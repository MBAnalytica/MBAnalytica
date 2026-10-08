(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Syed Mehedi Hasan, Taushif Ahmed, Andreas Rapakoulias, Sumit Banik. *)
(* mbe_strategy_dispatch_v2.m -- exact, fail-closed Standard-route planner.
   The certified library is queried by MB2MPL before this sidecar.  On a miss,
   this module normalizes, classifies, chooses a producer, certifies an LR
   order when HyperFLINT is used, and returns an exact constant or $Failed.
   Numerical evaluation is never the producer. *)

BeginPackage["MBEStrategy`", {"MBtoMPL`"}];

mbeStdClassify::usage =
"mbeStdClassify[integrand, contour, vars] returns the normalized structural strategy plan without evaluating the integral.";
mbeStdPlan::usage =
"mbeStdPlan[integrand, contour, vars] is an alias for mbeStdClassify.";
mbeStdClose::usage =
"mbeStdClose[integrand, contour, vars] executes the fail-closed Standard-route plan and returns {exactValue, strategy} or {$Failed, strategy}.";
mbeStdLastPlan::usage =
"mbeStdLastPlan[] returns the most recent classification/evaluation ledger.";

Begin["`Private`"];

$mbeHFSeconds = 900;
$mbeIntVolSeconds = 300;
$mbeIntVolDimensionCap = 5;
$mbeDispatchSeconds = 2200;
$mbeDispatchDeadline = Infinity;
$mbeRenameCounter = 0;
$mbeLastPlan = <||>;

ClearAll[mbeGammaArgs, mbePsiArgs, mbeCrossQ, mbeCrossKind,
  mbeNoWindowPairQ, mbeWindowableQ, mbeNumeratorPolynomialQ,
  mbeNormalize, mbeNormalizeIdentityQ, mbePsiPower, mbeAffinePsiQ,
  mbeExactQ, mbeInexactNumberFreeQ, mbeNumericallyEvaluableQ,
  mbeProvedZeroQ,
  mbeResolveAbs, mbeNoSpace,
  mbeStripContexts, mbeSecondsLeft, mbeRunHF,
  mbePrepareCube, mbeDenominatorFactors, mbeAlphabetStrings,
  mbeVerifyLROrder, mbeFindLROrder, mbeFindCommonLROrder, mbeHFWithOrder,
  mbeHFExactCube, mbeCubeNumericSealQ, mbeIntVolExactCube, mbeIntegrateCube,
  mbeReflectDifference, mbeEvalOrdinary, mbeEvalEngineN,
  mbeEvalGroupedCohort, mbeEvalEngineNGrouped, mbeEvalAffineBell,
  mbeExecuteStrategy];

mbeGammaArgs[expression_] :=
  Cases[expression, Gamma[arg_] :> arg, {0, Infinity}];
mbePsiArgs[expression_] :=
  Cases[expression, PolyGamma[_, arg_] :> arg, {0, Infinity}];

mbeCrossQ[arg_, variables_List] :=
  Count[variables, variable_ /; !FreeQ[arg, variable]] >= 2;
mbeCrossKind[arg_, variables_List] := Module[{coefficients, nonzero, signs},
  coefficients = Coefficient[arg, #] & /@ variables;
  nonzero = Select[coefficients, # =!= 0 &];
  If[Length[nonzero] < 2, Return["single"]];
  signs = Quiet[Sign /@ nonzero];
  Which[
    AllTrue[signs, TrueQ[# === 1] &] ||
      AllTrue[signs, TrueQ[# === -1] &], "sum",
    AllTrue[signs, MemberQ[{-1, 1}, #] &], "difference",
    True, "mixed"]
];

mbeNoWindowPairQ[expression_, variables_List] := Module[{arguments},
  arguments = mbeGammaArgs[expression];
  AnyTrue[variables, Function[variable,
    Module[{others = DeleteCases[variables, variable], plus, minus},
      plus = Select[arguments, Coefficient[#, variable] === 1 &&
        FreeQ[# /. variable -> 0, Alternatives @@ others] &];
      minus = Select[arguments, Coefficient[#, variable] === -1 &&
        FreeQ[# /. variable -> 0, Alternatives @@ others] &];
      AnyTrue[plus, Function[positiveArg,
        AnyTrue[minus, TrueQ[Simplify[
          (positiveArg /. variable -> 0) + (# /. variable -> 0)] <= 0] &]]]]]]
];

mbeWindowableQ[expression_, variables_List, contour_List] :=
  AllTrue[mbeGammaArgs[expression], Function[arg,
    FreeQ[arg, Alternatives @@ variables] ||
      TrueQ[NumericQ[arg /. contour] && Re[N[arg /. contour, 30]] > 0]]];

mbeNumeratorPolynomialQ[expression_, variables_List] := Module[{factors},
  factors = If[Head[expression] === Times, List @@ expression, {expression}];
  AnyTrue[factors, Function[factor,
    FreeQ[factor, Gamma | PolyGamma] && PolynomialQ[factor, variables] &&
      Total[Exponent[factor, #] & /@ variables] > 0]]
];

mbePsiPower[expression_] := Module[{terms},
  terms = If[Head[expression] === Plus, List @@ expression, {expression}];
  Max[Join[{0}, Function[term,
      Count[term, _PolyGamma, {0, Infinity}] +
        Total[Cases[term,
          Power[PolyGamma[_, _], power_Integer?Positive] :> power - 1,
          {0, Infinity}]]] /@ terms]]
];

mbeAffinePsiQ[arguments_List, variables_List] := Module[{base},
  If[arguments === {}, Return[False]];
  base = First[arguments];
  AllTrue[Rest[arguments], Function[arg,
    FreeQ[Together[arg - base], Alternatives @@ variables] &&
      IntegerQ[Together[arg - base]]]]
];

mbeNormalizeIdentityQ[before_, after_, contour_List, variables_List] := Module[
  {difference, verdict},
  If[TrueQ[before === after], Return[True]];
  difference = Quiet@TimeConstrained[
    Together[FunctionExpand[before - after]], 120, $TimedOut];
  If[TrueQ[difference === 0] || TrueQ[PossibleZeroQ[difference]],
    Return[True]];
  verdict = Quiet@TimeConstrained[
    FullSimplify[before == after], 120, False];
  TrueQ[verdict]
];

mbeNormalize[expression_, contour_List, variables_List] := Module[
  {candidate = expression},
  If[DownValues[Global`gammaMinN] =!= {},
    candidate = Quiet@TimeConstrained[
      Global`gammaMinN[expression, variables], 120, expression]];
  If[candidate === $Failed || !mbeNormalizeIdentityQ[
      expression, candidate, contour, variables], expression, candidate]
];

mbeNumericallyEvaluableQ[expression_] := Module[{value},
  value = Quiet@TimeConstrained[
    If[DownValues[Global`gvN] =!= {}, Global`gvN[expression],
      N[expression, 30]], 120, $TimedOut];
  NumberQ[value]
];

mbeInexactNumberFreeQ[expression_] :=
  Cases[expression,
    number_?NumberQ /; Precision[Unevaluated[number]] =!= Infinity :> number,
    {0, Infinity}, Heads -> True] === {};

mbeExactQ[expression_, variables_List : {}] :=
  expression =!= $Failed && expression =!= $TimedOut &&
  mbeInexactNumberFreeQ[expression] &&
  FreeQ[expression, $Failed | Indeterminate | ComplexInfinity |
    DirectedInfinity] && FreeQ[expression, Alternatives @@ variables] &&
  Cases[expression,
    symbol_Symbol /; Context[Unevaluated[symbol]] === "Global`" :> symbol,
    {0, Infinity}, Heads -> True] === {} &&
  Cases[expression, head_Symbol[___] /; MemberQ[
    {"ZeroInfPeriod", "HyperInt", "Hlog", "Integrate", "NIntegrate",
     "delta", "Mpl", "mzv"}, SymbolName[Unevaluated[head]]] :> head,
    {0, Infinity}, Heads -> False] === {} &&
  mbeNumericallyEvaluableQ[expression];

(* PossibleZeroQ is a useful simplifier heuristic, but it is too permissive
   for a release-path zero return.  Only a literal exact Together result may
   short-circuit an analytic producer. *)
mbeProvedZeroQ[expression_] := TrueQ[Quiet@Check[
  Together[expression] === 0, False]];

mbeResolveAbs[expression_, variables_List] := Catch[Module[
  {arguments, assumptions, rules = {}, sign},
  arguments = DeleteDuplicates@Cases[expression, Abs[arg_] :> arg,
    {0, Infinity}];
  If[arguments === {}, Throw[expression, "mbeResolveAbs"]];
  assumptions = And @@ Join[Element[#, Reals] & /@ variables,
    Flatten[({0 < #, # < 1} & /@ variables)]];
  Do[
    sign = Quiet@TimeConstrained[
      FullSimplify[Sign[Together[argument]], assumptions], 30, $TimedOut];
    Which[
      TrueQ[sign === 1], AppendTo[rules, Abs[argument] -> argument],
      TrueQ[sign === -1], AppendTo[rules, Abs[argument] -> -argument],
      True, Throw[$Failed, "mbeResolveAbs"]],
    {argument, arguments}];
  Together[expression /. rules]
], "mbeResolveAbs"];

mbeNoSpace[expression_] := StringReplace[
  ToString[expression, InputForm, PageWidth -> Infinity],
  WhitespaceCharacter -> ""];
mbeStripContexts[string_String] := StringReplace[string,
  RegularExpression["[A-Za-z][A-Za-z0-9]*`"] -> ""];

mbeSecondsLeft[requested_Integer] := Module[{remaining},
  remaining = If[NumberQ[$mbeDispatchDeadline],
    Floor[$mbeDispatchDeadline - AbsoluteTime[] - 10], requested];
  Max[0, Min[requested, remaining]]
];

mbeRunHF[body_String, timeout_Integer] := Module[
  {inputFile, outputFile, errorFile, command, exitCode, response, bounded},
  bounded = mbeSecondsLeft[timeout];
  If[bounded < 1, Return[<|"ok" -> False, "reason" -> "budget-exhausted"|>]];
  inputFile = FileNameJoin[{$TemporaryDirectory,
    "mbe_dispatch_in_" <> ToString[$ProcessID] <> ".json"}];
  outputFile = FileNameJoin[{$TemporaryDirectory,
    "mbe_dispatch_out_" <> ToString[$ProcessID] <> ".json"}];
  errorFile = FileNameJoin[{$TemporaryDirectory,
    "mbe_dispatch_err_" <> ToString[$ProcessID] <> ".txt"}];
  If[FileExistsQ[outputFile], Quiet@DeleteFile[outputFile]];
  Export[inputFile, body, "Text"];
  command = "ulimit -s unlimited; timeout " <> ToString[bounded] <>
    " env OMP_NUM_THREADS=1 HF_MAX_THREADS_PER_CALL=1 " <>
    "HF_NARROW_CTX=1 " <> Global`hfBin <>
    " eval-json < " <> inputFile <> " > " <> outputFile <>
    " 2> " <> errorFile;
  exitCode = Run[command];
  If[!FileExistsQ[outputFile] || FileByteCount[outputFile] === 0,
    Return[<|"ok" -> False, "reason" -> "no-response",
      "exitCode" -> exitCode|>]];
  response = Quiet@Check[Import[outputFile, "RawJSON"], $Failed];
  If[!AssociationQ[response],
    <|"ok" -> False, "reason" -> "invalid-json",
      "exitCode" -> exitCode|>,
    <|"ok" -> True, "response" -> response,
      "exitCode" -> exitCode|>]
];

mbePrepareCube[integrand_, variables_List,
    suppliedVariables_: Automatic] := Module[
  {clean, expression, renamedVariables, prefix},
  clean = mbeResolveAbs[integrand, variables];
  If[clean === $Failed, Return[$Failed]];
  If[suppliedVariables === Automatic,
    prefix = "mbeHFp" <> ToString[$ProcessID] <> "c" <>
      ToString[++$mbeRenameCounter] <> "v";
    renamedVariables = Table[
      Symbol["Global`" <> prefix <> ToString[index]],
      {index, Length[variables]}],
    If[!ListQ[suppliedVariables] ||
        Length[suppliedVariables] =!= Length[variables] ||
        !AllTrue[suppliedVariables, Head[#] === Symbol &],
      Return[$Failed]];
    renamedVariables = suppliedVariables];
  expression = clean /. Thread[variables -> renamedVariables];
  expression = (expression /. Thread[renamedVariables ->
      renamedVariables/(1 + renamedVariables)])*
    Times @@ ((1 + #)^-2 & /@ renamedVariables);
  expression = expression /. Global`constToHF;
  <|"Expression" -> expression, "Variables" -> renamedVariables,
    "Names" -> (SymbolName /@ renamedVariables),
    "String" -> mbeStripContexts[mbeNoSpace[expression]]|>
];

mbeDenominatorFactors[expression_] := DeleteDuplicates@Join[
  Cases[{expression}, Power[base_, power_?Negative] :> base,
    {0, Infinity}],
  Cases[{expression}, Log[arg_] :> Numerator[Together[arg]],
    {0, Infinity}],
  Cases[{expression}, Log[arg_] :> Denominator[Together[arg]],
    {0, Infinity}]];

mbeAlphabetStrings[prepared_Association] := Module[
  {variables = prepared["Variables"], candidates, irreducibles},
  candidates = DeleteDuplicates@Flatten[{
    variables, 1 + variables,
    Numerator[Together[#]] & /@ mbeDenominatorFactors[
      prepared["Expression"]],
    Denominator[Together[#]] & /@ mbeDenominatorFactors[
      prepared["Expression"]]}];
  candidates = Select[candidates,
    PolynomialQ[#, variables] &&
      !FreeQ[#, Alternatives @@ variables] && !NumericQ[#] &];
  (* Factor each candidate independently: one malformed candidate must not
     erase an otherwise certified alphabet.  Retaining the candidate on a
     factorisation failure is conservative and lets find_lr_orders reject it. *)
  irreducibles = DeleteDuplicates@Flatten[
    (Quiet@Check[First /@ Rest[FactorList[#]], {#}]) & /@ candidates];
  irreducibles = Select[irreducibles,
    !NumericQ[#] && !FreeQ[#, Alternatives @@ variables] &];
  mbeStripContexts[mbeNoSpace[#]] & /@ irreducibles
];

mbeVerifyLROrder[alphabet_, names_List, order_List, timeout_Integer,
    grouped_: False] := Module[{request, run, response, key, required},
  key = If[TrueQ[grouped], "groups", "polys"];
  request = <|"op" -> "find_lr_orders", key -> alphabet,
    "xvars" -> names, "coeff_vars" -> {},
    "algebraic_letters" -> False, "carry_discharge" -> False,
    "verify_order" -> order|>;
  run = mbeRunHF[Global`jsonStr[request], Min[timeout, 300]];
  If[!TrueQ[run["ok"]], Return[run]];
  response = run["response"];
  (* In strict mode carry-profile fields are intentionally absent from the
     HyperFLINT schema.  Require every field that verify_order itself always
     emits, so a schema downgrade cannot inherit an accepting default. *)
  required = {"schema_version", "hf_version", "order_is_lr",
    "verify_malformed", "verify_blocking_step", "verify_blocking_degree",
    "verify_forbidden_dep", "verify_blocking_letter"};
  If[AllTrue[required, KeyExistsQ[response, #] &] &&
      response["schema_version"] === 2 &&
      TrueQ[response["order_is_lr"]] &&
      !TrueQ[response["verify_malformed"]] &&
      response["verify_blocking_step"] === -1 &&
      response["verify_blocking_degree"] === 0 &&
      !TrueQ[response["verify_forbidden_dep"]] &&
      response["verify_blocking_letter"] === "",
    <|"ok" -> True, "response" -> response|>,
    <|"ok" -> False, "reason" -> "LR-verification-failed",
      "response" -> response|>]
];

mbeFindLROrder[prepared_Association, timeout_Integer] := Module[
  {letters, request, run, response, order, verification},
  letters = mbeAlphabetStrings[prepared];
  If[letters === {}, Return[<|"ok" -> False, "reason" -> "empty-alphabet"|>]];
  request = <|"op" -> "find_lr_orders", "polys" -> letters,
    "xvars" -> prepared["Names"], "coeff_vars" -> {},
    "algebraic_letters" -> False, "carry_discharge" -> False|>;
  run = mbeRunHF[Global`jsonStr[request], Min[timeout, 300]];
  If[!TrueQ[run["ok"]], Return[run]];
  response = run["response"];
  If[TrueQ[Lookup[response, "nolr", True]] ||
      Lookup[response, "best_order", {}] === {},
    <|"ok" -> False, "reason" -> "non-LR",
      "response" -> response|>,
    order = response["best_order"];
    verification = mbeVerifyLROrder[letters, prepared["Names"], order,
      timeout, False];
    If[!TrueQ[verification["ok"]], Return[verification]];
    <|"ok" -> True, "order" -> order,
      "response" -> response, "verification" -> verification["response"]|>]
];

mbeFindCommonLROrder[preparedGroups_List, timeout_Integer] := Module[
  {names, alphabets, request, run, response, order, verification},
  If[preparedGroups === {}, Return[<|"ok" -> False,
    "reason" -> "empty-group-cohort"|>]];
  names = First[preparedGroups]["Names"];
  If[!AllTrue[preparedGroups, Lookup[#, "Names", {}] === names &],
    Return[<|"ok" -> False, "reason" -> "group-variable-mismatch"|>]];
  alphabets = mbeAlphabetStrings /@ preparedGroups;
  If[MemberQ[alphabets, {}], Return[<|"ok" -> False,
    "reason" -> "empty-group-alphabet"|>]];
  request = <|"op" -> "find_lr_orders", "groups" -> alphabets,
    "xvars" -> names, "coeff_vars" -> {},
    "algebraic_letters" -> False, "carry_discharge" -> False|>;
  run = mbeRunHF[Global`jsonStr[request], Min[timeout, 300]];
  If[!TrueQ[run["ok"]], Return[run]];
  response = run["response"];
  If[TrueQ[Lookup[response, "nolr", True]] ||
      Lookup[response, "best_order", {}] === {},
    <|"ok" -> False, "reason" -> "no-common-LR-order",
      "response" -> response|>,
    order = response["best_order"];
    verification = mbeVerifyLROrder[alphabets, names, order, timeout, True];
    If[!TrueQ[verification["ok"]], Return[verification]];
    <|"ok" -> True, "order" -> order,
      "response" -> response, "verification" -> verification["response"]|>]
];

mbeHFWithOrder[prepared_Association, orderNames_List, timeout_Integer,
    checkDivergences_: True] := Module[{request, run, parsed, exact},
  If[Sort[orderNames] =!= Sort[prepared["Names"]], Return[$Failed]];
  request = <|"op" -> "hyperflint", "expr" -> prepared["String"],
    "vars_int" -> orderNames,
    "vars" -> Join[prepared["Names"],
      {"hfEG", "hfPI", "hfZ3", "hfZ5", "hfLOG2"}],
    "vars_int_from" -> ConstantArray["0", Length[orderNames]],
    "vars_int_to" -> ConstantArray["Infinity", Length[orderNames]],
    "mzv_data_path" -> Global`mzvPath,
    "algebraic_letters" -> False,
    "check_divergences" -> checkDivergences,
    "canonical_emission" -> True|>;
  run = mbeRunHF[Global`jsonStr[request], timeout];
  If[!TrueQ[run["ok"]], Return[$Failed]];
  parsed = Global`parseResp[run["response"]];
  If[!TrueQ[parsed["ok"]], Return[$Failed]];
  exact = Global`gvExact[parsed["val"]];
  If[TrueQ[exact === 0] || !mbeExactQ[exact, prepared["Variables"]],
    $Failed, exact]
];

mbeHFExactCube[integrand_, variables_List, timeout_Integer] := Module[
  {prepared, lr},
  If[variables === {}, Return[If[mbeExactQ[integrand], integrand, $Failed]]];
  If[mbeProvedZeroQ[integrand], Return[0]];
  prepared = mbePrepareCube[integrand, variables];
  If[!AssociationQ[prepared], Return[$Failed]];
  lr = mbeFindLROrder[prepared, timeout];
  If[!TrueQ[lr["ok"]], Return[$Failed]];
  mbeHFWithOrder[prepared, lr["order"], timeout, True]
];

mbeCubeNumericSealQ[integrand_, variables_List, exact_] := Module[
  {numericExact, anchor, bounded},
  numericExact = Quiet@TimeConstrained[
    If[DownValues[Global`gvN] =!= {}, Global`gvN[exact], N[exact, 30]],
    120, $TimedOut];
  If[!NumberQ[numericExact], Return[False]];
  bounded = mbeSecondsLeft[120];
  If[bounded < 1, Return[False]];
  anchor = Quiet@TimeConstrained[
    NIntegrate[Evaluate[integrand],
      Evaluate[Sequence @@ ({#, 0, 1} & /@ variables)],
      WorkingPrecision -> 25, AccuracyGoal -> 8, PrecisionGoal -> 8,
      MaxRecursion -> 14,
      Method -> {"GlobalAdaptive", "SymbolicProcessing" -> 0}],
    bounded, $TimedOut];
  NumberQ[anchor] &&
    TrueQ[Abs[numericExact - anchor] < 10^-7*(1 + Abs[anchor])]
];

mbeIntVolExactCube[integrand_, variables_List, timeout_Integer] := Module[
  {clean, result, exact, bounded},
  If[Length[variables] > $mbeIntVolDimensionCap, Return[$Failed]];
  clean = mbeResolveAbs[integrand, variables];
  If[clean === $Failed, Return[$Failed]];
  If[mbeProvedZeroQ[clean], Return[0]];
  bounded = mbeSecondsLeft[timeout];
  If[bounded < 1, Return[$Failed]];
  result = Quiet@TimeConstrained[
    Block[{Global`$IV$UseLibrary = False,
        Global`$IV$Kinematics = <||>},
      Global`IntVolIntegrate[clean, variables,
        "Kinematics" -> <||>, "Certify" -> False, "Verbose" -> False,
        "Timeout" -> bounded]], bounded + 5, $TimedOut];
  If[!AssociationQ[result], Return[$Failed]];
  exact = Lookup[result, "Result", $Failed];
  If[TrueQ[Lookup[result, "Certified", Automatic] === False] ||
      !mbeExactQ[exact, variables] ||
      !mbeCubeNumericSealQ[clean, variables, exact], $Failed, exact]
];

mbeIntegrateCube[integrand_, variables_List] := Module[{value},
  If[variables === {}, Return[If[mbeExactQ[integrand], integrand, $Failed]]];
  If[mbeProvedZeroQ[integrand], Return[0]];
  value = mbeHFExactCube[integrand, variables, $mbeHFSeconds];
  If[value =!= $Failed, Return[value]];
  If[Length[variables] <= $mbeIntVolDimensionCap,
    value = mbeIntVolExactCube[integrand, variables, $mbeIntVolSeconds]];
  If[mbeExactQ[value, variables], value, $Failed]
];

mbeReflectDifference[integrand_, contour_List, variables_List] := Module[
  {crossArguments, reflectedVariable},
  crossArguments = Select[mbeGammaArgs[integrand],
    mbeCrossQ[#, variables] && mbeCrossKind[#, variables] === "difference" &];
  reflectedVariable = SelectFirst[variables, Function[variable,
    AnyTrue[crossArguments, Coefficient[#, variable] < 0 &]], Missing[]];
  If[MissingQ[reflectedVariable], Return[$Failed]];
  {integrand /. reflectedVariable -> -reflectedVariable,
    contour /. (reflectedVariable -> value_) :>
      (reflectedVariable -> -value)}
];

mbeEvalOrdinary[integrand_, contour_List, variables_List] := Catch[Module[
  {converted, rows, values = {}, value},
  converted = Quiet@TimeConstrained[
    MBtoMPL`MBtoEuler[integrand, contour, variables], 300, $TimedOut];
  If[converted === $TimedOut || !AssociationQ[converted] ||
      Lookup[converted, "PartAFailure", None] =!= None,
    Throw[$Failed, "mbeOrdinary"]];
  rows = Lookup[converted, "EulerIntegrands", {}];
  If[rows === {}, Throw[$Failed, "mbeOrdinary"]];
  Do[
    value = mbeIntegrateCube[row[[1]], row[[2]]];
    If[value === $Failed, Throw[$Failed, "mbeOrdinary"]];
    AppendTo[values, value],
    {row, rows}];
  value = Total[values];
  If[mbeExactQ[value, variables], value, $Failed]
], "mbeOrdinary"];

mbeEvalGroupedCohort[cohort_Association] := Catch[Module[
  {groups, variables, firstPrepared, prepared, lr, values = {}, value},
  If[!TrueQ[Lookup[cohort, "IdentityGate", False]] ||
      !TrueQ[Lookup[cohort, "BatchIdentityGate", False]],
    Throw[$Failed, "mbeGrouped"]];
  groups = cohort["Groups"];
  variables = cohort["Variables"];
  If[!ListQ[groups] || groups === {}, Throw[$Failed, "mbeGrouped"]];
  firstPrepared = mbePrepareCube[First[groups], variables];
  If[!AssociationQ[firstPrepared], Throw[$Failed, "mbeGrouped"]];
  prepared = Prepend[
    mbePrepareCube[#, variables, firstPrepared["Variables"]] & /@
      Rest[groups], firstPrepared];
  If[!AllTrue[prepared, AssociationQ], Throw[$Failed, "mbeGrouped"]];
  If[!AllTrue[prepared, Function[item,
      AllTrue[item["Variables"], !FreeQ[item["Expression"], #] &]]],
    Throw[$Failed, "mbeGrouped"]];
  lr = mbeFindCommonLROrder[prepared, $mbeHFSeconds];
  If[!TrueQ[lr["ok"]], Throw[$Failed, "mbeGrouped"]];
  Do[
    (* Each scale class is a shuffle-regularized summand.  Endpoint
       divergences cancel only after the exact cohort sum, so HyperFLINT's
       per-group divergence veto must be disabled here. *)
    value = mbeHFWithOrder[item, lr["order"], $mbeHFSeconds, False];
    If[value === $Failed, Throw[$Failed, "mbeGrouped"]];
    AppendTo[values, value],
    {item, prepared}];
  value = Total[values];
  If[mbeExactQ[value, variables], value, $Failed]
], "mbeGrouped"];

mbeEvalEngineNGrouped[integrand_, contour_List, variables_List] :=
  Catch[Module[{cohorts, values = {}, value},
    If[DownValues[Global`engineNGroupedSubcubes] === {},
      Throw[$Failed, "mbeEngineNGrouped"]];
    cohorts = Quiet@TimeConstrained[
      Global`engineNGroupedSubcubes[<|"Vars" -> variables,
        "Contour" -> contour, "Integrand" -> integrand|>],
      mbeSecondsLeft[900], $TimedOut];
    If[!ListQ[cohorts] || cohorts === {},
      Throw[$Failed, "mbeEngineNGrouped"]];
    If[!AllTrue[cohorts, AssociationQ] ||
        !AllTrue[cohorts,
          TrueQ[Lookup[#, "BatchIdentityGate", False]] &] ||
        !SameQ @@ Lookup[cohorts, "ProducerCount", -1] ||
        First[Lookup[cohorts, "ProducerCount", {-1}]] =!= Length[cohorts],
      Throw[$Failed, "mbeEngineNGrouped"]];
    Do[
      value = mbeEvalGroupedCohort[cohort];
      If[value === $Failed, Throw[$Failed, "mbeEngineNGrouped"]];
      AppendTo[values, value],
      {cohort, cohorts}];
    value = Total[values];
    If[mbeExactQ[value, variables], value, $Failed]
  ], "mbeEngineNGrouped"];

mbeEvalEngineN[integrand_, contour_List, variables_List] := Catch[Module[
  {subcubes, values = {}, value},
  subcubes = Quiet@TimeConstrained[
    Global`engineNSubcubes[<|"Vars" -> variables, "Contour" -> contour,
      "Integrand" -> integrand|>], mbeSecondsLeft[900], $TimedOut];
  If[!ListQ[subcubes] || subcubes === {},
    Throw[$Failed, "mbeEngineN"]];
  Do[
    If[!ListQ[subcube] || Length[subcube] =!= 2 || subcube[[1]] === $Failed,
      Throw[$Failed, "mbeEngineN"]];
    value = mbeIntegrateCube[subcube[[1]], subcube[[2]]];
    If[value === $Failed, Throw[$Failed, "mbeEngineN"]];
    AppendTo[values, value],
    {subcube, subcubes}];
  value = Total[values];
  If[mbeExactQ[value, variables], value, $Failed]
], "mbeEngineN"];

(* A strict hook for a future generic affine-leg Bell producer.  The present
   Standard package first tries it when installed; otherwise it proceeds to
   the universally applicable integral-representation engine. *)
mbeEvalAffineBell[integrand_, contour_List, variables_List] := Module[{value},
  If[DownValues[Global`mbeAffineBellClose] === {}, Return[$Failed]];
  value = Quiet@TimeConstrained[
    Global`mbeAffineBellClose[integrand, contour, variables],
    mbeSecondsLeft[1800], $TimedOut];
  If[mbeExactQ[value, variables], value, $Failed]
];

mbeStdClassify[integrand_, contour_List, variables_List] := Module[
  {normalized, psiArguments, gammaArguments, crossArguments, crossKinds,
   noWindow, windowable, numeratorPolynomial, psiPower, affinePsi,
   strategy, fallbacks, reason},
  normalized = mbeNormalize[integrand, contour, variables];
  psiArguments = mbePsiArgs[normalized];
  gammaArguments = mbeGammaArgs[normalized];
  crossArguments = Select[gammaArguments, mbeCrossQ[#, variables] &];
  crossKinds = DeleteDuplicates[mbeCrossKind[#, variables] & /@ crossArguments];
  noWindow = mbeNoWindowPairQ[normalized, variables];
  windowable = mbeWindowableQ[normalized, variables, contour];
  numeratorPolynomial = mbeNumeratorPolynomialQ[normalized, variables];
  psiPower = mbePsiPower[normalized];
  affinePsi = mbeAffinePsiQ[psiArguments, variables];
  strategy = Which[
    Length[variables] >= 2 && MemberQ[crossKinds, "difference"],
      "EngineN-Difference",
    Length[variables] >= 2 && MemberQ[crossKinds, "sum"],
      "EngineN-Sum",
    psiArguments =!= {} && affinePsi && psiPower >= 2,
      "AffineBell",
    psiArguments =!= {} || noWindow || !windowable || numeratorPolynomial ||
      MemberQ[crossKinds, "mixed"],
      "IntegralRepresentation",
    True, "OrdinaryEuler"];
  fallbacks = Switch[strategy,
    "OrdinaryEuler", {"IntegralRepresentation", "GroupedScaleClass"},
    "AffineBell", {"IntegralRepresentation", "GroupedScaleClass"},
    "EngineN-Difference", {"GroupedScaleClass"},
    "EngineN-Sum", {"GroupedScaleClass"},
    _, {"GroupedScaleClass"}];
  reason = Switch[strategy,
    "EngineN-Difference", "difference cross-Gamma: exact reflection, then engineN",
    "EngineN-Sum", "sum cross-Gamma: engineN with certified LR orders",
    "AffineBell", "higher-power digamma factors on one affine Gamma leg",
    "IntegralRepresentation", "polygamma/no-window/polynomial obstruction",
    _, "positive-window ordinary Euler conversion"];
  <|"Strategy" -> strategy, "Fallbacks" -> fallbacks, "Reason" -> reason,
    "NormalizedIntegrand" -> normalized,
    "NormalizationChanged" -> !TrueQ[normalized === integrand],
    "Features" -> <|"Folds" -> Length[variables],
      "PsiCount" -> Length[psiArguments], "MaxPsiPower" -> psiPower,
      "AffinePsiLeg" -> affinePsi, "CrossKinds" -> crossKinds,
      "NoWindowPair" -> noWindow, "Windowable" -> windowable,
      "NumeratorPolynomial" -> numeratorPolynomial|>|>
];

mbeStdPlan[integrand_, contour_List, variables_List] :=
  mbeStdClassify[integrand, contour, variables];

mbeStdClose[integrand_, contour_List, variables_List] :=
 Block[{$mbeDispatchDeadline = AbsoluteTime[] + $mbeDispatchSeconds},
  Module[{plan, strategy, normalized, attempts, attempted = {},
      value = $Failed, used = None, reflected = $Failed, workIntegrand,
      workContour},
    plan = mbeStdClassify[integrand, contour, variables];
    strategy = plan["Strategy"];
    normalized = plan["NormalizedIntegrand"];
    attempts = DeleteDuplicates[Prepend[plan["Fallbacks"], strategy]];
    If[strategy === "EngineN-Difference",
      reflected = mbeReflectDifference[normalized, contour, variables]];
    Do[
      If[mbeSecondsLeft[1] < 1, Break[]];
      used = attempt;
      AppendTo[attempted, attempt];
      {workIntegrand, workContour} =
        If[strategy === "EngineN-Difference" &&
            MemberQ[{"EngineN-Difference", "GroupedScaleClass"}, attempt],
          If[ListQ[reflected] && Length[reflected] === 2,
            reflected, {$Failed, contour}],
          {normalized, contour}];
      value = Switch[attempt,
        "OrdinaryEuler",
          mbeEvalOrdinary[workIntegrand, workContour, variables],
        "AffineBell",
          mbeEvalAffineBell[workIntegrand, workContour, variables],
        "IntegralRepresentation" | "EngineN-Sum" | "EngineN-Difference",
          If[workIntegrand === $Failed, $Failed,
            mbeEvalEngineN[workIntegrand, workContour, variables]],
        "GroupedScaleClass",
          If[workIntegrand === $Failed, $Failed,
            mbeEvalEngineNGrouped[workIntegrand, workContour, variables]],
        _, $Failed];
      If[mbeExactQ[value, variables], Break[], value = $Failed],
      {attempt, attempts}];
    If[!mbeExactQ[value, variables], value = $Failed; used = None];
    $mbeLastPlan = Append[plan, <|"ExecutedStrategy" -> used,
      "AttemptedStrategies" -> attempted,
      "Closed" -> (value =!= $Failed)|>];
    {value, used}
  ]
 ];

mbeStdLastPlan[] := $mbeLastPlan;

End[];
EndPackage[];
