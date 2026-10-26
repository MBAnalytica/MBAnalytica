(* uint_gle.m (2 October 2026) -- THE GENERALIZED BARNES LEMMA AS A FOLD-REDUCING REWRITE of an eps-free
   pure-Gamma multi-fold piece that no eps-free Barnes lemma takes (the class of MB8bu residue 21: a three-fold whose legs
   in one variable are pinched, Gamma(1+L) Gamma(-1-L)).  Theory: subtraction_syed.tex, sec:pinched-gle.

   One fold, variable v, upward line Re v = cv:
     K(v) = Gamma(b1+v) Gamma(b2+v) Gamma(b3+v) Gamma(a1-v) Gamma(a2-v) / Gamma(c+v),
     m = a1+a2+b1+b2+b3-c  (the defect; an integer in this class),   pinches a_i + b_j = -p (p >= 0 an integer).
   The lemma  Int K = Sum_n P_n,
     P_n = Gamma(a1+b1)Gamma(a2+b1)Gamma(a1+b2)Gamma(a2+b2) Gamma(a1+b3+n)Gamma(a2+b3+n) (m)_n
           / (Gamma(a1+a2+b1+b3+n) Gamma(a1+a2+b2+b3+n) Gamma(c-b3) n!),
   holds on a separating contour; the given line differs by the crossed poles (right family Gamma(a_j - v): v = a_j + k
   LEFT of the line -> + Res; left family Gamma(b_j + v): v = -b_j - k RIGHT of it -> - Res).  A pinch makes P_n singular;
   a regulator d on the pinched legs removes it, the left side is analytic at d = 0, and the value is the d^0 coefficient.

   (i)  m <= 0 (TERMINATING): the pinched b legs get regulators kappa_j d and the denominator leg their sum, so that the
        defect stays the exact integer m and the series ends at n = -m for every d:
            Int K = T0 = [ Sum_{n <= -m} P_n(d) + crossed residues ]_{d^0}        (every negative power must cancel).
        Any number of pinches; no convergence condition (a finite identity, continued in the parameters).
   (ii) m >= 1 with exactly one pinch (a2, b3), a2 + b3 = -p: regulator on b3 only,
            Int K = T0 + Pfin S,   T0 = [ Sum_{n <= p} P_n(d) + crossed residues ]_{d^0},
            Pfin = [ P_0(d) / Gamma(a2+b3+d) ]_{d=0},
            S = Sum_{n > p} (A)_n Gamma(n-p) (m)_n / ((D)_n (E)_n n!),  A = a1+b3, D = a1+a2+b1+b3, E = a1+a2+b2+b3,
        and the tail S is an Euler integral with a RATIONAL dressing (the remaining folds then invert to small eps-free cubes):
            S = N Int_0^1 Int_0^1 dt du t^(A-1) (1-t)^(E+q-A-1) (1-u)^(D+p-1) u^(-p-1) G(t u),
            G(z) = ((E+theta)_q/(E)_q) [ (1-z)^-m - Sum_{n<=p} (m)_n z^n/n! ],  N = Gamma(E+q) Gamma(D)/(Gamma(A) Gamma(E+q-A) Gamma(D+p)),
        q >= 0 the least integer with Re(E+q-A) > 0 on the contour (Re(D+p) > 0 required; else D and E swap roles);
        the lemma's series needs Re(c - b3) > 0 on the contour.
   (iii) m >= 1, THE SERIES AS A RATIONAL SUM (no pinch, or the one pinch (a2, b3)): when the two b legs other than b3 pair
        with the a legs to positive integers (a2+b1 = kA and a1+b2 = kB, or a2+b2 = kA and a1+b1 = kB; kA + kB - m >= 1),
            P_n = C0 R(n),  C0 = Gamma(a1+b1)Gamma(a2+b1)Gamma(a1+b2)Gamma(a2+b2)/Gamma(c-b3),
            R(n) = (n+1)_(m-1)/(m-1)! / ((A+n)_kA (B+n)_kB),   A = a1+b3, B = a2+b3,
        a rational function of n, and the tail is summed by partial fractions in n,
            Sum_{n > p} c/(n+al)^r = (-1)^r c psi^(r-1)(al+p+1)/(r-1)!   (r = 1: -c psi(al+p+1), the c of r = 1 sum to 0):
        polygammas of the spectators, no Euler integral and no cube (p = -1 without a pinch).

   THE REWRITE OF A PIECE (gleRewritePiece): for every variable v of the piece the legs in v are read (unit slopes; Gamma
   pairs at integer distance cancelled into polynomials); a census 3+2 over 1 (or its mirror, v -> -v; or 2+2 with one
   rational pole that no leg absorbs, the pole written as a Gamma ratio) with rational poles absorbed into legs and the
   polynomial numerator Newton-expanded on one leg gives a list of kernels with spectator weights; the candidates are
   ranked (no tail first, then the smallest tail shift q and pinch p); the best candidate whose fold identity passes its
   numerical gate (contour quadrature in v at a complex point of the spectators against the lemma, the negative regulator
   powers zero) and whose tails close exactly is taken:
       piece = Sum_j (psi-dressed pieces with one fold fewer, from T0) + tail constant.
   The lower-fold pieces go back to the closer chain (piece cache, worker pool, sealed lane, engine); the tails are closed
   here: dressed faithful cube (fcuDress, fcuInvertV2) -> the package hyperlogarithm integrator (cubeHF), gated numerically.

   Everything is exact; the quadratures are gates only. *)
gleVersion="2026-10-04b";
gleP[s___]:=If[TrueQ[$gleVerbose],Print["    [gle] ",s]];
If[!ValueQ[$gleTailSeconds],$gleTailSeconds=900];
(* exact cancellation of Gamma factors whose arguments differ by integers (numerator against denominator) *)
gleGammaCancel[e0_]:=Module[{e=Together[e0],facs,g,rest=1,changed=True,ks,pair,a,b,k},
  facs=If[Head[e]===Times,List@@e,{e}];
  g=<||>;
  Do[Which[
      MatchQ[f,Gamma[_]],g[Expand[f[[1]]]]=Lookup[g,Expand[f[[1]]],0]+1,
      MatchQ[f,Power[Gamma[_],_Integer]],g[Expand[f[[1,1]]]]=Lookup[g,Expand[f[[1,1]]],0]+f[[2]],
      True,rest=rest f],{f,facs}];
  While[changed,changed=False;
    ks=Keys[Select[g,#=!=0&]];
    (* the pair at the smallest integer distance first (the rational factor of lowest degree) *)
    pair=Select[Tuples[{ks,ks}],(#[[1]]=!=#[[2]]&&g[#[[1]]]>0&&g[#[[2]]]<0&&IntegerQ[Expand[#[[1]]-#[[2]]]])&];
    pair=If[pair==={},None,First[SortBy[pair,Abs[Expand[#[[1]]-#[[2]]]]&]]];
    If[pair=!=None,
      {a,b}=pair;k=Expand[a-b];
      (* Gamma(a)/Gamma(b) = (b)_k for k >= 0, 1/(a)_(-k) for k < 0 *)
      rest=rest If[k>=0,Product[b+j,{j,0,k-1}],1/Product[a+j,{j,0,-k-1}]];
      g[a]=g[a]-1;g[b]=g[b]+1;changed=True]];
  rest Times@@KeyValueMap[Gamma[#1]^#2&,Select[g,#=!=0&]]];
(* the exact real part of a pole position on the spectator contour (rational contour values) *)
gleRe[e_,ctrNum_List]:=With[{r=Expand[e/.ctrNum]},If[NumericQ[r],Re[r],$Failed]];
gleSeries0[e_,d_]:=If[DownValues[withPlainSeries]=!={},withPlainSeries[Series[e,{d,0,0}]],Series[e,{d,0,0}]];
glePins[aa_List,bb_List]:=Select[Tuples[{Range[Length[aa]],Range[Length[bb]]}],With[{t=Expand[aa[[#[[1]]]]+bb[[#[[2]]]]]},IntegerQ[t]&&t<=0]&];
(* the Euler data of the tail of a kernel with m >= 1 and the single pinch (a2, b3): <|"p","A","D","E","q","Swapped"|> or a Failure *)
gleTailData[aa_List,bb_List,cc_,m_Integer,ctrNum_List]:=Catch[Module[{a1,a2,b1,b2,b3,p,A,DD,EE,q=0,sw=False,exc},
  {a1,a2}=aa;{b1,b2,b3}=bb;p=-Expand[a2+b3];
  exc=gleRe[cc-b3,ctrNum];
  If[!(exc=!=$Failed&&exc>0),Throw[Failure["GLE",<|"Reason"->"excess Re(c - b3) = "<>ToString[exc,InputForm]<>" is not positive"|>],"glet"]];
  A=Expand[a1+b3];DD=Expand[a1+a2+b1+b3];EE=Expand[a1+a2+b2+b3];
  If[!TrueQ[gleRe[DD+p,ctrNum]>0],{DD,EE}={EE,DD};sw=True];
  If[!TrueQ[gleRe[DD+p,ctrNum]>0],Throw[Failure["GLE",<|"Reason"->"no Euler pairing of the tail: Re(D + p) <= 0 for both lower parameters"|>],"glet"]];
  If[!TrueQ[gleRe[A+p+1,ctrNum]>0],Throw[Failure["GLE",<|"Reason"->"no Euler pairing of the tail: Re(A + p + 1) <= 0"|>],"glet"]];
  While[!TrueQ[gleRe[EE+q-A,ctrNum]>0],q++;If[q>6,Throw[Failure["GLE",<|"Reason"->"tail shift q > 6"|>],"glet"]]];
  <|"p"->p,"A"->A,"D"->DD,"E"->EE,"q"->q,"Swapped"->sw|>],"glet"];
(* class of one kernel without any expansion: <|"m","Tail","p","q","aa","bb"|> (legs reordered: the pinched pair of a tail
   kernel is (a2, b3); a pinched leg of a terminating kernel is b3) or a Failure *)
gleKernelInfo[aa0_List,bb0_List,cc0_,ctrNum_List]:=Catch[Module[{aa=Expand/@aa0,bb=Expand/@bb0,cc=Expand[cc0],m,pins,td,coll},
  (* cc = None: the 2+2 kernel of Barnes' first lemma (no denominator leg, no condition on the legs); booked with defect -99 *)
  If[cc0===None,
    If[Length[aa]=!=2||Length[bb]=!=2,Throw[Failure["GLE",<|"Reason"->"not a 2+2 kernel"|>],"glek"]];
    pins=glePins[aa,bb];
    Throw[<|"m"->-99,"Tail"->False,"First"->True,"p"->If[pins==={},-1,Max[-Expand[aa[[#[[1]]]]+bb[[#[[2]]]]]&/@pins]],"q"->0,"aa"->aa,"bb"->bb,"cc"->None,"Pins"->pins|>,"glek"]];
  If[Length[aa]=!=2||Length[bb]=!=3,Throw[Failure["GLE",<|"Reason"->"not a 3+2 over 1 kernel"|>],"glek"]];
  m=Expand[Total[aa]+Total[bb]-cc];
  If[!IntegerQ[m],Throw[Failure["GLE",<|"Reason"->"defect "<>ToString[m,InputForm]<>" is not an integer"|>],"glek"]];
  pins=glePins[aa,bb];
  If[m<=0,
    Throw[<|"m"->m,"Tail"->False,"p"->If[pins==={},-1,Max[-Expand[aa[[#[[1]]]]+bb[[#[[2]]]]]&/@pins]],"q"->0,"aa"->aa,"bb"->bb,"cc"->cc,"Pins"->pins|>,"glek"]];
  If[Length[pins]>1,Throw[Failure["GLE",<|"Reason"->"defect "<>ToString[m]<>" >= 1 with "<>ToString[Length[pins]]<>" pinched pair(s): the tail form needs at most one"|>],"glek"]];
  (* the rational-series pairing of {b1, b2} with the a legs (0 = none): 1: (a2+b1, a1+b2), 2: (a2+b2, a1+b1) *)
  coll[a_List,b_List]:=Module[{k1=Expand[a[[2]]+b[[1]]],k2=Expand[a[[1]]+b[[2]]],k3=Expand[a[[2]]+b[[2]]],k4=Expand[a[[1]]+b[[1]]]},
    Which[IntegerQ[k1]&&IntegerQ[k2]&&k1>=1&&k2>=1&&k1+k2-m>=1,1,IntegerQ[k3]&&IntegerQ[k4]&&k3>=1&&k4>=1&&k3+k4-m>=1,2,True,0]];
  If[pins==={},
    (* no pinch: the whole series must be a rational sum; b3 = any of the three legs *)
    Do[With[{bj=Append[Delete[bb,j],bb[[j]]]},With[{pr=coll[aa,bj]},
        If[pr>0,Throw[<|"m"->m,"Tail"->False,"Collapse"->pr,"p"->-1,"q"->0,"aa"->aa,"bb"->bj,"cc"->cc,"Pins"->{}|>,"glek"]]]],{j,{3,2,1}}];
    Throw[Failure["GLE",<|"Reason"->"defect "<>ToString[m]<>" >= 1 without a pinch and without a rational series"|>],"glek"]];
  aa=If[pins[[1,1]]==1,Reverse[aa],aa];bb=Append[Delete[bb,pins[[1,2]]],bb[[pins[[1,2]]]]];
  td=gleTailData[aa,bb,cc,m,ctrNum];
  With[{pr=coll[aa,bb]},
    If[FailureQ[td]&&pr==0,Throw[td,"glek"]];
    <|"m"->m,"Tail"->!FailureQ[td],"Collapse"->pr,"p"->-Expand[aa[[2]]+bb[[3]]],"q"->If[FailureQ[td],0,td["q"]],"aa"->aa,"bb"->bb,"cc"->cc,"Pins"->{{2,3}}|>]],"glek"];
(* one kernel: aa = {a1, a2} (legs Gamma(a_i - v)), bb = {b1, b2, b3} (legs Gamma(b_j + v)), cc (denominator Gamma(cc + v)) *)
gleFold[aa0_List,bb0_List,cc0_,v_Symbol,cv_,ctrNum_List]:=Catch[Module[
  {info,aa,bb,cc,m,pins,a1,a2,b1,b2,b3,cd,d=Unique["gled"],kb,Kd,Pn,nmax,cross={},res,expr,ser,negs={},T0,td,A,DD,EE,p,q,Pfin,N0,Fp,poly,G,rat,bad=False,pos,mpos,coll=None},
  info=gleKernelInfo[aa0,bb0,cc0,ctrNum];
  If[FailureQ[info],Throw[info,"gle"]];
  aa=info["aa"];bb=info["bb"];cc=info["cc"];m=info["m"];pins=glePins[aa,bb];
  (* Barnes' first lemma (2+2): Int = Gamma(a1+b1)Gamma(a1+b2)Gamma(a2+b1)Gamma(a2+b2)/Gamma(a1+a2+b1+b2) on a separating
     contour; regulators on the pinched b legs, the same crossed residues, the d^0 coefficient *)
  If[TrueQ[info["First"]],
    kb=Table[If[MemberQ[pins[[All,2]],j],{1,3/5}[[j]],0],{j,2}];
    {a1,a2}=aa;{b1,b2}=bb+kb d;
    Kd=Gamma[b1+v]Gamma[b2+v]Gamma[a1-v]Gamma[a2-v];
    Do[Do[With[{r=gleRe[aj+k,ctrNum]},If[r===$Failed||r==cv,bad=True;Break[]];If[r<cv,AppendTo[cross,{+1,Expand[aj+k]}],Break[]]],{k,0,40}],{aj,{a1,a2}}];
    Do[Do[With[{r=gleRe[(-bj-k)/.d->0,ctrNum]},If[r===$Failed||r==cv,bad=True;Break[]];If[r>cv,AppendTo[cross,{-1,Expand[-bj-k]}],Break[]]],{k,0,40}],{bj,{b1,b2}}];
    If[bad,Throw[Failure["GLE",<|"Reason"->"a pole of the fold kernel lies on the line (or its position is not numeric)"|>],"gle"]];
    cross=DeleteDuplicates[cross];
    res=Total[Table[c[[1]] Residue[Kd,{v,c[[2]]}],{c,cross}]];
    If[!FreeQ[res,ComplexInfinity|Indeterminate|_DirectedInfinity|_Residue],Throw[Failure["GLE",<|"Reason"->"a crossed residue could not be taken"|>],"gle"]];
    expr=Gamma[a1+b1]Gamma[a1+b2]Gamma[a2+b1]Gamma[a2+b2]/Gamma[a1+a2+b1+b2]+res;
    If[FreeQ[expr,d],T0=expr,
      ser=gleSeries0[expr,d];
      If[Head[ser]=!=SeriesData||ser[[4]]/ser[[6]]<-4,Throw[Failure["GLE",<|"Reason"->"no Laurent series in the regulator"|>],"gle"]];
      negs=Table[SeriesCoefficient[ser,-j],{j,1,Max[0,-ser[[4]]/ser[[6]]]}];T0=SeriesCoefficient[ser,0]];
    If[!FreeQ[{T0,negs},d|ComplexInfinity|Indeterminate|_DirectedInfinity],Throw[Failure["GLE",<|"Reason"->"the regulator expansion is not finite"|>],"gle"]];
    Throw[<|"m"->m,"p"->info["p"],"T0"->T0,"Neg"->negs,"Cross"->cross,"HasS"->False,"aa"->aa,"bb"->bb,"cc"->None|>,"gle"]];
  (* regulators: kernel with m >= 1: d on the pinched leg b3 only (none without a pinch); terminating kernel: kappa_j d on
     every pinched b leg, their sum on the denominator *)
  mpos=m>=1;
  kb=If[mpos,If[pins==={},{0,0,0},{0,0,1}],Table[If[MemberQ[pins[[All,2]],j],{1,3/5,7/11}[[j]],0],{j,3}]];
  If[!mpos&&pins=!={}&&kb[[3]]===0,With[{j=pins[[1,2]]},bb=Append[Delete[bb,j],bb[[j]]];kb=Append[Delete[kb,j],kb[[j]]]]];
  {a1,a2}=aa;{b1,b2,b3}=bb+kb d;cd=cc+If[mpos,0,Total[kb]] d;
  Kd=Gamma[b1+v]Gamma[b2+v]Gamma[b3+v]Gamma[a1-v]Gamma[a2-v]/Gamma[cd+v];
  Pn[n_]:=Gamma[a1+b1]Gamma[a2+b1]Gamma[a1+b2]Gamma[a2+b2]Gamma[a1+b3+n]Gamma[a2+b3+n]Pochhammer[Expand[a1+a2+b1+b2+b3-cd],n]/
    (Gamma[a1+a2+b1+b3+n]Gamma[a1+a2+b2+b3+n]Gamma[cd-b3]n!);
  nmax=If[mpos,info["p"],-m];
  (* crossed poles, exact positions on the rational spectator contour at d = 0; a pole on the line refuses; coincident
     positions of unregulated legs are one (multiple) pole *)
  Do[Do[With[{r=gleRe[aj+k,ctrNum]},If[r===$Failed||r==cv,bad=True;Break[]];If[r<cv,AppendTo[cross,{+1,Expand[aj+k]}],Break[]]],{k,0,40}],{aj,{a1,a2}}];
  Do[Do[With[{r=gleRe[(-bj-k)/.d->0,ctrNum]},If[r===$Failed||r==cv,bad=True;Break[]];If[r>cv,AppendTo[cross,{-1,Expand[-bj-k]}],Break[]]],{k,0,40}],{bj,{b1,b2,b3}}];
  If[bad,Throw[Failure["GLE",<|"Reason"->"a pole of the fold kernel lies on the line (or its position is not numeric)"|>],"gle"]];
  cross=DeleteDuplicates[cross];
  res=Total[Table[c[[1]] Residue[Kd,{v,c[[2]]}],{c,cross}]];
  If[!FreeQ[res,ComplexInfinity|Indeterminate|_DirectedInfinity|_Residue],Throw[Failure["GLE",<|"Reason"->"a crossed residue could not be taken"|>],"gle"]];
  expr=Sum[Pn[n],{n,0,nmax}]+res;
  If[FreeQ[expr,d],T0=expr,
    ser=gleSeries0[expr,d];
    If[Head[ser]=!=SeriesData,Throw[Failure["GLE",<|"Reason"->"no Laurent series in the regulator"|>],"gle"]];
    If[ser[[4]]/ser[[6]]<-4,Throw[Failure["GLE",<|"Reason"->"a pole of order above four in the regulator"|>],"gle"]];
    negs=Table[SeriesCoefficient[ser,-j],{j,1,Max[0,-ser[[4]]/ser[[6]]]}];T0=SeriesCoefficient[ser,0]];
  If[!FreeQ[{T0,negs},d|ComplexInfinity|Indeterminate|_DirectedInfinity],Throw[Failure["GLE",<|"Reason"->"the regulator expansion is not finite"|>],"gle"]];
  If[!mpos,Throw[<|"m"->m,"p"->info["p"],"T0"->T0,"Neg"->negs,"Cross"->cross,"HasS"->False,"aa"->aa,"bb"->bb,"cc"->cc|>,"gle"]];
  (* the tail of a kernel with m >= 1 *)
  {a1,a2}=aa;{b1,b2,b3}=bb;p=info["p"];
  (* (iii) the tail as a rational sum: partial fractions in n, polygammas of the spectators *)
  If[Lookup[info,"Collapse",0]>0,
    Module[{n=Unique["glen"],Ac=Expand[a1+b3],Bc=Expand[a2+b3],kA,kB,C0,R,roots,S=0,c1=0},
      {kA,kB}=If[info["Collapse"]==1,{Expand[a2+b1],Expand[a1+b2]},{Expand[a2+b2],Expand[a1+b1]}];
      C0=Gamma[Expand[a1+b1]]Gamma[Expand[a2+b1]]Gamma[Expand[a1+b2]]Gamma[Expand[a2+b2]]/Gamma[Expand[cc-b3]];
      R=Product[n+j,{j,1,m-1}]/((m-1)! Product[Ac+n+i,{i,0,kA-1}] Product[Bc+n+i,{i,0,kB-1}]);
      roots=Tally[Join[Table[Expand[Ac+i],{i,0,kA-1}],Table[Expand[Bc+i],{i,0,kB-1}]]];
      Do[Module[{al=rt[[1]],mu=rt[[2]],g,cr},
          g=Together[(n+al)^mu R];
          Do[cr=Together[(D[g,{n,mu-r}]/(mu-r)!)/.n->-al];
            If[r==1,c1+=cr;S+=-cr PolyGamma[0,Expand[al+p+1]],S+=cr (-1)^r PolyGamma[r-1,Expand[al+p+1]]/(r-1)!],{r,1,mu}]],{rt,roots}];
      If[Together[c1]===0&&FreeQ[{C0,S},ComplexInfinity|Indeterminate|_DirectedInfinity|n],coll=C0 S]]];
  td=If[TrueQ[info["Tail"]],gleTailData[aa,bb,cc,m,ctrNum],None];
  If[!AssociationQ[td],
    If[coll===None,Throw[Failure["GLE",<|"Reason"->"the tail has neither an Euler form nor a rational series"|>],"gle"]];
    Throw[<|"m"->m,"p"->p,"T0"->T0+coll,"Neg"->negs,"Cross"->cross,"HasS"->False,"Collapsed"->True,"aa"->aa,"bb"->bb,"cc"->cc|>,"gle"]];
  A=td["A"];DD=td["D"];EE=td["E"];p=td["p"];q=td["q"];
  Pfin=gleGammaCancel[Gamma[a1+b1]Gamma[a2+b1]Gamma[a1+b2]Gamma[a2+b2]Gamma[a1+b3]/(Gamma[a1+a2+b1+b3]Gamma[a1+a2+b2+b3]Gamma[cc-b3])];
  N0=gleGammaCancel[Gamma[EE+q]Gamma[DD]/(Gamma[A]Gamma[EE+q-A]Gamma[DD+p])];
  Fp=(1-Global`gleZ)^(-m)-Sum[Pochhammer[m,n]Global`gleZ^n/n!,{n,0,p}];
  poly=Expand[Pochhammer[EE+Global`gleN,q]/Pochhammer[EE,q]];
  G=Sum[Coefficient[poly,Global`gleN,j] Nest[Together[Global`gleZ D[#,Global`gleZ]]&,Fp,j],{j,0,Exponent[poly,Global`gleN]}];
  rat=Together[(G/.Global`gleZ->Global`gt1 Global`gu1)/Global`gu1^(p+1)];
  <|"m"->m,"p"->p,"T0"->T0,"Neg"->negs,"Pfin"->Pfin,"A"->A,"D"->DD,"E"->EE,"q"->q,"N"->N0,"Swapped"->td["Swapped"],
    "Powers"->Global`gt1^(A-1)(1-Global`gt1)^(EE+q-A-1)(1-Global`gu1)^(DD+p-1),"EulerRational"->rat,"Cross"->cross,"HasS"->True,
    "Collapse"->coll,"aa"->aa,"bb"->bb,"cc"->cc|>],"gle"];
(* S numerically at a spectator point: S = cf 4F3(A+p+1, m+p+1, 1, 1; D+p+1, E+p+1, p+2; 1) *)
gleSnum[r_Association,pt_List]:=Module[{A=r["A"]/.pt,DD=r["D"]/.pt,EE=r["E"]/.pt,m=r["m"],p=r["p"],cf},
  cf=Pochhammer[A,p+1]Pochhammer[m,p+1]/(Pochhammer[DD,p+1]Pochhammer[EE,p+1](p+1)!);
  N[cf HypergeometricPFQ[{A+p+1,m+p+1,1,1},{DD+p+1,EE+p+1,p+2},1],25]];
(* the fold identity at a complex spectator point: contour integral in v of the whole integrand Fv (the other variables at
   pt) against spec Sum_k w_k (T0_k + Pfin_k S_k); rs = {{w_k, gleFold result}, ..}; the negative regulator powers must vanish *)
gleFoldGate[Fv_,v_Symbol,cv_,spec_,rs_List,pt_List]:=Module[{lhs,rhs,neg,qa},
  lhs=Quiet@NIntegrate[Evaluate[(Fv/.pt)/.v->cv+I qa],{qa,-Infinity,Infinity},WorkingPrecision->30,PrecisionGoal->13,MaxRecursion->40]/(2Pi);
  rhs=Quiet[N[spec/.pt,30] Total[Table[N[w[[1]]/.pt,30] (N[(w[[2]]["T0"]/.pt),30]+If[TrueQ[w[[2]]["HasS"]],N[w[[2]]["Pfin"]/.pt,30] gleSnum[w[[2]],pt],0]),{w,rs}]]];
  neg=Max[Join[{0},Flatten[Table[Abs[Quiet@N[(N[w[[1]]/.pt,30] #)/.pt,30]]&/@w[[2]]["Neg"],{w,rs}]]]];
  <|"A"->lhs,"BC"->rhs,"Neg"->neg,"Pass"->TrueQ[NumericQ[lhs]&&NumericQ[rhs]&&NumericQ[neg]&&Abs[lhs-rhs]<10^-9 (1+Abs[lhs])&&neg<10^-15 (1+Abs[rhs/N[spec/.pt,30]])]|>];

(* ---------------- the legs of F in one variable ---------------- *)
(* <|"Up" (b: Gamma(b+v)), "Down" (a: Gamma(a-v)), "DenUp", "DenDown", "Spec" (free of v), "R" (rational in v)|> or a Failure *)
gleLegs[F_,v_Symbol]:=Catch[Module[{g=gleGammaCancel[F],fs,up={},dn={},dup={},ddn={},spec=1,R=1,a,pw,sl,t},
  fs=If[Head[g]===Times,List@@g,{g}];
  Do[Which[
      FreeQ[f,v],spec=spec f,
      MatchQ[f,Gamma[_]|Power[Gamma[_],_Integer]],
        {a,pw}=If[Head[f]===Gamma,{f[[1]],1},{f[[1,1]],f[[2]]}];a=Expand[a];sl=Coefficient[a,v];
        If[!MemberQ[{1,-1},sl]||!FreeQ[Expand[a-sl v],v],Throw[Failure["GLE",<|"Reason"->"a leg of "<>ToString[v]<>" has no unit slope"|>],"glel"]];
        Which[sl===1&&pw>0,up=Join[up,ConstantArray[Expand[a-v],pw]],sl===-1&&pw>0,dn=Join[dn,ConstantArray[Expand[a+v],pw]],
          sl===1,dup=Join[dup,ConstantArray[Expand[a-v],-pw]],True,ddn=Join[ddn,ConstantArray[Expand[a+v],-pw]]],
      True,R=R f],{f,fs}];
  t=Together[R];
  If[!FreeQ[t,Gamma|PolyGamma]||!PolynomialQ[Numerator[t],v]||!PolynomialQ[Denominator[t],v],
    Throw[Failure["GLE",<|"Reason"->"the dependence on "<>ToString[v]<>" is not Gamma legs times a rational function"|>],"glel"]];
  <|"Up"->up,"Down"->dn,"DenUp"->dup,"DenDown"->ddn,"Spec"->spec,"R"->t|>],"glel"];
(* Newton expansion of a polynomial Nw(w) on a leg: up leg b: Sum_r q_r (w+b)_r; down leg a: Sum_r q_r (a-w)_r *)
gleNewton[Nw_,w_,leg_,upQ_]:=Module[{P=Together[Nw],r=0,cs={},q0},
  While[P=!=0&&r<40,
    q0=Together[P/.w->If[upQ,-leg-r,leg+r]];AppendTo[cs,q0];
    P=Together[(P-q0)/If[upQ,w+leg+r,leg+r-w]];r++];
  If[P=!=0,$Failed,cs]];
(* frames of one variable: the kernel in the fold variable gleV with the rational poles absorbed; a frame is
   <|"aa","bb","cc","Nw" (polynomial in gleV),"Pref" (spectator factor),"cw","Note"|> *)
gleFrames[L_Association,v_Symbol,cv_]:=Module[{w=Global`gleV,out={},mk},
  mk[bb0_,aa0_,cden_,oden_,Rw_,cw_,note_]:=Catch[Module[{bb=bb0,aa=aa0,cc,num=Numerator[Rw],den=Denominator[Rw],fl,pref=1,poles={},conv=None,done,r,k},
    If[oden=!={}||Length[aa]=!=2,Throw[{},"glef"]];
    fl=FactorList[den];
    Do[If[FreeQ[f[[1]],w],pref=pref/f[[1]]^f[[2]],
        If[Exponent[f[[1]],w]=!=1,Throw[{},"glef"]];
        With[{al=Coefficient[f[[1]],w,1],be=Coefficient[f[[1]],w,0]},pref=pref/al^f[[2]];poles=Join[poles,ConstantArray[Together[-be/al],f[[2]]]]]],{f,fl}];
    Which[
      Length[bb]==3&&Length[cden]==1,cc=cden[[1]],
      Length[bb]==2&&cden==={},cc=None,
      True,Throw[{},"glef"]];
    (* absorb the poles: denominator leg (c = -r), an up leg b with b + r = k >= 1, a down leg a with a - r = k >= 1; with no
       denominator leg ONE pole that no leg absorbs becomes the third up leg Gamma(w - r)/Gamma(w - r + 1) *)
    Do[done=False;r=poles[[i]];
      If[cc=!=None&&!done&&Expand[cc+r]===0,cc=Expand[cc+1];done=True];
      If[!done,Do[k=Expand[bb[[j]]+r];If[!done&&IntegerQ[k]&&k>=1,bb[[j]]=Expand[-r];num=num Product[w-r+jj,{jj,1,k-1}];done=True],{j,Length[bb]}]];
      If[!done,Do[k=Expand[aa[[j]]-r];If[!done&&IntegerQ[k]&&k>=1,aa[[j]]=Expand[r];num=-num Product[r-w+jj,{jj,1,k-1}];done=True],{j,2}]];
      If[!done&&cc===None&&Length[bb]==2,bb=Append[bb,Expand[-r]];cc=Expand[1-r];done=True];
      If[!done,Throw[{},"glef"]],{i,Length[poles]}];
    (* three b legs with their denominator leg, or the 2+2 kernel of the first lemma (every pole absorbed, cc = None) *)
    If[!((Length[bb]==3&&cc=!=None)||(Length[bb]==2&&cc===None)),Throw[{},"glef"]];
    {<|"aa"->aa,"bb"->bb,"cc"->cc,"Nw"->Expand[num],"Pref"->pref,"cw"->cw,"Note"->note<>If[cc===None," (first lemma)",""]|>}],"glef"];
  out=Join[out,mk[L["Up"],L["Down"],L["DenUp"],L["DenDown"],L["R"]/.v->w,cv,"fold in "<>ToString[v]]];
  (* the mirror frame; a 2+2 kernel is its own mirror *)
  If[!AnyTrue[out,#["cc"]===None&],
    out=Join[out,mk[L["Down"],L["Up"],L["DenDown"],L["DenUp"],Together[L["R"]/.v->-w],-cv,"fold in -"<>ToString[v]]]];
  out];
(* all candidates of F: (variable, frame, Newton leg) -> kernels with spectator weights, ranked *)
gleCandidates[F_,ctr_List,extra_List:{}]:=Module[{w=Global`gleV,out={}},
  Do[Module[{L=gleLegs[F,v],cv=v/.ctr,ctrNum=Join[DeleteCases[ctr,v->_],extra],frames},
      If[AssociationQ[L],
        frames=gleFrames[L,v,cv];
        Do[Module[{deg=Exponent[fr["Nw"],w],legs},
            legs=If[deg==0,{{1,True}},Join[Table[{j,True},{j,Length[fr["bb"]]}],Table[{j,False},{j,2}]]];
            Do[Module[{cs,kern,infos},
                cs=If[deg==0,{fr["Nw"]},gleNewton[fr["Nw"],w,If[lg[[2]],fr["bb"][[lg[[1]]]],fr["aa"][[lg[[1]]]]],lg[[2]]]];
                If[cs=!=$Failed,
                  kern=DeleteCases[Table[{cs[[r+1]],If[lg[[2]],fr["aa"],ReplacePart[fr["aa"],lg[[1]]->Expand[fr["aa"][[lg[[1]]]]+r]]],
                      If[lg[[2]],ReplacePart[fr["bb"],lg[[1]]->Expand[fr["bb"][[lg[[1]]]]+r]],fr["bb"]],fr["cc"]},{r,0,Length[cs]-1}],{0,__}];
                  infos=gleKernelInfo[#[[2]],#[[3]],#[[4]],ctrNum]&/@kern;
                  If[kern=!={}&&AllTrue[infos,AssociationQ],
                    AppendTo[out,<|"Var"->v,"cw"->fr["cw"],"Note"->fr["Note"]<>If[deg>0,", Newton on "<>If[lg[[2]],"up","down"]<>" leg "<>ToString[lg[[1]]],""],
                      "Spec"->L["Spec"] fr["Pref"],"Kernels"->kern,"Infos"->infos,"CtrNum"->ctrNum,
                      "Score"->{Count[infos,_?(#["Tail"]&)],Total[#["q"]&/@infos],Total[If[#["Tail"],#["p"],0]&/@infos],Length[kern],Max[#["m"]&/@infos]}|>]]]],
              {lg,legs}]],{fr,frames}]]],{v,Keys[ctr]}];
  SortBy[out,#["Score"]&]];

(* ---------------- the d^0 part as pieces with one fold fewer ---------------- *)
glePiecesOf[expr_]:=Module[{e=Expand[expr],terms,split,groups},
  terms=If[Head[e]===Plus,List@@e,{e}];
  split[t_]:=Module[{g=gleGammaCancel[t],fs,core,rat},
    fs=If[Head[g]===Times,List@@g,{g}];
    core=Times@@Select[fs,!FreeQ[#,Gamma|PolyGamma]&&!FreeQ[#,s_Symbol/;Context[s]=!="System`"]&];
    rat=Times@@Select[fs,!(!FreeQ[#,Gamma|PolyGamma]&&!FreeQ[#,s_Symbol/;Context[s]=!="System`"])&];
    {core,rat}];
  groups=GatherBy[split/@terms,First];
  Select[Table[Together[Total[g[[All,2]]]] g[[1,1]],{g,groups}],#=!=0&]];

(* a ONE-fold piece with a rational factor 1/(k z + c)^r of non-unit slope (|k| >= 2; from Gamma ratios such as
   Gamma(1-2s)/Gamma(2-2s)): no closer of the one-fold layer takes that factor next to unit-slope polygammas (the pole sits
   on no leg lattice), while polygammas of the same argument are in its classes.  Exact rewrite, x = k z + c or its
   negative with a positive real part on the contour:
       1/x^r = ((-1)^(r-1)/(r-1)!) [psi^(r-1)(x + 1) - psi^(r-1)(x)]       (r = 1: psi(x+1) - psi(x)).
   The rational weight is split by partial fractions in z; polynomial parts and unit-slope poles stay as they are. *)
gleRationalToPsi[F_,ctr_List]:=Module[{z,c0,fs,core,rat,ap,terms,chg=False,tot},
  If[Length[ctr]=!=1,Return[{F},Module]];
  {z,c0}={ctr[[1,1]],ctr[[1,2]]};
  fs=If[Head[F]===Times,List@@F,{F}];
  core=Times@@Select[fs,!FreeQ[#,Gamma|PolyGamma]&];rat=Together[Times@@Select[fs,FreeQ[#,Gamma|PolyGamma]&]];
  If[!AnyTrue[FactorList[Denominator[rat]],(!FreeQ[#[[1]],z]&&Exponent[#[[1]],z]==1&&Abs[Coefficient[#[[1]],z]]=!=1)&],Return[{F},Module]];
  ap=Apart[rat,z];terms=If[Head[ap]===Plus,List@@ap,{ap}];
  tot=Total[Table[Module[{fl=Select[FactorList[Denominator[Together[t]]],!FreeQ[#[[1]],z]&],q,r,al,x,re},
      If[Length[fl]=!=1,t,
        {q,r}=fl[[1]];
        If[Exponent[q,z]=!=1||Abs[Coefficient[q,z]]===1||r>3,t,
          al=Together[t q^r];re=If[FreeQ[al,z],Quiet@Re[N[q/.z->c0]],0];
          Which[
            !FreeQ[al,z]||!NumericQ[re]||re==0,t,
            re>0,chg=True;al (-1)^(r-1)/(r-1)! (PolyGamma[r-1,Expand[q+1]]-PolyGamma[r-1,Expand[q]]),
            True,chg=True;-al/(r-1)! (PolyGamma[r-1,Expand[1-q]]-PolyGamma[r-1,Expand[-q]])]]]],{t,terms}]];
  If[!chg,{F},glePiecesOf[core tot]]];

(* ---------------- the tail: a dressed faithful cube ---------------- *)
(* linear factors next to Gamma legs, exact: numerator q with a leg Gamma(a), a = +-q + k (k an integer): a sum of two Gamma
   monomials (one for k = 0); denominator 1/q with Gamma(a), a = q + 1 or a = 1 - q: Gamma(a - 1) or -Gamma(a - 1); with a
   denominator leg 1/Gamma(a): 1/(q Gamma(a)) = +-1/Gamma(a + 1) for q = +-a, q/Gamma(a) = +-1/Gamma(a - 1) for q = +-(a - 1).
   What stays (other rationals, higher powers) is left to the dressing rules of the cube rung. *)
gleAbsorbLinear[M_,zs_List]:=Module[{e=Expand[M],mons,one,all,tot,linQ},
  linQ[q_]:=PolynomialQ[q,zs]&&!FreeQ[q,Alternatives@@zs]&&Max[Exponent[q,zs]]==1;
  one[mon_]:=Module[{fs=If[Head[mon]===Times,List@@mon,{mon}],hits={},q,a,k,ex},
    Do[Which[
        linQ[fs[[i]]]&&MatchQ[fs[[j]],Gamma[_]],
          q=fs[[i]];a=fs[[j,1]];
          k=Expand[a-q];If[IntegerQ[k],AppendTo[hits,{Abs[k],i,j,Gamma[Expand[a+1]]-k Gamma[a]}]];
          k=Expand[a+q];If[IntegerQ[k],AppendTo[hits,{Abs[k],i,j,k Gamma[a]-Gamma[Expand[a+1]]}]],
        linQ[fs[[i]]]&&MatchQ[fs[[j]],Power[Gamma[_],-1]],
          q=fs[[i]];a=fs[[j,1,1]];
          If[Expand[a-1-q]===0,AppendTo[hits,{0,i,j,1/Gamma[Expand[a-1]]}]];
          If[Expand[a-1+q]===0,AppendTo[hits,{0,i,j,-1/Gamma[Expand[a-1]]}]],
        MatchQ[fs[[i]],Power[_,-1]]&&linQ[fs[[i,1]]]&&MatchQ[fs[[j]],Gamma[_]],
          q=fs[[i,1]];a=fs[[j,1]];
          If[Expand[a-q]===1,AppendTo[hits,{0,i,j,Gamma[Expand[a-1]]}]];
          If[Expand[a+q]===1,AppendTo[hits,{0,i,j,-Gamma[Expand[a-1]]}]],
        MatchQ[fs[[i]],Power[_,-1]]&&linQ[fs[[i,1]]]&&MatchQ[fs[[j]],Power[Gamma[_],-1]],
          q=fs[[i,1]];a=fs[[j,1,1]];
          If[Expand[a-q]===0,AppendTo[hits,{0,i,j,1/Gamma[Expand[a+1]]}]];
          If[Expand[a+q]===0,AppendTo[hits,{0,i,j,-1/Gamma[Expand[a+1]]}]]],{i,Length[fs]},{j,Length[fs]}];
    If[hits==={},Return[{mon},Module]];
    hits=First[SortBy[hits,First]];
    ex=Expand[(Times@@Delete[fs,{{hits[[2]]},{hits[[3]]}}]) hits[[4]]];
    Flatten[one/@If[Head[ex]===Plus,List@@ex,{ex}]]];
  mons=If[Head[e]===Plus,List@@e,{e}];
  all=Flatten[one/@mons];
  tot=Expand[Total[all]];
  Which[tot===0,{},Head[tot]===Plus,List@@tot,True,{tot}]];
gleToStd[e_]:=Module[{g},
  g=Quiet@PolyLogTools`ShuffleRegulate[Expand[Global`gvExact[e]]];
  g=g/.HoldPattern[PolyLogTools`G[ls__,1]]/;SubsetQ[{0,1,-1},{ls}]&&First[{ls}]=!=1:>(-1)^Count[{ls},1] HPL`HPL[{ls},1];
  g=g/.{HoldPattern[PolyLogTools`G[zz__,x_]]/;NumericQ[x]&&x=!=1&&AllTrue[{zz},#===0&]:>Log[x]^Length[{zz}]/Length[{zz}]!,
        HoldPattern[PolyLogTools`G[a_,x_]]/;NumericQ[x]&&NumericQ[a]&&a=!=0&&x=!=1:>Log[1-x/a]};
  g=g/.gg:HoldPattern[PolyLogTools`G[__,x_]]/;NumericQ[x]&&x=!=1:>PolyLogTools`GToLi[gg];
  Global`mbeCanonicalConstants[Expand[g]]];
gleStdQ[e_]:=FreeQ[e,_PolyLogTools`G|_HPL`HPL|_Real|$Failed]&&FreeQ[e,h_[__]/;MemberQ[{"Mpl","mzv","ZeroInfPeriod"},SymbolName[h]]]&&NumericQ[Quiet@N[e,20]];
(* ---- 2 October 2026 (version j): two exact moves that make a tail kernel a pure unit-slope Gamma kernel ----
   The tail of a fold multiplies the remaining Mellin variable by weight x P_fin x N, and N brings Gamma functions of the
   pinch parameters: for the last open piece of MB8bu residue 21 (a two-fold with psi(-1+u) on the leg Gamma(-1+u)) the
   tail kernel is  Gamma(-1+u) Gamma(-u) Gamma(u) Gamma(2+u) psi(-1+u)/Gamma(2u).  The faithful cube refuses a slope-two
   denominator without a slope-two numerator, and takes pure Gamma kernels only.
   (a) BETA UNDO (one remaining variable).  Two numerator legs Gamma(s z + a), Gamma(s z + b) with a + b = c + n, n >= 0 an
       integer, positive real parts on the contour, and the denominator Gamma(2 s z + c):
           Gamma(s z + a) Gamma(s z + b)/Gamma(2 s z + c) = (2 s z + c)_n  Int_0^1 v^(s z + a - 1) (1 - v)^(s z + b - 1) dv
       (the triple of the pairing lemma: no slope condition).  The Euler variable v joins the dressing; its scale v(1-v)
       meets the kernel collapse as a letter that factorizes linearly ((1-v) t + v)(v t + 1 - v) in the cases met.
   (b) GAMMA COPY.  One factor psi(L) with Gamma(L) a numerator leg:  psi(L) Gamma(L) = d/dlam Gamma(L + lam) at 0.  The
       cube is built for the pure kernel with lam as the regulator symbol of the inversion (decisions read at a value of lam
       inside the pole-free strip of the leg), and the tail is the lam^1 coefficient of prefactor x cube (logarithmic
       insertions; Lemma "Gamma copy" of the theory note); a pole in lam is refused. *)
(* The two moves are OFF in the release ($gleTailExtensions = False): with them the two-fold above is rewritten, exactly
   (its tail closes; the rewrite equals the iterated contour quadrature to 1e-16), into seven one-fold pieces, and one of
   those, -2 Gamma(2-u) Gamma(-1+u) Gamma(-2u) Gamma(-u) Gamma(2u) Gamma(1+u) psi(-1+u), carries a slope-two numerator PAIR
   that neither the one-fold chain nor the sealed lane closes (tests e40-e42 of 2 October); the piece would then cost its
   budgets and fall back to the lane on the parent two-fold, which closes it today (923 s).  The closure of that pair
   (pi/sin(2 pi u) = (pi cot + pi tan)/2: the cotangent part closes by the first lemma, the tangent part is the unit
   kernel Gamma(v) Gamma(1-v) in v = 2u with a polygamma of slope 1/2) is written up in the theory note and is the next
   rung; until it is in the chain the moves stay off. *)
If[!ValueQ[$gleTailExtensions],$gleTailExtensions=False];
gleBetaUndo[M_,z_,c_]:=Module[{fs=If[Head[M]===Times,List@@M,{M}],den,num,cands={},s,c0,psiArgs,b},
  den=Cases[fs,Power[Gamma[a_],-1]/;Abs[Coefficient[a,z]]==2:>Expand[a]];
  If[Length[den]=!=1,Return[None,Module]];
  s=Coefficient[den[[1]],z]/2;c0=Expand[den[[1]]-2 s z];
  If[!FreeQ[c0,z],Return[None,Module]];
  psiArgs=Cases[fs,PolyGamma[_,a_]:>Expand[a],{0,Infinity}];
  num=Join[Cases[fs,Gamma[a_]/;Coefficient[a,z]===s&&FreeQ[Expand[a-s z],z]:>Expand[a-s z]],
    Flatten[Cases[fs,Power[Gamma[a_],p_Integer?Positive]/;Coefficient[a,z]===s&&FreeQ[Expand[a-s z],z]:>ConstantArray[Expand[a-s z],p]]]];
  Do[With[{ai=num[[i]],aj=num[[j]]},With[{n=Expand[ai+aj-c0]},
      If[IntegerQ[n]&&n>=0&&TrueQ[Re[N[s c+ai]]>0]&&TrueQ[Re[N[s c+aj]]>0]&&!MemberQ[psiArgs,Expand[s z+ai]]&&!MemberQ[psiArgs,Expand[s z+aj]],
        AppendTo[cands,{n,ai,aj}]]]],{i,Length[num]},{j,i+1,Length[num]}];
  If[cands==={},Return[None,Module]];
  b=First[SortBy[cands,First]];
  <|"Kernel"->Expand[Pochhammer[2 s z+c0,b[[1]]]] Cancel[M Gamma[2 s z+c0]/(Gamma[Expand[s z+b[[2]]]] Gamma[Expand[s z+b[[3]]]])],
    "Weight"->Global`gleBv^Expand[s z+b[[2]]-1] (1-Global`gleBv)^Expand[s z+b[[3]]-1],"Var"->Global`gleBv,
    "Note"->"Beta undo of 1/Gamma["<>ToString[InputForm[den[[1]]]]<>"] with the legs "<>ToString[InputForm[{Expand[s z+b[[2]]],Expand[s z+b[[3]]]}]]<>", n = "<>ToString[b[[1]]]|>];
(* the copy of a polygamma on its own leg: returns {kernel with Gamma(L) -> Gamma(L + dum), sign of the decision point} or a Failure *)
gleCopyLeg[M_,ctr_List,dum_]:=Module[{fs=If[Head[M]===Times,List@@M,{M}],ps,L,re,sg},
  ps=Select[fs,!FreeQ[#,PolyGamma]&];
  If[Length[ps]=!=1||!MatchQ[ps[[1]],PolyGamma[0,_]],Return[Failure["GLE",<|"Reason"->"tail: polygamma weight outside the copy class (one psi to the first power)"|>],Module]];
  L=Expand[ps[[1,2]]];
  If[Count[fs,Gamma[a_]/;Expand[a-L]===0]=!=1||!FreeQ[Denominator[Together[M/.PolyGamma[__]->1]],Gamma[a_]/;Expand[a-L]===0],
    Return[Failure["GLE",<|"Reason"->"tail: psi("<>ToString[InputForm[L]]<>") is not on a simple numerator leg of the kernel"|>],Module]];
  re=Re[N[L/.ctr]];
  If[!NumericQ[re]||re==Round[re],Return[Failure["GLE",<|"Reason"->"tail: the leg of the copy has no pole-free strip"|>],Module]];
  sg=Which[Floor[re-1/40]==Floor[re],-1,Floor[re+1/40]==Floor[re],1,True,0];
  If[sg==0,Return[Failure["GLE",<|"Reason"->"tail: no decision point inside the strip of the copy leg"|>],Module]];
  {(M/ps[[1]])/.Gamma[a_]/;Expand[a-L]===0:>Gamma[L+dum],sg}];
(* Mk: Gamma kernel of the remaining variables with rational/polynomial weights; dressing = powers rat in (gt1, gu1) *)
gleTailClose[Mk_,powers_,rat_,ctr2_List,sec_]:=Catch[Module[{zs=Keys[ctr2],dum=Global`gleDumEps,eN,mons,vals={},t0=AbsoluteTime[],work={}},
  eN=dum->-1/40;
  If[DownValues[Global`fcuInvertV2]==={}||DownValues[Global`cubeHF]==={},Throw[Failure["GLE",<|"Reason"->"tail: the cube rung or the hyperlogarithm integrator is not loaded"|>],"glec"]];
  mons=gleAbsorbLinear[gleGammaCancel[Mk],zs];
  (* every monomial -> pure monomials with their extra dressing, extra variables, decision point and copy flag *)
  Do[Module[{M=mm,wExtra=1,vExtra={},copyQ=False,sg=-1,bu,cp},
      If[TrueQ[$gleTailExtensions]&&Length[zs]==1&&!FreeQ[M,Power[Gamma[a_],-1]/;Abs[Coefficient[a,zs[[1]]]]==2],
        bu=gleBetaUndo[M,zs[[1]],zs[[1]]/.ctr2];
        If[AssociationQ[bu],M=bu["Kernel"];wExtra=bu["Weight"];vExtra={bu["Var"]};gleP["tail: ",bu["Note"]]]];
      If[TrueQ[$gleTailExtensions]&&!FreeQ[M,PolyGamma],
        If[Head[Expand[M]]===Plus,
          (* the polynomial of the undo times the kernel: the copy is taken on the common Gamma part *)
          M=Collect[Expand[M],_Gamma|_PolyGamma,Together]];
        cp=gleCopyLeg[If[Head[M]===Times,Times@@Select[List@@M,!FreeQ[#,Gamma|PolyGamma]&],M],ctr2,dum];
        If[FailureQ[cp],Throw[cp,"glec"]];
        M=(If[Head[M]===Times,Times@@Select[List@@M,FreeQ[#,Gamma|PolyGamma]&],1]) cp[[1]];sg=cp[[2]];copyQ=True;
        gleP["tail: polygamma weight taken as a Gamma copy (decision point ",sg,"/40)"]];
      Do[AppendTo[work,{km,wExtra,vExtra,copyQ,sg}],{km,gleAbsorbLinear[M,zs]}]],{mm,mons}];
  gleP["tail: ",Length[work]," dressed kernel(s)"];
  Do[Module[{M=work[[i,1]],wExtra=work[[i,2]],vExtra=work[[i,3]],copyQ=work[[i,4]],dr,K,dress,inv=None,ig,vars,r,val,vn,qn,left,eNi},
      left=sec-(AbsoluteTime[]-t0);
      If[left<10,Throw[Failure["GLE",<|"Reason"->"tail: budget spent"|>],"glec"]];
      eNi=dum->work[[i,5]]/40;
      dr=Quiet@Global`fcuDress[M,zs,ctr2,eNi,dum];
      If[AssociationQ[dr]&&TrueQ[dr["Failed"]],Throw[Failure["GLE",<|"Reason"->"tail: dressing of kernel "<>ToString[i]<>" refused: "<>ToString[Lookup[dr,"Reason","?"]]|>],"glec"]];
      If[!AssociationQ[dr]&&dr=!=None,Throw[Failure["GLE",<|"Reason"->"tail: dressing of kernel "<>ToString[i]<>" failed"|>],"glec"]];
      K=If[AssociationQ[dr],dr["K"],M];
      dress=<|"Failed"->False,"K"->K,"Dressing"->If[AssociationQ[dr],dr["Dressing"],1] powers rat wExtra,
        "Vars"->Join[If[AssociationQ[dr],dr["Vars"],{}],{Global`gt1,Global`gu1},vExtra],"Prefactor"->If[AssociationQ[dr],dr["Prefactor"],1],"Trace"->{}|>;
      Do[If[inv===None,With[{rr=Quiet@TimeConstrained[Global`fcuInvertV2[K,zs,ctr2,dum,ord,eNi,{},dress],Min[300,left],$Aborted]},
            If[AssociationQ[rr]&&!TrueQ[rr["Failed"]]&&(copyQ||FreeQ[rr["Cube"],dum]),inv=rr]]],{ord,Permutations[zs]}];
      If[inv===None,Throw[Failure["GLE",<|"Reason"->"tail: no faithful cube of kernel "<>ToString[i]<>" ("<>ToString[InputForm[Short[M,3]]]<>")"|>],"glec"]];
      ig=inv["Prefactor"] dress["Prefactor"] inv["Cube"];vars=inv["Vars"];
      If[copyQ,
        Module[{ser=Quiet@Check[Series[ig,{dum,0,1}],$Failed]},
          If[Head[ser]=!=SeriesData,
            If[ser===$Failed||!FreeQ[ser,dum],Throw[Failure["GLE",<|"Reason"->"tail: the copy cube of kernel "<>ToString[i]<>" has no expansion in the copy regulator"|>],"glec"]];ig=0,
            If[ser[[4]]<0&&!AllTrue[Table[Quiet@Simplify[SeriesCoefficient[ser,o]],{o,ser[[4]],-1}],#===0&],
              Throw[Failure["GLE",<|"Reason"->"tail: the copy cube of kernel "<>ToString[i]<>" has a pole in the copy regulator"|>],"glec"]];
            ig=SeriesCoefficient[ser,1]]];
        If[!FreeQ[ig,dum],Throw[Failure["GLE",<|"Reason"->"tail: copy regulator left in the cube of kernel "<>ToString[i]|>],"glec"]]];
      If[ig===0,AppendTo[vals,0];Continue[]];
      r=Global`cubeHF[ig,vars,Max[60,Min[If[copyQ,900,600],Round[left]]]];
      If[!TrueQ[r["ok"]]||!FreeQ[r["val"],_Real],Throw[Failure["GLE",<|"Reason"->"tail: the integrator refused the cube of kernel "<>ToString[i]<>" ("<>ToString[Length[vars]]<>" variables): "<>ToString[Lookup[r,"reason","?"]]|>],"glec"]];
      val=gleToStd[r["val"]];
      If[!gleStdQ[val],Throw[Failure["GLE",<|"Reason"->"tail: constants of kernel "<>ToString[i]<>" not reduced"|>],"glec"]];
      (* development gate of the cube value: a loose direct quadrature of the cube *)
      vn=N[val,20];
      qn=Quiet@TimeConstrained[NIntegrate[ig,Evaluate[Sequence@@({#,0,1}&/@vars)],PrecisionGoal->4,MaxPoints->2*10^6,Method->{"GlobalAdaptive","SymbolicProcessing"->0}],240,$TimedOut];
      If[NumericQ[qn]&&!(Abs[vn-qn]<5*10^-3 Max[1,Abs[vn]]),
        Throw[Failure["GLE",<|"Reason"->"tail: cube gate of kernel "<>ToString[i]<>": exact "<>ToString[N[vn,12]]<>" vs quadrature "<>ToString[qn]|>],"glec"]];
      gleP["tail kernel ",i,"/",Length[work],": cube in ",Length[vars]," variables, value ",N[vn,16],", cube quadrature ",qn," (",Round[AbsoluteTime[]-t0]," s)"];
      AppendTo[vals,val]],{i,Length[work]}];
  Global`mbeCanonicalConstants[Expand[Total[vals]]]],"glec"];

(* ---------------- the rewrite of one piece ---------------- *)
If[!ValueQ[$gleRewriteDir]&&ValueQ[$closeStateDir],$gleRewriteDir=FileNameJoin[{$closeStateDir,"piece_rewrites"}]];
gleKey[F_,ctr_]:=Hash[{F,Sort[ctr]},"SHA256","HexString"];
(* ---------------- a polygamma of two or more variables: the balanced copy ---------------- *)
(* F = psi(L) F0 with L depending on at least two variables: no variable is a fold variable with psi as a spectator.  If L
   lies on the lattice of a numerator leg Gamma(L0) of F0 (L = L0 + n) and M is another numerator leg that depends on the
   fold variable v alone, then
       psi(L) = psi(L0) + rho_n(L0),      [psi(L0) - psi(M)] Gamma(L0) Gamma(M) = d/dlam [Gamma(L0 + lam) Gamma(M - lam)] at 0,
   and the copy pair leaves the defect of the v-kernel unchanged, so that the v-fold of the regulated integrand stays in
   the terminating class at every lam:
       F = rho_n F0  +  psi(M) F0  +  d/dlam Ft(lam) at 0,     Ft = F0 with Gamma(L0) Gamma(M) -> Gamma(L0+lam) Gamma(M-lam).
   The first two are pieces of the same fold count with a rational weight and with a polygamma of ONE variable (the other
   variable then folds them); the third is folded in v at finite lam (terminating kernels only) and its lam^1 coefficient
   gives lower-fold pieces.  Gate: the contour quadrature in v of [psi(L0) - psi(M)] F0 at a complex spectator point
   against that coefficient, the negative powers of lam zero. *)
gleCopyRewrite[F00_,ctr_List]:=Catch[Module[{F=F00/.{Gamma[a_]:>Gamma[Expand[a]],PolyGamma[k_,a_]:>PolyGamma[k,Expand[a]]},fs,vs=Keys[ctr],psis,psi,L,F0,args,lam=Unique["glel"],w=Global`gleV,reasons={},t0=AbsoluteTime[]},
  fs=If[Head[F]===Times,List@@F,{F}];
  psis=Select[fs,MatchQ[#,PolyGamma[0,_]]&&Count[vs,x_/;!FreeQ[#,x]]>=2&];
  If[Length[psis]=!=1||!FreeQ[Cancel[F/psis[[1]]],psis[[1]]],Throw[Failure["GLE",<|"Reason"->"copy: not exactly one first-order polygamma of several variables"|>],"glecp"]];
  psi=psis[[1]];L=Expand[psi[[2]]];F0=Cancel[F/psi];
  args=DeleteDuplicates[Join[Cases[fs,Gamma[a_]:>Expand[a]],Cases[fs,Power[Gamma[a_],_Integer?Positive]:>Expand[a]]]];
  Do[If[Abs[Coefficient[L,v]]===1,
      Module[{legsL=Select[args,IntegerQ[Expand[L-#]]&],legsM=Select[args,Abs[Coefficient[#,v]]===1&&FreeQ[#,Alternatives@@DeleteCases[vs,v]]&],ctr2=DeleteCases[ctr,v->_],pt},
        pt=Table[ctr2[[i,1]]->ctr2[[i,2]]+I {3/7,-5/11,2/9,-4/13,6/17,-8/19}[[Mod[i-1,6]+1]],{i,Length[ctr2]}];
        Do[If[L0=!=M,
            Module[{n=Expand[L-L0],rho,Ft,cands},
              rho=Which[n>0,Sum[1/(L0+j),{j,0,n-1}],n<0,-Sum[1/(L0-j),{j,1,-n}],True,0];
              Ft=(F0/(Gamma[L0]Gamma[M]))Gamma[L0+lam]Gamma[M-lam];
              cands=Select[Quiet@gleCandidates[Ft,ctr,{lam->0}],#["Var"]===v&&#["Score"][[1]]==0&];
              Do[Module[{folds,tot,ser,c1,negs,lhs,rhs,negN,pieces,same,qa},
                  folds=gleFold[#[[2]],#[[3]],#[[4]],w,cd["cw"],cd["CtrNum"]]&/@cd["Kernels"];
                  If[!AllTrue[folds,AssociationQ],AppendTo[reasons,"copy "<>cd["Note"]<>": "<>ToString[First[Select[folds,FailureQ]]["Reason"]]];Continue[]];
                  tot=cd["Spec"] Total[MapThread[#1[[1]] #2["T0"]&,{cd["Kernels"],folds}]];
                  ser=If[DownValues[withPlainSeries]=!={},withPlainSeries[Series[tot,{lam,0,1}]],Series[tot,{lam,0,1}]];
                  If[Head[ser]=!=SeriesData||ser[[4]]/ser[[6]]<-4,AppendTo[reasons,"copy "<>cd["Note"]<>": no Laurent expansion in the copy regulator"];Continue[]];
                  c1=SeriesCoefficient[ser,1];negs=Table[SeriesCoefficient[ser,-j],{j,1,Max[0,-ser[[4]]/ser[[6]]]}];
                  lhs=Quiet@NIntegrate[Evaluate[(((PolyGamma[0,L0]-PolyGamma[0,M])F0)/.pt)/.v->(v/.ctr)+I qa],{qa,-Infinity,Infinity},WorkingPrecision->30,PrecisionGoal->13,MaxRecursion->40]/(2Pi);
                  rhs=Quiet@N[c1/.pt,30];
                  negN=Max[Join[{0},Abs[Quiet@N[#/.pt,30]]&/@negs,
                    Flatten[Table[Abs[Quiet@N[((cd["Kernels"][[k,1]] #)/.lam->1/97)/.pt,30]]&/@folds[[k]]["Neg"],{k,Length[folds]}]]]];
                  If[!TrueQ[NumericQ[lhs]&&NumericQ[rhs]&&NumericQ[negN]&&Abs[lhs-rhs]<10^-9(1+Abs[lhs])&&negN<10^-12(1+Abs[lhs])],
                    gleP["copy of psi(",InputForm[L0],") against ",InputForm[M],", ",cd["Note"],": gate ",N[lhs,12]," vs ",N[rhs,12],", negative powers ",N[negN,3],"  FAIL"];
                    AppendTo[reasons,"copy "<>cd["Note"]<>": gate failed"];Continue[]];
                  pieces=glePiecesOf[c1];
                  If[!FreeQ[pieces,w|v|lam]||AnyTrue[pieces,FreeQ[#,Alternatives@@Keys[ctr2]]&],AppendTo[reasons,"copy "<>cd["Note"]<>": the lam^1 part is not a list of lower-fold pieces"];Continue[]];
                  If[Length[ctr2]==1,pieces=glePiecesOf[Total[Flatten[gleRationalToPsi[#,ctr2]&/@pieces]]]];
                  same=DeleteCases[{Together[rho] F0,PolyGamma[0,M] F0},0];
                  gleP["copy of psi(",InputForm[L0],") against the leg ",InputForm[M],", ",cd["Note"],": kernels (m, p) ",{#["m"],#["p"]}&/@folds,", gate passed (",N[lhs,12],"); ",
                    Length[pieces]," lower-fold piece(s), ",Length[same]," piece(s) of the same fold count"];
                  Throw[<|"Pieces"->Join[pieces,same],"Contours"->Join[ConstantArray[ctr2,Length[pieces]],ConstantArray[ctr,Length[same]]],"Constant"->0,
                    "Info"-><|"Note"->"copy of psi("<>ToString[InputForm[L0]]<>") against "<>ToString[InputForm[M]]<>", "<>cd["Note"],"Kernels"->({#["m"],#["p"],False}&/@folds),
                      "Gate"->{N[lhs,16],N[rhs,16]},"Tails"->0,"Rank"->1,"Viable"->1,"SameFold"->Length[same],"Seconds"->Round[AbsoluteTime[]-t0]|>|>,"glecp"]],
                {cd,Take[cands,UpTo[4]]}]]],{L0,legsL},{M,legsM}]]],{v,vs}];
  Failure["GLE",<|"Reason"->If[reasons==={},"copy: the polygamma argument is on no leg lattice with a one-variable partner leg",StringRiffle[Take[reasons,UpTo[4]]," | "]]|>]],"glecp"];
gleRewriteGet[F_,ctr_,kth_]:=Module[{f,r},
  If[!StringQ[$gleRewriteDir],Return[Missing["no store"],Module]];
  f=FileNameJoin[{$gleRewriteDir,gleKey[{F,kth},ctr]<>".m"}];
  If[!FileExistsQ[f],Return[Missing["none"],Module]];
  r=Quiet@Check[Get[f],$Failed];
  If[AssociationQ[r]&&r["F"]===F&&Sort[r["Contour"]]===Sort[ctr]&&r["Version"]===gleVersion&&r["Kth"]===kth&&ListQ[r["Pieces"]],r,Missing["stale"]]];
gleRewritePut[F_,ctr_,kth_,rw_Association]:=Module[{f},
  If[StringQ[$gleRewriteDir],
    Quiet@CreateDirectory[$gleRewriteDir,CreateIntermediateDirectories->True];
    f=FileNameJoin[{$gleRewriteDir,gleKey[{F,kth},ctr]<>".m"}];
    Put[Join[<|"F"->F,"Contour"->Sort[ctr],"Version"->gleVersion,"Kth"->kth,"Date"->DateString["ISODateTime"]|>,rw],f<>".tmp"];
    Quiet@RenameFile[f<>".tmp",f,OverwriteTarget->True]]];
(* gleRewritePiece[F, ctr, k]: the k-th rewrite of the piece (k = 1 by default).  The candidates of the planner are folded
   and gated first (cheap); those that pass are ordered by the number of lower-fold pieces they hand back (then tails,
   then the planner's score): the fewer and simpler the pieces, the more of them the closers take.  Their tails are then
   closed in that order, and the k-th candidate whose tails all close is returned -- the caller asks for k + 1 when the
   lower-fold pieces of the k-th do not all close. *)
If[!ValueQ[$gleCandidateFilter],$gleCandidateFilter=(True&)];
If[!ValueQ[$gleMaxCandidates],$gleMaxCandidates=10];
(* (g) A ONE-VARIABLE POLYGAMMA IN THE FOLD VARIABLE (4 October 2026): Barnes' first lemma with a Gamma copy.
   A piece  W x P(v) x psi(L) x Gamma(a1+v) Gamma(a2+v) Gamma(b1-v) Gamma(b2-v)  (after the exact cancellation of Gamma
   pairs at integer distance, gleGammaCancel; W free of v, P a polynomial in v, L = +-v + c with L - L0 an integer for a leg
   argument L0 of the kernel) is folded in v exactly:
     psi(L) = psi(L0) + rho(L0),   rho = Sum_{j<n} 1/(L0+j) (n = L - L0 > 0), -Sum_{j=1..-n} 1/(L0-j) (n < 0);
     psi(L0) Gamma(L0) = d/dlam Gamma(L0 + lam) at lam = 0   (the Gamma copy, subtraction_syed.tex lem:gammacopy);
     the rational part rho(L0) P(v) is absorbed into the legs (a pole 1/(L0+j), j < 0, lowers the leg L0 to L0+j);
     every term is Barnes' first lemma with the Newton expansion of its polynomial on an up leg, and the given line differs
     from a separating one by the crossed poles (down poles v = b_j + n left of the line: + Res; up poles v = -a_i - n right
     of it: - Res).  Every leg carries a regulator k del (distinct k), so that every crossed pole is simple and a pinch
     a_i + b_j in Z_{<=0} is lifted; the fixed-line integral is analytic at del = 0 (no pole meets the line for del between 0
     and del0, checked), so the value is the del^0 coefficient, of the lam^1 coefficient for the copy part; every negative
     power of del must cancel (checked at a complex point of the spectators).
   Gate: the contour quadrature in v of the whole piece at a complex point of the spectators against the result.
   The result is a list of pieces with one fold fewer (polygammas of the spectators) plus a constant. *)
gleCflCrossings[aa_List,bb_List,cv_,num_]:=Module[{out={},x0,nmax},
  (* down legs Gamma(b - v): poles v = b + n LEFT of the line (+1); up legs Gamma(a + v): poles v = -a - n RIGHT of it (-1) *)
  Do[x0=num[bb[[j]]];If[!NumericQ[x0],Return[$Failed,Module]];
    nmax=Max[-1,Ceiling[cv-x0]];Do[If[x0+n<cv,AppendTo[out,{+1,"dn",j,n}]],{n,0,nmax}],{j,Length[bb]}];
  Do[x0=num[-aa[[i]]];If[!NumericQ[x0],Return[$Failed,Module]];
    nmax=Max[-1,Ceiling[x0-cv]];Do[If[x0-n>cv,AppendTo[out,{-1,"up",i,n}]],{n,0,nmax}],{i,Length[aa]}];
  out];
(* the exact value of  Int_line dv/(2 pi i) P(v) Gamma(a1+v) Gamma(a2+v) Gamma(b1-v) Gamma(b2-v)  for regulated (symbolic)
   parameters: first lemma (Newton on a1) + crossed residues; cross = the census {sign, "dn"/"up", index, n} *)
gleCflTerm[P_,aa_List,bb_List,w_,cross_List]:=Module[{cs,lem,res=0,g,a1=aa[[1]],a2=aa[[2]],b1=bb[[1]],b2=bb[[2]]},
  cs=gleNewton[P,w,a1,True];If[cs===$Failed,Return[$Failed,Module]];
  lem=Sum[cs[[r+1]] Gamma[a1+r+b1]Gamma[a1+r+b2]Gamma[a2+b1]Gamma[a2+b2]/Gamma[a1+r+a2+b1+b2],{r,0,Length[cs]-1}];
  Do[Module[{s=cr[[1]],kind=cr[[2]],k=cr[[3]],n=cr[[4]],vp,rest},
      If[kind==="dn",
        vp=bb[[k]]+n;rest=P Gamma[a1+w]Gamma[a2+w]Gamma[bb[[3-k]]-w];
        res+=s (-(-1)^n/n!) (rest/.w->vp),
        vp=-aa[[k]]-n;rest=P Gamma[aa[[3-k]]+w]Gamma[b1-w]Gamma[b2-w];
        res+=s ((-1)^n/n!) (rest/.w->vp)]],{cr,cross}];
  lem+res];
(* exact raise of the polygammas of the spectators whose argument has a real part below 1/4 on the (real) contour *)
gleRaisePsi[e_,ctr2_List]:=e/.PolyGamma[k_Integer,L_]/;(!FreeQ[L,Alternatives@@Keys[ctr2]]&&
    With[{r=Quiet@N[Re[L/.ctr2]]},NumericQ[r]&&r<1/4]):>
  With[{n=Ceiling[1/4-Re[N[L/.ctr2]]]},PolyGamma[k,L+n]-(-1)^k k! Sum[1/(L+j)^(k+1),{j,0,n-1}]];
gleCopyFirstLemma[F00_,ctr0_List]:=Catch[Module[{F,ctr=Normal[ctr0],vs,reasons={},t0=AbsoluteTime[],w=Global`gleV},
  vs=Keys[ctr];
  F=F00/.{Gamma[a_]:>Gamma[Expand[a]],PolyGamma[k_,a_]:>PolyGamma[k,Expand[a]]};
  If[Head[F]=!=Times,Throw[Failure["GLE",<|"Reason"->"copy-first-lemma: the piece is not a product"|>],"glecfl"]];
  Do[Module[{fs=List@@F,psis,psi,L,G0,gf,W=1,ups={},dns={},Rv=1,okv=True,legs,L0,n,rho,lam=Unique["gcflam"],del=Unique["gcfdel"],
       cv,ctr2,num,cross1,del0,terms2,R2,ap,V1,V2,tot,ser,negs,tot0,pt,lhs,rhs,negN,pcs,const,vv},
      psis=Select[fs,!FreeQ[#,PolyGamma]&&!FreeQ[#,v]&];
      If[Length[psis]=!=1||!MatchQ[psis[[1]],PolyGamma[0,_]],Continue[]];
      psi=psis[[1]];L=psi[[2]];
      If[Abs[Coefficient[L,v]]=!=1,AppendTo[reasons,ToString[v]<>": polygamma slope "<>ToString[Coefficient[L,v]]];Continue[]];
      cv=v/.ctr;ctr2=DeleteCases[ctr,v->_];
      (* exact cancellation of Gamma pairs at integer distance, then the census in v (variable renamed to w) *)
      G0=gleGammaCancel[(F/psi)/.v->w];
      gf=If[Head[G0]===Times,List@@G0,{G0}];
      Do[Which[
          FreeQ[f,w],W=W f,
          MatchQ[f,Gamma[_]|Power[Gamma[_],_Integer]],
            Module[{a=If[Head[f]===Power,f[[1,1]],f[[1]]],p=If[Head[f]===Power,f[[2]],1],sl},
              sl=Coefficient[a,w];
              Which[p<0||!MemberQ[{1,-1},sl]||!FreeQ[Expand[a-sl w],w],okv=False,
                sl===1,ups=Join[ups,ConstantArray[Expand[a-w],p]],
                True,dns=Join[dns,ConstantArray[Expand[a+w],p]]]],
          !FreeQ[f,Gamma|PolyGamma],okv=False,
          True,Rv=Rv f],{f,gf}];
      Rv=Together[Rv];
      If[!okv||!PolynomialQ[Numerator[Rv],w]||!FreeQ[Denominator[Rv],w],AppendTo[reasons,ToString[v]<>": not a 2+2 kernel with a polynomial weight"];Continue[]];
      If[Length[ups]=!=2||Length[dns]=!=2,AppendTo[reasons,ToString[v]<>": "<>ToString[Length[ups]]<>"+"<>ToString[Length[dns]]<>" legs, not 2+2"];Continue[]];
      (* the leg on whose lattice psi(L) lies: argument L0 = w + a (up) or b - w (down) *)
      legs=Join[{w+#,"up",#}&/@ups,{#-w,"dn",#}&/@dns];
      L0=SelectFirst[SortBy[legs,Abs[Expand[(L/.v->w)-#[[1]]]]&],IntegerQ[Expand[(L/.v->w)-#[[1]]]]&,None];
      If[L0===None,AppendTo[reasons,ToString[v]<>": psi argument on no leg lattice"];Continue[]];
      n=Expand[(L/.v->w)-L0[[1]]];
      rho=Which[n>0,Sum[1/(L0[[1]]+j),{j,0,n-1}],n<0,-Sum[1/(L0[[1]]-j),{j,1,-n}],True,0];
      num[x_]:=With[{y=Expand[x]/.(ctr2/.Rule[a_,b_]:>Rule[a,Re[b]])/.{lam->0,del->del0}},If[NumericQ[y],Re[N[y,30]],$Failed]];
      (* regulators: up leg i -> a_i + (2 i - 1) del, down leg j -> b_j + 2 j del; the copy leg also carries lam *)
      Module[{aR,bR,crossOf,okDel=False,ddel,kU,kD,copyIdx,copyKind},
        copyKind=L0[[2]];copyIdx=If[copyKind==="up",First[FirstPosition[ups,L0[[3]]]],First[FirstPosition[dns,L0[[3]]]]];
        aR[withLam_]:=Table[ups[[i]]+(2 i-1) del+If[withLam&&copyKind==="up"&&i===copyIdx,lam,0],{i,2}];
        bR[withLam_]:=Table[dns[[j]]+2 j del+If[withLam&&copyKind==="dn"&&j===copyIdx,lam,0],{j,2}];
        (* del0: the crossing census must be the same at del0 and del0/1000, of either sign; no pole on the line at 0 *)
        Do[del0=ddel;With[{c1=gleCflCrossings[aR[False],bR[False],Re[N[cv,30]],num]},
            del0=ddel/1000;With[{c2=gleCflCrossings[aR[False],bR[False],Re[N[cv,30]],num]},
              If[ListQ[c1]&&c1===c2,okDel=True;del0=ddel;cross1=c1]]];If[okDel,Break[]],{ddel,{1/97,-1/97}}];
        If[!okDel,AppendTo[reasons,ToString[v]<>": no regulator interval with a constant crossing census"];Continue[]];
        (* the copy part: P(w) Gamma(L0+lam) ...; its lam^1 coefficient *)
        V1=gleCflTerm[Numerator[Rv]/Denominator[Rv],aR[True],bR[True],w,cross1];
        If[V1===$Failed,AppendTo[reasons,ToString[v]<>": Newton expansion failed"];Continue[]];
        (* the rational part rho(L0) P(w): partial fractions in w, poles 1/(L0+j) (j < 0) absorbed by lowering the leg L0 *)
        R2=Together[rho Rv];V2=0;
        If[R2=!=0,
          ap=Apart[R2,w];ap=If[Head[ap]===Plus,List@@ap,{ap}];
          Do[Module[{tt=Together[t],den,w0,j,c,newUps=ups,newDns=dns,aN,bN,cN,poly},
              den=Denominator[tt];
              Which[
                FreeQ[den,w],V2+=gleCflTerm[tt,aR[False],bR[False],w,cross1],
                PolynomialQ[den,w]&&Exponent[den,w]===1,
                  w0=w/.First[Solve[den==0,w]];j=Expand[-(L0[[1]]/.w->w0)];
                  c=Together[tt*(L0[[1]]+j)];
                  If[!(IntegerQ[j]&&j<=-1&&PolynomialQ[Numerator[c],w]&&FreeQ[Denominator[c],w]),okv=False,
                    (* Gamma(L0)/(L0+j) = Gamma(L0+j) (L0+j+1)...(L0-1): the leg L0 lowered by -j *)
                    poly=Together[c*Product[L0[[1]]+i,{i,j+1,-1}]];
                    If[copyKind==="up",newUps[[copyIdx]]=Expand[ups[[copyIdx]]+j],newDns[[copyIdx]]=Expand[dns[[copyIdx]]+j]];
                    aN=Table[newUps[[i]]+(2 i-1) del,{i,2}];bN=Table[newDns[[k]]+2 k del,{k,2}];
                    cN=gleCflCrossings[aN,bN,Re[N[cv,30]],num];
                    If[!ListQ[cN],okv=False,V2+=gleCflTerm[poly,aN,bN,w,cN]]],
                True,okv=False]],{t,ap}];
          If[!okv,AppendTo[reasons,ToString[v]<>": a rational pole of the copy remainder is not absorbable"];Continue[]]];
        (* lam^1 of the copy part, del^0 of the sum; the negative powers of del must cancel *)
        tot=W (If[DownValues[withPlainSeries]=!={},withPlainSeries[SeriesCoefficient[Series[V1,{lam,0,1}],1]],SeriesCoefficient[Series[V1,{lam,0,1}],1]]+V2);
        ser=If[DownValues[withPlainSeries]=!={},withPlainSeries[Series[tot,{del,0,0}]],Series[tot,{del,0,0}]];
        If[Head[ser]=!=SeriesData,AppendTo[reasons,ToString[v]<>": no Laurent series in the regulator"];Continue[]];
        negs=Table[SeriesCoefficient[ser,-k],{k,1,Max[0,-ser[[4]]/ser[[6]]]}];
        tot0=SeriesCoefficient[ser,0];
        pt=Table[ctr2[[i,1]]->ctr2[[i,2]]+I {3/7,-5/11,2/9,-4/13,6/17,-8/19}[[Mod[i-1,6]+1]],{i,Length[ctr2]}];
        negN=Max[Join[{0},Abs[Quiet@N[#/.pt,30]]&/@negs]];
        lhs=Quiet@NIntegrate[Evaluate[(F/.pt)/.v->cv+I vv],{vv,-Infinity,Infinity},WorkingPrecision->30,PrecisionGoal->14,MaxRecursion->40]/(2Pi);
        rhs=Quiet@N[tot0/.pt,30];
        If[!TrueQ[NumericQ[lhs]&&NumericQ[rhs]&&NumericQ[negN]&&Abs[lhs-rhs]<10^-10 (1+Abs[lhs])&&negN<10^-15 (1+Abs[lhs])],
          gleP["copy-first-lemma in ",v,": gate ",N[lhs,14]," vs ",N[rhs,14],", negative powers ",N[negN,3],"  FAIL"];
          AppendTo[reasons,ToString[v]<>": fold gate failed"];Continue[]];
        (* polygammas of the spectators whose argument has a real part below 1/4 on the contour are raised exactly,
           psi^(k)(L) = psi^(k)(L+1) - (-1)^k k!/L^(k+1), before the split into pieces: the piece closers refuse a
           polygamma within 1/4 of its pole (MB11's residue 18: psi(-s) psi(1+s) (7+2s) stayed open in the lane for
           1500 s; split this way its four pieces close in 9-165 s); the raised form is gated again *)
        tot0=Expand[gleRaisePsi[tot0,ctr2]];
        If[!TrueQ[Abs[Quiet@N[tot0/.pt,30]-rhs]<10^-10 (1+Abs[rhs])],AppendTo[reasons,ToString[v]<>": the raised form fails its gate"];Continue[]];
        pcs=glePiecesOf[tot0];
        const=Total[Select[pcs,FreeQ[#,Alternatives@@Keys[ctr2]]&]];
        pcs=Select[pcs,!FreeQ[#,Alternatives@@Keys[ctr2]]&];
        If[!FreeQ[pcs,w|v|lam|del]||!FreeQ[const,w|v|lam|del],AppendTo[reasons,ToString[v]<>": the result is not a list of lower-fold pieces"];Continue[]];
        gleP["copy-first-lemma in ",v,": psi(",InputForm[L],") copied on the leg ",InputForm[L0[[1]]/.w->v],", ",Length[cross1]," crossed pole(s), gate passed (",N[lhs,14],"); ",
          Length[pcs]," piece(s) with one fold fewer, constant ",N[const,12]];
        Throw[<|"Pieces"->pcs,"Contours"->ConstantArray[ctr2,Length[pcs]],"Constant"->const,
          "Info"-><|"Note"->"first lemma with the polygamma copy in "<>ToString[v],"Kernels"->{},"Gate"->{N[lhs,16],N[rhs,16]},"Tails"->0,
            "SeriesTails"->0,"Rank"->1,"Viable"->1,"Seconds"->Round[AbsoluteTime[]-t0]|>|>,"glecfl"]]],{v,vs}];
  Failure["GLE",<|"Reason"->"copy-first-lemma: "<>If[reasons==={},"no variable with one first-order polygamma",StringRiffle[Take[reasons,UpTo[4]]," | "]]|>]],"glecfl"];
(* the structural precondition of gleCopyFirstLemma alone (no integration): some variable v carries exactly one
   first-order polygamma psi(L), L of unit slope in v, on the lattice of a leg of a 2+2 kernel in v with a polynomial
   weight (after the exact Gamma-pair cancellation) *)
gleCopyFirstLemmaQ[F00_,ctr0_List]:=Module[{F,vs=Keys[Normal[ctr0]],w=Global`gleV},
  F=F00/.{Gamma[a_]:>Gamma[Expand[a]],PolyGamma[k_,a_]:>PolyGamma[k,Expand[a]]};
  If[Head[F]=!=Times,Return[False,Module]];
  AnyTrue[vs,Function[v,Module[{fs=List@@F,psis,L,G0,gf,ups={},dns={},Rv=1,okv=True},
    psis=Select[fs,!FreeQ[#,PolyGamma]&&!FreeQ[#,v]&];
    If[Length[psis]=!=1||!MatchQ[psis[[1]],PolyGamma[0,_]]||Abs[Coefficient[psis[[1,2]],v]]=!=1,Return[False,Module]];
    L=Expand[psis[[1,2]]/.v->w];
    G0=gleGammaCancel[(F/psis[[1]])/.v->w];gf=If[Head[G0]===Times,List@@G0,{G0}];
    Do[Which[FreeQ[f,w],Null,
        MatchQ[f,Gamma[_]|Power[Gamma[_],_Integer]],
          Module[{a=If[Head[f]===Power,f[[1,1]],f[[1]]],p=If[Head[f]===Power,f[[2]],1],sl},sl=Coefficient[a,w];
            Which[p<0||!MemberQ[{1,-1},sl]||!FreeQ[Expand[a-sl w],w],okv=False,sl===1,ups=Join[ups,ConstantArray[Expand[a-w],p]],True,dns=Join[dns,ConstantArray[Expand[a+w],p]]]],
        !FreeQ[f,Gamma|PolyGamma],okv=False,
        True,Rv=Rv f],{f,gf}];
    Rv=Together[Rv];
    okv&&PolynomialQ[Numerator[Rv],w]&&FreeQ[Denominator[Rv],w]&&Length[ups]===2&&Length[dns]===2&&
      AnyTrue[Join[w+#&/@ups,#-w&/@dns],IntegerQ[Expand[L-#]]&]]]]];

gleRewritePiece[F_,ctr0_List,kth_Integer:1]:=Module[{ctr=Normal[ctr0],cands,reasons={},out=None,hit,t0=AbsoluteTime[],w=Global`gleV,viable={},succ=0},
  (* polygamma factors are admitted as SPECTATORS: a variable on which a polygamma depends is no fold variable (gleLegs) *)
  If[Length[ctr]<2,Return[Failure["GLE",<|"Reason"->"not a multi-fold piece"|>],Module]];
  hit=gleRewriteGet[F,ctr,kth];
  If[AssociationQ[hit],Return[hit,Module]];
  cands=Select[Quiet@gleCandidates[F,ctr],TrueQ[$gleCandidateFilter[#]]&];
  If[cands==={},
    (* no fold variable; a polygamma of several variables on a leg lattice is taken by the balanced copy (one rewrite) *)
    If[!FreeQ[F,PolyGamma]&&kth==1,
      With[{cr=gleCopyRewrite[F,ctr]},If[AssociationQ[cr],gleRewritePut[F,ctr,kth,cr];Return[cr,Module]];
        (* (g) a one-variable polygamma in a first-lemma fold variable: the Gamma copy with Barnes' first lemma *)
        With[{c2=gleCopyFirstLemma[F,ctr]},If[AssociationQ[c2],gleRewritePut[F,ctr,kth,c2];Return[c2,Module]];
          Return[Failure["GLE",<|"Reason"->ToString[cr["Reason"]]<>" || "<>ToString[c2["Reason"]]|>],Module]]]];
    Return[Failure["GLE",<|"Reason"->"no variable with a 3+2 over 1 kernel of integer defect (pinched tail or terminating)"|>],Module]];
  (* 1. folds, gates and lower-fold pieces of every candidate *)
  Do[Module[{v=cd["Var"],cw=cd["cw"],ctrNum=cd["CtrNum"],folds,rs,pt,gate,pieces,ctr2},
      ctr2=DeleteCases[ctr,v->_];
      folds=gleFold[#[[2]],#[[3]],#[[4]],w,cw,ctrNum]&/@cd["Kernels"];
      If[!AllTrue[folds,AssociationQ],AppendTo[reasons,cd["Note"]<>": "<>ToString[First[Select[folds,FailureQ]]["Reason"]]];Continue[]];
      rs=Transpose[{cd["Kernels"][[All,1]],folds}];
      pt=Table[ctr2[[i,1]]->ctr2[[i,2]]+I {3/7,-5/11,2/9,-4/13,6/17,-8/19}[[Mod[i-1,6]+1]],{i,Length[ctr2]}];
      gate=gleFoldGate[F,v,v/.ctr,cd["Spec"],rs,pt];
      If[!gate["Pass"],gleP[cd["Note"],": fold gate ",N[gate["A"],12]," vs ",N[gate["BC"],12],", negative powers ",N[gate["Neg"],3],"  FAIL"];
        AppendTo[reasons,cd["Note"]<>": fold gate failed"];Continue[]];
      pieces=glePiecesOf[cd["Spec"] Total[#[[1]] #[[2]]["T0"]&/@rs]];
      If[!FreeQ[pieces,w|v]||AnyTrue[pieces,FreeQ[#,Alternatives@@Keys[ctr2]]&],AppendTo[reasons,cd["Note"]<>": the d^0 part is not a list of lower-fold pieces"];Continue[]];
      gleP[cd["Note"],": kernels (m, p, tail) ",{#["m"],#["p"],If[TrueQ[#["Collapsed"]],"series",#["HasS"]]}&/@folds,", fold gate passed (",N[gate["A"],12],"), ",Length[pieces]," lower-fold piece(s)"];
      AppendTo[viable,<|"Cand"->cd,"rs"->rs,"Gate"->gate,"Pieces"->pieces,"Contour2"->ctr2,"Folds"->folds,"Pt"->pt|>]],{cd,Take[cands,UpTo[$gleMaxCandidates]]}];
  If[viable==={},Return[Failure["GLE",<|"Reason"->StringRiffle[reasons," | "]|>],Module]];
  viable=SortBy[viable,{Length[#["Pieces"]],Count[#["Folds"],_?(TrueQ[#["HasS"]]&)],#["Cand"]["Score"]}&];
  (* 2. the tails, in that order; the k-th candidate that closes them.  A tail with a rational series (iii) is taken as
     polygamma pieces when one variable is left or when its weight carries a polygamma (the dressed cube takes pure Gamma
     kernels only), and whenever its cube does not close; the rational sum is checked against the series numerically. *)
  Do[If[out===None,Module[{cd=vb["Cand"],const=0,ok=True,nt=0,extra=0,nser=0,pieces=vb["Pieces"],serQ},
        serQ[rr_]:=AssociationQ[rr[[2]]]&&KeyExistsQ[rr[[2]],"Collapse"]&&rr[[2]]["Collapse"]=!=None&&
          With[{x=Quiet@N[(rr[[2]]["Collapse"])/.vb["Pt"],30],y=Quiet[N[rr[[2]]["Pfin"]/.vb["Pt"],30] gleSnum[rr[[2]],vb["Pt"]]]},
            TrueQ[NumericQ[x]&&NumericQ[y]&&Abs[x-y]<10^-9 (1+Abs[y])]];
        Do[If[ok&&TrueQ[rr[[2]]["HasS"]],
            If[(Length[vb["Contour2"]]==1||!FreeQ[cd["Spec"] rr[[1]],PolyGamma])&&serQ[rr],
              extra+=rr[[1]] rr[[2]]["Collapse"];nser++,
              With[{tv=gleTailClose[cd["Spec"] rr[[1]] rr[[2]]["Pfin"] rr[[2]]["N"],rr[[2]]["Powers"],rr[[2]]["EulerRational"],vb["Contour2"],$gleTailSeconds]},
                If[FailureQ[tv],
                  If[serQ[rr],extra+=rr[[1]] rr[[2]]["Collapse"];nser++,AppendTo[reasons,cd["Note"]<>": "<>ToString[tv["Reason"]]];ok=False],
                  const+=tv;nt++]]]],{rr,vb["rs"]}];
        If[ok&&nser>0,
          pieces=glePiecesOf[cd["Spec"] (Total[#[[1]] #[[2]]["T0"]&/@vb["rs"]]+extra)];
          If[!FreeQ[pieces,w|cd["Var"]]||AnyTrue[pieces,FreeQ[#,Alternatives@@Keys[vb["Contour2"]]]&],
            AppendTo[reasons,cd["Note"]<>": the rational series is not a list of lower-fold pieces"];ok=False]];
        (* one-fold pieces: rational factors of non-unit slope become polygamma differences (gleRationalToPsi) *)
        If[ok&&Length[vb["Contour2"]]==1,
          With[{pp=glePiecesOf[Total[Flatten[gleRationalToPsi[#,vb["Contour2"]]&/@pieces]]]},If[FreeQ[pp,w|cd["Var"]],pieces=pp]]];
        If[ok,succ++;
          If[succ==kth,
            out=<|"Pieces"->pieces,"Contours"->ConstantArray[vb["Contour2"],Length[pieces]],"Constant"->Global`mbeCanonicalConstants[Expand[const]],
              "Info"-><|"Note"->cd["Note"],"Kernels"->({#["m"],#["p"],If[TrueQ[#["Collapsed"]],"series",#["HasS"]]}&/@vb["Folds"]),"Gate"->{N[vb["Gate"]["A"],16],N[vb["Gate"]["BC"],16]},"Tails"->nt,
                "SeriesTails"->nser,"Rank"->kth,"Viable"->Length[viable],"Seconds"->Round[AbsoluteTime[]-t0]|>|>]]]],{vb,viable}];
  If[out===None,Return[Failure["GLE",<|"Reason"->If[succ>0,"only "<>ToString[succ]<>" rewrite(s) of this piece (asked for number "<>ToString[kth]<>")",StringRiffle[reasons," | "]]|>],Module]];
  gleRewritePut[F,ctr,kth,out];
  out];
Print["[uint_gle] generalized Barnes lemma rewrite loaded (terminating and pinched folds, d^0 pieces, Euler tail as a dressed cube or a rational series; version ",gleVersion,")."];
