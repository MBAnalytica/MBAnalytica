(* ::Package:: *)

(* ::Title:: *)
(*The Mathematica interface to GiNaC for the numerical evaluation multiple polylogarithms*)


GiNaC$FileCounter = 1;


(* ::Section::Closed:: *)
(*LiNumericalValueFromGiNaC*)


Options[LiNumericalValueFromGiNaC] = {Debug -> True, GiNaCRunFile -> "GiNaCtemplate", PrecisionGoal -> 30};


LiNumericalValueFromGiNaC[ws_List, xs_List, OptionsPattern[]] := Block[{workingdir, 
    resetdir = True,
    exec = OptionValue[GiNaCRunFile] <> ToString[GiNaC$FileCounter++],
    filename,
    cfile,
    ginac},


    filename = exec <> ".cc";

    Off[SetDirectory::cdir];
    workingdir = SetDirectory[GiNaC$InterfacePath];
    If[workingdir === $Failed, 
       resetdir = False;
       workingdir = Directory[]
      ];

    cfile = OpenWrite[filename];
    WriteString[cfile, "#include <iostream>\n"];
    WriteString[cfile, "#include <ginac/ginac.h>\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, "int main() \n"];
    WriteString[cfile, " {\n"];
    WriteString[cfile, "  using namespace std;\n"];
    WriteString[cfile, "  using namespace GiNaC;\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, "  Digits = ", ToString[OptionValue[PrecisionGoal]], ";\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, " cout << Li( ", StringReplace[ToString[Reverse[ws], CForm], {"List" -> "lst"}], ", ", StringReplace[ToString[SetPrecision[N[Reverse[xs], 6], 6], CForm], {"List" -> "lst"}], " ).evalf() << endl;\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, " return 0;\n"];
    WriteString[cfile, "}\n"];

    Close[cfile];

    Run["c++ " <> filename <> " -o " <> exec <> " -lcln -lginac"];
    Run["./" <> exec <> " >> " <> exec <> ".out"];
  

    ginac = Import[exec <> ".out", "Plaintext"];
    ginac = Conjugate[ToExpression[StringReplace[ginac, {"E" -> "*^", "i" -> "I"}]]];

    If[Not[OptionValue[Debug]],
       Run["rm -rf " <> filename];
       Run["rm -rf " <> exec];
       Run["rm -rf " <> exec <> ".out"]
      ];
 
    If[resetdir, ResetDirectory[]];

    Return[ginac];

];

    

   


(* ::Section:: *)
(*Ginsh*)


GiNaC$FullFileCounter = 1;


Options[Ginsh] = {Debug -> False, GinshRunFile -> "Ginshtemplate", PrecisionGoal -> 30, BranchPoints -> {}, Truncation :> eGinsh$DefaultNTrunc, QTruncation :>eGinsh$DefaultQTrunc };


Options[GinshDeclareParam] = {BranchPoints -> {}, Point->{}, Truncation :> eGinsh$DefaultNTrunc, QTruncation :>eGinsh$DefaultQTrunc }
GinshDeclareParam[(Rule|RuleDelayed)[x_, y_],OptionsPattern[]] := "   " <> GinshForm[x,BranchPoints->OptionValue[BranchPoints],Point->OptionValue[Point],Truncation->OptionValue[Truncation],QTruncation->OptionValue[QTruncation]] <> " = evalf(" <> GinshForm[y/.Rational[a_,b_] -> GinshRational[a,GinshSlash[b]],BranchPoints->OptionValue[BranchPoints],Point->OptionValue[Point],Truncation->OptionValue[Truncation],QTruncation->OptionValue[QTruncation]] <> "):\n";


Clear[ToGiNaCZeta];
ToGiNaCZeta[{ws__}] := (ToGiNaCZeta[{ws}] = GiNaCZeta[Flatten[{Ginsh$LB,Abs /@ {ws},Ginsh$RB}],Flatten[{Ginsh$LB, Sign /@ {ws},Ginsh$RB}]]) /; Union[Sign /@ {ws}] =!= {1};
ToGiNaCZeta[{ws__}] := (ToGiNaCZeta[{ws}] = GiNaCZeta[Flatten[{Ginsh$LB,Abs /@ {ws},Ginsh$RB}]]) /; Union[Sign /@ {ws}] === {1};


(* MB2MPL higher-weight producers may return GPL words in either canonical
   variadic form G[a1,...,an,x] or list form G[{a1,...,an},x].  The generic
   variadic rule below treats a list word as one index and emits a nested
   CForm List(...), which ginsh rejects.  Canonicalize list words first. *)
ToGinshForm1 = {HoldPattern[G[ws_List, x_]] :>
                 G[Join[{Ginsh$LB}, ws, {Ginsh$RB}], x],
               HoldPattern[H[ws_List, x_]] :>
                 H[Join[{Ginsh$LB}, ws, {Ginsh$RB}], x],
               HoldPattern[HGinsh[ws_List, x_]] :>
                 HGinsh[Join[{Ginsh$LB}, ws, {Ginsh$RB}], x],
               HoldPattern[Rationalize[x_, tol___]] :> x,
               Li[ws_List, xs_List] :> Li[Append[Prepend[Reverse[ws],Ginsh$LB], Ginsh$RB], Append[Prepend[Reverse[xs],Ginsh$LB], Ginsh$RB]], 
               G[ws__, x_] :> G[{Ginsh$LB, ws, Ginsh$RB}, x],
               GIZero[ws_List, signs_List, x_] :> GIZero[Append[Prepend[ws,Ginsh$LB],Ginsh$RB], Append[Prepend[signs,Ginsh$LB],Ginsh$RB], x],
               H[ws__, x_]|HGinsh[ws__, x_] :> H[{Ginsh$LB, ws, Ginsh$RB}, x],
               HPL[{1}, 1] :> GiNaCH[{Ginsh$LB, 1, Ginsh$RB}, 1],
               Zeta[n_] :> ToGiNaCZeta[{n}],
               MZV[{ws__}] :> ToGiNaCZeta[{ws}],
               HPLs6 :> ToGiNaCZeta[{-5,-1}]+Pi^6/945,
               Complex[a_, b_] :> a+ b GinshI,
               Abs   :> Ginshabs,
               PolyLog[2, x_] :> Li2[x], PolyLog[n_, x_] :> Li[n, x], 
               PolyLog[m1_, m2_ ,x_]:> GiNaCH[{Ginsh$LB, Sequence @@ Table[0, {m1}], Sequence @@ Table[1, {m2}], Ginsh$RB}, x],
               Rational[a_,b_] -> GinshRational[a,GinshSlash[b]]};

ToGinshForm1bis = {Li[m__, 1/3] :> Li[m, GinshThird], Li[m__, -1/3] :> Li[m, -GinshThird],
                   GiNaCH[m_, 1/3] :> GiNaCH[m, GinshThird], GiNaCH[m_, -1/3] :> GiNaCH[m, -GinshThird],
                   Complex[a_, b_] :> a+ b GinshI,
                   Power[E, n_] :> exp[n]
};

ToGinshForm2 = {"List(Ginsh$LB," -> "{",
                ",Ginsh$RB)" -> "}",
                "PolylogTools_GiNaCH" -> "H",
                "PolyLogTools_GiNaCH" -> "H",
                "PolylogTools_H" -> "H",
                "PolyLogTools_H" -> "H",
                "Re(" -> "real_part(",
                "Im(" -> "imag_part(",
                "Log" -> "log",
                "EulerGamma" -> "Euler",
                "Power" -> "pow",
                "GiNaCZeta" -> "zeta",
                "GinshI" :> "I",
                "GIZero" :> "G",
                "Sqrt" -> "sqrt",
                "Conjugate" -> "conjugate",
                "GiNaCH" -> "H",
                "GinshThird" -> "1/3",
                "GinshRational" -> "",
                 ",GinshSlash" -> "/",
                 "Ginshabs" -> "abs"};

PLT$GreekLetters = {"\[Alpha]","\[Beta]","\[Gamma]","\[Delta]","\[Epsilon]","\[CurlyEpsilon]","\[Zeta]","\[Eta]","\[Theta]","\[CurlyTheta]","\[Iota]","\[Kappa]","\[CurlyKappa]","\[Lambda]","\[Mu]","\[Nu]","\[Xi]","\[Omicron]","\[CurlyPi]","\[Rho]","\[CurlyRho]","\[Sigma]","\[FinalSigma]","\[Tau]","\[Upsilon]","\[Phi]","\[CurlyPhi]","\[Chi]","\[Psi]","\[Omega]","\[Digamma]","\[Koppa]","\[Stigma]","\[Sampi]","\[CapitalAlpha]","\[CapitalBeta]","\[CapitalGamma]","\[CapitalDelta]","\[CapitalEpsilon]","\[CapitalZeta]","\[CapitalEta]","\[CapitalTheta]","\[CapitalIota]","\[CapitalKappa]","\[CapitalLambda]","\[CapitalMu]","\[CapitalNu]","\[CapitalXi]","\[CapitalOmicron]","\[CapitalPi]","\[CapitalRho]","\[CapitalSigma]","\[CapitalTau]","\[CapitalUpsilon]","\[CurlyCapitalUpsilon]","\[CapitalPhi]","\[CapitalChi]","\[CapitalPsi]","\[CapitalOmega]","\[CapitalDigamma]","\[CapitalKoppa]","\[CapitalStigma]","\[CapitalSampi]","\[CapitalSigma]","\[CapitalPi]","\[Epsilon]","\[Mu]","\[CapitalUpsilon]","\[FinalSigma]","\[Digamma]","\[Koppa]","\[Stigma]","\[Sampi]"};
PLT$GreekLetterNames=StringTake[ToString@FullForm@#,{4,-3}]&/@(PLT$GreekLetters);
PLT$GreekLetterMasker=ToString[#[[1]]]->StringJoin["_plt_",ToString[#[[2]]]]&/@MapThread[Symbol@#->Symbol@ToLowerCase@#2&,{PLT$GreekLetters,PLT$GreekLetterNames}];
PLT$GreekLetterUnMasker=#[[2]]->#[[1]]&/@PLT$GreekLetterMasker;
MaskHead=#//.(q:Except[List|Zeta|G|cG|H|HPL|Sqrt|Power|Log|PolyLog|Rational|Complex|GinshRational|GinshSlash|Li|Ginshabs|GinshThird|GiNaCH|Conjugate|GIZero|GinshI|Exp|exp|GiNaCZeta])[n_Integer]:>Symbol[ToString[q]<>"QpltQ"<>ToString[n]]&;
UnmaskHead[x_Symbol]:=UnMaskHead[ToString[x]]
UnmaskHead[str_String]/;!StringFreeQ[str,"QpltQ"]:=
With[{pos=First[StringPosition[str,"QpltQ"]]},
ToExpression[StringTake[str,pos[[1]]-1]][StringTake[str,{pos[[2]]+1,-1}]]]



Options[GinshForm] = {BranchPoints -> {}, Point -> {}, Truncation :> eGinsh$DefaultNTrunc, QTruncation :> eGinsh$DefaultQTrunc};
ToeGinshForm[bps_,pt_,trunc_,qtrunc_] := {};


GinshForm[ex_,OptionsPattern[]] := StringReplace[StringReplace[ToString[MaskHead[ex] //. Complex[a_,b_]:> a+ b*GinshI //. Rational[a_,b_] -> GinshRational[a,GinshSlash[b]] //. ToeGinshForm[OptionValue[BranchPoints],OptionValue[Point],OptionValue[Truncation],OptionValue[QTruncation]] /. ToGinshForm1 //. ToGinshForm1bis, CForm], ToGinshForm2],PLT$GreekLetterMasker];


Clear[NormalizeGToOneForGiNaC];
NormalizeGToOneForGiNaC[g_G] := NormalizeGToOneForGiNaC[g] = Block[{tg=g},

    tg = ExtractZeroes[tg];
    tg = tg //. G[ws___,Except[0,w_], Except[1,x_]] :> G @@ Factor[{ws,w,x}/x];
    Return[tg];
];


GToHGinsh[expr_] := expr /. G[inds__, x_] :> (-1)^(Length[Cases[{inds}, 1]]) * HGinsh[inds, x] /; Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}


ExtractExpForGinsh[expr_] := Block[{vars,gs,Ginsh$exp,temp=expr},

    temp = temp //. {(-1)^(r_Rational):>Ginsh$exp[I Pi r],Exp[a_]|E^(a_) :> Ginsh$exp[a]};

    If[FreeQ[temp,Ginsh$exp],
       Return[{expr, {}}]
      ];


    gs = GetGs[temp];
    vars = Union@@(GetGArguments /@ gs);
    vars = Union[Cases[Variables[vars],_Ginsh$exp],Cases[Variables[temp],_Ginsh$exp]];
    vars = Inner[Rule, Table[Unique["expvar"],{Length[vars]}], vars, List];
    temp = temp //. (Reverse/@vars);
    vars = vars //. Ginsh$exp -> Exp;
    Return[{temp //. Ginsh$exp -> Exp, vars}]
]; 


Ginsh[expr_, inputs_List, OptionsPattern[]] := Block[{workingdir, 
    resetdir = True,
    exec = OptionValue[GinshRunFile] <>"_"<>ToString[$KernelID] <> "_" <> ToString[GiNaC$FullFileCounter++],
    filename,
    cfile,
    ginac,
    params = GinshDeclareParam /@ Join[inputs, Flatten[List[OptionValue[BranchPoints]]]],
    tempexpr,ginshpltone
},


    filename = exec;

    Off[SetDirectory::cdir];
    workingdir = SetDirectory[GiNaC$InterfacePath];
    If[workingdir === $Failed, 
       resetdir = False;
       workingdir = Directory[]
      ];

   tempexpr = expr;
   If[Not[FreeQ[expr,GR|GI]],
      params = Append[params, GinshDeclareParam[ginshpltone -> 1,BranchPoints->OptionValue[BranchPoints],Point->inputs,Truncation->OptionValue[Truncation],QTruncation->OptionValue[QTruncation]]];
      tempexpr = tempexpr //. {GR[as__] :> 1/2 G[as,ginshpltone] + 1/2 G[Sequence@@Conjugate[{as}],ginshpltone],
                               GI[as__] :> -I/2 G[as,ginshpltone] + I/2 G[Sequence@@Conjugate[{as}],ginshpltone]}
      ];
      


   tempexpr = cGToG[cCTocG[ClToLi[tempexpr]]] //. G[ws__, Except[1,x_]] :> NormalizeGToOneForGiNaC[G[ws,x]];

(*Fix November 2018 *)
   tempexpr = ExtractExpForGinsh[tempexpr];
   params = Join[params, (GinshDeclareParam /@ (tempexpr[[2]]//.inputs))];
   tempexpr= tempexpr[[1]];
(*End Fix Novembr 2018*)
     

    cfile = OpenWrite[filename];


    WriteString[cfile, "  Digits = ", ToString[OptionValue[PrecisionGoal]], ":\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, #]& /@ params;
    WriteString[cfile, "\n"];
    WriteString[cfile, " expression = ", GinshForm[GToHGinsh[tempexpr],BranchPoints->OptionValue[BranchPoints],Point->inputs,Truncation->OptionValue[Truncation],QTruncation->OptionValue[QTruncation]] , " :\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, " evalf(expression);\n"];
    WriteString[cfile, "quit:\n"];

    Close[cfile];

    Run["ginsh " <> filename <> " >> " <> exec <> ".txt"];
  

    ginac = Import[exec <> ".txt"];

    ginac = StringReplace[StringSplit[ginac][[-1]],PLT$GreekLetterUnMasker];
    ginac = Chop[ToExpression[StringReplace[ginac, {"E" -> "*^", "i" -> "I"}]], 10^(-OptionValue[PrecisionGoal])];

    (*ginac = ToExpression[StringReplace[ginac, {"E" -> "*^", "i" -> "I"}]];*)

    If[Not[OptionValue[Debug]],
       Run["rm -rf " <> filename];
       Run["rm -rf " <> exec];
       Run["rm -rf " <> exec <> ".txt"]
      ];
 

    If[resetdir, ResetDirectory[]];

    If[ginac === expressIon,vPrint[Style["Failed to evaluate expression ",Red],expr,Style[" numerically",Red]]];
  

    Return[ginac];

];

    

   





(* ::Section:: *)
(*Ginsh2*)


ToGinshFormFunctions = {Li[ws_List, xs_List] :> Li[Append[Prepend[Reverse[ws],Ginsh$LB], Ginsh$RB], Append[Prepend[Reverse[xs],Ginsh$LB], Ginsh$RB]], 
               G[ws__, x_] :> G[{Ginsh$LB, ws, Ginsh$RB}, x],
               GIZero[ws_List, signs_List, x_] :> GIZero[Append[Prepend[ws,Ginsh$LB],Ginsh$RB], Append[Prepend[signs,Ginsh$LB],Ginsh$RB], x],
               H[ws__, x_]|HGinsh[ws__, x_] :> H[{Ginsh$LB, ws, Ginsh$RB}, x],
               HPL[{1}, 1] :> GiNaCH[{Ginsh$LB, 1, Ginsh$RB}, 1],
               Zeta[n_] :> ToGiNaCZeta[{n}],
               MZV[{ws__}] :> ToGiNaCZeta[{ws}],
               HPLs6 :> ToGiNaCZeta[{-5,-1}]+Pi^6/945,
               Abs   :> Ginshabs,
               PolyLog[2, x_] :> Li2[x], PolyLog[n_, x_] :> Li[n, x], 
               PolyLog[m1_, m2_ ,x_]:> GiNaCH[{Ginsh$LB, Sequence @@ Table[0, {m1}], Sequence @@ Table[1, {m2}], Ginsh$RB}, x]};


ToGinshFormRationals = {Complex[a_, b_] :> a+ b GinshI,
               Rational[a_,b_] -> GinshRational[a,GinshSlash[b]],
	I->GinshI};


GinshForm2[ex_] := StringReplace[StringReplace[ToString[MaskHead[ex] //.ToGinshFormRationals /. ToGinshFormFunctions//. ToGinshForm1bis, CForm], ToGinshForm2],PLT$GreekLetterMasker];


Options[Ginsh2] = {Debug -> False, GinshRunFile -> "Ginshtemplate", PrecisionGoal -> 30};

Ginsh2[expr_, inputs_List, OptionsPattern[]] := Block[{workingdir, 
    resetdir = True,
    exec = OptionValue[GinshRunFile] <>"_"<>ToString[$KernelID] <> "_" <> ToString[GiNaC$FullFileCounter++],
    filename,
    cfile,
    ginac,
    params = GinshDeclareParam /@ inputs,
    tempexpr,ginshpltone
},


    filename = exec;

    Off[SetDirectory::cdir];
    workingdir = SetDirectory[GiNaC$InterfacePath];
    If[workingdir === $Failed, 
       resetdir = False;
       workingdir = Directory[]
      ];

   tempexpr = expr;
   If[Not[FreeQ[expr,GR|GI]],
      params = Append[params, GinshDeclareParam[ginshpltone -> 1]];
      tempexpr = tempexpr //. {GR[as__] :> 1/2 G[as,ginshpltone] + 1/2 G[Sequence@@Conjugate[{as}],ginshpltone],
                               GI[as__] :> -I/2 G[as,ginshpltone] + I/2 G[Sequence@@Conjugate[{as}],ginshpltone]}
      ];
      


   tempexpr = cGToG[cCTocG[ClToLi[tempexpr]]] //. G[ws__, Except[1,x_]] :> NormalizeGToOneForGiNaC[G[ws,x]];
     

    cfile = OpenWrite[filename];


    WriteString[cfile, "  Digits = ", ToString[OptionValue[PrecisionGoal]], ":\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, #]& /@ params;
    WriteString[cfile, "\n"];
    WriteString[cfile, " expression = ", GinshForm2[GToHGinsh[tempexpr]] , " :\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, " evalf(expression);\n"];
    WriteString[cfile, "quit:\n"];

    Close[cfile];

    Run["ginsh " <> filename <> " >> " <> exec <> ".txt"];
  

    ginac = Import[exec <> ".txt"];

    ginac = StringReplace[StringSplit[ginac][[-1]],PLT$GreekLetterUnMasker];
    ginac = Chop[ToExpression[StringReplace[ginac, {"E" -> "*^", "i" -> "I"}]], 10^(-OptionValue[PrecisionGoal])];

    (*ginac = ToExpression[StringReplace[ginac, {"E" -> "*^", "i" -> "I"}]];*)

    If[Not[OptionValue[Debug]],
       Run["rm -rf " <> filename];
       Run["rm -rf " <> exec];
       Run["rm -rf " <> exec <> ".txt"]
      ];
 

    If[resetdir, ResetDirectory[]];

    If[ginac === expressIon,vPrint[Style["Failed to evaluate expression ",Red],expr,Style[" numerically",Red]]];
  

    Return[ginac];

];


(* ::Section::Closed:: *)
(*FullEval*)


Eval$FullFileCounter = 1;


Options[FullEval] = {Debug -> True, GiNaCRunFile -> "GiNaCtemplate", PrecisionGoal -> 30};


GiNaCDeclareParam[(Rule|RuleDelayed)[x_, y_]] := ToString[x, CForm] <> " = " <> ToString[y, CForm] <> " :\n";


ToGiNaCForm1 = {Li[ws_List, xs_List] :> Li[Reverse[ws], xs], 
               G[ws__, x_] :> G[{ws}, x],
               H[ws__, x_] :> H[{ws}, x],
               Zeta[n_] :> GiNaCZeta[n],
               MZV[ws__] :> GiNaCZeta[{ws}]};

ToGiNaCForm2 = {"List" -> "lst",
                "Log" -> "log",
                "EulerGamma" -> "Euler",
                "Power" -> "pow",
                "GiNaCZeta" -> "zeta"};

GiNaCForm[ex_] := StringReplace[ToString[ex /. ToGiNaCForm1, CForm], ToGiNaCForm2];


FullEval[expr_, inputs_List, OptionsPattern[]] := Block[{workingdir, 
    resetdir = True,
    exec = OptionValue[GiNaCRunFile] <> ToString[GiNaC$FullFileCounter++],
    filename,
    cfile,
    ginac,
    params = GiNaCDeclareParam /@ inputs
},


    filename = exec <> ".cc";

    Off[SetDirectory::cdir];
    workingdir = SetDirectory[GiNaC$InterfacePath];
    If[workingdir === $Failed, 
       resetdir = False;
       workingdir = Directory[]
      ];


     

    cfile = OpenWrite[filename];
    WriteString[cfile, "#include <iostream>\n"];
    WriteString[cfile, "#include <ginac/ginac.h>\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, "int main() \n"];
    WriteString[cfile, " {\n"];
    WriteString[cfile, "  using namespace std;\n"];
    WriteString[cfile, "  using namespace GiNaC;\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, "  Digits = ", ToString[OptionValue[PrecisionGoal]], ";\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, #]& /@ params;
    WriteString[cfile, "\n"];
    WriteString[cfile, " cout << ( ", GiNaCForm[expr] , " ).evalf() << endl;\n"];
    WriteString[cfile, "\n"];
    WriteString[cfile, " return 0;\n"];
    WriteString[cfile, "}\n"];

    Close[cfile];

    Run["c++ -O2 " <> filename <> " -o " <> exec <> " -lcln -lginac"];
    Run["./" <> exec <> " >> " <> exec <> ".out"];
  

    ginac = Import[exec <> ".out", "Plaintext"];
    ginac = Conjugate[ToExpression[StringReplace[ginac, {"E" -> "*^", "i" -> "I"}]]];

    If[Not[OptionValue[Debug]],
       Run["rm -rf " <> filename];
       Run["rm -rf " <> exec];
       Run["rm -rf " <> exec <> ".out"]
      ];
 
    If[resetdir, ResetDirectory[]];

    Return[ginac];

];

    

   
