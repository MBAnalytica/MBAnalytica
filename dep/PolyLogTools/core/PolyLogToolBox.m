(* ::Package:: *)

(* ::Title:: *)
(*Tools*)


NotContainsTranscendentalFunctionQ[l_] := FreeQ[l,G] && FreeQ[l,H] && FreeQ[l,HPL] && FreeQ[l,Zeta] && FreeQ[l,MZV] && FreeQ[l,Pi] && FreeQ[l,SVH] && FreeQ[l,cG] && FreeQ[l,cL] && FreeQ[l,Log] && FreeQ[l,PolyLog];


(* ::Section:: *)
(*Conversion*)


HToG[expr_] := expr /. H[inds__, x_] :> (-1)^(Length[Cases[{inds}, 1]]) * G[inds, x];

cLTocG[expr_] := expr /. cL[inds__, x_] :> (-1)^(Length[Cases[{inds}, 1]]) * cG[inds, x];

GToH[expr_] := expr /. G[inds__, x_] :> (-1)^(Length[Cases[{inds}, 1]]) * H[inds, x] /; Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1};

cGTocL[expr_] := expr /. cG[inds__, x_] :> (-1)^(Length[Cases[{inds}, 1]]) * cL[inds, x] /; Union[{inds}] === {0,1} || Union[{inds}] === {1} || Union[{inds}] === {0};

HToHPL[expr_] := GToH[expr] /. H[ws__,x_] :> HPL[{ws},x];

HPLToH[expr_] := expr /. HPL[w_List, x_] :> H[Sequence @@ HPLMtoA[w],x];

HPLToG[expr_] := HToG[HPLToH[expr]];

GToHPL[expr_] := HToHPL[GToH[expr]];

ClToLi[expr_] := expr //. {Cl[n_Integer, a_] /; EvenQ[n] :> 1/2/I(PolyLog[n,E^(I a)] - PolyLog[n,E^(-I a)]),Cl[n_Integer, a_] /; OddQ[n] :> 1/2(PolyLog[n,E^(I a)] + PolyLog[n,E^(-I a)])};

GRToG[as__]:=1/2((G@@{as,1})+(G@@Conjugate[{as,1}]));
GIToG[as__]:=1/2/I((G@@{as,1})-(G@@Conjugate[{as,1}]));
GRGIToG[expr_]:=expr//.{GR->GRToG,GI->GIToG};


Gm[ms_List,x_List,$z_]:=Block[{maketab,matrix,g},

   maketab[{m_,y_}]:=Append[Table[0,{m-1}],y];

   matrix=Transpose[{ms,x}];
   matrix=Flatten[maketab/@matrix];
   g=Append[G@@matrix,$z];

   Return[g];
];


LiG[ms_List, xs_List] := Block[{
   depth = Length[ms],
   xx, myTab, dum
   },

  If[depth == 1,
     Return[-G[Sequence @@ Join[Table[0, {ms[[1]] -1}], {1, xs[[1]]}]]];
    ];

  xx = Table[Product[1/xs[[$ii]], {$ii, $kk, depth}], {$kk, depth}];
  xx = Flatten[Inner[Prepend, dum @@@ ((myTab[0,{#-1}]& /@ ms) /. myTab -> Table), xx, List] /. dum -> List];
  xx = Append[Reverse[xx], 1];

  Return[(-1)^depth (G @@ xx)];
];


GLi[ws___, w0_?(#=!=0&), x_] := Block[{ms, xs},

    ms = {ws,w0} //. {ws1___, Except[0|1, _], ws2___} :> {ws1, 1, ws2};
    ms = ms //. {ws1___, 0, Except[0, i_], ws2___} :> {ws1, i+1, ws2};
    ms = Reverse[ms];

    xs = Prepend[DeleteCases[{ws, w0} / x, 0], 1];

    xs = Reverse[Table[xs[[i]]/xs[[i+1]], {i, Length[xs] -1}]];

    Return[(-1)^Length[ms] * Li[ms, xs]];

];


GToLi[expr_] := Expand[ExtractZeroes[expr] /. G[ws___, Except[0, w_], x_] :> GLi[ws,w,x]];

LiToG[expr_] := Expand[expr /. {Li -> LiG, 
                                 PolyLog[n_, x_]:> -G @@ Join[Table[0, {n-1}], {1, x}],
                                 PolyLog[n_, m_, x_]:> (-1)^m G @@ Join[Table[0, {n}], Table[1, {m}], {x}],
                                 Log[x_] :> G[0,x]
                                 }];


(* ::Section:: *)
(*Normalisation*)


NormalizeG[expr_] := ExtractZeroes[expr] /. {G[ws___, Except[0, w1_], x_] :> G @@ ({ws,w1,x}/x),
                                             cG[ws___, Except[0, w1_], x_] :> cG @@ ({ws,w1,x}/x),
                                             cC[ws___, Except[0, w1_], x_] :> cC @@ ({ws,w1,x}/x)};


(* ::Section:: *)
(*Special Values*)


G[ws__, 0] := 0 /; Union[{ws}] =!= {0};
H[ws__, 0] := 0 /; Union[{ws}] =!= {0};


(*H[ws__, 1] := HPL[{ws}, 1] /; PLT$AutoConvertToKnownConstants;
H[ws__, -1] := HPL[{ws}, -1] /; PLT$AutoConvertToKnownConstants;*)
H[ws__, 1] := (-1)^Length[Cases[{ws},1]] * G[ws, 1] /; PLT$AutoConvertToKnownConstants;
H[ws__, -1] := (-1)^Length[Cases[{ws},1]] * G[ws, -1] /; PLT$AutoConvertToKnownConstants;
H[ws__, I] := HPL[{ws}, I] /; PLT$AutoConvertToKnownConstants;
H[ws__, -I] := Conjugate[HPL[{ws}, I]] /; PLT$AutoConvertToKnownConstants;


(*H[ws___,0,-1/2] := Block[{xhalf}, (HPLToH[HPLReduceToMinimalSet[HPL[{ws,0},xhalf]]]/.H[0,xhalf] :> Log[xhalf]/. xhalf -> -1/2 )] /; PLT$AutoConvertToKnownConstants;
H[ws___,0,-1/3] := Block[{xhalf}, (HPLToH[HPLReduceToMinimalSet[HPL[{ws,0},xhalf]]]/.H[0,xhalf] :> Log[xhalf]/. xhalf -> -1/3 )] /; PLT$AutoConvertToKnownConstants*)


G[1,1] := -HPL[{1},1] /; PLT$AutoConvertToKnownConstants && PLT$ShuffleRegularisation;
G[1,inds__,1] := 1/(Length[{inds}]+1)! G[1,1]^(Length[{inds}]+1) /; Union[{inds}] === {1} && PLT$AutoConvertToKnownConstants && PLT$ShuffleRegularisation;
G[1,inds__,1] := Block[{PLT$one, indis = {1,inds},work},
     indis = If[#===1,PLT$one,#]&/@ indis;
     Return[ExtractShuffleSingularities[G[Sequence@@indis,PLT$one]] //. PLT$one->1];
] /; (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants && PLT$ShuffleRegularisation;

G[Except[1,w1_],inds___,1] := (-1)^Length[Cases[{w1,inds},1]]*HPL[{w1,inds},1] /; (Union[{w1,inds}] === {-1,0,1} || Union[{w1,inds}] === {0,1} || Union[{w1,inds}] === {-1,0}  || Union[{w1,inds}] === {-1,1} || Union[{w1,inds}] === {0} || Union[{w1,inds}] === {-1}) && PLT$AutoConvertToKnownConstants && PLT$ShuffleRegularisation;

G[-1,-1] := -HPL[{1},1] /; PLT$AutoConvertToKnownConstants && PLT$ShuffleRegularisation;
G[-1,inds__,-1] := 1/(Length[{inds}]+1)! G[-1,-1]^(Length[{inds}]+1) /; Union[{inds}] === {-1} && PLT$AutoConvertToKnownConstants && PLT$ShuffleRegularisation;
G[-1,inds__,-1] := Block[{PLT$one, indis = {-1,inds},work},
     indis = If[#===-1,PLT$one,#]&/@ indis;
     Return[ExtractShuffleSingularities[G[Sequence@@indis,PLT$one]] //. PLT$one->-1];
] /; (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants && PLT$ShuffleRegularisation;

G[Except[-1,w1_],inds___,-1] := (-1)^Length[Cases[{w1,inds},1]]*HPL[{w1,inds},-1] /; (Union[{w1,inds}] === {-1,0,1} || Union[{w1,inds}] === {0,1} || Union[{w1,inds}] === {-1,0}  || Union[{w1,inds}] === {-1,1} || Union[{w1,inds}] === {1} || Union[{w1,inds}] === {0} || Union[{w1,inds}] === {-1}) && PLT$AutoConvertToKnownConstants && PLT$ShuffleRegularisation;

G[inds__, 1] := (-1)^Length[Cases[{inds},1]]*HPL[{inds},1] /;  (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants && Not[PLT$ShuffleRegularisation];
G[inds__, -1] := (-1)^Length[Cases[{inds},1]]*HPL[{inds},-1] /;  (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants && Not[PLT$ShuffleRegularisation];

G[inds__, I] := (-1)^Length[Cases[{inds},1]]*HPL[{inds},I] /;  (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants;
G[inds__, -I] := (-1)^Length[Cases[{inds},1]]*Conjugate[HPL[{inds},I]] /;  (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants;

G[inds__, -1] := G @@ (I {inds, -1}) /;  Complement[Union[{inds}] , {-I,0,I}] === {} && Last[{inds}] =!= 0 && PLT$AutoConvertToKnownConstants;
G[inds__, 1] := G @@ (I {inds, 1}) /;  Complement[Union[{inds}] , {-I,0,I}] === {} && Last[{inds}] =!= 0 && PLT$AutoConvertToKnownConstants;
G[inds__, -I] := G @@ (I {inds, -I}) /;  Complement[Union[{inds}] , {-I,0,I}] === {} && Last[{inds}] =!= 0 && PLT$AutoConvertToKnownConstants;
G[inds__, I] := G @@ (I {inds, I}) /;  Complement[Union[{inds}] , {-I,0,I}] === {} && Last[{inds}] =!= 0 && PLT$AutoConvertToKnownConstants;

G[inds__,0, 1] := Block[{xxx}, ExtractZeroes[G[inds,0,xxx]]/. xxx->1] /;  Complement[Union[{inds}] , {-I,0,I}] === {} && PLT$AutoConvertToKnownConstants;



(*G[inds__, 1/2] := (-1)^Length[Cases[{inds},1]]*H[inds,1/2] /;  (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants;
G[inds__, 1/3] := (-1)^Length[Cases[{inds},1]]*H[inds,1/3] /;  (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants;
G[inds__, -1/2] := (-1)^Length[Cases[{inds},1]]*H[inds,-1/2] /;  (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants;
G[inds__, -1/3] := (-1)^Length[Cases[{inds},1]]*H[inds,-1/3] /;  (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants;
G[inds__, 2/3] := (-1)^Length[Cases[{inds},1]]*H[inds,2/3] /;  (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants;*)

H[ws__, 1/2] /; PLT$AutoConvertToKnownConstants := Block[{xhalf}, HToG[H[ws,xhalf]] //. xhalf -> 1/2];
H[ws__, 1/3] /; PLT$AutoConvertToKnownConstants := Block[{xhalf}, HToG[H[ws,xhalf]] //. xhalf -> 1/3];
H[ws__, -1/2] /; PLT$AutoConvertToKnownConstants := Block[{xhalf}, HToG[H[ws,xhalf]] //. xhalf -> -1/2];
H[ws__, -1/3] /; PLT$AutoConvertToKnownConstants := Block[{xhalf}, HToG[H[ws,xhalf]] //. xhalf -> -1/3];



Li[ms_List,zs_List] /; PLT$AutoConvertToKnownConstants && SubsetQ[{1,-1},Union[zs]] := LiG[ms,zs];


(* ::Section:: *)
(*GLog*)


GLog[0, $z_] := Log[$z];

GLog[a_, $z_] := Log[1-$z/a];


GLog[0, 0, $z_] := Log[$z]^2/2;

GLog[0, a_, $z_] := - PolyLog[2, $z/a];

GLog[a_, 0, $z_] := GLog[0, $z] GLog[a,$z] - GLog[0, a, $z];

GLog[b_, a_, $z_] := PolyLog[2, (a-$z)/(a-b)] - PolyLog[2, a/(a-b)] + Log[1-$z/a]Log[($z-b)/(a-b)];

GLog[a_, a_, $z_] := GLog[a, $z]^2/2;

GLog[a_, 1, 1] := -PolyLog[2, 1/(1-a)];



(* ::Section:: *)
(*Gamma functions*)


Unprotect[PolyGamma];
PolyGamma[n_,1]:=-(-1)^n n! Zeta[n+1] /; (n > 1) && EvenQ[n] /; PLT$AutoConvertToKnownConstants;
PolyGamma[n_, m_]:=PolyGamma[n,m-1]+(-1)^n n!/(m-1)^(n+1) /; PLT$AutoConvertToKnownConstants && IntegerQ[m] && (m >1) && EvenQ[n] && (n>1);
PolyGamma[0, 1/2] := -EulerGamma - 2 Log[2]/;PLT$AutoConvertToKnownConstants;
PolyGamma[n_, 1/2] := (-1)^(n+1) n! (2^(n+1)-1) Zeta[n+1] /; PLT$AutoConvertToKnownConstants&&(n > 1)&&EvenQ[n];
PolyGamma[n_, Rational[m_,2]] := PolyGamma[n, (m-2)/2] + (-1)^n n!/((m-2)/2)^(n+1)/;PLT$AutoConvertToKnownConstants&&EvenQ[n]&&(n>1)&&(m>1)&&OddQ[m];
Protect[PolyGamma];


NPolyGammas={PolyGamma[n_?(#>0&),1]:>-(-1)^n n! Zeta[n+1],
             PolyGamma[n_, m_?(IntegerQ[#] ===True && # >1 &)]:>PolyGamma[n,m-1]+(-1)^n n!/(m-1)^(n+1),
             PolyGamma[0, 1/2] :> -EulerGamma - 2 Log[2],
             PolyGamma[n_, 1/2] :> (-1)^(n+1) n! (2^(n+1)-1) Zeta[n+1] /; n > 1,
             PolyGamma[n_, 3/2] :> PolyGamma[n, 1/2] + (-1)^n n!/(1/2)^(n+1),
             PolyGamma[n_, -1/2] :> PolyGamma[n, 1/2] - (-1)^n n!/(1/2)^(n+1),
             PolyGamma[n_, -3/2] :> PolyGamma[n, -1/2] - (-1)^n n!/(-1/2)^(n+1),
             PolyGamma[n_, 5/2] :> PolyGamma[n, 3/2] + (-1)^n n!/(3/2)^(n+1)};

RedSin={Sin[Pi ee_]:>Pi ee/Gamma[1+ee]/Gamma[1-ee],Csc[Pi ee_]:>Gamma[1+ee]Gamma[1-ee]/Pi/ee, Cot[Pi ee_]:> (Gamma[1 - ee]^2*Gamma[1 + ee]^2)/(ee*Pi*Gamma[1 - 2*ee]*Gamma[1 + 2*ee]),
        Sec[Pi ee_] :> Gamma[1+2ee]Gamma[1-2ee]/Gamma[1+ee]/Gamma[1-ee],
        Cos[Pi ee_] :> Gamma[1+ee]Gamma[1-ee]/Gamma[1+2ee]/Gamma[1-2ee],
        Tan[Pi ee_] :> (ee*Pi*Gamma[1 - 2*ee]*Gamma[1 + 2*ee])/(Gamma[1 - ee]^2*Gamma[1 + ee]^2),
        Gamma[1/2 + ee_] :> Gamma[2 ee]/((2Pi)^(-1/2)2^(2ee-1/2)Gamma[ee]),
        Gamma[-1/2+ee_] :> Gamma[1/2+ee]/(-1/2+ee)};



(* ::Section::Closed:: *)
(**)


ReduceCoeffs[expr_]:=Block[{cof,rules},
cof=Cases[Union[(List@@Expand[expr])/.c[i_]_:>c[i]],_c];
rules=Dispatch[Table[cof[[i]]->c[i],{i,Length[cof]}]];
Return[expr/.rules];
];
CountCoeffs[expr_]:=Block[{cof},
cof=Cases[Union[(List@@Expand[expr])/.c[i_]_:>c[i]],_c];
Return[Length[cof]];
];


(* ::Section:: *)
(*GArgumentSimplify*)


(*GetGs[expr_] := Union[If[Head[#]===Times, Sequence@@#,#]&/@Union[Select[If[Head[Expand[expr]] === Plus, List @@ Expand[expr], {Expand[expr]}], Not[FreeQ[#, G]]&]//. g_G^_:>g//. a_ g_G^_. :> g/;FreeQ[a,G]]];*)
GetGs[expr_] := Cases[Variables[expr], _G|_cG|_cC];
GetGs[list_List] := Union[Flatten[GetGs /@ list]];


GetGArguments[expr_] := Union[Flatten[List@@@GetGs[HToG[HPLToH[expr//.cG->G]]]]];
GetGArguments[list_List] := Union @@ (GetGArguments/@list);

GetGIndices[expr_] := Union[Flatten[GetGs[HToG[HPLToH[expr//.{cG|cC->G}]]] //. G[ws__,_]:>{ws}]];
GetGIndices[list_List] := Union @@ (GetGIndices/@list);



GArgumentSimplify[expr_] := expr //. {G[as__,x_] :> GArgumentSimplifier[as, x],
                                      cG[as__,x_] :> cGArgumentSimplifier[as, x],
                                      cC[as__,x_] :> cCArgumentSimplifier[as, x],
                                       Li[m_List, x_List] :> LiArgumentSimplifier[m,x],
                                       PolyLog[n_, x_] :> PolyLog[n, SimplifyArgument[x]],
                                       Log[x_] :> Log[SimplifyArgument[x]]
                                       };


GArgumentSimplifier[as__, x_] := GArgumentSimplifier[as, x] = G @@ (SimplifyArgument /@ {as,x});
cGArgumentSimplifier[as__, x_] := cGArgumentSimplifier[as, x] = cG @@ (SimplifyArgument /@ {as,x});
cCArgumentSimplifier[as__, x_] := cCArgumentSimplifier[as, x] = cC @@ (SimplifyArgument /@ {as,x});
LiArgumentSimplifier[m_List,x_List] := LiArgumentSimplifier[m, x] = Li[m, SimplifyArgument /@ x];


SimplifyArgument[expr_] := SimplifyArgument[expr] = Factor[Simplify[expr], Extension -> $QExtension];


(* ::Section:: *)
(*Coefficient Simplify*)


GCollector[a_,b_. g_G^n_.]:=GCollector[a g^n,b];
GCollector[a_,b_. g_cG^n_.]:=GCollector[a g^n,b];
GCollector[a_,b_. g_cC^n_.]:=GCollector[a g^n,b];
GCollector[a_,b_. g_PolyLog^n_.]:=GCollector[a g^n,b];
GCollector[a_,b_. g_H^n_.]:=GCollector[a g^n,b];
GCollector[a_,b_. g_Li^n_.]:=GCollector[a g^n,b];
GCollector[a_,b_. g_Log^n_.]:=GCollector[a g^n,b];
GCollector[a_,b_. g_Zeta^n_.]:=GCollector[a g^n,b];
GCollector[a_,b_. g_MZV^n_.]:=GCollector[a g^n,b];
GCollector[a_,b_. Pi^n_.]:=GCollector[a Pi^n,b];
GCollector[a_,b_. EulerGamma^n_.]:=GCollector[a EulerGamma^n,b];
GCollector[a_,sum_Plus]:=GCollector[a,#]&/@sum


GCoefficientSimplifier[list_List]:=list[[1,1]]Simplify[Plus@@list[[All,2]]];
GCoefficientFullSimplifier[list_List]:=list[[1,1]]FullSimplify[Plus@@list[[All,2]]];


GCoefficientSimplifyApply[expr_, func_]:=Block[{
    temp=Expand[expr]
    },

    temp = GArgumentSimplify[temp];
    
    If[Head[temp] =!= Plus,
       Return[Simplify[temp]]
      ];

    temp = GatherBy[List@@GCollector[1,temp], First];

    temp = func /@ temp;

    temp = Plus@@temp;
 
    Return[temp];
];


GCoefficientSimplify[expr_] := GCoefficientSimplifyApply[expr, GCoefficientSimplifier];
GCoefficientFullSimplify[expr_] := GCoefficientSimplifyApply[expr, GCoefficientFullSimplifier];


(* ::Section:: *)
(*GIntegrate*)


IntegrandCollector[sum_Plus, a_, var_] := IntegrandCollector[#,a, var]& /@ sum;
IntegrandCollector[a_ b_, c_, var_] := IntegrandCollector[a, b c, var] /; FreeQ[b, var];
IntegrandCollector[Except[1,b_], c_, var_] := IntegrandCollector[1, b c, var] /; FreeQ[b, var];


IntegrandCollectorSummer[list_List] := {Plus @@ list[[All, 2]], list[[1,1]]};


GIntegrate[expr_, var:(_symbol|_symbol[_integer]), var0_] := GIntegrate[expr, var] /. var -> var0;


GIntegrate[expr_, var:(_symbol|_symbol[_integer]), var0_, var1_] := Expand[GIntegrate[expr, var, var1] - GIntegrate[expr, var, var0]];


GIntegrate[expr_, {var:(_symbol|_symbol[_integer]), var0_, var1_}] := GIntegrate[expr, var, var0, var1];


GIntegrate[expr_, var:(_Symbol|_Symbol[_Integer])] := Block[{
    temp = expr
    },

    temp = GatherObjectsMatrix[temp, Gather -> Rationals];
    temp = {ShuffleG[Expand[#[[1]]]], Apart[#[[2]], var]}& /@ temp;
    temp = Expand[Plus @@ (Times @@@ temp)];

    temp = IntegrandCollector[temp, 1, var];

    temp = If[Head[temp] === Plus,
              List @@ temp,
              {temp}
              ];

    temp = GatherBy[temp, First];
    temp = IntegrandCollectorSummer /@ temp;
    temp = MapAt[Gint[#,var,var]&, #, 2]& /@ temp;

    temp = Plus @@ (Times @@@ temp);

    Return[temp];
];
    
    


(* ::Section:: *)
(*GatherObjects*)


TranscendentalCollector[sum_Plus,a_]:=TranscendentalCollector[#,a]&/@sum;
TranscendentalCollector[b_. g_G^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_GR^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_GI^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_Cl^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_cG^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_cC^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_H^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_Li^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_Log^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_PolyLog^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_Zeta^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. g_MZV^n_.,a_]:=TranscendentalCollector[b, g^n a];
TranscendentalCollector[b_. Pi^n_.,a_]:=TranscendentalCollector[b, Pi^n a];
TranscendentalCollector[b_. g_CiTi,a_]:=TranscendentalCollector[b, g a];
TranscendentalCollector[b_. g_CT,a_]:=TranscendentalCollector[b, g a];


RationalPrefactorCollector[b_ g_Integer,a_]:=RationalPrefactorCollector[b, g a];
RationalPrefactorCollector[b_ g_Rational,a_]:=RationalPrefactorCollector[b, g a];
RationalPrefactorCollector[b_ g_Complex,a_]:=RationalPrefactorCollector[b, g a];
RationalPrefactorCollector[Except[1,g_Integer],a_]:=RationalPrefactorCollector[1, g a];
RationalPrefactorCollector[Except[1,g_Rational],a_]:=RationalPrefactorCollector[1, g a];
RationalPrefactorCollector[Except[1,g_Complex],a_]:=RationalPrefactorCollector[1, g a];


Options[GatherObjectsMatrix]:=Options[GatherObjects];

GatherObjectsMatrix[expr_,OptionsPattern[]]:=Block[{temp=Expand[expr],RPC2},
   temp=TranscendentalCollector[temp,1];

   If[OptionValue[Gather]===Rationals,
      temp=temp//.TranscendentalCollector->RationalPrefactorCollector;
     ];

   temp=If[Head[temp]===Plus,
           List@@temp,
           {temp}
           ];

   temp =List@@@temp;

   If[OptionValue[Gather]===Rationals,
      temp=Reverse/@temp
      ];

   temp = GatherBy[temp,Last];
   temp = (List[(Plus@@#[[All,1]]),Factor[#[[1,2]],Extension->$QExtension]]&/@temp);

   If[OptionValue[Gather]===Rationals,
      temp=Reverse/@temp;
      temp=RationalPrefactorCollector@@@temp;
      temp=Reverse/@temp;
      temp=List@@@temp;
     ];

   temp=GatherBy[temp,Last];
   temp=List[Factor[#[[1,2]], Extension->$QExtension],Expand[Plus@@#[[All,1]]]]&/@temp;

   temp=GatherBy[temp,First];
   temp=List[#[[1,1]],Expand[Plus@@#[[All,2]]]]&/@temp;

   If[OptionValue[Gather]===Rationals,
      temp=Reverse/@temp
      ];

   Return[temp];
];


Options[GatherObjects] = {Gather -> Automatic};

GatherObjects[expr_, OptionsPattern[]] := Plus @@ (Times @@@ GatherObjectsMatrix[expr, Gather -> OptionValue[Gather]]);


GatherTranscendentals[expr_]:=GatherObjects[expr];

GatherPrefactors[expr_]:=GatherObjects[expr,Gather->Rationals];


CoefficientManipulate[expr_,func_] := Total[Times @@@ (MapAt[func,#,2]& /@ GatherObjectsMatrix[expr])];


(* ::Section:: *)
(*Derivatives*)


DerG::Weight="Derivatives are only available for polylogarithms up to weight 8.";

PLT$DGFunctions = {cL,cG,G,H,Li,CT,CiTi};



DG[list_List, x_] := DG[#,x]& /@ list;

DG[sum_Plus,y_]:=DG[#,y]&/@sum;
DG[a_ b_,y_]:=a DG[b,y]+DG[a,y]b;
DG[Power[a_,n_],y_]:=n Power[a,n-1] DG[a,y];
DG[a_,y_]:=D[a,y]/; (And @@ (FreeQ[a,#]& /@ PLT$DGFunctions));

DG[g_Li,y_]:=DG[g,y]=DG[LiToG[g],y];
DG[g_H,y_]:=DG[g,y]=GToH[DG[HToG[g],y]];
DG[ctt_CiTi,y_]:=Block[{temp=ctt,Temp$CiTi,der},
   temp=temp//.CiTi->Temp$CiTi;
   der=Factor[D[Log[temp[[-1]]],y],Extension->$QExtension];
   temp=Most[temp];
   Return[temp der];
];
DG[CT[as__,b_],y_]:=CT[as,DG[b,y]]


DG[g_G,y_]:=DG[g,y]=Block[{dn1,weight=Length[g]-1},

   If[weight==1,
      Return[Factor[D[g/.G->GLog,y]]]
     ];

   dn1=Which[weight==2,Delta11[g],
             weight==3,Delta21[g],
             weight==4,Delta31[g],
             weight==5,Delta41[g],
             weight==6,Delta51[g],
             weight==7,Delta61[g],
             weight==8,Delta71[g],
             True,Message[DerG::Weight];Return[$DG[g,y]]
            ];

   dn1=dn1//.CT[a_,b_]:>a Factor[D[b//.G->GLog,y],Extension->$QExtension];
   Return[dn1];
];


(* ::Section:: *)
(*Series expansion*)


ZSumEval[{m_Integer},{x_},n_Integer] := ZSumEval[{m},{x},n] = Sum[x^kk/kk^m,{kk,n}]

ZSumEval[{m_Integer, ms__}, {x_, xs___}, n_Integer] := ZSumEval[{m, ms}, {x, xs}, n] = Sum[x^kk/kk^m ZSumEval[{ms},{xs},kk-1], {kk, n}]


GSeries[ws__, x_, n_Integer] := GSeries[ws, x, n] = Block[{
      work = G[ws,x]
      },

      work = Expand[ExtractZeroes[work]];
      work = work /. G[w___, Except[0,w1_], x] :> GLi[w,w1,x];
      work = work /. Li[m_List, xs_List] :> ZSumEval[Reverse[m],Reverse[xs],n] + x^(n+1)$helpGSeries[ws];
      work = Collect[work, x, Factor];
      Return[work];
];
             


ExpPol::Point = "Only expansions around 0 are currently suppported.";
ExpPol::Arg = "Only polylogarithms where the indices do not depend on the expansion parameter can currently be expanded.";


Options[ExpandPolyLogs] := Options[Series];


ExpandPolyLogs[expr_, {x_, nmin_Integer, nmax_Integer}, OptionsPattern[]] := Block[{
     work = Collect[HToG[HPLToH[expr]], {G[__,x]}, Expand], 
     order = nmax+1, $Finished=False,temp,$LOG
     },

     If[nmin =!= 0,
        Message[ExpPol::Point];
        Return[expr]
        ];


     If[Not[FreeQ[Simplify[GetGIndices[expr]], x]],
        Message[ExpPol::Arg];
        Return[expr]
        ];

     While[Not[$Finished],
           temp = work /. G[ws__, x] :> GSeries[ws, x, order];
           temp = temp //. G[ws__, x] :> $LOG^(Length[{ws}])/(Length[{ws}]!) /; Union[{ws}] === {0};
           temp = Normal[Series[temp, {x, 0, nmax}, Analytic -> OptionValue[Analytic], Assumptions -> OptionValue[Assumptions]]];
           temp = temp //. $LOG -> G[0,x];
           $Finished = FreeQ[temp, $helpGSeries];
           order = order+1
          ];
     work=temp;

     Return[work];
];
    


(* ::Section:: *)
(*Tools for HPLs*)


HPLMin[expr_] := Expand[HPLToH[expr //. {hpl_H :> HPLReduceToMinimalSet[HToHPL[hpl]], hpl_HPL :> HPLReduceToMinimalSet[hpl]}]];


HPLBasis1 = {HPL[{0}, x_] :> Log[x],
             HPL[{1}, x_] :> -Log[1-x],
             HPL[{-1},x_]  :> Log[1+x]};


ToHPLBasis[expr_] := Block[{temp = Expand[expr]},
    
     temp = GToH[temp];
     temp = HToHPL[HPLMin[expr]];
     temp = temp //. HPLBasis1 //. HPLBasis2 //. HPLBasis3 //. HPLBasis4 //. HPLBasis5;
     temp = Expand[temp];

     Return[temp];

];


SVHPL[is__, Except[_List, x_]] := SVHPL[is, {x, Conjugate[x]}];


SVHToH[expr_] := expr  //. {SVH -> SVHPL};
