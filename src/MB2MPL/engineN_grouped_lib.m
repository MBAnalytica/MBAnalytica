(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Syed Mehedi Hasan, Taushif Ahmed, Andreas Rapakoulias, Sumit Banik. *)
(* engineN_grouped_lib.m -- pre-Together scale-class fork of engineN.
   Requires engineN_lib.m.  It preserves each exact representation term,
   groups only equal MB scale vectors, and emits a producer identity gate.
   No group is integrated here. *)

ClearAll[mbeGroupResolveAbs, engineNGroupedSubcubes];

mbeGroupResolveAbs[expression_, variables_List] := Catch[Module[
  {arguments, assumptions, rules = {}, sign},
  arguments = DeleteDuplicates@Cases[expression, Abs[arg_] :> arg,
    {0, Infinity}];
  If[arguments === {}, Throw[expression, "mbeGroupAbs"]];
  assumptions = And @@ Join[Element[#, Reals] & /@ variables,
    Flatten[({0 < #, # < 1} & /@ variables)]];
  Do[
    sign = Quiet@TimeConstrained[
      FullSimplify[Sign[Together[argument]], assumptions], 30, $TimedOut];
    Which[
      TrueQ[sign === 1], AppendTo[rules, Abs[argument] -> argument],
      TrueQ[sign === -1], AppendTo[rules, Abs[argument] -> -argument],
      True, Throw[$Failed, "mbeGroupAbs"]],
    {argument, arguments}];
  Together[expression /. rules]
], "mbeGroupAbs"];

engineNGroupedSubcubes[p_Association, threshold_: 1/5] := Catch[Module[
  {variables = p["Vars"], contour = p["Contour"], integrand, terms,
   output = {}, scalePlaceholders, expectedCells = 0},
  scalePlaceholders = Table[Unique["WWNsym$"], {Length[variables]}];
  integrand = Expand[Global`betaGuardLift[
    Global`raisePsiN[p["Integrand"], variables, contour, threshold],
    variables]];
  terms = If[Head[integrand] === Plus, List @@ integrand, {integrand}];
  Do[Module[{sourceTerm = terms[[sourceIndex]], factors, baseKernel = 1,
      polygammas = {}, rationalPoles = {}, representations,
      representationTerms, baseCubes, invalid = False, cubeOrdinal = 0},
    factors = If[Head[sourceTerm] === Times, List @@ sourceTerm, {sourceTerm}];
    Do[
      Which[
        MatchQ[factor, PolyGamma[_, _]] ||
          MatchQ[factor, Power[PolyGamma[_, _], _Integer?Positive]],
          AppendTo[polygammas, factor],
        !FreeQ[factor, PolyGamma], invalid = True,
        MatchQ[factor, Power[linear_, power_Integer?Negative] /;
          FreeQ[linear, Gamma] && PolynomialQ[linear, variables] &&
          Total[Exponent[linear, #] & /@ variables] === 1],
          AppendTo[rationalPoles, factor],
        True, baseKernel = baseKernel*factor],
      {factor, factors}];
    If[invalid, Throw[$Failed, "engineNGrouped"]];
    polygammas = Flatten[Replace[polygammas,
      {Power[pg_, count_Integer?Positive] :> ConstantArray[pg, count],
       pg_ :> {pg}}, 1]];
    baseCubes = Global`cubeMBN[baseKernel, variables, contour,
      scalePlaceholders];
    If[baseCubes === $Failed || baseCubes === {},
      Throw[$Failed, "engineNGrouped"]];
    expectedCells += Length[baseCubes];
    representations = Times @@ Join[
      (Global`repFactorN[#[[1]], #[[2]], Global`freshSN] & /@ polygammas),
      (Function[pole, Global`ratRepN[pole[[1]], -pole[[2]],
          Global`freshSN, contour]] /@ rationalPoles)];
    representationTerms = If[Head[Expand[representations]] === Plus,
      List @@ Expand[representations], {Expand[representations]}];
    Do[Module[{contributions = {}, auxiliaryVariables = {}, cubeVariables,
        scaleVector, residual, contribution, grouped, groupExpressions,
        rawExpression, cleanRaw, cleanGroups, identityGate},
      cubeOrdinal++;
      Do[
        {scaleVector, residual} = Global`peelWN[representationTerm, variables];
        scaleVector = Together /@ scaleVector;
        auxiliaryVariables = Union[auxiliaryVariables,
          Cases[{residual, scaleVector}, symbol_Symbol /;
            StringMatchQ[SymbolName[symbol], "seNx" ~~ __], Infinity]];
        contribution = residual*(baseCube[[1]] /.
          Thread[scalePlaceholders -> scaleVector]);
        AppendTo[contributions,
          <|"Scale" -> scaleVector, "Expression" -> contribution|>],
        {representationTerm, representationTerms}];
      cubeVariables = DeleteDuplicates@Join[baseCube[[2]], auxiliaryVariables];
      grouped = GatherBy[contributions, Lookup[#, "Scale"] &];
      groupExpressions = Together[Total[Lookup[#, "Expression"]]] & /@ grouped;
      rawExpression = Total[Lookup[contributions, "Expression"]];
      identityGate = TrueQ[Quiet@TimeConstrained[
        Together[Total[groupExpressions] - rawExpression] === 0,
        120, False]];
      If[!identityGate, Throw[$Failed, "engineNGrouped"]];
      cleanRaw = mbeGroupResolveAbs[Together[rawExpression], cubeVariables];
      cleanGroups = mbeGroupResolveAbs[#, cubeVariables] & /@ groupExpressions;
      If[cleanRaw === $Failed || MemberQ[cleanGroups, $Failed],
        Throw[$Failed, "engineNGrouped"]];
      identityGate = TrueQ[Quiet@TimeConstrained[
        Together[Total[cleanGroups] - cleanRaw] === 0, 120, False]];
      If[!identityGate, Throw[$Failed, "engineNGrouped"]];
      AppendTo[output, <|
        "SourceIndex" -> sourceIndex,
        "BaseCubeIndex" -> cubeOrdinal,
        "Original" -> cleanRaw,
        "Variables" -> cubeVariables,
        "Groups" -> cleanGroups,
        "ScaleKeys" -> (Lookup[First[#], "Scale"] & /@ grouped),
        "GroupCount" -> Length[cleanGroups],
        "ContributionCount" -> Length[contributions],
        "IdentityGate" -> True|>]],
      {baseCube, baseCubes}]],
    {sourceIndex, Length[terms]}];
  If[Length[output] =!= expectedCells || expectedCells === 0 ||
      Sort[DeleteDuplicates[Lookup[output, "SourceIndex", -1]]] =!=
        Range[Length[terms]] ||
      !AllTrue[output, TrueQ[Lookup[#, "IdentityGate", False]] &],
    Throw[$Failed, "engineNGrouped"]];
  (Join[#, <|"BatchIdentityGate" -> True,
      "ProducerCount" -> expectedCells|>] &) /@ output
], "engineNGrouped"];
