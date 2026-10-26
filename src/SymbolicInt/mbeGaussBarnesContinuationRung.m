(* Development class rung; independent original-route coefficient audits passed
   on MB9 residues 9/14 and MB6 residue 8 before installation.
   Meromorphic five-Gamma Barnes continuation plus explicit simple-pole
   corrections for a nonseparating original straight contour. *)
sgcFail[why_] := Throw[<|"Reduced" -> False, "Reason" -> why|>, sgcTag];
sgcNonpositiveIntegerQ[x_] := IntegerQ[x] && x <= 0;
sgcReduceOne[expr_, zz_, ep_, contour_] := Catch[Module[
  {parsed, plus, minus, den, cv, amp, delta = 1/40, origin, slope, margin,
   corrections = {}, pole, args, res, nmax, choices = {}, aa, bb, cc, dd, ee, ff,
   ss, gap, excess, pref, pfq, rank, answer},
  parsed = mbeBPRParse[expr, zz];
  If[parsed === $Failed || ! FreeQ[parsed["poly"], zz], sgcFail["not a pure Gamma ratio"]];
  plus = Select[parsed["num"], Coefficient[#, zz] === 1 &];
  minus = Select[parsed["num"], Coefficient[#, zz] === -1 &]; den = parsed["den"];
  If[Length[plus] =!= 3 || Length[minus] =!= 2 || Length[den] =!= 1 ||
      Coefficient[First[den], zz] =!= 1, sgcFail["not the three-plus/two-minus/one-plus class"]];
  If[! AllTrue[Join[plus, minus, den], sbrAffineQ[#, {zz, ep}] &],
    sgcFail["parameters are not rational-affine"]];
  cv = Rationalize[contour, 0]; If[! sbrRationalQ[cv], sgcFail["contour is not rational real"]];
  plus = Expand[# /. zz -> 0] & /@ plus; minus = Expand[# /. zz -> 0] & /@ minus;
  ff = Expand[First[den] /. zz -> 0]; amp = parsed["rest"] parsed["poly"];
  If[AnyTrue[Expand /@ Flatten[Outer[Plus, plus, minus]], sgcNonpositiveIntegerQ],
    sgcFail["permanent opposite-family collision requires an extra regulator"]];
  (* Keep the original line off every numerator pole, with constant crossing counts. *)
  Do[origin = form /. ep -> 0; slope = Coefficient[form, ep];
    If[sgcNonpositiveIntegerQ[origin], sgcFail["numerator pole on original contour at epsilon zero"]];
    margin = If[origin > 0, origin, Min[origin - Floor[origin], Ceiling[origin] - origin]];
    If[slope =!= 0, delta = Min[delta, margin/(2 Abs[slope])]],
    {form, Join[plus + cv, minus - cv]}];
  (* I_rho = meromorphic separating value + right residues left of rho
      - left residues right of rho.  Only simple crossings are admitted. *)
  Do[nmax = Ceiling[-(plus[[jj]] /. ep -> 0) - cv] - 1;
    If[nmax > 40, sgcFail["crossing-count budget"]];
    Do[pole = Expand[-plus[[jj]] - nn];
      args = Expand /@ Join[Delete[plus, jj] + pole, minus - pole];
      If[AnyTrue[args, sgcNonpositiveIntegerQ], sgcFail["multiple crossed pole"]];
      res = amp (-1)^nn/nn! Times @@ (Gamma /@ args)/Gamma[ff + pole];
      AppendTo[corrections, <|"Family" -> "Left", "Pole" -> pole,
        "Residue" -> res, "Contribution" -> -res|>], {nn, 0, nmax}], {jj, 3}];
  Do[nmax = Ceiling[cv - (minus[[jj]] /. ep -> 0)] - 1;
    If[nmax > 40, sgcFail["crossing-count budget"]];
    Do[pole = Expand[minus[[jj]] + nn];
      args = Expand /@ Join[plus + pole, Delete[minus, jj] - pole];
      If[AnyTrue[args, sgcNonpositiveIntegerQ], sgcFail["multiple crossed pole"]];
      res = -amp (-1)^nn/nn! Times @@ (Gamma /@ args)/Gamma[ff + pole];
      AppendTo[corrections, <|"Family" -> "Right", "Pole" -> pole,
        "Residue" -> res, "Contribution" -> res|>], {nn, 0, nmax}], {jj, 2}];
  Do[cc = plus[[jj]]; {aa, bb} = Delete[plus, jj];
    dd = minus[[kk]]; ee = minus[[3 - kk]]; ss = Expand[aa + bb + dd + ee];
    gap = Expand[ff - cc]; excess = Expand[cc + dd];
    If[! TrueQ[(excess /. ep -> 0) > 0], Continue[]];
    pref = amp Gamma[aa + dd] Gamma[aa + ee] Gamma[bb + dd] Gamma[bb + ee]
      Gamma[cc + ee]/(Gamma[ss] Gamma[ff + ee]);
    pfq = HypergeometricPFQ[{aa + ee, bb + ee, gap}, {ss, ff + ee}, 1];
    If[! FreeQ[{pref, pfq}, Indeterminate | ComplexInfinity | _DirectedInfinity], Continue[]];
    rank = {If[TrueQ[(gap /. ep -> 0) === 0], 0, 1], -(excess /. ep -> 0)};
    AppendTo[choices, {rank, <|"Reduced" -> True, "Prefactor" -> pref, "PFQ" -> pfq,
      "Parameters" -> {aa, bb, cc, dd, ee, ff}, "Excess" -> excess|>}], {jj, 3}, {kk, 2}];
  If[choices === {}, sgcFail["no finite representation with positive terminal excess at zero"]];
  answer = Last[First[SortBy[choices, First]]];
  slope = Coefficient[answer["Excess"], ep];
  If[slope =!= 0, delta = Min[delta, (answer["Excess"] /. ep -> 0)/(2 Abs[slope])]];
  Join[answer, <|"Correction" -> Total[Lookup[corrections, "Contribution", {}]],
    "Crossings" -> corrections, "Contour" -> cv, "EpsilonInterval" -> {-delta, delta},
    "Certificate" -> "meromorphic five-Gamma identity and explicit simple crossings"|>]], sgcTag];

sgcReduceTerm[term_, ep_] := Module[{ctr = term[[2, 2]], zz, ww, cv, result},
  If[Length[ctr] =!= 1, Return[<|"Reduced" -> False, "Reason" -> "one fold required"|>]];
  zz = First[Keys[ctr]]; cv = First[Values[ctr]];
  result = sgcReduceOne[term[[1]], zz, ep, cv];
  If[TrueQ[result["Reduced"]], Return[Join[result, <|"Direction" -> "RIGHT"|>]]];
  ww = Unique["sgcReflected"];
  result = sgcReduceOne[term[[1]] /. zz -> -ww, ww, ep, -cv];
  Join[result, <|"Direction" -> "LEFT"|>]];

sgcResidueLaurent[term_, ep_, lo_Integer, hi_Integer, verbose_:False] := Module[
  {red, depth, expanded, series, result, start = AbsoluteTime[]},
  red = sgcReduceTerm[term, ep]; Global`$sgcLastRun = <|"Reduction" -> red, "Closed" -> False|>;
  If[! TrueQ[red["Reduced"]], Return[$Failed]];
  depth = Max[0, hi - oftLeadOrder[red["Prefactor"], ep, Max[0, hi]]];
  If[verbose, Print["    [Gauss-Barnes continuation] ", Length[red["Crossings"]],
    " simple crossings; excess ", red["Excess"], "; depth ", depth]];
  expanded = If[FreeQ[red["PFQ"], HypergeometricPFQ | Hypergeometric2F1], red["PFQ"],
    hbbExpand[red["PFQ"], ep, depth, 1800]["Expansion"]];
  If[! hbbExactQ[expanded], Return[$Failed]];
  series = Series[red["Prefactor"] expanded + red["Correction"], {ep, 0, hi}];
  result = (Expand[mbeCanonicalConstants[#]] &) /@ Table[abtCoefficient[series, ep, jj], {jj, lo, hi}];
  If[abtUnfinishedQ[result] || ! FreeQ[result, ep | $Failed | $Aborted | Indeterminate | ComplexInfinity | _DirectedInfinity] ||
      ! MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[result], Return[$Failed]];
  Global`$sgcLastRun = <|"Reduction" -> red, "Closed" -> True, "Depth" -> depth,
    "Orders" -> {lo, hi}, "Seconds" -> AbsoluteTime[] - start|>;
  result];

Print["[mbeGaussBarnesContinuationRung] nonseparating five-Gamma contours with explicit simple residues and positive terminal excess."];
