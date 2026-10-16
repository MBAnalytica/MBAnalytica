#!/usr/bin/env wolframscript
(* ::Package:: *)
(* mbevaluate_target.wls -- one row of a benchmark status table through MBEvaluate[..., Method -> METHOD] in this fresh
   kernel.  Every verdict is on the value MBEvaluate returns; nothing else of the package is called for the result.
   Environment:
     METHOD     Resum | Standard | Subtraction
     KIND       inc (inclusive row) | u (differential row, u unintegrated, 0 < u < 1)
     NAME       the row (MB1, ..., MB14, MBpilot12, MBpilot13, MB1u, ..., MB14u)
     LO, HI     the orders of the row (LO = auto: from the leading pole)
     OUT        record folder;  KERNELS  $KernelLaunch;  RESULTS_T  the audited MBResum records (results_t)
     VERBOSE    1 = MBEvaluate[..., Verbose -> True] (the engine's progress in the log; the value is the same)
   The inputs are those of the reference tables: MBResum rows from mb_resum_targets.m (status_mb2mpl.pdf: MB2 = MB21 +
   MB22, MB8 = MB81 + MB82), Standard and Subtraction rows from mb_targets_all.m and mb_u_targets.m (benchmark_status.pdf:
   MB8 = MB8a + MB8b, MB14 = MB14a + MB14b; the rows marked k and f on the Subtraction page are, as there, the exact
   u-integrals of their differential kernels or families at the MB level, u^a (1-u)^b G -> G Gamma(1+a) Gamma(1+b) /
   Gamma(2+a+b)).  Each part is one MBEvaluate call; the row is their sum.
   Checks: the value is free of MBFailed, H and HPL;
     inclusive rows: every order equals the exact benchmark MBnVal (exact zero difference, else 10^-30 at 40 digits);
     MBResum differential rows: every order equals results_t/MBn_diff_k.m at u = 31/100, 7/100 to 10^-12;
     Standard and Subtraction differential rows: the full complex value (Complex -> True) equals the records of both
     routes (mbu_results.m, mbu_subtraction_records.m) at u = 1/5, 1/3, 3/7, 4/5 to 10^-20.
   The last line is MBEVAL_RESULT ... *)
SetOptions[$Output, PageWidth -> Infinity];
$HistoryLength = 0;
ScriptDir = DirectoryName[ExpandFileName[If[StringQ[$InputFileName] && $InputFileName =!= "", $InputFileName,
  First[Select[Join[$ScriptCommandLine, $CommandLine], StringEndsQ[#, "mbevaluate_target.wls"] &]]]]];
PackageDir = ParentDirectory[ParentDirectory[ScriptDir]];
Method1 = Environment["METHOD"];
Kind = Environment["KIND"];
Name = Environment["NAME"];
Lo = Quiet[ToExpression[Environment["LO"]]];
Hi = ToExpression[Environment["HI"]];
RecordDir = Environment["OUT"];
Kern = Quiet[ToExpression[Environment["KERNELS"]]];
RefDir = Environment["RESULTS_T"];
VerboseQ = Environment["VERBOSE"] === "1";
Global`$KernelLaunch = If[IntegerQ[Kern], Kern, 4];
If[StringQ[Environment["MBANALYTICA_CACHE"]], Global`$MBAnalyticaCacheDirectory = Environment["MBANALYTICA_CACHE"]];
Get[FileNameJoin[{PackageDir, "MBAnalytica.wl"}]];
Eps = Global`\[Epsilon];


(* ::Section:: *)
(*Inputs*)


KernelIntegral[Data_, Family_] := Module[{Entry, A, B, Rest1, U},
  Entry = Data["Targets"][Family];
  U = Data["Parameter"];
  A = Entry["UPower"];
  B = Entry["OneMinusUPower"];
  Rest1 = Together[Entry["Integrand"]/(U^A (1 - U)^B)];
  If[! FreeQ[Rest1, U] || ! FreeQ[{A, B}, U], Return[$Failed]];
  Return[(Rest1 Gamma[1 + A] Gamma[1 + B]/Gamma[2 + A + B]) /. Data["Regulator"] -> Eps]];


Parts = {};
Val = None;
UData = None;
Which[
  Method1 === "Resum",
    Get[FileNameJoin[{ScriptDir, "mb_resum_targets.m"}]];
    Parts = Switch[Name, "MB2", {Global`MB21, Global`MB22}, "MB2u", {Global`MB21u, Global`MB22u},
      "MB8", {Global`MB81, Global`MB82}, "MB8u", {Global`MB81u, Global`MB82u}, _, {ToExpression["Global`" <> Name]}];
    If[Kind === "inc", Val = ToExpression["Global`" <> Name <> "Val"]],
  Kind === "inc",
    Get[FileNameJoin[{ScriptDir, "mb_targets_all.m"}]];
    UData = Block[{$ContextPath = $ContextPath}, Quiet[Get[FileNameJoin[{ScriptDir, "mb_u_targets.m"}]]]];
    Parts = Which[
      Method1 === "Subtraction" && MemberQ[{"MB5", "MB6", "MB9", "MB10", "MB11"}, Name], {KernelIntegral[UData, Name <> "u"]},
      Method1 === "Subtraction" && Name === "MB8", {KernelIntegral[UData, "MB8au"], KernelIntegral[UData, "MB8bu"]},
      Method1 === "Subtraction" && Name === "MB14", {KernelIntegral[UData, "MB14au"], KernelIntegral[UData, "MB14bu"]},
      Name === "MB8", {Global`MB8a, Global`MB8b},
      Name === "MB14", {Global`MB14a, Global`MB14b},
      True, {ToExpression["Global`" <> Name]}];
    Val = Switch[Name, "MBpilot12", Global`MB1Val, "MBpilot13", Global`MB2Val, _, ToExpression["Global`" <> Name <> "Val"]],
  True,
    UData = Block[{$ContextPath = $ContextPath}, Quiet[Get[FileNameJoin[{ScriptDir, "mb_u_targets.m"}]]]];
    Parts = Map[UData["Targets"][#]["Integrand"] /. {UData["Regulator"] -> Eps, UData["Parameter"] -> Global`u} &,
      Lookup[UData["ComponentGroups"], Name, {Name}]]];
If[Parts === {} || MemberQ[Parts, $Failed], Print["MBEVAL_RESULT ", Method1, " ", Kind, " ", Name, "  NO INPUT"]; Exit[1]];
ComplexQ = Kind === "u" && Method1 =!= "Resum";
Print["MBEVAL ", Method1, " ", Kind, " ", Name, "  ", Length[Parts], " part(s)  orders through eps^", Hi,
  "  Complex -> ", ComplexQ, "  $KernelLaunch ", Global`$KernelLaunch, "  ", DateString[]];


(* ::Section:: *)
(*The evaluation: MBEvaluate only*)


T0 = AbsoluteTime[];
(* RECHECK = a record of this script: its saved MBEvaluate value is checked again (after a fix of the checks) *)
Recheck = Environment["RECHECK"];
If[StringQ[Recheck] && Recheck =!= "" && FileExistsQ[Recheck],
  Saved = Get[Recheck];
  Values1 = {Saved["Value"]};
  Seconds = Saved["Seconds"];
  Print["MBEVAL_RECHECK ", Name, "  the MBEvaluate value saved in ", Recheck],
  Values1 = Map[MBEvaluate[#, {Eps, Hi}, Method -> Method1, Complex -> ComplexQ, Verbose -> VerboseQ] &, Parts];
  Seconds = Round[AbsoluteTime[] - T0]];
GForm = Total[Values1];
If[! IntegerQ[Lo], Lo = Exponent[Expand[GForm], Eps, Min]];
Clean = ! MemberQ[Values1, $Failed] && FreeQ[GForm, MBAnalytica`MBFailed] && FreeQ[GForm, _HarmonicSums`H] &&
  (Names["HPL`HPL"] === {} || FreeQ[GForm, _HPL`HPL]);
Print["MBEVAL_FORM ", Name, "  free of MBFailed, H and HPL: ", Clean, "  G functions: ", Count[GForm, _PolyLogTools`G, {0, Infinity}],
  "  seconds ", Seconds];
Pass = Clean;
OrderPass = <||>;


(* ::Section:: *)
(*Numbers: GiNaC for G, multiple zeta values included*)


GinshBinary = Lookup[Quiet[Check[Get[FileNameJoin[{PackageDir, "config.m"}]], <||>]], "Ginsh", "ginsh"];
(* rationals exactly; an algebraic letter (Sqrt[5], (1 + Sqrt[17])/2, ...) is reduced exactly first and passed with 60
   digits, since ginsh reads no Mathematica syntax *)
GinshNumber[X_] := Module[{Reduced, Value1},
  Reduced = If[IntegerQ[X] || Head[X] === Rational || ! NumericQ[X], X, Quiet[RootReduce[X]]];
  If[IntegerQ[Reduced] || Head[Reduced] === Rational, Return[ToString[InputForm[Reduced]]]];
  Value1 = N[Reduced, 60];
  Return[StringReplace[ToString[Value1, InputForm, NumberMarks -> False], "*^" -> "E"]]];
GinshRun[Lines_List, Digits1_] := Module[{Reply, Values2},
  Reply = RunProcess[{GinshBinary}, "StandardOutput", "Digits=" <> ToString[Digits1] <> ":\n" <> StringRiffle[Lines, "\n"] <> "\n"];
  Values2 = StringSplit[StringTrim[Reply], "\n"];
  Values2 = Map[ToExpression[StringReplace[StringTrim[#], {"E" -> "*^"}]] &, Values2];
  If[Length[Values2] =!= Length[Lines] || ! VectorQ[Values2, NumericQ], Return[$Failed]];
  Return[Values2]];
(* GiNaC evaluates G(a; y) only for y > 0; G(a; y) = G(a/y; 1) when the last letter is not 0 *)
GScaled[G1_] := Module[{Letters, Y},
  Letters = Most[List @@ G1];
  Y = Last[List @@ G1];
  If[TrueQ[Y > 0] || Last[Letters] === 0, Return[{Letters, Y}]];
  Return[{Letters/Y, 1}]];
GRules[Gs_List, Digits1_] := Module[{Lines, Got},
  If[Gs === {}, Return[{}]];
  Lines = Map[Function[G1, Module[{LY = GScaled[G1]},
    "evalf(G({" <> StringRiffle[Map[GinshNumber, LY[[1]]], ","] <> "}," <> GinshNumber[LY[[2]]] <> "));"]], Gs];
  Got = GinshRun[Lines, Digits1];
  If[Got === $Failed, Return[$Failed]];
  Return[Thread[Gs -> Got]]];
(* the multiple zeta value zeta(5,3) = Sum_{m>n} m^-5 n^-3 (the convention of the benchmarks for Zeta[5, 3]) *)
Zeta53 = First[GinshRun[{"evalf(zeta({5,3}));"}, 50]];
(* the harmonic polylogarithms of the records by GiNaC as well (H(m; x) in the m-notation of HPL), independent of the
   conversion MBEvaluate applies to its own values *)
HRules[Hs_List, Digits1_] := Module[{Lines, Got},
  If[Hs === {}, Return[{}]];
  Lines = Map["evalf(H({" <> StringRiffle[Map[GinshNumber, First[#]], ","] <> "}," <> GinshNumber[Last[#]] <> "));" &, Hs];
  Got = GinshRun[Lines, Digits1];
  If[Got === $Failed, Return[$Failed]];
  Return[Thread[Hs -> Got]]];
NumberOf[X_, Digits1_] := Module[{Y, Gs, Hs, Rules, HR},
  Y = X /. {HPL`HPLs8a -> Zeta[8] + Zeta53, Zeta[5, 3] -> Zeta53};
  Gs = DeleteDuplicates[Cases[Y, G1_PolyLogTools`G /; VectorQ[List @@ G1, NumericQ], {0, Infinity}]];
  Rules = GRules[Gs, Digits1 + 5];
  If[Rules === $Failed, Return[$Failed]];
  Hs = If[Names["HPL`HPL"] === {}, {},
    DeleteDuplicates[Cases[Y, H1_HPL`HPL /; VectorQ[First[H1], IntegerQ] && NumericQ[Last[H1]], {0, Infinity}]]];
  HR = HRules[Hs, Digits1 + 5];
  If[HR === $Failed, Return[$Failed]];
  Return[N[Y /. Rules /. HR, Digits1]]];


(* ::Section:: *)
(*Inclusive rows: the exact benchmark*)


PrimeLog[E1_] := E1 /. Log[Q_ /; (IntegerQ[Q] || Head[Q] === Rational) && Q > 0] :> Total[(#[[2]] Log[#[[1]]]) & /@ FactorInteger[Q]];
ExactZeroQ[D1_] := Module[{C1},
  C1 = Quiet[Expand[PrimeLog[D1]]];
  Return[C1 === 0 || TrueQ[Quiet[PossibleZeroQ[Simplify[C1]]]]]];
If[Kind === "inc",
  Do[Module[{C1, B1, Exact1, Num1, Rel},
     C1 = Coefficient[Expand[GForm], Eps, K];
     B1 = SeriesCoefficient[Val, {Eps, 0, K}];
     Exact1 = ExactZeroQ[Re[C1 /. HPL`HPLs8a -> Zeta[8] + Zeta[5, 3]] - B1];
     Rel = If[Exact1, 0, Module[{X = NumberOf[Re[C1], 40], Y = NumberOf[B1, 40]},
       If[NumericQ[X] && NumericQ[Y], N[Abs[X - Y]/(1 + Abs[Y]), 3], Infinity]]];
     OrderPass[K] = Exact1 || Rel < 10^-30;
     Print["MBEVAL_ORDER ", Name, " eps^", K, "  ", If[Exact1, "exact difference 0", "relative difference " <> ToString[Rel]],
       If[OrderPass[K], "  EQUAL", "  UNEQUAL"]]],
   {K, Lo, Hi}]];


(* ::Section:: *)
(*MBResum differential rows: the audited records*)


If[Kind === "u" && Method1 === "Resum",
  GArc[Words_, Sig_] := Module[{Suffixes, GName, Eqs, Ics, Fs, Sol, S0, Zs, Dz},
    Suffixes = DeleteDuplicates[Flatten[Map[Function[W, Table[Drop[W, J - 1], {J, Length[W]}]], Words], 1]];
    GName = AssociationThread[Suffixes, Table[Unique["gv"], {Length[Suffixes]}]];
    Zs[S_] := S + I*Sig*S*(1 - S)/2;
    Dz[S_] := 1 + I*Sig*(1 - 2*S)/2;
    S0 = 10^-30;
    Eqs = Map[Function[W, Module[{Rest1}, Rest1 = If[Length[W] === 1, 1, GName[Rest[W]][s]];
      GName[W]'[s] == Dz[s]*Rest1/(Zs[s] - First[W])]], Suffixes];
    Ics = Map[(GName[#][S0] == 0) &, Suffixes];
    Fs = Map[GName, Suffixes];
    Sol = NDSolve[Join[Eqs, Ics], Fs, {s, S0, 1}, WorkingPrecision -> 40, AccuracyGoal -> 30, PrecisionGoal -> 28,
      MaxSteps -> Infinity, Method -> "ExplicitRungeKutta"];
    AssociationThread[Words, Map[(GName[#][1] /. First[Sol]) &, Words]]];
  (* the records: every HarmonicSums H by GiNaC, H(c; x) = Prod over c != 0 of (-sign c) times G(c; x) (HarmonicSums
     integrates 1/(|c| - sign(c) t)); H whose letters lie on the path are left to the G-function ODE on an arc, as
     nbdiffcheck.wls.  (The N rule of H, used before for words containing the letter 1, is good to about 10^-9 only.) *)
  HValue[V_, U0_] := Module[{Hs, OnH, Words, Gs, Rules, Vx, Off, OffWords, GR},
    Vx = V /. Global`u -> U0;
    Off = Select[DeleteDuplicates[Cases[Vx, HoldPattern[HarmonicSums`H[__]], {0, Infinity}]],
      Function[H1, Module[{L = N[List @@ H1]},
        VectorQ[L, NumericQ] && AllTrue[L, Im[#] == 0 &] &&
          ! AnyTrue[Most[L], Function[C1, C1 != 0 && 0 < C1 < Last[L]]]]]];
    If[Off =!= {},
      OffWords = Map[PolyLogTools`G @@ (List @@ #) &, Off];
      GR = GRules[OffWords, 35];
      If[GR =!= $Failed,
        Vx = Vx /. Thread[Off -> MapThread[(Times @@ Map[If[TrueQ[# > 0], -1, 1] &, DeleteCases[Most[List @@ #1], 0]])*(#2 /. GR) &,
          {Off, OffWords}]]]];
    Hs = DeleteDuplicates[Cases[Vx, HoldPattern[HarmonicSums`H[__]], {0, Infinity}]];
    OnH = Select[Hs, (Last[List @@ #] === 1 && ! MemberQ[Most[List @@ #], 1] &&
       VectorQ[N[Most[List @@ #]], Im[#] == 0 &]) &];
    If[OnH =!= {},
      Words = Map[Most[List @@ #] &, OnH];
      Gs = GArc[Words, 1];
      Rules = Thread[OnH -> Map[(Times @@ Map[If[TrueQ[# > 0], -1, 1] &, DeleteCases[#, 0]])*Gs[#] &, Words]];
      Vx = Vx /. Rules];
    N[Vx, 20]];
  ZetaSym[V_] := V /. Q_Symbol /; StringMatchQ[SymbolName[Q], "z" ~~ DigitCharacter ..] :> Zeta[ToExpression[StringDrop[SymbolName[Q], 1]]];
  Idx = StringReplace[StringDrop[Name, -1], {"MB" -> ""}];
  Do[Module[{File1, GC, Ref, Rel},
     File1 = FileNameJoin[{RefDir, "MB" <> Idx <> "_diff_" <> StringReplace[ToString[K], "-" -> "m"] <> ".m"}];
     GC = Coefficient[Expand[GForm], Eps, K];
     If[! FileExistsQ[File1], Print["MBEVAL_ORDER ", Name, " eps^", K, "  no record"]; OrderPass[K] = False; Continue[]];
     (* the records write H without its context *)
     Ref = Block[{$ContextPath = Prepend[$ContextPath, "HarmonicSums`"]}, Get[File1]];
     (* without HarmonicSums loaded (a recheck) the bare H of the record is Global`H *)
     Ref = Ref /. Global`H -> HarmonicSums`H;
     Rel = Table[Module[{A = NumberOf[GC /. Global`u -> P, 30], B = HValue[ZetaSym[Ref], P]},
       If[NumericQ[A] && NumericQ[B], N[Abs[Re[A] - Re[B]]/Max[1, Abs[Re[B]]], 3], Infinity]], {P, {31/100, 7/100}}];
     OrderPass[K] = Max[Rel] < 10^-12;
     Print["MBEVAL_ORDER ", Name, " eps^", K, "  vs record at u = 31/100, 7/100: ", Rel, If[OrderPass[K], "  EQUAL", "  UNEQUAL"]]],
   {K, Lo, Hi}]];


(* ::Section:: *)
(*Standard and Subtraction differential rows: the records of both routes*)


If[Kind === "u" && Method1 =!= "Resum",
  Points = {1/5, 1/3, 3/7, 4/5};
  Std = Block[{$ContextPath = $ContextPath}, Quiet[Get[FileNameJoin[{ParentDirectory[ScriptDir], "reference", "mbu_results.m"}]]]; Global`MBuResults];
  Sub = Block[{$ContextPath = $ContextPath}, Quiet[Get[FileNameJoin[{ParentDirectory[ScriptDir], "reference", "mbu_subtraction_records.m"}]]]];
  Refs = Select[{{"Standard records", If[AssociationQ[Std], Lookup[Std, Name, None], None]},
    {"Subtraction records", If[AssociationQ[Sub], Lookup[Sub, Name, None], None]}}, AssociationQ[#[[2]]] &];
  (* every G by GiNaC at 45 digits (HPL of the records by its own N rule); the engine's evaluator only when that fails *)
  NumAt[X_, P_] := Module[{V},
    V = Quiet[NumberOf[X /. Global`u -> P, 40]];
    If[NumericQ[V], Return[V]];
    Return[MBParameter`Private`parameterNumericValue[X /. Global`u -> P, 600]]];
  Do[Module[{GC, Covered, Rels},
     GC = Coefficient[Expand[GForm], Eps, K];
     Covered = Select[Refs, KeyExistsQ[#[[2]]["Coefficients"], K] &];
     Rels = Map[Function[R1, Module[{RC},
       RC = R1[[2]]["Coefficients"][K] /. R1[[2]]["Parameter"] -> Global`u;
       If[TrueQ[Quiet[Expand[GC - RC] === 0]], 0,
         Max[Table[Module[{X = NumAt[GC, P], Y = NumAt[RC, P]},
           If[NumericQ[X] && NumericQ[Y] && Min[Precision[X], Precision[Y]] >= 25, N[Abs[X - Y]/Max[1, Abs[X], Abs[Y]], 3], Infinity]],
           {P, Points}]]]]], Covered];
     OrderPass[K] = Covered =!= {} && Max[Rels] < 10^-20;
     Print["MBEVAL_ORDER ", Name, " eps^", K, "  vs ", Map[First, Covered], " at u = 1/5, 1/3, 3/7, 4/5: ", Rels,
       If[OrderPass[K], "  EQUAL", "  UNEQUAL"]]],
   {K, Lo, Hi}]];


(* ::Section:: *)
(*Verdict*)


Pass = Pass && OrderPass =!= <||> && AllTrue[Values[OrderPass], TrueQ];
Quiet[CreateDirectory[RecordDir, CreateIntermediateDirectories -> True]];
Block[{$Context = "zzWrite`", $ContextPath = {"System`"}},
  Put[<|"Method" -> Method1, "Kind" -> Kind, "Name" -> Name, "Orders" -> {Lo, Hi}, "Seconds" -> Seconds, "Pass" -> Pass,
    "OrderPass" -> OrderPass, "Value" -> GForm|>, FileNameJoin[{RecordDir, Method1 <> "_" <> Name <> ".m"}]]];
Print["MBEVAL_RESULT ", Method1, " ", Kind, " ", Name, "  range {", Lo, ", ", Hi, "}  seconds ", Seconds, "  pass ", Pass,
  "  green ", Select[Keys[OrderPass], TrueQ[OrderPass[#]] &], "  ", DateString[]];
Exit[0];
