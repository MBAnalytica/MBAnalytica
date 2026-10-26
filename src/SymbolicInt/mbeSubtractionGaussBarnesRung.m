(* Five numerator Gamma legs (three +z, two -z), one +z denominator,
   no other z dependence, and a straight separating original contour.
   Beta-pair one numerator with the denominator, use the four-Gamma
   scaled Barnes kernel, then take its Euler moment.  The resulting
   3F2(1) has strictly positive excess at epsilon zero.  Reflection
   supplies the opposite orientation.  No target identifiers. *)
sgbFail[reason_] := Throw[<|"Reduced" -> False, "Reason" -> reason|>, sgbTag];
sgbReduceOne[f_, zz_, ep_, contour_] := Catch[Module[
  {parsed, plus, minus, denominator, cv, choices = {}, aa, bb, cc, dd, ee, ff, ss,
   gap, forms, delta, slope, origin, sign, pref, pfq, rank, chosen},
  parsed = mbeBPRParse[f, zz];
  If[parsed === $Failed || ! FreeQ[parsed["poly"], zz], sgbFail["not a pure Gamma ratio"]];
  plus = Select[parsed["num"], Coefficient[#, zz] === 1 &];
  minus = Select[parsed["num"], Coefficient[#, zz] === -1 &];
  denominator = parsed["den"];
  If[Length[plus] =!= 3 || Length[minus] =!= 2 || Length[denominator] =!= 1 ||
    Coefficient[First[denominator], zz] =!= 1, sgbFail["not the three-plus/two-minus/one-plus class"]];
  If[! AllTrue[Join[plus, minus, denominator], sbrAffineQ[#, {zz, ep}] &],
    sgbFail["parameters are not rational-affine"]];
  cv = Rationalize[contour, 0];
  If[! sbrRationalQ[cv], sgbFail["contour is not real rational"]];
  If[! AllTrue[Join[plus, minus], TrueQ[(# /. {zz -> cv, ep -> 0}) > 0] &],
    sgbFail["original contour is not strictly separating at epsilon zero"]];
  plus = Expand[# /. zz -> 0] & /@ plus;
  minus = Expand[# /. zz -> 0] & /@ minus;
  ff = Expand[First[denominator] /. zz -> 0];
  Do[
    cc = plus[[jj]]; {aa, bb} = Delete[plus, jj]; {dd, ee} = minus;
    gap = Expand[ff - cc]; ss = Expand[aa + bb + dd + ee];
    forms = Expand /@ Join[plus + cv, minus - cv, {gap}];
    delta = 1/40;
    Do[origin = form /. ep -> 0; slope = Coefficient[form, ep];
      If[TrueQ[origin > 0] && slope =!= 0, delta = Min[delta, origin/(2 Abs[slope])]], {form, forms}];
    sign = SelectFirst[{1, -1}, Function[sg,
      AllTrue[forms, TrueQ[(# /. ep -> 0) >= 0 && (# /. ep -> sg delta) > 0] &]], None];
    If[sign === None, Continue[]];
    pref = parsed["rest"] parsed["poly"] Gamma[aa + dd] Gamma[aa + ee]
      Gamma[bb + dd] Gamma[bb + ee] Gamma[cc + ee]/(Gamma[ss] Gamma[ff + ee]);
    pfq = HypergeometricPFQ[{aa + ee, bb + ee, gap}, {ss, ff + ee}, 1];
    rank = {If[TrueQ[(gap /. ep -> 0) === 0], 0, 1], -((cc + dd) /. ep -> 0)};
    AppendTo[choices, {rank, <|"Reduced" -> True, "Prefactor" -> pref, "PFQ" -> pfq,
      "Parameters" -> {aa, bb, cc, dd, ee, ff}, "Excess" -> Expand[cc + dd],
      "EpsilonInterval" -> Sort[{0, sign delta}], "Contour" -> cv|>}], {jj, 3}];
  If[choices === {}, sgbFail["no positive beta gap on either epsilon half-interval"]];
  Last[First[SortBy[choices, First]]]], sgbTag];

sgbReduceTerm[term_, ep_] := Module[{ctr, zz, value, ww, cv},
  ctr = term[[2, 2]]; If[Length[ctr] =!= 1, Return[<|"Reduced" -> False, "Reason" -> "one fold required"|>]];
  zz = First[Keys[ctr]]; cv = First[Values[ctr]];
  value = sgbReduceOne[term[[1]], zz, ep, cv];
  If[TrueQ[value["Reduced"]], Return[Join[value, <|"Direction" -> "RIGHT"|>]]];
  ww = Unique["sgbReflected"];
  value = sgbReduceOne[term[[1]] /. zz -> -ww, ww, ep, -cv];
  Join[value, <|"Direction" -> "LEFT"|>]];

sgbResidueLaurent[term_, ep_, lo_Integer, hi_Integer, verbose_: False] := Module[
  {red, pref, pfq, depth, expanded, series, result, start = AbsoluteTime[]},
  red = sgbReduceTerm[term, ep]; Global`$sgbLastRun = <|"Reduction" -> red, "Closed" -> False|>;
  If[! TrueQ[red["Reduced"]], Return[$Failed]];
  pref = red["Prefactor"]; pfq = red["PFQ"];
  depth = Max[0, hi - oftLeadOrder[pref, ep, Max[0, hi]]];
  If[verbose, Print["    [Gauss-Barnes] excess ", red["Excess"], "; depth ", depth, "; PFQ ", pfq]];
  expanded = If[FreeQ[pfq, HypergeometricPFQ | Hypergeometric2F1], pfq,
    hbbExpand[pfq, ep, depth, 1800]["Expansion"]];
  If[! hbbExactQ[expanded], Return[$Failed]];
  series = Series[pref expanded, {ep, 0, hi}];
  result = (Expand[mbeCanonicalConstants[#]] &) /@ Table[abtCoefficient[series, ep, jj], {jj, lo, hi}];
  If[abtUnfinishedQ[result] || ! FreeQ[result, ep | $Failed | $Aborted | Indeterminate | ComplexInfinity | _DirectedInfinity] ||
    ! MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[result], Return[$Failed]];
  Global`$sgbLastRun = <|"Reduction" -> red, "Closed" -> True, "Depth" -> depth,
    "Orders" -> {lo, hi}, "Seconds" -> AbsoluteTime[] - start|>;
  result];

Print["[mbeSubtractionGaussBarnesRung] separating five-Gamma class -> convergent 3F2(1) with beta-interval and excess certificates."];
