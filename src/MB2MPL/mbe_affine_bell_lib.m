(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* mbe_affine_bell_lib.m — AFFINE-BELL PRODUCER (library), 2026-09-01.
   Closes 1-fold pieces  Rat(z) * [Gamma kernel] * Prod psi^{(m)}(affine args)^k  whose psi-arguments are integer shifts of a
   leg x = sigma z + alpha or of its pairing partner s1 - x.  Kernel spec (per family):
     <|"name", "sigma", "alpha", "legs" -> {s_1, ..}, "kernelRat" -> R(x), "gammaKernel" -> expr in z (pure Gamma part)|>
   with  gammaKernel(z) == kernelRat(x) * Prod_i Gamma(x) Gamma(s_i - x).
   Method: psi-monomial -> Bell basis Prod_i Y_{j_i}(p) Y_{k_i}(q) * leftover (p_m, q_m, m>=1); derivatives of the Beta pairings
   Gamma^{(j)}(x) Gamma^{(k)}(y) = Sum C C Gamma^{(j+k-i-l)}(x+y) Int v^{x-1}(1-v)^{y-1} log^i v log^l(1-v) dv at y = s - x;
   leftovers psi^{(m)}(x) = -Int t^{x-1} log^m t/(1-t) dt; rationals via partial fractions and w-reps; Mellin inversion in x
   collapses the projective leg-1 variable; IntVolFLINT closes the cubes; gate = numeric contour integral of the piece. *)
abpZ = Global`z;  (* the MB variable symbol used in pieces is renamed to abpZ by abpClose *)
abpSpecs = <|
  "K1" -> <|"name" -> "MB9r3", "sigma" -> -1, "alpha" -> 0, "legs" -> {1, 2}, "kernelRat" -> (1/#1 &),
     "gammaKernel" -> (Gamma[-#]^3 Gamma[#] Gamma[1 + #]/Gamma[-1 - #] &)|>,
  "K3" -> <|"name" -> "MB5r4", "sigma" -> -1, "alpha" -> 1, "legs" -> {1, 1}, "kernelRat" -> (-1/(1 - #1) &),
     "gammaKernel" -> (Gamma[1 - #] Gamma[-#] Gamma[#]^2 &)|>,
  (* K2 = MB9 r7: Gamma[-1-z]Gamma[2-z]Gamma[-z]^2Gamma[1+z]^3/Gamma[1-z], contour 0.858; x = 2 - z (Re 1.14):
     = Gamma[x]^3 Gamma[3-x]^3 / ((x-3)(x-2)^3(x-1)^2);  psi(-1-z) = psi(x-3), psi(2-z) = psi(x) *)
  "K2" -> <|"name" -> "MB9r7", "sigma" -> -1, "alpha" -> 2, "legs" -> {3, 3, 3}, "kernelRat" -> (1/((#1 - 3) (#1 - 2)^3 (#1 - 1)^2) &),
     "gammaKernel" -> (Gamma[-1 - #] Gamma[2 - #] Gamma[-#]^2 Gamma[1 + #]^3/Gamma[1 - #] &)|>|>;
(* ---------- Bell polynomials ---------- *)
abpY[j_, sym_] := abpY[j, sym] = Expand[D[Exp[Sum[sym[m] tt^(m + 1)/(m + 1)!, {m, 0, j}]], {tt, j}] /. tt -> 0];
abpWt[mono_] := Total[Cases[FactorList[mono], {(Global`abpP | Global`abpQ)[m_], e_} :> (m + 1) e]];
abpLeftovers[wgt_, d_] := Module[{res = {1}, syms, cand},
   syms = Join[Table[Global`abpP[m], {m, 1, wgt}], Table[Global`abpQ[m], {m, 1, wgt}]];
   Do[cand = Select[DeleteDuplicates[Times @@@ Tuples[syms, k]], abpWt[#] <= wgt &]; res = Join[res, cand], {k, 1, d}];
   DeleteDuplicates[Select[res, abpWt[#] <= wgt &]]];
(* Bell representation: T(p,q) = Sum c * Prod_i Y_{j_i}(p) Y_{k_i}(q) * mu ; qLegs = legs allowed to carry q-derivatives *)
abpBellRep[T_, nLegs_, qLegs_] := Module[{wT, sol = $Failed, d = 0, basis, cs, eq, vars, rules, TT = Expand[T], mons, jk},
   If[FreeQ[TT, Global`abpP | Global`abpQ], Return[{{TT, ConstantArray[{0, 0}, nLegs], 1}}]];
   mons = If[Head[TT] === Plus, List @@ TT, {TT}];
   wT = Max[abpWt /@ mons];
   While[sol === $Failed && d <= 4,
    jk = Flatten[Table[Table[{j, If[MemberQ[qLegs, i], k, 0]}, {i, nLegs}] /. {j -> jj, k -> kk}, {jj, 0, wT}, {kk, 0, wT}], 0];
    (* enumerate exponent assignments per leg *)
    basis = {};
    Module[{ranges = Table[Flatten[Table[{j, k}, {j, 0, wT}, {k, 0, If[MemberQ[qLegs, i], wT, 0]}], 1], {i, nLegs}]},
     Do[Module[{tot = Total[Flatten[assign]]}, If[tot <= wT,
        Do[If[abpWt[mu] + tot == wT, AppendTo[basis, {assign, mu}]], {mu, abpLeftovers[wT - tot, d]}]]], {assign, Tuples[ranges]}]];
    cs = Table[Unique["abpc"], {Length[basis]}];
    eq = Expand[TT - Sum[cs[[i]] Times @@ Table[abpY[basis[[i, 1, l, 1]], Global`abpP] abpY[basis[[i, 1, l, 2]], Global`abpQ], {l, nLegs}] basis[[i, 2]], {i, Length[basis]}]];
    vars = Union[Cases[eq, (Global`abpP | Global`abpQ)[_], Infinity]];
    rules = Quiet@Solve[Thread[CoefficientRules[eq, vars][[All, 2]] == 0], cs];
    If[rules =!= {} && rules =!= $Failed,
     sol = Select[Transpose[{cs /. First[rules] /. Thread[cs -> 0], basis[[All, 1]], basis[[All, 2]]}], #[[1]] =!= 0 &], d++]];
   sol];   (* list of {coeff, {{j1,k1},{j2,k2},..}, mu} *)
(* ---------- exact Gamma derivatives ---------- *)
abpGam[n_, s_] := abpGam[n, s] = FullSimplify[D[Gamma[xx], {xx, n}] /. xx -> s];
(* ---------- psi argument -> (type, shift) and rational corrections ---------- *)
(* psi^{(m)}(x+n) = psi^{(m)}(x) + (-1)^m m! Sum_{k=0}^{n-1} 1/(x+k)^{m+1}  (n>0);  n<0: - Sum_{k=1}^{|n|} 1/(x-k)^{m+1} *)
abpShiftPoly[m_, n_, base_] := If[n > 0, (-1)^m m! Sum[1/(base + k)^(m + 1), {k, 0, n - 1}], If[n < 0, -(-1)^m m! Sum[1/(base - k)^(m + 1), {k, 1, -n}], 0]];
(* ---------- cube construction for one Bell term ---------- *)
(* returns list of {constant, integrand, vars}; xv = symbol for x used in rational factors *)
abpCubes[spec_, assign_, mu_, ratTerm_, x0_] := Module[
   {legs = spec["legs"], nL, ms, msq, tvarsP, tvarsQ, vvars, wvar = Global`abpw, xfacs = {}, pre = 1, base, out = {}, s1, rt, k, j, rsign, wfac, ig0, a0, v0, leg1, expTab},
   nL = Length[legs]; s1 = legs[[1]];
   ms = Flatten[Cases[FactorList[mu], {Global`abpP[m_], e_} :> Table[m, {e}]]];
   msq = Flatten[Cases[FactorList[mu], {Global`abpQ[m_], e_} :> Table[m, {e}]]];
   tvarsP = Table[Symbol["abpt" <> ToString[r]], {r, Length[ms]}];
   tvarsQ = Table[Symbol["abps" <> ToString[r]], {r, Length[msq]}];
   vvars = Table[Symbol["abpv" <> ToString[i]], {i, 2, nL}];
   (* X-bookkeeping: {base, exponent}; leg 1 collapsed separately *)
   xfacs = Join[Table[{vvars[[i - 1]]/(1 - vvars[[i - 1]]), 1}, {i, 2, nL}], Table[{tvarsP[[r]], 1}, {r, Length[ms]}], Table[{tvarsQ[[r]], -1}, {r, Length[msq]}]];
   (* rational term c/(x+k)^j : ratTerm = {c, k, j} meaning c (x + k)^(-j) *)
   {rt, k, j} = ratTerm;
   If[j > 0,
    If[Re[x0 + k] > 0, wfac = wvar^(k - 1) (-Log[wvar])^(j - 1)/(j - 1)!; AppendTo[xfacs, {wvar, 1}]; rsign = 1,
     wfac = wvar^(-k - 1) (-Log[wvar])^(j - 1)/(j - 1)!; AppendTo[xfacs, {wvar, -1}]; rsign = (-1)^j],
    wfac = 1; rsign = 1];
   a0 = Times @@ (#[[1]]^(-#[[2]]) & /@ xfacs); v0 = a0/(1 + a0);
   (* derivative expansions per leg *)
   expTab = Table[Module[{jj = assign[[i, 1]], kk = assign[[i, 2]]}, Flatten[Table[{Binomial[jj, ii] Binomial[kk, ll] abpGam[jj + kk - ii - ll, legs[[i]]], ii, ll}, {ii, 0, jj}, {ll, 0, kk}], 1]], {i, nL}];
   Do[Module[{cst = rt rsign (-1)^(Length[ms] + Length[msq]) Times @@ (combo[[All, 1]]), ig},
     leg1 = (1/(1 + a0)) (1/(1 + a0))^(s1 - 1) Log[v0]^combo[[1, 2]] Log[1/(1 + a0)]^combo[[1, 3]];
     ig = leg1 * Times @@ Table[(1/vvars[[i - 1]]) (1 - vvars[[i - 1]])^(legs[[i]] - 1) Log[vvars[[i - 1]]]^combo[[i, 2]] Log[1 - vvars[[i - 1]]]^combo[[i, 3]], {i, 2, nL}] *
        Times @@ Table[(1/tvarsP[[r]]) Log[tvarsP[[r]]]^ms[[r]]/(1 - tvarsP[[r]]), {r, Length[ms]}] *
        Times @@ Table[tvarsQ[[r]]^(s1 - 1) Log[tvarsQ[[r]]]^msq[[r]]/(1 - tvarsQ[[r]]), {r, Length[msq]}] * wfac;
     AppendTo[out, {cst, Together[ig], Join[vvars, If[j > 0, {wvar}, {}], tvarsP, tvarsQ]}]],
    {combo, Tuples[expTab]}];
   out];
(* ---------- automatic kernel spec (2026-09-01 16:00) ----------
   Derive <|sigma, alpha, legs, kernelRat, gammaKernel|> for ANY balanced 1-fold pure-Gamma kernel K(z) x rational(z):
   x = sigma z + alpha with x0 in (0,1]; every Gamma(x+n) -> Gamma(x) x Pochhammer (P legs), every Gamma(m-x) -> Gamma(s-x)
   with s the least integer >= m keeping Re(s-x0) > 0 (Q legs); denominators cancel legs of the same type; balanced iff
   #P == #Q after cancellation (an unpaired Gamma inverts to an exponential, not a polylog cube).  Verified numerically. *)
abpPoch[x_, n_Integer] := If[n >= 0, Product[x + k, {k, 0, n - 1}], 1/Product[x - k, {k, 1, -n}]];   (* Gamma(x+n) = Gamma(x) abpPoch *)
abpAutoSpec[kernel_, zsym_, z0in_] := Module[{best = $Failed, xs = Global`abpxs, z0 = Rationalize[z0in, 10^-15]},
   Do[Module[{alpha, x0, kx, num, den, gf, rat, nP = 0, legs = {}, ok = True, spec, chk},
      alpha = Floor[1 - sigma z0]; x0 = sigma z0 + alpha;   (* x0 in (0,1]; z0 exact so the identity check below is exact-precision *)
      kx = Together[kernel /. zsym -> (xs - alpha)/sigma];
      gf = Join[Cases[{kx}, Power[Gamma[a_], e_Integer] :> {Expand[a], e}, Infinity], Cases[kx /. Power[Gamma[_], _Integer] -> 1, Gamma[a_] :> {Expand[a], 1}, Infinity],
        Cases[{kx}, Power[Gamma[a_], e_Integer] /; False :> 0, Infinity]];
      (* denominator Gammas appear as Power[Gamma[a], -e] in Together form; numerator as Gamma[a] or Power[Gamma[a], e] *)
      rat = kx /. Gamma[_] -> 1;
      Do[Module[{a = g[[1]], e = g[[2]], c, n},
         c = Coefficient[a, xs]; n = a - c xs;
         Which[c == 1 && IntegerQ[n], nP += e; rat = rat abpPoch[xs, n]^e,
               c == -1 && IntegerQ[n], If[e > 0,
                  Module[{s = n, k = 0}, While[! TrueQ[s - x0 > 0], s++; k++];   (* Gamma(n-x) = Gamma(s-x)/Prod_{i=0}^{k-1}(n+i-x) *)
                    Do[AppendTo[legs, s], {e}]; rat = rat/Product[n + i - xs, {i, 0, k - 1}]^e],
                  Do[Module[{s}, If[legs === {}, ok = False, s = First[MinimalBy[legs, Abs[# - n] &]]; legs = DeleteCases[legs, s, 1, 1];
                      (* 1/Gamma(n-x) = Prod_{i=n}^{s-1}(i-x)/Gamma(s-x)  (s>=n)  or  1/(Gamma(s-x) Prod_{i=s}^{n-1}(i-x))  (s<n) *)
                      rat = rat If[s >= n, Product[i - xs, {i, n, s - 1}], 1/Product[i - xs, {i, s, n - 1}]]]], {-e}]],
               True, ok = False]], {g, gf}];
      If[ok && nP == Length[legs] && nP >= 1 && FreeQ[rat, Gamma],
       legs = Sort[legs];
       spec = <|"name" -> "AUTO", "sigma" -> sigma, "alpha" -> alpha, "legs" -> legs,
          "kernelRat" -> With[{r = Together[rat]}, Function[xx, r /. xs -> xx]],
          "gammaKernel" -> With[{kk = kernel}, Function[zz, kk /. zsym -> zz]]|>;
       chk = Table[Module[{zt = z0 + 3/10 I + t/7, xt}, xt = sigma zt + alpha;
           N[(kernel /. zsym -> zt)/(spec["kernelRat"][xt] Times @@ (Gamma[xt] Gamma[# - xt] & /@ legs)), 30]], {t, 0, 1}];
       If[AllTrue[chk, Abs[# - 1] < 10^-20 &], If[best === $Failed || Length[legs] < Length[best["legs"]], best = spec]]]],
     {sigma, {-1, 1}}];
   best];
(* ---------- close one piece ---------- *)
Options[abpClose] = {"Timeout" -> 900, "Log" -> None, "Gate" -> True};
abpClose[ig0in_, zsym_, z0_, specKey_, OptionsPattern[]] := Module[
   {spec, sigma, alpha, x0, ig0, psiF, gam, rest, ratio, T = 1, ratX = 1, xv = Global`abpx, terms, total = 0, ok = True, tmo = OptionValue["Timeout"], lg = OptionValue["Log"], rep, s1, nL, qLegs, refv, W},
   W = If[lg === None, Null &, lg];
   ig0 = ig0in /. zsym -> abpZ;
   (* separate psi factors *)
   psiF = Join[Cases[{ig0}, Power[PolyGamma[m_, a_], e_] :> {m, a, e}, Infinity], Cases[ig0 /. Power[PolyGamma[__], _] -> 1, PolyGamma[m_, a_] :> {m, a, 1}, Infinity]];
   rest = ig0 /. PolyGamma[__] -> 1;
   spec = If[KeyExistsQ[abpSpecs, specKey], abpSpecs[specKey], abpAutoSpec[rest, abpZ, z0]];
   If[! AssociationQ[spec], W["abpClose: no spec (AUTO derivation failed: unbalanced or non-integer kernel) for " <> ToString[InputForm[rest]]]; Return[$Failed]];
   If[specKey === "AUTO" || ! KeyExistsQ[abpSpecs, specKey], W["abpClose: AUTO spec sigma=" <> ToString[spec["sigma"]] <> " alpha=" <> ToString[spec["alpha"]] <> " legs=" <> ToString[spec["legs"]] <> " kernelRat=" <> ToString[InputForm[spec["kernelRat"][Global`abpx]]]]];
   sigma = spec["sigma"]; alpha = spec["alpha"]; x0 = sigma z0 + alpha; s1 = spec["legs"][[1]]; nL = Length[spec["legs"]];
   qLegs = Flatten[Position[spec["legs"], s1]];
   ratio = Simplify[rest/spec["gammaKernel"][abpZ]];
   If[! FreeQ[ratio, abpZ], W["abpClose: kernel mismatch, ratio = " <> ToString[InputForm[ratio]]]; Return[$Failed]];
   (* psi factors -> p/q with shifts (x = sigma z + alpha  =>  z = (x - alpha)/sigma) *)
   Do[Module[{m = pf[[1]], arg = pf[[2]] /. abpZ -> (xv - alpha)/sigma, e = pf[[3]], sl, n, poly},
     arg = Expand[arg]; sl = Coefficient[arg, xv]; n = arg - sl xv;
     Which[sl == 1 && IntegerQ[n], poly = Global`abpP[m] + abpShiftPoly[m, n, xv],
           sl == -1 && IntegerQ[n - s1], poly = Global`abpQ[m] + abpShiftPoly[m, n - s1, s1 - xv],
           True, W["abpClose: unsupported psi argument " <> ToString[InputForm[pf[[2]]]]]; ok = False; poly = 1];
     T = T poly^e], {pf, psiF}];
   If[! ok, Return[$Failed]];
   T = Expand[T ratio spec["kernelRat"][xv]];
   (* split T into (p,q)-monomial x rational-in-x terms; partial fractions of each rational coefficient *)
   terms = Module[{cr = CoefficientRules[T, Union[Cases[T, (Global`abpP | Global`abpQ)[_], Infinity]]], vars = Union[Cases[T, (Global`abpP | Global`abpQ)[_], Infinity]]},
     Flatten[Table[Module[{mono = Times @@ (vars^r[[1]]), rat = Apart[r[[2]], xv], rl},
        rl = If[Head[rat] === Plus, List @@ rat, {rat}];
        Table[Module[{c, den, kk, jj}, (* term c/(x+k)^j or constant *)
           den = Denominator[Together[rt]]; c = Numerator[Together[rt]];
           If[FreeQ[den, xv], {mono, {rt, 0, 0}},
            jj = Exponent[den, xv];
            Module[{lead = Coefficient[Expand[den], xv, jj], kk},
             kk = Simplify[Coefficient[Expand[den], xv, jj - 1]/(jj lead)];   (* den = lead (x + k)^j  =>  coeff of x^(j-1) = j lead k *)
             If[! FreeQ[c, xv] || Simplify[Expand[den] - lead (xv + kk)^jj] =!= 0, W["abpClose: unsupported rational term " <> ToString[InputForm[rt]]]; ok = False];
             {mono, {c/lead, kk, jj}}]]], {rt, rl}]], {r, cr}], 1]];
   If[! ok, Return[$Failed]];
   W["abpClose: " <> ToString[Length[terms]] <> " (monomial, rational) terms; x0 = " <> ToString[N[x0]]];
   Do[Module[{mono = tm[[1]], rtm = tm[[2]], rep, cubes, t0 = AbsoluteTime[]},
     rep = abpBellRep[mono, nL, qLegs];
     If[rep === $Failed, W["abpClose: Bell rep failed for " <> ToString[mono]]; ok = False; Continue[]];
     Do[cubes = abpCubes[spec, bt[[2]], bt[[3]], rtm, x0];
       Do[Module[{v, ck},
          (* 16:20: persistent cube memo — the Bell-basis cubes (psi-monomial x pole term) recur across the classes of a
             residue; key = exact integrand + variables.  Global`abpCubeMemo (association) is loaded/merged and saved by the
             runner (Global`abpCubeMemoFile); a hit costs nothing, a miss is banked after the exact IVF closure. *)
          ck = ToString[InputForm[{cb[[2]], cb[[3]]}]];
          If[AssociationQ[Global`abpCubeMemo] && KeyExistsQ[Global`abpCubeMemo, ck], v = Global`abpCubeMemo[ck]; Global`abpCubeHits++,
           v = Quiet@CheckAbort[TimeConstrained[Global`ivfExactCubeBoth[cb[[2]], cb[[3]], tmo], tmo + 60, $Failed], $Failed];
           If[! (v === $Failed || ! FreeQ[v, $Failed | Indeterminate]) && AssociationQ[Global`abpCubeMemo],
            Global`abpCubeMemo[ck] = v; If[StringQ[Global`abpCubeMemoFile],
              Put[Global`abpCubeMemo, Global`abpCubeMemoFile <> ".tmp"]; Quiet@DeleteFile[Global`abpCubeMemoFile]; RenameFile[Global`abpCubeMemoFile <> ".tmp", Global`abpCubeMemoFile]]]];
          If[v === $Failed || ! FreeQ[v, $Failed | Indeterminate], ok = False;
           W["  cube REFUSED (" <> ToString[Length[cb[[3]]]] <> "-dim) " <> ToString[Lookup[Global`$ivfLastRace, "reason", "?"]]],
           total += bt[[1]] cb[[1]] v]], {cb, cubes}], {bt, rep}];
     W["  term " <> ToString[InputForm[mono]] <> " x " <> ToString[InputForm[rtm]] <> ": " <> ToString[Length[rep]] <> " Bell terms (" <> ToString[Round[AbsoluteTime[] - t0]] <> "s)"]], {tm, terms}];
   If[! ok, Return[$Failed]];
   If[OptionValue["Gate"],
    refv = Quiet@NIntegrate[ig0 /. abpZ -> z0 + I yy, {yy, -Infinity, -1, -1/10, 0, 1/10, 1, Infinity}, WorkingPrecision -> 40, PrecisionGoal -> 16, MaxRecursion -> 20, Method -> "GlobalAdaptive"]/(2 Pi);
    Module[{tv = Quiet@N[total /. Zeta[5, 3] -> 37707672984847544011304782294206604580201/10^42 /. Symbol["HPL`HPLs8a"] -> Zeta[8] + 37707672984847544011304782294206604580201/10^42, 25]},
     W["abpClose: exact ~ " <> ToString[tv] <> "   gate " <> ToString[N[refv, 20]] <> If[NumericQ[tv] && NumericQ[refv] && Abs[tv - refv] < 10^-8 (1 + Abs[refv]), "   GATE OK", "   *** GATE FAIL ***"]];
     If[! (NumericQ[tv] && NumericQ[refv] && Abs[tv - refv] < 10^-8 (1 + Abs[refv])), Return[$Failed]]]];
   total];
