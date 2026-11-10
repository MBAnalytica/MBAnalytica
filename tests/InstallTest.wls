#!/usr/bin/env wolframscript
(* ::Package:: *)
(* MBAnalytica installation test (make test): loads the package by name, as every Mathematica session does after
   make install (the package of this folder when it is not yet on the $Path of Mathematica), reports the
   dependencies, and evaluates the integrals of tests/reference/InstallReference.m with every method available on
   this machine, TestMB exactly and 2F1 numerically at two values of its kinematic variable.  The lines of the test
   go to stderr, one for each evaluation as soon as it is compared.  The output of the methods and of their
   dependencies goes to stdout, which make test writes to a log file.  Exit code 0 when every available method returns
   every result. *)

SetOptions[$Output, PageWidth -> Infinity];
TestSay[Parts___] := WriteString["stderr", Parts, "\n"];
(* a Print of the package (the dependency report of MBAnalyticaCheck) as a line of the test *)
TestPrintLine = Function[WriteString["stderr", StringJoin[Map[ToString, {##}]], "\n"]];
TestRoot = ParentDirectory[DirectoryName[ExpandFileName[First[Select[$ScriptCommandLine, StringEndsQ[#, "InstallTest.wls"] &]]]]];
TestPackage = FileNameJoin[{TestRoot, "MBAnalytica.wl"}];
(* the file that << MBAnalytica.wl loads in a session outside this folder: without ".", the current directory on
   $Path, which is this folder while make runs *)
TestFound = Block[{$Path = DeleteCases[$Path, "."]}, FindFile["MBAnalytica.wl"]];
Which[
  TestFound === $Failed,
    TestSay["MBAnalytica.wl is not on the $Path of Mathematica yet (make install adds it), so the package of this folder is tested."];
    Get[TestPackage],
  ExpandFileName[TestFound] =!= TestPackage,
    TestSay["<< MBAnalytica.wl loads ", TestFound, " instead of ", TestPackage,
      ", since another copy comes earlier on the $Path of Mathematica."];
    Exit[1],
  True,
    TestSay["<< MBAnalytica.wl loads ", TestFound];
    Get[TestFound]];
TestSay[""];
TestCheck = Block[{Print = TestPrintLine}, MBAnalyticaCheck[]];
TestSay[""];

TestReferences = Block[{$ContextPath = {"System`"}}, Get[FileNameJoin[{TestRoot, "tests", "reference", "InstallReference.m"}]]];
TestMethods = TestCheck["Methods"];
If[TestMethods === {},
  TestSay["No method can run on this machine, see the report above."];
  Exit[1]];
(* the numerical comparison evaluates G functions with GiNaC through PolyLogTools, which the methods ExpandInt and
   Subtraction load *)
TestNumericQ = IntersectingQ[TestMethods, {"ExpandInt", "Subtraction"}];

(* a coefficient at a value of the kinematic variable, through ginsh (PolyLogTools` on the context path, since ginsh
   rejects a G written with its context).  PolyLogTools is loaded here if no integration method has loaded it yet *)
TestNumber[Expr_, Var_, Value_] := Module[{Value1},
  If[FreeQ[Expr, PolyLogTools`G], Return[N[Expr /. Var -> Value, 30]]];
  If[DownValues[PolyLogTools`Ginsh] === {}, MBAnalytica`Private`WithoutUserValues[MBAnalytica`Private`LoadSymbolicInt[]]];
  Value1 = Block[{$ContextPath = Prepend[$ContextPath, "PolyLogTools`"]},
    Quiet[Check[PolyLogTools`Ginsh[Expr, {Var -> Value}], $Failed]]];
  Return[If[NumberQ[Value1], Value1, $Failed]]];

(* TestMB, the real part of the expansion exactly, and 2F1, every coefficient at every point to 20 digits *)
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

(* every evaluation is compared as soon as it is done.  TestMB comes first with every method, so that an integration
   method has loaded PolyLogTools before the numerical comparisons of 2F1 *)
TestTodo = Select[Tuples[{TestReferences, TestMethods}], TestNumericQ || KeyExistsQ[#[[1]], "RealPart"] &];
TestSay["TestMB through e^0 and 2F1 through e^2 with each available method:"];
TestRuns = {};
TestPasses = {};
Do[Module[{Run1, Pass, Line1, Shown},
    Run1 = TestRun[T1[[1]], T1[[2]]];
    Pass = TestPass[Run1["Reference"], Run1["Result"]];
    AppendTo[TestRuns, Run1];
    AppendTo[TestPasses, Pass];
    Line1 = StringJoin[If[Pass, "  PASS  ", "  FAIL  "], Run1["Reference"]["Name"], "  ", Run1["Method"], "  (",
      ToString[Run1["Seconds"]], " s)"];
    TestSay[Line1];
    (* the whole result goes to the log, the first 500 characters to the terminal *)
    If[! Pass,
      Print[Line1, "  result: ", InputForm[Run1["Result"]]];
      Shown = ToString[InputForm[Run1["Result"]]];
      TestSay["        result: ", StringTake[Shown, UpTo[500]], If[StringLength[Shown] > 500, " ...", ""]]]],
  {T1, TestTodo}];
If[! TestNumericQ, TestSay["  2F1 skipped, since its numerical comparison needs the methods ExpandInt or Subtraction (GiNaC)."]];
TestSay[""];
TestFailed = DeleteDuplicates[Map[#["Method"] &, Pick[TestRuns, TestPasses, False]]];
If[TestFailed === {},
  TestSay["Installation test passed for: ", StringRiffle[TestMethods, ", "]];
  Exit[0],
  TestSay["Installation test FAILED for: ", StringRiffle[TestFailed, ", "]];
  Exit[1]];
