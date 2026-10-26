(* AUTHORSHIP (release R2, 2026-09-07): component of the MBSymbolicInt package (Standard route). Authors of MBSymbolicInt: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* ============================================================
   mbePinchClose.m  (2026-07-24)

   SIDECAR: the PINCH-class closer for the STANDARD route.
   Class: eps-free multi-fold coefficients carrying a CROSS-VARIABLE
   Gamma (Gamma[c + s_i z_i + s_j z_j]) whose faithful cube has
   non-normal-crossing (NNC) corners -> MBtoEuler's ordinary path
   fails with the pinched/degenerate Block-5 fingerprint.

   METHOD (validated on MB10 p_0057, 2026-07-24):
     1. faithful cube via MBtoEuler with $mbeFlagNNCCorners=True and
        the F-pattern/degenerate diverters OFF (PartAFailure===None
        certifies the cube);
     2. CORNER-LINEAR EXACT INTEGRATION: every NNC corner factor P
        that is linear in a PRIVATE variable v (P is the only
        v-carrying denominator factor; numerator depends on v only
        polynomially) is integrated over v in closed form (rational
        integral) -- this kills the corner multiplicity exactly
        (eps-free analogue of the subtraction-route Prop-corner);
     3. PRODUCT COLLAPSE: variable pairs entering only through x*y
        are reduced to one variable by the exact rule
        Int_0^1 Int_0^1 x^p y^q f(xy) dx dy
          = Int_0^1 f(w) w^q (1-w^(p-q))/(p-q) dw   (p != q)
          = Int_0^1 f(w) w^p (-Log[w]) dw           (p == q);
     4. remaining variables by mbeSeqIntegrate (Integrate-first
        sequential chain, PLT GIntegrate fallback);
     5. SERVE ONLY on a numeric match (1e-6 rel) against the piece
        ORACLE: Schwinger-decoupled evaluation for a single cross-
        Gamma piece (two clean 1-fold contour quadratures x 1D
        t-integral; subtracted Cahen-Mellin), else the direct 2-fold
        contour quadrature. Unverifiable or mismatched -> $Failed
        (caller ledgers; never a silent value).
   ============================================================ *)

Begin["MBAnalytica`SymbolicInt`Private`"];

$mbePinchCloserEnabled = True;
If[$RecursionLimit < 8192, $RecursionLimit = 8192];
$mbePinchDebug = False;
mbePinchDbg[msg___] := If[TrueQ[$mbePinchDebug],
  WriteString["stdout", "    [PinchLin/dbg] ", msg, "\n"]];
If[! AssociationQ[$mbePinchClosedForms], $mbePinchClosedForms = <||>];

(* strict chain-result acceptance: no Integrate/ConditionalExpression
   remnants (mixed G+Integrate forms choke Ginsh), numeric value exists.
   TIME-BOUNDED: an unbounded Ginsh on a large G-form wedged for 40+ min
   (mb3g piece 1); 300 s is ample for a genuine value. *)
mbePinchChainOK[rr_] := rr =!= $Failed &&
  FreeQ[rr, Integrate | ConditionalExpression] &&
  NumericQ[Quiet@N[Quiet@TimeConstrained[mbeSeqNValue[rr, 20], 300, $Failed]]];

(* ---------- detection ---------- *)
mbePinchCrossGammas[intg_, vrs_List] := Union@Cases[intg,
  Gamma[a_] /; Length[Intersection[Variables[a], vrs]] >= 2 :> a,
  {0, Infinity}];

(* numerator cross-Gammas only (denominator 1/Gamma is entire: no pinch) *)
mbePinchNumeratorCrossGammas[intg_, vrs_List] := Module[{num},
  num = Numerator[Together[intg]];
  mbePinchCrossGammas[num, vrs]];

(* Eligible: 2-fold with a numerator cross-Gamma (the pinch class), or ANY
   1-fold (the origin-pole / psi-rep class, e.g. MB10 p_0055 and the MB6
   z35 family, whose cubes are individually divergent and need the
   union-sum treatment). Fires only after all ordinary attempts failed. *)
mbePinchPieceQ[intg_, vrs_List] :=
  (Length[vrs] == 2 && mbePinchNumeratorCrossGammas[intg, vrs] =!= {}) ||
  Length[vrs] == 1;

(* ---------- oracle: Schwinger decoupling for ONE cross-Gamma ---------- *)
(* piece = pref * f_i(z_i) * f_j(z_j) * Gamma[c + s_i z_i + s_j z_j].
   Gamma[arg] = Int_0^inf t^(arg-1) Ksub(t) dt  (subtracted Cahen-Mellin,
   K = floor(-Re(arg_c)) subtractions), kernel t^(s_i z_i) t^(s_j z_j)
   factorizes -> two 1-fold contour quads F_i(t), F_j(t). *)
mbePinchSchwingerTruth[intg_, ctr_List, vrs_List, wp_:16] := Module[
  {cross, carg, zi, zj, si, sj, rest, parts, fi, fj, c0, argc, Ksub, kern,
   Fi, Fj, val, zic, zjc, prefN},
  cross = mbePinchNumeratorCrossGammas[intg, vrs];
  If[Length[cross] =!= 1, Return[$Failed]];
  carg = First[cross];
  {zi, zj} = vrs[[1 ;; 2]];
  si = D[carg, zi]; sj = D[carg, zj];
  If[! (MemberQ[{1, -1}, si] && MemberQ[{1, -1}, sj]), Return[$Failed]];
  rest = Cancel[Together[intg/Gamma[carg]]];
  If[! FreeQ[rest, Gamma[a_] /; Length[Intersection[Variables[a], vrs]] >= 2],
    Return[$Failed]];
  (* split rest = fi(zi)*fj(zj)*const; fail if not multiplicatively split.
     NO inner Module here (trap #20: Return[..,Module] would exit it). *)
  parts = If[Head[rest] === Times, List @@ rest, {rest}];
  fi = Times @@ Select[parts, ! FreeQ[#, zi] && FreeQ[#, zj] &];
  fj = Times @@ Select[parts, ! FreeQ[#, zj] && FreeQ[#, zi] &];
  prefN = Times @@ Select[parts, FreeQ[#, zi] && FreeQ[#, zj] &];
  If[! PossibleZeroQ[Simplify[rest - fi fj prefN]], Return[$Failed]];
  zic = zi /. ctr; zjc = zj /. ctr;
  (* c0 = CONSTANT part of the cross-Gamma argument: the outer kernel is
     t^(c0-1); the z-dependent parts t^(si zi), t^(sj zj) live in Fi, Fj.
     (Bug fixed 2026-07-24: using the numeric contour value here instead
     of c0 gave a wrong oracle, -0.061182 vs -0.060693 on p_0057.) *)
  c0 = carg /. {zi -> 0, zj -> 0};
  argc = carg /. ctr;                        (* numeric arg on the contour *)
  Ksub = Max[0, Floor[-Re[N[argc]]] + 1];   (* number of Taylor terms removed *)
  kern[t_] := Exp[-t] - Sum[(-t)^k/k!, {k, 0, Ksub - 1}];
  Fi[t_?NumericQ] := (1/(2 Pi)) NIntegrate[
    (fi /. zi -> zic + I s) t^(si (zic + I s)), {s, -35, 35},
    WorkingPrecision -> wp + 2, MaxRecursion -> 14, PrecisionGoal -> wp - 6];
  Fj[t_?NumericQ] := (1/(2 Pi)) NIntegrate[
    (fj /. zj -> zjc + I s) t^(sj (zjc + I s)), {s, -35, 35},
    WorkingPrecision -> wp + 2, MaxRecursion -> 14, PrecisionGoal -> wp - 6];
  val = Quiet@NIntegrate[kern[t] t^(c0 - 1) Fi[t] Fj[t] // Re,
    {t, 0, Infinity}, WorkingPrecision -> wp, PrecisionGoal -> Min[8, wp - 6],
    MaxRecursion -> 12, Method -> "DoubleExponential"];
  If[NumericQ[Quiet@N[val]], prefN val, $Failed]];

(* nested 1D contour quadratures (robust general 2-fold oracle: the inner
   1-fold is smooth and exponentially decaying at each fixed outer point) *)
mbePinchNestedQuadTruth[intg_, ctr_List, vrs_List, wp_:14] := Module[
  {zi, zj, zic, zjc, fInner, v},
  {zi, zj} = vrs[[1 ;; 2]]; zic = zi /. ctr; zjc = zj /. ctr;
  fInner[ss_?NumericQ] := Quiet@NIntegrate[
    (intg /. {zi -> zic + I ss, zj -> zjc + I Global`mbxU})/(2 Pi)^2,
    {Global`mbxU, -32, 32}, WorkingPrecision -> wp + 2,
    PrecisionGoal -> wp - 6, MaxRecursion -> 12];
  v = Quiet@TimeConstrained[NIntegrate[fInner[Global`mbxS] // Re,
      {Global`mbxS, -32, 32}, WorkingPrecision -> wp,
      PrecisionGoal -> Min[8, wp - 6], MaxRecursion -> 10], 900, $Failed];
  If[NumericQ[Quiet@N[v]], v, $Failed]];

(* 1-fold oracle: plain contour quadrature *)
mbePinchQuad1Truth[intg_, ctr_List, vrs_List] := Module[{z1, z1c, v},
  z1 = First[vrs]; z1c = z1 /. ctr;
  v = Quiet@TimeConstrained[NIntegrate[
      (intg /. z1 -> z1c + I Global`mbxS)/(2 Pi) // Re,
      {Global`mbxS, -60, 60}, WorkingPrecision -> 25,
      PrecisionGoal -> 10, MaxRecursion -> 14], 240, $Failed];
  If[NumericQ[Quiet@N[v]], v, $Failed]];

mbePinchTruthN[intg_, ctr_List, vrs_List] := Module[{s, q},
  If[Length[vrs] == 1,
    q = mbePinchQuad1Truth[intg, ctr, vrs];
    Return[If[NumericQ[Quiet@N[q]], {q, 10^-6}, $Failed]]];
  s = Quiet@TimeConstrained[
    mbePinchSchwingerTruth[intg, ctr, vrs], 600, $Failed];
  If[NumericQ[Quiet@N[s]], Return[{s, 10^-6}]];
  q = mbePinchNestedQuadTruth[intg, ctr, vrs];
  If[NumericQ[Quiet@N[q]], {q, 10^-5}, $Failed]];

(* ---------- the faithful NNC cube ---------- *)
mbePinchCube[intg_, ctr_List, vrs_List, timeout_:400] := Module[{em, eis},
  em = Block[{$Assumptions = True,
      MBAnalytica`SymbolicInt`Private`mbeMatchesFPatternQ,
      MBAnalytica`SymbolicInt`Private`mbeMatchesDegenerateKernelQ,
      MBAnalytica`SymbolicInt`Private`$mbeFlagNNCCorners = True},
    MBAnalytica`SymbolicInt`Private`mbeMatchesFPatternQ[___] := False;
    MBAnalytica`SymbolicInt`Private`mbeMatchesDegenerateKernelQ[___] := False;
    Quiet@TimeConstrained[
      MBAnalytica`SymbolicInt`MBtoEuler[intg, ctr, vrs, "Assumptions" -> {}], timeout, $Failed]];
  If[! AssociationQ[em] || em["PartAFailure"] =!= None ||
     TrueQ[em["PartialResult"]], Return[$Failed]];
  eis = em["EulerIntegrands"];
  If[! ListQ[eis], Return[$Failed]];
  (* SANITIZE: some entries (PartB/corrections bookkeeping) carry a
     malformed vars slot (seen: Union[{}[[1]][CubeVariables], {}] on
     p_0055 cube 2). Re-derive the cube variables from the integrand;
     the cube-variable heads are t/u/s/bdyU with integer index. *)
  Table[
    Module[{ig = eis[[e, 1]], vv = eis[[e, 2]], good},
      good = ListQ[vv] && (vv === {} ||
        MatchQ[vv, {((t | u | s | bdyU)[_Integer]) ..}]);
      If[! good,
        vv = Union@Cases[ig, (t | u | s | bdyU)[_Integer], {0, Infinity}];
        mbePinchDbg["cube ", e, ": malformed vars slot; re-derived ",
          ToString[vv]]];
      {ig, vv}],
    {e, Length[eis]}]];

(* ---------- corner-linear exact integration ---------- *)
(* NNC corner factors: denominator factors depending on >=2 cube vars *)
mbePinchCornerFactors[expr_, cvars_List] := Module[{den},
  den = Denominator[Together[expr]];
  Union@Cases[Quiet@FactorList[den][[All, 1]],
    f_ /; Length[Intersection[Variables[f], cvars]] >= 2]];

(* private linear variables: v such that the denominator's v-carrying
   content is a SINGLE distinct factor (any multiplicity), linear in v,
   and the numerator is polynomial in v.  Sign/normalization-robust via
   FactorList.  Returns {v, factor} pairs, corner-factors (>=2 cube vars)
   first. *)
mbePinchPrivateVars[expr_, cvars_List] := Module[{tog, den, num, fl, out},
  tog = Together[expr];
  den = Denominator[tog]; num = Numerator[tog];
  fl = DeleteCases[Quiet@FactorList[den][[All, 1]], _?NumericQ];
  out = Reap[Do[
    Module[{vfacs = Select[fl, ! FreeQ[#, v] &]},
      If[Length[vfacs] === 1 && Exponent[vfacs[[1]], v] === 1 &&
         PolynomialQ[num, v],
        Sow[{v, vfacs[[1]],
          Length[Intersection[Variables[vfacs[[1]]], cvars]]}]]],
    {v, cvars}]][[2]];
  If[out === {}, {},
    SortBy[out[[1]], -Last[#] &][[All, 1 ;; 2]]]];

mbePinchCornerLinReduce[expr0_, cvars0_List, timeout_:600] := Module[
  {expr = expr0, cvars = cvars0, priv, v, r, progress = True},
  While[progress && mbePinchCornerFactors[expr, cvars] =!= {},
    progress = False;
    priv = mbePinchPrivateVars[expr, cvars];
    (* only integrate vars whose private factor is a genuine corner
       (>=2 cube vars) — plain one-var factors are left to the chain *)
    priv = Select[priv,
      Length[Intersection[Variables[#[[2]]], cvars]] >= 2 &];
    Do[
      v = pv[[1]];
      r = Quiet@TimeConstrained[
        Integrate[expr, {v, 0, 1},
          Assumptions -> And @@ (0 < # < 1 & /@ DeleteCases[cvars, v])],
        timeout, $Failed];
      If[r =!= $Failed && FreeQ[r, Integrate | ConditionalExpression],
        expr = r; cvars = DeleteCases[cvars, v]; progress = True;
        Break[]],
      {pv, priv}]];
  {expr, cvars}];

(* ---------- product collapse x,y -> w ---------- *)
(* Exact rule, no exponent extraction needed: substitute x = w/y (fixed y,
   dx = dw/y, region w < y < 1):
     Int_0^1 Int_0^1 e(x,y) dx dy = Int_0^1 dw Int_w^1 dy/y * e(w/y, y).
   If e(w/y, y) == y^m * H(w) exactly (checked symbolically), the inner
   y-integral closes:
     Int_w^1 y^(m-1) H(w) dy = H(w) (1-w^m)/m   (m != 0)
                             = H(w) (-Log[w])   (m == 0).
   H = e(w/y,y)|_{y->1}.  Iterates over pairs until no collapse applies. *)
mbePinchProductCollapse[expr0_, cvars0_List] := Module[
  {expr = expr0, cvars = cvars0, x, y, h, hy, m, g1, wv, meas, again = True},
  While[again && Length[cvars] >= 2,
    again = False;
    Do[
      {x, y} = pr;
      h = Quiet@TimeConstrained[
        Together[PowerExpand[expr /. x -> Global`mbxW/y]], 60, $Failed];
      If[h === $Failed || h === Indeterminate, Continue[]];
      (* find integer m with h == y^m H(w): m from the y-log-derivative at a
         generic point, then verify symbolically *)
      m = Quiet@TimeConstrained[Simplify[y D[h, y]/h], 60, $Failed];
      If[m === $Failed || ! IntegerQ[m], Continue[]];
      If[! PossibleZeroQ[Quiet@TimeConstrained[
           Simplify[D[h/y^m, y]], 90, 1]], Continue[]];
      g1 = Quiet@Simplify[h /. y -> 1];              (* H(w) *)
      If[! FreeQ[g1, y] || ! FreeQ[g1, x], Continue[]];
      wv = Unique["mbxWv"];
      meas = If[m === 0, -Log[wv], (1 - wv^m)/m];
      expr = (g1 /. Global`mbxW -> wv) meas;
      expr = With[{s = Quiet@TimeConstrained[Simplify[expr], 120, $Failed]},
        If[s === $Failed, expr, s]];
      cvars = Append[DeleteCases[cvars, x | y], wv];
      mbePinchDbg["collapsed (", ToString[x], ",", ToString[y],
        ") -> ", ToString[wv], "  m=", ToString[m]];
      again = True; Break[],
      {pr, Subsets[cvars, {2}]}]];
  {expr, cvars}];

(* ---------- endpoint subtraction (union-sum normal form) ----------
   The union-sum is pointwise finite, but its additive terms carry
   endpoint poles 1/(1-v)^p or 1/v^p whose cancellation can be
   TRANSCENDENTAL (rational halves against Log[...]-coefficient halves)
   — invisible to Cancel, and Integrate's termwise splitting then makes
   Infinity-Infinity. Normal form: per term T = A(v,..)/(1-v)^p write
     T = (A - A|_{v=1})/(1-v)^p + A|_{v=1}/(1-v)^p ;
   the first part is individually integrable; the collected second
   parts must vanish (pointwise finiteness) and are checked+dropped
   (kept if nonzero — then deeper pole orders iterate). Same at v=0. *)
mbePinchEndpointSubtract[expr0_, vars_List] := Module[
  {terms, out, resid, v, changed = False},
  terms = If[Head[expr0] === Plus, List @@ expr0, {expr0}];
  Do[
    Module[{news = {}, sub1 = 0, sub0 = 0},
      Do[
        Module[{t = tt, tog, p1, A, A1},
          (* pole order at v=1: vanishing order (lowest power, Exponent[..,Min])
             of the denominator minus the numerator at v=1-e; Log[...] etc.
             are atoms and do not enter the rational skeleton *)
          tog = Together[t];
          p1 = Quiet@Check[
            Max[0,
              Exponent[Denominator[tog] /. v -> 1 - Global`mbxEV,
                Global`mbxEV, Min] -
              Exponent[Numerator[tog] /. v -> 1 - Global`mbxEV,
                Global`mbxEV, Min]], 0];
          If[! IntegerQ[p1], p1 = 0];
          If[p1 >= 1,
            A = Quiet@TimeConstrained[
              Simplify[t (1 - v)^p1], 30, t (1 - v)^p1];
            A1 = Quiet@TimeConstrained[Simplify[A /. v -> 1], 30, $Failed];
            If[A1 =!= $Failed && FreeQ[A1, DirectedInfinity | ComplexInfinity |
                Indeterminate],
              news = Append[news, (A - A1)/(1 - v)^p1];
              sub1 += A1/(1 - v)^p1; changed = True,
              news = Append[news, t]],
            news = Append[news, t]]],
        {tt, terms}];
      (* collected pole parts must cancel; verify (symbolic or numeric at
         random points) then drop; if genuinely nonzero keep them intact *)
      If[sub1 =!= 0,
        Module[{zq, othv, pts, nvals},
          zq = PossibleZeroQ[Quiet@TimeConstrained[Simplify[sub1], 60, 1]];
          If[! zq,
            (* indexed cube vars (s[2], t[1], ...) are NOT Variables[] atoms:
               extract them structurally (bug fixed 2026-07-25: the numeric
               zero-check sampled nothing and kept an identically-zero pole
               sum, poisoning the chain) *)
            othv = DeleteCases[
              Union@Cases[sub1, (s | t | u | bdyU)[_Integer], {0, Infinity}], v];
            pts = Table[Thread[othv -> RandomReal[{1/10, 9/10}, Length[othv]]],
              {3}];
            nvals = Quiet@Table[
              Abs[N[(Together[sub1 (1 - v)] /. v -> 1) /. pt]], {pt, pts}];
            zq = VectorQ[nvals, NumericQ] && Max[nvals] < 10^-10];
          If[zq,
            mbePinchDbg["endpoint-subtract at ", ToString[v],
              "=1: pole parts cancel (dropped)"],
            news = Append[news, sub1]]];
        terms = news,
        terms = news]],
    {v, vars}];
  If[changed, Total[terms], expr0]];

(* ---------- the closer ---------- *)
mbePinchLinClose[intg_, ctr_List, vrs_List, timeout_:2400] := Module[
  {truth, tol, eis, tot, nv, t0 = AbsoluteTime[]},
  If[! TrueQ[$mbePinchCloserEnabled], Return[$Failed]];
  If[! mbePinchPieceQ[intg, vrs], Return[$Failed]];
  truth = mbePinchTruthN[intg, ctr, vrs];
  If[truth === $Failed, Return[$Failed]];
  {truth, tol} = truth;
  eis = mbePinchCube[intg, ctr, vrs, Min[400, timeout/3]];
  If[eis === $Failed || eis === {}, Return[$Failed]];
  (* Per-cube corner-linear reduction, then ONE chain over the UNION-SUM.
     Individual cubes can be genuinely DIVERGENT (the psi integral rep
     splits (1-s^a)/(1-s) into divergent halves across cubes; measured:
     an MB3 cube whose exact value is finite*HPL[{1},1]); the corner
     reduction never touches the psi-rep variable, so the partners still
     cancel POINTWISE after reduction and the summed integrand is finite.
     Sum-of-integrals == integral-of-sum over the union cube (absent
     variables integrate to 1). *)
  tot = Catch[Catch[Module[{redP, uVars, sum, rr},
    redP = Table[
      Module[{ig = eis[[e, 1]], cvs = eis[[e, 2]]},
        mbePinchDbg["cube ", e, "/", Length[eis], " vars=", ToString[cvs],
          " LC=", LeafCount[ig]];
        {ig, cvs} = mbePinchCornerLinReduce[ig, cvs, Min[600, timeout/2]];
        mbePinchDbg["  reduced: vars=", ToString[cvs], " LC=", LeafCount[ig],
          " cornersLeft=",
          ToString[Length[mbePinchCornerFactors[ig, cvs]]]];
        {ig, cvs}],
      {e, Length[eis]}];
    uVars = Union @@ redP[[All, 2]];
    sum = Total[redP[[All, 1]]];
    mbePinchDbg["union-sum: vars=", ToString[uVars], " LC=", LeafCount[sum]];
    {sum, uVars} = mbePinchProductCollapse[sum, uVars];
    mbePinchDbg["after collapse: vars=", ToString[uVars], " LC=", LeafCount[sum]];
    (* ATTEMPT 1 — Together'd chain.  Integrate maps sums TERM-WISE
       internally, so a union-sum whose members are divergent halves
       yields Infinity-Infinity=Indeterminate even though the sum is
       pointwise finite (measured on MB3 piece 1).  Together makes the
       cancellation manifest (common denominator, vanishing numerator)
       BEFORE the integrator can split it. *)
    Module[{tog, rr1 = $Failed, rr2 = $Failed, multiCube = Length[eis] > 1,
        chainTogether, chainEndpointSub},
      chainTogether[] := (
        (* Cancel after Together: purely-rational canceling endpoint poles
           are removed algebraically; transcendental (Log-coefficient)
           cancellations are NOT — those need the endpoint subtraction. *)
        tog = Quiet@TimeConstrained[Cancel[Together[sum]], 180, $Failed];
        If[tog =!= $Failed,
          mbePinchDbg["together: LC=", LeafCount[tog]];
          rr1 = Block[{$RecursionLimit = 16384},
            mbeSeqIntegrate[tog, uVars,
              Max[120, Min[900, timeout - (AbsoluteTime[] - t0)]]]];
          mbePinchDbg["seq(Together) result: ", If[rr1 === $Failed, "FAILED",
            "LC=" <> ToString[LeafCount[rr1]]]];
          If[mbePinchChainOK[rr1],
            Throw[rr1, mbePinchOKTag]]]);
      chainEndpointSub[] := Module[{sub},
        (* per-term pole parts subtracted at v=1 (grouped differences stay
           grouped), collected pole parts cancel by pointwise finiteness *)
        sub = Quiet@TimeConstrained[
          mbePinchEndpointSubtract[Expand[sum], uVars], 300, $Failed];
        If[sub =!= $Failed,
          mbePinchDbg["endpoint-subtracted: LC=", LeafCount[sub]];
          rr2 = Block[{$RecursionLimit = 16384},
            mbeSeqIntegrate[sub, uVars,
              Max[120, Min[900, timeout - (AbsoluteTime[] - t0)]]]];
          mbePinchDbg["seq(EndpointSub) result: ",
            If[rr2 === $Failed, "FAILED", "LC=" <> ToString[LeafCount[rr2]]]];
          If[mbePinchChainOK[rr2],
            Throw[rr2, mbePinchOKTag]]]];
      (* UNIVERSAL ordering (2026-07-25): endpoint-subtracted chain FIRST
         for every shape — single-cube remainders have their own t->1
         bracket cancellations (p_0057's 391-way distribute produced
         divergent atoms exactly like the MB3 family), and the subtraction
         is a no-op when no endpoint poles exist. Together second. *)
      chainEndpointSub[]; chainTogether[];
      (* ATTEMPT 2.5 — SHALLOW DISTRIBUTE for product-of-brackets shapes
         (the p_0057 manual route): distribute the top-level product of
         Plus-brackets ONCE (4-9 structural terms, logs kept atomic) and
         close each bracket-term separately, summing. Avoids both the
         monolithic form (RecursionLimit) and the 900-term full Expand. *)
      If[! multiCube,
        Module[{brk = sum, parts, vals, ok = True},
          If[Head[brk] === Times &&
             Count[List @@ brk, _Plus] >= 2,
            parts = List @@ Distribute[brk];
            mbePinchDbg["shallow-distribute: ", Length[parts], " terms"];
            vals = Table[
              Module[{rt = Block[{$RecursionLimit = 16384},
                  mbeSeqIntegrate[parts[[j]], uVars,
                    Max[120, Min[900, timeout - (AbsoluteTime[] - t0)]]]]},
                If[! mbePinchChainOK[rt],
                  ok = False; $Failed, rt]],
              {j, Length[parts]}];
            If[ok,
              mbePinchDbg["shallow-distribute chain CLOSED all ",
                Length[parts], " terms"];
              Throw[Total[vals], mbePinchOKTag],
              mbePinchDbg["shallow-distribute: some term failed"]]]]];
      (* ATTEMPT 3 — Expand'd chain (legacy: single-cube product shapes) *)
      rr2 = With[{x = Quiet@TimeConstrained[Expand[sum], 120, $Failed]},
        If[x === $Failed, sum, x]];
      mbePinchDbg["after expand: LC=", LeafCount[rr2], "  terms=",
        If[Head[rr2] === Plus, Length[rr2], 1]];
      rr2 = Block[{$RecursionLimit = 16384},
        mbeSeqIntegrate[rr2, uVars,
          Max[120, Min[900, timeout - (AbsoluteTime[] - t0)]]]];
      mbePinchDbg["seq(Expand) result: ", If[rr2 === $Failed, "FAILED",
        "LC=" <> ToString[LeafCount[rr2]]]];
      If[mbePinchChainOK[rr2],
        Throw[rr2, mbePinchOKTag]];
      mbePinchDbg["all chains failed -> fail"];
      Throw[$Failed, mbePinchTag]]], mbePinchOKTag], mbePinchTag];
  If[tot === $Failed, Return[$Failed]];
  nv = mbeSeqNValue[tot, 20];
  If[! NumericQ[Quiet@N[nv]], Return[$Failed]];
  If[Abs[N[nv, 20] - truth] <= tol (1 + Abs[truth]),
    WriteString["stdout",
      "    [PinchLin] corner-linear closer ORACLE-VERIFIED (tol " <>
      ToString[N[tol]] <> ").\n"];
    tot,
    WriteString["stdout",
      "    [PinchLin] value-vs-oracle MISMATCH: " <> ToString[N[nv, 12]] <>
      " vs " <> ToString[N[truth, 12]] <> " -> $Failed.\n"];
    $Failed]];

End[];

Print["[mbePinchClose] sidecar loaded (pinch corner-linear closer; ",
  "oracle-gated; $mbePinchCloserEnabled=",
  ToString[MBAnalytica`SymbolicInt`Private`$mbePinchCloserEnabled], ")."];
