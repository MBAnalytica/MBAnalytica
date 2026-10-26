(* AUTHORSHIP (release R2, 2026-09-07): component of the MBSymbolicInt package (Standard route). Authors of MBSymbolicInt: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* ============================================================================================================
   mbeResolveLP.m -- EXACT LINEAR-PROGRAMMING CONTOUR SEARCH FOR THE RESOLVER (2026-09-17; MB15/MB16/MB17).
   MBresolve (MBresolve.m, MB`Private`MBfindResidues) explores the residue tree of the continuation eps -> 0 and,
   at EVERY node, looks for a contour point by a numerical global optimisation (NMinimize, differential evolution,
   in as many dimensions as there are integration variables) of the staircase penalty
       StepFunction[{x, 0}] = 0 for x > 0, else Floor[-x] + 1;
       StepFunction[{x, n}] = Floor[-n+1-x] for x < -n+1 (0 on -n < x < -n+1), else 1000 (x + n)
   over the Gamma arguments x (affine in the contour position).  The feasible set of a node is the polyhedron
   {a_j(z) > L_j, a_j(z) < U_j} (L_j = 0, U_j = infinity for an uncrossed leg; L_j = -n, U_j = -n+1 for a leg crossed
   n times), so the search is a LINEAR PROGRAMME: maximise the margin t with a_j - L_j >= t and U_j - a_j >= t
   (t capped at 1/2); the node is feasible iff t > 0, and the point is then an interior point of the strip (a
   Chebyshev-type centre, good for every later numerical gate).  When infeasible, the point that the tree recursion
   crosses from is the minimiser of the L1 hinge violation (weights 1 below the band, 1000 above it, the same
   weighting as the staircase), an LP as well.  Both LPs are solved EXACTLY over the rationals (LinearProgramming
   with rational data), so the contour points are rational.  The residue tree obtained differs from the
   differential-evolution one only in the choice of the crossing points; every choice is exact (the residue plus
   the shifted contour reproduce the integral), and the value is gated by the benchmark assembly as always.
   Per-node cost: milliseconds instead of ~0.5 s (MB15a: 981 residues, 1371 s with NMinimize).
   THIS RUNG redefines MB`Private`MBfindResidues with the same body, the point search replaced; the original is
   kept as Global`mbeLPFindResiduesOrig and used for a node whenever the LP fails (fail-closed).  Env
   MBE_RESOLVE_LP=0 disables the rung.
   ============================================================================================================ *)

If[Environment["MBE_RESOLVE_LP"] =!= "0" && DownValues[MB`Private`MBfindResidues] =!= {} && DownValues[Global`mbeLPFindResiduesOrig] === {},
 Module[{},
  DownValues[Global`mbeLPFindResiduesOrig] = DownValues[MB`Private`MBfindResidues] /. HoldPattern[MB`Private`MBfindResidues] -> Global`mbeLPFindResiduesOrig;
  Global`$mbeLPNodes = 0; Global`$mbeLPFallbacks = 0;
  (* the point search: conf = {{arg, n}, ...} with the limit variables already substituted; vars = the contour variables.
     Returns {value, {var -> rational, ...}} in the format of NMinimize's result, or $Failed. *)
  Global`mbeLPContourPoint[conf_List, vars_List] := Module[
    {k = Length[vars], rows = {}, rhs = {}, lows, ups, a0, cvec, sol, t, z, val, n, m, cobj, bounds, sl, su, ns},
    If[! AllTrue[conf, ListQ[#] && Length[#] == 2 && IntegerQ[#[[2]]] && PolynomialQ[#[[1]], vars] && Max[Exponent[#[[1]], vars]] <= 1 &], Return[$Failed]];
    If[! FreeQ[conf, _Real], Return[$Failed]];   (* exact data only *)
    lows = If[#[[2]] == 0, 0, -#[[2]]] & /@ conf;
    ups = If[#[[2]] == 0, Infinity, -#[[2]] + 1] & /@ conf;
    a0 = (#[[1]] /. Thread[vars -> 0]) & /@ conf;
    cvec = Table[Coefficient[c[[1]], v], {c, conf}, {v, vars}];
    (* LP A: variables {z_1..z_k, t}; minimise -t; a_j - t >= L_j  (c_j.z - t >= L_j - a0_j);  -a_j - t >= -U_j *)
    Do[AppendTo[rows, Append[cvec[[j]], -1]]; AppendTo[rhs, {lows[[j]] - a0[[j]], 1}];
       If[ups[[j]] =!= Infinity, AppendTo[rows, Append[-cvec[[j]], -1]]; AppendTo[rhs, {-ups[[j]] + a0[[j]], 1}]], {j, Length[conf]}];
    bounds = Append[Table[{-Infinity, Infinity}, {k}], {-Infinity, 1/2}];
    sol = Quiet[LinearProgramming[Append[ConstantArray[0, k], -1], rows, rhs, bounds, Method -> "Simplex"]];
    If[! ListQ[sol] || Length[sol] =!= k + 1, Return[$Failed]];
    t = Last[sol]; z = Take[sol, k];
    If[t > 0, Return[{0, Thread[vars -> z]}]];
    (* MILP B: infeasible node -- minimise the STAIRCASE SUM itself (the differential-evolution search minimises it
       approximately; a pure count objective ignored the depth and put MB4's root point at staircase 3 against 2):
       for an uncrossed leg an integer depth u_j >= 0 with a_j >= delta - u_j (so u_j = Floor[-a_j] + 1 on a
       violation, 0 when a_j >= delta); for a leg crossed n times a_j >= -n + delta - u_j and, for the upper edge,
       a_j <= -n + 1 - delta + M w_j with a binary w_j weighted 1000 (the staircase's 1000 (a+n)).  delta = 1/10,
       M = 200.  Objective Sum u_j + 1000 Sum w_j. *)
    m = Length[conf]; rows = {}; rhs = {};
    ns = Select[Range[m], ups[[#]] =!= Infinity &];
    (* variables: z (k), u (m), w (Length[ns]) *)
    Do[AppendTo[rows, Join[cvec[[j]], UnitVector[m, j], ConstantArray[0, Length[ns]]]]; AppendTo[rhs, {lows[[j]] + 1/10 - a0[[j]], 1}], {j, m}];
    Do[With[{jj = ns[[q]]}, AppendTo[rows, Join[-cvec[[jj]], ConstantArray[0, m], 200 UnitVector[Length[ns], q]]]; AppendTo[rhs, {-ups[[jj]] + 1/10 + a0[[jj]], 1}]], {q, Length[ns]}];
    cobj = Join[ConstantArray[0, k], ConstantArray[1, m], ConstantArray[1000, Length[ns]]];
    bounds = Join[Table[{-Infinity, Infinity}, {k}], Table[{0, 100}, {m}], Table[{0, 1}, {Length[ns]}]];
    sol = Quiet[LinearProgramming[cobj, rows, rhs, bounds, Join[ConstantArray[Reals, k], ConstantArray[Integers, m + Length[ns]]]]];
    If[! ListQ[sol] || Length[sol] =!= k + m + Length[ns], Return[$Failed]];
    z = Take[sol, k];
    (* LP C: an exact vertex of LP B can put an argument EXACTLY on an integer, i.e. a pole on the contour, which the
       tree bookkeeping then mis-crosses (MB4 validation: wrong value).  Move to the INTERIOR of the cell of the
       arrangement that z lies in: every argument keeps its staircase value but sits strictly inside its unit
       interval (an argument exactly at -k is assigned the open interval (-k-1, -k)); maximise the margin t. *)
    Module[{cells, vals = (#[[1]] /. Thread[vars -> z]) & /@ conf, rows2 = {}, rhs2 = {}, sol2, t2, z2},
      cells = Table[Module[{a = vals[[j]], n = conf[[j, 2]], lo, hi},
         Which[
          n == 0 && a > 0, {0, Infinity},                                   (* satisfied: a > 0 *)
          n == 0, With[{kk = Floor[-a]}, If[a == -kk, {-kk - 1, -kk}, {-kk - 1, -kk}]],   (* a in (-kk-1, -kk] -> open cell *)
          a > -n && a < -n + 1, {-n, -n + 1},                                 (* inside the band *)
          a >= -n + 1, With[{kk = Floor[a]}, If[a == kk, {kk - 1, kk}, {kk, kk + 1}] /. x_ /; x < -n + 1 -> -n + 1],   (* above the band: keep it above *)
          True, With[{kk = Floor[-a]}, {-kk - 1, -kk}]]],                    (* below the band *)
        {j, m}];
      Do[AppendTo[rows2, Append[cvec[[j]], -1]]; AppendTo[rhs2, {cells[[j, 1]] - a0[[j]], 1}];
         If[cells[[j, 2]] =!= Infinity, AppendTo[rows2, Append[-cvec[[j]], -1]]; AppendTo[rhs2, {-cells[[j, 2]] + a0[[j]], 1}]], {j, m}];
      sol2 = Quiet[LinearProgramming[Append[ConstantArray[0, k], -1], rows2, rhs2, Append[Table[{-Infinity, Infinity}, {k}], {-Infinity, 1/2}], Method -> "Simplex"]];
      If[! ListQ[sol2] || Length[sol2] =!= k + 1, Return[$Failed]];
      t2 = Last[sol2]; z2 = Take[sol2, k];
      If[! (t2 > 0), Return[$Failed]];
      (* Gamma poles are the nonpositive integers. Positive integers are
         regular and must not force a random numerical fallback. *)
      If[AnyTrue[(#[[1]] /. Thread[vars -> z2]) & /@ conf, IntegerQ[#] && # <= 0 &], Return[$Failed]];
      z = z2];
    val = Total[MB`Private`StepFunction[{#[[1]] /. Thread[vars -> z], #[[2]]}] & /@ conf];
    {val, Thread[vars -> z]}];
  Clear[MB`Private`MBfindResidues];
  MB`Private`MBfindResidues[{vars_, integrand_, conf_}, LimVars_, {min_, max_}, FixedPoint_, options___Rule] := Module[
    {newpoint, function, point, badpoints, i, res, step, temp, opt = MB`Private`ParseOptions[MB`Private`MBfindResidues, options], verbose},
    verbose = MB`Verbose /. opt;
    If[verbose, Print["Level: ", Length[vars]]];
    If[verbose, Print[conf]];
    If[FixedPoint === False,
      If[Length[vars] === 0,
        If[verbose, Print["+"]];
        Return[{MB`MBint[MB`Private`NONE, {Take[LimVars, 1], {}}]}]];
      If[MB`Private`BadConfiguration[conf], If[verbose, Print["Bad configuration"]]; Return[False]];
      If[Length[Union[(#[[1]]) & /@ conf]] =!= Length[conf], If[verbose, Print["Bad configuration"]]; Return[False]];
      Global`$mbeLPNodes++;
      point = Global`mbeLPContourPoint[conf /. LimVars, vars];
      If[point === $Failed,
        Global`$mbeLPFallbacks++;
        function = Plus @@ (MB`Private`StepFunction /@ (conf /. LimVars));
        point = NMinimize[function, vars, Method -> "DifferentialEvolution"]],
      point = FixedPoint];
    If[point[[1]] > 100, If[verbose, Print["?"]]; Return[False]];
    If[verbose, Print[point]];
    If[point[[1]] < 1,
      If[verbose, Print["+"]];
      Return[{MB`MBint[MB`Private`NONE, {Take[LimVars, 1], point[[2]]}]}]];
    badpoints = Select[conf, (MB`Private`StepFunction[# /. Join[point[[2]], LimVars]] > 0) &];
    If[verbose, Print[badpoints]];
    For[i = 1, i <= Length[badpoints], i++,
      temp = badpoints[[i]];
      step = {vars, integrand, conf /. {temp -> temp + {0, 1}}};
      temp = Plus @@ temp;
      temp = {Complement[Variables[temp], (#[[1]]) & /@ LimVars][[1]], temp};
      temp = {Rule[temp[[1]], -(temp[[2]]/Coefficient[temp[[2]], temp[[1]]]) /. (Rule[temp[[1]], 0])], Sign[Coefficient[temp[[2]], temp[[1]]]]};
      If[verbose, Print[temp]];
      res = {DeleteCases[vars, temp[[1]][[1]]], MB`Private`NONE, Union[Expand[DeleteCases[conf, badpoints[[i]]] /. temp[[1]]]]};
      res = {res[[1]], res[[2]], Select[res[[3]], (Complement[Variables[#[[1]]], (#[[1]]) & /@ LimVars] =!= {}) &]};
      res = MB`Private`MBfindResidues[res, LimVars, {min, min + ((max - min)/(Length[badpoints]) + 1)}, False];
      If[res === False, Continue[]];
      MB`Private`Dots[min + ((max - min)/(Length[badpoints] + 1))];
      step = MB`Private`MBfindResidues[step, LimVars, {min + ((max - min)/(Length[badpoints] + 1)), max}, {point[[1]] - 1, point[[2]]}];
      If[step === False, Continue[]];
      MB`Private`Dots[max];
      Return[{MB`Private`MBmakeResidue[res, {temp[[2]], List @@ (temp[[1]])}], step}]];
    Return[False]];
  WriteString["stdout", "[mbeResolveLP] MB`Private`MBfindResidues redefined: exact linear-programming contour search (margin LP, then L1-hinge LP); the differential-evolution search is the per-node fallback.\n"]]];
