(* uint_jet_rung.m (1 October 2026) -- THE JET RUNG: polygamma dressings of a one-fold Gamma kernel as regulator jets.

   Any monomial of polygammas of the legs a_1..a_r of a Gamma kernel K(z) is a linear combination of mixed regulator
   derivatives of REGULATED COPIES of the legs,
       psi^(m)(a):  Gamma(a + d)/Gamma(a) = exp( sum_{n>=1} psi^(n-1)(a) d^n/n! ),
       d^n/dd^n [Gamma(a+d)/Gamma(a)] at 0 = B_n(psi(a), psi'(a), ..., psi^(n-1)(a))   (complete Bell polynomial),
   so for a leg of weight W = sum (m+1) over its polygamma factors the monomial is solved from the derivatives D_lambda =
   prod_j B_{lambda_j} over the partitions lambda of W (one copy per part, the matrix is unitriangular); across legs the
   products multiply.  A slope-k leg is regulated through the regulated multiplication theorem (unit-slope legs only),
       Gamma(k z + c + d)/Gamma(k z + c) = k^d prod_{j=0}^{k-1} Gamma(z + (c+j)/k + d/k)/Gamma(z + (c+j)/k).
   With d_i = kappa_i ep the one-fold family ladder (mbeOneFoldFamilyLaurent, exact towers in the regulator) gives the
   Laurent coefficients of the regulated one-fold; the ep^n coefficient (n = total weight) is a polynomial of total degree n
   in the kappa's whose coefficient of prod kappa_i^lambda_i is the wanted mixed derivative: the forward differences
   Delta^lambda on the grid kappa_i = 0..lambda_i extract it exactly (every other monomial of degree <= n is annihilated,
   including any regulator-independent splitting terms).  Gates: the ep^0 coefficients of all samples equal the undressed
   integral; the total equals the contour quadrature of the piece.  Requires: uint_piece_chain.m (ladQuad, ladGateQ,
   ladExactQ, ladGammaCancel, ladUnitKernelQ), the one-fold ladder, mbeCanonicalConstants. *)
jetVersion="2026-10-02e";
jetP[args__]:=If[TrueQ[$jetVerbose],Print["    [jet] ",args]];
jetRefuse[s_]:=Throw[Failure["Jet",<|"Reason"->s|>],"jet"];
jetFactors[F_]:=If[Head[F]===Times,List@@F,{F}];
(* K and the polygamma factors {m, a, power} *)
jetSplit[F_]:=Module[{pg={},K=1},
  Do[Which[
      MatchQ[t,PolyGamma[_Integer?NonNegative,_]],AppendTo[pg,{t[[1]],Expand[t[[2]]],1}],
      MatchQ[t,Power[PolyGamma[_Integer?NonNegative,_],_Integer?Positive]],AppendTo[pg,{t[[1,1]],Expand[t[[1,2]]],t[[2]]}],
      True,K=K t],{t,jetFactors[F]}];
  {K,pg}];
(* the n-th regulator derivative of Gamma(a+d)/Gamma(a) at 0 as a polynomial in jetPG[k] (= psi^(k)(a)) *)
jetBell[n_]:=jetBell[n]=Module[{dd,a},
  Expand[(D[Gamma[a+dd],{dd,n}]/.dd->0)/Gamma[a]]/.PolyGamma[k_,a]:>jetPG[k]];
(* partition lambda of W <-> monomial prod jetPG[lambda_j - 1] *)
jetMonomial[lambda_List]:=Times@@(jetPG[#-1]&/@lambda);
(* the wanted leg monomial (from its factor list {m, a, p}) as sum_lambda c_lambda D_lambda, D_lambda = prod_j B_{lambda_j};
   returns {{c, lambda}, ...} with lambda the copy orders *)
jetLegCombination[facs_List]:=Module[{W,parts,target,mons,A,vecT,c},
  W=Total[(#[[1]]+1) #[[3]]&/@facs];
  parts=IntegerPartitions[W];
  target=Times@@(jetPG[#[[1]]]^#[[3]]&/@facs);
  mons=jetMonomial/@parts;
  (* A[[i,j]] = coefficient of mons[[j]] in D_{parts[[i]]} *)
  A=Table[Module[{Dl=Expand[Times@@(jetBell/@parts[[i]])]},Coefficient[Dl,mons[[j]]]/.jetPG[_]->0],{i,Length[parts]},{j,Length[parts]}];
  (* every D_lambda is a polynomial in the jetPG with constant term 0 and total weight W: Coefficient at a full monomial is a number *)
  If[!AllTrue[Flatten[A],NumberQ],jetRefuse["Bell matrix not numeric"]];
  vecT=Table[If[mons[[j]]===target,1,0],{j,Length[parts]}];
  If[Total[vecT]=!=1,jetRefuse["leg monomial not among the partitions"]];
  c=LinearSolve[Transpose[A],vecT];
  Select[Transpose[{c,parts}],#[[1]]=!=0&]];
(* regulated leg Gamma(a+d)/Gamma(a) with the multiplication theorem for |slope| >= 2 *)
jetRegLeg[a_,d_,z_]:=Module[{k=Abs[Coefficient[a,z]]},
  Which[k===0,jetRefuse["a z-free polygamma argument"],
    !IntegerQ[k],jetRefuse["non-integer polygamma slope "<>ToString[k,InputForm]],
    k===1,Gamma[Expand[a+d]]/Gamma[Expand[a]],
    (* arguments EXPANDED: Gamma[(2+2z)/2] would not cancel against the kernel's Gamma[1+z] and the ladder would see a
       spurious leg pair (test b: the slope-two case went to HypExp and failed) *)
    True,k^d Product[Gamma[Expand[(a+j)/k+d/k]]/Gamma[Expand[(a+j)/k]],{j,0,k-1}]]];
(* the ep^0..ep^n Laurent coefficients of the one-fold of g on ctr (exact), memoized on the kernel *)
If[!AssociationQ[jetLadderMemo],jetLadderMemo=<||>];
jetLadder[g_,ctr_List,ep_,n_,sec_]:=Module[{t0=AbsoluteTime[],fam,key={g,ctr,ep,n}},
  If[KeyExistsQ[jetLadderMemo,key],Return[jetLadderMemo[key],Module]];
  fam=Quiet@TimeConstrained[MBtoMPL`Private`mbeOneFoldFamilyLaurent[{MBint[g,{{ep->0},ctr}]},ep,0,n,False],sec,$Aborted];
  If[!(ListQ[fam]&&Length[fam]==n+1&&ladExactQ[fam]&&FreeQ[fam,ep]),
    jetRefuse["ladder sample refused ("<>If[fam===$Aborted,"time limit",ToString[Short[fam,2],InputForm]]<>") on "<>ToString[Short[g,3],InputForm]]];
  jetP["ladder sample (",Round[AbsoluteTime[]-t0]," s): ",Short[g,2]];
  jetLadderMemo[key]=fam;
  fam];
(* ENGINE B (fallback when the ladder refuses a term's samples, e.g. half-integer 3F2 classes where HypExp fails): the
   Mellin tower at a scale (s2ItemLaurent) and the limit Y -> 1 (s2UnitLimit, half-integer towers through Y = x^2).
   ONE FIXED REGULATED FAMILY: the kernel's coincident legs are split by nu ep ONCE (Ks = s2NormalizeInner[K])
   and every sample is Ks times the regulated copies -- never re-normalized per sample (a per-sample split changes the
   family with kappa and the differences are wrong: (1 - nu) int K psi instead of int K psi).  The splitting then adds only
   terms of kappa-degree < n at order n, which the forward differences Delta^lambda annihilate.  Copies of one leg take
   DISTINCT, collision-checked step multiples (no two copies ever coincide on the grid). *)
jetTowerSample[g_,ctr_List,ep_,n_,sec_]:=Module[{t0=AbsoluteTime[],z=ctr[[1,1]],c=ctr[[1,2]],Y=Global`s2Yu,J,vals,key={"tower",g,ctr,ep,n}},
  If[KeyExistsQ[jetLadderMemo,key],Return[jetLadderMemo[key],Module]];
  If[DownValues[s2ItemLaurent]==={}||DownValues[s2UnitLimit]==={},jetRefuse["tower engine not loaded"]];
  J=TimeConstrained[s2HPLBlock[Catch[s2ItemLaurent[g Y^z,{z->c},z,Y,0,n,0<Y<1,{{1/3},{2/3}}],"s2t"]],sec,$Aborted];
  If[J===$Aborted||FailureQ[J]||!ListQ[J]||Length[J]=!=n+1,
    jetRefuse["tower sample refused ("<>Which[J===$Aborted,"time limit",FailureQ[J],ToString[J["Reason"]],True,"?"]<>") on "<>ToString[Short[g,3],InputForm]]];
  vals=Catch[Table[s2HPLBlock[s2UnitLimit[J[[k+1]],Y]],{k,0,n}],"s2u"];
  If[FailureQ[vals]||!ListQ[vals]||!ladExactQ[vals],jetRefuse["tower sample: the limit Y -> 1 refused"<>If[FailureQ[vals],": "<>ToString[vals["Reason"]],""]]];
  jetP["tower sample (",Round[AbsoluteTime[]-t0]," s): ",Short[g,2]];
  jetLadderMemo[key]=vals;
  vals];
(* collision-free step multiples for the copies of one term: a_r = 1 + (r-1)/7 unless two copies of the SAME leg would
   meet on the grid (j a_r = k a_s with 1 <= j <= lambda_r, 1 <= k <= lambda_s); then bump *)
jetSteps[regs_List]:=Module[{m=Length[regs],steps,ok,guard=0},
  steps=Table[1+(r-1)/7,{r,m}];
  ok[]:=AllTrue[Subsets[Range[m],{2}],Function[pr,regs[[pr[[1]],1]]=!=regs[[pr[[2]],1]]||
    Intersection[Table[j steps[[pr[[1]]]],{j,regs[[pr[[1]],3]]}],Table[k steps[[pr[[2]]]],{k,regs[[pr[[2]],3]]}]]==={}]];
  While[!ok[]&&guard++<20,steps=Table[1+(r-1)/7+guard/97 (r-1),{r,m}]];
  If[!ok[],jetRefuse["no collision-free step multiples"]];
  steps];
(* PRODUCT FORM of a sample kernel: Cancel/Together distribute the polynomial prefactor over the Gamma product (a sum of
   Gamma terms, which the tower engine refuses: "not a Gamma product times a rational function"); regroup as the Gamma part
   of the first term times the factored Gamma-free quotient *)
jetProductForm[e_]:=Module[{terms,gp,D},
  If[Head[e]=!=Plus,Return[e,Module]];
  terms=List@@e;
  gp=Times@@Cases[If[Head[terms[[1]]]===Times,List@@terms[[1]],{terms[[1]]}],Gamma[_]|Power[Gamma[_],_]|Power[_,_?(!FreeQ[#,Global`regEp]&)]];
  If[gp===1,Return[e,Module]];
  D=Together[e/gp];
  If[FreeQ[D,Gamma],gp Factor[D],e]];
jetCandidateQ[F_,z_]:=Module[{sp=jetSplit[F]},
  sp[[2]]=!={}&&AllTrue[sp[[2]],IntegerQ[Coefficient[#[[2]],z]]&&Coefficient[#[[2]],z]=!=0&]&&
    ladUnitKernelQ[ladGammaCancel[sp[[1]],{z}],{z}]];
jetWeight[F_]:=Total[(#[[1]]+1) #[[3]]&/@jetSplit[F][[2]]];
(* ---------- ENGINE C: a SLOPE-k POLYGAMMA BY ITS INTEGRAL REPRESENTATION (1 October 2026; option (a)) ----------
   F = K(z) D(z) psi^(m)(a), a = k z + c0 with |k| >= 2, D a product of UNIT-slope polygammas (or 1), K a unit-slope Gamma
   kernel times a polynomial.  For Re a > 0 on the contour,
       psi(a) = -gamma_E + Int_0^1 (1 - t^(a-1))/(1-t) dt,     psi^(m)(a) = -Int_0^1 t^(a-1) log^m(t)/(1-t) dt   (m >= 1),
   and with t^(kz) = X^z the piece is the exact outer t-integral of the dressed inner one-fold at the scale,
       J(X) = Int K D X^z dz/(2 pi i),      value = -gamma_E J(1) + Int_0^1 [J(1) - t^(c0-1) J(t^k)]/(1-t) dt     (m = 0),
   J(X) by the jet at the scale (one fixed split family, forward differences, as engine B without the limit) or the plain
   tower when D = 1, J(1) by the ladder jet on K D (the half-integer legs of the regulated multiplication theorem never
   appear), the outer integral by the exact last fold with the pullback S = t^k (s2OuterExact, as s2PsiIntClose).  A
   contour with Re a <= 0 is shifted, psi^(m)(a) = psi^(m)(a+n) - (-1)^m m! sum_j 1/(a+j)^(m+1), the rational pieces
   closed by the rung itself. *)
(* ---------- single-argument polygamma monomials as BETA-KERNEL MOMENTS (2 October 2026) ----------
   For one argument a and f(t) = t^(a-1),
       M_{j,k}(a) = Int_0^1 [t^(a-1) log^j(t) - delta_{j0}] log^k(1-t)/(1-t) dt = k! d_a^j c_k(a),
       B(a, b) - 1/b = sum_{k>=0} c_k(a) b^k,     B(a, b) = Gamma(1+b) Gamma(a)/(b Gamma(a+b)),
   and c_k is a polynomial of weight k+1 in psi^(n)(a), gamma_E and zeta values (c_0 = -(gamma_E + psi), c_1 =
   ((gamma_E + psi)^2 + zeta_2 - psi')/2, ...).  Every monomial of weight W <= 3 in the polygammas of ONE argument is
       c00 + sum_{j+k+1 <= W} alpha_jk M_jk(a)
   (a square linear system: 2, 4, 7 unknowns for W = 1, 2, 3), e.g. psi = -gamma_E - M_00, psi' = -M_10,
   psi^2 = 2 M_01 - M_10 + 2 gamma_E M_00 + gamma_E^2 - zeta_2.  (For m >= 1: psi^(m)(a) = -Int_0^1 t^(a-1) log^m(t)/(1-t) dt
   for EVERY m; the sign (-1)^(m+1) used before 2 October was wrong for odd m, and the gate refused every psi' piece.) *)
jetBetaMoment[j_Integer,k_Integer]:=jetBetaMoment[j,k]=Module[{a,b,ck},
  ck=SeriesCoefficient[Series[(Gamma[1+b] Gamma[a]/Gamma[a+b]-1)/b,{b,0,k}],k];
  Expand[FunctionExpand[k! D[ck,{a,j}]]/.PolyGamma[n_,a]:>jetPG[n]]];
jetBetaCombination[target_,W_Integer]:=jetBetaCombination[target,W]=Module[{idx,al,c0,eq,vars,rules,sol,out},
  idx=Flatten[Table[{j,w-1-j},{w,1,W},{j,0,w-1}],1];
  vars=Join[{c0},al/@idx];
  eq=Expand[target-c0-Sum[al[p] jetBetaMoment[p[[1]],p[[2]]],{p,idx}]];
  If[!PolynomialQ[eq,jetPG/@Range[0,W]],Return[$Failed,Module]];
  rules=CoefficientRules[eq,jetPG/@Range[0,W]];
  sol=Quiet@Solve[(#[[2]]==0)&/@rules,vars];
  If[!ListQ[sol]||Length[sol]=!=1,Return[$Failed,Module]];
  out={Expand[c0/.sol[[1]]],Select[{#[[1]],#[[2]],Expand[al[#]/.sol[[1]]]}&/@idx,#[[3]]=!=0&]};
  If[!FreeQ[out,al|c0]||Expand[eq/.sol[[1]]]=!=0,$Failed,out]];
(* a reciprocal linear factor next to a leg one step above its zero is absorbed, Gamma(x+1)/x = Gamma(x), x = +-(z + a0), in
   the orientation whose new pole lies on the leg's own side of the contour (pole -a0 left of Re z = c: an up leg
   Gamma(z + a0 + 1) -> Gamma(z + a0); right of it: a down leg Gamma(1 - a0 - z) -> Gamma(-a0 - z)).  The kernel
   Gamma(1+z) Gamma(2+z)/(1+z) is the pure product Gamma(1+z)^2, whose coincident legs the tower splits, while the rational
   factor as an operator on the split family failed its gate (MB8bu residue 21, 2 October 2026).  Factors without such a
   leg stay (the tower's operator route).  An exact identity, checked at a complex point. *)
jetAbsorbRational[K_,z_,c_]:=Module[{fs,gs,rat,changed=True,guard=0,out},
  If[Head[K]=!=Times,Return[K,Module]];
  fs=List@@K;gs=Select[fs,MatchQ[#,Gamma[_]|Power[Gamma[_],_Integer]]&];
  If[gs==={},Return[K,Module]];
  rat=Together[K/Times@@gs];
  If[!FreeQ[rat,Gamma]||FreeQ[Denominator[rat],z],Return[K,Module]];
  gs=Times@@(gs/.Gamma[a_]:>Gamma[Expand[a]]);
  While[changed&&guard++<12,changed=False;
    Do[Module[{q=fl[[1]],a0,sg,x,leg},
        If[changed||FreeQ[q,z]||Exponent[q,z]=!=1,Continue[]];
        a0=Expand[(q/.z->0)/Coefficient[q,z]];
        If[!NumericQ[a0]||-a0==c,Continue[]];
        sg=If[-a0<c,1,-1];
        x=Expand[sg (z+a0)];leg=Gamma[Expand[x+1]];
        If[Exponent[gs,leg]>=1,gs=gs Gamma[x]/leg;rat=Together[rat x];changed=True]],
      {fl,FactorList[Denominator[rat]]}]];
  out=gs Factor[rat];
  If[out=!=K&&ladCheckQ[K,out,{z}],out,K]];
(* the first-pass flag of the piece chain ($jetPsiIntOnly) restricts the TOP-LEVEL piece to this route; the route's own
   inner pieces (J(1) of a dressed kernel, the rational pieces of a shift) are closed by the whole rung *)
jetPsiIntClose[args___]:=Block[{$jetPsiIntOnly=False},jetPsiIntClose0[args]];
jetPsiIntClose0[F_,ctr_List,ep_,budget_,shiftQ_:False]:=Catch[Module[{t0=AbsoluteTime[],left,z=ctr[[1,1]],c=ctr[[1,2]],K,pg,slopeF,ar,m,k,c0,D=1,
    X=Global`s2X,t=Global`s2pt,n=0,ratSum=0,JX,J1=0,val,q,W,comb,cc0,needJ1,Kabs},
  left:=budget-(AbsoluteTime[]-t0);
  If[Length[ctr]=!=1,jetRefuse["psi-integral: one-fold pieces only"]];
  {K,pg}=jetSplit[F];
  slopeF=Select[pg,Abs[Coefficient[#[[2]],z]]>=2&];
  (* 2 October 2026: the polygammas of ONE slope >= 2 argument, any monomial of weight <= 3 (psi, psi', psi^2, psi'',
     psi psi', psi^3), through the Beta-kernel moments above *)
  If[slopeF==={}||Length[DeleteDuplicates[slopeF[[All,2]]]]=!=1,jetRefuse["psi-integral: the polygammas of exactly one slope >= 2 argument"]];
  W=Total[(#[[1]]+1) #[[3]]&/@slopeF];
  If[W>3,jetRefuse["psi-integral: slope >= 2 polygamma monomial of weight "<>ToString[W]<>" > 3"]];
  ar=slopeF[[1,2]];k=Coefficient[ar,z];
  If[k<0,Return[jetPsiIntClose[F/.z->-z,{z->-c},ep,budget,shiftQ],Module]];
  c0=Expand[ar/.z->0];
  If[!IntegerQ[c0],jetRefuse["psi-integral: non-integer offset "<>ToString[c0,InputForm]]];
  (* UNIT-slope polygammas whose argument has a non-positive real part on the contour are shifted up first,
         psi^(m)(L) = psi^(m)(L+n) - (-1)^m m! sum_{j<n} 1/(L+j)^(m+1),
     so that every copy Gamma(L+n+d) has its poles on the side of the contour of an ordinary leg (psi(z)^2 on Re z = -1/5:
     the copies Gamma(z+d) put a pole at z = -d to the RIGHT of the contour and the inner tower failed its gate); the
     rational terms join the kernel.  The monomials are closed one by one and the sum is gated by the quadrature of the
     piece.  This form is the SECOND attempt (shiftQ): a copy on a leg of the kernel itself needs no shift (psi(z) next to
     Gamma(z)^2 closes as given, and closed so before the shift existed), so the piece is first tried as given. *)
  Module[{uf=Select[pg,Abs[Coefficient[#[[2]],z]]==1&&Re[N[#[[2]]/.z->c]]<=0&],Fs,mons,vals,qq,tot},
    If[TrueQ[shiftQ]&&uf==={},jetRefuse["psi-integral: no unit polygamma with a non-positive real part to shift"]];
    If[TrueQ[shiftQ]&&uf=!={},
      Fs=Expand[F/.PolyGamma[mm_Integer,a_]/;MemberQ[uf[[All,2]],Expand[a]]:>
        With[{nn=Floor[-Re[N[a/.z->c]]]+1},PolyGamma[mm,Expand[a+nn]]-(-1)^mm mm! Sum[1/(a+j)^(mm+1),{j,0,nn-1}]]];
      If[!ladCheckQ[F,Fs,{z}],jetRefuse["psi-integral: the shift of the unit polygammas failed its check"]];
      mons=If[Head[Fs]===Plus,List@@Fs,{Fs}];
      mons=Module[{parts},
        parts=Function[mo,With[{ff=If[Head[mo]===Times,List@@mo,{mo}]},{Times@@Select[ff,!PolynomialQ[#,z]&],Times@@Select[ff,PolynomialQ[#,z]&]}]]/@mons;
        (Factor[Total[#[[All,2]]]] #[[1,1]])&/@GatherBy[parts,First]];
      jetP["psi-integral: unit polygammas ",InputForm[PolyGamma[#[[1]],#[[2]]]&/@uf]," shifted to a positive real part: ",Length[mons]," monomial(s)"];
      vals=Table[Module[{r=jetPsiIntClose[mons[[i]],ctr,ep,Max[120,left/(Length[mons]-i+1)]]},
          If[!AssociationQ[r],jetRefuse["psi-integral: monomial "<>ToString[i]<>" of the shifted piece: "<>If[FailureQ[r],ToString[r["Reason"]],"?"]]];
          r["Value"]],{i,Length[mons]}];
      tot=mbeCanonicalConstants[Expand[Total[vals]]];
      qq=ladQuad[F,ctr];
      If[!ladGateQ[tot,qq],jetRefuse["psi-integral gate (shifted monomials): "<>ToString[N[gbNumJ[tot],15]]<>" vs quadrature "<>ToString[If[NumericQ[qq],N[qq,15],qq]]]];
      jetP["psi-integral: closed in ",Round[AbsoluteTime[]-t0]," s (",Length[mons]," shifted monomials): ",N[gbNumJ[tot],12]];
      Throw[<|"Value"->tot,"Method"->"jet rung, psi-integral representation ("<>ToString[Length[mons]]<>" monomials after the shift of the unit polygammas, gated)","Quad"->qq|>,"jet"]]];
  D=Times@@(PolyGamma[#[[1]],#[[2]]]^#[[3]]&/@Select[pg,Abs[Coefficient[#[[2]],z]]<2&]);
  K=jetProductForm[ladGammaCancel[K,{z}]];
  If[!ladUnitKernelQ[K,{z}],jetRefuse["psi-integral: kernel with non-unit legs"]];
  (* Re a > 0 on the contour *)
  While[k c+c0+n<=0,n++];
  If[n>0,
    If[!(Length[slopeF]==1&&slopeF[[1,3]]==1),jetRefuse["psi-integral: a polygamma monomial whose argument has a non-positive real part on the contour"]];
    m=slopeF[[1,1]];
    ratSum=Sum[(-1)^m m! Module[{r=jetPieceClose[Together[K D/(ar+j)^(m+1)],ctr,ep,Min[left/2,900]]},
        If[FailureQ[r],jetRefuse["psi-integral: rational piece refused: "<>r["Reason"]]];r["Value"]],{j,0,n-1}];
    c0=c0+n;ar=ar+n];
  comb=jetBetaCombination[Times@@(jetPG[#[[1]]]^#[[3]]&/@slopeF),W];
  If[comb===$Failed,jetRefuse["psi-integral: the monomial is not a combination of Beta-kernel moments"]];
  {cc0,comb}=comb;
  (* the inner function J(X), exact in X *)
  Kabs=jetAbsorbRational[K,z,c];
  JX=Catch[jetInnerAtScale[Kabs,D,ctr,ep,X,Min[left-120,2000]],"jet"];
  If[FailureQ[JX]&&Kabs=!=K,
    jetP["psi-integral: inner J(X) refused on the kernel with its rational factor absorbed (",StringTake[ToString[JX["Reason"]],UpTo[160]],"); the kernel as given next"];
    JX=Catch[jetInnerAtScale[K,D,ctr,ep,X,Min[left-120,2000]],"jet"]];
  If[FailureQ[JX],Throw[JX,"jet"]];
  jetP["psi-integral: inner J(X) closed (",LeafCount[JX]," leaves); moments ",comb[[All,{1,2}]],If[Kabs=!=K,"; rational factor absorbed into a leg",""]];
  (* J(1): for the constant term and for the subtraction of the j = 0 moments *)
  needJ1=cc0=!=0||AnyTrue[comb,#[[1]]==0&];
  J1=If[needJ1,
    Module[{r=If[D===1,
        (* the undressed one-fold: the ladder first (exact, fast on every Barnes class), the Barnes closed forms next *)
        Module[{v=Catch[jetLadder[K,ctr,ep,0,Min[600,left]],"jet"]},
          If[FailureQ[v],v=Catch[s2UnitPieceValue[K,ctr],"s2p"],v=v[[1]]];
          If[FailureQ[v],v,<|"Value"->v|>]],
        jetPieceClose[K D,ctr,ep,Min[left-60,1200]]]},
      If[FailureQ[r],jetRefuse["psi-integral: J(1) refused: "<>ToString[r["Reason"]]]];r["Value"]],0];
  If[!s2LastFoldLoadedQ[],jetRefuse["psi-integral: exact last-fold rung not loaded"]];
  (* one exact outer fold per moment (rational weights with Log[t], Log[1-t]; the constants alpha multiply the values) *)
  val=cc0 J1+Sum[Module[{jj=cb[[1]],kk=cb[[2]],res},
      res=Catch[If[jj==0,
          s2OuterExact[{JX},{t^(c0-1) Log[1-t]^kk/(1-t)},0,X,t,t^k,-J1 Log[1-t]^kk/(1-t)],
          s2OuterExact[{JX},{t^(c0-1) Log[t]^jj Log[1-t]^kk/(1-t)},0,X,t,t^k]],"s2o"];
      If[!(ListQ[res]&&Length[res]===1),jetRefuse["psi-integral: outer fold of the moment "<>ToString[{jj,kk}]<>": "<>If[FailureQ[res],ToString[res["Reason"]],"?"]]];
      jetP["psi-integral: moment ",{jj,kk}," folded (",Round[AbsoluteTime[]-t0]," s)"];
      cb[[3]] res[[1]]],{cb,comb}]-ratSum;
  val=mbeCanonicalConstants[Expand[val]];
  q=ladQuad[F,ctr];
  If[!ladGateQ[val,q],jetRefuse["psi-integral gate: "<>ToString[N[gbNumJ[val],15]]<>" vs quadrature "<>ToString[If[NumericQ[q],N[q,15],q]]]];
  jetP["psi-integral: closed in ",Round[AbsoluteTime[]-t0]," s: ",N[gbNumJ[val],12]];
  <|"Value"->val,"Method"->"jet rung, psi-integral representation (slope "<>ToString[k]<>", weight "<>ToString[W]<>", pullback t^"<>ToString[k]<>", gated)","Quad"->q|>],"jet"];
(* the dressed inner one-fold at the scale: J(X) = Int K D X^z; D = 1: the Mellin tower (as s2PsiIntClose); otherwise the
   jet at the scale with ONE fixed split family and forward differences on collision-free steps *)
jetInnerAtScale[K_,D_,ctr_List,ep_,X_,sec_]:=Module[{t0=AbsoluteTime[],z=ctr[[1,1]],c=ctr[[1,2]],Ks,pg,legs,combos,n,terms,total=0,J0,Jser,sp,P=1,Kg=K},
  Ks=s2NormalizeInner[K,z,1/7];
  If[D===1,
    (* the undressed inner tower on the MERGED-and-split kernel (integer-distance legs of one orientation give coincident
       natural towers and "no closure direction" otherwise; the dressed path uses the same Ks) *)
    (* reciprocal linear factors left in the kernel: the tower's operator route (s2ItemLaurent: (Theta + a)^-1 on the
       closed inner function, cluster residue for a pole right of the contour), as the dressed path below *)
    If[!FreeQ[Denominator[Together[Ks/.Gamma[_]->1]],z],
      Jser=TimeConstrained[s2HPLBlock[Catch[s2ItemLaurent[Ks X^z,{z->c},z,X,0,0,0<X<1,{{1/3},{2/3}}],"s2t"]],sec,$Aborted];
      If[Jser===$Aborted||FailureQ[Jser]||!ListQ[Jser]||Length[Jser]=!=1,
        jetRefuse["inner tower with a rational operator refused ("<>Which[Jser===$Aborted,"time limit",FailureQ[Jser],ToString[Jser["Reason"]],True,"?"]<>")"]];
      Return[Expand[Jser[[1]]],Module]];
    sp=s2SplitPoly[Ks,z];If[sp=!=$Failed,{Kg,P}=sp,Kg=Ks;P=1];
    Jser=Quiet@TimeConstrained[MBMellinTower`mbeMellinLaurent[s2SplitCoincident[Kg,z,1/7] X^z,z,ep,c,0,0,{X},0<X<1,"GatePoints"->{{1/7},{1/2}},"Log"->(Null&)],sec,$Aborted];
    If[Jser===$Aborted||FailureQ[Jser]||!FreeQ[Jser,MBMellinTower`mbeMellinLaurent|_MBint|HypergeometricPFQ|$Failed],jetRefuse["inner tower refused: "<>ToString[Short[Jser,3],InputForm]]];
    J0=Coefficient[Expand[Jser],ep,0];
    If[P=!=1,J0=Expand[s2PolyOperator[P,z,J0,X]]];
    Return[J0,Module]];
  pg=jetSplit[D][[2]];
  legs=GatherBy[pg,#[[2]]&];
  combos=Table[{legs[[i,1,2]],jetLegCombination[legs[[i]]]},{i,Length[legs]}];
  n=Total[(#[[1]]+1) #[[3]]&/@pg];
  terms=Tuples[combos[[All,2]]];
  Do[Module[{coef=Times@@tm[[All,1]],lams=tm[[All,2]],regs,mm,grid,wt,steps,norm,val,J00=None},
      regs=Flatten[Table[{i,j,lams[[i,j]]},{i,Length[lams]},{j,Length[lams[[i]]]}],1];mm=Length[regs];
      grid=Tuples[Range[0,#[[3]]]&/@regs];wt[kv_]:=Times@@Table[(-1)^(regs[[r,3]]-kv[[r]]) Binomial[regs[[r,3]],kv[[r]]],{r,mm}];
      steps=jetSteps[regs];norm=1/Times@@Table[steps[[r]]^regs[[r,3]],{r,mm}];
      val=norm Sum[Module[{kv=grid[[s]],g,J},
          g=Ks Product[jetRegLeg[combos[[regs[[r,1]],1]],kv[[r]] steps[[r]] ep,z],{r,mm}];
          If[AbsoluteTime[]-t0>sec,jetRefuse["inner jet at the scale: budget spent"]];
          J=TimeConstrained[s2HPLBlock[Catch[s2ItemLaurent[g X^z,{z->c},z,X,0,n,0<X<1,{{1/3},{2/3}}],"s2t"]],Max[60,sec-(AbsoluteTime[]-t0)],$Aborted];
          If[J===$Aborted||FailureQ[J]||!ListQ[J]||Length[J]=!=n+1,jetRefuse["inner jet at the scale: tower refused ("<>Which[J===$Aborted,"time limit",FailureQ[J],ToString[J["Reason"]],True,"?"]<>")"]];
          (* order-0 consistency across the family at X = 1/3 *)
          If[J00===None,J00=J[[1]],If[!TrueQ[Abs[N[gbNumJ[(J[[1]]-J00)/.X->1/3],30]]<10^-15 Max[1,Abs[N[gbNumJ[J00/.X->1/3],30]]]],jetRefuse["inner jet at the scale: order-0 functions differ across samples"]]];
          jetP["inner sample at the scale (",Round[AbsoluteTime[]-t0]," s): ",Short[g,2]];
          wt[kv] J[[n+1]]],{s,Length[grid]}];
      total+=coef val],{tm,terms}];
  Expand[total]];
(* the rung *)
jetPieceClose[F_,ctr_List,ep_,budget_]:=Catch[Module[{t0=AbsoluteTime[],left,z=ctr[[1,1]],K,pg,legs,combos,n,terms,total=0,q,q0,und,nSamples=0},
  left:=budget-(AbsoluteTime[]-t0);
  If[Length[ctr]=!=1,jetRefuse["one-fold pieces only"]];
  If[!FreeQ[F,ep],jetRefuse["eps in piece"]];
  {K,pg}=jetSplit[F];
  If[pg==={},jetRefuse["no polygamma dressing"]];
  K=jetProductForm[ladGammaCancel[K,{z}]];
  If[!ladUnitKernelQ[K,{z}],jetRefuse["kernel with non-unit legs (slope-two closer's class)"]];
  (* the polygammas of ONE slope >= 2 argument (monomial of weight <= 3): ENGINE C (integral representation) first -- no
     half-integer regulated legs; its refusal falls through to the regulated multiplication theorem below *)
  If[With[{sf=Select[pg,Abs[Coefficient[#[[2]],z]]>=2&]},sf=!={}&&Length[DeleteDuplicates[sf[[All,2]]]]==1&&Total[(#[[1]]+1) #[[3]]&/@sf]<=3],
    (* two forms of the piece: as given, and with the unit polygammas of non-positive real part shifted up.  As given first
       when every such polygamma sits on a leg of the kernel itself (psi(-s) next to Gamma(-s)^2: its copy adds no pole);
       shifted first otherwise (psi(z) next to Gamma(1+z) Gamma(2+z): the copy Gamma(z+d) would put a new pole on the far
       side of the contour).  The other form is the second attempt. *)
    Module[{rc,legsK=Cases[jetFactors[K],(Gamma[a_]|Power[Gamma[a_],_Integer?Positive]):>Expand[a]],ufA,shiftFirst},
      ufA=Select[pg,Abs[Coefficient[#[[2]],z]]==1&&Re[N[#[[2]]/.ctr]]<=0&][[All,2]];
      shiftFirst=ufA=!={}&&!SubsetQ[legsK,ufA];
      rc=Catch[jetPsiIntClose[F,ctr,ep,Max[60,left-60],shiftFirst],"jet"];
      (* Throw, not Return[.., Module]: a Return leaves only this inner Module (the return-in-inner-Module trap) *)
      If[AssociationQ[rc],Throw[rc,"jet"]];
      If[ufA=!={}&&left>120,
        jetP["psi-integral route refused ",If[shiftFirst,"with the unit polygammas shifted","as given"]," (",If[FailureQ[rc],StringTake[ToString[rc["Reason"]],UpTo[200]],"?"],"); the other form next"];
        rc=Catch[jetPsiIntClose[F,ctr,ep,Max[60,left-60],!shiftFirst],"jet"];
        If[AssociationQ[rc],Throw[rc,"jet"]]];
      If[TrueQ[$jetPsiIntOnly],jetRefuse["psi-integral route refused ("<>If[FailureQ[rc],StringTake[ToString[rc["Reason"]],UpTo[300]],"?"]<>"); first pass: the regulated multiplication theorem is left to the second pass"]];
      jetP["psi-integral route refused (",If[FailureQ[rc],rc["Reason"],"?"],"); regulated multiplication theorem next"]]];
  (* the first pass of the piece chain asks for the psi-integral route only (Global flag set by ladClosePiece) *)
  If[TrueQ[$jetPsiIntOnly],jetRefuse["first pass: outside the psi-integral class; the regulated multiplication theorem is left to the second pass"]];
  (* legs: distinct arguments with their factor lists *)
  legs=GatherBy[pg,#[[2]]&];
  combos=Table[{legs[[i,1,2]],jetLegCombination[legs[[i]]]},{i,Length[legs]}];   (* {a, {{c, lambda}, ...}} *)
  n=Total[(#[[1]]+1) #[[3]]&/@pg];
  jetP["weight ",n,", ",Length[legs]," leg(s): ",Table[{InputForm[legs[[i,1,2]]],Length[combos[[i,2]]]," combination(s)"},{i,Length[legs]}]];
  (* the undressed integral for the order-0 gate *)
  und=Catch[jetLadder[K,ctr,ep,0,Min[600,left]],"jet"];
  If[FailureQ[und],und=jetTowerSample[K,ctr,ep,0,Min[900,left]]];
  und=und[[1]];
  (* every tuple of leg combinations = one regulated kernel family with its copy orders *)
  terms=Tuples[combos[[All,2]]];
  Do[Module[{coef=Times@@tm[[All,1]],lams=tm[[All,2]],regs,kap,g,grid,val},
      (* regulators: one per copy: {leg index, copy index, order} *)
      regs=Flatten[Table[{i,j,lams[[i,j]]},{i,Length[lams]},{j,Length[lams[[i]]]}],1];
      (* EXTRACTION.  The ladder is an exact Laurent expansion (no internal regulator splitting), so the ep^n coefficient
         C_n(kappa) = sum_{|alpha| = n} I_alpha kappa^alpha/alpha! is homogeneous.  CUBE scheme (0/1 samples only, the
         slow kappa >= 2 ladder samples avoided): the Moebius sum over the sub-cubes isolates the alphas of full support;
         when every composition alpha of n into the copies is a permutation of lambda WITHIN each leg (copies of one leg
         are interchangeable, I_alpha = I_lambda), I_lambda = lambda! x Moebius / #compositions.  Otherwise the forward
         differences Delta^lambda on the grid kappa_i = 0..lambda_i (exact, any polynomial of degree <= n). *)
      Module[{m=Length[regs],comps,cubeQ,wt,norm,engine="ladder",steps,gAll,slopes,Kfam,sample,val0},
        (* REGULATOR SCALE per leg: d = slope x kappa x step x ep (the unit sub-legs of a slope-k leg carry the kappa x step
           multiple of ep); C_n carries prod slope_r^lambda_r, divided out at the end *)
        slopes=Table[Abs[Coefficient[combos[[regs[[r,1]],1]],z]],{r,Length[regs]}];
        (* ENGINE: the ladder on the term's all-ones sample first; a refusal sends the WHOLE term to the tower engine
           (one engine and one fixed family per term) *)
        gAll=jetProductForm[Cancel[Together[K Product[jetRegLeg[combos[[regs[[r,1]],1]],slopes[[r]] ep,z],{r,Length[regs]}]]]];
        If[FailureQ[Catch[jetLadder[gAll,ctr,ep,n,Min[Max[60,left/3],left]],"jet"]],engine="tower";
          jetP["term with copy orders ",regs[[All,3]],": the ladder refused the all-ones sample -> tower engine"]];
        Which[engine==="ladder",
          comps=Select[Tuples[Range[1,n-m+1],m],Total[#]==n&];
          cubeQ=AllTrue[comps,Function[al,AllTrue[DeleteDuplicates[regs[[All,1]]],
            Function[i,Sort[Pick[al,regs[[All,1]],i]]===Sort[Pick[regs[[All,3]],regs[[All,1]],i]]]]]];
          If[cubeQ,
            grid=Tuples[{0,1},m];wt[kv_]:=(-1)^(m-Total[kv]);norm=(Times@@(regs[[All,3]]!))/Length[comps];steps=ConstantArray[1,m],
            (* BOUNDED GRID: kappa_r = j/lambda_r, j = 0..lambda_r -- every kappa <= 1 (a coefficient 2 stalls
               the ladder); Delta^lambda on that grid = lambda! x coefficient / prod lambda_r^lambda_r *)
            grid=Tuples[Range[0,#[[3]]]&/@regs];wt[kv_]:=Times@@Table[(-1)^(regs[[r,3]]-kv[[r]]) Binomial[regs[[r,3]],kv[[r]]],{r,m}];
            steps=Table[1/regs[[r,3]],{r,m}];norm=Times@@Table[regs[[r,3]]^regs[[r,3]],{r,m}]];
          Kfam=K;
          jetP["term with copy orders ",regs[[All,3]],": ladder, ",If[cubeQ,"cube scheme","bounded forward-difference grid"],", ",Length[grid]," sample(s)"],
          True,
          grid=Tuples[Range[0,#[[3]]]&/@regs];wt[kv_]:=Times@@Table[(-1)^(regs[[r,3]]-kv[[r]]) Binomial[regs[[r,3]],kv[[r]]],{r,m}];
          steps=jetSteps[regs];norm=1/Times@@Table[steps[[r]]^regs[[r,3]],{r,m}];
          Kfam=s2NormalizeInner[K,z,1/7];   (* the one fixed splitting of the family *)
          jetP["term with copy orders ",regs[[All,3]],": tower, forward-difference grid with steps ",steps,", ",Length[grid]," sample(s); family ",Short[Kfam,2]]];
        sample[kv_]:=Module[{gk},
          gk=If[engine==="ladder",
            jetProductForm[Cancel[Together[Kfam Product[jetRegLeg[combos[[regs[[r,1]],1]],kv[[r]] steps[[r]] slopes[[r]] ep,z],{r,Length[regs]}]]]],
            (* tower: the split family times the copies, NO Cancel/Together across the split legs (a copy's denominator
               Gamma(a) must not be cancelled against a split Gamma(a + nu ep) partner by accident; plain product) *)
            Kfam Product[jetRegLeg[combos[[regs[[r,1]],1]],kv[[r]] steps[[r]] slopes[[r]] ep,z],{r,Length[regs]}]];
          If[left<30,jetRefuse["budget spent after "<>ToString[nSamples]<>" sample(s)"]];
          If[engine==="ladder",jetLadder[gk,ctr,ep,n,Min[Max[60,left-20],left]],jetTowerSample[gk,ctr,ep,n,Min[Max[60,left-20],left]]]];
        val=norm Sum[Module[{kv=grid[[s]],fam,cn},
            fam=sample[kv];nSamples++;
            If[!TrueQ[Abs[N[gbNumJ[fam[[1]]-und],30]]<10^-20 Max[1,Abs[N[gbNumJ[und],30]]]],jetRefuse["a sample's order-0 coefficient differs from the undressed integral"]];
            cn=fam[[n+1]];
            wt[kv] cn],{s,Length[grid]}];
        val=val/Times@@Table[slopes[[r]]^regs[[r,3]],{r,Length[regs]}]];
      total+=coef val],{tm,terms}];
  total=mbeCanonicalConstants[Expand[total]];
  q=ladQuad[F,ctr];
  If[!ladGateQ[total,q],jetRefuse["jet gate: "<>ToString[N[gbNumJ[total],15]]<>" vs quadrature "<>ToString[If[NumericQ[q],N[q,15],q]]]];
  jetP["closed in ",Round[AbsoluteTime[]-t0]," s with ",nSamples," ladder sample(s): ",N[gbNumJ[total],12]];
  <|"Value"->total,"Method"->"jet rung ("<>ToString[nSamples]<>" ladder samples, weight "<>ToString[n]<>", gated)","Quad"->q|>],"jet"];
(* numerics: N first, then the closers' Ginsh evaluator if present *)
gbNumJ[e_]:=Module[{v=Quiet@N[e,30]},If[NumericQ[v],v,If[DownValues[Global`gbNum]=!={},Global`gbNum[e],If[DownValues[Global`s2Gnum]=!={},Global`s2Gnum[e],$Failed]]]];
jetPieceGated[F_,ctr_List,sec_:2400]:=Module[{r=jetPieceClose[F,ctr,ladEp,sec]},r];
Print["[uint_jet_rung] jet rung loaded (polygamma dressings as regulator jets of copied legs; regulated multiplication theorem; ladder samples; forward differences; gated)."];
