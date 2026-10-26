(* Epsilon-symbolic Barnes-I reduction for the Subtraction route.
   Class: four unit-slope numerator Gamma legs (two each way), after exact polynomial Gamma cancellations;
   no other dependence on the eliminated variable except a polynomial; a common straight separating contour
   exists throughout a certified negative-epsilon interval; all crossed poles are simple.  The original contour
   is retained by its explicit crossing residues.  No epsilon expansion, numerical producer or target signature.
   Base identity: NIST DLMF 5.13.3, https://dlmf.nist.gov/5.13.E3 .
   Validated against the original faithful cubes for MB6 residues 7 and 12 through epsilon^-2. *)

sbrFail[reason_] := Throw[<|"Reduced" -> False, "Reason" -> reason|>, sbrTag];
sbrRationalQ[x_] := IntegerQ[x] || Head[x] === Rational;
sbrAffineQ[l_, vars_] := PolynomialQ[l, vars] &&
  AllTrue[CoefficientRules[l, vars], Total[First[#]] <= 1 && sbrRationalQ[Last[#]] &];
sbrLine[l_, ctr_, ep_] := Module[{x = Expand[l /. ctr]},
  If[! sbrAffineQ[x, {ep}], sbrFail["the contour real part is not rational-affine in epsilon"]];
  {x /. ep -> 0, Coefficient[x, ep]}];
sbrPositiveIntervalQ[l_, ctr_, ep_, delta_] := With[{q = sbrLine[l, ctr, ep]},
  TrueQ[q[[1]] >= 0 && q[[1]] - delta q[[2]] > 0]];
(* Half the distance to every nearest distinct integer crossing.  A pole exactly at epsilon=0 is an endpoint,
   not an interior crossing; the next integer still bounds the interval.  This also bounds coincidence arguments. *)
sbrSafeInterval[forms_, ctr_, ep_] := Module[{delta = 1/40, q, distances},
  Do[q = sbrLine[l, ctr, ep];
    If[q[[2]] =!= 0,
      distances = DeleteCases[Abs[q[[1]] - #] & /@ Range[Floor[q[[1]]] - 1, Ceiling[q[[1]]] + 1], 0];
      delta = Min[delta, Min[distances]/(2 Abs[q[[2]]])]], {l, forms}];
  delta];

sbrReduceVar[f_, v_, vars_List, ctr0_List, ep_] := Catch[Module[
  {p, plus, minus, aa, bb, sums, forms, ctr, delta, cv, cross = {}, cs, terms, leg, pole, restLegs, pos, value,
   realAt, polynomialCheck},
  If[DownValues[mbeBPRParse] === {} || DownValues[mbeBPRDenToPoly] === {} || DownValues[mbeBPRNewton] === {},
    sbrFail["Barnes polynomial helpers are not loaded"]];
  p = mbeBPRParse[f, v]; If[p === $Failed, sbrFail["dependence outside the four-Gamma/polynomial class"]];
  p = mbeBPRDenToPoly[p, v]; If[p === $Failed, sbrFail["denominator is not an exact polynomial Gamma cancellation"]];
  plus = Select[p["num"], Coefficient[#, v] === 1 &];
  minus = Select[p["num"], Coefficient[#, v] === -1 &];
  If[Length[plus] =!= 2 || Length[minus] =!= 2, sbrFail["not two Gamma legs of each orientation"]];
  If[! AllTrue[Join[plus, minus], sbrAffineQ[#, Append[vars, ep]] &],
    sbrFail["Gamma arguments are not rational-affine in MB variables and epsilon"]];
  ctr = ctr0 /. r_Rule :> (r[[1]] -> Rationalize[r[[2]], 0]);
  aa = Expand[# /. v -> 0] & /@ plus; bb = Expand[# /. v -> 0] & /@ minus;
  sums = Flatten[Outer[Plus, aa, bb]];
  forms = DeleteDuplicates[Expand /@ Join[plus, minus, sums,
    Flatten[Outer[Subtract, aa, aa]], Flatten[Outer[Subtract, bb, bb]]]];
  delta = sbrSafeInterval[forms, ctr, ep];
  If[! AllTrue[sums, sbrPositiveIntervalQ[#, ctr, ep, delta] &],
    sbrFail["no common straight separating contour throughout the negative-epsilon interval"]];
  cv = v /. ctr; If[! sbrRationalQ[cv], sbrFail["missing rational contour"]];
  realAt[l_] := With[{q = sbrLine[l, ctr, ep]}, q[[1]] - delta q[[2]]];
  If[AnyTrue[Join[plus, minus], With[{r = realAt[#]}, IntegerQ[r] && r <= 0] &],
    sbrFail["a Gamma pole lies on the original contour"]];
  Do[Do[AppendTo[cross, {"right", b, j}], {j, 0, Ceiling[cv - realAt[b]] - 1}], {b, bb}];
  Do[Do[AppendTo[cross, {"left", a, j}], {j, 0, Ceiling[-realAt[a] - cv] - 1}], {a, aa}];
  cs = mbeBPRNewton[p["poly"], v, aa[[1]]];
  polynomialCheck = Expand[Sum[cs[[j + 1]] Pochhammer[v + aa[[1]], j], {j, 0, Length[cs] - 1}] - p["poly"]];
  If[! TrueQ[Simplify[polynomialCheck] === 0], sbrFail["Newton expansion did not reproduce the entire polynomial"]];
  terms = Table[p["rest"] cs[[j + 1]]
    Gamma[aa[[1]] + j + bb[[1]]] Gamma[aa[[1]] + j + bb[[2]]]
    Gamma[aa[[2]] + bb[[1]]] Gamma[aa[[2]] + bb[[2]]] /
      Gamma[Total[aa] + Total[bb] + j], {j, 0, Length[cs] - 1}];
  Do[
    {leg, pole} = If[c[[1]] === "right", {Expand[c[[2]] - v], c[[2]] + c[[3]]},
      {Expand[c[[2]] + v], -c[[2]] - c[[3]]}];
    pos = Position[Expand /@ p["num"], leg, {1}, 1, Heads -> False];
    If[pos === {}, sbrFail["crossing leg was not found"]];
    restLegs = Delete[p["num"], First[pos]];
    (* If another leg is a pole identically along a remaining contour, the residue requires derivatives. *)
    If[AnyTrue[restLegs, Function[l, With[{q = sbrLine[Expand[l /. v -> pole], ctr, ep]},
        q[[2]] === 0 && IntegerQ[q[[1]]] && q[[1]] <= 0]]], sbrFail["a crossed pole is not simple"]];
    value = -(-1)^c[[3]]/c[[3]]! p["rest"] (p["poly"] /. v -> pole)
      Times @@ (Gamma[Expand[# /. v -> pole]] & /@ restLegs);
    AppendTo[terms, value], {c, cross}];
  terms = DeleteCases[terms, 0];
  If[! FreeQ[terms, v | Indeterminate | ComplexInfinity | _DirectedInfinity] ||
      Cases[terms, q_?NumberQ /; Precision[q] =!= Infinity, {0, Infinity}, Heads -> True] =!= {},
    sbrFail["reduction is not exact and variable-free"]];
  <|"Reduced" -> True, "Variable" -> v, "Terms" -> terms, "RemainingVariables" -> DeleteCases[vars, v],
    "Contour" -> Select[ctr, First[#] =!= v &], "EpsilonInterval" -> {-delta, 0},
    "PairSums" -> sums, "Crossings" -> cross, "PolynomialDegree" -> Length[cs] - 1|>], sbrTag];

sbrReduceTerm[term_, ep_] := Module[{vars = Keys[term[[2, 2]]], r, refusals = {}},
  Do[r = sbrReduceVar[term[[1]], v, vars, term[[2, 2]], ep];
    If[TrueQ[r["Reduced"]], Return[r, Module]];
    AppendTo[refusals, v -> r["Reason"]], {v, vars}];
  <|"Reduced" -> False, "Reasons" -> refusals|>];

(* Terminal subclass: every resulting one-fold has admissible plain Gamma towers.  Collect their blocks and
   expand at the prefactor-derived depths.  A refused crossed term refuses the whole reduction; there is no
   discarded residue or numerical completion.  The caller may then use the original faithful cube. *)
sbrResidueLaurent[term_, ep_, lo_Integer, hi_Integer, verbose_] := Catch[Module[
  {red, vars, cl, blocks = {}, others = 0, expansions, ser, out, en, start = AbsoluteTime[], run,
   abel = ConstantArray[0, hi - lo + 1], av, abelRecords = {}},
  red = sbrReduceTerm[term, ep];
  Global`$sbrLastRun = <|"Reduction" -> red, "Closed" -> False|>;
  If[! TrueQ[red["Reduced"]], Throw[$Failed, sbrCloseTag]];
  vars = red["RemainingVariables"];
  If[Length[vars] > 1, Throw[$Failed, sbrCloseTag]];
  en = ep -> First[red["EpsilonInterval"]]/2;
  Do[
    If[vars === {}, others += tm; Continue[]];
    cl = Global`oftCloseOne[tm, First[vars], ep, red["Contour"][[1, 2]], en, hi];
    If[! AssociationQ[cl] || TrueQ[cl["Failed"]],
      av = If[DownValues[Global`oftAbelClose] =!= {} && ! TrueQ[Global`$sbrNoAbel],
        Global`oftAbelClose[{tm, {{ep -> 0}, red["Contour"]}}, ep, lo, hi, verbose], $Failed];
      If[ListQ[av] && Length[av] === hi - lo + 1 && MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[av],
        abel += av; AppendTo[abelRecords, Global`$abtLastRun]; Continue[]];
      Global`$sbrLastRun["Reason"] = If[AssociationQ[cl], cl["Reason"], "no plain tower closure"];
      If[verbose, Print["    [symbolic Barnes] terminal tower refused: ", Global`$sbrLastRun["Reason"]]];
      Throw[$Failed, sbrCloseTag]];
    blocks = Join[blocks, cl["Blocks"]]; others += cl["Others"], {tm, red["Terms"]}];
  If[verbose, Print["    [symbolic Barnes] eliminated ", red["Variable"], "; ", Length[red["Crossings"]],
    " crossing(s), ", Length[red["Terms"]], " term(s), block depths ", blocks[[All, "Depth"]]]];
  (* Preserve the caller's family log; oftExpandBlocks normally writes its diagnostics there. *)
  run = Global`$oftLastRun;
  expansions = Global`oftExpandBlocks[blocks, ep, verbose];
  Global`$sbrLastRun["Blocks"] = Lookup[Global`$oftLastRun, "Blocks", {}];
  Global`$oftLastRun = run;
  If[expansions === $Failed, Throw[$Failed, sbrCloseTag]];
  ser = Quiet@Series[others, {ep, 0, hi}];
  Do[ser += Quiet@Series[b["Pref"] (b["PFQ"] /. expansions), {ep, 0, hi}], {b, blocks}];
  out = Table[If[Head[ser] === SeriesData, SeriesCoefficient[ser, kk], Coefficient[Expand[ser], ep, kk]], {kk, lo, hi}] + abel;
  If[! FreeQ[out, $Failed | $Aborted | HypergeometricPFQ | HypExp`HypExp | SeriesCoefficient |
      Indeterminate | ComplexInfinity | _DirectedInfinity] || ! FreeQ[out, ep] || ! MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[out],
    Global`$sbrLastRun["Reason"] = "unclean Laurent coefficients"; Throw[$Failed, sbrCloseTag]];
  out = Table[With[{cc = Expand[Global`mbeCanonicalConstants[x]]},
    If[LeafCount[cc] < 300000, TimeConstrained[Simplify[cc], 120, cc], cc]], {x, out}];
  Global`$sbrLastRun["Closed"] = True; Global`$sbrLastRun["Seconds"] = AbsoluteTime[] - start;
  Global`$sbrLastRun["AbelTerms"] = abelRecords;
  If[verbose, Print["    [symbolic Barnes] residue closed in ", Round[AbsoluteTime[] - start], " s"]];
  out], sbrCloseTag];

Print["[mbeSubtractionBarnesRung] epsilon-symbolic four-Gamma reduction (interval and crossing certificates), plain or Abel terminal towers."];
