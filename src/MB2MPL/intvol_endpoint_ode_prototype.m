(* AUTHORSHIP (release R2, 2026-09-07): part of the IntVol package (exact endpoint / interior-wall / weight-two gauge modules of the Euler-integral backend). Author: Syed Mehedi Hasan. *)
(* Exact, source-only endpoint prototype for IntVol antiderivatives.
   It is deliberately fail-closed and is not loaded by production code. *)

ClearAll[
  IVEP$GPLCases, IVEP$GPLMake, IVEP$ExactZeroQ,
  IVEP$MinimumExponent, IVEP$TermPoleOrder,
  IVEP$CertifyPositive, IVEP$PositiveFactorLog,
  IVEP$NormalizePositiveConstants, IVEP$ExactRationalQ,
  IVEP$PrimeLogValue, IVEP$CanonicalDilog,
  IVEP$WeightOneRationalValue, IVEP$WeightTwoOuterFirstBranchData,
  IVEP$WeightTwoRationalValue,
  IVEP$CanonicalizeDilogKernelFast, IVEP$Li2, IVEP$PositiveDilog,
  IVEP$AbelRelationData, IVEP$AbelDilogReduce,
  IVEP$CanonicalizeDilogKernel, IVEP$RationalGPLConstantNormalize,
  IVEP$RationalEndpointFinitePart, IVEP$Evaluate];

IVEP$GPLCases[expr_] := DeleteDuplicates@Cases[
  {expr}, g : (PolyLogTools`G | Global`G)[__], Infinity];

IVEP$GPLMake[head_, letters_List, argument_] :=
  Apply[head, Join[letters, {argument}]];

IVEP$ExactZeroQ[expr_] := TrueQ[
  Global`IV$ExactGPLZeroQ[Quiet@Collect[
    Expand[expr],
    _PolyLogTools`G | _Global`G | _Log | _PolyLog,
    Together]]];

IVEP$MinimumExponent[polynomial_, variable_] := Module[{rules},
  If[SameQ[polynomial, 0], Return[Infinity]];
  rules = Quiet@Check[CoefficientRules[polynomial, variable], $Failed];
  If[rules === $Failed || rules === {}, Return[$Failed]];
  Min[First /@ Keys[rules]]
  ];

IVEP$TermPoleOrder[term_, x_, endpoint_, eta_] := Module[
  {skeleton, shifted, numerator, denominator, numeratorOrder,
   denominatorOrder},
  skeleton = term /. {
    _PolyLogTools`G -> 1, _Global`G -> 1, _HPL`HPL -> 1,
    _Log -> 1, _PolyLog -> 1, _Zeta -> 1, Pi -> 1};
  shifted = Quiet@Check[Cancel[Together[
    skeleton /. x -> If[endpoint === 0, eta, 1 - eta]]], $Failed];
  If[shifted === $Failed, Return[$Failed]];
  numerator = Numerator[shifted];
  denominator = Denominator[shifted];
  If[! PolynomialQ[numerator, eta] ||
      ! PolynomialQ[denominator, eta], Return[$Failed]];
  numeratorOrder = IVEP$MinimumExponent[numerator, eta];
  denominatorOrder = IVEP$MinimumExponent[denominator, eta];
  If[MemberQ[{numeratorOrder, denominatorOrder}, $Failed],
    Return[$Failed]];
  If[numeratorOrder === Infinity, 0,
    Max[0, denominatorOrder - numeratorOrder]]
  ];

IVEP$CertifyPositive[expr_, predicate_, variables_List] := Module[
  {clean = Quiet@Cancel[Together[expr]], query},
  If[! FreeQ[clean, _Real], Return[False]];
  query = If[variables === {}, predicate && clean <= 0,
    predicate && clean <= 0];
  TrueQ[Quiet@Check[
    Reduce[query, variables, Reals] === False, False]]
  ];

IVEP$PositiveFactorLog[expr_, predicate_, variables_List] := Module[
  {rat = Quiet@Cancel[Together[expr]], numerator, denominator,
   sideData, numeratorData, denominatorData},
  If[! IVEP$CertifyPositive[rat, predicate, variables], Return[$Failed]];
  numerator = Numerator[rat];
  denominator = Denominator[rat];
  sideData[polynomial_] := Module[
    {factorList, constant, sign, logSum, factor, multiplicity,
     positiveFactor, valid = True},
    factorList = Quiet@Check[FactorList[polynomial], $Failed];
    If[factorList === $Failed || ! ListQ[factorList], Return[$Failed]];
    constant = factorList[[1, 1]];
    If[! MatchQ[constant, _Integer | _Rational] || constant === 0,
      Return[$Failed]];
    sign = Sign[constant];
    logSum = If[Abs[constant] === 1, 0, Log[Abs[constant]]];
    Do[
      factor = Expand[factorRow[[1]]];
      multiplicity = factorRow[[2]];
      positiveFactor = Which[
        IVEP$CertifyPositive[factor, predicate, variables], factor,
        IVEP$CertifyPositive[-factor, predicate, variables],
          sign *= (-1)^multiplicity; -factor,
        True, valid = False; Break[]];
      If[! valid, Break[]];
      logSum += multiplicity Log[positiveFactor],
      {factorRow, Rest[factorList]}];
    If[valid, <|"Sign" -> sign, "Log" -> logSum|>, $Failed]
    ];
  numeratorData = sideData[numerator];
  denominatorData = sideData[denominator];
  If[! AssociationQ[numeratorData] ||
      ! AssociationQ[denominatorData] ||
      numeratorData["Sign"] =!= denominatorData["Sign"],
    Return[$Failed]];
  numeratorData["Log"] - denominatorData["Log"]
  ];

IVEP$NormalizePositiveConstants[expr_, eta_, predicate_, variables_List] :=
 Module[
  {weightOneGPLs, weightOneValues, weightOneRules, afterWeightOne,
   constantLogs, constantLogValues, constantLogRules, normalized},
  weightOneGPLs = Select[IVEP$GPLCases[expr],
    Length[List @@ #] === 2 && Last[List @@ #] === 1 &];
  weightOneValues = Table[
    IVEP$PositiveFactorLog[
      1 - 1/First[List @@ gpl], predicate, variables],
    {gpl, weightOneGPLs}];
  (* An uncertified principal GPL is retained literally.  Only a certified
     positive argument permits the branch-sensitive logarithm split. *)
  weightOneRules = MapThread[
    If[#2 === $Failed, Nothing, #1 -> #2] &,
    {weightOneGPLs, weightOneValues}];
  afterWeightOne = expr /. Dispatch[weightOneRules];
  constantLogs = DeleteDuplicates@Cases[afterWeightOne,
    log_Log /; FreeQ[log, eta], Infinity];
  constantLogValues = Table[
    IVEP$PositiveFactorLog[First[List @@ log], predicate, variables],
    {log, constantLogs}];
  (* A principal Log that is not certified positive is retained literally;
     it is never split. *)
  constantLogRules = MapThread[
    If[#2 === $Failed, Nothing, #1 -> #2] &,
    {constantLogs, constantLogValues}];
  normalized = Quiet@Check[
    Collect[Expand[afterWeightOne /. Dispatch[constantLogRules]],
      _PolyLogTools`G | _Global`G | _PolyLog | _Log, Together],
    $Failed];
  If[normalized === $Failed, Return[$Failed]];
  <|"Expression" -> normalized,
    "WeightOneGPLs" -> weightOneGPLs,
    "WeightOneRules" -> weightOneRules,
    "UnsplitWeightOneGPLs" -> Complement[
      weightOneGPLs, First /@ weightOneRules],
    "ConstantLogs" -> constantLogs,
    "ConstantLogRules" -> constantLogRules,
    "UnsplitConstantLogs" -> Complement[
      constantLogs, First /@ constantLogRules]|>
  ];

IVEP$ExactRationalQ[value_] := MatchQ[value, _Integer | _Rational];

IVEP$PrimeLogValue[q_] := Module[
  {numeratorFactors, denominatorFactors},
  If[! IVEP$ExactRationalQ[q] || q <= 0, Return[$Failed]];
  If[q === 1, Return[0]];
  numeratorFactors = FactorInteger[Numerator[q]];
  denominatorFactors = FactorInteger[Denominator[q]];
  Total[(#[[2]] Log[#[[1]]]) & /@ numeratorFactors] -
    Total[(#[[2]] Log[#[[1]]]) & /@ denominatorFactors]
  ];

IVEP$CanonicalDilog[q_] := IVEP$CanonicalDilog[q] = Which[
  ! IVEP$ExactRationalQ[q], $Failed,
  q === 0, 0,
  q === 1, Pi^2/6,
  q === -1, -Pi^2/12,
  q > 1,
    -IVEP$CanonicalDilog[1/q] + Pi^2/3 - Log[q]^2/2 -
      I Pi Log[q],
  0 < q < 1,
    -IVEP$CanonicalDilog[-q/(1 - q)] - Log[1/(1 - q)]^2/2,
  q < -1,
    -IVEP$CanonicalDilog[1/q] - Pi^2/6 - Log[-q]^2/2,
  -1 < q < 0, PolyLog[2, q],
  True, $Failed];

IVEP$WeightOneRationalValue[g_] := Module[{args, a, endpoint, h},
  args = List @@ g;
  If[Length[args] =!= 2 ||
      ! AllTrue[args, IVEP$ExactRationalQ], Return[$Failed]];
  {a, endpoint} = args;
  If[endpoint <= 0, Return[$Failed]];
  If[a === 0, Return[Log[endpoint]]];
  h = Cancel[Together[1 - endpoint/a]];
  Which[h > 0, Log[h], h < 0, Log[-h] + I Pi,
    True, $Failed]
  ];

(* Exact branch record for G[a,b;t] when the first letter lies to the right
   of the path.  The transformed root separates the two regions in which
   Log[1-beta] + Log[1+c w] differs from the principal log of their product.
   Every accepted value carries exact domain, factor, sign, ordering, base,
   and collision-continuity gates. *)
IVEP$WeightTwoOuterFirstBranchData[a_, b_, endpoint_] := Module[
  {beta, c, wEnd, wRoot, leftFactor, rightFactor, productFactor,
   sector, correctionPoint, base, correction, factorGate, signGate,
   orderingGate, baseGate, continuityGate, gate},
  If[! AllTrue[{a, b, endpoint}, IVEP$ExactRationalQ] ||
      ! TrueQ[0 < endpoint < a] || b === 0 || b === a,
    Return[$Failed]];
  beta = a/b;
  c = beta/(1 - beta);
  wEnd = 1 - endpoint/a;
  wRoot = 1 - 1/beta;
  leftFactor = 1 - beta;
  rightFactor = 1 + c wEnd;
  productFactor = 1 - endpoint/b;
  sector = Which[
    b < 0, "NegativeSecondLetter",
    b > a, "SecondLetterRightOfFirst",
    0 < b < endpoint, "InternalSecondLetter",
    b === endpoint, "EndpointSecondLetter",
    endpoint < b < a, "SecondLetterBetweenEndpointAndFirst",
    True, Return[$Failed]];
  factorGate = SameQ[
    Cancel[Together[leftFactor rightFactor - productFactor]], 0];
  signGate = Switch[sector,
    "NegativeSecondLetter" | "SecondLetterRightOfFirst",
      leftFactor > 0 && rightFactor > 0 && productFactor > 0,
    "InternalSecondLetter",
      leftFactor < 0 && rightFactor > 0 && productFactor < 0,
    "EndpointSecondLetter",
      leftFactor < 0 && rightFactor === 0 && productFactor === 0,
    "SecondLetterBetweenEndpointAndFirst",
      leftFactor < 0 && rightFactor < 0 && productFactor > 0,
    _, False];
  orderingGate = If[beta > 1,
    If[endpoint > b,
      TrueQ[0 < wEnd < wRoot < 1],
      TrueQ[0 < wRoot <= wEnd < 1]],
    TrueQ[beta < 1 && 0 < wEnd < 1]];
  correctionPoint = If[beta > 1,
    If[endpoint > b, wRoot, wEnd], 1];
  base = Log[1 - beta] Log[wEnd] -
    PolyLog[2, -c wEnd] + PolyLog[2, -c];
  correction = If[beta > 1,
    -2 Pi I Log[correctionPoint], 0];
  baseGate = SameQ[
    Expand[Log[1 - beta] Log[1] -
      PolyLog[2, -c] + PolyLog[2, -c]], 0];
  continuityGate = If[beta > 1,
    SameQ[Cancel[Together[(1 - b/a) - wRoot]], 0], True];
  gate = factorGate && TrueQ[signGate] && TrueQ[orderingGate] &&
    baseGate && continuityGate && TrueQ[correctionPoint > 0];
  <|"SchemaVersion" -> 1, "SourceOnly" -> True,
    "NoNumericalOracle" -> True, "A" -> a, "B" -> b,
    "Endpoint" -> endpoint, "Sector" -> sector, "Beta" -> beta,
    "C" -> c, "WEnd" -> wEnd, "WRoot" -> wRoot,
    "LeftFactor" -> leftFactor, "RightFactor" -> rightFactor,
    "ProductFactor" -> productFactor,
    "CorrectionPoint" -> correctionPoint, "Base" -> base,
    "Correction" -> correction, "Value" -> base + correction,
    "FactorGate" -> factorGate, "SignGate" -> signGate,
    "OrderingGate" -> orderingGate, "BaseGate" -> baseGate,
    "ContinuityGate" -> continuityGate, "Gate" -> gate|>
  ];

IVEP$WeightTwoRationalValue[g_] := Module[
  {args, a, b, endpoint, alpha, beta, c, wEnd, wRoot,
   base, correction, branchData},
  args = List @@ g;
  If[Length[args] =!= 3 ||
      ! AllTrue[args, IVEP$ExactRationalQ], Return[$Failed]];
  {a, b, endpoint} = args;
  If[endpoint <= 0, Return[$Failed]];
  Which[
    a === 0 && b === 0,
      Log[endpoint]^2/2,
    a === 0 && b =!= 0 && TrueQ[b < 0 || b > endpoint],
      -PolyLog[2, endpoint/b],
    b === 0 && a =!= 0 && TrueQ[a < 0 || a > endpoint],
      Log[endpoint] Log[1 - endpoint/a] + PolyLog[2, endpoint/a],
    a === b && a =!= 0 && TrueQ[a < 0 || a > endpoint],
      Log[1 - endpoint/a]^2/2,
    TrueQ[0 < endpoint < a],
      branchData = IVEP$WeightTwoOuterFirstBranchData[a, b, endpoint];
      If[AssociationQ[branchData] && TrueQ[branchData["Gate"]],
        branchData["Value"], $Failed],
    True, $Failed]
  ];

IVEP$CanonicalizeDilogKernelFast[expr_] := Module[
  {converted, dilogs, half, third, halfCoefficient,
   thirdCoefficient, pairGate, pairValue, afterPair,
   logArguments},
  converted = expr /. PolyLog[2, q_] :> IVEP$CanonicalDilog[q];
  If[! FreeQ[converted, $Failed], Return[$Failed]];
  dilogs = DeleteDuplicates@Cases[converted, PolyLog[2, q_] :> q,
    Infinity];
  If[Complement[dilogs, {-1/2, -1/3}] =!= {}, Return[$Failed]];
  half = PolyLog[2, -1/2];
  third = PolyLog[2, -1/3];
  halfCoefficient = Together[Coefficient[Expand[converted], half]];
  thirdCoefficient = Together[Coefficient[Expand[converted], third]];
  pairGate = SameQ[Together[halfCoefficient - 2 thirdCoefficient], 0];
  If[! pairGate && ! SameQ[halfCoefficient, 0] &&
      ! SameQ[thirdCoefficient, 0], Return[$Failed]];
  (* Abel at x=y=1/2, duplication at 1/2, and Landen at 1/3. *)
  pairValue = -Pi^2/6 - Log[2]^2 + 2 Log[2] Log[3] -
    Log[3]^2/2;
  afterPair = If[pairGate,
    Expand[converted - halfCoefficient half - thirdCoefficient third +
      thirdCoefficient pairValue], converted];
  logArguments = DeleteDuplicates@Cases[afterPair, Log[q_] :> q,
    Infinity];
  If[! AllTrue[logArguments,
      IVEP$ExactRationalQ[#] && # > 0 &], Return[$Failed]];
  Together@Expand[afterPair /.
    Log[q_] :> IVEP$PrimeLogValue[q]]
  ];

(* Put every real rational dilogarithm on (0,1) using identities whose
   principal-branch corrections are explicit. *)
IVEP$PositiveDilog[q_] := IVEP$PositiveDilog[q] = Which[
  ! IVEP$ExactRationalQ[q], $Failed,
  q === 0, 0,
  q === 1, Pi^2/6,
  0 < q < 1, IVEP$Li2[q],
  q > 1,
    -IVEP$PositiveDilog[1/q] + Pi^2/3 - Log[q]^2/2 - I Pi Log[q],
  q < 0,
    -IVEP$PositiveDilog[q/(q - 1)] - Log[1 - q]^2/2,
  True, $Failed];

(* Exact Spence five-term relation data on a bounded Farey basis. For
   0<x,y<1,
     Li2[x]+Li2[y]-Li2[xy]-Li2[x(1-y)/(1-xy)]
       -Li2[y(1-x)/(1-xy)]
     = Log[(1-x)/(1-xy)] Log[(1-y)/(1-xy)].
   Duplicate arguments in a row are combined before linear algebra. *)
IVEP$AbelRelationData[bound_Integer] :=
  IVEP$AbelRelationData[bound] = Module[
    {values, pairs, arguments, signs = {1, 1, -1, -1, -1},
     goodPairs, abelAssociations, reflectionValues,
     reflectionAssociations, rowAssociations, basis, matrix,
     abelCorrections, reflectionCorrections, corrections},
    If[bound < 2 || bound > 16, Return[$Failed]];
    values = DeleteDuplicates@Flatten@Table[
      Table[n/d, {n, 1, d - 1}], {d, 2, bound}];
    pairs = Join[Subsets[values, {2}], ({#, #} & /@ values)];
    arguments[{x_, y_}] := With[{den = 1 - x y},
      {x, y, x y, x (1 - y)/den, y (1 - x)/den}];
    goodPairs = Select[pairs, With[{args = arguments[#]},
      AllTrue[args, IVEP$ExactRationalQ[#] && 0 < # < 1 &] &&
        Max[Denominator /@ args] <= bound] &];
    If[goodPairs === {}, Return[$Failed]];
    abelAssociations = Merge[Thread[arguments[#] -> signs], Total] & /@
      goodPairs;
    reflectionValues = Select[values,
      # <= 1/2 && Denominator[1 - #] <= bound &];
    reflectionAssociations =
      Merge[Thread[{#, 1 - #} -> {1, 1}], Total] & /@
        reflectionValues;
    rowAssociations = Join[abelAssociations, reflectionAssociations];
    basis = Union[Flatten[Keys /@ rowAssociations]];
    matrix = Table[Lookup[rowAssociations[[i]], basis[[j]], 0],
      {i, Length[rowAssociations]}, {j, Length[basis]}];
    abelCorrections = (With[
        {x = #[[1]], y = #[[2]], den = 1 - Times @@ #},
        Log[(1 - x)/den] Log[(1 - y)/den]]) & /@ goodPairs;
    reflectionCorrections =
      (Pi^2/6 - Log[#] Log[1 - #]) & /@ reflectionValues;
    corrections = Join[abelCorrections, reflectionCorrections];
    <|"Bound" -> bound, "Pairs" -> goodPairs,
      "ReflectionValues" -> reflectionValues, "Basis" -> basis,
      "Matrix" -> matrix, "Corrections" -> corrections|>
    ];

IVEP$AbelDilogReduce[expr_] := Module[
  {converted, expanded, dilogs, maxDenominator, bound, data, basis,
   matrix, target, solution, dilogPart, residual, reduced,
   logArguments},
  converted = expr /. PolyLog[2, q_] :> IVEP$PositiveDilog[q];
  If[! FreeQ[converted, $Failed], Return[$Failed]];
  expanded = Expand[converted];
  dilogs = DeleteDuplicates@Cases[expanded, IVEP$Li2[q_] :> q,
    Infinity];
  If[! AllTrue[dilogs,
      IVEP$ExactRationalQ[#] && 0 < # < 1 &], Return[$Failed]];
  If[dilogs === {},
    logArguments = DeleteDuplicates@Cases[expanded, Log[q_] :> q,
      Infinity];
    If[! AllTrue[logArguments,
        IVEP$ExactRationalQ[#] && # > 0 &], Return[$Failed]];
    Return[Together@Expand[expanded /.
      Log[q_] :> IVEP$PrimeLogValue[q]]]];
  maxDenominator = Max[Denominator /@ dilogs];
  If[maxDenominator > 16, Return[$Failed]];
  bound = Max[12, maxDenominator];
  data = IVEP$AbelRelationData[bound];
  If[! AssociationQ[data], Return[$Failed]];
  basis = data["Basis"];
  If[Complement[dilogs, basis] =!= {}, Return[$Failed]];
  matrix = data["Matrix"];
  target = Table[Together@Coefficient[expanded, IVEP$Li2[q]],
    {q, basis}];
  If[! FreeQ[target, _PolyLog | IVEP$Li2[_]], Return[$Failed]];
  dilogPart = Total@MapThread[#1 IVEP$Li2[#2] &, {target, basis}];
  residual = Expand[expanded - dilogPart];
  If[! FreeQ[residual, _PolyLog | IVEP$Li2[_]], Return[$Failed]];
  solution = Quiet@Check[
    LinearSolve[Transpose[matrix], target], $Failed];
  If[solution === $Failed ||
      ! AllTrue[MapThread[Together[#1 - #2] &,
        {solution . matrix, target}], SameQ[#, 0] &], Return[$Failed]];
  reduced = Expand[residual + solution . data["Corrections"]];
  logArguments = DeleteDuplicates@Cases[reduced, Log[q_] :> q,
    Infinity];
  If[! AllTrue[logArguments,
      IVEP$ExactRationalQ[#] && # > 0 &], Return[$Failed]];
  Together@Expand[reduced /. Log[q_] :> IVEP$PrimeLogValue[q]]
  ];

IVEP$CanonicalizeDilogKernel[expr_] := Module[{fast},
  fast = IVEP$CanonicalizeDilogKernelFast[expr];
  If[fast =!= $Failed, fast, IVEP$AbelDilogReduce[expr]]
  ];

IVEP$RationalGPLConstantNormalize[expr_] := Module[
  {gpls, supportedGate, converted},
  gpls = IVEP$GPLCases[expr];
  supportedGate = AllTrue[gpls, Function[g,
    With[{args = List @@ g},
      MemberQ[{2, 3}, Length[args]] &&
        AllTrue[args, IVEP$ExactRationalQ] && Last[args] > 0]]];
  If[! supportedGate, Return[$Failed]];
  converted = expr /. {
    g : (PolyLogTools`G | Global`G)[__] /;
        Length[List @@ g] === 2 :> IVEP$WeightOneRationalValue[g],
    g : (PolyLogTools`G | Global`G)[__] /;
        Length[List @@ g] === 3 :> IVEP$WeightTwoRationalValue[g]};
  If[FreeQ[converted, $Failed],
    IVEP$CanonicalizeDilogKernel[converted], $Failed]
  ];

IVEP$RationalEndpointFinitePart[series_, eta_] := Module[
  {logVariable = Unique["endpointLog"], laurent, minPower,
   maxLogPower, poleRows, constantTerm, logRows, poleGate, logGate,
   finitePart, gate, symbolZeroGate},
  symbolZeroGate[expr_] := Quiet@CheckAbort[TimeConstrained[
    SameQ[Expand[PolyLogTools`SymbolMap[expr]], 0], 600, False],
    False];
  laurent = Expand[series /. Log[eta] -> logVariable];
  minPower = Exponent[laurent, eta, Min];
  maxLogPower = Exponent[laurent, logVariable];
  If[! IntegerQ[minPower] || ! IntegerQ[maxLogPower], Return[$Failed]];
  poleRows = Flatten[Table[Module[{coefficient, normalized},
    coefficient = Collect[
      Coefficient[Coefficient[laurent, eta, k], logVariable, j],
      _PolyLogTools`G | _Global`G | _Log, Together];
    If[SameQ[coefficient, 0], Nothing,
      normalized = IVEP$RationalGPLConstantNormalize[coefficient];
      <|"Power" -> k, "LogPower" -> j,
        "Coefficient" -> coefficient,
        "SymbolZeroGate" -> symbolZeroGate[coefficient],
        "NormalizedCoefficient" -> normalized,
        "ZeroGate" -> SameQ[normalized, 0]|>]],
    {k, minPower, -1}, {j, 0,
      Exponent[Coefficient[laurent, eta, k], logVariable]}], 1];
  constantTerm = Coefficient[laurent, eta, 0];
  logRows = Table[Module[{coefficient, normalized},
    coefficient = Collect[Coefficient[constantTerm, logVariable, j],
      _PolyLogTools`G | _Global`G | _Log, Together];
    normalized = IVEP$RationalGPLConstantNormalize[coefficient];
    <|"LogPower" -> j, "Coefficient" -> coefficient,
      "SymbolZeroGate" -> symbolZeroGate[coefficient],
      "NormalizedCoefficient" -> normalized,
      "ZeroGate" -> SameQ[normalized, 0]|>],
    {j, 1, Exponent[constantTerm, logVariable]}];
  poleGate = AllTrue[poleRows, Function[row,
    TrueQ[row["SymbolZeroGate"]] && TrueQ[row["ZeroGate"]]]];
  logGate = AllTrue[logRows, Function[row,
    TrueQ[row["SymbolZeroGate"]] && TrueQ[row["ZeroGate"]]]];
  finitePart = If[poleGate && logGate,
    Collect[Coefficient[constantTerm, logVariable, 0],
      _PolyLogTools`G | _Global`G | _Log, Together], $Failed];
  gate = poleGate && logGate && FreeQ[finitePart,
    eta | logVariable | $Failed | $Aborted | Indeterminate |
      ComplexInfinity | DirectedInfinity[_] | _Real];
  <|"MinPower" -> minPower, "MaxLogPower" -> maxLogPower,
    "PoleRows" -> poleRows, "LogRows" -> logRows,
    "PoleGate" -> poleGate, "LogGate" -> logGate,
    "FinitePart" -> finitePart, "Gate" -> gate|>
  ];

IVEP$Evaluate[antiderivative_, x_, {lo_, hi_}, cellVariables_List] :=
 Module[
  {ad = antiderivative, variables, cellPredicate, fullVariables,
   fullPredicate, allGPLs, variableLetterGPLs, otherVariableGPLs,
   variableLogArguments, variableLogPositiveGates, variableLogRules,
   logAd, argumentGPLs, unsupportedArgumentGPLs, letters,
   wallLetters, wallRows, etaLower = Unique["etaLower"],
   etaUpper = Unique["etaUpper"], expandedTerms, lowerPoleOrders,
   upperPoleOrders, poleGate, maxLowerPoleOrder, maxUpperPoleOrder,
   lowerOrder, upperOrder, lowerSeries, upperSeries, lowerValues,
   upperValues, upperLeadingShuffleGate, lowerProof, upperProof,
   lowerProofGates,
   upperProofGates, seriesGate, lowerRules, upperRules, lowerInput,
   upperInput, lowerLaurent, upperLaurent, lowerNormalized,
   upperNormalized, lowerFinite, upperFinite, lowerFiniteGate,
   upperFiniteGate, lowerFiniteAudit, upperFiniteAudit, status, gate,
   badPattern, result},

  If[{lo, hi} =!= {0, 1},
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> "PrototypeUnitIntervalOnly"|>]];
  variables = DeleteDuplicates[cellVariables];
  If[MemberQ[variables, x],
    Return[<|"Status" -> "Failed",
      "FailReason" -> "IntegrationVariableInCellVariables"|>]];
  cellPredicate = And @@ (0 < # < 1 & /@ variables);
  If[cellPredicate === And[], cellPredicate = True];
  fullVariables = Join[{x}, variables];
  fullPredicate = 0 < x < 1 && cellPredicate;

  allGPLs = IVEP$GPLCases[ad];
  variableLetterGPLs = Select[allGPLs,
    Length[List @@ #] === 2 && Last[List @@ #] === 1 &&
      ! FreeQ[First[List @@ #], x] &];
  otherVariableGPLs = Select[allGPLs,
    ! FreeQ[#, x] && Last[List @@ #] =!= x &&
      ! MemberQ[variableLetterGPLs, #] &];
  If[otherVariableGPLs =!= {},
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> "UnsupportedVariableLetterGPL",
      "Offenders" -> otherVariableGPLs|>]];
  variableLogArguments = Quiet@Cancel[Together[
      1 - 1/First[List @@ #]]] & /@ variableLetterGPLs;
  variableLogPositiveGates = IVEP$CertifyPositive[
      #, fullPredicate, fullVariables] & /@ variableLogArguments;
  If[! And @@ variableLogPositiveGates,
    Return[<|"Status" -> "Conditional",
      "FailReason" -> "VariableLetterBranchNotCertified",
      "VariableLetterGPLs" -> variableLetterGPLs,
      "LogArguments" -> variableLogArguments,
      "PositiveGates" -> variableLogPositiveGates|>]];
  variableLogRules = MapThread[#1 -> Log[#2] &,
    {variableLetterGPLs, variableLogArguments}];
  logAd = ad /. Dispatch[variableLogRules];

  argumentGPLs = Select[IVEP$GPLCases[logAd],
    Last[List @@ #] === x &];
  unsupportedArgumentGPLs = Select[argumentGPLs,
    ! MemberQ[{1, 2}, Length[List @@ #] - 1] ||
      ! FreeQ[Most[List @@ #], x] &];
  If[unsupportedArgumentGPLs =!= {},
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> "UnsupportedArgumentGPL",
      "Offenders" -> unsupportedArgumentGPLs|>]];

  letters = DeleteDuplicates@Flatten[Most[List @@ #] & /@ argumentGPLs];
  wallLetters = Select[letters,
    TrueQ[Quiet@Check[
      Reduce[cellPredicate && 0 < # < 1, variables, Reals] =!= False,
      True]] &];
  wallRows = <|"Letter" -> #,
      "ExistencePredicate" -> Quiet@Reduce[
        cellPredicate && 0 < # < 1, variables, Reals]|> & /@ wallLetters;

  expandedTerms = Expand[logAd];
  expandedTerms = If[Head[expandedTerms] === Plus,
    List @@ expandedTerms, {expandedTerms}];
  lowerPoleOrders = IVEP$TermPoleOrder[#, x, 0, etaLower] & /@
    expandedTerms;
  upperPoleOrders = IVEP$TermPoleOrder[#, x, 1, etaUpper] & /@
    expandedTerms;
  poleGate = FreeQ[{lowerPoleOrders, upperPoleOrders}, $Failed];
  If[! poleGate,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "PoleOrderAuditFailed"|>]];
  maxLowerPoleOrder = Max[lowerPoleOrders];
  maxUpperPoleOrder = Max[upperPoleOrders];
  lowerOrder = Max[2, maxLowerPoleOrder + 2];
  upperOrder = Max[2, maxUpperPoleOrder + 2];

  Clear[lowerSeries, upperSeries];
  lowerSeries[g_, order_Integer] := lowerSeries[g, order] = Module[
    {args = List @@ g, head = Head[g], word, weight, first,
     tail, tailValue, derivativeValue, primitive},
    word = Most[args];
    If[Last[args] =!= x || ! FreeQ[word, x], Return[$Failed]];
    weight = Length[word];
    If[weight === 1,
      first = First[word];
      Return[If[TrueQ[Cancel[Together[first]] === 0],
        Log[etaLower],
        Normal@Series[Log[1 - etaLower/first],
          {etaLower, 0, order}]]]];
    If[weight =!= 2, Return[$Failed]];
    If[And @@ (TrueQ[Cancel[Together[#]] === 0] & /@ word),
      Return[Log[etaLower]^weight/weight!]];
    first = First[word];
    tail = IVEP$GPLMake[head, Rest[word], x];
    tailValue = lowerSeries[tail, order];
    If[tailValue === $Failed, Return[$Failed]];
    derivativeValue = Quiet@Check[
      Normal@Series[tailValue/(etaLower - first),
        {etaLower, 0, order - 1}], $Failed];
    If[derivativeValue === $Failed, Return[$Failed]];
    primitive = Quiet@Check[
      Integrate[derivativeValue, etaLower,
        GenerateConditions -> False], $Failed];
    If[primitive === $Failed, Return[$Failed]];
    primitive = primitive - Quiet@Limit[primitive, etaLower -> 0,
      Direction -> "FromAbove"];
    If[! FreeQ[primitive, Indeterminate | ComplexInfinity |
        DirectedInfinity[_]], Return[$Failed]];
    Normal@Series[primitive, {etaLower, 0, order}]
    ];
  upperSeries[g_, order_Integer] := upperSeries[g, order] = Module[
    {args = List @@ g, head = Head[g], word, weight, first,
     tail, tailValue, derivativeValue, primitive, primitiveAtZero},
    word = Most[args];
    If[Last[args] =!= x || ! FreeQ[word, x], Return[$Failed]];
    weight = Length[word];
    If[weight === 1,
      first = First[word];
      Return[If[TrueQ[Cancel[Together[first - 1]] === 0],
        Log[etaUpper],
        IVEP$GPLMake[head, word, 1] +
          Normal@Series[Log[1 + etaUpper/(first - 1)],
            {etaUpper, 0, order}]]]];
    If[weight =!= 2, Return[$Failed]];
    If[And @@ (TrueQ[Cancel[Together[# - 1]] === 0] & /@ word),
      Return[Log[etaUpper]^weight/weight!]];
    first = First[word];
    If[TrueQ[Cancel[Together[first - 1]] === 0],
      Module[{second = Last[word], leading, secondWord,
              shuffledWord, leadingValue, secondValue, shuffledValue},
        leading = IVEP$GPLMake[head, {1}, x];
        secondWord = IVEP$GPLMake[head, {second}, x];
        shuffledWord = IVEP$GPLMake[head, {second, 1}, x];
        leadingValue = upperSeries[leading, order];
        secondValue = upperSeries[secondWord, order];
        shuffledValue = upperSeries[shuffledWord, order];
        If[MemberQ[{leadingValue, secondValue, shuffledValue}, $Failed],
          Return[$Failed]];
        Return[Normal@Series[
          leadingValue secondValue - shuffledValue,
          {etaUpper, 0, order}]]]];
    tail = IVEP$GPLMake[head, Rest[word], x];
    tailValue = upperSeries[tail, order];
    If[tailValue === $Failed, Return[$Failed]];
    derivativeValue = Quiet@Check[
      Normal@Series[-tailValue/(1 - etaUpper - first),
        {etaUpper, 0, order - 1}], $Failed];
    If[derivativeValue === $Failed, Return[$Failed]];
    primitive = Quiet@Check[
      Integrate[derivativeValue, etaUpper,
        GenerateConditions -> False], $Failed];
    If[primitive === $Failed, Return[$Failed]];
    primitiveAtZero = Quiet@Limit[primitive, etaUpper -> 0,
      Direction -> "FromAbove"];
    If[! FreeQ[primitiveAtZero, Indeterminate | ComplexInfinity |
        DirectedInfinity[_]], Return[$Failed]];
    IVEP$GPLMake[head, word, 1] +
      Normal@Series[primitive - primitiveAtZero,
        {etaUpper, 0, order}]
    ];

  lowerValues = lowerSeries[#, lowerOrder] & /@ argumentGPLs;
  upperValues = upperSeries[#, upperOrder] & /@ argumentGPLs;
  If[FreeQ[{lowerValues, upperValues}, $Failed], Null,
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> "EndpointGPLSeriesUnsupported"|>]];

  upperLeadingShuffleGate[g_] := Module[
    {args = List @@ g, head = Head[g], word, second, identity,
     derivativeGate, baseGate},
    word = Most[args];
    If[Length[word] =!= 2 ||
        ! TrueQ[Cancel[Together[First[word] - 1]] === 0],
      Return[False]];
    second = Last[word];
    identity = IVEP$GPLMake[head, {1}, x]
        IVEP$GPLMake[head, {second}, x] -
      IVEP$GPLMake[head, {second, 1}, x] - g;
    derivativeGate = IVEP$ExactZeroQ[PolyLogTools`DG[identity, x]];
    baseGate = IVEP$ExactZeroQ[identity];
    derivativeGate && baseGate
    ];

  lowerProof[g_, value_] := Module[
    {word = Most[List @@ g], head = Head[g], first, target, residual,
     baseGate},
    first = First[word];
    target = If[Length[word] === 1,
      1/(etaLower - first),
      lowerSeries[IVEP$GPLMake[head, Rest[word], x], lowerOrder]/
        (etaLower - first)];
    residual = Normal@Series[D[value, etaLower] - target,
      {etaLower, 0, lowerOrder - 1}];
    baseGate = Which[
      Length[word] === 1 &&
          TrueQ[Cancel[Together[first]] === 0], True,
      And @@ (TrueQ[Cancel[Together[#]] === 0] & /@ word), True,
      True, TrueQ[Quiet@Limit[value, etaLower -> 0,
        Direction -> "FromAbove"] === 0]];
    IVEP$ExactZeroQ[residual] && baseGate
    ];
  upperProof[g_, value_] := Module[
    {word = Most[List @@ g], head = Head[g], first, target, residual,
     baseValue, baseGate},
    first = First[word];
    target = If[Length[word] === 1,
      -1/(1 - etaUpper - first),
      -upperSeries[IVEP$GPLMake[head, Rest[word], x], upperOrder]/
        (1 - etaUpper - first)];
    residual = Normal@Series[D[value, etaUpper] - target,
      {etaUpper, 0, upperOrder - 1}];
    baseValue = IVEP$GPLMake[head, word, 1];
    baseGate = Which[
      Length[word] === 1 &&
          TrueQ[Cancel[Together[first - 1]] === 0], True,
      And @@ (TrueQ[Cancel[Together[# - 1]] === 0] & /@ word), True,
      Length[word] === 2 &&
          TrueQ[Cancel[Together[first - 1]] === 0],
        upperLeadingShuffleGate[g],
      True, SameQ[Quiet@Limit[value, etaUpper -> 0,
        Direction -> "FromAbove"], baseValue]];
    IVEP$ExactZeroQ[residual] && baseGate
    ];
  lowerProofGates = MapThread[lowerProof, {argumentGPLs, lowerValues}];
  upperProofGates = MapThread[upperProof, {argumentGPLs, upperValues}];
  seriesGate = And @@ Join[lowerProofGates, upperProofGates];
  If[! seriesGate,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "EndpointGPLSeriesProofFailed",
      "LowerProofGates" -> lowerProofGates,
      "UpperProofGates" -> upperProofGates|>]];

  lowerRules = Dispatch[Thread[argumentGPLs -> lowerValues]];
  upperRules = Dispatch[Thread[argumentGPLs -> upperValues]];
  lowerInput = (logAd /. lowerRules) /. x -> etaLower;
  upperInput = (logAd /. upperRules) /. x -> 1 - etaUpper;
  lowerLaurent = Quiet@CheckAbort[TimeConstrained[
    Normal@Series[lowerInput, {etaLower, 0, 0}], 900, $Failed],
    $Failed];
  upperLaurent = Quiet@CheckAbort[TimeConstrained[
    Normal@Series[upperInput, {etaUpper, 0, 0}], 900, $Failed],
    $Failed];
  If[MemberQ[{lowerLaurent, upperLaurent}, $Failed],
    Return[<|"Status" -> "Failed",
      "FailReason" -> "EndpointLaurentExpansionFailed"|>]];
  lowerNormalized = IVEP$NormalizePositiveConstants[
    lowerLaurent, etaLower, cellPredicate, variables];
  upperNormalized = IVEP$NormalizePositiveConstants[
    upperLaurent, etaUpper, cellPredicate, variables];
  If[! AssociationQ[lowerNormalized] ||
      ! AssociationQ[upperNormalized],
    Return[<|"Status" -> "Failed",
      "FailReason" -> "EndpointConstantNormalizationFailed"|>]];
  lowerFinite = Quiet@CheckAbort[TimeConstrained[
    Global`IV$CertifiedLaurentFinitePart[
      lowerNormalized["Expression"], etaLower, 0], 900, $Failed],
    $Failed];
  upperFinite = Quiet@CheckAbort[TimeConstrained[
    Global`IV$CertifiedLaurentFinitePart[
      upperNormalized["Expression"], etaUpper, 0], 900, $Failed],
    $Failed];
  lowerFiniteAudit = If[lowerFinite === $Failed,
    IVEP$RationalEndpointFinitePart[
      lowerNormalized["Expression"], etaLower],
    <|"Gate" -> True, "FinitePart" -> lowerFinite,
      "Mode" -> "BasicFinitePart"|>];
  upperFiniteAudit = If[upperFinite === $Failed,
    IVEP$RationalEndpointFinitePart[
      upperNormalized["Expression"], etaUpper],
    <|"Gate" -> True, "FinitePart" -> upperFinite,
      "Mode" -> "BasicFinitePart"|>];
  If[AssociationQ[lowerFiniteAudit] && TrueQ[lowerFiniteAudit["Gate"]],
    lowerFinite = lowerFiniteAudit["FinitePart"]];
  If[AssociationQ[upperFiniteAudit] && TrueQ[upperFiniteAudit["Gate"]],
    upperFinite = upperFiniteAudit["FinitePart"]];
  badPattern = $Failed | $Aborted | Indeterminate | Undefined |
    ComplexInfinity | DirectedInfinity[_] | _Real;
  lowerFiniteGate = FreeQ[lowerFinite, badPattern | etaLower | x];
  upperFiniteGate = FreeQ[upperFinite, badPattern | etaUpper | x];
  gate = lowerFiniteGate && upperFiniteGate;
  status = Which[
    ! gate, "Failed",
    wallRows =!= {}, "Conditional",
    True, "Certified"];
  result = If[gate, upperFinite - lowerFinite, $Failed];
  <|"SchemaVersion" -> 1, "SourceOnly" -> True,
    "NoNumericalOracle" -> True, "Status" -> status,
    "Value" -> result, "Variable" -> x, "Interval" -> {lo, hi},
    "CellVariables" -> variables, "CellPredicate" -> cellPredicate,
    "VariableLetterGPLs" -> variableLetterGPLs,
    "VariableLetterLogArguments" -> variableLogArguments,
    "VariableLetterPositiveGates" -> variableLogPositiveGates,
    "VariableLetterRules" -> variableLogRules,
    "ArgumentGPLs" -> argumentGPLs,
    "WallRows" -> wallRows, "RequiresWallAudit" -> wallRows =!= {},
    "LowerPoleOrders" -> lowerPoleOrders,
    "UpperPoleOrders" -> upperPoleOrders,
    "LowerSeriesOrder" -> lowerOrder,
    "UpperSeriesOrder" -> upperOrder,
    "LowerProofGates" -> lowerProofGates,
    "UpperProofGates" -> upperProofGates,
    "LowerLaurent" -> lowerLaurent,
    "UpperLaurent" -> upperLaurent,
    "LowerNormalization" -> lowerNormalized,
    "UpperNormalization" -> upperNormalized,
    "LowerFinite" -> lowerFinite, "UpperFinite" -> upperFinite,
    "LowerFiniteAudit" -> lowerFiniteAudit,
    "UpperFiniteAudit" -> upperFiniteAudit,
    "LowerFiniteGate" -> lowerFiniteGate,
    "UpperFiniteGate" -> upperFiniteGate,
    "Gate" -> gate|>
  ];
