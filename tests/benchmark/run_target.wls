#!/usr/bin/env wolframscript
(* AUTHORSHIP (release R3.1, 2026-10-04): MB2MPL regression helper.  Authors of MB2MPL: Taushif Ahmed, Sumit Banik,
   Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* run_target.wls -- ONE target of the release on the SUBTRACTION route in this fresh kernel, every piece recomputed
   (disk cache off, no checkpoint resume), through the public calls:
     KIND=inc   an inclusive target of the ledger:   MBSerialRunOne[NAME, LO, HI]   (benchmark of mb_targets_all.m)
     KIND=u     a u-dependent family:                MBSubtractionRunU[NAME, LO, HI] (compared with the release's
                Standard records mbu_results.m and with the Subtraction records mbu_subtraction_records.m at
                u = 1/5, 1/3, 3/7, 4/5, 35-digit numerics; exact equality where the difference is the exact zero)
   Environment: KIND, NAME, LO, HI; optional PK (piece kernels of an inclusive target; default Automatic = the resource
   policy), NATIVE_WORKERS (native integrator processes of the u ladder; default 16), HELPERS (residue helper processes;
   default 15), MAINBUDGET (main kernels of the resource policy; default 16), OUT (record directory; default
   .cache/regression_targets), VERBOSE (1 = route log), CMP_SECONDS (time limit of one numeric comparison; default 1800),
   CMP_KERNELS (subkernels for the numeric comparisons of a u family; default 16, 0 or 1 = in this kernel), RAW_FROM (a
   u family only: the path of a saved NAME_LO_HI_raw.m; its record is compared again instead of being recomputed).
   The run-time stores under .cache must be set aside before a regression (run_regression.wls does it).
   Start it as   KIND=u NAME=MB6u LO=-5 HI=1 WolframKernel -noinit -noprompt -script run_target.wls   (never pass a script
   path as an argument to another script).  The last line is "TARGET_RESULT ...". *)
Module[{here, kind = Environment["KIND"], name = Environment["NAME"], lo = Quiet@ToExpression[Environment["LO"]],
    hi = Quiet@ToExpression[Environment["HI"]], out = Environment["OUT"], pk, nw, h, b, cmpSec, t0, rec, sec, run, raw,
    pass, std, sub, cmp, rowsStd = {}, rowsSub = {}, covered, cmpK, rawFrom = Environment["RAW_FROM"], saved, cmpEval,
    points = {1/5, 1/3, 3/7, 4/5}, refs, need, exprs, vals, value},
  here = DirectoryName[ExpandFileName[If[StringQ[$InputFileName] && $InputFileName =!= "", $InputFileName, First[$ScriptCommandLine]]]];
  If[here === "", here = Directory[]];
  SetDirectory[here];
  If[! MemberQ[{"inc", "u"}, kind] || ! StringQ[name] || ! IntegerQ[lo] || ! IntegerQ[hi],
    Print["run_target.wls: need KIND (inc|u), NAME, LO, HI"]; Exit[1]];
  If[! StringQ[out] || out === "", out = FileNameJoin[{With[{e = Environment["MBANALYTICA_CACHE"]}, If[StringQ[e] && e =!= "", e,
    FileNameJoin[{$UserBaseDirectory, "ApplicationData", "MBAnalytica"}]]], "regression_targets"}]];
  Quiet@CreateDirectory[out, CreateIntermediateDirectories -> True];
  pk = Quiet@ToExpression[Environment["PK"]]; If[! IntegerQ[pk], pk = Automatic];
  nw = Quiet@ToExpression[Environment["NATIVE_WORKERS"]]; If[! IntegerQ[nw] || nw < 1, nw = 16];
  h = Quiet@ToExpression[Environment["HELPERS"]]; If[! IntegerQ[h] || h < 0, h = 15];
  b = Quiet@ToExpression[Environment["MAINBUDGET"]]; If[! IntegerQ[b] || b < 1, b = 16];
  cmpSec = Quiet@ToExpression[Environment["CMP_SECONDS"]]; If[! IntegerQ[cmpSec] || cmpSec < 1, cmpSec = 1800];
  cmpK = Quiet@ToExpression[Environment["CMP_KERNELS"]]; If[! IntegerQ[cmpK] || cmpK < 0, cmpK = 16];
  $MBSerialPieceKernels = pk; $MBSerialWorkerMode = "Subkernels"; $MBSerialDiskCache = False; $MBSerialResume = False;
  (* ROUTE=Standard runs the same target on the Standard route (MBAnalytica: both pages of the benchmark status) *)
  $MBSerialOrderMode = "SealedStandard"; $MBSerialVerbose = Environment["VERBOSE"] =!= "0";
  $MBSerialRoute = If[Environment["ROUTE"] === "Standard", "Standard", "Subtraction"];
  (* a launcher that finds no free subkernel must not start process workers beyond the main-kernel budget *)
  Global`$mbtNestedInWorker = True; Global`$mbtMainKernelBudget = b; Global`$oftResidueHelpers = h;
  Global`$orsVerbose = True;
  MBParameterSubtractionHF`$PSHNativeWorkers = nw;
  Get[FileNameJoin[{here, "MB2MPL_StandardRoute.wl"}]];
  MBtoMPL`Private`$mbtUseMB2MPLDiskCache = False;
  Print["TARGET ", kind, " ", name, " eps^", lo, "..eps^", hi, "  ", $MBSerialRoute, " route  piece kernels ", pk, "  native workers ", nw,
    "  helpers ", h, "  main-kernel budget ", b, "  ", DateString[]];
  t0 = AbsoluteTime[];
  If[kind === "inc",
    (* ---- an inclusive target: the ledger row decides the construction (own integral, SubtractionKernels or
       SubtractionFamilies); the record carries the exact comparison with the benchmark ---- *)
    rec = MBSerialRunOne[name, lo, hi]; sec = Round[AbsoluteTime[] - t0];
    Block[{$Context = "zzWrite`", $ContextPath = {"System`"}}, Put[rec, FileNameJoin[{out, name <> "_" <> ToString[lo] <> "_" <> ToString[hi] <> ".m"}]]];
    Print["TARGET_RESULT inc ", name, "  range ", {lo, hi}, "  seconds ", sec,
      "  pass ", If[AssociationQ[rec], rec["Pass"], False],
      "  exact-match ", If[AssociationQ[rec], Lookup[rec, "ExactMatchAllBenchmarked", "?"], "-"],
      "  failed-pieces ", If[AssociationQ[rec], rec["FailedPieceCount"], "-"], "  ", DateString[]];
    Exit[0]];
  (* ---- a u-dependent family ---- *)
  Clear[Global`u];
  If[StringQ[rawFrom] && rawFrom =!= "" && FileExistsQ[rawFrom],
    (* a saved record compared again (no computation) *)
    saved = Get[rawFrom]; rec = saved["Record"]; run = saved["Run"]; sec = saved["Seconds"];
    raw = If[AssociationQ[rec], rec["Result"], rec];
    Print["TARGET_RAW_FROM ", rawFrom],
    rec = If[$MBSerialRoute === "Standard", MBStandardRunU[name, lo, hi], MBSubtractionRunU[name, lo, hi]]; sec = Round[AbsoluteTime[] - t0];
    raw = If[AssociationQ[rec], rec["Result"], rec]; run = MBParameter`$LastParameterRun;
    (* written with full contexts: read back after the loader, a bare u, G or regulator would resolve to a package context *)
    Block[{$Context = "zzWrite`", $ContextPath = {"System`"}},
      Put[<|"Record" -> rec, "Run" -> run, "Seconds" -> sec|>, FileNameJoin[{out, name <> "_" <> ToString[lo] <> "_" <> ToString[hi] <> "_raw.m"}]]]];
  Print["TARGET_RAW_SAVED ", name, " seconds ", sec, "  exact ", If[AssociationQ[rec], rec["Exact"], "-"],
    "  failed ", If[AssociationQ[rec], rec["FailedPieceCount"], "-"], "  route ", Lookup[If[AssociationQ[run], run, <||>], "Route", "-"]];
  If[AssociationQ[rec] && FailureQ[raw], Print["TARGET_FAILURE ", name, " ", InputForm[Short[raw, 6]]]];
  (* the numeric values of a list of exact expressions (u already substituted), each with the route's evaluator and its
     time limit, on CMP_KERNELS subkernels that load the release as this kernel did (one value per expression, in order;
     the same evaluations as one after another in this kernel, which is the fallback) *)
  cmpEval[es_List] := Module[{ks = Kernels[], own = {}, ok, fresh = False},
    If[cmpK >= 2 && Length[es] >= 2,
      (* kernels this call launches load the release; kernels already running are used only if they have the evaluator
         (a second load of the packages is never made: HypExp refuses one) *)
      If[ks === {}, Quiet[LaunchKernels[Min[cmpK, Length[es]]]]; own = Kernels[]; ks = own; fresh = True];
      If[ks =!= {},
        ok = With[{d = here, f = fresh}, Quiet@ParallelEvaluate[Off[General::shdw]; SetDirectory[d];
            If[f, Global`$mbtNestedInWorker = True; Global`$oftResidueHelpers = 0;
              Block[{$Output = {}}, Quiet@Get[FileNameJoin[{d, "MB2MPL_StandardRoute.wl"}]]]];
            Length[DownValues[MBParameter`Private`parameterNumericValue]] > 0, ks, DistributedContexts -> None]];
        If[! (ListQ[ok] && Length[ok] === Length[ks] && AllTrue[ok, TrueQ]), If[own =!= {}, Quiet@CloseKernels[own]]; own = {}; ks = {}]],
      ks = {}];
    Print["   numeric comparison: ", Length[es], " values on ", Max[1, Length[ks]], " kernel(s)  ", DateString[]];
    With[{vs = If[ks =!= {},
        With[{s = cmpSec}, ParallelMap[MBParameter`Private`parameterNumericValue[#, s] &, es, Method -> "FinestGrained", DistributedContexts -> None]],
        MBParameter`Private`parameterNumericValue[#, cmpSec] & /@ es]},
      If[own =!= {}, Quiet@CloseKernels[own]]; vs]];
  pass = False;
  If[AssociationQ[rec] && TrueQ[rec["Exact"]] && rec["FailedPieceCount"] === 0 && ! FailureQ[raw],
    std = Block[{$ContextPath = $ContextPath}, Quiet@Get[FileNameJoin[{ParentDirectory[here], "reference", "mbu_results.m"}]]; Global`MBuResults];
    sub = Block[{$ContextPath = $ContextPath}, Quiet@Get[FileNameJoin[{ParentDirectory[here], "reference", "mbu_subtraction_records.m"}]]];
    refs = Select[{{"Standard records (mbu_results.m)", If[AssociationQ[std], Lookup[std, name, None], None]},
        {"Subtraction records (mbu_subtraction_records.m)", If[AssociationQ[sub], Lookup[sub, name, None], None]}}, AssociationQ[#[[2]]] &];
    (* per reference and order: exact zero difference, or the orders that need numbers *)
    need = Association[Table[r[[1]] -> Association[Table[k -> (Expand[Coefficient[raw, mbSerialEpsilon, k] -
          (r[[2]]["Coefficients"][k] /. r[[2]]["Parameter"] -> Global`u)] =!= 0), {k, Select[Keys[r[[2]]["Coefficients"]], lo <= # <= hi &]}]], {r, refs}]];
    (* every value needed: the candidate once per order and point, each reference per order and point *)
    exprs = DeleteDuplicates[Join[
      Flatten[Table[{"cand", k, p}, {k, Union @@ (Keys[Select[#, TrueQ]] & /@ Values[need])}, {p, points}], 1],
      Flatten[Table[{r[[1]], k, p}, {r, refs}, {k, Keys[Select[need[r[[1]]], TrueQ]]}, {p, points}], 2]]];
    vals = AssociationThread[exprs, cmpEval[(If[#[[1]] === "cand", Coefficient[raw, mbSerialEpsilon, #[[2]]],
          With[{r = SelectFirst[refs, Function[x, x[[1]] === #[[1]]]][[2]]}, r["Coefficients"][#[[2]]] /. r["Parameter"] -> Global`u]] /.
          Global`u -> #[[3]]) & /@ exprs]];
    cmp[tag_] := Module[{rows = Table[k -> If[! need[tag][k], 0, Max[Table[Module[{x = vals[{"cand", k, p}], y = vals[{tag, k, p}]},
            If[NumericQ[x] && NumericQ[y] && Min[Precision[x], Precision[y]] >= 25, N[Abs[x - y]/Max[1, Abs[x], Abs[y]]],
              Print["   no number: order ", k, " u=", p, " candidate ", NumericQ[x], " reference ", NumericQ[y]]; Infinity]], {p, points}]]],
          {k, Keys[need[tag]]}]},
      Print["TARGET_CMP ", name, " vs ", tag, ": ", InputForm[N[rows, 3]]]; rows];
    If[KeyExistsQ[need, "Standard records (mbu_results.m)"], rowsStd = cmp["Standard records (mbu_results.m)"]];
    If[KeyExistsQ[need, "Subtraction records (mbu_subtraction_records.m)"], rowsSub = cmp["Subtraction records (mbu_subtraction_records.m)"]];
    covered = Union[Keys[rowsStd], Keys[rowsSub]];
    (* pass: exact, nothing failed, every order of the range compared, every compared difference below 10^-20 *)
    pass = covered === Range[lo, hi] && AllTrue[Join[Values[rowsStd], Values[rowsSub]], # < 10^-20 &] &&
      MBParameter`Private`exactQ[raw, {Global`u, mbSerialEpsilon}]];
  covered = Union[Keys[rowsStd], Keys[rowsSub]];
  Block[{$Context = "zzWrite`", $ContextPath = {"System`"}},
    Put[<|"Family" -> name, "Range" -> {lo, hi}, "Seconds" -> sec, "Pass" -> pass, "Standard" -> rowsStd, "Subtraction" -> rowsSub,
      "OrdersCompared" -> covered, "OrdersUncompared" -> Complement[Range[lo, hi], covered]|>,
      FileNameJoin[{out, name <> "_" <> ToString[lo] <> "_" <> ToString[hi] <> "_cmp.m"}]]];
  Print["TARGET_RESULT u ", name, "  range ", {lo, hi}, "  seconds ", sec, "  pass ", pass, "  compared ", covered,
    "  uncompared ", Complement[Range[lo, hi], covered], "  ", DateString[]];
  Exit[0]];
