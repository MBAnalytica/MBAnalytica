(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* mbeTwoVarPsiRung.m — sidecar rung (2026-09-04): EXACT closers for the new-MB12 multi-fold classes.
   Never edits the sealed core; installs by saved-DownValues wrapping.  Load AFTER load_mbe_engines.m
   (MBEStrategy`mbeStdClose) and AFTER the package; in workers after the engines too.

   PART A — the BWS engine (Barnes-With-Scale recursion), bwsClose[ig, ctr, vrs]:
     closes  C0 * prod Gamma(unit-slope legs) / prod Gamma(same-slope denominators) * prod (affine)^(-k) * psi^(m)(L)
     with ONE polygamma whose argument L is affine in >= 2 MB variables (the class that defeats every wired closer:
     psi(1+zA-zC), psi(2+zA+zB)).  Every step is an exact identity (standard_syed.tex: Lemma aux, Lemma sameorient,
     DLMF 15.6.7 Barnes-with-scale, Euler representation; contour crossings by explicit residues):
       (1) psi^(0)(L) = -gamma + Int_0^1 (1 - s^(L-1))/(1-s) ds,  psi^(m>=1)(L) = -Int_0^1 s^(L-1) log^m(s)/(1-s) ds,
           valid for Re L > 0 on the contour  =>  the piece is P0 (psi-stripped) and P(s) (kinematic scale s^(L-1));
       (2) Gamma(g)/Gamma(d) with g-d = -n < 0  ->  1/Pochhammer(g, n) (rational); every affine denominator factor
           1/l^k -> Int_0^1 w^(l-1) (-log w)^(k-1)/(k-1)! dw on the contour-sign-correct branch  (aux powers);
       (3) variables are eliminated one at a time; a variable v whose legs form a (1,1) or (2,2) unit-slope pattern
           carries the scale Y = prod base^(coeff of v):
             (1,1): (1/2Pi i) Int G(a1+v)G(b1-v) Y^v dv = Y^b1 G(a1+b1) (1+Y)^(-(a1+b1))              [canonical contour]
             (2,2): (1/2Pi i) Int G(a1+v)G(a2+v)G(b1-v)G(b2-v) Y^v dv
                    = Y^b2 G(a)G(b)G(c-a)G(c-b)/G(c) 2F1(a,b;c;1-Y),  a=a1+b2, b=a2+b2, c=a1+a2+b1+b2,
                    and the Euler representation 2F1(al,be;c;1-Y) = G(c)/(G(be)G(c-be)) Int_0^1 u^(be-1)(1-u)^(c-be-1)
                    (1-u+uY)^(-al) du  (Re c > Re be > 0)  =>  new legs G(al) G(c-al), new kinematic powers;
           a non-canonical contour adds the residues of the crossed poles (right-family poles left of the contour: +Res;
           left-family poles right of it: -Res), simple poles only (fail-closed otherwise);
       (4) when no MB variable is left the integrand is an explicit Euler cube with multilinear letters, closed by
           IntVolFLINT (certificate mode first; the regularized mode only under an independent numeric agreement gate).
     Result: an exact MZV/gamma expression, or $Failed (fail-closed at every unmet hypothesis).

   PART B — MBEStrategy`mbeStdClose wrap: pieces with a multi-variable psi go to bwsClose first; otherwise the original
     dispatcher with permutation and single/double reflection retries (the EngineN order-sensitivity seen on 0142/0143).
     The sealed EngineDispatch block then serves the EXACT value after its own contour-oracle gate (folds 1-3).

   PART C — MBtoMPL`Private`mbtCachedMB2MPL wrap: when the sealed ladder has failed a multi-fold piece (it would be
     set to 0 and ledgered), run the exact engine ladder and serve only a value that (i) passes the exactness predicate
     and (ii) is reproduced EXACTLY by a second, structurally different construction (different elimination/variable
     order or a reflected form): method independence at the exact level.  A loose phase-stripped contour quadrature is
     attempted as an additional sanity check but is never a producer and never blocks when unavailable; the per-order
     exact benchmark assembly remains the final arbiter.  This is the only path for >= 4-fold pieces (the sealed block
     has no contour oracle there) and the safety net for 2/3-fold pieces whose oracle was too coarse.
   No float is ever served: every returned value passes bwsExactQ (no inexact numbers, no residual variables/heads). *)

Global`$bwsCounter = 0;
Global`$bwsIVFSeconds = 1200;
Global`$bwsVerbose = True;
bwsLog[a___] := If[TrueQ[Global`$bwsVerbose], WriteString["stdout", "    [BWS] " <> StringJoin[ToString /@ {a}] <> "\n"]];

bwsAffineQ[e_, vars_] := PolynomialQ[e, vars] && AllTrue[CoefficientRules[e, vars], Total[#[[1]]] <= 1 &];
bwsRe[e_, ctr_] := Quiet@Check[Re[N[e /. ctr, 30]], $Failed];
bwsFresh[pre_] := Symbol["Global`" <> pre <> ToString[++Global`$bwsCounter]];
(* 2026-09-05 19:00 (Lemma align, user: "make the second construction successful"): the cube variables minted while
   eliminating the MB variable v are named by ROLE = {v, kind, k} (k = the k-th variable of that kind minted for the
   term at that step), so that every term of one elimination order shares the same symbols and the terms can be SUMMED
   BEFORE INTEGRATION (dimension = the longest chain, not the number of terms times their dimensions).  A group that
   is log-divergent on its own (MB6 piece 0502, order {z35, z60}: the subset term of one Euler group diverges at its u
   variable, the partner group carries the cancelling divergence) is then closed as part of the aligned sum.  The
   registry is reset for every elimination order. *)
Global`$bwsRoleReg = <||>;
Global`$bwsExactFirstCandidate = None;   (* a two-construction agreement refused only by its quadratures (06:33) *)
bwsRole[v_, kind_String, k_Integer] := Module[{key = {v, kind, k}},
  If[! KeyExistsQ[Global`$bwsRoleReg, key], Global`$bwsRoleReg[key] = bwsFresh[kind]];
  Global`$bwsRoleReg[key]];
bwsVarSymbolQ[x_] := MatchQ[x, _Symbol] && StringStartsQ[SymbolName[x], "bws"];

(* 2026-09-05: canonical exact form for the agreement tests and the served values -- logarithms of positive numerics
   expanded (exact for positive arguments), Log 2 / Log 3 collected as polynomial placeholders, then Simplify.  Without
   it two equal values differing by "Log[2] Log[531441/64] - 6 Log[3] Log[4] + 6 Log[2]^2" (= 0) were logged as a
   DISAGREEMENT and piece 0055 was refused fail-closed. *)
(* 2026-09-05 18:40 (MB6 fresh audit run 2): the exact gate of the audit compared Simplify[served - benchmark] with 0
   and got "Pi^2 (94 Log[2]^2 - Log[4] Log[140737488355328]) + ..." -- Simplify's complexity measure prefers Log[2^47]
   to 47 Log[2], so it REWROTE a zero difference into a form it could not cancel; the served coefficient was exact and
   right (the prime-log expansion of the same difference is identically 0 at every order).  PowerExpand does nothing
   for an INTEGER argument (2^47 has already evaluated).  bwsPrimeLog is the exact identity Log q = Sum k_p Log p over
   the prime factorisation of a positive rational q; every exact comparison goes through it FIRST (Expand of a
   polynomial in the independent constants), Simplify only as the fallback. *)
bwsPrimeLog[e_] := e /. Log[q_ /; (IntegerQ[q] || Head[q] === Rational) && q > 0] :>
  Total[(#[[2]] Log[#[[1]]]) & /@ FactorInteger[q]];
bwsExactZeroQ[d_] := Module[{c},
  c = Quiet@TimeConstrained[Expand[bwsPrimeLog[d]], 120, $Failed];
  If[c === 0, True,
    c = Quiet@TimeConstrained[Simplify[Expand[bwsPrimeLog[d]] /. {Log[2] -> Global`l6LogTwo, Log[3] -> Global`l6LogThree}], 300, $Failed];
    c === 0]];
bwsCanonExact[e_] := Module[{f},
  f = bwsPrimeLog[e] /. Log[x_] /; NumericQ[x] && FreeQ[x, Complex] && TrueQ[Positive[x]] :> PowerExpand[Log[x]];
  f = Expand[f /. {Log[2] -> Global`l6LogTwo, Log[3] -> Global`l6LogThree}];
  If[f === 0, Return[0, Module]];
  Quiet@TimeConstrained[Simplify[f], 300, f] /. {Global`l6LogTwo -> Log[2], Global`l6LogThree -> Log[3]}];
bwsSameExactQ[a_, b_] := bwsExactZeroQ[a - b];

bwsExactQ[expr_, vrs_] :=
  expr =!= $Failed && expr =!= $TimedOut && expr =!= $Aborted &&
  FreeQ[expr, $Failed | $TimedOut | Indeterminate | ComplexInfinity | DirectedInfinity | _Integrate | _NIntegrate] &&
  FreeQ[expr, Alternatives @@ vrs] &&
  Cases[expr, q_?NumberQ /; Precision[Unevaluated[q]] =!= Infinity :> q, {0, Infinity}, Heads -> True] === {} &&
  Cases[expr, x_Symbol /; bwsVarSymbolQ[x] :> x, {0, Infinity}] === {} &&
  Cases[expr, h_Symbol[___] /; MemberQ[{"ZeroInfPeriod", "HyperInt", "Hlog", "delta", "Mpl", "mzv",
      "ivfExactCubeBoth"}, SymbolName[Unevaluated[h]]] :> h, {0, Infinity}, Heads -> False] === {} &&
  NumericQ[Quiet@N[expr]];

(* ---------- parse: constant, Gamma legs, denominator Gammas, polygammas, affine rational factors ---------- *)
bwsParse[ig_, vars_] := Module[{fac, const = 1, gam = {}, den = {}, psi = {}, rat = {}, poly = {}, bad = False},
  fac = If[Head[ig] === Times, List @@ ig, {ig}];
  Do[Which[
     FreeQ[f, Alternatives @@ vars], const *= f,
     MatchQ[f, Gamma[_]], AppendTo[gam, f[[1]]],
     MatchQ[f, Power[Gamma[_], _Integer?Positive]], gam = Join[gam, ConstantArray[f[[1, 1]], f[[2]]]],
     MatchQ[f, Power[Gamma[_], _Integer?Negative]], den = Join[den, ConstantArray[f[[1, 1]], -f[[2]]]],
     MatchQ[f, PolyGamma[_Integer, _]], AppendTo[psi, f],
     MatchQ[f, Power[PolyGamma[_Integer, _], _Integer?Positive]], Null,   (* psi^k: collected below *)
     MatchQ[f, Power[_, _Integer?Negative]] && PolynomialQ[f[[1]], vars],
       Do[If[NumericQ[q[[1]]], const *= q[[1]]^(f[[2]] q[[2]]),
          If[bwsAffineQ[q[[1]], vars], AppendTo[rat, {q[[1]], -f[[2]] q[[2]]}], bad = True]],
         {q, FactorList[f[[1]]]}],
     (* 2026-09-05 (pure-Gamma class, MB10 p57): POLYNOMIAL NUMERATORS with affine factors -- absorbed into Gamma
        legs by bwsAbsorbPoly at initialisation (Lemma polyabsorb: (q0 + c.z) Gamma(L) with grad L = +-c is a sum of
        two Gamma legs) *)
     PolynomialQ[f, vars],
       Do[If[NumericQ[q[[1]]], const *= q[[1]]^q[[2]],
          If[bwsAffineQ[q[[1]], vars], poly = Join[poly, ConstantArray[q[[1]], q[[2]]]], bad = True]],
         {q, FactorList[f]}],
     True, bad = True], {f, fac}];
  (* "psi" -> None = PURE mode (no polygamma; e.g. the rational remainder of a psi raise): the same recursion without
     the scale variable, the value being the cube itself.  2026-09-05 (MB6 difference-kernel family, class b): SEVERAL
     polygamma factors are allowed -- "psi" is then the LIST of factors (a power psi^k appears k times), each carrying
     its own scale variable (Lemma multipsi in the addendum). *)
  psi = Flatten[Table[Which[MatchQ[f, PolyGamma[_Integer, _]], f,
      MatchQ[f, Power[PolyGamma[_Integer, _], _Integer?Positive]], ConstantArray[f[[1]], f[[2]]], True, Nothing], {f, fac}]];
  If[bad, $Failed,
    <|"const" -> const, "gam" -> gam, "den" -> den, "psi" -> If[psi === {}, None, psi], "rat" -> rat,
      "poly" -> poly|>]];

(* ---------- same-slope denominator cancellation (Lemma sameorient, S1): Gamma(g)/Gamma(d), g-d integer ---------- *)
bwsCancelDen[p_, ctr_: {}] := Module[{gam = p["gam"], rat = p["rat"], beta = {}, poly = Lookup[p, "poly", {}], ok = True},
  Do[Module[{cands, g, n, pair},
     cands = Select[gam, IntegerQ[Simplify[# - d]] &];
     cands = SortBy[cands, Simplify[# - d] &];
     If[cands === {},
       (* 2026-09-05 (MB13 piece 60, slope-2 legs): an exact BETA TRIPLE Gamma(g1)Gamma(g2)/Gamma(g1+g2) with
          Re g1, Re g2 > 0 on the contour becomes Int_0^1 t^(g1-1) (1-t)^(g2-1) dt: two kinematic powers whose
          exponents may carry any integer slope (the elimination kernels take Y = prod base^coefficient) *)
       (* 2026-09-06 12:00 (MB8 phase-dropped piece 1648: Gamma(-z4)^3 Gamma(z4) Gamma(1+z4) Gamma(-1-z6)
          Gamma(-z6) Gamma(z6) Gamma(1+z6) Gamma(2+z6) / Gamma(z6 - z4), the cross-variable denominator matched by
          Gamma(-z4) Gamma(z6) with Re z6 = -0.41 < 0): the triple is taken with an INTEGER OFFSET k >= 0,
          Gamma(g1)Gamma(g2)/Gamma(d) with g1 + g2 = d + k, and a leg of non-positive real part is RAISED first,
          Gamma(g) = Gamma(g+m)/(g)_m (Lemma betapair): Gamma(g1)Gamma(g2)/Gamma(d)
            = B(g1+m1, g2+m2) (d)_(k+m1+m2) / [(g1)_m1 (g2)_m2],
          a Beta pair of positive real parts, a polynomial numerator (absorbed) and affine denominators (aux powers).
          Pairs with the smallest offset and no raise are preferred; a leg with Re = 0 on the contour is refused. *)
       pair = Module[{cs},
         cs = Select[Subsets[gam, {2}], ctr =!= {} && IntegerQ[Simplify[#[[1]] + #[[2]] - d]] && Simplify[#[[1]] + #[[2]] - d] >= 0 &&
             NumericQ[bwsRe[#[[1]], ctr]] && NumericQ[bwsRe[#[[2]], ctr]] && bwsRe[#[[1]], ctr] != 0 && bwsRe[#[[2]], ctr] != 0 &];
         cs = SortBy[cs, {Simplify[#[[1]] + #[[2]] - d], Max[0, Floor[-bwsRe[#[[1]], ctr]] + 1] + Max[0, Floor[-bwsRe[#[[2]], ctr]] + 1]} &];
         If[cs === {}, Missing[], First[cs]]];
       If[MissingQ[pair], ok = False,
         Module[{g1 = pair[[1]], g2 = pair[[2]], k, m1, m2},
           k = Simplify[g1 + g2 - d];
           m1 = Max[0, Floor[-bwsRe[g1, ctr]] + 1]; m2 = Max[0, Floor[-bwsRe[g2, ctr]] + 1];
           If[k + m1 + m2 > 0, bwsLog["Beta triple Gamma(", g1, ") Gamma(", g2, ") / Gamma(", d, "): offset ", k, ", raises ", {m1, m2}]];
           AppendTo[beta, {Expand[g1 + m1], Expand[g2 + m2]}];
           gam = DeleteCases[gam, g1, 1, 1]; gam = DeleteCases[gam, g2, 1, 1];
           Do[AppendTo[poly, Expand[d + j]], {j, 0, k + m1 + m2 - 1}];
           Do[AppendTo[rat, {Expand[g1 + j], 1}], {j, 0, m1 - 1}];
           Do[AppendTo[rat, {Expand[g2 + j], 1}], {j, 0, m2 - 1}]]],
       g = First[cands]; n = Simplify[g - d];
       If[n > 0,
         (* 2026-09-05: every candidate leg lies ABOVE the denominator, Gamma(d+n)/Gamma(d) = (d)_n, a polynomial
            numerator (absorbed by bwsAbsorbPoly); the closest candidate keeps the degree minimal *)
         gam = DeleteCases[gam, g, 1, 1];
         Do[AppendTo[poly, Expand[d + k]], {k, 0, n - 1}],
         gam = DeleteCases[gam, g, 1, 1];
         Do[AppendTo[rat, {g + k, 1}], {k, 0, -n - 1}]]]],
    {d, p["den"]}];
  If[ok, Join[p, <|"gam" -> gam, "den" -> {}, "rat" -> rat, "beta" -> beta, "poly" -> poly|>], $Failed]];

(* ---------- polynomial absorption (2026-09-05, Lemma polyabsorb) ----------
   An affine numerator factor q = q0 + c.z is absorbed into a numerator Gamma leg L = L0 + g.z of PARALLEL gradient:
     g = +c :  q Gamma(L) = Gamma(L+1) + (q0 - L0) Gamma(L)
     g = -c :  q Gamma(L) = -Gamma(L+1) + (q0 + L0) Gamma(L)
   (exact; one term when the constant vanishes).  A factor whose gradient is the SUM of two legs' gradients (with signs)
   is absorbed through both, q = s1 L1 + s2 L2 + delta -> three terms.  Fail-closed when no leg combination matches.
   Absorption order: the (factor, leg) pair with the smallest |constant| first, so exact absorptions come free. *)
bwsGrad[e_, vars_] := Coefficient[e, #] & /@ vars;
bwsAbsorbOne[term_, q_, vars_] := Module[{c = bwsGrad[q, vars], q0 = q /. Thread[vars -> 0], gam = term["gam"], opts = {}, L, L0, g, best, out},
  Do[L = gam[[i]]; g = bwsGrad[L, vars]; L0 = L /. Thread[vars -> 0];
     Which[g === c, AppendTo[opts, {Abs[N[q0 - L0]], i, 1, Expand[q0 - L0]}],
           g === -c, AppendTo[opts, {Abs[N[q0 + L0]], i, -1, Expand[q0 + L0]}]], {i, Length[gam]}];
  If[opts === {},
    (* two-leg combination: c = s1 g1 + s2 g2 *)
    Do[Module[{g1 = bwsGrad[gam[[i]], vars], g2 = bwsGrad[gam[[j]], vars], l1 = gam[[i]] /. Thread[vars -> 0], l2 = gam[[j]] /. Thread[vars -> 0]},
       Do[If[s1 g1 + s2 g2 === c, AppendTo[opts, {Abs[N[q0 - s1 l1 - s2 l2]], {i, j}, {s1, s2}, Expand[q0 - s1 l1 - s2 l2]}]],
         {s1, {1, -1}}, {s2, {1, -1}}]], {i, Length[gam]}, {j, i + 1, Length[gam]}];
    If[opts === {}, Return[$Failed]];
    best = First[SortBy[opts, First]];
    Module[{i = best[[2, 1]], j = best[[2, 2]], s1 = best[[3, 1]], s2 = best[[3, 2]], delta = best[[4]]},
      out = {Join[term, <|"c" -> s1 term["c"], "gam" -> ReplacePart[gam, i -> Expand[gam[[i]] + 1]]|>],
             Join[term, <|"c" -> s2 term["c"], "gam" -> ReplacePart[gam, j -> Expand[gam[[j]] + 1]]|>]};
      If[delta =!= 0, AppendTo[out, Join[term, <|"c" -> delta term["c"]|>]]];
      Return[out]]];
  best = First[SortBy[opts, First]];
  Module[{i = best[[2]], sgn = best[[3]], delta = best[[4]]},
    out = {Join[term, <|"c" -> sgn term["c"], "gam" -> ReplacePart[gam, i -> Expand[gam[[i]] + 1]]|>]};
    If[delta =!= 0, AppendTo[out, Join[term, <|"c" -> delta term["c"]|>]]];
    out]];
bwsAbsorbPoly[terms_, poly_, vars_] := Module[{ts = terms, rest = poly, pick, r, out},
  While[rest =!= {},
    (* the factor with the cheapest absorption in the first term decides the order *)
    pick = First[SortBy[rest, Function[q, Module[{o = bwsAbsorbOne[First[ts], q, vars]}, If[o === $Failed, Infinity, Length[o]]]]]];
    rest = DeleteCases[rest, pick, 1, 1];
    out = {};
    Do[r = bwsAbsorbOne[t, pick, vars]; If[r === $Failed, Return[$Failed, Module]]; out = Join[out, r], {t, ts}];
    ts = out];
  ts];

(* ---------- aux powers: one variable per group of rational factors sharing a linear direction ---------- *)
(* entries {{l_i, k_i}} with l_i = l0 + integer, all Re l_i of one sign on the contour:
   prod 1/l_i^k_i = Int_0^1 w^(sgn l0 - 1) P(w, log w) dw  by partial fractions in the formal variable t = l0. *)
bwsPFTerm[term_, t_] := Module[{num = Numerator[term], den = Denominator[term], fl, c = 1, kk = 0, j = 0, ok = True},
  If[! NumericQ[num], Return[$Failed]];
  fl = FactorList[den];
  Do[Which[NumericQ[f[[1]]], c = c/f[[1]]^f[[2]],
     PolynomialQ[f[[1]], t] && Exponent[f[[1]], t] === 1 && Coefficient[f[[1]], t] === 1, kk = f[[1]] /. t -> 0; j = f[[2]],
     True, ok = False], {f, fl}];
  If[! ok || j === 0, $Failed, {num c, kk, j}]];
bwsAuxGroup[entries_, ctr_] := Module[{l0, t, rat, parts, sgn, w, xf = 0, reals, pf},
  l0 = entries[[1, 1]];
  reals = bwsRe[#[[1]], ctr] & /@ entries;
  If[! AllTrue[reals, NumericQ] || MemberQ[reals, 0], Return[$Failed]];
  If[! (AllTrue[reals, # > 0 &] || AllTrue[reals, # < 0 &]), Return[$Failed]];
  sgn = If[reals[[1]] > 0, 1, -1];
  w = bwsFresh["bwsW"];
  rat = Times @@ ((t + Simplify[#[[1]] - l0])^(-#[[2]]) & /@ entries);
  parts = Apart[rat, t]; parts = If[Head[parts] === Plus, List @@ parts, {parts}];
  Do[pf = bwsPFTerm[term, t]; If[pf === $Failed, Return[$Failed]];
     xf += pf[[1]] If[sgn == 1, w^pf[[2]] (-Log[w])^(pf[[3]] - 1)/(pf[[3]] - 1)!,
                        (-1)^pf[[3]] w^(-pf[[2]]) (-Log[w])^(pf[[3]] - 1)/(pf[[3]] - 1)!], {term, parts}];
  {{w, sgn l0 - 1}, xf}];
bwsAuxSingle[entry_, ctr_] := Module[{l = entry[[1]], k = entry[[2]], w = bwsFresh["bwsW"], rl},
  rl = bwsRe[l, ctr];
  Which[! NumericQ[rl] || rl == 0, $Failed,
    rl > 0, {{w, l - 1}, (-Log[w])^(k - 1)/(k - 1)!},
    True, {{w, -l - 1}, (-1)^k (-Log[w])^(k - 1)/(k - 1)!}]];

(* ---------- initial term: psi representation + aux powers for the rationals ---------- *)
(* term = <|"c" -> constant, "gam" -> {affine legs}, "kin" -> {{base, affine exponent}...}, "xf" -> z-free factor|> *)
(* ss = the list of scale variables, one per polygamma factor (2026-09-05: several factors allowed) *)
bwsInit[p_, vars_, ctr_, ss_List] := Module[{kin = {}, xf = 1, groups, g, ok = True, psis},
  psis = If[p["psi"] === None, {}, p["psi"]];
  Do[With[{m = psis[[i, 1]], L = psis[[i, 2]], s = ss[[i]]},
     If[! bwsAffineQ[L, vars] || ! TrueQ[bwsRe[L, ctr] > 0], ok = False,
       AppendTo[kin, {s, L - 1}];
       If[m >= 1, xf *= -Log[s]^m/(1 - s)]]], {i, Length[psis]}];
  If[! ok, Return[$Failed]];
  (* Beta triples from bwsCancelDen: t^(g1-1) (1-t)^(g2-1) *)
  Do[With[{t = bwsFresh["bwsT"]}, AppendTo[kin, {t, pr[[1]] - 1}]; AppendTo[kin, {1 - t, pr[[2]] - 1}]],
    {pr, Lookup[p, "beta", {}]}];
  groups = GatherBy[p["rat"], Expand[#[[1]] - (#[[1]] /. Thread[vars -> 0])] &];
  Do[g = If[Length[grp] > 1, bwsAuxGroup[grp, ctr], $Failed];
     If[g =!= $Failed, AppendTo[kin, g[[1]]]; xf *= g[[2]],
       Do[g = bwsAuxSingle[e, ctr]; If[g === $Failed, Return[$Failed]];
          AppendTo[kin, g[[1]]]; xf *= g[[2]], {e, grp}]], {grp, groups}];
  (* polynomial numerator factors -> a sum of pure-Gamma terms (2026-09-05) *)
  bwsAbsorbPoly[{<|"c" -> p["const"], "gam" -> p["gam"], "kin" -> kin, "xf" -> xf|>}, Lookup[p, "poly", {}], vars]];

(* fold a variable-free Gamma leg into the constant; a leg at a non-positive integer is a pinch -> fail *)
bwsAddLeg[term_, leg_, vars_] :=
  If[FreeQ[leg, Alternatives @@ vars],
    If[IntegerQ[leg] && leg <= 0, $Failed, Join[term, <|"c" -> term["c"] Gamma[leg]|>]],
    Join[term, <|"gam" -> Append[term["gam"], leg]|>]];

bwsNonPosIntQ[e_] := Module[{x = Simplify[e]}, IntegerQ[x] && x <= 0];
(* replace the FIRST TOP-LEVEL occurrence of a leg (2026-09-05 fix: First[FirstPosition[list, leg]] matched the leg
   symbol INSIDE an already-shifted leg 1+z, so a leg needing two shifts -- the csc^2 kernel Gamma(z)^2 Gamma(-z)^2 of
   the class-C one-folds -- was never shifted twice and the elimination failed at the iteration cap) *)
bwsReplaceLeg[list_, leg_, new_] := Module[{pos = Position[list, leg, {1}, 1, Heads -> False]},
  If[pos === {}, list, ReplacePart[list, First[pos] -> new]]];
(* logs of the (positive) scale Y as sums of logs of its polynomial factors, for the cube integrator.  Y > 0 on the
   open cube (every base is positive there), but Factor may carry sign flips like (-1 + w) = -(1 - w): each factor's
   constant sign is read at an interior sample point and the product of signs must come out positive (else fail). *)
bwsSamplePoint[expr_] := Module[{ev = DeleteDuplicates[Cases[expr, x_Symbol /; bwsVarSymbolQ[x] :> x, {0, Infinity}]]},
  Thread[ev -> Table[Prime[k + 3]/(Prime[k + 3] + Prime[k + 9]), {k, Length[ev]}]]];
bwsExpandLogs[expr_] := expr /. Log[a_] :> Module[{fl = FactorList[Together[a]], res = 0, sgn = 1, pt, val},
   pt = bwsSamplePoint[a];
   Do[Module[{f = fac[[1]], e = fac[[2]]},
      val = If[NumericQ[f], f, f /. pt];
      If[! NumericQ[val] || val == 0, Throw[$Failed, "bwsE"]];
      If[val < 0, sgn *= (-1)^e; res += e Log[-f], res += e Log[f]]], {fac, fl}];
   If[sgn =!= 1, Throw[$Failed, "bwsE"]];
   res];

(* ---------- eliminate one MB variable from one term ---------- *)
(* (2,2) Euler admissibility (top-level copies of the eulerShift closures, used by the pairing fallback) *)
bwsAdmQ[aa_, bb_, ctr_] := Module[{rc = bwsRe[Expand[Total[aa] + Total[bb]], ctr]},
  AnyTrue[Flatten[Outer[Plus, aa, bb]], Function[be, With[{rb = bwsRe[be, ctr]}, NumericQ[rb] && NumericQ[rc] && rb > 0 && rc - rb > 0]]]];
bwsElemQ[aa_, bb_] := Module[{cc = Expand[Total[aa] + Total[bb]]},
  AnyTrue[bb, Function[b2, IntegerQ[Expand[aa[[1]] + b2]] && IntegerQ[Expand[aa[[2]] + b2]] && IntegerQ[cc] &&
    Expand[aa[[1]] + b2] > 0 && Expand[aa[[2]] + b2] > 0 && cc > 0]]];

bwsEliminate[term_, v_, ctr_, vars_] := Catch[Module[
  {gam = term["gam"], kin = term["kin"], xf = term["xf"], cc = term["c"], plus, minus, other, Y, kinRest, cv, out = {}, base, t,
   iter = 0, degQ, lm, wsh, multShift, eulerShift, pairOnce, cnt = <||>, mint},
  If[FreeQ[{gam, kin[[All, 2]]}, v], Throw[{term}, "bwsE"]];
  (* role-aligned minting (Lemma align): the k-th variable of a kind minted for this term at this step *)
  mint[kind_] := (cnt[kind] = Lookup[cnt, kind, 0] + 1; bwsRole[v, kind, cnt[kind]]);
  plus = Select[gam, Coefficient[#, v] === 1 &];
  minus = Select[gam, Coefficient[#, v] === -1 &];
  other = Select[gam, FreeQ[#, v] &];
  If[Length[plus] + Length[minus] + Length[other] =!= Length[gam], Throw[$Failed, "bwsE"]];
  (* balanced (n,n) kernels only; n >= 3 is Beta-paired down to (2,2) below (2026-09-05, Lemma betapair) *)
  If[Length[plus] =!= Length[minus] || Length[plus] === 0, Throw[$Failed, "bwsE"]];
  cv = bwsRe[v, ctr]; If[! NumericQ[cv], Throw[$Failed, "bwsE"]];
  (* Beta pairing of one plus-leg with one minus-leg (Lemma betapair):
       Gamma(a+v) Gamma(b-v) = Gamma(a+b) Int_0^1 t^(a+v-1) (1-t)^(b-v-1) dt   (Re(a+v) > 0, Re(b-v) > 0 on the contour),
     the two kinematic powers carrying the scale t/(1-t); a leg of non-positive real part is first shifted,
     Gamma(L) = Gamma(L+1)/L (aux power).  A pair whose sum is a non-positive integer (pinch) is never paired; a sum
     free of the MB variables is a constant Gamma, otherwise a leg of the remaining variables. *)
  pairOnce := Module[{pairs, rank, best, a, b, w, tt, ab},
    If[plus === {} || minus === {}, Return[False]];
    pairs = Select[Tuples[{plus, minus}], ! bwsNonPosIntQ[Expand[#[[1]] + #[[2]]]] &];
    If[pairs === {}, Return[False]];
    rank[{a1_, b1_}] := Module[{s = Expand[a1 + b1], ra = bwsRe[a1, ctr], rb = bwsRe[b1, ctr]},
      {If[FreeQ[s, Alternatives @@ vars], 0, 1],
       If[NumericQ[ra] && NumericQ[rb] && ra != 0 && rb != 0, Max[0, Floor[-ra] + 1] + Max[0, Floor[-rb] + 1], Infinity]}];
    best = First[SortBy[pairs, rank]]; If[rank[best][[2]] === Infinity, Return[False]];
    {a, b} = best;
    While[TrueQ[bwsRe[a, ctr] < 0], w = mint["bwsW"]; AppendTo[kin, {w, -a - 1}]; xf *= -1;
      plus = bwsReplaceLeg[plus, a, Expand[a + 1]]; a = Expand[a + 1]];
    While[TrueQ[bwsRe[b, ctr] < 0], w = mint["bwsW"]; AppendTo[kin, {w, -b - 1}]; xf *= -1;
      minus = bwsReplaceLeg[minus, b, Expand[b + 1]]; b = Expand[b + 1]];
    If[! TrueQ[bwsRe[a, ctr] > 0] || ! TrueQ[bwsRe[b, ctr] > 0], Return[False]];
    tt = mint["bwsT"];
    AppendTo[kin, {tt, Expand[a - 1]}]; AppendTo[kin, {1 - tt, Expand[b - 1]}];
    plus = DeleteCases[plus, a, 1, 1]; minus = DeleteCases[minus, b, 1, 1];
    ab = Expand[a + b];
    If[FreeQ[ab, Alternatives @@ vars],
      If[IntegerQ[ab] && ab <= 0, Return[False]]; cc *= Gamma[ab],
      AppendTo[other, ab]];
    bwsLog["Beta-paired Gamma(", a, ") Gamma(", b, ") in ", v, " -> (", Length[plus], ",", Length[minus], ")"];
    True];
  (* degenerate pairings (a_i + b_j a non-positive integer: no separating contour) are removed by shifting a leg of
     non-positive real part on the contour, Gamma(L) = Gamma(L+1)/L, the rational going to its own aux power
     (Thm shift-terminates, applied only where needed so that the cube dimension stays minimal) *)
  degQ := AnyTrue[Flatten[Outer[Plus, plus /. v -> 0, minus /. v -> 0]], bwsNonPosIntQ];
  While[degQ && iter < 8, iter++;
    lm = SelectFirst[Join[plus, minus], TrueQ[bwsRe[#, ctr] <= 0] &, Missing[]];
    If[MissingQ[lm] || TrueQ[bwsRe[lm, ctr] == 0], Throw[$Failed, "bwsE"]];
    wsh = mint["bwsW"];
    AppendTo[kin, {wsh, -lm - 1}]; xf *= -1;                 (* 1/L, Re L < 0: -Int w^(-L-1) dw *)
    (* shift ONE occurrence (legs can coincide, e.g. Gamma(B)^2) *)
    If[MemberQ[plus, lm], plus = bwsReplaceLeg[plus, lm, Expand[lm + 1]],
      minus = bwsReplaceLeg[minus, lm, Expand[lm + 1]]]];
  If[degQ, Throw[$Failed, "bwsE"]];
  (* (n,n) with n >= 3: Beta-pair down to (2,2) *)
  iter = 0; While[Length[plus] >= 3 && iter < 8 && pairOnce, iter++];
  If[! MemberQ[{{1, 1}, {2, 2}}, {Length[plus], Length[minus]}], Throw[$Failed, "bwsE"]];
  If[degQ, Throw[$Failed, "bwsE"]];
  (* multiple crossing poles (2026-09-05, MB13 piece 58: Gamma(B)^2 with the contour right of B = 0).  A pole that
     must be crossed and at which a SECOND leg of the same family is singular is a multiple pole; its residue would
     carry derivatives (polygammas of the other legs) which this recursion cannot continue with.  Shift the partner
     leg instead, Gamma(L) = Gamma(L+1)/L, the rational going to an aux power (either sign of Re L on the contour),
     until every crossing pole is simple; then re-check the pairing degeneracy. *)
  multShift := Module[{found = False, as2 = Expand[# /. v -> 0] & /@ plus, bs2 = Expand[# /. v -> 0] & /@ minus,
      ras2, rbs2, lm2 = None, rl2, w2},
    ras2 = bwsRe[#, ctr] & /@ as2; rbs2 = bwsRe[#, ctr] & /@ bs2;
    If[! AllTrue[Join[ras2, rbs2], NumericQ], Throw[$Failed, "bwsE"]];
    Do[Module[{n = 0}, While[! found && -ras2[[i]] - n > cv && n < 40,
        Do[If[! found && l =!= i && bwsNonPosIntQ[as2[[l]] - as2[[i]] - n], found = True; lm2 = plus[[l]]],
          {l, Length[as2]}]; n++]], {i, Length[as2]}];
    Do[Module[{n = 0}, While[! found && rbs2[[j]] + n < cv && n < 40,
        Do[If[! found && k =!= j && bwsNonPosIntQ[bs2[[k]] - bs2[[j]] - n], found = True; lm2 = minus[[k]]],
          {k, Length[bs2]}]; n++]], {j, Length[bs2]}];
    If[! found, False,
      rl2 = bwsRe[lm2, ctr]; If[! NumericQ[rl2] || rl2 == 0, Throw[$Failed, "bwsE"]];
      w2 = mint["bwsW"];
      If[rl2 > 0, AppendTo[kin, {w2, lm2 - 1}], AppendTo[kin, {w2, -lm2 - 1}]; xf *= -1];
      If[MemberQ[plus, lm2], plus = bwsReplaceLeg[plus, lm2, Expand[lm2 + 1]],
        minus = bwsReplaceLeg[minus, lm2, Expand[lm2 + 1]]];
      True]];
  iter = 0; While[multShift && iter < 8, iter++];
  If[degQ, Throw[$Failed, "bwsE"]];
  (* Euler admissibility (2026-09-05, MB13 piece 60): in the (2,2) case with non-integer parameters the Euler
     representation needs a choice beta in {a_i + b_j} with 0 < Re beta < Re c.  If none exists, shift one leg,
     Gamma(L) = Gamma(L+1)/L (aux power of the correct branch), choosing the leg whose shift makes a choice
     admissible; at most a few times. *)
  eulerShift := Module[{as3 = Expand[# /. v -> 0] & /@ plus, bs3 = Expand[# /. v -> 0] & /@ minus, c3, admQ, elemQ, legs, pick = None, rl3, w3},
    If[Length[plus] =!= 2, Return[False]];
    admQ[aa_, bb_] := Module[{cc = Expand[Total[aa] + Total[bb]], rc = bwsRe[Expand[Total[aa] + Total[bb]], ctr]},
      AnyTrue[Flatten[Outer[Plus, aa, bb]], Function[be, With[{rb = bwsRe[be, ctr]}, NumericQ[rb] && NumericQ[rc] && rb > 0 && rc - rb > 0]]]];
    elemQ[aa_, bb_] := Module[{cc = Expand[Total[aa] + Total[bb]]},
      AnyTrue[bb, Function[b2, IntegerQ[Expand[aa[[1]] + b2]] && IntegerQ[Expand[aa[[2]] + b2]] && IntegerQ[cc] &&
        Expand[aa[[1]] + b2] > 0 && Expand[aa[[2]] + b2] > 0 && cc > 0]]];
    If[admQ[as3, bs3] || elemQ[as3, bs3], Return[False]];
    legs = Join[plus, minus];
    Do[Module[{aa = as3, bb = bs3},
       If[i <= 2, aa[[i]] = aa[[i]] + 1, bb[[i - 2]] = bb[[i - 2]] + 1];
       If[pick === None && (admQ[aa, bb] || elemQ[aa, bb]) && NumericQ[bwsRe[legs[[i]], ctr]] && bwsRe[legs[[i]], ctr] != 0,
         pick = i]], {i, 4}];
    If[pick === None, Return[False]];
    rl3 = bwsRe[legs[[pick]], ctr]; w3 = mint["bwsW"];
    If[rl3 > 0, AppendTo[kin, {w3, legs[[pick]] - 1}], AppendTo[kin, {w3, -legs[[pick]] - 1}]; xf *= -1];
    If[pick <= 2, plus = ReplacePart[plus, pick -> Expand[legs[[pick]] + 1]],
      minus = ReplacePart[minus, pick - 2 -> Expand[legs[[pick]] + 1]]];
    True];
  iter = 0; While[eulerShift && iter < 4, iter++];
  If[degQ, Throw[$Failed, "bwsE"]];
  (* (2,2) kernel without an admissible Euler representation (no beta with 0 < Re beta < Re c after the single
     shifts above, no elementary integer case): Beta-pair one leg pair and use the (1,1) kernel, which needs no
     admissibility (2026-09-05, MB10 p57: as = {0,0}, bs = {3, -2-z4}, c = 1-z4) *)
  If[Length[plus] === 2 && Module[{as0 = Expand[# /. v -> 0] & /@ plus, bs0 = Expand[# /. v -> 0] & /@ minus},
       ! (bwsAdmQ[as0, bs0, ctr] || bwsElemQ[as0, bs0])],
    bwsLog["(2,2) kernel in ", v, " has no admissible Euler representation: Beta-pairing one pair -> (1,1)"];
    If[! pairOnce, Throw[$Failed, "bwsE"]];
    If[degQ, Throw[$Failed, "bwsE"]]];
  Y = Together[Times @@ (#[[1]]^Coefficient[#[[2]], v] & /@ kin)];
  kinRest = {#[[1]], Expand[#[[2]] /. v -> 0]} & /@ kin;
  base = Join[term, <|"c" -> cc, "gam" -> other, "kin" -> kinRest, "xf" -> xf|>];
  If[Length[plus] === 1,
    (* ----- (1,1) ----- *)
    Module[{a1 = Expand[plus[[1]] /. v -> 0], b1 = Expand[minus[[1]] /. v -> 0], ra, rb, n},
      ra = bwsRe[a1, ctr]; rb = bwsRe[b1, ctr];
      If[! NumericQ[ra] || ! NumericQ[rb], Throw[$Failed, "bwsE"]];
      t = bwsAddLeg[Join[base, <|"kin" -> Join[kinRest, {{Y, b1}, {Together[1 + Y], -(a1 + b1)}}]|>], a1 + b1, vars];
      If[t === $Failed, Throw[$Failed, "bwsE"]]; AppendTo[out, t];
      (* crossings *)
      n = 0; While[rb + n < cv && n < 40,
        t = bwsAddLeg[Join[base, <|"c" -> base["c"] (-(-1)^n/n!), "kin" -> Append[kinRest, {Y, b1 + n}]|>], a1 + b1 + n, vars];
        If[t === $Failed, Throw[$Failed, "bwsE"]]; AppendTo[out, t]; n++];
      n = 0; While[-ra - n > cv && n < 40,
        t = bwsAddLeg[Join[base, <|"c" -> -base["c"] ((-1)^n/n!), "kin" -> Append[kinRest, {Y, -a1 - n}]|>], a1 + b1 + n, vars];
        If[t === $Failed, Throw[$Failed, "bwsE"]]; AppendTo[out, t]; n++]],
    (* ----- (2,2) ----- *)
    Module[{as = Expand[# /. v -> 0] & /@ plus, bs = Expand[# /. v -> 0] & /@ minus, c, choice = $Failed, u, n, ras, rbs,
            elem = $Failed},
      c = Expand[Total[as] + Total[bs]];
      ras = bwsRe[#, ctr] & /@ as; rbs = bwsRe[#, ctr] & /@ bs;
      If[! AllTrue[Join[ras, rbs], NumericQ], Throw[$Failed, "bwsE"]];
      (* elementary case: integer 2F1 parameters -> rational/log closed form, no Euler variable *)
      Do[Module[{b2 = bs[[jb]], a = Expand[as[[1]] + bs[[jb]]], b = Expand[as[[2]] + bs[[jb]]]},
         If[elem === $Failed && IntegerQ[a] && IntegerQ[b] && IntegerQ[c] && a > 0 && b > 0 && c > 0,
           elem = {b2, Gamma[a] Gamma[b] Gamma[c - a] Gamma[c - b]/Gamma[c],
                   bwsExpandLogs[FunctionExpand[Hypergeometric2F1[a, b, c, 1 - Y]]]}]], {jb, 2}];
      If[elem =!= $Failed,
        t = Join[base, <|"c" -> base["c"] elem[[2]], "kin" -> Append[kinRest, {Y, elem[[1]]}], "xf" -> xf elem[[3]]|>];
        AppendTo[out, t],
        (* Euler representation: shift b2 in {bs}, be in {a1+b2, a2+b2}, need Re c > Re be > 0.  Among the
           admissible choices prefer one whose new legs Gamma(al) Gamma(c-al) create NO degenerate pairing for the
           remaining variables (a pinch there would force a shift and an extra cube dimension). *)
        Module[{adm = {}},
          Do[Module[{b2 = bs[[jb]], be = as[[ia]] + bs[[jb]], al, rb, rc, newLegs, deg},
             al = Expand[as[[3 - ia]] + bs[[jb]]];
             rb = bwsRe[be, ctr]; rc = bwsRe[c, ctr];
             If[NumericQ[rb] && NumericQ[rc] && rb > 0 && rc - rb > 0,
               newLegs = Join[other, Select[{al, Expand[c - al]}, ! FreeQ[#, Alternatives @@ vars] &]];
               deg = Count[DeleteCases[vars, v], vv_ /; Module[{pl, mn},
                   pl = Select[newLegs, Coefficient[#, vv] === 1 &]; mn = Select[newLegs, Coefficient[#, vv] === -1 &];
                   AnyTrue[Flatten[Outer[Plus, pl /. vv -> 0, mn /. vv -> 0]], bwsNonPosIntQ]]];
               (* 2026-09-05 (MB13 piece 58/54): PREFER an Euler choice whose factor (1-u+uY)^(-al) has an exponent al
                  FREE of the remaining variables.  Otherwise the next variable's scale Y' contains (1-u+uY) with Y
                  itself carrying the scale s, so Y' is QUADRATIC in s: the cube letters acquire 1-s+s^2 (sixth roots
                  of unity), HyperFLINT leaves level-6 polylogarithms (or takes its degree-2 path).  With al free of
                  the other variables every later letter stays linear in s. *)
               AppendTo[adm, {{If[FreeQ[al, Alternatives @@ DeleteCases[vars, v]], 0, 1], deg}, {b2, be, al}}]]],
            {jb, 2}, {ia, 2}];
          If[adm =!= {}, choice = First[SortBy[adm, First]][[2]]]];
        If[choice === $Failed, Throw[$Failed, "bwsE"]];
        u = mint["bwsU"];
        t = Join[base, <|"kin" -> Join[kinRest, {{Y, choice[[1]]}, {u, choice[[2]] - 1}, {1 - u, c - choice[[2]] - 1},
                         {Together[1 - u + u Y], -choice[[3]]}}]|>];
        t = bwsAddLeg[t, choice[[3]], vars]; If[t === $Failed, Throw[$Failed, "bwsE"]];
        t = bwsAddLeg[t, Expand[c - choice[[3]]], vars]; If[t === $Failed, Throw[$Failed, "bwsE"]];
        AppendTo[out, t]];
      (* crossings: right-family poles v = b_j + n left of the contour (+Res), left-family v = -a_i - n right of it (-Res);
         simple poles only: the partner leg of the same family must not sit at a non-positive integer *)
      Do[n = 0; While[rbs[[j]] + n < cv && n < 40,
         Module[{bk = bs[[3 - j]], bj = bs[[j]], tt},
           If[bwsNonPosIntQ[bk - bj - n], Throw[$Failed, "bwsE"]];
           tt = Join[base, <|"c" -> base["c"] (-(-1)^n/n!), "kin" -> Append[kinRest, {Y, bj + n}]|>];
           tt = bwsAddLeg[tt, Expand[as[[1]] + bj + n], vars]; If[tt === $Failed, Throw[$Failed, "bwsE"]];
           tt = bwsAddLeg[tt, Expand[as[[2]] + bj + n], vars]; If[tt === $Failed, Throw[$Failed, "bwsE"]];
           tt = bwsAddLeg[tt, Expand[bk - bj - n], vars]; If[tt === $Failed, Throw[$Failed, "bwsE"]];
           AppendTo[out, tt]]; n++], {j, 2}];
      Do[n = 0; While[-ras[[i]] - n > cv && n < 40,
         Module[{al = as[[3 - i]], ai = as[[i]], tt},
           If[bwsNonPosIntQ[al - ai - n], Throw[$Failed, "bwsE"]];
           tt = Join[base, <|"c" -> -base["c"] ((-1)^n/n!), "kin" -> Append[kinRest, {Y, -ai - n}]|>];
           tt = bwsAddLeg[tt, Expand[al - ai - n], vars]; If[tt === $Failed, Throw[$Failed, "bwsE"]];
           tt = bwsAddLeg[tt, Expand[bs[[1]] + ai + n], vars]; If[tt === $Failed, Throw[$Failed, "bwsE"]];
           tt = bwsAddLeg[tt, Expand[bs[[2]] + ai + n], vars]; If[tt === $Failed, Throw[$Failed, "bwsE"]];
           AppendTo[out, tt]]; n++], {i, 2}]]];
  out], "bwsE"];

bwsEliminateVar[terms_, v_, ctr_, vars_] := Catch[Module[{out = {}, r},
  Do[r = bwsEliminate[t, v, ctr, vars]; If[r === $Failed, Throw[$Failed, "bwsEV"]]; out = Join[out, r], {t, terms}];
  out], "bwsEV"];

(* depth-first over elimination orders; "FirstVar" forces the first variable (used for the second construction) *)
bwsEliminateAll[terms_, vars_, ctr_, order_] := Catch[Module[{res, cand},
  If[vars === {}, Throw[terms, "bwsEA"]];
  cand = If[order === {}, vars, Join[Select[order, MemberQ[vars, #] &], DeleteCases[vars, Alternatives @@ order]]];
  Do[res = Quiet@Check[bwsEliminateVar[terms, v, ctr, vars], $Failed];
     If[res =!= $Failed,
       res = bwsEliminateAll[res, DeleteCases[vars, v], ctr, DeleteCases[order, v]];
       If[res =!= $Failed, Global`$bwsLastOrder = Prepend[Global`$bwsLastOrder, v]; Throw[res, "bwsEA"]]],
    {v, cand}];
  $Failed], "bwsEA"];

bwsTermExpr[t_] := Module[{k = t["kin"], legs = t["gam"]},
  If[legs =!= {} || ! AllTrue[k[[All, 2]], IntegerQ], Return[$Failed]];
  t["c"] t["xf"] Times @@ (#[[1]]^#[[2]] & /@ k)];

(* ---------- IVF closure with the certificate first, regularized only under an independent numeric gate ---------- *)
(* the cube variables in which some denominator factor is quadratic with a non-square discriminant *)
bwsQuadVars[f_, evars_] := Module[{fl = FactorList[Denominator[Together[f]]][[All, 1]]},
  DeleteDuplicates[Flatten[Table[Select[evars, PolynomialQ[q, #] && Exponent[q, #] >= 2 &&
      (Exponent[q, #] >= 3 || ! bwsPerfectSquareQ[Discriminant[q, #], evars]) &], {q, fl}]]]];
(* ONE fixed-order Unit-chart request (no chart race): the variable lastVar is integrated LAST, so a factor quadratic
   in it is never a letter of an integration variable (HyperFLINT's degree-2 path cannot fire) and shows up only as a
   constant letter at the end.  The raw words are kept in $bwsLastRaw for the level-6 reduction. *)
bwsIVFSingleOrder[f_, evars_, lastVar_, tmo_, reg_] := Module[{fr, vars, fN, pos, ord, reqs, pr, val},
  {fr, vars} = Global`renameVarsHF[f, evars];
  (* lastVar: a variable (put last) or a full order (a list of the cube variables) *)
  ord = If[ListQ[lastVar], lastVar /. Thread[evars -> vars],
    pos = Position[evars, lastVar][[1, 1]]; Append[Delete[vars, pos], vars[[pos]]]];
  fN = Global`ivfPolyLogToHlog[fr /. Global`constToHF];
  reqs = {{{"Unit", ord}, Global`jsonStr[Global`ivfNativeRequest[fN, vars, ord, ! reg, {}]]}};
  pr = Quiet@CheckAbort[Global`ivfRaceRequests[reqs, tmo, Global`$ivfBin,
      "env OMP_NUM_THREADS=" <> ToString[Global`$ivfChartThreads] <> " "], $Failed];
  If[! (AssociationQ[pr] && TrueQ[pr["ok"]]), Global`$ivfLastRefusals = If[AssociationQ[pr], Lookup[pr, "refusals", pr], pr];
    bwsLog["single-order request (", ord, ", ", If[reg, "regularized", "certificate"], ") refused: ",
      StringTake[ToString[Global`$ivfLastRefusals, InputForm], UpTo[600]]];
    Return[$Failed]];
  Global`$bwsLastRaw = pr["val"];
  val = Global`gvExact[pr["val"]];
  If[FreeQ[val, _Real] && NumericQ[Quiet@Global`ivfNumericCheck[pr["val"], {}]], val, $Failed]];
(* weight-1 leftovers of gvExact: PolyLogTools keeps G[0,2] and G[a,z] symbolic for numeric letters *)
(* HoldPattern: a rule LHS with PolyLogTools`G evaluates under PLT's own G rules (the evaluating-pattern trap) *)
bwsGClean[e_] := Simplify[e /. {HoldPattern[PolyLogTools`G[0, x_?NumericQ]] :> Log[x],
   HoldPattern[PolyLogTools`G[a_?NumericQ, x_?NumericQ]] /; a =!= 0 :> Log[1 - x/a]}];
(* the orders to try: quadratic-denominator variables LAST (their quadratics then only appear as constant letters at
   the end and HyperFLINT's degree-2 path never fires), the given order and its reverse first, then permutations *)
(* 2026-09-05 20:45 (speed of the second construction, user: "figure out why it is slow ... keeping the honesty"):
   the cube variables are minted along the elimination chain (the scale s first, then the initial aux/Beta variables,
   then one step per eliminated MB variable), and a variable minted LATER appears with the earlier ones inside its
   letters (the scale Y accumulates).  Integrating the innermost (last-minted) variable FIRST keeps every letter linear
   in the integration variable; the opposite order was refused or timed out (p57: the Beta variable first ran into
   the 1200 s budget; 0502: the scale first was refused) while its reverse closed.  bwsChainOrder = descending mint
   index (innermost first, the scales last); it leads the race below. *)
bwsVarIndex[x_Symbol] := Module[{s = StringDrop[SymbolName[x], 4]}, If[StringMatchQ[s, DigitCharacter ..], ToExpression[s], 0]];
bwsChainOrder[evars_] := Reverse[SortBy[evars, bwsVarIndex]];
bwsOrderCandidates[fT_, evars_] := Module[{qv = Quiet@bwsQuadVars[fT, evars], base, perms, chain, chainQ},
  If[! ListQ[qv], qv = {}];
  base = DeleteCases[evars, Alternatives @@ qv];
  chain = bwsChainOrder[evars];
  chainQ = Join[DeleteCases[chain, Alternatives @@ qv], Select[chain, MemberQ[qv, #] &]];   (* quadratic variables last, chain order inside *)
  (* every quadratic variable AFTER every linear one, in any internal order (MB13 piece 60: the two quadratic
     variables t and u must come as (u, t), not (t, u)) *)
  perms = DeleteDuplicates[Join[{chainQ, Join[base, qv], Join[Reverse[base], qv], Join[base, Reverse[qv]], Join[Reverse[base], Reverse[qv]]},
     If[Length[evars] <= 5, Flatten[Outer[Join, Permutations[base], Permutations[qv], 1], 1], {}]]];
  perms];
(* certificate-mode closure: ONE fixed-order Unit-chart request per order (no chart race: the projective chart of the
   race returned a wrong certified value on MB13 piece 59; the single Unit request keeps every letter linear in its
   integration variable).  Level-6 (sixth-root-of-unity) leftovers are reduced by bwsL6Reduce when it is loaded. *)
(* 2026-09-05 20:45: a RACE of several fixed-order Unit-chart certificate requests (all the same semantics: no
   regularization, refuse on divergence; the first clean finisher wins) instead of trying the orders one after the
   other -- a bad order no longer serialises its full budget in front of a good one.  The race machinery is the
   package's own (ivfRaceRequests: one process per request, first success wins, refusals collected with their
   "divergent" flag; the wrong value of 2026-09-05 came from the PROJECTIVE chart, which is not used here). *)
bwsIVFRace[f_, evars_, ords_, tmo_, reg_] := Module[{fr, vars, fN, reqs, pr, val, ordsR},
  {fr, vars} = Global`renameVarsHF[f, evars];
  ordsR = (# /. Thread[evars -> vars]) & /@ ords;
  fN = Global`ivfPolyLogToHlog[fr /. Global`constToHF];
  reqs = {{"Unit", #}, Global`jsonStr[Global`ivfNativeRequest[fN, vars, #, ! reg, {}]]} & /@ ordsR;
  (* a fixed THREAD BUDGET per race ($bwsRaceThreads, default 8) shared by the lanes: a race of 4 runs 2 threads per
     lane (the package default), a race of 2 -- the large aligned cubes have only two distinct candidate orders --
     runs 4 per lane, so the machine's cores are used where the work is (20:50) *)
  pr = Quiet@CheckAbort[Global`ivfRaceRequests[reqs, tmo, Global`$ivfBin,
      "env OMP_NUM_THREADS=" <> ToString[Max[Global`$ivfChartThreads, Floor[Global`$bwsRaceThreads/Max[1, Length[ords]]]]] <> " "], $Failed];
  Global`$bwsLastDivergent = AssociationQ[pr] && ! TrueQ[pr["ok"]] && TrueQ[pr["divergent"]];
  If[! (AssociationQ[pr] && TrueQ[pr["ok"]]), Global`$ivfLastRefusals = If[AssociationQ[pr], Lookup[pr, "refusals", pr], pr];
    bwsLog["race of ", Length[ords], " order(s) (", If[reg, "regularized", "certificate"], ") refused",
      If[TrueQ[Global`$bwsLastDivergent], " (divergence detected)", ""], ": ",
      StringTake[ToString[Global`$ivfLastRefusals, InputForm], UpTo[400]]];
    Return[$Failed]];
  Global`$bwsLastWinnerOrder = Quiet@Check[Last[pr["Order"]] /. Thread[vars -> evars], pr["Order"]];
  Global`$bwsLastRaw = pr["val"];
  val = Global`gvExact[pr["val"]];
  If[FreeQ[val, _Real] && NumericQ[Quiet@Global`ivfNumericCheck[pr["val"], {}]], val, $Failed]];
Global`$bwsRaceOrders = 4;   (* lanes per race: chain order (quadratics last), the given order, its reverse, one more *)
Global`$bwsRaceThreads = 0;  (* OMP threads per race shared by its lanes; 0 = the package default per lane.  MEASURED
   21:00 on 0502: 4 threads per lane in a 2-lane race gave 131 s / 418 s, identical to 2 threads -> the symbolic
   integration does not use them; the knob is kept at 0 so that no cores are wasted *)
(* 2026-09-06 07:52 (MB8b 0618, a raised 4-fold): the S cubes of a 4-fold are 8-dimensional aligned sums and every
   certificate request of them hit the 1200 s budget with an EMPTY refusal (a timeout, not a refusal), five orders in
   a row.  The budget now grows with the dimension: x1 up to 6 variables, x2 at 7, x3 at 8, ... (a performance knob;
   the semantics of the request are unchanged). *)
bwsIVFBudget[tmo_, evars_] := tmo Max[1, Length[evars] - 5];
(* 2026-09-06 09:50 (MB8b 0618 reduced two-fold): the value of a cube integrand at a scale s = 1 is taken as a LIMIT
   when the plain substitution is Indeterminate.  The cube carried the factor s log s/(s-1), which is regular at s = 1
   (limit 1) but evaluates to 0 * ComplexInfinity under substitution, so the pure part P0 = F(s=1) was refused and the
   whole closure with it.  The limit exists whenever the psi representation does (the cube of P(s) tends to that of
   P0 pointwise); if Mathematica cannot find it the cube is refused and dumped for inspection. *)
bwsIndetQ[e_] := ! FreeQ[e, Indeterminate | ComplexInfinity | _DirectedInfinity | _Limit];
bwsAtOne[F_, ss_List] := Fold[If[#1 === $Failed, $Failed, bwsAtOne[#1, #2]] &, F, ss];
bwsAtOne[F_, s_] := Module[{F1 = Quiet[F /. s -> 1], L},
  If[! bwsIndetQ[F1], F1,
    L = Quiet@TimeConstrained[Limit[F, s -> 1], 300, $Failed];
    If[L === $Failed || bwsIndetQ[L],
      Global`$bwsIndetDump = FileNameJoin[{$TemporaryDirectory, "bws_P0_indet_" <> ToString[$ProcessID] <> ".m"}];
      bwsLog["the ", s, " -> 1 value of a cube integrand is Indeterminate and its limit was not found -> refused, dumped to ", Global`$bwsIndetDump];
      Put[{F, s}, Global`$bwsIndetDump]; $Failed,
      bwsLog["the ", s, " -> 1 value of a cube integrand taken as a limit (the substitution gave 0 * ComplexInfinity)"]; L]]];
(* 2026-09-15 (MB14 p_0247): the LOOSE cube quadrature (a development gate, never a value) of a cube handed to the
   integrator.  Used to gate the certificate of a cube whose denominator carries a factor quadratic in a cube variable
   with irrational roots: on such cubes the certified value has been WRONG twice (MB13: -17 Pi^4/120 for 11 Pi^4/540;
   MB14 p_0247: -3 Zeta[3] for -9 Zeta[3], certified in 3 s inside a raised closure with the quadratic variable last),
   while the same cubes integrate numerically to the right value.  A second, cheaper attempt when the first fails. *)
bwsCubeQuad[f_, evars_] := Module[{q, rg = Sequence @@ ({#, 0, 1} & /@ evars)},
  (* NIntegrate holds its arguments: the range list must be spliced with Evaluate (without it the quadrature
     silently fails and every gate is UNGATED -- seen in the first MB14 worker test). *)
  q = Quiet@TimeConstrained[NIntegrate[f, Evaluate[rg], WorkingPrecision -> 20, PrecisionGoal -> 5, MaxRecursion -> 10,
      Method -> {"GlobalAdaptive", "SymbolicProcessing" -> 0}], 240, $Failed];
  If[! NumericQ[q], q = Quiet@TimeConstrained[NIntegrate[f, Evaluate[rg], WorkingPrecision -> 20, PrecisionGoal -> 3, MaxRecursion -> 7,
      Method -> {"GlobalAdaptive", "SymbolicProcessing" -> 0}], 180, $Failed]];
  If[NumericQ[q], q, $Failed]];
Global`$bwsCertGateTol = 10^-2;   (* loose: correct 5-dimensional values sit a few 10^-3 from their quadratures *)
Global`$bwsRegGateTol = 10^-3;    (* the regularized gate (was 10^-4: too tight for the 5-dimensional S cubes) *)
bwsIVFCert[f_, evars_, tmo0_] := Module[{v, fT, ords, k = 0, batch, batchLeft, t0, q = None, gateQ, win, nb, tmo = bwsIVFBudget[tmo0, evars]},
  If[evars === {}, Return[If[NumericQ[Quiet@N[f]], f, $Failed]]];
  fT = Together[f];
  ords = bwsOrderCandidates[fT, evars];
  gateQ = (Quiet@bwsQuadVars[fT, evars]) =!= {};   (* the class whose certificates have been wrong: gate by the cube quadrature *)
  Global`$bwsLastDivergent = False;
  While[k < Length[ords] && k < Global`$bwsMaxOrders,
    batch = Take[ords, {k + 1, Min[k + Global`$bwsRaceOrders, Length[ords], Global`$bwsMaxOrders]}]; k += Length[batch];
    batchLeft = batch;
    While[batchLeft =!= {},
      t0 = AbsoluteTime[];
      v = bwsIVFRace[fT, evars, batchLeft, tmo, False];
      If[v === $Failed, Break[]];
      win = Global`$bwsLastWinnerOrder;
      v = bwsGClean[v];
      If[! bwsExactQ[v, {}] && DownValues[Global`bwsL6Reduce] =!= {},
        bwsLog["level-6 constants left by gvExact: reducing through the cyclotomy-6 table"];
        v = Global`bwsL6Reduce[Global`$bwsLastRaw]];
      If[! bwsExactQ[v, {}], bwsLog["certificate race: inexact residue (", Short[v, 3], ")"]; Break[]];
      If[gateQ,
        If[q === None, q = bwsCubeQuad[fT, evars]];
        If[NumericQ[q] && ! (Abs[N[v, 20] - q] <= Global`$bwsCertGateTol (1 + Abs[q])),
          Global`$bwsCertMismatchDump = FileNameJoin[{$TemporaryDirectory, "bws_cert_mismatch_" <> ToString[$ProcessID] <> "_" <> ToString[Round[AbsoluteTime[]]] <> ".m"}];
          bwsLog["*** certificate order ", win, " gave ", v, " (", N[v, 10], ") but the cube quadrature is ", q,
            " -> WRONG certified value REFUSED (quadratic-denominator class); cube dumped to ", Global`$bwsCertMismatchDump, " ***"];
          Quiet@Put[{fT, evars, win, v, q}, Global`$bwsCertMismatchDump];
          nb = DeleteCases[batchLeft, win];
          If[Length[nb] === Length[batchLeft], Break[]];   (* the winner could not be identified: next batch *)
          batchLeft = nb; Continue[]]];
      bwsLog["certificate order ", win, " closed (", Round[AbsoluteTime[] - t0], " s, race of ", Length[batchLeft], ")",
        If[gateQ, If[NumericQ[q], "; the cube quadrature " <> ToString[q] <> " agrees", "; the cube quadrature failed: UNGATED certificate"], ""]];
      Return[v, Module]];
    (* 2026-09-15 (MB14 3-folds p_0245/0247/0248): a divergence verdict of the integrator is NOT decisive.  Its scan
       false-positives on double poles (the cubes of this class carry a corner factor squared), and the orders it
       called divergent sit next to orders that close in certificate mode with the value the cube quadrature confirms
       (S of p_0245: -43 Pi^4/120 + 9 Zeta[3] in four orders, quadratures -24.07..-24.08).  The former fail-fast
       ("a divergence in any order proves non-integrability, Fubini") refused the whole cube on that verdict, so the
       good orders were never tried.  Every order of the candidate list is now tried; a divergence verdict is logged
       and the piece-level gates (two constructions, or one with the contour quadrature) remain the arbiter. *)
    If[TrueQ[Global`$bwsLastDivergent],
      bwsLog["certificate race: divergence verdict in this batch (not decisive: the scan false-positives on double poles) -> further orders are tried"]]];
  $Failed];
Global`$bwsMaxOrders = 8;
(* 2026-09-05 GUARD: HyperFLINT's partial-fraction path for a DENOMINATOR factor of degree >= 2 in an integration
   variable with a non-square discriminant ("Phase 7 Wm/Wp") returned certified values that DROP the contribution of the
   irrational/complex roots (MB13 pieces 54/56/57/59: -17 Pi^4/120 instead of 11 Pi^4/540 per unit prefactor; the
   dispatcher's -11 Pi^4/90 remainders; the regularized S = Pi^4/45).  Such cubes are refused here, fail-closed. *)
(* a factor quadratic in v is harmless only when its discriminant is a perfect square of a polynomial (rational roots);
   2026-09-05: the former test Head[Sqrt[d]] =!= Power let 4 w1 w2 (Sqrt -> 2 Sqrt[w1 w2], head Times) pass *)
bwsPerfectSquareQ[d_, evars_] := PolynomialQ[d, evars] && Module[{r = Sqrt[Factor[d]]}, PolynomialQ[r, evars] && PossibleZeroQ[Together[r^2 - d]]];
bwsQuadraticDenQ[f_, evars_] := Module[{den = Denominator[Together[f]], fl},
  fl = FactorList[den][[All, 1]];
  AnyTrue[fl, Function[q, AnyTrue[evars, Function[v, PolynomialQ[q, v] && Exponent[q, v] >= 2 &&
      (Exponent[q, v] >= 3 || ! bwsPerfectSquareQ[Discriminant[q, v], evars])]]]]];
(* regularized mode.  lastVar (optional): force ONE fixed order with lastVar last -- the scale variable s of a
   difference quotient must be integrated last for its shuffle regularization to be the value of the convergent
   total (the "s LAST" lesson of MB13 piece 58: the same cube regularized in another order gave Pi^4/120 and Pi^4/45),
   and a variable carrying a quadratic denominator factor must be last so that the degree-2 path never fires.
   Gate: a LOOSE cube quadrature (user rule: development gates are loose; the benchmark assembly arbitrates). *)
bwsIVFReg[f_, evars_, tmo0_, lastVar_: None] := Module[{v = $Failed, num, fT, ords, tried = 0, tmo = bwsIVFBudget[tmo0, evars]},
  If[evars === {}, Return[If[NumericQ[Quiet@N[f]], f, $Failed]]];
  fT = Together[f];
  (* orders: quadratic variables last; when lastVar is given (the scale variable s) it must be the very last one *)
  ords = bwsOrderCandidates[fT, evars];
  (* lastVar: one variable, or (2026-09-05, several scales) a LIST of variables that must occupy the last positions *)
  If[lastVar =!= None,
    ords = Select[ords, If[ListQ[lastVar], Complement[Take[#, -Length[lastVar]], lastVar] === {}, Last[#] === lastVar] &];
    (* 2026-09-15 (MB14 3-folds): when the scale variable(s) must come last, the "quadratic variables last" rule of
       bwsOrderCandidates leaves at most ONE order (the quadratic variables cannot be last as well), and that order
       was refused on p_0245/0247/0248 with a cubic denominator factor in its first variable.  The orders offered are
       then the permutations of the other variables followed by the scale(s), a few at most; every regularized value
       is gated by the cube quadrature below, so a wrong value from a quadratic letter cannot pass. *)
    If[Length[ords] <= 1,
      Module[{lv = If[ListQ[lastVar], lastVar, {lastVar}], rest},
        rest = DeleteCases[evars, Alternatives @@ lv];
        ords = DeleteDuplicates[Join[ords, Take[Join[#, lv] & /@ Permutations[rest], UpTo[Global`$bwsMaxOrders]]]]]];
    If[ords === {}, ords = {If[ListQ[lastVar], Join[DeleteCases[evars, Alternatives @@ lastVar], lastVar],
      Append[DeleteCases[evars, lastVar], lastVar]]}]];
  (* the cube quadrature (the gate) does not depend on the order: once *)
  num = bwsCubeQuad[fT, evars];
  (* 2026-09-15 (MB14 p_0240, the slope-2 two-fold of MB13's class B): the cube quadrature fails on the nearly
     non-integrable cubes of this class, and the regularized value was then refused although it was the only exact
     candidate.  It is now admitted UNGATED at the cube level and flagged; the piece-level ladder (bwsExactLadder)
     serves a value built on an ungated regularized cube only with the contour quadrature of the PIECE confirming it. *)
  If[! NumericQ[num], Global`$bwsUngatedReg = True;
    bwsLog["regularized mode: the cube quadrature failed -> UNGATED regularized value (the piece-level contour quadrature must confirm)"]];
  Do[If[tried >= Global`$bwsMaxOrders, Break[]]; tried++;
     bwsLog["regularized single fixed-order request, order ", ord];
     v = bwsIVFSingleOrder[fT, evars, ord, tmo, True];
     If[v =!= $Failed, v = bwsGClean[v];
       If[! bwsExactQ[v, {}] && DownValues[Global`bwsL6Reduce] =!= {}, v = Global`bwsL6Reduce[Global`$bwsLastRaw]]];
     If[bwsExactQ[v, {}],
       bwsLog["regularized value ", v, " (", N[v, 12], ") vs cube quadrature ", num];
       (* 2026-09-15: a value that fails the gate is a wrong value of THIS order (a quadratic letter, a genuine
          divergence); the next order is tried instead of refusing the cube *)
       If[! NumericQ[num] || Abs[N[v, 20] - num] < Global`$bwsRegGateTol (1 + Abs[num]), Break[],
         bwsLog["regularized value of this order does not pass the cube quadrature -> next order"]; v = $Failed],
       v = $Failed], {ord, ords}];
  If[! bwsExactQ[v, {}], Return[$Failed]];
  v];

(* all distinct elimination orders that succeed algebraically, with their Euler cubes, ranked by size.
   2026-09-05: the cube is kept as GROUPS of terms sharing one variable set (the polynomial absorption and the crossing
   residues produce several terms whose eliminations mint their own auxiliary/Euler variables; summing them into one
   integrand made a 37-variable cube out of four 4-dimensional ones on MB10 p57).  Each group is closed separately
   and the exact values are summed; the rank is {largest group dimension, total size}. *)
bwsGroupTerms[res_] := Module[{exprs, groups},
  exprs = bwsTermExpr /@ res; If[! FreeQ[exprs, $Failed], Return[$Failed]];
  groups = GatherBy[exprs, Sort[DeleteDuplicates[Cases[#, x_Symbol /; bwsVarSymbolQ[x] :> x, {0, Infinity}]]] &];
  Table[With[{F = Together[Total[g]]}, {F, DeleteDuplicates[Cases[F, x_Symbol /; bwsVarSymbolQ[x] :> x, {0, Infinity}]]}], {g, groups}]];
(* close every group with the closure function f[F, evars] and sum; fail-closed if any group fails *)
bwsSumGroups[groups_, f_] := Module[{tot = 0, r},
  Do[r = f[g[[1]], g[[2]]]; If[r === $Failed, Return[$Failed, Module]]; tot += r, {g, groups}]; tot];
(* the ALIGNED SUM of all groups as one integrand over the union of their (role-named) variables (Lemma align): a term
   free of a variable is constant in it (Int_0^1 1 = 1), so the sum of the group integrals is the integral of the sum;
   the closure formulas then apply to the total, where the endpoint divergences of single groups cancel *)
bwsMergeGroups[groups_] := Module[{F = Total[groups[[All, 1]]]},
  {{F, DeleteDuplicates[Cases[F, x_Symbol /; bwsVarSymbolQ[x] :> x, {0, Infinity}]]}}];
bwsCandidates[terms_, vrs_, ctr_, prefer_] := Module[{cands = {}, seen = {}, res, F, evars, groups},
  Do[Global`$bwsLastOrder = {};
     Global`$bwsRoleReg = <||>;   (* role-aligned variable names: one registry per elimination order *)
     res = bwsEliminateAll[terms, vrs, ctr, ord];
     If[res =!= $Failed && ! MemberQ[seen, Global`$bwsLastOrder],
       AppendTo[seen, Global`$bwsLastOrder];
       groups = bwsGroupTerms[res];
       If[groups =!= $Failed,
         F = Total[groups[[All, 1]]];
         If[Module[{fv = Quiet@N[F /. bwsSamplePoint[F], 30]}, NumericQ[fv] && Abs[Im[fv]] <= 10^-20 (1 + Abs[fv])],
           evars = DeleteDuplicates[Flatten[groups[[All, 2]]]];
           AppendTo[cands, <|"Order" -> Global`$bwsLastOrder, "F" -> F, "EVars" -> evars, "Groups" -> groups,
             "Rank" -> {Max[Length /@ groups[[All, 2]]], LeafCount[F]}|>]]]],
    {ord, Join[If[prefer === {}, {}, {prefer}], Permutations[vrs]]}];
  SortBy[cands, #["Rank"] &]];

(* ---------- 2026-09-15 (MB14b pieces 0245/0247/0248): two EXACT fallbacks of the closure ----------
   Lemma unimod (psi-argument ALIGNMENT).  A Mellin-Barnes integral over straight contours is invariant under a
   unimodular integer change of variables: vertical lines map to vertical lines, |Jacobian| = 1, every Gamma leg keeps
   an integer slope.  A polygamma argument L = L0 + Sum_i k_i z_i with some |k_j| = 1 becomes the SINGLE-variable
   argument L0 + z_j under z_j -> (z_j - Sum_{i != j} k_i z_i)/k_j (the new z_j is the old L - L0; its contour value is
   L(ctr) - L0).  Observed on the MB14b kernel: with a two-variable argument the scale power s^(L-1) enters two
   eliminations and every cube of every order is refused, while the same kernel with a one-variable argument closes
   (the transferred pieces psi(1+z611) and psi(-z611) of piece 0247).  Candidates are ranked by the total |slope| of
   the transformed Gamma legs (the simplest kernel first).
   Lemma ibp (psi TRANSFER by parts).  Let R be the piece without one psi^(0)(L) factor, L a Gamma leg of R with
   numerator-minus-denominator count nL != 0, and z a variable with c = dL/dz != 0.  R decays exponentially on the
   vertical lines, so Int d/dz R = 0, i.e.
     Int R [ Sum_legs g' psi(g) - Sum_dens d' psi(d) - Sum_rat e q'/q + Sum_poly q'/q
             + Sum_other-psi L_o' psi^(m_o+1)(L_o)/psi^(m_o)(L_o) ] = 0,
   hence  Int R psi(L) = -(1/(nL c)) x (the other terms), every term a piece of this engine on the SAME contour.  It is
   used when the raise of an argument of non-positive real part leaves a rational remainder that no cube closes
   (0247: Gamma(x)^2/Gamma(x+1) refused in every order); the transferred arguments must have Re > 0 (the integral
   representation), those with Re >= 1/4 (no further raise) are preferred.  Both fallbacks are depth-guarded. *)
bwsDepth[sym_] := If[IntegerQ[sym], sym, 0];
Global`$bwsCloseSeconds = With[{e = Environment["BWS_CLOSE_SECONDS"]},
  If[StringQ[e] && IntegerQ[Quiet@ToExpression[e]], ToExpression[e], 3600]];
bwsCloseCap[vrs_] := Global`$bwsCloseSeconds Max[1, Length[vrs] - 1];   (* per construction; was 1800 x (fold - 1) *)
bwsSlopeSum[e_, vrs_] := Total[Abs[Coefficient[#, vrs]] & /@ Cases[e, Gamma[a_] :> a, {0, Infinity}], 2];
bwsAlignCandidates[ig_, ctr_, vrs_] := Module[{ps, out = {}},
  ps = DeleteDuplicates@Cases[ig, PolyGamma[_Integer, a_] /; Count[vrs, x_ /; ! FreeQ[a, x]] >= 2 :> a, {0, Infinity}];
  Do[Module[{k = Coefficient[L, #] & /@ vrs, L0 = L /. Thread[vrs -> 0]},
     If[AllTrue[k, IntegerQ] && bwsAffineQ[L, vrs],
       Do[If[Abs[k[[j]]] === 1,
          Module[{zj = vrs[[j]], sub, igA, ctrA},
            sub = zj -> (zj - Sum[If[i === j, 0, k[[i]] vrs[[i]]], {i, Length[vrs]}])/k[[j]];
            igA = ig /. sub;
            ctrA = ctr /. (zj -> _) :> (zj -> ((L - L0) /. ctr));
            (* the aligned variable often lands near a pole or inside the raise band: the near-pole midpoint shift
               (exact by analyticity, PART C) is applied to the aligned contour as well *)
            If[DownValues[Global`bwsNearPoleShift] =!= {}, ctrA = Quiet@Check[Global`bwsNearPoleShift[igA, ctrA, vrs], ctrA]];
            AppendTo[out, <|"L" -> L, "Var" -> zj, "Sub" -> sub, "Ig" -> igA, "Ctr" -> ctrA, "Rank" -> bwsSlopeSum[igA, vrs]|>]]],
         {j, Length[vrs]}]]], {L, ps}];
  SortBy[out, #["Rank"] &]];
bwsAlignClose[ig_, ctr_, vrs_, order_, excl_, tmo_] := Module[{cands, v = $Failed, d = bwsDepth[Global`$bwsAlignDepth]},
  If[d >= 2, Return[$Failed]];
  cands = bwsAlignCandidates[ig, ctr, vrs];
  If[cands === {}, Return[$Failed]];
  Do[If[v === $Failed,
     bwsLog["ALIGNMENT (Lemma unimod): psi argument ", c["L"], " -> the single variable ", c["Var"], " by ", c["Sub"],
       "; contour ", c["Ctr"], " (slope sum ", c["Rank"], ")"];
     v = Block[{Global`$bwsAlignDepth = d + 1},
       bwsClose[c["Ig"], c["Ctr"], vrs, "Order" -> order, "Exclude" -> excl, "Timeout" -> tmo]];
     If[v === $Failed, bwsLog["aligned closure refused"], bwsLog["aligned closure: ", v]]], {c, cands}];
  v];
bwsPsiTransfer[ig_, L_, ctr_, vrs_, order_, excl_, tmo_] := Module[
  {p, gam, den, rat, poly, others, ig1, nL, cands = {}, v = $Failed, d = bwsDepth[Global`$bwsTransferDepth], same},
  If[d >= 1, Return[$Failed]];
  p = bwsParse[ig, vrs]; If[p === $Failed, Return[$Failed]];
  same[a_, b_] := PossibleZeroQ[Expand[a - b]];
  gam = p["gam"]; den = p["den"]; rat = p["rat"]; poly = p["poly"];
  others = If[p["psi"] === None, {}, DeleteCases[p["psi"], PolyGamma[0, x_] /; same[x, L], 1, 1]];
  nL = Count[gam, x_ /; same[x, L]] - Count[den, x_ /; same[x, L]];
  If[nL === 0, bwsLog["transfer: psi argument ", L, " is not a Gamma leg of the piece -> no transfer"]; Return[$Failed]];
  ig1 = ig /. PolyGamma[0, L]^k_. :> PolyGamma[0, L]^(k - 1);   (* ONE occurrence removed *)
  Do[Module[{c = D[L, z], terms = {}, args, rate},
     If[c =!= 0,
       rate = Total[Abs[D[#, z]] & /@ gam] - Total[Abs[D[#, z]] & /@ den];
       Do[If[! same[g, L] && D[g, z] =!= 0, AppendTo[terms, {Count[gam, g] D[g, z], ig1 PolyGamma[0, g], g}]], {g, DeleteDuplicates[gam]}];
       Do[If[! same[g, L] && D[g, z] =!= 0, AppendTo[terms, {-Count[den, g] D[g, z], ig1 PolyGamma[0, g], g}]], {g, DeleteDuplicates[den]}];
       Do[If[D[q[[1]], z] =!= 0, AppendTo[terms, {-q[[2]] D[q[[1]], z], Together[ig1/q[[1]]], None}]], {q, rat}];
       Do[If[D[q, z] =!= 0, AppendTo[terms, {Count[poly, q] D[q, z], Together[ig1/q], None}]], {q, DeleteDuplicates[poly]}];
       Do[With[{mo = pg[[1]], Lo = pg[[2]]}, If[D[Lo, z] =!= 0,
          AppendTo[terms, {Count[others, pg] D[Lo, z],
            ig1 /. PolyGamma[mo, Lo]^k_. :> PolyGamma[mo, Lo]^(k - 1) PolyGamma[mo + 1, Lo], None}]]], {pg, DeleteDuplicates[others]}];
       args = bwsRe[#, ctr] & /@ DeleteCases[terms[[All, 3]], None];
       If[rate > 0 && terms =!= {} && AllTrue[args, NumericQ[#] && # > 0 &],
         AppendTo[cands, <|"Var" -> z, "c" -> c, "Terms" -> terms, "Rank" -> {If[args === {} || Min[args] >= 1/4, 0, 1], Length[terms]}|>],
         bwsLog["transfer in ", z, " not admissible (decay rate ", rate, ", transferred arguments with Re ", N[args, 3], ")"]]]], {z, vrs}];
  If[cands === {}, Return[$Failed]];
  cands = SortBy[cands, #["Rank"] &];
  Do[If[v === $Failed,
     Module[{tot = 0, ok = True, vt, first = None},
       bwsLog["PSI TRANSFER (Lemma ibp) in ", cand["Var"], ": psi(", L, ") -> ", Length[cand["Terms"]], " term(s), coefficients ",
         cand["Terms"][[All, 1]], " on ", cand["Terms"][[All, 3]] /. None -> "(rational or psi')", ", divided by -(", nL, " x ", cand["c"], ")"];
       Do[If[ok,
          vt = Block[{Global`$bwsTransferDepth = d + 1},
            bwsClose[t[[2]], ctr, vrs, "Order" -> order, "Exclude" -> excl, "Timeout" -> tmo]];
          If[vt === $Failed, ok = False; bwsLog["transferred term ", t[[3]] /. None -> "(rational or psi')", " refused -> this transfer is refused"],
            If[first === None, first = Global`$bwsLastOrder];
            bwsLog["transferred term ", t[[3]] /. None -> "(rational or psi')", " = ", vt];
            tot += t[[1]] vt]], {t, cand["Terms"]}];
       If[ok, v = Simplify[-tot/(nL cand["c"])]; Global`$bwsLastOrder = first;
         bwsLog["psi transfer closure: ", v]]]], {cand, cands}];
  v];
(* the fallback chain of a refused closure: alignment first (one piece), the transfer second (several pieces);
   L = the psi^(0) argument to transfer, None when the piece has none *)
bwsFallbackClose[ig_, ctr_, vrs_, order_, excl_, tmo_, L_] := Module[{v},
  v = bwsAlignClose[ig, ctr, vrs, order, excl, tmo];
  If[v === $Failed && L =!= None, v = bwsPsiTransfer[ig, L, ctr, vrs, order, excl, tmo]];
  v];

Options[bwsClose] = {"Order" -> {}, "Timeout" -> Automatic, "Exclude" -> {}};
(* 2026-09-15: MEMO of the closures of this kernel.  The fallback chains (raise, alignment, transfer) meet the same
   integrand on the same contour more than once (the aligned raised piece is also the raised aligned piece); a
   closure is deterministic up to the integrator's time budget, so its outcome, the order used and the ungated flag
   are kept per {integrand, contour, variables, options, depths} and replayed.  Exact values only; nothing served
   changes. *)
bwsClose[ig_, ctr_List, vrs_List, opts : OptionsPattern[]] := Module[
  {key = {ig, ctr, vrs, OptionValue["Order"], OptionValue["Exclude"], bwsDepth[Global`$bwsAlignDepth], bwsDepth[Global`$bwsTransferDepth]}, r, m},
  If[! AssociationQ[Global`$bwsMemo], Global`$bwsMemo = <||>];
  If[KeyExistsQ[Global`$bwsMemo, key],
    m = Global`$bwsMemo[key];
    bwsLog["memo: this integrand was closed before in this kernel -> ", m[[1]]];
    Global`$bwsLastOrder = m[[2]]; Global`$bwsUngatedReg = TrueQ[Global`$bwsUngatedReg] || TrueQ[m[[3]]];
    Return[m[[1]], Module]];
  r = bwsCloseCore[ig, ctr, vrs, opts];
  Global`$bwsMemo[key] = {r, Global`$bwsLastOrder, TrueQ[Global`$bwsUngatedReg]};
  r];
Options[bwsCloseCore] = Options[bwsClose];
bwsCloseCore[ig_, ctr_List, vrs_List, OptionsPattern[]] := Catch[Module[
  {p, s, terms, cands, val = $Failed, tmo, order = OptionValue["Order"], excl = OptionValue["Exclude"],
   tried = 0, used = {}, psis, ss, m0, subsetSum, closeGroupsCert, closeGroupsReg, sumOrAligned},
  tmo = OptionValue["Timeout"]; If[tmo === Automatic, tmo = Global`$bwsIVFSeconds];
  p = bwsParse[ig, vrs]; If[p === $Failed, Throw[$Failed, "bws"]];
  (* PURE mode (no polygamma): the value is the cube itself.  2026-09-05: SEVERAL polygamma factors are allowed
     (class b, the MB6 difference-kernel family psi(-1+z35-z60) psi(-z60), psi(-2-z60)^2): each factor gets its own
     scale variable; the closure below sums over the subsets of the m = 0 scales (Lemma multipsi). *)
  psis = If[p["psi"] === None, {}, p["psi"]];
  (* 2026-09-05: one-variable psi arguments are allowed too (class C sub-pieces after the psi duplication; the sealed
     harmonic-sums fast path served a half-integer-offset psi one-fold WRONG without its quadrature gate) *)
  Do[If[Count[vrs, x_ /; ! FreeQ[pg[[2]], x]] < 1, Throw[$Failed, "bws"]], {pg, psis}];
  (* 2026-09-05 (MB13 piece 58): the psi integral representation needs Re L > 0 on the contour.  When Re L <= 0,
     raise the argument, psi^(m)(L) = psi^(m)(L+n) - (-1)^m m! Sum_{k<n} (L+k)^-(m+1) with n = Floor[-Re L]+1: the
     first term is this engine on the raised piece (recursively, same options), the rational remainder is this
     engine on the piece with that ONE factor replaced by the rational (an aux power of the correct branch; the
     strategy dispatcher gave a WRONG value for it on piece 58, -11.9 against the quadrature's +3.88).  Both exact;
     the sum is exact.  With several factors the first one of non-positive real part is raised; one occurrence of a
     power psi^k at a time (the recursion raises the next). *)
  (* 2026-09-06 07:00 (MB8b pieces 0618/0616): a psi argument within 1/4 of its pole (0 < Re L < 1/4) is raised
     FIRST as well -- its kinematic power s^(L-1) makes every Euler cube nearly non-integrable and the direct closure
     of a 4-fold takes more than an hour to be refused, so the retry below never came.  Exact identity; the recursion
     raises again if the raised argument still lies in the band (0616: -0.839 -> 0.161 -> 1.161). *)
  Do[With[{m = pg[[1]], L = pg[[2]]}, Module[{reL = bwsRe[L, ctr]},
    If[NumericQ[reL] && reL < 1/4,
      Module[{n = If[reL <= 0, Floor[-reL] + 1, 1], ig1, shifted, t1, t2, rat, v, ord1},
        ig1 = ig /. PolyGamma[m, L]^k_. :> PolyGamma[m, L]^(k - 1);   (* ONE occurrence removed *)
        shifted = ig1 PolyGamma[m, L + n];
        bwsLog["psi argument ", L, " has Re ", N[reL, 6], " on the contour", If[reL <= 0, "", " (within 1/4 of its pole)"], ": raised by ", n];
        t1 = bwsClose[shifted, ctr, vrs, "Order" -> order, "Exclude" -> excl, "Timeout" -> tmo];
        If[t1 === $Failed, bwsLog["raised piece refused"],
          ord1 = Global`$bwsLastOrder;
          rat = Sum[1/(L + k)^(m + 1), {k, 0, n - 1}];
          t2 = bwsClose[Together[ig1 rat], ctr, vrs, "Order" -> order, "Exclude" -> excl, "Timeout" -> tmo];
          If[t2 === $Failed, bwsLog["rational remainder of the psi raise refused"],
            Global`$bwsLastOrder = ord1;
            v = Simplify[t1 - (-1)^m m! t2];
            bwsLog["raised-psi closure: BWS part ", t1, ", rational part ", t2, " -> ", v];
            Throw[If[bwsExactQ[v, vrs], v, $Failed], "bws"]]];
        (* 2026-09-15: the raise refused -> the exact fallbacks (Lemma unimod, then Lemma ibp for a psi^(0) factor).
           In the FIRST construction only ("Exclude" = {}): the second construction is a confirmation, and when it
           refuses the piece is served by the single construction under its quadrature gate as before -- the
           fallbacks there only lengthened the refusal (MB6 regression, 2-fold psi pieces). *)
        v = If[excl === {}, bwsFallbackClose[ig, ctr, vrs, order, excl, tmo, If[m === 0, L, None]], $Failed];
        Throw[If[bwsExactQ[v, vrs], v, $Failed], "bws"]]]]], {pg, psis}];
  p = bwsCancelDen[p, ctr]; If[p === $Failed, Throw[$Failed, "bws"]];
  ss = Table[bwsFresh["bwsS"], {Length[psis]}];
  m0 = Pick[ss, (#[[1]] == 0) & /@ psis];   (* the scales of the psi^(0) factors: those carry the -gamma + difference form *)
  s = If[Length[m0] === 1, First[m0], None];   (* the single-scale case keeps the sealed closure sequence below *)
  terms = bwsInit[p, vrs, ctr, ss]; If[terms === $Failed, Throw[$Failed, "bws"]];
  cands = bwsCandidates[terms, vrs, ctr, order];
  (* "Exclude" -> an elimination order: the caller wants a structurally different cube (second construction); the
     remaining candidates are still ranked by {dim, size}, so the cheapest alternative is tried first *)
  If[excl =!= {}, cands = Select[cands, #["Order"] =!= excl &]];
  If[cands === {}, Throw[$Failed, "bws"]];
  If[order =!= {}, cands = Join[Select[cands, #["Order"] === order &], Select[cands, #["Order"] =!= order &]]];
  bwsLog[Length[cands], " elimination order(s): ", #["Order"] -> #["Rank"] & /@ cands];
  (* certificate-mode closure, best-ranked cube first; regularized (numerically gated) only if every order refuses *)
  (* every candidate is a list of term GROUPS (one variable set each); each group is closed separately, values summed *)
  (* the subset-sum closure for r = Length[m0] >= 2 polygamma^(0) factors (Lemma multipsi): with each psi^(0)(L_i) =
     -gamma + Int_0^1 (1 - s_i^(L_i-1))/(1-s_i) ds_i, the product expands into
        Sum_{T subset m0} (-gamma)^(r-|T|) (-1)^|T| Int prod_{i in T} log(1-s_i) d/ds_i [F]|_{s_j = 1, j notin T}
     (each factor by parts as in the single-scale case); every subset term is a certificate-mode cube of its own.
     closer[integrand, evars, lastVars] closes one such cube (certificate or regularized). *)
  (* 2026-09-05 17:15 BUG FIXED: "Return[$Failed, Module]" inside the Do body's own Module left only THAT Module, so a
     refused subset term was silently DROPPED and the sum served a wrong exact value (MB6 piece 0502, order {z35,z60}:
     the gamma-free term missing; caught by the two-construction gate + escalation quadrature).  A refused term now
     fails the whole sum (flag + Break). *)
  (* 2026-09-05 20:45: PER-TERM alignment -- a subset term (or P0, S, the pure cube) is closed group-wise first and,
     only if a group is refused alone, as the aligned sum of the groups (Lemma align); the terms that closed
     group-wise keep their values (a certificate-mode success proves absolute convergence, and the aligned sum equals
     the sum of the parts when every part converges).  Before, one refused term sent the WHOLE closure to the
     aligned cubes again. *)
  sumOrAligned[groups_, f_, tag_] := Module[{r = bwsSumGroups[groups, f], m},
    If[r === $Failed && Length[groups] > 1,
      m = bwsMergeGroups[groups];
      bwsLog[tag, ": a group refused alone -> the aligned sum of the ", Length[groups], " groups as one ",
        Length[m[[1, 2]]], "-dimensional cube (Lemma align)"];
      r = f[m[[1, 1]], m[[1, 2]]]];
    r];
  subsetSum[groups_, closer_] := Module[{tot = 0, r = Length[m0], term, failed = False},
    Do[Module[{rest = Complement[m0, T], sub1},
       sub1 = Thread[rest -> 1];
       term = sumOrAligned[groups, Function[{F, ev}, Module[{FT = bwsAtOne[F, rest], evT = DeleteCases[ev, Alternatives @@ rest]},
           (* a group free of one of the subset's scales has a vanishing mixed derivative *)
           Which[FT === $Failed, $Failed,
             T =!= {} && AnyTrue[T, FreeQ[FT, #] &], 0,
             True, closer[Together[Times @@ (Log[1 - #] & /@ T) D[FT, Sequence @@ T]], evT, T]]]], "subset term " <> ToString[T]];
       If[term === $Failed, failed = True; bwsLog["subset term ", T, " refused -> the subset sum is refused"],
         tot += (-EulerGamma)^(r - Length[T]) (-1)^Length[T] term]];
       If[failed, Break[]], {T, Subsets[m0]}];
    If[failed, $Failed, tot]];
  (* certificate-mode closure of a list of groups (group-wise or the aligned sum) *)
  closeGroupsCert[groups_, tag_] := Module[{P0, S, v = $Failed},
    Which[
     Length[m0] === 1,
      P0 = sumOrAligned[groups, Function[{F, ev}, Module[{F1 = bwsAtOne[F, s]},
          If[F1 === $Failed, $Failed, bwsIVFCert[F1, DeleteCases[ev, s], tmo]]]], tag <> " P0"];
      If[P0 =!= $Failed,
        (* S = Int_0^1 [F(1)-F(s)]/(1-s) ds = -Int_0^1 log(1-s) F'(s) ds (integration by parts; the boundary terms
           vanish): no cancellation between terms, only an integrable log endpoint -> certificate mode accepts it.
           The difference quotient was refused by the divergence certificate and its REGULARIZED value was wrong
           (MB13 piece 58: Pi^4/45 against the true -Pi^4/540).  A group free of s contributes nothing to S. *)
        S = sumOrAligned[groups, Function[{F, ev}, If[FreeQ[F, s], 0, bwsIVFCert[Together[-Log[1 - s] D[F, s]], ev, tmo]]], tag <> " S"];
        If[S =!= $Failed, v = -EulerGamma P0 + S; bwsLog[tag, ": P0 = ", P0, ", S = ", S],
          bwsLog[tag, ": S refused in certificate mode (", Short[Global`$ivfLastRefusals, 3], ")"]],
        bwsLog[tag, ": P0 refused in certificate mode (", Short[Global`$ivfLastRefusals, 3], ")"]],
     Length[m0] >= 2,
      v = subsetSum[groups, Function[{f, ev, lastT}, bwsIVFCert[f, ev, tmo]]];
      If[v =!= $Failed, bwsLog[tag, ": ", Length[m0], "-scale subset sum = ", v],
        bwsLog[tag, ": a subset cube refused in certificate mode (", Short[Global`$ivfLastRefusals, 3], ")"]],
     True,
      v = sumOrAligned[groups, Function[{F, ev}, bwsIVFCert[F, ev, tmo]], tag];
      If[v =!= $Failed, bwsLog[tag, ": value = ", v],
        bwsLog[tag, ": refused in certificate mode (", Short[Global`$ivfLastRefusals, 3], ")"]]];
    v];
  (* regularized closure (numeric gate inside bwsIVFReg) of a list of groups *)
  closeGroupsReg[groups_] := Module[{P0, S, v = $Failed},
    Which[
     Length[m0] === 1,
      P0 = bwsSumGroups[groups, Function[{F, ev}, Module[{F1 = bwsAtOne[F, s]},
          If[F1 === $Failed, $Failed, bwsIVFReg[F1, DeleteCases[ev, s], tmo]]]]];
      (* the difference quotient with s LAST (its regularization is then the value of the convergent total);
         the by-parts form second *)
      S = If[P0 === $Failed, $Failed,
        bwsSumGroups[groups, Function[{F, ev}, If[FreeQ[F, s], 0, Module[{F1 = bwsAtOne[F, s]},
          If[F1 === $Failed, $Failed, bwsIVFReg[Together[(F1 - F)/(1 - s)], ev, tmo, s]]]]]]];
      If[S === $Failed && P0 =!= $Failed,
        S = bwsSumGroups[groups, Function[{F, ev}, If[FreeQ[F, s], 0, bwsIVFReg[Together[-Log[1 - s] D[F, s]], ev, tmo, s]]]]];
      If[S =!= $Failed, v = -EulerGamma P0 + S],
     Length[m0] >= 2,
      (* by-parts subset cubes, the scale variables of the subset LAST *)
      v = subsetSum[groups, Function[{f, ev, lastT}, bwsIVFReg[f, ev, tmo, If[lastT === {}, None, lastT]]]],
     True,
      v = bwsSumGroups[groups, Function[{F, ev}, bwsIVFReg[F, ev, tmo]]]];
    v];
  (* 2026-09-05 19:00 (Lemma align): group-wise first (small cubes); if a group is refused alone, the ALIGNED SUM of
     all groups of that order is closed as one integrand (the role-named variables coincide across the terms, so the
     dimension is that of the longest chain) -- the endpoint divergences of single groups cancel in the total. *)
  (* 20:45: the aligned fallback is now PER TERM inside closeGroupsCert (sumOrAligned) *)
  Do[Module[{groups = c["Groups"]},
     If[val =!= $Failed || tried >= 6, Continue[]]; tried++;
     val = closeGroupsCert[groups, "order " <> ToString[c["Order"]] <> " (" <> ToString[Length[groups]] <> " group(s))"];
     If[val =!= $Failed, used = c["Order"]]],
    {c, cands}];
  If[val === $Failed,
    Module[{c = First[cands], groups},
      (* the regularization must be applied to ONE integrand for its finite parts to be consistent: the aligned sum *)
      groups = If[Length[c["Groups"]] > 1, bwsMergeGroups[c["Groups"]], c["Groups"]];
      bwsLog["regularized retry under a numeric gate on order ", c["Order"], " (", If[Length[c["Groups"]] > 1, "aligned sum", "single group"], ")"];
      val = closeGroupsReg[groups];
      If[val =!= $Failed, used = c["Order"]]]];
  (* 2026-09-06 05:50 (MB8b pieces 0616/0618): NEAR-POLE PSI RAISE as a retry.  A psi argument L with 0 < Re L < 1/2 on
     the contour is admissible for the integral representation, but its kinematic power s^(L-1) is nearly
     non-integrable and the Euler cubes of every elimination are refused as divergent (0618: all aligned P0/S cubes of
     seven orders).  The raise psi^(m)(L) = psi^(m)(L+n) - (-1)^m m! Sum_{k<n} (L+k)^-(m+1) (exact) moves the argument
     to Re >= 1/2.  Applied ONLY after the direct closure has been refused, so every piece that closed before keeps
     its path. *)
  If[val === $Failed,
    Module[{cand = SelectFirst[psis, With[{r = bwsRe[#[[2]], ctr]}, NumericQ[r] && 0 < r < 1/2] &, None]},
      If[cand =!= None,
        With[{m = cand[[1]], L = cand[[2]]}, Module[{reL = bwsRe[L, ctr], n, ig1, t1, t2, rat, v, ord1},
          n = Floor[1/2 - reL] + 1;
          bwsLog["direct closure refused; psi argument ", L, " has Re ", N[reL, 4], " (near its pole): NEAR-POLE RAISE by ", n];
          ig1 = ig /. PolyGamma[m, L]^k_. :> PolyGamma[m, L]^(k - 1);   (* ONE occurrence removed *)
          t1 = bwsClose[ig1 PolyGamma[m, L + n], ctr, vrs, "Order" -> order, "Exclude" -> excl, "Timeout" -> tmo];
          If[t1 =!= $Failed,
            ord1 = Global`$bwsLastOrder;
            rat = Sum[1/(L + k)^(m + 1), {k, 0, n - 1}];
            t2 = bwsClose[Together[ig1 rat], ctr, vrs, "Order" -> order, "Exclude" -> excl, "Timeout" -> tmo];
            If[t2 =!= $Failed,
              Global`$bwsLastOrder = ord1; used = ord1;
              v = Simplify[t1 - (-1)^m m! t2];
              bwsLog["near-pole-raised closure: BWS part ", t1, ", rational part ", t2, " -> ", v];
              If[bwsExactQ[v, vrs], val = v]]]]]]]];
  (* 2026-09-15: the direct closure refused -> the exact fallbacks (Lemma unimod on a multi-variable psi argument,
     then Lemma ibp on the first psi^(0) factor); the inner closure records its own order *)
  If[val === $Failed && psis =!= {} && excl === {},   (* first construction only, see the raise branch *)
    Module[{L0 = SelectFirst[psis, #[[1]] === 0 &, None]},
      bwsLog["direct closure refused -> exact fallbacks (alignment, transfer)"];
      val = bwsFallbackClose[ig, ctr, vrs, order, excl, tmo, If[L0 === None, None, L0[[2]]]];
      If[val =!= $Failed, used = Global`$bwsLastOrder]]];
  If[val === $Failed, Throw[$Failed, "bws"]];
  (* record the elimination order that PRODUCED the value (the enumeration above leaves the marker on the last
     order it tried, which made the second-construction gate reject genuinely different orders) *)
  Global`$bwsLastOrder = used;
  val = Simplify[val];
  If[bwsExactQ[val, vrs], val, $Failed]], "bws"];

bwsTwoVarPsiQ[ig_, vrs_] := Length[vrs] >= 2 &&
  AnyTrue[Cases[ig, PolyGamma[_, a_] :> a, {0, Infinity}], Count[vrs, x_ /; ! FreeQ[#, x]] >= 2 &];
(* a numerator Gamma pair Gamma(a+v)Gamma(b-v) with a+b a non-positive integer in some MB variable v *)
bwsDegenerateQ[ig_, vrs_] := Module[{p = bwsParse[ig, vrs], gam},
  If[p === $Failed, Return[False]]; gam = p["gam"];
  AnyTrue[vrs, Function[v, Module[{plus = Select[gam, Coefficient[#, v] === 1 &], minus = Select[gam, Coefficient[#, v] === -1 &]},
    AnyTrue[Flatten[Outer[Plus, plus /. v -> 0, minus /. v -> 0]], bwsNonPosIntQ]]]]];
(* a Gamma leg (numerator or denominator) with an integer slope |k| >= 2 in some MB variable *)
bwsSlopeQ[ig_, vrs_] := AnyTrue[Cases[ig, Gamma[a_] :> a, {0, Infinity}],
  Function[a, AnyTrue[vrs, IntegerQ[Coefficient[a, #]] && Abs[Coefficient[a, #]] >= 2 &]]];

(* ===================== PART B: MBEStrategy`mbeStdClose wrap ===================== *)
If[DownValues[MBEStrategy`mbeStdClose] =!= {} && DownValues[Global`bwsStdCloseOrig] === {},
 Module[{},
  Global`$bwsStdCloseSaved = DownValues[MBEStrategy`mbeStdClose];
  DownValues[Global`bwsStdCloseOrig] =
    Global`$bwsStdCloseSaved /. HoldPattern[MBEStrategy`mbeStdClose] -> Global`bwsStdCloseOrig;
  Clear[MBEStrategy`mbeStdClose];
  bwsOrigTry[ig_, ctr_, vrs_, secs_] := Block[{MBEStrategy`Private`$mbeDispatchSeconds = secs},
    Module[{v = Quiet@CheckAbort[Global`bwsStdCloseOrig[ig, ctr, vrs], $Failed]},
      If[ListQ[v] && Length[v] === 2 && bwsExactQ[v[[1]], vrs], v, $Failed]]];
  MBEStrategy`mbeStdClose[ig_, ctr_List, vrs_List] := Module[{v = $Failed},
    If[bwsTwoVarPsiQ[ig, vrs],
      bwsLog["multi-variable polygamma argument -> BWS engine"];
      v = Quiet@CheckAbort[TimeConstrained[Global`bwsClose[ig, ctr, vrs], bwsCloseCap[vrs], $Failed], $Failed];   (* cap scales with the fold (08:30) *)
      If[bwsExactQ[v, vrs], bwsLog["closed: ", v]; Return[{v, "TwoVarPsi-BWS"}, Module]];
      bwsLog["BWS engine refused; falling to the dispatcher"]];
    v = bwsOrigTry[ig, ctr, vrs, MBEStrategy`Private`$mbeDispatchSeconds];
    If[v =!= $Failed, Return[v, Module]];
    (* retries: variable permutations, then single and double reflections (exact changes of variables) *)
    Do[If[v === $Failed && perm =!= vrs, v = bwsOrigTry[ig, ctr, perm, 400]],
      {perm, If[Length[vrs] <= 3, Permutations[vrs], Join[{Reverse[vrs]}, Table[RotateLeft[vrs, k], {k, 1, Length[vrs] - 1}]]]}];
    If[v === $Failed,
      Do[If[v === $Failed,
         Module[{igR = ig /. rv -> -rv, ctrR = ctr /. (rv -> c_) :> (rv -> -c)}, v = bwsOrigTry[igR, ctrR, vrs, 400]]],
        {rv, vrs}]];
    If[v === $Failed && Length[vrs] >= 3,
      Do[If[v === $Failed,
         Module[{igR = ig /. Thread[rp -> -rp], ctrR = ctr /. ((vv_ -> c_) /; MemberQ[rp, vv]) :> (vv -> -c)},
           v = bwsOrigTry[igR, ctrR, vrs, 400]]],
        {rp, Subsets[vrs, {2}]}]];
    If[v === $Failed, {$Failed, None}, v]];
  WriteString["stdout", "[mbeTwoVarPsiRung] mbeStdClose wrapped (BWS engine + permutation/reflection retries).\n"]]];

(* ===================== PART C: post-failure exact ladder at the piece entry point ===================== *)
(* mbtCachedMB2MPL is (re)defined INSIDE every MBresolveToMPL call (a call-time helper of the sealed entry point) with
   the generic pattern [intg_, ctr_, vrs_].  2026-09-05 (regression): the wrap is a PERSISTENT rule with the more
   specific pattern [intg_, ctr_List, vrs_List] and a re-entrancy condition; Mathematica orders it before the generic
   rule and the package never clears the symbol, so the wrap is active in the serial master (PieceKernels 0, the
   notebook's default) as well as in every worker, from the first call on.  The original evaluator is reached by
   bwsOrigCall (the condition flag).  The earlier version copied the DownValues after the worker's bootstrap call and
   was therefore never active in a serial master. *)
bwsOrigCall[intg_, ctr_, vrs_] := Block[{Global`$bwsInOrig = True}, MBtoMPL`Private`mbtCachedMB2MPL[intg, ctr, vrs]];
bwsInstallCachedWrap[] := If[DownValues[MBEStrategy`mbeStdClose] =!= {} && ! TrueQ[Global`$bwsCachedWrapInstalled],
 Module[{},
  Global`$bwsCachedWrapInstalled = True;
  (* the package's own cache key (numeric prefactor stripped; one-folds canonicalised) *)
  bwsCacheKey[intg_, ctr_, vrs_] := Module[{numFactor, normalised, canon, key},
    numFactor = Times @@ Cases[intg, _?(NumericQ[N[#]] && FreeQ[#, Alternatives @@ vrs] &), {1}];
    If[PossibleZeroQ[numFactor] || ! FreeQ[numFactor, Alternatives @@ vrs], numFactor = 1];
    normalised = intg/numFactor;
    canon = If[Length[vrs] == 1, MBtoMPL`Private`mbtCanonicalize[normalised, First[vrs]], normalised];
    key = {MBtoMPL`Private`$mbtCacheVersion, canon, ctr, vrs};
    {numFactor, key, IntegerString[Hash[key, "SHA"], 16]}];
  bwsCacheStore[key_, nf_, dh_, ex_] := If[key =!= None,
    Module[{val = Simplify[ex/nf]}, MBtoMPL`Private`$mbtMB2MPLCache[key] = val;
      Quiet@MBtoMPL`Private`mbtMB2MPLDiskPut[dh, val]]];
  (* second, structurally different construction of the same exact value *)
  bwsSecondConstruction[ig_, ctr_, vrs_, first_] := Module[{v2 = $Failed},
    If[bwsTwoVarPsiQ[ig, vrs],
      (* a different elimination order than the one that produced the first value *)
      Module[{firstOrder = Global`$bwsLastOrder},
        (* the best-ranked cube among the OTHER elimination orders, in ONE call (rank = {dim, size}).  A blind
           permutation loop tried a 7-dimensional cube first and only timed out; the ranked alternative for these
           pieces is 3-dimensional and closes in seconds. *)
        v2 = Quiet@CheckAbort[TimeConstrained[Global`bwsClose[ig, ctr, vrs, "Exclude" -> firstOrder], bwsCloseCap[vrs], $Failed], $Failed];
        If[! bwsExactQ[v2, vrs] || Global`$bwsLastOrder === firstOrder, v2 = $Failed];
        Global`$bwsSecondTag = "TwoVarPsi-BWS-otherorder"],
      (* pure-Gamma / other multi-folds.  The engineN cube of such a piece is the MBtoEuler cube built in the GIVEN
         variable order, so a different order is a structurally different Euler cube of the same MB integral (a
         different reflection likewise).  Try every distinct order through the dispatcher (rotations and the
         reversal first), then single reflections; each try is logged. *)
      Module[{deadline = AbsoluteTime[] + 3300, orders},
        (* 2026-09-05 (MB13): FIRST a genuinely different ENGINE — the BWS recursion in pure mode (no polygamma);
           an agreement between two variable orders of the SAME engine is not engine-independent (EngineN returned
           the same wrong -11 Pi^4/90-type values in two orders) and is accepted below only with the quadrature. *)
        Module[{t0 = AbsoluteTime[], r},
          r = Quiet@CheckAbort[TimeConstrained[Global`bwsClose[ig, ctr, vrs], 600, $Failed], $Failed];
          bwsLog["construction 2, BWS pure mode: ", If[r === $Failed, "refused", "closed"], " (", Round[AbsoluteTime[] - t0], " s)"];
          If[r =!= $Failed && bwsExactQ[r, vrs], v2 = r; Global`$bwsSecondTag = "BWS-pure"]];
        orders = DeleteDuplicates[DeleteCases[
          Join[Rest[NestList[RotateLeft, vrs, Length[vrs] - 1]], {Reverse[vrs]}, Permutations[vrs]], vrs]];
        Do[If[v2 === $Failed && AbsoluteTime[] < deadline,
           Module[{t0 = AbsoluteTime[], r = bwsOrigTry[ig, ctr, ord, 600]},
             bwsLog["construction 2, order ", ord, ": ", If[r === $Failed, "refused", r[[2]]],
               " (", Round[AbsoluteTime[] - t0], " s)"];
             If[r =!= $Failed && bwsExactQ[r[[1]], vrs], v2 = r[[1]]; Global`$bwsSecondTag = r[[2]]]]], {ord, orders}];
        Do[If[v2 === $Failed && AbsoluteTime[] < deadline,
           Module[{igR = ig /. rv -> -rv, ctrR = ctr /. (rv -> c_) :> (rv -> -c), t0 = AbsoluteTime[], r},
             r = bwsOrigTry[igR, ctrR, Reverse[vrs], 600];
             bwsLog["construction 2, reflect ", rv, " + reversed order: ", If[r === $Failed, "refused", r[[2]]],
               " (", Round[AbsoluteTime[] - t0], " s)"];
             If[r =!= $Failed && bwsExactQ[r[[1]], vrs] && ! (r[[2]] === first[[2]] && Reverse[vrs] === vrs),
               v2 = r[[1]]; Global`$bwsSecondTag = r[[2]]]]], {rv, vrs}]]];
    v2];
  bwsLooseQuad[ig_, ctr_, vrs_] := Module[{ts, sub, q},
    If[! FreeQ[ig, Complex] || ! FreeQ[ig, Power[b_ /; b === -1 || b === E, e_ /; ! FreeQ[e, Alternatives @@ vrs]]],
      Return[$Failed]];
    ts = Table[Unique["bwsT"], {Length[vrs]}];
    sub = MapThread[(#1 -> (#1 /. ctr) + I #2) &, {vrs, ts}];
    (* CHEAP by design (user 2026-09-04): low precision, short cap; used only in the single-construction fallback *)
    q = Quiet@TimeConstrained[NIntegrate[Re[Quiet@FunctionExpand[ig] /. sub]/(2 Pi)^Length[vrs],
        Evaluate[Sequence @@ ({#, -12, 12} & /@ ts)], WorkingPrecision -> 20, PrecisionGoal -> 3,
        MaxRecursion -> 5, Method -> {"GlobalAdaptive", "MaxErrorIncreases" -> 400}], 120, $Failed];
    If[NumericQ[q], q, $Failed]];
  (* the exact two-construction ladder on one piece: numFactor * value, or $Failed.  No numerical integration on the
     two-construction path; a CHEAP low-precision quadrature only in the single-construction fallback. *)
  (* 2026-09-05 restructure: construction A = the BWS engine itself (pure or polygamma mode; it is the engine whose
     cube closures were verified piece by piece tonight), construction B = a structurally different one (for BWS pieces
     the best-ranked OTHER elimination order; for the rest the ORIGINAL strategy dispatcher, whose EngineN path served
     wrong values on the degenerate-pairing family).  Decision: A == B exactly -> serve (a same-engine agreement is
     confirmed by the cheap quadrature when it is available); A != B -> the cheap quadrature arbitrates at 1e-2 and the
     event is logged loudly; only one exact construction -> served only with an agreeing quadrature. *)
  bwsAgreeQ[v_, q_] := NumericQ[q] && Abs[N[v, 20] - q] <= 10^-2 (1 + Abs[q]);
  (* 2026-09-05 (piece 0057): the cheap quadrature (range 12, PrecisionGoal 3) was 3.5% off on a piece with a double
     crossing pole near the contour and could not arbitrate between the right BWS value and the wrong EngineN value ->
     ESCALATION quadrature, used only when the cheap one cannot decide: wider range, PrecisionGoal 8, tight 1e-5 gate.
     Still a development gate between EXACT candidates, never a producer. *)
  bwsBetterQuad[ig_, ctr_, vrs_] := Module[{ts, sub, q, t0 = AbsoluteTime[]},
    If[! FreeQ[ig, Complex] || ! FreeQ[ig, Power[b_ /; b === -1 || b === E, e_ /; ! FreeQ[e, Alternatives @@ vrs]]],
      Return[$Failed]];
    ts = Table[Unique["bwsT"], {Length[vrs]}];
    sub = MapThread[(#1 -> (#1 /. ctr) + I #2) &, {vrs, ts}];
    q = Quiet@TimeConstrained[NIntegrate[Re[Quiet@FunctionExpand[ig] /. sub]/(2 Pi)^Length[vrs],
        Evaluate[Sequence @@ ({#, -40, 40} & /@ ts)], WorkingPrecision -> 30, PrecisionGoal -> 8,
        MaxRecursion -> 12, Method -> {"GlobalAdaptive", "MaxErrorIncreases" -> 1000}], 900, $Failed];
    bwsLog["escalation quadrature: ", q, " (", Round[AbsoluteTime[] - t0], " s)"];
    If[NumericQ[q], q, $Failed]];
  bwsAgreeTightQ[v_, q_] := NumericQ[q] && Abs[N[v, 20] - q] <= 10^-5 (1 + Abs[q]);
  bwsExactLadder[intg_, ctr_, vrs_] := Module[{numFactor, normalised, vA = $Failed, vB = $Failed, tagA = "BWS", tagB = None,
      ordA, r, q, q2, t0 = AbsoluteTime[], serve, ungated = False},
    numFactor = Times @@ Cases[intg, _?(NumericQ[N[#]] && FreeQ[#, Alternatives @@ vrs] &), {1}];
    If[PossibleZeroQ[numFactor] || ! FreeQ[numFactor, Alternatives @@ vrs], numFactor = 1];
    normalised = intg/numFactor;
    serve[v_, how_] := (WriteString["stdout", "    [BWS] EXACT value served (" <> how <> "): " <> ToString[v, InputForm] <> "\n"];
      numFactor v);
    (* construction A: BWS *)
    Global`$bwsLastOrder = {}; Global`$bwsUngatedReg = False; ungated = False;
    r = Quiet@CheckAbort[TimeConstrained[Global`bwsClose[normalised, ctr, vrs], bwsCloseCap[vrs], $Failed], $Failed];   (* 08:30: a raised 4-fold needs hours *)
    If[bwsExactQ[r, vrs], vA = bwsCanonExact[r]; ordA = Global`$bwsLastOrder; ungated = TrueQ[Global`$bwsUngatedReg];
      bwsLog["construction A (BWS, order ", ordA, "): ", vA, "  (", Round[AbsoluteTime[] - t0], " s)", If[ungated, "  [built on an UNGATED regularized cube]", ""]],
      bwsLog["construction A (BWS) refused (", Round[AbsoluteTime[] - t0], " s)"]];
    (* construction B: the best-ranked OTHER BWS elimination order first (2026-09-05: for pure-Gamma pieces as well --
       on the degenerate-pairing family the dispatcher's EngineN value is wrong and the decision then rests on the
       quadrature alone); the original dispatcher only when no other order closes *)
    If[vA =!= $Failed,
      Global`$bwsUngatedReg = False;
      r = Quiet@CheckAbort[TimeConstrained[Global`bwsClose[normalised, ctr, vrs, "Exclude" -> ordA], bwsCloseCap[vrs], $Failed], $Failed];
      If[bwsExactQ[r, vrs] && Global`$bwsLastOrder =!= ordA, vB = bwsCanonExact[r]; tagB = "BWS-otherorder"; ungated = ungated || TrueQ[Global`$bwsUngatedReg];
        bwsLog["construction B (BWS, order ", Global`$bwsLastOrder, "): ", vB, "  (", Round[AbsoluteTime[] - t0], " s)", If[TrueQ[Global`$bwsUngatedReg], "  [built on an UNGATED regularized cube]", ""]]]];
    If[vB === $Failed,
      r = bwsOrigTry[normalised, ctr, vrs, 1200];
      If[r =!= $Failed && bwsExactQ[r[[1]], vrs], vB = bwsCanonExact[r[[1]]]; tagB = r[[2]];
        bwsLog["construction B (dispatcher ", tagB, "): ", vB, "  (", Round[AbsoluteTime[] - t0], " s)"],
        bwsLog["construction B (dispatcher) refused (", Round[AbsoluteTime[] - t0], " s)"]]];
    If[vA === $Failed && vB === $Failed, bwsLog["exact engine ladder refused"]; Return[$Failed, Module]];
    (* decision *)
    If[vA =!= $Failed && vB =!= $Failed,
      If[bwsSameExactQ[vA, vB],
        If[tagB === "BWS-otherorder",
          q = bwsLooseQuad[normalised, ctr, vrs];
          If[NumericQ[q] && ! bwsAgreeQ[vA, q],
            bwsLog["two BWS orders agree but the cheap quadrature (", q, ") does not -> escalation quadrature"];
            q2 = bwsBetterQuad[normalised, ctr, vrs];
            If[bwsAgreeTightQ[vA, q2],
              Return[serve[vA, "two BWS elimination orders agree, escalation quadrature " <> ToString[q2] <> " confirms"], Module]];
            (* 2026-09-06 06:40 (MB12 rungs-only regression, e^-1 MISMATCH): on a 4-fold pure-Gamma piece the two
               orders agreed on Pi^4/180 (the value the earlier run had served with "quadrature unavailable") but the
               cheap quadrature returned 0.4957 and the escalation quadrature -0.3431 -- mutually INCONSISTENT, i.e.
               the numerics are ill-conditioned on this piece; the refusal sent it to the sealed ladder, which served
               7 Pi^4/180 under the same unreliable quadrature.  Quadratures that contradict each other are no
               arbiter: the agreement of two structurally different exact constructions is served, as it is when the
               quadrature is unavailable; the refused agreement is kept as a candidate against the sealed ladder. *)
            If[! (NumericQ[q2] && Abs[q - q2] <= 10^-2 (1 + Abs[q2])),
              Return[serve[vA, "two BWS elimination orders agree; the quadratures (" <> ToString[q] <> ", " <> ToString[q2] <>
                ") contradict each other and cannot arbitrate"], Module]];
            Global`$bwsExactFirstCandidate = vA;
            bwsLog["*** two BWS orders agree but neither quadrature (", q, ", ", q2, ") does -> NOT served (candidate kept) ***"]; Return[$Failed, Module]];
          (* 2026-09-15: a value built on an UNGATED regularized cube (its cube quadrature failed) needs the piece
             quadrature: agreement of two orders is not enough when the finite parts of both are unverified *)
          If[ungated && ! NumericQ[q],
            q2 = bwsBetterQuad[normalised, ctr, vrs];
            If[bwsAgreeTightQ[vA, q2],
              Return[serve[vA, "two BWS elimination orders agree (ungated regularized cube), escalation quadrature " <> ToString[q2] <> " confirms"], Module]];
            bwsLog["two BWS orders agree on a value built on an ungated regularized cube, but no quadrature confirms it -> NOT served"]; Return[$Failed, Module]];
          Return[serve[vA, "two BWS elimination orders agree" <> If[NumericQ[q], ", quadrature " <> ToString[q] <> " confirms", ", quadrature unavailable"]], Module]];
        If[ungated,
          q = bwsLooseQuad[normalised, ctr, vrs];
          If[! bwsAgreeQ[vA, q], q2 = bwsBetterQuad[normalised, ctr, vrs];
            If[! bwsAgreeTightQ[vA, q2],
              bwsLog["BWS (ungated regularized cube) and ", tagB, " agree, but no quadrature confirms -> NOT served"]; Return[$Failed, Module]]]];
        Return[serve[vA, "BWS and " <> ToString[tagB] <> " agree exactly"], Module]];
      q = bwsLooseQuad[normalised, ctr, vrs];
      bwsLog["*** constructions DISAGREE: BWS ", vA, " (", N[vA, 12], ") vs ", tagB, " ", vB, " (", N[vB, 12], "); cheap quadrature ", q, " ***"];
      Which[bwsAgreeQ[vA, q] && ! bwsAgreeQ[vB, q], Return[serve[vA, "BWS confirmed by the quadrature against " <> ToString[tagB]], Module],
            bwsAgreeQ[vB, q] && ! bwsAgreeQ[vA, q], Return[serve[vB, ToString[tagB] <> " confirmed by the quadrature against BWS"], Module]];
      bwsLog["cheap quadrature cannot arbitrate -> escalation quadrature"];
      q2 = bwsBetterQuad[normalised, ctr, vrs];
      Which[bwsAgreeTightQ[vA, q2] && ! bwsAgreeTightQ[vB, q2], Return[serve[vA, "BWS confirmed by the escalation quadrature " <> ToString[q2] <> " against " <> ToString[tagB]], Module],
            bwsAgreeTightQ[vB, q2] && ! bwsAgreeTightQ[vA, q2], Return[serve[vB, ToString[tagB] <> " confirmed by the escalation quadrature " <> ToString[q2] <> " against BWS"], Module],
            True, bwsLog["quadratures cannot arbitrate -> NOT served (fail-closed)"]; Return[$Failed, Module]]];
    (* a single exact construction: quadrature-gated (cheap first, escalation second) *)
    q = bwsLooseQuad[normalised, ctr, vrs];
    If[vA =!= $Failed && bwsAgreeQ[vA, q], Return[serve[vA, "single BWS construction + cheap quadrature " <> ToString[q]], Module]];
    If[vB =!= $Failed && bwsAgreeQ[vB, q], Return[serve[vB, "single " <> ToString[tagB] <> " construction + cheap quadrature " <> ToString[q]], Module]];
    bwsLog["single construction not confirmed by the cheap quadrature (", q, ") -> escalation quadrature"];
    q2 = bwsBetterQuad[normalised, ctr, vrs];
    If[vA =!= $Failed && bwsAgreeTightQ[vA, q2], Return[serve[vA, "single BWS construction + escalation quadrature " <> ToString[q2]], Module]];
    If[vB =!= $Failed && bwsAgreeTightQ[vB, q2], Return[serve[vB, "single " <> ToString[tagB] <> " construction + escalation quadrature " <> ToString[q2]], Module]];
    bwsLog["single construction not confirmed by either quadrature (", q, ", ", q2, ") -> NOT served (fail-closed)"];
    $Failed];
  (* ---- CLASS C (2026-09-05, MB13 piece 15): a polygamma whose argument has an integer slope |k| >= 2 in a variable.
     psi DUPLICATION / multiplication formula  psi^(m)(k x) = delta_{m0} log k + k^(-m-1) Sum_{j=0}^{k-1} psi^(m)(x + j/k)
     splits the piece into unit-slope pieces: the log-k part (pure Gamma) goes to the sealed ladder, the psi parts to
     the BWS engine (the sealed harmonic-sums fast path served a half-integer-offset psi one-fold WRONG without its
     quadrature gate).  Every part exact; a one-variable psi part has a single elimination order, so it is gated by a
     PG-8 one-fold contour quadrature at 1e-6 (cheap and reliable for one-folds; the benchmark assembly arbitrates). *)
  bwsPsiMultQ[intg_, vrs_] := ! FreeQ[intg, PolyGamma] &&
    Cases[intg, PolyGamma[_Integer, a_] /; ! FreeQ[a, Alternatives @@ vrs] &&
        AnyTrue[vrs, IntegerQ[Coefficient[a, #]] && Abs[Coefficient[a, #]] >= 2 &], {0, Infinity}] =!= {};
  bwsPsiMultSplit[intg_, vrs_] := Module[{ps, pg, m, L, coefs, k, x, pure},
    ps = DeleteDuplicates@Cases[intg, PolyGamma[_Integer, a_] /; ! FreeQ[a, Alternatives @@ vrs] &&
        AnyTrue[vrs, IntegerQ[Coefficient[a, #]] && Abs[Coefficient[a, #]] >= 2 &], {0, Infinity}];
    If[Length[ps] =!= 1, Return[$Failed]];
    pg = First[ps]; {m, L} = List @@ pg;
    coefs = DeleteCases[Coefficient[L, #] & /@ vrs, 0];
    If[! AllTrue[coefs, IntegerQ], Return[$Failed]];
    k = GCD @@ coefs; If[k < 2, Return[$Failed]];
    x = Expand[L/k]; pure = intg /. pg -> 1;
    Join[If[m == 0, {Log[k] pure}, {}], Table[k^(-m - 1) pure PolyGamma[m, x + j/k], {j, 0, k - 1}]]];
  bwsQuad1[ig_, ctr_, v_] := Quiet@TimeConstrained[NIntegrate[Re[ig /. v -> (v /. ctr) + I Global`bwsTQ]/(2 Pi),
      {Global`bwsTQ, -40, 40}, WorkingPrecision -> 30, PrecisionGoal -> 8, MaxRecursion -> 14], 180, $Failed];
  bwsPsiMultClose[intg_, ctr_, vrs_] := Module[{parts, vals = {}, n0 = Length[MBtoMPL`Private`$mbtFailedPieces], v, q, tot, v2},
    (* 2026-09-05: FIRST the BWS engine on the whole piece -- an integer-slope psi argument is just a kinematic power
       of slope |k| for the elimination kernels (the quadratic letter it leaves is integrated last, see bwsIVFCert);
       one-folds are gated by the one-fold quadrature at 1e-6, multi-folds by a second elimination order *)
    v = Quiet@CheckAbort[TimeConstrained[Global`bwsClose[intg, ctr, vrs], 1200, $Failed], $Failed];
    If[bwsExactQ[v, vrs],
      If[Length[vrs] === 1,
        q = bwsQuad1[intg, ctr, First[vrs]];
        If[NumericQ[q] && Abs[N[v, 20] - q] <= 10^-6 (1 + Abs[q]),
          WriteString["stdout", "    [BWS] EXACT value served (slope-|k| psi one-fold: BWS engine + one-fold quadrature " <>
            ToString[q] <> "): " <> ToString[v, InputForm] <> "\n"]; Return[v, Module],
          bwsLog["BWS value ", v, " NOT confirmed by the one-fold quadrature ", q, " -> multiplication route"]],
        v2 = Quiet@CheckAbort[TimeConstrained[Global`bwsClose[intg, ctr, vrs, "Exclude" -> Global`$bwsLastOrder], 1200, $Failed], $Failed];
        If[bwsExactQ[v2, vrs] && bwsSameExactQ[v, v2],
          WriteString["stdout", "    [BWS] EXACT value served (slope-|k| psi multi-fold: two BWS elimination orders agree): " <>
            ToString[v, InputForm] <> "\n"]; Return[v, Module],
          bwsLog["BWS value ", v, " has no agreeing second elimination order -> multiplication route"]]],
      bwsLog["BWS engine refused the slope-|k| psi piece directly -> multiplication route"]];
    parts = bwsPsiMultSplit[intg, vrs];
    If[parts === $Failed, Return[$Failed]];
    bwsLog["psi multiplication formula: ", Length[parts], " unit-slope part(s)"];
    Do[If[FreeQ[part, PolyGamma],
        v = bwsOrigCall[part, ctr, vrs];
        If[Length[MBtoMPL`Private`$mbtFailedPieces] > n0 || ! MBtoMPL`Private`mbtCleanNumQ[v, vrs] || ! bwsExactQ[v, vrs],
          MBtoMPL`Private`$mbtFailedPieces = Take[MBtoMPL`Private`$mbtFailedPieces, n0];
          bwsLog["pure part refused by the sealed ladder"]; Return[$Failed, Module]];
        bwsLog["pure part (sealed ladder): ", v],
        v = Quiet@CheckAbort[TimeConstrained[Global`bwsClose[part, ctr, vrs], 1200, $Failed], $Failed];
        If[! bwsExactQ[v, vrs], bwsLog["psi part refused by the BWS engine"]; Return[$Failed, Module]];
        If[Length[vrs] === 1,
          q = bwsQuad1[part, ctr, First[vrs]];
          If[! (NumericQ[q] && Abs[N[v, 20] - q] <= 10^-6 (1 + Abs[q])),
            bwsLog["psi part ", v, " NOT confirmed by the one-fold quadrature ", q, " -> refused"]; Return[$Failed, Module]]];
        bwsLog["psi part (BWS): ", v]];
      AppendTo[vals, v], {part, parts}];
    tot = Simplify[Total[vals]];
    WriteString["stdout", "    [BWS] EXACT value served via the psi multiplication formula: " <> ToString[tot, InputForm] <> "\n"];
    tot];
  (* ---- NEAR-POLE CONTOUR SHIFT (2026-09-05, MB11 fresh audit) ----
     MBresolve / the regulated continuation may place a contour within 1e-3 of a pole of the piece (MB11: the 23-piece
     block at z27 = -0.99950, 5e-4 from the pole at -1).  Every closer of the sealed ladder is gated by a same-contour
     quadrature, and such a quadrature is ill-conditioned there (the PinchLin oracle read -993226 against the value
     -0.36), so every exact closure is refused and the piece is ledgered.  The value of an eps-free Barnes piece is
     independent of the contour inside the pole-free strip that contains it (Cauchy; balanced Gamma products decay
     exponentially on vertical lines), so the piece is evaluated at the MIDPOINT of that strip: an exact identity, no
     residue enters.  Poles in v: numerator Gamma and polygamma arguments at non-positive integers and the zeros of
     the rational denominators, the other variables held at their contour values.  Applied once per piece. *)
  bwsRealPoles[intg_, ctr_, vrs_, v_] := Module[{fac, sub, args = {}, rats = {}, ps = {}, sg, a0},
    sub = Select[ctr, MemberQ[DeleteCases[vrs, v], First[#]] &];
    fac = If[Head[intg] === Times, List @@ intg, {intg}];
    Do[Which[
       MatchQ[f, Gamma[_]] && ! FreeQ[f, v], AppendTo[args, f[[1]]],
       MatchQ[f, Power[Gamma[_], _Integer?Positive]] && ! FreeQ[f, v], AppendTo[args, f[[1, 1]]],
       MatchQ[f, PolyGamma[_Integer, _]] && ! FreeQ[f, v], AppendTo[args, f[[2]]],
       (* a polygamma POWER was invisible to this scan: the strip was computed without the psi poles and the "exact"
          shift landed on a pole (development fix of 17 September; ported 1 October after the staging run moved
          z -> -3/2 onto the double pole of psi(2+2z)^2) *)
       MatchQ[f, Power[PolyGamma[_Integer, _], _Integer?Positive]] && ! FreeQ[f, v], AppendTo[args, f[[1, 2]]],
       MatchQ[f, Power[_, _Integer?Negative]] && PolynomialQ[f[[1]], v] && ! FreeQ[f, v],
         rats = Join[rats, Select[FactorList[f[[1]]][[All, 1]], ! FreeQ[#, v] &]]], {f, fac}];
    Do[sg = Coefficient[a, v]; a0 = (a /. v -> 0) /. sub;
       If[NumericQ[sg] && sg != 0 && NumericQ[a0] && bwsAffineQ[a, {v}],
         ps = Join[ps, Table[(-n - a0)/sg, {n, 0, 40}]]], {a, DeleteDuplicates[args]}];
    Do[If[PolynomialQ[r, v] && Exponent[r, v] === 1,
         With[{root = (-(r /. v -> 0)/Coefficient[r, v]) /. sub}, If[NumericQ[root], AppendTo[ps, root]]]], {r, rats}];
    Sort[DeleteDuplicates[Select[N[ps, 30], NumericQ[#] && Im[#] == 0 &] // Re]]];
  bwsNearPoleShift[intg_, ctr_, vrs_] := Module[{ctr2 = ctr},
    Do[Module[{c = v /. ctr2, ps, near, left, right, cT, width},
       If[! NumericQ[c] || ! FreeQ[c, Complex], Continue[]];
       ps = Quiet@Check[bwsRealPoles[intg, ctr2, vrs, v], {}];
       If[ps === {}, Continue[]];
       near = Min[Abs[ps - N[c, 30]]];
       left = Select[ps, # < c &]; right = Select[ps, # > c &];
       (* 2026-09-06 08:30 (MB8b 0616/0618): RELATIVE criterion -- the contour must lie in the CENTRAL HALF of its
          pole-free strip in every variable (0616: z321 sat 0.077 from the wall z321 = -z7 of a 0.84-wide strip, the
          leg Gamma(z321+z7) had Re 0.077, its kinematic power t^(0.077-1) made every Euler cube divergent; 0618:
          Gamma(z611+z8) at Re 0.054).  Exact by analyticity, as before.  The absolute 1/50 stays for narrow strips. *)
       width = If[left =!= {} && right =!= {}, Min[right] - Max[left], Infinity];
       If[near >= 1/50 && If[width === Infinity, near >= 1/4, near >= width/4], Continue[]];
       cT = Which[left =!= {} && right =!= {}, (Max[left] + Min[right])/2, left =!= {}, Max[left] + 1/2, True, Min[right] - 1/2];
       cT = Rationalize[cT, 10^-12];
       If[Min[Abs[ps - N[cT, 30]]] > near, ctr2 = ctr2 /. (v -> c) -> (v -> cT)]], {v, vrs}];
    ctr2];
  MBtoMPL`Private`mbtCachedMB2MPL[intg_, ctr_List, vrs_List] /; ! TrueQ[Global`$bwsInOrig] := Module[
    {n0 = Length[MBtoMPL`Private`$mbtFailedPieces], v, ex, pre, envMin, twoVar, classC, rec, nf = 1, key = None, dh = None, dv, tried = False, ctrS, bprVal = $Failed},
    (* the shift is applied once: the re-entrant call below runs this same wrap (exact-first classes, guard) at the
       shifted contour with the flag set, so no second shift is attempted *)
    ctrS = If[TrueQ[Global`$bwsShifting], ctr, Quiet@Check[bwsNearPoleShift[intg, ctr, vrs], ctr]];
    If[ctrS =!= ctr,
      bwsLog["near-pole contour ", ctr, " -> ", ctrS, " (midpoint of the pole-free strip; exact by analyticity)"];
      (* the certified library is keyed by the ORIGINAL contour: query it first *)
      If[TrueQ[MBtoMPL`Private`$mbtUseCertifiedLibrary] && DownValues[MBStandardLibrary`MBStdLibQueryPiece] =!= {},
        rec = Quiet@MBStandardLibrary`MBStdLibQueryPiece[intg, ctr, vrs];
        If[AssociationQ[rec],
          If[! IntegerQ[MBtoMPL`Private`$mbtLearnedPieceHits], MBtoMPL`Private`$mbtLearnedPieceHits = 0];
          MBtoMPL`Private`$mbtLearnedPieceHits++;
          Return[bwsServe[bwsGNumericClean[rec["Value"]], "certified-library", intg, ctr, vrs, n0, False], Module]]];
      Return[Block[{Global`$bwsShifting = True}, MBtoMPL`Private`mbtCachedMB2MPL[intg, ctrS, vrs]], Module]];
    classC = TrueQ[bwsPsiMultQ[intg, vrs]];
    envMin = With[{e = Environment["BWS_SKIP_SEALED_MINVARS"]},
      If[StringQ[e] && IntegerQ[Quiet@ToExpression[e]], ToExpression[e], Infinity]];
    twoVar = Length[vrs] >= 2 && TrueQ[bwsTwoVarPsiQ[intg, vrs]];
    (* 2026-09-05 (MB13): two more classes the sealed ladder cannot close and on which its EngineN path served WRONG
       values -- multi-fold pieces with a DEGENERATE pairing Gamma(x)Gamma(-x) / Gamma(-1-x)Gamma(1+x) in some
       variable, and pieces with a Gamma leg of slope |k| >= 2 -- go exact-first as well *)
    pre = twoVar || (Length[vrs] >= 4 && FreeQ[intg, PolyGamma]) || Length[vrs] >= envMin ||
      (Length[vrs] >= 2 && TrueQ[Quiet@bwsDegenerateQ[intg, vrs]]) || TrueQ[Quiet@bwsSlopeQ[intg, vrs]] ||
      (Length[vrs] >= 2 && TrueQ[Global`$bwsExactFirstForce]);   (* 2026-09-15: sub-pieces of a class-handler reduction *)
    (* 2026-09-06 09:20 BARNES-LEMMA PRE-REDUCTION (mbeBarnesPreReduce.m; MB8b pieces 0616/0618): a >= 3-fold piece in
       which some variable carries exactly two left-going and two right-going unit-slope legs (denominator legs at an
       integer distance from a numerator leg become polynomials, absorbed by the Newton expansion) is integrated in
       that variable EXACTLY by Barnes' first lemma, recursively; the reduced pieces (0616: two 2-folds, 0618: one
       2-fold, from a 3-fold and a 4-fold whose 7-8-dimensional Euler cubes were refused as divergent for hours) go
       through this same evaluator, with all its gates, and their exact values are summed.  A refused reduced piece
       leaves the ledger entry, so the sum is never served silently. *)
    (* 2026-09-06 10:15: the served value is returned from THIS Module (a Return[.., Module] inside the hook's own
       Module left only the hook, and the wrap went on to the other ladders -- the trap of 2026-09-05 17:15 again);
       a refused reduced piece abandons the pre-reduction (its ledger entries are dropped) and the piece continues
       on its own path, so a refusal costs nothing but time and never serves a partial sum. *)
    If[Length[vrs] >= 3 && DownValues[Global`mbeBarnesPreReduce] =!= {},
      Module[{red = Quiet@Check[Global`mbeBarnesPreReduce[intg, vrs, ctr], $Failed], tot = 0, sub, ctrSub},
        If[ListQ[red] && red =!= {} && AllTrue[red, Length[#[[2]]] < Length[vrs] &],
          bwsLog["Barnes-lemma pre-reduction: ", Length[vrs], "-fold -> ", Length[red], " piece(s) of ",
            DeleteDuplicates[Length /@ red[[All, 2]]], " variable(s)"];
          Do[If[t[[2]] === {}, sub = Simplify[t[[1]]],
               ctrSub = Select[ctr, MemberQ[t[[2]], First[#]] &];
               sub = MBtoMPL`Private`mbtCachedMB2MPL[t[[1]], ctrSub, t[[2]]]];
             tot += sub, {t, red}];
          If[Length[MBtoMPL`Private`$mbtFailedPieces] > n0,
            bwsLog["a reduced piece was refused -> the pre-reduction is abandoned (its ledger entries dropped); the piece continues on its own path"];
            MBtoMPL`Private`$mbtFailedPieces = Take[MBtoMPL`Private`$mbtFailedPieces, n0],
            WriteString["stdout", "    [BWS] EXACT value served (Barnes-lemma pre-reduction, " <> ToString[Length[red]] <>
              " reduced piece(s)): " <> ToString[Simplify[tot], InputForm] <> "\n"];
            bprVal = bwsServe[Simplify[tot], "barnes-prereduction", intg, ctr, vrs, n0, True]]]]];
    If[bprVal =!= $Failed, Return[bprVal, Module]];
    (* 2026-09-15 (MB14b pieces 0245/0247/0248; mbeBarnes2PsiReduce.m): a polygamma on a leg of a Barnes-SECOND-lemma
       pattern in some variable is rewritten EXACTLY as the polygamma of a partner leg (an argument in that variable
       alone where possible: such pieces close in the recursion, the two-variable ones refuse every cube) plus the
       delta-derivative of the lemma with its crossed-pole corrections, pieces in one variable fewer.  No integral
       representation, no raise: valid for any real part of the argument.  Candidates (partners) are tried in turn;
       every sub-piece goes through this same evaluator with all its gates; a refused sub-piece abandons the
       candidate (its ledger entries dropped).  Not re-entered from inside its own sub-pieces. *)
    If[Length[vrs] >= 2 && ! FreeQ[intg, PolyGamma] && DownValues[Global`mbeBarnes2PsiReduce] =!= {} && ! TrueQ[Global`$mbeB2PActive],
      Module[{cands = Block[{Global`$mbeB2PVerbose = True}, Quiet@Check[Global`mbeBarnes2PsiReduce[intg, vrs, ctr], $Failed]], tot, sub, ctrSub, k = 0},
        If[ListQ[cands] && cands =!= {},
          Do[If[bprVal === $Failed && k < 3, k++;
             bwsLog["Barnes second lemma with a psi difference (candidate ", k, " of ", Length[cands], "): partner ",
               Cases[cand[[1, 1]], PolyGamma[0, x_] :> x, {0, Infinity}], " + ", Length[cand] - 1, " piece(s) in ", cand[[2, 2]]];
             tot = 0;
             (* the sub-pieces go exact-first (the partner 3-fold of piece 0245, a single-variable psi on a kernel
                without a slope-2 leg, would otherwise spend the sealed ladder's numerical budget first); the sealed
                ladder remains their fallback *)
             Block[{Global`$mbeB2PActive = True, Global`$bwsExactFirstForce = True},
               Do[If[Length[MBtoMPL`Private`$mbtFailedPieces] > n0, Break[]];
                  If[t[[2]] === {}, sub = Simplify[t[[1]]],
                    ctrSub = Select[ctr, MemberQ[t[[2]], First[#]] &];
                    sub = MBtoMPL`Private`mbtCachedMB2MPL[t[[1]], ctrSub, t[[2]]]];
                  tot += sub, {t, cand}]];
             If[Length[MBtoMPL`Private`$mbtFailedPieces] > n0,
               bwsLog["a sub-piece of candidate ", k, " was refused -> candidate abandoned (its ledger entries dropped)"];
               MBtoMPL`Private`$mbtFailedPieces = Take[MBtoMPL`Private`$mbtFailedPieces, n0],
               WriteString["stdout", "    [BWS] EXACT value served (Barnes second lemma with a psi difference, partner + " <>
                 ToString[Length[cand] - 1] <> " reduced piece(s)): " <> ToString[Simplify[tot], InputForm] <> "\n"];
               bprVal = bwsServe[Simplify[tot], "barnes2psi", intg, ctr, vrs, n0, True]]], {cand, cands}]]]];
    If[bprVal =!= $Failed, Return[bprVal, Module]];
    (* pieces the sealed ladder handles as before go straight to it; the only change for them is the numeric-argument
       G cleanup of PART E on the served value (certified-library records of the s61 closures carry G[0, 2] = Log[2]
       unevaluated, which the worker's cleanliness test rejects although the value is exact and right) *)
    If[! classC && ! pre, Return[bwsServe[bwsGNumericClean[bwsOrigCall[intg, ctr, vrs]], "sealed-ladder", intg, ctr, vrs, n0, False], Module]];
    (* exact-first classes: the CERTIFIED LIBRARY and the caches come first (the sealed evaluator's own first steps;
       without this a library piece of MB3/MB6/MB10/MB11 with a degenerate pairing would spend minutes in the
       exact ladder before its certified value was even looked up) *)
    If[TrueQ[MBtoMPL`Private`$mbtUseCertifiedLibrary] && DownValues[MBStandardLibrary`MBStdLibQueryPiece] =!= {},
      rec = Quiet@MBStandardLibrary`MBStdLibQueryPiece[intg, ctr, vrs];
      If[AssociationQ[rec],
        If[! IntegerQ[MBtoMPL`Private`$mbtLearnedPieceHits], MBtoMPL`Private`$mbtLearnedPieceHits = 0];
        MBtoMPL`Private`$mbtLearnedPieceHits++;
        Return[bwsServe[bwsGNumericClean[rec["Value"]], "certified-library", intg, ctr, vrs, n0, False], Module]]];
    {nf, key, dh} = Quiet@Check[bwsCacheKey[intg, ctr, vrs], {1, None, None}];
    If[key =!= None && AssociationQ[MBtoMPL`Private`$mbtMB2MPLCache] && KeyExistsQ[MBtoMPL`Private`$mbtMB2MPLCache, key],
      MBtoMPL`Private`$mbtCacheHits++; Return[nf MBtoMPL`Private`$mbtMB2MPLCache[key], Module]];
    If[key =!= None,
      dv = Quiet@Check[MBtoMPL`Private`mbtMB2MPLDiskGet[dh], $Failed];
      If[dv =!= $Failed && ! PossibleZeroQ[dv] && bwsExactQ[dv, vrs],
        MBtoMPL`Private`$mbtCacheHits++; MBtoMPL`Private`$mbtMB2MPLCache[key] = dv; Return[nf dv, Module]]];
    (* CLASS C first: slope-|k|>=2 polygamma argument -> multiplication formula *)
    If[classC,
      bwsLog["exact-first: polygamma with an integer slope >= 2 (class C) -> multiplication formula"];
      ex = bwsPsiMultClose[intg, ctr, vrs];
      If[ex =!= $Failed, bwsCacheStore[key, nf, dh, ex]; Return[ex, Module]];
      bwsLog["multiplication-formula route refused; sealed ladder next"]];
    (* EXACT-FIRST policy (user, 2026-09-04: the method must not spend its time in numerical searches).  Pieces of a
       class the sealed ladder provably cannot close -- a polygamma whose argument depends on >= 2 MB variables -- or
       is known to refuse only after exhausting its numerical attempts -- pure-Gamma pieces of >= 4 variables, and
       pieces of >= BWS_SKIP_SEALED_MINVARS variables when that env knob is set -- go to the exact two-construction
       ladder FIRST (seconds to minutes); the sealed ladder runs only if that refuses.  Every other piece keeps the
       sealed ladder first and the exact ladder after a failure. *)
    If[pre,
      bwsLog["exact-first: ", Length[vrs], "-fold piece of an exact-ladder class (",
        Which[twoVar, "multi-variable polygamma argument", TrueQ[Quiet@bwsSlopeQ[intg, vrs]], "slope >= 2 Gamma leg",
          TrueQ[Quiet@bwsDegenerateQ[intg, vrs]], "degenerate Gamma pairing", True, "pure-Gamma multi-fold"], ")"];
      Global`$bwsExactFirstCandidate = None;
      ex = bwsExactLadder[intg, ctr, vrs]; tried = True;
      If[ex =!= $Failed, bwsCacheStore[key, nf, dh, ex]; Return[ex, Module]];
      bwsLog["exact-first ladder refused; sealed ladder next"]];
    v = bwsOrigCall[intg, ctr, vrs];
    (* 2026-09-06 06:40: a sealed value that CONTRADICTS a two-construction agreement refused only by its quadratures
       is not served -- the piece is ledgered (fail-closed) so that the disagreement is visible in the run instead
       of a wrong exact value entering the assembly (MB12 e^-1: 7 Pi^4/180 against the agreement Pi^4/180). *)
    If[pre && Global`$bwsExactFirstCandidate =!= None && bwsExactQ[v, vrs] && ! bwsSameExactQ[v, Global`$bwsExactFirstCandidate],
      bwsLog["*** sealed ladder value ", v, " CONTRADICTS the refused two-construction agreement ", Global`$bwsExactFirstCandidate, " -> ledgered, not served ***"];
      AppendTo[MBtoMPL`Private`$mbtFailedPieces,
        <|"reason" -> "sealed-vs-agreement-disagree", "vars" -> vrs, "normalised" -> Short[intg, 3],
          "sealed" -> v, "agreement" -> Global`$bwsExactFirstCandidate|>]];
    Global`$bwsExactFirstCandidate = None;
    If[! pre && Length[vrs] >= 2 && Length[MBtoMPL`Private`$mbtFailedPieces] > n0,
      bwsLog["sealed ladder failed a ", Length[vrs], "-fold piece; exact engine ladder with method-independence gate"];
      ex = bwsExactLadder[intg, ctr, vrs]; tried = True;
      If[ex =!= $Failed,
        MBtoMPL`Private`$mbtFailedPieces = Take[MBtoMPL`Private`$mbtFailedPieces, n0];
        bwsCacheStore[key, nf, dh, ex];
        Return[ex, Module]]];
    bwsServe[bwsGNumericClean[v], "sealed-ladder", intg, ctr, vrs, n0, tried, key, nf, dh]];
  (* 2026-09-05 NO-SERVED-FLOATS GUARD (class-general; MB3 fresh audit): the sealed evaluator's cleanliness test
     accepts any value that N[] can evaluate, so a closer that returns an arbitrary-precision NUMBER (a Complex atom
     is even invisible to a _Real test) is served as "Clean" and the assembled order is verified numerically but is
     not exact (MB3 e^0: coefficient = -119.13...`21 + 2181.2...`37 I).  Every served value now passes this guard:
     an inexact value of a >= 2-fold piece is offered to the exact two-construction ladder (unless that already
     refused it); if no exact value exists the piece is LEDGERED (reason "inexact-served(<stage>)") so the run is
     marked incomplete instead of carrying a float. *)
  bwsInexactQ[e_] := Cases[e, q_?NumberQ /; Precision[Unevaluated[q]] =!= Infinity :> q, {0, Infinity}, Heads -> True] =!= {};
  (* 2026-09-06 03:10 (MB8a piece 1058: -54 Gamma(2-z)Gamma(-z)Gamma(z)Gamma(1+z) psi(2-z)^2 at e^-3 -- the sealed
     one-fold ladder served a 19-digit FLOAT and the guard ledgered it, aborting the route): a ONE-fold polygamma piece
     whose sealed value is inexact is offered to the BWS engine (two-scale subset sum: 9(-21 + 18 gamma^2 + 5 pi^2
     - 2 gamma(3 + 2 pi^2))/2 in 7 s, equal to the float's 19 digits), gated by the one-fold contour quadrature at
     1e-6 -- the same policy as the slope-|k| one-fold path above. *)
  bwsOneFoldExact[intg_, ctr_, vrs_] := Module[{v, q},
    v = Quiet@CheckAbort[TimeConstrained[Global`bwsClose[intg, ctr, vrs], 1200, $Failed], $Failed];
    If[! bwsExactQ[v, vrs], bwsLog["BWS engine refused the one-fold psi piece"]; Return[$Failed]];
    q = bwsQuad1[intg, ctr, First[vrs]];
    If[NumericQ[q] && Abs[N[v, 20] - q] <= 10^-6 (1 + Abs[q]),
      WriteString["stdout", "    [BWS] EXACT value served (one-fold psi piece after an inexact sealed value: BWS engine + one-fold quadrature " <>
        ToString[q] <> "): " <> ToString[v, InputForm] <> "\n"]; v,
      bwsLog["BWS one-fold value ", v, " NOT confirmed by the one-fold quadrature ", q, " -> refused"]; $Failed]];
  bwsServe[v0_, stage_String, intg_, ctr_, vrs_, n0_, tried_, key_:None, nf_:1, dh_:None] := Module[{ex, v},
    v = bwsPrimeLog[v0];   (* 18:40: every served value in the prime-log canonical form (exact identity) *)
    If[! bwsInexactQ[v], Return[v, Module]];
    bwsLog["INEXACT value served by the ", stage, " for a ", Length[vrs], "-fold piece (precision ",
      ToString[Quiet@N[Precision[v], 4]], "); NO SERVED FLOATS -> ", If[! tried && Length[vrs] >= 2, "exact ladder",
        If[! tried && Length[vrs] === 1 && ! FreeQ[intg, PolyGamma], "BWS one-fold engine", "ledgered"]]];
    If[! tried && Length[vrs] >= 2,
      ex = bwsExactLadder[intg, ctr, vrs];
      If[ex =!= $Failed,
        MBtoMPL`Private`$mbtFailedPieces = Take[MBtoMPL`Private`$mbtFailedPieces, n0];
        If[key =!= None, bwsCacheStore[key, nf, dh, ex]];
        Return[ex, Module]]];
    If[! tried && Length[vrs] === 1 && ! FreeQ[intg, PolyGamma],
      ex = bwsOneFoldExact[intg, ctr, vrs];
      If[ex =!= $Failed,
        MBtoMPL`Private`$mbtFailedPieces = Take[MBtoMPL`Private`$mbtFailedPieces, n0];
        If[key =!= None, bwsCacheStore[key, nf, dh, ex]];
        Return[ex, Module]]];
    AppendTo[MBtoMPL`Private`$mbtFailedPieces,
      <|"reason" -> "inexact-served(" <> stage <> ")", "vars" -> vrs, "normalised" -> Short[intg, 3],
        "precision" -> Precision[v]|>];
    v];
  WriteString["stdout", "[mbeTwoVarPsiRung] mbtCachedMB2MPL wrapped (persistent rule: exact-first ladder for its classes, library/caches first, two-construction gate).\n"]]];
bwsInstallCachedWrap[];

(* ===================== PART E: numeric-argument G leftovers of the word converter (2026-09-05) ===================== *)
(* gvExact (hf_machinery.m) converts HyperFLINT words to PolyLogTools G's through LiToG.  A G whose letters and endpoint
   are all NUMERIC is a constant, but PolyLogTools evaluates only its tabulated endpoints (+-1, +-I, sixth roots, low
   weight at +-1/2, +-1/3); e.g. G[0, 2] = Log[2] stays symbolic, N[...] does not evaluate it, and the piece evaluator's
   cleanliness test (NumericQ[N[value]]) then REFUSES an exact, correct value (MB11 fresh audit: pieces 136 and 183,
   both closed exactly with "(3 + G[0, 2] - Log[2])" inside, both marked Failed).  Class-general cleanup, applied to
   every consumer of gvExact by wrapping its saved definition: weight-one G's -> logarithms (exact identities),
   deeper numeric-argument G's -> the Li form (GToLi), kept only when Mathematica can evaluate it numerically. *)
bwsGNumericClean[e_] := Module[{f},
  f = e /. {HoldPattern[PolyLogTools`G[0, x_?NumericQ]] :> Log[x],
            HoldPattern[PolyLogTools`G[a_?NumericQ, x_?NumericQ]] /; a =!= 0 :> Log[1 - x/a]};
  f /. gg : HoldPattern[PolyLogTools`G[__?NumericQ]] :> Module[{li = Quiet@Check[PolyLogTools`GToLi[gg], gg]},
      If[FreeQ[li, PolyLogTools`G] && NumericQ[Quiet@N[li]], li, gg]]];
If[DownValues[Global`gvExact] =!= {} && DownValues[Global`bwsGvExactOrig] === {},
  DownValues[Global`bwsGvExactOrig] = DownValues[Global`gvExact] /. HoldPattern[Global`gvExact] -> Global`bwsGvExactOrig;
  Clear[Global`gvExact];
  Global`gvExact[e_] := bwsGNumericClean[Global`bwsGvExactOrig[e]];
  WriteString["stdout", "[mbeTwoVarPsiRung] gvExact wrapped (numeric-argument G leftovers -> Log / Li).\n"]];

(* ===================== PART D: master mop-up guard (2026-09-05) ===================== *)
(* The sealed mbtClosePiecesParallel recomputes every worker-failed or worker-missing piece SERIALLY IN THE MASTER
   with the sealed ladder.  On MB13 that mop-up killed the master (ginsh stderr flood + an escaped $Aborted in the
   PinchLin closer): no assembly, no verdict, although all 60 worker results were on disk.  This replacement keeps
   the launch/collection logic of the sealed function verbatim and changes only the mop-up:
     - a piece the worker REPORTED as failed is ledgered (reason "worker-failed") and set to 0 — the workers already
       ran the full ladder including the exact-first rung; recomputing it in the master gains nothing and risks the kernel;
     - a piece with NO r-file (worker died) is recomputed ONCE inside CheckAbort (an escaped abort ledgers it instead of
       killing the run).
   Fail-closed as before: every 0 is ledgered and the assembly reports the incomplete orders. *)
(* 2026-09-08 (user): RESOURCE POLICY as the default.  The worker request Automatic means the policy budget: half of the
   licence's subkernels when the licence is large (>= 32), every subkernel it allows when it is small (a laptop),
   never more than the cores; running jobs of this user share that budget (a census of the running subkernels), and
   at least one worker is always launched.  The launcher also exports the IntVolFLINT scaling (threads per hyperflint
   process, candidates raced at once, per-candidate budget) so that the total hyperflint thread count stays near the
   cores whatever the worker count (with 64 workers racing every candidate at 4 threads the node reached load 1700
   and the pieces stalled). *)
(* MBAnalytica: an unlimited licence ($MaxLicenseSubprocesses = Infinity, e.g. a site licence) allows one subkernel
   per core; it had counted as 0, which held every run to a single worker whatever was requested *)
Global`mbtWorkerBudget[] := Module[{lic, cores = Max[1, $ProcessorCount - 1]},
  lic = Which[IntegerQ[$MaxLicenseSubprocesses], $MaxLicenseSubprocesses, $MaxLicenseSubprocesses === Infinity, cores, True, 0];
  If[! IntegerQ[Global`$mbtSubkernelBudget], Global`$mbtSubkernelBudget = If[lic >= 32, Floor[lic/2], lic]];
  If[! IntegerQ[Global`$mbtMainKernelBudget], Global`$mbtMainKernelBudget = 10];
  Max[1, Min[Global`$mbtSubkernelBudget, cores]]];
(* MBAnalytica: worker rounds.  A subkernel worker closes at most mbtWorkerPieceLimit[] pieces (MBT_WORKER_PIECES, default
   100) and exits, and fresh workers continue on the open pieces; the master closes at most mbtMasterMopupMax[] missing
   pieces itself (MBT_MASTER_MOPUP_MAX, default 4) and ledgers the rest (fail-closed). *)
Global`mbtWorkerPieceLimit[] := With[{v = Quiet[ToExpression[Environment["MBT_WORKER_PIECES"]]]}, If[IntegerQ[v] && v > 0, v, 100]];
Global`mbtMasterMopupMax[] := With[{v = Quiet[ToExpression[Environment["MBT_MASTER_MOPUP_MAX"]]]}, If[IntegerQ[v] && v >= 0, v, 4]];
Global`mbtMySubkernelCount[] := Module[{out},
  (* kernel processes only: the "sh -c" wrapper of every subkernel repeats its arguments and must not be counted *)
  out = Quiet@Check[RunProcess[{"bash", "-c", "ps -u " <> $Username <> " -o args= | grep -- '-subkernel' | grep -v '^sh -c' | grep -c -E 'WolframKernel|MathKernel'"}, "StandardOutput"], ""];
  out = Quiet@Check[ToExpression[StringTrim[out]], 0]; If[IntegerQ[out], out, 0]];
Global`mbtSubkernelCapDynamic[] := (Global`mbtWorkerBudget[]; Max[0, Global`$mbtSubkernelBudget - Global`mbtMySubkernelCount[]]);
(* this user's running MAIN kernels (kernel binaries that are not subkernels; wrappers excluded) *)
Global`mbtMyMainKernelCount[] := Module[{out},
  out = Quiet@Check[RunProcess[{"bash", "-c", "ps -u " <> $Username <> " -o args= | grep -v -- '-subkernel' | grep -v '^sh -c' | grep -v '^timeout' | grep -c '" <> MBAnalytica`Portable`KernelBinaryPattern[] <> "'"}, "StandardOutput"], "0"];
  out = Quiet@Check[ToExpression[StringTrim[out]], 0]; If[IntegerQ[out], out, 0]];
Global`mbtExportIVFScaling[nW_Integer] := Module[{running, total, budget, t, w, s},
  (* the core budget per worker counts EVERY subkernel of this user on the node (this job's new workers plus the
     workers of the other running jobs), so that two jobs sized for the whole node do not oversubscribe it together *)
  running = Global`mbtMySubkernelCount[]; total = Max[1, running + nW];
  budget = Max[1, Floor[Max[1, $ProcessorCount]/total]];
  t = Which[budget >= 16, 4, budget >= 8, 2, True, 1];
  w = Max[1, Floor[budget/t]];
  (* MBAnalytica: IVF_RACE_LIMIT caps the candidates raced at once; every hyperflint process can hold a gigabyte, and
     the race only decides which certified order finishes first, never the value *)
  With[{limit = Quiet[ToExpression[Environment["IVF_RACE_LIMIT"]]]}, If[IntegerQ[limit] && limit >= 1, w = Min[w, limit]]];
  s = Min[1800, 900 Ceiling[4/t]];
  (* one argument: a list of rules (the three-rule form is refused by SetEnvironment and set nothing) *)
  SetEnvironment[{"IVF_THREADS" -> ToString[t], "IVF_RACE_WIDTH" -> ToString[w], "IVF_SECONDS" -> ToString[s]}];
  Global`$mbtIVFScaling = {t, w, s};   (* handed to subkernel workers through ParallelEvaluate (they do not inherit the environment) *)
  WriteString["stdout", "  [PieceKernels] IntVolFLINT scaling for ", nW, " worker(s) (", running, " other subkernel(s) running) on ",
    $ProcessorCount, " cores: ", t, " thread(s) per hyperflint, ", w, " candidate(s) raced at once, ", s, " s per candidate\n"]];

If[DownValues[MBtoMPL`Private`mbtClosePiecesParallel] =!= {} && DownValues[Global`bwsClosePiecesOrig] === {},
  DownValues[Global`bwsClosePiecesOrig] = DownValues[MBtoMPL`Private`mbtClosePiecesParallel] /.
    HoldPattern[MBtoMPL`Private`mbtClosePiecesParallel] -> Global`bwsClosePiecesOrig;
  Clear[MBtoMPL`Private`mbtClosePiecesParallel];
  MBtoMPL`Private`mbtClosePiecesParallel[integ_List, ctrs_List, vars_List, epsFacs_List, pkSpec_] :=
    Module[{n = Length[integ], nW, nReq, mode, cap, ks = {}, got = 0, jobRoot, pkgDir, worker, res, k, serialFallback, serialWarn},
      serialFallback := Table[MBtoMPL`Private`mbtCachedMB2MPL[integ[[ii]], ctrs[[ii]], vars[[ii]]], {ii, n}];
      serialWarn := WriteString["stdout", "  [PieceKernels] *** NO PIECE WORKER COULD BE STARTED: the pieces are closed SERIALLY in this kernel, which is far slower than the workers.  Check $MaxLicenseSubprocesses / $MaxLicenseProcesses, the cores and the math executable. ***\n"];
      (* 2026-09-07 (user): the requested worker count is a MAXIMUM, never a refusal.  The workers are parallel
         SUBKERNELS by default (Global`$mbtWorkerMode = "Subkernels": LaunchKernels, which every licence provides some
         of; "Processes" = the former separate math kernels, one main-kernel licence seat each).  The number launched
         is Min[request, licence allowance, cores - 1] and is printed; Global`$mbtSubkernelCap (integer) lowers the
         allowance by hand.  Only when no worker of either kind can start does the run fall back to the serial master
         path, with the warning above (serial mode is far slower and is never the default). *)
      nReq = Which[pkSpec === Automatic, Global`mbtWorkerBudget[], IntegerQ[pkSpec] && pkSpec > 0, pkSpec, True, 1];
      nReq = Min[nReq, n];
      mode = If[MemberQ[{"Subkernels", "Processes"}, Global`$mbtWorkerMode], Global`$mbtWorkerMode, "Subkernels"];
      pkgDir = DirectoryName[MBtoMPL`Private`$mbtPackageFile];
      worker = FileNameJoin[{pkgDir, "mbt_piece_worker.m"}];
      If[MBtoMPL`Private`$mbtPackageFile === "" || ! FileExistsQ[worker],
        WriteString["stdout", "  [PieceKernels] worker file not found.\n"]; serialWarn; Return[serialFallback]];
      If[mode === "Processes" && ! FileExistsQ[MBtoMPL`Private`$mbtMathExecutable],
        WriteString["stdout", "  [PieceKernels] math executable not found -> subkernel workers instead of processes.\n"]; mode = "Subkernels"];
      If[mode === "Subkernels",
        cap = Min[If[IntegerQ[Global`$mbtSubkernelCap], Global`$mbtSubkernelCap, Infinity],
                  If[IntegerQ[$MaxLicenseSubprocesses], $MaxLicenseSubprocesses, Infinity], Max[1, $ProcessorCount - 1],
                  Max[1, Global`mbtSubkernelCapDynamic[]]];   (* the policy budget shared with this user's running jobs *)
        nW = Max[0, Min[nReq, cap]];
        WriteString["stdout", "  [PieceKernels] workers requested ", nReq, "; licence allows ", $MaxLicenseSubprocesses,
          " subkernels; policy budget ", Global`$mbtSubkernelBudget, " (", Global`mbtMySubkernelCount[], " running); ",
          $ProcessorCount, " cores -> launching ", nW, " subkernel worker(s)\n"];
        Quiet@CloseKernels[];
        If[nW > 0, Global`mbtExportIVFScaling[nW]; Quiet@Check[LaunchKernels[nW], Null]];
        ks = Kernels[]; got = Length[ks];
        If[got < nW, WriteString["stdout", "  [PieceKernels] only ", got, " subkernel(s) could be launched (licence or resources).\n"]];
        If[got == 0, WriteString["stdout", "  [PieceKernels] no subkernel available -> trying process workers.\n"]; mode = "Processes"]];
      If[mode === "Processes",
        cap = Min[If[IntegerQ[$MaxLicenseProcesses], $MaxLicenseProcesses - 1, Infinity], Max[1, $ProcessorCount - 1]];
        (* process workers are MAIN kernels (one licence seat each).  In the workers of the multifold closing chain
           (Global`$mbtNestedInWorker = True, set by its pool and lane workers) a nested request -- a worker closing the
           sub-pieces of its piece -- is closed in that worker, and process workers are launched only within the user's
           main-kernel budget (Global`$mbtMainKernelBudget, default 10, counted over this user's running main kernels):
           a pool of sixty piece workers otherwise started one or more main kernels per worker and exhausted the
           licence.  Without the flag (the Standard route, the family driver's own workers) nothing changes. *)
        If[$KernelID =!= 0 && TrueQ[Global`$mbtNestedInWorker],
          WriteString["stdout", "  [PieceKernels] nested request inside a worker: ", n, " piece(s) closed in this kernel.\n"]; Return[serialFallback]];
        If[TrueQ[Global`$mbtNestedInWorker],
          cap = Min[cap, Max[0, If[IntegerQ[Global`$mbtMainKernelBudget], Global`$mbtMainKernelBudget, 10] - Global`mbtMyMainKernelCount[]]]];
        nW = Max[0, Min[nReq, cap]];
        If[nW == 0 || ! FileExistsQ[MBtoMPL`Private`$mbtMathExecutable], serialWarn; Return[serialFallback]];
        WriteString["stdout", "  [PieceKernels] workers requested ", nReq, "; licence allows ", $MaxLicenseProcesses,
          " main kernels; ", $ProcessorCount, " cores -> ", nW, " process worker(s)\n"]];
      jobRoot = FileNameJoin[{$TemporaryDirectory, "mb2mpl-piece-" <> ToString[$ProcessID] <> "-" <> StringReplace[CreateUUID[], "-" -> ""]}];
      Quiet@CreateDirectory[jobRoot, CreateIntermediateDirectories -> True];
      Put[<|"pkgDir" -> pkgDir, "pkgPath" -> MBtoMPL`Private`$mbtPackageFile, "pltPath" -> MBtoMPL`Private`$mbtPolyLogToolsFile,
            "nPieces" -> n, "useCertifiedLibrary" -> TrueQ[MBtoMPL`Private`$mbtUseCertifiedLibrary]|>,
          FileNameJoin[{jobRoot, "meta.m"}]];
      Do[Put[<|"integEps1" -> integ[[ii]], "ctr" -> ctrs[[ii]], "vrs" -> vars[[ii]], "epsFac" -> epsFacs[[ii]]|>,
             FileNameJoin[{jobRoot, "p_" <> IntegerString[ii, 10, 4] <> ".m"}]], {ii, n}];
      If[mode === "Subkernels",
        nW = got;
        WriteString["stdout", "  [PieceKernels] ", nW, " subkernel workers on ", n, " pieces (job ", FileNameTake[jobRoot], ") [mop-up guard ON]...\n"];
        (* every subkernel runs the same worker file with its own start index (the pieces are claimed dynamically, so
           the stride only sets where each worker starts); ParallelEvaluate holds its argument, hence the With *)
        (* MBAnalytica: rounds of fresh workers.  A long-lived worker accumulates memory: on MB8 (1413 pieces) both
           workers were OOM-killed after about 170 pieces each, their claims blocked the pieces they held, and the master
           closed the remaining 1078 serially until it was killed as well.  Each worker now exits after
           mbtWorkerPieceLimit[] pieces; after every round the claims of the pieces without a result are cleared and fresh
           workers are launched on them, while the rounds make progress. *)
        Module[{round = 0, open = Range[n], before, limit = Global`mbtWorkerPieceLimit[], stall = 0},
          While[True,
            before = Length[open];
            Do[With[{kk = i, kern = ks[[i]], jr = jobRoot, nn = Length[ks], sc = Global`$mbtIVFScaling, lim = limit},
               Quiet@ParallelEvaluate[(Global`$mbtWorkerJobRoot = jr; Global`$mbtWorkerLO = kk; Global`$mbtWorkerStride = nn;
                 Global`$mbtIVFScaling = sc; Global`$mbtWorkerMaxPieces = lim;), kern]], {i, Length[ks]}];
            With[{w = worker}, Quiet@CheckAbort[ParallelEvaluate[Get[w], ks], Null]];   (* concurrent on all workers; returns when every piece loop has ended *)
            Quiet@CloseKernels[];
            open = Select[open, ! FileExistsQ[FileNameJoin[{jobRoot, "r_" <> IntegerString[#, 10, 4] <> ".m"}]] &];
            round++;
            If[open === {}, Break[]];
            If[Length[open] < before, stall = 0, stall++];
            If[stall >= 2 || round >= 200, Break[]];
            Scan[Quiet[DeleteDirectory[FileNameJoin[{jobRoot, "claim_" <> IntegerString[#, 10, 4]}], DeleteContents -> True]] &, open];
            WriteString["stdout", "  [PieceKernels] round ", round, ": ", Length[open], " piece(s) open -> ", nW, " fresh worker(s)\n"];
            Global`mbtExportIVFScaling[nW];
            Quiet@Check[LaunchKernels[nW], Null];
            ks = Kernels[];
            If[ks === {}, Break[]]]];
        Quiet@CloseKernels[],
        WriteString["stdout", "  [PieceKernels] ", nW, " process-workers on ", n, " pieces (job ", FileNameTake[jobRoot], ") [mop-up guard ON]...\n"];
        Global`mbtExportIVFScaling[nW];
        Module[{sh, runfile, rc},
          sh = "#!/bin/bash\ncd " <> MBAnalytica`Portable`ShellQuote[pkgDir] <> "\n" <>
            StringJoin@Table["LO=" <> ToString[w] <> " STRIDE=" <> ToString[nW] <> " JOBROOT=" <> MBAnalytica`Portable`ShellQuote[jobRoot] <> " " <>
              MBAnalytica`Portable`ShellQuote[MBtoMPL`Private`$mbtMathExecutable] <> " -script " <> MBAnalytica`Portable`ShellQuote[worker] <> " > " <>
              MBAnalytica`Portable`ShellQuote[FileNameJoin[{jobRoot, "w_" <> ToString[w] <> ".log"}]] <> " 2>&1 &\n", {w, nW}] <> "wait\n";
          runfile = FileNameJoin[{jobRoot, "run.sh"}];
          Export[runfile, sh, "Text"];
          rc = Run["bash " <> MBAnalytica`Portable`ShellQuote[runfile]];
          If[rc =!= 0, WriteString["stdout", "  [PieceKernels] launcher exit code ", rc, " (collecting; any missing pieces will be flagged, not dropped).\n"]]]];
      If[DownValues[Global`IVLibMergeFile] =!= {},
        Module[{ivDfs = FileNames["ivlib_delta_*.m", jobRoot]},
          If[ivDfs =!= {},
            Block[{Global`$IVLibVerbose = False},
              Scan[Quiet[Global`IVLibMergeFile[#]] &, ivDfs];
              If[StringQ[Global`$IVLibFile], Quiet@Global`IVLibSave[Global`$IVLibFile]]];
            WriteString["stdout", "  [PieceKernels] merged ", Length[ivDfs], " library delta file(s).\n"]]]];
      Module[{failedK = {}, missingK = {}, failReasons},
        res = Table[
          Module[{rf = FileNameJoin[{jobRoot, "r_" <> IntegerString[k, 10, 4] <> ".m"}], r1},
            r1 = If[FileExistsQ[rf], Quiet@Check[Get[rf], $Failed], $Failed];
            Which[
              AssociationQ[r1] && r1["status"] === "Clean",
                If[TrueQ[Lookup[r1, "certifiedLibraryHit", False]], MBtoMPL`Private`$mbtLearnedPieceHits++,
                  If[TrueQ[MBtoMPL`Private`$mbtUseCertifiedLibrary], MBtoMPL`Private`$mbtLearnedPieceMisses++]];
                r1["value"],
              AssociationQ[r1], AppendTo[failedK, k]; failReasons[k] = Lookup[r1, "failReasons", {}]; 0,
              True, AppendTo[missingK, k]; 0]],
          {k, n}];
        If[failedK =!= {},
          WriteString["stdout", "  [PieceKernels] mop-up guard: ", Length[failedK], " worker-FAILED piece(s) ledgered, NOT recomputed in the master: ", ToString[failedK], "\n"];
          Do[AppendTo[MBtoMPL`Private`$mbtFailedPieces,
               <|"reason" -> "worker-failed" <> If[ListQ[failReasons[k]] && failReasons[k] =!= {}, ": " <> StringRiffle[ToString /@ failReasons[k], "; "], ""],
                 "piece" -> k, "vars" -> vars[[k]], "normalised" -> Short[integ[[k]], 3]|>], {k, failedK}]];
        If[Length[missingK] > Global`mbtMasterMopupMax[],
          WriteString["stdout", "  [PieceKernels] mop-up guard: ", Length[missingK], " worker-MISSING piece(s), more than the master may close (",
            Global`mbtMasterMopupMax[], "): ledgered, NOT recomputed: ", ToString[missingK], "\n"];
          Do[AppendTo[MBtoMPL`Private`$mbtFailedPieces,
               <|"reason" -> "worker-missing", "piece" -> k, "vars" -> vars[[k]], "normalised" -> Short[integ[[k]], 3]|>], {k, missingK}];
          missingK = {}];
        If[missingK =!= {},
          WriteString["stdout", "  [PieceKernels] mop-up guard: ", Length[missingK], " worker-MISSING piece(s) recomputed under CheckAbort: ", ToString[missingK], "\n"];
          Do[Module[{n0 = Length[MBtoMPL`Private`$mbtFailedPieces], v},
               v = CheckAbort[MBtoMPL`Private`mbtCachedMB2MPL[integ[[k]], ctrs[[k]], vars[[k]]], $Aborted];
               If[v === $Aborted || ! MBtoMPL`Private`mbtCleanNumQ[v, vars[[k]]],
                 If[Length[MBtoMPL`Private`$mbtFailedPieces] == n0,
                   AppendTo[MBtoMPL`Private`$mbtFailedPieces,
                     <|"reason" -> "worker-missing", "piece" -> k, "vars" -> vars[[k]], "normalised" -> Short[integ[[k]], 3]|>]];
                 res[[k]] = 0,
                 res[[k]] = v]], {k, missingK}]]];
      (* 2026-09-05: keep the worker logs of a successful job (small text files) under <pkgDir>/worker_logs/<job>/ so that
         a served value can be traced to its closer afterwards (the MB3 audit's served number could not be attributed
         once the job dir was gone) *)
      Quiet@Check[Module[{ld = FileNameJoin[{Global`$MBStandardCacheDir, "worker_logs", FileNameTake[jobRoot]}]},
        CreateDirectory[ld, CreateIntermediateDirectories -> True];
        Scan[CopyFile[#, FileNameJoin[{ld, FileNameTake[#]}], OverwriteTarget -> True] &, FileNames["w_*.log", jobRoot]];
        WriteString["stdout", "  [PieceKernels] worker logs kept in ", ld, "\n"]], Null];
      If[Length[MBtoMPL`Private`$mbtFailedPieces] == 0,
        Quiet@DeleteDirectory[jobRoot, DeleteContents -> True],
        WriteString["stdout", "  [PieceKernels] job kept for inspection: ", jobRoot, "\n"]];
      WriteString["stdout", "  [PieceKernels] done (", n - Length[MBtoMPL`Private`$mbtFailedPieces], "/", n, " clean).\n"];
      res];
  WriteString["stdout", "[mbeTwoVarPsiRung] master mop-up guard installed (worker-failed pieces ledgered, not recomputed).\n"]];

(* ===================== PART F: RUNGS-ONLY knob (2026-09-06) ===================== *)
(* env MBT_PIECE_LIBRARY_OFF=1 (already honoured by mbt_piece_worker.m) now also disables the certified PIECE
   library in a MASTER (serial masters, mop-ups, PieceKernels 0): the piece query returns a miss, so every piece is
   re-derived by the sealed core + the rungs.  The RESOLUTION record query (MBStdLibQueryResolved: MB11's resonant
   continuation) is untouched -- the resolver rung is a separate, future class handler.  Used by
   run_full_rungs_only_regression_v4.sh. *)
If[Environment["MBT_PIECE_LIBRARY_OFF"] === "1" && ! TrueQ[Global`$bwsPieceLibraryOff],
  Global`$bwsPieceLibraryOff = True;
  If[DownValues[MBStandardLibrary`MBStdLibQueryPiece] =!= {},
    Global`$bwsStdLibQueryPieceSaved = DownValues[MBStandardLibrary`MBStdLibQueryPiece];
    Quiet@Unprotect[MBStandardLibrary`MBStdLibQueryPiece];
    ClearAll[MBStandardLibrary`MBStdLibQueryPiece];
    MBStandardLibrary`MBStdLibQueryPiece[___] := Missing["NotFound"]];
  WriteString["stdout", "[mbeTwoVarPsiRung] RUNGS-ONLY: certified PIECE library disabled in this process (MBT_PIECE_LIBRARY_OFF=1); the resolution-record query is untouched.\n"]];
