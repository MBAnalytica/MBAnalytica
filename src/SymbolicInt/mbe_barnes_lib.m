(* ============================================================
   mbe_barnes_lib.m — shared Barnes/tower machinery (2026-07-09)
   Get[] AFTER load_standard_w8.m + onefold_closure.m + pole_dictionary.m.
   Provides (all Global`, prefix mbl):
     mblGammasOf[f]                          {arg,power} pairs of Gamma factors
     mblCensus[f,v]                          up/down numerator/denominator census
     mblBarnes1[f,v,vrest,ctr,eps,e0]        1st-Barnes value+crossings+A-gate
     mblBarnes2[f,v,vrest,ctr,eps,e0]        2nd-Barnes (direct+reflected) ditto
     mblCloseLR[t,vR,cR,eps,e0]              margin-based tower closure {cl,dir,margin}
     mblExpandPFQ[p,eps,dep]                 0F0 | named-PD | PDExpand | $Failed
   All numeric checks at eps->e0 (small negative rational, e.g. -1/30).
   Barnes lemma 1: Int G(a+v)G(b+v)G(c-v)G(d-v) = G(a+c)G(a+d)G(b+c)G(b+d)/G(a+b+c+d).
   Barnes lemma 2: Int G(a+v)G(b+v)G(c+v)G(d-v)G(e-v)/G(a+b+c+d+e+v)
                   = G(a+d)G(b+d)G(c+d)G(a+e)G(b+e)G(c+e)/(G(a+b+d+e)G(a+c+d+e)G(b+c+d+e)).
   Crossing rule (validated res7/res12): down-pole (of G(x-v), poles v=x+n) LEFT of the
   resolved contour -> +Residue; up-pole (of G(x+v), poles v=-x-n) RIGHT of it -> -Residue.
   Every reduction MUST pass its numeric A-gate; callers abort loudly otherwise.
   ============================================================ *)
mblGammasOf[f_]:=Module[{fac,g={}},fac=If[Head[f]===Times,List@@f,{f}];
  Do[Which[MatchQ[t,Gamma[_]],AppendTo[g,{t[[1]],1}],
     MatchQ[t,Power[Gamma[_],_Integer]],AppendTo[g,{t[[1,1]],t[[2]]}]],{t,fac}];g];
mblCensus[f_,v_]:=Module[{g=Select[mblGammasOf[f],!FreeQ[#[[1]],v]&]},
  <|"upN"->Select[g,Coefficient[#[[1]],v]===1&&#[[2]]>0&],
    "dnN"->Select[g,Coefficient[#[[1]],v]===-1&&#[[2]]>0&],
    "upD"->Select[g,Coefficient[#[[1]],v]===1&&#[[2]]<0&],
    "dnD"->Select[g,Coefficient[#[[1]],v]===-1&&#[[2]]<0&],
    "other"->Select[g,!MemberQ[{1,-1},Coefficient[#[[1]],v]]&]|>];
mblExpand2[l_]:=Flatten@Table[ConstantArray[x[[1]],Abs[x[[2]]]],{x,l}];
(* ---- crossing census for a v-Gamma product at resolved contour cB ---- *)
(* 2026-10-01: the fixed scan n = 0..15 replaced by the exact bound of the crossed count,
   down-poles x0 + n < cB: n < cB - Re x0; up-poles -x0 - n > cB: n < -Re x0 - cB (one extra position is scanned, harmless) *)
mblCrossings[zpart_,v_,cB_,subs_List]:=Module[{g=mblGammasOf[zpart],crs={},numv,cBn},
  numv[x_]:=With[{y=x/.subs},If[NumericQ[y],Re[N[y,40]],$Failed]];cBn=numv[cB];
  Do[Module[{arg=gp[[1]],sl=Coefficient[gp[[1]],v],x0,p0,cnt},
    Which[
     sl===-1,x0=arg/.v->0;p0=numv[x0];  (* poles v=x0+n *)
      If[p0=!=$Failed&&cBn=!=$Failed,cnt=Max[0,Ceiling[cBn-p0]];Do[If[numv[x0+n]<cBn,AppendTo[crs,{+1,x0+n}]],{n,0,cnt}]],
     sl===1,x0=arg/.v->0;p0=numv[-x0];   (* poles v=-x0-n *)
      If[p0=!=$Failed&&cBn=!=$Failed,cnt=Max[0,Ceiling[p0-cBn]];Do[If[numv[-x0-n]>cBn,AppendTo[crs,{-1,-x0-n}]],{n,0,cnt}]]]],
   {gp,Select[g,#[[2]]>0&]}];
  DeleteDuplicatesBy[crs,#[[2]]&]];
(* ---- A-gate: numeric v-contour integral of zpart vs candidate closed value ---- *)
mblAGate[zpart_,v_,cB_,cand_,subs_List]:=Module[{A,BC},
  A=Quiet@NIntegrate[(zpart/.subs/.v->N[cB/.subs]+I Global`tGl),
     {Global`tGl,-Infinity,Infinity},WorkingPrecision->30,PrecisionGoal->12,MaxRecursion->16]/(2 Pi);
  BC=Quiet@N[cand/.subs,20];
  <|"A"->A,"BC"->BC,"Pass"->TrueQ[Abs[A-BC]<10^-6(1+Abs[A])]|>];
(* ---- FIRST Barnes reduction of variable v; returns Failure or
        <|"Terms"->{...}, "Gate"-><|..|>|> with Terms = rest*(Bt) and rest*(signed residues) ---- *)
mblBarnes1[f_,v_,ctr_,eps_,e0_]:=Module[
  {c=mblCensus[f,v],ups,dns,zpart,rest,as,cs,Bt,cB,subs,crs,crT,gate},
  ups=mblExpand2[c["upN"]];dns=mblExpand2[c["dnN"]];
  If[!(Length[ups]==2&&Length[dns]==2&&c["upD"]==={}&&c["dnD"]==={}&&c["other"]==={}),
    Return[$Failed]];
  zpart=Times@@(Gamma/@Join[ups,dns]);
  rest=Quiet@Simplify[f/zpart];
  If[!FreeQ[rest,v],Return[$Failed]];
  as=(#/.v->0)&/@ups;cs=(#/.v->0)&/@dns;
  Bt=Gamma[as[[1]]+cs[[1]]]Gamma[as[[1]]+cs[[2]]]Gamma[as[[2]]+cs[[1]]]Gamma[as[[2]]+cs[[2]]]/
     Gamma[Total[as]+Total[cs]];
  cB=v/.ctr;
  subs=Join[DeleteCases[ctr,v->_]/.Rule[a_,b_]:>Rule[a,Rationalize[b,0]],{eps->e0}];
  crs=mblCrossings[zpart,v,cB,subs];
  crT=Table[cr[[1]]*Residue[zpart,{v,cr[[2]]}],{cr,crs}];
  gate=mblAGate[zpart,v,cB,Bt+Total[crT],subs];
  If[!gate["Pass"],Return[Failure["Barnes1AGate",<|"Gate"->gate,"Crossings"->crs|>]]];
  <|"Terms"->Simplify/@Prepend[rest*#&/@crT,rest*Bt],"Gate"->gate,"Crossings"->crs|>];
(* ---- SECOND Barnes reduction (direct 3up2dn/1upD, or reflected 2up3dn/1dnD) ---- *)
mblBarnes2[f_,v_,ctr_,eps_,e0_]:=Module[
  {c=mblCensus[f,v],refl=False,ups,dns,den,g5,zpart,rest,aa,dd,ff,delta,B2,cB,subs,crs,crT,gate,w},
  ups=mblExpand2[c["upN"]];dns=mblExpand2[c["dnN"]];
  Which[
   Length[ups]==3&&Length[dns]==2&&Length[c["upD"]]==1&&c["dnD"]==={}&&c["other"]==={},
    den=c["upD"][[1,1]],
   Length[ups]==2&&Length[dns]==3&&Length[c["dnD"]]==1&&c["upD"]==={}&&c["other"]==={},
    refl=True;den=c["dnD"][[1,1]],
   True,Return[$Failed]];
  zpart=Times@@(Gamma/@Join[ups,dns])/Gamma[den];
  rest=Quiet@Simplify[f/zpart];
  If[!FreeQ[rest,v],Return[$Failed]];
  (* map to canonical G(a+s)G(b+s)G(c+s)G(d-s)G(e-s)/G(f+s): reflected case s=-v *)
  If[refl,
    {ups,dns}={(#/.v->-v)&/@dns,(#/.v->-v)&/@ups};den=den/.v->-v];
  aa=(#/.v->0)&/@ups;   (* now 3 of them *)
  dd=(#/.v->0)&/@dns;   (* 2 of them *)
  ff=den/.v->0;
  delta=Simplify[ff-(Total[aa]+Total[dd])];
  If[delta=!=0,Return[Failure["Barnes2Balance",<|"Delta"->delta|>]]];
  B2=(Gamma[aa[[1]]+dd[[1]]]Gamma[aa[[2]]+dd[[1]]]Gamma[aa[[3]]+dd[[1]]]*
      Gamma[aa[[1]]+dd[[2]]]Gamma[aa[[2]]+dd[[2]]]Gamma[aa[[3]]+dd[[2]]])/
     (Gamma[aa[[1]]+aa[[2]]+dd[[1]]+dd[[2]]]Gamma[aa[[1]]+aa[[3]]+dd[[1]]+dd[[2]]]*
      Gamma[aa[[2]]+aa[[3]]+dd[[1]]+dd[[2]]]);
  cB=If[refl,-(v/.ctr),v/.ctr];
  subs=Join[DeleteCases[ctr,v->_]/.Rule[a_,b_]:>Rule[a,Rationalize[b,0]],{eps->e0}];
  zpart=If[refl,zpart/.v->-v,zpart]; (* canonical-orientation product in v *)
  crs=mblCrossings[zpart,v,cB,subs];
  crT=Table[cr[[1]]*Residue[zpart,{v,cr[[2]]}],{cr,crs}];
  gate=mblAGate[zpart,v,cB,B2+Total[crT],subs];
  If[!gate["Pass"],Return[Failure["Barnes2AGate",<|"Gate"->gate,"Crossings"->crs|>]]];
  <|"Terms"->Simplify/@Prepend[rest*#&/@crT,rest*B2],"Gate"->gate,"Crossings"->crs,
    "Reflected"->refl|>];
(* ---- GENERALIZED Barnes reduction (v3, 2026-07-10): NO balance condition.
   [Mishima 1812.04373 (6.51) / DMSW 1801.09696 / Bailey 4.5; numerically certified
   genbarnes_cert_out.txt: 16-digit MATCH at 4 points incl. b3-swap invariance]
   (1/2pii) Int G(a1-v)G(a2-v)G(b1+v)G(b2+v)G(b3+v)/G(c+v) dv
   = [G(a1+b1)G(a2+b1)G(a1+b2)G(a2+b2)G(a1+b3)G(a2+b3)
      /(G(a1+a2+b1+b3)G(a1+a2+b2+b3)G(c-b3))]
     * 3F2({a1+b3, a2+b3, a1+a2+b1+b2+b3-c},{a1+a2+b1+b3, a1+a2+b2+b3},1).
   Unit-argument excess of the 3F2 = c-b3; b3 auto-chosen to maximize Re(c-b3).
   2nd Barnes lemma = special case c = Sum (Saalschuetzian 3F2 -> Gammas).
   Returns <|"Terms"->{rest*BG, rest*crossings...},"Gate"->..,"PFQ"->the 3F2,
   "Excess"->c-b3|>; if the 3F2 cannot be numericized at the gate point the gate
   is marked "NoNum" and the caller MUST rely on the downstream per-order gate. ---- *)
mblBarnesGen[f_,v_,ctr_,eps_,e0_]:=Module[
  {c=mblCensus[f,v],refl=False,ups,dns,den,zpart,rest,bb,aa,cc,cB,subs,b3i,
   pref,pfq,BG,crs,crT,gate,gv},
  ups=mblExpand2[c["upN"]];dns=mblExpand2[c["dnN"]];
  Which[
   Length[ups]==3&&Length[dns]==2&&Length[c["upD"]]==1&&c["dnD"]==={}&&c["other"]==={},
    den=c["upD"][[1,1]],
   Length[ups]==2&&Length[dns]==3&&Length[c["dnD"]]==1&&c["upD"]==={}&&c["other"]==={},
    refl=True;den=c["dnD"][[1,1]],
   True,Return[$Failed]];
  zpart=Times@@(Gamma/@Join[ups,dns])/Gamma[den];
  rest=Quiet@Simplify[f/zpart];
  If[!FreeQ[rest,v],Return[$Failed]];
  If[refl,{ups,dns}={(#/.v->-v)&/@dns,(#/.v->-v)&/@ups};den=den/.v->-v];
  bb=(#/.v->0)&/@ups;   (* 3 b's: Gamma(b+v) *)
  aa=(#/.v->0)&/@dns;   (* 2 a's: Gamma(a-v) *)
  cc=den/.v->0;
  cB=If[refl,-(v/.ctr),v/.ctr];
  subs=Join[DeleteCases[ctr,v->_]/.Rule[a_,b_]:>Rule[a,Rationalize[b,0]],{eps->e0}];
  (* choose b3 = the b maximizing Re(c - b3) (largest excess) *)
  b3i=First@Ordering[Table[-Re[N[(cc-b)/.subs]],{b,bb}],1];
  Module[{b3=bb[[b3i]],rests=Delete[bb,b3i],b1,b2},
   b1=rests[[1]];b2=rests[[2]];
   pref=Gamma[aa[[1]]+b1]Gamma[aa[[2]]+b1]Gamma[aa[[1]]+b2]Gamma[aa[[2]]+b2]*
        Gamma[aa[[1]]+b3]Gamma[aa[[2]]+b3]/
        (Gamma[aa[[1]]+aa[[2]]+b1+b3]Gamma[aa[[1]]+aa[[2]]+b2+b3]Gamma[cc-b3]);
   pfq=HypergeometricPFQ[{aa[[1]]+b3,aa[[2]]+b3,aa[[1]]+aa[[2]]+b1+b2+b3-cc},
        {aa[[1]]+aa[[2]]+b1+b3,aa[[1]]+aa[[2]]+b2+b3},1];
   BG=pref*pfq;
   zpart=If[refl,zpart/.v->-v,zpart];
   crs=mblCrossings[zpart,v,cB,subs];
   crT=Table[cr[[1]]*Residue[zpart,{v,cr[[2]]}],{cr,crs}];
   gv=Quiet@N[(BG+Total[crT])/.subs,20];
   gate=If[NumericQ[gv],mblAGate[zpart,v,cB,BG+Total[crT],subs],"NoNum"];
   If[gate=!="NoNum"&&!gate["Pass"],
     Return[Failure["BarnesGenAGate",<|"Gate"->gate,"Crossings"->crs|>]]];
   <|"Terms"->Prepend[Simplify/@(rest*#&/@crT),rest*BG],"Gate"->gate,
     "Crossings"->crs,"PFQ"->pfq,"Excess"->Simplify[cc-bb[[b3i]]],
     "Reflected"->refl|>]];
(* ---- margin-based tower closure ---- *)
mblTowerMargin[cl_,eps_,e0_]:=If[!FreeQ[cl,$Failed],-Infinity,
  Module[{ps=Union@Cases[cl["Exact"],_HypergeometricPFQ,Infinity]},
   If[ps==={},Infinity,
    Min@Table[Module[{m=Quiet@Re@N[(Total[p[[2]]]-Total[p[[1]]])/.eps->e0]},
      If[p[[3]]===-1,m+1,m]],{p,ps}]]]];
mblCloseLR[t_,vR_,cR_,eps_,e0_,allowRisky_:False]:=Module[{clR,clL,mR,mL},
  clR=Quiet@OFCClose[t,vR,eps,N[cR],eps->e0];
  clL=Quiet@OFCClose[t/.vR->-vR,vR,eps,-N[cR],eps->e0];
  mR=mblTowerMargin[clR,eps,e0];mL=mblTowerMargin[clL,eps,e0];
  Which[
   mR>=mL&&mR>1/50,{clR,"R",mR},
   mL>mR&&mL>1/50,{clL,"L",mL},
   allowRisky&&mR>=mL&&mR>-Infinity,{clR,"R-risky",mR},
   allowRisky&&mL>mR,{clL,"L-risky",mL},
   True,{$Failed,"pair",Max[mR,mL]}]];
(* ---- expansion: 0F0 -> named PD -> PDExpand(HypExp) ---- *)
mblNamedLookup[p_,dep_]:=Module[{hits},
  hits=Select[Values[$PoleDict],
    AssociationQ[#]&&KeyExistsQ[#,"Object"]&&#["Object"]===p&&
    KeyExistsQ[#,"Expansion"]&&Lookup[#,"Depth",0]>=dep&];
  If[hits==={},$Failed,First[hits]["Expansion"]]];
mblExpandPFQ[p_HypergeometricPFQ,eps_,dep_]:=Module[{e1,g},
  If[p[[1]]==={}&&p[[2]]==={},Return[Exp[p[[3]]]]];
  (* v3 2026-07-10: Gauss 2F1(1) short-circuit (exact, table-free at any depth) *)
  If[MatchQ[p,HypergeometricPFQ[{_,_},{_},1]],
    g=Gamma[p[[2,1]]]Gamma[p[[2,1]]-p[[1,1]]-p[[1,2]]]/
      (Gamma[p[[2,1]]-p[[1,1]]]Gamma[p[[2,1]]-p[[1,2]]]);
    If[FreeQ[g,ComplexInfinity|Indeterminate|DirectedInfinity],Return[g]]];
  e1=mblNamedLookup[p,dep];
  If[e1===$Failed,
    e1=Quiet@Check[TimeConstrained[PDExpand[p,eps,dep],12000,$Failed],$Failed]];
  If[e1===$Failed||!FreeQ[e1,HypergeometricPFQ],$Failed,e1]];
