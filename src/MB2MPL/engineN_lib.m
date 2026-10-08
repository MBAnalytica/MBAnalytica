(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Syed Mehedi Hasan, Taushif Ahmed, Andreas Rapakoulias, Sumit Banik. *)
(* engineN_lib.m — N-fold generalization of Engine 1 (integral-rep faithful cube) for the SUM-CROSS 2-folds
   (and 1-folds). Requires load_standard_w10 + HyperIntica + hf_machinery + nbp_numeric_pieces loaded.
   Provides engineNSubcubes[p] -> list of {integrand, vars} subcubes to HF-integrate and sum. *)
Clear[gammaMinN,raisePsiN,repFactorN,ratRepN,peelWN,cubeMBN,cleanAbsN,engineNSubcubes];
(* denominator-Gamma cancellation for a given "slope var set": cancel Gamma[a]/Gamma[b], a-b positive integer,
   same slope in EVERY var *)
gammaMinN[e0_,vars_]:=Module[{e=e0,ch=True,fl,dG,nG,a,b,it=0,sameSlopeQ},
  sameSlopeQ[a_,b_]:=AllTrue[vars,Coefficient[a-b,#]===0&]&&IntegerQ[Simplify[a-b]]&&Simplify[a-b]>0;
  If[Head[e]===Plus,Return[Total[gammaMinN[#,vars]&/@(List@@e)]]];
  While[ch&&it<60,ch=False;fl=If[Head[e]===Times,List@@e,{e}];
    dG=Select[Cases[fl,Power[Gamma[bb_],q_/;q<0]:>bb],!FreeQ[#,Alternatives@@vars]&];
    If[dG=!={},b=First[dG];nG=Join[Cases[fl,Gamma[aa_]/;sameSlopeQ[aa,b]:>aa],Cases[fl,Power[Gamma[aa_],pp_/;pp>0]/;sameSlopeQ[aa,b]:>aa]];
      If[nG=!={},a=First[nG];e=e Pochhammer[b,Simplify[a-b]] Gamma[b]/Gamma[a];ch=True]];it++]; e];
ratToGammaN[e_,vars_]:=e//.Power[l_,m_Integer?Negative]/;(!FreeQ[l,Alternatives@@vars]&&Total[Exponent[l,#]&/@vars]==1&&PolynomialQ[l,vars]):>(Gamma[l]/Gamma[l+1])^(-m);
betaGuardLift[ig0_,vars_]:=Module[{ig=ig0,changed=True,it=0},
  While[changed&&it<20,changed=False;it++;
   Do[Module[{gl=Cases[ig,Gamma[a_]:>a,{0,Infinity}],plus,minus,pr},
     plus=Select[gl,Coefficient[#,v]==1&&FreeQ[#,Alternatives@@DeleteCases[vars,v]]&];
     minus=Select[gl,Coefficient[#,v]==-1&&FreeQ[#,Alternatives@@DeleteCases[vars,v]]&];
     pr=SelectFirst[Tuples[{plus,minus}],(((#[[1]]/.v->0)+(#[[2]]/.v->0))<=0)&,Missing[]];
     If[pr=!=Missing[],Module[{ap=pr[[1]],n},n=1-((ap/.v->0)+(pr[[2]]/.v->0));
        ig=ig/.Gamma[ap]:>Gamma[ap+n]/Product[ap+k,{k,0,n-1}]; changed=True]]],{v,vars}]];
  Expand[ig]];
raisePsiN[expr_,vars_,ct_,thr_]:=expr//.PolyGamma[m_,a_]/;(NumericQ[a/.ct]&&Re[a/.ct]<=thr&&!FreeQ[a,Alternatives@@vars]):>(PolyGamma[m,a+1]-(-1)^m m!/a^(m+1));
$eNs=0;
freshSN:=Symbol["Global`seNxP" <> ToString[$ProcessID] <>
  "n" <> ToString[++$eNs]];
repFactorN[m_,a_,s_]:=If[m==0,-EulerGamma+(1-s^(a-1))/(1-s),-s^(a-1) Log[s]^m/(1-s)];
ratRepN[L_,m_,s_,ct_]:=Module[{Lc=L/.ct},If[Re[Lc]>0,s^(L-1)(-Log[s])^(m-1)/(m-1)!,(-1)^m s^(-L-1)(-Log[s])^(m-1)/(m-1)!]];
(* per-variable scale extraction *)
peelWN[T_,vars_]:=Module[{Wv=ConstantArray[1,Length[vars]],rest},
  rest=T/.Power[s_Symbol,e_]/;(StringMatchQ[SymbolName[s],"seNx"~~__]&&!FreeQ[e,Alternatives@@vars]):>
    (Do[Wv[[i]]=Wv[[i]] s^Coefficient[e,vars[[i]]],{i,Length[vars]}];Power[s,Simplify[e/.Thread[vars->0]]]);
  {Wv,rest}];
polyToPochN[Q_,g_]:=Module[{d=Exponent[Q,g],cs,sol},If[d<=0,Return[{Q}]];cs=Array[ccN,d+1,0];
  sol=Solve[Thread[CoefficientList[Expand[Q-Sum[cs[[kk+1]] Pochhammer[g,kk],{kk,0,d}]],g]==0],cs];If[sol==={},$Failed,cs/.First[sol]]];
polysplitGamN[gam_,P_,vars_]:=Module[{gArg,a,sig,g,Q,cs,v},
  v=SelectFirst[vars,!FreeQ[P,#]&,None]; If[v===None||FreeQ[P,v],Return[P gam]];
  gArg=FirstCase[gam,Gamma[arg_]/;(Coefficient[arg,v]=!=0):>arg,Missing[],Infinity];
  If[gArg===Missing[],Return[P gam]]; a=gArg/.v->0; sig=Coefficient[gArg,v,1];
  Q=Expand[P/.v->sig(g-a)]; cs=polyToPochN[Q,g]; If[cs===$Failed,Return[P gam]];
  Sum[cs[[k+1]](gam/Gamma[gArg])Gamma[gArg+k],{k,0,Length[cs]-1}]];
cubeMBN[K0_,vars_,ct_,WWv_]:=Module[{K0g,fac,gam=1,rat=1,parts,eis={},bad=False,scale},
  scale=Product[WWv[[i]]^vars[[i]],{i,Length[vars]}];
  K0g=gammaMinN[Expand[ratToGammaN[K0,vars]],vars];
  fac=If[Head[K0g]===Times,List@@K0g,{K0g}];
  Do[If[FreeQ[f,Gamma],rat*=f,gam*=f],{f,fac}];
  parts=Apart[rat,First[vars]]; parts=If[Head[parts]===Plus,List@@parts,{parts}];
  Do[Module[{km,kts},km=If[PolynomialQ[pp,vars]&&Total[Exponent[pp,#]&/@vars]>=1,polysplitGamN[gam,pp,vars],gam pp];
     kts=If[Head[Expand[km]]===Plus,List@@Expand[km],{km}];
     Do[Module[{eu,euRows},eu=Quiet@TimeConstrained[MBtoMPL`MBtoEuler[kt scale,ct,vars],200,$TimedOut];
        If[eu===$TimedOut||!AssociationQ[eu]||Lookup[eu,"PartAFailure",None]=!=None,
          bad=True,
          euRows=Lookup[eu,"EulerIntegrands",$Failed];
          If[!ListQ[euRows]||euRows==={},bad=True,eis=Join[eis,euRows]]]],{kt,kts}]],{pp,parts}];
  If[bad || eis === {}, $Failed, eis]];
cleanAbsN[ex_,vars_]:=ex//.Abs[arg_]:>Module[{vals=Table[arg/.Table[v->RandomReal[{.05,.95}],{v,vars}],{8}]},
   If[AllTrue[vals,NumericQ[#]&&Re[#]!=0&]&&Equal@@Sign[Re/@vals],Sign[Re[First[vals]]] arg,Abs[arg]]];
engineNSubcubes[p_,thr_:1/5]:=Module[{vars=p["Vars"],ct=p["Contour"],ig,terms,out={},WWv},
  WWv=Table[Unique["WWNsym$"],{Length[vars]}];
  ig=Expand[betaGuardLift[raisePsiN[p["Integrand"],vars,ct,thr],vars]];
  terms=If[Head[ig]===Plus,List@@ig,{ig}];
  Do[Module[{fac,K0=1,psis={},rats={},reps,repExp,cubeset,invalid=False,outBefore=Length[out]},
     fac=If[Head[term]===Times,List@@term,{term}];
     Do[Which[
        MatchQ[f,PolyGamma[_,_]]||MatchQ[f,Power[PolyGamma[_,_],_Integer?Positive]],AppendTo[psis,f],
        !FreeQ[f,PolyGamma],invalid=True,
        MatchQ[f,Power[l_,m_Integer?Negative]/;(FreeQ[l,Gamma]&&PolynomialQ[l,vars]&&Total[Exponent[l,#]&/@vars]==1)],AppendTo[rats,f],
        True,K0*=f],{f,fac}];
     If[invalid,AppendTo[out,{$Failed,{}}];Continue[]];
     psis=Flatten[Replace[psis,{Power[pg_,n_Integer?Positive]:>ConstantArray[pg,n],pg_:>{pg}},1]];
     cubeset=cubeMBN[K0,vars,ct,WWv];
     If[cubeset===$Failed||cubeset==={},AppendTo[out,{$Failed,{}}];Continue[]];
     reps=Times@@Join[repFactorN[#[[1]],#[[2]],freshSN]&/@psis,Function[rf,ratRepN[rf[[1]],-rf[[2]],freshSN,ct]]/@rats];
     repExp=If[Head[Expand[reps]]===Plus,List@@Expand[reps],{Expand[reps]}];
     Do[Module[{integ=0,sv={},vv},
        Do[Module[{Wv,Ar},{Wv,Ar}=peelWN[et,vars];
           sv=Union[sv,Cases[{Ar,Wv},sx_Symbol/;StringMatchQ[SymbolName[sx],"seNx"~~__],Infinity]];
           integ+=Ar (cube[[1]]/.Thread[WWv->Wv])],{et,repExp}];
        vv=Join[cube[[2]],sv]; integ=cleanAbsN[Together[integ],vv];
        AppendTo[out,{integ,vv}]],{cube,cubeset}];
     If[Length[out]===outBefore,AppendTo[out,{$Failed,{}}]]],{term,terms}];
  out];
