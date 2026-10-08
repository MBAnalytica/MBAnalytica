(* ::Package:: *)

(* ::Title:: *)
(*Polygon Algebra*)


$NC=400;


(* ::Section:: *)
(*Basic definitions for polygons*)


PG=PolyGon
Sh=Shuffle


Gon2[a_,b_] := CiTi[1-b/a] /; a=!=b && a=!=0 && b=!=0;
Gon2[0,a_]  := CiTi[a];
Gon2[_,0]   := 0;
Gon2[a_,a_] := CiTi[1/a] /; a=!=0;

Gon22[a_,a_] := 0;
Gon22[_,0] := 0;
Gon22[a_,b_] := Gon2[a,b]/;a=!=b;


ToPolyGon[expr_] := expr /. {G[as__,$z_]:>PolyGon[Sequence@@Reverse[{as}],$z]};


PolyGon[_,0] := 0;


(* ::Section:: *)
(*Dissection*)


(* ::Subsection:: *)
(*Dissection function*)


Dissect[prod_Times]       := Dissect /@ prod;
Dissect[sum_Plus]         := Dissect /@ sum;
Dissect[a_?(NumberQ)*pg_] := a Dissect[pg];

Dissect[PolyGon[a1_,a2_]] := PolyGon[a1,a2];

Dissect[sum_Plus]         := Dissect /@ sum;
Dissect[a_?NumberQ*p_]    := a Dissect[p]


(* ::Subsection:: *)
(*Trigon dissection*)


Dissect[PolyGon[a1_,a2_,a3_]] := (PolyGon[a1,a3]|PolyGon[a2,a3])+
                                 (PolyGon[a2,a3]|PolyGon[a1,a2])-
                                 (PolyGon[a1,a3]|PolyGon[a2,a1])/.Alternatives->Alt/.Alt->Alternatives;


(* ::Subsection::Closed:: *)
(*Fourgon dissection*)


Dissect[PolyGon[a1_,a2_,a3_,a4_]] := (PolyGon[a1,a4]|PolyGon[a2,a4]|PolyGon[a3,a4])+
     (PolyGon[a3,a4]|PolyGon[a1,a3]|PolyGon[a2,a3])-
     (PolyGon[a2,a4]|PolyGon[a1,a2]|PolyGon[a3,a2])-
     (PolyGon[a2,a4]|PolyGon[a3,a2]|PolyGon[a1,a2])+
     (PolyGon[a1,a4]|PolyGon[a3,a1]|PolyGon[a2,a1])+
     (PolyGon[a3,a4]|PolyGon[a2,a3]|PolyGon[a1,a2])+
     (PolyGon[a1,a4]|PolyGon[a2,a1]|PolyGon[a3,a2])-
     (PolyGon[a1,a4]|PolyGon[a2,a1]|PolyGon[a3,a4])-
     (PolyGon[a1,a4]|PolyGon[a3,a4]|PolyGon[a2,a1])-
     (PolyGon[a1,a4]|PolyGon[a2,a4]|PolyGon[a3,a2])-
     (PolyGon[a3,a4]|PolyGon[a1,a3]|PolyGon[a2,a1])+
     (PolyGon[a2,a4]|PolyGon[a1,a2]|PolyGon[a3,a4])+
     (PolyGon[a2,a4]|PolyGon[a3,a4]|PolyGon[a1,a2])-
     (PolyGon[a1,a4]|PolyGon[a3,a1]|PolyGon[a2,a3])+
     (PolyGon[a1,a4]|PolyGon[a3,a4]|PolyGon[a2,a3])/.Alternatives->Alt/.Alt->Alternatives;


(* ::Subsection:: *)
(*Pentagon dissection*)


Dissect[PolyGon[d_,c_,b_,a_,$z_]]:=
(*Topology 1*)
    Alt[PG[a,$z],PG[b,a],PG[c,b],PG[d,c]]-
    Alt[PG[d,$z],PG[c,d],PG[b,c],PG[a,b]]+
    Alt[PG[d,$z],Sh[PG[a,$z],{PG[c,d],PG[b,c]}]]-
    Alt[PG[d,$z],Sh[PG[c,d],{PG[a,$z],PG[b,a]}]]+
    Alt[PG[d,$z],PG[a,$z],PG[b,a],PG[c,b]]-
(*T21*)
    Alt[PG[b,$z],Sh[PG[a,b],{PG[c,b],PG[d,c]}]]+
    Alt[PG[b,$z],Sh[PG[a,$z],{PG[c,b],PG[d,c]}]]+
    Alt[PG[a,$z],PG[b,a],PG[d,b],PG[c,b]]-
    Alt[PG[a,$z],PG[b,a],PG[d,b],PG[c,d]]-
    Alt[PG[a,$z],PG[c,a],Sh[PG[d,c],PG[b,c]]]+
    Alt[PG[a,$z],PG[c,a],Sh[PG[d,c],PG[b,a]]]-
(*T22*)
    Alt[PG[d,$z],PG[c,d],PG[a,c],PG[b,c]]+
    Alt[PG[d,$z],PG[c,d],PG[a,c],PG[b,a]]+
    Alt[PG[d,$z],PG[b,d],Sh[PG[a,b],PG[c,b]]]-
    Alt[PG[d,$z],PG[b,d],Sh[PG[c,d],PG[a,b]]]+
    Alt[PG[d,$z],PG[c,$z],PG[b,c],PG[a,b]]+
    Alt[PG[c,$z],Sh[PG[d,c],{PG[b,c],PG[a,b]}]]+
(*T23*)
    Alt[PG[d,$z],Sh[PG[a,$z],{PG[b,d],PG[c,d]}]]-
    Alt[PG[d,$z],Sh[PG[a,$z],{PG[b,d],PG[c,b]}]]+
    Alt[PG[a,$z],PG[d,a],PG[c,d],PG[b,c]]-
    Alt[PG[d,$z],PG[a,d],PG[c,d],PG[b,c]]-
    Alt[PG[d,$z],PG[c,$z],Sh[PG[a,$z],PG[b,c]]]-
    Alt[PG[c,$z],Sh[PG[a,$z],PG[b,c],PG[d,c]]]+
(*T24*)
    Alt[PG[d,$z],PG[c,$z],PG[a,$z],PG[b,a]]+
    Alt[PG[c,$z],Sh[PG[d,c],{PG[a,$z],PG[b,a]}]]+
    Alt[PG[d,$z],Sh[PG[c,d],{PG[b,$z],PG[a,b]}]]-
    Alt[PG[d,$z],Sh[PG[c,d],{PG[b,$z],PG[a,$z]}]]-
    Alt[PG[a,$z],PG[d,a],Sh[PG[c,d],PG[b,a]]]+
    Alt[PG[d,$z],PG[a,d],Sh[PG[c,d],PG[b,a]]]+
(*T25*)
    Alt[PG[d,$z],PG[a,$z],PG[c,a],PG[b,a]]-
    Alt[PG[d,$z],PG[a,$z],PG[c,a],PG[b,c]]+
    Alt[PG[a,$z],PG[d,a],PG[b,a],PG[c,b]]-
    Alt[PG[d,$z],PG[a,d],PG[b,a],PG[c,b]]-
    Alt[PG[d,$z],PG[b,$z],Sh[PG[c,b],PG[a,b]]]+
    Alt[PG[d,$z],PG[b,$z],Sh[PG[a,$z],PG[c,b]]]-
(*T31*)
    Alt[PG[b,$z],Sh[PG[a,b],{PG[d,b],PG[c,b]}]]+
    Alt[PG[b,$z],Sh[PG[a,b],{PG[d,b],PG[c,d]}]]+
    Alt[PG[b,$z],Sh[PG[a,$z],{PG[d,b],PG[c,b]}]]-
    Alt[PG[b,$z],Sh[PG[a,$z],{PG[d,b],PG[c,d]}]]+
(*T32*)
    Alt[PG[c,$z],Sh[PG[d,c],{PG[a,c],PG[b,c]}]]+
    Alt[PG[d,$z],PG[c,$z],PG[a,c],PG[b,c]]-
    Alt[PG[c,$z],Sh[PG[d,c],{PG[a,c],PG[b,a]}]]-
    Alt[PG[d,$z],PG[c,$z],PG[a,c],PG[b,a]]+
(*T33*)
    Alt[PG[d,$z],PG[c,$z],PG[b,$z],PG[a,$z]]+
    Alt[PG[c,$z],Sh[PG[d,c],{PG[b,$z],PG[a,$z]}]]-
    Alt[PG[d,$z],PG[c,$z],PG[b,$z],PG[a,b]]-
    Alt[PG[c,$z],Sh[PG[d,c],{PG[b,$z],PG[a,b]}]]-
(*T34*)
    Alt[PG[d,$z],PG[a,d],PG[b,d],PG[c,d]]+
    Alt[PG[a,$z],PG[d,a],PG[b,d],PG[c,d]]-
    Alt[PG[a,$z],PG[d,a],PG[b,d],PG[c,b]]+
    Alt[PG[d,$z],PG[a,d],PG[b,d],PG[c,b]]+
(*T35*)
    Alt[PG[a,$z],PG[d,a],PG[c,a],PG[b,a]]-
    Alt[PG[a,$z],PG[d,a],PG[c,a],PG[b,c]]- 
    Alt[PG[d,$z],PG[a,d],PG[c,a],PG[b,a]]+
    Alt[PG[d,$z],PG[a,d],PG[c,a],PG[b,c]]/.Alt->Alternatives;


(* ::Section:: *)
(*Tensor algebra*)


Options[ToTensorProduct]={Variant->1};

SetAttributes[CiTi,Flat];
SetAttributes[CircleDot,Orderless];

SetAttributes[Diff,Orderless];

Alt[___,0,___]:=0;


Expander[sum_Plus]       := Expander/@sum;
Expander[c_NumberQ term_]:= c Expander[term];


ToTensorProduct[expr_,OptionsPattern[]]:=Block[{

    gon=If[OptionValue[Variant]===1,Gon2,Gon22],
    temp = expr
     },

    If[OptionValue[Variant] == 2,
       temp = temp/.PolyGon[a,a]:>0/.Alternatives->Alt/.Alt->Alternatives
      ];


    temp = temp//.Alternatives->CiTi;

    temp = temp//.PolyGon[a_,b_]:>gon[a,b];

    Return[temp];

    ];


CiTiExpand[terms1___,a_Times, terms2___]:=Plus@@(CiTiExpand[terms1,#,terms2]&/@(List@@a));
CiTiExpand[terms1___,Power[a_,n_] , terms2___]:=n CiTiExpand[terms1,a,terms2];
CiTiExpand[terms1___,x_-1,terms2___]:=CiTiExpand[terms1,1-x,terms2];
CiTiExpand[terms1___,Rational[a_,b_],terms2___]:=CiTiExpand[terms1,a,terms2]-CiTiExpand[terms1,b,terms2];


CiTiExpand[terms1___,4|-4,terms2___]:=2CiTiExpand[terms1,2,terms2];
CiTiExpand[terms1___,8|-8,terms2___]:=3CiTiExpand[terms1,2,terms2];
CiTiExpand[terms1___,16|-16,terms2___]:=4CiTiExpand[terms1,2,terms2];
CiTiExpand[terms1___,9,terms2___]:=2CiTiExpand[terms1,3,terms2];

CiTiExpand[terms1___,-x_,terms2___]:=CiTiExpand[terms1,x,terms2];
CiTiExpand[terms1___,-2,terms2___]:=CiTiExpand[terms1,2,terms2];
CiTiExpand[terms1___,-3,terms2___]:=CiTiExpand[terms1,3,terms2];


CiTi[a___,1|(-1)|I|-I,b___]:=0/;Length[{a,b}]=!=0;
CiTi[terms1___,-a_,terms2___]:=CiTi[terms1,a,terms2];
CiTi[1]=0;
CiTi[___,0,___]=0;


Clear[SetQExtension];

SetQExtension[extension_List]:= Block[{},
	$QExtension = extension;
	Clear[MyLogFactor];
	Clear[CiTiFrozen];
	SetOptions[MyLogFactor,QExtension->extension];


	MyLogFactor[x_,OptionsPattern[]] := MyLogFactor[x] = Block[{log = Factor[{x},Extension->OptionValue[QExtension]]},
    log = If[log ===0,
       Return[0],
       PowerExpand[Log @@ log] /. Pi ->0 /. Log->MyLogflat
      ];

Return[log]
   
];

CiTiFrozen[as__] := CiTiFrozen[as] = CiTiFrozen2 @@(MyLogFactor /@ List[as]);
CiTiFrozen2[as___, sum_Plus, bs___] := CiTiFrozen2[as,#,bs]& /@ sum;
CiTiFrozen2[as___, Except[_MyLog, c_] b_, bs___] := c CiTiFrozen2[as,b,bs];

];


Clear[MyLogFactor];
Options[MyLogFactor] = { QExtension -> {} };
MyLogFactor[x_,OptionsPattern[]] := MyLogFactor[x] = Block[{log = Factor[{x},Extension->OptionValue[QExtension]]},
    log = If[log ===0,
       Return[0],
       PowerExpand[Log @@ log] /. Pi ->0 /. Log->MyLogflat
      ];

Return[log]
   
];
  


MyLogflat[x_] := MyLogflat[x] = MyLog[flat[x]];


Clear[CiTiFrozen];
CiTiFrozen[as__] := CiTiFrozen[as] = CiTiFrozen2 @@(MyLogFactor /@ List[as]);
CiTiFrozen2[as___, sum_Plus, bs___] := CiTiFrozen2[as,#,bs]& /@ sum;
CiTiFrozen2[as___, Except[_MyLog, c_] b_, bs___] := c CiTiFrozen2[as,b,bs];


CiTiFrozen3[as__] := CiTi @@ ({as} /. MyLog -> Identity);


ReduceTensorProduct2[expr_]:=Block[{exp=expr},
     exp=exp/.CiTi:>CiTiFrozen ;
     exp = exp/. CiTiFrozen2 -> CiTiFrozen3;


    (* exp=exp/.CiTi->CiTiExpand/.CiTiExpand->CiTi;*)


  (*   exp=exp//.CiTi[terms1___,a_-b_,terms2___]:>CiTi[terms1,Diff[a,b],terms2]//.Diff[a_,b_]:>a-b;*)
 
     exp = Expand[exp];

     Return[exp];

];


ReduceTensorProduct[expr_]:=Block[{exp=expr},

     exp=exp/.CiTi[inds___]:>CiTi@@Factor[{inds}];


     exp=exp/.CiTi->CiTiExpand//.Dispatch[Table[CiTiExpand[a___,2^n|(-2^n),b___]->n*CiTiExpand[a,2,b],{n,2,10}]]//.Dispatch[Table[CiTiExpand[a___,3^n|(-3^n),b___]->n*CiTiExpand[a,3,b],{n,2,10}]]/.CiTiExpand->CiTi;


  (*   exp=exp//.CiTi[terms1___,a_-b_,terms2___]:>CiTi[terms1,Diff[a,b],terms2]//.Diff[a_,b_]:>a-b;*)
 
     exp = Expand[exp];

     Return[flatTensor[exp]];

];


NoTensorQ=Head[#]=!=CiTi&;


Clear[Shuffle];


(*Shuffle[CCTT[a_],CCTT[b_]]:=CCTT[a,b]+CCTT[b,a];

Shuffle[CCTT[a_],CCTT[b_,c_]]:=CCTT[a,b,c]+CCTT[b,a,c]+CCTT[b,c,a];
Shuffle[CCTT[b_,c_],CCTT[a_]]:=CCTT[a,b,c]+CCTT[b,a,c]+CCTT[b,c,a];

Shuffle[CCTT[a_],CCTT[b_,c_,d_]]:=CCTT[a,b,c,d]+CCTT[b,a,c,d]+CCTT[b,c,a,d]+CCTT[b,c,d,a];
Shuffle[CCTT[b_,c_,d_],CCTT[a_]]:=CCTT[a,b,c,d]+CCTT[b,a,c,d]+CCTT[b,c,a,d]+CCTT[b,c,d,a];
Shuffle[CCTT[a_,b_],CCTT[c_,d_]]:=CCTT[a,b,c,d]+CCTT[a,c,b,d]+CCTT[a,c,d,b]+CCTT[c,a,b,d]+CCTT[c,a,d,b]+CCTT[c,d,a,b];

Shuffle[CCTT[a_,b_,c_,d_],CCTT[e_]]:=CCTT[a,b,c,d,e]+CCTT[a,b,c,e,d]+CCTT[a,b,e,c,d]+CCTT[a,e,b,c,d]+CCTT[e,a,b,c,d];
Shuffle[CCTT[e_],CCTT[a_,b_,c_,d_]] := Shuffle[CCTT[a,b,c,d],CCTT[e]];
Shuffle[CCTT[a_,b_,c_],CCTT[d_,e_]]:= CCTT[a,b,c,d,e]+CCTT[a,b,d,c,e]+CCTT[a,d,b,c,e]+CCTT[d,a,b,c,e]+CCTT[a,b,d,e,c]+CCTT[a,d,b,e,c]+CCTT[d,a,b,e,c]+CCTT[a,d,e,b,c]+CCTT[d,a,e,b,c]+CCTT[d,e,a,b,c];
Shuffle[CCTT[d_,e_],CCTT[a_,b_,c_]] := Shuffle[CCTT[a,b,c],CCTT[d,e]];

Shuffle[CCTT[b_,c_,d_,e_,f_],CCTT[a_]]:=CCTT[a,b,c,d,e,f] + CCTT[b,a,c,d,e,f] + CCTT[b,c,a,d,e,f] + CCTT[b,c,d,a,e,f] + CCTT[b,c,d,e,a,f] + CCTT[b,c,d,e,f,a];

Shuffle[CCTT[a_],CCTT[b_,c_,d_,e_,f_]] := Shuffle[CCTT[b,c,d,e,f],CCTT[a]];*)


(*Shuffle[CCTT[c_,d_,e_,f_],CCTT[a_,b_]]:=CCTT[a,b,c,d,e,f] + CCTT[a,c,b,d,e,f] + CCTT[a,c,d,b,e,f] + CCTT[a,c,d,e,b,f] + CCTT[a,c,d,e,f,b] + 
          CCTT[c,a,b,d,e,f] + CCTT[c,a,d,b,e,f] + CCTT[c,a,d,e,b,f] + CCTT[c,a,d,e,f,b] +
          CCTT[c,d,a,b,e,f] + CCTT[c,d,a,e,b,f] + CCTT[c,d,a,e,f,b] +
          CCTT[c,d,e,a,b,f] + CCTT[c,d,e,a,f,b] + 
          CCTT[c,d,e,f,a,b];

Shuffle[CCTT[a_,b_],CCTT[c_,d_,e_,f_]] := Shuffle[CCTT[c,d,e,f],CCTT[a,b]];
*)


Shuffle[Tens[a_,bs___],Tens[c_,ds___]]:=Expand[Tens[a,Shuffle[Tens[bs],Tens[c,ds]]]+Tens[c,Shuffle[Tens[a,bs],Tens[ds]]]]
Shuffle[Tens[],t_Tens]:=t;
Shuffle[t_Tens,Tens[]]:=t;


Shuffle[a_CCTT,b_CCTT,c__]:=Shuffle[Shuffle[a,b],c];


Shuffle[sum_Plus,a_]:=Shuffle[#,a]&/@sum;
Shuffle[a_,sum_Plus]:=Shuffle[a,#]&/@sum;


Shuffle[d___,a_?NumberQ b_,c___]:=a Shuffle[d,b,c];
Shuffle[c___,a_?NumberQ b_,d___]:=a Shuffle[c,b,d];


Shuffle/:Alt[pg1___,Shuffle[PolyGon[a1_,a2_],PolyGon[b1_,b2_],PolyGon[c1_,c2_]],pg2___]:=Alt[pg1,PolyGon[a1,a2],PolyGon[b1,b2],PolyGon[c1,c2],pg2]+Alt[pg1,PolyGon[a1,a2],PolyGon[c1,c2],PolyGon[b1,b2],pg2]+Alt[pg1,PolyGon[b1,b2],PolyGon[a1,a2],PolyGon[c1,c2],pg2]+Alt[pg1,PolyGon[b1,b2],PolyGon[c1,c2],PolyGon[a1,a2],pg2]+Alt[pg1,PolyGon[c1,c2],PolyGon[a1,a2],PolyGon[b1,b2],pg2]+Alt[pg1,PolyGon[c1,c2],PolyGon[b1,b2],PolyGon[a1,a2],pg2];


Shuffle/:Alt[pg1___,Shuffle[PolyGon[a1_,a2_],{PolyGon[b1_,b2_],PolyGon[c1_,c2_]}],pg2___]:=Alt[pg1,PolyGon[a1,a2],PolyGon[b1,b2],PolyGon[c1,c2],pg2]+Alt[pg1,PolyGon[b1,b2],PolyGon[a1,a2],PolyGon[c1,c2],pg2]+Alt[pg1,PolyGon[b1,b2],PolyGon[c1,c2],PolyGon[a1,a2],pg2];


Shuffle/:Alt[pg1___,Shuffle[PolyGon[a1_,a2_],PolyGon[b1_,b2_]],pg2___]:=Alt[pg1,PolyGon[a1,a2],PolyGon[b1,b2],pg2]+Alt[pg1,PolyGon[b1,b2],PolyGon[a1,a2],pg2];


Shuffle/:Alt[___,Shuffle[___,0,___],___]:=0;
Shuffle/:Alt[___,Shuffle[___,{___,0,___},___],___]:=0;


ShuffleTensor[expr_]:=Expand[expr//.{CiTi|Tens->ShuffleCiTi}]/.{ShuffleCiTi|Tens->CiTi, ElTens -> Identity};


Clear[ShuffleCiTi]


ShuffleCiTi/:ShuffleCiTi[a__]ShuffleCiTi[b__]:=Shuffle[Tens@@(ElTens /@ {a}),Tens@@(ElTens /@ {b})];
ShuffleCiTi/:Power[ShuffleCiTi[a__],n_?(#>2&)]:=Shuffle[Tens@@(ElTens /@ {a}), Tens@@(ElTens /@ {a})]Power[ShuffleCiTi[a],n-2];
ShuffleCiTi/:Power[ShuffleCiTi[a__],2]:=Shuffle[Tens@@(ElTens /@ {a}), Tens@@(ElTens /@ {a})];


(* ::Section:: *)
(*CreateTensor*)


Get["Weight5`"];
Get["Weight6`"];


TensTab[x_,n_]:=Tens@@Table[ElTens[x],{n}];


TensIpq[{r1_,r2_},{x1_,x2_}]:=Sum[(-1)^(t1+r2-1)Tens[ElTens[1-1/x2],Shuffle[TensTab[x2,r2-1],Tens[ElTens[1-x2/x1],Shuffle[TensTab[x1,t1],TensTab[x2,r1-1-t1]]]]],{t1,0,r1-1}]+Sum[(-1)^(r1-1-t2+r2)Binomial[t2+t4,t2]Tens[ElTens[1-1/x1],TensTab[x1,r2-1-t4],Tens[ElTens[1-x1/x2]],Shuffle[TensTab[x2,t2+t4],TensTab[x1,r1-1-t2]]],{t2,0,r1-1},{t4,0,r2-1}]+Sum[(-1)^(r1-1-t2+r2-1)Binomial[t2+r2-1,t2]Tens[ElTens[1-1/x1],Shuffle[TensTab[x1,r1-1-t2],Tens[ElTens[1-1/x2],TensTab[x2,r2-1+t2]]]],{t2,0,r1-1}]/.Tens[a___,Tens[],b___]:>Tens[a,b];


HTens[{p_,q_},x_]:=TensIpq[{Abs[q],Abs[p]},{Sign[q]1/x,Sign[p]1/x}]/.Tens[w__]:>Identity@@@CiTi[w]//ReduceTensorProduct;


CreateHTensor[ws__,x_]:=Block[{wlist=Reverse[{ws}]},
   Return[(-1)^Length[DeleteCases[wlist,0]] (CiTi@@(wlist-x))]
];


ToCyclTensor[G[ws__,x_]] := Block[{
    indices = {ws}, test
    },

    (* Make HPLs to cyclotomic *)
    indices = indices //. {{as___,1,bs___} :> {as, Cycl[1],bs}, {as___,-1,bs___} :> {as, Cycl[2],bs}};
 
    (* Check if arguments are indeed cyclotomic *)
    test = DeleteCases[indices, _Cycl|0];
    If[test =!= {},
       Message[Cyclotmic::Tensor]
       ];

    
    indices = Reverse[indices];
    indices = indices //. {{as___,0,bs___} :> {as,x,bs}, {as___,Cycl[n_], bs___} :> {as, Cyclotomic[n,x],bs}};
    indices = CiTi @@ indices;
    Return[flatTensor[indices]];
];


CreateTensor[expr_] := Block[{temp=HPLToH[expr]},

PLT$AutoConvertToKnownConstants = False;
    temp = HToG[temp /. {PolyLog[n_, x_] :> H[Sequence@@Table[0,{n-1}],1,x], 
                        PolyLog[n_, m_, x_] :> H[Sequence@@Table[0,{n}],Sequence@@Table[1,{m}],x]} /. {HPL[w_,x_]:>H[Sequence@@HPLMtoA[w],x]} /. H[ws__,x_]:>CreateHTensor[ws,x] /; DeleteCases[{ws},0|1]==={}];
    temp = temp //. G[ws__,x_] :> ToCyclTensor[G[ws,x]] /; Not[FreeQ[{ws}, Cycl]];

    temp = temp /. {G[a1_,a2_,a3_,a4_,a5_,x_]:>Weight5Tensor[a5,a4,a3,a2,a1,x],
                    G[a1_,a2_,a3_,a4_,a5_,a6_,x_]:>Weight6Tensor[a6,a5,a4,a3,a2,a1,x]};
PLT$AutoConvertToKnownConstants = True;

    temp = temp//.{Pi->0,Zeta[_]:>0,_Cl|_GR|_GI:>0, _MZV :>0, HPLs6 -> 0}//.{Log[x_]:>G[0,x],PolyLog[n_,x_]:>-G[Sequence@@Table[0,{n-1}],1,x],Li->LiG};
    temp = temp//.{G[ws__,x_]:>ToPolyGon[G[ws,x]], PolyLog[n_,x_]:> -PolyGon[1,Sequence @@ Table[0,{n-1}],x], 
                  PolyLog[n_,m_,x_]:> (-1)^m PolyGon[Sequence @@ Table[1,{m}],Sequence @@ Table[0,{n}],x]}/.PolyGon[ws__]:>Dissect[PolyGon[ws]];
    temp = ToTensorProduct[temp];
     temp = temp//ShuffleTensor//Expand;

    temp = ReduceTensorProduct2[temp]//Expand//ShuffleTensor;
 
    Return[flatTensor[temp//.$CanonicalPrimeElementOrder]];
];


CreateTensorOld[expr_] := Block[{temp=expr},

    temp = HToG[temp /. {PolyLog[n_, x_] :> H[Sequence@@Table[0,{n-1}],1,x], 
                        PolyLog[n_, m_, x_] :> H[Sequence@@Table[0,{n}],Sequence@@Table[1,{m}],x]} /. {HPL[w_,x_]:>H[Sequence@@HPLMtoA[w],x]} /. H[ws__,x_]:>CreateHTensor[ws,x] /; DeleteCases[{ws},0|1]==={}];
    temp = temp /. {G[a1_,a2_,a3_,a4_,a5_,x_]:>Weight5Tensor[a5,a4,a3,a2,a1,x],
                    G[a1_,a2_,a3_,a4_,a5_,a6_,x_]:>Weight6Tensor[a6,a5,a4,a3,a2,a1,x]};
    temp = temp/.{Pi->0,Zeta[_]:>0,_Cl|_GR|_GI:>0}//.{Log[x_]:>G[0,x],PolyLog[n_,x_]:>-G[Sequence@@Table[0,{n-1}],1,x],Li->LiG};
    temp = temp/.{G[ws__,x_]:>ToPolyGon[G[ws,x]], PolyLog[n_,x_]:> -PolyGon[1,Sequence @@ Table[0,{n-1}],x], 
                  PolyLog[n_,m_,x_]:> (-1)^m PolyGon[Sequence @@ Table[1,{m}],Sequence @@ Table[0,{n}],x]}/.PolyGon[ws__]:>Dissect[PolyGon[ws]];
    temp = ToTensorProduct[temp];
     temp = temp//ShuffleTensor//Expand;

    temp = ReduceTensorProduct[temp]//Expand//ShuffleTensor;
 
    Return[temp];
];


RemoveConstantEntries[expr_]:=Block[{CCTT},expr//.CiTi->CCTT//.CCTT[___,_?NumericQ,___]:>0//.CCTT->CiTi];


Options[ComputeSymbol] = {ConstantEntries -> True};

ComputeSymbol[expr_, OptionsPattern[]] := Block[{temp = cGToG[HPLToH[expr]]},
   temp = CreateTensor[temp];
   If[OptionValue[ConstantEntries] === False,
      temp = RemoveConstantEntries[temp]
     ];
   Return[temp];
];


(* ::Section:: *)
(*Tensor Algebra*)


Tens[a___,Tens[b__],c___]:=Tens[a,b,c]
Tens[a___,sum_Plus,b___]:=Tens[a,#,b]&/@sum
Tens[a___,Except[_Tens|ElTens,c_]d_,b___]:=c Tens[a,d,b]
Tens[___,0,___]:=0

TensWedge[a___,sum_Plus,b___]:=TensWedge[a,#,b]&/@sum
TensWedge[a___,Except[_Tens|ElTens|TensWedge,c_]d_,b___]:=c TensWedge[a,d,b]
TensWedge[___,0,___]:=0
TensWedge[a__]:=Signature[{a}] TensWedge@@Sort[{a}] /; Not[OrderedQ[{a}]];
TensWedge[___,a_,___,a_,___]:=0;




(* ::Subsection:: *)
(*s projector*)


(* ::Text:: *)
(*Note that we omit the normalization factor (n-1)/n*)


proj[expr_]:=sh[expr];

proj[expr_, 2, 1] := expr /. CiTi[w__]:>Tens@@(ElTens/@{w}) /. Tens[a_,b_,c_]:> Tens[sh[Tens[a,b]], c];

proj[expr_, 3, 1] := expr /. CiTi[w__]:>Tens@@(ElTens/@{w}) /. Tens[a_,b_,c_,d_]:> Tens[sh[Tens[a,b,c]], d];
proj[expr_, 2, 2] := expr /. CiTi[w__]:>Tens@@(ElTens/@{w}) /. Tens[a_,b_,c_,d_]:> Tens[sh[Tens[a,b]], sh[Tens[c,d]]];
proj[expr_, 2, 1, 1] := expr /. CiTi[w__]:>Tens@@(ElTens/@{w}) /. Tens[a_,b_,c_,d_]:> Tens[sh[Tens[a,b]],c,d];


sh[CiTi[ws___]] := sh[CiTi[ws] /.CiTi[w__]:>Tens@@(ElTens/@{w})] /. Tens[www__]:>(Identity @@@ CiTi[www]);

sh[Tens[a_,b_]]:=Tens[a,b]/2-Tens[b,a]/2;

sh[a_,b__] := sh[Tens[a,b]];

sh[Tens[a_,b__,c_]]:=Expand[(Length[{a,b,c}]-1)/Length[{a,b,c}](Tens[sh[a,b],c]-Tens[sh[b,c],a])];

sh[a___,sum_Plus,b___]:=sh[a,#,b]&/@sum;
sh[a___,Except[_Tens|TensWedge,c_]d_,b___]:=c sh[a,d,b];


(* ::Subsection:: *)
(*\[Delta] operator*)


(*NoWedge[expr_]:=expr/.TensWedge[a_,b_]:>Tens[a,b]-Tens[b,a]/. Tens[www__]:>(Identity @@@ CiTi[www]);*)


(*\[Delta][t_CiTi] := \[Delta][t /.CiTi[w__]:>Tens@@(ElTens/@{w})];*)


(*\[Delta][t_Tens]:=Block[{

   split=Table[{Take[t,k],Drop[t,k]},{k,2,Length[t]-2}]

   },

   split=Map[sh,split,{2}];

   split=Plus@@(TensWedge@@@split);

   Return[split];

];*)


(*del = \[Delta];
\[Delta][sum_Plus] := \[Delta]/@sum;
\[Delta][Except[_Tens|TensWedge,a_]b_] := a \[Delta][b];
\[Delta][a_,bs__] := \[Delta][Tens[a,bs]];*)


(* ::Section:: *)
(*Symmetry projection*)


(* ::Subsection:: *)
(*Weight2*)


ComponentLi2[expr_]:=Block[{$CCTT,temp},

    temp=expr/.CiTi -> $CCTT;
    temp=temp/.$CCTT[a_,b_] :> Wedge[a,b];
    temp=temp//.{Wedge[a_,b_]:>-Wedge[b,a]/;Not[OrderedQ[{a,b}]],Wedge[a_,a_]:>0};

    Return[temp/.$CCTT->CiTi];
];


(* ::Subsection:: *)
(*Weight 3*)


(* ::Subsubsection:: *)
(*Antisymmetric 1*)


ComponentLi2Log[expr_] := Block[{$CCTT,temp},

   temp=expr/.CiTi->$CCTT;
   temp=temp/.$CCTT[a_,b_,c_]:>$CCTT[a,Wedge[b,c]];
   temp=temp//.{$CCTT[as1___,Wedge[a_,b_],as2___]:>-$CCTT[as1,Wedge[b,a],as2]/;Not[OrderedQ[{a,b}]],$CCTT[___,Wedge[a_,a_],___]:>0};

   Return[temp/.$CCTT->CiTi];
];


(* ::Subsubsection:: *)
(*Antisymmetric 2*)


ComponentLi3[expr_] := Block[{$CCTT,temp},

   temp=expr/.CiTi->$CCTT;
   temp=temp/.$CCTT[a_,b_,c_]:>$CCTT[Wedge[a,b],c];
   temp=temp//.{$CCTT[as1___,Wedge[a_,b_],as2___]:>-$CCTT[as1,Wedge[b,a],as2]/;Not[OrderedQ[{a,b}]],$CCTT[___,Wedge[a_,a_],___]:>0};

   Return[temp/.$CCTT->CiTi];
];


(* ::Subsection:: *)
(*Weight 4*)


(* ::Subsubsection:: *)
(*Component4A22*)


ComponentLi22[expr_] := Block[{temp},

   temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
   temp=del[temp];

   temp=Expand[temp];

   Return[temp];

];


(* ::Subsubsection:: *)
(*ComponentLi2Li2*)


ComponentLi2Li2[expr_] := Block[{$CCTT,temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=temp/.Tens[a_,b_,c_,d_] :> Tens[s[a,b],s[c,d]];
    temp=Expand[temp];

    Return[temp];
];


(* ::Subsubsection:: *)
(*ComponentLi2LogLog*)


ComponentLi2LogLog[expr_]:=Block[{$CCTT,temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=temp/.Tens[a_,b_,c_,d_] :> Tens[a,b,s[c,d]];
    temp=Expand[temp];

    Return[temp];
];


(* ::Subsubsection:: *)
(*ComponentLi3Log*)


ComponentLi3Log[expr_]:=Block[{$CCTT,temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=temp/.Tens[a_,b_,c_,d_] :> Tens[a,s[b,c,d]];
    temp=Expand[temp];

    Return[temp];
];


(* ::Subsubsection:: *)
(*ComponentLi4*)


ComponentLi4[expr_]:=Block[{$CCTT,temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=s[temp];
    temp=Expand[temp];

    Return[temp];
];


(* ::Subsection:: *)
(*Weight 5*)


Sym58[a_,b_,c_,d_,e_] := CCTT[e,a,b,c,d]-CCTT[e,a,b,d,c]-
                        CCTT[e,b,a,c,d]+CCTT[e,b,a,d,c]-
                        CCTT[e,c,d,a,b]+ CCTT[e,d,c,a,b]+
                        CCTT[e,c,d,b,a]-CCTT[e,d,c,b,a];


(* ::Subsubsection:: *)
(*ComponentLi23*)


ComponentLi23[expr_] := Block[{temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=del[temp];
    temp=Expand[temp];

    Return[temp];

];


(* ::Subsubsection:: *)
(*ComponentLi22Log*)


ComponentLi22Log[expr_] := Block[{temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=temp/.Tens[a_,b_,c_,d_,e_] :> Tens[a,del[b,c,d,e]];
    temp=Expand[temp];

    Return[temp];

];


(* ::Subsubsection:: *)
(*ComponentLi2Li2Log*)


ComponentLi2Li2Log[expr_] := Block[{$CCTT,temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=temp/.Tens[a_,b_,c_,d_,e_] :> Tens[a,s[b,c],s[d,e]];
    temp=Expand[temp];

    Return[temp];
];


(* ::Subsubsection:: *)
(*ComponentLi3Li2*)


ComponentLi3Li2[expr_] := Block[{$CCTT,temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=temp/.Tens[a_,b_,c_,d_,e_] :> Tens[s[a,b,c],s[d,e]];
    temp=Expand[temp];

    Return[temp];
];


(* ::Subsubsection:: *)
(*ComponentLi2LogLogLog*)


ComponentLi2LogLogLog[expr_] := Block[{$CCTT,temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=temp/.Tens[a_,b_,c_,d_,e_] :> Tens[a,b,c,s[d,e]];
    temp=Expand[temp];

    Return[temp];
];


(* ::Subsubsection:: *)
(*ComponentLi3LogLog*)


ComponentLi3LogLog[expr_] := Block[{$CCTT,temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=temp/.Tens[a_,b_,c_,d_,e_] :> Tens[a,b,s[c,d,e]];
    temp=Expand[temp];

    Return[temp];
];


(* ::Subsubsection:: *)
(*ComponentLi4Log*)


ComponentLi4Log[expr_] := Block[{$CCTT,temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=temp/.Tens[a_,b_,c_,d_,e_] :> Tens[a,s[b,c,d,e]];
    temp=Expand[temp];

    Return[temp];
];


(* ::Subsubsection:: *)
(*ComponentLi5*)


ComponentLi5[expr_] := Block[{$CCTT,temp},

    temp=Expand[expr]/.CiTi[x__]:>Tens@@(ElTens/@{x});
    temp=s[temp];
    temp=Expand[temp];

    Return[temp];
];


(* ::Section:: *)
(*BasisFitting*)


(*ConstructTensorSpaceBasis[list_] := Block[{temp = Expand[list]},

    If[Head[temp] === List, 
       Return[Union[Flatten[ConstructTensorSpaceBasis /@ temp]]]];

    If[Head[temp] === Plus, 
       temp = List @@ temp,
       temp = {temp}
      ];

    temp = temp //.{_ *Tens[c__]:>Tens[c],_ *TensWedge[c__]:>TensWedge[c], _ *CiTi[c__]:>CiTi[c]};
    temp = Union[flatTensor[temp]];

    Return[temp];

];*)

ConstructTensorSpaceBasis[list_] := Cases[Variables[list],_CiTi];


BBPP/:a_ BBPP[n_,b_]:=BBPP[n,a b];


FindUnknowns[expr_]:=Block[{temp = List @@ Expand[expr]},

   temp = Union[temp //. {_CiTi :> 1, _Tens:>1}];
   temp = Variables[temp];
   
   Return[temp];
];



Options[FitToTensorBasis] = {Engine -> Automatic, Verbose -> False, Variables -> Automatic, Recursion -> 500};

FitToTensorBasis[ansatz_, OptionsPattern[]] := Block[{input = flatTensor[Expand[ansatz]],
    basis, solution,   
    variables = OptionValue[Variables]
    },


    If[variables === Automatic,
       variables = FindUnknowns[input]
       ];


    basis = ConstructTensorSpaceBasis[input];


    solution = FitToBasis[input, basis, variables, Engine -> OptionValue[Engine], Verbose -> OptionValue[Verbose], Recursion -> OptionValue[Recursion]];

    Return[solution];

];


Options[RecursiveSolve]={Verbose -> False};


RecursiveSolve[eqs_,variables_,num_:500,OptionsPattern[]]:=Block[
   {run,
    keep=Union[eqs],
    runsol,
    solution={},
    counter=1, unknowns = variables
   },

   
   If[OptionValue[Verbose],
      Print["Solving for ",Length[eqs]," equations."]
      ];



   While[keep=!={},

         If[OptionValue[Verbose],
            Print["> Iteration ",counter++];
            ];

         unknowns = Intersection[variables, Variables[First /@ keep]];;

         If[OptionValue[Verbose],
            Print["Unknowns = ", Length[unknowns]]
           ];

         If[Length[keep]<num,
            run=keep;
            keep={},
            run=keep[[1;;num]];
            keep=Drop[keep,num]
           ];

    
         If[OptionValue[Verbose],
            Print["    Number of Equations = ", Length[run]];
            Print["    Rest                = ", Length[keep]]
           ];
   
         runsol = Reduce[run];
         runsol = If[Head[runsol] === And, 
                     List @@ runsol, {runsol}] /. Equal -> Rule;

         If[OptionValue[Verbose],
            Print["Solutions = ",Length[runsol]]
           ];


    If[(runsol === {}) || (runsol === {False}),
       Return[{}]
      ];

 (*   Print[Union[Expand[run /. Dispatch[runsol]]]];*)
    
    solution=Join[Expand[solution//.Dispatch[runsol]],runsol];
    keep=Union[DeleteCases[Expand/@(keep/.Dispatch[runsol]),True|0]];
    ];

    If[OptionValue[Verbose],
       Print["Number of solutions: ",Length[solution]]
       ];
    Return[solution];
];



Options[FitToBasis] := Options[FitToTensorBasis];


Fit::Engine = "The Engine option should only take the values Automatic, Solve or RecursiveSolve (value encountered: `1`). 
Default value Automatic is used instead."


FitToBasis[ansatz_, basis_, variables_, OptionsPattern[]] := Block[{

   bp = Table[Rule[basis[[i]],BP[i]],{i,Length[basis]}],
   equations, solution, result, inputbasis, ans, 
   engine = OptionValue[Engine], 
   recbound = OptionValue[Recursion]

   },

(*   inputbasis = ConstructTensorSpaceBasis[ansatz];
   If[Length[inputbasis] > Length[bp],
      Print["Warning: Dimension of subspace is less then dimension of input!"]
    ];*)

   ans=ansatz /. Dispatch[bp];

   ans = List @@ (ans /. BP[n_]:>BBPP[n,1]);
   ans = Plus @@@ GatherBy[ans, #[[1]]&];

   (*equations = Table[ans==0 /. BP[i] :>1 /. BP[_]:>0,{i,Length[bp]}];*)
   equations = Union[Equal[#,0]&/@ (ans /. BBPP[_,c_]:>c)];

   Which[engine === Solve, engine=engine,
         engine === RecursiveSolve, engine=engine,
         True, If[engine =!= Automatic,
                  Message[Fit::Engine, engine];
                  engine = Automatic
                  ];
                If[Length[equations] > recbound,
                   If[OptionValue[Verbose],
                      Print["Recursive mode is used to solve the linear system."];
                      Print["Linear system is solved in blocks of ", recbound, "."];
                      ];
                   engine = RecursiveSolve,
                   engine = Solve
                   ];
         ];

(*Print["Got Eqs."];*)
   solution = If[engine === Solve,
                 Flatten[Solve[equations, variables]],
                 RecursiveSolve[equations, variables, recbound, Verbose -> OptionValue[Verbose]]
                ];

   Return[solution];

];
    


ConstructBasisVectorRules[basis_] := Block[{unitmat = IdentityMatrix[Length[basis]],rules,keep},

    unitmat = keep @@@ unitmat;
    rules = Inner[Rule, basis, unitmat, List] /. keep -> List;
    Return[rules];
];    


(* ::Section:: *)
(**)


S3Element[1,x_] := x;
S3Element[2,x_] := 1-x;
S3Element[3,x_] := x/(x-1);
S3Element[4,x_] := 1/x;
S3Element[5,x_] := 1/(1-x);
S3Element[6,x_] := (x-1)/x;

S3Act[i_Integer, x_] := Which[Head[x] === List, S3Act[i, #]&/@x,
                              x === 1, 1,
                              True, S3Element[i,x]
                             ];


S3Orbit[x_] := Sort[Simplify[Factor[S3Act[#,x]& /@ Range[6]]]];


ConstructS3Orbits[list_List]:=Union[S3Orbit /@ list]


(* ::Section:: *)
(*Output*)


Options[AddToList] = {PrecisionGoal->500};


AddToList[Rule[hpl_, expr_], list_, OptionsPattern[]] := Block[{
 
   check,
   bool = False,
   newlist = list

   },

   checktext = "";
   If[Head[newlist] =!= List, newlist = {}];

   Print["Checking ", hpl, " : ", Dynamic[checktext]];
   check = Abs[Ginsh[expr - hpl /. Li->LiG  /. HPL[ws_, x_] :> H[Sequence @@ HPLMtoA[ws],x], {x -> Random[]}, PrecisionGoal -> OptionValue[PrecisionGoal]]];
   checktext = If[check < 10^(-OptionValue[PrecisionGoal]),
                  bool = True; Style["Passed", Green],
                  bool = False; Style["Failed", Red]
                 ];

   If[bool,
      If[MemberQ[newlist, Rule[hpl, _]],
         Print["Deleting doulbe entries."];
         newlist = DeleteCases[newlist, Rule[hpl, _]]
         ];
      Print["Saving"];
      newlist = Append[newlist, Rule[hpl, expr]];
     ];

Return[newlist];
];
    

   
   


Options[CheckList] = {PrecisionGoal->500};
Options[CheckReduction] = {PrecisionGoal->500};


CheckReduction[Rule[hpl_, expr_], OptionsPattern[]] := Block[{

    check

    },

   checktext = "";

   Print["Checking ", hpl, " : ", Dynamic[checktext]];
   check = Abs[Ginsh[expr - hpl /. Li->LiG  /. HPL[ws_, x_] :> H[Sequence @@ HPLMtoA[ws],x], {x -> Random[]}, PrecisionGoal -> OptionValue[PrecisionGoal]]];
   If[check < 10^(-OptionValue[PrecisionGoal]),
                  checktext = Style["Passed", Green]; Return[0],
                  checktext = Style["Failed", Red];Return[1]
                 ];
];

CheckList[list_] := DeleteCases[CheckReduction /@ list,0];

   


(* ::Section:: *)
(*Reader*)


PolygonReader[filename_String]:=Block[{

tensor =Import[filename,"Table"]

},

tensor=StringJoin@@@tensor;
tensor=StringReplace[#,{"["->"{","]"->"}"}]&/@tensor;
tensor=ToExpression/@tensor;
tensor=(Last[#](CiTi@@Most[#]))&/@tensor;
tensor=Plus@@tensor;

Return[tensor];

];


flatTensor[expr_]:=expr/.CiTi->CCTT/.CCTT[as__]:>flat/@CCTT[as]/.CCTT->CiTi


(* ::Section:: *)
(*Integrability*)


ExtractFromTensor[tensor_CiTi,{i_Integer,j_Integer}] := If[Max[i,j] > Length[tensor], 0, Weggizer[Log[tensor[[i]]],Log[tensor[[j]]]]Delete[CCTT@@tensor,{{i},{j}}]];


TotalDifferential[expr_,vars_List] := Plus @@ (D[expr,#]der[#]&/@vars);


DiffWedge[as___,sum_Plus,bs___] := DiffWedge[as,#,bs]& /@ sum;
DiffWedge[as___,Except[der[_],x_]y_,bs___] := x DiffWedge[as,y,bs];
DiffWedge[der[x_],der[x_]] := 0;
DiffWedge[der[x_],der[y_]] := -DiffWedge[der[y],der[x]] /; Not[OrderedQ[{x,y}]];
DiffWedge[___,0,___] := 0;


TagWedge[as___]:=TagWedge2@@(Factor/@{as})
TagWedge2[as___,x_,bs___]/;Denominator[x]=!=1&&FreeQ[Denominator[x],_der]:=$tag[Denominator[x]]TagWedge2[as,Numerator[x],bs]


Options[CheckIntegrabilityTagged]={Basis->Automatic};

CheckIntegrabilityTagged[expr_, n_Integer, primes_List,options___] := CheckIntegrability[expr,{n,n+1},options];
CheckIntegrabilityTagged[expr_, {n_Integer}, primes_List,options___] := CheckIntegrability[expr,{n,n+1},options]

CheckIntegrabilityTagged[expr_,{i_Integer,j_Integer},primes_List,OptionsPattern[]] := Block[{
   basis=OptionValue[Basis],
   temp=Expand[expr],
   extractor,weggizer,diffweggizer, vars,tagger,untagger
   },

   vars = Variables[FindPrimeElements[temp]];

   extractor[ex_]:=ex/.is_CiTi:>ExtractFromTensor[is,{i,j}];
   weggizer[ex_]:=ex/.Weggizer[a_,b_]:>Weggizer[TotalDifferential[a,vars],TotalDifferential[b,vars]];
   diffweggizer[ex_]:=ex/.Weggizer->DiffWedge;
	tagger[ex_]:=ex/.Weggizer->TagWedge;
	untagger[ex_]:=ex/.TagWedge2->Weggizer;
	temp = untagger/@tagger/@weggizer/@extractor/@temp;
   temp = (temp//.$tag[f_Times]:>$tag/@f)//.$tag[f_]:>$prime@@Flatten[Position[primes,f,1]];
   temp = Expand[diffweggizer/@temp];

    If[temp===0,
       Return[temp]];

    If[OptionValue[Basis]=!=Automatic,
       temp=CollectTensorsCoefficients[temp/.CCTT->CiTi,Basis->basis],
       temp=temp/.CCTT[]:>1
      ];

     Return[temp //. DiffWedge -> WEDGE //. der -> Identity //. CCTT -> CiTi];
];


Options[CheckIntegrability]={Basis->Automatic};

CheckIntegrability[expr_, n_Integer, options___] := CheckIntegrability[expr,{n,n+1},options];
CheckIntegrability[expr_, {n_Integer}, options___] := CheckIntegrability[expr,{n,n+1},options]

CheckIntegrability[expr_,{i_Integer,j_Integer},OptionsPattern[]] := Block[{
   basis=OptionValue[Basis],
   temp=Expand[expr],
   extractor,weggizer,diffweggizer, vars,tagger,untagger
   },

   vars = Variables[FindPrimeElements[temp]];

   extractor[ex_]:=ex/.is_CiTi:>ExtractFromTensor[is,{i,j}];
   weggizer[ex_]:=ex/.Weggizer[a_,b_]:>Weggizer[TotalDifferential[a,vars],TotalDifferential[b,vars]];
   diffweggizer[ex_]:=ex/.Weggizer->DiffWedge;
	tagger[ex_]:=ex/.Weggizer->TagWedge;
	untagger[ex_]:=ex/.TagWedge2->Weggizer;
   temp = If[Head[temp] === Plus,
      weggizer/@extractor/@temp,
      weggizer[extractor[temp]]
      ];
   temp = Expand[diffweggizer/@temp];

    If[temp===0,
       Return[temp]];

    If[OptionValue[Basis]=!=Automatic,
       temp=CollectTensorsCoefficients[temp/.CCTT->CiTi,Basis->basis],
       temp=temp/.CCTT[]:>1
      ];

     Return[temp //. DiffWedge -> WEDGE //. der -> Identity //. CCTT -> CiTi];
];


CheckIntegrability[expr_] := Block[{temp=Expand[expr], base,maxweight},

   base = If[Head[temp] === Plus, List @@ temp, {temp}];
   base = Union[base //. _ c_CiTi :> c];
   maxweight = Max @@ (Length /@ base);

   base = {#,#+1}& /@ Range[maxweight-1];
   temp = {#, CheckIntegrability[temp, #]}& /@ base;

   Return[temp];
]; 
   



Options[CollectTensorsCoefficients]={Basis->Automatic};

CollectTensorsCoefficients[expr_,OptionsPattern[]]:=Block[{
   basis,
   bp,
   ans=expr
   },

   If[OptionValue[Basis]===Automatic,
      basis = ConstructTensorSpaceBasis[expr];
      bp = Table[Rule[basis[[i]],BBPP[i,1]],{i,Length[basis]}],
      bp=OptionValue[Basis]
     ];

   ans = List @@ (ans /.bp);
   ans = Plus @@@ GatherBy[ans, #[[1]]&];
   ans = ans/.BBPP[_,x_]:>x;

   Return[ans];
];




(* ::Section:: *)
(*ds*)


Clear[der,deri];
der[expr_,x_]:=deri[expr/.CiTi->Ct,x]/.Ct->CiTi
deri[sum_Plus,x_]:=deri[#,x]&/@sum;
deri[a_ *b_,x_]:=deri[a,x]b+a deri[b,x]
deri[a_?(FreeQ[#,Ct]&),x_]:=D[a,x];
deri[Ct[as__,b_],x_]:=D[Log[b],x]Ct[as];
deri[Ct[b_],x_]:=D[Log[b],x]
collector[a_ ct_CiTi,x_,var_]:=collector[a,ct x,var];
collector[a_ b_,x_,var_]:=collector[a,b x,var]/;FreeQ[b,var];
termer[list_List]:=$term[list[[1,1]],Plus@@(#[[2]]&/@list)]

DenominatorCollector[expr_, var_] := Block[{
    temp = Factor[expr],
    num, den
    },
     
    num = Numerator[temp];
    den = Collect[Denominator[temp], var, Factor];
    
    Return[num/den];
];


CollectRationalTerms[expr_,var_]:=Block[{exp=Expand[Apart[#,var]&/@expr]},
   exp=If[Head[exp]===Plus,List@@exp,{exp}];
   exp=collector[#,1,var]&/@exp;
   exp=exp/.collector[a_,b_,v_]:>collector[Apart[Factor[a],v],b,v];
   exp=exp/.collector[Power[a_+bb_ v_,-1],b_,v_]:>collector[Power[v+a/bb,-1],b/bb,v];
   exp=exp/.collector[Power[a_-v_,-1],b_,v_]:>collector[Power[v-a,-1],-b,v];
   exp=termer/@GatherBy[exp,First];
   exp = exp /. $term[a_,b_] :> $term[DenominatorCollector[a, var], b];
   Return[exp];
];




Clear[SymbG]
SymbG[sum_Plus,var_]:=SymbG[#,var]&/@sum;
SymbG[Except[CiTi[___],a_] b_,var_]:=a SymbG[b,var];
SymbG[CiTi[var_],_]:=G[0,Identity@@var];
SymbG[CiTi[a_+b_. var_],var_]:=G[0,a]+G[-a/b,var];
SymbG[CiTi[b_. var_+a_],var_]:=G[0,-a]+G[-a/b,var];
SymbG[CiTi[a_-b_],var_]:=G[0,a]+G[a,b]/;FreeQ[a,var]&&FreeQ[b,var]
SymbG[1,_]:=1;

IntegrateUp[$term[a_,b_],var_]:=Gint[Expand[Apart[a SymbG[b,var],var]],var,var];
IntegrateUp[list_List,var_]:=Plus@@(IntegrateUp[#,var]&/@list);


(* ::Section:: *)
(**)


TensToCiTi[expr_] := expr //. Tens[as___]:> CiTi @@ (Identity @@@ {as});


ssh21[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_] :> Tens[sh[Tens[a,b]], c]]];
ssh12[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_] :> Tens[a, sh[Tens[b,c]]]]];

ssh31[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_] :> Tens[sh[Tens[a,b,c]], d]]];
ssh13[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_] :> Tens[a, sh[Tens[b,c,d]]]]];
ssh22[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_] :> Tens[sh[Tens[a,b]], sh[Tens[c,d]]]]];
ssh211[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_] :> Tens[sh[Tens[a,b]], c,d]]];
ssh121[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_] :> Tens[a, sh[Tens[b,c]],d]]];
ssh112[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_] :> Tens[a, b,sh[Tens[c,d]]]]];

ssh41[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[sh[Tens[a,b,c,d]], e]]];
ssh14[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[a, sh[Tens[b,c,d,e]]]]];
ssh32[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[sh[Tens[a,b,c]], sh[Tens[d,e]]]]];
ssh23[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[sh[Tens[a,b]], sh[Tens[c,d,e]]]]];
ssh311[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[sh[Tens[a,b,c]], d,e]]];
ssh131[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[a,sh[Tens[b,c,d]], e]]];
ssh113[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[a,b, sh[Tens[c,d,e]]]]];
ssh221[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[sh[Tens[a,b]], sh[Tens[c,d]],e]]];
ssh212[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[sh[Tens[a,b]], c,sh[Tens[d,e]]]]];
ssh122[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[a,sh[Tens[b,c]], sh[Tens[d,e]]]]];
ssh2111[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[sh[Tens[a,b]],c,d,e]]];
ssh1211[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[a,sh[Tens[b,c]],d,e]]];
ssh1121[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[a,b,sh[Tens[c,d]],e]]];
ssh1112[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_] :> Tens[a,b,c,sh[Tens[d,e]]]]];

ssh51[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b,c,d,e]], f]]];
ssh15[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a, sh[Tens[b,c,d,e,f]]]]];
ssh42[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b,c,d]], sh[Tens[e,f]]]]];
ssh24[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b]], sh[Tens[c,d,e,f]]]]];
ssh33[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b,c]], sh[Tens[d,e,f]]]]];
ssh411[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b,c,d]], e,f]]];
ssh141[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,sh[Tens[b,c,d,e]], f]]];
ssh114[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,b, sh[Tens[c,d,e,f]]]]];
ssh321[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b,c]], sh[Tens[d,e]],f]]];
ssh312[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b,c]], d, sh[Tens[e,f]]]]];
ssh231[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b]], sh[Tens[c,d,e]],f]]];
ssh213[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b]], c, sh[Tens[d,e,f]]]]];
ssh123[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a, sh[Tens[b,c]], sh[Tens[d,e,f]]]]];
ssh132[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a, sh[Tens[b,c,d]], sh[Tens[e,f]]]]];
ssh222[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b]], sh[Tens[c,d]], sh[Tens[e,f]]]]];

ssh3111[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b,c]],d,e,f]]];
ssh1311[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,sh[Tens[b,c,d]],e,f]]];
ssh1131[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,b,sh[Tens[c,d,e]],f]]];
ssh1113[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,b,c,sh[Tens[d,e,f]]]]];

ssh2211[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b]],sh[Tens[c,d]],e,f]]];
ssh2121[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b]],c,sh[Tens[d,e]],f]]];
ssh2112[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b]],c,d,sh[Tens[e,f]]]]];
ssh1221[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,sh[Tens[b,c]],sh[Tens[d,e]],f]]];
ssh1212[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,sh[Tens[b,c]],d,sh[Tens[e,f]]]]];
ssh1122[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,b,sh[Tens[c,d]],sh[Tens[e,f]]]]];

ssh21111[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[sh[Tens[a,b]],c,d,e,f]]];
ssh12111[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,sh[Tens[b,c]],d,e,f]]];
ssh11211[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,b,sh[Tens[c,d]],e,f]]];
ssh11121[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,b,c,sh[Tens[d,e]],f]]];
ssh11112[expr_] := TensToCiTi[Expand[expr /. CiTi[as__] :> Tens @@ (ElTens /@ CiTi[as]) /. Tens[a_, b_, c_, d_, e_, f_] :> Tens[a,b,c,d,sh[Tens[e,f]]]]];



sh21CiTi[a_,b_,c_] = ssh21[CiTi[a,b,c]];
sh12CiTi[a_,b_,c_] = ssh12[CiTi[a,b,c]];

sh31CiTi[a_,b_,c_,d_] = ssh31[CiTi[a,b,c,d]];
sh13CiTi[a_,b_,c_,d_] = ssh13[CiTi[a,b,c,d]];
sh22CiTi[a_,b_,c_,d_] = ssh22[CiTi[a,b,c,d]];
sh211CiTi[a_,b_,c_,d_] = ssh211[CiTi[a,b,c,d]];
sh121CiTi[a_,b_,c_,d_] = ssh121[CiTi[a,b,c,d]];
sh112CiTi[a_,b_,c_,d_] = ssh112[CiTi[a,b,c,d]];

sh41CiTi[a_,b_,c_,d_,e_] = ssh41[CiTi[a,b,c,d,e]];
sh14CiTi[a_,b_,c_,d_,e_] = ssh14[CiTi[a,b,c,d,e]];
sh32CiTi[a_,b_,c_,d_,e_] = ssh32[CiTi[a,b,c,d,e]];
sh23CiTi[a_,b_,c_,d_,e_] = ssh23[CiTi[a,b,c,d,e]];
sh311CiTi[a_,b_,c_,d_,e_] = ssh311[CiTi[a,b,c,d,e]];
sh131CiTi[a_,b_,c_,d_,e_] = ssh131[CiTi[a,b,c,d,e]];
sh113CiTi[a_,b_,c_,d_,e_] = ssh113[CiTi[a,b,c,d,e]];
sh221CiTi[a_,b_,c_,d_,e_] = ssh221[CiTi[a,b,c,d,e]];
sh212CiTi[a_,b_,c_,d_,e_] = ssh212[CiTi[a,b,c,d,e]];
sh122CiTi[a_,b_,c_,d_,e_] = ssh122[CiTi[a,b,c,d,e]];
sh2111CiTi[a_,b_,c_,d_,e_] = ssh2111[CiTi[a,b,c,d,e]];
sh1211CiTi[a_,b_,c_,d_,e_] = ssh1211[CiTi[a,b,c,d,e]];
sh1121CiTi[a_,b_,c_,d_,e_] = ssh1121[CiTi[a,b,c,d,e]];
sh1112CiTi[a_,b_,c_,d_,e_] = ssh1112[CiTi[a,b,c,d,e]];

sh51CiTi[a_,b_,c_,d_,e_,f_] = ssh51[CiTi[a,b,c,d,e,f]];
sh15CiTi[a_,b_,c_,d_,e_,f_] = ssh15[CiTi[a,b,c,d,e,f]];
sh42CiTi[a_,b_,c_,d_,e_,f_] = ssh42[CiTi[a,b,c,d,e,f]];
sh24CiTi[a_,b_,c_,d_,e_,f_] = ssh24[CiTi[a,b,c,d,e,f]];
sh33CiTi[a_,b_,c_,d_,e_,f_] = ssh33[CiTi[a,b,c,d,e,f]];
sh411CiTi[a_,b_,c_,d_,e_,f_] = ssh411[CiTi[a,b,c,d,e,f]];
sh141CiTi[a_,b_,c_,d_,e_,f_] = ssh141[CiTi[a,b,c,d,e,f]];
sh114CiTi[a_,b_,c_,d_,e_,f_] = ssh114[CiTi[a,b,c,d,e,f]];
sh123CiTi[a_,b_,c_,d_,e_,f_] = ssh123[CiTi[a,b,c,d,e,f]];
sh132CiTi[a_,b_,c_,d_,e_,f_] = ssh132[CiTi[a,b,c,d,e,f]];
sh213CiTi[a_,b_,c_,d_,e_,f_] = ssh213[CiTi[a,b,c,d,e,f]];
sh231CiTi[a_,b_,c_,d_,e_,f_] = ssh231[CiTi[a,b,c,d,e,f]];
sh312CiTi[a_,b_,c_,d_,e_,f_] = ssh312[CiTi[a,b,c,d,e,f]];
sh321CiTi[a_,b_,c_,d_,e_,f_] = ssh321[CiTi[a,b,c,d,e,f]];
sh222CiTi[a_,b_,c_,d_,e_,f_] = ssh222[CiTi[a,b,c,d,e,f]];

sh3111CiTi[a_,b_,c_,d_,e_,f_] = ssh3111[CiTi[a,b,c,d,e,f]];
sh1311CiTi[a_,b_,c_,d_,e_,f_] = ssh1311[CiTi[a,b,c,d,e,f]];
sh1131CiTi[a_,b_,c_,d_,e_,f_] = ssh1131[CiTi[a,b,c,d,e,f]];
sh1113CiTi[a_,b_,c_,d_,e_,f_] = ssh1113[CiTi[a,b,c,d,e,f]];

sh2211CiTi[a_,b_,c_,d_,e_,f_] = ssh2211[CiTi[a,b,c,d,e,f]];
sh2121CiTi[a_,b_,c_,d_,e_,f_] = ssh2121[CiTi[a,b,c,d,e,f]];
sh2112CiTi[a_,b_,c_,d_,e_,f_] = ssh2112[CiTi[a,b,c,d,e,f]];
sh1221CiTi[a_,b_,c_,d_,e_,f_] = ssh1221[CiTi[a,b,c,d,e,f]];
sh1212CiTi[a_,b_,c_,d_,e_,f_] = ssh1212[CiTi[a,b,c,d,e,f]];
sh1122CiTi[a_,b_,c_,d_,e_,f_] = ssh1122[CiTi[a,b,c,d,e,f]];

sh21111CiTi[a_,b_,c_,d_,e_,f_] = ssh21111[CiTi[a,b,c,d,e,f]];
sh12111CiTi[a_,b_,c_,d_,e_,f_] = ssh12111[CiTi[a,b,c,d,e,f]];
sh11211CiTi[a_,b_,c_,d_,e_,f_] = ssh11211[CiTi[a,b,c,d,e,f]];
sh11121CiTi[a_,b_,c_,d_,e_,f_] = ssh11121[CiTi[a,b,c,d,e,f]];
sh11112CiTi[a_,b_,c_,d_,e_,f_] = ssh11112[CiTi[a,b,c,d,e,f]];





sh21[expr_] := Expand[expr] /. CiTi -> sh21CiTi;
sh12[expr_] := Expand[expr] /. CiTi -> sh12CiTi;

sh31[expr_] := Expand[expr] /. CiTi -> sh31CiTi;
sh13[expr_] := Expand[expr] /. CiTi -> sh13CiTi;
sh22[expr_] := Expand[expr] /. CiTi -> sh22CiTi;
sh211[expr_] := Expand[expr] /. CiTi -> sh211CiTi;
sh121[expr_] := Expand[expr] /. CiTi -> sh121CiTi;
sh112[expr_] := Expand[expr] /. CiTi -> sh112CiTi;

sh41[expr_] := Expand[expr] /. CiTi -> sh41CiTi;
sh14[expr_] := Expand[expr] /. CiTi -> sh14CiTi;
sh32[expr_] := Expand[expr] /. CiTi -> sh32CiTi;
sh23[expr_] := Expand[expr] /. CiTi -> sh23CiTi;
sh311[expr_] := Expand[expr] /. CiTi -> sh311CiTi;
sh131[expr_] := Expand[expr] /. CiTi -> sh131CiTi;
sh113[expr_] := Expand[expr] /. CiTi -> sh113CiTi;
sh221[expr_] := Expand[expr] /. CiTi -> sh221CiTi;
sh212[expr_] := Expand[expr] /. CiTi -> sh212CiTi;
sh122[expr_] := Expand[expr] /. CiTi -> sh122CiTi;
sh2111[expr_] := Expand[expr] /. CiTi -> sh2111CiTi;
sh1211[expr_] := Expand[expr] /. CiTi -> sh1211CiTi;
sh1121[expr_] := Expand[expr] /. CiTi -> sh1121CiTi;
sh1112[expr_] := Expand[expr] /. CiTi -> sh1112CiTi;

sh51[expr_] := Expand[expr] /. CiTi -> sh51CiTi;
sh15[expr_] := Expand[expr] /. CiTi -> sh15CiTi;
sh42[expr_] := Expand[expr] /. CiTi -> sh42CiTi;
sh24[expr_] := Expand[expr] /. CiTi -> sh24CiTi;
sh33[expr_] := Expand[expr] /. CiTi -> sh33CiTi;
sh411[expr_] := Expand[expr] /. CiTi -> sh411CiTi;
sh141[expr_] := Expand[expr] /. CiTi -> sh141CiTi;
sh114[expr_] := Expand[expr] /. CiTi -> sh114CiTi;
sh321[expr_] := Expand[expr] /. CiTi -> sh321CiTi;
sh312[expr_] := Expand[expr] /. CiTi -> sh312CiTi;
sh231[expr_] := Expand[expr] /. CiTi -> sh231CiTi;
sh213[expr_] := Expand[expr] /. CiTi -> sh213CiTi;
sh123[expr_] := Expand[expr] /. CiTi -> sh123CiTi;
sh132[expr_] := Expand[expr] /. CiTi -> sh132CiTi;
sh222[expr_] := Expand[expr] /. CiTi -> sh222CiTi;

sh3111[expr_] := Expand[expr] /. CiTi -> sh3111CiTi;
sh1311[expr_] := Expand[expr] /. CiTi -> sh1311CiTi;
sh1131[expr_] := Expand[expr] /. CiTi -> sh1131CiTi;
sh1113[expr_] := Expand[expr] /. CiTi -> sh1113CiTi;

sh2211[expr_] := Expand[expr] /. CiTi -> sh2211CiTi;
sh2121[expr_] := Expand[expr] /. CiTi -> sh2121CiTi;
sh2112[expr_] := Expand[expr] /. CiTi -> sh2112CiTi;
sh1221[expr_] := Expand[expr] /. CiTi -> sh1221CiTi;
sh1212[expr_] := Expand[expr] /. CiTi -> sh1212CiTi;
sh1122[expr_] := Expand[expr] /. CiTi -> sh1122CiTi;

sh21111[expr_] := Expand[expr] /. CiTi -> sh21111CiTi;
sh12111[expr_] := Expand[expr] /. CiTi -> sh12111CiTi;
sh11211[expr_] := Expand[expr] /. CiTi -> sh11211CiTi;
sh11121[expr_] := Expand[expr] /. CiTi -> sh11121CiTi;
sh11112[expr_] := Expand[expr] /. CiTi -> sh11112CiTi;



(* ::Section:: *)
(*Symbol Hopf algebra*)


ProductProjector[cc_CiTi] /; Length[cc] > 1 := sh[cc];
ProductProjector[cc_CiTi] /; Length[cc] == 1 := cc;


(* ::Subsection:: *)
(*The deconcatenation coproduct*)


DeltaDeconcatenation[sum_Plus] := DeltaDeconcatenation /@ sum;
DeltaDeconcatenation[a_ b_] := a DeltaDeconcatenation[b] /; FreeQ[a, CiTi];
DeltaDeconcatenation[a_] := a /; FreeQ[a, CiTi];


DeltaDeconcatenation[cc_CiTi] := CT[1,cc] + CT[cc,1] + Sum[CT[Take[cc,k],Drop[cc,k]],{k,1,Length[cc]-1}];


(* ::Subsection:: *)
(*The antipode*)


AntipodeDeconcatenation[sum_Plus] := AntipodeDeconcatenation /@ sum;
AntipodeDeconcatenation[a_ b_] := a AntipodeDeconcatenation[b] /; FreeQ[a, CiTi];
AntipodeDeconcatenation[a_] := a /; FreeQ[a, CiTi];


AntipodeDeconcatenation[cc_CiTi] := (-1)^Length[cc] * Reverse[cc];


(* ::Subsection:: *)
(*Cobracket*)


CobracketDeconcatenation[expr_] := Block[{cop = DeltaDeconcatenation[expr]},
   cop = cop - (cop /. CT[a_,b_]:>CT[b,a]);
   cop = cop /. CT[a_,b_] :> CT[ProductProjector[a],ProductProjector[b]];
   Return[Expand[cop/2/.CT->CTW]];
   ];


(* ::Subsection:: *)
(*Term selection*)


Clear[SymbolWeight];


SymbolWeight[CT[as__]] := SymbolWeight /@ CTTW[as];


SymbolWeight[a_ * b_] := SymbolWeight[a] + SymbolWeight[b];
SymbolWeight[Power[a_, n_Integer]] := n * SymbolWeight[a];

SymbolWeight[cc_CiTi] := Length[cc];
SymbolWeight[_Integer|_Rational|_Complex] = 0;
SymbolWeight[Except[_Plus]]:=0;
SymbolWeight[c[_]] = 0;


GetSymbolTerms[expr_, n_Integer] := Block[{temp=Expand[expr], weight},

    If[Head[temp] === Plus, Return[Select[Expand[expr], SymbolWeight[#] === n&]]];

    weight = SymbolWeight[temp];
    temp = If[weight ==n, temp, 0];  

    Return[temp];]


DecomposeDeltaDeconcatenation[expr_] := Block[{
    temp = Expand[expr//.CT[a__]:>CT[Sequence@@(Expand/@{a})]]
    },

    temp = If[Head[temp] === Plus, 
              List @@ temp,
              {temp}
             ];

    temp = GatherBy[temp, SymbolWeight];
   
    temp = Prepend[#, List @@ SymbolWeight[#[[1]]]]& /@ temp;

    temp = {#[[1]], Plus @@ Rest[#]}& /@ temp;

    Return[temp];

];


CobracketDeconcatenation[ij_List,g_] := DeltaComponent[CombineCobracketLines/@(GatherBy[MapAt[Sort,#,1]&/@DecomposeDeltaDeconcatenation[CobracketDeconcatenation[g]/.CTW->CT],First]),Sort[ij]]//.CT->CTW;


DeltaDeconcatenation[{i_,j_},g_] := DeltaComponent[DecomposeDeltaDeconcatenation[DeltaDeconcatenation[g]],{i,j}];

DeltaDeconcatenation[{is__,j_,k_},g_] := DeltaDeconcatenation[{Total[{is,j}],k},g] /. CT[a_,b_]:> CT[Expand[DeltaDeconcatenation[{is,j}, a]],b];


(* ::Section:: *)
(*Public functions*)


GetSymbolAlphabet = FindPrimeElements;


SymbolExpand = ReduceTensorProduct;

SymbolFactor[symb_]:=FullSimplify[symb //. CiTi -> cc //. 
 cc[a___, x_, b___] f_. + cc[a___, y_, b___] g_. :> cc[a, x^f y^g, b]]/.cc->CiTi;


MakeMaxDelta[n_Integer] := Symbol["Delta" <> (StringJoin @@ Table["1",{n}])];


Clear[SymbolMap];
SymbolMap[sum_Plus] := SymbolMap /@ sum;
SymbolMap[a_ b_] /; FreeQ[a,G|H|HPL|PolyLog|Log|Li|Pi|MZV|Zeta|cG|cC|Cl|GR|GI] := a SymbolMap[b];
SymbolMap[a_] /; FreeQ[a,G|H|HPL|PolyLog|Log|Li|Pi|MZV|Zeta|cG|cC|Cl|GR|GI] := a;
SymbolMap[a_ * b_] := Expand[Expand[Expand[SymbolMap[a]SymbolMap[b]] //. CiTi|Tens -> ShuffleCiTi]//. ShuffleCiTi->CiTi //. Tens -> CiTi //. ElTens -> Identity ];
SymbolMap[a_^n_Integer] /; n >1 := Expand[Expand[Expand[SymbolMap[a]^n] //. CiTi|Tens -> ShuffleCiTi] //. ShuffleCiTi->CiTi//. Tens -> CiTi //. ElTens -> Identity ];

SymbolMap[Pi^_.] := 0;
SymbolMap[_Cl^_.] := 0;
SymbolMap[_GR^_.] := 0;
SymbolMap[_GI^_.] := 0;
SymbolMap[_Zeta^_.] := 0;
SymbolMap[_MZV^_.] := 0;

SymbolMap[l_Log] := ComputeSymbol[l];
SymbolMap[l_PolyLog] := ComputeSymbol[l];
SymbolMap[l_H] := ComputeSymbol[l];
SymbolMap[l_HPL] := ComputeSymbol[l];
SymbolMap[l_G] /; TranscendentalWeight[l] === 1 := SymbolMap[l//.G->GLog];
SymbolMap[l_G] /; TranscendentalWeight[l] > 1 := SymbolExpand[ToSymbol[MakeMaxDelta[TranscendentalWeight[l]][l]]];
SymbolMap[l_cG] := SymbolMap[cGToG[l]];
SymbolMap[l_cC] := SymbolMap[cCToG[l]];
SymbolMap[l_cC] := SymbolMap[LiToG[l]];


IntegrabilityCondition[expr_,i_Integer] := CheckIntegrability[expr,{i,i+1}]//.WEDGE[a_,b_] -> CTW[DifferentialD[a],DifferentialD[b]]
