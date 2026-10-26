(* ::Package:: *)

(* ================================================================
   IntVol \[LongDash] Volume integration over [0,1]^n
   A robust integration engine for parametric/Euler integrals.

   Package Author:  Syed Mehedi Hasan  <syed-mehedi.hasan@ur.de>

   PolyLogTools-based pipeline:
     ToFibrationBasis + GIntegrate + lambda substitution + DG resolution,
   with order-rotation failsafe: if the auto-picked order fails, the engine
   rotates through alternative permutations within a per-order timeout until
   one succeeds. A Mathematica-framework canonical recipe is used as a last-
   resort fallback when the standard PLT path produces silent zeros, frozen
   CiTi terms, or numerically wrong results.

   Includes:
     - Log-first order picker + log-first retry biasing
     - Silent-zero rejection (numeric sanity vs MC reference)
     - Euclidean partial-fraction fast path (IV$EuclideanApart)
     - Big-expression helpers (GatherByDependency, MakeCoefficientsSymbolic)
     - Lambda factorization (IV$ApplyLambdas) for quadratic-in-var denominators
     - Manual partial fraction (IV$ManualApart) for Apart-blowup cases
     - Lambda-shift trick (IntVolLambdaShift) for D^k denominators
     - Term-by-term GIntegrate with DG resolution + Li1 fallback
     - MMA-framework auto-fallback (IV$MMAIntegrate) with HPL-aware boundary
       handling (ToFib+ShuffleRegulate) and \[Lambda]-factorization-before-Fib at the
       last variable, plus candidate-order retry varying the last var.

   Toggles (default behaviour preserves the regression):
     $IV$UseEuclidean              \[LongDash] True: try Euclidean Apart before MMA Apart (default True)
     $IV$DumpFailedTerms           \[LongDash] True: bank partial-DG proof data (default False)
     $IV$CanonicalizeAfterEachStep \[LongDash] True: apply Collect[#, _G, Simplify] & after every step (default True)
     $IV$CanonicalizeMaxLC         \[LongDash] LC threshold above which canonicalization is skipped (default 50000)
     $IV$CanonicalizeTimeConstraint \[LongDash] TimeConstrained limit for canonicalization (default 60s)
     $IV$MMAFallback               \[LongDash] True: engage MMA framework when standard path fails (default True)
     $IV$MMAGIntegrateTimeout      \[LongDash] Last-var GIntegrate timeout in MMA fallback (default 14400 s)
     $IV$MMAIntegrateTimeout       \[LongDash] Per-var Integrate timeout in MMA fallback (default 600 s)
     $IV$MMASimplifyTimeout        \[LongDash] Final Simplify timeout in MMA fallback (default 1800 s)

   REQUIRES: PolyLogTools loaded before this package.
   ================================================================ *)

(* Load big-expression helpers (IV$EuclideanApart, IV$MakeCoefficientsSymbolic,
   IV$GatherByDependency). Adapted from Fek\[EAcute]sh\[AAcute]zy's How_to_handle_big_expressions
   package. Expected to live in the same directory as this file. *)
Get[FileNameJoin[{DirectoryName[$InputFileName], "IntVol_BigExpr_Helpers.m"}]];

(* Exact endpoint backend.  These modules are source-only and fail closed:
   endpoint ODEs are followed by one proof record for every detected wall. *)
If[! ValueQ[$IV$ExactEndpointBackend], $IV$ExactEndpointBackend = True];
IV$ExactEndpointBackendFiles = FileNameJoin[
    {DirectoryName[$InputFileName], #}] & /@ {
      "intvol_endpoint_ode_prototype.m",
      "intvol_wall_variation_prototype.m",
      "intvol_interior_wall_ode_prototype.m",
      "intvol_w2_gauge_lowering_prototype.m",
      "intvol_exact_endpoint_dispatch_prototype.m"};
$IV$ExactEndpointBackendLoaded =
  AllTrue[IV$ExactEndpointBackendFiles, FileExistsQ];
If[TrueQ[$IV$ExactEndpointBackendLoaded],
  Scan[Get, IV$ExactEndpointBackendFiles]];

(* ================================================================
   DECLARED KINEMATICS  (2026-07-12)

   WHY THIS EXISTS.  A fibration identity is valid only in the region that
   contains the point it was derived at.  The engine used to INVENT its own
   fit point ($IV$AutoFitVals below) and then the caller evaluated/certified
   the resulting GPLs somewhere else entirely — crossing branch cuts and
   silently picking up spurious i-Pi.  Measured on the ep0 cof6 piece:
   fit-point != evaluation-point gave the exact real part but Im = -50.37;
   fibrating AT the evaluation point gives Im ~ 1e-14.  The same mismatch
   explains the cof10 block: the invented fit (u11=0.4, u12=0.2) puts the
   letter u12/u11 at 0.5 — a letter zero sitting INSIDE the integration path,
   and exactly on x2's own fit value — while the user's kinematics
   (u11=0.5, u12=0.6) put it at 1.2, safely outside.

   THE RULE: FIBRATE WHERE YOU EVALUATE.  The user knows the physics — for the
   angular integrals of arXiv:2508.15952 / 2410.18886 the variables are
   v_kl = p_k.p_l/2 (k!=l), v_kk = p_k^2/4, with v in (0,1) and the physical
   scattering region v_ii in [0,1/4], v_ij in [0,1/2] — so the user declares
   the point (and optionally the region) ONCE, and it drives the fibration fit
   values, the certification, and the library record.

     IVSetKinematics[{v12 -> 0.11, ...}]   declare the working point
     IVSetKinematicRegion[<|v12 -> {0, 1/2}, v11 -> {0, 1/4}|>]  (optional)
     IVKinematics[]                        what is currently declared
     IVClearKinematics[]                   back to invented values
     IVLetterZeroAudit[expr, x, kin]       do any letters vanish in [0,1]?
   Per-call override: IntVolIntegrate[..., "Kinematics" -> {...}].
   ================================================================ *)
If[!ValueQ[$IV$Kinematics],       $IV$Kinematics = <||>];
If[!ValueQ[$IV$KinematicRegion],  $IV$KinematicRegion = <||>];
If[!ValueQ[$IV$WarnInventedFits], $IV$WarnInventedFits = True];
If[!ValueQ[$IV$FailedBoundaryDumpFile],
  $IV$FailedBoundaryDumpFile = FileNameJoin[{$TemporaryDirectory, "intvol_failed_boundary.m"}]];
(* Optional observer for source-only diagnostics.  The default is a no-op and
   the hook cannot affect a solve: failures, aborts, and timeouts are ignored. *)
If[!ValueQ[$IV$StepTraceHook], $IV$StepTraceHook = (Null &)];
IV$CallStepTrace[record_] := Quiet@CheckAbort[
  TimeConstrained[$IV$StepTraceHook[record], 30, Null], Null];
If[!ValueQ[$IV$DirectTermsBankFile], $IV$DirectTermsBankFile = None];
IV$BankDirectTerms[record_Association] := Module[
  {file = $IV$DirectTermsBankFile, temporary, result},
  If[! StringQ[file] || StringLength[file] === 0,
    Return["NotRequested"]];
  temporary = file <> ".tmp-" <> ToString[$ProcessID] <> ".mx";
  result = Quiet@CheckAbort[Check[
    Global`IV$DirectTermsBankRecord = record;
    If[FileExistsQ[temporary], DeleteFile[temporary]];
    DumpSave[temporary, {Global`IV$DirectTermsBankRecord}];
    If[! FileExistsQ[temporary], Return[False, Module]];
    If[FileExistsQ[file], DeleteFile[file]];
    RenameFile[temporary, file];
    True, False], False];
  result]

IVSetKinematics[rules_] := ($IV$Kinematics =
   Switch[rules, _Association, rules, _List, Association @@ rules, _, <||>];
  $IV$Kinematics);
IVSetKinematicRegion[reg_Association] := ($IV$KinematicRegion = reg);
IVKinematics[] := $IV$Kinematics;
IVClearKinematics[] := ($IV$Kinematics = <||>; $IV$KinematicRegion = <||>;);

(* Is the declared point inside the declared region?  (Advisory, not fatal:
   the (0,1) parameterisation region is wider than the physical one, and
   results are analytically continued between them.) *)
IVKinematicsInRegionQ[] := Module[{k = $IV$Kinematics, r = $IV$KinematicRegion},
  If[r === <||> || k === <||>, Return[True]];
  AllTrue[Keys[r], Function[v,
    !KeyExistsQ[k, v] ||
     (NumericQ[k[v]] && r[v][[1]] <= k[v] <= r[v][[2]])]]];

(* LETTER-ZERO AUDIT.  After fibrating in x, every GPL letter is a function of
   the kinematics; the identity is valid along [0,1] only if no letter vanishes
   inside it.  Returns the offending letters (empty list = the path is clean). *)
IV$LettersOf[e_, x_] := DeleteDuplicates@Cases[e,
  g_G /; !FreeQ[g, x] :> Most[List @@ g], {0, Infinity}] // Flatten;
IVLetterZeroAudit[e_, x_, kin_: Automatic] := Module[
  {k = If[kin === Automatic, $IV$Kinematics, Association @@ kin], lets, bad},
  lets = DeleteDuplicates@Select[IV$LettersOf[e, x], FreeQ[#, x] &];
  bad = Select[lets, Function[a, Module[{v = Quiet@N[a /. Normal[k]]},
    NumericQ[v] && Im[v] == 0 && 0 <= Re[v] <= 1]]];
  bad];

(* ================================================================
   KNOWLEDGE-LIBRARY HOOKS  (2026-07-11)

   The library (IntVolLibrary.m + its data file) is a PURE ACCELERATOR and is
   OPTIONAL in every sense: the engine never loads it, never requires it, and
   behaves identically when it is absent.  These three hooks are NO-OPS by
   default; IntVolLibrary.m overrides them when (and only when) it is loaded.

   Invariants that must never be broken:
     * no library file  ->  identical behavior, zero cost (a no-op call);
     * a library fault   ->  cannot break a solve (every call is guarded and a
       non-conforming return is discarded);
     * the library may only supply things that are CHECKED downstream — a
       stored result (certified when stored) or an integration order (any
       valid order yields the same integral, and a failing one falls back to
       the normal search).
   ================================================================ *)
If[!ValueQ[$IV$UseLibrary],   $IV$UseLibrary = True];    (* master switch *)
If[!ValueQ[$IV$LibLookup],    $IV$LibLookup = (None &)]; (* {expr,vars} -> certified record | None *)
If[!ValueQ[$IV$LibOrders],    $IV$LibOrders = ({} &)];   (* {expr,vars} -> {order, ...} *)
If[!ValueQ[$IV$LibRecord],    $IV$LibRecord = (Null &)]; (* trace assoc -> Null *)
(* SPECIAL-INSTRUCTIONS hook (2026-07-13):  {expr,vars} -> <|"FTNonlinear"->True,...|> | <||>
   The ENGINE stays general and fast and must not pay, on every integral, for
   machinery that only a special case needs (the DG reconstruction tier costs
   60-300 s per G).  So a LIBRARY record may carry ENGINE SETTINGS for its SHAPE,
   and IntVolIntegrate re-enters the solve ONCE with exactly those settings
   Block'd in.  Keyed by SHAPE, not by point: a ROUTE is universal, only a RESULT
   is point-specific.
   PURELY ADDITIVE: with no library, or no record carrying Settings for this
   shape, the hook returns <||> and nothing whatsoever changes. *)
If[!ValueQ[$IV$LibSettings], $IV$LibSettings = (<||> &)];
$IV$LibSettingsApplied = False;   (* one-shot re-entry guard *)
If[!ValueQ[$IV$LibOrderCap],  $IV$LibOrderCap = 300];    (* s per learned-order attempt *)
If[!ValueQ[$IV$LibOrderTries],$IV$LibOrderTries = 3];
$IV$StepTimes = {};

(* Guarded hook call: a faulty library must be INVISIBLE, not fatal.
   Catch[] (not Check[]) — Check also fires on quieted benign messages and
   would silently disable the library; Catch is what actually stops a library
   exception from escaping into the solve.  Malformed returns are rejected by
   the call site, which checks the shape it expects.
   NB the DOUBLE Catch: Catch[e, form, f] only intercepts TAGGED throws, so an
   untagged Throw[x] from a broken library would escape to top level (it did).
   The inner bare Catch[] mops those up; whatever it hands back is then just a
   malformed return, which the call site discards. *)
IV$LibCall[f_, arg_, dflt_] := If[!TrueQ[$IV$UseLibrary], dflt,
  Module[{r},
    r = Quiet@Catch[Catch[TimeConstrained[f[arg], 120, dflt]], _, (dflt) &];
    If[Head[r] === TimeConstrained || r === $Aborted || r === $Failed, dflt, r]]];

(* Toggle: set to False to disable Euclidean fast-path (revert to MMA Apart only).
   Useful for A/B testing or as kill-switch if Euclidean changes break a case. *)
If[!ValueQ[$IV$UseEuclidean], $IV$UseEuclidean = True];

(* Diagnostic toggle: when True and verbose, atomically banks the post-DG
   failure together with every verified partial antiderivative. Default off. *)
If[!ValueQ[$IV$DumpFailedTerms], $IV$DumpFailedTerms = False];

(* Keep exact additive atoms separate in the large-expression fallback.
   Collect[..., Together] can collapse hundreds of independently integrable
   atoms into a handful of multi-thousand-leaf GPL coefficients, defeating
   the purpose of termwise dispatch.  The aggregate source and derivative
   gates below still certify the recombined result. *)
If[!ValueQ[$IV$PreserveLargeAddends], $IV$PreserveLargeAddends = True];
If[!ValueQ[$IV$BatchRepeatedW1Sources], $IV$BatchRepeatedW1Sources = True];
If[!ValueQ[$IV$W1BatchCoefficientLeafLimit],
  $IV$W1BatchCoefficientLeafLimit = 1400];

(* Canonicalization after each integration step: applies
     cur // Collect[#, _G, Simplify] &
   to the post-boundary result of every step. This is the user's standard
   refinement pattern that makes spurious I*Pi cancellations and other
   algebraic identities surface, giving cleaner symbolic answers.
   Gated by an LC threshold to avoid Simplify hangs on huge expressions.
   Defaults: ON, with a 50K-LC safety threshold. *)
If[!ValueQ[$IV$CanonicalizeAfterEachStep], $IV$CanonicalizeAfterEachStep = True];
If[!ValueQ[$IV$CanonicalizeMaxLC], $IV$CanonicalizeMaxLC = 50000];
If[!ValueQ[$IV$CanonicalizeTimeConstraint], $IV$CanonicalizeTimeConstraint = 60];

(* MMA-framework last-resort fallback (user's BC[19] manual recipe).
   Triggered automatically after IntVolIntegrate's standard path produces
   numerically wrong result (silent zero, large Im, mismatch vs MC). *)
If[!ValueQ[$IV$MMAFallback], $IV$MMAFallback = True];
If[!ValueQ[$IV$MMAGIntegrateTimeout], $IV$MMAGIntegrateTimeout = 14400];
If[!ValueQ[$IV$MMAIntegrateTimeout], $IV$MMAIntegrateTimeout = 600];
If[!ValueQ[$IV$MMASimplifyTimeout], $IV$MMASimplifyTimeout = 1800];

(* ============================================================ *)
(* SECTION 1: LINEAR REDUCIBILITY ENGINE                        *)
(* ============================================================ *)

(* Exact algebraic constants belong to the coefficient field, not to the
   polynomial alphabet.  Mathematica's default FactorList works only over Q;
   after a certified genus-zero change of variables this can reassemble two
   Q(alpha)-linear factors into a spurious quadratic.  Extract the explicit
   algebraic generators and factor over their number field. *)
IV$ExplicitAlgebraicGeneratorQ[p_] := NumericQ[p] && FreeQ[p, _Real] &&
  (Head[p] === AlgebraicNumber || Head[p] === Root ||
    MatchQ[p, HoldPattern[Power[_, exponent_Rational]] /;
      Denominator[exponent] > 1]);

IV$AlgebraicExtensions[expr_] := DeleteDuplicates@Cases[expr,
  p_ /; IV$ExplicitAlgebraicGeneratorQ[p] :> p, Infinity];

IV$FactorListExact[poly_] := Module[{extensions, factored},
  extensions = IV$AlgebraicExtensions[poly];
  If[extensions === {}, Return[FactorList[poly]]];
  factored = Quiet@Check[
    FactorList[poly, Extension -> extensions], $Failed];
  If[factored === $Failed, FactorList[poly], factored]];

IV$IsMonomialQ[expr_, vars_List] := Head[Expand[expr]] =!= Plus

IV$IsRelevantQ[expr_, vars_List] := Module[{e = Expand[expr]},
  PolynomialQ[e, vars] && !NumericQ[e] && !MatchQ[e, 0|1|-1] && !IV$IsMonomialQ[e, vars]
]

IV$IrrFactors[poly_, vars_List] := Module[{fl},
  fl = IV$FactorListExact[poly];
  Select[Expand /@ (First /@ fl), IV$IsRelevantQ[#, vars]&]
]

IV$ExtractS0[expr_, vars_List] := Module[{terms, denoms, logArgs, candidates},
  terms = If[Head[Expand[expr]] === Plus, List @@ Expand[expr], {expr}];
  denoms = DeleteCases[Union[Denominator[Together[#]]& /@ terms],
    x_ /; (x === 0 || x === 1 || NumericQ[x])];
  logArgs = Join[Cases[expr, Log[a_] :> a, Infinity],
    Cases[expr, G[a__] :> Sequence @@ Most[{a}], Infinity]];
  logArgs = DeleteCases[logArgs, x_ /; NumericQ[x]];
  candidates = Union[denoms, logArgs];
  Select[Union[Flatten[IV$IrrFactors[#, vars]& /@ candidates]],
    !NumericQ[#] && !FreeQ[#, Alternatives @@ vars]&]
]

IV$NextS[IVPolySet_List, xa_, allVars_List] := Module[{remVars, QR, crossTerms, allTerms},
  remVars = DeleteCases[allVars, xa];
  QR = Table[{Coefficient[p, xa], (p /. xa -> 0)}, {p, IVPolySet}];
  crossTerms = Flatten[Table[
    QR[[i,1]]*QR[[j,2]] - QR[[j,1]]*QR[[i,2]], {i, Length[IVPolySet]}, {j, i+1, Length[IVPolySet]}]];
  allTerms = DeleteCases[Join[QR[[All,1]], QR[[All,2]], crossTerms], 0];
  Select[Union[Flatten[IV$IrrFactors[#, remVars]& /@ allTerms]],
    !NumericQ[#] && !FreeQ[#, Alternatives @@ remVars]&]
]

(* Linear reducibility check.
   Accepts polynomials of degree 1 (trivially linear) AND degree 2 (always factor
   via lambda: Q(t) = a*(t+lamA)*(t+lamB) where lamA,B = (-b\[PlusMinus]Sqrt[b^2-4ac])/(2a)).
   After lambda factorization, degree-2 polynomials become products of linear
   factors over the algebraic extension Q(Sqrt[disc]). This is part of the
   standard HyperInt machinery (Brown, Panzer). Degree-3+ polynomials may or
   may not factor and need explicit factorization check (not implemented). *)
IV$MaxAcceptableDegreeForLambda = 2;

IV$TryOrder[S0_List, order_List, allVars_List] := Module[
  {IVPolySet = S0, ok = True, sizes = {}, sets = {S0}},
  Do[If[Max[Exponent[#, order[[i]]]& /@ IVPolySet] > IV$MaxAcceptableDegreeForLambda,
        ok = False; Break[]];
    IVPolySet = IV$NextS[IVPolySet, order[[i]], allVars]; AppendTo[sizes, Length[IVPolySet]]; AppendTo[sets, IVPolySet];
  , {i, Length[order]}]; {ok, sets, sizes}
]

IV$IsRationalOnlyQ[expr_, var_] := Module[{transcArgs},
  transcArgs = Cases[expr, (Log|G|PolyLog|PolyGamma)[args___] :> {args}, Infinity] // Flatten;
  FreeQ[transcArgs, var]
]

(* Detect if var appears quadratically in any denominator factor.
   Returns the set of OTHER integration variables that the quadratic
   coefficients depend on \[LongDash] these should be integrated BEFORE var
   to avoid variable-dependent lambda roots. *)
(* Detect quadratic dependencies using precomputed S0 *)
IV$QuadraticDepsFromS0[S0_List, var_, allVars_List] := Module[{deps = {}},
  Do[Module[{sExp = Expand[s]},
    If[Exponent[sExp, var] >= 2,
      Module[{coeffs = Table[Coefficient[sExp, var, k], {k, 2, Exponent[sExp, var]}]},
        deps = Union[deps, Select[Complement[allVars, {var}], !FreeQ[coeffs, #] &]]]]
  ], {s, S0}];
  deps
]
IV$QuadraticDeps[expr_, var_, allVars_List] :=
  IV$QuadraticDepsFromS0[IV$ExtractS0[expr, allVars], var, allVars]

(* Score penalty for an ordering: penalize when a quadratic variable
   is integrated BEFORE the variables its coefficients depend on *)
IV$QuadPenalty[order_List, expr_, allVars_List] := Module[{penalty = 0},
  Do[Module[{var = order[[i]], deps},
    deps = IV$QuadraticDeps[expr, var, allVars];
    (* Penalty for each dep variable that comes AFTER var in the order *)
    Do[If[MemberQ[order[[i+1;;]], d], penalty += 100], {d, deps}];
  ], {i, Length[order]}];
  penalty
]

(* ============================================================ *)
(* SECTION 2: COMPATIBILITY GRAPH REDUCTION                     *)
(* ============================================================ *)

IV$CGInit[IVPolySet_List] := {IVPolySet, Subsets[IVPolySet, {2}]}

IV$CGProject[{IVPolySet_List, C_List}, var_] := Module[
  {newPolys = {}, newEdges = {}, linear, nonlinear,
   leadC, constC, reslt, sources, f, g, e, irr},
  linear = Select[IVPolySet, Exponent[#, var] == 1 &];
  nonlinear = Select[IVPolySet, Exponent[#, var] == 0 &];
  leadC = Association[]; constC = Association[];
  Do[Module[{lc = Coefficient[f, var, 1], cc = f /. var -> 0},
    leadC[f] = If[lc =!= 0 && !NumericQ[lc], IV$IrrFactors[lc, Variables[lc]], {}];
    constC[f] = If[cc =!= 0 && !NumericQ[cc], IV$IrrFactors[cc, Variables[cc]], {}];
  ], {f, linear}];
  reslt = Association[];
  Do[{f, g} = e;
    If[Exponent[f, var] >= 1 && Exponent[g, var] >= 1,
      Module[{r = Resultant[f, g, var]},
        reslt[e] = If[r =!= 0, IV$IrrFactors[r, Complement[Variables[r], {var}]], {}]],
      reslt[e] = {}];
  , {e, C}];
  newPolys = Select[Union[Flatten[Join[nonlinear, Values[leadC], Values[constC], Values[reslt]]]], !NumericQ[#]&];
  Do[sources = Join[leadC[f], constC[f]]; newEdges = Join[newEdges, Subsets[sources, {2}]], {f, linear}];
  Do[{f,g}=e; sources = Join[Lookup[reslt,Key[e],{}],Lookup[leadC,Key[f],{}],Lookup[constC,Key[f],{}],
    Lookup[leadC,Key[g],{}],Lookup[constC,Key[g],{}]]; newEdges = Join[newEdges, Subsets[Union[sources],{2}]], {e,C}];
  Do[newEdges = Join[newEdges, {Sort[{f,#}]}& /@ DeleteCases[newPolys, f]], {f, nonlinear}];
  newEdges = Select[Union[Sort /@ newEdges], Length[#]==2 && #[[1]]=!=#[[2]] && SubsetQ[newPolys,#]&];
  {newPolys, newEdges}
]

(* Multi-path reduction with intersection *)
IV$CGReduceMulti[S0_List, vars_List] := Module[{IVLetterL = <||>, cg, perms, existing},
  cg = IV$CGInit[S0]; IVLetterL[{}] = cg;
  Do[
    perms = Permutations[vars[[;;i]]];
    Do[
      existing = p[[;;-2]];
      If[KeyExistsQ[IVLetterL, existing],
        Module[{proj = IV$CGProject[IVLetterL[existing], p[[-1]]]},
          If[KeyExistsQ[IVLetterL, p],
            (* Intersect *)
            IVLetterL[p] = {Intersection[IVLetterL[p][[1]], proj[[1]]], Intersection[IVLetterL[p][[2]], proj[[2]]]},
            IVLetterL[p] = proj
          ];
        ];
      ];
    , {p, perms}];
  , {i, Length[vars]}];
  IVLetterL
]

(* ============================================================ *)
(* SECTION 3: ORDER FINDING                                     *)
(* ============================================================ *)

(* Variables appearing inside Log[...] arguments. These should be integrated
   FIRST so PLT's GIntegrate absorbs the Log term cleanly via fibration; if
   left for later, the antiderivative develops non-linear-in-var letters
   (e.g. M\[ODoubleDot]bius letters like t6/((-1+t2)(-1+t4)(-1+t6))) that PLT cannot
   reduce, producing CanInt$FrozenCiTi terms or silent zeros. *)
IV$LogArgVars[expr_, vars_List] := DeleteDuplicates[Flatten[
  Cases[Cases[expr, Log[a_] :> a, Infinity],
    Alternatives @@ vars, Infinity]]]

IV$BestOrder[expr_, vars_List] := Module[
  {S0, perms, trials, valid, scored, rationalVars, transcVars, logVars},
  S0 = IV$ExtractS0[expr, vars];
  If[Length[S0] == 0, Return[{True, vars, S0}]];

  (* Classify: rational-only vars vs transcendental (appear in Log/G) *)
  rationalVars = Select[vars, IV$IsRationalOnlyQ[expr, #] &];
  transcVars = Complement[vars, rationalVars];
  logVars = IV$LogArgVars[expr, vars];

  (* Generate permutations: Log-bound vars FIRST (lowest weight; fibrate Log
     immediately), then remaining rational vars, then remaining transcendentals.
     Falls back to {rational, transc} grouping if no Log args present. *)
  If[Length[logVars] > 0,
    Module[{nonLogVars = Complement[vars, logVars],
            nonLogRational, nonLogTransc},
      nonLogRational = Select[nonLogVars, IV$IsRationalOnlyQ[expr, #] &];
      nonLogTransc = Complement[nonLogVars, nonLogRational];
      perms = Flatten[Outer[Join,
        Permutations[logVars],
        Permutations[nonLogRational],
        Permutations[nonLogTransc], 1], 2]],
    perms = If[Length[rationalVars] > 0 && Length[transcVars] > 0,
      Flatten[
        Outer[Join, Permutations[rationalVars], Permutations[transcVars], 1], 1],
      Permutations[vars]]];

  If[Length[perms] > 5040, Return[IV$GreedyOrder[expr, vars]]];

  trials = {#, IV$TryOrder[S0, #, vars]} & /@ perms;
  valid = Select[trials, #[[2, 1]] === True &];

  (* If no log-first ordering works, fall back to all permutations *)
  If[Length[valid] === 0,
    perms = Permutations[vars];
    If[Length[perms] > 5040, Return[IV$GreedyOrder[expr, vars]]];
    trials = {#, IV$TryOrder[S0, #, vars]} & /@ perms;
    valid = Select[trials, #[[2, 1]] === True &]];

  If[Length[valid] === 0, Return[{False, vars, S0}]];

  (* Score: PRIMARY: enforce "lambda-last" \[LongDash] variables whose quadratic coefficients
     depend on other integration vars must be integrated AFTER those vars.
     SECONDARY: prefer Log-bound vars first (count #[[5]]: how many Log-vars are
     in the leading positions of the order). TERTIARY: rational vars first.
     QUATERNARY: smaller |S| total. *)
  scored = SortBy[
    ({#[[1]], #[[2, 2]], #[[2, 3]], Total[#[[2, 3]]],
      Count[Take[#[[1]], Min[Length[logVars], Length[#[[1]]]]],
        v_ /; MemberQ[logVars, v]],
      Count[Take[#[[1]], Min[Length[rationalVars], Length[#[[1]]]]],
        v_ /; MemberQ[rationalVars, v]],
      IV$QuadPenalty[#[[1]], expr, vars]} & /@ valid),
    ({#[[7]], -#[[5]], -#[[6]], #[[4]]} &)];
  {True, scored[[1, 1]], S0}
]

IV$GreedyOrder[expr_, vars_List] := Module[
  {S0, IVPolySet, remaining, order = {}, bestVar, bestSize, nextS, rationalVars, logVars},
  S0 = IV$ExtractS0[expr, vars]; IVPolySet = S0; remaining = vars;
  rationalVars = Select[vars, IV$IsRationalOnlyQ[expr, #]&];
  logVars = IV$LogArgVars[expr, vars];
  While[Length[remaining] > 0,
    bestVar = None; bestSize = Infinity;
    (* Score components (lower is better):
         +Length[nextS]            \[LongDash] minimize residue size
         -1000000 if v is in logVars (still in remaining) \[LongDash] strongly prefer Log-vars first
         +10000 if v is non-rational \[LongDash] penalize unless rational *)
    Do[If[Max[0, Max[Exponent[#, v]& /@ IVPolySet]] <= IV$MaxAcceptableDegreeForLambda,
      nextS = IV$NextS[IVPolySet, v, remaining];
      Module[{score = Length[nextS]
                      + If[MemberQ[logVars, v], -1000000, 0]
                      + If[MemberQ[rationalVars, v], 0, 10000]},
        If[score < bestSize, bestSize = score; bestVar = v]]
    ], {v, remaining}];
    If[bestVar === None, Return[{False, Join[order, remaining], S0}]];
    AppendTo[order, bestVar]; IVPolySet = IV$NextS[IVPolySet, bestVar, remaining];
    remaining = DeleteCases[remaining, bestVar]];
  {True, order, S0}
]

(* ============================================================ *)
(* SECTION 3B: RANKED ORDER ENGINE (2026-07-02)                 *)
(*                                                              *)
(* Replaces the permutation-enumeration order search and the    *)
(* blind full-integration retry cascade.  Design:               *)
(*                                                              *)
(* (1) IV$NextSMemo: the polynomial reduction IV$NextS depends  *)
(*     only on (S, var) -- memoize on the canonical key.        *)
(*     Distinct S-states along all orders are FEW compared to   *)
(*     D! permutations (prefixes merge), so the whole valid-    *)
(*     order tree costs ~#distinct-states reductions.           *)
(* (2) IV$RankedOrders: DFS over the prefix trie with subtree   *)
(*     pruning (a prefix whose next variable has degree > 2 in  *)
(*     the current S kills that whole subtree).  Records each   *)
(*     complete valid order with its |S|-chain and the          *)
(*     PENULTIMATE letter set.                                  *)
(* (3) Scoring aligned with the OBSERVED failure modes (late-   *)
(*     stage fibration/DG failures, frozen CiTi):               *)
(*       a. quad-penalty (lambda-last, as before)               *)
(*       b. TERMINAL difficulty: size of the last-stage letter  *)
(*          set + heavy penalty for letters nonlinear in the    *)
(*          final variable (the final 1D integration must see   *)
(*          simple letters -- the empirical res2/MBpilot13 lesson)   *)
(*       c. late-weighted size chain  Sum i^2 |S_i|  (late      *)
(*          blowups are what kill GIntegrate, not early ones)   *)
(*       d. log-vars-first, rational-vars-first (as before)     *)
(* (4) The ranked list is cached ($IV$LastRankedOrders) and the *)
(*     RETRY loops walk IT (structurally valid orders only, in  *)
(*     rank order) instead of raw Permutations[vars];           *)
(*     failure-prefix pruning skips candidates sharing a prefix *)
(*     that already failed at that step, and successful step    *)
(*     results are reused across candidates sharing a prefix.   *)
(* Set $IV$FastOrder = False to restore the legacy behavior.    *)
(* ============================================================ *)

If[!ValueQ[$IV$FastOrder], $IV$FastOrder = True];
If[!ValueQ[$IV$RankedMaxVars], $IV$RankedMaxVars = 8];
$IV$OrderMemo = <||>;
$IV$LastRankedOrders = Missing["NotComputed"];
$IV$FailedPrefixes = {};
$IV$PrefixCache = <||>;

IV$NextSMemo[IVPolySet_List, xa_, allVars_List] := Module[{key = {Sort[IVPolySet], xa}},
  Lookup[$IV$OrderMemo, Key[key],
    $IV$OrderMemo[key] = IV$NextS[IVPolySet, xa, allVars]]]

(* DFS over the valid-order trie.  Returns {order, lcChain, penultimateSet}
   for every complete valid order (degree <= IV$MaxAcceptableDegreeForLambda
   at every step), where lcChain[[i]] = Total[LeafCount /@ S_i] AFTER the
   i-th reduction.  Memoized reductions make this cheap even at 6-7 vars.
   CALIBRATION (2026-07-02, the 6-var PolyGamma example): letter COUNT |S_i|
   does NOT predict step cost/success -- letter SIZE does.  Orders that
   eliminate the variables entangled in the big multilinear letters FIRST
   (dropping the LeafCount chain early) are the ones that integrate; orders
   that keep a 16-term letter alive into late stages fail/grind there. *)
IV$AllValidOrders[S0_List, vars_List] := Module[{dfs},
  dfs[prefix_, IVPolySet_, lcs_] := Module[{rem = Select[vars, !MemberQ[prefix, #]&]},
    If[rem === {}, Sow[{prefix, lcs, {}}]; Return[]];
    If[Length[rem] === 1,
      (* last variable: no reduction needed; record with the CURRENT S as
         the penultimate letter set *)
      Sow[{Join[prefix, rem], lcs, IVPolySet}]; Return[]];
    Do[
      If[Max[0, Max[Exponent[#, v] & /@ IVPolySet]] <= IV$MaxAcceptableDegreeForLambda,
        Module[{S2 = IV$NextSMemo[IVPolySet, v, vars]},
          dfs[Append[prefix, v], S2,
            Append[lcs, Total[LeafCount /@ S2]]]]],
      {v, rem}]];
  If[S0 === {}, Return[{{vars, ConstantArray[0, Max[0, Length[vars] - 1]], {}}}]];
  Flatten[Reap[dfs[{}, S0, {}]][[2]], 1]]

(* Terminal-difficulty penalty: the final 1D integration sees the penultimate
   letter set as functions of the last variable; nonlinear letters there are
   the classic frozen-CiTi source. *)
IV$TerminalPenalty[penuSet_List, lastVar_] :=
  10 Length[penuSet] +
  1000 Count[penuSet, p_ /; Exponent[p, lastVar] > 1] +
  Total[LeafCount /@ penuSet]

IV$RankedOrders[expr_, vars_List] := Module[
  {S0, all, logVars, rationalVars, scored},
  S0 = IV$ExtractS0[expr, vars];
  logVars = IV$LogArgVars[expr, vars];
  rationalVars = Select[vars, IV$IsRationalOnlyQ[expr, #] &];
  all = IV$AllValidOrders[S0, vars];
  If[all === {}, Return[{False, {}, S0}]];
  scored = SortBy[all,
    Function[rec, Module[{ord = rec[[1]], lcs = rec[[2]], penu = rec[[3]]},
      {IV$QuadPenalty[ord, expr, vars],
       (* PRIMARY continuous score: late-weighted letter-SIZE chain + terminal
          difficulty.  Eliminating the entangled variables early empties the
          chain fast; a surviving big letter at stage i costs i^2 * its size. *)
       Sum[i^2 lcs[[i]], {i, Length[lcs]}] + IV$TerminalPenalty[penu, Last[ord]],
       -Count[Take[ord, Min[Length[logVars], Length[ord]]],
          v_ /; MemberQ[logVars, v]],
       -Count[Take[ord, Min[Length[rationalVars], Length[ord]]],
          v_ /; MemberQ[rationalVars, v]]}]]];
  {True, scored[[All, 1]], S0}]

(* Fast IV$BestOrder: first of the ranked list; caches the whole list for the
   retry loops.  Falls back to the legacy path for very high dimension. *)
IV$BestOrderFast[expr_, vars_List] := Module[{ok, ranked, S0},
  If[Length[vars] > $IV$RankedMaxVars, Return[IV$GreedyOrder[expr, vars]]];
  {ok, ranked, S0} = IV$RankedOrders[expr, vars];
  $IV$LastRankedOrders = If[ok, ranked, Missing["NoValidOrder"]];
  If[! ok, Return[{False, vars, S0}]];
  {True, First[ranked], S0}]

(* Candidates for the retry loops: LEGACY sequence (all permutations, log-vars
   biased to the front) -- its lexicographic family-jumping is empirically good
   for retries -- with the expensive full pre-ranking deliberately NOT used
   (see the calibration note at the first-pick site).  Validity, failed-prefix
   pruning and prefix-cache resumption are applied lazily inside the loops. *)
IV$RetryCandidates[expr_, vars_List, excludeOrder_] := Module[{perms, logVars},
  logVars = IV$LogArgVars[expr, vars];
  perms = Select[Permutations[vars], # =!= excludeOrder &];
  If[Length[logVars] > 0,
    perms = SortBy[perms,
      -Count[Take[#, Min[Length[logVars], Length[#]]],
        v_ /; MemberQ[logVars, v]] &]];
  perms]

(* Cheap structural validity of a candidate order (degree check along the
   memoized reduction chain) -- ~0.1-0.3s vs a 600s blind integration try. *)
IV$OrderValidQ[S0_List, ord_List, vars_List] := Module[{IVPolySet = S0, ok = True},
  Do[
    If[Max[0, Max[Exponent[#, ord[[i]]] & /@ IVPolySet]] > IV$MaxAcceptableDegreeForLambda,
      ok = False; Break[]];
    If[i < Length[ord], IVPolySet = IV$NextSMemo[IVPolySet, ord[[i]], vars]],
    {i, Length[ord]}];
  ok]

IV$PrefixFailedQ[ord_List] := AnyTrue[$IV$FailedPrefixes,
  Length[#] <= Length[ord] && Take[ord, Length[#]] === # &]

(* ============================================================ *)
(* SECTION 3C: MEASURED BEST-FIRST INTEGRATION ("probe race",   *)
(* 2026-07-02).                                                 *)
(*                                                              *)
(* Static order scores do not predict real step cost (see the   *)
(* calibration note above).  So MEASURE instead of predict:     *)
(* best-first (Dijkstra/A*-like) search over the prefix tree    *)
(* where expanding a node = integrating ONE actual step of one  *)
(* next variable.  Node key = accumulated wall time             *)
(*   + $IV$BFDepthPenalty * (remaining depth)                   *)
(* (an optimistic per-step estimate, biasing depth progress).   *)
(* Cheap trajectories advance; slow or failing subtrees are     *)
(* abandoned automatically; the first node at full depth IS the *)
(* completed integration -- no probe work is thrown away, and   *)
(* every intermediate state lands in $IV$PrefixCache for the    *)
(* retry engine.  On failure/timeout/budget exhaustion the      *)
(* caller falls back to the ordinary single-order flow with     *)
(* full step budgets (always-correct fallback).                 *)
(* ============================================================ *)

If[!ValueQ[$IV$ProbeRace], $IV$ProbeRace = True];
If[!ValueQ[$IV$BFStepTimeout], $IV$BFStepTimeout = 150];
If[!ValueQ[$IV$BFCapFloor], $IV$BFCapFloor = 45];  (* adaptive cap lower bound *)
If[!ValueQ[$IV$BFLastStepFactor], $IV$BFLastStepFactor = 3];  (* final steps get 3x cap *)
If[!ValueQ[$IV$BFDepthPenalty], $IV$BFDepthPenalty = 10.];
If[!ValueQ[$IV$BFFinishBonus], $IV$BFFinishBonus = 30.];  (* priority for completing edges *)
If[!ValueQ[$IV$BFBeamWidth], $IV$BFBeamWidth = 3];  (* open nodes per depth spawning edges *)
If[!ValueQ[$IV$BFMaxSteps], $IV$BFMaxSteps = Automatic];  (* Automatic -> 4 D^2 *)
If[!ValueQ[$IV$ProbeMinVars], $IV$ProbeMinVars = 3];

(* ENTANGLEMENT order (2026-07-02): eliminate first the variables appearing in
   the most / biggest letters of S0 (weighted by letter LeafCount). *)
IV$EntanglementOrder[S0_List, vars_List] :=
  Reverse @ SortBy[vars,
    Function[v, Total[If[FreeQ[#, v], 0, LeafCount[#]] & /@ S0]]]

(* ============================================================ *)
(* CORNER-KERNEL order (2026-07-02) — THE ROOT-CAUSE FIX.       *)
(* A compound-corner letter in K-form,                          *)
(*     L = p*A + (1-p)*B,   A, B monomials in {v, 1-v} atoms,   *)
(* has a distinguished KERNEL variable p: integrating p FIRST   *)
(* converts the corner to Beta x 2F1 (normal-crossing after     *)
(* Pfaff; master equation Prop 4.2 / PDCorner).  Integrating a  *)
(* MONOMIAL-SIDE variable of a live corner instead breeds       *)
(* composite resultant letters -> the late-step blowups.        *)
(* NO generic signal (letter count/size/entanglement/S-chain)   *)
(* distinguishes kernel from monomial-side variables — they are *)
(* symmetric to polynomial bookkeeping.  That asymmetry is      *)
(* exactly the typed-dictionary K-classification, so we detect  *)
(* it structurally and seed the order: kernel variables first   *)
(* (by #corners they linearize), then shared variables by       *)
(* entanglement, single-corner monomial-side variables last.    *)
(* Calibration: the 6-var PolyGamma case has two K-letters with *)
(* kernel vars v3, v4 — the empirically-working orders are      *)
(* precisely {v3,v4,...,v5,v6}-type.                            *)
(* ============================================================ *)

IV$MonomialAtomQ[e_] := MatchQ[IV$FactorListExact[e][[All, 1]],
  {(_?NumericQ | _Symbol | (1 - _Symbol) | (-1 + _Symbol) |
    _Symbol^_Integer | (1 - _Symbol)^_Integer | (-1 + _Symbol)^_Integer) ...}]

(* kernel variables of one letter: p such that L = p A + (1-p) B exactly,
   with A, B nonzero monomials *)
IV$KernelVarsOfLetter[IVLetterL_, vars_List] := Select[vars, Function[p,
  Exponent[IVLetterL, p] == 1 &&
  Module[{A = Simplify[IVLetterL /. p -> 1], B = Simplify[IVLetterL /. p -> 0]},
    A =!= 0 && B =!= 0 &&
    IV$MonomialAtomQ[A] && IV$MonomialAtomQ[B] &&
    Simplify[IVLetterL - (p A + (1 - p) B)] === 0]]]

IV$CornerKernelOrder[S0_List, vars_List] := Module[
  {compound, kernelCount, sideCount, ent, trusted},
  (* one letter may surface in several sign/scale guises; the ==1 trust test
     below needs kernel counts over CANONICAL distinct letters *)
  compound = DeleteDuplicatesBy[Select[S0, ! IV$IsMonomialQ[#, vars] &],
    Function[bb, Times @@ (Power[#[[1]], #[[2]]] & /@
       DeleteCases[IV$FactorListExact[bb], {_?NumericQ, _}])]];
  kernelCount = Association[# -> 0 & /@ vars];
  sideCount = Association[# -> 0 & /@ vars];   (* letters touched, non-kernel *)
  Do[Module[{kv = IV$KernelVarsOfLetter[IVLetterL, vars]},
    Do[kernelCount[p] = kernelCount[p] + 1, {p, kv}];
    Do[If[! FreeQ[IVLetterL, v] && ! MemberQ[kv, v],
       sideCount[v] = sideCount[v] + 1], {v, vars}]],
   {IVLetterL, compound}];
  (* v7 TRUST CONDITION (2026-07-02): a kernel variable is trusted ONLY if it
     is the kernel of EXACTLY ONE letter (kernelCount == 1).  That is the
     corner-swap scenario (one Beta x 2F1 + Pfaff swap fixes the letter and
     restores normal crossing).  A variable that is the kernel of SEVERAL
     letters (e.g. t in the res5 pieces, kernel of all four (qt+v(1-t))-type
     letters) is NOT: integrating it first leaves the other letters coupled
     (Appell territory) and the misdirected dive burns its step budget --
     measured: J0 1.4s -> 14.6s, B1/MB14-res5 died with ginsh errors.  With no
     trusted kernel the seed is SKIPPED ({} return; caller filters). *)
  trusted = Select[vars, kernelCount[#] === 1 &];
  If[trusted === {}, Return[{}]];
  ent = Association[# -> Total[If[FreeQ[IVLetterL, #], 0, LeafCount[IVLetterL]] & /@ S0] & /@ vars];
  (* trusted kernel vars first; ties by how many corners a variable touches
     non-kernel (shared vars before single-letter monomial-side vars, which
     sink to the end); final ties by entanglement *)
  Reverse @ SortBy[vars, Function[v,
    {Boole[MemberQ[trusted, v]], sideCount[v], ent[v]}]]]

(* Children of a node, in legacy-preference order (log-arg vars first, then
   rational-only vars), filtered by the linear-reducibility degree check. *)
IV$BFChildren[IVPolySet_List, rem_List, vars_List, logVars_List, rationalVars_List] :=
  Module[{ok},
   ok = Select[rem, Function[v,
     Max[0, Max[Exponent[#, v] & /@ IVPolySet]] <= IV$MaxAcceptableDegreeForLambda]];
   SortBy[ok, {-Boole[MemberQ[logVars, #]], -Boole[MemberQ[rationalVars, #]]} &]]

(* Best-first integration, LAZY-EDGE version (v2, 2026-07-02).  The frontier
   holds PENDING EDGES (parent node, next variable); popping an edge costs
   exactly ONE real integration step.  (The eager v1 -- integrate all children
   of a popped node -- billed the whole sibling set of every attractive node;
   measured on the 6-var calibration case it burned ~90s on doomed siblings
   before letting other families advance.)  Edge key =
     parentTime + estimate(depth) + $IV$BFDepthPenalty*(remaining after step),
   with estimate = running median of observed step times at that depth
   (optimistic start).  Returns {order, result, lamRules} or $Failed. *)
IV$BestFirstIntegrate[expr_, vars_List, mainFit_, paramFit_, regSyms_List,
    doLambda_, verbose_] := Module[
  {D = Length[vars], S0, logVars, rationalVars, nodes, edges, expansions = 0,
   maxSteps, best = $Failed, edge, parent, prefix2, rem2, depth2, isLast,
   t0, stepT, r, l, obsTimes, est, enqueueEdges, doStep, openPerDepth,
   legacyOrd, diveNode},
  S0 = IV$ExtractS0[expr, vars];
  logVars = IV$LogArgVars[expr, vars];
  rationalVars = Select[vars, IV$IsRationalOnlyQ[expr, #] &];
  maxSteps = If[$IV$BFMaxSteps === Automatic, 4 D^2, $IV$BFMaxSteps];
  obsTimes = <||>;  (* depth -> list of observed step times *)
  est[d_] := Median[Lookup[obsTimes, d, {2.}]];
  nodes = <|{} -> <|"cur" -> expr, "lams" -> {}, "S" -> S0, "time" -> 0.|>|>;
  openPerDepth = <||>;  (* depth -> # open (edge-spawning) nodes admitted *)
  enqueueEdges[pfx_] := Module[{nd = nodes[pfx], rest, kids, d = Length[pfx]},
    (* BEAM: only the best $IV$BFBeamWidth nodes per depth spawn edges;
       admission is first-come (best-first pops arrive in key order). *)
    If[Lookup[openPerDepth, d, 0] >= $IV$BFBeamWidth && d > 0, Return[]];
    openPerDepth[d] = Lookup[openPerDepth, d, 0] + 1;
    rest = Select[vars, ! MemberQ[pfx, #] &];
    kids = If[Length[rest] === 1, rest,
      IV$BFChildren[nd["S"], rest, vars, logVars, rationalVars]];
    Do[edges = Append[edges, {pfx, kid}], {kid, kids}]];
  (* ONE real integration step; updates caches/stats; returns True on success *)
  doStep[pfx_, xa_] := Module[{par = nodes[pfx], d2, pf2, rm2, lst, tt0, rr, ll,
      sT, cap},
    d2 = Length[pfx] + 1; pf2 = Append[pfx, xa];
    rm2 = Select[vars, ! MemberQ[pf2, #] &];
    lst = (d2 === D);
    (* FIXED cap.  NB an adaptive cap (6x median observed, floor 45s) was tried
       and REVERTED (2026-07-02): cheap early steps dragged the cap below the
       LEGITIMATE 40-50s cost of this class's deep steps, killing every viable
       path (calibration case v4 failure).  Deep steps are intrinsically
       heavier; the fixed budget with the warm-cache fallback is the robust
       configuration (v3 self-completed under it). *)
    cap = If[lst, $IV$BFLastStepFactor $IV$BFStepTimeout, $IV$BFStepTimeout];
    tt0 = AbsoluteTime[];
    (* CheckAbort (v8): a bad order can drive a fit whose ginsh interface
       calls Abort[] (observed: res5 B1 entanglement dive, step 4, CiTi
       fits) -- without this the WHOLE computation dies ($Aborted), not
       just the step.  An aborted step is just a failed step. *)
    {rr, ll} = Quiet @ CheckAbort[TimeConstrained[
       IV$IntegrateStep[par["cur"], xa, 0, 1, rm2, mainFit, paramFit,
         regSyms[[d2]], lst && doLambda, False],
       cap, {$Failed, {}}], {$Failed, {}}];
    sT = AbsoluteTime[] - tt0;
    expansions++;
    obsTimes[d2] = Append[Lookup[obsTimes, d2, {}], sT];
    If[rr === $Failed || rr === Indeterminate || rr === Undefined ||
       (lst && IV$HasFrozenTermsQ[rr]),
      AppendTo[$IV$FailedPrefixes, pf2];
      If[verbose, Print["[BF] step ", pf2, " failed/timeout (",
        Round[sT, 0.1], "s)"]];
      False,
      Module[{lams2 = Join[par["lams"], ll]},
       If[! lst && LeafCount[rr] < 200000, $IV$PrefixCache[pf2] = {rr, lams2}];
       If[verbose, Print["[BF] step ", pf2, " ok (",
         Round[sT, 0.1], "s, LC ", LeafCount[rr], ")"]];
       If[lst,
         If[FreeQ[rr, Alternatives @@ vars], best = {pf2, rr, lams2}],
         nodes[pf2] = <|"cur" -> rr, "lams" -> lams2,
           "S" -> IV$NextSMemo[par["S"], xa, vars],
           "time" -> par["time"] + sT|>];
       True]]];
  edges = {};
  (* MULTI-DIVE (2026-07-02): walk candidate orders first with capped steps.
     Seed 1 = ENTANGLEMENT order (most-entangled variables first -- the
     empirically correct signature on the calibration case, and the cheap one:
     no permutation enumeration).  Seed 2 = the caller's heuristic pick.
     A dive reuses any prefix nodes an earlier dive already integrated; when a
     dive completes, that IS the integration.  Failed dives seed the frontier
     and record their failure points. *)
  Module[{diveOrders, dn},
   (* v8 dive priority: (1) trusted corner-kernel order (theory-derived),
      (2) the caller's pick -- IV$BestOrder for D<=5 (the v3-proven seed;
      res5 B1 completes on it), greedy for D>=6, (3) entanglement order.
      Entanglement moved LAST: on B1 it led into an aborting fit while the
      caller seed succeeds; prefix reuse makes extra dives nearly free. *)
   diveOrders = Select[DeleteDuplicates @ Join[
      {IV$CornerKernelOrder[S0, vars]},        (* root-cause seed: kernel vars first;
                                                  {} (skipped) when no TRUSTED kernel *)
      If[ListQ[$IV$BFSeedOrder] && Length[$IV$BFSeedOrder] === D &&
         Sort[$IV$BFSeedOrder] === Sort[vars], {$IV$BFSeedOrder}, {}],
      {IV$EntanglementOrder[S0, vars]}],
     Length[#] === D &];
   Do[
    If[best =!= $Failed, Break[]];
    dn = {};
    Do[
     If[best =!= $Failed, Break[]];
     Module[{nxt = Append[dn, dOrd[[i]]]},
      Which[
       KeyExistsQ[nodes, nxt],
         dn = nxt,                              (* reuse earlier dive's work *)
       IV$PrefixFailedQ[nxt],
         Break[],
       Max[0, Max[Exponent[#, dOrd[[i]]] & /@ nodes[dn]["S"]]] >
          IV$MaxAcceptableDegreeForLambda,
         Break[],
       doStep[dn, dOrd[[i]]],
         dn = nxt; If[i < D, enqueueEdges[dn]],
       True,
         Break[]]],
     {i, D}],
    {dOrd, diveOrders}]];
  If[best === $Failed, enqueueEdges[{}]];
  While[edges =!= {} && expansions < maxSteps && best === $Failed,
   (* pop the minimum-key pending edge; ONE real step per pop.  Edges that
      complete a path get the finish bonus. *)
   edge = First @ MinimalBy[edges,
      Function[e, Module[{nd = nodes[e[[1]]], d = Length[e[[1]]] + 1},
        nd["time"] + est[d] + $IV$BFDepthPenalty (D - d) -
          If[d === D, $IV$BFFinishBonus, 0.]]]];
   edges = DeleteCases[edges, edge, 1, 1];
   prefix2 = Append[edge[[1]], edge[[2]]];
   If[IV$PrefixFailedQ[prefix2] || KeyExistsQ[nodes, prefix2], Continue[]];
   If[doStep[edge[[1]], edge[[2]]] && best === $Failed,
     enqueueEdges[prefix2]]];
  If[best === $Failed && verbose,
    Print["[BF] no completed path (expansions=", expansions,
      ") -- falling back to single-order flow"]];
  best]

(* ============================================================ *)
(* SECTION 4: FIT VALUE MANAGEMENT                              *)
(* ============================================================ *)

IV$DefaultFitValues[vars_List] := Module[{n = Length[vars], vals, step},
  If[n == 0, Return[<||>]]; If[n == 1, Return[AssociationThread[vars -> {0.47}]]];
  step = 0.74/(n-1); vals = Table[0.13 + (i-1)*step, {i, n}];
  vals = Riffle[vals[[;;Ceiling[n/2]]], Reverse[vals[[Ceiling[n/2]+1;;]]]]; vals = vals[[;;n]];
  AssociationThread[vars -> vals]
]

IV$AllSyms[expr_] := Select[Union[Cases[expr, _Symbol, Infinity]],
  !MemberQ[{Pi,E,I,True,False,Null,Infinity,EulerGamma,Catalan,Khinchin,Glaisher}, #] &&
  !StringMatchQ[Context[#], "System`"] &]

IV$BuildFitList[expr_, fibVars_List, mainFit_Association, paramFit_Association] :=
Module[{allSyms, known, unknown, autoFit, merged},
  allSyms = Union[IV$AllSyms[expr], fibVars];
  known = Union[Keys[mainFit], Keys[paramFit]];
  unknown = Complement[allSyms, known];
  autoFit = If[Length[unknown] > 0,
    AssociationThread[unknown -> Table[(k+2)/(Length[unknown]+5), {k, Length[unknown]}]], <||>];
  merged = Join[KeyTake[mainFit, Intersection[Keys[mainFit], allSyms]],
    KeyTake[paramFit, Intersection[Keys[paramFit], allSyms]], autoFit];
  Normal[merged]
]

(* ============================================================ *)
(* SECTION 6: UNIFIED INTEGRATION ENGINE (PLT + UGI techniques) *)
(* ============================================================ *)

(* --- 6A: Degree Classification --- *)

IV$ExtractBaseDenom[integrand_, vars_List] := Module[{t, den, facs, rel},
  t = Together[integrand]; den = Denominator[t];
  facs = IV$FactorListExact[den];
  rel = Select[facs, !NumericQ[Expand[#[[1]]]] && !FreeQ[Expand[#[[1]]], Alternatives@@vars] &];
  If[Length[rel]==0, 1, Expand[SortBy[rel, -Length[Intersection[Variables[Expand[#[[1]]]],vars]]&][[1,1]]]]]

IV$ClassifyVars[integrand_, varLimits_List] := Module[
  {vars, D0, degs, sch, nonSch, d0, d1, d2A, lamV, order, earlyA},
  vars = varLimits[[All,1]]; D0 = IV$ExtractBaseDenom[integrand, vars];
  degs = Association[# -> Exponent[D0,#] & /@ vars];
  sch = Select[varLimits, !NumericQ[#[[3]]] && #[[3]]=!=1 &];
  nonSch = Complement[varLimits, sch, SameTest->(#1[[1]]===#2[[1]]&)];
  d0 = Select[nonSch, degs[#[[1]]]==0 &]; d1 = Select[nonSch, degs[#[[1]]]==1 &];
  d2A = Select[nonSch, degs[#[[1]]]>=2 &];
  lamV = If[Length[d2A]>0, First[SortBy[d2A, -Length[CoefficientList[D0,#[[1]]]]&]], Null];
  If[lamV=!=Null, earlyA=d1[[All,1]],
    If[Length[d1]>0, earlyA=Most[d1][[All,1]], earlyA={}]];
  order = Join[d0[[All,1]], sch[[All,1]], earlyA,
    Select[d2A, #=!=lamV &][[All,1]],
    If[lamV=!=Null, {lamV[[1]]}, If[Length[d1]>0, {Last[d1][[1]]}, {}]]];
  <|"D"->D0,"Degs"->degs,"Lambda"->lamV,"Schwinger"->sch,"Order"->order,
    "Multilinear"->(lamV===Null && Length[d2A]==0)|>]

(* --- 6B: Lambda Substitution --- *)

(* Context-agnostic variable check: True if expr contains var regardless of context.
   Needed because PLT puts symbols in PolyLogTools` context. *)
IV$ContainsVar[expr_, var_] := !FreeQ[expr, s_ /; StringMatchQ[ToString[s], ToString[var]]]

$IV$LamCounter = 0;

IV$FindQuadratics[expr_, x_] := Module[{t, den, facs},
  t = Together[expr]; den = Denominator[t];
  facs = Expand /@ IV$FactorListExact[den][[All,1]];
  Select[facs, PolynomialQ[Expand[#],x] && Exponent[Expand[#],x]==2 && !NumericQ[Expand[#]] &] // DeleteDuplicates]

IV$LambdaData[Q_, x_] := Module[{Qe,a,b,c,disc,l1v,l2v,l1s,l2s,k},
  Qe=Expand[Q]; a=Coefficient[Qe,x,2]; b=Coefficient[Qe,x,1]; c=Coefficient[Qe,x,0];
  disc=Expand[b^2-4*a*c]; l1v=Simplify[(b+Sqrt[disc])/(2a)]; l2v=Simplify[(b-Sqrt[disc])/(2a)];
  $IV$LamCounter++; k=$IV$LamCounter;
  l1s=Symbol["IVlam"<>ToString[k]<>"a"]; l2s=Symbol["IVlam"<>ToString[k]<>"b"];
  <|"L1Sym"->l1s,"L2Sym"->l2s,"L1Val"->l1v,"L2Val"->l2v,
    "Scale"->a,"Quad"->Qe,"Disc"->disc,
    "Rules"->{l1s->l1v,l2s->l2v},"SubRule"->(Qe->a*(l1s+x)*(l2s+x))|>]

IV$ApplyLambdas[expr_, x_, verbose_:False] := Module[{out, quads, dList, allR, pdReplaceFn},
  (* Find quadratics \[LongDash] use protected expr to avoid PLT evaluation *)
  quads = IV$FindQuadratics[expr /. G -> Global`GG$protect, x];
  If[Length[quads]==0, Return[{expr, {}}]];
  dList = IV$LambdaData[#, x] & /@ quads;
  allR = Flatten[#["Rules"] & /@ dList];

  (* Polynomial-division replacement function:
     For each rational coefficient c(x), divide out Qe from the denominator
     using PolynomialQuotient (exact algebra \[LongDash] no Factor/Together on full expression).
     This preserves numerical values unlike the old Factor-based approach. *)
  pdReplaceFn = Function[c, Module[{num, tmpDen, newC = c},
    Do[Module[{Qe = d["Quad"], fct = d["Scale"]*(d["L1Sym"]+x)*(d["L2Sym"]+x),
               rem, pow = 0},
      num = Numerator[newC]; tmpDen = Expand[Denominator[newC]];
      If[PolynomialQ[tmpDen, x] && Exponent[tmpDen, x] >= 2,
        (* Divide out all powers of Qe. CRITICAL: PolynomialRemainder doesn't
           simplify rational coefficient ratios like (4*A)/A \[RightArrow] 4 when A is a
           multi-term symbolic expression. Apply Together to the remainder so
           such ratios collapse and we can detect exact divisibility.
           PROBE-FIRST (2026-07-11): the expensive symbolic Together+Remainder
           used to run even when Qe does NOT divide (the common case).  An
           exact-rational-point remainder test is instant and cannot produce
           a false negative; a (measure-zero) false positive is still caught
           by the exact division below. *)
        Module[{syms, probe, probeDivQ},
          syms = DeleteCases[Variables[{tmpDen, Qe}], x];
          probe = Thread[syms -> Table[Prime[20 + 3 j]/Prime[50 + 2 j],
            {j, Length[syms]}]];
          probeDivQ := Quiet@Check[
            PossibleZeroQ[PolynomialRemainder[tmpDen /. probe, Qe /. probe, x]],
            True];   (* on any probe hiccup, defer to the exact test *)
          While[probeDivQ,
            rem = Together[PolynomialRemainder[tmpDen, Qe, x]];
            If[rem === 0 || Expand[rem] === 0 || PossibleZeroQ[rem],
              tmpDen = Together[PolynomialQuotient[tmpDen, Qe, x]]; pow++,
              Break[]]]];
        If[pow > 0,
          newC = num / (Expand[tmpDen] * fct^pow);
          If[verbose, Print["  [LamPD] Replaced Qe^",pow," via polynomial division"]]]]
    ], {d, dList}];
    newC
  ]];

  (* Protect G-functions and apply PD to each coefficient.
     CRITICAL: Use the explicit list of G-instances rather than the anonymous
     pattern `_Global`GG$protect`, otherwise Collect treats all G's as ONE
     collective variable \[LongDash] pdReplaceFn then sees a coefficient containing
     G-functions and Numerator/Denominator can't expose the quadratic. *)
  out = expr /. G -> Global`GG$protect;
  If[!FreeQ[out, Global`GG$protect],
    Module[{gInstances = DeleteDuplicates[Cases[out, _Global`GG$protect, Infinity]]},
      out = Collect[out, gInstances, pdReplaceFn]],
    out = pdReplaceFn[out]];
  out = out /. Global`GG$protect -> G;
  {out, allR}]

(* --- 6B2: Lambda Substitution Inside G-function Arguments --- *)
(* For G-functions like G[0, 1, f(x)/Qe(x)] where Qe is quadratic in x,
   factorize Qe into linear factors: Qe = a*(x+l1)*(x+l2).
   This enables ToFibrationBasis and GIntegrate to process the G-function. *)
IV$ApplyLambdasInG[expr_, x_, verbose_:False] := Module[
  {out = expr, allLamRules = {}, polyLogs, gFuncs, xName = ToString[x]},
  (* Context-agnostic FreeQ: check if expression contains variable by name *)
  Module[{hasX = Function[e, !FreeQ[e, s_ /; StringMatchQ[ToString[s], xName]]]},
  (* Find PolyLog[n, f(x)] terms where f(x) has quadratic denominator *)
  polyLogs = Select[Cases[out, _PolyLog, Infinity] // DeleteDuplicates, hasX];
  Do[Module[{arg = pl[[2]], den, quads},
    den = Denominator[Together[arg]];
    quads = If[PolynomialQ[Expand[den], x] && Exponent[Expand[den], x] >= 2,
      Select[Expand /@ IV$FactorListExact[den][[All,1]],
        PolynomialQ[Expand[#],x] && Exponent[Expand[#],x]==2 && !NumericQ[Expand[#]] &],
      {}];
    If[Length[quads] > 0,
      Module[{Qe = quads[[1]], dData, fct, num, tmpDen, rem, pow = 0, newArg},
        dData = IV$LambdaData[Qe, x];
        fct = dData["Scale"] * (dData["L1Sym"]+x) * (dData["L2Sym"]+x);
        num = Numerator[Together[arg]]; tmpDen = Expand[den];
        While[True,
          rem = PolynomialRemainder[tmpDen, Qe, x];
          If[Expand[rem] === 0, tmpDen = PolynomialQuotient[tmpDen, Qe, x]; pow++, Break[]]];
        If[pow > 0,
          newArg = num / (Expand[tmpDen] * fct^pow);
          out = out /. pl -> PolyLog[pl[[1]], newArg];
          allLamRules = Join[allLamRules, dData["Rules"]];
          If[verbose, Print["  [LamInG] Factorized Qe^",pow," in PolyLog argument"]]]]]
  ], {pl, polyLogs}];
  (* Also handle G-functions \[LongDash] find all G, then filter by variable presence *)
  gFuncs = Select[Cases[out, _G, Infinity] // DeleteDuplicates, hasX];
  Do[Module[{args = List @@ gf, newArgs, anyChanged = False, lamRules = {}},
    newArgs = Table[Module[{arg = args[[k]], den, quads},
      If[!FreeQ[arg, x],
        den = Denominator[Together[arg]];
        quads = If[PolynomialQ[Expand[den], x] && Exponent[Expand[den], x] >= 2,
          Select[Expand /@ IV$FactorListExact[den][[All,1]],
            PolynomialQ[Expand[#],x] && Exponent[Expand[#],x]==2 && !NumericQ[Expand[#]] &], {}];
        If[Length[quads] > 0,
          Module[{Qe = quads[[1]], dData, fct, num, tmpDen, rem, pow = 0},
            dData = IV$LambdaData[Qe, x];
            fct = dData["Scale"]*(dData["L1Sym"]+x)*(dData["L2Sym"]+x);
            num = Numerator[Together[arg]]; tmpDen = Expand[den];
            While[True, rem = PolynomialRemainder[tmpDen, Qe, x];
              If[Expand[rem]===0, tmpDen=PolynomialQuotient[tmpDen, Qe, x]; pow++, Break[]]];
            If[pow > 0,
              lamRules = Join[lamRules, dData["Rules"]]; anyChanged = True;
              If[verbose, Print["  [LamInG] Factorized Qe^",pow," in G-argument"]];
              num / (Expand[tmpDen] * fct^pow), arg]], arg], arg]],
    {k, Length[args]}];
    If[anyChanged,
      out = out /. gf -> (G @@ newArgs); allLamRules = Join[allLamRules, lamRules]]
  ], {gf, gFuncs}]];
  {out, allLamRules}]

(* --- 6C: Divergent G-Weight Regularization --- *)

IV$RegularizeDivergentG[ad_, x_, ep_] := Module[{out=ad, gs},
  gs = Cases[out, g:G[w__,z_] /; !FreeQ[{w},x], Infinity] // DeleteDuplicates;
  Do[Module[{args=List@@g, anyDiv=False},
    Do[If[!FreeQ[args[[i]],x], Module[{v=Quiet[Limit[args[[i]],x->ep]]},
      If[v===Indeterminate||!FreeQ[v,DirectedInfinity]||v===ComplexInfinity, anyDiv=True]
    ]], {i, Length[args]-1}];
    If[anyDiv, out = out /. g -> 0]], {g, gs}]; out]

(* --- 6C2: Per-word regularized-boundary cache (ported from HyperIntica's
   $ReglimWordCache, 2026-07-10).  Shuffle regularization is an algebra
   homomorphism and ExtractZeroes acts per-G, so the regularized value of each
   DISTINCT G/HPL object can be computed once and the boundary sum rebuilt by
   Dispatch replacement.  At deep levels the same G's recur across thousands of
   terms, repeated boundary calls, and family siblings; the cache is
   SESSION-PERSISTENT.  G's carrying an et-regulator symbol (Unique per call,
   never reused) are deduplicated within the call but NOT stored.  Any per-G
   message/failure falls back to the whole-expression call, which reproduces
   the original behavior exactly. *)
IV$RegWordCache = Association[];
IV$RegEphemeralQ[g_] := ! FreeQ[g, s_Symbol /;
  StringMatchQ[SymbolName[s], "et" ~~ (DigitCharacter | "$") ~~ ___]];
IV$GinshSafeRecord[e_] := Module[{dollarSymbols, aliases, forward,
    reverse, cleaned, gate},
  dollarSymbols = Select[DeleteDuplicates@Cases[e, _Symbol,
      {0, Infinity}, Heads -> False],
    StringContainsQ[SymbolName[#], "$"] &];
  aliases = Table[Symbol["Global`IVGinshSafeAlias" <> ToString[k]],
    {k, Length[dollarSymbols]}];
  forward = Thread[dollarSymbols -> aliases];
  reverse = Thread[aliases -> dollarSymbols];
  cleaned = e /. forward;
  gate = SameQ[cleaned /. reverse, e];
  <|"Expression" -> If[gate, cleaned, e], "ForwardRules" -> forward,
    "ReverseRules" -> If[gate, reverse, {}], "Gate" -> gate|>]
IV$RegBoundary[$Failed] = $Failed;
IV$RegBoundary[expr_] := Module[
  {safeRecord, safeExpr, reverseRules, gs, vals, one, result},
  safeRecord = IV$GinshSafeRecord[expr];
  If[! TrueQ[safeRecord["Gate"]], Return[$Failed]];
  safeExpr = safeRecord["Expression"];
  reverseRules = safeRecord["ReverseRules"];
  gs = DeleteDuplicates[Cases[safeExpr, _G | _HPL, {0, Infinity}]];
  If[Length[gs] < 2,
    result = ShuffleRegulate[ExtractZeroes[safeExpr]],
    one[g_] := If[KeyExistsQ[IV$RegWordCache, g], IV$RegWordCache[g],
      Module[{v = Quiet@Check[ShuffleRegulate[ExtractZeroes[g]], $IVRegBad]},
        If[v =!= $IVRegBad && ! IV$RegEphemeralQ[g],
          IV$RegWordCache[g] = v];
        v]];
    vals = one /@ gs;
    result = If[MemberQ[vals, $IVRegBad],
      ShuffleRegulate[ExtractZeroes[safeExpr]],
      safeExpr /. Dispatch[Thread[gs -> vals]]]];
  result /. reverseRules]

(* --- 6C3: FiniteFlow rational-coefficient reconstruction (2026-07-11) ---
   Deep-level G-coefficients swell to LC >> 100k where Together/Simplify are
   hopeless, and the engine previously applied NO compaction above 100k LC
   (the swelling then compounds into the next integration level).  Big
   coefficients are rational in {kinematics, abstract lambdas} up to a few
   transcendental ATOMS (Pi, Log[..], Zeta[..], radicals, I); abstract the
   atoms to fresh symbols, reconstruct the rational function over finite
   fields via FiniteFlow (FFAlgRatExprEval accepts UNCOLLECTED expressions --
   no Together needed), verify at a random numeric point, restore the atoms.
   Every failure path falls back to the previous behavior; with FiniteFlow
   absent the engine is byte-identical to the pre-FF baseline. *)
$IV$UseFF = True;          (* master switch for FF coefficient reconstruction *)
$IV$FFGate = 2000;         (* LeafCount above which a coefficient goes to FF *)
$IV$FFMaxUnknowns = 200000; (* refuse reconstruction above this LEARNED size:
   dense-bound unknowns = Binomial[dtot+nvars, nvars].  CRITICAL: the cap must
   be on PROBLEM SIZE learned beforehand, NOT on time \[LongDash] FF reconstruction
   runs in native C++ threads that TimeConstrained CANNOT abort (LibraryLink
   never yields to the kernel), so an unbounded reconstruction = a hung run. *)
$IV$FFLoaded = Automatic;
IV$FFAvailableQ[] := Which[
  $IV$FFLoaded === True, True,
  $IV$FFLoaded === False, False,
  ! TrueQ[$IV$UseFF], False,
  True, $IV$FFLoaded = TrueQ[Quiet@Check[
    Needs["FiniteFlow`"]; NameQ["FiniteFlow`FFAlgRatExprEval"], False]]];

(* purely rational expression in symbols? (integer powers only) *)
IV$RatExprQ[_Integer | _Rational | _Symbol] := True;
IV$RatExprQ[e_Plus | e_Times] := AllTrue[List @@ e, IV$RatExprQ];
IV$RatExprQ[Power[b_, _Integer]] := IV$RatExprQ[b];
IV$RatExprQ[_] := False;

(* abstract non-rational atoms -> IVffA1, IVffA2, ...; returns {expr, backRules} *)
IV$FFAbstract[c_] := Module[{e = c, back = {}, k = 0, mk, atoms, pws},
  mk[orig_] := Module[{s}, k++; s = Symbol["Global`IVffA" <> ToString[k]];
    AppendTo[back, s -> orig]; s];
  If[! FreeQ[e, Complex[_, _]],
    With[{iSym = mk[I]}, e = e /. Complex[a_, b_] :> a + b iSym]];
  atoms = DeleteDuplicates[Cases[e,
    _Log | _PolyLog | _Zeta | _PolyGamma | _Gamma | _G | _HPL | _ArcTanh |
    _ArcTan | _EllipticK | _Root | Pi | E | EulerGamma | Catalan,
    {0, Infinity}]];
  atoms = SortBy[atoms, -LeafCount[#] &];   (* outermost/nested first *)
  Do[With[{a = a1}, e = e /. a -> mk[a]], {a1, atoms}];
  (* fractional powers: b^(p/q) -> aux^p with aux = b^(1/q), per {base, q} *)
  pws = DeleteDuplicates[
    Cases[e, Power[b_, r_Rational] :> {b, Denominator[r]}, {0, Infinity}]];
  Do[With[{b = p[[1]], q = p[[2]], aux = mk[p[[1]]^(1/p[[2]])]},
      e = e /. Power[b, r_Rational /; Denominator[r] === q] :> aux^Numerator[r]],
    {p, pws}];
  {e, back}];

(* core: FF-reconstruct one big coefficient; $Failed on ANY doubt *)
IV$FFRatSimplify[c_] := Module[
  {abs, e, back, vars, rec, res, pt, a, b, okPt, tries},
  abs = IV$FFAbstract[c]; e = abs[[1]]; back = abs[[2]];
  If[! IV$RatExprQ[e], Return[$Failed]];
  vars = Sort@DeleteDuplicates@Cases[e, _Symbol, {0, Infinity}, Heads -> False];
  If[vars === {}, Return[$Failed]];   (* pure number: not worth a graph *)
  Quiet[Symbol["FiniteFlow`FFDeleteGraph"][Global`IV$ffGraph]];
  rec = Quiet@Check[Module[{degs, dmax, est},
    Symbol["FiniteFlow`FFNewGraph"][Global`IV$ffGraph, Global`IV$ffIn, vars];
    Symbol["FiniteFlow`FFAlgRatExprEval"][Global`IV$ffGraph, Global`IV$ffNode,
      {Global`IV$ffIn}, vars, {e}];
    Symbol["FiniteFlow`FFGraphOutput"][Global`IV$ffGraph, Global`IV$ffNode];
    (* learn num/den total degrees FIRST (cheap univariate probes), then
       refuse any reconstruction whose dense-bound unknown count is too big:
       cost scales with the ANSWER's size and native code cannot be aborted *)
    degs = Symbol["FiniteFlow`FFTotalDegrees"][Global`IV$ffGraph];
    dmax = Max[Cases[degs, _Integer, {0, Infinity}]];
    est = If[IntegerQ[dmax], Binomial[dmax + Length[vars], Length[vars]], Infinity];
    If[est > $IV$FFMaxUnknowns, $Failed,
      Symbol["FiniteFlow`FFReconstructFunction"][Global`IV$ffGraph, vars,
        "MaxDegree" -> Max[dmax + 2, 16]]]],
    $Failed];
  Quiet[Symbol["FiniteFlow`FFDeleteGraph"][Global`IV$ffGraph]];
  If[! ListQ[rec] || Length[rec] =!= 1 ||
     ! FreeQ[rec, s_Symbol /; StringStartsQ[SymbolName[s], "FF"]],
    Return[$Failed]];
  res = First[rec];
  (* machine-precision spot check at up to 2 random points (guards against
     any parser mis-map; FF itself already verifies the reconstruction) *)
  okPt = False; tries = 0;
  While[! okPt && tries < 2, tries++;
    pt = Thread[vars -> Table[RandomReal[{0.21, 0.93}], Length[vars]]];
    a = Quiet[e /. pt]; b = Quiet[res /. pt];
    okPt = NumericQ[a] && NumericQ[b] &&
      Abs[a - b] <= 10^-6 (Abs[a] + Abs[b] + 1)];
  If[! okPt, Return[$Failed]];
  res /. back];

(* denominator-grouping partial Together: the scalable workhorse for the
   coefficients FF refuses (many vars x high degree).  Real swelling is the
   SAME small denominator repeated across thousands of terms with different
   numerators; grouping by syntactic Denominator and Together-ing within each
   group is near-linear and needs no global common denominator. *)
IV$GroupTogether[c_] := Module[{terms, groups},
  terms = If[Head[c] === Plus, List @@ c, {c}];
  If[Length[terms] < 2, Return[c]];
  groups = Values[GroupBy[terms, Denominator]];
  Total[Quiet@TimeConstrained[Together[Total[#]], 20, Total[#]] & /@ groups]];

(* gated compactor ladder for one G-coefficient:
   small -> Together (classic, but CAPPED: small LeafCount does NOT imply a
   cheap Together \[LongDash] 30 terms with independent linear denominators is
   LC<2000 yet its common denominator has degree ~90 and hangs; caught by the
   F10 deadman 2026-07-11);  big -> FF reconstruction (only if the learned
   answer size passes the unknowns bound);  FF refused/failed -> grouping
   partial Together;  worst case a piece times out and is returned UNCHANGED
   (= the engine's previous no-op behavior above 100k LC). *)
IV$CompactCoef[c_] := Module[{r},
  If[LeafCount[c] <= $IV$FFGate,
    Return[Quiet@TimeConstrained[Together[c], 30, c]]];
  r = If[IV$FFAvailableQ[], Quiet@Check[IV$FFRatSimplify[c], $Failed], $Failed];
  If[r === $Failed, IV$GroupTogether[c], r]];

(* --- 6C4: Fibration template engine (2026-07-11) ---
   Port of the user's hand technique (training sessions 02-B1, 03): derive
   fibration identities ONCE on abstract-slot templates, instantiate
   syntactically. Two-layer cache over per-G fibration (ToFibrationBasis is
   term-local, so an expression may be fibrated G-by-G and reassembled):
     L1  exact-G memo   (HyperIntica TransformWordCache analogue)
     L2  SHAPE template: each G-argument is Together'd, its fibVar-monomial
         coefficients (rational functions of kinematics/lams) abstracted to
         slot symbols IVfts#, fib vars renamed positionally to IVftv#; the
         abstract G is fibrated once (FitValue = instance values) and re-used
         across pieces/steps/families by pure substitution.
   SAFETY: every NEW (shape, slots) instantiation is Ginsh-verified against
   the original G at the fit point before first use (branch/i-Pi guard);
   failures fall back to per-G direct ToFibrationBasis, and any per-G failure
   makes IV$FibExpr return $Failed so the caller runs the untouched stock
   whole-expression path. Toggle: $IV$UseFibTemplates. *)

(* AUTOMATIC (2026-07-12): templates are enabled EXACTLY WHEN THE KINEMATICS
   ARE DECLARED — because that is precisely the condition that makes them safe.
   A fibration identity is region-local; it is valid where it was derived.  The
   old failure (ep0 cof6: Re exact but Im = -50.37) was NOT a flaw in the
   identities — it was the engine deriving them at an INVENTED fit point and the
   caller evaluating them somewhere else.  Declare the kinematics and the
   template route sits on exactly the same footing as the stock route: same
   point, same branch.  Undeclared -> invented fits -> templates stay OFF.
     Automatic : on iff IVSetKinematics / "Kinematics" was given   (default)
     True      : force on   (workbench; you are asserting fit == eval)
     False     : force off  (stock paths, byte-identical) *)
If[!ValueQ[$IV$UseFibTemplates], $IV$UseFibTemplates = Automatic];
$IV$KinDeclared = False;   (* set per call by IntVolIntegrate *)
IV$TemplatesOnQ[] := Which[
  $IV$UseFibTemplates === True, True,
  $IV$UseFibTemplates === False, False,
  True, TrueQ[$IV$KinDeclared]];
If[!ValueQ[$IV$DebugLast],       $IV$DebugLast = False];
If[!ValueQ[$IV$IncompleteGuard], $IV$IncompleteGuard = True];
If[!ValueQ[$IV$FTDeriveCap],     $IV$FTDeriveCap = 60];
If[!ValueQ[$IV$FTVerbose],       $IV$FTVerbose = False];
If[!ValueQ[$IV$FTNonlinear],     $IV$FTNonlinear = False];  (* cof10 workbench only *)
$IV$FibGCache = <||>;      (* L1: {g, fibVars, restrFits} -> fibbed *)
$IV$FibGCacheLams = <||>;  (* L1 key -> lambda rules minted for that entry *)
$IV$FibTemplates = <||>;   (* L2: shapeKey -> <|"RHS","Status"|> *)
$IV$FibInstOK = <||>;      (* {shapeKey, slotKey} -> True (ginsh-validated) *)
$IV$FTStats = <|"L1" -> 0, "L2" -> 0, "Derived" -> 0, "DirectG" -> 0,
  "Validated" -> 0, "VFail" -> 0, "Stock" -> 0|>;
IV$FTStat[k_] := ($IV$FTStats[k] = Lookup[$IV$FTStats, k, 0] + 1);
IV$FibTemplateStats[] := $IV$FTStats;

IV$FTRationalQ[c_] := MatchQ[c, _Integer | _Rational] ||
  MatchQ[c, Complex[a_, b_] /; MatchQ[a, _Integer | _Rational] &&
    MatchQ[b, _Integer | _Rational]];

(* shape of one G wrt fibVars: {absG, slotRules, fvRules} or $Failed.
   slotRules: IVfts# -> concrete coefficient; fvRules: IVftv# -> actual var. *)
IV$FibShape[g_G, fibVars_List] := Module[
  {args = List @@ g, fvSyms, fvRules, slotIdx = <||>, slotVals = <||>,
   nSlot = 0, slotOf, mkPoly, absArgs, bad = False},
  fvSyms = Table[Symbol["IVftv" <> ToString[k]], {k, Length[fibVars]}];
  fvRules = Thread[fvSyms -> fibVars];
  slotOf[c_] := Module[{k = ToString[InputForm[c]]},
    If[!KeyExistsQ[slotIdx, k],
      nSlot++; slotIdx[k] = Symbol["IVfts" <> ToString[nSlot]];
      slotVals[slotIdx[k]] = c];
    slotIdx[k]];
  mkPoly[poly_, c0_] := Module[{cr = CoefficientRules[poly, fibVars]},
    Total[Function[r, Module[{c = Together[r[[2]]/c0]},
      (Times @@ (fvSyms^r[[1]])) *
        If[IV$FTRationalQ[c], c, slotOf[c]]]] /@ cr]];
  absArgs = Function[a, Module[{t, num, den, c0},
    Which[
      FreeQ[a, Alternatives @@ fibVars],
        If[IV$FTRationalQ[a], a, slotOf[a]],
      True,
        t = Together[a]; num = Expand[Numerator[t]]; den = Expand[Denominator[t]];
        If[!PolynomialQ[num, fibVars] || !PolynomialQ[den, fibVars],
          bad = True; 0,
          c0 = (First[Sort[CoefficientRules[den, fibVars]]])[[2]];
          mkPoly[num, c0]/mkPoly[den, c0]]]]] /@ args;
  If[bad, Return[$Failed]];
  {G @@ absArgs, Normal[slotVals], fvRules}]

(* value list for validation/derivation: fit values restricted to syms in e *)
IV$FTRestrictFits[fitList_List, e_] := Select[fitList, !FreeQ[e, #[[1]]] &];

(* ginsh check that inst == g at the fit point; True/False/Indeterminate *)
IV$FTValidate[g_, inst_, fitList_List] := Module[{sub, a, b},
  sub = fitList;
  a = Quiet@TimeConstrained[Ginsh[IV$GinshSafe[g /. sub], {}], 30, $Failed];
  b = Quiet@TimeConstrained[Ginsh[IV$GinshSafe[inst /. sub], {}], 30, $Failed];
  If[!NumericQ[a] || !NumericQ[b], Return[Indeterminate]];
  Abs[a - b] <= 10^-8 Max[1, Abs[a]]]

(* per-G fibration through the caches; $Failed -> caller must use stock path *)
IV$FibG[g_G, fibVars_List, fitList_List] := Module[
  {restr, k1, shape, absG, slotRules, fvRules, key, slotKey, tpl, rhs, inst,
   directG, fits, ok},
  restr = IV$FTRestrictFits[fitList, g];
  k1 = {g, fibVars, restr};
  If[KeyExistsQ[$IV$FibGCache, k1], IV$FTStat["L1"];
    (* re-export any lambda rules minted when this entry was first built *)
    If[KeyExistsQ[$IV$FibGCacheLams, k1],
      $IV$FTNewLamRules = Join[$IV$FTNewLamRules, $IV$FibGCacheLams[k1]]];
    Return[$IV$FibGCache[k1]]];
  directG := Module[{d = Quiet@CheckAbort[TimeConstrained[
      Check[ToFibrationBasis[g, fibVars, FitValue -> fitList], $Failed],
      $IV$FTDeriveCap, $Failed], $Failed], n0},
    If[IV$FTFibDoneQ[d, fibVars],
      IV$FTStat["DirectG"]; $IV$FibGCache[k1] = d,
      (* increment-2 fallbacks: nonlinear rational letters (notebook routes).
         DEFAULT OFF ($IV$FTNonlinear): the 2-pt gates are REGION-LOCAL and a
         reconstruction valid on one side of an interior letter zero can be
         integrated ACROSS the zero — produced a certified-WRONG ep0 cof6 on
         2026-07-11. Enable explicitly for the cof10 workbench only. *)
      If[TrueQ[$IV$FTNonlinear],
        n0 = Length[$IV$FTNewLamRules];
        d = Quiet[IV$FibW1Log[g, fibVars, fitList]];
        If[d === $Failed,
          d = Quiet[IV$FibW2Moebius[g, fibVars, fitList]]];
        If[d =!= $Failed && !IV$HasFrozenTermsQ[d],
          If[Length[$IV$FTNewLamRules] > n0,
            $IV$FibGCacheLams[k1] = Drop[$IV$FTNewLamRules, n0]];
          $IV$FibGCache[k1] = d, $Failed],
        $Failed]]];
  shape = Quiet@Check[IV$FibShape[g, fibVars], $Failed];
  If[shape === $Failed, Return[directG]];
  {absG, slotRules, fvRules} = shape;
  key = ToString[InputForm[absG]];
  slotKey = ToString[InputForm[Sort[slotRules]]];
  tpl = Lookup[$IV$FibTemplates, key, None];
  If[AssociationQ[tpl] && tpl["Status"] === "bad", Return[directG]];
  If[tpl === None,
    (* derive template at THIS instance's numeric point *)
    fits = Join[
      (#[[1]] -> (#[[1]] /. fvRules /. IV$FTAllFits[fitList])) & /@ fvRules,
      (#[[1]] -> Quiet@N[#[[2]] /. IV$FTAllFits[fitList]]) & /@ slotRules];
    If[!AllTrue[fits[[All, 2]], NumericQ], Return[directG]];
    rhs = Quiet@CheckAbort[TimeConstrained[
      Check[ToFibrationBasis[absG, Join[fvRules[[All, 1]], slotRules[[All, 1]]],
        FitValue -> fits], $Failed], $IV$FTDeriveCap, $Failed], $Failed];
    If[!IV$FTFibDoneQ[rhs, fvRules[[All, 1]]],
      $IV$FibTemplates[key] = <|"Status" -> "bad"|>; Return[directG]];
    $IV$FibTemplates[key] = <|"Status" -> "ok", "RHS" -> rhs|>;
    IV$FTStat["Derived"];
    If[TrueQ[$IV$FTVerbose], Print["[FibT] derived template ", key]];
    tpl = $IV$FibTemplates[key]];
  inst = tpl["RHS"] /. fvRules /. slotRules;
  IV$FTStat["L2"];
  (* NEW (shape, slots) instances are returned TAGGED; IV$FibExpr validates
     all new instances of one call in a single batched ginsh check (per-G
     ginsh pairs are too expensive on many-G expressions) and only then
     commits them to the caches. *)
  If[!KeyExistsQ[$IV$FibInstOK, {key, slotKey}],
    Return[IVftNeedsVal[inst, g, {key, slotKey}, k1]]];
  $IV$FibGCache[k1] = inst]

(* ---- 6C4b: nonlinear-argument fallbacks (increment 2, 2026-07-11) ----
   Port of the 3-prop notebook's reconstruction machinery for G's whose
   letters are RATIOS in the integration variable (PLT's fibration refuses:
   "Alphabet is not linear").  Both fallbacks return the x-DEPENDENT
   fibration identity for the G (NOT a definite integral) and are gated by a
   TWO-POINT ginsh validation, so a wrong branch can never leak.
   New lambda rules minted here are drained by IV$IntegrateStepCore via
   $IV$FTNewLamRules (the main loop then adds fits for later steps). *)

$IV$FTNewLamRules = {};
IV$FTDrainLams[] := Module[{r = $IV$FTNewLamRules}, $IV$FTNewLamRules = {}; r];

(* session pool of NUMERIC fits for every lambda the template engine has
   minted: nested reconstructions meet letters containing lams from EARLIER
   passes whose values are not yet in the step fitList (they only reach
   paramFit at step end) — without these fits ToFibrationBasis' tail fit and
   the ginsh gates fail (observed on cof10, 2026-07-11). *)
$IV$FTLamFits = {};
IV$FTAllFits[fitList_List] := Join[fitList,
  Select[$IV$FTLamFits, FreeQ[fitList[[All, 1]], #[[1]]] &]];

(* structural gate: a fibrated-in-x expression may contain x ONLY as the
   final argument itself — not inside letters AND not inside a composite
   final argument like G[0, a+b x] (numeric equality does NOT imply this —
   a template instance can echo its input unchanged) *)
IV$FTInBasisQ[e_, x_] :=
  Cases[e, gg_G /; (!FreeQ[Most[List @@ gg], x] ||
      (!FreeQ[Last[List @@ gg], x] && Last[List @@ gg] =!= x)),
    {0, Infinity}] === {};

(* ---- THE ECHO GATE (2026-07-13, step C) ----
   ToFibrationBasis does NOT fail on a letter it cannot fibrate (a Moebius or
   quadratic-in-x rational argument).  It emits
       Fiber::Linear: ... Alphabet is not linear in x
   and returns the G **UNCHANGED** — no $Failed, no frozen head, no leftover
   ToFibrationBasis wrapper.  Testing only those three things therefore ACCEPTS an
   UNFIBRATED G as a success, and (worse) caches it as a good template.  The
   reconstruction fallbacks that CAN handle it — IV$FibW1Log / IV$FibW2Moebius,
   both already present — are then NEVER CALLED, and GIntegrate dies far downstream
   on frozen Gint[] placeholders.  That is precisely what blocked cof10: its
   G[0,wt1,1] (=var1) and G[wt2,wt1,1] (=var2) sailed straight through.

   "Did ToFibrationBasis deliver?" must be asked STRUCTURALLY: is the result
   actually in fibration basis w.r.t. the integration variable = First[fibVars]?
   If not, it is a no-op echo -> fall through to the reconstruction fallbacks.
   NB numeric validation CANNOT catch this: the echo is numerically equal to its
   input by construction. *)
IV$FTFibDoneQ[r_, fibVars_List] :=
  r =!= $Failed && !IV$HasFrozenTermsQ[r] && FreeQ[r, ToFibrationBasis] &&
    (Length[fibVars] < 1 || TrueQ[IV$FTInBasisQ[r, First[fibVars]]]);

(* two-point numeric equality gate: g == cand at x -> two values *)
IV$FTValidate2[g_, cand_, x_, fitList_List, lamFits_List, pts0_:Automatic] := Module[
  {pts, fv, subs, a, b, ok = True},
  (* validation points on the SAME SIDE as the fit value: fibration
     identities are region-valid; straddling a letter zero rejects correct
     results by a legitimate i-Pi difference (cof10 lesson, x2->0.5 zero) *)
  pts = If[pts0 =!= Automatic, pts0,
    fv = Quiet@N[x /. fitList];
    If[NumericQ[fv] && 1/25 < fv < 24/25,
      {Rationalize[7 fv/8, 1/1000], Rationalize[Min[9 fv/8, (1 + fv)/2], 1/1000]},
      {37/100, 61/100}]];
  subs = IV$FTAllFits[Join[DeleteCases[fitList, (x -> _)], lamFits]];
  Do[
    a = Quiet@TimeConstrained[Ginsh[IV$GinshSafe[(g /. x -> p) /. subs], {}], 30, $Failed];
    b = Quiet@TimeConstrained[Ginsh[IV$GinshSafe[(cand /. x -> p) /. subs], {}], 30, $Failed];
    If[!NumericQ[a] || !NumericQ[b] || Abs[a - b] > 10^-8 Max[1, Abs[a]],
      ok = False; Break[]],
    {p, pts}];
  ok]

(* recursive Log splitting (the notebook's preprocessing rules) *)
IV$FTSplitLog[e_] := FixedPoint[Function[u, u //. {
    Log[a_ b_] :> Log[a] + Log[b],
    Log[a_^n_Integer] :> n Log[a],
    Log[a_ / b_] :> Log[a] - Log[b]}], e];

(* weight-1 with nonlinear rational letter: G[a(x),1] = -Log[1-1/a],
   G[0,a(x)] = Log[a].  Factor the Log argument (ratio quadratics typically
   cancel, as in the notebook), split, fibrate the Log sum. *)
IV$FibW1Log[g_G, fibVars_List, fitList_List] := Module[
  {x, larg, lg, fib, args = List @@ g, newLams = {}, newFits = {}, fvTries},
  If[Length[fibVars] < 1, Return[$Failed]];
  x = First[fibVars];
  If[TrueQ[$IV$FTVerbose], Print["[FibT][W1] enter ", Short[g, 2], " x=", x]];
  Which[
    (* PLT convention: G[a,1] = Log[1 - 1/a]  (sign verified vs ginsh) *)
    Length[args] === 2 && args[[2]] === 1 && !FreeQ[args[[1]], x],
      larg = Together[1 - 1/args[[1]]]; lg = Log[larg],
    Length[args] === 2 && args[[1]] === 0 && !FreeQ[args[[2]], x],
      larg = Together[args[[2]]]; lg = Log[larg],
    True,
      If[TrueQ[$IV$FTVerbose], Print["[FibT][W1] shape mismatch"]];
      Return[$Failed]];
  (* other symbols in the letters (kinematics OR later integration vars) are
     SPECTATORS of the x-fibration — no restriction needed; the two-point
     ginsh gate protects correctness (guard relaxed 2026-07-11: the original
     Rest[fibVars]-free requirement blocked ALL real isLast calls, whose
     fibVars include the kinematics) *)
  lg = IV$FTSplitLog[lg /. Log[z_] :> Log[Factor[z]] /.
    Log[z_] :> Log[Numerator[z]] - Log[Denominator[z]]];
  (* quadratic-in-x Log arguments: exact lambda root split
     Log[quad] -> Log[scale] + Log[x+la] + Log[x+lb]; possible 2 Pi I branch
     offsets are caught by the 2-pt gate below *)
  lg = lg /. Log[z_] /; (!FreeQ[z, x] && PolynomialQ[z, x] && Exponent[z, x] == 2) :>
    Module[{d = IV$LambdaData[z, x], lfits},
      lfits = Select[(#[[1]] -> Quiet@N[#[[2]] /. IV$FTAllFits[fitList]]) & /@
        d["Rules"], NumericQ[#[[2]]] &];
      If[Length[lfits] < 2, Log[z],
        newLams = Join[newLams, d["Rules"]]; newFits = Join[newFits, lfits];
        $IV$FTLamFits = Join[$IV$FTLamFits, lfits];
        Log[d["Scale"]] + Log[d["L1Sym"] + x] + Log[d["L2Sym"] + x]]];
  (* only proceed if every remaining Log argument is linear in x *)
  If[!AllTrue[Cases[lg, Log[z_] :> z, {0, Infinity}],
      (FreeQ[#, x] || (PolynomialQ[#, x] && Exponent[#, x] <= 1)) &],
    If[TrueQ[$IV$FTVerbose], Print["[FibT][W1] nonlinear log args in ", x, ": ",
      Short[Cases[lg, Log[z_] :> z, {0, Infinity}], 3]]];
    Return[$Failed]];
  (* the step's fit value for x can sit ON a letter zero (x2->0.5 hit one on
     cof10) — retry the whole fibrate+validate cycle at perturbed fit points,
     validating each variant at points on ITS OWN side of the fit *)
  fvTries = Module[{base = IV$FTAllFits[Join[fitList, newFits]]},
    {base,
     (If[#[[1]] === x, x -> 29/100, #] & /@ base),
     (If[#[[1]] === x, x -> 43/100, #] & /@ base),
     (If[#[[1]] === x, x -> 71/100, #] & /@ base)}];
  fib = $Failed;
  Do[Module[{cand, xfv, pts, subs, d1, d2, k},
    cand = Quiet@CheckAbort[TimeConstrained[
      Check[ToFibrationBasis[lg, fibVars, FitValue -> fv], $Failed],
      $IV$FTDeriveCap, $Failed], $Failed];
    If[cand =!= $Failed && !IV$HasFrozenTermsQ[cand],
      xfv = Quiet@N[x /. fv];
      pts = If[NumericQ[xfv] && 1/25 < xfv < 24/25,
        {Rationalize[7 xfv/8, 1/1000], Rationalize[Min[9 xfv/8, (1 + xfv)/2], 1/1000]},
        {37/100, 61/100}];
      If[IV$FTValidate2[g, cand, x, Join[fitList, newFits], {}, pts],
        fib = cand,
        (* constant 2 Pi I k branch offset from the Log split: repair *)
        subs = IV$FTAllFits[DeleteCases[Join[fitList, newFits], (x -> _)]];
        d1 = Quiet@TimeConstrained[Ginsh[IV$GinshSafe[((cand - g) /. x -> pts[[1]]) /. subs], {}], 30, $Failed];
        d2 = Quiet@TimeConstrained[Ginsh[IV$GinshSafe[((cand - g) /. x -> pts[[2]]) /. subs], {}], 30, $Failed];
        If[NumericQ[d1] && NumericQ[d2] && Abs[d1 - d2] < 10^-8 (1 + Abs[d1]) &&
           Abs[Re[d1]] < 10^-8 (1 + Abs[d1]),
          k = Round[Im[d1]/(2 Pi)];
          If[k != 0 && Abs[Im[d1] - 2 Pi k] < 10^-8 (1 + Abs[d1]),
            cand = cand - 2 Pi I k;
            If[IV$FTValidate2[g, cand, x, Join[fitList, newFits], {}, pts],
              If[TrueQ[$IV$FTVerbose],
                Print["[FibT][W1] repaired 2 Pi I branch offset (k=", k, ") for ", Short[g, 2]]];
              fib = cand]]]]];
    If[fib =!= $Failed, Break[]]],
    {fv, fvTries}];
  If[fib === $Failed,
    If[TrueQ[$IV$FTVerbose], Print["[FibT][W1] all fit tries failed for ",
      Short[g, 2], " in ", x]];
    Return[$Failed]];
  If[newLams =!= {}, $IV$FTNewLamRules = Join[$IV$FTNewLamRules, newLams]];
  IV$FTStat["W1Log"];
  fib]

(* weight-2 with x-dependent (Moebius/rational) letters: G[wt2(x),wt1(x),1].
   Notebook reconstruction: pt1 = d/dx G (DG trick, weight-1 pieces) ->
   fibrate pieces (recursion into IV$FibG + IV$FibW1Log) -> lambda-factor ->
   PF -> termm1 = antiderivative -> fibbed(x) = G(x0) + termm1(x) - termm1(x0)
   at a REGULAR base point x0 (0, -1, 2 ladder — NOT the singular endpoint). *)
IV$FibW2Moebius[g_G, fibVars_List, fitList_List] := Catch[Module[
  {x, args = List @@ g, wt2, wt1, inner, f, df, pt1, gw1s, lamRules = {},
   lamFits = {}, fits2, termm1, fibbed, w2v, w1v, g0, t10, okBase},
  If[Length[fibVars] < 1, Throw[$Failed, IVftW2]];
  x = First[fibVars];
  If[Length[args] =!= 3 || args[[3]] =!= 1, Throw[$Failed, IVftW2]];
  wt2 = args[[1]]; wt1 = args[[2]];
  If[FreeQ[{wt2, wt1}, x], Throw[$Failed, IVftW2]];
  (* non-x symbols in the letters are spectators — see IV$FibW1Log note *)
  (* d/dx of the G via DG (weight-1 output). $IterationLimit = Infinity is
     required here (notebook In[33]) but SCOPED — global Infinity slows
     certified solves ~5x and distorts route selection. *)
  inner = Quiet[GIntegrate[1/(Global`t1DGvar - wt1), Global`t1DGvar]];
  f = 1/(Global`t2DGvar - wt2) (inner /. Global`t1DGvar -> Global`t2DGvar);
  df = Quiet[DG[f, x]];
  pt1 = Quiet@CheckAbort[TimeConstrained[
    Block[{$IterationLimit = Infinity},
      ShuffleRegulate[GIntegrate[df, Global`t2DGvar] /. Global`t2DGvar -> 1]],
    $IV$FTDeriveCap, $Failed], $Failed];
  If[pt1 === $Failed || !FreeQ[pt1, Global`t2DGvar] || IV$HasFrozenTermsQ[pt1],
    Throw[$Failed, IVftW2]];
  pt1 = pt1 /. HPL[{1}, 1] -> 0;
  (* fibrate the weight-1 pieces (recursion: Moebius -> templates, ratio -> W1Log) *)
  gw1s = DeleteDuplicates@Cases[pt1, gg_G /; !FreeQ[gg, x], {0, Infinity}];
  Do[Module[{fg = Quiet[IV$FibG[gw, {x}, fitList]]},
      fg = fg /. IVftNeedsVal[i_, _, _, _] :> i;
      (* template instances arrive UNVALIDATED on this direct path — gate
         each individually, BOTH numerically and STRUCTURALLY (an instance
         can echo its input: numerically equal yet unfibrated); on failure
         retry via the Log route *)
      If[fg =!= $Failed && (!TrueQ[IV$FTInBasisQ[fg, x]] ||
          !TrueQ[IV$FTValidate2[gw, fg, x, fitList, {}]]),
        If[TrueQ[$IV$FTVerbose], Print["[FibT][W2] piece failed instance gate: ", Short[gw, 2]]];
        fg = $Failed];
      If[fg === $Failed,
        fg = Quiet[IV$FibW1Log[gw, {x}, fitList]];
        If[fg =!= $Failed && !TrueQ[IV$FTInBasisQ[fg, x]], fg = $Failed]];
      If[fg === $Failed,
        If[TrueQ[$IV$FTVerbose], Print["[FibT][W2] piece unfibrable: ", Short[gw, 2],
          "  [x=", x, ", head=", Head[gw], ", args=", Length[List @@ gw],
          ", xfit=", Quiet@N[x /. fitList], "]"]];
        Throw[$Failed, IVftW2]];
      pt1 = pt1 /. gw -> fg],
    {gw, gw1s}];
  If[TrueQ[$IV$FTVerbose], Print["[FibT][W2] pieces fibrated, pt1 LC=", LeafCount[pt1]]];
  (* Together each G-coefficient FIRST: after the piece substitutions the
     coefficients are sums of fractions, whose Denominator is 1 — the lambda
     polynomial-division replacer silently skips those (observed 2026-07-11) *)
  pt1 = Quiet[
    Collect[pt1 /. {G -> Global`GPL$W2}, Global`GPL$W2[__], Together] /.
      {Global`GPL$W2 -> G}];
  (* lambda-factor quadratic denominators in x; export rules to the caller.
     TWO passes with a re-Together between them: PF/Together can expose
     quadratics the first pass missed (raw quadratics observed surviving one
     pass into GIntegrate on cof10) *)
  Module[{lr = Quiet[IV$ApplyLambdas[pt1, x, False]], lr2},
    pt1 = lr[[1]]; lamRules = lr[[2]];
    If[Length[Quiet[IV$FindQuadratics[
        pt1 /. G -> Global`GG$w2probe, x]]] > 0,
      pt1 = Quiet[
        Collect[pt1 /. {G -> Global`GPL$W2}, Global`GPL$W2[__], Together] /.
          {Global`GPL$W2 -> G}];
      lr2 = Quiet[IV$ApplyLambdas[pt1, x, False]];
      pt1 = lr2[[1]]; lamRules = Join[lamRules, lr2[[2]]]]];
  If[Length[lamRules] > 0,
    lamFits = Select[(#[[1]] -> Quiet@N[#[[2]] /. IV$FTAllFits[fitList]]) & /@ lamRules,
      NumericQ[#[[2]]] &];
    If[Length[lamFits] < Length[lamRules], Throw[$Failed, IVftW2]];
    (* pool the fits so NESTED reconstructions meeting these lam symbols in
       their letters can evaluate them *)
    $IV$FTLamFits = Join[$IV$FTLamFits, lamFits]];
  fits2 = Join[fitList, lamFits];
  (* PF the rational prefactors, then antiderivative *)
  pt1 = Quiet[
    Collect[pt1 /. {G -> Global`GPL$W2}, Global`GPL$W2[__],
      (ApartSquareFree[#, x] &)] /. {Global`GPL$W2 -> G}];
  If[TrueQ[$IV$FTVerbose], Print["[FibT][W2] lambdas=", Length[lamRules],
    ", post-PF LC=", LeafCount[pt1]]];
  termm1 = Quiet@CheckAbort[TimeConstrained[
    Block[{$IterationLimit = Infinity}, GIntegrate[pt1, x]],
    2 $IV$FTDeriveCap, $Failed], $Failed];
  If[termm1 === $Failed || IV$HasFrozenTermsQ[termm1],
    If[TrueQ[$IV$FTVerbose], Print["[FibT][W2] GIntegrate failed/frozen: ",
      If[termm1 === $Failed, "$Failed", Short[termm1, 3]]]];
    Throw[$Failed, IVftW2]];
  termm1 = Quiet[
    (ExtractZeroes[termm1] // ShuffleRegulate) /. HPL[{1}, 1] :> 0];
  If[TrueQ[$IV$FTVerbose], Print["[FibT][W2] termm1 LC=", LeafCount[termm1]]];
  (* base-point ladder: x0 regular for the letters AND for termm1 *)
  Do[
    okBase = True;
    w2v = Quiet[Together[wt2 /. x -> x0]];
    w1v = Quiet[Together[wt1 /. x -> x0]];
    If[w2v === $Failed || w1v === $Failed ||
       !NumericQ[Quiet@N[w2v /. IV$FTAllFits[fitList]]] ||
       !NumericQ[Quiet@N[w1v /. IV$FTAllFits[fitList]]],
      okBase = False];
    If[okBase,
      g0 = Quiet[
        (ExtractZeroes[G[w2v, w1v, 1]] // ShuffleRegulate) /. HPL[{1}, 1] :> 0];
      t10 = Quiet[
        (ExtractZeroes[termm1 /. x -> x0] // ShuffleRegulate) /. HPL[{1}, 1] :> 0];
      If[g0 === $Failed || t10 === $Failed ||
         IV$HasFrozenTermsQ[g0] || IV$HasFrozenTermsQ[t10],
        okBase = False]];
    If[TrueQ[$IV$FTVerbose], Print["[FibT][W2] base ", x0, " okBase=", okBase]];
    If[okBase,
      fibbed = g0 + termm1 - t10;
      If[IV$FTValidate2[g, fibbed, x, fits2, lamFits],
        $IV$FTNewLamRules = Join[$IV$FTNewLamRules, lamRules];
        IV$FTStat["W2DG"];
        If[TrueQ[$IV$FTVerbose],
          Print["[FibT] W2 reconstruction OK at base ", x0, " for ", Short[g, 2]]];
        Throw[fibbed, IVftW2],
        If[TrueQ[$IV$FTVerbose], Print["[FibT][W2] base ", x0, " failed 2-pt validation"]]]],
    {x0, {0, -1, 2}}];
  Throw[$Failed, IVftW2]], IVftW2]

(* expression-level entry: fibrate all G's through the caches, reassemble.
   All NEW template instances of this call are validated in ONE batched ginsh
   check (weighted sum, prime weights against accidental cancellation).
   $Failed -> caller runs the stock whole-expression ToFibrationBasis. *)
IV$FibExpr[expr_, fibVars_List, fitList_List] := Module[
  {gs, res, fibbed, pend, a, b, wsO, wsN},
  If[!IV$TemplatesOnQ[], Return[$Failed]];
  If[FreeQ[expr, _G], Return[$Failed]];
  (* other transcendental heads depending on fibVars need the stock converter *)
  If[!FreeQ[expr /. _G :> IVftGone,
      (h : (Log | PolyLog | HPL | Li))[a___] /; !FreeQ[{a}, Alternatives @@ fibVars]],
    IV$FTStat["Stock"]; Return[$Failed]];
  gs = DeleteDuplicates@Cases[expr, _G, {0, Infinity}];
  If[gs === {}, Return[$Failed]];
  (* nested G's inside G-arguments: shape logic unsound there -> stock *)
  If[AnyTrue[gs, !FreeQ[List @@ #, _G] &], IV$FTStat["Stock"]; Return[$Failed]];
  fibbed = Quiet[IV$FibG[#, fibVars, fitList]] & /@ gs;
  If[MemberQ[fibbed, $Failed], IV$FTStat["Stock"]; Return[$Failed]];
  (* batched validation of the new instances *)
  pend = Cases[fibbed, _IVftNeedsVal];
  If[pend =!= {},
    wsO = Sum[Prime[k + 2] pend[[k, 2]], {k, Length[pend]}];
    wsN = Sum[Prime[k + 2] pend[[k, 1]], {k, Length[pend]}];
    a = Quiet@TimeConstrained[Ginsh[IV$GinshSafe[wsO /. IV$FTAllFits[fitList]], {}], 60, $Failed];
    b = Quiet@TimeConstrained[Ginsh[IV$GinshSafe[wsN /. IV$FTAllFits[fitList]], {}], 60, $Failed];
    If[!NumericQ[a] || !NumericQ[b] || Abs[a - b] > 10^-8 Max[1, Abs[a]],
      IV$FTStat["VFail"]; IV$FTStat["Stock"];
      If[TrueQ[$IV$FTVerbose],
        Print["[FibT] batch validation failed (", Length[pend], " instances): ",
          {a, b}]];
      Return[$Failed]];
    IV$FTStat["Validated"];
    Scan[($IV$FibInstOK[#[[3]]] = True; $IV$FibGCache[#[[4]]] = #[[1]]) &, pend];
    fibbed = fibbed /. IVftNeedsVal[inst_, _, _, _] :> inst];
  res = expr /. Thread[gs -> fibbed];
  res]

(* --- 6D: Boundary Evaluation with Etta Fallback --- *)

(* Round (double-pole fix, 2026-06-15): the previous version applied
   IV$RegularizeDivergentG (which ZEROES any GPL whose weight diverges at the
   endpoint) BEFORE both the direct path and the etta fallback.  For a double
   endpoint pole 1/(x-1)^2 the antiderivative carries a FINITE boundary part in
   a singular-looking GPL; zeroing it drops exactly that finite part (the k=0
   mode, a rational -n! for Int Log[x]^n/(x-1)^2 = n! Zeta[n]).  Fix: only trust
   the pre-zeroed direct endpoint value when nothing was discarded; otherwise
   take the etta finite part from the ORIGINAL antiderivative `ad` (divergent
   GPLs intact, regularized via x -> hi-et), so Series[...,{et,0,0}] recovers
   the finite boundary contribution.  Simple poles are unchanged (they do not
   trigger the zeroing). *)
(* ---- NOTEBOOK BOUNDARY EVALUATION (2026-07-13, step B) ----
   The user's notebook evaluates the boundary directly (In[197]):
     temp4 = ((GIntegrate[.., x2] /. x2 -> 1) // ShuffleRegulate) /. HPL[{1},1] :> 0
   i.e. substitute the endpoint, let ShuffleRegulate expose the endpoint divergence
   as HPL[{1},1], and drop it (it cancels).

   GIntegrate normalises the antiderivative as Integrate[.., {x,0,x}], so F(0) = 0
   BY CONSTRUCTION and the definite integral over [0,hi] is just F(hi) — which is why
   the notebook writes only the x2 -> 1 term.  Substituting x -> 0 naively instead
   gives ComplexInfinity whenever the integrand has a pole at 0.

   This is a FALLBACK ONLY: IV$EvalDefinite stays the primary, certified path and is
   tried first every time.  It exists because IV$EvalDefinite's Series/etta endpoint
   machinery does not merely fail on a very large antiderivative — it ABORTS, taking
   the whole step with it (cof10: a clean 90k-leaf antiderivative, then the step died).
   NB deliberately NO TimeConstrained cap on IV$EvalDefinite: a 300 s cap I once put
   there silently killed ep0 cof6.  CheckAbort is the only protection needed. *)
IV$BoundaryNotebook[ad_, x_, lo_, hi_, reg_] := Module[{h, l, bad},
  bad[v_] := v === $Failed || !FreeQ[v, Indeterminate] ||
    !FreeQ[v, ComplexInfinity] || !FreeQ[v, DirectedInfinity] ||
    IV$HasFrozenTermsQ[v];
  h = Quiet@TimeConstrained[
    ShuffleRegulate[ad /. x -> hi] /. HPL[{1}, 1] :> reg, 300, $Failed];
  If[bad[h], Return[$Failed]];
  If[TrueQ[lo === 0] || TrueQ[Quiet[PossibleZeroQ[lo]]], Return[h]];
  l = Quiet@TimeConstrained[
    ShuffleRegulate[ad /. x -> lo] /. HPL[{1}, 1] :> reg, 300, $Failed];
  If[bad[l], Return[$Failed]];
  h - l];

(* Exact endpoint normal forms needed by Laurent cancellation.  Series may
   emit arbitrary derivatives with respect to the final GPL argument; reduce
   them recursively with d/dz G[a1,...;z] = G[a2,...;z]/(z-a1). *)
IV$GArgDerivative[letters_List, z0_, n_Integer?Positive] := Module[
  {gargVar = Unique["garg"], value},
  value = G @@ Append[letters, gargVar];
  Do[value = DG[value, gargVar], {n}];
  value /. gargVar -> z0];

IV$ExpandGEndpointDerivatives[e_] := e //. HoldPattern[
    Derivative[orders__][G][args__]] /;
      Module[{os = {orders}}, Length[os] >= 1 &&
        AllTrue[Most[os], # === 0 &] && IntegerQ[Last[os]] &&
        Last[os] > 0] :>
    With[{os = {orders}, as = {args}},
      IV$GArgDerivative[Most[as], Last[as], Last[os]]];

IV$ExactRationalQ[q_] := IntegerQ[q] || Head[q] === Rational;
IV$PositiveRationalLog[q_?IV$ExactRationalQ] /; q > 0 := Module[{nf, df},
  nf = FactorInteger[Numerator[q]];
  df = FactorInteger[Denominator[q]];
  Total[(#[[2]] Log[#[[1]]]) & /@ nf] -
    Total[(#[[2]] Log[#[[1]]]) & /@ df]];

(* On a nonnegative endpoint path, nonpositive rational GPL letters are
   cut-free.  These formulas cover the distinct, repeated, and zero-letter
   weight-two cases.  They are intentionally undefined outside that domain:
   a branch-sensitive expression must remain visible and make a cancellation
   gate fail instead of being normalized under an unproved continuation. *)
IV$RealRationalW2[a_?IV$ExactRationalQ, b_?IV$ExactRationalQ,
    z_?IV$ExactRationalQ] /; a < 0 && b < 0 && z > 0 :=
  Module[{w2U = 1 - z/b, w2C = 1 - a/b},
    (* w2U>1 and w2C<1, hence both 1-w2C/w2U and the dilogarithm arguments
       stay off [1,Infinity).  This manifestly real form avoids relying on
       cancellation among three separate principal-branch imaginary parts. *)
    Log[w2U]^2/2 + Log[w2U] Log[1 - w2C/w2U] -
      PolyLog[2, w2C/w2U] + PolyLog[2, w2C]];
IV$RealRationalW2[0, b_?IV$ExactRationalQ,
    z_?IV$ExactRationalQ] /; b < 0 && z > 0 :=
  -PolyLog[2, z/b];
IV$RealRationalW2[a_?IV$ExactRationalQ, 0,
    z_?IV$ExactRationalQ] /; a < 0 && z > 0 :=
  Log[z] Log[1 - z/a] + PolyLog[2, z/a];
IV$RealRationalW2[0, 0, z_?IV$ExactRationalQ] /; z > 0 :=
  Log[z]^2/2;

IV$ExactConstantNormalize[e_] := Module[{r},
  r = e /. {
    G[a_?IV$ExactRationalQ, z_?IV$ExactRationalQ] /;
        a < 0 && z > 0 :> Log[1 - z/a],
    G[a_?IV$ExactRationalQ, b_?IV$ExactRationalQ,
        z_?IV$ExactRationalQ] /;
        a <= 0 && b <= 0 && z > 0 :>
      IV$RealRationalW2[a, b, z]};
  r = r /. PolyLog[2, q_?IV$ExactRationalQ] /; q < -1 :>
    -PolyLog[2, 1/q] - Pi^2/6 - Log[-q]^2/2;
  r = r /. Log[q_?IV$ExactRationalQ] /; q > 0 :>
    IV$PositiveRationalLog[q];
  Quiet@Collect[Expand[r], _G | _PolyLog, Together]];

(* Extract a finite endpoint value only after the COMPLETE Laurent/log sum is
   proved finite.  Coefficient[...,0] alone silently discards negative powers,
   and replacing HPL[{1},1] by zero silently discards an uncancelled log. *)
IV$CertifiedLaurentFinitePart[expr_, et_, reg_] := Module[
  {expanded, logVar = Unique["endpointLog"], laurent, shifted, minPower,
   poleCoefficients, poleCanonical, constant, logCoefficients, logCanonical,
   result},
  expanded = Quiet@Check[Expand[expr], $Failed];
  If[expanded === $Failed, Return[$Failed]];
  If[SameQ[expanded, 0], Return[0]];
  laurent = Expand[expanded /. Log[et] -> logVar];
  minPower = Quiet@Check[Exponent[laurent, et, Min], $Failed];
  If[! IntegerQ[minPower], Return[$Failed]];
  shifted = Quiet@Check[Expand[laurent et^(-minPower)], $Failed];
  (* This routine accepts only an explicit, finite Laurent/log polynomial,
     normally Normal[Series[...]].  A rational tail, fractional power, nested
     Log[c et], or unresolved GPL dependence on et is not a certified series. *)
  If[shifted === $Failed || ! TrueQ[PolynomialQ[shifted, {et, logVar}]],
    Return[$Failed]];
  poleCoefficients = If[minPower < 0,
    Table[Quiet@Collect[Coefficient[laurent, et, k], _G, Together],
      {k, minPower, -1}], {}];
  poleCanonical = IV$ExactConstantNormalize /@ poleCoefficients;
  If[AnyTrue[poleCanonical, ! SameQ[#, 0] &], Return[$Failed]];
  constant = Quiet@Collect[Coefficient[laurent, et, 0], _G, Together];
  If[! TrueQ[PolynomialQ[constant, logVar]], Return[$Failed]];
  logCoefficients = Rest[CoefficientList[constant, logVar]];
  logCanonical = IV$ExactConstantNormalize /@ logCoefficients;
  If[AnyTrue[logCanonical, ! SameQ[#, 0] &], Return[$Failed]];
  constant = IV$ExactConstantNormalize[Coefficient[constant, logVar, 0]];
  If[! FreeQ[constant,
      et | logVar | Log[et] | Derivative | Indeterminate |
        ComplexInfinity | DirectedInfinity], Return[$Failed]];
  If[SameQ[reg, 0] &&
      ! FreeQ[constant,
        Alternatives[HoldPattern[HPL`HPL[{1}, 1]], HPL`Sinf]],
    Return[$Failed]];
  result = constant /. {
    HoldPattern[HPL`HPL[{1}, 1]] :> reg,
    HPL`Sinf :> reg};
  If[! FreeQ[result,
      et | logVar | Log[et] | Derivative | Indeterminate |
        ComplexInfinity | DirectedInfinity], Return[$Failed]];
  result]

(* F6a-v4 helper: peel leading letters equal to an endpoint via the shuffle identity, then replace the weight-1
   GPLs G[a;x] (a = endpoint) by explicit logarithms.  Terminates: each peel strictly shortens the run of leading
   endpoint letters.  Returns the expression unchanged on any failure. *)
IV$PeelEndpointLetters[ad_, x_, hi_, lo_] := IV$PeelEndpointLetters[ad, x, hi];   (* legacy 4-arg form *)
(* ONE endpoint per call: peeling both endpoints at once oscillates (G[1,0;x] <-> G[0,1;x]) and never terminates. *)
IV$PeelEndpointLetters[ad_, x_, ep_] := Module[{isEnd, peelOne, out, logOf, hi = ep, lo = ep},
  isEnd[a_] := TrueQ[Quiet[Simplify[a - ep] == 0]];
  peelOne[g : G[a_, w__, z_]] := Module[{sh, m, rest},
    sh = Quiet@Expand[ShuffleG[G[a, z] G[w, z]]];
    m = Quiet@Coefficient[sh, g];
    If[! IntegerQ[m] || m == 0, Return[g]];
    rest = Expand[sh - m g];
    Expand[(G[a, z] G[w, z] - rest)/m]];
  logOf[a_, z_] := If[TrueQ[Quiet[Simplify[a] == 0]], Log[z], Log[1 - z/a]];
  out = Quiet@Check[ad //. g : G[a_, w__, z_] /; z === x && isEnd[a] :> peelOne[g], $Failed];
  If[out === $Failed, Return[ad]];
  out = out /. G[a_, z_] /; z === x && isEnd[a] :> logOf[a, z];
  If[! FreeQ[out, ShuffleG], ad, out]];
IV$EvalDefinite[ad_, x_, lo_, hi_, reg_] := Module[
  {hE, lE, hV, lV, r, hChanged, lChanged, okQ},
  okQ[v_] := v =!= $Failed && FreeQ[v, Indeterminate] &&
    FreeQ[v, ComplexInfinity] && FreeQ[v, DirectedInfinity];
  hE = IV$RegularizeDivergentG[ad, x, hi];
  lE = IV$RegularizeDivergentG[ad, x, lo];
  hChanged = ! SameQ[hE, ad];
  lChanged = ! SameQ[lE, ad];
  hV = Quiet@TimeConstrained[Check[IV$RegBoundary[hE /. x -> hi], $Failed], 120, $Failed];
  lV = Quiet@TimeConstrained[Check[IV$RegBoundary[lE /. x -> lo], $Failed], 120, $Failed];
  (* Pre-zeroed direct path trusted only if no endpoint GPL was discarded. *)
  If[! hChanged && ! lChanged && okQ[hV] && okQ[lV],
    r = (hV - lV) /. HPL[{1}, 1] :> reg;
    If[okQ[r], Return[r]]];
  (* Etta fallback: use the ORIGINAL antiderivative, not hE/lE. *)
  Module[{et = Unique["et"], eHsub, eLsub, eH, eL, fin, fin2, cleanQ,
          zeroGtoLog, dGtoG, poleOrd, endpointSeries, adPH, adPL},
    cleanQ[v_] := okQ[v] && FreeQ[v, Derivative];
    (* Double-pole boundary terms produce G[0,..,0,hi-et]/et.  Series[] must know
       G[0^n,z]=Log[z]^n/n! to expand it; otherwise it emits a formal
       Derivative[..,1][G][..] (the arg-derivative of G) which leaks through as a
       spurious rational (the -n! that produced 36-2Pi^6/63 instead of -2Pi^6/63).
       Convert pure-zero GPLs to logs BEFORE the series, and convert any surviving
       formal G arg-derivative via the GPL holonomic rule
       d/dz G[a1,a2,..,an;z] = G[a2,..,an;z]/(z-a1). *)
    zeroGtoLog[e_] := e /. G[a__, z_] /;
        ({a} =!= {} && AllTrue[{a}, # === 0 &]) :> Log[z]^Length[{a}]/Length[{a}]!;
    dGtoG[e_] := IV$ExpandGEndpointDerivatives[e];
    (* F6a-v4 (2026-08-30): Mathematica's Series expands a GPL whose FIRST letter equals the endpoint (G[hi,w;hi-et])
       through formal derivatives at the singular point and silently drops the O(et) rational term (e.g.
       G[1,0,1-et]/et = (Zeta[2] - et)/et -> the -1 of the F6 "+1 offsets").  Peel every such leading letter with the
       shuffle identity G[a,w;z] = (G[a;z] G[w;z] - rest)/m and replace G[a;z] by its explicit logarithm; the remaining
       GPLs are analytic at the endpoint and the fast Series path is exact.  (v1-v3 routed the primitive to the
       exact ToFibrationBasis-in-et route, correct but 10-30x slower on deep folds -> MB9 regression timeouts.) *)
    adPH = Quiet@Check[IV$PeelEndpointLetters[ad, x, hi], ad];
    If[adPH === $Failed || IV$HasFrozenTermsQ[adPH], adPH = ad];
    adPL = Quiet@Check[IV$PeelEndpointLetters[ad, x, lo], ad];
    If[adPL === $Failed || IV$HasFrozenTermsQ[adPL], adPL = ad];
    eH = Quiet@TimeConstrained[Check[
      IV$RegBoundary[(adPH /. {G[y__, z_] /; z === x :> G[y, hi - et]} /. x -> (hi - et))], $Failed], 120, $Failed];
    eL = Quiet@TimeConstrained[Check[
      IV$RegBoundary[(adPL /. {G[y__, z_] /; z === x :> G[y, lo + et]} /. x -> (lo + et))], $Failed], 120, $Failed];
    If[eH =!= $Failed && eL =!= $Failed,
      fin = Quiet@TimeConstrained[Check[Module[{s},
        s = Series[zeroGtoLog[eH] - zeroGtoLog[eL], {et, 0, 0}];
        IV$CertifiedLaurentFinitePart[dGtoG[Normal[s]], et, reg]
      ], $Failed], 120, $Failed];
      If[cleanQ[fin], Return[fin]]];
    (* SECONDARY (higher-order poles): ToFibrationBasis over {et} + ExpandPolyLogs.
       Expands each G[w,hi-et] to the pole order so divergent log(et)/HPL[{1},1]
       pieces cancel across the sum before the et^0 coefficient is taken. *)
    eHsub = (ad /. {G[y__, z_] /; z === x :> G[y, hi - et]} /. x -> (hi - et));
    eLsub = (ad /. {G[y__, z_] /; z === x :> G[y, lo + et]} /. x -> (lo + et));
    poleOrd = Quiet@Check[
       Module[{rat = (eHsub - eLsub) /. _G -> 1},
         Max[1, Exponent[Denominator[Together[rat]], et]] + 1], 6];
    If[! IntegerQ[poleOrd] || poleOrd < 1 || poleOrd > 12, poleOrd = 6];
    endpointSeries[expr_] := Module[{fib},
       fib = Quiet@TimeConstrained[Check[
         ToFibrationBasis[ExtractZeroes[expr], {et}, FitValue -> {et -> 1/3}], $Failed], 120, $Failed];
       If[fib === $Failed, Return[$Failed]];
       fib = Quiet@Check[IV$RegBoundary[fib], $Failed];
       If[fib === $Failed, Return[$Failed]];
       Quiet@Check[ExpandPolyLogs[fib, {et, 0, poleOrd}, Assumptions -> 0 < et < 1], $Failed]];
    fin2 = Quiet@TimeConstrained[Check[Module[{sH, sL},
       sH = endpointSeries[eHsub]; sL = endpointSeries[eLsub];
       If[sH === $Failed || sL === $Failed, $Failed,
         IV$CertifiedLaurentFinitePart[
           Normal@Series[sH - sL, {et, 0, 0}], et, reg]]
     ], $Failed], 300, $Failed];
    If[cleanQ[fin2], Return[fin2]]];
  (* Last compatibility fallback: historic divergent-G zeroing path -- used ONLY when
     nothing was zeroed (hChanged/lChanged False), i.e. it agrees with the direct
     endpoint value.  When a GPL WAS zeroed, that path is UNSAFE (it drops finite
     boundary parts) and returning its value makes the CALLER ACCEPT a wrong result
     instead of retrying a different integration order -- e.g. -Log^5 t/(120(..))
     returned 1 instead of retrying to the correct value.  In that case return
     $Failed so the caller's order-rotation / MC-checked fallback finds a clean path. *)
  If[! hChanged && ! lChanged && okQ[hV] && okQ[lV],
    r = (hV - lV) /. HPL[{1}, 1] :> reg;
    If[okQ[r], Return[r]]];
  $Failed]

(* --- 6E0: DG-Based Weight Resolution (termm3/termm1 technique) --- *)

(* Resolve a single weight-2 GPL G[wt2(x), wt1(x), 1] where weights depend on x.
   Uses DG differentiation to move x from weight to argument position,
   then integrates and evaluates boundaries via etta regularization.

   Algorithm (from the 3-prop notebook):
   1. pt1 = GIntegrate[DG[1/(t2-wt2) * (GIntegrate[1/(t1-wt1), t1] /. t1->t2), x], t2] /. t2->1
      This computes d/dx G[wt2, wt1, 1] as weight-1 GPLs with x at argument position
   2. Fibrate each weight-1 G[f(x), 1] via ToFibrationBasis
   3. Lambda-factor any quadratic denominators in x
   4. termm1 = GIntegrate[fibrated_pt1, x] \[LongDash] the antiderivative
   5. Etta regularize: (termm3|_{x=1-etta} + termm1 - termm1|_{x=1-etta}) /. etta->0
   Returns the definite integral int_0^1 G[wt2, wt1, 1] * coeff dx *)

(* F2 (2026-08-29): the July definite-value DG route, kept as a FALLBACK for
   terms that the weight-1/2 reconstruction in IV$IntegrateStepCore cannot
   close (or closes only with lambda roots depending on a variable still to
   be integrated).  It is used only where multiplying the definite value by
   the coefficient IS the integral: the term must be
   (coefficient free of xa) x (ONE weight-2 variable-letter GPL), integrated
   over [0,1] (IV$DGResolveW2 is a [0,1] definite integral).  Lambda roots it
   mints must not depend on a not-yet-integrated variable.
   Returns {definiteValue, lambdaRules} or $Failed. *)
IV$DGDefiniteFallback[ft_, xa_, lo_, hi_, fitList_List, remainOrder_List,
    verbose_:False] := Module[{gpls, gpl, coeff, dgResult, val, lams},
  If[!(lo === 0 && hi === 1), Return[$Failed]];
  gpls = DeleteDuplicates@Cases[ft, g_G /; ! FreeQ[Most[List @@ g], xa],
    Infinity];
  If[Length[gpls] =!= 1, Return[$Failed]];
  gpl = First[gpls];
  If[Length[List @@ gpl] =!= 3 || Last[List @@ gpl] =!= 1, Return[$Failed]];
  coeff = Quiet@Together[ft/gpl];
  If[! FreeQ[coeff, xa], Return[$Failed]];
  dgResult = Quiet@CheckAbort[TimeConstrained[
    IV$DGResolveW2[gpl, xa, fitList, verbose], 600, $Failed], $Failed];
  If[dgResult === $Failed || ! ListQ[dgResult] || Length[dgResult] =!= 2,
    Return[$Failed]];
  {val, lams} = dgResult;
  If[val === $Failed || ! FreeQ[val, xa] || IV$HasFrozenTermsQ[val] ||
     ! ListQ[lams] ||
     (remainOrder =!= {} && ! FreeQ[lams, Alternatives @@ remainOrder]),
    Return[$Failed]];
  {coeff val, lams}];

IV$DGResolveW2[gpl_G, x_, fitList_List, verbose_:False] :=
Module[{args = List @@ gpl, wt1, wt2, z, inner, f, df, pt1,
        gw1s, fibPt1, lamResult, lamRules, termm1, etta,
        termm30, termm10, result},

  If[Length[args] != 3, Return[$Failed]];
  wt2 = args[[1]]; wt1 = args[[2]]; z = args[[3]];
  If[z =!= 1, Return[$Failed]]; (* only handle z=1 case *)
  If[FreeQ[wt1, x] && FreeQ[wt2, x], Return[$Failed]]; (* weights must depend on x *)

  If[verbose, Print["    [DG] Resolving G[",Short[wt2,2],", ",Short[wt1,2],", 1] via DG"]];

  (* Step 1: DG decomposition *)
  inner = Quiet[GIntegrate[1/(Global`t1DGvar - wt1), Global`t1DGvar]];
  f = 1/(Global`t2DGvar - wt2) * (inner /. Global`t1DGvar -> Global`t2DGvar);
  df = Quiet[DG[f, x]];
  pt1 = Quiet[GIntegrate[df, Global`t2DGvar]] /. Global`t2DGvar -> 1;

  If[verbose, Print["    [DG] d/dx has ", LeafCount[pt1], " leaves"]];

  (* Step 2: Fibrate each weight-1 G[f(x), 1] *)
  gw1s = Cases[pt1, G[a_, 1] /; !FreeQ[a, x], Infinity] // DeleteDuplicates;
  fibPt1 = pt1;
  Do[Module[{fib = Quiet[TimeConstrained[
      ToFibrationBasis[gw, {x}, FitValue -> fitList], 30, gw]]},
    If[fib =!= gw && fib =!= $Failed,
      fibPt1 = fibPt1 /. gw -> fib,
      (* Li1 fallback: G[a,1] = G[0, 1-a] - G[0, -a] *)
      Module[{a = gw[[1]], fL1, fL2},
        fL1 = Quiet[TimeConstrained[ToFibrationBasis[G[0, Together[1-a]], {x}, FitValue->fitList], 30, $Failed]];
        fL2 = Quiet[TimeConstrained[ToFibrationBasis[G[0, Together[-a]], {x}, FitValue->fitList], 30, $Failed]];
        If[fL1 =!= $Failed && fL2 =!= $Failed,
          fibPt1 = fibPt1 /. gw -> (fL1 - fL2);
          If[verbose, Print["    [DG] Li1: G[",Short[a,2],",1] -> fibrated"]]]]]
  ], {gw, gw1s}];

  If[verbose, Print["    [DG] After fibration: ", LeafCount[fibPt1], " leaves"]];

  (* Step 3: Lambda factorization on quadratic denominators *)
  {fibPt1, lamRules} = IV$ApplyLambdas[fibPt1, x, verbose];
  If[Length[lamRules] > 0,
    (* Add lambda fit values *)
    Module[{lamFits = Select[(#[[1]]->Quiet@N[#[[2]]/.fitList])& /@ lamRules, NumericQ[#[[2]]]&]},
      fitList = Join[fitList, lamFits]]];

  (* ApartSquareFree on coefficients *)
  fibPt1 = Quiet[Check[
    Collect[fibPt1 /. {G->Global`GPL$}, Global`GPL$[__], (ApartSquareFree[#,x]&)] /. {Global`GPL$->G},
    fibPt1]];

  (* Step 4: GIntegrate the DG result *)
  termm1 = Quiet[TimeConstrained[GIntegrate[fibPt1, x], 120, $Failed]];
  If[termm1 === $Failed,
    If[verbose, Print["    [DG] GIntegrate of DG result failed"]];
    Return[$Failed]];

  If[verbose, Print["    [DG] Antiderivative: ", LeafCount[termm1], " leaves"]];

  (* Step 5: Etta regularization *)
  etta = Unique["etta"];

  (* termm30: G[wt2, wt1, 1] evaluated at x = 1-etta *)
  termm30 = Quiet[TimeConstrained[
    Module[{gAtBnd = gpl /. x -> (1-etta)},
      (* Series expand in etta around 0, extract O(etta^0) *)
      Normal[Series[gAtBnd, {etta, 0, 0}]]],
    30, $Failed]];

  (* termm10: termm1 evaluated at x = 1-etta *)
  termm10 = Quiet[termm1 /. x -> (1-etta)];

  If[termm30 === $Failed,
    (* Can't series-expand the original G \[LongDash] try direct evaluation *)
    If[verbose, Print["    [DG] Series expansion of G at boundary failed, using direct"]];
    result = Quiet[IV$EvalDefinite[termm1, x, 0, 1, 0]];
    If[result =!= $Failed, Return[{Collect[result, _G, Simplify], lamRules}]];
    Return[$Failed]];

  (* Assemble: (termm30 + termm1|_{x1=0..1} - termm10) /. etta->0 *)
  (* termm1 at x=0: *)
  Module[{termm1at0 = Quiet[IV$RegBoundary[termm1 /. x -> 0]]},
    (* F3 (2026-08-29): IV$RegBoundary is fail-closed and may return $Failed;
       it must never enter the arithmetic below (it leaked as "c*$Failed"). *)
    result = If[termm1at0 === $Failed, $Failed,
      Quiet[
        IV$RegBoundary[
          (termm30 + termm1at0 - termm10) /. etta -> 0] /. HPL[{1},1] -> 0]];
  ];

  If[result === $Failed || !FreeQ[result, etta],
    If[verbose, Print["    [DG] Etta regularization failed"]];
    Return[$Failed]];

  (* Sanity check: DG resolution of a non-trivial G[wt2(x), wt1(x), 1] should
     not collapse to a tiny atomic expression (literal 0, Indeterminate, or
     NaN-like). LeafCount=1 outputs are almost always silent failures. *)
  If[verbose, Print["    [DG] Pre-Collect result LeafCount: ", LeafCount[result],
                    ", Head: ", Head[result], ", short: ", Short[result, 3]]];
  Module[{collected = Quiet[Collect[result, _G, Simplify]]},
    If[collected === 0 || collected === Indeterminate || collected === Undefined ||
       collected === ComplexInfinity ||
       (NumericQ[collected] && PossibleZeroQ[collected]) ||
       LeafCount[collected] <= 2,
      If[verbose, Print["    [DG] Suspicious tiny/zero output (", Short[collected, 2],
                        ", LC=", LeafCount[collected], ") \[LongDash] returning $Failed"]];
      Return[$Failed]];
    If[verbose, Print["    [DG] Success: ", LeafCount[collected], " leaves"]];
    {collected, lamRules}]
]

(* Resolve ALL unfibrated weight-2+ GPLs in an expression.
   Finds G[w1(x), w2(x), 1] terms, resolves each via DG, substitutes back. *)
IV$DGResolveAll[expr_, x_, fitList_List, verbose_:False] :=
Module[{out = expr, w2gpls, allLamRules = {}, anyResolved = False},
  w2gpls = Select[Cases[out, G[_,_,1], Infinity] // DeleteDuplicates,
    Function[g, IV$ContainsVar[g[[1]],x] || IV$ContainsVar[g[[2]],x]]];
  If[Length[w2gpls] == 0, Return[{expr, {}, False}]];
  If[verbose, Print["    [DGR] Found ", Length[w2gpls], " weight-2 GPLs to resolve"]];

  Do[Module[{resolved},
    resolved = Quiet[IV$DGResolveW2[gpl, x, fitList, verbose]];
    If[resolved =!= $Failed && ListQ[resolved],
      out = out /. gpl -> resolved[[1]];
      allLamRules = Join[allLamRules, resolved[[2]]];
      anyResolved = True;
      If[verbose, Print["    [DGR] Resolved: ", Short[gpl, 2]]],
      If[verbose, Print["    [DGR] Could not resolve: ", Short[gpl, 2]]]]
  ], {gpl, w2gpls}];

  If[anyResolved, out = Collect[out, _G, Simplify]];
  {out, allLamRules, anyResolved}
]

(* --- 6E: Frozen Term Check and Resolution --- *)

(* F3 (2026-08-29): "$Failed" added -- the fail-closed IV$RegBoundary can
   return $Failed, which arithmetic callers turned into "c*$Failed" inside a
   step result that then still counted as "ok" (test_orderhint pt1:6). *)
IV$HasFrozenTermsQ[expr_] := Module[{s = ToString[expr, InputForm]},
  StringContainsQ[s,"CanInt$FrozenCiTi"|"Gint["|"$Aborted"|"ComplexInfinity"|"DirectedInfinity"] ||
  (* F3 (2026-08-29): a $Failed BURIED inside a compound expression (boundary-regularization
     leak) is frozen; the BARE atom $Failed is NOT, so every pre-existing
     "cur === $Failed || IV$HasFrozenTermsQ[cur]" routing keeps its semantics
     (bare $Failed after the first-order MC check must reach the permuted-order retry,
     not the rational-first retry, which discards step lambda rules). *)
  (expr =!= $Failed && ! FreeQ[expr, $Failed])]

(* A term is eligible for the rational fast path only when every GPL, Log,
   or PolyLog is x-independent and an explicit multiplicative factor of the
   whole term.  Cases[...,Infinity] is unsafe here: for g1 (r1 + g2 r2) it
   returns {g1,g2}, causing g2 to be multiplied into the primitive of r1. *)
IV$ConstSpecialMonomialSplit[term_, x_] := Module[
  {factors, specialFactors, specialProduct, ratPart},
  If[FreeQ[term, _G | _Log | _PolyLog], Return[{1, term}]];
  factors = If[Head[term] === Times, List @@ term, {term}];
  specialFactors = Select[factors,
    Function[f, FreeQ[f, x] &&
      MatchQ[f, _G | _Log | _PolyLog |
        Power[_G | _Log | _PolyLog, _Integer?Positive]]]];
  If[specialFactors === {}, Return[$Failed]];
  specialProduct = Times @@ specialFactors;
  ratPart = Quiet@Cancel[term/specialProduct];
  If[! FreeQ[ratPart, _G | _Log | _PolyLog], Return[$Failed]];
  {specialProduct, ratPart}]

IV$ConstGMonomialSplit[term_, x_] :=
  IV$ConstSpecialMonomialSplit[term, x]

(* Exact zero certificate in the GPL shuffle algebra.  SameQ[#,0] is the
   acceptance predicate; PossibleZeroQ and numerical sampling are not used. *)
IV$ExactGPLZeroQ[expr_] := Module[
  {canonicalCollect, residual, rationalCanonical, canonicalResidual, shuffled,
   canonicalShuffled},
  canonicalCollect[value_] := Quiet@CheckAbort[TimeConstrained[
    Collect[value, _G, Function[coefficient,
      Quiet@Check[RootReduce[Together[coefficient]], $Failed]]],
    120, $Failed], $Failed];
  residual = Quiet@CheckAbort[TimeConstrained[
    Collect[expr, _G, Together], 120, $Failed], $Failed];
  If[residual === $Failed, Return[False]];
  If[SameQ[residual, 0], Return[True]];
  rationalCanonical = If[FreeQ[residual, _G],
    Quiet@CheckAbort[TimeConstrained[
      RootReduce[Cancel[Together[residual]]], 120, $Failed], $Failed],
    $Failed];
  If[SameQ[rationalCanonical, 0], Return[True]];
  canonicalResidual = canonicalCollect[residual];
  If[canonicalResidual =!= $Failed &&
      FreeQ[canonicalResidual, $Failed] &&
      SameQ[canonicalResidual, 0], Return[True]];
  (* GIntegrate may return a primitive whose derivative differs only by exact
     shuffle products, e.g. G[0,z]^2-2 G[0,0,z].  PossibleZeroQ does not know
     those identities.  Expand the shuffle algebra and collect its rational
     coefficients exactly; numerical agreement is never accepted. *)
  shuffled = Quiet@CheckAbort[TimeConstrained[
    Collect[ShuffleG[residual], _G, Together], 120, $Failed], $Failed];
  If[shuffled === $Failed, Return[False]];
  If[SameQ[shuffled, 0], Return[True]];
  canonicalShuffled = canonicalCollect[shuffled];
  canonicalShuffled =!= $Failed &&
    FreeQ[canonicalShuffled, $Failed] &&
    SameQ[canonicalShuffled, 0]]

(* Fail closed on an alleged antiderivative.  This is applied after fibration,
   whose branch-sensitive equality has its own independent validation gate. *)
IV$ExactAntiderivativeQ[anti_, integrand_, x_] := Module[
  {residual, gplZeroGate, rationalZeroGate},
  residual = Quiet@CheckAbort[TimeConstrained[
    DG[anti, x] - integrand, 120, $Failed], $Failed];
  If[residual === $Failed, Return[False]];
  gplZeroGate = TrueQ[IV$ExactGPLZeroQ[residual]];
  If[gplZeroGate, Return[True]];
  rationalZeroGate = FreeQ[residual, _G] &&
    TrueQ[IV$ExactRationalIdentityQ[residual, x]];
  rationalZeroGate]

(* Canonicalize and apply exact algebraic rules without allowing coincident
   lambda roots to manufacture 0/0.  Removable rational factors are cancelled
   before substitution; inconsistent, inexact, or delayed rules fail closed. *)
IV$ExactAlgebraicZeroQ[expr_] := Module[
  {reduced, exactExpressionGate, algebraicGate},
  reduced = Quiet@Check[Together[expr], $Failed];
  If[reduced === $Failed, Return[False]];
  If[SameQ[reduced, 0], Return[True]];
  exactExpressionGate = FreeQ[reduced,
    number : (_Real | _Complex) /;
      ! TrueQ[ExactNumberQ[number]]];
  algebraicGate = exactExpressionGate &&
    SameQ[Element[reduced, Algebraics], True];
  algebraicGate && SameQ[
    Quiet@Check[RootReduce[reduced], $Failed], 0]]

IV$CanonicalExactRules[rules_List] := Module[
  {exactExpressionQ, uniqueRules, groups},
  exactExpressionQ[value_] := FreeQ[value,
    number : (_Real | _Complex) /;
      ! TrueQ[ExactNumberQ[number]]];
  If[! AllTrue[rules, Head[#] === Rule &] || ! exactExpressionQ[rules],
    Return[$Failed]];
  uniqueRules = DeleteDuplicates[rules];
  If[! AllTrue[uniqueRules, MatchQ[First[#], _Symbol] &], Return[$Failed]];
  groups = GatherBy[uniqueRules, First];
  If[! AllTrue[groups, Function[group,
      With[{firstValue = Last[First[group]]},
        AllTrue[Rest[group],
          Function[rule, IV$ExactAlgebraicZeroQ[Last[rule] - firstValue]]]]]],
    Return[$Failed]];
  First /@ groups]

IV$SafeExactSubstitute[expr_, rules_List] := Module[
  {canonicalRules, prepared, denominators, substituted},
  If[rules === {}, Return[expr]];
  canonicalRules = IV$CanonicalExactRules[rules];
  If[canonicalRules === $Failed, Return[$Failed]];
  prepared = Quiet@CheckAbort[TimeConstrained[
    Collect[expr, _G, Cancel], 120, $Failed], $Failed];
  If[prepared === $Failed ||
      ! TrueQ[IV$ExactGPLZeroQ[prepared - expr]], Return[$Failed]];
  denominators = DeleteDuplicates@Cases[prepared,
    HoldPattern[Power[base_, power_]] /;
        TrueQ[NumberQ[power] && power < 0] :> base, Infinity];
  If[AnyTrue[denominators,
      IV$ExactAlgebraicZeroQ[# /. canonicalRules] &], Return[$Failed]];
  substituted = Quiet@Check[prepared /. canonicalRules, $Failed];
  If[substituted === $Failed ||
      ! FreeQ[substituted,
        Indeterminate | Undefined | ComplexInfinity | DirectedInfinity] ||
      IV$HasFrozenTermsQ[substituted], Return[$Failed]];
  substituted]

(* Manual partial fraction decomposition \[LongDash] bypasses Mathematica's Apart for cases
   where Apart times out due to many free symbols (e.g. v's + lambdas + xa).
   For ratExpr = N(x)/D(x) with D = const * Prod[(b_i*(x-r_i))^k_i] (all linear in x):
   Each linear factor contributes Series[N/(D/L_i^k_i), {x, r_i, k_i-1}] / (b_i^k_i * (x-r_i)^k_i).
   Returns $Failed if any non-linear factor in x is encountered. *)
IV$ManualApart[ratExpr_, x_] := Module[
  {num, den, fl, polyPart = 0, polyDeg, denDeg, xFactors, partials, lf,
   factor, mult, b, r, q, h, ser, partial, innerLinear, kLinear},
  num = Numerator[ratExpr]; den = Together[Denominator[ratExpr]];
  If[FreeQ[den, x], Return[ratExpr]];
  polyDeg = Exponent[Expand[num], x]; denDeg = Exponent[Expand[den], x];
  If[polyDeg >= denDeg,
    polyPart = PolynomialQuotient[num, den, x];
    num = PolynomialRemainder[num, den, x]];
  fl = IV$FactorListExact[den];
  xFactors = Select[fl, !FreeQ[#[[1]], x] &];
  partials = Catch[Sum[
    factor = lf[[1]]; mult = lf[[2]];
    If[Exponent[Expand[factor], x] == 1,
      innerLinear = factor; kLinear = mult,
      If[Head[factor] === Power && Exponent[Expand[factor[[1]]], x] == 1,
        innerLinear = factor[[1]]; kLinear = factor[[2]] * mult,
        Throw[$Failed, "manualPF"]]];
    b = Coefficient[innerLinear, x, 1];
    r = -Coefficient[innerLinear, x, 0] / b;
    q = den / (b * (x - r))^kLinear;
    h = num / q;
    ser = Quiet[Normal[Series[h, {x, r, kLinear - 1}]]];
    ser / (b^kLinear * (x - r)^kLinear),
    {lf, xFactors}], "manualPF"];
  If[partials === $Failed, Return[$Failed]];
  polyPart + partials]

(* Prove a linear partial-fraction decomposition where it is constructed,
   without rebuilding the complete common denominator afterward.  For a
   proper remainder R/(q_i f_i^m), the Taylor polynomial of R/q_i through
   order m-1 is exactly its principal part at the distinct root of f_i.
   Factor reconstruction, polynomial division, pairwise coprimality, and the
   local Taylor identities therefore certify the unique global decomposition. *)
IV$ExactPolynomialIdentityQ[expression_, x_] := Module[
  {expanded, coefficients, reducedCoefficients},
  expanded = Quiet@Check[Expand[expression], $Failed];
  If[expanded === $Failed || ! PolynomialQ[expanded, x], Return[False]];
  If[SameQ[expanded, 0], Return[True]];
  coefficients = CoefficientList[expanded, x];
  reducedCoefficients = Quiet@Check[Together /@ coefficients, $Failed];
  reducedCoefficients =!= $Failed &&
    AllTrue[reducedCoefficients, TrueQ[IV$ExactAlgebraicZeroQ[#]] &]]

IV$ExactRationalIdentityQ[expression_, x_] := Module[
  {normalized, numerator},
  normalized = Quiet@Check[Cancel[Together[expression]], $Failed];
  If[normalized === $Failed, Return[False]];
  If[SameQ[normalized, 0], Return[True]];
  numerator = Quiet@Check[Expand[Numerator[normalized]], $Failed];
  numerator =!= $Failed && PolynomialQ[numerator, x] &&
    TrueQ[IV$ExactPolynomialIdentityQ[numerator, x]]]

IV$ManualApartCertified[ratExpr_, x_] := Module[
  {rat, numerator, denominator, numeratorDegree, denominatorDegree,
   polynomialPart = 0, remainder, divisionGate, factorList,
   reconstructedDenominator, factorReconstructionGate, factorPositions,
   factorRows, linearFactorCoverageGate, factorPairs, resultantRows,
   distinctFactorGate, pieces, apart, apartIdentityGate,
   properRemainderGate, gate},
  rat = Quiet@Check[Cancel[Together[ratExpr]], $Failed];
  If[rat === $Failed || ! FreeQ[rat, _Real],
    $IV$LastManualApartAudit = <|"Gate" -> False,
      "Reason" -> "RationalCanonicalizationFailure"|>;
    Return[$IV$LastManualApartAudit]];
  numerator = Expand[Numerator[rat]];
  denominator = Expand[Denominator[rat]];
  If[! PolynomialQ[numerator, x] || ! PolynomialQ[denominator, x],
    $IV$LastManualApartAudit = <|"Gate" -> False,
      "Reason" -> "NonPolynomialRationalFunction"|>;
    Return[$IV$LastManualApartAudit]];
  numeratorDegree = Exponent[numerator, x];
  denominatorDegree = Exponent[denominator, x];
  If[numeratorDegree >= denominatorDegree,
    polynomialPart = Quiet@Check[
      PolynomialQuotient[numerator, denominator, x], $Failed];
    remainder = Quiet@Check[
      PolynomialRemainder[numerator, denominator, x], $Failed],
    remainder = numerator];
  If[polynomialPart === $Failed || remainder === $Failed,
    $IV$LastManualApartAudit = <|"Gate" -> False,
      "Reason" -> "PolynomialDivisionFailure"|>;
    Return[$IV$LastManualApartAudit]];
  divisionGate = TrueQ[IV$ExactPolynomialIdentityQ[
    numerator - polynomialPart denominator - remainder, x]];
  properRemainderGate = SameQ[remainder, 0] ||
    Exponent[remainder, x] < denominatorDegree;
  factorList = Quiet@Check[IV$FactorListExact[denominator], $Failed];
  If[factorList === $Failed || factorList === {},
    $IV$LastManualApartAudit = <|"Gate" -> False,
      "Reason" -> "FactorizationFailure"|>;
    Return[$IV$LastManualApartAudit]];
  reconstructedDenominator =
    Times @@ (#[[1]]^#[[2]] & /@ factorList);
  factorReconstructionGate = TrueQ[IV$ExactPolynomialIdentityQ[
    denominator - reconstructedDenominator, x]];
  factorPositions = Flatten@Position[factorList,
    row_ /; ! FreeQ[First[row], x], {1}];
  factorRows = Map[Function[position, Module[
      {factor, multiplicity, coefficient, root, linearIdentityGate,
       complementaryFactor, complementaryRootValue,
       complementaryRootGate, analyticPart, taylorPolynomial,
       taylorShapeGate, localResidual, localDerivativeRows,
       localTaylorGate, partial,
       rowGate},
      factor = factorList[[position, 1]];
      multiplicity = factorList[[position, 2]];
      coefficient = Coefficient[Expand[factor], x, 1];
      root = If[Exponent[Expand[factor], x] === 1 &&
          ! TrueQ[IV$ExactAlgebraicZeroQ[coefficient]],
        -Coefficient[Expand[factor], x, 0]/coefficient, $Failed];
      linearIdentityGate = root =!= $Failed &&
        TrueQ[IV$ExactPolynomialIdentityQ[
          factor - coefficient (x - root), x]];
      complementaryFactor = If[! linearIdentityGate, $Failed,
        Times @@ MapIndexed[
          If[First[#2] === position, 1, First[#1]^Last[#1]] &,
          factorList]];
      complementaryRootValue = If[complementaryFactor === $Failed,
        $Failed, Quiet@Check[Together[
          complementaryFactor /. x -> root], $Failed]];
      complementaryRootGate = complementaryRootValue =!= $Failed &&
        ! TrueQ[IV$ExactAlgebraicZeroQ[complementaryRootValue]];
      analyticPart = If[! complementaryRootGate, $Failed,
        remainder/complementaryFactor];
      taylorPolynomial = If[analyticPart === $Failed, $Failed,
        Quiet@Check[Normal[Series[analyticPart,
          {x, root, multiplicity - 1}]], $Failed]];
      taylorShapeGate = taylorPolynomial =!= $Failed &&
        FreeQ[taylorPolynomial, _SeriesData] &&
        PolynomialQ[Expand[taylorPolynomial], x] &&
        (SameQ[taylorPolynomial, 0] ||
          Exponent[Expand[taylorPolynomial], x] <= multiplicity - 1);
      localResidual = If[! taylorShapeGate, $Failed,
        analyticPart - taylorPolynomial];
      localDerivativeRows = If[localResidual === $Failed, {$Failed},
        Table[Quiet@Check[Together[
          D[localResidual, {x, order}] /. x -> root], $Failed],
          {order, 0, multiplicity - 1}]];
      localTaylorGate = localDerivativeRows =!= {$Failed} &&
        FreeQ[localDerivativeRows, $Failed] &&
        AllTrue[localDerivativeRows,
          TrueQ[IV$ExactAlgebraicZeroQ[#]] &];
      partial = If[! localTaylorGate, $Failed,
        taylorPolynomial/factor^multiplicity];
      rowGate = IntegerQ[multiplicity] && multiplicity > 0 &&
        linearIdentityGate && complementaryRootGate &&
        taylorShapeGate && localTaylorGate && partial =!= $Failed;
      <|"Position" -> position, "Factor" -> factor,
        "Multiplicity" -> multiplicity, "Root" -> root,
        "LinearIdentityGate" -> linearIdentityGate,
        "ComplementaryRootGate" -> complementaryRootGate,
        "TaylorShapeGate" -> taylorShapeGate,
        "LocalDerivativeRows" -> localDerivativeRows,
        "LocalTaylorGate" -> localTaylorGate, "Partial" -> partial,
        "Gate" -> rowGate|>]], factorPositions];
  linearFactorCoverageGate = If[FreeQ[denominator, x],
    factorRows === {},
    factorRows =!= {} && AllTrue[factorRows, TrueQ[#Gate] &]];
  factorPairs = Subsets[Lookup[factorRows, "Factor", {}], {2}];
  resultantRows = Map[Function[pair, Module[{resultant, rowGate},
      resultant = Quiet@Check[Resultant[First[pair], Last[pair], x],
        $Failed];
      rowGate = resultant =!= $Failed &&
        ! TrueQ[IV$ExactAlgebraicZeroQ[resultant]];
      <|"Pair" -> pair, "Resultant" -> resultant,
        "Gate" -> rowGate|>]], factorPairs];
  distinctFactorGate = AllTrue[resultantRows, TrueQ[#Gate] &];
  pieces = Join[If[SameQ[polynomialPart, 0], {}, {polynomialPart}],
    Lookup[factorRows, "Partial", {}]];
  apart = If[FreeQ[pieces, $Failed], Total[pieces], $Failed];
  apartIdentityGate = apart =!= $Failed &&
    TrueQ[IV$ExactRationalIdentityQ[apart - rat, x]];
  gate = divisionGate && properRemainderGate &&
    factorReconstructionGate && linearFactorCoverageGate &&
    distinctFactorGate && apartIdentityGate;
  $IV$LastManualApartAudit = <|
    "Method" -> "UniquePrincipalPartsOverExactLinearFactorization",
    "Rational" -> rat, "PolynomialPart" -> polynomialPart,
    "Remainder" -> remainder, "DivisionGate" -> divisionGate,
    "ProperRemainderGate" -> properRemainderGate,
    "FactorList" -> factorList,
    "FactorReconstructionGate" -> factorReconstructionGate,
    "FactorRows" -> factorRows,
    "LinearFactorCoverageGate" -> linearFactorCoverageGate,
    "ResultantRows" -> resultantRows,
    "DistinctFactorGate" -> distinctFactorGate, "Pieces" -> pieces,
    "Apart" -> apart, "ApartIdentityGate" -> apartIdentityGate,
    "Gate" -> gate|>]

(* Integrate one exact partial-fraction piece with a single linear
   x-dependent denominator factor.  IV$ManualApart can leave a polynomial
   numerator over a repeated pole; treating that numerator as a constant
   gives a false primitive.  Expanding the numerator in the linear factor
   itself covers every polynomial numerator and every pole multiplicity. *)
IV$IntegrateLinearPieceExact[piece_, x_] := Module[
  {rat, num, den, factors, xFactors, constantFactor, factor,
   multiplicity, a, b, root, s, numeratorInFactor, degree},
  If[! FreeQ[piece, _Real], Return[$Failed]];
  rat = Quiet@Check[Cancel[Together[piece]], $Failed];
  If[rat === $Failed, Return[$Failed]];
  num = Numerator[rat]; den = Denominator[rat];
  If[FreeQ[den, x],
    If[! PolynomialQ[Expand[num/den], x], Return[$Failed]];
    degree = Max[0, Exponent[Expand[num/den], x]];
    Return[Sum[Coefficient[Expand[num/den], x, j] x^(j + 1)/(j + 1),
      {j, 0, degree}]]];
  factors = IV$FactorListExact[den];
  xFactors = Select[factors, ! FreeQ[#[[1]], x] &];
  If[Length[xFactors] =!= 1, Return[$Failed]];
  factor = xFactors[[1, 1]];
  multiplicity = xFactors[[1, 2]];
  If[Exponent[Expand[factor], x] =!= 1, Return[$Failed]];
  constantFactor = Times @@
    (#[[1]]^#[[2]] & /@ Select[factors, FreeQ[#[[1]], x] &]);
  a = Coefficient[factor, x, 0];
  b = Coefficient[factor, x, 1];
  If[SameQ[b, 0], Return[$Failed]];
  root = -a/b;
  s = Unique["IVlinearFactor$"];
  numeratorInFactor = Expand[num /. x -> (s - a)/b];
  If[! PolynomialQ[numeratorInFactor, s], Return[$Failed]];
  degree = Max[0, Exponent[numeratorInFactor, s]];
  Sum[With[{coefficient = Coefficient[numeratorInFactor, s, j],
      power = j - multiplicity},
      If[power === -1,
        coefficient G[root, x]/(constantFactor b),
        coefficient factor^(power + 1)/
          (constantFactor b (power + 1))]],
    {j, 0, degree}]]

(* Robust integration of a single Apart-piece c(other-vars)/((linear in xa)^k * other-factors).
   onFail is a thunk run when the piece can't be handled.
   Handles three FactorList edge cases:
   - Linear factor with multiplicity (standard rational case)
   - Power[linear, k] with mult 1 (some symbolic forms)
   - Real-coefficient polynomial (-11.+x)^2 that FactorList expands to
     121.-22.x+x^2 with mult 1 \[LongDash] for these, use NSolve to extract numerical
     roots and recurse on the resulting linear-factor pieces. *)
IV$IntegratePiece[piece_, xa_, onFail_] := Module[
  {num, den, fl, xfac, factor, mult, deg, fp, kp, ap, bp, constfac,
   anti, exactAnti, lead, roots, rewritten, ap2, aTerms},
  exactAnti = IV$IntegrateLinearPieceExact[piece, xa];
  If[exactAnti =!= $Failed, Return[exactAnti]];
  num = Numerator[piece]; den = Together[Denominator[piece]];
  If[FreeQ[den, xa],
    Module[{numExp = Expand[num/den], dg},
      dg = If[PolynomialQ[numExp, xa], Exponent[numExp, xa], 0];
      Return[Sum[Coefficient[numExp, xa, j] * xa^(j+1)/(j+1), {j, 0, dg}]]]];
  fl = IV$FactorListExact[den];
  xfac = SelectFirst[fl, !FreeQ[#[[1]], xa] &, None];
  If[xfac === None, Return[onFail[]]];
  factor = xfac[[1]]; mult = xfac[[2]];
  deg = Exponent[Expand[factor], xa];
  Which[
    deg == 1,
      fp = factor; kp = mult,
    Head[factor] === Power && Exponent[Expand[factor[[1]]], xa] == 1,
      fp = factor[[1]]; kp = factor[[2]] * mult,
    deg >= 2,
      (* Numerical-root recovery for Real-coefficient polynomials. *)
      lead = Coefficient[Expand[factor], xa, deg];
      roots = xa /. Quiet[NSolve[factor == 0, xa]];
      If[Length[roots] != deg || !AllTrue[roots, NumericQ], Return[onFail[]]];
      (* Detect perfect-power case (all roots numerically equal). Avoids
         infinite recursion: rewriting (x-r)^deg back to FactorList just
         re-expands to the same quadratic. Handle directly with kp = deg*mult. *)
      If[AllTrue[roots, Abs[# - roots[[1]]] < 10^-9 &],
        constfac = (Times @@ (#[[1]]^#[[2]] & /@ Select[fl, FreeQ[#[[1]], xa] &])) * lead^mult;
        fp = xa - roots[[1]]; kp = deg * mult;
        ap = Coefficient[fp, xa, 0]; bp = Coefficient[fp, xa, 1];
        Return[If[kp == 1,
          num / (constfac * bp) * G[-ap/bp, xa],
          num / (constfac * bp * (1 - kp)) * fp^(1 - kp)]]];
      (* Distinct roots: split via Apart on rewritten linear-factor product. *)
      constfac = (Times @@ (#[[1]]^#[[2]] & /@ Select[fl, FreeQ[#[[1]], xa] &])) * lead^mult;
      rewritten = num / (constfac * Times @@ ((xa - #)^mult & /@ roots));
      ap2 = Quiet[Apart[rewritten, xa]];
      aTerms = If[Head[ap2] === Plus, List @@ ap2, {ap2}];
      Return[Sum[IV$IntegratePiece[aTerms[[k]], xa, onFail], {k, Length[aTerms]}]],
    True,
      Return[onFail[]]];
  constfac = Times @@ (#[[1]]^#[[2]] & /@ Select[fl, FreeQ[#[[1]], xa] &]);
  ap = Coefficient[fp, xa, 0]; bp = Coefficient[fp, xa, 1];
  If[kp == 1,
    anti = num / (constfac * bp) * G[-ap/bp, xa],
    anti = num / (constfac * bp * (1 - kp)) * fp^(1 - kp)];
  anti]

(* Exact rational primitive used by source-preserving GPL integration.  The
   returned expression is never trusted merely because all pieces integrated:
   both the partial-fraction identity and the aggregate derivative are proved
   in the exact GPL shuffle algebra. *)
IV$RationalPrimitiveExact[rational_, x_] := Module[
  {rat, apartAudit, pieces, primitiveRows, primitives, primitive, gate},
  If[! IV$SpecialFunctionsFreeOfXQ[rational, x] ||
      ! FreeQ[rational, _Real],
    $IV$LastRationalPrimitiveAudit = <|"Gate" -> False,
      "Reason" -> "InputEligibilityFailure"|>;
    Return[$Failed]];
  rat = Quiet@Check[Cancel[Together[rational]], $Failed];
  If[rat === $Failed,
    $IV$LastRationalPrimitiveAudit = <|"Gate" -> False,
      "Reason" -> "RationalCanonicalizationFailure"|>;
    Return[$Failed]];
  If[SameQ[rat, 0],
    $IV$LastRationalPrimitiveAudit = <|
      "Method" -> "ExactZeroRational",
      "PartialFractionAudit" -> <|"FactorRows" -> {},
        "Pieces" -> {}, "Gate" -> True|>,
      "PrimitiveRows" -> {}, "AggregateDerivativeGate" -> True,
      "Gate" -> True|>;
    Return[0]];
  apartAudit = Quiet@CheckAbort[TimeConstrained[
    IV$ManualApartCertified[rat, x], 600, $Failed], $Failed];
  If[apartAudit === $Failed || ! AssociationQ[apartAudit] ||
      ! TrueQ[apartAudit["Gate"]],
    $IV$LastRationalPrimitiveAudit = <|"Gate" -> False,
      "Reason" -> "CertifiedPartialFractionFailure",
      "PartialFractionAudit" -> apartAudit|>;
    Return[$Failed]];
  pieces = apartAudit["Pieces"];
  primitiveRows = MapIndexed[Function[{piece, position}, Module[
      {piecePrimitive, derivativeGate},
      piecePrimitive = IV$IntegrateLinearPieceExact[piece, x];
      derivativeGate = piecePrimitive =!= $Failed &&
        TrueQ[IV$ExactAntiderivativeQ[piecePrimitive, piece, x]];
      <|"Index" -> First[position], "Piece" -> piece,
        "Primitive" -> piecePrimitive,
        "DerivativeGate" -> derivativeGate,
        "Gate" -> derivativeGate|>]], pieces];
  primitives = Lookup[primitiveRows, "Primitive", {$Failed}];
  gate = primitiveRows =!= {} &&
    AllTrue[primitiveRows, TrueQ[#Gate] &] &&
    FreeQ[primitives, $Failed];
  If[! gate,
    $IV$LastRationalPrimitiveAudit = <|"Gate" -> False,
      "Reason" -> "LinearPiecePrimitiveFailure",
      "PartialFractionAudit" -> apartAudit,
      "PrimitiveRows" -> primitiveRows|>;
    Return[$Failed]];
  primitive = Total[primitives];
  (* Exact transitivity: the certified principal parts sum to rat and every
     piece primitive differentiates exactly.  No whole-sum normalization is
     needed to prove the aggregate derivative. *)
  $IV$LastRationalPrimitiveAudit = <|
    "Method" ->
      "CertifiedPrincipalPartsPlusExactPieceDerivativesAndLinearity",
    "PartialFractionAudit" -> apartAudit,
    "PrimitiveRows" -> primitiveRows,
    "AggregateDerivativeGate" -> True, "Gate" -> True|>;
  primitive]

(* The simple-pole residue formula is a Lagrange identity over any field.  Its
   scalable certificate is the structural Lagrange-basis evaluation matrix
   together with polynomial degree/root-count uniqueness.  It deliberately
   does not expand a generic Vandermonde rational function: actual distinctness
   and all nonzero normalization obligations are discharged at specialization. *)
If[! AssociationQ[$IV$GenericSimplePoleIdentityCache],
  $IV$GenericSimplePoleIdentityCache = <||>];

IV$GenericSimplePoleIdentityCertificate[poleCount_Integer,
    numeratorDegree_Integer] := Module[
  {schemaVersion = 3, degree, cacheKey, cached, nodeIndices,
   requiredDistinctRootPairs, requiredLinearScaleIndices, obligations,
   basisRows, evaluationMatrix,
   evaluationMatrixGate, basisGate, interpolantDegreeUpperBound,
   residualDegreeUpperBound, properDegreeGate, uniquenessGate, gate,
   certificate},
  degree = numeratorDegree;
  If[poleCount <= 0 || degree < 0 || degree >= poleCount,
    Return[<|"Method" ->
        "FormalLagrangeBasisAndDistinctNodeUniqueness",
      "SchemaVersion" -> schemaVersion,
      "PoleCount" -> poleCount, "NumeratorDegree" -> numeratorDegree,
      "FormalDegree" -> degree, "ProperDegreeGate" -> False,
      "Gate" -> False|>]];
  nodeIndices = Range[poleCount];
  requiredDistinctRootPairs = Subsets[nodeIndices, {2}];
  requiredLinearScaleIndices = nodeIndices;
  obligations = {
    <|"Name" -> "PairwiseDistinctRoots",
      "RequiredPairs" -> requiredDistinctRootPairs|>,
    <|"Name" -> "NonzeroConstantProduct"|>,
    <|"Name" -> "NonzeroLinearScales",
      "RequiredIndices" -> requiredLinearScaleIndices|>,
    <|"Name" -> "LinearFactorNormalization",
      "RequiredIndices" -> nodeIndices|>,
    <|"Name" -> "DenominatorClearing"|>};
  cacheKey = ToString[
    {"FormalLagrangeUniqueness", schemaVersion, poleCount, degree},
    InputForm];
  cached = Lookup[$IV$GenericSimplePoleIdentityCache, cacheKey,
    Missing["NotFound"]];
  If[! MissingQ[cached],
    If[AssociationQ[cached] &&
        SameQ[Lookup[cached, "SchemaVersion", Missing[]],
          schemaVersion] &&
        SameQ[Lookup[cached, "PoleCount", Missing[]], poleCount] &&
        SameQ[Lookup[cached, "FormalDegree", Missing[]], degree] &&
        SameQ[Lookup[cached, "EvaluationMatrix", Missing[]],
          IdentityMatrix[poleCount]] &&
        SameQ[Lookup[cached, "RequiredDistinctRootPairs", Missing[]],
          requiredDistinctRootPairs] &&
        SameQ[Lookup[cached, "RequiredLinearScaleIndices", Missing[]],
          requiredLinearScaleIndices] &&
        SameQ[Lookup[Lookup[cached, "Obligations", {}], "Name",
            Missing[]], Lookup[obligations, "Name"]] &&
        TrueQ[Lookup[cached, "ConditionalUniquenessGate", False]] &&
        TrueQ[Lookup[cached, "Gate", False]],
      Return[Join[cached, <|"CacheHit" -> True|>]],
      Return[<|"Method" ->
          "FormalLagrangeBasisAndDistinctNodeUniqueness",
        "SchemaVersion" -> schemaVersion,
        "PoleCount" -> poleCount, "NumeratorDegree" -> numeratorDegree,
        "FormalDegree" -> degree, "Reason" -> "InvalidCachedCertificate",
        "Gate" -> False|>]]];
  basisRows = Table[Module[
      {factorIndices = Delete[nodeIndices, basisIndex],
       denominatorPairs, evaluationRows, degreeGate, rowGate},
      denominatorPairs = ({basisIndex, #} &) /@ factorIndices;
      evaluationRows = Table[If[nodeIndex === basisIndex,
          Module[{numeratorPairs, cancellationGate},
            numeratorPairs = ({nodeIndex, #} &) /@ factorIndices;
            cancellationGate = SameQ[numeratorPairs, denominatorPairs];
            <|"NodeIndex" -> nodeIndex, "ExpectedValue" -> 1,
              "Reason" -> "IdenticalNumeratorAndDenominatorFactors",
              "NumeratorDifferencePairs" -> numeratorPairs,
              "DenominatorDifferencePairs" -> denominatorPairs,
              "StructuralGate" -> cancellationGate,
              "Gate" -> cancellationGate|>],
          Module[{zeroFactorGate},
            zeroFactorGate = MemberQ[factorIndices, nodeIndex];
            <|"NodeIndex" -> nodeIndex, "ExpectedValue" -> 0,
              "Reason" -> "ExplicitZeroNumeratorFactor",
              "ZeroDifferencePair" -> {nodeIndex, nodeIndex},
              "ZeroFactorIndexPresentGate" -> zeroFactorGate,
              "DenominatorDifferencePairs" -> denominatorPairs,
              "StructuralGate" -> zeroFactorGate,
              "Gate" -> zeroFactorGate|>]],
        {nodeIndex, nodeIndices}];
      degreeGate = Length[factorIndices] === poleCount - 1;
      rowGate = Length[evaluationRows] === poleCount && degreeGate &&
        AllTrue[evaluationRows, TrueQ[#Gate] &];
      <|"BasisIndex" -> basisIndex,
        "BasisForm" ->
          "Product[f_j(x),j!=i]/Product[f_j(r_i),j!=i]",
        "NumeratorFactorIndices" -> factorIndices,
        "DenominatorDifferencePairs" -> denominatorPairs,
        "Degree" -> poleCount - 1, "DegreeGate" -> degreeGate,
        "EvaluationRows" -> evaluationRows, "Gate" -> rowGate|>],
    {basisIndex, nodeIndices}];
  evaluationMatrix = Map[
    Lookup[Lookup[#, "EvaluationRows", {}], "ExpectedValue", Missing[]] &,
    basisRows];
  evaluationMatrixGate = SameQ[evaluationMatrix,
    IdentityMatrix[poleCount]];
  basisGate = Length[basisRows] === poleCount &&
    AllTrue[basisRows, TrueQ[#Gate] &];
  interpolantDegreeUpperBound = poleCount - 1;
  residualDegreeUpperBound = Max[degree, interpolantDegreeUpperBound];
  properDegreeGate = 0 <= degree < poleCount;
  (* Conditional on the recorded pairwise-distinct-node obligations, a
     polynomial of degree < poleCount with poleCount roots is identically zero. *)
  uniquenessGate = properDegreeGate && evaluationMatrixGate &&
    basisGate && residualDegreeUpperBound < poleCount &&
    Length[requiredDistinctRootPairs] === Binomial[poleCount, 2];
  gate = uniquenessGate;
  certificate = <|"Method" ->
      "FormalLagrangeBasisAndDistinctNodeUniqueness",
    "SchemaVersion" -> schemaVersion,
    "PoleCount" -> poleCount, "NumeratorDegree" -> numeratorDegree,
    "FormalDegree" -> degree, "ProperDegreeGate" -> properDegreeGate,
    "BasisRows" -> basisRows, "BasisGate" -> basisGate,
    "EvaluationMatrix" -> evaluationMatrix,
    "EvaluationMatrixGate" -> evaluationMatrixGate,
    "InterpolantDegreeUpperBound" -> interpolantDegreeUpperBound,
    "ResidualDegreeUpperBound" -> residualDegreeUpperBound,
    "RootCount" -> poleCount,
    "RootCountExceedsResidualDegreeGate" ->
      (poleCount > residualDegreeUpperBound),
    "UniquenessTheorem" ->
      "A nonzero polynomial over a field has at most degree-many distinct roots",
    "RequiresDistinctRoots" -> True,
    "RequiredDistinctRootPairs" -> requiredDistinctRootPairs,
    "RequiresNonzeroConstantProduct" -> True,
    "RequiresNonzeroLinearScales" -> True,
    "RequiredLinearScaleIndices" -> requiredLinearScaleIndices,
    "RequiresLinearFactorNormalization" -> True,
    "RequiresDenominatorClearing" -> True,
    "Obligations" -> obligations,
    "PolynomialIdentityContract" ->
      "N(x)=Sum_i N(r_i) Product[f_j(x),j!=i]/Product[f_j(r_i),j!=i]",
    "RationalIdentityContract" ->
      "N/(C Product[f_i])=Sum_i N(r_i)/(C b_i Product[f_j(r_i),j!=i])/(x-r_i)",
    "ConditionalUniquenessGate" -> uniquenessGate,
    "CacheHit" -> False, "Gate" -> gate|>;
  If[gate, $IV$GenericSimplePoleIdentityCache[cacheKey] = certificate];
  certificate]

(* Exact simple-pole residues from an already certified factored denominator.
   This path deliberately never multiplies the denominator factors or calls
   Together on the complete algebraic rational function. *)
IV$ExactResidueInterpolationCertificate[numerator_, constantRows_List,
    linearRows_List, residueRows_List, x_] := Module[
  {poleCount, expandedNumerator, numeratorDegree, numeratorCoefficients,
   properGate, countGate, exactExpressionQ, exactAlgebraicNumberQ,
   exactNonzeroCertificate, exactEqualityCertificate, numeratorFieldGate,
   constantProduct, constantFieldRows, linearFieldRows, roots, scales,
   distinctRootRows, exactFieldGate, genericIdentityCertificate,
   genericBasisRows, requiredDistinctRootPairs, actualDistinctRootPairs,
   requiredLinearScaleIndices, actualLinearScaleIndices,
   obligationNames, obligationSchemaGate, pointCountEchoGate,
   formalDegreeEchoGate, distinctRootObligationGate,
   constantProductObligationGate, linearScaleObligationGate,
   linearNormalizationRows, linearNormalizationObligationGate,
   denominatorClearingRow, denominatorClearingObligationGate,
   genericIdentityGate, residueBridgeRows, gate},
  poleCount = Length[linearRows];
  expandedNumerator = Quiet@Check[Expand[numerator], $Failed];
  numeratorDegree = If[expandedNumerator === $Failed ||
      ! PolynomialQ[expandedNumerator, x], Infinity,
    If[SameQ[expandedNumerator, 0], -Infinity,
      Exponent[expandedNumerator, x]]];
  properGate = poleCount > 0 && expandedNumerator =!= $Failed &&
    PolynomialQ[expandedNumerator, x] &&
    (SameQ[expandedNumerator, 0] || numeratorDegree < poleCount);
  numeratorCoefficients = If[! properGate, {},
    If[SameQ[expandedNumerator, 0], {0},
      CoefficientList[expandedNumerator, x]]];
  countGate = properGate && Length[residueRows] === poleCount &&
    AllTrue[constantRows,
      AssociationQ[#] && KeyExistsQ[#, "CanonicalFactor"] &&
        KeyExistsQ[#, "Multiplicity"] && TrueQ[Lookup[#, "Gate", False]] &] &&
    AllTrue[linearRows,
      AssociationQ[#] && KeyExistsQ[#, "Root"] &&
        KeyExistsQ[#, "Scale"] && TrueQ[Lookup[#, "Gate", False]] &] &&
    AllTrue[residueRows,
      AssociationQ[#] && KeyExistsQ[#, "Root"] &&
        KeyExistsQ[#, "Residue"] &&
        KeyExistsQ[#, "CanonicalResidue"] &&
        KeyExistsQ[#, "NumeratorAtRoot"] &&
        KeyExistsQ[#, "ComplementaryFactorValues"] &&
        KeyExistsQ[#, "ConstantProduct"] &&
        KeyExistsQ[#, "ComplementaryProduct"] &&
        TrueQ[Lookup[#, "Gate", False]] &];
  If[! countGate,
    Return[<|"Method" -> "ExactFormalFieldLagrangeCertificate",
      "NumeratorDegree" -> numeratorDegree,
      "ProperDegreeGate" -> properGate,
      "CountGate" -> False, "Gate" -> False|>]];
  exactExpressionQ[value_] := FreeQ[value,
    number : (_Real | _Complex) /;
      ! TrueQ[ExactNumberQ[number]]];
  exactAlgebraicNumberQ[value_] := exactExpressionQ[value] &&
    SameQ[Element[value, Algebraics], True];
  exactNonzeroCertificate[value_] := Module[
    {canonical = Quiet@TimeConstrained[RootReduce[value], 120, $Failed],
     exactGate, nonzeroGate},
    exactGate = canonical =!= $Failed &&
      exactAlgebraicNumberQ[canonical];
    nonzeroGate = exactGate && ! SameQ[canonical, 0];
    <|"CanonicalValue" -> canonical,
      "ExactAlgebraicGate" -> exactGate,
      "NonzeroGate" -> nonzeroGate, "Gate" -> nonzeroGate|>];
  exactEqualityCertificate[first_, second_] := Module[
    {structuralGate = SameQ[first, second], residual, gate},
    residual = If[structuralGate, 0,
      Quiet@TimeConstrained[RootReduce[first - second], 120, $Failed]];
    gate = SameQ[residual, 0];
    <|"StructuralGate" -> structuralGate, "Residual" -> residual,
      "Gate" -> gate|>];
  numeratorFieldGate = numeratorCoefficients =!= {} &&
    AllTrue[numeratorCoefficients, exactAlgebraicNumberQ];
  constantFieldRows = MapIndexed[Function[{row, position}, Module[
      {value, multiplicity, exactGate, multiplicityGate,
       nonzeroAudit, nonzeroGate},
      value = row["CanonicalFactor"];
      multiplicity = row["Multiplicity"];
      exactGate = exactAlgebraicNumberQ[value];
      multiplicityGate = IntegerQ[multiplicity] && multiplicity =!= 0;
      nonzeroAudit = If[exactGate, exactNonzeroCertificate[value],
        <|"Gate" -> False|>];
      nonzeroGate = exactGate && TrueQ[nonzeroAudit["Gate"]];
      <|"Index" -> First[position], "ExactAlgebraicGate" -> exactGate,
        "MultiplicityGate" -> multiplicityGate,
        "NonzeroCertificate" -> nonzeroAudit,
        "NonzeroGate" -> nonzeroGate,
        "Gate" -> (multiplicityGate && nonzeroGate)|>]],
    constantRows];
  roots = Lookup[linearRows, "Root"];
  scales = Lookup[linearRows, "Scale"];
  linearFieldRows = MapIndexed[Function[{row, position}, Module[
      {root, scale, multiplicity, rootGate, scaleGate,
       multiplicityGate, scaleNonzeroAudit, scaleNonzeroGate,
       factorIdentityGate, rowGate},
      root = row["Root"];
      scale = row["Scale"];
      multiplicity = row["Multiplicity"];
      rootGate = exactAlgebraicNumberQ[root];
      scaleGate = exactAlgebraicNumberQ[scale];
      multiplicityGate = SameQ[multiplicity, 1];
      scaleNonzeroAudit = If[scaleGate, exactNonzeroCertificate[scale],
        <|"Gate" -> False|>];
      scaleNonzeroGate = scaleGate &&
        TrueQ[scaleNonzeroAudit["Gate"]];
      factorIdentityGate = rootGate && scaleNonzeroGate &&
        TrueQ[IV$ExactPolynomialIdentityQ[
          row["Factor"] - scale (x - root), x]];
      rowGate = rootGate && scaleNonzeroGate && multiplicityGate &&
        factorIdentityGate &&
        TrueQ[Lookup[row, "Gate", False]];
      <|"Index" -> First[position],
        "RootExactAlgebraicGate" -> rootGate,
        "ScaleExactAlgebraicGate" -> scaleGate,
        "MultiplicityGate" -> multiplicityGate,
        "ScaleNonzeroCertificate" -> scaleNonzeroAudit,
        "ScaleNonzeroGate" -> scaleNonzeroGate,
        "FactorIdentityGate" -> factorIdentityGate,
        "Gate" -> rowGate|>]], linearRows];
  distinctRootRows = Map[Function[pair, Module[
      {difference, exactGate, nonzeroAudit, distinctGate},
      difference = roots[[First[pair]]] - roots[[Last[pair]]];
      exactGate = exactAlgebraicNumberQ[difference];
      nonzeroAudit = If[exactGate, exactNonzeroCertificate[difference],
        <|"Gate" -> False|>];
      distinctGate = exactGate && TrueQ[nonzeroAudit["Gate"]];
      <|"Pair" -> pair, "Difference" -> difference,
        "ExactAlgebraicGate" -> exactGate,
        "NonzeroCertificate" -> nonzeroAudit,
        "Gate" -> distinctGate|>]],
    Subsets[Range[poleCount], {2}]];
  exactFieldGate = numeratorFieldGate &&
    AllTrue[constantFieldRows, TrueQ[#Gate] &] &&
    AllTrue[linearFieldRows, TrueQ[#Gate] &] &&
    Length[distinctRootRows] === Binomial[poleCount, 2] &&
    AllTrue[distinctRootRows, TrueQ[#Gate] &];
  constantProduct = Times @@ Map[
    Lookup[#, "CanonicalFactor"]^Lookup[#, "Multiplicity"] &,
    constantRows];
  genericIdentityCertificate =
    IV$GenericSimplePoleIdentityCertificate[poleCount,
      If[numeratorDegree === -Infinity, 0, numeratorDegree]];
  genericBasisRows = Lookup[genericIdentityCertificate, "BasisRows", {}];
  pointCountEchoGate = SameQ[
    Lookup[genericIdentityCertificate, "PoleCount", Missing[]], poleCount];
  formalDegreeEchoGate = SameQ[
    Lookup[genericIdentityCertificate, "FormalDegree", Missing[]],
    If[numeratorDegree === -Infinity, 0, numeratorDegree]];
  obligationNames = Lookup[
    Lookup[genericIdentityCertificate, "Obligations", {}], "Name",
    Missing["NotAvailable"]];
  obligationSchemaGate = SameQ[obligationNames,
    {"PairwiseDistinctRoots", "NonzeroConstantProduct",
      "NonzeroLinearScales", "LinearFactorNormalization",
      "DenominatorClearing"}];
  requiredDistinctRootPairs = Lookup[genericIdentityCertificate,
    "RequiredDistinctRootPairs", Missing["NotAvailable"]];
  actualDistinctRootPairs = If[distinctRootRows === {}, {},
    Lookup[distinctRootRows, "Pair", Missing["NotAvailable"]]];
  distinctRootObligationGate = ListQ[requiredDistinctRootPairs] &&
    SameQ[requiredDistinctRootPairs, actualDistinctRootPairs] &&
    AllTrue[distinctRootRows, TrueQ[#Gate] &];
  constantProductObligationGate =
    TrueQ[Lookup[genericIdentityCertificate,
      "RequiresNonzeroConstantProduct", False]] &&
    AllTrue[constantFieldRows,
      TrueQ[#MultiplicityGate] && TrueQ[#NonzeroGate] &];
  requiredLinearScaleIndices = Lookup[genericIdentityCertificate,
    "RequiredLinearScaleIndices", Missing["NotAvailable"]];
  actualLinearScaleIndices = Lookup[linearFieldRows, "Index",
    Missing["NotAvailable"]];
  linearScaleObligationGate =
    TrueQ[Lookup[genericIdentityCertificate,
      "RequiresNonzeroLinearScales", False]] &&
    SameQ[requiredLinearScaleIndices, actualLinearScaleIndices] &&
    AllTrue[linearFieldRows, TrueQ[#ScaleNonzeroGate] &];
  linearNormalizationRows = Map[Function[row,
    <|"Index" -> row["Index"],
      "Contract" -> "f_i(x)=b_i(x-r_i)",
      "FactorIdentityGate" -> row["FactorIdentityGate"],
      "ScaleNonzeroGate" -> row["ScaleNonzeroGate"],
      "Gate" -> (TrueQ[row["FactorIdentityGate"]] &&
        TrueQ[row["ScaleNonzeroGate"]])|>], linearFieldRows];
  linearNormalizationObligationGate =
    TrueQ[Lookup[genericIdentityCertificate,
      "RequiresLinearFactorNormalization", False]] &&
    SameQ[Lookup[linearNormalizationRows, "Index",
        Missing["NotAvailable"]], Range[poleCount]] &&
    AllTrue[linearNormalizationRows, TrueQ[#Gate] &];
  denominatorClearingRow = <|
    "Contract" ->
      "D=C Product[f_i]=C Product[b_i] Product[x-r_i] is nonzero",
    "ConstantProduct" -> constantProduct,
    "NonzeroConstantProductGate" -> constantProductObligationGate,
    "NonzeroLinearScalesGate" -> linearScaleObligationGate,
    "PairwiseDistinctRootsGate" -> distinctRootObligationGate,
    "LinearNormalizationGate" -> linearNormalizationObligationGate,
    "Gate" -> (constantProductObligationGate &&
      linearScaleObligationGate && distinctRootObligationGate &&
      linearNormalizationObligationGate)|>;
  denominatorClearingObligationGate =
    TrueQ[Lookup[genericIdentityCertificate,
      "RequiresDenominatorClearing", False]] &&
    TrueQ[denominatorClearingRow["Gate"]];
  genericIdentityGate = AssociationQ[genericIdentityCertificate] &&
    TrueQ[Lookup[genericIdentityCertificate, "Gate", False]] &&
    TrueQ[Lookup[genericIdentityCertificate,
      "RequiresDistinctRoots", False]] &&
    pointCountEchoGate && formalDegreeEchoGate && obligationSchemaGate &&
    distinctRootObligationGate && constantProductObligationGate &&
    linearScaleObligationGate && linearNormalizationObligationGate &&
    denominatorClearingObligationGate && exactFieldGate;
  residueBridgeRows = MapIndexed[Function[{row, position}, Module[
      {index, root, scale, numeratorAtRoot, otherFactorValues,
       expectedResidue, storedNumeratorAtRoot,
       storedComplementaryFactorValues, storedConstantProduct,
       storedComplementaryProduct, numeratorValueBridge,
       complementaryValueBridges, constantProductBridge,
       complementaryProductBridge, expectedResidueBridge,
       basisRow, complementaryFactorIndices, complementaryIndexGate,
       residueConstantGate,
       componentBridgeGate,
       residueFromStoredComponents, rootAlignmentGate,
       residueConstructionGate, canonicalBridgeGate, rowGate},
      index = First[position];
      root = linearRows[[index]]["Root"];
      scale = linearRows[[index]]["Scale"];
      numeratorAtRoot = Fold[#1 root + #2 &,
        Last[numeratorCoefficients], Reverse[Most[numeratorCoefficients]]];
      otherFactorValues = MapIndexed[
        If[First[#2] === index, 1,
          (#1["Factor"] /. x -> root)] &, linearRows];
      expectedResidue = numeratorAtRoot/
        (constantProduct scale Times @@ otherFactorValues);
      basisRow = If[Length[genericBasisRows] === poleCount,
        genericBasisRows[[index]], <||>];
      complementaryFactorIndices = Delete[Range[poleCount], index];
      complementaryIndexGate = AssociationQ[basisRow] &&
        SameQ[Lookup[basisRow, "BasisIndex", Missing[]], index] &&
        SameQ[Lookup[basisRow, "NumeratorFactorIndices", Missing[]],
          complementaryFactorIndices] &&
        SameQ[Lookup[basisRow, "BasisForm", Missing[]],
          "Product[f_j(x),j!=i]/Product[f_j(r_i),j!=i]"];
      storedNumeratorAtRoot = row["NumeratorAtRoot"];
      storedComplementaryFactorValues = row["ComplementaryFactorValues"];
      storedConstantProduct = row["ConstantProduct"];
      storedComplementaryProduct = row["ComplementaryProduct"];
      numeratorValueBridge = exactEqualityCertificate[
        storedNumeratorAtRoot, numeratorAtRoot];
      complementaryValueBridges = If[
        ListQ[storedComplementaryFactorValues] &&
          Length[storedComplementaryFactorValues] ===
            Length[otherFactorValues],
        MapThread[exactEqualityCertificate,
          {storedComplementaryFactorValues, otherFactorValues}], {}];
      constantProductBridge = exactEqualityCertificate[
        storedConstantProduct, constantProduct];
      complementaryProductBridge = exactEqualityCertificate[
        storedComplementaryProduct,
        Times @@ storedComplementaryFactorValues];
      expectedResidueBridge = exactEqualityCertificate[
        row["Residue"], expectedResidue];
      residueConstantGate = FreeQ[row["Residue"], x] &&
        FreeQ[expectedResidue, x];
      componentBridgeGate = TrueQ[numeratorValueBridge["Gate"]] &&
        Length[complementaryValueBridges] === Length[otherFactorValues] &&
        AllTrue[complementaryValueBridges, TrueQ[#Gate] &] &&
        TrueQ[constantProductBridge["Gate"]] &&
        TrueQ[complementaryProductBridge["Gate"]] &&
        TrueQ[expectedResidueBridge["Gate"]] &&
        complementaryIndexGate && residueConstantGate;
      residueFromStoredComponents = storedNumeratorAtRoot/
        (storedConstantProduct scale storedComplementaryProduct);
      rootAlignmentGate = SameQ[row["Root"], root];
      residueConstructionGate =
        SameQ[row["Residue"], residueFromStoredComponents];
      canonicalBridgeGate =
        SameQ[row["CanonicalResidue"], row["Residue"]];
      rowGate = exactFieldGate && componentBridgeGate && rootAlignmentGate &&
        residueConstructionGate && canonicalBridgeGate &&
        TrueQ[Lookup[row, "Gate", False]];
      <|"Index" -> index,
        "RootAlignmentResidual" ->
          If[rootAlignmentGate, 0, Missing["StructuralMismatch"]],
        "RootAlignmentGate" -> rootAlignmentGate,
        "ExpectedResidue" -> expectedResidue,
        "ExpectedResidueBridge" -> expectedResidueBridge,
        "ComplementaryFactorIndices" -> complementaryFactorIndices,
        "ComplementaryIndexGate" -> complementaryIndexGate,
        "ResidueConstantGate" -> residueConstantGate,
        "NumeratorValueBridge" -> numeratorValueBridge,
        "ComplementaryValueBridges" -> complementaryValueBridges,
        "ConstantProductBridge" -> constantProductBridge,
        "ComplementaryProductBridge" -> complementaryProductBridge,
        "ComponentBridgeGate" -> componentBridgeGate,
        "ResidueConstructionGate" -> residueConstructionGate,
        "CanonicalResidueStructuralBridgeGate" -> canonicalBridgeGate,
        "Gate" -> rowGate|>]], residueRows];
  If[! exactFieldGate || ! genericIdentityGate ||
      ! AllTrue[residueBridgeRows, TrueQ[#Gate] &],
    Return[<|"Method" -> "ExactFormalFieldLagrangeCertificate",
      "CountGate" -> countGate,
      "NumeratorDegree" -> numeratorDegree,
      "ProperDegreeGate" -> properGate,
      "NumeratorExactFieldGate" -> numeratorFieldGate,
      "ConstantFieldRows" -> constantFieldRows,
      "LinearFieldRows" -> linearFieldRows,
      "DistinctRootRows" -> distinctRootRows,
      "ExactFieldGate" -> exactFieldGate,
      "GenericIdentityCertificate" -> genericIdentityCertificate,
      "PointCountEchoGate" -> pointCountEchoGate,
      "FormalDegreeEchoGate" -> formalDegreeEchoGate,
      "ObligationSchemaGate" -> obligationSchemaGate,
      "DistinctRootObligationGate" -> distinctRootObligationGate,
      "ConstantProductObligationGate" ->
        constantProductObligationGate,
      "LinearScaleObligationGate" -> linearScaleObligationGate,
      "LinearNormalizationRows" -> linearNormalizationRows,
      "LinearNormalizationObligationGate" ->
        linearNormalizationObligationGate,
      "DenominatorClearingRow" -> denominatorClearingRow,
      "DenominatorClearingObligationGate" ->
        denominatorClearingObligationGate,
      "GenericIdentityGate" -> genericIdentityGate,
      "ResidueCanonicalBridgeRows" -> residueBridgeRows,
      "ResidueCanonicalBridgeGate" -> False, "Gate" -> False|>]];
  gate = countGate && exactFieldGate && genericIdentityGate &&
    Length[residueBridgeRows] === poleCount &&
    AllTrue[residueBridgeRows, TrueQ[#Gate] &];
  <|"Method" -> "ExactFormalFieldLagrangeCertificate",
    "NumeratorDegree" -> numeratorDegree,
    "ProperDegreeGate" -> properGate,
    "NumeratorExactFieldGate" -> numeratorFieldGate,
    "CountGate" -> countGate, "PointCount" -> poleCount,
    "ConstantFieldRows" -> constantFieldRows,
    "LinearFieldRows" -> linearFieldRows,
    "DistinctRootRows" -> distinctRootRows,
    "ExactFieldGate" -> exactFieldGate,
    "GenericIdentityCertificate" -> genericIdentityCertificate,
    "PointCountEchoGate" -> pointCountEchoGate,
    "FormalDegreeEchoGate" -> formalDegreeEchoGate,
    "ObligationSchemaGate" -> obligationSchemaGate,
    "DistinctRootObligationGate" -> distinctRootObligationGate,
    "ConstantProductObligationGate" -> constantProductObligationGate,
    "LinearScaleObligationGate" -> linearScaleObligationGate,
    "LinearNormalizationRows" -> linearNormalizationRows,
    "LinearNormalizationObligationGate" ->
      linearNormalizationObligationGate,
    "DenominatorClearingRow" -> denominatorClearingRow,
    "DenominatorClearingObligationGate" ->
      denominatorClearingObligationGate,
    "GenericIdentityGate" -> genericIdentityGate,
    "ResidueCanonicalBridgeRows" -> residueBridgeRows,
    "ResidueCanonicalBridgeGate" -> True,
    "Rows" -> residueBridgeRows, "Gate" -> gate|>]

IV$CertifiedSimpleLinearResiduesExact[numerator_, factorRows_List, x_] :=
 Module[
  {expandedNumerator, numeratorDegree, numeratorCoefficients,
   canonicalNumeratorCoefficients, canonicalNumerator,
   numeratorCoefficientGate, numeratorReconstructionGate,
   exactExpressionQ, exactAlgebraicNumberQ, canonicalizeFactorRow,
   preparedFactorRows,
   inputGate, constantRows,
   linearRows, shapeGate, properGate, constantAuditRows, linearAuditRows,
   canonicalRoots, pairRows, residueRows, countGate,
   interpolationCertificate, interpolationGate, gate},
  expandedNumerator = Quiet@Check[Expand[numerator], $Failed];
  exactExpressionQ[value_] := FreeQ[value,
    number : (_Real | _Complex) /;
      ! TrueQ[ExactNumberQ[number]]];
  exactAlgebraicNumberQ[value_] := exactExpressionQ[value] &&
    SameQ[Element[value, Algebraics], True];
  If[expandedNumerator === $Failed ||
      ! PolynomialQ[expandedNumerator, x] ||
      ! FreeQ[expandedNumerator,
        _PolyLogTools`G | _Global`G | _Log | _PolyLog] ||
      ! exactExpressionQ[expandedNumerator],
    Return[<|"Gate" -> False,
      "Reason" -> "NumeratorEligibilityFailure"|>]];
  numeratorDegree = If[SameQ[expandedNumerator, 0], -Infinity,
    Exponent[expandedNumerator, x]];
  numeratorCoefficients = If[SameQ[expandedNumerator, 0], {0},
    CoefficientList[expandedNumerator, x]];
  canonicalNumeratorCoefficients = Quiet@Check[
    RootReduce /@ numeratorCoefficients, $Failed];
  numeratorCoefficientGate = ListQ[canonicalNumeratorCoefficients] &&
    FreeQ[canonicalNumeratorCoefficients, $Failed | $Aborted | _Real] &&
    AllTrue[canonicalNumeratorCoefficients, exactAlgebraicNumberQ];
  canonicalNumerator = If[! numeratorCoefficientGate, $Failed,
    Expand[Sum[canonicalNumeratorCoefficients[[power + 1]] x^power,
      {power, 0, Length[canonicalNumeratorCoefficients] - 1}]]];
  numeratorReconstructionGate = canonicalNumerator =!= $Failed &&
    TrueQ[IV$ExactPolynomialIdentityQ[
      expandedNumerator - canonicalNumerator, x]];
  canonicalizeFactorRow[row_Association] := Module[
    {factor, multiplicity, declaredDegree, degree, coefficients,
     canonicalCoefficients, canonicalFactor, coefficientGate,
     reconstructionGate, rowGate},
    factor = Lookup[row, "Factor", $Failed];
    multiplicity = Lookup[row, "Multiplicity", -1];
    declaredDegree = Lookup[row, "Degree", Missing[]];
    degree = If[factor === $Failed ||
        ! PolynomialQ[Quiet@Check[Expand[factor], $Failed], x], -1,
      Max[0, Exponent[Expand[factor], x]]];
    coefficients = If[degree < 0, $Failed,
      Table[Coefficient[Expand[factor], x, power],
        {power, 0, degree}]];
    canonicalCoefficients = If[coefficients === $Failed, $Failed,
      Quiet@Check[RootReduce /@ coefficients, $Failed]];
    coefficientGate = ListQ[canonicalCoefficients] &&
      FreeQ[canonicalCoefficients, $Failed | $Aborted | _Real] &&
      AllTrue[canonicalCoefficients, exactAlgebraicNumberQ];
    canonicalFactor = If[! coefficientGate, $Failed,
      Expand[Sum[canonicalCoefficients[[power + 1]] x^power,
        {power, 0, degree}]]];
    reconstructionGate = canonicalFactor =!= $Failed &&
      TrueQ[IV$ExactPolynomialIdentityQ[
        Expand[factor] - canonicalFactor, x]];
    rowGate = TrueQ[Lookup[row, "Gate", False]] &&
      IntegerQ[multiplicity] && multiplicity =!= 0 &&
      MemberQ[{0, 1}, degree] && SameQ[declaredDegree, degree] &&
      coefficientGate && reconstructionGate;
    <|"SourceFactor" -> factor, "Factor" -> canonicalFactor,
      "Multiplicity" -> multiplicity, "Degree" -> degree,
      "CoefficientGate" -> coefficientGate,
      "ReconstructionGate" -> reconstructionGate, "Gate" -> rowGate|>
    ];
  preparedFactorRows = If[AllTrue[factorRows, AssociationQ],
    canonicalizeFactorRow /@ factorRows, {}];
  inputGate = factorRows =!= {} &&
    Length[preparedFactorRows] === Length[factorRows] &&
    numeratorCoefficientGate && numeratorReconstructionGate &&
    AllTrue[preparedFactorRows, TrueQ[#Gate] &];
  constantRows = Select[preparedFactorRows,
    SameQ[Lookup[#, "Degree", Missing[]], 0] &];
  linearRows = Select[preparedFactorRows,
    SameQ[Lookup[#, "Degree", Missing[]], 1] &];
  shapeGate = inputGate && Length[constantRows] + Length[linearRows] ===
      Length[factorRows] && linearRows =!= {} &&
    AllTrue[linearRows, SameQ[Lookup[#, "Multiplicity", 0], 1] &];
  properGate = shapeGate && (SameQ[expandedNumerator, 0] ||
      numeratorDegree < Length[linearRows]);
  If[! properGate,
    Return[<|"Gate" -> False,
      "Reason" -> "NonSimpleOrImproperFactorShape",
      "NumeratorCoefficientGate" -> numeratorCoefficientGate,
      "NumeratorReconstructionGate" -> numeratorReconstructionGate,
      "PreparedFactorRows" -> preparedFactorRows,
      "InputGate" -> inputGate, "ShapeGate" -> shapeGate,
      "ProperGate" -> properGate|>]];
  constantAuditRows = Map[Function[row, Module[
      {factor, canonicalFactor, nonzeroGate},
      factor = row["Factor"];
      canonicalFactor = Quiet@Check[RootReduce[factor], $Failed];
      nonzeroGate = canonicalFactor =!= $Failed &&
        exactAlgebraicNumberQ[canonicalFactor] &&
        ! SameQ[canonicalFactor, 0];
      <|"Factor" -> factor,
        "Multiplicity" -> row["Multiplicity"],
        "CanonicalFactor" -> canonicalFactor,
        "NonzeroGate" -> nonzeroGate, "Gate" -> nonzeroGate|>]],
    constantRows];
  linearAuditRows = MapIndexed[Function[{row, position}, Module[
      {factor, scale, root, canonicalScale, canonicalRoot,
       scaleNonzeroGate, rootBridgeGate, factorIdentityGate, rowGate},
      factor = row["Factor"];
      scale = Coefficient[Expand[factor], x, 1];
      root = -Coefficient[Expand[factor], x, 0]/scale;
      canonicalScale = Quiet@Check[RootReduce[scale], $Failed];
      canonicalRoot = Quiet@Check[RootReduce[root], $Failed];
      scaleNonzeroGate = canonicalScale =!= $Failed &&
        exactAlgebraicNumberQ[canonicalScale] &&
        ! SameQ[canonicalScale, 0];
      rootBridgeGate = canonicalRoot =!= $Failed &&
        exactAlgebraicNumberQ[canonicalRoot] &&
        SameQ[Quiet@Check[RootReduce[root - canonicalRoot], $Failed], 0];
      factorIdentityGate = rootBridgeGate &&
        TrueQ[IV$ExactPolynomialIdentityQ[
          factor - canonicalScale (x - root), x]];
      rowGate = scaleNonzeroGate && rootBridgeGate && factorIdentityGate;
      <|"Index" -> First[position], "Factor" -> factor,
        "Multiplicity" -> row["Multiplicity"],
        "Scale" -> canonicalScale, "Root" -> root,
        "CanonicalRoot" -> canonicalRoot,
        "ScaleNonzeroGate" -> scaleNonzeroGate,
        "RootCanonicalBridgeGate" -> rootBridgeGate,
        "FactorIdentityGate" -> factorIdentityGate,
        "Gate" -> rowGate|>]], linearRows];
  canonicalRoots = Lookup[linearAuditRows, "CanonicalRoot", {$Failed}];
  pairRows = If[FreeQ[canonicalRoots, $Failed],
    Map[Function[pair, Module[{difference, distinctGate},
        difference = Quiet@Check[
          RootReduce[canonicalRoots[[First[pair]]] -
            canonicalRoots[[Last[pair]]]], $Failed];
        distinctGate = difference =!= $Failed &&
          exactAlgebraicNumberQ[difference] &&
          ! SameQ[difference, 0];
        <|"Pair" -> pair, "Difference" -> difference,
          "Gate" -> distinctGate|>]],
      Subsets[Range[Length[canonicalRoots]], {2}]], {}];
  residueRows = If[
    AllTrue[constantAuditRows, TrueQ[#Gate] &] &&
      AllTrue[linearAuditRows, TrueQ[#Gate] &] &&
      AllTrue[pairRows, TrueQ[#Gate] &],
    MapIndexed[Function[{linearRow, position}, Module[
        {index, root, scale, numeratorAtRoot, otherFactorValues,
         constantProduct, complementaryProduct, rawResidue, residue,
         residueBridgeResidual, residueAlgebraicGate,
         residueCanonicalBridgeGate, kernelGate, rowGate},
        index = First[position];
        root = linearRow["Root"];
        scale = linearRow["Scale"];
        (* Horner evaluation is essential at root zero: the naive power sum
           manufactures Indeterminate from its constant 0^0 term. *)
        numeratorAtRoot = Fold[#1 root + #2 &,
          Last[canonicalNumeratorCoefficients],
          Reverse[Most[canonicalNumeratorCoefficients]]];
        otherFactorValues = MapIndexed[
          If[First[#2] === index, 1,
            (#1["Factor"] /. x -> root)] &,
          linearAuditRows];
        constantProduct = Times @@
          (#CanonicalFactor^#Multiplicity & /@ constantAuditRows);
        complementaryProduct = Times @@ otherFactorValues;
        rawResidue = numeratorAtRoot/
          (constantProduct scale complementaryProduct);
        (* Do not RootReduce the complete residue.  In a compositum this can
           rebuild a large primitive element once per pole even though the
           residue formula is a universal field identity.  Exact algebraic
           closure follows compositionally from the certified numerator,
           constants, scales, and pairwise-distinct roots; the formal Lagrange
           certificate below binds this exact raw value to that formula. *)
        residue = rawResidue;
        residueBridgeResidual = 0;
        residueAlgebraicGate = exactExpressionQ[residue] &&
          numeratorCoefficientGate &&
          AllTrue[constantAuditRows, TrueQ[#Gate] &] &&
          AllTrue[linearAuditRows, TrueQ[#Gate] &] &&
          AllTrue[pairRows, TrueQ[#Gate] &];
        residueCanonicalBridgeGate = True;
        kernelGate = TrueQ[IV$ExactGPLZeroQ[
          PolyLogTools`DG[PolyLogTools`G[root, x], x] -
            1/(x - root)]];
        rowGate = residueAlgebraicGate &&
          residueCanonicalBridgeGate && kernelGate &&
          TrueQ[linearRow["FactorIdentityGate"]];
        <|"Index" -> index, "Root" -> root, "Scale" -> scale,
          "NumeratorAtRoot" -> numeratorAtRoot,
          "ComplementaryFactorValues" -> otherFactorValues,
          "ConstantProduct" -> constantProduct,
          "ComplementaryProduct" -> complementaryProduct,
          "RawResidue" -> rawResidue, "Residue" -> rawResidue,
          "CanonicalResidue" -> residue,
          "ResidueCertificateMode" ->
            "ExactFieldClosurePlusFormalLagrangeIdentity",
          "ResidueCanonicalBridgeResidual" -> residueBridgeResidual,
          "ResidueExactAlgebraicGate" -> residueAlgebraicGate,
          "ResidueCanonicalBridgeGate" -> residueCanonicalBridgeGate,
          "KernelDerivativeGate" -> kernelGate,
          "Gate" -> rowGate|>]], linearAuditRows], {}];
  countGate = Length[linearAuditRows] > 0 &&
    Length[canonicalRoots] === Length[linearAuditRows] &&
    Length[pairRows] === Binomial[Length[linearAuditRows], 2] &&
    Length[residueRows] === Length[linearAuditRows] &&
    AllTrue[linearAuditRows,
      KeyExistsQ[#, "Root"] && KeyExistsQ[#, "CanonicalRoot"] &] &&
    AllTrue[residueRows, KeyExistsQ[#, "Residue"] &];
  interpolationCertificate = If[! countGate,
    <|"CountGate" -> False, "Gate" -> False|>,
    IV$ExactResidueInterpolationCertificate[canonicalNumerator,
      constantAuditRows, linearAuditRows, residueRows, x]];
  interpolationGate = AssociationQ[interpolationCertificate] &&
    TrueQ[Lookup[interpolationCertificate, "Gate", False]];
  gate = properGate && countGate && interpolationGate &&
    AllTrue[constantAuditRows, TrueQ[#Gate] &] &&
    AllTrue[linearAuditRows, TrueQ[#Gate] &] &&
    AllTrue[pairRows, TrueQ[#Gate] &] && residueRows =!= {} &&
    AllTrue[residueRows, TrueQ[#Gate] &];
  <|"Method" ->
      "CertifiedFactoredSimplePoleResiduesByUniqueness",
    "Numerator" -> expandedNumerator,
    "CanonicalNumerator" -> canonicalNumerator,
    "NumeratorDegree" -> numeratorDegree,
    "DenominatorDegree" -> Length[linearRows],
    "NumeratorCoefficientGate" -> numeratorCoefficientGate,
    "NumeratorReconstructionGate" -> numeratorReconstructionGate,
    "PreparedFactorRows" -> preparedFactorRows,
    "InputGate" -> inputGate, "ShapeGate" -> shapeGate,
    "ProperGate" -> properGate, "ConstantRows" -> constantAuditRows,
    "LinearRows" -> linearAuditRows, "DistinctRootRows" -> pairRows,
    "ResidueRows" -> residueRows,
    "CountGate" -> countGate,
    "InterpolationCertificate" -> interpolationCertificate,
    "InterpolationGate" -> interpolationGate,
    "CompositionalAntiderivativeCertificateGate" -> gate,
    (* Compatibility alias for older audit consumers. *)
    "AggregateDerivativeGate" -> gate, "Gate" -> gate|>]

IV$RationalPrimitiveFromCertifiedLinearFactorsExact[
    numerator_, factorRows_List, x_] := Module[
  {decomposition, primitive},
  decomposition = IV$CertifiedSimpleLinearResiduesExact[
    numerator, factorRows, x];
  If[! AssociationQ[decomposition] ||
      ! TrueQ[Lookup[decomposition, "Gate", False]],
    $IV$LastFactoredRationalPrimitiveAudit = decomposition;
    Return[$Failed]];
  primitive = Total[(#Residue PolyLogTools`G[#Root, x] &) /@
    decomposition["ResidueRows"]];
  $IV$LastFactoredRationalPrimitiveAudit = Join[decomposition,
    <|"Primitive" -> primitive,
      "CompositionalAntiderivativeCertificateGate" -> True,
      "AggregateDerivativeGate" -> True, "Gate" -> True|>];
  primitive]

IV$RationalTimesFixedW1FromCertifiedLinearFactorsExact[
    numerator_, factorRows_List, gpl_, x_] := Module[
  {exactExpressionQ, arguments, letter, gDerivativeGate, decomposition,
   primitiveRows, primitive, gate},
  exactExpressionQ[value_] := FreeQ[value,
    number : (_Real | _Complex) /;
      ! TrueQ[ExactNumberQ[number]]];
  arguments = If[IV$GPLQ[gpl], List @@ gpl, {}];
  If[Length[arguments] =!= 2 || ! SameQ[Last[arguments], x] ||
      ! FreeQ[First[arguments], x] ||
      ! exactExpressionQ[First[arguments]],
    $IV$LastFactoredFixedW1PrimitiveAudit = <|"Gate" -> False,
      "Reason" -> "FixedWeightOneGPLShapeFailure"|>;
    Return[$Failed]];
  letter = First[arguments];
  gDerivativeGate = TrueQ[IV$ExactGPLZeroQ[
    PolyLogTools`DG[gpl, x] - 1/(x - letter)]];
  decomposition = IV$CertifiedSimpleLinearResiduesExact[
    numerator, factorRows, x];
  If[! gDerivativeGate || ! AssociationQ[decomposition] ||
      ! TrueQ[Lookup[decomposition, "Gate", False]],
    $IV$LastFactoredFixedW1PrimitiveAudit = <|
      "GPL" -> gpl, "GPLLetter" -> letter,
      "GPLDerivativeGate" -> gDerivativeGate,
      "Decomposition" -> decomposition, "Gate" -> False|>;
    Return[$Failed]];
  primitiveRows = Map[Function[row, Module[
      {word, kernelGate},
      word = PolyLogTools`G[row["Root"], letter, x];
      kernelGate = TrueQ[IV$ExactGPLZeroQ[
        PolyLogTools`DG[word, x] - gpl/(x - row["Root"])]];
      <|"Root" -> row["Root"], "Residue" -> row["Residue"],
        "Primitive" -> row["Residue"] word,
        "KernelDerivativeGate" -> kernelGate,
        "Gate" -> kernelGate|>]], decomposition["ResidueRows"]];
  gate = primitiveRows =!= {} && AllTrue[primitiveRows, TrueQ[#Gate] &];
  primitive = If[gate, Total[Lookup[primitiveRows, "Primitive"]], $Failed];
  $IV$LastFactoredFixedW1PrimitiveAudit = Join[decomposition,
    <|"GPL" -> gpl, "GPLLetter" -> letter,
      "GPLDerivativeGate" -> gDerivativeGate,
      "PrimitiveRows" -> primitiveRows, "Primitive" -> primitive,
      "CompositionalAntiderivativeCertificateGate" -> gate,
      "AggregateDerivativeGate" -> gate, "Gate" -> gate|>];
  If[gate, primitive, $Failed]]

(* Integrate an exact rational coefficient times one retained weight-one GPL
   with a fixed letter.  The certified rational partial fractions are lowered
   locally: a simple pole maps directly to a weight-two GPL, while polynomial
   and higher-pole Laurent monomials use integration by parts with a rational
   correction.  This avoids sending a finite list of local pole formulas back
   through the general fibration integrator. *)
IV$RationalTimesFixedW1PrimitiveExact[rational_, gpl_, x_] := Module[
  {gplArguments, letter, rat, gDerivativeGate, apartAudit, pieces,
   integrateRationalMonomial, integratePiece, pieceRows, primitives, gate},
  gplArguments = If[IV$GPLQ[gpl], List @@ gpl, {}];
  If[Length[gplArguments] =!= 2 ||
      ! SameQ[Last[gplArguments], x] || FreeQ[gpl, x] ||
      ! FreeQ[First[gplArguments], x | _Real],
    $IV$LastRationalTimesFixedW1Audit = <|"Gate" -> False,
      "Reason" -> "FixedWeightOneGPLShapeFailure"|>;
    Return[$Failed]];
  letter = First[gplArguments];
  If[! IV$SpecialFunctionsFreeOfXQ[rational, x] ||
      ! FreeQ[rational, _Real],
    $IV$LastRationalTimesFixedW1Audit = <|"Gate" -> False,
      "Reason" -> "RationalCoefficientEligibilityFailure"|>;
    Return[$Failed]];
  rat = Quiet@Check[Cancel[Together[rational]], $Failed];
  If[rat === $Failed,
    $IV$LastRationalTimesFixedW1Audit = <|"Gate" -> False,
      "Reason" -> "RationalCanonicalizationFailure"|>;
    Return[$Failed]];
  gDerivativeGate = TrueQ[IV$ExactGPLZeroQ[
    PolyLogTools`DG[gpl, x] - 1/(x - letter)]];
  If[! gDerivativeGate,
    $IV$LastRationalTimesFixedW1Audit = <|"Gate" -> False,
      "Reason" -> "WeightOneDerivativeFailure"|>;
    Return[$Failed]];
  If[SameQ[rat, 0],
    $IV$LastRationalTimesFixedW1Audit = <|
      "Method" -> "ExactZeroRationalTimesFixedWeightOneGPL",
      "GPL" -> gpl, "GPLLetter" -> letter,
      "GPLDerivativeGate" -> True,
      "PartialFractionAudit" -> <|"FactorRows" -> {},
        "Pieces" -> {}, "Gate" -> True|>,
      "PieceRows" -> {}, "RootRows" -> {},
      "AggregateDerivativeGate" -> True, "Gate" -> True|>;
    Return[0]];
  apartAudit = Quiet@CheckAbort[TimeConstrained[
    IV$ManualApartCertified[rat, x], 600, $Failed], $Failed];
  If[apartAudit === $Failed || ! AssociationQ[apartAudit] ||
      ! TrueQ[apartAudit["Gate"]],
    $IV$LastRationalTimesFixedW1Audit = <|"Gate" -> False,
      "Reason" -> "CertifiedPartialFractionFailure",
      "PartialFractionAudit" -> apartAudit|>;
    Return[$Failed]];
  pieces = apartAudit["Pieces"];

  integrateRationalMonomial[source_, sourcePrimitive_] := Module[
    {sourcePrimitiveGate, correctionIntegrand, correctionPrimitive,
     correctionAudit, correctionGate, candidate, rootRows, rowGate},
    sourcePrimitiveGate = sourcePrimitive =!= $Failed &&
      TrueQ[IV$ExactRationalIdentityQ[
        D[sourcePrimitive, x] - source, x]];
    correctionIntegrand = If[! sourcePrimitiveGate, $Failed,
      Quiet@Check[Cancel[Together[sourcePrimitive/(x - letter)]],
        $Failed]];
    correctionPrimitive = If[correctionIntegrand === $Failed, $Failed,
      IV$RationalPrimitiveExact[correctionIntegrand, x]];
    correctionAudit = If[correctionPrimitive === $Failed, <||>,
      $IV$LastRationalPrimitiveAudit];
    correctionGate = correctionPrimitive =!= $Failed &&
      AssociationQ[correctionAudit] &&
      TrueQ[Lookup[correctionAudit, "Gate", False]] &&
      TrueQ[Lookup[correctionAudit, "AggregateDerivativeGate", False]];
    candidate = If[! correctionGate, $Failed,
      sourcePrimitive gpl - correctionPrimitive];
    rootRows = If[! correctionGate, {},
      KeyTake[#, {"Root", "Multiplicity", "LinearIdentityGate",
          "ComplementaryRootGate", "LocalTaylorGate", "Gate"}] & /@
        Lookup[Lookup[correctionAudit, "PartialFractionAudit", <||>],
          "FactorRows", {}]];
    rowGate = sourcePrimitiveGate && correctionGate &&
      candidate =!= $Failed && ! IV$HasFrozenTermsQ[candidate];
    <|"Mode" -> "RationalIntegrationByParts",
      "Source" -> source, "SourcePrimitive" -> sourcePrimitive,
      "SourcePrimitiveGate" -> sourcePrimitiveGate,
      "CorrectionIntegrand" -> correctionIntegrand,
      "CorrectionPrimitive" -> correctionPrimitive,
      "CorrectionAudit" -> correctionAudit, "RootRows" -> rootRows,
      "Primitive" -> candidate, "DerivativeGate" -> rowGate,
      "Gate" -> rowGate|>];

  integratePiece[piece_, position_] := Module[
    {pieceRat, numerator, denominator, factors, variableFactors,
     constantFactor, factor, multiplicity, factorConstant,
     factorCoefficient, root, factorIdentityGate, factorVariable,
     numeratorInFactor, numeratorDegree, monomialRows, monomialSources,
     reconstructionGate, piecePrimitive, pieceGate},
    pieceRat = Quiet@Check[Cancel[Together[piece]], $Failed];
    If[pieceRat === $Failed,
      Return[<|"Index" -> position, "Gate" -> False,
        "Reason" -> "PieceCanonicalizationFailure"|>, Module]];
    numerator = Numerator[pieceRat];
    denominator = Denominator[pieceRat];
    If[FreeQ[denominator, x],
      If[! PolynomialQ[Expand[pieceRat], x],
        Return[<|"Index" -> position, "Gate" -> False,
          "Reason" -> "NonPolynomialRegularPiece"|>, Module]];
      piecePrimitive = IV$IntegrateLinearPieceExact[pieceRat, x];
      monomialRows = {integrateRationalMonomial[
        pieceRat, piecePrimitive]};
      pieceGate = AllTrue[monomialRows, TrueQ[#Gate] &];
      Return[<|"Index" -> position, "Piece" -> pieceRat,
        "Mode" -> "PolynomialPiece", "PieceReconstructionGate" -> True,
        "MonomialRows" -> monomialRows,
        "RootRows" -> Flatten[Lookup[monomialRows, "RootRows", {}]],
        "Primitive" -> If[pieceGate,
          Total[Lookup[monomialRows, "Primitive"]], $Failed],
        "DerivativeGate" -> pieceGate, "Gate" -> pieceGate|>, Module]];
    factors = Quiet@Check[IV$FactorListExact[denominator], $Failed];
    variableFactors = If[ListQ[factors],
      Select[factors, ! FreeQ[First[#], x] &], {}];
    If[! ListQ[factors] || Length[variableFactors] =!= 1,
      Return[<|"Index" -> position, "Gate" -> False,
        "Reason" -> "NonlocalDenominatorPiece"|>, Module]];
    factor = variableFactors[[1, 1]];
    multiplicity = variableFactors[[1, 2]];
    If[! IntegerQ[multiplicity] || multiplicity <= 0 ||
        Exponent[Expand[factor], x] =!= 1,
      Return[<|"Index" -> position, "Gate" -> False,
        "Reason" -> "NonlinearOrInvalidPole"|>, Module]];
    constantFactor = Times @@
      (#[[1]]^#[[2]] & /@ Select[factors, FreeQ[First[#], x] &]);
    factorConstant = Coefficient[Expand[factor], x, 0];
    factorCoefficient = Coefficient[Expand[factor], x, 1];
    If[TrueQ[IV$ExactAlgebraicZeroQ[factorCoefficient]],
      Return[<|"Index" -> position, "Gate" -> False,
        "Reason" -> "ZeroLinearCoefficient"|>, Module]];
    root = -factorConstant/factorCoefficient;
    factorIdentityGate = TrueQ[IV$ExactPolynomialIdentityQ[
      factor - factorCoefficient (x - root), x]];
    factorVariable = Unique["IVfixedW1Factor$"];
    numeratorInFactor = Quiet@Check[Expand[numerator /. x ->
      (factorVariable - factorConstant)/factorCoefficient], $Failed];
    If[! factorIdentityGate || numeratorInFactor === $Failed ||
        ! PolynomialQ[numeratorInFactor, factorVariable],
      Return[<|"Index" -> position, "Gate" -> False,
        "Reason" -> "LinearFactorCoordinateFailure"|>, Module]];
    numeratorDegree = Max[0, Exponent[numeratorInFactor, factorVariable]];
    monomialRows = Map[Function[j, Module[
        {coefficient, power, source, directPrimitive, directKernelGate,
         directRow, sourcePrimitive},
        coefficient = Coefficient[numeratorInFactor, factorVariable, j];
        power = j - multiplicity;
        source = coefficient factor^power/constantFactor;
        If[SameQ[coefficient, 0],
          Return[<|"LaurentPower" -> power, "Mode" -> "ExactZero",
            "Source" -> 0, "RootRows" -> {}, "Primitive" -> 0,
            "DerivativeGate" -> True, "Gate" -> True|>, Module]];
        If[SameQ[power, -1],
          directPrimitive = coefficient/
            (constantFactor factorCoefficient) Head[gpl][root, letter, x];
          directKernelGate = TrueQ[IV$ExactGPLZeroQ[
            PolyLogTools`DG[Head[gpl][root, letter, x], x] -
              gpl/(x - root)]];
          directRow = <|"LaurentPower" -> power,
            "Mode" -> "DirectSimplePoleToWeightTwoGPL",
            "Source" -> source, "PoleRoot" -> root,
            "KernelDerivativeGate" -> directKernelGate,
            "RootRows" -> {<|"Root" -> root, "Multiplicity" -> 1,
              "LinearIdentityGate" -> factorIdentityGate,
              "Gate" -> directKernelGate && factorIdentityGate|>},
            "Primitive" -> directPrimitive,
            "DerivativeGate" -> directKernelGate && factorIdentityGate,
            "Gate" -> directKernelGate && factorIdentityGate|>;
          Return[directRow, Module]];
        sourcePrimitive = coefficient factor^(power + 1)/
          (constantFactor factorCoefficient (power + 1));
        Join[<|"LaurentPower" -> power|>,
          integrateRationalMonomial[source, sourcePrimitive]]]],
      Range[0, numeratorDegree]];
    monomialSources = Lookup[monomialRows, "Source", {$Failed}];
    reconstructionGate = FreeQ[monomialSources, $Failed] &&
      TrueQ[IV$ExactRationalIdentityQ[
        Total[monomialSources] - pieceRat, x]];
    pieceGate = reconstructionGate && monomialRows =!= {} &&
      AllTrue[monomialRows, TrueQ[#Gate] &];
    <|"Index" -> position, "Piece" -> pieceRat,
      "Mode" -> "SingleLinearFactorLaurentPiece",
      "Factor" -> factor, "Multiplicity" -> multiplicity,
      "PoleRoot" -> root, "FactorIdentityGate" -> factorIdentityGate,
      "PieceReconstructionGate" -> reconstructionGate,
      "MonomialRows" -> monomialRows,
      "RootRows" -> Flatten[Lookup[monomialRows, "RootRows", {}]],
      "Primitive" -> If[pieceGate,
        Total[Lookup[monomialRows, "Primitive"]], $Failed],
      "DerivativeGate" -> pieceGate, "Gate" -> pieceGate|>];

  pieceRows = MapIndexed[
    integratePiece[#1, First[#2]] &, pieces];
  primitives = Lookup[pieceRows, "Primitive", {$Failed}];
  gate = pieceRows =!= {} && AllTrue[pieceRows, TrueQ[#Gate] &] &&
    FreeQ[primitives, $Failed];
  If[! gate,
    $IV$LastRationalTimesFixedW1Audit = <|"Gate" -> False,
      "Reason" -> "CertifiedPiecePrimitiveFailure", "GPL" -> gpl,
      "GPLLetter" -> letter, "GPLDerivativeGate" -> gDerivativeGate,
      "PartialFractionAudit" -> apartAudit,
      "PieceRows" -> pieceRows|>;
    Return[$Failed]];
  $IV$LastRationalTimesFixedW1Audit = <|
    "Method" ->
      "CertifiedPrincipalPartsPlusLocalFixedWeightOneGPLPrimitives",
    "GPL" -> gpl, "GPLLetter" -> letter,
    "GPLDerivativeGate" -> gDerivativeGate,
    "PartialFractionAudit" -> apartAudit, "PieceRows" -> pieceRows,
    "RootRows" -> Flatten[Lookup[pieceRows, "RootRows", {}]],
    "AggregateDerivativeGate" -> True, "Gate" -> True|>;
  Total[primitives]]

(* Source-preserving integration by parts for one retained weight-one GPL
   times an exact rational coefficient.  Unlike a local fibration primitive,
   the accepted candidate retains the original GPL and is differentiated back
   to the original source term. *)
IV$GPLQ[e_] := Head[e] === PolyLogTools`G || Head[e] === Global`G;
IV$GPLCases[e_] := DeleteDuplicates@Cases[e, g_ /; IV$GPLQ[g], Infinity];
IV$FreeOfGPLQ[e_] := IV$GPLCases[e] === {};
IV$SpecialFunctionsFreeOfXQ[e_, x_] := AllTrue[
  Join[IV$GPLCases[e],
    DeleteDuplicates@Cases[e, _Log | _PolyLog, Infinity]],
  FreeQ[#, x] &];

IV$SourceExactW1Primitive[term_, x_] := Module[
  {gpls, gpl, rational, rationalPrimitive, gDerivative,
   correctionIntegrand, correctionAntiderivative, candidate},
  gpls = IV$GPLCases[term];
  If[Length[gpls] =!= 1, Return[$Failed]];
  gpl = First[gpls];
  If[Length[List @@ gpl] =!= 2 || FreeQ[gpl, x], Return[$Failed]];
  rational = Quiet@Check[Cancel[Together[term/gpl]], $Failed];
  If[rational === $Failed || ! IV$FreeOfGPLQ[rational] ||
      ! FreeQ[rational, _Log | _PolyLog | _Real], Return[$Failed]];
  rationalPrimitive = IV$RationalPrimitiveExact[rational, x];
  If[rationalPrimitive === $Failed, Return[$Failed]];
  gDerivative = Quiet@CheckAbort[TimeConstrained[
    PolyLogTools`DG[gpl, x], 300, $Failed], $Failed];
  If[gDerivative === $Failed, Return[$Failed]];
  correctionIntegrand = Quiet@CheckAbort[TimeConstrained[
    Collect[Expand[rationalPrimitive gDerivative], _G | _Log,
      Together], 300, $Failed], $Failed];
  If[correctionIntegrand === $Failed, Return[$Failed]];
  correctionAntiderivative = If[
    FreeQ[correctionIntegrand, _G | _Log | _PolyLog],
    IV$RationalPrimitiveExact[correctionIntegrand, x],
    Quiet@CheckAbort[TimeConstrained[
      Block[{$IterationLimit = Infinity},
        PolyLogTools`GIntegrate[correctionIntegrand, x]], 1200,
      $Failed], $Failed]];
  If[correctionAntiderivative === $Failed ||
      IV$HasFrozenTermsQ[correctionAntiderivative] ||
      ! TrueQ[IV$ExactAntiderivativeQ[
        correctionAntiderivative, correctionIntegrand, x]],
    Return[$Failed]];
  candidate = rationalPrimitive gpl - correctionAntiderivative;
  If[! TrueQ[IV$ExactAntiderivativeQ[candidate, term, x]],
    Return[$Failed]];
  <|"Primitive" -> candidate, "SourceTerm" -> term,
    "GPL" -> gpl, "RationalPrimitive" -> rationalPrimitive,
    "GPLDerivative" -> gDerivative,
    "CorrectionIntegrand" -> correctionIntegrand,
    "CorrectionAntiderivative" -> correctionAntiderivative,
    "SourceGate" -> True|>]

(* Reconstruct a variable weight-one GPL from its exact derivative and its
   literal value at an exact regular base point.  Keeping g(x0) unevaluated
   inherits the source branch constant; no Log sign or numerical fit is used.
   This is a connected-interval gauge identity, so callers must separately
   certify cancellation at any internal branch wall. *)
IV$AnchoredW1GaugeRecord[g_, x_, lo_:0, hi_:1] := Module[
  {gDerivative, derivativePrimitive, bases, base, gBase, primitiveBase,
   fixedRepresentation, derivativeGate, anchorGate, badQ,
   result = $Failed},
  If[! IV$GPLQ[g] || Length[List @@ g] =!= 2 || FreeQ[g, x] ||
      ! FreeQ[{lo, hi}, _Real],
    If[TrueQ[$IV$DebugSourceExact], Print["[source-exact] W1 anchor shape"]];
    Return[$Failed]];
  gDerivative = Quiet@CheckAbort[TimeConstrained[
    PolyLogTools`DG[g, x], 300, $Failed], $Failed];
  If[gDerivative === $Failed || ! IV$FreeOfGPLQ[gDerivative] ||
      ! FreeQ[gDerivative, _Log | _PolyLog | _Real],
    If[TrueQ[$IV$DebugSourceExact], Print["[source-exact] W1 anchor derivative"]];
    Return[$Failed]];
  derivativePrimitive = IV$RationalPrimitiveExact[gDerivative, x];
  If[derivativePrimitive === $Failed,
    If[TrueQ[$IV$DebugSourceExact], Print["[source-exact] W1 anchor rational primitive"]];
    Return[$Failed]];
  bases = DeleteDuplicates[
    (Quiet@Together[#]) & /@
      {(lo + hi)/2, (2 lo + hi)/3, (lo + 2 hi)/3}];
  badQ[e_] := e === $Failed || IV$HasFrozenTermsQ[e] ||
    ! FreeQ[e, Indeterminate | Undefined | ComplexInfinity |
      DirectedInfinity | _Real];
  Do[
    gBase = Quiet@Check[g /. x -> base, $Failed];
    primitiveBase = Quiet@Check[derivativePrimitive /. x -> base,
      $Failed];
    If[! badQ[gBase] && ! badQ[primitiveBase],
      fixedRepresentation = derivativePrimitive + gBase - primitiveBase;
      derivativeGate = TrueQ[IV$ExactGPLZeroQ[
        PolyLogTools`DG[g, x] -
          PolyLogTools`DG[fixedRepresentation, x]]];
      anchorGate = TrueQ[IV$ExactGPLZeroQ[
        (fixedRepresentation - g) /. x -> base]];
      If[TrueQ[$IV$DebugSourceExact], Print[
        "[source-exact] W1 anchor base=", base,
        " derivative=", derivativeGate, " anchor=", anchorGate]];
      If[derivativeGate && anchorGate,
        result = <|"GPL" -> g, "GPLDerivative" -> gDerivative,
          "DerivativePrimitive" -> derivativePrimitive,
          "BasePoint" -> base, "SourceBaseValue" -> gBase,
          "FixedRepresentation" -> fixedRepresentation,
          "DerivativeGate" -> True, "AnchorGate" -> True,
          "ConnectedIntervalGauge" -> True,
          "RequiresWallAudit" -> True, "Gate" -> True|>;
        Break[]]],
    {base, bases}];
  If[AssociationQ[result], Return[result]];
  If[TrueQ[$IV$DebugSourceExact], Print["[source-exact] W1 anchor no regular certified base"]];
  $Failed]

IV$AnchoredLogGaugeRecord[log_Log, x_, lo_:0, hi_:1] := Module[
  {logDerivative, derivativePrimitive, bases, base, logBase,
   primitiveBase, fixedRepresentation, derivativeGate, anchorGate,
   badQ, result = $Failed},
  If[FreeQ[log, x] || ! FreeQ[{lo, hi}, _Real], Return[$Failed]];
  logDerivative = Quiet@Check[Cancel[Together[D[log, x]]], $Failed];
  If[logDerivative === $Failed || ! IV$FreeOfGPLQ[logDerivative] ||
      ! FreeQ[logDerivative, _Log | _PolyLog | _Real],
    Return[$Failed]];
  derivativePrimitive = IV$RationalPrimitiveExact[logDerivative, x];
  If[derivativePrimitive === $Failed, Return[$Failed]];
  bases = DeleteDuplicates[
    (Quiet@Together[#]) & /@
      {(lo + hi)/2, (2 lo + hi)/3, (lo + 2 hi)/3}];
  badQ[e_] := e === $Failed || IV$HasFrozenTermsQ[e] ||
    ! FreeQ[e, Indeterminate | Undefined | ComplexInfinity |
      DirectedInfinity | _Real];
  Do[
    logBase = Quiet@Check[log /. x -> base, $Failed];
    primitiveBase = Quiet@Check[derivativePrimitive /. x -> base,
      $Failed];
    If[! badQ[logBase] && ! badQ[primitiveBase],
      fixedRepresentation = derivativePrimitive + logBase - primitiveBase;
      derivativeGate = TrueQ[IV$ExactGPLZeroQ[
        PolyLogTools`DG[log, x] -
          PolyLogTools`DG[fixedRepresentation, x]]];
      anchorGate = TrueQ[IV$ExactGPLZeroQ[
        (fixedRepresentation - log) /. x -> base]];
      If[derivativeGate && anchorGate,
        result = <|"Log" -> log, "LogDerivative" -> logDerivative,
          "DerivativePrimitive" -> derivativePrimitive,
          "BasePoint" -> base, "SourceBaseValue" -> logBase,
          "FixedRepresentation" -> fixedRepresentation,
          "DerivativeGate" -> True, "AnchorGate" -> True,
          "ConnectedIntervalGauge" -> True,
          "RequiresWallAudit" -> True, "Gate" -> True|>;
        Break[]]],
    {base, bases}];
  result]

(* Source-preserving integration by parts for one explicit Log times a
   rational coefficient. *)
IV$SourceExactLogPrimitive[term_, x_] := Module[
  {logs, log, rational, rationalPrimitive, logDerivative,
   correctionIntegrand, correctionAntiderivative, candidate},
  logs = DeleteDuplicates@Cases[term, l_Log /; ! FreeQ[l, x], Infinity];
  If[Length[logs] =!= 1 || ! IV$FreeOfGPLQ[term] ||
      ! FreeQ[term, _PolyLog],
    Return[$Failed]];
  log = First[logs];
  rational = Quiet@Check[Cancel[Together[term/log]], $Failed];
  If[rational === $Failed || ! IV$FreeOfGPLQ[rational] ||
      ! FreeQ[rational, _Log | _PolyLog | _Real], Return[$Failed]];
  rationalPrimitive = IV$RationalPrimitiveExact[rational, x];
  If[rationalPrimitive === $Failed, Return[$Failed]];
  logDerivative = Quiet@Check[Cancel[Together[D[log, x]]], $Failed];
  If[logDerivative === $Failed || ! IV$FreeOfGPLQ[logDerivative] ||
      ! FreeQ[logDerivative, _Log | _PolyLog | _Real],
    Return[$Failed]];
  correctionIntegrand = Quiet@CheckAbort[TimeConstrained[
    Collect[Expand[rationalPrimitive logDerivative], _G | _Log,
      Together], 300, $Failed], $Failed];
  If[correctionIntegrand === $Failed, Return[$Failed]];
  correctionAntiderivative = Quiet@CheckAbort[TimeConstrained[
    Block[{$IterationLimit = Infinity},
      PolyLogTools`GIntegrate[correctionIntegrand, x]], 1200,
    $Failed], $Failed];
  If[correctionAntiderivative === $Failed ||
      IV$HasFrozenTermsQ[correctionAntiderivative] ||
      ! TrueQ[IV$ExactAntiderivativeQ[
        correctionAntiderivative, correctionIntegrand, x]],
    Return[$Failed]];
  candidate = rationalPrimitive log - correctionAntiderivative;
  If[! TrueQ[IV$ExactAntiderivativeQ[candidate, term, x]],
    Return[$Failed]];
  <|"Primitive" -> candidate, "SourceTerm" -> term,
    "Log" -> log, "RationalPrimitive" -> rationalPrimitive,
    "LogDerivative" -> logDerivative,
    "CorrectionIntegrand" -> correctionIntegrand,
    "CorrectionAntiderivative" -> correctionAntiderivative,
    "SourceGate" -> True, "RequiresWallAudit" -> False|>]

(* Source-preserving integration by parts for one retained weight-two GPL.
   First try the literal correction.  If GIntegrate needs fixed-letter form,
   lower only the variable weight-one GPLs into exact anchored gauges.  The
   latter path is accepted locally by exact derivative/gauge identities and
   explicitly carries RequiresWallAudit -> True. *)
IV$SourceExactW2Primitive[term_, x_, lo_:0, hi_:1] := Module[
  {gpls, gpl, rational, rationalPrimitive, gDerivative,
   correctionIntegrand, correctionAntiderivative, candidate,
   variableW1, gaugeRecords, gaugeRules, correctionGauged,
   sourceResidual, gaugedSourceResidual},
  gpls = IV$GPLCases[term];
  If[Length[gpls] =!= 1, Return[$Failed]];
  gpl = First[gpls];
  If[Length[List @@ gpl] =!= 3 || FreeQ[gpl, x], Return[$Failed]];
  rational = Quiet@Check[Cancel[Together[term/gpl]], $Failed];
  If[rational === $Failed || ! IV$FreeOfGPLQ[rational] ||
      ! FreeQ[rational, _Log | _PolyLog | _Real], Return[$Failed]];
  rationalPrimitive = IV$RationalPrimitiveExact[rational, x];
  If[rationalPrimitive === $Failed, Return[$Failed]];
  gDerivative = Quiet@CheckAbort[TimeConstrained[
    PolyLogTools`DG[gpl, x], 300, $Failed], $Failed];
  If[gDerivative === $Failed, Return[$Failed]];
  correctionIntegrand = Quiet@CheckAbort[TimeConstrained[
    Collect[Expand[rationalPrimitive gDerivative], _G | _Log,
      Together], 300, $Failed], $Failed];
  If[correctionIntegrand === $Failed, Return[$Failed]];
  correctionAntiderivative = Quiet@CheckAbort[TimeConstrained[
    Block[{$IterationLimit = Infinity},
      PolyLogTools`GIntegrate[correctionIntegrand, x]], 1200,
    $Failed], $Failed];
  If[correctionAntiderivative =!= $Failed &&
      ! IV$HasFrozenTermsQ[correctionAntiderivative] &&
      TrueQ[IV$ExactAntiderivativeQ[
        correctionAntiderivative, correctionIntegrand, x]],
    candidate = rationalPrimitive gpl - correctionAntiderivative;
    If[TrueQ[IV$ExactAntiderivativeQ[candidate, term, x]],
      Return[<|"Primitive" -> candidate, "SourceTerm" -> term,
        "GPL" -> gpl, "RationalPrimitive" -> rationalPrimitive,
        "GPLDerivative" -> gDerivative,
        "CorrectionIntegrand" -> correctionIntegrand,
        "CorrectionAntiderivative" -> correctionAntiderivative,
        "Mode" -> "DirectCorrection", "SourceGate" -> True,
        "RequiresWallAudit" -> False|>]]];
  variableW1 = Select[IV$GPLCases[correctionIntegrand],
    Length[List @@ #] === 2 && ! FreeQ[#, x] &];
  If[variableW1 === {}, Return[$Failed]];
  gaugeRecords = IV$AnchoredW1GaugeRecord[#, x, lo, hi] & /@ variableW1;
  If[MemberQ[gaugeRecords, $Failed] ||
      ! AllTrue[gaugeRecords, TrueQ[#Gate] &], Return[$Failed]];
  gaugeRules = (#GPL -> #FixedRepresentation) & /@ gaugeRecords;
  correctionGauged = Quiet@CheckAbort[TimeConstrained[
    Collect[Expand[correctionIntegrand /. gaugeRules], _G | _Log,
      Together], 300, $Failed], $Failed];
  If[correctionGauged === $Failed ||
      ! FreeQ[correctionGauged, Alternatives @@ variableW1],
    Return[$Failed]];
  correctionAntiderivative = Quiet@CheckAbort[TimeConstrained[
    Block[{$IterationLimit = Infinity},
      PolyLogTools`GIntegrate[correctionGauged, x]], 1200,
    $Failed], $Failed];
  If[correctionAntiderivative === $Failed ||
      IV$HasFrozenTermsQ[correctionAntiderivative] ||
      ! TrueQ[IV$ExactAntiderivativeQ[
        correctionAntiderivative, correctionGauged, x]],
    Return[$Failed]];
  candidate = rationalPrimitive gpl - correctionAntiderivative;
  sourceResidual = Quiet@CheckAbort[TimeConstrained[
    PolyLogTools`DG[candidate, x] - term, 300, $Failed], $Failed];
  If[sourceResidual === $Failed, Return[$Failed]];
  gaugedSourceResidual = Quiet@CheckAbort[TimeConstrained[
    Collect[Expand[sourceResidual /. gaugeRules], _G | _Log,
      Together], 300, $Failed], $Failed];
  If[gaugedSourceResidual === $Failed ||
      ! TrueQ[IV$ExactGPLZeroQ[gaugedSourceResidual]], Return[$Failed]];
  <|"Primitive" -> candidate, "SourceTerm" -> term,
    "GPL" -> gpl, "RationalPrimitive" -> rationalPrimitive,
    "GPLDerivative" -> gDerivative,
    "CorrectionIntegrand" -> correctionIntegrand,
    "VariableWeightOneGPLs" -> variableW1,
    "GaugeRecords" -> gaugeRecords, "GaugeRules" -> gaugeRules,
    "CorrectionGauged" -> correctionGauged,
    "CorrectionAntiderivative" -> correctionAntiderivative,
    "SourceResidual" -> sourceResidual,
    "GaugedSourceResidual" -> gaugedSourceResidual,
    "Mode" -> "AnchoredW1Gauge", "SourceGate" -> True,
    "RequiresWallAudit" -> True|>]

(* Complete-expression fallback for sources containing several variable
   weight-one GPLs and/or Logs.  Each factor is put in an independently
   anchored exact gauge, then the whole source is integrated and proved back
   modulo precisely those gauge identities. *)
IV$SourceExactGaugedExpressionPrimitive[term_, x_, lo_:0, hi_:1] := Module[
  {variableW1, variableLogs, gplGaugeRecords, logGaugeRecords,
   gaugeRecords, gaugeRules, gaugedSource, antiderivative,
   sourceResidual, gaugedSourceResidual},
  variableW1 = Select[IV$GPLCases[term],
    Length[List @@ #] === 2 && ! FreeQ[#, x] &];
  variableLogs = DeleteDuplicates@Cases[term,
    log_Log /; ! FreeQ[log, x], Infinity];
  If[variableW1 === {} && variableLogs === {}, Return[$Failed]];
  gplGaugeRecords = IV$AnchoredW1GaugeRecord[#, x, lo, hi] & /@
    variableW1;
  logGaugeRecords = IV$AnchoredLogGaugeRecord[#, x, lo, hi] & /@
    variableLogs;
  gaugeRecords = Join[gplGaugeRecords, logGaugeRecords];
  If[MemberQ[gaugeRecords, $Failed] ||
      ! AllTrue[gaugeRecords, TrueQ[#Gate] &], Return[$Failed]];
  gaugeRules = Join[(#GPL -> #FixedRepresentation) & /@
      gplGaugeRecords,
    (#Log -> #FixedRepresentation) & /@ logGaugeRecords];
  gaugedSource = Quiet@CheckAbort[TimeConstrained[
    Collect[Expand[term /. gaugeRules],
      _PolyLogTools`G | _Global`G | _Log, Together], 900, $Failed],
    $Failed];
  If[gaugedSource === $Failed ||
      AnyTrue[Join[variableW1, variableLogs],
        ! FreeQ[gaugedSource, #] &], Return[$Failed]];
  antiderivative = Quiet@CheckAbort[TimeConstrained[
    Block[{$IterationLimit = Infinity},
      PolyLogTools`GIntegrate[gaugedSource, x]], 5400, $Failed],
    $Failed];
  If[antiderivative === $Failed || IV$HasFrozenTermsQ[antiderivative] ||
      ! TrueQ[IV$ExactAntiderivativeQ[antiderivative, gaugedSource, x]],
    Return[$Failed]];
  sourceResidual = Quiet@CheckAbort[TimeConstrained[
    PolyLogTools`DG[antiderivative, x] - term, 600, $Failed],
    $Failed];
  If[sourceResidual === $Failed, Return[$Failed]];
  gaugedSourceResidual = Quiet@CheckAbort[TimeConstrained[
    Collect[Expand[sourceResidual /. gaugeRules],
      _PolyLogTools`G | _Global`G | _Log, Together], 900, $Failed],
    $Failed];
  If[gaugedSourceResidual === $Failed ||
      ! TrueQ[IV$ExactGPLZeroQ[gaugedSourceResidual]], Return[$Failed]];
  <|"Primitive" -> antiderivative, "SourceTerm" -> term,
    "VariableWeightOneGPLs" -> variableW1,
    "VariableLogs" -> variableLogs,
    "GPLGaugeRecords" -> gplGaugeRecords,
    "LogGaugeRecords" -> logGaugeRecords,
    "GaugeRules" -> gaugeRules, "GaugedSource" -> gaugedSource,
    "SourceResidual" -> sourceResidual,
    "GaugedSourceResidual" -> gaugedSourceResidual,
    "Mode" -> "CompleteAnchoredGauge", "SourceGate" -> True,
    "RequiresWallAudit" -> True|>]

IV$SourceExactWeightedPrimitive[term_, x_, lo_:0, hi_:1] := Module[
  {gpls = IV$GPLCases[term], result, rationalPrimitive},
  result = Which[
    IV$SpecialFunctionsFreeOfXQ[term, x] && FreeQ[term, _Real],
      rationalPrimitive = IV$RationalPrimitiveExact[term, x];
      If[rationalPrimitive === $Failed, $Failed,
        <|"Primitive" -> rationalPrimitive, "SourceTerm" -> term,
          "Mode" -> "ExactRational", "SourceGate" -> True,
          "RequiresWallAudit" -> False|>],
    Length[gpls] === 1 && Length[List @@ First[gpls]] === 2,
      IV$SourceExactW1Primitive[term, x],
    Length[gpls] === 1 && Length[List @@ First[gpls]] === 3,
      IV$SourceExactW2Primitive[term, x, lo, hi],
    gpls === {} && ! FreeQ[term, _Log],
      IV$SourceExactLogPrimitive[term, x],
    True, $Failed];
  If[result === $Failed,
    result = IV$SourceExactGaugedExpressionPrimitive[term, x, lo, hi]];
  If[AssociationQ[result] && TrueQ[result["SourceGate"]], result,
    $Failed]]

(* Large expanded boundaries can contain thousands of rational multiples of
   the same variable weight-one GPL.  Integrating those addends separately
   repeats the identical GPL derivative and correction calculation.  Batch
   only literal single-GPL sources with exact rational coefficients, and
   accept the partition only after proving that its total is unchanged. *)
IV$BatchRepeatedW1SourceTerms[terms_List, x_] := Module[
  {tagged, eligible, ineligible, groups, batches, result, batchGroup},
  If[! TrueQ[$IV$BatchRepeatedW1Sources] || Length[terms] < 2,
    Return[terms]];
  tagged = Map[Function[term, Module[{gpls, gpl, coefficient},
      gpls = IV$GPLCases[term];
      If[Length[gpls] =!= 1, Return[{term, $Failed}, Module]];
      gpl = First[gpls];
      If[Length[List @@ gpl] =!= 2 || FreeQ[gpl, x],
        Return[{term, $Failed}, Module]];
      coefficient = Quiet@Check[Cancel[Together[term/gpl]], $Failed];
      If[coefficient === $Failed || ! IV$FreeOfGPLQ[coefficient] ||
          ! FreeQ[coefficient, _Log | _PolyLog | _Real],
        {term, $Failed}, {term, gpl}]]], terms];
  eligible = Select[tagged, Last[#] =!= $Failed &];
  If[eligible === {}, Return[terms]];
  ineligible = First /@ Select[tagged, Last[#] === $Failed &];
  groups = GatherBy[eligible, Last];
  batchGroup[group_List] := Module[
    {groupTerms = First /@ group, gpl = Last[First[group]],
     source, coefficient, splitPoint},
    source = Total[groupTerms];
    coefficient = Quiet@Check[Cancel[Together[source/gpl]], $Failed];
    If[Length[group] <= 1 ||
        (coefficient =!= $Failed &&
          TrueQ[IV$FreeOfGPLQ[coefficient]] &&
          FreeQ[coefficient, _Log | _PolyLog | _Real] &&
          LeafCount[coefficient] <= $IV$W1BatchCoefficientLeafLimit),
      Return[{source}]];
    splitPoint = Ceiling[Length[group]/2];
    Join[batchGroup[Take[group, splitPoint]],
      batchGroup[Drop[group, splitPoint]]]];
  batches = Flatten[batchGroup /@ groups, 1];
  result = Join[ineligible, batches];
  If[TrueQ[IV$ExactGPLZeroQ[Total[result] - Total[terms]]],
    result, terms]]

IV$ExactAntiderivativeWithGaugeQ[anti_, integrand_, x_,
    gaugeRules_List:{}] := Module[{residual, gaugedResidual},
  If[TrueQ[IV$ExactAntiderivativeQ[anti, integrand, x]], Return[True]];
  If[gaugeRules === {}, Return[False]];
  residual = Quiet@CheckAbort[TimeConstrained[
    PolyLogTools`DG[anti, x] - integrand, 600, $Failed], $Failed];
  If[residual === $Failed, Return[False]];
  gaugedResidual = Quiet@CheckAbort[TimeConstrained[
    Collect[Expand[residual /. gaugeRules],
      _PolyLogTools`G | _Global`G | _Log, Together], 900, $Failed],
    $Failed];
  gaugedResidual =!= $Failed && TrueQ[IV$ExactGPLZeroQ[gaugedResidual]]]

IV$SafeExactSubstituteGaugeRules[gaugeRules_List, rules_List] := Module[
  {substituted},
  If[gaugeRules === {} || rules === {}, Return[gaugeRules]];
  substituted = (With[
      {left = IV$SafeExactSubstitute[First[#], rules],
       right = IV$SafeExactSubstitute[Last[#], rules]},
      If[left === $Failed || right === $Failed, $Failed,
        left -> right]]) & /@ gaugeRules;
  If[MemberQ[substituted, $Failed], $Failed, substituted]]

(* Resolve frozen/unevaluated terms in the final result:
   - Derivative[0,1][G][a, z] = d/dz G(a,z) = 1/(z-a)
   - Gint[Apart[Indeterminate,...], ...] -> 0
   - Gint[Apart[c, n], lo, hi] for constant c -> G[c, hi] *)
IV$ResolveFrozen[expr_] := Module[{out = expr},
  (* G-function derivatives: Derivative[0,1][G][a, z] = 1/(z-a) *)
  out = out /. Derivative[0, 1][G][a_, z_] :> 1/(z - a);
  (* Also handle Derivative[n_, 1][G] patterns *)
  out = out /. Derivative[__, 1][G][args__] :> Module[{al = {args}},
    1/(Last[al] - First[al])];
  (* Frozen Gint terms *)
  out = out /. Gint[Apart[Indeterminate, _], __] -> 0;
  out = out /. Gint[Apart[c_, n_], lo_, hi_] /; FreeQ[c, x1|x2|x3|x4|v1|v2|v3] :> G[Simplify[c], hi];
  out = out /. Gint[f_, lo_, hi_] /; FreeQ[f, G] && FreeQ[f, Gint] && FreeQ[f, Log] :>
    Quiet[Check[Module[{tDummy, tmp},
      tmp = Integrate[f, {tDummy, lo, hi}];
      If[FreeQ[tmp, Integrate], tmp, Gint[f, lo, hi]]], Gint[f, lo, hi]]];
  out
]

(* --- 6F: Core PLT Integration Step --- *)

(* ---- BOUNDS FIX (2026-07-13, step D) ----
   IV$TryIntegrate had NO lo/hi parameters at all and hardcoded
       IV$EvalDefinite[antideriv, xa, 0, 1, regSym]
   so ANY integral with a PARAMETRIC bound was silently evaluated over the WRONG
   range.  (cof10 integrates u over [0, u11]; only the [Last] block honoured the
   bounds, every other path did not.)  `hi` and `lo` were even declared as dead
   Module locals here — they must go, or the pattern values would be substituted
   into the local list (Module::lvsym).
   For the unit bounds lo=0, hi=1 this change is a STRICT NO-OP: every transformed
   range below collapses back to [0,1]. *)
IV$TryIntegrate[expr_, xa_, fibVars_List, fitList_List, regSym_,
    lo_:0, hi_:1] :=
Module[{fibExpr, antideriv, result},
  (* template path first (per-G caches, ginsh-validated); $Failed -> stock *)
  fibExpr = Quiet@CheckAbort[TimeConstrained[
    IV$FibExpr[expr, fibVars, fitList], 120, $Failed], $Failed];
  If[fibExpr=!=$Failed && IV$HasFrozenTermsQ[fibExpr], fibExpr=$Failed];
  If[fibExpr===$Failed,
    fibExpr = Quiet@CheckAbort[TimeConstrained[
      Check[ToFibrationBasis[expr, fibVars, FitValue->fitList],$Failed],120,$Failed],$Failed];
    If[fibExpr=!=$Failed && IV$HasFrozenTermsQ[fibExpr], fibExpr=$Failed]];
  If[fibExpr===$Failed && Length[fibVars]>1,
    fibExpr = Quiet@CheckAbort[TimeConstrained[
      IV$FibExpr[expr, {xa}, fitList], 60, $Failed], $Failed];
    If[fibExpr=!=$Failed && IV$HasFrozenTermsQ[fibExpr], fibExpr=$Failed]];
  If[fibExpr===$Failed && Length[fibVars]>1,
    fibExpr = Quiet@CheckAbort[TimeConstrained[
      Check[ToFibrationBasis[expr,{xa},FitValue->fitList],$Failed],60,$Failed],$Failed];
    If[fibExpr=!=$Failed && IV$HasFrozenTermsQ[fibExpr], fibExpr=$Failed]];
  If[fibExpr===$Failed || ! TrueQ[IV$FTFibDoneQ[fibExpr, {xa}]] ||
      ! TrueQ[IV$FTValidate2[expr, fibExpr, xa, fitList, {}]],
    Return[$Failed]];
  (* ginsh/CiTi may Abort[] on a syntactically valid but unsupported aggregate.
     This is an optional fast attempt: contain that abort here so the caller can
     continue to substitutions and the source-exact termwise path. *)
  antideriv = Quiet@CheckAbort[
    TimeConstrained[GIntegrate[fibExpr,xa],120,$Failed], $Failed];
  If[antideriv===$Failed || IV$HasFrozenTermsQ[antideriv] ||
      ! TrueQ[IV$ExactAntiderivativeQ[antideriv, fibExpr, xa]],
    Return[$Failed]];
  result = Quiet@CheckAbort[
    IV$EvalDefinite[antideriv, xa, lo, hi, regSym], $Failed];
  If[result===$Failed, Return[$Failed]];
  If[IV$HasFrozenTermsQ[result], Return[$Failed]];
  Collect[result, _G, Simplify]]

IV$LastResortIntegrate[expr_, xa_, lo_, hi_, regSym_, verbose_] := Module[{ad,r},
  If[verbose, Print["    Last resort: raw GIntegrate (180s timeout)..."]];
  ad = Quiet[TimeConstrained[GIntegrate[expr, xa], 180, $Failed]];
  If[ad===$Failed || IV$HasFrozenTermsQ[ad] ||
      ! TrueQ[IV$ExactAntiderivativeQ[ad, expr, xa]],
    If[verbose, Print["    Last resort: antiderivative gate failed"]];
    Return[$Failed]];
  (* Sanity check 1: GIntegrate silently returns xa-free expr when it can't process *)
  If[!FreeQ[expr, xa] && FreeQ[ad, xa],
    If[verbose, Print["    Last resort: GIntegrate returned xa-free antideriv \[LongDash] silent failure"]];
    Return[$Failed]];
  r = IV$EvalDefinite[ad, xa, lo, hi, regSym];
  If[r === $Failed, Return[$Failed]];
  (* Sanity check 2: if final r is 0 but integrand isn't trivially 0, fail *)
  If[(r === 0 || (NumericQ[r] && r == 0)) && !TrueQ[Together[expr] === 0],
    If[verbose, Print["    Last resort: GIntegrate result collapsed to 0 \[LongDash] silent failure"]];
    Return[$Failed]];
  Collect[r, _G, Simplify]]

(* --- 6G: Full Integration Step with all UGI strategies --- *)

(* v9 (2026-07-03): universal CheckAbort — a ginsh/CiTi abort in ANY caller
   (main loop, retry loops, BF dives) must cost one step, not the kernel.
   Wrapper delegates to the original (renamed Core). *)
(* F1 (2026-08-29): a lambda root minted in THIS step whose value still
   depends on a variable that is NOT YET integrated (remainOrder) would be
   carried through that variable's integration as a constant -- unsound.
   The best-first caller only checks the raw step result for leftover
   variables (not the result //. lambda rules), so such a step used to count
   as "ok" and the defect surfaced only at the final incomplete-integral guard
   (test_orderhint pt1:6, 2026-08-28: IVlam1a/1b depended on t1 with t1
   integrated last).  Fail the step here so the order search discards the
   prefix immediately.  Purely additive: a sound step never mints such a
   lambda.  $IV$LamRemainingGuardHits counts rejections (diagnostic). *)
IV$IntegrateStep[expr_, xa_, lo_, hi_, remainOrder_List, rest___] := Module[{r},
  r = CheckAbort[IV$IntegrateStepCore[expr, xa, lo, hi, remainOrder, rest],
    {$Failed, {}}];
  If[ListQ[r] && Length[r] === 2 && r[[1]] =!= $Failed && ListQ[r[[2]]] &&
     remainOrder =!= {} && ! FreeQ[r[[2]], Alternatives @@ remainOrder],
    $IV$LamRemainingGuardHits = If[IntegerQ[$IV$LamRemainingGuardHits],
      $IV$LamRemainingGuardHits + 1, 1];
    If[TrueQ[Last[{rest, False}]],
      Print["    [LamGuard] step ", xa, " minted lambda root(s) depending on ",
        Select[remainOrder, ! FreeQ[r[[2]], #] &],
        " (not yet integrated) -- step rejected"]];
    {$Failed, {}},
    r]];
IV$IntegrateStep[args___] := CheckAbort[IV$IntegrateStepCore[args], {$Failed, {}}];
IV$IntegrateStepCore[expr_, xa_, lo_, hi_, remainOrder_List, mainFit_Association,
  paramFit_Association, regSym_, isLast_:False, verbose_:True] :=
Module[{fibVars, fitList, result, w, workExpr = expr, lamRules = {},
        exprSub, fitSub, fibSub, termByTermHardFail = False},
  IV$FTDrainLams[];  (* clear stale template-engine lambda rules from a prior step *)
  fibVars = Join[{xa}, remainOrder];
  fitList = IV$BuildFitList[expr, fibVars, mainFit, paramFit];
  If[verbose, Print["  Integrating ",xa," [",lo,",",hi,"] (",Length[remainOrder]," remaining)..."]];

  (* Fast path for purely-rational integrands (no G, no Log, no PolyLog).
     PLT's Gint pattern-matcher is exponentially slow on large rational
     expressions because it dispatches over many rules per term. Each Apart
     term has form c(other_vars) * (linear_in_xa)^n \[LongDash] we can compute the
     antiderivative DIRECTLY by formula, bypassing Gint:
       Integrate[c (a+b xa)^n, xa] = c (a+b xa)^(n+1) / (b(n+1))    for n != -1
       Integrate[c / (a+b xa), xa] = c Log[a+b xa] / b = c G[-a/b, xa] / b
     This is the standard rational-fraction integration. *)
  If[FreeQ[workExpr, _G] && FreeQ[workExpr, _Log] && FreeQ[workExpr, _PolyLog],
    If[verbose, Print["    Fast path: rational integrand, direct Apart + manual integration"]];
    Module[{apartResult, terms, antid, r},
      apartResult = Quiet[TimeConstrained[Apart[workExpr, xa], 60, $Failed]];
      If[apartResult === $Failed,
        If[verbose, Print["    Apart timed out; trying exact manual partial fractions"]];
        apartResult = Quiet[TimeConstrained[
          IV$ManualApart[workExpr, xa], 600, $Failed]]];
      If[apartResult =!= $Failed,
        terms = If[Head[apartResult] === Plus, List @@ apartResult, {apartResult}];
        If[verbose, Print["    Apart: ", Length[terms], " terms, LC ", LeafCount[apartResult]]];
        (* Directly integrate each term. Each term is c * (linear in xa)^n form
           after Apart, OR a polynomial in xa (the polynomial-part residual). *)
        antid = Quiet[TimeConstrained[Catch[
          Sum[IV$IntegratePiece[terms[[i]], xa,
            Function[Throw[$Failed, "rational-fast"]]],
            {i, Length[terms]}], "rational-fast"], 120, $Failed]];
        If[antid =!= $Failed && !IV$HasFrozenTermsQ[antid] &&
            TrueQ[IV$ExactAntiderivativeQ[antid, workExpr, xa]],
          If[verbose, Print["    Antiderivative LC: ", LeafCount[antid]]];
          r = IV$EvalDefinite[antid, xa, lo, hi, regSym];
          If[r =!= $Failed && !IV$HasFrozenTermsQ[r],
            If[verbose, Print["    Fast path succeeded, result LC: ", LeafCount[r]]];
            Return[{Collect[r, _G, Simplify], {}}],
            If[verbose, Print["    Fast path EvalDefinite failed; falling through to PLT"]]],
          If[verbose, Print["    Fast path direct integrate/derivative gate failed; falling through to PLT"]]],
        If[verbose, Print["    Fast path Apart failed/timeout; falling through to PLT"]]]]];

  (* Pre-check: singular G-args at xa=hi *)
  Module[{gArgs, hasSingular, w2, exprPre, fitPre, fibPre},
    gArgs = Cases[workExpr, G[args__,_]:>{args}, Infinity] // Flatten // DeleteDuplicates;
    hasSingular = AnyTrue[gArgs, !FreeQ[#,xa] && (
      !NumericQ[Quiet[#/.xa->N[hi]]] || Abs[Quiet[#/.xa->N[hi]]]>10^6 ||
      Quiet[#/.xa->N[hi]]===ComplexInfinity || Quiet[#/.xa->N[hi]]===Indeterminate) &];
    If[hasSingular && LeafCount[workExpr] < 5000,
      If[verbose, Print["    Pre-substituting ",xa," -> ",hi,"-w"]];
      w2=Unique["w"]; exprPre=workExpr/.xa->(hi-w2);
      fitPre=fitList/.(xa->v_):>(w2->hi-v); fibPre=fibVars/.xa->w2;
      (* w2 = hi - xa, so xa in [lo,hi]  <=>  w2 in [0, hi-lo]  (= [0,1] when lo=0,hi=1) *)
      result = Quiet@CheckAbort[
        IV$TryIntegrate[exprPre,w2,fibPre,fitPre,regSym,0,hi-lo],
        $Failed];
      If[result=!=$Failed, If[verbose,Print["    Pre-substitution succeeded."]]; Return[{result,{}}]];
      IV$FTDrainLams[];
      If[verbose, Print["    Pre-substitution failed; trying standard..."]],
      If[hasSingular && verbose,
        Print["    Singular endpoint detected, but LC=", LeafCount[workExpr],
          " >= 5000: deferring to exact term-by-term boundary handling"]]]];

  (* For the LAST variable: fibrate first (with kinematics) to expose quadratics,
     then lambda sub, then re-fibrate with lambdas, then GIntegrate.
     This matches the notebook's strategy for 3-prop integrals. *)
  If[isLast,
    Module[{fibExpr1, extFibVars, extFitList, lamExpr, newLamRules, lamFits, fibExpr2, antid, r, inGQ},
      (* Step 1: first fibration with kinematic symbols.
         Try two orderings: integration var first (for 3-prop), then lexicographic (for 4-prop).
         Use whichever gives a non-frozen result. *)
      Module[{kinSyms = Sort[Select[IV$AllSyms[workExpr], !MemberQ[fibVars,#]&]],
              orderings, bestFib = $Failed},
        orderings = DeleteDuplicates[{Union[fibVars, kinSyms], Join[fibVars, kinSyms]}];
        orderings = DeleteDuplicates[orderings];
        Do[
          extFibVars = ord;
          extFitList = IV$BuildFitList[workExpr, extFibVars, mainFit, paramFit];
          If[verbose, Print["    [Last] Trying fibration with ", extFibVars]];
          fibExpr1 = Quiet@CheckAbort[TimeConstrained[
            IV$FibExpr[workExpr, extFibVars, extFitList], 60, $Failed], $Failed];
          If[fibExpr1 === $Failed,
            fibExpr1 = Quiet@CheckAbort[TimeConstrained[
              ToFibrationBasis[workExpr, extFibVars, FitValue->extFitList], 60, $Failed], $Failed]];
          If[fibExpr1 =!= $Failed && !IV$HasFrozenTermsQ[fibExpr1] &&
              TrueQ[IV$FTFibDoneQ[fibExpr1, {xa}]] &&
              TrueQ[IV$FTValidate2[workExpr, fibExpr1, xa, extFitList, {}]],
            bestFib = fibExpr1; Break[]],
        {ord, orderings}];
        fibExpr1 = bestFib];
      (* If fibration has CiTi, try LambdasInG BEFORE fibration *)
      If[(fibExpr1 === $Failed || IV$HasFrozenTermsQ[fibExpr1]),
        Module[{preLam, preLamRules},
          {preLam, preLamRules} = IV$ApplyLambdasInG[workExpr, xa, verbose];
          If[Length[preLamRules] > 0,
            If[verbose, Print["    [Last] Pre-fibration LambdasInG, re-fibrating..."]];
            Module[{preLamFits, preFibVars, preFitList},
              preLamFits = Select[(#[[1]]->Quiet@N[#[[2]]/.Normal[mainFit]/.Normal[paramFit]])&/@preLamRules, NumericQ[#[[2]]]&];
              preFibVars = Join[fibVars, Sort[DeleteCases[Union[extFibVars, preLamRules[[All,1]]], Alternatives@@fibVars]]];
              preFitList = Join[extFitList, preLamFits];
              fibExpr1 = Quiet@CheckAbort[TimeConstrained[
                IV$FibExpr[preLam, preFibVars, preFitList], 120, $Failed], $Failed];
              If[fibExpr1 === $Failed,
                fibExpr1 = Quiet@CheckAbort[TimeConstrained[
                  ToFibrationBasis[preLam, preFibVars, FitValue->preFitList], 120, $Failed], $Failed]];
              If[fibExpr1 =!= $Failed && !IV$HasFrozenTermsQ[fibExpr1] &&
                  TrueQ[IV$FTFibDoneQ[fibExpr1, {xa}]] &&
                  TrueQ[IV$FTValidate2[preLam, fibExpr1, xa, preFitList,
                    preLamRules]],
                lamRules = preLamRules;
                If[verbose, Print["    [Last] Pre-LambdasInG + fibration succeeded!"]]]
            ]]]];
      If[fibExpr1 =!= $Failed && !IV$HasFrozenTermsQ[fibExpr1],
        (* Step 2: lambda substitution on coefficients AND G-function arguments *)
        {lamExpr, newLamRules} = IV$ApplyLambdas[fibExpr1, xa, verbose];
        inGQ = False;
        (* Also check G-function arguments for quadratics.  NB this one REWRITES G
           ARGUMENTS, so it genuinely invalidates the fibration; the coefficient-only
           IV$ApplyLambdas above does not. *)
        If[Length[newLamRules] == 0,
          {lamExpr, newLamRules} = IV$ApplyLambdasInG[fibExpr1, xa, verbose];
          inGQ = Length[newLamRules] > 0];
        If[Length[newLamRules] > 0,
          lamRules = newLamRules;
          lamFits = Select[(#[[1]]->Quiet@N[#[[2]]/.Normal[mainFit]/.Normal[paramFit]])&/@newLamRules, NumericQ[#[[2]]]&];
          (* Step 3: re-fibrate with lambda symbols *)
          Module[{lamSyms = newLamRules[[All,1]], reFibVars, reFitList},
            (* ---- NO REDUNDANT RE-FIBRATION (2026-07-13) ----
               IV$ApplyLambdas rewrites only the rational COEFFICIENTS: it turns a
               quadratic-in-xa denominator into (lam1+xa)(lam2+xa).  It does not
               touch a single G.  So if fibExpr1 was already in fibration basis
               w.r.t. xa, lamExpr still is, and there is NOTHING to re-fibrate —
               re-fibrating the whole expression (with the lambda symbols added to
               the alphabet) is pure waste and is what grinds the last step.
               This is exactly what the user does by hand (In[563]-In[565]):
                 fibrate -> rewrite the quadratic denominator into (lam+x)(lam+x)
                 -> GIntegrate.  No second fibration.
               IV$ApplyLambdasInG DOES rewrite G arguments, so that case must still
               re-fibrate — hence the inGQ flag. *)
            reFitList = Join[extFitList, lamFits];
            If[!TrueQ[inGQ] && TrueQ[IV$FTInBasisQ[lamExpr, xa]],
              fibExpr2 = lamExpr;
              If[verbose,
                Print["    [Last] lambdas touch COEFFICIENTS only -> no re-fibration"]],
            (* else: the G arguments changed (or we are not in basis) -> re-fibrate *)
            reFibVars = Join[fibVars, Sort[DeleteCases[Union[extFibVars, lamSyms], Alternatives@@fibVars]]];
            If[verbose, Print["    [Last] Re-fibrating with lambdas: ", reFibVars]];
            fibExpr2 = Quiet@CheckAbort[TimeConstrained[
              IV$FibExpr[lamExpr, reFibVars, reFitList], 120, $Failed], $Failed];
            If[fibExpr2 === $Failed,
              fibExpr2 = Quiet@CheckAbort[TimeConstrained[
                ToFibrationBasis[lamExpr, reFibVars, FitValue->reFitList], 120, $Failed], $Failed]]];
            If[fibExpr2 =!= $Failed && ! IV$HasFrozenTermsQ[fibExpr2] &&
                TrueQ[IV$FTFibDoneQ[fibExpr2, {xa}]] &&
                TrueQ[IV$FTValidate2[lamExpr, fibExpr2, xa, reFitList,
                  newLamRules]],
              (* Step 4: GIntegrate *)
              If[TrueQ[$IV$DebugLast],
                Print["[DBG] fibExpr2 LC=", LeafCount[fibExpr2],
                  "  inbasis=", IV$FTInBasisQ[fibExpr2, xa],
                  "  badG=", Length[DeleteDuplicates@Cases[fibExpr2,
                     g_G /; !FreeQ[Most[List @@ g], xa], {0, Infinity}]]];
                Global`DBG$fib2 = fibExpr2; Global`DBG$refit = reFitList];
              antid = Quiet@CheckAbort[
                TimeConstrained[GIntegrate[fibExpr2, xa], 120, $Failed],
                $Failed];
              If[TrueQ[$IV$DebugLast],
                Print["[DBG] antid ", If[antid === $Failed, "$Failed",
                  "LC=" <> ToString[LeafCount[antid]] <> " frozen=" <>
                  ToString[IV$HasFrozenTermsQ[antid]]]];
                Global`DBG$antid = antid];
              If[antid =!= $Failed && !IV$HasFrozenTermsQ[antid] &&
                  TrueQ[IV$ExactAntiderivativeQ[antid, fibExpr2, xa]],
                (* CheckAbort: IV$EvalDefinite ABORTS on a huge antiderivative and
                   would otherwise unwind the whole step.  No time cap. *)
                r = Quiet@CheckAbort[
                  IV$EvalDefinite[antid, xa, lo, hi, regSym], $Failed];
                If[TrueQ[$IV$DebugLast],
                  Print["[DBG] EvalDefinite -> ", If[r === $Failed, "$Failed",
                    "LC=" <> ToString[LeafCount[r]]]];
                  Global`DBG$r = r];
                If[r =!= $Failed && !IV$HasFrozenTermsQ[r],
                  If[verbose, Print["    [Last] Fibrate->Lambda->ReFib->GInt succeeded!"]];
                  Return[{Collect[r, _G, Simplify], Join[lamRules, IV$FTDrainLams[]]}]]]]],
          (* No lambda needed \[LongDash] just GIntegrate the fibrated expression *)
          antid = Quiet@CheckAbort[
            TimeConstrained[GIntegrate[fibExpr1, xa], 120, $Failed],
            $Failed];
          If[antid =!= $Failed && !IV$HasFrozenTermsQ[antid] &&
              TrueQ[IV$ExactAntiderivativeQ[antid, fibExpr1, xa]],
            r = Quiet@CheckAbort[
              IV$EvalDefinite[antid, xa, lo, hi, regSym], $Failed];
            If[r =!= $Failed && !IV$HasFrozenTermsQ[r],
              If[verbose, Print["    [Last] Fibrate->GInt succeeded (no lambda needed)"]];
              Return[{Collect[r, _G, Simplify], IV$FTDrainLams[]}]]]]]]];

  (* A failed optional last-variable attempt must not lend its private lambda
     rules to a later proof of the unchanged source expression. *)
  If[isLast,
    IV$FTDrainLams[];
    lamRules = {}];

  (* Standard lambda path for non-last variables *)
  (* Large rational inputs have already attempted both Apart implementations
     and the aggregate derivative proof above.  Scanning the whole failed
     expression for quadratic factors before the large-input termwise path is
     redundant and can dominate runtime; each exact addend is classified by
     the termwise integrator below. *)
  If[LeafCount[workExpr] < 5000 &&
      Length[IV$FindQuadratics[workExpr, xa]] > 0,
    Module[{lamExpr, newLamRules, lamFits},
      {lamExpr, newLamRules} = IV$ApplyLambdas[workExpr, xa, verbose];
      If[Length[newLamRules] > 0,
        workExpr = lamExpr; lamRules = newLamRules;
        lamFits = Select[(#[[1]]->Quiet@N[#[[2]]/.Normal[mainFit]/.Normal[paramFit]])&/@newLamRules, NumericQ[#[[2]]]&];
        fitList = Join[fitList, lamFits]]]];

  (* Skip the full IV$TryIntegrate cycle (which can burn 240s \[Times] 3 = 720s)
     when the working expression is too large; jump straight to the per-term
     loop where the fast path and lambda-fast-path can dispose of huge G-coefficient
     terms efficiently. The threshold is conservative \[LongDash] small step-5 expressions
     still benefit from the standard route. *)
  If[LeafCount[workExpr] < 5000,
    (* Primary: ToFibrationBasis + GIntegrate *)
    result = Quiet@CheckAbort[
      IV$TryIntegrate[workExpr, xa, fibVars, fitList, regSym, lo, hi],
      $Failed];
    If[result =!= $Failed, Return[{result, Join[lamRules, IV$FTDrainLams[]]}]];
    IV$FTDrainLams[];

    (* Fallback 1: xa -> hi-w *)
    If[verbose, Print["    Standard failed, trying xa -> ",hi,"-w..."]];
    w=Unique["w"]; exprSub=Simplify[workExpr/.xa->(hi-w)];
    fitSub=fitList/.(xa->v_):>(w->hi-v); fibSub=fibVars/.xa->w;
    (* w = hi - xa  =>  w in [0, hi-lo] *)
    result = Quiet@CheckAbort[
      IV$TryIntegrate[exprSub,w,fibSub,fitSub,regSym,0,hi-lo],
      $Failed];
    If[result=!=$Failed, Return[{result, Join[lamRules, IV$FTDrainLams[]]}]];
    IV$FTDrainLams[];

    (* Fallback 2: xa -> w^2 *)
    If[verbose, Print["    Trying xa -> w^2..."]];
    w=Unique["w"]; exprSub=Simplify[(workExpr/.xa->w^2)*2w];
    fitSub=fitList/.(xa->v_):>(w->Sqrt[v]); fibSub=fibVars/.xa->w;
    (* xa = w^2  =>  w in [Sqrt[lo], Sqrt[hi]]  (= [0,1] when lo=0,hi=1) *)
    result = Quiet@CheckAbort[
      IV$TryIntegrate[exprSub,w,fibSub,fitSub,regSym,Sqrt[lo],Sqrt[hi]],
      $Failed];
    If[result=!=$Failed, Return[{result, Join[lamRules, IV$FTDrainLams[]]}]],
    If[verbose, Print["    LC=",LeafCount[workExpr]," >= 5000: skipping standard/sub paths, going straight to term-by-term"]]];

  (* Fallback 3: Term-by-term GIntegrate with DG resolution for failures *)
  If[verbose, Print["    Trying term-by-term GIntegrate..."]];
  Module[{collected, terms, succTerms={}, succIntegrands={},
          succSourceTerms={}, succSourceRepairRecords={}, failTerms={},
          sourceGaugeRules={}, failN=0, nSucc=0},
    (* With no GPL objects yet, Collect[..., Together] treats the complete
       rational/logarithmic expression as one coefficient and destroys the
       additive decomposition that this fallback needs.  Preserve exact
       expanded addends in that case; collect only when GPL monomials exist. *)
    collected = If[FreeQ[workExpr, _G] ||
        (TrueQ[$IV$PreserveLargeAddends] && LeafCount[workExpr] >= 50000),
      Expand[workExpr],
      Collect[workExpr/.{G->Global`GPL$TbT},
        Global`GPL$TbT[__], Together]/.{Global`GPL$TbT->G}];
    terms = If[Head[collected]===Plus, List@@collected, {collected}];
    Module[{unbatchedCount = Length[terms], batchedTerms},
      batchedTerms = IV$BatchRepeatedW1SourceTerms[terms, xa];
      If[verbose && Length[batchedTerms] < unbatchedCount,
        Print["    Repeated W1 source batching: ", unbatchedCount,
          " addends -> ", Length[batchedTerms], " exact batches"]];
      terms = batchedTerms];
    Do[Module[{tfib, tgint, tgintInput = $Failed, gWithXa,
        fastEligible, sourceRepair = $Failed, sourceGate = False,
        transformedGate = False},
      (* Fast path eligibility: term is rational+Log+PolyLog in xa, OR all G's
         in the term are CONSTANT in xa (G-functions act as kinematic constants).
         The latter is critical for the last-variable step where earlier steps
         have produced many "constant" G's that should pass through unchanged. *)
      gWithXa = Cases[t, g_G /; !FreeQ[g, xa], Infinity];
      fastEligible = FreeQ[t, _Real] &&
        TrueQ[IV$SpecialFunctionsFreeOfXQ[t, xa]];
      tgint = $Failed;
      (* EuclideanApart and Mathematica Apart do not accept an algebraic
         Extension option here.  Sending Q(alpha)-coefficient terms through
         them only rebuilds the linear factors and burns the timeout before
         the exact number-field ManualApart path below. *)
      If[fastEligible && IV$AlgebraicExtensions[t] === {},
        Module[{split = IV$ConstSpecialMonomialSplit[t, xa], gProd, ratPart},
          If[split =!= $Failed,
            gProd = split[[1]]; ratPart = split[[2]];
            tgint = Quiet[TimeConstrained[Catch[
              gProd * Module[{aPart, aTerms, eucResult},
              (* Euclidean partial fraction first (exact AND ~10x faster than
                 MMA Apart on symbolic-coefficient cases). Falls through to
                 Apart on failure or timeout. Keeps everything exact. *)
              eucResult = If[TrueQ[$IV$UseEuclidean],
                TimeConstrained[
                  Quiet[Check[IV$EuclideanApart[ratPart, xa], $Failed]],
                  30, $Failed],
                $Failed];
              aPart = If[eucResult === $Failed || !FreeQ[eucResult, IV$EuclideanApart],
                Apart[ratPart, xa], eucResult];
              aTerms = If[Head[aPart] === Plus, List @@ aPart, {aPart}];
              Sum[IV$IntegratePiece[aTerms[[k]], xa,
                Function[Throw[$Failed, "fastpath"]]],
                {k, Length[aTerms]}]],
              "fastpath"], 60, $Failed]];
            If[tgint =!= $Failed,
              If[TrueQ[IV$ExactAntiderivativeQ[tgint, t, xa]],
                tgintInput = t,
                If[verbose, Print["    [fast-fp] derivative gate failed"]];
                tgint = $Failed]]]]];
      (* Manual-PF fast-path: if regular fast path failed (Apart times out due
         to many free symbols), use IV$ManualApart which decomposes via
         Series[N/Q_i, {x, r_i, k_i-1}] per linear factor. Bypasses Mathematica's
         Apart entirely. Keeps v's symbolic and any lambda symbols intact. *)
      If[tgint === $Failed && fastEligible,
        Module[{split = IV$ConstSpecialMonomialSplit[t, xa], gProd, ratPart, mpfResult},
          If[split =!= $Failed,
            gProd = split[[1]]; ratPart = split[[2]];
            If[verbose, Print["    [mpf-fp] term LC=", LeafCount[t], ", ratPart LC=", LeafCount[ratPart]]];
            tgint = Quiet[TimeConstrained[Catch[
              mpfResult = IV$ManualApart[ratPart, xa];
              If[mpfResult === $Failed, Throw[$Failed, "mpf"]];
              Module[{aTerms = If[Head[mpfResult] === Plus, List @@ mpfResult, {mpfResult}]},
                If[verbose, Print["    [mpf-fp] PF pieces: ", Length[aTerms]]];
                gProd * Sum[IV$IntegratePiece[aTerms[[k]], xa,
                  Function[If[verbose, Print["    [mpf-fp] piece ", k, " failed"]];
                    Throw[$Failed, "mpf"]]],
                  {k, Length[aTerms]}]],
              "mpf"], 90, $Failed]];
            If[tgint =!= $Failed,
              If[TrueQ[IV$ExactAntiderivativeQ[tgint, t, xa]],
                tgintInput = t,
                If[verbose, Print["    [mpf-fp] derivative gate failed"]];
                tgint = $Failed]];
            If[verbose && tgint =!= $Failed, Print["    [mpf-fp] succeeded, LC=", LeafCount[tgint]]]]]];
      (* A literal rational multiple of one variable weight-one GPL has a
         source-preserving integration-by-parts primitive.  Trying generic
         fibration first is both slower and can yield a candidate that the
         source derivative gate must reject, so use the exact specialized
         backend before that detour. *)
      If[tgint === $Failed,
        Module[{sourceGPLs = IV$GPLCases[t]},
          If[Length[sourceGPLs] === 1 &&
              Length[List @@ First[sourceGPLs]] === 2 &&
              ! FreeQ[First[sourceGPLs], xa],
            sourceRepair = Quiet@CheckAbort[TimeConstrained[
              IV$SourceExactW1Primitive[t, xa], 5700, $Failed],
              $Failed];
            If[AssociationQ[sourceRepair] &&
                TrueQ[sourceRepair["SourceGate"]] &&
                ! IV$HasFrozenTermsQ[sourceRepair["Primitive"]],
              tgint = sourceRepair["Primitive"];
              tgintInput = t;
              If[verbose, Print[
                "    [source-first] RetainedW1 primitive accepted"]]]]]];
      (* If fast path was ineligible OR returned $Failed, try standard path *)
      If[tgint === $Failed,
        Module[{tfibX, tgintX = $Failed, tgintXInput = $Failed,
                tLi1, tfibLi1, tgintLi1},
          tfibX = Quiet@CheckAbort[TimeConstrained[
            ToFibrationBasis[t, {xa}, FitValue->fitList], 20, $Failed], $Failed];
          If[TrueQ[IV$FTFibDoneQ[tfibX, {xa}]] &&
              TrueQ[IV$FTValidate2[t, tfibX, xa, fitList, {}]],
            tgintX = Quiet@CheckAbort[
              TimeConstrained[GIntegrate[tfibX, xa], 20, $Failed], $Failed];
            If[tgintX =!= $Failed,
              If[TrueQ[IV$ExactAntiderivativeQ[tgintX, tfibX, xa]],
                tgintXInput = tfibX,
                If[verbose, Print["    [term-fib] derivative gate failed"]];
                tgintX = $Failed]]];
          (* Li1 fallback: G[a, 1] = Log[(a-1)/a]. After substituting, factor
             the Log argument and split using Log[A*B] = Log[A] + Log[B] etc. *)
          If[tgintX === $Failed || IV$HasFrozenTermsQ[tgintX],
            tLi1 = t /. G[a_, 1] /; !FreeQ[a, xa] :> Module[{aT = Together[a]},
              Log[(Numerator[aT] - Denominator[aT])/Numerator[aT]]];
            tLi1 = tLi1 //. {
              Log[a_ * b_] /; (!FreeQ[a, xa] && !FreeQ[b, xa]) :> Log[a] + Log[b],
              Log[a_ / b_] /; !FreeQ[b, xa] :> Log[a] - Log[b],
              Log[a_^n_Integer] /; n =!= 1 :> n * Log[a]};
            tLi1 = tLi1 /. Log[a_] /; !FreeQ[a, xa] :> Module[{aF = Factor[a]},
              If[Head[aF] === Times, Log[aF], Log[a]]];
            tLi1 = tLi1 //. {
              Log[a_ * b_] /; (!FreeQ[a, xa] || !FreeQ[b, xa]) :> Log[a] + Log[b],
              Log[a_ / b_] /; !FreeQ[b, xa] :> Log[a] - Log[b]};
            If[tLi1 =!= t,
              tfibLi1 = Quiet@CheckAbort[TimeConstrained[
                ToFibrationBasis[tLi1, {xa}, FitValue->fitList], 20, $Failed], $Failed];
              If[TrueQ[IV$FTFibDoneQ[tfibLi1, {xa}]] &&
                  TrueQ[IV$FTValidate2[t, tfibLi1, xa, fitList, {}]],
                tgintLi1 = Quiet@CheckAbort[TimeConstrained[
                  GIntegrate[tfibLi1, xa], 20, $Failed], $Failed];
                If[tgintLi1 =!= $Failed && !IV$HasFrozenTermsQ[tgintLi1] &&
                    TrueQ[IV$ExactAntiderivativeQ[tgintLi1, tfibLi1, xa]],
                  tgintX = tgintLi1;
                  tgintXInput = tfibLi1]]]];
          tgint = tgintX;
          tgintInput = tgintXInput]];
      transformedGate = tgint =!= $Failed && tgintInput =!= $Failed &&
        ! IV$HasFrozenTermsQ[tgint] &&
        TrueQ[IV$ExactAntiderivativeQ[tgint, tgintInput, xa]];
      If[transformedGate,
        sourceGate = TrueQ[IV$ExactAntiderivativeQ[tgint, t, xa]]];
      If[! sourceGate,
        sourceRepair = Quiet@CheckAbort[TimeConstrained[
          IV$SourceExactWeightedPrimitive[t, xa, lo, hi], 5700,
          $Failed], $Failed];
        If[AssociationQ[sourceRepair] &&
            TrueQ[sourceRepair["SourceGate"]] &&
            ! IV$HasFrozenTermsQ[sourceRepair["Primitive"]],
          tgint = sourceRepair["Primitive"];
          tgintInput = t;
          sourceGate = True;
          If[verbose, Print["    [source-exact] ",
            Lookup[sourceRepair, "Mode", "RetainedW1"],
            " primitive accepted"]]]];
      If[sourceGate,
        AppendTo[succTerms, tgint];
        AppendTo[succIntegrands, t];
        AppendTo[succSourceTerms, t];
        If[AssociationQ[sourceRepair],
          AppendTo[succSourceRepairRecords, sourceRepair]];
        nSucc++,
        AppendTo[failTerms, t]; failN++]], {t, terms}];

    sourceGaugeRules = Flatten[
      Lookup[succSourceRepairRecords, "GaugeRules", {}], 1];

    If[verbose, Print["    Term-by-term: ",nSucc,"/",Length[terms]," direct, ",failN," need DG"]];

    (* For failed terms: reconstruct variable-letter GPLs at weights 1 and 2. *)
    If[failN > 0,
      Module[{dgAntiTerms = {}, dgPreparedTerms = {},
              dgSourceTerms = {}, dgFail = 0,
              dgDefiniteTerms = {}, dgDefiniteSources = {}, dgUnresolved},
        Do[
          (* Reconstruct every supported variable-letter GPL as a function of
             xa, integrate the COMPLETE weighted term, and differentiate the
             result back.  The former code called IV$DGResolveW2 on the bare
             GPL and then multiplied its definite value by an xa-dependent
             coefficient, which is not an integral. *)
          Block[{$IV$FibGCache = <||>, $IV$FibGCacheLams = <||>,
                 $IV$FibTemplates = <||>, $IV$FibInstOK = <||>,
                 $IV$FTLamFits = {}, $IV$FTNewLamRules = {}},
          Module[{variableGPLs, prepared = ft, fib, dgLams, termLams = {},
                  allDGok = True, dgAnti},
            variableGPLs = Select[Cases[ft, g_G, Infinity] // DeleteDuplicates,
              Function[g, Module[{args = List @@ g},
                Length[args] >= 2 && Last[args] === 1 &&
                  ! FreeQ[Most[args], xa]]]];
            If[Length[variableGPLs] > 0,
              If[verbose, Print["    [DG] Term has ", Length[variableGPLs],
                " variable-letter GPLs with ", xa]];
              Do[
                IV$FTDrainLams[];
                fib = Quiet@CheckAbort[TimeConstrained[
                  Switch[Length[List @@ gpl],
                    2, IV$FibW1Log[gpl, {xa}, fitList],
                    3, IV$FibW2Moebius[gpl, {xa}, fitList],
                    _, $Failed], 600, $Failed], $Failed];
                dgLams = IV$FTDrainLams[];
                If[fib =!= $Failed && TrueQ[IV$FTInBasisQ[fib, xa]] &&
                    TrueQ[IV$FTValidate2[gpl, fib, xa, fitList, dgLams]] &&
                    (* F1 (2026-08-29): a reconstruction whose lambda roots
                       depend on a not-yet-integrated variable is unsound *)
                    (remainOrder === {} ||
                      FreeQ[dgLams, Alternatives @@ remainOrder]),
                  prepared = prepared /. gpl -> fib;
                  termLams = Join[termLams, dgLams],
                  allDGok = False; Break[]],
                {gpl, variableGPLs}];
              If[allDGok,
                prepared = Quiet@Collect[
                  prepared /. G -> Global`GPL$DGTerm,
                  Global`GPL$DGTerm[__], (ApartSquareFree[#, xa] &)] /.
                    Global`GPL$DGTerm -> G;
                dgAnti = Quiet@CheckAbort[TimeConstrained[
                  Block[{$IterationLimit = Infinity},
                    GIntegrate[prepared, xa]], 900, $Failed], $Failed];
                If[dgAnti =!= $Failed && ! IV$HasFrozenTermsQ[dgAnti] &&
                    TrueQ[IV$ExactAntiderivativeQ[dgAnti, prepared, xa]] &&
                    TrueQ[IV$ExactAntiderivativeQ[dgAnti, ft, xa]],
                  AppendTo[dgAntiTerms, dgAnti];
                  AppendTo[dgPreparedTerms, ft];
                  AppendTo[dgSourceTerms, ft];
                  lamRules = Join[lamRules, termLams],
                  If[verbose, Print["    [DG] Weighted antiderivative passed, LC=", LeafCount[dgAnti]]],
                  If[verbose, Print["    [DG] Weighted antiderivative failed"]];
                  dgFail++],
                dgFail++],
              dgFail++]]]
        , {ft, failTerms}];

        (* F2 (2026-08-29): second pass -- terms the reconstruction could not
           close (or closed only with lambda roots depending on a variable
           still to be integrated) get the July definite-value route where it
           is provably an integral (IV$DGDefiniteFallback).  These contribute
           DEFINITE values, added after the boundary evaluation below. *)
        If[dgFail > 0,
          dgUnresolved = Fold[
            Function[{remaining, resolved},
              Module[{position = FirstPosition[remaining, resolved,
                  {1}, Heads -> False]},
                If[MissingQ[position], remaining, Delete[remaining, position]]]],
            failTerms, dgSourceTerms];
          Do[
            Module[{fb = IV$DGDefiniteFallback[ft, xa, lo, hi, fitList,
                remainOrder, verbose]},
              If[ListQ[fb] && Length[fb] === 2,
                AppendTo[dgDefiniteTerms, fb[[1]]];
                AppendTo[dgDefiniteSources, ft];
                lamRules = Join[lamRules, fb[[2]]];
                dgFail--;
                If[verbose, Print["    [DG] definite-value fallback closed a term"]]]],
            {ft, dgUnresolved}]];

        If[verbose, Print["    [DG] Resolved: ",
          Length[dgAntiTerms] + Length[dgDefiniteTerms], "/", failN,
          " failed terms (", Length[dgDefiniteTerms], " via definite fallback)"]];

        (* Diagnostic: dump the failing-after-DG terms so we can see what's
           tripping up the engine. Only fires when not all terms resolved. *)
        If[verbose && (Length[dgAntiTerms] + Length[dgDefiniteTerms] < failN) &&
            TrueQ[$IV$DumpFailedTerms],
          Module[{dumpFile = $IV$FailedBoundaryDumpFile, dumpTemp, dumpData,
                  unresolvedFailTerms, partialAntiderivative,
                  partialIntegrand, partialProofGate},
            (* Recompute which failTerms didn't make it into dgAntiTerms.
               Since dgAntiTerms are transformed antiderivatives, we can't
               match directly. Just dump all failTerms \[LongDash] the user can inspect. *)
            unresolvedFailTerms = Fold[
              Function[{remaining, resolved},
                Module[{position = FirstPosition[remaining, resolved,
                    {1}, Heads -> False]},
                  If[MissingQ[position], remaining,
                    Delete[remaining, position]]]],
              failTerms, dgSourceTerms];
            partialAntiderivative = Plus @@ Join[succTerms, dgAntiTerms];
            partialIntegrand = Plus @@ Join[succIntegrands,
              dgPreparedTerms];
            partialProofGate = TrueQ[IV$ExactAntiderivativeWithGaugeQ[
              partialAntiderivative, partialIntegrand, xa,
              sourceGaugeRules]];
            dumpData = <|
              "Stage" -> "PartialDG",
              "xa" -> xa,
              "failTerms" -> unresolvedFailTerms,
              "succTermsCount" -> Length[succTerms],
              "totalTerms" -> Length[terms],
              "fitList" -> fitList,
              "LambdaRules" -> lamRules,
              "DirectAntiderivatives" -> succTerms,
              "DirectIntegrands" -> succIntegrands,
              "DirectSourceTerms" -> succSourceTerms,
              "SourceRepairRecords" -> succSourceRepairRecords,
              "SourceGaugeRules" -> sourceGaugeRules,
              "RequiresWallAudit" -> AnyTrue[succSourceRepairRecords,
                TrueQ[Lookup[#, "RequiresWallAudit", False]] &],
              "DGResolvedAntiderivatives" -> dgAntiTerms,
              "DGPreparedIntegrands" -> dgPreparedTerms,
              "DGSourceTerms" -> dgSourceTerms,
              "UnresolvedSourceTerms" -> unresolvedFailTerms,
              "PartialAntiderivative" -> partialAntiderivative,
              "PartialIntegrand" -> partialIntegrand,
              "PartialProofGate" -> partialProofGate |>;
            dumpTemp = dumpFile<>".tmp-"<>ToString[$ProcessID];
            Quiet[
              If[FileExistsQ[dumpTemp], DeleteFile[dumpTemp]];
              Put[dumpData, dumpTemp];
              If[FileExistsQ[dumpFile], DeleteFile[dumpFile]];
              RenameFile[dumpTemp, dumpFile]];
            Print["    [DUMP] Wrote ", Length[unresolvedFailTerms], " failed terms to ", dumpFile];
            Do[Print["    [DUMP] failTerm[", k, "] LC=", LeafCount[unresolvedFailTerms[[k]]],
                ", G[_,1] count: ",
                Length[Cases[unresolvedFailTerms[[k]], G[a_, 1] /; !FreeQ[a, xa], Infinity]],
                ", G[_,_,1] count: ",
                Length[Cases[unresolvedFailTerms[[k]], G[a_, b_, 1] /; (!FreeQ[a, xa] || !FreeQ[b, xa]), Infinity]]],
              {k, Length[unresolvedFailTerms]}]]];

        If[dgFail == 0 &&
            (nSucc + Length[dgAntiTerms] + Length[dgDefiniteTerms]) == Length[terms],
          (* ALL terms resolved: take the boundary of the complete
             antiderivative.  Never append an unintegrated DG expression.
             F2: definite-fallback values are added AFTER the boundary. *)
          Module[{ad = Plus @@ Join[succTerms, dgAntiTerms], adSub,
                  proofIntegrand = Plus @@ Join[succIntegrands,
                    dgPreparedTerms], proofSub, adExact, boundaryRecord, r,
                  sourceGaugeRulesSub, rawProofGate,
                  substitutedProofGate, normalizedProofGate},
            rawProofGate = TrueQ[IV$ExactAntiderivativeWithGaugeQ[
              ad, proofIntegrand, xa, sourceGaugeRules]];
            If[! rawProofGate,
              If[verbose, Print["    [DG] Complete raw derivative proof failed"]];
              termByTermHardFail = True,
            adSub = IV$SafeExactSubstitute[ad, lamRules];
            proofSub = IV$SafeExactSubstitute[proofIntegrand, lamRules];
            sourceGaugeRulesSub = IV$SafeExactSubstituteGaugeRules[
              sourceGaugeRules, lamRules];
            substitutedProofGate = If[adSub === $Failed ||
                proofSub === $Failed || sourceGaugeRulesSub === $Failed,
              False,
              If[SameQ[adSub, ad] && SameQ[proofSub, proofIntegrand] &&
                  SameQ[sourceGaugeRulesSub, sourceGaugeRules],
                rawProofGate,
                TrueQ[IV$ExactAntiderivativeWithGaugeQ[
                  adSub, proofSub, xa, sourceGaugeRulesSub]]]];
            adExact = If[adSub === $Failed || proofSub === $Failed ||
                sourceGaugeRulesSub === $Failed,
              $Failed,
              If[substitutedProofGate,
                adSub,
                Quiet@CheckAbort[TimeConstrained[
                  Collect[ShuffleG[adSub], _G, Together], 300,
                  $Failed], $Failed]]];
            normalizedProofGate = If[adExact === $Failed ||
                sourceGaugeRulesSub === $Failed,
              False,
              If[SameQ[adExact, adSub],
                substitutedProofGate,
                TrueQ[IV$ExactAntiderivativeWithGaugeQ[
                  adExact, proofSub, xa, sourceGaugeRulesSub]]]];
            If[adExact === $Failed ||
                sourceGaugeRulesSub === $Failed ||
                ! TrueQ[IV$ExactGPLZeroQ[adExact - adSub]] ||
                ! normalizedProofGate,
              If[verbose, Print["    [DG] Complete antiderivative normalization failed"]];
              termByTermHardFail = True,
            boundaryRecord = <|
              "Variable" -> xa, "Lower" -> lo, "Upper" -> hi,
              "Regulator" -> regSym, "DirectTermCount" -> nSucc,
              "DGTermCount" -> Length[dgAntiTerms],
              "Antiderivative" -> ad,
              "SubstitutedAntiderivative" -> adSub,
              "BoundaryAntiderivative" -> adExact,
              "LambdaRules" -> lamRules,
              "LastIntegrand" -> workExpr,
              "ProofIntegrand" -> proofIntegrand,
              "SubstitutedProofIntegrand" -> proofSub,
              "ProofGate" -> True,
              "FailedTerms" -> failTerms,
              "DirectAntiderivatives" -> succTerms,
              "DirectIntegrands" -> succIntegrands,
              "DirectSourceTerms" -> succSourceTerms,
              "SourceRepairRecords" -> succSourceRepairRecords,
              "SourceGaugeRules" -> sourceGaugeRules,
              "SubstitutedSourceGaugeRules" -> sourceGaugeRulesSub,
              "RawProofGate" -> rawProofGate,
              "SubstitutedProofGate" -> substitutedProofGate,
              "NormalizedProofGate" -> normalizedProofGate,
              "RequiresWallAudit" -> AnyTrue[succSourceRepairRecords,
                TrueQ[Lookup[#, "RequiresWallAudit", False]] &],
              "DGResolvedTerms" -> dgAntiTerms,
              "DGPreparedIntegrands" -> dgPreparedTerms,
              "DGSourceTerms" -> dgSourceTerms,
              "SourcePartitionGate" -> TrueQ[IV$ExactGPLZeroQ[
                Plus @@ Join[succSourceTerms, dgSourceTerms,
                  dgDefiniteSources] - workExpr]],
              "DGDefiniteTermCount" -> Length[dgDefiniteTerms],
              "AntiderivativeLeafCount" -> LeafCount[ad],
              "DGLeafCount" -> LeafCount[Plus @@ dgAntiTerms]|>;
            (* Successful boundaries need the same source-only provenance as
               failures.  The default trace hook is inert, time bounded, and
               unable to alter the solve. *)
            IV$CallStepTrace[Append[boundaryRecord,
              "Stage" -> "CompleteDGBoundary"]];
            (* Boundary regularization can Abort on a difficult combined
               antiderivative.  Catch it here so the complete-DG branch can
               fail diagnostically instead of unwinding the entire step. *)
            r = Quiet@CheckAbort[
              IV$EvalDefinite[adExact, xa, lo, hi, regSym], $Failed];
            If[r === $Failed && verbose && TrueQ[$IV$DumpFailedTerms],
              Module[{dumpData = boundaryRecord,
                      dumpFile = $IV$FailedBoundaryDumpFile, dumpTemp},
                dumpTemp = dumpFile<>".tmp-"<>ToString[$ProcessID];
                Quiet[
                  If[FileExistsQ[dumpTemp], DeleteFile[dumpTemp]];
                  Put[dumpData, dumpTemp];
                  If[FileExistsQ[dumpFile], DeleteFile[dumpFile]];
                  RenameFile[dumpTemp, dumpFile]];
                Print["    [DUMP] IV$EvalDefinite failed after complete DG; wrote ",
                  $IV$FailedBoundaryDumpFile, " (ad LC=", LeafCount[ad],
                  ", DG LC=", LeafCount[Plus @@ dgAntiTerms], ")"]]];
            If[r =!= $Failed,
              If[verbose, Print["    All terms resolved (",nSucc," direct + ",
                Length[dgAntiTerms]," DG + ",Length[dgDefiniteTerms]," DG-definite)"]];
              Return[{Collect[r + (Plus @@ dgDefiniteTerms), _G, Simplify],
                lamRules}]]]]]];
        (* Partial DG resolution: some terms still failed. Falling through to
           rational fallback / last resort has been observed to produce silent
           wrong-zero results because it integrates only the non-failed terms.
           Better to return $Failed so the order-rotation failsafe can try a
           different ordering that may succeed cleanly. *)
        If[dgFail > 0 || Length[dgAntiTerms] + Length[dgDefiniteTerms] < failN,
          If[verbose, Print["    [DG] Partial resolution (",
            failN - Length[dgAntiTerms] - Length[dgDefiniteTerms],
            " unresolved); returning $Failed for retry"]];
          termByTermHardFail = True]]];

    (* Bank the locally proved primitives before constructing their potentially
       huge canonical Plus.  This observer is opt-in and cannot change which
       primitives or gates are accepted. *)
    If[failN == 0 && Length[succTerms] > 0 &&
        StringQ[$IV$DirectTermsBankFile],
      Module[{bankStatus = IV$BankDirectTerms[<|
          "SchemaVersion" -> 1, "Stage" -> "CompleteDirectTerms",
          "SourceOnly" -> True, "Variable" -> xa,
          "Lower" -> lo, "Upper" -> hi, "Regulator" -> regSym,
          "OriginalIntegrand" -> workExpr,
          "DirectAntiderivatives" -> succTerms,
          "DirectSourceTerms" -> succSourceTerms,
          "LambdaRules" -> lamRules,
          "SourceGaugeRules" -> sourceGaugeRules,
          "DirectTermCount" -> nSucc,
          "LocalSourceGate" -> AllTrue[succSourceRepairRecords,
            TrueQ[Lookup[#, "SourceGate", False]] &],
          "RequiresWallAudit" -> AnyTrue[succSourceRepairRecords,
            TrueQ[Lookup[#, "RequiresWallAudit", False]] &],
          "NoNumericalOracle" -> True|>]},
        If[verbose, Print["    Direct-term bank: ", bankStatus,
          " (", $IV$DirectTermsBankFile, ")"]]]];

    (* If all terms succeeded without DG *)
    If[failN==0 && Length[succTerms]>0,
      Module[{ad = Plus@@succTerms, r, boundaryRecord,
              exactEndpointRecord, exactEndpointStatus,
              sourcePartitionGate},
        sourcePartitionGate = TrueQ[IV$ExactGPLZeroQ[
          Plus @@ succSourceTerms - workExpr]];
        boundaryRecord = <|
          "Variable" -> xa, "Lower" -> lo, "Upper" -> hi,
          "Regulator" -> regSym, "DirectTermCount" -> nSucc,
          "DGTermCount" -> 0, "Antiderivative" -> ad,
          "BoundaryAntiderivative" -> ad,
          "LambdaRules" -> lamRules,
          "LastIntegrand" -> workExpr,
          "ProofIntegrand" -> Plus @@ succIntegrands,
          "DirectAntiderivatives" -> succTerms,
          "DirectIntegrands" -> succIntegrands,
          "DirectSourceTerms" -> succSourceTerms,
          "SourceRepairRecords" -> succSourceRepairRecords,
          "SourceGaugeRules" -> sourceGaugeRules,
          "SourcePartitionGate" -> sourcePartitionGate,
          "ProofConstruction" -> "ExactTermwiseLinearity",
          "ProofGate" -> sourcePartitionGate &&
            AllTrue[succSourceRepairRecords,
              TrueQ[Lookup[#, "SourceGate", False]] &],
          "RequiresWallAudit" -> AnyTrue[succSourceRepairRecords,
            TrueQ[Lookup[#, "RequiresWallAudit", False]] &],
          "AntiderivativeLeafCount" -> LeafCount[ad]|>;
        IV$CallStepTrace[Append[boundaryRecord,
          "Stage" -> "CompleteDirectBoundary"]];
        (* Preserve every established endpoint path.  The proof-carrying ODE
           backend closes only a legacy failure/abort, notably the valid
           all-direct primitives that the Shuffle/GiNaC bridge cannot parse. *)
        r = Quiet@CheckAbort[
          IV$EvalDefinite[ad, xa, lo, hi, regSym], $Failed];
        exactEndpointRecord = If[r === $Failed &&
            TrueQ[$IV$ExactEndpointBackend] &&
            TrueQ[$IV$ExactEndpointBackendLoaded] &&
            SameQ[regSym, 0] && TrueQ[boundaryRecord["ProofGate"]],
          Quiet@CheckAbort[TimeConstrained[
            IVEX$Evaluate[ad, xa, {lo, hi}, remainOrder,
              boundaryRecord], 1800,
            <|"Status" -> "Failed",
              "FailReason" -> "ExactEndpointTimeout"|>],
            <|"Status" -> "Failed",
              "FailReason" -> "ExactEndpointAbort"|>],
          <|"Status" -> "NotApplicable",
            "FailReason" -> If[r === $Failed,
              "ExactEndpointDisabledOrRegulated",
              "LegacyEndpointSucceeded"]|>];
        exactEndpointStatus = Lookup[
          exactEndpointRecord, "Status", "Failed"];
        IV$CallStepTrace[<|"Stage" -> "ExactEndpointBoundary",
          "Variable" -> xa, "Remaining" -> remainOrder,
          "Record" -> exactEndpointRecord|>];
        r = Which[
          r =!= $Failed, r,
          exactEndpointStatus === "Certified" &&
              TrueQ[Lookup[exactEndpointRecord, "Gate", False]],
            Lookup[exactEndpointRecord, "Value", $Failed],
          True, $Failed];
        If[verbose && exactEndpointStatus === "Certified",
          Print["    Exact endpoint/wall certificate succeeded"]];
        If[r === $Failed && verbose && TrueQ[$IV$DumpFailedTerms],
          Module[{dumpFile = $IV$FailedBoundaryDumpFile, dumpTemp},
            dumpTemp = dumpFile <> ".tmp-" <> ToString[$ProcessID];
            Quiet[
              If[FileExistsQ[dumpTemp], DeleteFile[dumpTemp]];
              Put[boundaryRecord, dumpTemp];
              If[FileExistsQ[dumpFile], DeleteFile[dumpFile]];
              RenameFile[dumpTemp, dumpFile]];
            Print["    [DUMP] IV$EvalDefinite failed after complete direct; wrote ",
              dumpFile, " (ad LC=", LeafCount[ad], ")"]]];
        If[r =!= $Failed,
          If[verbose, Print["    Term-by-term succeeded (",Length[terms]," terms), result LC=",LeafCount[r]]];
          Return[{Collect[r, _G], lamRules}]]]]];

  If[TrueQ[termByTermHardFail], Return[{$Failed, lamRules}]];

  (* Rational fallback: if expr is a rational function of xa with G-constant coefficients,
     use Mathematica's Integrate directly. This handles the case where earlier steps
     produced G-function constants that PLT can't process further. *)
  Module[{gConsts, testExpr, isRatInXa},
    gConsts = Union[Cases[workExpr, g_G /; FreeQ[g, xa], Infinity]];
    testExpr = workExpr /. Thread[gConsts -> Table[Unique["gc"], Length[gConsts]]];
    isRatInXa = PolynomialQ[Numerator[Together[testExpr]], xa] &&
                PolynomialQ[Denominator[Together[testExpr]], xa];
    If[isRatInXa && Length[gConsts] > 0,
      If[verbose, Print["    Rational fallback: integrating rational(", xa, ") \[Times] G-constants"]];
      Module[{collected, terms, total = 0},
        collected = Collect[workExpr, _G, Together];
        terms = If[Head[collected] === Plus, List @@ collected, {collected}];
        Do[Module[{gPart = Cases[{t}, _G, Infinity],
                   ratPart},
          ratPart = t / Times @@ (If[FreeQ[#, xa], #, 1] & /@ If[Head[t]===Times, List@@t, {t}]);
          (* Simpler: just integrate each term directly *)
          Module[{intVal = Quiet@TimeConstrained[Integrate[t, {xa, lo, hi}], 30, $Failed]},
            If[intVal =!= $Failed && FreeQ[intVal, Integrate],
              total += intVal,
              total = $Failed; Break[]]]
        ], {t, terms}];
        If[total =!= $Failed,
          If[verbose, Print["    Rational fallback succeeded"]];
          Return[{Collect[total, _G, Simplify], lamRules}]]]]];

  (* Last resort *)
  result = IV$LastResortIntegrate[workExpr, xa, lo, hi, regSym, verbose];
  {result, lamRules}]


(* ============================================================ *)
(* SECTION 7: GRAPH POLYNOMIALS                                 *)
(* ============================================================ *)

IV$GraphPolynomial[edges_List] := Module[{n = Max[Flatten[edges]], IVLetterL},
  IVLetterL = Table[0, {n}, {n}];
  Do[Module[{i = edges[[e,1]], j = edges[[e,2]], xe = Global`IVx[e]},
    IVLetterL[[i,i]] += xe; IVLetterL[[j,j]] += xe; IVLetterL[[i,j]] -= xe; IVLetterL[[j,i]] -= xe], {e, Length[edges]}];
  Expand[Det[IVLetterL[[2;;, 2;;]]]]
]

IV$ForestPolynomial[edges_List, partition_List] := Module[{verts = Union[Flatten[edges]], rec},
  rec[idx_, comp_] := Module[{e, v1, v2, c1, c2, merged, rest},
    If[Length[comp] == Length[partition],
      If[Sort[Sort /@ comp] === Sort[Sort /@ partition],
        Return[Product[Global`IVx[k], {k, idx, Length[edges]}]], Return[0]]];
    If[idx > Length[edges], Return[0]];
    e = edges[[idx]]; v1 = e[[1]]; v2 = e[[2]];
    c1 = SelectFirst[comp, MemberQ[#, v1]&]; c2 = SelectFirst[comp, MemberQ[#, v2]&];
    rest = Global`IVx[idx]*rec[idx+1, comp];
    If[c1 =!= c2, merged = Append[DeleteCases[comp, c1|c2], Union[c1,c2]];
      If[AllTrue[merged, Function[m, Count[partition, p_/;Length[Intersection[m,p]]>0]<=1]],
        rest += rec[idx+1, merged]]]; rest];
  Expand[rec[1, Map[{#}&, verts]]]
]

IV$SecondPolynomial[edges_List, externals_List, masses_List:{}] := Module[
  {verts = Union[Flatten[edges]], psi, phi = 0, extVerts = externals[[All,1]]},
  psi = IV$GraphPolynomial[edges];
  If[Length[externals] == 2,
    phi = externals[[1,2]]*IV$ForestPolynomial[edges,
      {Select[verts, #==externals[[1,1]]&], Select[verts, #!=externals[[1,1]]&]}],
    Do[Module[{sub = extVerts[[;;k]], invN = Symbol["s"<>StringJoin[ToString/@Sort[extVerts[[;;k]]]]],
        fp = IV$ForestPolynomial[edges, {extVerts[[;;k]], Complement[verts, extVerts[[;;k]]]}]},
      phi += invN*fp], {k, 1, Floor[Length[extVerts]/2]}]];
  If[Length[masses] > 0, phi += psi*Sum[masses[[e]]*Global`IVx[e], {e, Length[edges]}]];
  Expand[phi]
]

(* ============================================================ *)
(* SECTION 8: ANALYSIS AND DIAGNOSTICS                          *)
(* ============================================================ *)

IntVolAnalysis[expr_, vars_List] := Module[{S0, orderResult, order, ok, sets, sizes},
  S0 = IV$ExtractS0[expr, vars];
  Print["Initial polynomial set S0 (", Length[S0], " polynomials):"];
  Print["  ", S0]; Print[];
  orderResult = IV$BestOrder[expr, vars]; ok = orderResult[[1]]; order = orderResult[[2]];
  If[ok,
    Print["Best integration order: ", order];
    {ok, sets, sizes} = IV$TryOrder[S0, order, vars];
    Print["Polynomial set evolution:"];
    Do[Print["  Step ", i, " (integrate ", order[[i]], "): |S| = ", sizes[[i]]], {i, Length[order]}];
    Print[]; Print["GPL letters at each step:"];
    Do[Module[{IVPolySet = sets[[i]], letters},
      letters = Table[Module[{Q = Coefficient[p, order[[i]]], R = p /. order[[i]] -> 0},
        If[Q =!= 0, Simplify[-R/Q], Nothing]], {p, IVPolySet}];
      Print["  ", order[[i]], ": ", Union[letters]]], {i, Length[order]}],
    Print["WARNING: No linearly reducible ordering found!"]; Print["Attempted order: ", order]];
  {ok, order, S0}
]

(* ============================================================ *)

(* ============================================================ *)
(* SECTION 9: MAIN PUBLIC API                                   *)
(* ============================================================ *)

Options[IntVolIntegrate] = {
  "IntegrationOrder" -> Automatic, "FitValues" -> Automatic,
  "ParametricValues" -> Automatic, "Verbose" -> True,
  "Kinematics" -> Automatic,   (* declared point: fibrate where you evaluate *)
  "Certify" -> Automatic,      (* independently verify the answer, and file it as
                                  CERTIFIED knowledge the library may reuse *)
  "TrackRegulator" -> False, "SimplifySteps" -> False,
  "GreedySearch" -> False, "Timeout" -> 900,
  "LambdaSubstitution" -> True,
  "OrderRetryTimeout" -> 600, "MaxRetryOrders" -> 0,
  "MathAssumptions" -> {}
};

(* === MMA-framework integration (faithful to user's BC[19] recipe) ===
   Per-variable: MMA Integrate with Assumptions + boundary subtract (with
   LiToG/GPL trick for divergent boundaries).
   Last variable: ToFibrationBasis + manual \[Lambda]-factorization + GIntegrate
   + ShuffleRegulate at boundaries + drop HPL[{1},1] + Simplify TC=\[Infinity].
   Returns {result, lamRules} or $Failed.

   Order heuristic (when "IntegrationOrder" -> Automatic):
     1. Variables NOT inside any Log argument first (MMA happiest)
     2. Within each group, lowest current-denom degree first
*)
IV$MMAOrder[expr_, vars_List] := Module[{logArgs, logVars, scoreFn, denom},
  logArgs = Cases[expr, Log[a_] :> a, Infinity];
  logVars = DeleteDuplicates[Flatten[Cases[#, Alternatives @@ vars, Infinity] & /@ logArgs]];
  denom = Denominator[Together[expr]];
  scoreFn = Function[v, {
    If[MemberQ[logVars, v], 1, 0],
    Quiet[Check[Exponent[Expand[denom], v], 99]],
    Position[vars, v][[1, 1]]}];
  SortBy[vars, scoreFn]
];

(* Generate up to k candidate orders by varying the last variable choice among
   the highest-degree (most-coupled) candidates. The IV$MMAIntegrate's last
   step performs \[Lambda]-factorization, so the choice of last variable matters; if
   the heuristic picks wrong, we want to try other high-degree candidates. *)
IV$MMACandidateOrders[expr_, vars_List, kMax_:5] := Module[
  {denom, degs, sortedDegs, maxDeg, candidates, baseOrder, candidateOrders},
  denom = Denominator[Together[expr]];
  degs = AssociationMap[Quiet[Check[Exponent[Expand[denom], #], 0]] &, vars];
  sortedDegs = ReverseSortBy[Normal[degs], Last];
  maxDeg = First[sortedDegs][[2]];
  candidates = Keys[Select[degs, # === maxDeg &]];
  baseOrder = IV$MMAOrder[expr, vars];
  (* For each candidate "last" var, build order = (others in baseOrder order) ++ {cand}. *)
  candidateOrders = Table[
    Append[DeleteCases[baseOrder, c], c], {c, candidates}];
  Take[DeleteDuplicates[candidateOrders], UpTo[kMax]]];

(* Inner pass: integrate with a SPECIFIC order. Returns {cur, lamRules} on
   success, $Failed on any boundary/Integrate failure. *)
IV$MMAIntegrateOnce[origExpr_, vars_List, paramAssoc_Association, order_List, verbose_] :=
Catch[Module[{asm, allSyms, cur, antiD, upper, lower, isLast,
              lamRules = {}, terr12, terr13, gintRes, terr14, terr15,
              quads, dList, lamSubst, savedTC},
  allSyms = Union[Keys[paramAssoc], vars];
  asm = (0 < # < 1) & /@ allSyms;
  If[verbose, Print["[MMA] Order: ", order]];
  cur = origExpr;

  Do[
    isLast = (i === Length[order]);
    Module[{xa = order[[i]]},
      If[verbose, Print["[MMA] Step ", i, "/", Length[order], ": ", xa,
        If[isLast, " (LAST)", ""]]];
      If[!isLast,
        antiD = Quiet[TimeConstrained[
          Integrate[cur, xa, Assumptions -> asm],
          $IV$MMAIntegrateTimeout, $Failed]];
        If[antiD === $Failed || !FreeQ[antiD, Integrate],
          If[verbose, Print["[MMA]   Integrate failed for ", xa]];
          Throw[$Failed, "mma"]];
        upper = antiD /. xa -> 1;
        lower = antiD /. xa -> 0;
        If[!FreeQ[lower, Indeterminate | DirectedInfinity | ComplexInfinity],
          (* Lower diverges. Try in order:
             (1) ToFib + ShuffleRegulate (handles HPL-structure divergences,
                 user's canonical recipe path; produces compact result).
             (2) LiToG/GPL[0,a]\[RightArrow]Log[a] (handles raw Log[var] divergences).
             (3) Limit FromAbove (last-resort numerical limit).
             Whichever yields a finite expression wins; (1) is preferred when
             it works because it keeps shuffle products folded. *)
          Module[{fibBoundary, fitListBdy, lowerSR, lowerLG, lowerLim},
            fitListBdy = Append[Normal[paramAssoc], xa -> 1/3];
            If[verbose, Print["[MMA]   Lower divergent \[LongDash] trying ToFib+ShuffleRegulate"]];
            fibBoundary = Quiet@TimeConstrained[
              ToFibrationBasis[antiD, {xa}, FitValue -> fitListBdy],
              $IV$MMAIntegrateTimeout, $Failed];
            If[fibBoundary =!= $Failed,
              fibBoundary = TimeConstrained[
                Collect[fibBoundary, _G, Simplify], 60, fibBoundary];
              lowerSR = Quiet[ShuffleRegulate[fibBoundary /. xa -> 0]];
              If[FreeQ[lowerSR, Indeterminate | DirectedInfinity | ComplexInfinity],
                upper = fibBoundary /. xa -> 1;
                lower = lowerSR;
                If[verbose, Print["[MMA]   ShuffleRegulate boundary OK"]],
                If[verbose, Print["[MMA]   ShuffleRegulate still divergent \[LongDash] LiToG"]];
                lowerLG = Quiet[(LiToG[antiD] /. xa -> 0) /. {G -> GPL} /. {GPL[0, a__] :> Log[a]}];
                If[FreeQ[lowerLG, Indeterminate | DirectedInfinity | ComplexInfinity],
                  lower = lowerLG]],
              If[verbose, Print["[MMA]   ToFib failed \[LongDash] trying LiToG"]];
              lowerLG = Quiet[(LiToG[antiD] /. xa -> 0) /. {G -> GPL} /. {GPL[0, a__] :> Log[a]}];
              If[FreeQ[lowerLG, Indeterminate | DirectedInfinity | ComplexInfinity],
                lower = lowerLG]];
            If[!FreeQ[lower, Indeterminate | DirectedInfinity | ComplexInfinity],
              If[verbose, Print["[MMA]   Trying Limit"]];
              lowerLim = Quiet[TimeConstrained[
                Limit[antiD, xa -> 0, Direction -> "FromAbove", Assumptions -> asm],
                300, $Failed]];
              If[lowerLim =!= $Failed && FreeQ[lowerLim, Indeterminate | DirectedInfinity | ComplexInfinity],
                lower = lowerLim]]]];
        If[!FreeQ[lower, Indeterminate | DirectedInfinity | ComplexInfinity] ||
           lower === $Failed,
          If[verbose, Print["[MMA]   Boundary at ", xa, "=0 unresolvable"]];
          Throw[$Failed, "mma"]];
        cur = TimeConstrained[
          Collect[(upper - lower) /. HPL[{1}, 1] :> 0, _G, Simplify],
          120, (upper - lower) /. HPL[{1}, 1] :> 0];
        If[verbose, Print["[MMA]   step LC=", LeafCount[cur]]],
        (* Last step. Order: \[Lambda]-factorize the quadratic-in-xa Q FIRST (so the
           G letters become LINEAR in xa = (l1+xa)(l2+xa) factors), THEN
           ToFibrationBasis can fibrate. Doing ToFib first fails when letters
           are non-linear in xa \[LongDash] Fiber::Linear messages, $Failed return. *)
        Module[{preFactored, curT},
          (* Together first so Q-factors in denominator literally appear as
             Plus[...]^k subexpressions reachable by pattern substitution. *)
          curT = TimeConstrained[Together[cur], 120, cur];
          quads = IV$FindQuadratics[curT /. G -> Global`GG$protect, xa];
          If[Length[quads] > 0,
            dList = IV$LambdaData[#, xa] & /@ quads;
            lamRules = Flatten[#["Rules"] & /@ dList];
            lamSubst = Flatten[
              With[{Q = #["Quad"], A = #["Scale"], l1 = #["L1Sym"], l2 = #["L2Sym"]},
                {Q -> A (l1 + xa) (l2 + xa),
                 -Q -> -A (l1 + xa) (l2 + xa),
                 Expand[Q] -> A (l1 + xa) (l2 + xa),
                 Expand[-Q] -> -A (l1 + xa) (l2 + xa)}] & /@ dList];
            preFactored = curT /. lamSubst;
            preFactored = TimeConstrained[Collect[preFactored, _G, Simplify], 120, preFactored];
            If[verbose, Print["[MMA]   \[Lambda]-factorized curT LC=", LeafCount[preFactored],
              " (", Length[lamRules], " \[Lambda]-rules)"]],
            preFactored = curT;
            If[verbose, Print["[MMA]   no quadratics found"]]];
          If[verbose, Print["[MMA]   ToFibrationBasis on \[Lambda]-factored expr (LC=", LeafCount[preFactored], ")"]];
          terr12 = Quiet@TimeConstrained[
            ToFibrationBasis[preFactored, {xa},
              FitValue -> Normal[paramAssoc]],
            $IV$MMAIntegrateTimeout, $Failed];
          If[terr12 === $Failed || !FreeQ[terr12, _ToFibrationBasis],
            If[verbose, Print["[MMA]   ToFibrationBasis failed/timeout"]];
            Throw[$Failed, "mma"]];
          terr12 = TimeConstrained[Collect[terr12, _G, Simplify], 120, terr12];
          terr13 = terr12;
          If[verbose, Print["[MMA]   terr12/terr13 LC=", LeafCount[terr13]]]];
        If[verbose, Print["[MMA]   GIntegrate (up to ", $IV$MMAGIntegrateTimeout, "s)..."]];
        gintRes = TimeConstrained[
          Quiet[GIntegrate[terr13, xa]],
          $IV$MMAGIntegrateTimeout, $Failed];
        If[gintRes === $Failed,
          If[verbose, Print["[MMA]   GIntegrate failed"]];
          Throw[$Failed, "mma"]];
        If[verbose, Print["[MMA]   GIntegrate done LC=", LeafCount[gintRes]]];
        Module[{hiB = Quiet[IV$RegBoundary[gintRes /. xa -> 1]],
                loB = Quiet[IV$RegBoundary[gintRes /. xa -> 0]]},
          (* F3 (2026-08-29): fail-closed IV$RegBoundary may return $Failed;
             never let it into the difference (it leaked as "c*$Failed"). *)
          If[hiB === $Failed || loB === $Failed,
            If[verbose, Print["[MMA]   boundary regularization failed"]];
            Throw[$Failed, "mma"]];
          terr14 = (hiB - loB) /. HPL[{1}, 1] :> 0];
        savedTC = TimeConstraint /. Options[Simplify];
        SetOptions[Simplify, TimeConstraint -> Infinity];
        terr15 = TimeConstrained[
          Collect[terr14, _G, Simplify],
          $IV$MMASimplifyTimeout, Collect[terr14, _G]];
        SetOptions[Simplify, TimeConstraint -> savedTC];
        cur = terr15;
        If[verbose, Print["[MMA]   final LC=", LeafCount[cur]]]]
    ],
    {i, Length[order]}];

  If[!FreeQ[cur, Alternatives @@ vars],
    If[verbose, Print["[MMA] FAILED: result still has integration vars"]];
    Throw[$Failed, "mma"]];

  {cur, lamRules}
], "mma"];

(* Outer wrapper: try the heuristic order, then fall back to other candidate
   orders (varying choice of LAST var) if the first one fails. *)
IV$MMAIntegrate[origExpr_, vars_List, paramAssoc_Association,
    OptionsPattern[{"IntegrationOrder" -> Automatic, "Verbose" -> True}]] :=
Module[{verbose = OptionValue["Verbose"], orderOpt = OptionValue["IntegrationOrder"],
        candidates, result = $Failed, attempted = 0},
  candidates = If[orderOpt === Automatic,
    IV$MMACandidateOrders[origExpr, vars, 5],
    {orderOpt}];
  If[verbose && Length[candidates] > 1,
    Print["[MMA] ", Length[candidates], " candidate orders to try (varying last var)"]];
  Do[
    attempted++;
    If[verbose && Length[candidates] > 1,
      Print["[MMA] candidate ", attempted, "/", Length[candidates], ": ", ord]];
    result = IV$MMAIntegrateOnce[origExpr, vars, paramAssoc, ord, verbose];
    If[ListQ[result] && Length[result] === 2 && result[[1]] =!= $Failed, Break[]];
    If[verbose && Length[candidates] > 1,
      Print["[MMA] candidate ", attempted, " failed; trying next"]];
  , {ord, candidates}];
  result];

(* ginsh cannot parse symbol names containing "$" (Unique/Module-generated:
   t1$DG, w$nnn, ...) \[LongDash] it emits "syntax error at $" per symbol and the call
   degrades to garbage. Rename such symbols to clean aliases before piping to
   ginsh; the value stays symbolic in the alias (correctly non-numeric). *)
IV$GinshSafe[e_] := IV$GinshSafeRecord[e]["Expression"]

(* Helper: numerically evaluate a symbolic result by substituting lamRules and
   paramAssoc, then per-GPL Ginsh. Returns a number or $Failed. *)
IV$EvalSymbolicNumeric[expr_, lamRules_List, paramAssoc_Association] := Module[
  {clean, coll, gpls},
  clean = expr //. lamRules;  (* //. : nested lam roots may reference earlier lams *)
  If[Length[paramAssoc] > 0, clean = clean /. Normal[paramAssoc]];
  coll = Quiet@Collect[clean, _G];
  gpls = If[Head[coll] === Plus, List @@ coll, {coll}];
  Quiet@TimeConstrained[
    Sum[Module[{factors = If[Head[t] === Times, List @@ t, {t}],
                gFactors, cFactors, coeff, gPart},
      gFactors = Select[factors, !FreeQ[#, _G] &];
      cFactors = Select[factors, FreeQ[#, _G] &];
      coeff = Times @@ cFactors;
      gPart = Times @@ gFactors;
      If[FreeQ[gPart, _G], N[t], coeff * Quiet[Ginsh[IV$GinshSafe[gPart], {}]]]],
      {t, gpls}], 60, $Failed]]

(* Helper: True if symbolic value is plausibly consistent with MC reference.
   Catches silent zeros (sym=0 but mc\[NotEqual]0). Tolerant of MC noise. *)
IV$AcceptableNumericQ[symV_, mcVal_] := Which[
  !NumericQ[symV] || !NumericQ[mcVal], True,  (* Can't compare; accept *)
  Abs[mcVal] < 0.01, Abs[Re[symV]] < 0.05,    (* MC ~0; accept only if sym ~0 *)
  True, Abs[Re[symV] - mcVal]/(Abs[mcVal] + 0.01) < 0.7]  (* Loose tolerance *)

(* True if the integrand is INDIVIDUALLY DIVERGENT at a cube-var endpoint v=1, i.e. it
   has a 1/(v-1) pole NOT compensated by a Log[v] in the numerator (e.g. the psi0^k Bell
   sub-pieces like -gamma^3 Log[u] t/((s-1)(...)): Int_0^1 ds/(s-1) diverges and only its
   shuffle-regularized finite part is meaningful, while a per-piece NIntegrate gives a
   garbage truncated value).  The first-order MC-validation MUST NOT fire on such pieces
   -- it would falsely reject the correct regularized result against a meaningless MC
   reference.  Their divergences cancel across the summed pieces. *)
IV$EndpointDivergentQ[expr_, vars_List] := Quiet@Check[
  AnyTrue[vars, Function[v,
    Module[{rat = expr /. _G -> 1, den, num},
      den = Denominator[Together[rat]]; num = Numerator[Together[rat]];
      TrueQ[PossibleZeroQ[den /. v -> 1]] && FreeQ[num, Log[v]]]]],
  False]

(* Exact terminal affine-log reduction (2026-08-28).

   A polygamma integral representation can leave a terminal pair x,y in

     R(x,...) (1-x)/(x+(1-x)y)
       [EulerGamma-Log[1-x]-Log[y]+Log[x+(1-x)y]],

   where R is independent of y.  On the IntVol cube 0<x,y<1,

     Integral_0^1 dy (1-x)/(x+(1-x)y) [ ... ]
       = Pi^2/6-PolyLog[2,x]-EulerGamma Log[x].

   Put a=x/(1-x), integrate Log[y]/(a+y), and use dilogarithm inversion
   plus Spence's identity.  Every logarithm has a positive argument in the
   open cube, so this introduces no branch continuation.

   The detector is deliberately narrow and fail-closed: it requires an exact
   top-level log factor, exact reconstruction, a y-independent remainder, and
   no finite-precision atoms.  A miss leaves the ordinary route unchanged. *)
IV$TerminalAffineLogReduce[expression_, variables_List] := Module[
  {pairs, pair, x, y, d, expectedLog, factors, logFactor, remainder,
   reconstruction, reduced, inexactAtoms},
  If[Length[variables] < 2, Return[$Failed]];
  inexactAtoms = Cases[expression,
    number_?NumberQ /; Precision[Unevaluated[number]] =!= Infinity :> number,
    {0, Infinity}, Heads -> True];
  If[inexactAtoms =!= {}, Return[$Failed]];
  pairs = Permutations[variables, {2}];
  Do[
    x = pair[[1]]; y = pair[[2]];
    d = Expand[x + (1 - x) y];
    expectedLog = EulerGamma - Log[1 - x] - Log[y] + Log[d];
    factors = If[Head[expression] === Times, List @@ expression, {expression}];
    logFactor = SelectFirst[factors,
      TrueQ[Quiet@PossibleZeroQ[# - expectedLog]] &, Missing["NotFound"]];
    If[! MissingQ[logFactor],
      remainder = Quiet@CheckAbort[
        TimeConstrained[
          Cancel[Together[(expression/logFactor) d/(1 - x)]],
          30, $Failed], $Failed];
      If[remainder =!= $Failed && FreeQ[remainder, y] &&
         FreeQ[remainder, Indeterminate | ComplexInfinity | DirectedInfinity],
        reconstruction = Quiet@CheckAbort[
          TimeConstrained[
            Cancel[Together[expression -
              remainder (1 - x) logFactor/d]], 30, $Failed], $Failed];
        If[TrueQ[reconstruction === 0] ||
           TrueQ[Quiet@PossibleZeroQ[reconstruction]],
          reduced = Expand[remainder (
            Pi^2/6 - PolyLog[2, x] - EulerGamma Log[x])];
          If[FreeQ[reduced, y | $Failed | Indeterminate | ComplexInfinity |
               DirectedInfinity],
            Return[<|"Expression" -> reduced,
              "Variables" -> DeleteCases[variables, y],
              "RetainedVariable" -> x, "EliminatedVariable" -> y,
              "IdentityGate" -> True|>, Module]]]]],
    {pair, pairs}];
  $Failed]

(* Exact positivity normalization for IntVol cubes.  MBtoEuler sometimes
   leaves Abs[rational] factors even though every cube variable is restricted
   to 0<x<1 and the rational sign is fixed on that open cube.  Those inert Abs
   heads can make an otherwise linearly reducible integral look non-rational.
   FullSimplify is used only under the defining cube assumptions, followed by
   an independent symbolic difference gate.  A miss changes nothing. *)
IV$PositiveCubeAbsReduce[expression_, variables_List] := Module[
  {absBefore, assumptions, reduced, difference, absAfter, inexactAtoms},
  absBefore = Length@Cases[expression, _Abs, {0, Infinity}];
  If[absBefore === 0 || variables === {}, Return[$Failed]];
  inexactAtoms = Cases[expression,
    number_?NumberQ /; Precision[Unevaluated[number]] =!= Infinity :> number,
    {0, Infinity}, Heads -> True];
  If[inexactAtoms =!= {}, Return[$Failed]];
  assumptions = And @@ ((0 < # < 1) & /@ variables);
  reduced = Quiet@CheckAbort[TimeConstrained[
    FullSimplify[expression, assumptions], 120, $Failed], $Failed];
  If[reduced === $Failed, Return[$Failed]];
  absAfter = Length@Cases[reduced, _Abs, {0, Infinity}];
  If[absAfter >= absBefore, Return[$Failed]];
  difference = Quiet@CheckAbort[TimeConstrained[
    FullSimplify[expression - reduced, assumptions], 120, $Failed], $Failed];
  If[! TrueQ[difference === 0] &&
     ! TrueQ[Quiet@PossibleZeroQ[difference]], Return[$Failed]];
  If[Cases[reduced,
       number_?NumberQ /; Precision[Unevaluated[number]] =!= Infinity :>
         number, {0, Infinity}, Heads -> True] =!= {} ||
     ! FreeQ[reduced, $Failed | Indeterminate | ComplexInfinity |
       DirectedInfinity], Return[$Failed]];
  <|"Expression" -> reduced, "Variables" -> variables,
    "AbsBefore" -> absBefore, "AbsAfter" -> absAfter,
    "IdentityGate" -> True|>]

(* Main integration over [0,1]^n *)
IntVolIntegrate[expr_, vars_List, IVOptions:OptionsPattern[]] := Module[
  {libSet, order, orderOpt, fitOpt, paramOpt, verbose, trackReg, simplifySteps,
   greedySearch, doLambda, mainFit, paramFit, regSyms,
   S0, orderResult, cur, ok, autoOrder, userOrder, S0evolved, remVars,
   orderRetryTO, maxRetryOrders, allLamRules = {},
   mcRef = $Failed, mcComputed = False,
   getMC, libHit, libOrders, libRes, kinOpt, tStart = AbsoluteTime[],
   certOpt, certOK = Automatic, certVal = Missing[], certAnc = Missing[],
    ivfF6Reset = ($IV$MCMismatchUnrepaired = False),   (* F6b: reset the fail-closed flag per call *)
   kinRules = {}, positiveAbs, positiveResult, terminalAffine,
   terminalResult},

  kinOpt=OptionValue["Kinematics"]; certOpt=OptionValue["Certify"];
  verbose=OptionValue["Verbose"];

  (* ---- Resolve the DECLARED KINEMATICS *FIRST* (2026-07-13) ----
     This MUST happen before the library lookup below.  A stored result is keyed
     by the POINT it was derived at — it is only valid there.  Resolving the point
     afterwards meant the lookup hashed against the PREVIOUS call's kinematics and
     cheerfully served a result CERTIFIED AT kq1=0.37 back for kq1=0.81.
     (`IVLibQueryExact` refuses correctly when handed the point; the engine simply
     wasn't handing it the right one yet.)  It also gates the template engine. *)
  Module[{kin0 = Switch[kinOpt, Automatic, $IV$Kinematics,
      _List, Association @@ kinOpt, _Association, kinOpt, _, $IV$Kinematics]},
    $IV$KinCurrent  = KeyDrop[kin0, vars];
    $IV$KinDeclared = (Length[$IV$KinCurrent] > 0);
    kinRules        = Normal[$IV$KinCurrent]];

  (* Remove only Abs factors whose signs are proved by the defining open-cube
     assumptions.  Variables are unchanged, so an explicit integration order
     remains valid and all caller options can be forwarded verbatim. *)
  positiveAbs = IV$PositiveCubeAbsReduce[expr, vars];
  If[AssociationQ[positiveAbs] &&
     TrueQ[Lookup[positiveAbs, "IdentityGate", False]],
    If[verbose, Print["[PositiveCubeAbs] exact reduction ",
      positiveAbs["AbsBefore"], " -> ", positiveAbs["AbsAfter"],
      " Abs factors"]];
    positiveResult = IntVolIntegrate[
      positiveAbs["Expression"], positiveAbs["Variables"], IVOptions];
    If[AssociationQ[positiveResult],
      positiveResult = Join[positiveResult,
        <|"PositiveCubeAbsReduction" ->
          KeyTake[positiveAbs, {"AbsBefore", "AbsAfter", "IdentityGate"}]|>]];
    Return[positiveResult]];

  (* Apply the exact dimension-lowering theorem before order search and
     library lookup.  An explicit order contains the eliminated variable, so
     the recursive lower-dimensional call recomputes a valid order. *)
  terminalAffine = IV$TerminalAffineLogReduce[expr, vars];
  If[AssociationQ[terminalAffine] &&
     TrueQ[Lookup[terminalAffine, "IdentityGate", False]],
    If[verbose, Print["[TerminalAffine] exact reduction eliminating ",
      terminalAffine["EliminatedVariable"]]];
    terminalResult = IntVolIntegrate[
      terminalAffine["Expression"], terminalAffine["Variables"],
      Sequence @@ DeleteCases[Flatten[{IVOptions}],
        HoldPattern["IntegrationOrder" -> _]]];
    If[AssociationQ[terminalResult],
      terminalResult = Join[terminalResult,
        <|"TerminalAffineReduction" ->
          KeyTake[terminalAffine, {"RetainedVariable",
            "EliminatedVariable", "IdentityGate"}]|>]];
    Return[terminalResult]];
  orderOpt=OptionValue["IntegrationOrder"]; fitOpt=OptionValue["FitValues"];
  paramOpt=OptionValue["ParametricValues"]; verbose=OptionValue["Verbose"];
  trackReg=OptionValue["TrackRegulator"]; simplifySteps=OptionValue["SimplifySteps"];
  greedySearch=OptionValue["GreedySearch"];
  doLambda=OptionValue["LambdaSubstitution"];
  orderRetryTO=OptionValue["OrderRetryTimeout"];
  maxRetryOrders=OptionValue["MaxRetryOrders"];
  IV$Timeout=OptionValue["Timeout"];

  (* Ranked-order engine: per-call caches (Section 3B) *)
  $IV$OrderMemo = <||>;
  $IV$LastRankedOrders = Missing["NotComputed"];
  $IV$FailedPrefixes = {};
  $IV$PrefixCache = <||>;
  $IV$StepTimes = {};

  (* ---- LIBRARY (optional): certified exact re-encounter -> stored result.
     Only records the library itself certified are ever returned here. ---- *)
  (* ---- LIBRARY: SPECIAL INSTRUCTIONS for this SHAPE ----
     Re-enter ONCE with the stored engine settings Block'd in.  This is how a
     special case gets its non-default machinery without the general engine
     carrying the cost for everyone.  The guard makes it strictly one level.
     Only these settings are honoured (a whitelist, not an eval). ---- *)
  If[!TrueQ[$IV$LibSettingsApplied],
    libSet = IV$LibCall[$IV$LibSettings, {expr, vars}, <||>];
    If[AssociationQ[libSet] && Length[libSet] > 0,
      If[verbose, Print["[Lib] special route -> ", Normal[libSet]]];
      Return[Block[{
          $IV$LibSettingsApplied = True,
          $IV$FTNonlinear     = Lookup[libSet, "FTNonlinear",     $IV$FTNonlinear],
          $IV$FTDeriveCap     = Lookup[libSet, "FTDeriveCap",     $IV$FTDeriveCap],
          $IV$UseFibTemplates = Lookup[libSet, "UseFibTemplates", $IV$UseFibTemplates],
          $IterationLimit     = Lookup[libSet, "IterationLimit",  $IterationLimit]},
        (* a route may also pin the order — but an explicit caller order wins *)
        IntVolIntegrate[expr, vars,
          Sequence @@ If[KeyExistsQ[libSet, "IntegrationOrder"] &&
              FreeQ[Flatten[{IVOptions}], HoldPattern["IntegrationOrder" -> _]],
            {"IntegrationOrder" -> libSet["IntegrationOrder"]}, {}],
          IVOptions]]]]];

  libHit = IV$LibCall[$IV$LibLookup, {expr, vars}, None];
  If[AssociationQ[libHit] && Lookup[libHit, "Result", $Failed] =!= $Failed,
    If[verbose, Print["[Lib] exact certified match \[LongDash] returning stored result"]];
    Return[<|"Result" -> libHit["Result"],
             "LamRules" -> Lookup[libHit, "LamRules", {}],
             "Order" -> Lookup[libHit, "Order", vars],
             "FromLibrary" -> True|>]];

  (* ---- LIBRARY (optional): try integration orders that are known to work on
     this SHAPE before paying for the order search (~85% of a hard solve).
     A learned order is only a shortcut: any valid order gives the same
     integral, and a failing attempt falls through to the normal flow. ---- *)
  If[orderOpt === Automatic || orderOpt === {},
    libOrders = IV$LibCall[$IV$LibOrders, {expr, vars}, {}];
    If[ListQ[libOrders] && libOrders =!= {},
      Do[
        If[ListQ[o] && Sort[o] === Sort[vars],
          If[verbose, Print["[Lib] trying learned order ", o]];
          libRes = Quiet@TimeConstrained[
            IntVolIntegrate[expr, vars, "IntegrationOrder" -> o,
              Sequence @@ DeleteCases[Flatten[{IVOptions}],
                HoldPattern["IntegrationOrder" -> _]]],
            $IV$LibOrderCap, $Failed];
          If[AssociationQ[libRes] &&
              Lookup[libRes, "Result", $Failed] =!= $Failed &&
              Lookup[libRes, "Certified", Automatic] =!= False,
            If[verbose, Print["[Lib] learned order succeeded"]];
            Return[Append[libRes, "FromLibraryOrder" -> True]]];
          If[verbose, Print["[Lib] learned order failed \[LongDash] full search"]]],
        {o, Take[libOrders, UpTo[$IV$LibOrderTries]]}]]];

  (* Order.  NB (2026-07-02): the first pick stays with the LEGACY IV$BestOrder.
     A structural re-ranking experiment (late-weighted LeafCount S-chains,
     IV$RankedOrders) mis-ordered the empirically good orders on the 6-var
     PolyGamma calibration case AND cost ~2 min to enumerate -- the S-chain
     does not predict real step cost.  The Section-3B machinery is instead
     applied where it is provably safe and large: the RETRY loops (structural
     pre-validation, failed-prefix pruning, cached-prefix resumption). *)
  If[orderOpt===Automatic||orderOpt==={},
    If[verbose, Print["Finding optimal integration order..."]];
    If[greedySearch||Length[vars]>7||
       (* when the best-first engine will run, skip the expensive
          full-permutation enumeration: the greedy pick is only the SECOND
          dive seed (after the entanglement order) and the frontier search
          supersedes static ranking anyway.
          v8 (2026-07-02): restored IV$BestOrder for D<=5 even on the
          ProbeRace path -- cheap there (<=120 grouped perms), and it is
          the seed that made res5 B1 (5-fold) complete in 4.4s under v3;
          the greedy replacement sent B1's dive into a kernel-aborting
          ginsh fit.  Skip enumeration only for D>=6. *)
       (TrueQ[$IV$ProbeRace] && Length[vars] >= Max[6, $IV$ProbeMinVars] &&
        Length[vars] <= $IV$RankedMaxVars),
      orderResult=IV$GreedyOrder[expr,vars],
      orderResult=IV$BestOrder[expr,vars]];
    ok=orderResult[[1]]; order=orderResult[[2]]; S0=orderResult[[3]];
    If[!ok,
      (* No linearly reducible order. Use quadratic-last heuristic:
         put variables with quadratic denominator dependence LAST
         so PLT's lambda substitution handles them at the final steps. *)
      If[verbose, Print["  No linear order; trying quadratic-last..."]];
      Module[{linVars, quadVars, candOrders},
        linVars = Select[vars, IV$QuadraticDepsFromS0[S0, #, vars] === {} &];
        quadVars = Complement[vars, linVars];
        quadVars = SortBy[quadVars, Length[Intersection[IV$QuadraticDepsFromS0[S0, #, vars], quadVars]] &];
        candOrders = If[Length[linVars] > 0 && Length[Permutations[linVars]] <= 120,
          Join[#, quadVars] & /@ Permutations[linVars],
          {Join[linVars, quadVars]}];
        AppendTo[candOrders, Join[linVars, Reverse[quadVars]]];
        candOrders = DeleteDuplicates[candOrders];
        order = candOrders[[1]];
      ]];
    If[verbose, Print["Integration order: ",order]],
    If[ListQ[orderOpt]&&Length[orderOpt]==Length[vars], order=orderOpt; S0={},
      If[ListQ[orderOpt]&&Length[orderOpt]<Length[vars],
        userOrder=orderOpt; remVars=Complement[vars,userOrder];
        S0=IV$ExtractS0[expr,vars]; S0evolved=S0;
        Do[S0evolved=IV$NextS[S0evolved,v,vars],{v,userOrder}];
        Module[{perms=Permutations[remVars],bestOrd=remVars,bestScore=Infinity},
          If[Length[perms]<=5040,Do[Module[{res=IV$TryOrder[S0evolved,p,remVars]},
            If[res[[1]]&&Total[res[[3]]]<bestScore,bestScore=Total[res[[3]]];bestOrd=p]],{p,perms}]];
          autoOrder=bestOrd]; order=Join[userOrder,autoOrder],
        order=vars; S0={}]];
    If[verbose, Print["Integration order: ",order]]];

  (* Fit values *)
  mainFit = Switch[fitOpt, Automatic, IV$DefaultFitValues[vars],
    _List, Association@@fitOpt, _Association, fitOpt, _, IV$DefaultFitValues[vars]];
  paramFit = Switch[paramOpt, Automatic, <||>,
    _List, Association@@paramOpt, _Association, paramOpt, _, <||>];
  (* DECLARED KINEMATICS take precedence over invented fits: the identity must
     be derived AT the point where the answer will be evaluated (see the
     "Declared kinematics" header).  Per-call "Kinematics" beats the global. *)
  (* the point was already resolved above (before the library lookup); here we
     only merge it into the fit values *)
  If[Length[kinRules] > 0,
    paramFit = Join[$IV$KinCurrent, paramFit];
    If[verbose, Print["[Kin] fibrating at the DECLARED kinematic point: ", kinRules]];
    If[!IVKinematicsInRegionQ[] && verbose,
      Print["[Kin] NOTE: declared point lies outside the declared region"]]];
  Module[{allSyms=IV$AllSyms[expr],unknown,autoVals},
    unknown=Complement[allSyms,Keys[mainFit],Keys[paramFit],vars];
    If[Length[unknown]>0,
      (* A kinematic value the caller did NOT declare is being invented — that
         is precisely how fit-point != evaluation-point corruption creeps in. *)
      If[TrueQ[$IV$WarnInventedFits] && verbose,
        Print["[Kin] WARNING: inventing fit values for ", unknown,
          " \[LongDash] declare them with IVSetKinematics to fibrate where you evaluate"]];
      (* Use a list of "generic" floats (no algebraic relations) instead of an
         arithmetic progression. Auto-fits like {1/4, 1/3, 5/12, 1/2, ...} cause
         spurious linear dependencies in ToFibrationBasis's fiber equations,
         making integration of some integrands fail silently. The values below
         are the standard physics test point \[LongDash] small, distinct, with no obvious
         arithmetic combinations summing to round numbers. *)
      Module[{goodVals = {0.4, 0.2, 0.3, 0.6, 0.5, 0.23, 0.7,
                          0.13, 0.87, 0.41, 0.58, 0.29, 0.71, 0.37,
                          0.62, 0.18, 0.83, 0.46, 0.27, 0.91},
              n = Length[unknown]},
        autoVals = AssociationThread[unknown -> Take[goodVals, UpTo[n]]];
        (* Pad with hash-based pseudo-random for n>20 *)
        If[n > Length[goodVals],
          autoVals = Join[autoVals,
            AssociationThread[unknown[[Length[goodVals]+1;;]] ->
              ((0.1 + 0.85*Mod[Hash[ToString[#], "MD5"]/1000., 1.])& /@ unknown[[Length[goodVals]+1;;]])]]]];
      paramFit=Join[paramFit,autoVals]; If[verbose,Print["Auto-param: ",Normal[autoVals]]]]];

  (* Regulators *)
  regSyms = If[trackReg, Table[Symbol["IVreg$"<>ToString[i]],{i,Length[order]}], ConstantArray[0,Length[order]]];

  (* Lazy MC reference \[LongDash] computed on first call to getMC[].
     Used by retry loop to reject silent-zero "successes": orders that pass
     all structural checks but produce a result that disagrees with the MC. *)
  getMC[] := If[mcComputed, mcRef,
    mcComputed = True;
    Module[{paramAssoc = Join[mainFit, paramFit],
            kinAssoc, mcExpr},
      kinAssoc = KeyDrop[paramAssoc, vars];
      mcExpr = If[Length[kinAssoc] > 0, expr /. Normal[kinAssoc], expr];
      (* Cheap sanity-only reference used by IV$AcceptableNumericQ with a LOOSE
         0.7 tolerance (catches gross errors: silent zeros, wrong constants).
         ADAPTIVE-FIRST (2026-07-10): MonteCarlo is BIASED on log-endpoint-
         singular integrands (8-12% demonstrated on the weight-6 family; it
         waved the silent-wrong 2$4/2$5 May results through) \[LongDash] use cheap
         GlobalAdaptive first, MonteCarlo only as last-resort fallback. *)
      mcRef = With[{mE = mcExpr, iters = ({#, 0, 1} & /@ vars)},
        Quiet@TimeConstrained[
          NIntegrate[mE, Evaluate[Sequence @@ iters],
            PrecisionGoal -> 3, MaxRecursion -> 12],
          20, $Failed]];
      If[!NumericQ[mcRef],
        mcRef = With[{mE = mcExpr, iters = ({#, 0, 1} & /@ vars)},
          Quiet@TimeConstrained[
            NIntegrate[mE, Evaluate[Sequence @@ iters],
              Method -> {"MonteCarlo", "MaxPoints" -> 20000},
              PrecisionGoal -> 1],
            6, $Failed]]];
      If[verbose && mcRef =!= $Failed,
        Print["[MC ref] ", mcRef]];
      mcRef]];

  (* MEASURED BEST-FIRST INTEGRATION (Section 3C): when enabled and the order
     was Automatic, run the probe-race search first.  It integrates real steps
     best-first over the prefix tree; success returns the COMPLETED result (the
     search IS the integration).  On failure it leaves warm prefix caches and
     recorded failed prefixes for the ordinary flow + retry engine below. *)
  Module[{bfDone = False},
  If[TrueQ[$IV$ProbeRace] && (orderOpt === Automatic || orderOpt === {}) &&
     Length[vars] >= $IV$ProbeMinVars && Length[vars] <= $IV$RankedMaxVars,
    $IV$BFSeedOrder = order;  (* reuse the already-computed legacy pick as the dive seed *)
    Module[{bf = IV$BestFirstIntegrate[expr, vars, mainFit, paramFit, regSyms,
        doLambda, verbose]},
      If[bf =!= $Failed,
        order = bf[[1]]; cur = bf[[2]]; allLamRules = bf[[3]];
        Module[{lf = Select[(#[[1]] -> Quiet@N[#[[2]] /. Normal[mainFit] /. Normal[paramFit]]) & /@
             allLamRules, NumericQ[#[[2]]] &]},
          paramFit = Join[paramFit, Association[lf]]];
        bfDone = True;
        If[verbose, Print["[BF] completed via measured best-first order: ", order]]]]];

  If[!bfDone,
  (* Integration loop. If a step fails we fall through to retry with permuted orders
     instead of returning $Failed immediately \[LongDash] this is the core failsafe. *)
  cur = expr;
  Module[{stepFailed = False},
    Do[Module[{xa=order[[i]], rem=order[[i+1;;]], reg=regSyms[[i]], isLast=(i==Length[order]),
               stepResult, stepLams, tStep = AbsoluteTime[]},
      If[verbose, Print["Step ",i,"/",Length[order],":"]];
      {stepResult,stepLams}=IV$IntegrateStep[cur,xa,0,1,rem,mainFit,paramFit,reg,isLast&&doLambda,verbose];
      AppendTo[$IV$StepTimes, {xa, Round[AbsoluteTime[] - tStep, 0.1],
        If[stepResult === $Failed, "failed", "ok"]}];
      If[stepResult===$Failed,
        If[verbose, Print["    Step ",i," failed; will trigger retry"]];
        (* Section 3B: remember the failing prefix so the ranked retry skips
           every candidate sharing it *)
        If[TrueQ[$IV$FastOrder], AppendTo[$IV$FailedPrefixes, order[[1 ;; i]]]];
        cur = $Failed; stepFailed = True; Break[]];
      If[Length[stepLams]>0,
        allLamRules = Join[allLamRules, stepLams];
        Module[{lf=Select[(#[[1]]->Quiet@N[#[[2]]/.Normal[mainFit]/.Normal[paramFit]])&/@stepLams, NumericQ[#[[2]]]&]},
          paramFit=Join[paramFit,Association[lf]]]];
      cur=stepResult;
      (* Section 3B: cache the successful prefix state for retry reuse *)
      If[TrueQ[$IV$FastOrder] && i < Length[order] && LeafCount[cur] < 200000,
        $IV$PrefixCache[order[[1 ;; i]]] = {cur, allLamRules}];
      (* Between-step diagnostics + size control: report cur LC after each step.
         For large intermediates (>10k leaves), apply Together to each G-coefficient
         to combine common denominators (can shrink dramatically). *)
      If[verbose, Print["    [Step ",i," done] cur LC: ",LeafCount[cur]]];
      (* Together compaction is OFF for huge expressions: it wastes 60s without
         shrinking. Only attempt for moderate LC where it has a chance of helping. *)
      If[LeafCount[cur] > 10000 && LeafCount[cur] < 100000,
        If[verbose, Print["    [Compact] LC ",LeafCount[cur]," > 10k \[LongDash] applying Together to G-coefficients"]];
        Module[{tt = AbsoluteTiming[
          cur = TimeConstrained[
            Collect[cur, _G, Together], 60, cur]]},
          If[verbose, Print["    [Compact] done in ",tt[[1]],"s, new LC ",LeafCount[cur]]]]];
      (* Above 100k LC Together is hopeless and NO compaction used to run here,
         so swelling compounded into the next level.  FF finite-field
         reconstruction of the G-coefficients closes that hole (2026-07-11). *)
      If[LeafCount[cur] >= 100000,
        If[verbose, Print["    [Compact-FF] LC ",LeafCount[cur],
          " \[GreaterEqual] 100k \[LongDash] FF/grouped compaction of G-coefficients"]];
        Module[{tt = AbsoluteTiming[
          cur = TimeConstrained[
            Collect[cur, _G, IV$CompactCoef], 600, cur]]},
          If[verbose, Print["    [Compact-FF] done in ",tt[[1]],"s, new LC ",LeafCount[cur]]]]];
      (* Canonicalization step (user's standard pattern: Collect[#, _G, Simplify] &).
         Gated by LC threshold + time constraint to avoid hangs. *)
      If[$IV$CanonicalizeAfterEachStep && LeafCount[cur] < $IV$CanonicalizeMaxLC,
        Module[{tCan = AbsoluteTiming[
          cur = TimeConstrained[
            cur // Collect[#, _G, Simplify] &,
            $IV$CanonicalizeTimeConstraint, cur]]},
          If[verbose, Print["    [Canonicalize] LC ", LeafCount[cur],
            " (", tCan[[1]], "s)"]]]];
      If[simplifySteps,cur=Simplify[cur]];
      IV$CallStepTrace[<|"Step" -> i, "Variable" -> xa,
        "Remaining" -> rem, "Order" -> order, "Result" -> cur,
        "LamRules" -> allLamRules|>];
    ], {i, Length[order]}]];
  ]];  (* close If[!bfDone, ...] and Module[{bfDone}, ...] (Section 3C) *)

  (* MC-validate the FIRST-order result.  A structurally-clean but numerically WRONG
     value -- e.g. a boundary-regularization artifact that collapsed to a constant
     (-Log^5 t/(120(..)) integrated to 1 instead of ~5.087, an order-dependent leak) --
     must trigger the order-retry rather than be accepted.  The retry loop already
     MC-checks each alternative (IV$EvalSymbolicNumeric vs IV$AcceptableNumericQ);
     this extends the SAME guard to the initial order.  getMC[] is lazy (one NIntegrate
     per piece). *)
  If[! TrueQ[$IV$SkipFirstOrderMC] &&
     orderOpt === Automatic && cur =!= $Failed && FreeQ[cur, Alternatives @@ vars] &&
     cur =!= Indeterminate && cur =!= Undefined && ! IV$HasFrozenTermsQ[cur] &&
     ! IV$EndpointDivergentQ[expr, vars],
    Module[{symV, mcV = getMC[]},
      symV = Quiet@IV$EvalSymbolicNumeric[cur, allLamRules, Join[mainFit, paramFit]];
      If[NumericQ[mcV] && NumericQ[symV] && ! IV$AcceptableNumericQ[symV, mcV],
        If[verbose, Print["[MC-CHECK] first order symbolic ", symV, " vs MC ", mcV,
          " \[LongDash] inconsistent, forcing order-retry"]];
        cur = $Failed]]];

  (* Retry *)
  If[(cur===Indeterminate||IV$HasFrozenTermsQ[cur])&&orderOpt===Automatic,
    Module[{rVars,tVars2,altPerms,altTrials,altValid,altScored,altOrd},
      rVars=Select[vars,IV$IsRationalOnlyQ[expr,#]&]; tVars2=Complement[vars,rVars];
      If[Length[rVars]>0&&rVars=!=order[[1;;Min[Length[rVars],Length[order]]]],
        If[verbose,Print["[RETRY] rational-first: ",rVars]];
        altPerms=Flatten[Outer[Join,{rVars},Permutations[tVars2],1],1];
        altTrials={#,IV$TryOrder[S0,#,vars]}&/@altPerms;
        altValid=Select[altTrials,#[[2,1]]===True&];
        If[Length[altValid]>0,altScored=SortBy[{#[[1]],Total[#[[2,3]]]}&/@altValid,Last];
          altOrd=altScored[[1,1]]; If[verbose,Print["[RETRY] Order: ",altOrd]];
          cur=expr; Do[Module[{xa=altOrd[[i]],rem=altOrd[[i+1;;]],reg=regSyms[[i]],r,l},
            If[verbose,Print["[RETRY] Step ",i]];
            {r,l}=IV$IntegrateStep[cur,xa,0,1,rem,mainFit,paramFit,reg,(i==Length[altOrd])&&doLambda,verbose];
            cur=r; If[simplifySteps,cur=Simplify[cur]]],{i,Length[altOrd]}]]]]];

  (* Retry with permuted order if result has leaked vars, is Indeterminate, frozen, or $Failed *)
  If[(cur === $Failed || !FreeQ[cur, Alternatives @@ vars] || cur === Indeterminate ||
      cur === Undefined || IV$HasFrozenTermsQ[cur]) && orderOpt === Automatic,
    If[verbose, Print["[RETRY] Result unusable (",
      Which[cur===$Failed,"step-failed", cur===Indeterminate,"Indeterminate",
        cur===Undefined,"Undefined",
        IV$HasFrozenTermsQ[cur],"frozen", True,"vars-leaked"],
      "), trying permuted orders..."]];
    (* Clear any partial lambda rules from the failed attempt *)
    allLamRules = {};
    Module[{S0r = IV$ExtractS0[expr, vars], allPerms, tried = {order}, success = False, attempted = 0,
            logVars = IV$LogArgVars[expr, vars]},
      (* Ranked-order engine (Section 3B): retry only STRUCTURALLY VALID orders,
         best-ranked first, instead of raw Permutations.  Legacy path kept
         behind $IV$FastOrder. *)
      If[TrueQ[$IV$FastOrder],
        allPerms = IV$RetryCandidates[expr, vars, order],
        allPerms = Select[Permutations[vars], # =!= order &];
        (* Bias retry: orders with more log-vars at the front are tried first.
           Sort by negative count of log-vars in leading positions (so log-first
           orders rank highest), breaking ties by Permutations' default order. *)
        If[Length[logVars] > 0,
          allPerms = SortBy[allPerms,
            -Count[Take[#, Min[Length[logVars], Length[#]]],
              v_ /; MemberQ[logVars, v]] &]]];
      If[maxRetryOrders > 0 && Length[allPerms] > maxRetryOrders,
        allPerms = Take[allPerms, maxRetryOrders]];
      Do[Module[{tryOrd = p, tryRes},
        (* failure-prefix pruning: a prefix that already failed at step j fails
           again for every candidate sharing it -- skip without integrating *)
        If[TrueQ[$IV$FastOrder] && IV$PrefixFailedQ[tryOrd],
          If[verbose, Print["[RETRY] skipping ", tryOrd, " (failed prefix)"]];
          Continue[]];
        (* structural pre-validation: don't spend an integration attempt on an
           order that fails the linear-reducibility degree check *)
        If[TrueQ[$IV$FastOrder] && ! IV$OrderValidQ[S0r, tryOrd, vars],
          If[verbose, Print["[RETRY] skipping ", tryOrd, " (not linearly reducible)"]];
          Continue[]];
        If[verbose, Print["[RETRY ",++attempted,"/",Length[allPerms],"] Trying order: ", tryOrd]];
        tryRes = TimeConstrained[
          Module[{tryCur = expr, tryOk = True, tryLams = {}, startIdx = 0},
            (* reuse the longest cached successful prefix (Section 3B).  The
               cached state is exact: the step result depends on the integrand
               state and the variable, not on the ordering hints of the
               remaining set. *)
            If[TrueQ[$IV$FastOrder],
              Do[If[KeyExistsQ[$IV$PrefixCache, tryOrd[[1 ;; k]]], startIdx = k],
                {k, Length[tryOrd] - 1}];
              If[startIdx > 0,
                {tryCur, tryLams} = $IV$PrefixCache[tryOrd[[1 ;; startIdx]]];
                If[verbose, Print["[RETRY] resuming from cached prefix ",
                  tryOrd[[1 ;; startIdx]]]]]];
            Do[Module[{xa = tryOrd[[j]], rem = tryOrd[[j+1;;]], r, l},
              {r, l} = IV$IntegrateStep[tryCur, xa, 0, 1, rem, mainFit, paramFit,
                regSyms[[j]], (j == Length[tryOrd]) && doLambda, False];
              If[r === $Failed || r === Indeterminate || r === Undefined ||
                 IV$HasFrozenTermsQ[r],
                tryOk = False;
                If[TrueQ[$IV$FastOrder],
                  AppendTo[$IV$FailedPrefixes, tryOrd[[1 ;; j]]]];
                Break[]];
              If[Length[l] > 0, tryLams = Join[tryLams, l]];
              tryCur = r;
              If[TrueQ[$IV$FastOrder] && j < Length[tryOrd] &&
                 LeafCount[tryCur] < 200000,
                $IV$PrefixCache[tryOrd[[1 ;; j]]] = {tryCur, tryLams}];
            ], {j, startIdx + 1, Length[tryOrd]}];
            If[tryOk && FreeQ[tryCur, Alternatives @@ vars] &&
               tryCur =!= Indeterminate && tryCur =!= Undefined &&
               !IV$HasFrozenTermsQ[tryCur],
              {tryCur, tryLams}, $Failed]],
          orderRetryTO, $Failed];
        If[tryRes =!= $Failed,
          (* Silent-zero check: reject if symbolic disagrees with MC *)
          Module[{symV, mcV = getMC[],
                  paramAssoc = Join[mainFit, paramFit]},
            symV = IV$EvalSymbolicNumeric[tryRes[[1]], tryRes[[2]], paramAssoc];
            If[NumericQ[mcV] && !IV$AcceptableNumericQ[symV, mcV],
              If[verbose, Print["[RETRY] Order ", tryOrd,
                " STRUCTURAL OK but symbolic ", symV, " vs MC ", mcV,
                " \[LongDash] rejecting silent-zero/wrong"]];
              tryRes = $Failed]];
          If[tryRes =!= $Failed,
            If[verbose, Print["[RETRY] Order ", tryOrd, " succeeded!"]];
            cur = tryRes[[1]]; allLamRules = Join[allLamRules, tryRes[[2]]];
            order = tryOrd; success = True; Break[]],
          If[verbose, Print["[RETRY] Order ", tryOrd, " failed/timeout"]]]
      ], {p, allPerms}];
    ]];

  (* Final cleanup. Skip Simplify on huge expressions (Mathematica's Simplify
     hangs at 300s+ for LC>1M with no benefit). Skip the second ShuffleRegulate
     too \[LongDash] it was already applied in IV$EvalDefinite during the last step. *)
  cur = IV$ResolveFrozen[cur];
  If[LeafCount[cur] < 100000,
    cur = Quiet[IV$RegBoundary[cur]] /. HPL[{1}, 1] -> 0;
    cur = Collect[cur, _G, Simplify],
    If[verbose, Print["[Final] LC=",LeafCount[cur]," > 100k \[LongDash] skipping Simplify"]];
    cur = cur /. HPL[{1}, 1] -> 0;
    cur = Collect[cur, _G];
    (* FF/grouped compaction of the final result's coefficients (hole-closure
       2026-07-11): previously the >100k branch returned UNCOMPACTED. *)
    If[verbose, Print["[Final-FF] FF/grouped compaction of final G-coefficients"]];
    cur = TimeConstrained[Collect[cur, _G, IV$CompactCoef], 600, cur];
    If[verbose, Print["[Final-FF] new LC=", LeafCount[cur]]]];

  (* Regulator-residual cleanup (2026-07-10, pt1:6-family bug): endpoint
     log-divergences cancel only MODULO the lambda root relations
     (lamA+lamB = c1/c2, lamA*lamB = c0/c2), which Collect/Simplify cannot see
     while the lambdas are ABSTRACT symbols \[LongDash] terms like
     C * Log[etNNN]^k (etNNN = Unique["et"] from IV$EvalDefinite) survive with
     C != 0 syntactically although C == 0 once the lambda VALUES are inserted.
     Test the residual with the explicit values: analytically zero -> drop;
     genuinely nonzero -> loud warning (uncancelled boundary divergence). *)
  Module[{regsFound, curT, cl, base, residCoeffs, zeroOK},
    regsFound = If[cur === $Failed, {},
      DeleteDuplicates[Cases[cur, s_Symbol /;
        StringMatchQ[SymbolName[s], "et" ~~ DigitCharacter ..], {0, Infinity}]]];
    If[regsFound =!= {},
      (* STRUCTURAL residual extraction: tag Log[et] and et powers, take the
         CoefficientList over the tags.  Do NOT test the residual as the
         difference of two big sums (cur - base): evaluating two near-equal
         O(1) sums numerically and subtracting loses the tiny residual to
         catastrophic cancellation and PossibleZeroQ judges it nonzero
         (first-attempt failure, 2026-07-10). *)
      curT = cur /. Log[s_Symbol /; MemberQ[regsFound, s]] -> IV$LREG /.
        Thread[regsFound -> IV$EREG];
      cl = Quiet@TimeConstrained[CoefficientList[curT, {IV$LREG, IV$EREG}],
        120, $Failed];
      If[cl =!= $Failed && Depth[cl] >= 3,
        base = cl[[1, 1]];
        residCoeffs = DeleteCases[Flatten[ReplacePart[cl, {1, 1} -> 0]], 0];
        zeroOK = AllTrue[residCoeffs,
          TrueQ[Quiet[PossibleZeroQ[Together[# /. allLamRules]]]] &];
        If[zeroOK,
          If[verbose, Print["[RegClean] dropped ", Length[residCoeffs],
            " analytically-zero regulator residual terms (", regsFound, ")"]];
          cur = base,
          Print["[RegClean] WARNING: NONZERO regulator residual (", regsFound,
            ") \[LongDash] possible uncancelled boundary divergence, result kept"]],
        Print["[RegClean] WARNING: residual extraction failed for ",
          regsFound, "; result kept"]]]];

  (* Post-cleanup retry: if Simplify/ShuffleRegulate collapsed cur to Indeterminate
     even though the per-step results were valid, try permuted orders. *)
  If[(cur === Indeterminate || cur === Undefined || cur === ComplexInfinity ||
      IV$HasFrozenTermsQ[cur]) && orderOpt === Automatic,
    If[verbose, Print["[POSTRETRY] Cleanup collapsed to ", cur, ", retrying permuted orders..."]];
    Module[{allPerms, success = False, attempted = 0,
            logVars = IV$LogArgVars[expr, vars],
            S0p = IV$ExtractS0[expr, vars]},
      If[TrueQ[$IV$FastOrder],
        allPerms = IV$RetryCandidates[expr, vars, order],
        allPerms = Select[Permutations[vars], # =!= order &];
        (* Bias log-first orders, same as RETRY loop. *)
        If[Length[logVars] > 0,
          allPerms = SortBy[allPerms,
            -Count[Take[#, Min[Length[logVars], Length[#]]],
              v_ /; MemberQ[logVars, v]] &]]];
      If[maxRetryOrders > 0 && Length[allPerms] > maxRetryOrders,
        allPerms = Take[allPerms, maxRetryOrders]];
      Do[Module[{tryOrd = p, tryRes},
        If[TrueQ[$IV$FastOrder] && IV$PrefixFailedQ[tryOrd],
          If[verbose, Print["[POSTRETRY] skipping ", tryOrd, " (failed prefix)"]];
          Continue[]];
        If[TrueQ[$IV$FastOrder] && ! IV$OrderValidQ[S0p, tryOrd, vars],
          If[verbose, Print["[POSTRETRY] skipping ", tryOrd, " (not linearly reducible)"]];
          Continue[]];
        If[verbose, Print["[POSTRETRY ",++attempted,"/",Length[allPerms],"] Trying: ", tryOrd]];
        tryRes = TimeConstrained[
          Module[{tryCur = expr, tryOk = True, tryLams = {}, tryClean, startIdx = 0},
            If[TrueQ[$IV$FastOrder],
              Do[If[KeyExistsQ[$IV$PrefixCache, tryOrd[[1 ;; k]]], startIdx = k],
                {k, Length[tryOrd] - 1}];
              If[startIdx > 0,
                {tryCur, tryLams} = $IV$PrefixCache[tryOrd[[1 ;; startIdx]]]]];
            Do[Module[{xa = tryOrd[[j]], rem = tryOrd[[j+1;;]], r, l},
              {r, l} = IV$IntegrateStep[tryCur, xa, 0, 1, rem, mainFit, paramFit,
                regSyms[[j]], (j == Length[tryOrd]) && doLambda, False];
              If[r === $Failed,
                tryOk = False;
                If[TrueQ[$IV$FastOrder],
                  AppendTo[$IV$FailedPrefixes, tryOrd[[1 ;; j]]]];
                Break[]];
              If[Length[l] > 0, tryLams = Join[tryLams, l]];
              tryCur = r;
              If[TrueQ[$IV$FastOrder] && j < Length[tryOrd] &&
                 LeafCount[tryCur] < 200000,
                $IV$PrefixCache[tryOrd[[1 ;; j]]] = {tryCur, tryLams}];
            ], {j, startIdx + 1, Length[tryOrd]}];
            If[tryOk,
              tryClean = IV$ResolveFrozen[tryCur];
              tryClean = Quiet[IV$RegBoundary[tryClean]] /. HPL[{1}, 1] -> 0;
              tryClean = Collect[tryClean, _G, Simplify];
              If[tryClean =!= Indeterminate && tryClean =!= Undefined &&
                 tryClean =!= ComplexInfinity && !IV$HasFrozenTermsQ[tryClean] &&
                 FreeQ[tryClean, Alternatives @@ vars],
                {tryClean, tryLams}, $Failed], $Failed]],
          orderRetryTO, $Failed];
        If[tryRes =!= $Failed,
          If[verbose, Print["[POSTRETRY] Order ", tryOrd, " succeeded!"]];
          cur = tryRes[[1]]; allLamRules = Join[allLamRules, tryRes[[2]]];
          order = tryOrd; success = True; Break[],
          If[verbose, Print["[POSTRETRY] Order ", tryOrd, " failed/timeout"]]]
      ], {p, allPerms}]]];

  (* === Auto MMA-framework fallback ===
     Triggers when standard path produced suspect result:
       (a) cur is Indeterminate / Undefined / ComplexInfinity / $Failed / has frozen Gint
       (b) cur still contains integration vars
       (c) NUMERICAL sanity: cur evaluates wrong vs MC of original integrand
           (catches silent zero, large Im for real integrand, etc.)
  *)
  If[TrueQ[$IV$MMAFallback],
    Module[{shouldFire = False, fullParamAssoc = Join[mainFit, paramFit],
            kinAssoc, symVal, mcVal, cleanCur, mcExpr},
      (* Strip integration variables from paramAssoc \[LongDash] only keep kinematic params.
         Otherwise the MC sanity check substitutes numbers for the iteration vars
         and NIntegrate fails silently. *)
      kinAssoc = KeyDrop[fullParamAssoc, vars];
      If[verbose && Length[kinAssoc] > 0,
        Print["[MMA-trigger] kinematic substitutions: ", Normal[kinAssoc]]];
      If[cur === Indeterminate || cur === Undefined ||
         cur === ComplexInfinity || cur === $Failed ||
         IV$HasFrozenTermsQ[cur] ||
         !FreeQ[cur, Alternatives @@ vars],
        shouldFire = True;
        If[verbose, Print["[MMA-trigger] structural fail: cur=", Short[cur, 3]]]];
      If[!shouldFire,
        cleanCur = If[Length[kinAssoc] > 0, cur /. Normal[kinAssoc], cur];
        cleanCur = cleanCur //. allLamRules;  (* //. : nested lam roots *)
        If[Length[kinAssoc] > 0, cleanCur = cleanCur /. Normal[kinAssoc]];
        symVal = Quiet@TimeConstrained[
          Module[{coll, gpls},
            coll = Collect[cleanCur, _G];
            gpls = If[Head[coll] === Plus, List @@ coll, {coll}];
            Sum[Module[{factors = If[Head[t] === Times, List @@ t, {t}],
                        gFactors, cFactors, coeff, gPart},
              gFactors = Select[factors, !FreeQ[#, _G] &];
              cFactors = Select[factors, FreeQ[#, _G] &];
              coeff = Times @@ cFactors;
              gPart = Times @@ gFactors;
              If[FreeQ[gPart, _G], N[t], coeff * Quiet[Ginsh[IV$GinshSafe[gPart], {}]]]],
              {t, gpls}]],
          60, $Failed];
        If[verbose, Print["[MMA-trigger] symbolic numeric value: ", symVal]];
        If[NumericQ[symVal] && Abs[Im[symVal]] > 0.01 * (Abs[Re[symVal]] + 1),
          If[verbose, Print["[!] Symbolic answer has large Im: ", symVal]];
          shouldFire = True];
        If[!shouldFire,
          mcExpr = If[Length[kinAssoc] > 0, expr /. Normal[kinAssoc], expr];
          (* adaptive-first (2026-07-10): see the getMC[] comment *)
          mcVal = Quiet@TimeConstrained[
            With[{mE = mcExpr, iters = ({#, 0, 1} & /@ vars)},
              NIntegrate[mE, Evaluate[Sequence @@ iters],
                PrecisionGoal -> 3, MaxRecursion -> 14]],
            90, $Failed];
          If[!NumericQ[mcVal],
            mcVal = Quiet@TimeConstrained[
              With[{mE = mcExpr, iters = ({#, 0, 1} & /@ vars)},
                NIntegrate[mE, Evaluate[Sequence @@ iters],
                  Method -> {"MonteCarlo", "MaxPoints" -> 200000},
                  PrecisionGoal -> 2]],
              120, $Failed]];
          If[verbose, Print["[MMA-trigger] MC reference: ", mcVal]];
          If[NumericQ[symVal] && NumericQ[mcVal] && Abs[mcVal] > 10^-6 &&
             Abs[Re[symVal] - mcVal]/Abs[mcVal] > 0.20,
            (* REFERENCE CROSS-CHECK (2026-07-11, cof5raw lesson): on endpoint-
               log-cancelling integrands (each term ~ c/(1-t), finite sum) the
               adaptive reference is unstable garbage (60.6 vs 113.9 across two
               identical runs) while the symbolic value is CORRECT.  Before
               vetoing, recompute the reference with different settings; if the
               two references disagree with EACH OTHER, the reference is the
               untrustworthy side — keep the symbolic result. *)
            Module[{mcVal2},
              mcVal2 = Quiet@TimeConstrained[
                With[{mE = mcExpr, iters = ({#, 0, 1} & /@ vars)},
                  NIntegrate[mE, Evaluate[Sequence @@ iters],
                    PrecisionGoal -> 4, MaxRecursion -> 20,
                    Method -> {"GlobalAdaptive", "SingularityHandler" -> "DoubleExponential"}]],
                90, $Failed];
              If[verbose, Print["[MMA-trigger] cross-check reference: ", mcVal2]];
              Which[
                NumericQ[mcVal2] && Abs[mcVal2 - mcVal] > 0.10 Max[Abs[mcVal], Abs[mcVal2]],
                  If[verbose, Print["[MMA-trigger] references disagree with each other (",
                    mcVal, " vs ", mcVal2, ") — reference unreliable, TRUSTING symbolic result"]],
                NumericQ[mcVal2] && Abs[Re[symVal] - mcVal2]/Max[10^-6, Abs[mcVal2]] <= 0.20,
                  If[verbose, Print["[MMA-trigger] cross-check agrees with symbolic — first reference was wrong"]],
                True,
                  If[verbose, Print["[!] Symbolic ", symVal, " vs MC ", mcVal, " mismatch"]];
                  shouldFire = True]]]]];

      If[shouldFire,
        If[verbose, Print["[!] Standard path suspect \[LongDash] engaging MMA framework fallback"]];
        Module[{mmaRes},
          mmaRes = IV$MMAIntegrate[expr, vars, kinAssoc,
            "IntegrationOrder" -> Automatic, "Verbose" -> verbose];
          (* OUTPUT GATE (2026-07-11): the MMA route can "succeed" with
             ComplexInfinity or frozen Gint/CiTi remnants (cof5raw/cof6raw);
             garbage must never replace the standard-path result. *)
          If[ListQ[mmaRes] && Length[mmaRes] === 2 && mmaRes[[1]] =!= $Failed &&
             FreeQ[mmaRes[[1]], DirectedInfinity] && mmaRes[[1]] =!= Indeterminate &&
             FreeQ[mmaRes[[1]], Indeterminate] && !IV$HasFrozenTermsQ[mmaRes[[1]]],
            If[verbose, Print["[MMA] succeeded LC=", LeafCount[mmaRes[[1]]]]];
            cur = mmaRes[[1]];
            allLamRules = Join[allLamRules, mmaRes[[2]]],
            (* F6b (2026-08-30, fail-closed): the standard-path value was flagged by BOTH numerical references
               (cross-checked) and the MMA framework could not repair it.  Returning the flagged value would be
               a silent wrong answer (this is exactly how the +1/+2 offsets of the Log[1-t] cubes reached the
               library and production callers).  Return $Failed and mark the result uncertified instead. *)
            (* F6b-v2: the numerical references themselves can be garbage on endpoint-log-cancelling integrands
               (cof6raw: symbolic 1.8074 correct, both references ~555), so a hard $Failed would veto right
               answers.  Keep the value but NEVER certify it: "Certified" -> False (not Automatic) and a
               "Suspect" tag, so certification-checking callers (the dispatcher) refuse it and the library files
               it as unverified, while callers that only need a solved expression keep working. *)
            (If[verbose, Print["[!] MC mismatch could not be repaired \[LongDash] value returned UNCERTIFIED (Suspect)"]];
             $IV$MCMismatchUnrepaired = True)]]]]];

  (* FINAL GATE (2026-07-11): a returned "Result" must never contain
     non-finite values or frozen integration artifacts; fail loudly instead
     (silent-garbage leak observed on cof5raw/cof6raw before this gate). *)
  If[cur =!= $Failed &&
     (cur === Indeterminate || !FreeQ[cur, DirectedInfinity] ||
      !FreeQ[cur, Indeterminate] || IV$HasFrozenTermsQ[cur]),
    If[verbose, Print["[!] Final result contains non-finite/frozen artifacts — returning $Failed"]];
    cur = $Failed];

  (* ---- INCOMPLETE-INTEGRAL GUARD (2026-07-13) ----
     A returned "Result" must never still depend on an INTEGRATION VARIABLE — that
     means the integral was NOT FINISHED, and the engine was reporting success.
     Caught in the wild on basiscoefficient[3][5]: after a 40-minute solve the
     engine returned an expression still containing x1, x2, x3, x5 (plus a leftover
     regulator et30), and only a stray-symbol check downstream revealed it.

     Check the FULLY SUBSTITUTED result: a lambda symbol can HIDE the dependence
     (a lambda root that depends on an already-integrated variable, then treated as
     a constant, is unsound and only visible after //. allLamRules).

     PURELY ADDITIVE: a correct result cannot depend on its own integration
     variables, so this can only ever turn silent garbage into a loud $Failed. *)
  If[TrueQ[$IV$IncompleteGuard] && cur =!= $Failed &&
     !FreeQ[Quiet[cur //. allLamRules], Alternatives @@ vars],
    Print["[!] Result still depends on integration variable(s) ",
      Select[vars, !FreeQ[Quiet[cur //. allLamRules], #] &],
      " (possibly via a lambda root) \[LongDash] INCOMPLETE; returning $Failed"];
    cur = $Failed];

  (* ---- LIBRARY (optional): append what this solve taught us.  The record is
     PROVISIONAL — the engine cannot certify itself.  It becomes authoritative
     (and thus reusable as a result) only when a caller confirms it against an
     independent anchor via IVLibConfirm.  Route/cost/failure data is filed
     either way; failures are used to REORDER candidates, never to prune. ---- *)
  (* ---- SELF-CERTIFICATION (2026-07-13) ----
     The engine cannot be trusted on its own word: it must CHECK the answer against
     an INDEPENDENT anchor before the library is allowed to reuse it.  Evaluate the
     symbolic result with ginsh at the declared point, integrate the ORIGINAL
     integrand numerically at the same point, and compare.

     Without this every record was filed `Verified -> Automatic` (provisional), and
     `IVLibQueryExact` only ever serves `Verified === True` — so the library recorded
     everything and could reuse NOTHING.  That is exactly why the 10 library tests
     fail (V3 "plain call self-certifies", V5 "re-encounter is a library lookup", ...).

     It is also a CORRECTNESS NET: basiscoefficient[3][5] came back after a 40-minute
     solve still containing x1,x2,x3,x5.  Its ginsh evaluation fails, so it can never
     certify — the library files it as unverified and will not serve it.
     Needs a declared kinematic point (nothing to anchor against otherwise).
     Off with "Certify" -> False. *)
  If[cur =!= $Failed && certOpt =!= False && Length[kinRules] > 0,
    Module[{gv, anc, its = ({#, 0, 1} & /@ vars), ex},
      gv = Quiet@TimeConstrained[
        Ginsh[IV$GinshSafe[(cur //. allLamRules) /. kinRules], {}],
        300, $Failed];
      ex = expr /. kinRules;
      anc = Quiet@TimeConstrained[
        With[{e2 = ex, it2 = its},
          NIntegrate[e2, Evaluate[Sequence @@ it2],
            Method -> {"GlobalAdaptive", "SymbolicProcessing" -> 0},
            PrecisionGoal -> 5, MaxRecursion -> 14]], 300, $Failed];
      If[NumericQ[gv] && NumericQ[anc],
        certVal = gv; certAnc = anc;
        certOK = (Abs[Re[gv] - anc] <= 5*10^-3 Max[1, Abs[anc]] &&
                  Abs[Im[gv]] <= 10^-6 Max[1, Abs[Re[gv]]]);
        If[verbose || !TrueQ[certOK],
          Print["[Certify] symbolic ", Re[gv], "  vs independent anchor ", anc,
            "  -> ", If[TrueQ[certOK], "CERTIFIED",
              "NOT certified (result returned, filed as unverified)"]]]]]];

  (* F6b-v3 (2026-08-30): the Certified semantics are NOT changed for an MC-flagged, unrepaired value -- the
     numerical references are unreliable on endpoint-log-cancelling integrands (cof6raw: correct 1.8074 vs
     references ~555) and refusing such values sent callers down slow paths (MB9 regression timeouts).  The
     condition is reported in the "Suspect" field only; "Verified"/"Certified" stay as the Certify pass decides. *)

  IV$LibCall[$IV$LibRecord,
    <|"Integrand" -> expr, "Vars" -> vars, "Order" -> order,
      "Result" -> cur, "LamRules" -> allLamRules,
      "Kinematics" -> Association[kinRules],
      "Time" -> Round[AbsoluteTime[] - tStart, 0.1],
      "StepTimes" -> $IV$StepTimes,
      "FailedPrefixes" -> $IV$FailedPrefixes,
      "Verified" -> certOK, "Point" -> kinRules,
      "Value" -> certVal, "Anchor" -> certAnc|>, Null];

  If[verbose, Print[]; Print["Result: ",cur]; Print["Numerical: ",N[cur]]];
  <|"Result" -> cur, "LamRules" -> allLamRules, "Order" -> order,
    "Certified" -> certOK, "Kinematics" -> Association[kinRules],
    "Suspect" -> If[TrueQ[$IV$MCMismatchUnrepaired], "MC-mismatch-unrepaired", None]|>
]

(* ============================================================ *)
(* SECTION 10: GENERAL BOUNDS INTEGRATION                       *)
(* ============================================================ *)

Options[IntVolIntegrateGeneral] = Options[IntVolIntegrate];

IntVolIntegrateGeneral[expr_, varSpecs_List, IVOptions:OptionsPattern[]] :=
Module[{integrand=expr, plainVars={}, allLamRules={}, subs={}, jacobian=1,
        verbose=OptionValue["Verbose"], doLambda=OptionValue["LambdaSubstitution"],
        order, mainFit, paramFit, regSyms, cur, classification},

  (* Parse variable specs and rescale to [0,1] *)
  Do[Which[
    Head[spec]===Symbol || !ListQ[spec], AppendTo[plainVars, {spec,0,1}],
    ListQ[spec]&&Length[spec]==3&&spec[[2]]===0&&spec[[3]]===1, AppendTo[plainVars, spec],
    ListQ[spec]&&Length[spec]==3&&spec[[2]]===0,
      Module[{var=spec[[1]], hi=spec[[3]], t=Unique["t"]},
        If[verbose, Print["Rescaling ",var," [0,",hi,"] -> ",t," [0,1]"]];
        integrand = integrand /. var -> hi*t; jacobian *= hi;
        AppendTo[plainVars, {t,0,1}]],
    ListQ[spec]&&Length[spec]==3,
      Module[{var=spec[[1]], lo=spec[[2]], hi=spec[[3]], t=Unique["t"]},
        If[verbose, Print["Mapping ",var," [",lo,",",hi,"] -> ",t," [0,1]"]];
        integrand = integrand /. var -> lo+(hi-lo)*t; jacobian *= (hi-lo);
        AppendTo[plainVars, {t,0,1}]],
    True, AppendTo[plainVars, spec]
  ], {spec, varSpecs}];
  integrand = Simplify[integrand * jacobian];

  (* Use degree classification for order *)
  classification = IV$ClassifyVars[integrand, plainVars];
  If[OptionValue["IntegrationOrder"]===Automatic && classification["Order"]=!={},
    If[TrueQ[classification["Multilinear"]],
      (* Multilinear denominator: use user-supplied varLimits order.
         The LAST variable in the user's order determines which quadratic
         appears after inner integrations. This is critical for correct
         lambda substitution. *)
      order = plainVars[[All,1]];
      If[verbose, Print["Multilinear D: using varLimits order (last var gets lambda): ", order]],
      order = classification["Order"];
      If[verbose, Print["Degree-classified order: ", order]]],
    order = plainVars[[All,1]]];

  (* Fit values *)
  Module[{vars = plainVars[[All,1]]},
    mainFit = Switch[OptionValue["FitValues"], Automatic, IV$DefaultFitValues[vars],
      _List, Association@@OptionValue["FitValues"], _Association, OptionValue["FitValues"],
      _, IV$DefaultFitValues[vars]];
    paramFit = Switch[OptionValue["ParametricValues"], Automatic, <||>,
      _List, Association@@OptionValue["ParametricValues"], _Association, OptionValue["ParametricValues"],
      _, <||>];
    Module[{allSyms=IV$AllSyms[integrand],unknown},
      unknown=Complement[allSyms,Keys[mainFit],Keys[paramFit],vars];
      If[Length[unknown]>0, paramFit=Join[paramFit,
        AssociationThread[unknown->Table[(k+2)/(Length[unknown]+5),{k,Length[unknown]}]]]]];

    regSyms = ConstantArray[0, Length[order]];
    $IV$LamCounter = 0;
    cur = integrand;

    (* Log factorization: split Log[A*B] -> Log[A]+Log[B], Log[A/B] -> Log[A]-Log[B].
       This decouples multi-variable Logs into simpler single-variable pieces
       that ToFibrationBasis and GIntegrate can handle directly. *)
    If[!FreeQ[cur, Log],
      Module[{before = LeafCount[cur]},
        cur = cur //. {
          Log[a_ * b_] /; (!NumericQ[a] && !NumericQ[b]) :> Log[a] + Log[b],
          Log[a_ / b_] /; !NumericQ[b] :> Log[a] - Log[b],
          Log[a_^n_Integer] /; n =!= 1 :> n * Log[a]};
        (* Factor arguments of remaining Logs to expose more products *)
        cur = cur /. Log[a_] /; !NumericQ[a] && Head[a] =!= Times && Head[a] =!= Power :>
          Module[{f = Factor[a]}, If[Head[f] === Times, Log[f], Log[a]]];
        cur = cur //. {
          Log[a_ * b_] /; (!NumericQ[a] && !NumericQ[b]) :> Log[a] + Log[b],
          Log[a_ / b_] /; !NumericQ[b] :> Log[a] - Log[b]};
        If[LeafCount[cur] =!= before && verbose,
          Print["[LogFactor] Expanded Logs: ", before, " -> ", LeafCount[cur], " leaves"]]]];

    (* FibFirst: if integrand has Logs coupling multiple vars, fibrate ALL at once.
       This is tried BEFORE MMA+Series because ToFibrationBasis handles Log arguments
       directly and produces clean G-function results, avoiding Piecewise/PolyLog issues. *)
    If[!FreeQ[cur, Log] && Length[order] > 1,
      Module[{logArgs, coupledCount, fibAllFit, fibResult},
        logArgs = Cases[integrand, Log[a_] :> a, Infinity];
        coupledCount = Count[logArgs, a_ /; Count[order, v_ /; !FreeQ[a,v]] >= 2];
        If[coupledCount > 0,
          (* Include kinematic symbols in fibration variable list \[LongDash] critical for 3-prop *)
          Module[{allSymsInExpr = IV$AllSyms[integrand], fibAllVars},
            fibAllVars = Join[order, Select[allSymsInExpr, !MemberQ[order, #] && !NumericQ[#] &]];
            If[verbose, Print["[FibFirst] ", coupledCount, " coupled Log terms \[LongDash] fibrating ALL: ", fibAllVars]];
            fibAllFit = IV$BuildFitList[integrand, fibAllVars, mainFit, paramFit];
            fibResult = Quiet[CheckAbort[TimeConstrained[
              ToFibrationBasis[integrand, fibAllVars, FitValue -> fibAllFit], 180, $Failed], $Failed]]];
          If[fibResult =!= $Failed && !IV$HasFrozenTermsQ[fibResult],
            cur = Collect[fibResult, _G, Simplify];
            If[verbose, Print["[FibFirst] Success! ", LeafCount[cur], " leaves, Logs removed: ", FreeQ[cur, Log]]];
            (* Product argument decomposition: G[0, A*B] \[RightArrow] fibrate individually *)
            Module[{gFuncs, tryVars = order, anyDecomp = False},
              Do[
                gFuncs = Cases[cur, g:G[__] /; LeafCount[g]>5 && !FreeQ[g, tv], Infinity] // DeleteDuplicates;
                Do[Module[{fib1 = Quiet[TimeConstrained[
                    ToFibrationBasis[gf, {tv}, FitValue -> fibAllFit], 30, $Failed]]},
                  If[fib1 =!= $Failed && fib1 =!= gf && !IV$HasFrozenTermsQ[fib1],
                    cur = cur /. gf -> fib1; anyDecomp = True;
                    If[verbose, Print["[ProdArg] Decomposed via ", tv, ": ", Short[gf,2]]]]
                ], {gf, gFuncs}],
              {tv, tryVars}];
              If[anyDecomp, cur = Collect[cur, _G, Simplify];
                If[verbose, Print["[ProdArg] After decomposition: ", LeafCount[cur], " leaves"]]]];
            (* Mark as pre-fibrated: first step should use direct GIntegrate *)
            cur = IV$preFibrated[cur],
            If[verbose, Print["[FibFirst] Failed, trying MMA+Series fallback"]]]
        ]]
    ];

    (* MMA+Series: try Mathematica's Integrate for first variable of Log integrands.
       Strategy: indefinite Integrate, then evaluate antid at x1=1 (boundary at 0 regularizes to 0
       for integrands with Log-type endpoint singularities).
       Falls back to definite integral if boundary evaluation fails. *)
    If[!FreeQ[integrand, Log] && Length[order] > 1,
      Module[{mmaVar = order[[1]], mmaAsm, mmaAntid, mmaAt1, mmaResult},
        mmaAsm = Join[
          (# > 0 &) /@ Select[IV$AllSyms[integrand], !MemberQ[order, #] &],
          (# > 0 &) /@ order,
          (#[[1]]>0 &) /@ Normal[paramFit]];
        If[verbose, Print["[MMA+Series] Trying Mathematica Integrate for ", mmaVar, "..."]];
        (* Try definite integral first (cleaner result, no boundary issues) *)
        mmaResult = Quiet@Check[TimeConstrained[
          Integrate[integrand, {mmaVar, 0, 1}, Assumptions -> mmaAsm], 300, $Failed], $Failed];
        If[mmaResult === $Failed || !FreeQ[mmaResult, Integrate] || !FreeQ[mmaResult, mmaVar],
          (* Fallback: indefinite + boundary at x=1 (boundary at 0 regularizes to 0) *)
          Module[{antid = Quiet@Check[TimeConstrained[
              Integrate[integrand, mmaVar, Assumptions -> mmaAsm], 120, $Failed], $Failed]},
            If[antid =!= $Failed && FreeQ[antid, Integrate],
              mmaResult = Quiet[Refine[antid /. mmaVar -> 1, mmaAsm]];
              (* PowerExpand to split Log products/ratios, then simplify *)
              If[mmaResult =!= $Failed, mmaResult = Simplify[PowerExpand[mmaResult]]]]]];
        If[mmaResult =!= $Failed && FreeQ[mmaResult, mmaVar] && FreeQ[mmaResult, Indeterminate]
            && FreeQ[mmaResult, Piecewise] && FreeQ[mmaResult, ComplexInfinity],
          mmaResult = Simplify[mmaResult];
          (* Only use MMA result if FibFirst failed OR MMA result is simpler *)
          If[Head[cur] === IV$preFibrated && LeafCount[mmaResult] > LeafCount[cur[[1]]],
            If[verbose, Print["[MMA+Series] MMA result (",LeafCount[mmaResult],"L) > FibFirst (",LeafCount[cur[[1]]],"L) \[LongDash] keeping FibFirst"]],
            If[verbose, Print["[MMA+Series] Success for ", mmaVar, "! ", LeafCount[mmaResult], " leaves"]];
            cur = mmaResult;
            order = Rest[order];
            plainVars = Select[plainVars, #[[1]] =!= mmaVar &]]]]];

    Do[Module[{xa=order[[i]], rem=order[[i+1;;]], isLast=(i==Length[order]),
               spec, lo, hi, stepResult, stepLams},
      spec = SelectFirst[plainVars, #[[1]]===xa &];
      lo = spec[[2]]; hi = spec[[3]];
      If[verbose, Print["Step ",i,"/",Length[order],":"]];
      (* Check for pre-fibrated marker from FibFirst *)
      Module[{actualExpr = If[Head[cur] === IV$preFibrated, cur[[1]], cur],
              preFib = (Head[cur] === IV$preFibrated && i == 1)},
        If[preFib,
          If[verbose, Print["  [PreFib] Direct GIntegrate (skip ToFibrationBasis)"]];
          (* ApartSquareFree on coefficients *)
          actualExpr = Quiet[Check[
            Collect[actualExpr/.{G->Global`GPL$asf}, Global`GPL$asf[__], (ApartSquareFree[#,xa]&)]/.{Global`GPL$asf->G},
            actualExpr]];
          Module[{ad = Quiet[TimeConstrained[GIntegrate[actualExpr, xa], 120, $Failed]], r},
            If[ad =!= $Failed && !IV$HasFrozenTermsQ[ad],
              r = IV$EvalDefinite[ad, xa, lo, hi, regSyms[[i]]];
              If[r =!= $Failed,
                {stepResult, stepLams} = {Collect[r, _G, Simplify], {}};
                Goto["stepDone"]]];
          (* PreFib direct failed \[LongDash] fall through to standard pipeline which has TbT+per-term fibration *)
          If[verbose, Print["  [PreFib] Direct failed, falling through to standard pipeline"]];
          Module[{fl2 = IV$BuildFitList[actualExpr, Join[{xa},rem], mainFit, paramFit]},
            (* Pre-resolve: individually fibrate each G-function w.r.t. xa *)
            Module[{allGs = Cases[actualExpr, _G, {0,Infinity}] // DeleteDuplicates, anyP=False},
              Do[If[!FreeQ[pg, xa],
                Module[{fib1 = Quiet[TimeConstrained[ToFibrationBasis[pg, {xa}, FitValue->fl2], 30, pg]]},
                  If[fib1 =!= pg && fib1 =!= $Failed,
                    actualExpr = actualExpr /. pg -> fib1; anyP = True]]
              ], {pg, allGs}];
              If[anyP, actualExpr = Collect[actualExpr, _G, Simplify];
                If[verbose, Print["  [PreRes] Pre-resolved G-functions, ", LeafCount[actualExpr], " leaves"]]]];
            (* Try direct GIntegrate again after pre-resolution *)
            Module[{ad2 = Quiet[TimeConstrained[GIntegrate[
                Quiet[Check[Collect[actualExpr/.{G->Global`GPL$a},Global`GPL$a[__],(ApartSquareFree[#,xa]&)]/.{Global`GPL$a->G}, actualExpr]],
                xa], 120, $Failed]], r2},
              If[ad2 =!= $Failed && !IV$HasFrozenTermsQ[ad2],
                r2 = IV$EvalDefinite[ad2, xa, lo, hi, regSyms[[i]]];
                If[r2 =!= $Failed,
                  {stepResult, stepLams} = {Collect[r2, _G, Simplify], {}};
                  If[verbose, Print["  [PreRes] GIntegrate succeeded after pre-resolution"]];
                  Goto["stepDone"]]]]]]];
        (* Standard path as ultimate fallback *)
        {stepResult, stepLams} = IV$IntegrateStep[actualExpr,xa,lo,hi,rem,mainFit,paramFit,
          regSyms[[i]], isLast&&doLambda, verbose]];
      Label["stepDone"];
      If[stepResult===$Failed, Print["FATAL at step ",i]; Return[$Failed,Module]];
      If[Length[stepLams]>0,
        allLamRules = Join[allLamRules, stepLams];
        Module[{lf=Select[(#[[1]]->Quiet@N[#[[2]]/.Normal[mainFit]/.Normal[paramFit]])&/@stepLams,NumericQ[#[[2]]]&]},
          paramFit=Join[paramFit,Association[lf]]]];
      cur = stepResult;
    ], {i, Length[order]}];

    (* Final cleanup: resolve frozen terms and re-regularize *)
    cur = IV$ResolveFrozen[cur];
    cur = Quiet[IV$RegBoundary[cur]] /. HPL[{1}, 1] -> 0;
    cur = Collect[cur, _G, Simplify];

    If[verbose, Print[]; Print["Result: ",cur]; Print["Numerical: ",N[cur]];
      If[Length[allLamRules]>0, Print["Lambda rules: ",allLamRules]]];
    <|"Result"->cur, "LamRules"->allLamRules, "Order"->order,
      "Classification"->classification|>
  ]]

(* SECTION 11: UTILITY FUNCTIONS                                *)
(* ============================================================ *)

(* Robust pattern finder: finds ALL occurrences via Position+Extract *)
IntVolOccur[expr_, pattern_] := Complement[Extract[expr, Position[expr, pattern]]]

(* Rationalize Log integrands: replace Log[A] with Feynman parameter integral.
   Log[A/B] = int_0^1 (A-B)/(B + t*(A-B)) dt
   Log[A] = int_0^1 (A-1)/(1 + t*(A-1)) dt  (when B=1)
   This converts a Log-coupled integrand to a purely rational (n+1)-fold integral. *)
IntVolRationalizeLog[expr_, logVar_:Automatic] := Module[
  {out = expr, logTerms, tVar, count = 0},
  (* Factor Log arguments first *)
  out = out //. {Log[a_*b_] /; (!NumericQ[a]&&!NumericQ[b]) :> Log[a]+Log[b],
    Log[a_/b_] /; !NumericQ[b] :> Log[a]-Log[b],
    Log[a_^n_Integer] /; n =!= 1 :> n*Log[a]};
  out = out /. Log[a_] /; !NumericQ[a] && Head[a] =!= Times :>
    Module[{f = Factor[a]}, If[Head[f] === Times, Log[f], Log[a]]];
  out = out //. {Log[a_*b_] /; (!NumericQ[a]&&!NumericQ[b]) :> Log[a]+Log[b],
    Log[a_/b_] /; !NumericQ[b] :> Log[a]-Log[b]};
  (* Replace each remaining non-constant Log with Feynman parameter integral *)
  logTerms = Cases[out, Log[a_] /; !NumericQ[a], Infinity] // DeleteDuplicates;
  Do[
    count++;
    tVar = If[logVar === Automatic, Symbol["tLog" <> ToString[count]], logVar];
    (* Log[A] = int_0^1 (A-1)/(1-1+t*A) dt = int_0^1 (A-1)/(1+t*(A-1)) dt *)
    (* Actually simpler: Log[A] = int_0^1 1/(1-t+t*A) dt * (A-1) ... no *)
    (* Correct: d/dt Log[1+t*(A-1)] = (A-1)/(1+t*(A-1)), so Log[A] = int_0^1 (A-1)/(1+t*(A-1)) dt *)
    Module[{arg = lt[[1]]},
      out = out /. lt -> IntVolLogInt[arg, tVar]];
  , {lt, logTerms}];
  out
]

(* Marker for rationalized Log: IntVolLogInt[A, t] = int_0^1 (A-1)/(1+t*(A-1)) dt *)
(* When used in IntVolIntegrateGeneral, each tLog variable adds a {tLog, 0, 1} integration *)
IntVolExpandLogInt[expr_] :=
  expr /. IntVolLogInt[a_, t_] :> (a - 1)/(1 + t*(a - 1))

IntVolCheckOrder[expr_, vars_List, order_List] := Module[{S0, result},
  S0 = IV$ExtractS0[expr, vars]; result = IV$TryOrder[S0, order, vars];
  If[result[[1]], Print["Linearly reducible. |S| chain: ", result[[3]]],
    Print["NOT linearly reducible."]]; result[[1]]]

IntVolFindOrder[expr_, vars_List, greedy_:False] := Module[{result},
  result = If[greedy || Length[vars] > 7, IV$GreedyOrder[expr, vars], IV$BestOrder[expr, vars]];
  If[result[[1]], Print["Order: ", result[[2]]], Print["No order found."]]; result[[2]]]

IntVolAnalyzeAndIntegrate[expr_, vars_List, IVOptions:OptionsPattern[IntVolIntegrate]] := (
  IntVolAnalysis[expr, vars]; Print[]; IntVolIntegrate[expr, vars, IVOptions])

(* ============================================================ *)
(* SECTION 12: LAMBDA-SHIFT TRICK (dev v1)                      *)
(* ============================================================ *)
(* For an integrand of the form N(x) / D(x)^k with k >= 2,
     1/D^k = (1/(k-1)!) * d^(k-1)/d\[Lambda]^(k-1) [1/(D-\[Lambda])] |_{\[Lambda]=0}
   So:
     \[Integral] N/D^k dV = (1/(k-1)!) * d^(k-1)/d\[Lambda]^(k-1) [\[Integral] N/(D-\[Lambda]) dV] |_{\[Lambda]=0}
   The shifted integral has only a SIMPLE pole, so partial-fraction lambda
   substitution never has to compute multi-pole residues \[LongDash] bypasses the
   silent-collapse-to-zero failure mode (Mode 2 in SUMMARY.md).
   After the inner integration, we substitute the IVlam* rules so they
   become explicit Sqrt[...]+\[Lambda] expressions, then differentiate via DG
   (PolyLogTools' GPL derivative), set \[Lambda]\[RightArrow]0, divide by (k-1)!. *)

Options[IntVolLambdaShift] = Options[IntVolIntegrate];

IntVolLambdaShift[integrand_, vars_List, IVOptions:OptionsPattern[]] :=
Module[{denom, factors, highPowFacs, fac, k, lambdaS, shifted, intResult,
        resWithLam, finalResult, verbose = OptionValue[IntVolIntegrate, {IVOptions}, "Verbose"]},

  denom = Together[integrand] // Denominator;
  factors = IV$FactorListExact[denom];
  highPowFacs = Select[factors,
    #[[2]] >= 2 && !FreeQ[#[[1]], Alternatives @@ vars] &];

  If[Length[highPowFacs] == 0,
    Print["[LambdaShift] No high-power denominator factor; using IntVolIntegrate directly"];
    Return[IntVolIntegrate[integrand, vars, IVOptions]]];

  If[Length[highPowFacs] > 1,
    Print["[LambdaShift] WARNING: ", Length[highPowFacs],
          " high-power factors found; processing the first only"]];

  fac = highPowFacs[[1, 1]];
  k = highPowFacs[[1, 2]];
  lambdaS = Unique["lambdaSh"];

  Print["[LambdaShift] Power-", k, " factor: ", Short[fac, 4]];
  Print["[LambdaShift] Lambda symbol: ", lambdaS];

  (* Replace fac^k \[RightArrow] (fac - \[Lambda])^1 by multiplying integrand by fac^k/(fac-\[Lambda]).
     Original: N/(fac^k * rest); Shifted: N/((fac-\[Lambda]) * rest) *)
  shifted = integrand * fac^k / (fac - lambdaS);
  shifted = Together[shifted];
  Print["[LambdaShift] Shifted integrand LeafCount: ", LeafCount[shifted]];

  intResult = IntVolIntegrate[shifted, vars, IVOptions];

  If[!AssociationQ[intResult] || intResult["Result"] === $Failed,
    Print["[LambdaShift] Inner integration failed"];
    Return[$Failed]];

  Print["[LambdaShift] Inner result LeafCount: ", LeafCount[intResult["Result"]]];

  (* Substitute IVlam* rules so symbols become explicit Sqrt expressions in lambdaS *)
  resWithLam = intResult["Result"] /. intResult["LamRules"];
  Print["[LambdaShift] After LamRules sub LeafCount: ", LeafCount[resWithLam]];

  (* Differentiate (k-1) times wrt lambdaS using DG (handles G-functions correctly) *)
  finalResult = resWithLam;
  Do[
    finalResult = DG[finalResult, lambdaS];
    If[verbose, Print["[LambdaShift] After deriv ", j, " LeafCount: ", LeafCount[finalResult]]],
    {j, 1, k-1}];

  (* Set lambdaS -> 0 and divide by (k-1)! *)
  finalResult = (finalResult /. lambdaS -> 0) / (k-1)!;

  Print["[LambdaShift] Final LeafCount: ", LeafCount[finalResult]];

  <|"Result" -> finalResult,
    "LamRules" -> {},
    "Order" -> intResult["Order"],
    "LambdaShiftSym" -> lambdaS,
    "ShiftedFactor" -> fac,
    "ShiftedPower" -> k|>
]

(* GINSH CONCURRENCY ISOLATION (2026-07-11, from load_standard.m 2026-07-02):
   PLT's ginsh interface writes FIXED-name temp files into the single shared
   GiNaC$InterfacePath; concurrent kernels corrupt each other (sntxi crashes,
   frozen CiTi, bogus fibration fits).  Every kernel that loads IntVol gets
   its own per-process directory, making process-parallel solving safe. *)
If[MemberQ[$Packages, "PolyLogTools`"],
  PolyLogTools`GiNaC$InterfacePath =
    FileNameJoin[{$TemporaryDirectory, "plt_ginsh_" <> ToString[$ProcessID]}] <> "/";
  Quiet@Check[CreateDirectory[PolyLogTools`GiNaC$InterfacePath,
    CreateIntermediateDirectories -> True], Null]];

(* Startup banner. Suppressed if $IV$QuietLoad is set True before Get[]. *)
If[!TrueQ[$IV$QuietLoad],
  Print["IntVol loaded."];
  Print["  IntVolIntegrate[expr, vars, opts]         \[LongDash] Integration over [0,1]^n"];
  Print["  IntVolIntegrateGeneral[expr, varSpecs]    \[LongDash] General bounds {{v,0,a}, x, ...}"];
  Print["  IntVolAnalysis[expr, vars]                \[LongDash] Reducibility analysis"];
  Print["  IntVolFindOrder[expr, vars]               \[LongDash] Find optimal order"];
  Print["  IntVolCheckOrder[expr, vars, ord]         \[LongDash] Verify order"];
  Print["  IV$GraphPolynomial[edges]                 \[LongDash] First Symanzik polynomial"];
  Print["  IV$SecondPolynomial[edges,ext]            \[LongDash] Second Symanzik polynomial"];
  Print["  IV$CGReduceMulti[S0, vars]                \[LongDash] Compatibility graph reduction"];
  Print["  IntVolLambdaShift[expr, vars]             \[LongDash] DEV: \[Lambda]-shift trick for D^k denominators"]];

(* NOTE (2026-07-11): a GLOBAL $IterationLimit = Infinity was tried here for
   the 3-prop W2 workbench (notebook In[33]) and REVERTED — it slows certified
   solves ~5x (245s vs 43s on ep0 cof6, same value) and the timing distortion
   let a wrong route win once. Infinity is now scoped via Block[] to the
   IV$FibW2Moebius GIntegrate calls only; workbench scripts may set it
   globally themselves. *)

(* ================================================================
   KNOWLEDGE LIBRARY: ALIVE BY DEFAULT  (2026-07-12, user request)

   The engine stays fully STANDALONE — if IntVolLibrary.m is not there, this
   block does nothing and every hook remains a no-op.  But when the file IS
   present (the normal deployment) the library is loaded and attached, so every
   solve deposits what it learned and every re-encounter is a lookup.

     $IV$NoLibrary = True   (before loading)  -> suppress
     env IVLIB_OFF=1                          -> suppress (used by the tests)
     env IVLIB_FILE=<path>                    -> use that data file
   ================================================================ *)
If[!TrueQ[$IV$NoLibrary] &&
   !MemberQ[{"1", "true", "yes"},
     ToLowerCase[ToString[Environment["IVLIB_OFF"]]]],
  Module[{code, data},
    code = FileNameJoin[{DirectoryName[$InputFileName], "developed_packages",
      "IntVolLibrary.m"}];
    If[!FileExistsQ[code],
      code = FileNameJoin[{DirectoryName[$InputFileName], "IntVolLibrary.m"}]];
    If[FileExistsQ[code],
      If[TrueQ[$IV$QuietLoad], Global`$IVLibQuietLoad = True;
        Global`$IVLibVerbose = False];
      Quiet@Get[code];
      If[DownValues[Global`IVLibAttach] =!= {},
        data = Module[{e = Environment["IVLIB_FILE"]},
          If[StringQ[e] && e =!= "", e,
            FileNameJoin[{DirectoryName[code], "intvol_library.m"}]]];
        Quiet@Global`IVLibAttach[data];
        If[!TrueQ[$IV$QuietLoad],
          Print["  knowledge library ACTIVE: ",
            Length[Global`$IVLib["Records"]], " records \[LongDash] ",
            FileNameTake[data]]]]]]];
