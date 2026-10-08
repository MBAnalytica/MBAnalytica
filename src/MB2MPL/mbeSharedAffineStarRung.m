(* Development prototype: shared-affine stars of arbitrary finite size.
   u,v are the hub; independent beta leaves t_j enter 1-v+u v t_j.
   The exact square map of mbeSharedAffineGaussRung removes the hub scale,
   then every leaf is an Euler Gauss integral. Polynomial numerators give
   a finite list of one-dimensional integrals, each with its own convergence
   certificate. No target identifiers, numerical producers or finite parts.
   Not installed in the dispatcher until independent audits are complete. *)

(* Reloads must remove the former shorter signatures, which would otherwise
   shadow the new optional research argument in an initialized kernel. *)
Clear[sgsParameters,sgsTryHub,sgsReduceCube];
sgsFail[why_] := Throw[<|"Reduced" -> False, "Reason" -> why|>, sgsTag];
sgsParameters[core_List, leaves_List, amplitude_, ep_, yy_: SharedAffineStar`argument, marginalHubBeta_: False] := Catch[Module[
  {aa, bb, cc, dd, hub, uu, kk, strict, positive, delta = 1/40, sign = None,
   differences, worst, slopeBound, q0, q1, pref, weight, blocks = {}, hh, alpha, beta, pp},
  If[! MemberQ[{4, 5}, Length[core]] || ! AllTrue[leaves, ListQ[#] && Length[#] === 3 &] ||
      ! AllTrue[Join[core, Flatten[leaves]], sbrAffineQ[#, {ep}] &],
    sgsFail["parameters must be rational-affine; leaves are {alpha,beta,P}"]];
  If[! FreeQ[amplitude, yy] || ! MBtoMPL`Private`mbtInexactNumberFreeQ[amplitude],
    sgsFail["amplitude must be exact and independent of the terminal variable"]];
  {aa, bb, cc, dd, hub} = If[Length[core] === 4, Append[core, 0], core];
  uu = Expand[aa + dd - hub - Total[If[leaves === {}, {}, leaves[[All, 3]]]]];
  kk = Expand[aa + bb - cc];
  differences = Expand[#[[1]] - #[[3]]] & /@ leaves;
  worst = (dd /. ep -> 0) + Total[Min[0, # /. ep -> 0] & /@ differences];
  strict = Expand /@ Join[If[TrueQ[marginalHubBeta],{aa,cc,uu},{aa,bb,cc,uu}], (#[[1]] + #[[2]]) & /@ leaves];
  If[! TrueQ[worst > 0] || ! AllTrue[strict, TrueQ[(# /. ep -> 0) > 0] &],
    sgsFail["no strict margin for both terminal endpoints and the hub beta integral"]];
  positive = Join[strict, {bb}, Flatten[Take[#, 2] & /@ leaves]];
  Do[q0 = ff /. ep -> 0; q1 = Coefficient[ff, ep];
    If[q0 > 0 && q1 =!= 0, delta = Min[delta, q0/(2 Abs[q1])]], {ff, positive}];
  Do[If[leaf[[1]]===1&&leaf[[2]]===1,
    q0=1-(leaf[[3]]/.ep->0);q1=-Coefficient[leaf[[3]],ep];
    If[q0=!=0&&q1=!=0,delta=Min[delta,Abs[q0]/(2Abs[q1])]]],{leaf,leaves}];
  slopeBound = Abs[Coefficient[dd, ep]] + Total[Abs[Coefficient[#, ep]] & /@ differences];
  If[slopeBound > 0, delta = Min[delta, worst/(2 slopeBound)]];
  Do[If[AllTrue[positive, TrueQ[(# /. ep -> 0) >= 0 && (# /. ep -> ss delta) > 0] &],
    sign = ss; Break[]], {ss, {1, -1}}];
  If[sign === None, sgsFail["no common half-interval for all beta endpoint powers"]];
  pref = amplitude Gamma[uu] Gamma[bb]/Gamma[uu + bb];
  weight = yy^(aa - 1) (1 - yy)^(dd - 1);
  hh = HypergeometricPFQ[{kk, uu}, {uu + bb}, 1 - yy];
  If[Head[hh] === HypergeometricPFQ, AppendTo[blocks, hh], weight *= hh];
  Do[{alpha, beta, pp} = leaf;
    pref *= Gamma[alpha] Gamma[beta]/Gamma[alpha + beta];
    Which[pp === 0, Null,
      alpha === 1 && beta === 1,
        If[pp === 1, weight *= -Log[1 - yy]/yy,
          pref /= 1 - pp; weight *= (1 - (1 - yy)^(1 - pp))/yy],
      True,
        hh = HypergeometricPFQ[{pp, beta}, {alpha + beta}, yy];
        If[Head[hh] === HypergeometricPFQ, AppendTo[blocks, hh], weight *= hh]], {leaf, leaves}];
  <|"Reduced" -> True, "Class" -> If[TrueQ[marginalHubBeta]&&TrueQ[(bb/.ep->0)===0],"SharedAffineStarMarginalBeta","SharedAffineStar"], "Parameters" -> {core, leaves},
    "U" -> uu, "K" -> kk, "Variable" -> yy, "Prefactor" -> pref,
    "Weight" -> weight, "GaussBlocks" -> blocks, "InputDimension" -> 2 + Length[leaves],
    "OutputDimension" -> 1, "EndpointMargins" -> <|"AtZero" -> ({aa, cc} /. ep -> 0),
      "AtOneWorstSubset" -> worst, "BetaMargins" -> (strict /. ep -> 0)|>,
    "EpsilonInterval" -> Sort[{0, sign delta}],"HubBetaOrigin"->(bb/.ep->0)|>], sgsTag];

(* Recognize exact positive bases, including hub reflections and individual
   leaf reflections. Unknown factors are admitted only as a polynomial
   numerator. Each resulting monomial is checked separately. *)
sgsTryHub[cube_, vars_List, ep_, pair_List, reflect_List, marginalHubBeta_: False] := Catch[Module[
  {uu = pair[[1]], vv = pair[[2]], other, ordering, replacements, transformed,
   factors, betaBases, betaPowers, leafPowers, leafDirections, amplitude = 1,
   polynomial = 1, hubPower = 0, base, power, hit, scale, qq, matches, pos, direction,
   foundShared = False, core, leafParameters, monomials, shifted, red, terms = {}, cr, reconstruction},
  other = DeleteCases[vars, Alternatives @@ pair]; ordering = Join[pair, other];
  replacements = MapThread[#1 -> If[#2, 1 - #1, #1] &, {pair, reflect}];
  transformed = cube /. replacements;
  factors = If[Head[transformed] === Times, List @@ transformed, {transformed}];
  betaBases = Flatten[({#, 1 - #} &) /@ ordering];
  betaPowers = ConstantArray[0, Length[betaBases]];
  leafPowers = ConstantArray[0, Length[other]];
  leafDirections = ConstantArray[None, Length[other]];
  Do[
    If[FreeQ[fac, Alternatives @@ vars], amplitude *= fac; Continue[]];
    {base, power} = If[Head[fac] === Power, List @@ fac, {fac, 1}];
    If[! FreeQ[power, Alternatives @@ vars] || ! sbrAffineQ[power, {ep}],
      sgsFail["an exponent depends on Euler variables or is not rational-affine"]];
    base = Expand[base];
    hit = SelectFirst[Range[Length[betaBases]], TrueQ[Expand[base - betaBases[[#]]] === 0] &, None];
    If[hit =!= None, betaPowers[[hit]] += power; Continue[]];
    (* Integer factors may be printed as v-1 by Factor. They carry the
       endpoint zero of 1-v, not two independent numerator monomials.
       Extracting their integer sign is exact and keeps that zero whole. *)
    If[IntegerQ[power],
      hit = SelectFirst[Range[Length[betaBases]], TrueQ[Expand[base + betaBases[[#]]] === 0] &, None];
      If[hit =!= None, amplitude *= (-1)^power; betaPowers[[hit]] += power; Continue[]]];
    scale = If[PolynomialQ[base, vars], base /. {uu -> 0, vv -> 0}, None];
    If[sbrRationalQ[scale] && TrueQ[scale > 0],
      qq = Expand[(base /. {uu -> 1, vv -> 1})/scale];
      If[FreeQ[qq, uu | vv] && TrueQ[Expand[base/scale - (1 - vv + uu vv qq)] === 0],
        If[qq === 1, hubPower -= power; amplitude *= scale^power; foundShared = True; Continue[]];
        matches = Flatten[Table[Which[TrueQ[Expand[qq - other[[jj]]] === 0], {{jj, False}},
          TrueQ[Expand[qq - (1 - other[[jj]])] === 0], {{jj, True}}, True, {}], {jj, Length[other]}], 1];
        If[Length[matches] === 1,
          {pos, direction} = First[matches];
          If[leafDirections[[pos]] =!= None && leafDirections[[pos]] =!= direction,
            sgsFail["one leaf carries two different affine factors"]];
          leafDirections[[pos]] = direction; leafPowers[[pos]] -= power;
          amplitude *= scale^power; foundShared = True; Continue[]]]];
    If[IntegerQ[power] && power >= 0 && PolynomialQ[base, vars], polynomial *= base^power; Continue[]];
    sgsFail["a factor is outside the shared-affine beta/polynomial class"], {fac, factors}];
  If[! foundShared, sgsFail["no shared affine factor"]];
  core = Join[betaPowers[[1 ;; 4]] + 1, {hubPower}];
  leafParameters = Table[{betaPowers[[2 jj + 3]] + 1, betaPowers[[2 jj + 4]] + 1, leafPowers[[jj]]},
    {jj, Length[other]}];
  polynomial = Expand[polynomial]; monomials = CoefficientRules[polynomial, ordering];
  reconstruction = Total[(Last[#] Times @@ MapThread[Power, {ordering, First[#]}]) & /@ monomials];
  If[! TrueQ[Expand[reconstruction - polynomial] === 0], sgsFail["polynomial reconstruction failed"]];
  Do[
    shifted = core; shifted[[1]] += First[cr][[1]]; shifted[[3]] += First[cr][[2]];
    red = Table[With[{lp = leafParameters[[jj]], nn = First[cr][[jj + 2]]},
      If[TrueQ[leafDirections[[jj]]], {lp[[2]], lp[[1]] + nn, lp[[3]]},
        {lp[[1]] + nn, lp[[2]], lp[[3]]}]], {jj, Length[other]}];
    red = sgsParameters[shifted, red, amplitude Last[cr], ep, SharedAffineStar`argument, marginalHubBeta];
    If[! TrueQ[red["Reduced"]], sgsFail[red["Reason"]]];
    AppendTo[terms, Join[red, <|"NumeratorMonomial" -> cr|>]], {cr, monomials}];
  <|"Reduced" -> True, "Class" -> "SharedAffineStarPolynomial", "Terms" -> terms,
    "InputDimension" -> Length[vars], "OutputDimension" -> 1, "TermCount" -> Length[terms],
    "OriginalCube" -> cube, "OriginalVariables" -> vars, "Hub" -> pair,
    "HubReflections" -> reflect, "LeafReflections" -> leafDirections,
    "Polynomial" -> polynomial, "PolynomialVariables" -> ordering|>], sgsTag];

sgsReduceCube[cube_, vars_List, ep_, marginalHubBeta_: False] := Module[{red, reasons = <||>},
  If[Length[vars] < 2, Return[<|"Reduced" -> False, "Reason" -> "at least two Euler variables are required"|>]];
  If[! MBtoMPL`Private`mbtInexactNumberFreeQ[cube],
    Return[<|"Reduced" -> False, "Reason" -> "inexact input is outside this exact class"|>]];
  Do[red = sgsTryHub[cube, vars, ep, pair, reflection, marginalHubBeta];
    If[TrueQ[red["Reduced"]], Return[red, Module]];
    reasons[red["Reason"]] = Lookup[reasons, red["Reason"], 0] + 1,
    {pair, Select[Tuples[vars, 2], #[[1]] =!= #[[2]] &]}, {reflection, Tuples[{False, True}, 2]}];
  <|"Reduced" -> False, "Reason" -> "no admitted shared-affine star", "Refusals" -> reasons|>];

(* Every polynomial monomial is an independently convergent beta class on
   its certified regulator interval. The terminal integrator retains the
   COMPLETE coefficient for each such term. A refused term refuses the sum. *)
sgsCubeLaurent[red_Association, externalPref_, ep_, lo_Integer, hi_Integer, verbose_: False] := Module[
  {terms, values = {}, value, records = {}, result, started = AbsoluteTime[]},
  If[! TrueQ[red["Reduced"]], Return[$Failed]];
  terms = Lookup[red, "Terms", {red}];
  Do[value = sagCubeLaurent[term, externalPref, ep, lo, hi, verbose];
    If[! ListQ[value] || Length[value] =!= hi - lo + 1, Return[$Failed, Module]];
    AppendTo[values, value]; AppendTo[records, Global`$sagLastRun], {term, terms}];
  result = If[values === {}, ConstantArray[0, hi - lo + 1], Global`mbeCanonicalConstants /@ Total[values]];
  If[abtUnfinishedQ[result] || ! FreeQ[result, ep | $Failed | Indeterminate | ComplexInfinity | _DirectedInfinity] ||
    ! MBtoMPL`Private`mbtInexactNumberFreeQ[result], Return[$Failed]];
  Global`$sgsLastRun = <|"InputDimension" -> red["InputDimension"], "OutputDimension" -> 1,
    "TermCount" -> Length[terms], "TermRuns" -> records, "Seconds" -> AbsoluteTime[] - started|>;
  result];

(* Called by the faithful-cube dispatcher after its established four-variable
   rung. Unsupported structures and terminal failures preserve the fallback. *)
sgsTryCubeLaurent[cube_,vars_List,pref_,ep_,lo_Integer,hi_Integer,verbose_:False]:=Module[
  {red,value,handler},
  Do[
    red=TimeConstrained[handler[cube,vars,ep],10,<|"Reduced"->False,"Reason"->"recognizer budget"|>];
    If[!AssociationQ[red]||!TrueQ[red["Reduced"]],Continue[]];
    If[verbose,Print["    [Gauss branches] ",red["Class"],": ",Length[vars],
      " variables -> ",red["TermCount"]," one-dimensional integral(s)"]];
    value=TimeConstrained[sgsCubeLaurent[red,pref,ep,lo,hi,verbose],Global`$fcuEulerRungSeconds,$Failed];
    If[ListQ[value]&&Length[value]===hi-lo+1&&!abtUnfinishedQ[value]&&
        MBtoMPL`Private`mbtInexactNumberFreeQ[value]&&FreeQ[value,ep|$Failed|Indeterminate|ComplexInfinity|_DirectedInfinity],
      Return[<|"Values"->value,"Reduction"->red,"Run"->Global`$sgsLastRun|>,Module]],
    {handler,{sapReduceCube,sgsReduceCube}}];
  $Failed];

Print["[mbeSharedAffineStarRung] prototype: arbitrary shared-affine beta stars and polynomial numerators -> a finite list of one-dimensional Gauss products."];
