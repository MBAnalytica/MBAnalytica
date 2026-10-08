(* ::Package:: *)
(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Syed Mehedi Hasan, Taushif Ahmed, Andreas Rapakoulias, Sumit Banik. *)

(* mbeResonantResolve.m -- resonant-resolution rung (2026-09-06).

   CLASS.  A Mellin-Barnes representation is RESONANT when a non-negative combination of its numerator Gamma
   arguments is a non-positive constant with every integration-variable coefficient AND the epsilon coefficient
   equal to zero (an epsilon-free Farkas certificate).  Such a "zero-sum Gamma cycle" blocks every straight
   contour at every epsilon, so MBresolve returns False deterministically.  The value of the integral is the
   analytic continuation in auxiliary regulators inserted on a hitting set of the certificate supports:
   Gamma(a_i) -> Gamma(a_i + r_i delta) with the regulators tied along a generic ray r.  The continuation walks
   epsilon -> 0 first at finite delta (delta regulates every epsilon-pinch) and then delta -> 0 once per piece;
   the delta -> 0 limit of the piece list is the resolution residue list in MBresolve's own format.

   THIS RUNG wraps MB`MBresolve: the saved original runs first; only when it yields no residue list does the rung
   look for epsilon-free certificates, choose the smallest feasible hitting set, and run the two-regulator
   continuation with MB`MBcontinue (retrying on the next ray when a piece hits a delta-collision).  Everything
   is exact (rational start points, symbolic residues); a failure of every ray is fail-closed (the original
   result is returned and the sealed core reports the resolution failure).  The result is memoised per
   (integrand, epsilon) because the sealed core's global body re-runs the resolution.

   Theory: standard_syed.tex, "Resonant representations" (Lemma resonant-continuation); campaign scripts
   mbx_mb11_farkas2.m (certificates), mbx_mb11_full.m v5 (continuation), MB11 audits 2026-07-29 .. 2026-09-06. *)

Global`$mbrVerbose = True;
Global`$mbrCertificateSeconds = 120;   (* per FindInstance in the certificate enumeration *)
Global`$mbrMaxCertificates = 8;
Global`$mbrFeasibilitySeconds = 30;
Global`$mbrStartSeconds = 300;         (* joint start point FindInstance *)
Global`$mbrEpsWalkSeconds = 3000;      (* MBcontinue epsilon -> 0 at finite delta *)
Global`$mbrDeltaWalkSeconds = 1500;    (* MBcontinue delta -> 0, per piece *)
Global`$mbrMaxHittingSets = 3;
Global`$mbrHittingSetChoice = None;   (* integer: force the n-th feasible hitting-set candidate (regulator-independence checks) *)
Global`$mbrRayChoice = None;          (* list of rationals: force the ray direction *)
Global`$mbrRegulator = Global`deltaReg;
Global`$mbrPrimes = {9973, 10007, 10037, 10061, 10067, 10069, 10079, 10091, 10093, 10099, 10103, 10111, 10133, 10139};
If[! AssociationQ[Global`$mbrCache], Global`$mbrCache = <||>];
Global`$mbrLastReport = <||>;

Global`mbrLog[x___] := If[TrueQ[Global`$mbrVerbose], Print["[resonant] ", x]];

Global`mbrGammaArgs[mb_] := Cases[{Numerator[Together[mb]]}, Gamma[a_] :> a, {0, Infinity}];
Global`mbrVars[args_, eps_] := Sort[DeleteCases[Variables[args], eps]];

(* ---- epsilon-free Farkas certificates: supports of lambda >= 0, Sum lambda = 1, zero z- and eps-coefficients,
        non-positive constant; enumerated greedily by forbidding the first member of each support found ---- *)
Global`mbrCertificates[args_, vars_, eps_] := Module[
  {n = Length[args], lam, sum, zco, eco, c0, find, certs = {}, forbid = {}},
  lam = Table[Symbol["Global`mbrLam" <> ToString[k]], {k, n}];
  sum = lam . args;
  zco = Coefficient[sum, #] & /@ vars;
  eco = Coefficient[sum, eps];
  c0 = sum /. Join[Thread[vars -> 0], {eps -> 0}];
  find[fb_] := Module[{cons, sol},
    cons = Join[(# >= 0) & /@ lam, (lam[[#]] == 0) & /@ fb, (# == 0) & /@ zco,
      {eco == 0, Total[lam] == 1, c0 <= 0}];
    sol = Quiet@TimeConstrained[FindInstance[And @@ cons, lam, Rationals], Global`$mbrCertificateSeconds, {}];
    If[ListQ[sol] && sol =!= {}, First[sol], None]];
  Do[Module[{c = find[forbid], supp},
     If[c === None, Break[]];
     supp = Select[Range[n], (lam[[#]] /. c) =!= 0 &];
     AppendTo[certs, supp];
     AppendTo[forbid, First[supp]]],
    {Global`$mbrMaxCertificates}];
  certs];

Global`mbrFeasibleQ[args_, vars_, eps_, idx_, off_] := Module[{a = args, sol},
  Do[a[[idx[[i]]]] += off[[i]], {i, Length[idx]}];
  sol = Quiet@TimeConstrained[FindInstance[And @@ ((# > 1/100) & /@ a), Append[vars, eps], Reals],
    Global`$mbrFeasibilitySeconds, {}];
  ListQ[sol] && sol =!= {}];

(* hitting sets of the certificate supports, smallest first, ordered by support frequency; a candidate is kept
   when a straight contour exists once its members carry generic positive offsets *)
Global`mbrHittingSets[args_, vars_, eps_, certs_] := Module[{freq, top, cands},
  freq = Reverse@SortBy[Tally[Flatten[certs]], Last];
  top = freq[[All, 1]];
  cands = Join[List /@ top, Subsets[Take[top, UpTo[5]], {2}], Subsets[Take[top, UpTo[6]], {3}]];
  cands = Select[cands, With[{h = #}, AllTrue[certs, IntersectingQ[#, h] &]] &];
  cands = Select[cands,
    Global`mbrFeasibleQ[args, vars, eps, #, ConstantArray[1, Length[#]]] ||
    Global`mbrFeasibleQ[args, vars, eps, #, ConstantArray[3, Length[#]]] &];
  Take[cands, UpTo[Global`$mbrMaxHittingSets]]];

Global`mbrRays[1] = {{1}, {7/5}, {9/7}, {11/8}};
Global`mbrRays[2] = {{13/10, 9/10}, {17/13, 7/11}, {23/17, 11/13}, {19/14, 8/13}};
Global`mbrRays[k_Integer /; k >= 3] := Table[Table[(10 + 3 i + 7 j)/(7 + 2 i + 5 j), {i, k}], {j, 0, 3}];

(* ---- the two-stage continuation on one ray: eps -> 0 at finite delta, then delta -> 0 per piece ---- *)
Global`mbrTryRay[mb_, eps_, args_, vars_, hit_, ray_] := Module[
  {reg = Global`$mbrRegulator, prm = Global`$mbrPrimes, mbR, argsR, sol, pt0, c1 = $Failed, c3 = {}, bad = 0, t0 = AbsoluteTime[]},
  mbR = mb /. Table[Gamma[args[[hit[[i]]]]] -> Gamma[args[[hit[[i]]]] + ray[[i]] reg], {i, Length[hit]}];
  argsR = Global`mbrGammaArgs[mbR];
  sol = Quiet@TimeConstrained[FindInstance[
    And @@ Join[(# > 1/50) & /@ argsR, {1/2 < reg < 3/2, -4 < eps < 4}],
    Join[vars, {eps, reg}], Reals], Global`$mbrStartSeconds, {}];
  If[! (ListQ[sol] && sol =!= {}), Global`mbrLog["ray ", ray, ": no joint start point"]; Return[$Failed]];
  pt0 = Rationalize[First[sol], 1/100000];
  (* eps -> 0 at finite delta; the start point is perturbed by large-prime-denominator offsets so that no pole
     sits exactly on a contour *)
  Do[Module[{off, pt, rules1},
     off = Table[try (k + 1)/prm[[k]], {k, Length[vars] + 2}];
     pt = MapThread[(#1[[1]] -> #1[[2]] + #2) &, {List @@@ pt0, Take[off, Length[pt0]]}];
     If[! TrueQ[And @@ ((N[# /. pt] > 1/100) & /@ argsR)], Continue[]];
     rules1 = {{eps -> (eps /. pt), reg -> (reg /. pt)}, Thread[vars -> (vars /. pt)]};
     c1 = Quiet@TimeConstrained[MB`MBcontinue[mbR, eps -> 0, rules1], Global`$mbrEpsWalkSeconds, $Failed];
     If[ListQ[c1], c1 = Flatten[c1]; Break[]]],
    {try, 0, 6}];
  If[! ListQ[c1], Global`mbrLog["ray ", ray, ": epsilon walk failed"]; Return[$Failed]];
  Global`mbrLog["ray ", ray, ": epsilon -> 0 gave ", Length[c1], " pieces (", Round[AbsoluteTime[] - t0], " s)"];
  (* delta -> 0 once per piece, with contour nudges on retry *)
  Do[Module[{p = c1[[j]], c, done = False},
     If[FreeQ[p[[1]], reg], AppendTo[c3, p]; done = True];
     Do[If[! done,
        Module[{r2 = p[[2]]},
          If[rt > 0,
            r2 = {r2[[1]], MapThread[(#1[[1]] -> #1[[2]] + #2) &,
              {List @@@ r2[[2]], Table[rt (k + 2)/prm[[k]], {k, Length[r2[[2]]]}]}]}];
          c = Quiet@TimeConstrained[MB`MBcontinue[p[[1]], reg -> 0, r2], Global`$mbrDeltaWalkSeconds, $Failed];
          If[ListQ[c], c3 = Join[c3, Flatten[c]]; done = True]]],
       {rt, 0, 2}];
     If[! done, bad++]],
    {j, Length[c1]}];
  If[bad > 0, Global`mbrLog["ray ", ray, ": delta walk left ", bad, " piece(s) -> next ray"]; Return[$Failed]];
  c3 = Quiet@MB`MBexpand[c3, 1, {reg, 0, 0}];
  If[Count[c3, p_ /; ! FreeQ[p[[1]], reg]] > 0,
    Global`mbrLog["ray ", ray, ": residual regulator dependence -> next ray"]; Return[$Failed]];
  Global`mbrLog["ray ", ray, ": delta -> 0 done, ", Length[c3], " residue pieces; folds ",
    Tally[Sort[Length[#[[2, 2]]] & /@ c3]], " (", Round[AbsoluteTime[] - t0], " s)"];
  c3];

Global`mbrResonantResolve[mb_, eps_] := Module[
  {key = Hash[{mb, eps, Global`$mbrHittingSetChoice, Global`$mbrRayChoice}], args, vars, certs, cands, out = $Failed, t0 = AbsoluteTime[], hitUsed = None, rayUsed = None},
  If[KeyExistsQ[Global`$mbrCache, key], Return[Global`$mbrCache[key]]];
  args = Global`mbrGammaArgs[mb];
  vars = Global`mbrVars[args, eps];
  certs = Global`mbrCertificates[args, vars, eps];
  If[certs === {},
    Global`mbrLog["no epsilon-free Farkas certificate: not a resonant representation (nothing to continue)"];
    Return[$Failed]];
  Global`mbrLog[Length[certs], " epsilon-free certificate(s); supports ", certs];
  cands = Global`mbrHittingSets[args, vars, eps, certs];
  If[cands === {}, Global`mbrLog["no feasible hitting set among singles/pairs/triples"]; Return[$Failed]];
  Global`mbrLog["hitting-set candidates ", cands, " (Gamma arguments ", (args[[#]] & /@ cands), ")"];
  If[IntegerQ[Global`$mbrHittingSetChoice] && 1 <= Global`$mbrHittingSetChoice <= Length[cands],
    cands = {cands[[Global`$mbrHittingSetChoice]]};
    Global`mbrLog["forced hitting set ", cands]];
  Do[
    Do[Module[{r = Global`mbrTryRay[mb, eps, args, vars, hit, ray]},
       If[ListQ[r], out = r; hitUsed = hit; rayUsed = ray; Break[]]],
      {ray, If[ListQ[Global`$mbrRayChoice] && Length[Global`$mbrRayChoice] === Length[hit],
              {Global`$mbrRayChoice}, Global`mbrRays[Length[hit]]]}];
    If[ListQ[out], Break[]],
    {hit, cands}];
  If[ListQ[out],
    Global`$mbrCache[key] = out;
    Global`$mbrLastReport = <|"Certificates" -> certs, "HittingSet" -> (args[[#]] & /@ hitUsed), "Ray" -> rayUsed,
      "Pieces" -> Length[out], "Seconds" -> Round[AbsoluteTime[] - t0]|>;
    Global`mbrLog["resonant continuation complete: regulators on ", args[[#]] & /@ hitUsed, " along ray ", rayUsed,
      "; ", Length[out], " residue pieces in ", Round[AbsoluteTime[] - t0], " s"],
    Global`mbrLog["every hitting set and ray failed (", Round[AbsoluteTime[] - t0], " s); fail-closed"]];
  out];

(* ---- install: wrap MB`MBresolve (saved original first, rung only on failure) ---- *)
If[DownValues[Global`mbrMBresolveOrig] === {} && DownValues[MB`MBresolve] =!= {},
  DownValues[Global`mbrMBresolveOrig] = DownValues[MB`MBresolve] /. HoldPattern[MB`MBresolve] -> Global`mbrMBresolveOrig;
  Global`mbrResolveWrap[mb_, eps_] := Module[{r, c, key = Hash[{mb, eps, Global`$mbrHittingSetChoice, Global`$mbrRayChoice}]},
    (* a memoised continuation means the saved original already failed on this input: serve it directly *)
    If[KeyExistsQ[Global`$mbrCache, key], Return[Global`$mbrCache[key]]];
    r = Global`mbrMBresolveOrig[mb, eps];
    If[ListQ[r] && r =!= {}, Return[r]];
    c = Global`mbrResonantResolve[mb, eps];
    If[ListQ[c] && c =!= {}, c, r]];
  Unprotect[MB`MBresolve];
  DownValues[MB`MBresolve] = {
    HoldPattern[MB`MBresolve[mb_, eps_Symbol]] :> Global`mbrResolveWrap[mb, eps],
    HoldPattern[MB`MBresolve[mb_, rest___]] :> Global`mbrMBresolveOrig[mb, rest]};
  Global`$mbrWrapInstalled = True];
