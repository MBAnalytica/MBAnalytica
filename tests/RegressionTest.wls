#!/usr/bin/env wolframscript
(* ::Package:: *)
(* MBAnalytica regression tests for the defects found in the audit of 2026-11-09 (make regression).  Every test asserts
   an exact mathematical result or a controlled refusal; numbers only ever enter as an additional check.  The package of
   this folder is loaded, with an empty cache folder of its own.  One line PASS or FAIL per test, and the exit code is
   0 only when every test ran and passed. *)

SetOptions[$Output, PageWidth -> Infinity];
$HistoryLength = 0;
TestRoot = ParentDirectory[DirectoryName[ExpandFileName[First[Select[Join[$ScriptCommandLine, {$InputFileName}],
  StringQ[#] && StringEndsQ[#, "RegressionTest.wls"] &]]]]];
Global`$KernelLaunch = 2;
Global`$MBAnalyticaCacheDirectory = CreateDirectory[];
Get[FileNameJoin[{TestRoot, "MBAnalytica.wl"}]];
Print["MBAnalytica ", $MBAnalyticaVersion, " from ", $MBAnalyticaDirectory, ", methods ", $MBAnalyticaMethods];

TestResults = {};
SetAttributes[Check1, HoldRest];
Check1[Name_String, Test_] := Module[{T0 = AbsoluteTime[], Ok},
  Ok = TrueQ[Quiet[TimeConstrained[Test, 1800, False]]];
  AppendTo[TestResults, Name -> Ok];
  Print[If[Ok, "  PASS  ", "  FAIL  "], Name, "  (", Round[AbsoluteTime[] - T0], " s)"]];
Methods1 = $MBAnalyticaMethods;
MethodQ[M_] := MemberQ[Methods1, M];


(* 1. SymbolicSum grouped numerically equal but different integrals: (1/2)^z and (1/2 + 10^-14)^z *)
Check1["structures grouped by identity, not by value",
  MBEvaluate[Gamma[-z] Gamma[1 + z] ((1/2)^z - (1/2 + 10^-14)^z)/10^-14, {ep, 0}, Method -> "SymbolicSum", Complex -> True] ===
    200000000000000/450000000000003];

(* 2. user symbols named like the constants of the dependencies stay what they are, with every method *)
BarnesKernel = Gamma[-z] Gamma[1 - z] Gamma[1 + z]^2;
Do[With[{Par = Symbol["Global`" <> Name]},
    Check1["parameter " <> Name <> " with SymbolicSum",
      MBEvaluate[Par BarnesKernel, {ep, 0}, Method -> "SymbolicSum", Complex -> True] === Par/2]],
  {Name, {"x", "z2", "z3", "z5", "ln2", "li4half", "Log2", "et1", "S", "H"}}];
Do[If[MethodQ[M],
    Check1["parameter z2 with " <> M, Simplify[MBEvaluate[Global`z2 BarnesKernel, {ep, 0}, Method -> M, Complex -> True] - Global`z2/2] === 0];
    Check1["kinematic variable z3 with " <> M,
      Simplify[MBEvaluate[Gamma[-z] Gamma[1 + z] Global`z3^z, {ep, 0}, Method -> M] - 1/(1 + Global`z3), 0 < Global`z3 < 1] === 0]],
  {M, {"ExpandInt", "Subtraction"}}];
Check1["kinematic variable z3 with SymbolicSum",
  Simplify[MBEvaluate[Gamma[-z] Gamma[1 + z] Global`z3^z, {ep, 0}, Method -> "SymbolicSum"] - 1/(1 + Global`z3), 0 < Global`z3 < 1] === 0];

(* 8. a result returned with the convergence region of its series keeps every order: Coefficient took the
   ConditionalExpression as a single term, so that 1/ep got the coefficient 0 and the whole result became the
   coefficient of ep^0, which the regulator check then omitted (the one-mass angular integral of Examples.nb) *)
I111m = 2^(-1 + 2 ep) Pi^ep Gamma[1 - 2 ep]/Gamma[1 - ep] 2^(-1 - 2 ep) Pi^(1 - ep)/Gamma[-1 - 2 ep] Gamma[-z11] Gamma[-z12]*
  Gamma[-z13] Gamma[-z23] Gamma[1 + 2 z11 + z12 + z13] Gamma[1 + z12 + z23] Gamma[1 + z13 + z23]*
  Gamma[-2 - ep - z11 - z12 - z13 - z23] v11^z11 v12^z12 v13^z13 v23^z23;
Check1["SymbolicSum result with a condition keeps every order", With[{R = MBEvaluate[I111m, {ep, 0}, Method -> "SymbolicSum"]},
  Head[R] === ConditionalExpression &&
    Simplify[Coefficient[Expand[First[R]], ep, -1] + Pi (v12 + v13)/(4 v12 v13 v23)] === 0 &&
    FreeQ[Coefficient[Expand[First[R]], ep, 0], ep] && ! FreeQ[Coefficient[Expand[First[R]], ep, 0], Log]]];


(* 4. an exact half-integer order is refused with a message, a regulated one is not *)
Check1["CosmoTreeMB refuses nu = 3/2", CosmoTreeMB[{{1, 2}}, {3, 3}, {3/2}, "Point" -> {{3, 4}, {1}}] === $Failed];
Check1["CosmoTreeMB refuses nu = 5/2", CosmoTreeMB[{{1, 2}}, {3, 3}, {5/2}, "Point" -> {{3, 4}, {1}}] === $Failed];
Check1["CosmoTreeMB refuses nu = 3/2 with LightSplit",
  CosmoTreeMB[{{1, 2}}, {3, 3}, {3/2}, "Point" -> {{3, 4}, {1}}, "LightSplit" -> True] === $Failed];
Check1["CosmoTreeMB refuses a K leg of order 3/2",
  CosmoTreeMB[{{1, 2}}, {2, 1/2}, {1/2}, "Energies" -> {{k2, k3}, {k3}}, "KLegs" -> {{1, k1, 3/2}}, "Point" -> {{9/10, 4/5}, {4/5}, {1}}] === $Failed];
Check1["CosmoTreeMB keeps nu = 3/2 - eps", With[{R = CosmoTreeMB[{{1, 2}}, {3, 3}, {3/2 - ep}, "Point" -> {{3, 4}, {1}}, "LightSplit" -> True]},
  ListQ[R] && R =!= {} && AllTrue[R, AssociationQ[#] && ! PossibleZeroQ[#["Integrand"]] &]]];
Check1["CosmoTreeMB keeps nu = 1/2", With[{R = CosmoTreeMB[{{1, 2}}, {1, 1}, {1/2}, "Point" -> {{3, 4}, {1}}]},
  ListQ[R] && Length[R] === 2 && AllTrue[R, ! PossibleZeroQ[#["Integrand"]] &]]];

(* 5. values of notebook symbols are neither used nor changed *)
Reference5 = CosmoTreeMB[{{1, 2}}, {1, 1}, {1/2}, "Point" -> {{3, 4}, {1}}];
(* the comparison with the reference is made outside the Block, where u1 has no value *)
Run5 = Block[{Global`u1 = 2}, {CosmoTreeMB[{{1, 2}}, {1, 1}, {1/2}, "Point" -> {{3, 4}, {1}}], Global`u1 === 2}];
Check1["CosmoTreeMB with u1 = 2", With[{R = First[Run5]},
  Last[Run5] && ListQ[R] && FreeQ[R[[All, "Integrand"]], 2^_] && FreeQ[R[[All, "Variables", All, 1]], 2] &&
    (* the same integrand, with the renamed variable *)
    (R[[1, "Integrand"]] /. Thread[R[[1, "Variables", All, 1]] -> Reference5[[1, "Variables", All, 1]]]) === Reference5[[1, "Integrand"]]]];
Check1["CosmoTreeMB with z1 = 2", Block[{Global`z1 = 2}, With[{R = CosmoTreeMB[{{1, 2}}, {1, 1}, {1/2}, "Point" -> {{3, 4}, {1}}]},
  Global`z1 === 2 && ListQ[R] && FreeQ[R[[All, "Integrand"]], ComplexInfinity | Indeterminate] && ! MemberQ[R[[All, "Integrand"]], 0]]]];

(* 7. the endpoint series of SymbolicSum *)
Check1["H(-1; t) series", Expand[MBAnalytica`SymbolicSum`Private`HPLSeries[{-1}, 3, t, L]] === t - t^2/2 + t^3/3];
Check1["H(2; t) series", Expand[MBAnalytica`SymbolicSum`Private`HPLSeries[{2}, 3, t, L] - Normal[Series[-Log[1 - t/2], {t, 0, 3}]]] === 0];
Check1["limit with a fourth-order pole", With[{Y = MBAnalytica`SymbolicSum`Private`MBCHVarY},
  MBAnalytica`SymbolicSum`Private`LimitToOne[(Log[Y] + (1 - Y) + (1 - Y)^2/2 + (1 - Y)^3/3)/(1 - Y)^4] === -1/4]];
Check1["pole order of a product", With[{Y = MBAnalytica`SymbolicSum`Private`MBCHVarY},
  MBAnalytica`SymbolicSum`Private`PoleOrderAtOne[1/((1 - Y)^2 (1 - Y^2)^2)] === 4]];

(* 8. a coefficient must be free of the regulator and of unfinished series, integrals and limits *)
NotEvaluatedQ[C1_] := Head[C1] === MBAnalytica`Private`NotEvaluated;
Check1["output gate: SeriesData", NotEvaluatedQ[MBAnalytica`Private`CheckOutputClass[SeriesData[e, 0, {1, 2}, 0, 2, 1], "test", {}, e]]];
Check1["output gate: regulator", NotEvaluatedQ[MBAnalytica`Private`CheckOutputClass[Re[Gamma[e]] + 1, "test", {}, e]]];
Check1["output gate: Inactive[Integrate]", NotEvaluatedQ[MBAnalytica`Private`CheckOutputClass[Inactive[Integrate][1/(1 + x^2), {x, 0, 1}], "test", {}, e]]];
Check1["output gate: an MPL coefficient", MBAnalytica`Private`CheckOutputClass[Zeta[3] + Log[x] PolyLogTools`G[0, 1, x], "test", {x}, e] ===
  Zeta[3] + Log[x] PolyLogTools`G[0, 1, x]];

(* 12. the Perl fallback of timeout kills the whole process tree *)
If[StringQ[MBAnalytica`Portable`Private`FindCommand["perl"]],
  Check1["Perl timeout supervisor", Module[{Dir = CreateDirectory[], PidFile, Res, Child},
    PidFile = FileNameJoin[{Dir, "child"}];
    Res = RunProcess[Join[{MBAnalytica`Portable`Private`FindCommand["perl"], "-e", MBAnalytica`Portable`Private`PerlSupervisor, "2"},
      {"/bin/sh", "-c", "sleep 60 & echo $! > '" <> PidFile <> "'; sleep 60"}]];
    Pause[1];
    Child = Quiet[ToExpression[StringTrim[Import[PidFile, "Text"]]]];
    Res["ExitCode"] === 124 && IntegerQ[Child] && RunProcess[{"kill", "-0", ToString[Child]}, "ExitCode"] =!= 0]]];

(* the review of a6af3be (2026-11-10) *)
(* R1. the private names of the symbol protection are fresh: a user symbol of the same name, or one with a value, is
   neither merged with a protected parameter nor read *)
Check1["private name taken by a user symbol",
  Simplify[MBEvaluate[(Global`z2 + Global`mbaUserSymbol0001) BarnesKernel, {ep, 0}, Method -> "SymbolicSum", Complex -> True] -
    (Global`z2 + Global`mbaUserSymbol0001)/2] === 0];
Check1["private name with a value", Block[{Global`mbaUserSymbol0001 = 7},
  MBEvaluate[Global`z2 BarnesKernel, {ep, 0}, Method -> "SymbolicSum", Complex -> True] === Global`z2/2]];
Check1["two protected parameters", Simplify[MBEvaluate[(Global`z2 + 2 Global`ln2) BarnesKernel, {ep, 0}, Method -> "SymbolicSum",
  Complex -> True] - (Global`z2 + 2 Global`ln2)/2] === 0];
(* the review of e4f55bd: the private names are kept and used again, so that the memo of the leading pole does not grow
   under removed names *)
Check1["private names used again, no memo growth", Module[{Names1, Memo1},
  MBEvaluate[Global`z2 BarnesKernel, {ep, 0}, Method -> "SymbolicSum", Complex -> True];
  Names1 = Names["Global`mbaUserSymbol*"];
  Memo1 = Length[DownValues[MBAnalytica`Private`LeadingPole]];
  Do[MBEvaluate[Global`z2 BarnesKernel, {ep, 0}, Method -> "SymbolicSum", Complex -> True], {3}];
  Names["Global`mbaUserSymbol*"] === Names1 && Length[DownValues[MBAnalytica`Private`LeadingPole]] === Memo1 &&
    StringFreeQ[ToString[DownValues[MBAnalytica`Private`LeadingPole], InputForm], "Removed"]]];

(* R2. an inexact order is refused: 0.5 and 1.5 passed the exact checks and gave zero integrands *)
Do[Check1["CosmoTreeMB refuses the inexact order " <> ToString[Nu, InputForm],
    CosmoTreeMB[{{1, 2}}, {1, 1}, {Nu}, "Point" -> {{3, 4}, {1}}] === $Failed],
  {Nu, {0.5, 1.5, N[1/2, 30], 0.5 - ep}}];
Check1["CosmoTreeMB refuses a K leg of order 1.5",
  CosmoTreeMB[{{1, 2}}, {2, 1/2}, {1/2}, "Energies" -> {{k2, k3}, {k3}}, "KLegs" -> {{1, k1, 1.5}}, "Point" -> {{9/10, 4/5}, {4/5}, {1}}] === $Failed];

(* R3. an output name never denotes two things *)
Check1["CosmoTreeMB refuses the variable name z",
  CosmoTreeMB[{{1, 2}}, {1, 1}, {1/2}, "Point" -> {{3, 4}, {1}}, "VariableName" -> "z"] === $Failed];
Check1["CosmoTreeMB refuses energies named u1, u2",
  CosmoTreeMB[{{1, 2}}, {1, 1}, {1/2}, "Energies" -> {{u1, u2}, {u3}}, "Point" -> {{3, 4}, {1}}] === $Failed];
Check1["CosmoTreeMB with energies u1, u2 and the variable name v", With[{R = CosmoTreeMB[{{1, 2}}, {1, 1}, {1/2},
    "Energies" -> {{u1, u2}, {u3}}, "Point" -> {{3, 4}, {1}}, "VariableName" -> "v"]},
  ListQ[R] && Length[R] === 2 && Sort[R[[1, "Variables", All, 1]]] === {Global`v1, Global`v2} &&
    (R[[1, "Integrand"]] /. Thread[R[[1, "Variables", All, 1]] -> Reference5[[1, "Variables", All, 1]]]) === Reference5[[1, "Integrand"]]]];

(* R4. the depth of the endpoint expansion comes from the functions, not from their sum at 1 *)
Check1["limit with cancelling functions", With[{Y = MBAnalytica`SymbolicSum`Private`MBCHVarY},
  MBAnalytica`SymbolicSum`Private`LimitToOne[(HarmonicSums`H[1, 2, 3, 4, 1 - Y] - HarmonicSums`H[1, 2, 3, 5, 1 - Y])/(1 - Y)^4] === 1/2880]];

(* R5. a coefficient is taken only from a Laurent polynomial in the regulator *)
Check1["Laurent guard: Gamma[ep]", NotEvaluatedQ[MBAnalytica`Private`LaurentCoefficient[Gamma[ep], ep, 1, "test"]]];
Check1["Laurent guard: 1/ep + Gamma[ep]", NotEvaluatedQ[MBAnalytica`Private`LaurentCoefficient[1/ep + Gamma[ep], ep, -1, "test"]]];
Check1["Laurent guard: a Laurent polynomial", MBAnalytica`Private`LaurentCoefficient[1/ep^2 + 3 - Log[2] ep, ep, 1, "test"] === -Log[2]];

(* R6b. the exact Taylor check of the one-fold series, once per call: Sum_n (-x)^n/(n + e) *)
Check1["one-fold series through e^3", Block[{MBAnalytica`OneFoldHyp`OneFoldHypDomain = 0 < x < 1},
  MBAnalytica`OneFoldHyp`OneFoldHypExpand[Gamma[-z] Gamma[1 + z] Gamma[e + z]/Gamma[1 + e + z] x^z, e, {-1, 3}]] ===
  <|-1 -> 1, 0 -> -PolyLogTools`G[1, -x], 1 -> PolyLogTools`G[0, 1, -x], 2 -> -PolyLogTools`G[0, 0, 1, -x], 3 -> PolyLogTools`G[0, 0, 0, 1, -x]|>];

(* perf C of the review: the scan of the System symbols is kept under a hash of their rules, and a rule of the summation
   packages added or removed afterwards is seen *)
Check1["rule scan kept and renewed", Module[{First1, Second1, Added, Removed, T1, T2},
  {T1, First1} = AbsoluteTiming[MBAnalytica`Private`SymbolicSumRules[]];
  {T2, Second1} = AbsoluteTiming[MBAnalytica`Private`SymbolicSumRules[]];
  Unprotect[System`Erfc];
  System`Erfc[HarmonicSums`Private`mbaRegressionProbe] := 1;
  Added = MBAnalytica`Private`SymbolicSumRules[];
  System`Erfc[HarmonicSums`Private`mbaRegressionProbe] =.;
  Protect[System`Erfc];
  Removed = MBAnalytica`Private`SymbolicSumRules[];
  First1 =!= <||> && Second1 === First1 && KeyExistsQ[Added, "Erfc"] && ! KeyExistsQ[First1, "Erfc"] && Removed === First1]];

(* R7. the Perl supervisor waits for its limit on a high-resolution clock and cleans up when it is stopped *)
If[StringQ[MBAnalytica`Portable`Private`FindCommand["perl"]],
  Check1["Perl supervisor keeps a command within its limit", Count[Table[RunProcess[{MBAnalytica`Portable`Private`FindCommand["perl"], "-e",
    MBAnalytica`Portable`Private`PerlSupervisor, "1", "/bin/sh", "-c", "sleep 0.5"}, "ExitCode"], {6}], 0] === 6];
  Check1["Perl supervisor stopped by TERM", Module[{Dir = CreateDirectory[], PidFile, P, Child},
    PidFile = FileNameJoin[{Dir, "child"}];
    P = StartProcess[{MBAnalytica`Portable`Private`FindCommand["perl"], "-e", MBAnalytica`Portable`Private`PerlSupervisor, "30",
      "/bin/sh", "-c", "sleep 60 & echo $! > '" <> PidFile <> "'; sleep 60"}];
    Pause[1.5];
    RunProcess[{"kill", "-TERM", ToString[P["PID"]]}];
    Pause[1.5];
    Child = Quiet[ToExpression[StringTrim[Import[PidFile, "Text"]]]];
    IntegerQ[Child] && RunProcess[{"kill", "-0", ToString[Child]}, "ExitCode"] =!= 0]];
  (* an aborted RunProcess kills the supervisor's group with KILL; its watcher then kills the command's group *)
  Check1["Perl supervisor of an aborted RunProcess", Module[{Dir = CreateDirectory[], ShFile, PidFile, R, Sh, Child},
    ShFile = FileNameJoin[{Dir, "sh"}];
    PidFile = FileNameJoin[{Dir, "child"}];
    R = TimeConstrained[RunProcess[{MBAnalytica`Portable`Private`FindCommand["perl"], "-e", MBAnalytica`Portable`Private`PerlSupervisor, "30",
      "/bin/sh", "-c", "echo $$ > '" <> ShFile <> "'; sleep 60 & echo $! > '" <> PidFile <> "'; sleep 60"}], 2, "aborted"];
    Pause[2];
    Sh = Quiet[ToExpression[StringTrim[Import[ShFile, "Text"]]]];
    Child = Quiet[ToExpression[StringTrim[Import[PidFile, "Text"]]]];
    R === "aborted" && IntegerQ[Sh] && IntegerQ[Child] && RunProcess[{"kill", "-0", ToString[Sh]}, "ExitCode"] =!= 0 &&
      RunProcess[{"kill", "-0", ToString[Child]}, "ExitCode"] =!= 0]]];

(* the review of e4f55bd (2026-11-10) *)
(* R3.1 a negative base is the principal power.  On a domain where it is negative (ParameterAssumptions -> 0 < x < 1) it is
   solved with a positive phase and continued to Exp[I Pi]; positive bases as before; a base of no fixed sign there, or
   a complex one, is refused *)
Value1[R_] := If[Head[R] === ConditionalExpression, First[R], R];
If[MethodQ["SymbolicSum"],
  Check1["negative base: the full complex value", FullSimplify[Value1[MBEvaluate[I BarnesKernel (-2 x)^z, {ep, 0},
    Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True, ParameterAssumptions -> 0 < x < 1]] -
      (2 Pi x + I (1 + 2 x - 2 x Log[2 x]))/(1 + 2 x)^2, 0 < x < 1] === 0];
  Check1["negative base: the real part", FullSimplify[Value1[MBEvaluate[I BarnesKernel (-2 x)^z, {ep, 0}, Method -> "SymbolicSum",
    BarnesReduce -> False, ParameterAssumptions -> 0 < x < 1]] - 2 Pi x/(1 + 2 x)^2, 0 < x < 1] === 0];
  Check1["negative base: the inverse power", With[{X = -2 x, LX = Log[2 x] + I Pi}, FullSimplify[Value1[MBEvaluate[I BarnesKernel (-2 x)^(-z),
    {ep, 0}, Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True, ParameterAssumptions -> 0 < x < 1]] -
      I (X^2 - X - X LX)/(X - 1)^2, 0 < x < 1] === 0]];
  (* the principal power on the negative axis is the limit from above: the contour integral with Log of the base at
     Log[3/2] + I Pi agrees, the one with Log[3/2] - I Pi (the limit from below) differs by 12 Pi/25 *)
  Check1["negative base: the limit from above, not from below", Module[{V, Contours},
    V = N[Value1[MBEvaluate[I BarnesKernel (-2 x)^z, {ep, 0}, Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True,
      ParameterAssumptions -> 0 < x < 1]] /. x -> 3/4, 25];
    Contours = Map[Function[LB, NIntegrate[Evaluate[I BarnesKernel Exp[z LB] /. z -> -1/2 + I t], {t, -60, 60}, WorkingPrecision -> 30]/(2 Pi)],
      {Log[3/2] + I Pi, Log[3/2] - I Pi}];
    Abs[V - Contours[[1]]] < 10^-12 && Abs[Abs[V - Contours[[2]]] - 12 Pi/25] < 10^-12]];
  (* at the probe x = 1/2 the base -2 x sits on the boundary of both charts: the analytic regulator gives the value on
     the whole domain, and without it the charts are summed at probes on either side, a value with its region *)
  Check1["negative base without the analytic regulator", Module[{R},
    MBAnalytica`SymbolicSum`Private`ClearSolveCaches[];
    R = Block[{MBAnalytica`SymbolicSum`Private`MBCHRegSlots = 0}, MBEvaluate[I BarnesKernel (-2 x)^z, {ep, 0},
      Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True, ParameterAssumptions -> 0 < x < 1]];
    MBAnalytica`SymbolicSum`Private`ClearSolveCaches[];
    R =!= 0 && FullSimplify[Value1[R] - (2 Pi x + I (1 + 2 x - 2 x Log[2 x]))/(1 + 2 x)^2,
      If[Head[R] === ConditionalExpression, R[[2]], True] && 0 < x < 1] === 0]];
  Check1["negative base -x/3 (its charts converge at the probe)", With[{X = -x/3}, FullSimplify[Value1[MBEvaluate[I BarnesKernel (-x/3)^z,
    {ep, 0}, Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True, ParameterAssumptions -> 0 < x < 1]] -
      I (1 - X + X (Log[x/3] + I Pi))/(1 - X)^2, 0 < x < 1] === 0]];
  Check1["positive bases as before, Log[2] not ln2", With[{R = MBEvaluate[I BarnesKernel (2 x)^z, {ep, 0}, Method -> "SymbolicSum",
      BarnesReduce -> False, Complex -> True]},
    FreeQ[R, Global`ln2] && FullSimplify[Value1[R] - I (1 - 2 x + 2 x Log[2 x])/(1 - 2 x)^2, 1/2 < x < 1] === 0 &&
      FullSimplify[MBEvaluate[I BarnesKernel (x/3)^z, {ep, 0}, Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True] -
        I (1 - x/3 + x/3 Log[x/3])/(1 - x/3)^2, 0 < x < 1] === 0]];
  Check1["complex base refused", Check[MBEvaluate[I BarnesKernel (-2 x + I/10)^z, {ep, 0}, Method -> "SymbolicSum", Complex -> True,
    ParameterAssumptions -> 0 < x < 1]; False, True, MBEvaluate::open]];
  Check1["complex base: no real values make it positive", Check[MBEvaluate[I BarnesKernel (-2 x + I/10)^z, {ep, 0},
    Method -> "SymbolicSum", Complex -> True]; False, True, MBEvaluate::bases]];
  Check1["base of changing sign on the domain refused", Check[MBEvaluate[I BarnesKernel (1 - 2 x)^z, {ep, 0}, Method -> "SymbolicSum",
    Complex -> True, ParameterAssumptions -> 0 < x < 1]; False, True, MBEvaluate::open]];
  (* (-x)^z: a base that is no symbol, with -X = x below 1 (Mathematica writes (-x/2)^z as (-x)^z/2^z, two powers,
     which is outside the class) *)
  Check1["one-fold route: the negative base -x", Block[{MBAnalytica`OneFoldHyp`OneFoldHypDomain = 0 < x < 1 && 0 < y < 1},
    With[{A = MBAnalytica`OneFoldHyp`OneFoldHypExpand[
      Gamma[-z] Gamma[1 + z] Gamma[e + z]/Gamma[1 + e + z] (-x)^z, e, {-1, 1}],
      B = MBAnalytica`OneFoldHyp`OneFoldHypExpand[Gamma[-z] Gamma[1 + z] Gamma[e + z]/Gamma[1 + e + z] y^z, e, {-1, 1}] /. y -> -x},
    AssociationQ[A] && AssociationQ[B] && AllTrue[Keys[B], Simplify[A[#] - B[#]] === 0 &]]]];
  Check1["one-fold route refuses the argument 2 x", Block[{MBAnalytica`OneFoldHyp`OneFoldHypDomain = 0 < x < 1},
    MBAnalytica`OneFoldHyp`OneFoldHypExpand[Gamma[-z] Gamma[1 + z] Gamma[e + z]/Gamma[1 + e + z] (-2 x)^z, e, {-1, 1}]] === $Failed];
  (* R3.3 the defaults of SetOptions[MBEvaluate, ...] are read, an explicit option still wins, and the defaults return *)
  Check1["SetOptions of MBEvaluate", Module[{Saved = Options[MBEvaluate], A, B, C1},
    SetOptions[MBEvaluate, Complex -> True];
    A = MBEvaluate[I BarnesKernel, {ep, 0}, Method -> "SymbolicSum"];
    B = MBEvaluate[I BarnesKernel, {ep, 0}, Method -> "SymbolicSum", Complex -> False];
    SetOptions[MBEvaluate, Saved];
    C1 = MBEvaluate[I BarnesKernel, {ep, 0}, Method -> "SymbolicSum"];
    A === I/2 && B === 0 && C1 === 0 && Options[MBEvaluate] === Saved]];
  (* the names the methods give their own variables *)
  Check1["a parameter named like an integration variable", MBEvaluate[Global`MBSymbolicSumIntVar1 BarnesKernel, {ep, 0},
    Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True] === Global`MBSymbolicSumIntVar1/2];
  Check1["a parameter named like the phase", MBEvaluate[Global`MBSymbolicSumPhase BarnesKernel, {ep, 0}, Method -> "SymbolicSum",
    Complex -> True] === Global`MBSymbolicSumPhase/2];
  (* R3.4 an H that is not real on the whole domain keeps its imaginary part in the real projection *)
  Check1["TidyResult of I H[1, 2 x] and I H[1, x/2]", Block[{MBAnalytica`SymbolicSum`Private`MBCHComplex = False,
      MBAnalytica`SymbolicSum`Private`MBCHScale = {x}, MBAnalytica`SymbolicSum`Private`MBCHDomain = 0 < x < 1},
    MBAnalytica`SymbolicSum`Private`TidyResult[I HarmonicSums`H[1, 2 x]] === -Im[HarmonicSums`H[1, 2 x]] &&
      MBAnalytica`SymbolicSum`Private`TidyResult[I HarmonicSums`H[1, x/2]] === 0]]];
(* G1. the general kinematics: with nothing assumed, the coefficients are closed forms in the bases as written, solved
   where every base lies in (0, 1) and holding for any x by analytic continuation, with the principal value of every
   power; ParameterAssumptions restricts the variables, and Complex -> False takes the real part on the given domain,
   or for every real value without one *)
GeneralExact[X_] := I (1 - X + X Log[X])/(1 - X)^2;
GeneralAgreeQ[R_, Base_, Pts_] := FreeQ[R, ConditionalExpression] && AllTrue[Pts, Function[Pt,
  Abs[MBAnalytica`Private`NumericValue[R /. x -> Pt] - N[GeneralExact[Base /. x -> Pt], 20]] < 10^-12]];
Do[If[MethodQ[M],
    Check1["any x: a negative base with " <> M, GeneralAgreeQ[MBEvaluate[I BarnesKernel (-2 x)^z, {ep, 0}, Method -> M,
      BarnesReduce -> False, Complex -> True], -2 x, {-1/4, 1/3, 3/4, 2}]];
    Check1["any x: a base of changing sign with " <> M, GeneralAgreeQ[MBEvaluate[I BarnesKernel (1 - 2 x)^z, {ep, 0}, Method -> M,
      BarnesReduce -> False, Complex -> True], 1 - 2 x, {1/4, 3/4, -1}]];
    Check1["any x: no condition for the base 2 x with " <> M, GeneralAgreeQ[MBEvaluate[I BarnesKernel (2 x)^z, {ep, 0}, Method -> M,
      BarnesReduce -> False, Complex -> True], 2 x, {1/4, 3/4, 2}]]],
  {M, {"SymbolicSum", "ExpandInt", "Subtraction"}}];
If[MethodQ["SymbolicSum"],
  Check1["any x: the real part for every real x", With[{R = MBEvaluate[BarnesKernel (2 x)^z, {ep, 0}, Method -> "SymbolicSum",
      BarnesReduce -> False]},
    AllTrue[{-1/3, 1/4, 3/4, 2}, Abs[MBAnalytica`Private`NumericValue[R /. x -> #] - Re[N[GeneralExact[2 #]/I, 20]]] < 10^-12 &]]];
  Check1["any x: the real part on a given domain", With[{R = MBEvaluate[BarnesKernel (2 x)^z, {ep, 0}, Method -> "SymbolicSum",
      BarnesReduce -> False, ParameterAssumptions -> 0 < x < 1/2]},
    FreeQ[R, Abs | Re | Im] && FullSimplify[R - GeneralExact[2 x]/I, 0 < x < 1/2] === 0]];
  (* as for Assumptions: a list of conditions, lists in lists, and conditions on other symbols, which restrict nothing,
     so that one list serves integrals in different variables *)
  With[{Ref = MBEvaluate[BarnesKernel (2 x)^z, {ep, 0}, Method -> "SymbolicSum", BarnesReduce -> False,
      ParameterAssumptions -> 0 < x < 1/2],
    Free = MBEvaluate[BarnesKernel (2 x)^z, {ep, 0}, Method -> "SymbolicSum", BarnesReduce -> False]},
    Check1["a list of conditions, as for Assumptions", MBEvaluate[BarnesKernel (2 x)^z, {ep, 0}, Method -> "SymbolicSum",
      BarnesReduce -> False, ParameterAssumptions -> {0 < x, x < 1/2}] === Ref];
    Check1["lists in lists", MBEvaluate[BarnesKernel (2 x)^z, {ep, 0}, Method -> "SymbolicSum", BarnesReduce -> False,
      ParameterAssumptions -> {{0 < x < 1/2}}] === Ref];
    Check1["one list for integrals in different variables", MBEvaluate[BarnesKernel (2 x)^z, {ep, 0},
      Method -> "SymbolicSum", BarnesReduce -> False, ParameterAssumptions -> {0 < x < 1/2, 0 < Global`y < 1, ep > 0}] === Ref];
    Check1["a condition on another symbol restricts nothing", MBEvaluate[BarnesKernel (2 x)^z, {ep, 0},
      Method -> "SymbolicSum", BarnesReduce -> False, ParameterAssumptions -> Global`a > 0] === Free];
    Check1["Element[x, Reals] restricts nothing", MBEvaluate[BarnesKernel (2 x)^z, {ep, 0}, Method -> "SymbolicSum",
      BarnesReduce -> False, ParameterAssumptions -> Element[x, Reals]] === Free]];
  Check1["contradictory conditions on another symbol refused", Check[MBEvaluate[I BarnesKernel (2 x)^z, {ep, 0},
    Method -> "SymbolicSum", ParameterAssumptions -> {Global`a > 1, Global`a < 0}]; False, True, MBEvaluate::assum]];
  Check1["an empty domain refused", Check[MBEvaluate[I BarnesKernel (2 x)^z, {ep, 0}, Method -> "SymbolicSum",
    ParameterAssumptions -> x > 1 && x < 0]; False, True, MBEvaluate::assum]];
  Check1["bases that are never positive together", Check[MBEvaluate[Gamma[-z] Gamma[1 + z] x^z (-x)^ep, {ep, 0},
    Method -> "SymbolicSum"]; False, True, MBEvaluate::bases]]];
(* G2. an unbounded projection, V > c with c > 0 or V < c with c < 0, is inverted to the unit interval, V -> c/V, and
   every power of a base with V is split into the powers of its factors, each positive there.  SymbolicSum summed no
   series solution of the two-fold product on y > 1 before *)
Check1["the split of an inverted base", MBAnalytica`Private`SplitPower[1 + 2/Global`y, w, {Global`y}, 0 < Global`y < 1] ===
  (2 + Global`y)^w Global`y^-w];
Check1["a negative inverted base is not split", MBAnalytica`Private`SplitPower[1 - 2/Global`y, w, {Global`y},
  0 < Global`y < 1] === $Failed];
Check1["the inversion of y > 1", With[{D1 = MBAnalytica`Private`KinematicDomains[Gamma[-z] Gamma[1 + z] Global`y^z,
    {Global`y}, Global`y > 1]},
  D1["Forward"] === {Global`y -> 1/Global`y} && D1["Integrand"] === Gamma[-z] Gamma[1 + z] Global`y^-z]];
Do[If[MethodQ[M],
    Check1["an unbounded domain {0 < x < 1, y > 1} with " <> M, With[{R = MBEvaluate[Gamma[-z] Gamma[1 + z] x^z Gamma[-w]*
        Gamma[1 + w] Global`y^w, {ep, 0}, Method -> M, ParameterAssumptions -> {0 < x < 1, Global`y > 1}]},
      Simplify[R - 1/((1 + x) (1 + Global`y))] === 0]]],
  {M, {"SymbolicSum", "ExpandInt", "Subtraction"}}];
If[MethodQ["SymbolicSum"],
  Check1["an unbounded domain x > 1 with SymbolicSum", With[{R = MBEvaluate[Gamma[-z]^2 Gamma[1 + z]^2 x^z, {ep, 0},
      Method -> "SymbolicSum", ParameterAssumptions -> {x > 1}]},
    FullSimplify[R - Log[x]/(x - 1), x > 1] === 0]]];
(* R3.7 $KernelLaunch = 0 is one subkernel, with a message *)
Check1["$KernelLaunch = 0", Block[{Global`$KernelLaunch = 0},
  MBAnalytica`Private`KernelCountWarned = False;
  Check[MBAnalytica`Private`KernelCount[]; False, True, MBEvaluate::kernels] && MBAnalytica`Private`KernelCount[] === 1]];
(* R3.5 the benchmark checker takes the lowest order from the benchmark, not from the value: a value without its leading
   pole fails, the full value passes *)
Check1["benchmark checker refuses a truncated value", Module[{Dir = CreateDirectory[], Full, Lo1, Trunc, Run1, Kernel1},
  Block[{$ContextPath = $ContextPath}, Get[FileNameJoin[{TestRoot, "tests", "benchmark", "mb_symbolicsum_targets.m"}]]];
  Full = Expand[Normal[Series[Global`MB1Val, {Global`\[Epsilon], 0, 0}]]];
  Lo1 = Exponent[Full, Global`\[Epsilon], Min];
  Trunc = Expand[Full - Coefficient[Full, Global`\[Epsilon], Lo1] Global`\[Epsilon]^Lo1];
  (* the kernel of this installation through its launcher (the binary of $CommandLine needs the launcher's environment) *)
  Kernel1 = SelectFirst[{FileNameJoin[{$InstallationDirectory, "Executables", "WolframKernel"}],
    FileNameJoin[{$InstallationDirectory, "MacOS", "WolframKernel"}], First[$CommandLine]}, FileExistsQ];
  Run1[V_, Tag_] := Module[{F = FileNameJoin[{Dir, Tag <> ".m"}], Out},
    Put[<|"Value" -> V, "Seconds" -> 0|>, F];
    Out = RunProcess[{Kernel1, "-noprompt", "-script", FileNameJoin[{TestRoot, "tests", "benchmark", "mbevaluate_target.wls"}]},
      ProcessEnvironment -> Join[Association[GetEnvironment[]], <|"METHOD" -> "SymbolicSum", "KIND" -> "inc", "NAME" -> "MB1",
        "LO" -> "auto", "HI" -> "0", "OUT" -> Dir, "RECHECK" -> F, "KERNELS" -> "1"|>]];
    (* the kernel prints the strings of the result line in InputForm under -script: pass "True" *)
    StringContainsQ[Out["StandardOutput"], RegularExpression["MBEVAL_RESULT.*pass \"?True"]]];
  Lo1 < 0 && Run1[Full, "full"] && ! Run1[Trunc, "truncated"]]];

(* 3. and 6. need the integration engine *)
If[MethodQ["ExpandInt"] || MethodQ["Subtraction"],
  MBAnalytica`Private`WithoutUserValues[MBAnalytica`Private`LoadSymbolicInt[]];
  Clear[x, y, z, w, v];
  (* 2. replacing every user symbol by a private one changed the order of the kinematic variables against the internal
     symbols of the summation, and EvaluateMultiSums then summed none of the series of the Appell function
     F1(ep, ep, ep; 1 + ep; -u, -v), which SymbolicSum evaluates in about a minute.  Its coefficient of ep^2 is
     Li2(-u) + Li2(-v), from the double series term by term, compared numerically at u = 1/3, v = 1/5 (GiNaC) *)
  If[MethodQ["SymbolicSum"],
    F1a = Gamma[1 + ep]/Gamma[ep]^3 Gamma[-s] Gamma[-t] Gamma[ep + s + t] Gamma[ep + s] Gamma[ep + t]/Gamma[1 + ep + s + t] u^s v^t;
    Check1["Appell F1 with SymbolicSum through ep^2", With[{R = MBEvaluate[F1a, {u, v}, {ep, 2}, Method -> "SymbolicSum"]},
      With[{V = Expand[If[Head[R] === ConditionalExpression, First[R], R]]},
        Coefficient[V, ep, 0] === 1 && Coefficient[V, ep, 1] === 0 && FreeQ[Coefficient[V, ep, 2], ep] &&
          Abs[MBAnalytica`Private`NumericValue[Coefficient[V, ep, 2] /. {u -> 1/3, v -> 1/5}] -
            N[PolyLog[2, -1/3] + PolyLog[2, -1/5], 20]] < 10^-15]]]];
  Check1["corner search: minimal set of size three", MemberQ[Global`fcuVanishingSets[x y + x z + x w + y z w, {x, y, z, w}],
    s_ /; Sort[s] === Sort[{y -> 0, z -> 0, w -> 0}]]];
  Check1["corner letters: the face {y, z, w} -> 0 with x > 0",
    Global`fcuCornerLetters[x^2 (x y + x z + x w + y z w)^(-3 + ep), {x, y, z, w}, ep] =!= {}];
  Check1["corner letters: the origin of five variables",
    Global`fcuCornerLetters[(x + y + z + w + v)^(-5 + ep), {x, y, z, w, v}, ep] =!= {}];
  (* R6. corners of several letters, and of a letter that vanishes to a higher order (review of a6af3be) *)
  Check1["corner letters: three letters at the origin", Sort[Global`fcuCornerLetters[(x + y)^(-1 + ep) (x + z)^(-1 + ep) (y + z)^(-1 + ep),
    {x, y, z}, ep]] === Sort[{x + y, x + z, y + z}]];
  Check1["corner letters: a double zero", Global`fcuCornerLetters[(x^2 + y^2)^(-1 + ep), {x, y}, ep] === {x^2 + y^2}];
  Check1["corner letters: a weighted direction", Global`fcuCornerLetters[y (x + y^2)^(-2 + ep), {x, y}, ep] === {x + y^2}];
  Check1["corner letters: a union with a pole face", Global`fcuCornerLetters[z^(-1 + ep) (x + y + z)^(-1 + ep) (x + y)^(-1 + ep), {x, y, z}, ep] =!= {}];
  Check1["corner letters: convergent corners", Global`fcuCornerLetters[(x + y)^(-1 + ep) (y + z)^(-1 + ep), {x, y, z}, ep] === {} &&
    Global`fcuCornerLetters[y^2 (x + y^2)^(-2 + ep), {x, y}, ep] === {}];
  Check1["corner letters: an exponent that is no number", MissingQ[Global`fcuCornerLetters[(x + y)^(a + ep), {x, y}, ep]]];
  Check1["blow-up of three letters at the origin", With[{S = Catch[Global`fcuBlowUp[(x + y)^(-1 + ep) (x + z)^(-1 + ep) (y + z)^(-1 + ep),
      {x, y, z}, ep, False], Global`fcu$tag]},
    ListQ[S] && Length[S] >= 3 && AllTrue[S, Global`fcuCornerLetters[#[[1]], #[[2]], ep] === {} &]]];
  Check1["cube without jobs below its pole refused", FailureQ[MBAnalytica`Private`WithoutSymbolicSumRules[MBParameterSubtraction`PSPrepareCube[
    <|"Cube" -> (x + y)^(-1 + ep) (x + z)^(-1 + ep) (y + z)^(-1 + ep), "Variables" -> {x, y, z}, "Prefactor" -> 1|>, ep, -1, -1, {}]]]];
  If[MethodQ["Subtraction"],
    Check1["three-fold integral with that corner", With[{T = Gamma[-s] Gamma[1 - ep + s] Gamma[-t] Gamma[1 - ep + t] Gamma[-u] Gamma[1 - ep + u]/Gamma[1 - ep]^3*
        Gamma[-1 + 2 ep - s - t]/Gamma[2 ep - s - t] Gamma[ep + s - u]/Gamma[1 + ep + s - u] Gamma[1 + t + u]/Gamma[2 + t + u]},
      Simplify[MBEvaluate[T, {ep, -1}, Method -> "Subtraction", Complex -> True] - Pi^2/(12 ep)] === 0]]];
  (* the review of e4f55bd: a corner through a pole face along a weighted direction, x ~ y^2 *)
  Check1["corner letters: a weighted direction through a pole face", Global`fcuCornerLetters[x^(-1 + ep) y^3 (x + y^2)^(-2 + ep), {x, y}, ep] ===
    {x + y^2}];
  Check1["corner letters: a convergent weighted direction through a pole face",
    Global`fcuCornerLetters[x^(-1 + ep) y^5 (x + y^2)^(-2 + ep), {x, y}, ep] === {}];
  Check1["weighted face cube without jobs refused", FailureQ[MBAnalytica`Private`WithoutSymbolicSumRules[MBParameterSubtraction`PSPrepareCube[
    <|"Cube" -> x^(-1 + ep) y^3 (x + y^2)^(-2 + ep), "Variables" -> {x, y}, "Prefactor" -> 1|>, ep, -2, -2, {}]]]];
  (* R3.2 distinct logarithms do not cancel in the certificate, and the all-zero words of the endpoint jets are kept *)
  Check1["log certificate", With[{C1 = MBJobConvergence`mbeJobConvergenceCertificate[#, {x}]["Certified"] &},
    C1[(Log[x] - Log[1 - x])/x] === False && C1[Log[x]/x] === False && C1[Log[x]] === True &&
      C1[Log[x]/(x (1 + x)) - Log[x]/x] === True && C1[1/Log[x]] === False]];
  Check1["last folds: divergent refused, convergent exact", Module[{Gnum, Fold1},
    Gnum[E1_] := N[E1 /. {HoldPattern[PolyLogTools`G[0, A_]] :> Log[A], HoldPattern[PolyLogTools`G[1, A_]] :> Log[1 - A],
      HoldPattern[PolyLogTools`G[-1, A_]] :> Log[1 + A], HoldPattern[PolyLogTools`G[0, 0, A_]] :> Log[A]^2/2,
      HoldPattern[PolyLogTools`G[0, 1, A_]] :> -PolyLog[2, A], HoldPattern[PolyLogTools`G[0, -1, A_]] :> -PolyLog[2, -A],
      HoldPattern[PolyLogTools`G[-1, 0, A_]] :> Log[A] Log[1 + A] + PolyLog[2, -A]}, 40];
    Fold1[F_] := MBAnalytica`Private`WithoutSymbolicSumRules[Block[{MBExactLastFold`Private`gatePts = {1/3, 2/3}},
      KeyTake[MBExactLastFold`mbeLastFoldIntegrate[F, {}, x, Gnum], {"Status", "Value"}]]];
    Fold1[(PolyLogTools`G[0, x] - PolyLogTools`G[1, x])/x]["Status"] === "ZERO_NONCANCEL" &&
      Fold1[PolyLogTools`G[0, x]/x]["Status"] === "ZERO_NONCANCEL" &&
      Fold1[PolyLogTools`G[0, x]] === <|"Status" -> "ok", "Value" -> -1|> &&
      Fold1[-PolyLogTools`G[1, x]/x] === <|"Status" -> "ok", "Value" -> Pi^2/6|> &&
      Fold1[PolyLogTools`G[0, x]/(x (1 + x)) - PolyLogTools`G[0, x]/x] === <|"Status" -> "ok", "Value" -> Pi^2/12|>]];
  (* R3.6 the residue store repairs a corrupt value and an ownerless claim; every start of helpers has its own job
     directory, and an abort during the start stops the helpers already started *)
  If[TrueQ[Global`$orsInstalled],
    Check1["residue store: corrupt value, ownerless claim", Module[{Dir = CreateDirectory[], Calls = 0, A, B},
      Block[{Global`$oftResidueStore = Dir, Global`$oftClaimGrace = 1},
        Export[FileNameJoin[{Dir, "k1.wxf"}], "not a value", "Text"];
        A = Global`orsStoredCall["k1", (Calls++; {1, 2}), (ListQ[#] && Length[#] === 2 &), False];
        B = Global`orsStoredCall["k1", (Calls++; {3, 4}), (ListQ[#] && Length[#] === 2 &), False];
        CreateDirectory[FileNameJoin[{Dir, "k2.claim"}]];
        Pause[2];
        A === {1, 2} && B === {1, 2} && Calls === 1 &&
          TimeConstrained[Global`orsStoredCall["k2", {5, 6}, (ListQ[#] && Length[#] === 2 &), False], 60, $TimedOut] === {5, 6}]]];
    Check1["helpers: own job directory, stopped on an abort", Module[{Dir = CreateDirectory[], Fake, A, B, Left1},
      Fake = FileNameJoin[{Dir, "fakekernel.sh"}];
      Export[Fake, "#!/bin/sh\nsleep 4317\n", "Text"];
      RunProcess[{"chmod", "+x", Fake}];
      Block[{Global`$oftResidueStore = Dir, MBAnalytica`SymbolicInt`Private`$mbtMathExecutable = Fake},
        A = Global`orsStartHelpers[<|"Kind" -> "Family"|>, "tag", 0, False];
        B = Global`orsStartHelpers[<|"Kind" -> "Family"|>, "tag", 0, False];
        TimeConstrained[Global`orsStartHelpers[<|"Kind" -> "Family"|>, "tag2", 2, False], 3]];
      Pause[2];
      (* the bracket keeps pgrep from matching the command line of this shell *)
      Left1 = StringTrim[RunProcess[{"/bin/sh", "-c", "pgrep -f 'sleep 431[7]' | wc -l"}, "StandardOutput"]];
      A[[2]] =!= B[[2]] && Left1 === "0"]]];
  Check1["Euclidean partial fractions keep the quotient", With[{F1 = x^2/((x + 1) (x + 2))}, Together[IV$EuclideanApart[F1, x] - F1] === 0]];
  (* E1. the ExpandInt closure of the cosmological blocks: the constant half-integer part of a kinematic power is taken
     out of the kernel, u^(-1/2 - z) = u^(-1/2) u^(-z), and the source gate samples points with distinct parameters
     first, since equal parameters lie on the letters u_i - u_j of many candidates *)
  Check1["kinematic power with a constant half-integer offset split", With[{S = MBParameter`Private`splitKinematicConstants[
      Global`u^(-1/2 - z) Gamma[-z] Gamma[1 + z], {z}, 0 < Global`u < 1]},
    S[[1]] === Global`u^(-1/2) && Simplify[S[[2]] - Global`u^(-z) Gamma[-z] Gamma[1 + z]] === 0]];
  Check1["source-gate points with distinct parameters first", With[{P = MBParameter`Private`parameterPoints[{Global`u1, Global`u2},
      0 < Global`u1 < 1 && 0 < Global`u2 < 1]},
    Length[P] === 2 && AllTrue[P, DuplicateFreeQ[Values[#]] &]]];
  (* perf A of the review: the orders of a large block are formed without its permutations *)
  Check1["integration orders of eleven variables", With[{Vs = Array[Symbol["Global`axis" <> ToString[#]] &, 11]},
    With[{T = AbsoluteTiming[MBParameterSubtractionHF`Private`heurOrders[Times @@ (1/(1 + #) & /@ Vs), Vs, 48]]},
      T[[1]] < 30 && AssociationQ[T[[2]]] && Length[T[[2]]["Orders"]] === 48 && DuplicateFreeQ[T[[2]]["Orders"]]]]];
  Check1["integration orders as before", With[{B = {{a1, a2}, {b1, b2, b3}, {c1}}},
    MBParameterSubtractionHF`Private`boundedOrders[B, 20] === Take[Flatten[Outer[Join, Permutations[B[[1]]], Permutations[B[[2]]],
      Permutations[B[[3]]], 1], 2], UpTo[20]]]];
  Check1["native integrator: two-dimensional cube", With[{R = Block[{Global`$ivfChartThreads = 1, Global`$ivfChartPerChart = 1},
      Global`ivfExactCube[1/(1 + x + y^2), {x, y}, 30, "OrderHint" -> {x, y}]]},
    R === $Failed || Abs[N[R, 30] - N[Log[3/2] + 2 Sqrt[2] ArcTan[1/Sqrt[2]] - Pi/2, 30]] < 10^-20]];
  (* the reference is the y, z integral of Log[(2 + y^2 + z^2)/(1 + y^2 + z^2)] by NIntegrate with WorkingPrecision 40 and
     PrecisionGoal 25 in a fresh kernel; the three-dimensional NIntegrate with WorkingPrecision 25 is wrong in the eighth
     digit (0.48960288...) *)
  Check1["native integrator: no wrong three-dimensional cube", With[{R = Block[{Global`$ivfChartThreads = 1, Global`$ivfChartPerChart = 1},
      Global`ivfExactCube[1/(1 + x + y^2 + z^2), {x, y, z}, 30, "OrderHint" -> {x, y, z}]]},
    R === $Failed || Abs[N[R, 20] - 48960293731869148046/10^20] < 10^-15]]];

Print[""];
Failed1 = Select[TestResults, ! Last[#] &];
If[TestResults === {} || Failed1 =!= {},
  Print["Regression tests FAILED: ", If[TestResults === {}, "no test ran", StringRiffle[Keys[Failed1], ", "]]];
  Exit[1]];
Print["Regression tests passed: ", Length[TestResults], " tests"];
Exit[0];
