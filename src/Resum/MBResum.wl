(* ::Package:: *)

(* ::Title:: *)
(*MBResum*)


(* ::Subtitle:: *)
(*a Mathematica package for the analytic evaluation of Mellin-Barnes integrals in terms of multiple polylogarithms*)


(* ::Section::Closed:: *)
(*Package Initiation*)


(* claim the parallel kernels before MBConicHulls, which would start two per core *)
If[$KernelCount === 0 && $KernelID === 0,
   LaunchKernels[If[IntegerQ[$KernelLaunch], $KernelLaunch, Min[4, $ProcessorCount]]]];

(* hide the front end and silence printing so the encoded packages load quietly *)
Unprotect[Print, CellPrint, NotebookWrite, NotebookPrint];
Print[___] := Null; CellPrint[___] := Null;
NotebookWrite[___] := Null; NotebookPrint[___] := Null;
CheckAbort[
 Block[{$Notebooks = False, $FrontEnd = Null, $Output = {}, $Messages = {}},
  If[Names["MB`*"]==={},             Quiet[Get["MB.m"]]; Quiet[Get["MBresolve.m"]]];
  If[Names["BarnesRoutines`*"]==={}, Quiet[Get["barnesroutines.m"]]];
  If[Names["MBConicHulls`*"]==={},   Quiet[Get["MBConicHulls`"]]];
  Quiet[Get["HarmonicSums`"]];
  Quiet[Get["Sigma`"]];
  Quiet[Get["EvaluateMultiSums`"]]], Null];
(* a dependency re-Protects Print, so unprotect before clearing or Print stays dead *)
Unprotect[Print, CellPrint, NotebookWrite, NotebookPrint];
Clear[Print, CellPrint, NotebookWrite, NotebookPrint];
Protect[Print, CellPrint, NotebookWrite, NotebookPrint];

MBResumOuterPath = $ContextPath;

BeginPackage["MBAnalytica`Resum`"];
$ContextPath = DeleteDuplicates[Join[$ContextPath,
   DeleteCases[Global`MBResumOuterPath, "Global`"]]];
ParallelEvaluate[Off[SetDelayed::write]];
SetOptions[ResolveMB,RunInParallel->False];
SetOptions[EvaluateSeries,RunInParallel->False];
LastUpdate="\!\(\*SuperscriptBox[\(21\), \(st\)]\) September, 2026";


(* ::Section::Closed:: *)
(*Author Credits*)


Print[Style["MBResum 1.0",Blue,14,FontFamily->"Courier",Bold],Style[" - a Mathematica package for the analytic evaluation of Mellin-Barnes integrals in terms of multiple polylogarithms.",Blue,14,FontFamily->"Courier"]];
Print[Style["Authors: ",Black,Bold],Style["Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias",Brown,Bold,12.5]];
Print[Style["Dependencies: ",Black,Bold],
  Hyperlink[Style["MB",RGBColor[0,0.45,0.8],Bold,12.5],"https://gitlab.com/feynmanintegrals/MB"],
  Style[", ",Black,Bold,12.5],
  Hyperlink[Style["MBresolve",RGBColor[0,0.45,0.8],Bold,12.5],"https://gitlab.com/feynmanintegrals/MB"],
  Style[", ",Black,Bold,12.5],
  Hyperlink[Style["barnesroutines",RGBColor[0,0.45,0.8],Bold,12.5],"https://gitlab.com/feynmanintegrals/MB"],
  Style[", ",Black,Bold,12.5],
  Hyperlink[Style["MBConicHulls",RGBColor[0,0.45,0.8],Bold,12.5],"https://github.com/SumitBanikGit/MBConicHulls"],
  Style[", ",Black,Bold,12.5],
  Hyperlink[Style["HarmonicSums",RGBColor[0,0.45,0.8],Bold,12.5],"https://risc.jku.at/sw/harmonicsums/"],
  Style[", ",Black,Bold,12.5],
  Hyperlink[Style["Sigma",RGBColor[0,0.45,0.8],Bold,12.5],"https://risc.jku.at/sw/sigma/"],
  Style[", ",Black,Bold,12.5],
  Hyperlink[Style["EvaluateMultiSums",RGBColor[0,0.45,0.8],Bold,12.5],"https://risc.jku.at/sw/evaluatemultisums/"]];
Print[Style["Last updated: ",Black,Bold], LastUpdate];


(* ::Section::Closed:: *)
(*Usage Messages*)


(* ::Subsection::Closed:: *)
(*Global Variables*)




(* ::Subsection::Closed:: *)
(*External Module*)


MBCH2MPL::usage =
"MBCH2MPL[MBInt, {Eps, Ord}] returns the expansion of the Mellin-Barnes \
integral MBInt in Eps, from its leading pole through the order Eps^Ord, \
expressed in terms of multiple polylogarithms.\n\n\
MBInt  - the MB integrand, built from Gamma and PolyGamma functions and powers \
of the kinematic variables\n\
Eps    - the dimensional regulator appearing in MBInt\n\
Ord    - the deepest order of Eps to be evaluated\n\n\
The integration variables are read off from MBresolve and the kinematic \
variables are whatever is left, so neither has to be given. \
MBCH2MPL[MBInt, MBVar, {Eps, Ord}] names the kinematic variables explicitly.\n\n\
The result is analytic: it is returned in terms of Log, PolyLog, the harmonic \
polylogarithms H of HarmonicSums and zeta values. Numerical contour \
integration is used only to accept or reject a candidate series solution, \
never as an answer.\n\n\
The integral is evaluated in five stages, each of which can be called on its \
own: MBRexExp, MBCHInput, MBCanonlise, MBGetSeries and MBSumSeries. A \
structure that no series solution can reach is passed to MBRegulate, and \
every candidate is checked by MBVerify.\n\n\
Options:  Verbose -> False,  BarnesReduce -> True\n\n\
Examples:\n  \
MBCH2MPL[MB1, {\[Epsilon], -2}]\n  \
MBCH2MPL[MB1u, {\[Epsilon], 0}, Verbose -> True]";


















(* ::Subsection::Closed:: *)
(*External Module Options*)






(* ::Section::Closed:: *)
(*Mellin-Barnes Expansion and Input*)


Begin["`Private`"];


(* ::Subsection::Closed:: *)
(*Internal Modules*)


(* ::Subsubsection::Closed:: *)
(*Settings*)


MBCHChartTime   = 300;    (* seconds allowed for one series solution *)


MBCHChartBudget = 1500;   (* total seconds spent trying series solutions *)


MBCHRegTime     = 300;    (* seconds allowed for one EvaluateMultiSum *)


MBCHRegBudget   = 600;    (* total seconds allowed for the regulator route *)


MBCHRegSlots    = 3;      (* Gamma functions tried as regulator carriers *)


MBCHNumTime     = 180;    (* seconds allowed for one contour integration *)


MBCHProbe       = 1/2;    (* kinematic point used for cross-checking *)


MBCHTol         = 10^-6;  (* relative tolerance of the cross-check *)


MBCHSeriesTerms = {400, 120, 40};  (* terms summed per sub-series dimension *)


MBCHVerifyDiff  = False;  (* cross-check scale-ful structures against the contour *)


MBCHFromOrder   = Automatic;  (* first order harvested; Automatic = leading pole *)


MBCHVerbose  = False;     (* set by the Verbose option of MBCH2MPL *)


MBCHComplex  = False;     (* set by the Complex option of MBCH2MPL: True keeps and checks the full complex value *)


MBCHScale    = {};        (* kinematic variables, set by MBCH2MPL *)


MBCHParallel = True;      (* solve distinct structures on the parallel subkernels *)


MBResumParallelOk = False;  (* set by LoadWorkers once the subkernels pass the self-test *)


MBCHRegGood   = 0;          (* regulator slot that worked last time *)
MBCHRegChart  = 0;          (* regulator chart that worked last time *)
MBSolveCache  = <||>;       (* solved structures, shared by serial and parallel runs *)
MBResumFile   = $InputFileName;  (* reloaded into each subkernel on first use *)
MBRexExpCache = <||>;       (* one epsilon expansion per integral *)
MBResumStatus = "";         (* live status shown by PrintTemporary *)
MBResumLog    = {};         (* the last few steps, so none flashes past *)
MBResumJ      = 0;          (* structure being solved, for the status *)
MBResumN      = 0;


MBCHCanonVar = {zc1, zc2, zc3, zc4, zc5, zc6};


MBCHDel      = RegDel;    (* the analytic regulator *)


MBCHScaleX   = ScaleX;    (* artificial scale given to a scaleless structure *)


MBCHVarY     = VarY;      (* geometric variable, the answer is its y -> 1 limit *)


MBCHSmallT   = SmallT;    (* t = 1 - y, so the limit sits at the origin *)


MBCHLogT     = LogT;      (* Log[t], the only divergent object left *)


VPrint[args___] := If[TrueQ[MBCHVerbose], Print[args]];


ScaleAssum[] := Module[{Vars},
  Vars = MBCHScale;
  If[Vars === {}, Return[True]];
  Return[And @@ Map[(0 < # < 1) &, Vars]]];


ScaleFreeQ[Expr_] := Module[{Vars},
  Vars = MBCHScale;
  If[Vars === {}, Return[True]];
  Return[And @@ Map[FreeQ[Expr, #] &, Vars]]];


ProbeRule[] := Map[(# -> MBCHProbe) &, MBCHScale];


(* ::Subsubsection::Closed:: *)
(*Guards*)


(* emptying $Output silences Print; with no front end Verbose echoes the step *)
Say[Msg_] := (AppendTo[MBResumLog, Msg];
   MBResumStatus = Column[Take[MBResumLog, -Min[Length[MBResumLog], 8]]];
   If[$FrontEnd === Null && TrueQ[MBCHVerbose], Print["      ", Msg]]);

SetAttributes[Silent, HoldAll];
Silent[Expr_] := Block[{$Output = {}, $Messages = {}}, Expr];

SetAttributes[SafeEval, HoldAll];

SafeEval[Expr_] := Module[{Res},
  Res = CheckAbort[Catch[Catch[Expr], _, ($Failed &)], $Failed];
  Return[Res]];


MBCHKeepSym = {"HarmonicSums`H"};


LeakQ[Expr_] := Module[{Bad},
  Bad = Cases[Expr,
     Sym_Symbol /; ! MemberQ[{"System`", "Global`"}, Context[Sym]] &&
       ! MemberQ[MBCHKeepSym, Context[Sym] <> SymbolName[Sym]] :> Sym,
     {0, Infinity}, Heads -> True];
  Bad = DeleteDuplicates[Bad];
  Return[Length[Bad] > 0]];


DirtyQ[Val_] := Module[{Res},
  Res = SumsToMPL[Val];
  If[LeakQ[Res], Return[True]];
  If[! FreeQ[Res, Indeterminate | ComplexInfinity | DirectedInfinity], Return[True]];
  If[! FreeQ[Res, Global`LinInf], Return[True]];
  If[! FreeQ[Res, Global`sinf], Return[True]];
  If[! FreeQ[Res, S], Return[True]];
  Return[False]];


(* ::Subsubsection::Closed:: *)
(*Real or Complex Comparison*)


(* with Complex -> False only the real part is compared, as before; with Complex -> True the full complex value *)
ComparedPart[Val_] := If[TrueQ[MBCHComplex], Val, Re[Val]];


ValueGap[A_, B_] := Module[{X, Y},
  X = ComparedPart[A];
  Y = ComparedPart[B];
  Return[Abs[X - Y]]];


RefSize[A_] := Abs[ComparedPart[A]];


(* the accepted solutions depend on what is compared, so the caches are kept per setting *)
SetComplex[Flag_] := Module[{},
  If[Flag === MBCHComplex, Return[Null]];
  MBCHComplex = Flag;
  ClearSolveCaches[];
  Return[Null]];


ClearSolveCaches[] := Module[{Kept},
  MBSolveCache = <||>;
  Kept = Select[DownValues[MBSolveOne], ! FreeQ[First[#], Pattern] &];
  DownValues[MBSolveOne] = Kept;
  If[$KernelID === 0 && $KernelCount > 0 && TrueQ[MBResumParallelOk],
    Quiet[ParallelEvaluate[MBAnalytica`Resum`Private`ClearSolveCaches[]]]];
  Return[Null]];


(* ::Subsubsection::Closed:: *)
(*Coefficient Extraction*)


CoefOf[Expr_, Var_, Ord_] := Module[{Res, FlatEx, Terms},
  Res = Coefficient[Expand[Expr], Var, Ord];
  Res = Expand[Res];
  If[! LeakQ[Res], Return[Res]];
  ClearSystemCache[];
  Res = Coefficient[Expand[Expr], Var, Ord];
  Res = Expand[Res];
  If[! LeakQ[Res], Return[Res]];
  FlatEx = Expand[Expr];
  Terms = If[Head[FlatEx] === Plus, List @@ FlatEx, {FlatEx}];
  Terms = Select[Terms, Quiet[Exponent[#, Var]] === Ord &];
  Res = Total[Terms]/Var^Ord;
  Return[Expand[Res]]];


GammaOrPG[ArgX_] := Module[{Res},
  If[Head[ArgX] === List,
     Res = PolyGamma[ArgX[[1]], ArgX[[2]]],
     Res = Gamma[ArgX]];
  Return[Res]];


(* ::Subsubsection::Closed:: *)
(*S-Sums to Polylogarithms*)


MBCHSumRules = {S[1, {X_}, Global`LinInf] :> -Log[1 - X],
                S[M_Integer, {X_}, Global`LinInf] :> PolyLog[M, X]};


(* SinfToL/LToH mistranslate symbolic S-sums: convert S -> Li (index merges) -> G -> H *)

CutBlocks[Cut_, K_] := Module[{Edges, Blocks},
  Edges = Join[{0}, Cut, {K}];
  Blocks = Table[Range[Edges[[J]] + 1, Edges[[J + 1]]], {J, Length[Edges] - 1}];
  Return[Blocks]];

AdjacentMerges[K_] := Module[{Cuts, Res},
  Cuts = Subsets[Range[K - 1]];
  Res = Map[CutBlocks[#, K] &, Cuts];
  Return[Res]];

LetterProbe[] := Join[ProbeRule[], {MBCHVarY -> 1/2}];

LetterFactor[A_] := Module[{V},
  V = N[A /. LetterProbe[]];
  Return[-Sign[V]]];

LiWordToH[Ms_, Ys_] := Module[{Word, Prod, Fac, Nz},
  Word = {};
  Prod = 1;
  Do[
   Prod = Together[Prod*Ys[[J]]];
   Word = Join[Word, ConstantArray[0, Ms[[J]] - 1], {Together[1/Prod]}],
   {J, Length[Ms]}];
  Nz = DeleteCases[Word, 0];
  Fac = Times @@ Map[LetterFactor, Nz];
  Return[(-1)^Length[Ms]*Fac*(H @@ Append[Word, 1])]];

SumInfConvergesQ[Idx_List, Xs_List] := Module[{Ys, Prods, Ok},
  Ys = N[Xs /. LetterProbe[]];
  If[! VectorQ[Ys, NumericQ], Return[False]];
  Prods = FoldList[Times, Ys];
  Ok = AllTrue[Prods, Abs[#] <= 1 + 10^-12 &];
  If[Idx[[1]] === 1 && Abs[Ys[[1]] - 1] < 10^-12, Ok = False];
  Return[Ok]];

SumInfToH[Idx_List, Xs_List] := Module[{Splits, Terms},
  If[! SumInfConvergesQ[Idx, Xs], Return[S @@ Join[Idx, {Xs, Global`LinInf}]]];
  Splits = AdjacentMerges[Length[Idx]];
  Terms = Map[
    Function[Bl, LiWordToH[Map[Total[Idx[[#]]] &, Bl], Map[(Times @@ Xs[[#]]) &, Bl]]],
    Splits];
  Return[Total[Terms]]];

SumInfRules = {S[Idx__Integer, Xs_List /; ! VectorQ[Xs, NumericQ], Global`LinInf] :>
                 SumInfToH[{Idx}, Xs]};


SumsToMPL[Val_] := Module[{Res, Part1},
  If[FreeQ[Val, S], Return[Val]];
  Res = Val /. MBCHSumRules;
  If[FreeQ[Res, S], Return[Res]];
  Res = Res /. SumInfRules;
  If[FreeQ[Res, S], Return[Res]];
  Part1 = Res;
  Res = Res /. S[A__, Global`LinInf] :> S[A, Infinity];
  Res = SafeEval[Quiet[TimeConstrained[SinfToL[Res], 180, Res]]];
  If[Res === $Failed, Return[Part1]];
  Res = SafeEval[Quiet[TimeConstrained[LToH[Res], 180, Res]]];
  If[Res === $Failed, Return[Part1]];
  If[! FreeQ[Res, $Failed], Return[Part1]];
  If[LeakQ[Res], Return[Part1]];
  Return[Res]];


TidyResult[Val_] := Module[{Hs, Fwd, Bwd, Res},
  Hs = Cases[Val, _H, {0, Infinity}];
  Hs = DeleteDuplicates[Hs];
  Fwd = MapIndexed[(#1 -> HoldH[First[#2]]) &, Hs];
  Bwd = Map[Reverse, Fwd];
  Res = Val /. Fwd;
  Res = FunctionExpand[Res];
  If[! TrueQ[MBCHComplex], Res = Re[Res]];
  Res = ComplexExpand[Res];
  Res = Quiet[Assuming[ScaleAssum[], Simplify[Res]]];
  Res = Res /. Bwd;
  If[LeakQ[Res] && ! LeakQ[Val], Return[Val]];
  Return[Res]];


(* ::Subsubsection::Closed:: *)
(*Linear Gamma Factors*)


LinearGammaQ[Fac_, IntVar_] := Module[{Lin, Pow, Degs, Cofs},
  If[Head[Fac] === Power && IntegerQ[Fac[[2]]],
     Lin = Fac[[1]]; Pow = Fac[[2]],
     Lin = Fac; Pow = 1];
  If[Pow === 0, Return[False]];
  If[FreeQ[Lin, Alternatives @@ IntVar], Return[False]];
  If[! PolynomialQ[Lin, IntVar], Return[False]];
  If[! FreeQ[Lin, Gamma | PolyGamma], Return[False]];
  Degs = Map[Exponent[Lin, #] &, IntVar];
  If[Max[Degs] =!= 1, Return[False]];
  If[Total[Degs] < 1, Return[False]];
  Cofs = Map[Coefficient[Lin, #] &, IntVar];
  Cofs = Select[Cofs, # =!= 0 &];
  Return[And @@ Map[IntegerQ, Cofs]]];


(* ::Subsubsection::Closed:: *)
(*Argument Parts and Shifts*)


ArgParts[ArgX_, IntVar_] := Module[{Tag, Expr, Const, Cofs},
  If[Head[ArgX] === List,
     Tag = ArgX[[1]]; Expr = ArgX[[2]],
     Tag = -1; Expr = ArgX];
  Const = Expr /. Map[(# -> 0) &, IntVar];
  Cofs = Map[Coefficient[Expr, #] &, IntVar];
  Return[{Tag, Const, Cofs}]];


ShiftFor[AllParts_, NVar_] := Module[{Shift},
  Shift = Table[
    Module[{Pos, Neg},
     Pos = Select[AllParts, #[[3]] === UnitVector[NVar, J] &];
     Neg = Select[AllParts, #[[3]] === -UnitVector[NVar, J] &];
     Which[
      Pos =!= {}, -Min[Pos[[All, 2]]],
      Neg =!= {}, Min[Neg[[All, 2]]],
      True, 0]],
    {J, NVar}];
  Return[Shift]];


(* ::Subsubsection::Closed:: *)
(*Grouping Key*)


GroupKey[Entry_] := Module[{Ref, NonZero},
  If[Entry[[2]] === Null, Return["Const"]];
  Ref = MBVerify[Entry[[2]], Entry[[3]], Entry[[4]], Entry[[5]]];
  NonZero = NumericQ[Ref] && Abs[Ref] > 10^-8;
  If[NonZero,
   Return[{"Val", Length[Entry[[2]]], Round[Re[Ref], 10^-12], Round[Im[Ref], 10^-12]}]];
  If[Ref === $Failed,
   Return[{Entry[[3]], Entry[[4]], Entry[[5]], Entry[[2]]}]];
  Return[{Entry[[3]], Entry[[4]], Entry[[5]],
          {Round[Re[Ref], 10^-10], Round[Im[Ref], 10^-10]}}]];


(* ::Subsubsection::Closed:: *)
(*MBRexExp*)


Options[MBRexExp] = {BarnesReduce -> True};

MBRexExp[MBInt_, Eps_, Ord_, OptionsPattern[]] :=
 Module[{Key, Top, Red, Resolved, Expanded, Barnesed, Merged},
  (* one expansion to order Top holds every lower order, so it is cached per integral *)
  Red = TrueQ[OptionValue[BarnesReduce]];
  Key = {MBInt, Eps, Red};
  If[KeyExistsQ[MBRexExpCache, Key] && MBRexExpCache[Key][[1]] >= Ord,
     Return[MBRexExpCache[Key][[2]]]];
  Top = If[KeyExistsQ[MBRexExpCache, Key], Max[MBRexExpCache[Key][[1]], Ord], Ord];
  Say["Resolving contours ..."];
  Resolved = Silent[MBresolve[MBInt /. {Eps -> ep}, ep]];
  Say["Resolved Done!"];
  Expanded = Silent[MBexpand[Resolved, 1, {ep, 0, Top}]];
  If[Red,
     Say["Barnes Reduction ..."];
     Barnesed = Silent[Quiet[TimeConstrained[DoAllBarnes[Expanded, False], 600, Expanded]]];
     Say["Barnes Reduction Done!"],
     Barnesed = Expanded];
  Merged = Silent[MBmerge[Barnesed]];
  Merged = ExpandAll[Merged];
  MBRexExpCache[Key] = {Top, Merged};
  Return[Merged]];


(* ::Subsubsection::Closed:: *)
(*MBCHInput*)


MBCHInput[Term_, IntVar_] := Module[
  {Facs, PreFac, Num, Den, MBVars, Fac, Base, Expo, Lin, Pow, Cofs, Cof, NewB},
  PreFac = 1;
  Num = {};
  Den = {};
  MBVars = ConstantArray[1, Length[IntVar]];
  Facs = If[Head[Term] === Times, List @@ Term, {Term}];
  Do[
   Which[
    MatchQ[Fac, Gamma[_]^_.] && ! FreeQ[Fac, Alternatives @@ IntVar] &&
      (Head[Fac] =!= Power || (IntegerQ[Fac[[2]]] && Fac[[2]] != 0)),
      If[Head[Fac] === Power && Fac[[2]] < 0,
         Den = Join[Den, ConstantArray[Fac[[1, 1]], -Fac[[2]]]],
         Num = Join[Num, ConstantArray[Fac /. {Gamma[Q_]^K_. :> Q},
                                       If[Head[Fac] === Power, Fac[[2]], 1]]]],

    MatchQ[Fac, PolyGamma[_, _]^_.] && ! FreeQ[Fac, Alternatives @@ IntVar] &&
      (Head[Fac] =!= Power || (IntegerQ[Fac[[2]]] && Fac[[2]] > 0)),
      Num = Join[Num, ConstantArray[
         List @@ (Fac /. {PolyGamma[A_, B_]^K_. :> PolyGamma[A, B]}),
         If[Head[Fac] === Power, Fac[[2]], 1]]],

    MatchQ[Fac, Power[_, _]] && ! FreeQ[Fac[[2]], Alternatives @@ IntVar],
      Base = Fac[[1]];
      Expo = Fac[[2]];
      PreFac = PreFac*Base^(Expo /. Map[(# -> 0) &, IntVar]);
      Do[MBVars[[J]] = MBVars[[J]]*Base^Coefficient[Expo, IntVar[[J]]],
         {J, Length[IntVar]}],

    LinearGammaQ[Fac, IntVar],
      If[Head[Fac] === Power,
         Lin = Fac[[1]]; Pow = Fac[[2]],
         Lin = Fac; Pow = 1];
      Cofs = Map[Coefficient[Lin, #] &, IntVar];
      Cofs = Select[Cofs, # =!= 0 &];
      If[Length[Cofs] === 1,
         Cof = First[Cofs],
         Cof = Sign[First[Cofs]]*(GCD @@ Abs[Cofs])];
      NewB = Expand[Lin/Cof];
      PreFac = PreFac*Cof^Pow;
      If[Pow > 0,
         Num = Join[Num, ConstantArray[NewB + 1, Pow]];
         Den = Join[Den, ConstantArray[NewB, Pow]],
         Num = Join[Num, ConstantArray[NewB, -Pow]];
         Den = Join[Den, ConstantArray[NewB + 1, -Pow]]],

    True,
      PreFac = PreFac*Fac],
   {Fac, Facs}];
  MBVars = MapIndexed[If[#1 === 1, Subscript[MBCHScaleX, First[#2]], #1] &, MBVars];
  Return[{PreFac, MBVars, Num, Den}]];


(* ::Subsubsection::Closed:: *)
(*MBCanonlise*)


MBCanonlise[IntVar_, MBVars_, Num_, Den_] := Module[
  {Vars, Vals, NVar, Best, BestKey, Perm, PMBVars, NumP, DenP, AllP, Shift,
   NumK, DenK, Key, CanVar, ShiftFac, IntVarC},
  Vars = Keys[IntVar];
  Vals = Values[IntVar];
  NVar = Length[Vars];
  If[NVar === 0 || NVar > 4, Return[{IntVar, MBVars, Num, Den, 1}]];
  Best = Null;
  BestKey = Null;
  Do[
   PMBVars = MapIndexed[
      If[MatchQ[#1, Subscript[MBCHScaleX, _]], Subscript[MBCHScaleX, First[#2]], #1] &,
      MBVars[[Perm]]];
   NumP = Map[ArgParts[#, Vars] &, Num];
   NumP = Map[{#[[1]], #[[2]], #[[3]][[Perm]]} &, NumP];
   DenP = Map[ArgParts[#, Vars] &, Den];
   DenP = Map[{#[[1]], #[[2]], #[[3]][[Perm]]} &, DenP];
   AllP = Join[NumP, DenP];
   Shift = ShiftFor[AllP, NVar];
   NumK = Map[{#[[1]], #[[2]] + #[[3]] . Shift, #[[3]]} &, NumP];
   NumK = Sort[NumK];
   DenK = Map[{#[[1]], #[[2]] + #[[3]] . Shift, #[[3]]} &, DenP];
   DenK = Sort[DenK];
   Key = {PMBVars, NumK, DenK};
   If[BestKey === Null || Order[Key, BestKey] === 1,
    BestKey = Key;
    CanVar = Take[MBCHCanonVar, NVar];
    ShiftFac = Times @@ Table[
       (MBVars[[Perm[[J]]]] /. Subscript[MBCHScaleX, _] -> 1)^Shift[[J]], {J, NVar}];
    IntVarC = Thread[CanVar -> (Vals[[Perm]] - Shift)];
    Best = {IntVarC, PMBVars,
       Map[If[#[[1]] === -1, #[[2]] + #[[3]] . CanVar,
              {#[[1]], #[[2]] + #[[3]] . CanVar}] &, NumK],
       Map[If[#[[1]] === -1, #[[2]] + #[[3]] . CanVar,
              {#[[1]], #[[2]] + #[[3]] . CanVar}] &, DenK],
       ShiftFac}],
   {Perm, Permutations[Range[NVar]]}];
  Return[Best]];


(* ::Section::Closed:: *)
(*Series Solutions*)


(* ::Subsection::Closed:: *)
(*Internal Modules*)


(* ::Subsubsection::Closed:: *)
(*Contour Integration*)


ContourValue[IntVar_, MBVars_, Num_, Den_, Pr_] := Module[
  {Vars, Vals, Sub, Integrand, Ts, Res},
  Vars = Keys[IntVar];
  Vals = Values[IntVar];
  Sub = Cases[MBVars, Q_Subscript :> (Q -> 1)];
  Integrand = Times @@ Map[GammaOrPG, Num];
  Integrand = Integrand/(Times @@ Map[GammaOrPG, Den]);
  Integrand = Integrand*
     Product[(MBVars[[J]] /. Sub)^Vars[[J]], {J, Length[Vars]}];
  Integrand = Integrand /. Pr;
  If[! ScaleFreeQ[Integrand], Return[$Failed]];
  Ts = Table[Unique["tq"], {Length[Vars]}];
  Integrand = Integrand /. Thread[Vars -> (Vals + I*Ts)];
  Res = TimeConstrained[
    Which[
     Length[Vars] === 1,
       Quiet[NIntegrate[Integrand/(2 Pi), Evaluate[{Ts[[1]], -80, 80}],
          WorkingPrecision -> 20, MaxRecursion -> 18]],
     Length[Vars] === 2,
       Quiet[NIntegrate[Integrand/(2 Pi)^2, Evaluate[{Ts[[1]], -40, 40}],
          Evaluate[{Ts[[2]], -40, 40}], MaxRecursion -> 12]],
     Length[Vars] === 3,
       Quiet[NIntegrate[Integrand/(2 Pi)^3, Evaluate[{Ts[[1]], -25, 25}],
          Evaluate[{Ts[[2]], -25, 25}], Evaluate[{Ts[[3]], -25, 25}],
          Method -> {"AdaptiveMonteCarlo", "MaxPoints" -> 4*10^6},
          PrecisionGoal -> 8, MaxRecursion -> 6]],
     True, $Failed],
    MBCHNumTime, $Failed];
  If[NumericQ[Res], Return[Chop[Res, 10^-12]]];
  Return[$Failed]];


(* ::Subsubsection::Closed:: *)
(*Series Cross-Check*)


(* one sub-series at the probe point, truncated at Lim; Table, as Sum may not evaluate *)
TruncatedSum[Summand_, Vars_, Pr_, Lim_] := Module[{Fresh, Rules, Iters, Terms, Val},
  Fresh = Table[Unique["MBCHk"], {Length[Vars]}];
  Rules = Thread[Vars -> Fresh];
  Iters = Table[{Fresh[[K1]], 0, Lim}, {K1, Length[Fresh]}];
  Terms = Quiet[Table[N[Summand /. Join[Pr, Rules], 20], Evaluate[Sequence @@ Iters]]];
  Val = Quiet[Total[Flatten[Terms]]];
  If[NumericQ[Val], Return[Val]];
  Return[$Failed]];


(* sum the chart's series numerically in any dimension; the caller judges it by the contour *)
SeriesNumeric[SerOut_, Pr_] := Module[{Total1, Terms},
  Terms = Table[
    Module[{Vars, Dim, Lim, Half, Full},
     Vars = Cases[{SerOut[[4, I1]]}, (W_ >= 0) :> W, Infinity];
     Vars = DeleteDuplicates[Vars];
     Dim = Length[Vars];
     Which[
      Vars === {},
        N[SerOut[[2, I1]] /. Pr, 20],
      Dim > Length[MBCHSeriesTerms],
        $Failed,
      True,
        Lim = MBCHSeriesTerms[[Dim]];
        Half = TruncatedSum[SerOut[[2, I1]], Vars, Pr, Quotient[Lim, 2]];
        Full = TruncatedSum[SerOut[[2, I1]], Vars, Pr, Lim];
        (* an unconverged truncation is not a value: report it as cannot judge *)
        Which[
         ! NumericQ[Half] || ! NumericQ[Full], $Failed,
         Abs[Full - Half] <= MBCHTol*Max[1, Abs[Full]], Full,
         True, $Failed]]],
    {I1, SerOut[[1]]}];
  If[! FreeQ[Terms, $Failed], Return[$Failed]];
  Total1 = Quiet[Total[Terms]];
  If[NumericQ[Total1], Return[Total1]];
  Return[$Failed]];


(* True = matches the contour, False = wrong, $Failed = cannot judge; keep all three apart *)
SeriesOkQ[ResolveOut_, Sub_, Chart_, Ref_, Pr_] := Module[{SerOut, Val},
  If[Ref === $Failed, Return[$Failed]];
  SerOut = SafeEval[Quiet[Silent[
     EvaluateSeries[ResolveOut, Sub, Chart, RearrangeSeries -> True]]]];
  If[! ListQ[SerOut] || Length[SerOut] < 5, Return[$Failed]];
  Val = SafeEval[Quiet[TimeConstrained[SeriesNumeric[SerOut, Pr], MBCHNumTime, $Failed]]];
  If[! NumericQ[Val], Return[$Failed]];
  Return[Quiet[TrueQ[ValueGap[Val, Ref] <= MBCHTol*Max[1, RefSize[Ref]]]]]];


(* Check fires on the message every H emits, so the value itself is tested *)
AgreeQ[A_, B_] := Module[{X, Y, Pr},
  Pr = ProbeRule[];
  X = Quiet[N[ComparedPart[A /. Pr], 20]];
  Y = Quiet[N[ComparedPart[B /. Pr], 20]];
  If[! NumericQ[X] || ! NumericQ[Y],
     Return[Quiet[TrueQ[Simplify[A - B] === 0]]]];
  Return[Quiet[TrueQ[Abs[X - Y] <= MBCHTol*Max[1, Abs[X], Abs[Y]]]]]];


(* three-valued like SeriesOkQ: True / False / $Failed = cannot judge *)
ValueOkQ[Val_, Ref_] := Module[{X, Pr},
  If[Ref === $Failed, Return[$Failed]];
  Pr = ProbeRule[];
  X = Quiet[N[ComparedPart[Val /. Pr], 20]];
  If[! NumericQ[X], Return[$Failed]];
  Return[Quiet[TrueQ[Abs[X - ComparedPart[Ref]] <= MBCHTol*Max[1, RefSize[Ref]]]]]];


(* ::Subsubsection::Closed:: *)
(*Convergent Series*)


ConvergentSeries[ResolveOut_, Sub_, Pr_] := Module[{SerOut, Bases, Res},
  Res = Catch[
    Do[
     SerOut = CheckAbort[Quiet[Silent[
        EvaluateSeries[ResolveOut, Sub, K, RearrangeSeries -> True]]], $Failed];
     If[! ListQ[SerOut] || Length[SerOut] < 5, Continue[]];
     Bases = Cases[SerOut[[2]],
        Power[B_, E1_] /; ! FreeQ[E1, Subscript[n, _]] :> B, Infinity];
     If[Bases === {} || AllTrue[Bases, Quiet[TrueQ[Abs[N[# /. Pr]] < 1]] &],
        Throw[K, "Conv"]],
     {K, ResolveOut[[7]]}];
    1, "Conv"];
  Return[Res]];


(* ::Subsubsection::Closed:: *)
(*MBVerify*)


(* ground truth for one structure; scale-ful ones give none unless MBCHVerifyDiff *)
MBVerify[IntVar_, MBVars_, Num_, Den_] :=
 MBVerify[IntVar, MBVars, Num, Den] = Module[{Sub, Pr},
  Sub = Cases[MBVars, Q_Subscript :> (Q -> 1)];
  If[ScaleFreeQ[MBVars /. Sub],
     Pr = {},
     If[! TrueQ[MBCHVerifyDiff], Return[$Failed]];
     Pr = ProbeRule[]];
  Return[SafeEval[ContourValue[IntVar, MBVars, Num, Den, Pr]]]];


(* ::Subsubsection::Closed:: *)
(*MBGetSeries*)


MBGetSeries[IntVar_, MBVars_, Num_, Den_] := Module[
  {Rep, NMB, ResolveOut, Card, Order1, Sub, Pr},
  Sub = Cases[MBVars, Q_Subscript :> (Q -> 1)];
  Rep = SafeEval[Quiet[Silent[
     MBRep[1, IntVar, MBVars, {Num, Den}]]]];
  If[Rep === $Failed || ! ListQ[Rep], Return[$Failed]];
  NMB = Length[Rep] - 1;
  If[NMB > 1, Return[{Rep, NMB, "Multi"}]];
  ResolveOut = SafeEval[Quiet[Silent[ResolveMB[Rep]]]];
  If[ResolveOut === $Failed || ! ListQ[ResolveOut] || Length[ResolveOut] < 7,
     Return[$Failed]];
  Card = Quiet[Check[Map[Length, ResolveOut[[1]]],
                     ConstantArray[0, ResolveOut[[7]]]]];
  Order1 = Ordering[Card];
  If[! ScaleFreeQ[MBVars /. Sub],
   Pr = ProbeRule[];
   Order1 = Prepend[Order1, ConvergentSeries[ResolveOut, Sub, Pr]];
   Order1 = DeleteDuplicates[Order1]];
  Return[{ResolveOut, Order1, "Single"}]];


(* ::Subsubsection::Closed:: *)
(*MBSumSeries*)


MBSumSeries[ResolveOut_, Sub_, Chart_] := Module[{SerOut, Parts, Res},
  SerOut = SafeEval[Quiet[Silent[
     EvaluateSeries[ResolveOut, Sub, Chart, RearrangeSeries -> True]]]];
  If[! ListQ[SerOut] || Length[SerOut] < 5, Return[$Failed]];
  If[SerOut[[5]] =!= True, Return[$Failed]];
  Parts = SafeEval[Quiet[Silent[
     Table[
      Module[{Vars},
       Vars = Cases[{SerOut[[4, I1]]}, (W_ >= 0) :> W, Infinity];
       Vars = DeleteDuplicates[Vars];
       If[Vars === {},
          SerOut[[2, I1]],
          Expand[EvaluateMultiSum[Evaluate[SerOut[[2, I1]]],
             Evaluate[Thread[{Vars, 0, Infinity}]],
             Assumptions -> ScaleAssum[]]]]],
      {I1, SerOut[[1]]}]]]];
  If[Parts === $Failed || ! FreeQ[Parts, $Failed], Return[$Failed]];
  Res = Total[Parts];
  Res = SumsToMPL[Res];
  Return[Res]];


(* ::Section::Closed:: *)
(*Analytic Regulator*)


(* ::Subsection::Closed:: *)
(*Internal Modules*)


(* ::Subsubsection::Closed:: *)
(*Reflections and Index Shifts*)


NegShiftQ[ArgX_, Idx_] := Module[{Shift, Cofs},
  Shift = ArgX - (ArgX /. Map[(# -> 0) &, Idx]);
  If[Shift === 0, Return[False]];
  Cofs = Map[Coefficient[ArgX, #] &, Idx];
  Return[And @@ Map[(IntegerQ[#] && # < 0) &, Cofs]]];


FlipArg[ArgX_, Idx_, Fn_] := Module[{Const, Shift, Cofs},
  Const = ArgX /. Map[(# -> 0) &, Idx];
  Shift = ArgX - Const;
  If[Shift === 0, Return[$Failed]];
  Cofs = Map[Coefficient[Shift, #] &, Idx];
  If[! And @@ Map[IntegerQ, Cofs], Return[$Failed]];
  Return[Fn[Shift, Const]]];


DeTrig[Expr_, Idx_] := Expr //. {
  Csc[Pi*A_] :> With[{Q = FlipArg[A, Idx, ((-1)^#1*Csc[Pi*#2]) &]}, Q /; Q =!= $Failed],
  Sin[Pi*A_] :> With[{Q = FlipArg[A, Idx, ((-1)^#1*Sin[Pi*#2]) &]}, Q /; Q =!= $Failed],
  Cot[Pi*A_] :> With[{Q = FlipArg[A, Idx, Cot[Pi*#2] &]}, Q /; Q =!= $Failed],
  Gamma[B_] /; NegShiftQ[B, Idx] :> Pi/(Sin[Pi*B]*Gamma[1 - B]),
  PolyGamma[0, B_] /; NegShiftQ[B, Idx] :> PolyGamma[0, 1 - B] - Pi*Cot[Pi*B],
  PolyGamma[M_Integer, B_] /; M > 0 && NegShiftQ[B, Idx] :>
     (-1)^M*PolyGamma[M, 1 - B] - Pi*(D[Cot[Pi*ZZ], {ZZ, M}] /. ZZ -> B),
  Power[B_, K_] /; ! FreeQ[K, Alternatives @@ Idx] &&
     MatchQ[B, Times[-1, _] | _?(NumericQ[#] && Negative[#] &)] :> (-1)^K*(-B)^K};


ShiftUp[Expr_, Idx_] := Expr //. {
  Gamma[Idx] :> Gamma[1 + Idx]/Idx,
  PolyGamma[0, Idx] :> PolyGamma[0, 1 + Idx] - 1/Idx,
  Gamma[A_. + Idx] /; IntegerQ[A] && A < 0 :>
     Gamma[1 + Idx]/Product[Idx + J, {J, A, 0}],
  PolyGamma[0, A_. + Idx] /; IntegerQ[A] && A < 0 :>
     PolyGamma[0, 1 + Idx] - Sum[1/(Idx + J), {J, A, 0}]};


(* ::Subsubsection::Closed:: *)
(*Regulated Sub-Series*)


RegulateSub[Summand_, Vars_, Inv_, Ord_] := Module[{Idx, Sm, Term0, Tail, RuleY},
  RuleY = Which[
    Inv === Null, {},
    TrueQ[Inv], MBCHScaleX -> 1/MBCHVarY,
    True, MBCHScaleX -> MBCHVarY];
  If[Vars === {}, Return[Summand /. RuleY]];
  If[Length[Vars] =!= 1, Return[$Failed]];
  Idx = Vars[[1]];
  Sm = DeTrig[Summand, Vars];
  Sm = Quiet[Refine[Sm, Element[Idx, Integers] && Idx >= 0]];
  Term0 = Sm /. Idx -> 0;
  Term0 = Term0 /. RuleY;
  Term0 = Quiet[Simplify[Term0]];
  Tail = Sum[
    MBCHDel^M*SafeEval[Quiet[Silent[
       TimeConstrained[
         EvaluateMultiSum[
           Evaluate[Simplify[ShiftUp[SeriesCoefficient[Sm, {MBCHDel, 0, M}], Idx] /. RuleY]],
           Evaluate[{{Idx, 1, Infinity}}],
           Assumptions -> 0 < MBCHVarY < 1],
         MBCHRegTime, $Failed]]]],
    {M, 0, Ord}];
  If[! FreeQ[Tail, $Failed], Return[$Failed]];
  Return[Term0 + Tail]];


(* ::Subsubsection::Closed:: *)
(*Harmonic Polylogarithm Series*)


IntMonomial[P_, K_, T_, Lg_] := Module[{Res},
  If[P === -1, Return[Lg^(K + 1)/(K + 1)]];
  Res = T^(P + 1)*Sum[(-1)^(K - J)*K!/(J!*(P + 1)^(K - J + 1))*Lg^J, {J, 0, K}];
  Return[Res]];


TruncT[Expr_, T_, NN_] := Module[{Rules},
  Rules = CoefficientRules[Expand[Expr], {T}];
  Rules = Cases[Rules, R_ /; R[[1, 1]] <= NN :> R[[2]]*T^R[[1, 1]]];
  Return[Total[Rules]]];


HPLSeries[{}, NN_, T_, Lg_] := 1;

HPLSeries[Word_List, NN_, T_, Lg_] := HPLSeries[Word, NN, T, Lg] = Module[
  {Letter, Inner, Rules, Res},
  Letter = First[Word];
  Inner = HPLSeries[Rest[Word], NN, T, Lg];
  Rules = CoefficientRules[Expand[Inner], {T, Lg}];
  Res = 0;
  If[Letter === 0,
   Do[Res = Res + R[[2]]*IntMonomial[R[[1, 1]] - 1, R[[1, 2]], T, Lg], {R, Rules}],
   Do[Do[Res = Res + R[[2]]*IntMonomial[R[[1, 1]] + M, R[[1, 2]], T, Lg],
         {M, 0, NN - R[[1, 1]]}], {R, Rules}]];
  Return[TruncT[Expand[Res], T, NN]]];


(* ::Subsubsection::Closed:: *)
(*Euler Sums at Infinity*)


ZetaSub[Expr_] := Expr /. Q_Symbol /;
   StringMatchQ[SymbolName[Q], "z" ~~ DigitCharacter ..] :>
   Zeta[ToExpression[StringDrop[SymbolName[Q], 1]]];


EulerSumValue[M_List] := EulerSumValue[M] = Module[{Summand, Res},
  If[Length[M] === 1,
     Summand = 1/nZ^M[[1]],
     Summand = S @@ Append[Rest[M], nZ];
     Summand = Summand/nZ^M[[1]]];
  Res = SafeEval[Quiet[Silent[
     TimeConstrained[EvaluateMultiSum[Summand, {{nZ, 1, Infinity}}],
        MBCHRegTime, $Failed]]]];
  Return[Res]];


(* ::Subsubsection::Closed:: *)
(*Limit to One*)


(* letters c/y become HPL letters c at argument y, since G(la; lx) = G(a; x) *)
YLettersQ[Ls_] := Module[{Nz},
  If[Last[Ls] === 0, Return[False]];
  Nz = DeleteCases[Ls, 0];
  Return[AllTrue[Nz, NumericQ[Together[#*MBCHVarY]] &]]];

SumsToHPL[Expr_] := Module[{Res},
  (* generalized sums in y go through SumInfToH, as in SumsToMPL *)
  Res = Expr /. SumInfRules;
  Res = Res /. S[A__, Global`LinInf] :> S[A, Infinity];
  If[! FreeQ[Res, S],
   Res = SafeEval[Quiet[TimeConstrained[SinfToL[Res], 300, $Failed]]];
   If[Res === $Failed, Return[$Failed]];
   Res = SafeEval[Quiet[TimeConstrained[LToH[Res], 300, $Failed]]];
   If[Res === $Failed, Return[$Failed]]];
  Res = Res /. H[A__, 1] :> With[{Ls = {A}},
     H @@ Append[Together[Ls*MBCHVarY], MBCHVarY] /; YLettersQ[Ls]];
  Return[Res]];


LogsToHPL[Expr_] := Expr /. {
  Log[1 - MBCHVarY] -> -H[1, MBCHVarY],
  Log[MBCHVarY] -> H[0, MBCHVarY],
  Log[Power[MBCHVarY, -1]] -> -H[0, MBCHVarY],
  PolyLog[K_Integer /; K > 0, MBCHVarY] :>
     H @@ Join[ConstantArray[0, K - 1], {1, MBCHVarY}]};


ValueAtOne[Expr_] := Module[{Res},
  Res = Expr /. H[A__, MBCHVarY] :> H[A, 1];
  Res = Res /. H[A__, 1] :> Quiet[TimeConstrained[HToSinf[H[A, 1]], 240, H[A, 1]]];
  Res = Res /. S[M__, Infinity] :> With[{Q = EulerSumValue[{M}]}, Q /; Q =!= $Failed];
  Res = ZetaSub[Res];
  Res = Quiet[Simplify[Res]];
  Return[Res]];


LimitToOne[Expr_] := Module[{Res, Hs, TrH, Sub, Rules, Ans, Pows, NN},
  NN = 3;
  Res = SumsToHPL[Expr];
  If[Res === $Failed, Return[$Failed]];
  Res = LogsToHPL[Res];
  Hs = Cases[Res, _H, {0, Infinity}];
  Hs = DeleteDuplicates[Hs];
  TrH = SafeEval[Quiet[TimeConstrained[
     Res /. Map[(# -> TransformH[#, 1 - MBCHVarY]) &, Hs], 900, $Failed]]];
  If[TrH === $Failed, Return[$Failed]];
  If[! FreeQ[TrH, TransformH], Return[$Failed]];
  If[! FreeQ[TrH, S], Return[$Failed]];
  Sub = Expand[TrH /. MBCHVarY -> 1 - MBCHSmallT];
  Sub = Sub /. H[A__, MBCHSmallT] :> HPLSeries[{A}, NN, MBCHSmallT, MBCHLogT];
  Sub = Sub /. Log[MBCHSmallT] -> MBCHLogT;
  If[! FreeQ[Sub, H[__, MBCHSmallT]], Return[$Failed]];
  If[! FreeQ[Sub, MBCHVarY], Return[$Failed]];
  Sub = SafeEval[Quiet[TimeConstrained[
     Normal[Series[Together[Expand[Sub]], {MBCHSmallT, 0, 0}]], 900, $Failed]]];
  If[Sub === $Failed, Return[$Failed]];
  Rules = CoefficientRules[Expand[Sub], {MBCHSmallT}];
  If[AnyTrue[Rules,
      #[[1, 1]] < 0 && ! TrueQ[Quiet[PossibleZeroQ[Simplify[#[[2]]]]]] &],
   Return[$Failed]];
  Ans = Total[Cases[Rules, R_ /; R[[1, 1]] === 0 :> R[[2]]]];
  Pows = CoefficientList[Expand[Ans], MBCHLogT];
  If[Length[Pows] > 1 &&
     AnyTrue[Rest[Pows], ! TrueQ[Quiet[PossibleZeroQ[ValueAtOne[#]]]] &],
   Return[$Failed]];
  Ans = ValueAtOne[First[Pows]];
  If[Ans === $Failed, Return[$Failed]];
  If[! FreeQ[Ans, MBCHVarY | MBCHSmallT | MBCHLogT], Return[$Failed]];
  If[! FreeQ[Ans, S | H], Return[$Failed]];
  Return[Ans]];


(* ::Subsubsection::Closed:: *)
(*Regulated Series*)


RegulateChart[ResolveOut_, MBVars_, Chart_, Ord_ : 1, Pick_ : 0] := Module[
  {SerOut, Sub, Inv, Parts, Total1, Fin, Lim, DiffQ, Poles},
  DiffQ = ! ScaleFreeQ[MBVars /. Cases[MBVars, Q_Subscript :> (Q -> 1)]];
  If[DiffQ,
     Sub = Cases[MBVars, Q_Subscript :> (Q -> 1)],
     Sub = Cases[MBVars, Q_Subscript :> (Q -> MBCHScaleX)]];
  SerOut = SafeEval[Quiet[Silent[
     EvaluateSeries[ResolveOut, Sub, Chart, RearrangeSeries -> True]]]];
  If[! ListQ[SerOut] || Length[SerOut] < 5, Return[$Failed]];
  If[SerOut[[5]] =!= True, Return[$Failed]];
  If[DiffQ,
   Inv = Null,
   Inv = ! FreeQ[SerOut[[2]],
      Power[MBCHScaleX, _?(! FreeQ[#, Subscript[n, _]] &&
         MatchQ[#, Times[-1, _] | Plus[_, Times[-1, _]]] &)]];
   Inv = Inv || ! FreeQ[SerOut[[2]], Power[Power[MBCHScaleX, -1], _]]];
  Parts = Table[
    SafeEval[RegulateSub[SerOut[[2, I1]],
       DeleteDuplicates[Cases[{SerOut[[4, I1]]}, (W_ >= 0) :> W, Infinity]],
       Inv, Ord]],
    {I1, SerOut[[1]]}];
  If[! FreeQ[Parts, $Failed], Return[$Failed]];
  Total1 = Total[Parts];
  Total1 = Total1 /. MBCHSumRules;
  If[Pick === 0,
   Fin = SafeEval[Quiet[TimeConstrained[
      Normal[Series[Total1, {MBCHDel, 0, 0}]], 600, $Failed]]];
   If[Fin === $Failed, Return[$Failed]];
   If[! FreeQ[Fin, MBCHDel], Return[$Failed]],
   Poles = SafeEval[Quiet[TimeConstrained[
      Table[Simplify[SeriesCoefficient[Total1, {MBCHDel, 0, M}]],
            {M, -Pick - 2, -1}], 600, $Failed]]];
   If[Poles === $Failed, Return[$Failed]];
   If[! FreeQ[Poles, MBCHDel], Return[$Failed]];
   If[AnyTrue[Poles, ! TrueQ[Quiet[PossibleZeroQ[#]]] &], Return[$Failed]];
   Fin = SafeEval[Quiet[TimeConstrained[
      Simplify[SeriesCoefficient[Total1, {MBCHDel, 0, Pick}]], 600, $Failed]]];
   If[Fin === $Failed, Return[$Failed]];
   If[! FreeQ[Fin, MBCHDel], Return[$Failed]]];
  If[DiffQ,
   Lim = Quiet[Simplify[Fin]],
   Lim = SafeEval[Quiet[TimeConstrained[
      Limit[Simplify[Fin], MBCHVarY -> 1, Direction -> "FromBelow"], 600, $Failed]]];
   If[Lim === $Failed || ! FreeQ[Lim, MBCHVarY] ||
      ! FreeQ[Lim, S | H | Global`LinInf] || DirtyQ[Lim],
      Lim = SafeEval[LimitToOne[Fin]]]];
  If[Lim === $Failed, Return[$Failed]];
  If[! FreeQ[Lim, MBCHVarY], Return[$Failed]];
  If[DirtyQ[Lim], Return[$Failed]];
  Return[Lim]];


(* ::Subsubsection::Closed:: *)
(*PolyGamma to Gamma*)


PolyGammaRoute[IntVar_, MBVars_, Num_, Den_] := Module[
  {Vars, Slots, Rep, ResolveOut, Val, Start, Res},
  Vars = Keys[IntVar];
  If[Length[Vars] =!= 1, Return[$Failed]];
  Slots = Flatten[Position[Num, {0, _}, {1}]];
  If[Slots === {}, Return[$Failed]];
  Start = AbsoluteTime[];
  Res = Catch[
    Do[
     Module[{ArgX, NewNum, NewDen, Where},
      If[AbsoluteTime[] - Start > MBCHRegBudget, Break[]];
      ArgX = Num[[P, 2]];
      NewNum = Delete[Num, P];
      NewDen = Den;
      Where = Position[NewNum, ArgX, {1}, 1];
      If[Where =!= {},
         NewNum = ReplacePart[NewNum, First[First[Where]] -> ArgX + MBCHDel],
         NewNum = Append[NewNum, ArgX + MBCHDel];
         NewDen = Append[NewDen, ArgX]];
      Rep = SafeEval[Quiet[Silent[
         MBRep[1, IntVar, MBVars, {NewNum, NewDen},
            TakeLimit -> {MBCHDel -> 0}]]]];
      If[! ListQ[Rep], Continue[]];
      ResolveOut = SafeEval[Quiet[Silent[ResolveMB[Rep]]]];
      If[! ListQ[ResolveOut] || Length[ResolveOut] < 7, Continue[]];
      Do[
       Val = SafeEval[RegulateChart[ResolveOut, MBVars, K, 2, 1]];
       If[Val === $Failed && AbsoluteTime[] - Start < MBCHRegBudget,
          Val = SafeEval[RegulateChart[ResolveOut, MBVars, K, 3, 1]]];
       If[Val =!= $Failed,
        VPrint["        PolyGamma route: slot ", P, ", series ", K];
        Throw[Val, "PG"]],
       {K, ResolveOut[[7]]}]],
     {P, Slots}];
    $Failed, "PG"];
  Return[Res]];


(* ::Subsubsection::Closed:: *)
(*MBRegulate*)


MBRegulate[IntVar_, MBVars_, Num_, Den_] := Module[
  {Vars, Rep, ResolveOut, Val, Start, Slots, Res, Charts},
  Vars = Keys[IntVar];
  If[Length[Vars] =!= 1, Return[$Failed]];
  Start = AbsoluteTime[];
  Slots = Range[Min[MBCHRegSlots, Length[Num]]];
  If[0 < MBCHRegGood <= Length[Num], Slots = Prepend[Slots, MBCHRegGood]];
  Slots = DeleteDuplicates[Slots];
  Res = Catch[
    Do[
     Module[{NewNum},
      If[AbsoluteTime[] - Start > MBCHRegBudget, Break[]];
      NewNum = Num;
      If[Head[NewNum[[SlotN]]] === List,
         NewNum[[SlotN]] = {NewNum[[SlotN, 1]], NewNum[[SlotN, 2]] + MBCHDel},
         NewNum[[SlotN]] = NewNum[[SlotN]] + MBCHDel];
      Rep = SafeEval[Quiet[Silent[
         MBRep[1, IntVar, MBVars, {NewNum, Den}, TakeLimit -> {MBCHDel -> 0}]]]];
      If[! ListQ[Rep], Continue[]];
      ResolveOut = SafeEval[Quiet[Silent[ResolveMB[Rep]]]];
      If[! ListQ[ResolveOut] || Length[ResolveOut] < 7, Continue[]];
      (* last good chart first, and order 1 on every chart before any order 2 (5x dearer) *)
      Charts = Range[ResolveOut[[7]]];
      If[MemberQ[Charts, MBCHRegChart], Charts = DeleteDuplicates[Prepend[Charts, MBCHRegChart]]];
      Do[
       Do[
        If[RegOrd === 2 && AbsoluteTime[] - Start > MBCHRegBudget, Break[]];
        Val = SafeEval[RegulateChart[ResolveOut, MBVars, K, RegOrd, 0]];
        If[Val =!= $Failed,
         MBCHRegGood = SlotN;
         MBCHRegChart = K;
         VPrint["        regulator: slot ", SlotN, ", series ", K, ", order ", RegOrd];
         Throw[Val, "Reg"]],
        {K, Charts}],
       {RegOrd, {1, 2}}]],
     {SlotN, Slots}];
    $Failed, "Reg"];
  If[Res =!= $Failed, Return[Res]];
  Return[SafeEval[PolyGammaRoute[IntVar, MBVars, Num, Den]]]];


(* ::Section::Closed:: *)
(*MBCH2MPL*)


(* ::Subsection::Closed:: *)
(*Internal Modules*)


(* ::Subsubsection::Closed:: *)
(*Parallel Solving*)


(* load the package into the subkernels once, at load time: loaded later they misbehave *)
LoadWorkers[] := Module[{Got, Probe, Want, Seen},
  MBResumParallelOk = False;
  If[$KernelID =!= 0, Return[False]];
  If[! TrueQ[MBCHParallel], Return[False]];
  If[$KernelCount < 2, Return[False]];
  Got = With[{F = MBResumFile, D = Directory[], P = $Path},
    Quiet[ParallelEvaluate[
      If[Length[DownValues[MBSolveOne]] === 0,
       $Path = P;
       SetDirectory[D];
       Global`$KernelLaunch = 0;
       Block[{$Output = {}, $Messages = {}}, Get[F]]];
      Length[DownValues[MBSolveOne]] > 0]]];
  If[! ListQ[Got] || ! AllTrue[Got, TrueQ], Return[False]];
  (* self-test: every subkernel must reproduce the master on a small known structure *)
  Probe = {1, {{MBCHCanonVar[[1]] -> -1/2}, {1}, {-MBCHCanonVar[[1]], MBCHCanonVar[[1]]}, {}}};
  Want = SolveTask[Probe];
  Seen = With[{Pb = Probe}, Quiet[ParallelEvaluate[SolveTask[Pb]]]];
  MBResumParallelOk = ListQ[Seen] && ! DirtyQ[Want] && AllTrue[Seen, (# === Want) &];
  Return[MBResumParallelOk]];

(* parallel only if the self-test passed and every kernel still holds the package *)
WorkersReady[] := Module[{Got},
  If[! TrueQ[MBCHParallel] || ! TrueQ[MBResumParallelOk], Return[False]];
  If[$KernelCount < 2, Return[False]];
  Got = Quiet[ParallelEvaluate[Length[DownValues[MBSolveOne]] > 0]];
  If[ListQ[Got] && AllTrue[Got, TrueQ], Return[True]];
  MBResumParallelOk = False;
  Return[False]];

SyncWorkers[] := DistributeDefinitions[MBCHScale, MBCHVerbose, MBCHComplex, MBCHVerifyDiff, MBCHTol,
   MBCHSeriesTerms, MBCHNumTime, MBCHProbe, MBCHChartTime, MBCHChartBudget,
   MBCHRegTime, MBCHRegBudget, MBCHRegSlots, MBCHRegGood, MBCHRegChart];

(* the regulator slot and chart the workers found most often become the master's next guess *)
LearnFromWorkers[] := Module[{Seen, Slot, Chart},
  Seen = Quiet[ParallelEvaluate[{MBCHRegGood, MBCHRegChart}]];
  If[! ListQ[Seen], Return[Null]];
  Seen = Select[Seen, MatchQ[#, {_Integer?Positive, _Integer?Positive}] &];
  If[Seen === {}, Return[Null]];
  {Slot, Chart} = First[Commonest[Seen]];
  MBCHRegGood = Slot;
  MBCHRegChart = Chart;
  Return[Null]];

SolveTask[Task_] := Module[{Val},
  MBResumJ = Task[[1]];
  Val = SafeEval[MBSolveOne @@ Task[[2]]];
  Return[Val]];

(* a structure whose subkernel died, or that aborted, counts as not solved *)
CleanVal[Val_] := If[Val === $Failed || ! FreeQ[Val, $Aborted], Indeterminate, Val];

(* structures are independent: solve the new ones in parallel; a crash costs one kernel *)
SolveAll[Tasks_] := Module[{New, Res},
  New = Select[Tasks, ! KeyExistsQ[MBSolveCache, #[[2]]] &];
  New = DeleteDuplicatesBy[New, Last];
  Which[
   New === {}, Null,
   Length[New] > 1 && WorkersReady[],
    SyncWorkers[];
    Say["Solving " <> ToString[Length[New]] <> " structures on " <> ToString[$KernelCount] <> " kernels ..."];
    Res = Block[{Parallel`Settings`$RecoveryMode = "Abandon"},
      ParallelMap[SolveTask, New, Method -> "FinestGrained"]];
    LearnFromWorkers[],
   True,
    Res = Map[SolveTask, New]];
  If[New =!= {},
   Do[MBSolveCache[New[[K, 2]]] = CleanVal[Res[[K]]], {K, Length[New]}]];
  Return[Map[MBSolveCache[#[[2]]] &, Tasks]]];


(* ::Subsubsection::Closed:: *)
(*Leading Pole*)


(* Exponent[] misses poles in unexpanded denominators; Together per term finds them *)
TermPower[T_] := Module[{Tog, NumP, DenP},
  Tog = Together[T];
  NumP = Exponent[Numerator[Tog], ep, Min];
  DenP = Exponent[Denominator[Tog], ep, Min];
  Return[NumP - DenP]];

LowestPower[Fn_] := Module[{Terms, Pows},
  Terms = If[Head[Fn] === Plus, List @@ Fn, {Fn}];
  Terms = DeleteCases[Terms, 0];
  If[Terms === {}, Return[Infinity]];
  Pows = Map[TermPower, Terms];
  Return[Min[Pows]]];


(* ::Subsubsection::Closed:: *)
(*Solving One Structure*)


MBSolveOne[IntVar_, MBVars_, Num_, Den_] :=
 MBSolveOne[IntVar, MBVars, Num, Den] = Module[
  {Sub, Ref, Got, ResolveOut, Order1, Kind, Val, Best, Clean, Spent, T0, Pr, Res, Verdict},
  Sub = Cases[MBVars, Q_Subscript :> (Q -> 1)];
  Ref = MBVerify[IntVar, MBVars, Num, Den];
  If[ScaleFreeQ[MBVars /. Sub], Pr = {}, Pr = ProbeRule[]];
  Say["Obtaining series solutions ..."];
  Got = MBGetSeries[IntVar, MBVars, Num, Den];
  If[Got =!= $Failed, MBResumStatus = "Series solution obtained!"];
  If[Got === $Failed, Return[Indeterminate]];
  {ResolveOut, Order1, Kind} = Got;
  If[Kind === "Multi",
   Res = Total[Table[
      Module[{RO, Ord1, V},
       RO = SafeEval[Quiet[Silent[
          ResolveMB[ResolveOut, MBNumber -> J]]]];
       If[! ListQ[RO] || Length[RO] < 7, Indeterminate,
        Ord1 = Ordering[Quiet[Check[Map[Length, RO[[1]]],
                                    ConstantArray[0, RO[[7]]]]]];
        V = Catch[
          Do[
           Module[{W},
            W = TimeConstrained[MBSumSeries[RO, Sub, K], MBCHChartTime, $Failed];
            If[W =!= $Failed && ! DirtyQ[W], Throw[W, "One"]]],
           {K, Ord1}];
          Indeterminate, "One"];
        V]],
      {J, Order1}]];
   (* MBRep split the contour, so only the total can be checked against it *)
   Verdict = ValueOkQ[Res, Ref];
   If[Verdict === False,
    VPrint["        multi-piece total contradicts the contour"];
    Return[Indeterminate]];
   If[Verdict === $Failed, VPrint["        multi-piece total unverified"]];
   Return[Res]];
  Best = $Failed;
  Clean = {};
  Spent = 0;
  Res = Catch[
    Do[
     If[Spent > MBCHChartBudget, Break[]];
     T0 = AbsoluteTime[];
     Say["Series solution obtained!"];
     Say["Resumming with EvaluateMultiSums " <> ToString[MBResumJ] <>
         "/" <> ToString[MBResumN]];
     Val = TimeConstrained[MBSumSeries[ResolveOut, Sub, K], MBCHChartTime, $Failed];
     Spent = Spent + (AbsoluteTime[] - T0);
     If[Val === $Failed || DirtyQ[Val],
      Say["EvaluateMultiSums failed! Deriving another series solution."]];
     If[Val =!= $Failed && ! DirtyQ[Val],
      (* judge the series, then the closed form, then a second chart; never accept unjudged *)
      Verdict = SeriesOkQ[ResolveOut, Sub, K, Ref, Pr];
      If[Verdict === $Failed, Verdict = ValueOkQ[Val, Ref]];
      Which[
       Verdict === True,
        VPrint["        series ", K, " verified against the contour"];
        Throw[Val, "Chart"],
       Verdict === False,
        VPrint["        series ", K, " contradicts the contour"],
       True,
        If[AnyTrue[Clean, AgreeQ[#, Val] &],
         VPrint["        series ", K, " corroborated by another"];
         Throw[Val, "Chart"]];
        AppendTo[Clean, Val];
        If[Best === $Failed, Best = Val]]],
     {K, Order1}];
    If[Ref =!= $Failed, Indeterminate,
       If[Best === $Failed, Indeterminate, Best]],
    "Chart"];
  If[! DirtyQ[Res], Return[Res]];
  Say["Using the analytic regulator!"];
  Val = SafeEval[MBRegulate[IntVar, MBVars, Num, Den]];
  (* DirtyQ only checks that the S-sums convert, so convert the regulator result here *)
  If[Val =!= $Failed, Val = SumsToMPL[Val]];
  If[Val =!= $Failed && ! DirtyQ[Val], Return[Val]];
  Return[Res]];


(* ::Subsection:: *)
(*External Module*)


(* ::Subsubsection::Closed:: *)
(*MBCH2MPL*)


Options[MBCH2MPL] = {Verbose -> False, BarnesReduce -> True, Complex -> False};

MBCH2MPL[MBInt_, {Eps_, Ord_}, opts : OptionsPattern[]] :=
  MBCH2MPL[MBInt, Automatic, {Eps, Ord}, opts];

MBCH2MPL[MBInt_, MBVar_, {Eps_, Ord_}, OptionsPattern[]] := Module[
  {Expanded, IntVars, Low, Res, Coeffs, K, Tmp},
  MBCHVerbose = TrueQ[OptionValue[Verbose]];
  SetComplex[TrueQ[OptionValue[Complex]]];
  MBResumLog = {};
  Say["Starting ..."];
  If[$FrontEnd =!= Null, Tmp = PrintTemporary[Dynamic[MBResumStatus]]];
  VPrint["MBCH2MPL: expansion of the integral through ", Eps, "^", Ord];

  Expanded = MBRexExp[MBInt, Eps, Ord, BarnesReduce -> OptionValue[BarnesReduce]];
  VPrint["  MBRexExp    : ", Length[Expanded], " MB integrals"];

  IntVars = Flatten[Map[Keys[#[[2, 2]]] &, Expanded]];
  IntVars = DeleteDuplicates[IntVars];

  (* the kinematic variables are what is left after the regulator and MB variables *)
  If[MBVar === Automatic,
   MBCHScale = Cases[Expanded, Q_Symbol /; Context[Q] =!= "System`" :> Q,
      {0, Infinity}];
   MBCHScale = DeleteDuplicates[MBCHScale];
   MBCHScale = Complement[MBCHScale, Join[IntVars, MBCHCanonVar, {ep, Eps}]];
   MBCHScale = Select[MBCHScale, FreeQ[Attributes[#], Protected] &],
   MBCHScale = If[Head[MBVar] === List, MBVar, {MBVar}];
   MBCHScale = Select[MBCHScale, Head[#] === Symbol &]];
  VPrint["  kinematics  : ", If[MBCHScale === {}, "none (scaleless)", MBCHScale]];

  Low = Min[Map[LowestPower[#[[1]]] &, Expanded]];
  If[! IntegerQ[Low] || Low > Ord, Low = Ord];
  (* MBCHFromOrder starts the harvest later, so a kernel death costs one coefficient *)
  If[IntegerQ[MBCHFromOrder], Low = Max[Low, Min[MBCHFromOrder, Ord]]];

  (* every order's distinct structures in one batch keeps all kernels busy; the orders then read the cache *)
  If[WorkersReady[],
   SolveAll[Flatten[Table[GroupTasks[OrderGroups[Expanded, K]], {K, Low, Ord}], 1]]];
  Coeffs = Table[MBCH2MPLOrder[Expanded, IntVars, K], {K, Low, Ord}];
  Res = Total[Table[Coeffs[[K - Low + 1]]*Eps^K, {K, Low, Ord}]];
  Say["Done!"];
  VPrint["  done."];
  Return[Res]];

OrderGroups[Expanded_, Ord_] := Module[{Structs},
  Structs = {};
  Cases[Expanded,
   MBint[Fn_, {_, IntV_}] :>
    Module[{Coef, Terms},
     Coef = CoefOf[Fn, ep, Ord];
     Which[
      Coef === 0, Null,
      IntV === {},
        AppendTo[Structs, {Coef, Null, Null, Null, Null, Null}],
      True,
        Terms = If[Head[Coef] === Plus, List @@ Coef, {Coef}];
        Do[
         Module[{Split1, Canon},
          Split1 = MBCHInput[T1, Keys[IntV]];
          Canon = MBCanonlise[IntV, Split1[[2]], Split1[[3]], Split1[[4]]];
          AppendTo[Structs, Join[{Split1[[1]]}, Canon]]],
         {T1, Terms}]]],
   Infinity];
  If[Structs === {}, Return[{}]];
  Return[Values[GroupBy[Structs, GroupKey]]]];

GroupTasks[Groups_] := Module[{Tasks},
  Tasks = Select[Range[Length[Groups]], Groups[[#, 1, 2]] =!= Null &];
  Return[Map[{#, Groups[[#, 1, 2 ;; 5]]} &, Tasks]]];

MBCH2MPLOrder[Expanded_, IntVars_, Ord_] := Module[
  {Groups, Res, Bad, Total1, Tasks, Vals},
  Groups = OrderGroups[Expanded, Ord];
  If[Groups === {}, Return[0]];
  VPrint["  eps^", Ord, "      : ", Length[Flatten[Groups, 1]], " structures -> ", Length[Groups], " distinct"];

  MBResumN = Length[Groups];
  Tasks = GroupTasks[Groups];
  Vals = AssociationThread[Map[First, Tasks], SolveAll[Tasks]];

  Total1 = 0;
  Do[
   Module[{G, Coef, Val},
    G = Groups[[J]];
    If[G[[1, 2]] === Null,
     Total1 = Total1 + Total[G[[All, 1]]],
     Coef = Total[Map[(#[[1]]*#[[6]]) &, G]];
     Val = Vals[J];
     If[Val === $Failed || DirtyQ[Val],
        VPrint["        structure ", J, "/", Length[Groups], " NOT solved"]];
     Total1 = Total1 + Coef*Val]],
   {J, Length[Groups]}];

  Bad = Select[IntVars, ! FreeQ[Total1, #] &];
  Bad = Join[Bad, Select[MBCHCanonVar, ! FreeQ[Total1, #] &]];
  Bad = Join[Bad, Select[{Global`sinf, Global`LinInf}, ! FreeQ[Total1, #] &]];
  If[! FreeQ[Total1, S], Bad = Append[Bad, S]];
  If[LeakQ[Total1], Bad = Append[Bad, "leak"]];
  If[Bad =!= {}, Return[MBFailed[Bad]]];

  Res = Total1 /. Q_Symbol /;
     StringMatchQ[SymbolName[Q], "z" ~~ DigitCharacter ..] :>
     Zeta[ToExpression[StringDrop[SymbolName[Q], 1]]];
  Res = TidyResult[Res];
  Return[Res]];


(* ::Section::Closed:: *)
(*End Package*)


End[];
EndPackage[];
$ContextPath = DeleteDuplicates[Join[$ContextPath,
   DeleteCases[MBResumOuterPath, "Global`"]]];
MBAnalytica`Resum`Private`LoadWorkers[];
