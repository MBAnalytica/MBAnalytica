(* Positive affine blend kernel ((1-t)x+t y)^(-P).
   Splitting the square into x<y and y<x gives two convergent sectors.
   In each, the radial and t integrals are Euler Gauss moments, leaving
   one variable.  Prototype; scalar dispatcher unchanged. *)
ablFail[why_]:=Throw[<|"Reduced"->False,"Reason"->why|>,ablTag];
ablParameters[pars_List,amplitude_,ep_,ss_:AffineBlend`argument]:=Catch[Module[
 {aa,bb,cc,dd,alpha,beta,pp,uu,strict,positive,delta=1/40,sign,origin,slope,
  terms={},pref,weight,blocks,hh,sector},
 If[Length[pars]=!=7||!AllTrue[pars,sbrAffineQ[#,{ep}]&]||
   !MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[amplitude]||!FreeQ[amplitude,ss],
   ablFail["seven rational-affine parameters and an exact amplitude required"]];
 {aa,bb,cc,dd,alpha,beta,pp}=pars;uu=Expand[aa+cc-pp];
 strict=Expand/@{aa,cc,uu,aa+alpha-pp,cc+beta-pp,bb+dd,alpha+beta};
 If[!AllTrue[strict,TrueQ[(#/.ep->0)>0]&],ablFail["strict sector endpoint margins required"]];
 positive=Join[strict,{bb,dd,alpha,beta}];
 Do[origin=ff/.ep->0;slope=Coefficient[ff,ep];
   If[TrueQ[origin>0]&&slope=!=0,delta=Min[delta,origin/(2Abs[slope])]],{ff,positive}];
 sign=SelectFirst[{1,-1},Function[sg,AllTrue[positive,TrueQ[(#/.ep->0)>=0&&(#/.ep->sg delta)>0]&]],None];
 If[sign===None,ablFail["no common regulator half-interval for beta moments"]];
 Do[pref=amplitude Gamma[uu]Gamma[sector[[4]]]/Gamma[uu+sector[[4]]]
     Gamma[alpha]Gamma[beta]/Gamma[alpha+beta];
   weight=ss^(sector[[1]]-1);blocks={};
   Do[If[Head[hh]===HypergeometricPFQ,AppendTo[blocks,hh],weight*=hh],
     {hh,{HypergeometricPFQ[{1-sector[[2]],uu},{uu+sector[[4]]},ss],
       HypergeometricPFQ[{pp,sector[[6]]},{alpha+beta},1-ss]}}];
   AppendTo[terms,<|"Reduced"->True,"Class"->"AffineBlendSector","Parameters"->pars,
     "Variable"->ss,"Prefactor"->pref,"Weight"->weight,"GaussBlocks"->blocks,
     "InputDimension"->3,"OutputDimension"->1,"EpsilonInterval"->Sort[{0,sign delta}],
     "EndpointMargins"->(strict/.ep->0),"SectorParameters"->sector|>],
   {sector,{{aa,bb,cc,dd,alpha,beta},{cc,dd,aa,bb,beta,alpha}}}];
 <|"Reduced"->True,"Class"->"AffineBlend","Parameters"->pars,"Terms"->terms,
   "TermCount"->2,"InputDimension"->3,"OutputDimension"->1,"U"->uu,
   "EpsilonInterval"->Sort[{0,sign delta}],"EndpointForms"->strict|>],ablTag];

ablTryChart[cube_,vars_List,ep_,roles_List,reflect_List]:=Catch[Module[
 {xx=roles[[1]],yy=roles[[2]],tt=roles[[3]],expr,bases,blend,factors,exponents,
  pp=0,amplitude=1,seen=False,base,power,hit,scale,red,reconstruction},
 expr=cube/.MapThread[#1->If[#2,1-#1,#1]&,{roles,reflect}];
 factors=If[Head[expr]===Times,List@@expr,{expr}];
 bases=Flatten[({#,1-#}&)/@roles];blend=Expand[(1-tt)xx+tt yy];exponents=ConstantArray[0,6];
 Do[If[FreeQ[fac,Alternatives@@vars],amplitude*=fac;Continue[]];
   {base,power}=If[Head[fac]===Power,List@@fac,{fac,1}];base=Expand[base];
   If[!sbrAffineQ[power,{ep}],ablFail["non-affine exponent or logarithmic dressing"]];
   hit=SelectFirst[Range[6],TrueQ[Expand[base-bases[[#]]]===0]&,None];
   If[hit===None&&IntegerQ[power],
     hit=SelectFirst[Range[6],TrueQ[Expand[base+bases[[#]]]===0]&,None];
     If[hit=!=None,amplitude*=(-1)^power]];
   If[hit=!=None,exponents[[hit]]+=power;Continue[]];
   scale=2(base/.Thread[roles->1/2]);
   If[sbrRationalQ[scale]&&scale=!=0&&TrueQ[Expand[base-scale blend]===0]&&
     (scale>0||IntegerQ[power]),pp-=power;amplitude*=scale^power;seen=True;Continue[]];
   ablFail["factor outside the affine blend class"],{fac,factors}];
 If[!seen,ablFail["no affine blend kernel"]];
 reconstruction=amplitude Times@@MapThread[Power,{bases,exponents}]blend^(-pp);
 If[!TrueQ[FullSimplify[expr-reconstruction,
   Assumptions->And@@Join[Thread[vars>0],Thread[vars<1],{Element[ep,Reals]}]]===0],
   ablFail["whole-integrand reconstruction failed"]];
 red=ablParameters[Append[exponents+1,pp],amplitude,ep];
 If[TrueQ[red["Reduced"]],Join[red,<|"OriginalCube"->cube,"OriginalVariables"->vars,
   "Roles"->roles,"Reflections"->reflect,"ExactIdentity"->True|>],red]],ablTag];

ablReduceCube[cube_,vars_List,ep_]:=Module[{red,reasons={}},
 If[Length[vars]=!=3,Return[<|"Reduced"->False,"Reason"->"three variables required"|>]];
 Do[red=ablTryChart[cube,vars,ep,roles,reflect];
   If[TrueQ[red["Reduced"]],Return[red,Module]];AppendTo[reasons,red["Reason"]],
   {roles,Permutations[vars]},{reflect,Tuples[{False,True},3]}];
 <|"Reduced"->False,"Reason"->"no admitted affine blend chart","Refusals"->DeleteDuplicates[reasons]|>];

Print["[mbeAffineBlendRung] prototype: three-variable affine blends become two one-variable Gauss products."];
