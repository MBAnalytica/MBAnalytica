(* AUTHORSHIP (release R2, 2026-09-07): part of the IntVol package (exact endpoint / interior-wall / weight-two gauge modules of the Euler-integral backend). Author: Syed Mehedi Hasan. *)
(* Exact two-sided ODE certificate for a fixed rational interior GPL wall.
   The complete primitive is expanded on both sides before any finite jump is
   formed.  This prototype is fail-closed and is not production-loaded. *)

ClearAll[
  IVEIW$ExactRationalQ, IVEIW$PrimeLogValue,
  IVEIW$WeightOneBranchValue, IVEIW$BranchConstantNormalize,
  IVEIW$SeriesZeroQ, IVEIW$Evaluate];

IVEIW$ExactRationalQ[value_] := MatchQ[value, _Integer | _Rational];

IVEIW$PrimeLogValue[q_] := Module[
  {numeratorFactors, denominatorFactors},
  If[! IVEIW$ExactRationalQ[q] || q <= 0, Return[$Failed]];
  If[q === 1, Return[0]];
  numeratorFactors = FactorInteger[Numerator[q]];
  denominatorFactors = FactorInteger[Denominator[q]];
  Total[(#[[2]] Log[#[[1]]]) & /@ numeratorFactors] -
    Total[(#[[2]] Log[#[[1]]]) & /@ denominatorFactors]
  ];

IVEIW$WeightOneBranchValue[g_, sigma_] := Module[
  {args = List @@ g, a, endpoint, h},
  If[Length[args] =!= 2 ||
      ! AllTrue[args, IVEIW$ExactRationalQ], Return[$Failed]];
  {a, endpoint} = args;
  If[endpoint <= 0, Return[$Failed]];
  If[a === 0, Return[IVEIW$PrimeLogValue[endpoint]]];
  h = Cancel[Together[1 - endpoint/a]];
  Which[
    h > 0, IVEIW$PrimeLogValue[h],
    h < 0, IVEIW$PrimeLogValue[-h] + sigma I Pi,
    True, $Failed]
  ];

IVEIW$BranchConstantNormalize[expr_, sigma_] := Module[
  {shuffled, converted, logs},
  (* Put rational weight-two constants in descending-letter order.  This is
     the ordinary GPL shuffle identity and does not choose a branch. *)
  shuffled = Expand[expr //. {
    g : (PolyLogTools`G | Global`G)[a_, b_, endpoint_] /;
        And @@ (IVEIW$ExactRationalQ /@ {a, b, endpoint}) && a < b :>
      IVEP$GPLMake[Head[g], {a}, endpoint]
        IVEP$GPLMake[Head[g], {b}, endpoint] -
        IVEP$GPLMake[Head[g], {b, a}, endpoint]}];
  converted = shuffled /. {
    g : (PolyLogTools`G | Global`G)[__] /;
        Length[List @@ g] === 2 &&
        AllTrue[List @@ g, IVEIW$ExactRationalQ] :>
      IVEIW$WeightOneBranchValue[g, sigma]};
  If[! FreeQ[converted, $Failed], Return[$Failed]];
  logs = DeleteDuplicates@Cases[converted, Log[q_] :> q, Infinity];
  If[! AllTrue[logs, IVEIW$ExactRationalQ[#] && # > 0 &],
    Return[Quiet@Collect[Expand[converted],
      _PolyLogTools`G | _Global`G | _Log, Together]]];
  Together@Expand[converted /. Log[q_] :> IVEIW$PrimeLogValue[q]]
  ];

IVEIW$SeriesZeroQ[expr_, sigma_] := Module[
  {polynomial, numerator, denominator, remainder, normalized,
   normalizedNumerator, normalizedDenominator, reduced, coefficients},
  polynomial = Quiet@Collect[Expand[expr], sigma, Together];
  If[! PolynomialQ[polynomial, sigma], Return[False]];
  numerator = Numerator[Together[polynomial]];
  denominator = Denominator[Together[polynomial]];
  If[! FreeQ[denominator, sigma], Return[False]];
  remainder = PolynomialRemainder[numerator, sigma^2 - 1, sigma]/
    denominator;
  normalized = IVEIW$BranchConstantNormalize[remainder, sigma];
  If[normalized === $Failed || ! PolynomialQ[normalized, sigma],
    Return[False]];
  normalizedNumerator = Numerator[Together[normalized]];
  normalizedDenominator = Denominator[Together[normalized]];
  If[! FreeQ[normalizedDenominator, sigma], Return[False]];
  reduced = PolynomialRemainder[
      normalizedNumerator, sigma^2 - 1, sigma]/normalizedDenominator;
  coefficients = Coefficient[reduced, sigma, #] & /@ {0, 1};
  AllTrue[coefficients, Function[coefficient,
    SameQ[coefficient, 0] || Quiet@CheckAbort[TimeConstrained[
      IVEP$ExactZeroQ[coefficient], 600, False], False]]]
  ];

IVEIW$Evaluate[antiderivative_, x_, {lo_, hi_}, wall_,
    branchPrescription_:"PrincipalGlobalI0"] := Module[
  {ad = antiderivative, sigma = Unique["branchSigma"],
   eta = Unique["wallEta"], logVariable = Unique["wallLog"],
   branchParameterize, primitiveSigma, argumentGPLs, crossingGPLs,
   unsupportedGPLs, skeleton, minimumExponent, termPoleOrder,
   expandedTerms, poleOrders, poleGate, maxPoleOrder, seriesOrder,
   localGPLSeries, localSeriesProof, leftValues, rightValues,
   seriesGate, leftProofGates, rightProofGates, leftRules,
   rightRules, leftInput, rightInput, leftSeries, rightSeries,
   certifySide, leftAudit, rightAudit, sideGate, wallDifference,
   wallDifferenceGate, branchAxioms, branchAxiomGate,
   structuralGate, status, gate},

  If[{lo, hi} =!= {0, 1},
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> "PrototypeUnitIntervalOnly"|>]];
  If[! IVEIW$ExactRationalQ[wall] || ! TrueQ[0 < wall < 1],
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> "FixedRationalInteriorWallRequired",
      "Wall" -> wall|>]];
  If[branchPrescription =!= "PrincipalGlobalI0",
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> "UnsupportedBranchPrescription",
      "BranchPrescription" -> branchPrescription|>]];

  branchParameterize[expr_] := expr /. c_Complex :>
    Re[c] + sigma I Im[c];
  primitiveSigma = branchParameterize[ad];
  argumentGPLs = Select[IVEP$GPLCases[primitiveSigma],
    Last[List @@ #] === x &];
  crossingGPLs = Select[argumentGPLs,
    AnyTrue[Most[List @@ #],
      TrueQ[Cancel[Together[# - wall]] === 0] &] &];
  unsupportedGPLs = Select[argumentGPLs, With[
    {word = Most[List @@ #]},
    ! MemberQ[{1, 2}, Length[word]] || ! FreeQ[word, x]]];
  If[crossingGPLs === {} || unsupportedGPLs =!= {},
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> If[crossingGPLs === {}, "NoCrossingGPL",
        "UnsupportedGPLAtWall"],
      "CrossingGPLs" -> crossingGPLs,
      "Offenders" -> unsupportedGPLs|>]];

  skeleton[expr_] := expr /. {
    _PolyLogTools`G -> 1, _Global`G -> 1, _HPL`HPL -> 1,
    _Log -> 1, _PolyLog -> 1, _Zeta -> 1, Pi -> 1,
    sigma -> 1, I -> 1};
  minimumExponent[polynomial_, variable_] := Module[{rules},
    If[SameQ[polynomial, 0], Return[Infinity]];
    rules = Quiet@Check[CoefficientRules[polynomial, variable], $Failed];
    If[rules === $Failed || rules === {}, Return[$Failed]];
    Min[First /@ Keys[rules]]];
  termPoleOrder[term_] := Module[
    {shifted, numerator, denominator, numeratorOrder,
     denominatorOrder},
    shifted = Quiet@Check[Cancel[Together[
      skeleton[term] /. x -> wall + eta]], $Failed];
    If[shifted === $Failed, Return[$Failed]];
    numerator = Numerator[shifted];
    denominator = Denominator[shifted];
    If[! PolynomialQ[numerator, eta] ||
        ! PolynomialQ[denominator, eta], Return[$Failed]];
    numeratorOrder = minimumExponent[numerator, eta];
    denominatorOrder = minimumExponent[denominator, eta];
    If[MemberQ[{numeratorOrder, denominatorOrder}, $Failed],
      Return[$Failed]];
    If[numeratorOrder === Infinity, 0,
      Max[0, denominatorOrder - numeratorOrder]]];

  branchAxioms = <|
    "Prescription" -> branchPrescription,
    "Coherence" -> "One global i0 sign conjugates every prior and local branch",
    "LeftArgument" -> Cancel[Together[1 - (wall - eta)/wall]],
    "RightArgument" -> Cancel[Together[1 - (wall + eta)/wall]],
    "LeftValue" -> Log[eta] - Log[wall],
    "RightValue" -> Log[eta] - Log[wall] + sigma I Pi|>;
  branchAxiomGate = SameQ[branchAxioms["LeftArgument"], eta/wall] &&
    SameQ[branchAxioms["RightArgument"], -eta/wall] &&
    TrueQ[Quiet@Reduce[eta > 0 && eta/wall <= 0, eta, Reals] ===
      False];
  expandedTerms = Expand[primitiveSigma];
  expandedTerms = If[Head[expandedTerms] === Plus,
    List @@ expandedTerms, {expandedTerms}];
  poleOrders = termPoleOrder /@ expandedTerms;
  poleGate = FreeQ[poleOrders, $Failed];
  If[! poleGate,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "WallPoleOrderAuditFailed"|>]];
  maxPoleOrder = Max[poleOrders];
  seriesOrder = Max[2, maxPoleOrder + 2];

  localGPLSeries[g_, side_Integer, order_Integer] :=
    localGPLSeries[g, side, order] = Module[
      {args = List @@ g, head = Head[g], word, weight, first, second,
       tail, tailValue, derivativeValue, primitive, base, leadingValue,
       secondValue, shuffledValue},
      word = Most[args];
      If[Last[args] =!= x || ! FreeQ[word, x] ||
          ! MemberQ[{-1, 1}, side], Return[$Failed]];
      weight = Length[word];
      first = First[word];
      If[weight === 1 &&
          TrueQ[Cancel[Together[first - wall]] === 0],
        Return[Log[eta] - Log[wall] +
          If[side === 1, sigma I Pi, 0]]];
      If[weight === 1,
        derivativeValue = Normal@Series[
          side/(wall + side eta - first), {eta, 0, order - 1}];
        primitive = Integrate[derivativeValue, eta,
          GenerateConditions -> False];
        base = IVEP$GPLMake[head, {first}, wall];
        Return[base + primitive - (primitive /. eta -> 0)]];
      If[weight =!= 2, Return[$Failed]];
      If[TrueQ[Cancel[Together[first - wall]] === 0],
        second = Last[word];
        leadingValue = localGPLSeries[
          IVEP$GPLMake[head, {first}, x], side, order];
        If[leadingValue === $Failed, Return[$Failed]];
        If[TrueQ[Cancel[Together[second - first]] === 0],
          Return[Expand[leadingValue^2/2]]];
        secondValue = localGPLSeries[
          IVEP$GPLMake[head, {second}, x], side, order];
        shuffledValue = localGPLSeries[
          IVEP$GPLMake[head, {second, first}, x], side, order];
        If[MemberQ[{secondValue, shuffledValue}, $Failed],
          Return[$Failed]];
        Return[Expand[
          leadingValue secondValue - shuffledValue]]];
      tail = IVEP$GPLMake[head, Rest[word], x];
      tailValue = localGPLSeries[tail, side, order];
      If[tailValue === $Failed, Return[$Failed]];
      derivativeValue = Quiet@Check[Normal@Series[
        side tailValue/(wall + side eta - first),
        {eta, 0, order - 1}], $Failed];
      If[derivativeValue === $Failed, Return[$Failed]];
      primitive = Quiet@TimeConstrained[Integrate[derivativeValue, eta,
        GenerateConditions -> False], 120, $Failed];
      If[primitive === $Failed, Return[$Failed]];
      base = IVEP$GPLMake[head, word, wall];
      base + primitive - Quiet@Limit[primitive, eta -> 0,
        Direction -> "FromAbove"]];

  localSeriesProof[gpl_, value_, side_] := Module[
    {word = Most[List @@ gpl], head = Head[gpl], first, second,
     target, residual, derivativeGate, base, baseResidual, baseGate,
     leadingValue, secondValue, shuffledValue, shuffleResidual},
    first = First[word];
    target = If[Length[word] === 1,
      side/(wall + side eta - first),
      side localGPLSeries[
        IVEP$GPLMake[head, Rest[word], x], side, seriesOrder]/
        (wall + side eta - first)];
    residual = Normal@Series[D[value, eta] - target,
      {eta, 0, seriesOrder - 1}];
    derivativeGate = IVEIW$SeriesZeroQ[residual, sigma];
    baseGate = Which[
      Length[word] === 1 &&
          TrueQ[Cancel[Together[first - wall]] === 0],
        base = Log[eta] - Log[wall] +
          If[side === 1, sigma I Pi, 0];
        SameQ[Together[value - base], 0],
      Length[word] === 2 &&
          TrueQ[Cancel[Together[first - wall]] === 0],
        second = Last[word];
        leadingValue = localGPLSeries[
          IVEP$GPLMake[head, {first}, x], side, seriesOrder];
        If[TrueQ[Cancel[Together[second - first]] === 0],
          shuffleResidual = 2 value - leadingValue^2,
          secondValue = localGPLSeries[
            IVEP$GPLMake[head, {second}, x], side, seriesOrder];
          shuffledValue = localGPLSeries[
            IVEP$GPLMake[head, {second, first}, x], side, seriesOrder];
          shuffleResidual = value -
            leadingValue secondValue + shuffledValue];
        IVEIW$SeriesZeroQ[shuffleResidual, sigma],
      True,
        base = IVEP$GPLMake[head, word, wall];
        baseResidual = Quiet@Limit[value - base, eta -> 0,
          Direction -> "FromAbove"];
        IVEIW$SeriesZeroQ[baseResidual, sigma]];
    derivativeGate && baseGate];

  leftValues = localGPLSeries[#, -1, seriesOrder] & /@ argumentGPLs;
  rightValues = localGPLSeries[#, 1, seriesOrder] & /@ argumentGPLs;
  seriesGate = FreeQ[{leftValues, rightValues},
    $Failed | $Aborted | Indeterminate | ComplexInfinity |
      DirectedInfinity[_]];
  If[! seriesGate,
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> "WallGPLSeriesUnsupported",
      "Wall" -> wall,
      "LeftFailures" -> Pick[argumentGPLs,
        (# === $Failed &) /@ leftValues],
      "RightFailures" -> Pick[argumentGPLs,
        (# === $Failed &) /@ rightValues]|>]];
  leftProofGates = MapThread[
    localSeriesProof[#1, #2, -1] &, {argumentGPLs, leftValues}];
  rightProofGates = MapThread[
    localSeriesProof[#1, #2, 1] &, {argumentGPLs, rightValues}];
  seriesGate = And @@ Join[leftProofGates, rightProofGates];
  If[! seriesGate,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "WallGPLSeriesProofFailed",
      "LeftProofGates" -> leftProofGates,
      "RightProofGates" -> rightProofGates|>]];

  leftRules = Dispatch[Thread[argumentGPLs -> leftValues]];
  rightRules = Dispatch[Thread[argumentGPLs -> rightValues]];
  leftInput = (primitiveSigma /. leftRules) /. x -> wall - eta;
  rightInput = (primitiveSigma /. rightRules) /. x -> wall + eta;
  leftSeries = Quiet@CheckAbort[TimeConstrained[
    Normal@Series[leftInput, {eta, 0, 0}], 900, $Failed], $Failed];
  rightSeries = Quiet@CheckAbort[TimeConstrained[
    Normal@Series[rightInput, {eta, 0, 0}], 900, $Failed], $Failed];
  If[MemberQ[{leftSeries, rightSeries}, $Failed],
    Return[<|"Status" -> "Failed",
      "FailReason" -> "WallLaurentExpansionFailed"|>]];

  certifySide[series_] := Module[
    {laurent, minPower, constantTerm, poleRows, logRows,
     poleGateLocal, logGate, finitePart, coefficient},
    laurent = Expand[series /. Log[eta] -> logVariable];
    minPower = Exponent[laurent, eta, Min];
    If[! IntegerQ[minPower], Return[$Failed]];
    poleRows = Flatten@Table[
      coefficient = Collect[
        Coefficient[Coefficient[laurent, eta, k], logVariable, j],
        _PolyLogTools`G | _Global`G | _Log, Together];
      If[SameQ[coefficient, 0], Nothing,
        <|"Power" -> k, "LogPower" -> j,
          "Coefficient" -> coefficient,
          "ZeroGate" -> IVEIW$SeriesZeroQ[coefficient, sigma]|>],
      {k, minPower, -1}, {j, 0, Max[0,
        Exponent[Coefficient[laurent, eta, k], logVariable]]}];
    constantTerm = Coefficient[laurent, eta, 0];
    logRows = Table[
      coefficient = Collect[
        Coefficient[constantTerm, logVariable, j],
        _PolyLogTools`G | _Global`G | _Log, Together];
      <|"LogPower" -> j, "Coefficient" -> coefficient,
        "ZeroGate" -> IVEIW$SeriesZeroQ[coefficient, sigma]|>,
      {j, 1, Max[0, Exponent[constantTerm, logVariable]]}];
    poleGateLocal = AllTrue[poleRows, TrueQ[#ZeroGate] &];
    logGate = AllTrue[logRows, TrueQ[#ZeroGate] &];
    finitePart = If[poleGateLocal && logGate,
      Collect[Coefficient[constantTerm, logVariable, 0],
        _PolyLogTools`G | _Global`G | _Log, Together], $Failed];
    If[! FreeQ[finitePart, eta | logVariable | Log[eta]],
      finitePart = $Failed];
    <|"MinPower" -> minPower, "PoleRows" -> poleRows,
      "LogRows" -> logRows, "PoleGate" -> poleGateLocal,
      "LogGate" -> logGate, "FinitePart" -> finitePart,
      "Gate" -> (poleGateLocal && logGate && finitePart =!= $Failed)|>];

  leftAudit = certifySide[leftSeries];
  rightAudit = certifySide[rightSeries];
  sideGate = AssociationQ[leftAudit] && AssociationQ[rightAudit] &&
    TrueQ[leftAudit["Gate"]] && TrueQ[rightAudit["Gate"]];
  wallDifference = If[sideGate, Collect[Expand[
    rightAudit["FinitePart"] - leftAudit["FinitePart"]],
    _PolyLogTools`G | _Global`G | _Log, Together], $Failed];
  wallDifferenceGate = wallDifference =!= $Failed &&
    IVEIW$SeriesZeroQ[wallDifference, sigma];
  structuralGate = FreeQ[
    {leftAudit["FinitePart"], rightAudit["FinitePart"], wallDifference},
    _Gint | _HPL | Derivative[__][PolyLogTools`G] | $Failed |
      $Aborted | Indeterminate | ComplexInfinity | DirectedInfinity[_] |
      _Real | eta | logVariable];
  gate = branchAxiomGate && poleGate && seriesGate && sideGate &&
    wallDifferenceGate && structuralGate;
  status = If[gate, "Certified", "Failed"];
  <|"SchemaVersion" -> 1, "SourceOnly" -> True,
    "NoNumericalOracle" -> True, "Status" -> status,
    "Variable" -> x, "Interval" -> {lo, hi}, "Wall" -> wall,
    "BranchPrescription" -> branchPrescription,
    "BranchAxioms" -> branchAxioms,
    "BranchAxiomGate" -> branchAxiomGate,
    "BranchParameter" -> sigma, "CrossingGPLs" -> crossingGPLs,
    "ArgumentGPLs" -> argumentGPLs, "MaxWallPoleOrder" -> maxPoleOrder,
    "SeriesOrder" -> seriesOrder, "LeftProofGates" -> leftProofGates,
    "RightProofGates" -> rightProofGates, "LeftAudit" -> leftAudit,
    "RightAudit" -> rightAudit, "WallDifference" -> wallDifference,
    "WallDifferenceGate" -> wallDifferenceGate,
    "StructuralGate" -> structuralGate, "Gate" -> gate|>
  ];
