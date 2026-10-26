(* ::Package:: *)
(* mbeMellinTowerRung.m -- closure of a one-fold Mellin-Barnes integral with a PARAMETER DAMPING (2026-09-25).

   Class: F(z) = P(u) * b(u)^z * prod Gamma(a_i + b_i eps + k_i z)^(p_i)  with rational-affine arguments, integer slopes
   k_i, a fixed straight contour Re z = c that no pole crosses on a certified epsilon interval ending at zero, and a
   scale b(u) > 0 on the parameter domain (0 < u < 1).  Such integrals are what the Mellin-space resolution of a
   residue leaves after Barnes' lemmas (mbe_barnes_lib.m) have removed the other folds.

   Steps (every one an exact identity):
     1. Gauss multiplication turns every slope |k| >= 2 into unit slopes (Gamma(m w) = (2 pi)^((1-m)/2) m^(m w-1/2)
        prod_j Gamma(w + j/m)); the m^(m z) factor joins the scale.
     2. The scale b(u)^z is split off (all powers whose exponent is affine in z); b(u) > 0 must be proved on the domain.
     3. The bare Gamma product is closed by the epsilon-symbolic radial towers of mbeAbelTowerRung.m (abtLaurentOne):
        every pole sequence summed as a hypergeometric block pFq(..., arg x) with the damping variable x, expanded
        by HypExp, and the Laurent coefficients taken; the endpoint x -> b(u) is the SUBSTITUTION (the rung's Abel
        limit x -> 1 is replaced), first with the right closure, then with the reflected left closure.
        The tower sum converges where |arg b(u)| < 1; the closed form is the analytic continuation, equal to the
        integral on the whole domain when no cut of the closed form meets it.  A closed form with a cut inside the
        domain is not served: the two-sided numerical gate below refuses it.
     4. Gate (development only, never a producer): for every order the epsilon-coefficient of the integrand is
        integrated numerically along the contour at parameter points on BOTH sides of every scale threshold
        (|arg b(u)| = 1) and compared with the closed form.

   Refusals (loud, with the reason): non-integer slopes, a dressing depending on the Mellin variable (rational or
   polygamma factors: the regulated rung's identities are the next step), exactly coincident Gamma legs (need
   regulators), unbalanced leg counts, no closure direction, a failed gate.  Sums are closed term by term. *)

BeginPackage["MBMellinTower`"];
mbeMellinTowerClose::usage = "mbeMellinTowerClose[F, z, eps, c, lo, hi, {u}, dom, opts]: exact Laurent list lo..hi of the one-fold MB integral of F over Re z = c with parameter damping, or a Failure with the reason.";
mbeMellinSlopeNormalize::usage = "mbeMellinSlopeNormalize[F, z]: Gauss multiplication of every Gamma leg of slope |k|>=2.";
mbeMellinScaleSplit::usage = "mbeMellinScaleSplit[F, z, pars, dom]: <|\"Scale\"->b, \"Rest\"->F/b^z|> with b proved positive.";
mbeMellinTowerGate::usage = "mbeMellinTowerGate[F, z, eps, c, lo, hi, values, pars, points]: numerical contour check of every order at the parameter points.";
mbeMellinLaurent::usage = "mbeMellinLaurent[F, z, eps, c, lo, hi, {u}, dom, opts]: closes a SUM term by term and returns the Laurent polynomial or a Failure.";
Begin["`Private`"];

refuse[s_, d_ : <||>] := Failure["MellinTower", Join[<|"Reason" -> s|>, d]];
factorsOf[e_] := If[Head[e] === Times, List @@ e, {e}];
prove[q_, dom_] := TrueQ@Quiet@TimeConstrained[FullSimplify[q, Assumptions -> dom], 20, False];

(* ---- 1. Gauss multiplication ---- *)
gaussOne[a_, k_Integer, z_] := Module[{m = Abs[k], w}, w = a/m + Sign[k] z;
  (2 Pi)^((1 - m)/2) m^(m w - 1/2) Product[Gamma[w + j/m], {j, 0, m - 1}]];
mbeMellinSlopeNormalize[f_, z_, skip_List : {}] := Module[{fs = factorsOf[f], out = 1, l, k, p},
  (* skip: other Mellin variables; a Gamma leg that also depends on one of them is left alone (its Gauss
     multiplication would give that variable a half-integer slope) *)
  Do[Which[
    !FreeQ[t, Alternatives @@ skip], out *= t,
    MatchQ[t, Gamma[_]] && !FreeQ[t, z], l = t[[1]]; k = Coefficient[l, z];
      If[!IntegerQ[k] || !PolynomialQ[l, z] || Exponent[l, z] > 1, Return[refuse["non-integer or nonlinear slope: " <> ToString[l, InputForm]], Module]];
      out *= If[Abs[k] >= 2, gaussOne[l /. z -> 0, k, z], t],
    MatchQ[t, Power[Gamma[_], _Integer]] && !FreeQ[t, z], l = t[[1, 1]]; p = t[[2]]; k = Coefficient[l, z];
      If[!IntegerQ[k] || !PolynomialQ[l, z] || Exponent[l, z] > 1, Return[refuse["non-integer or nonlinear slope: " <> ToString[l, InputForm]], Module]];
      out *= If[Abs[k] >= 2, gaussOne[l /. z -> 0, k, z]^p, t],
    True, out *= t], {t, fs}];
  out];

(* ---- 2. scale split: every Power[b, p] with p affine in z, b free of z ---- *)
mbeMellinScaleSplit[f_, z_, pars_List, dom_] := Module[{fs = factorsOf[f], scale = 1, rest = 1, k, p0, bad = {}},
  Do[Which[
    MatchQ[t, Power[_, _]] && !FreeQ[t[[2]], z],
      If[!FreeQ[t[[1]], z] || !PolynomialQ[t[[2]], z] || Exponent[t[[2]], z] > 1, AppendTo[bad, t]; Continue[]];
      k = Coefficient[t[[2]], z]; p0 = t[[2]] /. z -> 0;
      If[!MatchQ[k, _Integer | _Rational], AppendTo[bad, t]; Continue[]];
      scale *= t[[1]]^k; If[p0 =!= 0, rest *= t[[1]]^p0],
    MatchQ[t, Exp[_]] && !FreeQ[t, z], AppendTo[bad, t],
    True, rest *= t], {t, fs}];
  If[bad =!= {}, Return[refuse["scale factors outside the class", <|"Factors" -> bad|>], Module]];
  scale = Simplify[scale];
  If[!FreeQ[scale, Alternatives @@ pars] && !prove[scale > 0, dom], Return[refuse["scale not proved positive on the domain", <|"Scale" -> scale|>], Module]];
  If[FreeQ[scale, Alternatives @@ pars] && !TrueQ[scale > 0], Return[refuse["numeric scale not positive", <|"Scale" -> scale|>], Module]];
  <|"Scale" -> scale, "Rest" -> rest|>];

(* ---- 4. gate ---- *)
coefficientAt[F_, ep_, k_, lo_] := Module[{s = Quiet@Series[F, {ep, 0, k}]}, If[Head[s] === SeriesData, SeriesCoefficient[s, k], Coefficient[Expand[s], ep, k]]];
gnum[g_PolyLogTools`G] := Module[{ls = Most[List @@ g], y = Last[g]},
  If[y === 1 && ls =!= {} && SubsetQ[{0, 1, -1}, ls] && First[ls] =!= 1, (-1)^Count[ls, 1] N[HPL`HPL[ls, 1], 30],
    Quiet[N[PolyLogTools`Ginsh[g, {}, PolyLogTools`PrecisionGoal -> 40], 30]]]];
numericValue[v_, pars_, pt_] := Module[{w = v /. Thread[pars -> pt], n},
  (* polylogarithms through Ginsh (any real argument); the HPL package's own numerics are slow beyond the unit disk *)
  n = Quiet@TimeConstrained[N[(w /. h_HPL`HPL :> PolyLogTools`HPLToG[h]) /. g_PolyLogTools`G :> gnum[g], 24], 300, $TimedOut];
  If[NumericQ[n], Return[n, Module]];
  Quiet@TimeConstrained[N[w, 24], 300, $TimedOut]];
mbeMellinTowerGate[F_, z_, ep_, c_, lo_, hi_, vals_List, pars_List, points_List, seconds_ : 900, log_ : Print] := Module[{out = {}, g, ref, val, ok = True, tt, rel, t0},
  Do[t0 = AbsoluteTime[]; g = coefficientAt[F, ep, k, lo]; log["[mellin tower] gate eps^", k, " coefficient series ", Round[AbsoluteTime[] - t0], " s"];
    Do[t0 = AbsoluteTime[];
      ref = If[g === 0, 0, Quiet@TimeConstrained[NIntegrate[Evaluate[(g /. Thread[pars -> pt]) /. z -> c + I tt], {tt, -60, 60}, WorkingPrecision -> 20, PrecisionGoal -> 9, MaxRecursion -> 40, Method -> {"GlobalAdaptive", "SymbolicProcessing" -> 0}]/(2 Pi), seconds, $TimedOut]];
      log["[mellin tower] gate eps^", k, " u=", pt, " reference ", Round[AbsoluteTime[] - t0], " s"]; t0 = AbsoluteTime[];
      val = numericValue[vals[[k - lo + 1]], pars, pt];
      log["[mellin tower] gate eps^", k, " u=", pt, " value ", Round[AbsoluteTime[] - t0], " s"];
      rel = If[NumericQ[ref] && NumericQ[val], If[Abs[ref] > 10^-12, Abs[val - ref]/Abs[ref], Abs[val - ref]], Indeterminate];
      If[!(NumericQ[rel] && rel < 10^-6), ok = False];
      AppendTo[out, <|"Order" -> k, "Point" -> pt, "Reference" -> ref, "Value" -> val, "Relative" -> rel|>], {pt, points}], {k, lo, hi}];
  <|"Passed" -> ok, "Rows" -> out|>];

(* ---- 3a. the radial tower closure with DEGENERATE PAIRS ----
   A pair Gamma(a - z) Gamma(b + z) with a + b a nonpositive integer has coincident poles at z = a + n, n = 0..-(a+b):
   the tower of Gamma(a - z) starts on a multiple pole, and the rung's natural-base tower sum is singular there
   ("coincident natural tower bases").  Here the tower is summed from the first simple pole with the truncated
   hypergeometric form (parameter pair (1, 1+n0)), and the coincident poles are taken as finite residues of the
   full integrand with their total multiplicity.  Everything else is abtLaurentOne (mbeAbelTowerRung.m). *)
mtFail[s_] := Throw[<|"Failed" -> True, "Reason" -> s|>, mtTag];

(* ---- 3b. the UNIT-SCALE endpoint x -> 1 as an exact regularized limit ----
   The summed towers are rational(x) x HPLs of x (letters 0, 1); the sum is regular at x = 1 although its terms are
   not.  The HPLs are rewritten exactly at the argument 1 - x by the HPL package's transformation table, x = 1 - y,
   every HPL of y is replaced by its power-logarithmic expansion at y = 0 (the package's series upvalue), and the
   Laurent-log expansion of the sum must have no negative power and no power of log y: the value is its constant term.
   This replaces the Abel Limit of mbeAbelTowerRung.m, which is not certified on these sums. *)
(* ---- 3c. exact power-log jets of G-functions at a point, by path composition ----
   G(a_1..a_n; x0 + sigma) = sum_k Greg(a_{k+1}..a_n; x0) G(a_1-x0, ..., a_k-x0; sigma), with Greg the shuffle-regularized
   value at x0 (tangential base point, G(x0; x0) := 0) and the second factor expanded at sigma = 0 from the iterated-
   integral definition (all-zero words log^m/m!, a leading zero integrates dt/t, a nonzero leading letter a expands
   1/(t-a) = -sum t^m/a^(m+1)).  Reflected form for the point 1: G(w; 1-t) = sum_k Greg(a_{k+1}..a_n; 1) G(1-a_1..1-a_k; t)
   (the outer letters of the word belong to the last segment of the path). *)
mtLsym = Global`mtLog;
mtIntPow[k_, j_, x_, n_] := If[k + 1 > n, 0, x^(k + 1) Sum[(-1)^i j!/(j - i)! mtLsym^(j - i)/(k + 1)^(i + 1), {i, 0, j}]];
mtGser[{}, x_, n_] := 1;
mtGser[w_List, x_, n_] := mtGser[w, x, n] = Module[{a = First[w], rest = Rest[w], inner, res = 0, terms},
  If[AllTrue[w, # === 0 &], Return[mtLsym^Length[w]/Length[w]!]];
  inner = Expand[mtGser[rest, x, n]];
  terms = DeleteCases[List @@ (inner + Global`zzz) /. Global`zzz -> 0, 0];
  Do[Module[{k = Exponent[t, x], j = Exponent[t, mtLsym], c}, c = Cancel[t/(x^k mtLsym^j)];
    If[a === 0, If[k >= 1, res += c*mtIntPow[k - 1, j, x, n]], res += c*Sum[-(1/a^(m + 1))*mtIntPow[k + m, j, x, n], {m, 0, n}]]], {t, terms}];
  Expand[res]];
mtHPLBlock := {HPL`$HPLAutoConvertToKnownFunctions = False, HPL`$HPLAutoReduceToMinimalSet = False, HPL`$HPLAutoConvertToSimplerArgument = False,
  HPL`$HPLAutoProductExpand = False, HPL`$HPLAutoLogExtract = True};
mtGreg[w_List, x0_] := mtGreg[w, x0] = Module[{v},
  If[w === {}, Return[1]];
  v = PolyLogTools`ShuffleRegulate[PolyLogTools`G @@ Append[w, x0]];
  (* the regulator of the tangential base point at x0 (PolyLogTools writes it as G(x0;x0) / HPL({1},1)) is zero *)
  v /. HoldPattern[PolyLogTools`G[o__, x0]] /; MatchQ[{o}, {x0 ..}] :> 0 /. HPL`HPL[{1}, 1] -> 0];
mtConst[e_] := e /. PolyGamma[n_Integer, r_Rational] :> FunctionExpand[PolyGamma[n, r]] /. PolyGamma[n_Integer, r_Integer] :> FunctionExpand[PolyGamma[n, r]];
(* jet at x = 1 of an expression in G(w; x), Log, rational coefficients; t = 1 - x; returns the constant term or fails *)
mtJetOne[e_, x_, ppExtra_ : 0] := Block[{HPL`$HPLAutoConvertToKnownFunctions = False, HPL`$HPLAutoReduceToMinimalSet = False,
    HPL`$HPLAutoConvertToSimplerArgument = False, HPL`$HPLAutoProductExpand = False, HPL`$HPLAutoLogExtract = True},
  Module[{aa, t, gs, dd, pp, jetG, loc, val, lin},
  aa = e /. {PolyLog[n_Integer, x] :> HPL`HPL[{n}, x], PolyLog[n_Integer, -x] :> -HPL`HPL[{-n}, x],
    PolyLog[n_Integer, p_Integer, x] /; n >= 1 && p >= 1 :> HPL`HPL[Join[{n + 1}, ConstantArray[1, p - 1]], x]};
  aa = aa /. {Log[x] -> PolyLogTools`G[0, x], Log[1 - x] -> PolyLogTools`G[1, x], Log[1 + x] -> PolyLogTools`G[-1, x], Log[-1 + x] -> PolyLogTools`G[1, x] + I Pi};
  aa = aa /. h : HPL`HPL[_, a_] /; !FreeQ[a, x] :> PolyLogTools`HPLToG[h];
  (* remaining polylogarithms of a linear argument alpha + beta x: through HPLs of that argument *)
  aa = aa /. PolyLog[n_Integer, a_] /; !FreeQ[a, x] && PolynomialQ[a, x] && Exponent[a, x] == 1 :> PolyLogTools`HPLToG[HPL`HPL[{n}, a]];
  aa = aa /. Log[a_] /; !FreeQ[a, x] && PolynomialQ[a, x] && Exponent[a, x] == 1 && (a /. x -> 0) =!= 0 :> Log[a /. x -> 0] + PolyLogTools`G[-(a /. x -> 0)/Coefficient[a, x], x];
  If[!FreeQ[aa, HPL`HPL[_, a_] /; !FreeQ[a, x]] || !FreeQ[aa, (Log | PolyLog)[___, a_] /; !FreeQ[a, x]], mtFail["jet: functions outside the G class: " <>
    ToString[DeleteDuplicates[Cases[aa, (HPL`HPL | Log | PolyLog)[___, a_] /; !FreeQ[a, x], {0, Infinity}]], InputForm]]];
  If[!FreeQ[aa, PolyLogTools`G[w__, a_] /; !FreeQ[a, x] && !FreeQ[{w}, x]], mtFail["jet: letters depend on the variable"]];
  (* arguments: x itself (composition at 1), or alpha + beta x with alpha + beta = 1 (composition at 1, sigma = -beta t) or alpha + beta = 0 (direct jet in -beta t) *)
  lin = DeleteDuplicates[Cases[aa, PolyLogTools`G[__, a_] /; !FreeQ[a, x] :> a, {0, Infinity}]];
  If[!AllTrue[lin, PolynomialQ[#, x] && Exponent[#, x] == 1 && MemberQ[{0, 1}, Simplify[# /. x -> 1]] &], mtFail["jet: G argument outside the linear class: " <> ToString[lin, InputForm]]];
  dd = Denominator[Together[aa /. PolyLogTools`G[__, a_] /; !FreeQ[a, x] -> 1]];
  If[!PolynomialQ[dd, x], mtFail["jet: denominator not polynomial"]];
  pp = Max[0, Exponent[dd /. x -> 1 - t, t, Min]] + ppExtra; If[pp > 10, mtFail["jet: pole order beyond the tested bound"]];
  gs = DeleteDuplicates[Cases[aa, PolyLogTools`G[__, a_] /; !FreeQ[a, x], {0, Infinity}]];
  jetG[g_] := Module[{w = Most[List @@ g], a = Last[g], n = Length[Most[List @@ g]], beta, at1},
    beta = Coefficient[a, x]; at1 = Simplify[a /. x -> 1];
    (* path composition 0 -> 1 -> 1 - beta t: the OUTER letters (the first k) live on the second segment *)
    If[at1 === 1, Sum[mtGreg[Drop[w, k], 1] mtGser[1 - Take[w, k], t, pp] /. t -> beta t, {k, 0, n}] /. mtLsym -> mtLsym + Log[beta],
      (* argument -> 0 at x = 1: the word itself expanded at sigma = -beta t; G(w; sigma) with sigma = c t, c = -beta *)
      mtGser[w, t, pp] /. t -> -beta t /. mtLsym -> mtLsym + Log[-beta]]];
  loc = (aa /. Table[g -> jetG[g], {g, gs}]) /. x -> 1 - t;
  val = Quiet@Normal@Series[loc, {t, 0, 0}];
  val = mtConst[Quiet@Together[Expand[val]]];
  If[!FreeQ[val, t | mtLsym], val = Simplify[val]];
  If[!FreeQ[val, t | mtLsym | Indeterminate | ComplexInfinity | _DirectedInfinity], mtFail["jet: negative powers or logarithms do not cancel at 1: " <> ToString[Short[val, 6], InputForm]]];
  Global`mbeCanonicalConstants[val]]];

(* logarithms of rational functions of the variable, split into logarithms of the linear factors (all positive on (0,1)) *)
mtLogSplit[e_, x_] := e /. Log[a_] /; !FreeQ[a, x] && !MatchQ[a, x | 1 - x | 1 + x] :> Module[{f = Factor[Together[a]], fl, c, lin, out, sgn},
  fl = FactorList[f]; c = Times @@ (#[[1]]^#[[2]] & /@ Select[fl, FreeQ[#[[1]], x] &]);
  lin = Select[fl, !FreeQ[#[[1]], x] &];
  If[!AllTrue[lin, PolynomialQ[#[[1]], x] && Exponent[#[[1]], x] == 1 &], mtFail["endpoint: logarithm of a nonlinear factor: " <> ToString[a, InputForm]]];
  (* a factor negative on (0,1) is replaced by its negative, the sign goes to the constant *)
  lin = Table[sgn = Sign[l[[1]] /. x -> 1/2]; If[sgn < 0, c = c (-1)^l[[2]]; {-l[[1]], l[[2]]}, l], {l, lin}];
  If[!TrueQ[Simplify[c] > 0], mtFail["endpoint: logarithm with a non-positive constant factor: " <> ToString[a, InputForm]]];
  out = Log[Simplify[c]] + Total[(#[[2]] Log[#[[1]]]) & /@ lin];
  out /. Log[b_] /; !FreeQ[b, x] :> With[{b0 = b /. x -> 0, b1 = Coefficient[b, x]}, Which[b0 === 0, Log[b1] + Log[x], True, Log[b0] + Log[Expand[1 + b1/b0 x]]]] /.
    {Log[1 - x] -> Log[1 - x], Log[1 + x] -> Log[1 + x]}];

mtUnitEndpoint[e_, x_] := Module[{aa, s},
  aa = Block[{HPL`$HPLAutoConvertToKnownFunctions = False, HPL`$HPLAutoReduceToMinimalSet = False, HPL`$HPLAutoConvertToSimplerArgument = False,
      HPL`$HPLAutoProductExpand = False, HPL`$HPLAutoLogExtract = True},
    e /. {PolyLog[n_Integer, x] :> HPL`HPL[{n}, x], PolyLog[n_Integer, 1 - x] :> HPL`HPL[{n}, 1 - x], PolyLog[n_Integer, -x] :> -HPL`HPL[{-n}, x],
      PolyLog[n_Integer, p_Integer, x] /; n >= 1 && p >= 1 :> HPL`HPL[Join[{n + 1}, ConstantArray[1, p - 1]], x]}];
  (* half-integer hypergeometric parameters give HPLs of Sqrt[x] with +- weights and logarithms of rational functions
     of Sqrt[x]: pass to s = Sqrt[x], x = s^2, every integer-weight HPL of x rewritten in s by the package's table,
     +- weights to integer weights, logarithms split into their linear factors; then the endpoint s -> 1 *)
  If[!FreeQ[aa, Sqrt[x]],
    (* the inner Module must not swallow the Return: compute the s-form, then return from THIS Module *)
    s = Unique["mtS"];
    aa = Block[{HPL`$HPLAutoConvertToKnownFunctions = False, HPL`$HPLAutoReduceToMinimalSet = False, HPL`$HPLAutoConvertToSimplerArgument = False,
        HPL`$HPLAutoProductExpand = False, HPL`$HPLAutoLogExtract = True},
      HPL`HPLpm21m1[(aa /. h : HPL`HPL[_, x] :> HPL`HPLArgTransform[h, x -> Sqrt[x]]) /. Sqrt[x] -> s /. {Log[x] -> 2 Log[s], Log[1 - x] -> Log[1 - s] + Log[1 + s]} /. x -> s^2]];
    If[!FreeQ[aa, Sqrt[s] | Power[s, _Rational]], mtFail["endpoint: nested square roots of the damping variable"]];
    If[!FreeQ[aa, x], mtFail["endpoint: the damping variable survived the square-root substitution"]];
    Return[mtUnitEndpoint[aa, s], Module]];
  aa = mtLogSplit[aa, x];
  If[!FreeQ[aa, PolyLog[___, a_] /; !FreeQ[a, x]] || !FreeQ[aa, Log[a_] /; !FreeQ[a, x] && a =!= x && a =!= 1 - x && a =!= 1 + x],
    mtFail["endpoint: functions of the damping variable outside the HPL class: " <>
      ToString[DeleteDuplicates[Cases[aa, (Log | PolyLog)[___, a_] /; !FreeQ[a, x], {0, Infinity}]], InputForm]]];
  If[!FreeQ[aa, HPL`HPL[m_, a_] /; !FreeQ[a, x] && !AllTrue[m, IntegerQ]], mtFail["endpoint: HPL weights outside the integer class: " <>
    ToString[DeleteDuplicates[Cases[aa, HPL`HPL[m_, a_] /; !FreeQ[a, x] && !AllTrue[m, IntegerQ] :> HPL`HPL[m, a], {0, Infinity}]], InputForm]]];
  If[!FreeQ[aa, HPL`HPL[_, a_] /; !FreeQ[a, x] && a =!= x && a =!= 1 - x], mtFail["endpoint: HPL argument outside {x, 1-x}: " <>
    ToString[DeleteDuplicates[Cases[aa, HPL`HPL[_, a_] /; !FreeQ[a, x] && a =!= x :> a, {0, Infinity}]], InputForm]]];
  mtJetOne[aa, x]];

mtLaurentOne[f_, z_, ep_, c_, lo_Integer, hi_Integer, verbose_ : False, unitQ_ : False, compactQ_ : False] := Catch[Module[
  {dec, gam, eff, forms, delta, cl, x = Unique["mtX"], total = 0, blocks = {}, d, tw, base, prefix, raw, dep, ex, series, vals, lowerPoles,
   start = AbsoluteTime[], expansionRecord, finite, coincident, n0, extraMult = <||>, handled = {}},
  dec = Catch[MBAnalytica`SymbolicInt`Private`mbeOFCDecompose[f, z], MBAnalytica`SymbolicInt`Private`mbeOFC$tag];
  If[!AssociationQ[dec], mtFail["Gamma decomposition failed"]];
  gam = dec["Gammas"];
  Global`$abtLastRun = <|"Closed" -> False|>;
  If[!FreeQ[dec["Rest"], z], mtFail["remainder depends on the Mellin variable"]];
  If[!AllTrue[gam, Global`sbrAffineQ[#[[1]], {z, ep}] && MemberQ[{-1, 0, 1}, Coefficient[#[[1]], z]] &],
    mtFail["Gamma arguments are outside the rational-affine unit-slope class"]];
  eff = Table[Total[Last /@ Select[gam, Coefficient[First[#], z] === sg &]], {sg, {1, -1}}];
  (* compactQ (29 September 2026): a zero net Gamma count is admitted when the caller has chosen the closing side from the
     decay of the scale factor and gates the result by the forward Mellin transform (the Parseval move of the handler) *)
  If[!TrueQ[eff[[1]] === eff[[2]] && (eff[[1]] > 0 || (TrueQ[compactQ] && eff[[1]] == 0))], mtFail["effective Gamma counts are not equal and positive"]];
  If[AnyTrue[gam, Function[g, g[[2]] > 0 && Coefficient[g[[1]], z] =!= 0 &&
      With[{atZero = g[[1]] /. {z -> c, ep -> 0}}, IntegerQ[atZero] && atZero <= 0]]],
    mtFail["the original contour meets a numerator pole at epsilon zero"]];
  forms = First /@ gam; delta = Global`sbrSafeInterval[forms, {z -> c}, ep];
  cl = Catch[MBAnalytica`SymbolicInt`Private`mbeOFCClose[f, z, ep, c, ep -> -delta/2], MBAnalytica`SymbolicInt`Private`mbeOFC$tag];
  If[!AssociationQ[cl], mtFail["simple right towers are unavailable"]];
  (* 3 October 2026: two legs on one pole lattice give double poles that the per-leg simple towers below do not see
     (mbeAbelTowerRung.m, abtOverlappingTowersQ: MB8a residue 50) *)
  If[DownValues[Global`abtOverlappingTowersQ] =!= {} && Global`abtOverlappingTowersQ[cl["RightPoles"]["Towers"]],
    mtFail["two legs on one pole lattice (multiple-pole towers)"]];
  finite = cl["RightPoles"]["Finite"];   (* {position -> multiplicity} of the up-poles right of the contour *)
  Do[
    If[pa["Type"] === "Tower",
      tw = SelectFirst[cl["RightPoles"]["Towers"], #["Base"] === pa["Base"] &];
      base = tw["Al"];
      (* degenerate pair: tower poles base + n coinciding with finite up-poles *)
      coincident = Select[finite, With[{k = Simplify[First[#] - base]}, IntegerQ[k] && k >= 0] &];
      If[coincident =!= {},
        n0 = Max[Simplify[First[#] - base] & /@ coincident] + 1;
        Do[extraMult[First[cp]] = Lookup[extraMult, Key[First[cp]], 0] + tw["Mult"], {cp, coincident}];
        If[verbose, Print["    [mellin tower] degenerate pair at base ", base, ": tower from n = ", n0, ", coincident poles ", First /@ coincident]];
        d = MBAnalytica`SymbolicInt`Private`mbeOFCTowerSum[dec, z, base + n0, ep, base, n0];
        If[!FreeQ[d["Pref"], Indeterminate | ComplexInfinity | _DirectedInfinity], mtFail["coincident tower bases beyond the degenerate-pair class"]];
        prefix = 0,
        d = MBAnalytica`SymbolicInt`Private`mbeOFCTowerSum[dec, z, base, ep, base, 0];
        If[!FreeQ[d["Pref"], Indeterminate | ComplexInfinity | _DirectedInfinity], mtFail["coincident natural tower bases"]];
        n0 = 0;
        prefix = d["Pref"] x^base Sum[(d["Arg"] x)^jj/jj! (Times @@ (Pochhammer[#, jj] & /@ d["Num"]))/(Times @@ (Pochhammer[#, jj] & /@ d["Den"])), {jj, 0, tw["N0"] - 1}]];
      raw = HypergeometricPFQ[d["Num"], d["Den"], d["Arg"] x];
      lowerPoles = Count[d["Den"], qq_ /; With[{q0 = qq /. ep -> 0}, IntegerQ[q0] && q0 <= 0]];
      dep = hi - Global`oftLeadOrder[d["Pref"], ep, Max[0, hi + lowerPoles]];
      If[dep === -Infinity, Continue[]];
      If[verbose, Print["    [mellin tower] base ", pa["Base"], ", start ", n0, ", depth ", dep, ", p/q ", {Length[d["Num"]], Length[d["Den"]]}]];
      Global`$abtLastBlock = <|"Input" -> raw, "Depth" -> dep, "Base" -> pa["Base"], "Budget" -> Global`$abtBlockSeconds|>;
      expansionRecord = If[DownValues[Global`hbbExpand] =!= {},
        Global`hbbExpand[raw, ep, Max[0, dep], Global`$abtBlockSeconds, x],
        <|"Expansion" -> Quiet@TimeConstrained[HypExp`HypExp[raw, ep, Max[0, dep]], Global`$abtBlockSeconds, $Failed]|>];
      ex = expansionRecord["Expansion"];
      If[!FreeQ[ex, $Failed | $Aborted | HypergeometricPFQ | Hypergeometric2F1 | HypExp`HypExp], mtFail["a radial hypergeometric block did not expand"]];
      total += Normal@Series[d["Pref"] x^(base + n0) ex - prefix, {ep, 0, hi}];
      AppendTo[blocks, <|"Base" -> pa["Base"], "Start" -> n0, "Depth" -> dep|>],
      (* finite crossed pole: full residue of x^z f with the total multiplicity (up-poles + coincident tower poles) *)
      If[MemberQ[handled, pa["Z"]], Continue[]];
      d = SelectFirst[finite, First[#] === pa["Z"] &];
      total -= Normal@Series[MBAnalytica`SymbolicInt`Private`mbeOFCFiniteRes[x^z f, z, pa["Z"], Last[d] + Lookup[extraMult, Key[pa["Z"]], 0]], {ep, 0, hi}];
      AppendTo[handled, pa["Z"]]],
    {pa, cl["Parts"]}];
  series = Series[total, {ep, 0, hi}];
  vals = Table[If[verbose, Print["    [mellin tower] endpoint eps^", kk]];
    If[unitQ, mtUnitEndpoint[Global`abtCoefficient[series, ep, kk], x], Global`abtEndpoint[Global`abtCoefficient[series, ep, kk], x]], {kk, lo, hi}];
  If[Global`abtUnfinishedQ[vals] || !FreeQ[vals, ep | z] || !MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[vals], mtFail["unclean exact coefficients"]];
  Global`$abtLastRun = <|"Closed" -> True, "EffectiveCounts" -> eff, "Interval" -> {-delta, 0}, "Blocks" -> blocks, "Seconds" -> AbsoluteTime[] - start|>;
  If[verbose, Print["    [mellin tower] closed in ", Round[AbsoluteTime[] - start], " s"]];
  vals], mtTag];

(* ---- 3. closure ---- *)
Options[mbeMellinTowerClose] = {"Directions" -> {"RIGHT", "LEFT"}, "Gate" -> True, "GatePoints" -> Automatic, "GateSeconds" -> 900,
  "BlockSeconds" -> 1200, "Seconds" -> 3000, "Log" -> Print, "Verbose" -> False, "CompactSupport" -> False};
mbeMellinTowerClose[F_, z_, ep_, c_, lo_Integer, hi_Integer, pars_List, dom_, OptionsPattern[]] := Module[
  {log = OptionValue["Log"], f1, sc, bb, bare, dec, gam, keys, eff, attempts = {}, vals = $Failed, direction = None, fz, zz, cc, scale, w, gate, pts, thresholds, arg},
  f1 = mbeMellinSlopeNormalize[F, z]; If[FailureQ[f1], Return[f1, Module]];
  sc = mbeMellinScaleSplit[f1, z, pars, dom]; If[FailureQ[sc], Return[sc, Module]];
  bb = sc["Scale"]; bare = sc["Rest"];
  dec = Catch[MBAnalytica`SymbolicInt`Private`mbeOFCDecompose[bare, z], MBAnalytica`SymbolicInt`Private`mbeOFC$tag];
  If[!AssociationQ[dec], Return[refuse["Gamma decomposition failed"], Module]];
  If[!FreeQ[dec["Rest"], z], Return[refuse["dressing depends on the Mellin variable", <|"Rest" -> dec["Rest"]|>], Module]];
  gam = dec["Gammas"];
  keys = Table[{Coefficient[g[[1]], z], Expand[g[[1]] /. z -> 0]}, {g, gam}];
  If[!DuplicateFreeQ[keys] || AnyTrue[gam, #[[2]] > 1 && Coefficient[#[[1]], z] =!= 0 &],
    Return[refuse["exactly coincident Gamma legs need regulators", <|"Gammas" -> gam|>], Module]];
  eff = Table[Total[Last /@ Select[gam, Coefficient[First[#], z] === sg &]], {sg, {1, -1}}];
  If[!TrueQ[eff[[1]] === eff[[2]] && (eff[[1]] > 0 || (TrueQ[OptionValue["CompactSupport"]] && eff[[1]] == 0))],
    Return[refuse["leg counts not balanced and positive", <|"Effective" -> eff|>], Module]];
  arg = (-1)^eff[[2]];
  log["[mellin tower] scale ", InputForm[bb], ", legs ", eff, ", tower argument sign ", arg];
  Do[
    If[dir === "RIGHT", fz = bare; zz = z; cc = c; scale = bb,
      w = Unique["mtw"]; fz = bare /. z -> -w; zz = w; cc = -c; scale = 1/bb];
    vals = If[scale === 1,
      (* unit scale: the rung's own Abel endpoint x -> 1 (limit of the summed towers) *)
      Block[{Global`$abtBlockSeconds = OptionValue["BlockSeconds"]},
        TimeConstrained[mtLaurentOne[fz, zz, ep, cc, lo, hi, OptionValue["Verbose"], True, TrueQ[OptionValue["CompactSupport"]]], OptionValue["Seconds"], $TimedOut]],
      Block[{Global`abtEndpoint, Global`$abtBlockSeconds = OptionValue["BlockSeconds"]},
        Global`abtEndpoint[v_, x_] := v /. x -> scale;
        TimeConstrained[mtLaurentOne[fz, zz, ep, cc, lo, hi, OptionValue["Verbose"], False, TrueQ[OptionValue["CompactSupport"]]], OptionValue["Seconds"], $TimedOut]]];
    If[ListQ[vals] && Length[vals] === hi - lo + 1 && FreeQ[vals, $Failed | $Aborted | _Real],
      direction = dir; log["[mellin tower] closed ", dir, " in ", Round[Lookup[Global`$abtLastRun, "Seconds", 0]], " s"]; Break[],
      AppendTo[attempts, <|"Direction" -> dir, "Reason" -> If[AssociationQ[vals], vals["Reason"], vals]|>];
      log["[mellin tower] ", dir, " refused: ", If[AssociationQ[vals], vals["Reason"], vals]]], {dir, OptionValue["Directions"]}];
  If[direction === None, Return[refuse["no closure direction", <|"Attempts" -> attempts|>], Module]];
  log["[mellin tower] raw coefficients: leaf counts ", LeafCount /@ vals];
  If[StringQ[Global`$mellinTowerDump], Quiet@Put[<|"Raw" -> vals, "F" -> F, "z" -> z, "ep" -> ep, "c" -> c, "lo" -> lo, "hi" -> hi, "pars" -> pars, "Scale" -> bb, "Direction" -> direction|>, Global`$mellinTowerDump]];
  vals = Table[Quiet@TimeConstrained[Global`mbeCanonicalConstants[v], 300, v], {v, vals}];
  log["[mellin tower] canonical constants done: leaf counts ", LeafCount /@ vals];
  If[!TrueQ[OptionValue["Gate"]], Return[<|"Values" -> vals, "Direction" -> direction, "Scale" -> bb, "Gate" -> None|>, Module]];
  pts = OptionValue["GatePoints"];
  If[pars === {}, pts = {{}}];
  If[pts === Automatic,
    (* both sides of every scale threshold |scale| = 1 inside the domain, plus the interior points 1/3 and 5/7 *)
    thresholds = If[Length[pars] === 1, DeleteDuplicates@Select[Flatten[Quiet@Solve[bb == 1, pars[[1]]] /. Rule[_, v_] :> v], NumericQ[#] && 0 < # < 1 &], {}];
    pts = DeleteDuplicates[Join[{1/3, 5/7}, Flatten[Table[{Rationalize[t - 1/20], Rationalize[t + 1/20]}, {t, thresholds}]]]];
    pts = Select[pts, 0 < # < 1 &]; pts = List /@ pts];
  log["[mellin tower] gate points ", pts];
  gate = mbeMellinTowerGate[F, z, ep, c, lo, hi, vals, pars, pts, OptionValue["GateSeconds"], log];
  Do[log["[mellin tower] gate eps^", r["Order"], " u=", r["Point"], " ref ", N[r["Reference"], 12], " value ", N[r["Value"], 12], " rel ", N[r["Relative"], 3]], {r, gate["Rows"]}];
  If[!TrueQ[gate["Passed"]], Return[refuse["gate failed", <|"Gate" -> gate, "Values" -> vals, "Direction" -> direction, "Scale" -> bb|>], Module]];
  <|"Values" -> vals, "Direction" -> direction, "Scale" -> bb, "Gate" -> gate|>];

mbeMellinLaurent[F_, z_, ep_, c_, lo_Integer, hi_Integer, pars_List, dom_, opts : OptionsPattern[mbeMellinTowerClose]] := Module[{terms, total = 0, res, log = OptionValue[mbeMellinTowerClose, {opts}, "Log"]},
  terms = If[Head[#] === Plus, List @@ #, {#}] &[Expand[F]];
  log["[mellin tower] ", Length[terms], " term(s)"];
  Do[res = mbeMellinTowerClose[terms[[i]], z, ep, c, lo, hi, pars, dom, opts];
    If[FailureQ[res], Return[Failure["MellinTower", <|"Reason" -> "term " <> ToString[i] <> ": " <> res["Reason"], "Term" -> i, "Detail" -> res|>], Module]];
    total += Total[MapThread[#1 ep^#2 &, {res["Values"], Range[lo, hi]}]], {i, Length[terms]}];
  total];

End[];
EndPackage[];
Print["[mbeMellinTowerRung] one-fold MB integrals with parameter damping: Gauss multiplication, scale split, epsilon-symbolic radial towers at the scale, two-sided contour gate."];
