(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* ============================================================
   mbeSeqIntegrate.m  (2026-07-22)

   SIDECAR PATCH for MB2MPL.m — NO PolyLogTools source
   change.  Load AFTER the main package (and after PolyLogTools).

   PURPOSE.  Integrate a faithful-cube integrand over [0,1]^n by
   SEQUENTIAL single-variable integration, as a fallback for the class
   of integrands on which PolyLogTools' ToFibrationBasis fails.

   WHY THIS IS NEEDED (understood from the PLT source + Panzer 2015).
   ToFibrationBasis requires GLOBAL linear reducibility: one integration
   order in which every denominator polynomial stays linear at each step
   (DenominatorReduction.m: ReduceSet / FindIntegrationOrder).  The
   reduction builds cross-term resultants and, WITHOUT the Fubini
   restriction, can emit SPURIOUS polynomials that are non-linear in a
   later variable — making FindIntegrationOrder wrongly report "not
   reducible" for an integrand that IS reducible.  This is exactly the
   documented HyperInt limitation (Panzer, arXiv:1403.3385; the Fubini
   restriction filters such spurious factors).  It is the failure hit by
   the derivative-form [iota^k] coefficients (weight-k logs over a cubic
   Mobius denominator, e.g. log^2(1-t)/(t + u1 u2 u3 (1-t))^3).

   THE FIX.  Mathematica's built-in Integrate handles each SINGLE-variable
   step ad hoc (the integrand is linear in the current variable in the
   denominator, so each step is a genuine hyperlogarithm integral); no
   GLOBAL reducibility and hence no spurious global polynomials arise.
   For any single variable that Integrate cannot close, we fall back to
   PolyLogTools' GIntegrate (single-variable MPL, its strength) after a
   G-basis conversion.  Verified on the offset-3 psi0^2 [iota^2]
   coefficient: reproduces the contour value to 12 digits where
   ToFibrationBasis returns unevaluated.
   ============================================================ *)

Begin["MBtoMPL`Private`"];

(* Order variables cheapest-first: integrate the ones the denominator is
   linear in and that appear in the fewest G/log factors first, so the
   surviving integrand stays as simple as possible for the last step. *)
mbeSeqVarOrder[integrand_, vars_List] := Module[{den, score},
  den = Denominator[Together[integrand]];
  score = Function[v,
    {Exponent[den, v],                              (* denom degree in v *)
     Count[integrand, (Log | PolyLog | Global`G |
        PolyLogTools`G)[___, a_ /; ! FreeQ[a, v]], {0, Infinity}]}];
  SortBy[vars, score]];

(* Integrate one variable over [0,1]; symbolic Integrate first, then
   GIntegrate (PLT) on a G-basis conversion, then leave the definite
   Integrate unevaluated (numerically evaluable) as a last resort. *)
(* NOTE: v may be a cube variable t[2], u[1], ... whose head is t/u, NOT
   Symbol — so match v_ (any), never v_Symbol (trap hit 2026-07-22). *)
mbeSeqIntegrateOne[integrand_, v_, others_List, timeout_:600] :=
  Module[{ass, r, asG},
    ass = And @@ Join[Thread[others > 0], Thread[others < 1]];
    r = Quiet@TimeConstrained[
      Integrate[integrand, {v, 0, 1}, Assumptions -> ass], timeout, $Failed];
    (* 2026-07-25 FIX: Indeterminate/Infinity is NOT success. Integrate
       splits pointwise-finite sums termwise (Infinity-Infinity ->
       Indeterminate); such results previously RETURNED here and the PLT
       shuffle-regularized fallback below (which handles exactly these
       canceling endpoint divergences via the G-basis) never fired. *)
    If[r =!= $Failed && FreeQ[r, Integrate | v] &&
       FreeQ[r, Indeterminate | DirectedInfinity | ComplexInfinity] &&
       (* 2026-07-25: a ConditionalExpression is a BRANCH result (e.g. the
          corner wall tt2+w<=1 on the pinch remainders) — treating it as
          success poisons every later step; region-split callers handle it *)
       FreeQ[r, ConditionalExpression | Undefined],
      Return[r]];
    (* PLT single-variable fallback: convert logs/polylogs of v to G and
       GIntegrate from 0 to 1 (shuffle-regularized at the endpoints).
       2026-07-25: PLT's fibration needs a PLAIN SYMBOL fibration variable
       (canonical-variable trap: an indexed cube var t[1] silently derails
       it) — rename v to a fresh symbol for the PLT leg and back. *)
    Module[{vSym = Unique["pltV"], eV},
      eV = integrand /. v -> vSym;
      asG = Quiet@TimeConstrained[
        PolyLogTools`ToFibrationBasis[eV, {vSym}], timeout, $Failed];
      If[asG =!= $Failed && FreeQ[asG, PolyLogTools`ToFibrationBasis],
        r = Quiet@TimeConstrained[
          PolyLogTools`GIntegrate[asG, vSym] /. vSym -> 1, timeout, $Failed];
        If[r =!= $Failed && FreeQ[r, PolyLogTools`GIntegrate | vSym] &&
           FreeQ[r, Indeterminate | DirectedInfinity | ComplexInfinity],
          Return[r]]]];
    (* last resort: the definite integral, unevaluated but numeric-ready *)
    Integrate[integrand, {v, 0, 1},
      Assumptions -> ass]];

(* Full sequential integration.  Returns the (possibly MPL) closed form,
   or an object numerically evaluable via N/Ginsh, or $Failed only if a
   step genuinely diverges. *)
mbeSeqIntegrateChain[integrand_, vars_List, timeout_:600] := Module[
  {order, r = integrand, rem},
  If[vars === {}, Return[integrand]];
  order = mbeSeqVarOrder[integrand, vars];
  Do[
    rem = Take[order, -(Length[order] - k)];  (* vars not yet integrated *)
    r = mbeSeqIntegrateOne[r, order[[k]], rem, timeout];
    If[r === $Failed, Return[$Failed]],
    {k, Length[order]}];
  r];

(* Whole-integrand sequential chain is the PROVEN path (patchtest 2026-07-22:
   closes the offset-3 [iota^2] coefficient to leaf-44 = 112.235 in ~15 min).
   Atom-splitting was tried and REVERTED — it was slower (3 h) and the
   per-atom fallback path collapsed. Mathematica's Integrate handles the
   full sum better than the atomised fallback here. *)
mbeSeqIntegrate[integrand_, vars_List, timeout_:600] :=
  mbeSeqIntegrateChain[integrand, vars, timeout];

(* Numeric value of a (possibly unevaluated-Integrate / G-laden) result. *)
mbeSeqNValue[r_, prec_:20] := Quiet@Which[
  r === $Failed, $Failed,
  ! FreeQ[r, PolyLogTools`G | Global`G], Re@PolyLogTools`Ginsh[r, prec],
  ! FreeQ[r, Integrate], Re@NIntegrate @@ (r /. Integrate[f_, rng__] :> {f, rng}),
  True, Re@N[r, prec]];

(* ============================================================
   DERIVATIVE-FORM CLOSER (fold-4) for degenerate psi0^k pieces.

   For a piece  K(z) * psi0(a)^k  with a no-window kernel in K (so the
   direct cube / integral-rep force-shift is fold-(k+3) and times out),
   the EGF  Gamma(a+iota)/Gamma(a) = exp(sum_{j>=1} psi_{j-1}(a) iota^j/j!)
   gives the complete-Bell inversion
     psi0^1 = [iota^1] G
     psi0^2 = 2 [iota^2] G  -  psi1
     psi0^3 = 6 [iota^3] G  -  3 psi0 psi1  -  psi2         (G=Gamma(a+i)/Gamma(a))
   The AUX-GAMMA term injects ONE Gamma (no cube variable), giving a
   fold-(k+2) cube — one lower than the integral-rep — and its [iota^k]
   coefficient is integrated by mbeSeqIntegrate (which closes the
   log^k/(cubic) integrand that ToFibrationBasis cannot).  The lower
   psi-product remainders carry fewer/simpler polygammas and are closed by
   the ordinary cube/shift routes.  Every served value is caller-verified
   against the contour quadrature. *)

$mbeDerivBell = <|
  1 -> {{1, {}}},                                  (* [i^1]G *)
  2 -> {{2, {}}, {-1, {1}}},                        (* 2[i^2]G - psi1 *)
  3 -> {{6, {}}, {-3, {0, 1}}, {-1, {2}}}|>;        (* 6[i^3]G -3 psi0 psi1 - psi2 *)

(* Close K*psi0(a)^k.  kernelCloser closes an ordinary (non-aux) piece
   [cube/shift]; ctr/vrs are the MB contour/variables. Returns numeric or
   $Failed. *)
(* Aux-Gamma [iota^kPow] contribution of K*Gamma(a+i)/Gamma(a), integrated
   by mbeSeqIntegrate.  Returns the (i^kPow)-coefficient value or $Failed.
   NOTE: the Bell coefficient (the leading `k!/…` factor) is carried in
   $mbeDerivBell, so this returns the BARE [i^kPow] value — no extra
   Factorial here. *)
mbeDerivAuxTerm[Kfac_, a_, kPow_Integer, ctr_List, vrs_List, timeout_] :=
  Module[{iot = Unique["iotDF"], auxCube, em, contrib = 0, bad = False},
    auxCube = Kfac Gamma[a + iot]/Gamma[a];
    em = Block[{$Assumptions = True,
                MBtoMPL`Private`mbeMatchesFPatternQ,
                MBtoMPL`Private`mbeMatchesDegenerateKernelQ},
      MBtoMPL`Private`mbeMatchesFPatternQ[___] := False;
      MBtoMPL`Private`mbeMatchesDegenerateKernelQ[___] := False;
      Quiet@TimeConstrained[
        MBtoMPL`MBtoEuler[auxCube, ctr, vrs, "Assumptions" -> {}],
        timeout, $Failed]];
    If[! AssociationQ[em] || em["PartAFailure"] =!= None, Return[$Failed]];
    Do[Module[{ig = em["EulerIntegrands"][[e, 1]],
               vs = em["EulerIntegrands"][[e, 2]], cc, r, nv},
       cc = Coefficient[Normal@Series[ig, {iot, 0, kPow}], iot, kPow];
       If[! PossibleZeroQ[cc],
         r = mbeSeqIntegrate[cc, vs, timeout];
         nv = mbeSeqNValue[r, 20];
         If[NumericQ[Quiet@N[nv]], contrib += nv, bad = True]]],
      {e, Length[em["EulerIntegrands"]]}];
    If[bad, $Failed, contrib]];

mbeDerivFormClose[Kfac_, a_, kPow_Integer, ctr_List, vrs_List,
    kernelCloser_, timeout_:600] := Module[
  {terms, tot = 0, bad = False},
  terms = Lookup[$mbeDerivBell, kPow, $Failed];
  If[terms === $Failed, Return[$Failed]];
  Do[
    With[{coef = term[[1]], psiList = term[[2]]},
      Module[{piece},
        piece = If[psiList === {},
          (* aux-Gamma term: coef * [i^kPow] value *)
          Module[{aux = mbeDerivAuxTerm[Kfac, a, kPow, ctr, vrs, timeout]},
            If[aux === $Failed, bad = True; 0, coef aux]],
          (* psi-product remainder: coef * K * prod psi_m(a) *)
          Module[{rr = kernelCloser[
              coef Kfac Times @@ (PolyGamma[#, a] & /@ psiList),
              ctr, vrs, timeout]},
            If[NumericQ[Quiet@N[rr]], rr, bad = True; 0]]];
        tot += piece]],
    {term, terms}];
  If[bad, $Failed, tot]];

(* Detect a degenerate piece of the form c * K(z) * psi0(a)^k with a SINGLE
   polygamma factor psi0 at one argument a (k = 1,2,3).  Returns
   {Kfac, a, k} (Kfac absorbs the constant and the kernel) or $Failed. *)
mbeDerivFormMatch[integrand_, v_] := Module[{pg, a, k, Kfac},
  pg = Cases[integrand, PolyGamma[0, arg_] /; ! FreeQ[arg, v] :> arg,
    {0, Infinity}] // Union;
  If[Length[pg] =!= 1, Return[$Failed]];      (* one psi0 argument only *)
  a = pg[[1]];
  If[! FreeQ[integrand, PolyGamma[m_ /; m >= 1, _]], Return[$Failed]];
  k = Exponent[integrand, PolyGamma[0, a]];
  If[! (IntegerQ[k] && 1 <= k <= 3), Return[$Failed]];
  Kfac = Simplify[integrand / PolyGamma[0, a]^k];
  If[! FreeQ[Kfac, PolyGamma], Return[$Failed]];
  {Kfac, a, k}];

(* Auto derivative-form close: detect psi0^k, close via mbeDerivFormClose.
   The psi-product remainder uses the ordinary cube/shift routes. *)
mbeDerivFormCloseAuto[integrand_, ctr_List, vrs_List, timeout_:1200] :=
  Module[{m, kcl},
    If[Length[vrs] =!= 1, Return[$Failed]];
    m = mbeDerivFormMatch[integrand, First[vrs]];
    If[m === $Failed, Return[$Failed]];
    kcl[piece_, c_, vv_, to_] := Module[{r},
      r = mbeCubeOrShiftClose[piece, c, vv, Min[to, 600]];
      If[! NumericQ[Quiet@N[r]],
        r = mbeForceShiftClose[piece, c, vv, Min[to, 400]]];
      r];
    mbeDerivFormClose[m[[1]], m[[2]], m[[3]], ctr, vrs, kcl, timeout]];

End[];

Print["[mbeSeqIntegrate] sidecar loaded (sequential-integration fallback ",
  "for ToFibrationBasis failures; no PLT source change)."];
