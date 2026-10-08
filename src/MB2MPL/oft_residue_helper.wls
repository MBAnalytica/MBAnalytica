#!/usr/bin/env wolframscript
(* AUTHORSHIP (release R3.1, 2026-10-03): MB2MPL helper process of the Subtraction route.
   Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* oft_residue_helper.wls -- started by mbeResidueStore.m, never by hand.  It loads the release and reads one job:
     "Family": the multi-fold residues of one family of the Subtraction family route (mbeOneFoldTowerRung.m), closed in
               this helper's order with the same closer (Global`oftMultiFoldHandler);
     "PS":     one u-dependent integrand of the parameter Subtraction ladder (mbeParameterSubtractionDispatch.m),
               expanded with its queue of resolved terms in this helper's order.
   Every closed residue or term goes into the residue store, which the process that started the helper reads; a residue
   another process holds is skipped.  The helper stops when its job's STOP file appears or the job file is gone.
   Environment: OFT_JOB (job file), OFT_ORDER (desc | mid | rot3), OFT_STORE (store directory). *)
$HistoryLength = 0;
here = DirectoryName[ExpandFileName[If[StringQ[$InputFileName] && $InputFileName =!= "", $InputFileName, First[$ScriptCommandLine]]]];
If[here === "", here = Directory[]];
SetDirectory[here];
Global`$oftResidueHelpers = 0;      (* a helper starts no helpers *)
Global`$orsHelperMode = True;       (* a residue held by another process is skipped, not waited for *)
Global`$mbtNestedInWorker = True;   (* no process workers beyond the main-kernel budget *)
Global`$oftResidueStore = Environment["OFT_STORE"];
Get[FileNameJoin[{here, "load_standard.m"}]];
Module[{jobFile = Environment["OFT_JOB"], job, n, seq, order = Environment["OFT_ORDER"], stopQ, t0, m},
  (* reading the job creates its symbols here (Global`u, ...): a shadowing message is harmless, only the value decides *)
  job = Global`orsRead[jobFile];
  If[! AssociationQ[job], Print["[residue helper] no job: ", jobFile]; Exit[5]];
  stopQ[] := FileExistsQ[FileNameJoin[{DirectoryName[jobFile], "STOP"}]] || ! FileExistsQ[jobFile];
  Switch[Lookup[job, "Kind", "Family"],
    "Family",
      n = Length[job["Members"]]; seq = Global`orsPermute[n, order];
      Print["[residue helper] ", $ProcessID, " for process ", job["Owner"], ": ", n, " multi-fold residue(s), order ", order, "  ", DateString[]];
      Do[If[stopQ[], Break[]];
        t0 = AbsoluteTime[];
        m = Quiet@CheckAbort[Global`oftMultiFoldHandler[job["Members"][[j]], job["Regulator"], job["OrderMin"], job["OrderMax"], True], $Aborted];
        Print["[residue helper] residue ", job["Indices"][[j]], ": ", If[ListQ[m], "closed", "not closed here"], " (", Round[AbsoluteTime[] - t0], " s)  ", DateString[]],
        {j, seq}],
    "PS",
      Print["[residue helper] ", $ProcessID, " for process ", job["Owner"], ": u-dependent integrand, queue order ", order, "  ", DateString[]];
      t0 = AbsoluteTime[];
      (* the same frame as MBParameter`MBParameterExpand gives PSExpand *)
      m = Quiet@CheckAbort[Block[{Global`$psQueueOrder = order, Global`$psStopQ = stopQ,
          MBParameter`Private`$trace = {}, MBParameter`Private`$pieceValues = <||>, MBParameter`Private`$pieceChecks = <||>,
          MBParameter`Private`$closureMemo = <||>, MBParameter`Private`$fixedBarnesMemo = <||>,
          MBParameter`Private`$sourceGateSamples = <||>, MBParameter`Private`$parameterResidueRepairs = {}},
        MBParameterSubtraction`PSExpand[job["Source"], job["Regulator"], job["Contract"], job["OrderMin"], job["OrderMax"],
          job["Seconds"], job["Cache"]]], $Aborted];
      Print["[residue helper] queue done (", Round[AbsoluteTime[] - t0], " s)  ", DateString[]]];
  Print["[residue helper] done  ", DateString[]]];
Quiet@CloseKernels[];
Exit[0];
