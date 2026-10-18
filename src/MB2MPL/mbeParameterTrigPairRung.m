(* Trig-pair Barnes-to-Euler closer for eps-free parameter coefficients (2026-10-18).  The last fallback of
   closePiece (mbeParameterEulerRung.m): a coefficient kernel that every earlier closer refused is converted, fold by
   fold and by exact identities on its own straight contour, into Euler integrals, which the bundled HyperIntica closes;
   the value is served only through the exactness contract and the independent source-contour gate.  Built for the
   light cosmological split terms, whose refused pieces pair Gamma[a + z] Gamma[b - z] with a + b an integer (a trig
   pair, Gamma[z] Gamma[-z] = -Pi/(z Sin[Pi z]): no Euler form of its own), the class the one-fold trig-kernel rung
   (mbeTrigKernelRung.m) cannot reach with two or more folds.
   Per fold z, on the contour z = c:
   (1) a denominator Gamma[C] in z is Beta-paired with a numerator Gamma[A] of the same z-slope and the same content in
       the other folds: Gamma[A]/Gamma[C] = Int_0^1 x^(A-1) (1-x)^(C-A-1) dx/Gamma[C-A]  (Re(C-A) > 0, Re A > 0);
   (2) every (+, -) numerator pair of z but one becomes an Euler variable v in (0, Infinity):
       Gamma[a + z] Gamma[b - z] = Int_0^Inf v^(a+z-1) M_n(v; a+b) dv,
       M_n(v; S) = Gamma[S] (1+v)^-S - Sum_(j<n) (-1)^j Gamma[S+j] v^(-S-j)/j!,  n from Re(b - z) on the contour;
   (3) the last (kernel) pair is inverted in closed form, (1/2 Pi I) Int Gamma[a+z] Gamma[b-z] Y^-z dz =
       Gamma[a+b] Y^a (1+Y)^-(a+b), corrected by the poles that lie on the wrong side of the contour; among the pairs
       that keep the other + legs inside their strips, a trig pair is preferred;
   (4) what depends on the remaining folds goes back into the MB, term by term.
   Polygamma dressings: every z-dependent Gamma carries a shift; the Euler integrand is expanded to second order in the
   shifts and the dressing is matched in the Bell span of the shift derivatives (fail-closed when it is not).
   Ported from the research converter cosmo/u10/u10_general2.wls (light psi0 at eps^3: 230.79170934037 vs the
   continuation reference 230.791709). *)
BeginPackage["MBParameter`"];
Begin["`Private`"];
ClearAll[trigPairMFunction, trigPairSubLevel, trigPairRe, trigPairZVars, trigPairFold, trigPairEulerTerms,
  trigPairGammaArgs, trigPairShiftedKernel, trigPairBell, trigPairRationalToGamma, trigPairStructure, trigPairCubes,
  trigPairClose, trigPairRefuse, trigPairPoints, trigPairDirichlet];

$trigPairTag = "MBParameterTrigPair";

(* a refusal: the reason is kept in $trigPairLastReason for the diagnostics *)
trigPairRefuse[reason_] := Module[{},
  $trigPairLastReason = reason;
  Throw[$Failed, $trigPairTag]];

trigPairMFunction[v_, s_, n_] := Gamma[s] (1 + v)^-s - Sum[(-1)^j Gamma[s + j] v^(-s - j)/j!, {j, 0, n - 1}];

trigPairSubLevel[re_] := If[re > 0, 0, Ceiling[-re]];

(* real part on the contour, every shift at 0 *)
trigPairRe[x_, ctr_, shifts_] := Module[{value},
  value = x /. ctr;
  value = value /. Thread[shifts -> 0];
  Re[N[value]]];

trigPairZVars[x_, vars_] := Select[vars, !FreeQ[x, #] &];

(* one fold z of one Euler term <|"Num", "Den", "Mono", "W", "Vars"|> -> list of Euler terms *)
trigPairFold[t_, z_, ctr_, vars_, shifts_] := Module[{num, den, mono, w, ranges, dz, nz, plus, minus, best, restPlus,
    restMinus, states, out = {}, admissible, trigQ, coefficientOf},
  num = t["Num"];
  den = t["Den"];
  mono = t["Mono"];
  w = t["W"];
  ranges = t["Vars"];
  coefficientOf[x_] := Coefficient[x, z];
  (* (1) Beta pairings of the denominators that contain z *)
  dz = Select[den, !FreeQ[#, z] &];
  Do[Module[{slope, candidates, numerator, x1, zeroFold},
    slope = coefficientOf[d1];
    candidates = Select[num, !FreeQ[#, z] && coefficientOf[#] === slope &&
       FreeQ[Expand[d1 - #], Alternatives @@ vars] && trigPairRe[d1 - #, ctr, shifts] > 0 &&
       trigPairRe[#, ctr, shifts] > 0 &];
    If[candidates === {}, trigPairRefuse["no Beta partner for a denominator Gamma"]];
    numerator = First[candidates];
    x1 = Unique["Global`tpx"];
    num = Delete[num, First[FirstPosition[num, numerator]]];
    den = Delete[den, First[FirstPosition[den, d1]]];
    zeroFold = numerator /. Thread[vars -> 0];
    w = w x1^(zeroFold - 1) (1 - x1)^(d1 - numerator - 1)/Gamma[d1 - numerator];
    AppendTo[mono, {x1, Expand[numerator - zeroFold]}];
    AppendTo[ranges, {x1, 0, 1}]], {d1, dz}];
  (* (2) the numerator pairs of z *)
  nz = Select[num, !FreeQ[#, z] &];
  plus = Select[nz, coefficientOf[#] === 1 &];
  minus = Select[nz, coefficientOf[#] === -1 &];
  If[Length[plus] =!= Length[minus] || Length[plus] + Length[minus] =!= Length[nz] || plus === {},
    trigPairRefuse["a fold is not balanced (unequal + and - legs, or a slope other than 1)"]];
  num = Select[num, FreeQ[#, z] &];
  trigQ[pair_] := IntegerQ[Expand[pair[[1]] + pair[[2]]] /. Thread[shifts -> 0]];
  admissible = Select[Tuples[{plus, minus}],
    AllTrue[Delete[plus, First[FirstPosition[plus, #[[1]]]]], trigPairRe[#, ctr, shifts] > 0 &] &];
  If[admissible === {}, trigPairRefuse["two + legs outside their strips"]];
  best = First[Join[Select[admissible, trigQ], admissible]];
  restPlus = Delete[plus, First[FirstPosition[plus, best[[1]]]]];
  restMinus = Delete[minus, First[FirstPosition[minus, best[[2]]]]];
  states = {<|"Num" -> num, "Mono" -> mono, "W" -> w, "Vars" -> ranges|>};
  Do[Module[{a = restPlus[[j]] - z, b = restMinus[[j]] + z, v1, level, total, branches},
    v1 = Unique["Global`tpv"];
    If[trigPairRe[a + z, ctr, shifts] <= 0, trigPairRefuse["an Euler leg outside its strip"]];
    level = trigPairSubLevel[trigPairRe[b - z, ctr, shifts]];
    total = a + b;
    branches = Join[{{1, total, {1 + v1, -total}}},
      Table[{-(-1)^j2/j2!, total + j2, {v1, -total - j2}}, {j2, 0, level - 1}]];
    states = Flatten[Map[Function[st, Map[Function[br, Module[{num2 = st["Num"], mono2 = st["Mono"], w2 = st["W"], e0},
        w2 = w2 br[[1]] v1^((a /. Thread[vars -> 0]) - 1);
        If[trigPairZVars[br[[2]], vars] === {}, w2 = w2 Gamma[br[[2]]], AppendTo[num2, br[[2]]]];
        e0 = br[[3, 2]] /. Thread[vars -> 0];
        w2 = w2 br[[3, 1]]^e0;
        If[trigPairZVars[br[[3, 2]], vars] =!= {}, AppendTo[mono2, {br[[3, 1]], Expand[br[[3, 2]] - e0]}]];
        AppendTo[mono2, {v1, Expand[a - (a /. Thread[vars -> 0])] + z}];
        <|"Num" -> num2, "Mono" -> mono2, "W" -> w2, "Vars" -> Append[st["Vars"], {v1, 0, Infinity}]|>]], branches]],
      states]]], {j, Length[restPlus]}];
  (* (3) the kernel pair, inverted for every partial state *)
  Do[Module[{num1 = st["Num"], mono1 = st["Mono"], w1 = st["W"], ranges1 = st["Vars"], a = best[[1]] - z,
      b = best[[2]] + z, c1 = z /. ctr, reA, reB, y, terms = {}},
    y = Times @@ Map[#[[1]]^(-coefficientOf[#[[2]]]) &, mono1];
    mono1 = Map[{#[[1]], Expand[#[[2]] - coefficientOf[#[[2]]] z]} &, mono1];
    mono1 = Select[mono1, #[[2]] =!= 0 &];
    reA = trigPairRe[a, ctr, shifts];
    reB = trigPairRe[b, ctr, shifts];
    AppendTo[terms, <|"G" -> {a + b}, "Pow" -> {{y, a}, {1 + y, -(a + b)}}, "c" -> 1|>];
    Do[AppendTo[terms, <|"G" -> {a + b + n2}, "Pow" -> {{y, a + n2}}, "c" -> -(-1)^n2/n2!|>], {n2, 0, Ceiling[-reA - c1] - 1}];
    Do[AppendTo[terms, <|"G" -> {a + b + n2}, "Pow" -> {{y, -b - n2}}, "c" -> -(-1)^n2/n2!|>], {n2, 0, Ceiling[c1 - reB] - 1}];
    Do[Module[{num2 = num1, mono2 = mono1, w2 = w1 tt["c"]},
      Do[If[trigPairZVars[g1, vars] === {}, w2 = w2 Gamma[g1], AppendTo[num2, g1]], {g1, tt["G"]}];
      Do[Module[{e0 = pp[[2]] /. Thread[vars -> 0]},
        w2 = w2 pp[[1]]^e0;
        If[trigPairZVars[pp[[2]], vars] =!= {}, AppendTo[mono2, {pp[[1]], Expand[pp[[2]] - e0]}]]], {pp, tt["Pow"]}];
      AppendTo[out, <|"Num" -> num2, "Den" -> den, "Mono" -> mono2, "W" -> w2, "Vars" -> ranges1|>]], {tt, terms}]],
    {st, states}];
  out];

(* the Dirichlet pre-step (the class of the light psi0 pieces, research closer u10_close.wls): k >= 2 folds, no
   denominators, ONE coupling Gamma[b - Sum z] and per fold one trig pair plus one leg Gamma[a_j + z_j]:
     Gamma[b - Sum z] Prod Gamma[a_j + z_j] = Int Prod dv_j v_j^(a_j + z_j - 1) M_n(Sum v; b + Sum a)   (Re(a_j + z_j) > 0),
   n from Re(b - Sum z) on the contour; afterwards every fold holds its trig pair only.  None when the class does not fit *)
trigPairDirichlet[t_, ctr_, vars_, shifts_] := Catch[Module[{num = t["Num"], coupling, b, legs = {}, total, level, vs, wsum,
    branches, out},
  If[Length[vars] < 2 || t["Den"] =!= {}, Throw[None, "MBParameterTrigPairDirichlet"]];
  coupling = Select[num, AllTrue[vars, Function[z, Coefficient[#, z] === -1]] &];
  If[Length[coupling] =!= 1, Throw[None, "MBParameterTrigPairDirichlet"]];
  coupling = First[coupling];
  num = Delete[num, First[FirstPosition[num, coupling]]];
  If[!AllTrue[num, Length[trigPairZVars[#, vars]] === 1 && MemberQ[{1, -1}, Coefficient[#, First[trigPairZVars[#, vars]]]] &],
    Throw[None, "MBParameterTrigPairDirichlet"]];
  Do[Module[{plus, minus, trigPlus, leg},
    plus = Select[num, Coefficient[#, z] === 1 &];
    minus = Select[num, Coefficient[#, z] === -1 &];
    If[Length[plus] =!= 2 || Length[minus] =!= 1, Throw[None, "MBParameterTrigPairDirichlet"]];
    trigPlus = Select[plus, IntegerQ[Expand[# + First[minus]] /. Thread[shifts -> 0]] &];
    If[trigPlus === {}, Throw[None, "MBParameterTrigPairDirichlet"]];
    (* the leg stays inside its strip; the trig + leg is the other one *)
    leg = Select[plus, trigPairRe[#, ctr, shifts] > 0 &];
    leg = Select[leg, Length[trigPlus] > 1 || # =!= First[trigPlus] &];
    If[leg === {}, Throw[None, "MBParameterTrigPairDirichlet"]];
    leg = First[leg];
    If[!MemberQ[trigPlus, First[DeleteCases[plus, leg, {1}, 1]]], Throw[None, "MBParameterTrigPairDirichlet"]];
    AppendTo[legs, {z, leg}];
    num = Delete[num, First[FirstPosition[num, leg]]]], {z, vars}];
  b = Expand[coupling + Total[vars]];
  total = Expand[b + Total[Map[#[[2]] - #[[1]] &, legs]]];
  level = trigPairSubLevel[trigPairRe[coupling, ctr, shifts]];
  vs = Table[Unique["Global`tpd"], {Length[vars]}];
  wsum = Total[vs];
  branches = Join[{{1, total, {1 + wsum, -total}}}, Table[{-(-1)^j/j!, total + j, {wsum, -total - j}}, {j, 0, level - 1}]];
  out = Map[Function[br, Module[{w2 = t["W"] br[[1]] Gamma[br[[2]]] br[[3, 1]]^br[[3, 2]], mono2 = t["Mono"]},
      Do[w2 = w2 vs[[j]]^(legs[[j, 2]] - legs[[j, 1]] - 1);
        AppendTo[mono2, {vs[[j]], legs[[j, 1]]}], {j, Length[vars]}];
      <|"Num" -> num, "Den" -> {}, "Mono" -> mono2, "W" -> w2,
        "Vars" -> Join[t["Vars"], Map[{#, 0, Infinity} &, vs]]|>]], branches];
  out], "MBParameterTrigPairDirichlet"];

(* a kernel of Gamma's and z-dependent powers -> its Euler terms, fold by fold *)
trigPairEulerTerms[kernel_, ctr_, vars_, shifts_] := Module[{fs, num = {}, den = {}, mono = {}, w = 1, state},
  fs = factors[kernel];
  Do[Which[
    MatchQ[f, Gamma[_]], AppendTo[num, f[[1]]],
    MatchQ[f, Gamma[_]^_Integer?Positive], num = Join[num, ConstantArray[f[[1, 1]], f[[2]]]],
    MatchQ[f, Gamma[_]^_Integer?Negative], den = Join[den, ConstantArray[f[[1, 1]], -f[[2]]]],
    MatchQ[f, Power[_, x_] /; !FreeQ[x, Alternatives @@ vars]], AppendTo[mono, {f[[1]], Expand[f[[2]]]}],
    True, w = w f], {f, fs}];
  mono = Map[Module[{e0 = #[[2]] /. Thread[vars -> 0]}, w = w #[[1]]^e0; {#[[1]], Expand[#[[2]] - e0]}] &, mono];
  state = {<|"Num" -> num, "Den" -> den, "Mono" -> mono, "W" -> w, "Vars" -> {}|>};
  Module[{dir = trigPairDirichlet[First[state], ctr, vars, shifts]},
    If[ListQ[dir], state = dir]];
  Do[state = Flatten[Map[trigPairFold[#, z, ctr, vars, shifts] &, state]], {z, vars}];
  state];

trigPairGammaArgs[t_, vars_] := Flatten[Map[Which[
    MatchQ[#, Gamma[_]], {#[[1]]},
    MatchQ[#, Gamma[_]^_Integer?Positive], ConstantArray[#[[1, 1]], #[[2]]],
    MatchQ[#, Gamma[_]^_Integer?Negative], ConstantArray[#[[1, 1]], -#[[2]]],
    True, {}] &, Select[factors[t], !FreeQ[#, Gamma] && !FreeQ[#, Alternatives @@ vars] &]]];

trigPairShiftedKernel[t_, vars_, pars_, shifts_] := Module[{kernel = 1, j = 0},
  Do[Which[
    MatchQ[f, Gamma[_]^_.] && !FreeQ[f, Alternatives @@ vars],
      Module[{arg = If[Head[f] === Power, f[[1, 1]], f[[1]]], e1 = If[Head[f] === Power, f[[2]], 1]},
        Do[j++; kernel = kernel Gamma[arg + shifts[[j]]]^Sign[e1], {Abs[e1]}]],
    MatchQ[f, Power[_, x_] /; !FreeQ[x, Alternatives @@ vars]], kernel = kernel f,
    True, Null], {f, factors[t]}];
  kernel];

(* the second-order Taylor polynomial of Prod Gamma[g + sh]^sign / Gamma[g]^sign, with p[g, m] for PolyGamma[m, g] *)
trigPairBell[gs_, signs_, shifts_, p_] := Module[{tau, product},
  product = Product[Exp[signs[[g]] (shifts[[g]] tau p[gs[[g]], 0] + (shifts[[g]] tau)^2/2 p[gs[[g]], 1])], {g, Length[gs]}];
  Expand[Normal[Series[product, {tau, 0, 2}]] /. tau -> 1]];

(* a factor L or 1/L, L affine in the folds with unit slopes, as a Gamma ratio *)
trigPairRationalToGamma[t_, vars_] := Module[{fs, out = 1},
  fs = factors[t];
  Do[Module[{base, power},
    {base, power} = If[Head[f] === Power, {f[[1]], f[[2]]}, {f, 1}];
    If[Head[base] =!= Gamma && !FreeQ[base, Alternatives @@ vars] && IntegerQ[power] && affineQ[base, vars] &&
        FreeQ[base, _Symbol?(!MemberQ[vars, #] &)] && Length[trigPairZVars[base, vars]] === 1 &&
        MemberQ[{1, -1}, Coefficient[base, First[trigPairZVars[base, vars]]]],
      out = out If[power > 0, (Gamma[base + 1]/Gamma[base])^power, (Gamma[base]/Gamma[base + 1])^(-power)],
      out = out f]], {f, fs}];
  out];

(* the fold structure of a product: its fold-dependent factors other than polygammas *)
trigPairStructure[t_, vars_] := Times @@ Select[factors[t], !FreeQ[#, Alternatives @@ vars] && FreeQ[#, PolyGamma] &];

(* the Euler cubes {integrand, {{variable, lo, hi}..}} of a kernel: a product, or a sum of products with one common
   fold structure (the terms of one MBexpand coefficient: a second-order dressing such as PolyGamma[0, x]^2 is in the
   Bell span only together with its PolyGamma[1, x] partner), or $Failed *)
trigPairCubes[ig_, ctr_, vars_, pars_] := Catch[Module[{expanded, products, master, gs, signs, dressing, dressArgs,
    degree, needed, sigmas, direction, tau, regulators, shiftsAt, eulerAt, value0, coefficients, p, bell, bellShifts,
    basis, unknowns, rhs, monomials, equations, solution, integrand, ranges, taylorOf, canonical, live},
  expanded = Expand[ig];
  products = If[Head[expanded] === Plus, List @@ expanded, {expanded}];
  products = Map[trigPairRationalToGamma[#, vars] &, products];
  master = trigPairStructure[First[products], vars];
  If[!AllTrue[products, trigPairStructure[#, vars] === master &], trigPairRefuse["the terms have different fold structures"]];
  gs = trigPairGammaArgs[master, vars];
  If[gs === {}, trigPairRefuse["no fold-dependent Gamma"]];
  signs = Flatten[Map[Which[MatchQ[#, Gamma[_]], {1}, MatchQ[#, Gamma[_]^_Integer?Positive], ConstantArray[1, #[[2]]],
      MatchQ[#, Gamma[_]^_Integer?Negative], ConstantArray[-1, -#[[2]]], True, {}] &,
    Select[factors[master], !FreeQ[#, Gamma] && !FreeQ[#, Alternatives @@ vars] &]]];
  (* the dressing: each product without the common structure (whose z-free power parts the Euler weights carry) *)
  dressing = Total[Map[Times @@ Select[factors[#], FreeQ[#, Alternatives @@ vars] || !FreeQ[#, PolyGamma] &] &, products]];
  dressing = dressing /. PolyGamma[m1_, x_] /; !FreeQ[x, Alternatives @@ vars] :> p[x, m1];
  (* the dressing may depend on the folds only through the polygammas p[x, m] *)
  If[!FreeQ[dressing /. _p -> 1, Alternatives @@ vars], trigPairRefuse["the dressing depends on the folds outside the polygammas"]];
  dressArgs = Union[Cases[dressing, p[x_, _] :> x, {0, Infinity}]];
  degree = Module[{t1}, Exponent[Expand[dressing /. q_p :> t1 q], t1]];
  If[!IntegerQ[degree] || degree > 2, trigPairRefuse["the dressing is beyond second order"]];
  (* every Gamma moves along tau (direction_j + sigma_j): the generic positive direction regulates the trig-pair poles
     (their arguments only ever add shifts), the symbols sigma_j exist only for the Gammas that carry a dressing *)
  needed = Map[MemberQ[dressArgs, #] &, gs];
  sigmas = Table[If[needed[[j]], Unique["MBParameter`Private`tps"], 0], {j, Length[gs]}];
  direction = Table[1/Prime[j + 1], {j, Length[gs]}];
  regulators = Join[{tau}, DeleteCases[sigmas, 0]];
  shiftsAt[sig_] := tau (direction + sig);
  (* the Euler variables in creation order (the same for every call), renamed to one canonical list *)
  canonical = {};
  eulerAt[sig_] := Module[{terms, ranges1, rules},
    terms = trigPairEulerTerms[trigPairShiftedKernel[master, vars, pars, shiftsAt[sig]], ctr, vars, regulators];
    ranges1 = DeleteDuplicates[Flatten[Map[#["Vars"] &, terms], 1]];
    While[Length[canonical] < Length[ranges1], AppendTo[canonical, Unique["Global`tpe"]]];
    rules = Thread[ranges1[[All, 1]] -> Take[canonical, Length[ranges1]]];
    {Total[Map[#["W"] &, terms]] /. rules, ranges1 /. rules}];
  (* order 0 along the numeric direction alone: no symbolic cancellation needed *)
  value0 = eulerAt[ConstantArray[0, Length[gs]]];
  ranges = value0[[2]];
  value0 = SeriesCoefficient[Series[value0[[1]], {tau, 0, 0}], 0];
  (* orders 1..degree: the degree-k part in the sigmas of the tau^k coefficient (F_k(sigma + direction) restricted) *)
  coefficients = <|0 -> value0|>;
  If[degree > 0,
    Module[{full, ser},
      full = eulerAt[sigmas];
      If[full[[2]] =!= ranges, trigPairRefuse["the Euler variables depend on the dressing shifts"]];
      ser = Series[full[[1]], {tau, 0, degree}];
      Do[coefficients[k] = Cancel[Together[SeriesCoefficient[ser, k]]], {k, 1, degree}]]];
  bellShifts = sigmas;
  bell = trigPairBell[gs, signs, bellShifts, p];
  (* the basis up to the degree of the dressing *)
  live = DeleteCases[sigmas, 0];
  basis = Join[{1}, If[degree >= 1, live, {}],
    If[degree >= 2, Flatten[Table[live[[i1]] live[[j1]], {i1, Length[live]}, {j1, i1, Length[live]}]], {}]];
  unknowns = Table[Unique["MBParameter`Private`tpc"], {Length[basis]}];
  rhs = Expand[unknowns[[1]] + Sum[unknowns[[j]] Coefficient[bell, basis[[j]]] /. Thread[DeleteCases[sigmas, 0] -> 0], {j, 2, Length[basis]}]];
  monomials = Union[Cases[{dressing, rhs}, _p, {0, Infinity}]];
  equations = Thread[Flatten[CoefficientList[Expand[dressing - rhs], monomials]] == 0];
  solution = Quiet[Solve[equations, unknowns]];
  If[solution === {} || !ListQ[solution], trigPairRefuse["the dressing is not in the second-order Bell span"]];
  solution = First[solution];
  (* the Euler integrand of a basis monomial: its coefficient in the tau^k coefficient, k its degree *)
  taylorOf[b_] := Module[{k},
    k = If[b === 1, 0, Exponent[b /. Thread[DeleteCases[sigmas, 0] -> tau], tau]];
    If[k === 0, coefficients[0],
      Coefficient[coefficients[k], b] /. Thread[DeleteCases[sigmas, 0] -> 0]]];
  integrand = Sum[((unknowns[[j]] /. solution) /. Thread[unknowns -> 0]) taylorOf[basis[[j]]], {j, Length[basis]}];
  If[!FreeQ[integrand, Alternatives @@ Join[vars, regulators]] || !FreeQ[integrand, _p],
    trigPairRefuse["the Euler integrand still holds a fold, shift or polygamma"]];
  {{integrand, ranges}}], $trigPairTag];

(* two gate points with pairwise distinct coordinates (the grid of parameterPoints repeats a value for up to three
   parameters, and at u2 = u3 the G form of a piece with a letter u2 - u3 has no numerical value), well-spread as the
   points parameterPoints takes for four or more parameters *)
trigPairPoints[pars_, dom_] := Module[{spread, grid},
  If[pars === {}, Return[{{}, {}}, Module]];
  spread = {{1/3, 2/5, 3/7, 4/9, 5/11, 6/13, 7/15, 8/17}, {1/2, 2/7, 3/8, 2/9, 5/12, 3/10, 4/11, 5/13},
    {2/3, 3/5, 4/7, 5/9, 6/11, 7/13, 8/15, 9/17}, {2, 3, 5/2, 7/3, 9/4, 11/5, 13/6, 15/7}};
  If[Length[pars] > 8, Return[parameterPoints[pars, dom], Module]];
  grid = Map[Thread[pars -> Take[#, Length[pars]]] &, spread];
  grid = Select[grid, TrueQ[dom /. #] &];
  If[Length[grid] < 2, Return[parameterPoints[pars, dom], Module]];
  Take[grid, 2]];

trigPairClose[ig_, ctr_, vars_, pars_, dom_, seconds_] := Module[{points, cubes, raw, value, ctr1},
  $trigPairLastReason = None;
  If[vars === {} || DownValues[HyperIntica`HyperIntica] === {}, Return[$Failed, Module]];
  points = trigPairPoints[pars, dom];
  If[Length[points] < 2, Return[$Failed, Module]];
  (* a contour within 1/10 of a pole moves to the centre of its pole chamber (same value; centerParameterContour, as in
     closePiece), found on the common fold structure: a group of terms reaches this closer without that step, and the
     gate's contour quadrature converges poorly next to a pole *)
  Module[{expanded, first, centered},
    expanded = Expand[ig];
    first = If[Head[expanded] === Plus, First[expanded], expanded];
    centered = Quiet@centerParameterContour[trigPairStructure[trigPairRationalToGamma[first, vars], vars], ctr, vars, dom];
    If[AssociationQ[centered], ctr1 = centered["Contour"], ctr1 = ctr]];
  cubes = Quiet@TimeConstrained[trigPairCubes[ig, ctr1, vars, pars], Min[600, seconds/2], $trigPairLastReason = "the conversion timed out"; $Failed];
  If[!ListQ[cubes], Return[$Failed, Module]];
  raw = Table[Quiet@TimeConstrained[
      Block[{HyperIntica`$NoAlgebraicRootsContributions = False, HyperIntica`$HyperAlgebraicRoots = True,
          HyperIntica`$QuietPrint = True, HyperIntica`$HyperInticaAbortOnDivergence = False},
        HyperIntica`HyperIntica[Together[c[[1]]], Map[#[[1]] -> {#[[2]], #[[3]]} &, c[[2]]]]],
      seconds, $Failed], {c, cubes}];
  If[MemberQ[raw, $Failed | $Aborted], $trigPairLastReason = "HyperIntica failed or timed out"; Return[$Failed, Module]];
  value = Expand[Total[raw] /. HyperIntica`ZeroInfPeriod[w_List] :> period[w]];
  If[!exactQ[value, pars], $trigPairLastReason = "the HyperIntica value is not exact"; Return[$Failed, Module]];
  If[!sourceGate[ig, ctr1, vars, value, pars, points], $trigPairLastReason = "the source gate rejected the value"; Return[$Failed, Module]];
  value];

End[];
EndPackage[];
Print["[mbeParameterTrigPairRung] trig-pair Barnes-to-Euler closer for refused parameter coefficients."];
