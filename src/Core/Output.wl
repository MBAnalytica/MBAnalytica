(* ::Package:: *)

(* ::Title:: *)
(*MBAnalytica: one output form for every method*)


(* ::Text:: *)
(*Read inside MBAnalytica`Private` by MBAnalytica.wl.  Every method returns its Laurent coefficients in multiple*)
(*polylogarithms G (PolyLogTools`G), Log, Zeta, Pi and EulerGamma: harmonic polylogarithms of HarmonicSums (MBSymbolicSum)*)
(*and of HPL (the MBSymbolicInt engine) and classical polylogarithms of the kinematic variables are rewritten as G.*)
(*With Complex -> False the exact real part is taken (functions not proved real keep explicit Re and Im); with*)
(*Complex -> True the full complex value is kept.*)


(* ::Section:: *)
(*Harmonic polylogarithms to G*)


(* the sign of a letter on the kinematic domain 0 < x < 1, proved by Refine or by Resolve (HoldsOnDomain); $Failed when
   neither proves it, and the function then stays in its original form.  Points sampled on the diagonal prove nothing:
   1 - 2 x + y is positive at every diagonal point x = y but negative at (9/10, 1/10) *)
LetterSign[Letter_, Vars_List] := Module[{Assumption, Refined},
  If[Letter === 0, Return[0]];
  Assumption = And @@ Map[(0 < # < 1) &, Vars];
  Refined = Quiet[Refine[Sign[Letter], Assumption]];
  If[MemberQ[{1, -1}, Refined], Return[Refined]];
  If[HoldsOnDomain[Letter > 0, Vars], Return[1]];
  If[HoldsOnDomain[Letter < 0, Vars], Return[-1]];
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


(* a number for an exact expression: N, then the engine's G evaluator, then PolyLogTools' ginsh interface; all with
   PolyLogTools` on the context path, since N of a G reaches ginsh too and ginsh rejects a G written with its context *)
NumericValue[Expr_] := Block[{$ContextPath = Prepend[$ContextPath, "PolyLogTools`"]}, Module[{Value},
  Value = Quiet[Check[N[Expr, 20], $Failed]];
  If[NumberQ[Value], Return[Value, Module]];
  If[DownValues[Global`gvN] =!= {},
    Value = Quiet[Check[Global`gvN[Expr], $Failed]];
    If[NumberQ[Value], Return[N[Value], Module]]];
  If[Names["PolyLogTools`Ginsh"] =!= {} && DownValues[PolyLogTools`Ginsh] =!= {},
    Value = Quiet[Check[TimeConstrained[PolyLogTools`Ginsh[Expr, {}], 120, $Failed], $Failed]];
    If[NumberQ[Value], Return[N[Value], Module]]];
  Return[$Failed, Module]]];


(* True when Cond holds on the whole domain 0 < x < 1: proved by Refine, else by Resolve within ten seconds *)
DecideOnDomain[Cond_, Vars_List] := Module[{Assumption, Refined, Resolved},
  If[Vars === {}, Return[TrueQ[Quiet[Simplify[Cond]]]]];
  Assumption = And @@ Map[(0 < # < 1) &, Vars];
  Refined = Quiet[Refine[Cond, Assumption]];
  If[Refined === True, Return[True]];
  Resolved = Quiet[TimeConstrained[Resolve[ForAll[Vars, Assumption, Cond], Reals], 10, $Failed]];
  Return[Resolved === True]];


(* the decided conditions, keyed by {Cond, Vars}: the same letters recur across thousands of G functions, and each
   undecided Resolve costs its ten seconds again *)
HoldsOnDomainCache = <||>;
HoldsOnDomain[Cond_, Vars_List] := Module[{CacheKey, Res},
  CacheKey = {Cond, Vars};
  (* KeyExistsQ, not Lookup: Lookup reads a list as a list of keys, so the cache never answered and no condition was
     ever decided *)
  If[KeyExistsQ[HoldsOnDomainCache, CacheKey], Return[HoldsOnDomainCache[CacheKey]]];
  Res = DecideOnDomain[Cond, Vars];
  HoldsOnDomainCache[CacheKey] = Res;
  Return[Res]];


(* G(a1, ..., an; x) and H(a1, ..., an; x) integrate along [0, x] with poles at their letters, so they are real when
   no nonzero letter lies on the path, a/x < 0 or a/x >= 1 (a1/x != 1 for the outermost letter), and either x > 0, or
   x < 0 with a nonzero last letter: a trailing zero brings Log[x], which is complex for x < 0 *)
OffPathQ[Letters_List, Argument_, Vars_List] := Module[{Positions, Conditions, PositiveQ, NegativeQ},
  If[AnyTrue[Letters, ListQ], Return[False]];
  If[Letters === {}, Return[True]];
  PositiveQ = HoldsOnDomain[Argument > 0, Vars];
  NegativeQ = ! PositiveQ && Last[Letters] =!= 0 && HoldsOnDomain[Argument < 0, Vars];
  If[! PositiveQ && ! NegativeQ, Return[False]];
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


(* a product of the real symbols to integer powers *)
RealMonomialQ[Factor1_, RealPattern_] := Module[{Fs},
  Fs = If[Head[Factor1] === Times, List @@ Factor1, {Factor1}];
  Return[AllTrue[Fs, MatchQ[#, RealPattern | Power[RealPattern, _Integer]] &]]];


(* ComplexExpand[Re[Held]] term by term: for a term c m with m a product of the real symbols to integer powers the
   real part is Re[c] m, with ComplexExpand[Re[c]] taken once per distinct constant c; any other term goes through
   ComplexExpand as before.  The same result as ComplexExpand of the whole sum, which on a three-site cosmological
   coefficient (13802 terms) took longer than four minutes.  The complex symbols, those of the functions not proved
   real, are passed to ComplexExpand, so that their real and imaginary parts stay explicit *)
ComplexSymbolsIn[Expr_, ComplexSet_Association] := DeleteDuplicates[Cases[Expr, S1_Symbol /; KeyExistsQ[ComplexSet, S1],
  {0, Infinity}, Heads -> True]];
RealPartByTerms[Held_, RealSymbols_List, ComplexSymbols_List] := Module[{Expanded, Terms, RealPattern, ComplexSet,
    ConstantRe, TermRe},
  Expanded = Expand[Held];
  Terms = If[Head[Expanded] === Plus, List @@ Expanded, {Expanded}];
  RealPattern = Alternatives @@ RealSymbols;
  ComplexSet = AssociationThread[ComplexSymbols, True];
  ConstantRe = <||>;
  TermRe[Term_] := Module[{Fs, Constant1, Rest},
    Fs = If[Head[Term] === Times, List @@ Term, {Term}];
    Constant1 = Times @@ Select[Fs, FreeQ[#, RealPattern] &];
    Rest = Times @@ Select[Fs, ! FreeQ[#, RealPattern] &];
    If[! RealMonomialQ[Rest, RealPattern], Return[ComplexExpand[Re[Term], ComplexSymbolsIn[Term, ComplexSet]], Module]];
    If[! KeyExistsQ[ConstantRe, Constant1],
      ConstantRe[Constant1] = ComplexExpand[Re[Constant1], ComplexSymbolsIn[Constant1, ComplexSet]]];
    Return[ConstantRe[Constant1] Rest, Module]];
  Return[Total[Map[TermRe, Terms]]]];


(* seconds for the reality proofs of all functions together, and for each numeric probe: a function whose proof has
   not finished by then counts as not proved real, and a probe that has not finished as not evaluated, so a large
   coefficient keeps explicit real and imaginary parts instead of stalling (a three-site cosmological sector with
   tens of thousands of G functions sat here for hours) *)
RealPartBudget = 300;


(* whether a function is proved real on the domain before the deadline *)
ProvedRealQ[Function1_, Vars_List, Deadline_] := Module[{Left},
  Left = Deadline - AbsoluteTime[];
  If[Left <= 0, Return[False]];
  Return[TrueQ[TimeConstrained[RealFunctionQ[Function1, Vars], Left, False]]]];


(* Re and Im of a logarithm: Log of the modulus and the argument, refined on the domain *)
LogParts[Expr_, Vars_List] := Module[{Assumption, Res},
  Assumption = And @@ Map[(0 < # < 1) &, Vars];
  Res = Expr /. {Re[Log[A1_]] :> Log[Abs[A1]], Im[Log[A1_]] :> Arg[A1]};
  Res = Res /. {Abs[A1_] :> Quiet[Refine[Abs[A1], Assumption]], Arg[A1_] :> Quiet[Refine[Arg[A1], Assumption]]};
  Return[Res]];


(* the exact real part on the whole domain 0 < x < 1: every function proved real there (RealFunctionQ) is held as a
   real symbol, every other one as a complex symbol, whose real and imaginary parts stay explicit, Re[G[...]] and
   Im[G[...]] (for a logarithm, Log of the modulus and the argument).  No sampled point decides: I Log[1 - 2 x + y]
   is real at every diagonal point but has the real part -Pi at (9/10, 1/10), and its result is -Arg[1 - 2 x + y].
   The two numeric probes only check the construction; a disagreement returns $Failed, and the full complex value
   is kept *)
RealPart[Expr_, Vars_List] := Module[{Functions, Deadline, RealQ, Holders, RealHolders, ComplexHolders, ToHolders,
    FromHolders, Held, Candidate, Points, Probes},
  Functions = DeleteDuplicates[Cases[Expr, FunctionPattern, {0, Infinity}]];
  Deadline = AbsoluteTime[] + RealPartBudget;
  RealQ = Map[ProvedRealQ[#, Vars, Deadline] &, Functions];
  Holders = Table[Symbol["MBAnalytica`Private`RealHolder" <> ToString[K]], {K, Length[Functions]}];
  RealHolders = Pick[Holders, RealQ];
  ComplexHolders = Pick[Holders, RealQ, False];
  ToHolders = Dispatch[Thread[Functions -> Holders]];
  FromHolders = Dispatch[Thread[Holders -> Functions]];
  Held = Expr /. ToHolders;
  Candidate = RealPartByTerms[Held, Join[RealHolders, Vars], ComplexHolders];
  Candidate = Candidate /. FromHolders;
  Candidate = LogParts[Candidate, Vars];
  Candidate = Expand[Candidate];
  If[Functions === {}, Return[Candidate]];
  Points = If[Vars === {}, {{}}, Map[Function[Point1, Thread[Vars -> Point1]], {1/3, 5/7}]];
  Probes = Map[Function[Rules1, Module[{Whole, Part1},
    (* Quiet: a probe point on which a letter vanishes (u1 = u2) gives Power::infy, and such a probe is just not evaluated *)
    Whole = TimeConstrained[Quiet[NumericValue[Expr /. Rules1]], RealPartBudget, $Failed];
    Part1 = TimeConstrained[Quiet[NumericValue[Candidate /. Rules1]], RealPartBudget, $Failed];
    Which[
      ! NumberQ[Whole] || ! NumberQ[Part1], Missing[],
      Abs[Re[Whole] - Part1] <= 10^-8 Max[1, Abs[Whole]], True,
      True, False]]], Points];
  If[MemberQ[Probes, False], Return[$Failed]];
  Return[Candidate]];


(* ::Section:: *)
(*Assembly*)


(* the output class of a coefficient: G, Log, Zeta, Pi, EulerGamma, the constants of HPL (MZV and the irreducible
   constants HPLs6, HPLs7a, ..., HPLs8a = zeta(5,3) of weight 8, ...), Re and Im, and rational functions of the kinematic
   variables.  What remains after the rewriting as G outside this class means that a step did not finish: an HPL that
   has no G form (HPL[{1}, 1] diverges), a symbol of a private context (HypExp`Private`HPL1, the leftover of an expansion
   at unit argument), an unevaluated hypergeometric function or summation *)
OutsideOutputClass[Coef_] := Module[{Atoms},
  Atoms = Cases[{Coef}, S1_Symbol :> S1, {0, Infinity}, Heads -> True];
  Return[DeleteDuplicates[Select[Atoms, Function[S1, With[{Ctx = Context[S1], Name1 = SymbolName[S1]},
    StringEndsQ[Ctx, "Private`"] ||
      (Ctx === "HPL`" && ! (Name1 === "MZV" || StringStartsQ[Name1, "HPLs"])) ||
      MemberQ[{"HypExp`", "Sigma`", "EvaluateMultiSums`"}, Ctx] ||
      (Ctx === "System`" && MemberQ[{"Hypergeometric0F1", "Hypergeometric1F1", "Hypergeometric2F1", "HypergeometricPFQ",
        "AppellF1", "AppellF2", "AppellF3", "AppellF4", "Sum", "Indeterminate", "ComplexInfinity", "DirectedInfinity"}, Name1])]]]]]];


(* a coefficient of one method that is not in the output class is not exact: it is reported as MBFailed, so that the
   next method of Method -> Automatic is tried for this order *)
CheckOutputClass[Coef_, Method1_String, Vars_List] := Module[{Outside},
  If[Head[Coef] === MBFailed, Return[Coef]];
  Outside = OutsideOutputClass[ToGBasis[Coef, Vars]];
  If[Outside === {}, Return[Coef]];
  Return[MBFailed[{Method1, "functions outside the output class: " <> ToString[Take[Outside, UpTo[3]], InputForm]}]]];


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
