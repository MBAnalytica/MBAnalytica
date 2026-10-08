#!/usr/bin/env wolframscript
(* AUTHORSHIP (release R2, 2026-09-07): MB2MPL regression script. Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* Full regression of the MB_standard release with timing: every benchmark target through the Standard route (sealed
   core + rungs, no library), every piece recomputed (disk cache off, no checkpoint resume), per-target wall times.
   Usage:  PK=8 wolframscript -file run_regression.wls          (PK = maximum piece workers per target; default Automatic = the resource policy;
           WORKER_MODE=Processes selects separate math kernels instead of the default parallel subkernels)
           ROUTE=Subtraction wolframscript -file run_regression.wls   (release R3.1: the Subtraction route, every inclusive target
           to its SealedSubtractionMax and every u-dependent family on its SubtractionOrderRanges, each in a fresh kernel
           through run_target.wls, one at a time; TARGETS=MB6u,MB11 selects a subset)
           ROUTE=Subtraction R3=1 wolframscript -file run_regression.wls   (the regression of release R3: its verified targets,
           then the general multifold handler on the differential families of MB13, MB8 and MB14 in three further kernels;
           MULTIFOLD=0 skips those)
           FRESH=0 keeps the run-time stores under .cache/ (default: they are set aside, so that every value is recomputed)
   Output: regression_report.txt in the release directory and the per-target checkpoints in standard_serial_results/. *)
Module[{here = Module[{f = If[StringQ[$InputFileName] && $InputFileName =!= "", $InputFileName,
      If[ListQ[$ScriptCommandLine] && $ScriptCommandLine =!= {}, First[$ScriptCommandLine], ""]]},
      If[f === "", "", DirectoryName[ExpandFileName[f]]]], pk, t0, summary, report, rows, allPass, mfQ = False,
    fams = {{"MB13", "MB13u", "MB13u"}, {"MB8", "MB8u", "MB8au+MB8bu"}, {"MB14", "MB14u", "MB14au+MB14bu"}}, kernel, w, sec, procs = {}, t1, recDir, rec, sumFile, nh, helperPlan, helpers = {}, t2, tEnd, mfRows = {}, tPub,
    names, after, light, tLight = 0, recs = <||>, cacheDir},
  If[here === "", here = Directory[]];
  SetDirectory[here];
  (* MBAnalytica layout: the run-time stores are in the cache folder (MBANALYTICA_CACHE, else the default of
     configure_runtime.m), the engine in src/MB2MPL *)
  cacheDir = With[{e = Environment["MBANALYTICA_CACHE"]}, If[StringQ[e] && e =!= "", e,
    FileNameJoin[{$UserBaseDirectory, "ApplicationData", "MBAnalytica"}]]];
  pk = ToExpression[Environment["PK"]]; If[! IntegerQ[pk] || pk < 0, pk = Automatic];   (* Automatic = the resource policy (2026-09-08) *)
  $MBSerialPieceKernels = pk;
  $MBSerialWorkerMode = If[Environment["WORKER_MODE"] === "Processes", "Processes", "Subkernels"];
  $MBSerialDiskCache = False;   (* recompute every piece *)
  $MBSerialResume = False;      (* ignore existing checkpoints *)
  $MBSerialOrderMode = "SealedStandard";
  $MBSerialRoute = If[ToLowerCase[ToString[Environment["ROUTE"]]] === "subtraction", "Subtraction", "Standard"];  (* ROUTE env *)
  (* 2 October 2026: a regression measures the release from EMPTY run-time state.  The exact stores of the closers under
     .cache/ (cube pieces, hypergeometric blocks, the multifold piece and term caches, ...) are content-addressed and
     correct to reuse, but a value read from them is not recomputed.  Unless FRESH=0 they are set aside before the first
     target (renamed with a time stamp, never deleted); the multifold family runs and their helpers then share the
     stores they fill during this regression only.  The records of earlier family runs (.cache/multifold_family) are set
     aside as well: a record read at the end is one this regression wrote. *)
  If[Environment["FRESH"] =!= "0",
    Module[{stamp = DateString[{"Year", "Month", "Day", "_", "Hour", "Minute", "Second"}], moved = {}},
      Do[With[{d = FileNameJoin[{cacheDir, s}]},
          If[DirectoryQ[d] && Quiet@Check[RenameDirectory[d, d <> "_before_" <> stamp], $Failed] =!= $Failed, AppendTo[moved, s]]],
        {s, {"fcu", "hypergeometric_blocks", "multifold_close", "multifold_family", "mb2mpl", "doab", "shared_affine_gauss", "oft_residues"}}];
      Print["FRESH  run-time state set aside before the regression: ", If[moved === {}, "none present", moved], "  (FRESH=0 keeps it)"]]];
  Get[FileNameJoin[{here, "MB2MPL_StandardRoute.wl"}]];
  MBtoMPL`Private`$mbtUseMB2MPLDiskCache = False;
  Print["MB_standard regression: ", DateString[], "  PieceKernels ", pk, "  disk cache off  resume off"];
  t0 = AbsoluteTime[];
  (* ---- release R3.1 (4 October 2026): on the Subtraction route every inclusive target of the ledger (to its
     SealedSubtractionMax) and every u-dependent family (on its SubtractionOrderRanges) runs in a FRESH KERNEL through
     run_target.wls, ONE AT A TIME (each target gets the whole machine; the resource policy sizes its workers).
     TARGETS=MB6u,MB11 selects a subset; R3=1 keeps the regression of release R3 (below).  Per-target logs and records
     under .cache/regression_targets_<stamp>/; the report is regression_report.txt. ---- *)
  If[$MBSerialRoute === "Subtraction" && Environment["R3"] =!= "1",
    Module[{items, sel = Environment["TARGETS"], kern, outDir, rows31 = {}, ts, logf, line, ok, allOk},
      (* the ledger must have loaded; a regression of no target is never green *)
      If[! ListQ[mbSerialTargets] || ! AssociationQ[mbSerialUData],
        Print["R3.1 SUBTRACTION REGRESSION: the release did not load from ", here, " -- NOT_GREEN"]; Exit[2]];
      items = Join[
        {"u", #1, First[#2], Last[#2]} & @@@ Normal[Lookup[mbSerialUData, "SubtractionOrderRanges", <||>]],
        {"inc", #["Name"], #["OrderMin"], #["SealedSubtractionMax"]} & /@ Select[mbSerialTargets, KeyExistsQ[#, "SealedSubtractionMax"] &]];
      If[StringQ[sel] && sel =!= "", items = Select[items, MemberQ[StringTrim /@ StringSplit[sel, ","], #[[2]]] &]];
      kern = FileNameJoin[{$InstallationDirectory, "Executables", "WolframKernel"}];
      If[! FileExistsQ[kern], kern = First[$CommandLine]];
      outDir = FileNameJoin[{cacheDir, "regression_targets_" <> DateString[{"Year", "Month", "Day", "_", "Hour", "Minute", "Second"}]}];
      Quiet@CreateDirectory[outDir, CreateIntermediateDirectories -> True];
      Print["R3.1 SUBTRACTION REGRESSION  ", Length[items], " targets, one at a time, records in ", outDir];
      Do[logf = FileNameJoin[{outDir, it[[2]] <> "_" <> ToString[it[[3]]] <> "_" <> ToString[it[[4]]] <> ".log"}];
        ts = AbsoluteTime[];
        Print["R31 begin ", it[[1]], " ", it[[2]], " eps^", it[[3]], "..eps^", it[[4]], "  ", DateString[]];
        RunProcess[{"bash", "-c", StringJoin["exec '", kern, "' -noinit -noprompt -script '", FileNameJoin[{here, "run_target.wls"}],
            "' > '", logf, "' 2>&1"]},
          ProcessEnvironment -> Join[Association[GetEnvironment[]], <|"KIND" -> it[[1]], "NAME" -> it[[2]], "LO" -> ToString[it[[3]]],
            "HI" -> ToString[it[[4]]], "OUT" -> outDir, "PK" -> If[IntegerQ[pk], ToString[pk], ""]|>]];
        line = Select[StringSplit[Quiet@Check[Import[logf, "Text"], ""], "\n"], StringContainsQ[#, "TARGET_RESULT"] &];
        ok = line =!= {} && StringContainsQ[Last[line], "pass \"True\""];
        AppendTo[rows31, <|"MB" -> it[[2]], "Kind" -> it[[1]], "Range" -> it[[3 ;; 4]], "Seconds" -> Round[AbsoluteTime[] - ts],
          "Pass" -> ok, "Line" -> If[line === {}, "NO RESULT LINE", Last[line]]|>];
        Print["R31 end ", it[[2]], "  pass ", ok, "  ", Round[AbsoluteTime[] - ts], " s  ", DateString[]], {it, items}];
      allOk = rows31 =!= {} && AllTrue[rows31, TrueQ[#["Pass"]] &];
      If[rows31 === {}, Print["R3.1 SUBTRACTION REGRESSION: no target selected (TARGETS=", sel, ") -- NOT_GREEN"]];
      report = StringJoin["MB_standard R3.1 Subtraction regression report  ", DateString[], "\n",
        "every target in a fresh kernel through run_target.wls, one at a time; every piece recomputed\n",
        StringRiffle[Table[StringJoin[StringPadRight[r["MB"] <> " (" <> r["Kind"] <> ")", 18], "  range ", ToString[r["Range"]],
          "  seconds ", ToString[r["Seconds"]], "  pass ", ToString[r["Pass"]]], {r, rows31}], "\n"],
        "\ntotal wall ", ToString[Round[AbsoluteTime[] - t0]], " s\n",
        "REGRESSION_RESULT=", If[allOk, "ALL_GREEN", "NOT_GREEN"], "\n"];
      Export[FileNameJoin[{here, "regression_report.txt"}], report, "Text"];
      Print[report];
      Exit[If[allOk, 0, 3]]]];
  (* ---- release R3 (29 September 2026): on the Subtraction route the regression also runs the general multifold handler on
     the differential families of the solved inclusive targets (MB13 = MB13u, MB8 = MB8au + MB8bu, MB14 = MB14au + MB14bu),
     eps^-7..eps^-3 against MB13Val/MB8Val/MB14Val, as separate kernels through run_multifold_family.wls (records under
     .cache/multifold_family/, tag "regression"); MULTIFOLD=0 skips them, MULTIFOLD_WORKERS sets their piece workers (default: the resource policy split over the families),
     MULTIFOLD_HELPERS the number of helper processes that close the families from other residue orders (default 6),
     MULTIFOLD_FAMILIES a selection of the families (default MB13,MB8,MB14),
     MULTIFOLD_SECONDS the closing budget per term (14400 s). *)
  (* The family runs with their helpers are started first (they are the long part, and an open item shows early).  While
     they run, this kernel closes the LIGHT targets of the public route (one-fold towers on one or two subkernels); the
     targets named in PUBLIC_AFTER (default MB4 and MB7: the cube pieces of MB4 take 35 subkernels and the integrator's
     threads, and the piece workers of MB7's two-contour residue start well over a hundred integrator processes for
     ten minutes) run AFTER the families.  (All started together on 2 October they overloaded the node: load 195 on 128 cores, MB4 took
     11968 s instead of 4272 s, and time limits of the piece closers fired in the families.) *)
  mfQ = $MBSerialRoute === "Subtraction" && Environment["MULTIFOLD"] =!= "0";
  (* ten kernels run at once: a launcher that finds no free subkernel must not start process workers (main kernels) beyond
     the main-kernel budget; with this flag it starts them only within that budget and otherwise closes in the kernel *)
  If[mfQ, Global`$mbtNestedInWorker = True];
  If[mfQ,
      (* MULTIFOLD_FAMILIES: a comma-separated selection of MB13, MB8, MB14 (default: all three) *)
      With[{sel = Environment["MULTIFOLD_FAMILIES"]}, If[StringQ[sel] && sel =!= "", fams = Select[fams, MemberQ[StringTrim /@ StringSplit[sel, ","], #[[1]]] &]]];
      kernel = FileNameJoin[{$InstallationDirectory, "Executables", "WolframKernel"}];
      If[!FileExistsQ[kernel], kernel = First[$CommandLine]];
      (* helpers (1 October 2026): the handler closes the residues of a family one after another, so a pool of piece workers
         is busy only inside piece-heavy residues.  Further processes of the same driver on single member families, with the
         residue list in another order, close each family from other ends into the shared piece and term caches
         (.cache/multifold_close/); the main runs serve those items from the cache.  Every value comes from the same closers
         with the same gates; the records and the exact comparison are the main runs'.  MULTIFOLD_HELPERS = number of
         helper processes (default 6, 0 = none). *)
      nh = Environment["MULTIFOLD_HELPERS"]; nh = If[StringQ[nh] && IntegerQ[ToExpression[nh]], Max[ToExpression[nh], 0], 6];
      (* {family, residue order, item order}.  MB8bu is listed three times with the same residue order and three item
         orders: its residue 21 has six heavy items (four pure-Gamma three-folds closed by the generalized-lemma rewrite,
         two polygamma three-folds), about an hour each, and the three processes close them from different ends.
         A helper is given BOTH member families of its group, the second-listed one after the first, so that it keeps
         working (and sharing by claims) until the whole group is closed: with single-family helpers MB8au was left to the
         main run alone and set the wall time. *)
      helperPlan = Take[Select[{{"MB14bu MB14au", "asc", "asc"}, {"MB8bu MB8au", "asc", "asc"}, {"MB14au MB14bu", "desc", "asc"}, {"MB8bu MB8au", "asc", "desc"},
          {"MB14bu MB14au", "desc", "asc"}, {"MB8bu MB8au", "asc", "mid"}, {"MB8au MB8bu", "desc", "asc"}, {"MB13u", "desc", "asc"}, {"MB14bu MB14au", "mid", "asc"},
          {"MB14au MB14bu", "mid", "asc"}, {"MB8au MB8bu", "mid", "asc"}},
          Function[h, AnyTrue[fams, StringStartsQ[h[[1]], #[[1]] <> "u"] || StringStartsQ[h[[1]], #[[1]] <> "au"] || StringStartsQ[h[[1]], #[[1]] <> "bu"] &]]], UpTo[nh]];
      (* MULTIFOLD_WORKERS: default = the resource policy's dynamic subkernel budget split evenly over ALL processes started
         here (the family runs and their helpers): with work sharing by claims every process closes items of its own, so
         the budget is shared by processes that are busy, not by pools that wait (1 October 2026, user: "use enough
         workers so that the total evaluation time is substantially small"); at least 8 *)
      w = Environment["MULTIFOLD_WORKERS"];
      If[!StringQ[w] || ToExpression[w] === $Failed,
        w = ToString[Max[8, Floor[(If[DownValues[Global`mbtSubkernelCapDynamic] =!= {}, Global`mbtSubkernelCapDynamic[], 24] - 2)/Max[1, Length[fams] + Length[helperPlan]]]]]];
      sec = Environment["MULTIFOLD_SECONDS"]; If[!StringQ[sec] || ToExpression[sec] === $Failed, sec = "14400"];   (* closing budget per term *)
      recDir = FileNameJoin[{cacheDir, "multifold_family"}]; Quiet@CreateDirectory[recDir, CreateIntermediateDirectories -> True];
      Print["MULTIFOLD START  ", fams[[All, 1]], "  eps^-7..eps^-3 through run_multifold_family.wls, ", w, " piece workers each, ", sec, " s per term, in parallel  ", DateString[]];
      Print["MULTIFOLD HELPERS  ", Length[helperPlan], " helper process(es) ", helperPlan, " (same driver, another residue or item order, shared caches)"];
      t1 = AbsoluteTime[];
      procs = Table[StartProcess[{"bash", "-c", StringJoin["exec '", kernel, "' -noinit -noprompt -script '", FileNameJoin[{here, "run_multifold_family.wls"}],
          "' ", f[[2]], " tag=regression workers=", w, " seconds=", sec, " > '", FileNameJoin[{recDir, "regression_" <> f[[2]] <> ".log"}], "' 2>&1"]}], {f, fams}];
      helpers = Table[With[{h = helperPlan[[i]]}, StartProcess[{"bash", "-c", StringJoin["exec '", kernel, "' -noinit -noprompt -script '", FileNameJoin[{here, "run_multifold_family.wls"}],
          "' ", h[[1]], " tag=helper", ToString[i], "_", h[[2]], "_", h[[3]], " order=", h[[2]], " items=", h[[3]], " compare=0 workers=", w, " seconds=", sec, " > '",
          FileNameJoin[{recDir, "helper" <> ToString[i] <> "_" <> h[[2]] <> "_" <> h[[3]] <> "_" <> StringReplace[h[[1]], " " -> "+"] <> ".log"}], "' 2>&1"]}]], {i, Length[helperPlan]}];
      tEnd = ConstantArray[None, Length[procs]];
      (* the light public targets, closed by this kernel while the families run *)
      names = mbSerialRouteTargetNames[];
      after = With[{e = Environment["PUBLIC_AFTER"]}, If[StringQ[e], StringTrim /@ StringSplit[e, ","], {"MB4", "MB7"}]];
      light = Select[names, ! MemberQ[after, #] &];
      tPub = AbsoluteTime[];
      Do[recs[nm] = MBSerialRunOne[nm]; Do[If[tEnd[[i]] === None && ProcessStatus[procs[[i]]] =!= "Running", tEnd[[i]] = AbsoluteTime[]], {i, Length[procs]}], {nm, light}];
      tLight = AbsoluteTime[] - tPub;
      Print["PUBLIC ROUTE TARGETS ", light, " done after ", Round[tLight], " s (next to the family runs)  ", DateString[]];
      While[AnyTrue[procs, ProcessStatus[#] === "Running" &],
        Do[If[tEnd[[i]] === None && ProcessStatus[procs[[i]]] =!= "Running", tEnd[[i]] = AbsoluteTime[]], {i, Length[procs]}]; Pause[30]];
      Do[If[tEnd[[i]] === None, tEnd[[i]] = AbsoluteTime[]], {i, Length[procs]}];
      (* the main runs are complete: every item is in the term cache, a helper still running finishes from the cache *)
      t2 = AbsoluteTime[];
      While[AnyTrue[helpers, ProcessStatus[#] === "Running" &] && AbsoluteTime[] - t2 < 1200, Pause[10]];
      Do[If[ProcessStatus[p] === "Running", KillProcess[p]], {p, helpers}];
      Do[sumFile = FileNameJoin[{recDir, "regression_" <> fams[[i, 3]] <> "_sum.m"}];
         rec = If[FileExistsQ[sumFile], Quiet@Check[Get[sumFile], $Failed], $Failed];
         AppendTo[mfRows, If[AssociationQ[rec],
           <|"MB" -> fams[[i, 1]], "Range" -> rec["Orders"], "Seconds" -> tEnd[[i]] - t1,
             "Pass" -> TrueQ[rec["AllClosed"]] && TrueQ[rec["Comparison"]["AllMatch"]], "ExactMatch" -> TrueQ[rec["Comparison"]["AllMatch"]],
             "RouteFailure" -> !TrueQ[rec["AllClosed"]], "FailedPieceCount" -> Length[rec["Open"]], "Multifold" -> True|>,
           <|"MB" -> fams[[i, 1]], "Range" -> {-7, -3}, "Seconds" -> tEnd[[i]] - t1, "Pass" -> False, "ExactMatch" -> False,
             "RouteFailure" -> True, "FailedPieceCount" -> -1, "Multifold" -> True|>]];
         Print["MULTIFOLD END  ", fams[[i, 1]], "  pass=", Last[mfRows]["Pass"], "  record=", sumFile], {i, Length[fams]}];
      Print["MULTIFOLD wall ", Round[AbsoluteTime[] - t1], " s  ", DateString[]]];
  tPub = AbsoluteTime[];
  summary = If[mfQ,
    (* the targets left for after the families; then the same summary as MBSerialRunAll (a target without a record fails) *)
    Do[recs[nm] = MBSerialRunOne[nm], {nm, Select[names, MemberQ[after, #] &]}];
    $MBSerialResults = AssociationThread[names, Lookup[recs, #, $Failed] & /@ names]; MBSerialSummary[],
    MBSerialRunAll[]];
  rows = Join[Normal[summary], mfRows];
  Print["PUBLIC ROUTE TARGETS done after ", Round[AbsoluteTime[] - tPub + tLight], " s  ", DateString[]];
  allPass = And @@ (TrueQ[#["Pass"]] & /@ rows);
  report = StringJoin[
    "MB_standard regression report  ", DateString[], "\n",
    "PieceKernels ", ToString[pk], "; every piece recomputed; certified library: none in this release\n",
    StringRiffle[Table[
      StringJoin[StringPadRight[r["MB"] <> If[TrueQ[Lookup[r, "Multifold", False]], " (multifold families)", ""], 26], "  range ", ToString[r["Range"]], "  seconds ", ToString[Round[r["Seconds"]]],
        "  pass ", ToString[r["Pass"]], "  exact-match ", ToString[r["ExactMatch"]],
        "  route-failure ", ToString[r["RouteFailure"]], "  failed-pieces ", ToString[r["FailedPieceCount"]]], {r, rows}], "\n"],
    "\ntotal wall ", ToString[Round[AbsoluteTime[] - t0]], " s\n",
    "REGRESSION_RESULT=", If[allPass, "ALL_GREEN", "NOT_GREEN"], "\n"];
  Export[FileNameJoin[{here, "regression_report.txt"}], report, "Text"];
  Print[report];
];
