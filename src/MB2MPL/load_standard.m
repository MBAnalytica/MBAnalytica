(* ::Package:: *)

(* Self-contained Standard-route loader for the MB_standard release (R2, 2026-09-07).
   Loads, in this order: the bundled PolyLogTools / HPL (weight 10) / HypExp stack, the sealed MB2MPL core, the
   MB / MBresolve / Barnes routines, the strategy engines (HyperIntica + hyperlogarithm integrator bridges), the
   IntVolFLINT strategy hook, and the class-handler rungs.  No certified piece library, no phase-block record and
   no IntVol knowledge library exist in this release: every Barnes piece is derived by the sealed core and the rungs.

   THE PACKAGES AND THEIR FUNCTION
   - MB2MPL (MB2MPL.m + the rungs mbe*.m + the engines + the worker): evaluates a dimensionally regulated
     Mellin-Barnes integral as an exact Laurent series in epsilon whose coefficients are multiple polylogarithms and
     multiple zeta values.  Authors: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias.
   - IntVol (IntVol_stable.m, IntVol_BigExpr_Helpers.m, intvol_*_prototype.m): the Euler-integral backend of MB2MPL:
     integrates the epsilon-free cubes over [0,1]^n by PolyLogTools fibration and GIntegrate with an order-rotation
     failsafe, lambda factorisation of quadratic denominators, Euclidean partial fractions, silent-zero rejection, and
     exact endpoint / interior-wall modules.  Author: Syed Mehedi Hasan.
   - IntVolFLINT (intvolflint/*.m, hf_machinery.m, vendor/IntVolFLINT): the certified-order hyperlogarithm strategy that
     the cube dispatcher tries first: native [0,1]-chart requests with the divergence certificate, a race of
     integration orders, symbolic kinematics and rationalisation of algebraic letters, G/HPL-to-hyperlogarithm
     conversion, and the exact evaluation of the returned words.  Author: Syed Mehedi Hasan.  It runs on two backends
     by other authors: the hyperlogarithm integrator HyperFLINT (vendor/IntVolFLINT is a fork of HyperFLINT 1.2.13)
     and the word evaluator HyperIntica, both from SubTropica by M. Giroux, S. Mizera and G. Salvatori
     (arXiv:2604.20954); HyperIntica is a native Mathematica reimplementation of E. Panzer's HyperInt (arXiv:1403.3385).
   - Vendored packages: PolyLogTools (C. Duhr, F. Dulat), HPL (D. Maitre), HypExp (T. Huber, D. Maitre);
     MB.m (M. Czakon) and MBresolve.m (A. V. Smirnov, V. A. Smirnov) in the root.
   - The Subtraction route (Route -> "Subtraction") is served by the one-fold tower-closure rung
     mbeOneFoldTowerRung.m and the faithful-cube rung mbeFaithfulCubeRung.m. *)

Off[General::shdw];
Module[{here, configure, polyLogTools, mathCandidates, mathExecutable, hplPlain, hplPM, hplMZVMax, rung},
  here = DirectoryName[ExpandFileName[$InputFileName]];
  If[here === "" || here === ".", here = Directory[]];
  SetDirectory[here];

  configure = FileNameJoin[{here, "configure_runtime.m"}];
  Get[configure];

  (* no IntVol knowledge library: IntVol_stable.m's optional attach block is a no-op *)
  Global`$IV$NoLibrary = True;
  SetEnvironment["IVLIB_OFF" -> "1"];

  polyLogTools = FileNameJoin[{Global`$PolyLogPath, "PolyLogTools.m"}];
  If[! MemberQ[$Packages, "PolyLogTools`"], Get[polyLogTools]];
  If[! MemberQ[$Packages, "HypExp`"], Quiet@Needs["HypExp`"]];
  If[! MemberQ[$Packages, "MBtoMPL`"], Get[FileNameJoin[{here, "MB2MPL.m"}]]];
  (* the sealed core's certified-library option is a no-op without library data; make the setting explicit *)
  Quiet@SetOptions[MBtoMPL`MBresolveToMPL, "UseCertifiedLibrary" -> False];
  MBtoMPL`Private`$mbtUseCertifiedLibrary = False;

  Quiet@Get[FileNameJoin[{here, "mbeSeqIntegrate.m"}]];
  Quiet@Get[FileNameJoin[{here, "mbePinchClose.m"}]];
  Get[FileNameJoin[{here, "MB.m"}]];
  Get[FileNameJoin[{here, "MBresolve.m"}]];
  Get[FileNameJoin[{here, "barnesroutines.m"}]];
  If[! TrueQ[Global`$mbeSkipEngines],
    Quiet@Get[FileNameJoin[{here, "load_mbe_engines.m"}]]];

  (* IntVolFLINT strategy hook (default ON; opt-out: env IVF_HOOK=0 or Global`$IVFUseIntVolFLINT = False before
     this loader).  The decision is exported as IVF_HOOK so that PieceKernels workers follow the master. *)
  If[! TrueQ[Global`$mbeSkipEngines] && Environment["IVF_HOOK"] =!= "0" && Global`$IVFUseIntVolFLINT =!= False,
    Quiet@CheckAbort[
      (If[! ValueQ[Global`$IVFUseIntVolFLINT], Global`$IVFUseIntVolFLINT = True];
       Get[FileNameJoin[{here, "intvolflint", "ivf_machinery.m"}]];
       Global`$ivfBin = Global`$MBStandardHyperFLINTBinary;
       Get[FileNameJoin[{here, "intvolflint", "ivf_dispatch_hook.m"}]];
       Get[FileNameJoin[{here, "intvolflint", "ivf_ext_finitepart_gconv.m"}]]), Null];
    If[DownValues[Global`IVFPrevIntVolIntegrate] === {} || DownValues[Global`IVFOrigIntegrateCube] === {},
      Print["[MB_standard] IntVolFLINT hook FAILED to install \[LongDash] old engine chain in force"]]];
  SetEnvironment["IVF_HOOK" -> If[TrueQ[Global`$IVFUseIntVolFLINT], "1", "0"]];

  mathCandidates = {
    Quiet@Check[FindExecutable["math"], $Failed],
    FileNameJoin[{$InstallationDirectory, "Executables", "math"}],
    FileNameJoin[{$InstallationDirectory, "Executables", "WolframKernel"}]};
  mathExecutable = SelectFirst[mathCandidates, StringQ[#] && FileExistsQ[#] &, ""];

  MBtoMPL`Private`$mbtPolyLogToolsFile = polyLogTools;
  MBtoMPL`Private`$mbtBarnesRoutinesPath = If[StringEndsQ[here, $PathnameSeparator], here, here <> $PathnameSeparator];
  MBtoMPL`Private`$mbtMathExecutable = mathExecutable;
  MBtoMPL`Private`$mbtDoABCacheDir = FileNameJoin[{here, ".cache", "doab"}] <> $PathnameSeparator;
  MBtoMPL`Private`$mbtMB2MPLDiskCacheDir = FileNameJoin[{here, ".cache", "mb2mpl"}] <> $PathnameSeparator;
  Quiet@CreateDirectory[MBtoMPL`Private`$mbtDoABCacheDir, CreateIntermediateDirectories -> True];
  Quiet@CreateDirectory[MBtoMPL`Private`$mbtMB2MPLDiskCacheDir, CreateIntermediateDirectories -> True];

  (* HarmonicSums is not shipped (2026-09-08): no rung uses it, and the sealed core's optional HarmonicSums closer
     (a one-fold fast path that never served a value on the benchmark corpus) is disabled here, so every piece goes
     through the rungs, IntVol and IntVolFLINT *)
  MBtoMPL`Private`mbeLoadHarmonicSums[] := $Failed;
  MBtoMPL`Private`mbeRebindHSTables[] := $Failed;

  (* per-process GiNaC interface directory (safe concurrent ginsh use) *)
  PolyLogTools`GiNaC$InterfacePath = FileNameJoin[{$TemporaryDirectory, "mb_standard_ginsh_" <> ToString[$ProcessID]}] <> $PathnameSeparator;
  Quiet@CreateDirectory[PolyLogTools`GiNaC$InterfacePath, CreateIntermediateDirectories -> True];

  (* ---- the class-handler rungs (sidecars wrapping saved definitions; the sealed core is never edited) ---- *)
  Do[rung = FileNameJoin[{here, r}];
     If[FileExistsQ[rung], Quiet@Get[rung], Print["[MB_standard] ERROR: rung missing: ", r]; Abort[]],
    {r, {"mbeReflZero.m", "mbeAffineBellRung.m", "mbeTwoVarPsiRung.m", "mbeLevel6Reduce.m", "mbeBarnesPreReduce.m",
         "mbeBarnes2PsiReduce.m", "mbeResonantResolve.m", "mbeFaithfulCubeRung.m", "mbeOneFoldTowerRung.m",
         (* release R3 (29 September 2026): the rungs of the general multifold handler of the Subtraction route --
            regulated towers, the interval-certified Barnes rung, the HypExp block bank, the Abel and Mellin towers,
            the separating and continued five-Gamma classes, the trig-kernel closer, the Euler class rungs, the
            convergence certificate and the exact last fold, the multifold family rung *)
         "mbeRegulatedTowerRung.m", "mbeSubtractionBarnesRung.m", "mbeHypExpBlockBank.m", "mbeAbelTowerRung.m",
         "mbe_barnes_lib.m", "mbeMellinTowerRung.m", "mbeSubtractionGaussBarnesRung.m", "mbeGaussBarnesContinuationRung.m",
         "mbeRegularHPLBoundaryRung.m", "mbeFixedLetterGPLRung.m", "mbeSharedAffineGaussRung.m", "mbeSharedAffineStarRung.m",
         "mbeSharedAffinePairRung.m", "mbeGaussBranchJobs.m", "mbeAffineEulerLeafRung.m", "mbeAffineLogMomentRung.m",
         "mbeWeightedAffineLogMomentRung.m", "mbeSeparableEulerRung.m", "mbeBilinearBetaRung.m", "mbeAffineBlendRung.m",
         "mbeFiniteEulerSumRung.m", "mbeEulerCompositionRung.m", "mbeTrigKernelRung.m",
         "mbePositiveCubePowerCount.m", "mbeJobConvergenceRung.m", "mbeParameterSubtractionRoots.m", "mbeExactLastFoldRung.m",
         "mbeExternalParameterRung.m", "mbeParameterResidueRung.m", "mbeParameterEulerRung.m",
         "mbeParameterTransverseRung.m", "mbeParameterSixGammaRung.m", "mbeParameterBarnesSecondRung.m",
         (* release R3.1 (3 October 2026): the u-dependent SUBTRACTION route (development tree, 22 September 2026): exact scaled
            Barnes closure + regulated Gauss word recurrence, parameter factor times unscaled towers, faithful Euler cubes
            with parameter signs certified on the open unit domain, native periods to endpoint-regularized GPL words;
            mbeExternalParameterRung.m dispatches Route -> "Subtraction" with external parameters here *)
         "mbeParameterSubtractionRung.m", "mbeParameterSubtractionSeries.m", "mbeParameterSubtractionCube.m",
         "mbeParameterSubtractionDispatch.m", "mbeParameterSubtractionHighFold.m",
         "mbeMultifoldFamilyRung.m"}}];

  (* ---- the general multifold handler of the Subtraction route (release R3, 29 September 2026) ----
     mbeMultifoldHandler.m: u-integration at the MB level, stabilized finite-eps Barnes chains with unimodular pivots,
     the gated pair census, the closing chain of multifold_close/ (closed forms, the Mellin-Parseval decoupling, the
     piece worker, the slope-two closer), the eta step and the family sum; mfhInstall[] puts it into the multi-fold
     slot of the Subtraction family driver (Global`oftMultiFoldHandler), the previous chain kept as the fallback.
     Set Global`$mfhAutoInstall = False before loading to keep the R2 behaviour. *)
  rung = FileNameJoin[{here, "mbeMultifoldHandler.m"}];
  If[FileExistsQ[rung], Quiet@Get[rung];
    If[!ValueQ[Global`$mfhAutoInstall], Global`$mfhAutoInstall = True];
    If[TrueQ[Global`$mfhAutoInstall] && DownValues[Global`mfhInstall] =!= {}, Global`mfhInstall[]],
    Print["[MB_standard] ERROR: rung missing: mbeMultifoldHandler.m"]; Abort[]];

  (* ---- release R3.1: parallel residues of the Subtraction family route (mbeResidueStore.m) ----
     the closed multi-fold residues go to a store under .cache/oft_residues (key: code state, residue, orders); for a
     family with several multi-fold residues, helper processes (oft_residue_helper.wls, within the main-kernel budget of
     the resource policy) close them in other orders while this kernel runs the family route and reads what they
     closed.  Global`$oftResidueStore = False before loading keeps the family route of release R3. *)
  rung = FileNameJoin[{here, "mbeResidueStore.m"}];
  If[FileExistsQ[rung], Get[rung], Print["[MB_standard] ERROR: rung missing: mbeResidueStore.m"]; Abort[]];

  (* ---- the package switches survive an interrupted call (mbeFlagGuard.m) ----
     HPL and HypExp change their automatic-conversion switches globally during a call and restore them at its end; a
     call stopped by a time limit left them changed for the rest of the kernel's life.  The guard wraps the HypExp
     routines by their saved definitions and gives the handler and the workers a reset to the values found here, at
     the end of the loader. *)
  rung = FileNameJoin[{here, "mbeFlagGuard.m"}];
  If[FileExistsQ[rung], Get[rung], Print["[MB_standard] ERROR: rung missing: mbeFlagGuard.m"]; Abort[]];

  hplPlain = Quiet@Check[HPL`Private`MinimalSetLoaded, {}];
  hplPM = Quiet@Check[HPL`Private`MinimalSetpmLoaded, {}];
  hplMZVMax = Quiet@Check[HPL`Private`$MaxMZVTables, $Failed];
  Global`$MBStandardHigherWeightStatus = <|"HPLPlainWeights" -> hplPlain, "HPLPlusMinusWeights" -> hplPM,
    "MZVTableMaximumWeight" -> hplMZVMax|>;
  If[hplPlain =!= Range[2, 10] || hplPM =!= Range[2, 10] || hplMZVMax =!= 10,
    Print["[MB_standard] ERROR: weight-10 extension did not load completely: ", Global`$MBStandardHigherWeightStatus];
    Abort[]];

  Global`$MBStandardLoaded = True;
  Print["[MB_standard] MB2MPL, Standard route (R3; parameter extension 2026-09-21; general multifold handler 2026-09-29). Authors: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias."];
  Print["[MB_standard] IntVol (Euler-integral backend) and IntVolFLINT (certified-order hyperlogarithm strategy): author Syed Mehedi Hasan."];
  Print["[MB_standard] IntVolFLINT backends: HyperFLINT (fork of 1.2.13) and HyperIntica by M. Giroux, S. Mizera, G. Salvatori (SubTropica, arXiv:2604.20954); HyperIntica reimplements E. Panzer's HyperInt."];
  Print["[MB_standard] Vendored: PolyLogTools (C. Duhr, F. Dulat), HPL (D. Maitre), HypExp (T. Huber, D. Maitre); MB.m (M. Czakon), MBresolve.m (A. V. Smirnov, V. A. Smirnov)."];
  Print["[MB_standard] READY: exact Standard route (sealed core + rungs, no library); HPL/MZV weight 10; ",
    "IntVol + IntVolFLINT (", If[TrueQ[Global`$IVFUseIntVolFLINT], "ON", "off"], ") + HyperIntica; rungs installed: ",
    DownValues[Global`bwsStdCloseOrig] =!= {} && TrueQ[Global`$bwsCachedWrapInstalled] && DownValues[Global`mbeBarnesPreReduce] =!= {} &&
    TrueQ[Global`$mbrWrapInstalled], "; multifold handler installed: ", DownValues[Global`mfhResidue] =!= {} && DownValues[Global`mfhPreviousMultiFoldHandler] =!= {}];
  If[mathExecutable === "",
    Print["[MB_standard] NOTE: no Mathematica command-line kernel was found; PieceKernels will fall back to serial execution."]];
];
