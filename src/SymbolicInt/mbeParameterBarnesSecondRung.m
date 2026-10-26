(* Balanced and immediately contiguous Barnes-II reductions on the supplied fixed contour.
   The same class includes four Gamma legs with one affine reciprocal.
   All coincident-pole corrections share one deformation and one limit. *)
BeginPackage["MBParameter`"];
Begin["`Private`"];
ClearAll[secondBarnesParses, fixedSecondBarnesVariable];

secondBarnesParses[ig_, v_] := Module[
  {num = {}, den = {}, rest = 1, rat = 1, ok = True, nr, dr, slope, shift, candidates = {}, p},
  Do[Which[
    FreeQ[f, v], rest *= f,
    MatchQ[f, Gamma[_]] && Global`mbeBPRAffineQ[f[[1]], v] && Abs[Coefficient[f[[1]], v]] === 1,
      AppendTo[num, f[[1]]],
    MatchQ[f, Power[Gamma[_], _Integer]] && Global`mbeBPRAffineQ[f[[1, 1]], v] && Abs[Coefficient[f[[1, 1]], v]] === 1,
      If[f[[2]] > 0, num = Join[num, ConstantArray[f[[1, 1]], f[[2]]]],
        den = Join[den, ConstantArray[f[[1, 1]], -f[[2]]]]],
    FreeQ[f, Gamma | PolyGamma | _Log | _Exp] &&
      PolynomialQ[Numerator[Together[f]], v] && PolynomialQ[Denominator[Together[f]], v], rat *= f,
    True, ok = False], {f, factors[ig]}];
  If[!ok, Return[{}, Module]];
  rat = Cancel[rat]; nr = Numerator[rat]; dr = Denominator[rat];
  If[!FreeQ[nr, v], Return[{}, Module]];
  If[FreeQ[dr, v],
    AppendTo[candidates, <|"num" -> num, "den" -> den, "rest" -> rest rat,
      "ReciprocalLift" -> None|>],
    If[Length[num] =!= 4 || den =!= {} || !Global`mbeBPRAffineQ[dr, v], Return[{}, Module]];
    slope = Coefficient[dr, v]; shift = Cancel[(dr /. v -> 0)/slope];
    Do[AppendTo[candidates, <|"num" -> Append[num, sign (v + shift)],
      "den" -> {1 + sign (v + shift)}, "rest" -> rest nr sign/slope,
      "ReciprocalLift" -> <|"Denominator" -> dr, "Orientation" -> sign|>|>], {sign, {1, -1}}]];
  Select[candidates, Length[#["num"]] === 5 && Length[#["den"]] === 1 &]];

fixedSecondBarnesVariable[ig_, v_, vars_, ctr_] := Module[
  {parses, num, den, a, b, c, up, dn, orientation, reallegs, shifted, reg,
   terms, crosses, pole, limit, gate, core, realContour, result = $Failed,
   balance, multiplier, regular},
  parses = secondBarnesParses[ig, v];
  Do[num = p["num"]; den = First[p["den"]];
    up = Count[Coefficient[#, v] & /@ num, 1]; dn = Count[Coefficient[#, v] & /@ num, -1];
    orientation = Which[up === 3 && dn === 2 && Coefficient[den, v] === 1, 1,
      up === 2 && dn === 3 && Coefficient[den, v] === -1, -1, True, 0];
    If[orientation === 0, Continue[]];
    num = num /. v -> orientation v; den = den /. v -> orientation v;
    up = Flatten@Position[Coefficient[#, v] & /@ num, 1];
    dn = Flatten@Position[Coefficient[#, v] & /@ num, -1];
    a = Expand[num[[up]] /. v -> 0]; b = Expand[num[[dn]] /. v -> 0]; c = Expand[den /. v -> 0];
    balance = Expand[c - Total[a] - Total[b]];
    If[!MemberQ[{0, 1}, balance], Continue[]];
    realContour = ctr /. Rule[v, q_] :> Rule[v, orientation q];
    reallegs = num /. realContour;
    If[!AllTrue[reallegs, MatchQ[#, _Rational | _Integer] &] ||
       AnyTrue[reallegs, IntegerQ[#] && # <= 0 &], Continue[]];
    shifted = MapIndexed[#1 + 2^(First[#2] - 1) reg &, num];
    a = shifted[[up]] /. v -> 0; b = shifted[[dn]] /. v -> 0;
    c = Total[a] + Total[b] + balance;
    (* For c = Sum[a]+Sum[b]+1 the raised-leg difference simplifies
       exactly to this symmetric polynomial times the same Gamma quotient.
       Its polynomial form also covers coincident positive offsets. *)
    multiplier = If[balance === 0, 1,
      Total[Times @@@ Subsets[a, {2}]] + Total[a] Total[b] + b[[1]]^2 + b[[1]] b[[2]] + b[[2]]^2];
    terms = {multiplier Times @@ Flatten[Outer[Gamma[#1 + #2] &, a, b]]/(Times @@ (Gamma[c - #] & /@ a))};
    crosses = {};
    Do[Do[pole = -Coefficient[num[[i]], v] ((shifted[[i]] /. v -> 0) + k);
      AppendTo[terms, -(-1)^k/k! (Times @@ (Gamma[# /. v -> pole] & /@ Delete[shifted, i]))/Gamma[c + pole]];
      AppendTo[crosses, <|"Leg" -> num[[i]], "Index" -> k|>],
      {k, 0, Ceiling[-reallegs[[i]]] - 1}], {i, 5}];
    regular = Quiet[terms /. reg -> 0];
    limit = If[FreeQ[regular, Indeterminate | ComplexInfinity | _DirectedInfinity],
      Quiet@TimeConstrained[FullSimplify[Total[regular]], 20, $Failed],
      Quiet@TimeConstrained[FullSimplify[Normal@Series[Total[terms], {reg, 0, 0}]], 30, $Failed]];
    limit = limit /. {HarmonicNumber[q_] :> PolyGamma[0, 1 + q] + EulerGamma,
      Csc[Pi q_] :> Gamma[q] Gamma[1 - q]/Pi,
      Sec[Pi q_] :> Gamma[1/2 + q] Gamma[1/2 - q]/Pi};
    If[limit === $Failed || !FreeQ[limit, reg | v | Indeterminate | ComplexInfinity | _DirectedInfinity | _Series | _Derivative], Continue[]];
    core = (Times @@ (Gamma /@ num))/Gamma[den];
    gate = transverseGate[core, limit, v, vars, realContour];
    If[!TrueQ[gate["pass"]], Continue[]];
    result = <|"Expression" -> p["rest"] limit, "Variable" -> v,
      "Contour" -> DeleteCases[ctr, Rule[v, _]], "Variables" -> DeleteCases[vars, v],
      "Proof" -> <|"Class" -> If[balance === 0, "FixedContourBarnesII", "ContiguousFixedContourBarnesII"],
        "BalanceOffset" -> balance, "CanonicalMultiplier" -> (multiplier /. reg -> 0), "GammaLegs" -> num,
        "DenominatorLeg" -> den, "Orientation" -> orientation,
        "ReciprocalLift" -> p["ReciprocalLift"], "CrossedPoles" -> crosses,
        "CollectiveDeformationLimit" -> True, "Gate" -> gate|>|>;
    Break[], {p, parses}];
  result];
End[];
EndPackage[];
Print["[mbeParameterBarnesSecondRung] balanced five-Gamma and affine reciprocal classes, fixed-contour collective residues."];
