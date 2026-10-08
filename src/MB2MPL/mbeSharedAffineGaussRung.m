(* Structural Subtraction class rung.  Two shared affine powers
     (1-v+u v x)^(-P) (1-v+u v t)^(-Q)
   with beta weights in u,v,t and a flat x measure reduce to one integral of two Gauss functions.
   Coordinates y=u v/(1-v+u v), T=1-v+u v map the square bijectively to the square.
   Euler beta integrals include the singular-face moments by meromorphic continuation; no moment is dropped. *)
sagFail[why_] := Throw[<|"Reduced" -> False, "Reason" -> why|>, sagTag];
sagParameters[pars_List, amplitude_, ep_, variable_: SharedAffineGauss`argument] := Catch[Module[
  {aa, bb, cc, dd, pp, qq, eta, theta, uu, kk, strict, positive, delta = 1/40, sign = None, q0, q1,
   pref, weight, h1, h2, yy = variable},
  If[Length[pars] =!= 8 || ! AllTrue[pars, sbrAffineQ[#, {ep}] &], sagFail["parameters are not rational-affine"]];
  {aa, bb, cc, dd, pp, qq, eta, theta} = pars;
  uu = Expand[aa + dd - pp - qq]; kk = Expand[aa + bb - cc];
  strict = Expand /@ {aa, cc, dd, dd + 1 - pp, dd + eta - qq, dd + 1 - pp + eta - qq, uu, bb, eta + theta};
  If[! AllTrue[strict, TrueQ[(# /. ep -> 0) > 0] &], sagFail["no uniform integrable endpoint margin at epsilon zero"]];
  positive = Join[strict, {eta, theta}];
  Do[q0 = ff /. ep -> 0; q1 = Coefficient[ff, ep];
    If[q0 > 0 && q1 =!= 0, delta = Min[delta, q0/(2 Abs[q1])]], {ff, positive}];
  Do[If[AllTrue[positive, TrueQ[(# /. ep -> 0) >= 0 && (# /. ep -> ss delta) > 0] &], sign = ss; Break[]], {ss, {1, -1}}];
  If[sign === None, sagFail["no common half-interval for the beta integrations"]];
  pref = amplitude Gamma[uu] Gamma[bb]/Gamma[uu + bb] Gamma[eta] Gamma[theta]/Gamma[eta + theta];
  weight = yy^(aa - 2) (1 - yy)^(dd - 1);
  If[TrueQ[pp === 1], weight *= -Log[1 - yy],
    pref /= 1 - pp; weight *= 1 - (1 - yy)^(1 - pp)];
  h1 = HypergeometricPFQ[{kk, uu}, {uu + bb}, 1 - yy];
  h2 = HypergeometricPFQ[{qq, theta}, {eta + theta}, yy];
  <|"Reduced" -> True, "Parameters" -> pars, "U" -> uu, "K" -> kk,
    "Variable" -> yy, "Prefactor" -> pref, "Weight" -> weight, "GaussBlocks" -> {h1, h2},
    "EndpointMargins" -> (strict /. ep -> 0), "EpsilonInterval" -> Sort[{0, sign delta}]|>], sagTag];

sagReduceCube[cube_, vars_List, ep_] := Module[
  {factors, bases, powers, amplitude, found, base, power, position, pars, result, other},
  If[Length[vars] =!= 4, Return[<|"Reduced" -> False, "Reason" -> "four Euler variables are required"|>]];
  factors = If[Head[cube] === Times, List @@ cube, {cube}];
  Do[
    bases = With[{u = ordering[[1]], v = ordering[[2]], x = ordering[[3]], t = ordering[[4]]},
      {u, 1 - u, v, 1 - v, x, 1 - x, t, 1 - t, 1 - v + u v x, 1 - v + u v t}];
    powers = ConstantArray[0, Length[bases]]; amplitude = 1; found = True;
    Do[If[FreeQ[fac, Alternatives @@ vars], amplitude *= fac; Continue[]];
      {base, power} = If[Head[fac] === Power, List @@ fac, {fac, 1}];
      If[! sbrAffineQ[power, {ep}] || ! FreeQ[power, Alternatives @@ vars], found = False; Break[]];
      position = SelectFirst[Range[Length[bases]], TrueQ[Expand[base - bases[[#]]] === 0] &, None];
      If[position === None, found = False; Break[]]; powers[[position]] += power, {fac, factors}];
    If[! found || powers[[5]] =!= 0 || powers[[6]] =!= 0 || powers[[9]] === 0 || powers[[10]] === 0, Continue[]];
    pars = Expand /@ {powers[[1]] + 1, powers[[2]] + 1, powers[[3]] + 1, powers[[4]] + 1,
      -powers[[9]], -powers[[10]], powers[[7]] + 1, powers[[8]] + 1};
    result = sagParameters[pars, amplitude, ep];
    If[TrueQ[result["Reduced"]], Return[Join[result, <|"OriginalVariables" -> ordering, "OriginalCube" -> cube|>], Module]],
    {ordering, Permutations[vars]}];
  <|"Reduced" -> False, "Reason" -> "shared-affine beta structure or its convergence bounds were not admitted"|>];

sagIntegralFail[why_, detail_: None] := (Global`$sagIntegralLastFailure = <|"Reason" -> why, "Detail" -> detail|>;
  Throw[$Failed, sagIntegralTag]);
sagAtomicPut[value_, path_String] := Module[{temporary = path <> "." <> CreateUUID[] <> ".tmp"},
  Put[value, temporary]; RenameFile[temporary, path, OverwriteTarget -> True]];
sagLogForm[e_] := Module[{words = DeleteDuplicates[Cases[e, _HPL`HPL, {0, Infinity}]], rules},
  If[DownValues[Global`rhplLogExtract] =!= {}, Return[Global`rhplLogExtract[e] /. {
    HoldPattern[HPL`HPL[{0}, z_]] :> Log[z], HoldPattern[HPL`HPL[{1}, z_]] :> -Log[1 - z]}, Module]];
  rules = Table[h -> HPL`HPLLogExtract[h], {h, words}];
  (e /. Dispatch[rules]) /. {
    HoldPattern[HPL`HPL[{0}, z_]] :> Log[z], HoldPattern[HPL`HPL[{1}, z_]] :> -Log[1 - z]}];
(* On 0<x<1 the two negative Mobius arguments x/(x-1) and (x-1)/x map to
   x and 1-x under q -> q/(q-1).  Words with nonnegative indices and a
   nonzero final index have no logarithmic branch ambiguity on the negative
   axis.  Apply the public HPL identity BEFORE the automatic sign transform,
   then normalize the rational argument before the reflection identity. *)
sagMobiusHPL[e_, xx_] := e /. h : HoldPattern[HPL`HPL[ww_List, zz_]] /;
    ! FreeQ[zz, xx] && ww =!= {} && AllTrue[ww, IntegerQ[#] && # >= 0 &] && Last[ww] > 0 &&
    (TrueQ[Together[zz - (xx - 1)/xx] === 0] || TrueQ[Together[zz - xx/(xx - 1)] === 0]) :>
  Module[{tt, rr, compact = HPL`HPLAtoM[HPL`HPLMtoA[ww]]},
    rr = HPL`HPLArgTransform[HPL`HPL[compact, tt], tt -> tt/(tt - 1)] /. tt -> zz;
    rr /. HoldPattern[HPL`HPL[vv_List, aa_]] :> HPL`HPL[vv, Together[aa]]];
(* Ordinary endpoint limit for a polynomial in endpoint logs and HPLs regular
   at both endpoints, with rational coefficients having no endpoint pole.
   Every regular HPL differs from its endpoint value by O(delta log^k delta).
   Thus the COMPLETE log polynomial gives the limit precisely when all its
   positive-degree coefficients vanish.  No logarithmic finite part is taken. *)
sagFiniteLogEndpoint[expr_, xx_, side : (0 | 1)] := Module[
  {hp, compact, atoms, lzero, lone, ell, pp, cr, denominator, boundary, vals, cs},
  hp = DeleteDuplicates[Cases[expr, h_HPL`HPL /; ! FreeQ[h, xx], {0, Infinity}]];
  If[! AllTrue[hp, Function[h, Last[h] === xx && ListQ[First[h]] &&
      AllTrue[First[h], IntegerQ[#] && # >= 0 &] &&
      With[{ww = HPL`HPLAtoM[HPL`HPLMtoA[First[h]]]},
        ww =!= {} && AllTrue[ww, IntegerQ[#] && # >= 0 &] && First[ww] > 1]]], Return[$Failed]];
  atoms = Table[Unique["sagFiniteWord"], {Length[hp]}];
  pp = expr /. Thread[hp -> atoms] /. {Log[xx] -> lzero, Log[1 - xx] -> lone};
  If[! PolynomialQ[pp, Join[atoms, {lzero, lone}]], Return[$Failed]];
  cr = CoefficientRules[pp, Join[atoms, {lzero, lone}]];
  If[! AllTrue[Last /@ cr, Function[cc,
      denominator = Denominator[Together[cc]];
      PolynomialQ[Numerator[Together[cc]], xx] && PolynomialQ[denominator, xx] &&
      NumericQ[denominator /. xx -> side] && TrueQ[(denominator /. xx -> side) != 0] &&
      FreeQ[cc /. xx -> side, $Failed | Indeterminate | ComplexInfinity | _DirectedInfinity] &&
      FreeQ[cc, h_HPL`HPL /; ! FreeQ[h, xx]] &&
      FreeQ[cc, Log[arg_] /; ! FreeQ[arg, xx]]]], Return[$Failed]];
  vals = If[side === 0, ConstantArray[0, Length[hp]], hp /. xx -> 1];
  boundary = Expand[(pp /. xx -> side) /. Thread[atoms -> vals] /.
    If[side === 0, {lzero -> ell, lone -> 0}, {lzero -> 0, lone -> ell}]];
  If[! PolynomialQ[boundary, ell], Return[$Failed]];
  cs = CoefficientList[boundary, ell];
  If[cs === {}, Return[0]];
  If[! And @@ (bwsExactZeroQ /@ Rest[cs]), Return[$Failed]];
  boundary = Global`mbeCanonicalConstants[First[cs]];
  If[abtUnfinishedQ[boundary] || ! FreeQ[boundary, xx | $Failed | Indeterminate | ComplexInfinity | _DirectedInfinity] ||
    ! MBtoMPL`Private`mbtInexactNumberFreeQ[boundary], $Failed, boundary]];
(* A complete primitive and its derivative certificate precede endpoint evaluation.  Both endpoint limits
   are ordinary finite limits of the entire primitive; no individually divergent GPL is assigned a value. *)
sagIntegrateOne[expr_, xx_, verbose_: False] := Catch[Block[
  {HPL`$HPLAutoConvertToKnownFunctions = False, HPL`$HPLAutoReduceToMinimalSet = False,
   HPL`$HPLAutoProductExpand = False, HPL`$HPLAutoLogExtract = False,
   HPL`$HPLAutoConvertToSimplerArgument = False}, Module[
  {hh, gg, bad, primitive, derivative, ph, upper, lower, value, start = AbsoluteTime[], stages = <||>, mark},
  mark[tag_] := (stages[tag] = AbsoluteTime[] - start; Global`$sagIntegralProfile = stages;
    If[verbose, Print["    [Gauss pair] ", tag, " at ", Round[stages[tag]], " s"]]);
  Global`$sagIntegralLastFailure = None;
  If[expr === 0, Return[0, Module]];
  hh = expr /. {
    HoldPattern[PolyLog[n_Integer, p_Integer, zz_]] /; n >= 1 && p >= 1 :>
      HPL`HPL[Join[{n + 1}, ConstantArray[1, p - 1]], zz],
    HoldPattern[PolyLog[n_Integer?Positive, zz_]] :> HPL`HPL[{n}, zz],
    HoldPattern[Log[zz_]] :> HPL`HPL[{0}, zz]};
  hh = HPL`HPLConvertToSimplerArgument[sagMobiusHPL[hh, xx]];
  gg = PolyLogTools`HPLToG[hh];
  bad = Cases[gg, g_PolyLogTools`G /; ! FreeQ[g, xx] &&
    (Last[g] =!= xx || ! FreeQ[Most[List @@ g], xx] || ! AllTrue[Most[List @@ g], MemberQ[{0, 1}, #] &]), {0, Infinity}];
  If[bad =!= {} || ! FreeQ[gg, HPL`HPL | PolyLog], sagIntegralFail["conversion left unsupported functions", gg]];
  mark["common argument"];
  primitive = TimeConstrained[PolyLogTools`GIntegrate[gg, xx], 600, $Failed];
  If[! FreeQ[primitive, $Failed | $Aborted | PolyLogTools`GIntegrate | _Integrate] ||
      ! FreeQ[primitive, ss_Symbol /; StringContainsQ[SymbolName[Unevaluated[ss]], "Gint" | "CiTi"]],
    sagIntegralFail["primitive unavailable", primitive]];
  mark["primitive"];
  derivative = TimeConstrained[If[DownValues[Global`gfdDerivative] =!= {},
    Global`gfdDerivative[primitive, xx], PolyLogTools`DG[primitive, xx]], 300, $Failed];
  If[derivative === $Failed, sagIntegralFail["primitive not in the fixed-letter derivative class", primitive]];
  derivative = TimeConstrained[PolyLogTools`GCoefficientSimplify[Expand[
    PolyLogTools`ShuffleG[derivative - gg]]], 300, $Failed];
  If[! TrueQ[derivative === 0], sagIntegralFail["primitive derivative check failed", derivative]];
  mark["derivative checked"];
  ph = PolyLogTools`GToHPL[primitive]; mark["HPL conversion"];
  ph = sagLogForm[ph];
  If[! FreeQ[ph, PolyLogTools`G], sagIntegralFail["primitive not in the HPL alphabet", ph]];
  mark["endpoint logarithms extracted"];
  upper = sagFiniteLogEndpoint[ph, xx, 1];
  If[upper === $Failed, upper = Catch[abtEndpoint[ph, xx], abtTag]];
  mark["upper endpoint"];
  lower = sagFiniteLogEndpoint[ph, xx, 0];
  If[lower === $Failed,
    lower = Catch[abtEndpoint[sagLogForm[HPL`HPLConvertToSimplerArgument[ph /. xx -> 1 - xx]], xx], abtTag]];
  mark["lower endpoint"];
  If[AssociationQ[upper] || AssociationQ[lower], sagIntegralFail["finite endpoint limit unavailable", {upper, lower, ph}]];
  value = Global`mbeCanonicalConstants[upper - lower];
  If[abtUnfinishedQ[value] || ! FreeQ[value, xx | $Failed | $Aborted | Indeterminate | ComplexInfinity | _DirectedInfinity] ||
    ! MBtoMPL`Private`mbtInexactNumberFreeQ[value], sagIntegralFail["unfinished value", value]];
  If[verbose, Print["    [Gauss pair] primitive derivative and both finite endpoints certified"]];
  value]], sagIntegralTag];

sagCubeLaurent[red_Association, externalPref_, ep_, lo_Integer, hi_Integer, verbose_: False] := Catch[Block[
  {HPL`$HPLAutoConvertToKnownFunctions = False, HPL`$HPLAutoReduceToMinimalSet = False,
   HPL`$HPLAutoProductExpand = False, HPL`$HPLAutoLogExtract = False,
   HPL`$HPLAutoConvertToSimplerArgument = False}, Module[
  {xx, pref, leading, cubeHi, weightLead, depth, expansions, product, coefficient, cubeValues = <||>, cubeLo,
   key, bankDir, bank, answer, total, values, jj, q, start = AbsoluteTime[]},
  If[! TrueQ[red["Reduced"]], Throw[$Failed, sagCloseTag]];
  xx = red["Variable"]; pref = externalPref red["Prefactor"];
  leading = Global`oftLeadOrder[pref, ep, Max[0, hi]]; cubeHi = hi - leading;
  weightLead = Global`oftLeadOrder[red["Weight"], ep, Max[0, cubeHi]];
  depth = Max[0, cubeHi - weightLead];
  If[verbose, Print["    [Gauss pair] parameters ", red["Parameters"], "; block depth ", depth]];
  expansions = Table[hbbExpand[q, ep, depth, 1800, xx]["Expansion"], {q, red["GaussBlocks"]}];
  If[! AllTrue[expansions, hbbExactQ], Throw[$Failed, sagCloseTag]];
  product = Series[red["Weight"] Times @@ expansions, {ep, 0, cubeHi}];
  cubeLo = Global`fcuLeadOrderOfSeries[product, red["Weight"] Times @@ expansions];
  bankDir = FileNameJoin[{Global`$MBStandardCacheDir, "shared_affine_gauss"}];
  Quiet@CreateDirectory[bankDir, CreateIntermediateDirectories -> True];
  key = IntegerString[Hash[{"shared-affine-gauss-v1", red["Weight"], red["GaussBlocks"]}, "SHA256"], 16, 16];
  Do[bank = FileNameJoin[{bankDir, "c_" <> key <> "_e" <> ToString[jj] <> ".m"}];
    If[FileExistsQ[bank] && TrueQ[Global`$fcuBankRead],
      answer = Quiet@Check[Get[bank], $Failed];
      If[! abtUnfinishedQ[answer] && FreeQ[answer, xx | ep | $Failed | $Aborted | Indeterminate | ComplexInfinity | _DirectedInfinity] &&
        MBtoMPL`Private`mbtInexactNumberFreeQ[answer], cubeValues[jj] = answer; Continue[]]];
    coefficient = Expand[abtCoefficient[product, ep, jj]];
    sagAtomicPut[coefficient, FileNameJoin[{bankDir, "integrand_" <> key <> "_e" <> ToString[jj] <> ".m"}]];
    If[verbose, Print["    [Gauss pair] integral order ", jj, ", leaves ", LeafCount[coefficient]]];
    answer = sagIntegrateOne[coefficient, xx, verbose];
    If[answer === $Failed, Throw[$Failed, sagCloseTag]];
    cubeValues[jj] = answer; sagAtomicPut[answer, bank], {jj, cubeLo, cubeHi}];
  If[!AllTrue[Range[cubeLo,cubeHi],KeyExistsQ[cubeValues,#]&],Throw[$Failed,sagCloseTag]];
  total = Series[pref Total[Table[cubeValues[jj] ep^jj, {jj, cubeLo, cubeHi}]], {ep, 0, hi}];
  values = Global`mbeCanonicalConstants /@ Table[abtCoefficient[total, ep, jj], {jj, lo, hi}];
  If[abtUnfinishedQ[values] || ! FreeQ[values, ep] || ! MBtoMPL`Private`mbtInexactNumberFreeQ[values], Throw[$Failed, sagCloseTag]];
  Global`$sagLastRun = <|"Orders" -> {lo, hi}, "Key" -> key, "GaussDepth" -> depth,
    "IntegralOrders" -> {cubeLo, cubeHi}, "Seconds" -> AbsoluteTime[] - start|>;
  values]], sagCloseTag];

Print["[mbeSharedAffineGaussRung] shared-affine beta cubes -> one Gauss-pair integral with exact primitive and finite endpoint certificates."];
