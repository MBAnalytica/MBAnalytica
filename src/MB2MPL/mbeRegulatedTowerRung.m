(* ::Package:: *)
(* AUTHORSHIP (rung, 2026-09-11): MB2MPL regulated tower-closure rung for dressed one-fold residues. Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)

(* mbeRegulatedTowerRung.m -- REGULATED / DERIVATIVE TOWER CLOSURE of a one-fold residue (Subtraction route sidecar;
   loaded after mbeOneFoldTowerRung.m, whose engine and family driver it extends).

   A one-fold residue of MBresolve at a multiple pole carries, besides its Gamma product K(z), a DRESSING: polygamma
   factors psi^(m)(L) with L affine in z and eps, and rational factors 1/l(z)^k; and K itself may carry a Gamma leg
   with multiplicity two or more (a multiple-pole tower).  The sealed tower engine refuses all three ("phase not
   n-constant", "multiple-pole tower unsupported"), and the faithful cube closes such residues only through one Euler
   variable per dressing factor (MB5's residue 4: six variables, and its cube pieces at eps^1 exceed the integrator).
   This rung removes the three obstructions by exact identities and closes the residue through the towers:

     (i)   1/l = Gamma(l)/Gamma(l + 1),  l = Gamma(l + 1)/Gamma(l): every rational in z becomes a Gamma ratio;
     (ii)  psi^(m)(L) = d^(m+1)/du^(m+1) log Gamma(L + u) at u = 0 = d^(m+1)/du^(m+1) log G(u), G(u) = Gamma(L+u)/Gamma(L):
           the (m+1)-th CUMULANT of G, a polynomial in the moments G^(k)(0); a product of r moments is the mixed
           derivative of a product of r COPIES G(u_1)...G(u_r) at u = 0, so every polygamma monomial of the dressing
           is a linear combination of mixed u-derivatives of the Gamma-copy integrand  K x prod_j Gamma(L_j + u_j)/Gamma(L_j);
     (iii) a leg of multiplicity p, Gamma(L)^p, is split into Gamma(L) Gamma(L + u_2) ... Gamma(L + u_p) (the same for
           the Gamma ratios of (i) whose pole coincides with a tower); the closure is analytic in the shifts, and the
           limit u -> 0 is taken on the eps-coefficients after the poles 1/(u_i - u_j) of the separate towers have
           cancelled in their sum.
   With u_j = lam_j eps the shifted integrand is a plain Gamma product with parameters affine in eps (coefficients
   symbolic in the lam's), which the tower engine closes in either direction; HypExp expands the blocks with symbolic
   eps-coefficients; the derivatives d/du = (1/eps) d/dlam act on the eps-coefficients, which are polynomials in the
   lam's once the towers are summed (Together), and the remaining lam's are set to zero.  Depth: ordMax + (total
   derivative order).  Every step is an exact identity or a limit of an analytic function; the result is served only
   when every coefficient is an exact expression (no lam left, no inexact atom).

   Fail-closed: a dressing factor outside (i)/(ii), a Gamma-part whose towers are inadmissible in both directions, a
   block HypExp cannot expand, an eps-coefficient that is not polynomial in the lam's after Together, or any inexact
   atom returns $Failed and the family driver continues with the faithful cube. *)

If[! TrueQ[Global`$rtwRungInstalled],
Module[{},
  If[! ValueQ[Global`$rtwMaxCopies], Global`$rtwMaxCopies = 6];      (* refuse dressings needing more regulator symbols *)
  If[! ValueQ[Global`$rtwTogetherSeconds], Global`$rtwTogetherSeconds = 600];
  Global`$rtwLastRun = <||>;
  Global`rtw$fail[msg_] := Throw[<|"Failed" -> True, "Reason" -> ToString[msg]|>, Global`rtw$tag];
  Global`rtwAffineQ[l_, z_, eps_] := PolynomialQ[l, {z, eps}] && Exponent[l, z] <= 1 && Exponent[l, eps] <= 1;

  (* the cumulant of order n of a generating function g with g(0) = 1, as {coefficient, {moment orders}} terms *)
  Global`rtwCumulantTerms[n_Integer] := Module[{g, u, e, terms},
    e = Expand[D[Log[g[u]], {u, n}] /. u -> 0 /. g[0] -> 1];
    terms = If[Head[e] === Plus, List @@ e, {e}];
    Table[Module[{c = t /. Derivative[_][g][0] -> 1, ks},
      ks = Join @@ Cases[If[Head[t] === Times, List @@ t, {t}], (Derivative[k_][g][0])^(a_.) :> ConstantArray[k, a]];
      {c, Sort[ks]}], {t, terms}]];

  (* the dressing of a one-fold residue: K (Gamma part) and the terms of f/K:
     {{coef (z-free), rationals {{l, k}}, polynomials {l}, polygammas {{m, L}} (a power a listed a times)}} *)
  Global`rtwParse[f_, z_, eps_] := Module[{terms0, gp, K, D, terms, out = {}},
    terms0 = If[Head[f] === Plus, List @@ f, {f}];
    gp = Function[t, Times @@ Cases[If[Head[t] === Times, List @@ t, {t}], Gamma[_] | Power[Gamma[_], _Integer]]];
    K = gp[terms0[[1]]];
    D = Together[f/K];
    If[! FreeQ[D, Gamma], D = Expand[Together[Total[Table[Cancel[t/K], {t, terms0}]]]]];
    If[! FreeQ[D, Gamma], Global`rtw$fail["Gamma functions inside the dressing"]];
    D = Expand[D];
    terms = If[Head[D] === Plus, List @@ D, {D}];
    Do[Module[{facs = If[Head[t] === Times, List @@ t, {t}], coef = 1, rats = {}, pols = {}, psis = {}},
      Do[Which[
        FreeQ[fa, z], coef = coef fa,
        MatchQ[fa, Power[_, _Integer?Negative]] && Global`rtwAffineQ[fa[[1]], z, eps], AppendTo[rats, {fa[[1]], -fa[[2]]}],
        MatchQ[fa, Power[_PolyGamma, _Integer?Positive]] && Global`rtwAffineQ[fa[[1, 2]], z, eps],
          psis = Join[psis, ConstantArray[{fa[[1, 1]], fa[[1, 2]]}, fa[[2]]]],
        MatchQ[fa, _PolyGamma] && Global`rtwAffineQ[fa[[2]], z, eps], AppendTo[psis, {fa[[1]], fa[[2]]}],
        PolynomialQ[fa, z],
          Do[If[FreeQ[q[[1]], z], coef = coef q[[1]]^q[[2]],
             If[Global`rtwAffineQ[q[[1]], z, eps], pols = Join[pols, ConstantArray[q[[1]], q[[2]]]],
               Global`rtw$fail["polynomial factor not affine: " <> ToString[fa, InputForm]]]], {q, FactorList[fa]}],
        True, Global`rtw$fail["dressing factor not representable: " <> ToString[fa, InputForm]]], {fa, facs}];
      AppendTo[out, <|"Coef" -> coef, "Rationals" -> rats, "Polys" -> pols, "Psis" -> psis|>]], {t, terms}];
    <|"K" -> K, "Terms" -> out|>];

  (* the regulated Gamma integrand of one term and its derivative operators:
     <|"Integrand", "Ops" -> {{coefficient, {lam -> order ...}}}, "Lams" -> all regulator symbols, "MaxOrder"|> *)
  Global`rtwBuild[K_, term_, z_, eps_, newLam_] := Module[{g = K, ops = {{1, {}}}, lams = {}, gams, mult, lam, kmax = 0},
    (* (iii) multiplicities of K: split every leg of multiplicity p >= 2 into p simple legs *)
    gams = If[Head[#] === Times, List @@ #, {#}] &[K];
    g = 1;
    Do[Which[
      MatchQ[t, Power[Gamma[_], _Integer?Positive]] && t[[2]] >= 2 && ! FreeQ[t, z],
        g = g Gamma[t[[1, 1]]] Product[lam = newLam[]; AppendTo[lams, lam]; Gamma[t[[1, 1]] + lam eps], {t[[2]] - 1}],
      True, g = g t], {t, gams}];
    (* (i) rationals and polynomials: every copy carries its own regulator (its pole may sit on a tower of K) *)
    Do[Do[lam = newLam[]; AppendTo[lams, lam]; g = g Gamma[r[[1]] + lam eps]/Gamma[r[[1]] + 1 + lam eps], {r[[2]]}], {r, term["Rationals"]}];
    Do[lam = newLam[]; AppendTo[lams, lam]; g = g Gamma[p + 1 + lam eps]/Gamma[p + lam eps], {p, term["Polys"]}];
    (* (ii) polygammas: one factor psi^(m)(L) -> m+1 copies Gamma(L + u_j)/Gamma(L) and the cumulant operator *)
    Do[Module[{m = ps[[1]], L = ps[[2]], copies, cts},
       copies = Table[lam = newLam[]; AppendTo[lams, lam]; lam, {m + 1}];
       Do[g = g Gamma[L + c eps]/Gamma[L], {c, copies}];
       cts = Global`rtwCumulantTerms[m + 1];
       ops = Flatten[Table[{o[[1]] ct[[1]], Join[o[[2]], Thread[Take[copies, Length[ct[[2]]]] -> ct[[2]]]]}, {o, ops}, {ct, cts}], 1]],
      {ps, term["Psis"]}];
    kmax = Max[Table[Total[o[[2]][[All, 2]]], {o, ops}]];
    <|"Integrand" -> term["Coef"] g, "Ops" -> ops, "Lams" -> lams, "MaxOrder" -> kmax|>];

  (* close one regulated integrand to a Laurent list ordMin..ordMax+kmax (the caller applies the operators) *)
  Global`rtwCloseIntegrand[g_, z_, eps_, c_, lams_, ordMin_, ordMaxK_, verbose_] := Module[{eN, cl, exp, ser, out},
    eN = Join[{eps -> -1/100}, Table[lams[[j]] -> Prime[j + 3]/(20 Prime[j + 3] + 7), {j, Length[lams]}]];
    cl = Global`oftCloseOne[g, z, eps, c, eN, ordMaxK];
    If[TrueQ[cl["Failed"]], Return[<|"Failed" -> True, "Reason" -> cl["Reason"]|>]];
    If[verbose, Print["    [regulated tower] closure ", cl["Direction"], " (", cl["Parts"], " parts; ", Length[cl["Blocks"]],
      " transcendental block(s), depths ", cl["Blocks"][[All, "Depth"]], "; regulators ", Length[lams], ")"]];
    exp = Global`oftExpandBlocks[cl["Blocks"], eps, verbose];
    If[exp === $Failed, Return[<|"Failed" -> True, "Reason" -> "a block was not expanded"|>]];
    ser = Quiet@Series[cl["Others"], {eps, 0, ordMaxK}];
    Do[ser += Quiet@Series[b["Pref"] (b["PFQ"] /. exp), {eps, 0, ordMaxK}], {b, cl["Blocks"]}];
    If[! FreeQ[ser, HypergeometricPFQ | HypExp`HypExp | Indeterminate | ComplexInfinity | DirectedInfinity],
      Return[<|"Failed" -> True, "Reason" -> "the closure is not a clean Laurent expansion"|>]];
    <|"Failed" -> False, "Series" -> ser, "Direction" -> cl["Direction"]|>];

  (* the handler: an MBresolve one-fold residue term -> exact Laurent coefficients ordMin..ordMax, or $Failed *)
  Global`oftRegulatedClose[term_, eps_, ordMin_Integer, ordMax_Integer, verbose_] := Catch[Module[
    {f = term[[1]], ctr = term[[2, 2]], z, c, parsed, nl = 0, newLam, total, t0 = AbsoluteTime[], log = {}},
    If[Length[ctr] =!= 1, Throw[$Failed, Global`rtw$tag]];
    z = Keys[ctr][[1]]; c = Rationalize[ctr[[1, 2]], 0];
    newLam[] := (nl++; Symbol["Global`rtwLam" <> ToString[nl]]);
    parsed = Catch[Global`rtwParse[f, z, eps], Global`rtw$tag];
    If[AssociationQ[parsed] && TrueQ[parsed["Failed"]],
      If[verbose, Print["    [regulated tower] refused: ", parsed["Reason"]]]; Throw[$Failed, Global`rtw$tag]];
    If[verbose, Print["    [regulated tower] dressing: ", Length[parsed["Terms"]], " term(s); polygammas ",
      DeleteDuplicates[Join @@ (#["Psis"] & /@ parsed["Terms"])], ", rationals ",
      DeleteDuplicates[Join @@ (#["Rationals"] & /@ parsed["Terms"])]]];
    total = ConstantArray[0, ordMax - ordMin + 1];
    Do[Module[{b, cl, ser, coefs, kmax, contrib},
      nl = 0;
      b = Global`rtwBuild[parsed["K"], tm, z, eps, newLam];
      kmax = b["MaxOrder"];
      If[Length[b["Lams"]] > Global`$rtwMaxCopies,
        If[verbose, Print["    [regulated tower] refused: ", Length[b["Lams"]], " regulators needed"]]; Throw[$Failed, Global`rtw$tag]];
      cl = Global`rtwCloseIntegrand[b["Integrand"], z, eps, c, b["Lams"], ordMin, ordMax + kmax, verbose];
      If[TrueQ[cl["Failed"]],
        If[verbose, Print["    [regulated tower] refused: ", cl["Reason"]]]; Throw[$Failed, Global`rtw$tag]];
      ser = cl["Series"];
      (* the eps-coefficients, polynomial in the regulators once the towers are summed *)
      coefs = Association[Table[n -> Module[{cn = If[Head[ser] === SeriesData, SeriesCoefficient[ser, n], Coefficient[Expand[Normal[ser]], eps, n]], cnt},
          cnt = Quiet@TimeConstrained[Together[cn], Global`$rtwTogetherSeconds, $Failed];
          If[cnt === $Failed, Global`rtw$fail["Together of an eps-coefficient did not finish"]];
          If[! FreeQ[Denominator[cnt], Alternatives @@ b["Lams"]],
            Global`rtw$fail["an eps-coefficient is not polynomial in the regulators (order " <> ToString[n] <> ")"]];
          cnt], {n, ordMin, ordMax + kmax}]];
      contrib = Table[Module[{val = 0},
          Do[Module[{k = Total[o[[2]][[All, 2]]], cn, d},
             cn = coefs[N0 + k];
             d = If[o[[2]] === {}, cn, D[cn, Sequence @@ (List @@@ o[[2]])]];
             val += o[[1]] (d /. Thread[b["Lams"] -> 0])], {o, b["Ops"]}];
          val], {N0, ordMin, ordMax}];
      AppendTo[log, <|"Term" -> tm["Coef"], "Regulators" -> Length[b["Lams"]], "Ops" -> Length[b["Ops"]], "Direction" -> cl["Direction"]|>];
      total += contrib], {tm, parsed["Terms"]}];
    total = Quiet@Check[Expand[Global`mbeCanonicalConstants[#]], #] & /@ total;
    total = Table[If[LeafCount[t] < 300000, Quiet@TimeConstrained[Simplify[t], 120, t], t], {t, total}];
    If[! FreeQ[total, s_Symbol /; StringStartsQ[SymbolName[Unevaluated[s]], "rtwLam"]] || ! MBtoMPL`Private`mbtInexactNumberFreeQ[total] ||
       ! FreeQ[total, Indeterminate | ComplexInfinity | DirectedInfinity | $Failed | SeriesCoefficient],
      If[verbose, Print["    [regulated tower] refused: the assembled coefficients are not clean"]]; Throw[$Failed, Global`rtw$tag]];
    Global`$rtwLastRun = <|"Terms" -> log, "Seconds" -> AbsoluteTime[] - t0|>;
    If[verbose, Print["    [regulated tower] residue closed in ", Round[AbsoluteTime[] - t0], " s (", Length[log], " term(s))"]];
    total], Global`rtw$tag];

  Global`$rtwRungInstalled = True;
  Print["[mbeRegulatedTowerRung] installed: dressed one-fold residues (polygammas, rationals, multiple-pole towers) closed through regulated Gamma copies and derivative operators."];
]];
