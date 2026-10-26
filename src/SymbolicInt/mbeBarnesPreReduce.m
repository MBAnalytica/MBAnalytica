(* AUTHORSHIP (release R2, 2026-09-07): component of the MBSymbolicInt package (Standard route). Authors of MBSymbolicInt: Syed Mehedi Hasan, Taushif Ahmed, Andreas Rapakoulias, Sumit Banik. *)
(* ============================================================================================================
   mbeBarnesPreReduce.m -- BARNES-LEMMA PRE-REDUCTION RUNG (2026-09-06; crossing residues + reduction gate 09:45).
   Class handler for multi-fold pieces in which one MB variable v appears through exactly two left-going and two
   right-going unit-slope numerator legs (Barnes' first lemma), possibly together with denominator legs that are
   INTEGER SHIFTS of a numerator leg of the same orientation (Gamma(L)/Gamma(L-k) = (L-1)...(L-k), a polynomial) and
   polynomial factors, and no polygamma in v.  The polynomial is absorbed into a left leg by its Newton expansion
   (v+a)_j Gamma(a+v) = Gamma(a+j+v) and every term is closed by the first lemma
       (1/2 pi i) Int Gamma(a+v) Gamma(a'+v) Gamma(b-v) Gamma(b'-v) dv = Gamma(a+b)Gamma(a+b')Gamma(a'+b)Gamma(a'+b')/Gamma(a+a'+b+b')
   on the CANONICAL contour (the one separating the two pole families).  The piece's own contour need not be canonical
   (MB8b 0616: Gamma(-1-z321-z7) has two poles left of Re z321 = -0.762; 0618: Gamma(-1-z611+z7) one pole left of
   Re z611 = -0.170): the value on the actual contour is the canonical value plus the residues of the crossed poles,
       right-family pole b+n left of the contour:  +(-1)^n/n! * rest(b+n)     (I_actual = I_canonical - Res, Res = -(-1)^n/n! rest)
       left-family pole -a-n right of the contour: +(-1)^n/n! * rest(-a-n)    (I_actual = I_canonical + Res, Res = +(-1)^n/n! rest)
   where rest is the integrand without the leg that carries the pole, at v = pole.  Every reduction is GATED: the
   one-dimensional v-integral of the integrand at a random interior point of the other variables (their contour
   values plus random imaginary parts) is compared numerically (development gate, 1e-8 relative; never served) with
   the closed form; a failed gate refuses the reduction.  The result is a SUM of pieces in the remaining variables,
   reduced again where possible.  MB8b pieces 0616 (3-fold) and 0618 (4-fold) reduce to 2-folds in (z7, z8) with psi(-z7)
   plus lower-fold residue pieces.
   API:  mbeBPRReduceVar[intg, v, vars, ctr] -> {term, ...} (each free of v) or $Failed
         mbeBarnesPreReduce[intg, vars, ctr] -> {{term, remainingVars}, ...} fully reduced, or $Failed if no variable reduces
   Nothing is carried across a chart; no contour is closed except by the explicit crossed-pole residues above.
   ============================================================================================================ *)

mbeBPRLog[a___] := If[TrueQ[Global`$mbeBPRVerbose], WriteString["stdout", "  [BarnesPre] " <> StringJoin[ToString /@ {a}] <> "\n"]];

mbeBPRAffineQ[e_, v_] := PolynomialQ[e, v] && Exponent[e, v] <= 1;

(* factor the integrand: {const (v-free non-Gamma part), numerator legs (list, with multiplicity), denominator legs,
   polynomial part in v (product), psi-free-in-v flag} for ONE variable v *)
mbeBPRParse[intg_, v_] := Module[{fac, num = {}, den = {}, poly = 1, rest = 1, ok = True},
  fac = If[Head[intg] === Times, List @@ intg, {intg}];
  Do[Which[
     FreeQ[f, v], rest *= f,
     MatchQ[f, Gamma[_]] && mbeBPRAffineQ[f[[1]], v] && Abs[Coefficient[f[[1]], v]] == 1, AppendTo[num, f[[1]]],
     MatchQ[f, Power[Gamma[_], _Integer?Positive]] && mbeBPRAffineQ[f[[1, 1]], v] && Abs[Coefficient[f[[1, 1]], v]] == 1,
       num = Join[num, ConstantArray[f[[1, 1]], f[[2]]]],
     MatchQ[f, Power[Gamma[_], _Integer?Negative]] && mbeBPRAffineQ[f[[1, 1]], v] && Abs[Coefficient[f[[1, 1]], v]] == 1,
       den = Join[den, ConstantArray[f[[1, 1]], -f[[2]]]],
     PolynomialQ[f, v], poly *= f,
     True, ok = False], {f, fac}];
  If[! ok || ! FreeQ[rest, PolyGamma[_, x_] /; ! FreeQ[x, v]], Return[$Failed]];
  <|"rest" -> rest, "num" -> num, "den" -> den, "poly" -> poly|>];

(* convert every denominator leg into a polynomial through a numerator leg of the same orientation with an integer,
   non-negative difference; fail otherwise *)
mbeBPRDenToPoly[p_, v_] := Module[{num = p["num"], den = p["den"], poly = p["poly"], ok = True},
  Do[Module[{s = Coefficient[d, v], cands, n, k},
     cands = Select[num, Coefficient[#, v] == s && IntegerQ[Simplify[# - d]] && Simplify[# - d] >= 0 &];
     If[cands === {}, ok = False; Return[]];
     n = First[SortBy[cands, Simplify[# - d] &]]; k = Simplify[n - d];
     num = DeleteCases[num, n, 1, 1];
     poly *= Product[d + j, {j, 0, k - 1}]], {d, den}];
  If[! ok, $Failed, Join[p, <|"num" -> num, "den" -> {}, "poly" -> Expand[poly]|>]]];

(* Newton expansion of the polynomial P(v) in the basis (v+a)_j : P = Sum c_j Prod_{i<j}(v+a+i) *)
mbeBPRNewton[P_, v_, a_] := Module[{Q = Expand[P], cs = {}, j = 0, c},
  While[Q =!= 0 && j <= 40,
    c = Simplify[Q /. v -> -a - j]; AppendTo[cs, c];
    Q = Expand[Cancel[Together[(Q - c)/(v + a + j)]]]; j++];
  cs];

mbeBPRRe[e_, ctr_] := Quiet@Check[Re[N[e /. ctr, 30]], $Failed];

(* the one-dimensional development gate: the v-integral of intg along Re v = c at a random interior point of the other
   variables against the closed form; True/False (False also when the quadrature is unavailable) *)
mbeBPRGate[intg_, v_, others_, ctr_, closed_] := Module[{pt, f, cv, num, cl, L = 24},
  (* exact rational test point (machine contour values rationalized): a 30-digit quadrature needs exact input *)
  pt = Table[o -> Rationalize[o /. ctr, 10^-12] + I RandomInteger[{-300, 300}]/1000, {o, others}];
  cv = Rationalize[v /. ctr, 10^-12];
  f = intg /. pt;
  cl = Quiet[N[closed /. pt, 30]];
  If[! NumericQ[cl], mbeBPRLog["gate: closed form not numeric at the test point"]; Return[False]];
  num = Quiet[NIntegrate[f /. v -> cv + I y, {y, -L, L}, WorkingPrecision -> 30, PrecisionGoal -> 12, MaxRecursion -> 14]/(2 Pi)];
  If[! NumericQ[num], mbeBPRLog["gate: quadrature unavailable"]; Return[False]];
  mbeBPRLog["gate in ", v, ": closed ", N[cl, 12], "  quadrature ", N[num, 12], "  rel ", N[Abs[num - cl]/(1 + Abs[cl]), 3]];
  Abs[num - cl] <= 10^-8 (1 + Abs[cl])];

(* reduce ONE variable by the first lemma with crossing residues; returns the list of v-free terms *)
mbeBPRReduceVar[intg_, v_, vars_, ctr_] := Module[{p, left, right, a, a2, b, b2, cs, terms, cv, others, cross = {}, ok = True},
  p = mbeBPRParse[intg, v]; If[p === $Failed, Return[$Failed]];
  p = mbeBPRDenToPoly[p, v]; If[p === $Failed, Return[$Failed]];
  left = Select[p["num"], Coefficient[#, v] == 1 &]; right = Select[p["num"], Coefficient[#, v] == -1 &];
  If[Length[left] =!= 2 || Length[right] =!= 2, Return[$Failed]];
  {a, a2} = Expand[# /. v -> 0] & /@ left; {b, b2} = Expand[# /. v -> 0] & /@ right;
  (* a pinch (a + b a non-positive integer) has no separating contour: refuse *)
  If[AnyTrue[Flatten[Outer[Plus, {a, a2}, {b, b2}]], IntegerQ[Simplify[#]] && Simplify[#] <= 0 &], Return[$Failed]];
  cv = mbeBPRRe[v, ctr]; If[! NumericQ[cv], Return[$Failed]];
  others = DeleteCases[vars, v];
  (* crossed poles of the actual contour: right-family poles b+n with Re < cv, left-family poles -a-n with Re > cv *)
  Do[Module[{rb = mbeBPRRe[bb, ctr], nmax},
     If[! NumericQ[rb], ok = False; Return[]];
     nmax = Ceiling[cv - rb] - 1;   (* n = 0..nmax have Re(bb + n) < cv *)
     Do[AppendTo[cross, {"right", bb, n}], {n, 0, nmax}]], {bb, {b, b2}}];
  Do[Module[{ra = mbeBPRRe[aa, ctr], nmax},
     If[! NumericQ[ra], ok = False; Return[]];
     nmax = Ceiling[-ra - cv] - 1;   (* n = 0..nmax have Re(-aa - n) > cv *)
     Do[AppendTo[cross, {"left", aa, n}], {n, 0, nmax}]], {aa, {a, a2}}];
  If[! ok, Return[$Failed]];
  (* a pole exactly on the contour (Re equal within 1e-9) is a refusal *)
  If[AnyTrue[cross, Abs[If[#[[1]] === "right", mbeBPRRe[#[[2]] + #[[3]], ctr], mbeBPRRe[-#[[2]] - #[[3]], ctr]] - cv] < 10^-9 &],
    mbeBPRLog["variable ", v, ": a pole lies on the contour -> refused"]; Return[$Failed]];
  cs = mbeBPRNewton[p["poly"], v, a];
  mbeBPRLog["variable ", v, ": legs (", a, "+v)(", a2, "+v)(", b, "-v)(", b2, "-v), polynomial degree ", Length[cs] - 1,
    " -> first lemma with ", Length[cross], " crossed pole(s) ", cross];
  terms = Table[With[{j = k - 1},
     cs[[k]] p["rest"] Gamma[a + j + b] Gamma[a + j + b2] Gamma[a2 + b] Gamma[a2 + b2]/Gamma[a + j + a2 + b + b2]], {k, Length[cs]}];
  (* crossing residues: +(-1)^n/n! * (integrand without the pole's leg) at the pole, for both families *)
  Do[Module[{leg, pole, restLegs, val},
     {leg, pole} = If[c[[1]] === "right", {c[[2]] - v, c[[2]] + c[[3]]}, {c[[2]] + v, -c[[2]] - c[[3]]}];
     restLegs = DeleteCases[p["num"], leg, 1, 1];
     (* another leg singular at the pole would make a double pole: refuse *)
     If[AnyTrue[restLegs, With[{x = Simplify[# /. v -> pole]}, IntegerQ[x] && x <= 0] &], ok = False; Return[]];
     (* sign fixed 09:55 by the one-fold unit tests: I_actual = Formula + Res for a right pole left of the contour
        (Res Gamma(b-v) at b+n = -(-1)^n/n!) and I_actual = Formula - Res for a left pole right of it
        (Res Gamma(a+v) at -a-n = +(-1)^n/n!): both corrections are -(-1)^n/n! * rest(pole) *)
     val = -(-1)^c[[3]]/c[[3]]! p["rest"] (p["poly"] /. v -> pole) Times @@ (Gamma[# /. v -> pole] & /@ restLegs);
     AppendTo[terms, Simplify[val]]], {c, cross}];
  If[! ok, mbeBPRLog["variable ", v, ": a crossed pole is not simple -> refused"]; Return[$Failed]];
  terms = Select[terms, # =!= 0 &];
  (* the reduction gate (development numerics only, never served) *)
  If[! mbeBPRGate[intg, v, others, ctr, Total[terms]], mbeBPRLog["variable ", v, ": the reduction FAILED its one-dimensional gate -> refused"]; Return[$Failed]];
  terms];

(* reduce as far as possible: returns {{term, remaining vars}, ...}; $Failed if NO variable of the input reduces *)
mbeBarnesPreReduce[intg_, vars_List, ctr_List] := Module[{work = {{intg, vars}}, out = {}, progress = False, item, red, v},
  While[work =!= {},
    item = First[work]; work = Rest[work];
    red = $Failed;
    If[Length[item[[2]]] >= 1,
      Do[red = mbeBPRReduceVar[item[[1]], vv, item[[2]], ctr]; If[red =!= $Failed, v = vv; Break[]], {vv, item[[2]]}]];
    If[red === $Failed, AppendTo[out, item],
      progress = True;
      work = Join[work, {#, DeleteCases[item[[2]], v]} & /@ red]]];
  If[! progress, $Failed, out]];
(* the contour-less signature is an error now: the crossings need the contour *)
mbeBarnesPreReduce[intg_, vars_List] := (mbeBPRLog["mbeBarnesPreReduce called without a contour -> refused"]; $Failed);

WriteString["stdout", "[mbeBarnesPreReduce] loaded (Barnes first lemma with polynomial absorption, crossed-pole residues, one-dimensional reduction gate).\n"];
