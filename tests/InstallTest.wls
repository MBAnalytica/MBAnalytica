#!/usr/bin/env wolframscript
(* ::Package:: *)
(* MBAnalytica installation test (make test): loads the package in a fresh kernel, reports the dependencies, and
   evaluates one known integral with every method available on this machine.  Exit code 0 when every available
   method returns the known result exactly. *)

SetOptions[$Output, PageWidth -> Infinity];
TestRoot = ParentDirectory[DirectoryName[ExpandFileName[First[Select[$ScriptCommandLine, StringEndsQ[#, "InstallTest.wls"] &]]]]];
Get[FileNameJoin[{TestRoot, "MBAnalytica.wl"}]];
Print[""];
TestCheck = MBAnalyticaCheck[];
Print[""];

TestReference = Block[{$ContextPath = {"System`"}}, Get[FileNameJoin[{TestRoot, "tests", "reference", "InstallReference.m"}]]];
TestIntegral = TestReference["Integral"];
TestEps = TestReference["Regulator"];
TestExpected = TestReference["RealPart"];

TestOne[Method1_String] := Module[{Start, Result, Difference, Pass, Seconds},
  Start = AbsoluteTime[];
  Result = MBEvaluate[TestIntegral, {TestEps, TestReference["Order"]}, Method -> Method1];
  Seconds = Round[AbsoluteTime[] - Start];
  Difference = Quiet[Simplify[Expand[Result - TestExpected]]];
  Pass = TrueQ[Difference === 0];
  Print[If[Pass, "  PASS  ", "  FAIL  "], Method1, "  (", Seconds, " s)"];
  If[! Pass, Print["        result: ", InputForm[Result]]];
  Return[Pass]];

TestMethods = TestCheck["Methods"];
If[TestMethods === {},
  Print["No method can run on this machine; see the report above."];
  Exit[1]];
Print["MB1 through e^0 with each available method:"];
TestPasses = Map[TestOne, TestMethods];
Print[""];
If[And @@ TestPasses,
  Print["Installation test passed for: ", StringRiffle[TestMethods, ", "]];
  Exit[0],
  Print["Installation test FAILED for: ", StringRiffle[Pick[TestMethods, TestPasses, False], ", "]];
  Exit[1]];
