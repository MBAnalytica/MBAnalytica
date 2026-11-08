#!/usr/bin/env wolframscript
(* ::Package:: *)
(* MBAnalytica installation test (make test): loads the package by name, as every Mathematica session does after
   make install (the package of this folder when it is not yet on the $Path of Mathematica), reports the
   dependencies, and evaluates the integrals of tests/reference/InstallReference.m with every method available on
   this machine: J exactly, and 2F1 numerically at two values of its kinematic variable.  Exit code 0 when every
   available method returns every result. *)

SetOptions[$Output, PageWidth -> Infinity];
TestRoot = ParentDirectory[DirectoryName[ExpandFileName[First[Select[$ScriptCommandLine, StringEndsQ[#, "InstallTest.wls"] &]]]]];
TestPackage = FileNameJoin[{TestRoot, "MBAnalytica.wl"}];
(* the file that << MBAnalytica.wl loads in a session outside this folder: without ".", the current directory on
   $Path, which is this folder while make runs *)
TestFound = Block[{$Path = DeleteCases[$Path, "."]}, FindFile["MBAnalytica.wl"]];
Which[
  TestFound === $Failed,
    Print["MBAnalytica.wl is not on the $Path of Mathematica yet (make install adds it): the package of this folder is tested."];
    Get[TestPackage],
  ExpandFileName[TestFound] =!= TestPackage,
    Print["<< MBAnalytica.wl loads ", TestFound, " instead of ", TestPackage,
      ": another copy comes earlier on the $Path of Mathematica."];
    Exit[1],
  True,
    Print["<< MBAnalytica.wl loads ", TestFound];
    Get[TestFound]];
Print[""];
TestCheck = MBAnalyticaCheck[];
Print[""];

TestReferences = Block[{$ContextPath = {"System`"}}, Get[FileNameJoin[{TestRoot, "tests", "reference", "InstallReference.m"}]]];
TestMethods = TestCheck["Methods"];
If[TestMethods === {},
  Print["No method can run on this machine; see the report above."];
  Exit[1]];
(* the numerical comparison evaluates G functions with GiNaC through PolyLogTools, which the methods ExpandInt and
   Subtraction load *)
TestNumericQ = IntersectingQ[TestMethods, {"ExpandInt", "Subtraction"}];

(* a coefficient at a value of the kinematic variable, through ginsh (PolyLogTools` on the context path: ginsh
   rejects a G written with its context) *)
TestNumber[Expr_, Var_, Value_] := Module[{Value1},
  If[FreeQ[Expr, PolyLogTools`G], Return[N[Expr /. Var -> Value, 30]]];
  Value1 = Block[{$ContextPath = Prepend[$ContextPath, "PolyLogTools`"]},
    Quiet[Check[PolyLogTools`Ginsh[Expr, {Var -> Value}], $Failed]]];
  Return[If[NumberQ[Value1], Value1, $Failed]]];

(* J: the real part of the expansion, exactly; 2F1: every coefficient at every point, to 20 digits *)
TestPass[Reference_, Result_] := Module[{Eps, Var, Differences},
  Eps = Reference["Regulator"];
  If[KeyExistsQ[Reference, "RealPart"],
    Return[TrueQ[Quiet[Simplify[Expand[Result - Reference["RealPart"]]]] === 0]]];
  Var = Reference["Variable"];
  Differences = Flatten[Table[
    TestNumber[Coefficient[Result, Eps, K1], Var, P1] - N[Coefficient[Reference["ClosedForm"], Eps, K1] /. Var -> P1, 30],
    {K1, 0, Reference["Order"]}, {P1, Reference["Points"]}]];
  Return[VectorQ[Differences, NumberQ] && Max[Abs[Differences]] < 10^-20]];

TestRun[Reference_, Method1_] := Module[{Start, Result},
  Start = AbsoluteTime[];
  Result = MBEvaluate[Reference["Integral"], {Reference["Regulator"], Reference["Order"]}, Method -> Method1];
  Return[<|"Reference" -> Reference, "Method" -> Method1, "Result" -> Result, "Seconds" -> Round[AbsoluteTime[] - Start]|>]];

(* every evaluation first, then the comparisons, so that PolyLogTools is loaded for the numerical ones *)
TestTodo = Select[Tuples[{TestReferences, TestMethods}], TestNumericQ || KeyExistsQ[#[[1]], "RealPart"] &];
Print["J through e^0 and 2F1 through e^2 with each available method:"];
TestRuns = Map[TestRun[#[[1]], #[[2]]] &, TestTodo];
TestPasses = Map[TestPass[#["Reference"], #["Result"]] &, TestRuns];
MapThread[Function[{Run1, Pass},
    Print[If[Pass, "  PASS  ", "  FAIL  "], Run1["Reference"]["Name"], "  ", Run1["Method"], "  (", Run1["Seconds"], " s)"];
    If[! Pass, Print["        result: ", InputForm[Run1["Result"]]]]],
  {TestRuns, TestPasses}];
If[! TestNumericQ, Print["  2F1 skipped: its numerical comparison needs the methods ExpandInt or Subtraction (GiNaC)."]];
Print[""];
TestFailed = DeleteDuplicates[Map[#["Method"] &, Pick[TestRuns, TestPasses, False]]];
If[TestFailed === {},
  Print["Installation test passed for: ", StringRiffle[TestMethods, ", "]];
  Exit[0],
  Print["Installation test FAILED for: ", StringRiffle[TestFailed, ", "]];
  Exit[1]];
