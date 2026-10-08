(* Research: polynomial-weighted affine logarithmic moments, with the
   complete local polynomial retained in the returned lower-dimensional
   integral. Positive affine endpoints and a fixed nonzero slope required. *)
walmMoment[n_Integer?NonNegative,m_Integer?NonNegative,p_Integer?Positive,aa_,bb_]:=Module[
 {aux=Unique["walmA"],zz,base},
 zz=-bb/aux;
 base=(-1)^m Factorial[m]/aux zz^(-n-1)
   (PolyLog[m+1,zz]-Sum[zz^jj/jj^(m+1),{jj,1,n}]);
 ((-1)^(p-1)/Factorial[p-1])D[base,{aux,p-1}]/.aux->aa];

walmReduceCube[cube_,vars_List,ep_]:=Module[
 {expr,factors,rest,polynomial,logPower,den,base,aa,bb,other,answer,coefs,degree,valid},
 If[!MBtoMPL`Private`mbtInexactNumberFreeQ[cube],Return[<|"Reduced"->False,"Reason"->"inexact input"|>]];
 Do[
  expr=TimeConstrained[Factor[Together[If[flip,cube/.xx->1-xx,cube]]],20,$Failed];
  If[expr===$Failed,Continue[]];
  factors=If[Head[expr]===Times,List@@expr,{expr}];
  rest=1;polynomial=1;logPower=0;den=None;valid=True;
  Do[Which[
    FreeQ[fac,xx],rest*=fac,
    fac===Log[xx],logPower++,
    MatchQ[fac,Power[Log[xx],_Integer?NonNegative]],logPower+=fac[[2]],
    MatchQ[fac,Power[_,_Integer?Negative]]&&PolynomialQ[fac[[1]],xx]&&Exponent[fac[[1]],xx]===1&&den===None,den=fac,
    PolynomialQ[fac,xx],polynomial*=fac,
    True,valid=False;Break[]],{fac,factors}];
  If[!valid||den===None,Continue[]];base=Expand[den[[1]]];
  If[TrueQ[(base/.Thread[vars->1/2])<0],rest*=(-1)^den[[2]];base=Expand[-base]];
  aa=Expand[base/.xx->0];bb=Coefficient[base,xx];other=DeleteCases[vars,xx];
  If[!alePositiveQ[aa,other]||!alePositiveQ[Expand[aa+bb],other]||
    !(alePositiveQ[bb,other]||alePositiveQ[-bb,other]),Continue[]];
  degree=Exponent[polynomial,xx];coefs=CoefficientList[polynomial,xx];
  answer=rest Total[Table[coefs[[jj+1]]walmMoment[jj,logPower,-den[[2]],aa,bb],{jj,0,degree}]];
  If[!FreeQ[answer,xx]||abtUnfinishedQ[answer],Continue[]];
  Return[<|"Reduced"->True,"Class"->"WeightedAffineLogMoment","OriginalCube"->cube,"OriginalVariables"->vars,
    "Cube"->answer,"Vars"->other,"Variable"->xx,"Reflected"->flip,"Polynomial"->polynomial,
    "Degree"->degree,"LogPower"->logPower,"DenominatorPower"->-den[[2]],
    "AffineConstant"->aa,"AffineSlope"->bb,"PositiveEndpoints"->True,
    "InputDimension"->Length[vars],"OutputDimension"->Length[other]|>,Module],
  {xx,vars},{flip,{False,True}}];
 <|"Reduced"->False,"Reason"->"no admitted polynomial-weighted affine logarithmic leaf"|>];

Print["[mbeWeightedAffineLogMomentRung] research: exact polynomial-weighted affine log moments eliminate one variable."];
