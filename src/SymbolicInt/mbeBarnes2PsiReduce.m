(* AUTHORSHIP (release R2, 2026-09-07): component of the MBSymbolicInt package (Standard route). Authors of MBSymbolicInt: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* ============================================================================================================
   mbeBarnes2PsiReduce.m -- BARNES' SECOND LEMMA WITH A POLYGAMMA DIFFERENCE (2026-09-15; MB14b pieces 0245/0247/0248).
   Class handler for pieces in which one MB variable v appears through the second-lemma pattern
       Gamma(a1+v) Gamma(a2+v) Gamma(a3+v) Gamma(b1-v) Gamma(b2-v) / Gamma(c+v),   c = a1+a2+a3+b1+b2   (Saalschuetz),
   (or its mirror image, mapped by v -> -v) times ONE polygamma psi(L) whose argument L is one of the six legs, times
   v-free factors (other polygammas included).  The lemma
       (1/2 pi i) Int ... dv = Prod_{i,j} Gamma(a_i+b_j) / Prod_i Gamma(c-a_i)
   holds on the canonical contour for every parameter set satisfying the condition, so it may be differentiated along
   any parameter direction that KEEPS the condition: shifting the leg of L by +delta and a partner leg L0 by -delta
   (a denominator leg by +delta) gives, at delta = 0,
       Int K [psi(L) - psi(L0)] dv = d/d delta [ lemma_delta + crossed-pole residues_delta ]_{delta=0},
   a closed form in the other variables (Gamma products times polygammas of v-free arguments).  Hence
       Int K psi(L) = Int K psi(L0) + (closed form),
   which reduces the piece to a partner piece with another leg's polygamma (chosen so that its argument depends on v
   only, where possible: such pieces close in the recursion where the two-variable arguments refuse every cube) plus
   pieces in one variable fewer.  Neither the psi integral representation nor the raise is needed: the identity is
   exact for any real part of L.  Crossed poles: the piece's contour need not be canonical; a right-family pole
   b_j + n left of the contour or a left-family pole -a_i - n right of it contributes -(-1)^n/n! x rest(pole) to the
   value (the convention of mbeBarnesPreReduce.m, fixed there by one-fold unit tests), and the delta-derivative of
   that correction is taken as well (with the Saalschuetz condition the denominator Gamma often has a ZERO at the
   crossed pole, so the correction is O(delta) and only its derivative survives).  Every decomposition is GATED:
   the one-dimensional v-integrals of the piece and of its partner at a random interior point of the other variables
   are compared with the closed form (development numerics, 1e-8 relative, never served); a failed gate refuses the
   partner.
   API:  mbeBarnes2PsiReduce[intg, vars, ctr] -> list of CANDIDATES, best partner first; each candidate is a list
         {{partnerIntegrand, vars}, {reducedTerm, vars without v}, ...} whose values SUM to the piece; or $Failed.
   ============================================================================================================ *)

mbeB2PLog[a___] := If[TrueQ[Global`$mbeB2PVerbose] || TrueQ[Global`$bwsVerbose],
  WriteString["stdout", "  [Barnes2Psi] " <> StringJoin[ToString /@ {a}] <> "\n"]];
mbeB2PAffineQ[e_, v_] := PolynomialQ[e, v] && Exponent[e, v] <= 1;
mbeB2PRe[e_, ctr_] := Quiet@Check[Re[N[e /. ctr, 30]], $Failed];
mbeB2PSameQ[a_, b_] := PossibleZeroQ[Expand[a - b]];
mbeB2PNonPosIntQ[e_] := With[{x = Simplify[e]}, IntegerQ[x] && x <= 0];

(* parse for ONE variable v: v-free factors (polygammas included), unit-slope numerator and denominator legs, and the
   single psi^(0) factor whose argument depends on v; polynomials, rationals or further polygammas in v refuse *)
mbeB2PParse[intg_, v_] := Module[{fac, num = {}, den = {}, rest = 1, psi = {}, ok = True},
  fac = If[Head[intg] === Times, List @@ intg, {intg}];
  Do[Which[
     FreeQ[f, v], rest *= f,
     MatchQ[f, Gamma[_]] && mbeB2PAffineQ[f[[1]], v] && Abs[Coefficient[f[[1]], v]] == 1, AppendTo[num, f[[1]]],
     MatchQ[f, Power[Gamma[_], _Integer?Positive]] && mbeB2PAffineQ[f[[1, 1]], v] && Abs[Coefficient[f[[1, 1]], v]] == 1,
       num = Join[num, ConstantArray[f[[1, 1]], f[[2]]]],
     MatchQ[f, Power[Gamma[_], _Integer?Negative]] && mbeB2PAffineQ[f[[1, 1]], v] && Abs[Coefficient[f[[1, 1]], v]] == 1,
       den = Join[den, ConstantArray[f[[1, 1]], -f[[2]]]],
     MatchQ[f, PolyGamma[0, _]] && mbeB2PAffineQ[f[[2]], v], AppendTo[psi, f[[2]]],
     True, ok = False], {f, fac}];
  If[! ok || Length[psi] =!= 1, Return[$Failed]];
  <|"rest" -> rest, "num" -> num, "den" -> den, "L" -> First[psi]|>];

(* one-dimensional development gate: Int_v piece - Int_v partner against the closed form at a random interior point
   of the other variables (contour values rationalized plus random imaginary parts); True/False *)
mbeB2PGate[piece_, partner_, v_, others_, ctr_, closed_] := Module[{pt, cv, q, cl, lhs, rhs, L = 24},
  pt = Table[o -> Rationalize[o /. ctr, 10^-12] + I RandomInteger[{-300, 300}]/1000, {o, others}];
  cv = Rationalize[v /. ctr, 10^-12];
  cl = Quiet[N[closed /. pt, 30]];
  If[! NumericQ[cl], mbeB2PLog["gate: the closed form is not numeric at the test point"]; Return[False]];
  q[f_] := Quiet[NIntegrate[(f /. pt) /. v -> cv + I y, {y, -L, L}, WorkingPrecision -> 30, PrecisionGoal -> 12, MaxRecursion -> 14]/(2 Pi)];
  lhs = q[piece]; rhs = q[partner];
  If[! NumericQ[lhs] || ! NumericQ[rhs], mbeB2PLog["gate: quadrature unavailable"]; Return[False]];
  mbeB2PLog["gate in ", v, ": piece ", N[lhs, 12], "  partner + closed ", N[rhs + cl, 12], "  rel ", N[Abs[lhs - rhs - cl]/(1 + Abs[lhs]), 3]];
  Abs[lhs - rhs - cl] <= 10^-8 (1 + Abs[lhs])];

(* the reduction in ONE variable: list of candidates (best partner first) or $Failed *)
mbeB2PReduceVar[intg_, v_, vars_, ctr_] := Module[
  {p, num, den, L, up, dn, sgn, cv, a, b, c, legs, legArg, type, others, cross = {}, ok = True, cands = {}, partners,
   d = Global`mbeB2PDelta, closedForm, shifts, rest},
  p = mbeB2PParse[intg, v]; If[p === $Failed, Return[$Failed]];
  num = p["num"]; den = p["den"]; L = p["L"]; rest = p["rest"];
  If[Length[num] =!= 5 || Length[den] =!= 1, Return[$Failed]];
  up = Select[num, Coefficient[#, v] == 1 &]; dn = Select[num, Coefficient[#, v] == -1 &];
  sgn = Which[Length[up] == 3 && Length[dn] == 2 && Coefficient[First[den], v] == 1, 1,
              Length[up] == 2 && Length[dn] == 3 && Coefficient[First[den], v] == -1, -1, True, 0];
  If[sgn == 0, Return[$Failed]];
  (* the mirror image is the standard pattern in -v; the reduced terms are v-free, the contour value flips sign *)
  If[sgn == -1, {num, den, L} = {num, den, L} /. v -> -v;
    up = Select[num, Coefficient[#, v] == 1 &]; dn = Select[num, Coefficient[#, v] == -1 &]];
  cv = sgn mbeB2PRe[v, ctr]; If[! NumericQ[cv], Return[$Failed]];
  a = Expand[# /. v -> 0] & /@ up; b = Expand[# /. v -> 0] & /@ dn; c = Expand[First[den] /. v -> 0];
  If[! PossibleZeroQ[Simplify[c - Total[a] - Total[b]]], Return[$Failed]];
  (* a pinch (a_i + b_j a non-positive integer) has no separating contour *)
  If[AnyTrue[Flatten[Outer[Plus, a, b]], mbeB2PNonPosIntQ], Return[$Failed]];
  legs = Join[Table[{"a", i}, {i, 3}], Table[{"b", j}, {j, 2}], {{"c"}}];
  legArg[{"a", i_}] := a[[i]] + v; legArg[{"b", j_}] := b[[j]] - v; legArg[{"c"}] := c + v;
  type = SelectFirst[legs, mbeB2PSameQ[legArg[#], L] &, None];
  If[type === None, mbeB2PLog["variable ", v, ": the polygamma argument ", L, " is not a leg of the pattern"]; Return[$Failed]];
  others = DeleteCases[vars, v];
  (* crossed poles of the actual contour (at delta = 0): right-family poles b_j + n with Re < cv, left-family poles
     -a_i - n with Re > cv; a pole on the contour or a double pole refuses *)
  Do[Module[{rb = mbeB2PRe[b[[j]], ctr], nmax},
     If[! NumericQ[rb], ok = False; Return[]];
     nmax = Ceiling[cv - rb] - 1;
     Do[AppendTo[cross, {"b", j, n}], {n, 0, nmax}]], {j, 2}];
  Do[Module[{ra = mbeB2PRe[a[[i]], ctr], nmax},
     If[! NumericQ[ra], ok = False; Return[]];
     nmax = Ceiling[-ra - cv] - 1;
     Do[AppendTo[cross, {"a", i, n}], {n, 0, nmax}]], {i, 3}];
  If[! ok, Return[$Failed]];
  Do[Module[{pole = If[cr[[1]] === "b", b[[cr[[2]]]] + cr[[3]], -a[[cr[[2]]]] - cr[[3]]], singular},
     If[Abs[mbeB2PRe[pole, ctr] - cv] < 10^-9, mbeB2PLog["variable ", v, ": a pole lies on the contour -> refused"]; ok = False; Return[]];
     singular = Join[Table[a[[i]] + pole, {i, 3}], Table[b[[j]] - pole, {j, 2}]];
     singular = Delete[singular, If[cr[[1]] === "b", 3 + cr[[2]], cr[[2]]]];
     If[AnyTrue[singular, mbeB2PNonPosIntQ], mbeB2PLog["variable ", v, ": a crossed pole is not simple -> refused"]; ok = False; Return[]]],
    {cr, cross}];
  If[! ok, Return[$Failed]];
  (* the closed form of the delta-family: lemma + crossed-pole corrections, parameters shifted by the given list
     {{leg, +1|-1}, ...} *)
  closedForm[shift_] := Module[{A = a, B = b, C = c, lemma, corr = 0},
    Do[Switch[s[[1, 1]], "a", A[[s[[1, 2]]]] += s[[2]] d, "b", B[[s[[1, 2]]]] += s[[2]] d, "c", C += s[[2]] d], {s, shift}];
    lemma = Product[Gamma[A[[i]] + B[[j]]], {i, 3}, {j, 2}]/Product[Gamma[C - A[[i]]], {i, 3}];
    Do[Module[{pole, r},
       If[cr[[1]] === "b",
         pole = B[[cr[[2]]]] + cr[[3]];
         r = Product[Gamma[A[[i]] + pole], {i, 3}] Gamma[B[[3 - cr[[2]]]] - pole]/Gamma[C + pole],
         pole = -A[[cr[[2]]]] - cr[[3]];
         r = Product[If[i === cr[[2]], 1, Gamma[A[[i]] + pole]], {i, 3}] Product[Gamma[B[[j]] - pole], {j, 2}]/Gamma[C + pole]];
       corr += -(-1)^cr[[3]]/cr[[3]]! r], {cr, cross}];
    lemma + corr];
  mbeB2PLog["variable ", v, If[sgn == -1, " (mirror image)", ""], ": second-lemma pattern a = ", a, ", b = ", b, ", c = ", c,
    "; psi on the leg ", type, " (", L, "); ", Length[cross], " crossed pole(s) ", cross];
  (* partners: the other five legs, single-variable arguments first, then Re >= 1/4, then the larger Re *)
  partners = DeleteCases[legs, type];
  partners = SortBy[partners, With[{arg = legArg[#] /. v -> sgn v, re = mbeB2PRe[legArg[#] /. v -> sgn v, ctr]},
    {If[FreeQ[arg, Alternatives @@ others], 0, 1], If[NumericQ[re] && re >= 1/4, 0, 1], If[NumericQ[re], -re, 0]}] &];
  Do[Module[{L0 = legArg[t0] /. v -> sgn v, partner, closed, terms},
     (* the shift that keeps the Saalschuetz condition: a numerator leg L by +delta with a numerator partner by -delta
        or a denominator partner by +delta; a denominator L by -delta with a numerator partner by -delta *)
     shifts = Which[type =!= {"c"} && t0 =!= {"c"}, {{type, 1}, {t0, -1}},
                    type =!= {"c"} && t0 === {"c"}, {{type, 1}, {t0, 1}},
                    True, {{type, -1}, {t0, -1}}];
     closed = Quiet@Check[SeriesCoefficient[closedForm[shifts], {d, 0, 1}], $Failed];
     If[closed === $Failed || ! FreeQ[closed, d] || ! FreeQ[closed, v],
       mbeB2PLog["partner ", L0, ": the delta-derivative could not be formed"]; Continue[]];
     closed = Simplify[closed];
     partner = intg /. PolyGamma[0, x_] /; mbeB2PSameQ[x, L /. v -> sgn v] :> PolyGamma[0, L0];
     If[! mbeB2PGate[intg, partner, v, others, ctr, rest closed],
       mbeB2PLog["partner ", L0, ": the decomposition FAILED its one-dimensional gate -> refused"]; Continue[]];
     terms = With[{e = Expand[rest closed]}, If[Head[e] === Plus, List @@ e, {e}]];
     terms = Select[terms, # =!= 0 &];
     mbeB2PLog["partner ", L0, ": gate passed; ", Length[terms], " reduced term(s) in ", others];
     AppendTo[cands, Join[{{partner, vars}}, {#, others} & /@ terms]]], {t0, partners}];
  If[cands === {}, $Failed, cands]];

(* try every variable; the candidates of the first variable that reduces *)
mbeBarnes2PsiReduce[intg_, vars_List, ctr_List] := Module[{r = $Failed},
  If[FreeQ[intg, PolyGamma] || Length[vars] < 2, Return[$Failed]];
  Do[If[r === $Failed, r = Quiet@Check[mbeB2PReduceVar[intg, v, vars, ctr], $Failed]], {v, vars}];
  r];

WriteString["stdout", "[mbeBarnes2PsiReduce] loaded (Barnes second lemma with a polygamma difference: partner leg + one-variable-fewer pieces, crossed-pole residues, one-dimensional gate).\n"];
