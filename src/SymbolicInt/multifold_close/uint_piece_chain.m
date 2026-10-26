(* uint_piece_chain.m  (1 October 2026) -- the closer chain of ONE eps-free MB piece, shared by the subkernel
   worker (uint_piece_worker_bn.m) and the diagnostic probes.  The caller has loaded the package stack, the Mellin tower
   rung, uint_b22_lib.m, uint_bn_lib.m, uint_bg_lib.m and uint_fcu_s2.m (with the bare names ep, e0, closeSeconds set), and
   sets before Get: ladEp (the regulator symbol) and, optionally, the budgets ladLadderSec (ladder, default 300 s),
   ladS2Sec (slope-two closer, 2400), ladUnitSec (unit tower, 1800), ladPieceSec (total per piece, 3600), and ladHeart
   (a heartbeat hook ladHeart[piece, stage], a no-op by default).

   ladClosePiece[F, ctr, k]  -> <|"Value" -> exact, "Method" -> ..., "Quad" -> quadrature|> or Failure["Piece", <|"Reason"|>]

   Chain of a one-fold: Barnes 2+2 closed form (gated) -> generalized Barnes (gated) -> slope-two closer (gated) -> unit
   tower at a scale (gated) -> the one-fold tower ladder of the theory (gated here).  Multi-fold: the iterated Barnes 2+2
   (gated).  When the direct chain refuses a one-fold, EXACT REWRITES and the chain on every monomial, the sum gated:
     (i)  same-slope integer-distance Gamma pairs cancelled into Pochhammer polynomials (Gamma(4+2z)/Gamma(2+2z) =
          (2+2z)(3+2z); the closed forms refuse a slope-two leg they would never see otherwise);
     (ii) on a unit-slope Gamma kernel the multiplication theorem for polygammas of slope |m| >= 2,
          psi^(k)(m x) = delta_k0 log m + m^(-k-1) sum_{j<m} psi^(k)(x + j/m),
          after which the monomials carry unit-slope polygammas only (the unit tower's class).
   Each identity is checked at a complex point.  Every value is exact; the quadratures are gates only. *)
ladPieceChainVersion="2026-10-02a";
If[!ValueQ[ladLadderSec],ladLadderSec=180];If[!ValueQ[ladS2Sec],ladS2Sec=2400];If[!ValueQ[ladUnitSec],ladUnitSec=1800];If[!ValueQ[ladJetSec],ladJetSec=2400];If[!ValueQ[ladPieceSec],ladPieceSec=3600];
If[DownValues[ladHeart]==={},ladHeart[___]:=Null];
(* 2 October 2026: a stage starts with the package switches of the loader.  HPL and HypExp change their automatic-conversion
   switches globally during a call and restore them at its end; a stage stopped by its time limit inside such a call left
   them changed for every later stage and piece of the kernel (mbeFlagGuard.m; a term then arrives in another form and a
   closer that takes it in seconds refuses it) *)
ladStage[k_,stage_]:=(Global`mbeFlagGuardRestore["piece "<>ToString[k]<>", before "<>ToString[stage]];ladHeart[k,stage]);
(* 2 October 2026: TWO PASSES for a one-fold piece with a polygamma of a slope >= 2 argument for which an exact rewrite
   exists (the multiplication theorem turns it into unit-slope monomials).  The stages of the direct chain have budgets
   (slope-two closer 2400 s, jet rung 2400 s, unit tower 1800 s) whose sum exceeds the 3600 s of a piece, and on one kernel
   of MB8bu residue 21 (Gamma(-s)^2 Gamma(-1+s) Gamma(2+s) with psi(1-2s), psi(1-2s)^2, psi'(1-2s): thirteen pieces) the
   slow engines used the whole budget, although the tower ladder closes psi'(1-2s) there in under five minutes and the
   rewrite closes psi(1-2s) in fifteen.  For this class:
     pass 1 (at most ladFirstPassSec): the closed forms, the slope-two closer and the jet rung's psi-integral route ONLY
             (no regulated multiplication theorem, no unit tower: they are the slow engines of the class);
     then the tower ladder on the piece, then the exact rewrites (at most ladRewriteSec),
     then pass 2: the full direct chain with the time that is left.
   Every other piece takes the chain as before. *)
If[!ValueQ[ladFirstPassSec],ladFirstPassSec=1500];If[!ValueQ[ladRewriteSec],ladRewriteSec=1200];
If[!ValueQ[ladFirstPass],ladFirstPass=False];
ladSlopePsiQ[F_,z_]:=!FreeQ[F,PolyGamma[_,a_]/;Abs[Coefficient[a,z]]>=2];
ladExactQ[x_]:=FreeQ[x,_Real|$Failed|$Aborted|$TimedOut|Indeterminate|ComplexInfinity|DirectedInfinity|_MBint|_HypergeometricPFQ|_SeriesData|_Missing|_Failure]&&
  FreeQ[x,s_Symbol/;StringContainsQ[SymbolName[Unevaluated[s]],"Failed"|"Aborted"|"TimedOut"],{0,Infinity},Heads->True];
ladQuad[F_,ctr_List]:=Module[{vs=Keys[ctr],ts,ig},
  ts=Table[Unique["Global`ladtq"],{Length[vs]}];ig=F/.Thread[vs->(Values[ctr]+I ts)];
  Quiet@TimeConstrained[Switch[Length[vs],
    1,NIntegrate[ig,Evaluate[{ts[[1]],-60,60}],WorkingPrecision->30,PrecisionGoal->14,MaxRecursion->40]/(2 Pi),
    2,NIntegrate[ig,Evaluate[Sequence@@({#,-30,30}&/@ts)],PrecisionGoal->8,MaxRecursion->20,MaxPoints->4*10^6]/(2 Pi)^2,
    _,$Failed],300,$TimedOut]];
ladGateQ[v_,q_,nf_:1]:=TrueQ[NumericQ[q]&&NumericQ[N[v,30]]&&Abs[N[v,40]-q]<If[nf==1,10^-10,10^-6] Max[1,Abs[q]]];
ladReason[r_]:=Which[FailureQ[r],ToString[r["Reason"]],r===$Aborted||r===$TimedOut,"time limit",True,ToString[Short[r,3],InputForm]];
(* ---- exact rewrites ---- *)
ladCheckQ[F_,G_,zs_List]:=Module[{pt=Thread[zs->(1/5+I/7+Range[Length[zs]]/11)],a,b},
  a=Quiet@N[F/.pt,30];b=Quiet@N[G/.pt,30];
  TrueQ[NumericQ[a]&&NumericQ[b]&&Abs[a-b]<10^-20 Max[1,Abs[a]]]];
ladGammaCancel[F_,zs_List]:=Module[{fs=If[Head[F]===Times,List@@F,{F}],nums,dens,G=F,changed=False},
  nums=Cases[fs,Gamma[a_]/;!FreeQ[a,Alternatives@@zs]:>Expand[a]];
  dens=Cases[fs,Power[Gamma[a_],-1]/;!FreeQ[a,Alternatives@@zs]:>Expand[a]];
  Do[Module[{m=SelectFirst[nums,IntegerQ[Expand[#-d]]&&Expand[#-d]>=0&,None]},
      If[m=!=None,G=G Gamma[d] FunctionExpand[Pochhammer[d,Expand[m-d]]]/Gamma[m];nums=DeleteCases[nums,m,1,1];changed=True]],{d,dens}];
  If[!changed,Return[F,Module]];
  G=Expand[G/.Gamma[a_]:>Gamma[Expand[a]]];
  If[ladCheckQ[F,G,zs],G,F]];
ladBgCandidateQ[F_,z_]:=Module[{fs=If[Head[F]===Times,List@@F,{F}],up=0,down=0,den=0},
  Do[Which[MatchQ[t,Gamma[a_]/;Coefficient[Expand[a],z]===1],up++,MatchQ[t,Power[Gamma[a_],n_Integer?Positive]/;Coefficient[Expand[a],z]===1],up+=t[[2]],
      MatchQ[t,Gamma[a_]/;Coefficient[Expand[a],z]===-1],down++,MatchQ[t,Power[Gamma[a_],n_Integer?Positive]/;Coefficient[Expand[a],z]===-1],down+=t[[2]],
      MatchQ[t,Power[Gamma[a_],_Integer?Negative]/;Coefficient[Expand[a],z]=!=0],den++],{t,fs}];
  (up>=3||down>=3)&&den>=1];
(* (iii) POLYGAMMA LATTICE NORMALIZATION (1 October 2026: one hard closure per Gamma kernel and
   lattice class): every polygamma argument L is shifted by an integer to the representative L0 whose real part on the
   contour lies in (-1/2, 1/2]; psi^(m)(L0+n) = psi^(m)(L0) + (-1)^m m! sum_{j<n} 1/(L0+j)^(m+1) (and the mirror for
   negative shifts).  The rational remainders are closed by the closed forms (Newton) or by the closers' operator route;
   the hard polygamma closure of a lattice class is then shared by every dressing on that lattice.  Checked numerically. *)
ladPsiShift[F_,zs_List,ctr_List]:=Module[{G,rule,reVal},
  reVal[a_]:=Re[N[a/.ctr,30]];
  (* integer lattices only: shifting a half-integer argument (psi(5/2+z) -> psi(3/2+z) + 1/(3/2+z)) creates rational
     factors with half-integer poles, which neither the Newton absorption nor the (Theta+a)^-1 operator closes (piece 71) *)
  (* unit slope only (psi(4+2z) -> psi(2+2z) + 1/(2+2z) + 1/(3+2z) has a half-integer pole although the
     constants are integers); interval (-1/2, 1/2] exactly: n = Ceiling[Re - 1/2] *)
  (* half-integer lattices again allowed: the rational operator takes half-integer poles left of the contour (Y = x^2) *)
  rule=PolyGamma[m_Integer,a_]/;(Module[{e=Expand[a]},!FreeQ[e,Alternatives@@zs]&&AllTrue[zs,MemberQ[{0,1,-1},Coefficient[e,#]]&]&&IntegerQ[2 Expand[e/.Thread[zs->0]]]&&NumericQ[reVal[e]]&&!(-1/2<reVal[e]<=1/2)]):>
    Module[{e=Expand[a],n,L0},n=Ceiling[Rationalize[reVal[e],0]-1/2];L0=Expand[e-n];
      If[n>0,PolyGamma[m,L0]+(-1)^m m! Sum[1/(L0+j)^(m+1),{j,0,n-1}],
             PolyGamma[m,L0]-(-1)^m m! Sum[1/(L0-j)^(m+1),{j,1,-n}]]];
  G=F/.rule;
  If[G===F,Return[F,Module]];
  G=Expand[G];
  If[ladCheckQ[F,G,zs],G,F]];
ladUnitKernelQ[F_,zs_List]:=!AnyTrue[Cases[F,Gamma[a_]:>a,{0,Infinity}],Function[a,AnyTrue[zs,Abs[Coefficient[Expand[a],#]]>=2&]]];
ladPsiMult[F_,zs_List]:=Module[{G,rule},
  rule=PolyGamma[k_Integer,a_]/;(Module[{e=Expand[a]},AnyTrue[zs,Abs[Coefficient[e,#]]>=2&]]):>
    Module[{e=Expand[a],m,x},m=Max[Abs[Coefficient[e,#]]&/@zs];x=Expand[e/m];
      If[k==0,Log[m],0]+m^(-k-1) Sum[PolyGamma[k,x+j/m],{j,0,m-1}]];
  G=F/.rule;
  If[G===F,Return[F,Module]];
  G=Expand[G];
  If[ladCheckQ[F,G,zs],G,F]];
(* ---- the chain of ONE piece without rewrites ---- *)
ladChainOne[F_,ctr_List,k_,budget_,ladderQ_:True]:=Module[{nv=Length[ctr],t0=AbsoluteTime[],left,reasons={},r,fam,q,z,out},
  (* 2026-10-01: no stage starts once the budget is spent; a spent budget is reported as such *)
  left:=budget-(AbsoluteTime[]-t0);
  out[res_]:=Return[res,Module];
  If[!FreeQ[F,ladEp],Return[Failure["Chain",<|"Reason"->"eps in piece"|>],Module]];
  If[nv>=2,
    If[left<=5,Return[Failure["Chain",<|"Reason"->"budget spent"|>],Module]];
    ladStage[k,"iterated barnes22"];
    r=Quiet@bnGated[F,ctr,Min[ladLadderSec,left]];
    If[AssociationQ[r]&&ladExactQ[r["Value"]],Return[<|"Value"->r["Value"],"Method"->"iterated barnes22","Quad"->r["Quad"]|>,Module]];
    AppendTo[reasons,"bn: "<>ladReason[r]];
    (* 2026-10-01: the general TWO-fold closer -- psi split, Gamma copies by a finite-regulator Barnes
       lemma, generalized Barnes -> Euler kernel -> Mellin tower at the scale -> folded exact last fold; every step gated,
       the total gated by the two-fold quadrature inside gbTwoFold *)
    If[nv>=2&&DownValues[gbMultiFold]=!={}&&left>30,
      ladStage[k,"multi-fold closer (Barnes lemmas, generalized Barnes -> Euler kernel)"];
      (* 2 October 2026: the multi-fold closer is the last stage of a multi-fold piece and takes the whole remaining piece
         budget; under the slope-two budget (900 s in the pool) its Euler copy route was cut off on MB8au residue 43 piece 79
         (closed in 469 s alone, more inside a loaded pool) and the piece fell to the sealed lane *)
      r=Quiet@gbMultiFold[F,ctr,left];
      If[AssociationQ[r]&&ladExactQ[r["Value"]],Return[<|"Value"->r["Value"],"Method"->"multi-fold closer: "<>r["Method"],"Quad"->r["Quad"]|>,Module]];
      AppendTo[reasons,"gb: "<>ladReason[r]]];
    Return[Failure["Chain",<|"Reason"->StringRiffle[reasons," | "]|>],Module]];
  z=ctr[[1,1]];
  If[left<=5,Return[Failure["Chain",<|"Reason"->"budget spent before the closed forms"|>],Module]];
  ladStage[k,"barnes22"];
  r=Quiet@b22Gated[F,ctr,Min[120,left]];
  If[AssociationQ[r]&&ladExactQ[r["Value"]],Return[<|"Value"->r["Value"],"Method"->"barnes22","Quad"->r["Quad"]|>,Module]];
  AppendTo[reasons,"b22: "<>ladReason[r]];
  (* the generalized lemma (3+2 over 1 -> 3F2(1) by HypExp) is tried only on candidates: at least three unit-slope legs of
     one orientation and a denominator leg; a HypExp refusal costs its whole budget *)
  If[left<=5,Return[Failure["Chain",<|"Reason"->StringRiffle[Append[reasons,"budget spent"]," | "]|>],Module]];
  If[DownValues[bgGated]=!={}&&ladBgCandidateQ[F,z],
    ladStage[k,"generalized barnes"];
    r=Quiet@bgGated[F,ctr,Min[150,left]];
    If[AssociationQ[r]&&ladExactQ[r["Value"]],Return[<|"Value"->r["Value"],"Method"->"generalized barnes","Quad"->r["Quad"]|>,Module]];
    AppendTo[reasons,"bg: "<>ladReason[r]]];
  If[left<=5,Return[Failure["Chain",<|"Reason"->StringRiffle[Append[reasons,"budget spent"]," | "]|>],Module]];
  If[DownValues[s2PieceGated]=!={}&&TrueQ[s2PieceSlope2Q[F,ctr]],
    ladStage[k,"slope-two closer"];
    r=Quiet@s2PieceGated[F,ctr,Min[ladS2Sec,left]];
    If[AssociationQ[r]&&ladExactQ[r["Value"]],Return[<|"Value"->r["Value"],"Method"->"slope-two closer","Quad"->r["Quad"]|>,Module]];
    AppendTo[reasons,"s2: "<>ladReason[r]]];
  If[left<=5,Return[Failure["Chain",<|"Reason"->StringRiffle[Append[reasons,"budget spent"]," | "]|>],Module]];
  (* 2026-10-01 13:2x: the JET RUNG (uint_jet_rung.m) -- polygamma dressings of a unit-slope kernel as regulator jets of
     copied legs, closed by ladder samples and forward differences; FIRST for dressings of weight >= 2 (the unit tower's
     weak class: psi x psi, psi^2, psi'), AFTER the unit tower for weight 1 *)
  If[DownValues[jetPieceGated]=!={}&&TrueQ[Quiet@jetCandidateQ[F,z]]&&jetWeight[F]>=2,
    ladStage[k,"jet rung"];
    r=Block[{$jetPsiIntOnly=TrueQ[ladFirstPass]},Quiet@jetPieceGated[F,ctr,Min[ladJetSec,left]]];
    If[AssociationQ[r]&&ladExactQ[r["Value"]],Return[<|"Value"->r["Value"],"Method"->r["Method"],"Quad"->r["Quad"]|>,Module]];
    AppendTo[reasons,"jet: "<>ladReason[r]]];
  If[left<=5,Return[Failure["Chain",<|"Reason"->StringRiffle[Append[reasons,"budget spent"]," | "]|>],Module]];
  If[DownValues[s2UnitPieceGated]=!={}&&!TrueQ[ladFirstPass]&&ladUnitKernelQ[F/.PolyGamma[__]->1,{z}],
    ladStage[k,"unit tower at a scale"];
    r=Quiet@s2UnitPieceGated[F,Normal[ctr],Min[ladUnitSec,left]];
    If[AssociationQ[r]&&ladExactQ[r["Value"]],Return[<|"Value"->r["Value"],"Method"->"unit tower at a scale","Quad"->r["Quad"]|>,Module]];
    AppendTo[reasons,"unit: "<>ladReason[r]]];
  If[left<=5,Return[Failure["Chain",<|"Reason"->StringRiffle[Append[reasons,"budget spent"]," | "]|>],Module]];
  If[DownValues[jetPieceGated]=!={}&&TrueQ[Quiet@jetCandidateQ[F,z]]&&jetWeight[F]<2,
    ladStage[k,"jet rung"];
    r=Block[{$jetPsiIntOnly=TrueQ[ladFirstPass]},Quiet@jetPieceGated[F,ctr,Min[ladJetSec,left]]];
    If[AssociationQ[r]&&ladExactQ[r["Value"]],Return[<|"Value"->r["Value"],"Method"->r["Method"],"Quad"->r["Quad"]|>,Module]];
    AppendTo[reasons,"jet: "<>ladReason[r]]];
  If[!TrueQ[ladderQ],Return[Failure["Chain",<|"Reason"->StringRiffle[reasons," | "]|>],Module]];
  If[left<=5,Return[Failure["Chain",<|"Reason"->StringRiffle[Append[reasons,"budget spent before the ladder"]," | "]|>],Module]];
  (* the one-fold tower ladder of the theory, LAST (slow, and its engine fallbacks served wrong values on this class);
     the value is gated by the contour quadrature *)
  ladStage[k,"ladder"];
  fam=Quiet@TimeConstrained[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[{MBint[F,{{ladEp->0},ctr}]},ladEp,0,0,False],Min[ladLadderSec,left],$Aborted];
  If[ListQ[fam]&&Length[fam]==1&&ladExactQ[fam]&&FreeQ[fam,ladEp],
    q=ladQuad[F,ctr];
    If[ladGateQ[fam[[1]],q],Return[<|"Value"->fam[[1]],"Method"->"ladder (gated)","Quad"->q|>,Module]];
    AppendTo[reasons,"ladder gate: "<>ToString[N[fam[[1]],15]]<>" vs quadrature "<>ToString[If[NumericQ[q],N[q,15],q]]],
    AppendTo[reasons,"ladder: "<>ladReason[fam]]];
  Failure["Chain",<|"Reason"->StringRiffle[reasons," | "]|>]];
(* ---- the exact rewrites of a one-fold piece with the chain (closed forms, closers; no ladder) on every monomial, the sum
        gated by the quadrature of the ORIGINAL piece ---- *)
ladRewriteForm[F_,ctr_List]:=Module[{zs=Keys[ctr],G},
  G=ladGammaCancel[F,zs];
  If[ladUnitKernelQ[G/.PolyGamma[__]->1,zs],G=ladPsiMult[G,zs]];
  ladPsiShift[G,zs,ctr]];
ladRewriteClose[F_,ctr_List,k_,budget_]:=Module[{t0=AbsoluteTime[],zs=Keys[ctr],G,mons,vals={},reasons={},q,total,left},
  left:=budget-(AbsoluteTime[]-t0);
  G=ladRewriteForm[F,ctr];
  If[G===F,Return[Failure["Rewrite",<|"Reason"->"no exact rewrite applies"|>],Module]];
  mons=If[Head[G]===Plus,List@@G,{G}];
  (* 2026-10-01 11:4x: monomials with the same non-polynomial part (Gamma kernel, polygammas, reciprocal factors) are
     closed as ONE piece with the summed polynomial coefficient -- every closer takes a polynomial (Newton expansion,
     absorption into the legs, the operator); the psi^2 pieces of MB8au r43's copy coefficients came as 9 monomials,
     each a 120 s unit-tower closure, where 3 grouped pieces suffice *)
  mons=Module[{polyQ,parts},
    polyQ[f_]:=PolynomialQ[f,zs];
    parts=Function[m,With[{fs=If[Head[m]===Times,List@@m,{m}]},{Times@@Select[fs,!polyQ[#]&],Times@@Select[fs,polyQ]}]]/@mons;
    (Expand[Total[#[[All,2]]]] #[[1,1]])&/@GatherBy[parts,First]];
  Print["    [chain] piece ",k,": exact rewrite -> ",Length[mons]," grouped piece(s): ",InputForm[Short[G,6]]];
  ladStage[k,"rewritten monomials"];
  Do[Module[{m=mons[[j]],cz,mz,rm},
      cz=Times@@Select[If[Head[m]===Times,List@@m,{m}],FreeQ[#,Alternatives@@zs]&];mz=Cancel[m/cz];
      If[FreeQ[mz,Alternatives@@zs],AppendTo[vals,m];Continue[]];
      If[left<=5,AppendTo[reasons,"budget spent at monomial "<>ToString[j]];Break[]];
      rm=ladChainOne[mz,ctr,k,left,False];
      If[AssociationQ[rm],AppendTo[vals,cz rm["Value"]];Print["    [chain] piece ",k,": monomial ",j,"/",Length[mons]," closed (",rm["Method"],")"],
        AppendTo[reasons,"monomial "<>ToString[j]<>" ("<>ToString[InputForm[Short[mz,3]]]<>"): "<>rm["Reason"]];Break[]]],{j,Length[mons]}];
  If[Length[vals]=!=Length[mons],Return[Failure["Rewrite",<|"Reason"->StringRiffle[reasons," || "]|>],Module]];
  total=Expand[Total[vals]];
  q=ladQuad[F,ctr];
  If[ladGateQ[total,q],<|"Value"->total,"Method"->"exact rewrite ("<>ToString[Length[mons]]<>" monomials, gated)","Quad"->q|>,
    Failure["Rewrite",<|"Reason"->"rewrite gate: "<>ToString[N[total,15]]<>" vs quadrature "<>ToString[If[NumericQ[q],N[q,15],q]]|>]]];
(* ---- a piece: closed forms and closers on the piece, the exact rewrites, then the ladder on the original piece (last:
        slow; 300 s per piece that the rewrite would close in seconds) ---- *)
(* the tower ladder on a piece, gated by the contour quadrature *)
ladLadderTry[F0_,ctr_List,k_,sec_]:=Module[{fam,q},
  ladStage[k,"ladder"];
  fam=Quiet@TimeConstrained[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[{MBint[F0,{{ladEp->0},ctr}]},ladEp,0,0,False],sec,$Aborted];
  If[ListQ[fam]&&Length[fam]==1&&ladExactQ[fam]&&FreeQ[fam,ladEp],
    q=ladQuad[F0,ctr];
    If[ladGateQ[fam[[1]],q],<|"Value"->fam[[1]],"Method"->"ladder (gated)","Quad"->q|>,
      Failure["Ladder",<|"Reason"->"ladder gate: "<>ToString[N[fam[[1]],15]]<>" vs quadrature "<>ToString[If[NumericQ[q],N[q,15],q]]|>]],
    Failure["Ladder",<|"Reason"->"ladder: "<>ladReason[fam]|>]]];
ladClosePiece[F0_,ctr_List,k_]:=Module[{t0=AbsoluteTime[],r,reasons={},left,twoPass},
  left:=ladPieceSec-(AbsoluteTime[]-t0);
  Global`mbeFlagGuardRestore["piece "<>ToString[k]];
  twoPass=Length[ctr]===1&&TrueQ[Quiet@ladSlopePsiQ[F0,ctr[[1,1]]]]&&Quiet@Check[ladRewriteForm[F0,ctr],F0]=!=F0;
  If[twoPass,
    r=Block[{ladFirstPass=True},ladChainOne[F0,ctr,k,Min[ladPieceSec,ladFirstPassSec],False]];
    If[AssociationQ[r],Return[r,Module]];
    AppendTo[reasons,"first pass: "<>r["Reason"]];
    If[left>30,
      r=ladLadderTry[F0,ctr,k,Min[ladLadderSec,left]];
      If[AssociationQ[r],Return[r,Module]];
      AppendTo[reasons,r["Reason"]]];
    If[left>30,
      r=ladRewriteClose[F0,ctr,k,Min[ladRewriteSec,left]];
      If[AssociationQ[r],Return[r,Module]];
      AppendTo[reasons,"rewrite: "<>r["Reason"]]];
    If[left>120,
      r=ladChainOne[F0,ctr,k,left,False];
      If[AssociationQ[r],Return[r,Module]];
      AppendTo[reasons,"second pass: "<>r["Reason"]],
      AppendTo[reasons,"budget spent before the second pass"]];
    Return[Failure["Piece",<|"Reason"->StringRiffle[reasons," || "]|>],Module]];
  r=ladChainOne[F0,ctr,k,ladPieceSec,False];
  If[AssociationQ[r],Return[r,Module]];
  AppendTo[reasons,"direct: "<>r["Reason"]];
  If[Length[ctr]=!=1,Return[Failure["Piece",<|"Reason"->StringRiffle[reasons," || "]|>],Module]];
  If[left<=5,Return[Failure["Piece",<|"Reason"->StringRiffle[Append[reasons,"budget spent before the rewrites"]," || "]|>],Module]];
  r=ladRewriteClose[F0,ctr,k,left];
  If[AssociationQ[r],Return[r,Module]];
  AppendTo[reasons,"rewrite: "<>r["Reason"]];
  If[left<=5,Return[Failure["Piece",<|"Reason"->StringRiffle[Append[reasons,"budget spent before the ladder"]," || "]|>],Module]];
  r=ladLadderTry[F0,ctr,k,Min[ladLadderSec,left]];
  If[AssociationQ[r],Return[r,Module]];
  AppendTo[reasons,r["Reason"]];
  Failure["Piece",<|"Reason"->StringRiffle[reasons," || "]|>]];
Print["[uint_piece_chain] piece closer chain loaded (closed forms, slope-two closer, unit tower, gated ladder; exact rewrites: Gamma-pair cancellation, polygamma multiplication theorem)."];
