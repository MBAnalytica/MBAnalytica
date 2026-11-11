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


(* the domains of the kinematic variables: DerivationDomain, on which the method solved the integral, where the letters
   of the harmonic polylogarithms take their signs, and RealPartDomain, on which Complex -> False takes the real part.
   True means every real value.  MBEvaluate sets both for each call *)
DerivationDomain = True;
RealPartDomain = True;


(* a domain as an assumption on the variables: True gives every real value *)
DomainAssumption[Vars_List, Domain1_] := If[Domain1 === True, And @@ Map[Element[#, Reals] &, Vars],
  Domain1 && (And @@ Map[Element[#, Reals] &, Vars])];


(* the sign of a letter on the derivation domain, proved by Refine or by Resolve (HoldsOnDomain); $Failed when neither
   proves it, and the function then stays in its original form.  Points sampled on the diagonal prove nothing:
   1 - 2 x + y is positive at every diagonal point x = y but negative at (9/10, 1/10) *)
LetterSign[Letter_, Vars_List] := Module[{Assumption, Refined},
  If[Letter === 0, Return[0]];
  Assumption = DomainAssumption[Vars, DerivationDomain];
  Refined = Quiet[Refine[Sign[Letter], Assumption]];
  If[MemberQ[{1, -1}, Refined], Return[Refined]];
  If[HoldsOnDomain[Letter > 0, Vars, DerivationDomain], Return[1]];
  If[HoldsOnDomain[Letter < 0, Vars, DerivationDomain], Return[-1]];
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


(* True when Cond holds on the whole domain: proved by Refine, else by Resolve within ten seconds.  For every real value
   (Domain1 True) Refine alone decides: a function of the kinematic variables is then hardly ever real everywhere, and a
   Resolve over the whole real space for each of the thousands of letters of a cosmological coefficient ran into its
   ten seconds every time (the light double exchange of Examples.nb took more than an hour instead of twenty minutes);
   a function that is not proved real keeps Re[...] and Im[...], which is exact *)
DecideOnDomain[Cond_, Vars_List, Domain1_] := Module[{Assumption, Refined, Resolved},
  If[Vars === {}, Return[TrueQ[Quiet[Simplify[Cond]]]]];
  Assumption = DomainAssumption[Vars, Domain1];
  Refined = Quiet[Refine[Cond, Assumption]];
  If[Refined === True, Return[True]];
  If[Domain1 === True, Return[False]];
  Resolved = Quiet[TimeConstrained[Resolve[ForAll[Vars, Assumption, Cond], Reals], 10, $Failed]];
  Return[Resolved === True]];


(* the decided conditions, keyed by {Cond, Vars, Domain1}: the same letters recur across thousands of G functions, and
   each undecided Resolve costs its ten seconds again *)
HoldsOnDomainCache = <||>;
HoldsOnDomain[Cond_, Vars_List] := HoldsOnDomain[Cond, Vars, RealPartDomain];
HoldsOnDomain[Cond_, Vars_List, Domain1_] := Module[{CacheKey, Res},
  CacheKey = {Cond, Vars, Domain1};
  (* KeyExistsQ, not Lookup: Lookup reads a list as a list of keys, so the cache never answered and no condition was
     ever decided *)
  If[KeyExistsQ[HoldsOnDomainCache, CacheKey], Return[HoldsOnDomainCache[CacheKey]]];
  Res = DecideOnDomain[Cond, Vars, Domain1];
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
    If[! RealMonomialQ[Rest, RealPattern], Return[ExpandedRe[Term, ComplexSet], Module]];
    If[! KeyExistsQ[ConstantRe, Constant1], ConstantRe[Constant1] = ExpandedRe[Constant1, ComplexSet]];
    Return[ConstantRe[Constant1] Rest, Module]];
  Return[Total[Map[TermRe, Terms]]]];


(* Re of a term: with at most one complex function factor its real and imaginary parts are written out, Re[c G] =
   Re[c] Re[G] - Im[c] Im[G]; a product of several complex functions stays inside Re[...], since writing out
   Re[G1 G2 ... Gk] gives 2^(k-1) products, which made the real part of the light double exchange three times as large
   and its numerical evaluation an hour long *)
ComplexFactorCount[Term_, ComplexSet_Association] := Module[{Fs},
  Fs = If[Head[Term] === Times, List @@ Term, {Term}];
  Return[Total[Map[Function[F, Which[
      MatchQ[F, S1_Symbol /; KeyExistsQ[ComplexSet, S1]], 1,
      MatchQ[F, Power[S1_Symbol, N1_Integer] /; KeyExistsQ[ComplexSet, S1]], Abs[F[[2]]],
      FreeQ[F, S1_Symbol /; KeyExistsQ[ComplexSet, S1]], 0,
      True, 2]], Fs]]]];
ExpandedRe[Term_, ComplexSet_Association] := If[ComplexFactorCount[Term, ComplexSet] <= 1,
  ComplexExpand[Re[Term], ComplexSymbolsIn[Term, ComplexSet]], Re[Term]];


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


(* Re and Im of a logarithm: Log of the modulus and the argument, refined on the domain of the real part *)
LogParts[Expr_, Vars_List] := Module[{Assumption, Res},
  Assumption = DomainAssumption[Vars, RealPartDomain];
  Res = Expr /. {Re[Log[A1_]] :> Log[Abs[A1]], Im[Log[A1_]] :> Arg[A1]};
  Res = Res /. {Abs[A1_] :> Quiet[Refine[Abs[A1], Assumption]], Arg[A1_] :> Quiet[Refine[Arg[A1], Assumption]]};
  Return[Res]];


(* the exact real part on the whole domain of the real part (RealPartDomain: the one given with ParameterAssumptions,
   else every real value): every function proved real there (RealFunctionQ) is held as a real symbol, every other one
   as a complex symbol, whose real and imaginary parts stay explicit, Re[G[...]] and Im[G[...]] (for a logarithm, Log
   of the modulus and the argument).  No sampled point decides: I Log[1 - 2 x + y] is real at every diagonal point but
   has the real part -Pi at (9/10, 1/10), and its result is -Arg[1 - 2 x + y].  The two numeric probes, points of the
   domain, only check the construction; a disagreement returns $Failed, and the full complex value is kept *)
(* a coefficient given with the convergence region of its series: the real part of its value, under the same
   condition.  Taken as one term, the whole value went into a single Re[...] *)
RealPart[ConditionalExpression[Value1_, Cond_], Vars_List] := Module[{Part1},
  Part1 = RealPart[Value1, Vars];
  If[Part1 === $Failed, Return[$Failed]];
  Return[ConditionalExpression[Part1, Cond]]];
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
  Points = If[Vars === {}, {{}}, Map[Thread[Vars -> #] &, DomainProbes[RealPartDomain, Vars]]];
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
        "AppellF1", "AppellF2", "AppellF3", "AppellF4", "Sum", "NSum", "Indeterminate", "ComplexInfinity", "DirectedInfinity",
        (* an unfinished expansion, integration or limit (audit of 2026-11-09: an accepted coefficient contained
           SeriesData and Re[Gamma[e]] of the regulator, and Inactive[Integrate] passed the class check) *)
        "SeriesData", "Series", "SeriesCoefficient", "O", "Integrate", "NIntegrate", "Inactive", "Inactivate", "Limit",
        "Derivative", "Hold", "HoldForm", "HoldComplete", "Unevaluated"}, Name1])]]]]]];


(* a coefficient of one method that is not in the output class is not exact: it is marked as NotEvaluated, so that the
   next method of Method -> Automatic is tried for this order.  A Laurent coefficient is free of the regulator: one
   that still contains it, or a ConditionalExpression whose value does, is not evaluated either *)
CheckOutputClass[Coef_, Method1_String, Vars_List] := CheckOutputClass[Coef, Method1, Vars, None];
CheckOutputClass[Coef_, Method1_String, Vars_List, Eps_] := Module[{Outside, Value1},
  If[Head[Coef] === NotEvaluated, Return[Coef]];
  Value1 = If[Head[Coef] === ConditionalExpression, First[Coef], Coef];
  If[Eps =!= None && ! FreeQ[Value1, Eps],
    Return[NotEvaluated[{Method1, "the coefficient still depends on the regulator"}]]];
  Outside = OutsideOutputClass[ToGBasis[Coef, Vars]];
  If[Outside === {}, Return[Coef]];
  Return[NotEvaluated[{Method1, "functions outside the output class: " <> ToString[Take[Outside, UpTo[3]], InputForm]}]]];


(* after the variables of the method are taken back to those of the user, the arguments of the functions and the rational
   coefficients are brought together: Log[1 - 2 (1/2 + x)] becomes Log[-2 x] *)
TidyArguments[Expr_] := Expr /. {
  Log[A_] :> Log[Together[A]],
  PolyLog[N1_, A_] :> PolyLog[N1, Together[A]],
  HoldPattern[PolyLogTools`G[Args__]] :> (PolyLogTools`G @@ Map[Together, {Args}])};
TidyMapped[Expr_ConditionalExpression] := ConditionalExpression[TidyMapped[First[Expr]], TidyArguments[Expr[[2]]]];
TidyMapped[Expr_] := Module[{Res, Functions},
  Res = TidyArguments[Expr];
  Functions = DeleteDuplicates[Cases[Res, FunctionPattern, {0, Infinity}]];
  Res = Collect[Expand[Res], Functions, Together];
  Return[Res]];


(* two points of the domain for the probes of the real part: 1/3 and 5/7 for every variable when they lie in it,
   else other exact points *)
DomainProbes[Domain1_, Vars_List] := Module[{Candidates, Found, Width},
  Candidates = {1/3, 5/7, 1/5, 3/4, 2/3, 1/7, 3/2, 7/3, 4, -1/3, -5/7, -3/2, -7/3};
  Found = Select[Map[ConstantArray[#, Length[Vars]] &, Candidates],
    TrueQ[Quiet[Domain1 /. Thread[Vars -> #]]] &];
  If[Length[Found] < 2,
    Width = Which[Length[Vars] <= 3, 6, Length[Vars] <= 6, 3, True, 2];
    Found = Join[Found, Select[Tuples[Take[Candidates, Width], Length[Vars]],
      TrueQ[Quiet[Domain1 /. Thread[Vars -> #]]] &]]];
  Return[Take[DeleteDuplicates[Found], UpTo[2]]]];


(* coefficients: an association order -> coefficient (or NotEvaluated[...]).  The harmonic polylogarithms become G on
   the derivation domain, then Back takes the variables of the method to those of the user (the affine maps of
   MBEvaluate), and the real part is taken on RealPartDomain *)
FinishCoefficient[Coef_, Vars_List, ComplexQ_] := FinishCoefficient[Coef, Vars, ComplexQ, {}];
FinishCoefficient[Coef_, Vars_List, ComplexQ_, Back_List] := Module[{Res, Real1},
  If[Head[Coef] === NotEvaluated, Return[Coef]];
  Res = ToGBasis[Coef, Vars];
  If[Back =!= {}, Res = TidyMapped[Res /. Back]];
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
