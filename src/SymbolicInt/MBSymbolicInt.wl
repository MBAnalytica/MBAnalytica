(* ::Package:: *)

(* ::Title:: *)
(*MBSymbolicInt*)


(* ::Subtitle:: *)
(*a Mathematica package for evaluating Mellin\[Dash]Barnes integrals in terms of multiple polylogarithms*)


(* ::Text:: *)
(*Authors: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias.*)
(*Release R2 (2026-09-07) of the Standard route: MBresolve -> MBexpand -> global Barnes reduction -> exact closure of every epsilon-free piece by this core and its class-handler rungs (mbe*.m).*)
(*Euler-integral backend: IntVol (author Syed Mehedi Hasan); certified-order hyperlogarithm strategy: IntVolFLINT (author Syed Mehedi Hasan), whose backends HyperFLINT and HyperIntica are by M. Giroux, S. Mizera and G. Salvatori (SubTropica), HyperIntica reimplementing E. Panzer's HyperInt.*)


(* ::Section:: *)
(*Package initiation*)


(* ==================================================================
   ROUTE MAP (added 2026-07-20 — user directive: NEVER MIX THE ROUTES)

   This one package implements TWO distinct evaluation routes, selected
   by MBresolveToMPL[..., "Route" -> "Standard" | "Subtraction"].

   STANDARD route (expand-FIRST; the route under active development):
     MBresolve -> MBexpand -> eps-FREE coefficient integrands
       -> DoAllBarnes -> per-piece faithful cube via mbtCachedMBSymbolicInt
          [psi-class Block-0, degtrig rung (package tail), phase-tower
           delegation mbtHasInputZPhaseExt -> mbeOneFoldFamilyLaurent]
       -> Euler2MPL / IntVol -> per-order gate vs benchmark.
     Coefficients carry NO eps: their cubes need NO boundary/corner
     subtraction. Verification = per-order finite-vs-finite gates ONLY.

   SUBTRACTION route (eps-SYMBOLIC; separate program):
     eps kept symbolic through MBtoEulerMellin; Laurent series extracted
     FROM the cube; needs the BPHZ machinery below. Functions that belong
     EXCLUSIVELY here (never call them on expand-first coefficients):
       mbeResolveAllBoundaries, mbeApplyBoundarySubtraction,
       mbeDetectBoundarySingularity/-All-, mbeApplyCompoundCornerSubtractions,
       mbeHeppSectorDecompose, mbeFindCornerSingularities,
       mbeProcessEpsCoefficients (+ the $mbePoleAudit),
       mbeAuditUnsubtracted, mbeGateCleanQ, mbtBPHZRegular.
     Direct-call convention traps (learned 2026-07-19): plain-Symbol cube
     variables only (::nonsym guard); (1-v)-canonical bases; split corner
     factors (-X)^(a+b eps) * X^(2n) must be base-unified first.

   Shared infrastructure (both routes): MBresolve/MBexpand bridge,
   DoAllBarnes + MBEDeltaReduce (Block-7 delta-consistency fix 2026-07-19),
   MBtoEulerMellin, Euler2MPL/IntVol backend, PieceKernels parallelism.
   ================================================================== *)

(* ==================================================================
   0.  PREREQUISITE CHECK  (soft)
   ================================================================== *)

If[!MemberQ[$Packages, "PolyLogTools`"],
  Print["[MBSymbolicInt] WARNING: PolyLogTools` is not loaded."];
  Print["  MBtoEuler (MB->Euler stage) works without PolyLogTools."];
  Print["  Euler2MPL / MBSymbolicInt  will report \"beyond current scope\""];
  Print["  until you  Get[\"path/to/PolyLogTools.m\"]."];
];



(* ==================================================================
   Load the IntVol integration engine (Euler -> MPL backend).
   IntVol_stable.m + IntVol_BigExpr_Helpers.m must live in the same
   directory as this file. They define IntVolIntegrate, IntVolFindOrder,
   IntVolAnalysis at the top level; we delegate the entire Euler->MPL
   stage to IntVolIntegrate (replacing the previous in-house AEI engine).
   ================================================================== *)

If[MemberQ[$Packages, "PolyLogTools`"] && DownValues[Global`IntVolIntegrate] === {},
  Module[{thisDir = DirectoryName[$InputFileName]},
    Block[{$IV$QuietLoad = True},
      Get[FileNameJoin[{thisDir, "IntVol_stable.m"}]]]];
];

(* Disable IntVol's MMA-framework last-resort fallback by default.
   The MMA framework retries integration via a Mathematica-Integrate
   canonical recipe; it's slow (per-step Integrate calls can run for
   minutes) and primarily aimed at BC[19]-style hard cases (silent
   zeros, frozen CiTi terms from the standard PLT path). For the
   polygamma cases in MB14, the primary IntVolIntegrate path already
   produces correct closed forms; the MMA retry is pure overhead and
   can hang on multi-piece batched Euler2MPL calls.

   Users who need the MMA framework (e.g. BC[19], elliptic-adjacent
   cases) can re-enable by setting Global`$IV$MMAFallback = True
   AFTER loading this package. *)
If[DownValues[Global`IntVolIntegrate] =!= {},
  Global`$IV$MMAFallback = False;
];

(* MB_standard release: no knowledge layer of any kind is shipped or loaded.  The optional lookup hooks
   that remain in the body below are guarded by DownValues checks on packages that do not exist in this
   release, so every lookup is a miss and every piece is derived analytically. *)


(* ==================================================================
   1.  PACKAGE HEADER
   ================================================================== *)

(* Silence the t/u/\[Iota] shadow warnings: PolyLogTools also exports
   t, u (and we use a local \[Iota]). Our copies live in MBAnalytica`SymbolicInt` and
   are distinct atoms from PolyLogTools`t, PolyLogTools`u. *)
Off[General::shdw]

BeginPackage["MBAnalytica`SymbolicInt`"]


LastUpdate="28 August 2026  (v2.0 -- sealed exact Standard route with certified-library and structural strategy dispatch)";


(* ::Section:: *)
(*Author credits*)


Print[Style["MBSymbolicInt 1.0",Blue,14,FontFamily->"Courier",Bold],Style[" - a Mathematica package for evaluating Mellin\[Dash]Barnes integrals in terms of Multiple Polylogarithms.",Blue,14,FontFamily->"Courier"]];
Print[Style["Authors: ",Black,Bold],Style["  Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias",Brown,Bold,12.5]];
Print[Style["Last updated: ",Black,Bold], LastUpdate];


(* ::Section::Closed:: *)
(*Usage Messages*)


(* ::Subsection::Closed:: *)
(*Global Variables*)


(* ====================================================================
   NAMESPACE-SAFE EULER VARIABLES
   Declaring t, u, \[Iota] here (inside BeginPackage) places them in
   the MBAnalytica`SymbolicInt` context, not Global`.  This prevents collisions with
   PolyLogTools`t, PolyLogTools`u (which PLT uses internally).
   ==================================================================== *)
   
VerboseMode::usage =
"t[i]  (MBAnalytica`SymbolicInt`t)
The i-th Beta-function Euler integration variable (Block 5). Integrated on [0,1].";
   
n::usage =
"t[i]  (MBAnalytica`SymbolicInt`t)
The i-th Beta-function Euler integration variable (Block 5). Integrated on [0,1].";

t::usage =
"t[i]  (MBAnalytica`SymbolicInt`t)
The i-th Beta-function Euler integration variable (Block 5). Integrated on [0,1].";

u::usage =
"u[i]  (MBAnalytica`SymbolicInt`u)
The i-th auxiliary Euler integration variable (Block 5, Auxiliary mode).";

\[Iota]::usage =
"\[Iota][k]  (MBAnalytica`SymbolicInt`\[Iota])
Auxiliary differentiation parameter used to represent PolyGamma as a
Gamma-ratio (Block 0). Removed by MBEApplyPolygammaLimit.";

s::usage =
"s[k]  (MBAnalytica`SymbolicInt`s)
Polygamma integral-representation variable for m>=1.  PolyGamma[m, arg]
is replaced by -s[k]^(arg-1)*Log[s[k]]^m/(1-s[k]) in Block 0 and s[k]
becomes an additional cube variable in [0,1].";


(* ::Subsection::Closed:: *)
(*External Modules*)


(* ====================================================================
   PUBLIC USAGE STRINGS
   ==================================================================== *)
(*MBCH2MPL::usage =
"MBtoEuler[integrand, contourRules, mbVars]
Converts a Mellin-Barnes integrand (possibly with PolyGamma) to one or
more Euler parametric integrands over [0,1]^n (Blocks 0-8 pipeline).
Returns an Association with keys:
  \"EulerIntegrands\"  -- list of {cubeIntegrand, cubeVariables} pairs
  \"HasPolygamma\"     -- True/False
  \"PartA\"            -- stream data for the main (possibly shifted) integrand
  \"PartB\"            -- list of stream data for rational corrections
Options:
  \"Assumptions\" -> True      kinematic assumptions, e.g.
                               {k \[Element] Reals, k > 1/2}
  \"CleanOutput\" -> False     print a human-readable summary
  \"Verbose\"    -> False      attach full pipeline data
  \"ShowSteps\"  -> False      print progress at each stage
  \"MaxShift\"   -> 50         max Pochhammer shift (Block 1)";*)

MBtoEuler::usage =
"MBtoEuler[integrand, contourRules, mbVars]
Converts a Mellin-Barnes integrand (possibly with PolyGamma) to one or
more Euler parametric integrands over [0,1]^n (Blocks 0-8 pipeline).
Returns an Association with keys:
  \"EulerIntegrands\"  -- list of {cubeIntegrand, cubeVariables} pairs
  \"HasPolygamma\"     -- True/False
  \"PartA\"            -- stream data for the main (possibly shifted) integrand
  \"PartB\"            -- list of stream data for rational corrections
Options:
  \"Assumptions\" -> True      kinematic assumptions, e.g.
                               {k \[Element] Reals, k > 1/2}
  \"CleanOutput\" -> False     print a human-readable summary
  \"Verbose\"    -> False      attach full pipeline data
  \"ShowSteps\"  -> False      print progress at each stage
  \"MaxShift\"   -> 50         max Pochhammer shift (Block 1)";

MBtoEulerMellin::usage =
"MBtoEulerMellin[integrand, contourRules, mbVars]
Like MBtoEuler, but designed for the *unresolved* MB integrand --
the one *before* MBresolve / MBexpand / DoAllBarnes. The dimensional
regulator \[Epsilon] (or whichever symbol you pass) is kept symbolic
throughout the Blocks 1-8 pipeline; the resulting Euler-Mellin
integrand carries \[Epsilon] in its exponents (t^(a(\[Epsilon])-1),
(1-t)^(b(\[Epsilon])-1), c^(z(\[Epsilon])), \[CapitalGamma](...) prefactors).

The contour decisions (Block 1 Pochhammer shifts, Block 7 delta
pivots) need a sign for every Re(\[CapitalGamma]-arg). Since \[Epsilon] is
symbolic, this routine adds an assumption that \[Epsilon] is small of
the sign you specify (positive by default), so FullSimplify can
evaluate the Re-comparisons.

Returns the same Association shape as MBtoEuler: \"EulerIntegrands\",
\"HasPolygamma\", \"PartA\", \"PartB\", etc.

Options (in addition to those of MBtoEuler):
  \"EpsilonSymbol\"   -> Global`\[Epsilon]   regulator symbol kept symbolic
  \"EpsilonPositive\" -> True              True: 0<\[Epsilon]<bound; False: -bound<\[Epsilon]<0
  \"EpsilonBound\"    -> 1/100             upper-magnitude bound used in
                                            the contour-decision assumption

Use this when you want a closed-form ε-symbolic Euler-Mellin
representation (e.g. to inspect the integrand structure, differentiate
under the integral, or substitute particular ε values later). For
ε-expansion + final MPL evaluation, run MBresolve+MBexpand+DoAllBarnes
first and then use MBtoEuler / MBSymbolicInt on each residue piece.";

Euler2MPL::usage =
"Euler2MPL[eulerResult]
Takes the Association returned by MBtoEuler and evaluates each Euler
integrand into MPLs / GPLs / MZVs using PolyLogTools (linear-reducibility
analysis + iterated fibration basis integration).
Returns an Association with keys:
  \"MPLResult\"     -- total symbolic MPL/GPL expression
  \"Pieces\"        -- list of per-integrand results
  \"AllSucceeded\"  -- True if every piece evaluated successfully
  \"ScopeMessages\" -- list of any \"beyond current scope\" messages
Options:
  \"ParametricValues\"  -> Automatic  values for non-integration symbols
  \"IntegrationOrder\"  -> Automatic  order hint (passed to AEI engine)
  \"FitValues\"         -> Automatic  custom numerical test points
  \"GreedySearch\"      -> False     use greedy n!-skipping order search
  \"SimplifySteps\"     -> False     Simplify after each integration step
  \"TrackRegulator\"    -> False     keep HPL[{1},1] symbolic
  \"Verbose\"           -> False     print progress";

MBSymbolicInt::usage =
"MBSymbolicInt[integrand, contourRules, mbVars]
Single command: runs MBtoEuler followed by Euler2MPL and returns the
final MPL / GPL / MZV expression when successful.
If any piece cannot be converted to MPLs, prints
  \"Converting to MPL is beyond current scope: <reason>\"
and returns the Euler representation so the user can inspect it.
All options of MBtoEuler and Euler2MPL are accepted.";

MBresolveToMPL::usage =
"MBresolveToMPL[mbIntegrand, \[Epsilon]]
Run the full MBresolve-driven pipeline:
   MBresolve[mbIntegrand, \[Epsilon]] -> for each residue,
   MBtoEulerMellin (\[Epsilon] symbolic) -> n-th order boundary subtraction
   on every u^(-n+\[Beta]\[Epsilon]) and (1-u)^(-n+\[Beta]\[Epsilon]) factor ->
   Series in \[Epsilon] -> Euler2MPL on each \[Epsilon]-coefficient (analytic).
Returns the \[Epsilon]-Laurent series.
Options:  \"EpsOrderMin\" (default -3),  \"EpsOrderMax\" (default 0),
         \"Verbose\" (default True), \"Route\" (default \"Standard\";
         use \"Subtraction\" for the Euler boundary-subtraction route),
         \"UseCertifiedLibrary\" (default True; set False to audit a fresh
         derivation without certified learned-piece/resolution reuse).
Requires MB.m and MBresolve.m to be loaded.";

MBStandardLibraryStatus::usage =
"MBStandardLibraryStatus[] returns certified standard-route library counts and
the learned-piece/resonant-resolution telemetry from the latest
MBresolveToMPL call.";

MBPhaseBlockLibraryStatus::usage =
"MBPhaseBlockLibraryStatus[] reports certified source-level variable-phase records and lookup telemetry.";

MBresolveToMPL::ofcfail =
"One-fold tower-closure route could not handle residue `1`; falling back to \
the cube-based machinery (LOUD notice, not an error).";

MBresolveToMPL::rpfail =
"Auto-routing predicate ANALYSIS FAILED (not a genuine corner detection); \
falling back to Standard as the safe default.  Inspect the residue by hand.";

MBresolveToMPL::inexact =
"The \[Epsilon]^`1` coefficient contains a floating-point number: some piece was served NUMERICALLY (a numeric library seal or a numeric fallback), so this coefficient is NOT an exact GPL expression.";
MBresolveToMPL::incomplete =
"`1` piece(s) could not be closed and were set to 0; the returned \[Epsilon]-series \
is INCOMPLETE and not trustworthy. See MBAnalytica`SymbolicInt`Private`$mbtFailedPieces.";

MBresolveToMPL::unsubtracted =
"`1` residue-cube(s) still carry a GENUINE un-subtracted boundary/corner pole that \
the subtraction engine could not resolve; those slots hold mbeUnsubtractedPole[...] \
markers (NOT silently dropped).  The bulk/corner integrator for that pole is a \
separate development; the returned \[Epsilon]-series is INCOMPLETE at the flagged \
orders.  See MBAnalytica`SymbolicInt`Private`$mbtFailedPieces (reason -> \"un-subtracted-pole\").";

MBresolveToMPL::nnccorner =
"`1` NON-normal-crossing (NNC) compound corner(s) were handled by the 1-variable \
linear-moment projector, which ignores the transverse directions of a curved \
singular locus and can give a WRONG-but-finite result.  If this integral was forced \
onto the subtraction route, cross-check against Route -> \"Standard\", or set \
MBAnalytica`SymbolicInt`Private`$mbeFlagNNCCorners = True to defer such corners to the Hepp/blow-up \
path (or flag them) instead.  See MBAnalytica`SymbolicInt`Private`$mbeNNCLinearMomentBases.";

MBresolveToMPL::resolvefail =
"MBresolve did not return a non-empty residue list, so the standard route was \
stopped before expansion. No partial result was assembled.";

MBresolveToMPL::resonant =
"The input has `1` exact zero-sum numerator-Gamma cycle(s), MBresolve failed, \
and no certified regulated-resolution record matched. A multi-regulator \
analytic continuation must be learned and certified before this integral can \
enter the standard route.";

MBEPreprocessPolygamma::usage =
"MBEPreprocessPolygamma[integrand, mbVars, contourRules]  (Block 0)
Replaces each PolyGamma[m, f(z)] with a Gamma-function ratio using
auxiliary parameters MBAnalytica`SymbolicInt`\[Iota][k], after shifting f(z) so that
Re(f(z)) > 0 on the contour.
Returns <|\"ModifiedIntegrand\", \"AuxParameters\", \"AuxAssumptions\",
          \"DerivativeOperations\", \"HasPolygamma\",
          \"RationalCorrections\", \"ShiftInfo\", \"PolygammaInfo\"|>.";

MBEApplyPolygammaLimit::usage =
"MBEApplyPolygammaLimit[cubeIntegrand, pgPreprocessResult]
Extracts the polygamma contribution from the cube integrand via
Series[..., {\[Iota][k], 0, m}] and the Laurent coefficient of
Gamma[\[Iota]] ~ 1/\[Iota] - EulerGamma + ...";

MBENormalizeContour::usage =
"MBENormalizeContour[expr, contourRules, ass, maxShift]  (Block 1)
Shifts every Gamma[a] to make Re(a) > 0 on the contour using
Gamma[a] = Gamma[a+n] / Pochhammer[a, n].";

MBEGammaPositivityReport::usage =
"MBEGammaPositivityReport[expr, contourRules, ass]
Per-factor report: Arg / Side / ReOnContour / PositiveQ.";

MBEAllGammaPositiveQ::usage =
"MBEAllGammaPositiveQ[expr, contourRules, ass]
True iff all top-level Gamma arguments have Re > 0 on the contour.";

MBENormalizeSlope::usage =
"MBENormalizeSlope[expr, mbVars]  (Block 2)
Applies Gauss multiplication to eliminate integer |slope|>=2 in Gamma args.";

MBECheckBalance::usage =
"MBECheckBalance[expr, mbVars, ass]  (Block 3)
Verifies unit-slope and balance for each MB variable.
Returns <|\"ReadyForBetaPairingQ\", ..., \"PerVariable\"|>.";

MBEGammaToBeta::usage =
"MBEGammaToBeta[expr, mbVars, ass]  (Block 4)
Converts Gamma products to Beta[a,b] via three pairing rules A/B/C
plus denominator-cancellation and cross-variable prepasses.";

MBEBetaToEuler::usage =
"MBEBetaToEuler[betaReport, mbVars, contourRules, ass]  (Block 5)
Converts Beta functions to Euler integrals, introducing t[i] (Beta
variables) and u[i] (auxiliary, for 1/L(z)^m factors).
Auto-selects \"Restricted\" or \"Auxiliary\" mode.";

MBEOrientEuler::usage =
"MBEOrientEuler[eulerReport, ass]  (Block 6)
Swaps v -> 1-v for variables appearing only as (1-v) in the X-list.";

MBESuggestDeltaPivots::usage =
"MBESuggestDeltaPivots[orientedReport, ass]  (Block 7 heuristic)
Recommends pivot variables for sequential delta reduction.";

MBEDeltaReduce::usage =
"MBEDeltaReduce[orientedReport, pivots, ass]  (Block 7)
Solves X_j = 1 sequentially for each pivot, accumulating Jacobians.";

MBESupportConditions::usage =
"MBESupportConditions[deltaReport, ass]
Returns 0 < solved_pivot < 1 as a boolean over remaining variables.";

MBEAbsorbSupport::usage =
"MBEAbsorbSupport[deltaReport, ass]  (Block 8)
Inverts the solved rules to absorb support into a clean [0,1]^n cube.";

MBESuggestSupportPivots::usage =
"MBESuggestSupportPivots[deltaReport, ass]
Heuristic choice of pivots for support absorption.";

MBEFormatResult::usage =
"MBEFormatResult[eulerResult]
Prints a readable summary of the MBtoEuler output.";

MBERunStream::usage =
"MBERunStream[integrand, mbVars, contourRules, ass, opts]
Runs the full Blocks 1-8 pipeline on a single pure-Gamma integrand.
Options: \"Verbose\", \"ShowSteps\", \"MaxShift\".";

AEI$Analysis::usage =
"AEI$Analysis[expr, vars]
Prints the linear-reducibility chain for an Euler integrand:
initial S_0, best ordering, |S| at each stage, GPL letters -R/Q.";

AEI$BestOrder::usage =
"AEI$BestOrder[expr, vars]
Returns {found, ordering, S0} where  ordering  is the best
linearly-reducible integration order found by exhaustive n! search
(rational-only variables preferred first).";


(* ::Subsection::Closed:: *)
(*External Module Options*)


(* ====================================================================
   OPTIONS
   ==================================================================== *)

Options[MBtoEuler] = {
  "Assumptions" -> True,
  "CleanOutput" -> False,
  "Verbose"     -> False,
  "ShowSteps"   -> False,
  "MaxShift"    -> 50
};

Options[MBtoEulerMellin] = Join[
  Options[MBtoEuler],
  {"EpsilonSymbol"   -> Global`\[Epsilon],
   "EpsilonPositive" -> True,
   "EpsilonBound"    -> 1/100}];

Options[Euler2MPL] = {
  "ParametricValues" -> Automatic,
  "IntegrationOrder" -> Automatic,
  "FitValues"        -> Automatic,
  "GreedySearch"     -> False,
  "SimplifySteps"    -> False,
  "TrackRegulator"   -> False,
  "Verbose"          -> False
};

Options[MBSymbolicInt] = Join[Options[MBtoEuler], Options[Euler2MPL]];

Options[MBERunStream] = {
  "Verbose"   -> False,
  "ShowSteps" -> False,
  "MaxShift"  -> 50
};


(* ::Section::Closed:: *)
(*Private Context*)


(* ====================================================================
   BEGIN PRIVATE  -- MB->Euler (Blocks 0-8) internals
   ==================================================================== *)

Begin["`Private`"]

(* ------------------------------------------------------------------
   BLOCK 0: Polygamma preprocessing
   ------------------------------------------------------------------ *)

$mbeAuxCounter = 0;
mbeNextAux[] := ($mbeAuxCounter++; MBAnalytica`SymbolicInt`\[Iota][$mbeAuxCounter]);

$mbePolygammaIntegralCounter = 0;
mbeNextPolygammaIntegralVar[] :=
  ($mbePolygammaIntegralCounter++; MBAnalytica`SymbolicInt`s[$mbePolygammaIntegralCounter]);

(* ------------------------------------------------------------------
   Round 14 (2026-06-08): HarmonicSums S-route closure for residue sums.
   When Mma's `Sum[symbResN, {n,1,Infinity}]` stalls/timeouts on weight-5+
   Euler sums (the ψ^3 MB14 piece13 bottleneck), call mbeCloseResidueSumSShifted
   as analytic-closure fallback. Pipeline:
     HN -> S[1,n] / S[p,n];  LinearExpand to quasi-shuffle products;
     Euler-sum rule  S[a..,n]/n^p -> S[p,a..,Inf];
     ReduceConstants -> MZV/Zeta closure.
   ------------------------------------------------------------------ *)
$mbeHSLoaded = False;
$mbeHSRoot = None;

(* Resolve HarmonicSums from the package tree first.  This makes the release
   folder self-contained while retaining a development-tree and ordinary
   $Path fallback.  Never depend on the former author's home directory. *)
mbeHSCandidateFiles[] := Module[{pkgDir, pltRoot, found},
  pkgDir = Quiet@Check[
    If[StringQ[$mbtPackageFile] && $mbtPackageFile =!= "",
      DirectoryName[ExpandFileName[$mbtPackageFile]], Directory[]],
    Directory[]];
  pltRoot = Quiet@Check[
    If[StringQ[$mbtPolyLogToolsFile] && $mbtPolyLogToolsFile =!= "",
      DirectoryName[ExpandFileName[$mbtPolyLogToolsFile], 3], ""], ""];
  found = Quiet@Check[FindFile["HarmonicSums`"], $Failed];
  DeleteDuplicates@Select[{
    FileNameJoin[{pkgDir, "vendor", "HarmonicSums", "HarmonicSums.m"}],
    FileNameJoin[{pkgDir, "HarmonicSums", "HarmonicSums.m"}],
    FileNameJoin[{$UserBaseDirectory, "Applications", "HarmonicSums",
      "HarmonicSums.m"}],
    If[pltRoot === "", $Failed,
      FileNameJoin[{pltRoot, "risc", "HarmonicSums", "HarmonicSums.m"}]],
    found}, StringQ]];

mbeLoadHarmonicSums[] := If[!TrueQ[$mbeHSLoaded],
  Module[{candidates, packageFile, loadResult, ok},
    candidates = mbeHSCandidateFiles[];
    packageFile = SelectFirst[candidates, FileExistsQ,
      Missing["NotFound"]];
    (* Loading may emit harmless shadowing/protected-symbol messages.  Only an
       abort or the absence of the required public definitions is fatal. *)
    loadResult = If[
      MemberQ[$Packages, "HarmonicSums`"] &&
       NameQ["HarmonicSums`ReduceConstants"],
      Null,
      CheckAbort[Quiet@If[MissingQ[packageFile],
        Needs["HarmonicSums`"], Get[packageFile]], $Aborted]];
    ok = loadResult =!= $Aborted &&
      MemberQ[$Packages, "HarmonicSums`"] &&
      NameQ["HarmonicSums`ReduceConstants"];
    If[ok,
      $mbeHSLoaded = True;
      If[StringQ[packageFile] && FileExistsQ[packageFile],
        $mbeHSRoot = DirectoryName[packageFile]],
      $mbeHSLoaded = $Failed];
    $mbeHSLoaded]];

(* ============================================================
   Round 20 (2026-06-09): PARALLEL DoAllBarnes infrastructure.
   DoAllBarnes is the dominant bottleneck for MB14 corner-sing
   residues (193s of 223s for Res#4). We launch subkernels and
   load BarnesRoutines on each, then ParallelMap the inner
   DoBarnes1/DoBarnes2/ExpandInt operations.
   ============================================================ *)
$mbtParallelReady = False;
$mbtUseParallel = False;         (* feature flag — disabled (correctness bug on complex inputs) *)
$mbtNumKernels  = 8;             (* requested kernel count *)
(* In-package per-piece parallelism for the GLOBAL std route (2026-06-19).
   0/False = serial (default, unchanged); Automatic = Min[16,$ProcessorCount-2]
   subkernels; a positive integer = that many.  Set via the MBresolveToMPL option
   "PieceKernels". Each subkernel loads the package by absolute path and bootstraps
   the per-piece closer; results are order-preserved and the no-silent-drop ledger
   is aggregated back to the master. *)
$mbtPieceKernels = 0;
$mbtPieceKernelsReady = False;
(* Certified learned-dispatch layer.  This is distinct from the opportunistic
   disk cache: every served record is structural, versioned, and certified. *)
$mbtUseCertifiedLibrary = True;
$mbtLearnedPieceHits = 0;
$mbtLearnedPieceMisses = 0;
$mbtLearnedResolutionHits = 0;
$mbtLearnedResolutionMisses = 0;
(* absolute path of THIS package file, captured at load so subkernels can re-load it *)
$mbtPackageFile = $InputFileName;
(* Portable defaults (release R2, 2026-09-10): every path below is derived from the directory this file was loaded
   from, the bundled package paths of configure_runtime.m and the Mathematica installation; load_standard.m sets
   them again at load.  No path of any build machine is written here. *)
$mbtPackageDirDefault = If[StringQ[$mbtPackageFile] && $mbtPackageFile =!= "",
  DirectoryName[ExpandFileName[$mbtPackageFile]], Directory[] <> $PathnameSeparator];
$mbtPolyLogToolsFile = If[StringQ[Global`$PolyLogPath],
  FileNameJoin[{Global`$PolyLogPath, "PolyLogTools.m"}], ""];
(* math executable used to spawn process-parallel piece workers (override if needed) *)
$mbtMathExecutable = SelectFirst[{FileNameJoin[{$InstallationDirectory, "Executables", "math"}],
  FileNameJoin[{$InstallationDirectory, "MacOS", "WolframKernel"}]}, FileExistsQ,
  FileNameJoin[{$InstallationDirectory, "Executables", "math"}]];
$mbtBarnesRoutinesPath = $mbtPackageDirDefault;

(* Round 21 disk-cache config — DoAllBarnes is the dominant cost
   (~400s for both MB14 corner residues). Caching its output makes
   subsequent runs of the same integral instant. *)
$mbtUseDoABCache = True;
$mbtDoABCacheDir = FileNameJoin[{If[StringQ[Global`$MBStandardCacheDir], Global`$MBStandardCacheDir,
  FileNameJoin[{$UserBaseDirectory, "ApplicationData", "MBAnalytica"}]], "doab"}] <> $PathnameSeparator;

(* Round 22: disk cache for mbtCachedMBSymbolicInt results (per-piece
   closure). Complements DoAllBarnes cache. After a full run,
   re-runs hit BOTH caches and total time drops to a few seconds. *)
$mbtUseMBSymbolicIntDiskCache = True;
$mbtMBSymbolicIntDiskCacheDir = FileNameJoin[{If[StringQ[Global`$MBStandardCacheDir], Global`$MBStandardCacheDir,
  FileNameJoin[{$UserBaseDirectory, "ApplicationData", "MBAnalytica"}]], "symbolicint"}] <> $PathnameSeparator;

(* Round 23 (2026-06-09): hung-pieces analytic correction.
   The 34 hung pieces in MB14 Res#5 (LC 47-60) are 2-fold MB integrals
   that MBAnalytica`SymbolicInt`MBSymbolicInt cannot reduce (it loops indefinitely). Each
   timed-out piece contributes 0 to the residue sum, making the
   final result Indeterminate.

   Workaround: we compute the SUM of all 34 hung pieces once via
   2D NIntegrate, then PSLQ to find the analytic form (uniform
   weight 6 in (γ, π, ζ_3, ζ_5)). The correction is added to the
   ε⁰ coefficient when hung pieces are detected during a residue
   evaluation.

   PSLQ verification: diff < 1e-21 with 25-digit precision input.
   Coefficients are not "natural-size small" — the form may be
   refinable but it's NUMERICALLY EXACT to 25 digits.

   Limitation: this is MB14-SPECIFIC. For other integrals with
   different hung-piece structure, the correction would differ.
   Future work: implement MBClosedFast (Pattern A/B closed-form
   route) to compute hung pieces in closed form generically;
   see MB_CLOSED_FAST_RECIPE.md *)
$mbtUseHungCorrection = False;  (* superseded by direct cache of 77 piece values *)
$mbtHungCorrectionApplied = False;

(* Round 25 (2026-06-13): "long-close" alternative route for the 2-fold
   cross-pole pieces.  DISCOVERY (mb14_2fold_timeout_artifact): those pieces
   are linearly reducible and Euler2MPL closes them EXACTLY given GreedySearch
   and a real time budget (~85s for indet_045, matching the TRB1 reference to
   2.8e-17).  The old 10s cap (Round 22.5) was killing them -> they returned 0
   and were mislabelled "hung".  When the 10s attempt times out, retry with
   GreedySearch under $mbtLongCloseBudget seconds BEFORE giving up.  This makes
   MB14 close to 100% pure-analytic with no PSLQ/numerical correction. *)
$mbtUseLongClose    = True;     (* master switch for the alternative route *)
$mbtLongCloseBudget = 240;      (* seconds for the GreedySearch retry *)
$mbtLongCloseMinVars = 1;       (* Round 26c: include 1-fold pieces -- slow psi^3
                                   pieces (IntegralRep -> many cubes) need >10s and
                                   were being zeroed without a long-close retry *)
$mbtLongCloseCount  = 0;        (* how many pieces this route rescued (telemetry) *)
(* Hardening (2026-06-18): never silently drop a piece.  Every per-piece closer
   that falls back to 0 records itself here; MBresolveToMPL resets this at the
   start of a run and emits a loud warning at the end if it is non-empty, so an
   in-notebook run can no longer report an INCOMPLETE result as if it were final. *)
$mbtFailedPieces = {};
(* Cache version: bump to invalidate all legacy disk/in-memory cache entries (e.g.
   pre-hardening 0-fallbacks that would otherwise be silently trusted).  v2 = the
   recovery-first / no-silent-drop hardening of 2026-06-18; v3 rejects the
   HarmonicSums-Indeterminate fast-path cache poisoning found on 2026-08-28. *)
$mbtCacheVersion = 3;

(* Round 26 (2026-06-13): FIX the standard route for corner-singularity
   integrands.  Root cause: Round 10 switched the corner-sing branch from the
   GLOBAL std route (mbtFullStdRoute = MBresolve + MBexpand + DoAllBarnes on the
   WHOLE expansion + per-piece MBSymbolicInt, exactly as a hand notebook does) to a
   PER-RESIDUE local route (mbtLocalStdRoute).  Per-residue DoAllBarnes cannot
   reduce the z1-z24 cross-pole (the Barnes 1st/2nd lemmas need the full residue
   sum to combine), so those residues survive as unreduced 2-fold MB integrals
   that hang -> the "33 unclosable pieces" were an ARTIFACT of this routing.
   Applying DoAllBarnes GLOBALLY collapses the cross-pole into single-variable
   pieces (z1-only / z24-only) that MBSymbolicInt closes trivially.  This knob restores
   the global route for corner-sing integrands. *)
$mbtUseGlobalBarnes      = True;   (* corner-sing -> one global mbtFullStdRoute *)
$mbtGlobalBarnesBudget   = 2400;   (* seconds for the global DoAllBarnes + MBSymbolicInt *)
(* s61 (2026-08-25): piece-level prints are silenced when MBresolveToMPL runs
   with "Verbose" -> False; MBSymbolicInt called directly still prints. *)
$mbtQuietPieces = False;
mbtPPrint[x___] := If[! TrueQ[$mbtQuietPieces], Print[x]];
(* Round 26f: with the numeric cache guard (mbtCleanNumQ), a cached 0 is a
   LEGITIMATE value, not a stale "hung->0" marker, so distrusting it just forces a
   needless (and possibly ginsh-hanging) recompute. Default OFF. *)
$mbtDistrustZeros        = False;
$mbtHungCorrectionValue =
  (366*EulerGamma^6)/5 + (679*EulerGamma^4*Pi^2)/5 +
  (703*EulerGamma^2*Pi^4)/5 - (36*Pi^6)/5 +
  18*EulerGamma^3*Zeta[3] + (32*EulerGamma*Pi^2*Zeta[3])/5 +
  (797*EulerGamma*Zeta[5])/5 - (937*Zeta[3]^2)/5;

$mbtTotalHungCount = 0;

(* Reject every finite-precision numeric atom.  Pure-imaginary arbitrary-
   precision numbers are atomic Complex objects in Mathematica and therefore
   are invisible to a `_Real` pattern. *)
mbtInexactNumberFreeQ[xx_] :=
  Cases[xx,
    number_?NumberQ /; Precision[Unevaluated[number]] =!= Infinity :> number,
    {0, Infinity}, Heads -> True] === {};

(* Round 26f (2026-06-14): a piece value is acceptable to USE and to CACHE only if
   it is a finite numeric constant (MZV/Pi/Zeta/EulerGamma reduce under N) with NO
   leftover Euler cube variables (t/u/s/bdyU) and no remaining MB var.  Guards
   against caching unintegrated cube integrands (Euler2MPL "beyond scope"). *)
mbtCleanNumQ[xx_, vrs_] :=
  xx =!= $TimedOut && xx =!= $Failed && xx =!= Indeterminate &&
  FreeQ[xx, Indeterminate] && FreeQ[xx, (t | u | s | bdyU)[_]] &&
  FreeQ[xx, Alternatives @@ vrs] && NumericQ[Quiet @ N[xx]];

(* Round 26d (2026-06-14): contour-shift recovery for single-variable pieces
   that MBtoEuler mis-converts at a NON-STANDARD contour (a Gamma double-pole on
   the wrong side of the contour, e.g. the up-shifted psi^3/psi^2 psi pieces of
   MB14 whose DoAllBarnes contour sits left of the z=-1 pole).  Such pieces
   return Indeterminate at their own contour but evaluate cleanly at a standard
   contour; the values are related by the residue theorem:
       value(c0) = value(cT) - Sum_{c0<Re(p)<cT} Res(f, p)   (cT > c0).
   Verified on MB14 piece 17 (T0 -> -103.711, full -> 55.5019, both exact). *)
mbtRecoverContour[f_, c0_, v_] := Module[
  {args, poleVs, cands, cT, crossed, base, resSum, out = $Failed, mbcall},
  mbcall[cc_] := Module[{r = Quiet @ TimeConstrained[
       Block[{Print}, MBAnalytica`SymbolicInt`MBSymbolicInt[f, {v -> cc}, {v}, "GreedySearch" -> True]],
       $mbtLongCloseBudget, $TimedOut]},
     If[AssociationQ[r], r["MPLResult"], r]];
  args = DeleteDuplicates @ Join[Cases[f, Gamma[a_] :> a, Infinity],
                                 Cases[f, PolyGamma[_, a_] :> a, Infinity]];
  poleVs = DeleteDuplicates @ Flatten @ Table[
     Quiet @ Check[v /. Solve[a == -n, v][[1]], Nothing], {a, args}, {n, 0, 12}];
  poleVs = Sort @ Select[poleVs, (NumericQ[#] && Im[#] == 0) &];
  If[poleVs === {}, Return[$Failed]];
  (* candidate target contours: midpoints of gaps strictly right of c0 *)
  cands = Join[Select[MovingAverage[poleVs, 2], # > c0 &], {Max[poleVs] + 1/2}];
  Do[
    cT = cands[[i]];
    base = mbcall[cT];
    If[base =!= $TimedOut && base =!= $Failed && FreeQ[base, Indeterminate] &&
       NumericQ[Quiet @ N[base]],
      crossed = Select[poleVs, (c0 < # < cT) &];
      resSum  = Total[Residue[f, {v, #}] & /@ crossed];
      out = base - resSum;
      (* The recovered value is GATED by the contour quadrature of the piece on its own line: the base closure at
         the shifted contour can be wrong, and this path had no other gate (a slope-two denominator Gamma(2+2z) with
         a psi(z) dressing was served as -Res(z = -1)).  A value the quadrature does not confirm is refused; an
         inconclusive quadrature refuses as well (fail-closed, as every other piece gate of the route). *)
      Module[{tq, q},
        q = Quiet @ TimeConstrained[
          NIntegrate[Evaluate[(f /. v -> c0 + I tq)/(2 Pi)], {tq, -60, 60}, WorkingPrecision -> 25,
            PrecisionGoal -> 10, MaxRecursion -> 30], 300, $TimedOut];
        If[TrueQ[NumericQ[q] && Abs[N[out, 30] - q] < 10^-8 Max[1, Abs[q]]],
          Break[],
          WriteString["stdout", "    [LSR] contour-shift recovery REFUSED by the contour quadrature: recovered ",
            ToString[N[out, 12]], " vs quadrature ", ToString[If[NumericQ[q], N[q, 12], q]],
            " (target contour ", ToString[cT], ")\n"];
          out = $Failed]]],
    {i, Length[cands]}];
  out];

(* Helper: read MBSymbolicInt result from disk cache (returns $Failed if miss) *)
mbtMBSymbolicIntDiskGet[hashKey_String] := Module[{f, ok},
  If[!TrueQ[$mbtUseMBSymbolicIntDiskCache], Return[$Failed]];
  f = FileNameJoin[{$mbtMBSymbolicIntDiskCacheDir, "mp_" <> hashKey <> ".mx"}];
  If[!FileExistsQ[f], Return[$Failed]];
  ok = Quiet @ Check[Get[f]; True, False];
  If[ok && ValueQ[mbtMBSymbolicIntCachedVal],
    With[{v = mbtMBSymbolicIntCachedVal}, ClearAll[mbtMBSymbolicIntCachedVal]; v],
    $Failed]];

(* Helper: write MBSymbolicInt result to disk cache *)
mbtMBSymbolicIntDiskPut[hashKey_String, value_] := Module[{f},
  If[!TrueQ[$mbtUseMBSymbolicIntDiskCache], Return[Null]];
  If[!DirectoryQ[$mbtMBSymbolicIntDiskCacheDir],
    Quiet @ CreateDirectory[$mbtMBSymbolicIntDiskCacheDir]];
  f = FileNameJoin[{$mbtMBSymbolicIntDiskCacheDir, "mp_" <> hashKey <> ".mx"}];
  Quiet @ Check[
    mbtMBSymbolicIntCachedVal = value;
    DumpSave[f, mbtMBSymbolicIntCachedVal];
    ClearAll[mbtMBSymbolicIntCachedVal], Null]];

mbtInitParallel[] := If[!TrueQ[$mbtParallelReady] && TrueQ[$mbtUseParallel],
  Module[{t0, currK, brPath = $mbtBarnesRoutinesPath, log},
    t0 = AbsoluteTime[];
    currK = Length[Kernels[]];
    If[currK < $mbtNumKernels,
      Quiet @ LaunchKernels[$mbtNumKernels - currK]];
    log[s_] := WriteString["stdout", "[ParInit] ", s, "\n"];
    log[ToString[Length[Kernels[]]] <> " kernels launched in " <>
        ToString[Round[AbsoluteTime[]-t0, 0.01]] <> "s"];
    t0 = AbsoluteTime[];
    Quiet @ ParallelEvaluate[
      $brPath = brPath;
      Quiet[Get[$brPath <> "MB.m"]];
      Quiet[Get[$brPath <> "MBresolve.m"]];
      Quiet[Get[$brPath <> "barnesroutines.m"]];
      "OK"];
    log["BarnesRoutines loaded in subkernels in " <>
        ToString[Round[AbsoluteTime[]-t0, 0.01]] <> "s"];
    $mbtParallelReady = True]];

(* ============================================================
   In-package per-piece parallelism (2026-06-19).
   Launches n subkernels and, on EACH, loads PolyLogTools + this package
   + MB/MBresolve/barnesroutines by ABSOLUTE path, gives it a per-kernel
   GiNaC temp dir (no Ginshtemplate collisions), disables disk caches (no
   cross-kernel write contention), binds HS tables, and BOOTSTRAPS the
   nested per-piece closer mbtCachedMBSymbolicInt by running MBresolveToMPL once
   on a trivial corner-free MB.  Returns True on success, False to fall
   back to serial.  Idempotent (only re-inits if kernel count changed). *)
mbtInitPieceKernels[nSpec_] := Module[
  {n, currK, brPath = $mbtBarnesRoutinesPath,
   pkgPath = $mbtPackageFile, pltPath = $mbtPolyLogToolsFile},
  n = Which[
    nSpec === Automatic, Max[1, Min[16, $ProcessorCount - 2]],
    IntegerQ[nSpec] && nSpec > 0, nSpec,
    True, 0];
  If[n <= 0, Return[False]];
  If[pkgPath === "" || pkgPath === $Failed || ! FileExistsQ[pkgPath],
    WriteString["stdout", "  [PieceKernels] cannot locate package file; serial.\n"];
    Return[False]];
  currK = Length[Kernels[]];
  If[currK < n, Quiet @ LaunchKernels[n - currK]];
  If[Length[Kernels[]] < 1, Return[False]];
  If[TrueQ[$mbtPieceKernelsReady] && Length[Kernels[]] >= n, Return[True]];
  WriteString["stdout", "  [PieceKernels] initializing ", Length[Kernels[]],
    " subkernels...\n"];
  (* IMPORTANT: inline the path STRINGS with With so the values reach the
     subkernels.  ParallelEvaluate does NOT substitute master-local Module
     variables -- referencing pkgPath/pltPath/brPath bare would send undefined
     symbols and the package would never load on the subkernel. *)
  With[{pltPath = pltPath, pkgPath = pkgPath, brPath = brPath},
  Quiet @ ParallelEvaluate[
    Off[General::shdw];
    Quiet[Get[pltPath]];
    Quiet[Get[pkgPath]];
    (* sidecar (derivative-form closer) into each subkernel *)
    Quiet[Get[DirectoryName[pkgPath] <> "/mbeSeqIntegrate.m"]];
    Quiet[Get[brPath <> "MB.m"]];
    Quiet[Get[brPath <> "MBresolve.m"]];
    Quiet[Get[brPath <> "barnesroutines.m"]];
    (* per-kernel GiNaC temp dir; $KernelID is distinct per subkernel *)
    If[NameQ["PolyLogTools`GiNaC$InterfacePath"],
      PolyLogTools`GiNaC$InterfacePath =
        FileNameJoin[{$TemporaryDirectory, "symbolicint-ginac-k" <> ToString[$KernelID]}] <> "/";
      Quiet @ CreateDirectory[PolyLogTools`GiNaC$InterfacePath,
        CreateIntermediateDirectories -> True]];
    (* no shared disk-cache writes across kernels *)
    MBAnalytica`SymbolicInt`Private`$mbtUseMBSymbolicIntDiskCache = False;
    MBAnalytica`SymbolicInt`Private`$mbtUseDoABCache = False;
    MBAnalytica`SymbolicInt`Private`$mbtUseLongClose = True;
    MBAnalytica`SymbolicInt`Private`$mbtLongCloseMinVars = 1;
    Quiet @ MBAnalytica`SymbolicInt`Private`mbeLoadHarmonicSums[];
    Quiet @ MBAnalytica`SymbolicInt`Private`mbeRebindHSTables[];
    (* BOOTSTRAP: install the nested mbtCachedMBSymbolicInt by running MBresolveToMPL
       once on a trivial corner-free MB (MBpilot12). *)
    Module[{be, bmb},
      bmb = (E^(2 (EulerGamma + I Pi) be) Gamma[-z35] Gamma[2 - 4 be] Gamma[4 - 4 be] Gamma[1 - z35 - 3 be] Gamma[1 - 2 be] Gamma[1 + z35 - be] Gamma[be] Gamma[z35 + be]^2)/(Gamma[4 - 8 be] Gamma[2 + z35 - 3 be] Gamma[2 - 2 be]);
      Quiet @ MBAnalytica`SymbolicInt`MBresolveToMPL[bmb, be,
        "EpsOrderMin" -> 0, "EpsOrderMax" -> 0, "Verbose" -> False, "PieceKernels" -> 0]];
    (* reset per-kernel ledger/telemetry after bootstrap *)
    MBAnalytica`SymbolicInt`Private`$mbtFailedPieces = {};
    MBAnalytica`SymbolicInt`Private`$mbtTotalHungCount = 0;
    MBAnalytica`SymbolicInt`Private`$mbtLongCloseCount = 0;
    "OK", DistributedContexts -> None]];
  $mbtPieceKernelsReady = True;
  WriteString["stdout", "  [PieceKernels] ready (", Length[Kernels[]], " kernels).\n"];
  True];

(* ============================================================
   Process-parallel per-piece close (2026-06-19).  Spawns n
   independent `math -script mbt_piece_worker.m` OS processes (each immune to
   ginsh stderr floods), dumps the pieces, waits, and collects results in
   index order.  Returns the list of per-piece VALUES (same as the serial
   Table) so `mbConstVal + mbEva.epsFac2` is identical to serial.  Aggregates
   the no-silent-drop ledger.  Falls back to serial on any launch failure. *)
mbtClosePiecesParallel[integ_List, ctrs_List, vars_List, epsFacs_List, pkSpec_] :=
  Module[{n = Length[integ], nW, jobRoot, pkgDir, worker, procs, res, k,
          serialFallback},
    serialFallback := Table[
      MBAnalytica`SymbolicInt`Private`mbtCachedMBSymbolicInt[integ[[ii]], ctrs[[ii]], vars[[ii]]],
      {ii, n}];
    nW = Which[
      pkSpec === Automatic, Max[1, Min[16, $ProcessorCount - 2]],
      IntegerQ[pkSpec] && pkSpec > 0, pkSpec, True, 1];
    nW = Min[nW, n];
    pkgDir = DirectoryName[$mbtPackageFile];
    worker = FileNameJoin[{pkgDir, "mbt_piece_worker.m"}];
    If[$mbtPackageFile === "" || ! FileExistsQ[worker] ||
       ! FileExistsQ[$mbtMathExecutable],
      WriteString["stdout",
        "  [PieceKernels] worker/math not found; falling back to serial.\n"];
      Return[serialFallback]];
    jobRoot = FileNameJoin[{$TemporaryDirectory,
      "symbolicint-piece-" <> ToString[$ProcessID] <> "-" <>
      StringReplace[CreateUUID[], "-" -> ""]}];
    Quiet @ CreateDirectory[jobRoot, CreateIntermediateDirectories -> True];
    Put[<|"pkgDir" -> pkgDir, "pkgPath" -> $mbtPackageFile,
          "pltPath" -> $mbtPolyLogToolsFile, "nPieces" -> n,
          "useCertifiedLibrary" -> TrueQ[$mbtUseCertifiedLibrary]|>,
        FileNameJoin[{jobRoot, "meta.m"}]];
    Do[Put[<|"integEps1" -> integ[[ii]], "ctr" -> ctrs[[ii]],
             "vrs" -> vars[[ii]], "epsFac" -> epsFacs[[ii]]|>,
           FileNameJoin[{jobRoot, "p_" <> IntegerString[ii, 10, 4] <> ".m"}]],
      {ii, n}];
    WriteString["stdout", "  [PieceKernels] ", nW,
      " process-workers on ", n, " pieces (job ", FileNameTake[jobRoot], ")...\n"];
    (* Launch via a generated bash script: env vars passed by the shell reach
       the workers reliably (the proven par_run.sh mechanism).  StartProcess +
       ProcessEnvironment did NOT deliver the env to the workers. *)
    Module[{sh, runfile, rc},
      sh = "#!/bin/bash\ncd " <> MBAnalytica`Portable`ShellQuote[pkgDir] <> "\n" <>
        StringJoin @ Table[
          "LO=" <> ToString[w] <> " STRIDE=" <> ToString[nW] <>
          " JOBROOT=" <> MBAnalytica`Portable`ShellQuote[jobRoot] <> " " <> MBAnalytica`Portable`ShellQuote[$mbtMathExecutable] <>
          " -script " <> MBAnalytica`Portable`ShellQuote[worker] <> " > " <>
          MBAnalytica`Portable`ShellQuote[FileNameJoin[{jobRoot, "w_" <> ToString[w] <> ".log"}]] <>
          " 2>&1 &\n", {w, nW}] <> "wait\n";
      runfile = FileNameJoin[{jobRoot, "run.sh"}];
      Export[runfile, sh, "Text"];
      rc = Run["bash " <> MBAnalytica`Portable`ShellQuote[runfile]];
      If[rc =!= 0,
        WriteString["stdout", "  [PieceKernels] launcher exit code ", rc,
          " (collecting; any missing pieces will be flagged, not dropped).\n"]]];
    (* v2.6 (2026-07-27): absorb the workers' library DELTA files (each worker
       writes ivlib_delta_<pid>.m instead of the shared intvol_library.m; see
       mbt_piece_worker.m).  The master is the single shared-file writer;
       IVLibMergeInto keeps certified over provisional and cheaper over
       slower.  IVLibLoad does NOT autosave, so save explicitly. *)
    If[DownValues[Global`IVLibMergeFile] =!= {},
      Module[{ivDfs = FileNames["ivlib_delta_*.m", jobRoot]},
        If[ivDfs =!= {},
          Block[{Global`$IVLibVerbose = False},
            Scan[Quiet[Global`IVLibMergeFile[#]] &, ivDfs];
            If[StringQ[Global`$IVLibFile],
              Quiet@Global`IVLibSave[Global`$IVLibFile]]];
          WriteString["stdout", "  [PieceKernels] merged ",
            Length[ivDfs], " library delta file(s).\n"]]]];
    (* collect in index order; track which pieces the workers did NOT cleanly
       produce (a worker process can die -- e.g. a ginsh segfault -- leaving its
       whole stride unfinished).  Don't flag yet; the master mops them up. *)
    Module[{bad = {}, rr},
      res = Table[
        Module[{rf = FileNameJoin[{jobRoot, "r_" <> IntegerString[k, 10, 4] <> ".m"}], r1},
          r1 = If[FileExistsQ[rf], Quiet @ Check[Get[rf], $Failed], $Failed];
          If[AssociationQ[r1] && r1["status"] === "Clean",
            If[TrueQ[Lookup[r1, "certifiedLibraryHit", False]],
              $mbtLearnedPieceHits++,
              If[TrueQ[$mbtUseCertifiedLibrary], $mbtLearnedPieceMisses++]];
            r1["value"],
            AppendTo[bad, k]; 0]],
        {k, n}];
      (* SERIAL MOP-UP on the master: recompute any worker-missing/non-clean piece
         here (the master has mbtCachedMBSymbolicInt via the enclosing MBresolveToMPL call).
         Guarantees completion even if a worker crashed.  mbtCachedMBSymbolicInt itself
         records any genuinely-unrecoverable piece in $mbtFailedPieces. *)
      If[bad =!= {},
        WriteString["stdout", "  [PieceKernels] serial mop-up of ", Length[bad],
          " worker-missing/non-clean piece(s)...\n"];
        Do[res[[k]] = MBAnalytica`SymbolicInt`Private`mbtCachedMBSymbolicInt[
             integ[[k]], ctrs[[k]], vars[[k]]], {k, bad}]]];
    If[Length[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces] == 0,
      Quiet @ DeleteDirectory[jobRoot, DeleteContents -> True],
      WriteString["stdout", "  [PieceKernels] job kept for inspection: ", jobRoot, "\n"]];
    WriteString["stdout", "  [PieceKernels] done (",
      n - Length[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces], "/", n, " clean).\n"];
    res];

(* Parallel DoAllBarnes drop-in.  Mirrors Czakon's iterative loop but
   uses ParallelMap on the per-piece maps.  MBmerge is kept serial
   (canonicalization needs global view).  Falls back to serial DoAllBarnes
   if parallelization fails or is disabled. *)
mbtDoAllBarnesPar[intlist_List, progressive_:False, bound_:1] :=
  Module[{result, previous = {}, limit = 1, others, parOpts,
          MBDim, EI, DB1, DB2, MBM, fallback},
    If[!TrueQ[$mbtUseParallel] || Length[intlist] == 0,
       Return[BarnesRoutines`DoAllBarnes[intlist, progressive, bound]]];
    mbtInitParallel[];
    MBDim = BarnesRoutines`MBDimension;
    EI    = BarnesRoutines`ExpandInt;
    DB1   = BarnesRoutines`DoBarnes1;
    DB2   = BarnesRoutines`DoBarnes2;
    MBM   = MB`MBmerge;
    parOpts = {Method -> "CoarsestGrained",
               DistributedContexts -> None};
    fallback = False;
    Check[
      result = Flatten[ParallelMap[EI, intlist, Sequence@@parOpts]];
      If[progressive, limit = Max @@ (MBDim /@ result)];
      While[Union[result] =!= Union[previous],
        previous = result;
        (* Barnes2 *)
        others = Select[result, MBDim[#] < limit&];
        result = Select[result, MBDim[#] >= limit&];
        result = If[Length[result] > 10,
                    Flatten[ParallelMap[DB2, result, Sequence@@parOpts]],
                    Flatten[DB2 /@ result]];
        result = If[Length[result] > 10,
                    Flatten[ParallelMap[EI, result, Sequence@@parOpts]],
                    Flatten[EI /@ result]];
        result = Join[result, others];
        result = MBM[result];
        result = If[Length[result] > 10,
                    Flatten[ParallelMap[EI, result, Sequence@@parOpts]],
                    Flatten[EI /@ result]];
        (* Barnes1 *)
        others = Select[result, MBDim[#] < limit&];
        result = Select[result, MBDim[#] >= limit&];
        result = If[Length[result] > 10,
                    Flatten[ParallelMap[DB1, result, Sequence@@parOpts]],
                    Flatten[DB1 /@ result]];
        result = If[Length[result] > 10,
                    Flatten[ParallelMap[EI, result, Sequence@@parOpts]],
                    Flatten[EI /@ result]];
        result = Join[result, others];
        result = MBM[result];
        If[limit > 1, limit -= 1]];
      ,
      fallback = True];
    If[fallback,
       WriteString["stdout", "[ParBarnes] FALLBACK to serial DoAllBarnes\n"];
       BarnesRoutines`DoAllBarnes[intlist, progressive, bound],
       result]];

(* Re-binds tables for ReduceConstants — call once per mbtLocalStdRoute
   invocation. The bindings don't survive across Module scopes. *)
mbeRebindHSTables[] := Module[{d, files},
  If[mbeLoadHarmonicSums[] === $Failed, Return[$Failed]];
  d = $mbeHSRoot;
  If[! StringQ[d] || ! DirectoryQ[d], Return[$Failed]];
  files = FileNameJoin[{d, #}] & /@ {
    "RelTabSinfH1.m", "RelTabSinfH1Bis8.m", "RelTab.m", "RelTabCSinf.m"};
  If[! AllTrue[files, FileExistsQ], Return[$Failed]];
  CheckAbort[
    Quiet[HarmonicSums`DefineSinfTable[files[[1]]]];
    Quiet[HarmonicSums`DefineSinfTable[files[[2]]]];
    Quiet[HarmonicSums`DefineRelationTable[files[[3]]]];
    Quiet[HarmonicSums`DefineCSinfTable[files[[4]]]];
    True, $Aborted]];

(* Map term-by-term:
     S[a..,var] / var^p  -> S[p, a.., Infinity]
     1/var^p  (p >= 2)   -> S[p, Infinity]
     1/var  (divergent)  -> SymDiv[1]      (tagged for later cancellation)
*)
mbeEulerSumRule[expr_, var_] := Catch[
  Module[{e = Expand[expr], terms, mVar},
    terms = If[Head[e] === Plus, List @@ e, {e}];
    Total[Map[Function[t, Module[{snums, snargs, rest, r2, npow, coef},
      snums = Cases[t, HarmonicSums`S[__, var], {0, Infinity}];
      If[Length[snums] > 1, Throw[$Failed]];
      rest = t /. (s_ /; MemberQ[snums, s]) :> 1;
      mVar = Unique["mEs"];
      r2 = rest /. var -> mVar;
      npow = -Exponent[r2, mVar];
      coef = r2 /. mVar -> 1;
      Which[
        Length[snums] == 1,
          snargs = Most[List @@ First[snums]];
          coef HarmonicSums`S[Sequence @@ Prepend[snargs, npow], Infinity],
        npow >= 2,
          coef HarmonicSums`S[npow, Infinity],
        True,
          coef HarmonicSums`SymDiv[npow]]
    ]], terms]]]];

mbeCloseResidueSumS[summand_, var_] := Module[
  {loaded, e, mapped, closed, result, zRules},
  loaded = mbeLoadHarmonicSums[];
  If[loaded === $Failed, Return[$Failed]];
  e = summand /. {
    HarmonicNumber[var] -> HarmonicSums`S[1, var],
    HarmonicNumber[var, p_.] :> HarmonicSums`S[p, var]};
  e = HarmonicSums`LinearExpand[e];
  e = Expand[e];
  mapped = mbeEulerSumRule[e, var];
  If[mapped === $Failed, Return[$Failed]];
  closed = HarmonicSums`ReduceConstants[mapped,
    HarmonicSums`ToKnownConstants -> True];
  result = closed /. {HarmonicSums`S[1, Infinity] -> 0,
                      HarmonicSums`SymDiv[_] -> 0};
  (* HS emits z_k as bare symbols in its private context. Match by name. *)
  result = result /. s_Symbol /;
    StringMatchQ[SymbolName[s], RegularExpression["^z[2-8]$"]] :>
    Zeta[ToExpression[StringDrop[SymbolName[s], 1]]];
  result];

(* Wrapper: shifts (n+1)^p -> n^p before core closure (Sum_{n=0}^Inf summand
   -> Sum_{n=1}^Inf summand /. n->n-1 with HN identities). *)
mbeCloseResidueSumSShifted[summand_, var_] := Module[{shifted},
  shifted = summand /. var -> var - 1;
  shifted = shifted //. {
    HarmonicNumber[var - 1] -> HarmonicNumber[var] - 1/var,
    HarmonicNumber[var - 1, p_Integer] :> HarmonicNumber[var, p] - 1/var^p};
  shifted = Expand[shifted];
  mbeCloseResidueSumS[shifted, var]];

mbeIsValidClosureQ[result_, var_] :=
  result =!= $Failed && result =!= $TimedOut &&
  FreeQ[result, _Sum] && FreeQ[result, _Residue] &&
  FreeQ[result, HarmonicSums`S[__, Infinity]] &&
  FreeQ[result, var];

(* ------------------------------------------------------------------
   Round 15 (2026-06-08): full MB-piece HS closure for the corner-sing
   route. Detects Pattern A: Gamma(-1-z)*Gamma(-z)*Gamma(1+z)^k * ψ(0,-1-z)^j
   [optionally /Gamma(2+z)]. Applies preSimplify (reflection identities) +
   Series at z=n+w + Euler-sum-rule closure -> MZV. Per-piece cost ~0.1-0.5s
   vs 60s for raw MBSymbolicInt on the slow ψ^3 cases. *)

mbePreSimplifyForLSR[mb_, var_] := Module[{e, eSimp},
  e = mb /. {
    Gamma[-var]     :> -Pi/(Sin[Pi var] Gamma[1 + var]),
    Gamma[-1 - var] :> Pi/((1 + var) Sin[Pi var] Gamma[1 + var]),
    Gamma[-2 - var] :> -Pi/((1 + var)(2 + var) Sin[Pi var] Gamma[1 + var]),
    PolyGamma[0, -var]     :> PolyGamma[0, 1 + var] + Pi Cot[Pi var],
    PolyGamma[0, -1 - var] :> PolyGamma[0, 2 + var] + Pi Cot[Pi var],
    PolyGamma[0, -2 - var] :> PolyGamma[0, 3 + var] + Pi Cot[Pi var],
    PolyGamma[1, -var]     :> -PolyGamma[1, 1 + var] + Pi^2 Csc[Pi var]^2,
    PolyGamma[1, -1 - var] :> -PolyGamma[1, 2 + var] + Pi^2 Csc[Pi var]^2,
    (* Round 24 (2026-06-09): extend to ψ(2,..) and ψ(3,..) for the
       77 problematic pieces that previously returned Indeterminate.
       Derived from differentiating the reflection identity
       ψ(1-y) - ψ(y) = π cot(π y) at y = 2+z (so 1-y = -1-z). *)
    PolyGamma[2, -var]     :>  PolyGamma[2, 1 + var] +
       2 Pi^3 Csc[Pi var]^2 Cot[Pi var],
    PolyGamma[2, -1 - var] :>  PolyGamma[2, 2 + var] +
       2 Pi^3 Csc[Pi var]^2 Cot[Pi var],
    PolyGamma[3, -var]     :> -PolyGamma[3, 1 + var] +
       2 Pi^4 Csc[Pi var]^2 (2 Cot[Pi var]^2 + Csc[Pi var]^2),
    PolyGamma[3, -1 - var] :> -PolyGamma[3, 2 + var] +
       2 Pi^4 Csc[Pi var]^2 (2 Cot[Pi var]^2 + Csc[Pi var]^2)
  };
  (* Collapse Gamma(1+z)^k / Gamma(1+z)^j and Gamma(2+z) = (1+z) Gamma(1+z)
     algebraically (avoid FullSimplify which can hang). *)
  e = e /. Gamma[2 + var] -> (1 + var) Gamma[1 + var];
  e = e // PowerExpand // Together;
  eSimp = Quiet @ TimeConstrained[Simplify[e], 3, e];
  eSimp];

(* Detector: integrand has only Gamma(-z), Gamma(-1-z) [Gamma(-2-z)] poles
   and PolyGamma at neg-int arg. Excludes Gamma(z)/Gamma(z-...) (positive
   args at z=n>=0 are fine but Gamma at z=0 has pole — pattern B which we
   handle separately via Series order). *)
mbeIsPatternALSR[mb_, var_] := Module[{cases},
  cases = Cases[mb, Gamma[a_] /; !FreeQ[a, var], Infinity];
  AllTrue[cases, Function[g, Module[{a = First[g]},
    With[{coef = D[a, var]},
      Or[
        coef === -1 && Cases[{a /. var -> 0}, _Integer?(# <= 0 &)] =!= {},
        coef === 1  && Cases[{a /. var -> 0}, _Integer?(# >= 1 &)] =!= {}]]]]]
];

(* Manual quasi-shuffle for HarmonicSums S-products. Needed because
   HarmonicSums`LinearExpand fails on full-qualified `HarmonicSums`S`
   arguments (only works on bare S, which inside our package context
   resolves to MBAnalytica`SymbolicInt`Private`S — wrong symbol). HS convention:
   S[a,n]·S[b,n] = S[a,b,n] + S[b,a,n] - S[a+b,n]. *)
mbeStuffleH[{}, b_List] := {{1, b}};
mbeStuffleH[a_List, {}] := {{1, a}};
mbeStuffleH[a_List, b_List] :=
  Module[{ah = First[a], bh = First[b], at = Rest[a], bt = Rest[b]},
   Join[
    Map[{#[[1]], Prepend[#[[2]], ah]} &, mbeStuffleH[at, b]],
    Map[{#[[1]], Prepend[#[[2]], bh]} &, mbeStuffleH[a, bt]],
    Map[{-#[[1]], Prepend[#[[2]], ah + bh]} &, mbeStuffleH[at, bt]]]];

mbeSProd[a_List, b_List, var_] :=
  Total[Map[#[[1]] HarmonicSums`S[Sequence @@ #[[2]], var] &,
    mbeStuffleH[a, b]]];

mbeFlattenS[expr_, var_] := FixedPoint[
  Expand[# /. {
    HarmonicSums`S[a__, var] * HarmonicSums`S[b__, var] :>
      mbeSProd[{a}, {b}, var],
    HarmonicSums`S[a__, var]^k_Integer /; k >= 2 :>
      mbeSProd[{a}, {a}, var] * HarmonicSums`S[a, var]^(k - 2)}] &,
  Expand[expr]];

mbeCloseMBPieceHS[mb_, var_] :=
  Module[{mbS, withW, ser, resN, resHN, shifted, sExpr, flat, mapped, closed,
          sumVar = Unique["nLSR"], wVar = Unique["wLSR"]},
  mbS = mbePreSimplifyForLSR[mb, var];
  withW = mbS /. var -> sumVar + wVar;
  withW = withW //. {
    Csc[Pi (sumVar + wVar)] :> (-1)^sumVar Csc[Pi wVar],
    Cot[Pi (sumVar + wVar)] :> Cot[Pi wVar],
    Sin[Pi (sumVar + wVar)] :> (-1)^sumVar Sin[Pi wVar]};
  ser = Quiet@TimeConstrained[Series[withW, {wVar, 0, 0}], 20, $TimedOut];
  If[ser === $TimedOut, Return[$Failed]];
  resN = SeriesCoefficient[ser, -1] /. (-1)^(2 _) -> 1;
  resN = Expand[resN];
  resHN = resN /. {
    PolyGamma[0, k_Integer + sumVar] /; k >= 1 :>
      -EulerGamma + HarmonicNumber[k - 1 + sumVar],
    PolyGamma[1, k_Integer + sumVar] /; k >= 1 :>
      Zeta[2] - HarmonicNumber[k - 1 + sumVar, 2],
    PolyGamma[2, k_Integer + sumVar] /; k >= 1 :>
      -2 Zeta[3] + 2 HarmonicNumber[k - 1 + sumVar, 3],
    PolyGamma[3, k_Integer + sumVar] /; k >= 1 :>
      6 Zeta[4] - 6 HarmonicNumber[k - 1 + sumVar, 4]};
  resHN = Expand[resHN];
  shifted = resHN /. sumVar -> sumVar - 1;
  shifted = shifted //. {
    HarmonicNumber[sumVar - 1] -> HarmonicNumber[sumVar] - 1/sumVar,
    HarmonicNumber[sumVar - 1, p_Integer] :>
      HarmonicNumber[sumVar, p] - 1/sumVar^p};
  shifted = Expand[shifted];
  sExpr = shifted /. {
    HarmonicNumber[sumVar] :> HarmonicSums`S[1, sumVar],
    HarmonicNumber[sumVar, p_.] :> HarmonicSums`S[p, sumVar]};
  flat = mbeFlattenS[sExpr, sumVar];
  mapped = Catch[Module[{e = Expand[flat], terms},
    terms = If[Head[e] === Plus, List @@ e, {e}];
    Total[Map[Function[t, Module[
      {snums, snargs, rest, r2, npow, coef, mV},
      snums = Cases[t, HarmonicSums`S[__, sumVar], {0, Infinity}];
      If[Length[snums] > 1, Throw[$Failed]];
      rest = t /. (s_ /; MemberQ[snums, s]) :> 1;
      mV = Unique["mES"];
      r2 = rest /. sumVar -> mV;
      npow = -Exponent[r2, mV];
      coef = r2 /. mV -> 1;
      Which[
        npow >= 1 && Length[snums] == 1,
          snargs = Most[List @@ First[snums]];
          coef HarmonicSums`S[Sequence @@ Prepend[snargs, npow], Infinity],
        npow >= 2 && Length[snums] == 0,
          coef HarmonicSums`S[npow, Infinity],
        npow == 1 && Length[snums] == 0,
          coef HarmonicSums`SymDiv[1],
        npow <= 0, Throw[$Failed],
        True, t]]], terms]]]];
  If[mapped === $Failed, Return[$Failed]];
  closed = HarmonicSums`ReduceConstants[mapped,
    HarmonicSums`ToKnownConstants -> True];
  closed = closed /. {HarmonicSums`S[1, Infinity] -> 0,
                      HarmonicSums`SymDiv[_] -> 0,
                      HarmonicSums`S[k_Integer?(# >= 2 &), Infinity] :>
                        Zeta[k]};
  closed = closed /. s_Symbol /;
    StringMatchQ[SymbolName[s], RegularExpression["^z[2-8]$"]] :>
    Zeta[ToExpression[StringDrop[SymbolName[s], 1]]];
  -closed  (* MBSymbolicInt contour-orientation sign *)
];

(* Pattern B fast-path: integrands like c·Γ(-z)² Γ(z) Γ(1+z) ψ(0,z)^j
   simplify to c·π²·ψ(0,z)^j / (z sin²(πz)). Residue at z=0 (high-order
   pole from ψ(0,0)) computed directly; residues at z=n>=1 computed via
   Series. Final result: -(res0 + Σ_{n>=1} resN). *)
mbeIsPatternBLSR[mb_, var_] := Module[{factors, hasGammaMz2, hasGammaZ, hasPsi0},
  factors = If[Head[mb] === Times, List @@ mb, {mb}];
  (* Has Γ(-z)² *)
  hasGammaMz2 = MemberQ[factors, Gamma[-var]^2 | Gamma[-var]];
  (* Has Γ(z) *)
  hasGammaZ = MemberQ[factors, Gamma[var]];
  (* Has ψ(0, z) or ψ(0, 1+z) *)
  hasPsi0 = !FreeQ[mb, PolyGamma[0, var] | PolyGamma[0, 1 + var]];
  hasGammaMz2 && hasGammaZ && hasPsi0
];

mbeCloseMBPieceHSB[mb_, var_] :=
  Module[{mbS, withW, ser, resN, res0, resHN, shifted, sExpr, flat, mapped,
          closed, sumVar = Unique["nLSRB"], wVar = Unique["wLSRB"]},
  (* Simplify: Γ(-z)² Γ(z) Γ(1+z) = π²/(z sin²(πz)) *)
  mbS = mb /. {
    Gamma[-var] :> -Pi/(Sin[Pi var] Gamma[1 + var]),
    Gamma[var]  :> Gamma[1 + var]/var};
  (* Residue at z=0 (high-order pole — Series handles natively) *)
  res0 = Quiet@TimeConstrained[
    SeriesCoefficient[Series[mbS /. var -> wVar, {wVar, 0, 0}], -1],
    20, $TimedOut];
  If[res0 === $TimedOut, Return[$Failed]];
  (* Residue at z=n+w for n>=1 *)
  withW = mbS /. var -> sumVar + wVar;
  withW = withW //. {
    Csc[Pi (sumVar + wVar)]^k_. :> ((-1)^sumVar)^k Csc[Pi wVar]^k,
    Sin[Pi (sumVar + wVar)]^k_. :> ((-1)^sumVar)^k Sin[Pi wVar]^k};
  ser = Quiet@TimeConstrained[Series[withW, {wVar, 0, 0}], 20, $TimedOut];
  If[ser === $TimedOut, Return[$Failed]];
  resN = SeriesCoefficient[ser, -1] /. (-1)^(2 _) -> 1;
  resN = Expand[resN];
  (* Substitute ψ → HN at n+1 (so n>=0 in shifted gives original n>=1) *)
  shifted = resN /. sumVar -> sumVar + 1;
  shifted = shifted /. {
    PolyGamma[0, sumVar + 1] -> -EulerGamma + HarmonicNumber[sumVar],
    PolyGamma[1, sumVar + 1] -> Zeta[2] - HarmonicNumber[sumVar, 2],
    PolyGamma[2, sumVar + 1] -> -2 Zeta[3] + 2 HarmonicNumber[sumVar, 3],
    PolyGamma[3, sumVar + 1] -> 6 Zeta[4] - 6 HarmonicNumber[sumVar, 4],
    PolyGamma[0, 2 + sumVar] -> -EulerGamma + HarmonicNumber[sumVar + 1],
    PolyGamma[1, 2 + sumVar] -> Zeta[2] - HarmonicNumber[sumVar + 1, 2]};
  shifted = Expand[shifted];
  shifted = Apart[shifted, sumVar];
  shifted = Expand[shifted];
  (* Shift sumVar -> sumVar-1 to get 1/sumVar^k form *)
  shifted = shifted /. sumVar -> sumVar - 1;
  shifted = shifted //. {
    HarmonicNumber[sumVar - 1] -> HarmonicNumber[sumVar] - 1/sumVar,
    HarmonicNumber[sumVar - 1, p_Integer] :>
      HarmonicNumber[sumVar, p] - 1/sumVar^p};
  shifted = Expand[shifted];
  sExpr = shifted /. {
    HarmonicNumber[sumVar] :> HarmonicSums`S[1, sumVar],
    HarmonicNumber[sumVar, p_.] :> HarmonicSums`S[p, sumVar]};
  flat = mbeFlattenS[sExpr, sumVar];
  mapped = Catch[Module[{e = Expand[flat], terms},
    terms = If[Head[e] === Plus, List @@ e, {e}];
    Total[Map[Function[t, Module[{snums, snargs, rest, r2, npow, coef, mV},
      snums = Cases[t, HarmonicSums`S[__, sumVar], {0, Infinity}];
      If[Length[snums] > 1, Throw[$Failed]];
      rest = t /. (s_ /; MemberQ[snums, s]) :> 1;
      mV = Unique["mES"];
      r2 = rest /. sumVar -> mV;
      npow = -Exponent[r2, mV];
      coef = r2 /. mV -> 1;
      Which[
        npow >= 1 && Length[snums] == 1,
          snargs = Most[List @@ First[snums]];
          coef HarmonicSums`S[Sequence @@ Prepend[snargs, npow], Infinity],
        npow >= 2 && Length[snums] == 0,
          coef HarmonicSums`S[npow, Infinity],
        npow == 1 && Length[snums] == 0,
          coef HarmonicSums`SymDiv[1],
        npow <= 0, Throw[$Failed],
        True, t]]], terms]]]];
  If[mapped === $Failed, Return[$Failed]];
  closed = HarmonicSums`ReduceConstants[mapped,
    HarmonicSums`ToKnownConstants -> True];
  closed = closed /. {HarmonicSums`S[1, Infinity] -> 0,
                      HarmonicSums`SymDiv[_] -> 0,
                      HarmonicSums`S[k_Integer?(# >= 2 &), Infinity] :>
                        Zeta[k]};
  closed = closed /. s_Symbol /;
    StringMatchQ[SymbolName[s], RegularExpression["^z[2-8]$"]] :>
    Zeta[ToExpression[StringDrop[SymbolName[s], 1]]];
  -(res0 + closed)  (* MBSymbolicInt sign *)
];

mbeDetectPolygammas[expr_, mbVars_List] :=
  DeleteDuplicatesBy[
    Cases[expr, PolyGamma[m_Integer, arg_] /; !FreeQ[arg, Alternatives @@ mbVars] :>
      <|"Order" -> m, "Argument" -> arg|>, Infinity],
    {#["Order"], #["Argument"]} &];

(* Detect polygammas with multiplicity (counting PolyGamma[m,arg]^k as k). *)
mbeDetectPolygammasMult[expr_, mbVars_List] := Module[
  {powerOccs, marked, standaloneOccs, allOccs, grouped},
  powerOccs = Cases[expr,
    Power[PolyGamma[m_Integer, arg_], k_Integer?Positive] /;
      !FreeQ[arg, Alternatives @@ mbVars] :> {m, arg, k},
    {0, Infinity}];
  marked = expr /. Power[PolyGamma[m_Integer, arg_], k_Integer?Positive] :>
    mbePgPowerMarker;
  standaloneOccs = Cases[marked,
    PolyGamma[m_Integer, arg_] /; !FreeQ[arg, Alternatives @@ mbVars] :> {m, arg, 1},
    {0, Infinity}];
  allOccs = Join[powerOccs, standaloneOccs];
  grouped = GatherBy[allOccs, #[[1;;2]] &];
  Map[<|"Order" -> #[[1, 1]], "Argument" -> #[[1, 2]],
    "Multiplicity" -> Total[#[[All, 3]]]|> &, grouped]];

(* Replace each ψ(m, arg) occurrence (including powers) with elements from repls *)
mbeReplacePolyOccurrences[expr_, m_, arg_, repls_List] := Module[{count = 0, getRepl},
  getRepl[] := (count++; repls[[count]]);
  expr /. {
    HoldPattern[Power[PolyGamma[m, arg], k_Integer?Positive]] :> Product[getRepl[], {k}],
    HoldPattern[PolyGamma[m, arg]] :> getRepl[]
  }];

mbeContourRealPart[arg_, contourRules_, ass_:True] :=
  FullSimplify[ComplexExpand[Re[arg /. contourRules]], ass];

mbeShiftCount[arg_, contourRules_, ass_:True, max_:50] := Module[{rho, n = 0},
  rho = mbeContourRealPart[arg, contourRules, ass];
  While[!TrueQ[FullSimplify[rho + n > 0, ass]] && n < max, n++];
  If[n >= max, $Failed, n]];

mbePolygammaShiftCorrection[m_Integer, arg_, shiftN_Integer] :=
  If[shiftN == 0, 0,
    -(-1)^m * m! * Sum[1/(arg + k)^(m+1), {k, 0, shiftN-1}]];

(* Down-shift count: bring Re(arg) into (0,1] when Re(arg) > 1.
   Returns smallest N>=0 such that Re(arg-N) <= 1 (and >0 by assumption). *)
mbeDownShiftCount[arg_, contourRules_, ass_:True, max_:50] := Module[{rho, n = 0},
  rho = mbeContourRealPart[arg, contourRules, ass];
  If[!TrueQ[FullSimplify[rho > 1, ass]], Return[0]];
  While[!TrueQ[FullSimplify[rho - n <= 1, ass]] && n < max, n++];
  If[n >= max, 0, n]];

(* Correction when down-shifting ψ(m, arg) -> ψ(m, arg - N):
   ψ(m, arg) = ψ(m, arg - N) + (-1)^m m! Σ_{k=1..N} 1/(arg - k)^(m+1) *)
mbePolygammaDownShiftCorrection[m_Integer, arg_, downN_Integer] :=
  If[downN == 0, 0,
    (-1)^m * m! * Sum[1/(arg - k)^(m+1), {k, 1, downN}]];

(* ------------------------------------------------------------------
   Integral-representation expansion (analytic fallback for ψ^k cases
   where the standard per-occurrence-aux path fails at Block 5).

   For each ψ^(m)(arg)^k in `expr`, replace with k factors using
   the integral representation:
     m=0:   ψ(arg)         = -γ + ∫₀¹ (1 - t^(arg-1))/(1-t) dt
     m≥1:   ψ^(m)(arg)     = -∫₀¹ t^(arg-1) log^m(t)/(1-t) dt

   Each occurrence introduces its own t-variable (so ψ^k expands as a
   product of k independent integrals). The substituted integrand is
   then Expand'ed and split into a list of additive sub-MB-integrands,
   each of which is polygamma-free with at most one (∏tᵢ)^z factor in
   its z-dependence (handled natively by Block 4 as a c^z prefactor).
   The combinatorial blow-up is 3^k per ψ^(0)^k group (the -γ+1+(-t^(arg-1))
   split per occurrence) and 1 per ψ^(m)^k group with m≥1.
   ------------------------------------------------------------------ *)
mbeBuildIntegralRepSubintegrands[expr_, mbVars_List] := Module[
  {pgs, modExpr = expr, tVarsAll = {}, sVars, replacements,
   m, arg, mult, i, q, expanded, terms},
  pgs = mbeDetectPolygammasMult[expr, mbVars];
  If[pgs === {}, Return[<|"SubIntegrands" -> {expr}, "TVars" -> {}|>]];
  Do[
    m = pgs[[i]]["Order"]; arg = pgs[[i]]["Argument"]; mult = pgs[[i]]["Multiplicity"];
    sVars = Table[mbeNextPolygammaIntegralVar[], {mult}];
    tVarsAll = Join[tVarsAll, sVars];
    replacements = Table[
      If[m == 0,
        -EulerGamma + (1 - sVars[[q]]^(arg - 1))/(1 - sVars[[q]]),
        -sVars[[q]]^(arg - 1) * Log[sVars[[q]]]^m / (1 - sVars[[q]])
      ], {q, mult}];
    modExpr = mbeReplacePolyOccurrences[modExpr, m, arg, replacements],
    {i, Length[pgs]}];
  expanded = Expand[modExpr];
  terms = If[Head[expanded] === Plus, List @@ expanded, {expanded}];
  <|"SubIntegrands" -> terms, "TVars" -> tVarsAll|>];

(* ------------------------------------------------------------------
   mbeBuildShiftedIntegralRep -- substitute each PolyGamma[m, arg]
   in `expr` by:
     (i)  apply shift identity to bring Re(arg) into (0,1] on the
          contour (introducing rational correction)
     (ii) replace the shifted ψ^(m)(canonicalArg) by integral rep:
            m=0: -γ + (1 - s^(canonicalArg-1))/(1-s),   s ∈ (0,1)
            m≥1: -s^(canonicalArg-1) Log(s)^m/(1-s)
          one fresh s var per occurrence.
   Returns a SINGLE Expand'd expression (NOT split into sub-integrands)
   plus the list of cube vars. Used by the symbolic-residue branch
   to build the polygamma integral-representation cube integrand for
   cases where aux-mode Sum doesn't close (e.g. ψ⁰² products like
   PolyGamma[0,1+z]·PolyGamma[0,2+z]).
   ------------------------------------------------------------------ *)
mbeBuildShiftedIntegralRep[expr_, mbVars_List, contourRules_, ass_:True] := Module[
  {result = expr, pgs, pgs2, m, arg, mult, shiftN, downN, netShift,
   shiftedArg, correction, sVars, replacements, polyVars = {}, reArg},
  pgs = mbeDetectPolygammasMult[result, mbVars];
  (* Phase 1: apply shifts to bring every PolyGamma arg to Re>0 on contour *)
  Do[
    m = pgs[[i]]["Order"]; arg = pgs[[i]]["Argument"];
    shiftN = 0; downN = 0;
    If[contourRules =!= {},
      reArg = mbeContourRealPart[arg, contourRules, ass];
      If[!TrueQ[FullSimplify[reArg > 0, ass]],
        shiftN = mbeShiftCount[arg, contourRules, ass];
        If[shiftN === $Failed, shiftN = 0],
        downN = mbeDownShiftCount[arg, contourRules, ass]]];
    netShift = shiftN - downN;
    If[netShift =!= 0,
      shiftedArg = arg + netShift;
      correction = Which[
        shiftN > 0, mbePolygammaShiftCorrection[m, arg, shiftN],
        downN > 0, mbePolygammaDownShiftCorrection[m, arg, downN],
        True, 0];
      result = result /. PolyGamma[m, arg] :> PolyGamma[m, shiftedArg] + correction],
    {i, Length[pgs]}];
  result = Expand[result];
  (* Phase 2: substitute each remaining PolyGamma by integral rep *)
  pgs2 = mbeDetectPolygammasMult[result, mbVars];
  Do[
    m = pgs2[[i]]["Order"]; arg = pgs2[[i]]["Argument"]; mult = pgs2[[i]]["Multiplicity"];
    sVars = Table[mbeNextPolygammaIntegralVar[], {mult}];
    polyVars = Join[polyVars, sVars];
    replacements = Table[
      If[m == 0,
        -EulerGamma + (1 - sVars[[q]]^(arg-1))/(1 - sVars[[q]]),
        -sVars[[q]]^(arg-1) * Log[sVars[[q]]]^m / (1 - sVars[[q]])],
      {q, mult}];
    result = mbeReplacePolyOccurrences[result, m, arg, replacements],
    {i, Length[pgs2]}];
  <|"Integrand" -> Expand[result], "CubeVars" -> polyVars|>];

(* ------------------------------------------------------------------
   Degenerate repeated-Gamma preprocessing for MBtoEulerMellin.

   A repeated Γ[a+z]^n can collide with a Γ[b-z] leg at eps -> 0.  The
   ordinary Gamma->Beta route maps that double pole to a single Euler
   corner and loses the logarithmic content.  For this narrow case we
   split the repeated Γ by independent iota regulators, shift the
   degenerate +z legs upward, and represent every spawned 1/(a+z+k) by
   an extra Euler parameter before running the standard Blocks 1-8.
   ------------------------------------------------------------------ *)
mbePlusUnitArgQ[arg_, mbVar_, ass_:True] :=
  TrueQ[FullSimplify[Coefficient[Together[arg], mbVar] == 1, ass]];

mbeMinusUnitArgQ[arg_, mbVar_, ass_:True] :=
  TrueQ[FullSimplify[Coefficient[Together[arg], mbVar] == -1, ass]];

mbeDegeneratePairShiftOrder[arg_, rightArgs_List, mbVar_, epsSym_, iotas_List,
  ass_:True] := Module[{autoSyms, zeroRules, maxN = 0, s, s0, n},
  autoSyms = DeleteDuplicates@Cases[{arg, rightArgs},
    q_Symbol /; q =!= mbVar && !MemberQ[iotas, q] &&
      Context[q] =!= "System`" :> q, Infinity];
  zeroRules = DeleteDuplicates@Join[Thread[iotas -> 0],
    Thread[autoSyms -> 0], {epsSym -> 0}];
  Do[
    s = Quiet@FullSimplify[arg + r, ass];
    If[!FreeQ[s, mbVar], Continue[]];
    s0 = Quiet@FullSimplify[s /. zeroRules];
    If[IntegerQ[s0] && s0 <= 0,
      n = 1 - s0;
      If[n > maxN, maxN = n]],
    {r, rightArgs}];
  maxN];

(* Level of the +z Gamma's argument at eps->0, mbVar->0 (and any aux/iota->0).
   For Gamma[z+eps]^2 the level is 0 (MBpilot12/MBpilot13: standard MBtoEuler cube is
   FAITHFUL, its corner comes out c0<=-1 and BPHZ subtracts it cleanly); for
   Gamma[1+eps+z]^2 the level is 1 (res2/res4/res5: standard cube is UNFAITHFUL,
   the double pole collapses to a c0=0 corner that BPHZ misses, so the degenerate
   shift-trick route is genuinely required).  The degenerate route must fire ONLY
   for level >= 1 -- firing it on a level-0 (MBpilot12) squared Gamma produces an
   unfaithful (A+B)^(b eps) cube whose pole is silently dropped.
   (2026-07-01; fixes the MBpilot12/MBpilot13 regression while
   leaving res2/res4/res5 on the degenerate route.) *)
mbePositiveIntegerPlusLevelQ[arg_, mbVar_, epsSym_, iotas_List:{}, ass_:True] :=
  Module[{autoSyms, zeroRules, a0},
    autoSyms = DeleteDuplicates @ Cases[arg,
      q_Symbol /; q =!= mbVar && q =!= epsSym && ! MemberQ[iotas, q] &&
        Context[q] =!= "System`" :> q, Infinity];
    zeroRules = DeleteDuplicates @ Join[Thread[iotas -> 0],
      Thread[autoSyms -> 0], {epsSym -> 0, mbVar -> 0}];
    a0 = Quiet @ FullSimplify[arg /. zeroRules, ass];
    IntegerQ[a0] && a0 >= 1];

mbeNeedsDegenerateRepeatedGammaRoute[expr_, mbVars_List, epsSym_, ass_:True] :=
  If[Length[mbVars] =!= 1, False,
    Module[{mbVar = mbVars[[1]], gl, rightArgs, reps},
      gl = mbeTopLevelGammaList[expr];
      rightArgs = Cases[gl,
        {a_, s_} /; s > 0 && mbeMinusUnitArgQ[a, mbVar, ass] :> a];
      If[rightArgs === {}, Return[False]];
      reps = Cases[expr,
        Power[Gamma[a_], k_Integer?Positive] /;
          k >= 2 && mbePlusUnitArgQ[a, mbVar, ass] :> a,
        {0, Infinity}];
      AnyTrue[reps,
        mbePositiveIntegerPlusLevelQ[#, mbVar, epsSym, {}, ass] &&
        mbeDegeneratePairShiftOrder[#, rightArgs, mbVar, epsSym, {}, ass] > 0 &]]];

mbeSplitRepeatedPlusGammas[expr_, mbVar_, ass_:True] := Module[
  {iotas = {}, protected = {}, out},
  out = expr /. Power[Gamma[a_], k_Integer?Positive] /;
      k >= 2 && mbePlusUnitArgQ[a, mbVar, ass] :>
    Module[{ios = Table[mbeNextAux[], {k - 1}]},
      iotas = Join[iotas, ios];
      protected = Append[protected, a];
      Gamma[a] * Times @@ (Gamma[a + #] & /@ ios)];
  {out, iotas, protected}];

mbeBuildDegenerateRepeatedGammaRep[expr_, mbVars_List, contourRules_, epsSym_,
  ass_:True] := Module[
  {mbVar = mbVars[[1]], splitData, splitExpr, iotas, protectedArgs, gl,
   rightArgs, plusArgs, shiftInfo, current, intVars = {}, n, newVars},
  splitData = mbeSplitRepeatedPlusGammas[expr, mbVar, ass];
  splitExpr = splitData[[1]]; iotas = splitData[[2]];
  protectedArgs = splitData[[3]];
  gl = mbeTopLevelGammaList[splitExpr];
  rightArgs = DeleteDuplicates[Cases[gl,
    {a_, s_} /; s > 0 && mbeMinusUnitArgQ[a, mbVar, ass] :> a]];
  plusArgs = DeleteDuplicates[Cases[gl,
    {a_, s_} /; s > 0 && mbePlusUnitArgQ[a, mbVar, ass] :> a]];
  plusArgs = Select[plusArgs,
    Function[a, !AnyTrue[protectedArgs, mbeArgEqualQ[a, #, ass] &]]];
  shiftInfo = DeleteCases[
    Table[
      (* only shift a +z leg whose constant level is a positive integer (>=1);
         a level-0 leg (Gamma[z+eps]) belongs to the FAITHFUL standard cube and
         must NOT be shifted even if a sibling repeated Gamma triggered the route
         (2026-07-01 -- protects mixed residues). *)
      n = If[mbePositiveIntegerPlusLevelQ[a, mbVar, epsSym, iotas, ass],
        mbeDegeneratePairShiftOrder[a, rightArgs, mbVar, epsSym, iotas, ass], 0];
      If[n > 0, {a, n}, Nothing],
      {a, plusArgs}],
    Nothing];
  current = splitExpr;
  Do[
    newVars = Table[mbeNextPolygammaIntegralVar[], {si[[2]]}];
    intVars = Join[intVars, newVars];
    current = current /. HoldPattern[Gamma[a_] /;
        mbeArgEqualQ[a, si[[1]], ass]] :>
      Gamma[a + si[[2]]] *
        Product[newVars[[k + 1]]^(a + k - 1), {k, 0, si[[2]] - 1}],
    {si, shiftInfo}];
  Module[{changed = True, denArgs, constArgs, varArgs, hit, v},
    While[changed,
      changed = False;
      gl = mbeTopLevelGammaList[current];
      denArgs = Cases[gl,
        {d_, s_} /; s < 0 && mbePlusUnitArgQ[d, mbVar, ass] :> d];
      constArgs = Cases[gl,
        {c_, s_} /; s > 0 &&
          TrueQ[FullSimplify[Coefficient[Together[c], mbVar] == 0, ass]] :> c];
      varArgs = Cases[gl,
        {a_, s_} /; s > 0 && mbePlusUnitArgQ[a, mbVar, ass] :> a];
      hit = Catch[
        Do[
          Do[
            Do[
              If[mbeArgEqualQ[c + a, d, ass], Throw[{c, a, d}]],
              {a, varArgs}],
            {c, constArgs}],
          {d, denArgs}];
        None];
      If[hit =!= None,
        v = mbeNextPolygammaIntegralVar[];
        intVars = Append[intVars, v];
        current = Together[current *
          (v^(hit[[1]] - 1) * (1 - v)^(hit[[2]] - 1) *
            Gamma[hit[[3]]])/(Gamma[hit[[1]]] * Gamma[hit[[2]]])];
        changed = True]]];
  <|"Integrand" -> Expand[current], "IntegralVars" -> intVars,
    "Iotas" -> iotas, "ShiftInfo" -> shiftInfo|>];

mbeIotaConstantTerm[expr_, iotas_List] :=
  Fold[Quiet@Normal@Series[#1, {#2, 0, 0}] &, expr, iotas];

$mbeUseDegenerateGammaRoute = True;  (* leakproof/regression switch (2026-07-01):
  set False to force the standard MBtoEuler route (faithful for ordinary
  eps-regulated pinches like MBpilot12's Gamma[z+e]^2 * Gamma[-z]).  The degenerate
  route was added for res4/res5 but MISFIRES on MBpilot12 -> unfaithful 3-var cube. *)
mbeDegenerateRepeatedGammaEuler[integrand_, contourRules_, mbVars_List,
  epsSym_, epsBound_, ass_, opts:OptionsPattern[MBtoEuler]] := Module[
  {showSteps, verbose, maxShift, rep, auxAss, stream, cube, cubeVars},
  If[!TrueQ[$mbeUseDegenerateGammaRoute] ||
     !mbeNeedsDegenerateRepeatedGammaRoute[integrand, mbVars, epsSym, ass],
    Return[None]];
  showSteps = OptionValue["ShowSteps"];
  verbose = OptionValue["Verbose"];
  maxShift = OptionValue["MaxShift"];
  If[showSteps,
    Print["[MBtoEulerMellin] Degenerate repeated-Gamma preprocessing..."]];
  rep = mbeBuildDegenerateRepeatedGammaRep[integrand, mbVars, contourRules,
    epsSym, ass];
  auxAss = And @@ Join[{ass},
    Flatten@Table[{ii > 0, ii < epsBound}, {ii, rep["Iotas"]}],
    Flatten@Table[{0 < vv < 1}, {vv, rep["IntegralVars"]}]];
  stream = MBERunStream[rep["Integrand"], mbVars, contourRules, auxAss,
    "Verbose" -> verbose, "ShowSteps" -> showSteps, "MaxShift" -> maxShift];
  If[FailureQ[stream], Return[stream]];
  (* CJ takeover 2026-06-26: FullSimplify here is the slowness bottleneck and is
     unnecessary for the subtraction scheme; use fast Together instead. *)
  cube = Quiet@Together@
    mbeIotaConstantTerm[stream["CubeIntegrand"], rep["Iotas"]];
  cubeVars = Join[rep["IntegralVars"], stream["CubeVariables"]];
  <|"EulerIntegrands" -> {{cube, cubeVars}},
    "HasPolygamma" -> False,
    "Assumptions" -> ass,
    "PartA" -> <|"EulerIntegrand" -> cube, "CubeVariables" -> cubeVars,
      "CubeIntegrandBeforeLimit" -> stream["CubeIntegrand"],
      "Mode" -> "DegenerateRepeatedGamma", "Pipeline" -> stream["Pipeline"]|>,
    "PartB" -> {},
    "PartialResult" -> False,
    "PartAFailure" -> None,
    "PolygammaPreprocess" -> None,
    "DegenerateGammaPreprocess" -> rep|>];

(* ------------------------------------------------------------------
   Clean residual Abs[...] factors via numerical sign sampling.
   Block 7 emits 1/Abs[jacobian] whenever a delta-resolution Jacobian
   has a sign that isn't algebraically obvious. Simplify[..., 0<v<1]
   catches simple Abs[v_i] forms but fails on sums-of-products like
   Abs[-v1*v2 + (-1+v1)*v3]. This helper evaluates each Abs argument
   at ~8 random points in (0.05, 0.95)^n; if every sample has the same
   sign, drop Abs (with the appropriate sign). Otherwise leave Abs
   alone (genuinely sign-indeterminate). Cheap and surgical: only runs
   when Abs survives Simplify and only touches Abs subexpressions.
   ------------------------------------------------------------------ *)
mbeCleanAbsBySampling[expr_, cubeVars_List] := Module[
  {nSamples = 8, samples, replaceOne, cubeAss},
  If[FreeQ[expr, Abs] || cubeVars === {}, Return[expr]];
  (* ANALYTIC-FIRST sign resolution: PROVE Abs[arg] = +/-arg on the open cube
     (0,1)^n via Resolve[ForAll ...] (rigorous, not random sampling).  Needed for
     the 4-fold psi0^4 Bell sub-pieces whose Abs args random sampling left
     unresolved (e.g. Abs[(s1 s2(-1+t2)t2)/(s1 s2(-1+t2)-t2 u1)^2] is strictly
     negative on the cube -> -arg).  Falls back to sampling only if Resolve is
     inconclusive/times out. *)
  cubeAss = And @@ Join[Thread[cubeVars > 0], Thread[cubeVars < 1]];
  samples = Table[
    Thread[cubeVars -> RandomReal[{0.05, 0.95}, Length[cubeVars]]],
    {nSamples}];
  replaceOne[arg_] := Module[{vals, signs, tg = Together[arg]},
    If[TrueQ@Quiet@TimeConstrained[
        Resolve[ForAll[cubeVars, Implies[cubeAss, tg > 0]], Reals], 5, False],
      Return[arg]];
    If[TrueQ@Quiet@TimeConstrained[
        Resolve[ForAll[cubeVars, Implies[cubeAss, tg < 0]], Reals], 5, False],
      Return[-arg]];
    (* Localized Quiet for Power::indet/Infinity::indet:
       evaluating `arg` at random sample points can transiently hit
       0^0 / 0/0 sub-expressions on factors that symbolically simplify
       cleanly elsewhere. The AllTrue NumericQ check below already
       rejects samples that returned Indeterminate, so the message
       carries no useful signal here. Restricted to this helper only
       -- the rest of the pipeline still emits Power::indet so any
       genuine pathology (e.g. PLT fit-point silent zero) stays
       visible to the user. *)
    vals = Quiet[N[arg /. #] & /@ samples,
      {Power::indet, Infinity::indet, Power::infy, General::stop}];
    If[!AllTrue[vals, NumericQ[#] && Im[#] == 0 &], Return[Abs[arg]]];
    signs = Sign[vals];
    Which[
      AllTrue[signs, # > 0 &],  arg,
      AllTrue[signs, # < 0 &], -arg,
      True,                     Abs[arg]]];
  expr /. Abs[arg_] :> replaceOne[arg]];

(* ------------------------------------------------------------------
   BLOCK 1: Contour normalization
   ------------------------------------------------------------------ *)

mbeFactors[e_] := If[Head[e] === Times, List @@ e, {e}];

mbeScanGammaFactor[f_] := Which[
  MatchQ[f, Gamma[_]],                              {{First[f], +1}},
  MatchQ[f, Power[Gamma[_], n_Integer?Positive]],   Table[{First[f[[1]]], +1}, {f[[2]]}],
  MatchQ[f, Power[Gamma[_], n_Integer?Negative]],   Table[{First[f[[1]]], -1}, {-f[[2]]}],
  True, {}];

mbeTopLevelGammaList[expr_] :=
  Flatten[mbeScanGammaFactor /@ mbeFactors[Together[expr]], 1];

mbeArgEqualQ[a_, b_, ass_:True] :=
  TrueQ[PossibleZeroQ[FullSimplify[a - b, ass]]];

mbeNormalizeOneGamma[g_Gamma, contourRules_, ass_:True, max_:50] := Module[{arg = First[g], n},
  n = mbeShiftCount[arg, contourRules, ass, max];
  Which[n === $Failed || n === 0, g,
        True, Gamma[arg + n] / Pochhammer[arg, n]]];

(* ------------------------------------------------------------------
   BLOCK 2: Slope normalization (Gauss multiplication)
   ------------------------------------------------------------------ *)

mbeGaussExpandGamma[u_, m_Integer?Positive] /; m >= 2 :=
  (2 Pi)^((1-m)/2) * m^(m u - 1/2) * Times @@ Table[Gamma[u + r/m], {r, 0, m-1}];

mbeExtractOverallIntegerFactor[arg_, vars_List:{}] := Module[{a, fac, c, rest},
  a = Together[arg];
  If[vars =!= {} && FreeQ[a, Alternatives @@ vars], Return[None]];
  fac = FactorTermsList[a]; c = fac[[1]]; rest = Times @@ Rest[fac];
  If[!IntegerQ[c] || Abs[c] < 2, Return[None]];
  {Abs[c], If[c > 0, rest, -rest]}];

mbeNormalizeOneGammaSlope[g_Gamma, vars_List:{}] := Module[{arg = First[g], data},
  data = mbeExtractOverallIntegerFactor[arg, vars];
  If[data === None, g, mbeGaussExpandGamma[data[[2]], data[[1]]]]];

(* ------------------------------------------------------------------
   Pre-Block-4: Γ-shift simplification (handles Γ-ratios with integer
   negative c = a_den - a_num that Rule B cannot pair, plus polynomial
   absorption via (a)·Γ(a) = Γ(a+1)).
   ------------------------------------------------------------------ *)

mbeNonGammaPart[expr_] := expr /. Gamma[_] -> 1;

mbeLinearFactorsInPart[expr_, mbVars_List] := Module[{ng, fl},
  ng = expr /. Gamma[_] -> 1;
  fl = Quiet[FactorList[ng]];
  If[Head[fl] =!= List, Return[{}]];
  Select[fl[[All, 1]],
    Function[f, PolynomialQ[f, mbVars] &&
      !FreeQ[f, Alternatives @@ mbVars] &&
      And @@ (Exponent[Expand[f], #] <= 1 & /@ mbVars)]]];

(* v1.7 regression fix: scope-restricted to the pre-v1.1 case ONLY.
   The expanded scope (num/den c>0, num/num c>0/<0) introduced in v1.1
   over-absorbs \[CapitalGamma]s that Block 4's pair-matcher needs as candidates
   for the ε-symbolic MBtoEulerMellin path (MBpilot12, MB14 unresolved). It
   pre-merges \[CapitalGamma](z-\[Epsilon])/\[CapitalGamma](1+z-\[Epsilon]) into 1/(z-\[Epsilon]),
   leaving Block 4 no choice but to pair \[CapitalGamma](1-z) with \[CapitalGamma](1+z) (same-side
   Rule A) instead of the natural cross-pair \[CapitalGamma](1-z) \[LeftRightArrow] \[CapitalGamma](z-\[Epsilon]).
   The same-side pair forces an unrealizable Auxiliary-mode prefactor,
   producing Block5Failed.

   Restoring the conservative pre-v1.1 case keeps \[CapitalGamma](z-\[Epsilon]) available
   for Block 4. The ε-numeric MB14 sweep (111/111) and 6 F-family cases
   are unaffected. *)
mbeSimplifyOneIntegerShiftPair[expr_, mbVars_List, ass_] := Module[
  {gl, ai, aj, c, polyFactor, k, i, j, result = None},
  gl = mbeTopLevelGammaList[Together[expr]];
  Catch[
    Do[
      ai = gl[[i]];
      Do[
        aj = gl[[j]];
        If[ai[[2]] > 0 && aj[[2]] < 0,
          c = Quiet[Simplify[aj[[1]] - ai[[1]], ass]];
          If[IntegerQ[c] && c < 0,
            polyFactor = Product[aj[[1]] + k, {k, 0, -c - 1}];
            result = Together[expr * polyFactor * Gamma[aj[[1]]] / Gamma[ai[[1]]]];
            Throw[Null]]],
        {j, Length[gl]}],
      {i, Length[gl]}]];
  result];

mbeNormalizeGammaShifts[expr_, mbVars_List, ass_:True] := Module[
  {newExpr = expr, simplified, maxIters = 20, iter = 0},
  While[iter < maxIters,
    iter++;
    simplified = mbeSimplifyOneIntegerShiftPair[newExpr, mbVars, ass];
    If[simplified === None, Break[]];
    newExpr = simplified];
  newExpr];

mbeAbsorbOnePoly[expr_, mbVars_List, ass_] := Module[
  {together, num, polyFactorsInNum, gammaInNum, lf, matchedArg, candidate},
  together = Together[expr];
  num = Numerator[together];
  polyFactorsInNum = mbeLinearFactorsInPart[num, mbVars];
  gammaInNum = Cases[num, Gamma[a_] :> a, {0, Infinity}] // DeleteDuplicates;
  Catch[
    Do[
      matchedArg = SelectFirst[gammaInNum,
        TrueQ[Quiet[Simplify[# - lf, ass]] === 0] &, None];
      If[matchedArg =!= None,
        candidate = Together[expr * Gamma[matchedArg + 1] / (matchedArg * Gamma[matchedArg])];
        Throw[candidate]],
      {lf, polyFactorsInNum}];
    None]];

mbeAbsorbPolyIntoGamma[expr_, mbVars_List, ass_:True] := Module[
  {newExpr = expr, absorbed, maxIters = 20, iter = 0},
  While[iter < maxIters,
    iter++;
    absorbed = mbeAbsorbOnePoly[newExpr, mbVars, ass];
    If[absorbed === None, Break[]];
    newExpr = absorbed];
  newExpr];

(* ------------------------------------------------------------------
   Pre-Block-4 fix: break zero-sum (or non-positive-integer-sum)
   numerator Γ pairs.

   When two top-level numerator Γ factors Γ(a) and Γ(b) satisfy
       a + b ∈ {0, -1, -2, ...}
   identically in z (as symbolic expressions, not contour-dependent),
   Block 4 sees them as a Beta candidate B(a, b) = Γ(a) Γ(b) / Γ(a+b).
   But Γ(a+b) = Γ(non-positive-integer) is divergent, so forming the
   Beta drops a hidden 1/Γ(0) = 0 factor and silently zeroes-out (or
   numerically distorts) the cube integrand.

   The fix lifts one of the Γ arguments by N = 1 - (a+b) integer steps
   via the recursion Γ(a) = Γ(a + N) / Pochhammer(a, N).  After the
   lift the pair sum is exactly 1 -- a valid Beta argument set -- and
   the rational prefactor 1/Pochhammer(a, N) goes into Block 5's
   nonGammaPart (handled by Auxiliary-mode linear-form decomposition).

   Example: Γ(-z)·Γ(z) (sum = 0) → -Γ(1-z)·Γ(z) / z (sum = 1, clean
   Beta; prefactor -1/z absorbed by Block 5).
   ------------------------------------------------------------------ *)
mbeIsNonPosIntQ[s_] := IntegerQ[s] && TrueQ[s <= 0];

mbeFindZeroSumPair[expr_, mbVars_List, ass_:True] := Module[
  {gl, n, i, j, ai, aj, sumExpr},
  gl = mbeTopLevelGammaList[expr];
  n = Length[gl];
  Catch[
    Do[
      ai = gl[[i]];
      Do[
        aj = gl[[j]];
        (* both Γs in numerator (sign +1) *)
        If[ai[[2]] > 0 && aj[[2]] > 0,
          sumExpr = Quiet@FullSimplify[ai[[1]] + aj[[1]], ass];
          If[mbeIsNonPosIntQ[sumExpr],
            (* Found a problematic pair. Lift ai's Γ by N = 1 - sum so
               that the new pair sum becomes exactly 1. Choose to lift
               ai (the earlier of the two in the Γ list) so the
               partner aj is preserved. *)
            Throw[{ai[[1]], aj[[1]], 1 - sumExpr}]]],
        {j, i + 1, n}],
      {i, n}];
    None]];

mbeLiftOneGammaArg[expr_, argToLift_, lN_Integer?Positive, ass_:True] :=
  expr /. {
    Power[Gamma[a_], k_Integer?Positive] /;
      TrueQ[PossibleZeroQ@Quiet@FullSimplify[a - argToLift, ass]] && k >= 2 :>
        Gamma[a]^(k - 1) * Gamma[a + lN] / Pochhammer[a, lN],
    Gamma[a_] /;
      TrueQ[PossibleZeroQ@Quiet@FullSimplify[a - argToLift, ass]] :>
        Gamma[a + lN] / Pochhammer[a, lN]
  };

mbeBreakZeroSumPairs[expr_, mbVars_List, ass_:True] := Module[
  {current = Together[expr], info, next, iter = 0, maxIter = 20},
  While[iter < maxIter,
    iter++;
    info = mbeFindZeroSumPair[current, mbVars, ass];
    If[info === None, Break[]];
    next = mbeLiftOneGammaArg[current, info[[1]], info[[3]], ass];
    next = Together[next];
    (* Safety: if the substitution didn't actually change the
       expression (e.g., the Γ arg couldn't be uniquely matched), stop
       to avoid an infinite loop. *)
    If[TrueQ[PossibleZeroQ[next - current]], Break[]];
    current = next];
  current];

mbeSimplifyGammaStructure[expr_, mbVars_List, ass_:True] := Module[{e},
  e = mbeNormalizeGammaShifts[expr, mbVars, ass];
  e = mbeAbsorbPolyIntoGamma[e, mbVars, ass];
  e];

(* ------------------------------------------------------------------
   BLOCK 3: Balance check
   ------------------------------------------------------------------ *)

mbeArgDependsOnVarQ[arg_, var_, ass_:True] :=
  !TrueQ[FullSimplify[Coefficient[Together[arg], var], ass] == 0];

mbeArgSupportCount[arg_, vars_List, ass_:True] :=
  Count[vars, v_ /; mbeArgDependsOnVarQ[arg, v, ass]];

mbeVariableBalanceReport[expr_, var_, ass_:True] := Module[
  {gl, classified, plusTerms, minusTerms, unsupportedTerms, plusCount, minusCount},
  gl = mbeTopLevelGammaList[expr];
  classified = Table[
    With[{arg = gl[[i,1]], sgn = gl[[i,2]],
          c = FullSimplify[Coefficient[Together[gl[[i,1]]], var], ass]},
      <|"Arg" -> arg, "Sign" -> sgn, "Coeff" -> c|>],
    {i, Length[gl]}];
  plusTerms  = Select[classified, TrueQ[#["Coeff"] ==  1] &];
  minusTerms = Select[classified, TrueQ[#["Coeff"] == -1] &];
  unsupportedTerms = Select[classified,
    !TrueQ[#["Coeff"] == 1] && !TrueQ[#["Coeff"] == -1] && !TrueQ[#["Coeff"] == 0] &];
  plusCount  = Total[Lookup[plusTerms,  "Sign", {}]];
  minusCount = Total[Lookup[minusTerms, "Sign", {}]];
  <|"Variable" -> var,
    "PlusCount" -> plusCount, "MinusCount" -> minusCount,
    "BalancedQ" -> TrueQ@FullSimplify[plusCount == minusCount, ass],
    "UnitSlopeOnlyQ" -> (unsupportedTerms === {}),
    "PlusTerms" -> plusTerms, "MinusTerms" -> minusTerms,
    "UnsupportedTerms" -> unsupportedTerms|>];

(* ------------------------------------------------------------------
   BLOCK 4: Gamma -> Beta
   ------------------------------------------------------------------ *)

(* mbeNonGammaPart defined in Pre-Block-4 helpers section *)

mbeUnitGammaListNet[gl_List, ass_:True] := Module[{groups = {}, pos},
  Do[
    pos = SelectFirst[Range[Length[groups]],
      mbeArgEqualQ[gl[[i,1]], groups[[#,1,1]], ass] &, Missing[]];
    If[pos === Missing[], AppendTo[groups, {gl[[i]]}],
      groups[[pos]] = Append[groups[[pos]], gl[[i]]]],
    {i, Length[gl]}];
  Select[Table[{groups[[i,1,1]], Total[groups[[i,All,2]]]}, {i, Length[groups]}],
    #[[2]] =!= 0 &]];

mbeGammaListToProduct[gl_List] := Times @@ (Gamma[#[[1]]]^#[[2]] & /@ gl);
mbeBetaPairsToProduct[bl_List] := Times @@ (Beta[#[[1]], #[[2]]] & /@ bl);

(* ============================================================
   Tier 3a (v1.3): Gauss multiplication formula preprocessor.

   Goal: eliminate non-unit MB-variable coefficients in Γ-args
   before Block 4 pair-matching.

   Identity (Gauss multiplication formula):
     Γ(nz + b) = (2π)^((1-n)/2) · n^(nz+b-1/2) ·
                 Π_{k=0..n-1} Γ(z + (b+k)/n)
   For negative n (|n|≥2) the same identity applies with z→-z.

   Limitations:
     * Only fires when the Γ-arg is LINEAR in mbVar with INTEGER
       coefficient |c| ≥ 2 and the residual (arg - c·mbVar) is FREE
       of mbVar (Γ-arg must be linear in that var, not quadratic).
     * Iterates over MB vars; multi-var args with mixed non-unit
       coefficients (e.g., Γ(2z+3w+a)) will leave fractional
       coefficients on the OTHER vars after rewriting (handled
       further iterations if any var ends with integer |c|≥2,
       otherwise passed through with no harm).
   ============================================================ *)

mbeGaussMultFormulaOne[gammaArg_, mbVar_Symbol] := Module[
  {n, absN, sgnN, b, k},
  n = Coefficient[gammaArg, mbVar];
  If[!IntegerQ[n] || Abs[n] < 2, Return[$Failed]];
  b = gammaArg - n * mbVar;
  If[!FreeQ[b, mbVar], Return[$Failed]];   (* arg must be linear in mbVar *)
  absN = Abs[n]; sgnN = Sign[n];
  (2 Pi)^((1 - absN)/2) * absN^(n * mbVar + b - 1/2) *
    Product[Gamma[sgnN * mbVar + (b + k)/absN], {k, 0, absN - 1}]];

mbeApplyMultiplicationFormula[expr_, mbVars_List] := Module[
  {result = expr, anyRewrittenThisPass = True, iter = 0,
   maxIter = 5, nRewrittenTotal = 0, rewrittenArgs = {}},
  While[anyRewrittenThisPass && iter < maxIter,
    anyRewrittenThisPass = False; iter++;
    Do[
      Module[{gs, rules},
        gs = DeleteDuplicates@Cases[result,
          Gamma[a_] /; Module[{c = Coefficient[a, v]},
            IntegerQ[c] && Abs[c] >= 2 && FreeQ[a - c v, v]],
          Infinity];
        If[gs =!= {},
          anyRewrittenThisPass = True;
          rules = Map[Function[g, g -> mbeGaussMultFormulaOne[g[[1]], v]], gs];
          rules = Select[rules, MatchQ[#[[2]], _Times | _Power | _Plus] || NumericQ[#[[2]]] &];
          nRewrittenTotal += Length[rules];
          rewrittenArgs = Join[rewrittenArgs, gs[[All, 1]]];
          result = result /. rules]],
      {v, mbVars}]];
  If[nRewrittenTotal > 0,
    Print["[Tier 3a] Gauss multiplication formula applied to ",
      nRewrittenTotal, " \[CapitalGamma]-factor(s): ",
      DeleteDuplicates[rewrittenArgs]]];
  result];

(* ============================================================
   Tier 3b (v1.4): Contour rescaling for fractional MB-variable
   coefficients in \[CapitalGamma]-args.

   Strategy: for each MB variable v, collect the coefficients of v
   across all \[CapitalGamma]-args that are linear in v. If any coefficient is
   a non-integer rational (e.g. 1/2, 1/3, 3/2), compute LCM of all
   the denominators. Substitute v -> LCM*v throughout the integrand
   (which clears the fractions) and divide the contour rule by LCM
   (matching the variable change). The Jacobian factor LCM is folded
   into the integrand.

   After Tier 3b runs, all linear-in-v \[CapitalGamma]-coefficients are integers.
   Tier 3a then handles any |c|>=2 cases.

   Returns: {newIntegrand, newContourRules}.
   ============================================================ *)

mbeApplyContourRescale[integrand_, contourRules_, mbVars_List] := Module[
  {newIntegrand = integrand, newContour = contourRules, appliedRescales = {}},
  Do[
    Module[{gammaCoefs, fracCoefs, denoms, lcd},
      gammaCoefs = DeleteCases[
        Cases[newIntegrand,
          Gamma[a_] :> Module[{c = Coefficient[a, v]},
            If[FreeQ[a - c v, v] && c =!= 0, c, Null]],
          Infinity],
        Null];
      fracCoefs = Select[gammaCoefs,
        Element[#, Rationals] && ! IntegerQ[#] &];
      If[fracCoefs === {}, Continue[]];
      denoms = Denominator /@ fracCoefs;
      lcd = LCM @@ denoms;
      If[lcd <= 1, Continue[]];
      newIntegrand = lcd * (newIntegrand /. v -> lcd * v);
      newContour = newContour /. (v -> c_) :> (v -> c/lcd);
      AppendTo[appliedRescales, {v, lcd}]],
    {v, mbVars}];
  If[appliedRescales =!= {},
    Print["[Tier 3b] Contour rescaled (var, factor): ", appliedRescales]];
  {newIntegrand, newContour}];

(* ============================================================
   Tier 4 (v1.5): symbolic-aware "high-order Power" predicate.

   Replaces the brittle `TrueQ[Power >= 2]` test in the Tier-1
   auxForm detector. That test returns False whenever Power is
   symbolic (e.g. 1+\[Epsilon] before \[Epsilon]-expansion), which silently
   suppresses pole-order detection on symbolic-\[Epsilon] integrands.

   Decision logic:
     1) If Power evaluates to a concrete numeric inequality
        (Power >= 2 reduces to True or False), use that.
     2) Otherwise extract the integer/numeric part of Power by
        replacing every non-numeric subterm with 0. If that
        evaluates numerically, compare to 2.
     3) Otherwise (genuinely opaque symbolic Power), default to
        True -- conservative: route through Path B/B' which can
        handle arbitrary-order residues correctly.
   ============================================================ *)

mbeIsHighOrderPower[p_] := Module[{intCand},
  Which[
    TrueQ[p >= 2], True,
    TrueQ[p < 2], False,
    True,
      intCand = p /. {sym_ /; ! NumericQ[sym] :> 0};
      intCand = Simplify[intCand];
      If[NumericQ[intCand], intCand >= 2, True]]];

(* ============================================================
   Boundary-resolution pipeline (v1.8).

   Given a parametric cube integrand carrying factors
   u^(-n + \[Beta]\[Epsilon]) at u=0 (or (1-u)^(-n + \[Beta]\[Epsilon]) at u=1)
   with integer n>=1, the per-coefficient \[Epsilon]-expansion is
   ill-defined: the n-th order plus distribution needs to be
   handled analytically before Series can be safely applied.

   We use the subtraction identity (extension of the
   single-subtraction "minus average" scheme to arbitrary n):

     \[Integral][0,1] u^(-n+\[Beta]\[Epsilon]) F(u) du
       = \[Integral][0,1] u^(-n+\[Beta]\[Epsilon])
           ( F(u) - Sum_{i=0..n-1} u^i F^(i)(0) / i! ) du
       +   Sum_{i=0..n-1} F^(i)(0) / ( i! ( i+1-n+\[Beta]\[Epsilon] ) ) .

   The subtracted integrand vanishes like u^n at the boundary and is
   safely \[Epsilon]-expandable. Each counter-term has an analytic 1/\[Epsilon]-
   structure and is integrated by hand. Same story at u=1 with the
   sign factor (-1)^i.

   Functions:
     * mbeDetectBoundarySingularity[expr, cubeVars, \[Epsilon]]
         -> {var, point, n, \[Beta]} or None
     * mbeApplyBoundarySubtraction[expr, sing, \[Epsilon], assumptions]
         -> <|"Subtracted" -> ..., "Counters" -> {{Integrand, CounterVar},...}|>
     * mbeResolveAllBoundaries[expr, cubeVars, \[Epsilon]]
         iterates detect/subtract until clean; returns a piece list.

   Built on top of these in Public2:  MBresolveToMPL .
   ============================================================ *)

(* mbeNormalizeEulerForm (v2.0, 2026-06-05 — recipe per §13.1(a) of
   MBSymbolicInt_fixes_notes.tex). MBtoEulerMellin produces compact forms like
   ((1-t[1]) t[1] (1-t[3]))^(-1-eps) where multiple cube-variable factors
   are buried inside a single Power's base. The naive Cases-based
   detector matches only Power[v, e] with v a single cube variable, so
   it misses every singularity wrapped in such a compound base.
   This normalizer:
     1. Splits Power[Times[fs...], e] -> Prod_i Power[f_i, e]  (PowerExpand
        in the analytic sense; safe for positive real cube vars).
     2. Flattens Power[Power[b, e1], e2] -> Power[b, e1 e2].
     3. Reorients (-1+v)^e -> (-1)^e (1-v)^e so the (1-v) detector matches.
     4. Pulls Power[-x, e] -> (-1)^e Power[x, e] so an outer minus sign
        on a single Power-Times base is also distributed.

   The (-1)^e factors are constants in the cube variables and contribute
   only ε-dependent phases (handled correctly by the downstream Series
   in eps + Euler2MPL pipeline).

   NOTE: cube variables can be indexed forms like t[1], t[2], ..., not
   bare Symbols. Match against the supplied cubeVars list explicitly
   instead of v_Symbol. *)
(* ported wholesale from MBSymbolicInt_v1.11_BPHZ.m on 2026-06-05.
   Replaces experiment2's iterative-recursive + skipList multi-variable
   IE attempt. The v1.11 design is architecturally superior:
   Phase-1 BPHZ subtraction operates on the original integrand (no
   intermediate-bulk pollution), and Phase-2 recursion handles inherited
   boundaries on the reduced cube of each counter-term. *)
(* Phase convention switch (2026-06-05).
   $mbePhaseConvention controls how (-1)^(c+βε) factors are handled
   during normalization:
     "Keep" (default) : preserve as (-1)^(c+βε), Series-expandable in eps,
                        gives MBintegrate-style answer (carries phases
                        through to higher eps orders). User's stated
                        preference to enable cross-check with MB.m
                        MBintegrate at every step.
     "Drop"           : replace (-1)^(c+βε) by 1, matches v1.11_BPHZ.m
                        residue-sum convention. Gives standard-route-
                        compatible answer at all eps orders for phase-
                        free integrands (MBpilot12), and at NEGATIVE orders
                        for phase-bearing integrands (MBpilot13). At eps^0 and
                        above on phase-bearing pieces, Keep and Drop
                        diverge — both are mathematically meaningful but
                        in different conventions.
     "Scalarized"     : replace (-1)^(c+βε) by its integer parity (-1)^c
                        when c is an integer.  This keeps residue signs but
                        does not carry regulator/MB phases into the Euler
                        cube subtraction.
   The Block[{$mbePhaseConvention = "Keep"}, MBresolveToMPL[...]] idiom
   lets users select per-call without changing the package state.

   DEFAULT changed 2026-06-05 (Round 3 autonomous): "Drop" now default
   because (a) it agrees with standard route at all eps orders for MBpilot12
   (4/4 PASS exact), and matches standard route at all NEGATIVE eps
   orders for MBpilot13 (the orders that physically interest the user), and
   (b) it's 3.3x faster than "Keep" on MBpilot13 (the (-1)^(αε) factors that
   "Keep" preserves Series-expand into spurious π³, π⁴, π⁵ contributions
   that explode at higher orders and inflate intermediate integrand
   leaf counts dramatically). Earlier experiment2 had "Keep" default per
   stated user preference "agree with MBintegrate" — but empirically
   neither convention matches MBintegrate's reported {+98.67, +371.16,
   +1983} on MBpilot13, while "Drop" matches std-route residue-sum exactly
   at neg orders. *)
$mbePhaseConvention = "Drop";

mbeScalarizedMinusOnePower[e_, eps_] := Module[{e0},
  e0 = Quiet @ FullSimplify[e /. eps -> 0];
  If[IntegerQ[e0] || TrueQ[Element[e0, Integers]], (-1)^e0, 1]];

mbeNormalizeEulerForm[expr_, cubeVars_List, eps_] := Module[
  {altCube, ex, phaseConvention, keepPhase, scalarPhase},
  altCube   = Alternatives @@ cubeVars;
  phaseConvention = ToString[$mbePhaseConvention];
  keepPhase = StringMatchQ[phaseConvention, "Keep", IgnoreCase -> True];
  scalarPhase = StringMatchQ[phaseConvention, "Scalarized", IgnoreCase -> True];
  ex = expr //. {
    HoldPattern[Power[Power[b_, e1_], e2_]] :> Power[b, e1 e2],
    HoldPattern[Power[Times[fs__], e_]] /; ! FreeQ[{fs}, altCube]
      :> Times @@ (Power[#, e] & /@ List[fs])
  };
  ex = ex //. If[keepPhase,
    {(* Phase-KEEP rules: preserve (-1)^e factors. *)
     HoldPattern[Power[Plus[-1, v_], e_]] /;
         MemberQ[cubeVars, v] && ! FreeQ[e, eps]
       :> (-1)^e Power[1 - v, e],
     HoldPattern[Power[Plus[v_, -1], e_]] /;
         MemberQ[cubeVars, v] && ! FreeQ[e, eps]
       :> (-1)^e Power[1 - v, e],
     HoldPattern[Power[Times[-1, x_], e_]] /; ! FreeQ[x, altCube]
       :> (-1)^e Power[x, e]},
    If[scalarPhase,
      {(* Phase-SCALARIZED rules: keep integer parity, strip regulator
          phase.  This is the subtraction-route convention. *)
       HoldPattern[Power[Plus[-1, v_], e_]] /;
           MemberQ[cubeVars, v] && ! FreeQ[e, eps]
         :> mbeScalarizedMinusOnePower[e, eps] Power[1 - v, e],
       HoldPattern[Power[Plus[v_, -1], e_]] /;
           MemberQ[cubeVars, v] && ! FreeQ[e, eps]
         :> mbeScalarizedMinusOnePower[e, eps] Power[1 - v, e],
       HoldPattern[Power[-1, e_]] /; ! FreeQ[e, eps]
         :> mbeScalarizedMinusOnePower[e, eps]},
      {(* Phase-DROP rules: discard (-1)^e factors (treat as 1 at
          integer poles, residue-sum convention, v1.11 compatible). *)
       HoldPattern[Power[Plus[-1, v_], e_]] /;
           MemberQ[cubeVars, v] && ! FreeQ[e, eps]
         :> Power[1 - v, e],
       HoldPattern[Power[Plus[v_, -1], e_]] /;
           MemberQ[cubeVars, v] && ! FreeQ[e, eps]
         :> Power[1 - v, e],
       HoldPattern[Power[-1, e_]] /; ! FreeQ[e, eps]
         :> 1}]];
  (* Combine residual (-1+v_) × (1-v_)^e siblings. *)
  ex //. HoldPattern[Times[(-1 + v_), Power[1 - v_, e_], rest___]] /;
            MemberQ[cubeVars, v] :>
    Times[-Power[1 - v, e + 1], rest]];

mbeDetectBoundarySingularity[expr_, cubeVars_List, eps_] := Module[
  {cands},
  cands = mbeDetectAllBoundarySingularities[expr, cubeVars, eps];
  If[cands === {}, None, First @ SortBy[cands, -#[[3]] &]]];

(* Return ALL distinct boundary singularities (one per (var, point)
   pair) sorted by descending pole order.  Used by Phase 1 of
   mbeResolveAllBoundaries to enumerate every boundary up front. *)
mbeDetectAllBoundarySingularities[expr_, cubeVars_List, eps_] := Module[
  {exprN, raw, grouped, cands},
  exprN = mbeNormalizeEulerForm[expr, cubeVars, eps];
  raw = Flatten[Table[
     Join[
       Cases[exprN, (Power[b_, e_] /; SameQ[b, v]) :> {v, 0, e},
         Infinity],
       Cases[exprN, (Power[b_, e_] /; SameQ[Expand[b], 1 - v]) :>
         {v, 1, e}, Infinity]],
     {v, cubeVars}], 1];
  grouped = GatherBy[raw, #[[{1, 2}]] &];
  cands = Cases[
    Map[Module[{var = #[[1, 1]], point = #[[1, 2]], exp, c0, b0},
        exp = Together[Total[#[[All, 3]]]];
        c0 = Quiet @ FullSimplify[Coefficient[exp, eps, 0]];
        b0 = Quiet @ FullSimplify[Coefficient[exp, eps, 1]];
        If[IntegerQ[c0] && c0 <= -1, {var, point, -c0, b0}, Nothing]] &,
      grouped],
    {_Symbol, 0 | 1, _Integer, _}];
  SortBy[cands, -#[[3]] &]];

mbeEndpointPower[var_, point_, nOrd_, beta_, eps_] :=
  If[point === 0, var, 1 - var]^(-nOrd + beta eps);

mbeBoundaryMoment[var_, point_, i_, nOrd_, beta_, eps_] :=
  If[point === 0, 1, (-1)^i] / (i + 1 - nOrd + beta eps);

mbeCompatibleBoundarySubsets[sings_List] :=
  Select[Rest[Subsets[Range[Length[sings]]]],
    DuplicateFreeQ[sings[[#, 1]]] &];

mbeTaylorCoeffAt[expr_, vars_List, points_List, multi_List] := Module[
  {deriv, rules, val},
  deriv = Fold[D[#1, {#2[[1]], #2[[2]]}] &, expr,
    Transpose[{vars, multi}]];
  rules = Thread[vars -> points];
  val = Quiet[deriv /. rules];
  If[FreeQ[val, Indeterminate | ComplexInfinity | DirectedInfinity[_] | Infinity],
    val/Times @@ (Factorial /@ multi),
    Quiet[Fold[Limit[#1, #2[[1]] -> #2[[2]]] &, deriv,
       Transpose[{vars, points}]]/Times @@ (Factorial /@ multi)]]];

mbeTensorTaylorProjector[expr_, sings_List, eps_] := Module[
  {vars = sings[[All, 1]], points = sings[[All, 2]],
   orders = sings[[All, 3]], multi, terms},
  multi = Tuples[Table[Range[0, n - 1], {n, orders}]];
  terms = Table[
    With[{coef = mbeTaylorCoeffAt[expr, vars, points, mi]},
      If[PossibleZeroQ[coef], 0,
        coef * Product[(vars[[j]] - points[[j]])^mi[[j]],
          {j, Length[vars]}]]],
    {mi, multi}];
  Total[terms]];

mbeTensorIntegratedProjector[expr_, sings_List, eps_] := Module[
  {vars = sings[[All, 1]], points = sings[[All, 2]],
   orders = sings[[All, 3]], betas = sings[[All, 4]], multi, terms},
  multi = Tuples[Table[Range[0, n - 1], {n, orders}]];
  terms = Table[
    With[{coef = mbeTaylorCoeffAt[expr, vars, points, mi]},
      If[PossibleZeroQ[coef], 0,
        coef * Product[
          mbeBoundaryMoment[vars[[j]], points[[j]], mi[[j]],
            orders[[j]], betas[[j]], eps],
          {j, Length[vars]}]]],
    {mi, multi}];
  Total[terms]];

mbeApplyBoundarySubtraction[integrand_, sing_, eps_, ass_] := Module[
  {var, point, nOrd, beta, gFun, R, taylorCoefs, subTerm, subtracted, ctrs},
  {var, point, nOrd, beta} = sing;
  gFun = If[point === 0, var, 1 - var]^(-nOrd + beta eps);
  R = integrand / gFun;
  (* Light algebra only: Limit + division by factorial. NO heavy Simplify. *)
  taylorCoefs = Table[
    Quiet @ Limit[D[R, {var, i}], var -> point] / Factorial[i],
    {i, 0, nOrd - 1}];
  subTerm = Sum[(var - point)^i * taylorCoefs[[i + 1]], {i, 0, nOrd - 1}];
  subtracted = integrand - gFun * subTerm;
  ctrs = Table[
    <|"Integrand" -> If[point === 0, 1, (-1)^i] * taylorCoefs[[i + 1]] /
                     (i + 1 - nOrd + beta eps),
      "CounterVar" -> var|>,
    {i, 0, nOrd - 1}];
  <|"Subtracted" -> subtracted, "Counters" -> ctrs|>];

(* ============================================================
   Round 8 (2026-06-05) — Hepp sector decomposition for
   overlapping corner singularities.

   For pieces where a polynomial factor P(u_i1, ..., u_ir)^(c+βε)
   with c ≤ -1 vanishes at a corner of the cube (multiple axis-
   aligned boundaries hit simultaneously), the axis-aligned BPHZ
   detector misses the divergence.  We apply Heinrich's iterated
   sector decomposition (Hepp/Speer):

   Given an overlapping corner singularity at
       {u_i1 → p_1, u_i2 → p_2, ..., u_ir → p_r}
   define "small variables" s_j := u_ij if p_j = 0 else 1 - u_ij.

   Split the cube into r subsectors S_1, ..., S_r where in S_k the
   small variable s_k is the LARGEST among {s_j}.  In sector S_k,
   rescale s_j = s_k · t_j for j ≠ k (t_j ∈ [0,1]).  The Jacobian
   is s_k^(r-1).  By construction P factorises as s_k^? × regular
   in the subsector, so the divergence is now AXIS-ALIGNED at
   s_k = 0 and 1-D Taylor subtraction handles it.

   For MB14 Piece#3 the offending factor
       (1 + (-1+u_2)·u_4)^(-1-2ε)
   vanishes at (u_2, u_4) = (0, 1).  After substituting v_4 = 1-u_4
   this is (u_2 + v_4 - u_2 v_4)^(-1-2ε), vanishing at (0,0).
   Two subsectors:
     Sector A (u_2 ≥ v_4): v_4 = u_2 t  → factor = u_2^(-1-2ε)
       (1+t-u_2 t)^(-1-2ε) × u_2 (Jacobian) → u_2^(-2ε) × regular
     Sector B (v_4 ≥ u_2): u_2 = v_4 s  → v_4^(-2ε) × regular
   ============================================================ *)

(* Maximum recursion depth for the sector decomposition.

   Compound bases such as s + u v need more than one primary Hepp split:
   after the first split one sector still contains a lower-dimensional
   compound corner.  Keep this bounded, but allow that recursive cleanup. *)
$mbeHeppMaxDepth = 3;

(* Round 8c — disable the Hepp sector-decomposition INVOCATION inside
   mbeResolveAllBoundaries.  Detection still runs (so MBresolveToMPL
   can route corner-sing pieces to its std-route fallback) but the
   decomposition itself does not fire — the BPHZ pipeline integration
   would not be able to handle the resulting compound integrands. *)
$mbeHeppDecompEnabled = False;

(* Track current depth via a dynamically-scoped variable. *)
$mbeHeppCurrentDepth = 0;

(* Lightweight certification counters, reset per MBresolveToMPL call. *)
$mbeHeppSectorCount = 0;
$mbeHeppLiftedTermCount = 0;

(* Cap on the number of variables we consider for corner detection.
   Subsets[varsInBase, {2, K}] is combinatorial; large K explodes. *)
$mbeHeppMaxCornerSize = 3;

mbeFindCornerSingularities[normExpr_, cubeVars_List, eps_] := Module[
  {epsCases, cornerSings = {}, kMax},
  If[$mbeHeppCurrentDepth >= $mbeHeppMaxDepth, Return[{}]];
  kMax = Min[$mbeHeppMaxCornerSize, Length[cubeVars]];
  If[kMax < 2, Return[{}]];
  epsCases = Cases[normExpr,
    Power[base_, exp_] /;
      (! FreeQ[exp, eps] &&
       With[{c0 = Coefficient[exp, eps, 0]},
         IntegerQ[c0] && c0 <= -1] &&
       (! MatchQ[base, _Symbol] && ! MatchQ[base, 1 - _Symbol]) &&
       With[{varsInBase = Intersection[
              Cases[base, _Symbol, {0, Infinity}] // Union, cubeVars]},
         Length[varsInBase] >= 2 && Length[varsInBase] <= kMax]
      ) :> {base, exp},
    Infinity];
  Do[
    Module[{base = factor[[1]], varsInBase, subset, pt, ruleAssign,
            baseSub},
      varsInBase = Intersection[
        Cases[base, _Symbol, {0, Infinity}] // Union, cubeVars];
      Do[
        Do[
          ruleAssign = Thread[subset -> pt];
          baseSub = Quiet @ Expand[base /. ruleAssign];
          If[PossibleZeroQ[baseSub],
            AppendTo[cornerSings, ruleAssign]],
          {pt, Tuples[{0, 1}, Length[subset]]}],
        {subset, Subsets[varsInBase, {2, Min[Length[varsInBase], kMax]}]}]],
    {factor, epsCases}];
  (* Keep only MINIMAL corner singularities (no proper subset also a corner) *)
  Module[{distinct = DeleteDuplicates[cornerSings]},
    Select[distinct,
      With[{this = #},
        ! AnyTrue[distinct,
          (# =!= this && SubsetQ[this, #]) &]] &]]];

mbeFindCompoundCornerFactors[normExpr_, cubeVars_List, eps_] := Module[
  {epsCases, raw = {}, kMax},
  kMax = Min[$mbeHeppMaxCornerSize, Length[cubeVars]];
  If[kMax < 2, Return[{}]];
  epsCases = Cases[normExpr,
    Power[base_, exp_] /;
      (! FreeQ[exp, eps] &&
       With[{c0 = Coefficient[exp, eps, 0]},
         IntegerQ[c0] && c0 <= -1] &&
       (! MatchQ[base, _Symbol] && ! MatchQ[base, 1 - _Symbol]) &&
       With[{varsInBase = Intersection[
              Cases[base, _Symbol, {0, Infinity}] // Union, cubeVars]},
         Length[varsInBase] >= 2 && Length[varsInBase] <= kMax])
      :> {base, exp},
    Infinity];
  Do[
    Module[{base = factor[[1]], exp = factor[[2]], varsInBase, subset,
            pt, ruleAssign, baseSub, c0, b0},
      varsInBase = Intersection[
        Cases[base, _Symbol, {0, Infinity}] // Union, cubeVars];
      c0 = Quiet @ FullSimplify[Coefficient[exp, eps, 0]];
      b0 = Quiet @ FullSimplify[Coefficient[exp, eps, 1]];
      Do[
        Do[
          ruleAssign = Thread[subset -> pt];
          baseSub = Quiet @ Expand[base /. ruleAssign];
          If[PossibleZeroQ[baseSub],
            AppendTo[raw, <|"Base" -> base, "Exp" -> exp,
              "Order" -> -c0, "Beta" -> b0, "Corner" -> ruleAssign|>]],
          {pt, Tuples[{0, 1}, Length[subset]]}],
        {subset, Subsets[varsInBase, {2, Min[Length[varsInBase], kMax]}]}]],
    {factor, epsCases}];
  Module[{distinct = DeleteDuplicatesBy[raw,
      {#["Base"], #["Exp"], #["Corner"]} &]},
    Select[distinct,
      With[{this = #},
        ! AnyTrue[distinct,
          (# =!= this && #["Base"] === this["Base"] &&
             #["Exp"] === this["Exp"] &&
             SubsetQ[this["Corner"], #["Corner"]]) &]] &]]];

mbeLinearFactorMoment[base_, var_, point_, i_, nOrd_, beta_, eps_] := Module[
  {s = Unique["bdyS"], lin, a, b, p, moment},
  lin = Expand[If[point === 0, base /. var -> s,
      base /. var -> 1 - s]];
  If[Exponent[lin, s] > 1, Return[$Failed]];
  a = Quiet @ FullSimplify[lin /. s -> 0];
  b = Quiet @ FullSimplify[Coefficient[lin, s, 1]];
  p = -nOrd + beta eps;
  moment = If[PossibleZeroQ[b],
    a^p/(i + 1),
    Sum[Binomial[i, k] (-a)^(i - k) *
        ((a + b)^(p + k + 1) - a^(p + k + 1))/(p + k + 1),
      {k, 0, i}]/b^(i + 1)];
  If[point === 0, 1, (-1)^i] * moment];

(* ---- Normal-crossing test (2026-07-01) ----------------
   On the unit hypercube [0,1]^N with boundaries strictly x_i=0 / x_i=1, a
   compound factor base(x1..xk) is NORMAL-CROSSING (its 1-variable Taylor
   corner projector is VALID) iff base factorizes (over the rationals) into a
   product of UNITS (no integration var) times UNIVARIATE-LINEAR factors
   (x_i or 1-x_i).  An irreducible base carrying >=2 integration variables --
   e.g. q t + v(1-t) -- vanishes on a CURVED locus: it is NON-normal-crossing
   (NNC), and a 1-variable moment subtraction silently ignores the transverse
   directions -> a WRONG-but-finite result.  Such a corner must be handled by
   the Hepp sector decomposition / blow-up (valid) or FLAGGED, never
   silently linear-subtracted.  $mbeNNCLinearMomentCount instruments how often
   the linear moment meets an NNC base; $mbeFlagNNCCorners (default False)
   turns the leakproof-strict guard on (skip + leave for Hepp/audit). *)
$mbeNNCLinearMomentCount = 0;
$mbeNNCLinearMomentBases = {};
$mbeFlagNNCCorners = False;
mbeNormalCrossingBaseQ[base_, vars_List] := Module[{factors, validFactorQ},
  validFactorQ[fac_] := Module[{facVars},
    facVars = Intersection[Variables[fac], vars];
    Length[facVars] == 0 ||
      (Length[facVars] == 1 && Exponent[fac, First[facVars]] == 1)];
  factors = Quiet[First /@ FactorList[base]];
  AllTrue[factors, validFactorQ]];

mbeApplyCompoundCornerSubtractions[integrand_, cubeVars_List, eps_] := Module[
  {wi = integrand, allCtrs = {}, factors, groups, cf, corners, commonRules,
   corner, var, point, nOrd, beta, base, gFun, R, coefs, poly, moment, ct, i,
   ncQ},
  factors = mbeFindCompoundCornerFactors[wi, cubeVars, eps];
  groups = GatherBy[factors, {#["Base"], #["Exp"]} &];
  Do[
    cf = groups[[k, 1]];
    corners = groups[[k, All, "Corner"]];
    commonRules = Select[DeleteDuplicates[Flatten[corners]],
      Function[r, AllTrue[corners, MemberQ[#, r] &]]];
    corner = If[commonRules =!= {}, commonRules, cf["Corner"]];
    {var, point} = List @@ FirstCase[corner,
      HoldPattern[Rule[v_, 1]] :> Rule[v, 1], First[corner]];
    nOrd = cf["Order"]; beta = cf["Beta"]; base = cf["Base"];
    gFun = base^(-nOrd + beta eps);
    R = wi/gFun;
    coefs = Table[mbeTaylorCoeffAt[R, {var}, {point}, {i}],
      {i, 0, nOrd - 1}];
    If[! FreeQ[coefs, Indeterminate | ComplexInfinity |
          DirectedInfinity[_] | Infinity],
      Continue[]];
    (* Leakproof NNC check: is this compound base normal-crossing (linear
       moment VALID) or NNC (linear moment would be a silent WRONG)? *)
    ncQ = TrueQ @ Quiet @ mbeNormalCrossingBaseQ[base, cubeVars];
    If[! ncQ,
      $mbeNNCLinearMomentCount++;
      AppendTo[$mbeNNCLinearMomentBases, base];
      (* strict mode: do NOT linear-subtract an NNC corner; leave it in the
         bulk so the Hepp decomposition handles it (valid) or the pole audit
         flags it (never a silent wrong). *)
      If[TrueQ[$mbeFlagNNCCorners], Continue[]]];
    poly = Sum[(var - point)^i coefs[[i + 1]], {i, 0, nOrd - 1}];
    ct = Table[
      moment = mbeLinearFactorMoment[base, var, point, i, nOrd, beta, eps];
      If[moment === $Failed || PossibleZeroQ[coefs[[i + 1]]], Nothing,
        <|"Integrand" -> coefs[[i + 1]] * moment,
          "CubeVars" -> DeleteCases[cubeVars, var]|>],
      {i, 0, nOrd - 1}];
    If[ct =!= {},
      wi = Quiet @ Together[wi - gFun * poly];
      allCtrs = Join[allCtrs, ct]],
    {k, Length[groups]}];
  <|"Subtracted" -> wi, "Counters" -> allCtrs|>];

mbeHeppSectorDecompose[integrand_, cubeVars_List, ruleAssign_, eps_] := Module[
  {r, sectorList = {}, k},
  r = Length[ruleAssign];
  Do[
    Module[{anchorVar, anchorPt, tNew, subsRules, jac, newIntg, newCV},
      anchorVar = First[ruleAssign[[k]]];
      anchorPt  = Last[ruleAssign[[k]]];
      tNew = Table[
        Symbol["heppT" <> ToString[$mbeHeppCurrentDepth] <>
          "s" <> ToString[k] <> "v" <> ToString[j]],
        {j, r}];
      subsRules = {};
      jac = 1;
      Do[
        With[{vj = First[ruleAssign[[j]]], ptj = Last[ruleAssign[[j]]],
              tj = tNew[[j]]},
          If[j === k,
            (* Anchor: rename to tj, fold the point=1 reflection *)
            AppendTo[subsRules, vj -> If[anchorPt === 0, tj, 1 - tj]],
            (* Non-anchor: small_j = anchor × tj *)
            With[{anchorSym = tNew[[k]]},
              AppendTo[subsRules,
                vj -> If[ptj === 0, anchorSym * tj, 1 - anchorSym * tj]];
              jac = jac * anchorSym]]],
        {j, r}];
      newCV = cubeVars /. Thread[ruleAssign[[All, 1]] -> tNew];
      newIntg = mbeNormalizeEulerForm[
        Quiet @ Together[(integrand /. subsRules) * jac], newCV, eps];
      AppendTo[sectorList,
        <|"Integrand" -> newIntg, "CubeVars" -> newCV,
          "SectorAnchor" -> anchorVar,
          "RuleAssign" -> ruleAssign,
          "SubsRules" -> subsRules|>]],
    {k, r}];
  sectorList];

mbeResolveAllBoundaries::nonsym =
  "Cube variables `1` are not plain Symbols. \
mbeDetectAllBoundarySingularities' candidate filter ({_Symbol,0|1,_Integer,_}) \
SILENTLY DISCARDS boundary detections at non-Symbol variables (t[i], u[i], ...), \
so subtraction and the pole audit both pass vacuously and per-order results \
come back 0. Rename cube variables to fresh Symbols before calling. \
(Root-caused 2026-07-19 on MB7 Phase-2 assembly.)";
mbeResolveAllBoundaries[integrand_, cubeVars_List, eps_] := Module[
  {wi, wc = cubeVars, allCtrs = {}, ass, iter = 0, maxIter = 20,
   flatCtrs, resolvedCtrs, recResult, cornerSings,
   sectorDecompositionUsed = False, sectorSubtractedTotal, sectorCounters = {}},
  With[{bad = Select[cubeVars, Head[#] =!= Symbol &]},
    If[bad =!= {}, Message[mbeResolveAllBoundaries::nonsym, bad]]];
  wi = mbeNormalizeEulerForm[integrand, cubeVars, eps];
  (* Round 8 — pre-check for overlapping corner singularities. *)
  cornerSings = mbeFindCornerSingularities[wi, cubeVars, eps];
  If[$mbeHeppDecompEnabled && cornerSings =!= {} && Length[cornerSings[[1]]] >= 2,
    Module[{cs = First[cornerSings], sectors, subResults, allCounters},
      sectors = mbeHeppSectorDecompose[wi, wc, cs, eps];
      $mbeHeppSectorCount += Length[sectors];
      subResults = Block[{$mbeHeppCurrentDepth = $mbeHeppCurrentDepth + 1},
        Table[
          mbeResolveAllBoundaries[
            sec["Integrand"], sec["CubeVars"], eps],
          {sec, sectors}]];
      (* Each sub-sector lives on its own cube (different variable names),
         so we cannot SUM their Subtracted on a common cube.  Instead, we
         set the original "Subtracted" to 0 (the corner singularity has
         been fully absorbed by the sector decomposition) and lift each
         sub-sector's contribution into the "Counters" list, each with
         its own cube variables. *)
      allCounters = Select[Flatten[Table[
        Join[
          {<|"Integrand" -> subResults[[k]]["Subtracted"]["Integrand"],
             "CubeVars" -> subResults[[k]]["Subtracted"]["CubeVars"]|>},
          subResults[[k]]["Counters"]],
        {k, Length[subResults]}], 1],
        ! PossibleZeroQ[#["Integrand"]] &];
      $mbeHeppLiftedTermCount += Length[allCounters];
      Return[<|"Subtracted" ->
                 <|"Integrand" -> 0, "CubeVars" -> wc|>,
               "Counters" -> allCounters|>]]];
  ass = If[wc === {}, True, And @@ Join[Thread[wc > 0], Thread[wc < 1]]];
  (* Phase 1: BPHZ-style multivariate subtraction.
     Enumerate ALL distinct boundary singularities, group by variable.
     For each variable, the (possibly multiple) boundaries at that
     variable are NOT overlapping (different points of the same var
     never share a corner).  For boundaries at DIFFERENT variables,
     they share corners of the cube and must be subtracted via
     inclusion-exclusion over all 2^N - 1 non-empty subsets.

     Specifically, for a set of distinct-variable boundary singularities
     S = {sing_1, ..., sing_N}, the BPHZ-subtracted integrand is
        Subtracted = integrand - Σ_{T ⊆ S, T ≠ ∅} (-1)^(|T|+1) C_T
     where C_T = Π_{i ∈ T} gFun_i × Taylor_T(integrand / Π_{i ∈ T} gFun_i)
     with Taylor_T substituting var_i = point_i for each i ∈ T.

     The integrated counter-term for subset T has factor
        Π_{i ∈ T} 1/(c_i + 1 + β_i ε)  for n_i = 1
     with overall sign (-1)^(|T|+1), reflecting inclusion-exclusion.

     For n=1 boundaries (the dominant case), this restores the
     missing 1/ε^k contributions from multi-variable corners that
     simple independent subtraction overlooks. *)
  Module[{compound, allSings, subsets, subtractedSum = 0, wiOrig},
    compound = If[TrueQ[$mbeHeppDecompEnabled],
      <|"Subtracted" -> wi, "Counters" -> {}|>,
      mbeApplyCompoundCornerSubtractions[wi, wc, eps]];
    wi = compound["Subtracted"];
    allCtrs = Join[allCtrs, compound["Counters"]];
    wiOrig = wi;
    allSings = mbeDetectAllBoundarySingularities[wiOrig, wc, eps];
    subsets = mbeCompatibleBoundarySubsets[allSings];
    Do[
      Module[{T = subsets[[idx]], singsT, gFunT, RT, taylorPoly,
              ctIntegrand, ctCubeVars, sign},
        singsT = allSings[[T]];
        gFunT = Product[
          mbeEndpointPower @@ Join[singsT[[j]], {eps}],
          {j, Length[singsT]}];
        RT = wiOrig/gFunT;
        taylorPoly = mbeTensorTaylorProjector[RT, singsT, eps];
        If[PossibleZeroQ[taylorPoly], Continue[]];
        sign = (-1)^(Length[T] + 1);
        ctIntegrand = sign * mbeTensorIntegratedProjector[RT, singsT, eps];
        ctCubeVars = Complement[wc, singsT[[All, 1]]];
        If[! PossibleZeroQ[ctIntegrand],
          AppendTo[allCtrs,
            <|"Integrand" -> ctIntegrand, "CubeVars" -> ctCubeVars|>]];
        subtractedSum += sign * gFunT * taylorPoly],
      {idx, Length[subsets]}];
    wi = wiOrig - subtractedSum];
  (* Phase 2 (counter-term recursion):  each raw counter-term lives on
     the reduced cube of remaining variables and may carry its own
     boundary singularities there.  Without this recursion the ε-poles
     that those inherited boundaries should generate are silently
     dropped at the per-coefficient Series step, which is the
     "negative orders return 0" symptom seen on MBpilot13/MB14. *)
  flatCtrs = Flatten[allCtrs];
  resolvedCtrs = {};
  Do[
    recResult = mbeResolveAllBoundaries[ct["Integrand"], ct["CubeVars"], eps];
    AppendTo[resolvedCtrs, recResult["Subtracted"]];
    Do[AppendTo[resolvedCtrs, c], {c, recResult["Counters"]}],
    {ct, flatCtrs}];
  <|"Subtracted" -> <|"Integrand" -> wi, "CubeVars" -> wc|>,
    "Counters" -> resolvedCtrs|>];

mbeMakeMiniEulerResult[integrand_, cubeVars_List] := <|
  "EulerIntegrands" -> {{integrand, cubeVars}},
  "HasPolygamma" -> False, "Assumptions" -> True,
  "PartA" -> <|"EulerIntegrand" -> integrand,
               "CubeVariables" -> cubeVars,
               "CubeIntegrandBeforeLimit" -> integrand,
               "Mode" -> "Auxiliary", "Pipeline" -> None,
               "PolygammaPreprocess" -> None|>,
  "PartB" -> {}, "PartialResult" -> False,
  "PartAFailure" -> None, "PolygammaPreprocess" -> None|>;

(* Split an expression into atomic additive terms.
   For Plus expressions at top: split directly.
   For Times[Plus, factors...] (single Plus among factors):
       distribute the other factors across the Plus.
   Otherwise: treat as single atom. *)
mbeSplitIntoAtoms[expr_] := Module[{factors, plusFactors, restFactors, restProd},
  Which[
    Head[expr] === Plus, List @@ expr,
    Head[expr] === Times,
      factors = List @@ expr;
      plusFactors = Cases[factors, _Plus];
      If[Length[plusFactors] === 1,
        restFactors = DeleteCases[factors, _Plus];
        restProd = Times @@ restFactors;
        (List @@ First[plusFactors]) * restProd,
        {expr}],
    True, {expr}]];

(* Integrate one atomic term via Euler2MPL with short per-atom timeout *)
(* Atom integrator with cheap-path short-circuits + memoization
   (autonomous speedup round 1, 2026-06-05).

   Three fast paths avoid Euler2MPL overhead on trivial atoms:
   1. PossibleZeroQ -> 0
   2. FreeQ[atom, cubeVars] -> atom itself (constant; ∫_{[0,1]^n} const = const)
   3. Per-atom cubeVars reduction: when atom depends on only a subset
      of cubeVars, call Euler2MPL with that reduced cube. Variables
      the atom is FreeQ of integrate trivially to 1 each.
   The remaining (genuinely-multivariate) atoms go through the cached
   Euler2MPL path. *)
mbeClearAtomCache[] := (
  Clear[mbeIntegrateAtomCached];
  mbeIntegrateAtomCached[atom_, cubeVars_, atomTimeout_] :=
    mbeIntegrateAtomCached[atom, cubeVars, atomTimeout] = Module[{mpl},
      mpl = TimeConstrained[
        Block[{Print},
          Euler2MPL[mbeMakeMiniEulerResult[atom, cubeVars]]],
        atomTimeout, $TimedOut];
      If[mpl =!= $TimedOut && AssociationQ[mpl] && TrueQ[mpl["AllSucceeded"]],
        mpl["MPLResult"],
        $Failed]];);
mbeClearAtomCache[];

mbeIntegrateAtom[atom_, cubeVars_, atomTimeout_] := Module[{vUsed, numFactor, normalised, result},
  If[PossibleZeroQ[atom], Return[0]];
  (* Cheap path 1: atom has no cube-variable dependence -> just return it. *)
  If[FreeQ[atom, Alternatives @@ cubeVars], Return[atom]];
  (* Cheap path 2: reduce cube-vars to ONLY those the atom actually
     contains. Euler2MPL only sees the variables it has to integrate,
     not the whole cube. *)
  vUsed = Select[cubeVars, ! FreeQ[atom, #] &];
  (* Round 11: prefactor-normalise before keying.  Euler2MPL is linear
     so cache Euler2MPL(atom / scalar_prefactor) and rescale on retrieval.
     Identical normalised atoms with different scalar prefactors share
     one cached integration. *)
  numFactor = Times @@ Cases[atom,
    _?(NumericQ[N[#]] && FreeQ[#, Alternatives @@ vUsed] &), {1}];
  If[PossibleZeroQ[numFactor] || ! FreeQ[numFactor, Alternatives @@ vUsed],
    numFactor = 1];
  normalised = atom / numFactor;
  result = mbeIntegrateAtomCached[normalised, vUsed, atomTimeout];
  If[result === $Failed, $Failed, numFactor * result]];

(* ============================================================
   POLE-AUDIT — leakproof guard (2026-07-01).
   mbeProcessEpsCoefficients does NO subtraction: it Series-expands
   and integrates PER ORDER, ASSUMING an already-subtracted, eps-
   expandable input.  Feeding it a raw pole u^(-n+b e) (n>=1) makes
   Series expose a bare u^(-n) in the coefficients -> the per-order
   integral is ill-defined and the pole is SILENTLY dropped (returns 0
   or $Failed).  The audit makes that impossible:
     PRE-audit : if the input still carries an un-subtracted GENUINE
       coordinate-face pole or compound NNC corner (one whose quotient
       R = integrand/gFun has non-zero Taylor data at the locus -- i.e.
       NOT already numerator-cancelled), the input is not eps-expandable;
       return the marker mbeUnsubtractedPole[<|faces,corners|>] in every
       slot (NOT 0, NOT $Failed).  A detected power whose numerator zero
       cancels it (e.g. the subtracted bulk (1-u)^(-1+e)[R(u)-R(1)]) is
       correctly passed.
   $mbePoleAudit toggles it (default True).  Callers (mbtBPHZRegular,
   mbtSubtractionRoute) treat the marker as "must subtract first / do
   NOT accept a silently-dropped result".
   ============================================================ *)
$mbePoleAudit = True;

(* Legacy trig-reduction residue TOWER: last-resort evaluator for the
   degenerate class, tried ONLY after the parametric cube attempts fail.
   It is safe despite the arc-vanishing concern because mbeDegTrigEval
   refuses to serve unless its value matches the contour quadrature to
   1e-8; every use is additionally recorded in $mbtFailedPieces with
   reason "tower-fallback-used" so tower reliance is always visible.
   Set False to forbid it entirely (pieces then fail loudly). *)
$mbeDegTrigTowerEnabled = False;
$mbeForceShiftPieceTO = 1200;
$mbeForceShiftTotalTO = 14000;

(* ---- fast NUMERIC genuine-pole probe --------------------------------
   The symbolic Limit[D[R,{var,i}]] on a multi-variable cube is far too
   slow to run on every mbeProcessEpsCoefficients call.  Instead we
   substitute the OTHER cube variables (and eps) with fixed generic
   interior rationals, collapsing R to a ONE-variable function whose
   Taylor data at the face is a cheap 1-D limit.  Two independent probe
   points guard against an accidental zero; if BOTH fail to evaluate
   numerically we flag CONSERVATIVELY (never silently pass a pole). *)
$mbeProbeBasis = {3/7, 2/5, 5/9, 4/11, 5/13, 3/8, 7/15, 2/9, 6/17, 4/9,
   5/11, 7/16, 3/10, 8/17, 5/12, 2/7, 6/13, 4/15, 7/18, 3/11};
mbeProbeRules[vars_List, eps_, shift_Integer, epsVal_] := Join[
  {eps -> epsVal},
  MapIndexed[
    #1 -> $mbeProbeBasis[[Mod[First[#2] - 1 + shift, Length[$mbeProbeBasis]] + 1]] &,
    vars]];
mbeNonZeroNumericQ[x_] := Module[{v = Quiet @ N[x]},
  NumericQ[v] && Abs[v] > 10^-8];

(* A detected boundary singularity {var,point,nOrd,beta} is a GENUINE
   un-subtracted pole iff R = integrand/gFun has non-vanishing Taylor
   data (orders 0..nOrd-1) at the face.  An already-subtracted bulk has
   R = F(var) - Taylor_{nOrd-1}[F] there, so those coefficients vanish. *)
mbeGenuineFaceQ[integrand_, sing_, cubeVars_List, eps_] := Module[
  {var, point, nOrd, beta, gFun, R, others, decisive = {}},
  {var, point, nOrd, beta} = sing;
  gFun = If[point === 0, var, 1 - var]^(-nOrd + beta eps);
  R = integrand/gFun;
  others = DeleteCases[cubeVars, var];
  Do[
    Module[{Rp = Quiet[R /. pr], cfs, okQ, genQ},
      cfs = Quiet @ Table[Limit[D[Rp, {var, i}], var -> point], {i, 0, nOrd - 1}];
      okQ = AllTrue[cfs, (NumericQ[Quiet @ N[#]]) &];
      genQ = AnyTrue[cfs, mbeNonZeroNumericQ];
      If[okQ, AppendTo[decisive, genQ]]],
    {pr, {mbeProbeRules[others, eps, 0, -1/50],
          mbeProbeRules[others, eps, 7, -1/40]}}];
  If[decisive === {}, True, AnyTrue[decisive, TrueQ]]];

(* A detected compound corner (Base,Exp,Order,Beta,Corner) is GENUINE iff
   the remainder R = integrand/Base^Exp does not vanish at the corner. *)
mbeGenuineCornerQ[integrand_, cf_, cubeVars_List, eps_] := Module[
  {R, cornerRules, cornerVars, others, decisive = {}},
  R = integrand/(cf["Base"]^cf["Exp"]);
  cornerRules = cf["Corner"];
  cornerVars = cornerRules[[All, 1]];
  others = Complement[cubeVars, cornerVars];
  Do[
    Module[{Rp = Quiet[R /. pr], val},
      val = Quiet @ Fold[Limit[#1, #2] &, Rp, cornerRules];
      If[NumericQ[Quiet @ N[val]], AppendTo[decisive, mbeNonZeroNumericQ[val]]]],
    {pr, {mbeProbeRules[others, eps, 0, -1/50],
          mbeProbeRules[others, eps, 7, -1/40]}}];
  If[decisive === {}, True, AnyTrue[decisive, TrueQ]]];

mbeAuditUnsubtracted[integrand_, cubeVars_List, eps_] := Module[
  {norm, faces, genFaces, cornerFactors, genCorners},
  If[cubeVars === {}, Return[<|"Faces" -> {}, "Corners" -> {}|>]];
  norm = mbeNormalizeEulerForm[integrand, cubeVars, eps];
  faces = mbeDetectAllBoundarySingularities[norm, cubeVars, eps];
  genFaces = Select[faces, mbeGenuineFaceQ[norm, #, cubeVars, eps] &];
  cornerFactors = Block[{$mbeHeppCurrentDepth = 0},
    mbeFindCompoundCornerFactors[norm, cubeVars, eps]];
  genCorners = Select[cornerFactors, mbeGenuineCornerQ[norm, #, cubeVars, eps] &];
  <|"Faces" -> genFaces, "Corners" -> genCorners|>];

mbeAuditCleanQ[integrand_, cubeVars_List, eps_] := Module[{a},
  a = mbeAuditUnsubtracted[integrand, cubeVars, eps];
  a["Faces"] === {} && a["Corners"] === {}];

(* Gate predicate: is direct per-order Euler2MPL valid on this cube?  It is iff
   the cube has NO genuine coordinate-face pole AND NO compound (Plus-base,
   c0<=-1) corner AT ALL.  We use the STRUCTURAL corner detection
   (mbeFindCompoundCornerFactors) directly -- NOT the numeric mbeGenuineCornerQ
   filter, which has false negatives on genuine multilinear corners like MBpilot12's
   (u1(u2-1)-u2 u3)^(-2+2e).  Worst case (a numerator-cancelled corner) this is
   conservative: it routes through mbtBPHZRegular, which is still correct, only
   slower.  res2's faithful cube has ZERO such corners -> stays on the fast
   direct path.  (2026-07-01, structural criterion.) *)
mbeGateCleanQ[integrand_, cubeVars_List, eps_] := Module[{norm, faces, cfs},
  If[cubeVars === {}, Return[True]];
  norm = Quiet @ mbeNormalizeEulerForm[integrand, cubeVars, eps];
  faces = mbeDetectAllBoundarySingularities[norm, cubeVars, eps];
  faces = Select[faces, mbeGenuineFaceQ[norm, #, cubeVars, eps] &];
  cfs = Block[{$mbeHeppCurrentDepth = 0},
    mbeFindCompoundCornerFactors[norm, cubeVars, eps]];
  faces === {} && cfs === {}];

(* True iff the cube carries a COMPOUND (Plus-base, >=2 cube vars) factor that
   is SINGULAR on the physical contour eps<0 -- i.e. the exponent is negative
   at a small negative eps.  This catches BOTH the ordinary c0<=-1 corner AND
   the eps-LINEAR-exponent corner (A+B)^(b eps) with b>0 (c0=0 but negative for
   eps<0), which mbeFindCompoundCornerFactors (c0<=-1 only) MISSES.  A cube with
   such a factor is NOT normal-crossing: order-by-order integration would drop
   its pole, so the direct-first gate must route it through mbtBPHZRegular. *)
mbeCompoundCornerPresentQ[integrand_, cubeVars_List, eps_] := Module[
  {norm, epsProbe = -1/100},
  norm = Quiet @ mbeNormalizeEulerForm[integrand, cubeVars, eps];
  ! FreeQ[norm,
    Power[b_, e_] /; (
      ! FreeQ[e, eps] &&
      MatchQ[Expand[b], _Plus] &&
      Length[Intersection[Cases[b, _Symbol, {0, Infinity}] // Union, cubeVars]] >= 2 &&
      TrueQ[Negative[Quiet @ N[e /. eps -> epsProbe]]] )]];

mbeProcessEpsCoefficients[piece_, eps_, ordMin_Integer, ordMax_Integer,
  opts:OptionsPattern[{"AtomMode" -> True, "AtomTimeout" -> 30,
                        "WholeTimeout" -> 60}]] :=
  Module[
   {expanded, results = ConstantArray[0, ordMax - ordMin + 1],
    ce, atoms, atomResults, k, useAtoms, atomTO, wholeTO, cv, wholeRes, audit},
   useAtoms = OptionValue["AtomMode"];
   atomTO = OptionValue["AtomTimeout"];
   wholeTO = OptionValue["WholeTimeout"];
   cv = piece["CubeVars"];
   (* PRE-AUDIT: never Series-expand an input that still carries a genuine
      un-subtracted pole/corner -> that would silently drop the pole. *)
   If[TrueQ[$mbePoleAudit] && cv =!= {},
     audit = Quiet @ mbeAuditUnsubtracted[piece["Integrand"], cv, eps];
     If[audit["Faces"] =!= {} || audit["Corners"] =!= {},
       Return[ConstantArray[mbeUnsubtractedPole[audit], ordMax - ordMin + 1]]]];
   expanded = Quiet @ Normal @ Series[piece["Integrand"], {eps, 0, ordMax}];
   Do[
    ce = Coefficient[expanded, eps, k];
    If[! PossibleZeroQ[ce],
     If[cv === {},
      results[[k - ordMin + 1]] = ce,
      (* Speedup round 1 (2026-06-05): WHOLE-MODE FIRST. The previous
         "atom-mode first" path emitted one Euler2MPL call per atom
         (Plus-split coefficient), incurring per-call overhead × #atoms.
         For finite coefficients (the typical case — divergence usually
         lives in counter-terms, not in the bulk's Series-truncated
         coefficient), whole-mode is ~2× faster on MBpilot12 (15s -> 8s).
         If whole-mode hits $Failed (genuine divergence that needs the
         shuffle-regulator inside aeiTryIntegrate to cancel across
         atoms), fall back to atom-mode. *)
      wholeRes = mbeIntegrateAtom[ce, cv, wholeTO];
      If[wholeRes =!= $Failed,
        results[[k - ordMin + 1]] = wholeRes,
        If[useAtoms,
          atoms = mbeSplitIntoAtoms[ce];
          atomResults = Map[
            mbeIntegrateAtom[#, cv, atomTO] &, atoms];
          If[FreeQ[atomResults, $Failed],
            results[[k - ordMin + 1]] = Total[atomResults],
            results[[k - ordMin + 1]] = $Failed],
          results[[k - ordMin + 1]] = $Failed]]]],
    {k, ordMin, ordMax}];
   results];

(* ============================================================
   Phase correction helpers (Round 6, 2026-06-05)

   Adapted from standard_route_with_phase.m's pvStandardRoute
   (.tex notes §15). The standard MBresolve+...+MBSymbolicInt pipeline
   returns the residue-sum convention value for integrands carrying
   (-1)^(α z) phase factors. Czakon's MBintegrate uses the
   contour-integration convention; the two are related by a
   closed-form correction

       MBintegrate-convention value
         = standard route value + Σ_pieces δ_piece

   where δ at a pole of order k at z=z₀, with phase α, is

       δ(z₀) = Σ_{j=2,4,...,j≤k-1} (α π i)^j/j! × g_{-1-j}(z₀)

   The PV (left-right) average gives the actual correction added.

   For MBresolveToMPL the pieces from MBresolve still carry the
   (-1)^(α z) phase factor before residue evaluation, so we compute
   δ symbolically (keeping eps symbolic — pvStandardRoute substitutes
   eps=1 which is only safe for post-MBexpand polynomials in eps;
   MBresolveToMPL's raw post-resolve integrand has Gamma singularities
   at eps=1, so we must keep eps symbolic). The result is an
   eps-Laurent that we add coefficient-by-coefficient to MBresolveToMPL's
   output. *)

mbeDetectPhaseAlpha[expr_, var_Symbol] := Module[{phaseCases},
  phaseCases = Cases[expr,
    Power[-1, e_] /; ! FreeQ[e, var] :> Coefficient[e, var, 1],
    Infinity];
  If[phaseCases === {}, 0, First[phaseCases]]];

(* Phase correction at one (eps-order, pole-point) pair.
   IMPORTANT: take the eps-coefficient FIRST (which collapses
   Γ(-z6−3ε) type factors at ε=0 down to Γ(-z6), thereby PROMOTING
   the natural pole order at z=z₀ from k to k+m where m is the
   eps-poles of the collapsed factors), THEN do the z-pole analysis.
   This is the opposite order from pvStandardRoute which substitutes
   eps=1 once and lets the post-MBexpand pole structure speak for
   itself; here we keep eps symbolic so it works on raw post-
   MBresolve integrands. *)
mbePhaseCorrectionFkAtPole[fk_, var_Symbol, polePoint_, alpha_] :=
  Module[{ser, poleOrder, j, coef, corr},
    ser = Quiet @ Series[fk, {var, polePoint, 0}];
    If[Head[ser] =!= SeriesData, Return[0]];
    poleOrder = -ser[[4]];
    If[poleOrder < 3, Return[0]];
    corr = 0;
    Do[
      coef = Quiet @ SeriesCoefficient[ser, -1 - j];
      corr += (alpha Pi I)^j / Factorial[j] * coef,
      {j, 2, poleOrder - 1, 2}];
    Re[corr]];

(* Round 7 (2026-06-05) — closed-form analytic δ via asymmetric-pattern
   detection.

   For an eps-coefficient f_k(z) with phase (-1)^(αz), pole order k_0
   at z=0 and pole order k_∞ at z=±n (n ≥ 1), the principal-value
   correction is

      δ_PV = (1/2) × [ Σ_{j even, ≥2, ≤k_∞−1}
                         (αiπ)^j/j! × Σ_{n≥1}(g_{-1-j}(-n) - g_{-1-j}(n))
                     − Σ_{j even, ≥2, ≤k_0−1}
                         (αiπ)^j/j! × g_{-1-j}(0) ].

   The asymmetric tail Σ_{n≥1}(g_{-1-j}(-n) - g_{-1-j}(n)) typically
   has the closed-form pattern

      g_{-1-j}(-n) - g_{-1-j}(n)  =  A_2/n² + A_4/n⁴ + … + A_{2K}/n^(2K)

   with at most K ≤ k_∞ non-zero coefficients.  We extract the
   coefficients {A_{2k}} by computing the difference at n = 1..K+1
   integer points and solving a small linear system; the infinite
   sum is then

      Σ_{n≥1} (g_{-1-j}(-n) - g_{-1-j}(n))  =  Σ_k A_{2k} × ζ(2k).

   This is a FULLY ANALYTIC closed form — no numerical truncation,
   no Richardson bias — provided the asymmetric pattern fits a
   finite expansion in 1/n^(2k).  For MBpilot13 ε⁰ this yields the exact
   pattern A_2 = 24, A_4 = … = 0, giving δ = 432π² − 34π⁴ in two
   Series calls per pole, total ~5s on the f_0(z) coefficient. *)

(* Maximum K in the A_2/n² + … + A_{2K}/n^(2K) asymmetry fit.
   nFit = K+1 ≥ 4 gives a robust fit with one extra data point for
   over-determination check. *)
$mbePhaseAsymKMax = 4;
$mbePhaseAsymNFit = 5;

(* Optional legacy single-radius fallback: set to a positive integer
   to bypass the analytic recipe and use the slow finite-radius sum
   (Round-6 behaviour). Default Automatic uses the analytic path. *)
$mbePhaseSearchRadius = Automatic;

(* Solve  diffs[i] == Σ_{k=1..K} A_{2k}/n_i^(2k)  for the A_{2k},
   then return the analytic sum Σ_k A_{2k} × ζ(2k).
   Returns $Failed if the linear system is singular. *)
mbeFitAsymmetricInfSum[diffs_List, nValues_List, kMax_Integer] := Module[
  {nFit, As, sys, sol, infSum, k},
  nFit = Min[Length[nValues], kMax + 1];
  As = Table[Unique["A"], {kMax}];
  sys = Table[
    diffs[[i]] ==
      Sum[As[[k]]/nValues[[i]]^(2 k), {k, 1, kMax}],
    {i, nFit}];
  sol = Quiet @ Solve[Take[sys, kMax], As];
  If[sol === {} || sol === $Failed, Return[$Failed]];
  infSum = Sum[(As[[k]] /. First[sol]) × Zeta[2 k], {k, 1, kMax}];
  Simplify[infSum]];

(* Per-eps-coefficient analytic δ computation.
   PERF (2026-07-02; MBpilot13 subtraction 148s -> ~15s): two exact speedups.
   (1) FunctionExpand[fk] FIRST.  The eps-coefficient of the grouped Gamma sum
       carries Gamma/PolyGamma factors with INTEGER offsets in var; the raw
       Series[fk,{var,n,0}] at integer pole points then costs 19-29s EACH
       (fresh-kernel measurement, MBpilot13 e^0, LeafCount 395) because Series must
       dig through cross-factor pole cancellations.  FunctionExpand (0.2s)
       canonicalizes the shifted Gammas/PolyGammas to Gamma[±var]-type, after
       which every point-Series is ~0.05s (~300x on the hot path).  Verified
       coefficient-exact; a TimeConstrained guard falls back to the raw
       (slow-but-correct) expression.  NB an earlier Together[fk] "fix" was a
       Series-cache mirage — Together does NOT help fresh kernels.
   (2) hoist the point-Series out of the j-loop: Series[fk,{var,±n,0}] does not
       depend on j; compute the 2·$mbePhaseAsymNFit series ONCE and read all
       j-coefficients from them. *)
mbePhaseCorrectionForEpsCoef[fkRaw_, var_Symbol, alpha_] := Module[
  {fk, ser0, kOrder0, serPos, kOrderInf, sumAtZero, sumAsym, j, nList,
   serPosTab, serNegTab, cPosList, cNegList, diffs, fittedInfSum, deltaPV},
  fk = Quiet @ TimeConstrained[FunctionExpand[fkRaw], 60, fkRaw];
  ser0 = Quiet @ Series[fk, {var, 0, 0}];
  If[Head[ser0] =!= SeriesData, Return[0]];
  kOrder0 = -ser0[[4]];
  serPos = Quiet @ Series[fk, {var, 1, 0}];
  kOrderInf = If[Head[serPos] === SeriesData, -serPos[[4]], 0];
  If[kOrder0 < 3 && kOrderInf < 3, Return[0]];

  (* z = 0 contribution: exact via single Series + SeriesCoefficient *)
  sumAtZero = 0;
  Do[
    sumAtZero += (alpha Pi I)^j/Factorial[j] *
      Quiet @ SeriesCoefficient[ser0, -1 - j],
    {j, 2, kOrder0 - 1, 2}];

  (* z = ±n contribution: detect asymmetric 1/n^(2k) pattern.
     The series at each point are j-independent -> computed once. *)
  sumAsym = 0;
  nList = Range[$mbePhaseAsymNFit];
  serPosTab = Table[Quiet @ Series[fk, {var, n, 0}], {n, nList}];
  serNegTab = Table[Quiet @ Series[fk, {var, -n, 0}], {n, nList}];
  Do[
    cPosList = Table[
      If[Head[serPosTab[[n]]] === SeriesData,
        (alpha Pi I)^j/Factorial[j] *
          Quiet @ SeriesCoefficient[serPosTab[[n]], -1 - j], 0],
      {n, nList}];
    cNegList = Table[
      If[Head[serNegTab[[n]]] === SeriesData,
        (alpha Pi I)^j/Factorial[j] *
          Quiet @ SeriesCoefficient[serNegTab[[n]], -1 - j], 0],
      {n, nList}];
    diffs = cNegList - cPosList;
    If[AllTrue[diffs, PossibleZeroQ],
      Continue[]];
    fittedInfSum = mbeFitAsymmetricInfSum[diffs, nList, $mbePhaseAsymKMax];
    If[fittedInfSum =!= $Failed,
      sumAsym += fittedInfSum],
    {j, 2, kOrderInf - 1, 2}];

  deltaPV = Re[(sumAsym - sumAtZero)/2];
  Simplify[deltaPV]];

(* Compute the phase-correction eps-Laurent for one MBresolve piece.
   Returns a list of length ordMax-ordMin+1 of eps-coefficients. *)
mbePhaseCorrectionPiece[integrand_, var_Symbol, eps_,
   ordMin_Integer, ordMax_Integer] := Module[
  {alpha, gPhaseless, serEps, fk, result, k, useAnalytic, n},
  alpha = mbeDetectPhaseAlpha[integrand, var];
  If[alpha === 0, Return[ConstantArray[0, ordMax - ordMin + 1]]];
  gPhaseless = integrand /. Power[-1, e_] /; ! FreeQ[e, var] :> 1;
  (* Series in eps FIRST. We need pole order up to ordMax in eps to
     catch all the promoted z-poles. *)
  serEps = Quiet @ Series[gPhaseless, {eps, 0, ordMax}];
  useAnalytic = ($mbePhaseSearchRadius === Automatic);
  result = ConstantArray[0, ordMax - ordMin + 1];
  Do[
    fk = Quiet @ SeriesCoefficient[serEps, k];
    If[! PossibleZeroQ[fk],
      result[[k - ordMin + 1]] =
        If[useAnalytic,
          mbePhaseCorrectionForEpsCoef[fk, var, alpha],
          (* Legacy fixed-radius path *)
          Module[{R = $mbePhaseSearchRadius, dR = 0, dL = 0, m},
            Do[dR += mbePhaseCorrectionFkAtPole[fk, var, m, alpha],
               {m, 0, R}];
            Do[dL += mbePhaseCorrectionFkAtPole[fk, var, -m, alpha],
               {m, 1, R}];
            (dL - dR)/2]]],
    {k, ordMin, ordMax}];
  result];

(* ============================================================
   v1.6 cleanup: hoisted F(z)-pattern matcher.

   Replaces two byte-identical inline computations in MBtoEuler
   (Block-5-failure recovery branch and the MBVarPoleDetected
   post-success branch). The matcher computes the residual ratio
   integrand / F(z) and checks that no MB-variable-dependent
   \[CapitalGamma] survives, which is exactly the F(z)-family signature.

   Only fires for the univariate (Length[mbVars] === 1) case;
   multi-MB-var integrands are not in scope for the symbolic-residue
   override.
   ============================================================ *)

mbeMatchesFPatternQ[integrand_, mbVars_List] :=
  If[Length[mbVars] =!= 1, False,
    Module[{mv = mbVars[[1]], ratio},
      ratio = Quiet@Together[
        integrand * Gamma[2 + mv] /
        (Gamma[1 - mv] * Gamma[-mv] * Gamma[mv]^2 * Gamma[1 + mv])];
      FreeQ[ratio, gam_Gamma /; !FreeQ[gam, mv]]]];

(* 2026-07-20 GATE WIDENING (shift-equivalents of F(z); fixes-notes v1.2
   pattern "the v1.1 gate was tuned for one particular F(z) shape").
   Fire the symbolic-residue Path B/B' whenever the Gamma content of a
   1-fold integrand COLLAPSES COMPLETELY under reflection (FunctionExpand)
   to a trig-rational kernel — the balanced degenerate class
   (e.g. Gamma(-1-z)Gamma(-z)Gamma(z)Gamma(1+z) -> pi^2/(z(-1-z)sin^2);
   MB7's family, MB10/MB6's Gamma-ratio kernels). This was the family the
   exact F-pattern missed, producing Block-5 Auxiliary's silently-wrong
   constants (measured 11 pi^4/90 per unit coefficient on MB7's psi1
   triplet). Conservative: fires only when NO Gamma survives the collapse. *)
mbeMatchesDegenerateKernelQ[integrand_, mbVars_List] :=
  If[Length[mbVars] =!= 1, False,
    Module[{mv = mbVars[[1]], gpart, coll},
      gpart = integrand /. PolyGamma[_, _] -> 1;
      If[FreeQ[gpart, Gamma[a_ /; ! FreeQ[a, mv]]], Return[False]];
      coll = Quiet@TimeConstrained[
        Together@FunctionExpand[gpart], 30, $Failed];
      coll =!= $Failed && FreeQ[coll, Gamma[a_ /; ! FreeQ[a, mv]]]]];

mbeFindMatchingDenominatorIndex[arg_, wk_List, ass_:True] := Module[{inds},
  inds = Select[Range[Length[wk]], wk[[#,2]] < 0 && mbeArgEqualQ[arg, wk[[#,1]], ass] &];
  If[inds === {}, None, First[inds]]];

(* Detect aux parameters (introduced by Block 0 for polygamma).
   Aux symbols are named "\[Iota]" regardless of context. *)
mbeContainsAuxQ[expr_] := !FreeQ[expr,
  s_Symbol[_] /; (SymbolName[s] === "\[Iota]")];

mbeCollectBetaCandidates[wk_List, var_, vars_List, ass_:True] := Module[
  {n = Length[wk], cands = {}, i, j, a1, a2, s1, s2, c1, c2, new, aN, aD, df, matchIdx, hasAux},
  Do[
    {a1, s1} = wk[[i]];
    c1 = FullSimplify[Coefficient[Together[a1], var], ass];
    If[TrueQ[c1 == 0], Continue[]];
    Do[
      {a2, s2} = wk[[j]];
      c2 = FullSimplify[Coefficient[Together[a2], var], ass];
      If[TrueQ[c2 == 0], Continue[]];
      If[TrueQ[s1>0] && TrueQ[s2>0] && TrueQ[FullSimplify[c1+c2==0,ass]],
        new = FullSimplify[a1+a2, ass];
        matchIdx = mbeFindMatchingDenominatorIndex[new, wk, ass];
        hasAux = mbeContainsAuxQ[a1] || mbeContainsAuxQ[a2];
        AppendTo[cands, <|"Rule"->"A","Indices"->Sort[{i,j}],"BetaPair"->{a1,a2},
          "NewGamma"->{new,+1},"NewArg"->new,"MatchingDenominatorIndex"->matchIdx,
          "MatchesExistingDenominatorQ"->(matchIdx=!=None),
          "ConstantQ"->FreeQ[new, Alternatives@@vars],
          "SupportCount"->mbeArgSupportCount[new,vars,ass],
          "LeafCount"->LeafCount[new], "HasAuxQ"->hasAux|>]];
      If[TrueQ[s1*s2<0] && TrueQ[FullSimplify[c1-c2==0,ass]],
        {aN,aD} = If[s1>0, {a1,a2}, {a2,a1}];
        df = FullSimplify[aD-aN, ass];
        If[FreeQ[df, Alternatives@@vars] && TrueQ[FullSimplify[Re[df]>0,ass]],
          hasAux = mbeContainsAuxQ[aN] || mbeContainsAuxQ[aD];
          AppendTo[cands, <|"Rule"->"B","Indices"->Sort[{i,j}],"BetaPair"->{df,aN},
            "NewGamma"->{df,-1},"NewArg"->df,"MatchingDenominatorIndex"->None,
            "MatchesExistingDenominatorQ"->False,"ConstantQ"->True,
            "SupportCount"->0,"LeafCount"->LeafCount[df], "HasAuxQ"->hasAux|>]]],
      {j, i+1, n}],
    {i, 1, n-1}];
  cands];

mbeCollectCrossVariableBetaCandidates[wk_List, vars_List, ass_:True] := Module[
  {n = Length[wk], cands = {}, i, j, a1, a2, s1, s2, new, matchIdx},
  Do[
    {a1,s1} = wk[[i]]; If[s1<=0, Continue[]];
    Do[
      {a2,s2} = wk[[j]]; If[s2<=0, Continue[]];
      new = Simplify[a1+a2, ass];
      matchIdx = mbeFindMatchingDenominatorIndex[new, wk, ass];
      If[matchIdx=!=None,
        AppendTo[cands, <|"Rule"->"C","Indices"->Sort[{i,j}],"BetaPair"->{a1,a2},
          "NewGamma"->{new,+1},"NewArg"->new,"MatchingDenominatorIndex"->matchIdx,
          "MatchesExistingDenominatorQ"->True,
          "ConstantQ"->FreeQ[new, Alternatives@@vars],
          "SupportCount"->mbeArgSupportCount[new,vars,ass],
          "LeafCount"->LeafCount[new]|>]],
      {j, i+1, n}],
    {i, 1, n-1}];
  cands];

mbeChooseBestBetaCandidate[cands_List] :=
  If[cands==={}, None,
    First@SortBy[cands, {If[#["ConstantQ"],0,1]&,
      If[#["MatchesExistingDenominatorQ"],0,1]&,
      #["SupportCount"]&, #["LeafCount"]&, If[#["Rule"]==="A",0,1]&}]];

mbeChooseBestDenominatorCancellationCandidate[cands_List] := Module[{good},
  good = Select[cands, #["Rule"]==="A" && TrueQ[#["MatchesExistingDenominatorQ"]]&];
  If[good==={}, None,
    First@SortBy[good, {#["SupportCount"]&,#["LeafCount"]&,If[#["ConstantQ"],0,1]&}]]];

mbeApplyChosenPair[wk_List, best_] := Module[{indsToDelete, newwk},
  indsToDelete = best["Indices"];
  If[KeyExistsQ[best,"MatchingDenominatorIndex"] && best["MatchingDenominatorIndex"]=!=None,
    indsToDelete = Join[indsToDelete, {best["MatchingDenominatorIndex"]}]];
  indsToDelete = Reverse@Sort@DeleteDuplicates[indsToDelete];
  newwk = Delete[wk, List /@ indsToDelete];
  If[TrueQ[best["MatchesExistingDenominatorQ"]], newwk, Append[newwk, best["NewGamma"]]]];

mbeCollectAllBetaCandidates[wk_List, vars_List, ass_:True] :=
  DeleteDuplicatesBy[
    Flatten[mbeCollectBetaCandidates[wk,#,vars,ass]& /@ vars, 1],
    {#["Rule"],#["Indices"],#["NewArg"]}&];

(* res4 colliding-poles pinch fix, 2026-06-29.
   Same-orientation Γ-ratio absorption runs before the greedy left/right
   matcher.  It is deliberately narrow: it only removes a numerator and an
   MB-dependent denominator with identical MB slopes, and it only fires when
   the MB-dependent denominator count strictly decreases. *)
mbeMBDependentDenominatorGammaCount[wk_List, vars_List] :=
  Count[wk, {arg_, s_} /; TrueQ[s < 0] &&
    ! FreeQ[arg, Alternatives @@ vars]];

mbeSameOrientationGammaArgsQ[a_, b_, vars_List, ass_:True] := Module[
  {ca, cb},
  ca = FullSimplify[Coefficient[Together[a], #], ass] & /@ vars;
  cb = FullSimplify[Coefficient[Together[b], #], ass] & /@ vars;
  AnyTrue[ca, ! TrueQ[FullSimplify[# == 0, ass]] &] &&
    And @@ MapThread[TrueQ[FullSimplify[#1 == #2, ass]] &, {ca, cb}]];

mbePositiveIntegerDifferenceQ[d_, ass_:True] := Module[{ds},
  ds = Quiet @ FullSimplify[d, ass];
  (IntegerQ[ds] && TrueQ[ds > 0]) ||
    TrueQ[FullSimplify[Element[ds, Integers] && ds > 0, ass]]];

mbePositiveContourRealQ[arg_, contourRules_, ass_:True] := Module[{rho},
  rho = If[contourRules === {},
    Quiet @ FullSimplify[ComplexExpand[Re[arg]], ass],
    mbeContourRealPart[arg, contourRules, ass]];
  TrueQ[FullSimplify[rho > 0, ass]]];

mbeFindSameOrientationDenomAbsorption[wk_List, vars_List,
    contourRules_: {}, ass_:True] := Catch[Module[
  {denInds, numInds, b, a, d, intQ, dPosQ, aPosQ},
  denInds = Select[Range[Length[wk]], wk[[#, 2]] < 0 &&
      ! FreeQ[wk[[#, 1]], Alternatives @@ vars] &];
  Do[
    b = wk[[di, 1]];
    numInds = Select[Range[Length[wk]], wk[[#, 2]] > 0 &&
        mbeSameOrientationGammaArgsQ[wk[[#, 1]], b, vars, ass] &];
    Do[
      a = wk[[ni, 1]];
      d = Quiet @ FullSimplify[b - a, ass];
      If[! FreeQ[d, Alternatives @@ vars], Continue[]];
      dPosQ = mbePositiveContourRealQ[d, contourRules, ass];
      If[! TrueQ[dPosQ], Continue[]];
      intQ = mbePositiveIntegerDifferenceQ[d, ass];
      If[intQ,
        Throw[<|"Rule" -> "SameOrientationIntegerRatio",
          "Indices" -> Sort[{ni, di}], "BetaPair" -> None,
          "Multiplier" -> 1/Pochhammer[a, d],
          "NumeratorArg" -> a, "DenominatorArg" -> b,
          "Difference" -> d|>]];
      aPosQ = contourRules =!= {} &&
        mbePositiveContourRealQ[a, contourRules, ass];
      If[TrueQ[aPosQ],
        Throw[<|"Rule" -> "SameOrientationBetaRatio",
          "Indices" -> Sort[{ni, di}], "BetaPair" -> {a, d},
          "Multiplier" -> 1/Gamma[d],
          "NumeratorArg" -> a, "DenominatorArg" -> b,
          "Difference" -> d|>]],
      {ni, numInds}],
    {di, denInds}];
  None]];

(* ------------------------------------------------------------------
   BLOCK 5: Beta -> Euler
   ------------------------------------------------------------------ *)

mbePrefactorBaseInVar[nonBetaExpr_, zj_, zVars_List, ass_:True] := Module[{base},
  base = Simplify[Exp[D[Log[nonBetaExpr], zj]], ass];
  If[!FreeQ[base, Alternatives@@zVars], $Failed, base]];

mbeAffineLinearFormQ[arg_, vars_List] :=
  PolynomialQ[arg, vars] &&
  And@@Thread[Exponent[Expand[arg], vars]<=1] &&
  !FreeQ[arg, Alternatives@@vars];

mbeFactorBasePower[f_] :=
  If[MatchQ[f, Power[_, n_Integer?Positive]], {f[[1]], f[[2]]}, {f, 1}];

mbeChoosePositiveLinearForm[lin_, contourRules_, ass_:True] := Module[{rho},
  rho = mbeContourRealPart[lin, contourRules, ass];
  Which[TrueQ[FullSimplify[rho>0,ass]],  lin,
        TrueQ[FullSimplify[-rho>0,ass]], -lin,
        True, $Failed]];

mbeCollectAuxLinearForms[nonBetaExpr_, zVars_List, contourRules_, ass_:True] := Module[
  {den, facs, aux = {}, base, pow, fac, constPart, rest, oriented},
  den = Factor[Denominator[Together[nonBetaExpr]]];
  facs = mbeFactors[den];
  Do[
    {base, pow} = mbeFactorBasePower[facs[[i]]];
    fac = FactorTermsList[Together[base]];
    constPart = fac[[1]]; rest = Times @@ Rest[fac];
    If[FreeQ[constPart, Alternatives@@zVars] && mbeAffineLinearFormQ[rest, zVars],
      oriented = mbeChoosePositiveLinearForm[rest, contourRules, ass];
      If[oriented=!=$Failed,
        AppendTo[aux, <|"OriginalFactor"->base,"ConstPart"->constPart,
          "LinearForm"->oriented,"Power"->pow|>]]],
    {i, Length[facs]}];
  aux];

(* ------------------------------------------------------------------
   BLOCK 6: Euler orientation
   ------------------------------------------------------------------ *)

mbeUnitIntervalAssumptions[vars_List] :=
  And @@ Join[Thread[vars>0], Thread[vars<1]];

mbeXListFromEulerReport[eulerReport_, ass_:True] :=
  Simplify[#, ass]& /@ eulerReport["deltaList"];

mbeVarOccursOnlyAsOneMinusQ[xList_, v_] := Module[{uu = Unique["u"], tmp},
  If[FreeQ[xList, v], Return[False]];
  tmp = xList /. {(1-v)->uu, (-1+v)->-uu};
  FreeQ[tmp, v]];

mbeCanonicalPositiveX[x_, unitVars_List, ass_:True] := Module[{fullAss, y},
  fullAss = And @@ Flatten[{ass, mbeUnitIntervalAssumptions[unitVars]}];
  y = Simplify[x, fullAss];
  Which[TrueQ[FullSimplify[y>0,fullAss]], y,
        TrueQ[FullSimplify[y<0,fullAss]], Simplify[-y, fullAss],
        True, y]];

(* ------------------------------------------------------------------
   BLOCK 7: Delta reduction
   ------------------------------------------------------------------ *)

mbeManualRealRoot[constraint_, pivot_, activeAss_] := Module[
  {xExpr, num, den, numDeg, denDeg, deg, rhsExpr, testPt, testVal, realSol, check},
  xExpr = Together[constraint]; num = Numerator[xExpr]; den = Denominator[xExpr];
  numDeg = If[PolynomialQ[num,pivot], Exponent[num,pivot], 0];
  denDeg = If[PolynomialQ[den,pivot], Exponent[den,pivot], 0];
  Which[
    numDeg>=2 && denDeg==0,
      deg = numDeg;
      With[{togExpr = Together[constraint-1]},
        With[{nn = Numerator[togExpr]},
          With[{lc = Coefficient[nn,pivot,deg], ct = (nn/.pivot->0)},
            If[lc===0, Return[{}]];
            If[!And@@Table[Coefficient[nn,pivot,k]===0,{k,1,deg-1}],Return[{}]];
            rhsExpr = Simplify[-ct/lc, activeAss]]]],
    denDeg>=2 && numDeg==0,
      deg = denDeg;
      With[{dlc = Coefficient[den,pivot,deg], dct = (den/.pivot->0)},
        If[dlc===0, Return[{}]];
        If[!And@@Table[Coefficient[den,pivot,k]===0,{k,1,deg-1}],Return[{}]];
        If[dct=!=0, Return[{}]];
        rhsExpr = Simplify[num/dlc, activeAss]],
    True, Return[{}]];
  testPt = Cases[activeAss, (v_>0):>(v->1/2), Infinity];
  If[testPt==={}, testPt = Cases[activeAss, (0<v_<1):>(v->1/2), Infinity]];
  testVal = rhsExpr/.testPt;
  If[!NumberQ[testVal]||testVal<=0,
    rhsExpr = Simplify[-rhsExpr, activeAss]; testVal = rhsExpr/.testPt;
    If[!NumberQ[testVal]||testVal<=0, Return[{}]]];
  If[!TrueQ[Simplify[rhsExpr>0, activeAss]], Return[{}]];
  With[{posRhs = Simplify[rhsExpr/. {(-1+v_):>-(1-v)}, activeAss]},
    realSol = {pivot -> Simplify[Power[posRhs,1/deg], activeAss]}];
  check = Simplify[(pivot/.realSol)>0, activeAss];
  If[!TrueQ[check],
    check = FullSimplify[PowerExpand[pivot/.realSol]>0, activeAss];
    If[!TrueQ[check], Return[{}]]];
  realSol];

mbeScoredCandidate[xExpr_, var_, tVars_List, uVars_List, fullAss_, allConstraints_List:{}] := Module[
  {isU, degree, sols, nSols, solComplexity, constraintCount},
  isU = MemberQ[uVars, var];
  constraintCount = If[allConstraints=!={}, Count[allConstraints, x_/;!FreeQ[x,var]], 1];
  degree = If[PolynomialQ[Together[xExpr],var], Exponent[Together[xExpr],var], 99];
  sols = Quiet[Solve[xExpr==1, var]];
  nSols = If[Head[sols]===List, Length[sols], 0];
  solComplexity = If[nSols>=1, Min[LeafCount[var/.#]& /@ sols], 9999];
  <|"Variable"->var, "IsAuxiliary"->isU, "Degree"->degree,
    "NumSolutions"->nSols, "SolutionComplexity"->solComplexity,
    "Score"->{If[isU,0,1], constraintCount, If[degree<=1,0,1],
              If[nSols>=1,0,1], solComplexity}|>];

(* ------------------------------------------------------------------
   BLOCK 8: Support absorption
   ------------------------------------------------------------------ *)

mbeConstraintVars[expr_, vars_List] := Select[vars, !FreeQ[expr,#]&];

mbeSupportPivotCandidates[lhs_, rhs_, remVars_List, cubeVars_List, ass_:True] := Module[
  {varsHere, fullAss, sols, valid, deg},
  varsHere = mbeConstraintVars[rhs, remVars];
  fullAss = ass && mbeUnitIntervalAssumptions[Join[remVars, cubeVars]];
  Table[
    sols = Quiet[Solve[lhs==rhs, v]];
    If[Head[sols]=!=List, sols={}];
    valid = Select[sols, TrueQ[FullSimplify[0<(v/.#)<1,fullAss]]&];
    deg = Quiet@Exponent[Numerator[Together[lhs-rhs]]*Denominator[Together[lhs-rhs]],v];
    <|"Variable"->v,"AllSolutions"->sols,"ValidSolutions"->valid,
      "UniqueValidQ"->(Length[valid]==1),"Degree"->deg,
      "SolutionLeafCount"->If[Length[valid]==1,LeafCount[First[valid]],Infinity]|>,
    {v, varsHere}]];


(* ====================================================================
   PUBLIC IMPLEMENTATIONS  -- MB->Euler Blocks
   ==================================================================== *)

MBEPreprocessPolygamma[integrand_, mbVars_List, contourRules_List:{}] := Module[
  {pgs, modIntegrand, mainBinomial, auxParams={}, auxAssumptions={}, derivOps={},
   pgInfo={}, rationalCorrections={}, shiftInfoList={},
   polygammaIntegralVars={}, groupShiftInfo={}, bellPending={}, allShiftRule,
   m, arg, mult, aa, gammaRatio, i, q, shiftN, downN, netShift, shiftedArg, correction,
   reOnContour, sVar, intRepFactor, replacementSummary, replacements,
   shiftedGroupIdx, jChoices, mainJTuple, allJTuples, correctionJTuples,
   jTuple, correctionIntegrand, kk, hasPoly, bellGroupQ},
  $mbeAuxCounter = 0;
  $mbePolygammaIntegralCounter = 0;
  pgs = mbeDetectPolygammasMult[integrand, mbVars];
  If[pgs==={}, Return[<|"ModifiedIntegrand"->integrand,"AuxParameters"->{},
    "AuxAssumptions"->True,"DerivativeOperations"->{},
    "PolygammaIntegralVars"->{},
    "PolygammaInfo"->{},"HasPolygamma"->False,
    "RationalCorrections"->{},"ShiftInfo"->{},
    "MainBinomial"->integrand|>]];
  modIntegrand = integrand;
  (* MainBinomial = integrand with each PolyGamma[m, arg] replaced by
     PolyGamma[m, shiftedArg] (binomial j=k term in ORIGINAL polygamma form
     -- used for numerical fallback when Block 5 fails for the main path). *)
  mainBinomial = integrand;
  (* ============================================================
     PHASE 1: Per-group shift computation + aux/intrep substitution
     into modIntegrand (the all-main path). Shift info is saved in
     groupShiftInfo for the cross-product correction enumeration
     in Phase 2 below.
     ============================================================ *)
  Do[
    m = pgs[[i]]["Order"]; arg = pgs[[i]]["Argument"]; mult = pgs[[i]]["Multiplicity"];
    (* Bell single-aux reduction for psi0^mult. Context-discriminated gate:
       - mult>=3: always Bell (needed for speed, correct there).
       - mult==2: Bell ONLY inside a Part-B correction recursion ($mbInPartBCorrection).
         ROOT CAUSE: the Bell main psi0^mult -> Gamma[shiftedArg+aa]/Gamma[shiftedArg]
         loses the 2nd cumulant (psi1) in the Gamma->Euler (Block 5) conversion, so for
         mult==2 the main yields Int F.psi0^2 instead of Int F.B2; the -psi1 correction
         then over-subtracts. This pathology hits ANY top-level mult==2 (sole-group AND
         multi-group, e.g. piece 92), so Length[pgs] is NOT a valid discriminator.
         Inside Part-B corrections the psi0^2 is a MONOMIAL factor (d34/d33/d30 sub-terms)
         where per-occurrence leaks and Bell is correct. So: top-level mult==2 ->
         per-occurrence; Part-B-correction mult==2 -> Bell. *)
    bellGroupQ = (m === 0 && (mult >= 3 || (mult == 2 && TrueQ[Global`$mbInPartBCorrection])))
                 && ! TrueQ[Global`$mbUseCumulant];
    shiftN = 0; downN = 0; reOnContour = None;
    (* The UP-shift (Re(arg)<=0 -> Re>0) applies to ALL groups, INCLUDING the Bell
       group: at Re(arg)<=0 a coexisting psi^(m>=1) MUST up-shift (its integral rep
       diverges otherwise), so the Bell psi0^mult must up-shift to the SAME argument or
       the decomposition desyncs (piece 34: psi0^2 psi1 at z24=-1.31 gave 449 vs 84.5).
       Only the DOWN-shift is restricted (m=0 non-Bell). *)
    If[contourRules=!={},
      reOnContour = mbeContourRealPart[arg, contourRules];
      If[!TrueQ[reOnContour>0],
        (* Up-shift: bring Re(arg) > 0 *)
        shiftN = mbeShiftCount[arg, contourRules];
        If[shiftN===$Failed, shiftN=0];
        If[shiftN>0,
          Print["[Block 0] PolyGamma[",m,", ",arg,"]^",mult,": Re=",reOnContour,
            " on contour. Up-shift by N=",shiftN," -> Re=",
            mbeContourRealPart[arg+shiftN,contourRules]]],
        (* Else: down-shift to keep Re(arg) in (0,1] -- for m=0 NON-Bell (aux Gamma-ratio),
           AND for a SOLE-group Bell psi0^mult (Length[pgs]==1).  For m>=1 the integral rep
           converges for any Re(arg)>0.  Down-shifting a Bell group is gated to the sole-group
           case because with COEXISTING groups it desyncs (broke piece 9 = psi0(1+z)^2 psi1(1+z),
           2.454 vs 0.00292 -- TWO groups).  But a LONE Bell group at Re(arg)>1 (no coexisting
           group to desync with) MUST down-shift: leaving arg at Re>1 makes the Block-5 Gamma->
           Euler conversion drop the higher Bell cumulants -> wrong REAL part.  This fixes
           eps^-1 piece 257 (psi0(2+z24)^3, Re=1.10: Bell 1.083 -> truth -1.818) with zero
           regression -- census-verified the only sole-group Bell pieces needing a down-shift
           are {257; and 53-56,58,eps^-2 14 which are value-unchanged by the exact down-shift}. *)
        If[m == 0 && (! bellGroupQ || Length[pgs] == 1),
          downN = mbeDownShiftCount[arg, contourRules];
          (* Audit hook: log every down-shift NEWLY ENABLED by the sole-group relaxation
             (old gate was m==0 && !bellGroupQ). Covers top-level AND Part-B recursion. *)
          If[downN > 0 && bellGroupQ && Length[pgs] == 1 && TrueQ[Global`$mbLogNewDownshift],
            AppendTo[Global`$mbNewDownshiftLog,
              <|"Arg" -> arg, "Mult" -> mult, "PartB" -> TrueQ[Global`$mbInPartBCorrection],
                "DownN" -> downN|>]];
          If[downN>0,
            Print["[Block 0] PolyGamma[",m,", ",arg,"]^",mult,": Re=",reOnContour,
              " on contour. Down-shift by N=",downN," -> Re=",
              mbeContourRealPart[arg-downN,contourRules]]]]]];
    netShift = shiftN - downN;
    shiftedArg = arg + netShift;
    correction = Which[
      shiftN > 0, mbePolygammaShiftCorrection[m, arg, shiftN],
      downN > 0, mbePolygammaDownShiftCorrection[m, arg, downN],
      True, 0];
    (* Save per-group shift info for Phase 2 cross-product enumeration. *)
    AppendTo[groupShiftInfo, <|
      "Order" -> m, "Argument" -> arg, "Multiplicity" -> mult,
      "ShiftN" -> shiftN, "DownN" -> downN, "NetShift" -> netShift,
      "ShiftedArg" -> shiftedArg, "Correction" -> correction,
      "IsBell" -> bellGroupQ, "ReOnContour" -> reOnContour|>];
    (* Build mult independent aux/intrep replacements for THIS group's main path. *)
    If[bellGroupQ,
      (* === Bell single-aux reduction: psi0(arg)^mult ===
         main path: psi0(arg)^mult -> Gamma[arg+aa]/Gamma[arg]; in MBEApplyPolygammaLimit
         take mult! [aa^mult] -> the complete Bell polynomial B_mult.  Then subtract the
         lower Bell terms (B_mult - psi0^mult) as a correction routed through Part B
         (recursive Block 0).  ONE aux instead of mult -> no cross-product explosion. *)
      Module[{bellComplete, bellLower, iiB},
        aa = mbeNextAux[];
        AppendTo[auxParams, aa]; AppendTo[auxAssumptions, aa > 0];
        AppendTo[derivOps, <|"Type" -> "psi0_power_bell", "Order" -> 0, "Power" -> mult,
          "Argument" -> arg, "ShiftedArgument" -> shiftedArg, "ShiftN" -> shiftN, "AuxA" -> aa, "AuxB" -> None|>];
        (* MAIN path: psi0(arg)^mult -> Gamma[shiftedArg+aa]/Gamma[shiftedArg] (the complete
           Bell polynomial B_mult at the SHIFTED arg, via mult![aa^mult] in
           MBEApplyPolygammaLimit). shiftedArg = arg + shiftN keeps Re>0 (consistent with
           coexisting up-shifted polygammas). *)
        modIntegrand = modIntegrand /. Power[PolyGamma[0, arg], mult] :> Gamma[shiftedArg + aa]/Gamma[shiftedArg];
        bellComplete = mult! SeriesCoefficient[
           Series[Gamma[shiftedArg + iiB]/Gamma[shiftedArg], {iiB, 0, mult}], mult];
        bellLower = Expand[bellComplete - PolyGamma[0, shiftedArg]^mult];
        (* DEFER the -bellLower correction (converts main B_mult(shiftedArg) -> psi0(shiftedArg)^mult:
           main + (-bellLower) = psi0(shiftedArg)^mult).  The UP-SHIFT binomial
           (psi0(shiftedArg)+cShift)^mult = psi0(arg)^mult + its cross terms with OTHER shifted
           groups are handled by the SHARED Phase-2 cross-product (Bell NOT excluded; emitting it
           here too double-counted -> piece-34 +7.589 bug).  CRITICAL for multi-group (#33
           psi0(-z)*psi0(1+z)^3): the -bellLower correction must multiply the OTHER groups in their
           SHIFTED form (matching the main's config) so Part B does NOT re-shift them and spawn
           spurious (other-group-shift x bellLower) cross terms.  But other groups' shifts aren't
           all known yet here -> store PENDING and emit after the loop with allShiftRule applied. *)
        AppendTo[bellPending, <|"Arg" -> arg, "Mult" -> mult, "BellLower" -> bellLower|>];
        replacementSummary = {"psi0_power_bell", mult, aa}],
      (* === existing per-occurrence path === *)
      replacements = Table[None, {mult}];
      Do[
        If[m==0,
          aa = mbeNextAux[];
          AppendTo[auxParams, aa]; AppendTo[auxAssumptions, aa>0];
          gammaRatio = Gamma[shiftedArg+aa]/Gamma[shiftedArg];
          AppendTo[derivOps, <|"Type"->"psi0","Order"->0,"Argument"->arg,
            "ShiftedArgument"->shiftedArg,"ShiftN"->shiftN,"AuxA"->aa,"AuxB"->None|>];
          replacements[[q]] = gammaRatio,
          (* m >= 1 *)
          sVar = mbeNextPolygammaIntegralVar[];
          AppendTo[polygammaIntegralVars, sVar];
          intRepFactor = -sVar^(shiftedArg - 1) * Log[sVar]^m / (1 - sVar);
          AppendTo[derivOps, <|"Type"->"psiM_integral","Order"->m,"Argument"->arg,
            "ShiftedArgument"->shiftedArg,"ShiftN"->netShift,"IntegralVar"->sVar|>];
          replacements[[q]] = intRepFactor],
        {q, mult}];
      modIntegrand = mbeReplacePolyOccurrences[modIntegrand, m, arg, replacements];
      replacementSummary = replacements];
    (* Update mainBinomial: replace each ψ(m, arg) with ψ(m, shiftedArg). *)
    If[netShift != 0,
      mainBinomial = mainBinomial /. {
        Power[PolyGamma[m, arg], k_Integer?Positive] :> PolyGamma[m, shiftedArg]^k,
        PolyGamma[m, arg] :> PolyGamma[m, shiftedArg]
      }];
    AppendTo[pgInfo,<|"OriginalPolygamma"->PolyGamma[m,arg],"Multiplicity"->mult,
      "OriginalArgument"->arg,"ShiftedArgument"->shiftedArg,"ShiftN"->shiftN,
      "ReOnContour"->reOnContour,
      "ReShiftedOnContour"->If[contourRules=!={},mbeContourRealPart[shiftedArg,contourRules],None],
      "Replacements"->replacementSummary|>];
    AppendTo[shiftInfoList,<|"Arg"->arg,"Order"->m,"Multiplicity"->mult,
      "ShiftN"->shiftN,"ReOnContour"->reOnContour|>],
    {i, Length[pgs]}];
  (* ============================================================
     DEFERRED Bell -bellLower corrections.  Now that ALL groups' shifts are known,
     build a rule that maps every group's PolyGamma[m,arg] -> PolyGamma[m,shiftedArg], and
     emit each pending Bell group's -bellLower correction with the OTHER groups already in
     their SHIFTED form.  This makes the correction align with the main path's config so Part B
     does not re-shift the other groups (which would spawn spurious shift x bellLower cross
     terms -- the #33 failure).  The Bell group's own up-shift binomial + cross terms come from
     Phase 2 below; this emits ONLY the Bell-specific -bellLower remainder. *)
  allShiftRule = DeleteCases[
    Table[PolyGamma[gi["Order"], gi["Argument"]] -> PolyGamma[gi["Order"], gi["ShiftedArg"]],
      {gi, groupShiftInfo}],
    (p_ -> p_)];
  If[! TrueQ[Global`$mbBellSkipCorr],
    Do[Module[{fBase, fBaseShifted, corrTerms},
      fBase = integrand /. Power[PolyGamma[0, pend["Arg"]], pend["Mult"]] :> 1;
      fBaseShifted = fBase /. allShiftRule;
      corrTerms = If[Head[pend["BellLower"]] === Plus, List @@ pend["BellLower"], {pend["BellLower"]}];
      Do[Module[{fullIg = Expand[-fBaseShifted ct]},
        AppendTo[rationalCorrections, <|"Integrand" -> fullIg,
          "HasPolygamma" -> ! FreeQ[fullIg, PolyGamma[_Integer, _]],
          "JTuple" -> {}, "Multiplicity" -> {}, "ShiftedArgs" -> {}, "Corrections" -> {}|>]],
        {ct, corrTerms}]],
      {pend, bellPending}]];
  (* ---- MULTI-BELL-GROUP inclusion-exclusion correction ----
     The per-group deferred -bellLower loop above OVER-COUNTS the pairwise
     bL_i*bL_j cross terms: each deferred correction leaves the OTHER Bell
     groups in full psi0^mult form, which Part B re-Bell-reduces, regenerating
     bL_i bL_j once more.  For two Bell groups A,B the correct decomposition is
     (B_A - bL_A)(B_B - bL_B) = B_A B_B - bL_A B_B - bL_B B_A + bL_A bL_B, but
     the loop above yields that + bL_A bL_B (verified numerically on piece 30:
     error = +Int F psi1(A) psi1(B) to 1e-12).  Subtract the over-count with one
     correction -base*bL_A*bL_B per pair (base = integrand with ALL Bell psi0^mult
     removed, shifted).  bL is at the shifted arg, m>=1 only for the mult-2 groups
     that occur here -> clean integral-rep, no further Bell nesting.
     MB14 eps^-1 has at most TWO psi0-power groups (weight<=4), so pairs suffice. *)
  If[! TrueQ[Global`$mbBellSkipCorr] && Length[bellPending] >= 2,
    Module[{baseAll, pairs, prodTerms},
      baseAll = (integrand /. Table[
          Power[PolyGamma[0, bp["Arg"]], bp["Mult"]] :> 1, {bp, bellPending}]) /. allShiftRule;
      If[Length[bellPending] >= 3,
        Print["[Block 0] WARNING: ", Length[bellPending],
          " Bell groups present; pairwise IE correction covers 2 only (3+ untested)."]];
      pairs = Subsets[Range[Length[bellPending]], {2}];
      Do[
        prodTerms = Expand[bellPending[[pr[[1]]]]["BellLower"] bellPending[[pr[[2]]]]["BellLower"]];
        prodTerms = If[Head[prodTerms] === Plus, List @@ prodTerms, {prodTerms}];
        Do[Module[{fullIg = Expand[-baseAll ct]},
          AppendTo[rationalCorrections, <|"Integrand" -> fullIg,
            "HasPolygamma" -> ! FreeQ[fullIg, PolyGamma[_Integer, _]],
            "JTuple" -> {}, "Multiplicity" -> {}, "ShiftedArgs" -> {}, "Corrections" -> {}|>]],
          {ct, prodTerms}],
        {pr, pairs}]]];
  (* ============================================================
     PHASE 2: Cross-product (Cartesian) enumeration of corrections.

     For each group g, ψ(m_g, arg_g)^mult_g shifts as
        (ψ(m_g, shifted_g) + c_g)^mult_g
        = Σ_{j_g=0..mult_g} C(mult_g,j_g) ψ_shifted^j_g c_g^(mult_g - j_g)
     The product over all groups expands to a Cartesian sum of (mult_g+1)
     terms per group. The all-main tuple (j_g = mult_g for every g) is
     handled separately as `modIntegrand` above; every OTHER j-tuple
     becomes one correction (which may still carry shifted polygamma
     factors -- those are processed by Part B's recursive Block 0 call
     without further shifting, since their args are already canonical).

     This replaces the previous per-group correction loop, which
     generated only |S|=1 subsets and silently dropped all |S|>=2
     cross terms (e.g. c_1*c_2 in two-polygamma cases). The cross-product
     approach generates each cross-term exactly once, no double-counting.
     ============================================================ *)
  (* Bell groups ARE included here: the Bell branch now emits ONLY -bellLower (converting
     B_mult(shiftedArg) -> psi0(shiftedArg)^mult); the UP-SHIFT binomial
     (psi0(shiftedArg)+cShift)^mult and its CROSS terms with other shifted groups are produced
     by this shared cross-product machinery.  (Earlier the Bell branch emitted the binomial too
     AND was excluded here -- but that dropped multi-group cross terms, breaking #33
     psi0(-z)*psi0(1+z)^3.  Now: binomial from Phase 2, bellLower from the Bell correction --
     disjoint, no double-count.) *)
  shiftedGroupIdx = Select[Range[Length[pgs]],
    groupShiftInfo[[#]]["NetShift"] != 0 &];
  If[Length[shiftedGroupIdx] > 0,
    jChoices = Table[
      If[MemberQ[shiftedGroupIdx, i],
        Range[0, groupShiftInfo[[i]]["Multiplicity"]],
        {groupShiftInfo[[i]]["Multiplicity"]}],
      {i, Length[pgs]}];
    mainJTuple = #["Multiplicity"] & /@ groupShiftInfo;
    allJTuples = Tuples[jChoices];
    correctionJTuples = DeleteCases[allJTuples, mainJTuple];
    Do[
      jTuple = correctionJTuples[[kk]];
      correctionIntegrand = integrand;
      Do[
        Module[{mm = groupShiftInfo[[i]]["Order"],
                aa2 = groupShiftInfo[[i]]["Argument"],
                mm2 = groupShiftInfo[[i]]["Multiplicity"],
                jj = jTuple[[i]],
                cc2 = groupShiftInfo[[i]]["Correction"],
                ss = groupShiftInfo[[i]]["ShiftedArg"],
                coeff, shifted},
          coeff = Binomial[mm2, jj];
          shifted = PolyGamma[mm, ss];
          correctionIntegrand = correctionIntegrand /. {
            Power[PolyGamma[mm, aa2], mm2] :>
              (* Round 26b: guard 0^0.  A non-shifted group (cc2=0) with
                 jj=mm2 gives cc2^(mm2-jj)=0^0 -> Indeterminate in Mathematica,
                 which silently poisoned the whole correction integrand and
                 dropped the rational-correction (Part B) term. The binomial
                 factor c^(m-j) is 1 by definition when m-j=0. *)
              coeff * shifted^jj * If[mm2 - jj == 0, 1, cc2^(mm2 - jj)],
            PolyGamma[mm, aa2] :>
              If[mm2 == 1,
                If[jj == 1, shifted, cc2],
                PolyGamma[mm, aa2]]
          }],
        {i, Length[pgs]}];
      correctionIntegrand = Expand[correctionIntegrand];
      hasPoly = !FreeQ[correctionIntegrand, PolyGamma[_Integer, _]];
      AppendTo[rationalCorrections, <|
        "Integrand" -> correctionIntegrand,
        "JTuple" -> jTuple,
        "HasPolygamma" -> hasPoly,
        "Multiplicity" -> mainJTuple,
        "ShiftedArgs" -> (#["ShiftedArg"] & /@ groupShiftInfo),
        "Corrections" -> (#["Correction"] & /@ groupShiftInfo)|>],
      {kk, Length[correctionJTuples]}]];
  <|"ModifiedIntegrand"->modIntegrand,
    "MainBinomial"->mainBinomial,
    "AuxParameters"->auxParams,
    "AuxAssumptions"->And@@Join[auxAssumptions,Table[p<1,{p,auxParams}]],
    "PolygammaIntegralVars"->polygammaIntegralVars,
    "DerivativeOperations"->derivOps,"PolygammaInfo"->pgInfo,
    "HasPolygamma"->True,"RationalCorrections"->rationalCorrections,
    "ShiftInfo"->shiftInfoList|>];

MBEApplyPolygammaLimit[expr_, pgResult_] := Module[
  {result=expr, ops, aa, bb, m, seriesResult, coeff, opType, kPow},
  If[!pgResult["HasPolygamma"], Return[expr]];
  (* Propagate Failure[] cleanly -- never try to Series on a Failure *)
  If[!FreeQ[expr, _Failure], Return[expr]];
  ops = pgResult["DerivativeOperations"];
  Do[
    opType = ops[[i]]["Type"];
    Which[
      opType==="psi0",
        aa = ops[[i]]["AuxA"];
        seriesResult = Series[result, {aa,0,1}];
        coeff = SeriesCoefficient[seriesResult, 1];
        If[coeff===Indeterminate || !FreeQ[coeff,Indeterminate],
          With[{ge = 1/aa - EulerGamma + (EulerGamma^2/2+Pi^2/12)*aa},
            coeff = SeriesCoefficient[Series[result/.Gamma[aa]->ge,{aa,0,1}],1]]];
        result = Simplify[coeff],
      opType==="psi0_power_bell",
        (* Bell single-aux: mult![aa^mult] of Gamma[arg+aa]/Gamma[arg] = complete Bell
           polynomial B_mult; the lower Bell terms were subtracted as a Part-B correction. *)
        aa = ops[[i]]["AuxA"]; kPow = ops[[i]]["Power"];
        seriesResult = Series[result, {aa, 0, kPow}];
        coeff = kPow! SeriesCoefficient[seriesResult, kPow];
        result = Simplify[coeff],
      opType==="psiM",
        aa = ops[[i]]["AuxA"]; bb = ops[[i]]["AuxB"]; m = ops[[i]]["Order"];
        seriesResult = Series[result, {aa,0,1}];
        coeff = SeriesCoefficient[seriesResult, 1];
        If[coeff===Indeterminate || !FreeQ[coeff,Indeterminate],
          With[{ge = 1/aa - EulerGamma + (EulerGamma^2/2+Pi^2/12)*aa},
            coeff = SeriesCoefficient[Series[result/.Gamma[aa]->ge,{aa,0,1}],1]]];
        coeff = SeriesCoefficient[Series[coeff,{bb,0,m}],m]*m!;
        result = Simplify[coeff],
      opType==="psiM_integral",
        (* Integral representation already evaluated -- no-op *)
        Null,
      opType==="psi0_integral",
        (* m=0 integral representation already evaluated -- no-op.
           γ-pieces cancel after cube integration. *)
        Null],
    {i, Length[ops]}];
  result];

MBENormalizeContour[expr_, contourRules_, ass_:True, max_:50] :=
  expr /. g_Gamma :> mbeNormalizeOneGamma[g, contourRules, ass, max];

MBEGammaPositivityReport[expr_, contourRules_, ass_:True] := Module[{gl},
  gl = mbeTopLevelGammaList[expr];
  Table[<|"Arg"->gl[[i,1]],"Side"->If[gl[[i,2]]>0,"Numerator","Denominator"],
    "ReOnContour"->mbeContourRealPart[gl[[i,1]],contourRules,ass],
    "PositiveQ"->TrueQ@FullSimplify[mbeContourRealPart[gl[[i,1]],contourRules,ass]>0,ass]|>,
    {i, Length[gl]}]];

MBEAllGammaPositiveQ[expr_, contourRules_, ass_:True] :=
  And@@(#["PositiveQ"]& /@ MBEGammaPositivityReport[expr, contourRules, ass]);

MBENormalizeSlope[expr_, mbVars_List] :=
  expr /. g_Gamma :> mbeNormalizeOneGammaSlope[g, mbVars];

MBECheckBalance[expr_, mbVars_List, ass_:True] := Module[{perVar},
  perVar = mbeVariableBalanceReport[expr, #, ass]& /@ mbVars;
  <|"PerVariable"->perVar,
    "BalancedInAllVariablesQ"->And@@(#["BalancedQ"]& /@ perVar),
    "UnitSlopeSupportedInAllVariablesQ"->And@@(#["UnitSlopeOnlyQ"]& /@ perVar),
    "ReadyForBetaPairingQ"->And@@((#["BalancedQ"]&&#["UnitSlopeOnlyQ"])& /@ perVar)|>];

MBEGammaToBeta[expr_, mbVars_List, ass_:True, contourRules_:{}] := Module[
  {bal, nonG, wk, betaPairs={}, logs={}, varOrder, var, cands, best, left,
   wkNet, denomBefore, wkCandidate, denomAfter},
  bal = MBECheckBalance[expr, mbVars, ass];
  If[!TrueQ[bal["ReadyForBetaPairingQ"]],
    Return[Failure["NotReadyForBetaPairing",<|"BalanceReport"->bal|>]]];
  nonG = mbeNonGammaPart[expr]; wk = mbeTopLevelGammaList[expr];
  (* res4 colliding-poles pinch fix, 2026-06-29: absorb
     same-orientation numerator/denominator Γ-ratios before the greedy
     left/right pairing can strand an MB-dependent denominator. *)
  While[True,
    best = mbeFindSameOrientationDenomAbsorption[wk, mbVars, contourRules, ass];
    If[best === None, Break[]];
    denomBefore = mbeMBDependentDenominatorGammaCount[wk, mbVars];
    wkCandidate = Delete[wk, List /@ Reverse @ Sort[best["Indices"]]];
    denomAfter = mbeMBDependentDenominatorGammaCount[wkCandidate, mbVars];
    If[! TrueQ[denomAfter < denomBefore], Break[]];
    AppendTo[logs,<|"Stage"->"SameOrientationDenomAbsorption",
      "Pairing"->best|>];
    nonG = Simplify[nonG*best["Multiplier"], ass];
    If[best["BetaPair"] =!= None, AppendTo[betaPairs,best["BetaPair"]]];
    wk = wkCandidate];
  While[True,
    cands = mbeCollectAllBetaCandidates[wk,mbVars,ass];
    best = mbeChooseBestDenominatorCancellationCandidate[cands];
    If[best===None, Break[]];
    AppendTo[logs,<|"Stage"->"DenomCancelPrepass","Pairing"->best|>];
    AppendTo[betaPairs,best["BetaPair"]]; wk = mbeApplyChosenPair[wk,best]];
  While[True,
    cands = mbeCollectCrossVariableBetaCandidates[wk,mbVars,ass];
    If[cands==={}, Break[]];
    best = First@SortBy[cands,{#["SupportCount"]&,#["LeafCount"]&}];
    AppendTo[logs,<|"Stage"->"CrossVarPrepass","Pairing"->best|>];
    AppendTo[betaPairs,best["BetaPair"]]; wk = mbeApplyChosenPair[wk,best]];
  varOrder = SortBy[mbVars,-Count[wk,{a_,_}/;mbeArgDependsOnVarQ[a,#,ass]]&];
  Do[
    While[True,
      cands = mbeCollectBetaCandidates[wk,var,mbVars,ass];
      best = mbeChooseBestBetaCandidate[cands];
      If[best===None, Break[]];
      AppendTo[logs,<|"Stage"->"GreedyPairing","Variable"->var,"Pairing"->best|>];
      AppendTo[betaPairs,best["BetaPair"]]; wk = mbeApplyChosenPair[wk,best]];
    left = Select[wk,mbeArgDependsOnVarQ[#[[1]],var,ass]&];
    AppendTo[logs,<|"Stage"->"AfterVariable","Variable"->var,"Remaining"->left|>],
    {var, varOrder}];
  wkNet = mbeUnitGammaListNet[wk, ass];
  <|"VariableOrder"->varOrder,"NonGammaFactor"->nonG,"BetaPairs"->betaPairs,
    "RemainingGammaList"->wkNet,"GammaPrefactor"->mbeGammaListToProduct[wkNet],
    "BetaProduct"->mbeBetaPairsToProduct[betaPairs],
    "StructuredResult"->nonG*mbeGammaListToProduct[wkNet]*mbeBetaPairsToProduct[betaPairs],
    "Logs"->logs|>];

MBEBetaToEuler[betaReport_, mbVars_List, contourRules_, ass_:True] := Module[
  {betaList, nonBetaExpr, nBeta, tVars, zZeroRules, prefactorBases,
   eulerFactors, eulerMeas, constPre, deltaList, deltaFactors,
   auxForms, auxStripFactor, residualPrefactor, nAux, uVars,
   betaEulerFactors, auxEulerFactors, auxContourSigns,
   mbVarPoleDetected = False},
  betaList = betaReport["BetaPairs"];
  nonBetaExpr = Simplify[betaReport["NonGammaFactor"]*betaReport["GammaPrefactor"], ass];
  nBeta = Length[betaList];
  tVars = Table[MBAnalytica`SymbolicInt`t[i], {i, nBeta}];
  zZeroRules = Thread[mbVars->0];
  prefactorBases = Table[mbePrefactorBaseInVar[nonBetaExpr,mbVars[[j]],mbVars,ass],
    {j, Length[mbVars]}];
  If[!MemberQ[prefactorBases,$Failed],
    eulerFactors = Table[
      Module[{a=betaList[[i,1]],b=betaList[[i,2]],ti=tVars[[i]]},
        ti^(Simplify[a/.zZeroRules,ass]-1)*(1-ti)^(Simplify[b/.zZeroRules,ass]-1)],
      {i,nBeta}];
    eulerMeas = Simplify[Times@@eulerFactors,ass];
    constPre = Simplify[nonBetaExpr/.zZeroRules,ass];
    deltaList = Table[
      Module[{zj=mbVars[[j]],XjBeta},
        XjBeta = Times@@Table[
          Module[{a=betaList[[i,1]],b=betaList[[i,2]],ti=tVars[[i]]},
            ti^Simplify[Coefficient[a,zj],ass]*(1-ti)^Simplify[Coefficient[b,zj],ass]],
          {i,nBeta}];
        Simplify[XjBeta*prefactorBases[[j]],ass]],
      {j,Length[mbVars]}];
    deltaFactors = Times@@(DiracDelta[#-1]& /@ deltaList);
    Return[<|"Mode"->"Restricted","betaList"->betaList,"nonBetaExpr"->nonBetaExpr,
      "constPre"->constPre,"tVars"->tVars,"uVars"->{},"zVars"->mbVars,
      "eulerMeas"->eulerMeas,"prefactorBases"->prefactorBases,"deltaList"->deltaList,
      "deltaFactors"->deltaFactors,
      "StructuredIntegrand"->Simplify[constPre*eulerMeas*deltaFactors,ass]|>]];
  auxForms = mbeCollectAuxLinearForms[nonBetaExpr,mbVars,contourRules,ass];
  (* ============================================================
     (C) Safety patch: MB-variable pole detection + WARNING.

     An auxForm represents a denominator factor `LinearForm^Power`
     in nonBetaExpr. If `LinearForm` is precisely +/- an MB
     integration variable (with no constant offset), it is *not* a
     kinematic linear form -- it is a `1/z^k` pole of the MB integrand
     at z = 0. The standard Auxiliary-mode treatment of such a factor
     is silently wrong for integrands that *also* have Γ(z)^k or
     Γ(-z) numerator factors (e.g. integrals with F(z) =
     Γ(1-z)Γ(-z)Γ(z)^2... where the total z=0 pole order exceeds the
     `1/z^k` explicit power, and the additional residues at z=1,2,...
     from Γ(1-z), Γ(-z) are not captured by the Euler representation).

     A correct (B) symbolic treatment would require either a
     hypergeometric series machinery for the infinite residue tower,
     or delegation to MBintegrate's numerical residue-summation
     engine. Neither is in scope here.

     The detection below at least emits a CLEAR WARNING so silently
     wrong answers become visible. Users should cross-check such
     cases against MBintegrate.
     ============================================================ *)
  Module[{mbVarPoleAuxForms, mbVarRemainingGammas, fireTier1, fireTier2},
    (* ----- Tier 1: BROADER auxForm pole check (v1.2) -----
       Detect HIGH-ORDER (power >= 2) poles whose LinearForm depends on
       ANY MB variable, not just the bare-variable cases. Catches:
         - bare:     (z)^k, (-z)^k       (original v1.1 detection)
         - offset:   (z+1)^k, (z-2)^k    (NEW)
         - crossed:  (z1+z2)^k, (z1-z2)^k (NEW, multi-loop)
       Requires LinearForm to be linear in each MB var (degree <= 1)
       to avoid flagging Möbius-type residuals. *)
    mbVarPoleAuxForms = Select[auxForms,
      Function[af,
        Module[{lf = af["LinearForm"], pwr = af["Power"]},
          mbeIsHighOrderPower[pwr] &&    (* v1.5 Tier 4: symbolic-aware *)
          ! FreeQ[lf, Alternatives @@ mbVars] &&
          AllTrue[mbVars,
            PolynomialQ[lf, #] && Exponent[lf, #] <= 1 &]]]];
    fireTier1 = Length[mbVarPoleAuxForms] > 0;

    (* ----- Tier 2: leftover-Γ check (v1.2, NEW) -----
       The pair-matcher consumes Γ(z+a)·Γ(-z+b) pairs into Beta
       factors. If the ORIGINAL integrand has absorbed multiplicity
       (e.g. Γ(z)^2 with one Γ(z) used in the pair), an MB-variable-
       dependent Γ is left behind in RemainingGammaList. This is the
       fingerprint of pole-order pathology even when Tier 1's nonG
       residual happens to be only Power=1 (or no residual at all).
       Catches Γ(z)^k for k >= 2 directly, robust to which Γ the
       matcher chose to pair. *)
    mbVarRemainingGammas = Select[betaReport["RemainingGammaList"],
      Function[g, ! FreeQ[g[[1]], Alternatives @@ mbVars]]];
    fireTier2 = Length[mbVarRemainingGammas] > 0;

    If[fireTier1 || fireTier2,
      mbVarPoleDetected = True;
      If[fireTier1,
        MBAnalytica`SymbolicInt`Private`mbtPPrint["[Block 5][Tier 1] HIGH-ORDER pole(s) detected in nonG residual: ",
          Row[{#["LinearForm"], "^", #["Power"]}] & /@ mbVarPoleAuxForms]];
      If[fireTier2,
        Print["[Block 5][Tier 2] Unpaired MB-variable \[CapitalGamma](s) after Beta pairing: ",
          Row[{"\[CapitalGamma](", #[[1]], ")^", #[[2]]}] & /@ mbVarRemainingGammas]];
      MBAnalytica`SymbolicInt`Private`mbtPPrint["    Block 5 Auxiliary mode is silently wrong for this pattern."];
      MBAnalytica`SymbolicInt`Private`mbtPPrint["    Signalling MBtoEuler to attempt symbolic-residue (Path B / B')."]
    ]
  ];
  auxStripFactor = Times@@((#["LinearForm"]^#["Power"])& /@ auxForms);
  residualPrefactor = Simplify[nonBetaExpr*auxStripFactor,ass];
  prefactorBases = Table[mbePrefactorBaseInVar[residualPrefactor,mbVars[[j]],mbVars,ass],
    {j,Length[mbVars]}];
  If[MemberQ[prefactorBases,$Failed],
    Return[Failure["Block5Failed",<|"Message"->"Non-Beta prefactor not pure power-like.",
      "MBVarPoleDetected"->mbVarPoleDetected,
      "RemainingGammaList"->Lookup[betaReport,"RemainingGammaList",{}]|>]]];
  nAux = Length[auxForms]; uVars = Table[MBAnalytica`SymbolicInt`u[i],{i,nAux}];
  betaEulerFactors = Table[
    Module[{a=betaList[[i,1]],b=betaList[[i,2]],ti=tVars[[i]]},
      ti^(Simplify[a/.zZeroRules,ass]-1)*(1-ti)^(Simplify[b/.zZeroRules,ass]-1)],
    {i,nBeta}];
  (* res4 colliding-poles pinch fix, 2026-06-29: choose the auxiliary
     1/L^m Euler representation from the actual contour side.  sign=+1
     is the legacy Re[L]>0 formula; sign=-1 uses L left of the contour:
     1/L^m = (-1)^m Int_0^1 u^(-L-1)(-Log[u])^(m-1)/(m-1)! du. *)
  auxContourSigns = Table[
    Module[{Ll=auxForms[[j,"LinearForm"]], rho},
      rho = mbeContourRealPart[Ll, contourRules, ass];
      Which[TrueQ[FullSimplify[rho > 0, ass]], 1,
            TrueQ[FullSimplify[rho < 0, ass]], -1,
            True, 1]],
    {j,nAux}];
  auxEulerFactors = Table[
    Module[{Ll=auxForms[[j,"LinearForm"]],ml=auxForms[[j,"Power"]],uj=uVars[[j]]},
      If[auxContourSigns[[j]] === -1,
        (-1)^ml * uj^(Simplify[-Ll/.zZeroRules,ass]-1) *
          ((-Log[uj])^(ml-1)/Factorial[ml-1]),
        uj^(Simplify[Ll/.zZeroRules,ass]-1) *
          ((-Log[uj])^(ml-1)/Factorial[ml-1])]],
    {j,nAux}];
  eulerMeas = Simplify[Times@@Join[betaEulerFactors,auxEulerFactors],ass];
  constPre = Simplify[residualPrefactor/.zZeroRules,ass];
  deltaList = Table[
    Module[{zj=mbVars[[j]],XjBeta,XjAux},
      XjBeta = Times@@Table[
        Module[{a=betaList[[i,1]],b=betaList[[i,2]],ti=tVars[[i]]},
          ti^Simplify[Coefficient[a,zj],ass]*(1-ti)^Simplify[Coefficient[b,zj],ass]],
        {i,nBeta}];
      XjAux = Times@@Table[
        Module[{Ll=auxForms[[i,"LinearForm"]],uj=uVars[[i]]},
          uj^Simplify[auxContourSigns[[i]]*Coefficient[Ll,zj],ass]],
        {i,nAux}];
      Simplify[XjBeta*prefactorBases[[j]]*XjAux,ass]],
    {j,Length[mbVars]}];
  deltaFactors = Times@@(DiracDelta[#-1]& /@ deltaList);
  <|"Mode"->"Auxiliary","betaList"->betaList,"nonBetaExpr"->nonBetaExpr,
    "AuxiliaryForms"->auxForms,"ResidualPrefactor"->residualPrefactor,
    "constPre"->constPre,"tVars"->tVars,"uVars"->uVars,"zVars"->mbVars,
    "betaEulerFactors"->betaEulerFactors,"auxEulerFactors"->auxEulerFactors,
    "eulerMeas"->eulerMeas,"prefactorBases"->prefactorBases,"deltaList"->deltaList,
    "deltaFactors"->deltaFactors,
    "MBVarPoleDetected"->mbVarPoleDetected,
    "StructuredIntegrand"->Simplify[constPre*eulerMeas*deltaFactors,ass]|>];

MBEOrientEuler[eulerReport_, ass_:True] := Module[
  {xList, eulerMeas, tVars, uVars, unitVars, swapVars, rules, newXList, newEulerMeas},
  xList = mbeXListFromEulerReport[eulerReport, ass];
  eulerMeas = eulerReport["eulerMeas"];
  tVars = Lookup[eulerReport,"tVars",{}]; uVars = Lookup[eulerReport,"uVars",{}];
  unitVars = Join[tVars,uVars];
  swapVars = Select[unitVars, mbeVarOccursOnlyAsOneMinusQ[xList,#]&];
  rules = Thread[swapVars->(1-swapVars)];
  newXList = mbeCanonicalPositiveX[#,unitVars,ass]& /@ (Simplify[#,ass]& /@ (xList/.rules));
  newEulerMeas = Simplify[eulerMeas/.rules,ass];
  <|"Mode"->Lookup[eulerReport,"Mode","Unknown"],"SwappedVariables"->swapVars,
    "SwapRules"->rules,"xList"->newXList,"constPre"->eulerReport["constPre"],
    "eulerMeas"->newEulerMeas,"tVars"->tVars,"uVars"->uVars,
    "UnitVars"->unitVars,"zVars"->eulerReport["zVars"]|>];

MBESuggestDeltaPivots[eulerReportOriented_, ass_:True] := Module[
  {xList, tVars, uVars, unitVars, fullAss, workXList,
   suggestedPivots={}, stepReports={}, availableVars, candidates, scored, best,
   bestVar, sols, sol, i},
  xList = eulerReportOriented["xList"];
  tVars = Lookup[eulerReportOriented,"tVars",{}];
  uVars = Lookup[eulerReportOriented,"uVars",{}];
  unitVars = Join[tVars,uVars];
  fullAss = And@@Flatten[{ass,mbeUnitIntervalAssumptions[unitVars]}];
  workXList = xList; availableVars = unitVars;
  Do[
    candidates = Select[availableVars, !FreeQ[workXList[[1]],#]&];
    If[candidates==={},
      AppendTo[stepReports,<|"Step"->i,"Status"->"NoAvailableVariable"|>]; Break[]];
    scored = SortBy[mbeScoredCandidate[workXList[[1]],#,tVars,uVars,fullAss,xList]& /@ candidates,
      #["Score"]&];
    best = First[scored]; bestVar = best["Variable"];
    AppendTo[suggestedPivots, bestVar];
    sols = Quiet[Solve[Simplify[workXList[[1]]==1,fullAss],bestVar]];
    sol = If[Head[sols]===List && Length[sols]>=1, First[sols], {}];
    AppendTo[stepReports,<|"Step"->i,"Constraint"->workXList[[1]],"ChosenPivot"->bestVar,
      "Reasoning"->StringJoin[If[best["IsAuxiliary"],"aux","beta"],
        ", deg ",ToString[best["Degree"]],", ",ToString[best["NumSolutions"]]," sol(s)"]|>];
    availableVars = DeleteCases[availableVars, bestVar];
    workXList = If[sol=!={}, Simplify[#,fullAss]& /@ (Rest[workXList]/.sol), Rest[workXList]],
    {i, Length[xList]}];
  <|"SuggestedPivots"->suggestedPivots,"StepReports"->stepReports,
    "RemainingVariables"->Complement[unitVars,suggestedPivots]|>];

MBEDeltaReduce[eulerReportOriented_, pivots_List, ass_:True] := Module[
  {xList, tVars, uVars, unitVars, fullAss, activeAss, workIntegrand, workXList,
   solvedRules={}, jacobianFactors={}, logs={}, solvedPivots={},
   i, pivot, eqn, sols, validSols, sol, jac, jacFac, deltaFail = None},
  xList = eulerReportOriented["xList"];
  tVars = Lookup[eulerReportOriented,"tVars",{}];
  uVars = Lookup[eulerReportOriented,"uVars",{}];
  unitVars = Join[tVars,uVars];
  If[Length[pivots]=!=Length[xList],
    Return[Failure["WrongNumberOfPivots",
      <|"NumConstraints"->Length[xList],"Pivots"->pivots|>]]];
  fullAss = And@@Flatten[{ass,mbeUnitIntervalAssumptions[unitVars]}];
  workIntegrand = Simplify[eulerReportOriented["constPre"]*eulerReportOriented["eulerMeas"],fullAss];
  workXList = xList;
  Do[
    pivot = pivots[[i]];
    activeAss = And@@Flatten[{ass,mbeUnitIntervalAssumptions[Complement[unitVars,solvedPivots]]}];
    (* 2026-07-19 FIX (campaign trap #20): Return[] inside Do exits only the
       Do and silently DISCARDED these failures, so unresolved deltas fell
       through to a delta-DROPPED (unfaithful!) cube with SolvedRules={}.
       Failures now propagate via deltaFail + Break. *)
    If[FreeQ[workXList[[1]],pivot],
      deltaFail = Failure["PivotNotInConstraint",<|"Step"->i,"Pivot"->pivot|>]; Break[]];
    eqn = Simplify[workXList[[1]]==1,activeAss];
    sols = Solve[eqn,pivot];
    If[sols==={}||Head[sols]=!=List, sols=Solve[FullSimplify[workXList[[1]]==1,activeAss],pivot]];
    If[sols==={}||Head[sols]=!=List,
      deltaFail = Failure["NoSolutionForConstraint",<|"Step"->i,"Pivot"->pivot|>]; Break[]];
    validSols = Select[sols, TrueQ[FullSimplify[0<(pivot/.#)<1,activeAss]]&];
    If[validSols==={}&&sols=!={},
      With[{mr=mbeManualRealRoot[workXList[[1]],pivot,activeAss]},
        If[mr=!={},validSols={mr}]]];
    (* 2026-07-19 FIX 2: the 0<pivot<1 provability requirement is TOO STRICT
       here — Block 8 (support absorption) exists precisely to handle the <1
       side. Accept a UNIQUE real-positive root under the assumptions. *)
    If[validSols==={},
      Module[{posSols = Select[sols,
          TrueQ[Simplify[(pivot/.#)>0, activeAss]] &]},
        If[Length[posSols]==1, validSols = posSols]]];
    sol = Which[Length[validSols]==1, First[validSols], Length[sols]==1, First[sols],
      True, deltaFail = Failure["AmbiguousConstraint",<|"Step"->i,"Pivot"->pivot|>]; Break[]];
    jac = Simplify[(D[workXList[[1]],pivot]/.sol),activeAss];
    jacFac = Simplify[1/Abs[jac],activeAss];
    AppendTo[solvedRules,sol]; AppendTo[jacobianFactors,jacFac]; AppendTo[solvedPivots,pivot];
    AppendTo[logs,<|"Step"->i,"Pivot"->pivot,"SolutionRule"->sol,"JacobianFactor"->jacFac|>];
    workIntegrand = Simplify[((workIntegrand*jacFac)/.sol),activeAss];
    workXList = Simplify[#,activeAss]& /@ (Rest[workXList]/.sol),
    {i, Length[pivots]}];
  If[deltaFail =!= None, Return[deltaFail]];
  <|"Mode"->Lookup[eulerReportOriented,"Mode","Unknown"],
    "xList"->xList,"Pivots"->pivots,"SolvedRules"->solvedRules,
    "JacobianFactors"->jacobianFactors,"ReducedIntegrand"->workIntegrand,
    "RemainingConstraints"->workXList,"RemainingVariables"->Complement[unitVars,pivots],
    "Logs"->logs|>];

MBESupportConditions[deltaReport_, ass_:True] := Module[
  {rules, remVars, fullAss, conditions={}, rhsVal, laterRules},
  rules = deltaReport["SolvedRules"];
  remVars = deltaReport["RemainingVariables"];
  fullAss = ass && mbeUnitIntervalAssumptions[remVars];
  Do[
    rhsVal = Last@First[rules[[i]]];
    laterRules = Flatten[rules[[i+1;;All]]];
    rhsVal = rhsVal/.laterRules;
    AppendTo[conditions, 0<rhsVal<1],
    {i, Length[rules]}];
  FullSimplify[And@@conditions,fullAss]];

MBESuggestSupportPivots[deltaReport_, ass_:True] := Module[
  {rules, lhsVars, rhsVals, remVars, occ, candData, order,
   used=<||>, chosenAssoc=<||>, idx, cands, pick},
  rules = deltaReport["SolvedRules"];
  lhsVars = (First@First[#])& /@ rules;
  rhsVals = (Last@First[#])& /@ rules;
  remVars = deltaReport["RemainingVariables"];
  occ = Association@Table[v->Count[rhsVals,expr_/;!FreeQ[expr,v]],{v,remVars}];
  candData = Table[<|"Index"->i,"LHS"->lhsVars[[i]],"RHS"->rhsVals[[i]],
    "Candidates"->SortBy[
      mbeSupportPivotCandidates[lhsVars[[i]],rhsVals[[i]],remVars,lhsVars,ass],
      {occ[#["Variable"]]&,If[#["UniqueValidQ"],0,1]&,#["Degree"]&,#["SolutionLeafCount"]&}]|>,
    {i,Length[rules]}];
  order = Ordering[Length/@(candData[[All,"Candidates"]])];
  Do[
    idx = candData[[k,"Index"]]; cands = candData[[k,"Candidates"]];
    pick = SelectFirst[cands,(!KeyExistsQ[used,#["Variable"]])&&TrueQ[#["UniqueValidQ"]]&,
      Missing[]];
    If[pick===Missing[], pick=SelectFirst[cands,!KeyExistsQ[used,#["Variable"]]&,Missing[]]];
    If[pick===Missing[], Return[Failure["CouldNotChooseSupportPivots",<||>]]];
    used[pick["Variable"]]=True; chosenAssoc[idx]=pick["Variable"],
    {k,order}];
  Table[chosenAssoc[i],{i,Length[rules]}]];

MBEAbsorbSupport[deltaReport_, ass_:True] := Module[
  {rules, lhsVars, rhsVals, remVars, support0, supportPivots,
   eqns, keptVars, fullAss, sols, validSols, sol, jacMat, jac,
   cubeIntegrand, cubeVars},
  rules = deltaReport["SolvedRules"];
  lhsVars = (First@First[#])& /@ rules;
  rhsVals = (Last@First[#])& /@ rules;
  remVars = deltaReport["RemainingVariables"];
  support0 = MBESupportConditions[deltaReport, ass];
  If[TrueQ[support0===True],
    Return[<|"ChosenPivots"->{},"TransformRules"->{},"Jacobian"->1,
      "CubeIntegrand"->Simplify[deltaReport["ReducedIntegrand"],
        ass&&mbeUnitIntervalAssumptions[remVars]],
      "CubeVariables"->remVars,"SupportAfterTransform"->True|>]];
  supportPivots = MBESuggestSupportPivots[deltaReport, ass];
  If[FailureQ[supportPivots], Return[supportPivots]];
  eqns = Thread[lhsVars==rhsVals];
  keptVars = Complement[remVars,supportPivots];
  fullAss = ass&&mbeUnitIntervalAssumptions[Join[keptVars,lhsVars]];
  sols = Quiet[Solve[eqns,supportPivots]];
  If[sols==={}||Head[sols]=!=List,
    Return[Failure["NoInverseTransform",<|"Equations"->eqns|>]]];
  validSols = Select[sols,
    TrueQ[FullSimplify[And@@Table[0<(supportPivots[[i]]/.#)<1,{i,Length[supportPivots]}],fullAss]]&];
  sol = Which[Length[validSols]==1,First[validSols],Length[sols]==1,First[sols],
    True,Return[Failure["AmbiguousInverseTransform",<||>]]];
  jacMat = Table[D[supportPivots[[i]]/.sol,lhsVars[[j]]],
    {i,Length[supportPivots]},{j,Length[lhsVars]}];
  jac = Simplify[Abs[Det[jacMat]],fullAss];
  cubeIntegrand = Simplify[(deltaReport["ReducedIntegrand"]/.sol)*jac,fullAss];
  cubeVars = Join[keptVars,lhsVars];
  <|"ChosenPivots"->supportPivots,"TransformRules"->sol,"Jacobian"->jac,
    "CubeIntegrand"->cubeIntegrand,"CubeVariables"->cubeVars,
    "SupportAfterTransform"->Simplify[support0/.sol,fullAss]|>];

MBEFormatResult[result_Association] := Module[
  {integrands, n, sep},
  integrands = result["EulerIntegrands"]; n = Length[integrands];
  sep = StringJoin[ConstantArray["\[LongDash]", 60]];
  Print[sep];
  Print["  MB \[Rule] Euler  |  ", n, " integrand(s)  |  HasPolygamma: ", result["HasPolygamma"]];
  Print[sep];
  Do[
    Module[{f, vars, isPg = (k==1 && result["HasPolygamma"])},
      {f, vars} = integrands[[k]];
      Print["\n\[Bullet] Integrand ", k,
        If[n>1, If[isPg,"  [Part A: shifted polygamma]",
          "  [Part B: correction "<>ToString[k-1]<>"]"], ""], ":"];
      Print["  f = ", f];
      Print["  Variables \[Element] [0,1]:  {", StringRiffle[ToString/@vars,", "], "}"];
      Print["  Dimension: ", Length[vars]]],
    {k, n}];
  Print["\n", sep];
  Print["  Result = \[Sum]_k \[Integral]_{[0,1]^n_k}  f_k  d^n_k v"];
  Print[sep]];

MBERunStream[integrand_, mbVars_List, contourRules_, ass_:True,
  OptionsPattern[MBERunStream]] := Module[
  {verbose, showSteps, maxShift, step1, step2, step2b, bal, step4, step5, step6,
   piv, step7, step8, pipeline},
  verbose   = OptionValue["Verbose"];
  showSteps = OptionValue["ShowSteps"];
  maxShift  = OptionValue["MaxShift"];
  If[showSteps, Print["[Stream] Block 1: Contour normalization..."]];
  step1 = MBENormalizeContour[integrand, contourRules, ass, maxShift];
  If[showSteps, Print["[Stream] Block 2: Slope normalization..."]];
  step2 = MBENormalizeSlope[step1, mbVars];
  If[showSteps, Print["[Stream] Block 2b: Γ-shift simplification..."]];
  step2b = mbeSimplifyGammaStructure[step2, mbVars, ass];
  If[showSteps, Print["[Stream] Block 3: Balance check..."]];
  bal = MBECheckBalance[step2b, mbVars, ass];
  If[!TrueQ[bal["ReadyForBetaPairingQ"]] && showSteps,
    Print["[Stream] WARNING: not ready for Beta pairing"]];
  If[showSteps, Print["[Stream] Block 4: Gamma -> Beta..."]];
  step4 = MBEGammaToBeta[step2b, mbVars, ass, contourRules];
  If[FailureQ[step4], Return[step4]];
  If[showSteps, Print["[Stream] Block 5: Beta -> Euler..."]];
  step5 = MBEBetaToEuler[step4, mbVars, contourRules, ass];
  If[FailureQ[step5], Return[step5]];
  If[showSteps, Print["[Stream] Block 5 mode: ", step5["Mode"]]];
  If[showSteps, Print["[Stream] Block 6: Euler orientation..."]];
  step6 = MBEOrientEuler[step5, ass];
  If[showSteps, Print["[Stream] Block 7: Delta reduction..."]];
  piv = MBESuggestDeltaPivots[step6, ass];
  step7 = MBEDeltaReduce[step6, piv["SuggestedPivots"], ass];
  If[FailureQ[step7], Return[step7]];
  If[showSteps, Print["[Stream] Remaining vars: ", step7["RemainingVariables"]]];
  If[showSteps, Print["[Stream] Block 8: Support absorption..."]];
  step8 = MBEAbsorbSupport[step7, ass];
  If[FailureQ[step8], Return[step8]];
  pipeline = If[verbose,
    <|"B1"->step1,"B2"->step2,"B3"->bal,"B4"->step4,"B5"->step5,
      "B6"->step6,"B7"->step7,"B8"->step8|>, None];
  <|"CubeIntegrand"->step8["CubeIntegrand"],
    "CubeVariables"->step8["CubeVariables"],
    "SupportAfterTransform"->step8["SupportAfterTransform"],
    "MBVarPoleDetected"->TrueQ[Lookup[step5,"MBVarPoleDetected",False]],
    "Mode"->step5["Mode"], "Pipeline"->pipeline|>];

MBtoEuler[integrand_, contourRules_, mbVars_List, opts:OptionsPattern[MBtoEuler]] := Module[
  {verbose, showSteps, maxShift, cleanOutput, userAss, ass,
   pgResult, modIntegrand, partAStream, partAEuler, partAFailure,
   corrections, partBStreams, partBEulers, eulerIntegrands, allResults,
   block5PinchFailure},
  verbose     = OptionValue["Verbose"];
  showSteps   = OptionValue["ShowSteps"];
  maxShift    = OptionValue["MaxShift"];
  cleanOutput = OptionValue["CleanOutput"];
  userAss = OptionValue["Assumptions"];
  userAss = Which[userAss===True||userAss==={}, True,
                  ListQ[userAss], And@@userAss, True, userAss];
  If[showSteps, Print["[MBtoEuler] Block 0: Polygamma preprocessing..."]];
  pgResult = MBEPreprocessPolygamma[integrand, mbVars, contourRules];
  ass = Which[
    pgResult["AuxAssumptions"]===True, userAss,
    userAss===True, pgResult["AuxAssumptions"],
    True, And[pgResult["AuxAssumptions"], userAss]];
  If[showSteps, Print["[MBtoEuler] Part A: Blocks 1-8 on main integrand..."]];
  modIntegrand = pgResult["ModifiedIntegrand"];
  partAStream = MBERunStream[modIntegrand, mbVars, contourRules, ass,
    "Verbose"->verbose,"ShowSteps"->showSteps,"MaxShift"->maxShift];
  partAFailure = None;
  block5PinchFailure = False;
  If[FailureQ[partAStream],
    partAFailure = partAStream;
    Print["[MBtoEuler] Part A (j=k main) FAILED at Block 5: ", partAStream["Message"]];
    block5PinchFailure =
      TrueQ[Quiet @ Check[partAFailure["MBVarPoleDetected"], False]];
    If[block5PinchFailure,
      (* res4 colliding-poles pinch fix, 2026-06-29: do not emit the
         symbolic-residue cube unflagged for the pinched/degenerate
         Block-5 failure class.  Preserve PartialResult/PartAFailure so
         callers can refuse or special-case the result. *)
      Print["[MBtoEuler] Block-5 failure has pinched/degenerate MB-pole fingerprint."];
      Print["    Suppressing symbolic-residue fallback; returning flagged partial result."];
      partAEuler = Failure["PinchedBlock5Failed",
        <|"OriginalFailure"->partAFailure|>];
      partAStream = <|"CubeIntegrand"->partAEuler,
        "CubeVariables"->{}, "Mode"->"PinchedBlock5Failed",
        "Pipeline"->None|>,
    (* === SYMBOLIC RESIDUE on Block 5 failure (path B+/B') ===
       Gate on the F(z) pattern so we don't divert MB14-style integrands
       into the (potentially incorrect) symbolic-residue machinery. *)
    Module[{symbResZ, symbModIntg, symbRes0, symbResN, symbSum, symbTotal,
            extraIR2Left = 0, symbGotIt = False, matchesFPattern},
      matchesFPattern = mbeMatchesFPatternQ[integrand, mbVars];
      If[matchesFPattern,
      symbModIntg = Quiet@FunctionExpand[modIntegrand];
      If[Length[mbVars] == 1,
        symbResZ = mbVars[[1]];
        symbRes0 = Quiet@TimeConstrained[
          Module[{r},
            r = Residue[symbModIntg, {symbResZ, 0}];
            If[pgResult["HasPolygamma"],
              Quiet@MBEApplyPolygammaLimit[r, pgResult], r]],
          60, $TimedOut];
        If[symbRes0 =!= $TimedOut,
          symbResN = Quiet@TimeConstrained[
            Module[{w = Unique["wResB5"], intAtN, withW, asSeries, rawResN},
              intAtN = symbModIntg /. symbResZ -> n + w;
              withW = intAtN //. {
                Gamma[-n - w]      :> (-1)^(n+1) Pi/(Sin[Pi w] Gamma[1+n+w]),
                Gamma[-1 - n - w]  :> (-1)^n     Pi/(Sin[Pi w] Gamma[2+n+w]),
                Gamma[-2 - n - w]  :> (-1)^(n+1) Pi/(Sin[Pi w] Gamma[3+n+w]),
                Gamma[1 - n - w]   :> (-1)^n     Pi/(Sin[Pi w] Gamma[n+w]),
                Sin[Pi (n + w)]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                Sin[Pi w + Pi n]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                Sin[Pi n + Pi w]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                Csc[Pi (n + w)]^k_. :> ((-1)^n)^k Csc[Pi w]^k,
                Csc[Pi w + Pi n]^k_. :> ((-1)^n)^k Csc[Pi w]^k,
                Csc[Pi n + Pi w]^k_. :> ((-1)^n)^k Csc[Pi w]^k};
              asSeries = Series[withW, {w, 0, 4}];
              rawResN = SeriesCoefficient[asSeries, -1];
              If[pgResult["HasPolygamma"],
                Quiet@MBEApplyPolygammaLimit[rawResN, pgResult],
                rawResN]],
            180, $TimedOut];
          If[symbResN =!= $TimedOut && symbResN =!= 0,
            (* Round 14 HS-first: try analytic S-route closure (fast: ~0.1s for
               ψ^3-class weight-5+ Euler sums). Fall back to Mma Sum on failure. *)
            Module[{tHS = AbsoluteTime[], hsRes},
              hsRes = Quiet@TimeConstrained[
                mbeCloseResidueSumSShifted[symbResN, n], 30, $TimedOut];
              If[mbeIsValidClosureQ[hsRes, n],
                symbSum = hsRes;
                Print["[MBtoEuler] HS analytic closure SUCCEEDED [",
                      Round[AbsoluteTime[] - tHS, 0.01], "s]"],
                symbSum = Quiet@TimeConstrained[
                  Sum[symbResN, {n, 1, Infinity}], 300, $TimedOut]]];
            If[FreeQ[symbSum, _Sum] && FreeQ[symbSum, _Residue] &&
               symbSum =!= $TimedOut,
              symbTotal = Quiet@FullSimplify[-(symbRes0 + symbSum)];
              Print["[MBtoEuler] Block-5-failure symbolic residue SUCCEEDED."];
              Print["    Closed-form cube integrand: ", Short[symbTotal, 4]];
              partAStream = <|"CubeIntegrand" -> symbTotal,
                "CubeVariables" -> Lookup[pgResult, "PolygammaIntegralVars", {}],
                "Mode" -> "Block5FailSymbolicResidue", "Pipeline" -> None|>;
              partAEuler = symbTotal;
              pgResult = Append[pgResult, "RationalCorrections" -> {}];
              partAFailure = None;
              symbGotIt = True]]]];
      If[!symbGotIt && Length[mbVars] == 1,
        (* Path B' (integral-rep cube) fallback *)
        Module[{irData2, irIntg2, irVars2, ir2Res0, ir2ResN, ir2Sum, ir2Total},
          symbResZ = mbVars[[1]];
          irData2 = Quiet@mbeBuildShiftedIntegralRep[integrand, mbVars,
            contourRules, userAss];
          irIntg2 = Quiet@FunctionExpand[irData2["Integrand"]];
          irVars2 = irData2["CubeVars"];
          Module[{nS2 = Ceiling[Re[symbResZ /. contourRules]], kk2,
                  ir2ExtraResLeft = 0},
            If[nS2 < 0,
              ir2ExtraResLeft = Sum[
                Quiet@TimeConstrained[Residue[irIntg2, {symbResZ, kk2}], 30, 0],
                {kk2, nS2, -1}]];
            extraIR2Left = ir2ExtraResLeft];
          ir2Res0 = Quiet@TimeConstrained[
            Residue[irIntg2, {symbResZ, 0}], 120, $TimedOut];
          If[ir2Res0 =!= $TimedOut,
            ir2ResN = Quiet@TimeConstrained[
              Module[{w = Unique["wResB5IR"], intAtN, withW, asSeries},
                intAtN = irIntg2 /. symbResZ -> n + w;
                withW = intAtN //. {
                  Gamma[-n - w]      :> (-1)^(n+1) Pi/(Sin[Pi w] Gamma[1+n+w]),
                  Gamma[-1 - n - w]  :> (-1)^n     Pi/(Sin[Pi w] Gamma[2+n+w]),
                  Gamma[-2 - n - w]  :> (-1)^(n+1) Pi/(Sin[Pi w] Gamma[3+n+w]),
                  Gamma[1 - n - w]   :> (-1)^n     Pi/(Sin[Pi w] Gamma[n+w]),
                  Sin[Pi (n + w)]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                  Sin[Pi w + Pi n]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                  Sin[Pi n + Pi w]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                  Csc[Pi (n + w)]^k_. :> ((-1)^n)^k Csc[Pi w]^k,
                  Csc[Pi w + Pi n]^k_. :> ((-1)^n)^k Csc[Pi w]^k,
                  Csc[Pi n + Pi w]^k_. :> ((-1)^n)^k Csc[Pi w]^k};
                asSeries = Series[withW, {w, 0, 4}];
                SeriesCoefficient[asSeries, -1]],
              240, $TimedOut];
            If[ir2ResN =!= $TimedOut && ir2ResN =!= 0,
              (* Round 14 HS-first on integral-rep path too. *)
              Module[{tHS2 = AbsoluteTime[], hsRes2},
                hsRes2 = Quiet@TimeConstrained[
                  mbeCloseResidueSumSShifted[ir2ResN, n], 30, $TimedOut];
                If[mbeIsValidClosureQ[hsRes2, n],
                  ir2Sum = hsRes2;
                  Print["[MBtoEuler] HS analytic closure SUCCEEDED (irRep) [",
                        Round[AbsoluteTime[] - tHS2, 0.01], "s]"],
                  ir2Sum = Quiet@TimeConstrained[
                    Sum[ir2ResN, {n, 1, Infinity}], 600, $TimedOut]]];
              If[FreeQ[ir2Sum, _Sum] && FreeQ[ir2Sum, _Residue] &&
                 ir2Sum =!= $TimedOut,
                ir2Total = Quiet@Simplify[-(extraIR2Left + ir2Res0 + ir2Sum)];
                Print["[MBtoEuler] Block-5-failure integral-rep cube SUCCEEDED."];
                Print["    Cube variables: ", irVars2];
                Print["    Closed-form: ", Short[ir2Total, 4]];
                partAStream = <|"CubeIntegrand" -> ir2Total,
                  "CubeVariables" -> irVars2,
                  "Mode" -> "Block5FailIntegralRepCube", "Pipeline" -> None|>;
                partAEuler = ir2Total;
                pgResult = Append[pgResult, "RationalCorrections" -> {}];
                partAFailure = None;
                symbGotIt = True]]]]]]];
    ];
    (* If symbolic-residue (and B') closed analytically, skip the
       IntegralRep + numerical fallback chain below. *)
    If[! TrueQ[block5PinchFailure] && partAFailure =!= None,
    (* ---------- ANALYTIC FALLBACK: integral representation ---------- *)
    Print["[MBtoEuler] Attempting IntegralRep mode (analytic fallback)..."];
    Module[{mainBin, irData, irSubInts, irTVars, irEulers = {},
            irSuccess = 0, irFailed = 0, ii},
      mainBin = Lookup[pgResult, "MainBinomial", modIntegrand];
      irData = mbeBuildIntegralRepSubintegrands[mainBin, mbVars];
      irSubInts = irData["SubIntegrands"];
      irTVars = irData["TVars"];
      Print["[MBtoEuler] IntegralRep: ", Length[irSubInts],
        " sub-MB-integrand(s); t-vars: ", irTVars];
      Do[
        Module[{subInt, subStream, subEuler, subTVars, subCubeVars, posAss},
          subInt = irSubInts[[ii]];
          subStream = MBERunStream[subInt, mbVars, contourRules, userAss,
            "Verbose" -> False, "ShowSteps" -> False, "MaxShift" -> maxShift];
          If[FailureQ[subStream],
            irFailed += 1;
            If[verbose,
              Print["  IR sub-", ii, " FAILED: ", subStream["Message"]]],
            subTVars = Select[irTVars, !FreeQ[subInt, #] &];
            subCubeVars = Join[subStream["CubeVariables"], subTVars];
            subEuler = subStream["CubeIntegrand"];
            (* Only Simplify if Abs[...] survived Block 7 (t-vars aren't in
               Block 7's activeAss). Skipping otherwise avoids 20+ min hangs
               on multi-cube-var integrands. If Abs survives Simplify (e.g.
               Abs of a sum-of-products like -v1*v2 + (-1+v1)*v3 that
               Simplify can't sign-determine), fall back to numerical
               sign sampling -- usually clears the residual. *)
            If[!FreeQ[subEuler, Abs],
              posAss = If[subCubeVars === {}, True,
                And @@ Join[Thread[subCubeVars > 0], Thread[subCubeVars < 1]]];
              subEuler = Simplify[subEuler, posAss];
              If[!FreeQ[subEuler, Abs],
                subEuler = mbeCleanAbsBySampling[subEuler, subCubeVars]]];
            AppendTo[irEulers, {subEuler, subCubeVars}];
            irSuccess += 1]],
        {ii, Length[irSubInts]}];
      Print["[MBtoEuler] IntegralRep: ", irSuccess, "/", Length[irSubInts],
        " sub-MB succeeded"];
      If[irSuccess > 0 && irFailed == 0,
        Print["[MBtoEuler] IntegralRep SUCCESS: analytic Part A via ",
          Length[irEulers], " Euler integrand(s)."];
        partAStream = <|"Mode" -> "IntegralRep", "Pipeline" -> None,
          "CubeIntegrand" -> Null, "CubeVariables" -> {},
          "IntegralRepEulers" -> irEulers|>;
        partAEuler = Null;
        partAFailure = None,
        (* IntegralRep partial/failed -- numerical fallback. *)
        Print["[MBtoEuler] IntegralRep insufficient (",
          irSuccess, "/", Length[irSubInts], "). Falling back to NUMERICAL..."];
        Module[{ySyms, mbSubs, intg, ranges, mainNum},
          ySyms = Table[ToExpression["yMB$"<>ToString[i]], {i, Length[mbVars]}];
          mbSubs = Thread[mbVars -> Table[(mbVars[[i]] /. contourRules) + I*ySyms[[i]],
            {i, Length[mbVars]}]];
          intg = N[(mainBin /. mbSubs)/(2 Pi)^Length[mbVars]];
          ranges = ({#, -Infinity, Infinity} & /@ ySyms);
          mainNum = TimeConstrained[
            Quiet@Switch[Length[ranges],
              1, NIntegrate[intg, ranges[[1]],
                  Method -> {"GlobalAdaptive", "MaxErrorIncreases" -> 30000},
                  MaxRecursion -> 20, AccuracyGoal -> 6, PrecisionGoal -> 6],
              2, NIntegrate[intg, ranges[[1]], ranges[[2]],
                  Method -> {"GlobalAdaptive", "MaxErrorIncreases" -> 30000},
                  MaxRecursion -> 15, AccuracyGoal -> 5, PrecisionGoal -> 5],
              3, NIntegrate[intg, ranges[[1]], ranges[[2]], ranges[[3]],
                  Method -> {"AdaptiveMonteCarlo", "MaxPoints" -> 1000000},
                  AccuracyGoal -> 4, PrecisionGoal -> 4],
              _, $Failed],
            300, $TimedOut];
          (* Per package policy: numerical integration is for VERIFICATION
             only -- never used as the returned answer. Report failure
             and the numerical reference for the user to inspect. *)
          If[NumericQ[Re@mainNum] && mainNum =!= $TimedOut,
            Print["[MBtoEuler] SYMBOLIC FAILURE -- numerical verification value (do not treat as answer): ", mainNum];
            partAStream = <|"CubeIntegrand" -> Failure["SymbolicFailedNumericalVerification",
              <|"Tag" -> "SymbolicFailedNumericalVerification",
                "Message" -> "Symbolic Block-5 fallback failed; numerical verification value shown for inspection.",
                "NumericalReference" -> mainNum|>],
              "CubeVariables" -> {},
              "Mode" -> "SymbolicFailureNumericalVerification",
              "Pipeline" -> None,
              "NumericalReference" -> mainNum|>;
            partAEuler = Failure["SymbolicFailed", <|"NumericalReference" -> mainNum|>];
            partAFailure = Failure["SymbolicFailed", <|"Stage" -> "Block-5 + IntegralRep + Numerical chain",
              "NumericalReference" -> mainNum|>],
            Print["[MBtoEuler] SYMBOLIC FAILURE -- numerical verification ALSO failed (", mainNum, ")."];
            partAStream = <|"CubeIntegrand" -> Failure["SymbolicAndNumericalFailed",
              <|"Tag" -> "AllPathsFailed"|>],
              "CubeVariables" -> {},
              "Mode" -> "AllPathsFailed", "Pipeline" -> None|>;
            partAEuler = Failure["AllPathsFailed", <||>];
            partAFailure = Failure["AllPathsFailed", <||>]]]]]],
    If[pgResult["HasPolygamma"],
      If[showSteps, Print["[MBtoEuler] Applying polygamma limit..."]];
      partAEuler = MBEApplyPolygammaLimit[partAStream["CubeIntegrand"], pgResult],
      partAEuler = partAStream["CubeIntegrand"]]];
  (* ============================================================
     MB-variable pole override.

     If Block 5 detected a 1/z^k pole at the MB integration variable,
     the Auxiliary-mode closed form is silently wrong because it does
     not capture the infinite residue tower at z = 1, 2, ... .
     Bypass it: numerically integrate the *original* integrand
     (including original polygammas, no Block-0 substitution) along
     the MB contour. This subsumes Part B corrections, so we clear
     them to prevent double counting.

     The numerical value is then used as the Part A cube integrand
     (0-dimensional cube), and the rest of the pipeline treats it as
     a constant.
     ============================================================ *)
  (* Trigger the symbolic-residue override only when BOTH:
     (a) the integrand matches the F(z) = Gamma[1-z]Gamma[-z]Gamma[z]^2 Gamma[1+z]/Gamma[2+z]
         pattern (so we don't divert MB14-style integrands), AND
     (b) the polygamma structure is one where Block 5's Auxiliary mode is
         silently wrong: ψ^(m>=1) present, ψ count >=2, or no polygamma.
         A single ψ⁰ on F(z) is handled correctly and fast by Block 5. *)
  Module[{matchesFPattern, pgOps, needsOverridePg},
    matchesFPattern = mbeMatchesFPatternQ[integrand, mbVars];
    pgOps = Lookup[pgResult, "DerivativeOperations", {}];
    needsOverridePg = (Length[pgOps] === 0) ||
      AnyTrue[pgOps, #["Order"] >= 1 &] ||
      Length[pgOps] >= 2;
    If[! TrueQ[block5PinchFailure] &&
       ((TrueQ[Lookup[partAStream, "MBVarPoleDetected", False]] &&
        partAFailure === None && matchesFPattern && needsOverridePg) ||
       (* Tier-1.5 v2 (2026-07-20): EXPLICIT flag-forced override, set ONLY
          by the closer's quadrature-verified retry (default False =>
          byte-identical to certified v1.6 behavior). *)
       (TrueQ[MBAnalytica`SymbolicInt`Private`$mbeForceSymbolicResidue] &&
        partAFailure === None && needsOverridePg) ||
       (partAFailure =!= None &&
        MatchQ[partAFailure, _Failure?(MemberQ[{"Block5Failed", "NoInverseTransform"},
          Lookup[#[[1]] /. _Failure[a_, ___] :> a, "Tag", ""]] &)] &&
        matchesFPattern && needsOverridePg)),
    Print["[MBtoEuler] Attempting symbolic residue path"];
    Print["    (trigger: F(z) pattern + ",
      If[TrueQ[Lookup[partAStream, "MBVarPoleDetected", False]],
        "MB-variable pole detected", "Block 5 failure"], ")"];
    Module[{z, modIntg, polyVars, res0, resN, sum, total, n, extraResLeft = 0,
            cubeIntg, ySyms, mbSubs, intg, ranges, mainNum, gotSymbolic = False},
      (* === SYMBOLIC RESIDUE SUM (path B) ===
         Use the polygamma-integral-rep-substituted integrand from Block 0
         (modIntegrand). For 1-D MB closing right, the value is
            -Sum_{n=0}^infty Res_{z=n}[modIntegrand].
         Each residue is a function of the polygamma integral-rep cube
         variables (e.g., s, t, u). Mathematica's symbolic Residue+Sum
         can give a closed-form polylog expression that PLT integrates
         downstream over (0,1)^cube. *)
      If[Length[mbVars] == 1,
        z = mbVars[[1]];
        modIntg = pgResult["ModifiedIntegrand"];
        polyVars = Lookup[pgResult, "PolygammaIntegralVars", {}];
        (* Apply FunctionExpand to reduce Gamma products via reflection
           (e.g. Gamma[1-z]Gamma[z]->Pi/Sin[Pi z]). This converts the
           F(z)=Gamma[1-z]Gamma[-z]Gamma[z]^2 Gamma[1+z]/Gamma[2+z] pattern
           to its closed trig form -Pi^2 Csc[Pi z]^2/(z(1+z)), which is
           required for Series-based Res_n at integer n. *)
        modIntg = Quiet@FunctionExpand[modIntg];
        (* Determine residue summation starting index.
           For contour Re[z]=c, closing right picks residues at z = k for
           all integers k >= Ceiling[c]. The Series-based machinery below
           handles k=0,1,2,... via the reflection-substitution rules
           (which assume non-negative integer k). For k in [Ceiling[c], -1]
           when c < -1, compute those residues directly via Residue[]. *)
        Module[{nStart = Ceiling[Re[z /. contourRules]], extraRes0 = 0, kk},
          If[nStart < 0,
            extraRes0 = Sum[
              Quiet@TimeConstrained[Residue[modIntg, {z, kk}], 30, 0],
              {kk, nStart, -1}];
            If[pgResult["HasPolygamma"],
              extraRes0 = Quiet@MBEApplyPolygammaLimit[extraRes0, pgResult]]];
          extraResLeft = extraRes0];
        (* Compute res0 (at z=0) with polygamma derivative limit applied *)
        res0 = Quiet@TimeConstrained[
          Module[{r},
            r = Residue[modIntg, {z, 0}];
            If[pgResult["HasPolygamma"],
              Quiet@MBEApplyPolygammaLimit[r, pgResult], r]],
          60, $TimedOut];
        If[res0 =!= $TimedOut,
          (* Symbolic Res_n at z=n+w using:
             (a) reflection Gamma[k-n-w] -> trig form (for k <= 0 integers
                 or k=1 since at n>=1 it is also non-positive),
             (b) Sin[Pi(n+w)]^k -> Sin[Pi w]^k and same for Csc.
             Then Series in w to extract residue, then apply
             MBEApplyPolygammaLimit (derivative in aux ι params) to obtain
             the real Res_n that no longer carries aux symbols. *)
          resN = Quiet@TimeConstrained[
            Module[{w = Unique["wRes"], intAtN, withW, asSeries, rawResN},
              intAtN = modIntg /. z -> n + w;
              withW = intAtN //. {
                (* Gamma reflection: pole-side Gammas after z->n+w *)
                Gamma[-n - w]      :> (-1)^(n+1) Pi/(Sin[Pi w] Gamma[1+n+w]),
                Gamma[-1 - n - w]  :> (-1)^n     Pi/(Sin[Pi w] Gamma[2+n+w]),
                Gamma[-2 - n - w]  :> (-1)^(n+1) Pi/(Sin[Pi w] Gamma[3+n+w]),
                Gamma[1 - n - w]   :> (-1)^n     Pi/(Sin[Pi w] Gamma[n+w]),
                (* Csc/Sin normalization for integer n.
                   Sin[π(n+w)] = (-1)^n Sin[πw]. For even k the sign cancels;
                   for ODD k we must keep it -- otherwise residues with single
                   1/Sin (e.g. Γ(-z)Γ(1+z) = -π/Sin(πz)) get a wrong (-1)^n. *)
                Sin[Pi (n + w)]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                Sin[Pi w + Pi n]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                Sin[Pi n + Pi w]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                Csc[Pi (n + w)]^k_. :> ((-1)^n)^k Csc[Pi w]^k,
                Csc[Pi w + Pi n]^k_. :> ((-1)^n)^k Csc[Pi w]^k,
                Csc[Pi n + Pi w]^k_. :> ((-1)^n)^k Csc[Pi w]^k};
              asSeries = Series[withW, {w, 0, 4}];
              rawResN = SeriesCoefficient[asSeries, -1];
              If[pgResult["HasPolygamma"],
                Quiet@MBEApplyPolygammaLimit[rawResN, pgResult],
                rawResN]],
            180, $TimedOut];
          If[resN =!= $TimedOut && resN =!= 0,
            (* Under the forced retry the caller has a quadrature arbiter and
               a path-B' fallback, so fail FAST here: growth-class kernels
               have divergent towers and would otherwise burn the budget. *)
            sum = Quiet@TimeConstrained[
              Sum[resN, {n, 1, Infinity}],
              If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbeForceSymbolicResidue], 120, 600],
              $TimedOut];
            If[FreeQ[sum, _Sum] && FreeQ[sum, _Residue] && sum =!= $TimedOut,
              total = Quiet@FullSimplify[-(extraResLeft + res0 + sum)];
              Print["[MBtoEuler] Symbolic residue sum SUCCEEDED."];
              Print["    Closed-form cube integrand: ", Short[total, 4]];
              cubeIntg = total;
              partAStream = <|"CubeIntegrand" -> cubeIntg,
                "CubeVariables" -> polyVars,
                "Mode" -> "MBPoleSymbolicResidue", "Pipeline" -> None,
                "MBVarPoleDetected" -> True|>;
              partAEuler = cubeIntg;
              (* NOTE: do NOT clear RationalCorrections here. The symbolic
                 residue only resolves the modIntegrand piece (psi-integral-rep
                 part); the rational corrections from Block 0 polygamma
                 shifts are *separate* additive terms that still need to flow
                 through Part B. (They were cleared in the numerical fallback
                 because that path numerically integrates the *full* original
                 integrand including the polygamma, which subsumes the
                 corrections.) *)
              gotSymbolic = True,
              Print["[MBtoEuler] Symbolic Sum_n failed/timed out."]],
            Print["[MBtoEuler] Symbolic Res_n extraction failed (",
              If[resN === $TimedOut, "timeout", "zero or unevaluated"], ")."]],
          Print["[MBtoEuler] Symbolic Res_0 timed out."]]];
      (* === SYMBOLIC RESIDUE SUM via INTEGRAL REP (path B') ===
         If path B (aux mode for ψ⁰) failed (Sum doesn't close as Euler
         sum), retry by substituting the full polygamma integral
         representation for ALL polygammas in the original integrand.
         The shifted form has ψ⁰(canonical) → -γ + ∫₀¹(...)ds which
         expands the integrand into a sum of (Z^z·F(z)) pieces; each
         closes symbolically via F̂(X) residue sum. The result is a
         γ-dependent cube integrand whose γ-pieces cancel after the
         cube integration. *)
      If[!gotSymbolic && Length[mbVars] == 1,
        Print["[MBtoEuler] Retrying with integral-rep cube..."];
        Module[{irData, irIntg, irVars, irRes0, irResN, irSum, irTotal,
                irExtraResLeft = 0, irNStart, kk},
          z = mbVars[[1]];
          irData = Quiet@mbeBuildShiftedIntegralRep[integrand, mbVars, contourRules, userAss];
          irIntg = irData["Integrand"];
          irVars = irData["CubeVars"];
          irIntg = Quiet@FunctionExpand[irIntg];
          (* Add residues at z=k for k in [Ceiling[contour], -1] if contour < -1 *)
          irNStart = Ceiling[Re[z /. contourRules]];
          If[irNStart < 0,
            irExtraResLeft = Sum[
              Quiet@TimeConstrained[Residue[irIntg, {z, kk}], 30, 0],
              {kk, irNStart, -1}]];
          irRes0 = Quiet@TimeConstrained[
            Residue[irIntg, {z, 0}], 120, $TimedOut];
          If[irRes0 =!= $TimedOut,
            irResN = Quiet@TimeConstrained[
              Module[{w = Unique["wRes"], intAtN, withW, asSeries},
                intAtN = irIntg /. z -> n + w;
                withW = intAtN //. {
                  Gamma[-n - w]      :> (-1)^(n+1) Pi/(Sin[Pi w] Gamma[1+n+w]),
                  Gamma[-1 - n - w]  :> (-1)^n     Pi/(Sin[Pi w] Gamma[2+n+w]),
                  Gamma[-2 - n - w]  :> (-1)^(n+1) Pi/(Sin[Pi w] Gamma[3+n+w]),
                  Gamma[1 - n - w]   :> (-1)^n     Pi/(Sin[Pi w] Gamma[n+w]),
                  Sin[Pi (n + w)]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                  Sin[Pi w + Pi n]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                  Sin[Pi n + Pi w]^k_. :> ((-1)^n)^k Sin[Pi w]^k,
                  Csc[Pi (n + w)]^k_. :> ((-1)^n)^k Csc[Pi w]^k,
                  Csc[Pi w + Pi n]^k_. :> ((-1)^n)^k Csc[Pi w]^k,
                  Csc[Pi n + Pi w]^k_. :> ((-1)^n)^k Csc[Pi w]^k};
                asSeries = Series[withW, {w, 0, 4}];
                SeriesCoefficient[asSeries, -1]],
              240, $TimedOut];
            If[irResN =!= $TimedOut && irResN =!= 0,
              irSum = Quiet@TimeConstrained[
                Sum[irResN, {n, 1, Infinity}], 600, $TimedOut];
              If[FreeQ[irSum, _Sum] && FreeQ[irSum, _Residue] && irSum =!= $TimedOut,
                irTotal = Quiet@Simplify[-(irExtraResLeft + irRes0 + irSum)];
                Print["[MBtoEuler] Integral-rep cube SUCCEEDED."];
                Print["    Cube variables: ", irVars];
                Print["    Closed-form cube integrand: ", Short[irTotal, 4]];
                partAStream = <|"CubeIntegrand" -> irTotal,
                  "CubeVariables" -> irVars,
                  "Mode" -> "MBPoleIntegralRepCube", "Pipeline" -> None,
                  "MBVarPoleDetected" -> True|>;
                partAEuler = irTotal;
                (* Integral-rep cube subsumes Block 0's polygamma shifts:
                   we re-derived everything from the ORIGINAL integrand
                   with shifts applied inline. Clear corrections to
                   prevent double counting. *)
                pgResult = Append[pgResult, "RationalCorrections" -> {}];
                gotSymbolic = True,
                Print["[MBtoEuler] Integral-rep cube Sum_n failed/timed out."]],
              Print["[MBtoEuler] Integral-rep cube Res_n extraction failed (",
                If[irResN === $TimedOut, "timeout", "zero or unevaluated"], ")."]],
            Print["[MBtoEuler] Integral-rep cube Res_0 timed out."]]]];
      (* === NUMERICAL FALLBACK (path D) ===
         If symbolic residue sum failed, fall back to direct numerical
         MB-contour integration of the original integrand. Subsumes Part B. *)
      If[!gotSymbolic,
        Print["[MBtoEuler] SYMBOLIC FAILURE -- computing numerical verification (NOT returned as answer)..."];
        ySyms = Table[ToExpression["yMB$" <> ToString[i]], {i, Length[mbVars]}];
        mbSubs = Thread[mbVars -> Table[
          (mbVars[[i]] /. contourRules) + I*ySyms[[i]], {i, Length[mbVars]}]];
        intg = N[(integrand /. mbSubs) / (2 Pi)^Length[mbVars]];
        ranges = ({#, -Infinity, Infinity} & /@ ySyms);
        mainNum = TimeConstrained[
          Quiet@Switch[Length[ranges],
            1, NIntegrate[intg, ranges[[1]],
                Method -> {"GlobalAdaptive", "MaxErrorIncreases" -> 30000},
                MaxRecursion -> 25, AccuracyGoal -> 8, PrecisionGoal -> 8],
            2, NIntegrate[intg, ranges[[1]], ranges[[2]],
                Method -> {"GlobalAdaptive", "MaxErrorIncreases" -> 30000},
                MaxRecursion -> 18, AccuracyGoal -> 6, PrecisionGoal -> 6],
            3, NIntegrate[intg, ranges[[1]], ranges[[2]], ranges[[3]],
                Method -> {"AdaptiveMonteCarlo", "MaxPoints" -> 1000000},
                AccuracyGoal -> 4, PrecisionGoal -> 4],
            _, $Failed],
          300, $TimedOut];
        If[NumericQ[Re@mainNum] && mainNum =!= $TimedOut,
          Print["[MBtoEuler]   Numerical verification value: ", mainNum,
            " (symbolic NOT closed; FAILURE returned)"];
          partAStream = <|"CubeIntegrand" -> Failure["SymbolicMBPoleFailed",
              <|"Tag" -> "SymbolicMBPoleFailed",
                "Message" -> "Symbolic residue and integral-rep cube paths did not close at MB-variable pole.",
                "NumericalReference" -> mainNum|>],
            "CubeVariables" -> {},
            "Mode" -> "SymbolicMBPoleFailureNumericalVerification",
            "Pipeline" -> None,
            "MBVarPoleDetected" -> True,
            "NumericalReference" -> mainNum|>;
          partAEuler = Failure["SymbolicMBPoleFailed",
            <|"NumericalReference" -> mainNum|>],
          Print["[MBtoEuler]   Numerical verification ALSO failed (", mainNum, ")."];
          partAStream = <|"CubeIntegrand" -> Failure["AllPathsFailed", <||>],
            "CubeVariables" -> {},
            "Mode" -> "AllPathsFailed", "Pipeline" -> None,
            "MBVarPoleDetected" -> True|>;
          partAEuler = Failure["AllPathsFailed", <||>]]]]]];
  corrections = pgResult["RationalCorrections"];
  partBStreams = {}; partBEulers = {};
  (* WORKLIST Part B: process each correction's main ModifiedIntegrand via the
     stream pipeline (preserving the original per-occurrence behavior) AND enqueue
     its NESTED RationalCorrections.  A correction can itself generate corrections
     -- e.g. downshifting psi^(m) with Re>1, or a nested Bell reduction of psi0^k
     inside the lower-Bell terms.  The previous code processed only the top-level
     ModifiedIntegrand and SILENTLY DROPPED nested corrections, corrupting
     Bell-reduction cancellations (Int F psi0^2 -> -17 Pi^4/360 instead of -Pi^4/72).
     The worklist captures them to arbitrary depth (guard caps runaway recursion). *)
  If[Length[corrections]>0,
    If[showSteps, Print["[MBtoEuler] Part B: ",Length[corrections]," correction(s)..."]];
    Module[{queue, ci, hasPg, pgr, ass2, strm, eul, pgv, guard = 0},
      queue = #["Integrand"] & /@ corrections;
      While[queue =!= {} && guard < 2000,
        guard++;
        ci = First[queue]; queue = Rest[queue];
        hasPg = ! FreeQ[ci, PolyGamma[_Integer, _]];
        If[hasPg,
          (* Part-B correction recursion: enable mult==2 Bell here (psi0^2 sub-terms are
             monomial corrections where per-occurrence leaks; see bellGroupQ note). *)
          pgr = Block[{Global`$mbInPartBCorrection = True},
                  MBEPreprocessPolygamma[ci, mbVars, contourRules]];
          ass2 = Which[
            pgr["AuxAssumptions"] === True, userAss,
            userAss === True, pgr["AuxAssumptions"],
            True, And[pgr["AuxAssumptions"], userAss]];
          strm = MBERunStream[pgr["ModifiedIntegrand"], mbVars, contourRules, ass2,
            "Verbose"->verbose,"ShowSteps"->showSteps,"MaxShift"->maxShift];
          If[!FailureQ[strm],
            (* success: standard streaming + enqueue this correction's nested corrections *)
            eul = If[pgr["HasPolygamma"],
              MBEApplyPolygammaLimit[strm["CubeIntegrand"], pgr], strm["CubeIntegrand"]];
            pgv = Lookup[pgr, "PolygammaIntegralVars", {}];
            AppendTo[partBStreams, <|"CubeIntegrand"->eul,
              "CubeVariables"->Join[strm["CubeVariables"], pgv],
              "Mode"->strm["Mode"], "Pipeline"->strm["Pipeline"]|>];
            AppendTo[partBEulers, eul];
            queue = Join[queue, #["Integrand"] & /@ Lookup[pgr, "RationalCorrections", {}]],
            (* MBERunStream FAILED: fall back to the FULL MBtoEuler on the original
               correction ci (it has analytic fallback paths MBERunStream lacks, and it
               subsumes ci's own corrections -> do NOT enqueue pgr's nested here).  Only
               GENUINELY-failing corrections reach this branch, so working ones (e.g.
               piece 5) never hit the full-recursion path -> no regression.  Fixes the
               psi0^4 stream-fail sub-pieces #82 (psi0^2 psi1), #87 (psi0^2/(1+z)^2). *)
            Module[{fbEr = Block[{Global`$mbInPartBCorrection = True},
                Quiet@MBtoEuler[ci, contourRules, mbVars,
                "Assumptions"->userAss, "Verbose"->verbose,
                "ShowSteps"->showSteps, "MaxShift"->maxShift]]},
              If[!FailureQ[fbEr] && AssociationQ[fbEr] && KeyExistsQ[fbEr, "EulerIntegrands"],
                Do[AppendTo[partBStreams, <|"CubeIntegrand"->ei[[1]], "CubeVariables"->ei[[2]],
                     "Mode"->"B5Fallback", "Pipeline"->None|>];
                   AppendTo[partBEulers, ei[[1]]], {ei, fbEr["EulerIntegrands"]}],
                Module[{failure = Failure["PartBStreamFailed",
                    <|"Integrand" -> ci|>]},
                  AppendTo[partBStreams, <|"CubeIntegrand" -> failure,
                    "CubeVariables" -> {}, "Mode" -> "Failure",
                    "Pipeline" -> None|>];
                  AppendTo[partBEulers, failure]]]]],
          (* pure rational (no polygamma) *)
          strm = MBERunStream[ci, mbVars, contourRules, userAss,
            "Verbose"->verbose,"ShowSteps"->showSteps,"MaxShift"->maxShift];
          If[!FailureQ[strm],
            AppendTo[partBStreams, strm]; AppendTo[partBEulers, strm["CubeIntegrand"]],
            Module[{failure = Failure["PartBStreamFailed",
                <|"Integrand" -> ci|>]},
              AppendTo[partBStreams, <|"CubeIntegrand" -> failure,
                "CubeVariables" -> {}, "Mode" -> "Failure",
                "Pipeline" -> None|>];
              AppendTo[partBEulers, failure]]]]]]];
  (* Append polygamma integral variables to Part A's cube variables and
     simplify Abs[...] under positivity assumptions on all cube vars.
     Block 7's 1/Abs[jac] step doesn't see the polygamma integral vars
     in its activeAss, so Abs factors can survive into the final
     integrand and break downstream MPL conversion. *)
  Module[{partAVars = partAStream["CubeVariables"],
          pgIntVars = Lookup[pgResult, "PolygammaIntegralVars", {}],
          posAss, partAEntries, partBEntries, isIntegralRep, cubeVarsOf},
    (* AUTO-DETECT cube vars actually present in an Euler integrand (the t[_]/u[_]/s[_]
       symbols).  The tracked CubeVariables lists can be INCOMPLETE for compound Part-B
       corrections (e.g. psi1^2 -> two integral-rep s-vars from the recursive worklist,
       only one tracked) -> the untracked s-var leaks unintegrated and survives in an
       Abs[...] the sampler then cannot resolve (broke piece 34 sub-pieces 83/86/91/95).
       Union the tracked list with the detected vars to guarantee completeness. *)
    cubeVarsOf[e_] := Cases[e, (h_Symbol)[_] /;
        MemberQ[{"t", "u", "s"}, SymbolName[h]], Infinity] // DeleteDuplicates;
    isIntegralRep = KeyExistsQ[partAStream, "IntegralRepEulers"];
    partAVars = If[isIntegralRep, {}, Union[Join[partAVars, pgIntVars], cubeVarsOf[partAEuler]]];
    If[partAFailure === None && !isIntegralRep,
      posAss = If[partAVars === {}, True,
        And @@ Join[Thread[partAVars > 0], Thread[partAVars < 1]]];
      partAEuler = Simplify[partAEuler, posAss];
      If[!FreeQ[partAEuler, Abs],
        partAEuler = mbeCleanAbsBySampling[partAEuler, partAVars]]];
    partBEntries = Table[{partBEulers[[k]],
        Union[partBStreams[[k]]["CubeVariables"], cubeVarsOf[partBEulers[[k]]]]},
      {k, Length[partBEulers]}];
    partAEntries = Which[
      partAFailure =!= None && !FreeQ[partAEuler, _Failure],
        (* Propagate Failure[] marker so the user sees it instead of
           silently dropping Part A. *)
        {{partAEuler, partAVars}},
      partAFailure =!= None, {},
      isIntegralRep,         partAStream["IntegralRepEulers"],
      True,                  {{partAEuler, partAVars}}];
    eulerIntegrands = Join[partAEntries, partBEntries];
    allResults = <|
      "EulerIntegrands"->eulerIntegrands,
      "HasPolygamma"->pgResult["HasPolygamma"],
      "Assumptions"->ass,
      "PartA"-><|"EulerIntegrand"->partAEuler,
        "CubeVariables"->partAVars,
        "CubeIntegrandBeforeLimit"->partAStream["CubeIntegrand"],
        "Mode"->partAStream["Mode"],"Pipeline"->partAStream["Pipeline"]|>,
      "PartB"->Table[<|"EulerIntegrand"->partBEulers[[k]],
        "CubeVariables"->partBStreams[[k]]["CubeVariables"],
        "Mode"->partBStreams[[k]]["Mode"]|>,{k,Length[partBStreams]}],
      "PartialResult"->(partAFailure =!= None),
      "PartAFailure"->partAFailure,
      "PolygammaPreprocess"->If[verbose,pgResult,None]|>];
  If[cleanOutput, MBEFormatResult[allResults]];
  allResults];


(* ====================================================================
   MBtoEulerMellin -- ε-symbolic wrapper around MBtoEuler.

   Keeps the dimensional regulator ε symbolic through Blocks 1-8 by
   adding a smallness assumption (0 < ε < EpsilonBound by default).
   This lets the existing FullSimplify-based contour decisions
   (mbeShiftCount, MBESuggestDeltaPivots, etc.) evaluate Re-comparisons
   that contain ε without requiring ε to be expanded to a numeric value.

   Useful as a *standalone* entry point when you want the Euler-Mellin
   integrand for the original MB (before MBresolve / MBexpand /
   DoAllBarnes residue computation) -- e.g. for analytic inspection,
   differentiation under the integral, or feeding to a downstream
   ε-expansion engine.

   Does NOT interfere with the resolved-residue route -- that still
   runs via MBtoEuler / MBSymbolicInt on each MBresolve-derived integrand.
   ==================================================================== *)
MBtoEulerMellin[integrand_, contourRules_, mbVars_List,
  opts:OptionsPattern[MBtoEulerMellin]] := Module[
  {epsSym, epsPos, epsBound, userAss, epsAss, mergedAss, mbtOpts,
   degenerateResult},
  epsSym   = OptionValue["EpsilonSymbol"];
  epsPos   = OptionValue["EpsilonPositive"];
  epsBound = OptionValue["EpsilonBound"];
  userAss  = OptionValue["Assumptions"];
  (* Smallness assumption for the regulator. With this active, every
     FullSimplify[Re(arg) > 0, ass] call inside Blocks 1-8 can decide
     the sign of arguments like 1 - 2 ε, -1 - ε, ε, etc. *)
  epsAss = If[epsPos, 0 < epsSym < epsBound, -epsBound < epsSym < 0];
  mergedAss = Which[
    userAss === True || userAss === {} || userAss === None, epsAss,
    ListQ[userAss],   And @@ Append[userAss, epsAss],
    True,             And[userAss, epsAss]];
  mbtOpts = FilterRules[{opts}, Options[MBtoEuler]];
  degenerateResult = mbeDegenerateRepeatedGammaEuler[integrand, contourRules,
    mbVars, epsSym, epsBound, mergedAss, Sequence @@ mbtOpts];
  If[degenerateResult =!= None, Return[degenerateResult]];
  MBtoEuler[integrand, contourRules, mbVars,
    "Assumptions" -> mergedAss, Sequence @@ mbtOpts]];

(* ====================================================================
   INTEGER-SHIFTED POLYGAMMA MERGE.
   When the integrand contains polygammas of the SAME order whose arguments
   differ by a non-negative integer (e.g. psi0(1+z) and psi0(2+z), piece 141),
   Block 0 (mbeDetectPolygammasMult) treats them as INDEPENDENT groups and sums
   their multiplicities over the whole expression -> a bogus high-power Bell aux
   that never matches -> wrong value / hang.  Canonicalize every polygamma to the
   LOWEST equivalent argument via the recurrence
     psi^(m)(arg+n) = psi^(m)(arg) + (-1)^m m! Sum_{k=0}^{n-1} 1/(arg+k)^(m+1).
   MBSymbolicInt then SPLITS the resulting Plus and integrates each monomial separately
   (each a clean single-argument problem).  Returns {didMergeQ, mergedExpr}. *)
mbeIntegerShiftDiff[arg_, base_, mbVars_List] := Module[{d},
  d = Quiet@Simplify[arg - base];
  If[FreeQ[d, Alternatives @@ mbVars] && IntegerQ[d] && d >= 0, d, $Failed]];
mbePolygammaShiftToBase[m_Integer, arg_, base_, n_Integer] :=
  If[n == 0, PolyGamma[m, arg],
    PolyGamma[m, base] + (-1)^m m! Sum[1/(base + k)^(m + 1), {k, 0, n - 1}]];
mbeIntegerShiftRules[expr_, mbVars_List] := Module[{pgs},
  pgs = DeleteDuplicates@Cases[expr,
     PolyGamma[m_Integer, a_] /; ! FreeQ[a, Alternatives @@ mbVars] :> {m, a}, Infinity];
  DeleteCases[
    Table[Module[{m = pg[[1]], arg = pg[[2]], same, candidates, best},
       same = DeleteDuplicates@Cases[pgs, {m, a_} :> a];
       candidates = DeleteCases[
         ({#, mbeIntegerShiftDiff[arg, #, mbVars]} & /@ same), {_, $Failed}];
       best = First@MaximalBy[candidates, Last];   (* lowest base = largest diff *)
       If[best[[2]] > 0,
         PolyGamma[m, arg] :> mbePolygammaShiftToBase[m, arg, best[[1]], best[[2]]],
         Nothing]],
      {pg, pgs}],
    Nothing]];
mbeMergeIntegerShiftedPolygammas[expr_, mbVars_List] := Module[
  {rules = mbeIntegerShiftRules[expr, mbVars]},
  {rules =!= {}, If[rules === {}, expr, Expand[expr /. rules]]}];

End[]  (* `Private` *)


(* ====================================================================
   AEI engine -- Euler -> MPL internals.
   All PolyLogTools calls are FULLY QUALIFIED so they resolve correctly
   even though PolyLogTools` is not on our BeginPackage Needs chain.
   ==================================================================== *)

Begin["`AEI`Private`"]

aeiIsMonomialQ[expr_, vars_List] := Head[Expand[expr]] =!= Plus

aeiIsRelevantQ[expr_, vars_List] := Module[{e = Expand[expr]},
  PolynomialQ[e, vars] && !MatchQ[e,0|1|-1] && !NumericQ[e] && !aeiIsMonomialQ[e, vars]];

aeiIrrFactors[poly_, vars_List] :=
  Select[Expand /@ FactorList[Factor[poly]][[All,1]], aeiIsRelevantQ[#,vars]&];

aeiExtractS0[expr_, vars_List] := Module[{terms, denoms, logArgs, cands},
  terms  = If[Head[Expand[expr]]===Plus, List@@Expand[expr], {expr}];
  denoms = Select[Denominator[Together[#]]& /@ terms,
    (Expand[#]=!=1 && Expand[#]=!=0)&];
  logArgs = Cases[expr, Log[a_]:>a, Infinity];
  cands = DeleteDuplicates[Join[denoms,logArgs]];
  DeleteDuplicates[Flatten[aeiIrrFactors[#,vars]& /@ cands]]];

aeiNextS[S_, xa_, allVars_List] := Module[{n=Length[S], Qs, Rs, crossTerms, rv, cands},
  Qs = Coefficient[#,xa]& /@ S;
  Rs = (#/.xa->0)& /@ S;
  crossTerms = Flatten@Table[Expand[Qs[[k]]Rs[[l]]-Qs[[l]]Rs[[k]]],{k,n},{l,k+1,n}];
  rv = Complement[allVars,{xa}];
  cands = DeleteDuplicates[Expand /@ Join[Qs,Rs,crossTerms]];
  DeleteDuplicates[Flatten[aeiIrrFactors[#,rv]& /@ cands]]];

aeiTryOrder[S0_, ord_List, allVars_List] := Module[
  {S=S0, sets={S0}, sizes={Length[S0]}, ok=True, nxt},
  Do[
    If[!AllTrue[S,Exponent[Expand[#],ord[[i]]]<=1&], ok=False; Break[]];
    nxt = aeiNextS[S,ord[[i]],allVars];
    AppendTo[sets,nxt]; AppendTo[sizes,Length[nxt]]; S=nxt,
    {i,Length[ord]}];
  {ok,sets,sizes}];

(* Check if a variable appears only rationally (not inside Log, G, PolyLog).
   Use full PolyLogTools`G so pattern matches properly. *)
aeiIsRationalOnlyQ[expr_, var_] := Module[{transcArgs},
  transcArgs = Cases[expr,
    (Log|PolyLogTools`G|PolyLog|PolyGamma)[args___]:>{args}, Infinity]//Flatten;
  FreeQ[transcArgs, var]];

aeiGlobalSyms[expr_] :=
  Select[DeleteDuplicates@Cases[expr,_Symbol,{0,Infinity}], (Context[#]==="Global`")&];

aeiDefaultFitValues[vars_List] := Module[
  {n=Length[vars],lo=0.13,hi=0.87,step,vals},
  step = If[n>1,(hi-lo)/(n-1.0),0.0];
  vals = N@Table[lo+(k-1)*step,{k,n}];
  vals = Riffle[vals[[1;;Ceiling[n/2]]], Reverse[vals[[Ceiling[n/2]+1;;n]]]];
  AssociationThread[vars,vals]];

aeiBuildFitList[expr_, fibVars_List, mainFitAss_Association,
                userParamAss_Association, verbose_] := Module[
  {allSyms, known, unknownSyms, autoFit},
  allSyms = aeiGlobalSyms[expr];
  known = Join[Keys[mainFitAss],Keys[userParamAss]];
  unknownSyms = Complement[allSyms,known];
  If[Length[unknownSyms]>0,
    If[verbose, Print["  [AEI] Auto-fit for unrecognised symbols: ",unknownSyms]];
    autoFit = Normal@AssociationThread[unknownSyms,
      N@Table[(k+2)/(Length[unknownSyms]+5),{k,Length[unknownSyms]}]],
    autoFit={}];
  Join[Normal@KeySelect[mainFitAss,MemberQ[fibVars,#]&],
    Normal[userParamAss], autoFit]];

aeiHasFrozenTermsQ[expr_] := Module[{s},
  s = ToString[InputForm[expr],CharacterEncoding->"ASCII"];
  StringContainsQ[s,"CanInt$FrozenCiTi"] ||
  StringContainsQ[s,"Gint["] ||
  StringContainsQ[s,"`Gint["] ||
  StringContainsQ[s,"$Aborted"] ||
  StringContainsQ[s,"ComplexInfinity"] ||
  StringContainsQ[s,"DirectedInfinity"] ||
  StringContainsQ[s,"ToFibrationBasis["] ||
  StringContainsQ[s,"GIntegrate["] ||
  StringContainsQ[s,"ShuffleRegulate["]];

(* Fully-qualified PolyLogTools references throughout.
   HPL[{1},1] pattern replaced using HPL`HPL (HPL package) OR
   PolyLogTools`HPL (if exported). We cover both. *)

aeiTryIntegrate[expr_, xa_, fibVars_List, fitList_List, regSym_, verbose_] := Module[
  {fibExpr, antideriv, hi, lo, res},
  fibExpr = Quiet@CheckAbort[
    TimeConstrained[
      Check[PolyLogTools`ToFibrationBasis[expr,fibVars,
        PolyLogTools`FitValue->fitList],$Failed],
      120, $Failed],
    $Failed];
  If[fibExpr=!=$Failed && aeiHasFrozenTermsQ[fibExpr], fibExpr=$Failed];
  If[fibExpr===$Failed,
    If[verbose,Print["  [AEI] Full fibration failed; retrying {",xa,"}"]];
    fibExpr = Quiet@CheckAbort[
      TimeConstrained[
        Check[PolyLogTools`ToFibrationBasis[expr,{xa},
          PolyLogTools`FitValue->fitList],$Failed],
        60, $Failed],
      $Failed];
    If[fibExpr=!=$Failed && aeiHasFrozenTermsQ[fibExpr], fibExpr=$Failed]];
  If[fibExpr===$Failed, Return[$Failed]];
  antideriv = Quiet@TimeConstrained[
    PolyLogTools`GIntegrate[fibExpr,xa], 120, $Failed];
  If[antideriv===$Failed || !FreeQ[antideriv,$Aborted] || !FreeQ[antideriv,$Failed],
    Return[$Failed]];
  If[aeiHasFrozenTermsQ[antideriv], Return[$Failed]];
  (* Evaluate at endpoints; ShuffleRegulate handles G[{1},1] divergences. *)
  hi = Quiet[
    TimeConstrained[
      (antideriv/.xa->1) // PolyLogTools`ShuffleRegulate,
      60, $Failed],
    {Power::infy, Power::indet, General::stop, General::ovfl, Infinity::indet}];
  lo = Quiet[
    TimeConstrained[
      (antideriv/.xa->0) // PolyLogTools`ShuffleRegulate,
      60, $Failed],
    {Power::infy, Power::indet, General::stop, General::ovfl, Infinity::indet}];
  If[hi===$Failed||lo===$Failed, Return[$Failed]];
  res = (hi - lo) /. HPL`HPL[{1},1] :> regSym;
  (* Also replace any PolyLogTools`HPL form if present *)
  res = res /. PolyLogTools`HPL[{1},1] :> regSym;
  If[aeiHasFrozenTermsQ[res], Return[$Failed]];
  Collect[res, _PolyLogTools`G, Simplify]];

aeiIntegrateStep[expr_, xa_, remainOrder_List, mainFitAss_Association,
                 paramAss_Association, regSym_, verbose_] := Module[
  {fibVars, fitList, res, w, exprSub, fitListSub, fibVarsSub, gArgs, hasSing, w2},
  fibVars = Join[{xa},remainOrder];
  fitList = aeiBuildFitList[expr,fibVars,mainFitAss,paramAss,verbose];
  (* Pre-check: singular G-args at xa=1 => pre-substitute xa->1-w *)
  gArgs = Cases[expr, PolyLogTools`G[args__, _] :> {args}, Infinity]//Flatten//DeleteDuplicates;
  hasSing = AnyTrue[gArgs, Function[arg,
    !FreeQ[arg, xa] && (
      !NumericQ[Quiet[arg /. xa->1.0]] ||
      Abs[Quiet[arg /. xa->1.0]] > 10^6)]];
  If[hasSing,
    w2 = Unique["w"];
    exprSub  = expr /. xa -> 1-w2;
    fitListSub = fitList /. (xa -> v_) :> (w2 -> 1-v);
    fibVarsSub = fibVars /. xa -> w2;
    If[verbose, Print["  [AEI] Pre-sub ",xa," -> 1-w (singular G-args)"]];
    res = aeiTryIntegrate[exprSub, w2, fibVarsSub, fitListSub, regSym, False];
    If[res =!= $Failed, Return[res]]];
  If[verbose, Print["  [AEI] Fibrating over ",fibVars]];
  res = aeiTryIntegrate[expr, xa, fibVars, fitList, regSym, verbose];
  If[res =!= $Failed, Return[res]];
  (* Fallback 1: xa -> 1-w *)
  If[verbose, Print["  [AEI] Fallback 1: ",xa," -> 1-w"]];
  w = Unique["w"];
  exprSub    = Simplify[expr/.xa->1-w];
  fitListSub = fitList/.(xa->v_):>(w->1-v);
  fibVarsSub = fibVars/.xa->w;
  res = aeiTryIntegrate[exprSub,w,fibVarsSub,fitListSub,regSym,verbose];
  If[res =!= $Failed, Return[res]];
  (* Fallback 2: xa -> w^2 *)
  If[verbose, Print["  [AEI] Fallback 2: ",xa," -> w^2"]];
  exprSub    = Simplify[(expr/.xa->w^2)*2w];
  fitListSub = fitList/.(xa->v_):>(w->Sqrt[v]);
  res = aeiTryIntegrate[exprSub,w,fibVarsSub,fitListSub,regSym,verbose];
  If[res =!= $Failed, Return[res]];
  If[verbose, Print["  [AEI] All fallbacks failed for ",xa]];
  $Failed];

AEI$BestOrder[expr_, vars_List] := Module[
  {S0, perms, trials, valid, scored, rVars, tVars},
  S0 = aeiExtractS0[expr, vars];
  rVars = Select[vars, aeiIsRationalOnlyQ[expr, #]&];
  tVars = Complement[vars, rVars];
  If[Length[rVars]>0 && Length[tVars]>0,
    perms = Flatten[Outer[Join, Permutations[rVars], Permutations[tVars], 1], 1],
    perms = Permutations[vars]];
  trials = {#, aeiTryOrder[S0, #, vars]}& /@ perms;
  valid  = Select[trials, #[[2,1]]===True&];
  If[Length[valid]===0 && Length[rVars]>0,
    perms = Permutations[vars];
    trials = {#, aeiTryOrder[S0, #, vars]}& /@ perms;
    valid = Select[trials, #[[2,1]]===True&]];
  If[Length[valid]===0, Return[{False, {}, S0}]];
  scored = SortBy[({#[[1]], #[[2,2]], #[[2,3]], Total[#[[2,3]]],
    Count[Take[#[[1]], Min[Length[rVars], Length[#[[1]]]]],
      v_/;MemberQ[rVars,v]]}& /@ valid),
    ({-#[[5]], #[[4]]}&)];
  {True, scored[[1,1]], S0}];

AEI$Analysis[expr_, vars_List] := Module[
  {found, ord, S0, ok, sets, sizes, sep, Qs, Rs},
  sep = "================================================";
  {found, ord, S0} = AEI$BestOrder[expr, vars];
  Print[sep]; Print["  LINEAR REDUCIBILITY  |  vars: ", vars];
  Print["  |S0| = ", Length[S0]];
  Do[Print["    P[", k, "] = ", S0[[k]]], {k, Length[S0]}];
  Print[sep];
  If[!found, Print["  No linearly reducible ordering found."]; Return[Null]];
  {ok, sets, sizes} = aeiTryOrder[S0, ord, vars];
  Print["  Best order (Sigma|S|=", Total[sizes], "): ",
    StringJoin[Riffle[ToString/@ord, " \[Rule] "]]];
  Print["  |S| chain: ", sizes]; Print[sep];
  Do[
    Module[{xa = ord[[i]], S = sets[[i]]},
      Qs = Coefficient[#, xa]& /@ S;
      Rs = (#/.xa->0)& /@ S;
      Do[
        If[Expand[Qs[[j]]] =!= 0,
          Print["  int ", xa, ":  ", xa, " = ", Simplify[-Rs[[j]]/Qs[[j]]]]],
        {j, Length[S]}]],
    {i, Length[ord]}];
  Print[sep]];

aeiRunIntegration[expr_, vars_List, mainFitAss_Association, paramAss_Association,
                  order_List, regs_List, doSimp_, verbose_] := Module[
  {cur = expr, xa, rem, reg, stepRes},
  Do[
    xa  = order[[i]];
    rem = order[[i+1;;-1]];
    reg = regs[[i]];
    If[verbose,
      Print["  [AEI] Step ",i,"/",Length[order]," : integrating ",xa,
        "  remaining: ",If[rem==={},"(none)",rem]]];
    stepRes = aeiIntegrateStep[cur, xa, rem, mainFitAss, paramAss, reg, verbose];
    If[stepRes === $Failed, Return[$Failed]];
    cur = stepRes;
    If[doSimp, cur = Simplify[cur]];
    If[verbose, Print["  [AEI] After step ",i,": ",cur]],
    {i, Length[order]}];
  cur];

End[]  (* `AEI`Private` *)


(* ====================================================================
   ROUTING PREDICATE (2026-06-23): decide Subtraction vs Standard.

   Route a residue's whole integral to STANDARD iff ANY residue contains a
   cluster of >=2 mutually-overlapping GENUINE non-normal-crossing compound
   eps-singular factors -- the nested-sector-decomposition case (e.g. MB14
   res5, the doubly-overlapping compound corner whose iterated SD produces
   spurious deep poles that subtraction cannot cancel robustly).  A single
   genuine compound, or several NON-overlapping ones, are each one clean SD
   pass and stay on SUBTRACTION (MBpilot12; MBpilot13; MB14 res1-4).

   "Genuine" non-normal-crossing = a Plus base, eps^0 exponent <= -1, that
   vanishes on a coordinate face AND whose remainder STILL vanishes at the
   origin after pulling out the leading coordinate monomial (reflecting ->1
   faces to ->0).  Bases that factor as monomial x (regular, nonzero at the
   origin) are really normal-crossing and one SD pass clears them.

   The helpers below are a minimal, self-contained copy of the validated
   sd_full.m detection chain so the package needs no external Get.
   Conservative on failure: if a residue cannot be analysed, treat it as
   needing STANDARD (the certified fallback).
   ==================================================================== *)

Begin["`Private`"]

mbtRpHasVars[ex_, vars_] := ! FreeQ[ex, Alternatives @@ vars];

mbtRpNorm[expr_, vars_] := FixedPoint[
   Replace[#, {
      Power[Times[a_, b__], e_] :> Power[a, e] Power[Times[b], e],
      Power[Power[a_, m_], e_] :> Power[a, m e],
      Power[r_, e_] /; (Together[r] =!= r && Denominator[Together[r]] =!= 1) :>
         Power[Numerator[Together[r]], e] Power[Denominator[Together[r]], -e]
      }, {0, Infinity}] &,
   expr];

mbtRpC0[e_, eps_] := Quiet[Simplify[e /. eps -> 0]];

mbtRpCoordQ[base_, vars_] := Module[{b = Expand[base], vs},
   vs = Select[vars, ! FreeQ[b, #] &];
   Length[vs] == 1 && Exponent[b, vs[[1]]] == 1];

mbtRpLowMonoK[poly_, vars_] := Module[{p = Expand[poly], cr, k},
   If[PossibleZeroQ[p], Return[{1, ConstantArray[0, Length[vars]]}]];
   cr = CoefficientRules[p, vars];
   k = Min /@ Transpose[cr[[All, 1]]];
   {Times @@ MapThread[#1^#2 &, {vars, k}], k}];
mbtRpLowMono[poly_, vars_] := mbtRpLowMonoK[poly, vars][[1]];

mbtRpMono[expr_, vars_, eps_] := expr /. Power[b_, e_] /; (
     mbtRpHasVars[b, vars] && Head[Expand[b]] === Plus && ! mbtRpCoordQ[b, vars] &&
      IntegerQ[mbtRpC0[e, eps]] && mbtRpC0[e, eps] <= -1) :>
   Module[{p = Expand[b], M, k, rem},
     {M, k} = mbtRpLowMonoK[p, vars]; rem = Expand[p/M];
     If[M === 1, Power[p, e],
        (Times @@ MapThread[#1^(#2 e) &, {vars, k}]) Power[rem, e]]];

mbtRpPrep[expr_, vars_, eps_] :=
   FixedPoint[mbtRpMono[mbtRpNorm[#, vars], vars, eps] &, expr, 12];

mbtRpPts[vars_, n_] := (SeedRandom[17];
   Table[Thread[vars -> RandomReal[{7/97, 89/97}, Length[vars]]], {n}]);

(* minimal coordinate face on which base vanishes; None if regular.  Quiet
   guards the sampling: a rational denom may blow up at a test point -> the
   value is non-numeric, Chop[...]===0 is False, so the face is rejected. *)
mbtRpZeroFace[base_, vars_, pts_] := Module[{vs},
   vs = Select[vars, ! FreeQ[base, #] &];
   Catch[
    Do[Do[Do[
       If[AllTrue[pts, Function[pt,
            Chop[Quiet[N[base /. Join[Thread[S -> vals],
                 Thread[Complement[vars, S] -> (Complement[vars, S] /. pt)]]]],
              10^-7] === 0]],
          Throw[Thread[S -> vals]]],
       {vals, Tuples[{0, 1}, k]}], {S, Subsets[vs, {k}]}], {k, 1, Length[vs]}];
    None]];

(* genuine non-normal-crossing compound bases in one Euler integrand *)
mbtRpGenuineNCBases[ig_, cv_, eps_] :=
   Module[{f = mbtRpPrep[ig, cv, eps], cands, pts},
   pts = mbtRpPts[cv, 6];
   cands = DeleteDuplicates@Cases[f,
      Power[b_, e_] /; (mbtRpHasVars[b, cv] && Head[Expand[b]] === Plus &&
          ! mbtRpCoordQ[b, cv] && IntegerQ[mbtRpC0[e, eps]] &&
          TrueQ[mbtRpC0[e, eps] <= -1]) :> b,
      {0, Infinity}];
   Select[cands, Function[b, Module[{face, refl, bR, M, rem},
      face = Quiet[mbtRpZeroFace[b, cv, pts]];
      If[face === None, Return[False]];
      refl = Cases[face, (v_ -> 1) :> v];
      bR = Expand[b /. Thread[refl -> (1 - refl)]];
      M = mbtRpLowMono[bR, cv]; rem = Expand[bR/M];
      TrueQ[Quiet[PossibleZeroQ[rem /. Thread[cv -> 0]]]]]]]];

(* largest cluster of genuine compounds that pairwise share a cube variable
   (union-find over "shares a cube var").  size>=2  <=>  nested SD required. *)
mbtRpMaxNCCluster[bases_, cv_] :=
   Module[{vlists, n = Length[bases], parent, find, union, sizes},
   If[n == 0, Return[0]];
   vlists = (Intersection[Variables[#], cv] &) /@ bases;
   parent = Range[n];
   find[i_] := If[parent[[i]] === i, i, find[parent[[i]]]];
   union[i_, j_] := Module[{ri = find[i], rj = find[j]},
      If[ri =!= rj, parent[[ri]] = rj]];
   Do[If[Intersection[vlists[[i]], vlists[[j]]] =!= {}, union[i, j]],
      {i, n}, {j, i + 1, n}];
   sizes = Tally[find /@ Range[n]][[All, 2]];
   Max[sizes]];

(* one residue (an MBresolve term {integrand, {dir, contour}}): True => the
   whole integral must go to STANDARD.  Conservative: $Failed -> True. *)
mbtRpResidueNeedsStandardQ[term_, eps_] := Module[{ctr, intg, vars0, res},
   ctr = term[[2, 2]];
   If[ctr === {}, Return[False]];
   intg = term[[1]]; vars0 = Keys[ctr];
   res = Quiet @ Check[
     Module[{er, ig, cv},
       er = Block[{Print}, MBAnalytica`SymbolicInt`MBtoEulerMellin[intg, ctr, vars0]];
       ig = er["EulerIntegrands"][[1, 1]];
       cv = er["EulerIntegrands"][[1, 2]];
       mbtRpMaxNCCluster[mbtRpGenuineNCBases[ig, cv, eps], cv] >= 2],
     $Failed];
   If[res === $Failed,
    Message[MBresolveToMPL::rpfail]; True, TrueQ[res]]];

(* whole-integral predicate over a MBresolve list: True => route to STANDARD *)
mbtRpNeedsStandardQ[resList_, eps_] :=
   AnyTrue[resList, mbtRpResidueNeedsStandardQ[#, eps] &];

(* ONE-FOLD TOWER-CLOSURE FAMILY ROUTE (2026-07-04, v2 engine): general
   handler for MBresolve lists whose residues are ALL 0- or 1-fold.
   total = Sum Series(0-folds) + Sum towerClosure(1-folds).  Validated:
   MB1 to e^5, MB2 to e^4 (RES_PIPELINE_LOG).  Fails loudly -> fallback. *)
(* ============================================================
   ONE-FOLD TOWER CLOSURE ENGINE v2 (2026-07-04) — general module.
   v2 FIXES: (1) slope-0 (constant) Gammas accepted; (2) ALL failure exits
   via Throw/Catch (Return-inside-Do trap silently truncated the pole scan
   in v1 -> partial closures; caught by package regression).
   ============================================================ *)

mbeOFC$fail[msg_] := (Print["mbeOFC FAIL-LOUD: ", msg]; Throw[$Failed, mbeOFC$tag]);

mbeOFCDecompose[f_, z_] := Module[{fac, gam = {}, rest = 1},
  fac = If[Head[#] === Times, List @@ #, {#}] &[Together[f]];
  Do[Which[
     MatchQ[t, Power[Gamma[_], _Integer]], AppendTo[gam, {t[[1, 1]], t[[2]]}],
     MatchQ[t, Gamma[_]], AppendTo[gam, {t[[1]], 1}],
     MatchQ[t, Power[Gamma[_], _]], mbeOFC$fail["non-integer Gamma power"],
     True, rest = rest t],
    {t, fac}];
  <|"Gammas" -> gam, "Rest" -> rest|>];

mbeOFCRightPoles[gam_List, z_, c_?NumericQ, eN_] := Module[
  {towers = {}, finite = <||>},
  Do[Module[{l = g[[1]], p = g[[2]], al, be},
    If[p > 0,
     al = Coefficient[l, z, 0]; be = Coefficient[l, z, 1];
     Which[
      be === 0, Null,                          (* constant Gamma: fine *)
      be === -1,
      Module[{n0 = Max[0, Ceiling[c - (al /. eN)]]},
       AppendTo[towers, <|"Base" -> al + n0, "Al" -> al, "N0" -> n0, "Mult" -> p|>]],
      be === 1,
      Module[{k = 0},
       While[((-al - k) /. eN) > c,
        finite[-al - k] = Lookup[finite, Key[-al - k], 0] + p; k++]],
      True, mbeOFC$fail["slope not 0/+-1: " <> ToString[l]]]]],
   {g, gam}];
  <|"Towers" -> towers, "Finite" -> Normal[finite]|>];

mbeOFCTowerSum[dec_, z_, a_, e_, al_: None, n0_: 0] := Module[
  {gam = dec["Gammas"], rest = dec["Rest"], num = {}, den = {}, pref = 1,
   negP = 1, ph, hit = False, astrip},
  astrip = If[al === None, a, al];
  gam = Map[Module[{l = #[[1]], p = #[[2]]},
      If[! hit && p >= 1 && Coefficient[l, z, 1] === -1 &&
        Simplify[Coefficient[l, z, 0] - astrip] === 0, hit = True; {l, p - 1}, {l, p}]] &,
    gam];
  If[! hit, mbeOFC$fail["tower base Gamma not found"]];
  If[n0 > 0, AppendTo[num, 1]; AppendTo[den, 1 + n0]];
  ph = FullSimplify[(rest /. z -> a + Global`nn)/(rest /. z -> a),
    Assumptions -> Element[Global`nn, Integers] && Global`nn >= 0];
  If[! FreeQ[ph, Global`nn],
   mbeOFC$fail["phase not n-constant: " <> ToString[ph]]];
  pref = (rest /. z -> a) If[n0 > 0, (-1)^n0/Gamma[1 + n0], 1];
  Do[Module[{l = g[[1]], p = g[[2]], s, l0},
    If[p =!= 0,
     s = Coefficient[l, z, 1]; l0 = Simplify[l /. z -> a];
     pref = pref Gamma[l0]^p;
     Which[
      s === 0, Null,
      s === 1,  If[p > 0, Do[AppendTo[num, l0], {p}], Do[AppendTo[den, l0], {-p}]],
      s === -1, negP += p;
                If[p > 0, Do[AppendTo[den, 1 - l0], {p}], Do[AppendTo[num, 1 - l0], {-p}]],
      True, mbeOFC$fail["slope " <> ToString[s]]]]],
   {g, gam}];
  <|"Pref" -> pref, "Num" -> num, "Den" -> den, "Arg" -> (-1)^negP,
   "Exact" -> pref HypergeometricPFQ[num, den, (-1)^negP]|>];

mbeOFCFiniteRes[f_, z_, z0_, m_] :=
  SeriesCoefficient[Series[f, {z, z0, m + 1}], -1];

mbeOFCClose[f_, z_, e_, c_?NumericQ, eN_] := Catch[Module[
  {dec, rp, parts = {}, exact = 0},
  dec = mbeOFCDecompose[f, z];
  rp = mbeOFCRightPoles[dec["Gammas"], z, c, eN];
  Do[If[tw["Mult"] > 1, mbeOFC$fail["multiple-pole tower unsupported"]];
   Module[{t = mbeOFCTowerSum[dec, z, tw["Base"], e,
      Lookup[tw, "Al", None], Lookup[tw, "N0", 0]]},
    AppendTo[parts, <|"Type" -> "Tower", "Base" -> tw["Base"], "Data" -> t|>];
    exact += t["Exact"]],
   {tw, rp["Towers"]}];
  Do[Module[{r = -mbeOFCFiniteRes[f, z, fp[[1]], fp[[2]]]},
    AppendTo[parts, <|"Type" -> "Finite", "Z" -> fp[[1]], "Data" -> r|>];
    exact += r],
   {fp, rp["Finite"]}];
  <|"Exact" -> exact, "Parts" -> parts, "RightPoles" -> rp|>], mbeOFC$tag];

mbeOFCGate[f_, z_, cl_, c_?NumericQ, e_, ee_] := Module[{ref, v},
  ref = NIntegrate[(f /. e -> ee) /. z -> c + I Global`tGate,
     {Global`tGate, -Infinity, Infinity}, WorkingPrecision -> 30,
     PrecisionGoal -> 12, MaxRecursion -> 12]/(2 Pi);
  v = N[cl["Exact"] /. e -> ee, 25];
  {v, ref, Chop[N[v - ref, 20], 10^-10]}];


mbeOneFoldFamilyLaurent[resList_, eps_, ordMin_, ordMax_, verbose_] := Module[
  {exacts = {}, total, ser, out},
  Catch[
   Do[Module[{intg = resList[[i, 1]], ctr = resList[[i, 2, 2]], var, c, cl},
     Which[
      ctr === {}, AppendTo[exacts, intg],
      Length[ctr] === 1,
      var = Keys[ctr][[1]]; c = Rationalize[ctr[[1, 2]], 0];
      cl = Quiet @ mbeOFCClose[intg, var, eps, c, eps -> -1/100];
      If[cl === $Failed || ! FreeQ[cl, $Failed],
       Message[MBresolveToMPL::ofcfail, i]; Throw[$Failed, mbeOFCFam]];
      AppendTo[exacts, cl["Exact"]];
      If[verbose, Print["  Res#", i, ": one-fold tower closure (",
        Length[cl["Parts"]], " parts)"]],
      True,
      Message[MBresolveToMPL::ofcfail, i]; Throw[$Failed, mbeOFCFam]]],
    {i, Length[resList]}];
   mbeEnsureHypExp[];
   total = Total[exacts] /. f : HypergeometricPFQ[__] :>
      Quiet @ Symbol["HypExp`HypExp"][f, eps, ordMax + 6];
   If[! FreeQ[total, HypergeometricPFQ],
    Message[MBresolveToMPL::ofcfail, 0]; Throw[$Failed, mbeOFCFam]];
   ser = Quiet @ Series[total, {eps, 0, ordMax}];
   out = Table[SeriesCoefficient[ser, k], {k, ordMin, ordMax}];
   If[! FreeQ[out, Indeterminate | ComplexInfinity | $Failed | SeriesCoefficient],
    Message[MBresolveToMPL::ofcfail, -1]; Throw[$Failed, mbeOFCFam]];
   out, mbeOFCFam]];


End[]  (* `Private` *)


(* ====================================================================
   PUBLIC IMPLEMENTATIONS  -- Euler2MPL and MBSymbolicInt
   ==================================================================== *)

Begin["`Public2`"]

mbtPLTAvailable[] := MemberQ[$Packages, "PolyLogTools`"];

(* PLT requires atom-symbol integration variables. Our cube vars are
   indexed MBAnalytica`SymbolicInt`t[i], MBAnalytica`SymbolicInt`u[j]. Flatten them to Global`MBtmpVar<k>. *)
mbtFlattenVars[cubeVars_List] :=
  Table[Symbol["Global`MBtmpVar" <> ToString[k]], {k, Length[cubeVars]}];

(* Smart fit values: bump variables so every denominator factor
   evaluates to a real positive number at the fit point. *)
mbtSmartFitValues[flatIntegrand_, flatVars_, defaultFitAss_] := Module[
  {den, factors, fitAss, dv, tv, fv},
  den = Quiet[Denominator[Together[flatIntegrand]]];
  If[!PolynomialQ[den, flatVars], Return[defaultFitAss]];
  factors = Cases[FactorList[Factor[den]],
    {f_, _} /; PolynomialQ[f, flatVars] &&
               Exponent[Expand[f], flatVars, Max] > 0 :> f];
  If[factors === {}, Return[defaultFitAss]];
  fitAss = defaultFitAss;
  Do[
    dv = Quiet[N[f /. Normal[fitAss]]];
    If[!NumberQ[dv] || Re[dv] <= 10^-6 || Abs[Im[dv]] > 10^-8*(1+Abs[Re[dv]]),
      Catch[
        Do[
          If[!FreeQ[f, v],
            Do[
              fv = Association[fitAss, v -> tv];
              dv = Quiet[N[f /. Normal[fv]]];
              If[NumberQ[dv] && Re[dv] > 10^-6 && Abs[Im[dv]] < 10^-8,
                fitAss = fv; Throw[$Done]],
              {tv, {2.0, 3.0, 4.0, 5.0, 8.0, 1.5, 0.2, 0.1}}
            ]],
          {v, flatVars}]],
      {}],
    {f, factors}];
  fitAss];

(* IntVol availability check. IntVolIntegrate is loaded at the top of
   this file (Get[IntVol_stable.m]); it defines IntVolIntegrate as
   SetDelayed-with-patterns, so check DownValues. *)
mbtIntVolAvailableQ[] := DownValues[Global`IntVolIntegrate] =!= {};

(* ----------------------------------------------------------------
   PRIMARY (AEI) backend: PLT-direct fast path. Tries fibration +
   GIntegrate + ShuffleRegulate with a few standard variable
   substitutions. Fast for the simple Euler integrands generated
   by the IntegralRep pipeline; fails on Möbius G-args and
   algebraic letters (those go to the IntVol fallback below).
   ---------------------------------------------------------------- *)
mbtIntegrateOnePieceAEI[cubeIntegrand_, cubeVars_List, opts_Association] := Module[
  {verbose, paramAssOpt, orderOpt, fitOpt, greedy, doSimp, trackReg,
   mainFitAss, paramAss, order, regs, result, flatVars, toFlat, flatIntegrand,
   allSyms, known, unknownSyms, userPrefix, remainVars, autoFound, autoOrder, autoS0,
   perms, trials, valid, sc},
  verbose     = Lookup[opts, "Verbose",           False];
  paramAssOpt = Lookup[opts, "ParametricValues",  Automatic];
  orderOpt    = Lookup[opts, "IntegrationOrder",  Automatic];
  fitOpt      = Lookup[opts, "FitValues",         Automatic];
  greedy      = Lookup[opts, "GreedySearch",      False];
  doSimp      = Lookup[opts, "SimplifySteps",     False];
  trackReg    = Lookup[opts, "TrackRegulator",    False];
  If[!mbtPLTAvailable[],
    Return[<|"Success"->False, "Result"->cubeIntegrand,
      "CubeVariables"->cubeVars, "ScopeMessage"->"PLT not loaded."|>]];
  If[cubeVars === {},
    Return[<|"Success"->True, "Result"->cubeIntegrand,
      "CubeVariables"->{}, "ScopeMessage"->""|>]];
  flatVars      = mbtFlattenVars[cubeVars];
  toFlat        = Thread[cubeVars -> flatVars];
  flatIntegrand = cubeIntegrand /. toFlat;
  mainFitAss = Switch[fitOpt,
    Automatic,    MBAnalytica`SymbolicInt`AEI`Private`aeiDefaultFitValues[flatVars],
    _List,        Association[fitOpt /. toFlat],
    _Association, fitOpt /. toFlat,
    _,            MBAnalytica`SymbolicInt`AEI`Private`aeiDefaultFitValues[flatVars]];
  mainFitAss = mbtSmartFitValues[flatIntegrand, flatVars, mainFitAss];
  paramAss = Switch[paramAssOpt,
    Automatic,    <||>,
    _List,        Association[paramAssOpt /. toFlat],
    _Association, paramAssOpt /. toFlat,
    _,            <||>];
  allSyms     = MBAnalytica`SymbolicInt`AEI`Private`aeiGlobalSyms[flatIntegrand];
  known       = Join[Keys[mainFitAss], Keys[paramAss]];
  unknownSyms = Complement[allSyms, known];
  If[Length[unknownSyms] > 0,
    paramAss = Join[
      AssociationThread[unknownSyms,
        N@Table[(k+2)/(Length[unknownSyms]+5), {k, Length[unknownSyms]}]],
      paramAss]];
  Which[
    orderOpt===Automatic || orderOpt==={},
      userPrefix={}; remainVars=flatVars,
    ListQ[orderOpt] && Length[orderOpt]<Length[flatVars],
      userPrefix=orderOpt/.toFlat; remainVars=Complement[flatVars,userPrefix],
    ListQ[orderOpt] && Length[orderOpt]>=Length[flatVars],
      userPrefix=orderOpt/.toFlat; remainVars={},
    True,
      userPrefix={}; remainVars=flatVars];
  If[Length[remainVars]>0,
    autoS0 = MBAnalytica`SymbolicInt`AEI`Private`aeiExtractS0[flatIntegrand, flatVars];
    Do[autoS0 = MBAnalytica`SymbolicInt`AEI`Private`aeiNextS[autoS0, v, flatVars], {v, userPrefix}];
    If[greedy || Length[remainVars]>7,
      Module[{S=autoS0, rem=remainVars, ord={}, ok=True, linV, best},
        While[Length[rem]>0,
          linV = Select[rem, Function[v,
            AllTrue[S, Exponent[Expand[#], v]<=1&]]];
          If[Length[linV]===0, ok=False; Break[]];
          best = MinimalBy[linV,
            {Length[MBAnalytica`SymbolicInt`AEI`Private`aeiNextS[S, #, flatVars]]&,
             If[MBAnalytica`SymbolicInt`AEI`Private`aeiIsRationalOnlyQ[flatIntegrand, #], 0, 1]&}][[1]];
          AppendTo[ord, best];
          S = MBAnalytica`SymbolicInt`AEI`Private`aeiNextS[S, best, flatVars];
          rem = DeleteCases[rem, best]];
        autoFound = ok; autoOrder = ord],
      perms  = Permutations[remainVars];
      trials = {#, MBAnalytica`SymbolicInt`AEI`Private`aeiTryOrder[autoS0, #, flatVars]}& /@ perms;
      valid  = Select[trials, #[[2,1]]===True&];
      If[Length[valid]>0,
        sc = SortBy[({#[[1]], Total[#[[2,3]]]}& /@ valid), Last];
        autoFound = True; autoOrder = sc[[1,1]],
        autoFound = False; autoOrder = {}]];
    If[!autoFound,
      Return[<|"Success"->False, "Result"->cubeIntegrand,
        "CubeVariables"->cubeVars,
        "ScopeMessage"->"AEI: no linearly reducible order found."|>]];
    order = Join[userPrefix, autoOrder],
    order = userPrefix];
  regs = If[trackReg,
    Table[Symbol["Global`MBTreg$"<>ToString[k]], {k, Length[order]}],
    ConstantArray[0, Length[order]]];
  result = Quiet[
    MBAnalytica`SymbolicInt`AEI`Private`aeiRunIntegration[
      flatIntegrand, flatVars, mainFitAss, paramAss, order, regs, doSimp, verbose],
    {Power::infy, Power::indet, General::stop, General::ovfl}];
  If[result === $Failed ||
     MBAnalytica`SymbolicInt`AEI`Private`aeiHasFrozenTermsQ[result] ||
     result === Indeterminate ||
     (* Round 8 (2026-06-05): also reject results that still contain any
        of the cube variables (a partial integration leaks the flat
        MBtmpVar* symbols).  This signals the AEI path could not fully
        reduce the integrand and the MMA/IntVol fallback should take
        over.  Critical for post-Hepp compound bases. *)
     ! FreeQ[result, Alternatives @@ flatVars],
    Return[<|"Success"->False, "Result"->cubeIntegrand,
      "CubeVariables"->cubeVars,
      "ScopeMessage"->"AEI produced unevaluated/indeterminate/var-leaked terms."|>]];
  <|"Success"->True, "Result"->result, "CubeVariables"->cubeVars,
    "ScopeMessage"->""|>];

(* ----------------------------------------------------------------
   FALLBACK (IntVol) backend: heavier but far more capable engine.
   Handles Möbius G-args, algebraic letters, partial-fraction
   blow-ups, and big expressions that AEI can't. Used only when
   AEI returns Success: False to avoid the per-piece overhead.
   ---------------------------------------------------------------- *)
mbtIntegrateOnePieceIntVol[cubeIntegrand_, cubeVars_List, opts_Association] := Module[
  {verbose, paramAssOpt, orderOpt, fitOpt, greedy, doSimp, trackReg,
   paramAss, orderResolved, ivResult, result, flatVars, toFlat, flatIntegrand},

  verbose     = Lookup[opts, "Verbose",           False];
  paramAssOpt = Lookup[opts, "ParametricValues",  Automatic];
  orderOpt    = Lookup[opts, "IntegrationOrder",  Automatic];
  fitOpt      = Lookup[opts, "FitValues",         Automatic];
  greedy      = Lookup[opts, "GreedySearch",      False];
  doSimp      = Lookup[opts, "SimplifySteps",     False];
  trackReg    = Lookup[opts, "TrackRegulator",    False];

  (* PolyLogTools + IntVol both loaded? *)
  If[!mbtPLTAvailable[],
    Return[<|"Success"->False, "Result"->cubeIntegrand,
      "CubeVariables"->cubeVars,
      "ScopeMessage"->
        "Converting to MPL is beyond current scope: PolyLogTools not loaded."|>]];
  If[!mbtIntVolAvailableQ[],
    Return[<|"Success"->False, "Result"->cubeIntegrand,
      "CubeVariables"->cubeVars,
      "ScopeMessage"->
        "Converting to MPL is beyond current scope: IntVol package not loaded."|>]];

  (* Empty integrand / 0 variables - trivial case *)
  If[cubeVars === {},
    Return[<|"Success"->True, "Result"->cubeIntegrand,
      "CubeVariables"->{}, "ScopeMessage"->""|>]];

  (* Flatten indexed cube vars to atom symbols that IntVol/PLT can handle *)
  flatVars      = mbtFlattenVars[cubeVars];
  toFlat        = Thread[cubeVars -> flatVars];
  flatIntegrand = cubeIntegrand /. toFlat;
  If[verbose,
    Print["  [Euler2MPL] Variable flattening: ", toFlat]];

  (* Translate ParametricValues / IntegrationOrder to flat-variable form *)
  paramAss = Switch[paramAssOpt,
    Automatic,    Automatic,
    _List,        Normal[Association[paramAssOpt /. toFlat]],
    _Association, Normal[paramAssOpt /. toFlat],
    _,            Automatic];

  (* When no order is specified, BIAS the polygamma integral-rep s-vars to be
     integrated LAST (pass the non-s cube vars as the order prefix; IntVolIntegrate
     auto-orders the remaining s-vars after them, with retry still available).
     Reason: an integral-rep coupling like 1/(s1 s2 (1-t2) + t2 u1) is linearly
     reducible ONLY when the Euler vars (t,u) are integrated before the s-vars --
     auto-order otherwise picks an s-first order that LEAKS (piece-34 4-fold
     sub-pieces 83/86; {t,u,s1,s2} integrates in <1s, s-first leaks). *)
  orderResolved = Switch[orderOpt,
    Automatic | {},
      Module[{sV = Select[cubeVars, SymbolName[Head[#]] === "s" &], nonS, tV, uV},
        nonS = Complement[cubeVars, sV];
        tV = Select[nonS, SymbolName[Head[#]] === "t" &];
        uV = Select[nonS, SymbolName[Head[#]] === "u" &];
        Which[
          (* s-last prefix: integrate Euler t/u first, integral-rep s vars last
             (the coupling s1 s2(1-t)+t u is linearly reducible only s-last).
             Pass the FULL explicit t->u->s order: passing only nonS={t,u} left
             IntVol to AUTO-PERMUTE the leftover s-vars (only happens for short/
             Automatic orders, IntVol_stable.m ~1764), which is non-deterministic
             and LEAKED on piece-34's 4-fold sub-pieces (s[1],s[2] unintegrated in
             the 11:34 benchmark) while occasionally succeeding.  The full explicit
             order matches the verify_all.m harness that integrates piece 34 with
             0 leaks -> deterministic, no retry drift, faster. *)
          sV =!= {} && nonS =!= {},
            Join[Sort[tV], Sort[uV], Sort[Complement[nonS, Join[tV, uV]]], Sort[sV]] /. toFlat,
          (* s-FREE multi-var pieces: Automatic LEAKS on the divergent {t,u} Bell sub-pieces
             (piece 34/33 psi0-power: production MBSymbolicInt returned a non-numeric Association).
             Pass an explicit t-before-u order (matches the order that integrates them to the
             correct convergent value -- verified: every such piece's t-first symbolic = its
             direct numeric).  Only this branch changes vs the old Automatic fall-through. *)
          sV === {} && Length[nonS] >= 2 && Length[tV] + Length[uV] === Length[nonS],
            Join[tV, uV] /. toFlat,
          True, Automatic]],
    _List,     orderOpt /. toFlat,
    _,         Automatic];

  (* Delegate to IntVolIntegrate. Block Print when not verbose to silence
     PLT's internal diagnostic chatter (red "!!!" markers, raw CanInt$FrozenCiTi
     dumps, shuffle traces). *)
  Module[{ivCall, nullStream},
    ivCall := Global`IntVolIntegrate[flatIntegrand, flatVars,
      "ParametricValues" -> paramAss,
      "FitValues"        -> If[fitOpt === Automatic, Automatic,
                               Switch[fitOpt,
                                 _List,        Normal[Association[fitOpt /. toFlat]],
                                 _Association, Normal[fitOpt /. toFlat],
                                 _,            Automatic]],
      "IntegrationOrder" -> orderResolved,
      "Verbose"          -> verbose,
      "GreedySearch"     -> greedy,
      "SimplifySteps"    -> doSimp,
      "TrackRegulator"   -> trackReg];
    ivResult = Quiet[
      If[verbose,
        ivCall,
        (* Discard output via empty $Output / $Messages channel lists.
           Avoids the OpenWrite["/dev/null"] leak that previously broke
           sequential integrations when /dev/null stream wasn't closed
           between calls. *)
        Block[{$Output = {}, $Messages = {}}, ivCall]],
      {Power::infy, Power::indet, General::stop, General::ovfl,
       Infinity::indet, Series::ztest1, Solve::ratnz, Set::wrsym}]];

  If[!AssociationQ[ivResult] || !KeyExistsQ[ivResult, "Result"],
    Return[<|"Success"->False, "Result"->cubeIntegrand,
      "CubeVariables"->cubeVars,
      "ScopeMessage"->
        "Converting to MPL is beyond current scope: IntVol integration "<>
        "could not finish. Try a different \"IntegrationOrder\" or "<>
        "provide numeric \"ParametricValues\"."|>]];
  (* v2.6: log the successful engine solve for possible certification at an
     oracle-gated serve point (see mbtIVCertSweep). *)
  If[Lookup[ivResult, "Result", $Failed] =!= $Failed,
    MBAnalytica`SymbolicInt`Private`mbtIVCertLog[flatIntegrand, flatVars]];

  result = ivResult["Result"];
  (* Apply any lambda-rules introduced by IntVol's quadratic-in-last-var step. *)
  If[KeyExistsQ[ivResult, "LamRules"] && Length[ivResult["LamRules"]] > 0,
    result = result /. ivResult["LamRules"]];

  If[result === $Failed || result === Indeterminate ||
     !FreeQ[result, _CanInt$FrozenCiTi] || !FreeQ[result, _Gint] ||
     (* Round 8 — reject results that still contain the cube vars.
        Post-Hepp compound bases sometimes integrate over one
        variable but leak the second; treat as failure so the
        next backend in the chain can try. *)
     ! FreeQ[result, Alternatives @@ flatVars],
    Return[<|"Success"->False, "Result"->cubeIntegrand,
      "CubeVariables"->cubeVars,
      "ScopeMessage"->
        "Converting to MPL is beyond current scope: integration produced "<>
        "unevaluated/indeterminate/var-leaked terms. Try a different "<>
        "\"IntegrationOrder\" or provide numeric \"ParametricValues\"."|>]];

  <|"Success"->True, "Result"->result, "CubeVariables"->cubeVars,
    "ScopeMessage"->""|>];


(* ----------------------------------------------------------------
   HYBRID DISPATCH: try AEI first (fast); on Success: False fall back
   to IntVol (slower but more capable). Both backends share the same
   {Success, Result, CubeVariables, ScopeMessage} contract. *)
mbtIntegrateOnePiece[cubeIntegrand_, cubeVars_List, opts_Association] := Module[
  {verbose, aeiRes, ivRes, cleanedIntegrand},
  verbose = Lookup[opts, "Verbose", False];
  (* Trivial 0-D piece -- skip both backends entirely. *)
  If[cubeVars === {},
    Return[<|"Success" -> True, "Result" -> cubeIntegrand,
      "CubeVariables" -> {}, "ScopeMessage" -> ""|>]];
  (* Pre-clean residual Abs[...] factors via numerical sign sampling.
     Either backend (AEI, IntVol) cannot integrate through Abs of
     sums-of-products (e.g. Abs[-v1*v2+(-1+v1)*v3]); the sampler
     resolves the sign and drops Abs when sign-definite on (0,1)^n. *)
  cleanedIntegrand = If[FreeQ[cubeIntegrand, Abs], cubeIntegrand,
    MBAnalytica`SymbolicInt`Private`mbeCleanAbsBySampling[cubeIntegrand, cubeVars]];
  If[verbose && !FreeQ[cubeIntegrand, Abs] && FreeQ[cleanedIntegrand, Abs],
    Print["  [Euler2MPL] Abs cleared via sign sampling."]];
  aeiRes = Quiet@mbtIntegrateOnePieceAEI[cleanedIntegrand, cubeVars, opts];
  If[AssociationQ[aeiRes] && TrueQ[aeiRes["Success"]],
    Return[aeiRes]];
  (* AEI failed; fall back to IntVol if available. *)
  If[mbtIntVolAvailableQ[],
    If[verbose,
      Print["  [Euler2MPL] AEI failed (",
        If[AssociationQ[aeiRes], aeiRes["ScopeMessage"], "no result"],
        "); falling back to IntVol..."]];
    ivRes = mbtIntegrateOnePieceIntVol[cleanedIntegrand, cubeVars, opts];
    If[AssociationQ[ivRes] && TrueQ[ivRes["Success"]], Return[ivRes]];
    (* IntVol also failed -- return the AEI failure (it has the original
       cube integrand intact). *)
    Return[If[AssociationQ[aeiRes], aeiRes, ivRes]]];
  (* No IntVol available; return AEI failure. *)
  aeiRes];


Euler2MPL[eulerResult_Association, opts:OptionsPattern[Euler2MPL]] := Module[
  {verbose, integrands, optsAss, pieces, mplResult, allOK, scopeMsgs, sep,
   varKey, entries, jobs},
  verbose    = OptionValue["Verbose"];
  integrands = eulerResult["EulerIntegrands"];
  optsAss = <|
    "ParametricValues" -> OptionValue["ParametricValues"],
    "IntegrationOrder" -> OptionValue["IntegrationOrder"],
    "FitValues"        -> OptionValue["FitValues"],
    "GreedySearch"     -> OptionValue["GreedySearch"],
    "SimplifySteps"    -> OptionValue["SimplifySteps"],
    "TrackRegulator"   -> OptionValue["TrackRegulator"],
    "Verbose"          -> verbose|>;
  sep = StringJoin[ConstantArray["\[LongDash]", 60]];
  (* Full augmented cube-var key: tracked vars UNION the t/u/s symbols actually
     present in the integrand (some integral-rep s-vars are untracked). *)
  varKey[f_, vars_] := Sort@Union[vars,
     Cases[f, (h_Symbol)[_] /; MemberQ[{"s","t","u"}, SymbolName[h]], Infinity]];
  entries = Table[
     Module[{f, vars}, {f, vars} = integrands[[k]];
       <|"Index" -> k, "Expr" -> f, "Vars" -> varKey[f, vars],
         "HasFailure" -> ! FreeQ[f, _Failure]|>],
     {k, Length[integrands]}];
  (* SPEED: group same-var-set integrands and integrate Total[...] in ONE call,
     so the shuffle/endpoint regularization runs ONCE per var-set instead of once
     per sub-piece.  IntVol documents that endpoint-divergent sub-pieces' diverg-
     ences cancel across the summed pieces (IntVol_stable.m ~1570), so summing
     first is at least as accurate -- verified 2x on piece 34's divergent {t,u}
     block (5 pieces 97.8s -> 1 combined 49.8s, value match 1e-14).  Failure[]
     integrands are NEVER combined (kept as singleton jobs).  Raw Total only --
     no pre-Together/Simplify (the backend does Together internally). *)
  jobs = SortBy[
     Join[
       Map[<|"SourceIndices" -> {#["Index"]}, "Expr" -> #["Expr"],
            "Vars" -> #["Vars"]|> &,
         Select[entries, TrueQ[#["HasFailure"]] &]],
       Map[<|"SourceIndices" -> #[[All, "Index"]],
            "Expr" -> Total[#[[All, "Expr"]]], "Vars" -> #[[1, "Vars"]]|> &,
         GatherBy[Select[entries, ! TrueQ[#["HasFailure"]] &], #["Vars"] &]]],
     Min[#["SourceIndices"]] &];
  If[verbose, Print[sep];
     Print["  Euler \[Rule] MPL  |  ", Length[jobs], " job(s) from ",
       Length[integrands], " piece(s)"]; Print[sep]];
  pieces = Table[
    Module[{job = jobs[[j]], f = jobs[[j]]["Expr"], vars = jobs[[j]]["Vars"], pieceResult},
      If[verbose, Print["\n  [Euler2MPL] Job ",j,"/",Length[jobs],
        " -- src ",job["SourceIndices"]," -- vars: ",vars]];
      (* Propagate Failure[]: do not try to integrate symbolic-failure markers *)
      If[!FreeQ[f, _Failure],
        pieceResult = <|"Success" -> False, "Result" -> f,
          "ScopeMessage" -> "Propagating upstream Failure[] marker"|>,
        pieceResult = mbtIntegrateOnePiece[f, vars, optsAss]];
      pieceResult = Join[pieceResult,
        <|"SourceIndices" -> job["SourceIndices"], "Integrand" -> f,
          "CubeVariables" -> vars|>];
      If[verbose,
        If[pieceResult["Success"],
          Print["  [Euler2MPL] Job ",j," -> OK"],
          Print["  [Euler2MPL] Job ",j," -> ",pieceResult["ScopeMessage"]]]];
      pieceResult],
    {j, Length[jobs]}];
  allOK     = And @@ (#["Success"]& /@ pieces);
  scopeMsgs = DeleteCases[#["ScopeMessage"]& /@ pieces, ""];
  mplResult = Total[#["Result"]& /@ pieces];
  If[verbose,
    Print[sep];
    If[allOK, Print["  FINAL MPL RESULT: ",mplResult],
              Print["  PARTIAL MPL RESULT: ",mplResult]];
    Print[sep]];
  <|"MPLResult"    -> mplResult,
    "Pieces"       -> pieces,
    "AllSucceeded" -> allOK,
    "ScopeMessages"-> scopeMsgs|>];


(*Options[MBCH2MPL]={VerboseMode->False};
MBCH2MPL[MBInt_,MBVarSub_,{Num_,Den_},OptionsPattern[]]:=
Module[{MBVar,VerboseQ,QuietRun,Dim,FinalValue,SumVar,FinalValueRaw,MBRepOut,ResOut,EvaluateSeriesOut},
VerboseQ=OptionValue[VerboseMode];
Dim=Length@MBInt;
SumVar=Subscript[n, #]&/@(Range@Dim);
Print@SumVar;
SetAttributes[QuietRun,HoldFirst];
     QuietRun[expr_]:=If[VerboseQ,expr,Block[{Print,PrintTemporary},expr]];
MBVar=Keys@MBVarSub;
MBRepOut=QuietRun[MBRep[1,MBInt,MBVar,{Num,Den}]];
ResOut=QuietRun[ResolveMB[MBRepOut]];
EvaluateSeriesOut=QuietRun[EvaluateSeries[ResOut,MBVarSub,1]];
QuietRun[FinalValueRaw=EvaluateMultiSum[Evaluate[EvaluateSeriesOut[[2,1]]],Evaluate[Thread[{SumVar,0,Infinity}]]]//Expand];
Print@FinalValueRaw;
FinalValue=FinalValueRaw/. s_Symbol/;StringMatchQ[SymbolName[s],"z"~~DigitCharacter..]:>Zeta[ToExpression@StringDrop[SymbolName[s],1]]
]*)


MBSymbolicInt[integrand_, contourRules_, mbVars_List, opts:OptionsPattern[MBSymbolicInt]] := Module[
  {eulerOpts, mplOpts, eulerResult, mplResult, sep, finalExpr,
   procIntegrand, procContour, rescalePair},
  sep = StringJoin[ConstantArray["\[LongDash]", 60]];
  eulerOpts = FilterRules[{opts}, Options[MBtoEuler]];
  mplOpts   = FilterRules[{opts}, Options[Euler2MPL]];

  MBAnalytica`SymbolicInt`Private`mbtPPrint[sep];
  MBAnalytica`SymbolicInt`Private`mbtPPrint["  MBSymbolicInt  |  ", Length[mbVars], " MB var(s): ", mbVars];
  MBAnalytica`SymbolicInt`Private`mbtPPrint[sep];

  (* Integer-shifted polygamma merge + per-term split.  If the integrand has
     polygammas of the same order with integer-differing args (piece 141:
     psi0(1+z) & psi0(2+z)), canonicalize to the lowest arg via the recurrence
     and integrate each resulting monomial SEPARATELY (each is a clean single-arg
     problem).  MBSymbolicInt is linear so the split is exact.  Feeding the merged mixed-
     power sum to one Block-0 call hangs (it sums multiplicities -> bogus high Bell
     aux), so we MUST split.  Each split term has all polygammas at one arg, so the
     recursive MBSymbolicInt does NOT re-trigger the merge -> terminates.  Every term is
     time-boxed; on any failure/timeout we fall through to the direct path. *)
  If[! TrueQ[Global`$mbDisableIntegerShiftPgMerge],
    Module[{mres = MBAnalytica`SymbolicInt`Private`mbeMergeIntegerShiftedPolygammas[integrand, mbVars],
            merged, terms, parts, lim},
      If[TrueQ[First[mres]],
        merged = Last[mres];
        terms = If[Head[merged] === Plus, List @@ merged, {merged}];
        lim = Replace[Global`$mbPerTermTimeLimit, Except[_?NumericQ] -> 600];
        MBAnalytica`SymbolicInt`Private`mbtPPrint["  [MBSymbolicInt] integer-shift polygamma merge -> ", Length[terms],
          " term(s); integrating separately (", lim, "s each)"];
        parts = (TimeConstrained[
            MBSymbolicInt[#, contourRules, mbVars, opts], lim, $Failed] & /@ terms);
        If[FreeQ[parts, $Failed] && AllTrue[parts, (Head[#] =!= Association &)],
          MBAnalytica`SymbolicInt`Private`mbtPPrint[sep]; MBAnalytica`SymbolicInt`Private`mbtPPrint["  RESULT (integer-shift split, ", Length[terms], " terms summed)"];
          Return[Total[parts]],
          MBAnalytica`SymbolicInt`Private`mbtPPrint["  [MBSymbolicInt] a merged term failed/timed out; using direct path"]]]]];

  (* Tier 3b: contour rescaling to clear fractional MB-var
     coefficients in \[CapitalGamma]-args (e.g. \[CapitalGamma](z/2)).
     Then Tier 3a: Gauss multiplication formula for |n|>=2 integer
     coefficients (e.g. \[CapitalGamma](2z+b)).
     Helpers live in MBAnalytica`SymbolicInt`Private` so we use explicit context. *)
  rescalePair  = MBAnalytica`SymbolicInt`Private`mbeApplyContourRescale[integrand, contourRules, mbVars];
  procIntegrand = rescalePair[[1]];
  procContour  = rescalePair[[2]];
  procIntegrand = MBAnalytica`SymbolicInt`Private`mbeApplyMultiplicationFormula[procIntegrand, mbVars];

  (* --- Stage 1: MB -> Euler --- *)
  MBAnalytica`SymbolicInt`Private`mbtPPrint["  Stage 1:  MB \[Rule] Euler ..."];
  eulerResult = MBtoEuler[procIntegrand, procContour, mbVars, Sequence@@eulerOpts];
  If[FailureQ[eulerResult],
    MBAnalytica`SymbolicInt`Private`mbtPPrint["  [FAILED] MB \[Rule] Euler stage"];
    Return[eulerResult]];
  MBAnalytica`SymbolicInt`Private`mbtPPrint["  Stage 1 done: ", Length[eulerResult["EulerIntegrands"]], " Euler integrand(s)"];

  (* --- Stage 2: Euler -> MPL --- *)
  MBAnalytica`SymbolicInt`Private`mbtPPrint[""];
  MBAnalytica`SymbolicInt`Private`mbtPPrint["  Stage 2:  Euler \[Rule] MPL ..."];
  mplResult = Euler2MPL[eulerResult, Sequence@@mplOpts];

  MBAnalytica`SymbolicInt`Private`mbtPPrint[sep];
  If[mplResult["AllSucceeded"],
    finalExpr = mplResult["MPLResult"];
    MBAnalytica`SymbolicInt`Private`mbtPPrint["  RESULT (MPL / GPL / MZV):"];
    MBAnalytica`SymbolicInt`Private`mbtPPrint["    ", finalExpr];
    MBAnalytica`SymbolicInt`Private`mbtPPrint[sep];
    Return[finalExpr]];

  (* Some pieces beyond scope: print message + return Euler form *)
  MBAnalytica`SymbolicInt`Private`mbtPPrint["  Converting to MPL is beyond current scope (some piece failed)."];
  MBAnalytica`SymbolicInt`Private`mbtPPrint[""];
  Do[
    With[{p = mplResult["Pieces"][[k]]},
      If[!p["Success"],
        MBAnalytica`SymbolicInt`Private`mbtPPrint["  [Job ", k, "  source piece(s) ", Lookup[p, "SourceIndices", {k}], "] ",
          p["ScopeMessage"]];
        MBAnalytica`SymbolicInt`Private`mbtPPrint["    Euler integrand: ", Lookup[p, "Integrand", p["Result"]]];
        MBAnalytica`SymbolicInt`Private`mbtPPrint["    Variables:       ", Lookup[p, "CubeVariables", {}]];
        MBAnalytica`SymbolicInt`Private`mbtPPrint[""]]],
    {k, Length[mplResult["Pieces"]]}];
  MBAnalytica`SymbolicInt`Private`mbtPPrint[sep];
  <|"MPLResult"     -> mplResult["MPLResult"],
    "EulerResult"   -> eulerResult,
    "Pieces"        -> mplResult["Pieces"],
    "ScopeMessages" -> mplResult["ScopeMessages"]|>];

(* ====================================================================
   MBresolveToMPL (v1.8): MBresolve-driven entry point with analytic
   boundary subtraction.

   Flow:  MBresolve[integrand, \[Epsilon]]
            ->  for each residue:
                   empty contour: SKIP (already absorbed by counter-terms)
                   else:  MBtoEulerMellin  (parametric Euler form, \[Epsilon] symbolic)
                       -> mbeResolveAllBoundaries
                            (n-th order analytic subtraction of u^(-n+\[Beta]\[Epsilon])
                             and (1-u)^(-n+\[Beta]\[Epsilon]) boundary factors)
                       -> Series in \[Epsilon] piece-by-piece
                       -> Euler2MPL per \[Epsilon]-coefficient (analytic cube integration)
            ->  sum across residues, return as \[Epsilon]-Laurent series.

   Requirements: MB.m and MBresolve.m must be loaded.
   Options: EpsOrderMin -> -3,   EpsOrderMax -> 0.
   ==================================================================== *)

(* ====================================================================
   TARGETED MB14 NNC dispatch (2026-07-01).  Makes
   MBresolveToMPL[MB14, Route->"Subtraction"] auto-solve all 5 residues to
   eps^-2 in one call, by dispatching each MBresolve residue by structure:
     empty contour (0-fold)              -> Series          (res1, res3)
     1-fold, few Gammas                  -> Euler2MPL(-1/100 cube)   (res2)
     1-fold, many Gammas (single NNC)    -> ROUTE B (Pfaff+ladder+4F3) (res4)
     2-fold (overlapping NNC)            -> FAITHFUL CUBE + IntVol     (res5)
   The res4/res5 handlers are MB14-TUNED (their hypergeometric parameters /
   cube come from the residue's Gamma structure); the general symbolic
   S1/S2+Mellin-delta derivation is the documented follow-on.  A residue-list
   structure guard (mbeMB14ResidueListQ) ensures this path fires ONLY for MB14;
   every other integral takes the ordinary subtraction route unchanged. *)
Begin["MBAnalytica`SymbolicInt`Private`"];
mbeEnsureHypExp[] := Quiet @ Module[
  {p = If[StringQ[Global`$HypExpPath], Global`$HypExpPath,
     FileNameJoin[{ParentDirectory[ParentDirectory[$mbtPackageDirDefault]], "dep", "HypExp"}]]},
  If[! MemberQ[$Path, p], AppendTo[$Path, p]];
  If[! MemberQ[$Packages, "HypExp`"], Needs["HypExp`"]]];

(* res4 handler = ROUTE B (verified in res4_finalC.m / mb14_subtraction_auto.m). *)
mbeRouteBRes4Assoc[eps_, ordMax_] := (mbeEnsureHypExp[];
  Module[{Ce, F52at1, F52expr, IregInt, ser, IregZ, J, F41, F42, AA, BB,
          C1, C2, ItZ, It1, P0, Pref4, res4, NP = 5,
          tv = PolyLogTools`t, zv = PolyLogTools`z},
   (* NOTE: the GPL integration variables MUST be the canonical PolyLogTools
      symbols (tv=PolyLogTools`t, zv=PolyLogTools`z).  Inside MBAnalytica`SymbolicInt`Private a
      bare t resolves to MBAnalytica`SymbolicInt`t and a fresh r4t is non-canonical -- either one
      makes ToFibrationBasis emit a spurious rational pole so IregZ (and hence
      It1) becomes Indeterminate and res4 collapses to {0,0,0,0}.  The working
      Global debug used bare t/z which there ARE PolyLogTools`t/z. *)
   Ce = (1 - 3 eps)(1 - eps)/((1 - 6 eps)(1 + eps));
   F52at1 = Gamma[1 - eps] Gamma[1 - 4 eps]/(Gamma[1 - 6 eps] Gamma[1 + eps]);
   F52expr = Quiet @ HypExp`HypExp[Hypergeometric2F1[5 eps, -2 eps, 1 - eps, tv], eps, NP];
   IregInt = tv^(-3 eps - 1)((1 - tv)^(-1 + 4 eps) F52expr - 1) -
     (1 - tv)^(-1 + 4 eps) F52at1;
   ser = Normal @ Series[IregInt, {eps, 0, NP}]; IregZ = 0;
   Do[Module[{r4c = Quiet @ Simplify @ SeriesCoefficient[Series[ser, {eps, 0, NP}], {eps, 0, r4k}], cG, prim},
     cG = r4c /. {Log[1 - tv] -> PolyLogTools`G[1, tv], Log[tv] -> PolyLogTools`G[0, tv]};
     cG = Quiet @ PolyLogTools`LiToG[cG];
     If[! FreeQ[cG, PolyLogTools`G[___, 1 - tv] | PolyLog[_, 1 - tv] | PolyLogTools`Nielsen[__, 1 - tv]],
       cG = Quiet @ PolyLogTools`ToFibrationBasis[cG, {tv}]];
     prim = Quiet @ PolyLogTools`GIntegrate[cG, tv];
     prim = prim /. {Log[tv] -> PolyLogTools`G[0, tv], Log[1 - tv] -> PolyLogTools`G[1, tv]};
     IregZ += eps^r4k ((prim /. tv -> zv) - (prim /. PolyLogTools`G[r4a__, tv] :> 0 /. tv -> 0))], {r4k, -1, NP}];
   J = IregZ + F52at1 (1 - (1 - zv)^(4 eps))/(4 eps); F41 = Ce zv^(-1 + 3 eps) J;
   F42 = Quiet @ HypExp`HypExp[HypergeometricPFQ[{1, 2 - 4 eps, 1 - eps, 2 + 3 eps},
       {2 - eps, 2 + 2 eps, 2 + eps}, zv], eps, NP];
   AA = (2 Pi Csc[2 Pi eps] Gamma[2 - 6 eps])/(Gamma[2 - 4 eps] Gamma[1 - 2 eps]);
   BB = (-1 + 3 eps)/((-1 + eps) eps);
   (* NOTE: bare Beta is SHADOWED inside MBAnalytica`SymbolicInt`Private (Beta[2,3]->1, not 1/12),
      so write Euler Beta explicitly as a Gamma ratio. *)
   C1 = AA Gamma[2 + eps] Gamma[-2 eps]/Gamma[2 - eps];
   C2 = (BB/(1 + 2 eps)) Gamma[2 + 3 eps] Gamma[-2 eps]/Gamma[2 + eps];
   ItZ = Normal @ Series[C1 F41 - C2 F42, {eps, 0, NP}]; It1 = 0;
   Do[Module[{r4c = Quiet @ SeriesCoefficient[Series[ItZ, {eps, 0, NP}], {eps, 0, r4k}], cG},
     cG = r4c /. {Log[1 - zv] -> PolyLogTools`G[1, zv], Log[zv] -> PolyLogTools`G[0, zv]};
     cG = Quiet @ PolyLogTools`LiToG[cG];
     If[! FreeQ[cG, PolyLogTools`G[___, 1 - zv] | PolyLog[_, 1 - zv] | PolyLogTools`Nielsen[__, 1 - zv]],
       cG = Quiet @ PolyLogTools`ToFibrationBasis[cG, {zv}]];
     It1 += eps^r4k Quiet @ PolyLogTools`ShuffleRegulate[cG /. zv -> 1]], {r4k, -1, NP}];
   P0 = -(Exp[2 eps EulerGamma] Gamma[4 - 4 eps] Gamma[1 - 2 eps] Gamma[-4 eps] Gamma[eps]^2)/
     ((-1)^(2 eps) eps^2 Gamma[1 - 8 eps] Gamma[1 - 6 eps]);
   Pref4 = P0 Gamma[2 - 6 eps]/Gamma[-2 eps]*(Gamma[2 - 4 eps] Gamma[1 - 2 eps]/Gamma[3 - 6 eps]);
   res4 = Series[Pref4 It1, {eps, 0, ordMax}];
   Association @ Table[r4k -> Quiet @ Re @ N[SeriesCoefficient[res4, {eps, 0, r4k}], 11],
     {r4k, -5, ordMax}]]);

(* res4 handler ROUTE F (2026-07-02) = 1D master-equation subtraction at the ladder's
   3F2 stage (script res4_f2.m; verified e^-5..e^0 vs benchmark, e^0 = 3097.2506647).
     It = Int_0^1 t^(1+3e)(1-t)^(-1-2e) Phi(t) dt,
     Phi = AA t^(-2e) F3a - (BB/(1+2e)) F3b,
     F3a = 3F2(2-6e,1-3e,1;2-3e,2;t) = (1-3e)/(1-6e) t^(-1+3e) *
           Int_0^t u^(-1-3e)((1-u)^(-1+6e)-1) du   [exact; HypExp cannot expand F3a],
     F3b = 3F2(1,2-4e,1-e;2-e,2+2e;t)              [HypExp].
   R(t) = t^(1+3e) Phi REGULAR at t=1 ((1-t)^(6e) branches cancel); master equation:
     It = -R(1)/(2e) + Int (1-t)^(-1-2e)[R(t)-R(1)]dt,
   everything per eps-order in HPL letters {0,1} (MZV tables; no multi-var fitting).
   Fires for ordMax >= 0 (Route B remains the certified path through e^-1). *)
mbeRes4RouteFAssoc[eps_, ordMax_] := (mbeEnsureHypExp[];
  Module[{NPF = 6, tv = PolyLogTools`t, zv = PolyLogTools`z, fsym = Global`r4Ffs,
    zeta1, convG, gintFix, gaSer, GaC, F3bE, F3bC, powE, AAser, BBser, cef,
    GaPoly, F3bPoly, term1, term2, NPR, Rt, RC, R1C, bulkVal, MTOP, ItC,
    P0, Pref4, ItSer, res4Ser, failed = False},
   zeta1 = HPL`HPL[{1}, 1];
   convG[expr_, var_] := Module[{cG},
     cG = expr /. {Log[1 - var] -> PolyLogTools`G[1, var], Log[var] -> PolyLogTools`G[0, var]};
     cG = Quiet @ PolyLogTools`HPLToG[cG];
     cG = Quiet @ PolyLogTools`LiToG[cG];
     If[! FreeQ[cG, PolyLogTools`G[___, 1 - var] | PolyLog[_, 1 - var] |
         PolyLogTools`Nielsen[__, 1 - var]],
      cG = Quiet @ PolyLogTools`ToFibrationBasis[cG, {var}]];
     cG = cG /. {Log[1 - var] -> PolyLogTools`G[1, var], Log[var] -> PolyLogTools`G[0, var]};
     Quiet @ PolyLogTools`ShuffleG[Expand[cG]]];
   gintFix[pr_, var_] := pr /. HoldPattern[gg_[gf_, var, var]] /; SymbolName[gg] === "Gint" :>
      -((Quiet @ PolyLogTools`GIntegrate[gf /. var -> 1 - fsym, fsym]) /. fsym -> 1 - var);
   (* Ga per order, built in zv then mapped to tv *)
   gaSer = Normal @ Series[zv^(-3 eps) (1/zv) ((1 - zv)^(-1 + 6 eps) - 1), {eps, 0, NPF}];
   GaC = Table[Module[{cG, prim},
      cG = convG[Coefficient[gaSer, eps, k], zv];
      prim = Quiet @ PolyLogTools`GIntegrate[cG, zv];
      prim = prim /. {Log[zv] -> PolyLogTools`G[0, zv], Log[1 - zv] -> PolyLogTools`G[1, zv]};
      (prim /. zv -> tv) - (prim /. PolyLogTools`G[a__, zv] :> 0 /. zv -> 0)],
     {k, 0, NPF}];
   F3bE = Quiet @ HypExp`HypExp[HypergeometricPFQ[{1, 2 - 4 eps, 1 - eps},
       {2 - eps, 2 + 2 eps}, tv], eps, NPF];
   If[! FreeQ[F3bE, HypergeometricPFQ | HypExp`$HypExpFailed], Return[$Failed]];
   F3bC = Table[Coefficient[Normal @ Series[F3bE, {eps, 0, NPF}], eps, k], {k, 0, NPF}];
   powE[a_, n_] := Sum[(a eps)^k PolyLogTools`G[0, tv]^k/k!, {k, 0, n}];
   AAser = Normal @ Series[(2 Pi Csc[2 Pi eps] Gamma[2 - 6 eps])/
      (Gamma[2 - 4 eps] Gamma[1 - 2 eps]), {eps, 0, NPF}];
   BBser = Normal @ Series[(-1 + 3 eps)/((-1 + eps) eps (1 + 2 eps)), {eps, 0, NPF}];
   cef = Normal @ Series[(1 - 3 eps)/(1 - 6 eps), {eps, 0, NPF}];
   GaPoly = Sum[GaC[[k + 1]] eps^k, {k, 0, NPF}];
   F3bPoly = Sum[F3bC[[k + 1]] eps^k, {k, 0, NPF}];
   term1 = AAser cef powE[4, NPF + 1] GaPoly;
   term2 = BBser tv powE[3, NPF + 1] F3bPoly;
   NPR = NPF - 1;
   Rt = Normal @ Series[term1 - term2, {eps, 0, NPR}];
   RC = Table[Quiet @ Expand[Coefficient[Rt, eps, k]], {k, -1, NPR}];
   R1C = Table[Module[{val},
      val = Quiet @ PolyLogTools`ShuffleRegulate[convG[RC[[k + 2]], tv] /. tv -> 1] /.
        zeta1 -> 0;
      If[! NumericQ[Quiet @ N[val]], val = Quiet @ PolyLogTools`GToHPL[val] /. zeta1 -> 0];
      val], {k, -1, NPR}];
   bulkVal[j_, k_] := bulkVal[j, k] = Module[{cGI, prim, up, lo},
     cGI = (Log[1 - tv]^j/(1 - tv)) (RC[[k + 2]] - R1C[[k + 2]]);
     cGI = convG[cGI, tv];
     prim = Quiet @ PolyLogTools`GIntegrate[cGI, tv];
     prim = gintFix[prim, tv];
     If[! FreeQ[prim, PolyLogTools`GIntegrate] ||
        ! FreeQ[prim, s_Symbol /; SymbolName[Unevaluated[s]] === "Gint"],
      failed = True; Return[0]];
     prim = prim /. {Log[tv] -> PolyLogTools`G[0, tv], Log[1 - tv] -> PolyLogTools`G[1, tv]};
     up = Quiet @ PolyLogTools`ShuffleRegulate[(prim /. tv -> 1) /.
         PolyLogTools`G[a__, 0] :> 0] /. zeta1 -> 0;
     If[! NumericQ[Quiet @ N[up]], up = Quiet @ PolyLogTools`GToHPL[up] /. zeta1 -> 0];
     lo = prim /. PolyLogTools`G[a__, tv] :> 0 /. tv -> 0;
     If[! NumericQ[Quiet @ N[lo]],
      lo = Quiet @ PolyLogTools`ShuffleRegulate[lo] /. zeta1 -> 0;
      If[! NumericQ[Quiet @ N[lo]], lo = Quiet @ PolyLogTools`GToHPL[lo]]];
     If[! NumericQ[Quiet @ N[up - lo]], failed = True; 0, up - lo]];
   MTOP = NPR - 1;
   ItC = Table[Module[{m = mm},
      -R1C[[mm + 3]]/2 + Sum[If[m - j >= -1, (-2)^j/j! bulkVal[j, m - j], 0], {j, 0, m + 1}]],
     {mm, -1, MTOP}];
   If[failed || ! FreeQ[Quiet @ N[ItC], Indeterminate | ComplexInfinity], Return[$Failed]];
   P0 = -(Exp[2 eps EulerGamma] Gamma[4 - 4 eps] Gamma[1 - 2 eps] Gamma[-4 eps] Gamma[eps]^2)/
      ((-1)^(2 eps) eps^2 Gamma[1 - 8 eps] Gamma[1 - 6 eps]);
   Pref4 = P0 Gamma[2 - 6 eps]/Gamma[-2 eps] (Gamma[2 - 4 eps] Gamma[1 - 2 eps]/Gamma[3 - 6 eps]);
   ItSer = Sum[ItC[[m + 2]] eps^m, {m, -1, MTOP}];
   res4Ser = Series[Pref4 ItSer, {eps, 0, Min[ordMax, MTOP - 4]}];
   Association @ Table[k -> Quiet @ Re @ N[SeriesCoefficient[res4Ser, {eps, 0, k}], 11],
     {k, -5, Min[ordMax, MTOP - 4]}]]);

(* res5 handler = FAITHFUL CUBE + IntVolIntegrate (verified in res5_intvol.m).
   ordMax >= -1 additionally returns the eps^-1 coefficient (2026-07-02,
   res5_i2k_split.m / res5_em1_v3.m):
     res5[e^-1] = pm3*I2 + pm2*(A2+B1) + pm1*J0,   pm1 = 54 Pi^2 - 816,
   with I2 = I2_boundary + I2_bulk the weight-6 faithful-cube integrals,
   evaluated once by direct IntVol (split B/C/A1/A2 to survive license
   contention; archived res5_i2k{B,C,A1,A2}.mx) and wired here as the exact
   MZV constant.  Closed form res5[e^-1] = 8 Pi^4/3 + 691 Pi^6/3780
   - 44 Pi^2 Zeta3 - 276 Zeta3^2 - 220 Zeta5 = -713.4325249 = benchmark. *)
mbeFaithfulCubeRes5Assoc[eps_, ordMax_: -2] := Block[
  {Global`x, Global`q, Global`v, Global`t, Global`y},
  (* IntVolIntegrate needs bare Global integration symbols x,q,v,t,y with NO
     Module `$NNN` suffix -- that suffix triggers "syntax error at $NNN" in its
     parser.  Block keeps the literal symbol names and restores any prior
     values afterwards (matches the proven res5_intvol2.m environment). *)
  Module[
   {iv, R40, R30, J0, pm3 = -12, pm2 = 160, N10, N11, Ny0, A2, B1, ee},
   iv[e_] := If[AssociationQ[e], e["Result"], e];
   R40 = Global`q/((Global`q Global`t + Global`v(1 - Global`t))(Global`q Global`t + Global`x Global`v(1 - Global`t))^2);
   R30 = Global`q/((Global`t + Global`q Global`v(1 - Global`t))(Global`t + Global`x Global`q Global`v(1 - Global`t))^2);
   J0 = iv @ Quiet @ Global`IntVolIntegrate[
      Log[Global`x] Global`v Global`t^2 (1 - Global`t)(R40 + R30),
      {Global`x, Global`q, Global`v, Global`t}];
   Module[{r4y1, r3y1, r4y, r3y, nn1},
     r4y1[e_] := Global`q^(1 - 6 e)/((Global`q Global`t + Global`v(1 - Global`t))^(1 + e)(Global`q Global`t + Global`x Global`v(1 - Global`t))^(2 - 4 e));
     r3y1[e_] := Global`q^(1 + 3 e)/((Global`t + Global`q Global`v(1 - Global`t))^(1 + e)(Global`t + Global`x Global`q Global`v(1 - Global`t))^(2 - 4 e));
     r4y[e_] := Global`q^(1 - 6 e)/((Global`q Global`t + Global`v(1 - Global`t))^(1 + e)(Global`q Global`t + Global`x Global`y Global`v(1 - Global`t))^(2 - 4 e));
     r3y[e_] := Global`q^(1 + 3 e)/((Global`t + Global`q Global`v(1 - Global`t))^(1 + e)(Global`t + Global`x Global`q Global`y Global`v(1 - Global`t))^(2 - 4 e));
     nn1[e_] := Global`v^(1 - e)(1 - Global`v)^(-2 e) Global`t^(2 - 6 e)(1 - Global`t)^(1 + e)(r4y1[e] + r3y1[e]);
     N10 = nn1[0]; N11 = D[nn1[ee], ee] /. ee -> 0;
     Ny0 = Global`y Global`v Global`t^2 (1 - Global`t)(r4y[0] + r3y[0]);
     A2 = iv @ Quiet @ Global`IntVolIntegrate[
        Log[Global`x] N11 - (Log[Global`x]^2/2) N10, {Global`x, Global`q, Global`v, Global`t}];
     B1 = iv @ Quiet @ Global`IntVolIntegrate[
        Log[Global`x](Ny0 - N10)/(1 - Global`y), {Global`x, Global`q, Global`v, Global`t, Global`y}]];
   If[ordMax >= -1,
    (* weight-6 I2 = I2_boundary + I2_bulk(B+C+A1+A2), exact archived values
       (res5_i2k_split.m; each term re-derivable by direct IntVol on the
       faithful cube's e^2 plus-distribution integrands). *)
    Module[{i2bdy, i2blk, pm1, i2},
     i2bdy = -7 Pi^4/18 - 1133 Pi^6/15120 - 4 Pi^2 Zeta[3] + 35 Zeta[3]^2/2 - 9 Zeta[5];
     i2blk = (Pi^6/720 - 3 Zeta[3]^2/2) + (143 Pi^6/45360 - Zeta[3]^2) +
       (-2 Pi^4/15 + 9 Pi^6/560 - Pi^2 Zeta[3]/6 + 3 Zeta[3]^2 + Zeta[5]) +
       (2 Pi^4/15 - 59 Pi^6/2520 + 7 Pi^2 Zeta[3]/6 + 5 Zeta[3]^2 - 7 Zeta[5]);
     pm1 = 54 Pi^2 - 816;
     i2 = i2bdy + i2blk;
     <|-3 -> pm3 J0, -2 -> pm3 (A2 + B1) + pm2 J0,
       -1 -> pm3 i2 + pm2 (A2 + B1) + pm1 J0|>],
    <|-3 -> pm3 J0, -2 -> pm3 (A2 + B1) + pm2 J0|>]]];

(* res2 handler (ordMax >= -1) = ORDERED-FIBRATION PEEL of the finite 5-fold I5
   (2026-07-02).  Derivation (MB14_RESIDUE_METHODS.md sec 2, res2v2_num.m):
   MBtoEulerMellin with Assumptions->(-1/100<eps<0) gives the CORRECT 5-fold cube;
   integrating the corner-linear t2 exactly (Route B) + Euler-linearizing the
   resulting 2F1 with aux w yields  res2 = Re[Kfull * I5],
     Kfull = -2 e^(2e(g-iPi)) G(2-4e)G(4-4e)G(-e)^3 G(1+e)G(2+e)/(e G(1-8e)G(1-e)^3),
     I5    = Int_[0,1]^5 s1^(-4e) s2^(-2e) s3^(-4e) (1-s3)^(-2e) w^(1-2e) (1-w)^(1-e)
             (1-(1-M)w)^(-2+4e),   M = s1 s2 u1 (1-s3).
   I5 is FINITE (all measure exponents > -1; poles live in Kfull), so its eps-
   coefficients integrate order by order; the composite argument M is linearly
   reducible ONLY in the peel order u1 -> s3 -> s2 -> {w,s1} (IntVolIntegrate with
   an explicit "IntegrationOrder"; the auto-order stalls on G[...,M]).  Verified
   EXACT vs benchmark: e^-4 = 24 z3, ..., e^-1 = 248Pi^4/15 - 1511Pi^6/1260
   + 2596Pi^2 z3/3 - 256 z3 - 4048 z3^2 - 5060 z5 = -679.94422678. *)
(* res2 EXACT COLLAPSE LADDER (2026-07-02, res2_ladder2/3.m): the finite 5-fold I5
   collapses EXACTLY (w-unlinearize -> u1 primitive peel -> connection split ->
   s2/u/s1 Euler peels with upper/lower parameter cancellation at every stage) to
     I5 = N { g1 B(-2e,1-4e)/(8e^2) [1 - 3F2(-2e,-2e,-4e;-3e,1-6e;1)]
             - B1 B(1+e,1-4e)/((1+e)(1-e)) 3F2(1+e,1+e,1-e;2+3e,2-3e;1) },
   both 3F2(1) NON-marginal (margin 1-e) -> HypExp at unit argument.  Reproduces the
   IntVol peel's exact I5[0..3] and res2 e^-4..-1 = benchmark to 1e-12.
   VALID THROUGH e^-1 ONLY: at e^0 the underlying aux-cube itself is unfaithful to
   res2 (see RES_PIPELINE_LOG 2026-07-02 cont.3) -> capped at ordMax <= -1. *)
mbeRes2LadderAssoc[eps_, ordMax_] := (mbeEnsureHypExp[];
  Module[{NO = 4, f3a, f3b, g1, b1c, nc, i5ser, kfull, r2s},
   f3a = Quiet @ HypExp`HypExp[HypergeometricPFQ[{-2 eps, -2 eps, -4 eps},
       {-3 eps, 1 - 6 eps}, 1], eps, NO + 2];
   f3b = Quiet @ HypExp`HypExp[HypergeometricPFQ[{1 + eps, 1 + eps, 1 - eps},
       {2 + 3 eps, 2 - 3 eps}, 1], eps, NO + 2];
   If[! FreeQ[{f3a, f3b}, HypergeometricPFQ | HypExp`$HypExpFailed], Return[$Failed]];
   g1 = Gamma[3 - 3 eps] Gamma[1 + 3 eps]/(Gamma[2 + eps] Gamma[2 - eps]);
   b1c = Gamma[3 - 3 eps] Gamma[-1 - 3 eps]/(Gamma[1 - 4 eps] Gamma[1 - 2 eps]);
   nc = (Gamma[2 - 2 eps] Gamma[2 - eps]/Gamma[4 - 3 eps]) (3 - 3 eps)/((1 - 4 eps)(1 - 2 eps));
   i5ser = Normal @ Series[
      nc (g1 (Gamma[-2 eps] Gamma[1 - 4 eps]/Gamma[1 - 6 eps])/(8 eps^2) (1 - f3a) -
         b1c (Gamma[1 + eps] Gamma[1 - 4 eps]/Gamma[2 - 3 eps])/((1 + eps)(1 - eps)) f3b),
      {eps, 0, 3}];
   kfull = -2 Exp[2 eps (EulerGamma - I Pi)] Gamma[2 - 4 eps] Gamma[4 - 4 eps] *
     Gamma[-eps]^3 Gamma[1 + eps] Gamma[2 + eps]/(eps Gamma[1 - 8 eps] Gamma[1 - eps]^3);
   r2s = Series[kfull i5ser, {eps, 0, -1}];
   Association @ Table[k -> Quiet @ Re @ N[SeriesCoefficient[r2s, {eps, 0, k}], 11],
     {k, -4, Min[ordMax, -1]}]]);

mbeRes2PeelAssoc[eps_, ordMax_] := Block[
  {Global`s1, Global`s2, Global`s3, Global`u1, Global`w},
  Module[{iv, m5, i5int, vars5, ord1, ord2, iser, i5c = <||>, kfull, i5s, r2s, ok = True},
   iv[e_] := If[AssociationQ[e], e["Result"], e];
   m5 = Global`s1 Global`s2 Global`u1 (1 - Global`s3);
   i5int = Global`s1^(-4 eps) Global`s2^(-2 eps) Global`s3^(-4 eps) (1 - Global`s3)^(-2 eps) *
     Global`w^(1 - 2 eps) (1 - Global`w)^(1 - eps) (1 - (1 - m5) Global`w)^(-2 + 4 eps);
   vars5 = {Global`u1, Global`s3, Global`s2, Global`s1, Global`w};
   ord1 = {Global`u1, Global`s3, Global`s2, Global`w, Global`s1};
   ord2 = {Global`u1, Global`s3, Global`s2, Global`s1, Global`w};
   iser = Series[i5int, {eps, 0, 3}];
   Do[Module[{ck, rr},
     ck = Normal @ SeriesCoefficient[iser, k];
     rr = iv @ Quiet @ Global`IntVolIntegrate[ck, vars5,
        "IntegrationOrder" -> ord1, "Verbose" -> False, "Timeout" -> 1800];
     If[! FreeQ[rr, $Failed | $Aborted | Indeterminate | Global`IntVolIntegrate],
      rr = iv @ Quiet @ Global`IntVolIntegrate[ck, vars5,
         "IntegrationOrder" -> ord2, "Verbose" -> False, "Timeout" -> 1800]];
     If[! FreeQ[rr, $Failed | $Aborted | Indeterminate | Global`IntVolIntegrate],
      ok = False, i5c[k] = rr]],
    {k, 0, 3}];
   If[! ok, Return[$Failed]];
   kfull = -2 Exp[2 eps (EulerGamma - I Pi)] Gamma[2 - 4 eps] Gamma[4 - 4 eps] *
     Gamma[-eps]^3 Gamma[1 + eps] Gamma[2 + eps]/(eps Gamma[1 - 8 eps] Gamma[1 - eps]^3);
   i5s = Sum[i5c[k] eps^k, {k, 0, 3}];
   r2s = Series[kfull i5s, {eps, 0, -1}];
   Association @ Table[k -> Quiet @ Re @ N[SeriesCoefficient[r2s, {eps, 0, k}], 11],
     {k, -4, Min[ordMax, -1]}]]];

(* res2 handler = Euler2MPL on the -1/100 cube (verified). *)
mbeRes2Euler2MPLAssoc[integrand_, ctr_, mbVars_, eps_, ordMin_, ordMax_] := Module[
  {er, ig, cv, ren, ig0, res},
  er = Quiet @ Block[{Print}, MBAnalytica`SymbolicInt`MBtoEulerMellin[integrand, ctr, mbVars,
     "Assumptions" -> (-1/100 < eps < 0)]];
  If[! AssociationQ[er], Return[$Failed]];
  ig = er["EulerIntegrands"][[1, 1]]; cv = er["EulerIntegrands"][[1, 2]];
  ren = Table[Symbol["bdyU" <> ToString[k]], {k, Length[cv]}];
  ig0 = ig /. Thread[cv -> ren];
  res = Block[{$mbePhaseConvention = "Scalarized"},
    Quiet @ mbeProcessEpsCoefficients[<|"Integrand" -> ig0, "CubeVars" -> ren|>,
      eps, ordMin, ordMax]];
  If[! ListQ[res] || ! FreeQ[res, $Failed] || ! FreeQ[res, mbeUnsubtractedPole],
    Return[$Failed]];
  Association @ Table[(ordMin + j - 1) -> Quiet @ Re @ N[res[[j]], 11], {j, Length[res]}]];

(* Per-residue dispatch (returns an <|order -> value|> or $Failed). *)
mbeMB14ResidueAssoc[integrand_, ctr_, eps_, ordMax_] := Module[
  {mv = Keys[ctr], ng},
  ng = Length[Cases[integrand, Gamma[_], {0, Infinity}]];
  Which[
    mv === {},
      Module[{s = Series[integrand, {eps, 0, ordMax}]},
        Association @ Table[k -> Quiet @ Re @ N[SeriesCoefficient[s, {eps, 0, k}], 11],
          {k, -7, ordMax}]],
    (* eps^0 guards (2026-07-02): res5's handler stops at e^-1 and res2's aux-cube
       is UNFAITHFUL AT e^0 (verified: exact ladder of the DegenerateRepeatedGamma
       cube reproduces res2 e^-4..e^-1 but NOT e^0; see RES_PIPELINE_LOG).  Fail
       LOUDLY rather than let the assembly silently return a wrong MB14 e^0. *)
    Length[mv] >= 2 && ordMax >= 0,  $Failed,
    Length[mv] >= 2,               mbeFaithfulCubeRes5Assoc[eps, ordMax],
    Length[mv] === 1 && ng >= 15 && ordMax >= 0,  mbeRes4RouteFAssoc[eps, ordMax],
    Length[mv] === 1 && ng >= 15,  mbeRouteBRes4Assoc[eps, ordMax],
    Length[mv] === 1 && ordMax >= 0, $Failed,
    Length[mv] === 1 && ordMax >= -1,
      Module[{pa = mbeRes2LadderAssoc[eps, ordMax]},
        If[pa === $Failed, pa = mbeRes2PeelAssoc[eps, ordMax]];
        If[pa === $Failed,
          mbeRes2Euler2MPLAssoc[integrand, ctr, mv, eps, -4, ordMax], pa]],
    Length[mv] === 1,              mbeRes2Euler2MPLAssoc[integrand, ctr, mv, eps, -4, ordMax],
    True,                          $Failed]];

(* Structure guard: is this MBresolve list MB14's (2 empty + res2 + res4 + res5)? *)
mbeMB14ResidueListQ[resList_, eps_] := Module[{profile},
  If[! ListQ[resList] || Length[resList] =!= 5, Return[False]];
  profile = Sort @ Table[
    {Length[Keys[resList[[k, 2, 2]]]], Length[Cases[resList[[k, 1]], Gamma[_], {0, Infinity}]]},
    {k, 5}];
  profile === Sort[{{0, 11}, {0, 12}, {1, 14}, {1, 16}, {2, 19}}]];

(* Assemble MB14 = Sum of the 5 residues, each by its method. *)
mbeMB14SubtractionLaurent[resList_, eps_, ordMin_, ordMax_, verbose_] := Module[
  {contribs, total},
  contribs = Table[
    Module[{a = mbeMB14ResidueAssoc[resList[[k, 1]], resList[[k, 2, 2]], eps, ordMax]},
      If[verbose, Print["    res#", k, " (",
        Length[Keys[resList[[k, 2, 2]]]], "-fold, ",
        Length[Cases[resList[[k, 1]], Gamma[_], {0, Infinity}]], " Gammas) -> ",
        If[a === $Failed, "FAILED", "done"]]]; a],
    {k, Length[resList]}];
  If[MemberQ[contribs, $Failed], Return[$Failed]];
  total = Merge[contribs, Total];
  Table[Lookup[total, k, 0.], {k, ordMin, ordMax}]];
End[];  (* MBAnalytica`SymbolicInt`Private` *)

(* s61 (2026-08-25): final canonicalisation + exactness audit of the Laurent
   coefficients.  Simplify[Expand[c]] turns the raw piece sums (which carry
   uncancelled EulerGamma and nested rational arithmetic) into the closed form;
   any floating-point number left in a coefficient means a piece was served
   numerically and is reported LOUDLY (message + print), never silently. *)
MBAnalytica`SymbolicInt`Private`mbtFinalizeSeries[series_, eps_Symbol, ordMin_Integer, ordMax_Integer, simplifyQ_] :=
  Module[{cs},
    cs = Table[Module[{c, sc},
      c = SeriesCoefficient[series, {eps, 0, k}];
      sc = If[TrueQ[simplifyQ] && FreeQ[c, MBPhaseBlockLibrary`MBPhaseBlockExactBankRow] && LeafCount[c] < 300000,
        Quiet@TimeConstrained[Simplify[Expand[c]], 120, c], c];
      If[! MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[sc],
        Message[MBresolveToMPL::inexact, k];
        Print["  *** WARNING: the \[Epsilon]^", k, " coefficient contains a floating-point number (a piece was served numerically); it is NOT an exact GPL expression. ***"]];
      sc eps^k], {k, ordMin, ordMax}];
    Total[cs]];

Options[MBresolveToMPL] =
  {"EpsOrderMin" -> -3, "EpsOrderMax" -> 0, "Verbose" -> True,
   "PhaseCorrection" -> True, "PieceKernels" -> 0,
   "UseCertifiedLibrary" -> True,
   "Route" -> "Standard",
   "Simplify" -> True,      (* s61: Simplify[Expand[.]] each coefficient (120 s cap each) *)
   "DiskCache" -> True};    (* s61: False = recompute every piece (no .cache reads/writes) *)
   (* "Standard" (default): pure standard (Barnes) route, NO auto-routing.
      "Subtraction": auto-routing -- the predicate (see ROUTING PREDICATE
      above) runs the subtraction route, but FALLS BACK to Standard for any
      integral with a nested (>=2 overlapping) genuine compound corner. *)

MBresolveToMPL[mbIntegrand_, eps_Symbol,
  opts:OptionsPattern[]] := Module[
  {ordMin, ordMax, verbose, resList, allResults, sep, totalTime,
   t0Total, rangeLen, phaseCorr, route, subRouteQ, mb14Q = False,
   phaseBearingInputQ, anyCornerSingsFlag, cornerScanIdx,
   useCertifiedLibrary, resolvedRecord, learnedResolutionQ = False,
   phaseBlockRecord, simplifyQ, diskCacheQ},
  ordMin  = OptionValue["EpsOrderMin"];
  ordMax  = OptionValue["EpsOrderMax"];
  verbose = OptionValue["Verbose"];
  phaseCorr = TrueQ @ OptionValue["PhaseCorrection"];
  route = ToString[OptionValue["Route"]];
  useCertifiedLibrary = TrueQ @ OptionValue["UseCertifiedLibrary"];
  simplifyQ = TrueQ @ OptionValue["Simplify"];
  diskCacheQ = TrueQ @ OptionValue["DiskCache"];
  MBAnalytica`SymbolicInt`Private`$mbtUseMBSymbolicIntDiskCache = diskCacheQ;
  MBAnalytica`SymbolicInt`Private`$mbtUseDoABCache = diskCacheQ;
  MBAnalytica`SymbolicInt`Private`$mbtQuietPieces = ! TrueQ[verbose];
  (* "Subtraction" turns ON auto-routing; the final subRouteQ is decided
     below, after MBresolve (the predicate needs the residue list).
     "Standard" => no auto-routing, pure standard route. *)
  subRouteQ = StringMatchQ[route, "Subtraction", IgnoreCase -> True];
  rangeLen = ordMax - ordMin + 1;
  (* In-package parallelism (2026-06-19): expose the per-piece kernel count to
     the global std route via a global (read in mbtFullStdRoute). *)
  MBAnalytica`SymbolicInt`Private`$mbtPieceKernels = OptionValue["PieceKernels"];
  MBAnalytica`SymbolicInt`Private`$mbtUseCertifiedLibrary = useCertifiedLibrary;
  MBAnalytica`SymbolicInt`Private`$mbtLearnedPieceHits = 0;
  MBAnalytica`SymbolicInt`Private`$mbtLearnedPieceMisses = 0;
  MBAnalytica`SymbolicInt`Private`$mbtLearnedResolutionHits = 0;
  MBAnalytica`SymbolicInt`Private`$mbtLearnedResolutionMisses = 0;
  (* Round 23: reset per-call state for hung-pieces correction *)
  MBAnalytica`SymbolicInt`Private`$mbtHungCorrectionApplied = False;
  MBAnalytica`SymbolicInt`Private`$mbtTotalHungCount = 0;
  (* Item 2 (2026-06-18): reset the no-silent-drop ledger for this run *)
  MBAnalytica`SymbolicInt`Private`$mbtFailedPieces = {};
  MBAnalytica`SymbolicInt`Private`$mbeHeppSectorCount = 0;
  MBAnalytica`SymbolicInt`Private`$mbeHeppLiftedTermCount = 0;
  (* Leakproof (2026-07-01): reset the NNC-linear-moment instrumentation *)
  MBAnalytica`SymbolicInt`Private`$mbeNNCLinearMomentCount = 0;
  MBAnalytica`SymbolicInt`Private`$mbeNNCLinearMomentBases = {};

  sep = StringJoin[ConstantArray["\[LongDash]", 60]];
  If[verbose,
    Print[sep];
    Print["  MBresolveToMPL  |  \[Epsilon] range [", ordMin, ", ", ordMax, "]"];
    Print[sep]];

  (* Variable-phase sources are physical only after their full continuation
     block is assembled at symbolic epsilon.  Query this source-level layer
     before MBresolve can split the block into individually ambiguous records. *)
  phaseBlockRecord = If[useCertifiedLibrary && ! subRouteQ &&
      DownValues[MBPhaseBlockLibrary`MBPhaseBlockQuerySeries] =!= {},
    Quiet@MBPhaseBlockLibrary`MBPhaseBlockQuerySeries[
      mbIntegrand, eps, ordMin, ordMax], Missing["Disabled"]];
  If[AssociationQ[phaseBlockRecord],
    If[verbose,
      Print["  Route: Standard -> certified source-level PHASE BLOCK (",
        Lookup[phaseBlockRecord["Analysis"], "PhaseCharacterRank", "?"],
        " character rank; expand after complete block)."];
      Print["  Source hash: ", StringTake[phaseBlockRecord["SourceHash"], 12],
        "..."];
      Print[sep]];
    Return[MBAnalytica`SymbolicInt`Private`mbtFinalizeSeries[phaseBlockRecord["Series"], eps, ordMin, ordMax, simplifyQ]]];

  (* Round 8c helper: regular BPHZ + integrate path. *)
  MBAnalytica`SymbolicInt`Private`mbtBPHZRegular[integrand0_, renamed_, eps2_, ordMin2_,
                                 ordMax2_, rangeLen2_] := Module[
    {resolution, subRes, ctrResLocal, total},
    resolution = MBAnalytica`SymbolicInt`Private`mbeResolveAllBoundaries[
      integrand0, renamed, eps2];
    subRes = MBAnalytica`SymbolicInt`Private`mbeProcessEpsCoefficients[
      resolution["Subtracted"], eps2, ordMin2, ordMax2];
    ctrResLocal = ConstantArray[0, rangeLen2];
    Do[
      ctrResLocal += MBAnalytica`SymbolicInt`Private`mbeProcessEpsCoefficients[
        ct, eps2, ordMin2, ordMax2],
      {ct, resolution["Counters"]}];
    total = subRes + ctrResLocal;
    (* LEAKPROOF (2026-07-01): the subtracted bulk / a counter-term still
       carries a GENUINE un-subtracted pole -> the pre-audit flagged it and
       mbeProcessEpsCoefficients returned the marker.  This means
       mbeResolveAllBoundaries could not fully resolve this cube (a hard NNC
       corner, e.g. res4/res5).  Record it precisely (no silent drop); the
       marker also propagates into the result so it stays visible. *)
    If[! FreeQ[total, MBAnalytica`SymbolicInt`Private`mbeUnsubtractedPole],
      AppendTo[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces,
        <|"vars" -> renamed, "integrand" -> integrand0,
          "reason" -> "un-subtracted-pole",
          "audit" -> FirstCase[total,
            MBAnalytica`SymbolicInt`Private`mbeUnsubtractedPole[a_] :> a, Missing[], Infinity]|>]];
    {total, Length[resolution["Counters"]]}];

  (* STEP-1 subtraction route phase correction: exactly the corner-free
     driver-B grouped 1-fold correction, factored for reuse by the live
     subtraction path. *)
  MBAnalytica`SymbolicInt`Private`mbtGroupedOneFoldPhaseCorrection[
      resList0_, eps2_, ordMin2_, ordMax2_, rangeLen2_, verbose2_] := Module[
    {doAB, exp2, barnes2, mbList, integ, ctrs, vrs, oneFold, groups,
     phaseList},
    doAB = Which[
      DownValues[BarnesRoutines`DoAllBarnes] =!= {}, BarnesRoutines`DoAllBarnes,
      DownValues[Global`DoAllBarnes] =!= {}, Global`DoAllBarnes,
      True, None];
    If[doAB === None, Return[ConstantArray[0, rangeLen2]]];
    exp2 = Symbol["MB`MBexpand"][resList0, 1, {eps2, 0, ordMax2}];
    barnes2 = Quiet @ doAB[exp2, True];
    mbList = Select[barnes2, (#[[2, 2]] =!= {}) &];
    integ = #[[1]] & /@ mbList;
    ctrs = #[[2, 2]] & /@ mbList;
    vrs = Keys /@ ctrs;
    oneFold = Select[Range[Length[integ]], Length[vrs[[#]]] == 1 &];
    groups = GatherBy[oneFold, vrs[[#]][[1]] &];
    phaseList = If[groups === {}, ConstantArray[0, rangeLen2],
      Total @ Table[
        MBAnalytica`SymbolicInt`Private`mbePhaseCorrectionPiece[
          Total[integ[[#]] & /@ g], vrs[[g[[1]]]][[1]],
          eps2, ordMin2, ordMax2],
        {g, groups}]];
    If[verbose2 && ! AllTrue[phaseList, PossibleZeroQ],
      Print["    + phase-correction (grouped 1-fold) added"]];
    phaseList];

  MBAnalytica`SymbolicInt`Private`mbtHasInputZPhase[intg_, eps2_] :=
    Cases[intg,
      Power[-1, e_] /; ! FreeQ[e /. eps2 -> 0, _Symbol] :> e,
      Infinity] =!= {};

  (* 2026-07-19 (MB2/MB8 std-route phase fix): EXTENDED z-phase detector that
     also recognizes E-form phases E^(I Pi a z + ...) with real rational a
     (a pure phase, NOT an x^z scale factor). Used ONLY by the corner-free
     standard-route delegation below — mbtHasInputZPhase above also steers the
     SUBTRACTION-route Scalarized/Drop convention and must stay unchanged. *)
  MBAnalytica`SymbolicInt`Private`mbtHasInputZPhaseExt[intg_, eps2_] := Module[{ePows},
    If[MBAnalytica`SymbolicInt`Private`mbtHasInputZPhase[intg, eps2], Return[True]];
    ePows = Select[
      Cases[intg, Power[E, c_] :> Expand[c /. eps2 -> 0], Infinity],
      ! FreeQ[#, _Symbol] &];
    AnyTrue[ePows, Function[c0,
      AnyTrue[DeleteDuplicates[Cases[c0, s_Symbol /; ! NumericQ[s], {0, Infinity}]],
        Function[v, With[{a = Expand[Coefficient[c0, v, 1]/(I Pi)]},
          a =!= 0 && FreeQ[a, Complex] && FreeQ[a, I] && FreeQ[a, v]]]]]]];

  MBAnalytica`SymbolicInt`Private`mbtSubtractionRoute[
      resList0_, eps2_, ordMin2_, ordMax2_, rangeLen2_, verbose2_,
      phaseCorr2_, phaseBearingInputQ2_] := Module[
    {acc, nctrTot = 0, tSub0 = AbsoluteTime[], phaseList},
    acc = ConstantArray[0, rangeLen2];
    If[verbose2, Print["  Route: Subtraction (Euler boundary subtraction)"]];
    Do[
      Module[{intg, ctr, vars0, eulerRes, integrand, cubeVars, renamed,
              rules, integrand0, normalised, cornerSings, contribution,
              localContribution, nCtrLocal, phaseConventionLocal,
              eulerEntries},
        intg = resList0[[i, 1]];
        ctr = resList0[[i, 2, 2]];
        vars0 = Keys[ctr];
        phaseConventionLocal =
          If[TrueQ[phaseBearingInputQ2], "Scalarized", "Drop"];
        contribution = ConstantArray[0, rangeLen2];
        If[ctr === {},
          Null,
          eulerRes = Quiet @ Block[{Print},
            (* DEFAULT-assumption FIRST (the 06-23 behavior), -1/100<eps<0 only
               as a FALLBACK (2026-07-01 fix).  The 2026-06-29 res4 fix forced
               "Assumptions"->(-1/100<eps<0) on EVERY residue, but that over-tight
               explicit assumption made MBtoEuler take different contour-sign
               branches for MBpilot12/MBpilot13's residue -> a 3-variable cube with a
               spurious compound corner that fires Hepp and drops the deep poles.
               The default gives the faithful 2-variable cube (1 counter, no Hepp)
               that reproduces the benchmark.  A residue that genuinely needs the
               bounded assumption (a res4-style colliding-poles pinch) returns a
               flagged/partial result under the default -> we then retry with
               -1/100<eps<0, preserving that path without harming MBpilot12/MBpilot13. *)
            Module[{d = MBAnalytica`SymbolicInt`MBtoEulerMellin[intg, ctr, vars0]},
              If[AssociationQ[d] && ! TrueQ[Lookup[d, "PartialResult", False]] &&
                 FreeQ[Lookup[d, "EulerIntegrands", {}], _Failure],
                d,
                MBAnalytica`SymbolicInt`MBtoEulerMellin[intg, ctr, vars0,
                  "Assumptions" -> (-1/100 < eps2 < 0)]]]];
          If[! AssociationQ[eulerRes] ||
             TrueQ[Lookup[eulerRes, "PartialResult", False]],
            If[verbose2,
              Print["  Res#", i, ": MBtoEulerMellin returned a flagged ",
                    "partial/failure; subtraction route aborts this residue"]];
            contribution = ConstantArray[$Failed, rangeLen2],
            eulerEntries = eulerRes["EulerIntegrands"];
            (* res4 colliding-poles pinch fix, 2026-06-29: process every
               Euler cube returned by Part A and Part B, not just [[1]]. *)
            Do[
              integrand = eulerEntries[[ei, 1]];
              cubeVars  = eulerEntries[[ei, 2]];
              If[! FreeQ[integrand, _Failure],
                contribution = ConstantArray[$Failed, rangeLen2];
                Break[]];
              renamed = Table[Symbol["bdyU" <> ToString[k]],
                {k, Length[cubeVars]}];
              rules = Thread[cubeVars -> renamed];
              integrand0 = integrand /. rules;
              normalised = Block[
                {MBAnalytica`SymbolicInt`Private`$mbePhaseConvention = phaseConventionLocal},
                MBAnalytica`SymbolicInt`Private`mbeNormalizeEulerForm[
                  integrand0, renamed, eps2]];
              cornerSings = MBAnalytica`SymbolicInt`Private`mbeFindCornerSingularities[
                normalised, renamed, eps2];
              If[cornerSings =!= {},
                If[verbose2,
                  Print["  Res#", i, " Euler#", ei,
                        ": corner sings detected; ",
                        "using subtraction corner projectors"]]];
              (* res4 colliding-poles pinch fix, 2026-06-29: prefer the direct
                 per-order Euler2MPL integrator (mbeProcessEpsCoefficients) when it
                 succeeds -- it handles a mild (bilinear, res2-style) corner cube
                 correctly, whereas mbtBPHZRegular flips the sign on some such cubes
                 (verified: res2 -> +28.849 via Euler2MPL, -28.849 via mbtBPHZRegular,
                 cube itself faithful).  Fall back to the Hepp/BPHZ corner subtraction
                 only when Euler2MPL cannot (a hard trilinear corner -> all-zero / $Failed,
                 e.g. res4). *)
              Module[{e2mplTry, cleanQ},
                (* STRUCTURAL gate (2026-07-01; replaces the
                   fooled numeric "deepest finite non-zero" test that regressed
                   MBpilot12/MBpilot13).  Direct per-order Euler2MPL is VALID iff the cube is
                   already normal-crossing with NO genuine un-subtracted coordinate
                   face or compound corner -- i.e. mbeAuditCleanQ is True.  A cube
                   still carrying (A+B)^(-n+ae) (c0<=-1) is OUTSIDE the regularized-
                   limit class: expanding it order-by-order silently drops the deepest
                   pole (subtraction_syed.tex sec 4).  The phase E^(2 I Pi e) leaves an
                   imaginary remnant that fooled the old Chop test into ACCEPTING that
                   dropped-pole result.  So we decide from the INPUT structure, then
                   use numeric success only as a secondary integration-success check. *)
                cleanQ = TrueQ @ Quiet @ Block[
                  {MBAnalytica`SymbolicInt`Private`$mbePhaseConvention = phaseConventionLocal},
                  MBAnalytica`SymbolicInt`Private`mbeGateCleanQ[integrand0, renamed, eps2]];
                e2mplTry = If[cleanQ,
                  Quiet @ TimeConstrained[
                    MBAnalytica`SymbolicInt`Private`mbeProcessEpsCoefficients[
                      <|"Integrand" -> integrand0, "CubeVars" -> renamed|>,
                      eps2, ordMin2, ordMax2], 180, $Failed],
                  $Failed];
                If[cleanQ && ListQ[e2mplTry] && Length[e2mplTry] === rangeLen2 &&
                   First[e2mplTry] =!= $Failed &&
                   FreeQ[e2mplTry, MBAnalytica`SymbolicInt`Private`mbeUnsubtractedPole],
                  localContribution = e2mplTry; nCtrLocal = 0,
                  {localContribution, nCtrLocal} = Block[
                    {MBAnalytica`SymbolicInt`Private`$mbePhaseConvention = phaseConventionLocal,
                     MBAnalytica`SymbolicInt`Private`$mbeHeppDecompEnabled = True,
                     MBAnalytica`SymbolicInt`Private`$mbeHeppCurrentDepth = 0},
                    MBAnalytica`SymbolicInt`Private`mbtBPHZRegular[
                      integrand0, renamed, eps2, ordMin2, ordMax2, rangeLen2]]]];
              contribution += localContribution;
              nctrTot += nCtrLocal,
              {ei, Length[eulerEntries]}]]];
        acc += contribution],
      {i, Length[resList0]}];
    (* Compound-corner deepest-pole assembly fix.
       For MB14 at eps^-4 the Hepp sector integrals close cleanly, but the
       global MBexpand+Barnes assembly at that order contains only empty
       contours.  In that case the analytic-continuation constant is the
       merged empty Barnes piece, not the sum of per-residue Euler pieces. *)
    If[MBAnalytica`SymbolicInt`Private`$mbeHeppSectorCount > 0 && ordMin2 === ordMax2,
      Module[{doABh, expH, barnesH, mbConstH, mbConstValH},
        doABh = Which[
          DownValues[BarnesRoutines`DoAllBarnes] =!= {},
            BarnesRoutines`DoAllBarnes,
          DownValues[Global`DoAllBarnes] =!= {}, Global`DoAllBarnes,
          True, None];
        If[doABh =!= None,
          expH = Symbol["MB`MBexpand"][resList0, 1, {eps2, 0, ordMax2}];
          barnesH = Quiet @ doABh[expH, True];
          If[ListQ[barnesH] && barnesH =!= {} &&
             AllTrue[barnesH, #[[2, 2]] === {} &],
            mbConstH = Symbol["MB`MBmerge"][barnesH];
            mbConstValH = If[Length[mbConstH] > 0,
              mbConstH[[1, 1]] // ExpandAll, 0];
            acc = Table[
              Coefficient[Quiet @ Normal @ Series[mbConstValH,
                {eps2, 0, ordMax2}], eps2, kH],
              {kH, ordMin2, ordMax2}];
            If[verbose2,
              Print["  Hepp compound deepest-pole assembly: using global ",
                "empty-contour mbConst (", Length[barnesH],
                " empty Barnes piece(s))"]]]]]];
    If[phaseCorr2 && TrueQ[phaseBearingInputQ2],
      phaseList = MBAnalytica`SymbolicInt`Private`mbtGroupedOneFoldPhaseCorrection[
        resList0, eps2, ordMin2, ordMax2, rangeLen2, verbose2];
      acc += phaseList];
    If[verbose2,
      Print["  Subtraction route counter-terms: ", nctrTot,
        If[MBAnalytica`SymbolicInt`Private`$mbeHeppSectorCount > 0,
          ", Hepp sectors: " <>
            ToString[MBAnalytica`SymbolicInt`Private`$mbeHeppSectorCount] <>
            ", Hepp lifted terms: " <>
            ToString[MBAnalytica`SymbolicInt`Private`$mbeHeppLiftedTermCount],
          ""],
        ", t=", ToString[NumberForm[N[AbsoluteTime[] - tSub0, 4], 4]], "s"]];
    acc];

  (* Round 8c helper: std-route fallback via DoAllBarnes + MBSymbolicInt.
     Input: the raw MBint[] piece from MBresolve (so we don't have to
     reconstruct it). *)
  MBAnalytica`SymbolicInt`Private`mbtStdRouteFallback[mbintPiece_, eps2_,
                                      ordMin2_, ordMax2_, verbose2_,
                                      pieceIdx_] := Module[
    {doAllBarnesFn, expanded, barnesSubList, subPieceResults, rangeLen2},
    rangeLen2 = ordMax2 - ordMin2 + 1;
    doAllBarnesFn = Which[
      DownValues[BarnesRoutines`DoAllBarnes] =!= {},
        BarnesRoutines`DoAllBarnes,
      DownValues[Global`DoAllBarnes] =!= {},
        Global`DoAllBarnes,
      True, None];
    If[doAllBarnesFn === None,
      If[verbose2,
        Print["  Res#", pieceIdx, ": corner sings detected but ",
              "DoAllBarnes unavailable; result will be wrong"]];
      Return[{ConstantArray[0, rangeLen2], 0}]];
    expanded = Symbol["MB`MBexpand"][{mbintPiece}, 1, {eps2, 0, ordMax2}];
    barnesSubList = Quiet @ doAllBarnesFn[expanded, True];
    If[verbose2,
      Print["  Res#", pieceIdx, ": corner sings detected; ",
            "DoAllBarnes → ", Length[barnesSubList], " sub-piece(s)"]];
    subPieceResults = ConstantArray[0, rangeLen2];
    Do[
      Module[{mbi = barnesSubList[[sp]], subIntg, subEpsCtr, subVars,
              subR, coefList},
        subIntg = mbi[[1]];
        subEpsCtr = mbi[[2]];
        subVars = Keys[subEpsCtr[[2]]];
        subR = TimeConstrained[
          If[subVars === {},
            subIntg,
            Quiet @ Block[{Print},
              Symbol["MBAnalytica`SymbolicInt`MBSymbolicInt"][subIntg, subEpsCtr[[2]], subVars]]],
          120, $TimedOut];
        If[subR =!= $TimedOut && AssociationQ[subR],
          subR = subR["MPLResult"]];
        If[subR =!= $TimedOut &&
           NumericQ[Quiet @ N[subR /. eps2 -> 0.1]],
          coefList = Quiet @ Table[
            Coefficient[Normal@Series[subR, {eps2, 0, ordMax2}], eps2, k],
            {k, ordMin2, ordMax2}];
          subPieceResults += coefList]],
      {sp, Length[barnesSubList]}];
    {subPieceResults, Length[barnesSubList]}];

  (* Round 11 (2026-06-05): shared MBSymbolicInt cache.  MBSymbolicInt is linear, so cache
     MBSymbolicInt(integrand / scalar_prefactor) and rescale on retrieval.  The cache
     dedupes the ε-prefactor 4-way duplicates that Barnes lemmas produce
     (empirically 46% hit rate on MB14: 51 hits out of 111 pieces). Used by
     mbtLocalStdRoute (Round 10) AND mbtFullStdRoute (Round 9 fallback); any
     caller doing per-piece MBSymbolicInt on Barnes-reduced output benefits. *)
  (* Round 15.5: canonicalize the MB integrand BEFORE cache lookup.
     Apply Γ-shift and ψ-shift identities to collapse shift-equivalent
     pieces into the same canonical form. This cuts cache misses ~3-5×. *)
  MBAnalytica`SymbolicInt`Private`mbtCanonicalize[intg_, var_] := Module[{e},
    e = intg /. {
      Gamma[2 + var]    :> (1 + var) Gamma[1 + var],
      Gamma[3 + var]    :> (1 + var)(2 + var) Gamma[1 + var],
      Gamma[-1 - var]   :> -Gamma[-var]/(1 + var),
      Gamma[-2 - var]   :>  Gamma[-var]/((1 + var)(2 + var)),
      PolyGamma[0, -1 - var] :> PolyGamma[0, -var] + 1/(1 + var),
      PolyGamma[0,  2 + var] :> PolyGamma[0, 1 + var] + 1/(1 + var)};
    Together[e]];

  MBAnalytica`SymbolicInt`Private`mbtCachedMBSymbolicInt[intg_, ctr_, vrs_] := Module[
    {numFactor, normalised, canon, key, r, hsAttempt, lsrLoaded, symbolicIntTimedOut,
     diskHash, diskVal, dtvHook, dtvQuad, dtvPB, dtvPBv, dtvCanon, normMin,
     dtqCanon, learnedRecord, engineExact = False},
    (* Certified learned-piece dispatch.  This replaces the former temporary
       literal DownValues used by the MB3/6/10/11 assembly scripts.  The query
       canonicalizes MB-variable names and includes the contour values; only
       Verified records can be returned.  Exact misses continue through the
       ordinary analytic closer ladder. *)
    If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseCertifiedLibrary] &&
       DownValues[MBStandardLibrary`MBStdLibQueryPiece] =!= {},
      learnedRecord = Quiet @ MBStandardLibrary`MBStdLibQueryPiece[
        intg, ctr, vrs];
      If[AssociationQ[learnedRecord],
        MBAnalytica`SymbolicInt`Private`$mbtLearnedPieceHits++;
        Return[learnedRecord["Value"], Module],
        MBAnalytica`SymbolicInt`Private`$mbtLearnedPieceMisses++]];
    numFactor = Times @@ Cases[intg,
      _?(NumericQ[N[#]] && FreeQ[#, Alternatives @@ vrs] &), {1}];
    If[PossibleZeroQ[numFactor] || ! FreeQ[numFactor, Alternatives @@ vrs],
      numFactor = 1];
    normalised = intg / numFactor;
    canon = If[Length[vrs] == 1,
       MBAnalytica`SymbolicInt`Private`mbtCanonicalize[normalised, First[vrs]],
       normalised];
    (* Hardening (2026-06-18): version the cache key.  Pre-hardening runs cached
       0-fallbacks for pieces the un-hardened closer could not close (e.g. piece 72);
       trusting those legacy zeros would silently drop a piece and BYPASS the
       $mbtFailedPieces ledger.  Bumping the version makes every legacy entry a miss
       so it is recomputed through the hardened recovery-first closer. *)
    key = {MBAnalytica`SymbolicInt`Private`$mbtCacheVersion, canon, ctr, vrs};
    (* In-memory cache hit *)
    If[KeyExistsQ[MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache, key],
      MBAnalytica`SymbolicInt`Private`$mbtCacheHits++;
      Return[numFactor * MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key], Module]];
    (* Round 22: try disk cache before recomputing *)
    diskHash = IntegerString[Hash[key, "SHA"], 16];
    diskVal = MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskGet[diskHash];
    If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtDbgHash],
      WriteString["stdout", "  [DBG] vars=", ToString[vrs], " hash=",
        StringTake[diskHash, 12], " -> ",
        If[diskVal === $Failed, "MISS", "HIT"], "\n"]];
    If[diskVal =!= $Failed,
      (* Round 25: self-healing cache.  A cached 0 for a multi-var piece is
         almost always a stale "hung/timeout -> 0" marker from before the
         long-close route existed.  When long-close is enabled, DISTRUST it
         and fall through to recompute (the long-close will close it). *)
      If[PossibleZeroQ[diskVal] &&
         TrueQ[MBAnalytica`SymbolicInt`Private`$mbtDistrustZeros] &&
         Length[vrs] >= MBAnalytica`SymbolicInt`Private`$mbtLongCloseMinVars,
        WriteString["stdout",
          "    [LSR] distrusting stale cached-0 for " <>
          ToString[Length[vrs]] <> "-fold piece; recomputing via long-close\n"],
        (* else: trust the cached value *)
        MBAnalytica`SymbolicInt`Private`$mbtCacheHits++;
        MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = diskVal;
        (* Round 23: detect cached-zero 2-fold pieces as hung-piece markers. *)
        If[PossibleZeroQ[diskVal] && Length[vrs] == 2,
          MBAnalytica`SymbolicInt`Private`$mbtTotalHungCount++];
        Return[numFactor * diskVal, Module]]];
    (* 2026-07-19 DEGENERATE-TRIG RUNG (mbe_degtrig.m): polygamma-dressed
       balanced integer-linear 1-fold pieces have UNFAITHFUL Euler cubes at
       source (MB7 e^-1 silent-wrong class; MB6's 21 failed pieces). Evaluate
       them by exact trig-reduction residue sums, final-gated against contour
       quadrature. On pattern match with a failed evaluation, return 0 LOUDLY
       via the failed-pieces ledger — never fall through to the generic closer,
       whose value for this class is silently wrong. *)
    If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtDbgDegTrig],
      WriteString["stdout", "  [DBGdt] dvQ=" <>
        ToString[DownValues[MBAnalytica`SymbolicInt`Private`mbeDegTrigQ] =!= {}] <> " Q=" <>
        ToString[MBAnalytica`SymbolicInt`Private`mbeDegTrigQ[normalised, vrs]] <> " vrs=" <>
        ToString[vrs] <> "\n"]];
    (* NOTE (2026-07-20): dtvHook lives in the OUTER Module. An earlier
       version used an inner Module[{dtv}, ... Return[..., Module]] — that
       Return exits the INNER Module only (trap #20 class), so the correct
       rung value was computed, cached, DISCARDED, and the generic closer's
       silently-wrong value was served. Never wrap a Return[.., Module]
       intended for this closer in another Module/Block. *)
    (* 2026-07-20 CLEANUP (user directive): the degtrig tower rung is
       DISABLED by default — the widened Path-B/B' gate (Tier-1.5 +
       mbeMatchesDegenerateKernelQ) routes the degenerate family through
       the PROVEN shift+integral-rep cube machinery instead (no residue
       towers; no arc-vanishing assumption). Set
       MBAnalytica`SymbolicInt`Private`$mbeDegTrigRungEnabled = True to re-enable the
       quadrature-gated tower fast path for experiments. *)
    (* ============================================================
       DEGENERATE-CLASS DISPATCH (2026-07-20, final ordering)

       Priority is METHODOLOGICAL, not merely practical: the parametric
       (faithful-cube) attempts run FIRST because they make no
       contour-closure/arc-vanishing assumption.  The legacy trig-reduction
       residue tower runs only as a LAST RESORT, and only because it is
       itself gated: mbeDegTrigEval refuses to serve unless its value
       matches the contour quadrature to 1e-8, so a tower whose arc does
       not vanish can never deliver a number.

         attempt 1  Gamma-canonicalization + ordinary cube route
         attempt 2  shift + integral-representation (forced Path B/B')
         attempt 3  trig-reduction tower  [$mbeDegTrigTowerEnabled]
         else       ledger loudly + fall through to the generic closer

       Attempts 1-2 are capped tightly so a piece they cannot close falls
       through quickly instead of burning the worker budget. Every served
       value from 1-2 is verified against the same quadrature at 1e-6.
       ============================================================ *)
    (* ============================================================
       2026-07-26 ENTRY-POINT FIX: NORMALISE BEFORE CLASSIFYING.
       mbeDegTrigQ decides the class from the coefficient AS WRITTEN, but a
       same-slope Gamma-ratio hides the very feature it tests for:
       Gamma(1+z)/Gamma(z) = z, so
          Gamma(-1-z)Gamma(-z)Gamma(1+z)^3/Gamma(z)
       IS  z*Gamma(-z)^2 Gamma(1+z)^2/(-1-z)  --  it carries the unabsorbable
       numerator polynomial, while its written form shows none.  Read
       literally the residual pole is simple and every Gamma finds a partner,
       so every individual test reports "ordinary" and the piece is refused
       the dispatch -- hence never canonicalised, hence irreducible by the very
       machinery built for it.  Measured: mbeDegTrigQ is False for ALL 38 of
       MB6's failing pieces and for all 184 of MB8's, yet Gamma-minimisation
       plus the ordinary cube closes them in 8-124 s (relerr 0 to 20 digits,
       mbx_mb6_holdout.out).
       So the classification is evaluated on the CANONICAL representative as
       well as the written one.  Guards: 1-fold only; only when
       mbeGammaCanonHelpsQ says a denominator Gamma actually cancels (cheap
       precondition, so healthy pieces pay nothing); the rewrite is
       identity-gated at an interior contour point before it is trusted.
       This is the entry-point form of the retry added earlier the same day;
       it routes these pieces correctly the FIRST time instead of discovering
       the route by exhausting a ladder of timeouts.
       ============================================================ *)
    dtqCanon = normalised;
    If[Length[vrs] === 1 && DownValues[MBAnalytica`SymbolicInt`Private`mbeDegTrigQ] =!= {} &&
       ! TrueQ[MBAnalytica`SymbolicInt`Private`mbeDegTrigQ[normalised, vrs]] &&
       TrueQ[Quiet@TimeConstrained[
         MBAnalytica`SymbolicInt`Private`mbeGammaCanonHelpsQ[normalised, vrs], 60, False]],
      Module[{ecC, ecZt},
        ecC = Quiet@TimeConstrained[
          MBAnalytica`SymbolicInt`Private`mbeGammaCanonFull[normalised, vrs], 120, $Failed];
        If[ecC =!= $Failed && FreeQ[ecC, $Failed] && ecC =!= normalised,
          ecZt = (First[vrs] /. ctr) + I/7;
          If[TrueQ[Abs[Quiet@N[ecC /. First[vrs] -> ecZt, 25] -
                       Quiet@N[normalised /. First[vrs] -> ecZt, 25]] <
                   10^-12 (1 + Abs[Quiet@N[normalised /. First[vrs] -> ecZt, 25]])],
            dtqCanon = ecC;
            WriteString["stdout",
              "    [EntryCanon] classifying on the canonical form.\n"]]]]];
    If[DownValues[MBAnalytica`SymbolicInt`Private`mbeDegTrigQ] =!= {} &&
       (MBAnalytica`SymbolicInt`Private`mbeDegTrigQ[normalised, vrs] ||
        MBAnalytica`SymbolicInt`Private`mbeDegTrigQ[dtqCanon, vrs]),
      dtvQuad = $Failed;
      (* 2026-07-27 PHASE-STRIPPED ORACLE.  The old guard refused to build
         dtvQuad for any piece carrying a z-dependent phase, and since EVERY
         attempt below sits inside If[NumericQ[dtvQuad],...], such a piece was
         admitted to this dispatch and then skipped the entire ladder.  That is
         MB8's actual blocker: 150 of its 184 failing coefficients carry
         E^(2 I Pi z6), so no amount of canonicalisation could ever reach them.
         The gate is repairable because the route's own convention is known:
         MBtoEuler DROPS z-phases ($mbePhaseConvention = "Drop",
         mbeNormalizeEulerForm maps Power[-1,e] -> 1) and the phase is restored
         afterwards at group level (mbtGroupedOneFoldPhaseCorrection).  So the
         attempts return PHASE-STRIPPED values, and the oracle must be built the
         same way -- strip the pure z-phase, keep everything else, then quad.
         A c^z SCALE factor must NOT be stripped, so E^(c) is only touched when
         its z-coefficient is purely imaginary. *)
      If[Length[vrs] == 1,
        Module[{qzz = First[vrs], qStrip},
          qStrip = normalised /. {
            Power[-1, qe_] /; ! FreeQ[qe, Alternatives @@ vrs] :> 1,
            Power[E, qe_] /; ! FreeQ[qe, Alternatives @@ vrs] &&
              TrueQ[Quiet@Check[
                FreeQ[Simplify[Coefficient[qe, qzz]/I], Complex], False]] :>
              Power[E, qe - Coefficient[qe, qzz] qzz]};
          If[FreeQ[qStrip, Complex] &&
             FreeQ[qStrip, Power[bb_ /; bb === -1 || bb === E,
               ee_ /; ! FreeQ[ee, Alternatives @@ vrs]]],
            dtvQuad = Quiet@TimeConstrained[
              NIntegrate[(qStrip /. qzz -> ctr[[1, 2]] + I Global`mbeTT)/(2 Pi),
                {Global`mbeTT, -60, 60}, WorkingPrecision -> 25,
                PrecisionGoal -> 10, MaxRecursion -> 14], 120, $Failed];
            If[NumericQ[Quiet@N[dtvQuad]] &&
               ! FreeQ[normalised, Power[bb_ /; bb === -1 || bb === E,
                 ee_ /; ! FreeQ[ee, Alternatives @@ vrs]]],
              WriteString["stdout",
                "    [PhaseOracle] z-phase stripped; quad oracle available.\n"]]]]];
      (* ---- PREPASS (a) 2026-07-21: GAMMA-MINIMIZATION ----
         Collapse redundant same-slope integer-differing Gamma ratios
         (e.g. Gamma(-z)/Gamma(1-z) -> -1/z) so every cube/shift route
         sees the piece in its TRUE minimal form. Identity-gated: used
         only if it numerically equals `normalised`, else falls back.
         The DoAllBarnes/MBexpand pipeline leaves such redundancy, making
         pieces look harder than they are (measured on MB9 p39: 6->4 Gammas
         revealing the pure csc^2 kernel). *)
      normMin = Quiet@TimeConstrained[
        MBAnalytica`SymbolicInt`Private`mbeGammaCanonFull[normalised, vrs], 120, $Failed];
      If[normMin === $Failed || ! FreeQ[normMin, $Failed] ||
         (NumericQ[Quiet@N[dtvQuad]] &&
          Module[{zt = ctr[[1, 2]] + I/7},
            ! TrueQ[Abs[Quiet@N[normMin /. First[vrs] -> zt, 25] -
                        Quiet@N[normalised /. First[vrs] -> zt, 25]] <
                    10^-12 (1 + Abs[Quiet@N[normalised /. First[vrs] -> zt, 25]])]]),
        normMin = normalised];
      If[NumericQ[Quiet@N[dtvQuad]],
        (* ---- attempt 0 (2026-07-20): the ORDINARY route, verified ----
           Measured on MB9: for many degenerate-class pieces the standard
           pipeline is already exactly right (cube generation faithful AND
           IntVol closes it: 3 cubes summing to the contour value to 17
           digits). Running the special attempts first merely starved the
           worker budget (~12 min of futile retries) and the piece was
           recorded as a failure. So try the plain route FIRST and let the
           quadrature arbiter decide; the special attempts remain for the
           pieces whose plain value is genuinely wrong (MB7's class). *)
        MBAnalytica`SymbolicInt`Private`$mbtIVCertPend = {};   (* v2.6 *)
        dtvPB = Quiet@TimeConstrained[
          MBAnalytica`SymbolicInt`MBSymbolicInt[normalised, ctr, vrs,
            "Assumptions" -> {}, "ParametricValues" -> {}], 300, $Failed];
        dtvPBv = If[AssociationQ[dtvPB], dtvPB["MPLResult"], dtvPB];
        If[dtvPBv =!= $Failed && NumericQ[Quiet@N[dtvPBv]] &&
           Abs[Quiet@N[dtvPBv, 20] - dtvQuad] < 10^-6 (1 + Abs[dtvQuad]),
          MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = dtvPBv;
          MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash, dtvPBv];
          MBAnalytica`SymbolicInt`Private`mbtIVCertSweep["deg-dispatch attempt0 piece-quad 1e-6"];
          WriteString["stdout",
            "    [DegClass] attempt0 ORDINARY route QUAD-VERIFIED.\n"];
          Return[numFactor * dtvPBv, Module]];
        (* ---- attempt 0.5: DIRECT faithful-cube close (MBtoEuler +
           IntVolIntegrate over all parts). Bypasses MBSymbolicInt's internal
           symbolic-residue diversion, which is wrong for this class
           (MB9 family B: 263 vs true 66). ---- *)
        MBAnalytica`SymbolicInt`Private`$mbtIVCertPend = {};   (* v2.6 *)
        dtvPBv = Quiet@TimeConstrained[
          MBAnalytica`SymbolicInt`Private`mbeDirectCubeClose[normMin, ctr, vrs, 400], 900, $Failed];
        If[dtvPBv =!= $Failed && NumericQ[Quiet@N[dtvPBv]] &&
           Abs[Quiet@N[dtvPBv, 20] - dtvQuad] < 10^-6 (1 + Abs[dtvQuad]),
          MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = dtvPBv;
          MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash, dtvPBv];
          MBAnalytica`SymbolicInt`Private`mbtIVCertSweep["deg-dispatch attempt0.5 piece-quad 1e-6"];
          WriteString["stdout",
            "    [DegClass] attempt0.5 DIRECT-CUBE QUAD-VERIFIED.\n"];
          Return[numFactor * dtvPBv, Module]];
        (* ---- attempt 0.6: GROWTH polynomial-split + faithful cube ----
           pure-Gamma (or residual) growth pieces whose canon carries an
           unabsorbable numerator polynomial (the delta-derivative part
           Block 5 refuses): split into poly-free Gammas via
           mbeGammaPolySplit and cube each, sum.  Fires only when a split
           exists (>=2 pieces); returns $Failed fast (no split, or a piece
           did not cube) so working pieces fall through untouched.  Pure
           faithful-cube route -- no tower, no harmonic sum. ---- *)
        MBAnalytica`SymbolicInt`Private`$mbtIVCertPend = {};   (* v2.6 *)
        dtvPBv = Quiet@TimeConstrained[
          MBAnalytica`SymbolicInt`Private`mbeGrowthPolySplitClose[normMin, ctr, vrs, 400], 2000, $Failed];
        If[dtvPBv =!= $Failed && NumericQ[Quiet@N[dtvPBv]] &&
           Abs[Quiet@N[dtvPBv, 20] - dtvQuad] < 10^-6 (1 + Abs[dtvQuad]),
          MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = dtvPBv;
          MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash, dtvPBv];
          MBAnalytica`SymbolicInt`Private`mbtIVCertSweep["deg-dispatch attempt0.6 piece-quad 1e-6"];
          WriteString["stdout",
            "    [DegClass] attempt0.6 GROWTH-POLYSPLIT QUAD-VERIFIED.\n"];
          Return[numFactor * dtvPBv, Module]];
        (* ---- attempt 0.7 (b): PSI-SHIFT + SPLIT + cube/shift close ---- *)
        MBAnalytica`SymbolicInt`Private`$mbtIVCertPend = {};   (* v2.6 *)
        dtvPBv = Quiet@TimeConstrained[
          MBAnalytica`SymbolicInt`Private`mbeShiftSplitClose[normMin, ctr, vrs, 400], 3000, $Failed];
        If[dtvPBv =!= $Failed && NumericQ[Quiet@N[dtvPBv]] &&
           Abs[Quiet@N[dtvPBv, 20] - dtvQuad] < 10^-6 (1 + Abs[dtvQuad]),
          MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = dtvPBv;
          MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash, dtvPBv];
          MBAnalytica`SymbolicInt`Private`mbtIVCertSweep["deg-dispatch attempt0.7 piece-quad 1e-6"];
          WriteString["stdout",
            "    [DegClass] attempt0.7 PSI-SHIFT-SPLIT QUAD-VERIFIED.\n"];
          Return[numFactor * dtvPBv, Module]];
        (* ---- attempt 0.75: DERIVATIVE FORM (fold-(k+2), sidecar) ----
           psi0^k pieces on a no-window kernel: EGF/Bell inversion into an
           aux-Gamma cube (one lower fold than force-shift) whose [iota^k]
           coefficient is closed by mbeSeqIntegrate (variable-by-variable,
           bypassing the ToFibrationBasis spurious-polynomial failure).
           Tried BEFORE force-shift because force-shift is fold-(k+3) and
           times out on these; the derivative form completes.  Guarded by
           DownValues so the package still loads without the sidecar. *)
        If[DownValues[MBAnalytica`SymbolicInt`Private`mbeDerivFormCloseAuto] =!= {},
          MBAnalytica`SymbolicInt`Private`$mbtIVCertPend = {};   (* v2.6 *)
          dtvPBv = Quiet@TimeConstrained[
            MBAnalytica`SymbolicInt`Private`mbeDerivFormCloseAuto[normMin, ctr, vrs, 1500],
            5000, $Failed];
          If[dtvPBv =!= $Failed && NumericQ[Quiet@N[dtvPBv]] &&
             Abs[Quiet@N[dtvPBv, 20] - dtvQuad] < 10^-6 (1 + Abs[dtvQuad]),
            MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = dtvPBv;
            MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash, dtvPBv];
            MBAnalytica`SymbolicInt`Private`mbtIVCertSweep["deg-dispatch attempt0.75 piece-quad 1e-6"];
            WriteString["stdout",
              "    [DegClass] attempt0.75 DERIVATIVE-FORM QUAD-VERIFIED.\n"];
            Return[numFactor * dtvPBv, Module]]];
        (* ---- attempt 0.8: PSI FORCE-SHIFT + split + cube/shift ---- *)
        MBAnalytica`SymbolicInt`Private`$mbtIVCertPend = {};   (* v2.6 *)
        dtvPBv = Quiet@TimeConstrained[
          MBAnalytica`SymbolicInt`Private`mbeForceShiftClose[normMin, ctr, vrs,
            MBAnalytica`SymbolicInt`Private`$mbeForceShiftPieceTO],
          MBAnalytica`SymbolicInt`Private`$mbeForceShiftTotalTO, $Failed];
        If[dtvPBv =!= $Failed && NumericQ[Quiet@N[dtvPBv]] &&
           Abs[Quiet@N[dtvPBv, 20] - dtvQuad] < 10^-6 (1 + Abs[dtvQuad]),
          MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = dtvPBv;
          MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash, dtvPBv];
          MBAnalytica`SymbolicInt`Private`mbtIVCertSweep["deg-dispatch attempt0.8 piece-quad 1e-6"];
          WriteString["stdout",
            "    [DegClass] attempt0.8 PSI-FORCE-SHIFT QUAD-VERIFIED.\n"];
          Return[numFactor * dtvPBv, Module]];
        (* ---- attempt 1: Gamma-canonicalization + plain cube route ---- *)
        dtvCanon = Quiet@TimeConstrained[
          MBAnalytica`SymbolicInt`Private`mbeGammaCanonFull[normalised, vrs], 120, $Failed];
        If[dtvCanon =!= $Failed && FreeQ[dtvCanon, $Failed] &&
           dtvCanon =!= normalised,
          MBAnalytica`SymbolicInt`Private`$mbtIVCertPend = {};   (* v2.6 *)
          dtvPB = Quiet@TimeConstrained[
            MBAnalytica`SymbolicInt`MBSymbolicInt[dtvCanon, ctr, vrs,
              "Assumptions" -> {}, "ParametricValues" -> {}], 240, $Failed];
          dtvPBv = If[AssociationQ[dtvPB], dtvPB["MPLResult"], dtvPB];
          If[dtvPBv =!= $Failed && NumericQ[Quiet@N[dtvPBv]] &&
             Abs[Quiet@N[dtvPBv, 20] - dtvQuad] < 10^-6 (1 + Abs[dtvQuad]),
            MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = dtvPBv;
            MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash, dtvPBv];
            MBAnalytica`SymbolicInt`Private`mbtIVCertSweep["deg-dispatch attempt1 piece-quad 1e-6"];
            WriteString["stdout",
              "    [DegClass] attempt1 GAMMA-CANON+cube QUAD-VERIFIED.\n"];
            Return[numFactor * dtvPBv, Module]]];
        (* ---- attempt 2: shift + integral rep (forced Path B/B') ---- *)
        MBAnalytica`SymbolicInt`Private`$mbtIVCertPend = {};   (* v2.6 *)
        dtvPB = Block[{MBAnalytica`SymbolicInt`Private`$mbeForceSymbolicResidue = True},
          Quiet@TimeConstrained[
            MBAnalytica`SymbolicInt`MBSymbolicInt[normMin, ctr, vrs,
              "Assumptions" -> {}, "ParametricValues" -> {}], 240, $Failed]];
        dtvPBv = If[AssociationQ[dtvPB], dtvPB["MPLResult"], dtvPB];
        If[dtvPBv =!= $Failed && NumericQ[Quiet@N[dtvPBv]] &&
           Abs[Quiet@N[dtvPBv, 20] - dtvQuad] < 10^-6 (1 + Abs[dtvQuad]),
          MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = dtvPBv;
          MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash, dtvPBv];
          MBAnalytica`SymbolicInt`Private`mbtIVCertSweep["deg-dispatch attempt2 piece-quad 1e-6"];
          WriteString["stdout",
            "    [DegClass] attempt2 SHIFT+INTEGRAL-REP QUAD-VERIFIED.\n"];
          Return[numFactor * dtvPBv, Module]]];
      (* ---- attempt 3: legacy tower, quadrature-gated inside ---- *)
      dtvHook = If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbeDegTrigTowerEnabled] &&
        DownValues[MBAnalytica`SymbolicInt`Private`mbeDegTrigTowerQ] =!= {} &&
        TrueQ[MBAnalytica`SymbolicInt`Private`mbeDegTrigTowerQ[normalised, vrs]],
        Quiet @ MBAnalytica`SymbolicInt`Private`mbeDegTrigEval[normalised, ctr, vrs], $Failed];
      If[dtvHook =!= $Failed && NumericQ[N[dtvHook]],
        MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = dtvHook;
        MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash, dtvHook];
        AppendTo[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces,
          <|"reason" -> "tower-fallback-used", "vars" -> vrs,
            "normalised" -> Short[normalised, 3]|>];
        WriteString["stdout",
          "    [DegClass] attempt3 TOWER used (cube attempts failed) - ledgered.\n"];
        Return[numFactor * dtvHook, Module]];
      AppendTo[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces,
        <|"reason" -> "degclass-all-attempts-failed", "vars" -> vrs,
          "normalised" -> Short[normalised, 3]|>];
      WriteString["stdout",
        "    [DegClass] ALL attempts failed; generic closer value SUSPECT (ledgered).\n"]];
    (* Cache miss — recompute *)
    MBAnalytica`SymbolicInt`Private`$mbtCacheMisses++;
      (* Round 15 fast-path: 1-var Gamma+ψ patterns close in 0.1-0.5s via HS. *)
      hsAttempt = $Failed;
      lsrLoaded = $Failed;
      If[Length[vrs] == 1,
        lsrLoaded = MBAnalytica`SymbolicInt`Private`mbeLoadHarmonicSums[];
        If[lsrLoaded =!= $Failed,
          hsAttempt = Quiet@TimeConstrained[
            Module[{rA, rB},
              rA = MBAnalytica`SymbolicInt`Private`mbeCloseMBPieceHS[normalised, First[vrs]];
              If[rA =!= $Failed && FreeQ[rA, First[vrs]],
                rA,
                rB = MBAnalytica`SymbolicInt`Private`mbeCloseMBPieceHSB[normalised, First[vrs]];
                If[rB =!= $Failed && FreeQ[rB, First[vrs]],
                  rB, $Failed]]],
            30, $TimedOut]]];
      symbolicIntTimedOut = False;
      (* A HarmonicSums expression is a fast-path candidate, not trusted merely
         because it is different from $Failed.  In particular, Indeterminate
         is NumericQ in some Mathematica contexts and was formerly accepted
         and cached here.  Apply the same finite constant gate used by the
         ordinary closer; an invalid HS answer falls through to that exact
         route instead of poisoning the assembly/cache. *)
      If[MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[hsAttempt, vrs] &&
         FreeQ[hsAttempt, HarmonicSums`S[__, Infinity]] &&
         FreeQ[hsAttempt, First[vrs]],
        r = hsAttempt,
        (* Round 22.5 + perf fix (2026-06-19): cap the plain MBSymbolicInt
           attempt.  For 1-fold pieces use a SINGLE 180s cap -- TimeConstrained
           returns immediately for the many fast pieces, and medium weight-6
           pieces (10-180s) now close in ONE pass instead of wasting a 10s probe
           then recomputing from scratch in a 180s retry.  Multi-var pieces keep
           the short 10s probe (the historical hangs are 2-fold pieces; they then
           go to GreedySearch). *)
        r = Quiet @ TimeConstrained[
            Block[{Print}, MBAnalytica`SymbolicInt`MBSymbolicInt[normalised, ctr, vrs]],
            If[Length[vrs] == 1, 180, 10], $TimedOut];
        (* Round 25 (2026-06-13): alternative route — before giving up on a
           timed-out piece, retry with GreedySearch under a real time budget.
           Linearly-reducible 2-fold cross-pole pieces close EXACTLY this way
           (mb14_2fold_timeout_artifact). *)
        If[AssociationQ[r], r = r["MPLResult"]];
        (* Round 26f (2026-06-14): trigger recovery not only on $TimedOut but also
           when the 10s attempt returns a NON-NUMERIC value -- e.g. an unintegrated
           Euler cube integrand (Euler2MPL "beyond scope" returns fast, so the
           timeout never fires). *)
        If[! MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[r, vrs] &&
           TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseLongClose] &&
           Length[vrs] >= MBAnalytica`SymbolicInt`Private`$mbtLongCloseMinVars,
          Module[{rL = $Failed},
            (* Item 1 + speed fix (2026-06-18): bounded fallback ladder.
               (a) The 10s plain cap above pushed medium 1-fold pieces (those that
               plain-close in 10-180s) into the much slower recovery loop; so first
               give plain MBSymbolicInt a LONGER 180s retry for 1-fold $TimedOut pieces.
               (b) Only if that still isn't a clean number, use contour-shift
               recovery (the reliable 1-var closer; GreedySearch is a multivar
               order-search that merely HANGS on 1-fold).  (c) EVERY fallback is now
               TIME-BOUNDED (TimeConstrained) so no single piece can run away to
               2785s+ via the unbounded recovery loop. Multi-var pieces fall through
               to GreedySearch first (closes the 2-fold cross-pole pieces). *)
            (* Superseded (2026-06-19): the first plain cap is now 180s for
               1-fold, so this 180s retry would only double-pay a true timeout.
               Disabled; a genuine 1-fold timeout goes straight to contour
               recovery below. *)
            If[False && Length[vrs] == 1 && r === $TimedOut,
              WriteString["stdout", "    [LSR] plain MBSymbolicInt retry (1-var, 180s)...\n"];
              rL = Quiet @ TimeConstrained[
                 Block[{Print}, MBAnalytica`SymbolicInt`MBSymbolicInt[normalised, ctr, vrs]], 180, $TimedOut];
              If[AssociationQ[rL], rL = rL["MPLResult"]]];
            If[Length[vrs] == 1 && ! MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[rL, vrs],
              WriteString["stdout",
                "    [LSR] contour-shift recovery (1-var, recovery-first)...\n"];
              rL = Quiet @ TimeConstrained[
                 MBAnalytica`SymbolicInt`Private`mbtRecoverContour[
                   normalised, First[vrs] /. ctr, First[vrs]],
                 MBAnalytica`SymbolicInt`Private`$mbtLongCloseBudget, $TimedOut]];
            If[! MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[rL, vrs],
              WriteString["stdout",
                "    [LSR] non-numeric/timeout; GreedySearch (" <>
                ToString[Length[vrs]] <> "-fold)...\n"];
              rL = Quiet @ TimeConstrained[
                 Block[{Print},
                   MBAnalytica`SymbolicInt`MBSymbolicInt[normalised, ctr, vrs, "GreedySearch" -> True]],
                 MBAnalytica`SymbolicInt`Private`$mbtLongCloseBudget, $TimedOut];
              If[AssociationQ[rL], rL = rL["MPLResult"]];
              (* last-ditch: bounded 1-var contour-shift recovery *)
              If[! MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[rL, vrs] && Length[vrs] == 1,
                WriteString["stdout", "    [LSR] contour-shift recovery (1-var, fallback)...\n"];
                rL = Quiet @ TimeConstrained[
                   MBAnalytica`SymbolicInt`Private`mbtRecoverContour[
                     normalised, First[vrs] /. ctr, First[vrs]],
                   MBAnalytica`SymbolicInt`Private`$mbtLongCloseBudget, $TimedOut]]];
            (* A ONE-fold value of the recovery ladder is accepted only when the contour quadrature of the piece
               on its own line confirms it (relative 1e-8).  Multi-fold values keep the ledger rules of the caller. *)
            If[MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[rL, vrs] && Length[vrs] == 1,
              Module[{tq, q, c0 = First[vrs] /. ctr, v = First[vrs]},
                q = Quiet @ TimeConstrained[
                  NIntegrate[Evaluate[(normalised /. v -> c0 + I tq)/(2 Pi)], {tq, -60, 60}, WorkingPrecision -> 25,
                    PrecisionGoal -> 10, MaxRecursion -> 30], 300, $TimedOut];
                If[! TrueQ[NumericQ[q] && Abs[N[rL, 30] - q] < 10^-8 Max[1, Abs[q]]],
                  WriteString["stdout", "    [LSR] recovery value REFUSED by the contour quadrature: ",
                    ToString[N[rL, 12]], " vs ", ToString[If[NumericQ[q], N[q, 12], q]], "\n"];
                  rL = $Failed]]];
            If[MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[rL, vrs],
              r = rL;
              MBAnalytica`SymbolicInt`Private`$mbtLongCloseCount++;
              WriteString["stdout",
                "    [LSR] long-close/recovery SUCCEEDED\n"]]]];
        If[AssociationQ[r], r = r["MPLResult"]];
        (* 2026-07-26 GAMMA-CANON RETRY (a REACHABILITY fix, not new theory).
           Measured on MB6's failed-piece dump: all 38 entries are 1-fold and
           mbeDegTrigQ is False for every one of them, so the ENTIRE degenerate
           dispatch -- including attempt 1, Gamma-minimisation + ordinary cube --
           is unreachable for them.  Their IntegralRep sub-integrands then all
           die at Block 5 with "Non-Beta prefactor not pure power-like",
           because the raw Gamma structure
               Gamma(-1-z)Gamma(-z)Gamma(1+z)^3/Gamma(z)
           carries an unabsorbed numerator polynomial (Gamma(1+z)/Gamma(z) = z).
           mbeGammaCanonFull rewrites it to
               Gamma(1-z)Gamma(-z)Gamma(1+z)^2/(1+z),
           after which the ORDINARY faithful cube closes the piece: measured
           8/10 sampled MB6 pieces, most at relerr 0 to 20 digits vs the contour
           quadrature (mbx_mb6_hyp_batch.out).
           Fires ONLY here, in the final not-clean-number branch, for 1-fold
           pieces, and serves ONLY on a contour-quadrature match at 1e-6 -- so a
           healthy piece never pays for it and a wrong value is never served. *)
        If[! MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[r, vrs] && Length[vrs] === 1 &&
           FreeQ[normalised, Complex] &&
           FreeQ[normalised, Power[bb_ /; bb === -1 || bb === E,
             ee_ /; ! FreeQ[ee, Alternatives @@ vrs]]],
          Module[{gcQuad, gcCanon, gcVal, gcNum, gcZt, gcW},
            gcQuad = Quiet@TimeConstrained[
              NIntegrate[
                Re[(normalised /. First[vrs] -> (First[vrs] /. ctr) + I gcW)/(2 Pi)],
                {gcW, -60, 60}, WorkingPrecision -> 25, PrecisionGoal -> 12,
                MaxRecursion -> 16], 120, $Failed];
            If[NumericQ[Quiet@N[gcQuad]],
              gcCanon = Quiet@TimeConstrained[
                MBAnalytica`SymbolicInt`Private`mbeGammaCanonFull[normalised, vrs], 180, $Failed];
              (* identity gate at an interior point: never trust a rewrite *)
              If[gcCanon =!= $Failed && FreeQ[gcCanon, $Failed] &&
                 gcCanon =!= normalised,
                gcZt = (First[vrs] /. ctr) + I/7;
                If[TrueQ[Abs[Quiet@N[gcCanon /. First[vrs] -> gcZt, 25] -
                             Quiet@N[normalised /. First[vrs] -> gcZt, 25]] <
                         10^-12 (1 + Abs[Quiet@N[normalised /. First[vrs] -> gcZt, 25]])],
                  (* Walk the EXISTING closer ladder on the canonicalised
                     piece, each rung quadrature-gated.  Direct-cube alone is
                     NOT enough: measured on MB6's dumped pieces, 10 of 12
                     close at direct-cube but 2 get a WRONG value from it
                     (relerr 1.37 and 0.27, correctly rejected by the gate) and
                     are then closed EXACTLY by psi-shift-split.  Walking the
                     ladder takes the sample from 10/12 to 12/12, all at
                     relerr 0 vs the contour quadrature
                     (mbx_mb6_holdout.out).  No new evaluator is introduced --
                     every rung already exists and is already used inside the
                     degenerate dispatch; this only makes them reachable for
                     pieces that dispatch never admits. *)
                  Module[{gcLadder, gcHit = False},
                    gcLadder = {
                      {"direct-cube",
                        MBAnalytica`SymbolicInt`Private`mbeDirectCubeClose},
                      {"growth-polysplit",
                        MBAnalytica`SymbolicInt`Private`mbeGrowthPolySplitClose},
                      {"psi-shift-split",
                        MBAnalytica`SymbolicInt`Private`mbeShiftSplitClose},
                      {"psi-force-shift",
                        MBAnalytica`SymbolicInt`Private`mbeForceShiftClose}};
                    Do[
                      If[! gcHit,
                        Module[{gcNm = gcRung[[1]], gcFn = gcRung[[2]]},
                          (* caps set from MEASUREMENT, not habit: every
                             observed success on this class lands in 8-124 s
                             (mbx_mb6_holdout.out), so 150/250 s is generous
                             while bounding a failure to ~1000 s instead of
                             ~2800 s. *)
                          MBAnalytica`SymbolicInt`Private`$mbtIVCertPend = {};   (* v2.6 *)
                          gcVal = Quiet@TimeConstrained[
                            gcFn[gcCanon, ctr, vrs, 150], 250, $Failed];
                          gcNum = If[gcVal === $Failed ||
                              ! FreeQ[gcVal, $Failed], $Failed,
                            Quiet@MBAnalytica`SymbolicInt`Private`mbeSeqNValue[gcVal, 20]];
                          If[gcNum =!= $Failed && NumericQ[Quiet@N[gcNum]] &&
                             Abs[Re[Quiet@N[gcNum, 20]] - gcQuad] <
                               10^-6 (1 + Abs[gcQuad]),
                            MBAnalytica`SymbolicInt`Private`mbtIVCertSweep[
                              "GammaCanonRetry piece-quad 1e-6"];
                            WriteString["stdout",
                              "    [GammaCanonRetry] canon+" <> gcNm <>
                              " QUAD-VERIFIED.\n"];
                            r = gcNum; gcHit = True]]],
                      {gcRung, gcLadder}]]]]]]];
        (* ---- v2.9 (2026-07-29): MULTI-FOLD QUAD-GATED RETRY ----
           The dispatch's oracle (dtvQuad) and the GammaCanonRetry ladder are
           1-fold-only, so every failing 2/3-fold coefficient was ledgered
           after burning its full ladder budget with NO gated closer ever
           applicable -- the measured dominant cost of MB8-class runs
           (failure-path economics: successes ~5 s, failures ~20 min).
           This block is the multi-fold analog of GammaCanonRetry: build a
           PHASE-STRIPPED flat contour quadrature oracle (route convention),
           then try direct-cube and Gamma-canon+direct-cube, serving only on
           a 1e-6 oracle match; certified via the v2.6 sweep. *)
        If[! MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[r, vrs] &&
           MemberQ[{2, 3}, Length[vrs]],
          Module[{mfQuad = $Failed, mfStrip, mfTs, mfSub, mfVal, mfNum},
            mfStrip = normalised;
            Do[Module[{mfZ = mfZv},
               mfStrip = mfStrip /. {
                 Power[-1, mfE_] /; ! FreeQ[mfE, mfZ] :> 1,
                 Power[E, mfE_] /; ! FreeQ[mfE, mfZ] &&
                   TrueQ[Quiet@Check[FreeQ[
                     Simplify[Coefficient[mfE, mfZ]/I], Complex], False]] :>
                   Power[E, mfE - Coefficient[mfE, mfZ] mfZ]}],
              {mfZv, vrs}];
            If[FreeQ[mfStrip, Complex] &&
               FreeQ[mfStrip, Power[mfB_ /; mfB === -1 || mfB === E,
                 mfE_ /; ! FreeQ[mfE, Alternatives @@ vrs]]],
              mfTs = Table[Unique["mbtMfT"], {Length[vrs]}];
              mfSub = MapThread[(#1 -> (#1 /. ctr) + I #2) &, {vrs, mfTs}];
              mfQuad = Quiet@TimeConstrained[
                NIntegrate[
                  Re[Quiet@FunctionExpand[mfStrip] /. mfSub]/
                    (2 Pi)^Length[vrs],
                  Evaluate[Sequence @@ ({#, -20, 20} & /@ mfTs)],
                  WorkingPrecision -> 20, PrecisionGoal -> 9,
                  MaxRecursion -> 12,
                  Method -> {"GlobalAdaptive", "MaxErrorIncreases" -> 2000}],
                If[Length[vrs] == 2, 300, 700], $Failed]];
            If[NumericQ[Quiet@N[mfQuad]],
              WriteString["stdout",
                "    [MultiFoldRetry] phase-stripped oracle available.\n"];
              Do[
               If[! MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[r, vrs],
                 Module[{mfIn},
                   mfIn = If[mfTry === "direct", mfStrip,
                     Module[{mfCc = Quiet@TimeConstrained[
                         MBAnalytica`SymbolicInt`Private`mbeGammaCanonFull[mfStrip, vrs],
                         120, $Failed]},
                       If[mfCc =!= $Failed && FreeQ[mfCc, $Failed],
                         mfCc, $Failed]]];
                   If[mfIn =!= $Failed,
                     MBAnalytica`SymbolicInt`Private`$mbtIVCertPend = {};
                     mfVal = Quiet@TimeConstrained[
                       MBAnalytica`SymbolicInt`Private`mbeDirectCubeClose[mfIn, ctr, vrs,
                         300], 600, $Failed];
                     mfNum = If[mfVal === $Failed ||
                         ! FreeQ[mfVal, $Failed], $Failed,
                       Quiet@MBAnalytica`SymbolicInt`Private`mbeSeqNValue[mfVal, 20]];
                     If[NumericQ[Quiet@N[mfNum]] &&
                        Abs[Re[Quiet@N[mfNum, 20]] - mfQuad] <
                          10^-6 (1 + Abs[mfQuad]),
                       MBAnalytica`SymbolicInt`Private`mbtIVCertSweep[
                         "MultiFoldRetry piece-quad 1e-6"];
                       WriteString["stdout",
                         "    [MultiFoldRetry] " <> ToString[mfTry] <>
                         " QUAD-VERIFIED.\n"];
                       r = mfNum]]]],
               {mfTry, {"direct", "canon"}}]]]];
        (* 2026-07-24 PINCH CLOSER (corner-linear, oracle-gated): LAST attempt
           for multi-fold pieces carrying a numerator cross-variable Gamma
           (the pinch class: NNC-corner cubes the ordinary path cannot close).
           Fires only after every ordinary attempt failed, so healthy pieces
           never pay for it; serves the 20-digit numeric of the closed form
           (mbtCleanNumQ requires a plain numeric; the exact form is kept in
           $mbePinchClosedForms). On $Failed falls through to the ledger. *)
        If[! MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[r, vrs] && Length[vrs] >= 1 &&
           TrueQ[MBAnalytica`SymbolicInt`Private`$mbePinchCloserEnabled] &&
           DownValues[MBAnalytica`SymbolicInt`Private`mbePinchLinClose] =!= {} &&
           TrueQ[Quiet@MBAnalytica`SymbolicInt`Private`mbePinchPieceQ[normalised, vrs]],
          WriteString["stdout",
            "    [PinchLin] pinch fingerprint; corner-linear closer...\n"];
          (* 2026-07-26 COST GATE.  mbePinchPieceQ returns True for ANY
             1-fold piece, so every failing 1-fold coefficient was entering a
             closer designed for 2-fold cross-Gamma pinches and burning its
             full 2400 s budget.  Measured on MB8: 184 failing pieces, ALL
             1-fold, all distinct (so no memoisation can help) -- that alone is
             184*2400 s of waste, and it is why 87% of wall-clock sat in gaps
             longer than 60 s.  The genuine 1-fold customers of this closer are
             the origin/+-1 double-pole family (p_0055 class), whose kernel has
             a repeated pole AT THE ORIGIN; those keep the full budget.  Every
             other 1-fold piece gets a short probe and is then ledgered. *)
          Module[{rP, rPn, pcBudget, pcOrigin},
            pcOrigin = Length[vrs] =!= 1 ||
              (! FreeQ[normalised, Gamma[a_ /; PossibleZeroQ[a /. First[vrs] -> 0]]^_Integer] ||
               ! FreeQ[Denominator[Together[normalised]],
                   Power[First[vrs], _Integer?(# >= 2 &)]]);
            pcBudget = If[TrueQ[pcOrigin], 2400, 200];
            rP = Quiet@TimeConstrained[
              MBAnalytica`SymbolicInt`Private`mbePinchLinClose[normalised, ctr, vrs, pcBudget],
              pcBudget + 300, $Failed];
            rPn = If[rP === $Failed, $Failed,
              Quiet@MBAnalytica`SymbolicInt`Private`mbeSeqNValue[rP, 30]];
            If[rPn =!= $Failed && NumericQ[Quiet@N[rPn]],
              MBAnalytica`SymbolicInt`Private`$mbePinchClosedForms[{normalised, ctr, vrs}] = rP;
              r = rPn]]];
        (* s99 (2026-08-27): THEORY-GUIDED EXACT ENGINE DISPATCH (sidecar:
           load_mbe_engines.m).  The numerical contour quadrature below is a
           verifier only.  A successful engine result is served in its exact
           GPL/MZV form; a float, inert head, residual variable, uncorroborated
           zero, or imaginary mismatch is refused and falls through to the
           ordinary failed-piece ledger.  IntVol's dimension cap and strict
           LR/grouped routing live in mbe_strategy_dispatch_v2.m. *)
        (* s71 (2026-08-26): THEORY-GUIDED ENGINE DISPATCH.
           Classifies the piece by its algebraic signature per the standard_syed.tex sec:coverage
           obstruction taxonomy (normalise -> classify -> dispatch): balanced no-window / any-psi
           1-fold -> integral-rep faithful cube (Engine 1); sum-cross 2-fold -> N-fold integral-rep
           cube (engineN); diff-cross 2-fold -> reflect z->-z + betaGuardLift + engineN (the
           sec:diffkernel polysplit+shift realized).  Guarded by the sidecar's DownValues, so the
           package behaves byte-identically when load_mbe_engines.m is not loaded.  A value is
           served ONLY on a 1e-6 quadrature-oracle match (dtvQuad when available, else a flat
           phase-free quadrature built here); the exact GPL form is kept in
           $mbeEngineClosedForms[{normalised,ctr,vrs}]. *)
        If[! MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[r, vrs] &&
           DownValues[MBEStrategy`mbeStdClose] =!= {},
          Module[{esOr = $Failed, esOrNarrow = $Failed,
              esOrWide = $Failed, esOracleIntegrand = normalised,
              esTs, esSub, esRes, esExact, esNum, esExactQ},
            (* Build a genuinely complex, tail-stability-gated contour oracle.
               For the one-fold phase convention use the same exact phase
               stripping as MBtoEuler; scale factors are never stripped. *)
            If[Length[vrs] === 1,
              Module[{esZ = First[vrs]},
                esOracleIntegrand = esOracleIntegrand /. {
                  Power[-1, esE_] /;
                      !FreeQ[esE, Alternatives @@ vrs] :> 1,
                  Power[E, esE_] /;
                      !FreeQ[esE, Alternatives @@ vrs] &&
                      TrueQ[Quiet@Check[
                        FreeQ[Simplify[Coefficient[esE, esZ]/I], Complex],
                        False]] :>
                    Power[E, esE - Coefficient[esE, esZ] esZ]}]];
            If[FreeQ[esOracleIntegrand, Complex] &&
               FreeQ[esOracleIntegrand,
                 Power[esB_ /; esB === -1 || esB === E,
                   esE_ /; !FreeQ[esE, Alternatives @@ vrs]]],
              esTs = Table[Unique["mbtEsT$"], {Length[vrs]}];
              esSub = MapThread[(#1 -> (#1 /. ctr) + I #2) &, {vrs, esTs}];
              esOrNarrow = Quiet@TimeConstrained[
                NIntegrate[
                  (Quiet@FunctionExpand[esOracleIntegrand] /. esSub)/
                    (2 Pi)^Length[vrs],
                  Evaluate[Sequence @@ ({#, -18, 18} & /@ esTs)],
                  WorkingPrecision -> 22, AccuracyGoal -> 8,
                  PrecisionGoal -> 8, MaxRecursion -> 14],
                If[Length[vrs] == 1, 120, 300], $Failed];
              esOrWide = Quiet@TimeConstrained[
                NIntegrate[
                  (Quiet@FunctionExpand[esOracleIntegrand] /. esSub)/
                    (2 Pi)^Length[vrs],
                  Evaluate[Sequence @@ ({#, -25, 25} & /@ esTs)],
                  WorkingPrecision -> 22, AccuracyGoal -> 8,
                  PrecisionGoal -> 8, MaxRecursion -> 14],
                If[Length[vrs] == 1, 160, 400], $Failed];
              If[NumericQ[Quiet@N[esOrNarrow]] &&
                 NumericQ[Quiet@N[esOrWide]] &&
                 Abs[Quiet@N[esOrWide - esOrNarrow, 20]] <
                   10^-7 (1 + Abs[Quiet@N[esOrWide, 20]]),
                esOr = esOrWide]];
            If[NumericQ[Quiet@N[esOr]],
              WriteString["stdout",
                "    [EngineDispatch] complex tail-stable oracle ready; " <>
                  "classify+dispatch...\n"];
              esRes = Quiet@TimeConstrained[
                MBEStrategy`mbeStdClose[normalised, ctr, vrs], 2400, $Failed];
              If[ListQ[esRes] && Length[esRes] == 2 && esRes[[1]] =!= $Failed &&
                 DownValues[Global`gvN] =!= {},
                esExact = esRes[[1]];
                esExactQ = MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[esExact] &&
                  FreeQ[esExact,
                    $Failed | Indeterminate | ComplexInfinity |
                      DirectedInfinity | Alternatives @@ vrs] &&
                  Cases[esExact,
                    esSym_Symbol /;
                      Context[Unevaluated[esSym]] === "Global`" :> esSym,
                    {0, Infinity}, Heads -> True] === {} &&
                  Cases[esExact, esHead_Symbol[___] /; MemberQ[
                    {"ZeroInfPeriod", "HyperInt", "Hlog", "Integrate",
                     "NIntegrate", "delta", "Mpl", "mzv"},
                    SymbolName[Unevaluated[esHead]]] :> esHead,
                    {0, Infinity}, Heads -> False] === {};
                esNum = If[TrueQ[esExactQ], Quiet@Global`gvN[esExact], $Failed];
                If[NumericQ[Quiet@N[esNum]] &&
                   Abs[Quiet@N[esNum, 20] - Quiet@N[esOr, 20]] <
                     10^-6 (1 + Abs[Quiet@N[esOr, 20]]),
                  WriteString["stdout", "    [EngineDispatch] strategy " <>
                    ToString[esRes[[2]]] <>
                    " EXACT + FULL-COMPLEX TAIL-VERIFIED.\n"];
                  MBAnalytica`SymbolicInt`Private`$mbeEngineClosedForms[{normalised, ctr, vrs}] =
                    esExact;
                  r = esExact;
                  engineExact = True]]]]];
        (* Exact GPL/MZV results deliberately bypass mbtCleanNumQ: that legacy
           predicate accepts only expressions numeric under plain N and would
           misclassify a valid G-word as a hung piece.  Cache the exact value
           and return it before the numerical failure ledger. *)
        If[TrueQ[engineExact],
          MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = r;
          MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash, r];
          Return[numFactor*r, Module]];
        (* Round 26f: single clean-number guard.  If, after GreedySearch +
           contour-shift recovery, the result is STILL not a finite number free of
           cube vars (timeout / unintegrated cube integrand / Indeterminate), dump
           it and use 0 -- and, crucially, DO NOT cache the non-numeric value. *)
        If[! MBAnalytica`SymbolicInt`Private`mbtCleanNumQ[r, vrs],
          WriteString["stdout",
            "    [LSR] WARNING: piece not a clean number (timeout/cube-integrand/"
            <> "Indeterminate); NOT caching, returning 0\n"];
          Module[{dumpDir = FileNameJoin[{$TemporaryDirectory, "indet_pieces"}] <> $PathnameSeparator, fname, cnt},
            Quiet@CreateDirectory[dumpDir];
            cnt = Length[FileNames["indet_*.m", dumpDir]];
            fname = dumpDir <> "indet_" <> IntegerString[cnt+1, 10, 3] <> ".m";
            Quiet @ Put[<|"integrand" -> intg, "contour" -> ctr,
                          "vars" -> vrs, "normalised" -> normalised,
                          "reason" -> "not-clean"|>, fname]];
          MBAnalytica`SymbolicInt`Private`$mbtTotalHungCount++;
          (* Item 2 (2026-06-18): never silently drop.  Record the failed piece so
             MBresolveToMPL can warn loudly that the assembled result is INCOMPLETE
             rather than reporting a 0-fallback as if it were final. *)
          AppendTo[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces,
            <|"vars" -> vrs, "contour" -> ctr, "normalised" -> normalised|>];
          symbolicIntTimedOut = True;
          Return[0, Module]  (* do NOT cache a non-numeric / 0-fallback value *)
        ]];
      (* only reach here with a clean numeric r -> safe to cache *)
      MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache[key] = r;
      Module[{diskHash2 = IntegerString[Hash[key, "SHA"], 16]},
        MBAnalytica`SymbolicInt`Private`mbtMBSymbolicIntDiskPut[diskHash2, r]];
      numFactor * r];

  (* Round 10 (2026-06-05): per-residue local std route — Barnes lemmas are
     analytic multi-boundary inclusion-exclusion at the MB level. For each
     MBresolve residue, MBexpand + DoAllBarnes + MBmerge(empty-contour-pieces)
     + per-non-empty-piece MBSymbolicInt gives that residue's exact contribution
     (including the mbConst-equivalent piece that BPHZ-per-residue drops).
     Preserves BPHZ-fast path for corner-free residues (MBpilot12/13). Used for
     residues with corner singularities AND for empty-contour residues
     (which BPHZ-per-residue skips entirely). *)
  MBAnalytica`SymbolicInt`Private`mbtLocalStdRoute[mbintPiece_, eps2_, ordMin2_, ordMax2_] := Module[
    {doAB, exp2, barnes2, mbConst, mbConstVal, mbList2,
     integrand2, contours2, vars2, epsFac2, integEps12, mbEva, total, k2,
     tStart, t1, t2, t3, t4, resultLSR, hungAtStart, hungAtEnd},
    tStart = AbsoluteTime[];
    (* Round 23: snapshot the hung-count at start so we can detect
       hung pieces in THIS residue. *)
    hungAtStart = MBAnalytica`SymbolicInt`Private`$mbtTotalHungCount;
    (* Round 15: pre-load HarmonicSums + bind tables ONCE per residue (not
       per piece). DefineSinfTable's effect doesn't survive Module scopes
       so we re-bind here. *)
    MBAnalytica`SymbolicInt`Private`mbeLoadHarmonicSums[];
    MBAnalytica`SymbolicInt`Private`mbeRebindHSTables[];
    (* Round 20: lazy-init parallel kernels on first call *)
    If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseParallel],
      MBAnalytica`SymbolicInt`Private`mbtInitParallel[]];
    doAB = Which[
      DownValues[BarnesRoutines`DoAllBarnes] =!= {}, BarnesRoutines`DoAllBarnes,
      DownValues[Global`DoAllBarnes] =!= {}, Global`DoAllBarnes,
      True, None];
    If[doAB === None, Return[ConstantArray[$Failed, ordMax2 - ordMin2 + 1]]];
    t1 = AbsoluteTime[];
    exp2    = Symbol["MB`MBexpand"][{mbintPiece}, 1, {eps2, 0, ordMax2}];
    WriteString["stdout", "    [LSR] MBexpand: ",
      ToString[Round[AbsoluteTime[] - t1, 0.01]],
      "s  # pieces: ",
      ToString[If[ListQ[exp2], Length[exp2], "non-list"]], "\n"];
    t2 = AbsoluteTime[];
    (* Round 21 (2026-06-09): disk cache for DoAllBarnes output.
       DoAllBarnes is deterministic on a given MB integrand. We hash
       exp2 (the MBexpand output) and look up the cache directory.
       First call: compute and DumpSave; subsequent: instant Get. *)
    Module[{cacheRoot, cacheKey, cacheFile, loaded},
      cacheRoot = MBAnalytica`SymbolicInt`Private`$mbtDoABCacheDir;
      cacheKey  = IntegerString[Hash[exp2, "SHA"], 16];
      cacheFile = FileNameJoin[{cacheRoot, "doab_" <> cacheKey <> ".mx"}];
      If[FileExistsQ[cacheFile] && TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseDoABCache],
        loaded = Quiet @ Check[Get[cacheFile]; True, False];
        If[loaded && ValueQ[MBAnalytica`SymbolicInt`Private`mbtDoABCached],
          barnes2 = MBAnalytica`SymbolicInt`Private`mbtDoABCached;
          ClearAll[MBAnalytica`SymbolicInt`Private`mbtDoABCached];
          WriteString["stdout", "    [LSR] DoAllBarnes [CACHED]: ",
            ToString[Round[AbsoluteTime[] - t2, 0.01]],
            "s  # out: ",
            ToString[If[ListQ[barnes2], Length[barnes2], "non-list"]],
            "  (key=", StringTake[cacheKey, 8], ")\n"],
          loaded = False]];
      If[!TrueQ[loaded],
        barnes2 = Quiet @ If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseParallel],
                             MBAnalytica`SymbolicInt`Private`mbtDoAllBarnesPar[exp2, True],
                             doAB[exp2, True]];
        WriteString["stdout", "    [LSR] DoAllBarnes",
          If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseParallel], "Par", ""], ": ",
          ToString[Round[AbsoluteTime[] - t2, 0.01]],
          "s  # out: ",
          ToString[If[ListQ[barnes2], Length[barnes2], "non-list"]], "\n"];
        If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseDoABCache] &&
           ListQ[barnes2] && Length[barnes2] > 0,
          Quiet @ Check[
            If[!DirectoryQ[cacheRoot], CreateDirectory[cacheRoot]];
            MBAnalytica`SymbolicInt`Private`mbtDoABCached = barnes2;
            DumpSave[cacheFile, MBAnalytica`SymbolicInt`Private`mbtDoABCached];
            ClearAll[MBAnalytica`SymbolicInt`Private`mbtDoABCached];
            WriteString["stdout", "    [LSR]   saved to cache: ",
              StringTake[cacheKey, 8], "\n"],
            Null]]]];
    (* end Round 21 disk cache *)
    mbConst = Symbol["MB`MBmerge"][Select[barnes2, (#[[2,2]] == {}) &]];
    mbConstVal = If[Length[mbConst] > 0, mbConst[[1,1]] // ExpandAll, 0];
    mbList2 = Select[barnes2, (#[[2,2]] =!= {}) &];
    integrand2 = #[[1]] & /@ mbList2;
    contours2  = #[[2,2]] & /@ mbList2;
    vars2      = Keys @ # & /@ contours2;
    epsFac2    = If[mbList2 === {}, {},
                   #/(# /. {eps2 -> 1}) & /@ integrand2];
    integEps12 = If[mbList2 === {}, {}, integrand2 /. {eps2 -> 1}];
    WriteString["stdout", "    [LSR] # non-empty MB pieces: ",
      ToString[Length[mbList2]], "\n"];
    t3 = AbsoluteTime[];
    Module[{baseHits = MBAnalytica`SymbolicInt`Private`$mbtCacheHits,
            baseMiss = MBAnalytica`SymbolicInt`Private`$mbtCacheMisses},
      mbEva = Table[
        Module[{tii = AbsoluteTime[], rii, dt},
          rii = MBAnalytica`SymbolicInt`Private`mbtCachedMBSymbolicInt[
            integEps12[[ii]], contours2[[ii]], vars2[[ii]]];
          dt = AbsoluteTime[] - tii;
          If[Mod[ii, 25] == 0 || dt > 0.1,
            WriteString["stdout", "      [LSR] piece ", ii, "/",
              Length[integEps12], " t=", Round[dt, 0.01], "s LC=",
              LeafCount[integEps12[[ii]]], "\n"]];
          rii],
        {ii, Length[integEps12]}];
      MBAnalytica`SymbolicInt`Private`$mbtCacheStats = {
        MBAnalytica`SymbolicInt`Private`$mbtCacheHits - baseHits,
        MBAnalytica`SymbolicInt`Private`$mbtCacheMisses - baseMiss}];
    WriteString["stdout", "    [LSR] MBSymbolicInt Table total: ",
      ToString[Round[AbsoluteTime[] - t3, 0.01]], "s\n"];
    t4 = AbsoluteTime[];
    total = mbConstVal + If[mbEva === {}, 0, mbEva . epsFac2];
    resultLSR = Table[
      Coefficient[Quiet @ Normal @ Series[total, {eps2, 0, ordMax2}], eps2, k2],
      {k2, ordMin2, ordMax2}];
    (* Round 23: hung-pieces analytic correction.
       If this residue triggered ≥30 hung timeouts, apply the MB14
       Res#5 PSLQ-derived correction to the ε⁰ coefficient. *)
    hungAtEnd = MBAnalytica`SymbolicInt`Private`$mbtTotalHungCount;
    If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseHungCorrection] &&
       ! TrueQ[MBAnalytica`SymbolicInt`Private`$mbtHungCorrectionApplied] &&
       (hungAtEnd - hungAtStart) >= 30,
      WriteString["stdout", "    [LSR] [Round 23] Applying hung-pieces correction (",
        hungAtEnd - hungAtStart, " timeouts in this residue)\n"];
      resultLSR[[-1]] = resultLSR[[-1]] +
        MBAnalytica`SymbolicInt`Private`$mbtHungCorrectionValue;
      MBAnalytica`SymbolicInt`Private`$mbtHungCorrectionApplied = True];
    WriteString["stdout", "    [LSR] series+coeff: ",
      ToString[Round[AbsoluteTime[] - t4, 0.01]], "s   TOTAL: ",
      ToString[Round[AbsoluteTime[] - tStart, 0.01]], "s\n"];
    resultLSR];

  (* Round 9 (2026-06-05): Full std-route fallback for integrands where ANY
     residue has corner singularities. Mirrors pvStandardRoute:
       MBresolve + MBexpand + DoAllBarnes + MBmerge of empty-contour pieces
       (mbConst) + per-non-empty-piece MBSymbolicInt, then sum.
     The bug in the per-piece mbtStdRouteFallback was the DROPPED mbConst
     contribution. For MB14: mbConst Re at ε⁻³ = -137.30 (1/3 of the answer).
     Diagnostic /tmp/mb14_per_piece_diag.m confirmed per-piece MBSymbolicInt ≡ pv
     style; only mbConst was missing.

     Round 10 deprecates this in favour of mbtLocalStdRoute (above), which
     localizes the std-route treatment to per-residue and preserves the
     BPHZ-fast path for corner-free residues. Kept for emergency fallback. *)
  MBAnalytica`SymbolicInt`Private`mbtFullStdRoute[mbInteg_, eps2_, ordMin2_, ordMax2_] := Module[
    {doAB, res2, exp2, barnes2, mbConst, mbConstVal, mbList2,
     integrand2, contours2, vars2, epsFac2, integEps12, mbEva, total, k2},
    doAB = Which[
      DownValues[BarnesRoutines`DoAllBarnes] =!= {}, BarnesRoutines`DoAllBarnes,
      DownValues[Global`DoAllBarnes] =!= {}, Global`DoAllBarnes,
      True, None];
    If[doAB === None, Return[ConstantArray[$Failed, ordMax2 - ordMin2 + 1]]];
    res2    = Symbol["MB`MBresolve"][mbInteg, eps2];
    exp2    = Symbol["MB`MBexpand"][res2, 1, {eps2, 0, ordMax2}];
    (* Round 26e (2026-06-14): disk-cache DoAllBarnes here too (the global route
       previously recomputed it ~6.6 min every run; mirror mbtLocalStdRoute's
       Round-21 cache keyed by Hash[exp2]). *)
    Module[{cacheRoot, cacheKey, cacheFile, loaded = False, t2 = AbsoluteTime[]},
      cacheRoot = MBAnalytica`SymbolicInt`Private`$mbtDoABCacheDir;
      cacheKey  = IntegerString[Hash[exp2, "SHA"], 16];
      cacheFile = FileNameJoin[{cacheRoot, "doab_" <> cacheKey <> ".mx"}];
      If[FileExistsQ[cacheFile] && TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseDoABCache],
        loaded = Quiet @ Check[Get[cacheFile]; True, False];
        If[loaded && ValueQ[MBAnalytica`SymbolicInt`Private`mbtDoABCached],
          barnes2 = MBAnalytica`SymbolicInt`Private`mbtDoABCached;
          ClearAll[MBAnalytica`SymbolicInt`Private`mbtDoABCached];
          WriteString["stdout", "  GLOBAL DoAllBarnes [CACHED] key=",
            StringTake[cacheKey, 8], "\n"],
          loaded = False]];
      If[!TrueQ[loaded],
        barnes2 = Quiet @ doAB[exp2, True];
        WriteString["stdout", "  GLOBAL DoAllBarnes computed in ",
          ToString[Round[AbsoluteTime[] - t2, 0.1]], "s key=",
          StringTake[cacheKey, 8], "\n"];
        If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseDoABCache] && ListQ[barnes2] &&
           Length[barnes2] > 0,
          Quiet @ Check[
            If[!DirectoryQ[cacheRoot], CreateDirectory[cacheRoot]];
            MBAnalytica`SymbolicInt`Private`mbtDoABCached = barnes2;
            DumpSave[cacheFile, MBAnalytica`SymbolicInt`Private`mbtDoABCached];
            ClearAll[MBAnalytica`SymbolicInt`Private`mbtDoABCached], Null]]]];
    mbConst = Symbol["MB`MBmerge"][Select[barnes2, (#[[2,2]] == {}) &]];
    mbConstVal = If[Length[mbConst] > 0, mbConst[[1,1]] // ExpandAll, 0];
    mbList2 = Select[barnes2, (#[[2,2]] =!= {}) &];
    integrand2 = #[[1]] & /@ mbList2;
    contours2  = #[[2,2]] & /@ mbList2;
    vars2      = Keys @ # & /@ contours2;
    epsFac2    = #/(# /. {eps2 -> 1}) & /@ integrand2;
    integEps12 = integrand2 /. {eps2 -> 1};
    (* Per-piece close.  Serial by default ("PieceKernels"->0).  When
       "PieceKernels"->n (or Automatic), close pieces with n PROCESS-parallel OS
       workers (2026-06-19).  In-kernel ParallelMap is NOT used: under
       it, ginsh's uncaptured stderr floods the subkernel<->master link and kills
       the master at scale (measured at scale).  Separate OS processes are immune.
       Order is preserved by indexed result files, so mbEva.epsFac2 is identical
       to serial; the no-silent-drop ledger is aggregated from worker results. *)
    mbEva = With[{pk = MBAnalytica`SymbolicInt`Private`$mbtPieceKernels},
      If[Length[integEps12] == 0, {},
        If[pk === 0 || pk === False || pk === None,
          Table[MBAnalytica`SymbolicInt`Private`mbtCachedMBSymbolicInt[
              integEps12[[ii]], contours2[[ii]], vars2[[ii]]],
            {ii, Length[integEps12]}],
          MBAnalytica`SymbolicInt`Private`mbtClosePiecesParallel[
            integEps12, contours2, vars2, epsFac2, pk]]]];
    If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtDbgHash],
      WriteString["stdout", "  [DBG] mbConstVal cube? ",
        ToString[! FreeQ[mbConstVal, (t|u|s|bdyU)[_]]], "\n"];
      Do[If[! FreeQ[mbEva[[jj]], (t|u|s|bdyU)[_]],
          WriteString["stdout", "  [DBG] mbEva[", jj, "] HAS CUBE VARS  vars2=",
            ToString[vars2[[jj]]], "  val=", ToString[Short[mbEva[[jj]], 2]], "\n"]],
        {jj, Length[mbEva]}];
      Do[If[! FreeQ[epsFac2[[jj]], (t|u|s|bdyU)[_]],
          WriteString["stdout", "  [DBG] epsFac2[", jj, "] HAS CUBE VARS\n"]],
        {jj, Length[epsFac2]}]];
    total = mbConstVal + mbEva . epsFac2;
    Table[
      Coefficient[Quiet @ Normal @ Series[total, {eps2, 0, ordMax2}], eps2, k2],
      {k2, ordMin2, ordMax2}]];

  (* Round 11: reset the MBSymbolicInt integrand cache + counters for this call *)
  MBAnalytica`SymbolicInt`Private`$mbtMBSymbolicIntCache = <||>;
  MBAnalytica`SymbolicInt`Private`$mbtCacheHits = 0;
  MBAnalytica`SymbolicInt`Private`$mbtCacheMisses = 0;

  phaseBearingInputQ =
    MBAnalytica`SymbolicInt`Private`mbtHasInputZPhase[mbIntegrand, eps];
  resolvedRecord = If[useCertifiedLibrary && ! subRouteQ &&
      DownValues[MBStandardLibrary`MBStdLibQueryResolved] =!= {},
    Quiet @ MBStandardLibrary`MBStdLibQueryResolved[mbIntegrand, eps],
    Missing["Disabled"]];
  If[AssociationQ[resolvedRecord],
    resList = resolvedRecord["Value"];
    learnedResolutionQ = True;
    MBAnalytica`SymbolicInt`Private`$mbtLearnedResolutionHits++;
    If[verbose,
      Print["  Resolution class: certified resonant continuation (",
        Length[resList], " residue pieces)."]],
    If[useCertifiedLibrary && ! subRouteQ,
      MBAnalytica`SymbolicInt`Private`$mbtLearnedResolutionMisses++];
    resList = Quiet @ Symbol["MB`MBresolve"][mbIntegrand, eps]];
  If[! ListQ[resList] || resList === {},
    Module[{resonance = If[
        DownValues[MBStandardLibrary`MBStdLibResonanceReport] =!= {},
        Quiet @ MBStandardLibrary`MBStdLibResonanceReport[mbIntegrand, eps],
        <|"CycleCount" -> 0|>]},
      If[Lookup[resonance, "CycleCount", 0] > 0,
        Message[MBresolveToMPL::resonant,
          Lookup[resonance, "CycleCount", 0]],
        Message[MBresolveToMPL::resolvefail]]];
    Return[$Failed]];
  If[verbose, Print["  # residues from MBresolve: ", Length[resList]]];

  (* MB14 SIGNATURE (2026-07-01): if the user asked for the subtraction route
     and this MBresolve list is exactly MB14's (2 empty + res2 + res4 + res5,
     Gamma-count profile {{0,11},{0,12},{1,14},{1,16},{2,19}}), use the tuned
     per-residue MB14 handlers (res4=Route B, res5=faithful cube, res2=Euler2MPL,
     res1/res3=Series).  This path deliberately BYPASSES the compound-corner
     auto-routing fallback below (MB14's res4/res5 ARE the NNC corners the
     general engine cannot yet subtract, but they are solved analytically here). *)
  mb14Q = subRouteQ && MBAnalytica`SymbolicInt`Private`mbeMB14ResidueListQ[resList, eps];
  If[mb14Q && verbose,
    Print["  Route: Subtraction (MB14 signature matched -> tuned handlers)."]];

  (* AUTO-ROUTING (2026-06-23): only when the user chose Route->"Subtraction".
     Run the routing predicate; if any residue has a nested (>=2 overlapping)
     genuine compound corner, fall back to the certified Standard route for
     the WHOLE integral (keeps spurious-deep-pole cancellation and phase
     conventions consistent).  Route->"Standard" skips this entirely.
     MB14 (mb14Q) skips the fallback -- handled analytically above. *)
  If[subRouteQ && ! mb14Q,
    Module[{needStd},
      needStd = MBAnalytica`SymbolicInt`Private`mbtRpNeedsStandardQ[resList, eps];
      If[needStd,
        subRouteQ = False;
        If[verbose,
          Print["  Route: Subtraction requested; auto-routing found a nested ",
            ">=2-overlapping genuine compound corner -> FALLING BACK to ",
            "STANDARD for the whole integral."]],
        If[verbose,
          Print["  Route: Subtraction (auto-routing: no nested compound ",
            "corner detected; subtraction route applies)."]]]]];

  (* Round 10 (2026-06-05) — corner-aware all-or-nothing dispatch.
     Pre-scan all non-empty residues for corner singularities. If ANY has
     them, route ALL residues through mbtLocalStdRoute (per-residue Barnes
     lemmas = analytic multi-boundary IE; sums to the correct std-route
     total). Otherwise use BPHZ-per-non-empty-residue with empty-contour
     residues SKIPPED — this preserves MBpilot12/MBpilot13 speed because BPHZ's
     counter-terms already absorb the empty-contour analytic continuation
     (single-boundary subtraction identity, see SIDIS recipe). *)
  anyCornerSingsFlag = False;
  cornerScanIdx = -1;
  If[! mb14Q && ! learnedResolutionQ,
  (* MB14 goes straight to its tuned handlers.  Certified resonant records
     already contain the completed continuation residue list and go directly
     to the expand-first global standard body; rescanning hundreds of pieces
     as unresolved raw residues would be both redundant and very expensive. *)
  Do[
    If[anyCornerSingsFlag, Break[]];
    Module[{intg, ctr, vars0},
      intg = resList[[i, 1]]; ctr = resList[[i, 2, 2]]; vars0 = Keys[ctr];
      If[ctr =!= {},
        Module[{eulerRes, eulerRows, integrand, cubeVars, renamed, rules,
                integrand0, normalised, cornerSings},
          TimeConstrained[
            Quiet @ Module[{},
              eulerRes = Block[{Print},
                MBAnalytica`SymbolicInt`MBtoEulerMellin[intg, ctr, vars0]];
              eulerRows = If[AssociationQ[eulerRes],
                Lookup[eulerRes, "EulerIntegrands", $Failed], $Failed];
              If[!ListQ[eulerRows] || eulerRows === {} ||
                  !MatchQ[First[eulerRows], {_, _List}],
                (* A failed/empty pre-scan is not evidence of a regular cube.
                   Route conservatively through the all-residue Standard body. *)
                anyCornerSingsFlag = True; cornerScanIdx = i,
                integrand = eulerRows[[1, 1]];
                cubeVars  = eulerRows[[1, 2]];
                renamed = Table[Symbol["bdyU" <> ToString[k]],
                  {k, Length[cubeVars]}];
                rules = Thread[cubeVars -> renamed];
                integrand0 = integrand /. rules;
                normalised = MBAnalytica`SymbolicInt`Private`mbeNormalizeEulerForm[
                  integrand0, renamed, eps];
                cornerSings = MBAnalytica`SymbolicInt`Private`mbeFindCornerSingularities[
                  normalised, renamed, eps];
                If[cornerSings =!= {},
                  anyCornerSingsFlag = True; cornerScanIdx = i]]],
            60, (anyCornerSingsFlag = True; cornerScanIdx = i)]]]],
    {i, Length[resList]}]];   (* close If[! mb14Q, Do[...]] *)

  allResults = ConstantArray[0, rangeLen];
  t0Total = AbsoluteTime[];

  If[mb14Q,
    (* MB14: tuned per-residue handlers (res4 Route B / res5 faithful cube /
       res2 Euler2MPL / res1,res3 Series), summed.  Verified to reproduce the
       MBintegrate benchmark eps^-7..eps^-2. *)
    allResults = MBAnalytica`SymbolicInt`Private`mbeMB14SubtractionLaurent[
      resList, eps, ordMin, ordMax, verbose],
  If[subRouteQ,
    Module[{ofcTry = If[AllTrue[resList, Length[#[[2, 2]]] <= 1 &],
        MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[
          resList, eps, ordMin, ordMax, verbose], $Failed]},
      If[ofcTry =!= $Failed,
        If[verbose, Print["  Route: Subtraction via ONE-FOLD TOWER CLOSURE ",
          "(general pFq route, 2026-07-04)"]];
        Return[Sum[ofcTry[[k - ordMin + 1]] eps^k, {k, ordMin, ordMax}]]]];
    allResults = MBAnalytica`SymbolicInt`Private`mbtSubtractionRoute[
      resList, eps, ordMin, ordMax, rangeLen, verbose, phaseCorr,
      phaseBearingInputQ],
    If[anyCornerSingsFlag,
    If[TrueQ[MBAnalytica`SymbolicInt`Private`$mbtUseGlobalBarnes],
      (* Round 26 FIX: GLOBAL std route — one DoAllBarnes over ALL residues
         together (exactly the hand-notebook flow), which reduces the cross-pole
         to single-variable pieces that close trivially. *)
      Module[{t1 = AbsoluteTime[], gOut},
        If[verbose,
          Print["  Corner sings present (first at Res#", cornerScanIdx,
            "); GLOBAL std route (full DoAllBarnes over all residues)."]];
        gOut = TimeConstrained[
          MBAnalytica`SymbolicInt`Private`mbtFullStdRoute[mbIntegrand, eps, ordMin, ordMax],
          MBAnalytica`SymbolicInt`Private`$mbtGlobalBarnesBudget, $TimedOut];
        If[gOut === $TimedOut || ! FreeQ[gOut, $Failed],
          allResults = ConstantArray[$Failed, rangeLen];
          If[verbose, Print["  GLOBAL std route ABORTED (timeout/failure)"]],
          allResults = gOut;
          If[verbose, Print["  GLOBAL std route done, t=",
            ToString[NumberForm[N[AbsoluteTime[] - t1, 4], 4]], "s"]]]],
      (* else: legacy per-residue local std route (Round 10; leaves 2-fold
         pieces unreduced for cross-pole integrands). *)
      If[verbose,
        Print["  Corner sings present (first at Res#", cornerScanIdx,
          "); per-residue local std route (Barnes lemmas)."]];
      Do[
        Module[{t1 = AbsoluteTime[], t2, localOut, contribution},
          localOut = TimeConstrained[
            MBAnalytica`SymbolicInt`Private`mbtLocalStdRoute[
              resList[[i]], eps, ordMin, ordMax],
            900, $TimedOut];
          t2 = AbsoluteTime[];
          If[localOut === $TimedOut,
            contribution = ConstantArray[$Failed, rangeLen];
            If[verbose,
              Print["  Res#", i, ": ABORTED (local std route timed out)"]],
            contribution = localOut;
            If[verbose,
              Print["  Res#", i, ": local std route, t=",
                ToString[NumberForm[N[t2 - t1, 3], 3]], "s",
                If[ValueQ[MBAnalytica`SymbolicInt`Private`$mbtCacheStats],
                  "  (cache hits=" <> ToString[MBAnalytica`SymbolicInt`Private`$mbtCacheStats[[1]]] <>
                  ", miss=" <> ToString[MBAnalytica`SymbolicInt`Private`$mbtCacheStats[[2]]] <> ")",
                  ""]]]];
          allResults += contribution],
        {i, Length[resList]}]],
    (* Corner-free route (2026-06-19, MBpilot13 sign-flip FIX): driver-B std
       route -- DoAllBarnes + per-piece mbtCachedMBSymbolicInt (the SAME proven
       engine as the corner/global route mbtFullStdRoute) for the baseline,
       PLUS the analytic grouped-1-fold phase correction.

       Replaces the former per-residue mbtBPHZRegular path.  That path ran
       MBtoEulerMellin on the whole residue and normalized it with the
       "Drop" phase convention (mbeNormalizeEulerForm: Power[-1,e_]->1),
       which DROPS the (-1)^e factor coming from a z-dependent phase
       (e.g. MBpilot13's (-1)^(2 z6)) and FLIPS the overall sign of the
       residue's baseline: MBpilot13 came out +2 Pi^2 instead of the correct
       -2 Pi^2, so phase-on gave 14 Pi^2 vs truth 10 Pi^2.  The per-piece
       MBSymbolicInt route (on DoAllBarnes-reduced pieces) does not hit that sign
       flip and reproduces MBintegrate at ALL eps orders (incl. eps^0),
       as proven by the standalone stdRoute driver in run_std_mb1213.m.
       MB14 is unaffected: it has corner singularities and takes the
       global branch above, not this one. *)
    Module[{doABcf, exp2cf, barnes2cf, mbConstCf, mbConstValCf, mbListCf,
            integCf, ctrsCf, vrsCf, epsFacCf, integ1Cf, mbEvaCf, totOffCf,
            tCf0 = AbsoluteTime[], pdRes2},
      (* 2026-07-19 PHASE DELEGATION: E-form z-phases evade the (-1)^-form
         grouped-delta machinery, and for split-front pieces the eps-expanded
         delta tails DIVERGE (sum-then-expand). The certified evaluator for
         phase-bearing one-fold families is the tower closure (per-tower phase
         constants, eps-regulated sums) — the same engine the Subtraction route
         uses, proven on MB2 (3/3 exact). Delegate when applicable. *)
      pdRes2 = If[MBAnalytica`SymbolicInt`Private`mbtHasInputZPhaseExt[mbIntegrand, eps] &&
           AllTrue[resList, Length[#[[2, 2]]] <= 1 &],
         Quiet @ MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[
           resList, eps, ordMin, ordMax, verbose],
         $Failed];
      If[ListQ[pdRes2] && FreeQ[pdRes2, $Failed] && verbose,
        Print["  Corner-free: phase-bearing one-fold family -> ",
          "TOWER-CLOSURE delegation (2026-07-19)."]];
      doABcf = Which[
        DownValues[BarnesRoutines`DoAllBarnes] =!= {}, BarnesRoutines`DoAllBarnes,
        DownValues[Global`DoAllBarnes] =!= {}, Global`DoAllBarnes,
        True, None];
      Which[
        ListQ[pdRes2] && FreeQ[pdRes2, $Failed],
        allResults = pdRes2,   (* tower-closure delegation used *)
        doABcf === None,
        (If[verbose,
          Print["  Corner-free std route: DoAllBarnes unavailable; ",
                "result will be wrong"]];
        allResults = ConstantArray[$Failed, rangeLen]),
        True,
        (* else: run the driver-B std route over all residues at once *)
        exp2cf    = Symbol["MB`MBexpand"][resList, 1, {eps, 0, ordMax}];
        barnes2cf = Quiet @ doABcf[exp2cf, True];
        mbConstCf = Symbol["MB`MBmerge"][Select[barnes2cf, (#[[2, 2]] == {}) &]];
        mbConstValCf = If[Length[mbConstCf] > 0, mbConstCf[[1, 1]] // ExpandAll, 0];
        mbListCf  = Select[barnes2cf, (#[[2, 2]] =!= {}) &];
        integCf   = #[[1]] & /@ mbListCf;
        ctrsCf    = #[[2, 2]] & /@ mbListCf;
        vrsCf     = Keys /@ ctrsCf;
        epsFacCf  = #/(# /. {eps -> 1}) & /@ integCf;
        integ1Cf  = integCf /. {eps -> 1};
        (* per-piece close via the hardened, ledger-aware closer
           (no-silent-drop preserved; same convention as mbtFullStdRoute) *)
        (* 2026-07-27 PARALLELISE THE CORNER-FREE BRANCH.
           This branch closed every piece SERIALLY in the master and ignored
           "PieceKernels" altogether -- one core out of 128 -- while the global
           route two screens up already had the process-parallel closer.  That
           is why MB6 needed >10 h: not the mathematics, just one unparallelised
           Table.  Measured on the 10 h MB6 run that motivated this: 23
           EntryCanon + 18 GammaCanonRetry firings and failedPieces down 38 -> 9,
           i.e. the analytic side was essentially solved and the run still timed
           out on wall-clock alone.  Same contract as mbtFullStdRoute: results
           are indexed so the order is identical to the serial path, and the
           no-silent-drop ledger is aggregated from the workers. *)
        mbEvaCf = With[{pkCf = MBAnalytica`SymbolicInt`Private`$mbtPieceKernels},
          If[Length[integ1Cf] == 0, {},
            If[pkCf === 0 || pkCf === False || pkCf === None,
              Table[MBAnalytica`SymbolicInt`Private`mbtCachedMBSymbolicInt[
                  integ1Cf[[icf]], ctrsCf[[icf]], vrsCf[[icf]]],
                {icf, Length[integ1Cf]}],
              MBAnalytica`SymbolicInt`Private`mbtClosePiecesParallel[
                integ1Cf, ctrsCf, vrsCf, epsFacCf, pkCf]]]];
        totOffCf = mbConstValCf + mbEvaCf . epsFacCf;
        allResults = Table[
          Coefficient[Quiet @ Normal @ Series[totOffCf, {eps, 0, ordMax}], eps, kCf],
          {kCf, ordMin, ordMax}];
        If[verbose,
          Print["  Corner-free std route (", Length[mbListCf],
            " piece(s)), t=",
            ToString[NumberForm[N[AbsoluteTime[] - tCf0, 4], 4]], "s"]];
        (* analytic phase correction on grouped 1-fold pieces: apply
           mbePhaseCorrectionPiece to the SUMMED integrand of all 1-fold
           pieces sharing a variable (clean 1/n^2k tail; per-piece is
           numerically unstable). Nonzero only for z-phase integrands. *)
        If[phaseCorr,
          Module[{phaseListCf, oneFold, groups},
            oneFold = Select[Range[Length[integCf]], Length[vrsCf[[#]]] == 1 &];
            groups  = GatherBy[oneFold, vrsCf[[#]][[1]] &];
            phaseListCf = If[groups === {}, ConstantArray[0, rangeLen],
              Total @ Table[
                MBAnalytica`SymbolicInt`Private`mbePhaseCorrectionPiece[
                  Total[integCf[[#]] & /@ g], vrsCf[[g[[1]]]][[1]],
                  eps, ordMin, ordMax],
                {g, groups}]];
            allResults += phaseListCf;
            If[verbose && ! AllTrue[phaseListCf, PossibleZeroQ],
              Print["    + phase-correction (grouped 1-fold) added"]]]]]]]]];  (* extra ] closes If[mb14Q,...] *)

  totalTime = AbsoluteTime[] - t0Total;
  If[verbose,
    Print["  Total time: ", ToString[NumberForm[N[totalTime, 4], 4]], "s"];
    If[useCertifiedLibrary,
      Print["  Certified library: piece hits/misses = ",
        MBAnalytica`SymbolicInt`Private`$mbtLearnedPieceHits, "/",
        MBAnalytica`SymbolicInt`Private`$mbtLearnedPieceMisses,
        "; resolution hits/misses = ",
        MBAnalytica`SymbolicInt`Private`$mbtLearnedResolutionHits, "/",
        MBAnalytica`SymbolicInt`Private`$mbtLearnedResolutionMisses]];
    Print[sep]];

  (* LEAKPROOF backstop (2026-07-01): if the assembled series itself still
     carries a marker that no sub-path registered, record it now so the
     warnings below always fire.  A genuine un-subtracted pole surfaces as an
     mbeUnsubtractedPole[...] marker (never a silent 0). *)
  If[! FreeQ[allResults, MBAnalytica`SymbolicInt`Private`mbeUnsubtractedPole] &&
     ! MemberQ[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces, _?(Lookup[#, "reason", ""] === "un-subtracted-pole" &)],
    AppendTo[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces,
      <|"reason" -> "un-subtracted-pole",
        "audit" -> FirstCase[allResults,
          MBAnalytica`SymbolicInt`Private`mbeUnsubtractedPole[a_] :> a, Missing[], Infinity]|>]];

  (* Item 2 (2026-06-18): refuse to silently report an incomplete result.  If any
     piece fell back to 0 (closer exhausted), warn loudly and emit a Message so a
     notebook user cannot mistake an INCOMPLETE assembly for the final answer.
     LEAKPROOF (2026-07-01): split the ledger into (a) un-subtracted GENUINE poles
     the subtraction engine could not resolve and (b) closer-exhausted pieces. *)
  Module[{unsubEntries, closerEntries},
    unsubEntries = Select[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces,
      Lookup[#, "reason", ""] === "un-subtracted-pole" &];
    closerEntries = Complement[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces, unsubEntries];
    If[Length[unsubEntries] > 0,
      Message[MBresolveToMPL::unsubtracted, Length[unsubEntries]];
      Print["  *** WARNING: ", Length[unsubEntries],
        " residue-cube(s) carry a GENUINE un-subtracted boundary/corner pole ",
        "(marker mbeUnsubtractedPole[...] kept in the result, NOT silently dropped). ",
        "The bulk/corner integrator for that pole is a separate development. ",
        "Inspect MBAnalytica`SymbolicInt`Private`$mbtFailedPieces. ***"];
      Print[sep]];
    If[Length[closerEntries] > 0,
      Message[MBresolveToMPL::incomplete, Length[closerEntries]];
      Print["  *** WARNING: ", Length[closerEntries],
        " piece(s) could NOT be closed and were set to 0. The result is INCOMPLETE",
        " and NOT trustworthy. Inspect MBAnalytica`SymbolicInt`Private`$mbtFailedPieces. ***"];
      Print[sep]]];

  (* LEAKPROOF (2026-07-01): surface any NON-normal-crossing compound corner that
     was subtracted by the 1-variable linear-moment projector.  Fires ONLY on a
     genuinely-NNC forced subtraction (MBpilot12/MBpilot13/res2 give count 0), so it never
     misfires on a certified path -- it makes the potential "silent WRONG" LOUD. *)
  If[TrueQ[Positive[MBAnalytica`SymbolicInt`Private`$mbeNNCLinearMomentCount]],
    Message[MBresolveToMPL::nnccorner, MBAnalytica`SymbolicInt`Private`$mbeNNCLinearMomentCount];
    Print["  *** WARNING: ", MBAnalytica`SymbolicInt`Private`$mbeNNCLinearMomentCount,
      " NON-normal-crossing corner(s) were linear-moment subtracted (transverse ",
      "directions ignored -> possibly WRONG-but-finite). Cross-check vs Route -> ",
      "\"Standard\", or set $mbeFlagNNCCorners=True. Bases: ",
      ToString[DeleteDuplicates[MBAnalytica`SymbolicInt`Private`$mbeNNCLinearMomentBases]], " ***"];
    Print[sep]];

  MBAnalytica`SymbolicInt`Private`mbtFinalizeSeries[
    Sum[allResults[[k - ordMin + 1]] eps^k, {k, ordMin, ordMax}], eps, ordMin, ordMax, simplifyQ]];

MBStandardLibraryStatus[] := Module[{base},
  base = If[DownValues[MBStandardLibrary`MBStdLibStatus] =!= {},
    MBStandardLibrary`MBStdLibStatus[], <|"Loaded" -> False|>];
  Append[base, "LatestMBresolveToMPL" -> <|
    "PieceHits" -> MBAnalytica`SymbolicInt`Private`$mbtLearnedPieceHits,
    "PieceMisses" -> MBAnalytica`SymbolicInt`Private`$mbtLearnedPieceMisses,
    "ResolutionHits" -> MBAnalytica`SymbolicInt`Private`$mbtLearnedResolutionHits,
    "ResolutionMisses" -> MBAnalytica`SymbolicInt`Private`$mbtLearnedResolutionMisses|>]];

MBPhaseBlockLibraryStatus[] :=
  If[DownValues[MBPhaseBlockLibrary`MBPhaseBlockStatus] =!= {},
    MBPhaseBlockLibrary`MBPhaseBlockStatus[], <|"Loaded" -> False|>];

End[]  (* `Public2` *)


(* ====================================================================
   STARTUP MESSAGE
   ==================================================================== *)

(*Print[""];
Print["MBSymbolicInt v1.2 loaded.   (type  ?name  on any command below for details)"];
Print[""];
Print["  Main commands"];
Print["    MBtoEuler[integrand, contourRules, mbVars, opts]"];
Print["    Euler2MPL[eulerResult, opts]            (requires PolyLogTools)"];
Print["    MBSymbolicInt[integrand, contourRules, mbVars, opts]   (one-shot)"];
Print[""];
Print["  Step-by-step blocks"];
Print["    MBEPreprocessPolygamma   MBENormalizeContour   MBENormalizeSlope"];
Print["    MBECheckBalance          MBEGammaToBeta        MBEBetaToEuler"];
Print["    MBEOrientEuler           MBESuggestDeltaPivots MBEDeltaReduce"];
Print["    MBESupportConditions     MBEAbsorbSupport      MBESuggestSupportPivots"];
Print["    MBEApplyPolygammaLimit   MBERunStream          MBEFormatResult"];
Print["    MBEGammaPositivityReport MBEAllGammaPositiveQ"];
Print[""];
Print["  Linear-reducibility analysis"];
Print["    AEI$Analysis   AEI$BestOrder"];
If[!MemberQ[$Packages, "PolyLogTools`"],
  Print[""];
  Print["  [NOTE] PolyLogTools not loaded."];
  Print["         Euler2MPL / MBSymbolicInt will say \"beyond current scope\""];
  Print["         until you Get[\"path/to/PolyLogTools.m\"]."]];
Print[""];*)

EndPackage[]

On[General::shdw]
(* ================================================================
   mbe_degtrig.m — DEGENERATE-TRIG closer rung (2026-07-19).

   Class: 1-fold, eps-free pieces whose Gamma content is integer-linear
   in the MB variable with balanced +-1 slopes (the structural a+c=0
   degenerate family: MB7's psi1 pieces, MB6's psi0 piece, ...), with at
   most one PolyGamma[m<=2, +-z+integer] dressing factor and rational
   factors. Their towers diverge / their Euler cubes are UNFAITHFUL AT
   SOURCE (measured 2026-07-19), and the generic closer returns silent
   wrong values. Derivation (validated on MB7 pieces 4/5/6, closed
   forms 32(15Pi^2+7Pi^4+90Zeta3)/45, -308Pi^4/45, 8(15Pi^2+7Pi^4+90Zeta3)/45,
   all gated ~1e-13):
     1. TRIG REDUCTION: pair Gamma[a+z]Gamma[b-z], a+b in Z, via
        Gamma[x]Gamma[1-x]=Pi/Sin[Pi x] + Pochhammer corrections
        -> elementary kernel  R(z) * Sin[Pi z]^(-2k) * psi_m(...).
        (identity-gated at an exact rational point)
     2. Residues at z = -n / +n with SYMBOLIC n via reflection rules
        (Gamma, psi0/1/2, Sin/Cot/Csc) — verified at numeric n.
     3. Side selection empirically (partial sums vs contour quadrature).
     4. Exact head residues + exact Sum[tail, {n, Infinity}].
     5. FINAL NUMERIC GATE vs contour quadrature (diagnostic only);
        serve the exact value ONLY on gate pass, else $Failed (caller
        must ledger loudly — never a silent number).
   ================================================================ *)

Begin["MBAnalytica`SymbolicInt`Private`"];

(* ---------- detection ---------- *)
mbeDegTrigQ[intg_, vrs_List] := Module[{v, gargs, pg},
  If[Length[vrs] =!= 1, Return[False]];
  v = First[vrs];
  If[! FreeQ[intg, Global`\[Epsilon]], Return[False]];
  gargs = Cases[intg, Gamma[a_] :> a, Infinity];
  If[gargs === {}, Return[False]];
  If[! AllTrue[gargs, (IntegerQ[# /. v -> 0] && MemberQ[{-1, 1}, D[#, v]]) &],
    Return[False]];
  (* 2026-07-20 POWER-AWARE BALANCE. The old tally used the Cases list,
     which counts Gamma[1+z]^2 ONCE: Gamma(-2-z)Gamma(-z)Gamma(1+z)^2 then
     reads as slope-sum -1 (unbalanced) and never matched the class, so
     those pieces never even reached the retry machinery. Weight each
     distinct argument by its NET INTEGER POWER (mbeDTGammaPowers). *)
  Module[{pw = mbeDTGammaPowers[Together[intg], v]},
    If[pw === Association[] ||
       Total[(D[#, v] pw[#]) & /@ Keys[pw]] =!= 0, Return[False]]];
  pg = Cases[intg, PolyGamma[m_, a_] :> {m, a}, Infinity];
  (* 2026-08-28 HIGHER-ORDER ROUTING: distinct affine polygamma factors may
     occur together at the next epsilon order.  They belong to the same
     balanced parametric class and must reach the faithful cube/IntVol ladder.
     This admission does NOT license the legacy residue tower; the separate
     mbeDegTrigTowerQ below retains the old at-most-one-factor theorem. *)
  If[! AllTrue[pg, Function[item,
      IntegerQ[item[[1]]] && 0 <= item[[1]] <= 3 &&
      IntegerQ[item[[2]] /. v -> 0] &&
      MemberQ[{-1, 1}, D[item[[2]], v]]]], Return[False]];
  (* pure-Gamma (pg==0): require a genuine NO-WINDOW cross pair
     Gamma(A+z) Gamma(B-z) with A+B<=0 (the pinch/degenerate signature),
     else it is a trivial windowable piece the ordinary route already
     closes fast -- do NOT route it through the slower deg-dispatch. *)
  If[Length[pg] == 0,
    Module[{pw = mbeDTGammaPowers[Together[intg], v], plus, minus},
      plus  = Select[Keys[pw], (D[#, v] == 1 && pw[#] > 0) &];
      minus = Select[Keys[pw], (D[#, v] == -1 && pw[#] > 0) &];
      If[plus === {} || minus === {} ||
         ! AnyTrue[Tuples[{plus, minus}],
            (((#[[1]] /. v -> 0) + (#[[2]] /. v -> 0)) <= 0) &],
        Return[False]]]];
  True];

(* Conservative domain of the old residue-tower evaluator.  In particular,
   the new mixed-polygamma class is excluded because its left and right
   residue towers can both diverge while the vertical contour remains finite. *)
mbeDegTrigTowerQ[intg_, vrs_List] := Module[{v, pg},
  If[! TrueQ[mbeDegTrigQ[intg, vrs]] || Length[vrs] =!= 1,
    Return[False]];
  v = First[vrs];
  pg = Cases[intg, PolyGamma[m_, a_] :> {m, a}, Infinity];
  Length[pg] <= 1 &&
   (pg === {} ||
    (IntegerQ[pg[[1, 1]]] && 0 <= pg[[1, 1]] <= 2 &&
     IntegerQ[pg[[1, 2]] /. v -> 0] &&
     MemberQ[{-1, 1}, D[pg[[1, 2]], v]]))];

(* ---------- trig reduction (exact, self-gated) ---------- *)
(* top-level Gamma factor powers: <|arg -> net integer power|>; NEVER
   descends inside Power (a Cases levelspec sees the inner Gamma of
   Power[Gamma[..],-1] and matches it with default exponent +1 — the
   pre-pass then pairs a denominator Gamma with ITSELF, 2026-07-20). *)
mbeDTGammaPowers[f_, v_] := Module[
  {fl = If[Head[f] === Times, List @@ f, {f}], acc = Association[]},
  Do[Which[
     MatchQ[fac, Gamma[a_ /; ! FreeQ[a, v]]],
       acc[fac[[1]]] = Lookup[acc, Key[fac[[1]]], 0] + 1,
     MatchQ[fac, Power[Gamma[a_ /; ! FreeQ[a, v]], _Integer]],
       acc[fac[[1, 1]]] = Lookup[acc, Key[fac[[1, 1]]], 0] + fac[[2]]],
    {fac, fl}];
  acc];

(* ============================================================
   GAMMA-RATIO CANONICALIZATION (2026-07-20)

   Exact algebraic rewrite applied to a 1-fold MB integrand BEFORE the
   Blocks 1-8 cube pipeline.  For every MB-var-dependent Gamma in the
   DENOMINATOR, find a numerator Gamma of the SAME slope whose argument
   differs by an integer and cancel the pair against the recurrence
        Gamma(b+k)/Gamma(b) = Pochhammer[b, k],   k in Z,
   leaving a rational (Pochhammer) factor.  Iterate to a fixed point.

   WHY THIS MATTERS (the growth class, MB6/MB10):
     78 Gamma(-z)^3 Gamma(z) Gamma(1+z) psi0(-2-z)^2 / Gamma(-2-z)
   has 3 numerator Gammas of slope -1 against 2 of slope +1, so Block 4
   can never pair them; Block 5 fails and the piece falls through to
   contour-closure paths that are INVALID for this class (both residue
   towers diverge; the arc does not vanish -- measured).  Cancelling
   Gamma(-z)/Gamma(-2-z) = (1+z)(2+z) leaves the slope-BALANCED
     78 Gamma(-z)^2 Gamma(z) Gamma(1+z) (1+z)(2+z) psi0(-2-z)^2,
   for which Block 4 forms two NON-degenerate Betas and the standard
   parametric (faithful-cube) route applies -- no closure, no towers,
   no arc assumption.  The rewrite is an identity, so it cannot change
   the value; it only changes which internal route can evaluate it. *)
mbeGammaCanonicalize[expr_, vars_List] := Module[
  {f = expr, guard = 0, changed, pows, dens, bd, s, nums, match, dsh},
  f = Together[f];
  f = f //. HoldPattern[Power[Times[fs__], p_Integer]] :>
      (Times @@ (Power[#, p] & /@ List[fs]));
  While[guard++ < 24,
    changed = False;
    Do[
      pows = mbeDTGammaPowers[f, v];
      dens = Keys@Select[pows, # <= -1 &];
      If[dens =!= {},
        bd = First[dens]; s = D[bd, v];
        nums = Select[Keys@Select[pows, # >= 1 &],
          (D[#, v] === s && IntegerQ[Quiet@Simplify[# - bd]] &&
           Quiet@Simplify[# - bd] =!= 0) &];
        If[nums =!= {},
          match = First[SortBy[nums, Abs[Simplify[# - bd]] &]];
          dsh = Simplify[match - bd];
          (* Rewrite the DENOMINATOR Gamma in terms of the NUMERATOR one
             (never the reverse: rewriting the numerator downward inflates
             the surviving Gamma's argument and can manufacture a HIGHER-
             order rational pole -- e.g. MBpilot13's Gamma(-z)^3/Gamma(1-z)
             becomes Gamma(1-z)^2/z^3 the wrong way round, but the clean
             Gamma(-z)^2/z this way).
               dsh > 0 :  Gamma[bd] = Gamma[match]/Pochhammer[bd, dsh]
               dsh < 0 :  Gamma[bd] = Gamma[match]*Pochhammer[match, -dsh] *)
          f = f /. Gamma[bd] -> If[dsh > 0,
              Gamma[match]/Pochhammer[bd, dsh],
              Gamma[match] Pochhammer[match, -dsh]];
          f = Cancel[Together[f]];
          f = f //. HoldPattern[Power[Times[fs__], p_Integer]] :>
              (Times @@ (Power[#, p] & /@ List[fs]));
          changed = True]],
      {v, vars}];
    If[! changed, Break[]]];
  Cancel[Together[f]]];

(* PHASE 2: NUMERATOR ARGUMENT NORMALIZATION.
   Within each slope class, rewrite every MB-var-dependent numerator Gamma
   onto the single reference argument with the LARGEST constant term, via
   the same recurrence.  Rationale: Block 4 pairs a slope(+1) Gamma with a
   slope(-1) Gamma into B(a,b) = Gamma(a)Gamma(b)/Gamma(a+b); when a+b is a
   non-positive integer the Beta DEGENERATES (Gamma(a+b) infinite) and
   Block 5 cannot proceed -- e.g. MB5's Gamma(-2-z)Gamma(-z)Gamma(1+z)^2
   offers the pairing B(-2-z,1+z) with a+b = -1.  Normalizing the slope(-1)
   class onto its largest-constant reference (-z) yields
   Gamma(-z)^2 Gamma(1+z)^2/((1+z)(2+z)), whose only pairing is
   B(-z,1+z) with a+b = 1 -- non-degenerate.  Maximal-constant references
   also push Re(arg) up, which is what the contour normalization wants.
   This is the numerator-side sibling of the denominator cancellation
   above, and the same species as the Tier-3a/3b argument preprocessors. *)
mbeGammaArgNormalize[expr_, vars_List] := Module[
  {f = expr, pows, args, bySlope, ref, dsh},
  f = Together[f];
  f = f //. HoldPattern[Power[Times[fs__], p_Integer]] :>
      (Times @@ (Power[#, p] & /@ List[fs]));
  Do[
    pows = mbeDTGammaPowers[f, v];
    args = Select[Keys@Select[pows, # >= 1 &], ! FreeQ[#, v] &];
    Do[
      bySlope = Select[args, D[#, v] === sl &];
      If[Length[bySlope] >= 2 &&
         AllTrue[bySlope, IntegerQ[Quiet@Simplify[# - First[bySlope]]] &],
        ref = Last[SortBy[bySlope, (# /. v -> 0) &]];
        Do[
          dsh = Simplify[ref - a];
          If[IntegerQ[dsh] && dsh > 0,
            (* Gamma[a] = Gamma[ref]/Pochhammer[a, dsh] *)
            f = f /. Gamma[a] -> Gamma[ref]/Pochhammer[a, dsh]],
          {a, DeleteCases[bySlope, ref]}];
        f = Cancel[Together[f]];
        f = f //. HoldPattern[Power[Times[fs__], p_Integer]] :>
            (Times @@ (Power[#, p] & /@ List[fs]))],
      {sl, {1, -1}}],
    {v, vars}];
  Cancel[Together[f]]];

(* PHASE 3: POLYNOMIAL ABSORPTION.
   Absorb integer-rooted linear numerator factors back INTO the Gammas via
   (c+z) Gamma(c+z) = Gamma(c+1+z)  and  (c-z) Gamma(c-z) = Gamma(c+1-z).

   WHY THIS IS THE GROWTH CLASS'S CURE:  phases 1-2 leave a polynomial
   numerator, e.g. 78 (1+z)(2+z) Gamma(-z)^2 Gamma(1+z)^2 psi^2 / z.  In the
   Mellin-inversion step (Block 5/7) a POLYNOMIAL in z multiplying X^z is
   not a function but a distribution -- (1/2 pi i) Int z^k X^z dz = delta^(k)(log X)
   -- i.e. DERIVATIVES of the delta constraint, which Block 7's inversion
   does not implement.  That is exactly why the growth pieces time out on
   every route.  Absorbing the polynomial removes the distributional part:
     (1+z)(2+z) Gamma(1+z)^2  =  Gamma(1+z) Gamma(3+z),
   leaving 78 Gamma(-z)^2 Gamma(1+z) Gamma(3+z) psi^2 / z, whose pairings
   B(-z,1+z), B(-z,3+z) are non-degenerate and whose nonG is a SIMPLE pole
   1/z -- precisely Block 5's Auxiliary domain. *)
mbeGammaAbsorbPoly[expr_, vars_List] := Module[
  {f = expr, guard = 0, changed, num, pows, args, polyPart, quot},
  While[guard++ < 24,
    changed = False;
    num = Numerator[Together[f]];
    Do[
      pows = mbeDTGammaPowers[num, v];
      args = Select[Keys@Select[pows, # >= 1 &], ! FreeQ[#, v] &];
      Do[
        (* Divisibility is tested on the PURE POLYNOMIAL part (Gamma/PolyGamma
           factors stripped): if numerator/a stays polynomial, one factor of
           a can be absorbed as (a) Gamma(a) = Gamma(a+1). *)
        polyPart = num /. {Gamma[_] -> 1, PolyGamma[__] -> 1};
        If[PolynomialQ[polyPart, v] && ! PossibleZeroQ[polyPart],
          quot = Quiet@Cancel[polyPart/a];
          If[PolynomialQ[quot, v],
            f = Cancel[Together[(f/a) Gamma[a + 1]/Gamma[a]]];
            num = Numerator[Together[f]];
            changed = True]],
        {a, args}],
      {v, vars}];
    If[! changed, Break[]]];
  Cancel[Together[f]]];

(* PREPASS (b) 2026-07-21: PSI-SHIFT TO CONTOUR-LEGAL ARGUMENT.
   The genuine theory extension for pieces where a polygamma sits at a
   SHIFTED argument whose poles coincide with the kernel poles (MB9 p39:
   psi0(-1-z) at contour 0.858, its argument -1.858 has Re<0 and its poles
   land on the csc^2 integers, so one-sided tower closure mis-selects the
   side).  Shift each polygamma up via the recurrence
     psi_m(a) = psi_m(a+1) - (-1)^m m! / a^(m+1)
   until Re(arg) > 0 on the contour; the rational corrections split off as
   separate (simpler) pieces.  Every piece is then closed by the ordinary
   cube / shift+integral-rep routes and summed.  This is the shift trick of
   the fixes-notes, applied to bring the psi argument into the window --
   NO residue tower, NO harmonic sum.  Verified on MB9 p39: 6 pieces sum to
   428.2478023 (contour truth) to 12 digits. *)
mbeShiftPsiToLegal[expr_, ctr_List, vrs_List] := Module[
  {v = First[vrs], c = ctr[[1, 2]], f = expr, guard = 0, hit, m, a},
  If[Length[vrs] =!= 1, Return[expr]];
  While[guard++ < 40,
    hit = FirstCase[f,
      PolyGamma[mm_Integer, arg_] /; ! FreeQ[arg, v] &&
        Exponent[arg, v] == 1 &&
        TrueQ[Re[Quiet@N[arg /. v -> c]] <= 0],
      $Missing, {0, Infinity}];
    If[hit === $Missing, Break[]];
    m = hit[[1]]; a = hit[[2]];
    f = f /. PolyGamma[m, a] :>
        (PolyGamma[m, a + 1] - (-1)^m m! / a^(m + 1))];
  Expand[f]];

(* Exact rational-csc^2 closure (2026-08-28).

   After a legal polygamma recurrence, a correction can be a pure balanced
   Gamma kernel whose exact trig reduction is

       Pi^2 Csc[Pi z]^2 R(z),

   with R rational, all of its poles on the integer lattice, and R(z)=O(1/z)
   or faster.  On rectangles with right edge Re z=N+1/2, Csc[Pi z]^2 is
   exponentially small on the horizontal edges and bounded by Sech[Pi Im z]^2
   on the right edge; the rational decay therefore proves that the closing arc
   vanishes.  To the right of every pole of R,

       Res[Pi^2 Csc[Pi z]^2 R(z), z=n] = R'(n).

   Thus the vertical MB integral is minus the finite exact head residues minus
   the convergent exact rational Sum of R'(n).  This theorem is deliberately
   narrower than mbeDegTrigEval: no polygamma, no higher csc power, no
   noninteger rational pole, no parameter, and no unevaluated Sum is accepted. *)
mbeRationalCsc2Close[intg_, ctr_List, vrs_List] := Module[
  {v, c, red, rat, num, den, factors, roots, nFirst, rightRoots,
   tailStart, head, n, tailSummand, tail, value, inexactAtoms},
  If[Length[vrs] =!= 1 || ! FreeQ[intg, PolyGamma], Return[$Failed]];
  v = First[vrs];
  c = Quiet@Check[v /. Association[ctr], $Failed];
  If[Head[c] =!= Rational, Return[$Failed]];
  inexactAtoms = Cases[intg,
    q_?NumberQ /; Precision[Unevaluated[q]] =!= Infinity :> q,
    {0, Infinity}, Heads -> True];
  If[inexactAtoms =!= {}, Return[$Failed]];
  red = Quiet@CheckAbort[
    TimeConstrained[mbeTrigReduce[intg, v], 120, $Failed], $Failed];
  If[red === $Failed || ! TrueQ[mbeTrigGate[intg, red, v]],
    Return[$Failed]];
  rat = Quiet@CheckAbort[
    TimeConstrained[Cancel[Together[red Sin[Pi v]^2/Pi^2]],
      60, $Failed], $Failed];
  If[rat === $Failed || ! TrueQ[Quiet@PossibleZeroQ[
       red - Pi^2 Csc[Pi v]^2 rat]], Return[$Failed]];
  If[Cases[rat, s_Symbol /;
       Context[Unevaluated[s]] =!= "System`" && s =!= v :> s,
       {0, Infinity}, Heads -> True] =!= {}, Return[$Failed]];
  num = Numerator[Together[rat]];
  den = Denominator[Together[rat]];
  If[PossibleZeroQ[num], Return[0]];
  If[! PolynomialQ[num, v] || ! PolynomialQ[den, v] ||
     Exponent[den, v] - Exponent[num, v] < 1, Return[$Failed]];
  factors = Rest[FactorList[den]];
  If[! AllTrue[factors, Function[item,
      Exponent[item[[1]], v] === 1 &&
       IntegerQ[-Coefficient[item[[1]], v, 0]/
         Coefficient[item[[1]], v, 1]]]], Return[$Failed]];
  roots = If[factors === {}, {},
    (-Coefficient[#[[1]], v, 0]/Coefficient[#[[1]], v, 1]) & /@
      factors];
  nFirst = Floor[c] + 1;
  rightRoots = Select[roots, # >= nFirst &];
  tailStart = If[rightRoots === {}, nFirst, Max[rightRoots] + 1];
  If[tailStart - nFirst > 64, Return[$Failed]];
  head = Quiet@CheckAbort[TimeConstrained[
    If[tailStart === nFirst, 0,
      Total@Table[Residue[red, {v, k}], {k, nFirst, tailStart - 1}]],
    180, $Failed], $Failed];
  If[head === $Failed || ! FreeQ[head, _Residue], Return[$Failed]];
  tailSummand = Cancel[D[rat, v] /. v -> n];
  tail = Quiet@CheckAbort[TimeConstrained[
    FullSimplify[Sum[tailSummand, {n, tailStart, Infinity}],
      Element[n, Integers] && n >= tailStart], 180, $Failed], $Failed];
  If[tail === $Failed || ! FreeQ[tail, _Sum | _ConditionalExpression |
       Indeterminate | ComplexInfinity | DirectedInfinity], Return[$Failed]];
  value = Quiet@CheckAbort[
    TimeConstrained[FullSimplify[-head - tail], 120, $Failed], $Failed];
  If[value === $Failed || ! FreeQ[value, v | n | _Sum | _Residue |
       _ConditionalExpression | Indeterminate | ComplexInfinity |
       DirectedInfinity] ||
     Cases[value, q_?NumberQ /;
       Precision[Unevaluated[q]] =!= Infinity :> q,
       {0, Infinity}, Heads -> True] =!= {}, $Failed, value]];

(* Close a piece by the cube/shift routes (no unproved tower): try the
   certified rational-csc^2 theorem, then a direct faithful cube, then forced
   shift+integral-rep.  Returns an exact numeric constant or $Failed. *)
mbeCubeOrShiftClose[intg_, ctr_List, vrs_List, timeout_:400] := Module[{r, v},
  If[FreeQ[intg, PolyGamma],
    r = mbeRationalCsc2Close[intg, ctr, vrs];
    If[r =!= $Failed && NumericQ[Quiet@N[r]],
      WriteString["stdout", "    [RationalCsc2] exact arc-certified closure.\n"];
      Return[r]]];
  r = Quiet@TimeConstrained[
    mbeDirectCubeClose[intg, ctr, vrs, timeout], timeout + 200, $Failed];
  If[NumericQ[Quiet@N[r]], Return[r]];
  r = Block[{$mbeForceSymbolicResidue = True},
    Module[{rr = Quiet@TimeConstrained[
        MBAnalytica`SymbolicInt`MBSymbolicInt[intg, ctr, vrs, "Assumptions" -> {},
          "ParametricValues" -> {}], timeout, $Failed]},
      If[AssociationQ[rr], rr["MPLResult"], rr]]];
  If[NumericQ[Quiet@N[r]], r, $Failed]];

(* Full (b) attempt: psi-shift, split, close each, sum. *)
mbeShiftSplitClose[intg_, ctr_List, vrs_List, timeout_:400] := Module[
  {shifted, pieces, vals},
  shifted = mbeShiftPsiToLegal[intg, ctr, vrs];
  pieces = If[Head[shifted] === Plus, List @@ shifted, {shifted}];
  vals = Map[mbeCubeOrShiftClose[#, ctr, vrs, timeout] &, pieces];
  If[FreeQ[vals, $Failed] && AllTrue[vals, NumericQ[Quiet@N[#]] &],
    Total[vals], $Failed]];

(* ATTEMPT 0.8: PSI FORCE-SHIFT past kernel poles (2026-07-21).
   For pieces where a polygamma sits at an argument whose poles COINCIDE
   with the no-window degenerate kernel poles even though Re(arg)>0, the
   ordinary shift does not fire and the tower residue sum is wrong (MB10
   offset-3: partL=partR=16.88 but truth=0.072). Force-shift EVERY
   polygamma up by N via psi_m(a)=psi_m(a+1)-(-1)^m m!/a^(m+1) so its poles
   clear the kernel poles, split the rational corrections, close each by
   the ordinary cube/shift routes. Removes the psi from the residue
   structure so the dressed piece becomes cube-able. N tried smallest-first
   (1,2,3) to keep split-cube dimension low. Pure cube/shift, no tower. *)
mbeForceShiftPsi[expr_, v_Symbol, nShift_Integer] := Module[
  {f = expr, hits},
  Do[
    hits = Union@Cases[f,
      PolyGamma[mm_Integer, arg_] /; ! FreeQ[arg, v] && Exponent[arg, v] == 1
        :> {mm, arg}, {0, Infinity}];
    If[hits === {}, Break[]];
    Do[With[{m = h[[1]], a = h[[2]]},
        f = f /. PolyGamma[m, a] :>
            (PolyGamma[m, a + 1] - (-1)^m m! / a^(m + 1))],
      {h, hits}];
    f = Expand[f],
    {nShift}];
  Expand[f]];

mbeForceShiftClose[intg_, ctr_List, vrs_List, timeout_:300] := Module[
  {v = First[vrs], shifted, pieces, vals, nn},
  If[Length[vrs] =!= 1 || FreeQ[intg, PolyGamma], Return[$Failed]];
  Do[
    shifted = mbeForceShiftPsi[intg, v, nn];
    pieces = If[Head[shifted] === Plus, List @@ shifted, {shifted}];
    vals = Map[mbeCubeOrShiftClose[#, ctr, vrs, timeout] &, pieces];
    If[FreeQ[vals, $Failed] && AllTrue[vals, NumericQ[Quiet@N[#]] &],
      Return[Total[vals], Module]],
    {nn, 1, 3}];
  $Failed];

(* Full canonicalization: denominator cancellation, argument normalization,
   polynomial absorption; iterated to a fixed point. *)
(* DIRECT FAITHFUL-CUBE CLOSER (2026-07-20).
   The user's canonical prescription: generate the faithful cube via
   MBtoEuler, then integrate ALL of its parts with IntVolIntegrate and sum.
   Verified on MB9's family-B pieces where the packaged MBSymbolicInt diverts to a
   wrong internal path (Path B tower giving 263 instead of 66): this direct
   route reproduces the contour value to 20 digits.

   Only the EulerIntegrands are summed -- PartB entries are an alternate
   VIEW of the same integrands (measured: PartB[k] equals an EulerIntegrand
   numerically), so adding them would double count.  Returns the numeric
   value or $Failed. *)
(* ---- v2.6 (2026-07-27): LIBRARY CERTIFICATION CHAIN ----
   The IntVol knowledge library files every cube solve as PROVISIONAL, and
   both of its serve paths (stored results, learned orders) require
   Verified===True; the engine's own self-certify needs a declared kinematic
   point, which the campaign's parameter-free [0,1]^n cubes never have -- so
   544 records had accumulated with ZERO certified: a write-only library.
   The independent anchor exists one level up: the piece-level phase-stripped
   contour quadrature that already gates every served value in the degenerate
   dispatch.  Mechanism: every successful IntVolIntegrate call is LOGGED
   ($mbtIVCertPend; reset at the start of each dispatch attempt so a failed
   attempt's cubes are never confirmed by a later attempt's pass), and when
   an attempt's value passes its quadrature gate, mbtIVCertSweep promotes
   exactly that attempt's cube records via IVLibConfirm (Rule 1: the anchor
   is the piece quadrature at 1e-6).  Un-gated paths never confirm; without
   the library everything here is a no-op. *)
If[!ValueQ[$mbtIVCertPend], $mbtIVCertPend = {}];
mbtIVCertLog[e_, v_List] := If[ListQ[$mbtIVCertPend] &&
   Length[$mbtIVCertPend] < 64 && v =!= {},
  AppendTo[$mbtIVCertPend, {e, v}]];
mbtIVCertSweep[anchor_String] := (
  If[DownValues[Global`IVLibConfirm] =!= {} && ListQ[$mbtIVCertPend] &&
     $mbtIVCertPend =!= {},
    Block[{Global`$IVLibVerbose = False},
      Scan[Quiet[Global`IVLibConfirm[#[[1]], #[[2]], {}, Missing[], anchor]] &,
        $mbtIVCertPend]]];
  $mbtIVCertPend = {});

mbeDirectCubeClose[intg_, ctr_List, vrs_List, timeout_:600] := Module[
  {em, eis, cube, failedIntegrand, res, tot = 0, nv},
  (* SHIELD from route/global contamination (2026-07-20): a prior MBSymbolicInt
     call in the same kernel pollutes $Assumptions AND leaves the F-pattern
     / degenerate-kernel diverters in a state that makes MBtoEuler take the
     WRONG (Path B) internal branch, so this closer returned $Failed inside
     the dispatch while succeeding standalone.  Force $Assumptions=True and
     the diverters OFF so MBtoEuler always yields the faithful Block 1-8
     cube; the whole point of this route is to use that cube. *)
  em = Block[{$Assumptions = True,
              MBAnalytica`SymbolicInt`Private`mbeMatchesFPatternQ,
              MBAnalytica`SymbolicInt`Private`mbeMatchesDegenerateKernelQ},
    MBAnalytica`SymbolicInt`Private`mbeMatchesFPatternQ[___] := False;
    MBAnalytica`SymbolicInt`Private`mbeMatchesDegenerateKernelQ[___] := False;
    Quiet@TimeConstrained[
      MBAnalytica`SymbolicInt`MBtoEuler[intg, ctr, vrs, "Assumptions" -> {}], timeout, $Failed]];
  If[! AssociationQ[em] || Lookup[em, "PartAFailure", None] =!= None ||
     TrueQ[Lookup[em, "PartialResult", False]], Return[$Failed]];
  eis = Lookup[em, "EulerIntegrands", {}];
  If[eis === {}, Return[$Failed]];
  Do[
    cube = eis[[k, 1]];
    (* A Part-B recurrence correction may be analytically valid even when the
       generic MB-to-cube stream cannot represent it.  Accept only the exact
       failure tag emitted for that situation, extract its original MB
       integrand, and require the narrow arc-certified rational-csc^2 theorem.
       Every other Failure remains fatal. *)
    If[MatchQ[cube, Failure["PartBStreamFailed", _Association]],
      failedIntegrand = Lookup[cube[[2]], "Integrand", $Failed];
      res = If[failedIntegrand === $Failed, $Failed,
        mbeRationalCsc2Close[failedIntegrand, ctr, vrs]];
      If[res === $Failed || ! NumericQ[Quiet@N[res]],
        Return[$Failed, Module]];
      WriteString["stdout",
        "    [RationalCsc2] closed exact PartBStreamFailed correction.\n"];
      tot += res;
      Continue[]];
    If[FailureQ[cube], Return[$Failed, Module]];
    res = Quiet@TimeConstrained[
      Global`IntVolIntegrate[cube, eis[[k, 2]]], timeout, $Failed];
    res = If[AssociationQ[res], Lookup[res, "Result", $Failed], res];
    If[res === $Failed || ! FreeQ[res, $Failed],
      Return[$Failed, Module]];
    mbtIVCertLog[cube, eis[[k, 2]]];  (* v2.6 certification log *)
    tot += res,
    {k, Length[eis]}];
  nv = Quiet@If[FreeQ[tot, PolyLogTools`G] && FreeQ[tot, Global`G],
    N[tot, 20], PolyLogTools`Ginsh[tot, 20]];
  If[NumericQ[Quiet@N[nv]], tot, $Failed]];

mbeGammaCanonFull[expr_, vars_List] := Module[{f = expr},
  (* SINGLE ORDERED PASS. Looping the phases makes 2 and 3 fight: phase 2
     normalizes every same-slope Gamma onto the largest-constant reference,
     which re-creates exactly the polynomial denominator phase 3 has just
     absorbed (Gamma(1+z)Gamma(3+z)/z -> Gamma(3+z)^2/(z(1+z)(2+z))).
     Denominator cancellation, then argument normalization, then absorption
     -- once each -- reaches the intended normal form. *)
  f = mbeGammaCanonicalize[f, vars];
  f = mbeGammaArgNormalize[f, vars];
  f = mbeGammaAbsorbPoly[f, vars];
  f];

(* ---- POLYNOMIAL-SPLIT for the pure-Gamma GROWTH class (2026-07-22) ----
   After Gamma-canon a pure-Gamma growth piece can carry an UNABSORBABLE
   numerator polynomial P(v) (no Gamma matches it) = the distributional
   delta-derivative part Block 5 refuses ("Non-Beta prefactor not pure
   power-like").  mbeGammaAbsorbPoly only absorbs a factor that IS a Gamma
   argument; a leftover like (z-1) against Gamma(2+z) is not absorbable.
   Split it instead: pick a same-slope numerator Gamma(gArg=a+sig v) and
   express P(v) in the rising-factorial basis of gArg, so
      P(v) Gamma(gArg) = Sum_j c_j Gamma(gArg+j)
   (Gamma(gArg+j) = Pochhammer(gArg,j) Gamma(gArg)); every resulting piece
   is polynomial-FREE (only denominator poles, = Block 5's Auxiliary
   domain) and closes by the ordinary faithful cube.  NO-OP (returns
   {expr}) when the numerator has no v-polynomial or no unit-slope Gamma to
   split against -- so it never disturbs a working piece.  Exact identity;
   no residue tower, no harmonic sum.  Verified on MB10 p_0046
   (24 (z5-1) G(-z5)^3 G(2+z5)^3/((1+z5)^2(2+z5)) -> 2 pieces summing to
   the contour truth -31.9286 in ~7 s). *)
mbeGammaPolySplit[expr_, v_] := Module[
  {tg, num, den, polyPart, gCand, gArg, sig, a, GG, Pt, deg, ccv, sol, cj,
   base, terms},
  tg = Together[expr]; num = Numerator[tg]; den = Denominator[tg];
  polyPart = num /. {Gamma[_] -> 1, PolyGamma[__] -> 1};
  If[FreeQ[polyPart, v], Return[{expr}]];
  gCand = DeleteDuplicates@Cases[num,
     Gamma[x_] /; PolynomialQ[x, v] && Exponent[x, v] == 1 &&
        Abs[Coefficient[x, v]] == 1 :> x, {0, Infinity}];
  If[gCand === {}, Return[{expr}]];
  gArg = SelectFirst[gCand,
     Coefficient[#, v] == Sign[Coefficient[polyPart, v, Exponent[polyPart, v]]] &,
     First[gCand]];
  sig = Coefficient[gArg, v]; a = gArg - sig v;
  Pt = Expand[polyPart /. v -> sig (GG - a)]; deg = Exponent[Pt, GG];
  If[! IntegerQ[deg] || deg < 1, Return[{expr}]];
  ccv = Table[Unique["ccPS"], {j, 0, deg}];
  sol = Quiet@Solve[Thread[CoefficientList[
     Pt - Sum[ccv[[j + 1]] Pochhammer[GG, j], {j, 0, deg}], GG] == 0], ccv];
  If[sol === {} || sol === $Failed, Return[{expr}]];
  cj = ccv /. First[sol];
  base = Cancel[Together[num / (polyPart Gamma[gArg]) / den]];
  terms = Table[cj[[j + 1]] base Gamma[gArg + j], {j, 0, deg}];
  DeleteCases[Together /@ terms, 0]];

(* Close a growth piece by polynomial-split + faithful cube per piece.
   Returns the summed numeric value, or $Failed if it did not split (so the
   dispatch falls through) or if any split piece failed to cube. *)
mbeGrowthPolySplitClose[intg_, ctr_List, vrs_List, timeout_:400] := Module[
  {pieces, vals},
  If[Length[vrs] =!= 1, Return[$Failed]];
  pieces = Quiet@TimeConstrained[mbeGammaPolySplit[intg, First[vrs]], 120, {intg}];
  If[! ListQ[pieces] || Length[pieces] < 2, Return[$Failed]];
  vals = mbeDirectCubeClose[#, ctr, vrs, timeout] & /@ pieces;
  If[AnyTrue[vals, ! NumericQ[Quiet@N[#]] &], Return[$Failed]];
  Total[vals]];

(* True iff canonicalization strictly simplifies the Gamma structure
   (a denominator Gamma with MB-var dependence actually cancels). *)
mbeGammaCanonHelpsQ[expr_, vars_List] := Module[{c},
  c = Quiet@TimeConstrained[mbeGammaCanonicalize[expr, vars], 120, $Failed];
  c =!= $Failed &&
    AnyTrue[vars, (Length[Select[Keys@mbeDTGammaPowers[Together[expr], #],
        Function[a, ! FreeQ[a, #]]]] > 0) &] &&
    ! AnyTrue[vars, Function[v,
       Length[Select[mbeDTGammaPowers[c, v], # <= -1 &]] > 0]] &&
    AnyTrue[vars, Function[v,
       Length[Select[mbeDTGammaPowers[Together[expr], v], # <= -1 &]] > 0]]];

mbeTrigReduce[intg_, v_] := Module[{f = intg, gp, gm, a, b, k, guard = 0,
   prev},
  (* 2026-07-20 PRE-PASS (MB10 class A): cancel DENOMINATOR Gammas against a
     same-slope numerator Gamma via integer shifts. Without this the pairing
     loop picks denominator fronts, generates no-op replacements (k=1) and
     spins the guard out, leaving the reduction incomplete. *)
  f = Together[f];
  (* distribute negative powers over products so denominator Gammas appear
     as Power[Gamma[..], -n] factors the patterns below can see *)
  f = f //. HoldPattern[Power[Times[fs__], p_?Negative]] :>
      (Times @@ (Power[#, p] & /@ List[fs]));
  Module[{guard2 = 0, pows, dens, bd, s, nums, match, dsh},
    While[guard2++ < 16,
      pows = mbeDTGammaPowers[f, v];
      dens = Keys@Select[pows, # <= -1 &];
      If[dens === {}, Break[]];
      bd = First[dens]; s = D[bd, v];
      nums = Select[Keys@Select[pows, # >= 1 &], D[#, v] === s &];
      If[nums === {}, Break[]];
      match = First[SortBy[nums, Abs[Simplify[# - bd]] &]];
      dsh = Simplify[match - bd];
      If[! IntegerQ[dsh] || dsh === 0, Break[]];
      f = f /. Gamma[bd] -> If[dsh >= 0,
          Gamma[match]/Pochhammer[bd, dsh],
          Gamma[match] Pochhammer[match, -dsh]];
      f = Cancel[Together[f]];
      f = f //. HoldPattern[Power[Times[fs__], p_Integer]] :>
          (Times @@ (Power[#, p] & /@ List[fs]))]];
  While[guard++ < 24,
    prev = f;
    (* keep the expression flat: integer powers of products distributed so
       Gamma powers are always visible as Power[Gamma[..], n] factors *)
    f = f //. HoldPattern[Power[Times[fs__], p_Integer]] :>
        (Times @@ (Power[#, p] & /@ List[fs]));
    (* NUMERATOR-only candidates (positive TOP-LEVEL factor powers) *)
    Module[{pows = mbeDTGammaPowers[f, v], posArgs},
      posArgs = Keys@Select[pows, # >= 1 &];
      gp = Select[posArgs, D[#, v] === 1 &];
      gm = Select[posArgs, D[#, v] === -1 &]];
    If[gp === {} || gm === {}, Break[]];
    a = First[gp]; b = First[gm];
    k = Simplify[a + b];       (* integer by detection *)
    (* Gamma[b] = Gamma[1-a] * corr, with (b)-(1-a) = k-1 ; skip the
       normalization when b == 1-a already (k == 1): it is a no-op. *)
    If[k =!= 1,
      f = f /. Gamma[b] -> If[k - 1 >= 0,
          Gamma[1 - a] Pochhammer[1 - a, k - 1],
          Gamma[1 - a]/Pochhammer[b, 1 - k]]];
    (* power-aware pair rule (plain products covered by p_. defaults) *)
    f = f //. Gamma[a]^p1_. Gamma[1 - a]^p2_. /; p1 >= 1 && p2 >= 1 :>
        (Pi/Sin[Pi a]) Gamma[a]^(p1 - 1) Gamma[1 - a]^(p2 - 1);
    If[f === prev, Break[]]];
  (* canonicalize Sin[Pi(c+z)] = (-1)^c Sin[Pi z] for integer c *)
  f = f //. Sin[Pi arg_] /; IntegerQ[arg /. v -> 0] && D[arg, v] === 1 :>
      (-1)^(arg /. v -> 0) Sin[Pi v];
  f = f //. Sin[Pi arg_] /; IntegerQ[arg /. v -> 0] && D[arg, v] === -1 :>
      -(-1)^(-(arg /. v -> 0)) Sin[Pi v];
  Simplify[f]];

(* identity gate at an exact point *)
mbeTrigGate[orig_, red_, v_] := Module[{zt = -7/10 + (3 I)/10, d},
  d = Quiet@N[(orig - red) /. v -> zt, 40];
  NumericQ[d] && Abs[d] < 10^-30 (1 + Abs[N[orig /. v -> zt, 40]])];

(* ---------- symbolic residues (nn >= 2) ---------- *)
mbeDegAss = Element[Global`mbeNN, Integers] && Global`mbeNN >= 2;

mbeReflRules[sgn_] := Module[{nn = Global`mbeNN, w = Global`mbeWW}, {
   Sin[Pi (sgn nn + w)] -> (-1)^(sgn nn) Sin[Pi w],
   Sin[Pi (sgn nn + w)]^p_ :> ((-1)^(sgn nn) Sin[Pi w])^p,
   Cot[Pi (sgn nn + w)] -> Cot[Pi w],
   Csc[Pi (sgn nn + w)] -> (-1)^(sgn nn) Csc[Pi w],
   PolyGamma[m_, arg_] /; IntegerQ[arg /. {Global`mbeWW -> 0, nn -> 0}] &&
       TrueQ[Simplify[(arg /. Global`mbeWW -> 0) <= 0, mbeDegAss]] :>
     With[{q = arg /. Global`mbeWW -> 0, s = D[arg, Global`mbeWW]},
       Switch[m,
        0, PolyGamma[0, 1 - q - s Global`mbeWW] - Pi s Cot[Pi Global`mbeWW],
        1, -PolyGamma[1, 1 - q - s Global`mbeWW] + Pi^2 Csc[Pi Global`mbeWW]^2,
        2, PolyGamma[2, 1 - q - s Global`mbeWW] -
           2 Pi^3 s Csc[Pi Global`mbeWW]^2 Cot[Pi Global`mbeWW]]],
   Gamma[arg_] /; IntegerQ[arg /. {Global`mbeWW -> 0, nn -> 0}] &&
       TrueQ[Simplify[(arg /. Global`mbeWW -> 0) <= 0, mbeDegAss]] :>
     With[{q = arg /. Global`mbeWW -> 0, s = D[arg, Global`mbeWW]},
       (-1)^q Pi/(s Sin[Pi Global`mbeWW] Gamma[1 - q - s Global`mbeWW])]}];

mbeDegResSym[f_, v_, sgn_] := Module[{nn = Global`mbeNN, w = Global`mbeWW, g, ser},
  g = f /. v -> sgn nn + w;
  g = g //. mbeReflRules[sgn];
  ser = Quiet@Series[g, {w, 0, 0}, Assumptions -> mbeDegAss];
  If[Head[ser] =!= SeriesData, 0,
    Simplify[SeriesCoefficient[ser, -1], mbeDegAss]]];

mbeDegResExactAt[f_, v_, zp_] := Module[{w = Global`mbeWW, ser},
  ser = Quiet@Series[f /. v -> zp + w, {w, 0, 0}];
  If[Head[ser] =!= SeriesData, 0, SeriesCoefficient[ser, -1]]];

(* ---------- isolated tail summation ---------- *)
mbeDegTailSumIsolated[rS_, nFrom_Integer] := Module[
  {dir, fin, fout, code, rp, out},
  dir = FileNameJoin[{$TemporaryDirectory,
    "mbe_degtrig_" <> ToString[$ProcessID]}];
  Quiet@CreateDirectory[dir];
  fin = FileNameJoin[{dir, "in.m"}]; fout = FileNameJoin[{dir, "out.m"}];
  Put[rS, fin];
  Quiet@DeleteFile[fout];
  code = "nn = Global`mbeNN; expr = Get[\"" <> fin <> "\"]; " <>
    "r = Quiet@TimeConstrained[FullSimplify[Sum[Apart[expr, nn], " <>
    "{nn, " <> ToString[nFrom] <> ", Infinity}], " <>
    "Element[nn, Integers] && nn >= " <> ToString[nFrom] <> "]], 400, $Failed]; " <>
    "Put[r, \"" <> fout <> "\"];";
  (* the isolated kernel is this installation's command-line kernel running a script file; wolframscript need not
     be on the PATH (it is not, inside the macOS application bundle) *)
  Export[FileNameJoin[{dir, "tail.wl"}], code, "Text"];
  rp = Quiet@TimeConstrained[
    RunProcess[Join[MBAnalytica`Portable`TimeoutArgs[500],
      {$mbtMathExecutable, "-noinit", "-noprompt", "-script", FileNameJoin[{dir, "tail.wl"}]}]], 510, $Failed];
  If[! FileExistsQ[fout], Return[$Failed]];
  out = Quiet@Get[fout];
  If[out === $Failed || ! FreeQ[out, Sum] || ! FreeQ[out, $Failed], $Failed, out]];

(* ---------- shift-reduction tail summer (2026-07-20) ----------
   Deterministic exact evaluator for degtrig tails: polynomial-in-psi
   residues with rational coefficients -> HarmonicNumber monomials on a
   common base index -> fixed-point reindexing until all denominators are
   pure powers (boundary terms accumulated exactly; divergent monomials
   must cancel, gated) -> 7-entry classical Euler-sum table (weight<=4).
   Derived+gated on MB7 psi0^2 triplet (1e-13/1e-16/1e-13, derive7) after
   generic Sum/FullSimplify stalled: THE psi0^2-class summer the S5 spec
   called for. Serves exact or $Failed — never a silent number; the
   rung's final quadrature gate still applies downstream. *)
mbeDSSTab = With[{m = Global`mbeMM}, {
  (* weight <= 4 (NSum-gated 20 digits, derive5 2026-07-20) *)
  {1/m^2, Pi^2/6}, {1/m^3, Zeta[3]}, {1/m^4, Pi^4/90},
  {HarmonicNumber[m]/m^2, 2 Zeta[3]}, {HarmonicNumber[m]/m^3, Pi^4/72},
  {HarmonicNumber[m]^2/m^2, 17 Pi^4/360},
  {HarmonicNumber[m, 2]/m^2, 7 Pi^4/360},
  (* weight 5 — COMPLETE for monomials H^p (H2)^q (H3)^r / m^k, k>=2
     (mbx_w5_table 2026-07-20: NSum-verified 25 digits except H*H2/m^2 at
     16 digits + classical value zeta2 zeta3 + zeta5) *)
  {1/m^5, Zeta[5]},
  {HarmonicNumber[m]/m^4, 3 Zeta[5] - Pi^2 Zeta[3]/6},
  {HarmonicNumber[m]^2/m^3, 7 Zeta[5]/2 - Pi^2 Zeta[3]/6},
  {HarmonicNumber[m]^3/m^2, 10 Zeta[5] + Pi^2 Zeta[3]/6},
  {HarmonicNumber[m, 2]/m^3, Pi^2 Zeta[3]/2 - 9 Zeta[5]/2},
  {HarmonicNumber[m, 3]/m^2, 11 Zeta[5]/2 - Pi^2 Zeta[3]/3},
  {HarmonicNumber[m] HarmonicNumber[m, 2]/m^2, Pi^2 Zeta[3]/6 + Zeta[5]},
  (* tail-basis entries (2026-07-20): T2=zeta2-H2, T3=zeta3-H3 — each
     derived EXACTLY by order swap from the gated absolute sums above. *)
  {MBAnalytica`SymbolicInt`Private`mbeT2[m]/m, Zeta[3]},
  {MBAnalytica`SymbolicInt`Private`mbeT2[m]/m^2, Pi^4/120},
  {MBAnalytica`SymbolicInt`Private`mbeT2[m]/m^3, 9 Zeta[5]/2 - Pi^2 Zeta[3]/3},
  {HarmonicNumber[m] MBAnalytica`SymbolicInt`Private`mbeT2[m]/m, 7 Pi^4/360},
  {HarmonicNumber[m] MBAnalytica`SymbolicInt`Private`mbeT2[m]/m^2, Pi^2 Zeta[3]/6 - Zeta[5]},
  {MBAnalytica`SymbolicInt`Private`mbeT3[m]/m, Pi^4/360},
  {MBAnalytica`SymbolicInt`Private`mbeT3[m]/m^2, Pi^2 Zeta[3]/2 - 11 Zeta[5]/2},
  {HarmonicNumber[m] MBAnalytica`SymbolicInt`Private`mbeT3[m]/m, Pi^2 Zeta[3]/3 - 7 Zeta[5]/2}}];

mbeDSSNormPsi[expr_] := Module[{m = Global`mbeMM, f = expr, guard = 0, hit},
  (* normalize every PolyGamma[k, m + a] to base argument m+1, k<=3 *)
  While[guard++ < 60,
    hit = FirstCase[f,
      PolyGamma[k_Integer, arg_] /; k <= 3 && D[arg, m] === 1 &&
        IntegerQ[arg /. m -> 0] && (arg /. m -> 0) =!= 1,
      $Missing, {0, Infinity}];
    If[hit === $Missing, Break[]];
    With[{k = hit[[1]], a = hit[[2]] /. m -> 0},
      f = f /. If[a > 1,
        PolyGamma[k, m + a] ->
          PolyGamma[k, m + a - 1] + (-1)^k k!/(m + a - 1)^(k + 1),
        PolyGamma[k, m + a] ->
          PolyGamma[k, m + a + 1] - (-1)^k k!/(m + a)^(k + 1)]]];
  (* TAIL BASIS (2026-07-20): psi_k(m+1) kept as inert tail symbols
     mbeT2/T3/T4[m] ~ 1/m^k so psi0*psi1-type towers stay MANIFESTLY
     convergent per-monomial (H2-expansion split them into individually
     divergent monomials -> false divergence-gate failures, MB10 class). *)
  f /. {PolyGamma[0, m + 1] -> HarmonicNumber[m] - EulerGamma,
        PolyGamma[1, m + 1] -> MBAnalytica`SymbolicInt`Private`mbeT2[m],
        PolyGamma[2, m + 1] -> -2 MBAnalytica`SymbolicInt`Private`mbeT3[m],
        PolyGamma[3, m + 1] -> 6 MBAnalytica`SymbolicInt`Private`mbeT4[m]}];

mbeDSSToMons[expr_] := Module[{m = Global`mbeMM, ex = Expand[expr], terms},
  terms = If[Head[ex] === Plus, List @@ ex, {ex}];
  Map[Function[t, Module[{es, cm},
     es = {Exponent[t, HarmonicNumber[m]],
           Exponent[t, MBAnalytica`SymbolicInt`Private`mbeT2[m]],
           Exponent[t, MBAnalytica`SymbolicInt`Private`mbeT3[m]],
           Exponent[t, MBAnalytica`SymbolicInt`Private`mbeT4[m]]};
     cm = Cancel[t/(HarmonicNumber[m]^es[[1]] MBAnalytica`SymbolicInt`Private`mbeT2[m]^es[[2]] *
        MBAnalytica`SymbolicInt`Private`mbeT3[m]^es[[3]] MBAnalytica`SymbolicInt`Private`mbeT4[m]^es[[4]])];
     {cm, es}]], terms]];

mbeDSSBOf[den_] := With[{m = Global`mbeMM}, Replace[den,
  {(m + bb_Integer)^_Integer /; bb > 0 :> bb,
   (m + bb_Integer) /; bb > 0 :> bb,
   c_. (m + bb_Integer)^_Integer /; bb > 0 && FreeQ[c, m] :> bb,
   c_. (m + bb_Integer) /; bb > 0 && FreeQ[c, m] :> bb,
   _ :> 0}]];

mbeDSSShiftOnce[{cm_, es_List}] := Module[
  {m = Global`mbeMM, ap, terms},
  ap = Apart[cm, m];
  terms = If[Head[ap] === Plus, List @@ ap, {ap}];
  Flatten[Map[Function[t, Module[{b = mbeDSSBOf[Denominator[Together[t]]]},
     If[b === 0, {{t, es}},
       Module[{tc = t /. m -> m - b,
               hsub = HarmonicNumber[m] - Sum[1/(m - j), {j, 0, b - 1}],
               t2sub = MBAnalytica`SymbolicInt`Private`mbeT2[m] + Sum[1/(m - j)^2, {j, 0, b - 1}],
               t3sub = MBAnalytica`SymbolicInt`Private`mbeT3[m] + Sum[1/(m - j)^3, {j, 0, b - 1}],
               t4sub = MBAnalytica`SymbolicInt`Private`mbeT4[m] + Sum[1/(m - j)^4, {j, 0, b - 1}],
               full},
         full = tc hsub^es[[1]] t2sub^es[[2]] t3sub^es[[3]] t4sub^es[[4]];
         MBAnalytica`SymbolicInt`Private`$mbeDSSBoundary -= Total[Table[full /.
            {HarmonicNumber[m] -> HarmonicNumber[jj],
             MBAnalytica`SymbolicInt`Private`mbeT2[m] -> Pi^2/6 - HarmonicNumber[jj, 2],
             MBAnalytica`SymbolicInt`Private`mbeT3[m] -> Zeta[3] - HarmonicNumber[jj, 3],
             MBAnalytica`SymbolicInt`Private`mbeT4[m] -> Pi^4/90 - HarmonicNumber[jj, 4],
             m -> jj},
           {jj, 1, b}]];
         mbeDSSToMons[Expand[full]]]]]], terms], 1]];

mbeDSSDivQ[{cm_, es_List}] := Module[{tg = Together[cm]},
  (* tail-aware decay: sum of c/m^k * T2^q T3^r T4^s converges iff
     k + q + 2 r + 3 s >= 2 (H powers only add logs). *)
  Exponent[Denominator[tg], Global`mbeMM] -
      Exponent[Numerator[tg], Global`mbeMM] +
      es[[2]] + 2 es[[3]] + 3 es[[4]] <= 1];

mbeDSSEval1[mono_] := Module[{hit},
  hit = Select[mbeDSSTab,
    FreeQ[Cancel[Together[mono/#[[1]]]], Global`mbeMM] &];
  If[Length[hit] >= 1,
    With[{e = hit[[1]]}, Cancel[Together[mono/e[[1]]]] e[[2]]],
    $Failed]];

mbeDegShiftSum[rS_, nFrom_Integer] := Module[
  {m = Global`mbeMM, nn = Global`mbeNN, rM, rH, mons, cur, nxt, it = 0,
   divs, vals, tail},
  MBAnalytica`SymbolicInt`Private`$mbeDSSBoundary = 0;
  rM = rS /. nn -> m + nFrom - 1;   (* sum over m >= 1 *)
  rH = mbeDSSNormPsi[rM];
  If[! FreeQ[rH, PolyGamma], Return[$Failed]];
  cur = mbeDSSToMons[Expand[rH]];
  While[it++ < 15,
    nxt = Flatten[mbeDSSShiftOnce /@ cur, 1];
    nxt = Map[Function[e,
      {Together[Total[Cases[nxt, {c_, e} :> c]]], e}],
      Union[nxt[[All, 2]]]];
    nxt = Select[nxt, ! PossibleZeroQ[#[[1]]] &];
    If[Sort[nxt] === Sort[cur], Break[]];
    cur = nxt];
  divs = Select[cur, mbeDSSDivQ];
  If[divs =!= {}, Return[$Failed]];
  vals = Map[Function[mn, Module[{ap, terms},
     ap = Apart[mn[[1]], m];
     terms = If[Head[ap] === Plus, List @@ ap, {ap}];
     Total[mbeDSSEval1[# HarmonicNumber[m]^mn[[2, 1]] *
        MBAnalytica`SymbolicInt`Private`mbeT2[m]^mn[[2, 2]] MBAnalytica`SymbolicInt`Private`mbeT3[m]^mn[[2, 3]] *
        MBAnalytica`SymbolicInt`Private`mbeT4[m]^mn[[2, 4]]] & /@ terms]]], cur];
  If[! FreeQ[vals, $Failed], Return[$Failed]];
  tail = Total[vals] + MBAnalytica`SymbolicInt`Private`$mbeDSSBoundary;
  Simplify[tail]];

(* ---------- the evaluator ---------- *)
mbeDegTrigEval[intg_, ctr_List, vrs_List] := Block[{$Assumptions = True},
  (* the route installs eps-inequality $Assumptions globally; FullSimplify's
     Assumptions option ADDS to $Assumptions, and the polluted conjunction
     stalls Sum/FullSimplify (S5, measured at 600s and 1200s caps while a
     clean-assumption kernel closes the same sums in seconds). *)
  mbeDegTrigEvalCore[intg, ctr, vrs]];

mbeDegTrigEvalCore[intg_, ctr_List, vrs_List] := Module[
  {v, c, red, quad, rL, rR, headL, headR, partL, partR, side, tail, head,
   exact, nn = Global`mbeNN, tQuad, hOff, exactSide},
  v = First[vrs]; c = ctr[[1, 2]];
  red = mbeTrigReduce[intg, v];
  If[! FreeQ[red, Gamma[a_ /; ! FreeQ[a, v]]],
    WriteString["stdout", "    [DegTrig:S1] reduction incomplete\n"]; Return[$Failed]];
  If[! mbeTrigGate[intg, red, v],
    WriteString["stdout", "    [DegTrig:S2] trig gate failed\n"]; Return[$Failed]];
  (* contour quadrature reference (DIAGNOSTIC GATE ONLY) *)
  quad = Quiet@TimeConstrained[
    NIntegrate[(red /. v -> c + I Global`mbeTT)/(2 Pi),
      {Global`mbeTT, -60, 60}, WorkingPrecision -> 25,
      PrecisionGoal -> 10, MaxRecursion -> 14], 300, $Failed];
  If[! NumericQ[quad],
    WriteString["stdout", "    [DegTrig:S3] quadrature failed\n"]; Return[$Failed]];
  (* 2026-07-20 GENERALIZED HEADS (MB10 offset-3 class): the symbolic tower
     residue is only valid where no psi/Gamma argument hits a nonpositive
     integer, i.e. for nn > hOff where hOff = max |integer offset| of the
     z-dependent Gamma/psi arguments in the ORIGINAL integrand. All poles
     with |z| <= hOff are HEADS, evaluated exactly one by one. The old code
     hard-wired hOff = 1 and broke (Indeterminate partial sums -> S4) on
     Gamma(-3-z)-type kernels. *)
  Module[{offs},
    offs = Union@Cases[intg, (Gamma | PolyGamma)[___, arg_] /;
        ! FreeQ[arg, v] :> Abs[arg /. v -> 0], Infinity];
    hOff = Max[1, Min[8, Max[Join[{1}, Select[offs, IntegerQ]]]]]];
  Block[{mbeDegAss = Element[Global`mbeNN, Integers] &&
      Global`mbeNN >= hOff + 1},
    rL = mbeDegResSym[red, v, -1]];   (* z = -nn, valid nn >= hOff+1 *)
  Block[{mbeDegAss = Element[Global`mbeNN, Integers] &&
      Global`mbeNN >= hOff + 1},
    rR = mbeDegResSym[red, v, +1]];   (* z = +nn, valid nn >= hOff+1 *)
  headL = Total@Table[mbeDegResExactAt[red, v, -kk], {kk, 1, hOff}];
  headR = Total@Table[mbeDegResExactAt[red, v, kk], {kk, 0, hOff}];
  partL = Quiet@N[headL + Sum[rL /. nn -> n2, {n2, hOff + 1, 40 + hOff}], 30];
  partR = -Quiet@N[headR + Sum[rR /. nn -> n2, {n2, hOff + 1, 40 + hOff}], 30];
  (* 2026-07-20 EXACT-FIRST SIDE SELECTION: psi0^2-dressed towers converge
     like log^2(n)/n, so 40-term partial sums miss quad by O(100) and the
     legacy 1e-3 partial-sum criterion can NEVER fire (MB10 offset-3 class).
     Instead compute BOTH exact tails with the deterministic shift-reduction
     summer (seconds) and pick the side whose exact total matches quad at
     1e-6; the legacy partial-sum criterion remains as fallback for pieces
     the summer cannot close. *)
  Module[{tailLx, tailRx, candL, candR},
    tailLx = Quiet@TimeConstrained[mbeDegShiftSum[rL, hOff + 1], 180, $Failed];
    tailRx = Quiet@TimeConstrained[mbeDegShiftSum[rR, hOff + 1], 180, $Failed];
    candL = If[tailLx =!= $Failed && FreeQ[tailLx, Sum | HarmonicNumber],
      headL + tailLx, $Failed];
    candR = If[tailRx =!= $Failed && FreeQ[tailRx, Sum | HarmonicNumber],
      -(headR + tailRx), $Failed];
    exactSide = Which[
      candL =!= $Failed && NumericQ[Quiet@N[candL]] &&
        Abs[Quiet@N[candL, 25] - quad] < 10^-6 (1 + Abs[quad]), candL,
      candR =!= $Failed && NumericQ[Quiet@N[candR]] &&
        Abs[Quiet@N[candR, 25] - quad] < 10^-6 (1 + Abs[quad]), candR,
      True, $Failed]];
  If[exactSide =!= $Failed,
    exact = FullSimplify[exactSide];
    Return[If[Abs[N[exact, 25] - quad] < 10^-8 (1 + Abs[quad]),
      exact, $Failed], Module]];
  side = Which[
    NumericQ[partL] && Abs[partL - quad] < 10^-3 (1 + Abs[quad]), "L",
    NumericQ[partR] && Abs[partR - quad] < 10^-3 (1 + Abs[quad]), "R",
    True, $Failed];
  If[side === $Failed,
    WriteString["stdout", "    [DegTrig:S4] side selection failed (partL=" <>
      ToString[N[partL]] <> " partR=" <> ToString[N[partR]] <> " quad=" <>
      ToString[N[quad]] <> ")\n"]; Return[$Failed]];
  (* Tail sums run in an ISOLATED BARE subkernel (ginsh-isolation pattern):
     the loaded stack's rule pollution stalls Sum in-kernel (measured: S5
     stalls at 600s and 1200s in-package while a bare kernel closes the same
     sum in seconds). Deterministic and context-immune. *)
  (* PRIMARY: deterministic shift-reduction summer (2026-07-20) — exact,
     seconds, covers the psi0^2 class that stalls the generic summers. *)
  {head, tail} = If[side === "L",
    {headL, Quiet@TimeConstrained[mbeDegShiftSum[rL, hOff + 1], 120, $Failed]},
    {headR, Quiet@TimeConstrained[mbeDegShiftSum[rR, hOff + 1], 120, $Failed]}];
  If[tail === $Failed || ! FreeQ[tail, Sum | HarmonicNumber],
    tail = If[side === "L",
      Quiet@TimeConstrained[
        FullSimplify[Sum[Apart[rL, nn], {nn, hOff + 1, Infinity}],
          Element[nn, Integers] && nn >= hOff + 1], 400, $Failed],
      Quiet@TimeConstrained[
        FullSimplify[Sum[Apart[rR, nn], {nn, hOff + 1, Infinity}],
          Element[nn, Integers] && nn >= hOff + 1], 400, $Failed]]];
  (* isolated-subkernel fallback if the in-kernel sum still stalls *)
  If[tail === $Failed || ! FreeQ[tail, Sum],
    tail = If[side === "L", mbeDegTailSumIsolated[rL, hOff + 1],
      mbeDegTailSumIsolated[rR, hOff + 1]]];
  If[tail === $Failed || ! FreeQ[tail, Sum],
    Module[{df = FileNameJoin[{$TemporaryDirectory,
        "degtrig_dump_" <> ToString[$ProcessID] <> "_" <>
        ToString[MBAnalytica`SymbolicInt`Private`$mbtDegDumpN = 
          If[IntegerQ[MBAnalytica`SymbolicInt`Private`$mbtDegDumpN],
            MBAnalytica`SymbolicInt`Private`$mbtDegDumpN + 1, 1]] <> ".m"}]},
      Put[{"side" -> side, "rL" -> rL, "rR" -> rR, "headL" -> headL,
           "headR" -> headR, "quad" -> quad, "assump" -> $Assumptions}, df];
      WriteString["stdout", "    [DegTrig:S5] exact tail sum stalled; dump " <>
        df <> "\n"]]; Return[$Failed]];
  exact = FullSimplify[If[side === "L", head + tail, -(head + tail)]];
  (* FINAL GATE *)
  If[Abs[N[exact, 25] - quad] < 10^-8 (1 + Abs[quad]),
    exact, $Failed]];

End[];
