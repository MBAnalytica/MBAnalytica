(* ::Package:: *)

(* ::Title:: *)
(*MBAnalytica: dependency check*)


(* ::Text:: *)
(*Read inside MBAnalytica`Private` by MBAnalytica.wl.  Every dependency is tested without loading it, so the check*)
(*is fast and has no side effect.  A method is available when every dependency it needs is present.*)


(* ::Section:: *)
(*Configuration written by make*)


ReadConfig[] := Module[{ConfigFile, Settings},
  ConfigFile = FileNameJoin[{PackageRoot, "config.m"}];
  If[! FileExistsQ[ConfigFile], Return[<||>]];
  Settings = Quiet[Check[Get[ConfigFile], <||>]];
  If[! AssociationQ[Settings], Return[<||>]];
  Return[Settings]];


ConfigValue[Entry_String] := Module[{Settings, Value},
  Settings = ReadConfig[];
  Value = Lookup[Settings, Entry, ""];
  If[! StringQ[Value], Return[""]];
  Return[Value]];


(* the RISC packages are looked for on $Path; $MBAnalyticaRISCPath, or the folder make recorded, is added first *)
RISCFolder[] := Module[{Folder},
  Folder = Global`$MBAnalyticaRISCPath;
  If[StringQ[Folder] && DirectoryQ[Folder], Return[Folder]];
  Folder = ConfigValue["RISCPath"];
  If[DirectoryQ[Folder], Return[Folder]];
  Return[None]];


AddRISCPath[] := Module[{Folder},
  Folder = RISCFolder[];
  If[Folder === None, Return[Null]];
  If[! MemberQ[$Path, Folder], PrependTo[$Path, Folder]];
  Return[Null]];


(* ::Section:: *)
(*Individual tests*)


DepFile[Parts__] := FileNameJoin[{PackageRoot, "dep", Parts}];


AllFilesQ[Files_List] := AllTrue[Files, FileExistsQ];


RISCPackageQ[Name_String] := Module[{},
  AddRISCPath[];
  Return[FindFile[Name <> "`"] =!= $Failed]];


GinshPath[] := Module[{Pinned, Configured, Found},
  Pinned = Global`$MBStandardGinshExecutable;
  If[StringQ[Pinned] && FileExistsQ[Pinned], Return[Pinned]];
  Configured = ConfigValue["Ginsh"];
  If[FileExistsQ[Configured], Return[Configured]];
  Found = Quiet[Check[RunProcess[{"/bin/sh", "-c", "command -v ginsh"}, "StandardOutput"], ""]];
  If[! StringQ[Found], Return[None]];
  Found = StringTrim[Found];
  If[Found === "" || ! FileExistsQ[Found], Return[None]];
  Return[Found]];


HyperFLINTPath[] := Module[{Configured},
  Configured = ConfigValue["HyperFLINT"];
  If[FileExistsQ[Configured], Return[Configured]];
  Return[DepFile["IntVolFLINT", "bin", "hyperflint"]]];


HyperFLINTRunsQ[] := Module[{Binary, Reply},
  Binary = HyperFLINTPath[];
  If[! FileExistsQ[Binary], Return[False]];
  Reply = Quiet[Check[RunProcess[{Binary, "--version"}, "StandardOutput"], ""]];
  Return[StringQ[Reply] && StringContainsQ[Reply, "HF_VERSION"]]];


PythonPath[] := Module[{Configured, Local},
  Configured = ConfigValue["Python"];
  If[FileExistsQ[Configured], Return[Configured]];
  Local = FileNameJoin[{PackageRoot, ".venv", "bin", "python3"}];
  If[FileExistsQ[Local], Return[Local]];
  Return["python3"]];


PythonReadyQ[] := Module[{Code},
  Code = Quiet[Check[RunProcess[{PythonPath[], "-c", "import numpy, scipy, sympy"}, "ExitCode"], 1]];
  Return[Code === 0]];


(* ::Section:: *)
(*The dependency table*)


(* each row: name, what it is, its test, the methods that need it, and what to do when it is missing *)
DependencyRows[] := {
  <|"Name" -> "Mathematica 14 or later", "Kind" -> "system",
    "Test" -> (TrueQ[$VersionNumber >= 14] &), "Methods" -> {"SymbolicSum", "HyperLog", "Subtraction"},
    "Hint" -> "MBAnalytica is tested with Mathematica 14.2 and 15.0."|>,
  <|"Name" -> "MB tools (MB, MBresolve, barnesroutines)", "Kind" -> "downloaded by make",
    "Test" -> (AllFilesQ[{DepFile["MB", "MB.m"], DepFile["MB", "MBresolve.m"], DepFile["MB", "barnesroutines.m"]}] &),
    "Methods" -> {"SymbolicSum", "HyperLog", "Subtraction"},
    "Hint" -> "Run make in the MBAnalytica folder; it downloads them from https://gitlab.com/feynmanintegrals/MB (UPSTREAM=/path uses local copies)."|>,
  <|"Name" -> "MBConicHulls", "Kind" -> "bundled",
    "Test" -> (AllFilesQ[{DepFile["MBConicHulls", "MBConicHulls.wl"], DepFile["MBConicHulls", "MultivariateResidues.m"]}] &),
    "Methods" -> {"SymbolicSum"},
    "Hint" -> "It ships in dep/MBConicHulls; the folder is incomplete. Clone the repository again."|>,
  <|"Name" -> "HarmonicSums", "Kind" -> "external", "Test" -> (RISCPackageQ["HarmonicSums"] &), "Methods" -> {"SymbolicSum"},
    "Hint" -> "Download it from https://risc.jku.at/sw/harmonicsums/ and set $MBAnalyticaRISCPath to its folder (or run make RISC=/path)."|>,
  <|"Name" -> "Sigma", "Kind" -> "external", "Test" -> (RISCPackageQ["Sigma"] &), "Methods" -> {"SymbolicSum"},
    "Hint" -> "Download it from https://risc.jku.at/sw/sigma/ and set $MBAnalyticaRISCPath to its folder (or run make RISC=/path)."|>,
  <|"Name" -> "EvaluateMultiSums", "Kind" -> "external", "Test" -> (RISCPackageQ["EvaluateMultiSums"] &), "Methods" -> {"SymbolicSum"},
    "Hint" -> "Download it from https://risc.jku.at/sw/evaluatemultisums/ and set $MBAnalyticaRISCPath to its folder (or run make RISC=/path)."|>,
  <|"Name" -> "PolyLogTools, HyperIntica", "Kind" -> "bundled",
    "Test" -> (AllFilesQ[{DepFile["PolyLogTools", "PolyLogTools.m"], DepFile["HyperIntica", "HyperIntica.wl"]}] &),
    "Methods" -> {"HyperLog", "Subtraction"},
    "Hint" -> "They ship in dep/; the folder is incomplete. Clone the repository again."|>,
  <|"Name" -> "HPL 2.0, HypExp 2.0", "Kind" -> "downloaded by make",
    "Test" -> (AllFilesQ[{DepFile["HPL", "HPL.m"], DepFile["HypExp", "HypExp.m"]}] &),
    "Methods" -> {"HyperLog", "Subtraction"},
    "Hint" -> "Run make in the MBAnalytica folder; it downloads them from https://www.physik.uzh.ch/data/HPL/ and https://www.physik.uzh.ch/data/HypExp/ (UPSTREAM=/path uses local copies)."|>,
  <|"Name" -> "HPL weight 9 and 10 tables", "Kind" -> "downloaded by make",
    "Test" -> (AllFilesQ[{DepFile["HPL", "h9table.mat"], DepFile["HPL", "h10table.mat"], DepFile["HPL", "ms9_rules.mx"],
        DepFile["HPL", "mspm9_rules.mx"], DepFile["HPL", "ms10_rules_v2.mx"], DepFile["HPL", "mspm10_rules.mx"]}] &),
    "Methods" -> {"HyperLog", "Subtraction"},
    "Hint" -> "Run make in the MBAnalytica folder."|>,
  <|"Name" -> "HyperFLINT (built for this machine)", "Kind" -> "built by make", "Test" -> (HyperFLINTRunsQ[] &),
    "Methods" -> {"HyperLog", "Subtraction"},
    "Hint" -> "Run make in the MBAnalytica folder (it needs cmake, FLINT, GMP and MPFR; make deps shows how to install them)."|>,
  <|"Name" -> "ginsh (GiNaC)", "Kind" -> "external", "Test" -> (GinshPath[] =!= None &), "Methods" -> {"HyperLog", "Subtraction"},
    "Hint" -> "Install GiNaC and CLN (macOS: brew install ginac; Debian/Ubuntu: apt install ginac-tools), or run make deps."|>,
  <|"Name" -> "Python 3 with numpy, scipy, sympy", "Kind" -> "built by make", "Test" -> (PythonReadyQ[] &),
    "Methods" -> {"Subtraction with kinematic variables"},
    "Hint" -> "Run make in the MBAnalytica folder (it creates .venv)."|>
};


(* ::Section:: *)
(*Report*)


CheckDependencies[] := Module[{Rows, Results},
  Rows = DependencyRows[];
  Results = Map[Join[KeyDrop[#, "Test"], <|"Found" -> TrueQ[#["Test"][]]|>] &, Rows];
  Return[Results]];


MethodsFrom[Results_List] := Module[{Absent, Blocked},
  Absent = Select[Results, ! #["Found"] &];
  Blocked = DeleteDuplicates[Flatten[Map[#["Methods"] &, Absent]]];
  Return[Select[{"SymbolicSum", "HyperLog", "Subtraction"}, ! MemberQ[Blocked, #] &]]];


RefreshMethods[] := Module[{Results},
  Results = CheckDependencies[];
  $MBAnalyticaMethods = MethodsFrom[Results];
  LastCheck = Results;
  Return[Results]];


MBAnalyticaCheck[] := Module[{Results, Lines},
  Results = RefreshMethods[];
  Lines = Map[
    Row[{If[#["Found"], Style["  found    ", Darker[Green]], Style["  MISSING  ", Red]],
      Style[#["Name"], Bold], "  (" <> #["Kind"] <> "; needed by " <> StringRiffle[#["Methods"], ", "] <> ")",
      If[#["Found"], "", "\n             " <> #["Hint"]]}] &, Results];
  Scan[Print, Lines];
  Print[Row[{Style["Methods available on this machine: ", Bold],
    If[$MBAnalyticaMethods === {}, Style["none", Red], StringRiffle[$MBAnalyticaMethods, ", "]]}]];
  Return[<|"Methods" -> $MBAnalyticaMethods,
    "Dependencies" -> Association[Map[#["Name"] -> #["Found"] &, Results]]|>]];
