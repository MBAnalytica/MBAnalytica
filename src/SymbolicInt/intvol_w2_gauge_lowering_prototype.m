(* AUTHORSHIP (release R2, 2026-09-07): part of the IntVol package (exact endpoint / interior-wall / weight-two gauge modules of the Euler-integral backend). Author: Syed Mehedi Hasan. *)
(* Lower retained variable-letter weight-two GPLs into anchored fixed-letter
   representations.  This prototype consumes proof records emitted by the
   source-exact IntVol dispatcher and fails closed on collisions or gauges. *)

ClearAll[IVE2$IndependentDerivative, IVE2$CollisionRoots,
  IVE2$CanonicalGaugeRules, IVE2$ZeroOrPoleAtQ,
  IVE2$BranchConnectivityAudit, IVE2$Lower];

IVE2$IndependentDerivative[g_, x_] := Module[
  {args = List @@ g, head = Head[g], a, b, ga, gb, da, db},
  If[Length[args] =!= 3 || Last[args] =!= 1, Return[$Failed]];
  {a, b} = Most[args];
  ga = Apply[head, {a, 1}];
  gb = Apply[head, {b, 1}];
  da = D[a, x];
  db = D[b, x];
  Which[
    TrueQ[Cancel[Together[a - b]] === 0],
      Cancel[Together[da ga/(a (a - 1))]],
    TrueQ[Cancel[Together[b]] === 0],
      Collect[Expand[da (-gb/(1 - a) + (ga - gb)/a)],
        _PolyLogTools`G | _Global`G, Together],
    True,
      Collect[Expand[
        da (-gb/(1 - a) + (ga - gb)/(a - b)) +
        db (-(ga - gb)/(a - b) - ga/b)],
        _PolyLogTools`G | _Global`G, Together]]
  ];

IVE2$CollisionRoots[g_, x_] := Module[
  {args = List @@ g, a, b, equations, roots},
  If[Length[args] =!= 3 || Last[args] =!= 1, Return[{$Failed}]];
  {a, b} = Most[args];
  equations = DeleteDuplicates@Select[
    {Together[a - b] == 0, Together[a - 1] == 0,
      Together[b] == 0, Together[b - 1] == 0},
    ! TrueQ[#] && ! TrueQ[Not[#]] &];
  roots = Quiet@Check[
    DeleteDuplicates@Flatten[
      SolveValues[# && 0 < x < 1, x, Reals] & /@ equations],
    {$Failed}];
  roots
  ];

IVE2$CanonicalGaugeRules[gaugeRules_List] := Module[
  {groups, consistencyGates},
  If[! AllTrue[gaugeRules, Head[#] === Rule &] ||
      ! FreeQ[gaugeRules, _Real], Return[$Failed]];
  groups = GatherBy[DeleteDuplicates[gaugeRules], First];
  consistencyGates = Table[
    With[{base = First[group]},
      AllTrue[Rest[group], Quiet@CheckAbort[TimeConstrained[
        IVEP$ExactZeroQ[Last[#] - Last[base]], 600, False], False] &]],
    {group, groups}];
  If[And @@ consistencyGates, First /@ groups, $Failed]
  ];

IVE2$ZeroOrPoleAtQ[expr_, x_, point_] := Module[
  {rat, numerator, denominator},
  rat = Quiet@Check[Cancel[Together[expr]], $Failed];
  If[rat === $Failed, Return[True]];
  numerator = Quiet@Check[Cancel[Numerator[rat] /. x -> point],
    $Failed];
  denominator = Quiet@Check[Cancel[Denominator[rat] /. x -> point],
    $Failed];
  MemberQ[{numerator, denominator}, $Failed] ||
    TrueQ[numerator === 0] || TrueQ[denominator === 0]
  ];

(* An anchored row identity is global only when neither side acquires an
   unproved branch jump at a wall of the assembled primitive. *)
IVE2$BranchConnectivityAudit[loweringRecord_Association, x_,
    wallRows_List] := Module[
  {wallLetters, rows, gaugeRules, exactEqualQ, argumentGPLs,
   wallGPLHits, wallLogHits, unsupportedBranches, rowAudits,
   gaugeAudits, gate},
  wallLetters = Lookup[wallRows, "Letter", {}];
  rows = Lookup[loweringRecord, "Rows", {}];
  gaugeRules = Lookup[loweringRecord, "CanonicalGaugeRules", {}];
  If[! AllTrue[wallLetters, IVEP$ExactRationalQ],
    Return[<|"Status" -> "Failed",
      "FailReason" -> "NonRationalLoweringWall",
      "WallLetters" -> wallLetters, "Gate" -> False|>]];
  exactEqualQ[a_, b_] := Quiet@Check[
    TrueQ[Cancel[Together[a - b]] === 0], False];
  argumentGPLs[expr_] := Select[IVEP$GPLCases[expr],
    Last[List @@ #] === x &];
  wallGPLHits[expr_] := DeleteDuplicates@Cases[
    argumentGPLs[expr], gpl_ /; AnyTrue[
        Flatten@{Most[List @@ gpl]},
        Function[letter, AnyTrue[wallLetters,
          exactEqualQ[letter, #] &]]] :> gpl];
  wallLogHits[expr_] := DeleteDuplicates@Cases[{expr},
    log : Log[arg_] /; ! FreeQ[arg, x] &&
        AnyTrue[wallLetters, IVE2$ZeroOrPoleAtQ[arg, x, #] &] :> log,
    Infinity];
  unsupportedBranches[expr_] := DeleteDuplicates@Join[
    Cases[{expr}, item_PolyLog /; ! FreeQ[item, x] :> item,
      Infinity],
    Cases[{expr}, item_HPL`HPL /; ! FreeQ[item, x] :> item,
      Infinity],
    Cases[{expr}, item : Power[_, exponent_] /;
        ! FreeQ[item, x] && ! IntegerQ[exponent] :> item, Infinity]];
  rowAudits = MapIndexed[Function[{row, index}, Module[
      {gpl, args, a, b, factors, originalHits, primitive,
       primitiveGPLHits, primitiveLogHits, primitiveUnsupported,
       basePoint, baseCollisions, rowGate},
      gpl = Lookup[row, "GPL", $Failed];
      args = If[gpl === $Failed, {}, List @@ gpl];
      {a, b} = If[Length[args] === 3, Most[args],
        {$Failed, $Failed}];
      factors = If[MemberQ[{a, b}, $Failed], {},
        {a, b, a - 1, b - 1, a - b}];
      originalHits = Select[factors, Function[factor,
        ! TrueQ[Quiet@Check[Cancel[Together[factor]] === 0,
          False]] && AnyTrue[wallLetters,
          IVE2$ZeroOrPoleAtQ[factor, x, #] &]]];
      primitive = Lookup[row, "DerivativePrimitive", $Failed];
      primitiveGPLHits = If[primitive === $Failed, {$Failed},
        wallGPLHits[primitive]];
      primitiveLogHits = If[primitive === $Failed, {$Failed},
        wallLogHits[primitive]];
      primitiveUnsupported = If[primitive === $Failed, {$Failed},
        unsupportedBranches[primitive]];
      basePoint = Lookup[row, "BasePoint", $Failed];
      baseCollisions = If[primitive === $Failed, {$Failed},
        Select[argumentGPLs[primitive], Function[argumentGPL,
          AnyTrue[Most[List @@ argumentGPL],
            exactEqualQ[#, basePoint] &]]]];
      rowGate = originalHits === {} && primitiveGPLHits === {} &&
        primitiveLogHits === {} && primitiveUnsupported === {} &&
        baseCollisions === {};
      <|"Index" -> First[index], "GPL" -> gpl,
        "OriginalWallFactors" -> originalHits,
        "DerivativeGPLWallHits" -> primitiveGPLHits,
        "DerivativeLogWallHits" -> primitiveLogHits,
        "DerivativeUnsupportedBranches" -> primitiveUnsupported,
        "BaseGPLCollisions" -> baseCollisions, "Gate" -> rowGate|>
      ]], rows];
  gaugeAudits = MapIndexed[Function[{rule, index}, Module[
      {rhs, gplHits, logHits, unsupported, rowGate},
      rhs = Last[rule];
      gplHits = wallGPLHits[rhs];
      logHits = wallLogHits[rhs];
      unsupported = unsupportedBranches[rhs];
      rowGate = gplHits === {} && logHits === {} && unsupported === {};
      <|"Index" -> First[index], "Rule" -> rule,
        "GPLWallHits" -> gplHits, "LogWallHits" -> logHits,
        "UnsupportedBranches" -> unsupported, "Gate" -> rowGate|>
      ]], gaugeRules];
  gate = AllTrue[rowAudits, TrueQ[Lookup[#, "Gate", False]] &] &&
    AllTrue[gaugeAudits, TrueQ[Lookup[#, "Gate", False]] &];
  <|"SchemaVersion" -> 1, "SourceOnly" -> True,
    "NoNumericalOracle" -> True,
    "Status" -> If[gate, "Certified", "Failed"],
    "WallLetters" -> wallLetters, "RowAudits" -> rowAudits,
    "GaugeAudits" -> gaugeAudits, "Gate" -> gate|>
  ];

IVE2$Lower[antiderivative_, source_, x_, sourceRepairRecords_List,
    gaugeRules_List] := Module[
  {canonicalGaugeRules, weightTwoRepairs, rows, fixedRules,
   ruleLHSUniqueGate, variableWeightTwoGPLs, coverageGate,
   fixedPrimitive, badGPLs, badLogs, badBranchHeads,
   aggregateResidual, aggregateGate},
  If[! FreeQ[{antiderivative, source, sourceRepairRecords,
      gaugeRules}, _Real],
    Return[<|"Status" -> "Failed",
      "FailReason" -> "MachineRealInput"|>]];
  canonicalGaugeRules = IVE2$CanonicalGaugeRules[gaugeRules];
  If[canonicalGaugeRules === $Failed,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "GaugeRuleConsistency"|>]];
  weightTwoRepairs = Select[sourceRepairRecords,
    Function[repair, AssociationQ[repair] &&
      KeyExistsQ[repair, "GPL"] &&
      With[{gpl = repair["GPL"]},
        Length[List @@ gpl] === 3 && Last[List @@ gpl] === 1 &&
          ! FreeQ[gpl, x]]]];
  If[weightTwoRepairs === {},
    Return[<|"Status" -> "NotApplicable",
      "FailReason" -> "NoVariableWeightTwoGPL"|>]];

  rows = Table[Module[
    {gpl = repair["GPL"], recorded = repair["GPLDerivative"],
     independent, derivativeResidual, derivativeGate, collisionRoots,
     collisionGate, gaugedDerivative, replacementGate,
     derivativePrimitive, derivativePrimitiveGate, basePoint = 1/2,
     baseValue, primitiveBase, fixedRepresentation, baseGate,
     proofResidual, proofGate},
    independent = IVE2$IndependentDerivative[gpl, x];
    derivativeResidual = If[independent === $Failed, $Failed,
      Quiet@CheckAbort[TimeConstrained[
        Collect[Expand[recorded - independent],
          _PolyLogTools`G | _Global`G | _Log, Together],
        600, $Failed], $Failed]];
    derivativeGate = derivativeResidual =!= $Failed &&
      IVEP$ExactZeroQ[derivativeResidual];
    collisionRoots = IVE2$CollisionRoots[gpl, x];
    collisionGate = collisionRoots === {};
    If[! derivativeGate || ! collisionGate,
      Return[<|"GPL" -> gpl, "IndependentDerivative" -> independent,
        "DerivativeResidual" -> derivativeResidual,
        "DerivativeGate" -> derivativeGate,
        "CollisionRoots" -> collisionRoots,
        "CollisionGate" -> collisionGate, "Gate" -> False|>]];
    gaugedDerivative = Quiet@CheckAbort[TimeConstrained[
      Collect[Expand[recorded /. canonicalGaugeRules],
        _PolyLogTools`G | _Global`G | _Log, Together],
      600, $Failed], $Failed];
    replacementGate = gaugedDerivative =!= $Failed &&
      FreeQ[gaugedDerivative,
        gg : (PolyLogTools`G | Global`G)[a_, 1] /; ! FreeQ[a, x]];
    derivativePrimitive = If[replacementGate,
      Quiet@CheckAbort[TimeConstrained[
        PolyLogTools`GIntegrate[gaugedDerivative, x], 2400, $Failed],
        $Failed], $Failed];
    derivativePrimitiveGate = derivativePrimitive =!= $Failed &&
      ! TrueQ[Global`IV$HasFrozenTermsQ[derivativePrimitive]] &&
      TrueQ[Global`IV$ExactAntiderivativeQ[
        derivativePrimitive, gaugedDerivative, x]];
    baseValue = gpl /. x -> basePoint;
    primitiveBase = If[derivativePrimitiveGate,
      derivativePrimitive /. x -> basePoint, $Failed];
    fixedRepresentation = If[derivativePrimitiveGate,
      derivativePrimitive + baseValue - primitiveBase, $Failed];
    baseGate = fixedRepresentation =!= $Failed &&
      SameQ[fixedRepresentation /. x -> basePoint, baseValue];
    proofResidual = If[baseGate,
      Quiet@CheckAbort[TimeConstrained[
        Collect[Expand[(PolyLogTools`DG[fixedRepresentation, x] -
          recorded) /. canonicalGaugeRules],
          _PolyLogTools`G | _Global`G | _Log, Together],
        600, $Failed], $Failed], $Failed];
    proofGate = proofResidual =!= $Failed &&
      IVEP$ExactZeroQ[proofResidual];
    <|"GPL" -> gpl, "RecordedDerivative" -> recorded,
      "IndependentDerivative" -> independent,
      "DerivativeResidual" -> derivativeResidual,
      "DerivativeGate" -> derivativeGate,
      "CollisionRoots" -> collisionRoots,
      "CollisionGate" -> collisionGate,
      "GaugedDerivative" -> gaugedDerivative,
      "ReplacementGate" -> replacementGate,
      "DerivativePrimitive" -> derivativePrimitive,
      "DerivativePrimitiveGate" -> derivativePrimitiveGate,
      "BasePoint" -> basePoint, "BaseValue" -> baseValue,
      "FixedRepresentation" -> fixedRepresentation,
      "BaseGate" -> baseGate, "ProofResidual" -> proofResidual,
      "ProofGate" -> proofGate,
      "Gate" -> (derivativeGate && collisionGate && replacementGate &&
        derivativePrimitiveGate && baseGate && proofGate)|>
    ], {repair, weightTwoRepairs}];
  If[! AllTrue[rows, TrueQ[Lookup[#, "Gate", False]] &],
    Return[<|"Status" -> "Failed",
      "FailReason" -> "WeightTwoLoweringRow",
      "Rows" -> rows|>]];
  fixedRules = Function[row,
      row["GPL"] -> row["FixedRepresentation"]] /@ rows;
  ruleLHSUniqueGate =
    Length[fixedRules] === Length[DeleteDuplicates[First /@ fixedRules]];
  If[! ruleLHSUniqueGate,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "DuplicateWeightTwoRule", "Rows" -> rows,
      "WeightTwoRules" -> fixedRules|>]];
  variableWeightTwoGPLs = Select[IVEP$GPLCases[antiderivative],
    Function[gpl, With[{args = List @@ gpl},
      Length[args] === 3 && Last[args] === 1 &&
        ! FreeQ[Most[args], x]]]];
  coverageGate = Complement[variableWeightTwoGPLs,
      First /@ fixedRules] === {};
  If[! coverageGate,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "WeightTwoRuleCoverage", "Rows" -> rows,
      "WeightTwoRules" -> fixedRules,
      "UncoveredGPLs" -> Complement[variableWeightTwoGPLs,
        First /@ fixedRules]|>]];
  fixedPrimitive = Quiet@CheckAbort[TimeConstrained[
    Collect[Expand[(antiderivative /. Dispatch[fixedRules]) /.
      Dispatch[canonicalGaugeRules]],
      _PolyLogTools`G | _Global`G | _Log, Together],
    2400, $Failed], $Failed];
  If[fixedPrimitive === $Failed,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "FixedPrimitiveAssembly",
      "Rows" -> rows|>]];
  badGPLs = Select[IVEP$GPLCases[fixedPrimitive], Function[g,
    With[{args = List @@ g},
      ! (FreeQ[g, x] ||
        (Last[args] === x && FreeQ[Most[args], x]))]]];
  badLogs = DeleteDuplicates@Cases[fixedPrimitive,
    log_Log /; ! FreeQ[log, x], Infinity];
  badBranchHeads = DeleteDuplicates@Join[
    Cases[{fixedPrimitive}, item_PolyLog /; ! FreeQ[item, x] :> item,
      Infinity],
    Cases[{fixedPrimitive}, item_HPL`HPL /; ! FreeQ[item, x] :> item,
      Infinity],
    Cases[{fixedPrimitive}, item : Power[_, exponent_] /;
        ! FreeQ[item, x] && ! IntegerQ[exponent] :> item, Infinity]];
  If[badGPLs =!= {} || badLogs =!= {} || badBranchHeads =!= {},
    Return[<|"Status" -> "Failed",
      "FailReason" -> "FixedPrimitiveInventory",
      "Rows" -> rows, "BadGPLs" -> badGPLs,
      "BadLogs" -> badLogs, "BadBranchHeads" -> badBranchHeads|>]];
  aggregateResidual = Quiet@CheckAbort[TimeConstrained[
    PolyLogTools`DG[fixedPrimitive, x] - source, 1200, $Failed],
    $Failed];
  aggregateResidual = If[aggregateResidual === $Failed, $Failed,
    Quiet@CheckAbort[TimeConstrained[
      Collect[Expand[(aggregateResidual /. Dispatch[fixedRules]) /.
          Dispatch[canonicalGaugeRules]],
        _PolyLogTools`G | _Global`G | _Log, Together],
      1200, $Failed], $Failed]];
  aggregateGate = aggregateResidual =!= $Failed &&
    IVEP$ExactZeroQ[aggregateResidual];
  <|"SchemaVersion" -> 1, "SourceOnly" -> True,
    "NoNumericalOracle" -> True,
    "Status" -> If[aggregateGate, "Certified", "Failed"],
    "CanonicalGaugeRules" -> canonicalGaugeRules,
    "Rows" -> rows, "WeightTwoRules" -> fixedRules,
    "RuleLHSUniqueGate" -> ruleLHSUniqueGate,
    "CoverageGate" -> coverageGate,
    "FixedPrimitive" -> fixedPrimitive,
    "FixedPrimitiveLeafCount" -> LeafCount[fixedPrimitive],
    "BadGPLs" -> badGPLs, "BadLogs" -> badLogs,
    "BadBranchHeads" -> badBranchHeads,
    "AggregateResidual" -> aggregateResidual,
    "AggregateGate" -> aggregateGate, "Gate" -> aggregateGate|>
  ];
