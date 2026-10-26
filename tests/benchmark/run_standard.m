(* AUTHORSHIP (release R2, 2026-09-07): MBSymbolicInt Standard-route cluster script. Authors of MBSymbolicInt: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* run_standard.m -- the MBSymbolicInt Standard route from the command line, for a cluster (no front end).
   Run from anywhere:   math -script /path/to/MB_standard/run_standard.m        (or: wolframscript -file ...)
   Everything is set through environment variables (all optional):
     TARGETS        comma-separated benchmark targets, or "all" (default): MB1 ... MB14 (MB8 = MB8a + MB8b, MB14 = MB14a + MB14b),
                    MBpilot12, MBpilot13
     ORDERS         "min,max": the epsilon range for every target (default: each target's verified range)
     WORKERS        maximum number of piece workers (default Automatic = the resource policy: half of a large licence's
                    subkernels, all of a small one, never more than the cores, shared with your running jobs); the
                    launcher starts the smaller of this, the licence's allowance, the cores, the remaining budget and
                    the piece count, and prints the number; 0 = strictly serial (far slower)
     WORKER_MODE    "Subkernels" (default: parallel subkernels of this kernel) or "Processes" (separate math kernels,
                    one main-kernel licence seat each; math must be on the PATH)
     CACHE          1 (default) reuses exact Barnes reductions and pieces cached under .cache/; 0 recomputes everything
     RESUME         1 (default) returns a target from its verified checkpoint of an identical code state; 0 recomputes
     INTEGRAND_FILE a .m file that assigns Global`integrand (a Mellin-Barnes integrand written as in mb_targets_all.m,
                    regulator \[Epsilon]); with ORDERS it is evaluated instead of the targets (MBStandardEvaluate)
     REPORT         report file (default run_standard_report.txt in the release directory)
     ROUTE          "Standard" (default) or "Subtraction": the Subtraction route with the one-fold tower-closure and
                    faithful-cube rungs, e.g. TARGETS=MB1,MB2,MB7,MB4 ORDERS=... ROUTE=Subtraction
   Every served coefficient is exact; the per-order report shows the exact coefficient, its physical real part, the
   benchmark where one exists and the exact-match verdict.  The last line is RUN_STANDARD_RESULT=ALL_GREEN or NOT_GREEN. *)
Module[{here, env, orders, workers, mode, cacheQ, resumeQ, intFile, reportFile, t0, rows = {}, allPass = True, report, names},
  here = DirectoryName[ExpandFileName[If[StringQ[$InputFileName] && $InputFileName =!= "", $InputFileName, First[$ScriptCommandLine]]]];
  If[here === "", here = Directory[]];
  SetDirectory[here];
  env[k_, d_] := With[{v = Environment[k]}, If[StringQ[v] && StringTrim[v] =!= "", StringTrim[v], d]];
  (* WORKERS default (2026-09-08): Automatic = the resource policy (half of a large licence's subkernels, all of a
     small one, never more than the cores, shared with this user's running jobs) *)
  workers = ToExpression[env["WORKERS", "Automatic"]]; If[! (IntegerQ[workers] && workers >= 0), workers = Automatic];
  mode = If[env["WORKER_MODE", "Subkernels"] === "Processes", "Processes", "Subkernels"];
  cacheQ = env["CACHE", "1"] =!= "0"; resumeQ = env["RESUME", "1"] =!= "0";
  intFile = env["INTEGRAND_FILE", ""]; reportFile = env["REPORT", FileNameJoin[{here, "run_standard_report.txt"}]];
  orders = Quiet@Check[ToExpression /@ StringSplit[env["ORDERS", ""], ","], {}]; If[! (ListQ[orders] && Length[orders] == 2 && AllTrue[orders, IntegerQ]), orders = None];
  $MBSerialPieceKernels = workers; $MBSerialWorkerMode = mode; $MBSerialDiskCache = cacheQ; $MBSerialResume = resumeQ;
  $MBSerialOrderMode = "SealedStandard";
  (* ROUTE: "Standard" (default) or "Subtraction" (the one-fold tower-closure and faithful-cube rungs) *)
  $MBSerialRoute = If[ToLowerCase[env["ROUTE", "Standard"]] === "subtraction", "Subtraction", "Standard"];
  Get[FileNameJoin[{here, "MBSymbolicInt_StandardRoute.wl"}]];
  MBAnalytica`SymbolicInt`Private`$mbtUseMBSymbolicIntDiskCache = cacheQ;
  Print["run_standard: ", DateString[], "  route ", $MBSerialRoute, "  workers (maximum) ", workers, "  mode ", mode, "  cache ", cacheQ, "  resume ", resumeQ,
    "  licence: ", $MaxLicenseSubprocesses, " subkernels / ", $MaxLicenseProcesses, " main kernels; cores ", $ProcessorCount];
  t0 = AbsoluteTime[];
  If[intFile =!= "",
    (* a user's own integrand *)
    If[! FileExistsQ[intFile], Print["INTEGRAND_FILE not found: ", intFile]; Print["RUN_STANDARD_RESULT=NOT_GREEN"]; Quit[]];
    If[orders === None, Print["ORDERS=min,max is required with INTEGRAND_FILE"]; Print["RUN_STANDARD_RESULT=NOT_GREEN"]; Quit[]];
    Get[intFile];
    Module[{res = MBStandardEvaluate[Global`integrand, orders[[1]], orders[[2]]], ok},
      ok = AssociationQ[res] && TrueQ[Lookup[res, "Exact", False]] && Lookup[res, "FailedPieceCount", 1] === 0;
      allPass = ok;
      report = StringJoin["run_standard report  ", DateString[], "\nintegrand file ", intFile, "  orders ", ToString[orders], "\n",
        ToString[res, InputForm], "\ntotal wall ", ToString[Round[AbsoluteTime[] - t0]], " s\nRUN_STANDARD_RESULT=", If[ok, "ALL_GREEN", "NOT_GREEN"], "\n"]],
    names = If[ToLowerCase[env["TARGETS", "all"]] === "all", Lookup[mbSerialTargets, "Name"], StringTrim /@ StringSplit[env["TARGETS", "all"], ","]];
    Do[Module[{rec},
       rec = If[! MemberQ[Lookup[mbSerialTargets, "Name"], name], Print["unknown target ", name, " (see TARGETS in the header)"]; $Failed,
         If[orders === None, MBSerialRunOne[name], MBSerialRunOne[name, orders[[1]], orders[[2]]]]];
       If[AssociationQ[rec],
         AppendTo[rows, rec];
         If[! TrueQ[rec["Pass"]], allPass = False];
         Print["  per-order comparison of ", name, ":"];
         Do[Print["    eps^", c["EpsilonOrder"], "  exact ", If[TrueQ[c["AnalyticPass"]], "yes", "NO"],
              If[TrueQ[Lookup[c, "BenchmarkAvailable", False]], "  benchmark match " <> ToString[Lookup[c, "ExactMatch", Missing[]]], "  (no benchmark)"],
              "  physical ", ToString[Lookup[c, "CandidatePhysical", Missing[]]]], {c, Lookup[rec, "Comparisons", {}]}],
         Print[name, ": no result (unknown target or route failure)"]; allPass = False]], {name, names}];
    report = StringJoin["run_standard report  ", DateString[], "\nroute ", $MBSerialRoute, "  workers (maximum) ", ToString[workers], "  mode ", mode, "  cache ", ToString[cacheQ], "  resume ", ToString[resumeQ], "\n",
      StringRiffle[Table[StringJoin[StringPadRight[r["MB"], 10], "  range ", ToString[{r["OrderMin"], r["OrderMax"]}], "  seconds ", ToString[Round[r["Seconds"]]],
        "  pass ", ToString[r["Pass"]], "  exact-match ", ToString[Lookup[r, "ExactMatchAllBenchmarked", Missing[]]],
        "  route-failure ", ToString[r["RouteFailure"]], "  failed-pieces ", ToString[r["FailedPieceCount"]]], {r, rows}], "\n"],
      "\ntotal wall ", ToString[Round[AbsoluteTime[] - t0]], " s\nRUN_STANDARD_RESULT=", If[allPass && rows =!= {}, "ALL_GREEN", "NOT_GREEN"], "\n"]];
  Export[reportFile, report, "Text"];
  Print[report];
];
