(* AUTHORSHIP (release R2, 2026-09-07): part of the IntVolFLINT addition to MBSymbolicInt (the IntVolFLINT strategy slot of the cube dispatcher). Author: Syed Mehedi Hasan; backends: HyperFLINT and HyperIntica (SubTropica; M. Giroux, S. Mizera, G. Salvatori, arXiv:2604.20954), HyperIntica being a native Mathematica reimplementation of E. Panzer's HyperInt (arXiv:1403.3385). *)
(* ivf_dispatch_hook.m — the "IntVolFLINT" strategy slot WITHOUT editing the sealed dispatcher
   (mbe_strategy_dispatch_v2.m is pinned by STANDARD_ROUTE_DOCS_S101.sha256).  Load AFTER the dispatcher
   (load_standard_w10.m) — or, in a PieceKernels worker, after IntVol_stable.m — and after ivf_machinery.m.
   Default OFF: nothing changes until Global`$IVFUseIntVolFLINT = True.

   RULE (2026-08-30, "new dispatcher rule"):
     0. trivial cubes (no variables / provably zero) are left to the original chain;
     1. ELIGIBILITY (ivfEligibleCubeQ): constants-only [0,1]^n cube — no regulator or other free symbol, no
        Gamma/PolyGamma/G/HPL/hypergeometric heads, no inexact numbers, every irreducible letter factor of degree
        <= 2 in each integration variable.  Ineligible cubes never reach IntVolFLINT (log tag "ineligible");
     2. IntVolFLINT native, certificate ON, parallel order race (ivfExactCube).  Clean finish => served;
     3. refused by the DIVERGENCE certificate => tag "refused:divergent", the cube is appended to
        $IVFDivergentCohort (regularization is a cohort-wide decision made by the caller with
        ivfExactCube[..., "Regularized" -> True] — never here), then the original chain runs;
     4. any other refusal/timeout => tag "refused", original chain (HyperFLINT projective -> IntVol) unchanged.
   Every decision is appended to $IVFDispatchLog / $IVFIntVolLog and, when the environment variable
   IVF_LOG_DIR is set, to <IVF_LOG_DIR>/ivf_dispatch_<pid>.log (one InputForm association per line) so that
   PieceKernels worker processes leave a durable record.  Nothing sealed is touched. *)
If[!ValueQ[Global`$IVFUseIntVolFLINT], Global`$IVFUseIntVolFLINT = False];
If[!ValueQ[Global`$IVFWrapIntVol], Global`$IVFWrapIntVol = True];
If[!ValueQ[Global`$IVFValueContract], Global`$IVFValueContract = True];   (* False = pre-2026-08-30 behaviour (diagnostics only) *)
If[!ValueQ[Global`$IVFChartRace], Global`$IVFChartRace = True];   (* True = native + projective candidates in ONE race (2026-08-30) *)
If[!ValueQ[Global`$IVFAutoRationalize], Global`$IVFAutoRationalize = True];   (* 2026-08-31: Euler-rationalize non-LR cubes automatically (GPL cases); elliptic cubes exhaust and refuse *)
If[!ValueQ[Global`$IVFAcceptGinshForms], Global`$IVFAcceptGinshForms = False];   (* True: constants-only rationalized values may pass the contract via Ginsh (G-forms with algebraic letters); default off — the Standard route's closers need N[]-evaluable forms *)
Global`$IVFDispatchLog = {};
Global`$IVFIntVolLog = {};
Global`$IVFDivergentCohort = {};

(* ---- durable per-process log line ---- *)
ivfLogLine[rec_Association] := Module[{dir = Environment["IVF_LOG_DIR"], st},
  If[StringQ[dir] && dir =!= "",
    Quiet@Check[
      If[!DirectoryQ[dir], CreateDirectory[dir, CreateIntermediateDirectories -> True]];
      st = OpenAppend[FileNameJoin[{dir, "ivf_dispatch_" <> ToString[$ProcessID] <> ".log"}]];
      WriteString[st, ToString[Join[rec, <|"PID" -> $ProcessID, "Time" -> DateString[{"Hour", ":", "Minute", ":", "Second"}]|>], InputForm], "\n"]; Close[st], Null]]];

(* ---- (a) eligibility filter ---- *)
ivfAllowedConstants = {Pi, E, EulerGamma, Catalan, I, Glaisher, Khinchin};
ivfLetterFactorsOK[f_, vars_List] := Module[{args, polys, facs},
  (* letters = denominators and Log/PolyLog arguments; each irreducible factor must be a polynomial of degree
     <= 2 in every integration variable (HyperFLINT/IntVolFLINT scope: rational + quadratic letters) *)
  args = Join[Cases[f, Power[b_, n_?Negative] :> b, {0, Infinity}],
              Cases[f, (Log | PolyLog)[___, a_] :> a, {0, Infinity}]];
  polys = DeleteDuplicates@Flatten[Function[a, With[{t = Together[a]}, {Numerator[t], Denominator[t]}]] /@ args];
  polys = Select[polys, !FreeQ[#, Alternatives @@ vars] &];
  If[!AllTrue[polys, PolynomialQ[#, vars] &], Return[False]];
  facs = DeleteDuplicates@Flatten[(List @@ Replace[FactorList[#][[All, 1]], x_ :> x]) & /@ polys];
  AllTrue[facs, Function[fc, AllTrue[vars, Exponent[fc, #] <= 2 &]]]];
(* SYMBOLIC KINEMATICS (2026-08-30): with $IVFSymbolicKinematics = True a cube may carry free parameter symbols
   (kinematic invariants); they are handed to IntVolFLINT as coefficient variables and Wm/Wp letters may depend on
   them (fork flag spectator_algebraic_letters).  The parameter list is taken from the caller's "Kinematics" keys when
   given, else from the free symbols.  Regulator symbols are never parameters: names ep/eps/\[Epsilon] are refused. *)
If[!ValueQ[Global`$IVFSymbolicKinematics], Global`$IVFSymbolicKinematics = True];
ivfRegulatorSymbolQ[s_Symbol] := MemberQ[{"ep", "eps", "epsilon", "\[Epsilon]", "\[CurlyEpsilon]", "d", "D"}, SymbolName[s]];
ivfEligibleCubeQ[f_, vars_List] := Module[{syms, ps},
  If[vars === {}, Return[False]];
  If[!FreeQ[f, _Real], Return[False]];
  If[!FreeQ[f, Gamma | PolyGamma | PolyLogTools`G | HPL`HPL | Hypergeometric2F1 | HypergeometricPFQ | Zeta[_?(!NumericQ[#] &)] | LogGamma | Beta | Erf | ExpIntegralEi],
    Return[False]];
  syms = DeleteDuplicates@Cases[f, s_Symbol /; !MemberQ[ivfAllowedConstants, s] && Context[s] =!= "System`", {0, Infinity}, Heads -> False];
  ps = Complement[syms, vars];
  If[ps =!= {} && !(TrueQ[Global`$IVFSymbolicKinematics] && NoneTrue[ps, ivfRegulatorSymbolQ]), Return[False]];
  (* symbolic exponents (x^(-ep)-type) are never in scope *)
  If[!FreeQ[f, Power[_, e_ /; !FreeQ[e, Alternatives @@ Join[vars, ps]]]], Return[False]];
  (* on doubt (slow factorization) let the engine decide *)
  TrueQ[Quiet@Check[TimeConstrained[ivfLetterFactorsOK[f, vars], 20, True], True]]];

(* ---- value contract (2026-08-30, MB10 piece 46): the route's closers require a "clean number" — NumericQ under
   N[] (mbtCleanNumQ).  HF constants come back through gvExact as PolyLogTools G's (e.g. G[0,2]^4, depth-2 MPLs at
   1/2) which N[] cannot evaluate; a served value of that form made the whole piece fail (attempt cascade → LSR →
   "not a clean number").  Single-letter G's are exact logs and are rewritten (HoldPattern: PLT's G evaluates a
   bare G[0, z_] pattern — the evaluating-pattern trap); anything still non-numeric is REFUSED ("refused:form")
   and the original chain runs. *)
ivfCanonicalValue[v_] := Module[{w = v},
  w = w /. HoldPattern[PolyLogTools`G[0, z_]] /; NumericQ[z] :> Log[z];
  w = w /. HoldPattern[PolyLogTools`G[a_, z_]] /; NumericQ[a] && a =!= 0 && NumericQ[z] && NumericQ[1 - z/a] && (1 - z/a) =!= 0 :> Log[1 - z/a];
  w];
ivfCleanValueQ[v_] := FreeQ[v, _Real] && TrueQ[Quiet@NumericQ[N[v]]];
(* parametric value: must evaluate to a number at the kinematic point (the caller's, or a generic rational point).
   PolyLogTools G's with parameter arguments are not N[]-evaluable (Ginsh is the evaluator) — the race already
   computed exactly that number ($ivfLastRace["numeric"], via ivfNumericCheck at $ivfKinematicPoint); fall back to a
   fresh Ginsh evaluation if it is missing. *)
ivfCleanParametricQ[v_, ps_List, pt_] := Module[{rules, num},
  rules = If[ListQ[pt] && pt =!= {}, pt, Thread[ps -> Table[Rationalize[0.17 + 0.29 k, 10^-6], {k, Length[ps]}]]];
  num = Lookup[Global`$ivfLastRace, "numeric", $Failed];
  If[!NumericQ[num], num = Quiet@Check[N[PolyLogTools`Ginsh[IV$GinshSafe[v /. rules], {}]], $Failed]];
  FreeQ[v, _Real] && NumericQ[num]];

(* ---- the IntVolFLINT attempt shared by both slots ---- *)
ivfTryCube[f_, vars_List, site_String, kin_: <||>] := Module[{t0 = AbsoluteTime[], v = $Failed, tag, rec, raw, ps, pt, ratTag = None},
  Global`$ivfLastRootRules = {};
  If[!ivfEligibleCubeQ[f, vars],
    rec = <|"Site" -> site, "Vars" -> vars, "LC" -> LeafCount[f], "IVF" -> "ineligible", "Seconds" -> 0.|>;
    Return[{$Failed, rec}]];
  ps = Complement[DeleteDuplicates@Cases[f, s_Symbol /; !MemberQ[ivfAllowedConstants, s] && Context[s] =!= "System`", {0, Infinity}, Heads -> False], vars];
  pt = If[AssociationQ[kin] && Length[kin] > 0, Normal[kin], {}];
  Global`$ivfKinematicPoint = If[pt =!= {}, pt, Automatic];
  (* NOT Check[...]: a harmless message (e.g. the first-creation Symbol::shdw of a renamed variable) must not turn a
     correct value into a refusal — that is exactly what hid the piece-46 failure from the standalone reproducer *)
  v = Quiet@CheckAbort[If[TrueQ[Global`$IVFChartRace], Global`ivfExactCubeBoth[f, vars], Global`ivfExactCube[f, vars]], $Failed];
  If[!FreeQ[v, Global`ivfExactCube | Global`ivfExactCubeBoth] || v === $Aborted, v = $Failed];
  (* AUTO-RATIONALIZATION (2026-08-31): on a NON-divergent refusal whose reasons point at the quadratic-letter wall
     ("nonlinear factor" / no LR order found), try the exact Euler substitutions; if a candidate scans LR, race the
     TRANSFORMED cube (same value, GPLs).  Elliptic cubes exhaust their candidates and stay refused. *)
  ratTag = None;
  If[v === $Failed && TrueQ[Global`$IVFAutoRationalize] && !TrueQ[Quiet@Global`ivfLastRefusalDivergentQ[]] &&
     (Global`$ivfLastOrders === {} || AnyTrue[Global`$ivfLastRefusals, StringContainsQ[ToString[Lookup[#, "reason", ""]], "nonlinear factor"] &]),
    Module[{ps2, rat, rr},
      ps2 = Global`ivfParametersOf[f, vars];
      rat = Quiet@CheckAbort[Global`ivfRationalizeCube[f, vars, ps2], $Failed];
      If[AssociationQ[rat],
        rr = Lookup[rat, "RootRules", {}]; Global`$ivfLastRootRules = rr;
        (* the numeric point must know the adjoined roots (exact Sqrt at a rational point — Ginsh handles it) *)
        If[rr =!= {} && ListQ[Global`$ivfKinematicPoint], Global`$ivfKinematicPoint = Join[Global`$ivfKinematicPoint, rr /. Rule[r_, d_] :> Rule[r, d /. Global`$ivfKinematicPoint]]];
        v = Quiet@CheckAbort[Global`ivfExactCube[rat["Integrand"], rat["Vars"], $ivfSeconds, "Parameters" -> Join[ps2, rr[[All, 1]]]], $Failed];
        If[!FreeQ[v, Global`ivfExactCube], v = $Failed];
        If[v =!= $Failed && rr =!= {}, v = v];   (* value stays symbolic in the root; definition served via LamRules *)
        ratTag = If[v =!= $Failed, "served:rationalized", "refused:rationalized-still-hard"],
        If[rat === $Failed, ratTag = "refused:nonrationalizable"]]],
    Global`$ivfLastRootRules = {}];
  raw = v;
  If[v =!= $Failed && TrueQ[Global`$IVFValueContract],
    v = Quiet@Check[ivfCanonicalValue[v], v];
    If[!If[ps === {} && Global`$ivfLastRootRules === {},
        ivfCleanValueQ[v] || (TrueQ[Global`$IVFAcceptGinshForms] && ratTag === "served:rationalized" && FreeQ[v, _Real] && NumericQ[Quiet@N[PolyLogTools`Ginsh[IV$GinshSafe[v], {}]]]),
        ivfCleanParametricQ[v, Join[ps, Global`$ivfLastRootRules[[All, 1]]], pt]], v = $Failed]];
  tag = Which[v =!= $Failed && ratTag === "served:rationalized", "served:rationalized",
    v =!= $Failed, "served",
    raw =!= $Failed, "refused:form",
    StringQ[ratTag], ratTag,
    TrueQ[Quiet@Global`ivfLastRefusalDivergentQ[]], "refused:divergent",
    True, "refused"];
  If[tag === "refused:divergent",
    AppendTo[Global`$IVFDivergentCohort, <|"Site" -> site, "Vars" -> vars, "LC" -> LeafCount[f], "Hash" -> Hash[{f, vars}],
      "Reason" -> If[Global`$ivfLastRefusals === {}, "", First[Global`$ivfLastRefusals]["reason"]]|>]];
  rec = <|"Site" -> site, "Vars" -> vars, "LC" -> LeafCount[f], "IVF" -> tag, "Seconds" -> Round[AbsoluteTime[] - t0, 0.01],
    "Parameters" -> ps,
    "Winner" -> If[v =!= $Failed && AssociationQ[Global`$ivfLastWinner], Global`$ivfLastWinner["Order"], None],
    "Chart" -> If[v =!= $Failed && AssociationQ[Global`$ivfLastWinner], Lookup[Global`$ivfLastWinner, "Chart", "Unit"], None]|>;
  (* diagnostics: with IVF_LOG_FULL=1 the record also carries the integrand, the served value and the refusal reasons *)
  If[Environment["IVF_LOG_FULL"] === "1",
    rec = Join[rec, <|"Integrand" -> ToString[f, InputForm], "Value" -> If[v === $Failed, None, ToString[v, InputForm]],
      "RawForm" -> If[tag === "refused:form", ToString[Short[raw, 6], InputForm], None],
      "Race" -> If[raw === $Failed, ToString[Short[KeyDrop[Global`$ivfLastRace, {"val", "refusals"}], 8], InputForm], None],
      "Reasons" -> If[v === $Failed, (StringTake[ToString[#["reason"]], UpTo[160]] & /@ Global`$ivfLastRefusals), {}],
      "Orders" -> Global`$ivfLastOrders|>]];
  {v, rec}];

(* ---- slot 1: dispatcher cubes (only where the dispatcher is loaded, i.e. the master kernel) ---- *)
If[DownValues[MBEStrategy`Private`mbeIntegrateCube] =!= {},
  If[DownValues[Global`IVFOrigIntegrateCube] === {},
    DownValues[Global`IVFOrigIntegrateCube] =
      DownValues[MBEStrategy`Private`mbeIntegrateCube] /. MBEStrategy`Private`mbeIntegrateCube -> Global`IVFOrigIntegrateCube];
  MBEStrategy`Private`mbeIntegrateCube[integrand_, variables_List] := Module[{t0 = AbsoluteTime[], v = $Failed, r, rec},
    If[TrueQ[Global`$IVFUseIntVolFLINT] && variables =!= {} &&
       !TrueQ[Quiet@MBEStrategy`Private`mbeProvedZeroQ[integrand]],
      {v, rec} = ivfTryCube[integrand, variables, "dispatch"];
      If[v =!= $Failed && !TrueQ[MBEStrategy`Private`mbeExactQ[v, variables]], v = $Failed; rec["IVF"] = "refused:inexact"];
      AppendTo[Global`$IVFDispatchLog, rec]; ivfLogLine[rec];
      If[v =!= $Failed, Return[v, Module]]];
    r = Global`IVFOrigIntegrateCube[integrand, variables];
    If[TrueQ[Global`$IVFUseIntVolFLINT],
      rec = <|"Site" -> "dispatch", "Vars" -> variables, "LC" -> LeafCount[integrand],
        "IVF" -> "fallback:" <> If[r === $Failed, "failed", "served"], "Seconds" -> Round[AbsoluteTime[] - t0, 0.01]|>;
      AppendTo[Global`$IVFDispatchLog, rec]; ivfLogLine[rec]];
    r];
  Print["[ivf-dispatch] IntVolFLINT strategy hook installed (ON = ", TrueQ[Global`$IVFUseIntVolFLINT], ")"],
  Print["[ivf-dispatch] dispatcher not loaded in this kernel — mbeIntegrateCube slot skipped (IntVolIntegrate slot only)"]];

(* ---- slot 1b: the dispatcher's HyperFLINT projective slot gets the ORDER RACE (2026-08-30) ----
   mbeHFExactCube (sealed) = prepare (map to [0,Infinity)) -> one LR order -> one HyperFLINT run.  Here the same
   prepared cube is raced over LR-scan (score-minimal + carry_discharge), natural and reversed orders with the
   sealed slot's binary/env/request; acceptance identical (literal 0 or non-exact => $Failed).  The sealed LR order
   is one of the candidates, so no second single-order run is needed on refusal ($IVFProjectiveRace = False
   restores the sealed behaviour exactly). *)
If[!ValueQ[Global`$IVFProjectiveRace], Global`$IVFProjectiveRace = True];
If[DownValues[MBEStrategy`Private`mbeHFExactCube] =!= {},
  If[DownValues[Global`IVFOrigHFExactCube] === {},
    DownValues[Global`IVFOrigHFExactCube] =
      DownValues[MBEStrategy`Private`mbeHFExactCube] /. MBEStrategy`Private`mbeHFExactCube -> Global`IVFOrigHFExactCube];
  MBEStrategy`Private`mbeHFExactCube[integrand_, variables_List, timeout_Integer] := Module[{t0 = AbsoluteTime[], prepared, orders, v, rec},
    If[!(TrueQ[Global`$IVFUseIntVolFLINT] && TrueQ[Global`$IVFProjectiveRace]),
      Return[Global`IVFOrigHFExactCube[integrand, variables, timeout]]];
    If[variables === {}, Return[If[MBEStrategy`Private`mbeExactQ[integrand], integrand, $Failed]]];
    If[MBEStrategy`Private`mbeProvedZeroQ[integrand], Return[0]];
    prepared = MBEStrategy`Private`mbePrepareCube[integrand, variables];
    If[!AssociationQ[prepared], Return[$Failed]];
    orders = Quiet@Check[Global`ivfProjCandidates[prepared, timeout], {}];
    v = Quiet@CheckAbort[Global`ivfProjectiveExactCube[prepared, orders, timeout], $Failed];
    If[!FreeQ[v, Global`ivfProjectiveExactCube] || v === $Aborted, v = $Failed];
    If[v =!= $Failed && TrueQ[Global`$IVFValueContract],
      v = Quiet@Check[ivfCanonicalValue[v], v]; If[!ivfCleanValueQ[v], v = $Failed]];
    rec = <|"Site" -> "hf-projective", "Vars" -> variables, "LC" -> LeafCount[integrand],
      "IVF" -> If[v =!= $Failed, "served:projective", If[TrueQ[Quiet@Global`ivfLastRefusalDivergentQ[]], "refused:divergent", "refused"]],
      "Seconds" -> Round[AbsoluteTime[] - t0, 0.01], "Orders" -> Length[orders],
      "Winner" -> If[v =!= $Failed && AssociationQ[Global`$ivfLastWinner], Global`$ivfLastWinner["Order"], None]|>;
    AppendTo[Global`$IVFDispatchLog, rec]; ivfLogLine[rec];
    v];
  Print["[ivf-dispatch] projective order race installed on mbeHFExactCube (ON = ", TrueQ[Global`$IVFProjectiveRace], ")"]];

(* ---- slot 2: plain IntVolIntegrate calls (closers call IntVol directly; also inside PieceKernels workers) ---- *)
ivfPlainCubeQ[expr_, vars_List, opts_List] := Module[{kin},
  kin = Lookup[Association[opts], "Kinematics", <||>];
  If[AssociationQ[kin] && Length[kin] > 0 && !TrueQ[Global`$IVFSymbolicKinematics], Return[False]];
  If[Lookup[Association[opts], "ParametricValues", Automatic] =!= Automatic, Return[False]];
  If[KeyExistsQ[Association[opts], "IntegrationOrder"] && Lookup[Association[opts], "IntegrationOrder"] =!= Automatic, Return[False]];
  vars =!= {}];
If[DownValues[Global`IntVolIntegrate] =!= {} && DownValues[Global`IVFPrevIntVolIntegrate] === {},
  DownValues[Global`IVFPrevIntVolIntegrate] =
    DownValues[Global`IntVolIntegrate] /. Global`IntVolIntegrate -> Global`IVFPrevIntVolIntegrate;
  Options[Global`IVFPrevIntVolIntegrate] = Options[Global`IntVolIntegrate];
  Global`IntVolIntegrate[expr_, vars_List, opts : OptionsPattern[]] := Module[{t0 = AbsoluteTime[], v = $Failed, r, rec, kin},
    If[TrueQ[Global`$IVFUseIntVolFLINT] && TrueQ[Global`$IVFWrapIntVol] && ivfPlainCubeQ[expr, vars, {opts}],
      kin = Lookup[Association[{opts}], "Kinematics", <||>]; If[!AssociationQ[kin], kin = <||>];
      {v, rec} = ivfTryCube[expr, vars, "intvol", kin];
      AppendTo[Global`$IVFIntVolLog, rec]; ivfLogLine[rec];
      (* Return[..., Module] must target THIS Module: an inner Module here made the served value fall through to IntVol *)
      If[v =!= $Failed,
        Return[<|"Result" -> v, "LamRules" -> If[ListQ[Global`$ivfLastRootRules], Global`$ivfLastRootRules, {}], "Order" -> If[AssociationQ[Global`$ivfLastWinner], Global`$ivfLastWinner["Order"], vars],
          "Certified" -> True, "Kinematics" -> kin, "Engine" -> "IntVolFLINT"|>, Module]]];
    r = Global`IVFPrevIntVolIntegrate[expr, vars, opts];
    If[TrueQ[Global`$IVFUseIntVolFLINT] && TrueQ[Global`$IVFWrapIntVol],
      rec = <|"Site" -> "intvol", "Vars" -> vars, "LC" -> LeafCount[expr],
        "IVF" -> "fallback:" <> If[AssociationQ[r] && r["Result"] =!= $Failed, "served", "failed"],
        "Suspect" -> If[AssociationQ[r], Lookup[r, "Suspect", None], None],
        "Seconds" -> Round[AbsoluteTime[] - t0, 0.01]|>;
      AppendTo[Global`$IVFIntVolLog, rec]; ivfLogLine[rec]];
    r]];
Print["[ivf-dispatch] IntVolIntegrate-level slot installed (wrap = ", TrueQ[Global`$IVFWrapIntVol], ")"];
