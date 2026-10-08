(* ::Package:: *)
(* AUTHORSHIP (release R2, 2026-09-07): part of the IntVol package (Euler-integral backend of MB2MPL: big-expression helpers for the fibration pipeline). Author: Syed Mehedi Hasan. *)
(* ================================================================
   IntVol Big-Expression Helpers
   Adapted from Fekésházy's "How_to_handle_big_expressions_in_Mathematica"
   IV$-prefixed to avoid name collisions with user code.

   Provides:
     IV$Dependent[expr, var]
     IV$SeparateDependency[expr, var]
     IV$GatherByDependency[expr, var, fIndep, fDep]
     IV$MakeCoefficientsSymbolic[expr, var, dummyHead]
     IV$GetExponent[a*expr^n, var]
     IV$EuclideanApart[expr, var]
       — exact partial fractions via iterative Bézout/extended-GCD;
         drop-in Apart replacement, ~10× faster on symbolic-coeff cases
   ================================================================ *)

ClearAll[IV$Dependent, IV$SeparateDependency, IV$GatherByDependency,
        IV$MakeCoefficientsSymbolic, IV$GetExponent, IV$EuclideanApart]

(* ---- Dependent: split into {indep, dep} pairs after Expand ---- *)

IV$Dependent[expr_, var_] := {expr, 1} /; FreeQ[expr, var]

IV$Dependent[expr_, var_] := Block[{tmp = expr},
  tmp = tmp // Expand[#, var] &;
  tmp = If[Head[tmp] === Plus, List @@ tmp, {tmp}];
  tmp = IV$SeparateDependency[#, var] & /@ tmp]

(* ---- SeparateDependency: single-Times case helper ---- *)

IV$SeparateDependency[expr_, var_] := {expr, 1} /; Head[expr] =!= Times && FreeQ[expr, var]
IV$SeparateDependency[expr_, var_] := {expr, 1} /; Length[expr] === 0 && FreeQ[expr, var]
IV$SeparateDependency[expr_, var_] := {expr, 1} /; Length[expr] === 2 && Head[expr] === Power && FreeQ[expr, var]
IV$SeparateDependency[expr_, var_] := {1, expr} /; Head[expr] =!= Times && !FreeQ[expr, var]
IV$SeparateDependency[expr_, var_] := {1, expr} /; Length[expr] === 0 && !FreeQ[expr, var]
IV$SeparateDependency[expr_, var_] := {1, expr} /; Length[expr] === 2 && Head[expr] === Power && !FreeQ[expr, var]
IV$SeparateDependency[expr_, var_] := {Select[expr, FreeQ[#, var] &], Select[expr, !FreeQ[#, var] &]}

(* ---- GatherByDependency ---- *)

IV$GatherByDependency[expr_,
    var_Symbol | var_And | var_Or | var_Alternatives | var_Pattern,
    fIndep_: None, fDep_: None] :=
  If[fIndep === None, expr, expr // fIndep] /; FreeQ[expr, var]

IV$GatherByDependency[expr_Plus | expr_Times,
    var_Symbol | var_And | var_Or | var_Alternatives | var_Pattern,
    fIndep_: None, fDep_: None] :=
  Block[{tmp = expr, tmpFreeOfVar, tmpNotFreeOfVar},
    tmp = tmp // Expand[#, var] &;
    If[tmp === 0, Return[tmp, Block]];

    If[Head[tmp] =!= Plus,
      (* single term *)
      If[Length[tmp] === 0,
        tmpFreeOfVar = If[FreeQ[tmp, var], tmp, 1];
        tmpNotFreeOfVar = If[!FreeQ[tmp, var], tmp, 1],
        tmpFreeOfVar = tmp // Select[#, FreeQ[#, var] &] &;
        tmpNotFreeOfVar = tmp // Select[#, !FreeQ[#, var] &] &];
      Switch[{fIndep, fDep},
        {None, None}, tmp = tmpFreeOfVar * tmpNotFreeOfVar,
        {_, None},    tmp = (tmpFreeOfVar // fIndep) * tmpNotFreeOfVar,
        {None, _},    tmp = tmpFreeOfVar * (tmpNotFreeOfVar // fDep),
        {_, _},       tmp = (tmpFreeOfVar // fIndep) * (tmpNotFreeOfVar // fDep)];
      tmp,
      (* sum *)
      tmp = tmp // IV$Dependent[#, var] &;
      If[Head[tmp] =!= List, tmp,
        tmp = tmp // GatherBy[#, Last] &;
        Switch[{fIndep, fDep},
          {None, None}, tmp = Flatten[{#[[All, 1]] // Total, #[[1, 2]]}] & /@ tmp,
          {_, None},    tmp = Flatten[{#[[All, 1]] // Total // fIndep, #[[1, 2]]}] & /@ tmp,
          {None, _},    tmp = Flatten[{#[[All, 1]] // Total, #[[1, 2]] // fDep}] & /@ tmp,
          {_, _},       tmp = Flatten[{#[[All, 1]] // Total // fIndep, #[[1, 2]] // fDep}] & /@ tmp];
        Plus @@ Times @@@ tmp]]]

IV$GatherByDependency[expr_,
    var_Symbol | var_And | var_Or | var_Alternatives | var_Pattern,
    fIndep_: None, fDep_: None] :=
  If[fDep === None, expr, expr // fDep]

(* ---- MakeCoefficientsSymbolic ---- *)

IV$MakeCoefficientsSymbolic[expr_, var_Symbol, dummyFunction_Symbol] :=
  {dummyFunction[1], {dummyFunction[1] -> expr}} /; FreeQ[expr, var]

IV$MakeCoefficientsSymbolic[c_. var_Symbol^pow_., var_Symbol, dummyFunction_Symbol] :=
  {dummyFunction[1] var^pow, {dummyFunction[1] -> c}}

IV$MakeCoefficientsSymbolic[expr_, var_Symbol, dummyFunction_Symbol] :=
  Block[{tmp = expr, rules},
    tmp = tmp // IV$GatherByDependency[#, var, dummyFunction] &;
    If[tmp // FreeQ[#, var] &,
      Return[{dummyFunction[1], {dummyFunction[1] -> tmp}}, Block]];
    tmp = If[Head[tmp] === Plus, List @@ tmp, {tmp}];
    rules = Table[tmp[[i]] /. c_. dummyFunction[a_] :> Rule[dummyFunction[i], a], {i, 1, Length[tmp]}];
    tmp = Table[tmp[[i]] /. c_. dummyFunction[a_] :> c dummyFunction[i], {i, 1, Length[tmp]}];
    {Plus @@ tmp, rules}]

(* ---- GetExponent ---- *)

IV$GetExponent[list_List, var_Symbol] := IV$GetExponent[#, var] & /@ list
IV$GetExponent[a_. expr_^n_., var_] := {expr^n, 1} /; FreeQ[expr, var]
IV$GetExponent[a_. expr_^n_., var_] := {expr, n} /; !FreeQ[expr, var]

(* ---- EuclideanApart ---- *)
(* Iterative Bézout-GCD partial fractions; drop-in Apart replacement. *)

IV$EuclideanApart[expr_, var_] := expr /; FreeQ[expr, var]

IV$EuclideanApart[expr_, var_] :=
  Block[{tmp, dens, pairs, rulesGCD, dummyRulesGCD, tmpRules,
         tmp1, tmp2, tmp1Rules, tmp2Rules, pow1, pow2, coeff},

    tmp = Denominator[expr];
    tmp = If[Head[tmp] === Power, {tmp}, List @@ tmp];
    tmp = IV$GetExponent[#, var] & /@ List @@ tmp;
    dens = tmp[[All, 1]];

    pairs = Subsets[dens, {2}];
    If[Length[pairs] == 0, Return[expr // IV$GatherByDependency[#, var, None, Apart[#, var] &] &]];

    tmp = Table[
      tmp = PolynomialExtendedGCD[pairs[[i, 1]], pairs[[i, 2]], var][[2]];
      {tmp1, tmp1Rules} = tmp[[1]] // IV$MakeCoefficientsSymbolic[#, var, Unique[dummyF]] &;
      {tmp2, tmp2Rules} = tmp[[2]] // IV$MakeCoefficientsSymbolic[#, var, Unique[dummyF]] &;
      {{pairs[[i, 1]] tmp1, pairs[[i, 2]] tmp2}, Flatten[{tmp1Rules, tmp2Rules}]},
      {i, 1, Length[pairs]}];

    {rulesGCD, tmpRules} = {tmp[[All, 1]], Flatten[tmp[[All, 2]]]};

    dummyRulesGCD = MapThread[
      With[{tmp11 = #1[[1]], tmp12 = #1[[2]],
            tmp21 = #2[[1]], tmp22 = #2[[2]]},
        RuleDelayed[
          coeff_. Times[tmp11^pow1_, tmp12^pow2_] /; (pow1 < 0 && pow2 < 0),
          coeff*tmp21*tmp11^pow1*tmp12^pow2 + coeff*tmp22*tmp11^pow1*tmp12^pow2]] &,
      {pairs, rulesGCD}] // Dispatch;

    tmp = expr //. dummyRulesGCD;
    tmp = tmp // IV$GatherByDependency[#, var, None, Apart[#, var] &] &;
    tmp = tmp // IV$GatherByDependency[#, var, None, If[PolynomialQ[#, var], 0, #] &] &;
    tmp /. tmpRules]
