(* Six-Gamma two-scale classes, derived through a beta integral and one
   Mellin inversion. The scales are arbitrary expressions satisfying the
   stated domains. No target names, stored answers or numerical coefficients.
   H = Gamma(-a)^2 Gamma(-b) Gamma(b) Gamma(a-b) Gamma(a+b).
   Constant and linear polynomial insertions in a,b are covered. *)
BeginPackage["MBParameter`"];
Begin["`Private`"];
ClearAll[parameterShuffle, parameterWordProduct, parameterPolynomialWordIntegral,
  parameterRationalWordIntegral, sixGammaNormalize, sixGammaHValue, sixGammaPValue,
  sixGammaClose, sixGammaCloseAtOrigin, chamberCrossedPoles, chamberResidue, chamberTranslate,
  sixGammaTranslateClose, chamberCloseLinear];

parameterShuffle[{}, b_List] := {b};
parameterShuffle[a_List, {}] := {a};
parameterShuffle[a_List, b_List] /; a =!= {} && b =!= {} := Join[
  Prepend[#, First[a]] & /@ parameterShuffle[Rest[a], b],
  Prepend[#, First[b]] & /@ parameterShuffle[a, Rest[b]]];
parameterWordProduct[a_List, b_List] := Flatten[Table[
  {r[[1]] s[[1]], #} & /@ parameterShuffle[r[[2]], s[[2]]], {r, a}, {s, b}], 2];

(* Exact integration against GPL words. A rational kernel is split into its
   polynomial part and simple poles; polynomial pieces use integration by
   parts. Endpoint-one words are assembled in the common shuffle convention. *)
parameterPolynomialWordIntegral[n_Integer, {}] := 1/(n + 1);
parameterPolynomialWordIntegral[n_Integer, w_List] /; w =!= {} :=
  (regG[w] - Total@Table[If[j === 0, 1, First[w]^j] parameterPolynomialWordIntegral[n - j, Rest[w]], {j, 0, n}] -
    First[w]^(n + 1) regG[w])/(n + 1);
parameterRationalWordIntegral[f_, v_, w_List] := Module[
  {r = Factor[f], num, den, polynomial, remainder, fl, roots = {}, rr, result, coefficient,
   constant, key, saved, residues = {}, raw},
  If[r === 0, Return[0, Module]];
  constant = Times @@ Select[factors[r], FreeQ[#, v] &]; r = Cancel[r/constant];
  key = Hash[{r, v}, "SHA256"];
  saved = If[AssociationQ[$sixGammaPartialFractions], Lookup[$sixGammaPartialFractions, key, None], None];
  If[AssociationQ[saved], Return[constant (Total@Table[Coefficient[saved["Polynomial"], v, n]
        parameterPolynomialWordIntegral[n, w], {n, 0, Max[0, Exponent[saved["Polynomial"], v]]}] +
      Total[(#[[1]] regG[Prepend[w, #[[2]]]]) & /@ saved["Residues"]]), Module]];
  num = Numerator[r]; den = Denominator[r];
  If[!PolynomialQ[num, v] || !PolynomialQ[den, v], Return[$Failed, Module]];
  {polynomial, remainder} = PolynomialQuotientRemainder[num, den, v];
  result = Total@Table[Coefficient[polynomial, v, n] parameterPolynomialWordIntegral[n, w],
    {n, 0, Max[0, Exponent[polynomial, v]]}];
  If[remainder === 0, Return[constant result, Module]];
  fl = Select[FactorList[den], !FreeQ[First[#], v] &];
  If[AnyTrue[fl, Last[#] =!= 1 || Exponent[First[#], v] > 2 &], Return[$Failed, Module]];
  Do[rr = v /. Solve[First[q] == 0, v];
    If[Length[rr] =!= Exponent[First[q], v], Return[$Failed, Module]];
    roots = Join[roots, rr], {q, fl}];
  Do[raw = (remainder /. v -> root)/(D[den, v] /. v -> root);
    coefficient = Quiet@TimeConstrained[FullSimplify[raw], 2, Together[raw]];
    If[!FreeQ[coefficient, Indeterminate | ComplexInfinity | _DirectedInfinity], Return[$Failed, Module]];
    AppendTo[residues, {coefficient, root}];
    result += coefficient regG[Prepend[w, root]], {root, roots}];
  If[AssociationQ[$sixGammaPartialFractions], AssociateTo[$sixGammaPartialFractions,
    key -> <|"Polynomial" -> polynomial, "Residues" -> residues|>]];
  constant result];

sixGammaNormalize[ig_, vars_, dom_, pattern_] := Module[
  {a = vars[[1]], b = vars[[2]], sa, sb, p, base, remaining, hit, shift, polynomial},
  sa = splitScale[ig, a, vars, dom]; If[sa === $Failed, Return[$Failed, Module]];
  sb = splitScale[sa["Rest"], b, vars, dom]; If[sb === $Failed, Return[$Failed, Module]];
  p = baseParse[sb["Rest"], vars];
  If[p === $Failed || p["den"] =!= {} || p["psi"] =!= None || Length[p["gam"]] =!= 6,
    Return[$Failed, Module]];
  base = If[pattern === "H", {-a, -a, -b, b, a - b, a + b}, {-a, -a, -b, -b, a + b, a + b}];
  remaining = base;
  polynomial = Times @@ p["poly"] / Times @@ (#[[1]]^#[[2]] & /@ p["rat"]);
  Do[hit = SelectFirst[remaining, IntegerQ[Expand[g - #]] &, None];
    If[hit === None, Return[$Failed, Module]];
    shift = Expand[g - hit]; If[Abs[shift] > 6, Return[$Failed, Module]];
    polynomial *= If[shift >= 0, Product[hit + j, {j, 0, shift - 1}],
      1/Product[hit - j, {j, 1, -shift}]];
    remaining = DeleteCases[remaining, hit, 1, 1], {g, p["gam"]}];
  <|"X" -> Factor[sa["Scale"]], "Y" -> Factor[sb["Scale"]], "Constant" -> p["const"],
    "Polynomial" -> Cancel[polynomial], "GammaLegs" -> p["gam"]|>];

sixGammaHValue[X_, Y_, polynomial_, {a_, b_}, positiveB_] := Module[
  {t = Unique["sixGammaEuler"], v, jac, root, alphaP, alphaM, roots, p, q, ell, j, ja, dy, rows, groups, out},
  v = (1 - t)/(1 - X t^2); jac = Cancel[-D[v, t]/(v (1 - v))];
  root = (1 - 2 X t + X t^2)/(1 - X t^2);
  alphaP = (1 - X t)/(1 - X t^2); alphaM = X t (1 - t)/(1 - X t^2);
  roots = t /. Solve[Y + (1 - Y) t - X t^2 == 0, t];
  p = {{1, {1/X}}, {-1, {1/Sqrt[X]}}, {-1, {-1/Sqrt[X]}}};
  q = {{Log[X], {}}, {1, {0}}, {1, {1}}, {-1, {1/Sqrt[X]}}, {-1, {-1/Sqrt[X]}}};
  ell = Join[({1, {#}} & /@ roots), If[positiveB,
    {{Log[Y], {}}, {-1, {0}}, {-1, {1/X}}}, {{-1, {1}}}]];
  j = parameterWordProduct[p, q];
  ja = Join[({alphaP #[[1]]/root, #[[2]]} & /@ p), ({-alphaM #[[1]]/root, #[[2]]} & /@ q)];
  dy = Y (1 - t)/(Y + (1 - Y) t - X t^2) - If[positiveB, 0, 1];
  rows = Join[
    ({-jac Coefficient[polynomial, a] #[[1]], #[[2]]} & /@ parameterWordProduct[ja, ell]),
    ({-jac Coefficient[polynomial, b] dy #[[1]], #[[2]]} & /@ j),
    ({-jac (polynomial /. {a -> 0, b -> 0}) #[[1]], #[[2]]} & /@ parameterWordProduct[j, ell])];
  out = Block[{$sixGammaPartialFractions = <||>},
    Table[parameterRationalWordIntegral[r[[1]], t, r[[2]]], {r, rows}]];
  If[MemberQ[out, $Failed], $Failed, Total[out]]];

sixGammaPValue[X_, Y_] := Module[{t = Unique["sixGammaEuler"], aa, roots, ds, words},
  roots = t /. Solve[t^2 + (Y - X - 1) t + X == 0, t];
  (* Solve drops repeated roots; logarithmic derivatives retain multiplicity. *)
  If[Length[roots] === 1, roots = Join[roots, roots]];
  aa = If[Together[X - Y] === 0, None, X/(X - Y)];
  ds = Join[({#, 1} & /@ roots), If[aa === None, {}, {{aa, -1}}]];
  Total[Table[Log[X] (regG[{0, d[[1]]}] - regG[{1, d[[1]]}]) -
      (regG[{0, d[[1]], 0}] - regG[{1, d[[1]], 0}]) -
      (regG[{0, d[[1]], 1}] - regG[{1, d[[1]], 1}]) +
      If[aa === None, 0, regG[{0, d[[1]], aa}] - regG[{1, d[[1]], aa}]], {d, ds}] * ds[[All, 2]]]];

sixGammaCloseAtOrigin[ig_, ctr_, vars_, pars_, dom_] := Module[
  {p, a, b, ca, cb, poly, value, t, points = parameterPoints[pars, dom]},
  If[Length[vars] =!= 2, Return[$Failed, Module]];
  Do[{a, b} = vv; ca = a /. ctr; cb = b /. ctr;
    p = sixGammaNormalize[ig, vv, dom, "H"];
    If[AssociationQ[p] && TrueQ[0 < ca < 1 && -1 < cb < 1 && cb != 0] &&
        PolynomialQ[p["Polynomial"], vv] && Max[Total /@ (First /@ CoefficientRules[p["Polynomial"], vv])] <= 1 &&
        AllTrue[Select[p["GammaLegs"], !FreeQ[#, a] && !FreeQ[#, b] &], TrueQ[(# /. ctr) > 0] &] &&
        prove[0 < p["X"] < 1 && p["Y"] > 0, dom],
      value = p["Constant"] sixGammaHValue[p["X"], p["Y"], p["Polynomial"], vv, cb > 0];
      If[exactQ[value, pars] && sourceGate[ig, ctr, vars, value, pars, points],
        $lastSourceGate = Join[$lastSourceGate, <|"Class" -> "SixGammaConic", "Scales" -> {p["X"], p["Y"]},
          "PolynomialInsertion" -> p["Polynomial"], "BChamber" -> Sign[cb]|>]; Return[value, Module]]];
    p = sixGammaNormalize[ig, vv, dom, "P"];
    If[AssociationQ[p] && TrueQ[ca < 0 && cb < 0 && -1 < ca + cb < 0],
      poly = Cancel[p["Polynomial"]/(a + b)]; t = Unique["sixGammaDomain"];
      If[FreeQ[poly, Alternatives @@ vv] &&
          prove[p["X"] + (p["Y"] - p["X"]) t - t (1 - t) > 0, dom && 0 < t < 1],
        value = p["Constant"] poly sixGammaPValue[p["X"], p["Y"]];
        If[exactQ[value, pars] && sourceGate[ig, ctr, vars, value, pars, points],
          $lastSourceGate = Join[$lastSourceGate, <|"Class" -> "SixGammaTriangle", "Scales" -> {p["X"], p["Y"]}|>];
          Return[value, Module]]]], {vv, {vars, Reverse[vars]}}];
  $Failed];

(* Integer translations come from actual single-variable negative Gamma legs.
   The contour is translated with the integrand, so no pole is crossed. This
   exposes contiguous members of the same class without a target-specific
   substitution or an unrecorded contour deformation. *)
(* ---- Chamber translation with exact crossed residues ----
   A kernel of the H or P class whose contour lies outside the class chamber is moved to a point of the chamber,
   one variable at a time along a straight line (the others fixed on their current contours).  With upward contours
   and measure dz/(2 Pi I):  I(c) = I(t) + Sum Res  if t < c,  I(c) = I(t) - Sum Res  if t > c,  the sum running over
   the poles strictly between c and t.  Each residue is the exact Laurent coefficient of the WHOLE integrand at the
   pole hyperplane (multiplicities and polygammas included), an integral in one variable fewer on the current contour
   of the other variables.  Moves need the Stirling decay certificate of the kernel; a pole ON a path end refuses.
   The main term is closed by the class formula at the target, the residues by the ordinary coefficient closer, and
   the total is gated against the original kernel on its original contour. *)
chamberCrossedPoles[ig_, v_, cur_, t_] := Module[
  {c = v /. cur, lo, hi, locs = {}, fs = factors[ig], leg, k, r, r0, pos, onEdge = False, nmax},
  lo = Min[c, t]; hi = Max[c, t];
  Do[leg = Which[
      MatchQ[f, Gamma[_]], f[[1]],
      MatchQ[f, Power[Gamma[_], _Integer?Positive]], f[[1, 1]],
      MatchQ[f, PolyGamma[_, _]], f[[2]],
      MatchQ[f, Power[PolyGamma[_, _], _Integer?Positive]], f[[1, 2]],
      True, None];
    If[leg === None || FreeQ[leg, v], Continue[]];
    k = Coefficient[leg, v]; r = Expand[leg - k v]; r0 = r /. cur;
    If[!IntegerQ[k] || k === 0 || !FreeQ[r, v] || !MatchQ[r0, _Integer | _Rational], Return[$Failed, Module]];
    nmax = Ceiling[Abs[k] Max[Abs[lo], Abs[hi]] + Abs[r0]] + 2;
    Do[pos = (-n - r0)/k;
      If[pos === lo || pos === hi, onEdge = True];
      If[lo < pos < hi, AppendTo[locs, Expand[(-n - r)/k]]], {n, 0, nmax}], {f, fs}];
  Do[If[MatchQ[f, Power[_, _Integer?Negative]] && !FreeQ[f[[1]], v],
      If[!PolynomialQ[f[[1]], v] || Exponent[f[[1]], v] =!= 1, Return[$Failed, Module]];
      k = Coefficient[f[[1]], v]; r = Expand[f[[1]] - k v]; r0 = r /. cur;
      If[!MatchQ[k, _Integer | _Rational] || !MatchQ[r0, _Integer | _Rational], Return[$Failed, Module]];
      pos = -r0/k;
      If[pos === lo || pos === hi, onEdge = True];
      If[lo < pos < hi, AppendTo[locs, Expand[-r/k]]]], {f, fs}];
  If[onEdge, Return[$Failed, Module]];
  DeleteDuplicates[locs]];

chamberResidue[ig_, v_, loc_] := Module[{t = Unique["chamberT"], s, res},
  s = Quiet@TimeConstrained[Series[ig /. v -> loc + t, {t, 0, -1}], 90, $Failed];
  If[s === $Failed, Return[$Failed, Module]];
  If[Head[s] =!= SeriesData, Return[If[FreeQ[s, t], 0, $Failed], Module]];
  res = SeriesCoefficient[s, -1];
  If[!FreeQ[res, t | Indeterminate | ComplexInfinity | _DirectedInfinity | _SeriesData], $Failed, res]];

chamberTranslate[ig_, ctr_, vars_, target_] := Module[{cur = ctr, terms = {}, c, t, poles, res, sign},
  Do[c = v /. cur; t = v /. target;
    If[c === t, Continue[]];
    poles = chamberCrossedPoles[ig, v, cur, t];
    If[poles === $Failed, Return[$Failed, Module]];
    sign = If[t < c, 1, -1];
    Do[res = chamberResidue[ig, v, p];
      If[res === $Failed, Return[$Failed, Module]];
      If[res =!= 0, AppendTo[terms, <|"Expression" -> sign res, "Contour" -> DeleteCases[cur, Rule[v, _]],
        "Variables" -> DeleteCases[vars, v], "Pole" -> (v -> p)|>]], {p, poles}];
    cur = Replace[cur, Rule[v, _] -> Rule[v, t], {1}], {v, vars}];
  <|"Contour" -> cur, "Residues" -> terms|>];

(* A residue is a linear combination (e.g. a double pole gives 2 EulerGamma + Log[X] + PolyGamma[0, ...] + ...);
   close it term by term exactly as the route splits a coefficient: variable-free factor times a product kernel. *)
chamberCloseLinear[expr_, ctr_, vars_, pars_, dom_, seconds_] := Module[{terms, total = 0, constant, kernel, value},
  terms = If[Head[Expand[expr]] === Plus, List @@ Expand[expr], {Expand[expr]}];
  Do[constant = Times @@ Select[factors[tm], FreeQ[#, Alternatives @@ vars] &];
    kernel = Times @@ Select[factors[tm], !FreeQ[#, Alternatives @@ vars] &];
    value = If[vars === {}, kernel, closePiece[kernel, ctr, vars, pars, dom, seconds]];
    If[FailureQ[value] || value === $Failed, Return[$Failed, Module]];
    total += constant value, {tm, terms}];
  total];

$sixGammaTargets = <|
  "P" -> {{-1/3, -1/3}, {-1/4, -1/2}, {-1/2, -1/4}, {-1/5, -1/5}, {-2/5, -1/5}, {-1/5, -2/5}},
  "H" -> Flatten[Table[{x, y}, {x, {1/2, 1/3, 2/3, 1/4, 3/4}}, {y, {1/3, -1/3, 1/4, -1/4, 1/2, -1/2, 1/5, -1/5}}], 1]|>;

sixGammaTranslateClose[ig_, ctr_, vars_, pars_, dom_, seconds_] := Module[
  {p, tr, main, vals, total, points, decay, cands, counts, count},
  If[Length[vars] =!= 2 || TrueQ[$sixGammaTranslating], Return[$Failed, Module]];
  decay = contourDecayCertificate[ig, vars, dom];
  If[!AssociationQ[decay], Return[$Failed, Module]];
  points = parameterPoints[pars, dom];
  count[target_] := Module[{cur = ctr, n = 0, q},
    Do[q = chamberCrossedPoles[ig, v, cur, v /. target]; If[q === $Failed, Return[Infinity, Module]];
      n += Length[q]; cur = Replace[cur, Rule[v, _] -> Rule[v, v /. target], {1}], {v, vars}]; n];
  Do[p = sixGammaNormalize[ig, vv, dom, pat];
    If[!AssociationQ[p], Continue[]];
    cands = Thread[vv -> #] & /@ $sixGammaTargets[pat];
    counts = count /@ cands;
    cands = Pick[cands, (# =!= Infinity &) /@ counts]; counts = DeleteCases[counts, Infinity];
    cands = cands[[Ordering[counts]]];
    Do[tr = chamberTranslate[ig, ctr, vars, target];
      If[!AssociationQ[tr], Continue[]];
      main = Block[{$sixGammaTranslating = True}, sixGammaCloseAtOrigin[ig, tr["Contour"], vars, pars, dom]];
      If[main === $Failed, Continue[]];
      vals = Block[{$sixGammaTranslating = True},
        chamberCloseLinear[#["Expression"], #["Contour"], #["Variables"], pars, dom, seconds] & /@ tr["Residues"]];
      If[AnyTrue[vals, FailureQ[#] || # === $Failed &], Continue[]];
      total = main + Total[vals];
      If[exactQ[total, pars] && sourceGate[ig, ctr, vars, total, pars, points],
        $lastSourceGate = Join[$lastSourceGate, <|"Class" -> "SixGammaChamberTranslation", "Pattern" -> pat,
          "TargetContour" -> tr["Contour"], "CrossedResidues" -> (#["Pole"] & /@ tr["Residues"]),
          "DecayCertificate" -> decay|>];
        Return[total, Module]], {target, Take[cands, UpTo[4]]}], {pat, {"P", "H"}}, {vv, {vars, Reverse[vars]}}];
  $Failed];

sixGammaClose[ig_, ctr_, vars_, pars_, dom_, seconds_: 120] := Module[{legs, shifts, choices, sub, f, cc, value},
  $lastSourceGate = <|"pass" -> False, "reason" -> "No six-Gamma class closed."|>;
  If[Length[vars] =!= 2, Return[$Failed, Module]];
  value = sixGammaCloseAtOrigin[ig, ctr, vars, pars, dom];
  If[value =!= $Failed, Return[value, Module]];
  legs = Cases[ig, Gamma[g_] :> g, Infinity];
  shifts = Table[DeleteDuplicates@Join[{0}, Cases[legs, g_ /;
    Coefficient[g, v] === -1 && FreeQ[g + v, Alternatives @@ vars] &&
      IntegerQ[g + v] && Abs[g + v] <= 6 :> g + v]], {v, vars}];
  choices = DeleteCases[Tuples[shifts], ConstantArray[0, Length[vars]]];
  Do[sub = Thread[vars -> vars + shift];
    f = ig /. sub;
    f = f /. Power[b_, p_] /; !FreeQ[p, Alternatives @@ vars] :> b^Expand[p];
    cc = Thread[vars -> (vars /. ctr) - shift];
    value = sixGammaCloseAtOrigin[f, cc, vars, pars, dom];
    If[value =!= $Failed,
      $lastSourceGate = Join[$lastSourceGate, <|"AffineTranslation" -> sub,
        "OriginalContour" -> ctr, "TranslatedContour" -> cc|>]; Return[value, Module]], {shift, choices}];
  value = sixGammaTranslateClose[ig, ctr, vars, pars, dom, seconds];
  If[value =!= $Failed, Return[value, Module]];
  $lastSourceGate = <|"pass" -> False, "reason" -> "No six-Gamma class closed."|>;
  $Failed];
End[];
EndPackage[];
Print["[mbeParameterSixGammaRung] two-scale beta/Mellin classes, conic GPL closure, exact linear moments, source gate."];
