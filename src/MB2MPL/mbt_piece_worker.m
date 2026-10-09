(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* mbt_piece_worker.m -- process-parallel per-piece worker invoked by
   MBresolveToMPL's "PieceKernels" path.  Separate OS process => ginsh stderr
   floods cannot kill the master kernel.
   env: JOBROOT (dir with meta.m + p_####.m), LO, STRIDE.
   Writes r_####.m atomically (.tmp -> rename) with status/value/inputHash. *)
Off[General::shdw];
(* 2026-09-07 SUBKERNEL WORKERS: the master may run this file inside parallel subkernels (LaunchKernels) instead of
   separate math processes.  The job parameters then come from Global`$mbtWorkerJobRoot / $mbtWorkerLO / $mbtWorkerStride
   (set by the master through ParallelEvaluate) instead of the environment, $KernelID is nonzero, and the worker's
   output (Print, messages and the rungs' WriteString["stdout", ...]) goes to its own log file w_<LO>.log in the job
   directory, as the shell launcher did by redirection.  A -noinit subkernel has not run the user's init.m, which a
   math -script process would have; it is loaded here so that both kinds of worker see the same paths. *)
jobRoot = If[StringQ[Global`$mbtWorkerJobRoot], Global`$mbtWorkerJobRoot, Environment["JOBROOT"]];
LO = If[IntegerQ[Global`$mbtWorkerLO], Global`$mbtWorkerLO, ToExpression@Environment["LO"]];
STRIDE = If[IntegerQ[Global`$mbtWorkerStride], Global`$mbtWorkerStride, ToExpression@Environment["STRIDE"]];
If[$KernelID =!= 0,
  (* appended: the fresh workers of a later round write to the same log *)
  Global`$mbtWorkerLog = OpenAppend[FileNameJoin[{jobRoot, "w_" <> ToString[LO] <> ".log"}], FormatType -> OutputForm];
  $Output = {Global`$mbtWorkerLog}; $Messages = {Global`$mbtWorkerLog};
  Unprotect[WriteString]; WriteString["stdout", a___] := WriteString[Global`$mbtWorkerLog, a]; Protect[WriteString];
  With[{ini = FileNameJoin[{$UserBaseDirectory, "Kernel", "init.m"}]}, If[FileExistsQ[ini], Quiet@Get[ini]]];
  Print["[worker] running as subkernel ", $KernelID, " (PID ", $ProcessID, "), LO=", LO, " STRIDE=", STRIDE]];
meta = Get[FileNameJoin[{jobRoot, "meta.m"}]];
(* MB_standard: bind the bundled PolyLogTools/HPL/HypExp/HyperIntica paths BEFORE any package loads *)
Get[FileNameJoin[{meta["pkgDir"], "configure_runtime.m"}]];
SetDirectory[meta["pkgDir"]];
Global`$IV$NoLibrary = True;   (* no IntVol knowledge library in this release *)
Get[meta["pltPath"]];
If[Environment["IVLIB_OFF"] === "1", Global`$IV$NoLibrary = True];   (* 2026-08-31: pilot library not attached in production *)
Get[meta["pkgPath"]];
Get[FileNameJoin[{Global`$MBStandardMBDir, "MB.m"}]];
Get[FileNameJoin[{Global`$MBStandardMBDir, "MBresolve.m"}]];
Get[FileNameJoin[{Global`$MBStandardMBDir, "barnesroutines.m"}]];
(* 2026-07-24: load the sidecars in workers too (they were master-only, so
   attempt 0.75 / the pinch closer silently skipped inside workers and every
   such piece fell to the serial master mop-up). Guarded: worker still runs
   without them. *)
Module[{sq = FileNameJoin[{meta["pkgDir"], "mbeSeqIntegrate.m"}],
        pq = FileNameJoin[{meta["pkgDir"], "mbePinchClose.m"}]},
  If[FileExistsQ[sq], Quiet@Get[sq]];
  If[FileExistsQ[pq], Quiet@Get[pq]]];
Module[{rz = FileNameJoin[{meta["pkgDir"], "mbeReflZero.m"}]},
  If[FileExistsQ[rz], Quiet@Get[rz]]];   (* 2026-09-03: reflection-zero closer in workers too *)
Module[{ab = FileNameJoin[{meta["pkgDir"], "mbeAffineBellRung.m"}]},
  If[FileExistsQ[ab], Quiet@Get[ab]]];   (* 2026-09-04: affine-Bell rung in workers *)
Module[{fg = FileNameJoin[{meta["pkgDir"], "mbeFlagGuard.m"}]},
  If[FileExistsQ[fg], Global`$mbeFlagGuardQuiet = True; Quiet@Get[fg]]];   (* 2026-10-02: the HypExp routines leave the
     package switches as they found them when a call is stopped by a time limit; HypExp is loaded on demand here, and
     the guard completes its installation then *)
(* 2026-08-31: no pre-computed library is attached in production; the former per-worker delta-file block was removed. *)
ep = \[Epsilon];

(* 2026-08-30 IntVolFLINT strategy in the worker — PROMOTED (default ON; the master exports IVF_HOOK=0 to opt
   out, see load_standard_w10.m): the worker loads the IntVolFLINT hook so that plain IntVolIntegrate calls
   inside the worker are offered to IntVolFLINT first (the dispatcher slot needs the master's engine stack and
   is skipped here).  Guarded: any load failure leaves the worker unchanged.  Revert: .bak_pre_promotion_20260830. *)
If[Environment["IVF_HOOK"] =!= "0",
  Quiet@Check[
    Module[{ivfDir = FileNameJoin[{meta["pkgDir"], "intvolflint"}]},
      If[DownValues[Global`gvN] === {},
        Get[FileNameJoin[{Global`$HyperInticaPath, "HyperIntica.wl"}]]; HyperIntica`$QuietPrint = True;
        Get[FileNameJoin[{meta["pkgDir"], "hf_machinery.m"}]]];
      Get[FileNameJoin[{ivfDir, "ivf_machinery.m"}]];
      Global`$ivfBin = Global`$MBStandardHyperFLINTBinary;
      Global`$IVFUseIntVolFLINT = True;
      Get[FileNameJoin[{ivfDir, "ivf_dispatch_hook.m"}]];
      Get[FileNameJoin[{ivfDir, "ivf_ext_finitepart_gconv.m"}]];   (* 2026-08-31 finite-part mode + G conversion *)
      Print["[ivf-worker] IntVolFLINT hook loaded in worker ", $ProcessID]],
    Print["[ivf-worker] IntVolFLINT hook load FAILED — worker continues unchanged"]]];

(* 2026-09-04: exact multi-fold rung in workers (mbeTwoVarPsiRung.m: BWS engine for multi-variable psi arguments,
   mbeStdClose retries, post-failure exact ladder).  It needs the strategy engines (MBEStrategy`mbeStdClose,
   engineN_lib, hf_machinery; HyperIntica is shared with the IVF hook above), so load load_mbe_engines.m guarded
   first, then the rung.  Any load failure leaves the worker unchanged (the master's serial mop-up carries it). *)
Quiet@Check[
  Module[{le = FileNameJoin[{meta["pkgDir"], "load_mbe_engines.m"}],
          en = FileNameJoin[{meta["pkgDir"], "mbeTwoVarPsiRung.m"}]},
    (* test DEFINITIONS, not the symbol name: the package mentions MBEStrategy`mbeStdClose in its guard, so the
       symbol exists in every worker while its DownValues are empty until load_mbe_engines.m runs *)
    If[DownValues[MBEStrategy`mbeStdClose] === {} && FileExistsQ[le], Get[le]];
    If[FileExistsQ[en], Get[en]];
    (* 2026-09-05: sixth-root-of-unity reduction (Henn-Smirnov-Smirnov tables) used by the rung's cube closures *)
    Module[{l6 = FileNameJoin[{meta["pkgDir"], "mbeLevel6Reduce.m"}]}, If[FileExistsQ[l6], Quiet@Get[l6]]];
    (* 2026-09-06: Barnes-lemma pre-reduction rung (exact fold reduction) used by the wrap for >= 3-fold pieces *)
    Module[{bp = FileNameJoin[{meta["pkgDir"], "mbeBarnesPreReduce.m"}]}, If[FileExistsQ[bp], Quiet@Get[bp]]];
    (* 2026-09-15: Barnes second lemma with a polygamma difference (exact fold reduction of psi pieces on a
       Saalschuetzian kernel) used by the wrap for >= 2-fold pieces *)
    Module[{b2 = FileNameJoin[{meta["pkgDir"], "mbeBarnes2PsiReduce.m"}]}, If[FileExistsQ[b2], Quiet@Get[b2]]];
    Print["[worker] exact multi-fold rung installed? ",
      DownValues[Global`bwsStdCloseOrig] =!= {} && TrueQ[Global`$bwsCachedWrapInstalled],
      "   (dispatch defined? ", DownValues[MBEStrategy`mbeStdClose] =!= {},
      "; IVF hook installed? ", DownValues[Global`IVFPrevIntVolIntegrate] =!= {}, ")"]],
  Print["[worker] exact multi-fold rung load FAILED \[LongDash] worker continues unchanged"]];
(* 2026-09-04 (evening): the IVF hook above loads BEFORE the strategy engines exist in this kernel, so its two
   dispatcher slots (mbeIntegrateCube -> IntVolFLINT first; the projective order race on mbeHFExactCube) were never
   armed in workers ("dispatcher not loaded in this kernel — mbeIntegrateCube slot skipped"): every engineN cube ran
   on the plain single-order HyperFLINT path and was refused, which is why the workers failed the whole EngineN class
   (pass 4: 0138/0140/0142/0143/0146) while the master closed some of them.  Re-Get the hook now that the engines are
   loaded: the slot installers are guarded (originals saved once; the IntVolIntegrate slot is not re-wrapped). *)
If[Environment["IVF_HOOK"] =!= "0" && DownValues[MBEStrategy`mbeStdClose] =!= {},
  Quiet@Check[Get[FileNameJoin[{meta["pkgDir"], "intvolflint", "ivf_dispatch_hook.m"}]], Null];
  Print["[worker] IVF dispatcher slots armed after the engines? mbeIntegrateCube ",
    DownValues[Global`IVFOrigIntegrateCube] =!= {}, "  mbeHFExactCube race ", DownValues[Global`IVFOrigHFExactCube] =!= {}]];
(* 2026-09-08 RESOURCE SCALING of the hyperlogarithm integrator inside the worker: {threads per hyperflint process,
   candidates raced at once, seconds per candidate} come from the master (Global`$mbtIVFScaling, set through
   ParallelEvaluate before this file is loaded -- a subkernel does not inherit the master's later environment) or,
   for a process worker, from the environment the master exported.  Every race of the package (ivfRaceRequests:
   chart races, the BWS rung's order races, the projective race) is batched to that width and its lanes run at that
   thread count; the single calls of ivf_machinery.m and hf_machinery.m use the same thread count. *)
Module[{sc = Global`$mbtIVFScaling, envI},
  envI[name_] := Module[{v = Quiet@ToExpression[Environment[name]]}, If[IntegerQ[v] && v > 0, v, None]];
  If[! (ListQ[sc] && Length[sc] === 3), sc = {envI["IVF_THREADS"], envI["IVF_RACE_WIDTH"], envI["IVF_SECONDS"]}];
  If[IntegerQ[sc[[1]]], Global`$ivfRaceThreads = sc[[1]]; Global`$ivfThreadsSingle = sc[[1]]; Global`$ivfChartThreads = sc[[1]]];
  If[IntegerQ[sc[[2]]], Global`$ivfRaceWidth = sc[[2]];
    (* 2026-09-09: the ORDER race of the exact rung keeps its own width (four lanes) and is NOT narrowed by the
       chart-race width exported here.  Narrowing it made the rung try one elimination order, and the fail-fast
       divergence rule ("a divergence in one order refuses the cube") then refused pieces that close cleanly in
       another order: MB8a's pieces 1400/1403 were ledgered by subkernels at width 1 and at width 2, while a
       process worker at the default width 4 closed both in seconds.  The lanes are per piece and short-lived, so
       the cost is bounded by the worker count, which the resource policy already caps. *)];
  If[IntegerQ[sc[[3]]], Global`$ivfSeconds = sc[[3]]];
  If[AnyTrue[sc, IntegerQ], Global`$ivfScaledQ = True;
    Print["[worker] IntVolFLINT scaling applied: threads ", sc[[1]], ", race width ", sc[[2]], ", seconds ", sc[[3]]]]];

(* per-process GiNaC temp dir + no shared disk-cache writes *)
If[NameQ["PolyLogTools`GiNaC$InterfacePath"],
  PolyLogTools`GiNaC$InterfacePath =
    FileNameJoin[{jobRoot, "ginac", ToString[LO] <> "-" <> ToString[$ProcessID]}] <> "/";
  Quiet@CreateDirectory[PolyLogTools`GiNaC$InterfacePath, CreateIntermediateDirectories -> True]];
MBtoMPL`Private`$mbtUseMB2MPLDiskCache = False;
MBtoMPL`Private`$mbtUseDoABCache = False;
MBtoMPL`Private`$mbtUseLongClose = True;
MBtoMPL`Private`$mbtLongCloseMinVars = 1;

(* bootstrap nested closer via a trivial corner-free MB *)
(* 2026-09-05 AUDIT KNOB: env MBT_PIECE_LIBRARY_OFF=1 disables the certified PIECE library in this worker regardless of
   the master's setting (fresh-derivation audits of library targets whose RESOLUTION record must stay, e.g. MB11). *)
Module[{be, bmb},
  bmb = (E^(2 (EulerGamma + I Pi) be) Gamma[-z35] Gamma[2 - 4 be] Gamma[4 - 4 be] Gamma[1 - z35 - 3 be] Gamma[1 - 2 be] Gamma[1 + z35 - be] Gamma[be] Gamma[z35 + be]^2)/(Gamma[4 - 8 be] Gamma[2 + z35 - 3 be] Gamma[2 - 2 be]);
  (* 2026-09-15: "DiskCache" -> False.  The entry point sets the disk-cache flags from this option (default True), so
     the bootstrap call silently RE-ENABLED the piece cache in every worker after the line above had disabled it:
     workers wrote the shared cache and, in a second run, read it (a regression run "from scratch" was so only
     while the cache was empty).  The flags are asserted again after the call. *)
  Quiet @ MBtoMPL`MBresolveToMPL[bmb, be,
    "EpsOrderMin" -> 0, "EpsOrderMax" -> 0, "Verbose" -> False, "DiskCache" -> False,
    "PieceKernels" -> 0, "UseCertifiedLibrary" ->
      (TrueQ[Lookup[meta, "useCertifiedLibrary", True]] && Environment["MBT_PIECE_LIBRARY_OFF"] =!= "1")]];
MBtoMPL`Private`$mbtUseMB2MPLDiskCache = False;
MBtoMPL`Private`$mbtUseDoABCache = False;
If[Environment["MBT_PIECE_LIBRARY_OFF"] === "1", MBtoMPL`Private`$mbtUseCertifiedLibrary = False;
  Print["[worker] AUDIT: certified piece library DISABLED in this worker (MBT_PIECE_LIBRARY_OFF=1)"]];
(* 2026-09-04/05: the exact-ladder wrap of mbeTwoVarPsiRung.m PART C is a persistent, more specific rule installed at
   sidecar load; the bootstrap call above (re)defines only the generic rule, which stays behind it.  Report its state. *)
If[DownValues[Global`bwsInstallCachedWrap] =!= {}, Quiet@Check[Global`bwsInstallCachedWrap[], Null];
  Print["[worker] exact ladder wrap active? ",
    ! FreeQ[DownValues[MBtoMPL`Private`mbtCachedMB2MPL], Global`$bwsInOrig]]];

np = meta["nPieces"];
(* 2026-09-05 23:30 DYNAMIC CLAIMING (regression wave C: with 8 workers and the static stride LO, LO+8, ... every hard
   piece of MB12 -- they sit 8 apart in the piece list -- landed on worker 5, which ran them serially for 20 minutes
   while the other seven workers finished in four and exited).  A worker now walks the WHOLE list starting at its LO
   (rotated) and claims a piece by an atomic mkdir (claim_####); a piece claimed by another worker is skipped.  The
   r-files, the master's polling and its mop-up guard are unchanged. *)
claimQ[j_] := Quiet@Check[CreateDirectory[FileNameJoin[{jobRoot, "claim_" <> IntegerString[j, 10, 4]}]]; True, False];
(* MBAnalytica: a subkernel worker closes at most $mbtWorkerMaxPieces pieces (set by the master) and then exits, so that
   a fresh kernel continues; a process worker has no limit *)
maxPieces = If[IntegerQ[Global`$mbtWorkerMaxPieces] && Global`$mbtWorkerMaxPieces > 0, Global`$mbtWorkerMaxPieces, Infinity];
closedPieces = 0;
Catch[Do[
  Module[{tag = IntegerString[j, 10, 4], pf, rf, p, val, status,
      learnedHits0, learnedHit, inexact, reasons, claimed = False},
    rf = FileNameJoin[{jobRoot, "r_" <> tag <> ".m"}];
    If[! FileExistsQ[rf] && claimQ[j],
      claimed = True;
      pf = FileNameJoin[{jobRoot, "p_" <> tag <> ".m"}];
      p = Quiet @ Check[Get[pf], $Failed];
      If[! AssociationQ[p],
        Put[<|"status" -> "ReadFailed", "value" -> 0, "epsFac" -> 0|>, rf <> ".tmp"];
        RenameFile[rf <> ".tmp", rf, OverwriteTarget -> True],
        MBtoMPL`Private`$mbtFailedPieces = {};
        learnedHits0 = MBtoMPL`Private`$mbtLearnedPieceHits;
        val = MBtoMPL`Private`mbtCachedMB2MPL[p["integEps1"], p["ctr"], p["vrs"]];
        learnedHit = MBtoMPL`Private`$mbtLearnedPieceHits > learnedHits0;
        SetDirectory[meta["pkgDir"]];
        (* 2026-09-05 NO SERVED FLOATS: an inexact number (any precision; Complex atoms included) is never "Clean" *)
        inexact = Cases[val, q_?NumberQ /; Precision[Unevaluated[q]] =!= Infinity :> q, {0, Infinity}, Heads -> True] =!= {};
        status = If[MBtoMPL`Private`$mbtFailedPieces === {} && ! inexact &&
                    MBtoMPL`Private`mbtCleanNumQ[val, p["vrs"]], "Clean", "Failed"];
        reasons = Join[ToString[Lookup[#, "reason", "?"]] & /@ MBtoMPL`Private`$mbtFailedPieces,
          If[inexact, {"inexact-value(precision " <> ToString[Quiet@N[Precision[val], 4]] <> ")"}, {}],
          If[status === "Failed" && MBtoMPL`Private`$mbtFailedPieces === {} && ! inexact, {"not-clean-numeric"}, {}]];
        Put[<|"status" -> status, "value" -> val, "epsFac" -> p["epsFac"],
          "certifiedLibraryHit" -> learnedHit, "failReasons" -> reasons|>, rf <> ".tmp"];
        RenameFile[rf <> ".tmp", rf, OverwriteTarget -> True]]];
    If[claimed,
      closedPieces++;
      If[closedPieces >= maxPieces,
        Print["[worker] recycled after ", closedPieces, " pieces"];
        Throw[Null, "mbtRecycle"]]]],
  {j, Join[Range[Min[LO, np], np], Range[1, Min[LO, np] - 1]]}], "mbtRecycle"];
(* 2026-09-07: inside a subkernel the master closes the kernel afterwards; Quit here would kill it before the master collects *)
If[$KernelID === 0, Quit[], Quiet@Close[Global`$mbtWorkerLog]];
