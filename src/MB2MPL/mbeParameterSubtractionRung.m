(* Certified positive-base normalization for faithful Euler cubes with
   external parameters in the open unit interval. Public Subtraction dispatch
   is installed by mbeParameterSubtractionDispatch.m. Parameters are never
   integration axes. *)
ClearAll[psuPolynomialSign, psuPositiveFactors, psuNormalizeCube];
psuPolynomialSign[f_, axes_List] := Module[{ys, transformed, num, den, cn, cd, sn, sd},
  ys = Table[Unique["psuPositive"], {Length[axes]}];
  transformed = Together[f /. Thread[axes -> (#/(1 + #) & /@ ys)]];
  {num, den} = {Numerator[transformed], Denominator[transformed]};
  If[!PolynomialQ[num, ys] || !PolynomialQ[den, ys], Return[$Failed, Module]];
  cn = Last /@ CoefficientRules[num, ys]; cd = Last /@ CoefficientRules[den, ys];
  If[!AllTrue[Join[cn, cd], MatchQ[#, _Integer | _Rational] &], Return[$Failed, Module]];
  sn = Which[AllTrue[cn, # >= 0 &] && AnyTrue[cn, # > 0 &], 1,
    AllTrue[cn, # <= 0 &] && AnyTrue[cn, # < 0 &], -1, True, 0];
  sd = Which[AllTrue[cd, # >= 0 &] && AnyTrue[cd, # > 0 &], 1,
    AllTrue[cd, # <= 0 &] && AnyTrue[cd, # < 0 &], -1, True, 0];
  If[sn sd === 0, $Failed, sn sd]];

psuPositiveFactors[expr_, vars_, pars_] := Module[{fl, sign = 1, out = {}, s},
  fl = FactorList[Together[expr]];
  Do[s = psuPolynomialSign[p[[1]], DeleteDuplicates@Join[vars, pars]];
    If[s === $Failed, fcu$fail["External-parameter base sign was not certified: " <> ToString[p[[1]], InputForm]]];
    sign *= s^p[[2]];
    If[s p[[1]] =!= 1, AppendTo[out, {Expand[s p[[1]]], p[[2]]}]];
    AppendTo[$psuPositivityProofs, <|"Factor" -> p[[1]], "Sign" -> s,
      "Axes" -> vars, "ExternalUnitParameters" -> pars,
      "Certificate" -> "Coefficient signs after x=t/(1+t), t>0"|>],
    {p, fl}];
  {sign, out}];

psuNormalizeCube[cube_, vars_List, eps_Symbol, pars_List] := Module[{norm, proofs},
  If[!AllTrue[Join[vars, pars], MatchQ[#, _Symbol] &] ||
    !DuplicateFreeQ[Join[vars, pars]] || MemberQ[Join[vars, pars], eps],
    Return[Failure["ParameterSubtraction", <|"Reason" -> "Overlapping variable roles"|>], Module]];
  {norm, proofs} = Block[{fcuPosFactors, $psuPositivityProofs = {}},
    fcuPosFactors[e_, vv_] := psuPositiveFactors[e, vv, pars];
    {Catch[fcuNormalize[cube, Join[vars, pars], eps], fcu$tag], $psuPositivityProofs}];
  If[norm === $Failed || AssociationQ[norm] ||
    !FreeQ[norm, _If | Indeterminate | ComplexInfinity | _DirectedInfinity],
    Return[Failure["ParameterSubtraction", <|"Reason" -> "Normalization refused", "Details" -> norm|>], Module]];
  <|"Expression" -> norm, "Variables" -> vars, "ExternalParameters" -> pars,
    "Domain" -> And @@ (0 < # < 1 & /@ Join[vars, pars]), "PositivityProofs" -> proofs|>];
