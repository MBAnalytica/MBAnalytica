(* ::Package:: *)
(* AUTHORSHIP (release R2, 2026-09-07): MB2MPL Standard-route notebook driver. Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)

(* MB2MPL self-contained Standard-route notebook support (release R2, sealed 2026-09-07).
   This file is the executable source behind MB2MPL_StandardRoute.nb.  It defines every benchmark target of the
   release explicitly (MB1--MB14, with MB8 as the sum of the two phase-free five-folds MB8a + MB8b and MB14 as the
   sum of the two eight-folds MB14a + MB14b, and the pilot integrals MBpilot12, MBpilot13), reports every
   available benchmark coefficient, and runs one integral at
   a time through the sealed Standard route with the class-handler rungs.  The piece workers are parallel subkernels:
   $MBSerialPieceKernels (set it before loading) is the MAXIMUM -- Automatic, the default, means every subkernel the
   licence allows up to the cores of the machine; an integer is the user's own maximum -- and the package launches the
   smaller of it, the licence's subkernel allowance, the cores and the piece count, printing the number;
   $MBSerialWorkerMode = "Processes" uses separate math kernels instead (one main-kernel licence seat each); 0 =
   strictly serial, far slower and never the default.  Nothing is evaluated automatically: after loading,
   call MBSerialRunAll[] or the per-target functions.  All runtime dependencies are loaded relative to this file. *)

mbSerialBaseDirectory = DirectoryName[ExpandFileName[$InputFileName]];
If[mbSerialBaseDirectory === "", mbSerialBaseDirectory = Directory[]];
SetDirectory[mbSerialBaseDirectory];

Get[FileNameJoin[{mbSerialBaseDirectory, "load_standard.m"}]];
Get[FileNameJoin[{mbSerialBaseDirectory, "mb_targets_all.m"}]];

ClearAll[
  mbSerialSeriesFromRules, mbSerialRequestedMax, mbSerialTarget,
  mbSerialInexactNumberFreeQ, mbSerialNumericValue,
  mbSerialComparisonRows, mbSerialCheckpointPath, mbSerialSectionResult,
  mbSerialLoadCheckpoint, mbSerialSaveCheckpoint, MBSerialLedger,
  mbSerialDependencyDigest, mbSerialRunRoute,
  MBSerialBenchmarkReport, MBSerialRunOne, MBSerialRunSection, MBSerialRunAll,
  MBSerialSummary, MBSerialReport, MBStandardEvaluate, MBSubtractionEvaluate,
  mbSerialVerifiedMax, mbSerialRouteTargetNames
];

mbSerialEpsilon = \[Epsilon];
(* CONVENTION: Zeta[5,3] in the benchmark expressions of mb_targets_all.m denotes the MULTIPLE ZETA VALUE zeta(5,3) =
   Sum_{n>m>=1} 1/(n^5 m^3) = 0.0377076729848475440113..., NOT Mathematica's Hurwitz zeta function Zeta[5,3] =
   0.00567775...; every numerical comparison substitutes the value below, and the exact comparison identifies the route's
   HPL`HPLs8a (= S(5,3;infinity) = zeta(8) + zeta(5,3)) with Zeta[8] + Zeta[5,3] symbolically (mbSerialComparisonRows). *)
mbSerialZeta53 = 0.03770767298484754401136;

(* A checkpoint is valid only for the complete analytic implementation that produced it: hash the driver, the sealed
   core, the engines, every rung and the higher-weight package files. *)
mbSerialDependencyFiles = DeleteDuplicates[ExpandFileName /@ {
  FileNameJoin[{mbSerialBaseDirectory, "MB2MPL_StandardRoute.wl"}],
  FileNameJoin[{mbSerialBaseDirectory, "load_standard.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "configure_runtime.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "MB2MPL.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "MB.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "MBresolve.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "barnesroutines.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "IntVol_stable.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "IntVol_BigExpr_Helpers.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbe_strategy_dispatch_v2.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "engineN_lib.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "engineN_grouped_lib.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "hf_machinery.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "load_mbe_engines.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "intvolflint", "ivf_machinery.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "intvolflint", "ivf_dispatch_hook.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "intvolflint", "ivf_ext_finitepart_gconv.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeSeqIntegrate.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbePinchClose.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeReflZero.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeAffineBellRung.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbe_affine_bell_lib.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeTwoVarPsiRung.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeLevel6Reduce.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeBarnesPreReduce.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeBarnes2PsiReduce.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeResonantResolve.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeOneFoldTowerRung.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeFaithfulCubeRung.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeExternalParameterRung.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeParameterResidueRung.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeParameterEulerRung.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeParameterTransverseRung.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeParameterSixGammaRung.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeParameterBarnesSecondRung.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbeResolveLP.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "parameter_support", "contour_check.py"}],
  FileNameJoin[{mbSerialBaseDirectory, "mb_u_targets.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mbt_piece_worker.m"}],
  FileNameJoin[{mbSerialBaseDirectory, "mb_targets_all.m"}],
  FileNameJoin[{Global`$PolyLogPath, "PolyLogTools.m"}],
  FileNameJoin[{Global`$PolyLogPath, "core", "GiNaCInterface.m"}],
  FileNameJoin[{Global`$PolyLogPath, "core", "Reduction.m"}],
  FileNameJoin[{Global`$HPLPath, "HPL.m"}],
  FileNameJoin[{Global`$HPLPath, "hpl910_constants.m"}],
  FileNameJoin[{Global`$HypExpPath, "HypExp.m"}]
}];
(* release R3.1: every rung, closer and native driver of the package and both integrator binaries belong to the code
   state too (the handler, the family rung and the parameter Subtraction ladder were missing from the list above) *)
mbSerialDependencyFiles = DeleteDuplicates[Join[mbSerialDependencyFiles, ExpandFileName /@ Select[Join[
    FileNames["mbe*.m", mbSerialBaseDirectory], FileNames["mbe*.py", mbSerialBaseDirectory],
    FileNames["*.m", FileNameJoin[{mbSerialBaseDirectory, "multifold_close"}]],
    FileNames["*.m", FileNameJoin[{mbSerialBaseDirectory, "intvolflint"}]],
    {Global`$MBStandardHyperFLINTBinary, Global`$MBStandardHyperFLINTGuardedBinary}], StringQ[#] && FileExistsQ[#] &]]];
mbSerialDependencyDigest[path_String] := If[FileExistsQ[path],
  IntegerString[FileHash[path, "SHA256"], 16, 64], "MISSING"];
mbSerialDependencyHashes = Association @ Map[# -> mbSerialDependencyDigest[#] &, mbSerialDependencyFiles];
mbSerialPackageHash = IntegerString[Hash[Normal[mbSerialDependencyHashes], "SHA256"], 16, 64];

mbSerialSeriesFromRules[rules_List] := Total[(Last[#] mbSerialEpsilon^First[#]) & /@ rules];

(* BenchmarkMax is the highest order available in the benchmark expression of mb_targets_all.m.  SealedStandardMax
   (SealedSubtractionMax) is the highest order verified exactly by the release regression of the Standard
   (Subtraction) route (RUNTIME_RECORD.txt).  RecordedSeconds is the wall time of the Standard regression for the
   sealed range, every piece derived from scratch (resources in RUNTIME_RECORD.txt); it is a measurement, not a
   promise.  MB8 and MB14 are evaluated as the sums of their two components. *)
mbSerialTargets = {
  <|"Name" -> "MB1", "Folds" -> 1, "Integral" -> MB1,
    "Benchmark" -> MB1Val, "BenchmarkSource" -> "MB1Val (exact)",
    "OrderMin" -> -3, "BenchmarkMax" -> 5, "SealedStandardMax" -> 1, "SealedSubtractionMax" -> 5,
    "RecordedSeconds" -> 123, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB2", "Folds" -> 1, "Integral" -> MB2,
    "Benchmark" -> MB2Val, "BenchmarkSource" -> "MB2Val (exact)",
    "OrderMin" -> -2, "BenchmarkMax" -> 4, "SealedStandardMax" -> 0, "SealedSubtractionMax" -> 4,
    "RecordedSeconds" -> 6, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB3", "Folds" -> 2, "Integral" -> MB3,
    "Benchmark" -> MB3Val, "BenchmarkSource" -> "MB3Val (exact)",
    "OrderMin" -> -4, "BenchmarkMax" -> 4, "SealedStandardMax" -> 0, "SealedSubtractionMax" -> 4,
    "RecordedSeconds" -> 443, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB4", "Folds" -> 2, "Integral" -> MB4,
    "Benchmark" -> MB4Val, "BenchmarkSource" -> "MB4Val (exact)",
    "OrderMin" -> -7, "BenchmarkMax" -> 1, "SealedStandardMax" -> -3, "SealedSubtractionMax" -> 1,
    "RecordedSeconds" -> 99, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)",
    "Note" -> "Subtraction route: the two 0-fold and the two 1-fold residues are exact at every benchmark order; the 2-fold residue is closed by the faithful-cube rung (mbeFaithfulCubeRung.m: a 5-variable Euler cube, 70 pieces over the cube orders eps^0..eps^4, banked per order and per piece under .cache/fcu/). Verified eps^-7..eps^1 = the full benchmark: eps^-7..eps^0 canonically exact, eps^1 numerically to 29 digits with Zeta[5,3] read as the multiple zeta value. Timing: see RUNTIME_RECORD.txt."|>,
  <|"Name" -> "MB5", "Folds" -> 4, "Integral" -> MB5,
    "Benchmark" -> MB5Val, "BenchmarkSource" -> "MB5Val (exact)",
    "OrderMin" -> -7, "BenchmarkMax" -> 1, "SealedStandardMax" -> -3, "SealedSubtractionMax" -> -1,
    "SubtractionKernels" -> {"MB5u"},
    "RecordedSeconds" -> 549, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB6", "Folds" -> 3, "Integral" -> MB6,
    "Benchmark" -> MB6Val, "BenchmarkSource" -> "MB6Val (exact)",
    "OrderMin" -> -6, "BenchmarkMax" -> 2, "SealedStandardMax" -> -2, "SealedSubtractionMax" -> 0,
    "SubtractionKernels" -> {"MB6u"},
    "RecordedSeconds" -> 6273, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB7", "Folds" -> 1, "Integral" -> MB7,
    "Benchmark" -> MB7Val, "BenchmarkSource" -> "MB7Val (exact)",
    "OrderMin" -> -5, "BenchmarkMax" -> 3, "SealedStandardMax" -> -1, "SealedSubtractionMax" -> 3,
    "RecordedSeconds" -> 111, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB8", "Folds" -> 5, "Integral" -> None, "Components" -> {MB8a, MB8b},
    "ComponentNames" -> {"MB8a", "MB8b"},
    "Benchmark" -> MB8Val, "BenchmarkSource" -> "MB8Val (exact); MB8 = MB8a + MB8b (two phase-free five-folds)",
    "OrderMin" -> -7, "BenchmarkMax" -> 1, "SealedStandardMax" -> -3, "SealedSubtractionMax" -> -3,
    "SubtractionFamilies" -> {"MB8au", "MB8bu"},
    "RecordedSeconds" -> 3400, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB9", "Folds" -> 3, "Integral" -> MB9,
    "Benchmark" -> MB9Val, "BenchmarkSource" -> "MB9Val (exact)",
    "OrderMin" -> -7, "BenchmarkMax" -> 1, "SealedStandardMax" -> -3, "SealedSubtractionMax" -> 1,
    "SubtractionKernels" -> {"MB9u"},
    "RecordedSeconds" -> 510, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB10", "Folds" -> 3, "Integral" -> MB10,
    "Benchmark" -> MB10Val, "BenchmarkSource" -> "MB10Val (exact)",
    "OrderMin" -> -7, "BenchmarkMax" -> 1, "SealedStandardMax" -> -3, "SealedSubtractionMax" -> -1,
    "SubtractionKernels" -> {"MB10u"},
    "RecordedSeconds" -> 771, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB11", "Folds" -> 4, "Integral" -> MB11,
    "Benchmark" -> MB11Val, "BenchmarkSource" -> "MB11Val (exact)",
    "OrderMin" -> -7, "BenchmarkMax" -> 1, "SealedStandardMax" -> -3, "SealedSubtractionMax" -> -1,
    "SubtractionKernels" -> {"MB11u"},
    "RecordedSeconds" -> 1487, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)",
    "Note" -> "resonant representation (an exact zero-sum cycle of Gamma arguments): MBresolve finds no straight contour; the analytic continuation in regulators inserted on a hitting set of the cycles is performed by the resonant-resolution rung mbeResonantResolve.m"|>,
  <|"Name" -> "MB12", "Folds" -> 6, "Integral" -> MB12,
    "Benchmark" -> MB12Val, "BenchmarkSource" -> "MB12Val (exact)",
    "OrderMin" -> -5, "BenchmarkMax" -> 3, "SealedStandardMax" -> -1, "SealedSubtractionMax" -> -1,
    "RecordedSeconds" -> 2711, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB13", "Folds" -> 7, "Integral" -> MB13,
    "Benchmark" -> MB13Val, "BenchmarkSource" -> "MB13Val (exact)",
    "OrderMin" -> -7, "BenchmarkMax" -> 1, "SealedStandardMax" -> -3, "SealedSubtractionMax" -> -3,
    "RecordedSeconds" -> 573, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MB14", "Folds" -> 8, "Integral" -> None, "Components" -> {MB14a, MB14b},
    "ComponentNames" -> {"MB14a", "MB14b"},
    "Benchmark" -> MB14Val, "BenchmarkSource" -> "MB14Val (exact); MB14 = MB14a + MB14b (two eight-folds)",
    "OrderMin" -> -7, "BenchmarkMax" -> 1, "SealedStandardMax" -> -3, "SealedSubtractionMax" -> -3,
    "SubtractionFamilies" -> {"MB14au", "MB14bu"},
    "RecordedSeconds" -> 2352, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MBpilot12", "Folds" -> 1, "Integral" -> MBpilot12,
    "Benchmark" -> MB1Val, "BenchmarkOfRecord" -> mbSerialSeriesFromRules[MBpilot12Bench],
    "BenchmarkSource" -> "MB1Val (exact; MBpilot12 == MB1 through eps^0); MBpilot12Bench cross-check",
    "OrderMin" -> -3, "BenchmarkMax" -> 0, "SealedStandardMax" -> 0, "SealedSubtractionMax" -> 0,
    "RecordedSeconds" -> 75, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>,
  <|"Name" -> "MBpilot13", "Folds" -> 1, "Integral" -> MBpilot13,
    "Benchmark" -> MB2Val, "BenchmarkOfRecord" -> mbSerialSeriesFromRules[MBpilot13Bench],
    "BenchmarkSource" -> "MB2Val (exact physical Re through eps^0); MBpilot13Bench cross-check",
    "OrderMin" -> -2, "BenchmarkMax" -> 0, "SealedStandardMax" -> 0, "SealedSubtractionMax" -> 0,
    "RecordedSeconds" -> 5, "TimingSource" -> "release regression (RUNTIME_RECORD.txt; every piece from scratch, no cache)"|>
};

If[! ValueQ[$MBSerialOrderMode], $MBSerialOrderMode = "SealedStandard"];
(* 2026-09-07: the worker count is a MAXIMUM.  The workers are parallel subkernels (every licence provides some).
   $MBSerialPieceKernels = Automatic (the notebook default) means all the subkernels the licence allows, up to the
   cores of the machine (Min[$MaxLicenseSubprocesses, cores - 1]); an integer is a maximum of the user's choice; the
   package launches Min[request, licence allowance, cores - 1, pieces] and prints what it launched; 0 = strictly
   serial (far slower, never the default).  $MBSerialWorkerMode = "Processes" selects the former separate math
   kernels (one main-kernel licence seat each) instead of subkernels. *)
If[! ValueQ[$MBSerialPieceKernels], $MBSerialPieceKernels = Automatic];
If[! ValueQ[$MBSerialWorkerMode], $MBSerialWorkerMode = "Subkernels"];
Global`$mbtWorkerMode = $MBSerialWorkerMode;
(* Automatic = the resource policy of the piece-worker launcher (mbeTwoVarPsiRung.m PART D, 2026-09-08): half of a
   large licence's subkernels, every subkernel of a small licence, never more than the cores, shared with this user's
   running jobs; the launcher prints the number it started. *)
mbSerialWorkerRequest[] := Which[
  IntegerQ[$MBSerialPieceKernels] && $MBSerialPieceKernels >= 0, $MBSerialPieceKernels,
  DownValues[Global`mbtWorkerBudget] =!= {}, Global`mbtWorkerBudget[],
  True, Min[If[IntegerQ[$MaxLicenseSubprocesses], $MaxLicenseSubprocesses, 16], Max[1, $ProcessorCount - 1]]];
(* 2026-09-08: the route.  "Standard" (default) is the sealed Standard route; "Subtraction" is the Subtraction route
   with the one-fold tower-closure rung (mbeOneFoldTowerRung.m), which evaluates MB1, MB2, MB7
   and MB4 to their full benchmark range.  Checkpoints of the two routes are kept apart. *)
If[! ValueQ[$MBSerialRoute], $MBSerialRoute = "Standard"];
If[! ValueQ[$MBSerialDiskCache], $MBSerialDiskCache = True];
If[! ValueQ[$MBSerialResume], $MBSerialResume = True];
If[! ValueQ[$MBSerialVerbose], $MBSerialVerbose = False];
If[! ValueQ[$MBSerialTolerance], $MBSerialTolerance = 10^-6];
(* the sealed core's global watchdog is 2400 s; the notebook budget is finite and user-adjustable *)
If[! ValueQ[$MBSerialGlobalSeconds], $MBSerialGlobalSeconds = 43200];

(* the verified maximum of the selected route: SealedStandardMax for the Standard route, SealedSubtractionMax (present
   only for the targets the Subtraction route has been verified on) for the Subtraction route *)
mbSerialVerifiedMax[row_Association] := If[$MBSerialRoute === "Subtraction",
  Lookup[row, "SealedSubtractionMax", row["SealedStandardMax"]], row["SealedStandardMax"]];
mbSerialRouteTargetNames[] := If[$MBSerialRoute === "Subtraction",
  Lookup[Select[mbSerialTargets, KeyExistsQ[#, "SealedSubtractionMax"] &], "Name"], Lookup[mbSerialTargets, "Name"]];
mbSerialRequestedMax[row_Association] := Switch[$MBSerialOrderMode,
  "SealedStandard", mbSerialVerifiedMax[row],
  "BenchmarkMaximum", row["BenchmarkMax"],
  _, Message[MBSerialRunAll::mode, $MBSerialOrderMode]; $Failed];

MBSerialRunAll::mode = "Unknown order mode `1`. Use \"SealedStandard\" or \"BenchmarkMaximum\".";

mbSerialTarget[name_String] := SelectFirst[mbSerialTargets, #["Name"] === name &, Missing["UnknownTarget", name]];

MBSerialLedger[] := Dataset @ Map[
  Function[row,
    <|"MB" -> row["Name"], "Folds" -> row["Folds"],
      "BenchmarkMin" -> row["OrderMin"], "BenchmarkMax" -> row["BenchmarkMax"],
      "SealedStandardMax" -> row["SealedStandardMax"],
      "SealedSubtractionMax" -> Lookup[row, "SealedSubtractionMax", Missing["NotVerified"]],
      "UnsealedOrdersRemaining" -> row["BenchmarkMax"] - mbSerialVerifiedMax[row],
      "RecordedRange" -> {row["OrderMin"], row["SealedStandardMax"]},
      "RecordedSeconds" -> row["RecordedSeconds"], "TimingSource" -> row["TimingSource"],
      "Note" -> Lookup[row, "Note", ""]|>], mbSerialTargets];

MBSerialBenchmarkReport[name_: All] := Module[{targets},
  targets = If[name === All, mbSerialTargets, {mbSerialTarget[name]}];
  If[MemberQ[targets, _Missing], Return[First @ Select[targets, MissingQ]]];
  Dataset @ Flatten @ Map[
    Function[row,
      Table[<|"MB" -> row["Name"], "EpsilonOrder" -> k,
          "Benchmark" -> SeriesCoefficient[row["Benchmark"], {mbSerialEpsilon, 0, k}],
          "BenchmarkOfRecord" -> If[KeyExistsQ[row, "BenchmarkOfRecord"],
            SeriesCoefficient[row["BenchmarkOfRecord"], {mbSerialEpsilon, 0, k}],
            SeriesCoefficient[row["Benchmark"], {mbSerialEpsilon, 0, k}]],
          "BenchmarkSource" -> row["BenchmarkSource"]|>, {k, row["OrderMin"], row["BenchmarkMax"]}]], targets]];

mbSerialInexactNumberFreeQ[expression_] := Cases[expression,
    number_?NumberQ /; Precision[Unevaluated[number]] =!= Infinity :> number, {0, Infinity}, Heads -> True] === {};

mbSerialNumericValue[expression_] := Module[{value},
  value = Quiet @ Check[N[expression, 30], $Failed];
  If[NumberQ[value], Return[value]];
  If[DownValues[gvN] =!= {},
    value = Quiet @ Check[gvN[expression], $Failed];
    If[NumberQ[value], Return[N[value, 30]]]];
  $Failed];

(* exact comparison in the prime-log canonical form (logarithms of positive rationals expanded over their prime
   factorisation, an exact identity), then Expand; the simplifier is consulted only if that is not literally 0 *)
mbSerialPrimeLog[e_] := e /. Log[q_ /; (IntegerQ[q] || Head[q] === Rational) && q > 0] :>
  Total[(#[[2]] Log[#[[1]]]) & /@ FactorInteger[q]];
mbSerialExactZeroQ[d_] := Module[{c = Quiet@Expand[mbSerialPrimeLog[d]]},
  c === 0 || TrueQ[Quiet@PossibleZeroQ[Simplify[c]]]];

mbSerialComparisonRows[result_, row_Association, orderMin_Integer, orderMax_Integer] :=
  Table[Module[{candidate, benchmark, candidatePhysical, benchmarkNumeric, relativeError, rawImaginary, exactQ,
      analyticPassQ, benchmarkAvailableQ, benchmarkPassQ, exactMatchQ, passQ, candidateNumeric},
    candidate = SeriesCoefficient[result, {mbSerialEpsilon, 0, k}];
    benchmarkAvailableQ = row["OrderMin"] <= k <= row["BenchmarkMax"];
    benchmark = If[benchmarkAvailableQ, SeriesCoefficient[row["Benchmark"], {mbSerialEpsilon, 0, k}], Missing["NotAvailable"]];
    exactQ = mbSerialInexactNumberFreeQ[candidate];
    (* 2026-09-10: the whole coefficient is evaluated numerically FIRST and its real/imaginary parts are read off the
       number.  The former order (Im of the coefficient, then N inside Quiet@Check) refused MB7's exact,
       benchmark-equal eps^3 row: that coefficient is real and carries HPL's constant HPLs8a (= S(5,3; infinity) =
       zeta(8) + zeta(5,3)), so Im collapsed to -1024 Im[HPLs8a], whose N is 0 but emits N::meprec while deciding
       that the imaginary part of a real constant vanishes to 30 digits, and Check turned the warning into $Failed
       ("not numerically evaluable").  HPLs8a is evaluated by HPL's own N rule (the multiple zeta value), never
       through Mathematica's Hurwitz Zeta[5,3]. *)
    candidateNumeric = Quiet @ Check[N[candidate, 30], $Failed];
    candidatePhysical = If[NumberQ[candidateNumeric], Re[candidateNumeric], mbSerialNumericValue[Re[candidate]]];
    rawImaginary = If[NumberQ[candidateNumeric], Im[candidateNumeric], mbSerialNumericValue[Im[candidate]]];
    benchmarkNumeric = If[benchmarkAvailableQ,
      mbSerialNumericValue[benchmark /. Zeta[5, 3] -> mbSerialZeta53], Missing["NotAvailable"]];
    relativeError = If[benchmarkAvailableQ && NumberQ[candidatePhysical] && NumberQ[benchmarkNumeric],
      Abs[candidatePhysical - benchmarkNumeric]/(1 + Abs[benchmarkNumeric]), Missing["NotAvailable"]];
    (* 2026-09-10: the EXACT comparison now covers the zeta(5,3) rows as well.  In the benchmarks Zeta[5,3] denotes the
       multiple zeta value zeta(5,3) (mb_targets_all.m, convention warning), and the route's weight-8 values carry it
       as HPL`HPLs8a = zeta(8) + zeta(5,3) (HPL.m: HPLs8a is the harmonic sum S(5,3; infinity)).  The candidate is
       rewritten with the exact identity HPLs8a -> Zeta[8] + Zeta[5,3] (the symbol Zeta[5,3] standing for the same
       multiple zeta value on both sides) and the difference is tested in the canonical form, as for every other row.
       This rewriting is used for the SYMBOLIC comparison only; the numerical one above keeps HPL's N rule. *)
    exactMatchQ = If[benchmarkAvailableQ && exactQ,
      TrueQ[mbSerialExactZeroQ[Re[candidate /. HPL`HPLs8a -> Zeta[8] + Zeta[5, 3]] - benchmark]], Missing["NotAvailable"]];
    analyticPassQ = exactQ && NumberQ[candidatePhysical] && NumberQ[rawImaginary];
    benchmarkPassQ = If[benchmarkAvailableQ,
      NumberQ[benchmarkNumeric] && TrueQ[relativeError <= $MBSerialTolerance], Missing["NotAvailable"]];
    passQ = analyticPassQ && (! benchmarkAvailableQ || TrueQ[benchmarkPassQ]);
    <|"MB" -> row["Name"], "EpsilonOrder" -> k, "CandidateRaw" -> candidate,
      "CandidatePhysical" -> candidatePhysical, "Benchmark" -> benchmark, "BenchmarkNumeric" -> benchmarkNumeric,
      "RelativeError" -> relativeError, "ExactCandidate" -> exactQ, "ExactMatch" -> exactMatchQ,
      "AnalyticPass" -> analyticPassQ, "BenchmarkAvailable" -> benchmarkAvailableQ,
      "BenchmarkPass" -> benchmarkPassQ, "Pass" -> passQ|>], {k, orderMin, orderMax}];

mbSerialCheckpointDirectory = FileNameJoin[{mbSerialBaseDirectory, "standard_serial_results"}];

mbSerialCheckpointPath[row_Association, orderMin_Integer, orderMax_Integer] := FileNameJoin[
  {mbSerialCheckpointDirectory, row["Name"] <> "_" <> ToString[orderMin] <> "_" <> ToString[orderMax] <>
    If[$MBSerialRoute === "Standard", "", "_" <> ToString[$MBSerialRoute]] <> ".mx"}];

mbSerialLoadCheckpoint[row_Association, orderMin_Integer, orderMax_Integer] := Module[
  {path = mbSerialCheckpointPath[row, orderMin, orderMax], record},
  If[! TrueQ[$MBSerialResume] || ! FileExistsQ[path], Return[Missing["Absent"]]];
  Clear[mbSerialCheckpointRecord];
  Quiet @ Check[Get[path], Return[Missing["Unreadable"]]];
  record = mbSerialCheckpointRecord;
  Clear[mbSerialCheckpointRecord];
  If[AssociationQ[record] && Lookup[record, "PackageHash", None] === mbSerialPackageHash &&
      Lookup[record, "OrderMin", None] === orderMin && Lookup[record, "OrderMax", None] === orderMax &&
      TrueQ[Lookup[record, "Pass", False]] && TrueQ[Lookup[record, "AllRequestedOrdersExact", False]] &&
      ! TrueQ[Lookup[record, "RouteFailure", True]] && Lookup[record, "FailedPieceCount", Infinity] === 0,
    record, Missing["Stale"]]];

mbSerialSaveCheckpoint[record_Association, row_Association, orderMin_Integer, orderMax_Integer] := Module[{path},
  If[! DirectoryQ[mbSerialCheckpointDirectory], CreateDirectory[mbSerialCheckpointDirectory, CreateIntermediateDirectories -> True]];
  path = mbSerialCheckpointPath[row, orderMin, orderMax];
  mbSerialCheckpointRecord = record;
  DumpSave[path, mbSerialCheckpointRecord];
  Clear[mbSerialCheckpointRecord];
  path];

(* one Standard-route call; the failed-piece ledger is read after it *)
mbSerialRunRoute[integral_, orderMin_Integer, orderMax_Integer] := CheckAbort[
  Block[{MBtoMPL`Private`$mbtGlobalBarnesBudget = $MBSerialGlobalSeconds},
    MBresolveToMPL[integral, mbSerialEpsilon,
      "EpsOrderMin" -> orderMin, "EpsOrderMax" -> orderMax,
      "Route" -> $MBSerialRoute, "PieceKernels" -> mbSerialWorkerRequest[],
      "Simplify" -> True, "DiskCache" -> $MBSerialDiskCache,
      "UseCertifiedLibrary" -> False, "Verbose" -> $MBSerialVerbose]], $Aborted];

(* release R3.1: the differential-family evaluation of a target on the Subtraction route.  The families of mb_u_targets.m
   (e.g. MB8au + MB8bu for MB8) are u-integrated at the MB level and closed by the general multifold handler
   through run_multifold_family.wls: one main run (it writes the sum record) and helper processes in other residue and
   item orders (they share the closer caches and the item claims), as many as the main-kernel budget of the resource
   policy and the licence allow (at most $MBSerialFamilyHelpers, default 15), the subkernel budget split over them.
   Returns the exact family sum (eps^orderMin..eps^orderMax, the full complex phase) or $Failed when an item stays open. *)
If[! ValueQ[$MBSerialFamilyHelpers], $MBSerialFamilyHelpers = 15];
If[! ValueQ[$MBSerialFamilySeconds], $MBSerialFamilySeconds = 14400];
mbSerialFamilyRun[name_String, fams_List, orderMin_Integer, orderMax_Integer] := Module[
  {here = mbSerialBaseDirectory, kernel, tag, recDir, w, nH, free, procs, helpers = {}, sumFile, rec, famArgs, orders, items, log, t0 = AbsoluteTime[]},
  kernel = FileNameJoin[{$InstallationDirectory, "Executables", "WolframKernel"}];
  If[! FileExistsQ[kernel], kernel = First[$CommandLine]];
  tag = "call_" <> ToString[$ProcessID] <> "_" <> DateString[{"Year", "Month", "Day", "Hour", "Minute", "Second"}];
  recDir = FileNameJoin[{here, ".cache", "multifold_family"}]; Quiet@CreateDirectory[recDir, CreateIntermediateDirectories -> True];
  If[DownValues[Global`mbtWorkerBudget] =!= {}, Global`mbtWorkerBudget[]];
  free = If[DownValues[Global`mbtMyMainKernelCount] =!= {} && IntegerQ[Global`$mbtMainKernelBudget],
    Global`$mbtMainKernelBudget - Global`mbtMyMainKernelCount[] - 1, 0];
  If[IntegerQ[$MaxLicenseProcesses] && IntegerQ[$LicenseProcesses], free = Min[free, $MaxLicenseProcesses - $LicenseProcesses - 1]];
  nH = Max[0, Min[$MBSerialFamilyHelpers, free]];
  w = Max[4, Floor[(If[DownValues[Global`mbtSubkernelCapDynamic] =!= {}, Global`mbtSubkernelCapDynamic[], 24] - 2)/(nH + 1)]];
  famArgs = StringRiffle[fams, " "];
  log[s_] := FileNameJoin[{recDir, tag <> "_" <> s <> ".log"}];
  Print["  ", name, ": differential families ", famArgs, " (u-integral at the MB level, general multifold handler); main run + ",
    nH, " helper(s), ", w, " piece workers each  ", DateString[]];
  procs = {StartProcess[{"bash", "-c", StringJoin["exec '", kernel, "' -noinit -noprompt -script '", FileNameJoin[{here, "run_multifold_family.wls"}],
      "' ", famArgs, " tag=", tag, " target=", ToString[orderMax], " low=", ToString[orderMin], " workers=", ToString[w],
      " seconds=", ToString[$MBSerialFamilySeconds], " > '", log["main"], "' 2>&1"]}]};
  orders = Join[{"desc", "mid"}, Table["rot:" <> ToString[k], {k, 2, 40, 3}]];
  items = {"asc", "desc", "mid"};
  helpers = Table[With[{fa = StringRiffle[RotateLeft[fams, i - 1], " "], o = orders[[Mod[i - 1, Length[orders]] + 1]], it = items[[Mod[i - 1, 3] + 1]]},
      StartProcess[{"bash", "-c", StringJoin["exec '", kernel, "' -noinit -noprompt -script '", FileNameJoin[{here, "run_multifold_family.wls"}],
        "' ", fa, " tag=", tag, "_h", ToString[i], " order=", o, " items=", it, " compare=0 target=", ToString[orderMax],
        " low=", ToString[orderMin], " workers=", ToString[w], " seconds=", ToString[$MBSerialFamilySeconds], " > '", log["h" <> ToString[i]], "' 2>&1"]}]],
    {i, nH}];
  Internal`WithLocalSettings[Null,
    While[ProcessStatus[First[procs]] === "Running", Pause[10]],
    (* the main run is complete: every item is in the shared caches; the helpers are stopped *)
    Do[If[ProcessStatus[p] === "Running", KillProcess[p]], {p, helpers}]];
  sumFile = FileNameJoin[{recDir, tag <> "_" <> StringRiffle[fams, "+"] <> "_sum.m"}];
  rec = If[FileExistsQ[sumFile], Quiet@Check[Get[sumFile], $Failed], $Failed];
  Print["  ", name, ": family run ", If[AssociationQ[rec], If[TrueQ[rec["AllClosed"]], "closed", "OPEN"], "without a record"],
    " in ", Round[AbsoluteTime[] - t0], " s (log ", log["main"], ")"];
  If[! AssociationQ[rec] || ! TrueQ[rec["AllClosed"]], Return[$Failed, Module]];
  Expand[rec["Total"] /. Global`regEp -> mbSerialEpsilon]];

(* release R3.1: an inclusive target as the exact u-integral of its differential kernels at the MB level.  A kernel of
   mb_u_targets.m is u^a (1-u)^b times a u-free MB integrand G (a, b free of u), so its integral over 0 < u < 1 is
   G Gamma(1+a) Gamma(1+b)/Gamma(2+a+b) -- exact and unexpanded, no Laurent coefficient used; the route finds the
   contours of the new integrand afresh.  A row's "SubtractionKernels" names the kernels whose sum is the target; each
   is one component of the Subtraction call.  The kernels have fewer folds than the representation of mb_targets_all.m
   (MB6, MB9, MB10: 2 against 3; MB5, MB11: 3 against 4), and their residues close at the orders where the inclusive
   representation needs deep multi-fold cubes (the construction of the September inclusive runs).  Returns $Failed
   when a kernel's u-dependence is not of that form. *)
mbSerialKernelIntegrand[fam_String] := Module[{d = mbSerialUData, t, a, b, rest, uu},
  t = Lookup[d["Targets"], fam, Missing["UnknownKernel", fam]];
  If[MissingQ[t], Return[$Failed, Module]];
  uu = d["Parameter"]; a = t["UPower"]; b = t["OneMinusUPower"];
  If[!FreeQ[{a, b}, uu], Return[$Failed, Module]];
  rest = Together[t["Integrand"]/(uu^a (1 - uu)^b)];
  If[!FreeQ[rest, uu], Return[$Failed, Module]];
  (rest Gamma[1 + a] Gamma[1 + b]/Gamma[2 + a + b]) /. d["Regulator"] -> mbSerialEpsilon];

MBSerialRunOne::kernel = "The differential kernel(s) `2` of `1` are not of the form u^a (1-u)^b times a u-free integrand; the target's own integral is used.";
MBSerialRunOne::range = "Requested epsilon range `2` through `3` for `1` is invalid because the minimum order exceeds the maximum order.";
MBSerialRunOne::orders = "Epsilon orders for `1` must be integers; received `2` and `3`.";

MBSerialRunOne[name_String] := Module[{row, orderMax},
  row = mbSerialTarget[name];
  If[MissingQ[row], Return[row]];
  orderMax = mbSerialRequestedMax[row];
  If[orderMax === $Failed, Return[$Failed]];
  MBSerialRunOne[name, row["OrderMin"], orderMax]];

MBSerialRunOne[name_String, orderMin_Integer, orderMax_Integer] := Module[
  {row, checkpoint, started, seconds, result, results, ledgers, routeFailureQ, failedPieceLedger, failedPieceCount,
    comparisons, analyticPassQ, benchmarkRows, benchmarkPassQ, unbenchmarkedOrders, passQ, record, checkpointPath,
    components, componentNames},
  row = mbSerialTarget[name];
  If[MissingQ[row], Return[row]];
  If[orderMin > orderMax, Message[MBSerialRunOne::range, name, orderMin, orderMax]; Return[$Failed]];
  unbenchmarkedOrders = Select[Range[orderMin, orderMax], ! (row["OrderMin"] <= # <= row["BenchmarkMax"]) &];
  If[unbenchmarkedOrders =!= {},
    Print[name, " NOTE: no recorded benchmark is available for requested order(s) ", unbenchmarkedOrders,
      ". The ", $MBSerialRoute, " route will still run; analytic exactness and failure gates remain active."]];
  If[orderMax > mbSerialVerifiedMax[row],
    Print[name, " NOTE: requested eps^", orderMax, " is above the verified maximum eps^", mbSerialVerifiedMax[row],
      " of the ", $MBSerialRoute, " route. Exact and benchmark gates remain active."]];
  If[KeyExistsQ[row, "Note"], Print[name, " NOTE: ", row["Note"]]];
  checkpoint = mbSerialLoadCheckpoint[row, orderMin, orderMax];
  If[AssociationQ[checkpoint],
    Print[name, " resumed from verified checkpoint for eps^", orderMin, "..eps^", orderMax];
    Return[checkpoint]];
  components = Lookup[row, "Components", {row["Integral"]}];
  componentNames = Lookup[row, "ComponentNames", {name}];
  (* release R3.1: on the Subtraction route a row with "SubtractionKernels" is evaluated as the exact u-integral of its
     differential kernels (mbSerialKernelIntegrand), one component per kernel *)
  If[$MBSerialRoute === "Subtraction" && ListQ[Lookup[row, "SubtractionKernels", None]],
    Module[{k = mbSerialKernelIntegrand /@ row["SubtractionKernels"]},
      If[MemberQ[k, $Failed], Message[MBSerialRunOne::kernel, name, row["SubtractionKernels"]],
        components = k; componentNames = (# <> " (u-integral)" &) /@ row["SubtractionKernels"];
        Print["  ", name, ": the exact u-integral of the differential kernel(s) ", StringRiffle[row["SubtractionKernels"], " + "],
          " (", StringRiffle[ToString[Length[mbSerialUData["Targets"][#]["MBVariables"]]] <> "-fold" & /@ row["SubtractionKernels"], ", "],
          ") at the MB level"]]]];
  Print[name, " START  ", $MBSerialRoute, " route  eps^", orderMin, "..eps^", orderMax, "  PieceKernels->", mbSerialWorkerRequest[],
    " (maximum; the launcher prints the number actually started)",
    If[Length[components] > 1, "  (sum of " <> StringRiffle[componentNames, " + "] <> ")", ""]];
  started = AbsoluteTime[];
  results = {}; ledgers = {};
  (* release R3.1: on the Subtraction route a target whose row names its differential families is evaluated as the
     u-integral of the families by the general multifold handler (run_multifold_family.wls: a main run and helper
     processes sharing the closer caches) -- the method of the R3 regression for MB8 and MB14, now that of the call *)
  If[$MBSerialRoute === "Subtraction" && ListQ[Lookup[row, "SubtractionFamilies", None]],
    Module[{r = mbSerialFamilyRun[name, row["SubtractionFamilies"], orderMin, orderMax]},
      results = {r}; ledgers = {If[r === $Failed, {<|"Families" -> row["SubtractionFamilies"], "Reason" -> "family run not closed"|>}, {}]}],
  Do[Module[{r},
     If[Length[components] > 1, Print["  ", componentNames[[i]], " START"]];
     r = mbSerialRunRoute[components[[i]], orderMin, orderMax];
     AppendTo[results, r];
     AppendTo[ledgers, If[ListQ[MBtoMPL`Private`$mbtFailedPieces], MBtoMPL`Private`$mbtFailedPieces, Missing["Unavailable"]]];
     If[Length[components] > 1, Print["  ", componentNames[[i]], " END  ", Round[AbsoluteTime[] - started], " s so far"]]],
    {i, Length[components]}]];
  seconds = N[AbsoluteTime[] - started, 6];
  result = If[MemberQ[results, $Failed | $Aborted], $Failed, Total[results]];
  failedPieceLedger = If[AllTrue[ledgers, ListQ], Join @@ ledgers, Missing["Unavailable"]];
  failedPieceCount = If[ListQ[failedPieceLedger], Length[failedPieceLedger], Infinity];
  routeFailureQ = result === $Failed || result === $Aborted ||
    ! FreeQ[result, $Failed | $Aborted | Indeterminate | ComplexInfinity] || failedPieceCount =!= 0;
  comparisons = If[routeFailureQ, {}, mbSerialComparisonRows[result, row, orderMin, orderMax]];
  analyticPassQ = comparisons =!= {} && And @@ Lookup[comparisons, "AnalyticPass", False];
  benchmarkRows = Select[comparisons, TrueQ[Lookup[#, "BenchmarkAvailable", False]] &];
  benchmarkPassQ = If[benchmarkRows === {}, Missing["NoBenchmarkOverlap"], And @@ Lookup[benchmarkRows, "BenchmarkPass", False]];
  passQ = ! routeFailureQ && analyticPassQ && (benchmarkRows === {} || TrueQ[benchmarkPassQ]);
  record = <|"MB" -> name, "OrderMode" -> $MBSerialOrderMode, "OrderMin" -> orderMin, "OrderMax" -> orderMax,
    "BenchmarkMax" -> row["BenchmarkMax"], "SealedStandardMax" -> row["SealedStandardMax"],
    "WithinAnalyticSeal" -> TrueQ[orderMin >= row["OrderMin"] && orderMax <= row["SealedStandardMax"]],
    "AllRequestedOrdersExact" -> analyticPassQ, "BenchmarkPass" -> benchmarkPassQ,
    "ExactMatchAllBenchmarked" -> If[benchmarkRows === {}, Missing["NoBenchmarkOverlap"],
      And @@ (TrueQ /@ Lookup[benchmarkRows, "ExactMatch", False])],
    "UnbenchmarkedOrders" -> unbenchmarkedOrders, "PieceKernels" -> mbSerialWorkerRequest[],
    "GlobalBudgetSeconds" -> $MBSerialGlobalSeconds, "Seconds" -> seconds,
    "Pass" -> passQ, "RouteFailure" -> routeFailureQ, "FailedPieceCount" -> failedPieceCount,
    "FailedPieceLedger" -> failedPieceLedger, "Result" -> result, "ComponentResults" -> results,
    "Comparisons" -> comparisons, "PackageHash" -> mbSerialPackageHash,
    "DependencyHashes" -> mbSerialDependencyHashes, "CompletedAt" -> DateString["ISODateTime"]|>;
  checkpointPath = mbSerialSaveCheckpoint[record, row, orderMin, orderMax];
  Print[name, " END  seconds=", seconds, "  pass=", passQ, "  checkpoint=", checkpointPath];
  record];

MBSerialRunOne[name_String, orderMin_, orderMax_] := (Message[MBSerialRunOne::orders, name, orderMin, orderMax]; $Failed);

mbSerialSectionResult[name_String, record_] := Module[{},
  If[! AssociationQ[record], Return[record]];
  If[! AssociationQ[$MBSerialResults], $MBSerialResults = <||>];
  AssociateTo[$MBSerialResults, name -> record];
  Dataset[{KeyTake[record, {"MB", "OrderMin", "OrderMax", "WithinAnalyticSeal", "AllRequestedOrdersExact",
      "BenchmarkPass", "ExactMatchAllBenchmarked", "UnbenchmarkedOrders", "PieceKernels", "GlobalBudgetSeconds",
      "Seconds", "Pass", "RouteFailure", "FailedPieceCount"}]}]];

MBSerialRunSection[name_String] := mbSerialSectionResult[name, MBSerialRunOne[name]];
MBSerialRunSection[name_String, orderMin_Integer, orderMax_Integer] := mbSerialSectionResult[name, MBSerialRunOne[name, orderMin, orderMax]];
MBSerialRunSection[name_String, orderMin_, orderMax_] := mbSerialSectionResult[name, MBSerialRunOne[name, orderMin, orderMax]];

MBSerialRunAll[] := Module[{records, names = mbSerialRouteTargetNames[]},
  records = MBSerialRunOne /@ names;
  $MBSerialResults = AssociationThread[names, records];
  MBSerialSummary[]];

MBSerialSummary[] := If[! AssociationQ[$MBSerialResults], Missing["NoResults", "Evaluate MBSerialRunAll[] first"],
  Dataset @ KeyValueMap[
    Function[{name, record},
      If[AssociationQ[record],
        <|"MB" -> name, "Range" -> {record["OrderMin"], record["OrderMax"]}, "Seconds" -> record["Seconds"],
          "Pass" -> record["Pass"], "ExactMatch" -> Lookup[record, "ExactMatchAllBenchmarked", Missing[]],
          "RouteFailure" -> record["RouteFailure"], "FailedPieceCount" -> record["FailedPieceCount"]|>,
        <|"MB" -> name, "Range" -> Missing["Unavailable"], "Seconds" -> Missing["Unavailable"], "Pass" -> False,
          "ExactMatch" -> Missing[], "RouteFailure" -> True, "FailedPieceCount" -> Missing["Unavailable"]|>]],
    $MBSerialResults]];

MBSerialReport[name_String] := Module[{record},
  If[! AssociationQ[$MBSerialResults] || ! KeyExistsQ[$MBSerialResults, name], Return[Missing["NoResult", name]]];
  record = $MBSerialResults[name];
  If[! AssociationQ[record], Return[record]];
  Dataset[record["Comparisons"]]];

(* ---- your own integral: the same call the benchmark rows use, returning the exact raw Laurent series ----
   MBStandardEvaluate[integrand, orderMin, orderMax] where integrand is a Mellin-Barnes integrand in the conventions
   of mb_targets_all.m (Gamma functions with affine arguments in the MB variables, the regulator \[Epsilon], an
   optional exponential prefactor) whose contours MBresolve determines.  The physical value is the real part;
   the imaginary part is the raw contour phase and is retained.  A refused piece makes the run fail closed:
   inspect MBtoMPL`Private`$mbtFailedPieces. *)
(* The regulator is the symbol \[Epsilon] AS IT RESOLVES AFTER THE RELEASE IS LOADED (PolyLogTools exports a symbol of
   that name, so it is PolyLogTools`\[Epsilon]); the bundled targets and this file use it.  An integrand written before
   the load, or with the regulator qualified as Global`\[Epsilon], carries a different symbol of the same appearance
   and would expand to nothing.  Such an integrand is refused here instead of returning an empty series. *)
MBStandardEvaluate::eps = "The integrand does not contain the regulator `1` of this session (the symbol \[Epsilon] as it resolves after the release is loaded).  Type or load the integrand after the initialization cell, with the regulator written as \[Epsilon] (not Global`\[Epsilon]).";
Options[MBStandardEvaluate] = {"ExternalParameters" -> {}, "ParameterAssumptions" -> True,
  "ParameterTimeConstraint" -> 900, "Regulator" -> Automatic};
MBStandardEvaluate[integrand_, orderMin_Integer, orderMax_Integer, OptionsPattern[]] := Module[
  {result, ledger, exactQ, pars = OptionValue["ExternalParameters"], eps = OptionValue["Regulator"]},
  If[eps === Automatic, eps = mbSerialEpsilon];
  If[!MatchQ[eps, _Symbol] || FreeQ[integrand, eps],
    Message[MBStandardEvaluate::eps, eps]; Return[$Failed]];
  result = If[pars === {} && eps === mbSerialEpsilon,
    mbSerialRunRoute[integrand, orderMin, orderMax],
    MBtoMPL`MBresolveToMPL[integrand, eps, "Route" -> $MBSerialRoute,
      "EpsOrderMin" -> orderMin, "EpsOrderMax" -> orderMax,
      "ExternalParameters" -> pars, "ParameterAssumptions" -> OptionValue["ParameterAssumptions"],
      "ParameterTimeConstraint" -> OptionValue["ParameterTimeConstraint"],
      "DiskCache" -> $MBSerialDiskCache, "UseCertifiedLibrary" -> False,
      "PieceKernels" -> mbSerialWorkerRequest[], "Verbose" -> $MBSerialVerbose]];
  ledger = If[ListQ[MBtoMPL`Private`$mbtFailedPieces], MBtoMPL`Private`$mbtFailedPieces, {}];
  If[pars =!= {}, ledger = If[FailureQ[result], {result}, {}]];
  exactQ = result =!= $Failed && result =!= $Aborted && !FailureQ[result] && mbSerialInexactNumberFreeQ[result];
  <|"Result" -> result, "Exact" -> exactQ, "FailedPieceCount" -> Length[ledger], "FailedPieceLedger" -> ledger,
    "Coefficients" -> If[exactQ, Table[k -> SeriesCoefficient[result, {eps, 0, k}], {k, orderMin, orderMax}], Missing["RouteFailure"]]|>];
(* the same evaluation on the Subtraction route, whatever $MBSerialRoute is; the options are those of
   MBStandardEvaluate (an integrand with external parameters: "ExternalParameters" -> {u}, "ParameterAssumptions") *)
MBSubtractionEvaluate[integrand_, orderMin_Integer, orderMax_Integer, opts : OptionsPattern[MBStandardEvaluate]] :=
  Block[{$MBSerialRoute = "Subtraction"}, MBStandardEvaluate[integrand, orderMin, orderMax, opts]];

(* User-supplied u-dependent examples: inputs only; every run derives the result. *)
(* The input context stays private to the data: loading examples must not
   change which epsilon or u a user types in later notebook cells. *)
mbSerialUData = Block[{$ContextPath = $ContextPath},
  Quiet@Get[FileNameJoin[{mbSerialBaseDirectory, "mb_u_targets.m"}]]];
MBStandardULedger[] := Dataset@KeyValueMap[
  <|"Integral" -> #1, "EpsilonRange" -> #2, "ParameterDomain" -> "0 < u < 1"|> &,
  mbSerialUData["OrderRanges"]];
MBSubtractionULedger[] := Dataset@KeyValueMap[
  <|"Integral" -> #1, "EpsilonRange" -> #2, "ParameterDomain" -> "0 < u < 1"|> &,
  Lookup[mbSerialUData, "SubtractionOrderRanges", mbSerialUData["OrderRanges"]]];
MBStandardUInput[name_String] := Module[{names},
  If[!KeyExistsQ[mbSerialUData["OrderRanges"], name], Return[Missing["UnknownExample", name]]];
  names = Lookup[mbSerialUData["ComponentGroups"], name, {name}];
  Total[mbSerialUData["Targets"][#]["Integrand"] & /@ names] /.
    {mbSerialUData["Regulator"] -> mbSerialEpsilon, mbSerialUData["Parameter"] -> Global`u}];
MBStandardRunU[name_String] := Module[{range = Lookup[mbSerialUData["OrderRanges"], name, Missing["UnknownExample", name]]},
  If[MissingQ[range], range, MBStandardRunU[name, Sequence @@ range]]];
MBStandardRunU[name_String, lo_Integer, hi_Integer] := Module[{input = MBStandardUInput[name], record},
  If[MissingQ[input], Return[input]];
  record = Block[{$MBSerialRoute = "Standard"}, MBStandardEvaluate[input, lo, hi,
    "ExternalParameters" -> {Global`u}, "ParameterAssumptions" -> 0 < Global`u < 1,
    "ParameterTimeConstraint" -> Lookup[Lookup[mbSerialUData, "TimeConstraints", <||>], name, 3600]]];
  If[!AssociationQ[$MBStandardUResults], $MBStandardUResults = <||>];
  AssociateTo[$MBStandardUResults, name -> record]; record];
(* The same u-dependent examples on the SUBTRACTION route: exact scaled Barnes closure, the parameter factor times
   unscaled towers, faithful Euler cubes whose parameter signs are certified on 0 < u < 1, native periods.  The
   default range is the example's verified Subtraction range ("SubtractionOrderRanges"), else its Standard range. *)
MBSubtractionRunU[name_String] := Module[{range = Lookup[Lookup[mbSerialUData, "SubtractionOrderRanges", mbSerialUData["OrderRanges"]], name,
    Lookup[mbSerialUData["OrderRanges"], name, Missing["UnknownExample", name]]]},
  If[MissingQ[range], range, MBSubtractionRunU[name, Sequence @@ range]]];
MBSubtractionRunU[name_String, lo_Integer, hi_Integer] := Module[{input = MBStandardUInput[name], record},
  If[MissingQ[input], Return[input]];
  record = Block[{$MBSerialRoute = "Subtraction"}, MBStandardEvaluate[input, lo, hi,
    "ExternalParameters" -> {Global`u}, "ParameterAssumptions" -> 0 < Global`u < 1,
    "ParameterTimeConstraint" -> Lookup[Lookup[mbSerialUData, "SubtractionTimeConstraints", Lookup[mbSerialUData, "TimeConstraints", <||>]], name, 3600]]];
  If[!AssociationQ[$MBSubtractionUResults], $MBSubtractionUResults = <||>];
  AssociateTo[$MBSubtractionUResults, name -> record]; record];

(* Notebook workflow:
     MBSerialLedger[]                      MBSerialBenchmarkReport[]
     MBSerialRunSection["MB6", -6, -2]     MBSerialRunAll[]          MBSerialReport["MB6"]
     MBStandardEvaluate[myIntegrand, -3, 0]
   $MBSerialOrderMode = "SealedStandard" (default) runs the verified ranges; "BenchmarkMaximum" requests every
   available benchmark order (orders above the verified maximum must earn new green records). *)
