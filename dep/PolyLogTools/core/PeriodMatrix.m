(* ::Package:: *)

(* ::Section:: *)
(*PeriodMatrix*)


MakePeriLineRule[list_List]:=Rule[list[[1,1]],(2Pi I)^TranscendentalWeight[list[[1,1]]]Total[list[[All,2]]]]


MakePeriLine[elem_,conjs_]:=Block[{delta1=Delta[elem],
   oneconjs,rest,MyRule,$one
   },
   oneconjs=Prepend[DeleteCases[conjs,1],$one];
   delta1=delta1//.CT[a_,b_]:>CT[Expand[a],Expand[b]]//.CT->$CCT//.a_ $CCT[b_,c_]:>$CCT[b,a c];
   delta1=If[Head[delta1]===Plus,List@@delta1,{delta1}];
   delta1=GatherBy[delta1,First];
   delta1=MakePeriLineRule/@delta1;
   delta1=MyRule@@@delta1;
   delta1=delta1//.MyRule[1,a_]:>MyRule[$one,a];
   rest=MyRule[#,0]&/@Complement[oneconjs,First/@delta1];
   delta1=Join[delta1,rest]//.MyRule->Rule;
   Return[oneconjs/.delta1];
];


Clear[PeriodMatrix];
PeriodMatrix[expr_]:=PeriodMatrix[expr]=Block[{delta=Delta[expr],
   $CCT,firsts,elems,linerules
   },
   delta=delta//.CT[a_,b_]:>CT[Expand[a],Expand[b]]//.CT->$CCT//.a_ $CCT[b_,c_]:>$CCT[b,a c];
   firsts=If[Head[delta]===Plus,List@@delta,{delta}];
   firsts=SortBy[Union[firsts//.$CCT[a_,_]:>a],TranscendentalWeight];
   firsts=MakePeriLine[#,firsts]&/@firsts;
   Return[Transpose[firsts]];
];


(* ::Section:: *)
(*Single-Valued Periods*)


(* ::Subsection:: *)
(*ComplexConjugate*)


ComplexConjugate[l_List]:=ComplexConjugate/@l;
ComplexConjugate[l_Plus]:=ComplexConjugate/@l;
ComplexConjugate[l_Times]:=ComplexConjugate/@l;
ComplexConjugate[Power[a_,n_]]:=ComplexConjugate[a]^n;


ComplexConjugate[l_?NumericQ]:=Conjugate[l];
ComplexConjugate[l_]:=Conjugate[l] /; NotContainsTranscendentalFunctionQ[l];


ComplexConjugate[Log[a_]] := Log[ComplexConjugate[a]];
ComplexConjugate[PolyLog[n_,a_]] := PolyLog[n,ComplexConjugate[a]];
ComplexConjugate[g_G] := ComplexConjugate /@ g;
ComplexConjugate[H[ws__,z_]] := H[ws,ComplexConjugate[z]];
ComplexConjugate[HPL[ws_,z_]] := HPL[ws,ComplexConjugate[z]];
ComplexConjugate[g_cG] := ComplexConjugate /@ g;
ComplexConjugate[SVH[ws__,z_]] := SVH[ws,ComplexConjugate[z]];
ComplexConjugate[cL[ws__,z_]] := cL[ws,ComplexConjugate[z]];
ComplexConjugate[z_MZV] := z;


(* ::Subsection:: *)
(*SingleValued MPLs*)


cGToG[expr_] := expr //. cG -> ccGG;


Clear[MakeSV];
(*MakeSV[expr_G]:= MakeSV[expr] = Block[{permat,ipermat,$gg,pref,basis,nn,temp},

   permat = PeriodMatrix[expr]//.G->GReg;

   If[Not[SquareMatrixQ[permat]],
      Return[0];
     ];

   ipermat = Inverse[permat];
   ipermat = ComplexConjugate[ipermat];
   temp = (ipermat.permat)[[1,-1]];
   temp=ShuffleG[temp];

   Return[temp];
];*)

ProduceSVFromTerm[{i_,j_},expr_] := (-1)^i expr//.CT[a_,b_]:>ComplexConjugate[Antipode[a]]b;

BuildMakeSV[expr_] := BuildMakeSV[expr]= Total[ProduceSVFromTerm @@@ DecomposeDelta[Delta[expr]]];

MakeSV[expr_G]:= MakeSV[expr] = Module[{argss=Union[DeleteCases[List@@expr,0]],argshadows,temp},
                      argshadows = Inner[Rule,argss,Table[Unique["a$$"],{Length[argss]}],List];
                      argss = Reverse /@ argshadows;
                      temp = BuildMakeSV[expr //. argshadows];
                      temp = temp //. G[as___,Conjugate[b_],bs___] :> Conjugate[G[as,b,bs] //. Conjugate->Identity];
                      temp = temp //. argss //. Conjugate -> ComplexConjugate;
                      Return[temp];
                      ];


SVLi[n_,x_] := PolyLog[n,x]-Sum[(-1)^(n-k) ComplexConjugate[PolyLog[n-k,x]] (Log[x]+Log[ComplexConjugate[x]])^k/k!,{k,0,n-1}];


Clear[ccGG];
ccGG[as__,z_] := ccGG[as,z] = MakeSV[G[as,z]];


Clear[SVMZV];
SVMZV[ms_List] := SVMZV[ms] = Block[{gg,$$x},

  gg = HToG[HPLToH[HPL[ms,$$x]]] //. G->cG;
  gg = cGToG[gg];
  Return[Expand[gg //. $$x -> 1 //. Pi->0]];
];


(* ::Subsection:: *)
(*Special Values*)


cG[ws__, 0] := 0 /; Union[{ws}] =!= {0};

cG[inds__, x_] := Block[{$$x, work}, 
    work = cGToG[cG[inds,$$x]];
    work = work //. $$x -> x;
    Return[Expand[work]];
] /; MemberQ[{0,I,-I,1,-1},x] && (SubsetQ[{0,1,-1}, Union[{inds}]] || SubsetQ[{0,I,-I}, Union[{inds}]]) && PLT$AutoConvertToKnownConstants;


cL[ws__, 0] := 0 /; Union[{ws}] =!= {0};

cL[inds__, x_] := Block[{$$x},
    Return[cLTocG[cL[inds,$$x]]//.$$x->x]
    ]/;  MemberQ[{0,I,-I,1,-1},x] && (Union[{inds}] === {-1,0,1} || Union[{inds}] === {0,1} || Union[{inds}] === {-1,0}  || Union[{inds}] === {-1,1} || Union[{inds}] === {1} || Union[{inds}] === {0} || Union[{inds}] === {-1}) && PLT$AutoConvertToKnownConstants;


(* ::Subsection:: *)
(*SV*)


SV[sum_Plus] := SV /@ sum;
SV[times_Times] := SV /@ times;
SV[Power[a_,n_Integer]] := Power[SV[a],n];

SV[list_List] := SV /@ list;


SV[n_Integer] := n;
SV[n_Rational] := n;
SV[I] := I;


SV[Pi] := 0;
SV[Zeta[n_]] := 2Zeta[n];
SV[MZV[ms_List]] := SVMZV[ms];


SV[l_Log] := l + ComplexConjugate[l];
SV[PolyLog[n_Integer, x_]] := SVLi[n,x];

SV[g_cG] := g;
SV[g_cL] := g;
SV[g_G] := cG @@ g;
SV[g_H] := SV[HToG[g]];
SV[g_HPL] := SV[HPLToG[g]];
SV[PolyLog[n_,m_,x_]] := SV[LiToG[PolyLog[n,m,x]]];


SV[x_] := x /; NotContainsTranscendentalFunctionQ[x] && FreeQ[x, Zeta] && FreeQ[x,MZV];


(* ::Subsection:: *)
(*InversePeriodMatrix*)


InversePeriodMatrix[g_G] := InversePeriodMatrix[g] = Inverse[PeriodMatrix[g]];


(* ::Subsection:: *)
(*SVPeriodMatrix*)


SVPeriodMatrix[g_G]:=SVPeriodMatrix[g]=SV[PeriodMatrix[g]/.Pi->I/2];


SVPeriodMatrix[g_cG] := SVPeriodMatrix[G @@ g];


InverseSVPeriodMatrix[g_G] := InverseSVPeriodMatrix[g] = Inverse[SVPeriodMatrix[g]];


(* ::Subsection:: *)
(*Derivatives*)


DG[g_cG, x_] := Block[{$$g = G @@ g},
  $$g = DG[$$g, x];
  Return[SV[$$g]];
];


(* ::Subsection:: *)
(*Conjugate SV*)


ConjcG[as__,z_]:= ConjcG[as,z] = Block[{permat=InverseSVPeriodMatrix[G[as,z]],diag},
   permat=permat[[1,-1]];
   Return[ComplexConjugate[ShuffleG[permat]]];
];


ConjugatecG[expr_,varList_List] := Block[{temp = expr, vv, rests},

   If[varList === {},
      Return[expr];
     ];

   vv = varList[[1]];
   rests=Rest[varList];

   temp = ShuffleG[temp //. cG[as__, vv] :> ConjcG[as,vv]];
   Return[ConjugatecG[temp,rests]];
];


(* ::Subsection:: *)
(*DGC*)


Unprotect[Conjugate];
Conjugate/:DG[Conjugate[x_],x_] := 0;
Derivative[_Integer][Conjugate][x_]:=0;
Protect[Conjugate];


DGC[sum_Plus,x_] := DGC[#,x]& /@ sum;
DGC[a_ * b_, x_] := a DGC[b,x] + DGC[a,x] b;
DGC[a_, x_] := DG[a,x] /; FreeQ[a,cG];


DGC[g_cG,x_] := Block[{mat,permat = SVPeriodMatrix[g]},
   mat = DG[permat,x];
   mat = ComplexConjugate[mat];
   mat = mat /. cG[as__,xx_] :> ConjcG[as,xx];
   mat = - permat.mat.permat;
   Return[mat[[1,-1]]];
];


(* ::Subsection:: *)
(*ProjSV*)


ProjSV[sum_Plus] := ProjSV /@ sum;
ProjSV[times_Times] := ProjSV /@ times;
ProjSV[Power[a_,n_Integer]] := Power[ProjSV[a],n];

ProjSV[list_List] := ProjSV /@ list;


ProjSV[n_Integer] := n;
ProjSV[n_Rational] := n;
ProjSV[I] := I;


ProjSV[Pi] := Pi;
ProjSV[Zeta[n_]] := Zeta[n]/2;


ProjSV[g_cG] := G @@ g;


ProjSV[g_G] := g;


ProjSV[x_] := x /; NotContainsTranscendentalFunctionQ[x] && FreeQ[x, Zeta] && FreeQ[x,MZV];


(* ::Section:: *)
(*Integration*)


cGIntegrate[expr_, x_] := SV[GIntegrate[ProjSV[expr], x]];


cGCoefficientSimplify[expr_] := SV[GCoefficientSimplify[ProjSV[expr]]];


(* ::Section:: *)
(*ReduceCG*)


ReduceCG[g_cG, as__] := ReduceCG[ProjSV[g],as] /. Rule[a_,b_]:>Rule[SV[a],SV[b]];


(* ::Section:: *)
(*stildeMap*)


stildeMap[sum_Plus]:=stildeMap/@sum;
stildeMap[n_Integer]:=n ;
stildeMap[a_ b_]:=stildeMap[a]stildeMap[b];
stildeMap[n_Rational]:=n ;
stildeMap[z_Zeta]:=(-1)^TranscendentalWeight[z]Antipode[z];
stildeMap[z_MZV]:=(-1)^TranscendentalWeight[z]Antipode[z];
stildeMap[l_Log]:=ComplexConjugate[l];
stildeMap[l_PolyLog]:=(-1)^TranscendentalWeight[l]ComplexConjugate[Antipode[l]];
stildeMap[l_G]:=(-1)^TranscendentalWeight[l]ComplexConjugate[Antipode[l]];
stildeMap[l_H]:=(-1)^TranscendentalWeight[l]ComplexConjugate[Antipode[l]];


Delta[g_cG]:=Block[{ddd=Delta[ProjSV[g]]},
ddd=Delta[ddd];
ddd=ddd/.CT[a_,b_,c_]:>CT[SV[b],stildeMap[a]c];
ddd=ShuffleG[ddd];
Return[ddd];
];


(* ::Section:: *)
(*Clean Single-valued*)


ProductR[sum_Plus]:=ProductR/@sum;
ProductR[n_Integer a_]:=ProductR[a]n;
ProductR[n_Rational a_]:=ProductR[a]n;
ProductR[n_Complex a_]:=ProductR[a]n;
ProductR[n_Integer]:=n;
ProductR[n_Rational]:=n;
ProductR[n_Complex]:=n;

ProductR[Pi^_.  _.]:=0;

ProductR[g1_G^_. g2_G^_. _.]:=0;
ProductR[g1_G^_ _.]:=0;
ProductR[g1_H^_. g2_H^_. _.]:=0;
ProductR[g1_H^_ _.]:=0;
ProductR[g1_HPL^_. g2_HPL^_. _.]:=0;
ProductR[g1_HPL^_ _.]:=0;
ProductR[g1_PolyLog^_. g2_PolyLog^_. _.]:=0;
ProductR[g1_PolyLog^_ _.]:=0;
ProductR[_Log^_. l1_Log^_. _.]:=0;
ProductR[_Log^_  _.]:=0;
ProductR[g1_Zeta^_. _Zeta^_. _.]:=0;
ProductR[g1_Zeta^_ _.]:=0;
ProductR[g1_MZV^_. _MZV^_. _.]:=0;
ProductR[g1_MZV^_ _.]:=0;
ProductR[g1_Li^_. _Li^_. _.]:=0;
ProductR[g1_Li^_ _.]:=0;

ProductR[_H^_. l1_G^_. _.]:=0;
ProductR[_HPL^_. l1_G^_. _.]:=0;
ProductR[_PolyLog^_. l1_G^_. _.]:=0;
ProductR[_Log^_. l1_G^_. _.]:=0;
ProductR[_Zeta^_. l1_G^_. _.]:=0;
ProductR[_MZV^_. l1_G^_. _.]:=0;
ProductR[_Li^_. l1_G^_. _.]:=0;

ProductR[_HPL^_. l1_H^_. _.]:=0;
ProductR[_PolyLog^_. l1_H^_. _.]:=0;
ProductR[_Log^_. l1_H^_. _.]:=0;
ProductR[_Zeta^_. l1_H^_. _.]:=0;
ProductR[_MZV^_. l1_H^_. _.]:=0;
ProductR[_Li^_. l1_H^_. _.]:=0;

ProductR[_PolyLog^_. l1_HPL^_. _.]:=0;
ProductR[_Log^_. l1_HPL^_. _.]:=0;
ProductR[_Zeta^_. l1_HPL^_. _.]:=0;
ProductR[_MZV^_. l1_HPL^_. _.]:=0;
ProductR[_Li^_. l1_HPL^_. _.]:=0;

ProductR[_Log^_. l1_PolyLog^_. _.]:=0;
ProductR[_Zeta^_. l1_PolyLog^_. _.]:=0;
ProductR[_MZV^_. l1_PolyLog^_. _.]:=0;
ProductR[_Li^_. l1_PolyLog^_. _.]:=0;

ProductR[_Zeta^_. l1_Log^_. _.]:=0;
ProductR[_MZV^_. l1_Log^_. _.]:=0;
ProductR[_Li^_. l1_Log^_. _.]:=0;

ProductR[_MZV^_. l1_Zeta^_. _.]:=0;
ProductR[_Li^_. l1_Zeta^_. _.]:=0;

ProductR[_Li^_. l1_MZV^_. _.]:=0;


ProductR[g_G]:=MakeCleanFunction[g,Length[g]-1];
ProductR[g_H]:=MakeCleanFunction[g,Length[g]-1];
ProductR[g_HPL]:=MakeCleanFunction[g,Length[HPLMtoA[g[[1]]]]];
ProductR[g_Li]:=MakeCleanFunction[g,Total[g[[1]]]];
ProductR[g_Log]:=g;
ProductR[PolyLog[n_,z_]]:=MakeCleanFunction[PolyLog[n,z],n];
ProductR[PolyLog[n_,m_,z_]]:=MakeCleanFunction[PolyLog[n,m,z],n+m];
ProductR[Zeta[n_]]:=MakeCleanFunction[Zeta[n],n];
ProductR[MZV[n_]]:=MakeCleanFunction[MZV[n],Total[n]];


MakeCleanFunction[expr_,weight_]:=Block[{temp=expr},
   temp=Total[Last/@DeleteCases[DecomposeDelta[Delta[temp]],{{___,0,___},_}]];
   temp=temp//.CT[a_,b_]:>ProductR[Expand[b]]a;
   Return[weight expr-temp];
];


ProductProjector[sum_Plus]:=ProductProjector/@sum;
ProductProjector[n_Integer a_]:=ProductProjector[a]n;
ProductProjector[n_Rational a_]:=ProductProjector[a]n;
ProductProjector[n_Complex a_]:=ProductProjector[a]n;
ProductProjector[n_Integer]:=n;
ProductProjector[n_Rational]:=n;
ProductProjector[n_Complex]:=n;

ProductProjector[n_ a_] /; FreeQ[n, G|cG|cC|H|HPL|Log|PolyLog|Pi|Zeta|MZV|CiTi]:=ProductProjector[a]n;
ProductProjector[n_] /; FreeQ[n, G|cG|cC|H|HPL|Log|PolyLog|Pi|Zeta|MZV|Li|CiTi]:=n;

ProductProjector[Pi^_.  _.]:=0;

ProductProjector[g1_G^_. g2_G^_. _.]:=0;
ProductProjector[g1_G^_ _.]:=0;
ProductProjector[g1_H^_. g2_H^_. _.]:=0;
ProductProjector[g1_H^_ _.]:=0;
ProductProjector[g1_HPL^_. g2_HPL^_. _.]:=0;
ProductProjector[g1_HPL^_ _.]:=0;
ProductProjector[g1_PolyLog^_. g2_PolyLog^_. _.]:=0;
ProductProjector[g1_PolyLog^_ _.]:=0;
ProductProjector[_Log^_. l1_Log^_. _.]:=0;
ProductProjector[_Log^_  _.]:=0;
ProductProjector[g1_Zeta^_. _Zeta^_. _.]:=0;
ProductProjector[g1_Zeta^_ _.]:=0;
ProductProjector[g1_MZV^_. _MZV^_. _.]:=0;
ProductProjector[g1_MZV^_ _.]:=0;
ProductProjector[g1_Li^_. _Li^_. _.]:=0;
ProductProjector[g1_Li^_ _.]:=0;

ProductProjector[_H^_. l1_G^_. _.]:=0;
ProductProjector[_HPL^_. l1_G^_. _.]:=0;
ProductProjector[_PolyLog^_. l1_G^_. _.]:=0;
ProductProjector[_Log^_. l1_G^_. _.]:=0;
ProductProjector[_Zeta^_. l1_G^_. _.]:=0;
ProductProjector[_MZV^_. l1_G^_. _.]:=0;
ProductProjector[_Li^_. l1_G^_. _.]:=0;

ProductProjector[_HPL^_. l1_H^_. _.]:=0;
ProductProjector[_PolyLog^_. l1_H^_. _.]:=0;
ProductProjector[_Log^_. l1_H^_. _.]:=0;
ProductProjector[_Zeta^_. l1_H^_. _.]:=0;
ProductProjector[_MZV^_. l1_H^_. _.]:=0;
ProductProjector[_Li^_. l1_H^_. _.]:=0;

ProductProjector[_PolyLog^_. l1_HPL^_. _.]:=0;
ProductProjector[_Log^_. l1_HPL^_. _.]:=0;
ProductProjector[_Zeta^_. l1_HPL^_. _.]:=0;
ProductProjector[_MZV^_. l1_HPL^_. _.]:=0;
ProductProjector[_Li^_. l1_HPL^_. _.]:=0;

ProductProjector[_Log^_. l1_PolyLog^_. _.]:=0;
ProductProjector[_Zeta^_. l1_PolyLog^_. _.]:=0;
ProductProjector[_MZV^_. l1_PolyLog^_. _.]:=0;
ProductProjector[_Li^_. l1_PolyLog^_. _.]:=0;

ProductProjector[_Zeta^_. l1_Log^_. _.]:=0;
ProductProjector[_MZV^_. l1_Log^_. _.]:=0;
ProductProjector[_Li^_. l1_Log^_. _.]:=0;

ProductProjector[_MZV^_. l1_Zeta^_. _.]:=0;
ProductProjector[_Li^_. l1_Zeta^_. _.]:=0;

ProductProjector[_Li^_. l1_MZV^_. _.]:=0;


ProductProjector[g_G]:=ProductR[g]/(Length[g]-1);
ProductProjector[g_H]:=GToH[ProductR[g]/(Length[g]-1)];
ProductProjector[g_HPL]:=GToHPL[ProductR[g]/(Length[HPLMtoA[g[[1]]]])];
ProductProjector[g_Li]:=GToLi[ProductR[g]/Total[g[[1]]]];
ProductProjector[g_Log]:=g;
ProductProjector[PolyLog[n_,z_]]:=ProductR[PolyLog[n,z]]/n;
ProductProjector[PolyLog[n_,m_,z_]]:=ProductR[PolyLog[n,m,z]]/(m+n);
ProductProjector[Zeta[n_]]:=ProductR[Zeta[n]]/n;
ProductProjector[MZV[n_]]:=ProductR[MZV[n]]/Total[n];


(* ::Subsection:: *)
(*Cobracket*)


CTW[a_,b_] := -CTW[b,a] /; Not[OrderedQ[{a,b}]];


CTW[a___,sum_Plus,b___]:=CTW[a,#,b]&/@sum;
CTW[a___,n_Integer b_,c___]:=n CTW[a,b,c];
CTW[a___,n_Rational b_.,c___]:=n CTW[a,b,c];
CTW[a___,n_Complex b_.,c___]:=n CTW[a,b,c];
CTW[a___,Except[1,n_Integer],c___]:=n CTW[a,1,c];


CTW[___,Pi^_. * _., ___] := 0;


Cobracket[expr_]:=Block[{cop=Delta[expr]},
   cop = cop - (cop/.CT[a_,b_]:>CT[b,a]);
   cop = cop/.CT[a_,b_]:>CT[Expand[ProductProjector[a]],Expand[ProductProjector[b]]];
   Return[Expand[cop/2 /. CT->CTW]]
   ];


CombineCobracketLines[mat_]:={mat[[1,1]],Total[Last/@mat]};


Cobracket[ij_List,g_] := DeltaComponent[CombineCobracketLines/@(GatherBy[MapAt[Sort,#,1]&/@DecomposeDelta[Cobracket[g]/.CTW->CT],First]),Sort[ij]]//.CT->CTW;


(* ::Section:: *)
(*Single-valued Hopf algebra*)


DeltaSV[sum_Plus] := DeltaSV /@ sum;
DeltaSV[a_*b_] := DeltaSV[a] * DeltaSV[b];
DeltaSV[a_^n_Integer] := DeltaSV[a]^n;


DeltaSV[g_cG] := Delta[ProjSV[g]] /. CT[a_,b_] :> CT[SV[a],SV[b]];
DeltaSV[g_Zeta] := Delta[g];
DeltaSV[n_Integer] := n;
DeltaSV[n_Rational] := n;
DeltaSV[n_Complex] := n;


DeltaSV[a_?(TranscendentalWeight[#]===0&)] := a;


AntipodeSV[sum_Plus] := AntipodeSV /@ sum;
AntipodeSV[a_*b_] := AntipodeSV[a] * AntipodeSV[b];
AntipodeSV[a_*n_Integer] := AntipodeSV[a]^n;


AntipodeSV[Zeta[n_]] /; OddQ[n] := -Zeta[n];


AntipodeSV[g_cG] := SV[Antipode[ProjSV[g]]];


AntipodeSV[a_] := a /; TranscendentalWeight[a]==0;


(* ::Subsection:: *)
(*Exceptions for which this is not defined:*)


DeltaSV::undef = "DeltaSV is undefined for `1`.";
AntipodeSV::undef = "AntipodeSV is undefined for `1`.";


DeltaSV[g_] /; MemberQ[{G,H,HPL,PolyLog,Log,MZV,Li,cC},Head[g]] := (Message[DeltaSV::undef,g];$Failed);
AntipodeSV[g_] /; MemberQ[{G,H,HPL,PolyLog,Log,MZV,Li,cC},Head[g]] := (Message[AntipodeSV::undef,g];$Failed);
AntipodeSV[Pi] := (Message[AntipodeSV::undef,Pi];$Failed);


(* ::Subsection:: *)
(*ProductProjector*)


ProductRSV[sum_Plus]:=ProductRSV/@sum;
ProductRSV[n_Integer a_]:=ProductRSV[a]n;
ProductRSV[n_Rational a_]:=ProductRSV[a]n;
ProductRSV[n_Complex a_]:=ProductRSV[a]n;
ProductRSV[n_Integer]:=n;
ProductRSV[n_Rational]:=n;
ProductRSV[n_Complex]:=n;


ProductRSV[g1_cG^_. g2_cG^_. _.]:=0;
ProductRSV[g1_cG^_ _.]:=0;
ProductRSV[g1_Zeta^_. _Zeta^_. _.]:=0;
ProductRSV[g1_Zeta^_ _.]:=0;
ProductRSV[_Zeta^_. l1_G^_. _.]:=0;


ProductProjectorSV[sum_Plus]:=ProductProjectorSV/@sum;
ProductProjectorSV[n_Integer a_]:=ProductProjectorSV[a]n;
ProductProjectorSV[n_Rational a_]:=ProductProjectorSV[a]n;
ProductProjectorSV[n_Complex a_]:=ProductProjectorSV[a]n;
ProductProjectorSV[n_Integer]:=n;
ProductProjectorSV[n_Rational]:=n;
ProductProjectorSV[n_Complex]:=n;

ProductProjectorSV[n_ a_] /; FreeQ[n, G|cG|cC|H|HPL|Log|PolyLog|Pi|Zeta|MZV]:=ProductProjectorSV[a]n;
ProductProjectorSV[n_] /; FreeQ[n, G|cG|cC|H|HPL|Log|PolyLog|Pi|Zeta|MZV|Li]:=n;


ProductProjectorSV[g1_cG^_. g2_cG^_. _.]:=0;
ProductProjectorSV[g1_cG^_ _.]:=0;
ProductProjectorSV[g1_Zeta^_. _Zeta^_. _.]:=0;
ProductProjectorSV[g1_Zeta^_ _.]:=0;
ProductProjectorSV[_Zeta^_. l1_G^_. _.]:=0;


MakeCleanFunctionSV[expr_,weight_]:=Block[{temp=expr},
   temp=Total[Last/@DeleteCases[DecomposeDelta[DeltaSV[temp]],{{___,0,___},_}]];
   temp=temp//.CT[a_,b_]:>ProductRSV[Expand[b]]a;
   Return[weight expr-temp];
];


ProductRSV[g_cG]:=(Length[g]-1)cC@@g;
ProductRSV[Zeta[n_]]:=MakeCleanFunctionSV[Zeta[n],n];

ProductProjectorSV[g_cG] := cC@@g;
ProductProjectorSV[Zeta[n_]] := ProductRSV[Zeta[n]]/n;


ccCC[as__,x_]:=ShuffleG[SV[ProductR[G[as,x]]/Length[{as}]]];
cCTocG[expr_] :=expr //. cC->ccCC;
cCToG[expr_]:=cGToG[cCTocG[expr]];
cC[inds__,x_] /;MemberQ[{0,I,-I,1,-1},x]&&(SubsetQ[{0,1,-1},Union[{inds}]]||SubsetQ[{0,I,-I},Union[{inds}]])&&PLT$AutoConvertToKnownConstants := Block[{$$x, work},
     work =cCTocG[cC[inds,$$x]];
    work = work //. $$x -> x;
     Return[Expand[work]];
];


cC[as__,x_] := 0 /; (Length[{as}] > 1) && (Union[{as}] === 1);


CobracketSV[expr_]:=Block[{cop=DeltaSV[cCTocG[expr]]},
   cop = cop - (cop/.CT[a_,b_]:>CT[b,a]);
   cop = cop/.CT[a_,b_]:>CT[Expand[ProductProjectorSV[a]],Expand[ProductProjectorSV[b]]];
   Return[Expand[cop/2 /. CT->CTW]]
   ];


CobracketSV[ij_List,g_] := DeltaComponent[CombineCobracketLines/@(GatherBy[MapAt[Sort,#,1]&/@DecomposeDelta[CobracketSV[g]/.CTW->CT],First]),Sort[ij]]//.CT->CTW;


AntipodeSV[g_cC] := -g;


(* ::Subsection:: *)
(*Shorthands*)


DeltaSV[{i_,j_},g_] := DeltaComponent[DecomposeDelta[DeltaSV[g]],{i,j}];

DeltaSV[{is__,j_,k_},g_] /; Total[{is,j,k}] > 8 := DeltaSV[{Total[{is,j}],k},g] /. CT[a_,b_]:> CT[Expand[DeltaSV[{is,j}, a]],b];
DeltaSV[{is__,j_,k_},g_] /; Total[{is,j,k}] <= 8 := Symbol["DeltaSV" <> (StringJoin @@ (ToString/@{is,j,k}))][g];


DeltaSV11 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {1,1}]&;

DeltaSV21 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {2,1}]&;
DeltaSV12 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {1,2}]&;
DeltaSV111 = DeltaSV21[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV11[aa]], bb]&

DeltaSV31 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {3,1}]&;
DeltaSV13 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {1,3}]&;
DeltaSV22 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {2,2}]&;


DeltaSV211 = DeltaSV31[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV21[aa]], bb]&;
DeltaSV121 = DeltaSV31[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV12[aa]], bb]&;
DeltaSV112 = DeltaSV22[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV11[aa]], bb]&;

DeltaSV1111 = DeltaSV31[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV111[aa]], bb]&;


DeltaSV41 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {4,1}]&;
DeltaSV14 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {1,4}]&;
DeltaSV23 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {2,3}]&;
DeltaSV32 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {3,2}]&;

DeltaSV311 = DeltaSV41[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV31[aa]], bb]&;
DeltaSV131 = DeltaSV41[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV13[aa]], bb]&;
DeltaSV113 = DeltaSV23[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV11[aa]], bb]&;

DeltaSV221 = DeltaSV41[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV22[aa]], bb]&;
DeltaSV212 = DeltaSV32[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV21[aa]], bb]&;
DeltaSV122 = DeltaSV32[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV12[aa]], bb]&;

DeltaSV2111 = DeltaSV41[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV211[aa]], bb]&;
DeltaSV1211 = DeltaSV41[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV121[aa]], bb]&;
DeltaSV1121 = DeltaSV41[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV112[aa]], bb]&;
DeltaSV1112 = DeltaSV32[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV111[aa]], bb]&;

DeltaSV11111 = DeltaSV41[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1111[aa]], bb]&;

DeltaSV51 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {5,1}]&;
DeltaSV15 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {1,5}]&;
DeltaSV24 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {2,4}]&;
DeltaSV42 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {4,2}]&;
DeltaSV33 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {3,3}]&;


DeltaSV411 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV41[aa]], bb]&;
DeltaSV141 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV14[aa]], bb]&;
DeltaSV114 = DeltaSV24[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV11[aa]], bb]&;

DeltaSV123 = DeltaSV33[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV12[aa]], bb]&;
DeltaSV132 = DeltaSV42[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV13[aa]], bb]&;
DeltaSV213 = DeltaSV33[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV21[aa]], bb]&;
DeltaSV231 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV23[aa]], bb]&;
DeltaSV312 = DeltaSV42[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV31[aa]], bb]&;
DeltaSV321 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV32[aa]], bb]&;

DeltaSV222 = DeltaSV42[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV22[aa]], bb]&;

DeltaSV3111 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV311[aa]], bb]&;
DeltaSV1311 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV131[aa]], bb]&;
DeltaSV1131 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV113[aa]], bb]&;
DeltaSV1113 = DeltaSV33[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV111[aa]], bb]&;

DeltaSV2211 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV221[aa]], bb]&;
DeltaSV2121 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV212[aa]], bb]&;
DeltaSV2112 = DeltaSV42[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV211[aa]], bb]&;
DeltaSV1221 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV122[aa]], bb]&;
DeltaSV1212 = DeltaSV42[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV121[aa]], bb]&;
DeltaSV1122 = DeltaSV42[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV112[aa]], bb]&;

DeltaSV21111 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV2111[aa]], bb]&;
DeltaSV12111 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1211[aa]], bb]&;
DeltaSV11211 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1121[aa]], bb]&;
DeltaSV11121 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1112[aa]], bb]&;
DeltaSV11112 = DeltaSV42[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1111[aa]], bb]&;

DeltaSV111111 = DeltaSV51[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV11111[aa]], bb]&;

DeltaSV61 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {6,1}]&;
DeltaSV16 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {1,6}]&;
DeltaSV25 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {2,5}]&;
DeltaSV52 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {5,2}]&;
DeltaSV34 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {3,4}]&;
DeltaSV43 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {4,3}]&;

DeltaSV511 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV51[aa]], bb]&;
DeltaSV151 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV15[aa]], bb]&;
DeltaSV115 = DeltaSV25[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV11[aa]], bb]&;

DeltaSV421 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV42[aa]], bb]&;
DeltaSV412 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV41[aa]], bb]&;
DeltaSV241 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV24[aa]], bb]&;
DeltaSV214 = DeltaSV34[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV21[aa]], bb]&;
DeltaSV142 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV14[aa]], bb]&;
DeltaSV124 = DeltaSV34[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV12[aa]], bb]&;

DeltaSV322 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV32[aa]], bb]&;
DeltaSV232 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV23[aa]], bb]&;
DeltaSV223 = DeltaSV43[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV22[aa]], bb]&;

DeltaSV331 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV33[aa]], bb]&;
DeltaSV313 = DeltaSV43[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV31[aa]], bb]&;
DeltaSV133 = DeltaSV43[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV13[aa]], bb]&;

DeltaSV4111 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV411[aa]], bb]&;
DeltaSV1411 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV141[aa]], bb]&;
DeltaSV1141 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV114[aa]], bb]&;
DeltaSV1114 = DeltaSV34[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV111[aa]], bb]&;

DeltaSV3211 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV321[aa]], bb]&;
DeltaSV3121 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV312[aa]], bb]&;
DeltaSV3112 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV311[aa]], bb]&;
DeltaSV2311 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV231[aa]], bb]&;
DeltaSV2131 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV213[aa]], bb]&;
DeltaSV2113 = DeltaSV43[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV211[aa]], bb]&;
DeltaSV1321 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV132[aa]], bb]&;
DeltaSV1312 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV131[aa]], bb]&;
DeltaSV1231 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV123[aa]], bb]&;
DeltaSV1213 = DeltaSV43[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV121[aa]], bb]&;
DeltaSV1132 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV113[aa]], bb]&;
DeltaSV1123 = DeltaSV43[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV112[aa]], bb]&;

DeltaSV2221 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV222[aa]], bb]&;
DeltaSV2212 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV221[aa]], bb]&;
DeltaSV2122 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV212[aa]], bb]&;
DeltaSV1222 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV122[aa]], bb]&;

DeltaSV31111 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV3111[aa]], bb]&;
DeltaSV13111 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1311[aa]], bb]&;
DeltaSV11311 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1131[aa]], bb]&;
DeltaSV11131 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1113[aa]], bb]&;
DeltaSV11113 = DeltaSV43[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1111[aa]], bb]&;

DeltaSV22111 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV2211[aa]], bb]&;
DeltaSV21211 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV2121[aa]], bb]&;
DeltaSV21121 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV2112[aa]], bb]&;
DeltaSV21112 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV2111[aa]], bb]&;
DeltaSV12211 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1221[aa]], bb]&;
DeltaSV12121 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1212[aa]], bb]&;
DeltaSV12112 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1211[aa]], bb]&;
DeltaSV11221 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1122[aa]], bb]&;
DeltaSV11212 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1121[aa]], bb]&;
DeltaSV11122 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1112[aa]], bb]&;

DeltaSV211111 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV21111[aa]], bb]&;
DeltaSV121111 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV12111[aa]], bb]&;
DeltaSV112111 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV11211[aa]], bb]&;
DeltaSV111211 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV11121[aa]], bb]&;
DeltaSV111121 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV11121[aa]], bb]&;
DeltaSV111112 = DeltaSV52[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV11111[aa]], bb]&;

DeltaSV1111111 = DeltaSV61[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV111111[aa]], bb]&;


DeltaSV71 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {7,1}]&;
DeltaSV17 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {1,7}]&;
DeltaSV26 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {2,6}]&;
DeltaSV62 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {6,2}]&;
DeltaSV35 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {3,5}]&;
DeltaSV53 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {5,3}]&;
DeltaSV44 = DeltaComponent[DecomposeDelta[DeltaSV[#]], {4,4}]&;

DeltaSV611 = DeltaSV71[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV61[aa]], bb]&;
DeltaSV5111 = DeltaSV71[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV511[aa]], bb]&;
DeltaSV41111 = DeltaSV71[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV4111[aa]], bb]&;
DeltaSV311111 = DeltaSV71[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV31111[aa]], bb]&;
DeltaSV2111111 = DeltaSV71[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV211111[aa]], bb]&;
DeltaSV11111111 = DeltaSV71[#] /. CT[aa_, bb_] :> CT[Expand[DeltaSV1111111[aa]], bb]&;


