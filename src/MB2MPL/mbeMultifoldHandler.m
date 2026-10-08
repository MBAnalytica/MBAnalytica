(* ============================================================================================================
   mbeMultifoldHandler.m -- THE GENERAL MULTIFOLD HANDLER of the Subtraction route (29 September 2026).

   Governing finding (MULTIFOLD_HANDLER_RESEARCH_20260927.md, mandatory recovery read): every fast closure of the corpus
   reduced the number of integrations EXACTLY at finite eps before anything was expanded, expanded only one-variable
   functions, and handed the integrator nothing but small eps-free cubes.  This library is the dispatcher over those moves,
   ported from the drivers that closed the inclusive MB13, MB14 and MB8 targets exactly through eps^-3
   (differential_u_subtraction_to14_20260922/uint_mellin_v3.wls, uint_eta_v3d.wls, uint_family_sum_v1.wls) and the closer
   library (uint_close_lib.m: stabilization, fixed-contour Taylor closer, piece cache, sealed lane, slope-two closer).

   Layers (each exact, gated, time-budgeted; a refused object is returned with its signature, never a finite part):
     0  mfhSetup[eps, opts]           regulator, decision point e0 < 0, eta = -e0/4, target order, budgets, parameter symbol
     1  mfhUIntegrate[f, ctr]         (inclusive mode) exact u-integration at the MB level: Beta identity inside the strip,
                                      contour shifts at e0 with crossed residues (1-dim gates), log(u) powers as derivatives,
                                      unregulated endpoints set aside for the eta step
     2  mfhReduce[f, ctr]             stabilization + greedy finite-eps Barnes I / II / collapsed generalized lemma, in the
                                      given basis and after unimodular pivots z_j -> sigma (s - z_i); every output stabilized;
                                      a "NoNum" A-gate of the generalized lemma is replaced by the complex-spectator gate
                                      (the lemma's value can sit on a removable singularity at the real contour point: MB14bu r46)
     3  mfhPairItems[items]           opposite-sign pair census (same integrand up to normalization on two contours -> the
                                      finite sum of residues crossed on the sequential path at e0; exact cancellation when none)
     4  mfhCloseItem[F, ctr]          zero-fold: exact Series; else the closer chain of uint_close_lib.m with its engine
                                      stages DEFERRED (prefactor split by monomials, depth rule, cache, closed forms,
                                      slope-two closer; gates I_0, I_1 by contour quadrature), then layer 4b, then the
                                      closer chain with the sealed lane and the development engine, then the faithful cube
     4b mfhParseval[F, ctr]           (29 September 2026) Mellin-Parseval decoupling of a two-fold coupled through ONE linear
                                      form: three one-fold inverse Mellin transforms by the Mellin tower rung on both halves
                                      of t (compact-support factors closed on the side of their poles, zero on the other
                                      half, gated by the forward transform), exact tau -> 0 moments, rationalized letters,
                                      exact primitive with its gates, the item's I_0 gate (MB13u r49: 12 s)
     5  mfhResidue[f, ctr, lo, T]     one resolved residue -> exact Laurent lo..T (constant mode; inclusive mode with "Parameter")
        mfhFamily[resolved, lo, T]    all residues of a family: layer 1-2 per residue, pair census across residues, closing,
                                      the eta step for unregulated endpoints, exact family Laurent; optional exact benchmark
                                      comparison (benchmark values enter ONLY the comparison)
     6  mfhInstall[]                  wiring: Global`oftMultiFoldHandler (the multi-fold slot of the Subtraction family
                                      driver) tries mfhResidue first; PSExpand's multi-fold pre-reduction uses mfhReduce.
   Every served value is exact (exactQ of the closer library); numerics are gates only.
   ============================================================================================================ *)

If[!ValueQ[Global`$mfhEnabled],Global`$mfhEnabled=True];
If[!ValueQ[Global`$mfhVerbose],Global`$mfhVerbose=True];
Global`$mfhRoot=If[StringQ[$InputFileName]&&$InputFileName=!="",DirectoryName[$InputFileName],Directory[]];
(* the closer library: in a release tree under multifold_close/, in the development tree in the campaign folder *)
Global`$mfhCloseDir=If[DirectoryQ[FileNameJoin[{Global`$mfhRoot,"multifold_close"}]],FileNameJoin[{Global`$mfhRoot,"multifold_close"}],
  FileNameJoin[{Global`$mfhRoot,"differential_u_subtraction_to14_20260922"}]];
(* release layout (load_standard.m without the development loader): run-time state of the closer library (piece cache,
   term cache, open-piece census) and the family records live under <root>/.cache/, outside the sealed manifest *)
Global`$mfhReleaseLayoutQ=FileExistsQ[FileNameJoin[{Global`$mfhRoot,"load_standard.m"}]]&&!FileExistsQ[FileNameJoin[{Global`$mfhRoot,"load_standard_w10.m"}]];
Global`$mfhStateDir=If[TrueQ[Global`$mfhReleaseLayoutQ],FileNameJoin[{Global`$MBStandardCacheDir,"multifold_close"}],Global`$mfhCloseDir];
Global`$mfhRecordDir=If[TrueQ[Global`$mfhReleaseLayoutQ],FileNameJoin[{Global`$MBStandardCacheDir,"multifold_family"}],FileNameJoin[{Global`$mfhRoot,"mfh_records"}]];
mfhPrint[args___]:=If[TrueQ[Global`$mfhVerbose],Print[args]];

(* ---------------------------------------------------------------- 0. setup ---------------------------------------------------------------- *)
Options[mfhSetup]={"E0"->-1/40,"Target"->-3,"Low"->-12,"CloseSeconds"->7200,"BarnesSeconds"->1800,"Barnes"->True,
  "Parameter"->None,"ParallelPieces"->True,"Workers"->8,"ParMin"->1};
(* SYMBOL RESOLUTION (found 29 September 2026): the closer library reads the bare names ep, e0, eta, T, lo, closeSeconds, $uSym,
   $useParallelPieces, parWorkers, parMin.  A bare name resolves to the FIRST context on $ContextPath that owns it, and the
   package contexts precede Global` there: ep is MB`ep and eta is PolyLogTools`eta after the loader.  The drivers assigned bare
   names and were consistent; an explicit Global`ep is a different symbol and left every argument "nonlinear" in metPoles
   (every stabilization refused).  The shared names are therefore assigned through the same resolution, and the handler keeps
   its own copies of the values ($mfhEp, ...). *)
mfhSetName[name_String,val_]:=With[{h=ToExpression[name,InputForm,Hold]},Set@@Join[h,Hold[val]]];
mfhGetName[name_String]:=ReleaseHold[ToExpression[name,InputForm,Hold]];
mfhSetup[eps_Symbol,OptionsPattern[]]:=Module[{par=OptionValue["Parameter"],e0v=OptionValue["E0"]},
  mfhSetName["ep",eps];mfhSetName["e0",e0v];mfhSetName["eta",-e0v/4];mfhSetName["T",OptionValue["Target"]];mfhSetName["lo",OptionValue["Low"]];
  mfhSetName["closeSeconds",OptionValue["CloseSeconds"]];mfhSetName["barnesSeconds",OptionValue["BarnesSeconds"]];mfhSetName["barnesQ",TrueQ[OptionValue["Barnes"]]];
  mfhSetName["$uSym",par];mfhSetName["uu",par];mfhSetName["$useParallelPieces",TrueQ[OptionValue["ParallelPieces"]]];
  mfhSetName["parWorkers",OptionValue["Workers"]];mfhSetName["parMin",OptionValue["ParMin"]];
  $mfhEp=eps;$mfhE0=e0v;$mfhEta=-e0v/4;$mfhT=OptionValue["Target"];$mfhLo=OptionValue["Low"];
  $mfhCloseSeconds=OptionValue["CloseSeconds"];$mfhBarnesSeconds=OptionValue["BarnesSeconds"];$mfhBarnesQ=TrueQ[OptionValue["Barnes"]];
  $mfhUSym=par;$mfhU=par;
  $mfhParallelPieces=TrueQ[OptionValue["ParallelPieces"]];$mfhParWorkers=OptionValue["Workers"];$mfhParMin=OptionValue["ParMin"];
  If[DownValues[Global`mblBarnes1]==={},Get[FileNameJoin[{Global`$mfhRoot,"mbe_barnes_lib.m"}]]];
  If[FileExistsQ[FileNameJoin[{Global`$mfhRoot,"mbeExternalParameterRung.m"}]]&&DownValues[Global`mbeExternalParameterRungLoaded]==={},
    Quiet@Get[FileNameJoin[{Global`$mfhRoot,"mbeExternalParameterRung.m"}]];Global`mbeExternalParameterRungLoaded[]=True];
  If[DownValues[MBMellinTower`mbeMellinSlopeNormalize]==={}&&FileExistsQ[FileNameJoin[{Global`$mfhRoot,"mbeMellinTowerRung.m"}]],
    Quiet@Get[FileNameJoin[{Global`$mfhRoot,"mbeMellinTowerRung.m"}]]];
  SetEnvironment["MBT_PIECE_RECORDS"->"0"];SetEnvironment["MBE_L6_ACCEPT_BASIS"->"1"];SetEnvironment["MBT_PIECE_LIBRARY_OFF"->"1"];
  If[DownValues[Global`closeTerm]==={},If[!ValueQ[Global`$closeStateDir],mfhSetName["$closeStateDir",Global`$mfhStateDir]];
    Get[FileNameJoin[{Global`$mfhCloseDir,"uint_close_lib.m"}]]];
  (* the package's fixed-contour closer is defined lazily by the first public call *)
  If[DownValues[MBtoMPL`Private`mbtLocalStdRoute]==={},
    Quiet@MBtoMPL`MBresolveToMPL[Gamma[1+eps]^2/Gamma[1+2 eps],eps,"EpsOrderMin"->0,"EpsOrderMax"->0,"Route"->"Standard",
      "Verbose"->False,"DiskCache"->False,"UseCertifiedLibrary"->False]];
  MBtoMPL`Private`$mbtUseMB2MPLDiskCache=False;MBtoMPL`Private`$mbtUseDoABCache=False;
  MBtoMPL`Private`$mbtUseCertifiedLibrary=False;MBtoMPL`Private`$mbtUseHungCorrection=False;
  Global`$mfhReady=DownValues[MBtoMPL`Private`mbtLocalStdRoute]=!={}&&DownValues[Global`closeTerm]=!={};
  Global`$mfhReady];

(* ------------------------------------------------- 1. u-integration at the MB level (inclusive mode) ------------------------------------------------- *)
mfhNormalizeU[f_]:=Module[{fs=If[Head[f]===Times,List@@f,{f}],out=1,u=$mfhU},
  Do[out*=If[FreeQ[g,u]||g===u||MatchQ[g,Power[u,_]]||g===1-u||MatchQ[g,Power[1-u,_]]||g===-1+u||MatchQ[g,Power[-1+u,_]],g,PowerExpand[Factor[g]]],{g,fs}];out];
mfhSplitU[f_]:=Module[{u=$mfhU,fs,al=0,be=0,rest=1,jl=0,kl=0},
  fs=With[{nf=mfhNormalizeU[f]},If[Head[nf]===Times,List@@nf,{nf}]];
  Do[Which[g===u,al+=1,MatchQ[g,Power[u,_]],al+=g[[2]],g===1-u,be+=1,MatchQ[g,Power[1-u,_]],be+=g[[2]],
    g===-1+u,be+=1;rest*=-1,MatchQ[g,Power[-1+u,_Integer]],be+=g[[2]];rest*=(-1)^g[[2]],
    g===Log[u],jl+=1,MatchQ[g,Power[Log[u],_Integer?Positive]],jl+=g[[2]],
    g===Log[1-u],kl+=1,MatchQ[g,Power[Log[1-u],_Integer?Positive]],kl+=g[[2]],
    FreeQ[g,u],rest*=g,
    True,Throw[Failure["UIntegrate",<|"Reason"->"factor not a power of u or 1-u: "<>ToString[g,InputForm]|>],"mfhRefuse"]],{g,fs}];
  {Expand[al],Expand[be],rest,jl,kl}];
mfhBetaU[A_,B_,jl_,kl_]:=Module[{aa,bb},D[Gamma[aa+1]Gamma[bb+1]/Gamma[aa+bb+2],{aa,jl},{bb,kl}]/.{aa->A,bb->B}];
mfhReOn[x_,ctr_,ee_]:=Re[N[(x/.ctr)/.$mfhEp->ee,30]];
mfhStripOK[x_,ctr_]:=FreeQ[x,Alternatives@@Keys[ctr]]||AllTrue[{$mfhE0,3 $mfhE0/4,5 $mfhE0/4},mfhReOn[x,ctr,#]>-1&];
mfhGateRow[f_,v_,ctr_,cpv_,resSum_]:=Module[{others=DeleteCases[ctr,v->_],subs,t,lhs,rhs,g},
  subs=Join[Table[o[[1]]->Rationalize[o[[2]],0]+I/3,{o,others}],{$mfhEp->$mfhE0},If[$mfhU===None,{},{$mfhU->2/7}]];
  g=(f/.subs);
  lhs=Quiet@NIntegrate[g/.v->Rationalize[v/.ctr,0]+I t,{t,-60,60},WorkingPrecision->25,PrecisionGoal->10,MaxRecursion->30]/(2 Pi);
  rhs=Quiet@NIntegrate[g/.v->cpv+I t,{t,-60,60},WorkingPrecision->25,PrecisionGoal->10,MaxRecursion->30]/(2 Pi)+If[resSum===0,0,Quiet@N[resSum/.subs,25]];
  {N[lhs,12],N[rhs,12],TrueQ[NumericQ[lhs]&&NumericQ[rhs]&&Abs[lhs-rhs]<10^-7 (1+Abs[lhs])]}];
mfhUnregQ[x_,zs_]:=FreeQ[x,$mfhEp]&&FreeQ[x,Alternatives@@zs]&&IntegerQ[x]&&x<=-1;
(* state of one u-integration: terms {F, ctr} (F = 0 marks an unregulated term set aside), gates, unregulated records *)
mfhUProcess[f_,ctr_List,depth_]:=Module[{A,B,rest,jl,kl,zs=Keys[ctr],bad,v,x,cv,cand,cpv,crossings,newCtr,g,e0=$mfhE0,u=$mfhU},
  If[depth>40,Throw[Failure["UIntegrate",<|"Reason"->"u-recursion depth"|>],"mfhRefuse"]];
  If[zs=!={}&&AnyTrue[Global`poleArgs[f,zs],Function[pa,Module[{al=Expand[pa[[1]]/.ctr]/.$mfhEp->e0},NumericQ[al]&&If[pa[[2]]==="R",al==0,IntegerQ[al]&&al<=0]]]],
    Do[mfhUProcess[s[[1]],s[[2]],depth+1],{s,Global`stabilizeStep[f,ctr,depth]}];Return[Null]];
  If[!FreeQ[f,Log[u]|Log[1-u]],With[{mons=Expand[f,Log[u]|Log[1-u]]},
    If[Head[mons]===Plus,Do[mfhUProcess[m,ctr,depth+1],{m,List@@mons}];Return[Null]]]];
  {A,B,rest,jl,kl}=mfhSplitU[f];
  If[!FreeQ[rest,u],Throw[Failure["UIntegrate",<|"Reason"->"u-dependence beyond powers"|>],"mfhRefuse"]];
  bad=Select[{A,B},!mfhStripOK[#,ctr]&];
  If[bad==={},
    If[mfhUnregQ[A,zs]||mfhUnregQ[B,zs],
      AppendTo[Global`$mfhUTerms,{0,ctr}];AppendTo[Global`$mfhUUnreg,<|"Index"->Length[Global`$mfhUTerms],"Rest"->rest,"A"->A,"B"->B,"JL"->jl,"KL"->kl,"Contour"->ctr|>];
      mfhPrint[StringRepeat["  ",depth],"u-term ",Length[Global`$mfhUTerms],": UNREGULATED (set aside), ",Length[zs]," variables, u^(",InputForm[A],") (1-u)^(",InputForm[B],")"],
      AppendTo[Global`$mfhUTerms,{rest mfhBetaU[A,B,jl,kl],ctr}];
      mfhPrint[StringRepeat["  ",depth],"u-term ",Length[Global`$mfhUTerms],": ",Length[zs]," variables, u^(",InputForm[A],") (1-u)^(",InputForm[B],")",If[jl+kl>0," log(u)^"<>ToString[jl]<>" log(1-u)^"<>ToString[kl],""]]];
    Return[Null]];
  x=First[bad];
  v=First[SortBy[Select[zs,Coefficient[x,#]=!=0&],-Abs[Coefficient[x,#]]&]];cv=v/.ctr;
  cand=SortBy[DeleteDuplicates[Join[Table[cv+Sign[Coefficient[x,v]] k/7,{k,1,120}],Table[cv+Sign[Coefficient[x,v]] k/112,{k,1,600}]]],Abs[#-cv]&];
  With[{inStrip=Select[cand,Function[c,mfhStripOK[x,ctr/.(v->_):>(v->c)]]],
      poleFreeQ=Function[c,With[{ct=ctr/.(v->_):>(v->c)},NoneTrue[Select[Global`poleArgs[f,zs],!FreeQ[#[[1]],v]&],
        Function[pa,AnyTrue[{e0,3 e0/4,5 e0/4},Function[ee,Module[{al=mfhReOn[pa[[1]],ct,ee]},If[pa[[2]]==="R",Abs[al]<10^-12,al<=0&&Abs[al-Round[al]]<10^-12]]]]]]]],
      keepQ=Function[{c,loose},With[{ct=ctr/.(v->_):>(v->c)},AllTrue[{A,B},Function[y,mfhStripOK[y,ct]||!mfhStripOK[y,ctr]||
        (loose&&AnyTrue[zs,Function[w,w=!=v&&!FreeQ[y,w]&&FreeQ[x,w]]])]]]]},
    cand=Select[inStrip,keepQ[#,False]&&poleFreeQ[#]&];
    If[cand==={},cand=Select[inStrip,keepQ[#,True]&&poleFreeQ[#]&]]];
  If[cand==={},Throw[Failure["UIntegrate",<|"Reason"->"no admissible contour for "<>ToString[v]<>" (exponent "<>ToString[x,InputForm]<>")"|>],"mfhRefuse"]];
  cpv=First[cand];newCtr=ctr/.(v->_):>(v->cpv);
  If[AnyTrue[Global`polesInV[f,ctr,v,e0],Abs[Re[#[[1]]]-cv]<10^-20||Abs[Re[#[[1]]]-cpv]<10^-20&],
    Throw[Failure["UIntegrate",<|"Reason"->"a pole lies on a contour line at e0"|>],"mfhRefuse"]];
  crossings=DeleteDuplicates[#[[2]]&/@Select[Global`polesInV[f,ctr,v,e0],Min[cv,cpv]<Re[#[[1]]]<Max[cv,cpv]&],Simplify[#1-#2]===0&];
  mfhPrint[StringRepeat["  ",depth],"shift ",v,": ",cv," -> ",cpv," (exponent ",InputForm[x],"), crossed at e0 ",InputForm[crossings]];
  Module[{resList=Table[If[cpv>cv,-1,1] Residue[f,{v,pl}],{pl,crossings}]},
    g=mfhGateRow[f,v,ctr,cpv,Total[resList]];AppendTo[Global`$mfhUGates,{v,cv,cpv,g}];
    If[!g[[3]],Throw[Failure["UIntegrate",<|"Reason"->"shift gate failed: "<>ToString[g[[1;;2]]]|>],"mfhRefuse"]];
    Do[If[resList[[i]]=!=0,mfhUProcess[resList[[i]],DeleteCases[ctr,v->_],depth+1]],{i,Length[resList]}]];
  mfhUProcess[f,newCtr,depth+1]];
mfhUIntegrate[f_,ctr0_List]:=Module[{ctr=Rationalize[#,0]&/@ctr0,status,u=$mfhU},
  If[u===None,Return[Failure["UIntegrate",<|"Reason"->"no parameter symbol (mfhSetup \"Parameter\")"|>],Module]];
  Global`$mfhUTerms={};Global`$mfhUGates={};Global`$mfhUUnreg={};
  status=Catch[If[FreeQ[f,Log[u]|Log[1-u]],mfhUProcess[f,ctr,0],
      With[{mons=Expand[f,Log]},Do[mfhUProcess[m,ctr,0],{m,If[Head[mons]===Plus,List@@mons,{mons}]}]]];"ok","mfhRefuse"];
  If[status=!="ok",Return[status,Module]];
  <|"UTerms"->Global`$mfhUTerms,"Gates"->Global`$mfhUGates,"Unregulated"->Global`$mfhUUnreg|>];

(* ------------------------------------------------- 2. finite-eps Barnes reductions, outputs stabilized ------------------------------------------------- *)
mfhBadValQ[x_]:=!FreeQ[x,ComplexInfinity|Indeterminate|_DirectedInfinity|$Failed|$Aborted];
(* complex-spectator gate of a one-fold reduction identity: int_v f == Sum terms, the other variables shifted off the real
   contour point (i/3 apart), eps = e0, u = 2/7.  Used when the library's A-gate is "NoNum" (a removable singularity of the
   collapsed lemma at the real point, e.g. mfS + z611 = 0 on MB14bu r46's pivot contour). *)
mfhGateComplex[f_,v_,ctr_,terms_List]:=Module[{others=DeleteCases[ctr,v->_],subs,t,lhs,rhs},
  subs=Join[Table[others[[k,1]]->Rationalize[others[[k,2]],0]+I k/3,{k,Length[others]}],{$mfhEp->$mfhE0},If[$mfhU===None,{},{$mfhU->2/7}]];
  lhs=Quiet@NIntegrate[(f/.subs)/.v->Rationalize[v/.ctr,0]+I t,{t,-60,60},WorkingPrecision->25,PrecisionGoal->10,MaxRecursion->30]/(2 Pi);
  rhs=Quiet@N[Total[terms]/.subs,25];
  <|"LHS"->N[lhs,12],"RHS"->N[rhs,12],"Pass"->TrueQ[NumericQ[lhs]&&NumericQ[rhs]&&Abs[lhs-rhs]<10^-7 (1+Abs[lhs])]|>];
mfhTryReduce[f_,ctr_,v_]:=Module[{r,cl,notes={},ep=$mfhEp,e0=$mfhE0,gt,terms,okG},
  r=Quiet@Global`mblBarnes1[f,v,ctr,ep,e0];
  If[AssociationQ[r]&&mfhBadValQ[r["Terms"]],AppendTo[notes,"B1-pinch"];r=None];
  If[AssociationQ[r],Return[<|"Lemma"->"B1","Terms"->r["Terms"]|>,Module]];
  If[Head[r]===Failure,AppendTo[notes,"B1-gate-failed"]];
  r=Quiet@Global`mblBarnes2[f,v,ctr,ep,e0];
  If[AssociationQ[r]&&mfhBadValQ[r["Terms"]],AppendTo[notes,"B2-pinch"];r=None];
  If[AssociationQ[r],Return[<|"Lemma"->"B2","Terms"->r["Terms"]|>,Module]];
  If[Head[r]===Failure,AppendTo[notes,If[r[[1]]==="Barnes2Balance","B2-unbalanced","B2-gate-failed"]]];
  r=Quiet@Global`mblBarnesGen[f,v,ctr,ep,e0];
  If[AssociationQ[r],cl=Quiet@FunctionExpand[r["PFQ"]];
    If[FreeQ[cl,HypergeometricPFQ]&&!mfhBadValQ[r["Terms"]/.r["PFQ"]->cl],
      (* no inner Module here: Return[.., Module] would leave only the inner scope and the lemma would be dropped
         (found on MB14bu r46: gate passed, reduction never applied) *)
      terms=r["Terms"]/.r["PFQ"]->cl;okG=True;
      If[r["Gate"]==="NoNum",
        gt=mfhGateComplex[f,v,ctr,terms];okG=TrueQ[gt["Pass"]];
        If[okG,mfhPrint["    [gate] collapsed generalized lemma on ",v," gated at a complex spectator point: ",gt["LHS"]," vs ",gt["RHS"]],
          AppendTo[notes,"BG-complex-gate-failed"]]];
      If[okG,Return[<|"Lemma"->"BG-collapsed","Terms"->terms|>,Module]],
      AppendTo[notes,"BG-3F2-remains"]]];
  If[Head[r]===Failure,AppendTo[notes,"BG-gate-failed"]];
  <|"Lemma"->If[notes==={},"no-pattern",StringRiffle[notes,"|"]]|>];
mfhOnPoleQ[f_,ctr_]:=AnyTrue[Select[Cases[f,Gamma[a_]:>a,{0,Infinity}],!FreeQ[#,Alternatives@@Keys[ctr]]&],
  Function[a,AnyTrue[{0,$mfhE0},Function[ee,Module[{ra=Re[N[(a/.ctr)/.$mfhEp->ee,30]]},ra<=0&&Abs[ra-Round[ra]]<10^-9]]]]];
(* 2 October 2026: the fresh variable of a pivot has a CANONICAL name -- us<n> with the smallest n that does not occur in
   the term.  Unique["us"] numbered the variable by the kernel's history (every pivot trial of every residue reduced
   before), so the same item carried us24 in one process and us27 in another, and neither the term cache nor the piece
   cache of one process of a family run served another (MB8bu residue 21: the main run would have repeated all six heavy
   items its helpers had closed).  The variable is a dummy of one item; equal names in different items do not meet. *)
mfhFreshUs[f_,ctr_]:=Module[{n=1},While[!FreeQ[{f,Keys[ctr]},Symbol["Global`us"<>ToString[n]]],n++];Symbol["Global`us"<>ToString[n]]];
mfhUnimodTry[f_,ctr_]:=Catch[
  Do[If[zi=!=zj,Module[{s=mfhFreshUs[f,ctr],fN,ctrN,r},
      fN=f/.zj->sg (s-zi);
      ctrN=Append[DeleteCases[ctr,zj->_],s->Rationalize[(zi/.ctr)+sg (zj/.ctr),0]];
      If[!mfhOnPoleQ[fN,ctrN],
        r=mfhTryReduce[fN,ctrN,zi];
        If[KeyExistsQ[r,"Terms"],Throw[<|"Terms"->Table[{tt,DeleteCases[ctrN,zi->_]},{tt,r["Terms"]}],"Change"->{zj->sg (s-zi)},"Lemma"->r["Lemma"],"Pivot"->zi|>,"um"]]]]],
    {zi,Keys[ctr]},{zj,Keys[ctr]},{sg,{1,-1}}];$Failed,"um"];
(* ABSORB RATIONALS INTO GAMMA LEGS (29 September 2026; the normalizer the research brief left open).  A lemma output such as
   the collapsed 3F2 carries linear rational factors q^(+-1), q = c a with c = +-1, next to Gamma legs of argument a:
     q Gamma[a] = c Gamma[a+1],   1/(q Gamma[a]) = 1/(c Gamma[a+1])
   (Gamma[a+1] = a Gamma[a]).  Without the rewrite the stabilization sees a rational pole ON the contour where the Gamma
   zero cancels it (MB14bu r46 at eps = 0: 1/((s + z611) Gamma[-s - z611]) with s + z611 = 0 on the lines) and refuses.  A
   sum is first expanded into monomials so that each product can be normalized. *)
mfhLinearQ[q_,vs_List]:=PolynomialQ[q,vs]&&!FreeQ[q,Alternatives@@vs]&&Max[Exponent[q,vs]]<=1;
mfhAbsorbRational[F_,vs_List]:=Module[{fs,changed=True,out,i,j,q,a,c,g,rational,gammas,hit},
  fs=If[Head[F]===Times,List@@F,{F}];
  While[changed,changed=False;
    rational=Select[Range[Length[fs]],Function[k,MatchQ[fs[[k]],Power[_,-1]]&&mfhLinearQ[fs[[k,1]],vs]||mfhLinearQ[fs[[k]],vs]]];
    gammas=Select[Range[Length[fs]],Function[k,MatchQ[fs[[k]],Gamma[_]|Power[Gamma[_],-1]]]];
    hit=None;
    Do[i=rational[[ii]];
      Do[j=gammas[[jj]];
        If[MatchQ[fs[[i]],Power[_,-1]]&&MatchQ[fs[[j]],Power[Gamma[_],-1]],
          q=fs[[i,1]];a=fs[[j,1,1]];c=Which[Expand[a-q]===0,1,Expand[a+q]===0,-1,True,None];
          If[c=!=None,hit={i,j,1/(c Gamma[Expand[a+1]])};Break[]]];
        If[!MatchQ[fs[[i]],Power[_,_]]&&MatchQ[fs[[j]],Gamma[_]],
          q=fs[[i]];a=fs[[j,1]];c=Which[Expand[a-q]===0,1,Expand[a+q]===0,-1,True,None];
          If[c=!=None,hit={i,j,c Gamma[Expand[a+1]]};Break[]]],{jj,Length[gammas]}];
      If[hit=!=None,Break[]],{ii,Length[rational]}];
    If[hit=!=None,fs=Append[Delete[fs,{{hit[[1]]},{hit[[2]]}}],hit[[3]]];changed=True]];
  Times@@fs];
mfhMonomials[F_,vs_List]:=Module[{e=Expand[F],mons},mons=If[Head[e]===Plus,List@@e,{e}];
  DeleteCases[mfhAbsorbRational[#,vs]&/@mons,0]];
mfhStab[terms_]:=Join@@(Global`stabilize[#[[1]],#[[2]],0]&/@(Join@@Table[{#,t[[2]]}&/@mfhMonomials[t[[1]],Keys[t[[2]]]],{t,terms}]));
mfhLegendreSplit[f_,vars_]:=Module[{evenQ,g},
  evenQ[a_]:=Module[{cs=Coefficient[a,#]&/@vars},AnyTrue[cs,#=!=0&]&&AllTrue[cs,IntegerQ[#]&&EvenQ[#]&]&&PolynomialQ[a,vars]&&Max[Exponent[a,vars]]<=1];
  g=f/.Gamma[a_]/;evenQ[a]:>2^(a-1)/Sqrt[Pi] Gamma[Expand[a/2]]Gamma[Expand[(a+1)/2]];
  PowerExpand[g]/.Power[2,e_]:>Power[2,Expand[e]]];
(* prelude of the driver's item loop: slope normalization per variable, Legendre split of even-slope legs (identity-checked) *)
mfhPrepare[f_,ctr_]:=Module[{fN=f,vs=Keys[ctr]},
  If[DownValues[MBMellinTower`mbeMellinSlopeNormalize]=!={},
    Do[Module[{fg=Quiet@MBMellinTower`mbeMellinSlopeNormalize[fN,v,DeleteCases[vs,v]]},If[AssociationQ[fg]||FailureQ[fg]||fg===$Failed,Null,fN=fg]],{v,vs}]];
  If[!FreeQ[fN,Gamma[a_]/;AllTrue[Coefficient[a,#]&/@vs,IntegerQ[#]&&EvenQ[#]&]&&!FreeQ[a,Alternatives@@vs]],
    Module[{fl=mfhLegendreSplit[fN,vs],pt},
      pt=Join[Thread[vs->(Values[ctr]+I/7)],{$mfhEp->-1/97},If[$mfhU===None,{},{$mfhU->2/7}]];
      If[Abs[N[(fN/.pt)-(fl/.pt),30]]<10^-20 Max[1,Abs[N[fN/.pt,30]]],fN=fl;mfhPrint["  Legendre split of even-slope legs"]]]];
  fN];
(* 29 September 2026 (MB14bu residue 100, u-term 2): a crossing decision can be DEGENERATE exactly at the decision point --
   a residue crossed while a line is moved carries a pole that sits ON another line at e0 (there 5 e0 = -1/8 = the z8 line),
   so the stabilizer refuses ("a pole lies on a contour line at e0").  The term itself is analytic on [e0', e0] whenever no
   pole meets its lines there; the same decomposition is then read at a perturbed decision point e0' = e0 (1 + 1/97), the
   library's e0 and the handler's gates switched together for that reduction only.  mfhPoleFreeBetween is the licence. *)
mfhPoleFreeBetween[f_,ctr_,e1_,e2_]:=Module[{pas=Global`poleArgs[f,Keys[ctr]],ep=$mfhEp,ok=True},
  Do[Module[{al=Expand[pa[[1]]/.ctr],a0,a1,lo,hi},
      a0=al/.ep->0;a1=Coefficient[al,ep];
      If[!NumericQ[a0]||!NumericQ[a1]||!FreeQ[al,Alternatives@@Keys[ctr]],ok=False;Break[]];
      {lo,hi}=MinMax[{a0+a1 e1,a0+a1 e2}];
      If[If[pa[[2]]==="R",lo<=0<=hi,Ceiling[lo]<=Min[0,Floor[hi]]],ok=False;Break[]]],{pa,pas}];
  ok];
(* 3 October 2026: the constant-mode decision point (the multi-fold slot of mfhInstall below).  A resolved residue's lines
   are valid near eps = 0; the decision point must lie in their crossing-free interval: the default E0, halved until no pole
   meets the residue's lines on [E0, 0]; $Failed after twelve halvings. *)
mfhConstantE0[term_]:=Module[{f,ctr,e=$mfhE0,k=0},
  {f,ctr}=mfhResidueParts[term];ctr=Rationalize[#,0]&/@ctr;
  If[ctr==={},Return[e,Module]];
  f=mfhPrepare[f,ctr];
  While[k<12&&!mfhPoleFreeBetween[f,ctr,e,0],e=e/2;k++];
  If[mfhPoleFreeBetween[f,ctr,e,0],e,$Failed]];
SetAttributes[mfhWithE0,HoldRest];
mfhWithE0[e0p_,body_]:=Module[{old=mfhGetName["e0"],res},
  mfhSetName["e0",e0p];
  res=Block[{$mfhE0=e0p},body];
  mfhSetName["e0",old];res];
mfhReduce[f0_,ctr0_]:=Module[{r=mfhReduceCore[f0,ctr0],e0p,f,ctr},
  If[FailureQ[r]&&StringStartsQ[r["Reason"],"stabilization refused"],
    e0p=$mfhE0 (1+1/97);f=mfhPrepare[f0,Normal[ctr0]];ctr=Normal[ctr0];
    If[mfhPoleFreeBetween[f,ctr,e0p,$mfhE0],
      mfhPrint["  stabilization degenerate at e0 = ",$mfhE0," (a crossed pole on a line at e0): retried at e0' = ",e0p];
      r=mfhWithE0[e0p,mfhReduceCore[f0,ctr0]];
      If[!FailureQ[r],r=Join[r,<|"E0"->e0p|>]],
      mfhPrint["  stabilization refused and the term meets a pole between e0 and e0': no retry"]]];
  r];
mfhReduceCore[f0_,ctr0_]:=Module[{f=mfhPrepare[f0,Normal[ctr0]],ctr=Normal[ctr0],terms,progress=True,out,trace={},ff,cc,r,vDone,pass=0,um,tg=AbsoluteTime[],status},
  If[mfhBadValQ[f],Return[Failure["Reduce",<|"Reason"->"infinite/indeterminate integrand"|>],Module]];
  status=Catch[terms=mfhStab[{{f,ctr}}];"ok","refuse"];
  If[status=!="ok",Return[Failure["Reduce",<|"Reason"->"stabilization refused"|>],Module]];
  status=Catch[
   While[$mfhBarnesQ&&progress&&pass<30&&AbsoluteTime[]-tg<$mfhBarnesSeconds,pass++;progress=False;out={};
    Do[{ff,cc}=t;vDone=None;
      If[Length[cc]>=1,Do[r=mfhTryReduce[ff,cc,v];If[KeyExistsQ[r,"Terms"],vDone=v;AppendTo[trace,{Length[cc],v,r["Lemma"],Length[r["Terms"]]}];Break[],AppendTo[trace,{Length[cc],v,r["Lemma"]}]],{v,Keys[cc]}]];
      Which[
        vDone=!=None,progress=True;out=Join[out,mfhStab[Table[{tt,DeleteCases[cc,vDone->_]},{tt,r["Terms"]}]]],
        Length[cc]>=2&&AssociationQ[um=mfhUnimodTry[ff,cc]],
          progress=True;AppendTo[trace,{Length[cc],"unimod",ToString[um["Change"],InputForm],um["Lemma"],Length[um["Terms"]]}];out=Join[out,mfhStab[um["Terms"]]],
        True,AppendTo[out,{ff,cc}]],{t,terms}];
    terms=out];"ok","refuse"];
  If[status=!="ok",Return[Failure["Reduce",<|"Reason"->"stabilization refused after a lemma"|>],Module]];
  <|"Terms"->terms,"Trace"->DeleteDuplicates[trace],"InputFolds"->Length[ctr],"OutputFolds"->(Length[#[[2]]]&/@terms)|>];

(* ------------------------------------------------- 3. pairing of opposite-sign items ------------------------------------------------- *)
mfhPairNrm[f_]:=f/.{Power[b_,e_]/;!IntegerQ[e]:>Power[b,Expand[e]],Gamma[a_]:>Gamma[Expand[a]],PolyGamma[k_,a_]:>PolyGamma[k,Expand[a]]};
mfhPairResiduesAt[F_,ctrA_List,ctrB_List]:=Catch[Module[{cur=ctrA,terms={},vs=Select[Keys[ctrA],(#/.ctrA)=!=(#/.ctrB)&]},
  Do[Module[{ca=v/.cur,cb=v/.ctrB,pl,crossed,sgn},
      pl=Global`polesInV[F,cur,v,$mfhE0];
      If[AnyTrue[pl,Abs[Re[#[[1]]]-ca]<10^-20||Abs[Re[#[[1]]]-cb]<10^-20&],Throw[$Failed,"pr"]];
      crossed=DeleteDuplicates[#[[2]]&/@Select[pl,Min[ca,cb]<Re[#[[1]]]<Max[ca,cb]&],Simplify[#1-#2]===0&];
      sgn=If[cb>ca,-1,1];
      Do[With[{rs=Together[sgn Residue[F,{v,p}]]},If[rs=!=0,AppendTo[terms,{rs,DeleteCases[cur,v->_]}]]],{p,crossed}];
      cur=cur/.(v->_):>(v->cb)],{v,vs}];
  terms],"pr"];
(* items {tag, F, contour}; equal keys of the contours required; opposite integrands after normalization; renaming of the
   Mellin variables tried when the variable names differ (the Barnes step introduces fresh unimodular variables) *)
(* renaming-invariant signature (census_pairs.wls): fold count and the sorted absolute coefficient patterns of the Gamma and
   polygamma arguments; only items with equal signatures are compared, so the census is linear in practice *)
mfhPairSig[F_,vs_List]:=Module[{args=Join[Cases[F,Gamma[a_]:>a,{0,Infinity}],Cases[F,PolyGamma[_,a_]:>a,{0,Infinity}]]},
  {Length[vs],Sort[Sort[Abs[Coefficient[#,vs]]]&/@Select[args,!FreeQ[#,Alternatives@@vs]&]]}];
(* numerical gate of a pair identity: True (passed), False (failed), None (not gateable: > 3 folds with a path, or an
   inconclusive quadrature); same-contour pairs pass without a quadrature *)
If[!ValueQ[Global`$mfhPairGateSeconds],Global`$mfhPairGateSeconds=300];
(* 29 September 2026, 15:4x: the gate is POINTWISE IN THE SPECTATORS.  Each move of the sequential path is a one-fold
   identity in the moved variable, int_{a} F - int_{b} F = s sum Res, for every value of the other variables (here: their
   current lines plus distinct imaginary shifts, two points), so the whole path is verified by one-dimensional contour
   quadratures at ten digits whatever the fold count -- the same principle as the lemma gates.  The multi-dimensional
   rules (below, kept as a fallback when the pointwise check cannot be evaluated) are neither precise nor available
   beyond three folds. *)
mfhPairGatePointwise[FA_,ctrA_,ctrB_]:=Module[{ep=$mfhEp,e0=$mfhE0,cur=ctrA,vs,ok=True,any=False},
  vs=Select[Keys[ctrA],(#/.ctrA)=!=(#/.ctrB)&];
  Do[Module[{ca=v/.cur,cb=v/.ctrB,pl,crossed,sgn,others,pts},
      pl=Global`polesInV[FA,cur,v,e0];
      crossed=DeleteDuplicates[#[[2]]&/@Select[pl,Min[ca,cb]<Re[#[[1]]]<Max[ca,cb]&],Simplify[#1-#2]===0&];
      sgn=If[cb>ca,-1,1];
      others=DeleteCases[cur,v->_];
      pts=Table[Join[Table[others[[k,1]]->Rationalize[others[[k,2]],0]+I (k+j)/7,{k,Length[others]}],{ep->e0}],{j,0,1}];
      Do[Module[{g=FA/.pt,lhs,rhs,t},
          lhs=Quiet@(NIntegrate[g/.v->ca+I t,{t,-60,60},WorkingPrecision->25,PrecisionGoal->10,MaxRecursion->30]
                   -NIntegrate[g/.v->cb+I t,{t,-60,60},WorkingPrecision->25,PrecisionGoal->10,MaxRecursion->30])/(2 Pi);
          rhs=If[crossed==={},0,sgn Total[Table[Quiet@N[Residue[g,{v,p/.pt}],25],{p,crossed}]]];
          If[!(NumericQ[lhs]&&NumericQ[rhs]),ok=None,any=True;If[Abs[lhs-rhs]>10^-8 Max[1,Abs[lhs]],ok=False]]],{pt,pts}];
      cur=cur/.(v->_):>(v->cb)],{v,vs}];
  If[ok===None||!any,None,ok]];
mfhPairGate[FA_,ctrA_,FB_,ctrB_,rt_]:=Module[{ep=$mfhEp,e0=$mfhE0,nf=Length[ctrA],qa,qb,qr,tol,ok,pw},
  If[rt==={}&&Sort[ctrA]===Sort[ctrB],Return[True,Module]];
  pw=Quiet@TimeConstrained[mfhPairGatePointwise[FA,ctrA,ctrB],Global`$mfhPairGateSeconds,None];
  If[pw===True||pw===False,Return[pw,Module]];
  If[nf>3,Return[None,Module]];
  {qa,qb,qr}=Quiet@TimeConstrained[{Global`quad[FA/.ep->e0,ctrA],Global`quad[FB/.ep->e0,ctrB],Total[Table[Global`quad[t[[1]]/.ep->e0,t[[2]]],{t,rt}]]},Global`$mfhPairGateSeconds,{$TimedOut,$TimedOut,$TimedOut}];
  If[!(NumericQ[qa]&&NumericQ[qb]&&NumericQ[qr]),Return[None,Module]];
  tol=Global`gateTol[nf] Max[1,Abs[qa],Abs[qb]];
  ok=Abs[qa+qb-qr]<tol;
  If[!ok&&nf==2,
    (* a two-dimensional rule can be inconclusive: iterated one-dimensional quadratures re-check *)
    {qa,qb}=Quiet@TimeConstrained[{Global`quadIter[FA/.ep->e0,ctrA],Global`quadIter[FB/.ep->e0,ctrB]},Global`$mfhPairGateSeconds,{$TimedOut,$TimedOut}];
    If[NumericQ[qa]&&NumericQ[qb],ok=Abs[qa+qb-qr]<10^-5 Max[1,Abs[qa],Abs[qb]],Return[None,Module]]];
  ok];
mfhPairItems[items0_List]:=Module[{items=items0,n,used={},out={},nf,log={},sigs},
  n=Length[items];nf=mfhPairNrm/@items[[All,2]];
  sigs=Table[mfhPairSig[items[[k,2]],Keys[items[[k,3]]]],{k,n}];
  Do[If[MemberQ[used,a]||MemberQ[used,b]||items[[a,3]]==={}||items[[b,3]]==={},Continue[]];
    If[sigs[[a]]=!=sigs[[b]],Continue[]];
    Module[{va=Keys[items[[a,3]]],vb=Keys[items[[b,3]]],hit=None,ctrB},
      If[Sort[va]===Sort[vb],If[Together[nf[[a]]+nf[[b]]]===0,hit={}],
        If[Length[va]<=6,Do[Module[{rl=Thread[vb->p]},If[Together[nf[[a]]+mfhPairNrm[nf[[b]]/.rl]]===0,hit=rl;Break[]]],{p,Permutations[va]}]]];
      If[hit===None,Continue[]];
      ctrB=If[hit==={},items[[b,3]],Normal[items[[b,3]]]/.(x_->c_):>((x/.hit)->c)];
      Module[{rt=If[Sort[Normal[items[[a,3]]]]===Sort[Normal[ctrB]],{},mfhPairResiduesAt[items[[a,2]],Normal[items[[a,3]]],Normal[ctrB]]],gate},
        If[rt===$Failed,mfhPrint["  PAIR refused (a pole on a line) for items ",items[[a,1]],", ",items[[b,1]]];Continue[]];
        (* 29 September 2026: every pair identity with a path (different contours) is GATED numerically before it is applied:
           int_A F_A + int_B F_B must equal the crossed residue terms at e0 (contour quadratures; <= 3 folds, time-capped);
           a pair that cannot be gated is refused and both items are closed independently.  Found on MB14bu items
           {85,6} <-> {100,5} (slope-two legs), whose crossed residues did not reproduce A + B; the family sum was off by
           exactly that amount.  A same-contour pair is an exact cancellation and needs no gate. *)
        gate=mfhPairGate[items[[a,2]],Normal[items[[a,3]]],items[[b,2]],Normal[items[[b,3]]],rt];
        If[!TrueQ[gate],mfhPrint["  PAIR GATE ",If[gate===None,"UNAVAILABLE","FAIL"]," for items ",items[[a,1]],", ",items[[b,1]]," (",Length[items[[a,3]]]," folds, ",Length[rt]," residue terms): pair refused, both items closed independently"];Continue[]];
        used=Join[used,{a,b}];
        mfhPrint["  PAIRED items ",items[[a,1]]," and ",items[[b,1]]," (",Length[items[[a,3]]]," folds): ",Length[rt]," crossed residue term(s)"];
        AppendTo[log,<|"First"->items[[a,1]],"Second"->items[[b,1]],"Folds"->Length[items[[a,3]]],"ResidueTerms"->Length[rt],"Rename"->hit|>];
        out=Join[out,Table[{items[[a,1]],t[[1]],t[[2]]},{t,rt}]]]],{a,n},{b,a+1,n}];
  Global`$mfhPairLog=log;
  If[used==={},items,Join[Delete[items,List/@used],out]]];

(* ------------------------------------------------- 4. closing one item ------------------------------------------------- *)
mfhZeroFold[f_]:=Module[{s,ep=$mfhEp,T=$mfhT,lo=$mfhLo},
  If[mfhBadValQ[f],Return[Failure["ZeroFold",<|"Reason"->"infinite/indeterminate"|>],Module]];
  If[FreeQ[f,ep],Return[If[lo<=0<=T,Global`mbeCanonicalConstants[f],0],Module]];
  s=Quiet@Series[f,{ep,0,T}];
  If[Head[s]=!=SeriesData,Return[Failure["ZeroFold",<|"Reason"->"series failed"|>],Module]];
  If[s[[4]]/s[[6]]<lo,Return[Failure["ZeroFold",<|"Reason"->"starts at eps^"<>ToString[s[[4]]/s[[6]]]<>" below lo"|>],Module]];
  Total[Table[Global`mbeCanonicalConstants[SeriesCoefficient[s,k]] ep^k,{k,lo,T}]]];
(* last candidate of a multi-fold item: the package's FAITHFUL-CUBE rung on the whole eps-dependent item (Barnes-kernel
   inversion, eps-coefficients integrated exactly), gated by the item's own I_0 (the Laurent coefficient at the prefactor
   lead divided by the lead coefficient, against the contour quadrature of the eps = 0 integrand); disabled by $mfhNoCube *)
mfhCubeItem[F_,ctr_]:=Module[{ep=$mfhEp,lo=$mfhLo,T=$mfhT,vs=Keys[ctr],res,laur,cz,g,ser,L,c0,q,i0,ok},
  If[TrueQ[Global`$mfhNoCube]||DownValues[Global`fcuResidueLaurent]==={},Return[Failure["Cube",<|"Reason"->"faithful-cube rung not available"|>],Module]];
  res=Quiet@TimeConstrained[Global`fcuResidueLaurent[MBint[F,{{ep->0},Normal[ctr]}],ep,lo,T,False],$mfhCloseSeconds,$TimedOut];
  If[!ListQ[res]||Length[res]=!=T-lo+1||!TrueQ[Global`exactQ[res]],Return[Failure["Cube",<|"Reason"->"faithful cube refused or inexact: "<>ToString[Short[res,2]]|>],Module]];
  laur=Total[Table[res[[k-lo+1]] ep^k,{k,lo,T}]];
  cz=Times@@Select[If[Head[F]===Times,List@@F,{F}],FreeQ[#,Alternatives@@vs]&];g=Together[F/cz];
  ser=Quiet@Series[cz,{ep,0,T}];L=If[Head[ser]===SeriesData,ser[[4]]/ser[[6]],0];
  If[L>T,Return[<|"Laurent"->0,"Folds"->Length[vs],"Method"->"faithful cube (prefactor beyond target)"|>,Module]];
  c0=SeriesCoefficient[ser,L];i0=Coefficient[laur,ep,L]/c0;q=Global`quad[g/.ep->0,Normal[ctr]];
  ok=TrueQ[NumericQ[q]&&Abs[N[i0,30]-q]<Global`gateTol[Length[vs]] Max[1,Abs[q]]];
  If[!ok&&Length[vs]==2,With[{q2=Global`quadIter[g/.ep->0,Normal[ctr]]},ok=TrueQ[NumericQ[q2]&&Abs[N[i0,30]-q2]<10^-5 Max[1,Abs[q2]]];If[ok,q=q2]]];
  mfhPrint["   faithful cube: I_0 = ",N[i0,16]," vs quadrature ",N[q,12],If[ok,"  PASS","  FAIL"]];
  If[!ok,Return[Failure["Cube",<|"Reason"->"faithful cube value failed the I_0 gate"|>],Module]];
  <|"Laurent"->Expand[laur],"Folds"->Length[vs],"Method"->"faithful cube (whole item)","Gates"->{{Normal[ctr],0,N[q,12],N[i0,16],ok}}|>];
(* ------------------------------------------------- 4b. Mellin-Parseval decoupling ------------------------------------------------- *)
(* A two-fold item F = Cz A(x) B(y) K(L) whose coupling legs (the Gamma legs depending on both variables) all depend on ONE
   linear form L = sx x + sy y (sx, sy = +-1) is, by Mellin-Parseval,
        I = Cz int_0^inf dt/t a(t) b(t) k(t),   a(t) = (1/2 pi i) int A(x) t^(-sx x) dx,  b(t) likewise,  k(t) = (1/2 pi i) int K(s) t^s ds,
   every factor a ONE-FOLD inverse Mellin transform.  The line is split at t = 1 (t = 1/tau on (1, inf)); on each half every
   factor's eps-Laurent coefficient functions of tau come from the Mellin tower rung (radial towers at the scale, HypExp,
   two-sided contour gate).  A factor with ZERO net Gamma count (compact support; the tower rung's guard refuses it) is closed
   on the side of its poles chosen from the decay of tau^(sg z) and is exactly zero on the other half (Jordan's lemma: the
   integrand decays algebraically on the line); its closed form is gated by the FORWARD Mellin transform (the halves' transform
   must reproduce every eps-order of the Gamma product at two complex points).  Coincident legs Gamma(L)^p are separated by
   regulators lambda eps and the lambda = 0 value recovered by exact Lagrange interpolation (polynomial in lambda, one extra
   point certifies the degree).  The tau -> 0 singular part of every half is the exact product of the closing-side residues
   (exact in eps) and is integrated by its exact moments int_0^1 tau^e log^k tau = (-1)^k k!/(e+1)^(k+1) before anything is
   expanded; the remainder's algebraic letters are rationalized (sqrt(1-tau): tau = 1 - v^2; sqrt(tau): tau = v^2) and the
   exact primitive is taken by the {0,1,-1} integrator (derivative certificate, regulator, endpoint and quadrature gates).
   The item's own I_0 gate (contour quadrature of the eps = 0 two-fold) is applied to the result.  Ported from
   uint_meijer_v4m.wls (26-27 September 2026); compact-support class, rationalization and forward gate added 29 September
   2026 for MB13u residue 49 (closed by hand on 27 September: I_0 = -17 pi^(9/2)/180).  Disabled by $mfhNoParseval. *)
$mfhPvTau=Global`mfhTau;$mfhPvS=Global`mfhS;
If[!ValueQ[Global`$mfhPvSeconds],Global`$mfhPvSeconds=900];
mfhPvRefuse[why_]:=Throw[Failure["Parseval",<|"Reason"->why|>],mfhPvTag];
mfhPvLegs[f_]:=Join[Cases[f,Power[Gamma[a_],n_Integer]:>{a,n},{0,1}],Cases[f,Gamma[a_]:>{a,1},{0,1}]];
mfhPvProd[l_]:=Times@@(Power[Gamma[#[[1]]],#[[2]]]&/@l);
mfhPvLeadOrder[e_,T_]:=Module[{s=Quiet@Series[e,{$mfhEp,0,T+4}]},If[Head[s]===SeriesData,s[[4]]/s[[6]],If[TrueQ[Simplify[e]==0],Infinity,0]]];
mfhPvLaurentLead[l_,k0_,k1_]:=Module[{nz=Select[Range[k0,k1],Coefficient[l,$mfhEp,#]=!=0&]},If[nz==={},Infinity,Min[nz]]];
mfhPvN[e_]:=Quiet@N[e/.g_PolyLogTools`G:>Global`gnumHF[g],25];
mfhPvLoF:=Min[$mfhLo,-8]-4;
(* one half of one factor: F(tau) = (1/2 pi i) int M(z) tau^(sg z) dz on Re z = c, 0 < tau < 1, as an eps-Laurent polynomial *)
mfhPvTowerPlain[M_,z_,sg_,c_,hiK_,dirs_,compactQ_]:=Module[{tau=$mfhPvTau,r},
  r=MBMellinTower`mbeMellinLaurent[M tau^(sg z),z,$mfhEp,c,mfhPvLoF,hiK,{tau},0<tau<1,"Log"->(Null&),"Directions"->dirs,
    "CompactSupport"->compactQ,"Gate"->!compactQ,"Seconds"->Global`$mfhPvSeconds,"BlockSeconds"->Min[600,Global`$mfhPvSeconds]];
  If[FailureQ[r],mfhPvRefuse["tower refused ("<>ToString[InputForm[M]]<>", sg "<>ToString[sg]<>"): "<>ToString[r["Reason"]]]];
  r];
$mfhPvRegPoints={1/5,1/7,1/9,1/11,1/13,1/15,1/17,1/19,1/21,1/23,1/25,1/27};
mfhPvTower[M_,z_,sg_,c_,hiK_,dirs_,compactQ_]:=Module[{ep=$mfhEp,tau=$mfhPvTau,co,Mreg,runs,lead,out=0,nPts,pts=$mfhPvRegPoints},
  co=Cases[M,Power[Gamma[a_],p_Integer/;p>=2]/;!FreeQ[a,z]:>{a,p},{0,Infinity}];
  If[co==={},Return[mfhPvTowerPlain[M,z,sg,c,hiK,dirs,compactQ],Module]];
  Mreg[lv_]:=M/.Power[Gamma[a_],p_Integer/;p>=2]/;!FreeQ[a,z]:>Product[Gamma[a+j lv ep],{j,0,p-1}];
  lead=Module[{r1=mfhPvTowerPlain[Mreg[pts[[1]]],z,sg,c,hiK,dirs,compactQ]},Min[Select[Range[mfhPvLoF,hiK],Coefficient[r1,ep,#]=!=0&]/.{}->{hiK+1}]];
  If[lead>hiK,Return[0,Module]];
  nPts=Min[Length[pts],hiK-lead+2];
  runs=Table[mfhPvTowerPlain[Mreg[pts[[i]]],z,sg,c,hiK,dirs,compactQ],{i,nPts}];
  Do[Module[{d=k-lead,ys,val,check},
      ys=Table[Coefficient[runs[[i]],ep,k],{i,d+1}];
      val=Sum[ys[[i]] Product[If[j==i,1,(0-pts[[j]])/(pts[[i]]-pts[[j]])],{j,d+1}],{i,d+1}];
      If[d+2<=nPts,
        check=Sum[ys[[i]] Product[If[j==i,1,(pts[[d+2]]-pts[[j]])/(pts[[i]]-pts[[j]])],{j,d+1}],{i,d+1}]-Coefficient[runs[[d+2]],ep,k];
        If[!AllTrue[{1/3,5/7},Abs[mfhPvN[check/.tau->#]]<10^-18&],mfhPvRefuse["regulator interpolation not polynomial at eps^"<>ToString[k]]]];
      out+=Expand[val] ep^k],{k,lead,hiK}];
  mfhPrint["      [parseval] coincident legs ",InputForm[co]," closed by regulator interpolation (",nPts," points)"];
  out];
(* compact support: closing side from the decay of tau^(sg z) on 0 < tau < 1 (sg = +1: Re z -> +inf, RIGHT; sg = -1: LEFT);
   ZERO when the closing side carries no numerator pole *)
mfhPvCompactDir[M_,z_,sg_]:=Module[{legs=mfhPvLegs[M],numR,numL},
  numR=Select[legs,#[[2]]>0&&Coefficient[#[[1]],z]<0&];numL=Select[legs,#[[2]]>0&&Coefficient[#[[1]],z]>0&];
  If[sg===1,If[numR==={},"ZERO","RIGHT"],If[numL==={},"ZERO","LEFT"]]];
(* both halves of one factor: F(t) = (1/2 pi i) int M(z) t^(sgT z) dz; F1(tau) = F(tau), F2(tau) = F(1/tau), 0 < tau < 1 *)
mfhPvFactor[M_,z_,sgT_,c_,hiK_]:=Module[{legs=mfhPvLegs[M],eff,compactQ,d1,d2,F1,F2,p},
  eff=Table[Total[Last/@Select[legs,Coefficient[First[#],z]===sg&]],{sg,{1,-1}}];
  compactQ=(eff==={0,0});
  If[compactQ,
    p=Total[Table[l[[2]] (Re[N[(l[[1]]/.z->c)/.$mfhEp->0,20]]-1/2),{l,legs}]];
    If[!(p<0),mfhPvRefuse["compact-support factor does not decay on the contour (Stirling exponent "<>ToString[p]<>")"]];
    d1=mfhPvCompactDir[M,z,sgT];d2=mfhPvCompactDir[M,z,-sgT];
    If[d1==="ZERO"&&d2==="ZERO",mfhPvRefuse["compact-support factor without poles"]];
    mfhPrint["      [parseval] compact-support factor ",InputForm[M],": halves ",{d1,d2}];
    F1=If[d1==="ZERO",0,mfhPvTower[M,z,sgT,c,hiK,{d1},True]];
    F2=If[d2==="ZERO",0,mfhPvTower[M,z,-sgT,c,hiK,{d2},True]],
    F1=mfhPvTower[M,z,sgT,c,hiK,{"RIGHT","LEFT"},False];
    F2=mfhPvTower[M,z,-sgT,c,hiK,{"RIGHT","LEFT"},False]];
  <|"F1"->F1,"F2"->F2,"Compact"->compactQ,"M"->M,"z"->z,"sgT"->sgT,"c"->c,"HiK"->hiK|>];
(* leads of both halves of a factor (Infinity when a half vanishes) *)
mfhPvFactorLeads[fac_,hiK_]:={mfhPvLaurentLead[fac["F1"],mfhPvLoF,hiK],mfhPvLaurentLead[fac["F2"],mfhPvLoF,hiK]};
(* forward Mellin transform gate of a factor: int_0^1 F1_k tau^(-sgT z - 1) + int_0^1 F2_k tau^(sgT z - 1) = [eps^k] M(z) *)
mfhPvForwardGate[fac_,kMax_]:=Module[{tau=$mfhPvTau,ep=$mfhEp,M=fac["M"],z=fac["z"],sgT=fac["sgT"],c=fac["c"],pts,ok=True,rows={},ks,f1,f2},
  pts={c+I/2,c-I/3};
  ks=Select[Range[mfhPvLoF,kMax],Coefficient[fac["F1"],ep,#]=!=0||Coefficient[fac["F2"],ep,#]=!=0&];
  Do[Module[{ser=Quiet@Series[M/.z->pt,{ep,0,kMax}],ref,val,g1,g2},
      Do[ref=N[SeriesCoefficient[ser,k],20];
        f1=Coefficient[fac["F1"],ep,k];f2=Coefficient[fac["F2"],ep,k];
        g1[tt_?NumericQ]:=mfhPvN[f1/.tau->tt] tt^(-sgT pt-1);g2[tt_?NumericQ]:=mfhPvN[f2/.tau->tt] tt^(sgT pt-1);
        val=If[f1===0,0,Quiet@NIntegrate[g1[tt],{tt,0,1},PrecisionGoal->9,MaxRecursion->24,Method->"DoubleExponential"]]+
            If[f2===0,0,Quiet@NIntegrate[g2[tt],{tt,0,1},PrecisionGoal->9,MaxRecursion->24,Method->"DoubleExponential"]];
        AppendTo[rows,{k,pt,ref,val}];
        If[!(NumericQ[val]&&Abs[val-ref]<10^-6 Max[1,Abs[ref]]),ok=False],{k,ks}]],{pt,pts}];
  If[!ok,mfhPvRefuse["forward Mellin transform gate failed: "<>ToString[Short[rows,3],InputForm]]];
  mfhPrint["      [parseval] forward transform gate PASS (",Length[rows]," checks)"];rows];
(* exact small-tau asymptotics of one half of one factor: closing-side residues of M tau^(sg z) (sg = +1 closes right) *)
mfhPvAsym[M_,z_,sg_,c_,emax_]:=Module[{tau=$mfhPvTau,ep=$mfhEp,e0=$mfhE0,num,den,poles={},sgnClose=If[sg===1,-1,1]},
  num=Cases[M,Gamma[a_]:>a,{0,Infinity}];den=Cases[M,Power[Gamma[a_],n_/;n<0]:>a,{0,Infinity}];
  num=Select[Complement[num,den],!FreeQ[#,z]&&PolynomialQ[#,z]&&Exponent[#,z]==1&];
  Do[Module[{k=Coefficient[a,z],a0=a/.z->0},Do[Module[{p=(-a0-n)/k,r0,rE},
      r0=Re[N[p/.ep->0,20]];rE=Re[N[p/.ep->e0,20]];
      If[(sg===1&&r0>c&&rE>c)||(sg===-1&&r0<c&&rE<c),If[Re[N[sg p/.ep->0]]<=emax+10^-9,AppendTo[poles,p]]];
      If[(sg===1&&(r0>c)=!=(rE>c))||(sg===-1&&(r0<c)=!=(rE<c)),mfhPvRefuse["a pole crosses the contour between eps = 0 and e0"]]],{n,0,8}]],{a,num}];
  poles=DeleteDuplicates[poles,Simplify[#1-#2]===0&];
  Total[Table[sgnClose Residue[M tau^(sg z),{z,p}],{p,poles}]]];
mfhPvSingularPart[P_]:=Module[{tau=$mfhPvTau,ep=$mfhEp,ex=Expand[PowerExpand[P]],ts,keep={}},
  ts=If[Head[ex]===Plus,List@@ex,{ex}];
  Do[Module[{pw=Total[Cases[t/.Log[tau]->1,Power[tau,p_]:>p,{0,Infinity}]]+Count[t/.Log[tau]->1,tau,{0,1}]},
      If[Re[N[pw/.ep->0]]<=-1+10^-9,AppendTo[keep,t]]],{t,ts}];Total[keep]];
mfhPvMoment[term_]:=Module[{tau=$mfhPvTau,pw,lg,cf},   (* exact int_0^1 of c tau^pw log^lg tau *)
  lg=Exponent[term,Log[tau]];cf=term/.Log[tau]->1;
  pw=Total[Cases[cf,Power[tau,p_]:>p,{0,Infinity}]]+Count[cf,tau,{0,1}];
  cf=Simplify[cf/tau^pw];If[!FreeQ[cf,tau],mfhPvRefuse["moment of a non-monomial term"]];
  cf (-1)^lg lg!/(pw+1)^(lg+1)];
(* rationalization of the algebraic letters of a coefficient function of tau on (0,1): returns {integrand in v incl. the
   Jacobian, v}, or the function itself when no algebraic letter is present *)
mfhPvRationalize[c_,v_]:=Module[{tau=$mfhPvTau,rads,facs,sqrtSet,sub,jac,cv,chk},
  rads=DeleteDuplicates[Cases[c,Power[b_,e_Rational]/;!FreeQ[b,tau]:>Together[b],{0,Infinity}]];
  If[rads==={},Return[{c,tau},Module]];
  If[AnyTrue[Cases[c,Power[b_,e_Rational]/;!FreeQ[b,tau]:>e,{0,Infinity}],Denominator[#]=!=2&],mfhPvRefuse["algebraic letter beyond square roots"]];
  facs=Union@@Table[Module[{fl=Join[FactorList[Numerator[r]],FactorList[Denominator[r]]]},
      Select[fl,OddQ[#[[2]]]&&!FreeQ[#[[1]],tau]&][[All,1]]],{r,rads}];
  sqrtSet=Union[Table[Which[Expand[f]===tau,"t",Expand[f]===1-tau||Expand[f]===-1+tau,"1-t",True,mfhPvRefuse["algebraic letter outside the rationalization table: "<>ToString[f,InputForm]]],{f,facs}]];
  Which[
    sqrtSet==={"1-t"},sub=1-v^2;jac=2 v,
    sqrtSet==={"t"},sub=v^2;jac=2 v,
    True,mfhPvRefuse["square roots of both tau and 1 - tau (alphabet with i) are not integrated yet"]];
  (* the square roots first (principal branch on 0 < v < 1), then the rest *)
  cv=c/.Power[b_,e_Rational]/;!FreeQ[b,tau]:>Power[Simplify[b/.tau->sub,0<v<1],e];
  cv=cv/.Power[b_,e_Rational]/;!FreeQ[b,v]:>PowerExpand[Power[b,e],Assumptions->0<v<1];
  cv=(cv/.tau->sub) jac;
  (* conversion gate: the v-form equals the tau-form pointwise *)
  chk=AllTrue[{1/3,5/7},Module[{tv=#,tauv=sub/.v->#},Abs[mfhPvN[cv/.v->tv]-mfhPvN[c/.tau->tauv] N[jac/.v->tv]]<10^-15 (1+Abs[mfhPvN[c/.tau->tauv]])]&];
  If[!chk,mfhPvRefuse["rationalization changed the integrand (branch)"]];
  {cv,v}];
mfhPvIntegrateOne[c_]:=Module[{tau=$mfhPvTau,v=Global`mfhV,r,cv,xv,val},
  If[c===0,Return[0,Module]];
  If[DownValues[Global`altIntegrate]==={},Get[FileNameJoin[{$mfhCloseDir,"uint_altint.m"}]]];
  {cv,xv}=mfhPvRationalize[Expand[c],v];
  val=Global`altIntegrate[cv,xv,mfhPvN];
  If[val===$Failed,mfhPvRefuse["exact integral refused: "<>ToString[Global`$altIntLastFailure["Reason"]]<>" "<>ToString[Short[Global`$altIntLastFailure["Detail"],3],InputForm]]];
  val];
(* one half: int_0^1 dtau/tau prod F_i(tau), facs = {{F, M, z, sg, c, hiK}..} with F the eps-Laurent coefficient functions *)
mfhPvHalf[facs_List,NJ_]:=Module[{tau=$mfhPvTau,ep=$mfhEp,Fs=facs[[All,1]],ls,lead,SP,mom,P,res=0,t0=AbsoluteTime[]},
  If[MemberQ[Fs,0],Return[0,Module]];
  ls=Table[mfhPvLaurentLead[F,mfhPvLoF,NJ+8],{F,Fs}];
  If[MemberQ[ls,Infinity],Return[0,Module]];
  lead=Total[ls];If[lead>NJ,Return[0,Module]];
  (* every factor must be known up to the order the product needs at eps^NJ (loud, never a silent truncation) *)
  Do[If[NJ-(lead-ls[[i]])>facs[[i,6]],mfhPvRefuse["factor "<>ToString[i]<>" needed to eps^"<>ToString[NJ-(lead-ls[[i]])]<>" but computed to eps^"<>ToString[facs[[i,6]]]]],{i,Length[Fs]}];
  SP=mfhPvSingularPart[Expand[Times@@Table[mfhPvAsym[fc[[2]],fc[[3]],fc[[4]],fc[[5]],3],{fc,facs}]/tau]];
  If[SP=!=0,mfhPrint["      [parseval] tau -> 0: ",Length[If[Head[SP]===Plus,List@@SP,{SP}]]," singular term(s) by exact moments"]];
  mom=Total[mfhPvMoment/@If[Head[SP]===Plus,List@@SP,If[SP===0,{},{SP}]]];
  P=Normal[Series[Times@@Fs/tau-SP,{ep,0,NJ}]];
  Do[Module[{ck=Expand[Coefficient[P,ep,k]],vk},
      If[ck=!=0,vk=mfhPvIntegrateOne[ck];mfhPrint["      [parseval] remainder eps^",k,": ",N[vk,18]];res+=vk ep^k]],{k,lead,NJ}];
  res+Normal[Series[mom,{ep,0,NJ}]]];
mfhParseval[F_,ctr_]:=Module[{ep=$mfhEp,lo=$mfhLo,T=$mfhT,vs=Keys[Normal[ctr]],xv,yv,cx,cy,legs,multi,Cz,Ax,By,Ks,forms,Lf,sx,sy,cs,LC,NJ,sv=$mfhPvS,
    fa,fb,fk,hiK,J,laur,g,ser,c0,i0,q,ok,t0=AbsoluteTime[],status,gates={}},
  If[TrueQ[Global`$mfhNoParseval]||Length[vs]=!=2,Return[Failure["Parseval",<|"Reason"->"not a two-fold"|>],Module]];
  If[DownValues[MBMellinTower`mbeMellinLaurent]==={},Return[Failure["Parseval",<|"Reason"->"Mellin tower rung not loaded"|>],Module]];
  status=Catch[
    {xv,yv}=vs;{cx,cy}=Rationalize[vs/.Normal[ctr],0];
    legs=mfhPvLegs[F];
    Cz=Times@@Select[If[Head[F]===Times,List@@F,{F}],FreeQ[#,xv|yv]&];
    If[!FreeQ[Together[F/Cz]/.Gamma[_]->1,xv|yv],mfhPvRefuse["dressing depends on the Mellin variables (not a pure Gamma product)"]];
    multi=Select[legs,!FreeQ[#[[1]],xv]&&!FreeQ[#[[1]],yv]&];
    If[multi==={},mfhPvRefuse["no coupling leg (factorized item, not this move)"]];
    Ax=mfhPvProd[Select[legs,!FreeQ[#[[1]],xv]&&FreeQ[#[[1]],yv]&]];By=mfhPvProd[Select[legs,!FreeQ[#[[1]],yv]&&FreeQ[#[[1]],xv]&]];
    forms=DeleteDuplicates[Table[Module[{L=Expand[m[[1]]-(m[[1]]/.{xv->0,yv->0})]},If[Coefficient[L,xv]<0,-L,L]],{m,multi}]];
    If[Length[forms]=!=1,mfhPvRefuse["more than one coupling form: "<>ToString[forms,InputForm]]];
    Lf=forms[[1]];sx=Coefficient[Lf,xv];sy=Coefficient[Lf,yv];
    If[!MemberQ[{1,-1},sx]||!MemberQ[{1,-1},sy],mfhPvRefuse["coupling slopes "<>ToString[{sx,sy}]]];
    Ks=mfhPvProd[Table[Module[{a=m[[1]],sig},sig=If[Expand[a-(a/.{xv->0,yv->0})-Lf]===0,1,-1];{(a/.{xv->0,yv->0})+sig sv,m[[2]]}],{m,multi}]];
    If[Simplify[Cz Ax By (Ks/.sv->Lf)-F]=!=0,mfhPvRefuse["one-form factorization check failed"]];
    cs=sx cx+sy cy;
    LC=mfhPvLeadOrder[Cz,T];If[LC===Infinity,Throw["zero",mfhPvTag]];
    NJ=T-LC;If[NJ<0,Throw["beyond",mfhPvTag]];
    mfhPrint["   Mellin-Parseval: form ",InputForm[Lf],", K(s) = ",InputForm[Ks],", Re s = ",cs,", orders of the t-integral up to eps^",NJ];
    (* pass 1 at eps^NJ; a factor whose partners start below eps^0 is recomputed to the order the product needs *)
    hiK=NJ;
    fa=mfhPvFactor[Ax,xv,-sx,cx,hiK];fb=mfhPvFactor[By,yv,-sy,cy,hiK];fk=mfhPvFactor[Ks,sv,1,cs,hiK];
    Module[{fs={fa,fb,fk},mk,lds,minNeg,need},
      mk[i_,h_]:=Switch[i,1,mfhPvFactor[Ax,xv,-sx,cx,h],2,mfhPvFactor[By,yv,-sy,cy,h],3,mfhPvFactor[Ks,sv,1,cs,h]];
      lds=Table[mfhPvFactorLeads[f,f["HiK"]],{f,fs}];
      (* a factor that vanishes through eps^NJ on a half where a partner starts below eps^0 is recomputed deeper before its
         lead is trusted (a one-fold factor starts below eps^0 only through a pinch; the stable contour makes this rare) *)
      minNeg=Table[Total[Table[Min[If[lds[[j,h]]===Infinity,0,lds[[j,h]]],0],{j,3}]],{h,2}];
      Do[If[AnyTrue[Range[2],lds[[i,#]]===Infinity&&minNeg[[#]]<0&],fs[[i]]=mk[i,NJ-Min[minNeg]]],{i,3}];
      lds=Table[mfhPvFactorLeads[f,f["HiK"]],{f,fs}];
      need=Table[Max[Table[If[MemberQ[lds[[All,h]],Infinity],-Infinity,NJ-(Total[lds[[All,h]]]-lds[[i,h]])],{h,2}]],{i,3}];
      Do[If[need[[i]]>fs[[i]]["HiK"],fs[[i]]=mk[i,need[[i]]]],{i,3}];
      If[Max[need]>hiK,mfhPrint["      [parseval] factor leads ",lds,": recomputed to eps^",need]];
      {fa,fb,fk}=fs];
    Do[If[TrueQ[f["Compact"]],AppendTo[gates,mfhPvForwardGate[f,f["HiK"]]]],{f,{fa,fb,fk}}];
    J=mfhPvHalf[{{fa["F1"],Ax,xv,-sx,cx,fa["HiK"]},{fb["F1"],By,yv,-sy,cy,fb["HiK"]},{fk["F1"],Ks,sv,1,cs,fk["HiK"]}},NJ]+
      mfhPvHalf[{{fa["F2"],Ax,xv,sx,cx,fa["HiK"]},{fb["F2"],By,yv,sy,cy,fb["HiK"]},{fk["F2"],Ks,sv,-1,cs,fk["HiK"]}},NJ];
    laur=Normal[Series[Cz J,{ep,0,T}]];
    laur=Sum[Global`mbeCanonicalConstants[Coefficient[laur,ep,k]] ep^k,{k,lo,T}];
    "ok",mfhPvTag];
  Which[
    FailureQ[status],mfhPrint["   Mellin-Parseval refused: ",status["Reason"]];status,
    status==="zero"||status==="beyond",<|"Laurent"->0,"Folds"->2,"Method"->"Mellin-Parseval (prefactor beyond target)"|>,
    True,
    (* the item's own I_0 gate: Laurent coefficient at the prefactor lead over the lead coefficient vs the eps = 0 contour quadrature *)
    g=Together[F/Cz];ser=Quiet@Series[Cz,{ep,0,T}];c0=SeriesCoefficient[ser,LC];i0=Coefficient[laur,ep,LC]/c0;
    q=Global`quad[g/.ep->0,Normal[ctr]];
    ok=TrueQ[NumericQ[q]&&Abs[N[i0,30]-q]<Global`gateTol[2] Max[1,Abs[q]]];
    If[!ok,With[{q2=Global`quadIter[g/.ep->0,Normal[ctr]]},ok=TrueQ[NumericQ[q2]&&Abs[N[i0,30]-q2]<10^-5 Max[1,Abs[q2]]];If[ok,q=q2]]];
    mfhPrint["   Mellin-Parseval: I_0 = ",N[i0,16]," vs quadrature ",N[q,12],If[ok,"  PASS","  FAIL"]," (",Round[AbsoluteTime[]-t0]," s)"];
    If[!ok,Failure["Parseval",<|"Reason"->"Mellin-Parseval value failed the I_0 gate"|>],
      <|"Laurent"->Expand[laur],"Folds"->2,"Method"->"Mellin-Parseval decoupling","Gates"->{{Normal[ctr],0,N[q,12],N[i0,16],ok}},"ForwardGates"->gates|>]]];
(* order of the candidates for a multi-fold item: the closer chain with its engine stages DEFERRED (closed forms, towers,
   slope-two closer; seconds), then the Mellin-Parseval decoupling for two-folds (seconds), then the closer chain with the
   sealed lane and the development engine (minutes to the hour), then the faithful cube on the whole item *)
mfhCloseItem[F_,ctr_]:=If[Normal[ctr]==={},
  With[{z=mfhZeroFold[F]},If[FailureQ[z],z,<|"Laurent"->z,"Folds"->0|>]],
  Module[{r,p,c,why={}},
    (* 2 October 2026: every candidate starts with the package switches of the loader (mbeFlagGuard.m).  A closing stage
       stopped by its time limit inside a HypExp call had left the HPL conversion switches off in the kernel, and the
       Mellin-Parseval decoupling of MB13u residue 49, 9 s in a fresh kernel, refused its integrand ("HPL arguments not
       reduced") in the kernel that had run the family for an hour *)
    Global`mbeFlagGuardRestore["item, before the closer"];
    r=Block[{Global`$closeDeferEngine=True},Global`closeTerm[F,Normal[ctr]]];
    If[!FailureQ[r],Return[Join[r,<|"Folds"->Length[ctr]|>],Module]];
    AppendTo[why,"closer (engine deferred): "<>r["Reason"]];
    Global`mbeFlagGuardRestore["item, after the closer"];
    If[Length[Normal[ctr]]==2,
      p=mfhParseval[F,ctr];
      If[!FailureQ[p],Return[p,Module]];
      AppendTo[why,p["Reason"]]];
    Global`mbeFlagGuardRestore["item, after the Mellin-Parseval decoupling"];
    If[StringContainsQ[r["Reason"],"deferred"],
      r=Global`closeTerm[F,Normal[ctr]];
      If[!FailureQ[r],Return[Join[r,<|"Folds"->Length[ctr]|>],Module]];
      AppendTo[why,"closer: "<>r["Reason"]]];
    Global`mbeFlagGuardRestore["item, before the cube"];
    c=mfhCubeItem[F,ctr];
    If[!FailureQ[c],Return[c,Module]];
    AppendTo[why,c["Reason"]];
    Failure["Close",<|"Reason"->StringRiffle[why,"; "]|>]]];

(* ------------------------------------------------- 5. residues and families ------------------------------------------------- *)
(* a resolved residue: MBint[f, {{eps->0}, ctr}] or {f, ctr}; returns <|"Items"->{{tag,F,ctr}..}, "UIntegration"->.., "Open"->..|> *)
mfhResidueParts[res_]:=Which[Head[res]===MBint,{res[[1]],Normal[res[[2,2]]]},ListQ[res]&&Length[res]==2,{res[[1]],Normal[res[[2]]]},True,{res,{}}];
mfhItems[res_,tag_]:=Module[{f,ctr,uint,uterms,items={},open={},trace={}},
  {f,ctr}=mfhResidueParts[res];
  ctr=Rationalize[#,0]&/@ctr;
  If[$mfhU=!=None,
    uint=mfhUIntegrate[f,ctr];
    If[FailureQ[uint],Return[<|"Items"->{},"Open"->{<|"Reason"->"u-integration refused: "<>uint["Reason"]|>},"UIntegration"->uint|>,Module]];
    uterms=uint["UTerms"],
    uint=<|"UTerms"->{{f,ctr}},"Gates"->{},"Unregulated"->{}|>;uterms={{f,ctr}}];
  Do[If[uterms[[i,1]]===0,Continue[]];
    Module[{g=mfhReduce[uterms[[i,1]],uterms[[i,2]]]},
      If[FailureQ[g],AppendTo[open,<|"UTerm"->i,"Reason"->g["Reason"],"F"->uterms[[i,1]],"Contour"->uterms[[i,2]]|>];Continue[]];
      AppendTo[trace,g["Trace"]];
      mfhPrint["  u-term ",i,": folds ",Length[uterms[[i,2]]]," -> ",g["OutputFolds"]];
      Do[AppendTo[items,{{tag,i},tt[[1]],tt[[2]]}],{tt,g["Terms"]}]],{i,Length[uterms]}];
  <|"Items"->items,"Open"->open,"UIntegration"->uint,"Traces"->trace|>];
(* ITEM ORDER (2 October 2026).  The items of a residue are closed one after another; a residue with several heavy items
   (MB8bu residue 21: six items of about an hour each) then costs their sum.  Global`$mfhItemOrder = "desc", "mid" or
   "rot:k" (default: ascending) changes only the ORDER in which the items are closed, so that several processes of one
   family work on different items of the same residue; every closed item is in the shared term cache and is served from
   there to the others.  The sum over the items does not depend on the order. *)
mfhItemPermutation[n_Integer]:=Module[{o=If[ValueQ[Global`$mfhItemOrder],Global`$mfhItemOrder,"asc"]},
  Which[n<=1,Range[n],
    o==="desc",Reverse[Range[n]],
    o==="mid",RotateLeft[Range[n],Quotient[n,2]],
    StringQ[o]&&StringStartsQ[o,"rot:"],With[{k=ToExpression[StringDrop[o,4]]},If[IntegerQ[k]&&1<=k<=n,RotateLeft[Range[n],k-1],Range[n]]],
    True,Range[n]]];
(* ITEM CLAIMS (2 October 2026): work sharing between the processes of one family run (the main run and its helpers).
   With Global`$mfhItemClaims = True a process CLAIMS an item before it closes it (an atomic directory
   <term cache>/claims/<key>.claim with its process id) and drops the claim afterwards; the result is in the shared term
   cache.  An item claimed by another LIVING process is not started a second time: the other pending items of the residue
   are taken first, and when only claimed items are left a process with Global`$mfhClaimWait = True (the main run, which
   needs every item) waits for them, while the others (helpers) report them open and move to the next residue.  So the
   processes of a family leapfrog over its residues and over the items of a heavy residue instead of repeating each
   other's work.  A claim of a process that no longer exists, or older than $mfhClaimMaxAge, is taken over.  Claims change
   only who computes an item, never a value; without the flag (the public route, a single process) nothing changes. *)
If[!NumericQ[$mfhClaimMaxAge],$mfhClaimMaxAge=6*3600];
If[!NumericQ[$mfhClaimWaitMax],$mfhClaimWaitMax=6*3600];
mfhClaimDir[]:=Module[{d=FileNameJoin[{If[StringQ[Global`$termCacheDir],Global`$termCacheDir,If[StringQ[Global`$closeStateDir],Global`$closeStateDir,$TemporaryDirectory]],"claims"}]},
  If[!DirectoryQ[d],Quiet@CreateDirectory[d,CreateIntermediateDirectories->True]];d];
mfhItemKey[tf_,tc_]:=Hash[{tf,Sort[Normal[tc]],$mfhT,$mfhLo},"SHA256","HexString"];
(* a process that has ended but has not been collected by its parent (state Z) still answers the signal test and would
   keep its claim for hours (2 October 2026: a stopped helper, the main run waited for its item); the state is read from ps *)
mfhPidAliveQ[pid_]:=IntegerQ[pid]&&TrueQ[Quiet@Check[RunProcess[{"kill","-0",ToString[pid]},"ExitCode"]===0,False]]&&
  !TrueQ[Quiet@Check[With[{st=RunProcess[{"ps","-o","stat=","-p",ToString[pid]},"StandardOutput"]},StringQ[st]&&StringStartsQ[StringTrim[st],"Z"]],False]];
mfhClaimedByOtherQ[key_String]:=Module[{c=FileNameJoin[{mfhClaimDir[],key<>".claim"}],info},
  If[!DirectoryQ[c],Return[False,Module]];
  info=Quiet@Check[Get[FileNameJoin[{c,"owner.m"}]],$Failed];
  (* a claim directory without its owner file: being written right now *)
  If[!AssociationQ[info],Return[TrueQ[Quiet[AbsoluteTime[]-AbsoluteTime[FileDate[c]]]<120],Module]];
  info["PID"]=!=$ProcessID&&mfhPidAliveQ[info["PID"]]&&TrueQ[AbsoluteTime[]-info["Start"]<$mfhClaimMaxAge]];
mfhTakeClaim[key_String]:=Module[{c=FileNameJoin[{mfhClaimDir[],key<>".claim"}]},
  If[DirectoryQ[c]&&!mfhClaimedByOtherQ[key],Quiet@DeleteDirectory[c,DeleteContents->True]];
  If[Quiet@Check[CreateDirectory[c],$Failed]=!=$Failed,
    Quiet@Put[<|"PID"->$ProcessID,"Start"->AbsoluteTime[],"Date"->DateString[]|>,FileNameJoin[{c,"owner.m"}]];True,False]];
mfhDropClaim[key_String]:=Quiet@DeleteDirectory[FileNameJoin[{mfhClaimDir[],key<>".claim"}],DeleteContents->True];
mfhCloseItems[items_List,openIn_List]:=Module[{laur=0,open=openIn,closed=0,termsLog={},ep=$mfhEp,lo=$mfhLo,T=$mfhT,pending,
    claims=TrueQ[Global`$mfhItemClaims],waited=0,pos,it,key,own,guard=0},
  pending=items[[mfhItemPermutation[Length[items]]]];
  While[pending=!={}&&guard++<100000,
    pos=If[claims,SelectFirst[Range[Length[pending]],!mfhClaimedByOtherQ[mfhItemKey[pending[[#,2]],pending[[#,3]]]]&,None],1];
    If[pos===None,
      If[TrueQ[Global`$mfhClaimWait]&&waited<$mfhClaimWaitMax,
        (* every pending item is being closed by another process of the family: wait for the term cache *)
        If[waited==0,mfhPrint["  CLAIM_WAIT ",Length[pending]," item(s) of this residue are being closed by other processes of the family; waiting  ",DateString[]]];
        Pause[20];waited+=20,
        If[TrueQ[Global`$mfhClaimWait],
          (* the wait limit: the main run closes the items itself *)
          claims=False,
          mfhPrint["  CLAIM_SKIP ",Length[pending]," item(s) of this residue are left to the process(es) that claimed them"];
          Do[AppendTo[open,<|"Item"->p[[1]],"Folds"->Length[p[[3]]],"Reason"->"being closed by another process of the family (skipped by this helper)","F"->p[[2]],"Contour"->p[[3]]|>],{p,pending}];
          pending={}]],
      it=pending[[pos]];
      key=mfhItemKey[it[[2]],it[[3]]];
      own=claims&&mfhTakeClaim[key];
      If[claims&&!own,
        (* lost the race for the claim: look again *)
        Pause[1],
        pending=Delete[pending,pos];
        If[waited>0,mfhPrint["  CLAIM_WAIT over after ",waited," s"];waited=0];
        Module[{tf=it[[2]],tc=it[[3]],res},
          res=mfhCloseItem[tf,tc];
          If[own,mfhDropClaim[key]];
          If[FailureQ[res],
            mfhPrint["  CLOSE_OPEN item ",it[[1]]," (",Length[tc]," folds): ",res["Reason"]];
            AppendTo[open,<|"Item"->it[[1]],"Folds"->Length[tc],"Reason"->res["Reason"],"F"->tf,"Contour"->tc|>],
            laur+=res["Laurent"];closed++;
            AppendTo[termsLog,Join[<|"Item"->it[[1]],"F"->tf,"Contour"->tc|>,KeyTake[res,{"Folds","Laurent","Pieces","Gates","Stabilization"}]]]]]]]];
  laur=Expand[laur];
  laur=Sum[Global`mbeCanonicalConstants[Coefficient[laur,ep,k]] ep^k,{k,lo,T}];
  <|"Laurent"->laur,"Open"->open,"Closed"->closed,"Terms"->termsLog|>];
Options[mfhResidue]={"Tag"->1};
mfhResidue[res_,OptionsPattern[]]:=Module[{it=mfhItems[res,OptionValue["Tag"]],paired,cl},
  paired=mfhPairItems[it["Items"]];
  cl=mfhCloseItems[paired,it["Open"]];
  Join[cl,<|"Pairs"->Global`$mfhPairLog,"UIntegration"->it["UIntegration"],"Traces"->it["Traces"],
    "Status"->If[cl["Open"]==={},"Closed","Open"],"Orders"->{$mfhLo,$mfhT},"E0"->$mfhE0,"Eta"->$mfhEta|>]];
(* the eta step for unregulated u-endpoints (port of uint_eta_v3d): the family multiplied by u^(eta eps)(1-u)^(eta eps);
   the negative eta powers must cancel over the family (exactly per contour, else by exact Laurent coefficients), the eta^0
   parts R_i are closed like any term, opposite-sign R pairs across residues cancel exactly *)
mfhPolesBetween[f_,ca_,cb_]:=Module[{cur=ca,cnt=0,bad=False},
  Do[If[(v/.cur)=!=(v/.cb),
      Module[{lo1=Min[v/.cur,v/.cb],hi1=Max[v/.cur,v/.cb],pl=Global`polesInV[f,cur,v,$mfhE0]},
        If[AnyTrue[pl,Abs[Re[#[[1]]]-lo1]<10^-20||Abs[Re[#[[1]]]-hi1]<10^-20&],bad=True];
        cnt+=Count[pl,_?(lo1<Re[#[[1]]]<hi1&)]];
      cur=cur/.(v->_):>(v->(v/.cb))],{v,Keys[ca]}];
  If[bad,-1,cnt]];
mfhEta[unreg_List]:=Module[{terms=unreg,etaS=Symbol["Global`etaReg"],ep=$mfhEp,T=$mfhT,kAll,groups,sExact,sCheck,laur=0,recs={},refused={},rPairs={},rOmit={},lo1},
  If[terms==={},Return[<|"Laurent"->0,"Terms"->{},"SCheck"->"none","RPairs"->{}|>,Module]];
  Do[Module[{t=terms[[i]],A,B,jl,kl,beta,ser,kmin,S,R},
      A=t["A"];B=t["B"];jl=Lookup[t,"JL",0];kl=Lookup[t,"KL",0];
      beta=Module[{aa,bb},D[Gamma[aa+1]Gamma[bb+1]/Gamma[aa+bb+2],{aa,jl},{bb,kl}]/.{aa->A+etaS ep,bb->B+etaS ep}];
      ser=Series[beta,{etaS,0,0}];
      If[Head[ser]=!=SeriesData,Return[Failure["Eta",<|"Reason"->"no eta series"|>],Module]];
      kmin=Min[-1,ser[[4]]/ser[[6]]];
      S=Table[k->Simplify[SeriesCoefficient[ser,k]],{k,kmin,-1}];R=SeriesCoefficient[ser,0];
      terms[[i]]=Join[t,<|"S"->(#[[1]]->t["Rest"] #[[2]]&/@S),"R"->t["Rest"] R,"KMin"->kmin|>]],{i,Length[terms]}];
  Module[{used={}},
    Do[If[MemberQ[used,i]||MemberQ[used,j],Continue[]];
      Module[{a=terms[[i]],b=terms[[j]],va,vb,hit=None,cbA,nb},
        va=Keys[a["Contour"]];vb=Keys[b["Contour"]];
        If[Length[va]=!=Length[vb]||va==={},Continue[]];
        Do[Module[{rl=Thread[vb->p]},If[Together[mfhPairNrm[a["R"]]+mfhPairNrm[b["R"]/.rl]]===0,hit=rl;Break[]]],{p,Permutations[va]}];
        If[hit=!=None,
          cbA=Normal[b["Contour"]]/.(x_->c_):>((x/.hit)->c);
          nb=mfhPolesBetween[a["R"],Normal[a["Contour"]],cbA];
          If[nb===0,used=Join[used,{i,j}];AppendTo[rPairs,<|"A"->Lookup[a,{"Family","Residue","Index"}],"B"->Lookup[b,{"Family","Residue","Index"}]|>];
            mfhPrint["  [eta R pair] ",Lookup[a,{"Family","Residue","Index"}]," + ",Lookup[b,{"Family","Residue","Index"}],": exact cancellation"]]]],
      {i,Length[terms]},{j,i+1,Length[terms]}];
    rOmit=used];
  kAll=Range[Min[#["KMin"]&/@terms],-1];
  groups=GatherBy[terms,Sort[Normal[#["Contour"]]]&];
  sExact=AllTrue[groups,Function[g,AllTrue[kAll,Function[k,TrueQ[Together[Total[(k/.Append[#["S"],_->0])&/@g]]===0]]]]];
  sCheck=If[sExact,"integrands cancel exactly per contour",
    Module[{tot},Do[tot=0;
        Do[If[!PossibleZeroQ[k/.Append[t["S"],_->0]],Module[{rs=Global`closeTerm[k/.t["S"],Normal[t["Contour"]]]},
            If[FailureQ[rs],Return[Failure["Eta",<|"Reason"->"S term refused: "<>rs["Reason"]|>],Module]];tot+=rs["Laurent"]]],{t,terms}];
        tot=Expand[tot];
        If[tot=!=0&&!AllTrue[CoefficientList[tot ep^20,ep],PossibleZeroQ[Global`mbeCanonicalConstants[#]]&],
          Return[Failure["Eta",<|"Reason"->"the eta^"<>ToString[k]<>" parts do not cancel through eps^"<>ToString[T]|>],Module]],{k,kAll}];
      "exact Laurent coefficients of the S parts vanish"]];
  If[FailureQ[sCheck],Return[sCheck,Module]];
  Do[If[MemberQ[rOmit,ti],Continue[]];
    Module[{t=terms[[ti]],rc},
      rc=Global`closeTerm[t["R"],Normal[t["Contour"]]];
      If[FailureQ[rc],AppendTo[refused,Join[Lookup[t,{"Family","Residue","Index"}],{rc["Reason"]}]],
        laur+=rc["Laurent"];AppendTo[recs,Join[KeyDrop[t,{"S","R"}],<|"RLaurent"->rc["Laurent"]|>]]]],{ti,Length[terms]}];
  If[refused=!={},Return[Failure["Eta",<|"Reason"->"R terms open","Refused"->refused|>],Module]];
  laur=Expand[laur];lo1=If[laur===0,T,Min[Exponent[laur,ep,Min],T]];
  laur=Sum[Global`mbeCanonicalConstants[Coefficient[laur,ep,k]] ep^k,{k,lo1,T}];
  <|"Laurent"->laur,"Terms"->recs,"SCheck"->sCheck,"RPairs"->rPairs|>];
(* a family: resolved = list of MBint (or {f, ctr}); "CrossResiduePairs" pairs items across all residues before closing;
   "Family" tags the records; "Benchmark" -> exact benchmark list {c_lo, .., c_T} (or None) is used ONLY in the comparison *)
Options[mfhFamily]={"CrossResiduePairs"->True,"Family"->"MB","Benchmark"->None,"Residues"->All,"Record"->None};
mfhFamily[resolved_List,OptionsPattern[]]:=Module[{idx,state=<||>,all,paired,lo=$mfhLo,T=$mfhT,ep=$mfhEp,total=0,unreg={},open={},perRes={},etaRec,cmp=None,rec,t0=AbsoluteTime[]},
  idx=If[OptionValue["Residues"]===All,Range[Length[resolved]],OptionValue["Residues"]];
  Do[Module[{it},mfhPrint["== ",OptionValue["Family"]," residue ",r,": ",Length[mfhResidueParts[resolved[[r]]][[2]]]," variables ",DateString[]];
      it=mfhItems[resolved[[r]],r];state[r]=it;
      unreg=Join[unreg,Join[<|"Family"->OptionValue["Family"],"Residue"->r|>,#]&/@Lookup[it["UIntegration"],"Unregulated",{}]]],{r,idx}];
  If[TrueQ[OptionValue["CrossResiduePairs"]],
    all=Join@@(state[#]["Items"]&/@idx);mfhPrint["PAIRING across residues: ",Length[all]," items"];
    paired=mfhPairItems[all];Global`$mfhFamilyPairs=Global`$mfhPairLog;
    Do[state[r]["Items"]=Select[paired,#[[1,1]]===r&],{r,idx}],
    Do[state[r]["Items"]=mfhPairItems[state[r]["Items"]],{r,idx}];Global`$mfhFamilyPairs={}];
  Do[Module[{cl=mfhCloseItems[state[r]["Items"],state[r]["Open"]]},
      AppendTo[perRes,<|"Residue"->r,"Laurent"->cl["Laurent"],"Open"->cl["Open"],"Closed"->cl["Closed"]|>];
      total+=cl["Laurent"];open=Join[open,<|"Residue"->r|>~Join~#&/@cl["Open"]];
      mfhPrint[If[cl["Open"]==={},"DONE","OPEN"]," residue ",r,": ",Table[{k,N[Coefficient[cl["Laurent"],ep,k],16]},{k,Max[lo,-8],T}]]],{r,idx}];
  etaRec=mfhEta[unreg];
  If[FailureQ[etaRec],AppendTo[open,<|"Residue"->"eta","Reason"->etaRec["Reason"]|>],total+=etaRec["Laurent"]];
  total=Expand[total];total=Sum[Global`mbeCanonicalConstants[Coefficient[total,ep,k]] ep^k,{k,lo,T}];
  If[OptionValue["Benchmark"]=!=None,cmp=mfhCompare[total,OptionValue["Benchmark"]]];
  rec=<|"Family"->OptionValue["Family"],"Residues"->idx,"Orders"->{lo,T},"E0"->$mfhE0,"Eta"->$mfhEta,"Parameter"->$mfhU,
    "Laurent"->total,"PerResidue"->perRes,"Open"->open,"CrossResiduePairs"->Global`$mfhFamilyPairs,"EtaStep"->If[FailureQ[etaRec],etaRec,KeyDrop[etaRec,"Terms"]],
    "Comparison"->cmp,"Status"->If[open==={},"Closed","Open"],"Seconds"->Round[AbsoluteTime[]-t0],"Tool"->"mbeMultifoldHandler.m","Date"->DateString["ISODateTime"]|>;
  If[StringQ[OptionValue["Record"]],Put[rec,OptionValue["Record"]]];
  rec];
(* exact comparison with a benchmark: bench = list of exact coefficients for orders low..T (Real part of the route value);
   the difference must be exactly zero after canonicalization *)
mfhCompare[laur_,bench_Association]:=Module[{ep=$mfhEp,rows={}},
  Do[Module[{c=Global`mbeCanonicalConstants[Re[Coefficient[laur,ep,k]]],b=bench[k],d},
      d=Global`mbeCanonicalConstants[Simplify[c-b]];
      AppendTo[rows,<|"Order"->k,"Route"->N[c,20],"Benchmark"->N[b,20],"ExactDifference"->d,"Match"->(d===0||TrueQ[Simplify[d]==0])|>]],{k,Keys[bench]}];
  <|"Rows"->rows,"AllMatch"->AllTrue[rows,#["Match"]&]|>];

(* ------------------------------------------------- 6. wiring into the Subtraction route ------------------------------------------------- *)
(* one constant-mode attempt of the handler on a residue: the exact Laurent list eps^ordMin..eps^ordMax or $Failed *)
mfhConstantAttempt[term_,eps_Symbol,ordMin_Integer,ordMax_Integer,verbose_,budget_]:=Module[{r,ans,e0c},
  r=Block[{Global`$mfhActive=True},
    mfhSetup[eps,"Target"->ordMax,"Low"->ordMin,"CloseSeconds"->budget,"BarnesSeconds"->Min[300,budget],
      "Parameter"->None,"ParallelPieces"->!TrueQ[Global`$oftNoSubkernels]];
    (* 3 October 2026: the decision point inside the crossing-free interval of the residue's own lines.  The contours of
       an MBresolve residue are valid near eps = 0 only; when a pole meets the residue's line between E0 = -1/40 and 0,
       the fixed-contour integral at E0 is another analytic function, and the stabilization read there adds a crossed
       residue that does not belong to the residue -- an exact, gated, WRONG value (MB5 residues 10 and 12, MB9 residue
       18; the faithful cube had met the same class on 11 September, MB9 residue 18, 66.09 for -44.14).  The decision
       point is halved from -1/40 until the residue's lines are pole-free on [E0, 0]. *)
    e0c=If[TrueQ[Global`$mfhReady],mfhConstantE0[term],$Failed];
    If[e0c===$Failed,
      If[verbose,Print["    general multifold handler: no pole-free decision point on the residue's own lines"]],
      If[e0c=!=$mfhE0,
        If[verbose,Print["    general multifold handler: decision point ",e0c," (a pole meets the residue's line between ",$mfhE0," and 0)"]];
        mfhSetup[eps,"E0"->e0c,"Target"->ordMax,"Low"->ordMin,"CloseSeconds"->budget,"BarnesSeconds"->Min[300,budget],
          "Parameter"->None,"ParallelPieces"->!TrueQ[Global`$oftNoSubkernels]]]];
    If[TrueQ[Global`$mfhReady]&&e0c=!=$Failed,TimeConstrained[Quiet@mfhResidue[term],budget,$TimedOut],$Failed]];
  If[r===$TimedOut,If[verbose,Print["    general multifold handler: time budget ",budget," s exceeded"]]];
  If[AssociationQ[r]&&r["Status"]==="Closed",
    ans=Table[Coefficient[r["Laurent"],eps,k],{k,ordMin,ordMax}];
    If[FreeQ[ans,$Failed|$Aborted|_Failure|_Real|_Missing|eps]&&TrueQ[Global`exactQ[ans]],
      If[verbose,Print["    multi-fold residue closed by the general multifold handler (",r["Closed"]," items, pairs ",Length[r["Pairs"]],")"]];
      Return[ans,Module]]];
  If[verbose,Print["    general multifold handler refused: ",If[AssociationQ[r],Lookup[#,"Reason","?"]&/@r["Open"],r]]];
  If[r===$TimedOut,$TimedOut,$Failed]];

(* the constant-route multi-fold slot: Global`oftMultiFoldHandler[term, eps, ordMin, ordMax, verbose] (mbeOneFoldTowerRung.m).
   The handler runs first with the family driver's budget; its refusal falls through to the previous chain. *)
mfhInstall[]:=Module[{},
  If[DownValues[Global`oftMultiFoldHandler]==={},Return[$Failed,Module]];
  If[DownValues[Global`mfhPreviousMultiFoldHandler]=!={},Return["already installed",Module]];
  (* the previous chain under a new head (same definitions) *)
  DownValues[Global`mfhPreviousMultiFoldHandler]=DownValues[Global`oftMultiFoldHandler]/.HoldPattern[Global`oftMultiFoldHandler]->Global`mfhPreviousMultiFoldHandler;
  (* time budget of the constant-mode attempt (the research finding: minutes per move, then the next representation);
     the previous chain (faithful cube, piece workers) keeps the family driver's own budget *)
  If[!ValueQ[Global`$mfhConstantBudget],Global`$mfhConstantBudget=1200];
  (* depth guard: the handler's closing chain expands the term at fixed contours to the Taylor depth ordMax - lead of the
     z-free prefactor; a deep expansion of a multi-fold term is the expanded-multivariable path the research finding excludes
     (MB4 at eps^1: depth 4, 639 pieces).  Beyond $mfhConstantMaxDepth the term goes to the previous chain directly. *)
  If[!ValueQ[Global`$mfhConstantMaxDepth],Global`$mfhConstantMaxDepth=2];
  (* 3 October 2026: the handler's second chance.  When the previous chain refuses a residue that the handler did not get
     (depth guard) or that the handler gave up on because of its time budget, the handler takes it once more, at its full
     Taylor depth and with the longer budget $mfhDeepBudget, before the residue is refused.  (MB11 from its kernel, residue
     18, three folds: the handler stopped at its 1200 s budget, the faithful cube refused one sub-piece, the Barnes
     reduction left one two-fold polygamma piece that the piece workers could not close.)  The handler's closing chain
     (rewrite rung, sealed lane, jet rung, two-fold closer) is the stronger closer for such pieces.  Entries of the core's
     failed-piece ledger that the refused previous-chain attempt left behind are withdrawn when the handler closes the
     residue: the value of that attempt is not used.  A residue the handler refused for a structural reason is not tried
     again.  $mfhDeepFallback = False switches it off. *)
  If[!ValueQ[Global`$mfhDeepBudget],Global`$mfhDeepBudget=7200];
  Global`oftMultiFoldHandler[term_,eps_Symbol,ordMin_Integer,ordMax_Integer,verbose_]:=Module[{ans,first=None,vs,cz,ser,lead,depth,n0,prev},
    vs=Keys[term[[2,2]]];
    cz=Times@@Select[If[Head[term[[1]]]===Times,List@@term[[1]],{term[[1]]}],FreeQ[#,Alternatives@@vs]&];
    ser=Quiet@Series[cz,{eps,0,2}];lead=If[Head[ser]===SeriesData,ser[[4]]/ser[[6]],0];depth=ordMax-lead;
    If[TrueQ[Global`$mfhEnabled]&&Length[vs]>=2&&depth>Global`$mfhConstantMaxDepth,
      If[verbose,Print["    general multifold handler: Taylor depth ",depth," > ",Global`$mfhConstantMaxDepth," -> previous chain first"]]];
    If[TrueQ[Global`$mfhEnabled]&&!TrueQ[Global`$mfhActive]&&Length[vs]>=2&&depth<=Global`$mfhConstantMaxDepth,
      first=ans=mfhConstantAttempt[term,eps,ordMin,ordMax,verbose,Global`$mfhConstantBudget];
      If[ListQ[ans],Return[ans,Module]];
      If[verbose,Print["    -> previous chain"]]];
    n0=Length[MBtoMPL`Private`$mbtFailedPieces];
    prev=Global`mfhPreviousMultiFoldHandler[term,eps,ordMin,ordMax,verbose];
    If[ListQ[prev]&&Length[prev]===ordMax-ordMin+1&&FreeQ[prev,$Failed],Return[prev,Module]];
    If[TrueQ[Global`$mfhEnabled]&&!TrueQ[Global`$mfhActive]&&Length[vs]>=2&&(first===None||first===$TimedOut)&&
        Global`$mfhDeepBudget>If[first===$TimedOut,Global`$mfhConstantBudget,0]&&
        Global`$mfhDeepFallback=!=False&&!TrueQ[Global`$oftSubtractionOnly],
      If[verbose,Print["    previous chain refused the residue: the general multifold handler once more at full Taylor depth ",depth,
        " (", If[first===$TimedOut,"its first attempt stopped at its time budget","the depth guard had kept it from the handler"],
        "; budget ",Global`$mfhDeepBudget," s)"]];
      ans=mfhConstantAttempt[term,eps,ordMin,ordMax,verbose,Global`$mfhDeepBudget];
      If[ListQ[ans],
        If[Length[MBtoMPL`Private`$mbtFailedPieces]>n0,
          If[verbose,Print["    ",Length[MBtoMPL`Private`$mbtFailedPieces]-n0,
            " failed-piece ledger entr(ies) of the refused previous-chain attempt withdrawn (its value is not used)"]];
          MBtoMPL`Private`$mbtFailedPieces=Take[MBtoMPL`Private`$mbtFailedPieces,n0]];
        Return[ans,Module]]];
    prev];
  "installed"];
Print["[mbeMultifoldHandler] general multifold handler loaded: u-integration at the MB level, stabilized finite-eps Barnes chains with unimodular pivots and complex-point gates, pair census, closing chain, eta step, family sum; mfhInstall[] wires the Subtraction multi-fold slot."];
