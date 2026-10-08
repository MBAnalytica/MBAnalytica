(* Fixed-contour transverse Barnes classes with exact crossed residues.
   External scales determine null directions, not target identifiers.
   Auxiliary deformation separates coincident poles only during the identity;
   its collective limit is taken before accepting the reduced expression. *)
BeginPackage["MBParameter`"];
Begin["`Private`"];
ClearAll[transverseCharts, transverseGate, fixedBarnesVariable, fixedBarnesVariableUncached, transverseClose,
  transversePoleOnContourQ, transverseGenericContour];

(* A reduced piece can carry a pole exactly ON the reduced contour although the complete reduction is regular
   there: the crossed residues of a degenerate lemma whose poles coincide on a special hyperplane of the
   resolver's rational contour (e.g. z1 + z2 = 0).  The pieces are closed one by one, so each must be pole-free
   on its own contour. *)
transversePoleOnContourQ[expr_, ctr_, vars_] := Module[{legs, rat},
  legs = Union[Cases[expr, Gamma[l_] :> l, {0, Infinity}], Cases[expr, PolyGamma[_, l_] :> l, {0, Infinity}]];
  legs = Select[legs, !FreeQ[#, Alternatives @@ vars] &];
  rat = Cases[expr, Power[p_, _Integer?Negative] /; !FreeQ[p, Alternatives @@ vars] && PolynomialQ[p, vars] :> p,
    {0, Infinity}];
  AnyTrue[legs, With[{x = # /. ctr}, IntegerQ[x] && x <= 0] &] || AnyTrue[rat, (# /. ctr) === 0 &]];

(* A point of the SAME pole chamber of the source kernel -- every Gamma/polygamma argument keeps its open cell
   between consecutive poles and every rational factor its sign -- displaced by distinct small rationals, together
   with the Stirling decay certificate of the kernel.  The contour integral is therefore unchanged, and the new
   point is generic for the reduction (no reduced leg sits on an integer).  Exact checks only. *)
transverseGenericContour[ig_, ctr_, vars_, dom_] := Module[
  {legs, rat, vals, margins, grad, step, deltas, new, sameCell, decay},
  legs = Union[Cases[ig, Gamma[l_] :> l, {0, Infinity}], Cases[ig, PolyGamma[_, l_] :> l, {0, Infinity}]];
  legs = Select[legs, !FreeQ[#, Alternatives @@ vars] &];
  rat = DeleteDuplicates@Cases[ig, Power[p_, _Integer?Negative] /; !FreeQ[p, Alternatives @@ vars] &&
    PolynomialQ[p, vars] :> p, {0, Infinity}];
  If[legs === {} || !AllTrue[Join[legs, rat], affineQ[#, vars] &], Return[$Failed, Module]];
  vals = legs /. ctr;
  If[!AllTrue[Join[vals, rat /. ctr], MatchQ[#, _Integer | _Rational] &] ||
    AnyTrue[vals, IntegerQ[#] && # <= 0 &], Return[$Failed, Module]];
  margins = Join[If[# > 0, #, Min[# - Floor[#], Ceiling[#] - #]] & /@ vals, Abs[rat /. ctr]];
  If[!AllTrue[margins, TrueQ[# > 0] &], Return[$Failed, Module]];
  grad = Max[1, Max[Total[Abs[Coefficient[#, vars]]] & /@ Join[legs, rat]]];
  step = Min[margins]/(4 grad);
  deltas = Table[step Prime[i + 4]/Prime[Length[vars] + 12], {i, Length[vars]}];
  new = Thread[vars -> (vars /. ctr) + deltas];
  sameCell = AllTrue[Transpose[{legs, vals}], With[{x = #[[1]] /. new, x0 = #[[2]]},
      If[x0 > 0, x > 0, !IntegerQ[x] && Floor[x] === Floor[x0]]] &] &&
    AllTrue[rat, Sign[# /. new] === Sign[# /. ctr] &];
  If[!sameCell, Return[$Failed, Module]];
  decay = contourDecayCertificate[ig, vars, dom];
  If[!AssociationQ[decay], Return[$Failed, Module]];
  <|"Contour" -> new, "OriginalContour" -> ctr, "SamePoleChamber" -> True, "DecayCertificate" -> decay,
    "Displacement" -> deltas|>];

transverseCharts[ig_, vars_, ctr_] := Module[{kin, rows, directions, charts, n = Length[vars], mat, sub, transformed},
  charts = {<|"Kernel" -> ig, "Contour" -> ctr, "Matrix" -> IdentityMatrix[n]|>};
  If[n > 7, Return[charts, Module]];
  kin = Select[factors[ig], MatchQ[#, _Power] && !FreeQ[#[[2]], Alternatives @@ vars] &];
  If[!AllTrue[kin, FreeQ[#[[1]], Alternatives @@ vars] && affineQ[#[[2]], vars] &], Return[charts, Module]];
  rows = Table[Coefficient[k[[2]], #] & /@ vars, {k, kin}];
  directions = Select[Tuples[{-1, 0, 1}, n], Function[w, w =!= ConstantArray[0, n] &&
    First[DeleteCases[w, 0]] === 1 && AllTrue[rows, Function[r, r.w === 0]]]];
  Do[Do[If[w[[j]] =!= 0,
    mat = Transpose@ReplacePart[IdentityMatrix[n], j -> w/w[[j]]];
    If[mat === IdentityMatrix[n], Continue[]];
    sub = Thread[vars -> mat.vars];
    transformed = ig /. sub;
    transformed = transformed /. Power[b_, p_] /; !FreeQ[p, Alternatives @@ vars] :> b^Expand[p];
    AppendTo[charts, <|"Kernel" -> transformed,
      "Contour" -> Thread[vars -> (Inverse[mat].(vars /. ctr))], "Matrix" -> mat|>]], {j, n}], {w, directions}];
  DeleteDuplicatesBy[charts, {#["Kernel"], #["Contour"]} &]];

transverseGate[ig_, val_, v_, vars_, ctr_] := Module[{others = DeleteCases[vars, v], checks = {}, pt, num, pred, err, t},
  Do[pt = MapIndexed[#1 -> (#1 /. ctr) + I sign (2 First[#2] + 1)/23 &, others];
    pred = Quiet@N[val /. pt, 30];
    num = Quiet@TimeConstrained[NIntegrate[
      Evaluate[(ig /. pt) /. v -> (v /. ctr) + I t], {t, -22, 0, 22},
      WorkingPrecision -> 30, AccuracyGoal -> 12, PrecisionGoal -> 10, MaxRecursion -> 14]/(2 Pi), 30, $Failed];
    err = If[NumericQ[num] && NumericQ[pred], Abs[num - pred]/(1 + Abs[pred]), Infinity];
    AppendTo[checks, <|"Spectators" -> pt, "RelativeError" -> err, "Pass" -> TrueQ[err < 10^-8]|>], {sign, {1, -1}}];
  <|"pass" -> AllTrue[checks, TrueQ[#["Pass"]] &], "checks" -> checks,
    "qualification" -> "Exact Barnes identity with crossed residues; independent one-dimensional numerical diagnostics."|>];

fixedBarnesVariable[ig_, v_, vars_, ctr_] := Module[{key, cached, result},
  If[!AssociationQ[$fixedBarnesMemo], Return[Block[{$fixedBarnesMemo = <||>},
    fixedBarnesVariable[ig, v, vars, ctr]], Module]];
  key = Hash[{ig, v, vars, ctr}, "SHA256"];
  cached = Lookup[$fixedBarnesMemo, key, None];
  If[cached =!= None, Return[cached, Module]];
  result = fixedBarnesVariableUncached[ig, v, vars, ctr];
  If[!AssociationQ[result] && DownValues[fixedSecondBarnesVariable] =!= {},
    result = fixedSecondBarnesVariable[ig, v, vars, ctr]];
  If[AssociationQ[result], AssociateTo[$fixedBarnesMemo, key -> result]];
  result];

fixedBarnesVariableUncached[ig_, v_, vars_, ctr_] := Module[
  {psi, source = ig, p, legs, plus, minus, a, b, cs, reg, aux, shifted, terms, crosses = {},
   target, sign, pole, rest, sum, limit, gate, originalCore, reallegs, derivativeIndex = None},
  psi = DeleteDuplicates@Cases[ig, q : PolyGamma[_, l_] /; !FreeQ[l, v] :> q, {0, Infinity}];
  If[Length[psi] > 1 || (psi =!= {} && First[psi][[1]] =!= 0), Return[$Failed, Module]];
  If[psi =!= {},
    source = Cancel[ig/First[psi]];
    If[!FreeQ[source, q : PolyGamma[_, l_] /; !FreeQ[l, v]], Return[$Failed, Module]]];
  p = Global`mbeBPRParse[source, v]; If[p === $Failed, Return[$Failed, Module]];
  p = Global`mbeBPRDenToPoly[p, v]; If[p === $Failed, Return[$Failed, Module]];
  legs = p["num"];
  plus = Flatten@Position[Coefficient[#, v] & /@ legs, 1];
  minus = Flatten@Position[Coefficient[#, v] & /@ legs, -1];
  If[Length[plus] =!= 2 || Length[minus] =!= 2 || Exponent[p["poly"], v] > 16,
    Return[$Failed, Module]];
  If[psi =!= {},
    derivativeIndex = SelectFirst[Range[4], Expand[legs[[#]] - First[psi][[2]]] === 0 &, None];
    If[derivativeIndex === None, Return[$Failed, Module]]];
  reallegs = legs /. ctr;
  If[!AllTrue[reallegs, MatchQ[#, _Rational | _Integer] &] ||
    AnyTrue[reallegs, IntegerQ[#] && # <= 0 &], Return[$Failed, Module]];
  shifted = MapIndexed[#1 + First[#2] reg &, legs];
  If[derivativeIndex =!= None, shifted[[derivativeIndex]] += aux];
  a = (shifted[[plus]] /. v -> 0); b = (shifted[[minus]] /. v -> 0);
  cs = Global`mbeBPRNewton[p["poly"], v, First[a]];
  terms = Table[cs[[j + 1]] Times @@ Flatten[Outer[Gamma[#1 + #2] &, a + {j, 0}, b]]/
    Gamma[Total[a] + Total[b] + j], {j, 0, Length[cs] - 1}];
  Do[sign = Coefficient[legs[[i]], v];
    Do[pole = -sign (shifted[[i]] /. v -> 0) - sign k;
      rest = Delete[shifted, i];
      AppendTo[terms, -(-1)^k/k! (p["poly"] /. v -> pole) Times @@ (Gamma[# /. v -> pole] & /@ rest)];
      AppendTo[crosses, <|"Leg" -> legs[[i]], "Index" -> k, "Orientation" -> sign|>],
      {k, 0, Ceiling[-reallegs[[i]]] - 1}], {i, 4}];
  sum = Total[terms];
  If[derivativeIndex =!= None, sum = D[sum, aux] /. aux -> 0];
  limit = If[crosses === {},
    Quiet@TimeConstrained[FullSimplify[sum /. reg -> 0], 10, $Failed],
    Quiet@TimeConstrained[FullSimplify[Normal@Series[sum, {reg, 0, 0}]], 25, $Failed]];
  limit = limit /. {HarmonicNumber[q_] :> PolyGamma[0, 1 + q] + EulerGamma,
    Csc[Pi q_] :> Gamma[q] Gamma[1 - q]/Pi,
    Sec[Pi q_] :> Gamma[1/2 + q] Gamma[1/2 - q]/Pi};
  If[limit === $Failed || !FreeQ[limit, reg | aux | v | Indeterminate | ComplexInfinity | _DirectedInfinity | _Series | _Derivative],
    Return[$Failed, Module]];
  originalCore = p["poly"] Times @@ (Gamma /@ legs) If[psi === {}, 1, First[psi]];
  gate = transverseGate[originalCore, limit, v, vars, ctr];
  If[!TrueQ[gate["pass"]], Return[$Failed, Module]];
  <|"Expression" -> p["rest"] limit, "Variable" -> v,
    "Contour" -> DeleteCases[ctr, Rule[v, _]], "Variables" -> DeleteCases[vars, v],
    "Proof" -> <|"Class" -> "FixedContourBarnesI", "GammaLegs" -> legs,
      "CrossedPoles" -> crosses, "AuxiliaryGammaDerivative" -> (derivativeIndex =!= None),
      "CollectiveDeformationLimit" -> True, "Gate" -> gate|>|>];

transverseClose[ig_, ctr_, vars_, pars_, dom_, seconds_] := Module[
  {charts, red, pieces, values, checks, trace, value, generic, displaced, finalGate},
  If[Length[vars] < 2 || TrueQ[$transverseDepth >= 6], Return[$Failed, Module]];
  charts = transverseCharts[ig, vars, ctr];
  Do[Do[red = fixedBarnesVariable[ch["Kernel"], v, vars, ch["Contour"]];
    If[!AssociationQ[red], Continue[]];
    pieces = If[Head[Expand[red["Expression"]]] === Plus, List @@ Expand[red["Expression"]], {red["Expression"]}];
    displaced = None;
    (* A piece with a pole on the reduced contour: redo the reduction from a generic point of the source's own
       pole chamber (same integral), where the reduced contour avoids the special hyperplane. *)
    If[AnyTrue[pieces, transversePoleOnContourQ[#, red["Contour"], red["Variables"]] &],
      generic = transverseGenericContour[ch["Kernel"], ch["Contour"], vars, dom];
      If[!AssociationQ[generic], Continue[]];
      red = fixedBarnesVariable[ch["Kernel"], v, vars, generic["Contour"]];
      If[!AssociationQ[red], Continue[]];
      pieces = If[Head[Expand[red["Expression"]]] === Plus, List @@ Expand[red["Expression"]], {red["Expression"]}];
      If[AnyTrue[pieces, transversePoleOnContourQ[#, red["Contour"], red["Variables"]] &], Continue[]];
      displaced = generic];
    checks = {}; values = {};
    Do[value = Block[{$transverseDepth = If[IntegerQ[$transverseDepth], $transverseDepth + 1, 1]},
        closePiece[piece, red["Contour"], red["Variables"], pars, dom, seconds]];
      If[FailureQ[value] || value === $Failed, Break[]];
      AppendTo[values, value]; AppendTo[checks, $lastSourceGate], {piece, pieces}];
    If[Length[values] === Length[pieces] && exactQ[Total[values], pars],
      (* after a chamber displacement the total is also gated against the ORIGINAL kernel on its original contour *)
      finalGate = If[displaced === None, None,
        If[TrueQ[sourceGate[ig, ctr, vars, Total[values], pars, parameterPoints[pars, dom]]], $lastSourceGate, $Failed]];
      If[finalGate =!= $Failed,
        $lastSourceGate = <|"pass" -> True, "Method" -> "TransverseBarnesChain",
          "CoordinateMatrix" -> ch["Matrix"], "Reduction" -> red["Proof"], "RemainingChecks" -> checks,
          "GenericChamberPoint" -> displaced, "OriginalSourceGate" -> finalGate|>;
        Return[Total[values], Module]]], {v, vars}], {ch, charts}];
  $lastSourceGate = <|"pass" -> False, "reason" -> "No complete transverse Barnes chain closed."|>;
  $Failed];
End[];
EndPackage[];
Print["[mbeParameterTransverseRung] fixed contours, null-scale directions, collective degenerate limits, Gamma differentiation."];
