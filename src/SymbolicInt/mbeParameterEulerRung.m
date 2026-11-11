(* Coupled parameter coefficient rung. The BWS functions are localized for a
   call: constant routes and their global exactness predicate are not patched.
   Root contributions are retained, and every candidate needs an independent
   source-contour gate. Numeric values never enter the returned expression. *)
BeginPackage["MBParameter`"];
MBParameterClosePiece::usage = "MBParameterClosePiece[kernel,contourRules,variables,options] closes an epsilon-free scaled Barnes coefficient, with an independent contour diagnostic gate.";
Options[MBParameterClosePiece] = {"ExternalParameters" -> {}, "ParameterAssumptions" -> True,
  "ParameterTimeConstraint" -> 120};
Begin["`Private`"];
$gateScript = FileNameJoin[{DirectoryName[ExpandFileName[$InputFileName]], "parameter_support", "contour_check.py"}];
If[!TrueQ[$bwsSaved],
  DownValues[baseParse] = DownValues[Global`bwsParse] /. Global`bwsParse -> baseParse;
  DownValues[baseInit] = DownValues[Global`bwsInit] /. Global`bwsInit -> baseInit;
  DownValues[baseSample] = DownValues[Global`bwsSamplePoint] /. Global`bwsSamplePoint -> baseSample;
  DownValues[baseVarSymbolQ] = DownValues[Global`bwsVarSymbolQ] /. Global`bwsVarSymbolQ -> baseVarSymbolQ;
  $bwsSaved = True];
If[DownValues[baseVarSymbolQ] === {},
  DownValues[baseVarSymbolQ] = DownValues[Global`bwsVarSymbolQ] /. Global`bwsVarSymbolQ -> baseVarSymbolQ];
If[DownValues[baseFresh] === {},
  DownValues[baseFresh] = DownValues[Global`bwsFresh] /. Global`bwsFresh -> baseFresh];

parameterPoints[pars_, dom_] := Module[{grid, pt, spread},
  If[pars === {}, Return[{{}, {}}, Module]];
  (* up to three parameters: the full grid; more (a three-site cosmological sector has four or more): well-spread
     points with distinct coordinates, so that no two parameters coincide, then the diagonal grid points *)
  spread = {{1/3, 2/5, 3/7, 4/9, 5/11, 6/13, 7/15, 8/17}, {1/2, 2/7, 3/8, 2/9, 5/12, 3/10, 4/11, 5/13},
    {2/3, 3/5, 4/7, 5/9, 6/11, 7/13, 8/15, 9/17}, {2, 3, 5/2, 7/3, 9/4, 11/5, 13/6, 15/7}};
  grid = If[Length[pars] <= 3, Tuples[{1/3, 2/3, 1/2, 2, 3}, Length[pars]],
    Join[Map[Take[#, Length[pars]] &, Select[spread, Length[#] >= Length[pars] &]],
      Map[ConstantArray[#, Length[pars]] &, {1/3, 2/3, 1/2, 2, 3}]]];
  grid = Thread[pars -> #] & /@ grid;
  (* points with pairwise distinct coordinates first: equal parameters lie on spurious singularities of many candidate
     representations (letters u_i - u_j), where no candidate evaluates and the source gate refused correct results *)
  grid = Join[Select[grid, DuplicateFreeQ[Values[#]] &], Select[grid, ! DuplicateFreeQ[Values[#]] &]];
  pt = Select[grid, TrueQ[dom /. #] &]; Take[pt, UpTo[2]]];
parseScaled[ig_, vars_, dom_] := Module[{ff = factors[ig], kin, p},
  kin = Select[ff, MatchQ[#, _Power] && !FreeQ[#[[2]], Alternatives @@ vars] &];
  If[!AllTrue[kin, FreeQ[#[[1]], Alternatives @@ vars] &&
     Global`bwsAffineQ[#[[2]], vars] && prove[#[[1]] > 0, dom] &], Return[$Failed, Module]];
  p = baseParse[Times @@ Select[ff, !MemberQ[kin, #] &], vars];
  If[p === $Failed, Return[$Failed, Module]];
  Join[p, <|"ExternalKin" -> (List @@ # & /@ kin)|>]];

(* Exact log factorization must be valid on the entire open auxiliary cube;
   sample points are used for ranking only, never as a positivity proof. *)
positiveLogExpand[expr_, dom_] := expr /. Log[a_] :> Module[{fl, aux, domain, sign = 1, out = 0},
  fl = FactorList[Together[a]];
  aux = DeleteDuplicates@Cases[a, s_Symbol /; Global`bwsVarSymbolQ[s], {0, Infinity}];
  domain = dom && And @@ (0 < # < 1 & /@ aux);
  Do[Which[prove[r[[1]] > 0, domain], out += r[[2]] Log[r[[1]]],
    prove[r[[1]] < 0, domain], sign *= (-1)^r[[2]]; out += r[[2]] Log[-r[[1]]],
    True, Throw[$Failed, "bwsE"]], {r, fl}];
  If[sign =!= 1, Throw[$Failed, "bwsE"]]; out];

parameterCubes[ig_, ctr_, vars_, depth_: 0] := Module[
  {p, psis, near, m, L, n, base, r1, r2, ss, m0, terms, candidates, chosen, F, ev, q, out = {}},
  If[depth > 12, Return[$Failed, Module]];
  If[vars === {}, Return[{{ig, {}}}, Module]];
  p = Global`bwsParse[ig, vars]; If[p === $Failed, Return[$Failed, Module]];
  psis = If[p["psi"] === None, {}, p["psi"]];
  near = SelectFirst[psis, TrueQ[Global`bwsRe[#[[2]], ctr] < 1/4] &, None];
  If[near =!= None,
    {m, L} = List @@ near; n = If[Global`bwsRe[L, ctr] <= 0, Floor[-Global`bwsRe[L, ctr]] + 1, 1];
    base = Cancel[ig/near]; r1 = parameterCubes[base PolyGamma[m, L + n], ctr, vars, depth + 1];
    If[r1 === $Failed, Return[$Failed, Module]];
    Do[r2 = parameterCubes[Together[base/(L + j)^(m + 1)], ctr, vars, depth + 1];
      If[r2 === $Failed, Return[$Failed, Module]];
      r1 = Join[r1, {-(-1)^m m! #[[1]], #[[2]]} & /@ r2], {j, 0, n - 1}]; Return[r1, Module]];
  p = Global`bwsCancelDen[p, ctr]; If[p === $Failed, Return[$Failed, Module]];
  ss = Table[Global`bwsFresh["bwsS"], {Length[psis]}]; m0 = Pick[ss, #[[1]] === 0 & /@ psis];
  Global`$bwsM0Scales = m0;
  terms = Global`bwsInit[p, vars, ctr, ss]; If[terms === $Failed, Return[$Failed, Module]];
  candidates = Global`bwsCandidates[terms, vars, ctr, {}]; If[candidates === {}, Return[$Failed, Module]];
  chosen = candidates[[Min[Length[candidates], If[IntegerQ[$cubeCandidateIndex], $cubeCandidateIndex, 1]]]];
  Global`$bwsSquaredNow = Lookup[chosen, "Squared", {}];
  Do[F = Total[chosen["Groups"][[All, 1]]]; ev = DeleteDuplicates[Flatten[chosen["Groups"][[All, 2]]]];
    q = Global`bwsAtOne[F, Complement[m0, T]]; If[q === $Failed, Return[$Failed, Module]];
    If[T =!= {} && AnyTrue[T, FreeQ[q, #] &], q = 0,
      q = Together[(-EulerGamma)^(Length[m0] - Length[T]) (-1)^Length[T]
        Times @@ (If[MemberQ[Global`$bwsSquaredNow, #], Log[1 - #^2], Log[1 - #]] & /@ T)
        D[q, Sequence @@ T]]];
    If[q =!= 0, AppendTo[out, {q, DeleteCases[ev, Alternatives @@ Complement[m0, T]]}]], {T, Subsets[m0]}];
  out];

regG[{}] = 1;
regG[w_List] := regG[w] = Module[{m = LengthWhile[w, # === 1 &], r},
  If[m === 0, Return[Apply[PolyLogTools`G, Append[w, 1]], Module]];
  If[m === Length[w], Return[0, Module]];
  r = Rest[w]; -Sum[regG[Insert[r, 1, j + 1]], {j, m, Length[r]}]/m];
period[w_List] := Module[{rows = {{1, {}}}},
  Do[rows = Flatten[Table[If[Together[a + 1] === 0,
    {{-r[[1]], Append[r[[2]], 1]}},
    {{r[[1]], Append[r[[2]], Together[a/(1 + a)]]}, {-r[[1]], Append[r[[2]], 1]}}], {r, rows}], 1], {a, w}];
  Expand[Total[#[[1]] regG[#[[2]]] & /@ rows]]];

sourceAST[x_, vars_, pars_] := Which[
  MemberQ[vars, x], {"var", First@FirstPosition[vars, x] - 1},
  MemberQ[pars, x], {"param", First@FirstPosition[pars, x] - 1},
  NumericQ[x], {"num", N[Re[x]], N[Im[x]]},
  MemberQ[{Plus, Times, Power, Log, Gamma, PolyGamma}, Head[x]],
    Prepend[sourceAST[#, vars, pars] & /@ (List @@ x), SymbolName[Head[x]]],
  True, $Failed];
(* GiNaC's interface temporarily changes Directory[]. Restore it even when a
   diagnostic times out or aborts. A single batch call avoids launching a
   separate process for every GPL in a large algebraic candidate. *)

(* the constant, non-integer parts of the exponents of positive kinematic bases, {constant factor, rest of the kernel} *)
splitKinematicConstants[ig_, vars_, dom_] := Module[{pref = 1, rest = {}},
  Do[If[MatchQ[f, Power[b_, e_] /; FreeQ[b, Alternatives @@ vars] && !FreeQ[e, Alternatives @@ vars]] &&
      affineQ[f[[2]], vars] && prove[f[[1]] > 0, dom],
    With[{c0 = f[[2]] /. Thread[vars -> 0]},
      If[NumericQ[c0] && !IntegerQ[c0],
        pref *= f[[1]]^c0; AppendTo[rest, f[[1]]^Expand[f[[2]] - c0]],
        AppendTo[rest, f]]],
    AppendTo[rest, f]], {f, factors[ig]}];
  {pref, Times @@ rest}];

(* direct ginsh evaluation of G functions with numeric arguments, each scaled to the argument 1 (G(a; y) = G(a/y; 1)
   for a nonzero last index), the evaluation that the cosmological records were checked with.  Used only when
   PolyLogTools`Ginsh returns no number, for the predictions of the independent source gate *)
directGinshNumber[x_] := Module[{r = If[IntegerQ[x] || Head[x] === Rational || !NumericQ[x], x, Quiet[RootReduce[x]]]},
  If[IntegerQ[r] || Head[r] === Rational, ToString[InputForm[r]],
    StringReplace[ToString[N[r, 60], InputForm, NumberMarks -> False], "*^" -> "E"]]];
directGinshValue[e_] := Module[{exe, gs, lines, reply, vals, scaled},
  exe = If[StringQ[Global`$MBStandardGinshExecutable], Global`$MBStandardGinshExecutable, "ginsh"];
  gs = DeleteDuplicates[Cases[{e}, g_PolyLogTools`G /; VectorQ[List @@ g, NumericQ], {0, Infinity}]];
  If[gs === {}, Return[With[{v = N[e, 30]}, If[NumericQ[v], v, $Failed]], Module]];
  scaled[g_] := Module[{a = Most[List @@ g], y = Last[List @@ g]}, If[TrueQ[y > 0] || Last[a] === 0, {a, y}, {a/y, 1}]];
  lines = Map[Function[g, With[{ay = scaled[g]},
      "evalf(G({" <> StringRiffle[directGinshNumber /@ ay[[1]], ","] <> "}," <> directGinshNumber[ay[[2]]] <> "));"]], gs];
  reply = Quiet@RunProcess[{exe}, "StandardOutput", "Digits=40:\n" <> StringRiffle[lines, "\n"] <> "\n"];
  If[!StringQ[reply], Return[$Failed, Module]];
  vals = Quiet@Map[ToExpression[StringReplace[StringTrim[#], "E" -> "*^"]] &, StringSplit[StringTrim[reply], "\n"]];
  If[Length[vals] =!= Length[gs] || !VectorQ[vals, NumericQ], Return[$Failed, Module]];
  With[{v = N[e /. Thread[gs -> vals], 30]}, If[NumericQ[v], v, $Failed]]];

parameterNumericValue[expr_, seconds_: 25] := Module[{here = Directory[], value, e},
  Internal`WithLocalSettings[Null,
    value = CheckAbort[Quiet@TimeConstrained[
      e = Global`gvExact[expr];
      If[FreeQ[e, _HPL`HPL | _Gamma | _PolyGamma],
        e = PolyLogTools`ShuffleRegulate[Expand[e]];
        If[FreeQ[e, PolyLogTools`G], N[e, 35],
          N[PolyLogTools`Ginsh[e, {}, PolyLogTools`PrecisionGoal -> 35], 30]],
        Global`gvN[e]], seconds, $Failed], $Failed],
    If[Directory[] =!= here, SetDirectory[here]]];
  (* PolyLogTools`Ginsh returns no number for some candidates (G functions with arguments above 1 together with logs
     of negative numbers whose imaginary parts cancel): the direct, scaled ginsh evaluation is tried instead *)
  If[!NumericQ[value],
    value = Quiet@CheckAbort[TimeConstrained[Module[{e1 = Global`gvExact[expr]},
        If[FreeQ[e1, _HPL`HPL | _Gamma | _PolyGamma], directGinshValue[PolyLogTools`ShuffleRegulate[Expand[e1]]], $Failed]],
      seconds, $Failed], $Failed];
    If[Directory[] =!= here, SetDirectory[here]]];
  If[NumericQ[value], value, $Failed]];

sourceGate[ig_, ctr_, vars_, val_, pars_, points_] := Module[{preds, ast, tmp, req, resp, proc, answer, python, sampleKey, samples, candidateKey, saved},
  candidateKey = Hash[{"CandidateCheck", ig, ctr, vars, pars, points, Expand[val]}, "SHA256"];
  saved = If[AssociationQ[$sourceGateSamples], Lookup[$sourceGateSamples, candidateKey, None], None];
  If[AssociationQ[saved], $lastSourceGate = saved; Return[TrueQ[Lookup[saved, "pass", False]], Module]];
  $lastSourceGate = <|"pass" -> False, "reason" -> "Source diagnostic not completed."|>;
  ast = sourceAST[ig, vars, pars]; If[!FreeQ[ast, $Failed], Return[False, Module]];
  preds = Table[With[{v = parameterNumericValue[val /. pt]},
    If[!NumericQ[v], Return[False, Module]];
    <|"parameters" -> N[pars /. pt], "value" -> N[{Re[v], Im[v]}]|>], {pt, points}];
  tmp = CreateDirectory[]; req = FileNameJoin[{tmp, "request.json"}]; resp = FileNameJoin[{tmp, "response.json"}];
  sampleKey = Hash[{ig, ctr, vars, pars, points}, "SHA256"];
  samples = If[AssociationQ[$sourceGateSamples], Lookup[$sourceGateSamples, sampleKey, <||>], <||>];
  Export[req, <|"ast" -> ast, "contour" -> N[vars /. ctr], "predictions" -> preds, "observations" -> samples|>, "RawJSON"];
  (* Keep subprocess streams with this call's temporary files, including in
     restricted workspaces where the default Wolfram user-base is read-only. *)
  python = If[StringQ[Global`$MBStandardPythonExecutable], Global`$MBStandardPythonExecutable, "python3"];
  proc = If[StringQ[python], Quiet@Check[Block[{ProcessLink`Private`$TempPrefix = FileNameJoin[{tmp, "wl-stream-"}]},
    RunProcess[{"env", "OMP_NUM_THREADS=1", "OPENBLAS_NUM_THREADS=1", python,
      ExpandFileName[$gateScript], req, resp}]], $Failed], $Failed];
  answer = If[FileExistsQ[resp], Quiet@Check[Import[resp, "RawJSON"], <||>],
    <|"pass" -> False, "reason" -> "Python contour diagnostic did not return a JSON response.",
      "Process" -> If[AssociationQ[proc], KeyTake[proc, {"ExitCode", "StandardError"}], proc]|>];
  If[AssociationQ[answer] && AssociationQ[$sourceGateSamples] && AssociationQ[Lookup[answer, "observations", None]],
    AssociateTo[$sourceGateSamples, sampleKey -> answer["observations"]]];
  $lastSourceGate = If[AssociationQ[answer], KeyDrop[answer, "observations"], answer];
  If[AssociationQ[$sourceGateSamples] && AssociationQ[answer] && KeyExistsQ[answer, "pass"],
    AssociateTo[$sourceGateSamples, candidateKey -> $lastSourceGate]];
  (* Own temporary diagnostics only. Nothing in the user's project is removed. *)
  Quiet@DeleteDirectory[tmp, DeleteContents -> True];
  AssociationQ[answer] && TrueQ[Lookup[answer, "pass", False]]];

slopeTwo[ig_, ctr_, vars_, dom_] := Module[{v, sc, p, y, r, l, L, c, value},
  If[Length[vars] =!= 1, Return[$Failed, Module]]; v = First[vars];
  sc = splitScale[ig, v, vars, dom]; If[sc === $Failed, Return[$Failed, Module]];
  p = baseParse[sc["Rest"], vars]; If[p === $Failed, Return[$Failed, Module]];
  If[Sort[p["gam"]] =!= Sort[{-v, -v, -v, v, 1 + 2 v}] ||
    p["den"] =!= {} || p["rat"] =!= {} || p["poly"] =!= {} || p["psi"] =!= None, Return[$Failed, Module]];
  c = v /. ctr; If[!TrueQ[-1/2 < c < 0 || 0 < c < 1], Return[$Failed, Module]];
  y = sc["Scale"]; r = (1 - Sqrt[1 + 4 y])/(1 + Sqrt[1 + 4 y]); l = Log[1 + r]; L = Log[y];
  value = 2 PolyLog[3, -r] + 4 l^3/3 + 2 l^2 L + l L^2 + 8 Zeta[2] l;
  If[TrueQ[c < 0], value -= -L^3/6 - 4 Zeta[2] L + 2 Zeta[3]];
  p["const"] value];

(* Each request owns its subprocess input/output. This avoids the legacy
   process-ID filenames colliding across separately namespaced kernels. *)
parameterNativeRun[request_, seconds_] := Module[{streams = CreateDirectory[], process, result},
  Internal`WithLocalSettings[Null,
    process = Quiet@Check[Block[{ProcessLink`Private`$TempPrefix = FileNameJoin[{streams, "wl-stream-"}]},
      RunProcess[Join[MBAnalytica`Portable`TimeoutArgs[seconds], {"env", "OMP_NUM_THREADS=1"},
        MBAnalytica`Portable`StackArgs[{Global`$ivfBin, "eval-json"}]], All, Global`jsonStr[request]]], $Failed];
    result = If[AssociationQ[process] && process["ExitCode"] === 0,
      Quiet@Check[ImportString[process["StandardOutput"], "RawJSON"], $Failed], $Failed];
    If[!AssociationQ[result], $lastNativeProcess = If[AssociationQ[process],
      KeyTake[process, {"ExitCode", "StandardError"}], <|"Process" -> process|>]],
    Quiet@DeleteDirectory[streams, DeleteContents -> True]];
  result];

(* Rational-letter requests fail closed if a nonlinear factor is encountered;
   only after those cheap orders fail do we enable both algebraic-letter
   flags. All parameters and cube variables have distinct backend names.
   The original contour diagnostic remains mandatory for every candidate. *)
nativeCubeCandidate[cubes_, pars_, seconds_, validator_: (True &)] := Module[
  {values = {}, np, nv, rules, rq, response, parsed, candidate, found, stem, orders, shortOrders, rationalOrders},
  $lastNativeDiagnostics = {};
  stem = "mbParameterNative" <> ToString[$ModuleNumber] <> "x";
  np = Table[Symbol["Global`" <> stem <> "p" <> ToString[i]], {i, Length[pars]}];
  Do[If[c[[2]] === {}, AppendTo[values, c[[1]]]; Continue[]];
    nv = Table[Symbol["Global`" <> stem <> "v" <> ToString[i]], {i, Length[c[[2]]]}];
    rules = Join[Thread[pars -> np], Thread[c[[2]] -> nv]];
    found = False;
    shortOrders = DeleteDuplicates[{nv, Reverse[nv], RotateLeft[nv], RotateRight[nv]}];
    rationalOrders = DeleteDuplicates@Join[shortOrders, If[Length[nv] <= 5, Permutations[nv], {}]];
    orders = Join[({#, False} & /@ rationalOrders), ({#, True} & /@ shortOrders)];
    Do[rq = Global`ivfNativeRequest[
        Global`ivfPolyLogToHlog[(c[[1]] /. rules) /. Global`constToHF], nv, setting[[1]], True, np];
      rq["algebraic_letters"] = setting[[2]]; rq["spectator_algebraic_letters"] = setting[[2]];
      response = parameterNativeRun[rq, Min[45, seconds]];
      If[!AssociationQ[response], AppendTo[$lastNativeDiagnostics, <|"Stage" -> "Process", "Result" -> response,
        "Details" -> $lastNativeProcess|>]; Continue[]];
      parsed = Quiet@Global`parseResp[response];
      If[!AssociationQ[parsed] || !KeyExistsQ[parsed, "val"],
        AppendTo[$lastNativeDiagnostics, <|"Stage" -> "Parse", "Result" -> parsed|>]; Continue[]];
      candidate = Quiet@TimeConstrained[Global`gvExact[parsed["val"]] /.
        {HyperIntica`ZeroInfPeriod[w_List] :> period[w]} /.
        (Reverse /@ Global`constToHF) /. Thread[np -> pars], 20, $Failed];
      AppendTo[$lastNativeDiagnostics, <|"Stage" -> "Candidate", "Exact" -> exactQ[candidate, pars],
        "IntegrationOrder" -> (setting[[1]] /. Thread[nv -> Range[Length[nv]]]), "AlgebraicLetters" -> setting[[2]],
        "ExtraSymbols" -> Complement[symbols[candidate], pars], "Value" -> candidate|>];
      If[exactQ[candidate, pars] && (Length[cubes] > 1 || TrueQ[validator[candidate]]),
        AppendTo[values, candidate]; found = True; Break[]],
      {setting, orders}];
    If[!found, Return[$Failed, Module]], {c, cubes}];
  If[Length[cubes] === 1 || TrueQ[validator[Total[values]]], Total[values], $Failed]];

scaledCubes[ig_, ctr_, vars_, pars_, dom_, points_, seconds_, index_: 1] := Block[{Global`bwsParse, Global`bwsInit, Global`bwsSamplePoint, Global`bwsExpandLogs, Global`bwsVarSymbolQ, Global`bwsFresh,
      Global`$bwsVerbose = False, Global`$bwsM0Scales = {}, Global`$bwsSquaredNow = {},
      Global`$bwsRoleReg = <||>, Global`$bwsSquaredSyms = {}, $cubeCandidateIndex = index},
    Global`bwsParse[f_, vv_] := parseScaled[f, vv, dom];
    Global`bwsVarSymbolQ[s_] := !MemberQ[pars, s] && baseVarSymbolQ[s];
    Global`bwsFresh[pre_] := Module[{s = baseFresh[pre]},
      While[Head[s] =!= Symbol || MemberQ[Join[pars, vars], s], s = baseFresh[pre]]; s];
    Global`bwsInit[p_, vv_, cc_, ss_List] := Module[{tt = baseInit[p, vv, cc, ss]},
      If[tt === $Failed, $Failed, Join[#, <|"kin" -> Join[#["kin"], Lookup[p, "ExternalKin", {}]]|>] & /@ tt]];
    Global`bwsSamplePoint[f_] := Join[baseSample[f], First[points]];
    Global`bwsExpandLogs[f_] := positiveLogExpand[f, dom];
    TimeConstrained[parameterCubes[ig, ctr, vars], Min[60, seconds], $Failed]];

(* A sufficient Stirling bound for a contour homotopy. Equal or opposite
   Gamma slopes cancel in the exponential bound, independent of offsets.
   Nonnegative remaining weights whose directions span the MB space give
   strict exponential decay, uniformly along the finite real deformation.
   More general bounds are deliberately outside this helper's scope. *)
contourDecayCertificate[ig_, vars_, dom_] := Module[
  {directions = {}, weights = {}, leg, multiplicity, vector, scale, unique, net, positive, kin},
  kin = Select[factors[ig], MatchQ[#, _Power] && !FreeQ[#[[2]], Alternatives @@ vars] &];
  If[!AllTrue[kin, FreeQ[#[[1]], Alternatives @@ vars] && affineQ[#[[2]], vars] &&
      prove[#[[1]] > 0, dom] &], Return[None, Module]];
  Do[Which[MatchQ[f, _Gamma], leg = f[[1]]; multiplicity = 1,
    MatchQ[f, Power[_Gamma, _Integer]], leg = f[[1, 1]]; multiplicity = f[[2]],
    FreeQ[f, Gamma[l_] /; !FreeQ[l, Alternatives @@ vars]], Continue[],
    True, Return[None, Module]];
    If[FreeQ[leg, Alternatives @@ vars], Continue[]];
    If[!affineQ[leg, vars], Return[None, Module]];
    vector = Coefficient[leg, #] & /@ vars;
    If[!AllTrue[vector, MatchQ[#, _Integer | _Rational] &], Return[None, Module]];
    scale = First[DeleteCases[vector, 0]];
    AppendTo[directions, vector/scale]; AppendTo[weights, multiplicity Abs[scale]], {f, factors[ig]}];
  unique = DeleteDuplicates[directions];
  net = Table[Total[Pick[weights, (# === d & /@ directions)]], {d, unique}];
  If[!AllTrue[net, TrueQ[# >= 0] &], Return[None, Module]];
  positive = Pick[unique, Positive /@ net];
  If[positive === {} || MatrixRank[positive] =!= Length[vars], Return[None, Module]];
  <|"StrictExponentialDecay" -> True, "Directions" -> unique, "Weights" -> net|>];

(* A second sufficient Stirling bound: when, for every MB variable z_k, the numerator legs in z_k alone outweigh all
   reciprocal legs together (each counted with its power times the modulus of its coefficient of z_k), the integrand
   decays exponentially in every direction.  Numerator legs of several variables only add decay, and polygamma and
   rational factors grow at most polynomially *)
coordinateDecayCertificate[ig_, vars_, dom_] := Module[
  {kin, own = ConstantArray[0, Length[vars]], against = ConstantArray[0, Length[vars]], leg, multiplicity, vector},
  kin = Select[factors[ig], MatchQ[#, _Power] && !FreeQ[#[[2]], Alternatives @@ vars] &];
  If[!AllTrue[kin, FreeQ[#[[1]], Alternatives @@ vars] && affineQ[#[[2]], vars] &&
      prove[#[[1]] > 0, dom] &], Return[None, Module]];
  Do[Which[MatchQ[f, _Gamma], leg = f[[1]]; multiplicity = 1,
    MatchQ[f, Power[_Gamma, _Integer]], leg = f[[1, 1]]; multiplicity = f[[2]],
    FreeQ[f, Gamma[l_] /; !FreeQ[l, Alternatives @@ vars]], Continue[],
    True, Return[None, Module]];
    If[FreeQ[leg, Alternatives @@ vars], Continue[]];
    If[!affineQ[leg, vars], Return[None, Module]];
    vector = Coefficient[leg, #] & /@ vars;
    If[!AllTrue[vector, MatchQ[#, _Integer | _Rational] &], Return[None, Module]];
    Which[
      multiplicity < 0, against = against + Abs[multiplicity] Abs[vector],
      Count[vector, Except[0]] === 1, own = own + multiplicity Abs[vector]], {f, factors[ig]}];
  If[!AllTrue[own - against, TrueQ[# > 0] &], Return[None, Module]];
  <|"StrictExponentialDecay" -> True, "Bound" -> "CoordinateDominance", "Own" -> own, "Against" -> against|>];

(* The order of the poles that the factors with the argument l give on its hyperplanes l = 0, -1, -2, ...: each
   Gamma[l] counts its power, each PolyGamma[m, l] counts m + 1 per power, and a reciprocal Gamma[l] counts its negative
   power.  Missing[] when a Gamma or polygamma function is not a plain factor of the integrand (a sum, or a nested
   argument), so that the caller keeps its stricter test *)
legPoleOrder[ig_, l_] := Module[{order = 0},
  Do[Which[
    f === Gamma[l], order += 1,
    MatchQ[f, Power[Gamma[l], _Integer]], order += f[[2]],
    MatchQ[f, PolyGamma[_Integer, l]], order += f[[1]] + 1,
    MatchQ[f, Power[PolyGamma[_Integer, l], _Integer?Positive]], order += f[[2]] (f[[1, 1]] + 1),
    MatchQ[f, Gamma[_] | Power[Gamma[_], _Integer] | PolyGamma[_Integer, _] | Power[PolyGamma[_Integer, _], _Integer?Positive]], Null,
    !FreeQ[f, Gamma | PolyGamma], Return[Missing[], Module]],
    {f, factors[ig]}];
  order];

(* Reciprocal Gamma legs at a non-positive integer on the contour are zeros of the integrand: they do not constrain the
   contour, but the Euler constructions and the numerical contour gate stall on them (F3(1, 1; 1, 1; eps; x, y): the
   contour s = t = -1/2 lies on the zero line s + t = -1 of 1/Gamma(s + t), and the exact candidates of every order were
   rejected).  The contour is moved off them along a generic direction, inside its pole chamber, every wall keeping at
   least half of its margin, with a decay certificate for the homotopy; None when no certificate or no such point *)
moveOffZeroLegs[ig_, ctr_, vars_, walls_, zeroLegs_, dom_] := Module[{decay, directions, bounds, tau, point},
  decay = contourDecayCertificate[ig, vars, dom];
  If[!AssociationQ[decay], decay = coordinateDecayCertificate[ig, vars, dom]];
  If[!AssociationQ[decay], Return[None, Module]];
  directions = Table[Table[1/Prime[i + j], {i, Length[vars]}], {j, 0, 5}];
  Do[
    bounds = Table[With[{x = w[[1]] /. ctr, gd = (Coefficient[w[[1]], #] & /@ vars) . d},
      If[gd === 0, Infinity,
        Min[If[w[[2]] === -Infinity, Infinity, x - w[[2]]], If[w[[3]] === Infinity, Infinity, w[[3]] - x]]/(2 Abs[gd])]],
      {w, walls}];
    tau = Min[Append[bounds, 1/10]];
    point = Thread[vars -> ((vars /. ctr) + tau d)];
    If[AllTrue[walls, TrueQ[#[[2]] < (#[[1]] /. point) < #[[3]]] &] && AllTrue[zeroLegs, !IntegerQ[# /. point] &],
      Return[<|"OriginalContour" -> ctr, "Contour" -> point, "Walls" -> walls, "SamePoleChamber" -> True,
        "DecayCertificate" -> decay, "ReciprocalZerosAvoided" -> zeroLegs|>, Module]],
    {d, directions}];
  None];

(* The contour of an expanded MB integral is moved off the zero lines of its reciprocal Gamma functions before the
   integrand is split into terms.  The sum is regular there, but a single term can have a pole on such a line: for
   F3(1, 1; 1, 1; eps; x, y), the contour s = t = -1/2 of MBresolve lies on the line s + t = -1, on which the term
   PolyGamma[0, s + t]^2/Gamma[s + t] of the expansion of 1/Gamma(eps + s + t) is singular.  The new contour stays
   inside the pole chamber of the numerator Gamma functions and of the rational factors, so that the sum of the terms
   keeps its value; the contour is returned unchanged when no reciprocal Gamma function lies on a zero line *)
offZeroContour[integrand_, ctr_, vars_, dom_] := Module[{expanded, terms, numerator, reciprocal, rational, zeroLegs,
    walls = {}, moved},
  If[vars === {}, Return[ctr, Module]];
  expanded = Expand[integrand];
  terms = If[Head[expanded] === Plus, List @@ expanded, {expanded}];
  numerator = DeleteDuplicates[Flatten[Map[Cases[factors[#], Gamma[l_] | Power[Gamma[l_], _Integer?Positive] :> l] &, terms]]];
  reciprocal = DeleteDuplicates[Flatten[Map[Cases[factors[#], Power[Gamma[l_], _Integer?Negative] :> l] &, terms]]];
  numerator = Select[numerator, !FreeQ[#, Alternatives @@ vars] &];
  reciprocal = Select[reciprocal, !FreeQ[#, Alternatives @@ vars] &];
  zeroLegs = Select[reciprocal, With[{x = # /. ctr}, IntegerQ[x] && x <= 0] &];
  If[zeroLegs === {}, Return[ctr, Module]];
  If[!AllTrue[Join[numerator, zeroLegs], affineQ[#, vars] &], Return[ctr, Module]];
  rational = Cases[terms, Power[q_, k_Integer?Negative] /; PolynomialQ[q, vars] && !FreeQ[q, Alternatives @@ vars] :> q, {0, Infinity}];
  rational = DeleteDuplicates@Flatten[First /@ Select[FactorList[#], !FreeQ[First[#], Alternatives @@ vars] &] & /@ rational];
  If[!AllTrue[rational, affineQ[#, vars] &], Return[ctr, Module]];
  Do[With[{x = l /. ctr},
    If[!MatchQ[x, _Rational | _Integer] || (IntegerQ[x] && x <= 0), Return[ctr, Module]];
    AppendTo[walls, {l, If[x > 0, 0, Floor[x]], If[x > 0, Infinity, Ceiling[x]]}]], {l, numerator}];
  Do[With[{x = l /. ctr},
    If[!MatchQ[x, _Rational | _Integer] || x === 0, Return[ctr, Module]];
    AppendTo[walls, {l, If[x > 0, 0, -Infinity], If[x > 0, Infinity, 0]}]], {l, rational}];
  moved = moveOffZeroLegs[First[terms], ctr, vars, walls, zeroLegs, dom];
  If[AssociationQ[moved], moved["Contour"], ctr]];

(* A numerical resolver can choose a contour arbitrarily close to a pole.
   Move only within its exact affine pole chamber, and record the proof.
   Reciprocal-Gamma zeros are also kept in their bands (a stronger condition
   than necessary). The new point is an interior convex combination, avoiding
   gratuitous integral coordinates from an LP vertex. *)
centerParameterContour[ig_, ctr_, vars_, dom_: True] := Module[
  {legs, rational, walls = {}, zeroLegs = {}, rows = {}, rhs = {}, values, margins, oldMargin,
   constant, gradient, sol, point, valid, decay},
  If[vars === {}, Return[None, Module]];
  legs = DeleteDuplicates@Cases[ig, Gamma[l_] :> l, {0, Infinity}];
  legs = Union[legs, Cases[ig, PolyGamma[_, l_] :> l, {0, Infinity}]];
  legs = Select[legs, !FreeQ[#, Alternatives @@ vars] &];
  rational = Cases[ig, Power[p_, k_Integer?Negative] /; PolynomialQ[p, vars] :> p, {0, Infinity}];
  rational = DeleteDuplicates@Flatten[First /@ Select[FactorList[#], !FreeQ[First[#], Alternatives @@ vars] &] & /@ rational];
  If[!AllTrue[Join[legs, rational], affineQ[#, vars] &&
      AllTrue[Last /@ CoefficientRules[#, vars], MatchQ[#, _Rational | _Integer] &] &], Return[None, Module]];
  Do[With[{x = l /. ctr},
    If[!MatchQ[x, _Rational | _Integer], Return[None, Module]];
    (* a non-positive integer of a reciprocal Gamma is a zero of the integrand, not a pole *)
    If[IntegerQ[x] && x <= 0 && TrueQ[legPoleOrder[ig, l] <= 0], AppendTo[zeroLegs, l]; Continue[]];
    If[IntegerQ[x] && x <= 0, Return[fail["Gamma or polygamma pole lies on the supplied contour."], Module]];
    AppendTo[walls, {l, If[x > 0, 0, Floor[x]], If[x > 0, Infinity, Ceiling[x]]}]], {l, legs}];
  Do[With[{x = l /. ctr},
    If[!MatchQ[x, _Rational | _Integer] || x === 0, Return[None, Module]];
    AppendTo[walls, {l, If[x > 0, 0, -Infinity], If[x > 0, Infinity, 0]}]], {l, rational}];
  If[zeroLegs =!= {}, Return[moveOffZeroLegs[ig, ctr, vars, walls, zeroLegs, dom], Module]];
  If[walls === {}, Return[None, Module]];
  margins = Flatten[Table[With[{x = w[[1]] /. ctr},
    {If[w[[2]] === -Infinity, Infinity, x - w[[2]]], If[w[[3]] === Infinity, Infinity, w[[3]] - x]}], {w, walls}]];
  oldMargin = Min[margins]; If[!TrueQ[0 < oldMargin < 1/10], Return[None, Module]];
  decay = contourDecayCertificate[ig, vars, dom];
  If[!AssociationQ[decay], Return[None, Module]];
  Do[constant = w[[1]] /. Thread[vars -> 0]; gradient = Coefficient[w[[1]], #] & /@ vars;
    If[w[[2]] =!= -Infinity, AppendTo[rows, Append[gradient, -1]]; AppendTo[rhs, {w[[2]] - constant, 1}]];
    If[w[[3]] =!= Infinity, AppendTo[rows, Append[-gradient, -1]]; AppendTo[rhs, {constant - w[[3]], 1}]], {w, walls}];
  sol = Quiet@Check[LinearProgramming[Append[ConstantArray[0, Length[vars]], -1], rows, rhs,
    Append[Table[{-Infinity, Infinity}, {Length[vars]}], {0, 1/2}], Method -> "Simplex"], $Failed];
  If[!ListQ[sol] || Length[sol] =!= Length[vars] + 1 || !TrueQ[Last[sol] > 2 oldMargin], Return[None, Module]];
  point = Thread[vars -> (3 Most[sol] + (vars /. ctr))/4];
  valid = And @@ Table[TrueQ[w[[2]] < (w[[1]] /. point) < w[[3]]], {w, walls}];
  If[!valid, Return[None, Module]];
  <|"OriginalContour" -> ctr, "Contour" -> point, "Walls" -> walls,
    "SamePoleChamber" -> True, "DecayCertificate" -> decay,
    "OriginalMargin" -> oldMargin, "OptimalMargin" -> Last[sol]|>];

(* Normalize only Gamma families shared by numerator and denominator. Their
   rational affine arguments differ by integers, so the recurrence gives
   finite products exactly. Cancel those products together before constructing
   Euler variables; treating each quotient separately can hide cancellations. *)
gammaQuotientNormalize[f_, vars_] := Module[
  {zero, num = {}, den = {}, valid, base, common, legs, rules, k, b, value},
  If[vars === {}, Return[None, Module]];
  zero = Thread[vars -> 0];
  Do[Which[
    MatchQ[q, Gamma[_]], AppendTo[num, q[[1]]],
    MatchQ[q, Power[Gamma[_], _Integer?Positive]], AppendTo[num, q[[1, 1]]],
    MatchQ[q, Power[Gamma[_], _Integer?Negative]], AppendTo[den, q[[1, 1]]]], {q, factors[f]}];
  valid[l_] := !FreeQ[l, Alternatives @@ vars] && affineQ[l, vars] &&
    MatchQ[l /. zero, _Integer | _Rational] && Abs[Floor[l /. zero]] <= 32;
  base[l_] := Expand[l - Floor[l /. zero]];
  num = Select[num, valid]; den = Select[den, valid];
  common = Intersection[base /@ num, base /@ den];
  If[common === {}, Return[None, Module]];
  legs = Select[Union[num, den], MemberQ[common, base[#]] &];
  rules = Table[k = Floor[l /. zero]; b = base[l];
    Gamma[l] -> Gamma[b] If[k >= 0, Product[b + j, {j, 0, k - 1}],
      1/Product[b + j, {j, k, -1}]], {l, legs}];
  value = Cancel[f /. rules];
  If[value === f || !FreeQ[value, Indeterminate | ComplexInfinity | _DirectedInfinity], Return[None, Module]];
  <|"Expression" -> value, "Proof" -> <|"Class" -> "FiniteGammaRecurrenceCancellation",
    "Rules" -> rules, "SharedAffineFamilies" -> common|>|>];

(* This memo contains only source-derived successes from the current public
   call. Recursive reductions share it, but it is never a persistent answer
   bank. The timeout covers the complete recursive coefficient calculation. *)
closePiece[ig_, ctr_, vars_, pars_, dom_, seconds_] := Module[{key, saved, value, centered, evaluationContour, normalized, kernel},
  If[!AssociationQ[$closureMemo],
    Return[Block[{$closureMemo = <||>, $fixedBarnesMemo = <||>, $sourceGateSamples = <||>},
      closePiece[ig, ctr, vars, pars, dom, seconds]], Module]];
  key = Hash[{ig, ctr, vars, pars, dom}, "SHA256"];
  saved = Lookup[$closureMemo, key, None];
  If[AssociationQ[saved], $lastSourceGate = saved["Gate"]; Return[saved["Value"], Module]];
  (* a kinematic power b^(c + l(z)) with a constant non-integer offset c (the half-integer powers of the K legs of
     cosmological trees, u^(-1/2 - z)) is the constant b^c times b^l(z): the Euler construction needs integer
     exponents after the eliminations, so the constant is taken out of the kernel and multiplied back *)
  (* the split result is returned from closePiece itself, not from an inner Module *)
  value = Module[{split = splitKinematicConstants[ig, vars, dom], inner},
    If[split[[1]] === 1, None,
      inner = closePiece[split[[2]], ctr, vars, pars, dom, seconds];
      If[!FailureQ[inner] && inner =!= $Failed,
        inner = split[[1]] inner;
        $lastSourceGate = Join[If[AssociationQ[$lastSourceGate], $lastSourceGate, <||>], <|"KinematicConstantFactor" -> split[[1]]|>];
        AssociateTo[$closureMemo, key -> <|"Value" -> inner, "Gate" -> $lastSourceGate|>]];
      inner]];
  If[value =!= None, Return[value, Module]];
  normalized = gammaQuotientNormalize[ig, vars];
  kernel = If[AssociationQ[normalized], normalized["Expression"], ig];
  centered = centerParameterContour[kernel, ctr, vars, dom];
  If[FailureQ[centered], Return[centered, Module]];
  evaluationContour = If[AssociationQ[centered], centered["Contour"], ctr];
  value = TimeConstrained[closePieceUncached[kernel, evaluationContour, vars, pars, dom, seconds],
    seconds, fail["Coefficient closure timed out.", <|"SecondsAllowed" -> seconds|>]];
  (* the last fallback: the trig-pair Barnes-to-Euler closer (mbeParameterTrigPairRung.m), with its own exactness
     contract and source gate *)
  If[FailureQ[value] && DownValues[trigPairClose] =!= {},
    Module[{pairValue},
      pairValue = trigPairClose[kernel, evaluationContour, vars, pars, dom, seconds];
      If[pairValue =!= $Failed,
        value = pairValue;
        $lastSourceGate = Join[$lastSourceGate, <|"TrigPairEulerCloser" -> True|>]]]];
  If[AssociationQ[centered], $lastSourceGate = Join[$lastSourceGate,
    <|"PoleChamberDeformation" -> centered|>]];
  If[AssociationQ[normalized], $lastSourceGate = Join[$lastSourceGate,
    <|"GammaNormalization" -> normalized["Proof"]|>]];
  If[!FailureQ[value] && exactQ[value, pars],
    AssociateTo[$closureMemo, key -> <|"Value" -> value, "Gate" -> $lastSourceGate|>]];
  value];

closePieceUncached[ig_, ctr_, vars_, pars_, dom_, seconds_] := Module[{points, cv, raw, val, direct, attempts = {}, alt, cubesKey, nativeTried = False},
  $lastSourceGate = <||>;
  $lastNativeDiagnostics = {};
  If[vars === {}, Return[ig, Module]];
  If[(Length[vars] === 3 || Length[vars] > 5) && DownValues[transverseClose] =!= {},
    (* A three-fold already has a direct source gate. Bound the optional
       transverse search so that one difficult branch cannot consume the
       entire coefficient budget before its Euler construction is tried. *)
    direct = If[Length[vars] === 3,
      TimeConstrained[transverseClose[ig, ctr, vars, pars, dom, seconds], Min[60, seconds/2], $Failed],
      transverseClose[ig, ctr, vars, pars, dom, seconds]];
    If[direct =!= $Failed, Return[direct, Module]]];
  (* Four- and five-fold coefficients follow the successful research
     workflow: construct their Euler cubes directly first. Transverse
     reductions remain a fallback when that construction or closure fails. *)
  If[Length[vars] > 5, Return[fail["Coupled parameter source gate supports at most five remaining MB folds after transverse reduction."], Module]];
  points = parameterPoints[pars, dom]; If[Length[points] < 2, Return[fail["Could not select two parameter points satisfying the domain."], Module]];
  direct = slopeTwo[ig, ctr, vars, dom];
  If[direct =!= $Failed && exactQ[direct, pars] && sourceGate[ig, ctr, vars, direct, pars, points], Return[direct, Module]];
  If[DownValues[sixGammaClose] =!= {},
    direct = sixGammaClose[ig, ctr, vars, pars, dom];
    If[direct =!= $Failed, Return[direct, Module]]];
  If[FreeQ[ig, Alternatives @@ pars],
    direct = Quiet@TimeConstrained[Block[{Global`$bwsVerbose = False}, Global`bwsClose[ig, ctr, vars]], Min[30, seconds], $Failed];
    If[exactQ[direct, {}] && sourceGate[ig, ctr, vars, direct, pars, points], Return[direct, Module]]];
  cv = scaledCubes[ig, ctr, vars, pars, dom, points, seconds];
  $lastParameterCubes = cv;
  If[!ListQ[cv],
    If[DownValues[transverseClose] =!= {},
      direct = transverseClose[ig, ctr, vars, pars, dom, seconds];
      If[direct =!= $Failed, Return[direct, Module]]];
    Return[fail["Scaled Barnes-to-Euler construction refused."], Module]];
  If[AnyTrue[cv, Length[#[[2]]] >= 3 &],
    nativeTried = True;
    val = nativeCubeCandidate[cv, pars, seconds, Function[q, sourceGate[ig, ctr, vars, q, pars, points]]];
    If[val =!= $Failed && exactQ[val, pars], Return[val, Module]]];
  Do[raw = Table[Quiet@TimeConstrained[
      Block[{HyperIntica`$NoAlgebraicRootsContributions = False, HyperIntica`$HyperAlgebraicRoots = True,
             HyperIntica`$QuietPrint = True},
        HyperIntica`HyperIntica[c[[1]], (# -> {0, 1} & /@ If[rev, Reverse[c[[2]]], c[[2]]])]],
      Min[45, seconds/3], $Failed], {c, cv}];
    val = Expand[Total[raw] /. HyperIntica`ZeroInfPeriod[w_List] :> period[w]];
    If[exactQ[val, pars] && sourceGate[ig, ctr, vars, val, pars, points], Return[val, Module]], {rev, {False, True}}];
  If[!nativeTried,
    val = nativeCubeCandidate[cv, pars, seconds, Function[q, sourceGate[ig, ctr, vars, q, pars, points]]];
    If[val =!= $Failed && exactQ[val, pars], Return[val, Module]]];
  If[DownValues[rationalizedCubeCandidate] =!= {},
    val = rationalizedCubeCandidate[cv, ig, ctr, vars, pars, dom, points, seconds];
    If[val =!= $Failed, Return[val, Module]]];
  cubesKey[cc_] := Hash[(#[[1]] /. Thread[#[[2]] -> Array[Slot, Length[#[[2]]]]]) & /@ cc];
  alt = scaledCubes[ig, ctr, vars, pars, dom, points, seconds, 2];
  If[ListQ[alt] && cubesKey[alt] =!= cubesKey[cv],
    val = nativeCubeCandidate[alt, pars, seconds, Function[q, sourceGate[ig, ctr, vars, q, pars, points]]];
    If[val =!= $Failed && exactQ[val, pars], Return[val, Module]];
    If[DownValues[rationalizedCubeCandidate] =!= {},
      val = rationalizedCubeCandidate[alt, ig, ctr, vars, pars, dom, points, seconds];
      If[val =!= $Failed, Return[val, Module]]]];
  If[DownValues[transverseClose] =!= {},
    direct = transverseClose[ig, ctr, vars, pars, dom, seconds];
    If[direct =!= $Failed, Return[direct, Module]]];
  fail["Euler candidate failed exactness or independent contour validation.", <|"SourceGate" -> $lastSourceGate,
    "CubeDimensions" -> (Length[#[[2]]] & /@ cv), "NativeDiagnostics" -> $lastNativeDiagnostics|>]];

MBParameterClosePiece[ig_, ctr_List, vars_List, OptionsPattern[]] := Module[{pars, dom, c, streams, result, exactContour},
  pars = OptionValue["ExternalParameters"]; dom = OptionValue["ParameterAssumptions"];
  If[Sort[First /@ ctr] =!= Sort[vars] || Intersection[vars, pars] =!= {} ||
    !AllTrue[Last /@ ctr, NumericQ], Return[fail["Invalid contour or overlapping variable roles."], Module]];
  c = contract[ig, Unique["unusedEpsilon"], pars, dom, vars];
  If[FailureQ[c], Return[c, Module]];
  (* Exact binary-rational values preserve the supplied contour. This is not
     a contour deformation or a guessed nearby small rational. *)
  exactContour = ctr /. r_Real :> SetPrecision[r, Infinity];
  streams = CreateDirectory[];
  result = Block[{$closureMemo = <||>, $fixedBarnesMemo = <||>, $sourceGateSamples = <||>,
      ProcessLink`Private`$TempPrefix = FileNameJoin[{streams, "wl-stream-"}]},
    TimeConstrained[closePiece[ig, exactContour, vars, pars, dom, OptionValue["ParameterTimeConstraint"]],
      OptionValue["ParameterTimeConstraint"], fail["Coefficient closure timed out."]]];
  Quiet@DeleteDirectory[streams, DeleteContents -> True];
  If[!FailureQ[result] && !exactQ[result, pars],
    fail["Coefficient result failed the exact parameter-result contract."], result]];

resolvedExpansion[f_, ep_, c_, lo_, hi_, seconds_] := Module[
  {rr, xx, rows, ctr, vars, terms, power, coefficient, constant, kernel, value, key, memo = <||>, total = 0, count = 0, checks = <||>, validResolution},
  validResolution[r_] := ListQ[r] && FreeQ[r, Indeterminate | $Failed | $TimedOut | ComplexInfinity | _DirectedInfinity | _Part] &&
    AllTrue[r, MatchQ[#, MB`MBint[_, {_, _List}]] &];
  rr = If[DownValues[parameterResolve] =!= {}, parameterResolve[f, ep, seconds],
    If[DownValues[withParameterResidues] === {}, Quiet@MB`MBresolve[f, ep],
    withParameterResidues[Quiet@If[DownValues[Global`mbeRCResolveOrig] === {},
      MB`MBresolve[f, ep], Global`mbeRCResolveOrig[f, ep]]]]];
  If[DownValues[parameterResolve] === {} && !validResolution[rr] && DownValues[Global`mbeLPFindResiduesOrig] =!= {},
    rr = Internal`InheritedBlock[{MB`Private`MBfindResidues},
      DownValues[MB`Private`MBfindResidues] = DownValues[Global`mbeLPFindResiduesOrig] /.
        HoldPattern[Global`mbeLPFindResiduesOrig] -> MB`Private`MBfindResidues;
      Quiet@TimeConstrained[If[DownValues[withParameterResidues] === {}, MB`MBresolve[f, ep],
        withParameterResidues[If[DownValues[Global`mbeRCResolveOrig] === {},
          MB`MBresolve[f, ep], Global`mbeRCResolveOrig[f, ep]]]], Min[180, seconds], $TimedOut]];
    AppendTo[$trace, <|"Class" -> "ValidatedResolutionRetry", "Method" -> "Original MBfindResidues",
      "Valid" -> validResolution[rr]|>]];
  If[!validResolution[rr], Return[fail["Parameter MBresolve failed validation, including its original-resolver retry."], Module]];
  If[ListQ[$parameterResidueRepairs] && $parameterResidueRepairs =!= {},
    AppendTo[$trace, <|"Class" -> "ParameterResidueNormalization", "Repairs" -> $parameterResidueRepairs|>]];
  xx = Quiet@MB`MBexpand[rr, 1, {ep, 0, hi}];
  If[!ListQ[xx] || !AllTrue[xx, MatchQ[#, MB`MBint[_, {_, _List}]] &], Return[fail["Parameter MBexpand failed."], Module]];
  Do[ctr = part[[2, 2]] /. r_Real :> SetPrecision[r, Infinity]; vars = First /@ ctr;
    ctr = offZeroContour[part[[1]], ctr, vars, c["Assumptions"]];
    terms = If[Head[Expand[part[[1]]]] === Plus, List @@ Expand[part[[1]]], {Expand[part[[1]]]}];
    Do[power = Exponent[Numerator[Together[tm]], ep] - Exponent[Denominator[Together[tm]], ep];
      If[!IntegerQ[power], Return[fail["Noninteger Laurent order."], Module]];
      If[power < lo || power > hi, Continue[]];
      coefficient = Cancel[tm/ep^power];
      If[!FreeQ[coefficient, ep], Return[fail["Regulator remained in a coefficient."], Module]];
      constant = Times @@ Select[factors[coefficient], FreeQ[#, Alternatives @@ vars] &];
      kernel = Times @@ Select[factors[coefficient], !FreeQ[#, Alternatives @@ vars] &];
      key = Hash[{kernel, ctr, c["Parameters"], c["Assumptions"]}, "SHA256"];
      $LastParameterRun = Join[$LastParameterRun, <|"CurrentCoefficient" -> <|
        "Order" -> power, "Kernel" -> kernel, "Contour" -> ctr, "ClosedKernelCount" -> Length[memo]|>|>];
      If[StringQ[$parameterProgressFile], Quiet@Put[$LastParameterRun["CurrentCoefficient"], $parameterProgressFile]];
      (* per-kernel budget by fold count; the whole expansion stays bounded by the call's ParameterTimeConstraint *)
      value = If[KeyExistsQ[$pieceValues, key], $pieceValues[key],
        closePiece[kernel, ctr, vars, c["Parameters"], c["Assumptions"],
          Min[Which[Length[vars] >= 4, 1200, Length[vars] === 3, 600, True, 120], seconds]]];
      If[FailureQ[value], Return[fail["An expanded coefficient kernel failed; no partial result returned.",
        <|"Order" -> power, "Kernel" -> kernel, "Contour" -> ctr, "Cause" -> value, "ClosedKernelCount" -> Length[memo]|>], Module]];
      If[!KeyExistsQ[$pieceValues, key], AssociateTo[$pieceChecks, key -> <|"Kernel" -> kernel,
        "Contour" -> ctr, "Variables" -> vars, "SourceGate" -> If[vars === {}, "ZeroFold", $lastSourceGate]|>]];
      AssociateTo[checks, key -> $pieceChecks[key]]; AssociateTo[$pieceValues, key -> value];
      AssociateTo[memo, key -> value]; total += constant ep^power value; count++, {tm, terms}], {part, xx}];
  AppendTo[$trace, <|"Class" -> "ResolvedScaledEuler", "ResolvedPieces" -> Length[rr],
    "CoefficientTerms" -> count, "DistinctKernels" -> Length[memo], "KernelChecks" -> checks,
    "RootContributionsRetained" -> True|>]; total];
End[];
EndPackage[];
Print["[mbeParameterEulerRung] parameter scales, aligned psi cubes, retained roots, independent source gate."];
