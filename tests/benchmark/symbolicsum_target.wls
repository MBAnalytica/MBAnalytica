#!/usr/bin/env wolframscript
(* ::Package:: *)
(* symbolicsum_target.wls -- one example of the MBSymbolicSum benchmark through MBEvaluate[..., Method -> "SymbolicSum"] in this fresh
   kernel: every verdict is on the value MBAnalytica returns (G, Log, Zeta, Pi), never on MBSymbolicSum's own output.
   Environment: NAME (MB1, MB2, ..., MB13, or MB1u, ..., MB13u; MB2 = MB21 + MB22 and MB8 = MB81 + MB82),
   ORDER (the deepest order), OUT (record folder), KERNELS ($KernelLaunch, default 4), RESULTS_T (the audited records).
   Every row: the MBEvaluate value is free of MBFailed and of HarmonicSums H.
   inclusive: the exact difference of the MBEvaluate value with MBnVal vanishes at every order.
   differential: every order of the MBEvaluate value equals the audited record results_t/MBn_diff_<k>.m at u = 31/100
   and 7/100 to 10^-12: each G of MBEvaluate by GiNaC (30 digits), each H of the record on its cut as a G-function ODE
   on an arc (40 digits), as nbdiffcheck.wls.  The last line is RESUM_RESULT ... *)
SetOptions[$Output, PageWidth -> Infinity]; $HistoryLength = 0;
ScriptDir = DirectoryName[ExpandFileName[If[StringQ[$InputFileName] && $InputFileName =!= "", $InputFileName,
  First[Select[Join[$ScriptCommandLine, $CommandLine], StringEndsQ[#, "symbolicsum_target.wls"] &]]]]];
PackageDir = ParentDirectory[ParentDirectory[ScriptDir]];
Name = Environment["NAME"]; Ord = ToExpression[Environment["ORDER"]]; RecordDir = Environment["OUT"];
Kern = ToExpression[Environment["KERNELS"]]; Global`$KernelLaunch = If[IntegerQ[Kern], Kern, 4];
RefDir = Environment["RESULTS_T"];
Get[FileNameJoin[{ScriptDir, "mb_symbolicsum_targets.m"}]];
Get[FileNameJoin[{PackageDir, "MBAnalytica.wl"}]];
Eps = ToExpression["\[Epsilon]"];
Parts = Switch[Name, "MB2", {MB21, MB22}, "MB2u", {MB21u, MB22u}, "MB8", {MB81, MB82}, "MB8u", {MB81u, MB82u},
  _, {ToExpression[Name]}];
DiffQ = StringEndsQ[Name, "u"];
T0 = AbsoluteTime[];
GForm = Total[Map[MBEvaluate[#, {Eps, Ord}, Method -> "SymbolicSum"] &, Parts]];
Seconds = Round[AbsoluteTime[] - T0];
Lo = Exponent[Expand[GForm], Eps, Min];
Clean = FreeQ[GForm, MBAnalytica`MBFailed] && FreeQ[GForm, _HarmonicSums`H];
Print["RESUM_FORM ", Name, " MBEvaluate value free of MBFailed and H: ", Clean, "  G functions: ",
  Count[GForm, _PolyLogTools`G, {0, Infinity}]];
Pass = Clean; Rows = {};
If[! DiffQ,
  Val = ToExpression[Name <> "Val"];
  Diff = Quiet[Simplify[Expand[GForm - Normal[Series[Val, {Eps, 0, Ord}]]]]];
  Pass = Pass && TrueQ[Diff === 0];
  Print["RESUM_INCL ", Name, " exact difference with ", Name, "Val: ", InputForm[Diff]]];
If[DiffQ,
  Wp = 40;
  GArc[Words_, Sig_] := Module[{Suffixes, GName, Eqs, Ics, Fs, Sol, S0, Zs, Dz},
    Suffixes = DeleteDuplicates[Flatten[Map[Function[W, Table[Drop[W, J - 1], {J, Length[W]}]], Words], 1]];
    GName = AssociationThread[Suffixes, Table[Unique["gv"], {Length[Suffixes]}]];
    Zs[S_] := S + I*Sig*S*(1 - S)/2; Dz[S_] := 1 + I*Sig*(1 - 2*S)/2; S0 = 10^-30;
    Eqs = Map[Function[W, Module[{Rest1}, Rest1 = If[Length[W] === 1, 1, GName[Rest[W]][s]];
      GName[W]'[s] == Dz[s]*Rest1/(Zs[s] - First[W])]], Suffixes];
    Ics = Map[(GName[#][S0] == 0) &, Suffixes]; Fs = Map[GName, Suffixes];
    (* the default method stops early on simple words such as {0, 100/69}; explicit Runge-Kutta does not *)
    Sol = NDSolve[Join[Eqs, Ics], Fs, {s, S0, 1}, WorkingPrecision -> Wp, AccuracyGoal -> 30, PrecisionGoal -> 28, MaxSteps -> Infinity,
      Method -> "ExplicitRungeKutta"];
    AssociationThread[Words, Map[(GName[#][1] /. First[Sol]) &, Words]]];
  (* raw values: HarmonicSums H at argument 1 with letters on the path through the arc, as nbdiffcheck.wls *)
  HValue[V_, U0_] := Module[{Hs, OnH, Words, Gs, Rules, Vx},
    Hs = DeleteDuplicates[Cases[V, HoldPattern[HarmonicSums`H[__]], {0, Infinity}]];
    OnH = Select[Hs, (Last[List @@ #] === 1 && ! MemberQ[Most[List @@ #], 1] &&
       VectorQ[N[Most[List @@ #] /. Global`u -> U0], Im[#] == 0 &]) &];
    Vx = V;
    If[OnH =!= {}, Words = Map[(Most[List @@ #] /. Global`u -> U0) &, OnH]; Gs = GArc[Words, 1];
      Rules = Thread[OnH -> Map[(Times @@ Map[If[TrueQ[# > 0], -1, 1] &, DeleteCases[#, 0]])*Gs[#] &, Words]];
      Vx = Vx /. Rules];
    N[Vx /. Global`u -> U0, 20]];
  (* G form: every PolyLogTools G by GiNaC (ginsh, 30 digits), independent of MBSymbolicSum and of the conversion to G *)
  GinshBinary = Lookup[Quiet[Check[Get[FileNameJoin[{PackageDir, "config.m"}]], <||>]], "Ginsh", "ginsh"];
  GinshNumber[X_] := ToString[InputForm[X]];
  GinshValues[Gs_List] := Module[{Lines, Reply, Values1},
    Lines = Map["evalf(G({" <> StringRiffle[Map[GinshNumber, Most[List @@ #]], ","] <> "}," <> GinshNumber[Last[List @@ #]] <> "));" &, Gs];
    Reply = RunProcess[{GinshBinary}, "StandardOutput", "Digits=30:\n" <> StringRiffle[Lines, "\n"] <> "\n"];
    Values1 = StringSplit[StringTrim[Reply], "\n"];
    Values1 = Map[ToExpression[StringReplace[StringTrim[#], {"E" -> "*^"}]] &, Values1];
    If[Length[Values1] =!= Length[Gs] || ! VectorQ[Values1, NumericQ], Return[$Failed]];
    Thread[Gs -> Values1]];
  GValue[V_, U0_] := Module[{Vx, Gs1, Rules},
    Vx = V /. Global`u -> U0;
    Gs1 = DeleteDuplicates[Cases[Vx, g_PolyLogTools`G /; VectorQ[List @@ g, NumericQ], {0, Infinity}]];
    If[Gs1 =!= {}, Rules = GinshValues[Gs1]; If[Rules === $Failed, Return[$Failed]]; Vx = Vx /. Rules];
    N[Vx, 20]];
  ZetaSym[V_] := V /. Q_Symbol /; StringMatchQ[SymbolName[Q], "z" ~~ DigitCharacter ..] :> Zeta[ToExpression[StringDrop[SymbolName[Q], 1]]];
  Idx = StringReplace[StringDrop[Name, -1], {"MB" -> ""}];
  Do[Module[{File1, GC, Ref, Rel},
     File1 = FileNameJoin[{RefDir, "MB" <> Idx <> "_diff_" <> StringReplace[ToString[K], "-" -> "m"] <> ".m"}];
     GC = Coefficient[Expand[GForm], Eps, K];
     If[! FileExistsQ[File1], Print["RESUM_DIFF ", Name, " eps^", K, " no reference"]; Pass = False; Continue[]];
     (* the records write H without its context *)
     Ref = Block[{$ContextPath = Prepend[$ContextPath, "HarmonicSums`"]}, Get[File1]];
     Rel = Table[Module[{A = GValue[GC, P], B = HValue[ZetaSym[Ref], P]},
       If[NumericQ[A] && NumericQ[B], N[Abs[Re[A] - Re[B]]/Max[1, Abs[Re[B]]], 3], Infinity]], {P, {31/100, 7/100}}];
     If[! (Max[Rel] < 10^-12), Pass = False];
     Print["RESUM_DIFF ", Name, " eps^", K, "  MBEvaluate vs record at u = 31/100, 7/100: ", Rel,
       If[Max[Rel] < 10^-12, "  EQUAL", "  UNEQUAL"]]],
   {K, Lo, Ord}]];
Quiet[CreateDirectory[RecordDir, CreateIntermediateDirectories -> True]];
Block[{$Context = "zzWrite`", $ContextPath = {"System`"}},
  Put[<|"Name" -> Name, "Order" -> Ord, "Seconds" -> Seconds, "Pass" -> Pass, "GForm" -> GForm|>,
    FileNameJoin[{RecordDir, Name <> "_" <> ToString[Ord] <> ".m"}]]];
Print["RESUM_RESULT ", Name, "  order ", Ord, "  seconds ", Seconds, "  pass ", Pass, "  ", DateString[]];
Exit[0];
