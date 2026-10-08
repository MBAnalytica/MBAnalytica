(* AUTHORSHIP (release R2, 2026-09-07): part of the IntVolFLINT addition to MB2MPL (native unit-chart requests with the divergence certificate, chart race, symbolic kinematics, algebraic-letter rationalisation). Author: Syed Mehedi Hasan; backends: HyperFLINT and HyperIntica (SubTropica; M. Giroux, S. Mizera, G. Salvatori, arXiv:2604.20954), HyperIntica being a native Mathematica reimplementation of E. Panzer's HyperInt (arXiv:1403.3385). *)
(* ivf_machinery.m — IntVolFLINT v1 Mathematica bridge (pilot, 2026-08-29).
   Mirrors hf_machinery.m but drives the IntVolFLINT fork with the NATIVE [0,1] chart and the divergence
   certificate ALWAYS ON.  Requires load_standard_w10 + HyperIntica + hf_machinery.m loaded (parseResp, gvExact,
   gvN, exprStr, constToHF, jsonStr, mzvPath, renameVarsHF are reused).  Nothing here touches the sealed route:
   the dispatcher gets the strategy only through MBEStrategy`Private`$mbeUseIntVolFLINT (default False) once
   WP4 wires mbeIntegrateCube; until then use cubeIVF / ivfExactCube directly. *)
(* ---- v5 word-eval guard (2026-09-01) ----------------------------------------------------------
   The machinery REUSES hf_machinery.m + HyperIntica (parseResp, gvExact, gvN, exprStr, constToHF,
   jsonStr, mzvPath, renameVarsHF, ZeroInfPeriodAsMpl).  In a kernel loaded WITHOUT them (standalone
   drivers) every call silently $Failed's in ~0s ("instant refusal" trap, measured 2026-08-31 on the
   res5 I3 cubes).  Self-load here, per lane: vendor/HyperIntica beside this tree, else the task
   checkouts; hf_machinery.m from the lane root.  Override with Global`$ivfHyperInticaPath. *)
Module[{ivfHere = Quiet@Check[DirectoryName[$InputFileName], ""], hiC, hfC},
  If[DownValues[Global`gvN] === {} || DownValues[Global`exprStr] === {},
    hiC = Select[{If[StringQ[Global`$ivfHyperInticaPath], Global`$ivfHyperInticaPath, "/nonexistent"],
        If[ivfHere =!= "", FileNameJoin[{ParentDirectory[ivfHere], "vendor", "HyperIntica", "HyperIntica.wl"}], "/nonexistent"],
        "/nonexistent"}, FileExistsQ];
    hfC = Select[{If[ivfHere =!= "", FileNameJoin[{ParentDirectory[ivfHere], "hf_machinery.m"}], "/nonexistent"],
        "/nonexistent"}, FileExistsQ];
    If[hiC =!= {} && !MemberQ[$Packages, "HyperIntica`"],
      Quiet@Get[First[hiC]]; HyperIntica`$QuietPrint = True];
    If[hfC =!= {}, Quiet@Check[Get[First[hfC]], Null]];
    If[DownValues[Global`gvN] === {},
      Print["[ivf-machinery v5] WARNING: hf_machinery/HyperIntica unavailable -> word evaluation ",
        "WILL silently refuse; load them or set Global`$ivfHyperInticaPath."],
      Print["[ivf-machinery v5] word-eval guard: self-loaded HyperIntica/hf_machinery"]]]];
$ivfBin = FileNameJoin[{ParentDirectory[DirectoryName[ExpandFileName[$InputFileName]]], "vendor", "IntVolFLINT", "bin", "hyperflint"}];
(* 2026-09-08 resource scaling: the piece-worker launcher exports IVF_THREADS (OMP threads per hyperflint process),
   IVF_RACE_WIDTH (candidate orders raced concurrently per piece) and IVF_SECONDS (per-candidate budget) so that the
   total hyperflint thread count stays near the cores of the machine whatever the number of workers; unset = the
   original values (8 threads for a single call, 4 per race candidate, every candidate at once, 900 s). *)
ivfEnvInteger[name_, default_] := Module[{v = Quiet@ToExpression[Environment[name]]}, If[IntegerQ[v] && v > 0, v, default]];
$ivfSeconds = ivfEnvInteger["IVF_SECONDS", 900];
$ivfThreadsSingle = ivfEnvInteger["IVF_THREADS", 8];
$ivfLastResponse = <||>;

ivfRun[body_, tmo_] := Module[{inF = FileNameJoin[{$TemporaryDirectory, "ivf_in_" <> ToString[$ProcessID] <> ".json"}],
    outF = FileNameJoin[{$TemporaryDirectory, "ivf_out_" <> ToString[$ProcessID] <> ".json"}], r},
  Quiet@DeleteFile[outF]; Export[inF, body, "Text"];
  RunProcess[{"bash", "-c", "ulimit -s unlimited; timeout " <> ToString[tmo] <> " env OMP_NUM_THREADS=" <> ToString[$ivfThreadsSingle] <> " " <>
    $ivfBin <> " eval-json < " <> inF <> " > " <> outF <> " 2>/dev/null"}];
  If[!FileExistsQ[outF] || FileByteCount[outF] === 0, Return[$Failed]];
  r = Quiet@Import[outF, "RawJSON"]; If[!AssociationQ[r], $Failed, r]];

(* cubeIVF[f, vars, order]: integrate the [0,1]^n cube f over vars in the given order (default = vars),
   natively, certificate ON.  Returns parseResp-style <|"ok", "val", "reason", "unit_chart_vars", "sec"|>. *)
(* "Regularized" -> True switches the divergence certificate OFF: the result is then the shuffle-regularized
   finite part (identical to IntVol's regularized value on every production cube probed so far).  Allowed ONLY
   when the caller owns a collective-cancellation guarantee for the cohort (same policy as the dispatcher's
   grouped HF route, mbe_strategy_dispatch_v2.m:482). *)
(* WP4 item 2 (2026-08-29): HyperFLINT's expression parser rejects PolyLog[...] but accepts Hlog[z, {letters}]
   with a rational-function argument; Li_n(z) = -G(0^(n-1), 1; z) = -Hlog[z, {0,...,0,1}]. *)
ivfPolyLogToHlog[e_] := e /. PolyLog[n_Integer?Positive, z_] :> -Global`Hlog[z, Append[ConstantArray[0, n - 1], 1]];
(* SYMBOLIC KINEMATICS (2026-08-30): "Parameters" -> {v12, ...} lists the never-integrated coefficient variables; they are
   passed to HyperFLINT as extra "vars" and the fork's "spectator_algebraic_letters" flag lets Wm/Wp pairs depend on them
   (IntVol's lambda letters).  ivfParametersOf[f, vars] = the free non-constant symbols of f other than vars. *)
ivfParametersOf[f_, vars_List] := DeleteDuplicates@Cases[f, s_Symbol /; !MemberQ[vars, s] && !MemberQ[{Pi, E, EulerGamma, Catalan, I, Glaisher, Khinchin}, s] && Context[s] =!= "System`", {0, Infinity}, Heads -> False];
Options[cubeIVF] = {"Regularized" -> False, "Parameters" -> {}};
cubeIVF[f0_, vars_, order_: Automatic, tmo_: $ivfSeconds, OptionsPattern[]] := Module[
  {f = ivfPolyLogToHlog[f0 /. constToHF], ord = If[order === Automatic, vars, order], req, r, pr, t0 = AbsoluteTime[],
   cert = !TrueQ[OptionValue["Regularized"]], ps = OptionValue["Parameters"]},
  req = <|"op" -> "hyperflint", "expr" -> exprStr[f], "vars_int" -> (SymbolName /@ ord),
    "vars" -> Join[SymbolName /@ vars, SymbolName /@ ps, {"hfEG", "hfPI", "hfZ3", "hfZ5", "hfLOG2"}],
    "vars_int_from" -> ConstantArray["0", Length[ord]], "vars_int_to" -> ConstantArray["1", Length[ord]],
    "mzv_data_path" -> mzvPath, "algebraic_letters" -> True, "canonical_emission" -> True,
    "check_divergences" -> cert, "native_unit_interval" -> True, "spectator_algebraic_letters" -> (ps =!= {})|>;
  r = ivfRun[jsonStr[req], tmo]; $ivfLastResponse = r;
  If[r === $Failed, Return[<|"ok" -> False, "reason" -> "IVF-fail/timeout", "sec" -> Round[AbsoluteTime[] - t0, 0.01]|>]];
  pr = parseResp[r]; pr["sec"] = Round[AbsoluteTime[] - t0, 0.01];
  pr["unit_chart_vars"] = Lookup[r, "unit_chart_vars", {}];
  pr["divergent"] = KeyExistsQ[r, "divergent"]; pr];

(* ---- WP4: order selection (2026-08-29) ----
   ivfAlphabet[f, vars]: the NATIVE [0,1] alphabet = irreducible factors of every denominator and of every Log
   argument's numerator/denominator, plus the boundary polynomials x_i and 1 - x_i (no projective map, no 1 + x_i).
   ivfFindOrder[f, vars]: HyperFLINT's find_lr_orders on that alphabet -> best_order (variable names) or $Failed. *)
ivfAlphabetPolys[f0_, vars_] := Module[{f = f0 /. constToHF, dens, logs, polys},
  dens = Cases[{f}, Power[b_, e_?Negative] :> b, {0, Infinity}];
  dens = Join[dens, {Denominator[Together[f /. Log[_] -> 1]]}];
  logs = Cases[{f}, Log[a_] :> {Numerator[Together[a]], Denominator[Together[a]]}, {0, Infinity}];
  polys = Flatten[{dens, logs, vars, 1 - vars}];
  polys = DeleteDuplicates[Flatten[FactorList[#][[All, 1]] & /@ Select[polys, ! FreeQ[#, Alternatives @@ vars] &]]];
  Select[polys, ! FreeQ[#, Alternatives @@ vars] && ! NumericQ[#] &]];
ivfAlphabet[f0_, vars_] := exprStr /@ ivfAlphabetPolys[f0, vars];
(* ivfFindOrder returns up to TWO candidate orders: the scan's score-minimal order and its carry_discharge
   variant (they differ on real cubes and neither is reliably the faster one); names are mapped back to the
   caller's variable SYMBOLS by SymbolName (renamed variables may live in a non-Global context). *)
ivfFindOrder[f_, vars_, tmo_: 300, ps_List: {}] := Module[{alpha, names, byName, ask, cands},
  alpha = ivfAlphabet[f, vars];
  If[alpha === {}, Return[$Failed]];
  names = SymbolName /@ vars; byName = AssociationThread[names -> vars];
  ask[carry_] := Module[{req, r, ord},
    req = <|"op" -> "find_lr_orders", "polys" -> alpha, "xvars" -> names, "coeff_vars" -> (SymbolName /@ ps),
      "algebraic_letters" -> True, "carry_discharge" -> carry|>;
    r = ivfRun[jsonStr[req], tmo];
    If[r === $Failed || TrueQ[Lookup[r, "nolr", False]], Return[$Failed]];
    ord = Lookup[r, "best_order", {}];
    If[!ListQ[ord] || Length[ord] =!= Length[vars] || !AllTrue[ord, KeyExistsQ[byName, #] &], Return[$Failed]];
    ord = byName /@ ord;
    If[Sort[ord] =!= Sort[vars], $Failed, ord]];
  cands = DeleteDuplicates[Select[{ask[False], ask[True]}, ListQ]];
  If[cands === {}, $Failed, cands]];

(* ---- WP4 parallel order race (2026-08-30) ----
   ivfRaceParallel[f, vars, orders, tmo, reg]: one hyperflint process per candidate order, all started at once;
   the first clean finisher wins, the others are killed.  Wall time ~ the fastest candidate (+ ~1 s overhead)
   instead of the sum of the losers' budgets.  Returns parseResp-style association with "Order" and "sec", or
   <|"ok" -> False|>. *)
$ivfRaceThreads = ivfEnvInteger["IVF_THREADS", 4];   (* OMP threads per candidate process (IVF_THREADS, default 4) *)
$ivfRaceWidth = ivfEnvInteger["IVF_RACE_WIDTH", 0];    (* candidates raced at once; 0 = all (IVF_RACE_WIDTH) *)
(* 2026-09-08: the race is run in batches of at most $ivfRaceWidth candidates (the first clean finisher of a batch
   wins; a batch with no clean finisher is followed by the next); with every candidate at once, 12 workers on
   4-5-variable weight-8 cubes started ~250 hyperflint processes x 4 threads on 128 cores and every candidate then
   ran into its budget. *)
ivfRaceParallel[f0_, vars_, orders_List, tmo_, reg_: False, ps_List: {}] := Module[
  {w, res = <|"ok" -> False, "reason" -> "race-failed"|>},
  w = If[IntegerQ[$ivfRaceWidth] && $ivfRaceWidth > 0, $ivfRaceWidth, Length[orders]];
  If[orders === {}, Return[res]];
  Catch[
    Do[res = ivfRaceParallelBatch[f0, vars, batch, tmo, reg, ps];
       If[AssociationQ[res] && TrueQ[res["ok"]], Throw[res, ivfRaceTag]],
      {batch, Partition[orders, UpTo[Max[1, w]]]}];
    res, ivfRaceTag]];
(* 2026-09-01 16:45: kill a race candidate's WHOLE process group (the candidate is started under setsid, so its bash PID is
   the group id): kill -9 -- -PID reaches bash, timeout and hyperflint; KillProcess alone only killed bash and the
   timeout/hyperflint pair kept computing to its budget (measured 16:36: 178 orphaned candidates, load average 231). *)
ivfKillGroup[pr_] := Module[{pid = Quiet[pr["PID"]]},
  If[IntegerQ[pid], Quiet@RunProcess[{"kill", "-9", "--", "-" <> ToString[pid]}]];
  Quiet@KillProcess[pr]];
ivfRaceParallelBatch[f0_, vars_, orders_List, tmo_, reg_: False, ps_List: {}] := Module[
  {f = ivfPolyLogToHlog[f0 /. constToHF], base, procs = {}, files = {}, t0 = AbsoluteTime[], done = False, result = <|"ok" -> False, "reason" -> "race-failed"|>, k = 0, refusals = {}},
  base = FileNameJoin[{$TemporaryDirectory, "ivf_race_" <> ToString[$ProcessID] <> "_" <> ToString[Round[1000 t0]]}];
  Do[k++;
    Module[{req, inF = base <> "_" <> ToString[k] <> ".in", outF = base <> "_" <> ToString[k] <> ".out", pr},
      req = <|"op" -> "hyperflint", "expr" -> exprStr[f], "vars_int" -> (SymbolName /@ o),
        "vars" -> Join[SymbolName /@ vars, SymbolName /@ ps, {"hfEG", "hfPI", "hfZ3", "hfZ5", "hfLOG2"}],
        "vars_int_from" -> ConstantArray["0", Length[o]], "vars_int_to" -> ConstantArray["1", Length[o]],
        "mzv_data_path" -> mzvPath, "algebraic_letters" -> True, "canonical_emission" -> True,
        "check_divergences" -> !TrueQ[reg], "native_unit_interval" -> True, "spectator_algebraic_letters" -> (ps =!= {})|>;
      Export[inF, jsonStr[req], "Text"];
      (* 2026-09-01 16:45: own process group per candidate (setsid) so that ivfKillGroup can kill bash+timeout+hyperflint;
         KillProcess alone killed only the bash wrapper and left the losers running to their full budget (178 orphans, load 231) *)
      pr = StartProcess[{"setsid", "bash", "-c", "ulimit -s unlimited; timeout " <> ToString[tmo] <> " env OMP_NUM_THREADS=" <> ToString[$ivfRaceThreads] <> " " <>
        $ivfBin <> " eval-json < " <> inF <> " > " <> outF <> ".tmp 2>/dev/null; mv " <> outF <> ".tmp " <> outF}];
      AppendTo[procs, pr]; AppendTo[files, {o, outF}]],
    {o, orders}];
  While[! done && AbsoluteTime[] - t0 < tmo + 5,
    Do[Module[{o = files[[i, 1]], outF = files[[i, 2]], r, pr},
      If[! done && FileExistsQ[outF],
        r = Quiet@Import[outF, "RawJSON"]; Quiet@DeleteFile[outF];
        If[AssociationQ[r],
          pr = parseResp[r];
          If[TrueQ[pr["ok"]],
            pr["Order"] = o; pr["sec"] = Round[AbsoluteTime[] - t0, 0.01]; pr["divergent"] = KeyExistsQ[r, "divergent"];
            result = pr; done = True,
            (* (a) 2026-08-30: keep every refusal (reason + divergence flag) for the dispatcher's cohort tag *)
            AppendTo[refusals, <|"Order" -> o, "reason" -> ToString[Lookup[pr, "reason", ""]],
              "divergent" -> (KeyExistsQ[r, "divergent"] || StringContainsQ[ToString[Lookup[pr, "reason", ""]], "divergent"])|>]]];
        (* a finished-but-failed candidate: mark its slot as consumed *)
        files[[i, 2]] = "";]],
      {i, Length[files]}];
    If[! done && AllTrue[files, #[[2]] === "" &], Break[]];
    If[! done, Pause[0.1]]];   (* 2026-08-30: 0.5 s granularity dominated trivial cubes *)
  Do[ivfKillGroup[pr], {pr, procs}];
  Do[Quiet@DeleteFile[base <> "_" <> ToString[i] <> ".in"]; Quiet@DeleteFile[base <> "_" <> ToString[i] <> ".out"]; Quiet@DeleteFile[base <> "_" <> ToString[i] <> ".out.tmp"], {i, Length[orders]}];
  If[! done, result["refusals"] = refusals; result["divergent"] = AnyTrue[refusals, TrueQ[#["divergent"]] &];
    result["reason"] = If[refusals === {}, "race-timeout", First[refusals]["reason"]]];
  $ivfLastRefusals = refusals;
  result];

(* ivfExactCube[integrand, variables, timeout]: dispatcher-shaped entry (same contract as
   MBEStrategy`Private`mbeHFExactCube): exact value or $Failed; tries the natural order, then the LR order
   reported by HF's scan on the native alphabet (WP4), then the remaining permutations up to $ivfMaxOrders. *)
$ivfMaxOrders = 6;
Options[ivfExactCube] = {"Regularized" -> False, "OrderHint" -> None, "Parameters" -> Automatic};
$ivfLastOrders = {};
ivfExactCube[integrand_, variables_List, timeout_: $ivfSeconds, OptionsPattern[]] := Module[
  {f, vars, orders, pr, val, reg = TrueQ[OptionValue["Regularized"]], lr, hint, rn, ps},
  If[variables === {}, Return[If[NumericQ[Quiet@N[integrand]], integrand, $Failed]]];
  {f, vars} = renameVarsHF[integrand, variables];
  ps = OptionValue["Parameters"]; If[ps === Automatic, ps = ivfParametersOf[f, vars]]; If[!ListQ[ps], ps = {}];
  $ivfLastParameters = ps;
  (* WP4 order ladder (2026-08-29): candidates = LR-scan orders (score-minimal + carry_discharge), the caller's
     hint (e.g. IntVol's stored route), natural, reversed.  They are RACED with an escalating budget: every
     candidate first gets $ivfRaceSeconds; only if none finishes do the survivors get the full timeout.
     Measured on production cubes the spread between orders is 20-50x, so a short first pass wins overall. *)
  lr = Quiet@Check[ivfFindOrder[f, vars, 300, ps], $Failed];
  hint = OptionValue["OrderHint"];
  hint = If[ListQ[hint] && Length[hint] === Length[variables], (renameVarsHF[0, hint][[2]]), None];
  orders = DeleteDuplicates[Join[
    If[ListQ[lr], lr, {}], If[ListQ[hint] && Sort[hint] === Sort[vars], {hint}, {}],
    {vars, Reverse[vars]}]];
  orders = Take[orders, UpTo[$ivfMaxOrders]];
  $ivfLastOrders = orders; $ivfLastWinner = None; $ivfLastRefusals = {};
  If[TrueQ[$ivfParallelRace] && Length[orders] > 1,
    (* parallel race: all candidates at once with the full budget; first clean finisher wins *)
    pr = ivfRaceParallel[f, vars, orders, timeout, reg, ps];
    $ivfLastRace = pr;
    If[TrueQ[pr["ok"]],
      val = gvExact[pr["val"]];
      $ivfLastRace["exact"] = val; $ivfLastRace["numeric"] = ivfNumericCheck[pr["val"], ps];
      If[FreeQ[val, _Real] && NumericQ[$ivfLastRace["numeric"]],
        $ivfLastWinner = <|"Order" -> pr["Order"], "Seconds" -> pr["sec"], "Budget" -> timeout, "Parameters" -> ps|>; Return[val, Module]]];
    Return[$Failed, Module]];
  Catch[
    Do[Do[pr = cubeIVF[f, vars, o, b, "Regularized" -> reg, "Parameters" -> ps];
          If[! TrueQ[pr["ok"]], AppendTo[$ivfLastRefusals, <|"Order" -> o, "reason" -> ToString[Lookup[pr, "reason", ""]],
            "divergent" -> (TrueQ[pr["divergent"]] || StringContainsQ[ToString[Lookup[pr, "reason", ""]], "divergent"])|>]];
          If[TrueQ[pr["ok"]],
            val = gvExact[pr["val"]];
            If[FreeQ[val, _Real] && NumericQ[ivfNumericCheck[pr["val"], ps]],
              $ivfLastWinner = <|"Order" -> o, "Seconds" -> pr["sec"], "Budget" -> b, "Parameters" -> ps|>; Throw[val, "ivfDone"]]],
          {o, orders}],
       {b, DeleteDuplicates[{Min[$ivfRaceSeconds, timeout], timeout}]}];
    $Failed, "ivfDone"]];
$ivfRaceSeconds = 45;
$ivfParallelRace = True;
(* numeric sanity of a served value: constants -> Ginsh; with parameters -> evaluate at $ivfKinematicPoint (default:
   generic rationals) — the value must be a number there *)
$ivfKinematicPoint = Automatic;
$ivfLastParameters = {};
ivfNumericCheck[hfval_, ps_List] := Module[{pt},
  If[ps === {}, Return[Quiet@N[gvN[hfval]]]];
  pt = If[ListQ[$ivfKinematicPoint] && $ivfKinematicPoint =!= {}, $ivfKinematicPoint, Thread[ps -> Table[Rationalize[0.17 + 0.29 k, 10^-6], {k, Length[ps]}]]];
  Quiet@N[gvN[hfval /. pt]]];
$ivfLastRefusals = {}; $ivfLastRace = <||>;
(* True iff the last ivfExactCube refusal was the divergence certificate (any candidate order) *)
ivfLastRefusalDivergentQ[] := AnyTrue[$ivfLastRefusals, TrueQ[#["divergent"]] &];

(* ======================================================================================================
   PROJECTIVE-CHART ORDER RACE for the dispatcher's HyperFLINT slot (2026-08-30, user: "add the order race
   to the [0,Infinity) path too").  The sealed slot (mbe_strategy_dispatch_v2.m: mbePrepareCube -> mbeFindLROrder
   -> mbeHFWithOrder) maps the [0,1] cube to [0,Infinity) itself and runs ONE HyperFLINT order.  Here the same
   prepared cube (same expression string, same bounds "0".."Infinity", algebraic_letters False, canonical emission,
   the sealed slot's own binary Global`hfBin and per-call env) is raced over several candidate orders in parallel:
   LR-scan score-minimal, LR-scan carry_discharge, natural, reversed.  First clean finisher wins, losers are killed.
   Acceptance is the sealed slot's: exact = gvExact[val]; a literal 0 or a non-exact value is refused.
   ====================================================================================================== *)
$ivfProjBin = If[ValueQ[Global`hfBin], Global`hfBin, $ivfBin];
$ivfProjEnv = "env OMP_NUM_THREADS=1 HF_MAX_THREADS_PER_CALL=1 HF_NARROW_CTX=1 ";   (* = mbeRunHF's env *)
ivfProjRequest[prepared_Association, orderNames_List, cert_: True] := <|"op" -> "hyperflint", "expr" -> prepared["String"],
  "vars_int" -> orderNames, "vars" -> Join[prepared["Names"], {"hfEG", "hfPI", "hfZ3", "hfZ5", "hfLOG2"}],
  "vars_int_from" -> ConstantArray["0", Length[orderNames]], "vars_int_to" -> ConstantArray["Infinity", Length[orderNames]],
  "mzv_data_path" -> mzvPath, "algebraic_letters" -> False, "check_divergences" -> cert, "canonical_emission" -> True|>;
(* candidate orders (variable NAMES, as the sealed slot uses them) *)
ivfProjCandidates[prepared_Association, tmo_: 300] := Module[{letters, names = prepared["Names"], ask, cands},
  letters = Quiet@Check[MBEStrategy`Private`mbeAlphabetStrings[prepared], {}];
  ask[carry_] := Module[{req, r, ord},
    If[letters === {}, Return[$Failed]];
    req = <|"op" -> "find_lr_orders", "polys" -> letters, "xvars" -> names, "coeff_vars" -> {},
      "algebraic_letters" -> False, "carry_discharge" -> carry|>;
    r = ivfRunWith[$ivfProjBin, $ivfProjEnv, jsonStr[req], Min[tmo, 300]];
    If[r === $Failed || TrueQ[Lookup[r, "nolr", False]], Return[$Failed]];
    ord = Lookup[r, "best_order", {}];
    If[ListQ[ord] && Sort[ord] === Sort[names], ord, $Failed]];
  cands = DeleteDuplicates[Join[Select[{ask[False], ask[True]}, ListQ], {names, Reverse[names]}]];
  Take[cands, UpTo[$ivfMaxOrders]]];
(* one-shot run with an explicit binary + env (the sealed slot's) *)
ivfRunWith[bin_, envStr_, body_, tmo_] := Module[{inF = FileNameJoin[{$TemporaryDirectory, "ivfp_in_" <> ToString[$ProcessID] <> ".json"}],
    outF = FileNameJoin[{$TemporaryDirectory, "ivfp_out_" <> ToString[$ProcessID] <> ".json"}], r},
  Quiet@DeleteFile[outF]; Export[inF, body, "Text"];
  RunProcess[{"bash", "-c", "ulimit -s unlimited; timeout " <> ToString[tmo] <> " " <> envStr <> bin <> " eval-json < " <> inF <> " > " <> outF <> " 2>/dev/null"}];
  If[!FileExistsQ[outF] || FileByteCount[outF] === 0, Return[$Failed]];
  r = Quiet@Import[outF, "RawJSON"]; If[!AssociationQ[r], $Failed, r]];
(* generic parallel race over ready-made requests {{label, jsonString}, ...}: first ok wins *)
(* 2026-09-08 RESOURCE SCALING (central): every race of the package goes through here.  When the worker has applied
   the scaling ($ivfScaledQ), the requests are raced in batches of at most $ivfRaceWidth (the first clean finisher of
   a batch wins; a batch without one is followed by the next) and the lanes' OMP thread count in the caller's env
   string is rewritten to $ivfRaceThreads, so that the total hyperflint thread count on the node stays near the
   cores whatever the worker count. *)
ivfRaceRequests[reqs_List, tmo_, bin_, envStr_] := Module[{w, env2, res = <|"ok" -> False, "reason" -> "race-failed"|>, allRef = {}},
  If[reqs === {}, Return[res]];
  w = If[TrueQ[$ivfScaledQ] && IntegerQ[$ivfRaceWidth] && $ivfRaceWidth > 0, $ivfRaceWidth, Length[reqs]];
  env2 = If[TrueQ[$ivfScaledQ] && IntegerQ[$ivfRaceThreads] && $ivfRaceThreads > 0,
    StringReplace[envStr, RegularExpression["OMP_NUM_THREADS=\\d+"] -> ("OMP_NUM_THREADS=" <> ToString[$ivfRaceThreads])], envStr];
  Catch[
    Do[res = ivfRaceRequestsBatch[batch, tmo, bin, env2];
       If[AssociationQ[res] && TrueQ[res["ok"]], Throw[res, ivfRaceReqTag]];
       allRef = Join[allRef, If[AssociationQ[res], Lookup[res, "refusals", {}], {}]],
      {batch, Partition[reqs, UpTo[Max[1, w]]]}];
    If[AssociationQ[res], res["refusals"] = allRef; res["divergent"] = AnyTrue[allRef, TrueQ[Lookup[#, "divergent", False]] &]];
    $ivfLastRefusals = allRef;
    res, ivfRaceReqTag]];
ivfRaceRequestsBatch[reqs_List, tmo_, bin_, envStr_] := Module[
  {base, procs = {}, files = {}, t0 = AbsoluteTime[], done = False, result = <|"ok" -> False, "reason" -> "race-failed"|>, k = 0, refusals = {}},
  base = FileNameJoin[{$TemporaryDirectory, "ivfp_race_" <> ToString[$ProcessID] <> "_" <> ToString[Round[1000 t0]]}];
  Do[k++;
    Module[{inF = base <> "_" <> ToString[k] <> ".in", outF = base <> "_" <> ToString[k] <> ".out", pr},
      Export[inF, rq[[2]], "Text"];
      pr = StartProcess[{"setsid", "bash", "-c", "ulimit -s unlimited; timeout " <> ToString[tmo] <> " " <> envStr <> bin <>
        " eval-json < " <> inF <> " > " <> outF <> ".tmp 2>/dev/null; mv " <> outF <> ".tmp " <> outF}];
      AppendTo[procs, pr]; AppendTo[files, {rq[[1]], outF}]],
    {rq, reqs}];
  While[! done && AbsoluteTime[] - t0 < tmo + 5,
    Do[Module[{lab = files[[i, 1]], outF = files[[i, 2]], r, pr},
      If[! done && outF =!= "" && FileExistsQ[outF],
        r = Quiet@Import[outF, "RawJSON"]; Quiet@DeleteFile[outF];
        If[AssociationQ[r],
          pr = parseResp[r];
          If[TrueQ[pr["ok"]],
            pr["Order"] = lab; pr["sec"] = Round[AbsoluteTime[] - t0, 0.01]; pr["divergent"] = KeyExistsQ[r, "divergent"];
            result = pr; done = True,
            AppendTo[refusals, <|"Order" -> lab, "reason" -> ToString[Lookup[pr, "reason", ""]],
              "divergent" -> (KeyExistsQ[r, "divergent"] || StringContainsQ[ToString[Lookup[pr, "reason", ""]], "divergent"])|>]]];
        files[[i, 2]] = "";]],
      {i, Length[files]}];
    If[! done && AllTrue[files, #[[2]] === "" &], Break[]];
    If[! done, Pause[0.1]]];   (* 2026-08-30: 0.5 s granularity dominated trivial cubes *)
  Do[ivfKillGroup[pr], {pr, procs}];
  Do[Quiet@DeleteFile[base <> "_" <> ToString[i] <> ".in"]; Quiet@DeleteFile[base <> "_" <> ToString[i] <> ".out"]; Quiet@DeleteFile[base <> "_" <> ToString[i] <> ".out.tmp"], {i, Length[reqs]}];
  If[! done, result["refusals"] = refusals; result["divergent"] = AnyTrue[refusals, TrueQ[#["divergent"]] &];
    result["reason"] = If[refusals === {}, "race-timeout", First[refusals]["reason"]]];
  $ivfLastRefusals = refusals; $ivfLastRace = result;
  result];
(* dispatcher-shaped entry on a PREPARED cube: exact value or $Failed (sealed-slot acceptance) *)
ivfProjectiveExactCube[prepared_Association, orders_List, tmo_: $ivfSeconds, cert_: True] := Module[{reqs, pr, exact},
  $ivfLastOrders = orders; $ivfLastWinner = None; $ivfLastRefusals = {};
  If[orders === {}, Return[$Failed]];
  reqs = {#, jsonStr[ivfProjRequest[prepared, #, cert]]} & /@ orders;
  pr = If[Length[reqs] > 1 && TrueQ[$ivfParallelRace], ivfRaceRequests[reqs, tmo, $ivfProjBin, $ivfProjEnv],
    Module[{r = ivfRunWith[$ivfProjBin, $ivfProjEnv, reqs[[1, 2]], tmo], p}, If[r === $Failed, <|"ok" -> False, "reason" -> "fail/timeout"|>,
      p = parseResp[r]; p["Order"] = reqs[[1, 1]]; p["sec"] = 0.; p]]];
  If[!TrueQ[pr["ok"]], Return[$Failed]];
  exact = gvExact[pr["val"]];
  If[TrueQ[exact === 0] || !MBEStrategy`Private`mbeExactQ[exact, prepared["Variables"]], Return[$Failed]];
  $ivfLastWinner = <|"Order" -> pr["Order"], "Seconds" -> pr["sec"], "Budget" -> tmo, "Chart" -> "Projective"|>;
  exact];
(* natively [0,Infinity) integrand (no map): build a prepared-like association and race it *)
ivfInfCubePrepare[integrand_, variables_List] := Module[{f, vars, expr},
  {f, vars} = renameVarsHF[integrand, variables];
  expr = ivfPolyLogToHlog[f /. constToHF];
  <|"Expression" -> expr, "Variables" -> vars, "Names" -> (SymbolName /@ vars), "String" -> exprStr[expr]|>];
ivfInfExactCube[integrand_, variables_List, tmo_: $ivfSeconds] := Module[{prep = ivfInfCubePrepare[integrand, variables]},
  ivfProjectiveExactCube[prep, ivfProjCandidates[prep, tmo], tmo]];

(* ======================================================================================================
   CHART RACE (2026-08-30, user: "a single race across both charts"): native [0,1] candidates and projective
   [0,Infinity) candidates (the cube mapped x -> s/(1+s) with Jacobian, exactly as the sealed dispatcher does)
   start TOGETHER on the fork binary; the first clean finisher wins.  Per chart: LR score-minimal, LR carry_discharge,
   natural (<= $ivfChartPerChart each).  Threads per candidate $ivfChartThreads.  Winner carries "Chart".
   ====================================================================================================== *)
$ivfChartPerChart = 4;   (* LR score-min, LR carry, natural, reversed — the reversed order won 4 of the hardest 18 natively *)
$ivfChartThreads = 2;    (* 8 candidates x 2 threads per cube; 1 thread cost 846/847 ~10x on the native chart, 4 threads x 8 candidates is too much per PieceKernels worker *)
ivfProjPrepare[f_, vars_List] := Module[{expr},
  expr = (f /. Thread[vars -> vars/(1 + vars)]) Times @@ ((1 + #)^-2 & /@ vars);
  expr = ivfPolyLogToHlog[expr /. constToHF];
  <|"Expression" -> expr, "Native" -> f, "Variables" -> vars, "Names" -> (SymbolName /@ vars), "String" -> exprStr[expr]|>];
(* projective candidates WITHOUT the dispatcher (workers have no MBEStrategy): LR scan on ivfAlphabet of the mapped
   expression (boundary letters x_i; 1-x_i is harmless extra) *)
(* projective alphabet from the NATIVE one (2026-08-30): each native letter P(x) -> Numerator[P(s/(1+s))] plus the
   boundary letters s_i and 1+s_i.  Running ivfAlphabet on the MAPPED 7-fold expression (Together of the whole
   rational function) cost ~120 s on id 846; this is a substitution on small factors. *)
ivfProjAlphabetFromNative[f_, vars_List] := Module[{alphaN, polys},
  alphaN = Quiet@Check[ivfAlphabetPolys[f, vars], {}];
  polys = Join[Numerator[Together[# /. Thread[vars -> vars/(1 + vars)]]] & /@ alphaN, vars, 1 + vars];
  polys = DeleteDuplicates[Flatten[FactorList[#][[All, 1]] & /@ polys]];
  polys = Select[polys, ! FreeQ[#, Alternatives @@ vars] && ! NumericQ[#] &];
  exprStr /@ polys];
ivfProjCandidatesLocal[prep_Association, tmo_: 300, ps_List: {}] := Module[{f = prep["Expression"], vars = prep["Variables"], names, byName, alpha, ask, cands},
  names = prep["Names"]; byName = AssociationThread[names -> vars];
  alpha = Quiet@Check[ivfProjAlphabetFromNative[Lookup[prep, "Native", f], vars], {}];
  ask[carry_] := Module[{req, r, ord},
    If[alpha === {}, Return[$Failed]];
    req = <|"op" -> "find_lr_orders", "polys" -> alpha, "xvars" -> names, "coeff_vars" -> (SymbolName /@ ps), "algebraic_letters" -> True, "carry_discharge" -> carry|>;
    r = ivfRun[jsonStr[req], Min[tmo, 300]];
    If[r === $Failed || TrueQ[Lookup[r, "nolr", False]], Return[$Failed]];
    ord = Lookup[r, "best_order", {}];
    If[ListQ[ord] && Sort[ord] === Sort[names], ord, $Failed]];
  cands = DeleteDuplicates[Join[Select[{ask[False], ask[True]}, ListQ], {names, Reverse[names]}]];
  Take[cands, UpTo[$ivfChartPerChart]]];
ivfNativeRequest[f_, vars_, order_, cert_, ps_List: {}] := <|"op" -> "hyperflint", "expr" -> exprStr[f], "vars_int" -> (SymbolName /@ order),
  "vars" -> Join[SymbolName /@ vars, SymbolName /@ ps, {"hfEG", "hfPI", "hfZ3", "hfZ5", "hfLOG2"}],
  "vars_int_from" -> ConstantArray["0", Length[order]], "vars_int_to" -> ConstantArray["1", Length[order]],
  "mzv_data_path" -> mzvPath, "algebraic_letters" -> True, "canonical_emission" -> True,
  "check_divergences" -> cert, "native_unit_interval" -> True, "spectator_algebraic_letters" -> (ps =!= {})|>;
(* projective candidates: algebraic letters OFF for constants-only cubes (= the sealed slot; ON made 846/847 6x slower),
   but ON with the spectator flag when parameters are present (the lambda letters live on both charts) *)
ivfProjRequestFork[prep_Association, orderNames_List, cert_, ps_List: {}] := <|"op" -> "hyperflint", "expr" -> prep["String"], "vars_int" -> orderNames,
  "vars" -> Join[prep["Names"], SymbolName /@ ps, {"hfEG", "hfPI", "hfZ3", "hfZ5", "hfLOG2"}],
  "vars_int_from" -> ConstantArray["0", Length[orderNames]], "vars_int_to" -> ConstantArray["Infinity", Length[orderNames]],
  "mzv_data_path" -> mzvPath, "algebraic_letters" -> (ps =!= {}), "canonical_emission" -> True,
  "check_divergences" -> cert, "native_unit_interval" -> False, "spectator_algebraic_letters" -> (ps =!= {})|>;
Options[ivfExactCubeBoth] = {"Regularized" -> False, "OrderHint" -> None, "Parameters" -> Automatic};
ivfExactCubeBoth[integrand_, variables_List, timeout_: $ivfSeconds, OptionsPattern[]] := Module[
  {f, vars, fN, lr, hint, natOrders, prep, projOrders, reqs, pr, val, reg = TrueQ[OptionValue["Regularized"]], env, ps},
  If[variables === {}, Return[If[NumericQ[Quiet@N[integrand]], integrand, $Failed]]];
  {f, vars} = renameVarsHF[integrand, variables];
  ps = OptionValue["Parameters"]; If[ps === Automatic, ps = ivfParametersOf[f, vars]]; If[!ListQ[ps], ps = {}];
  $ivfLastParameters = ps;
  fN = ivfPolyLogToHlog[f /. constToHF];
  lr = Quiet@Check[ivfFindOrder[f, vars, 300, ps], $Failed];
  hint = OptionValue["OrderHint"];
  hint = If[ListQ[hint] && Length[hint] === Length[variables], (renameVarsHF[0, hint][[2]]), None];
  natOrders = DeleteDuplicates[Join[If[ListQ[lr], lr, {}], If[ListQ[hint] && Sort[hint] === Sort[vars], {hint}, {}], {vars, Reverse[vars]}]];
  natOrders = Take[natOrders, UpTo[$ivfChartPerChart + If[ListQ[hint], 1, 0]]];
  prep = ivfProjPrepare[f, vars];
  projOrders = Quiet@Check[ivfProjCandidatesLocal[prep, timeout, ps], {prep["Names"]}];
  reqs = Join[{{"Unit", #}, jsonStr[ivfNativeRequest[fN, vars, #, !reg, ps]]} & /@ natOrders,
              {{"Projective", #}, jsonStr[ivfProjRequestFork[prep, #, !reg, ps]]} & /@ projOrders];
  $ivfLastOrders = reqs[[All, 1]]; $ivfLastWinner = None; $ivfLastRefusals = {};
  env = "env OMP_NUM_THREADS=" <> ToString[$ivfChartThreads] <> " ";
  pr = ivfRaceRequests[reqs, timeout, $ivfBin, env];
  $ivfLastRace = pr;
  If[!TrueQ[pr["ok"]], Return[$Failed]];
  val = gvExact[pr["val"]];
  $ivfLastRace["exact"] = val; $ivfLastRace["numeric"] = ivfNumericCheck[pr["val"], ps];
  If[!(FreeQ[val, _Real] && NumericQ[$ivfLastRace["numeric"]]), Return[$Failed]];
  $ivfLastWinner = <|"Order" -> pr["Order"][[2]], "Chart" -> pr["Order"][[1]], "Seconds" -> pr["sec"], "Budget" -> timeout, "Parameters" -> ps|>;
  val];

(* ======================================================================================================
   AUTO-RATIONALIZATION (2026-08-31, user: "keep the mechanism for rationalization in the package, so that
   cases where rationalization solves the problem in terms of GPL are done automatically").
   On a non-LR refusal the hook calls ivfRationalizeCube: census the quadratic letter obstructions, build Euler
   substitutions at rational boundary points (z -> (b - 2 s0 tau)/(tau^2 - a), verified SYMBOLICALLY:
   F(psi) = (s0 + tau psi)^2, psi(tau0) = 0, psi(tau1) = 1 — the transform is exact, no numerics in the result),
   remap tau affinely to [0,1], and LR-scan the transformed cube with a short budget.  First candidate that scans
   LR wins; the transformed cube integrates to the SAME value (GPLs).  Candidates whose sampled path leaves the
   unit interval grossly are refused (conservative guard; the identities alone do not certify monotonicity).
   If every candidate fails the cube is tagged non-rationalizable — on this corpus that is the elliptic class
   (genus-1 double covers, see TODO.md "(g)"): stop, never iterate blindly.  Depth is 1 by design.
   ====================================================================================================== *)
$ivfRatScanSeconds = 120;      (* LR-scan budget per candidate inside the auto path *)
$ivfRatMaxCandidates = 6;
$ivfRatCache = <||>;           (* cube-hash -> $Failed (exhausted) or the transform package; per-session *)
ivfRatSqrtOf[e_] := Module[{fl = FactorList[e], q},
  q = First[fl][[1]];
  If[!AllTrue[Rest[fl], EvenQ[#[[2]]] &] || q < 0 || Head[Sqrt[q]] === Power || !FreeQ[Sqrt[q], Power[_, _Rational]], $Failed,
    Sqrt[q] Times @@ (#[[1]]^(#[[2]]/2) & /@ Rest[fl])]];   (* Sqrt[q] must be RATIONAL (NumericQ[Sqrt[2]] is True — the old test let irrationals through) *)
(* quadratic obstructions: base letters quadratic in w whose discriminant has a non-square factor depending on
   other INTEGRATION variables *)
ivfQuadraticObstructions[f_, vars_List] := Module[{polys, out = {}},
  polys = Quiet@Check[ivfAlphabetPolys[f, vars], {}];
  Do[Do[If[Exponent[p, w] == 2,
      Module[{disc = Quiet@Together[Coefficient[p, w, 1]^2 - 4 Coefficient[p, w, 2] Coefficient[p, w, 0]], fl, F, co, coq},
        (* the rationalization target is disc / (its square part) WITH SIGN AND NUMERIC CONTENT:
           FactorList strips the sign into the numeric entry (disc = 1+4x-x^2 -> (-1)(x^2-4x-1)); losing it made
           F(0) < 0 and killed every valid candidate.  co = disc/(F * squares) must be a rational SQUARE. *)
        fl = FactorList[disc];
        F = Times @@ (#[[1]]^Mod[#[[2]], 2] & /@ Rest[fl]);   (* odd part of the polynomial factors *)
        co = First[fl][[1]];                                   (* numeric content (carries the sign) *)
        If[co < 0, F = -F; co = -co];
        coq = Sqrt[co];
        If[!FreeQ[coq, Power[_, _Rational]], F = co F];        (* non-square numeric: fold it into F *)
        If[!FreeQ[F, Alternatives @@ DeleteCases[vars, w]] && ivfRatSqrtOf[Factor[disc]] === $Failed && Exponent[F, w] == 0,
          AppendTo[out, <|"w" -> w, "F" -> F|>]]]],
      {w, Select[vars, Exponent[p, #] == 2 &]}],
    {p, polys}];
  DeleteDuplicatesBy[out, #["F"] &]];
(* one Euler substitution: z (quadratic in F) at center 0 or 1; returns the transformed cube or $Failed *)
$ivfRootCount = 0;
ivfEulerTransform[f_, vars_List, F_, z_, center_, uNew_] := Module[
  {zz, F2, a, b, c, s0, s1, psi, tau0, tau1, g, sub, back, others, ok, rootRules = {}, farVal},
  F2 = Together[F /. z -> If[center === 0, zz, 1 - zz]];
  a = Coefficient[F2, zz, 2]; b = Coefficient[F2, zz, 1]; c = Coefficient[F2, zz, 0];
  s0 = ivfRatSqrtOf[Factor[c]]; If[s0 === $Failed || s0 === 0, Return[$Failed]];
  s1 = ivfRatSqrtOf[Factor[F2 /. zz -> 1]];
  If[s1 === $Failed,
    (* ONE-SIDED case (2026-08-31, the user's "last fold" class): allowed only when F is free of every
       integration variable except z — then Sqrt[F(far end)] is a PARAMETER constant; adjoin it as a fresh
       root parameter r (definition returned via RootRules, served through LamRules like IntVol's lambdas). *)
    If[!FreeQ[F, Alternatives @@ DeleteCases[vars, z]], Return[$Failed]];
    farVal = Together[F2 /. zz -> 1];
    Module[{r = Symbol["Global`ivfr" <> ToString[++$ivfRootCount]]},
      s1 = r; rootRules = {r -> Sqrt[farVal]}]];
  psi = Together[(b - 2 s0 ivfTau)/(ivfTau^2 - a)];
  (* the far-endpoint identity holds modulo r^2 = F(far end): substitute the root definition before simplifying *)
  ok = Quiet@TimeConstrained[
    Simplify[(F2 /. zz -> psi) - (s0 + ivfTau psi)^2] === 0 &&
    Simplify[psi /. ivfTau -> Together[b/(2 s0)]] === 0 &&
    Simplify[((psi /. ivfTau -> Together[s1 - s0]) /. rootRules) - 1] === 0, 120, False];
  If[!TrueQ[ok], Return[$Failed]];
  tau0 = Together[b/(2 s0)]; tau1 = Together[s1 - s0];
  back = If[center === 0, psi, 1 - psi];
  g = Quiet@TimeConstrained[Together[(f /. z -> back) D[back, ivfTau]], 120, $Failed];
  If[g === $Failed, Return[$Failed]];
  g = Quiet@TimeConstrained[Together[(g /. ivfTau -> tau0 + (tau1 - tau0) uNew) (tau1 - tau0)], 120, $Failed];
  If[g === $Failed || !FreeQ[g, ivfTau], Return[$Failed]];
  (* GUARD v2 (2026-08-31): what invalidates the tau-integral is a POLE of the transformed rational integrand on
     the straight tau-segment — NOT excursions of psi outside [0,1] (rigorous 1-D checks pass on excursion draws;
     cf. b3:5/6/9).  Two-stage guard: (1) denominator sign-change scan along the segment on 200 random draws;
     (2) three pointwise 1-D quadrature comparisons original-vs-transformed (the decisive oracle). *)
  others = DeleteCases[vars, z];
  Module[{psAll = ivfParametersOf[f, vars], denTau = Denominator[Together[(f /. z -> back) D[back, ivfTau]]], bad = 0, nD = 0},
    Do[Module[{s, t0v, t1v, dv},
      s = Join[Thread[others -> RandomReal[{1/20, 19/20}, Length[others]]],
               Thread[psAll -> RandomReal[{11/100, 87/100}, Length[psAll]]]];
      s = Join[s, rootRules /. Rule[r_, d_] :> Rule[r, N[d /. s]]];
      t0v = Quiet@N[tau0 /. s]; t1v = Quiet@N[tau1 /. s];
      If[!(NumericQ[t0v] && NumericQ[t1v]), bad++,
        dv = Quiet@Table[N[denTau /. s /. ivfTau -> t0v + k (t1v - t0v)/40], {k, 0, 40}];
        If[!VectorQ[dv, NumericQ] || Min[Abs[dv]] < 10^-13 || Length[Split[Sign[dv]]] > 1, bad++]]],
      {200}];
    If[bad > 4, Return[$Failed, Module]];
    Do[Module[{s, i1, i2},
      s = Join[Thread[others -> RandomReal[{1/10, 9/10}, Length[others]]],
               Thread[psAll -> RandomReal[{11/100, 87/100}, Length[psAll]]]];
      s = Join[s, rootRules /. Rule[r_, d_] :> Rule[r, Rationalize[N[d /. s], 10^-15]]];
      i1 = Quiet@NIntegrate[f /. s, {z, 0, 1}, PrecisionGoal -> 8, WorkingPrecision -> 20];
      i2 = Quiet@NIntegrate[(f /. z -> back) D[back, ivfTau] /. s, {ivfTau, Rationalize[N[tau0 /. s], 0], Rationalize[N[tau1 /. s], 0]}, PrecisionGoal -> 8, WorkingPrecision -> 20];
      If[!(NumericQ[i1] && NumericQ[i2] && Abs[i1 - i2] < 10^-5 (1 + Abs[i1])), nD++]],
      {3}];
    If[nD > 0, Return[$Failed, Module]]];
  <|"Integrand" -> g, "Vars" -> Append[DeleteCases[vars, z], uNew], "RootRules" -> rootRules,
    "Note" -> "Euler substitution: " <> ToString[z] <> " (center " <> ToString[center] <> ") rationalizing Sqrt of a quadratic-letter discriminant" <> If[rootRules === {}, "", "; adjoined root parameter " <> ToString[rootRules[[1, 1]]]]|>];
(* the driver: try candidates until one scans LR; cached per cube *)
ivfRationalizeCube[f_, vars_List, ps_List] := Module[{key, obs, cands = {}, res = $Failed, uNew, k = 0},
  key = Hash[{f, vars}];
  If[KeyExistsQ[$ivfRatCache, key], Return[$ivfRatCache[key]]];
  obs = Quiet@Check[TimeConstrained[ivfQuadraticObstructions[f, vars], 60, {}], {}];
  Do[Do[Do[If[Exponent[o["F"], z] == 2, AppendTo[cands, {o["F"], z, ctr}]],
      {ctr, {0, 1}}], {z, Select[vars, Exponent[o["F"], #] == 2 &]}], {o, obs}];
  cands = Take[DeleteDuplicates[cands], UpTo[$ivfRatMaxCandidates]];
  Do[k++;
    Module[{tr, lr, ff, rv},
      uNew = Symbol["Global`ivfu" <> ToString[k]];
      tr = Quiet@Check[ivfEulerTransform[f, vars, cd[[1]], cd[[2]], cd[[3]], uNew], $Failed];
      If[tr =!= $Failed,
        {ff, rv} = renameVarsHF[tr["Integrand"], tr["Vars"]];
        lr = Quiet@Check[ivfFindOrder[ff, rv, $ivfRatScanSeconds, Join[ps, Lookup[tr, "RootRules", {}][[All, 1]]]], $Failed];
        If[ListQ[lr],
          res = Join[tr, <|"Obstruction" -> cd[[1]], "Candidate" -> {cd[[2]], cd[[3]]}|>];
          Break[]]]],
    {cd, cands}];
  If[res === $Failed && obs === {}, res = "no-quadratic-obstruction"];
  $ivfRatCache[key] = res; res];
