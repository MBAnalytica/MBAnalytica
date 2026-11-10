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
