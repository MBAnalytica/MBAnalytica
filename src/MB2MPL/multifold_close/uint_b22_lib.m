(* uint_b22_lib.m  (2026-09-27) -- exact closed-form closer for one-fold eps-free MB pieces whose Gamma kernel,
   after one Gamma copy per polygamma factor, is a Barnes 2+2 kernel times a polynomial.

   Identity used (no expansion, no towers, no HypExp):
     psi(L) = d/dlam [Gamma(L+lam)/Gamma(L)] at lam = 0, one symbol lam_j per polygamma occurrence (psi^2 of one argument
     = two copies), so  F = D_lam F_lam |_{lam=0},  F_lam = F (psi-free part) * Prod_j Gamma(L_j + lam_j)/Gamma(L_j).
   F_lam is written as  Gamma(a1+z) Gamma(a2+z) Gamma(b1-z) Gamma(b2-z) Q(z)  with Q a POLYNOMIAL in z (free slots lowered
   by integer steps to absorb every rational pole; lam-slots are never moved), every slot carrying a regulator (lam_j, or
   delta_k t for a free slot, inserted as Gamma(x + delta_k t)/Gamma(x)) so that all crossed poles are simple.  On the
   fixed straight contour Re z = c (upward):
     int_c = B[Q] - Sum_{crossed} (-1)^n/n! [F_reg/Gamma(L)]_{z = v*}
   with B[Q] = Sum_r q_r Gamma(a1+r+b1)Gamma(a1+r+b2)Gamma(a2+b1)Gamma(a2+b2)/Gamma(a1+a2+b1+b2+r) (Newton expansion
   Q(v) = Sum_r q_r (v+a1)_r, first Barnes lemma), crossed = left-family poles right of c and right-family poles left of c
   (subtraction_syed.tex, sec:symbolicbarnes).  The value is the lam-derivative at lam = 0 of the t -> 0 limit; the
   integral is analytic in every regulator near 0 (c is off every pole), so the limit and the derivatives are exact.
   Gate (never a producer): the caller compares with a contour quadrature of the original piece.

   b22Close[F, {z -> c}]  -> exact value, or Failure["B22", <|"Reason" -> ..|>] *)

(* polygamma derivatives by cumulants of G(lam) = Gamma(L+lam)/Gamma(L), m_k = G^(k)(0) (b22T[k, L] = one copy
   differentiated k times): psi = m1, psi' = m2 - m1^2, psi'' = m3 - 3 m2 m1 + 2 m1^3 *)
b22Cumulants[F_]:=Expand[F/.{PolyGamma[1,a_]:>b22T[2,a]-PolyGamma[0,a]^2,
   PolyGamma[2,a_]:>b22T[3,a]-3 b22T[2,a]PolyGamma[0,a]+2 PolyGamma[0,a]^3}];
(* split a monomial: Gamma legs {arg, power}, copies {arg, derivative order} (one entry per copy), the rest *)
b22Split[F_,z_]:=Module[{fs=If[Head[F]===Times,List@@F,{F}],gam={},psi={},rest=1},
  Do[Which[
      MatchQ[f,Gamma[a_]/;!FreeQ[a,z]],AppendTo[gam,{f[[1]],1}],
      MatchQ[f,Power[Gamma[a_],n_Integer]/;!FreeQ[a,z]],AppendTo[gam,{f[[1,1]],f[[2]]}],
      MatchQ[f,PolyGamma[0,a_]/;!FreeQ[a,z]],AppendTo[psi,{f[[2]],1}],
      MatchQ[f,Power[PolyGamma[0,a_],n_Integer?Positive]/;!FreeQ[a,z]],psi=Join[psi,ConstantArray[{f[[1,2]],1},f[[2]]]],
      MatchQ[f,b22T[_Integer,a_]/;!FreeQ[a,z]],AppendTo[psi,{f[[2]],f[[1]]}],
      MatchQ[f,Power[b22T[_Integer,a_],n_Integer?Positive]/;!FreeQ[a,z]],psi=Join[psi,ConstantArray[{f[[1,2]],f[[1,1]]},f[[2]]]],
      !FreeQ[f,PolyGamma|Gamma|b22T]&&!FreeQ[f,z],Return[$Failed,Module],
      True,rest*=f],{f,fs}];
  {gam,psi,rest}];

(* exact reduction of a product of Gamma powers whose arguments, grouped by orientation and non-integer part, have zero
   net power per group: returns the rational function, or $Failed if some group does not cancel *)
b22GammaRatio[pairs_List,z_]:=Module[{grp,out=1},
  grp=GatherBy[pairs,Function[p,With[{a=Expand[p[[1]]]},{Coefficient[a,z],a-Coefficient[a,z] z-Floor[(a-Coefficient[a,z] z)/.{_Symbol->0}]}]]];
  Catch[Do[Module[{s=Coefficient[Expand[g[[1,1]]],z],ks,base,kmin},
      If[Total[g[[All,2]]]=!=0,Throw[$Failed,"gr"]];
      ks=Expand[#[[1]]]&/@g;
      base=ks[[1]];
      (* integer offsets relative to base *)
      Module[{offs=Expand[#-base]&/@ks},
        If[!AllTrue[offs,IntegerQ],Throw[$Failed,"gr"]];
        kmin=Min[offs];
        out*=Times@@MapThread[Function[{o,p},Pochhammer[base+kmin,o-kmin]^p],{offs,g[[All,2]]}]]],{g,grp}];
    Together[FunctionExpand[out]],"gr"]];

b22Close[F00_,ctr_List]:=Catch[Module[{z=ctr[[1,1]],c=ctr[[1,2]],F0,sp,gam,psi,rest,lams={},ords={},legs,upL,dnL,slotsU,slotsD,
    Q,t=Unique["b22t"],delta=Table[Unique["b22d"],{4}],iter=0,a1,a2,b1,b2,newton,B,cross={},V,val,qOf},
  F0=If[FreeQ[F00,PolyGamma[1|2,_]],F00,b22Cumulants[F00]];
  If[Head[F0]===Plus,Return[Module[{parts=b22Close[#,ctr]&/@List@@F0},If[AnyTrue[parts,FailureQ],First[Select[parts,FailureQ]],Total[parts]]],Module]];
  If[!FreeQ[F0,PolyGamma[k_/;k>=3,_]],Throw[Failure["B22",<|"Reason"->"polygamma order above two"|>],"b22"]];
  If[!NumericQ[c]||IntegerQ[c],Throw[Failure["B22",<|"Reason"->"contour"|>],"b22"]];
  sp=b22Split[F0,z];If[sp===$Failed,Throw[Failure["B22",<|"Reason"->"factor outside the class"|>],"b22"]];
  {gam,psi,rest}=sp;
  If[!FreeQ[Denominator[Together[rest]],z]&&!PolynomialQ[Denominator[Together[rest]],z],Throw[Failure["B22",<|"Reason"->"rest"|>],"b22"]];
  (* legs {argument, power}; each copy {arg, order} adds Gamma(L+lam)^1 Gamma(L)^-1 and is differentiated 'order' times *)
  legs=gam;
  Do[With[{l=Unique["b22lam"]},AppendTo[lams,l];AppendTo[ords,p[[2]]];legs=Join[legs,{{p[[1]]+l,1},{p[[1]],-1}}]],{p,psi}];
  If[!AllTrue[legs,MemberQ[{1,-1},Coefficient[#[[1]],z]]&&FreeQ[Expand[#[[1]]]-Coefficient[#[[1]],z] z,z]&],
    Throw[Failure["B22",<|"Reason"->"non-unit slope"|>],"b22"]];
  upL=Select[legs,Coefficient[#[[1]],z]===1&];dnL=Select[legs,Coefficient[#[[1]],z]===-1&];
  If[Total[upL[[All,2]]]=!=2||Total[dnL[[All,2]]]=!=2,
    Throw[Failure["B22",<|"Reason"->"not a 2+2 kernel after copies "<>ToString[{Total[upL[[All,2]]],Total[dnL[[All,2]]]}]|>],"b22"]];
  Module[{lamU=Select[upL,!FreeQ[#[[1]],Alternatives@@lams]&],lamD=Select[dnL,!FreeQ[#[[1]],Alternatives@@lams]&],freeU,freeD,kU,kD},
    freeU=2-Length[lamU];freeD=2-Length[lamD];
    If[freeU<0||freeD<0,Throw[Failure["B22",<|"Reason"->"more than two copies on one side"|>],"b22"]];
    kU=Max[Append[Cases[upL,{a_,p_}/;p>0&&FreeQ[a,Alternatives@@lams]:>Expand[a-z]],0]];
    kD=Max[Append[Cases[dnL,{a_,p_}/;p>0&&FreeQ[a,Alternatives@@lams]:>Expand[a+z]],0]];
    (* a slot: {offset, regulator}; lam slots keep their own argument *)
    slotsU=Join[{Expand[#[[1]]-z]-(Expand[#[[1]]-z]/.Thread[lams->0]),Expand[#[[1]]-z]/.Thread[lams->0]}&/@lamU,Table[{delta[[k]] t,kU},{k,freeU}]];
    slotsD=Join[{Expand[#[[1]]+z]-(Expand[#[[1]]+z]/.Thread[lams->0]),Expand[#[[1]]+z]/.Thread[lams->0]}&/@lamD,Table[{delta[[2+k]] t,kD},{k,freeD}]]];
  (* slot = {regulator, integer offset}; free slots have regulator delta t; the integrand is F_reg = F_lam * Prod_free
     Gamma(x + delta t)/Gamma(x) at the CURRENT free offsets, and Q = F_reg / Prod slot Gammas *)
  qOf[su_,sd_]:=Module[{pairs},
    pairs=Join[legs,
      Flatten[Table[If[MatchQ[s[[1]],_ t],{{z+s[[2]]+s[[1]],1},{z+s[[2]],-1}},{}],{s,su}],1],
      Flatten[Table[If[MatchQ[s[[1]],_ t],{{-z+s[[2]]+s[[1]],1},{-z+s[[2]],-1}},{}],{s,sd}],1],
      Table[{z+s[[2]]+s[[1]],-1},{s,su}],Table[{-z+s[[2]]+s[[1]],-1},{s,sd}]];
    With[{r=b22GammaRatio[pairs,z]},If[r===$Failed,$Failed,Together[rest r]]]];
  Q=qOf[slotsU,slotsD];
  If[Q===$Failed,Throw[Failure["B22",<|"Reason"->"Gamma bookkeeping"|>],"b22"]];
  While[!FreeQ[Denominator[Q],z]&&iter<40,iter++;
    Module[{roots=Select[z/.Solve[Denominator[Q]==0,z],NumericQ],r,done=False},
      If[roots==={},Throw[Failure["B22",<|"Reason"->"non-numeric rational pole"|>],"b22"]];
      r=First[Sort[roots]];
      (* up free slot at offset k absorbs root r by lowering to -r (needs k >= 1 - r); down free slot to r (needs k >= r + 1) *)
      Do[If[!done&&MatchQ[slotsU[[i,1]],_ t]&&slotsU[[i,2]]>=1-r,slotsU[[i,2]]=-r;done=True],{i,Length[slotsU]}];
      Do[If[!done&&MatchQ[slotsD[[i,1]],_ t]&&slotsD[[i,2]]>=r+1,slotsD[[i,2]]=r;done=True],{i,Length[slotsD]}];
      If[!done,Throw[Failure["B22",<|"Reason"->"rational pole at "<>ToString[r]<>" not absorbable"|>],"b22"]]];
    Q=qOf[slotsU,slotsD];If[Q===$Failed,Throw[Failure["B22",<|"Reason"->"Gamma bookkeeping"|>],"b22"]]];
  If[!FreeQ[Denominator[Q],z]||!PolynomialQ[Numerator[Q],z],Throw[Failure["B22",<|"Reason"->"Q not polynomial"|>],"b22"]];
  {a1,a2}=#[[2]]+#[[1]]&/@slotsU;{b1,b2}=#[[2]]+#[[1]]&/@slotsD;
  (* Newton expansion of Q in rising factorials of (v + a1) *)
  Module[{P=Together[Q],r=0,coeffs={}},
    While[!TrueQ[Simplify[P==0]]&&r<80,
      Module[{q0=Together[P/.z->-a1-r]},AppendTo[coeffs,q0];P=Together[(P-q0)/(z+a1+r)];r++]];
    If[r>=80,Throw[Failure["B22",<|"Reason"->"Newton expansion"|>],"b22"]];newton=coeffs];
  B=Sum[newton[[r+1]] Gamma[a1+r+b1]Gamma[a1+r+b2]Gamma[a2+b1]Gamma[a2+b2]/Gamma[a1+a2+b1+b2+r],{r,0,Length[newton]-1}];
  Module[{full=Gamma[a1+z]Gamma[a2+z]Gamma[b1-z]Gamma[b2-z] Q,reg0=Join[Thread[lams->0],{t->0}]},
    Do[Do[If[((-a-n)/.reg0)>c,AppendTo[cross,-(-1)^n/n! ((full/Gamma[a+z])/.z->(-a-n))]],{n,0,Max[0,Ceiling[(-a/.reg0)-c]+1]}],{a,{a1,a2}}];
    Do[Do[If[((b+n)/.reg0)<c,AppendTo[cross,-(-1)^n/n! ((full/Gamma[b-z])/.z->(b+n))]],{n,0,Max[0,Ceiling[c-(b/.reg0)]+1]}],{b,{b1,b2}}]];
  V=B+Total[cross];
  val=Quiet@TimeConstrained[Series[V/.Thread[delta->{1/3,2/7,3/11,5/13}],{t,0,0}],300,$TimedOut];
  If[val===$TimedOut,Throw[Failure["B22",<|"Reason"->"t series timeout"|>],"b22"]];
  (* negative powers of t are unsimplified Gamma identities: checked zero at two random points (50 digits), dropped *)
  If[Head[val]===SeriesData,
    If[val[[4]]<0,Module[{syms,negs},
      negs=Table[SeriesCoefficient[val,-m],{m,1,-val[[4]]/val[[6]]}];
      syms=Union[Cases[negs,s_Symbol/;Context[s]=!="System`",{0,Infinity}]];
      Do[If[!AllTrue[negs,TrueQ[Abs[N[#/.Thread[syms->RandomInteger[{1,10^6},Length[syms]]/(7 10^7)],50]]<10^-35]&],
          Throw[Failure["B22",<|"Reason"->"pole in the slot regulator"|>],"b22"]],{2}]]];
    val=SeriesCoefficient[val,0]];
  (* the k-th derivative of copy lam at 0: k! times the coefficient of lam^k (negative powers must be absent: checked) *)
  Do[Module[{l=lams[[j]],k=ords[[j]],s,neg},
      s=Quiet@TimeConstrained[Series[val,{l,0,k}],300,$TimedOut];
      If[s===$TimedOut,Throw[Failure["B22",<|"Reason"->"lam series timeout"|>],"b22"]];
      If[Head[s]===SeriesData&&s[[4]]<0,
        neg=Table[SeriesCoefficient[s,-m],{m,1,-s[[4]]/s[[6]]}];
        (* the other copies at generic small values (the coefficients must vanish identically) *)
        neg=neg/.Thread[lams->Table[1/(997+37 i),{i,Length[lams]}]];
        If[!AllTrue[neg,TrueQ[Abs[N[#,40]]<10^-30]&],Throw[Failure["B22",<|"Reason"->"pole in a copy regulator"|>],"b22"]]];
      val=k! If[Head[s]===SeriesData,SeriesCoefficient[s,k],Coefficient[s,l,k]]],{j,Length[lams]}];
  val=Expand[val];
  If[!FreeQ[val,t|z|_SeriesData]||!FreeQ[val,Alternatives@@lams],Throw[Failure["B22",<|"Reason"->"regulator survived"|>],"b22"]];
  val],"b22"];

(* the closed form with its gate: contour quadrature of the ORIGINAL piece (a gate, never a producer; 2+2 kernels decay
   like exp(-2 pi |t|), so the window +-60 is exhaustive); returns <|"Value", "Quad", "Seconds"|> or a Failure *)
b22Gated[F_,ctr_List,sec_:120]:=Module[{t0=AbsoluteTime[],v,q,z=ctr[[1,1]],c=ctr[[1,2]],tt},
  v=TimeConstrained[b22Close[F,ctr],sec,Failure["B22",<|"Reason"->"time limit"|>]];
  If[FailureQ[v],Return[v,Module]];
  If[!FreeQ[v,_Real|Indeterminate|ComplexInfinity|DirectedInfinity|$Failed],Return[Failure["B22",<|"Reason"->"inexact value"|>],Module]];
  q=Quiet@TimeConstrained[NIntegrate[(F/.z->c+I tt)/(2 Pi),{tt,-60,60},WorkingPrecision->30,PrecisionGoal->14,MaxRecursion->40],sec,$TimedOut];
  If[!TrueQ[NumericQ[q]&&Abs[N[v,40]-q]<10^-10 Max[1,Abs[q]]],
    Return[Failure["B22",<|"Reason"->"gate: closed form "<>ToString[N[v,15]]<>" vs quadrature "<>ToString[N[q,15]]|>],Module]];
  <|"Value"->v,"Quad"->q,"Seconds"->Round[AbsoluteTime[]-t0,0.01]|>];
