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
(* $KernelLaunch = 0 is no serial mode: the summation stack starts kernels of its own when none run (MBConicHulls two
   per core, 48 on a 24-core machine, review of e4f55bd), so zero or a negative number is refused with a message and one
   subkernel is used *)
KernelCount[] := Module[{Asked, FreeGB, ByMemory},
  Asked = Global`$KernelLaunch;
  If[IntegerQ[Asked] && Asked >= 1, Return[Asked]];
  If[IntegerQ[Asked],
    If[! TrueQ[KernelCountWarned], Message[MBEvaluate::kernels, Asked]; KernelCountWarned = True];
    Return[1]];
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


(* a hash of every rule of a System symbol *)
RuleListsHash[Name_String] := Quiet[ToExpression["System`" <> Name, InputForm,
  Function[Sym, Hash[{DownValues[Sym], UpValues[Sym], SubValues[Sym], NValues[Sym]}], HoldAll]]];


(* the rules of these packages in System symbols, by name of the symbol; none while no package of theirs is loaded.  The
   scan of the 7700 System symbols took 0.45 s, three times per call of MBEvaluate; it is kept under a hash of all their
   rules, which takes 0.05 s, so that a rule added, changed or removed since gives a new scan (review of a6af3be).  A few
   states are kept, since a call inside WithoutSymbolicSumRules sees the rules set aside *)
SymbolicSumRulesCache = <||>;
SymbolicSumRules[] := Module[{Loaded, Names1, Key1, Rules1},
  Loaded = Select[$Packages, StringStartsQ[#, SymbolicSumContexts] &];
  If[Loaded === {}, Return[<||>]];
  Names1 = Select[Names["System`*"], ! StringStartsQ[#, "$"] &];
  Key1 = Hash[{Loaded, Names1, Map[RuleListsHash, Names1]}];
  If[KeyExistsQ[SymbolicSumRulesCache, Key1], Return[SymbolicSumRulesCache[Key1]]];
  Rules1 = Association[Map[# -> NameSymbolicSumRules[#] &, Names1]];
  Rules1 = Select[Rules1, Total[Map[Length, #]] > 0 &];
  If[Length[SymbolicSumRulesCache] >= 8, SymbolicSumRulesCache = <||>];
  SymbolicSumRulesCache[Key1] = Rules1;
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
  (* MBSymbolicSum reads the option symbols of MBAnalytica` and marks a coefficient that it cannot evaluate with
     MBAnalytica`Private`NotEvaluated; its own context stays off the user's path *)
  (* as in a fresh kernel after MB.m, MBresolve.m and barnesroutines.m, with MBAnalytica` first so that MBSymbolicSum's
     option symbols are those of MBEvaluate *)
  Block[{$ContextPath = Join[{"MBAnalytica`", "BarnesRoutines`", "MB`"}, FreshContextPath], $Output = {}},
    Get[SymbolicSumFile];
    SymbolicSumContextPath = $ContextPath];
  LoadOneFoldHyp[];
  SymbolicSumLoaded = DownValues[MBAnalytica`SymbolicSum`MBCH2MPL] =!= {};
  Return[SymbolicSumLoaded]];


(* the one-fold series of hypergeometric type, summed directly (OneFoldHyp.wl), which needs none of the summation
   packages: it is tried before HarmonicSums, Sigma and EvaluateMultiSums are loaded.  Its context stays off the user's
   path *)
LoadOneFoldHyp[] := Module[{},
  If[TrueQ[OneFoldHypLoaded], Return[True]];
  Block[{$ContextPath = $ContextPath},
    Get[FileNameJoin[{PackageRoot, "src", "SymbolicSum", "OneFoldHyp.wl"}]]];
  OneFoldHypLoaded = DownValues[MBAnalytica`OneFoldHyp`OneFoldHypExpand] =!= {};
  Return[OneFoldHypLoaded]];


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
  (* the notices of the engine's files ("sidecar installed", "loaded") write to stdout directly, past $Output: the flag
     Global`$mbtQuietStdout silences them (review of e4f55bd: an ExpandInt call printed a page of them) *)
  Block[{$Output = {}, $ContextPath = FreshContextPath, Global`$mbtQuietStdout = True},
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
(*The domain of the kinematic variables*)


(* the bases of an integral: every power of an expression of the kinematic variables whose exponent is not an integer.
   A positive numeric factor with the same exponent belongs to the base when one kinematic base has that exponent, as
   Mathematica writes (2 x)^z as 2^z x^z *)
KinematicBases[MBInt_, Kinematics_List] := Module[{VarPattern, Powers, Kin, Num, Bases},
  If[Kinematics === {}, Return[{}]];
  VarPattern = Alternatives @@ Kinematics;
  Powers = DeleteDuplicates[Cases[{MBInt}, Power[B_, E1_] /; ! IntegerQ[E1] :> {B, E1}, {0, Infinity}]];
  Kin = Select[Powers, ! FreeQ[#[[1]], VarPattern] &];
  Num = Select[Powers, NumericQ[#[[1]]] && TrueQ[Positive[#[[1]]]] &];
  Bases = Map[Function[P1, Module[{Same, Coef},
      Same = Select[Kin, #[[2]] === P1[[2]] &];
      Coef = Times @@ Map[First, Select[Num, #[[2]] === P1[[2]] &]];
      If[Length[Same] === 1, Coef*P1[[1]], P1[[1]]]]], Kin];
  Return[DeleteDuplicates[Bases]]];


(* the domain on which the methods solve an integral when no domain is given: where every base lies in (0, 1), else
   where every base is positive, and the unit interval for a variable in no base, whose rational factors need no
   branch.  The closed form holds for any values of the variables by analytic continuation, with the principal value
   of every power; False when no real values make every base positive *)
BasesDomain[MBInt_, Kinematics_List] := Module[{Bases, InBases, Free1, Rest1, Unit, Positive1},
  If[Kinematics === {}, Return[True]];
  Bases = KinematicBases[MBInt, Kinematics];
  InBases = Select[Kinematics, ! FreeQ[Bases, #] &];
  Free1 = Complement[Kinematics, InBases];
  Rest1 = And @@ Map[(0 < # < 1) &, Free1];
  If[Bases === {}, Return[Rest1]];
  (* a base with a complex number is positive for no real values of the variables *)
  If[! FreeQ[Bases, Complex], Return[False]];
  Unit = And @@ Map[(0 < # < 1) &, Bases];
  Unit = ReduceOrKeep[Unit, InBases];
  If[Unit =!= False, Return[Unit && Rest1]];
  Positive1 = And @@ Map[(# > 0) &, Bases];
  Positive1 = ReduceOrKeep[Positive1, InBases];
  If[Positive1 === False, Return[False]];
  Return[Positive1 && Rest1]];


(* Reduce over the reals within twenty seconds, or the condition itself when Reduce does not finish or returns unevaluated *)
ReduceOrKeep[Cond_, Vars_List] := Module[{Res},
  Res = Quiet[TimeConstrained[Reduce[Cond, Vars, Reals], 20, Cond]];
  If[! FreeQ[Res, Reduce], Return[Cond]];
  Return[Res]];


(* {a, b} for a projection a < V < b with finite rational ends, else $Failed *)
IntervalEnds[Proj_, V_] := Module[{Ends},
  Ends = Replace[Proj, {Inequality[A_, Less, V, Less, B_] :> {A, B}, Less[A_, V, B_] :> {A, B}, _ :> $Failed}];
  If[Ends === $Failed, Return[$Failed]];
  If[! VectorQ[Ends, MatchQ[#, _Integer | _Rational] &] || Ends[[1]] >= Ends[[2]], Return[$Failed]];
  Return[Ends]];


(* the affine maps V -> a + (b - a) V that take the projection a < V < b of the derivation domain on each variable to
   the unit interval, when a and b are finite rationals: the methods were built and validated with kinematic variables
   in (0, 1).  A variable keeps its name, since the summation packages order the variables by name (renaming the
   kinematic variables broke EvaluateMultiSums on Appell F1, audit of 2026-11-09), so Forward and Back are rules on the
   same symbols, applied once each; nothing changes for a projection (0, 1).  The derivation domain in the mapped
   variables comes third *)
UnitMaps[Domain1_, Kinematics_List] := Module[{Forward, Back, Mapped},
  Forward = {};
  Back = {};
  Do[Module[{Others, Proj, Ends},
      Others = DeleteCases[Kinematics, V];
      Proj = If[Others === {}, Domain1,
        Quiet[TimeConstrained[Reduce[Exists[Evaluate[Others], Domain1], V, Reals], 20, $Failed]]];
      Ends = IntervalEnds[Proj, V];
      If[Ends =!= $Failed && Ends =!= {0, 1},
        AppendTo[Forward, V -> Ends[[1]] + (Ends[[2]] - Ends[[1]]) V];
        AppendTo[Back, V -> (V - Ends[[1]])/(Ends[[2]] - Ends[[1]])]]],
    {V, Kinematics}];
  If[Forward === {}, Return[{Forward, Back, Domain1}]];
  Mapped = ReduceOrKeep[Domain1 /. Forward, Kinematics];
  Return[{Forward, Back, Mapped}]];


(* the domain given with ParameterAssumptions as one condition on the kinematic variables.  As for Assumptions, it is a
   condition, a list of conditions (lists in lists too) or a logical combination of them.  Only what it implies for the
   kinematic variables of the integral counts: a condition on other symbols, such as a variable of another integral or
   the regulator, restricts nothing (Exists over them), so that one list serves integrals in different variables.
   When that elimination does not finish, the conditions free of the other symbols are kept.  $Failed when no real
   values satisfy it, or when it is no condition (Reduce returns it unevaluated) *)
GivenDomain[Given_, Kinematics_List] := Module[{User, Others, Conjuncts, Res},
  User = If[ListQ[Given], And @@ Flatten[Given], Given];
  If[User === True, Return[True]];
  Others = Complement[Cases[{User}, S1_Symbol /; Context[S1] =!= "System`", {0, Infinity}], Kinematics];
  (* With: Exists holds its arguments *)
  Res = If[Others === {},
    Quiet[TimeConstrained[Reduce[User, Kinematics, Reals], 20, User]],
    With[{Cond = User, Bound = Others},
      Quiet[TimeConstrained[Reduce[Exists[Bound, Cond], Kinematics, Reals], 20, $Failed]]]];
  If[Res === $Failed,
    Conjuncts = If[Head[User] === And, List @@ User, {User}];
    Res = And @@ Select[Conjuncts, FreeQ[#, Alternatives @@ Others] &];
    Res = Quiet[TimeConstrained[Reduce[Res, Kinematics, Reals], 20, Res]]];
  If[Res === False || ! FreeQ[Res, Reduce | Exists], Return[$Failed]];
  Return[Res]];


(* the domains of a call: Derivation, on which the methods solve the integral (the one given with ParameterAssumptions,
   else where every base lies in (0, 1)), Real, on which Complex -> False takes the real part (the one given, else every
   real value), the maps Forward and Back of UnitMaps and Mapped, the derivation domain in the mapped variables.  A
   domain that is no restriction, such as Element[x, Reals], counts as none.  $Failed, with a message, for a given
   domain that is not a satisfiable condition on the kinematic variables, and when no real values make every base
   positive *)
KinematicDomains[MBInt_, Kinematics_List, Given_] := Module[{User, Unmentioned, Derive, Real1, Maps},
  If[Kinematics === {},
    Return[<|"Derivation" -> True, "Real" -> True, "Forward" -> {}, "Back" -> {}, "Mapped" -> True|>]];
  User = GivenDomain[Given, Kinematics];
  If[User === $Failed,
    Message[MBEvaluate::assum, Given /. MBEvaluateBackRules, Kinematics /. MBEvaluateBackRules];
    Return[$Failed]];
  (* a variable that the given domain does not restrict is treated as without one: the bases in it lie in (0, 1) *)
  If[User =!= True,
    Unmentioned = Select[Kinematics, FreeQ[User, #] &];
    Derive = If[Unmentioned === {}, User, User && BasesDomain[MBInt, Unmentioned]];
    Real1 = User,
    Derive = BasesDomain[MBInt, Kinematics];
    Real1 = True];
  If[Derive =!= False && Derive =!= True, Derive = ReduceOrKeep[Derive, Kinematics]];
  If[Derive === False,
    Message[MBEvaluate::bases, KinematicBases[MBInt, Kinematics] /. MBEvaluateBackRules];
    Return[$Failed]];
  Maps = UnitMaps[Derive, Kinematics];
  Return[<|"Derivation" -> Derive, "Real" -> Real1, "Forward" -> Maps[[1]], "Back" -> Maps[[2]], "Mapped" -> Maps[[3]]|>]];


(* ::Section:: *)
(*The methods*)


(* MBSymbolicSum: the coefficients from the leading pole through Eps^Ord; a coefficient it cannot evaluate is NotEvaluated[...] *)
RunSymbolicSum[MBInt_, MBVar_, Eps_, Lo_, Hi_, Opts_Association] := Module[{Series1, Expanded, Orders, OneFold},
  (* a one-fold integral Gamma(-z) Prod Gamma(m_i + c_i eps + z)^k_i X^z of the pFp-1 class whose contour separates the
     poles of Gamma(-z): its residue series is expanded in harmonic sums and summed with their generating functions,
     and the result is kept only if its Taylor coefficients in X agree exactly with those of the series.  It comes
     before the summation packages are loaded, which it does not need (review of e4f55bd) *)
  If[LoadOneFoldHyp[],
    OneFold = Block[{MBAnalytica`OneFoldHyp`OneFoldHypDomain = Opts["Domain"]},
      Quiet[TimeConstrained[MBAnalytica`OneFoldHyp`OneFoldHypExpand[MBInt, Eps, {Lo, Hi}], 900, $Failed]]];
    If[AssociationQ[OneFold],
      If[TrueQ[Opts["Verbose"]], Print["  MBEvaluate: SymbolicSum: one-fold series of hypergeometric type, summed in harmonic sums"]];
      Return[OneFold]]];
  If[! LoadSymbolicSum[], Return[FailAll[Lo, Hi, "SymbolicSum", "the method could not be loaded"]]];
  Series1 = Block[{$ContextPath = SymbolicSumContextPath},
    MBAnalytica`SymbolicSum`MBCH2MPL[MBInt, MBVar, {Eps, Hi},
      Verbose -> Opts["Verbose"], BarnesReduce -> Opts["BarnesReduce"], Complex -> Opts["MethodComplex"],
      "ParameterAssumptions" -> Opts["Domain"]]];
  (* a resummation that is not a finite expression (Indeterminate from a zero times an infinity, ComplexInfinity, a
     failure) closes no order: the next method is tried instead, and the result is never returned as it stands *)
  If[FailureQ[Series1] || ! FreeQ[Series1, Indeterminate | DirectedInfinity | $Failed | $Aborted],
    Return[FailAll[Lo, Hi, "SymbolicSum", "the resummed series is not finite"]]];
  Expanded = Expand[Series1];
  Orders = Range[Lo, Hi];
  Return[Association[Map[# -> LaurentCoefficient[Expanded, Eps, #, "SymbolicSum"] &, Orders]]]];


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
      "ParameterAssumptions" -> Opts["Domain"], "ParameterTimeConstraint" -> EngineSeconds}]];
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
  (* with Verbose -> False the engine runs as quietly as the other methods: its notices to stdout (Global`$mbtQuietStdout:
     [PieceKernels], [L6], ...) and the progress that MBresolve writes to $Output (CREATING RESIDUES LIST ...) are not
     shown; the result, the open orders and the messages of MBEvaluate are the same *)
  Result = Block[{$ContextPath = EngineContextPath, MBAnalytica`SymbolicInt`Private`$mbtGlobalBarnesBudget = EngineSeconds,
      $Output = If[TrueQ[Opts["Verbose"]], $Output, {}], Global`$mbtQuietStdout = ! TrueQ[Opts["Verbose"]],
      Global`$oftResidueHelpers = Max[0, KernelCount[] - 1], MBParameterSubtractionHF`$PSHNativeWorkers = Max[1, KernelCount[]],
      Global`$fcuMaxWorkers = Max[1, KernelCount[]], Global`$fcuLaneBudget = 3 Max[1, KernelCount[]],
      Global`$mbtSubkernelBudget = Budget},
    If[TrueQ[Opts["Verbose"]],
      WithoutSymbolicSumRules[CheckAbort[MBAnalytica`SymbolicInt`MBresolveToMPL[Integrand, Reg, Sequence @@ Options1], $Aborted]],
      (* the engine's own diagnostics (a piece not closed, a numeric piece, an unsubtracted pole, ...) are what the checks
         below turn into the open orders of MBEvaluate::open, which names them once *)
      Quiet[WithoutSymbolicSumRules[CheckAbort[MBAnalytica`SymbolicInt`MBresolveToMPL[Integrand, Reg, Sequence @@ Options1], $Aborted]],
        {MBAnalytica`SymbolicInt`MBresolveToMPL::ofcfail, MBAnalytica`SymbolicInt`MBresolveToMPL::rpfail,
         MBAnalytica`SymbolicInt`MBresolveToMPL::inexact, MBAnalytica`SymbolicInt`MBresolveToMPL::incomplete,
         MBAnalytica`SymbolicInt`MBresolveToMPL::unsubtracted, MBAnalytica`SymbolicInt`MBresolveToMPL::nnccorner,
         MBAnalytica`SymbolicInt`MBresolveToMPL::resolvefail, MBAnalytica`SymbolicInt`MBresolveToMPL::resonant}]]];
  SetEnvironment["MBT_SUBKERNEL_BUDGET" -> None];
  Ledger = If[Kinematics === {} && ListQ[MBAnalytica`SymbolicInt`Private`$mbtFailedPieces], MBAnalytica`SymbolicInt`Private`$mbtFailedPieces, {}];
  Exact = Result =!= $Failed && Result =!= $Aborted && ! FailureQ[Result] && Ledger === {} &&
    FreeQ[Result, $Failed | $Aborted | Indeterminate | ComplexInfinity | MBAnalytica`SymbolicInt`Private`mbeUnsubtractedPole] &&
    FreeQ[Result, SeriesData | Series | SeriesCoefficient] &&
    Cases[Result, N1_?NumberQ /; Precision[N1] =!= Infinity, {0, Infinity}] === {};
  Return[<|"Exact" -> Exact, "Result" -> (Result /. Reg -> Eps)|>]];


(* the engine route of a method: the ExpandInt method is the Standard route of the MBSymbolicInt engine *)
EngineRoute["ExpandInt"] = "Standard";
EngineRoute["Subtraction"] = "Subtraction";


(* the coefficient of Eps^K1 of an expanded Laurent polynomial in Eps, or NotEvaluated when it still depends on Eps: an
   expression such as Gamma[Eps] or a nested SeriesData left in the result is not a Laurent coefficient *)
(* True when every term of the expanded expression is a factor free of Eps times an integer power of Eps.  The check
   comes before Coefficient, which drops what is not a power of Eps: Gamma[ep] has the "coefficient" 0 of ep^1, and
   1/ep + Gamma[ep] the coefficient 1 of 1/ep (review of a6af3be) *)
LaurentPolynomialQ[Expanded_, Eps_] := Module[{Terms},
  Terms = If[Head[Expanded] === Plus, List @@ Expanded, {Expanded}];
  Return[AllTrue[Terms, Function[T1, Module[{K1 = Quiet[Exponent[T1, Eps]]},
    T1 === 0 || (IntegerQ[K1] && FreeQ[T1 Eps^(-K1), Eps])]]]]];


LaurentCoefficient[Expanded_, Eps_, K1_, Method1_] := Module[{Coef},
  If[! LaurentPolynomialQ[Expanded, Eps],
    Return[NotEvaluated[{Method1, "the result is not a Laurent polynomial in the regulator"}]]];
  Coef = Coefficient[Expanded, Eps, K1];
  If[! FreeQ[Coef, Eps], Return[NotEvaluated[{Method1, "the coefficient still depends on the regulator"}]]];
  Return[Coef]];

(* a result returned with the convergence region of its series: Coefficient takes a ConditionalExpression as a single
   term, so that the coefficient of 1/Eps came out as 0 and the whole expression as the coefficient of Eps^0 (the
   one-mass angular integral with SymbolicSum).  The coefficients of its value are taken, each with the condition *)
LaurentCoefficient[Expanded_ConditionalExpression, Eps_, K1_, Method1_] := Module[{Coef, Condition1},
  Condition1 = Last[Expanded];
  If[! FreeQ[Condition1, Eps], Return[NotEvaluated[{Method1, "the condition of the result depends on the regulator"}]]];
  Coef = LaurentCoefficient[Expand[First[Expanded]], Eps, K1, Method1];
  If[Head[Coef] === NotEvaluated, Return[Coef]];
  Return[ConditionalExpression[Coef, Condition1]]];


RunEngine[MBInt_, Kinematics_List, Eps_, Lo_, Hi_, Method1_String, Opts_Association] := Module[
  {Route, Call, Expanded, Coefs, Single},
  Route = EngineRoute[Method1];
  If[! LoadSymbolicInt[], Return[FailAll[Lo, Hi, Method1, "the method could not be loaded"]]];
  Call = EngineCall[MBInt, Kinematics, Eps, Lo, Hi, Route, Opts];
  If[TrueQ[Call["Exact"]],
    Expanded = Expand[Call["Result"]];
    Return[Association[Map[# -> LaurentCoefficient[Expanded, Eps, #, Method1] &, Range[Lo, Hi]]]]];
  If[Lo === Hi, Return[FailAll[Lo, Hi, Method1, "a term could not be evaluated"]]];
  Coefs = Association[Map[Function[K1,
    Single = EngineCall[MBInt, Kinematics, Eps, K1, K1, Route, Opts];
    K1 -> If[TrueQ[Single["Exact"]], LaurentCoefficient[Expand[Single["Result"]], Eps, K1, Method1],
      NotEvaluated[{Method1, "a term could not be evaluated"}]]], Range[Lo, Hi]]];
  Return[Coefs]];


FailAll[Lo_, Hi_, Method1_, Reason_] := Association[Map[# -> NotEvaluated[{Method1, Reason}] &, Range[Lo, Hi]]];


(* the orders that no method evaluated, each with the reason of the last method tried, for the message of MBEvaluate *)
OpenReasons[Coefficients_Association, OpenOrders_List, Eps_] := StringRiffle[
  Map[ToString[Eps^#] <> " " <> ToString[First[Coefficients[#]]] &, OpenOrders], ", "];


RunMethod[Method1_String, MBInt_, MBVar_, Kinematics_List, Eps_, Lo_, Hi_, Opts_Association] := Switch[Method1,
  "SymbolicSum", RunSymbolicSum[MBInt, MBVar, Eps, Lo, Hi, Opts],
  "ExpandInt", RunEngine[MBInt, Kinematics, Eps, Lo, Hi, "ExpandInt", Opts],
  "Subtraction", RunEngine[MBInt, Kinematics, Eps, Lo, Hi, "Subtraction", Opts]];


(* ::Section:: *)
(*MBEvaluate*)


Options[MBEvaluate] = {Method -> Automatic, Verbose -> False, BarnesReduce -> True, Complex -> False,
  ParameterAssumptions -> True};


MBEvaluate::method = "Method -> `1` is not Automatic, \"SymbolicSum\", \"ExpandInt\" or \"Subtraction\".";
MBEvaluate::unavailable = "The method `1` cannot run on this machine; MBAnalyticaCheck[] shows what is missing.";
MBEvaluate::none = "No method can run on this machine; MBAnalyticaCheck[] shows what is missing.";
MBEvaluate::pole = "The leading pole of the integral could not be determined (MBresolve or MBexpand failed).";
MBEvaluate::real = "The real part of a coefficient could not be separated symbolically and checked at two points of the \
domain of the kinematic variables, so its full complex value is returned. Complex -> True returns complex values \
throughout.";
MBEvaluate::assum = "ParameterAssumptions -> `1` is not a satisfiable condition on the kinematic variables `2` of the \
integral.";
MBEvaluate::bases = "No real values of the kinematic variables make every base `1` of the integral positive; \
ParameterAssumptions -> cond gives the region in which to evaluate it.";
MBEvaluate::open = "No method evaluated the coefficient(s) of `1`, which are omitted from the result (`2`).";
MBEvaluate::kernels = "$KernelLaunch = `1` is not a positive number of subkernels; one subkernel is used.";


MBEvaluate[MBInt_, {Eps_Symbol, Ord_Integer}, Opts : OptionsPattern[]] :=
  MBEvaluate[MBInt, Automatic, {Eps, Ord}, Opts];


(* a kinematic variable or parameter whose name the dependencies read as one of their own constants or functions is
   replaced by a private symbol before any method sees the integral, and restored in the result.  The dependencies name
   their constants z2, z3, ln2, Log2, li4half or et1 and their functions S, H and G, and several steps of the methods
   convert symbols by their names: a parameter called z2 came back as Zeta[2] (audit of 2026-11-09).  The private names
   match none of these names.  Only such symbols are replaced: the integration variables, the symbols in the arguments
   of the Gamma and polygamma functions, never reach the result, and replacing every symbol changed the order of the
   kinematic variables against the internal symbols of the summation, after which EvaluateMultiSums summed none of the
   series of F1(eps, eps, eps; 1 + eps; x, y) *)
(* the methods name some of their own variables in Global` as well: the summation method its integration variables
   MBSymbolicSumIntVar1, ... and the phase MBSymbolicSumPhase of a negative base, the engine its Euler variables fcv1, ...
   and parameters psParameter1, ...; a parameter called MBSymbolicSumIntVar1 became the integration variable and the
   result -1/6 instead of MBSymbolicSumIntVar1/2 (review of e4f55bd) *)
DependencyNameQ[S1_Symbol] := Module[{Name},
  Name = SymbolName[S1];
  Return[StringMatchQ[Name, RegularExpression["(z|ln|Log|li|et)[0-9].*"]] || MemberQ[{"S", "H", "G"}, Name] ||
    StringMatchQ[Name, RegularExpression["(MBSymbolicSumIntVar|MBSymbolicSumPhase|fcv|fcd|fcuL|psParameter|MBtmpVar|MBTreg)[0-9]*"]]]];


(* a prefix of the private names that no symbol of the session, in any context, starts with, so that a private name is
   neither a symbol of the input nor a symbol with a value: the fixed names Global`mbaUserSymbol0001, ... merged z2 with
   an input symbol of that name, and a value given to that name entered the result (review of a6af3be).  The private
   symbols are kept and used again: removing them after every call left the memoized values of LeadingPole under
   Removed["mbaUserSymbol0001"], one more per call (review of e4f55bd), so a name is taken only when a symbol of that
   name exists that this package did not create, has a value, or occurs in the integral.  The numbers keep the canonical
   order of the original symbols *)
PrivateSymbolNames = {};
(* the symbol is read held: OwnValues and its relatives hold their argument, so that a local variable holding the symbol
   was inspected instead of the symbol, and a symbol with a value would have been evaluated *)
PrivateNameFreeQ[Name_String, Input_] := Module[{Held},
  If[! MemberQ[PrivateSymbolNames, Name], Return[Names["Global`" <> Name] === {}]];
  Held = ToExpression["Global`" <> Name, InputForm, HoldComplete];
  Return[Replace[Held, HoldComplete[S1_] :> (FreeQ[Input, HoldPattern[S1]] && OwnValues[S1] === {} && DownValues[S1] === {} &&
    UpValues[S1] === {} && SubValues[S1] === {} && Attributes[S1] === {})]]];
(* Names gives a symbol of a context on $ContextPath without its context *)
FullSymbolName[Name_String] := If[StringContainsQ[Name, "`"], Name, Context[Name] <> Name];
FreshPrefix[Input_, Count_Integer] := Module[{Prefix, Free},
  Prefix = "mbaUserSymbol";
  Free[P_] := AllTrue[Map[FullSymbolName, Names["*`" <> P <> "*"]],
      (StringStartsQ[#, "Global`"] && MemberQ[PrivateSymbolNames, StringDrop[#, 7]]) &] &&
    AllTrue[Range[Count], PrivateNameFreeQ[P <> IntegerString[#, 10, 4], Input] &];
  While[! Free[Prefix], Prefix = Prefix <> "x"];
  Return[Prefix]];


UserSymbolRules[MBInt_, MBVar_, Eps_] := Module[{Symbols, Integration, Prefix, Names1},
  Symbols = Cases[{MBInt, If[MBVar === Automatic, {}, MBVar]}, S1_Symbol /; Context[S1] =!= "System`" && S1 =!= Eps,
    {0, Infinity}];
  Integration = Cases[Cases[MBInt, (Gamma | PolyGamma)[A__] :> {A}, {0, Infinity}], S1_Symbol, {0, Infinity}];
  Symbols = Select[Sort[DeleteDuplicates[Symbols]], DependencyNameQ[#] && ! MemberQ[Integration, #] &];
  If[Symbols === {}, Return[{}]];
  Prefix = FreshPrefix[{MBInt, MBVar}, Length[Symbols]];
  Names1 = Table[Prefix <> IntegerString[K1, 10, 4], {K1, Length[Symbols]}];
  PrivateSymbolNames = DeleteDuplicates[Join[PrivateSymbolNames, Names1]];
  Return[MapThread[#1 -> Symbol["Global`" <> #2] &, {Symbols, Names1}]]];


(* the options are resolved here, against Options[MBEvaluate], and passed on explicitly: only the options of the call
   were passed before, and MBEvaluatePrivate then used its own defaults, so that SetOptions[MBEvaluate, Complex -> True]
   had no effect (review of e4f55bd) *)
MBEvaluate[MBInt_, MBVar_, {Eps_Symbol, Ord_Integer}, Opts : OptionsPattern[]] := Module[{Rules1, Back, Result, Resolved},
  Rules1 = UserSymbolRules[MBInt, MBVar, Eps];
  Resolved = {Method -> OptionValue[Method], Verbose -> OptionValue[Verbose], BarnesReduce -> OptionValue[BarnesReduce],
    Complex -> OptionValue[Complex], ParameterAssumptions -> (OptionValue[ParameterAssumptions] /. Rules1)};
  Back = Map[Reverse, Rules1];
  Result = Block[{MBEvaluateBackRules = Back},
    MBEvaluatePrivate[MBInt /. Rules1, If[MBVar === Automatic, Automatic, MBVar /. Rules1], {Eps, Ord}, Sequence @@ Resolved]];
  Result = Result /. Back;
  Return[Result]];


(* the rules back to the user's symbols, for the messages and the progress lines of the call *)
MBEvaluateBackRules = {};


Options[MBEvaluatePrivate] = {Method -> Automatic, Verbose -> False, BarnesReduce -> True, Complex -> False,
  ParameterAssumptions -> True};


MBEvaluatePrivate[MBInt_, MBVar_, {Eps_Symbol, Ord_Integer}, OptionsPattern[]] := Module[
  {Method1, Settings, Methods, Kinematics, Lo, Coefficients, OpenKeys, Got, Finished, OpenOrders, Evaluated, Domains,
   MethodInt},
  Method1 = OptionValue[Method];
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
    If[Kinematics === {}, "none", Kinematics /. MBEvaluateBackRules]];
  Domains = KinematicDomains[MBInt, Kinematics, OptionValue[ParameterAssumptions]];
  If[Domains === $Failed, Return[$Failed]];
  If[Kinematics =!= {},
    Say[Settings["Verbose"], "MBEvaluate: solved on ", Domains["Derivation"] /. MBEvaluateBackRules,
      If[Domains["Real"] === True, ", real part for every real value", ", real part on that domain"]]];
  MethodInt = MBInt /. Domains["Forward"];
  Settings["Domain"] = Domains["Mapped"];
  (* without a domain given, the real part is taken for every real value, not on the domain the method solved on: the
     method returns the full value *)
  Settings["MethodComplex"] = Settings["Complex"] || (Kinematics =!= {} && Domains["Real"] =!= Domains["Derivation"]);
  Lo = WithoutUserValues[LeadingPole[MBInt, Eps, Ord]];
  If[! IntegerQ[Lo], Message[MBEvaluate::pole]; Return[$Failed]];
  Say[Settings["Verbose"], "MBEvaluate: orders ", Eps, "^", Lo, " through ", Eps, "^", Ord];
  Coefficients = Association[Map[# -> NotEvaluated[{"not attempted"}] &, Range[Lo, Ord]]];
  Do[
    OpenKeys = Select[Keys[Coefficients], Head[Coefficients[#]] === NotEvaluated &];
    If[OpenKeys === {}, Break[]];
    Say[Settings["Verbose"], "MBEvaluate: ", M1, " on ", Eps, "^", Min[OpenKeys], " .. ", Eps, "^", Max[OpenKeys]];
    Got = WithoutUserValues[RunMethod[M1, MethodInt, MBVar, Kinematics, Eps, Min[OpenKeys], Max[OpenKeys], Settings]];
    Got = Block[{DerivationDomain = Domains["Mapped"]},
      WithoutUserValues[Association[KeyValueMap[#1 -> CheckOutputClass[#2, M1, Kinematics, Eps] &, Got]]]];
    Scan[Function[K1, If[KeyExistsQ[Got, K1] && Head[Got[K1]] =!= NotEvaluated, Coefficients[K1] = Got[K1]]], OpenKeys];
    Scan[Function[K1, If[KeyExistsQ[Got, K1] && Head[Got[K1]] === NotEvaluated, Coefficients[K1] = Got[K1]]],
      Select[OpenKeys, Head[Coefficients[#]] === NotEvaluated &]],
    {M1, Methods}];
  OpenOrders = Select[Keys[Coefficients], Head[Coefficients[#]] === NotEvaluated &];
  If[OpenOrders =!= {}, Message[MBEvaluate::open, Map[Eps^# &, OpenOrders], OpenReasons[Coefficients, OpenOrders, Eps] /. MBEvaluateBackRules]];
  (* a coefficient that no method evaluated is omitted from the result, as the message says; when no order was
     evaluated, the result is $Failed *)
  Evaluated = KeySelect[Coefficients, ! MemberQ[OpenOrders, #] &];
  If[Evaluated === <||>, Return[$Failed]];
  Finished = Block[{DerivationDomain = Domains["Mapped"], RealPartDomain = Domains["Real"]},
    WithoutUserValues[Association[KeyValueMap[
      #1 -> FinishCoefficient[#2, Kinematics, Settings["Complex"], Domains["Back"]] &, Evaluated]]]];
  ShowOutputContexts[];
  Return[AssembleSeries[Finished, Eps]]];
