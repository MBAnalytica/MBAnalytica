(* Abel closure of balanced pure-Gamma one-folds in the development Subtraction route.
   Admit only unit slopes, positive equal effective Gamma counts in both directions, and a z-independent
   remainder.  x^z (0<x<1) damps the right closure.  Sum every tower and finite crossing BEFORE x->1.
   Positive effective count gives exponential decay on the vertical contour and permits the Abel limit and
   Laurent coefficient extraction there.  The finite endpoint limit is required, never a finite-part value.
   The ordinary tower handler may use this rung when its separate unit-argument sums are inadmissible. *)
abtFail[s_] := Throw[<|"Failed" -> True, "Reason" -> s|>, abtTag];
If[! NumericQ[Global`$abtBlockSeconds], Global`$abtBlockSeconds = 600];
abtCoefficient[s_, ep_, kk_] := If[Head[s] === SeriesData, SeriesCoefficient[s, kk], Coefficient[Expand[s], ep, kk]];
(* 3 October 2026: the towers of two different numerator legs whose natural bases differ by an integer lie on one pole
   lattice, and from the later base on every pole is double (MB8a residue 50 after reflection: Gamma(-1-w-2eps) and
   Gamma(-w-2eps), both towers starting at w = -2eps).  The rungs that sum one SIMPLE tower per leg, looked up by its first
   pole, would sum one of them twice and drop the double-pole residues -- an exact, ungated, wrong value (3 - Pi^2/2 at
   eps^-5, the whole direct-route MB8a defect of 3 October).  Such a direction is refused; the regulated tower rung and
   the faithful cube take the residue. *)
abtOverlappingTowersQ[towers_List] := Module[{als = Lookup[Select[towers, AssociationQ], "Al"]},
  AnyTrue[Subsets[Range[Length[als]], {2}], IntegerQ[Simplify[als[[#[[1]]]] - als[[#[[2]]]]]] &]];
abtUnfinishedQ[v_] := ! FreeQ[v, _Missing | _Failure | _Association | _Limit | _Series | _SeriesData | _SeriesCoefficient | _Integrate | _NIntegrate |
  _ConditionalExpression | _Piecewise | _Derivative | HypergeometricPFQ | Hypergeometric2F1 | HypExp`HypExp |
  HoldPattern[HPL`HPL[{1}, 1]] | HoldPattern[HPL`HPL[{0}, 0]]];

abtEndpoint[e_, x_] := Module[{aa, dd, hh, pp, repl, loc, val},
  aa = Together[e];
  val = Quiet@TimeConstrained[Limit[aa, x -> 1, Direction -> "FromBelow"], 20, $Failed];
  If[! abtUnfinishedQ[val] && FreeQ[val, x | $Failed | Indeterminate | ComplexInfinity | _DirectedInfinity],
    Return[Global`mbeCanonicalConstants[val], Module]];
  dd = Denominator[aa]; hh = Unique["abtDistance"];
  If[! PolynomialQ[dd, x], abtFail["endpoint denominator is not polynomial"]];
  pp = Max[0, Exponent[Expand[dd /. x -> 1 - hh], hh, Min]];
  If[! IntegerQ[pp] || pp > 6, abtFail["endpoint pole order is outside the tested bound"]];
  (* The HPL package has Series upvalues at x=1; expose Nielsen functions as positive-index HPLs. *)
  loc = Block[{HPL`$HPLAutoConvertToKnownFunctions = False, HPL`$HPLAutoReduceToMinimalSet = False},
    aa = aa /. PolyLog[n_Integer, p_Integer, x] /; n >= 1 && p >= 1 :>
      HPL`HPL[Join[{n + 1}, ConstantArray[1, p - 1]], x];
    repl = DeleteDuplicates[Cases[aa, h_HPL`HPL /; ! FreeQ[h, x], {0, Infinity}]];
    repl = Table[h -> Normal[Series[h, {x, 1, pp}]], {h, repl}];
    Quiet@Normal@Series[aa /. repl, {x, 1, 0}]];
  val = Quiet@TimeConstrained[Limit[loc, x -> 1, Direction -> "FromBelow"], 120, $Failed];
  If[abtUnfinishedQ[val] || ! FreeQ[val, x | $Failed | Indeterminate | ComplexInfinity | _DirectedInfinity],
    abtFail["tower sum has no certified finite Abel endpoint"]];
  Global`mbeCanonicalConstants[val]];

abtLaurentOne[f_, z_, ep_, c_, lo_Integer, hi_Integer, verbose_: False] := Catch[Module[
  {dec, gam, eff, forms, delta, cl, x = Unique["abtX"], total = 0, blocks = {}, d, tw, base, prefix, raw, dep, ex, series, vals, lowerPoles,
   start = AbsoluteTime[], expansionRecord},
  dec = Catch[MBAnalytica`SymbolicInt`Private`mbeOFCDecompose[f, z], MBAnalytica`SymbolicInt`Private`mbeOFC$tag];
  If[! AssociationQ[dec], abtFail["Gamma decomposition failed"]];
  gam = dec["Gammas"];
  Global`$abtLastRun = <|"Closed" -> False|>;
  If[! FreeQ[dec["Rest"], z], abtFail["remainder depends on the Mellin variable"]];
  If[! AllTrue[gam, sbrAffineQ[#[[1]], {z, ep}] && MemberQ[{-1, 0, 1}, Coefficient[#[[1]], z]] &],
    abtFail["Gamma arguments are outside the rational-affine unit-slope class"]];
  eff = Table[Total[Last /@ Select[gam, Coefficient[First[#], z] === sg &]], {sg, {1, -1}}];
  If[! TrueQ[eff[[1]] === eff[[2]] && eff[[1]] > 0], abtFail["effective Gamma counts are not equal and positive"]];
  If[AnyTrue[gam, Function[g, g[[2]] > 0 && Coefficient[g[[1]], z] =!= 0 &&
      With[{atZero = g[[1]] /. {z -> c, ep -> 0}}, IntegerQ[atZero] && atZero <= 0]]],
    abtFail["the original contour meets a numerator pole at epsilon zero"]];
  forms = First /@ gam; delta = sbrSafeInterval[forms, {z -> c}, ep];
  cl = Catch[MBAnalytica`SymbolicInt`Private`mbeOFCClose[f, z, ep, c, ep -> -delta/2], MBAnalytica`SymbolicInt`Private`mbeOFC$tag];
  If[! AssociationQ[cl], abtFail["simple right towers are unavailable"]];
  If[abtOverlappingTowersQ[cl["RightPoles"]["Towers"]], abtFail["two legs on one pole lattice (multiple-pole towers)"]];
  Do[
    If[pa["Type"] === "Tower",
      tw = SelectFirst[cl["RightPoles"]["Towers"], #["Base"] === pa["Base"] &];
      base = tw["Al"];
      (* A truncated tower introduces an extra 1/(n+N0)! parameter and may exceed HypExp's pFq class.
         Sum from its natural base, then subtract its finite initial terms exactly. *)
      d = MBAnalytica`SymbolicInt`Private`mbeOFCTowerSum[dec, z, base, ep, base, 0];
      If[! FreeQ[d["Pref"], Indeterminate | ComplexInfinity | _DirectedInfinity], abtFail["coincident natural tower bases"]];
      prefix = d["Pref"] x^base Sum[(d["Arg"] x)^jj/jj! *
        (Times @@ (Pochhammer[#, jj] & /@ d["Num"]))/
        (Times @@ (Pochhammer[#, jj] & /@ d["Den"])), {jj, 0, tw["N0"] - 1}];
      raw = HypergeometricPFQ[d["Num"], d["Den"], d["Arg"] x];
      (* Every lower parameter at a nonpositive integer can supply one Laurent pole.  A vanishing Gamma
         prefactor must not be discarded before those poles are included. *)
      lowerPoles = Count[d["Den"], qq_ /; With[{q0 = qq /. ep -> 0}, IntegerQ[q0] && q0 <= 0]];
      dep = hi - Global`oftLeadOrder[d["Pref"], ep, Max[0, hi + lowerPoles]];
      If[dep === -Infinity, Continue[]];
      If[verbose, Print["    [Abel tower] base ", pa["Base"], ", depth ", dep, ", p/q ", {Length[d["Num"]], Length[d["Den"]]}]];
      Global`$abtLastBlock = <|"Input" -> raw, "Depth" -> dep, "Base" -> pa["Base"],
        "Budget" -> Global`$abtBlockSeconds|>;
      expansionRecord = If[DownValues[Global`hbbExpand] =!= {},
        Global`hbbExpand[raw, ep, Max[0, dep], Global`$abtBlockSeconds, x],
        <|"Expansion" -> Quiet@TimeConstrained[HypExp`HypExp[raw, ep, Max[0, dep]], Global`$abtBlockSeconds, $Failed]|>];
      ex = expansionRecord["Expansion"];
      If[! FreeQ[ex, $Failed | $Aborted | HypergeometricPFQ | Hypergeometric2F1 | HypExp`HypExp],
        abtFail["a radial hypergeometric block did not expand"]];
      total += Normal@Series[d["Pref"] x^base ex - prefix, {ep, 0, hi}];
      AppendTo[blocks, <|"Base" -> pa["Base"], "Depth" -> dep|>],
      (* Finite crossed poles may be multiple: differentiate x^z as part of the full residue. *)
      d = SelectFirst[cl["RightPoles"]["Finite"], First[#] === pa["Z"] &];
      total -= Normal@Series[MBAnalytica`SymbolicInt`Private`mbeOFCFiniteRes[x^z f, z, pa["Z"], Last[d]], {ep, 0, hi}]],
    {pa, cl["Parts"]}];
  series = Series[total, {ep, 0, hi}];
  vals = Table[
    If[verbose, Print["    [Abel tower] endpoint eps^", kk]];
    abtEndpoint[abtCoefficient[series, ep, kk], x], {kk, lo, hi}];
  If[abtUnfinishedQ[vals] || ! FreeQ[vals, ep | z] || ! MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[vals], abtFail["unclean exact coefficients"]];
  Global`$abtLastRun = <|"Closed" -> True, "EffectiveCounts" -> eff, "Interval" -> {-delta, 0},
    "Blocks" -> blocks, "Seconds" -> AbsoluteTime[] - start|>;
  If[verbose, Print["    [Abel tower] closed in ", Round[AbsoluteTime[] - start], " s"]];
  vals], abtTag];

oftAbelClose[term_, ep_, lo_Integer, hi_Integer, verbose_] := Module[{ctr = term[[2, 2]], val, zz, ww, cc},
  If[Length[ctr] =!= 1, Return[$Failed]];
  zz = First[Keys[ctr]]; cc = Rationalize[ctr[[1, 2]], 0];
  Global`$abtLastAttempts = {};
  val = abtLaurentOne[term[[1]], zz, ep, cc, lo, hi, verbose];
  AppendTo[Global`$abtLastAttempts, <|"Direction" -> "RIGHT", "Closed" -> ListQ[val],
    "Reason" -> If[AssociationQ[val], Lookup[val, "Reason", None], None]|>];
  If[ListQ[val] && Length[val] === hi - lo + 1, Global`$abtLastRun["Direction"] = "RIGHT"; Return[val, Module]];
  ww = Unique["abtReflected"];
  val = abtLaurentOne[term[[1]] /. zz -> -ww, ww, ep, -cc, lo, hi, verbose];
  AppendTo[Global`$abtLastAttempts, <|"Direction" -> "LEFT", "Closed" -> ListQ[val],
    "Reason" -> If[AssociationQ[val], Lookup[val, "Reason", None], None]|>];
  If[ListQ[val] && Length[val] === hi - lo + 1,
    Global`$abtLastRun["Direction"] = "LEFT"; val, $Failed]];

Print["[mbeAbelTowerRung] balanced positive Gamma counts: radial tower sums with a finite common endpoint."];
