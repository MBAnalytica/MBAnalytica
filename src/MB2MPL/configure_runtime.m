(* ::Package:: *)
(* AUTHORSHIP: part of the MBAnalytica package (MB2MPL engine). Authors: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)

(* Run-time configuration of the MB2MPL engine (the Standard and Subtraction methods of MBAnalytica).  This file sets
   paths and checks the environment only; it loads no package except the portable process helpers.  The master kernel
   and every worker kernel or process load it, so they all see the same locations.

   Layout (relative to this file, src/MB2MPL/):
     ../Core/Portable.wl     portable time limits, stack size and process trees (macOS and Linux)
     ../../dep/              the bundled packages: MB tools, PolyLogTools, HPL, HypExp, HyperIntica, IntVolFLINT
     ../../config.m          the paths that make found on this machine (ginsh, Python, the HyperFLINT binaries)

   A location set before loading always wins: Global`$MBStandardGinshExecutable, Global`$MBStandardHyperFLINTBinary,
   Global`$MBStandardHyperFLINTGuardedBinary, Global`$MBStandardPythonExecutable.  The cache folder comes from the
   environment variable MBANALYTICA_CACHE (MBAnalytica.wl sets it, so worker processes inherit it), else from
   config.m, else $UserBaseDirectory/ApplicationData/MBAnalytica. *)

Module[{here, root, dep, config, configFile, setting, systemPath, ginshExecutable, binary, binaryOK, required, missing,
    cache, envCache, riscPath},
  here = DirectoryName[ExpandFileName[$InputFileName]];
  If[here === "" || here === ".", here = Directory[]];
  root = ParentDirectory[ParentDirectory[here]];
  dep = FileNameJoin[{root, "dep"}];

  Get[FileNameJoin[{ParentDirectory[here], "Core", "Portable.wl"}]];

  configFile = FileNameJoin[{root, "config.m"}];
  config = If[FileExistsQ[configFile], Quiet@Check[Get[configFile], <||>], <||>];
  If[! AssociationQ[config], config = <||>];
  setting[key_String, default_] := Module[{value},
    value = Lookup[config, key, default];
    If[StringQ[value] && value =!= "", value, default]];

  Global`$MBAnalyticaRoot = root;
  Global`$MBStandardDir = here;
  Global`$MBStandardVendorDir = dep;
  (* the MB tools are loaded through the loaders in mbtools/, which read dep/MB and fix barnesroutines.m *)
  Global`$MBStandardMBDir = FileNameJoin[{here, "mbtools"}];
  Global`$PolyLogPath = FileNameJoin[{dep, "PolyLogTools"}];
  Global`$HPLPath = FileNameJoin[{dep, "HPL"}];
  Global`$HypExpPath = FileNameJoin[{dep, "HypExp"}];
  Global`$HyperInticaPath = FileNameJoin[{dep, "HyperIntica"}];

  (* the RISC packages (HarmonicSums, ...) that the user downloaded: $MBAnalyticaRISCPath, else the folder make
     recorded, on $Path of this kernel and of every worker that reads this file *)
  riscPath = If[StringQ[Global`$MBAnalyticaRISCPath] && DirectoryQ[Global`$MBAnalyticaRISCPath],
    Global`$MBAnalyticaRISCPath, setting["RISCPath", ""]];
  If[DirectoryQ[riscPath] && ! MemberQ[$Path, riscPath], PrependTo[$Path, riscPath]];

  (* caches and logs never go inside the package folder *)
  envCache = Environment["MBANALYTICA_CACHE"];
  cache = If[StringQ[envCache] && envCache =!= "", envCache,
    setting["CacheDirectory", FileNameJoin[{$UserBaseDirectory, "ApplicationData", "MBAnalytica"}]]];
  Global`$MBStandardCacheDir = cache;
  Quiet@CreateDirectory[cache, CreateIntermediateDirectories -> True];

  (* the GiNaC shell: pinned, else config.m, else the first ginsh on this kernel's PATH *)
  systemPath = StringSplit[Replace[Environment["PATH"], Except[_String] -> ""], ":"];
  ginshExecutable = Which[
    StringQ[Global`$MBStandardGinshExecutable] && FileExistsQ[Global`$MBStandardGinshExecutable],
      Global`$MBStandardGinshExecutable,
    FileExistsQ[setting["Ginsh", ""]], setting["Ginsh", ""],
    True, SelectFirst[FileNameJoin[{#, "ginsh"}] & /@ systemPath, FileExistsQ, $Failed]];
  If[StringQ[ginshExecutable] && ! MemberQ[systemPath, DirectoryName[ginshExecutable]],
    SetEnvironment["PATH" -> DirectoryName[ginshExecutable] <> ":" <> Environment["PATH"]]];
  Global`$MBStandardGinshExecutable = ginshExecutable;

  (* one hyperlogarithm integrator serves both bridges (hf_machinery.m and intvolflint/): the IntVolFLINT fork of
     HyperFLINT 1.2.13, built by make into dep/IntVolFLINT/bin/; the guarded build carries
     dep/IntVolFLINT/patches/transform_nonlinear_guard.patch and serves the u-dependent Subtraction jobs *)
  Global`$MBStandardHyperFLINTBinary = Which[
    StringQ[Global`$MBStandardHyperFLINTBinary] && FileExistsQ[Global`$MBStandardHyperFLINTBinary],
      Global`$MBStandardHyperFLINTBinary,
    True, setting["HyperFLINT", FileNameJoin[{dep, "IntVolFLINT", "bin", "hyperflint"}]]];
  Global`$MBStandardHyperFLINTGuardedBinary = Which[
    StringQ[Global`$MBStandardHyperFLINTGuardedBinary] && FileExistsQ[Global`$MBStandardHyperFLINTGuardedBinary],
      Global`$MBStandardHyperFLINTGuardedBinary,
    True, setting["HyperFLINTGuarded", FileNameJoin[{dep, "IntVolFLINT", "bin", "hyperflint_guarded"}]]];
  Global`$MBStandardHyperFLINTData = FileNameJoin[{dep, "IntVolFLINT", "data", "mzv_reductions.json"}];

  (* the Python of the parameter routes: pinned, else config.m, else the package environment .venv, else python3 *)
  Global`$MBStandardPythonExecutable = Which[
    StringQ[Global`$MBStandardPythonExecutable] && FileExistsQ[Global`$MBStandardPythonExecutable],
      Global`$MBStandardPythonExecutable,
    FileExistsQ[setting["Python", ""]], setting["Python", ""],
    FileExistsQ[FileNameJoin[{root, ".venv", "bin", "python3"}]], FileNameJoin[{root, ".venv", "bin", "python3"}],
    True, "python3"];
  Global`$MBStandardPythonReady = TrueQ[Quiet@Check[
    RunProcess[{Global`$MBStandardPythonExecutable, "-c", "import sympy, numpy, scipy"}, "ExitCode"] === 0, False]];

  (* HPL and HypExp must be on $Path before PolyLogTools is loaded (it Needs["HPL`"]) *)
  Scan[If[! MemberQ[$Path, #], PrependTo[$Path, #]] &, Reverse[{Global`$HPLPath, Global`$HypExpPath}]];

  required = {
    FileNameJoin[{Global`$PolyLogPath, "PolyLogTools.m"}],
    FileNameJoin[{Global`$HPLPath, "HPL.m"}],
    FileNameJoin[{Global`$HypExpPath, "HypExp.m"}],
    FileNameJoin[{Global`$HyperInticaPath, "HyperIntica.wl"}],
    Global`$MBStandardHyperFLINTBinary,
    Global`$MBStandardHyperFLINTData,
    FileNameJoin[{dep, "MB", "MB.m"}], FileNameJoin[{dep, "MB", "MBresolve.m"}], FileNameJoin[{dep, "MB", "barnesroutines.m"}],
    FileNameJoin[{Global`$MBStandardMBDir, "MB.m"}],
    FileNameJoin[{Global`$MBStandardMBDir, "MBresolve.m"}],
    FileNameJoin[{Global`$MBStandardMBDir, "barnesroutines.m"}],
    FileNameJoin[{here, "MB2MPL.m"}],
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
    FileNameJoin[{here, "mbeLevel6Reduce.m"}], FileNameJoin[{dep, "level6_tables", "sl4re.m"}],
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
  binary = Global`$MBStandardHyperFLINTBinary;
  binaryOK = FileExistsQ[binary] && TrueQ[Quiet@Check[
    StringContainsQ[RunProcess[{binary, "--version"}, "StandardOutput"], "HF_VERSION"], False]];
  Global`$MBStandardIntegratorReady = binaryOK;

  (* MBAnalytica.wl checks all of this before it loads the engine and explains what is missing; a direct load of the
     engine stops here *)
  If[missing =!= {},
    Print["[MBAnalytica] the MB2MPL engine cannot load; missing files:"];
    Scan[Print["  ", #] &, missing];
    Abort[]];
  If[! (StringQ[ginshExecutable] && FileExistsQ[ginshExecutable]),
    Print["[MBAnalytica] the MB2MPL engine cannot load: ginsh (GiNaC) was not found. Install GiNaC and CLN, or set ",
      "$MBStandardGinshExecutable to its path before loading."];
    Abort[]];
  If[! binaryOK,
    Print["[MBAnalytica] the MB2MPL engine cannot load: the HyperFLINT binary ", binary,
      " does not run on this machine. Run make in the MBAnalytica folder."];
    Abort[]];
];
