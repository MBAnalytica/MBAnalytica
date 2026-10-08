(* ::Package:: *)

(* ::Title:: *)
(*MBAnalytica: one output form for every method*)


(* ::Text:: *)
(*Read inside MBAnalytica`Private` by MBAnalytica.wl.  Every method returns its Laurent coefficients in multiple*)
(*polylogarithms G (PolyLogTools`G), Log, Zeta, Pi and EulerGamma: harmonic polylogarithms of HarmonicSums (MBResum)*)
(*and of HPL (the MB2MPL engine) and classical polylogarithms of the kinematic variables are rewritten as G.*)
(*With Complex -> False the real part is taken; with Complex -> True the full complex value is kept.*)


(* ::Section:: *)
(*Harmonic polylogarithms to G*)


(* the sign of a letter on the kinematic domain 0 < x < 1: proved by Refine, else the same sign at five points *)
LetterSign[Letter_, Vars_List] := Module[{Assumption, Refined, Points, Signs},
  If[Letter === 0, Return[0]];
  Assumption = And @@ Map[(0 < # < 1) &, Vars];
  Refined = Quiet[Refine[Sign[Letter], Assumption]];
  If[MemberQ[{1, -1}, Refined], Return[Refined]];
  If[Vars === {}, Return[$Failed]];
  Points = {1/7, 1/3, 1/2, 2/3, 6/7};
  Signs = Map[Function[Point1, Quiet[Sign[N[Letter /. Thread[Vars -> Point1]]]]], Points];
  If[Length[DeleteDuplicates[Signs]] === 1 && MemberQ[{1, -1}, First[Signs]], Return[First[Signs]]];
  Return[$Failed]];


(* HarmonicSums: H(c; x) integrates 1/(|c| - sign(c) t), that is -sign(c)/(t - c), so every letter c != 0 gives a
   factor -sign(c) relative to G(c; x); the letter 0 gives 1/t in both *)
HarmonicSumsHToG[Args_List, Vars_List] := Module[{Letters, Argument, Signs, Prefactor},
  Letters = Most[Args];
  Argument = Last[Args];
  If[AnyTrue[Letters, ListQ], Return[$Failed]];
  Signs = Map[LetterSign[#, Vars] &, DeleteCases[Letters, 0]];
  If[MemberQ[Signs, $Failed], Return[$Failed]];
  Prefactor = Times @@ Map[Minus, Signs];
  Return[Prefactor*(PolyLogTools`G @@ Append[Letters, Argument])]];


(* HPL m-notation {m1, ...}: m != 0 stands for |m| - 1 zeros and the letter Sign[m]; 0 stands for the letter 0 *)
HPLLetters[Indices_List] := Module[{Blocks},
  Blocks = Map[If[# === 0, {0}, Join[ConstantArray[0, Abs[#] - 1], {Sign[#]}]] &, Indices];
  Return[Flatten[Blocks]]];


(* HPL: the letters 1 and -1 integrate 1/(1 - t) and 1/(1 + t), so the letter 1 gives a factor -1 relative to G *)
HPLToG[Indices_List, Argument_] := Module[{Letters, Prefactor},
  If[! AllTrue[Indices, IntegerQ], Return[$Failed]];
  Letters = HPLLetters[Indices];
  Prefactor = (-1)^Count[Letters, 1];
  Return[Prefactor*(PolyLogTools`G @@ Append[Letters, Argument])]];


(* Li_n(z) = -G(0, ..., 0, 1; z) with n - 1 zeros *)
PolyLogToG[Order1_Integer, Argument_] := Module[{Letters},
  Letters = Append[ConstantArray[0, Order1 - 1], 1];
  Return[-(PolyLogTools`G @@ Append[Letters, Argument])]];


(* HoldPattern: HarmonicSums defines H[x] = 1, so an unheld H[Args__] would evaluate to the rule 1 :> ... *)
ToGBasis[Expr_, Vars_List] := Module[{Res, VarPattern},
  Res = Expr /. HoldPattern[HarmonicSums`H[Args__]] :>
    With[{Converted = HarmonicSumsHToG[{Args}, Vars]}, Converted /; Converted =!= $Failed];
  Res = Res /. HoldPattern[HPL`HPL[Indices_List, Argument_]] :>
    With[{Converted = HPLToG[Indices, Argument]}, Converted /; Converted =!= $Failed];
  If[Vars =!= {},
    VarPattern = Alternatives @@ Vars;
    Res = Res /. PolyLog[Order1_Integer?Positive, Argument_] /; ! FreeQ[Argument, VarPattern] :>
      PolyLogToG[Order1, Argument]];
  Return[Res]];


(* ::Section:: *)
(*Real part*)


FunctionPattern = _PolyLogTools`G | _HarmonicSums`H | _HPL`HPL | _PolyLog | _Log;


(* a number for an exact expression: N, then the engine's G evaluator, then PolyLogTools' ginsh interface *)
NumericValue[Expr_] := Module[{Value},
  Value = Quiet[Check[N[Expr, 20], $Failed]];
  If[NumberQ[Value], Return[Value]];
  If[DownValues[Global`gvN] =!= {},
    Value = Quiet[Check[Global`gvN[Expr], $Failed]];
    If[NumberQ[Value], Return[N[Value]]]];
  If[Names["PolyLogTools`Ginsh"] =!= {} && DownValues[PolyLogTools`Ginsh] =!= {},
    Value = Quiet[Check[TimeConstrained[PolyLogTools`Ginsh[Expr, {}], 120, $Failed], $Failed]];
    If[NumberQ[Value], Return[N[Value]]]];
  Return[$Failed]];


(* True when Cond holds on the whole domain 0 < x < 1: proved by Refine, else by Resolve within ten seconds *)
HoldsOnDomain[Cond_, Vars_List] := Module[{Assumption, Refined, Resolved},
  If[Vars === {}, Return[TrueQ[Quiet[Simplify[Cond]]]]];
  Assumption = And @@ Map[(0 < # < 1) &, Vars];
  Refined = Quiet[Refine[Cond, Assumption]];
  If[Refined === True, Return[True]];
  Resolved = Quiet[TimeConstrained[Resolve[ForAll[Vars, Assumption, Cond], Reals], 10, $Failed]];
  Return[Resolved === True]];


(* G(a1, ..., an; x) and H(a1, ..., an; x) integrate along [0, x] with poles at their letters, so they are real when
   x > 0 and no nonzero letter lies on the path: a/x < 0 or a/x >= 1, and a1/x != 1 for the outermost letter *)
OffPathQ[Letters_List, Argument_, Vars_List] := Module[{Positions, Conditions},
  If[AnyTrue[Letters, ListQ], Return[False]];
  If[! HoldsOnDomain[Argument > 0, Vars], Return[False]];
  Positions = Select[Range[Length[Letters]], Letters[[#]] =!= 0 &];
  Conditions = Map[If[# === 1, Letters[[#]]/Argument < 0 || Letters[[#]]/Argument > 1,
    Letters[[#]]/Argument < 0 || Letters[[#]]/Argument >= 1] &, Positions];
  Return[AllTrue[Conditions, HoldsOnDomain[#, Vars] &]]];


(* whether a function is real on the whole domain *)
RealFunctionQ[Function1_, Vars_List] := Module[{Args},
  Args = List @@ Function1;
  Which[
    MatchQ[Function1, _PolyLogTools`G | _HarmonicSums`H], Return[OffPathQ[Most[Args], Last[Args], Vars]],
    MatchQ[Function1, Log[_]], Return[HoldsOnDomain[First[Args] > 0, Vars]],
    MatchQ[Function1, PolyLog[_Integer?Positive, _]], Return[HoldsOnDomain[Last[Args] <= 1, Vars]],
    True, Return[False]]];


(* the real part with every function held as a real symbol: exact when every function is real on the domain;
   otherwise accepted only when it agrees with the real part of the full value at the probe points (or, without
   kinematic variables, at the single point) *)
RealPart[Expr_, Vars_List] := Module[{Functions, Holders, ToHolders, FromHolders, Held, Candidate, Points, Agree},
  Functions = DeleteDuplicates[Cases[Expr, FunctionPattern, {0, Infinity}]];
  Holders = Table[Symbol["MBAnalytica`Private`RealHolder" <> ToString[K]], {K, Length[Functions]}];
  ToHolders = Thread[Functions -> Holders];
  FromHolders = Thread[Holders -> Functions];
  Held = Expr /. ToHolders;
  Candidate = ComplexExpand[Re[Held]];
  Candidate = Candidate /. FromHolders;
  Candidate = Expand[Candidate];
  If[Functions === {}, Return[Candidate]];
  If[AllTrue[Functions, RealFunctionQ[#, Vars] &], Return[Candidate]];
  Points = If[Vars === {}, {{}}, Map[Function[Point1, Thread[Vars -> Point1]], {1/3, 5/7}]];
  Agree = AllTrue[Points, Function[Rules1, Module[{Whole, Part1},
    Whole = NumericValue[Expr /. Rules1];
    Part1 = NumericValue[Candidate /. Rules1];
    NumberQ[Whole] && NumberQ[Part1] && Abs[Re[Whole] - Part1] <= 10^-8 Max[1, Abs[Whole]]]]];
  If[Agree, Return[Candidate]];
  Return[$Failed]];


(* ::Section:: *)
(*Assembly*)


(* coefficients: an association order -> coefficient (or MBFailed[...]) *)
FinishCoefficient[Coef_, Vars_List, ComplexQ_] := Module[{Res, Real1},
  If[Head[Coef] === MBFailed, Return[Coef]];
  Res = ToGBasis[Coef, Vars];
  If[TrueQ[ComplexQ], Return[Res]];
  Real1 = RealPart[Res, Vars];
  If[Real1 === $Failed,
    Message[MBEvaluate::real];
    Return[Res]];
  Return[Real1]];


AssembleSeries[Coefficients_Association, Eps_] := Module[{Orders, Terms},
  Orders = Sort[Keys[Coefficients]];
  Terms = Map[Coefficients[#]*Eps^# &, Orders];
  Return[Total[Terms]]];
