#!/usr/bin/env wolframscript
(* AUTHORSHIP (release R3, 2026-09-29): MB2MPL, the general multifold handler on a differential family.
   Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* The general multifold handler of the Subtraction route (mbeMultifoldHandler.m) on the differential families of an
   inclusive target: every family of mb_u_targets.m is resolved (mbeParameterResidueRung.m), its residues are u-integrated
   at the MB level, closed by the stabilized finite-eps Barnes chains, the gated pair census and the closing chain, the eta
   step is added, the families are summed and the sum is compared EXACTLY with the inclusive benchmark of mb_targets_all.m
   (benchmark values enter only the comparison).
   Usage:  wolframscript -file run_multifold_family.wls MB13u
           wolframscript -file run_multifold_family.wls MB8au MB8bu            (or the group name MB8u)
           wolframscript -file run_multifold_family.wls MB14u target=-3 low=-7 workers=8 seconds=7200 tag=r3
   Options (key=value): target (highest order, default -3), low (lowest compared order, default -7), e0 (decision point,
   default -1/40), seconds (closing budget per term, default 7200), workers (subkernels of the piece closers, default Automatic = the resource policy),
   residues=1,2,.. (a selection; default all), order=asc|desc|mid|rot:k (the order in which the residues are closed, the
   full list kept; default asc), items=asc|desc|mid|rot:k (the order in which the items of a residue are closed; default
   asc), compare=0 (no benchmark comparison: a helper run on one member family), claims=0 (no work sharing between the
   processes of a family; default 1), wait=1 (a helper waits for items another process is closing), state=dir (another
   directory for the run-time caches),
   tag (record prefix, default mfh), xpair=0 (no pairing across residues),
   bench (benchmark symbol; default from the family name, e.g. MB13u -> MB13Val).
   Records: .cache/multifold_family/<tag>_<FAMILY>.m per family, <tag>_<FAMILIES>_sum.m and <tag>_<FAMILIES>_report.txt.
   Exit code 0 = every residue closed and every compared order an exact match, 2 otherwise, 5 = setup refused. *)
$HistoryLength = 0; $MBSerialPieceKernels = 0; $fcuMaxWorkers = 0; $IV$NoLibrary = True; $oftNoSubkernels = True; $fcuNoSubkernels = True;
Quiet@SetSystemOptions["ParallelOptions" -> {"ParallelThreadNumber" -> 1, "MKLThreadNumber" -> 1}];
here = DirectoryName[ExpandFileName[If[StringQ[$InputFileName] && $InputFileName =!= "", $InputFileName, First[$ScriptCommandLine]]]];
If[here === "", here = Directory[]];
SetDirectory[here];
(* the release loader in the MBAnalytica layout (src/MB2MPL): core, rungs, the handler installed in the multi-fold slot *)
Get[FileNameJoin[{ParentDirectory[ParentDirectory[here]], "src", "MB2MPL", "load_standard.m"}]];
args = Join[$ScriptCommandLine, $CommandLine];
opt[k_, d_] := Module[{a = SelectFirst[args, StringStartsQ[#, k <> "="] &]}, If[StringQ[a], StringDrop[a, StringLength[k] + 1], d]];
famArgs = Select[args, StringMatchQ[#, "MB" ~~ __ ~~ "u"] && !StringContainsQ[#, "/"] && !StringContainsQ[#, "="] &];
Tt = ToExpression[opt["target", "-3"]]; low = ToExpression[opt["low", "-7"]];
e0v = ToExpression[opt["e0", "-1/40"]]; secs = ToExpression[opt["seconds", "7200"]];
(* workers: default Automatic = the resource policy (1 October 2026, user: "use all the resources available") -- the
   piece closers of one family take the whole dynamic subkernel budget (budget minus my running subkernels) less a margin
   of two, never fewer than eight; an explicit workers=n keeps that number *)
nW = With[{w = opt["workers", "Automatic"]}, If[w === "Automatic",
   Max[8, If[DownValues[Global`mbtSubkernelCapDynamic] =!= {}, Global`mbtSubkernelCapDynamic[] - 2, 8]], ToExpression[w]]];
resSel = With[{s = opt["residues", "All"]}, If[s === "All", All, ToExpression /@ StringSplit[s, ","]]];
(* order: the order in which the residues of a family are reduced and closed (default asc = 1..N).  desc, mid (from the
   middle, wrapping around) and rot:k (k, .., N, 1, .., k-1) keep the FULL residue list -- the cross-residue pair census and
   the eta step see the same family -- and let several processes of one family work from different ends: the piece and
   term caches under .cache/multifold_close/ are shared, so each process serves what another has closed. *)
ordSel = opt["order", "asc"];
resOrder[n_Integer] := Which[
   resSel =!= All, resSel,
   ordSel === "desc", Reverse[Range[n]],
   ordSel === "mid", RotateLeft[Range[n], Quotient[n, 2]],
   StringStartsQ[ordSel, "rot:"], With[{k = ToExpression[StringDrop[ordSel, 4]]}, If[IntegerQ[k] && 1 <= k <= n, RotateLeft[Range[n], k - 1], All]],
   True, All];
(* items: the order in which the ITEMS of a residue are closed (asc, desc, mid, rot:k; default asc).  Several processes of
   one family with different item orders close a residue with several heavy items in the time of its heaviest item: the
   term cache is shared. *)
Global`$mfhItemOrder = opt["items", "asc"];
doCmp = opt["compare", "1"] === "1";
(* claims (default on): the processes of one family run share the work.  A process claims an item before it closes it; an
   item claimed by another living process is not started twice.  The run that compares (the main run) waits for such
   items, a helper (compare=0) leaves them to their owner and moves on (wait=1 makes a helper wait as well). *)
Global`$mfhItemClaims = opt["claims", "1"] === "1";
Global`$mfhClaimWait = doCmp || opt["wait", "0"] === "1";
(* state: another directory for the run-time caches (pieces, terms, claims), relative to the package or absolute; default
   .cache/multifold_close *)
With[{sd = opt["state", ""]}, If[sd =!= "", Global`$closeStateDir = If[StringStartsQ[sd, "/"] || StringMatchQ[sd, LetterCharacter ~~ ":" ~~ __], sd, FileNameJoin[{here, sd}]];
   Quiet@CreateDirectory[Global`$closeStateDir, CreateIntermediateDirectories -> True]]];
tag = opt["tag", "mfh"];
recDir = If[StringQ[Global`$mfhRecordDir], Global`$mfhRecordDir, FileNameJoin[{here, ".cache", "multifold_family"}]];
Quiet@CreateDirectory[recDir, CreateIntermediateDirectories -> True];

(* the differential families (the data file keeps its symbols in a private context) *)
uData = Block[{$ContextPath = $ContextPath}, Get[FileNameJoin[{here, "mb_u_targets.m"}]]];
fams = DeleteDuplicates[Flatten[Lookup[uData["ComponentGroups"], #, {#}] & /@ famArgs]];
If[fams === {}, Print["MFH_FAMILY_REFUSED no family named (differential families: ", Keys[uData["Targets"]], ")"]; Exit[5]];
If[!AllTrue[fams, KeyExistsQ[uData["Targets"], #] &],
  Print["MFH_FAMILY_REFUSED unknown family ", Select[fams, !KeyExistsQ[uData["Targets"], #] &], "; known: ", Keys[uData["Targets"]]]; Exit[5]];
benchName = opt["bench", StringReplace[First[fams], RegularExpression["[a-d]?u$"] -> ""] <> "Val"];
ep = Global`regEp; uu = Global`regU;   (* the regulator and the parameter as the handler's plain symbols *)
toPlain[f_, vars_List] := f /. {uData["Regulator"] -> ep, uData["Parameter"] -> uu} /. Thread[vars -> (Symbol["Global`" <> SymbolName[#]] & /@ vars)];

(* resolution of a family: the parameter-aware residue enumeration of the release *)
resolveFamily[fam_] := Module[{t = uData["Targets"][fam], f, rr, tt},
  f = toPlain[t["Integrand"], t["MBVariables"]];
  Print["RESOLVE_START ", fam, " (", Length[t["MBVariables"]], "-fold) ", DateString[]];
  tt = AbsoluteTiming[rr = TimeConstrained[MBParameter`Private`parameterResolve[f, ep, 180], 240, $Aborted]];
  If[!MBParameter`Private`parameterResolutionValidQ[rr], Print["RESOLVE_REFUSED ", fam]; Return[$Failed, Module]];
  Print["RESOLVED ", fam, " residues ", Length[rr], " folds ", Length[#[[2, 2]]] & /@ rr, " seconds ", Round[First[tt]]];
  rr];

(* a family run is one of several kernels (the regression starts ten): its piece launcher starts process workers (main
   kernels) only within the main-kernel budget *)
Global`$mbtNestedInWorker = True;
ok = mfhSetup[ep, "E0" -> e0v, "Target" -> Tt, "Low" -> -12, "CloseSeconds" -> secs, "Parameter" -> uu, "ParallelPieces" -> True, "Workers" -> nW];
Print["MFH_FAMILY ", fams, " vs ", benchName, " orders ", low, "..", Tt, " e0 ", e0v, " ready ", ok, " ", DateString[]];
If[!TrueQ[ok], Print["MFH_FAMILY_REFUSED handler not ready"]; Exit[5]];

(* the benchmark: exact coefficients low..target of the inclusive value (comparison data only) *)
Get[FileNameJoin[{here, "mb_targets_all.m"}]]; epsB = ToExpression["\[Epsilon]"]; benchVal = ToExpression[benchName];
If[!FreeQ[benchVal, _Symbol?(SymbolName[#] === benchName &)], Print["MFH_FAMILY_REFUSED no benchmark ", benchName]; Exit[5]];
bench = Association@Table[k -> Coefficient[Normal[Series[benchVal, {epsB, 0, Tt}]], epsB, k], {k, low, Tt}];

total = 0; recs = {};
Do[Module[{rr = resolveFamily[fam], rec},
    If[rr === $Failed, AppendTo[recs, <|"Family" -> fam, "Status" -> "Open", "Open" -> {<|"Residue" -> "resolution", "Reason" -> "resolution refused"|>}, "Laurent" -> 0, "Seconds" -> 0|>]; Continue[]];
    rec = mfhFamily[rr, "Family" -> fam, "Residues" -> resOrder[Length[rr]], "CrossResiduePairs" -> (opt["xpair", "1"] === "1"),
      "Record" -> FileNameJoin[{recDir, tag <> "_" <> fam <> ".m"}]];
    AppendTo[recs, rec]; total += rec["Laurent"];
    Print["MFH_FAMILY ", fam, " status ", rec["Status"], " open ", Length[rec["Open"]], " seconds ", rec["Seconds"]]], {fam, fams}];
total = Expand[total];
cmp = mfhCompare[total, bench];
rows = If[!doCmp, {"comparison skipped (compare=0: a helper run on a member family; the comparison is the main run's)"}, Table[StringJoin["eps^", ToString[r["Order"]], "  route ", ToString[r["Route"]], "  benchmark ", ToString[r["Benchmark"]],
    "  exact difference ", ToString[r["ExactDifference"], InputForm], If[r["Match"], "  EXACT MATCH", "  MISMATCH"]], {r, cmp["Rows"]}]];
allClosed = AllTrue[recs, #["Status"] === "Closed" &];
report = StringJoin["multifold family run  ", DateString[], "\nfamilies ", StringRiffle[fams, " + "], "  benchmark ", benchName,
  "  orders ", ToString[low], "..", ToString[Tt], "  e0 ", ToString[e0v, InputForm], "  workers ", ToString[nW], If[ordSel =!= "asc", "  order " <> ordSel, ""], If[Global`$mfhItemOrder =!= "asc", "  items " <> Global`$mfhItemOrder, ""], "\n",
  StringRiffle[Table[StringJoin[StringPadRight[r["Family"], 8], "  status ", ToString[r["Status"]], "  open ", ToString[Length[r["Open"]]],
      "  seconds ", ToString[r["Seconds"]]], {r, recs}], "\n"], "\n",
  StringRiffle[rows, "\n"], "\n",
  "RESULT=", If[!doCmp, If[allClosed, "CLOSED", "OPEN"], If[allClosed && cmp["AllMatch"], "EXACT", "NOT_EXACT"]], "\n"];
Put[<|"Families" -> fams, "Benchmark" -> benchName, "Orders" -> {low, Tt}, "Total" -> total, "Comparison" -> cmp, "AllClosed" -> allClosed,
  "Open" -> Join @@ (#["Open"] & /@ recs), "Tool" -> "run_multifold_family.wls", "Date" -> DateString["ISODateTime"]|>,
  FileNameJoin[{recDir, tag <> "_" <> StringRiffle[fams, "+"] <> "_sum.m"}]];
Export[FileNameJoin[{recDir, tag <> "_" <> StringRiffle[fams, "+"] <> "_report.txt"}], report, "Text"];
Print[report];
Print["MFH_FAMILY_DONE ", fams, " all residues closed ", allClosed, " benchmark match ", If[doCmp, cmp["AllMatch"], "skipped"], " ", DateString[]];
Quiet@CloseKernels[]; Exit[If[allClosed && (!doCmp || cmp["AllMatch"]), 0, 2]];
