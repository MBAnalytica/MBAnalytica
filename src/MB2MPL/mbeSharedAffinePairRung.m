(* Prototype: mixed shared-affine beta pairs.
   Each pair has x^n t^(alpha-1)(1-t)^(beta-1)
   [(1-v)x+u v t]^(-P). Integrating x by a finite polynomial expansion
   and t by Euler's formula gives 2(n+1) Gauss/power alternatives.
   For r disjoint pairs, 2+2r variables become at most
   Product[2(n_j+1)] separately convergent one-dimensional integrals.
   Strict endpoint margins certify the split; borderline cancelling groups
   and identically removable k+1-P=0 cases refuse this prototype. *)

sapFail[why_] := Throw[<|"Reduced"->False,"Reason"->why|>,sapTag];
sapParameters[core_List,pairs_List,amplitude_,ep_,yy_:SharedAffinePair`argument] := Catch[Module[
  {aa,bb,cc,dd,hub,uu,kk,strict,positive,delta=1/40,sign=None,q0,q1,
   shifts,worst0,slopeBound,loss,basePref,baseWeight,baseBlocks={},hh,
   choices,terms={},term,pref,weight,blocks,alpha,beta,pp,nn,first,second},
  If[Length[core]=!=5 || pairs==={} ||
    !AllTrue[pairs,ListQ[#]&&Length[#]===4&&IntegerQ[#[[4]]]&&#[[4]]>=0&] ||
    !AllTrue[Join[core,Flatten[Take[#,3]&/@pairs]],sbrAffineQ[#,{ep}]&],
    sapFail["rational-affine core and {alpha,beta,P,n} pairs are required"]];
  If[!FreeQ[amplitude,yy]||!MBtoMPL`Private`mbtInexactNumberFreeQ[amplitude],sapFail["inexact or variable-dependent amplitude"]];
  {aa,bb,cc,dd,hub}=core;
  uu=Expand[aa+dd-hub-Total[pairs[[All,3]]]];kk=Expand[aa+bb-cc];
  loss=Total[pairs[[All,4]]+1];
  shifts=Expand[#[[4]]+1-#[[3]]]&/@pairs;
  worst0=Total[Min[0,#/.ep->0]&/@shifts];
  strict=Expand/@Join[{bb,uu,dd-loss},Flatten[({#[[1]],#[[1]]+#[[4]]+1-#[[3]],#[[1]]+#[[2]]})&/@pairs]];
  If[!AllTrue[strict,TrueQ[(#/.ep->0)>0]&] ||
    !TrueQ[(aa/.ep->0)+worst0>0]||!TrueQ[(cc/.ep->0)+worst0>0],
    sapFail["the finite branch split lacks strict endpoint margins"]];
  If[AnyTrue[pairs,Function[row,AnyTrue[Range[0,row[[4]]],TrueQ[Expand[#+1-row[[3]]]===0]&]]],
    sapFail["an identically vanishing moment denominator needs a parameter-derivative rung"]];
  positive=Join[strict,pairs[[All,2]]];
  Do[q0=ff/.ep->0;q1=Coefficient[ff,ep];
    If[q0>0&&q1=!=0,delta=Min[delta,q0/(2Abs[q1])]],{ff,positive}];
  Do[Do[q0=jj+1-(row[[3]]/.ep->0);q1=-Coefficient[row[[3]],ep];
    If[q0=!=0&&q1=!=0,delta=Min[delta,Abs[q0]/(2Abs[q1])]],
    {jj,0,row[[4]]}],{row,pairs}];
  slopeBound=Total[Abs[Coefficient[#,ep]]&/@shifts];
  Do[q0=(ff/.ep->0)+worst0;q1=Abs[Coefficient[ff,ep]]+slopeBound;
    If[q1>0,delta=Min[delta,q0/(2q1)]],{ff,{aa,cc}}];
  Do[If[AllTrue[positive,TrueQ[(#/.ep->0)>=0&&(#/.ep->ss delta)>0]&],sign=ss;Break[]],{ss,{1,-1}}];
  If[sign===None,sapFail["the beta endpoint powers have no common regulator half-interval"]];
  basePref=amplitude Gamma[uu]Gamma[bb]/Gamma[uu+bb];
  baseWeight=yy^(aa-1)(1-yy)^(dd-1-loss);
  hh=HypergeometricPFQ[{kk,uu},{uu+bb},1-yy];
  If[Head[hh]===HypergeometricPFQ,AppendTo[baseBlocks,hh],baseWeight*=hh];
  choices=Table[
    {alpha,beta,pp,nn}=row;
    Flatten[Table[
      first=<|"Coefficient"->((-1)^(nn-jj)Binomial[nn,jj]/(jj+1-pp))Gamma[alpha+nn-jj]Gamma[beta]/Gamma[alpha+beta+nn-jj],
        "Shift"->nn-jj,"Block"->HypergeometricPFQ[{pp-jj-1,beta},{alpha+beta+nn-jj},yy],"Branch"->{jj,"upper"}|>;
      second=<|"Coefficient"->-((-1)^(nn-jj)Binomial[nn,jj]/(jj+1-pp))Gamma[alpha+nn+1-pp]Gamma[beta]/Gamma[alpha+beta+nn+1-pp],
        "Shift"->nn+1-pp,"Block"->1,"Branch"->{jj,"lower"}|>;
      {first,second},{jj,0,nn}],1],{row,pairs}];
  Do[pref=basePref (Times@@Lookup[selection,"Coefficient"]);
    weight=baseWeight yy^Total[Lookup[selection,"Shift"]];blocks=baseBlocks;
    Do[hh=item["Block"];If[Head[hh]===HypergeometricPFQ,AppendTo[blocks,hh],weight*=hh],{item,selection}];
    term=<|"Reduced"->True,"Parameters"->{core,pairs},"Variable"->yy,"Prefactor"->pref,
      "Weight"->weight,"GaussBlocks"->blocks,"Branches"->Lookup[selection,"Branch"]|>;
    AppendTo[terms,term],{selection,Tuples[choices]}];
  <|"Reduced"->True,"Class"->"SharedAffinePairs","Core"->core,"Pairs"->pairs,
    "U"->uu,"K"->kk,"Terms"->terms,"TermCount"->Length[terms],
    "InputDimension"->2+2Length[pairs],"OutputDimension"->1,
    "EndpointMargins"->{(aa/.ep->0)+worst0,(cc/.ep->0)+worst0,(dd/.ep->0)-loss},
    "EpsilonInterval"->Sort[{0,sign delta}]|>],sapTag];

sapTryHub[cube_,vars_List,ep_,pair_List,reflection_List] := Catch[Module[
  {uu=pair[[1]],vv=pair[[2]],other,ordering,transformed,factors,bases,powers,
   amplitude=1,hubPower=0,legs={},used={},base,power,hit,aa,bb,scale,xa,ta,
   positions,pars,core,red},
  other=DeleteCases[vars,Alternatives@@pair];ordering=Join[pair,other];
  transformed=cube/.MapThread[#1->If[#2,1-#1,#1]&,{pair,reflection}];
  factors=If[Head[transformed]===Times,List@@transformed,{transformed}];
  bases=Flatten[({#,1-#}&)/@ordering];powers=ConstantArray[0,Length[bases]];
  Do[If[FreeQ[fac,Alternatives@@vars],amplitude*=fac;Continue[]];
    {base,power}=If[Head[fac]===Power,List@@fac,{fac,1}];base=Expand[base];
    If[!sbrAffineQ[power,{ep}]||!FreeQ[power,Alternatives@@vars],sapFail["unsupported exponent"]];
    hit=SelectFirst[Range[Length[bases]],TrueQ[Expand[base-bases[[#]]]===0]&,None];
    If[hit=!=None,powers[[hit]]+=power;Continue[]];
    If[TrueQ[Expand[base-(1-vv+uu vv)]===0],hubPower-=power;Continue[]];
    If[!PolynomialQ[base,vars],sapFail["a nonpolynomial factor couples the candidate pairs"]];
    aa=base/.{uu->0,vv->0};bb=base/.{uu->1,vv->1};
    positions=Select[Tuples[other,2],#[[1]]=!=#[[2]]&&
      With[{s=Coefficient[aa,#[[1]]]},sbrRationalQ[s]&&TrueQ[s>0]&&
        TrueQ[Expand[aa-s #[[1]]]===0]&&TrueQ[Expand[bb-s #[[2]]]===0]]&];
    If[Length[positions]=!=1,sapFail["not a pair of independent affine leaves"]];
    {xa,ta}=First[positions];scale=Coefficient[aa,xa];
    If[!TrueQ[Expand[base-scale((1-vv)xa+uu vv ta)]===0]||Intersection[used,{xa,ta}]=!={},
      sapFail["overlapping leaves or a different hub polynomial"]];
    used=Join[used,{xa,ta}];AppendTo[legs,{xa,ta,-power}];amplitude*=scale^power,{fac,factors}];
  If[Sort[used]=!=Sort[other]||legs==={},sapFail["every non-hub variable must belong to exactly one pair"]];
  pars=Table[xa=First@FirstPosition[ordering,leg[[1]]];ta=First@FirstPosition[ordering,leg[[2]]];
    If[powers[[2xa]]=!=0||!IntegerQ[powers[[2xa-1]]]||powers[[2xa-1]]<0,
      sapFail["the first leaf needs a nonnegative integer monomial measure"]];
    {powers[[2ta-1]]+1,powers[[2ta]]+1,leg[[3]],powers[[2xa-1]]},{leg,legs}];
  core=Join[powers[[1;;4]]+1,{hubPower}];red=sapParameters[core,pars,amplitude,ep];
  If[!TrueQ[red["Reduced"]],sapFail[red["Reason"]]];
  Join[red,<|"OriginalCube"->cube,"OriginalVariables"->vars,"Hub"->pair,
    "HubReflections"->reflection,"LeafPairs"->legs|>]],sapTag];

sapReduceCube[cube_,vars_List,ep_] := Module[{red,reasons=<||>},
  If[Length[vars]<4||OddQ[Length[vars]]||!MBtoMPL`Private`mbtInexactNumberFreeQ[cube],
    Return[<|"Reduced"->False,"Reason"->"an exact cube with 2+2r variables is required"|>]];
  Do[red=sapTryHub[cube,vars,ep,pair,reflection];
    If[TrueQ[red["Reduced"]],Return[red,Module]];
    reasons[red["Reason"]]=Lookup[reasons,red["Reason"],0]+1,
    {pair,Select[Tuples[vars,2],#[[1]]=!=#[[2]]&]},{reflection,Tuples[{False,True},2]}];
  <|"Reduced"->False,"Reason"->"no admitted disjoint shared-affine pairs","Refusals"->reasons|>];

Print["[mbeSharedAffinePairRung] prototype: shared affine pairs -> finite, separately convergent one-dimensional Gauss branches."];
