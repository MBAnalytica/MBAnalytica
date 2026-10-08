(* Exact regulator series for subtraction rungs. No target identifiers or answer data. *)
BeginPackage["MBParameterSubtraction`"];
PSGammaSeries::usage="PSGammaSeries[f,ep,hi] expands affine Gamma products by the exact log-Gamma/Bell recurrence, retaining Laurent moments.";
PSGaussSeries::usage="PSGaussSeries[h,ep,depth] expands the normalized regulated Gauss Euler class in HPL words, or returns Failure.";
PSExactReducedSeries::usage="PSExactReducedSeries[f,ep,lo,hi,pars] expands exact Gamma/Gauss reductions without coefficient-contour expansion.";
Begin["`Private`"];
ClearAll[ff,refuse,PSGammaSeries,PSGaussSeries,PSExactReducedSeries];
ff[x_]:=If[Head[x]===Times,List@@x,{x}];
refuse[s_,more_:<||>]:=Failure["ParameterSubtraction",Join[<|"Reason"->s|>,more]];

PSGammaSeries[f_,ep_Symbol,hi_Integer]:=Catch[Module[
 {gam={},other={},constant=1,pole=0,exponent=0,rest,rs,rl,nmax,lg,bc,coef,n,b,m,power,rr,a},
 If[Head[f]===Plus,Return[Total[PSGammaSeries[#,ep,hi]&/@List@@f],Module]];
 Do[Which[
  MatchQ[t,Gamma[_]|Power[Gamma[_],_Integer]],
   {a,m}=If[Head[t]===Gamma,{t[[1]],1},{t[[1,1]],t[[2]]}];
   If[!PolynomialQ[a,ep]||Exponent[a,ep]>1,Throw[refuse["Non-affine Gamma argument"],seriesTag]];
   n=a/.ep->0;b=Coefficient[a,ep];
   If[!FreeQ[{n,b},ep]||!MatchQ[n,_Integer|_Rational],Throw[refuse["Non-rational Gamma centre"],seriesTag]];
   If[b===0,constant*=Gamma[n]^m,AppendTo[gam,{n,b,m}]],
  MatchQ[t,Power[E,_]]&&PolynomialQ[t[[2]],ep],exponent+=t[[2]],
  MatchQ[t,Power[ep,_Integer]],pole+=t[[2]],
  MatchQ[t,Power[_,_]]&&FreeQ[t[[1]],ep]&&PolynomialQ[t[[2]],ep]&&Exponent[t[[2]],ep]===1,
   constant*=t[[1]]^(t[[2]]/.ep->0);exponent+=ep Coefficient[t[[2]],ep]Log[t[[1]]],
  True,AppendTo[other,t]],{t,ff[f]}];
 Do[{n,b,m}=g;
  If[IntegerQ[n],
   power=If[n>=1,m,-m];
   Do[If[j===0,constant*=b^power;pole+=power,constant*=j^power],{j,If[n>=1,Range[1,n-1],Range[n,0]]}],
   constant*=Gamma[n]^m],{g,gam}];
 If[!FreeQ[constant,Indeterminate|ComplexInfinity|_DirectedInfinity],Throw[refuse["Singular constant Gamma normalization"],seriesTag]];
 rest=Times@@other;
 rs=TimeConstrained[Quiet@Series[rest,{ep,0,0}],20,$Failed];
 If[rs===$Failed,Throw[refuse["Could not determine Laurent valuation of remaining factors"],seriesTag]];
 rl=Which[Head[rs]===SeriesData,If[rs[[3]]==={},Infinity,rs[[4]]/rs[[6]]],TrueQ[PossibleZeroQ[rs]],Infinity,True,0];
 If[rl===Infinity,rl=0];
 If[!IntegerQ[rl],Throw[refuse["Fractional regulator valuation"],seriesTag]];
 nmax=hi-pole-rl;If[nmax<0,Return[SeriesData[ep,0,{},hi+1,hi+1,1],Module]];
 lg=Table[Coefficient[Expand[exponent],ep,k],{k,0,nmax}];constant*=Exp[First[lg]];lg[[1]]=0;
 Do[{n,b,m}=g;
  If[IntegerQ[n],
   Do[lg[[k+1]]+=m If[k===1,-EulerGamma*b,(-1)^k Zeta[k]b^k/k],{k,1,nmax}];
   power=If[n>=1,m,-m];
   Do[If[j=!=0,Do[lg[[k+1]]+=power(-1)^(k+1)(b/j)^k/k,{k,1,nmax}]],{j,If[n>=1,Range[1,n-1],Range[n,0]]}],
   Do[lg[[k+1]]+=m b^k PolyGamma[k-1,n]/k!,{k,1,nmax}]],{g,gam}];
 lg=Expand/@lg;bc={1};
 Do[AppendTo[bc,Expand[Sum[k lg[[k+1]]bc[[j-k+1]],{k,1,j}]/j]],{j,1,nmax}];
 rs=TimeConstrained[Quiet@Series[rest,{ep,0,hi-pole}],30,$Failed];
 If[rs===$Failed,Throw[refuse["Series of remaining factors refused"],seriesTag]];
 rr=Table[If[Head[rs]===SeriesData,SeriesCoefficient[rs,k],Coefficient[Expand[rs],ep,k]],{k,rl,hi-pole}];
 coef=Table[constant Sum[bc[[j+1]]rr[[k-pole-j-rl+1]],{j,0,k-pole-rl}],{k,pole+rl,hi}];
 SeriesData[ep,0,coef,pole+rl,hi+1,1]
],seriesTag];

(* Euler's regulated Beta integral has one simple endpoint subtraction.
   Its normalized Gauss equation yields this finite word recurrence. *)
PSGaussSeries[h_,ep_Symbol,depth_Integer?NonNegative]:=Module[
 {aa,bb,cc,x,a,b,c,normalizer=1,fs={1,0},push0,push01,strip0,v,out},
 Which[MatchQ[h,_Hypergeometric2F1],{aa,bb,cc,x}=List@@h,
 MatchQ[h,HypergeometricPFQ[{_,_},{_},_]],{aa,bb}=h[[1]];cc=First[h[[2]]];x=h[[3]],
 True,Return[refuse["Not an ordinary Gauss block"],Module]];
 If[!And@@(PolynomialQ[#,ep]&&Exponent[#,ep]<=1&/@{aa,bb,cc})||!FreeQ[x,ep],Return[refuse["Non-affine Gauss data"],Module]];
 If[({aa,bb,cc}/.ep->0)==={1,1,1},normalizer=(1-x)^(cc-aa-bb);{aa,bb}={cc-aa,cc-bb}];
 If[({aa,bb,cc}/.ep->0)=!={0,0,1},Return[refuse["Gauss block is outside the normalized endpoint class"],Module]];
 {a,b,c}=Coefficient[#,ep]&/@{aa,bb,cc};
 If[!AllTrue[{a,b,c},MatchQ[#,_Integer|_Rational]&],Return[refuse["Non-rational Gauss slopes"],Module]];
 push0[q_]:=q/.word[w_List]:>word[Prepend[w,0]];
 strip0[q_]:=q/.word[{0,w___}]:>word[{w}];
 push01[q_]:=If[q===1,word[{0,1}],q/.word[w_List]:>word[Join[{0,1},w]]];
 Do[v=Expand[-c push0[fs[[n]]] + (a+b-c)push01[strip0[fs[[n]]]] + a b push01[fs[[n-1]]]];
  AppendTo[fs,v],{n,2,depth}];
 fs=Take[fs,depth+1];
 out=Sum[fs[[n+1]]ep^n,{n,0,depth}]/.word[w_List]:>HPL`HPL[w,x];
 <|"Expansion"->normalizer out,"NormalizedCoefficients"->fs,"Normalization"->normalizer,
 "Class"->"EndpointSubtractedRegulatedGauss","Slopes"->{a,b,c},"Argument"->x,"Depth"->depth|>
];

PSExactReducedSeries[f_,ep_Symbol,lo_Integer,hi_Integer,pars_List]:=Module[
 {terms,values={},fs,blocks,pref,ps,lead,gs,value},
 terms=If[Head[f]===Plus,List@@f,{f}];
 Do[fs=ff[t];blocks=Select[fs,!FreeQ[#,_Hypergeometric2F1|_HypergeometricPFQ]&];pref=Times@@Complement[fs,blocks];
  ps=PSGammaSeries[pref,ep,hi];If[FailureQ[ps],Return[ps,Module]];
  If[blocks==={},AppendTo[values,ps];Continue[]];
  If[Length[blocks]=!=1||!MatchQ[First[blocks],_Hypergeometric2F1|_HypergeometricPFQ],Return[refuse["Nonlinear or multiple Gauss blocks"],Module]];
  lead=If[Head[ps]===SeriesData,ps[[4]],0];
  gs=PSGaussSeries[First[blocks],ep,Max[0,hi-lead]];If[FailureQ[gs],Return[gs,Module]];
  value=PSGammaSeries[pref gs["Normalization"],ep,hi];
  AppendTo[values,Series[value (gs["Expansion"]/gs["Normalization"]),{ep,0,hi}]],{t,terms}];
 value=Normal[Total[values]];
 Total@Table[Coefficient[Expand[value],ep,k]ep^k,{k,lo,hi}]
];
End[];EndPackage[];
Print["[mbeParameterSubtractionSeries] exact Gamma/Bell series and endpoint-subtracted Gauss word recurrence."];
