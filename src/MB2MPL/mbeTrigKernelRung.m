(* AUTHORSHIP (development, 2026-09-07): MB2MPL development rung.  Authors of MB2MPL: Syed Mehedi Hasan, Taushif Ahmed,
   Andreas Rapakoulias, Sumit Banik. *)
(* ============================================================================================================
   mbeTrigKernelRung.m -- TRIGONOMETRIC-KERNEL one-fold class handler (development, 2026-09-07).

   The phase-absorption route (mbePhaseAbsorbRung.m, standard_syed.tex sec:phase-absorb) leaves, at the deep orders
   of MB8, ONE-FOLD eps-free pieces whose Gamma content reduces to a rational function times a TRIGONOMETRIC
   kernel (cot / tan / csc / sec, from reflection pairs and the reciprocal half-integer pair
   1/(Gamma(1/2+b-z) Gamma(1/2-b+z)) = cos(pi(b-z))/pi) dressed by polygammas of integer- and HALF-integer-shifted
   arguments, e.g.  c0 * Gamma(2-z) Gamma(-z) Gamma(z) / (Gamma(-1/2-z) Gamma(1-z) Gamma(3/2+z)) * psi-products.

   The sealed one-fold harmonic-sums closer (mbeCloseMBPieceHS/HSB) is the WRONG tool here: it closes to ONE side and
   its polygamma->harmonic-number map has no rule for the half-integer offsets, so it silently DROPS the half-integer
   tower (measured: it returns a finite part plus ReduceConstants[Indeterminate], off the true value by the whole
   tower).  This rung closes the piece by an explicit residue sum with CORRECT contour-side bookkeeping and the
   half-integer tower done by Mathematica's Sum, and every served value is gated against a high-precision contour
   quadrature -- so a wrong value is never served (fail-closed).

   Value semantics: (1/2 pi i) int_{c-i inf}^{c+i inf} F(z) dz, F the reduced meromorphic (trig+polygamma) integrand.
   Close on the side on which F decays; the value is  -sum(residues right of c)  or  +sum(residues left of c).

   API:  mbeTrigKernelQ[ig, vrs]                 -> True if the one-fold reduces to a trig kernel
         mbeTrigKernelClose[ig, ctr, vrs]         -> exact value (quadrature-gated) or $Failed
   Env / flag: Global`$mbeTrigVerbose = True prints the steps.
   ============================================================================================================ *)

mbeTrigLog[a___] := If[TrueQ[Global`$mbeTrigVerbose], WriteString["stdout", "  [TrigKernel] " <> StringJoin[ToString /@ {a}] <> "\n"]];

(* reduce a product of Gamma's (and polygammas) in the single variable z to a meromorphic form with Sin/Cos/PolyGamma
   (FunctionExpand turns reflection pairs and half-integer Gamma's into trig/elementary); keep it a ratio, no FullSimplify *)
mbeTrigReduce[ig_, z_] := Module[{f = Quiet@FunctionExpand[ig]}, Together[f]];

(* is this a trig-kernel one-fold?  one variable, eps-free, and the reduced form carries a Sin or Cos of Pi z
   (equivalently: a reciprocal half-integer Gamma pair or a no-window reflection pair is present) *)
mbeTrigKernelQ[ig_, vrs_List] := Length[vrs] === 1 && FreeQ[ig, Global`\[Epsilon]] &&
  Module[{z = First[vrs], red}, red = mbeTrigReduce[ig, z];
    ! FreeQ[red, (Sin | Cos | Tan | Cot | Csc | Sec)[_. Pi z + _.]] ||
    (* the raw signature: a denominator Gamma at a half-integer offset in z *)
    AnyTrue[Cases[Denominator[Together[ig]], Gamma[a_] :> a, {0, Infinity}],
       ! IntegerQ[# /. z -> 0] && IntegerQ[2 (# /. z -> 0)] &]];

(* the real poles of F in z: integers (from Sin/Cos/Csc/Cot/Tan/Sec kernels and integer-argument Gamma/PolyGamma) and
   half-integers (from half-integer PolyGamma and Sec/Csc of the shifted kernel), plus the roots of any polynomial
   denominator.  Returned as exact rationals. *)
mbeTrigPoleLattice[F_, z_, lo_, hi_] := Module[{halfInt = False, rats = {}, fl},
  (* half-integer poles present iff the reduced form has a half-integer polygamma or a Sec/Csc[Pi z + half] *)
  halfInt = ! FreeQ[F, PolyGamma[_, a_ /; ! IntegerQ[a /. z -> 0] && IntegerQ[2 (a /. z -> 0)]]] ||
            ! FreeQ[F, (Sec | Csc | Tan | Cot)[Pi z + r_ /; ! IntegerQ[r/Pi] && IntegerQ[2 r/Pi]]];
  fl = FactorList[Denominator[Together[F]]][[All, 1]];
  Do[If[PolynomialQ[q, z] && Exponent[q, z] === 1,
     With[{r = -(q /. z -> 0)/Coefficient[q, z]}, If[Element[r, Rationals] || NumericQ[r], AppendTo[rats, r]]]], {q, fl}];
  DeleteDuplicates[Join[Range[Ceiling[lo], Floor[hi]], If[halfInt, Range[Ceiling[lo - 1/2], Floor[hi - 1/2]] + 1/2, {}],
     Select[rats, lo <= # <= hi &]]]];

(* residue of F at a SPECIFIC pole p (finite; p a rational) *)
mbeTrigResAt[F_, z_, p_] := Module[{w, s}, s = Quiet@Series[F /. z -> p + w, {w, 0, -1}]; Quiet@SeriesCoefficient[s, -1]];

(* symbolic-n residue of F at z = sgn*(n) + p0 for the tower, then Sum over n; sgn = +1 closes to the right tower
   (z = p0 + n, n large), -1 to the left (z = p0 - n).  Returns the closed tail or $Failed. *)
mbeTrigTail[F_, z_, p0_, sgn_, n_, nStart_] := Module[{w, rn, tail},
  rn = Quiet@Check[SeriesCoefficient[Series[F /. z -> sgn (n) + p0 + w, {w, 0, -1}], -1], $Failed];
  If[rn === $Failed, Return[$Failed]];
  rn = Quiet@Simplify[rn];
  tail = Quiet@TimeConstrained[Sum[rn, {n, nStart, Infinity}], 240, $Failed];
  If[tail === $Failed || ! FreeQ[tail, HoldPattern[Sum[__]]], $Failed, Simplify[tail]]];

(* contour quadrature of the ORIGINAL integrand (development gate) *)
mbeTrigQuad[ig_, z_, c_, T_, pg_] := Module[{t}, Quiet@TimeConstrained[
   NIntegrate[(FunctionExpand[ig] /. z -> c + I t)/(2 Pi), {t, -T, T}, WorkingPrecision -> 40, PrecisionGoal -> pg,
     MaxRecursion -> 24, Method -> {"GlobalAdaptive", "MaxErrorIncreases" -> 3000}], 500, $Failed]];

(* decide the closing side: F must decay on the chosen half-plane.  Sample |F(c + i y)| growth is inconclusive for the
   raw reduced form (Cos/Gamma cancellations overflow); instead close on BOTH sides and require the two to agree with
   the quadrature -- the side on which the arc vanishes gives the quadrature, the other does not. *)
Options[mbeTrigKernelClose] = {"Quadrature" -> Automatic, "PoleRange" -> 400};
mbeTrigKernelClose[ig_, ctr_List, vrs_List, OptionsPattern[]] := Module[
  {z = First[vrs], c, F, q, R, poleR, poleL, fracR, fracL, towerR, towerL, valR, valL, nlist, p0R, p0L, serve},
  If[! mbeTrigKernelQ[ig, vrs], Return[$Failed]];
  c = z /. ctr; If[! NumericQ[N[c]], Return[$Failed]];
  F = mbeTrigReduce[ig, z];
  mbeTrigLog["reduced integrand leaf ", LeafCount[F], " on contour z=", N[c, 6]];
  q = OptionValue["Quadrature"]; If[q === Automatic, q = mbeTrigQuad[ig, z, c, 70, 12]];
  If[! NumericQ[q], mbeTrigLog["no quadrature gate available -> fail-closed"]; Return[$Failed]];
  poleR = OptionValue["PoleRange"];
  (* finite poles strictly right / left of c within a window, plus the tower base just past the window *)
  nlist = mbeTrigPoleLattice[F, z, c - poleR, c + poleR];
  fracR = Select[nlist, # > c &]; fracL = Select[nlist, # < c &];
  (* the finite residue sums over the windowed poles (both sides) *)
  valR = -Total[mbeTrigResAt[F, z, #] & /@ fracR];   (* right closure: -sum of residues to the right *)
  valL =  Total[mbeTrigResAt[F, z, #] & /@ fracL];   (*  left closure: +sum of residues to the left *)
  (* if the finite windows already reproduce the quadrature (a genuinely finite pole set), serve *)
  serve[v_, how_] := (mbeTrigLog["value ", v, " (", N[v, 10], ") matches quadrature ", N[q, 10], " via ", how];
     If[Global`bwsExactQ[v, {z}], Global`bwsCanonExact[v], v]);
  If[Global`bwsExactQ[valR, {z}] && Abs[N[valR, 30] - q] < 10^-6 (1 + Abs[q]), Return[serve[valR, "finite right closure"]]];
  If[Global`bwsExactQ[valL, {z}] && Abs[N[valL, 30] - q] < 10^-6 (1 + Abs[q]), Return[serve[valL, "finite left closure"]]];
  (* otherwise a tower: base index just outside the window, add the symbolic tail on each side *)
  p0R = Ceiling[c]; p0L = Floor[c];
  towerR = mbeTrigTail[F, z, 0, +1, Global`nT, Max[1, Ceiling[c + poleR] + 1]];
  towerL = mbeTrigTail[F, z, 0, -1, Global`nT, Max[1, Ceiling[-c + poleR] + 1]];
  If[Global`bwsExactQ[valR, {z}] && towerR =!= $Failed && Abs[N[valR - towerR, 30] - q] < 10^-6 (1 + Abs[q]),
    Return[serve[valR - towerR, "right closure + tower"]]];
  If[Global`bwsExactQ[valL, {z}] && towerL =!= $Failed && Abs[N[valL + towerL, 30] - q] < 10^-6 (1 + Abs[q]),
    Return[serve[valL + towerL, "left closure + tower"]]];
  mbeTrigLog["no closing side reproduced the quadrature (right ", N[Quiet@valR, 6], ", left ", N[Quiet@valL, 6],
     ", quad ", N[q, 6], ") -> fail-closed"];
  $Failed];

WriteString["stdout", "[mbeTrigKernelRung] loaded (trig-kernel one-fold closer; residue sum, quadrature-gated, fail-closed).\n"];
