(* ::Package:: *)
(* AUTHORSHIP (release R2 + rung, 2026-09-09/10): MB2MPL faithful-cube rung for multi-fold residues. Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)

(* mbeFaithfulCubeRung.m -- FAITHFUL CUBE of a multi-fold Mellin-Barnes residue by Barnes-kernel inversion
   (Subtraction route; the general form of the hand derivations of MB3-res2 and MB4-res2/res5, subtraction paper
   sec. "Non-normal-crossing corners", Proposition "Degenerate-residue conversion faithfulness", Template B).

   For a residue  R = (1/2 pi i)^n Int prod Gamma(l_i(z))^p_i phi(z) dz  with linear l_i and slopes 0, +-1 in every
   MB variable, one variable at a time (v2 rules, 2026-09-10 -- the moves of the MB4-res5 hand derivation
   the hand derivation of residue 5 written as rules; the v1 rules of 2026-09-09 are kept as the fallback):
     1. contour regularisation: every numerator Gamma has Re(l) > 0 on the contour after the shift
        Gamma(l) = Gamma(l+k) / prod_j (l+j); the rational factors are COLLECTED (not yet Euler monomials);
     2. S1: a denominator Gamma(l) with a same-slope numerator Gamma(l') at INTEGER distance cancels exactly,
        Gamma(l')/Gamma(l) = 1/(l')_n (rationals, collected) or (l)_n (a polynomial) -- no Euler variable;
     3. S2: every other denominator Gamma(l) pairs with a same-slope numerator Gamma(l') into a Beta integral,
        Gamma(l')/Gamma(l) = (1/Gamma(l-l')) Int x^(l'-1)(1-x)^(l-l'-1) dx, the partner chosen with a ratio l-l' FREE
        of the other MB variables; the denominator is shifted up by (l)_m only when Re(l-l') <= -1, so a gap in
        (-1, 0) leaves a genuine FACE (1-x)^(-1+k eps) that the master subtraction equation removes (step 7);
     4. one pair Gamma(a-z)Gamma(b+z) with a, b free of the other MB variables is kept as the Barnes kernel;
     5. the remaining numerators pair (+,-) into Beta integrals, a pair whose sum is free of the other variables first;
     6. the collected rationals sharing one linear direction are MERGED into ONE Euler variable by partial fractions in
        the formal direction variable, prod 1/l_i^k_i = Int_0^1 w^(G.z-1) M(w; eps) dw, each pole term on its
        contour-sign-correct branch; the eps-denominators of the partial-fraction coefficients join the prefactor
        (for MB4-res5: 1/((-z)(z-eps)) = (1/eps) Int x^(z-1) (1 - x^-eps) dx, the (1 - x^-eps) of Template B);
     7. the z-dependence is then exponential-linear, Lam^z, and the kernel collapses exactly,
        (1/2 pi i) Int Gamma(a-z)Gamma(b+z) Lam^z P(z) dz = Gamma(a+b) P(Lam d/dLam)[Lam^a (1+Lam)^(-(a+b))];
     the Gamma(a+b), Gamma(l-l'), Gamma(l1+l2) that still carry another MB variable join that variable's list.
   The result is ONE Euler cube (no contour deformation: pinch-safe) whose factors are monomials with eps-linear
   exponents and positive polynomials (N+M)^p.  Before the eps-expansion the MASTER SUBTRACTION EQUATION (subtraction
   paper Prop. onevar / the tensor inclusion-exclusion of sec. corner) is applied to every genuine face v^(c+k eps) or
   (1-v)^(c+k eps) with integer c <= -1: counter-terms = Taylor data at the face times the exact moments
   1/(i+c+1+k eps) (lower-dimensional cubes), bulk = the subtracted integrand, finite order by order by construction.
   Each eps-coefficient of each structural piece is split ONLY by the powers of the structural logs (the merged
   variables' log w, the faces' log(1-v)); everything else stays in one integrand (the hand organisation: 10 pieces at
   the cube's eps^3, 15 at eps^4 for MB4-res5, against 430 and 1651 log-monomial pieces of the v1 cube).  A refused
   piece is sub-split by log monomials WITH the face subtraction re-applied per monomial (each sub-piece finite).
   Pieces are integrated exactly by the package's cube integrator (IntVol with the IntVolFLINT strategy) on parallel
   subkernels and banked per order and per piece under .cache/fcu/.

   Fail-closed: a residue the inversion cannot pair, a face the master equation cannot resolve (an eps-free exponent
   <= -1 with non-vanishing Taylor data, a logarithm on a face), a cube with more than $fcuMaxVars variables, or any
   piece the integrator refuses makes the handler return $Failed and the Subtraction route continues with its other
   closers.  The v1 rules (2026-09-09; verified on MB4-res5 at eps^-3..eps^0) are used when the v2 inversion fails. *)

If[! TrueQ[Global`$fcuRungInstalled],
Module[{},
  If[! ValueQ[Global`$fcuMaxVars], Global`$fcuMaxVars = 9];
  If[! ValueQ[Global`$fcuPieceSeconds], Global`$fcuPieceSeconds = 7200];
  If[! ValueQ[Global`$fcuMaxWorkers], Global`$fcuMaxWorkers = 100];
  If[! ValueQ[Global`$fcuRules], Global`$fcuRules = "v2"];      (* "v2" (v1 fallback) | "v1" *)
  If[! ValueQ[Global`$fcuGate], Global`$fcuGate = False];   (* dev only: numeric faithfulness gate at eps=-1/40 *)
  Global`$fcuLastRun = <||>;

  Global`fcu$fail[msg_] := Throw[<|"Failed" -> True, "Reason" -> ToString[msg]|>, Global`fcu$tag];
  Global`fcuDecompose[f_, zs_] := Module[{fac, gam = {}, rest = 1},
    fac = If[Head[#] === Times, List @@ #, {#}] &[Together[f]];
    Do[Which[
      MatchQ[t, Power[Gamma[_], _Integer]], AppendTo[gam, {t[[1, 1]], t[[2]]}],
      MatchQ[t, Gamma[_]], AppendTo[gam, {t[[1]], 1}],
      True, rest = rest t], {t, fac}];
    If[! FreeQ[rest, Alternatives @@ zs], Global`fcu$fail["non-Gamma dependence on the MB variables: " <> ToString[rest, InputForm]]];
    <|"Gammas" -> gam, "Rest" -> rest|>];
  Global`fcuReVal[x_, ctrAll_, eN_] := Re[N[x /. ctrAll /. eN, 20]];

  (* ---------- the dressing of a residue: polygamma factors and rationals in the MB variables (2026-09-11, MB5) ----------
     MBresolve's residues at multiple poles carry exact-eps polygamma factors psi^(m)(L), L affine in the MB variables
     and eps, and rational factors 1/l^k; the tower closure refuses them ("phase not n-constant") and the inversion
     refused them ("non-Gamma dependence").  They are turned into Euler-cube structure BEFORE the inversion, by the
     integral-representation theorem of the standard paper (thm:intrep-cube): every polygamma whose argument has real
     part <= 1/4 on the contour is raised by psi^(m)(L) = psi^(m)(L+1) - (-1)^m m!/L^(m+1) (the near-pole band rule of
     the Barnes-with-scale rung), then
        psi(L)     = -EulerGamma + Int_0^1 (1 - s^(L-1))/(1-s) ds,
        psi^(m)(L) = -Int_0^1 s^(L-1) log^m(s)/(1-s) ds   (m >= 1),
     one fresh Euler variable s per occurrence, and every rational 1/l^k by the contour-sign-correct auxiliary integral
     (lemma aux), one variable per distinct l.  The MB variables then enter the dressing only through kinematic scales
     s^(-z), u^(+-z), which the kernel collapse absorbs.  The numerator (1 - s^(L-1)) is NOT split: its two terms share
     the eps-free face (1-s)^(-1) whose regular part vanishes at s = 1, which the face census accepts (fcuFacePieces). *)
  Global`fcuAffineQ[l_, zs_List, eps_] := PolynomialQ[l, Join[zs, {eps}]] && Max[Exponent[l, #] & /@ Join[zs, {eps}]] <= 1;
  (* THE EVALUATION POINT OF THE SIGN DECISIONS (2026-09-11, MB9 residue 18).  Every branch decision of the inversion
     (shift counts, Beta-pairing conditions, the canonical contour of the kernel collapse, the branch of each rational)
     is read at eps = eN on the resolver's contour.  A residue of MBresolve is valid in a neighbourhood of eps = 0 only
     as long as no pole crosses its contour; a leg such as Gamma(2 + z35 + 2 eps) on Re z35 = -1.9565 has Re = 0.0435
     at eps = 0 and crosses at eps = -0.0217, so the fixed eN = -1/40 lay BEYOND a crossing: the cube built there is
     faithful to the fixed-contour integral at eN, whose analytic continuation to eps -> 0 differs from the residue by
     the crossed residue -- a wrong finite coefficient (66.09 for -41) with no other symptom.  eN is now chosen per
     residue: half the smallest |eps| at which the real part of any affine form (Gamma and polygamma arguments,
     rational bases) on the contour reaches an integer, capped at 1/40. *)
  Global`fcuSafeEps[f_, zs_List, ctrR_, eps_] := Module[{forms, d = 1/40},
    forms = DeleteDuplicates[Join[Cases[f, Gamma[a_] :> a, {0, Infinity}], Cases[f, PolyGamma[_, a_] :> a, {0, Infinity}],
      Cases[f, Power[b_, p_?Negative] /; ! FreeQ[b, Alternatives @@ zs] :> b, {0, Infinity}]]];
    Do[Module[{r0, k, dist},
       r0 = Re[N[L /. ctrR /. eps -> 0, 30]]; k = Coefficient[Expand[L], eps];
       If[k =!= 0 && NumericQ[r0], dist = Abs[r0 - Round[r0]]; If[dist > 0, d = Min[d, dist/(2 Abs[k])]]]],
      {L, Select[forms, Global`fcuAffineQ[#, zs, eps] &]}];
    -d];
  Global`fcuDress[f_, zs_List, ctrAll_, eN_, eps_] := Catch[Module[
    {fac, K = 1, D = 1, prefD = 1, terms, out = 0, aux = {}, reg = <||>, nd = 0, newAux, psiRaise, dd, trace = {}},
    newAux[] := (nd++; Module[{v = Symbol["Global`fcd" <> ToString[nd]]}, AppendTo[aux, v]; v]);
    (* the Gamma content common to every term (MBresolve distributes the Gamma product over the polygamma sum of a
       multiple-pole residue): the Gamma factors of the first term, checked against the others by cancellation *)
    Module[{terms0 = If[Head[f] === Plus, List @@ f, {f}], gp},
      gp = Function[t, Times @@ Cases[If[Head[t] === Times, List @@ t, {t}], Gamma[_] | Power[Gamma[_], _Integer]]];
      K = gp[terms0[[1]]];
      D = Together[f/K];
      If[! FreeQ[D, Gamma], D = Expand[Together[Total[Table[Cancel[t/K], {t, terms0}]]]]]];
    If[FreeQ[D, Alternatives @@ zs], Return[None]];
    (* the z-free multiplicative factors of the dressing go to the prefactor *)
    fac = If[Head[D] === Times, List @@ D, {D}];
    D = 1; Do[If[FreeQ[t, Alternatives @@ zs], prefD = prefD t, D = D t], {t, fac}];
    If[! FreeQ[D, Gamma], Global`fcu$fail["dressing: Gamma functions inside a sum: " <> ToString[D, InputForm]]];
    (* 1. raise the polygamma arguments to the band Re L > 1/4 *)
    psiRaise[e_] := e //. PolyGamma[m_Integer, L_] /; ! FreeQ[L, Alternatives @@ zs] && Global`fcuAffineQ[L, zs, eps] &&
        Global`fcuReVal[L, ctrAll, eN] <= 1/4 :> (PolyGamma[m, L + 1] - (-1)^m m!/L^(m + 1));
    D = Expand[psiRaise[D]];
    Do[If[! FreeQ[p[[2]], Alternatives @@ zs] && ! Global`fcuAffineQ[p[[2]], zs, eps],
         Global`fcu$fail["dressing: polygamma argument not affine: " <> ToString[p, InputForm]]],
      {p, DeleteDuplicates[Cases[D, _PolyGamma, {0, Infinity}]]}];
    (* 2. the integral representations, one fresh variable per occurrence (powers first) *)
    D = D /. Power[p_PolyGamma, n_Integer?Positive] :> Times @@ Table[Global`fcuPsiOcc[p, i], {i, n}];
    D = D /. p_PolyGamma :> Global`fcuPsiOcc[p, 0];
    D = D /. Global`fcuPsiOcc[PolyGamma[m_Integer, L_], _] /; ! FreeQ[L, Alternatives @@ zs] :>
      With[{s = newAux[]}, AppendTo[trace, {"psi-rep", m, L, "var" -> s}];
        If[m === 0, -EulerGamma + (1 - s^(L - 1))/(1 - s), -s^(L - 1) Log[s]^m/(1 - s)]];
    D = D /. Global`fcuPsiOcc[p_, _] :> p;
    D = Expand[D];
    (* 3. the rationals in the MB variables: contour-sign-correct auxiliary integrals, one variable per distinct l *)
    dd = Function[term, Module[{facs, acc = 1},
      facs = If[Head[term] === Times, List @@ term, {term}];
      Do[Which[
        FreeQ[t, Alternatives @@ zs], acc = acc t,
        MatchQ[t, Power[_, _Integer?Negative]] && Global`fcuAffineQ[t[[1]], zs, eps],
          Module[{l = t[[1]], k = -t[[2]], r = Global`fcuReVal[t[[1]], ctrAll, eN], u},
            If[r == 0, Global`fcu$fail["dressing: rational " <> ToString[l, InputForm] <> " has zero real part on the contour"]];
            u = Lookup[reg, l, None];
            If[u === None, u = newAux[]; reg[l] = u; AppendTo[trace, {"rational", l, "var" -> u, "Re" -> r}]];
            acc = acc If[r > 0, u^(l - 1) (-Log[u])^(k - 1)/(k - 1)!, (-1)^k u^(-l - 1) (-Log[u])^(k - 1)/(k - 1)!]],
        MatchQ[t, Power[_, _]] && FreeQ[t[[1]], Alternatives @@ zs] && Global`fcuAffineQ[t[[2]], zs, eps], acc = acc t,
        PolynomialQ[t, zs], acc = acc t,
        True, Global`fcu$fail["dressing: factor not representable: " <> ToString[t, InputForm]]], {t, facs}];
      acc]];
    terms = If[Head[D] === Plus, List @@ D, {D}];
    out = Total[dd /@ terms];
    <|"Failed" -> False, "K" -> K, "Dressing" -> out, "Vars" -> aux, "Prefactor" -> prefD, "Trace" -> trace|>], Global`fcu$tag];
  Global`fcuSplitZ[term_, z_] := Module[{facs, zfree = 1, lam = 1, poly = 1},
    facs = If[Head[term] === Times, List @@ term, {term}];
    Do[Which[
      FreeQ[t, z], zfree = zfree t,
      MatchQ[t, Power[_, _]] && FreeQ[t[[1]], z] && PolynomialQ[t[[2]], z] && Exponent[t[[2]], z] === 1,
        lam = lam t[[1]]^Coefficient[t[[2]], z, 1]; zfree = zfree t[[1]]^(t[[2]] /. z -> 0),
      PolynomialQ[t, z], poly = poly t,
      True, Global`fcu$fail["factor neither exponential-linear nor polynomial in " <> ToString[z] <> ": " <> ToString[t, InputForm]]],
     {t, facs}];
    {zfree, lam, poly}];
  (* withGamma False: the kernel's Gamma(a+b) carries another MB variable and is booked as a numerator leg of the
     later stages instead of being multiplied into the cube (2026-09-11) *)
  Global`fcuKernel[a_, b_, lam_, poly_, z_, withGamma_ : True] := Module[{cs, LL, K, res = 0, nu = a + b},
    cs = CoefficientList[Expand[poly], z];
    K = LL^a (1 + LL)^(-nu);
    Do[res += cs[[k + 1]] Nest[Simplify[LL D[#, LL]] &, K, k], {k, 0, Length[cs] - 1}];
    If[TrueQ[withGamma], Gamma[nu], 1] (res /. LL -> lam)];

  (* ======================= v1 inversion (2026-09-09; kept verbatim as the fallback) ======================= *)
  Global`fcuInvertV1[f_, zs_List, ctr_List, eps_, order_List, eN_, plan_List : {}] := Catch[Module[
    {dec, gam, rest, cube = 1, pref = 1, vars = {}, nv = 0, newVar, ctrAll, z, lz, num, den, other, kerA, kerB, a, b, best, terms, total},
    newVar[] := (nv++; Module[{v = Symbol["Global`fcv" <> ToString[nv]]}, AppendTo[vars, v]; v]);
    Global`$fcuTrace = {};
    dec = Global`fcuDecompose[f, zs]; gam = dec["Gammas"]; rest = dec["Rest"];
    ctrAll = ctr;
    Do[
      z = order[[iz]];
      lz = Select[gam, ! FreeQ[#[[1]], z] &]; other = Select[gam, FreeQ[#[[1]], z] &];
      num = Flatten[Table[ConstantArray[{g[[1]], 1}, g[[2]]], {g, Select[lz, #[[2]] > 0 &]}], 1];
      den = Flatten[Table[ConstantArray[{g[[1]], 1}, -g[[2]]], {g, Select[lz, #[[2]] < 0 &]}], 1];
      If[AnyTrue[Join[num, den], Abs[Coefficient[#[[1]], z, 1]] =!= 1 &], Global`fcu$fail["slope not +-1 in " <> ToString[z]]];
      num = Flatten[Table[Module[{l = g[[1]], r, k},
          r = Global`fcuReVal[l, ctrAll, eN];
          If[r > 0, {{l, 1}},
            k = Floor[-r] + 1;
            Do[Module[{v = newVar[]}, cube = cube (-1) v^(-(l + j) - 1)], {j, 0, k - 1}];
            AppendTo[Global`$fcuTrace, {z, "shift", l, "k" -> k}];
            {{l + k, 1}}]], {g, num}], 1];
      Module[{minus = Select[num, Coefficient[#[[1]], z, 1] === -1 &], plus = Select[num, Coefficient[#[[1]], z, 1] === 1 &],
              cands = {}, pickIdx},
        If[minus === {} || plus === {}, Global`fcu$fail["no kernel pair for " <> ToString[z]]];
        Do[Module[{aa = m[[1]] + z, bb = p[[1]] - z, s},
          s = Length[Intersection[Cases[aa + bb, _Symbol, {0, Infinity}], zs]] + Abs[Coefficient[aa + bb, eps, 0]];
          AppendTo[cands, {s, {m, p, aa, bb}}]], {m, minus}, {p, plus}];
        cands = SortBy[cands, First][[All, 2]];
        pickIdx = If[iz <= Length[plan] && IntegerQ[plan[[iz]]], Min[plan[[iz]], Length[cands]], 1];
        best = cands[[pickIdx]];
        kerA = best[[1]]; kerB = best[[2]]; a = Simplify[best[[3]]]; b = Simplify[best[[4]]];
        AppendTo[Global`$fcuTrace, {z, "kernel", kerA[[1]], kerB[[1]], "a" -> a, "b" -> b}];
        num = Delete[num, {{First@Position[num, kerA][[1]]}}]; num = Delete[num, {{First@Position[num, kerB][[1]]}}]];
      Do[Module[{l = d[[1]], s = Coefficient[d[[1]], z, 1], cands, pick, gap, m = 0, v, lnum},
        cands = Select[Range[Length[num]], Coefficient[num[[#, 1]], z, 1] === s &];
        If[cands === {}, Global`fcu$fail["denominator " <> ToString[l, InputForm] <> " has no same-slope numerator partner"]];
        pick = First[SortBy[cands, -Global`fcuReVal[l - num[[#, 1]], ctrAll, eN] &]];
        lnum = num[[pick, 1]]; gap = Global`fcuReVal[l - lnum, ctrAll, eN];
        If[gap <= 0, m = Floor[-gap] + 1; cube = cube Product[l + j, {j, 0, m - 1}]];
        v = newVar[]; cube = cube v^(lnum - 1) (1 - v)^(l + m - lnum - 1);
        AppendTo[other, {l + m - lnum, -1}];
        AppendTo[Global`$fcuTrace, {z, "den-pair", l, lnum, "shift" -> m, "var" -> v}];
        num = Delete[num, pick]], {d, den}];
      Module[{minus = Select[num, Coefficient[#[[1]], z, 1] === -1 &], plus = Select[num, Coefficient[#[[1]], z, 1] === 1 &]},
        If[Length[minus] =!= Length[plus], Global`fcu$fail["unbalanced numerators for " <> ToString[z]]];
        Do[Module[{v = newVar[], l1 = plus[[i, 1]], l2},
          l2 = minus[[1, 1]]; minus = Delete[minus, 1];
          cube = cube v^(l1 - 1) (1 - v)^(l2 - 1);
          AppendTo[Global`$fcuTrace, {z, "num-pair", l1, l2, "var" -> v}];
          AppendTo[other, {l1 + l2, 1}]], {i, Length[plus]}]];
      terms = If[Head[#] === Plus, List @@ #, {#}] &[Expand[cube]];
      total = 0;
      Do[Module[{sp3 = Global`fcuSplitZ[t, z], lam},
        lam = PowerExpand[sp3[[2]]];
        total += sp3[[1]] Global`fcuKernel[a, b, lam, sp3[[3]], z]], {t, terms}];
      cube = total; gam = other;
      ctrAll = DeleteCases[ctrAll, HoldPattern[z -> _]],
     {iz, Length[order]}];
    Do[If[! FreeQ[g[[1]], Alternatives @@ zs], Global`fcu$fail["MB-variable Gamma survived: " <> ToString[g, InputForm]]];
       pref = pref Gamma[g[[1]]]^g[[2]], {g, gam}];
    <|"Failed" -> False, "Cube" -> cube, "Vars" -> vars, "Prefactor" -> pref rest, "Order" -> order, "Rules" -> "v1", "Merged" -> {}|>], Global`fcu$tag];

  (* ======================= v2 inversion (2026-09-10) ======================= *)
  (* an affine form over the MB variables: l = s (g . zs) + c, g canonical (first non-zero entry positive), s = +-1 *)
  Global`fcuCanon[l_, zs_List] := Module[{graw = Coefficient[l, #] & /@ zs, pos, s, g},
    pos = Select[Range[Length[graw]], graw[[#]] =!= 0 &];
    If[pos === {}, Return[$Failed]];
    s = Sign[graw[[First[pos]]]]; g = s graw;
    {g, s, Simplify[l - graw . zs]}];
  Global`fcuOthersIn[e_, zs_List, z_] := Length[Select[DeleteCases[zs, z], ! FreeQ[e, #] &]];
  (* partial fractions of a proper rational function of the formal variable T: {{A, c, j}} with rat = Sum A/(T+c)^j *)
  Global`fcuPFTerms[rat_, T_] := Catch[Module[{ap, terms, out = {}},
    ap = Apart[Together[rat], T];
    terms = If[Head[ap] === Plus, List @@ ap, {ap}];
    Do[Module[{num = Numerator[t], den = Denominator[t], fl, c = None, j = 0, coef = 1},
       If[! FreeQ[num, T], Throw[$Failed, Global`fcuPF]];
       fl = FactorList[den];
       Do[Which[FreeQ[f[[1]], T], coef = coef f[[1]]^f[[2]],
          PolynomialQ[f[[1]], T] && Exponent[f[[1]], T] === 1,
            If[c =!= None, Throw[$Failed, Global`fcuPF]];
            c = Simplify[(f[[1]] /. T -> 0)/Coefficient[f[[1]], T]]; coef = coef Coefficient[f[[1]], T]^f[[2]]; j = f[[2]],
          True, Throw[$Failed, Global`fcuPF]], {f, fl}];
       If[c === None, Throw[$Failed, Global`fcuPF]];
       AppendTo[out, {Together[num/coef], c, j}]], {t, terms}];
    out], Global`fcuPF];
  (* the collected rationals {{l, k}} (1/l^k) -> Euler factors: one variable per linear direction *)
  Global`fcuMergeRationals[rats_List, zs_List, ctrAll_, eN_, eps_, newVar_] := Module[{groups, factor = 1, pref = 1, merged = {}},
    If[rats === {}, Return[{1, 1, {}}]];
    groups = GatherBy[rats, Global`fcuCanon[#[[1]], zs][[1]] &];
    Do[Module[{g, T, prod = 1, terms, expr = 0, w, tog, num, den},
       g = Global`fcuCanon[grp[[1, 1]], zs][[1]];
       T = Unique["Global`fcuT"];
       Do[Module[{cn = Global`fcuCanon[e[[1]], zs], s, c}, s = cn[[2]]; c = cn[[3]];
          prod = prod s^(-e[[2]]) / (T + c/s)^e[[2]]], {e, grp}];   (* 1/l^k = s^-k/(T + c/s)^k, l = s (T + c/s) *)
       terms = Global`fcuPFTerms[prod, T];
       If[terms === $Failed, Global`fcu$fail["partial fractions failed for the rational group " <> ToString[grp, InputForm]]];
       w = newVar[]; AppendTo[merged, w];
       (* the pole coefficients are rational in eps only (the group shares one gradient, so the c's are eps-constants):
          their common denominator is the bracket's eps-pole and goes to the prefactor *)
       den = PolynomialLCM @@ (Denominator[Together[#[[1]]]] & /@ terms);
       If[! FreeQ[den, Alternatives @@ zs], Global`fcu$fail["merged rational bracket has a non-constant denominator"]];
       Do[Module[{A = Cancel[Together[t[[1]] den]], c = t[[2]], j = t[[3]], L, r},
          L = g . zs + c; r = Global`fcuReVal[L, ctrAll, eN];
          If[r == 0, Global`fcu$fail["rational " <> ToString[L, InputForm] <> " has zero real part on the contour"]];
          expr += A If[r > 0, w^(L - 1) (-Log[w])^(j - 1)/(j - 1)!, (-1)^j w^(-L - 1) (-Log[w])^(j - 1)/(j - 1)!]],
         {t, terms}];
       num = expr;
       pref = pref/den; factor = factor num;
       AppendTo[Global`$fcuTrace, {"merge", grp[[All, 1]], "var" -> w, "poles" -> Length[terms], "eps-denominator" -> den}]],
      {grp, groups}];
    {factor, pref, merged}];

  Global`fcuInvertV2[f_, zs_List, ctr_List, eps_, order_List, eN_, plan_List : {}, dress_ : None] := Catch[Module[
    {dec, gam, rest, cube = 1, pref = 1, vars = {}, nv = 0, newVar, ctrAll, z, lz, num, den, other, kerA, kerB, a, b, best,
     terms, total, rats, mergedAll = {}, mr, nuK, kerGamma = True, slopesOK},
    newVar[] := (nv++; Module[{v = Symbol["Global`fcv" <> ToString[nv]]}, AppendTo[vars, v]; v]);
    Global`$fcuTrace = {};
    dec = Global`fcuDecompose[f, zs]; gam = dec["Gammas"]; rest = dec["Rest"];
    (* a dressed residue: the dressing (scales and auxiliary Euler variables) is the initial cube *)
    If[AssociationQ[dress], cube = dress["Dressing"]; vars = Join[vars, dress["Vars"]]; Global`$fcuTrace = dress["Trace"]];
    ctrAll = ctr;
    (* 2026-09-11: legs of slope +-2 are admitted ($fcuSlope2, default True): they pair like unit legs (same-slope
       den-pairs, opposite-sign num-pairs whose sum may still carry z and is paired again); the kernel stays unit-slope *)
    slopesOK = If[Global`$fcuSlope2 === False, {1}, {1, 2}];
    Do[
      z = order[[iz]]; rats = {};
      lz = Select[gam, ! FreeQ[#[[1]], z] &]; other = Select[gam, FreeQ[#[[1]], z] &];
      num = Flatten[Table[ConstantArray[{g[[1]], 1}, g[[2]]], {g, Select[lz, #[[2]] > 0 &]}], 1];
      den = Flatten[Table[ConstantArray[{g[[1]], 1}, -g[[2]]], {g, Select[lz, #[[2]] < 0 &]}], 1];
      If[AnyTrue[Join[num, den], ! MemberQ[slopesOK, Abs[Coefficient[#[[1]], z, 1]]] &], Global`fcu$fail["slope not +-1 in " <> ToString[z]]];
      (* 1. contour regularisation of the numerator legs (rationals collected) *)
      num = Flatten[Table[Module[{l = g[[1]], r, k},
          r = Global`fcuReVal[l, ctrAll, eN];
          If[r > 0, {{l, 1}},
            k = Floor[-r] + 1;
            Do[AppendTo[rats, {l + j, 1}], {j, 0, k - 1}];
            AppendTo[Global`$fcuTrace, {z, "shift", l, "k" -> k}];
            {{l + k, 1}}]], {g, num}], 1];
      (* 2. S1: denominators at integer distance from a same-slope numerator *)
      den = Select[den, Function[d, Module[{l = d[[1]], s = Coefficient[d[[1]], z, 1], cands, pick, n, lnum},
          cands = Select[Range[Length[num]], Coefficient[num[[#, 1]], z, 1] === s && IntegerQ[Simplify[l - num[[#, 1]]]] &];
          If[cands === {}, True,
            pick = First[SortBy[cands, Abs[Simplify[l - num[[#, 1]]]] &]];
            lnum = num[[pick, 1]]; n = Simplify[l - lnum];
            Which[n > 0, Do[AppendTo[rats, {lnum + j, 1}], {j, 0, n - 1}],
                  n < 0, cube = cube Product[l + j, {j, 0, -n - 1}]];
            AppendTo[Global`$fcuTrace, {z, "S1", l, lnum, "n" -> n}];
            num = Delete[num, pick];
            False]]]];
      (* 3. S2 den-pairs: partner with a ratio free of the other variables; no shift unless the gap is <= -1 *)
      Do[Module[{l = d[[1]], s = Coefficient[d[[1]], z, 1], cands, pick, gap, m = 0, v, lnum, score},
        cands = Select[Range[Length[num]], Coefficient[num[[#, 1]], z, 1] === s &];
        If[cands === {}, Global`fcu$fail["denominator " <> ToString[l, InputForm] <> " has no same-slope numerator partner"]];
        score[i_] := Module[{gp = Global`fcuReVal[l - num[[i, 1]], ctrAll, eN]},
          {Global`fcuOthersIn[Simplify[l - num[[i, 1]]], zs, z], Which[gp > 0, 0, gp > -1, 1, True, 2], -gp}];
        pick = First[SortBy[cands, score]];
        lnum = num[[pick, 1]]; gap = Global`fcuReVal[l - lnum, ctrAll, eN];
        If[gap <= -1, m = Floor[-gap]; cube = cube Product[l + j, {j, 0, m - 1}]];
        If[Global`fcuReVal[l + m - lnum, ctrAll, eN] == 0, Global`fcu$fail["den-pair gap exactly zero for " <> ToString[l, InputForm]]];
        v = newVar[]; cube = cube v^(lnum - 1) (1 - v)^(l + m - lnum - 1);
        AppendTo[other, {l + m - lnum, -1}];
        AppendTo[Global`$fcuTrace, {z, "den-pair", l, lnum, "shift" -> m, "var" -> v, "face" -> (gap + m < 0)}];
        num = Delete[num, pick]], {d, den}];
      (* 4. the kernel: a, b free of the other MB variables preferred, then an eps-free a+b, then the smaller constant *)
      Module[{minus = Select[num, Coefficient[#[[1]], z, 1] === -1 &], plus = Select[num, Coefficient[#[[1]], z, 1] === 1 &],
              cands = {}, pickIdx},
        If[minus === {} || plus === {}, Global`fcu$fail["no kernel pair for " <> ToString[z]]];
        Do[Module[{aa = Simplify[m[[1]] + z], bb = Simplify[p[[1]] - z], s},
          s = {Global`fcuOthersIn[aa, zs, z] + Global`fcuOthersIn[bb, zs, z], If[FreeQ[Simplify[aa + bb], eps], 0, 1],
               Abs[Coefficient[Expand[aa + bb], eps, 0]]};
          AppendTo[cands, {s, {m, p, aa, bb}}]], {m, minus}, {p, plus}];
        cands = SortBy[cands, First][[All, 2]];
        pickIdx = If[iz <= Length[plan] && IntegerQ[plan[[iz]]], Min[plan[[iz]], Length[cands]], 1];
        best = cands[[pickIdx]];
        kerA = best[[1]]; kerB = best[[2]]; a = best[[3]]; b = best[[4]];
        (* 2026-09-11: a kernel Gamma(a+b) that carries another MB variable is a numerator leg of the later stages
           (it used to be multiplied into the cube, where the later stage could not pair it) *)
        nuK = Simplify[a + b]; kerGamma = FreeQ[nuK, Alternatives @@ DeleteCases[zs, z]];
        If[! kerGamma, AppendTo[other, {nuK, 1}]];
        AppendTo[Global`$fcuTrace, {z, "kernel", kerA[[1]], kerB[[1]], "a" -> a, "b" -> b, "deferred" -> ! kerGamma}];
        num = Delete[num, {{First@Position[num, kerA][[1]]}}]; num = Delete[num, {{First@Position[num, kerB][[1]]}}]];
      (* 5. num-pairs (2026-09-11: any opposite-sign slopes; a z-free sum (equal |slope|) first, then a sum free of the
            other variables, then list order; a sum that still carries z re-enters the pool) *)
      Module[{pool = num, plus, minus, sl},
        sl[l_] := Coefficient[l, z, 1];
        If[Total[sl /@ pool[[All, 1]]] =!= 0, Global`fcu$fail["unbalanced numerators for " <> ToString[z]]];
        While[pool =!= {},
          plus = Select[pool, sl[#[[1]]] > 0 &]; minus = Select[pool, sl[#[[1]]] < 0 &];
          If[plus === {} || minus === {}, Global`fcu$fail["unbalanced numerators for " <> ToString[z]]];
          Module[{pairs, best2, v, l1, l2, nl},
            pairs = SortBy[Tuples[{Range[Length[plus]], Range[Length[minus]]}],
              {Abs[sl[plus[[#[[1]], 1]]] + sl[minus[[#[[2]], 1]]]],
               Global`fcuOthersIn[Simplify[plus[[#[[1]], 1]] + minus[[#[[2]], 1]]], zs, z], #} &];
            best2 = First[pairs]; l1 = plus[[best2[[1]], 1]]; l2 = minus[[best2[[2]], 1]];
            v = newVar[]; cube = cube v^(l1 - 1) (1 - v)^(l2 - 1);
            nl = Simplify[l1 + l2];
            AppendTo[Global`$fcuTrace, {z, "num-pair", l1, l2, "var" -> v}];
            pool = Delete[pool, First@Position[pool, plus[[best2[[1]]]], {1}, 1]];
            pool = Delete[pool, First@Position[pool, minus[[best2[[2]]]], {1}, 1]];
            If[sl[nl] === 0, AppendTo[other, {nl, 1}], AppendTo[pool, {nl, 1}]]]]];
      (* 6. the rationals of this stage, merged per linear direction *)
      mr = Global`fcuMergeRationals[rats, zs, ctrAll, eN, eps, newVar];
      cube = cube mr[[1]]; pref = pref mr[[2]]; mergedAll = Join[mergedAll, mr[[3]]];
      (* 7. collapse *)
      terms = If[Head[#] === Plus, List @@ #, {#}] &[Expand[cube]];
      total = 0;
      Do[Module[{sp3 = Global`fcuSplitZ[t, z], lam},
        lam = PowerExpand[sp3[[2]]];
        total += sp3[[1]] Global`fcuKernel[a, b, lam, sp3[[3]], z, kerGamma]], {t, terms}];
      cube = total; gam = other;
      ctrAll = DeleteCases[ctrAll, HoldPattern[z -> _]],
     {iz, Length[order]}];
    Do[If[! FreeQ[g[[1]], Alternatives @@ zs], Global`fcu$fail["MB-variable Gamma survived: " <> ToString[g, InputForm]]];
       pref = pref Gamma[g[[1]]]^g[[2]], {g, gam}];
    <|"Failed" -> False, "Cube" -> cube, "Vars" -> vars, "Prefactor" -> pref rest, "Order" -> order, "Rules" -> "v2",
      "Merged" -> mergedAll|>], Global`fcu$tag];
  Global`fcuInvert[f_, zs_List, ctr_List, eps_, order_List, eN_, plan_List : {}] :=
    If[Global`$fcuRules === "v1", Global`fcuInvertV1[f, zs, ctr, eps, order, eN, plan], Global`fcuInvertV2[f, zs, ctr, eps, order, eN, plan]];

  (* positive-atom normal form: (1+M/N)^p -> (N+M)^p N^(-p), every base positive on the open cube *)
  Global`fcuPosify[expr_, vars_] := Module[{fl = FactorList[expr], sign = 1, out = 1, centre = Thread[vars -> 1/2]},
    Do[Module[{f = fl[[i, 1]], k = fl[[i, 2]], fp},
      Which[
        NumericQ[f], If[f < 0, sign = sign (-1)^k; out = out (-f)^k, out = out f^k],
        True, fp = If[(f /. centre) < 0, sign = sign (-1)^k; Expand[-f], f]; out = out fp^k]], {i, Length[fl]}];
    {sign, out}];
  (* every Power[b, p] with a base depending on the cube variables is rewritten with POSITIVE atoms: an atom monomial
     b (products of v, 1-v, numbers) keeps its atoms; a compound base b = num/den (e.g. 1 + M/N = (N+M)/N) becomes
     num^p den^(-p) with each of num, den sign-normalised; PowerExpand under 0 < v < 1 then splits the atom products,
     so that all powers of one atom combine (the face census reads the combined exponents) *)
  (* the sign-normalised factor list of a rational expression: {sign, {{positive factor, integer power}..}} *)
  Global`fcuPosFactors[expr_, vars_] := Module[{fl = FactorList[Together[expr]], sign = 1, out = {}, centre = Thread[vars -> 1/2]},
    Do[Module[{f = fl[[i, 1]], k = fl[[i, 2]], fp},
      Which[
        NumericQ[f], If[f < 0, sign = sign (-1)^k; If[f =!= -1, AppendTo[out, {-f, k}]], If[f =!= 1, AppendTo[out, {f, k}]]],
        True, fp = If[(f /. centre) < 0, sign = sign (-1)^k; Expand[-f], f]; AppendTo[out, {fp, k}]]], {i, Length[fl]}];
    {sign, out}];
  Global`fcuNormalize[cube_, vars_, eps_] := Module[{terms, out = 0},
    terms = If[Head[#] === Plus, List @@ #, {#}] &[Expand[cube]];
    Do[Module[{facs, acc = 1},
      facs = If[Head[t] === Times, List @@ t, {t}];
      Do[Which[
        MatchQ[fa, Power[_, _]] && ! FreeQ[fa[[1]], Alternatives @@ vars],
          Module[{p = fa[[2]], pf = Global`fcuPosFactors[fa[[1]], vars]},
            If[pf[[1]] =!= 1 && ! IntegerQ[p], Global`fcu$fail["base not positive on the cube: " <> ToString[fa, InputForm]]];
            acc = acc If[IntegerQ[p], pf[[1]]^p, 1] Times @@ (#[[1]]^(#[[2]] p) & /@ pf[[2]])],
        True, acc = acc fa], {fa, facs}];
      out += acc], {t, terms}];
    out];

  (* ---------- faces and the master subtraction equation ---------- *)
  Global`fcuAtomQ[b_, vars_] := MemberQ[vars, b] || MatchQ[b, 1 - v_Symbol /; MemberQ[vars, v]];
  Global`fcuAtomVar[b_, vars_] := First[Cases[{b}, v_Symbol /; MemberQ[vars, v], {0, Infinity}]];
  (* combined exponents of the monomial atoms of ONE term *)
  Global`fcuAtomExponents[term_, vars_] := Module[{facs, out = <||>},
    facs = If[Head[term] === Times, List @@ term, {term}];
    Do[Module[{b = None, e = 0},
       Which[MatchQ[f, Power[_, _]], {b, e} = List @@ f, Global`fcuAtomQ[f, vars], {b, e} = {f, 1}];
       If[b =!= None && Global`fcuAtomQ[b, vars], out[b] = Lookup[out, b, 0] + e]], {f, facs}];
    out];
  Global`fcuFacesOfTerm[term_, vars_, eps_] := Module[{ex = Global`fcuAtomExponents[term, vars], out = {}},
    Do[Module[{e = ex[a], c, k}, c = Simplify[e /. eps -> 0]; k = Simplify[Coefficient[Expand[e], eps]];
       If[IntegerQ[c] && c <= -1, AppendTo[out, <|"Atom" -> a, "Exp" -> e, "c" -> c, "k" -> k, "n" -> -c,
           "Var" -> Global`fcuAtomVar[a, vars], "y0" -> If[MatchQ[a, 1 - _], 1, 0]|>]]], {a, Keys[ex]}];
    out];
  (* Taylor data of R at the face: {R, R', R'', ...}/i! at y = y0 *)
  Global`fcuTaylorData[R_, face_] := Module[{y = face["Var"], y0 = face["y0"]},
    Table[(D[R, {y, i}] /. y -> y0)/i!, {i, 0, face["n"] - 1}]];
  (* T_l R (the Taylor polynomial), and the moment application M_l R (the face variable integrated exactly) *)
  Global`fcuTaylorPoly[td_, face_] := Module[{y = face["Var"], y0 = face["y0"]}, Sum[td[[i + 1]] (y - y0)^i, {i, 0, Length[td] - 1}]];
  Global`fcuMoment[td_, face_, eps_] := Module[{sg = If[face["y0"] === 1, -1, 1], e = face["Exp"]},
    Sum[td[[i + 1]] sg^i/(e + i + 1), {i, 0, Length[td] - 1}]];
  (* the structural pieces of a cube: for every group of terms sharing the exponents of its face atoms, the tensor
     inclusion-exclusion over its faces; a piece = <|"Prefactor" (the retained a^e factors), "R" (regular part),
     "Faces" (retained faces, with their Taylor subtraction), "Moments" (resolved faces), "Vars"|> *)
  Global`fcuFacePieces[cube_, vars_, eps_] := Module[{terms, groups, out = {}},
    terms = If[Head[#] === Plus, List @@ #, {#}] &[Expand[cube]];
    groups = GatherBy[terms, Module[{fs = Global`fcuFacesOfTerm[#, vars, eps]}, Sort[{#["Atom"], #["Exp"]} & /@ fs]] &];
    Do[Module[{faces = Global`fcuFacesOfTerm[grp[[1]], vars, eps], G = Total[grp], R, vsAll = vars},
       (* a logarithm of the face ATOM cannot be Taylor-expanded at the face (log of the other atom of the variable is
          analytic there) *)
       Do[If[! FreeQ[G, Log[fc["Atom"]]],
            Global`fcu$fail["face " <> ToString[fc["Atom"], InputForm] <> "^(" <> ToString[fc["Exp"], InputForm] <>
              ") cannot be subtracted (logarithm of the face atom)"]], {fc, faces}];
       If[! DuplicateFreeQ[#["Var"] & /@ faces],
         Global`fcu$fail["two faces on one variable (" <> ToString[#["Atom"]^#["Exp"] & /@ faces, InputForm] <> "): a two-point subtraction is not implemented"]];
       (* the regular part, the face powers removed TERM BY TERM (so that the powers of a face atom combine) *)
       R = Total[Table[t Times @@ (#["Atom"]^(-#["Exp"]) & /@ faces), {t, grp}]];
       (* an eps-free face (integer exponent, no regulator) is admissible only when the regular part vanishes there to
          the order of the pole (the polygamma representations' (1 - s^(L-1))/(1-s)): such a face needs no subtraction
          and is kept inside the regular part; otherwise the piece is genuinely divergent and the rung refuses *)
       Do[Module[{td = Simplify /@ Global`fcuTaylorData[R, fc]},
          If[AllTrue[td, TrueQ[PossibleZeroQ[#]] &],
            R = R fc["Atom"]^fc["Exp"]; faces = DeleteCases[faces, fc],
            Global`fcu$fail["face " <> ToString[fc["Atom"], InputForm] <> "^(" <> ToString[fc["Exp"], InputForm] <>
              ") has an eps-free exponent and non-vanishing Taylor data"]]], {fc, Select[faces, #["k"] === 0 &]}];
       Do[If[! FreeQ[R, fc["Atom"]^_ ] && ! FreeQ[Cases[R, Power[fc["Atom"], e_] :> e, {0, Infinity}], eps],
            Global`fcu$fail["the regular part of face " <> ToString[fc["Atom"], InputForm] <> " still carries an eps-power of the face atom"]], {fc, faces}];
       If[faces === {}, AppendTo[out, <|"Prefactor" -> 1, "R" -> R, "Faces" -> {}, "Moments" -> {}, "Vars" -> vars|>],
         Do[Module[{S = Complement[faces, T], vs = vars, pf = 1},
            vs = DeleteCases[vs, Alternatives @@ (#["Var"] & /@ S)];
            pf = Times @@ (#["Atom"]^#["Exp"] & /@ T);
            AppendTo[out, <|"Prefactor" -> pf, "R" -> R, "Faces" -> T, "Moments" -> S, "Vars" -> vs|>]], {T, Subsets[faces]}]]],
      {grp, groups}];
    out];
  (* apply the operators of a piece to an expression X (the moments first, then the subtractions), then multiply the
     retained face powers: pf * prod_{l in Faces}(1-T_l) prod_{l in Moments} M_l X *)
  Global`fcuApplyOps[piece_, X_, eps_] := Module[{Y = X},
    Do[Y = Global`fcuMoment[Global`fcuTaylorData[Y, fc], fc, eps], {fc, piece["Moments"]}];
    Do[Y = Y - Global`fcuTaylorPoly[Global`fcuTaylorData[Y, fc], fc], {fc, piece["Faces"]}];
    piece["Prefactor"] Y];
  (* log-monomial split of an eps-free expression by the powers of the given logs only *)
  Global`fcuLogPiecesBy[ck_, logs_List] := Module[{lv, e2, cr},
    If[logs === {} || ck === 0, Return[If[ck === 0, {}, {Global`fcuCombine[ck]}]]];
    lv = Table[Symbol["Global`fcuL" <> ToString[i]], {i, Length[logs]}];
    e2 = Expand[ck /. Thread[logs -> lv]];
    cr = CoefficientRules[e2, lv];
    Table[(Times @@ (lv^r[[1]])) Global`fcuCombine[r[[2]]] /. Thread[lv -> logs], {r, cr}]];
  (* the rational coefficient of a log monomial: combined over the common denominator when that stays small (the
     piece expressions of every earlier bank are unchanged); otherwise combined per denominator class and left as a
     sum (2026-09-11, MB10 residue 4: a raw coefficient of 2.5k leaves became ONE fraction of 880k leaves over eight
     letters with powers 3..5, and every integrator stalled on it; the class-wise sum is the same function) *)
  Global`fcuCombine[c_] := Module[{t, terms},
    t = Quiet@TimeConstrained[Together[c], Global`$fcuTogetherSeconds, $Failed];
    If[t =!= $Failed && LeafCount[t] <= Global`$fcuTogetherMaxLeaves, Return[t]];
    terms = If[Head[#] === Plus, List @@ #, {#}] &[Expand[c]];
    Total[Together[Total[#]] & /@ GatherBy[terms, Denominator]]];
  Global`fcuLogPieces[ck_] := Global`fcuLogPiecesBy[ck, DeleteDuplicates[Cases[ck, _Log, {0, Infinity}]]];
  (* the structural logs of a cube: the merged variables and the face atoms *)
  Global`fcuStructuralLogs[pieces_, merged_] := DeleteDuplicates[Join[Log /@ merged,
    Flatten[Table[Log[fc["Atom"]], {p, pieces}, {fc, p["Faces"]}]]]];
  (* order-k integrands of one structural piece: {integrand, vars} list *)
  (* the eps^k coefficient of X; a plain (non-SeriesData) result of Series -- a vanishing X, or a Laurent polynomial --
     is read by Coefficient, because SeriesCoefficient[0, k] stays unevaluated (the MB5 residue-25 trap, 2026-09-11) *)
  Global`fcuSerCoef[X_, eps_, k_] := Module[{s = Quiet@Series[X, {eps, 0, k}]},
    If[Head[s] === SeriesData, Quiet@Normal@SeriesCoefficient[s, k], Coefficient[Expand[s], eps, k]]];
  (* the logs that may NOT be split off a piece: the logarithm of the OTHER atom of every retained face variable
     (Log[y] for a face at y = 1, Log[1 - y] for a face at y = 0) vanishes at the face like the distance, so a split by
     its powers shares the Taylor cancellation between two jobs, each of which then carries a pole (2026-09-11, MB6
     residue 14: the Log[fcv1] job and the log-free job at cube order 1 with cancelling simple poles at fcv1 = 1; the
     certificate integrator refused both, the legacy chain served regularised values) *)
  Global`fcuCoAtomLogs[piece_] := Table[If[fc["y0"] === 1, Log[fc["Var"]], Log[1 - fc["Var"]]], {fc, piece["Faces"]}];
  Global`fcuSplitLogs[piece_, logs_List, expr_] :=
    Select[DeleteCases[DeleteDuplicates[logs], Alternatives @@ Global`fcuCoAtomLogs[piece]], ! FreeQ[expr, #] &];
  Global`fcuPieceOrder[piece_, k_, eps_, slogs_] := Module[{X, ck},
    X = Global`fcuApplyOps[piece, piece["R"], eps];
    ck = Global`fcuSerCoef[X, eps, k];
    If[ck === 0, {}, Table[{pc, piece["Vars"]}, {pc, Global`fcuLogPiecesBy[ck, Global`fcuSplitLogs[piece, slogs, ck]]}]]];
  (* fallback for a refused piece: the subtraction re-applied per log monomial of the regular part, all faces kept
     inside every sub-piece (each sub-piece is finite by construction) *)
  (* the regular part's own leading order bounds the re-expansion from below (a regular part starting below the cube's
     leading order -- every piece's leading term cancelled by the subtraction -- is not skipped) *)
  Global`fcuRLow[piece_, k_, kminR_] := Module[{lo = Global`fcuLeadOrder[piece["R"], Global`fcu$eps, Max[0, k]]}, If[lo === Infinity, kminR, Min[kminR, lo]]];
  (* the re-expansion needs the regular part up to order k + (number of moments): every resolved face contributes a
     moment 1/(k eps) (2026-09-11: the loop stopped at k and the eps^4 coefficient of MB10 residue 4's moment piece
     came out wrong by 233 at a test point -- a latent defect of the refused-piece fallback) *)
  (* the face operators on ONE expression (a log monomial of R_i or a chunk of it) and the eps^(k-i) coefficient,
     split into jobs; used by the two re-splits below, on the workers when there are any (2026-09-11: the re-split
     of a refused or oversized piece ran serially on the master for an hour while twenty subkernels idled) *)
  Global`fcuOpsJobs[piece_, Y0_, k_, i_, eps_] := Module[{Y = Y0, X, cj},
    Do[Y = Global`fcuMoment[Global`fcuTaylorData[Y, fc], fc, eps], {fc, piece["Moments"]}];
    Do[Y = Y - Global`fcuTaylorPoly[Global`fcuTaylorData[Y, fc], fc], {fc, piece["Faces"]}];
    X = piece["Prefactor"] Y;
    cj = Global`fcuSerCoef[X, eps, k - i];
    If[cj === 0, {}, Table[{pc, piece["Vars"]},
      {pc, Global`fcuLogPiecesBy[cj, Global`fcuSplitLogs[piece, Cases[cj, _Log, {0, Infinity}], cj]]}]]];
  Global`fcuOpsJobsAll[piece_, tasks_List, k_, eps_] :=
    Join @@ If[Kernels[] =!= {} && Length[tasks] >= 2,
      With[{p = piece, kk = k, e = eps}, ParallelMap[Function[t, Global`fcuOpsJobs[p, t[[2]], kk, t[[1]], e]], tasks, Method -> "FinestGrained"]],
      Table[Global`fcuOpsJobs[piece, t[[2]], k, t[[1]], eps], {t, tasks}]];
  Global`fcuPieceFallback[piece_, k_, eps_, kminR_] := Module[{Rser, tasks = {}, i0, nM = Length[piece["Moments"]]},
    i0 = Block[{Global`fcu$eps = eps}, Global`fcuRLow[piece, k, kminR]];
    Rser = Series[piece["R"], {eps, 0, Max[k - i0, k + nM]}];
    Do[Module[{Ri = If[Head[Rser] === SeriesData, Quiet@Normal@SeriesCoefficient[Rser, i], Coefficient[Expand[Rser], eps, i]]},
       If[Ri === 0, Continue[]];
       Do[AppendTo[tasks, {i, mon}], {mon, Global`fcuLogPieces[Ri]}]],
      {i, i0, k + nM}];
    Global`fcuOpsJobsAll[piece, tasks, k, eps]];
  (* oversized pieces (2026-09-11, MB10 residue 4: one eps^0 piece of 880k leaves that no integrator parses in time):
     the structural piece is re-split per log monomial AND per chunk of additive terms of the regular part, the face
     subtraction re-applied to every chunk -- the operators are linear, so every chunk is finite by construction *)
  Global`fcuPieceChunked[piece_, k_, eps_, kminR_, maxLeaves_] := Module[{Rser, tasks = {}, i0, nM = Length[piece["Moments"]]},
    i0 = Block[{Global`fcu$eps = eps}, Global`fcuRLow[piece, k, kminR]];
    Rser = Series[piece["R"], {eps, 0, Max[k - i0, k + nM]}];
    Do[Module[{Ri = If[Head[Rser] === SeriesData, Quiet@Normal@SeriesCoefficient[Rser, i], Coefficient[Expand[Rser], eps, i]]},
       If[Ri === 0, Continue[]];
       Do[Module[{terms, chunks = {}, cur = {}, acc = 0},
          terms = If[Head[#] === Plus, List @@ #, {#}] &[Expand[mon]];
          Do[If[acc + LeafCount[t] > maxLeaves && cur =!= {}, AppendTo[chunks, Total[cur]]; cur = {}; acc = 0];
             AppendTo[cur, t]; acc += LeafCount[t], {t, terms}];
          If[cur =!= {}, AppendTo[chunks, Total[cur]]];
          Do[AppendTo[tasks, {i, ch}], {ch, chunks}]], {mon, Global`fcuLogPieces[Ri]}]],
      {i, i0, k + nM}];
    Global`fcuOpsJobsAll[piece, tasks, k, eps]];
  Global`fcuLeadOrderOfSeries[s_, X_] :=
    Which[Head[s] === SeriesData && s[[3]] =!= {}, s[[4]]/s[[6]], Head[s] === SeriesData, Infinity, TrueQ[PossibleZeroQ[X]], Infinity, True, 0];
  Global`fcuLeadOrder[X_, eps_, kmax_] := Global`fcuLeadOrderOfSeries[Quiet@Series[X, {eps, 0, kmax}], X];
  (* one eps-series per structural piece, reused for the leading order and for every cube order ($fcuSingleSeries;
     2026-09-11: the enumeration of a 3-fold residue's cube to order 4 computed the series of every piece eight times) *)
  Global`fcuPieceSeriesJobs[piece_, s_, k_, eps_, slogs_] := Module[{ck},
    ck = If[Head[s] === SeriesData, Quiet@Normal@SeriesCoefficient[s, k], Coefficient[Expand[s], eps, k]];
    If[ck === 0, {}, Table[{pc, piece["Vars"]}, {pc, Global`fcuLogPiecesBy[ck, Global`fcuSplitLogs[piece, slogs, ck]]}]]];

  (* kernel-first integration order (subtraction paper, "Kernel-first ordering") -- the order HINT of the fallback call *)
  Global`fcuAtomMonomialQ[expr_, vars_] := Module[{fl = FactorList[expr]},
    AllTrue[fl[[All, 1]], (NumericQ[#] || MemberQ[vars, #] || MatchQ[#, 1 - v_Symbol /; MemberQ[vars, v]] || MatchQ[#, -1 + v_Symbol /; MemberQ[vars, v]]) &]];
  Global`fcuKernelFirstOrder[expr_, vars_] := Module[{letters, kern = <||>, trusted, shared, rest},
    letters = DeleteDuplicates[Cases[expr, Power[b_, _] /; PolynomialQ[b, vars] && ! Global`fcuAtomMonomialQ[b, vars] :> Expand[b], {0, Infinity}]];
    letters = DeleteDuplicates[Join[letters, Cases[expr, Log[b_] /; PolynomialQ[b, vars] && ! Global`fcuAtomMonomialQ[b, vars] :> Expand[b], {0, Infinity}]]];
    Do[Do[If[PolynomialQ[L, p] && Exponent[L, p] === 1,
        Module[{A = Expand[L /. p -> 1], B = Expand[L /. p -> 0]},
          If[A =!= 0 && B =!= 0 && Global`fcuAtomMonomialQ[A, vars] && Global`fcuAtomMonomialQ[B, vars],
            kern[p] = Append[Lookup[kern, p, {}], L]]]], {p, vars}], {L, letters}];
    trusted = Keys[Select[kern, Length[#] === 1 &]];
    shared = Select[Complement[vars, trusted], Function[v, Count[letters, L_ /; ! FreeQ[L, v]] >= 2]];
    rest = Complement[vars, trusted, shared];
    Join[trusted, shared, rest]];
  Global`fcuIntegratePiece[pc_, vars_, tmo_] := Module[{r, ord, tries},
    If[vars === {}, Return[If[NumericQ[Quiet@N[pc]] && MBtoMPL`Private`mbtInexactNumberFreeQ[pc], pc, $Failed]]];
    ord = Quiet@Check[Global`fcuKernelFirstOrder[pc, vars], vars];
    (* THE PLAIN CALL FIRST (2026-09-09): an explicit "IntegrationOrder" makes ivfPlainCubeQ decline the cube, so a
       hinted call bypasses IntVolFLINT for the legacy integrator; the hint is a short fallback only *)
    tries = If[ListQ[ord] && Sort[ord] === Sort[vars],
      {{tmo}, {Min[900, tmo], "IntegrationOrder" -> ord}}, {{tmo}}];
    Catch[
      Do[Module[{tm = First[opt], rest = Rest[opt], engine = "IntVol", ivfCap},
        Global`$ivfLastRefusals = {};
        (* the certificate integrator's own time cap grows with the piece (2026-09-11: an 880k-leaf piece needs far more
           than the 900/1800 s default; a cap hit there drops the piece to the legacy chain, which takes hours) *)
        (* ... and with the number of variables (weight): 600 s x 2^(n-3) -- 4800 s for a 6-variable piece at one thread *)
        (* 2026-09-11 18:05: base 1800 s (was 600): MB9's weight-8 four-variable pieces close standalone in 800-1000 s
           and were refused inside the family at the 1200 s cap with lane competition, after which the fallback
           re-split produced divergent chunks; $fcuCapBase *)
        ivfCap = Max[If[NumericQ[Global`$ivfSeconds], Global`$ivfSeconds, 900],
          Min[tm, Max[60 + Ceiling[LeafCount[pc]/50], If[NumericQ[Global`$fcuCapBase], Global`$fcuCapBase, 1800] 2^Max[0, Length[vars] - 3]]]];
        Global`$fcuLastCap = ivfCap;
        r = Block[{Global`$ivfSeconds = ivfCap},
          Quiet@TimeConstrained[Global`IntVolIntegrate[pc, vars, Sequence @@ rest, "Verbose" -> False, "Timeout" -> tm], tm + 60, $Failed]]];
        If[AssociationQ[r], engine = Lookup[r, "Engine", "IntVol"]; r = r["Result"]];
        (* per-piece integrator record (diagnostics; .cache/fcu/piece_log.m, one association per line) *)
        Quiet@Check[Module[{rec = If[ListQ[Global`$IVFIntVolLog] && Global`$IVFIntVolLog =!= {}, Last[Global`$IVFIntVolLog], <||>]},
          PutAppend[<|"Time" -> DateString["ISODateTime"], "LC" -> LeafCount[pc], "Vars" -> vars, "Engine" -> engine,
            "IVF" -> Lookup[rec, "IVF", None], "Seconds" -> Lookup[rec, "Seconds", None], "Winner" -> Lookup[rec, "Winner", None],
            "Cap" -> Global`$fcuLastCap, "OK" -> FreeQ[r, $Failed | $Aborted], "Kernel" -> $KernelID,
            (* 2026-09-11 15:15: the refusal reasons of the certificate race (MB11 residue 15: a piece refused in the
               workers in 56 s with no reason on record, served standalone in 4 s) *)
            "Refusals" -> If[ListQ[Global`$ivfLastRefusals], Take[StringTake[ToString[Lookup[#, "reason", ""]], UpTo[160]] & /@ Global`$ivfLastRefusals, UpTo[8]], None],
            "RaceReason" -> If[AssociationQ[Global`$ivfLastRace], Lookup[Global`$ivfLastRace, "reason", None], None]|>,
            FileNameJoin[{Global`$MBStandardCacheDir, "fcu", "piece_log.m"}]]], Null];
        (* FAIL-CLOSED ON DIVERGENCE (2026-09-11): when the certificate integrator refused this piece as divergent and the
           legacy chain then served a value, that value is a shuffle-REGULARISED finite part of a divergent integral,
           never the value of the piece (an unsubtracted pole, e.g. a corner's moment); it is refused here *)
        If[engine =!= "IntVolFLINT" && DownValues[Global`ivfLastRefusalDivergentQ] =!= {} && TrueQ[Quiet@Global`ivfLastRefusalDivergentQ[]],
          r = $Failed];
        (* a frozen canonical-integration object of the legacy chain (CiTi / Gint heads in any context) is not a value *)
        If[FreeQ[r, $Failed | $Aborted | Indeterminate | ComplexInfinity | Global`IntVolIntegrate | Global`CanInt$FrozenCiTi] &&
           FreeQ[r, s_Symbol /; StringContainsQ[SymbolName[Unevaluated[s]], "CiTi" | "Gint" | "CanInt"]] &&
           MBtoMPL`Private`mbtInexactNumberFreeQ[r], Throw[r, Global`fcuOK]], {opt, tries}];
      $Failed, Global`fcuOK]];

  (* subkernels for the pieces: policy cap, staged loading, integrator scaled to one thread per kernel *)
  Global`fcuLaunchWorkers[verbose_, nMax_Integer] := Module[{cap, nW, ks, dir = Global`$MBStandardDir},
    If[Kernels[] =!= {},
      Global`$fcuOwnsKernels = False; ks = Kernels[];
      If[verbose, Print["    [faithful cube] reusing the ", Length[ks], " subkernel(s) of the caller"]],
      Global`$fcuOwnsKernels = True;
      cap = If[DownValues[Global`mbtSubkernelCapDynamic] =!= {}, Global`mbtSubkernelCapDynamic[], 8];
      nW = Max[1, Min[cap, Global`$fcuMaxWorkers, nMax]];
      If[verbose, Print["    [faithful cube] workers: policy cap ", cap, ", pieces ", nMax, " -> launching ", nW, " subkernel(s)"]];
      Quiet@Check[LaunchKernels[nW], Null]; ks = Kernels[]];
    If[ks === {}, Return[{}]];
    With[{d = dir},
      Do[Quiet@ParallelEvaluate[
          Off[General`shdw]; SetDirectory[d]; Block[{$Output = {}}, Quiet@Get[FileNameJoin[{d, "load_standard.m"}]]];
          Global`$ivfRaceThreads = 1; Global`$ivfThreadsSingle = 1; Global`$ivfChartThreads = 1; Global`$ivfRaceWidth = 1;
          Global`$bwsRaceOrders = 2; Global`$ivfSeconds = 1800; Global`$ivfScaledQ = True; "ok", batch],
        {batch, Partition[ks, UpTo[12]]}]];
    ks = Select[ks, TrueQ[Quiet@ParallelEvaluate[MemberQ[$Packages, "MBtoMPL`"], #]] &];
    If[verbose, Print["    [faithful cube] ", Length[ks], " subkernel(s) ready for the pieces"]];
    ks];
  Global`fcuScaleWorkers[ks_, nPieces_, verbose_] := If[ks =!= {},
    Module[{budget = Max[1, Floor[$ProcessorCount/Max[1, Min[nPieces, Length[ks]]]]], t, w},
      (* race width up to 8 (2026-09-11: with width 4 the fast order of a hard piece waited behind a full time cap of the
         first batch); the thread budget per piece is what bounds it *)
      (* 2026-09-11 (MB5 residue 4): with w = budget/t a tight budget raced 4 candidates at 1 thread in sequential batches
         and a 6-variable piece that one order closes in 831 s (8 lanes x 4 threads) timed out into the legacy chain; the
         width stays 8 (at most ~2.5x oversubscription of the cores at 1 thread per lane), so a race is one batch *)
      (* ... but the lanes cost memory (11:17: 497 lanes of a few GB each = 1.4 TB, 370 GB left on the node): the width
         follows a lane budget of ~160 per run, never below 3 -- 40 kernels: 4 lanes, 20 kernels: 8 *)
      (* 2026-09-11 15:35: the lane budget is PER RUN, so several concurrent runs multiply into a memory blow-up
         (six runs reached 525 lanes = 1.7 TB, 59 GB free); the constant is 80 (was 160), and no more than three heavy
         cube runs are kept concurrent -- a 20-kernel run then races 4 lanes, three runs about 240 lanes ~ 0.75 TB *)
      t = Which[budget >= 16, 4, budget >= 8, 2, True, 1]; w = Max[3, Min[8, Floor[80/Max[1, Min[nPieces, Length[ks]]]]]];
      With[{tt = t, ww = w}, Quiet@ParallelEvaluate[
        Global`$ivfRaceThreads = tt; Global`$ivfThreadsSingle = tt; Global`$ivfChartThreads = tt;
        Global`$ivfRaceWidth = ww; Global`$ivfScaledQ = True;, ks]];
      If[verbose, Print["    [faithful cube] integrator scaling for this stage: ", t, " thread(s), race width ", w]]]];
  (* integrate a list of {integrand, vars} jobs on the workers (or serially); returns the values ($Failed where refused) *)
  Global`fcuRunJobs[jobsIn_List, ks_, bankOf_, verbose_, tag_] := Module[{res, todo, jobs, done = 0, nfail = 0, tk = AbsoluteTime[]},
    res = ConstantArray[$Failed, Length[jobsIn]];
    Do[Module[{bf = bankOf[jobsIn[[i, 1]]]}, If[FileExistsQ[bf] && TrueQ[Global`$fcuBankRead], res[[i]] = Get[bf]]], {i, Length[jobsIn]}];
    todo = Select[Range[Length[jobsIn]], res[[#]] === $Failed &];
    If[verbose, Print["    [faithful cube] ", tag, ": ", Length[jobsIn], " piece(s)", If[Length[todo] < Length[jobsIn],
      "; " <> ToString[Length[jobsIn] - Length[todo]] <> " from the per-piece bank", ""], If[ks === {}, " (serial)", " on " <> ToString[Length[ks]] <> " subkernel(s)"]]];
    If[todo === {}, Return[res]];
    If[ks === {},
      Do[res[[i]] = Global`fcuIntegratePiece[jobsIn[[i, 1]], jobsIn[[i, 2]], Global`$fcuPieceSeconds];
         If[res[[i]] =!= $Failed, Quiet@Put[res[[i]], bankOf[jobsIn[[i, 1]]]]], {i, todo}],
      Global`fcuScaleWorkers[ks, Length[todo], verbose];
      jobs = Table[With[{pc = jobsIn[[i, 1]], vv = jobsIn[[i, 2]], tm = Global`$fcuPieceSeconds, ii = i},
         ParallelSubmit[{ii, Global`fcuIntegratePiece[pc, vv, tm]}]], {i, todo}];
      Module[{running = jobs, r, id},
        While[running =!= {},
          {r, id, running} = WaitNext[running];
          If[ListQ[r] && Length[r] === 2, res[[r[[1]]]] = r[[2]];
            If[r[[2]] =!= $Failed, Quiet@Put[r[[2]], bankOf[jobsIn[[r[[1]], 1]]]]]];
          done++; If[! (ListQ[r] && r[[2]] =!= $Failed), nfail++];
          If[verbose && (Mod[done, 10] === 0 || running === {}),
            Print["      ... ", done, "/", Length[todo], " pieces, ", nfail, " refused (", Round[AbsoluteTime[] - tk], " s)"]]]]];
    res];

  (* A fallback re-expands an ENTIRE structural source, not just its failed jobs.  Keep source indices attached to
     job occurrences through sorting and chunking: identical expressions can occur in different sources.  When a
     source is replaced, all its old contributions (including successful siblings) must be removed exactly once. *)
  Global`fcuTagSourceJobs[bySource_List] := Flatten[
    MapIndexed[Function[{js, ix}, Append[#, First[ix]] & /@ js], bySource], 1];
  Global`fcuFallbackReplacement[jobSources_List, refused_List] := Module[{sources},
    sources = DeleteDuplicates[jobSources[[refused]]];
    <|"Sources" -> sources,
      "Replace" -> Select[Range[Length[jobSources]], MemberQ[sources, jobSources[[#]]] &]|>];

  (* ---------- compound corners: iterated sector decomposition (blow-up) before the face subtraction (2026-09-11) ----------
     A polynomial letter P^(c + k eps) with integer c <= -1 whose zero set meets the closed cube on a boundary stratum of
     codimension >= 2 (a "compound corner": two or more competing monomials in the local face coordinates; MB9's residue
     18 carries (1 - y + x y u v)^(-1 + 5 eps), which vanishes at y = 1 together with any of x, u, v = 0) carries a genuine
     eps-pole that no coordinate-face subtraction sees: the face subtraction alone gave that residue a wrong leading
     coefficient (the subtraction paper's compound-corner obstruction; standard paper, Prop. "corner blow-up").
     Resolution = resolve the geometry first: for a minimal set S of local coordinates whose joint vanishing kills P,
     sector j (j in S) substitutes x_i = x_j t_i (i in S, i != j), t_i in [0,1], Jacobian x_j^(|S|-1); then P = x_j P'
     with P' either non-vanishing on the sector or a corner of lower complexity, treated recursively.  A corner at a
     face x = 1 is first moved to 0 by x -> 1 - s.  Summed over the sectors the substitution is an exact change of
     variables, so the cube's value is unchanged; afterwards every singular locus is a single atom and the master
     subtraction equation applies verbatim.  Fail-closed: more than $fcuMaxSectors sectors, a letter that is not
     positive after the substitution, or a corner whose vanishing set cannot be found refuse the residue. *)
  If[! ValueQ[Global`$fcuBlowUp], Global`$fcuBlowUp = True];
  If[! ValueQ[Global`$fcuMaxSectors], Global`$fcuMaxSectors = 96];
  (* the inversion search: how many successful inversions are compared for their corner count, and for how long *)
  If[! ValueQ[Global`$fcuInversionTries], Global`$fcuInversionTries = 40];
  (* 2026-09-11: the race keeps comparing successful inversions until this many succeeded (fewest corners, then fewest
     Euler variables); pass 1 tries the first $fcuPlansPerOrder kernel plans of every variable order, pass 2 every plan *)
  If[! ValueQ[Global`$fcuInversionMinTries], Global`$fcuInversionMinTries = 12];
  If[! ValueQ[Global`$fcuPlansPerOrder], Global`$fcuPlansPerOrder = 3];
  (* pass 1 scans EVERY variable order with the plain kernel plan (1,...,1), up to this many successes or the time
     budget, and takes the best (fewest corners, then fewest Euler variables); the variable count of an inversion
     depends mostly on the order (MB12 res 23: 5 to 8 variables over the 24 orders) *)
  If[! ValueQ[Global`$fcuInversionScan], Global`$fcuInversionScan = 400];
  (* the cost of an inversion (2026-09-11): the pieces at cube order k are the log-monomials of degree k - kmin in the
     L structural logs of each of the P structural pieces, ~ P Binomial(L + k - kmin - 1, k - kmin), for the orders
     kmin .. ordMax - p0 (p0 = the prefactor's leading eps-power, kmin = the cube's own leading order).  Neither the
     variable count nor p0 alone decides: MB6 res 7 has a 6-variable inversion with orders 0..4 (715 pieces) and a
     5-variable one with orders 0..8 (12870); MB5 res 10 a 7-variable one with 1221 pieces and another with 9934.
     The estimate reproduces the enumerated counts (MB6 res 7: 165 = C(11,3), 495 = C(12,4) with L = 9). *)
  If[! ValueQ[Global`$fcuEstimateCandidates], Global`$fcuEstimateCandidates = 4];
  If[! ValueQ[Global`$fcuEstimateSeconds], Global`$fcuEstimateSeconds = 90];
  Global`fcuCostEstimate[inv_, norm_, dressPref_, eps_, ordMin_, ordMax_] := Module[
    {vars = inv["Vars"], pref, sectors, pieces, slogs, pser, p0, kmax, kmin, L, P},
    pref = inv["Prefactor"] dressPref;
    pser = Quiet@Series[pref, {eps, 0, ordMax + 2}];
    p0 = If[Head[pser] === SeriesData && pser[[3]] =!= {}, pser[[4]]/pser[[6]], 0];
    If[! IntegerQ[p0], p0 = 0];
    kmax = ordMax - p0;
    sectors = Catch[Global`fcuBlowUp[norm, vars, eps, False], Global`fcu$tag];
    If[AssociationQ[sectors], Return[Infinity]];
    pieces = Catch[Join @@ Table[Global`fcuFacePieces[sc[[1]], sc[[2]], eps], {sc, sectors}], Global`fcu$tag];
    If[AssociationQ[pieces], Return[Infinity]];
    (* the monomials are formed in the structural logs of the pieces; the sector logs only enter a blown-up cube *)
    slogs = Global`fcuStructuralLogs[pieces, inv["Merged"]];
    If[Length[sectors] > 1, slogs = DeleteDuplicates[Join[slogs,
      Log /@ DeleteDuplicates[Join @@ (#[[2]] & /@ sectors)], Log[1 - #] & /@ DeleteDuplicates[Join @@ (#[[2]] & /@ sectors)]]]];
    (* the monomial alphabet: the logs of the Euler variables plus the structural logs (MB12 res 23: 5 + 2 = 7 gives
       the enumerated 1, 7, 28, 84, 210) *)
    L = Max[1, Length[vars] + Length[slogs]]; P = Max[1, Length[pieces]];
    kmin = Quiet@TimeConstrained[
      Min[Table[Global`fcuLeadOrder[Global`fcuApplyOps[p, p["R"], eps], eps, Max[0, kmax]], {p, pieces}]],
      Global`$fcuEstimateSeconds, 0];
    If[! IntegerQ[kmin], kmin = 0];
    If[kmax < kmin, Return[0]];
    P Total[Table[Binomial[L + j - 1, j], {j, 0, kmax - kmin}]]];
  Global`fcuRaceDoneQ[pass_, nc_, n_, t0_] := If[pass === 1,
    n >= Global`$fcuInversionScan || AbsoluteTime[] - t0 > Global`$fcuInversionSeconds,
    (nc === 0 && n >= Global`$fcuInversionMinTries) || n >= Global`$fcuInversionTries ||
      AbsoluteTime[] - t0 > Global`$fcuInversionSeconds];
  If[! ValueQ[Global`$fcuBankRead], Global`$fcuBankRead = True];   (* False: recompute, ignoring banked totals and pieces (still written) *)
  If[! ValueQ[Global`$fcuEulerClassRungs], Global`$fcuEulerClassRungs = True];
  If[! ValueQ[Global`$fcuEulerRungSeconds], Global`$fcuEulerRungSeconds = 7200];
  If[! ValueQ[Global`$fcuEulerCompositionCandidates], Global`$fcuEulerCompositionCandidates = 4];
  (* 2026-09-11 14:50: 400000, not 60000 -- the certificate integrator serves class-wise pieces of 880k leaves in
     under a minute, while the chunking of an 85k-leaf piece kept the master busy for an hour with the workers idle *)
  If[! ValueQ[Global`$fcuMaxPieceLeaves], Global`$fcuMaxPieceLeaves = 400000];   (* larger pieces are re-split into chunks *)
  If[! ValueQ[Global`$fcuTogetherMaxLeaves], Global`$fcuTogetherMaxLeaves = 50000];   (* a combined coefficient above this stays class-wise *)
  If[! ValueQ[Global`$fcuTogetherSeconds], Global`$fcuTogetherSeconds = 30];   (* a slow combination is a large one *)
  If[! ValueQ[Global`$fcuSingleSeries], Global`$fcuSingleSeries = False];   (* one eps-series per piece for all orders *)
  If[! ValueQ[Global`$fcuParallelEnumeration], Global`$fcuParallelEnumeration = True];   (* pieces x orders on the workers *)
  Global`$fcuJobsBankVersion = "v20260911c";   (* split rules: combine guard + co-atom logs; bump when the split changes *)
  (* 2026-09-11: old order totals may double-count successful siblings after a whole-source fallback.  Reassemble
     totals in a new namespace, retaining the unchanged exact per-piece banks and job enumerations. *)
  Global`$fcuOrderBankVersion = "v20260911d";
  Global`fcuOrderBankPath[bankDir_, key_, k_] := FileNameJoin[{bankDir,
    "fcu_" <> key <> "_e" <> ToString[k] <> "_" <> Global`$fcuOrderBankVersion <> ".m"}];
  If[! ValueQ[Global`$fcuInversionSeconds], Global`$fcuInversionSeconds = 240];
  (* powers of products/polynomials with monomial factors -> products of atom powers (all bases positive on the cube) *)
  Global`fcuSplitPowers[expr_, vars_] := expr //. {
    Power[b_Times, p_] :> Times @@ (Power[#, p] & /@ (List @@ b)),
    Power[b_Plus, p_] /; ! FreeQ[b, Alternatives @@ vars] && ! Global`fcuAtomQ[b, vars] :>
      Module[{pf = Global`fcuPosFactors[Expand[b], vars]},
        If[pf[[1]] =!= 1, Global`fcu$fail["blow-up: base not positive on the cube: " <> ToString[b, InputForm]]];
        If[Length[pf[[2]]] === 1 && pf[[2, 1, 2]] === 1 && Expand[pf[[2, 1, 1]] - b] === 0, Power[Global`fcuHold[b], p],
          Times @@ (Power[#[[1]], #[[2]] p] & /@ pf[[2]])]]} /. Global`fcuHold[b_] :> b;
  (* the corner letters of an expression: polynomial bases with exponent c + k eps, c <= -1, vanishing on the boundary.
     Only the DANGEROUS ones are returned (2026-09-11, after the residue census): a corner is a genuine obstruction
     only when the local integral diverges by power counting.  On a vanishing set S (local coordinates t_i -> 0 along
     the atoms of S) the letters vanishing on S contribute a total pole order n_S = sum of their -c, and the measure
     contributes the atom exponents a_i (integer parts) of the same term; with t_i = rho tau_i the corner integral
     scales as rho^(sum_i (a_i + 1) - n_S - 1) d rho, convergent iff sum_i (a_i + 1) > n_S.  A corner with
     sum_i (a_i + 1) <= n_S (a face pole on one of its atoms, or a double pole of the letter) is what the face
     subtraction cannot see (MB9's residue 18: (1 - y + x y u v)^(-1+5 eps) with the face (1-y)^(-1+..)); a corner with
     no face on its atoms and a simple pole is an ordinary integrable letter of the piece (all of MB5's sealed
     orders carry such letters), and blowing it up would only cascade. *)
  Global`fcuCornerLetters[expr_, vars_, eps_] := Module[{terms, out = {}},
    terms = If[Head[#] === Plus, List @@ #, {#}] &[Expand[expr]];
    Do[Module[{ex = Global`fcuAtomExponents[t, vars], letters, sets = <||>, whose = <||>},
       letters = DeleteDuplicates[Cases[t, Power[b_, p_] /; ! Global`fcuAtomQ[b, vars] && ! FreeQ[b, Alternatives @@ vars] &&
           IntegerQ[Simplify[p /. eps -> 0]] && (p /. eps -> 0) <= -1 :> {b, -(p /. eps -> 0)}, {0, Infinity}]];
       Do[Do[sets[S] = Lookup[sets, Key[S], 0] + L[[2]]; whose[S] = Append[Lookup[whose, Key[S], {}], L[[1]]],
          {S, Global`fcuVanishingSets[L[[1]], vars]}], {L, letters}];
       Do[Module[{A = 0},
          Do[Module[{atom = If[r[[2]] === 0, r[[1]], 1 - r[[1]]], a},
             a = Simplify[Lookup[ex, atom, 0] /. eps -> 0]; A += a + 1], {r, S}];
          If[A <= sets[S], out = Join[out, whose[S]]]], {S, Keys[sets]}]], {t, terms}];
    DeleteDuplicates[out]];
  (* a minimal set of (variable -> side) whose joint substitution kills the letter exactly; None if the letter does not
     vanish on the closed cube (sizes 2, 3, 4 tried; size 1 would be a face factor, which normalisation has pulled out) *)
  Global`fcuVanishingSets[P_, vars_] := Module[{cands, found = {}},
    cands = Flatten[Table[{v -> 0, v -> 1}, {v, vars}], 1];
    Do[found = Select[Subsets[cands, {n}], DuplicateFreeQ[First /@ #] && Expand[P /. #] === 0 &];
       If[found =!= {}, Break[]], {n, 2, Min[4, Length[vars]]}];
    found];
  Global`fcuVanishingSet[P_, vars_] := With[{s = Global`fcuVanishingSets[P, vars]}, If[s === {}, None, First[s]]];
  (* a corner variable is DOUBLE-ENDED in an expression when it also carries a pole face at its other end *)
  Global`fcuDoubleEndedQ[expr_, r_Rule, eps_] := With[{v = r[[1]], side = r[[2]]},
    ! FreeQ[expr, Power[If[side === 0, 1 - v, v], p_] /; IntegerQ[Simplify[p /. eps -> 0]] && (p /. eps -> 0) <= -1]];
  (* one sector-decomposition step on the corner (P, S) of the sector {integrand, vars}: returns the list of sectors *)
  Global`fcuSectorStep[expr_, vars_, S_, eps_] := Module[{ex = expr, vs = vars, locals, out = {}},
    (* corners at a face x = 1 are moved to 0 by x -> 1 - s (a fresh variable s, Jacobian 1) *)
    locals = Table[Module[{v = r[[1]], side = r[[2]], s},
        If[side === 1, s = Unique["Global`fcs"]; ex = ex /. v -> 1 - s; vs = vs /. v -> s; s, v]], {r, S}];
    ex = Global`fcuSplitPowers[Expand[ex] /. Power[b_, p_] :> Power[Expand[b], p], vs];
    Do[Module[{xj = locals[[j]], others = Delete[locals, j], sub, ts, e2, v2},
        ts = Table[Unique["Global`fct"], {Length[others]}];
        sub = Thread[others -> xj ts];
        e2 = (ex /. sub) xj^Length[others];
        v2 = (vs /. Thread[others -> ts]);
        e2 = Global`fcuSplitPowers[e2 /. Power[b_, p_] :> Power[Expand[b], p], v2];
        AppendTo[out, {e2, v2}]], {j, Length[locals]}];
    out];
  Global`fcuBlowUp[cube_, vars_, eps_, verbose_] := Module[{queue = {{cube, vars}}, done = {}, guard = 0, sec, corners, S, P},
    If[! TrueQ[Global`$fcuBlowUp], Return[{{cube, vars}}]];
    While[queue =!= {},
      guard++; If[guard > 4 Global`$fcuMaxSectors || Length[done] + Length[queue] > Global`$fcuMaxSectors,
        Global`fcu$fail["blow-up: more than " <> ToString[Global`$fcuMaxSectors] <> " sectors"]];
      sec = First[queue]; queue = Rest[queue];
      corners = Global`fcuCornerLetters[sec[[1]], sec[[2]], eps];
      If[corners === {}, AppendTo[done, sec]; Continue[]];
      P = First[corners];
      (* among the minimal vanishing sets of the corner, prefer one whose variables carry no pole face at their other
         end: substituting such a variable cannot turn its far face into a new corner (1 - x_j t_i), which is what
         made the decomposition cascade on MB9's residue 18 (52 corners, then a cap) *)
      Module[{sets = Global`fcuVanishingSets[P, sec[[2]]]},
        If[sets === {}, Global`fcu$fail["blow-up: no vanishing set for " <> ToString[P, InputForm]]];
        S = First[SortBy[sets, Count[#, r_ /; Global`fcuDoubleEndedQ[sec[[1]], r, eps]] &]]];
      (* if every minimal set still has a double-ended variable, that variable is split at 1/2 first, so that each
         half is singular at one end only *)
      Module[{dbl = Select[S, Global`fcuDoubleEndedQ[sec[[1]], #, eps] &]},
        If[dbl =!= {},
          Module[{v = dbl[[1, 1]], u = Unique["Global`fcu"], e1, e2},
            AppendTo[Global`$fcuTrace, {"blow-up", "split at 1/2", v}];
            If[verbose, Print["    [faithful cube] corner variable ", v, " has a pole face at its other end -> split at 1/2"]];
            e1 = Global`fcuSplitPowers[Expand[(sec[[1]] /. v -> u/2)/2] /. Power[b_, p_] :> Power[Expand[b], p], sec[[2]] /. v -> u];
            e2 = Global`fcuSplitPowers[Expand[(sec[[1]] /. v -> 1 - u/2)/2] /. Power[b_, p_] :> Power[Expand[b], p], sec[[2]] /. v -> u];
            queue = Join[queue, {{e1, sec[[2]] /. v -> u}, {e2, sec[[2]] /. v -> u}}]; Continue[]]]];
      AppendTo[Global`$fcuTrace, {"blow-up", P, "at" -> S}];
      If[verbose, Print["    [faithful cube] compound corner ", InputForm[P], " at ", InputForm[S], " -> ", Length[S], " sectors"]];
      queue = Join[queue, Global`fcuSectorStep[sec[[1]], sec[[2]], S, eps]]];
    If[verbose && Length[done] > 1, Print["    [faithful cube] blow-up: ", Length[done], " sector(s)"]];
    done];

  (* the handler: an MBresolve residue term -> exact Laurent coefficients ordMin..ordMax, or $Failed *)
  Global`fcuResidueLaurent[term_, eps_, ordMin_Integer, ordMax_Integer, verbose_] := Catch[Module[
    {f, ctr, zs, ctrR, eN = eps -> -1/40, inv = None, cube, vars, pref, norm, pser, p0, kmaxCube, key,
     bankDir, coefs = <||>, ks = {}, t0 = AbsoluteTime[], log = {}, pieces, slogs, kmin, orderJobs = <||>, pieceJobs = <||>, psers = {}, nMax, rulesUsed, sectors,
     dress, fK, tsearch, ntried, invCorners = Infinity, cands = {}, invTrace = {}, classReduction, classValue},
    (* An upstream resolution failure is not a zero integral. Validate the
       contour structure before Part/Keys or an empty loop can manufacture
       a zero coefficient vector from an unevaluated inversion. *)
    If[!TrueQ[Quiet@Check[Length[term]>=2&&Length[term[[2]]]>=2&&
        MatchQ[Keys[term[[2,2]]],{___Symbol}],False]],Throw[$Failed,Global`fcu$tag]];
    f=term[[1]];ctr=term[[2,2]];
    zs = Keys[ctr]; ctrR = Normal[ctr] /. r_Rule :> (r[[1]] -> Rationalize[r[[2]], 0]);
    eN = eps -> Global`fcuSafeEps[f, zs, ctrR, eps];
    If[verbose, Print["    [faithful cube] sign decisions at eps = ", N[eN[[2]], 6], " (no pole crossing on the contour in between)"]];
    (* the dressing (polygamma factors, rationals in the MB variables) is made into Euler structure first *)
    dress = Global`fcuDress[f, zs, ctrR, eN, eps];
    If[AssociationQ[dress] && TrueQ[dress["Failed"]],
      If[verbose, Print["    [faithful cube] dressing failed: ", dress["Reason"]]]; Throw[$Failed, Global`fcu$tag]];
    If[AssociationQ[dress] && verbose, Print["    [faithful cube] dressing: ", Length[dress["Vars"]], " auxiliary variable(s) ",
      InputForm[dress["Trace"]]]];
    fK = If[AssociationQ[dress], dress["K"], f];
    (* the variable orders and kernel plans in turn (v2 rules, then v1); among the inversions that succeed within the
       search budget the one whose normalised cube has the FEWEST compound corners is taken (2026-09-11: a corner-free
       inversion needs no blow-up), ties broken by the number of Euler variables *)
    tsearch = AbsoluteTime[]; ntried = 0;
    (* 2026-09-11: the race no longer stops at the first corner-free inversion; it keeps comparing until
       $fcuInversionMinTries inversions succeeded (fewest corners, then fewest Euler variables): pass 1 over the variable
       orders with the first $fcuPlansPerOrder kernel plans each, pass 2 (only when pass 1 found nothing) over every
       plan.  MB12's residue 23: the first order gave a corner-free EIGHT-variable cube, other orders five variables. *)
    Do[
      Do[Do[Module[{plans = SortBy[Tuples[Range[3], Length[zs]], Total]},
          plans = Switch[pass, 1, {ConstantArray[1, Length[zs]]}, 2, Take[plans, Min[Length[plans], Global`$fcuPlansPerOrder]], _, plans];
          Do[Module[{try, nrm, nc},
             If[rules === "v1" && AssociationQ[dress], Break[]];
             try = If[rules === "v1", Global`fcuInvertV1[f, zs, ctrR, eps, ord, eN, pl], Global`fcuInvertV2[fK, zs, ctrR, eps, ord, eN, pl, dress]];
             Which[
               TrueQ[try["Failed"]], AppendTo[log, {rules, ord, pl} -> try["Reason"]],
               Length[try["Vars"]] > Global`$fcuMaxVars, AppendTo[log, {rules, ord, pl} -> "too many variables"],
               True,
                 nrm = Catch[Global`fcuNormalize[try["Cube"], try["Vars"], eps], Global`fcu$tag];
                 If[AssociationQ[nrm], AppendTo[log, {rules, ord, pl} -> ("normalisation: " <> nrm["Reason"])],
                   nc = If[TrueQ[Global`$fcuBlowUp], Length[Global`fcuCornerLetters[nrm, try["Vars"], eps]], 0];
                   AppendTo[log, {rules, ord, pl} -> ("ok, " <> ToString[nc] <> " corner letter(s)")];
                   ntried++;
                   AppendTo[cands, <|"Inv" -> try, "Norm" -> nrm, "Corners" -> nc, "Rules" -> rules, "Trace" -> Global`$fcuTrace|>];
                   If[inv === None || nc < invCorners || (nc === invCorners && Length[try["Vars"]] < Length[inv["Vars"]]),
                     inv = try; norm = nrm; invCorners = nc; rulesUsed = rules; invTrace = Global`$fcuTrace]]];
             If[verbose, Print["    [faithful cube] rules ", rules, ", order ", ord, ", kernel plan ", pl, ": ", Last[log][[2]],
               If[! TrueQ[try["Failed"]], "  (" <> ToString[Length[try["Vars"]]] <> " Euler variables)", ""]]];
             If[inv =!= None && Global`fcuRaceDoneQ[pass, invCorners, ntried, tsearch], Break[]]], {pl, plans}];
          If[inv =!= None && Global`fcuRaceDoneQ[pass, invCorners, ntried, tsearch], Break[]]], {ord, Permutations[zs]}];
        If[inv =!= None, Break[]], {rules, If[Global`$fcuRules === "v1", {"v1"}, {"v2", "v1"}]}];
      If[inv =!= None, Break[]], {pass, {1, 2, 3}}];
    If[inv === None, If[verbose, Print["    [faithful cube] inversion impossible: ", log]]; Throw[$Failed, Global`fcu$tag]];
    (* 2026-09-11: among the candidates with the fewest corners, the smallest ESTIMATED piece count decides (the
       fewest variables are only the tie-break); at most $fcuEstimateCandidates candidates are costed *)
    If[Length[cands] >= 2 && Length[zs] >= 2,
      Module[{best = Select[cands, #["Corners"] === invCorners &], scored, t1 = AbsoluteTime[], pick},
        best = Take[SortBy[best, Length[#["Inv"]["Vars"]] &], Min[Length[best], Global`$fcuEstimateCandidates]];
        scored = Table[{Global`fcuCostEstimate[c["Inv"], c["Norm"], If[AssociationQ[dress], dress["Prefactor"], 1], eps, ordMin, ordMax], c}, {c, best}];
        If[verbose, Print["    [faithful cube] piece estimates of the ", Length[best], " best inversion(s) {variables, pieces}: ",
          Table[{Length[s[[2]]["Inv"]["Vars"]], s[[1]]}, {s, scored}], " (", Round[AbsoluteTime[] - t1], " s)"]];
        pick = First[SortBy[scored, {#[[1]], Length[#[[2]]["Inv"]["Vars"]]} &]][[2]];
        inv = pick["Inv"]; norm = pick["Norm"]; rulesUsed = pick["Rules"]; invTrace = pick["Trace"]]];
    Global`$fcuTrace = invTrace;
    cube = inv["Cube"]; vars = inv["Vars"]; pref = inv["Prefactor"] If[AssociationQ[dress], dress["Prefactor"], 1];
    If[verbose, Print["    [faithful cube] inversion taken: ", rulesUsed, ", order ", inv["Order"], ", ", Length[vars],
      " Euler variables, ", invCorners, " corner letter(s) (", ntried, " inversion(s) compared)"]];
    (* Exact structural Euler rungs precede face enumeration.  Their own
       domain checks retain all analytically continued moments.  Dry runs
       and independent original-cube audits bypass this optional layer. *)
    If[TrueQ[Global`$fcuEulerClassRungs] && ! TrueQ[Global`$fcuDryRun] && Length[vars] === 4 &&
        DownValues[Global`sagReduceCube] =!= {} && DownValues[Global`sagCubeLaurent] =!= {},
      classReduction = Global`sagReduceCube[norm, vars, eps];
      If[TrueQ[classReduction["Reduced"]],
        If[verbose, Print["    [faithful cube] shared-affine Gauss class admitted: four variables -> one integral"]];
        classValue = TimeConstrained[Global`sagCubeLaurent[classReduction, pref, eps, ordMin, ordMax, verbose],
          Global`$fcuEulerRungSeconds, $Failed];
        If[ListQ[classValue] && Length[classValue] === ordMax - ordMin + 1 &&
            MBtoMPL`Private`mbtInexactNumberFreeQ[classValue] && ! Global`abtUnfinishedQ[classValue] &&
            FreeQ[classValue, eps | $Failed | $Aborted | Indeterminate | ComplexInfinity | _DirectedInfinity],
          Global`$fcuLastRun = <|"ClassRung" -> "SharedAffineGauss", "Cube" -> norm, "Vars" -> vars,
            "Prefactor" -> pref, "Order" -> inv["Order"], "Rules" -> rulesUsed,
            "Reduction" -> classReduction, "Run" -> Global`$sagLastRun|>;
          Throw[classValue, Global`fcu$tag]];
        If[verbose, Print["    [faithful cube] Gauss terminal refused; ordinary cube subtraction follows"]]]];
    If[TrueQ[Global`$fcuEulerClassRungs] && ! TrueQ[Global`$fcuDryRun] &&
        DownValues[Global`sgsTryCubeLaurent] =!= {},
      classValue = Global`sgsTryCubeLaurent[norm, vars, pref, eps, ordMin, ordMax, verbose];
      If[AssociationQ[classValue],
        classReduction = classValue["Reduction"];
        Global`$fcuLastRun = <|"ClassRung" -> classReduction["Class"], "Cube" -> norm, "Vars" -> vars,
          "Prefactor" -> pref, "Order" -> inv["Order"], "Rules" -> rulesUsed,
          "Reduction" -> classReduction, "Run" -> classValue["Run"]|>;
        Throw[classValue["Values"], Global`fcu$tag]]];
    (* Whole class compositions retain common-regulator and complete-depth
       certificates. A bounded number of source-exact alternative inversions
       may expose a factorization absent in the cheapest piece-count chart. *)
    If[TrueQ[Global`$fcuEulerClassRungs] && ! TrueQ[Global`$fcuDryRun] &&
        DownValues[Global`ecComposeLaurent] =!= {},
      Module[{ecCandidates,ecAnswer,ecChoice},
        ecCandidates=Prepend[SortBy[cands,Length[#["Inv"]["Vars"]]&],
          <|"Inv"->inv,"Norm"->norm,"Rules"->rulesUsed|>];
        ecCandidates=Take[DeleteDuplicatesBy[ecCandidates,{#["Norm"],#["Inv"]["Vars"],#["Inv"]["Prefactor"]}&],
          UpTo[Global`$fcuEulerCompositionCandidates]];
        Do[ecAnswer=TimeConstrained[Global`ecComposeLaurent[ecChoice["Norm"],ecChoice["Inv"]["Vars"],
            ecChoice["Inv"]["Prefactor"] If[AssociationQ[dress],dress["Prefactor"],1],
            eps,ordMin,ordMax,verbose],Global`$fcuEulerRungSeconds,<|"Complete"->False|>];
          If[AssociationQ[ecAnswer]&&TrueQ[ecAnswer["Complete"]]&&
              Global`ecValuesQ[ecAnswer["Values"],eps,ordMax-ordMin+1],
            Global`$fcuLastRun=<|"ClassRung"->"EulerComposition","Cube"->ecChoice["Norm"],
              "Vars"->ecChoice["Inv"]["Vars"],"Order"->ecChoice["Inv"]["Order"],
              "Rules"->ecChoice["Rules"],"Composition"->ecAnswer|>;
            If[verbose,Print["    [faithful cube] complete Euler class composition: ",
              ecAnswer["Tree"]["Kind"],"; common regulator ",ecAnswer["CommonEpsilonInterval"]]];
            Throw[ecAnswer["Values"],Global`fcu$tag]],{ecChoice,ecCandidates}]]];
    (* 2026-09-11: compound corners are blown up into sectors first; the face pieces are then formed per sector *)
    sectors = Catch[Global`fcuBlowUp[norm, vars, eps, verbose], Global`fcu$tag];
    If[AssociationQ[sectors], If[verbose, Print["    [faithful cube] blow-up failed: ", sectors["Reason"]]]; Throw[$Failed, Global`fcu$tag]];
    pieces = Catch[Join @@ Table[Global`fcuFacePieces[sc[[1]], sc[[2]], eps], {sc, sectors}], Global`fcu$tag];
    If[AssociationQ[pieces], If[verbose, Print["    [faithful cube] face decomposition failed: ", pieces["Reason"]]]; Throw[$Failed, Global`fcu$tag]];
    (* the structural logs: the merged variables and every sector atom (the blow-up renames variables) *)
    slogs = DeleteDuplicates[Join[Global`fcuStructuralLogs[pieces, inv["Merged"]],
      Log /@ DeleteDuplicates[Join @@ (#[[2]] & /@ sectors)], Log[1 - #] & /@ DeleteDuplicates[Join @@ (#[[2]] & /@ sectors)]]];
    pser = Series[pref, {eps, 0, ordMax + 2}]; p0 = pser[[4]]/pser[[6]];
    kmaxCube = ordMax - p0;
    (* the cube's own leading order (a face moment 1/(k eps) may be compensated by a numerator zero; never below the
       number of faces) *)
    (* PARALLEL ENUMERATION (2026-09-11): the leading orders and the per-order jobs of the structural pieces are
       independent tasks (pieces x orders); on the master they took an hour for a 3-fold residue's cube to order 4
       while the workers idled.  The workers are launched first and reused for the pieces. *)
    If[TrueQ[Global`$fcuParallelEnumeration] && Length[pieces] >= 2 && ks === {},
      ks = Global`fcuLaunchWorkers[verbose, Min[Global`$fcuMaxWorkers, Max[Length[pieces], Length[pieces] (Max[0, kmaxCube] + 3)]]]];
    If[TrueQ[Global`$fcuSingleSeries],
      psers = Table[Module[{X = Global`fcuApplyOps[p, p["R"], eps]}, {Quiet@Series[X, {eps, 0, Max[0, kmaxCube]}], X}], {p, pieces}];
      kmin = Min[Table[Global`fcuLeadOrderOfSeries[ps[[1]], ps[[2]]], {ps, psers}]],
      kmin = Min[If[ks =!= {} && TrueQ[Global`$fcuParallelEnumeration],
        With[{e = eps, km = Max[0, kmaxCube]}, ParallelMap[Global`fcuLeadOrder[Global`fcuApplyOps[#, #["R"], e], e, km] &, pieces, Method -> "FinestGrained"]],
        Table[Global`fcuLeadOrder[Global`fcuApplyOps[p, p["R"], eps], eps, Max[0, kmaxCube]], {p, pieces}]]]];
    If[kmin === Infinity, kmin = 0];
    If[verbose, Print["    [faithful cube] rules ", rulesUsed, ", order ", inv["Order"], ": ", Length[vars], " Euler variables, ",
      Length[pieces], " structural piece(s) (faces ", DeleteDuplicates[Flatten[Table[fc["Atom"], {p, pieces}, {fc, Join[p["Faces"], p["Moments"]]}]]],
      "), merged variables ", inv["Merged"], ", prefactor ~ eps^", p0, ", cube orders ", kmin, "..", kmaxCube,
      " needed for eps^", ordMin, "..eps^", ordMax]];
    Global`$fcuLastRun = <|"Cube" -> norm, "Vars" -> vars, "Prefactor" -> pref, "Order" -> inv["Order"], "Rules" -> rulesUsed,
      "Pieces" -> pieces, "StructuralLogs" -> slogs, "Merged" -> inv["Merged"]|>;
    If[kmaxCube < kmin, Throw[ConstantArray[0, ordMax - ordMin + 1], Global`fcu$tag]];
    bankDir = FileNameJoin[{Global`$MBStandardCacheDir, "fcu"}]; Quiet@CreateDirectory[bankDir, CreateIntermediateDirectories -> True];
    (* the bank key carries the sector structure: a blown-up cube must not read the coefficients banked before the blow-up *)
    (* a cube that needed no sector (one sector = the cube itself) keeps the pre-blow-up key: its pieces are identical *)
    key = IntegerString[Hash[If[Length[sectors] > 1, {norm, vars, rulesUsed, {"blow-up", Length[sectors], sectors[[All, 2]]}}, {norm, vars, rulesUsed}], "SHA256"], 16, 16];
    (* enumerate the structural pieces of every order first (cheap), so that the worker count matches the work *)
    Module[{needK = {}, jobsBank},
      (* the enumeration itself is banked per cube order (2026-09-11: a 3-fold residue's enumeration to order 4 costs
         half an hour and was repeated at every relaunch); the file name carries the split-rule version *)
      jobsBank = Function[k, FileNameJoin[{bankDir, "jobs_" <> key <> "_e" <> ToString[k] <> "_" <> Global`$fcuJobsBankVersion <> ".m"}]];
      Do[Module[{bank = Global`fcuOrderBankPath[bankDir, key, k]},
         Which[
           FileExistsQ[bank] && TrueQ[Global`$fcuBankRead], coefs[k] = Get[bank]; orderJobs[k] = {}; pieceJobs[k] = {},
           FileExistsQ[jobsBank[k]] && TrueQ[Global`$fcuBankRead] && ! TrueQ[Global`$fcuDryRun],
             pieceJobs[k] = Get[jobsBank[k]]; orderJobs[k] = Join @@ pieceJobs[k],
           True, AppendTo[needK, k]]],
        {k, kmin, kmaxCube}];
      If[needK =!= {},
        If[ks =!= {} && TrueQ[Global`$fcuParallelEnumeration] && ! TrueQ[Global`$fcuSingleSeries],
          (* all (piece, order) tasks at once on the workers *)
          Module[{tasks = Flatten[Table[{j, k}, {j, Length[pieces]}, {k, needK}], 1], res},
            res = With[{pcs = pieces, sl = slogs, e = eps},
              ParallelMap[Function[t, {t, Global`fcuPieceOrder[pcs[[t[[1]]]], t[[2]], e, sl]}], tasks, Method -> "FinestGrained"]];
            Do[pieceJobs[k] = Table[SelectFirst[res, #[[1]] === {j, k} &][[2]], {j, Length[pieces]}]; orderJobs[k] = Join @@ pieceJobs[k], {k, needK}]],
          Do[pieceJobs[k] = If[TrueQ[Global`$fcuSingleSeries],
               Table[Global`fcuPieceSeriesJobs[pieces[[j]], psers[[j, 1]], k, eps, slogs], {j, Length[pieces]}],
               Table[Global`fcuPieceOrder[p, k, eps, slogs], {p, pieces}]];
             orderJobs[k] = Join @@ pieceJobs[k], {k, needK}]];
        If[! TrueQ[Global`$fcuDryRun], Do[Quiet@Check[Put[pieceJobs[k], jobsBank[k]], Null], {k, needK}]]]];
    If[verbose, Print["    [faithful cube] structural pieces per order: ", Table[k -> Length[orderJobs[k]], {k, kmin, kmaxCube}]]];
    nMax = Max[1, Max[Length /@ Values[orderJobs]]];
    (* diagnostics: $fcuDryRun = True returns the decomposition (key, pieces, per-order jobs) instead of integrating *)
    If[TrueQ[Global`$fcuDryRun],
      Throw[<|"DryRun" -> True, "Key" -> key, "Jobs" -> Association[Table[k -> orderJobs[k], {k, kmin, kmaxCube}]], "Pieces" -> pieces,
        "Cube" -> norm, "Vars" -> vars, "Prefactor" -> pref, "BankDir" -> bankDir, "Sectors" -> Length[sectors]|>, Global`fcu$tag]];
    Do[Module[{bank = Global`fcuOrderBankPath[bankDir, key, k], jobs, res, bankOf, tk = AbsoluteTime[], refused, fb, res2,
               taggedJobs, jobSources, replacement},
      If[KeyExistsQ[coefs, k], If[verbose, Print["    [faithful cube] cube eps^", k, " from the bank"]]; Continue[]];
      taggedJobs = SortBy[Global`fcuTagSourceJobs[pieceJobs[k]], -LeafCount[#[[1]]] &];
      jobs = (Take[#, 2] &) /@ taggedJobs;
      If[jobs === {}, coefs[k] = 0; Put[0, bank]; Continue[]];
      If[ks === {}, ks = Global`fcuLaunchWorkers[verbose, nMax]];
      (* oversized pieces are re-split into chunks before any integration (their structural pieces re-expanded, the
         face operators per chunk on the workers); the chunk jobs remember their structural piece for the fallback *)
      Module[{big = Select[taggedJobs, LeafCount[#[[1]]] > Global`$fcuMaxPieceLeaves &], idx, chunked},
        If[big =!= {},
          idx = DeleteDuplicates[big[[All, 3]]];
          If[idx =!= {},
            chunked = Join @@ Table[Module[{cj = Global`fcuPieceChunked[pieces[[i]], k, eps, kmin, Global`$fcuMaxPieceLeaves]},
              Append[#, i] & /@ cj], {i, idx}];
            If[verbose, Print["    [faithful cube] cube eps^", k, ": ", Length[big], " oversized piece(s) (", Max[LeafCount /@ big[[All, 1]]],
              " leaves) -> ", Length[idx], " structural piece(s) re-split into ", Length[chunked], " chunk(s), largest ",
              If[chunked === {}, 0, Max[LeafCount /@ chunked[[All, 1]]]], " leaves"]];
            taggedJobs = SortBy[Join[Select[taggedJobs, ! MemberQ[idx, #[[3]]] &], chunked], -LeafCount[#[[1]]] &];
            jobs = (Take[#, 2] &) /@ taggedJobs]]];
      jobSources = taggedJobs[[All, 3]];
      (* PER-PIECE BANK, keyed by the piece expression (survives any change of the piece ordering) *)
      bankOf = Function[pc, FileNameJoin[{bankDir, "p_" <> key <> "_e" <> ToString[k] <> "_" <> IntegerString[Hash[pc, "SHA256"], 16, 16] <> ".m"}]];
      res = Global`fcuRunJobs[jobs, ks, bankOf, verbose, "cube eps^" <> ToString[k]];
      refused = Select[Range[Length[jobs]], res[[#]] === $Failed &];
      If[refused =!= {},
        (* fallback: the refused structural pieces sub-split by log monomials, the face subtraction re-applied *)
        If[verbose, Print["    [faithful cube] cube eps^", k, ": ", Length[refused], " structural piece(s) refused -> log-monomial sub-split with the subtraction re-applied"]];
        replacement = Global`fcuFallbackReplacement[jobSources, refused];
        fb = Join @@ Table[Global`fcuPieceFallback[pieces[[i]], k, eps, kmin], {i, replacement["Sources"]}];
        If[verbose, Print["    [faithful cube] cube eps^", k, ": ", Length[fb], " sub-piece(s)"]];
        res2 = Global`fcuRunJobs[fb, ks, bankOf, verbose, "cube eps^" <> ToString[k] <> " sub-pieces"];
        If[MemberQ[res2, $Failed],
          If[verbose, Print["    [faithful cube] cube eps^", k, ": ", Count[res2, $Failed], " sub-piece(s) refused -> handler fails closed"]];
          If[TrueQ[Global`$fcuOwnsKernels], Quiet@CloseKernels[]]; Throw[$Failed, Global`fcu$tag]];
        If[verbose, Print["    [faithful cube] fallback replaces ", Length[replacement["Replace"]],
          " original job(s) from ", Length[replacement["Sources"]], " whole structural source(s)"]];
        res = ReplacePart[res, Thread[replacement["Replace"] -> 0]]; res = Append[res, Total[res2]]];
      coefs[k] = Total[res]; Put[coefs[k], bank];
      If[verbose, Print["    [faithful cube] cube eps^", k, " = ", N[Re[coefs[k]], 12], " (", Round[AbsoluteTime[] - tk], " s)"]]],
     {k, kmin, kmaxCube}];
    If[TrueQ[Global`$fcuOwnsKernels], Quiet@CloseKernels[]];
    Module[{tot = Series[pref Sum[coefs[j] eps^j, {j, kmin, kmaxCube}], {eps, 0, ordMax}], out},
      (* 2026-09-11 (campaign, MB5 residue 25): when every cube coefficient in the range vanishes, Series returns the
         plain number 0 and SeriesCoefficient[0, k] stays unevaluated -- a non-Laurent atom that made the family refuse
         the whole target; a plain expression is expanded by Coefficient instead *)
      out = If[Head[tot] === SeriesData, Table[SeriesCoefficient[tot, k], {k, ordMin, ordMax}],
        Table[Coefficient[Expand[tot], eps, k], {k, ordMin, ordMax}]];
      If[! MBtoMPL`Private`mbtInexactNumberFreeQ[out]||
        !FreeQ[out,eps|_Missing|_Failure|$Failed|$Aborted|Indeterminate|ComplexInfinity|_DirectedInfinity|
          _SeriesCoefficient|_Integrate|_NIntegrate],Throw[$Failed,Global`fcu$tag]];
      If[verbose, Print["    [faithful cube] residue closed in ", Round[AbsoluteTime[] - t0], " s"]];
      out]], Global`fcu$tag];

  Global`$fcuRungInstalled = True;
  Print["[mbeFaithfulCubeRung] installed (v2 rules: S1 cancellation, other-variable-free pairings, merged rationals, faces by the master subtraction equation; v1 fallback): multi-fold residue -> faithful Euler cube -> exact per-order pieces on subkernels (banked under .cache/fcu)."];
]];
