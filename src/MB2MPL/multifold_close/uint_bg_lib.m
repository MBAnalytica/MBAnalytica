(* uint_bg_lib.m  (2026-09-27) -- one-fold eps-free MB pieces of the GENERALIZED Barnes class, in closed form.

   After one Gamma copy per polygamma (psi = d/dlam Gamma(L+lam)/Gamma(L); psi', psi'' by cumulants, as in
   uint_b22_lib.m), a piece whose legs are three Gamma(b_i + v) over one Gamma(c + v) and two Gamma(a_j - v), times a
   polynomial Q(v) (or the mirror image, mapped by v -> -v), is integrated by the generalized Barnes lemma
   (subtraction_syed.tex eq. genbarnes; Bailey 4.5):
     int dv/(2 pi i) Gamma(a1-v)Gamma(a2-v)Gamma(b1+v)Gamma(b2+v)Gamma(b3+v)/Gamma(c+v)
       = Gamma(a1+b1)Gamma(a2+b1)Gamma(a1+b2)Gamma(a2+b2)Gamma(a1+b3)Gamma(a2+b3)/(Gamma(a12+b13)Gamma(a12+b23)Gamma(c-b3))
         3F2(a1+b3, a2+b3, Sigma-c; a12+b13, a12+b23; 1)
   on a separating contour (excess c - b3 > 0; b3 chosen to maximize it), Q expanded in rising factorials (a1 - v)_r
   (a1 -> a1 + r keeps the excess), plus the residues of the crossed poles.  Every slot is regulated (copies lam_j,
   copy-free slots delta_k t), all regulators are scaled jointly, lam_j = kappa_j ee, t = tau ee: the Gamma factors are
   expanded by Series, each 3F2(1) by HypExp with symbolic coefficients, and the derivative is the coefficient of
   Prod kappa_j^{d_j} tau^0 in ee^D (D = total derivative order), times Prod d_j!.  The integral is analytic in all
   regulators jointly (no pole meets the contour), so the joint Taylor coefficient is the required derivative.
   Gate: contour quadrature of the original piece (caller).

   bgClose[F, {v -> c}] -> exact value or Failure["BG", <|"Reason" -> ..|>]
   bgGated[F, {v -> c}, sec] -> <|"Value", "Quad", "Seconds"|> or Failure *)

bgMonomial[F_,ctr_]:=Catch[Module[{v=ctr[[1,1]],c0=ctr[[1,2]],sp,gam,psi,rest,lams={},ords={},legs,flip=1,groups,patB=False,
    up,dn,upPos,upNeg,dnPos,slotsU={},slotsD={},cden,Q,qOf,iter=0,t=Unique["bgt"],ee=Unique["bgee"],tau=Unique["bgtau"],
    kap,a,b,b3i,newton,terms={},V,D,val,deltas={}},
  sp=b22Split[F,v];If[sp===$Failed,Throw[Failure["BG",<|"Reason"->"factor outside the class"|>],"bg"]];
  {gam,psi,rest}=sp;
  If[!FreeQ[Denominator[Together[rest]],v]&&!PolynomialQ[Denominator[Together[rest]],v],Throw[Failure["BG",<|"Reason"->"rest"|>],"bg"]];
  legs=gam;
  Do[With[{l=Unique["bglam"]},AppendTo[lams,l];AppendTo[ords,p[[2]]];legs=Join[legs,{{p[[1]]+l,1},{p[[1]],-1}}]],{p,psi}];
  If[!AllTrue[legs,MemberQ[{1,-1},Coefficient[#[[1]],v]]&],Throw[Failure["BG",<|"Reason"->"slope"|>],"bg"]];
  groups=GatherBy[legs,bnKey[#[[1]],v]&];
  (* orientation: the side with the denominator group must be the '+v' side; mirror otherwise *)
  Module[{net=Total[#[[All,2]]]&/@groups,sgn=Coefficient[#[[1,1]],v]&/@groups},
    If[Count[Transpose[{net,sgn}],{-1,-1}]==1&&Count[Transpose[{net,sgn}],{-1,1}]==0,flip=-1];
    If[flip==-1,legs={Expand[#[[1]]/.v->-v],#[[2]]}&/@legs;rest=rest/.v->-v;c0=-c0;groups=GatherBy[legs,bnKey[#[[1]],v]&]]];
  (* pattern: '+v' side groups: positive nets sum 3, exactly one group of net -1; '-v' side: nets sum 2, none negative *)
  Module[{info={Coefficient[#[[1,1]],v],Total[#[[All,2]]],#}&/@groups},
    up=Select[info,#[[1]]==1&];dn=Select[info,#[[1]]==-1&];
    (* pattern A: 3 up over 1 up-denominator; pattern B: plain 2+2 (the denominator is created below from an
       unabsorbable rational pole: Gamma(v - r)/Gamma(v - r + 1) (v - r) = 1) *)
    patB=Total[up[[All,2]]]==2&&AllTrue[up[[All,2]],#>=0&]&&Total[dn[[All,2]]]==2&&AllTrue[dn[[All,2]],#>=0&];
    If[!patB&&(Total[Select[up[[All,2]],#>0&]]=!=3||Count[up[[All,2]],-1]=!=1||Count[up[[All,2]],n_/;n<-1]>0||
       Total[dn[[All,2]]]=!=2||AnyTrue[dn[[All,2]],#<0&]),
      Throw[Failure["BG",<|"Reason"->"not the 3+2 over 1 pattern "<>ToString[{up[[All,2]],dn[[All,2]]}]|>],"bg"]];
    (* slots: a group of net p > 0 gives p slots at its highest numerator offset; regulated groups keep their argument *)
    Do[Module[{s=g[[1]],p=g[[2]],lg=g[[3]],num,k0,regQ},
        If[p<=0,Continue[]];num=Select[lg,#[[2]]>0&];
        k0=Last[SortBy[Expand[#-s v]&/@num[[All,1]],bnParts[#][[2]]&]];
        regQ=!FreeQ[k0,Alternatives@@lams];
        Do[With[{d=If[regQ&&j==1,0,Unique["bgd"]]},If[d=!=0,AppendTo[deltas,d]];
            If[s===1,AppendTo[slotsU,{Expand[k0],d}],AppendTo[slotsD,{Expand[k0],d}]]],{j,p}]],{g,Join[up,dn]}];
    (* the denominator: the net -1 group reduced to one Gamma at its lowest denominator offset (pattern A) *)
    If[patB,cden=None,
      Module[{g=SelectFirst[up,#[[2]]==-1&],dens},
        dens=Select[g[[3]],#[[2]]<0&];
        If[!FreeQ[dens,Alternatives@@lams],Throw[Failure["BG",<|"Reason"->"regulated denominator"|>],"bg"]];
        cden=First[SortBy[Expand[#-v]&/@dens[[All,1]],bnParts[#][[2]]&]]]]];
  (* Q = F_lam / (slot Gammas * 1/Gamma(v + cden)), at unregulated slot offsets *)
  qOf[su_,sd_,cc_]:=Module[{pairs,grs,r=rest},
    pairs=Join[legs,{v+#[[1]],-1}&/@su,{-v+#[[1]],-1}&/@sd,If[cc===None,{},{{v+cc,1}}]];
    grs=GatherBy[pairs,bnKey[#[[1]],v]&];
    Do[With[{gr=bnGroupRatio[g2]},If[gr===$Failed||Total[g2[[All,2]]]=!=0,Throw[Failure["BG",<|"Reason"->"Gamma bookkeeping"|>],"bg"]];r*=gr],{g2,grs}];
    Together[r]];
  Q=qOf[slotsU,slotsD,cden];
  While[!FreeQ[Denominator[Q],v]&&iter<40,iter++;
    Module[{fac=Select[FactorList[Denominator[Q]][[All,1]],!FreeQ[#,v]&],r,done=False},
      If[fac==={}||Exponent[fac[[1]],v]=!=1,Throw[Failure["BG",<|"Reason"->"non-linear rational factor"|>],"bg"]];
      r=Expand[v/.First[Solve[fac[[1]]==0,v]]];
      (* the denominator Gamma(v+c) absorbs v = r when -c - r is an integer >= 0 (raise c to 1 - r) *)
      If[cden=!=None,With[{m=Expand[-cden-r]},If[IntegerQ[m]&&m>=0,cden=Expand[1-r];done=True]]];
      Do[If[!done,With[{m=Expand[r+slotsU[[i,1]]]},If[IntegerQ[m]&&m>=1,slotsU[[i,1]]=Expand[-r];done=True]]],{i,Length[slotsU]}];
      Do[If[!done,With[{m=Expand[slotsD[[i,1]]-r]},If[IntegerQ[m]&&m>=1,slotsD[[i,1]]=Expand[r];done=True]]],{i,Length[slotsD]}];
      (* pattern B: create the third up slot and the denominator from this pole *)
      If[!done&&cden===None&&Length[slotsU]==2,
        With[{d=Unique["bgd"]},AppendTo[deltas,d];AppendTo[slotsU,{Expand[-r],d}]];cden=Expand[1-r];done=True];
      If[!done,Throw[Failure["BG",<|"Reason"->"rational pole "<>ToString[r,InputForm]<>" not absorbable"|>],"bg"]]];
    Q=qOf[slotsU,slotsD,cden]];
  If[!FreeQ[Denominator[Q],v]||!PolynomialQ[Numerator[Q],v],Throw[Failure["BG",<|"Reason"->"Q not polynomial"|>],"bg"]];
  b=If[#[[2]]===0,#[[1]],#[[1]]+#[[2]] t]&/@slotsU;a=If[#[[2]]===0,#[[1]],#[[1]]+#[[2]] t]&/@slotsD;
  If[Length[b]=!=3||Length[a]=!=2,Throw[Failure["BG",<|"Reason"->"slot count"|>],"bg"]];
  (* b3: the up slot maximizing the excess c - b at zero regulators *)
  Module[{ex=Table[(cden-b[[i]])/.Thread[lams->0]/.t->0,{i,3}]},
    If[!AllTrue[ex,NumericQ],Throw[Failure["BG",<|"Reason"->"excess"|>],"bg"]];
    b3i=First[Ordering[ex,-1]];
    (* a non-positive excess: raise the denominator, 1/Gamma(c+v) = (c+v)_m/Gamma(c+m+v) (an identity; the Pochhammer joins
       the polynomial Q), until the excess is 1 *)
    If[ex[[b3i]]<=0,
      If[!IntegerQ[ex[[b3i]]],Throw[Failure["BG",<|"Reason"->"non-integer non-positive excess"|>],"bg"]];
      With[{m=1-ex[[b3i]]},Q=Expand[Q FunctionExpand[Pochhammer[cden+v,m]]];cden=Expand[cden+m]]]];
  b=Join[Delete[b,b3i],{b[[b3i]]}];
  (* Newton expansion of Q in (a1 - v)_r *)
  Module[{P=Together[Q],r=0,coeffs={}},
    While[P=!=0&&r<80,Module[{q0=Together[P/.v->a[[1]]+r]},AppendTo[coeffs,q0];P=Together[(P-q0)/(a[[1]]+r-v)];r++]];
    If[r>=80,Throw[Failure["BG",<|"Reason"->"Newton expansion"|>],"bg"]];newton=coeffs];
  Do[Module[{a1=a[[1]]+r,a2=a[[2]],b1=b[[1]],b2=b[[2]],b3=b[[3]],a12,b13,b23,sig},
      a12=a1+a2;b13=b1+b3;b23=b2+b3;sig=a1+a2+b1+b2+b3;
      AppendTo[terms,{newton[[r+1]] Gamma[a1+b1]Gamma[a2+b1]Gamma[a1+b2]Gamma[a2+b2]Gamma[a1+b3]Gamma[a2+b3]/(Gamma[a12+b13]Gamma[a12+b23]Gamma[cden-b3]),
        {a1+b3,a2+b3,sig-cden},{a12+b13,a12+b23}}]],{r,0,Length[newton]-1}];
  (* crossed poles (positions at zero regulators) *)
  Module[{full=Q Gamma[a[[1]]-v]Gamma[a[[2]]-v]Gamma[b[[1]]+v]Gamma[b[[2]]+v]Gamma[b[[3]]+v]/Gamma[cden+v],at0},
    at0[x_]:=Module[{y=x/.{s_Symbol/;Context[s]=!="System`":>0}},If[NumericQ[y],N[y,30],Throw[Failure["BG",<|"Reason"->"pole position"|>],"bg"]]];
    Do[Do[If[at0[-bb-n]>c0,AppendTo[terms,{-(-1)^n/n! ((full/Gamma[bb+v])/.v->(-bb-n)),{},{}}]],{n,0,Max[0,Ceiling[at0[-bb]-c0]+1]}],{bb,b}];
    Do[Do[If[at0[aa+n]<c0,AppendTo[terms,{-(-1)^n/n! ((full/Gamma[aa-v])/.v->(aa+n)),{},{}}]],{n,0,Max[0,Ceiling[c0-at0[aa]]+1]}],{aa,a}]];
  (* joint scaling of the regulators; expansion; derivative *)
  D=Total[ords];kap=Table[Unique["bgk"],{Length[lams]}];
  Module[{sub=Join[Thread[lams->kap ee],{t->tau ee},Thread[deltas->Table[1/(3+2 i)+1/(7+5 i^2),{i,Length[deltas]}]]],ord=D+4,tot=0},
    Do[Module[{pre=tm[[1]]/.sub,s1,h},
        s1=Quiet@TimeConstrained[Series[pre,{ee,0,ord}],300,$TimedOut];
        If[s1===$TimedOut,Throw[Failure["BG",<|"Reason"->"series timeout"|>],"bg"]];
        If[tm[[2]]=!={},
          h=Quiet@TimeConstrained[HypExp`HypExp[HypergeometricPFQ[Expand[tm[[2]]/.sub],Expand[tm[[3]]/.sub],1],ee,ord],300,$TimedOut];
          If[h===$TimedOut||!FreeQ[h,HypergeometricPFQ|HypExp`HypExp],Throw[Failure["BG",<|"Reason"->"HypExp refused"|>],"bg"]];
          s1=s1 h];
        tot+=Normal[Series[s1,{ee,0,D}]]],{tm,terms}];
    tot=Expand[tot];
    (* negative powers of ee must cancel (checked at random kappa/tau); the required coefficient *)
    Do[With[{cn=Coefficient[tot,ee,-m]},If[cn=!=0&&!TrueQ[Abs[N[cn/.Thread[kap->Table[1/(11+3 i),{i,Length[kap]}]]/.tau->5/7,40]]<10^-30],
        Throw[Failure["BG",<|"Reason"->"pole in the joint regulator"|>],"bg"]]],{m,1,ord+4}];
    (* the coefficient is a rational function of tau whose 1/tau parts cancel only after combination *)
    val=Together[Coefficient[tot,ee,D]];
    If[!FreeQ[Denominator[val],tau]&&(Denominator[val]/.tau->0)===0,Throw[Failure["BG",<|"Reason"->"1/tau survives"|>],"bg"]];
    val=val/.tau->0;
    val=Fold[Coefficient[#1,#2[[1]],#2[[2]]]&,val,Transpose[{kap,ords}]]/.Thread[kap->0];
    val=Expand[val Times@@(ords!)]];
  If[!FreeQ[val,ee|tau|t|v]||!FreeQ[val,Alternatives@@Join[lams,kap]],Throw[Failure["BG",<|"Reason"->"regulator survived"|>],"bg"]];
  val],"bg"];

(* a 2+2 monomial whose rational factor has a pole that no copy-free leg absorbs becomes a 3+2-over-1 monomial by
   1/(v - r) = Gamma(v - r)/Gamma(v - r + 1)  (or 1/(r - v) = Gamma(r - v)/Gamma(r - v + 1) on the other side): an
   identity for every v; the converted factor is chosen among the linear denominator factors of the rational part *)
bgConvertPole[m_,v_]:=Module[{fs=If[Head[m]===Times,List@@m,{m}],lin,f,e,rest},
  lin=Select[fs,MatchQ[#,Power[b_,n_Integer/;n<0]/;PolynomialQ[b,v]&&Exponent[b,v]==1]&];
  If[lin==={},Return[$Failed,Module]];
  f=lin[[1]];e=-f[[2]];rest=m/f*f[[1]]^(e-1);  (* one power converted *)
  With[{b=Expand[f[[1]]],s=Coefficient[f[[1]],v]},
    If[s==1,rest Gamma[b]/Gamma[b+1],If[s==-1,rest Gamma[-b]/Gamma[-b+1] (-1),$Failed]]]];
bgClose[F00_,ctr0_List]:=Module[{ctr=Rationalize[#,0]&/@ctr0,F0,parts},
  If[Length[ctr]=!=1,Return[Failure["BG",<|"Reason"->"one-fold only"|>],Module]];
  If[IntegerQ[ctr[[1,2]]],Return[Failure["BG",<|"Reason"->"contour on an integer"|>],Module]];
  F0=If[FreeQ[F00,PolyGamma[1|2,_]],Expand[F00],b22Cumulants[F00]];
  If[!FreeQ[F0,PolyGamma[k_/;k>=3,_]],Return[Failure["BG",<|"Reason"->"polygamma order above two"|>],Module]];
  parts=Function[m,Module[{r=bgMonomial[m,ctr],m2},
      If[FailureQ[r]&&StringStartsQ[r["Reason"],"not the 3+2 over 1 pattern"|"rational pole"],
        m2=bgConvertPole[Together[m],ctr[[1,1]]];
        If[m2=!=$Failed,r=bgMonomial[m2,ctr]]];
      r]]/@If[Head[F0]===Plus,List@@F0,{F0}];
  If[AnyTrue[parts,FailureQ],First[Select[parts,FailureQ]],Total[parts]]];

bgGated[F_,ctr_List,sec_:300]:=Module[{t0=AbsoluteTime[],v,q,z=ctr[[1,1]],c=ctr[[1,2]],tt},
  v=TimeConstrained[bgClose[F,ctr],sec,Failure["BG",<|"Reason"->"time limit"|>]];
  If[FailureQ[v],Return[v,Module]];
  If[!FreeQ[v,_Real|Indeterminate|ComplexInfinity|DirectedInfinity|$Failed],Return[Failure["BG",<|"Reason"->"inexact value"|>],Module]];
  q=Quiet@TimeConstrained[NIntegrate[(F/.z->Rationalize[c,0]+I tt)/(2 Pi),{tt,-60,60},WorkingPrecision->30,PrecisionGoal->14,MaxRecursion->40],sec,$TimedOut];
  If[!TrueQ[NumericQ[q]&&Abs[N[v,40]-q]<10^-10 Max[1,Abs[q]]],
    Return[Failure["BG",<|"Reason"->"gate: closed form "<>ToString[N[v,15]]<>" vs quadrature "<>ToString[N[q,15]]|>],Module]];
  <|"Value"->v,"Quad"->q,"Seconds"->Round[AbsoluteTime[]-t0,0.01]|>];
