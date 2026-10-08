(* uint_bn_lib.m  (2026-09-27) -- ITERATED Barnes 2+2 closed form for eps-free MB pieces of any fold count.

   The one-fold closer of uint_b22_lib.m generalized: after one Gamma copy per polygamma (psi(L) = d/dlam Gamma(L+lam)/
   Gamma(L) at 0; psi', psi'' by cumulants), the integrand is a pure Gamma product times a rational factor.  A variable v
   in which the legs are a Barnes 2+2 kernel (unit slopes in v, net two legs of each orientation) is integrated by the
   first lemma with the Newton expansion of the polynomial factor and the residues of the poles crossed between the
   straight contour and a separating one (the other variables stay on their straight contours; the crossing set is read
   at their real parts).  Every output term has one variable fewer and is treated the same way; zero folds are closed
   forms in the copy regulators lam_j and the slot regulators delta_k t.  The value is the lam-derivative at lam = 0 of
   the t -> 0 limit (the integral is analytic in every regulator near 0 because no contour meets a pole).

   Slots of v: every group of legs of one orientation with the same non-integer part of the v-free argument (other
   variables and regulators included) reduces to one Gamma times Pochhammer factors; a group with net power p > 0 gives
   p slots (regulated legs keep their argument, lam-free ones get a delta insertion Gamma(x + delta t)/Gamma(x)), net
   power 0 gives a rational factor, negative power refuses.  Rational poles of Q are absorbed by lowering a slot of the
   same lattice (up slot Gamma(v + a) absorbs v = r when r + a is an integer >= 1; down slot Gamma(b - v) when b - r is
   an integer >= 1).

   bnClose[F, ctr]  -> exact value or Failure["BN", <|"Reason" -> ..|>]
   bnGated[F, ctr, sec]  -> <|"Value", "Quad", "Seconds"|> (contour quadrature gate: 1 fold 1e-10, 2 folds 1e-6,
                            3+ folds skipped) or Failure *)

If[DownValues[b22Cumulants]==={},
  b22Cumulants[F_]:=Expand[F/.{PolyGamma[1,a_]:>b22T[2,a]-PolyGamma[0,a]^2,PolyGamma[2,a_]:>b22T[3,a]-3 b22T[2,a]PolyGamma[0,a]+2 PolyGamma[0,a]^3}]];

(* split a monomial into Gamma legs {arg, power}, copies {arg, order}, rest *)
bnSplit[F_,vars_]:=Module[{fs=If[Head[F]===Times,List@@F,{F}],gam={},psi={},rest=1,dep=Function[x,!FreeQ[x,Alternatives@@vars]]},
  Do[Which[
      MatchQ[f,Gamma[a_]/;dep[a]],AppendTo[gam,{f[[1]],1}],
      MatchQ[f,Power[Gamma[a_],n_Integer]/;dep[a]],AppendTo[gam,{f[[1,1]],f[[2]]}],
      MatchQ[f,PolyGamma[0,a_]/;dep[a]],AppendTo[psi,{f[[2]],1}],
      MatchQ[f,Power[PolyGamma[0,a_],n_Integer?Positive]/;dep[a]],psi=Join[psi,ConstantArray[{f[[1,2]],1},f[[2]]]],
      MatchQ[f,b22T[_Integer,a_]/;dep[a]],AppendTo[psi,{f[[2]],f[[1]]}],
      MatchQ[f,Power[b22T[_Integer,a_],n_Integer?Positive]/;dep[a]],psi=Join[psi,ConstantArray[{f[[1,2]],f[[1,1]]},f[[2]]]],
      !FreeQ[f,PolyGamma|Gamma|b22T]&&dep[f],Return[$Failed,Module],
      True,rest*=f],{f,fs}];
  {gam,psi,rest}];

(* numeric constant part and symbolic part of an argument (with v removed) *)
bnParts[w_]:=Module[{e=Expand[w],c},c=If[Head[e]===Plus,Total[Select[List@@e,NumericQ]],If[NumericQ[e],e,0]];{Expand[e-c],c}];
(* group key of a leg in v: {orientation, symbolic part, fractional part of the constant} *)
bnKey[arg_,v_]:=Module[{s=Coefficient[arg,v],sym,c},{sym,c}=bnParts[arg-s v];{s,sym,c-Floor[c]}];

(* reduce a list of legs {arg, power} (all in ONE group) with zero net power to a rational function *)
bnGroupRatio[g_]:=Module[{offs,kmin,base},
  base=g[[1,1]];offs=Expand[#[[1]]-base]&/@g;
  If[!AllTrue[offs,IntegerQ],Return[$Failed,Module]];
  kmin=Min[offs];
  Together[FunctionExpand[Times@@MapThread[Pochhammer[base+kmin,#1-kmin]^#2&,{offs,g[[All,2]]}]]]];

(* one Barnes step in v.  legs: {arg, power}; rest: rational factor; returns a list of {legs', rest'} (v eliminated) or
   a Failure.  regs = the regulator symbols (lam's and t), dsym = fresh delta symbols for free slots *)
bnStep[legs_,rest_,v_,ctr_,regs_,t_]:=Catch[Module[{inV,outV,groups,slotsU={},slotsD={},Q,a,b,newton,terms={},cVal=v/.ctr,
    others=DeleteCases[ctr,v->_],reg0,full,freeSlot,qOf,iter=0},
  reg0=Join[Thread[regs->0],{t->0}];
  inV=Select[legs,!FreeQ[#[[1]],v]&];outV=Select[legs,FreeQ[#[[1]],v]&];
  If[!AllTrue[inV,MemberQ[{1,-1},Coefficient[#[[1]],v]]&&FreeQ[Expand[#[[1]]]-Coefficient[#[[1]],v] v,v]&],Throw[Failure["BN",<|"Reason"->"slope"|>],"bn"]];
  groups=GatherBy[inV,bnKey[#[[1]],v]&];
  (* slots per group *)
  Do[Module[{p=Total[g[[All,2]]],s=Coefficient[g[[1,1]],v],num,k0,regQ},
      If[p<0,Throw[Failure["BN",<|"Reason"->"denominator leg left in "<>ToString[v]|>],"bn"]];
      If[p>0,
        num=Select[g,#[[2]]>0&];
        (* the v-free part of the numerator leg with the largest constant (the group's other legs differ by integers) *)
        k0=Last[SortBy[Expand[#-s v]&/@num[[All,1]],bnParts[#][[2]]&]];
        regQ=!FreeQ[k0,Alternatives@@Append[regs,t]];
        Do[With[{d=If[regQ&&j==1,0,Unique["bnd"]]},
            If[s===1,AppendTo[slotsU,{Expand[k0],d}],AppendTo[slotsD,{Expand[k0],d}]]],{j,p}]]],{g,groups}];
  If[Length[slotsU]=!=2||Length[slotsD]=!=2,Throw[Failure["BN",<|"Reason"->"not 2+2 in "<>ToString[v]<>" "<>ToString[{Length[slotsU],Length[slotsD]}]|>],"bn"]];
  (* Q = rest * (legs in v) / (slot Gammas at their unregulated offsets); groups reduce to rational functions *)
  qOf[su_,sd_]:=Module[{pairs,grs,r=rest},
    pairs=Join[inV,{v+#[[1]],-1}&/@su,{-v+#[[1]],-1}&/@sd];
    grs=GatherBy[pairs,bnKey[#[[1]],v]&];
    Do[With[{gr=bnGroupRatio[g2]},If[gr===$Failed||Total[g2[[All,2]]]=!=0,Throw[Failure["BN",<|"Reason"->"Gamma bookkeeping in "<>ToString[v]|>],"bn"]];r*=gr],{g2,grs}];
    Together[r]];
  Q=qOf[slotsU,slotsD];
  While[!FreeQ[Denominator[Q],v]&&iter<40,iter++;
    Module[{fac=Select[FactorList[Denominator[Q]][[All,1]],!FreeQ[#,v]&],r,done=False},
      If[fac==={}||Exponent[fac[[1]],v]=!=1,Throw[Failure["BN",<|"Reason"->"non-linear rational factor"|>],"bn"]];
      r=Expand[v/.First[Solve[fac[[1]]==0,v]]];
      Do[If[!done,With[{m=Expand[r+slotsU[[i,1]]]},If[IntegerQ[m]&&m>=1,slotsU[[i,1]]=Expand[-r];done=True]]],{i,2}];
      Do[If[!done,With[{m=Expand[slotsD[[i,1]]-r]},If[IntegerQ[m]&&m>=1,slotsD[[i,1]]=Expand[r];done=True]]],{i,2}];
      If[!done,Throw[Failure["BN",<|"Reason"->"rational pole "<>ToString[r,InputForm]<>" not absorbable in "<>ToString[v]|>],"bn"]]];
    Q=qOf[slotsU,slotsD]];
  If[!FreeQ[Denominator[Q],v]||!PolynomialQ[Numerator[Q],v],Throw[Failure["BN",<|"Reason"->"Q not polynomial in "<>ToString[v]|>],"bn"]];
  (* regulated slot arguments: a delta insertion Gamma(x + d t)/Gamma(x) is part of the integrand from here on *)
  a=If[#[[2]]===0,#[[1]],#[[1]]+#[[2]] t]&/@slotsU;b=If[#[[2]]===0,#[[1]],#[[1]]+#[[2]] t]&/@slotsD;
  Module[{P=Together[Q],r=0,coeffs={}},
    While[P=!=0&&r<80,Module[{q0=Together[P/.v->-a[[1]]-r]},AppendTo[coeffs,q0];P=Together[(P-q0)/(v+a[[1]]+r)];r++]];
    If[r>=80,Throw[Failure["BN",<|"Reason"->"Newton expansion"|>],"bn"]];newton=coeffs];
  (* B term: legs outside v plus the lemma Gammas *)
  Do[AppendTo[terms,{Join[outV,{{a[[1]]+r+b[[1]],1},{a[[1]]+r+b[[2]],1},{a[[2]]+b[[1]],1},{a[[2]]+b[[2]],1},{a[[1]]+a[[2]]+b[[1]]+b[[2]]+r,-1}}],newton[[r+1]]}],
    {r,0,Length[newton]-1}];
  (* crossed poles: left family right of the contour, right family left of it; positions at zero regulators and at the
     real parts of the other contours *)
  full=Join[outV,{{v+a[[1]],1},{v+a[[2]],1},{-v+b[[1]],1},{-v+b[[2]],1}}];
  (* pole positions at the real parts of the other contours with EVERY regulator (copies, this and earlier steps) at 0;
     a non-numeric position refuses (a crossing is never dropped silently) *)
  Module[{pos,at0},
    at0[x_]:=Module[{y=(x/.others)/.{s_Symbol/;Context[s]=!="System`":>0}},If[NumericQ[y],Re[N[y,30]],Throw[Failure["BN",<|"Reason"->"non-numeric pole position"|>],"bn"]]];
    Do[Do[pos=at0[-aa-n];
        If[pos>cVal,AppendTo[terms,{Select[({#[[1]]/.v->(-aa-n),#[[2]]}&/@DeleteCases[full,{v+aa,1},1,1]),True&],-(-1)^n/n! (Q/.v->(-aa-n))}]],
        {n,0,Max[0,Ceiling[at0[-aa]-cVal]+1]}],{aa,a}];
    Do[Do[pos=at0[bb+n];
        If[pos<cVal,AppendTo[terms,{Select[({#[[1]]/.v->(bb+n),#[[2]]}&/@DeleteCases[full,{-v+bb,1},1,1]),True&],-(-1)^n/n! (Q/.v->(bb+n))}]],
        {n,0,Max[0,Ceiling[cVal-at0[bb]]+1]}],{bb,b}]];
  (* delta symbols must be registered for the final limit: return them with the terms *)
  {terms,Cases[Join[slotsU,slotsD],{_,d_Symbol}:>d]}],"bn"];

(* closed form of int_ctr rest*Prod Gamma(legs): one Barnes step (own regulator ts), recursion on every output term,
   sum, then ts -> 0 (the step's delta symbols at fixed generic rationals) *)
bnSolve[legs_,rest_,ctr_,lams_]:=Catch[Module[{ts=Unique["bnt"],st=$Failed,vDone=None,parts,val},
  If[ctr==={},Return[rest Times@@(Gamma[#[[1]]]^#[[2]]&/@legs),Module]];
  Do[st=bnStep[legs,rest,vv,ctr,lams,ts];If[!FailureQ[st],vDone=vv;Break[]],
    {vv,If[ListQ[Global`$bnOrder],Join[Select[Global`$bnOrder,MemberQ[Keys[ctr],#]&],Complement[Keys[ctr],Global`$bnOrder]],Keys[ctr]]}];
  If[vDone===None,Throw[st,"bns"]];
  parts=Table[bnSolve[tm[[1]],tm[[2]],DeleteCases[ctr,vDone->_],lams],{tm,st[[1]]}];
  If[AnyTrue[parts,FailureQ],Throw[First[Select[parts,FailureQ]],"bns"]];
  val=Total[parts]/.Thread[st[[2]]->Table[1/(3+2 i)+1/(7+5 i^2),{i,Length[st[[2]]]}]];
  val=Quiet@TimeConstrained[Series[val,{ts,0,0}],300,$TimedOut];
  If[val===$TimedOut,Throw[Failure["BN",<|"Reason"->"regulator series timeout"|>],"bns"]];
  (* the negative powers must vanish: Series leaves them as unsimplified Gamma identities (e.g. terms in Gamma(d),
     Gamma(1+d), Gamma(2+d)); each coefficient is checked to be zero at two random points of the remaining symbols
     (50 digits) and dropped; a non-zero one refuses *)
  If[Head[val]===SeriesData,
    If[val[[4]]<0,Module[{syms,negs},
      negs=Table[SeriesCoefficient[val,-m],{m,1,-val[[4]]/val[[6]]}];
      syms=Union[Cases[negs,s_Symbol/;Context[s]=!="System`",{0,Infinity}]];
      (* 2026-10-01: exact cancellation first (Gamma recurrences through FullSimplify under a time limit); the
         two random 50-digit points remain the fallback, logged *)
      negs=Map[Function[c,If[TrueQ[Quiet@TimeConstrained[PossibleZeroQ[FullSimplify[c]],20,False]],0,c]],negs];
      If[!AllTrue[negs,#===0&],Print["    [bn] step-regulator pole coefficients not cancelled exactly; numeric zero test at two points"]];
      Do[If[!AllTrue[negs,TrueQ[#===0||Abs[N[#/.Thread[syms->RandomInteger[{1,10^6},Length[syms]]/(7 10^7)],50]]<10^-35]&],
          Throw[Failure["BN",<|"Reason"->"pole in a step regulator"|>],"bns"]],{2}]]];
    val=SeriesCoefficient[val,0]];
  If[!FreeQ[val,ts],Throw[Failure["BN",<|"Reason"->"regulator survived its step"|>],"bns"]];
  val],"bns"];

(* close a monomial: copies, then Barnes steps until no variable is left *)
bnMonomial[F_,ctr_,t_]:=Catch[Module[{vars=Keys[ctr],sp,gam,psi,rest,lams={},ords={},legs,work,done={},deltas={},val},
  sp=bnSplit[F,vars];If[sp===$Failed,Throw[Failure["BN",<|"Reason"->"factor outside the class"|>],"bnm"]];
  {gam,psi,rest}=sp;
  If[!FreeQ[Denominator[Together[rest]],Alternatives@@vars]&&!PolynomialQ[Denominator[Together[rest]],vars],Throw[Failure["BN",<|"Reason"->"rest"|>],"bnm"]];
  legs=gam;
  Do[With[{l=Unique["bnlam"]},AppendTo[lams,l];AppendTo[ords,p[[2]]];legs=Join[legs,{{p[[1]]+l,1},{p[[1]],-1}}]],{p,psi}];
  (* recursion: every Barnes step has its OWN slot regulator t_s; its limit t_s -> 0 is taken after all descendants of
     that step have been summed (their own regulators already removed).  A single common regulator would be wrong:
     a term carrying a 1/t prefactor (pinch of the lemma) whose inner integral receives new regulators changes at O(t),
     i.e. at O(1) in the total. *)
  val=bnSolve[legs,rest,ctr,lams];
  If[FailureQ[val],Throw[val,"bnm"]];
  Do[Module[{l=lams[[j]],k=ords[[j]],s,neg},
      s=Quiet@TimeConstrained[Series[val,{l,0,k}],300,$TimedOut];
      If[s===$TimedOut,Throw[Failure["BN",<|"Reason"->"lam series timeout"|>],"bnm"]];
      If[Head[s]===SeriesData&&s[[4]]<0,
        neg=Table[SeriesCoefficient[s,-m],{m,1,-s[[4]]/s[[6]]}];
        neg=Map[Function[c,If[TrueQ[Quiet@TimeConstrained[PossibleZeroQ[FullSimplify[c]],20,False]],0,c]],neg];
        If[!AllTrue[neg,#===0&],Print["    [bn] copy-regulator pole coefficients not cancelled exactly; numeric zero test"]];
        neg=neg/.Thread[lams->Table[1/(997+37 i),{i,Length[lams]}]];
        If[!AllTrue[neg,TrueQ[#===0||Abs[N[#,40]]<10^-30]&],Throw[Failure["BN",<|"Reason"->"pole in a copy regulator"|>],"bnm"]]];
      val=k! If[Head[s]===SeriesData,SeriesCoefficient[s,k],Coefficient[s,l,k]]],{j,Length[lams]}];
  val=Expand[val];
  If[!FreeQ[val,t|_SeriesData]||!FreeQ[val,Alternatives@@Join[lams,vars]],Throw[Failure["BN",<|"Reason"->"regulator survived"|>],"bnm"]];
  val],"bnm"];

bnClose[F00_,ctr0_List]:=Module[{ctr=Rationalize[#,0]&/@ctr0,F0,t=Unique["bnt"],parts},
  If[AnyTrue[Values[ctr],IntegerQ],Return[Failure["BN",<|"Reason"->"contour on an integer"|>],Module]];
  F0=If[FreeQ[F00,PolyGamma[1|2,_]],Expand[F00],b22Cumulants[F00]];
  If[!FreeQ[F0,PolyGamma[k_/;k>=3,_]],Return[Failure["BN",<|"Reason"->"polygamma order above two"|>],Module]];
  parts=bnMonomial[#,ctr,t]&/@If[Head[F0]===Plus,List@@F0,{F0}];
  If[AnyTrue[parts,FailureQ],First[Select[parts,FailureQ]],Total[parts]]];

bnGated[F_,ctr_List,sec_:300]:=Module[{t0=AbsoluteTime[],v,q,vs=Keys[ctr],ts,ig,tol},
  v=TimeConstrained[bnClose[F,ctr],sec,Failure["BN",<|"Reason"->"time limit"|>]];
  If[FailureQ[v],Return[v,Module]];
  If[!FreeQ[v,_Real|Indeterminate|ComplexInfinity|DirectedInfinity|$Failed],Return[Failure["BN",<|"Reason"->"inexact value"|>],Module]];
  ts=Table[Unique["bnq"],{Length[vs]}];ig=F/.Thread[vs->(Rationalize[#,0]&/@Values[ctr])+I ts];
  q=Quiet@TimeConstrained[Switch[Length[vs],
      1,NIntegrate[ig,Evaluate[{ts[[1]],-60,60}],WorkingPrecision->30,PrecisionGoal->14,MaxRecursion->40]/(2 Pi),
      2,NIntegrate[ig,Evaluate[Sequence@@({#,-30,30}&/@ts)],PrecisionGoal->8,MaxRecursion->20,MaxPoints->4*10^6]/(2 Pi)^2,
      _,"skipped"],sec,$TimedOut];
  tol=Switch[Length[vs],1,10^-10,2,10^-6,_,Infinity];
  If[q=!="skipped"&&!TrueQ[NumericQ[q]&&Abs[N[v,40]-q]<tol Max[1,Abs[q]]],
    Return[Failure["BN",<|"Reason"->"gate: closed form "<>ToString[N[v,15]]<>" vs quadrature "<>ToString[N[q,15]]|>],Module]];
  <|"Value"->v,"Quad"->q,"Seconds"->Round[AbsoluteTime[]-t0,0.01]|>];
