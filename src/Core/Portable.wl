(* ::Package:: *)

(* ::Title:: *)
(*Portable process control for MBAnalytica*)


(* ::Text:: *)
(*The engine runs external programs (the HyperFLINT binary, Python, worker kernels) with a time limit, an unlimited*)
(*stack and, for parallel races, a process group it can kill.  On Linux it used timeout, prlimit, setsid and*)
(*ps --ppid; macOS has none of these.  Every helper below uses the Linux tool when it exists, so the behaviour on*)
(*Linux is unchanged, and otherwise a fallback that macOS ships: Perl's alarm for the time limit, the shell's ulimit*)
(*for the stack, and pgrep -P to walk a process tree.*)


BeginPackage["MBAnalytica`Portable`"];


TimeoutArgs::usage =
"TimeoutArgs[Seconds] is the command prefix, as a list of strings, that runs a program with a time limit of \
Seconds. TimeoutArgs[Seconds, KillAfter] also sends KILL KillAfter seconds after the limit, when the tool supports it.";

TimeoutPrefix::usage =
"TimeoutPrefix[Seconds] is TimeoutArgs[Seconds] as a string, ready to be put in front of a shell command.";

StackArgs::usage =
"StackArgs[Command] runs the list of strings Command with the largest stack the system allows.";

StackPrefix::usage =
"StackPrefix is the shell text that raises the stack limit as far as the system allows.";

SetsidArgs::usage =
"SetsidArgs[] is {\"setsid\"} where setsid exists (Linux) and {} elsewhere.";

ChildPIDs::usage =
"ChildPIDs[Pid] lists the process IDs of the children of the process Pid.";

KillTree::usage =
"KillTree[Pid] kills the process Pid and all of its descendants.";

KillGroup::usage =
"KillGroup[Pid] kills the process group led by Pid when it was started with SetsidArgs[], and the process tree of \
Pid otherwise.";

KernelBinaryPattern::usage =
"KernelBinaryPattern[] is the part of the path of this system's kernel binary that identifies a running kernel in \
the output of ps.";

ShellQuote::usage =
"ShellQuote[String] quotes String for a POSIX shell.";


Begin["`Private`"];


(* ::Section:: *)
(*Finding tools*)


FindCommand[Name_String] := Module[{Found},
  Found = Quiet[Check[RunProcess[{"/bin/sh", "-c", "command -v " <> Name}, "StandardOutput"], ""]];
  If[! StringQ[Found], Return[None]];
  Found = StringTrim[Found];
  If[Found === "" || ! FileExistsQ[Found], Return[None]];
  Return[Found]];


(* the tools are looked up once per kernel *)
TimeoutTool[] := TimeoutTool[] = Module[{Gnu, GnuMac, Perl},
  Gnu = FindCommand["timeout"];
  If[Gnu =!= None, Return[{"Gnu", Gnu}]];
  GnuMac = FindCommand["gtimeout"];
  If[GnuMac =!= None, Return[{"Gnu", GnuMac}]];
  Perl = FindCommand["perl"];
  If[Perl =!= None, Return[{"Perl", Perl}]];
  Return[{"None", ""}]];


SetsidTool[] := SetsidTool[] = FindCommand["setsid"];


PrlimitTool[] := PrlimitTool[] = FindCommand["prlimit"];


(* ::Section:: *)
(*Time limits*)


TimeoutArgs[Seconds_] := Module[{Tool, LimitText},
  Tool = TimeoutTool[];
  LimitText = ToString[Max[1, Ceiling[Seconds]]];
  Switch[Tool[[1]],
    "Gnu", Return[{Tool[[2]], LimitText}],
    "Perl", Return[{Tool[[2]], "-e", "alarm shift @ARGV; exec @ARGV", LimitText}],
    _, Return[{}]]];


TimeoutArgs[Seconds_, KillAfter_] := Module[{Tool, LimitText, AfterText},
  Tool = TimeoutTool[];
  If[Tool[[1]] =!= "Gnu", Return[TimeoutArgs[Seconds]]];
  LimitText = ToString[Max[1, Ceiling[Seconds]]];
  AfterText = "--kill-after=" <> ToString[Max[1, Ceiling[KillAfter]]];
  Return[{Tool[[2]], AfterText, LimitText}]];


TimeoutPrefix[Seconds_] := Module[{Args},
  Args = TimeoutArgs[Seconds];
  If[Args === {}, Return[""]];
  Return[StringRiffle[Map[ShellQuote, Args], " "] <> " "]];


(* ::Section:: *)
(*Stack size*)


StackPrefix = "ulimit -s unlimited 2>/dev/null || ulimit -s hard 2>/dev/null; ";


StackArgs[Command_List] := Module[{Prlimit},
  Prlimit = PrlimitTool[];
  If[Prlimit =!= None, Return[Join[{Prlimit, "--stack=unlimited"}, Command]]];
  Return[Join[{"/bin/sh", "-c", StackPrefix <> "exec \"$0\" \"$@\""}, Command]]];


(* ::Section:: *)
(*Process groups and trees*)


SetsidArgs[] := Module[{Tool},
  Tool = SetsidTool[];
  If[Tool === None, Return[{}]];
  Return[{Tool}]];


ChildPIDs[Pid_Integer] := Module[{Found, Words},
  Found = Quiet[Check[RunProcess[{"pgrep", "-P", ToString[Pid]}, "StandardOutput"], ""]];
  If[! StringQ[Found], Return[{}]];
  Words = StringSplit[Found];
  Words = Select[Words, StringMatchQ[#, DigitCharacter ..] &];
  Return[Map[ToExpression, Words]]];


Descendants[Pid_Integer] := Module[{Kids, Deeper},
  Kids = ChildPIDs[Pid];
  Deeper = Map[Descendants, Kids];
  Return[Join[Kids, Flatten[Deeper]]]];


KillTree[Pid_Integer] := Module[{Doomed},
  Doomed = Join[Descendants[Pid], {Pid}];
  Scan[Quiet[RunProcess[{"kill", "-9", ToString[#]}]] &, Doomed];
  Return[Null]];


KillGroup[Pid_Integer] := Module[{},
  If[SetsidTool[] =!= None,
    Quiet[RunProcess[{"kill", "-9", "--", "-" <> ToString[Pid]}]]];
  KillTree[Pid];
  Return[Null]];


(* ::Section:: *)
(*Kernels and quoting*)


KernelBinaryPattern[] := Module[{},
  If[$OperatingSystem === "MacOSX", Return["MacOS/WolframKernel"]];
  Return["Binaries/" <> $SystemID <> "/WolframKernel"]];


ShellQuote[Phrase_String] := Module[{Escaped},
  Escaped = StringReplace[Phrase, "'" -> "'\\''"];
  Return["'" <> Escaped <> "'"]];


End[];
EndPackage[];
