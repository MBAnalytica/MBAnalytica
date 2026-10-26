(* uint_gb_euler.m  (1 October 2026) -- the GENERAL closer of
   eps-free TWO-fold MB pieces whose Barnes chain stops at a generalized lemma with a hypergeometric 3F2(1) that does not
   collapse: "generalized Barnes -> Euler kernel -> Mellin tower at the scale -> exact last fold".

   Class.  F(z, w) = (Gamma product, unit or slope-two legs) x (rational in z, w) x (at most one psi(L), L affine with real
   rational coefficients), on straight contours Re z = c_z, Re w = c_w, eps-free (the piece layer).  Steps, every one an
   exact identity with a numerical gate:
     1. psi split.  psi(L) with a Gamma leg Gamma(L_leg)^p of the kernel at integer distance: psi(L) = psi(L_leg) + rational
        sum; the psi(L_leg) part is the regulator derivative of the Gamma COPY F_d = K Gamma(L_leg + d)/Gamma(L_leg) (a pure
        Gamma product), closed by a finite-d Barnes lemma in one variable (first, second or collapsed generalized lemma,
        A-gated at d = -1/40) into one-fold d-dependent terms; each term is stable on [-1/40, 0] (no numerator Gamma
        argument meets a non-positive integer on its contour in between), is expanded in d at its fixed contour, and its
        Laurent coefficients are eps-free one-fold pieces of the ordinary chain (ladClosePiece); the negative orders must
        cancel EXACTLY over the terms, the d^0 sum is gated by the two-fold quadrature of the undressed kernel.  The
        rational parts are pure Gamma x rational two-folds: the iterated 2+2 closed form (bn) where its slots absorb the
        pole, otherwise step 2.
     2. Euler kernel.  Plans are enumerated symbolically first (both fold orders x the three b3 choices of the generalized
        lemma, after Gauss multiplication of the slope-two legs in the integrated variable with balanced 2-powers), the 3F2
        of each plan classified from its RAW parameter lists:
          A  3F2(p, q, U; (U+r)/2, (U+r+1)/2; 1) = Gamma(U+r)/(Gamma(U)Gamma(r)) Int_0^1 x^(U-1)(1-x)^(r-1) 2F1(p,q;r;4x(1-x)) dx,
          B  3F2(p, q, U; r, U+m; 1)               = Gamma(U+m)/(Gamma(U)Gamma(m)) Int_0^1 x^(U-1)(1-x)^(m-1) 2F1(p,q;r;x) dx,
        with p, q, r free of w and U = sigma w + c, sigma = +-1; the admitted plans are ranked (pattern, subtraction order N,
        crossings) and executed in order: the lemma gated at two complex spectator points with the exact crossing census,
        the 2F1 for integers p, q, r as the rational-log function K(y) (partial fractions of (p)_n(q)_n/(n!(r)_n), the exact
        identity checked, plus a numerical check), phi(x) = (1-x)^(h-1) K(..) subtracted by its Taylor polynomial T_{N-1}
        with N = max(0, floor(-Re U) + 1) (strictly Re U + N > 0 on the contour), the representation gated against the 3F2
        at two complex w points; the lemma prefactor, the Beta constant C(w) and the spectators combined (Legendre
        duplication run backwards on half-slope pairs; every surviving 2^(k w) refuses) into M(w), a Gamma product times
        a rational function of w.
     3. Mellin tower at the scale.  J(x) = Int M(w) x^(sigma w) dw/(2 pi i) by the Mellin tower rung (integer-distance legs
        merged, coincident legs split by regulators, rational factors as (Theta + a)^-1 operators), gated at scale points;
        the output fibrated in x (words with the letters {0,1} at the endpoint x).
     4. Exact last fold.  The remainder Int_0^1 x^(c-1) (phi - T)(x) J(x) dx is folded about x = 1/2 (pattern A), x = (1 -+ t)/2:
        log((1-2x)^2) = 2 log t, 4x(1-x) = 1 - t^2, every word G(a; x) pulled back with its EXACT constants at the basepoint
        1/2 (path composition G(a1..an; b + s t) = sum_k G((a1-b)/s, .., (ak-b)/s; t) G(a_{k+1}..a_n; b); the constants are
        words at 1 with the letters {0,2} by rescaling, reduced to alternating constants; all-zero words are logarithms);
        each half gated separately at two points; the package's exact last fold (derivative gate, complete endpoint jets).
        Pattern B integrates on [0,1] directly.
     5. The subtraction moments and the crossings of the lemma are one-fold pieces of the ordinary chain; the total of a
        plan is gated by the two-dimensional contour quadrature of the original piece, and a failed plan is followed by
        the next.  Refusals are loud (the reason names the step).  No target identifier enters; every value is exact.

   gbTwoFold[F, ctr, budget] -> <|"Value", "Method", "Quad", "Parts"|> or Failure["GB2", <|"Reason"|>]
   Requires: mbe_barnes_lib.m, uint_bn_lib.m (bnGated), uint_fcu_s2.m (s2ItemLaurent, s2NormalizeInner, s2LFIntegrate,
   s2Gnum, s2Fib, s2LastFoldLoadedQ), uint_piece_chain.m (ladClosePiece, ladQuad, ladGateQ, ladExactQ, ladEp), the
   Mellin tower rung, PolyLogTools. *)
gbVersion="2026-10-01o";
gbFactors[F_]:=If[Head[F]===Times,List@@F,{F}];
gbP[s___]:=If[TrueQ[$gbVerbose],Print["    [gb] ",s]];
If[!ValueQ[$gbVerbose],$gbVerbose=True];
gbRefuse[s_]:=Throw[Failure["GB2",<|"Reason"->s|>],"gb2"];
(* jointly affine in vs with real numeric coefficients *)
gbAffineQ[a_,vs_List]:=Module[{e=Expand[a],at0=Thread[vs->0],cs},
  If[!PolynomialQ[e,vs],Return[False,Module]];
  cs=Join[{e/.at0},(D[e,#]/.at0)&/@vs];
  Expand[e-(e/.at0)-Total[(# (D[e,#]/.at0))&/@vs]]===0&&AllTrue[cs,NumericQ[#]&&TrueQ[Im[N[#]]==0]&]];
gbNoNonposIntBetweenQ[u_,v_]:=TrueQ[Ceiling[Min[u,v]]>Min[0,Floor[Max[u,v]]]];
(* numeric value of an expression that may carry PolyLogTools words (Ginsh through s2Gnum) *)
gbNum[e_]:=Module[{v=Quiet@N[e,30]},If[NumericQ[v],v,If[DownValues[s2Gnum]=!={},s2Gnum[e],$Failed]]];
(* the gate of a served value against a quadrature: numerics through gbNum (words at 1 outside the HPL tables go to Ginsh) *)
gbGateQ[v_,q_,nf_:1]:=Module[{vn=gbNum[v]},TrueQ[NumericQ[q]&&NumericQ[vn]&&Abs[vn-q]<If[nf==1,10^-10,10^-6] Max[1,Abs[q]]]];
gbTC[expr_,sec_]:=TimeConstrained[expr,Max[1,sec],gbRefuse["time limit ("<>ToString[Round[sec]]<>" s) in "<>ToString[Short[Hold[expr],2]]]];
SetAttributes[gbTC,HoldFirst];
(* ---------- Gauss multiplication of the slope-|k| >= 2 legs in z (all of them, the spectator-dependent ones included); the
   net power of every numeric base must be free of z (balanced legs) ---------- *)
gbGaussZ[F_,z_,vs_List,dsub_List:{}]:=Module[{fs=gbFactors[F],out=1,gauss,bad},
  gauss[a_,k_]:=With[{m=Abs[k],w0=Expand[a/Abs[k]+Sign[k] z]},(2 Pi)^((1-m)/2) m^(m w0-1/2) Product[Gamma[Expand[w0+j/m]],{j,0,m-1}]];
  Do[Which[
      MatchQ[t,Gamma[_]]&&!FreeQ[t,z],With[{k=Coefficient[Expand[t[[1]]],z]},
        If[!IntegerQ[k]||!gbAffineQ[Expand[t[[1]]]/.dsub,vs],gbRefuse["non-integer or nonlinear slope in "<>ToString[z]]];
        out*=If[Abs[k]>=2,gauss[Expand[t[[1]]-k z],k],t]],
      MatchQ[t,Power[Gamma[_],_Integer]]&&!FreeQ[t,z],With[{k=Coefficient[Expand[t[[1,1]]],z],p=t[[2]]},
        If[!IntegerQ[k]||!gbAffineQ[Expand[t[[1,1]]]/.dsub,vs],gbRefuse["non-integer or nonlinear slope in "<>ToString[z]]];
        out*=If[Abs[k]>=2,gauss[Expand[t[[1,1]]-k z],k]^p,t]],
      True,out*=t],{t,fs}];
  out=PowerExpand[out,Assumptions->True]/.Power[b_?NumericQ,e_]:>Power[b,Expand[e]];
  bad=Select[gbFactors[out],FreeQ[#,Gamma]&&!FreeQ[#,z]&&!(PolynomialQ[#,z]||MatchQ[#,Power[q_,_Integer?Negative]/;PolynomialQ[q,z]])&];
  If[bad=!={},gbRefuse["unbalanced slope-two legs in "<>ToString[z]<>": scale factors "<>ToString[bad,InputForm]<>" left"]];
  out];
(* ---------- exact crossing census of a one-variable Gamma product at the contour c (exact bounds); subs:
   the spectators at their REAL rational points.  {sign, pole}: down-pole (Gamma(x - v), poles v = x + n) LEFT of the
   contour -> +Res; up-pole (Gamma(x + v), poles v = -x - n) RIGHT of it -> -Res.  A pole on the contour refuses. ---------- *)
gbCrossings[zpart_,v_,c_,subs_List]:=Module[{g=mblGammasOf[zpart],crs={},re},
  re[x_]:=With[{y=x/.subs},If[NumericQ[y],Re[y],gbRefuse["non-numeric pole position "<>ToString[x,InputForm]]]];
  Do[Module[{arg=Expand[gp[[1]]],sl,x0,delta,cnt},sl=Coefficient[arg,v];x0=Expand[arg-sl v];
      Which[
        sl===-1,delta=c-re[x0];                                    (* poles v = x0 + n, crossed when x0 + n < c *)
          If[IntegerQ[delta]&&delta>=0,gbRefuse["a pole of "<>ToString[gp[[1]],InputForm]<>" lies on the contour"]];
          cnt=Max[0,Ceiling[delta]];Do[AppendTo[crs,{+1,x0+n}],{n,0,cnt-1}],
        sl===1,delta=-re[x0]-c;                                    (* poles v = -x0 - n, crossed when -x0 - n > c *)
          If[IntegerQ[delta]&&delta>=0,gbRefuse["a pole of "<>ToString[gp[[1]],InputForm]<>" lies on the contour"]];
          cnt=Max[0,Ceiling[delta]];Do[AppendTo[crs,{-1,-x0-n}],{n,0,cnt-1}],
        True,gbRefuse["slope "<>ToString[sl]<>" leg in the crossing census"]]],
    {gp,Select[g,#[[2]]>0&]}];
  (* a location reached from BOTH families is a pinch (not a plain crossing): refused *)
  If[Length[DeleteDuplicatesBy[crs,#[[2]]&]]=!=Length[DeleteDuplicates[crs]],gbRefuse["a crossed pole reached from both families (pinch)"]];
  DeleteDuplicates[crs]];
(* ---------- the generalized Barnes lemma in z: the symbolic plans for EVERY choice of b3 (no numerics here) ---------- *)
gbBarnesGenPlans[F_,z_,ctr_List]:=Module[{c=mblCensus[F,z],refl=False,ups,dns,den,zpart,rest,bb,aa,cc,cz,others,crs,crT,out={}},
  ups=mblExpand2[c["upN"]];dns=mblExpand2[c["dnN"]];
  Which[
    Length[ups]==3&&Length[dns]==2&&Length[c["upD"]]==1&&c["dnD"]==={}&&c["other"]==={},den=c["upD"][[1,1]],
    Length[ups]==2&&Length[dns]==3&&Length[c["dnD"]]==1&&c["upD"]==={}&&c["other"]==={},refl=True;den=c["dnD"][[1,1]],
    True,gbRefuse["no 3+2 over 1 pattern in "<>ToString[z]<>" (census "<>ToString[Length/@{ups,dns,c["upD"],c["dnD"],c["other"]}]<>")"]];
  zpart=Times@@(Gamma/@Join[ups,dns])/Gamma[den];
  rest=Cancel[Together[F/zpart]];
  If[!FreeQ[rest,z],gbRefuse["non-Gamma dependence on "<>ToString[z]<>" outside the lemma kernel: "<>ToString[Short[rest,3],InputForm]]];
  If[refl,{ups,dns}={(Expand[#/.z->-z])&/@dns,(Expand[#/.z->-z])&/@ups};den=Expand[den/.z->-z];zpart=zpart/.z->-z];
  bb=(Expand[#/.z->0])&/@ups;aa=(Expand[#/.z->0])&/@dns;cc=Expand[den/.z->0];
  cz=If[refl,-(z/.ctr),z/.ctr];
  others=DeleteCases[ctr,z->_];
  (* the crossing census and the residues once per fold orientation (independent of b3) *)
  crs=gbCrossings[zpart,z,cz,Thread[Keys[others]->(Rationalize[#,0]&/@Values[others])]];
  crT=Table[cr[[1]]*Residue[zpart,{z,cr[[2]]}],{cr,crs}];
  Do[Module[{b3=bb[[b3i]],rests=Delete[bb,b3i],b1,b2,pref,up,lo},
      b1=rests[[1]];b2=rests[[2]];
      pref=Gamma[aa[[1]]+b1]Gamma[aa[[2]]+b1]Gamma[aa[[1]]+b2]Gamma[aa[[2]]+b2]Gamma[aa[[1]]+b3]Gamma[aa[[2]]+b3]/
           (Gamma[aa[[1]]+aa[[2]]+b1+b3]Gamma[aa[[1]]+aa[[2]]+b2+b3]Gamma[cc-b3]);
      up=Expand/@{aa[[1]]+b3,aa[[2]]+b3,aa[[1]]+aa[[2]]+b1+b2+b3-cc};lo=Expand/@{aa[[1]]+aa[[2]]+b1+b3,aa[[1]]+aa[[2]]+b2+b3};
      AppendTo[out,<|"z"->z,"cz"->cz,"ZPart"->zpart,"Rest"->rest,"Pref"->pref,"Up"->up,"Lo"->lo,"Cross"->(rest*#&/@crT),"Crossings"->crs,
        "b3"->b3,"b3Index"->b3i,"Excess"->Simplify[cc-b3],"Reflected"->refl|>]],{b3i,3}];
  out];
(* the numerical A-gate of a plan at two complex spectator points *)
gbPlanGate[pl_,ctr_List]:=Module[{z,cz,others,pts,BG,crT,gates},
  (* sequential: a Module initializer cannot use another initializer of the same Module (others would have read the OUTER z) *)
  z=pl["z"];cz=pl["cz"];others=DeleteCases[ctr,z->_];
  pts={Table[others[[k,1]]->Rationalize[others[[k,2]],0]+I (2k-1)/7,{k,Length[others]}],Table[others[[k,1]]->Rationalize[others[[k,2]],0]+I (2k+1)/5,{k,Length[others]}]};
  BG=pl["Pref"] HypergeometricPFQ[pl["Up"],pl["Lo"],1];
  crT=Table[cr[[1]]*Residue[pl["ZPart"],{z,cr[[2]]}],{cr,pl["Crossings"]}];
  gates=Table[Module[{A,BC},
      A=Quiet@NIntegrate[(pl["ZPart"]/.pt)/.z->cz+I Global`gbtq,{Global`gbtq,-Infinity,Infinity},WorkingPrecision->30,PrecisionGoal->12,MaxRecursion->16]/(2 Pi);
      BC=Quiet@N[(BG+Total[crT])/.pt,25];
      <|"A"->A,"BC"->BC,"Pass"->TrueQ[NumericQ[A]&&NumericQ[BC]&&Abs[A-BC]<10^-9 (1+Abs[A])]|>],{pt,pts}];
  <|"Pass"->AllTrue[gates,#["Pass"]&],"Gates"->gates|>];
(* ---------- the 3F2 classifier on the RAW parameter lists ---------- *)
gbClassify[up0_List,lo0_List,w_]:=Catch[Module[{up=Expand/@up0,lo=Expand/@lo0,su,sl,iu,il},
  (* Throw, not Return[.., Module]: a Return inside the inner Modules below would leave only that Module (the return-in-inner-module trap) *)
  If[Length[up]=!=3||Length[lo]=!=2||!AllTrue[Join[up,lo],gbAffineQ[#,{w}]&],Throw[$Failed,"gbcls"]];
  su=Coefficient[#,w]&/@up;sl=Coefficient[#,w]&/@lo;
  iu=Flatten@Position[su,x_/;x=!=0,{1},Heads->False];il=Flatten@Position[sl,x_/;x=!=0,{1},Heads->False];
  (* pattern A: both lower parameters carry the same slope and differ by 1/2; exactly one upper parameter carries twice that slope *)
  If[Length[iu]==1&&Length[il]==2&&sl[[1]]===sl[[2]]&&su[[iu[[1]]]]===2 sl[[1]]&&MemberQ[{1/2,-1/2},Expand[lo[[2]]-lo[[1]]]],
    Module[{U=up[[iu[[1]]]],pq=Delete[up,iu[[1]]],sig=su[[iu[[1]]]],cc,bet,lo1,r},
      lo1=If[Expand[lo[[2]]-lo[[1]]]===1/2,lo[[1]],lo[[2]]];     (* the lower member of the pair, by its offset *)
      cc=Expand[U-sig w];bet=Expand[2 lo1-sig w];
      If[FreeQ[bet,w]&&MemberQ[{1,-1},sig]&&FreeQ[cc,w],
        r=Expand[bet-cc];
        Throw[<|"Pattern"->"A","p"->pq[[1]],"q"->pq[[2]],"r"->r,"h"->r,"U"->U,"sigma"->sig,"c"->cc,"beta"->bet|>,"gbcls"]]]];
  (* pattern B: one upper U and one lower U + m (m a positive integer), the other three free of w *)
  If[Length[iu]==1&&Length[il]==1&&su[[iu[[1]]]]===sl[[il[[1]]]]&&MemberQ[{1,-1},su[[iu[[1]]]]],
    Module[{U=up[[iu[[1]]]],pq=Delete[up,iu[[1]]],r=Delete[lo,il[[1]]][[1]],m=Expand[lo[[il[[1]]]]-up[[iu[[1]]]]],sig=su[[iu[[1]]]]},
      If[IntegerQ[m]&&m>0,
        Throw[<|"Pattern"->"B","p"->pq[[1]],"q"->pq[[2]],"r"->r,"h"->m,"U"->U,"sigma"->sig,"c"->Expand[U-sig w],"m"->m|>,"gbcls"]]]];
  $Failed],"gbcls"];
(* the Beta constant C(w) = Gamma(U+h)/(Gamma(U)Gamma(h)) = (U)_h/Gamma(h) for a positive integer h (no Gamma/Gamma singularity) *)
gbC[cls_]:=With[{U=cls["U"],h=cls["h"]},If[IntegerQ[h]&&h>=1,FunctionExpand[Pochhammer[U,h]]/Gamma[h],Gamma[U+h]/(Gamma[U]Gamma[h])]];
gbTerminatingQ[cls_]:=(IntegerQ[cls["p"]]&&cls["p"]<=0)||(IntegerQ[cls["q"]]&&cls["q"]<=0);
(* ---------- the Euler kernel 2F1(p,q;r;y) in closed form: positive integers by exact partial fractions,
   terminating cases as polynomials; the exact identity and a numerical check ---------- *)
gbKernel[p_,q_,r_,y_]:=Module[{n,R,pol,res,K,chk},
  If[!(IntegerQ[p]&&IntegerQ[q]&&IntegerQ[r]&&r>=1),Return[$Failed,Module]];
  If[p<=0||q<=0,Return[Expand[Sum[Pochhammer[p,n]Pochhammer[q,n]/(n! Pochhammer[r,n]) y^n,{n,0,Min[-Select[{p,q},#<=0&]]}]],Module]];
  R=Cancel[Factorial[r-1]/(Factorial[p-1]Factorial[q-1]) Product[n+k,{k,1,p-1}]Product[n+k,{k,1,q-1}]/Product[n+k,{k,1,r-1}]];
  pol=PolynomialQuotient[Numerator[R],Denominator[R],n];
  res=Table[Limit[(n+j) R,n->-j],{j,1,r-1}];
  If[Together[R-pol-Sum[res[[j]]/(n+j),{j,1,r-1}]]=!=0,Return[$Failed,Module]];
  K=If[pol===0,0,Sum[Coefficient[pol,n,k] Nest[y D[#,y]&,1/(1-y),k],{k,0,Exponent[pol,n]}]]+Sum[res[[j]] y^-j (-Log[1-y]-Sum[y^k/k,{k,1,j-1}]),{j,1,r-1}];
  K=Together[K];
  chk=Table[Abs[N[(K-Hypergeometric2F1[p,q,r,y])/.y->yy,30]],{yy,{1/3,-2/3,1/5}}];
  If[!AllTrue[chk,#<10^-20&],Return[$Failed,Module]];
  K];
(* the Taylor coefficients of phi(x) = (1-x)^(h-1) K(scale x (1-x)^extra) at x = 0, algebraically (no removable singularities) *)
gbPhiCoefficient[cls_,j_Integer]:=Module[{p=cls["p"],q=cls["q"],r=cls["r"],h=cls["h"],scale,extra,n},
  {scale,extra}=If[cls["Pattern"]==="A",{4,1},{1,0}];
  Sum[Pochhammer[p,n]Pochhammer[q,n] scale^n/(n! Pochhammer[r,n]) (-1)^(j-n) Binomial[h-1+extra n,j-n],{n,0,j}]];
gbPhi[cls_,x_]:=Module[{K},
  K=gbKernel[cls["p"],cls["q"],cls["r"],Global`gby];
  If[K===$Failed,gbRefuse["Euler kernel outside the integer class: 2F1"<>ToString[{cls["p"],cls["q"],cls["r"]},InputForm]]];
  If[cls["Pattern"]==="A",(1-x)^(cls["h"]-1) (K/.Global`gby->4 x (1-x)),(1-x)^(cls["h"]-1) (K/.Global`gby->x)]];
gbSubtractionN[cls_,cw_]:=Module[{u0=Re[Rationalize[cls["sigma"] cw+cls["c"],0]]},
  If[!NumericQ[u0],gbRefuse["cannot determine Re(U) on the contour"]];
  Max[0,Floor[-u0]+1]];
(* the hypergeometric representation gated against the 3F2 at a complex w point *)
gbHGate[cls_,up_,lo_,w_,wpt_,phi_,Tpoly_,nN_,x_]:=Module[{h,rep,U=cls["U"]/.w->wpt,C=gbC[cls]/.w->wpt,integ},
  h=Quiet@N[HypergeometricPFQ[up/.w->wpt,lo/.w->wpt,1],25];
  integ=Quiet@NIntegrate[(x^(U-1) (phi-Tpoly))/.x->Global`gbx,{Global`gbx,0,1/2,1},WorkingPrecision->30,PrecisionGoal->14,MaxRecursion->30];
  rep=C (Sum[gbPhiCoefficient[cls,j]/(U+j),{j,0,nN-1}]+integ);
  <|"H"->h,"Rep"->rep,"Pass"->TrueQ[NumericQ[h]&&NumericQ[rep]&&Abs[h-rep]<10^-9 (1+Abs[h])]|>];
(* ---------- Legendre duplication run backwards on w-dependent pairs Gamma(x)Gamma(x+1/2) of HALF slope and the same
   orientation (restoring unit slopes); a surviving spectator-dependent scale refuses ---------- *)
gbLegendreBack[M_,w_]:=Module[{fs=gbFactors[Together[M]],cnt=<||>,rest=1,changed=True,out,scale},
  Do[Which[MatchQ[t,Gamma[_]],cnt[Expand[t[[1]]]]=Lookup[cnt,Expand[t[[1]]],0]+1,
      MatchQ[t,Power[Gamma[_],_Integer]],cnt[Expand[t[[1,1]]]]=Lookup[cnt,Expand[t[[1,1]]],0]+t[[2]],
      True,rest*=t],{t,fs}];
  While[changed,changed=False;
    Do[With[{a2=Expand[a+1/2]},
        If[!changed&&MemberQ[{1/2,-1/2},Coefficient[a,w]]&&Lookup[cnt,a,0]=!=0&&Lookup[cnt,a2,0]=!=0&&Sign[cnt[a]]===Sign[cnt[a2]],
          With[{s=Sign[cnt[a]]},cnt[a]-=s;cnt[a2]-=s;cnt[Expand[2 a]]=Lookup[cnt,Expand[2 a],0]+s;rest*=(2^(1-2 a) Sqrt[Pi])^s;changed=True]]],{a,Keys[cnt]}]];
  rest=PowerExpand[rest,Assumptions->True]/.Power[b_?NumericQ,e_]:>Power[b,Expand[e]];
  rest=Together[rest];
  (* phase 2 (12:5x, MB8au r43 piece 79, crossing with 1/Gamma(2w)): a residual 2^(c w) is cancelled by recombining a pair of
     ANY slope k whose duplication factor (2^(1-2a) Sqrt[Pi])^s carries the opposite exponent, s k = c/2 (a unit-slope
     denominator pair gives 2^(2w-1)/Gamma(2w): the slope-two Beta denominator the one-fold closers take) *)
  Module[{resid,pair,guard=0},
    resid[]:=Module[{e2=Cases[rest,HoldPattern[Power[2,e_]]/;!FreeQ[e,w]:>e,{0,Infinity}]},If[e2==={},0,Coefficient[Expand[Total[e2]],w]]];
    While[resid[]=!=0&&guard++<8,
      pair=SelectFirst[Keys[cnt],Function[a,With[{a2=Expand[a+1/2],k=Coefficient[a,w]},k=!=0&&Lookup[cnt,a,0]=!=0&&Lookup[cnt,a2,0]=!=0&&Sign[cnt[a]]===Sign[cnt[a2]]&&Sign[cnt[a]] k===resid[]/2]],None];
      If[pair=!=None,
        With[{a=pair,a2=Expand[pair+1/2],s=Sign[cnt[pair]]},cnt[a]-=s;cnt[a2]-=s;cnt[Expand[2 a]]=Lookup[cnt,Expand[2 a],0]+s;rest*=(2^(1-2 a) Sqrt[Pi])^s],
        (* a SINGLE leg Gamma(y)^s with s k = c/2 through the duplication Gamma(y) = 2^(1-2y) Sqrt[Pi] Gamma(2y)/Gamma(y+1/2)
           (MB8au r43 piece 79, crossing 1: the denominator leg Gamma(1/2+w) -> Gamma(1+w)/(2^(-2w) Sqrt[Pi] Gamma(1+2w)),
           the slope-two denominator the one-fold closers take); a leg whose partner y+1/2 already exists is preferred *)
        Module[{singles=Select[Keys[cnt],Function[y,With[{k=Coefficient[y,w]},k=!=0&&Lookup[cnt,y,0]=!=0&&Sign[cnt[y]] k===resid[]/2]]],y},
          If[singles==={},Break[]];
          y=SelectFirst[singles,Lookup[cnt,Expand[#+1/2],0]=!=0&,First[singles]];
          With[{s=Sign[cnt[y]]},cnt[y]-=s;cnt[Expand[2 y]]=Lookup[cnt,Expand[2 y],0]+s;cnt[Expand[y+1/2]]=Lookup[cnt,Expand[y+1/2],0]-s;rest*=(2^(1-2 y) Sqrt[Pi])^s]]];
      rest=Together[PowerExpand[rest,Assumptions->True]/.Power[b_?NumericQ,e_]:>Power[b,Expand[e]]]]];
  scale=Cases[rest,HoldPattern[Power[b_?NumericQ,e_]]/;!FreeQ[e,w],{0,Infinity}];
  If[scale=!={},gbRefuse["a spectator-dependent scale "<>ToString[scale,InputForm]<>" survives the Legendre normalization (the tower would be J(lambda x))"]];
  out=rest Times@@(Gamma[#]^cnt[#]&/@Keys[Select[cnt,#=!=0&]]);
  out];
(* ---------- one-fold pieces (counterterms, crossings, copy coefficients): the ordinary chain ---------- *)
If[!AssociationQ[gbOneFoldMemo],gbOneFoldMemo=<||>];
gbOneFold[F_,ctr_,tag_,budget_]:=Module[{r,t0=AbsoluteTime[],Fc=Cancel[Together[F]],key},
  If[DownValues[ladClosePiece]==={},gbRefuse["one-fold chain (ladClosePiece) not loaded"]];
  key=Hash[{Fc,Sort[Normal[ctr]]},"SHA256","HexString"];
  If[KeyExistsQ[gbOneFoldMemo,key],gbP["one-fold ",tag," served from the session memo: ",N[gbOneFoldMemo[key],12]];Return[gbOneFoldMemo[key],Module]];
  r=Block[{ladPieceSec=Min[ladPieceSec,Max[30,budget]]},ladClosePiece[Fc,ctr,tag]];
  If[!AssociationQ[r]||!ladExactQ[r["Value"]],gbRefuse["one-fold "<>ToString[tag]<>" ("<>ToString[Short[F,3],InputForm]<>"): "<>If[FailureQ[r],r["Reason"],"inexact"]]];
  gbP["one-fold ",tag," closed by ",r["Method"]," in ",Round[AbsoluteTime[]-t0]," s: ",N[r["Value"],12]];
  gbOneFoldMemo[key]=r["Value"];
  r["Value"]];
(* ---------- the pullback of a word G(a; x), letters in {0,1}, at x = 1/2 + s t (s = -+1/2): exact constants at 1/2 ---------- *)
gbConstHalf[{}]:=1;
gbConstHalf[word_List]:=Module[{xh,e},
  e=Expand[PolyLogTools`ExtractZeroes[PolyLogTools`G@@Append[word,xh]]];
  e=e/.HoldPattern[PolyLogTools`G[zs:0..,xh]]:>Log[xh]^Length[{zs}]/Factorial[Length[{zs}]];
  e=e/.(HoldPattern[PolyLogTools`G[aa__,xh]]/;Last[{aa}]=!=0):>(PolyLogTools`G@@Append[2 {aa},1]);
  Global`mbeCanonicalConstants[Expand[e/.xh->1/2]]];
gbPullWord[word_List,s_,t_]:=Module[{n=Length[word]},
  Sum[(If[k==0,1,PolyLogTools`G@@Append[(word[[1;;k]]-1/2)/s,t]]) gbConstHalf[word[[k+1;;n]]],{k,0,n}]];
gbFoldHalf[e_,x_,t_,s_]:=Module[{f,bad},
  (* s = -1/2: x = (1-t)/2; s = +1/2: x = (1+t)/2 *)
  f=Expand[e];
  f=f/.HoldPattern[PolyLogTools`G[ww__,x]]:>gbPullWord[{ww},s,t];
  f=f/.{Log[x]->(If[s<0,PolyLogTools`G[1,t],PolyLogTools`G[-1,t]]-Log[2]),Log[1-x]->(If[s<0,PolyLogTools`G[-1,t],PolyLogTools`G[1,t]]-Log[2])};
  f=f/.Log[a_]/;!FreeQ[a,x]:>Module[{q=Factor[a/.x->1/2+s t]},Which[MatchQ[q,t^2]||MatchQ[q,(-t)^2],2 PolyLogTools`G[0,t],MatchQ[q,_?NumericQ t^2],Log[q/t^2]+2 PolyLogTools`G[0,t],True,gbRefuse["logarithm "<>ToString[a,InputForm]<>" not of the kernel form after the fold"]]];
  f=f/.x->1/2+s t;
  (* postcondition: every t-dependent transcendental is a PolyLogTools word with the endpoint t and t-free letters *)
  bad=Cases[f,g:(Log|PolyLog|HPL`HPL|HyperFLINT`Hlog)[___,a_]/;!FreeQ[a,t]:>g,{0,Infinity}];
  bad=Join[bad,Cases[f,g:PolyLogTools`G[___]/;!FreeQ[g,t]&&(Last[List@@g]=!=t||!FreeQ[Most[List@@g],t]):>g,{0,Infinity}]];
  If[bad=!={},gbRefuse["t-dependence outside the word class after the fold: "<>ToString[Short[bad,3],InputForm]]];
  Expand[f]];
(* ---------- the remainder: J(x) by the Mellin tower, the folded exact last fold ---------- *)
(* dreg: a copy regulator (the symbol ep of the closers) carried by M(w): the tower is expanded to first order in it and
   the d^1 coefficient is the dressed J(x) (only the subsequent w-tower needs a regulator jet) *)
gbRemainder[M_,w_,cw_,cls_,phiT_,x_,budget_,dreg_:None]:=Module[{sig=cls["sigma"],Mn,cwn,Y=Global`gbY,J,integ,fl,fu,integT,t=Global`gbt,gnum,chk,val,t0=AbsoluteTime[],left,dep=If[dreg===None,0,1]},
  left:=budget-(AbsoluteTime[]-t0);
  If[!s2LastFoldLoadedQ[],gbRefuse["exact last-fold rung not loaded"]];
  (* orientation: the scale x^(sigma w) -> x^w by w -> -w for sigma = -1 (Jacobian one, Re w -> -Re w) *)
  {Mn,cwn}=If[sig===1,{M,cw},{M/.w->-w,-cw}];
  (* the tower's coincident legs are split by nu*ep (s2NormalizeInner), the SAME symbol as a copy regulator dreg = ep: the
     ep^1 coefficient then carries the split's derivative S besides the wanted kappa*X.  Two samples of the copy, kappa = 1
     and 2 (M depends on dreg only through the copy): X = J1(kappa=2) - J1(kappa=1) (s2PieceClose's rule) *)
  If[dreg===None,
    Mn=s2NormalizeInner[Together[Mn],w,1/7];
    J=Catch[gbTC[s2ItemLaurent[Mn Y^w,{w->cwn},w,Y,0,0,0<Y<1,{{1/7},{1/5}}],left],"s2t"];
    If[FailureQ[J]||!ListQ[J]||Length[J]=!=1,gbRefuse["Mellin tower of M(w): "<>If[FailureQ[J],J["Reason"],ToString[Short[J,3]]]]];
    J=Expand[J[[1]]/.Y->x],
    Module[{Js,pts={1/5,3/10}},
      (* the regulator must enter M only through the copy (the Euler kernel's legs, the weight and the subtraction data are
         regulator-free): otherwise the rescaling M(kappa d) misses product-rule terms *)
      If[!FreeQ[{cls,phiT},dreg],gbRefuse["Mellin tower: the Euler kernel data depend on the copy regulator"]];
      Js=Table[Module[{Mk=s2NormalizeInner[Together[Mn/.dreg->kap dreg],w,1/7],Jk},
          Jk=Catch[gbTC[s2ItemLaurent[Mk Y^w,{w->cwn},w,Y,0,1,0<Y<1,{{1/7},{1/5}}],left],"s2t"];
          If[FailureQ[Jk]||!ListQ[Jk]||Length[Jk]=!=2,gbRefuse["Mellin tower of M(w) at copy sample kappa = "<>ToString[kap]<>": "<>If[FailureQ[Jk],Jk["Reason"],ToString[Short[Jk,3]]]]];
          Jk],{kap,{1,2,3}}];
      (* the ep^0 parts must agree at two scales (the undressed tower), the ep^1 parts must be AFFINE in kappa
         (J1(kappa) = S + kappa X, checked by the second difference at two scales) *)
      Do[Module[{a0=gbNum[Js[[1,1]]/.Y->pt],b0=gbNum[Js[[2,1]]/.Y->pt],c0=gbNum[Js[[3,1]]/.Y->pt],a1,b1,c1},
          If[!TrueQ[NumericQ[a0]&&NumericQ[b0]&&NumericQ[c0]&&Abs[a0-b0]<10^-15 Max[1,Abs[a0]]&&Abs[a0-c0]<10^-15 Max[1,Abs[a0]]],gbRefuse["Mellin tower: the copy samples disagree at order 0"]];
          {a1,b1,c1}=gbNum[#/.Y->pt]&/@{Js[[1,2]],Js[[2,2]],Js[[3,2]]};
          If[!TrueQ[NumericQ[a1]&&NumericQ[b1]&&NumericQ[c1]&&Abs[(c1-b1)-(b1-a1)]<10^-15 Max[1,Abs[b1-a1]]],gbRefuse["Mellin tower: order 1 not affine in the copy multiple"]]],{pt,pts}];
      J=Expand[(Js[[2,2]]-Js[[1,2]])/.Y->x];
      gbP["J1(x) from the copy samples kappa = 1, 2 (kappa = 3: affine check at two scales)"]]];
  If[!FreeQ[J,ladEp],gbRefuse["the tower left the regulator in J(x)"]];
  (* normalization: words at the endpoint x with fixed letters (fibration in x), head fix *)
  J=s2Fib[J,x];
  If[J===$Failed||!FreeQ[J,PolyLogTools`ToFibrationBasis],gbRefuse["J(x): fibration in x refused"]];
  J=Expand[J];
  If[!FreeQ[J,(PolyLog|HPL`HPL)[___,a_]/;!FreeQ[a,x]],gbRefuse["J(x) outside the word class after the fibration"]];
  gbP["J(x) closed in ",Round[AbsoluteTime[]-t0]," s (",LeafCount[J]," leaves, letters ",DeleteDuplicates[Flatten[Cases[J,PolyLogTools`G[ww__,x]:>{ww},{0,Infinity}]]],")"];
  integ=Expand[x^(cls["c"]-1) phiT J];
  gnum=s2Gnum;
  Which[
    cls["Pattern"]==="A",
      fl=gbFoldHalf[integ,x,t,-1/2];fu=gbFoldHalf[integ,x,t,1/2];
      MBExactLastFold`mbeLastFoldFibrate[0,t,1/2];MBExactLastFold`Private`gatePts={3/10,7/10};Clear[s2BackN];
      (* each half gated separately at two points *)
      Do[chk={gnum[integ/.x->1/2+ss tt],gnum[If[ss<0,fl,fu]/.t->tt]};
        If[!(NumericQ[chk[[1]]]&&NumericQ[chk[[2]]]&&Abs[chk[[1]]-chk[[2]]]<10^-12 Max[1,Abs[chk[[1]]]]),gbRefuse["fold conversion gate (s = "<>ToString[ss]<>", t = "<>ToString[tt]<>"): "<>ToString[N[chk,12]]]],
        {ss,{-1/2,1/2}},{tt,{2/5,1/7}}];
      integT=Expand[(fl+fu)/2]/.Log[t]->PolyLogTools`G[0,t];
      gbP["folded integrand ",LeafCount[integT]," leaves, both halves gated at two points"];
      val=Catch[gbTC[s2LFIntegrate[integT,t,gnum],left],"s2o"],
    True,
      integT=Expand[integ/.Log[x]->PolyLogTools`G[0,x]/.Log[1-x]->PolyLogTools`G[1,x]];
      MBExactLastFold`mbeLastFoldFibrate[0,x,1/2];MBExactLastFold`Private`gatePts={3/10,7/10};Clear[s2BackN];
      val=Catch[gbTC[s2LFIntegrate[integT,x,gnum],left],"s2o"]];
  If[FailureQ[val],gbRefuse["exact last fold of the remainder: "<>val["Reason"]]];
  val=Global`mbeCanonicalConstants[Expand[val]];
  gbP["remainder closed in ",Round[AbsoluteTime[]-t0]," s: ",N[val,16]];
  val];
(* a one-fold spectator piece (counterterm, crossing); with a copy regulator dreg its d^1 coefficient is closed: the piece
   must be analytic at d = 0 on its contour (no pole), its first-order expansion gives psi-dressed eps-free pieces *)
gbSpectatorPiece[P_,ctr1_,tag_,budget_,dreg_]:=Module[{ser,P1,mons,val=0,k=0},
  If[dreg===None,Return[gbOneFold[P,ctr1,tag,budget],Module]];
  If[FreeQ[P,dreg],Return[0,Module]];
  If[!gbStableQ[P,ctr1,dreg,-1/40],gbRefuse[tag<>": a numerator pole meets the contour for the copy regulator in [-1/40, 0]"]];
  ser=Quiet@Series[P,{dreg,0,1}];
  If[Head[ser]=!=SeriesData,gbRefuse[tag<>": no series in the copy regulator"]];
  If[ser[[4]]/ser[[6]]<0,gbRefuse[tag<>": a pole in the copy regulator (the spectator route needs analytic pieces)"]];
  P1=Expand[SeriesCoefficient[ser,1]];
  If[P1===0,Return[0,Module]];
  mons=If[Head[P1]===Plus,List@@P1,{P1}];
  Do[Module[{cz,mz},cz=Times@@Select[gbFactors[m],FreeQ[#,Alternatives@@Keys[ctr1]]&];mz=Cancel[Together[m/cz]];
      k++;val+=cz gbOneFold[mz,ctr1,tag<>"/"<>ToString[k],budget]],{m,mons}];
  val];
(* ---------- the Euler-kernel closer of a pure Gamma x rational two-fold (optionally dressed by a Gamma COPY of the spectator
   whose regulator jet is taken on the spectator pieces and the tower): plans first, then ranked execution, every plan
   gated by the two-fold quadrature (qref: the quadrature of the DRESSED kernel when a copy regulator is present) ---------- *)
gbPlanRank[pl_]:={Switch[pl["Class"]["Pattern"],"B",0,"A",1,_,2],pl["N"],Length[pl["Crossings"]],pl["FoldIndex"],pl["b3Index"]};
gbEulerCore[F_,ctr_List,budget_,dreg_:None,qref_:Automatic]:=Module[{t0=AbsoluteTime[],reasons={},left,plans={},q,x=Global`gbx},
  left:=budget-(AbsoluteTime[]-t0);
  (* 1. the symbolic plans *)
  Do[Module[{z=Keys[ctr][[fi]],w,cw,Fz,pls},
      w=First[DeleteCases[Keys[ctr],z]];cw=Rationalize[w/.ctr,0];
      pls=Catch[Fz=gbGaussZ[F,z,Keys[ctr],If[dreg===None,{},{dreg->1/97}]];gbBarnesGenPlans[Fz,z,ctr],"gb2"];
      If[FailureQ[pls],AppendTo[reasons,ToString[z]<>" first: "<>pls["Reason"]];Continue[]];
      Do[Module[{cls=gbClassify[pl["Up"],pl["Lo"],w],nN},
          If[cls===$Failed,AppendTo[reasons,ToString[z]<>"/b3="<>ToString[pl["b3"],InputForm]<>": 3F2 outside the patterns A/B"];Continue[]];
          nN=Catch[gbSubtractionN[cls,cw],"gb2"];
          If[FailureQ[nN],AppendTo[reasons,nN["Reason"]];Continue[]];
          AppendTo[plans,Join[pl,<|"w"->w,"cw"->cw,"Class"->cls,"N"->nN,"FoldIndex"->fi|>]]],{pl,pls}]],{fi,Length[ctr]}];
  If[plans==={},Return[Failure["GB2",<|"Reason"->StringRiffle[reasons," | "]|>],Module]];
  plans=SortBy[plans,gbPlanRank];
  gbP[Length[plans]," admitted plan(s): ",({#["z"],#["b3"],#["Class"]["Pattern"],#["N"],Length[#["Crossings"]]}&/@plans)];
  q=If[qref===Automatic,ladQuad[F,ctr],qref];
  If[!NumericQ[q],Return[Failure["GB2",<|"Reason"->"two-fold quadrature of the piece unavailable"|>],Module]];
  (* 2. ranked execution (the first plan that passes every gate is the value: Throw/Catch, since Return[.., Module]
        inside the Do body's Module would leave only that Module -- the return-in-inner-module trap) *)
  Catch[Do[Module[{z=pl["z"],w=pl["w"],cw=pl["cw"],cls=pl["Class"],nN=pl["N"],res},
      res=Catch[Module[{gt,phi,Tpoly,hg,M,counter=0,cross=0,rem,total,k=0},
          If[left<60,gbRefuse["budget spent"]];
          gt=gbPlanGate[pl,ctr];
          If[!gt["Pass"],gbRefuse["generalized-lemma gate: "<>ToString[N[{#["A"],#["BC"]}&/@gt["Gates"],8]]]];
          gbP["plan ",z,"/b3=",InputForm[pl["b3"]],": lemma gated at two complex points; pattern ",cls["Pattern"],", p,q,r = ",InputForm[{cls["p"],cls["q"],cls["r"]}],", U = ",InputForm[cls["U"]],", h = ",cls["h"],", N = ",nN];
          phi=gbPhi[cls,x];
          If[!gbTerminatingQ[cls],
            If[cls["Pattern"]==="A"&&!TrueQ[cls["r"]-cls["p"]-cls["q"]>=0],gbRefuse["interior singularity not integrable (r < p + q); the denominator-raising repair is not implemented"]];
            If[cls["Pattern"]==="B"&&!TrueQ[cls["r"]-cls["p"]-cls["q"]+cls["m"]>0],gbRefuse["endpoint x = 1 not integrable"]]];
          Tpoly=Sum[gbPhiCoefficient[cls,j] x^j,{j,0,nN-1}];
          hg=Table[gbHGate[cls,pl["Up"],pl["Lo"],w,cw+I qq,phi,Tpoly,nN,x],{qq,{1/7,2/5}}];
          If[!AllTrue[hg,#["Pass"]&],gbRefuse["Euler representation gate against the 3F2: "<>ToString[N[{#["H"],#["Rep"]}&/@hg,10]]]];
          gbP["Euler representation gated at two complex points"];
          M=gbLegendreBack[pl["Rest"] pl["Pref"] gbC[cls],w];
          Do[With[{pj=gbPhiCoefficient[cls,j]},If[pj=!=0,k++;counter+=pj gbSpectatorPiece[M/(cls["U"]+j),{w->cw},"ct"<>ToString[j],Min[900,left],dreg]]],{j,0,nN-1}];
          Do[k++;cross+=gbSpectatorPiece[gbLegendreBack[cr,w],{w->cw},"cross"<>ToString[k],Min[900,left],dreg],{cr,pl["Cross"]}];
          rem=gbRemainder[M,w,cw,cls,Expand[phi-Tpoly],x,left,dreg];
          total=Global`mbeCanonicalConstants[Expand[counter+cross+rem]];
          If[!gbGateQ[total,q,2],gbRefuse["two-fold gate "<>ToString[N[total,15]]<>" vs quadrature "<>ToString[N[q,15]]]];
          <|"Value"->total,"Quad"->q,"Method"->"generalized Barnes in "<>ToString[z]<>" -> Euler kernel (pattern "<>cls["Pattern"]<>") -> Mellin tower in "<>ToString[w]<>" -> exact last fold","Parts"-><|"Counter"->counter,"Cross"->cross,"Remainder"->rem|>|>],"gb2"];
      If[AssociationQ[res],Throw[res,"gbplan"]];
      AppendTo[reasons,ToString[z]<>"/b3="<>ToString[pl["b3"],InputForm]<>": "<>res["Reason"]];gbP["plan refused: ",res["Reason"]]],{pl,plans}];
    Failure["GB2",<|"Reason"->StringRiffle[reasons," | "]|>],"gbplan"]];
(* ---------- pure Gamma x rational two-fold: iterated 2+2 first (gated), then the Euler-kernel closer (gated inside) ---------- *)
(* ---------- pieces of ANY fold count (1 October 2026, 12:0x): one-folds by the ordinary chain, two-folds by the
   Euler-kernel closer, more folds by a finite Barnes lemma (first, second, collapsed generalized; eps-free, A-gated) in
   one variable and recursion on the (n-1)-fold terms.  Session memo of closed sub-pieces (the same kernels recur). ---------- *)
If[!AssociationQ[gbMultiMemo],gbMultiMemo=<||>];
If[!ValueQ[gbCopyLadderQ],gbCopyLadderQ=True];
gbCoeffClose[G_,ctr_,tag_,budget_]:=If[Length[ctr]==1,gbOneFold[G,ctr,tag,budget],
  Module[{r=gbMultiFold[G,ctr,budget]},
    If[!AssociationQ[r],gbRefuse["sub-piece "<>ToString[tag]<>" ("<>ToString[Length[ctr]]<>" folds): "<>r["Reason"]]];
    gbP["sub-piece ",tag," (",Length[ctr]," folds) closed: ",N[r["Value"],12]];
    r["Value"]]];
(* one eps-free Barnes lemma in a variable of a pure Gamma x rational n-fold (n >= 3), then recursion *)
gbReduceFold[F_,ctr_List,budget_,tag_]:=Module[{t0=AbsoluteTime[],cands={},reasons={},left,res,ep=ladEp},
  left:=budget-(AbsoluteTime[]-t0);
  Do[Module[{r},
      r=Quiet@mblBarnes1[F,v,ctr,ep,-1/40];
      If[AssociationQ[r]&&FreeQ[r["Terms"],ComplexInfinity|Indeterminate|_DirectedInfinity],AppendTo[cands,{v,"first lemma",r["Terms"]}]];
      r=Quiet@mblBarnes2[F,v,ctr,ep,-1/40];
      If[AssociationQ[r]&&FreeQ[r["Terms"],ComplexInfinity|Indeterminate|_DirectedInfinity],AppendTo[cands,{v,"second lemma",r["Terms"]}]];
      r=Quiet@mblBarnesGen[F,v,ctr,ep,-1/40];
      If[AssociationQ[r]&&r["Gate"]=!="NoNum",With[{cl=Quiet@FunctionExpand[r["PFQ"]]},
          If[FreeQ[cl,HypergeometricPFQ]&&FreeQ[r["Terms"]/.r["PFQ"]->cl,ComplexInfinity|Indeterminate|_DirectedInfinity],AppendTo[cands,{v,"collapsed generalized lemma",r["Terms"]/.r["PFQ"]->cl}]]]]],{v,Keys[ctr]}];
  If[cands==={},gbRefuse[tag<>": no eps-free Barnes lemma in any variable of the "<>ToString[Length[ctr]]<>"-fold"]];
  Do[res=Catch[Module[{vRed=cd[[1]],terms=Select[cd[[3]],#=!=0&],c1,val=0,k=0},
        c1=DeleteCases[ctr,vRed->_];
        gbP[tag,": ",cd[[2]]," in ",vRed," -> ",Length[terms]," term(s) with ",Length[c1]," fold(s)"];
        Do[Module[{cz,mz},
            cz=Times@@Select[gbFactors[tm],FreeQ[#,Alternatives@@Keys[c1]]&];mz=Cancel[Together[tm/cz]];
            If[left<30,gbRefuse[tag<>": budget spent"]];
            k++;val+=cz gbCoeffClose[mz,c1,tag<>"/"<>ToString[k],left]],{tm,terms}];
        val],"gb2"];
    If[!FailureQ[res],Return[res,Module]];
    AppendTo[reasons,cd[[2]]<>" in "<>ToString[cd[[1]]]<>": "<>res["Reason"]];gbP[tag,": candidate refused: ",res["Reason"]],{cd,cands}];
  gbRefuse[tag<>": "<>StringRiffle[reasons," | "]]];
gbPureRat[F_,ctr_List,budget_,tag_]:=Module[{t0=AbsoluteTime[],r},
  r=Quiet@bnGated[F,ctr,Min[300,budget]];
  If[AssociationQ[r]&&ladExactQ[r["Value"]],gbP[tag,": iterated Barnes 2+2 closed form: ",N[r["Value"],12]];Return[r["Value"],Module]];
  gbP[tag,": bn refused (",If[FailureQ[r],r["Reason"],"?"],"); ",If[Length[ctr]==2,"Euler-kernel closer","one Barnes lemma and recursion"]];
  If[Length[ctr]>=3,Return[gbReduceFold[F,ctr,budget-(AbsoluteTime[]-t0),tag],Module]];
  r=gbEulerCore[F,ctr,budget-(AbsoluteTime[]-t0)];
  If[FailureQ[r],gbRefuse[tag<>": "<>r["Reason"]]];
  gbP[tag," closed: ",N[r["Value"],16]," (quadrature ",N[r["Quad"],12],")"];
  r["Value"]];
(* ---------- the psi split and the Gamma-copy part ---------- *)
gbPsiLegs[K_,L_,vs_]:=Module[{legs=DeleteDuplicates[Cases[gbFactors[K],(Gamma[a_]|Power[Gamma[a_],_Integer]):>Expand[a]]]},
  SortBy[Select[legs,IntegerQ[Expand[#-L]]&],Abs[Expand[#-L]]&]];
(* stability of a term on the regulator interval [d1, 0]: no numerator Gamma argument (after cancellation) meets a
   non-positive integer on the contour for d in between *)
gbStableQ[G_,ctr_,d_,d1_]:=Module[{g=Cancel[Together[G]],nums},
  nums=DeleteDuplicates[Cases[gbFactors[Numerator[g]],(Gamma[a_]|Power[Gamma[a_],_Integer?Positive]):>Expand[a]]];
  AllTrue[Select[nums,!FreeQ[#,Alternatives@@Keys[ctr]]&],Function[a,With[{r0=Re[(a/.ctr)/.d->0],r1=Re[(a/.ctr)/.d->d1]},NumericQ[r0]&&NumericQ[r1]&&gbNoNonposIntBetweenQ[r0,r1]]]]];
gbCopyPart[K_,Lleg_,ctr_List,budget_,sgn_]:=Module[{d=ladEp,d1=-1/40,Fd,t0=AbsoluteTime[],cands={},reasons={},left,res},
  left:=budget-(AbsoluteTime[]-t0);
  Fd=Cancel[Together[K Gamma[Lleg+d]/Gamma[Lleg]]];
  If[!AllTrue[Select[Cases[Fd,Gamma[a_]:>Expand[a],{0,Infinity}],!FreeQ[#,Alternatives@@Keys[ctr]]&],gbAffineQ[#/.d->0,Keys[ctr]]&],gbRefuse["copy part: a Gamma argument is not affine with real coefficients"]];
  (* every finite-d Barnes lemma in every variable is a candidate; tried in order until one closes *)
  Do[Module[{r},
      r=Quiet@mblBarnes1[Fd,v,ctr,d,d1];
      If[AssociationQ[r]&&FreeQ[r["Terms"],ComplexInfinity|Indeterminate|_DirectedInfinity],AppendTo[cands,{v,"first lemma",r["Terms"]}]];
      r=Quiet@mblBarnes2[Fd,v,ctr,d,d1];
      If[AssociationQ[r]&&FreeQ[r["Terms"],ComplexInfinity|Indeterminate|_DirectedInfinity],AppendTo[cands,{v,"second lemma",r["Terms"]}]];
      r=Quiet@mblBarnesGen[Fd,v,ctr,d,d1];
      If[AssociationQ[r]&&r["Gate"]=!="NoNum",With[{cl=Quiet@FunctionExpand[r["PFQ"]]},
          If[FreeQ[cl,HypergeometricPFQ]&&FreeQ[r["Terms"]/.r["PFQ"]->cl,ComplexInfinity|Indeterminate|_DirectedInfinity],AppendTo[cands,{v,"collapsed generalized lemma",r["Terms"]/.r["PFQ"]->cl}]]]]],{v,Keys[ctr]}];
  If[cands==={},gbRefuse["copy part: no finite-d Barnes lemma in any variable"]];
  Do[res=Catch[Module[{vRed=cd[[1]],terms=Select[cd[[3]],#=!=0&],c1,vs1,lau=<||>,lead=0,q0,k=0,val},
        c1=DeleteCases[ctr,vRed->_];vs1=Keys[c1];
        gbP["copy part: finite-d ",cd[[2]]," in ",vRed," -> ",Length[terms]," term(s) with ",Length[c1]," fold(s)"];
        Do[Module[{ser,l0,fam,lo},
            If[!gbStableQ[tm,c1,d,d1],gbRefuse["copy part: a term has a numerator pole on its contour for a regulator in ["<>ToString[d1]<>", 0]"]];
            If[FreeQ[tm,d],Module[{cz,mz},cz=Times@@Select[gbFactors[tm],FreeQ[#,Alternatives@@vs1]&];mz=Cancel[Together[tm/cz]];
                k++;lau[0]=Lookup[lau,0,0]+cz gbCoeffClose[mz,c1,"copy"<>ToString[k]<>"(const)",Min[1800,left]]];Continue[]];
            ser=Quiet@Series[tm,{d,0,1}];
            If[Head[ser]=!=SeriesData,gbRefuse["copy part: no Laurent series in d"]];
            l0=ser[[4]]/ser[[6]];lead=Min[lead,l0];
            (* 12:0x: a ONE-fold term at finite d first through the one-fold family ladder (exact towers in the regulator; the
               Laurent coefficients come at once, no degree-2 dressings); its truncated Laurent is sanity-checked against
               the term's quadrature at d = d1 (loose: the omitted d^2 term), the d^0 and d^1 SUMS are gated exactly below;
               a refusal falls back to the coefficient pieces *)
            If[Length[c1]==1&&TrueQ[gbCopyLadderQ]&&l0>=-3,
              lo=Min[0,l0];
              fam=Quiet@TimeConstrained[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[{MBint[tm,{{d->0},c1}]},d,lo,1,False],Min[600,left],$Aborted];
              If[ListQ[fam]&&Length[fam]==2-lo&&ladExactQ[fam]&&FreeQ[fam,d],
                Module[{qd=ladQuad[tm/.d->d1,c1],tr=Sum[fam[[kk-lo+1]] d1^kk,{kk,lo,1}]},
                  If[NumericQ[qd]&&NumericQ[N[tr,30]]&&Abs[N[tr,30]-qd]<10^-3 Max[1,Abs[qd]],
                    gbP["copy term closed by the one-fold ladder at finite d (orders ",lo,"..1; sanity ",N[Abs[N[tr,30]-qd],2],")"];
                    Do[lau[kk]=Lookup[lau,kk,0]+fam[[kk-lo+1]],{kk,lo,1}];Continue[],
                    gbP["copy term: ladder Laurent fails the finite-d sanity check (",N[tr,8]," vs ",If[NumericQ[qd],N[qd,8],qd],"); coefficient pieces"]]],
                gbP["copy term: ladder refused (",If[ListQ[fam],"inexact/incomplete",ToString[Short[fam,2]]],")"]]];
            (* 12:3x: a one-fold term with SLOPE-TWO legs: the slope-two closer's term-level Taylor coefficients at finite d
               (Beta triple, inner Mellin tower, exact outer fold) on the z-dependent factor G, times the Laurent series of the
               z-free prefactor Cz (the pole); I_0 and I_1 of G gated by one-dimensional quadratures; then the coefficient pieces *)
            If[Length[c1]==1&&DownValues[s2towerTaylor]=!={},
              Module[{Cz,G,serC,L,dep,tc,ok=False},
                Cz=Times@@Select[gbFactors[tm],FreeQ[#,Alternatives@@vs1]&];G=Cancel[Together[tm/Cz]];
                If[AnyTrue[Cases[G,Gamma[a_]:>a,{0,Infinity}],fcuS2Slope2Q[#,vs1]&],
                  serC=Quiet@Series[Cz,{d,0,4}];
                  L=If[Head[serC]===SeriesData,serC[[4]]/serC[[6]],0];dep=1-L;
                  If[dep>=0&&dep<=3,
                    tc=Quiet@TimeConstrained[s2towerTaylor[G,c1,dep],Min[1500,left],$Aborted];
                    If[ListQ[tc]&&Length[tc]==dep+1&&ladExactQ[tc]&&FreeQ[tc,d],
                      Module[{q0g=ladQuad[G/.d->0,c1],q1g=If[dep>=1,ladQuad[D[G,d]/.d->0,c1],0]},
                        ok=gbGateQ[tc[[1]],q0g,1]&&(dep==0||gbGateQ[tc[[2]],q1g,1]);
                        If[ok,gbP["copy term with slope-two legs closed by the slope-two Taylor closer at finite d (depth ",dep,", lead ",L,"; I_0, I_1 gated)"];
                          Do[lau[kk]=Lookup[lau,kk,0]+Sum[If[Head[serC]===SeriesData,SeriesCoefficient[serC,kk-j],If[kk-j==0,Cz,0]] tc[[j+1]],{j,0,dep}],{kk,L,1}],
                          gbP["copy term: slope-two Taylor closer failed its I_0/I_1 gates (",N[tc,8]," vs ",N[{q0g,q1g},8],")"]]],
                      gbP["copy term: slope-two Taylor closer refused (",If[ListQ[tc],"inexact",ToString[Short[tc,2]]],")"]]]];
                If[ok,Continue[]]]];
            gbP["copy term: coefficient pieces (orders ",l0,"..1)"];
            Do[Module[{ck=Expand[SeriesCoefficient[ser,kk]],mons,cz,mz},
                If[ck===0,Continue[]];
                mons=If[Head[ck]===Plus,List@@ck,{ck}];
                Do[cz=Times@@Select[gbFactors[m],FreeQ[#,Alternatives@@vs1]&];mz=Cancel[Together[m/cz]];
                  If[FreeQ[mz,Alternatives@@vs1],gbRefuse["copy part: a monomial without the Mellin variables"]];
                  If[left<30,gbRefuse["copy part: budget spent"]];
                  k++;lau[kk]=Lookup[lau,kk,0]+cz gbCoeffClose[mz,c1,"copy"<>ToString[k]<>"(d^"<>ToString[kk]<>")",Min[1800,left]],{m,mons}]],
              {kk,l0,1}]],{tm,terms}];
        (* negative orders cancel EXACTLY (a time-limited FullSimplify to the literal zero; undecided = refused) *)
        Do[With[{cn=Global`mbeCanonicalConstants[Expand[Lookup[lau,kk,0]]]},
            If[cn=!=0&&Quiet@TimeConstrained[FullSimplify[cn],120,$TimedOut]=!=0,gbRefuse["copy part: the d^"<>ToString[kk]<>" coefficients do not cancel over the terms exactly: "<>ToString[N[cn,12]]]]],{kk,lead,-1}];
        (* order 0 = the undressed kernel, gated by its contour quadrature (required up to two folds; no quadrature beyond) *)
        q0=ladQuad[K,ctr];
        Which[
          NumericQ[q0],If[!gbGateQ[Lookup[lau,0,0],q0,2],gbRefuse["copy part: the d^0 sum "<>ToString[N[Lookup[lau,0,0],12]]<>" fails the two-fold quadrature gate of the undressed kernel ("<>ToString[N[q0,12]]<>")"]],
          Length[ctr]>=3,gbP["copy part: no ",Length[ctr],"-fold quadrature; the undressed sum rests on the gates of its sub-pieces"],
          True,gbRefuse["copy part: the quadrature of the undressed kernel is unavailable"]];
        gbP["copy part: ",k," sub-piece(s), poles cancelled exactly, d^0 sum ",N[Lookup[lau,0,0],12],If[NumericQ[q0]," = quadrature "<>ToString[N[q0,12]],""]];
        val=Lookup[lau,1,0];
        (* the d^1 sum IS the copy part: gated by the quadrature of the dressed kernel K psi(L_leg) (two folds) *)
        Module[{q1=ladQuad[K PolyGamma[0,Lleg],ctr]},
          Which[
            NumericQ[q1],If[!gbGateQ[val,q1,2],gbRefuse["copy part: the d^1 sum "<>ToString[N[val,12]]<>" fails the two-fold quadrature gate of the dressed kernel ("<>ToString[N[q1,12]]<>")"]];
              gbP["copy part: d^1 sum ",N[val,12]," = quadrature of K psi ",N[q1,12]],
            Length[ctr]>=3,Null,
            True,gbRefuse["copy part: the quadrature of the dressed kernel is unavailable"]]];
        gbP["copy part closed: ",N[sgn val,16]];
        sgn val],"gb2"];
    If[!FailureQ[res],Return[res,Module]];
    AppendTo[reasons,cd[[2]]<>" in "<>ToString[cd[[1]]]<>": "<>res["Reason"]];gbP["copy candidate refused: ",res["Reason"]],{cd,cands}];
  gbRefuse["copy part: "<>StringRiffle[reasons," | "]]];
(* ---------- the piece (two or more folds) ---------- *)
gbMultiFold[F_,ctr_List,budget_]:=Catch[Module[{t0=AbsoluteTime[],vs=Keys[ctr],fs,pg,K,val,q,left,parts={},key,out},
  left:=budget-(AbsoluteTime[]-t0);
  If[Length[ctr]<2,gbRefuse["two or more folds"]];
  If[!FreeQ[F,ladEp],gbRefuse["eps in piece"]];
  key=Hash[{Cancel[Together[F]],Sort[Normal[ctr]]},"SHA256","HexString"];
  If[KeyExistsQ[gbMultiMemo,key],Return[gbMultiMemo[key],Module]];
  fs=gbFactors[F];pg=Select[fs,!FreeQ[#,PolyGamma]&];
  If[AnyTrue[fs,!FreeQ[#,Alternatives@@vs]&&FreeQ[#,Gamma|PolyGamma]&&!(PolynomialQ[#,vs]||MatchQ[#,Power[q_,_Integer?Negative]/;PolynomialQ[q,vs]])&],gbRefuse["a factor outside the class (not Gamma, polygamma, polynomial or reciprocal polynomial)"]];
  If[!AllTrue[Cases[F,(Gamma|PolyGamma)[___,a_]:>a,{0,Infinity}],FreeQ[#,Alternatives@@vs]||gbAffineQ[#,vs]&],gbRefuse["a Gamma or polygamma argument is not affine with real coefficients"]];
  Which[
    pg==={},val=gbPureRat[F,ctr,left,"pure"],
    Length[pg]===1&&MatchQ[pg[[1]],PolyGamma[0,_]],
      Module[{L=Expand[pg[[1,2]]],legs,done=False,why={}},
        K=F/pg[[1]];
        legs=gbPsiLegs[K,L,vs];
        If[legs==={},gbRefuse["psi argument "<>ToString[L,InputForm]<>" on no leg lattice of the kernel"]];
        Do[Module[{n=Expand[Lleg-L],rat,r},
            If[done,Break[]];
            (* psi(L) = psi(L_leg) - sum_{j<n} 1/(L+j)  (n > 0);  psi(L) = psi(L_leg) + sum_{j<-n} 1/(L_leg+j)  (n < 0) *)
            rat=Which[n>0,-Sum[1/(L+j),{j,0,n-1}],n<0,Sum[1/(Lleg+j),{j,0,-n-1}],True,0];
            gbP["psi(",InputForm[L],") = psi(",InputForm[Lleg],")",If[rat=!=0," + "<>ToString[rat,InputForm],""]];
            r=Catch[Module[{v=None,ps={},qd,re},
                (* the copy through the Euler route (two folds; the psi argument on the spectator of a plan): no finite-d
                   lemma, no singular terms, no degree-2 dressings -- the spectator pieces and the tower take a regulator jet *)
                If[Length[ctr]==2,
                  qd=ladQuad[K PolyGamma[0,Lleg],ctr];
                  If[NumericQ[qd],
                    gbP["copy through the Euler route (regulator jet on the spectator): dressed-kernel quadrature ",N[qd,12]];
                    re=gbEulerCore[Cancel[Together[K Gamma[Lleg+ladEp]/Gamma[Lleg]]],ctr,left,ladEp,qd];
                    If[AssociationQ[re],v=re["Value"];gbP["copy part (Euler route) closed: ",N[v,16]],gbP["Euler copy route refused: ",re["Reason"]]]]];
                If[v===None,v=gbCopyPart[K,Lleg,ctr,left,1]];
                AppendTo[ps,"copy"->v];
                Do[With[{G=Cancel[Together[K rt]]},Module[{vr=gbPureRat[G,ctr,left,"rational part "<>ToString[rt,InputForm]]},AppendTo[ps,rt->vr];v+=vr]],{rt,If[rat===0,{},If[Head[rat]===Plus,List@@rat,{rat}]]}];
                {v,ps}],"gb2"];
            If[ListQ[r],val=r[[1]];parts=r[[2]];done=True,AppendTo[why,"leg "<>ToString[Lleg,InputForm]<>": "<>r["Reason"]]]],{Lleg,legs}];
        If[!done,gbRefuse[StringRiffle[why," || "]]]],
    True,gbRefuse["polygamma dressing outside the class (one psi of an affine argument): "<>ToString[pg,InputForm]]];
  val=Global`mbeCanonicalConstants[Expand[val]];
  If[!ladExactQ[val],gbRefuse["inexact value"]];
  q=ladQuad[F,ctr];
  Which[
    NumericQ[q],If[!gbGateQ[val,q,2],gbRefuse[ToString[Length[ctr]]<>"-fold gate: "<>ToString[N[val,15]]<>" vs quadrature "<>ToString[N[q,15]]]],
    Length[ctr]>=3,gbP[Length[ctr],"-fold: no contour quadrature; the value rests on the gates of its sub-pieces"],
    True,gbRefuse["the two-fold quadrature of the piece is unavailable"]];
  out=<|"Value"->val,"Method"->ToString[Length[ctr]]<>"-fold: psi split, Gamma copy + Barnes lemmas, generalized Barnes -> Euler kernel -> Mellin tower -> exact last fold","Quad"->q,"Parts"->parts,"Seconds"->Round[AbsoluteTime[]-t0]|>;
  gbMultiMemo[key]=out;
  out],"gb2"];
gbTwoFold[F_,ctr_List,budget_]:=If[Length[ctr]=!=2,Failure["GB2",<|"Reason"->"two-fold pieces only"|>],gbMultiFold[F,ctr,budget]];
Print["[uint_gb_euler] multi-fold closer loaded (psi split, finite-d Barnes copies, Barnes lemmas with recursion, generalized Barnes -> Euler kernel (patterns A/B) -> Mellin tower -> folded exact last fold; version ",gbVersion,")."];
