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
(* G1. the general kinematics: with nothing assumed, the closed form is derived where every base lies in (0, 1) and holds
   where every base is positive.  It holds for every value, with the principal powers, when it is a rational function
   of the logarithms and powers of the bases, as the values of SymbolicSum below, and otherwise it carries the condition
   that every base is positive (review of 07d9877).  ParameterAssumptions restricts the variables, and Complex -> False
   takes the real part where the result holds *)
GeneralExact[X_] := I (1 - X + X Log[X])/(1 - X)^2;
GeneralAgreeQ[R_, Base_, Pts_] := FreeQ[R, ConditionalExpression] && AllTrue[Pts, Function[Pt,
  Abs[MBAnalytica`Private`NumericValue[R /. x -> Pt] - N[GeneralExact[Base /. x -> Pt], 20]] < 10^-12]];
(* every value that the result claims is exact: with a condition, the positivity of the base, exact inside and Undefined
   outside; without one, exact everywhere *)
ClaimedAgreeQ[R_, Base_, PtsIn_, PtsOut_] := Module[{Cond, Agree},
  Cond = If[Head[R] === ConditionalExpression, R[[2]], True];
  Agree[Pt_] := Abs[MBAnalytica`Private`NumericValue[R /. x -> Pt] - N[GeneralExact[Base /. x -> Pt], 20]] < 10^-12;
  (Cond === True || TrueQ[Reduce[Equivalent[Cond, Base > 0], x, Reals]]) && AllTrue[PtsIn, Agree] &&
    AllTrue[PtsOut, If[Cond === True, Agree[#], (R /. x -> #) === Undefined] &]];
If[MethodQ["SymbolicSum"],
  Check1["any x: a negative base with SymbolicSum", GeneralAgreeQ[MBEvaluate[I BarnesKernel (-2 x)^z, {ep, 0},
    Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True], -2 x, {-1/4, 1/3, 3/4, 2}]];
  Check1["any x: a base of changing sign with SymbolicSum", GeneralAgreeQ[MBEvaluate[I BarnesKernel (1 - 2 x)^z, {ep, 0},
    Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True], 1 - 2 x, {1/4, 3/4, -1}]];
  Check1["any x: no condition for the base 2 x with SymbolicSum", GeneralAgreeQ[MBEvaluate[I BarnesKernel (2 x)^z, {ep, 0},
    Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True], 2 x, {1/4, 3/4, 2, -1}]]];
Do[If[MethodQ[M],
    Check1["a negative base with " <> M <> ": exact where it holds", ClaimedAgreeQ[MBEvaluate[I BarnesKernel (-2 x)^z,
      {ep, 0}, Method -> M, BarnesReduce -> False, Complex -> True], -2 x, {-1/4, -2}, {1/3, 2}]];
    Check1["a base of changing sign with " <> M <> ": exact where it holds", ClaimedAgreeQ[MBEvaluate[I BarnesKernel (1 - 2 x)^z,
      {ep, 0}, Method -> M, BarnesReduce -> False, Complex -> True], 1 - 2 x, {1/4, -1}, {3/4}]];
    Check1["the base 2 x with " <> M <> ": exact where it holds", ClaimedAgreeQ[MBEvaluate[I BarnesKernel (2 x)^z,
      {ep, 0}, Method -> M, BarnesReduce -> False, Complex -> True], 2 x, {1/4, 3/4, 2}, {-1}]]],
  {M, {"ExpandInt", "Subtraction"}}];
(* G3. independent powers keep their phases (review of 07d9877): Gamma[-s]^3 Gamma[1 + s]^3 times x^s y^s, (x y)^s,
   x^(2 s), (x^2)^s and x^-s against the contour integral with the principal powers on Re s = -1/2, at 40 digits.  Every
   value that a result claims is exact.  SymbolicSum writes these values in the logarithms of the bases, which hold for
   every value; at 07d9877 its Log[1/(x y)] gave Pi^2/4 at x = y = -1, where the integral is -3 Pi^2/4.  The G functions
   of ExpandInt and Subtraction carry the condition that every base is positive, and are Undefined at negative bases;
   at 07d9877 ExpandInt gave 5 Pi^2/4 for x^(2 s) at x = -1 *)
BranchKernel = Gamma[-s]^3 Gamma[1 + s]^3;
BranchContour[Pow_, Pt_] := BranchContour[Pow, Pt] = NIntegrate[Evaluate[(BranchKernel Pow) /. s -> -1/2 + I t /. Pt],
  {t, -Infinity, Infinity}, WorkingPrecision -> 40, PrecisionGoal -> 20, MaxRecursion -> 40]/(2 Pi);
BranchCases = {
  {x^s y^s, Exp[s (Log[x] + Log[y])], {{x -> -1, y -> -1}, {x -> -1, y -> 1/2}, {x -> -1/2, y -> -3}, {x -> 2, y -> 3}}},
  {(x y)^s, Exp[s Log[x y]], {{x -> -1, y -> -1}, {x -> -1, y -> 1/2}, {x -> 1/2, y -> 3}}},
  {x^(2 s), Exp[2 s Log[x]], {{x -> -1}, {x -> -1/2}, {x -> 3}}},
  {(x^2)^s, Exp[s Log[x^2]], {{x -> -1}, {x -> -1/2}, {x -> 1/3}}},
  {x^-s, Exp[-s Log[x]], {{x -> -2}, {x -> 1/3}, {x -> 4}}}};
(* at each point: True or False for a value of the result against the contour, Undefined where the result does not
   hold or has no value (a letter of a G function that is infinite there, such as 1/(x^2 - 1) at x = -1) *)
BranchClaimed[R_, Pow_, Pts_] := Map[Function[Pt, Module[{V = R /. Pt, Num},
  Num = If[V === Undefined, $Failed, Quiet[MBAnalytica`Private`NumericValue[V]]];
  Which[! NumberQ[Num], Undefined, Abs[Num - BranchContour[Pow, Pt]] < 10^-15, True, True, False]]], Pts];
Do[If[MethodQ[M], Do[With[{C1 = C2},
      Check1["phases of independent powers, " <> ToString[C1[[1]], InputForm] <> " with " <> M,
        Module[{R = MBEvaluate[BranchKernel C1[[1]], {ep, 0}, Method -> M, BarnesReduce -> False, Complex -> True], V},
          (* Subtraction refuses (x y)^s and (x^2)^s, which is no wrong value *)
          If[R === $Failed, M === "Subtraction" && MemberQ[{(x y)^s, (x^2)^s}, C1[[1]]],
            V = BranchClaimed[R, C1[[2]], C1[[3]]];
            ! MemberQ[V, False] && MemberQ[V, True] && If[M === "SymbolicSum", FreeQ[V, Undefined], True]]]]],
      {C2, BranchCases}]],
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
(* R4.2 the private names are free of the regulator and of the assumptions: an assumption on a symbol of the name that
   z2 gets restricted z2, and a regulator of that name became z2 (review of 07d9877) *)
If[MethodQ["SymbolicSum"],
  Check1["private name of a parameter in the assumptions", Module[{Alias, R1, R2},
    Alias = Last[First[MBAnalytica`Private`UserSymbolRules[Global`z2 BarnesKernel, Automatic, ep]]];
    MBEvaluate[Global`z2 BarnesKernel, {ep, 0}, Method -> "SymbolicSum", Complex -> True];
    R1 = MBEvaluate[I Log[1 - Global`z2] BarnesKernel, {ep, 0}, Method -> "SymbolicSum",
      ParameterAssumptions -> {Global`z2 > 0, Alias < 1}];
    R2 = MBEvaluate[Global`z2 BarnesKernel, {ep, 0}, Method -> "SymbolicSum", Complex -> True,
      ParameterAssumptions -> {Global`z2 > 1, Alias < 0}];
    Abs[N[R1 /. Global`z2 -> 2] + Pi/2] < 10^-12 && R2 === Global`z2/2]];
  Check1["private name of a parameter as the regulator", Module[{Alias},
    Alias = Last[First[MBAnalytica`Private`UserSymbolRules[Global`z2 BarnesKernel, Automatic, ep]]];
    MBEvaluate[Global`z2 BarnesKernel, {Alias, 0}, Method -> "SymbolicSum", Complex -> True] === Global`z2/2]];
  (* R4.5 the markers LinInf and sinf of EvaluateMultiSums as parameter names *)
  Check1["parameters named LinInf and sinf", MBEvaluate[Global`LinInf BarnesKernel, {ep, 0}, Method -> "SymbolicSum",
    Complex -> True] === Global`LinInf/2 && MBEvaluate[Global`sinf BarnesKernel, {ep, 0}, Method -> "SymbolicSum",
    Complex -> True] === Global`sinf/2];
  (* R4.3 the contour values and the solutions are kept per probe and domain: in one kernel the closed form 1/(1 + y) at
     the probe y = 1/3 was compared with the contour value 3/5 of the probe y = 2/3 of the previous call and refused *)
  Check1["a change of domain in one kernel", Block[{$ContextPath = MBAnalytica`Private`SymbolicSumContextPath,
      MBAnalytica`SymbolicSum`Private`MBCHVerifyDiff = True},
    AllTrue[{{0 < x < Global`y < 1, True}, {0 < Global`y < x < 1, False}, {0 < x < Global`y < 1, True}}, Function[A1,
      Simplify[MBAnalytica`SymbolicSum`MBCH2MPL[Gamma[-z] Gamma[1 + z] Global`y^z, {x, Global`y}, {ep, 0},
        Complex -> A1[[2]], "ParameterAssumptions" -> A1[[1]]] - 1/(1 + Global`y)] === 0]]]];
  (* R4.4 the points of a domain: exact points of a thin domain, and the tuples generated one at a time *)
  Check1["domain points of a thin domain", With[{P = MBAnalytica`SymbolicSum`Private`DomainPoints[
      0 < Global`u < 1 && 0 < Global`v < 1 && 0 < Global`u - Global`v < 1/10^6, {Global`u, Global`v}, 2]},
    P =!= {} && AllTrue[P, VectorQ[#, MatchQ[#, _Integer | _Rational] &] &&
      TrueQ[0 < #[[1]] < 1 && 0 < #[[2]] < 1 && 0 < #[[1]] - #[[2]] < 1/10^6] &]]];
  Check1["domain points of 18 variables", With[{Vs = Table[Symbol["Global`vv" <> ToString[K1]], {K1, 18}]},
    With[{Cond = (And @@ Map[0 < # < 1 &, Vs]) && Vs[[1]] > Vs[[2]]},
      First[AbsoluteTiming[MBAnalytica`SymbolicSum`Private`DomainPoints[Cond, Vs, 1]]] < 1 &&
        First[AbsoluteTiming[MBAnalytica`Private`DomainProbes[Cond, Vs]]] < 1 &&
        Length[MBAnalytica`Private`DomainProbes[Cond, Vs]] === 2]]];
  (* R4.6 the continuation along |P| = 1 needs the modulus of a complex coefficient: Log[1 + 2 I P] winds around 0 and
     was continued to Log[1 - 2 I] without its 2 Pi I; it is refused, and Log[1 + I P/2] keeps its principal value *)
  Check1["phase continuation with complex coefficients", Block[{MBAnalytica`SymbolicSum`Private`MBCHScale = {},
      MBAnalytica`SymbolicSum`Private`MBCHDomain = True, MBAnalytica`SymbolicSum`Private`MBCHPhaseRegion = True},
    MBAnalytica`SymbolicSum`Private`PhaseContinue[Log[1 + 2 I Global`MBSymbolicSumPhase]] === $Failed &&
      MBAnalytica`SymbolicSum`Private`PhaseContinue[PolyLog[2, 2 I Global`MBSymbolicSumPhase]] === $Failed &&
      MBAnalytica`SymbolicSum`Private`PhaseContinue[Log[1 + I/2 Global`MBSymbolicSumPhase]] === Log[1 - I/2] &&
      MBAnalytica`SymbolicSum`Private`PhaseContinue[PolyLog[2, I/2 Global`MBSymbolicSumPhase]] === PolyLog[2, -I/2]]]];
(* R5.1 a prefactor keeps the branch the user wrote: inside the methods Log[-x] became Log[x] + I Pi, exact on the
   derivation domain 0 < x < 1, and was continued to every x, I Pi at x = -1 where the integrand vanishes (review of
   5045340).  The references are independent: the Barnes integral of BarnesKernel is 1/2, and that of BarnesKernel x^z
   is (1 - x + x Log[x])/(1 - x)^2 *)
If[MethodQ["SymbolicSum"],
  Check1["prefactor Log[-x] keeps its branch", With[{R = MBEvaluate[Log[-x] x^ep BarnesKernel, {ep, 0}, Method -> "SymbolicSum",
      Complex -> True]},
    Simplify[R - Log[-x]/2] === 0 && (R /. x -> -1) === 0]];
  Check1["prefactor Log[-x], real part", With[{R = MBEvaluate[Log[-x] x^ep BarnesKernel, {ep, 1}, Method -> "SymbolicSum"]},
    FreeQ[R, ConditionalExpression] && (R /. x -> -1) === 0 && Simplify[(R /. x -> 2) - (Log[2]/2 + ep Log[2]^2/2)] === 0]];
  Check1["prefactor Log[-x] with a power of x", With[{R = MBEvaluate[Log[-x] x^z BarnesKernel, {ep, 0}, Method -> "SymbolicSum",
      BarnesReduce -> False, Complex -> True], Ref = Log[-x] (1 - x + x Log[x])/(1 - x)^2},
    AllTrue[{-1/2, 1/3, 3}, Abs[N[(R - Ref) /. x -> #, 30]] < 10^-25 &]]];
  Check1["prefactor Sqrt[-x]", MBEvaluate[Sqrt[-x] x^ep BarnesKernel, {ep, 0}, Method -> "SymbolicSum", Complex -> True] ===
    Sqrt[-x]/2];
  (* the real part is that of the product: the methods took the real part of the rest, I/2, and the result was 0 *)
  Check1["complex prefactor on a given domain", With[{R = MBEvaluate[I Log[1 - x] BarnesKernel, {ep, 0}, Method -> "SymbolicSum",
      ParameterAssumptions -> {x > 0}]},
    AllTrue[{1/2, 2, 5}, Abs[N[(R + Arg[1 - x]/2) /. x -> #, 30]] < 10^-25 &] && Abs[N[R /. x -> 2] + Pi/2] < 10^-12]];
  Check1["a logarithm inside a sum keeps a condition", With[{R = MBEvaluate[(Log[-x] + ep) x^z BarnesKernel, {ep, 0},
      Method -> "SymbolicSum", BarnesReduce -> False, Complex -> True]},
    Head[R] === ConditionalExpression && (R /. x -> -1/2) === Undefined &&
      Abs[N[(R - Log[-x] (1 - x + x Log[x])/(1 - x)^2) /. x -> 1/2, 30]] < 10^-25]];
  (* R5.4 a skipped verification is no contour value: cached as $Failed while MBCHVerifyDiff = False, it was returned after
     MBCHVerifyDiff = True in the same kernel (review of 5045340).  The contour value of Gamma[-s] Gamma[1 + s] x^s at
     x = 1/2 is 2/3 *)
  Check1["verification enabled after a skip in one kernel", Block[{$ContextPath = MBAnalytica`Private`SymbolicSumContextPath,
      MBAnalytica`SymbolicSum`Private`MBCHScale = {Global`x}, MBAnalytica`SymbolicSum`Private`MBCHDomain = 0 < Global`x < 1,
      MBAnalytica`SymbolicSum`Private`MBCHProbePoint = {1/2}, MBAnalytica`SymbolicSum`Private`MBVerifyCache = <||>,
      MBAnalytica`SymbolicSum`Private`MBCHVerifyDiff = False, MBAnalytica`SymbolicSum`Private`MBCHPhaseUsed = False,
      MBAnalytica`SymbolicSum`Private`MBCHPhaseContour = False, MBAnalytica`SymbolicSum`Private`MBCHNegativeBases = {},
      MBAnalytica`SymbolicSum`Private`MBCHNumTime = 30},
    Module[{Off1, On1},
      Off1 = MBAnalytica`SymbolicSum`Private`MBVerify[{Global`s -> -1/2}, {Global`x}, {-Global`s, 1 + Global`s}, {}];
      MBAnalytica`SymbolicSum`Private`MBCHVerifyDiff = True;
      On1 = MBAnalytica`SymbolicSum`Private`MBVerify[{Global`s -> -1/2}, {Global`x}, {-Global`s, 1 + Global`s}, {}];
      Off1 === $Failed && NumericQ[On1] && Abs[On1 - 2/3] < 10^-15]]]];
(* R6.4 the prefactor is classified by its structure: Together built the common denominator of 100 logarithms over x + k
   first and took more than 15 s (review of c51fb0a).  A sum or product of rational terms and an integer power of one
   stay rational, anything else is taken out as written *)
Check1["prefactor of 100 logarithms classified at once", With[{P100 = Sum[Log[1 + K1 x]/(x + K1), {K1, 1, 100}]},
  With[{T = AbsoluteTiming[MBAnalytica`Private`RationalFunctionQ[P100, {x}]]}, T[[1]] < 1 && T[[2]] === False]]];
Check1["rational sums stay rational", MBAnalytica`Private`RationalFunctionQ[(1 + x)/(x^2 + 3) + x^2/(x - 2) + Log[2] x, {x}] &&
  MBAnalytica`Private`RationalFunctionQ[((1 + x) (2 - x))^-3, {x}] && ! MBAnalytica`Private`RationalFunctionQ[Sqrt[x^2], {x}] &&
  ! MBAnalytica`Private`RationalFunctionQ[x + Log[x], {x}] && MBAnalytica`Private`RationalFunctionQ[Pi^2/6, {x}]];
If[MethodQ["SymbolicSum"],
  Check1["prefactor of 100 logarithms", With[{P100 = Sum[Log[1 + K1 x]/(x + K1), {K1, 1, 100}]},
    Expand[MBEvaluate[P100 BarnesKernel, {ep, 0}, Method -> "SymbolicSum", Complex -> True] - P100/2] === 0]]];
(* R6.6 the coefficients after the pushes in one pass, in a topological order of the oriented tree: the same sums as the
   NV rounds of propagation of c51fb0a (copied below), for every orientation and push map of a star and a branched tree,
   and the same first push of a chain of 14 vertices (review of c51fb0a) *)
OldCosmoPushed[Edges_List, Push_List, C0_List] := Module[{Cs, Prev, Earlier},
  Cs = C0;
  Prev = C0;
  Do[Cs = C0;
    Do[If[Push[[V]] =!= 0, Earlier = First[DeleteCases[Edges[[Push[[V]]]], V]]; Cs[[Earlier]] = Cs[[Earlier]] + Prev[[V]]],
      {V, Length[C0]}];
    Prev = Cs, {Length[C0]}];
  Cs];
Check1["cosmological pushes in one pass", AllTrue[{Table[{1, K1}, {K1, 2, 6}], {{1, 2}, {2, 3}, {2, 4}, {4, 5}, {4, 6}, {1, 7}}},
  Function[Edges, Module[{NV = Max[Flatten[Edges]], C0},
    C0 = Array[Symbol["Global`cc" <> ToString[#]] &, NV];
    AllTrue[Tuples[{1, 2}, Length[Edges]], Function[Orient, Module[{Later, Order1},
      Later = MapThread[#1[[#2]] &, {Edges, Orient}];
      Order1 = MBAnalytica`Private`CosmoPushOrder[Edges, Later, NV];
      AllTrue[Tuples[Table[Join[{0}, Select[Range[Length[Edges]], Later[[#]] === V &]], {V, NV}]], Function[P1,
        Expand[MBAnalytica`Private`CosmoPushed[Edges, P1, C0] - OldCosmoPushed[Edges, P1, C0]] === ConstantArray[0, NV] &&
          Expand[MBAnalytica`Private`CosmoPushed[Edges, P1, C0, Order1] - OldCosmoPushed[Edges, P1, C0]] === ConstantArray[0, NV]]]]]]]]]];
Check1["first push of a chain of 14 vertices", With[{N1 = 14}, MBAnalytica`Private`CosmoPushChoices[Table[{J1, J1 + 1}, {J1, N1 - 1}],
    Range[N1 - 1], Join[ConstantArray[1, N1 - 1], {N1^2}], Table[N1^2 - 2 (J1 - 1), {J1, N1 - 1}], {},
    Join[ConstantArray[1, N1 - 1], {N1^2}], Table[N1^2 - 2 (J1 - 1), {J1, N1 - 1}], {}, 1] === {Join[Range[12], {0, 0}]}]];
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
  (* R4.5B an exact endpoint coefficient is zero only exactly: the coefficient 1/10^13 passed the bound 10^-12 and the
     divergent integral of (G[0,x] - G[1,x])/(10^13 x) got the value Pi^2/(6 10^13) (review of 07d9877) *)
  Check1["last folds: a small exact divergence refused", Module[{Gnum, Fold1},
    Gnum[E1_] := N[E1 /. {HoldPattern[PolyLogTools`G[0, A_]] :> Log[A], HoldPattern[PolyLogTools`G[1, A_]] :> Log[1 - A],
      HoldPattern[PolyLogTools`G[0, 0, A_]] :> Log[A]^2/2, HoldPattern[PolyLogTools`G[0, 1, A_]] :> -PolyLog[2, A]}, 40];
    Fold1[F_] := MBAnalytica`Private`WithoutSymbolicSumRules[Block[{MBExactLastFold`Private`gatePts = {1/3, 2/3}},
      KeyTake[MBExactLastFold`mbeLastFoldIntegrate[F, {}, x, Gnum], {"Status", "Value"}]]];
    Fold1[(PolyLogTools`G[0, x] - PolyLogTools`G[1, x])/(10^13 x)]["Status"] === "ZERO_NONCANCEL" &&
      Fold1[-PolyLogTools`G[1, x]/(10^13 x)] === <|"Status" -> "ok", "Value" -> Pi^2/(6 10^13)|>]];
  (* R4.5A a corner through pole faces where a face variable stays away from its end: the maximal faced corner alone
     missed it, and the cube gave 0 instead of 1/(5 eps^3) (review of 07d9877) *)
  Check1["corner letters: a face variable away from its end", Sort[Global`fcuCornerLetters[x^(-1 + ep) z^(-1 + ep) y^4*
      (x + y^2)^(-2 + ep) (x z + y)^(-1 + ep), {x, y, z}, ep]] === Sort[{x + y^2, y + x z}]];
  Check1["cube with that corner refused", FailureQ[MBAnalytica`Private`WithoutSymbolicSumRules[MBParameterSubtraction`PSPrepareCube[
    <|"Cube" -> x^(-1 + ep) z^(-1 + ep) y^4 (x + y^2)^(-2 + ep) (x z + y)^(-1 + ep), "Variables" -> {x, y, z}, "Prefactor" -> 1|>,
    ep, -3, -3, {}]]]];
  (* R4.4A the source gate on a domain that no grid point reaches *)
  Check1["source-gate points of a thin domain", With[{P = MBParameter`Private`parameterPoints[{Global`u, Global`v},
      0 < Global`u < 1 && 0 < Global`v < 1 && 0 < Global`u - Global`v < 1/100]},
    Length[P] === 2 && AllTrue[P, TrueQ[(0 < Global`u < 1 && 0 < Global`v < 1 && 0 < Global`u - Global`v < 1/100) /. #] &]]];
  If[MethodQ["ExpandInt"],
    Check1["ExpandInt on a thin domain", With[{R = MBEvaluate[Gamma[-s] Gamma[1 + s] Gamma[-t] Gamma[1 + t]*
        Gamma[1 + s + t]/Gamma[2 + s + t] Global`u^s Global`v^t, {ep, 0}, Method -> "ExpandInt",
        ParameterAssumptions -> {0 < Global`u < 1, 0 < Global`v < 1, 0 < Global`u - Global`v < 1/100}]},
      R =!= $Failed && Abs[MBAnalytica`Private`NumericValue[R /. {Global`u -> 1/2, Global`v -> 99/200}] -
        N[(Log[3/2] - Log[299/200])/(1/200), 30]] < 10^-15]]];
  (* R5.2 a square factor comes out of a root only with a fixed sign on 0 < x < 1, 0 < u < 1: (1 - 2 x)^2 was read at
     x = 1/2 and came out as 0, and the finite integral of (2 y + 4)/((y + 2)^2 - u (1 - 2 x)^2) over the unit square got
     2 Log[3/2] instead of Log[(9 - u)/(4 - u)] + 6/Sqrt[u] ArcTanh[Sqrt[u]/3] - 4/Sqrt[u] ArcTanh[Sqrt[u]/2] (review of
     5045340).  It is now refused or exact *)
  Check1["last folds: square factors with a zero stay in the root", Block[{MBExactLastFold`Private`xv = x},
    With[{A = MBExactLastFold`Private`squareSplit[Global`psParameter1 (1 - 2 x)^2],
        B = MBExactLastFold`Private`squareSplit[Global`psParameter1 (1 - x)^2 x^2 (3 - x)^2]},
      A[[1]] === 1 && Expand[A[[2]] - Global`psParameter1 (1 - 2 x)^2] === 0 &&
        Expand[B[[1]] - (1 - x) x (3 - x)] === 0 && B[[2]] === Global`psParameter1]]];
  Check1["last folds: a finite integral through a square root", Module[{Dir = CreateDirectory[], R, U0, Ref},
    Export[FileNameJoin[{Dir, "requests.json"}], <|"jobs" -> {<|"id" -> "square_split", "request" -> <|"op" -> "hyperflint",
        "expr" -> "(2*y+4)/((y+2)^2-psParameter1*(1-2*x)^2)", "vars_int" -> {"y", "x"}, "vars" -> {"y", "x", "psParameter1"},
        "vars_int_from" -> {"0", "0"}, "vars_int_to" -> {"1", "1"}, "native_unit_interval" -> True, "check_divergences" -> True,
        "algebraic_letters" -> True, "spectator_algebraic_letters" -> True, "canonical_emission" -> True,
        "mzv_data_path" -> FileNameJoin[{TestRoot, "dep", "IntVolFLINT", "data", "mzv_reductions.json"}]|>,
        "orders" -> {{"y", "x"}}|>}|>, "RawJSON"];
    R = MBAnalytica`Private`WithoutSymbolicSumRules[Block[{$ContextPath = Prepend[$ContextPath, "PolyLogTools`"]},
      MBExactLastFold`mbeExactLastFold[Dir, "square_split", "Write" -> False, "EngineSeconds" -> 120, "RequireCertificate" -> True,
        "CrossCheck" -> False, "Log" -> (Null &)]]];
    AssociationQ[R] && StringQ[R["Status"]] && (R["Status"] =!= "LASTFOLD_DONE" ||
      (U0 = R["ValueAt"]["u"];
       Ref = Log[(9 - U0)/(4 - U0)] + 6/Sqrt[U0] ArcTanh[Sqrt[U0]/3] - 4/Sqrt[U0] ArcTanh[Sqrt[U0]/2];
       Abs[ToExpression[R["ValueAt"]["numeric"]] - N[Ref, 40]] < 10^-20))]];
  (* R5.1 the engine methods solve the integral without its prefactor: with Log[-x] in it they refused every order *)
  Do[If[MethodQ[M],
      Check1["prefactor Log[-x] with " <> M, With[{R = MBEvaluate[Log[-x] x^ep BarnesKernel, {ep, 1}, Method -> M]},
        (R /. x -> -1) === 0 && Simplify[(R /. x -> 2) - (Log[2]/2 + ep Log[2]^2/2)] === 0]]],
    {M, {"ExpandInt", "Subtraction"}}];
  (* R6.1 points with distinct coordinates for any number of parameters: with nine, only diagonal points were left, u = v,
     where the candidates of (Log[1 + u] - Log[1 + v])/(u - v) have a removable singularity, and ExpandInt refused the
     integral (review of c51fb0a).  Up to eight parameters the points are those of before *)
  Check1["source-gate points with distinct coordinates for 9 to 12 parameters", AllTrue[Range[9, 12], Function[N1,
    With[{Ps = Array[Symbol["Global`pp" <> ToString[#]] &, N1]}, With[{Dom = And @@ Map[0 < # < 1 &, Ps]},
      With[{P = MBParameter`Private`parameterPoints[Ps, Dom]},
        Length[P] === 2 && AllTrue[P, DuplicateFreeQ[Values[#]] && TrueQ[Dom /. #] &]]]]]]];
  Check1["source-gate points of eight parameters as before", With[{Ps = Array[Symbol["Global`pp" <> ToString[#]] &, 8]},
    Map[Values, MBParameter`Private`parameterPoints[Ps, And @@ Map[0 < # < 1 &, Ps]]] ===
      {{1/3, 2/5, 3/7, 4/9, 5/11, 6/13, 7/15, 8/17}, {1/2, 2/7, 3/8, 2/9, 5/12, 3/10, 4/11, 5/13}}]];
  If[MethodQ["ExpandInt"],
    Check1["ExpandInt with nine parameters", Module[{Ps, W1, R},
      Ps = Join[{Global`u, Global`v}, Array[Symbol["Global`ww" <> ToString[#]] &, 7]];
      W1 = Times @@ Drop[Ps, 2];
      R = MBEvaluate[W1 Gamma[-s] Gamma[1 + s] Gamma[-t] Gamma[1 + t] Gamma[1 + s + t]/Gamma[2 + s + t] Global`u^s Global`v^t,
        {ep, 0}, Method -> "ExpandInt", Complex -> True, ParameterAssumptions -> And @@ Map[0 < # < 1 &, Ps]];
      R =!= $Failed && Abs[MBAnalytica`Private`NumericValue[(R - W1 (Log[1 + Global`u] - Log[1 + Global`v])/(Global`u - Global`v)) /.
        Thread[Ps -> Range[9]/23]]] < 10^-20]]];
  (* R6.2 the Newton expansion of a Barnes polynomial through its degree: (v+1)...(v+41) gave 41 zeros, and the reduction
     of P Gamma[1 + v]^2 Gamma[1 - v]^2/(41! 10^13), whose value is 42/(43 44 10^13) by Barnes' first lemma, returned no
     term (review of c51fb0a) *)
  Check1["Newton expansions of degree 40 and 41", AllTrue[{40, 41}, Function[D1, With[{P = Product[Global`vv + 1 + J1, {J1, 0, D1 - 1}]},
      With[{C1 = Global`mbeBPRNewton[P, Global`vv, 1]}, ListQ[C1] && Length[C1] === D1 + 1 &&
        Expand[P - Sum[C1[[K1 + 1]] Product[Global`vv + 1 + J1, {J1, 0, K1 - 1}], {K1, 0, Length[C1] - 1}]] === 0]]]] &&
    Global`mbeBPRNewton[Global`vv + Log[Global`vv], Global`vv, 1] === $Failed];
  Check1["Barnes reduction of a degree-41 polynomial", With[{R = Global`mbeBPRReduceVar[Product[Global`vv + 1 + J1, {J1, 0, 40}]*
      Gamma[1 + Global`vv]^2 Gamma[1 - Global`vv]^2/(41! 10^13), Global`vv, {Global`vv}, {Global`vv -> -1/2}]},
    ListQ[R] && Together[Total[R] - 42/(43 44 10^13)] === 0]];
  (* R6.3 a root is merged with a registered one only through the ratio of the principal roots: with -u registered first,
     Sqrt[u] became I Sqrt[-u] = -Sqrt[u] (review of c51fb0a) *)
  Check1["last folds: principal roots in either order", Module[{U = Global`psParameter1, A, B, Back},
    Back[E1_] := (E1 /. MBExactLastFold`Private`backRules[]) /. U -> 1/3;
    MBExactLastFold`mbeLastFoldFibrate[0, x, U/2];
    A = MBExactLastFold`Private`sqSym[-U];
    B = MBExactLastFold`Private`sqSym[U];
    With[{Neg = {Back[A], Back[B]}},
      MBExactLastFold`mbeLastFoldFibrate[0, x, U/2];
      B = MBExactLastFold`Private`sqSym[U];
      A = MBExactLastFold`Private`sqSym[-U];
      Simplify[Neg - {I/Sqrt[3], 1/Sqrt[3]}] === {0, 0} && Simplify[{Back[A], Back[B]} - {I/Sqrt[3], 1/Sqrt[3]}] === {0, 0}]]];
  Check1["last folds: a fibration through both roots", With[{R = MBAnalytica`Private`WithoutSymbolicSumRules[MBExactLastFold`mbeLastFoldFibrate[
      Sqrt[-Global`psParameter1] + 2 Sqrt[Global`psParameter1], x, Global`psParameter1/2]]},
    Simplify[((R["Sfib"] /. R["RootBack"]) /. Global`psParameter1 -> 1/3) - (2 + I)/Sqrt[3]] === 0]];
  (* R6.5 the keys of the pieces carry the code of the engine: a value computed before a fix of the solvers was served
     after it, with the same key for 5045340 and c51fb0a (review of c51fb0a) *)
  Check1["piece keys change with the code of the engine", Module[{Dir = CreateDirectory[], Src, A, B},
    Src = MBAnalytica`SymbolicInt`Private`$mbtSourceDirectory;
    Scan[CopyFile[#, FileNameJoin[{Dir, FileNameTake[#]}]] &, FileNames["mbe*Barnes*.m", Src]];
    A = MBAnalytica`SymbolicInt`Private`mbtCodeStateOf[Dir];
    With[{St = OpenAppend[FileNameJoin[{Dir, "mbeBarnesPreReduce.m"}]]}, WriteString[St, "\n(* a fix *)\n"]; Close[St]];
    B = MBAnalytica`SymbolicInt`Private`mbtCodeStateOf[Dir];
    MBAnalytica`SymbolicInt`Private`$mbtCacheVersion === 6 && A =!= B &&
      MBAnalytica`SymbolicInt`Private`mbtFingerprintOf[A] =!= MBAnalytica`SymbolicInt`Private`mbtFingerprintOf[B] &&
      MBAnalytica`SymbolicInt`Private`mbtNativeFingerprint[] ===
        MBAnalytica`SymbolicInt`Private`mbtFingerprintOf[MBAnalytica`SymbolicInt`Private`mbtCodeState[]]]];
  (* R5.3 a divergent endpoint coefficient is zero only exactly, or for a certified job by the numbers: the constant
     G[0, 1 + 1/10^13] = Log[1 + 1/10^13] passed as zero through a scale with its G set to 1, and the divergent integral of
     G[0, 1 + 1/10^13] (G[0, x] - G[1, x])/x got Pi^2 G[0, 1 + 1/10^13]/6 (review of 5045340) *)
  Check1["last folds: a small constant is no zero", Module[{Gnum, Fold1, C1 = PolyLogTools`G[0, 1 + 1/10^13]},
    Gnum[E1_] := N[E1 /. {HoldPattern[PolyLogTools`G[0, A_]] :> Log[A], HoldPattern[PolyLogTools`G[1, A_]] :> Log[1 - A],
      HoldPattern[PolyLogTools`G[0, 0, A_]] :> Log[A]^2/2, HoldPattern[PolyLogTools`G[0, 1, A_]] :> -PolyLog[2, A]}, 40];
    Fold1[F_] := MBAnalytica`Private`WithoutSymbolicSumRules[Block[{MBExactLastFold`Private`gatePts = {1/3, 2/3}},
      KeyTake[MBExactLastFold`mbeLastFoldIntegrate[F, {}, x, Gnum], {"Status", "Value"}]]];
    MBAnalytica`Private`WithoutSymbolicSumRules[MBExactLastFold`Private`endpointZeroQ[C1, Gnum]] === False &&
      Fold1[C1 (PolyLogTools`G[0, x] - PolyLogTools`G[1, x])/x]["Status"] === "ZERO_NONCANCEL" &&
      Fold1[-C1 PolyLogTools`G[1, x]/x] === <|"Status" -> "ok", "Value" -> Pi^2 C1/6|>]];
  Check1["last folds: identities of G functions of the parameter", Module[{U = Global`psParameter1, G1, G2, Z, Id},
    G1 = MBExactLastFold`Private`makeGnum[1/3];
    G2 = MBExactLastFold`Private`makeGnum[2/7];
    Z[E1_, Cert_] := MBAnalytica`Private`WithoutSymbolicSumRules[Block[{$ContextPath = Prepend[$ContextPath, "PolyLogTools`"],
        MBExactLastFold`Private`endpointCertified = Cert, MBExactLastFold`Private`endpointExtraGnums = {G2}},
      MBExactLastFold`Private`endpointZeroQ[E1, G1]]];
    (* Log[1 - u/2] + Log[2/(2 - u)] = 0 *)
    Id = PolyLogTools`G[1, U/2] + PolyLogTools`G[2 (-1 + U/2)/U, 1];
    Z[Id, True] === True && Z[Id, False] === False &&
      Z[PolyLogTools`G[1, U/2] - PolyLogTools`G[2 (-1 + U/2)/U, 1], True] === False &&
      Z[PolyLogTools`G[1, U/2] - PolyLogTools`G[1, U/2 + 1/10^20], True] === False &&
      Z[PolyLogTools`G[1, U/2]/10^40, True] === False && Z[PolyLogTools`G[0, 1, 1] + Pi^2/6, False] === True]];
  (* R5.5 a claim is its holder's PID and start time: one with the PID of this kernel and another start time, of an
     earlier process, was waited for until the wait limit, four hours by default, and so was a live claim of this kernel
     itself, which no other process can finish (review of 5045340) *)
  If[TrueQ[Global`$orsInstalled],
    Check1["residue store: stale and own claims with the PID of this kernel", Module[{Dir = CreateDirectory[], Case1, A, B, C},
      Case1[Key_, Pid_, Started_] := Module[{Claim = FileNameJoin[{Dir, Key <> ".claim"}], Calls = 0, T, R},
        CreateDirectory[Claim];
        Export[FileNameJoin[{Claim, "owner"}], ToString[Pid] <> "|" <> Started, "Text"];
        {T, R} = AbsoluteTiming[Global`orsStoredCall[Key, (Calls++; {7}), MatchQ[#, {7}] &, False]];
        {R, Calls, T, DirectoryQ[Claim], FileExistsQ[FileNameJoin[{Dir, Key <> ".wxf"}]]}];
      Block[{Global`$oftResidueStore = Dir, Global`$oftClaimWaitLimit = 30, Global`$oftClaimPoll = 1/10,
          Global`$orsHelperMode = False},
        A = Case1["stale", $ProcessID, "Thu Jan  1 00:00:00 1970"];
        B = Case1["dead", 999999999, "Thu Jan  1 00:00:00 1970"];
        C = Case1["own", $ProcessID, Global`orsStartTime[$ProcessID]]];
      (* released and stored at once; released and stored; closed at once and left to its holder *)
      A[[1 ;; 2]] === {{7}, 1} && A[[3]] < 10 && ! A[[4]] && A[[5]] && B[[1 ;; 2]] === {{7}, 1} && ! B[[4]] && B[[5]] &&
        C[[1 ;; 2]] === {{7}, 1} && C[[3]] < 10 && C[[4]] && ! C[[5]]]]];
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
