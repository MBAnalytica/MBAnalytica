(* ::Package:: *)
(* AUTHORSHIP (release R3.1, 2026-10-03): MBSymbolicInt residue store and helper processes of the Subtraction family route.
   Authors of MBSymbolicInt: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)

(* mbeResidueStore.m -- PARALLEL RESIDUES FOR THE SUBTRACTION FAMILY ROUTE.

   The family route of the Subtraction route (mbeOneFoldTowerRung.m) closes the residues of an integral one after
   another.  Its multi-fold residues (Global`oftMultiFoldHandler: the general multifold handler, then the faithful cube)
   take minutes to half an hour each, and only the pieces inside one residue run on subkernels, so a family with many
   multi-fold residues leaves most of the machine idle.  This file adds:

   1. STORE.  A multi-fold residue closed by Global`oftMultiFoldHandler (an exact list of Laurent coefficients) is
      written to <store>/<key>.wxf, key = SHA256 of {code state, residue, regulator, orders}; a later request with the
      same key reads it.  The code state is the hash of the package's code files and integrator binaries, so a changed
      closer never serves an old value.  <store> = Global`$oftResidueStore if it is a directory name, else
      .cache/oft_residues of the release (Global`$oftResidueStore = False switches the store, the claims and the
      helpers off: the family route is then exactly that of release R3).
   2. CLAIMS.  The process that closes a residue holds the directory <key>.claim (atomic creation, its PID inside);
      another process that needs the same residue waits for the result, and closes the residue itself when the holder
      has stopped without a result.
   3. HELPERS.  For a family with at least Global`$oftHelperMinResidues (default 4) multi-fold residues,
      Global`$oftResidueHelpers helper processes (Automatic: up to 3, within the main-kernel budget of the resource
      policy, Global`$mbtMainKernelBudget, and the licence) close the multi-fold residues in other orders (from the
      end, from the middle, ...) into the store while this kernel runs the family route as before and reads what they
      closed.  The helpers (oft_residue_helper.wls) are stopped when the family route ends.  Every value comes from the
      same closers with the same gates; a helper that refuses a residue changes nothing (this kernel then closes or
      refuses it itself). *)

If[! TrueQ[Global`$orsInstalled] && DownValues[Global`oftMultiFoldHandler] =!= {} &&
    DownValues[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent] =!= {},
Module[{},
  If[! ValueQ[Global`$oftResidueStore], Global`$oftResidueStore = Automatic];
  If[! ValueQ[Global`$oftResidueHelpers], Global`$oftResidueHelpers = Automatic];
  If[! ValueQ[Global`$oftHelperMinResidues], Global`$oftHelperMinResidues = 4];
  If[! ValueQ[Global`$oftHelperMaximum], Global`$oftHelperMaximum = 3];
  If[! ValueQ[Global`$oftClaimPoll], Global`$oftClaimPoll = 5];   (* seconds between looks at a claimed residue *)
  Global`$orsDirectory = DirectoryName[ExpandFileName[$InputFileName]];
  Global`$orsHelperScript = FileNameJoin[{Global`$orsDirectory, "oft_residue_helper.wls"}];

  (* ---- the code state: every code file of the package and both integrator binaries ---- *)
  (* the store's own machinery (this file, oft_residue_helper.wls) decides where a value is computed, never what it is:
     it is not part of the code state *)
  Global`$orsCodeState = Module[{d = Global`$orsDirectory, files},
    files = Select[Join[
        DeleteCases[FileNames[{"mbe*.m", "mbt*.m", "MBSymbolicInt.wl", "MB.m", "MBresolve.m", "barnesroutines.m", "IntVol*.m", "intvol*.m",
          "hf_machinery.m", "engineN*.m", "load_*.m", "configure_runtime.m", "mbe*.py"}, d], _?(StringEndsQ[#, "mbeResidueStore.m"] &)],
        FileNames["*.m", FileNameJoin[{d, "multifold_close"}]], FileNames["*.m", FileNameJoin[{d, "intvolflint"}]],
        FileNames["*.m", FileNameJoin[{d, "mbtools"}]], FileNames["*.m", FileNameJoin[{Global`$MBStandardVendorDir, "MB"}]],
        {Global`$MBStandardHyperFLINTBinary, Global`$MBStandardHyperFLINTGuardedBinary}], StringQ[#] && FileExistsQ[#] &];
    (* with the identity of the dependencies (the Wolfram version, the third-party packages, the tables, the GiNaC
       shell): the code files alone let a value of another build of a dependency be served (review of e4f55bd) *)
    Hash[{MBAnalytica`SymbolicInt`Private`mbtDependencyState[], {FileNameTake[#], FileHash[#, "SHA256"]} & /@ Sort[DeleteDuplicates[files]]},
      "SHA256", "HexString"]];

  Global`orsRoot[] := Which[Global`$oftResidueStore === False, None,
    StringQ[Global`$oftResidueStore], Global`$oftResidueStore,
    True, FileNameJoin[{Global`$MBStandardCacheDir, "oft_residues"}]];
  Global`orsKey[term_, eps_, ordMin_, ordMax_] := Hash[{Global`$orsCodeState, term, eps, ordMin, ordMax}, "SHA256", "HexString"];
  Global`orsGoodQ[m_, n_] := ListQ[m] && Length[m] === n &&
    FreeQ[m, $Failed | $TimedOut | $Aborted | Indeterminate | ComplexInfinity | DirectedInfinity | _Missing];
  (* a message while reading is not a failure: creating a symbol such as Global`u in a kernel where another context has
     a u (General::shdw) is harmless; only the value decides *)
  Global`orsRead[file_] := With[{v = Quiet[Import[file, "WXF"]]}, If[FailureQ[v] || v === $Failed, $Failed, v]];
  (* written to a temporary name and renamed: a reader never sees a partial file *)
  Global`orsWrite[file_, value_] := Module[{tmp = file <> ".tmp" <> ToString[$ProcessID]},
    Quiet@Check[Export[tmp, value, "WXF"]; RenameFile[tmp, file, OverwriteTarget -> True], Quiet@DeleteFile[tmp]]];
  (* a claim's holder is alive while its PID runs a Wolfram kernel that started when the claim says (a reused PID of
     another program, or of another kernel, is not a holder) *)
  Global`orsStartTime[pid_Integer] := Quiet@Check[With[{a = RunProcess[{"ps", "-o", "lstart=", "-p", ToString[pid]}, "StandardOutput"]},
    If[StringQ[a], StringTrim[a], ""]], ""];
  Global`orsAliveQ[pid_Integer] := Global`orsAliveQ[{pid, None}];
  Global`orsAliveQ[{pid_Integer, started_}] := Quiet@Check[With[{a = RunProcess[{"ps", "-o", "args=", "-p", ToString[pid]}, "StandardOutput"]},
    StringQ[a] && StringContainsQ[a, "WolframKernel" | "MathKernel" | "math"] &&
      (! StringQ[started] || started === "" || started === Global`orsStartTime[pid])], False];
  Global`orsClaim[claim_String] := If[Quiet@Check[CreateDirectory[claim]; True, False] === True,
    Quiet@Check[Export[FileNameJoin[{claim, "owner"}], ToString[$ProcessID] <> "|" <> Global`orsStartTime[$ProcessID], "Text"], Null];
    True, False];
  (* {PID, start time} of the holder (an owner file of an older release has the PID alone), $Failed when it cannot be read *)
  Global`orsOwner[claim_String] := Quiet@Check[With[{parts = StringSplit[StringTrim[Import[FileNameJoin[{claim, "owner"}], "Text"]], "|"]},
    If[Length[parts] >= 1 && StringMatchQ[parts[[1]], DigitCharacter ..],
      {ToExpression[parts[[1]]], If[Length[parts] >= 2, parts[[2]], None]}, $Failed]], $Failed];
  Global`orsRelease[claim_String] := Quiet@DeleteDirectory[claim, DeleteContents -> True];
  (* a claim without a readable owner a minute after it was made: its holder stopped between making it and writing the
     owner, and the claim is released (it was waited for until the wait limit, hours, review of e4f55bd) *)
  If[! NumericQ[Global`$oftClaimGrace], Global`$oftClaimGrace = 60];
  Global`orsClaimAge[claim_String] := Quiet@Check[AbsoluteTime[] - AbsoluteTime[FileDate[claim, "Modification"]], 0];

  (* ---- 1-2. the store and the claims around the multi-fold slot ---- *)
  DownValues[Global`orsMultiFoldOrig] = DownValues[Global`oftMultiFoldHandler] /.
    HoldPattern[Global`oftMultiFoldHandler] -> Global`orsMultiFoldOrig;
  Clear[Global`oftMultiFoldHandler];
  (* the longest wait for a residue another process is closing: its own closing budget and an hour; then this kernel
     closes it itself (without the claim) *)
  If[! ValueQ[Global`$oftClaimWaitLimit], Global`$oftClaimWaitLimit = Automatic];
  Global`orsWaitLimit[] := If[NumericQ[Global`$oftClaimWaitLimit], Global`$oftClaimWaitLimit,
    If[NumericQ[Global`$oftMultiFoldBudget], Global`$oftMultiFoldBudget, 10800] + 3600];
  (* the store and the claims for one closing computation: key -> the stored value if present (and good), else the
     computation under the claim (stored when good), else -- another process holds the claim -- wait (a helper skips);
     Global`$orsLastFromStore tells the caller where the value came from *)
  SetAttributes[Global`orsStoredCall, HoldRest];
  Global`orsStoredCall[key_String, compute_, goodQ_, verbose_] := Module[
    {root = Global`orsRoot[], file, claim, m = $Failed, owner, t0 = AbsoluteTime[], said = False},
    Global`$orsLastFromStore = False;
    If[! DirectoryQ[root], Quiet@CreateDirectory[root, CreateIntermediateDirectories -> True]];
    file = FileNameJoin[{root, key <> ".wxf"}]; claim = FileNameJoin[{root, key <> ".claim"}];
    While[True,
      If[FileExistsQ[file], m = Global`orsRead[file];
        If[TrueQ[goodQ[m]], Global`$orsLastFromStore = True;
          If[verbose, Print["    [residue store] residue read from the store", If[said, " (closed by another process meanwhile)", ""], " (", StringTake[key, 12], ")"]];
          Return[m, Module]]];
      If[Global`orsClaim[claim],
        (* a stored file that does not read as a good value (a corrupt or truncated file) is replaced: it was kept, and
           every later request computed the residue again (review of e4f55bd) *)
        Internal`WithLocalSettings[Null, m = compute,
          If[TrueQ[goodQ[m]] && ! (FileExistsQ[file] && TrueQ[goodQ[Global`orsRead[file]]]), Global`orsWrite[file, m]];
          Global`orsRelease[claim]];
        Return[m, Module]];
      owner = Global`orsOwner[claim];
      (* the claim of this kernel itself, made by an outer call that closes the same residue: no other process can
         finish it, so it is closed here at once, and the claim stays with that call *)
      If[ListQ[owner] && owner[[1]] === $ProcessID && MemberQ[{None, "", Global`orsStartTime[$ProcessID]}, owner[[2]]],
        Return[compute, Module]];
      (* a holder that does not run is released, also when its PID is that of this kernel with another start time: such
         a claim of an earlier process was exempted, and waited for until the wait limit, four hours (review of 5045340) *)
      If[ListQ[owner] && ! Global`orsAliveQ[owner], Global`orsRelease[claim]; Continue[]];
      If[! ListQ[owner] && DirectoryQ[claim] && Global`orsClaimAge[claim] > Global`$oftClaimGrace, Global`orsRelease[claim]; Continue[]];
      (* a helper does not wait: another process holds this residue, the helper goes on to its next one *)
      If[TrueQ[Global`$orsHelperMode], Return[$Failed, Module]];
      If[AbsoluteTime[] - t0 > Global`orsWaitLimit[],
        If[verbose, Print["    [residue store] waited ", Round[AbsoluteTime[] - t0], " s for process ", owner, "; closing it here"]];
        Return[compute, Module]];
      If[! said && verbose, Print["    [residue store] being closed by process ", If[ListQ[owner], owner[[1]], "unknown"], "; waiting"]]; said = True;
      Pause[Global`$oftClaimPoll]]];
  Global`oftMultiFoldHandler[term_, eps_Symbol, ordMin_Integer, ordMax_Integer, verbose_] :=
    If[Global`orsRoot[] === None, Global`orsMultiFoldOrig[term, eps, ordMin, ordMax, verbose],
      Global`orsStoredCall[Global`orsKey[term, eps, ordMin, ordMax], Global`orsMultiFoldOrig[term, eps, ordMin, ordMax, verbose],
        Global`orsGoodQ[#, ordMax - ordMin + 1] &, verbose]];
  (* the u-dependent route (mbeParameterSubtractionDispatch.m): the closing ladder of one resolved term *)
  Global`orsPSHeavy[term_, i_, ep_, lo_, hi_, pars_, dom_, seconds_, cache_, baseRoot_] :=
    If[Global`orsRoot[] === None, MBParameterSubtraction`Private`psHeavyValue[term, i, ep, lo, hi, pars, dom, seconds, cache, baseRoot],
      Global`orsStoredCall[Hash[{Global`$orsCodeState, "PSHeavy", term, ep, lo, hi, pars, dom}, "SHA256", "HexString"],
        MBParameterSubtraction`Private`psHeavyValue[term, i, ep, lo, hi, pars, dom, seconds, cache, baseRoot],
        (AssociationQ[#] && KeyExistsQ[#, "Value"] && TrueQ[MBParameter`Private`exactQ[#["Value"], Append[pars, ep]]]) &,
        TrueQ[Global`$orsVerbose]]];
  (* the order in which a helper takes a list of n items *)
  Global`orsPermute[n_Integer, order_] := Which[
    order === "desc", Reverse[Range[n]],
    order === "mid", With[{c = Ceiling[n/2]}, Select[DeleteDuplicates[Flatten[Table[{c + k, c - k}, {k, 0, n}]]], 1 <= # <= n &]],
    order === "rot3", RotateLeft[Range[n], Floor[n/3]],
    (* "rot:q": start at the fraction q of the list *)
    StringQ[order] && StringStartsQ[order, "rot:"], RotateLeft[Range[n], Floor[n Quiet@ToExpression[StringDrop[order, 4]]]],
    True, Range[n]];
  (* the start points of nH helpers: the end, the middle, then evenly spaced fractions of the list *)
  Global`orsHelperOrders[nH_Integer] := Take[Join[{"desc", "mid"}, Table["rot:" <> ToString[InputForm[j/(nH + 1)]], {j, 1, Max[0, nH - 2]}]], nH];

  (* ---- 3. helper processes for families with several multi-fold residues ---- *)
  Global`orsHelperCount[heavy_Integer] := Module[{free, lic},
    If[! TrueQ[Global`$oftResidueHelpers === Automatic] && ! (IntegerQ[Global`$oftResidueHelpers] && Global`$oftResidueHelpers > 0),
      Return[0, Module]];
    If[! FileExistsQ[Global`$orsHelperScript] || ! StringQ[MBAnalytica`SymbolicInt`Private`$mbtMathExecutable] ||
       ! FileExistsQ[MBAnalytica`SymbolicInt`Private`$mbtMathExecutable] || heavy < Global`$oftHelperMinResidues, Return[0, Module]];
    If[DownValues[Global`mbtWorkerBudget] =!= {}, Global`mbtWorkerBudget[]];
    free = If[DownValues[Global`mbtMyMainKernelCount] =!= {} && IntegerQ[Global`$mbtMainKernelBudget],
      Global`$mbtMainKernelBudget - Global`mbtMyMainKernelCount[], 0];
    lic = If[IntegerQ[$MaxLicenseProcesses] && IntegerQ[$LicenseProcesses], $MaxLicenseProcesses - $LicenseProcesses, free];
    Max[0, Min[If[IntegerQ[Global`$oftResidueHelpers], Global`$oftResidueHelpers, Global`$oftHelperMaximum], free, lic, heavy - 1]]];
  Global`orsTree[pid_Integer] := Module[{kids},
    kids = MBAnalytica`Portable`ChildPIDs[pid];
    Join[Flatten[Global`orsTree /@ Select[kids, IntegerQ]], {pid}]];
  (* the PID of a process started by StartProcess is in the ProcessObject's own association *)
  Global`orsPID[p_ProcessObject] := Quiet@Check[With[{a = First[p]}, If[AssociationQ[a], Lookup[a, "PID", $Failed], $Failed]], $Failed];
  (* the STOP file is written with Put: this runs in the cleanup of an aborted computation as well, where Export (and
     Import) turned the abort of a TimeConstrained into an abort of the whole evaluation *)
  Global`orsStopHelpers[procs_List, jobDir_String] := Module[{pids},
    Quiet@Put["stop", FileNameJoin[{jobDir, "STOP"}]];
    pids = Flatten[With[{pid = Global`orsPID[#]}, If[IntegerQ[pid], Global`orsTree[pid], {}]] & /@ procs];
    (* literal PIDs of the helpers and of every process they started (subkernels, integrators) *)
    Scan[Quiet@RunProcess[{"kill", "-KILL", ToString[#]}] &, Select[pids, IntegerQ]];
    (* the job file goes; the helpers' logs stay in the job directory *)
    Quiet@DeleteFile[FileNameJoin[{jobDir, "job.wxf"}]]];

  (* start nH helper processes on a job (an association written to <store>/job_<pid>_<hash>/job.wxf); helper k takes the
     items in the order: 1 from the end, 2 from the middle outwards, 3 from a third of the list (the caller takes them
     from the start); a helper that is not running ten seconds later (a licence refused at that moment, ...) is started
     once more.  The wait ends as soon as every helper has either written its start marker (OFT_MARKER, the first statement
     of oft_residue_helper.wls) or stopped, instead of always after ten seconds (audit of 2026-11-09: ten idle seconds of
     the calling process on every start).  Returns {processes, job directory}. *)
  (* every start gets a job directory of its own: the directory of a tag was used again by a second start of the same
     tag in the same process, whose helpers then found the STOP file and the start markers of the first and stopped at
     once (review of e4f55bd).  The processes are recorded as they start, and an abort during the start stops those
     already started *)
  If[! IntegerQ[Global`$orsLaunchCount], Global`$orsLaunchCount = 0];
  Global`orsStartHelpers[job_Association, tag_, nH_Integer, verbose_] := Module[
    {root = Global`orsRoot[], jobDir, jobFile, orders, kernel = MBAnalytica`SymbolicInt`Private`$mbtMathExecutable, start, procs = {},
     marker, settled, deadline, done = False},
    Global`$orsLaunchCount = Global`$orsLaunchCount + 1;
    jobDir = FileNameJoin[{root, "job_" <> ToString[$ProcessID] <> "_" <> IntegerString[Hash[tag], 16] <> "_" <>
      IntegerString[Hash[{$SessionID, Global`$orsLaunchCount, AbsoluteTime[]}], 16, 8]}];
    Quiet@CreateDirectory[jobDir, CreateIntermediateDirectories -> True];
    jobFile = FileNameJoin[{jobDir, "job.wxf"}];
    Export[jobFile, Append[job, "Owner" -> $ProcessID], "WXF"];
    orders = Global`orsHelperOrders[nH];
    start[o_String, lg_String, mk_String] := Quiet@Check[StartProcess[{"bash", "-c", StringJoin["exec '", kernel,
        "' -noinit -noprompt -script '", Global`$orsHelperScript, "' >> '", lg, "' 2>&1"]},
      ProcessEnvironment -> Join[Association[GetEnvironment[]],
        <|"OFT_JOB" -> jobFile, "OFT_ORDER" -> o, "OFT_STORE" -> root, "OFT_MARKER" -> mk|>]], $Failed];
    marker[k_Integer, attempt_Integer] := FileNameJoin[{jobDir, "started_" <> ToString[k] <> "_" <> ToString[attempt]}];
    settled[p_, mk_String] := FileExistsQ[mk] || Head[p] =!= ProcessObject || ProcessStatus[p] =!= "Running";
    Internal`WithLocalSettings[Null,
      Do[AppendTo[procs, start[orders[[k]], FileNameJoin[{jobDir, "helper" <> ToString[k] <> ".log"}], marker[k, 1]]], {k, nH}];
      deadline = AbsoluteTime[] + 10;
      While[AbsoluteTime[] < deadline && ! AllTrue[Range[nH], settled[procs[[#]], marker[#, 1]] &], Pause[0.25]];
      Do[If[! (Head[procs[[k]]] === ProcessObject && ProcessStatus[procs[[k]]] === "Running"),
          If[verbose, Print["  [residue store] helper ", k, " stopped at start (exit code ",
            If[Head[procs[[k]]] === ProcessObject, ProcessInformation[procs[[k]]]["ExitCode"], "-"], "); starting it again"]];
          Pause[5];
          procs[[k]] = start[orders[[k]], FileNameJoin[{jobDir, "helper" <> ToString[k] <> ".log"}], marker[k, 2]]],
        {k, nH}];
      done = True,
      If[! done, Global`orsStopHelpers[Select[procs, Head[#] === ProcessObject &], jobDir]]];
    procs = Select[procs, Head[#] === ProcessObject &];
    If[verbose, Print["  [residue store] ", Length[procs], " helper process(es) started (orders ", Take[orders, Length[procs]],
      "), store ", root]];
    {procs, jobDir}];

  DownValues[Global`orsFamilyLaurentOrig] = DownValues[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent] /.
    HoldPattern[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent] -> Global`orsFamilyLaurentOrig;
  Clear[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent];
  MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[resList_, eps_, ordMin_, ordMax_, verbose_] := Module[
    {root = Global`orsRoot[], members, heavy, nH, started = {{}, None}},
    If[root === None || Global`$oftFamilyCacheKey === Hash[{resList, eps, ordMin, ordMax}],
      Return[Global`orsFamilyLaurentOrig[resList, eps, ordMin, ordMax, verbose], Module]];
    (* the residue list exactly as the family route forms it (the same census) *)
    members = If[DownValues[Global`mfrSameContourCensus] =!= {} && ! TrueQ[Global`$mfrDisabled],
      Global`mfrSameContourCensus[resList], resList];
    heavy = Select[Range[Length[members]], ListQ[members[[#, 2, 2]]] && Length[members[[#, 2, 2]]] >= 2 &];
    nH = Global`orsHelperCount[Length[heavy]];
    Internal`WithLocalSettings[Null,
      If[nH > 0,
        If[verbose, Print["  [residue store] ", Length[heavy], " multi-fold residues"]];
        started = Global`orsStartHelpers[<|"Kind" -> "Family", "Members" -> members[[heavy]], "Indices" -> heavy,
          "Regulator" -> eps, "OrderMin" -> ordMin, "OrderMax" -> ordMax|>, {resList, ordMin, ordMax}, nH, verbose]];
      Global`orsFamilyLaurentOrig[resList, eps, ordMin, ordMax, verbose],
      If[started[[1]] =!= {}, Global`orsStopHelpers[started[[1]], started[[2]]]]]];

  (* the u-dependent route: PSExpand (mbeParameterSubtractionDispatch.m) calls this after its census with the queue of
     resolved terms; for enough terms with folds, helpers run the same expansion with the queue in their own orders,
     in helper mode (a term another process holds, or one it cannot close, is skipped), filling the store that the
     closing ladder of each term reads (Global`orsPSHeavy).  Returns what Global`orsStopHelpers needs. *)
  Global`orsPSLaunch[f_, ep_, c_Association, lo_, hi_, seconds_, cache_, resolved_List] := Module[{heavy, nH},
    If[Global`orsRoot[] === None || TrueQ[Global`$orsHelperMode], Return[{{}, None}, Module]];
    heavy = Count[resolved, t_ /; ListQ[t[[2, 2]]] && Length[t[[2, 2]]] >= 1];
    nH = Global`orsHelperCount[heavy];
    If[nH > 0,
      Global`orsStartHelpers[<|"Kind" -> "PS", "Source" -> f, "Regulator" -> ep, "Contract" -> c, "OrderMin" -> lo,
        "OrderMax" -> hi, "Seconds" -> seconds, "Cache" -> cache|>, {f, lo, hi}, nH, TrueQ[Global`$orsVerbose]],
      {{}, None}]];

  Global`$orsInstalled = True;
  Print["[mbeResidueStore] residue store, claims and helper processes of the Subtraction family route installed (store: ",
    Global`orsRoot[], "; helpers: ", Global`$oftResidueHelpers, ", from ", Global`$oftHelperMinResidues, " multi-fold residues)."];
]];
