(* ::Package:: *)

(* ::Title:: *)
(*MBAnalytica*)


(* ::Subtitle:: *)
(*a Mathematica package for the analytic evaluation of Mellin-Barnes integrals in terms of multiple polylogarithms*)


(* ::Text:: *)
(*Authors: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias.*)
(*Three methods: Resum (series solutions summed by EvaluateMultiSums), HyperLog and Subtraction (the MB2MPL*)
(*engine: exact Euler integrals and boundary subtraction).  This file is the only one a user loads; it loads the*)
(*methods themselves the first time they are used.  See README.md for installation and Examples.nb for examples.*)


(* ::Section::Closed:: *)
(*Package Initiation*)


BeginPackage["MBAnalytica`"];


(* ::Section::Closed:: *)
(*Usage Messages*)


(* ::Subsection::Closed:: *)
(*External Commands*)


MBEvaluate::usage =
"MBEvaluate[MBInt, {Eps, Ord}] returns the expansion of the Mellin-Barnes integral MBInt in Eps, from its \
leading pole through the order Eps^Ord, in terms of multiple polylogarithms G, Log, Zeta and Pi.\n\n\
MBInt  - the MB integrand, built from Gamma and PolyGamma functions and powers of the kinematic variables\n\
Eps    - the dimensional regulator appearing in MBInt\n\
Ord    - the deepest order of Eps to be evaluated\n\n\
The integration variables are the variables inside the Gamma and PolyGamma functions and the kinematic variables \
are whatever is left, so neither has to be given. MBEvaluate[MBInt, MBVar, {Eps, Ord}] names the kinematic \
variables explicitly; they are taken in 0 < x < 1.\n\n\
A coefficient that could not be brought to a closed form is returned as MBFailed[reasons].\n\n\
Options:\n  \
Method -> Automatic       tries the methods available on this machine in the order \"Resum\", \"HyperLog\", \
\"Subtraction\", each one only on the orders the earlier ones left open; \"Resum\", \"HyperLog\" or \"Subtraction\" uses \
that method alone (\"Standard\" is accepted as an alias of \"HyperLog\")\n  \
Verbose -> False          prints one line per stage\n  \
BarnesReduce -> True      applies the Barnes lemmas before the Resum method solves the integral\n  \
Complex -> False          returns the real part; True returns the full complex value\n\n\
Examples:\n  \
MBEvaluate[MB1, {\[Epsilon], 0}]\n  \
MBEvaluate[MB1, {\[Epsilon], 0}, Method -> \"HyperLog\"]\n  \
MBEvaluate[MB1u, {\[Epsilon], -1}, Complex -> True]";


MBAnalyticaCheck::usage =
"MBAnalyticaCheck[] prints which dependencies of MBAnalytica were found on this machine, what to do about each \
missing one, and which methods can run. It returns an association with the same information.";


MBFailed::usage =
"MBFailed[reasons] stands for a coefficient that no method could bring to a closed form; reasons names what was \
left unresolved.";


(* ::Subsection::Closed:: *)
(*Options*)


BarnesReduce::usage =
"BarnesReduce is an option of MBEvaluate which specifies whether the first and second Barnes lemmas are applied, \
with DoAllBarnes, to the expanded integral before it is solved by the Resum method. Its default value is True.";


(* ::Subsection::Closed:: *)
(*Global Variables*)


Global`$KernelLaunch::usage =
"$KernelLaunch sets the number of parallel subkernels MBAnalytica uses (default 4, at most one per core). \
Set it before the first evaluation, e.g. $KernelLaunch = 8.";


Global`$MBAnalyticaRISCPath::usage =
"$MBAnalyticaRISCPath is the folder that holds HarmonicSums, Sigma and EvaluateMultiSums, if they are not already on \
$Path. make RISC=/path records it once for all sessions.";


Global`$MBAnalyticaCacheDirectory::usage =
"$MBAnalyticaCacheDirectory is the folder for the caches and logs of MBAnalytica; the default is \
$UserBaseDirectory/ApplicationData/MBAnalytica.";


$MBAnalyticaVersion::usage = "$MBAnalyticaVersion is the version of MBAnalytica.";


$MBAnalyticaDirectory::usage = "$MBAnalyticaDirectory is the folder MBAnalytica was loaded from.";


$MBAnalyticaMethods::usage =
"$MBAnalyticaMethods lists the methods that can run on this machine (\"Resum\", \"HyperLog\", \"Subtraction\").";


(* ::Section::Closed:: *)
(*Internal Modules*)


Begin["`Private`"];


PackageRoot = DirectoryName[$InputFileName];
If[PackageRoot === "", PackageRoot = Directory[]];
PackageRoot = StringTrim[PackageRoot, $PathnameSeparator ~~ EndOfString];


$MBAnalyticaVersion = "1.0.0";
$MBAnalyticaDirectory = PackageRoot;


Get[FileNameJoin[{PackageRoot, "src", "Core", "Portable.wl"}]];
$ContextPath = DeleteCases[$ContextPath, "MBAnalytica`Portable`"];
Get[FileNameJoin[{PackageRoot, "src", "Core", "Check.wl"}]];
Get[FileNameJoin[{PackageRoot, "src", "Core", "Output.wl"}]];
Get[FileNameJoin[{PackageRoot, "src", "Core", "Evaluate.wl"}]];


End[];


EndPackage[];


(* ::Section::Closed:: *)
(*Author Credits*)


Print[Style["MBAnalytica " <> $MBAnalyticaVersion, Blue, 14, FontFamily -> "Courier", Bold],
  Style[" - analytic evaluation of Mellin-Barnes integrals in terms of multiple polylogarithms.", Blue, 14,
    FontFamily -> "Courier"]];
Print[Style["Authors: ", Black, Bold],
  Style["Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias", Brown, Bold, 12.5]];
MBAnalytica`Private`RefreshMethods[];
Print[Style["Methods available: ", Black, Bold],
  If[$MBAnalyticaMethods === {}, Style["none - run MBAnalyticaCheck[] to see what is missing", Red],
    StringRiffle[$MBAnalyticaMethods, ", "] <>
      If[Length[$MBAnalyticaMethods] < 3, "  (MBAnalyticaCheck[] shows what the others need)", ""]]];
