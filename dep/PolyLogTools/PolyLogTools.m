(* ::Package:: *)

(* ::Title:: *)
(*PolyLogTools*)


(* ::Subsection:: *)
(*Print out*)


PLT$Version = "1.4";


Print["(****** PolyLogTools ", PLT$Version, " ******)"];
Print["    Authors: Claude Duhr, Falko Dulat"];
Print["    Email: cduhr@uni-bonn.de"];
Print["    PolyLogTools uses the implementation of the PSLQ algorithm by P. Bertok (http://library.wolfram.com/infocenter/MathSource/4263/)"];


Off[General::compat];

BeginPackage["PolyLogTools`", {"HPL`", "Combinatorica`"}];

On[General::compat];

If[ !ValueQ[Global`$PolyLogPath],	
	$PolyLogToolPath = DirectoryName[$InputFileName],
	$PolyLogToolPath = Global`$PolyLogPath;
];

GiNaC$InterfacePath = $PolyLogToolPath <> "/Temp/";


(* ::Subsection:: *)
(*Flags*)


PLT$AutoConvertToKnownConstants = True;
PLT$ShuffleRegularisation = True;

$QExtension = {};

$Alphabet = {0,1,-1};

PLT$MaxDenominatorReductionVariables = 11;

PLT$Verbose = False;

$AlphabetBound = 5;


vPrint[x___]:=If[PLT$Verbose,Print[x]];


Unprotect[HPL]
HPL[{-1},-1]=-HPL[{1},1]
Protect[HPL]


Get[FileNameJoin[{$PolyLogToolPath, "Usage.m"}]];


(* ::Subsection:: *)
(*Format*)


Format[Delta, StandardForm] = \[CapitalDelta];
Format[Delta, TraditionalForm] = \[CapitalDelta];

Format[CT[as__], StandardForm] := CircleTimes[as];
Format[CT[as__], TraditionalForm] := CircleTimes[as];


Format[Cl[n_,x_],TraditionalForm] := Subscript[Cl,n][x]
Format[Cl[n_,x_],StandardForm] := Subscript[Cl,n][x]


Format[CTW[a_,b_],TraditionalForm]:=Wedge[a,b];
Format[CTW[a_,b_],StandardForm]:=Wedge[a,b];


Format[PolyGon[verts__],TraditionalForm] := "["<>(StringJoin@@Riffle[ToString[#,TraditionalForm]&/@{verts},","])<>"]"
Format[PolyGon[verts__],StandardForm]    := Format[PolyGon[verts],TraditionalForm];


Format[CiTi[as___], StandardForm] := CircleTimes[as];
Format[CiTi[as___], TraditionalForm] := CircleTimes[as];


Format[Tens[x__],StandardForm]:=CiTi[x]
Format[Tens[x__],TraditionalForm]:=CiTi[x]

Format[TensWedge[x__],StandardForm]:=Wedge[x];
Format[TensWedge[x__],TraditionalForm]:=Wedge[x];

Format[ElTens[x__],StandardForm]:=x
Format[ElTens[x__],TraditionalForm]:=x


(* ::Subsection:: *)
(*Subdirectory structure and subroutines*)


Block[{

    $Path = ($PolyLogToolPath <> # &) /@ {"", "/lib", "/Temp", "/core"}

    },
    Get["Coproduct`"];
    Get["Regularization`"];
    Get["ShuffleAlgebra`"];
    Get["PolyLogToolBox`"];
    Get["Gint`"];
	Get["GiNaCInterface`"];
    Get["LyndonWords`"];
    Get["Symbols`"];
    Get["IntegrationSymbols`"];
    Get["CanonicalIntegrator`"];
    Get["Reduction`"];
    Get["ReduceCG78`"];
    Get["MZVw78`"];
    Get["PSLQ`"];
    Get["DenominatorReduction`"];
	Get["FitReduction`"];
	Get["PeriodMatrix`"];

    Get["Coproduct8`"];
    Get["Coproduct12`"];
    Get["SpecialPolyLogIdentities`"];
    Get["G12`"];
    Get["G13`"];
    Get["Gm12`"];
    Get["Gm13`"];
    Get["cLi.m"];
	Get["cLL.m"];
    Get["HPLBasis2`"];
    Get["HPLBasis3`"];
    Get["HPLBasis4`"];
    Get["HPLBasis5`"];
    Unprotect[MZV];
    Get["MZV7`"];
    Get["MZV8`"];
    Protect[MZV];
    Get["sixrootunity`"];

   (* Get["CosmicSVGs`"];*)

];


(* ::Subsection:: *)
(*Test if Ginsh is running*)


Ginsh::NotFound = "Warning: PolyLogTools was unable to locate the ginsh excecutable!
Make sure that GiNaC and ginsh are installed properly.
Some functionalities will not work properly unless ginsh is properly running.";


If[Run["which ginsh"] =!= 0,
   Message[Ginsh::NotFound]
   ];
    


(* ::Subsection:: *)
(**)


EndPackage[];
