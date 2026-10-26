(* AUTHORSHIP (release R2, 2026-09-07): part of the IntVolFLINT addition to MBSymbolicInt (G/HPL-to-hyperlogarithm conversion, finite-part mode). Author: Syed Mehedi Hasan; backends: HyperFLINT and HyperIntica (SubTropica; M. Giroux, S. Mizera, G. Salvatori, arXiv:2604.20954), HyperIntica being a native Mathematica reimplementation of E. Panzer's HyperInt (arXiv:1403.3385). *)
(* ivf_ext_finitepart_gconv.m — EXTENSION (prepared 2026-08-31, NOT loaded by production until the MB_standard campaign seal):
   (1) G/HPL-integrand conversion to HyperFLINT Hlog words; (2) finite-part mode for the IntVolIntegrate-level slot.
   Load AFTER ivf_machinery.m + ivf_dispatch_hook.m.  Switches: $IVFGConvert (default True here), $IVFFinitePartMode (default True here).
   Evidence base: finite_part_scheme_probe.log — on all 441 known divergent cubes IntVol's cutoff finite part == the fork's
   certificate-off shuffle-regularized value (the 4 "mismatches" were IntVol records off by exactly the prefactor). *)

(* ---------- (1) G / HPL -> Hlog ---------- *)
(* PolyLogTools G[a1,...,an, z] = int_0^z dt/(t-a1) G[a2..an; t]  ==  HyperInt/HyperFLINT Hlog[z, {a1,...,an}] (same letter order;
   consistency check: Li_n(z) = -G[0^(n-1),1; z] = -Hlog[z,{0,..,0,1}], the conversion already used for PolyLog). *)
ivfRationalInQ[e_, syms_List] := Module[{t = Together[e]}, PolynomialQ[Numerator[t], syms] && PolynomialQ[Denominator[t], syms] && FreeQ[e, Power[_, _Rational]]];
ivfGToHlog[e_, vars_List] := Module[{w = e, syms},
  syms = Join[vars, Global`ivfParametersOf[e, vars]];
  w = w /. HPL`HPL[word_List, x_] :> PolyLogTools`HPLToG[HPL`HPL[word, x]];
  w = w /. PolyLogTools`G[a__, z_] /; Length[DeleteDuplicates[{a}]] == 1 && First[{a}] =!= 0 && AllTrue[{a, z}, ivfRationalInQ[#, syms] &] :>
    Log[1 - z/First[{a}]]^Length[{a}]/Length[{a}]!;
  w = w /. PolyLogTools`G[a__, z_] /; ivfSafeWordQ[{a}] && AllTrue[{a, z}, ivfRationalInQ[#, syms] &] :> Global`Hlog[z, {a}];
  w];
(* letters contributed by Hlog words: (z - a_i) numerators and the denominators of a_i and z *)
ivfHlogLetterPolys[e_] := DeleteDuplicates@Flatten[Cases[e, Global`Hlog[z_, w_List] :>
  Join[Numerator[Together[z - #]] & /@ w, Denominator[Together[#]] & /@ Append[w, z]], {0, Infinity}]];
(* ivfPolyLogToHlog is applied by cubeIVF/ivfExactCube/ivfExactCubeBoth to every integrand: extend it to G/HPL.
   The variables are not known there, so use every non-constant symbol as a candidate polynomial variable. *)
If[!ValueQ[Global`$IVFGConvert], Global`$IVFGConvert = True];
(* copy DEFINITIONS, never alias the symbol (an alias resolves to the NEW definition -> infinite recursion) *)
If[DownValues[Global`ivfPolyLogToHlogOrig] === {},
  DownValues[Global`ivfPolyLogToHlogOrig] = DownValues[Global`ivfPolyLogToHlog] /. Global`ivfPolyLogToHlog -> Global`ivfPolyLogToHlogOrig];
Unprotect[Global`ivfPolyLogToHlog]; ClearAll[Global`ivfPolyLogToHlog];
Global`ivfPolyLogToHlog[e_] := Module[{w = e, syms},
  If[TrueQ[Global`$IVFGConvert] && !FreeQ[w, PolyLogTools`G | HPL`HPL],
    syms = DeleteDuplicates@Cases[w, s_Symbol /; Context[s] =!= "System`" && !MemberQ[Global`ivfAllowedConstants, s] :> s, {0, Infinity}];
    w = w /. HPL`HPL[word_List, x_] :> PolyLogTools`HPLToG[HPL`HPL[word, x]];
    (* the fork's Phase-3 Hlog INPUT path divides pure log-power words G[a,..,a; z] (a != 0) by an extra n!
       (probe ivf_hlog_repeated_probe.m): rewrite them EXACTLY as Log[1 - z/a]^n / n!, which HF parses as Log of a rational *)
    w = w /. PolyLogTools`G[a__, z_] /; Length[DeleteDuplicates[{a}]] == 1 && First[{a}] =!= 0 && AllTrue[{a, z}, ivfRationalInQ[#, syms] &] :>
      Log[1 - z/First[{a}]]^Length[{a}]/Length[{a}]!;
    w = w /. PolyLogTools`G[a__, z_] /; ivfSafeWordQ[{a}] && AllTrue[{a, z}, ivfRationalInQ[#, syms] &] :> Global`Hlog[z, {a}]];
  w /. PolyLog[n_Integer?Positive, z_] :> -Global`Hlog[z, Append[ConstantArray[0, n - 1], 1]]];
(* words with two ADJACENT equal non-zero letters (mixed, non-pure) stay unconverted until the exact-reference probe
   (ivf_hlog_repeated_probe2.m) clears them; trailing/leading zeros and distinct letters are verified *)
ivfSafeWordQ[w_List] := !AnyTrue[Range[Length[w] - 1], w[[#]] === w[[# + 1]] && w[[#]] =!= 0 &];
(* eligibility: accept G/HPL heads when the conversion removes them all and their letters obey the degree-<=2 rule *)
If[DownValues[Global`ivfEligibleCubeQOrig] === {},
  DownValues[Global`ivfEligibleCubeQOrig] = DownValues[Global`ivfEligibleCubeQ] /. Global`ivfEligibleCubeQ -> Global`ivfEligibleCubeQOrig];
ClearAll[Global`ivfEligibleCubeQ];
(* BOUNDED: the route hands IntVolIntegrate large G/HPL integrands (fibration output, thousands of leaves); an unbounded
   conversion + letter analysis here ran into the piece's own TimeConstrained (aborting the attempt with no log record) and
   the route closed the piece numerically (v4/v4b/v4c/regcfg MB9).  Cap by leaf count and by time; anything over -> ineligible. *)
If[!ValueQ[Global`$IVFGConvertMaxLC], Global`$IVFGConvertMaxLC = 4000];
If[!ValueQ[Global`$IVFGConvertSeconds], Global`$IVFGConvertSeconds = 5];
Global`ivfEligibleCubeQ[f_, vars_List] := Module[{g, letters, res, t0 = AbsoluteTime[]},
  If[FreeQ[f, PolyLogTools`G | HPL`HPL] || !TrueQ[Global`$IVFGConvert], Return[Global`ivfEligibleCubeQOrig[f, vars]]];
  (* evidence log: every G/HPL-integrand call that reaches the eligibility check (size, verdict, seconds) *)
  If[LeafCount[f] > Global`$IVFGConvertMaxLC,
    Quiet@Global`ivfLogLine[<|"Site" -> "g-eligibility", "Vars" -> vars, "LC" -> LeafCount[f], "IVF" -> "ineligible:G-too-large", "Seconds" -> 0.|>];
    Return[False]];
  res = Quiet@TimeConstrained[
    Module[{gg = ivfGToHlog[f, vars], ll},
      If[!FreeQ[gg, PolyLogTools`G | HPL`HPL], False,
        ll = ivfHlogLetterPolys[gg];
        If[!AllTrue[ll, Function[p, AllTrue[vars, Exponent[Expand[p], #] <= 2 &]]], False,
          TrueQ[Global`ivfEligibleCubeQOrig[gg /. Global`Hlog[z_, w_List] :> Log[z], vars]]]]],
    Global`$IVFGConvertSeconds, "timeout"];
  Quiet@Global`ivfLogLine[<|"Site" -> "g-eligibility", "Vars" -> vars, "LC" -> LeafCount[f],
    "IVF" -> If[res === "timeout", "ineligible:G-timeout", If[TrueQ[res], "eligible:G", "ineligible:G"]], "Seconds" -> Round[AbsoluteTime[] - t0, 0.01]|>];
  TrueQ[res]];

(* ---------- (1b) STRICT value contract for BOTH dispatcher slots ----------
   The sealed hook's ivfCleanValueQ tests FreeQ[_Real]; an inexact COMPLEX atom (e.g. 0.5 + 0.3 I from a projective-chart
   candidate under the chart race) passes it and then collapses a whole eps-order of the route to arbitrary precision
   (v4/v4b MB9: "the eps^-3 coefficient contains a floating-point number").  Copy the definition, then require exactness. *)
If[DownValues[Global`ivfCleanValueQOrig] === {},
  DownValues[Global`ivfCleanValueQOrig] = DownValues[Global`ivfCleanValueQ] /. Global`ivfCleanValueQ -> Global`ivfCleanValueQOrig];
ClearAll[Global`ivfCleanValueQ];
Global`$IVFInexactRefusals = 0;
Global`ivfCleanValueQ[v_] := Module[{ok},
  ok = TrueQ[Global`ivfCleanValueQOrig[v]] && FreeQ[v, x_ /; NumberQ[x] && Precision[x] =!= Infinity];
  If[!ok && TrueQ[Global`ivfCleanValueQOrig[v]], Global`$IVFInexactRefusals++;
    Quiet@Global`ivfLogLine[<|"Site" -> "contract", "IVF" -> "refused:inexact-value", "LC" -> LeafCount[v],
      "Value" -> If[Environment["IVF_LOG_FULL"] === "1", ToString[v, InputForm], None]|>]];
  ok];

(* ---------- (2) finite-part mode (IntVolIntegrate-level slot only; cohort sums stay with the dispatcher) ---------- *)
(* DEFAULT OFF (2026-08-31 13:25): exact for STANDALONE cubes (16/16 vs IntVol's finite parts) but UNSAFE inside the route's
   DIRECT-CUBE pieces, whose several divergent parts must share IntVol's etta scheme in the caller's order — the fork's
   regularized value is computed in its own (race-winning) order, the parts stop cancelling consistently, the piece fails the
   route's quadrature arbiter and is closed numerically (v4/v4b/v4c MB9).  Opt in with Global`$IVFFinitePartMode = True. *)
If[!ValueQ[Global`$IVFFinitePartMode], Global`$IVFFinitePartMode = False];
Global`$IVFFinitePartLog = {};
ivfFinitePart[expr_, vars_List, kin_Association] := Module[{f, t0 = AbsoluteTime[], v = $Failed, ps, w},
  f = If[Length[kin] > 0, expr /. Normal[kin], expr];
  ps = Global`ivfParametersOf[f, vars];
  (* NATIVE chart only: IntVol's finite part is defined in the [0,1] x-chart; the native Reg_0/Reg_1 convention is the one
     verified against it on 441 cubes (no projective race here) *)
  v = Quiet@CheckAbort[TimeConstrained[Global`ivfExactCube[f, vars, Global`$ivfSeconds, "Regularized" -> True], Global`$ivfSeconds + 60, $Failed], $Failed];
  If[!FreeQ[v, Global`ivfExactCube | Global`ivfExactCubeBoth] || v === $Aborted, v = $Failed];
  (* SILENT-ZERO GUARD (v4c MB9): the fork's certificate-off run can return exactly 0 for a divergent cube whose finite part is
     not 0 (24 such 4-fold cubes in MB9); IntVol's own retry loop rejects "symbolic 0 vs MC" — so must this path.  A zero is
     never served here; the cube goes to IntVol as before. *)
  If[v =!= $Failed && TrueQ[Quiet[PossibleZeroQ[v]]], v = $Failed; Global`$IVFFinitePartZeroRefusals = Lookup[<|"n" -> 0|>, "n", 0] + If[ValueQ[Global`$IVFFinitePartZeroRefusals], Global`$IVFFinitePartZeroRefusals, 0] + 1;
    Quiet@Global`ivfLogLine[<|"Site" -> "intvol-finitepart", "Vars" -> vars, "LC" -> LeafCount[expr], "IVF" -> "refused:regularized-zero", "Seconds" -> Round[AbsoluteTime[] - t0, 0.01]|>]];
  (* strict exact-form contract: the hook's ivfCleanValueQ tests FreeQ[_Real], which an inexact COMPLEX atom passes —
     a served value with a float collapses a whole eps-order of the route to arbitrary precision (v4 MB9 failure) *)
  If[v =!= $Failed, w = Quiet@Global`ivfCanonicalValue[v];
    If[!FreeQ[w, x_ /; NumberQ[x] && Precision[x] =!= Infinity], v = $Failed,
      If[TrueQ[Quiet@Global`ivfCleanValueQ[w]] || (ps =!= {} && TrueQ[Quiet@Global`ivfCleanParametricQ[w, ps, Global`$ivfKinematicPoint]]), v = w, v = $Failed]]];
  Module[{rec = <|"Site" -> "intvol-finitepart", "Vars" -> vars, "LC" -> LeafCount[expr], "IVF" -> If[v === $Failed, "refused:finite-part", "served:regularized"], "Seconds" -> Round[AbsoluteTime[] - t0, 0.01]|>},
    If[Environment["IVF_LOG_FULL"] === "1", rec = Join[rec, <|"Integrand" -> ToString[expr, InputForm], "Value" -> If[v === $Failed, None, ToString[v, InputForm]]|>]];
    AppendTo[Global`$IVFFinitePartLog, rec]; Quiet@Global`ivfLogLine[rec]];
  v];
(* re-wrap IntVolIntegrate: exact attempt (existing hook) -> on a DIVERGENT refusal serve the finite part *)
If[DownValues[Global`IVFPrevIntVolIntegrate] =!= {} && DownValues[Global`IVFFinitePartPrev] === {},
  DownValues[Global`IVFFinitePartPrev] = DownValues[Global`IntVolIntegrate] /. Global`IntVolIntegrate -> Global`IVFFinitePartPrev;
  Options[Global`IVFFinitePartPrev] = Options[Global`IntVolIntegrate];
  Global`IntVolIntegrate[expr_, vars_List, opts : OptionsPattern[]] := Module[{r, kin, v, t1, r2, rec2},
    If[TrueQ[Global`$IVFFinitePartMode] && TrueQ[Global`$IVFUseIntVolFLINT] && TrueQ[Global`$IVFWrapIntVol] && Global`ivfPlainCubeQ[expr, vars, {opts}],
      kin = Lookup[Association[{opts}], "Kinematics", <||>]; If[!AssociationQ[kin], kin = <||>];
      Global`$ivfLastRefusals = {};
      (* exact first, through the sealed slot's own try (no double logging: reuse ivfTryCube directly) *)
      v = First@Global`ivfTryCube[expr, vars, "intvol", kin];
      (* strict exact-form contract on the exact path too (the sealed hook's FreeQ[_Real] misses inexact Complex atoms) *)
      If[v =!= $Failed && !FreeQ[v, x_ /; NumberQ[x] && Precision[x] =!= Infinity], v = $Failed];
      If[v =!= $Failed, Return[<|"Result" -> v, "LamRules" -> If[ListQ[Global`$ivfLastRootRules], Global`$ivfLastRootRules, {}],
        "Order" -> If[AssociationQ[Global`$ivfLastWinner], Global`$ivfLastWinner["Order"], vars], "Certified" -> True, "Kinematics" -> kin, "Engine" -> "IntVolFLINT"|>, Module]];
      If[TrueQ[Quiet@Global`ivfLastRefusalDivergentQ[]],
        v = ivfFinitePart[expr, vars, kin];
        If[v =!= $Failed, Return[<|"Result" -> v, "LamRules" -> {}, "Order" -> vars, "Certified" -> True, "Regularized" -> True,
          "Kinematics" -> kin, "Engine" -> "IntVolFLINT-regularized"|>, Module]]];
      (* NO DOUBLE ATTEMPT: IntVolFLINT already refused above — go straight to the ORIGINAL IntVol (IVFPrevIntVolIntegrate),
         not to the hook's wrapper, which would run the whole IntVolFLINT attempt again (v4c/regcfg MB9: every refused cube paid
         the refusal twice, pieces overran their budget and the route closed them NUMERICALLY -> inexact eps-order). *)
      t1 = AbsoluteTime[];
      r2 = Global`IVFPrevIntVolIntegrate[expr, vars, opts];
      rec2 = <|"Site" -> "intvol", "Vars" -> vars, "LC" -> LeafCount[expr],
        "IVF" -> "fallback:" <> If[AssociationQ[r2] && r2["Result"] =!= $Failed, "served", "failed"],
        "Suspect" -> If[AssociationQ[r2], Lookup[r2, "Suspect", None], None], "Seconds" -> Round[AbsoluteTime[] - t1, 0.01]|>;
      AppendTo[Global`$IVFIntVolLog, rec2]; Quiet@Global`ivfLogLine[rec2];
      Return[r2, Module]];   (* returns from THIS wrapper's Module: no second IntVolFLINT attempt via the hook wrapper *)
    Global`IVFFinitePartPrev[expr, vars, opts]];
  Print["[ivf-ext] finite-part mode + G-conversion installed (finite-part ", TrueQ[Global`$IVFFinitePartMode], ", G-convert ", TrueQ[Global`$IVFGConvert], ")"],
  Print["[ivf-ext] hook not present — extension NOT installed"]];
