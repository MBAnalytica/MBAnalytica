(* ::Package:: *)
(* OneFoldHyp.wl: a direct summation route of the SymbolicSum method for one-fold MB integrals of hypergeometric type,
     PreFac(eps) Int dz/(2 pi i) Gamma(-z) Prod_i Gamma(m_i + c_i eps + z)^k_i X^z,
   with one kinematic variable X, integers m_i, rationals c_i, Sum_i k_i = 1 (balanced: the pFp-1 class) and a straight
   contour that separates the poles of Gamma(-z) from all others (every numerator argument m + c eps has m >= 1, or m = 0
   and c > 0). Closing the contour to the right gives the residue series
     F = PreFac Prod_i Gamma(m_i + c_i eps)^k_i Sum_n Y^n/n! Prod_i ((m_i + c_i eps)_n)^k_i,   Y = -X.
   The Pochhammer symbols are expanded in eps in terms of harmonic sums of the summation index, products of harmonic sums
   are reduced to nested sums by the quasi-shuffle, and every sum Sum_nu Y^nu R(nu) S_w(nu), R rational, is mapped to
   G-functions of Y with the letters 0 and 1: the generating function Sum_nu T^nu S_w(nu) = S_w(T; Infinity)/(1 - T),
   the operator T d/dT for the polynomial part of R and Int_0^T dT'/T' for its poles. The first terms of the series, in
   which a Pochhammer symbol of a non-positive parameter has no zero yet, are added exactly. The result is accepted only
   if its Taylor coefficients in X agree exactly with those of the series itself, order by order in eps, through
   X^OneFoldHypCheckTerms. The G-functions are returned at -X as PolyLogTools`G[letters..., -X].
   OneFoldHypExpand[Integrand, Eps, {Lo, Hi}] returns <|Order -> Coefficient|> for Lo..Hi, or $Failed. *)

BeginPackage["MBAnalytica`OneFoldHyp`"];

OneFoldHypExpand::usage = "OneFoldHypExpand[Integrand, Eps, {Lo, Hi}] expands a one-fold MB integral of hypergeometric type through Eps^Hi from its residue series, or returns $Failed outside its class or when the exact check of its Taylor coefficients fails.";
OneFoldHypQ::usage = "OneFoldHypQ[Integrand, Eps] parses a one-fold MB integrand of hypergeometric type into <|\"Prefactor\", \"Gammas\", \"X\", \"z\"|>, or returns $Failed.";
OneFoldHypCheckTerms::usage = "OneFoldHypCheckTerms is the number of Taylor coefficients in the kinematic variable that OneFoldHypExpand compares exactly with the series (default 30).";

Begin["`Private`"];

OneFoldHypCheckTerms = 30;


(* ::Section:: *)
(*Parsing*)


FactorList1[Expr_] := If[Head[Expr] === Times, List @@ Expr, {Expr}];


SumList[Expr_] := If[Head[Expr] === Plus, List @@ Expr, {Expr}];


(* one factor Gamma[Arg1]^Exp1: {Slope, IntPart, EpsCoef, Exp1} with Arg1 = Slope z + IntPart + EpsCoef Eps, or $Failed *)
GammaFactor[Fac_, IntVar_, Eps_] := Module[{Arg1, Exp1, Slope, Offset, IntPart, EpsCoef},
  If[Head[Fac] === Power, Arg1 = Fac[[1, 1]]; Exp1 = Fac[[2]], Arg1 = Fac[[1]]; Exp1 = 1];
  If[! PolynomialQ[Arg1, {IntVar, Eps}], Return[$Failed]];
  If[Exponent[Arg1, IntVar] =!= 1 || Exponent[Arg1, Eps] > 1, Return[$Failed]];
  Slope = Coefficient[Arg1, IntVar];
  If[! FreeQ[Slope, Eps], Return[$Failed]];
  Offset = Expand[Arg1 - Slope IntVar];
  IntPart = Offset /. Eps -> 0;
  EpsCoef = Coefficient[Offset, Eps];
  If[! IntegerQ[IntPart] || ! MatchQ[EpsCoef, _Integer | _Rational], Return[$Failed]];
  Return[{Slope, IntPart, EpsCoef, Exp1}]];


OneFoldHypQ[Integrand_, Eps_Symbol] := Module[
  {Factors, GammaArgs, IntVars, IntVar, GammaList = {}, KinList = {}, PreFac = 1, MinusCount = 0, Parsed, Good = True},
  Factors = FactorList1[Integrand];
  GammaArgs = Cases[Integrand, Gamma[Arg1_] :> Arg1, Infinity];
  IntVars = Union[Cases[GammaArgs, Sym_Symbol /; Sym =!= Eps && ! NumericQ[Sym], {0, Infinity}]];
  If[Length[IntVars] =!= 1, Return[$Failed]];
  IntVar = First[IntVars];
  Do[
    Which[
      FreeQ[Fac, IntVar],
        PreFac = PreFac Fac,
      MatchQ[Fac, Gamma[_] | Power[Gamma[_], _Integer]],
        Parsed = GammaFactor[Fac, IntVar, Eps];
        Which[
          Parsed === $Failed, Good = False,
          Parsed[[1]] === -1 && Parsed[[2]] === 0 && Parsed[[3]] === 0 && Parsed[[4]] === 1, MinusCount = MinusCount + 1,
          Parsed[[1]] === 1, AppendTo[GammaList, Rest[Parsed]],
          True, Good = False],
      MatchQ[Fac, Power[_, _]] && Fac[[2]] === IntVar && FreeQ[Fac[[1]], IntVar | Eps],
        AppendTo[KinList, Fac[[1]]],
      True,
        Good = False],
    {Fac, Factors}];
  If[! Good || MinusCount =!= 1 || Length[KinList] =!= 1, Return[$Failed]];
  (* balanced: the Gamma functions of +z balance Gamma(-z), so that the coefficients of the series are rational in the
     summation index *)
  If[Total[GammaList[[All, 3]]] =!= 1, Return[$Failed]];
  (* the series contour: every numerator pole to the left of Re z = 0- for small Eps > 0; and no denominator Gamma of a
     non-positive integer, which would make the series undefined *)
  Do[
    If[Gam[[3]] > 0 && ! (Gam[[1]] >= 1 || (Gam[[1]] == 0 && Gam[[2]] > 0)), Good = False];
    If[Gam[[3]] < 0 && Gam[[1]] <= 0 && Gam[[2]] == 0, Good = False],
    {Gam, GammaList}];
  If[! Good, Return[$Failed]];
  Return[<|"Prefactor" -> PreFac, "Gammas" -> GammaList, "X" -> First[KinList], "z" -> IntVar|>]];


(* ::Section:: *)
(*Nested sums*)


(* the quasi-shuffle of S-sums with inclusive nesting, as lists of {Coefficient, Word} *)
QuasiShuffle[{}, Word2_List] := {{1, Word2}};
QuasiShuffle[Word1_List, {}] := {{1, Word1}};
QuasiShuffle[{A1_, U1___}, {B1_, V1___}] := QuasiShuffle[{A1, U1}, {B1, V1}] = Module[{First1, Second1, Third1},
  First1 = Map[{#[[1]], Prepend[#[[2]], A1]} &, QuasiShuffle[{U1}, {B1, V1}]];
  Second1 = Map[{#[[1]], Prepend[#[[2]], B1]} &, QuasiShuffle[{A1, U1}, {V1}]];
  Third1 = Map[{-#[[1]], Prepend[#[[2]], A1 + B1]} &, QuasiShuffle[{U1}, {V1}]];
  Join[First1, Second1, Third1]];


(* the pairs {Coefficient, Word} with equal words combined *)
MergeWords[Pairs_List] := Module[{Groups, Merged},
  Groups = GatherBy[Pairs, Last];
  Merged = Map[{Together[Total[#[[All, 1]]]], #[[1, 2]]} &, Groups];
  Return[Select[Merged, #[[1]] =!= 0 &]]];


(* S_J(Nu + Shift) = S_J(Nu) + a rational function of Nu, for Shift >= -1 *)
ShiftHarmonic[J_, Shift_Integer, Nu_] := Which[
  Shift == 0, {{1, {J}}},
  Shift > 0, {{1, {J}}, {Sum[1/(Nu + L1)^J, {L1, 1, Shift}], {}}},
  True, {{1, {J}}, {-Sum[1/(Nu - L1)^J, {L1, 0, -Shift - 1}], {}}}];


(* a product of S_{J_r}(Nu + Shift_r) as a list of {rational function of Nu, Word} *)
HarmonicProduct[Factors_List, Nu_] := Module[{Acc = {{1, {}}}, Terms},
  Do[
    Terms = Table[
      Map[{P1[[1]] Q1[[1]] #[[1]], #[[2]]} &, QuasiShuffle[P1[[2]], Q1[[2]]]],
      {P1, Acc}, {Q1, ShiftHarmonic[Fac[[1]], Fac[[2]], Nu]}];
    Terms = Flatten[Terms, 2];
    Acc = MergeWords[Terms],
    {Fac, Factors}];
  Return[Acc]];


(* ::Section:: *)
(*Generating functions: pairs {R(T), Word} for R(T) G(Word; T)*)


(* S_w(T; Infinity) = Sum_{i1 >= i2 >= ...} T^i1 Prod 1/i^w as Li-type G-functions: each equality merges adjacent
   indices, and Li_{a1..ak}(T) = (-1)^k G(0^(a1-1), 1, ..., 0^(ak-1), 1; T) *)
LiFromS[Word_List] := Module[{Len = Length[Word], Cuts, Pairs},
  Cuts = Tuples[{False, True}, Max[Len - 1, 0]];
  Pairs = Map[
    Function[Cut, Module[{Blocks = {}, Current = Word[[1]], Letters},
      Do[If[Cut[[I1]], Current = Current + Word[[I1 + 1]], AppendTo[Blocks, Current]; Current = Word[[I1 + 1]]], {I1, 1, Len - 1}];
      AppendTo[Blocks, Current];
      Letters = Flatten[Map[Append[ConstantArray[0, # - 1], 1] &, Blocks]];
      {(-1)^Length[Blocks], Letters}]],
    Cuts];
  Return[MergeWords[Pairs]]];


(* B_w(T) = Sum_{Nu >= 1} T^Nu S_w(Nu) *)
GenFunction[{}, T_] := {{T/(1 - T), {}}};
GenFunction[Word_List, T_] := Map[{#[[1]]/(1 - T), #[[2]]} &, LiFromS[Word]];


(* T d/dT of a list of pairs *)
ThetaOp[Pairs_List, T_] := Module[{Terms},
  Terms = Map[
    Function[P1, Join[
      {{T D[P1[[1]], T], P1[[2]]}},
      If[P1[[2]] === {}, {}, {{T P1[[1]]/(T - First[P1[[2]]]), Rest[P1[[2]]]}}]]],
    Pairs];
  Terms = Flatten[Terms, 1];
  Return[MergeWords[Terms]]];


(* the pole and its order of a denominator with one linear factor in T *)
PoleOf[Den_, T_] := Module[{Factors, Linear, Root1},
  Factors = FactorList[Den];
  Linear = Select[Factors, ! FreeQ[#[[1]], T] &];
  If[Length[Linear] =!= 1 || Exponent[Linear[[1, 1]], T] =!= 1, Throw[$Failed, "OneFoldHyp"]];
  Root1 = Solve[Linear[[1, 1]] == 0, T][[1, 1, 2]];
  Return[{Root1, Linear[[1, 2]]}]];


(* Int_0^T R(T') G(Word; T') dT' for the words used here: letters 0 and 1, the last letter 1, or the empty word *)
IntegrateG[R_, Word_List, T_] := Module[{Tog, Parts, Out = {}},
  If[Word =!= {} && Last[Word] === 0, Throw[$Failed, "OneFoldHyp"]];
  Tog = Together[R];
  Parts = Apart[Tog, T];
  Parts = SumList[Parts];
  Do[Module[{Part1, Num, Den, Coef, Pole, Order1},
      Part1 = Together[Term];
      Num = Numerator[Part1];
      Den = Denominator[Part1];
      Which[
        FreeQ[Den, T] && PolynomialQ[Num, T],
          Do[
            Coef = Coefficient[Num, T, Power1]/Den;
            If[Coef =!= 0, Out = Join[Out, IntegratePower[Coef, Power1, Word, T]]],
            {Power1, 0, Exponent[Num, T]}],
        FreeQ[Num, T],
          {Pole, Order1} = PoleOf[Den, T];
          Coef = Simplify[Num/(Den/(T - Pole)^Order1)];
          If[! FreeQ[Coef, T], Throw[$Failed, "OneFoldHyp"]];
          Out = Join[Out, IntegratePole[Coef, Pole, Order1, Word, T]],
        True,
          Throw[$Failed, "OneFoldHyp"]]],
    {Term, Parts}];
  Return[MergeWords[Out]]];


(* Int_0^T Coef T'^Power1 G(Word; T') dT', by parts *)
IntegratePower[Coef_, Power1_, {}, T_] := {{Coef T^(Power1 + 1)/(Power1 + 1), {}}};
IntegratePower[Coef_, Power1_, Word_List, T_] := Module[{Boundary, Rest1},
  Boundary = {{Coef T^(Power1 + 1)/(Power1 + 1), Word}};
  Rest1 = IntegrateG[Coef T^(Power1 + 1)/((Power1 + 1) (T - First[Word])), Rest[Word], T];
  Rest1 = Map[{-#[[1]], #[[2]]} &, Rest1];
  Return[Join[Boundary, Rest1]]];


(* Int_0^T Coef G(Word; T')/(T' - Pole)^Order1 dT' *)
IntegratePole[Coef_, Pole_, 1, Word_List, T_] := {{Coef, Prepend[Word, Pole]}};
IntegratePole[Coef_, Pole_, Order1_Integer, {}, T_] := Module[{Value1},
  If[Pole === 0, Throw[$Failed, "OneFoldHyp"]];
  Value1 = Coef (-1/((Order1 - 1) (T - Pole)^(Order1 - 1)) + 1/((Order1 - 1) (-Pole)^(Order1 - 1)));
  Return[{{Value1, {}}}]];
IntegratePole[Coef_, Pole_, Order1_Integer, Word_List, T_] := Module[{Boundary, Rest1},
  Boundary = {{-Coef/((Order1 - 1) (T - Pole)^(Order1 - 1)), Word}};
  Rest1 = IntegrateG[Coef/((Order1 - 1) (T - Pole)^(Order1 - 1) (T - First[Word])), Rest[Word], T];
  Return[Join[Boundary, Rest1]]];


(* J[f](T) = Int_0^T dT'/T' f(T') *)
IntegralJ[Pairs_List, T_] := Module[{Terms},
  Terms = Map[IntegrateG[#[[1]]/T, #[[2]], T] &, Pairs];
  Terms = Flatten[Terms, 1];
  Return[MergeWords[Terms]]];


(* Sum_{Nu >= 1} T^Nu R(Nu) S_w(Nu) with R rational, whose poles are at Nu = -Shift, Shift >= 0 *)
SumToG[R_, Word_List, Nu_, T_] := Module[{Tog, Parts, Out = {}, Base},
  Base = GenFunction[Word, T];
  Tog = Together[R];
  Parts = Apart[Tog, Nu];
  Parts = SumList[Parts];
  Do[Module[{Part1, Num, Den, Coef, Pole, Order1, Shift, Lifted, Integrated, Derived},
      Part1 = Together[Term];
      Num = Numerator[Part1];
      Den = Denominator[Part1];
      Which[
        FreeQ[Den, Nu] && PolynomialQ[Num, Nu],
          Do[
            Coef = Coefficient[Num, Nu, Power1]/Den;
            If[Coef =!= 0,
              Derived = Nest[ThetaOp[#, T] &, Base, Power1];
              Out = Join[Out, Map[{Coef #[[1]], #[[2]]} &, Derived]]],
            {Power1, 0, Exponent[Num, Nu]}],
        FreeQ[Num, Nu],
          {Pole, Order1} = PoleOf[Den, Nu];
          Shift = -Pole;
          If[! IntegerQ[Shift] || Shift < 0, Throw[$Failed, "OneFoldHyp"]];
          Coef = Simplify[Num/(Den/(Nu - Pole)^Order1)];
          (* Sum T^Nu f/(Nu + Shift)^Order1 = T^-Shift J^Order1[T^Shift Sum T^Nu f] *)
          Lifted = Map[{T^Shift #[[1]], #[[2]]} &, Base];
          Integrated = Nest[IntegralJ[#, T] &, Lifted, Order1];
          Out = Join[Out, Map[{Coef #[[1]]/T^Shift, #[[2]]} &, Integrated]],
        True,
          Throw[$Failed, "OneFoldHyp"]]],
    {Term, Parts}];
  Return[MergeWords[Out]]];


(* ::Section:: *)
(*Expansion*)


(* (m + c Eps)_n = PochFactor(m, c) (n + m - 1)! Prod_{k <= n + m - 1} (1 + c Eps/k) for n >= Max(1, 1 - m) *)
PochFactor[IntPart_, EpsCoef_, Eps_] := If[IntPart >= 1,
  1/((IntPart - 1)! Product[1 + EpsCoef Eps/K1, {K1, 1, IntPart - 1}]),
  EpsCoef Eps Product[EpsCoef Eps - J1, {J1, 1, -IntPart}]];


(* the Taylor coefficients through Y^NMax of G(0^(a1-1), 1, ..., 0^(ak-1), 1; Y) = (-1)^k Li_{a1..ak}(Y): the coefficient
   of Y^n is (-1)^k Z_{a2..ak}(n - 1)/n^a1 *)
LiTaylor[Word_List, NMax_] := Module[{Blocks = {}, Count1 = 0, Nested, Inner, Weights},
  Do[Count1 = Count1 + 1; If[Letter === 1, AppendTo[Blocks, Count1]; Count1 = 0], {Letter, Word}];
  (* Nested[[n + 1]] = Z_{a_d .. a_k}(n), from the innermost index outwards *)
  Nested = ConstantArray[1, NMax + 1];
  Do[
    Inner = Nested;
    Weights = Table[Inner[[I1]]/I1^Blocks[[D1]], {I1, 1, NMax}];
    Nested = FoldList[Plus, 0, Weights],
    {D1, Length[Blocks], 2, -1}];
  Return[Table[If[N1 == 0, 0, (-1)^Length[Blocks] Nested[[N1]]/N1^Blocks[[1]]], {N1, 0, NMax}]]];


(* the result and the series agree in their Taylor coefficients through Y^OneFoldHypCheckTerms, order by order *)
TaylorCheck[Result_, Norm_, GammaList_, X_, Eps_, Lo_, Hi_] := Module[{NMax = OneFoldHypCheckTerms, Y, Good = True},
  Do[Module[{Coef, Series1, Direct, Terms},
      Coef = Expand[Coefficient[Result, Eps, Order1]];
      Series1 = Coef /. GG[Word_] :> Sum[LiTaylor[Word, NMax][[I1 + 1]] Y^I1, {I1, 0, NMax}];
      Series1 = Series1 /. X -> -Y;
      Series1 = Normal[Series[Series1, {Y, 0, NMax}]];
      Terms = Sum[Y^N1/N1! Product[Pochhammer[Gam[[1]] + Gam[[2]] Eps, N1]^Gam[[3]], {Gam, GammaList}], {N1, 0, NMax}];
      Direct = SeriesCoefficient[Norm Terms, {Eps, 0, Order1}];
      Direct = Normal[Series[Direct, {Y, 0, NMax}]];
      If[Expand[Series1 - Direct] =!= 0, Good = False]],
    {Order1, Lo, Hi}];
  Return[Good]];


OneFoldHypExpand[Integrand_, Eps_Symbol, {Lo_Integer, Hi_Integer}] := Catch[Module[
  {Parsed, GammaList, X, PreFac, Norm, N0, Sigma, Nu, N1, T, Ratio, PochProd, Leading, Inv, Order2, Exponent1, ExpSeries,
   SS, Generic, Exceptional, Total1, Result, LowPower},
  Parsed = OneFoldHypQ[Integrand, Eps];
  If[Parsed === $Failed, Throw[$Failed, "OneFoldHyp"]];
  GammaList = Parsed["Gammas"];
  X = Parsed["X"];
  PreFac = Parsed["Prefactor"];
  (* F = Norm Sum_n Y^n/n! Prod (m_i + c_i Eps)_n^k_i, Y = -X *)
  Norm = PreFac Product[Gamma[Gam[[1]] + Gam[[2]] Eps]^Gam[[3]], {Gam, GammaList}];
  (* the generic terms n >= N0 = Nu + Sigma, Nu >= 1, in which every Pochhammer symbol has its zero factor *)
  N0 = Max[1, Max[1 - GammaList[[All, 1]]]];
  Sigma = N0 - 1;
  Ratio = Product[Gamma[N1 + Gam[[1]]]^Gam[[3]], {Gam, GammaList}]/Gamma[N1 + 1];
  Ratio = FunctionExpand[Ratio];
  Ratio = FullSimplify[Ratio, Element[N1, Integers] && N1 > 1];
  Ratio = Together[Ratio];
  If[! PolynomialQ[Numerator[Ratio], N1] || ! PolynomialQ[Denominator[Ratio], N1], Throw[$Failed, "OneFoldHyp"]];
  PochProd = Product[PochFactor[Gam[[1]], Gam[[2]], Eps]^Gam[[3]], {Gam, GammaList}];
  (* the generic part is needed through Eps^Order2, Order2 = Hi minus the leading power of Norm PochProd *)
  Leading = Normal[Series[Norm PochProd, {Eps, 0, Hi}]];
  Leading = -Exponent[Leading /. Eps -> 1/Inv, Inv, Max];
  Order2 = Hi - Leading;
  (* exp(Sum_i k_i L(c_i Eps, Nu + Sigma + m_i - 1)), L(x, N) = Sum_j (-1)^(j + 1) x^j S_j(N)/j *)
  Generic = 0;
  If[Order2 >= 0,
    Exponent1 = Sum[Gam[[3]] Sum[(-1)^(J1 + 1) (Gam[[2]] Eps)^J1/J1 SS[J1, Sigma + Gam[[1]] - 1], {J1, 1, Order2}], {Gam, GammaList}];
    ExpSeries = Series[Exp[Exponent1], {Eps, 0, Order2}];
    ExpSeries = Normal[ExpSeries];
    Do[Module[{Coef, Monomials, Acc = {}, Value1 = 0},
        Coef = Expand[Coefficient[ExpSeries, Eps, Order1]];
        Monomials = If[Coef === 0, {}, SumList[Coef]];
        Do[Module[{Factors, Constant1, Words},
            Factors = Cases[FactorList1[Mono], SS[J1_, S1_]^P1_. :> ConstantArray[{J1, S1}, P1]];
            Factors = Flatten[Factors, 1];
            Constant1 = Mono /. SS[__] -> 1;
            Words = HarmonicProduct[Factors, Nu];
            Acc = Join[Acc, Map[{Constant1 #[[1]], #[[2]]} &, Words]]],
          {Mono, Monomials}];
        Acc = MergeWords[Acc];
        Do[Module[{Pairs},
            Pairs = SumToG[(Ratio /. N1 -> Nu + Sigma) Q1[[1]], Q1[[2]], Nu, T];
            Value1 = Value1 + Total[Map[If[#[[2]] === {}, #[[1]], #[[1]] GG[#[[2]]]] &, Pairs]]],
          {Q1, Acc}];
        Generic = Generic + Eps^Order1 Value1],
      {Order1, 0, Order2}]];
  (* the exceptional terms n < N0, exactly *)
  Exceptional = Sum[(-X)^N2/N2! Product[Pochhammer[Gam[[1]] + Gam[[2]] Eps, N2]^Gam[[3]], {Gam, GammaList}], {N2, 0, N0 - 1}];
  Total1 = Norm (Exceptional + PochProd (-X)^Sigma (Generic /. T -> -X));
  Result = Series[Total1, {Eps, 0, Hi}];
  Result = Normal[Result];
  If[! FreeQ[Result, GG[{___, 0}]], Throw[$Failed, "OneFoldHyp"]];
  (* no term below the leading pole that MBEvaluate determined from MBresolve *)
  LowPower = -Exponent[Expand[Result] /. Eps -> 1/Inv, Inv, Max];
  If[LowPower < Lo, Throw[$Failed, "OneFoldHyp"]];
  If[! TaylorCheck[Result, Norm, GammaList, X, Eps, Lo, Hi], Throw[$Failed, "OneFoldHyp"]];
  Association[Table[Order1 -> (Coefficient[Result, Eps, Order1] /. GG[Word_] :> (PolyLogTools`G @@ Append[Word, -X])), {Order1, Lo, Hi}]]],
  "OneFoldHyp"];


End[];
EndPackage[];
