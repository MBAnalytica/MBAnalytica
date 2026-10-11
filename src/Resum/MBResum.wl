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
MBVerifyCache = <||>;       (* contour value of each structure *)
MBSeriesCache = <||>;       (* expanded charts of the structure being solved *)
MBCHTaskMem   = Infinity;   (* bytes one structure may use on a subkernel; Infinity = no cap *)
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


(* an H letter strictly inside (0,1) at argument 1 lies on the integration path, so that H sits
   on its branch cut; only a divergent S-sum (the SinfToL fallback) produces one *)
OnPathQ[Expr_] := Module[{Pr, Hs},
  Pr = LetterProbe[];
  Hs = Cases[Expr, H[L__, 1] /; AnyTrue[{L}, Quiet[TrueQ[0 < N[# /. Pr] < 1]] &], {0, Infinity}];
  Return[Hs =!= {}]];


DirtyQ[Val_] := Module[{Res},
  Res = SumsToMPL[Val];
  If[LeakQ[Res], Return[True]];
  If[OnPathQ[Res], Return[True]];
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
(*Barnes Lemmas*)


(* each Barnes step acts on one integral at a time, so it maps onto the subkernels *)
BarnesMap[F_, Ints_] := Module[{Res},
  If[Length[Ints] < 4,
     Res = Map[F, Ints],
     Res = Block[{Parallel`Settings`$RecoveryMode = "Abandon"},
        ParallelMap[F, Ints, Method -> "FinestGrained"]]];
  Res = Flatten[Res];
  If[! VectorQ[Res, (Head[#] === MBint) &], Throw[$Failed, "Barnes"]];
  Return[Res]];

(* DoAllBarnes with its per-integral steps in parallel; the merges stay on the master *)
ParBarnes[Ints_] := Module[{Res, Prev, Low},
  Res = Flatten[Map[BarnesRoutines`ExpandInt, Ints]];
  Prev = {};
  While[Union[Res] =!= Union[Prev],
   Prev = Res;
   Low = Select[Res, BarnesRoutines`MBDimension[#] < 1 &];
   Res = Select[Res, BarnesRoutines`MBDimension[#] >= 1 &];
   Res = BarnesMap[BarnesRoutines`DoBarnes2, Res];
   Res = Flatten[Map[BarnesRoutines`ExpandInt, Res]];
   Res = MBmerge[Join[Res, Low]];
   Res = Flatten[Map[BarnesRoutines`ExpandInt, Res]];
   Low = Select[Res, BarnesRoutines`MBDimension[#] < 1 &];
   Res = Select[Res, BarnesRoutines`MBDimension[#] >= 1 &];
   Res = BarnesMap[BarnesRoutines`DoBarnes1, Res];
   Res = Flatten[Map[BarnesRoutines`ExpandInt, Res]];
   Res = MBmerge[Join[Res, Low]];
   Res = Flatten[Map[BarnesRoutines`ExpandInt, Res]]];
  Return[Res]];

BarnesAll[Ints_] := Module[{Res},
  If[! WorkersReady[], Return[DoAllBarnes[Ints, False]]];
  Res = Catch[ParBarnes[Ints], "Barnes"];
  If[Res === $Failed, Res = DoAllBarnes[Ints, False]];
  Return[Res]];


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
     Barnesed = Silent[Quiet[TimeConstrained[BarnesAll[Expanded], 600, Expanded]]];
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
   NumK, DenK, Key, CanVar, ShiftFac, IntVarC, NumA, DenA},
  Vars = Keys[IntVar];
  Vals = Values[IntVar];
  NVar = Length[Vars];
  If[NVar === 0 || NVar > 4, Return[{IntVar, MBVars, Num, Den, 1}]];
  Best = Null;
  BestKey = Null;
  (* the argument parts do not depend on the permutation *)
  NumA = Map[ArgParts[#, Vars] &, Num];
  DenA = Map[ArgParts[#, Vars] &, Den];
  Do[
   PMBVars = MapIndexed[
      If[MatchQ[#1, Subscript[MBCHScaleX, _]], Subscript[MBCHScaleX, First[#2]], #1] &,
      MBVars[[Perm]]];
   NumP = Map[{#[[1]], #[[2]], #[[3]][[Perm]]} &, NumA];
   DenP = Map[{#[[1]], #[[2]], #[[3]][[Perm]]} &, DenA];
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


(* a chart is expanded for its convergence, its resummation and its check: expand it once per structure *)
SeriesOf[ResolveOut_, Sub_, Chart_] := Module[{Key1, SerOut},
  Key1 = {Hash[ResolveOut], Sub, Chart};
  If[KeyExistsQ[MBSeriesCache, Key1], Return[MBSeriesCache[Key1]]];
  SerOut = SafeEval[Quiet[Silent[
     EvaluateSeries[ResolveOut, Sub, Chart, RearrangeSeries -> True]]]];
  MBSeriesCache[Key1] = SerOut;
  Return[SerOut]];


(* True = matches the contour, False = wrong, $Failed = cannot judge; keep all three apart *)
SeriesOkQ[ResolveOut_, Sub_, Chart_, Ref_, Pr_] := Module[{SerOut, Val},
  If[Ref === $Failed, Return[$Failed]];
  SerOut = SeriesOf[ResolveOut, Sub, Chart];
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
     SerOut = SeriesOf[ResolveOut, Sub, K];
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
MBVerify[IntVar_, MBVars_, Num_, Den_] := Module[{Key1, Sub, Pr, Res},
  Key1 = {IntVar, MBVars, Num, Den};
  If[KeyExistsQ[MBVerifyCache, Key1], Return[MBVerifyCache[Key1]]];
  Sub = Cases[MBVars, Q_Subscript :> (Q -> 1)];
  Pr = If[ScaleFreeQ[MBVars /. Sub], {}, ProbeRule[]];
  If[Pr =!= {} && ! TrueQ[MBCHVerifyDiff],
     Res = $Failed,
     Res = SafeEval[ContourValue[IntVar, MBVars, Num, Den, Pr]]];
  MBVerifyCache[Key1] = Res;
  Return[Res]];


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
  SerOut = SeriesOf[ResolveOut, Sub, Chart];
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
  If[Length[Vars] === 2, Return[RegulateSub2[Summand, Vars, RuleY, Ord]]];
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


(* Gamma and PolyGamma arguments of the numerator; 1/Gamma has no poles *)
NumGammaArgs[Sm_, Idxs_] := Module[{Top, Args},
  Top = If[Head[Sm] === Times, Numerator[Sm], Sm];
  Args = Cases[Top, (Gamma[A_] | PolyGamma[_, A_]) :> A, {0, Infinity}];
  Return[Select[Args, ! FreeQ[#, Alternatives @@ Idxs] &]]];

(* an argument that reaches a pole somewhere with every index >= 1 *)
ArgPoleQ[A_, Idxs_] := Module[{Const, Cofs},
  Const = (A /. MBCHDel -> 0) /. Map[(# -> 0) &, Idxs];
  Cofs = Map[Coefficient[A, #] &, Idxs];
  If[! IntegerQ[Const] || ! VectorQ[Cofs, IntegerQ], Return[False]];
  If[AnyTrue[Cofs, (# < 0) &], Return[True]];
  Return[Const + Total[Cofs] <= 0]];

(* the first index value from which the argument stays off the poles *)
ArgStart[A_, Idx_] := Module[{Const, Cof},
  Const = (A /. MBCHDel -> 0) /. Idx -> 0;
  Cof = Coefficient[A, Idx];
  If[! IntegerQ[Const] || ! IntegerQ[Cof], Return[1]];
  If[Cof <= 0, Return[Infinity]];
  Return[Max[1, Ceiling[(1 - Const)/Cof]]]];

(* the regulated summand, expanded from its lowest power of the regulator and summed from 1 in every index *)
RegSum[Sm_, Idxs_, RuleY_, Ord_] := Module[{Ser, Lo, Res},
  If[AnyTrue[NumGammaArgs[Sm, Idxs], ArgPoleQ[#, Idxs] &], Return[$Failed]];
  Ser = Quiet[Series[Sm, {MBCHDel, 0, Ord}]];
  Lo = If[Head[Ser] === SeriesData, Ser[[4]]/Ser[[6]], 0];
  If[! IntegerQ[Lo], Return[$Failed]];
  Res = Sum[
    MBCHDel^M*SafeEval[Quiet[Silent[
       TimeConstrained[
         EvaluateMultiSum[
           Evaluate[Simplify[Fold[ShiftUp, SeriesCoefficient[Sm, {MBCHDel, 0, M}], Idxs] /. RuleY]],
           Evaluate[Map[{#, 1, Infinity} &, Idxs]],
           Assumptions -> (0 < MBCHVarY < 1 && ScaleAssum[])],
         MBCHRegTime, $Failed]]]],
    {M, Lo, Ord}];
  If[! FreeQ[Res, $Failed], Return[$Failed]];
  Return[Res]];

(* one index: terms where a Gamma still sits on a pole are kept whole, the rest is summed *)
RegSum1[Sm_, Idx_, RuleY_, Ord_] := Module[{Start, Peel, Rest},
  Start = Max[Join[{1}, Map[ArgStart[#, Idx] &, NumGammaArgs[Sm, {Idx}]]]];
  If[Start > 8, Return[$Failed]];
  Peel = Sum[Quiet[Simplify[(Sm /. Idx -> J) /. RuleY]], {J, 1, Start - 1}];
  Rest = RegSum[Sm /. Idx -> Idx + Start - 1, {Idx}, RuleY, Ord];
  If[Rest === $Failed, Return[$Failed]];
  Return[Peel + Rest]];

(* two indices: the corner and both faces keep the regulator live until peeled, the bulk is expanded *)
RegulateSub2[Summand_, Vars_, RuleY_, Ord_] := Module[{N1, N2, Sm, Corner, Face1, Face2, Bulk},
  N1 = Vars[[1]];
  N2 = Vars[[2]];
  Sm = DeTrig[Summand, Vars];
  Sm = Quiet[Refine[Sm, Element[N1, Integers] && Element[N2, Integers] && N1 >= 0 && N2 >= 0]];
  Corner = Quiet[Simplify[(Sm /. {N1 -> 0, N2 -> 0}) /. RuleY]];
  Face1 = RegSum1[DeTrig[Sm /. N1 -> 0, {N2}], N2, RuleY, Ord];
  Face2 = RegSum1[DeTrig[Sm /. N2 -> 0, {N1}], N1, RuleY, Ord];
  Bulk = RegSum[Sm, {N1, N2}, RuleY, Ord];
  If[! FreeQ[{Corner, Face1, Face2, Bulk}, $Failed], Return[$Failed]];
  Return[Corner + Face1 + Face2 + Bulk]];


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
  SerOut = SeriesOf[ResolveOut, Sub, Chart];
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
   (* Limit segfaults the kernel on some H and S expressions: leave those to LimitToOne *)
   If[FreeQ[Fin, S | H],
      Lim = SafeEval[Quiet[TimeConstrained[
         Limit[Simplify[Fin], MBCHVarY -> 1, Direction -> "FromBelow"], 600, $Failed]]],
      Lim = $Failed];
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
  If[Length[Vars] > 2, Return[$Failed]];
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
(*Abel Summation*)


(* ::Subsection::Closed:: *)
(*Internal Modules*)


(* ::Subsubsection::Closed:: *)
(*Scales Kept Live*)


(* A scaleless MB integral I = Int f(z) dz equals lim_{y->1} I(y), I(y) = Int y^(w.z) f(z) dz,
   since the Gamma functions decay exponentially along the contour.  Setting the artificial
   scales to 1 BEFORE summing drops every Log[y] * (divergent sum) product, which has a finite
   limit, and leaves sub-series that diverge on their own.  Here the scales stay y^w, with the
   weights w chosen so that every index advances y at rate 0 or 1; rate-1 indices are summed one
   diagonal at a time, and the limit y -> 1 is taken on the total, where the divergences cancel. *)



AbelTime = 600;       (* seconds allowed for one EvaluateMultiSum *)
AbelTraceFile = None; (* a file name turns on a trace that survives a kernel crash *)

AbelTrace[Msg_] := Module[{Strm},
  If[AbelTraceFile === None, Return[Null]];
  Strm = OpenAppend[AbelTraceFile];
  WriteString[Strm, ToString[Round[SessionTime[], 0.1]] <> " s  " <> Msg <> "\n"];
  Close[Strm];
  Return[Null]];
AbelDiag = AbelNN;    (* index running along the diagonals *)
AbelUseLimit = True;  (* try Mathematica's Limit, on expressions free of S and H, after the G expansion *)
AbelBudget = 900;     (* seconds of plain Abel summation per structure *)
RegAbelBudget = 1800; (* seconds of regulated Abel summation per structure *)


(* the summation indices of one sub-series, read off its condition *)
AbelIdx[SerOut_, I1_] := DeleteDuplicates[Cases[{SerOut[[4, I1]]}, (W_ >= 0) :> W, Infinity]];


(* split powers and logs of products of scales, (X1/X2)^n -> X1^n X2^-n, so each scale stands alone *)
AbelSplit[Sm_] := Sm /. {
  Power[B_, E1_] /; Head[B] =!= AbelX && ! FreeQ[B, AbelX] && FreeQ[B, Plus] :> PowerExpand[Power[B, E1]],
  (* a kinematic factor such as 1 - u is positive, so (c X)^n = c^n X^n as well *)
  Power[B_Times, E1_] /; ! FreeQ[B, AbelX] :> Times @@ Map[Power[#, E1] &, List @@ B],
  Log[B_] /; Head[B] =!= AbelX && ! FreeQ[B, AbelX] && FreeQ[B, Plus] :> PowerExpand[Log[B]],
  Log[B_Times] /; ! FreeQ[B, AbelX] && AllTrue[List @@ B, (! FreeQ[#, AbelX] || TrueQ[Quiet[N[# /. ProbeRule[]] > 0]]) &] :>
     Total[Map[Log, List @@ B]]};


(* rows {J, dExp/dn} for every power of an artificial scale in a summand *)
AbelRows[Sm_, Idx_] := Module[{Pows, Rows},
  Pows = Cases[Sm, Power[AbelX[J_], E1_] :> {J, E1}, {0, Infinity}];
  Pows = DeleteDuplicates[Pows];
  Rows = Map[{#[[1]], Map[Function[K, Coefficient[#[[2]], K]], Idx]} &, Pows];
  Rows = DeleteDuplicates[Rows];
  Return[Rows]];


(* weights w with sum_J w_J dExp_J/dn_K = 1 for every index of every sub-series *)
AbelWeights[SerOut_, NX_] := Module[{Eqs, Ws, Sol, Res},
  Ws = Table[Unique["abw"], {NX}];
  Eqs = {};
  Do[
   Module[{Idx, Rows},
    Idx = AbelIdx[SerOut, I1];
    If[Idx =!= {},
     Rows = AbelRows[SerOut[[2, I1]], Idx];
     Do[
      Module[{Lhs},
       Lhs = Total[Map[(Ws[[#[[1]]]]*#[[2, K]]) &, Rows]];
       AppendTo[Eqs, Lhs == 1]],
      {K, Length[Idx]}]]],
   {I1, SerOut[[1]]}];
  Eqs = DeleteDuplicates[Eqs];
  If[Eqs === {}, Return[ConstantArray[1, NX]]];
  If[MemberQ[Eqs, False], Return[$Failed]];
  Sol = Quiet[Solve[Eqs, Ws]];
  If[Sol === {} || ! ListQ[Sol], Return[$Failed]];
  Res = Ws /. First[Sol];
  (* a weight left free by the equations never multiplies an index: any value will do *)
  Res = Res /. Map[(# -> 1) &, Ws];
  If[! VectorQ[Res, NumericQ], Return[$Failed]];
  Return[Res]];


(* rates of every index of every sub-series under the weights W; $Failed if a scale has two rates *)
AbelRates[SerOut_, W_] := Module[{Res},
  Res = Table[
    Module[{Idx, Rows, Js},
     Idx = AbelIdx[SerOut, I1];
     Rows = AbelRows[SerOut[[2, I1]], Idx];
     Js = Map[First, Rows];
     If[! DuplicateFreeQ[Js], $Failed,
      If[Idx === {}, {},
       Table[Total[Map[(W[[#[[1]]]]*#[[2, K]]) &, Rows]], {K, Length[Idx]}]]]],
    {I1, SerOut[[1]]}];
  Return[Res]];

(* every index's geometric base at y = 1 (kinematic factors at the probe) is at most 1: otherwise the
   path y -> 1 leaves the region where the sub-series converges *)
AbelBasesOkQ[SerOut_, W_] := Module[{Ok},
  Ok = True;
  Do[
   Module[{Idx, Sm, Pows},
    Idx = AbelIdx[SerOut, I1];
    Sm = SerOut[[2, I1]] /. AbelRules[W];
    Pows = Cases[Sm, Power[B_, E1_] /; FreeQ[B, Alternatives @@ Idx] && ! FreeQ[E1, Alternatives @@ Idx] :> {B, E1}, {0, Infinity}];
    Pows = DeleteDuplicates[Pows];
    Do[
     Module[{Base},
      Base = Times @@ Map[(#[[1]]^Coefficient[#[[2]], Idx[[K]]]) &, Pows];
      Base = Quiet[N[Abs[(Base /. MBCHVarY -> 1) /. ProbeRule[]]]];
      If[! NumericQ[Base] || Base > 1 + 10^-9, Ok = False]],
     {K, Length[Idx]}]],
   {I1, SerOut[[1]]}];
  Return[Ok]];


(* small integer weights whose rates are all 0, 1 or 2: fewest zero rates first, then fewest 2s *)
AbelCands[SerOut_, NX_] := Module[{Grid, Good},
  Grid = Tuples[Range[-2, 2], NX];
  Grid = DeleteCases[Grid, ConstantArray[0, NX]];
  Good = Select[
    Map[{#, AbelRates[SerOut, #]} &, Grid],
    FreeQ[#[[2]], $Failed] && SubsetQ[{0, 1, 2}, DeleteDuplicates[Flatten[#[[2]]]]] && AbelBasesOkQ[SerOut, #[[1]]] &&
      (* all rates 0 is the plain sum with the scales set to 1 *)
      ! AllTrue[Flatten[#[[2]]], (# === 0) &] &];
  Good = SortBy[Good, {Count[Flatten[#[[2]]], 0], Count[Flatten[#[[2]]], 2], Total[Abs[#[[1]]]]} &];
  Return[Take[Good, Min[4, Length[Good]]]]];


AbelRules[W_] := {
  Power[AbelX[J_], E1_] :> MBCHVarY^(W[[J]]*E1),
  Log[AbelX[J_]] :> W[[J]]*Log[MBCHVarY],
  AbelX[J_] :> MBCHVarY^W[[J]]};


(* LinInf outside the upper limit of an S-sum marks a divergent sum *)
DivergentQ[R_] := Module[{Masked},
  Masked = R /. S[A___, Global`LinInf] :> S[A, AbelInf];
  Return[! FreeQ[Masked, Global`LinInf]]];

(* a summand that is not finite at generic index values (a Gamma of the index on its poles for
   every large index) needs the regulator: plain Abel summation cannot sum it *)
DegenerateQ[SerOut_] := Module[{Bad},
  Bad = False;
  Do[
   Module[{Idx, Pt, V},
    Idx = AbelIdx[SerOut, I1];
    Pt = Thread[Idx -> Take[{7, 5, 11, 4}, Length[Idx]]];
    V = Quiet[N[((SerOut[[2, I1]] /. Pt) /. {AbelX[_] -> 1/3, MBCHDel -> 1/97}) /. ProbeRule[], 20]];
    If[! NumericQ[V], Bad = True]],
   {I1, SerOut[[1]]}];
  Return[Bad]];


(* one sub-series in y: rate-0 indices innermost to infinity, rate-1 indices one diagonal at a time *)
AbelPart[Sm_, Idx_, Rates_] := Module[{Zs, Os, Sm1, Ranges, Res, Rest1, Iv},
  If[Idx === {}, Return[Sm]];
  Zs = Pick[Idx, Rates, 0];
  Os = Pick[Idx, Rates, 1];
  Sm1 = Sm;
  Iv = Idx;
  If[Length[Os] >= 2,
   Rest1 = Rest[Os];
   Sm1 = Sm1 /. Os[[1]] -> AbelDiag - Total[Rest1];
   Iv = Join[Zs, {AbelDiag}, Rest1]];
  Sm1 = DeTrig[Sm1, Iv];
  Sm1 = Quiet[Refine[Sm1, And @@ Map[(Element[#, Integers] && # >= 0) &, Iv]]];
  Ranges = Map[{#, 0, Infinity} &, Zs];
  (* mixed rates: y^(n1 + 2 n2) is geometric in each index, so the sums are plain and nested *)
  If[AnyTrue[Rates, (# > 1) &],
   Sm1 = DeTrig[Sm, Idx];
   Sm1 = Quiet[Refine[Sm1, And @@ Map[(Element[#, Integers] && # >= 0) &, Idx]]];
   Ranges = Map[{#, 0, Infinity} &, Idx[[Ordering[Rates]]]];
   Os = {}];
  Which[
   Length[Os] === 1,
    Ranges = Append[Ranges, {Os[[1]], 0, Infinity}],
   Length[Os] >= 2,
    Ranges = Join[Ranges,
      Table[{Os[[K]], 0, AbelDiag - Total[Os[[2 ;; K - 1]]]}, {K, Length[Os], 2, -1}],
      {{AbelDiag, 0, Infinity}}]];
  Res = AbelEMS[Sm1, Ranges];
  (* mixed rates: EMS may manage the other nesting when the first leaves a sum undone *)
  If[Res === $Failed && AnyTrue[Rates, (# > 1) &] && Length[Ranges] > 1,
   Res = AbelEMS[Sm1, Reverse[Ranges]]];
  Return[Res]];


(* one EvaluateMultiSum, rejected when it left a sum undone or divergent *)
AbelEMS[Sm1_, Ranges_] := Module[{Res},
  Res = SafeEval[Quiet[Silent[TimeConstrained[
     EvaluateMultiSum[Evaluate[Sm1], Evaluate[Ranges], Assumptions -> (0 < MBCHVarY < 1 && ScaleAssum[])],
     AbelTime, $Failed]]]];
  If[Res === $Failed || ! FreeQ[Res, EvaluateMultiSum], AbelTrace["   EMS failed or timed out"]; Return[$Failed]];
  If[! FreeQ[Res, Indeterminate | ComplexInfinity], AbelTrace["   EMS: Indeterminate"]; Return[$Failed]];
  If[DivergentQ[Res], AbelTrace["   EMS: divergent (LinInf)"]; Return[$Failed]];
  (* sinf: EMS could not do an inner sum; a leaked internal symbol means it stopped half way *)
  If[! FreeQ[Res, Global`sinf], AbelTrace["   EMS: sinf"]; Return[$Failed]];
  If[! FreeQ[Res, Sym_Symbol /; StringContainsQ[Context[Sym], "Private`"] &&
       StringStartsQ[Context[Sym], "HarmonicSums`" | "Sigma`" | "EvaluateMultiSums`"], {0, Infinity}, Heads -> True],
   AbelTrace["   EMS: internal symbols left"]; Return[$Failed]];
  Return[Res]];


(* the y -> 1 limit of a closed form in y: Limit first, the HPL expansion at 1 otherwise *)
AbelLimit[Val_] := Module[{Lim},
  (* the G-function expansion first: exact, and it never calls Limit *)
  Lim = SafeEval[AbelLimitG[Val]];
  If[Lim =!= $Failed, Return[Lim]];
  If[AbelUseLimit && FreeQ[Val, S | H],
   AbelTrace["limit: Limit"];
   Lim = SafeEval[Quiet[TimeConstrained[
      Limit[Val, MBCHVarY -> 1, Direction -> "FromBelow"], 300, $Failed]]]];
  If[Lim === $Failed || ! FreeQ[Lim, MBCHVarY] || ! FreeQ[Lim, S | H | Global`LinInf | Limit] ||
     DirtyQ[Lim],
   AbelTrace["limit: LimitToOne"];
   Lim = SafeEval[LimitToOne[Val]]];
  AbelTrace["limit: done"];
  If[Lim === $Failed || ! FreeQ[Lim, MBCHVarY], Return[$Failed]];
  If[DirtyQ[Lim], Return[$Failed]];
  Return[Lim]];


(* one chart of a scaleless structure by Abel summation; {value, weights, part report} *)
AbelChart[ResolveOut_, MBVars_, Chart_] := Module[
  {NX, SubX, SerOut, Cands, Res},
  NX = Length[MBVars];
  If[! MarkStage[{"abel", Chart}], Return[{$Failed, "crashed before", {}}]];
  SubX = Table[Subscript[MBCHScaleX, J] -> AbelX[J], {J, NX}];
  SerOut = SafeEval[Quiet[Silent[
     EvaluateSeries[ResolveOut, SubX, Chart, RearrangeSeries -> True]]]];
  If[! ListQ[SerOut] || Length[SerOut] < 5, Return[{$Failed, "no series", {}}]];
  If[SerOut[[5]] =!= True, Return[{$Failed, "not trivial", {}}]];
  If[! FreeQ[SerOut[[2]], Indeterminate | ComplexInfinity], Return[{$Failed, "indeterminate", {}}]];
  SerOut = ReplacePart[SerOut, 2 -> AbelSplit[SerOut[[2]]]];
  If[DegenerateQ[SerOut], Return[{$Failed, "degenerate", {}}]];
  Cands = AbelCands[SerOut, NX];
  If[Cands === {}, Return[{$Failed, "no weights", {}}]];
  Res = {$Failed, "weights failed", {}};
  Catch[
   Do[
    If[MarkStage[{"abel", Chart, C1[[1]]}], Module[{W, Rates, Parts, Report, Total1, Lim},
     W = C1[[1]];
     Rates = C1[[2]];
     Report = {};
     Parts = Catch[
       Table[
        Module[{Idx, Sm, T0, R},
         Idx = AbelIdx[SerOut, I1];
         Sm = SerOut[[2, I1]] /. AbelRules[W];
         T0 = AbsoluteTime[];
         AbelTrace["w " <> ToString[W] <> " part " <> ToString[I1] <> " rates " <> ToString[Rates[[I1]]] <> ": EvaluateMultiSum"];
         R = AbelPart[Sm, Idx, Rates[[I1]]];
         AbelTrace["part " <> ToString[I1] <> " done"];
         AppendTo[Report, {Rates[[I1]], If[R === $Failed, "failed", "ok"], Round[AbsoluteTime[] - T0, 0.1]}];
         If[R === $Failed, Throw[$Failed, "AbelPartFail"]];
         R],
        {I1, SerOut[[1]]}],
       "AbelPartFail"];
     Res = {$Failed, W, Report};
     If[ListQ[Parts] && FreeQ[Parts, $Failed],
      Total1 = Total[Parts];
      AbelTrace["chart " <> ToString[Chart] <> ": limit of " <> ToString[LeafCount[Total1]] <> " leaves"];
      Lim = AbelLimit[Total1];
      Res = {Lim, W, Report};
      If[Lim =!= $Failed, Throw[Null, "AbelW"]]]]],
    {C1, Cands}],
   "AbelW"];
  Return[Res]];


(* every chart in turn, within the budget; the first value that matches the contour wins,
   or, when no contour can be integrated, the first clean one *)
AbelFrom[ResolveOut_, Order1_, MBVars_, Ref_] := Module[{Start, Res},
  Start = AbsoluteTime[];
  Res = Catch[
    Do[
     Module[{Out, Verdict},
      If[AbsoluteTime[] - Start > AbelBudget, Break[]];
      Out = AbelChart[ResolveOut, MBVars, K];
      VPrint["        Abel chart ", K, ": weights ", Out[[2]], ", parts ", Out[[3]]];
      If[Out[[1]] =!= $Failed,
       Verdict = ValueOkQ[Out[[1]], Ref];
       VPrint["        Abel chart ", K, ": contour check ", Verdict];
       If[Verdict === True, Throw[Out[[1]], "Abel"]];
       If[Verdict === $Failed && Ref === $Failed, Throw[Out[[1]], "Abel"]]]],
     {K, Order1}];
    $Failed, "Abel"];
  Return[Res]];



(* ::Subsubsection::Closed:: *)
(*Limit y -> 1 by G-Function Expansion*)


(* S-sums at infinity become G(w; 1) (index merges -> Li -> G); a word whose letters all carry 1/y^p
   is rescaled to G(y^p w; y^p).  G(w; 1-s) is expanded in s and L = Log[s] from its first letter:
     a != 1 : G(a w; 1-s) = G(a w; 1) - Int_0^s ds' G(w; 1-s')/((1-a) - s')
     a == 1 : dG(1 w; 1-s)/ds = G(w; 1-s)/s, integrated term by term, plus the regularized constant,
   and the regularized constants of words starting with 1 follow from the shuffle with G(1).
   The limit is the s^0 L^0 coefficient; every negative power of s and every power of L must cancel. *)



GLimOrder = 5;        (* powers of s kept in every expansion *)
GLimS = GLimSmall;    (* s = 1 - y *)
GLimL = GLimLog;      (* Log[s] *)
MBCHVarT = VarT;      (* y^2, for sub-series summed at rate 2 *)


(* an S-sum at infinity as a sum of G(w; 1) *)
SumInfToG[Idx_List, Xs_List] := Module[{Splits, Terms},
  Splits = AdjacentMerges[Length[Idx]];
  Terms = Map[
    Function[Bl, LiWordToG[Map[Total[Idx[[#]]] &, Bl], Map[(Times @@ Xs[[#]]) &, Bl]]],
    Splits];
  Return[Total[Terms]]];

(* Li_{m1..mk}(y1..yk) = (-1)^k G(0^(m1-1), 1/y1, ..., 0^(mk-1), 1/(y1...yk); 1) *)
LiWordToG[Ms_, Ys_] := Module[{Word, Prod},
  Word = {};
  Prod = 1;
  Do[
   Prod = Together[Prod*Ys[[J]]];
   Word = Join[Word, ConstantArray[0, Ms[[J]] - 1], {Together[1/Prod]}],
   {J, Length[Ms]}];
  Return[(-1)^Length[Ms]*GG[Word, 1]]];


(* G(w; 1) whose letters all carry 1/y^p -> G(y^p w; y^p); the scaling needs a nonzero last letter *)
GRescale[Word_] := Module[{Nz, Pows, P, Scaled},
  If[Last[Word] === 0, Return[$Failed]];
  Nz = DeleteCases[Word, 0];
  Pows = Map[Exponent[Together[#], MBCHVarY, Min] &, Nz];
  If[! VectorQ[Pows, IntegerQ] || Length[DeleteDuplicates[Pows]] =!= 1, Return[$Failed]];
  P = -First[Pows];
  If[P === 0, Return[GG[Word, 1]]];
  Scaled = Map[Together[#*MBCHVarY^P] &, Word];
  If[! FreeQ[Scaled, MBCHVarY], Return[$Failed]];
  Return[GG[Scaled, MBCHVarY^P]]];


(* the expression in y as polynomials in G(w; y), G(w; y^2) and constants *)
ToGForm[Expr_] := Module[{Res},
  Res = Expr /. S[Idx__Integer, Xs_List, Global`LinInf] :> SumInfToG[{Idx}, Xs];
  Res = Res /. PolyLog[M_Integer, X_] :> -GG[Append[ConstantArray[0, M - 1], 1/X], 1];
  Res = Res /. Log[X_] /; ! FreeQ[X, MBCHVarY] && X =!= MBCHVarY :> GLog[X];
  Res = Res /. GG[W_, 1] :> With[{Q = GRescale[W]}, Q /; Q =!= $Failed];
  (* letters with different powers of y: iterated integrals in y from 0 *)
  Res = Res /. GG[W_, 1] /; ! FreeQ[W, MBCHVarY] :>
     With[{Q = Catch[GToY[W], "GToY"]}, (Q /. GY[B_] :> GG[B, MBCHVarY]) /; Q =!= $Failed];
  Return[Res]];


(* int_0^s s'^P L'^J ds' *)
GIntMono[P_, J_] := Module[{Res},
  If[P === -1, Return[GLimL^(J + 1)/(J + 1)]];
  Res = GLimS^(P + 1)*Sum[(-1)^(J - I1)*J!/(I1!*(P + 1)^(J - I1 + 1))*GLimL^I1, {I1, 0, J}];
  Return[Res]];

GTrunc[Expr_, Ord_] := Module[{Rules},
  Rules = CoefficientRules[Expand[Expr], {GLimS, GLimL}];
  Rules = Select[Rules, #[[1, 1]] <= Ord &];
  Return[Total[Map[(#[[2]]*GLimS^#[[1, 1]]*GLimL^#[[1, 2]]) &, Rules]]]];


(* the regularized value at 1 (the s^0 L^0 term) of G(w; 1) *)
GReg[{}] := 1;
GReg[Word_List] := GReg[Word] = Module[{K, Rest1, Base, Ins, Res},
  If[First[Word] =!= 1, Return[GV[Word]]];
  K = LengthWhile[Word, (# === 1) &];
  Rest1 = Drop[Word, K];
  If[Rest1 === {}, Return[0]];
  Base = Join[ConstantArray[1, K - 1], Rest1];
  (* insert one more 1 after the first letter of Rest1 or later; the other K insertions give Word *)
  Ins = Table[Insert[Base, 1, P1], {P1, K + 1, Length[Base] + 1}];
  Res = -Total[Map[GReg, Ins]]/K;
  Return[Res]];


(* G(w; 1-s) to order s^Ord, as a polynomial in s and L *)
GSer[{}, Ord_] := 1;
GSer[Word_List, Ord_] := GSer[Word, Ord] = Module[{A, Inner, Rules, Res},
  A = First[Word];
  Inner = GSer[Rest[Word], Ord];
  Rules = CoefficientRules[Expand[Inner], {GLimS, GLimL}];
  Res = 0;
  If[A === 1,
   (* dG/ds = Inner/s *)
   Do[Res = Res + R1[[2]]*GIntMono[R1[[1, 1]] - 1, R1[[1, 2]]], {R1, Rules}];
   Res = Res + GReg[Word],
   (* 1/((1-a) - s') = Sum_m s'^m/(1-a)^(m+1) *)
   Do[
    Do[Res = Res - R1[[2]]/(1 - A)^(M + 1)*GIntMono[R1[[1, 1]] + M, R1[[1, 2]]],
     {M, 0, Ord - R1[[1, 1]]}],
    {R1, Rules}];
   Res = Res + GV[Word]];
  Return[GTrunc[Res, Ord]]];


(* one G(w; x) near x = 1 for x = y (s) or x = y^p (s_p = 1 - (1-s)^p) *)
GAt[Word_, X_, Ord_] := Module[{P, Ser, Sp, Lp},
  Ser = GSer[Word, Ord];
  If[X === MBCHVarY, Return[Ser]];
  P = Exponent[X, MBCHVarY];
  Sp = Normal[Series[1 - (1 - GLimS)^P, {GLimS, 0, Ord + 1}]];
  (* Log[s_p] = L + Log[s_p/s] *)
  Lp = GLimL + Normal[Series[Log[Sp/GLimS], {GLimS, 0, Ord}]];
  Return[GTrunc[Expand[Ser /. {GLimS -> Sp, GLimL -> Lp}], Ord]]];


(* {{p, q}, c} for the terms c s^p L^q of a Laurent polynomial in s and polynomial in L *)
LaurentRules[Ex_] := Module[{E1, Terms, Keys1, Res},
  E1 = Expand[Ex];
  Terms = If[Head[E1] === Plus, List @@ E1, {E1}];
  Keys1 = Map[{Exponent[#, GLimS], Exponent[#, GLimL]} &, Terms];
  If[! MatrixQ[Keys1, IntegerQ], Return[$Failed]];
  Res = Table[{Keys1[[K1]], Terms[[K1]]/(GLimS^Keys1[[K1, 1]]*GLimL^Keys1[[K1, 2]])}, {K1, Length[Terms]}];
  If[! FreeQ[Map[Last, Res], GLimS | GLimL], Return[$Failed]];
  Res = Map[{#[[1, 1]], Total[#[[All, 2]]]} &, GatherBy[Res, First]];
  Return[Res]];


(* the deepest pole at y = 1 among the factors of the expression *)
PoleOrderAtOne[Expr_] := Module[{Pows},
  Pows = Cases[Expr, Power[B_, K_Integer /; K < 0] /; ! FreeQ[B, MBCHVarY] &&
      Quiet[TrueQ[PossibleZeroQ[B /. MBCHVarY -> 1]]] :> -K, {0, Infinity}];
  Return[Max[Join[{0}, Pows]]]];

(* the s^0 L^0 term of the expression; $Failed if a pole in s or a power of L survives *)
GLimit[Expr_] := Module[{G1, Gs, Ord, Sub, Ser, Rules, Bad, Fin, Probe},
  AbelTrace["GLimit: ToGForm of " <> ToString[LeafCount[Expr]] <> " leaves"];
  G1 = ToGForm[Expr];
  AbelTrace["GLimit: ToGForm done, " <> ToString[LeafCount[G1]] <> " leaves, S/H left " <> ToString[! FreeQ[G1, S | H]]];
  If[! FreeQ[G1, S | H], Return[$Failed]];
  (* a word whose letters still depend on y could not be converted: its y -> 1 limit is not y = 1 *)
  If[! FreeQ[Cases[G1, GG[W_, 1] :> W, {0, Infinity}], MBCHVarY], Return[$Failed]];
  G1 = G1 /. GG[W_, 1] :> If[First[W] === 1, GDiv, GV[W]];
  If[! FreeQ[G1, GDiv], Return[$Failed]];
  If[! FreeQ[Cases[G1, GV[W_] :> W, {0, Infinity}], MBCHVarY], Return[$Failed]];
  Gs = DeleteDuplicates[Cases[G1, GG[_, _], {0, Infinity}]];
  If[! AllTrue[Gs, (#[[2]] === MBCHVarY || MatchQ[#[[2]], Power[MBCHVarY, _Integer?Positive]]) &],
     Return[$Failed]];
  Ord = PoleOrderAtOne[G1 /. MBCHVarT -> MBCHVarY^2] + 1;
  AbelTrace["GLimit: " <> ToString[Length[Gs]] <> " G functions, order " <> ToString[Ord]];
  Sub = G1 /. Map[(# -> GAt[#[[1]], #[[2]], Ord]) &, Gs];
  AbelTrace["GLimit: expansions substituted, " <> ToString[LeafCount[Sub]] <> " leaves"];
  Sub = Sub /. GLog[X_] :> Log[X];
  Sub = Sub /. MBCHVarT -> MBCHVarY^2;
  Sub = Sub /. MBCHVarY -> 1 - GLimS;
  Sub = Sub /. Log[GLimS] -> GLimL;
  Ser = SafeEval[Quiet[TimeConstrained[
     Normal[Series[Sub, {GLimS, 0, 0}]], 900, $Failed]]];
  AbelTrace["GLimit: Series done " <> ToString[Ser =!= $Failed]];
  If[Ser === $Failed, Return[$Failed]];
  Ser = Ser /. Log[GLimS] -> GLimL;
  If[! FreeQ[Ser, MBCHVarY | GLog | Log[GLimS]], Return[$Failed]];
  (* a Laurent polynomial in s: CoefficientRules would take the poles for part of the constant *)
  Rules = LaurentRules[Ser];
  If[Rules === $Failed, Return[$Failed]];
  Fin = Total[Cases[Rules, R1_ /; R1[[1]] === {0, 0} :> R1[[2]]]];
  Bad = Select[Rules, #[[1]] =!= {0, 0} && #[[1, 1]] <= 0 &];
  (* the divergent terms must vanish: numerically where the H values evaluate, else exactly *)
  Probe = Map[Quiet[N[GVNumeric[#[[2]]], 20]] &, Bad];
  Do[
   If[! NumericQ[Probe[[K1]]],
    Probe[[K1]] = If[TrueQ[Quiet[PossibleZeroQ[ValueAtOne[GVNumeric[Bad[[K1, 2]]]]]]], 0, 1]],
   {K1, Length[Bad]}];
  If[! AllTrue[Probe, (Abs[#] < 10^-10) &], Return[$Failed]];
  Return[Fin]];


(* G(w; 1) with numeric or kinematic letters in the H convention: G = Prod (-Sign a) H *)
GVToH[Word_] := Module[{Nz, Fac},
  Nz = DeleteCases[Word, 0];
  Fac = Times @@ Map[LetterFactor, Nz];
  Return[Fac*(H @@ Append[Word, 1])]];

GVNumeric[Expr_] := (Expr /. GV[W_] :> GVToH[W]) /. ProbeRule[];



(* H at 1 with letters 0, 1, -1 in known constants: HarmonicSums' tables, then ValueAtOne for the rest *)
ConstsAtOne[Ex_] := Module[{R},
  R = SafeEval[Quiet[TimeConstrained[ReduceConstants[Ex, ToKnownConstants -> True], 600, $Failed]]];
  If[R === $Failed || ! FreeQ[R, H | S | ReduceConstants], Return[ValueAtOne[Ex]]];
  R = R /. Q_Symbol /; SymbolName[Q] === "ln2" :> Log[2];
  R = R /. Q_Symbol /; StringMatchQ[SymbolName[Q], "li" ~~ DigitCharacter .. ~~ "half"] :>
     PolyLog[ToExpression[StringTake[SymbolName[Q], {3, -5}]], 1/2];
  R = ZetaSub[R];
  R = Quiet[TimeConstrained[Simplify[R], 120, R]];
  Return[R]];


(* the y -> 1 limit through GLimit; scaleless values go on to zeta values *)
AbelLimitG[Val_] := Module[{Fin, Res},
  Fin = SafeEval[GLimit[Val]];
  AbelTrace["limit: GLimit done " <> ToString[Fin =!= $Failed]];
  If[Fin === $Failed, Return[$Failed]];
  If[AbelTraceFile =!= None, Put[Fin, AbelTraceFile <> ".fin.m"]];
  Res = Fin /. GV[W_] :> GVToH[W];
  AbelTrace["limit: GVToH done, H left " <> ToString[Length[DeleteDuplicates[Cases[Res, _H, {0, Infinity}]]]]];
  If[MBCHScale === {}, Res = ConstsAtOne[Res]];
  AbelTrace["limit: constants done"];
  If[! FreeQ[Res, MBCHVarY | GLimS | GLimL], Return[$Failed]];
  If[DirtyQ[Res], Return[$Failed]];
  Return[Res]];




(* {c, k} for a letter c y^k, $Failed otherwise *)
LetterMono[A_] := Module[{T, K, C},
  T = Together[A];
  If[FreeQ[T, MBCHVarY], Return[{T, 0}]];
  K = Exponent[T, MBCHVarY];
  If[! IntegerQ[K] || K =!= Exponent[Numerator[T], MBCHVarY] - Exponent[Denominator[T], MBCHVarY], Return[$Failed]];
  C = Together[T/MBCHVarY^K];
  If[! FreeQ[C, MBCHVarY], Return[$Failed]];
  Return[{C, K}]];


(* trailing zeros at argument 1, by the shuffle with G(0; 1) = 0: for a word (b1..br, 0^k), br != 0,
   the k insertions of 0 after br give the word itself, so
   G(b, 0^k; 1) = -(1/k) Sum_{p <= r} G(Insert[(b, 0^(k-1)), 0, p]; 1), each with k-1 trailing zeros *)
GNoTrail[Word_] := Module[{K, R, Wp, Res},
  If[Word === {} || Last[Word] =!= 0, Return[GW[Word]]];
  If[AllTrue[Word, (# === 0) &], Return[0]];
  K = Length[Word] - Last[Flatten[Position[Word, B_ /; B =!= 0, {1}, Heads -> False]]];
  R = Length[Word] - K;
  Wp = Most[Word];
  Res = -Sum[GNoTrail[Insert[Wp, 0, P1]], {P1, 1, R}]/K;
  Return[Expand[Res]]];


(* the simple poles of a dlog in y: {{residue, point}, ...} *)
DlogPoles[F_] := Module[{Fa, Res},
  If[FreeQ[F, MBCHVarY], Return[{}]];
  Fa = FactorList[Together[F]];
  Res = {};
  Do[
   Module[{P, M, Rs},
    P = Fa1[[1]];
    M = Fa1[[2]];
    If[! FreeQ[P, MBCHVarY],
     Rs = MBCHVarY /. Solve[P == 0, MBCHVarY];
     Rs = Tally[Rs];
     Do[AppendTo[Res, {M*R1[[2]], R1[[1]]}], {R1, Rs}]]],
   {Fa1, Fa}];
  Return[Res]];


(* G(w(y); 1) as a combination of GY[b] = G(b; y) *)
GToY[{}] := 1;
GToY[Word_List] := GToY[Word] = Module[{Monos, Terms, Res, N1, Ext},
  If[Last[Word] === 0,
   Return[Expand[GNoTrail[Word] /. GW[W1_] :> GToY[W1]]]];
  If[FreeQ[Word, MBCHVarY], Return[GV[Word]]];
  Monos = Map[LetterMono, Word];
  If[MemberQ[Monos, $Failed], Throw[$Failed, "GToY"]];
  (* at y = 0 the word must vanish: some letter grows, none shrinks to 0 *)
  If[! AnyTrue[Monos, (#[[2]] < 0) &] || AnyTrue[Monos, (#[[2]] > 0) &], Throw[$Failed, "GToY"]];
  N1 = Length[Word];
  Ext = Join[{1}, Word, {0}];
  Res = 0;
  Do[
   Module[{Lower, Poles},
    Lower = GToY[Delete[Word, I1]];
    Poles = {};
    If[! TrueQ[Simplify[Ext[[I1]] - Ext[[I1 + 1]] == 0]],
     Poles = Join[Poles, DlogPoles[Ext[[I1]] - Ext[[I1 + 1]]]]];
    If[! TrueQ[Simplify[Ext[[I1 + 2]] - Ext[[I1 + 1]] == 0]],
     Poles = Join[Poles, Map[{-#[[1]], #[[2]]} &, DlogPoles[Ext[[I1 + 2]] - Ext[[I1 + 1]]]]]];
    (* int_0^y dt/(t - r) G(b; t) = G(r, b; y) *)
    Do[Res = Res + P1[[1]]*PrependY[P1[[2]], Lower], {P1, Poles}]],
   {I1, N1}];
  Return[Expand[Res]]];


(* prepend a letter to every GY word of an expression linear in them; a term free of GY is c G(r; y) *)
PrependY[R_, Ex_] := Module[{E1, Terms},
  E1 = Expand[Ex];
  Terms = If[Head[E1] === Plus, List @@ E1, {E1}];
  Terms = DeleteCases[Terms, 0];
  Return[Total[Map[If[FreeQ[#, GY], #*GY[{R}], # /. GY[B_] :> GY[Prepend[B, R]]] &, Terms]]]];


(* numerical value of G(b; y) at y = Y0 and of G(w; 1), letters numeric, in the H convention *)
GNum[Word_, X_] := Module[{W1, Nz, Fac},
  If[Word === {}, Return[1]];
  If[AllTrue[Word, (# === 0) &], Return[Log[X]^Length[Word]/Length[Word]!]];
  (* letters 0, 1, -1: an ordinary HPL at X, which HarmonicSums evaluates fast *)
  If[SubsetQ[{0, 1, -1}, DeleteDuplicates[Word]],
   Nz = DeleteCases[Word, 0];
   Fac = Times @@ Map[-Sign[#] &, Nz];
   Return[N[Fac*(H @@ Append[Word, X]), 20]]];
  W1 = Word/X;
  Nz = DeleteCases[W1, 0];
  Fac = Times @@ Map[-Sign[#] &, N[Nz]];
  Return[N[Fac*(H @@ Append[W1, 1]), 20]]];




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

(* ::Subsubsection::Closed:: *)
(*Recycled Subkernels*)


MBCHSkip = {};            (* stages of this structure that crashed a subkernel before: not tried again *)
MBCHStagePrefix = {};     (* the stage of an enclosing change of variables *)
MBCHMarkFile = None;      (* file where a subkernel notes the stage it is in *)
MBCHCrashTries = 3;       (* times a structure is resubmitted after its subkernel died *)


(* note the stage before it starts, so a crash can be traced to it; False = it crashed before, skip it *)
MarkStage[Tag_] := Module[{Full},
  Full = Append[MBCHStagePrefix, Tag];
  If[StringQ[MBCHMarkFile], Quiet[Put[Full, MBCHMarkFile]]];
  Return[! MemberQ[MBCHSkip, Full]]];


MBCHKernelMem = 3*2^30;   (* resident bytes a subkernel may hold after a task before it is replaced; Infinity = never *)
MBCHKernelTarget = 0;     (* number of subkernels to keep; set when the pool is first used *)
MBKernelIDs = <||>;       (* KernelObject -> $KernelID *)


(* one task on a subkernel, with the memory the kernel holds afterwards *)
SolveTaskMem[Task_] := Module[{V},
  V = SolveTask[Task];
  Return[{"Done", V, KernelRSS[], $KernelID}]];


(* resident memory of this kernel process in bytes: MemoryInUse misses what the process keeps but no longer uses *)
KernelRSS[] := Module[{Lines, Hit, Kb},
  Lines = Quiet[ReadList["/proc/self/status", String]];
  If[! ListQ[Lines], Return[MemoryInUse[]]];
  Hit = Select[Lines, StringStartsQ[#, "VmRSS:"] &];
  If[Hit === {}, Return[MemoryInUse[]]];
  Kb = ToExpression[First[StringCases[First[Hit], DigitCharacter ..]]];
  If[! IntegerQ[Kb], Return[MemoryInUse[]]];
  Return[1024*Kb]];


(* a new subkernel gets the package and the master's current settings *)
InitKernel[K_] := Module[{Ok, Vals},
  Ok = With[{F = MBResumFile, D = Directory[], P = $Path},
    Quiet[ParallelEvaluate[
      ($Path = P;
       SetDirectory[D];
       Global`$KernelLaunch = 0;
       Block[{$Output = {}, $Messages = {}}, Get[F]];
       Length[DownValues[MBSolveOne]] > 0), K]]];
  Vals = {MBCHScale, MBCHVerbose, MBCHVerifyDiff, MBCHTol, MBCHSeriesTerms, MBCHNumTime, MBCHProbe,
    MBCHChartTime, MBCHChartBudget, MBCHRegTime, MBCHRegBudget, MBCHRegSlots, MBCHRegGood, MBCHRegChart,
    MBCHTaskMem, AbelTime, AbelBudget, AbelUseLimit, MBCHComplex};
  With[{Vs = Vals},
   Quiet[ParallelEvaluate[
     ({MBCHScale, MBCHVerbose, MBCHVerifyDiff, MBCHTol, MBCHSeriesTerms, MBCHNumTime, MBCHProbe,
       MBCHChartTime, MBCHChartBudget, MBCHRegTime, MBCHRegBudget, MBCHRegSlots, MBCHRegGood, MBCHRegChart,
       MBCHTaskMem, AbelTime, AbelBudget, AbelUseLimit, MBCHComplex} = Vs), K]]];
  Return[TrueQ[Ok] || MatchQ[Ok, {True ..}]]];


(* the $KernelID of every subkernel, read while they are idle *)
RecordKernelIDs[] := Module[{Ids},
  Ids = Quiet[ParallelEvaluate[$KernelID]];
  If[ListQ[Ids] && Length[Ids] === Length[Kernels[]], MBKernelIDs = AssociationThread[Kernels[], Ids]];
  Return[Null]];


(* launch subkernels until the pool is back to its size *)
FillKernels[] := Module[{New, Id},
  While[$KernelCount < MBCHKernelTarget,
   New = Quiet[LaunchKernels[1]];
   If[ListQ[New], New = First[New, $Failed]];
   If[Head[New] =!= KernelObject, Break[]];
   If[! InitKernel[New], Quiet[CloseKernels[New]]; Break[]];
   Id = Quiet[ParallelEvaluate[$KernelID, New]];
   If[ListQ[Id], Id = First[Id]];
   MBKernelIDs[New] = Id];
  Return[Null]];


RecycleKernel[Kid_] := Module[{K},
  K = SelectFirst[Keys[MBKernelIDs], (MBKernelIDs[#] === Kid) &, None];
  VPrint["        subkernel ", Kid, " replaced (memory above ", Round[MBCHKernelMem/2^30., 0.1], " GB)"];
  If[K =!= None,
   Quiet[CloseKernels[K]];
   KeyDropFrom[MBKernelIDs, Key[K]]];
  FillKernels[];
  Return[Null]];


(* the tasks in order, at most one per subkernel at a time; a result reports the kernel's memory *)
RecycleMap[Sent_] := Module[{N1, Queue, Running, Out, Submit, Skips, Tries, Marks, Tag},
  If[MBCHKernelTarget < $KernelCount, MBCHKernelTarget = $KernelCount];
  RecordKernelIDs[];
  N1 = Length[Sent];
  Out = ConstantArray[$Failed, N1];
  Queue = Range[N1];
  Running = <||>;
  Skips = ConstantArray[{}, N1];
  Tries = ConstantArray[0, N1];
  Tag = ToString[$ProcessID] <> "_" <> ToString[Round[1000*AbsoluteTime[]]];
  Marks = Table[FileNameJoin[{$TemporaryDirectory, "mbresum_stage_" <> Tag <> "_" <> ToString[I1] <> ".m"}], {I1, N1}];
  Submit[I1_] := With[{T = Join[Sent[[I1]], {Skips[[I1]], Marks[[I1]]}]},
    Quiet[DeleteFile[Marks[[I1]]]];
    Running[ParallelSubmit[SolveTaskMem[T]]] = I1];
  Do[If[Queue =!= {}, Submit[First[Queue]]; Queue = Rest[Queue]], {Max[1, $KernelCount]}];
  While[Length[Running] > 0,
   Module[{W, R, E1, I1},
    W = Block[{Parallel`Settings`$RecoveryMode = "Abandon"}, WaitNext[Keys[Running]]];
    R = W[[1]];
    E1 = W[[2]];
    I1 = Running[E1];
    Running = KeyDrop[Running, Key[E1]];
    If[MatchQ[R, {"Done", _, _, _}],
     Out[[I1]] = R[[2]];
     (* a solved structure goes to the checkpoint at once *)
     If[CleanVal[R[[2]]] =!= Indeterminate && ! DirtyQ[R[[2]]], SaveCellRecord["S", Sent[[I1, 2]], R[[2]]]];
     If[R[[3]] > MBCHKernelMem, RecycleKernel[R[[4]]]],
     (* the subkernel died: retry the structure without the stage it died in, and refill the pool *)
     Module[{Stage},
      Stage = If[FileExistsQ[Marks[[I1]]], Quiet[Get[Marks[[I1]]]], None];
      Out[[I1]] = $Failed;
      Which[
       ListQ[Stage] && Stage =!= {{"series"}} && ! MemberQ[Skips[[I1]], Stage] && Tries[[I1]] < MBCHCrashTries,
        VPrint["        structure ", Sent[[I1, 1]], ": subkernel died in ", Stage, "; retried without it"];
        Skips[[I1]] = Append[Skips[[I1]], Stage];
        Tries[[I1]] = Tries[[I1]] + 1;
        Queue = Prepend[Queue, I1],
       (* no note: the subkernel died before the structure started, so nothing is to blame *)
       ! ListQ[Stage] && Tries[[I1]] < MBCHCrashTries,
        VPrint["        structure ", Sent[[I1, 1]], ": subkernel died before it started; retried"];
        Tries[[I1]] = Tries[[I1]] + 1;
        Queue = Prepend[Queue, I1],
       True,
        VPrint["        structure ", Sent[[I1, 1]], ": subkernel died in ", Stage]]];
     FillKernels[]];
    If[Queue =!= {} && $KernelCount > 0, Submit[First[Queue]]; Queue = Rest[Queue]]]];
  Scan[Quiet[DeleteFile[#]] &, Select[Marks, FileExistsQ]];
  Return[Out]];


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
   MBCHRegTime, MBCHRegBudget, MBCHRegSlots, MBCHRegGood, MBCHRegChart, MBCHTaskMem,
   AbelTime, AbelBudget, AbelUseLimit];

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

(* a task may carry the master's contour value, so the subkernel need not integrate it again *)
SolveTask[Task_] := Module[{Val},
  MBResumJ = Task[[1]];
  (* a task sent to the subkernels that comes back to the master means the pool died: do not risk the master *)
  If[Length[Task] > 2 && $KernelID === 0, Return[$Failed]];
  If[Length[Task] > 2 && NumericQ[Task[[3]]], MBVerifyCache[Task[[2]]] = Task[[3]]];
  If[Length[Task] > 4,
   MBCHSkip = Task[[4]];
   MBCHMarkFile = Task[[5]]];
  If[IntegerQ[MBCHTaskMem],
     Val = MemoryConstrained[SafeEval[MBSolveOne @@ Task[[2]]], MBCHTaskMem, $Failed],
     Val = SafeEval[MBSolveOne @@ Task[[2]]]];
  ClearMemos[];
  If[StringQ[MBCHMarkFile], Quiet[DeleteFile[MBCHMarkFile]]];
  MBCHMarkFile = None;
  MBCHSkip = {};
  Return[Val]];

(* drop the memoized values of the per-structure helpers, keep their definitions *)
ClearMemo[F_Symbol] := (DownValues[F] = Select[DownValues[F], (! FreeQ[#[[1]], Pattern] || ! FreeQ[#[[1]], {}]) &]);

ClearMemos[] := Module[{},
  Scan[ClearMemo, {GSer, GReg, GToY, HPLSeries}];
  MBSeriesCache = <||>;
  ClearSystemCache[];
  Return[Null]];

(* a structure whose subkernel died, or that aborted, counts as not solved *)
CleanVal[Val_] := If[Val === $Failed || ! FreeQ[Val, $Aborted], Indeterminate, Val];

(* structures are independent: solve the new ones in parallel; a crash costs one kernel *)
SolveAll[Tasks_] := Module[{New, Res, Sent},
  LoadCellCache[];
  New = Select[Tasks, ! KeyExistsQ[MBSolveCache, #[[2]]] &];
  New = DeleteDuplicatesBy[New, Last];
  Which[
   New === {}, Null,
   Length[New] > 1 && WorkersReady[],
    SyncWorkers[];
    Say["Solving " <> ToString[Length[New]] <> " structures on " <> ToString[$KernelCount] <> " kernels ..."];
    Sent = Map[Append[#, Lookup[MBVerifyCache, Key[#[[2]]], $Failed]] &, New];
    If[TrueQ[MBCHKernelMem < Infinity],
     Res = RecycleMap[Sent],
     Res = Block[{Parallel`Settings`$RecoveryMode = "Abandon"},
       ParallelMap[SolveTask, Sent, Method -> "FinestGrained"]]];
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
(*One-Fold Reduction of Trigonometric Two-Folds*)


(* A scaleless two-fold whose Gammas pair into Pi/Sin[Pi a] times a rational function, and whose PolyGammas
   depend on one linear form v only.  In coordinates (v, w) (z = T.(v, w), det T = 1) the variable w sits in
   the rational function and in one or two of the sines only, so its integral is minus the sum of the
   residues on the right of the contour: the sine poles give sums that are rational in the summation index
   (Sum returns PolyGammas of v), the poles of the rational function give residues.  What is left is a sum
   of one-fold integrals in v that MBSolveOne solves; the total is kept only if it matches the two-fold
   contour. *)

MBCHReduceBudget = 3600;   (* seconds for the one-fold reduction of one structure *)
MBCHReduceSumTime = 300;   (* seconds for one symbolic sum *)
MBCHInReduce = False;      (* set while the one-fold pieces are solved *)


(* Gamma[X + K]/Gamma[X] for an integer K *)
RisingProd[X_, K_Integer] := Which[
  K === 0, 1,
  K > 0, Product[X + J, {J, 0, K - 1}],
  True, 1/Product[X - J, {J, 1, -K}]];


FormVec[A_, Vars_] := Map[Coefficient[Expand[A], #] &, Vars];

(* a direction up to sign and scale *)
PrimVec[V_] := Module[{G, W},
  If[AllTrue[V, (# === 0) &], Return[V]];
  G = Apply[GCD, V];
  W = V/G;
  If[First[Select[W, (# =!= 0) &]] < 0, W = -W];
  Return[W]];


(* Gammas only: {PiPow, Rat, Sines} with Num/Den = Pi^PiPow Rat / Prod Sin[Pi s], or $Failed *)
GammaTrig[Num_, Den_, Vars_] := Catch[
  Module[{NumG, Rat, Sines, PiPow, Hit, A1, K1},
   NumG = Select[Num, (Head[#] =!= List) &];
   Rat = 1;
   Sines = {};
   PiPow = 0;
   (* a Den Gamma cancels a Num Gamma an integer away *)
   Do[
    If[FreeQ[B1, Alternatives @@ Vars],
     Rat = Rat/Gamma[B1],
     Hit = SelectFirst[Range[Length[NumG]], IntegerQ[Expand[NumG[[#]] - B1]] &, None];
     If[Hit === None, Throw[$Failed, "GT"]];
     Rat = Rat*RisingProd[B1, Expand[NumG[[Hit]] - B1]];
     NumG = Delete[NumG, Hit]],
    {B1, Den}];
   (* Gamma[a] Gamma[K - a] = Pi/Sin[Pi a] Gamma[K - a]/Gamma[1 - a] *)
   While[NumG =!= {},
    A1 = First[NumG];
    NumG = Rest[NumG];
    If[FreeQ[A1, Alternatives @@ Vars],
     Rat = Rat*Gamma[A1],
     Hit = SelectFirst[Range[Length[NumG]], IntegerQ[Expand[NumG[[#]] + A1]] &, None];
     If[Hit === None, Throw[$Failed, "GT"]];
     K1 = Expand[NumG[[Hit]] + A1];
     Rat = Rat*RisingProd[1 - A1, K1 - 1];
     AppendTo[Sines, A1];
     PiPow = PiPow + 1;
     NumG = Delete[NumG, Hit]]];
   {PiPow, Together[Rat], Sines}],
  "GT"];


(* the changes of variables (v, w) = U.z to try: v along the PolyGammas, w any completion with det U = 1 *)
ReduceFrames[Vars_, Psis_, Sines_] := Module[{PsiDirs, Dirs, Frames},
  PsiDirs = Map[PrimVec[FormVec[#[[2]], Vars]] &, Psis];
  PsiDirs = DeleteDuplicates[DeleteCases[PsiDirs, {0, 0}]];
  If[Length[PsiDirs] > 1, Return[{}]];
  If[PsiDirs === {},
   Dirs = DeleteDuplicates[Map[PrimVec[FormVec[#, Vars]] &, Sines]],
   Dirs = PsiDirs];
  Frames = Flatten[Table[
     Map[{P1, #} &, Select[Tuples[Range[-2, 2], 2], (Det[{P1, #}] === 1) &]],
     {P1, Dirs}], 1];
  Frames = SortBy[Frames, (Total[Abs[#[[2]]]] &)];
  Return[Frames]];


(* Sin[Pi L] = Sg Sin[Pi L1], L linear in MBCHRedV, L1 with a positive coefficient and a constant in [0, 1),
   so that Sum sees equal sines as equal *)
CanonSin[L_] := Module[{L1, Sg, A, C0, M},
  L1 = Expand[L];
  Sg = 1;
  A = Coefficient[L1, MBCHRedV];
  If[NumericQ[A] && A < 0,
   L1 = -L1;
   Sg = -Sg];
  C0 = L1 /. MBCHRedV -> 0;
  If[! NumericQ[C0], Return[{1, L}]];
  M = Floor[C0];
  L1 = Expand[L1 - M];
  Sg = Sg*(-1)^M;
  Return[{Sg, L1}]];

SinOf[L_] := Module[{Cs},
  Cs = CanonSin[L];
  Return[Cs[[1]]*Sin[Pi*Cs[[2]]]]];


(* the polynomial part Quo(w) of the rational function: F = Pi^PiPow/Prod Sin has F(w+1) = S1 F(w), so with
   P(w) - S1 P(w+1) = Quo(w) the integral of Quo F along the contour is minus the residues of P F in the strip
   between the contour and its shift by one, one pole per sine family (closing the contour to the right
   would miss the arc at infinity) *)
PolyInner[Quo_, PiPow_, Fams_] := Module[{S1, Dg, Ps, P, Eqs, Sol},
  S1 = (-1)^Length[Fams];
  Dg = Exponent[Quo, MBCHRedW] + If[S1 === 1, 1, 0];
  Ps = Table[Unique["pc"], {Dg + 1}];
  P = Sum[Ps[[J + 1]]*MBCHRedW^J, {J, 0, Dg}];
  Eqs = CoefficientList[Expand[P - S1*(P /. MBCHRedW -> MBCHRedW + 1) - Quo], MBCHRedW];
  If[S1 === 1, Eqs = Append[Eqs, Ps[[1]]]];
  Sol = Solve[Thread[Eqs == 0], Ps];
  If[Sol === {}, Return[$Failed]];
  P = Together[P /. First[Sol]];
  Return[-Total[Table[
     Module[{Fam, Others},
      Fam = Fams[[I1]];
      Others = Delete[Fams, I1];
      Fam[[4]]/(Pi*Fam[[2]])*Pi^PiPow*(P /. MBCHRedW -> Fam[[3]])/
        (Times @@ Map[SinOf[#[[1]] /. MBCHRedW -> Fam[[3]]] &, Others])],
     {I1, Length[Fams]}]]]];


(* the integral over W1 along Re W1 = W0, given V1 on Re V1 = V0: the polynomial part by PolyInner, the
   decaying rest as minus its residues on the right *)
InnerIntegral[PiPow_, RatVW_, WSines_, V0_, W0_] := Catch[
  Module[{Fams, Excl, Poles, ResR, Mx, Summand, Main, Finite, F, DenW, Numer, Denom, Quo, Rd, PolyPart},
   Numer = Numerator[RatVW];
   Denom = Denominator[RatVW];
   Quo = PolynomialQuotient[Numer, Denom, MBCHRedW];
   Rd = Together[PolynomialRemainder[Numer, Denom, MBCHRedW]/Denom];
   F = Pi^PiPow*Rd/(Times @@ Map[Sin[Pi*#] &, WSines]);
   (* the sine families: w = Base + n, n = 0, 1, ... *)
   Fams = Map[
     Function[L1,
      Module[{C1, Rest1, R0, Km, Base, Sg},
       C1 = Coefficient[L1, MBCHRedW];
       Rest1 = Expand[L1 - C1*MBCHRedW];
       R0 = Rest1 /. MBCHRedV -> V0;
       If[C1 === 1,
        If[Abs[W0 + R0 - Round[W0 + R0]] < 10^-8, Throw[$Failed, "Inner"]];
        Km = Floor[W0 + R0] + 1;
        Base = Km - Rest1,
        If[Abs[R0 - W0 - Round[R0 - W0]] < 10^-8, Throw[$Failed, "Inner"]];
        Km = Ceiling[R0 - W0] - 1;
        Base = Rest1 - Km];
       Sg = (-1)^Km;
       {L1, C1, Expand[Base], Sg}]],
     WSines];
   (* the poles of the rational function on the right *)
   PolyPart = If[Quo === 0, 0, PolyInner[Quo, PiPow, Fams]];
   If[PolyPart === $Failed, Throw[$Failed, "Inner"]];
   DenW = Select[FactorList[Denominator[Rd]], (! FreeQ[#[[1]], MBCHRedW]) &];
   If[AnyTrue[DenW, (Exponent[#[[1]], MBCHRedW] =!= 1) &], Throw[$Failed, "Inner"]];
   Poles = Map[Expand[-(#[[1]] /. MBCHRedW -> 0)/Coefficient[#[[1]], MBCHRedW]] &, DenW];
   Poles = Select[DeleteDuplicates[Poles], (N[Re[# /. MBCHRedV -> V0]] > W0) &];
   (* a pole that lies on a sine family is a higher-order pole: out of the family sum, into the residues *)
   Excl = {};
   Do[
    Do[
     Module[{D1},
      D1 = Expand[P1 - Fams[[I1, 3]]];
      If[IntegerQ[D1],
       If[D1 < 0, Throw[$Failed, "Inner"]];
       AppendTo[Excl, {I1, D1}]]],
     {I1, Length[Fams]}],
    {P1, Poles}];
   ResR = Map[
     Function[P1,
      Module[{Ser},
       Ser = TimeConstrained[
         SeriesCoefficient[F /. MBCHRedW -> P1 + MBCHRedE, {MBCHRedE, 0, -1}],
         MBCHReduceSumTime, $Failed];
       If[Ser === $Failed || ! FreeQ[Ser, SeriesCoefficient], Throw[$Failed, "Inner"]];
       Ser]],
     Poles];
   (* every family's term at w = Base + n: the residue of 1/Sin, the other sines at Base times (-1)^n *)
   Summand[N1_] := Total[Table[
     Module[{Fam, Others},
      Fam = Fams[[I1]];
      Others = Delete[Fams, I1];
      Fam[[4]]*If[EvenQ[Length[Fams]], 1, (-1)^N1]/(Pi*Fam[[2]])*Pi^PiPow*
        (Rd /. MBCHRedW -> Fam[[3]] + N1)/
        (Times @@ Map[SinOf[#[[1]] /. MBCHRedW -> Fam[[3]]] &, Others])],
     {I1, Length[Fams]}]];
   Mx = If[Excl === {}, 0, 1 + Max[Excl[[All, 2]]]];
   Main = TimeConstrained[
     Quiet[Sum[Evaluate[Together[Summand[MBCHRedN]]], {MBCHRedN, Mx, Infinity}]],
     MBCHReduceSumTime, $Failed];
   If[Main === $Failed || ! FreeQ[Main, Sum | Infinity | DirectedInfinity | ComplexInfinity | Indeterminate |
        LerchPhi | HypergeometricPFQ | Hypergeometric2F1], Throw[$Failed, "Inner"]];
   Finite = Total[Flatten[Table[
      If[MemberQ[Excl, {I1, N1}], 0,
       Module[{Fam, Others},
        Fam = Fams[[I1]];
        Others = Delete[Fams, I1];
        Fam[[4]]*If[EvenQ[Length[Fams]], 1, (-1)^N1]/(Pi*Fam[[2]])*Pi^PiPow*
          (Rd /. MBCHRedW -> Fam[[3]] + N1)/
          (Times @@ Map[SinOf[#[[1]] /. MBCHRedW -> Fam[[3]]] &, Others])]],
      {N1, 0, Mx - 1}, {I1, Length[Fams]}]]];
   PolyPart - (Main + Finite + Total[ResR])],
  "Inner"];


(* ---- one PolyGamma in the inner variable: PsiW = PolyGamma[K, W1 + G(V1)] ---- *)


(* the sine families of the inner variable: {L, C, Base, Sg} with poles w = Base + n, n = 0, 1, ... right of
   the contour, and Sg = (-1)^k of the first one; $Failed if a pole sits on the contour *)
SineFamilies[WSines_, V0_, W0_] := Catch[
  Map[
   Function[L1,
    Module[{C1, Rest1, R0, Km, Base},
     C1 = Coefficient[L1, MBCHRedW];
     Rest1 = Expand[L1 - C1*MBCHRedW];
     R0 = Rest1 /. MBCHRedV -> V0;
     If[C1 === 1,
      If[Abs[W0 + R0 - Round[W0 + R0]] < 10^-8, Throw[$Failed, "Fam"]];
      Km = Floor[W0 + R0] + 1;
      Base = Km - Rest1,
      If[Abs[R0 - W0 - Round[R0 - W0]] < 10^-8, Throw[$Failed, "Fam"]];
      Km = Ceiling[R0 - W0] - 1;
      Base = Rest1 - Km];
     {L1, C1, Expand[Base], (-1)^Km}]],
   WSines],
  "Fam"];


(* the residue of Expr at W1 = P1 *)
ResidueAt[Expr_, P1_] := Module[{Ser},
  Ser = TimeConstrained[
    SeriesCoefficient[Expr /. MBCHRedW -> P1 + MBCHRedE, {MBCHRedE, 0, -1}],
    MBCHReduceSumTime, $Failed];
  If[Ser === $Failed || ! FreeQ[Ser, SeriesCoefficient], Return[$Failed]];
  Return[Ser]];


(* the poles W1 = -m - Gm of PsiW right of the contour (finitely many), or those in the strip W0 < Re W1 < W0 + 1 *)
PsiPoles[Gm_, V0_, W0_, Strip_] := Module[{G0, Hi, Lo},
  G0 = N[Re[Gm /. MBCHRedV -> V0]];
  Hi = Ceiling[-G0 - W0] - 1;
  Lo = If[TrueQ[Strip], Max[0, Floor[-G0 - W0 - 1] + 1], 0];
  If[Hi < Lo, Return[{}]];
  Return[Table[Expand[-M1 - Gm], {M1, Lo, Hi}]]];


(* the polynomial part Quo(w) with PsiW: F(w+1) = S1 F(w) and PsiW(w+1) = PsiW(w) + Dl(w), so with
   P(w) - S1 P(w+1) = Quo(w): Int[Quo PsiW F] = -Res_strip[P PsiW F] + S1 Int[P(w+1) Dl(w) F] *)
PolyInnerPsi[Quo_, PiPow_, WSines_, Fams_, PsiW_, Gm_, V0_, W0_] := Module[
  {S1, Dg, Ps, P, Eqs, Sol, Kp, Dl, Ftrig, Strip, StripRes, Rest1},
  S1 = (-1)^Length[Fams];
  Dg = Exponent[Quo, MBCHRedW] + If[S1 === 1, 1, 0];
  Ps = Table[Unique["pc"], {Dg + 1}];
  P = Sum[Ps[[J + 1]]*MBCHRedW^J, {J, 0, Dg}];
  Eqs = CoefficientList[Expand[P - S1*(P /. MBCHRedW -> MBCHRedW + 1) - Quo], MBCHRedW];
  If[S1 === 1, Eqs = Append[Eqs, Ps[[1]]]];
  Sol = Solve[Thread[Eqs == 0], Ps];
  If[Sol === {}, Return[$Failed]];
  P = Together[P /. First[Sol]];
  Kp = PsiW[[1]];
  Dl = (-1)^Kp*Kp!/(MBCHRedW + Gm)^(Kp + 1);
  Ftrig = Pi^PiPow/(Times @@ Map[Sin[Pi*#] &, WSines]);
  Strip = Join[Fams[[All, 3]], PsiPoles[Gm, V0, W0, True]];
  Strip = DeleteDuplicatesBy[Strip, Expand];
  StripRes = Map[ResidueAt[P*PsiW*Ftrig, #] &, Strip];
  If[MemberQ[StripRes, $Failed], Return[$Failed]];
  Rest1 = InnerIntegral[PiPow, Together[S1*(P /. MBCHRedW -> MBCHRedW + 1)*Dl], WSines, V0, W0];
  If[Rest1 === $Failed, Return[$Failed]];
  Return[Rest1 - Total[StripRes]]];


(* {Cf, Bt, Pw} with Pt = Cf/(N1 + Bt)^Pw, Pw >= 1 *)
LinearPower[Pt_] := Module[{Fs, Cf, Bt, Pw},
  Fs = If[Head[Pt] === Times, List @@ Pt, {Pt}];
  Cf = 1;
  Bt = None;
  Pw = 0;
  Do[
   Module[{B, P},
    {B, P} = If[Head[F1] === Power, {F1[[1]], F1[[2]]}, {F1, 1}];
    Which[
     FreeQ[F1, MBCHRedN],
      Cf = Cf*F1,
     IntegerQ[P] && P < 0 && PolynomialQ[B, MBCHRedN] && Exponent[B, MBCHRedN] === 1 && Bt === None,
      Module[{Al},
       Al = Coefficient[B, MBCHRedN];
       Cf = Cf*Al^P;
       Bt = Expand[(B - Al*MBCHRedN)/Al];
       Pw = -P],
     True,
      Throw[$Failed, "RegSum"]]],
   {F1, Fs}];
  If[Bt === None, Throw[$Failed, "RegSum"]];
  Return[{Cf, Bt, Pw}]];


(* {PolyGamma of the index, rest} of one term; at most one such PolyGamma, to the first power *)
PsiSplit[T_] := Module[{Fs, Pg},
  Fs = If[Head[T] === Times, List @@ T, {T}];
  Pg = Select[Fs, (Head[#] === PolyGamma && ! FreeQ[#, MBCHRedN]) &];
  If[Length[Pg] > 1 || ! FreeQ[DeleteCases[Fs, Alternatives @@ Pg], PolyGamma[_, _?(! FreeQ[#, MBCHRedN] &)]],
   Throw[$Failed, "RegSum"]];
  If[Pg === {}, Return[{1, T}]];
  Return[{Pg[[1]], T/Pg[[1]]}]];


(* Sum over N1 >= M of a summand rational in N1 or rational times ONE PolyGamma[K, N1 + A].  The pieces that
   diverge alone, 1/(N1 + B) and PolyGamma[0, N1 + A]/(N1 + A), are summed to a common cutoff N:
     Sum 1/(n + B)            = Log N - PolyGamma[0, M + B]
     Sum psi(n + A)/(n + A)   = Log[N]^2/2 - psi(M + A)^2/2 - psi'(M + A)/2
   and their Log N and Log N^2 must cancel; everything else converges and goes to Sum. *)
RegSum[Summand_, M_] := Catch[
  Module[{Terms1, Groups, Val, LCoef, L2Coef, ConvSum},
   ConvSum[X_] := Module[{R},
     R = TimeConstrained[Quiet[Sum[X, {MBCHRedN, M, Infinity}]], MBCHReduceSumTime, $Failed];
     If[R === $Failed || ! FreeQ[R, Sum | Infinity | DirectedInfinity | ComplexInfinity | Indeterminate |
          LerchPhi | HypergeometricPFQ | Hypergeometric2F1 | HypergeometricPFQRegularized],
      Throw[$Failed, "RegSum"]];
     R];
   Terms1 = Expand[Summand];
   Terms1 = If[Head[Terms1] === Plus, List @@ Terms1, {Terms1}];
   Groups = GatherBy[Map[PsiSplit, Terms1], First];
   Val = 0;
   LCoef = 0;
   L2Coef = 0;
   Do[
    Module[{Pf, Rat1, Parts},
     Pf = G1[[1, 1]];
     Rat1 = Together[Total[G1[[All, 2]]]];
     Parts = Apart[Rat1, MBCHRedN];
     Parts = If[Head[Parts] === Plus, List @@ Parts, {Parts}];
     Do[
      Module[{Cf, Bt, Pw, K1, A1},
       {Cf, Bt, Pw} = LinearPower[Pt];
       Which[
        Pf === 1 && Pw === 1,
         LCoef = LCoef + Cf;
         Val = Val - Cf*PolyGamma[0, M + Bt],
        Pf === 1,
         Val = Val + Cf*(-1)^Pw*PolyGamma[Pw - 1, M + Bt]/(Pw - 1)!,
        True,
         K1 = Pf[[1]];
         If[Coefficient[Pf[[2]], MBCHRedN] =!= 1, Throw[$Failed, "RegSum"]];
         A1 = Expand[Pf[[2]] - MBCHRedN];
         If[K1 === 0 && Pw === 1,
          L2Coef = L2Coef + Cf;
          Val = Val + Cf*(-PolyGamma[0, M + A1]^2/2 - PolyGamma[1, M + A1]/2);
          If[Expand[A1 - Bt] =!= 0,
           Val = Val + ConvSum[Cf*(A1 - Bt)*Pf/((MBCHRedN + A1)*(MBCHRedN + Bt))]],
          Val = Val + ConvSum[Cf*Pf/(MBCHRedN + Bt)^Pw]]]],
      {Pt, Parts}]],
    {G1, Groups}];
   If[! TrueQ[Simplify[LCoef == 0]] || ! TrueQ[Simplify[L2Coef == 0]], Throw[$Failed, "RegSum"]];
   Val],
  "RegSum"];


(* the integral over W1 along Re W1 = W0 of Pi^PiPow Rat PsiW / Prod Sin, given V1 on Re V1 = V0 *)
InnerIntegralPsi[PiPow_, RatVW_, WSines_, PsiW_, V0_, W0_] := Catch[
  Module[{Fams, Numer, Denom, Quo, Rd, F, Gm, PolyPart, Special, ResS, Excl, Mx, Summand, Main, Finite, DenW, RPoles},
   If[Coefficient[PsiW[[2]], MBCHRedW] =!= 1, Throw[$Failed, "InnerPsi"]];
   Gm = Expand[PsiW[[2]] - MBCHRedW];
   Numer = Numerator[RatVW];
   Denom = Denominator[RatVW];
   Quo = PolynomialQuotient[Numer, Denom, MBCHRedW];
   Rd = Together[PolynomialRemainder[Numer, Denom, MBCHRedW]/Denom];
   Fams = SineFamilies[WSines, V0, W0];
   If[Fams === $Failed, Throw[$Failed, "InnerPsi"]];
   PolyPart = If[Quo === 0, 0, PolyInnerPsi[Quo, PiPow, WSines, Fams, PsiW, Gm, V0, W0]];
   If[PolyPart === $Failed, Throw[$Failed, "InnerPsi"]];
   F = Pi^PiPow*Rd*PsiW/(Times @@ Map[Sin[Pi*#] &, WSines]);
   (* the poles of the rational function and of PsiW on the right: residues of the whole integrand *)
   DenW = Select[FactorList[Denominator[Rd]], (! FreeQ[#[[1]], MBCHRedW]) &];
   If[AnyTrue[DenW, (Exponent[#[[1]], MBCHRedW] =!= 1) &], Throw[$Failed, "InnerPsi"]];
   RPoles = Map[Expand[-(#[[1]] /. MBCHRedW -> 0)/Coefficient[#[[1]], MBCHRedW]] &, DenW];
   RPoles = Select[RPoles, (N[Re[# /. MBCHRedV -> V0]] > W0) &];
   Special = DeleteDuplicatesBy[Join[RPoles, PsiPoles[Gm, V0, W0, False]], Expand];
   (* a special point on a sine family leaves the family sum *)
   Excl = {};
   Do[
    Do[
     Module[{D1},
      D1 = Expand[P1 - Fams[[I1, 3]]];
      If[IntegerQ[D1],
       If[D1 < 0, Throw[$Failed, "InnerPsi"]];
       AppendTo[Excl, {I1, D1}]]],
     {I1, Length[Fams]}],
    {P1, Special}];
   ResS = Map[ResidueAt[F, #] &, Special];
   If[MemberQ[ResS, $Failed], Throw[$Failed, "InnerPsi"]];
   Summand[N1_] := Total[Table[
      Module[{Fam, Others},
       Fam = Fams[[I1]];
       Others = Delete[Fams, I1];
       Fam[[4]]*If[EvenQ[Length[Fams]], 1, (-1)^N1]/(Pi*Fam[[2]])*Pi^PiPow*
         (Rd /. MBCHRedW -> Fam[[3]] + N1)*(PsiW /. MBCHRedW -> Fam[[3]] + N1)/
         (Times @@ Map[SinOf[#[[1]] /. MBCHRedW -> Fam[[3]]] &, Others])],
      {I1, Length[Fams]}]];
   Mx = If[Excl === {}, 0, 1 + Max[Excl[[All, 2]]]];
   (* two sines: the family sums diverge alone, so sum them to a common cutoff; one sine: alternating *)
   Main = If[EvenQ[Length[Fams]], RegSum[Summand[MBCHRedN], Mx], $Failed];
   If[Main === $Failed,
    Main = TimeConstrained[
      Quiet[Sum[Evaluate[Summand[MBCHRedN]], {MBCHRedN, Mx, Infinity}]],
      MBCHReduceSumTime, $Failed]];
   If[Main === $Failed || ! FreeQ[Main, Sum | Infinity | DirectedInfinity | ComplexInfinity | Indeterminate |
        LerchPhi | HypergeometricPFQ | Hypergeometric2F1 | HypergeometricPFQRegularized], Throw[$Failed, "InnerPsi"]];
   Finite = Total[Flatten[Table[
      If[MemberQ[Excl, {I1, N1}], 0,
       Module[{Fam, Others},
        Fam = Fams[[I1]];
        Others = Delete[Fams, I1];
        Fam[[4]]*If[EvenQ[Length[Fams]], 1, (-1)^N1]/(Pi*Fam[[2]])*Pi^PiPow*
          (Rd /. MBCHRedW -> Fam[[3]] + N1)*(PsiW /. MBCHRedW -> Fam[[3]] + N1)/
          (Times @@ Map[SinOf[#[[1]] /. MBCHRedW -> Fam[[3]]] &, Others])]],
      {N1, 0, Mx - 1}, {I1, Length[Fams]}]]];
   PolyPart - (Main + Finite + Total[ResS])],
  "InnerPsi"];


(* PolyGammas along two directions: v along one, w such that the other direction holds exactly one
   PolyGamma, which becomes PolyGamma[K, w + G(v)] *)
ReduceFramesPsi[Vars_, Psis_] := Module[{PsiDirs, Dirs, Frames},
  PsiDirs = Map[PrimVec[FormVec[#[[2]], Vars]] &, Psis];
  Dirs = DeleteDuplicates[DeleteCases[PsiDirs, {0, 0}]];
  If[Length[Dirs] =!= 2, Return[{}]];
  Frames = {};
  Do[
   Module[{Pout, Pin, Idx},
    Pout = Dirs[[Io]];
    Pin = Dirs[[3 - Io]];
    Idx = Flatten[Position[PsiDirs, Pin, {1}]];
    If[Length[Idx] === 1,
     Do[
      If[Det[{Pout, Q1}] === 1,
       Module[{U1, Ui, Cw},
        U1 = {Pout, Q1};
        Ui = Inverse[U1];
        Cw = (FormVec[Psis[[Idx[[1]], 2]], Vars] . Ui)[[2]];
        Which[
         Cw === 1, AppendTo[Frames, {U1, Idx[[1]]}],
         Cw === -1, AppendTo[Frames, {-U1, Idx[[1]]}]]]],
      {Q1, Tuples[Range[-2, 2], 2]}]]],
   {Io, 2}];
  Frames = SortBy[Frames, (Total[Abs[#[[1, 2]]]] &)];
  Return[Frames]];


(* Sin, Cos, Csc, Sec, Cot, Tan of Pi times a linear form become Gammas and PolyGammas, in ONE replacement:
   1/Sin[x] written back would evaluate to Csc[x] again; HarmonicNumber becomes PolyGamma *)
TrigToGamma[Expr_] := Module[{E1},
  E1 = Expr /. HarmonicNumber[X_] :> PolyGamma[0, X + 1] + EulerGamma;
  E1 = E1 /. {
    Sin[X_] :> With[{A = Expand[X/Pi]}, Pi/(Gamma[A]*Gamma[1 - A])],
    Csc[X_] :> With[{A = Expand[X/Pi]}, Gamma[A]*Gamma[1 - A]/Pi],
    Cos[X_] :> With[{A = Expand[X/Pi]}, Pi/(Gamma[1/2 + A]*Gamma[1/2 - A])],
    Sec[X_] :> With[{A = Expand[X/Pi]}, Gamma[1/2 + A]*Gamma[1/2 - A]/Pi],
    Cot[X_] :> With[{A = Expand[X/Pi]}, (PolyGamma[0, 1 - A] - PolyGamma[0, A])/Pi],
    Tan[X_] :> With[{A = Expand[X/Pi]}, (PolyGamma[0, 1/2 + A] - PolyGamma[0, 1/2 - A])/Pi]};
  Return[E1]];


(* one term Coef * Gammas * PolyGammas * powers of linear forms of V1 -> {Coef, Num, Den}, or $Failed *)
TermStruct[T_] := Catch[
  Module[{Fs, Coef, NumP, DenP},
   Fs = If[Head[T] === Times, List @@ T, {T}];
   Coef = 1;
   NumP = {};
   DenP = {};
   Do[
    Module[{B, P},
     {B, P} = If[Head[F1] === Power, {F1[[1]], F1[[2]]}, {F1, 1}];
     Which[
      FreeQ[F1, MBCHRedV],
       Coef = Coef*F1,
      ! IntegerQ[P],
       Throw[$Failed, "TS"],
      Head[B] === Gamma,
       If[P > 0, NumP = Join[NumP, ConstantArray[B[[1]], P]], DenP = Join[DenP, ConstantArray[B[[1]], -P]]],
      Head[B] === PolyGamma && Length[B] === 2 && P > 0,
       NumP = Join[NumP, ConstantArray[{B[[1]], B[[2]]}, P]],
      PolynomialQ[B, MBCHRedV] && Exponent[B, MBCHRedV] === 1,
       Module[{Al, Sh},
        Al = Coefficient[B, MBCHRedV];
        Sh = Expand[B/Al];
        Coef = Coef*Al^P;
        If[P > 0,
         NumP = Join[NumP, ConstantArray[Sh + 1, P]];
         DenP = Join[DenP, ConstantArray[Sh, P]],
         NumP = Join[NumP, ConstantArray[Sh, -P]];
         DenP = Join[DenP, ConstantArray[Sh + 1, -P]]]],
      True,
       Throw[$Failed, "TS"]]],
    {F1, Fs}];
   {Coef, NumP, DenP}],
  "TS"];


(* the one-fold pieces of H(V1): {{Coef, Num, Den}, ...} with equal structures merged, or $Failed *)
OneFoldPieces[H_] := Module[{H1, Terms1, Structs, Grouped},
  H1 = TrigToGamma[H];
  H1 = Expand[H1];
  Terms1 = If[Head[H1] === Plus, List @@ H1, {H1}];
  Structs = Map[TermStruct, Terms1];
  If[MemberQ[Structs, $Failed], Return[$Failed]];
  Structs = Map[{#[[1]], Sort[#[[2]]], Sort[#[[3]]]} &, Structs];
  Grouped = GatherBy[Structs, Rest];
  Grouped = Map[{Total[#[[All, 1]]], #[[1, 2]], #[[1, 3]]} &, Grouped];
  Grouped = Select[Grouped, (Simplify[#[[1]]] =!= 0) &];
  Return[Grouped]];


(* no Gamma or PolyGamma of a piece may have a pole on the contour (a Den Gamma only has zeros) *)
PieceOnContourQ[NumP_, DenP_, V0_] := Module[{Args, Vals},
  Args = Map[If[Head[#] === List, #[[2]], #] &, NumP];
  Vals = Map[N[# /. MBCHRedV -> V0] &, Args];
  Return[AnyTrue[Vals, (Re[#] <= 10^-8 && Abs[Re[#] - Round[Re[#]]] < 10^-8) &]]];


(* cheap test: the Gammas pair into sines and some frame exists for the PolyGammas *)
ReduceEligibleQ[IntVar_, Num_, Den_] := Module[{Vars, Gt, Psis},
  Vars = Keys[IntVar];
  If[Length[Vars] =!= 2 || AnyTrue[Den, ListQ], Return[False]];
  Gt = GammaTrig[Num, Den, Vars];
  If[Gt === $Failed, Return[False]];
  Psis = Select[Num, ListQ];
  Return[Join[ReduceFrames[Vars, Psis, Gt[[3]]], ReduceFramesPsi[Vars, Psis]] =!= {}]];


ReduceSolve[IntVar_, MBVars_, Num_, Den_, Ref_] := Module[{Vars, Vals, Gt, Psis, Frames, Start, Res},
  Vars = Keys[IntVar];
  Vals = Values[IntVar];
  If[Length[Vars] =!= 2 || ! NumericQ[Ref], Return[$Failed]];
  (* a PolyGamma in the denominator is not of this form; FreeQ would also see the list {} itself *)
  If[AnyTrue[Den, ListQ], Return[$Failed]];
  Gt = GammaTrig[Num, Den, Vars];
  If[Gt === $Failed, AbelTrace["reduce: Gammas do not pair into sines"]; Return[$Failed]];
  Psis = Select[Num, (Head[#] === List) &];
  Frames = Join[Map[{#, 0} &, ReduceFrames[Vars, Psis, Gt[[3]]]], ReduceFramesPsi[Vars, Psis]];
  If[Frames === {}, AbelTrace["reduce: no frame for these PolyGammas"]; Return[$Failed]];
  Start = AbsoluteTime[];
  Res = Catch[
    Do[
     Module[{U, Ip, Ui, Sub, RatVW, SinVW, WSines, OSines, PsiAll, PsiV, PsiW, V0, W0, Inner, Outer, H, Pieces, Vals1, Total1},
      If[AbsoluteTime[] - Start > MBCHReduceBudget, Break[]];
      If[! MarkStage[{"reduce", Fr}], Continue[]];
      U = Fr[[1]];
      Ip = Fr[[2]];
      Ui = Inverse[U];
      Sub = Thread[Vars -> Ui . {MBCHRedV, MBCHRedW}];
      RatVW = Together[Gt[[2]] /. Sub];
      SinVW = Map[Expand[# /. Sub] &, Gt[[3]]];
      WSines = Select[SinVW, (! FreeQ[#, MBCHRedW]) &];
      OSines = Select[SinVW, FreeQ[#, MBCHRedW] &];
      If[! MemberQ[{1, 2}, Length[WSines]], Continue[]];
      If[! AllTrue[WSines, MemberQ[{1, -1}, Coefficient[#, MBCHRedW]] &], Continue[]];
      If[Length[WSines] === 2 && PrimVec[FormVec[WSines[[1]], {MBCHRedV, MBCHRedW}]] ===
           PrimVec[FormVec[WSines[[2]], {MBCHRedV, MBCHRedW}]], Continue[]];
      PsiAll = Map[PolyGamma[#[[1]], Expand[#[[2]] /. Sub]] &, Psis];
      If[Ip === 0,
       PsiV = PsiAll;
       PsiW = None,
       PsiW = PsiAll[[Ip]];
       PsiV = Delete[PsiAll, Ip]];
      If[! FreeQ[PsiV, MBCHRedW], Continue[]];
      V0 = U[[1]] . Vals;
      W0 = U[[2]] . Vals;
      AbelTrace["reduce: frame " <> ToString[U] <> ", w in " <> ToString[Length[WSines]] <> " sines" <>
        If[PsiW === None, "", ", and in " <> ToString[PsiW, InputForm]]];
      Inner = If[PsiW === None,
        InnerIntegral[Gt[[1]], RatVW, WSines, V0, W0],
        InnerIntegralPsi[Gt[[1]], RatVW, WSines, PsiW, V0, W0]];
      If[Inner === $Failed, AbelTrace["reduce: inner integral failed"]; Continue[]];
      Outer = (Times @@ PsiV)/(Times @@ Map[SinOf, OSines]);
      H = Outer*Inner;
      Pieces = OneFoldPieces[H];
      If[Pieces === $Failed, AbelTrace["reduce: pieces not of MB form"]; Continue[]];
      If[AnyTrue[Pieces, PieceOnContourQ[#[[2]], #[[3]], V0] &], AbelTrace["reduce: a piece has a pole on the contour"]; Continue[]];
      AbelTrace["reduce: " <> ToString[Length[Pieces]] <> " one-fold pieces"];
      Vals1 = Catch[MapIndexed[
        Function[{Pc, Ix},
         Module[{V, T0},
          T0 = AbsoluteTime[];
          V = Block[{MBCHInReduce = True},
            SafeEval[MBSolveOne[{Vars[[1]] -> V0}, {Subscript[MBCHScaleX, 1]},
              Pc[[2]] /. MBCHRedV -> Vars[[1]], Pc[[3]] /. MBCHRedV -> Vars[[1]]]]];
          AbelTrace["reduce: piece " <> ToString[Ix[[1]]] <> If[V === $Failed || V === Indeterminate || DirtyQ[V],
            " NOT solved", " solved"] <> " (" <> ToString[Round[AbsoluteTime[] - T0]] <> " s) Num " <>
            ToString[Pc[[2]], InputForm] <> " Den " <> ToString[Pc[[3]], InputForm]];
          If[V === $Failed || V === Indeterminate || DirtyQ[V], Throw[$Failed, "Piece"]];
          V]],
        Pieces], "Piece"];
      If[Vals1 === $Failed, AbelTrace["reduce: a one-fold piece was not solved"]; Continue[]];
      Total1 = Total[Pieces[[All, 1]]*Vals1];
      VPrint["        one-fold reduction ", U, ": ", Length[Pieces], " pieces, contour check ", ValueOkQ[Total1, Ref]];
      If[ValueOkQ[Total1, Ref] === True, Throw[Total1, "Reduce"]]],
     {Fr, Frames}];
    $Failed, "Reduce"];
  Return[Res]];


(* ::Subsubsection::Closed:: *)
(*Solving One Structure*)


MBSolveOne[IntVar_, MBVars_, Num_, Den_] :=
 MBSolveOne[IntVar, MBVars, Num, Den] = Module[
  {Sub, Ref, Got, ResolveOut, Order1, Kind, Val, Best, Clean, Spent, T0, Pr, Res, Verdict, Direct},
  MBSeriesCache = <||>;
  Sub = Cases[MBVars, Q_Subscript :> (Q -> 1)];
  Ref = MBVerify[IntVar, MBVars, Num, Den];
  If[ScaleFreeQ[MBVars /. Sub], Pr = {}, Pr = ProbeRule[]];
  Say["Obtaining series solutions ..."];
  MarkStage[{"series"}];
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
            W = If[MarkStage[{"piece", J, K}],
               TimeConstrained[MBSumSeries[RO, Sub, K], MBCHChartTime, $Failed],
               $Failed];
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
     If[! MarkStage[{"chart", K}],
      VPrint["        series ", K, " skipped: it crashed a subkernel"];
      Continue[]];
     T0 = AbsoluteTime[];
     Say["Series solution obtained!"];
     Say["Resumming with EvaluateMultiSums " <> ToString[MBResumJ] <>
         "/" <> ToString[MBResumN]];
     Val = TimeConstrained[MBSumSeries[ResolveOut, Sub, K], MBCHChartTime, $Failed];
     Spent = Spent + (AbsoluteTime[] - T0);
     If[Val === $Failed || DirtyQ[Val],
      Say["EvaluateMultiSums failed! Deriving another series solution."]];
     If[Val =!= $Failed && ! DirtyQ[Val],
      (* a closed form that matches the contour needs no series check; never accept unjudged *)
      Direct = ValueOkQ[Val, Ref];
      If[Direct === True,
         Verdict = True,
         Verdict = SeriesOkQ[ResolveOut, Sub, K, Ref, Pr]];
      If[Verdict === $Failed, Verdict = Direct];
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
  (* a scaleless trigonometric 2-fold: the exact one-fold reduction first, checked against the contour *)
  If[Length[IntVar] === 2 && ScaleFreeQ[MBVars /. Sub] && ! TrueQ[MBCHInReduce] && ! TrueQ[MBCHInTransform] &&
     NumericQ[Ref] && ReduceEligibleQ[IntVar, Num, Den],
   Say["Reducing to one-folds ..."];
   Val = SafeEval[ReduceSolve[IntVar, MBVars, Num, Den, Ref]];
   If[Val =!= $Failed && ! DirtyQ[Val], Return[Val]]];
  (* an artificial scale, with or without kinematic ones: sum with it live and take y -> 1, before the regulator *)
  If[Kind === "Single" && ! FreeQ[MBVars, Subscript[MBCHScaleX, _]],
   Say["Abel summation ..."];
   Val = SafeEval[AbelFrom[ResolveOut, Order1, MBVars, Ref]];
   If[Val =!= $Failed && ! DirtyQ[Val], Return[Val]]];
  Say["Using the analytic regulator!"];
  If[MarkStage[{"reg"}],
     Val = SafeEval[MBRegulate[IntVar, MBVars, Num, Den]],
     Val = $Failed];
  (* DirtyQ only checks that the S-sums convert, so convert the regulator result here *)
  If[Val =!= $Failed, Val = SumsToMPL[Val]];
  (* the two-index regulator is new: it must not contradict the contour *)
  If[Length[IntVar] === 2 && Val =!= $Failed && ValueOkQ[Val, Ref] === False,
     VPrint["        two-fold regulator contradicts the contour"];
     Val = $Failed];
  If[Val =!= $Failed && ! DirtyQ[Val], Return[Val]];
  (* a scaleless 2-fold that nothing summed: the same integral after z -> T w gives other charts *)
  If[Length[IntVar] === 2 && ScaleFreeQ[MBVars /. Sub] && ! TrueQ[MBCHInTransform] && NumericQ[Ref],
   Say["Changing integration variables ..."];
   Val = SafeEval[TransformSolve[IntVar, MBVars, Num, Den, Ref]];
   If[Val =!= $Failed && ! DirtyQ[Val], Return[Val]]];
  Return[Res]];


(* ::Subsubsection::Closed:: *)
(*Change of Integration Variables*)


MBCHTransforms = {{{1, 1}, {0, 1}}, {{1, 0}, {1, 1}}, {{1, -1}, {0, 1}}, {{1, 0}, {-1, 1}}};

MBCHTransformBudget = 3600;   (* seconds for all the changes of variables of one structure *)

MBCHInTransform = False;      (* set while a transformed structure is solved, so it is not transformed again *)


(* z = T w with det T = 1: the straight contour Re z = z0 becomes Re w = T^-1 z0, every Gamma argument keeps
   its real part there, so the poles stay on the same sides and the integral is unchanged *)
TransformStruct[IntVar_, MBVars_, Num_, Den_, T_] := Module[{Vars, Vals, VarRule, Sub1, NumT, DenT, IntVarT, MBVarsT},
  Vars = Keys[IntVar];
  Vals = Values[IntVar];
  VarRule = Thread[Vars -> T . Vars];
  Sub1 = Function[A, If[Head[A] === List, {A[[1]], Expand[A[[2]] /. VarRule]}, Expand[A /. VarRule]]];
  NumT = Map[Sub1, Num];
  DenT = Map[Sub1, Den];
  IntVarT = Thread[Vars -> LinearSolve[T, Vals]];
  (* the scales of a scaleless structure are artificial: fresh ones for the new variables *)
  MBVarsT = Table[Subscript[MBCHScaleX, J], {J, Length[Vars]}];
  Return[{IntVarT, MBVarsT, NumT, DenT}]];


(* each change of variables in turn; a value is kept only if it matches the original contour *)
TransformSolve[IntVar_, MBVars_, Num_, Den_, Ref_] := Module[{Start, Res},
  Start = AbsoluteTime[];
  Res = Catch[
    Do[
     Module[{St, V},
      If[AbsoluteTime[] - Start > MBCHTransformBudget, Break[]];
      St = TransformStruct[IntVar, MBVars, Num, Den, T];
      AbelTrace["transform " <> ToString[T] <> ": Num " <> ToString[St[[3]], InputForm] <> " contour " <> ToString[Values[St[[1]]]]];
      V = Block[{MBCHInTransform = True, MBCHStagePrefix = Append[MBCHStagePrefix, {"tf", T}]},
        SafeEval[MBSolveOne @@ St]];
      VPrint["        change of variables ", T, ": ", If[V === Indeterminate || V === $Failed || DirtyQ[V], "not solved", "solved"]];
      If[V =!= Indeterminate && V =!= $Failed && ! DirtyQ[V] && ValueOkQ[V, Ref] === True, Throw[V, "Tf"]]],
     {T, MBCHTransforms}];
    $Failed, "Tf"];
  Return[Res]];


(* ::Subsection:: *)
(*External Module*)


(* ::Subsubsection::Closed:: *)
(*MBCH2MPL*)


Options[MBCH2MPL] = {Verbose -> False, BarnesReduce -> True, Complex -> False};

MBCH2MPL[MBInt_, {Eps_, Ord_}, opts : OptionsPattern[]] :=
  MBCH2MPL[MBInt, Automatic, {Eps, Ord}, opts];

MBCH2MPL[MBInt_, MBVar_, {Eps_, Ord_}, OptionsPattern[]] := Module[
  {Expanded, IntVars, SafeVars, Low, Res, Coeffs, K, Tmp, Structs, Groups},
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
  (* EMS writes zeta values as z2, z3, z5, ...: an integration variable named z5 would be taken
     for a leftover variable wherever Zeta[5] appears, so the variables are renamed; they stay in
     Global`, since CoefOf treats any other context as a leak and drops those terms *)
  SafeVars = Table[Symbol["Global`MBResumIntVar" <> ToString[K1]], {K1, Length[IntVars]}];
  Expanded = Expanded /. Thread[IntVars -> SafeVars];
  IntVars = SafeVars;

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

  (* structures of every order first, so the contours and then the solves each run as one parallel batch *)
  Structs = Table[OrderStructs[Expanded, K], {K, Low, Ord}];
  PrimeVerify[Flatten[Structs, 1]];
  Groups = Map[GroupStructs, Structs];
  If[WorkersReady[], SolveAll[Flatten[Map[GroupTasks, Groups], 1]]];
  Coeffs = Table[MBCH2MPLOrder[Groups[[K - Low + 1]], IntVars, K], {K, Low, Ord}];
  Res = Total[Table[Coeffs[[K - Low + 1]]*Eps^K, {K, Low, Ord}]];
  Say["Done!"];
  VPrint["  done."];
  Return[Res]];

OrderStructs[Expanded_, Ord_] := Module[{Structs},
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
  Return[Structs]];

(* ::Subsubsection::Closed:: *)
(*Cell Checkpoint*)


MBCHCacheFile = None;   (* file of {"V", structure, contour} and {"S", structure, value} records, or None *)


(* the records of an earlier, killed run of the same cell *)
LoadCellCache[] := Module[{Recs},
  If[! StringQ[MBCHCacheFile] || ! FileExistsQ[MBCHCacheFile], Return[0]];
  Recs = Quiet[ReadList[MBCHCacheFile, Expression]];
  If[! ListQ[Recs], Return[0]];
  Recs = Select[Recs, MatchQ[#, {"V" | "S", _, _}] &];
  Scan[If[#[[1]] === "V", MBVerifyCache[#[[2]]] = #[[3]], MBSolveCache[#[[2]]] = #[[3]]] &, Recs];
  Return[Length[Recs]]];


SaveCellRecord[Tag_, Key_, Val_] := If[StringQ[MBCHCacheFile], Quiet[PutAppend[{Tag, Key, Val}, MBCHCacheFile]]];


(* the grouping keys need one contour value per structure: the new ones go to the subkernels, a few per kernel
   at a time, each batch recorded in the checkpoint *)
PrimeVerify[Structs_] := Module[{Args, New, Batches, Got},
  Got = LoadCellCache[];
  If[Got > 0, Say["Checkpoint: " <> ToString[Got] <> " records of an earlier run"]];
  Args = Select[Structs, #[[2]] =!= Null &];
  Args = DeleteDuplicates[Map[#[[2 ;; 5]] &, Args]];
  New = Select[Args, ! KeyExistsQ[MBVerifyCache, #] &];
  If[Length[New] < 2 || ! WorkersReady[], Return[Null]];
  SyncWorkers[];
  Say["Contour values of " <> ToString[Length[New]] <> " structures on " <> ToString[$KernelCount] <> " kernels ..."];
  Batches = Partition[New, UpTo[4*Max[1, $KernelCount]]];
  Do[
   Module[{Refs},
    Refs = Block[{Parallel`Settings`$RecoveryMode = "Abandon"},
      ParallelMap[{"Done", MBVerify @@ #} &, Bt, Method -> "FinestGrained"]];
    (* only a structure whose subkernel died is left for the master to integrate *)
    Do[
     If[MatchQ[Refs[[K]], {"Done", _}],
      MBVerifyCache[Bt[[K]]] = Refs[[K, 2]];
      SaveCellRecord["V", Bt[[K]], Refs[[K, 2]]]],
     {K, Length[Bt]}]],
   {Bt, Batches}];
  Return[Null]];

GroupStructs[Structs_] := Module[{},
  If[Structs === {}, Return[{}]];
  Return[Values[GroupBy[Structs, GroupKey]]]];

GroupTasks[Groups_] := Module[{Tasks},
  Tasks = Select[Range[Length[Groups]], Groups[[#, 1, 2]] =!= Null &];
  Return[Map[{#, Groups[[#, 1, 2 ;; 5]]} &, Tasks]]];

MBCH2MPLOrder[Groups_, IntVars_, Ord_] := Module[
  {Res, Bad, Total1, Tasks, Vals},
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
