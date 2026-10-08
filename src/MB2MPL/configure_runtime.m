(* ::Package:: *)
(* AUTHORSHIP (release R2, 2026-09-07): MB2MPL Standard-route release loader support. Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)

(* Bundle-local runtime configuration for MB_standard (release R2, 2026-09-06: sealed core + class-handler rungs,
   no pre-computed library of any kind).  This file performs path setup and environment checks only; it does not
   load any package. *)

Module[{here, vendor, pathEntries, required, missing, ginshExecutable, systemPath, binary, binaryOK},
  here = DirectoryName[ExpandFileName[$InputFileName]];
  If[here === "" || here === ".", here = Directory[]];
  vendor = FileNameJoin[{here, "vendor"}];
  (* Two locations live in the user's system and may be pinned by an absolute path BEFORE loading (the notebooks'
     initialization cells show the lines): Global`$MBStandardGinshExecutable (the GiNaC shell; default: the first
     ginsh on the PATH of this kernel) and Global`$MBStandardHyperFLINTBinary (the hyperlogarithm integrator;
     default: the bundled vendor/IntVolFLINT/bin/hyperflint).  Everything else is located relative to this file. *)
  systemPath = StringSplit[Replace[Environment["PATH"], Except[_String] -> ""], ":"];
  ginshExecutable = If[StringQ[Global`$MBStandardGinshExecutable] && FileExistsQ[Global`$MBStandardGinshExecutable],
    (SetEnvironment["PATH" -> DirectoryName[Global`$MBStandardGinshExecutable] <> ":" <> Environment["PATH"]];
     Global`$MBStandardGinshExecutable),
    SelectFirst[FileNameJoin[{#, "ginsh"}] & /@ systemPath, FileExistsQ, $Failed]];

  Global`$MBStandardDir = here;
  Global`$MBStandardVendorDir = vendor;
  Global`$PolyLogPath = FileNameJoin[{vendor, "PolyLogTools"}];
  Global`$HPLPath = FileNameJoin[{vendor, "HPL"}];
  Global`$HypExpPath = FileNameJoin[{vendor, "HypExp"}];
  Global`$HyperInticaPath = FileNameJoin[{vendor, "HyperIntica"}];
  (* one hyperlogarithm integrator binary serves both bridges (hf_machinery.m and intvolflint/): the IntVolFLINT
     fork of HyperFLINT 1.2.13, whose default behaviour is that of the original (vendor/IntVolFLINT/FORK_PROVENANCE.md) *)
  Global`$MBStandardHyperFLINTBinary = If[StringQ[Global`$MBStandardHyperFLINTBinary] &&
      FileExistsQ[Global`$MBStandardHyperFLINTBinary], Global`$MBStandardHyperFLINTBinary,
    FileNameJoin[{vendor, "IntVolFLINT", "bin", "hyperflint"}]];
  (* release R3.1: the same build with the transform guard of vendor/IntVolFLINT/patches/transform_nonlinear_guard.patch
     (a letter factor that is not linear in the integration variable refuses the word transformation instead of being
     dropped); the native jobs of the u-dependent Subtraction route run on it (MBParameterSubtraction`PSNativeEngine) *)
  Global`$MBStandardHyperFLINTGuardedBinary = If[StringQ[Global`$MBStandardHyperFLINTGuardedBinary] &&
      FileExistsQ[Global`$MBStandardHyperFLINTGuardedBinary], Global`$MBStandardHyperFLINTGuardedBinary,
    FileNameJoin[{vendor, "IntVolFLINT", "bin", "hyperflint_guarded"}]];
  Global`$MBStandardHyperFLINTData = FileNameJoin[{vendor, "IntVolFLINT", "data", "mzv_reductions.json"}];
  Global`$MBStandardGinshExecutable = ginshExecutable;
  (* release R3.1 (4 October 2026): the Python of the parameter routes (the native coefficient jobs, their algebraic-root
     audit, the contour diagnostics): Global`$MBStandardPythonExecutable when it is set before loading, else the
     package-local environment .venv/bin/python3 when it exists (README: parameter_support/requirements.txt), else
     python3 on the PATH.  The audit compares a record with its rerun under algebraic letters EXACTLY, with sympy;
     without sympy no record that differs only in form can be certified (fail closed), and the u-dependent Subtraction
     route then sends far more jobs to the exact last fold or refuses -- hence the warning below. *)
  Global`$MBStandardPythonExecutable = Which[
    StringQ[Global`$MBStandardPythonExecutable] && FileExistsQ[Global`$MBStandardPythonExecutable],
      Global`$MBStandardPythonExecutable,
    FileExistsQ[FileNameJoin[{here, ".venv", "bin", "python3"}]], FileNameJoin[{here, ".venv", "bin", "python3"}],
    True, "python3"];
  Global`$MBStandardPythonReady = TrueQ[Quiet@Check[
    RunProcess[{Global`$MBStandardPythonExecutable, "-c", "import sympy, numpy, scipy"}, "ExitCode"] === 0, False]];
  If[! Global`$MBStandardPythonReady,
    Print["[MB_standard] WARNING: the Python of the parameter routes (", Global`$MBStandardPythonExecutable,
      ") cannot import sympy, numpy and scipy.  The u-dependent Subtraction route needs them (exact audit of the " <>
      "native coefficient jobs).  Install them in a package-local environment: python3 -m venv .venv, then " <>
      ".venv/bin/pip install -r parameter_support/requirements.txt (README), or set $MBStandardPythonExecutable " <>
      "to a Python that has them before loading."]];

  (* HPL and HypExp must be found on $Path BEFORE PolyLogTools is loaded (it Needs["HPL`"]).  HarmonicSums is not
     shipped (2026-09-08): no rung uses it and the sealed core's optional HarmonicSums closer is disabled by the loader. *)
  pathEntries = {Global`$HPLPath, Global`$HypExpPath};
  Scan[If[! MemberQ[$Path, #], PrependTo[$Path, #]] &, Reverse[pathEntries]];

  required = {
    FileNameJoin[{Global`$PolyLogPath, "PolyLogTools.m"}],
    FileNameJoin[{Global`$HPLPath, "HPL.m"}],
    FileNameJoin[{Global`$HypExpPath, "HypExp.m"}],
    FileNameJoin[{Global`$HyperInticaPath, "HyperIntica.wl"}],
    Global`$MBStandardHyperFLINTBinary,
    Global`$MBStandardHyperFLINTData,
    FileNameJoin[{here, "MB2MPL.m"}],
    FileNameJoin[{here, "MB.m"}], FileNameJoin[{here, "MBresolve.m"}], FileNameJoin[{here, "barnesroutines.m"}],
    FileNameJoin[{here, "IntVol_stable.m"}],
    FileNameJoin[{here, "load_mbe_engines.m"}], FileNameJoin[{here, "hf_machinery.m"}],
    FileNameJoin[{here, "engineN_lib.m"}], FileNameJoin[{here, "engineN_grouped_lib.m"}],
    FileNameJoin[{here, "mbe_strategy_dispatch_v2.m"}],
    FileNameJoin[{here, "intvolflint", "ivf_machinery.m"}],
    FileNameJoin[{here, "intvolflint", "ivf_dispatch_hook.m"}],
    FileNameJoin[{here, "intvolflint", "ivf_ext_finitepart_gconv.m"}],
    FileNameJoin[{here, "mbeSeqIntegrate.m"}], FileNameJoin[{here, "mbePinchClose.m"}],
    FileNameJoin[{here, "mbeReflZero.m"}], FileNameJoin[{here, "mbeAffineBellRung.m"}],
    FileNameJoin[{here, "mbe_affine_bell_lib.m"}], FileNameJoin[{here, "mbeTwoVarPsiRung.m"}],
    FileNameJoin[{here, "mbeLevel6Reduce.m"}], FileNameJoin[{here, "level6_tables", "sl4re.m"}],
    FileNameJoin[{here, "mbeBarnesPreReduce.m"}],
    FileNameJoin[{here, "mbeBarnes2PsiReduce.m"}],
    FileNameJoin[{here, "mbeResonantResolve.m"}],
    FileNameJoin[{here, "mbeOneFoldTowerRung.m"}],
    FileNameJoin[{here, "mbeFaithfulCubeRung.m"}],
    FileNameJoin[{here, "mbt_piece_worker.m"}]
  };
  missing = Select[required, ! FileExistsQ[#] &];
  Global`$MBStandardRuntimeMissing = missing;
  Global`$MBStandardRuntimeReady = missing === {};
  If[missing =!= {},
    Print["[MB_standard] ERROR: incomplete bundle; missing:"];
    Scan[Print["  ", #] &, missing];
    Abort[]];
  If[! (StringQ[ginshExecutable] && FileExistsQ[ginshExecutable]),
    Print["[MB_standard] ERROR: ginsh is not available on PATH. Install GiNaC/CLN (with the ginsh shell) in the " <>
      "user system before loading this release, or set $MBStandardGinshExecutable to its absolute path before loading."];
    Abort[]];
  (* the integrator binary must run on this machine; otherwise rebuild it from vendor/IntVolFLINT/src (BUILD.md) *)
  binary = Global`$MBStandardHyperFLINTBinary;
  binaryOK = Quiet@Check[
    StringContainsQ[RunProcess[{binary, "--version"}, "StandardOutput"], "HF_VERSION"], False];
  Global`$MBStandardIntegratorReady = TrueQ[binaryOK];
  If[! TrueQ[binaryOK],
    Print["[MB_standard] ERROR: the hyperlogarithm integrator binary does not run on this machine (",
      binary, ").  Build it from vendor/IntVolFLINT/src as described in vendor/IntVolFLINT/BUILD.md and place the " <>
      "executable at vendor/IntVolFLINT/bin/hyperflint, or set $MBStandardHyperFLINTBinary to its absolute path before loading."];
    Abort[]];
];
