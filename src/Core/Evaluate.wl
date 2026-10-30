(* ::Package:: *)

(* ::Title:: *)
(*MBAnalytica: MBEvaluate*)


(* ::Text:: *)
(*Read inside MBAnalytica`Private` by MBAnalytica.wl.  Each method is loaded the first time it is used.  With*)
(*Method -> Automatic the methods available on this machine are tried in the order SymbolicSum, ExpandInt, Subtraction,*)
(*and every later method only receives the orders the earlier ones could not close.*)


(* ::Section:: *)
(*Settings*)


(* $KernelLaunch when the user set it; otherwise 4, at most one per core, and at most what the free memory holds: an
   engine worker loads PolyLogTools with the weight-10 HPL tables, about 3.5 GB, and the main kernel needs as much *)
KernelCount[] := Module[{Asked, FreeGB, ByMemory},
  Asked = Global`$KernelLaunch;
  If[IntegerQ[Asked] && Asked >= 0, Return[Asked]];
  FreeGB = MemoryAvailable[]/2.^30;
  ByMemory = Max[1, Floor[(FreeGB - 4)/3.5]];
  Return[Min[4, $ProcessorCount, ByMemory]]];


CacheDirectory[] := Module[{Asked, Folder},
  Asked = Global`$MBAnalyticaCacheDirectory;
  Folder = If[StringQ[Asked] && Asked =!= "", Asked, FileNameJoin[{$UserBaseDirectory, "ApplicationData", "MBAnalytica"}]];
  Quiet[CreateDirectory[Folder, CreateIntermediateDirectories -> True]];
  (* worker kernels and processes inherit the environment, so they use the same folder *)
  SetEnvironment["MBANALYTICA_CACHE" -> Folder];
  Return[Folder]];


Say[Verbose1_, Parts__] := If[TrueQ[Verbose1], Print["  ", Parts]];


(* ::Section:: *)
(*Values of the user*)


(* the values that the user gave to Global` symbols must not reach the methods: HypExp is read with Global` on its
   context path (BeginPackage["HypExp`", {"HPL`", "Global`"}]), so a user's e = eps became the value of its own
   pattern variable e, and the Subtraction method returned HypExp`Private`DenCoeff[...]; with x, n, k, S, L, ... set,
   the kernel crashed.  While the methods load and run, every Global` symbol that holds a value of the user is
   therefore blocked.  Kept are the names with $ (the settings, such as $KernelLaunch), the values that the methods
   and their packages set themselves, and every symbol with definitions. *)
EngineGlobals = {};


GlobalValueQ[Name_String] := ToExpression["Global`" <> Name, InputForm,
  Function[Sym, OwnValues[Sym] =!= {} && DownValues[Sym] === {} && SubValues[Sym] === {} && UpValues[Sym] === {} &&
    FreeQ[Attributes[Sym], Protected | Locked], HoldAll]];


GlobalValueNames[] := Module[{Names1},
  Names1 = StringDelete[Names["Global`*"], StartOfString ~~ "Global`"];
  Names1 = Select[Names1, ! StringStartsQ[#, "$"] &];
  Return[Select[Names1, GlobalValueQ]]];


SetAttributes[KeepEngineGlobals, HoldAll];
KeepEngineGlobals[Expr_] := Module[{Result},
  Result = Expr;
  EngineGlobals = Union[EngineGlobals, GlobalValueNames[]];
  Return[Result]];


SetAttributes[WithoutUserValues, HoldAll];
WithoutUserValues[Expr_] := Module[{UserNames, Held, Result},
  UserNames = Complement[GlobalValueNames[], EngineGlobals];
  Held = Map[ToExpression["Global`" <> #, InputForm, Hold] &, UserNames];
  Held = Join[Hold[], Sequence @@ Held];
  Result = Replace[Held, Hold[Syms___] :> Block[{Syms}, KeepEngineGlobals[Expr]]];
  Return[Result]];


(* ::Section:: *)
(*Rules of the SymbolicSum packages*)


(* HarmonicSums, Sigma and EvaluateMultiSums, which load with the SymbolicSum method before the engine (LoadSymbolicInt),
   give rules to System symbols: 95 to D, 17 to Derivative, 12 to Series, 10 to Less, 8 to Unequal and one each to Limit,
   Abs and Conjugate.  The engine never uses these packages (load_standard.m switches its HarmonicSums closer off) and was
   validated without their rules, which change it: MBresolve evaluates the residues about seventy times slower (the rules
   of D and Derivative: 260 s instead of 4 s for the inclusive N4LO integral), and MBexpand cancels shifted Gamma ratios
   into rational denominators (the rules of Series: Gamma(1 + z)/Gamma(2 + z) becomes 1/(1 + z)), after which DoAllBarnes
   reduces the integrals differently (that integral split into 49 pieces instead of 60, one of which no closer evaluates,
   and the ExpandInt method lost its coefficient of eps^-3).  The engine and the leading pole therefore run without the
   rules of these packages, as the multifold closer of the engine already did for Series (withPlainSeries); the
   SymbolicSum method keeps them.  A rule of these packages is told apart from the definitions that Mathematica loads on
   demand by the contexts of its symbols (its pattern variables and functions), and the rules are looked up at every
   call, so that rules a package gives later, or a package the user loaded first, are found as well *)
SymbolicSumContexts = {"HarmonicSums`", "Sigma`", "EvaluateMultiSums`", "RISC`", "MBConicHulls`",
  "MultivariateResidues`", "MBAnalytica`SymbolicSum`", "MBAnalytica`OneFoldHyp`"};


RuleLists[Name_String] := Module[{Lists1},
  Lists1 = Quiet[ToExpression["System`" <> Name, InputForm,
    Function[Sym, {DownValues[Sym], UpValues[Sym], SubValues[Sym], NValues[Sym]}, HoldAll]]];
  If[! MatchQ[Lists1, {_List, _List, _List, _List}], Lists1 = {{}, {}, {}, {}}];
  Return[Lists1]];


(* the atoms only: _Symbol also matches an unevaluated call Symbol["name"] *)
SymbolicSumRuleQ[Rule1_] := Module[{Contexts1},
  Contexts1 = Cases[Rule1, S1_Symbol /; AtomQ[Unevaluated[S1]] :> Context[S1], {0, Infinity}, Heads -> True];
  Return[AnyTrue[Contexts1, StringStartsQ[#, SymbolicSumContexts] &]]];


NameSymbolicSumRules[Name_String] := Module[{Lists1},
  Lists1 = RuleLists[Name];
  Return[Map[Select[#, SymbolicSumRuleQ] &, Lists1]]];


(* the rules of these packages in System symbols, by name of the symbol; none while no package of theirs is loaded *)
SymbolicSumRules[] := Module[{Loaded, Names1, Rules1},
  Loaded = Select[$Packages, StringStartsQ[#, SymbolicSumContexts] &];
  If[Loaded === {}, Return[<||>]];
  Names1 = Select[Names["System`*"], ! StringStartsQ[#, "$"] &];
  Rules1 = Association[Map[# -> NameSymbolicSumRules[#] &, Names1]];
  Rules1 = Select[Rules1, Total[Map[Length, #]] > 0 &];
  Return[Rules1]];


SetAttributes[RemoveSymbolRules, HoldFirst];
RemoveSymbolRules[Sym_Symbol, Rules1_List] := Module[{ProtectedQ, Hashes},
  ProtectedQ = MemberQ[Attributes[Sym], Protected];
  Unprotect[Sym];
  Hashes = Map[Hash, Rules1[[1]]];
  DownValues[Sym] = Select[DownValues[Sym], ! MemberQ[Hashes, Hash[#]] &];
  Hashes = Map[Hash, Rules1[[2]]];
  UpValues[Sym] = Select[UpValues[Sym], ! MemberQ[Hashes, Hash[#]] &];
  Hashes = Map[Hash, Rules1[[3]]];
  SubValues[Sym] = Select[SubValues[Sym], ! MemberQ[Hashes, Hash[#]] &];
  Hashes = Map[Hash, Rules1[[4]]];
  NValues[Sym] = Select[NValues[Sym], ! MemberQ[Hashes, Hash[#]] &];
  If[ProtectedQ, Protect[Sym]];
  Return[Null]];


RemoveNameRules[Name_String, Rules1_List] := ToExpression["System`" <> Name, InputForm,
  Function[Sym, RemoveSymbolRules[Sym, Rules1], HoldAll]];


(* the rules are set aside inside Internal`InheritedBlock, which gives every symbol its full definition back afterwards *)
SetAttributes[WithoutSymbolicSumRules, HoldAll];
WithoutSymbolicSumRules[Expr_] := Module[{Rules1, Held, Result},
  Rules1 = SymbolicSumRules[];
  If[Rules1 === <||>, Return[Expr]];
  Held = Map[ToExpression["System`" <> #, InputForm, Hold] &, Keys[Rules1]];
  Held = Join[Hold[], Sequence @@ Held];
  Result = Replace[Held, Hold[Syms___] :> Internal`InheritedBlock[{Syms},
    KeyValueMap[RemoveNameRules, Rules1];
    Expr]];
  Return[Result]];


(* ::Section:: *)
(*Loading the methods*)


MBToolsDirectory = FileNameJoin[{PackageRoot, "src", "SymbolicInt", "mbtools"}];


(* Every method loads with the user's $ContextPath kept as it was: a package that exports a common name (PolyLogTools
   exports \[Epsilon]) would otherwise shadow the symbols of integrals the user typed before.  Each method then runs with
   the context path it had right after it loaded, the setting it was validated in; the user's path never gains the
   contexts of the methods (ShowOutputContexts). *)


(* the results print as G[...]: PolyLogTools`G is displayed without its context, as an InterpretationBox, so that a
   copied output is PolyLogTools`G again.  PolyLogTools` itself is NOT put on the user's context path: it exports about
   240 short names (a, ..., z, e, u1, ..., u12, x1, ...), and every symbol the user types afterwards under one of these
   names would become a symbol of PolyLogTools (u2 and u3 of an integrand typed after the first ExpandInt or Subtraction
   call became PolyLogTools`u2 and PolyLogTools`u3, and SymbolicSum then solved none of its sums) *)
ShowOutputContexts[] := Module[{},
  (* defined again on every call: loading PolyLogTools clears the rules of G that were made before it; the boxes are
     built before they enter the InterpretationBox, which holds its arguments *)
  PolyLogTools`G /: MakeBoxes[PolyLogTools`G[Args___], StandardForm] :=
    With[{Boxes = RowBox[{"G", "[", RowBox[Riffle[Map[MakeBoxes[#, StandardForm] &, {Args}], ","]], "]"}]},
      InterpretationBox[Boxes, PolyLogTools`G[Args]]];
  Return[Null]];


(* the context path of a fresh kernel, in which each method was validated *)
FreshContextPath = {"System`", "Global`"};


LoadMBTools[] := Module[{},
  If[TrueQ[MBToolsLoaded], Return[True]];
  If[! MemberQ[$Path, MBToolsDirectory], PrependTo[$Path, MBToolsDirectory]];
  Block[{$Output = {}, $ContextPath = FreshContextPath},
    (* MB.m defines its own option Verbose: the warning Verbose::shdw on loading it is expected *)
    If[DownValues[MB`MBresolve] === {},
      Quiet[Get[FileNameJoin[{MBToolsDirectory, "MB.m"}]], General::shdw];
      Quiet[Get[FileNameJoin[{MBToolsDirectory, "MBresolve.m"}]], General::shdw]];
    If[DownValues[BarnesRoutines`DoAllBarnes] === {},
      Get[FileNameJoin[{MBToolsDirectory, "barnesroutines.m"}]]]];
  MBToolsLoaded = DownValues[MB`MBresolve] =!= {} && DownValues[BarnesRoutines`DoAllBarnes] =!= {};
  Return[MBToolsLoaded]];


LoadSymbolicSum[] := Module[{SymbolicSumFile, Folder},
  If[TrueQ[SymbolicSumLoaded], Return[True]];
  LoadMBTools[];
  AddRISCPath[];
  Folder = FileNameJoin[{PackageRoot, "dep", "MBConicHulls"}];
  If[! MemberQ[$Path, Folder], PrependTo[$Path, Folder]];
  CacheDirectory[];
  (* MBSymbolicSum launches the subkernels before MBConicHulls loads (MBConicHulls would start two per core); it reads
     Global`$KernelLaunch, which keeps the user's value and otherwise gets the default *)
  If[! IntegerQ[Global`$KernelLaunch], Global`$KernelLaunch = KernelCount[]];
  SymbolicSumFile = FileNameJoin[{PackageRoot, "src", "SymbolicSum", "MBSymbolicSum.wl"}];
  (* MBSymbolicSum reads the option and failure symbols of MBAnalytica`; its own context stays off the user's path *)
  (* as in a fresh kernel after MB.m, MBresolve.m and barnesroutines.m, with MBAnalytica` first so that MBSymbolicSum's
     option and failure symbols are those of MBEvaluate *)
  Block[{$ContextPath = Join[{"MBAnalytica`", "BarnesRoutines`", "MB`"}, FreshContextPath], $Output = {}},
    Get[SymbolicSumFile];
    SymbolicSumContextPath = $ContextPath];
  (* the one-fold series of hypergeometric type, summed directly (OneFoldHyp.wl); its context stays off the user's path *)
  Block[{$ContextPath = $ContextPath},
    Get[FileNameJoin[{PackageRoot, "src", "SymbolicSum", "OneFoldHyp.wl"}]]];
  SymbolicSumLoaded = DownValues[MBAnalytica`SymbolicSum`MBCH2MPL] =!= {};
  Return[SymbolicSumLoaded]];


LoadSymbolicInt[] := Module[{Loader, StartDirectory},
  If[TrueQ[SymbolicIntLoaded], Return[True]];
  (* the RISC packages of SymbolicSum load before the engine: the engine leaves symbols such as S, L$ and F$ in Global`,
     and HarmonicSums, Sigma and EvaluateMultiSums loaded after it share these names with them (L$::shdw, F$::shdw),
     after which EvaluateMultiSums solved none of the nested sums of a later SymbolicSum call (and on 16 GB the kernel
     crashed); the engine then runs without the rules these packages give to System symbols (WithoutSymbolicSumRules) *)
  If[MemberQ[$MBAnalyticaMethods, "SymbolicSum"], LoadSymbolicSum[]];
  LoadMBTools[];
  CacheDirectory[];
  StartDirectory = Directory[];
  Loader = FileNameJoin[{PackageRoot, "src", "SymbolicInt", "load_standard.m"}];
  Block[{$Output = {}, $ContextPath = FreshContextPath},
    CheckAbort[Get[Loader], Null];
    EngineContextPath = $ContextPath];
  SetDirectory[StartDirectory];
  SymbolicIntLoaded = TrueQ[Global`$MBStandardLoaded];
  ShowOutputContexts[];
  Return[SymbolicIntLoaded]];


LoadMethod[Method1_String] := Switch[Method1,
  "SymbolicSum", LoadSymbolicSum[],
  "ExpandInt" | "Subtraction", LoadSymbolicInt[],
  _, False];


(* ::Section:: *)
(*Integration and kinematic variables, leading pole*)


(* the Mellin-Barnes variables are the symbols inside Gamma and PolyGamma; the kinematic variables are the others *)
IntegrationVariables[MBInt_, Eps_] := Module[{Arguments, Symbols},
  Arguments = Cases[{MBInt}, (Gamma | PolyGamma)[___, Arg1_] :> Arg1, {0, Infinity}];
  Symbols = Cases[Arguments, S1_Symbol /; Context[S1] =!= "System`", {0, Infinity}];
  Return[DeleteCases[DeleteDuplicates[Symbols], Eps]]];


KinematicVariables[MBInt_, MBVar_, Eps_] := Module[{All1, Ints},
  If[MBVar =!= Automatic, Return[Select[Flatten[{MBVar}], Head[#] === Symbol &]]];
  All1 = DeleteDuplicates[Cases[{MBInt}, S1_Symbol /; Context[S1] =!= "System`", {0, Infinity}]];
  Ints = IntegrationVariables[MBInt, Eps];
  All1 = Complement[All1, Ints, {Eps}];
  Return[Select[All1, FreeQ[Attributes[#], Protected] &]]];


(* the lowest power of the regulator after MBresolve and MBexpand, cached per integral *)
TermPower[Term_, Reg_] := Module[{Together1, NumPower, DenPower},
  Together1 = Together[Term];
  NumPower = Exponent[Numerator[Together1], Reg, Min];
  DenPower = Exponent[Denominator[Together1], Reg, Min];
  Return[NumPower - DenPower]];


LowestPower[Integrand_, Reg_] := Module[{Terms, Powers},
  Terms = If[Head[Integrand] === Plus, List @@ Integrand, {Integrand}];
  Terms = DeleteCases[Terms, 0];
  If[Terms === {}, Return[Infinity]];
  Powers = Map[TermPower[#, Reg] &, Terms];
  Return[Min[Powers]]];


(* the residue list of MBresolve, or False when MBresolve finds no straight contour *)
ResolveIntegral[MBInt_, Eps_] := Module[{Resolved},
  Block[{$Output = {}},
    Resolved = WithoutSymbolicSumRules[Quiet[MB`MBresolve[MBInt /. Eps -> MB`ep, MB`ep]]]];
  Return[Resolved]];


ResolvedQ[Resolved_] := ListQ[Resolved] && Resolved =!= {};


(* a resonant integral (a zero-sum cycle of Gamma arguments: no straight contour at any value of the regulator) is
   resolved by the analytic continuation of the engine, which wraps MBresolve once the engine is loaded; without a
   residue list the leading pole is unknown and $Failed is returned, never Ord, which would drop the lower orders *)
LeadingPole[MBInt_, Eps_, Ord_] := Module[{Resolved, Expanded, Powers, Lo},
  LoadMBTools[];
  Resolved = ResolveIntegral[MBInt, Eps];
  If[! ResolvedQ[Resolved] && IntersectingQ[$MBAnalyticaMethods, {"ExpandInt", "Subtraction"}] && LoadSymbolicInt[],
    Resolved = ResolveIntegral[MBInt, Eps]];
  If[! ResolvedQ[Resolved], Return[$Failed]];
  Block[{$Output = {}},
    Expanded = WithoutSymbolicSumRules[Quiet[MB`MBexpand[Resolved, 1, {MB`ep, 0, Ord}]]]];
  If[! ListQ[Expanded], Return[$Failed]];
  Powers = Map[LowestPower[First[#], MB`ep] &, Expanded];
  Powers = Select[Powers, IntegerQ];
  Lo = If[Powers === {}, Ord, Min[Min[Powers], Ord]];
  LeadingPole[MBInt, Eps, Ord] = Lo;
  Return[Lo]];


(* ::Section:: *)
(*The methods*)


(* MBSymbolicSum: the coefficients from the leading pole through Eps^Ord; a coefficient it cannot close is MBFailed[...] *)
RunSymbolicSum[MBInt_, MBVar_, Eps_, Lo_, Hi_, Opts_Association] := Module[{Series1, Expanded, Orders, OneFold},
  If[! LoadSymbolicSum[], Return[FailAll[Lo, Hi, "SymbolicSum", "the method could not be loaded"]]];
  (* a one-fold integral Gamma(-z) Prod Gamma(m_i + c_i eps + z)^k_i X^z of the pFp-1 class whose contour separates the
     poles of Gamma(-z): its residue series is expanded in harmonic sums and summed with their generating functions,
     and the result is kept only if its Taylor coefficients in X agree exactly with those of the series *)
  OneFold = Quiet[TimeConstrained[MBAnalytica`OneFoldHyp`OneFoldHypExpand[MBInt, Eps, {Lo, Hi}], 900, $Failed]];
  If[AssociationQ[OneFold],
    If[TrueQ[Opts["Verbose"]], Print["  MBEvaluate: SymbolicSum: one-fold series of hypergeometric type, summed in harmonic sums"]];
    Return[OneFold]];
  Series1 = Block[{$ContextPath = SymbolicSumContextPath},
    MBAnalytica`SymbolicSum`MBCH2MPL[MBInt, MBVar, {Eps, Hi},
      Verbose -> Opts["Verbose"], BarnesReduce -> Opts["BarnesReduce"], Complex -> Opts["Complex"]]];
  (* a resummation that is not a finite expression (Indeterminate from a zero times an infinity, ComplexInfinity, a
     failure) closes no order: the next method is tried instead, and the result is never returned as it stands *)
  If[FailureQ[Series1] || ! FreeQ[Series1, Indeterminate | DirectedInfinity | $Failed | $Aborted],
    Return[FailAll[Lo, Hi, "SymbolicSum", "the resummed series is not finite"]]];
  Expanded = Expand[Series1];
  Orders = Range[Lo, Hi];
  Return[Association[Map[# -> Coefficient[Expanded, Eps, #] &, Orders]]]];


(* the time an engine step may take: no limit in practice by default (10^9 s; a limit only wastes the work done when it is
   hit); the environment variable MBANALYTICA_ENGINE_SECONDS sets one in seconds, and 0 means the default.  The budget
   stays finite: it is written into the JSON requests and the timeout(1) arguments of the native job runner, where
   Infinity breaks them *)
EngineSeconds = With[{Seconds = Environment["MBANALYTICA_ENGINE_SECONDS"]},
  If[StringQ[Seconds] && StringMatchQ[Seconds, DigitCharacter ..] && ToExpression[Seconds] > 0,
    ToExpression[Seconds], 1000000000]];


(* the regulator the engine was validated with: its benchmark drivers read \[Epsilon] after PolyLogTools is loaded,
   which exports a public \[Epsilon], so every validated run had PolyLogTools`\[Epsilon].  The symbol matters twice:
   MBresolve orders the variables by name, so the name decides the contours and the residue pieces; and parts of the
   engine take Global`\[Epsilon] as the regulator by default (the corner pre-scan's MBtoEulerMellin, rung tests of
   FreeQ[..., Global`\[Epsilon]]), which never fired in the validated runs.  With Global`\[Epsilon] the pre-scan
   reports corners for the phase-bearing MBpilot13 and the global Barnes route loses its phase (pi^2 terms wrong).
   A private symbol of the same name when the integrand uses PolyLogTools`\[Epsilon] otherwise *)
EngineRegulator[MBInt_, Eps_] := Module[{PltEps},
  PltEps = Symbol["PolyLogTools`\[Epsilon]"];
  Return[If[Eps === PltEps || FreeQ[MBInt, PltEps], PltEps, MBAnalytica`Private`\[Epsilon]]]];


(* the MBSymbolicInt engine: one call for the whole range; when a piece was ledgered, the orders are re-run one by one so
   that exactly the open orders are reported *)
EngineCall[MBInt_, Kinematics_List, Eps_, Lo_, Hi_, Route_String, Opts_Association] := Module[
  {Reg, Integrand, Options1, Result, Ledger, Exact, Census, Budget},
  Reg = EngineRegulator[MBInt, Eps];
  Integrand = MBInt /. Eps -> Reg;
  Options1 = {"EpsOrderMin" -> Lo, "EpsOrderMax" -> Hi, "Route" -> Route, "Verbose" -> TrueQ[Opts["Verbose"]],
    "PieceKernels" -> KernelCount[], "UseCertifiedLibrary" -> False, "Simplify" -> True, "DiskCache" -> True};
  (* a parameter rung may take as long as the benchmark families did (the engine's default is 300 s) *)
  If[Kinematics =!= {},
    Options1 = Join[Options1, {"ExternalParameters" -> Kinematics,
      "ParameterAssumptions" -> (And @@ Map[(0 < # < 1) &, Kinematics]), "ParameterTimeConstraint" -> EngineSeconds}]];
  (* the engine's resources follow $KernelLaunch: piece workers, residue helper processes (main kernels with the
     HPL tables, about 3.5 GB each), native integrator processes and the subkernels of the faithful-cube rung (its own
     policy launched up to one per core: 14 subkernels of 3.8 GB for Subtraction MB4, past any memory cap of a shared
     machine) with their integrator race of 3 lanes per subkernel (8 by default, about 1 GB a lane); the global Barnes route gets the time budget of the benchmark runs (the engine's default, 2400 s,
     aborts the large integrals and every order is then rerun) *)
  (* the subkernel pools of the other rungs (one-fold towers, the multifold ladder, the sealed lane, the last-fold
     workers) take the engine's policy budget less the subkernels this account already runs; that budget was the whole
     node (one subkernel per core), so a run asked for 2 kernels launched 8-10 (Subtraction MB5, MB11: 44 GB in minutes).
     The budget is $KernelLaunch on top of what runs now, in this kernel and, through MBT_SUBKERNEL_BUDGET, in the
     residue helpers it starts *)
  Census = If[DownValues[Global`mbtMySubkernelCount] =!= {}, Global`mbtMySubkernelCount[], 0];
  Budget = Max[1, KernelCount[]] + If[IntegerQ[Census], Census, 0];
  SetEnvironment["MBT_SUBKERNEL_BUDGET" -> ToString[Budget]];
  Result = Block[{$ContextPath = EngineContextPath, MBAnalytica`SymbolicInt`Private`$mbtGlobalBarnesBudget = EngineSeconds,
      Global`$oftResidueHelpers = Max[0, KernelCount[] - 1], MBParameterSubtractionHF`$PSHNativeWorkers = Max[1, KernelCount[]],
      Global`$fcuMaxWorkers = Max[1, KernelCount[]], Global`$fcuLaneBudget = 3 Max[1, KernelCount[]],
      Global`$mbtSubkernelBudget = Budget},
    WithoutSymbolicSumRules[CheckAbort[MBAnalytica`SymbolicInt`MBresolveToMPL[Integrand, Reg, Sequence @@ Options1], $Aborted]]];
  SetEnvironment["MBT_SUBKERNEL_BUDGET" -> None];
  Ledger = If[Kinematics === {} && ListQ[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces], MBAnalytica`SymbolicInt`Private`$mbtFailedPieces, {}];
  Exact = Result =!= $Failed && Result =!= $Aborted && ! FailureQ[Result] && Ledger === {} &&
    FreeQ[Result, $Failed | $Aborted | Indeterminate | ComplexInfinity | MBAnalytica`SymbolicInt`Private`mbeUnsubtractedPole] &&
    Cases[Result, N1_?NumberQ /; Precision[N1] =!= Infinity, {0, Infinity}] === {};
  Return[<|"Exact" -> Exact, "Result" -> (Result /. Reg -> Eps)|>]];


(* the engine route of a method: the ExpandInt method is the Standard route of the MBSymbolicInt engine *)
EngineRoute["ExpandInt"] = "Standard";
EngineRoute["Subtraction"] = "Subtraction";


RunEngine[MBInt_, Kinematics_List, Eps_, Lo_, Hi_, Method1_String, Opts_Association] := Module[
  {Route, Call, Expanded, Coefs, Single},
  Route = EngineRoute[Method1];
  If[! LoadSymbolicInt[], Return[FailAll[Lo, Hi, Method1, "the method could not be loaded"]]];
  Call = EngineCall[MBInt, Kinematics, Eps, Lo, Hi, Route, Opts];
  If[TrueQ[Call["Exact"]],
    Expanded = Expand[Call["Result"]];
    Return[Association[Map[# -> Coefficient[Expanded, Eps, #] &, Range[Lo, Hi]]]]];
  If[Lo === Hi, Return[FailAll[Lo, Hi, Method1, "a piece could not be closed"]]];
  Coefs = Association[Map[Function[K1,
    Single = EngineCall[MBInt, Kinematics, Eps, K1, K1, Route, Opts];
    K1 -> If[TrueQ[Single["Exact"]], Coefficient[Expand[Single["Result"]], Eps, K1],
      MBFailed[{Method1, "a piece could not be closed"}]]], Range[Lo, Hi]]];
  Return[Coefs]];


FailAll[Lo_, Hi_, Method1_, Reason_] := Association[Map[# -> MBFailed[{Method1, Reason}] &, Range[Lo, Hi]]];


RunMethod[Method1_String, MBInt_, MBVar_, Kinematics_List, Eps_, Lo_, Hi_, Opts_Association] := Switch[Method1,
  "SymbolicSum", RunSymbolicSum[MBInt, MBVar, Eps, Lo, Hi, Opts],
  "ExpandInt", RunEngine[MBInt, Kinematics, Eps, Lo, Hi, "ExpandInt", Opts],
  "Subtraction", RunEngine[MBInt, Kinematics, Eps, Lo, Hi, "Subtraction", Opts]];


(* ::Section:: *)
(*MBEvaluate*)


Options[MBEvaluate] = {Method -> Automatic, Verbose -> False, BarnesReduce -> True, Complex -> False};


MBEvaluate::method = "Method -> `1` is not Automatic, \"SymbolicSum\", \"ExpandInt\" or \"Subtraction\".";
MBEvaluate::unavailable = "The method `1` cannot run on this machine; MBAnalyticaCheck[] shows what is missing.";
MBEvaluate::none = "No method can run on this machine; MBAnalyticaCheck[] shows what is missing.";
MBEvaluate::pole = "The leading pole of the integral could not be determined (MBresolve or MBexpand failed).";
MBEvaluate::real = "A coefficient contains a function that is not real on the whole domain 0 < x < 1, so its real \
part cannot be separated symbolically; its full complex value is returned. Complex -> True returns complex values \
throughout.";
MBEvaluate::open = "The coefficient(s) of `1` could not be closed by any method and are returned as MBFailed[...].";


MBEvaluate[MBInt_, {Eps_Symbol, Ord_Integer}, Opts : OptionsPattern[]] :=
  MBEvaluate[MBInt, Automatic, {Eps, Ord}, Opts];


MBEvaluate[MBInt_, MBVar_, {Eps_Symbol, Ord_Integer}, OptionsPattern[]] := Module[
  {Method1, Settings, Methods, Kinematics, Lo, Coefficients, OpenKeys, Got, Finished, OpenOrders},
  Method1 = OptionValue[Method];
  (* "HyperLog" and "Standard", the earlier names of the ExpandInt method, and "Resum", that of SymbolicSum, are accepted as aliases *)
  If[Method1 === "HyperLog" || Method1 === "Standard", Method1 = "ExpandInt"];
  If[Method1 === "Resum", Method1 = "SymbolicSum"];
  If[! MemberQ[{Automatic, "SymbolicSum", "ExpandInt", "Subtraction"}, Method1],
    Message[MBEvaluate::method, Method1];
    Return[$Failed]];
  Settings = <|"Verbose" -> TrueQ[OptionValue[Verbose]], "BarnesReduce" -> TrueQ[OptionValue[BarnesReduce]],
    "Complex" -> TrueQ[OptionValue[Complex]]|>;
  RefreshMethods[];
  Methods = If[Method1 === Automatic, $MBAnalyticaMethods, {Method1}];
  If[Methods === {}, Message[MBEvaluate::none]; Return[$Failed]];
  If[Method1 =!= Automatic && ! MemberQ[$MBAnalyticaMethods, Method1],
    Message[MBEvaluate::unavailable, Method1];
    Return[$Failed]];
  Kinematics = KinematicVariables[MBInt, MBVar, Eps];
  Say[Settings["Verbose"], "MBEvaluate: methods ", Methods, ", kinematic variables ",
    If[Kinematics === {}, "none", Kinematics]];
  Lo = WithoutUserValues[LeadingPole[MBInt, Eps, Ord]];
  If[! IntegerQ[Lo], Message[MBEvaluate::pole]; Return[$Failed]];
  Say[Settings["Verbose"], "MBEvaluate: orders ", Eps, "^", Lo, " through ", Eps, "^", Ord];
  Coefficients = Association[Map[# -> MBFailed[{"not attempted"}] &, Range[Lo, Ord]]];
  Do[
    OpenKeys = Select[Keys[Coefficients], Head[Coefficients[#]] === MBFailed &];
    If[OpenKeys === {}, Break[]];
    Say[Settings["Verbose"], "MBEvaluate: ", M1, " on ", Eps, "^", Min[OpenKeys], " .. ", Eps, "^", Max[OpenKeys]];
    Got = WithoutUserValues[RunMethod[M1, MBInt, MBVar, Kinematics, Eps, Min[OpenKeys], Max[OpenKeys], Settings]];
    Got = WithoutUserValues[Association[KeyValueMap[#1 -> CheckOutputClass[#2, M1, Kinematics] &, Got]]];
    Scan[Function[K1, If[KeyExistsQ[Got, K1] && Head[Got[K1]] =!= MBFailed, Coefficients[K1] = Got[K1]]], OpenKeys];
    Scan[Function[K1, If[KeyExistsQ[Got, K1] && Head[Got[K1]] === MBFailed, Coefficients[K1] = Got[K1]]],
      Select[OpenKeys, Head[Coefficients[#]] === MBFailed &]],
    {M1, Methods}];
  OpenOrders = Select[Keys[Coefficients], Head[Coefficients[#]] === MBFailed &];
  If[OpenOrders =!= {}, Message[MBEvaluate::open, Map[Eps^# &, OpenOrders]]];
  Finished = WithoutUserValues[Association[KeyValueMap[#1 -> FinishCoefficient[#2, Kinematics, Settings["Complex"]] &, Coefficients]]];
  ShowOutputContexts[];
  Return[AssembleSeries[Finished, Eps]]];
