(* ::Package:: *)
(* AUTHORSHIP (release R2 + rung, 2026-09-08): MBSymbolicInt one-fold tower-closure family rung. Authors of MBSymbolicInt: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)

(* mbeOneFoldTowerRung.m -- ONE-FOLD TOWER-CLOSURE FAMILY ROUTE, generalised (Subtraction route sidecar).

   The sealed core's family handler mbeOneFoldFamilyLaurent (MBSymbolicInt.wl, "ONE-FOLD TOWER CLOSURE ENGINE v2") closes
   every 1-fold residue of an MBresolve list by summing the residues of the RIGHT poles of the integration variable
   (Gamma-front towers -> prefactor x pFq(+-1), finite crossed poles), sums the 0-fold residues, and expands the
   hypergeometric blocks with HypExp.  This rung keeps that engine (mbeOFCDecompose / mbeOFCRightPoles /
   mbeOFCTowerSum / mbeOFCClose are untouched) and replaces the family handler around it:

   1. DIRECTION.  Both closures are tried: RIGHT, and LEFT as the right closure of f(-w) on Re w = -c.  A direction
      whose towers carry a multiple pole is rejected by the engine; among the admissible closures the one whose
      blocks all have non-negative excess at eps = 0 is preferred, then the one with the smaller expansion work.
      (MB7's residue has a double-pole front on the right and closes on the left; MB1 and MB2 close on the right.)
   2. NORMAL FORM of every block: common upper/lower parameters are cancelled, a vanishing upper parameter
      terminates the series, a 2F1(1) is closed by Gauss's theorem; only genuinely transcendental blocks reach HypExp.
   3. DEPTH.  Each block is expanded to depth ordMax - lead(prefactor), the minimal depth that fixes the requested
      orders (the sealed handler used ordMax + 6 for every block; at weight 8 that is the difference between an hour
      and an unfinished run).
   4. PARALLELISM.  Distinct blocks are expanded concurrently on subkernels when the work is large, within the
      resource policy (Global`mbtSubkernelCapDynamic[] if loaded, else Global`$mbtSubkernelCap, else the licence
      allowance and the cores); serial fallback; the kernels are closed afterwards.
   5. MULTI-FOLD RESIDUES.  A residue with 2 or more contours is closed by Global`oftMultiFoldHandler (by default the
      sealed core's per-residue Standard closer, fail-closed on its ledger), so that a family containing such a
      residue (MB4) keeps the tower route for its 0- and 1-fold members.  The family guard of the Subtraction branch
      of MBresolveToMPL is re-targeted to Global`oftFamilyApplicableQ (first occurrence only; the Standard branch is
      not touched).
   6. The MB14 signature path (mbeMB14ResidueListQ -> numeric tuned handlers, capped at eps^-1, returning an atomic
      $Failed that the core then indexed as $Failed[[k]]) is disabled: every served coefficient must be exact.

   Fail-closed: a block HypExp cannot expand, a divergent block, an inexact atom, an unsupported structure or a
   multi-fold residue no handler closes gives MBresolveToMPL::ofcfail and $Failed, and the core continues with its
   Euler boundary-subtraction machinery exactly as before.  Coefficients are canonicalised (Expand + Simplify, 120 s
   cap each) before they are returned. *)

If[! TrueQ[Global`$oftRungInstalled],
Module[{dv, pos, sym, n},

  Global`$oftRungVersion = "2026-09-08";
  If[! ValueQ[Global`$oftHypExpBudget], Global`$oftHypExpBudget = 14400];      (* seconds per block *)
  If[! ValueQ[Global`$oftMultiFoldBudget], Global`$oftMultiFoldBudget = 10800]; (* seconds per multi-fold residue *)
  (* 3 October 2026: no fold limit.  With the limit 2, a family with a residue of three or more folds never reached the
     family route: the core's auto-router decided alone and sent MB5, MB6, MB10, MB11 and MB12 to the Standard route
     (silently).  The general multifold handler (mbeMultifoldHandler.m) closes the multi-fold residues; what it refuses
     goes to the previous chain (faithful cube, the residue's own Barnes reduction), and only a family the route cannot
     close at all reaches the core's router, now with the loud message MBresolveToMPL::substd. *)
  If[! ValueQ[Global`$oftMaxFold], Global`$oftMaxFold = Infinity];
  If[! ValueQ[Global`$oftParallelMinDepth], Global`$oftParallelMinDepth = 5];
  Global`$oftLastRun = <||>;

  (* ---- 0a. exact canonical constants (2026-09-11, MB6 eps^-2: a coefficient equal to the benchmark to 80 digits failed
     the exact test because it carried Li_n(2), Nielsen S_{n,p}(-1) and Log[4]).  Three exact identities:
     (i)  Li_n(x) for real x outside [0,1]: the inversion Li_n(x) + (-1)^n Li_n(1/x) = -(2 pi i)^n/n! B_n(1/2 + ln(-x)/(2 pi i)),
          with ln(-x) = Log[x] + i pi for x > 1 (Mathematica's branch of PolyLog on the cut; checked to 77 digits for
          n = 2..5) and Log[-x] for x < 0;
     (ii) Nielsen S_{n,p}(-1) = PolyLog[n, p, -1] = H(0^n, 1^p; -1) = (-1)^p H(0^n, (-1)^p; 1), which HPL's alternating
          tables reduce to {zeta, Log[2], Li_k(1/2)} (checked to 78 digits at weights 4 and 5);
     (iii) logarithms of positive rationals over their prime factorisation.
     Applied to every served family coefficient (the coefficient stays exact) and used by the driver's exact-zero test. *)
  Global`mbeCanonicalConstants[e_] := Module[{f = e, invLog, inv},
    invLog[x_] := If[x > 1, Log[x] + I Pi, Log[-x]];
    inv[n_, x_] := -(-1)^n PolyLog[n, 1/x] - (2 Pi I)^n/n! BernoulliB[n, 1/2 + invLog[x]/(2 Pi I)];
    f = f /. PolyLog[n_Integer, x_] /; n >= 2 && NumericQ[x] && Im[x] == 0 && (x > 1 || x < -1) :> inv[n, x];
    f = f /. PolyLog[n_Integer, p_Integer, -1] /; n >= 1 && p >= 1 :> Module[{h = (-1)^p HPL`HPL[Join[ConstantArray[0, n], ConstantArray[-1, p]], 1]},
      If[FreeQ[h, HPL`HPL], h, PolyLog[n, p, -1]]];
    f = f /. Log[q_ /; (IntegerQ[q] || Head[q] === Rational) && q > 0] :> Total[(#[[2]] Log[#[[1]]]) & /@ FactorInteger[q]];
    (* 2026-09-11 (slope-two legs): level-2 constants.  (iv) polygammas at rationals -> explicit constants
       (psi(3/2) = 2 - gamma - 2 log 2, psi'(1/2) = pi^2/2, ...); (v) a PolyLogTools G at argument 1 with letters in
       {0, 1, 2} is, by t -> 1 - t, the reversed word with letters 1 - a_i at argument 1, which PolyLogTools reduces
       through its {0, +-1} tables to {zeta, Log[2], Li_k(1/2), ...} (checked numerically at weights 2-4, 30 digits) *)
    f = f /. PolyGamma[m_Integer, r_Rational] :> FunctionExpand[PolyGamma[m, r]];
    (* 2026-10-01 11:0x: a word at 1 with a TRAILING ZERO reflects to a word with the leading letter 1, which is
       divergent at 1 (PolyLogTools then returns the regulator HPL[{1},1]: the exact E of MB8au r43 piece 79 carried
       HPL[{1},1] terms); the trailing zeros are shuffled out first (G(0;1) = log 1 = 0), then the convergent words reflect *)
    (* 2026-10-01 11:5x: every word at 1 with a trailing zero (any numeric letters) is shuffled first; then a word
       G(0^(n-1), a; 1) with a numeric letter a outside {0, 1} is the classical polylogarithm -Li_n(1/a) (the folded last
       fold of the two-fold closer leaves such words with the letters +-3) *)
    f = f /. g_PolyLogTools`G /; (Last[List @@ g] === 1 && Length[List @@ g] >= 3 && AllTrue[Most[List @@ g], NumericQ] &&
        Last[Most[List @@ g]] === 0 && !MatchQ[Most[List @@ g], {0 ..}]) :> Expand[PolyLogTools`ExtractZeroes[g]];
    f = f /. g_PolyLogTools`G /; (Last[List @@ g] === 1 && MatchQ[Most[List @@ g], {0 ..., a_?NumericQ} /; a =!= 0 && a =!= 1]) :>
      With[{n = Length[Most[List @@ g]], a = Last[Most[List @@ g]]}, If[n == 1, Log[1 - 1/a], -PolyLog[n, 1/a]]];
    (* the reflection carries the sign (-1)^n (t -> 1 - t reverses every integration): G(2;1) = -log 2 = -G(-1;1); the
       September rule without the sign was checked on even weights only -- the odd-weight words of piece 79's E exposed it *)
    f = f /. g_PolyLogTools`G /; (Last[List @@ g] === 1 && SubsetQ[{0, 1, 2}, Most[List @@ g]] && MemberQ[Most[List @@ g], 2] &&
        Last[Most[List @@ g]] =!= 0 && First[Most[List @@ g]] =!= 1) :>
      ((-1)^Length[Most[List @@ g]] (PolyLogTools`G @@ Append[Reverse[1 - Most[List @@ g]], 1]));
    (* 2026-10-01 (vi): a G word at a NUMERIC argument other than 1 (the half-integer unit tower leaves
       G(0; 2) = log 2): weight one explicitly, higher weights through PolyLogTools' GToHPL when the result is free of
       G and HPL heads (the HPL package then reduces its alternating constants) *)
    f = f /. h_Symbol[a__] /; SymbolName[Unevaluated[h]] === "G" && Context[h] =!= "PolyLogTools`" && Context[h] =!= "System`" :> PolyLogTools`G[a];
    (* HoldPattern: once the HPL/HypExp tables are loaded, PolyLogTools`G carries DownValues that rewrite a bare pattern
       G[0, c_?NumericQ] on construction (the evaluating-pattern trap: the rule then never matches) *)
    f = f /. {HoldPattern[PolyLogTools`G[0, c_?NumericQ]] /; c =!= 1 && c =!= 0 :> Log[c],
      HoldPattern[PolyLogTools`G[a_?NumericQ, c_?NumericQ]] /; a =!= 0 && c =!= 1 && a =!= c :> Log[1 - c/a]};
    f = f /. g : HoldPattern[PolyLogTools`G[__, c_?NumericQ]] /; c =!= 1 :> With[{h = Quiet@PolyLogTools`GToHPL[g]}, If[FreeQ[h, PolyLogTools`G | HPL`HPL], h, g]];
    f = f /. Log[q_ /; (IntegerQ[q] || Head[q] === Rational) && q > 0] :> Total[(#[[2]] Log[#[[1]]]) & /@ FactorInteger[q]];
    f];

  (* ---- 0. provenance ---- *)
  If[DownValues[Global`oftOrigOneFoldFamily] === {} && DownValues[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent] =!= {},
    DownValues[Global`oftOrigOneFoldFamily] = DownValues[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent] /.
      HoldPattern[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent] -> Global`oftOrigOneFoldFamily];
  If[DownValues[Global`oftOrigMB14ListQ] === {} && DownValues[MBAnalytica`SymbolicInt`Private`mbeMB14ResidueListQ] =!= {},
    DownValues[Global`oftOrigMB14ListQ] = DownValues[MBAnalytica`SymbolicInt`Private`mbeMB14ResidueListQ] /.
      HoldPattern[MBAnalytica`SymbolicInt`Private`mbeMB14ResidueListQ] -> Global`oftOrigMB14ListQ];

  (* ---- 1. the engine's failure exit: recorded, silent ---- *)
  Global`$oftLastOFCReason = "";
  MBAnalytica`SymbolicInt`Private`mbeOFC$fail[msg_] := (Global`$oftLastOFCReason = ToString[msg]; Throw[$Failed, MBAnalytica`SymbolicInt`Private`mbeOFC$tag]);

  (* ---- 2. helpers ---- *)
  (* leading eps-order of an expression up to ordMax (Infinity = no term up to ordMax) *)
  Global`oftLeadOrder[x_, eps_, ordMax_] := Module[{s = Quiet@Series[x, {eps, 0, ordMax + 1}]},
    Which[
      Head[s] === SeriesData && s[[3]] =!= {}, s[[4]]/s[[6]],
      Head[s] === SeriesData, Infinity,
      TrueQ[Quiet@PossibleZeroQ[x]], Infinity,
      True, 0]];

  (* normal form of a unit-argument block *)
  Global`oftNormalizePFQ[num_List, den_List, arg_] := Module[{nu = num, de = den, common},
    common = Intersection[nu, de];
    Do[While[MemberQ[nu, c] && MemberQ[de, c], nu = DeleteCases[nu, c, 1, 1]; de = DeleteCases[de, c, 1, 1]], {c, common}];
    Which[
      MemberQ[nu, 0], 1,
      Length[nu] === 0 && Length[de] === 0, E^arg,
      Length[nu] === 2 && Length[de] === 1 && arg === 1,
        With[{a = nu[[1]], b = nu[[2]], c = de[[1]]}, Gamma[c] Gamma[c - a - b]/(Gamma[c - a] Gamma[c - b])],
      True, HypergeometricPFQ[nu, de, arg]]];

  (* score one closure: blocks (pFq, depth, prefactor), the exact remainder, admissibility *)
  Global`oftScoreClosure[cl_Association, dir_String, eps_, ordMax_] := Module[
    {blocks = {}, others = 0, rank = 0, work = 0, bad = False, reason = ""},
    Do[
      If[p["Type"] === "Tower",
        Module[{d = p["Data"], F, pfqs, pref, rest, cq, lead, exc0, thr, dep},
          pref = d["Pref"];
          (* the normal form may be auto-evaluated by Mathematica (contiguous relations) into an expression that is
             LINEAR in other pFq's with rational prefactors carrying eps-poles: every inner pFq q becomes a block with
             the full prefactor pref*Coefficient[F,q], whose leading order fixes the depth; the pFq-free remainder
             of F is exact *)
          F = Global`oftNormalizePFQ[d["Num"], d["Den"], d["Arg"]];
          If[! FreeQ[pref F, Indeterminate | ComplexInfinity | _DirectedInfinity],
            bad = True; reason = "non-finite unit-argument tower normal form"; Continue[]];
          pfqs = DeleteDuplicates[Cases[F, _HypergeometricPFQ, {0, Infinity}]];
          If[pfqs === {},
            others += pref F,
            rest = F /. Thread[pfqs -> 0];
            If[! FreeQ[rest, HypergeometricPFQ], bad = True; reason = "non-linear hypergeometric normal form"];
            others += pref rest;
            Do[
              cq = Coefficient[F, q];
              If[! FreeQ[cq, HypergeometricPFQ], bad = True; reason = "non-linear hypergeometric normal form"];
              lead = Global`oftLeadOrder[pref cq, eps, ordMax];
              If[lead =!= Infinity,
                exc0 = Simplify[(Total[q[[2]]] - Total[q[[1]]]) /. eps -> 0];
                thr = If[q[[3]] === 1, 0, -1];
                Which[
                  ! NumericQ[exc0], bad = True; reason = "non-numeric excess",
                  exc0 < thr, bad = True; reason = "divergent block (excess " <> ToString[exc0] <> " at eps=0)",
                  (* a block AT the threshold is admissible only when the regulator moves the excess off it; an excess
                     that is exactly the threshold for every eps is a divergent series (2026-09-11, MB6: the family's
                     assembly failed at the end on 3F2({1, -2eps, 1+3eps}; {1-eps, 1+2eps}; 1), HypExp "not convergent") *)
                  exc0 == thr && TrueQ[PossibleZeroQ[Simplify[Coefficient[Expand[Total[q[[2]]] - Total[q[[1]]]], eps]]]],
                    bad = True; reason = "marginal block without regulator (excess exactly " <> ToString[thr] <> ")",
                  exc0 == thr, rank = Max[rank, 1]];
                dep = ordMax - lead;
                work += (Length[q[[1]]] + Length[q[[2]]]) dep^2;
                AppendTo[blocks, <|"PFQ" -> q, "Depth" -> dep, "Pref" -> pref cq|>]],
              {q, pfqs}]]],
        others += p["Data"]],
      {p, cl["Parts"]}];
    If[bad, Return[<|"Rejected" -> True, "Direction" -> dir, "Reason" -> reason|>]];
    <|"Rejected" -> False, "Direction" -> dir, "Blocks" -> blocks, "Others" -> others, "Rank" -> rank, "Work" -> work,
      "Parts" -> Length[cl["Parts"]]|>];

  (* close one 1-fold residue: try both directions, take the best admissible closure *)
  (* 2026-09-11: legs of slope +-2 (Gamma(c +- 2 var), residue-induced) are split by Legendre's duplication formula
     Gamma(l) = 2^(l-1) Gamma(l/2) Gamma((l+1)/2) / Sqrt(Pi) before the closure; the 2^(+-2 var) factors cancel between
     balanced legs (otherwise the engine's phase test refuses, fail-closed).  The towers then carry half-integer
     parameters, which HypExp expands. *)
  Global`oftSlope2Q[f_, var_] := ! FreeQ[f, Gamma[l_] /; PolynomialQ[l, var] && Abs[Coefficient[l, var, 1]] == 2];
  Global`oftDuplicate[f_, var_] := f /. Gamma[l_] /; (PolynomialQ[l, var] && Abs[Coefficient[l, var, 1]] == 2) :>
      2^(l - 1)/Sqrt[Pi] Gamma[l/2] Gamma[(l + 1)/2];
  Global`oftCloseOne[intg0_, var_, eps_, c_, eN_, ordMax_] := Module[{clR, clL, rR, rL, wL, cands, rej, intg},
    intg = If[! TrueQ[Global`$oftNoDuplication] && Global`oftSlope2Q[intg0, var], Global`oftDuplicate[intg0, var], intg0];
    Global`$oftLastOFCReason = "";
    clR = Catch[MBAnalytica`SymbolicInt`Private`mbeOFCClose[intg, var, eps, c, eN], MBAnalytica`SymbolicInt`Private`mbeOFC$tag];
    rR = Global`$oftLastOFCReason;
    wL = Unique["Global`oftw"];
    Global`$oftLastOFCReason = "";
    clL = Catch[MBAnalytica`SymbolicInt`Private`mbeOFCClose[intg /. var -> -wL, wL, eps, -c, eN], MBAnalytica`SymbolicInt`Private`mbeOFC$tag];
    rL = Global`$oftLastOFCReason;
    cands = {};
    If[AssociationQ[clR], AppendTo[cands, Global`oftScoreClosure[clR, "RIGHT", eps, ordMax]], rR = If[rR === "", "engine failure", rR]];
    If[AssociationQ[clL], AppendTo[cands, Global`oftScoreClosure[clL, "LEFT", eps, ordMax]], rL = If[rL === "", "engine failure", rL]];
    rej = Select[cands, TrueQ[#["Rejected"]] &];
    Do[If[r["Direction"] === "RIGHT", rR = r["Reason"], rL = r["Reason"]], {r, rej}];
    cands = Select[cands, ! TrueQ[#["Rejected"]] &];
    If[cands === {}, Return[<|"Failed" -> True, "Reason" -> "RIGHT: " <> rR <> " | LEFT: " <> rL|>]];
    Append[First[SortBy[cands, {#["Rank"], #["Work"], #["Parts"]} &]], "Failed" -> False]];

  (* subkernels this expansion may use *)
  Global`oftSubkernelAllowance[nJobs_Integer] := Module[{cap},
    cap = Which[
      TrueQ[Global`$oftNoSubkernels], 0,
      DownValues[Global`mbtSubkernelCapDynamic] =!= {}, Global`mbtSubkernelCapDynamic[],
      IntegerQ[Global`$mbtSubkernelCap], Global`$mbtSubkernelCap,
      True, Min[Which[IntegerQ[$MaxLicenseSubprocesses], $MaxLicenseSubprocesses, $MaxLicenseSubprocesses === Infinity, Infinity, True, 0],
        Max[1, $ProcessorCount - 1]]];
    Max[0, Min[nJobs, cap]]];

  (* HypExp of distinct blocks on subkernels; $Failed -> the caller falls back to serial *)
  Global`oftParallelHypExp[jobs_List, eps_, nW_Integer, verbose_] := Module[{have, ks, cfg, ok, res, t0 = AbsoluteTime[]},
    cfg = If[StringQ[Global`$MBStandardDir], FileNameJoin[{Global`$MBStandardDir, "configure_runtime.m"}], ""];
    If[cfg === "" || ! FileExistsQ[cfg], Return[$Failed]];
    have = Length[Kernels[]];
    If[have < nW, Quiet@Check[LaunchKernels[nW - have], Null]];
    ks = Kernels[];
    If[Length[ks] < 2, Return[$Failed]];
    (* 2026-10-02: the subkernels get the switch guard as well (mbeFlagGuard.m): a block stopped by its budget inside
       HypExp left the HPL switches changed for the next block of the same subkernel *)
    With[{cfgF = cfg, fgF = FileNameJoin[{Global`$MBStandardDir, "mbeFlagGuard.m"}]},
      ok = Quiet@ParallelEvaluate[
        If[! MemberQ[$Packages, "HypExp`"],
          Off[General::shdw]; Quiet@Get[cfgF]; Quiet@Needs["HPL`"]; Quiet@Needs["HypExp`"]];
        If[! TrueQ[Global`$mbeFlagGuardInstalled] && FileExistsQ[fgF],
          Global`$mbeFlagGuardQuiet = True; Quiet@Get[fgF]];
        MemberQ[$Packages, "HypExp`"], ks]];
    If[! (ListQ[ok] && AllTrue[ok, TrueQ]),
      If[verbose, Print["  HypExp: the subkernels could not load HypExp -> serial expansion"]];
      Return[$Failed]];
    If[verbose, Print["  HypExp: ", Length[jobs], " block(s) on ", Length[ks], " subkernel(s) (", Round[AbsoluteTime[] - t0], " s to prepare)"]];
    res = With[{bud = Global`$oftHypExpBudget, ep = eps},
      Quiet@ParallelMap[
        Function[j, {j[[1]], AbsoluteTiming[TimeConstrained[HypExp`HypExp[j[[1]], ep, j[[2]]], bud, $Failed]]}],
        jobs, Method -> "FinestGrained"]];
    Quiet@CloseKernels[];
    If[! ListQ[res] || Length[res] =!= Length[jobs], Return[$Failed]];
    Association @ Map[(#[[1]] -> <|"Seconds" -> #[[2, 1]], "Expansion" -> #[[2, 2]]|>) &, res]];

  Global`oftExpandBlocks[blocks_List, eps_, verbose_] := Module[{need, jobs, res, nW, useSub, t0 = AbsoluteTime[], bad},
    If[blocks === {}, Return[<||>]];
    MBAnalytica`SymbolicInt`Private`mbeEnsureHypExp[];
    need = Merge[Table[Association[b["PFQ"] -> b["Depth"]], {b, blocks}], Max];
    jobs = Table[{k, need[k]}, {k, Keys[need]}];
    If[verbose, Print["  HypExp: ", Length[jobs], " distinct block(s); depths ", Values[need]]];
    nW = Global`oftSubkernelAllowance[Length[jobs]];
    useSub = Length[jobs] >= 2 && nW >= 2 && Max[Values[need]] >= Global`$oftParallelMinDepth;
    res = If[useSub, Global`oftParallelHypExp[jobs, eps, nW, verbose], $Failed];
    If[res === $Failed,
      res = Association @ Table[
        j[[1]] -> If[DownValues[Global`hbbExpand] =!= {},
          Global`hbbExpand[j[[1]], eps, j[[2]], Global`$oftHypExpBudget],
          Module[{tt = AbsoluteTiming[Quiet@TimeConstrained[HypExp`HypExp[j[[1]], eps, j[[2]]], Global`$oftHypExpBudget, $Failed]]},
            <|"Seconds" -> tt[[1]], "Expansion" -> tt[[2]]|>]], {j, jobs}]];
    bad = Select[Keys[res], (res[#]["Expansion"] === $Failed || res[#]["Expansion"] === $Aborted ||
       ! FreeQ[res[#]["Expansion"], HypergeometricPFQ | HypExp`HypExp]) &];
    Global`$oftLastRun["Blocks"] = Table[<|"PFQ" -> k, "Depth" -> need[k], "Seconds" -> res[k]["Seconds"],
       "Expanded" -> ! MemberQ[bad, k]|>, {k, Keys[res]}];
    If[bad =!= {},
      If[verbose, Print["  HypExp: block(s) NOT expanded: ", InputForm /@ bad]];
      Return[$Failed]];
    If[verbose, Print["  HypExp: all blocks expanded in ", Round[AbsoluteTime[] - t0], " s"]];
    Association @ Table[k -> res[k]["Expansion"], {k, Keys[res]}]];

  (* the default multi-fold handler: the residue's own Barnes reduction (MBexpand + DoAllBarnes) and the sealed
     core's ledger-aware piece closer, run through the parallel piece workers exactly as the Standard route's
     corner-free branch does (the per-residue mbtLocalStdRoute closes serially and carries a numeric "hung-pieces
     correction", neither of which is acceptable here).  Fail-closed on the ledger: a residue with any refused piece
     is not served. *)
  Global`oftMultiFoldHandler[term_, eps_, ordMin_, ordMax_, verbose_] := Module[
    {n0, t0 = AbsoluteTime[], doAB, exp2, barnes2, mbConst, mbConstVal, mbList, integ, ctrs, vrs, epsFac, integ1,
     mbEva, total, out, pk, fcu, sbr, mfr},
    If[DownValues[Global`mfrResidueLaurent] =!= {} && !TrueQ[Global`$mfrDisabled],
      mfr = Global`mfrResidueLaurent[term, eps, ordMin, ordMax, verbose];
      If[ListQ[mfr] && Length[mfr] === ordMax-ordMin+1 && FreeQ[mfr,$Failed],
        If[verbose, Print["    multi-fold residue closed after certified finite-regulator Barnes chain"]]; Return[mfr]]];
    If[DownValues[Global`sbrResidueLaurent] =!= {} && ! TrueQ[Global`$oftNoSymbolicBarnes],
      sbr = Global`sbrResidueLaurent[term, eps, ordMin, ordMax, verbose];
      If[ListQ[sbr] && Length[sbr] === ordMax - ordMin + 1 && FreeQ[sbr, $Failed],
        If[verbose, Print["    multi-fold residue closed by epsilon-symbolic Barnes reduction"]]; Return[sbr]]];
    (* 2026-09-09: the FAITHFUL CUBE of the residue (mbeFaithfulCubeRung.m) comes first: one Euler cube by
       Barnes-kernel inversion, its eps-coefficients integrated exactly on subkernels; only if that fails closed
       does the residue go to its own Barnes reduction and the piece workers below *)
    If[DownValues[Global`fcuResidueLaurent] =!= {},
      fcu = Global`fcuResidueLaurent[term, eps, ordMin, ordMax, verbose];
      If[ListQ[fcu] && Length[fcu] === ordMax - ordMin + 1 && FreeQ[fcu, $Failed],
        If[verbose, Print["    multi-fold residue closed by the faithful cube in ", Round[AbsoluteTime[] - t0], " s"]];
        Return[fcu],
        If[verbose, Print[If[TrueQ[Global`$oftSubtractionOnly],
          "    faithful cube did not close this residue", "    faithful cube not available for this residue -> Barnes reduction + piece workers"]]]]];
    If[TrueQ[Global`$oftSubtractionOnly], Return[$Failed]];
    n0 = Length[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces];
    doAB = Which[
      DownValues[BarnesRoutines`DoAllBarnes] =!= {}, BarnesRoutines`DoAllBarnes,
      DownValues[Global`DoAllBarnes] =!= {}, Global`DoAllBarnes,
      True, None];
    If[doAB === None, Return[$Failed]];
    exp2 = Quiet@Symbol["MB`MBexpand"][{term}, 1, {eps, 0, ordMax}];
    If[! ListQ[exp2], Return[$Failed]];
    barnes2 = Quiet@TimeConstrained[doAB[exp2, True], Global`$oftMultiFoldBudget, $Failed];
    If[! ListQ[barnes2], If[verbose, Print["    multi-fold residue: Barnes reduction failed"]]; Return[$Failed]];
    mbConst = Symbol["MB`MBmerge"][Select[barnes2, (#[[2, 2]] == {}) &]];
    mbConstVal = If[Length[mbConst] > 0, mbConst[[1, 1]] // ExpandAll, 0];
    mbList = Select[barnes2, (#[[2, 2]] =!= {}) &];
    integ = #[[1]] & /@ mbList; ctrs = #[[2, 2]] & /@ mbList; vrs = Keys /@ ctrs;
    epsFac = #/(# /. {eps -> 1}) & /@ integ;
    integ1 = integ /. {eps -> 1};
    If[verbose, Print["    multi-fold residue: Barnes reduction -> ", Length[mbList], " piece(s) + empty part (",
      Round[AbsoluteTime[] - t0], " s)"]];
    pk = Which[
      IntegerQ[MBAnalytica`SymbolicInt`Private`$mbtPieceKernels] && MBAnalytica`SymbolicInt`Private`$mbtPieceKernels > 0, MBAnalytica`SymbolicInt`Private`$mbtPieceKernels,
      IntegerQ[Global`$mbtDefaultPieceKernels], Global`$mbtDefaultPieceKernels,
      True, 100];
    If[DownValues[Global`mbtSubkernelCapDynamic] =!= {}, Global`$mbtSubkernelCap = Global`mbtSubkernelCapDynamic[]];
    mbEva = If[Length[integ1] == 0, {},
      If[DownValues[MBAnalytica`SymbolicInt`Private`mbtClosePiecesParallel] === {},
        Table[MBAnalytica`SymbolicInt`Private`mbtCachedMBSymbolicInt[integ1[[i]], ctrs[[i]], vrs[[i]]], {i, Length[integ1]}],
        MBAnalytica`SymbolicInt`Private`mbtClosePiecesParallel[integ1, ctrs, vrs, epsFac, pk]]];
    (* 2026-10-01: every ONE-fold engine value is gated by the contour quadrature of its piece (relative
       1e-8).  MB8au residue 43, piece 34: the engine's contour-shift recovery served -Res(z=-1) as a clean exact value
       on this path, which had no gate of its own.  A numeric mismatch refuses the residue; an inconclusive quadrature
       leaves the piece to the ledger rules and the caller's term gates. *)
    Module[{bad = {}},
      Do[If[Length[vrs[[i]]] == 1 && FreeQ[mbEva[[i]], $Failed | $TimedOut | Indeterminate | ComplexInfinity | DirectedInfinity | _MBint] &&
           NumericQ[Quiet @ N[mbEva[[i]], 20]],
          Module[{z = vrs[[i, 1]], c = z /. ctrs[[i]], tq, q},
            q = Quiet @ TimeConstrained[
              NIntegrate[Evaluate[(integ1[[i]] /. z -> c + I tq)/(2 Pi)], {tq, -60, 60}, WorkingPrecision -> 25,
                PrecisionGoal -> 10, MaxRecursion -> 30], 300, $TimedOut];
            If[NumericQ[q] && ! TrueQ[Abs[N[mbEva[[i]], 30] - q] < 10^-8 Max[1, Abs[q]]],
              AppendTo[bad, {i, N[mbEva[[i]], 12], N[q, 12]}]]]], {i, Length[mbEva]}];
      If[bad =!= {},
        If[verbose, Print["    multi-fold residue: ", Length[bad], " one-fold engine value(s) REFUSED by the contour quadrature ",
          "(piece, value, quadrature): ", bad]];
        Return[$Failed]]];
    total = mbConstVal + If[mbEva === {}, 0, mbEva . epsFac];
    out = Table[Coefficient[Quiet@Normal@Series[total, {eps, 0, ordMax}], eps, k], {k, ordMin, ordMax}];
    If[verbose, Print["    multi-fold residue closed in ", Round[AbsoluteTime[] - t0], " s; new ledger entries ",
      Length[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces] - n0]];
    If[Length[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces] > n0 || ! ListQ[out] ||
       ! FreeQ[out, $Failed | $TimedOut | Indeterminate | ComplexInfinity | DirectedInfinity], Return[$Failed]];
    out];

  Global`oftFamilyApplicableQ[resList_List] := AllTrue[resList, Length[#[[2, 2]]] <= 1 &] ||
    (DownValues[Global`oftMultiFoldHandler] =!= {} && AllTrue[resList, Length[#[[2, 2]]] <= Global`$oftMaxFold &]);

  (* ---- 3. the family handler (memoised on {resList, eps, orders}: the auto-router wrapper below runs it first,
          the family guard of the core then finds the result without recomputing) ---- *)
  Global`$oftFamilyCacheKey = None; Global`$oftFamilyCacheValue = $Failed;
  MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[resList_, eps_, ordMin_, ordMax_, verbose_] := Module[
    {eN = eps -> -1/100, exact0 = 0, blocks = {}, others = 0, rangeLen = ordMax - ordMin + 1, multi, exp, ser, out,
     t0 = AbsoluteTime[], log = {}, key, result, members},
    key = Hash[{resList, eps, ordMin, ordMax}];
    If[Global`$oftFamilyCacheKey === key, Return[Global`$oftFamilyCacheValue]];
    members = If[DownValues[Global`mfrSameContourCensus] =!= {} && !TrueQ[Global`$mfrDisabled],
      Global`mfrSameContourCensus[resList], resList];
    multi = ConstantArray[0, rangeLen];
    Global`$oftLastRun = <|"OrderRange" -> {ordMin, ordMax}, "Residues" -> {}|>;
    result = Catch[
      Do[Module[{intg = members[[i, 1]], ctr = members[[i, 2, 2]], var, c, cl, m},
        Which[
          ctr === {},
            exact0 += intg;
            AppendTo[log, <|"Residue" -> i, "Fold" -> 0|>],
          Length[ctr] === 1,
            var = Keys[ctr][[1]]; c = Rationalize[ctr[[1, 2]], 0];
            cl = Global`oftCloseOne[intg, var, eps, c, eN, ordMax];
            If[TrueQ[cl["Failed"]],
              m = If[DownValues[Global`sgbResidueLaurent] =!= {} && ! TrueQ[Global`$oftNoGaussBarnes],
                Global`sgbResidueLaurent[members[[i]], eps, ordMin, ordMax, verbose], $Failed];
              If[ListQ[m] && Length[m] === rangeLen && FreeQ[m, $Failed | $TimedOut],
                multi += m;
                AppendTo[log, <|"Residue" -> i, "Fold" -> 1, "Handler" -> "Gauss-Barnes",
                  "TowerRefused" -> cl["Reason"]|>];
                If[verbose, Print["  Res#", i, ": closed by the convergent Gauss-Barnes rung"]]; Continue[]];
              m = If[DownValues[Global`sgcResidueLaurent] =!= {} && ! TrueQ[Global`$oftNoGaussBarnesContinuation],
                Global`sgcResidueLaurent[members[[i]], eps, ordMin, ordMax, verbose], $Failed];
              If[ListQ[m] && Length[m] === rangeLen && FreeQ[m, $Failed | $TimedOut],
                multi += m;
                AppendTo[log, <|"Residue" -> i, "Fold" -> 1, "Handler" -> "Gauss-Barnes continuation",
                  "TowerRefused" -> cl["Reason"]|>];
                If[verbose, Print["  Res#", i, ": closed by Gauss-Barnes with explicit contour residues"]]; Continue[]];
              m = If[DownValues[Global`oftAbelClose] =!= {} && ! TrueQ[Global`$oftNoAbelTower],
                Global`oftAbelClose[members[[i]], eps, ordMin, ordMax, verbose], $Failed];
              If[ListQ[m] && Length[m] === rangeLen && FreeQ[m, $Failed | $TimedOut],
                multi += m;
                AppendTo[log, <|"Residue" -> i, "Fold" -> 1, "Handler" -> "Abel tower", "TowerRefused" -> cl["Reason"]|>];
                If[verbose, Print["  Res#", i, ": closed by the Abel tower rung"]]; Continue[]];
              (* 2026-09-11: a DRESSED one-fold residue (polygammas or rationals in the MB variable, or a multiple-pole
                 tower) whose Gamma-part towers are admissible is closed by the regulated tower rung
                 (mbeRegulatedTowerRung.m) -- exact, no Euler variable per dressing factor *)
              m = If[DownValues[Global`oftRegulatedClose] =!= {} && ! TrueQ[Global`$oftNoRegulatedTower],
                Global`oftRegulatedClose[members[[i]], eps, ordMin, ordMax, verbose], $Failed];
              If[ListQ[m] && Length[m] === rangeLen && FreeQ[m, $Failed | $TimedOut],
                multi += m;
                AppendTo[log, <|"Residue" -> i, "Fold" -> 1, "Handler" -> "regulated tower", "TowerRefused" -> cl["Reason"]|>];
                If[verbose, Print["  Res#", i, ": one-fold tower closure refused (", cl["Reason"],
                  ") -> closed by the regulated tower rung"]];
                Continue[]];
              (* 2026-09-10 (campaign, MB3): a one-fold residue whose tower closure is refused in both directions
                 (a block divergent at eps = 0: the arc condition fails for a net-growing kernel) is closed by the
                 arc-free faithful cube, exactly like a multi-fold residue -- the subtraction paper's prescription for
                 net-growing kernels.  MB3's residue 1 (excess -1 in both directions) closes this way in 100 s. *)
              m = If[DownValues[Global`oftMultiFoldHandler] =!= {},
                Global`oftMultiFoldHandler[members[[i]], eps, ordMin, ordMax, verbose], $Failed];
              If[ListQ[m] && Length[m] === rangeLen && FreeQ[m, $Failed | $TimedOut],
                multi += m;
                AppendTo[log, <|"Residue" -> i, "Fold" -> 1, "Handler" -> "faithful cube", "TowerRefused" -> cl["Reason"]|>];
                If[verbose, Print["  Res#", i, ": one-fold tower closure refused (", cl["Reason"],
                  ") -> closed by the faithful cube"]],
                If[verbose, Print["  Res#", i, ": one-fold tower closure impossible (", cl["Reason"],
                  ") and the faithful cube did not close it"]];
                Global`$oftLastRun["Residues"] = Append[log, <|"Residue" -> i, "Fold" -> 1, "Failed" -> cl["Reason"]|>];
                Message[MBresolveToMPL::ofcfail, i]; Throw[$Failed, Global`oftTag]],
              blocks = Join[blocks, cl["Blocks"]]; others += cl["Others"];
              AppendTo[log, <|"Residue" -> i, "Fold" -> 1, "Direction" -> cl["Direction"], "Parts" -> cl["Parts"],
                "Blocks" -> Length[cl["Blocks"]], "Depths" -> cl["Blocks"][[All, "Depth"]], "Marginal" -> cl["Rank"] > 0|>];
              If[verbose, Print["  Res#", i, ": one-fold tower closure ", cl["Direction"], " (", cl["Parts"], " parts; ",
                Length[cl["Blocks"]], " transcendental block(s), depths ", cl["Blocks"][[All, "Depth"]],
                If[cl["Rank"] > 0, "; eps-regulated marginal excess", ""], ")"]]],
          True,
            m = If[DownValues[Global`oftMultiFoldHandler] =!= {},
              Global`oftMultiFoldHandler[members[[i]], eps, ordMin, ordMax, verbose], $Failed];
            If[! (ListQ[m] && Length[m] === rangeLen && FreeQ[m, $Failed | $TimedOut]),
              If[verbose, Print["  Res#", i, ": ", Length[ctr], "-fold residue: no exact handler succeeded"]];
              Global`$oftLastRun["Residues"] = Append[log, <|"Residue" -> i, "Fold" -> Length[ctr], "Failed" -> "multi-fold handler"|>];
              Message[MBresolveToMPL::ofcfail, i]; Throw[$Failed, Global`oftTag]];
            multi += m;
            AppendTo[log, <|"Residue" -> i, "Fold" -> Length[ctr], "Handler" -> "multi-fold"|>];
            If[verbose, Print["  Res#", i, ": ", Length[ctr], "-fold residue closed by the multi-fold handler"]]]],
        {i, Length[members]}];
      Global`$oftLastRun["Residues"] = log;
      exp = Global`oftExpandBlocks[blocks, eps, verbose];
      If[exp === $Failed, Message[MBresolveToMPL::ofcfail, 0]; Throw[$Failed, Global`oftTag]];
      If[! FreeQ[exact0 + others, HypergeometricPFQ] || ! FreeQ[Table[b["PFQ"] /. exp, {b, blocks}], HypergeometricPFQ],
        If[verbose, Print["  tower family: a hypergeometric block survived the expansion -> refused"]];
        Message[MBresolveToMPL::ofcfail, 0]; Throw[$Failed, Global`oftTag]];
      ser = Quiet@Series[exact0 + others, {eps, 0, ordMax}];
      Do[ser += Quiet@Series[b["Pref"] (b["PFQ"] /. exp), {eps, 0, ordMax}], {b, blocks}];
      (* A family closed entirely by cubes/regulated towers has ser == 0; SeriesCoefficient[0,k] is not
         a coefficient.  Read plain constants/polynomials by Coefficient, as in the faithful-cube rung. *)
      out = Table[If[Head[ser] === SeriesData, SeriesCoefficient[ser, k],
          Coefficient[Expand[ser], eps, k]], {k, ordMin, ordMax}] + multi;
      If[! FreeQ[out, Indeterminate | ComplexInfinity | DirectedInfinity | $Failed | SeriesCoefficient | HypergeometricPFQ | HypExp`HypExp],
        If[verbose, Print["  tower family: assembly is not a clean Laurent expansion"]];
        Message[MBresolveToMPL::ofcfail, -1]; Throw[$Failed, Global`oftTag]];
      out = Table[Module[{cc = out[[j]], sc},
          (* canonical constants first (exact), then the expansion: a 971k-leaf MB6 coefficient collapses this way *)
          cc = Quiet@Check[Expand[Global`mbeCanonicalConstants[cc]], cc];
          sc = If[LeafCount[cc] < 300000, Quiet@TimeConstrained[Simplify[Expand[cc]], 120, Expand[cc]], cc];
          sc], {j, rangeLen}];
      If[! MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[out],
        If[verbose, Print["  tower family: an inexact number appeared in a coefficient -> refused"]];
        Message[MBresolveToMPL::ofcfail, -2]; Throw[$Failed, Global`oftTag]];
      Global`$oftLastRun["Seconds"] = AbsoluteTime[] - t0;
      If[verbose, Print["  tower family route done in ", Round[AbsoluteTime[] - t0], " s"]];
      out, Global`oftTag];
    Global`$oftFamilyCacheKey = key; Global`$oftFamilyCacheValue = result;
    result];

  (* the auto-router wrapper: for an applicable family the tower route is attempted FIRST; only if it fails is the
     sealed core's routing predicate consulted (Standard for a nested compound corner, Euler subtraction otherwise) *)
  (* 3 October 2026: a Subtraction request that ends on the Standard route says so (it used to be silent with verbose off) *)
  MBAnalytica`SymbolicInt`MBresolveToMPL::substd = "Route -> \"Subtraction\": `1`; the WHOLE integral is evaluated on the STANDARD route.";
  Global`oftNeedStandardQ[resList_List, eps_, ordMin_, ordMax_, verbose_] := Module[{fam, std},
    If[! Global`oftFamilyApplicableQ[resList],
      std = MBAnalytica`SymbolicInt`Private`mbtRpNeedsStandardQ[resList, eps];
      If[TrueQ[std], Message[MBAnalytica`SymbolicInt`MBresolveToMPL::substd, "the family route does not apply to this residue list"]];
      Return[std]];
    Global`$oftFamilyCacheKey = None;
    fam = MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[resList, eps, ordMin, ordMax, verbose];
    If[fam =!= $Failed, False,
      std = MBAnalytica`SymbolicInt`Private`mbtRpNeedsStandardQ[resList, eps];
      If[TrueQ[std], Message[MBAnalytica`SymbolicInt`MBresolveToMPL::substd, "the Subtraction family route did not close this integral (see the ofcfail messages)"]];
      std]];

  (* ---- 4. the MB14 signature path is disabled (numeric handlers, eps^-1 cap, atomic $Failed) ---- *)
  ClearAll[MBAnalytica`SymbolicInt`Private`mbeMB14ResidueListQ];
  MBAnalytica`SymbolicInt`Private`mbeMB14ResidueListQ[___] := False;

  (* ---- 5. re-target the family guard of the Subtraction branch (first occurrence only) ---- *)
  dv = DownValues[MBAnalytica`SymbolicInt`MBresolveToMPL];
  pos = Position[dv, HoldPattern[AllTrue[_Symbol, Function[Length[Part[Slot[1], 2, 2]] <= 1]]]];
  n = Length[pos];
  If[n >= 1,
    sym = Extract[dv, First[pos], Hold][[1, 1]];
    dv = ReplacePart[dv, First[pos] -> Global`oftFamilyApplicableQ[sym]];
    Global`$oftGuardRetargeted = True,
    Global`$oftGuardRetargeted = False];
  (* the auto-router call site: needStd = mbtRpNeedsStandardQ[resList, eps] -> the wrapper above, which receives the
     body's own order/verbosity locals (taken from the family call in the same body) *)
  Global`$oftRouterRetargeted = False;
  Module[{posR, posF, held, rl, ep, m1, m2, vb},
    posR = Position[dv, HoldPattern[MBAnalytica`SymbolicInt`Private`mbtRpNeedsStandardQ[_Symbol, _Symbol]]];
    posF = Position[dv, HoldPattern[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[_Symbol, _Symbol, _Symbol, _Symbol, _Symbol]]];
    If[posR =!= {} && posF =!= {},
      held = Extract[dv, First[posR], Hold]; rl = held[[1, 1]]; ep = held[[1, 2]];
      held = Extract[dv, First[posF], Hold]; m1 = held[[1, 3]]; m2 = held[[1, 4]]; vb = held[[1, 5]];
      dv = ReplacePart[dv, First[posR] -> Global`oftNeedStandardQ[rl, ep, m1, m2, vb]];
      Global`$oftRouterRetargeted = True]];
  DownValues[MBAnalytica`SymbolicInt`MBresolveToMPL] = dv;

  Global`$oftRungInstalled = True;
  Print["[mbeOneFoldTowerRung] installed: both closure directions, pFq normal form (Gauss/cancellation), minimal HypExp depth, ",
    "parallel block expansion, multi-fold handler (per-residue Standard closer); MB14 signature path disabled; ",
    "family guard re-targeted: ", Global`$oftGuardRetargeted, " (", n, " guard site(s) found); auto-router re-targeted: ",
    Global`$oftRouterRetargeted, "."];
]];
