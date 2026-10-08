(* AUTHORSHIP (release R2, 2026-09-07): part of the IntVol package (exact endpoint / interior-wall / weight-two gauge modules of the Euler-integral backend). Author: Syed Mehedi Hasan. *)
(* Exact monodromy-variation prototype for a single moving GPL wall.
   Supported crossing words are {wall} and {a,wall}; all branch-sensitive
   weight-one normalizations require strict positivity on the full cell. *)

ClearAll[IVEW$GPLMake, IVEW$Evaluate];

IVEW$GPLMake[head_, letters_List, argument_] :=
  Apply[head, Join[letters, {argument}]];

IVEW$Evaluate[antiderivative_, x_, {lo_, hi_}, cellVariables_List,
    wall_] := Module[
  {ad = antiderivative, variables, cellPredicate, fullVariables,
   fullPredicate, variableLetterGPLs, variableLogArguments,
   variablePositiveGates, variableRules, positiveAd, argumentGPLs,
   crossingGPLs, unsupportedCrossingGPLs, monodromyParameter,
   continuationRules, continuedAd, variationPolynomial,
   variationDegreeGate, wallVariation, variationDerivativeGate,
   weightOneGPLs, weightOneLogArguments, weightOnePositiveGates,
   weightOneLogValues, weightOneRules, normalizedVariation,
   remainingLogs, remainingLogRules, wallZeroGate, status},

  If[{lo, hi} =!= {0, 1},
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> "PrototypeUnitIntervalOnly"|>]];
  variables = DeleteDuplicates[cellVariables];
  cellPredicate = And @@ (0 < # < 1 & /@ variables);
  If[cellPredicate === And[], cellPredicate = True];
  fullVariables = Join[{x}, variables];
  fullPredicate = 0 < x < 1 && cellPredicate;

  variableLetterGPLs = Select[IVEP$GPLCases[ad],
    Length[List @@ #] === 2 && Last[List @@ #] === 1 &&
      ! FreeQ[First[List @@ #], x] &];
  variableLogArguments = Quiet@Cancel[Together[
      1 - 1/First[List @@ #]]] & /@ variableLetterGPLs;
  variablePositiveGates = IVEP$CertifyPositive[
      #, fullPredicate, fullVariables] & /@ variableLogArguments;
  If[! And @@ variablePositiveGates,
    Return[<|"Status" -> "Conditional",
      "FailReason" -> "VariableLetterBranchNotCertified",
      "VariableLetterGPLs" -> variableLetterGPLs,
      "PositiveGates" -> variablePositiveGates|>]];
  variableRules = MapThread[#1 -> Log[#2] &,
    {variableLetterGPLs, variableLogArguments}];
  positiveAd = ad /. Dispatch[variableRules];

  argumentGPLs = Select[IVEP$GPLCases[positiveAd],
    Last[List @@ #] === x &];
  crossingGPLs = Select[argumentGPLs,
    MemberQ[Most[List @@ #], wall] &];
  unsupportedCrossingGPLs = Select[crossingGPLs,
    With[{word = Most[List @@ #]},
      ! (word === {wall} ||
        (Length[word] === 2 && Last[word] === wall &&
          FreeQ[First[word], x]))] &];
  If[crossingGPLs === {} || unsupportedCrossingGPLs =!= {},
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> If[crossingGPLs === {}, "NoCrossingGPL",
        "UnsupportedCrossingWord"],
      "CrossingGPLs" -> crossingGPLs,
      "Offenders" -> unsupportedCrossingGPLs|>]];

  monodromyParameter = Unique["wallVariation"];
  continuationRules = Table[
    With[{head = Head[gpl], word = Most[List @@ gpl]},
      If[word === {wall},
        gpl -> gpl + monodromyParameter,
        gpl -> gpl + monodromyParameter (
          IVEW$GPLMake[head, {First[word]}, x] -
          IVEW$GPLMake[head, {First[word]}, wall])]],
    {gpl, crossingGPLs}];
  continuedAd = positiveAd /. Dispatch[continuationRules];
  variationPolynomial = Quiet@Check[
    Collect[Expand[continuedAd - positiveAd], monodromyParameter,
      Together], $Failed];
  variationDegreeGate = variationPolynomial =!= $Failed &&
    Exponent[variationPolynomial, monodromyParameter] === 1;
  If[! variationDegreeGate,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "NonlinearWallVariation",
      "VariationPolynomial" -> variationPolynomial|>]];
  wallVariation = Coefficient[
    variationPolynomial, monodromyParameter, 1];
  variationDerivativeGate = Quiet@CheckAbort[TimeConstrained[
    IVEP$ExactZeroQ[PolyLogTools`DG[wallVariation, x]], 600, False],
    False];
  If[! variationDerivativeGate,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "WallVariationNotConstant",
      "CrossingGPLs" -> crossingGPLs,
      "WallVariation" -> wallVariation|>]];

  weightOneGPLs = Select[IVEP$GPLCases[wallVariation],
    Length[List @@ #] === 2 &];
  weightOneLogArguments = Quiet@Cancel[Together[
      1 - Last[List @@ #]/First[List @@ #]]] & /@ weightOneGPLs;
  weightOnePositiveGates = IVEP$CertifyPositive[
      #, fullPredicate, fullVariables] & /@ weightOneLogArguments;
  If[! And @@ weightOnePositiveGates,
    Return[<|"Status" -> "Conditional",
      "FailReason" -> "WallGaugeBranchNotCertified",
      "WeightOneGPLs" -> weightOneGPLs,
      "LogArguments" -> weightOneLogArguments,
      "PositiveGates" -> weightOnePositiveGates|>]];
  weightOneLogValues = IVEP$PositiveFactorLog[
      #, fullPredicate, fullVariables] & /@ weightOneLogArguments;
  If[MemberQ[weightOneLogValues, $Failed],
    Return[<|"Status" -> "Failed",
      "FailReason" -> "WallGaugeLogNormalizationFailed"|>]];
  weightOneRules = Thread[weightOneGPLs -> weightOneLogValues];
  normalizedVariation = wallVariation /. Dispatch[weightOneRules];
  remainingLogs = DeleteDuplicates@Cases[normalizedVariation, _Log, Infinity];
  remainingLogRules = Map[
    Function[log, With[{value = IVEP$PositiveFactorLog[
        First[List @@ log], fullPredicate, fullVariables]},
      If[value === $Failed, Nothing, log -> value]]],
    remainingLogs];
  normalizedVariation = Quiet@Collect[
    Expand[normalizedVariation /. Dispatch[remainingLogRules]],
    _PolyLogTools`G | _Global`G | _Log, Together];
  wallZeroGate = Quiet@CheckAbort[TimeConstrained[
    IVEP$ExactZeroQ[normalizedVariation], 600, False], False];
  status = If[wallZeroGate, "Certified", "Failed"];
  <|"SchemaVersion" -> 1, "SourceOnly" -> True,
    "NoNumericalOracle" -> True, "Status" -> status,
    "Variable" -> x, "Interval" -> {lo, hi},
    "CellVariables" -> variables, "CellPredicate" -> cellPredicate,
    "Wall" -> wall, "CrossingGPLs" -> crossingGPLs,
    "VariableLetterGPLs" -> variableLetterGPLs,
    "VariableLetterLogArguments" -> variableLogArguments,
    "VariableLetterPositiveGates" -> variablePositiveGates,
    "VariableLetterRules" -> variableRules,
    "ContinuationRules" -> continuationRules,
    "VariationDegreeGate" -> variationDegreeGate,
    "WallVariation" -> wallVariation,
    "VariationDerivativeGate" -> variationDerivativeGate,
    "WeightOneGPLs" -> weightOneGPLs,
    "WeightOneLogArguments" -> weightOneLogArguments,
    "WeightOnePositiveGates" -> weightOnePositiveGates,
    "WeightOneRules" -> weightOneRules,
    "RemainingLogRules" -> remainingLogRules,
    "NormalizedWallVariation" -> normalizedVariation,
    "WallZeroGate" -> wallZeroGate, "Gate" -> wallZeroGate|>
  ];
