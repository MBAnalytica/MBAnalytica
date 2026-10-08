(* uint_close_lib.m  (2026-09-26) -- shared closing functions of the Mellin-space route
   (the same definitions as uint_stdclose_v1.wls, factored out for uint_eta_v1.wls and later tools).
   The caller sets, after Get["load_standard_w10.m"]: ep (regulator), e0 (< 0, decision point), eta (= -e0/4), T (target),
   closeSeconds (time limit of one closer call).
   stabilize[f, ctr, 0]  -> {{f_i, ctr_i}..} with Sum_i int_{ctr_i} f_i = int_ctr f continued from e0, every piece free of
                            poles on its contour for eps in [e0, eta] (hence holomorphic near [e0, 0]).
   taylor[G, ctr, D]      -> exact Taylor coefficients I_0..I_D of int_ctr G at eps = 0 (package fixed-contour closer),
                            or Failure[..].
   quad[g, ctr]           -> contour quadrature of g (gate only).
   closeTerm[g, ctr]      -> <|"Laurent" -> exact Laurent of int_ctr g through eps^T, "Pieces", "Gates", "Stabilization"|>
                            or Failure[..] (stabilization + prefactor split + taylor + gates I_0, I_1). *)

(* u-aware: powers of the external parameter (u, 1-u) are not Mellin poles; $uSym = the parameter symbol or None *)
If[!ValueQ[$uSym],$uSym=None];
uStrip[f_]:=If[$uSym===None,f,f/.{Power[b_,_]/;!FreeQ[b,$uSym]:>1,b_/;(b===$uSym||b===1-$uSym||b===-1+$uSym):>1}];
poleArgs[f0_,vars_]:=Module[{f=uStrip[f0],num,den,pg,rat},
  num=Cases[f,Gamma[a_]:>a,{0,Infinity}];den=Cases[f,Power[Gamma[a_],n_/;n<0]:>a,{0,Infinity}];
  num=Complement[num,den];pg=Cases[f,PolyGamma[_,a_]:>a,{0,Infinity}];
  rat=Cases[Denominator[Together[f/.{Gamma[_]->1,PolyGamma[_,_]->1}]],x_/;!FreeQ[x,Alternatives@@vars]:>If[Head[x]===Power,x[[1]],x],{0,1}];
  Join[{#,"G"}&/@Select[DeleteDuplicates[Join[num,pg]],!FreeQ[#,Alternatives@@vars]&],{#,"R"}&/@DeleteDuplicates[rat]]];
metPoles[pa_,ctr_]:=Module[{al=Expand[pa[[1]]/.ctr],a0,a1,lo,hi},
  a0=al/.ep->0;a1=Coefficient[al,ep];
  If[!NumericQ[a0]||!NumericQ[a1]||!FreeQ[al,Alternatives@@Keys[ctr]],Return[{"nonlinear"}]];
  {lo,hi}=MinMax[{a0+a1 e0,a0+a1 eta}];
  If[pa[[2]]==="R",Select[{0},lo<=#<=hi&],Range[Ceiling[lo],Min[0,Floor[hi]]]]];
badArgs[f_,ctr_]:=Select[poleArgs[f,Keys[ctr]],metPoles[#,ctr]=!={}&];
polesInV[f_,ctr_,v_,ee_]:=Module[{out={}},
  Do[Module[{a=pa[[1]],k=Coefficient[pa[[1]],v],rest},
    If[k===0||!FreeQ[k,Alternatives@@Keys[ctr]],Continue[]];
    rest=Expand[a-k v];   (* 2026-09-29: EXPAND -- a leg written with a common factor, Gamma[3 eps + 2 (us + z)], kept v symbolic in the pole position, which then never became numeric and the crossing was silently dropped (MB14bu pair {85,6}<->{100,5}) *)
    If[pa[[2]]==="R",AppendTo[out,{-rest/k,a}],
      Do[AppendTo[out,{(-n-rest)/k,a}],{n,0,120}]]],{pa,poleArgs[f,Keys[ctr]]}];
  {N[(#[[1]]/.DeleteCases[ctr,v->_])/.ep->ee,30],#[[1]],#[[2]]}&/@out];
stabLog={};
(* ONE line move for the first offending argument: {{f, newCtr}, {res_1, ctr\v}, ...}; the identity holds at e0 *)
stabilizeStep[f_,ctr_List,depth_]:=Module[{bad=badArgs[f,ctr],a,cands,v,cv,newC=None,newCtr,crossed,res},
  If[bad==={},Return[{{f,ctr}}]];
  a=bad[[1,1]];
  Do[If[newC=!=None,Break[]];
    cv=v/.ctr;
    cands=SortBy[Join[Table[cv+k/112,{k,1,300}],Table[cv-k/112,{k,1,300}]],Abs[#-cv]&];
    Do[Module[{ct=ctr/.(v->_):>(v->c)},
        If[Select[badArgs[f,ct],!FreeQ[#[[1]],v]&]==={},newC={v,c};Break[]]],{c,cands}],
    {v,Select[Keys[ctr],!FreeQ[a,#]&]}];
  If[newC===None,Print["CLOSE_REFUSED no stabilizing line for ",InputForm[a]];Throw[$Failed,"refuse"]];
  {v,cv}={newC[[1]],newC[[1]]/.ctr};newCtr=ctr/.(v->_):>(v->newC[[2]]);
  If[AnyTrue[polesInV[f,ctr,v,e0],Abs[Re[#[[1]]]-cv]<10^-20||Abs[Re[#[[1]]]-newC[[2]]]<10^-20&],
    Print["CLOSE_REFUSED a pole lies on a contour line at e0"];Throw[$Failed,"refuse"]];
  crossed=Select[polesInV[f,ctr,v,e0],Min[cv,newC[[2]]]<Re[#[[1]]]<Max[cv,newC[[2]]]&];
  crossed=DeleteDuplicates[#[[2]]&/@crossed,Simplify[#1-#2]===0&];
  AppendTo[stabLog,<|"Depth"->depth,"Argument"->a,"Variable"->v,"From"->cv,"To"->newC[[2]],"Crossed"->crossed|>];
  Print[StringRepeat["  ",depth],"stabilize: argument ",InputForm[a]," meets a pole on [e0,eta]; ",v,": ",cv," -> ",newC[[2]],
    ", crossed at e0: ",InputForm[crossed]];
  res=Table[If[newC[[2]]>cv,-1,1] Residue[f,{v,pl}],{pl,crossed}];
  Join[{{f,newCtr}},Select[Table[{res[[i]],DeleteCases[ctr,v->_]},{i,Length[res]}],#[[1]]=!=0&]]];
stabilize[f_,ctr_List,depth_]:=Module[{st},
  If[badArgs[f,ctr]==={},Return[{{f,ctr}}]];
  If[depth>8,Print["CLOSE_REFUSED stabilization depth"];Throw[$Failed,"refuse"]];
  st=stabilizeStep[f,ctr,depth];
  Join@@(stabilize[#[[1]],#[[2]],depth+1]&/@st)];

globalSyms[x_]:=DeleteDuplicates[Cases[x,s_Symbol/;Context[s]==="Global`"&&s=!=ep,{0,Infinity},Heads->True]];
(* failure markers of any package (e.g. HypExp`$HypExpFailed) are never exact values *)
failSymQ[x_]:=!FreeQ[x,s_Symbol/;StringContainsQ[SymbolName[Unevaluated[s]],"Failed"|"Aborted"|"TimedOut"],{0,Infinity},Heads->True];
exactQ[x_]:=FreeQ[x,_Real|$Failed|$Aborted|$TimedOut|Indeterminate|ComplexInfinity|DirectedInfinity|_MBint|
  _HypergeometricPFQ|_SeriesData|_Missing|_Failure|Integrate|NIntegrate]&&FreeQ[x,ep]&&globalSyms[x]==={}&&!failSymQ[x];
taylor[g_,ctr_,dd_]:=Module[{nFail=Length[MBtoMPL`Private`$mbtFailedPieces],nHung=MBtoMPL`Private`$mbtTotalHungCount,r,t0=AbsoluteTime[]},
  r=TimeConstrained[Catch[If[TrueQ[$useParallelPieces],stdRoutePar[g,ctr,dd],MBtoMPL`Private`mbtLocalStdRoute[MBint[g,{{ep->0},ctr}],ep,0,dd]],"deferEngine"],closeSeconds,$TimedOut];
  If[r===$TimedOut,Return[Failure["Closer",<|"Reason"->"time limit "<>ToString[closeSeconds]<>" s"|>],Module]];
  If[FailureQ[r],Return[r,Module]];
  Print["    closer: ",Round[AbsoluteTime[]-t0]," s"];
  Which[
    Length[MBtoMPL`Private`$mbtFailedPieces]>nFail,Failure["Closer",<|"Reason"->"failed-piece ledger grew"|>],
    MBtoMPL`Private`$mbtTotalHungCount>nHung,Failure["Closer",<|"Reason"->"hung pieces"|>],
    !ListQ[r]||Length[r]=!=dd+1,Failure["Closer",<|"Reason"->"no coefficient list"|>],
    !exactQ[r],Failure["Closer",<|"Reason"->"inexact or unevaluated coefficient (Global` symbols "<>ToString[globalSyms[r]]<>"): "<>ToString[Short[Select[r,!exactQ[#]&],3],InputForm]|>],
    True,Global`mbeCanonicalConstants/@r]];
(* the same construction as mbtLocalStdRoute (MBexpand at the given contours, DoAllBarnes, MBmerge of the contour-free
   pieces, per-piece exact closer), the pieces closed on subkernel workers (mbtClosePiecesParallel: indexed result files,
   failed pieces ledgered, never silently 0) when there are at least parMin of them *)
If[!ValueQ[parWorkers],parWorkers=12];If[!ValueQ[parMin],parMin=1];If[!ValueQ[ladderSeconds],ladderSeconds=900];
(* 2026-10-01: parMin 1 -- a piece closed in the main kernel's serial branch costs minutes of the whole family (271 s and
   592 s on single pieces of MB8au r43); every piece goes to a worker.  Budgets after the robust chain: the ladder 180 s
   (its external reads ignore TimeConstrained; the master's deadline is the real cap) *)
If[!ValueQ[pieceLadderSeconds],pieceLadderSeconds=180];
$closeLibDir=DirectoryName[$InputFileName];
(* run-time state (piece cache, term cache, open-piece census): in the development tree next to this library, in a
   release tree under the release's cache directory (the caller presets $closeStateDir before loading; never sealed) *)
If[!ValueQ[$closeStateDir],$closeStateDir=$closeLibDir];
(* the Barnes 2+2 closed form for eps-free one-fold pieces (uint_b22_lib.m); b22Taylor: the Taylor coefficients of a
   one-fold TERM, each coefficient expanded into polygamma monomials closed by b22Gated (every monomial gated) *)
Get[FileNameJoin[{$closeLibDir,"uint_b22_lib.m"}]];
Get[FileNameJoin[{$closeLibDir,"uint_bn_lib.m"}]];
If[FileExistsQ[FileNameJoin[{$closeLibDir,"uint_bg_lib.m"}]],Get[FileNameJoin[{$closeLibDir,"uint_bg_lib.m"}]]];
(* the slope-two closer (09-27): Beta undo + inner Mellin tower at Y = v(1-v) + outer IntVolIntegrate on a pure Euler
   integrand + sixth-root reduction; needs the level-six reducer of the dev tree *)
If[DownValues[Global`bwsL6Reduce]==={}&&FileExistsQ[FileNameJoin[{ParentDirectory[$closeLibDir],"mbeLevel6Reduce.m"}]],
  Get[FileNameJoin[{ParentDirectory[$closeLibDir],"mbeLevel6Reduce.m"}]]];
If[FileExistsQ[FileNameJoin[{$closeLibDir,"uint_fcu_s2.m"}]],Get[FileNameJoin[{$closeLibDir,"uint_fcu_s2.m"}]]];
(* 2 October 2026: the generalized-lemma rewrite of pure-Gamma multi-fold pieces with pinched legs (uint_gle.m): one fold
   by the regulated lemma, the d^0 part as lower-fold pieces, the tail as a dressed cube; used by stdRoutePar after the
   sealed lane, before the engine *)
If[FileExistsQ[FileNameJoin[{$closeLibDir,"uint_gle.m"}]],Get[FileNameJoin[{$closeLibDir,"uint_gle.m"}]]];
If[!ValueQ[$useGleRewrite],$useGleRewrite=True];If[!ValueQ[$gleRewriteSeconds],$gleRewriteSeconds=1800];If[!ValueQ[$gleMaxRewrites],$gleMaxRewrites=3];If[!ValueQ[$gleMaxDepth],$gleMaxDepth=5];
If[!ValueQ[$useBnWorker],$useBnWorker=True];
(* multi-fold TERMS: Taylor coefficients expanded into polygamma monomials, each closed by the iterated Barnes 2+2 closed
   form (no per-monomial quadrature; the term gates of closeTerm apply) *)
bnTaylor[G_,c2_,dep_]:=Module[{s,out={}},
  s=withPlainSeries[Quiet@Series[G,{ep,0,dep}]];
  If[Head[s]=!=SeriesData||s[[4]]<0,Return[Failure["BN",<|"Reason"->"Taylor series of G"|>],Module]];
  Catch[Do[Module[{ck=Expand[SeriesCoefficient[s,k]],v},
      v=TimeConstrained[bnClose[ck,c2],Min[300,closeSeconds],Failure["BN",<|"Reason"->"time limit"|>]];
      If[FailureQ[v],Throw[v,"bnt"]];
      If[!exactQ[v],Throw[Failure["BN",<|"Reason"->"inexact"|>],"bnt"]];
      AppendTo[out,v]],{k,0,dep}];
    out,"bnt"]];
b22Taylor[G_,c2_,dep_]:=Module[{s,out={}},
  s=withPlainSeries[Quiet@Series[G,{ep,0,dep}]];
  If[Head[s]=!=SeriesData||s[[4]]<0,Return[Failure["B22",<|"Reason"->"Taylor series of G"|>],Module]];
  Catch[Do[Module[{ck=Expand[SeriesCoefficient[s,k]],terms,vals},
      terms=If[Head[ck]===Plus,List@@ck,{ck}];
      vals=Table[If[FreeQ[tm,Alternatives@@Keys[c2]],Throw[Failure["B22",<|"Reason"->"z-free Taylor term"|>],"b22t"],
          With[{b=b22Gated[tm,c2,120]},If[AssociationQ[b]||DownValues[bgGated]==={},b,bgGated[tm,c2,300]]]],{tm,terms}];
      If[AnyTrue[vals,FailureQ],Throw[First[Select[vals,FailureQ]],"b22t"]];
      AppendTo[out,Total[#["Value"]&/@vals]]],{k,0,dep}];
    out,"b22t"]];
(* one-fold pieces on subkernel workers running the tower ladder (uint_ladder_worker.m; file protocol of the package's
   piece workers); returns the list of exact values, Missing["ladder"] where a worker refused or produced nothing *)
(* 2026-10-01 ROBUST MASTER: the workers CLAIM pieces dynamically (atomic claim directories; the affinity lists
   below are only their starting order), the master waits with the low-level kernel API (Parallel`Developer`Send /
   ReceiveIfReady, polled) under a HARD DEADLINE $ladderJobSeconds: TimeConstrained around ParallelEvaluate did not interrupt
   a worker blocked in an external read (MB8au r43: a 300 s piece budget ran 6090 s, a 2400 s lane budget ran 2.5 h), so at
   the deadline the running evaluations are aborted and a worker that does not answer within 15 s is ended by its PID.  The
   r_ files written so far are collected either way; the heartbeat files name the piece and stage of every worker. *)
If[!ValueQ[$ladderJobSeconds],$ladderJobSeconds=5400];   (* 2 October: a stall limit (no new result), above the longest single piece seen (MB14bu residue 28: 2820 s) *)
(* 2 October 2026: the stage budgets of a pool worker are those of the worker file again (slope-two closer 2400 s, unit
   tower 1800 s, 3600 s per piece).  The values 900 / 1200 / 2400 set with the robust master on 1 October cut the slope-two
   closer off on MB14bu residue 28's piece (three samples of about 350 s each on a loaded node; closed in the run of
   30 September under the worker's defaults), after which the lane and the engine refuse it. *)
If[!ValueQ[$s2PieceSeconds],$s2PieceSeconds=2400];If[!ValueQ[$unitPieceSeconds],$unitPieceSeconds=1800];If[!ValueQ[$pieceTotalSeconds],$pieceTotalSeconds=3600];
(* wait for the evaluations sent to ks (one per kernel) until all answered or the deadline; returns the kernels still busy *)
(* 2 October 2026: with stall = True the deadline is a STALL limit: the clock restarts whenever a new result file appears,
   so a pool with a long queue (264 one-fold pieces of a rewrite, some of them 15 minutes each) is not cut off while it
   makes progress, and hung workers are still ended (no result for `deadline` seconds, more than the budget of one piece) *)
waitWorkers[ks_List,deadline_,label_String,job_,stall_:False]:=Module[{pending=ks,t0=AbsoluteTime[],lastLog=AbsoluteTime[],tp=AbsoluteTime[],nr=0},
  While[pending=!={}&&AbsoluteTime[]-If[TrueQ[stall],tp,t0]<deadline,
    Pause[2];
    If[TrueQ[stall],With[{c=Length[FileNames["r_*.m",job]]},If[c>nr,nr=c;tp=AbsoluteTime[]]]];
    pending=Select[pending,Function[k,Quiet@Parallel`Developer`ReceiveIfReady[k]===Parallel`Developer`$NotReady]];
    If[AbsoluteTime[]-lastLog>600,lastLog=AbsoluteTime[];
      Print["    [",label,"] ",Round[AbsoluteTime[]-t0]," s: ",Length[pending]," worker(s) busy, ",
        Length[FileNames["r_*.m",job]]," result file(s)",
        With[{hb=Quiet@Check[Get/@FileNames["hb_*.m",job],{}]},If[ListQ[hb]&&hb=!={},"; stages "<>ToString[Tally[Lookup[Select[hb,AssociationQ],"stage","?"]]],""]]]]];
  pending];
(* 2 October 2026: at the deadline the busy workers are ENDED BY THEIR PROCESS IDS at once, with every process they started
   (race candidates, integrator shells).  AbortKernels[] waits for every kernel to acknowledge the abort; a sealed-lane
   worker inside MBtoEuler swallowed the abort and went on, and the master stood blocked for hours (MB8au residue 43 piece
   79, regression of 1 October).  Everything a worker has finished is already in its r_ files.  Only a worker whose
   process id is unknown takes the old path (abort, poll, give up). *)
killTree[pid_Integer]:=Quiet@RunProcess[{"bash","-c","q="<>ToString[pid]<>"; all=$q; while [ -n \"$q\" ]; do c=$(for x in $q; do pgrep -P $x; done); all=\"$all $c\"; q=$c; done; kill -9 $all 2>/dev/null"}];
stopWorkers[pending_List,ks_List,pids_List,label_String]:=If[pending=!={},
  Module[{known={},unknown={}},
    Do[With[{pos=Position[ks,k]},If[pos=!={}&&IntegerQ[pids[[pos[[1,1]]]]],AppendTo[known,pids[[pos[[1,1]]]]],AppendTo[unknown,k]]],{k,pending}];
    Print["    [",label,"] deadline: ",Length[pending]," worker(s) still busy -> processes ",known," ended",
      If[unknown=!={},"; "<>ToString[Length[unknown]]<>" without a process id -> aborted",""]];
    killTree/@known;
    If[unknown=!={},
      Quiet@AbortKernels[];Pause[3];
      Do[Module[{ok=False,t1=AbsoluteTime[]},
          Quiet@Parallel`Developer`ReceiveIfReady[k];
          Quiet@Parallel`Developer`Send[k,1];
          While[!ok&&AbsoluteTime[]-t1<15,Pause[0.5];ok=(Quiet@Parallel`Developer`ReceiveIfReady[k])===1]],{k,unknown}]];
    Pause[1]]];
ladderParallel[pcs_List,nW_Integer]:=Module[{job,n=Length[pcs],ks,got,cap,worker,res,t0=AbsoluteTime[],pids,pending,fails},
  job=FileNameJoin[{$TemporaryDirectory,"uint-ladder-"<>ToString[$ProcessID]<>"-"<>StringReplace[CreateUUID[],"-"->""]}];
  Quiet@CreateDirectory[job,CreateIntermediateDirectories->True];$ladderCurrentJob=job;
  Put[<|"pkgDir"->ParentDirectory[$closeLibDir],"libDir"->$closeLibDir,"Regulator"->ep,"nPieces"->n,"Seconds"->pieceLadderSeconds,
    "S2Seconds"->$s2PieceSeconds,"UnitSeconds"->$unitPieceSeconds,"PieceSeconds"->$pieceTotalSeconds|>,FileNameJoin[{job,"meta.m"}]];
  Do[Put[<|"F"->pcs[[k,1]],"Contour"->pcs[[k,2]]|>,FileNameJoin[{job,"p_"<>IntegerString[k,10,4]<>".m"}]],{k,n}];
  worker=FileNameJoin[{$closeLibDir,If[TrueQ[$useBnWorker],"uint_piece_worker_bn.m","uint_ladder_worker.m"]}];
  cap=Min[nW,n,If[DownValues[Global`mbtSubkernelCapDynamic]=!={},Max[1,Global`mbtSubkernelCapDynamic[]],nW]];
  Quiet@CloseKernels[];Quiet@Check[LaunchKernels[cap],Null];ks=Kernels[];got=Length[ks];
  Print["    [ladder-par] ",n," piece(s) on ",got," subkernel worker(s) (job ",FileNameTake[job],", stopped after ",$ladderJobSeconds," s without a new result)"];
  If[got==0,Return[ConstantArray[Missing["ladder"],n],Module]];
  pids=Quiet@Check[ParallelEvaluate[$ProcessID,ks],ConstantArray[None,got]];
  (* starting order of the workers: pieces of the same Gamma kernel and contour together (the derived HypExp blocks are
     banked per kernel session and reused), chunks of at most ceil(n/workers); every worker claims across the lists once
     its own is done *)
  Module[{key,groups,load=ConstantArray[0,got],assign=ConstantArray[{},got],w},
    key[k_]:=Module[{g=pcs[[k,1]]/.PolyGamma[__]->1},{Times@@Cases[If[Head[g]===Times,List@@g,{g}],Power[Gamma[_],_]|Gamma[_],{1}],pcs[[k,2]]}];
    groups=ReverseSortBy[GatherBy[Range[n],key],Length];
    groups=Join@@(Partition[#,UpTo[Max[1,Ceiling[n/got]]]]&/@groups);
    Do[w=First[Ordering[load,1]];assign[[w]]=Join[assign[[w]],gr];load[[w]]+=Length[gr],{gr,groups}];
    Do[Put[assign[[w]],FileNameJoin[{job,"assign_"<>ToString[w]<>".m"}]],{w,Length[assign]}];
    Print["    [ladder-par] ",Length[groups]," kernel groups over ",Length[assign]," workers (starting loads ",load,"; dynamic claiming)"]];
  With[{jr=job,nn=got},Quiet@ParallelEvaluate[(Global`$ladJobRoot=jr;Global`$ladLO=Automatic;Global`$ladStride=nn;),ks]];
  With[{w=worker},Do[Quiet@Parallel`Developer`Send[k,Quiet@Check[Get[w],$Failed]],{k,ks}]];
  pending=waitWorkers[ks,$ladderJobSeconds,"ladder-par",job,True];
  stopWorkers[pending,ks,pids,"ladder-par"];
  Quiet@CloseKernels[];
  res=Table[Module[{rf=FileNameJoin[{job,"r_"<>IntegerString[k,10,4]<>".m"}],r},
      r=If[FileExistsQ[rf],Quiet@Check[Get[rf],$Failed],$Failed];
      If[AssociationQ[r]&&r["status"]==="Clean"&&exactQ[r["value"]],r["value"],Missing["ladder"]]],{k,n}];
  fails=Select[Table[Module[{rf=FileNameJoin[{job,"r_"<>IntegerString[k,10,4]<>".m"}],r},
      r=If[FileExistsQ[rf],Quiet@Check[Get[rf],$Failed],$Failed];
      Which[
        AssociationQ[r]&&r["status"]=!="Clean",pcRefusePut[pcs[[k,1]],pcs[[k,2]],"refused: "<>ToString[Lookup[r,"reason","?"]]];{k,StringTake[ToString[Lookup[r,"reason","?"]],UpTo[160]]},
        (* a piece claimed by a worker that did not answer before the deadline: recorded as a deadline refusal
           (killed workers left no record and such pieces were retried in full) *)
        !FileExistsQ[rf]&&DirectoryQ[FileNameJoin[{job,"claim_"<>IntegerString[k,10,4]}]],pcRefusePut[pcs[[k,1]],pcs[[k,2]],"deadline: the pool produced no result for "<>ToString[$ladderJobSeconds]<>" s while this piece was open"];{k,"deadline"},
        True,Nothing]],{k,n}],ListQ];
  Print["    [ladder-par] ",Count[res,Except[_Missing]]," of ",n," closed in ",Round[AbsoluteTime[]-t0]," s",
    If[fails=!={},"; refused: "<>ToString[Length[fails]]<>" (first reasons: "<>ToString[Take[fails,UpTo[3]]]<>")",""],
    If[Count[res,_Missing]-Length[fails]>0,"; "<>ToString[Count[res,_Missing]-Length[fails]]<>" piece(s) without a result (deadline)",""]];
  If[FreeQ[res,_Missing],Quiet@DeleteDirectory[job,DeleteContents->True]];
  res];

(* HarmonicSums (loaded by the package closer) installs a catch-all DownValue on Series; MBexpand under it rewrites
   Gamma ratios such as Gamma[z]/Gamma[z-1] into polynomials at leading order, which hides the Barnes-lemma patterns
   from DoAllBarnes (measured: 34 pieces, 27 of them one-folds, vs 90 pieces with 2-/3-folds on MB8bu r11 term 2).
   The expansion and the Barnes step therefore run with the added Series definitions set aside (restored afterwards). *)
SetAttributes[withPlainSeries,HoldFirst];
(* a package loaded lazily inside expr may re-protect Series: unprotect again before restoring *)
withPlainSeries[expr_]:=Module[{dv=DownValues[Series],r},
  Internal`WithLocalSettings[Unprotect[Series];DownValues[Series]={},r=expr,Unprotect[Series];DownValues[Series]=dv;Protect[Series]];r];
(* CONTENT-ADDRESSED PIECE CACHE (2026-09-27): an eps-free piece int_ctr F has one exact value; every value closed by a
   worker or the engine is stored under the hash of {F, contour} (C/piece_cache/<hash>.m with its method and gate), and
   every later closure looks it up first -- a job killed by its time limit no longer loses its closed pieces.  Values
   imported from job directories of killed runs are gated by contour quadrature (1 and 2 folds) before storing; the
   term gates of closeTerm apply to every assembly as before. *)
If[!ValueQ[$pieceCacheDir],$pieceCacheDir=FileNameJoin[{$closeStateDir,"piece_cache"}]];
Quiet@CreateDirectory[$closeStateDir,CreateIntermediateDirectories->True];
Quiet@CreateDirectory[$pieceCacheDir];
pcKey[F_,ctr_]:=Hash[{F,Sort[ctr]},"SHA256","HexString"];
(* 2026-10-01 REFUSAL MEMORY (the MB8 family's two passes over item {43,3} re-ran every refused chain: 13771 s + 11187 s):
   a piece the worker chain refused is recorded with the chain version and the reasons; while the version is unchanged a
   later pass sends the piece straight to the lane/engine stages instead of running the chain again *)
If[!ValueQ[$pieceRefusalDir],$pieceRefusalDir=FileNameJoin[{$closeStateDir,"piece_refusals"}]];
Quiet@CreateDirectory[$pieceRefusalDir];
If[!ValueQ[$pieceChainVersion],$pieceChainVersion="2026-10-02e"];   (* 2 October: refusals recorded under the 900 s budget of the multi-fold closer, and deadline refusals of the fixed 3600 s pool deadline, are not reused *)
(* 2 October 2026: a refusal caused by a TIME LIMIT (a stage or a tower call aborted, a budget spent) says how loaded the
   machine was, not what the chain can do: MB14bu residue 28's slope-two piece closes in about 1100 s, was aborted in a
   helper process while the node was overloaded, and the memo then kept every other process from trying it (the family
   stayed open).  Such a record is honoured only by the process that wrote it; another process tries the piece again. *)
pcTimeRefusalQ[reason_]:=StringContainsQ[ToString[reason],"Aborted"|"time limit"|"budget spent"|"TimedOut"];
pcRefusedQ[F_,ctr_]:=Module[{f=FileNameJoin[{$pieceRefusalDir,pcKey[F,ctr]<>".m"}],r},
  If[!FileExistsQ[f],Return[False]];
  r=Quiet@Check[Get[f],$Failed];
  AssociationQ[r]&&Lookup[r,"Version",None]===$pieceChainVersion&&(!TrueQ[Lookup[r,"TimeLimited",False]]||Lookup[r,"PID",None]===$ProcessID)];
pcRefusePut[F_,ctr_,reason_]:=Module[{f=FileNameJoin[{$pieceRefusalDir,pcKey[F,ctr]<>".m"}]},
  Quiet@Put[<|"F"->F,"Contour"->ctr,"Version"->$pieceChainVersion,"Reason"->StringTake[ToString[reason],UpTo[1500]],
    "TimeLimited"->pcTimeRefusalQ[reason],"PID"->$ProcessID,"Date"->DateString["ISODateTime"]|>,f]];
pcGet[F_,ctr_]:=Module[{f=FileNameJoin[{$pieceCacheDir,pcKey[F,ctr]<>".m"}],r},
  If[!FileExistsQ[f],Return[Missing["cache"],Module]];
  r=Quiet@Check[Get[f],$Failed];
  If[AssociationQ[r]&&r["F"]===F&&Sort[r["Contour"]]===Sort[ctr]&&exactQ[r["Value"]],r["Value"],Missing["cache"]]];
pcPut[F_,ctr_,v_,method_,gate_]:=Module[{f=FileNameJoin[{$pieceCacheDir,pcKey[F,ctr]<>".m"}]},
  If[exactQ[v]&&!FileExistsQ[f],
    Put[<|"F"->F,"Contour"->Sort[ctr],"Value"->v,"Method"->method,"Gate"->gate,"Date"->DateString["ISODateTime"]|>,f<>".tmp"];
    Quiet@RenameFile[f<>".tmp",f,OverwriteTarget->True]]];
(* piece pairs (09-27): {F_i, contour_i, epsFac_i} -> None, or {F', contours', epsFacs', zero-fold constant} *)
piecePairNrm[f_]:=f/.{Power[b_,e_]/;!IntegerQ[e]:>Power[b,Expand[e]],Gamma[a_]:>Gamma[Expand[a]],PolyGamma[k_,a_]:>PolyGamma[k,Expand[a]]};
pieceResidues[F_,ctrA_List,ctrB_List]:=Catch[Module[{cur=ctrA,terms={},vs=Select[Keys[ctrA],(#/.ctrA)=!=(#/.ctrB)&]},
  Do[Module[{ca=v/.cur,cb=v/.ctrB,pl,crossed,sgn},
      pl=polesInV[F,cur,v,0];
      If[AnyTrue[pl,Abs[Re[#[[1]]]-ca]<10^-20||Abs[Re[#[[1]]]-cb]<10^-20&],Throw[$Failed,"pp"]];
      crossed=DeleteDuplicates[#[[2]]&/@Select[pl,Min[ca,cb]<Re[#[[1]]]<Max[ca,cb]&],Simplify[#1-#2]===0&];
      sgn=If[cb>ca,-1,1];
      Do[With[{rs=Together[sgn Residue[F,{v,p}]]},If[rs=!=0,AppendTo[terms,{rs,DeleteCases[cur,v->_]}]]],{p,crossed}];
      cur=cur/.(v->_):>(v->cb)],{v,vs}];
  terms],"pp"];
pairPiecesList[Fs_List,cs_List,es_List]:=Module[{n=Length[Fs],nf,used={},outF={},outC={},outE={},const=0},
  If[n<2,Return[None,Module]];
  nf=piecePairNrm/@Fs;
  Do[If[MemberQ[used,a]||MemberQ[used,b],Continue[]];
    If[Sort[Keys[cs[[a]]]]=!=Sort[Keys[cs[[b]]]]||Together[es[[a]]-es[[b]]]=!=0||Together[nf[[a]]+nf[[b]]]=!=0,Continue[]];
    Module[{rt=If[Sort[cs[[a]]]===Sort[cs[[b]]],{},pieceResidues[Fs[[a]],Normal[cs[[a]]],Normal[cs[[b]]]]]},
      If[rt===$Failed,Continue[]];
      used=Join[used,{a,b}];
      Print["    [pair] pieces ",a," and ",b," (",Length[cs[[a]]]," folds) paired: ",Length[rt]," crossed residue piece(s)"];
      Do[If[t[[2]]==={},const+=t[[1]] es[[a]],AppendTo[outF,t[[1]]];AppendTo[outC,t[[2]]];AppendTo[outE,es[[a]]]],{t,rt}]],
    {a,n},{b,a+1,n}];
  If[used==={},Return[None,Module]];
  With[{keep=Complement[Range[n],used]},{Join[Fs[[keep]],outF],Join[cs[[keep]],outC],Join[es[[keep]],outE],const}]];
(* 09-27 UNIT-SLOPE BASIS.  A unimodular change of the Mellin variables z = M y (integer M, det +-1) maps straight contours
   to straight contours (y = M^-1 c) with Jacobian one, so int_c F(z) = int_{M^-1 c} F(M y) exactly.  Among the bases made
   of the integrand's own linear forms (and the coordinate forms) the one with the smallest largest coefficient is taken;
   a slope-two leg that is an artefact of the variables disappears (MB14bu r29: in the basis {z611, z7, z7 + z8} the forms
   2 z7 + z8 and z7 + z8 are p + q and q), which the cube engine otherwise treats by squaring variables (quartic letters).
   usbTransform[F, ctr] -> <|"F","Contour","Vars","Basis","Max0","Max1"|>, or None (one fold, more than six folds,
   non-integer or nonlinear forms, no improvement of the largest coefficient). *)
usbForms[F_,vs_List]:=Module[{args,rat,h=F/.{Gamma[_]->1,PolyGamma[_,_]->1}},
  args=Join[Cases[F,Gamma[a_]:>a,{0,Infinity}],Cases[F,PolyGamma[_,a_]:>a,{0,Infinity}]];
  rat=Select[Join[FactorList[Numerator[Together[h]]],FactorList[Denominator[Together[h]]]][[All,1]],!FreeQ[#,Alternatives@@vs]&];
  Select[DeleteDuplicates[Expand/@Join[args,rat]],!FreeQ[#,Alternatives@@vs]&]];
usbTransform[F_,ctr0_List]:=Catch[Module[{ctr=Normal[ctr0],vs,n,forms,L,prim,pool,best=None,bestScore,score0,B,Binv,ys,rules,newC,better},
  vs=Keys[ctr];n=Length[vs];If[n<2||n>6,Throw[None,"usb"]];
  forms=usbForms[F,vs];
  If[AnyTrue[forms,!PolynomialQ[#,vs]||Max[Exponent[#,vs]]>1&],Throw[None,"usb"]];
  L=Table[Coefficient[f,v],{f,forms},{v,vs}];
  If[!MatrixQ[L,IntegerQ],Throw[None,"usb"]];
  score0={Max[Abs[L]],Total[Abs[Flatten[L]]]};
  If[score0[[1]]<=1,Throw[None,"usb"]];
  prim=DeleteDuplicates[Map[Function[w,With[{g=w/(GCD@@w)},If[First[Select[g,#!=0&]]<0,-g,g]]],DeleteCases[L,{0..}]]];
  pool=DeleteDuplicates[Join[prim,IdentityMatrix[n]]];
  If[Binomial[Length[pool],n]>200000,Throw[None,"usb"]];
  better[a_,b_]:=a[[1]]<b[[1]]||(a[[1]]==b[[1]]&&a[[2]]<b[[2]]);
  bestScore=score0;
  Do[If[Abs[Det[s]]==1,
      With[{tm=L.Inverse[s]},With[{sc={Max[Abs[tm]],Total[Abs[Flatten[tm]]]}},If[better[sc,bestScore],best=s;bestScore=sc]]]],
    {s,Subsets[pool,{n}]}];
  If[best===None||bestScore[[1]]>=score0[[1]],Throw[None,"usb"]];
  B=best;Binv=Inverse[B];
  ys=Table[With[{nm="Global`zu"<>ToString[j]},If[FreeQ[F,Symbol[nm]]&&FreeQ[vs,Symbol[nm]],Symbol[nm],Unique["Global`zu"]]],{j,n}];
  rules=Thread[vs->Binv.ys];
  newC=Thread[ys->B.(vs/.ctr)];
  <|"F"->((F/.rules)/.{Gamma[a_]:>Gamma[Expand[a]],PolyGamma[k_,a_]:>PolyGamma[k,Expand[a]]}),"Contour"->newC,"Vars"->ys,
    "Basis"->B,"Max0"->score0[[1]],"Max1"->bestScore[[1]]|>],"usb"];
(* 2026-09-28 SEALED LANE.  The development tree's piece engine
   regressed on classes the SEALED Standard release closes: on MB14bu r29 its 09-17 routes (unimodular alignment,
   slope-two Beta pairing and squaring) intercept the two-fold polygamma terms of the Barnes2Psi step before the class-C
   multiplication formula and refuse them, while the sealed worker closes the same three-fold pieces in minutes (values
   exactly equal to the Standard route's certified ones).  Every piece left open by the cache, the closed forms and the
   ladder therefore goes FIRST to the sealed release's worker (MB_standard/mbt_piece_worker.m with its own package,
   PolyLogTools and HyperFLINT; subkernels, time budget $sealedLaneSeconds); the caller gates its values like engine
   values.  Returns one entry per piece: an exact value or Missing[...]. *)
If[!ValueQ[$useSealedLane],$useSealedLane=True];
If[!ValueQ[$sealedLaneSeconds],$sealedLaneSeconds=1500];If[!ValueQ[$sealedLaneSecondsLast],$sealedLaneSecondsLast=4500];
If[!ValueQ[$sealedLaneWorkers],$sealedLaneWorkers=8];
(* the sealed lane = the release's piece worker: a sibling release tree MB_standard when this library lives in the
   development tree, the tree itself when it lives in the release (multifold_close/ under the release root); no
   absolute path (29 September 2026) *)
If[!ValueQ[$sealedLaneDir],$sealedLaneDir=With[{root=ParentDirectory[$closeLibDir]},
  If[FileExistsQ[FileNameJoin[{root,"mbt_piece_worker.m"}]]&&FileExistsQ[FileNameJoin[{root,"load_standard.m"}]]&&!FileExistsQ[FileNameJoin[{root,"load_standard_w10.m"}]],root<>"/",
    With[{sib=FileNameJoin[{ParentDirectory[root],"MB_standard"}]},If[FileExistsQ[FileNameJoin[{sib,"mbt_piece_worker.m"}]],sib<>"/",root<>"/"]]]]];
sealedLane[F_List,C_List,seconds_,nW0_]:=Module[{n=Length[F],jr,nW,ks,res,wf,t0,sc,cap},
  wf=FileNameJoin[{$sealedLaneDir,"mbt_piece_worker.m"}];
  If[n==0||!FileExistsQ[wf],Return[ConstantArray[Missing["sealed lane unavailable"],n],Module]];
  jr=FileNameJoin[{$TemporaryDirectory,"sealed-lane-"<>ToString[$ProcessID]<>"-"<>StringReplace[CreateUUID[],"-"->""]}];
  Quiet@CreateDirectory[jr,CreateIntermediateDirectories->True];
  Put[<|"pkgDir"->$sealedLaneDir,"pkgPath"->FileNameJoin[{$sealedLaneDir,"MB2MPL.m"}],
        "pltPath"->FileNameJoin[{Global`$PolyLogPath,"PolyLogTools.m"}],"nPieces"->n,"useCertifiedLibrary"->False|>,
      FileNameJoin[{jr,"meta.m"}]];
  Do[Put[<|"integEps1"->F[[k]],"vrs"->Keys[C[[k]]],"epsFac"->1,"ctr"->C[[k]]|>,FileNameJoin[{jr,"p_"<>IntegerString[k,10,4]<>".m"}]],{k,n}];
  cap=If[DownValues[Global`mbtSubkernelCapDynamic]=!={},Global`mbtSubkernelCapDynamic[],nW0];
  nW=Min[nW0,n,Max[0,cap]];
  If[nW<1,Print["    [sealed] no subkernel available: lane skipped"];Return[ConstantArray[Missing["sealed lane: no subkernel"],n],Module]];
  ks=Quiet@Check[LaunchKernels[nW],{}];
  If[!ListQ[ks]||ks==={},Print["    [sealed] no subkernel could be launched: lane skipped"];Return[ConstantArray[Missing["sealed lane: launch"],n],Module]];
  nW=Length[ks];
  (* per worker: 4 threads x 2 raced candidates when the node has room (as before for up to eight workers on an idle
     node); fewer threads when many subkernels run (this user's census, the new workers included), so that a wide lane
     does not oversubscribe the cores *)
  sc=Module[{tot=Max[nW,If[DownValues[Global`mbtMySubkernelCount]=!={},Global`mbtMySubkernelCount[],nW]],b,t},
    b=Max[1,Floor[Max[1,$ProcessorCount]/tot]];t=Which[b>=8,4,b>=4,2,True,1];
    {t,If[b>=2 t,2,1],Min[1200,Max[300,Round[seconds/2]]]}];
  Print["    [sealed] ",n," piece(s) to the sealed release's worker on ",nW," subkernel(s), budget ",seconds," s (job ",FileNameTake[jr],")"];
  Do[With[{kk=i,kern=ks[[i]],j=jr,nn=nW,s=sc},
      Quiet@ParallelEvaluate[(Global`$mbtWorkerJobRoot=j;Global`$mbtWorkerLO=kk;Global`$mbtWorkerStride=nn;Global`$mbtIVFScaling=s;Global`$mbtNestedInWorker=True;
        Global`$IV$NoLibrary=True;),kern]],{i,nW}];
  t0=AbsoluteTime[];
  (* 2026-10-01: the budget is ENFORCED (polled wait, abort, PID): TimeConstrained around ParallelEvaluate let a worker
     blocked in MBtoEuler's Block 5 run 2.5 h past a 2400 s budget (MB8au r43 piece 11) *)
  Module[{pids=Quiet@Check[ParallelEvaluate[$ProcessID,ks],ConstantArray[None,Length[ks]]],pending},
    With[{w=wf},Do[Quiet@Parallel`Developer`Send[k,Quiet@Check[Get[w],$Failed]],{k,ks}]];
    (* the budget is a stall limit: the clock restarts at every new result, so a lane with more pieces than workers is
       not cut off while it makes progress (one piece on one worker: the budget as before) *)
    pending=waitWorkers[ks,seconds,"sealed",jr,True];
    stopWorkers[pending,ks,pids,"sealed"]];
  Quiet@CloseKernels[ks];
  res=Table[Module[{rf=FileNameJoin[{jr,"r_"<>IntegerString[k,10,4]<>".m"}],r1},
      r1=If[FileExistsQ[rf],Quiet@Check[Get[rf],$Failed],$Failed];
      If[AssociationQ[r1]&&r1["status"]==="Clean"&&exactQ[r1["value"]],r1["value"],Missing["sealed lane: open"]]],{k,n}];
  Print["    [sealed] ",Count[res,Except[_Missing]]," of ",n," piece(s) closed by the sealed release's worker in ",Round[AbsoluteTime[]-t0]," s"];
  res];
depthBeyondQ[f_,dd_]:=Module[{ff=Factor[f],k},k=Exponent[ff,ep,Min];IntegerQ[k]&&k>dd&&FreeQ[Together[ff/ep^k],ep]];
stdRoutePar[g_,ctr_,dd_]:=Module[{doAB,exp2,barnes2,mbConst,mbConstVal,mbList2,integrand2,contours2,vars2,epsFac2,integEps12,mbEva,total},
  $sealedRefused=<||>;
  MBtoMPL`Private`mbeLoadHarmonicSums[];MBtoMPL`Private`mbeRebindHSTables[];
  doAB=Which[DownValues[BarnesRoutines`DoAllBarnes]=!={},BarnesRoutines`DoAllBarnes,DownValues[Global`DoAllBarnes]=!={},Global`DoAllBarnes,True,None];
  If[doAB===None,Return[$Failed,Module]];
  exp2=withPlainSeries[Symbol["MB`MBexpand"][{MBint[g,{{ep->0},ctr}]},1,{ep,0,dd}]];
  barnes2=withPlainSeries[Quiet@doAB[exp2,True]];
  mbConst=Symbol["MB`MBmerge"][Select[barnes2,(#[[2,2]]=={})&]];
  mbConstVal=If[Length[mbConst]>0,mbConst[[1,1]]//ExpandAll,0];
  mbList2=Select[barnes2,(#[[2,2]]=!={})&];
  integrand2=#[[1]]&/@mbList2;contours2=#[[2,2]]&/@mbList2;vars2=Keys@#&/@contours2;
  epsFac2=If[mbList2==={},{},#/(#/.{ep->1})&/@integrand2];
  integEps12=If[mbList2==={},{},integrand2/.{ep->1}];
  (* 09-27 PIECE PAIRS: eps-free pieces with the same eps factor and opposite integrands, on contours that differ in some
     variables, are replaced by the residues crossed between the lines (exact, no eps: the identity holds as it stands);
     nothing when no pole lies between them.  A pole on a line refuses that pair.  Zero-fold residues join the constant. *)
  Module[{pp=pairPiecesList[integEps12,contours2,epsFac2]},
    If[pp=!=None,
      integEps12=pp[[1]];contours2=pp[[2]];epsFac2=pp[[3]];vars2=Keys/@contours2;mbConstVal+=pp[[4]]]];
  Print["    [par] ",Length[exp2]," expanded, ",Length[barnes2]," after Barnes, ",Length[integEps12]," MB pieces, folds ",Tally[Length/@vars2]];
  (* one-fold pieces: the tower ladder of the theory (exact, seconds; ~90% of the pieces), each gated by a 1-dim quadrature;
     a one-fold piece the ladder refuses or that fails its gate, and every multi-fold piece: the package piece engine,
     on subkernel workers *)
  Module[{vals=ConstantArray[Missing[],Length[integEps12]],rest,t1=AbsoluteTime[],one,nCache,origF,origC,laneStage,gleLevel,withdraw,laneFirstQ,desc=<||>,gleTried={}},
    (* the piece cache first *)
    vals=Table[pcGet[integEps12[[ii]],contours2[[ii]]],{ii,Length[integEps12]}];
    nCache=Count[vals,Except[_Missing]];
    If[nCache>0,Print["    [cache] ",nCache," of ",Length[vals]," pieces from the piece cache"]];
    (* 2026-09-28 DEPTH SKIP: the routine returns the Taylor coefficients 0..dd only (last line), so a piece whose eps factor
       is c eps^k with k > dd cannot contribute; it is not closed (0 in the total, never cached).  Exact; e.g. MB8bu r21's
       psi-dressed three-folds with factor eps at depth 0. *)
    Module[{skip=Select[Range[Length[integEps12]],MissingQ[vals[[#]]]&&depthBeyondQ[epsFac2[[#]],dd]&]},
      If[skip=!={},vals[[skip]]=0;
        Print["    [depth] ",Length[skip]," piece(s) carry eps^k with k > ",dd,": not needed for the Taylor coefficients through ",dd," (not closed)"]]];
    (* 09-27 18:00 CROSS-RESIDUE PIECE PAIRS (C/piece_pairs.m, written by a checked pair tool): the same eps-free piece
       with the same eps factor and opposite term prefactors in two residues, no pole between the two contours -- the two
       contributions cancel in the family sum and are omitted in BOTH residues (value 0, never cached, logged in
       $xpieceLog and in the record) *)
    Module[{pf=FileNameJoin[{$closeLibDir,"piece_pairs.m"}],pairs,keys},
      pairs=If[FileExistsQ[pf],Quiet@Check[Get[pf],{}],{}];
      keys=If[ListQ[pairs],Flatten[Lookup[#,"Members",{}][[All,"Key"]]&/@pairs],{}];
      Do[If[MissingQ[vals[[ii]]]&&MemberQ[keys,pcKey[integEps12[[ii]],contours2[[ii]]]],
          With[{pr=SelectFirst[pairs,MemberQ[#["Members"][[All,"Key"]],pcKey[integEps12[[ii]],contours2[[ii]]]]&]},
            vals[[ii]]=0;
            If[!ValueQ[$xpieceTermOmit],$xpieceTermOmit={}];
            AppendTo[$xpieceTermOmit,<|"EpsFac"->epsFac2[[ii]],"Quad"->quad[integEps12[[ii]],contours2[[ii]]]|>];
            If[!ValueQ[$xpieceLog],$xpieceLog={}];
            AppendTo[$xpieceLog,<|"Pair"->pr["Pair"],"Key"->pcKey[integEps12[[ii]],contours2[[ii]]],"Contour"->contours2[[ii]]|>];
            Print["    [xpiece] piece ",ii," (",Length[vars2[[ii]]]," folds) is one member of the cross-residue pair \"",pr["Pair"],
              "\": omitted here and in its partner (exact in the family sum)"]]],
        {ii,Length[integEps12]}]];
    (* 09-27 unit-slope basis for the open multi-fold pieces (exact, Jacobian one); the cache keeps the original keys *)
    origF=integEps12;origC=contours2;
    Do[If[MissingQ[vals[[ii]]]&&Length[vars2[[ii]]]>=2,
        With[{t=Quiet@usbTransform[integEps12[[ii]],contours2[[ii]]]},
          If[AssociationQ[t],
            Print["    [usb] piece ",ii," (",Length[vars2[[ii]]]," folds): unimodular change of variables, largest coefficient ",
              t["Max0"]," -> ",t["Max1"]," (basis ",InputForm[t["Basis"]],")"];
            integEps12[[ii]]=t["F"];contours2[[ii]]=t["Contour"];vars2[[ii]]=t["Vars"]]]],
      {ii,Length[integEps12]}];
    (* with the bn worker every piece (one-fold: Barnes 2+2 then ladder; multi-fold: iterated Barnes 2+2) goes to the
       subkernel workers first; without it only the one-folds (ladder) *)
    one=If[TrueQ[$useBnWorker],Range[Length[vars2]],Flatten[Position[vars2,v_/;Length[v]==1,{1},Heads->False]]];
    one=Select[one,MissingQ[vals[[#]]]&];
    Module[{ref=Select[one,pcRefusedQ[integEps12[[#]],contours2[[#]]]&]},
      If[ref=!={},Print["    [refusals] ",Length[ref]," piece(s) refused by this chain version earlier: not retried, straight to the lane/engine stages"];
        one=Complement[one,ref]]];
    If[Length[one]>=parMin,
      vals[[one]]=ladderParallel[Transpose[{integEps12[[one]],contours2[[one]]}],parWorkers],
      Do[If[Length[vars2[[ii]]]>=2,
          With[{b=Quiet@bnGated[integEps12[[ii]],contours2[[ii]],pieceLadderSeconds]},If[AssociationQ[b]&&exactQ[b["Value"]],vals[[ii]]=Global`mbeCanonicalConstants[b["Value"]]]],
          Module[{b=Quiet@b22Gated[integEps12[[ii]],contours2[[ii]],120],fam},
            If[!AssociationQ[b]&&DownValues[bgGated]=!={},b=Quiet@bgGated[integEps12[[ii]],contours2[[ii]],300]];
            (* 09-27 11:16: slope-two pieces through the slope-two closer before the ladder *)
            If[!AssociationQ[b]&&DownValues[s2PieceGated]=!={}&&TrueQ[s2PieceSlope2Q[integEps12[[ii]],contours2[[ii]]]],b=Quiet@s2PieceGated[integEps12[[ii]],contours2[[ii]],2400]];
            If[AssociationQ[b]&&exactQ[b["Value"]],vals[[ii]]=Global`mbeCanonicalConstants[b["Value"]],
              fam=Quiet@TimeConstrained[MBtoMPL`Private`mbeOneFoldFamilyLaurent[{MBint[integEps12[[ii]],{{ep->0},contours2[[ii]]}]},ep,0,0,False],pieceLadderSeconds,$Aborted];
              (* the ladder value is gated like the closed forms (it can be wrong: slope-two numerator kernels) *)
              If[ListQ[fam]&&Length[fam]==1&&exactQ[fam],
                With[{q=quad[integEps12[[ii]],contours2[[ii]]]},
                  If[TrueQ[NumericQ[q]&&Abs[N[fam[[1]],30]-q]<10^-10 Max[1,Abs[q]]],vals[[ii]]=Global`mbeCanonicalConstants[fam[[1]]],
                    Print["    [ladder] PIECE GATE FAIL: ladder ",N[fam[[1]],12]," vs quadrature ",N[q,12]," -> refused"]]]];
              (* 09-27 13:00: an eps-free unit-slope one-fold the ladder did not close (divergent residue sums: trig kernels
                 with polygamma products, MB8au r12 p3): Gamma copies + Mellin tower at a scale + the limit Y -> 1, gated *)
              If[MissingQ[vals[[ii]]]&&DownValues[s2UnitPieceGated]=!={}&&FreeQ[integEps12[[ii]],ep]&&Length[contours2[[ii]]]==1,
                With[{u=Quiet@s2UnitPieceGated[integEps12[[ii]],Normal[contours2[[ii]]],1800]},
                  If[AssociationQ[u]&&exactQ[u["Value"]],vals[[ii]]=Global`mbeCanonicalConstants[u["Value"]]]]]]]],{ii,one}]];
    (* 2026-09-27 10:20: only GATED values enter the cache: every one-fold value is gated (closed forms and ladder, in the
       worker or above), two-fold values by the bn worker's quadrature; 3+ fold values are used by this term (its I_0/I_1
       gates arbitrate) but not cached *)
    Do[If[!MissingQ[vals[[ii]]]&&Length[vars2[[ii]]]<=2,pcPut[origF[[ii]],origC[[ii]],vals[[ii]],"worker (closed form / ladder, gated)","worker"]],{ii,one}];
    rest=Flatten[Position[vals,_Missing,{1},Heads->False]];
    Print["    [ladder] ",Length[one]-Count[vals[[one]],_Missing]," of ",Length[one]," pieces closed by the closed forms/towers in ",Round[AbsoluteTime[]-t1]," s; ",Length[rest]," pieces to the engine"];
    (* the sealed-lane stage on a list of pieces (2026-09-28: the ORIGINAL pieces go to the sealed release's worker with a
       time budget; its values are gated like engine values: 1-2 folds by quadrature and cached, 3+ folds used but not
       cached, the term gates arbitrate) *)
    laneStage[idx_List,nLane_:Automatic]:=If[idx=!={}&&TrueQ[$useSealedLane]&&DownValues[sealedLane]=!={},
      (* 2 October 2026: a LAST-RESORT lane call (one or two pieces, all of two or more folds: what no rewrite and no
         pool took) gets the longer stall limit $sealedLaneSecondsLast: the two-fold of MB8bu residue 21 that only the lane
         closes took 923 s on a quiet node, and the family stays open if a loaded node pushes it past the 1500 s of the
         ordinary lane calls *)
      Module[{sv=Quiet@sealedLane[origF[[idx]],origC[[idx]],
          If[Length[idx]<=2&&AllTrue[idx,Length[vars2[[#]]]>=2&],Max[$sealedLaneSeconds,$sealedLaneSecondsLast],$sealedLaneSeconds],
          If[IntegerQ[nLane],nLane,$sealedLaneWorkers]]},
        If[ListQ[sv]&&Length[sv]==Length[idx],
          Do[Module[{ii=idx[[j]],v=sv[[j]],nf,q,ok},
              If[exactQ[v],
                nf=Length[vars2[[ii]]];
                If[nf<=2,
                  {ok,q}=pieceGateQ[v,origF[[ii]],origC[[ii]],nf];
                  If[ok,vals[[ii]]=Global`mbeCanonicalConstants[v];
                    pcPut[origF[[ii]],origC[[ii]],v,"sealed-lane worker (gated)",ToString[N[q,15],InputForm]],
                    $sealedRefused[ii]=v;
                    Print["    [sealed] PIECE GATE FAIL (",nf," folds): sealed lane ",N[v,12]," vs quadrature ",N[q,12]," -> refused (kept for the two-construction test)"]],
                  vals[[ii]]=Global`mbeCanonicalConstants[v]]]],{j,Length[idx]}]]]];
    (* 2 October 2026: THE GENERALIZED-LEMMA REWRITE (uint_gle.m; subtraction_syed.tex, sec:pinched-gle).  An open
       multi-fold piece with a fold variable in the rung's class (three legs against two over one, integer defect:
       terminating, or pinched once with a tail; polygammas as spectators or by a balanced copy) is reduced by ONE fold with
       the regulated generalized Barnes lemma: the regulator-free part becomes pieces with one fold fewer, appended to the
       piece list with the parent's eps factor, the tail (if any) an exact constant (dressed cube), which becomes the
       parent's entry.  The fold identity is gated at a complex spectator point, every lower-fold piece by its own
       quadrature, and the term gates arbitrate the whole.
       withdraw: the pieces a rewrite appended (and theirs) leave the sum (value and eps factor 0; the closed ones stay in
       the piece cache).
       gleLevel[parents, depth]: the open multi-fold pieces of one level together.  Round k: the k-th rewrite of every
       pending parent (the rung's order: fewest lower-fold pieces first); all their pieces at once: piece cache, ONE worker
       pool, then the pieces of two or more folds that are still open are rewritten in turn (the next level: their own
       lower-fold pieces close in the pool in seconds, where the lane's cube constructions on a polygamma-dressed two-fold
       take tens of minutes), then ONE lane call for what no rewrite took.  A parent whose pieces all closed is closed (its
       entry = the tail constant); the pieces of the others are withdrawn and the next rewrite is asked for. *)
    withdraw[ii_]:=Do[withdraw[jj];vals[[jj]]=0;epsFac2[[jj]]=0,{jj,Lookup[desc,ii,{}]}];
    (* one-fold pieces that go to the lane BEFORE the pool: those with polygammas of non-unit slope OUTSIDE the jet rung's
       class.  The jet rung closes a monomial of weight <= 3 in the polygammas of ONE slope >= 2 argument (psi, psi',
       psi^2, ... by the Beta-kernel moments, with unit-slope polygammas next to it; minutes per piece).  Other dressings
       (two different slope >= 2 arguments, weight >= 4) are refused by the one-fold chain only after its stage budgets,
       and the lane's cube constructions close many of them.  What the lane leaves open still gets the pool. *)
    laneFirstQ[f_,c_]:=Length[c]==1&&Module[{z=Keys[c][[1]],fs,s2},
      If[FreeQ[f,PolyGamma[_,a_]/;Abs[Coefficient[a,z]]>=2],Return[False,Module]];
      If[Head[f]===Plus,Return[True,Module]];
      fs=If[Head[f]===Times,List@@f,{f}];
      s2=Join[Cases[fs,PolyGamma[m_,a_]/;Abs[Coefficient[a,z]]>=2:>{m,Expand[a],1}],
        Cases[fs,Power[PolyGamma[m_,a_],p_Integer?Positive]/;Abs[Coefficient[a,z]]>=2:>{m,Expand[a],p}]];
      If[s2==={},Return[True,Module]];
      (* (a lane-first rule for kernels with coincident up/down poles on both sides of the contour was tried on 2 October
         and dropped: of 82 such pieces of MB8bu residue 21 the pool closes 70 with a median of two minutes; the pieces
         that spent their budget there are closed by the chain's reserve for the exact rewrites) *)
      !(Length[DeleteDuplicates[s2[[All,2]]]]==1&&Total[(#[[1]]+1) #[[3]]&/@s2]<=3)];
    gleLevel[parents_List,depth_]:=Module[{pending=parents,round=0,rws,newAll,go,sub,open},
      While[pending=!={}&&round<$gleMaxRewrites,round++;
        rws=<||>;newAll={};
        Do[Module[{rw=Quiet@TimeConstrained[gleRewritePiece[integEps12[[ii]],contours2[[ii]],round],$gleRewriteSeconds,Failure["GLE",<|"Reason"->"time limit"|>]],n0=Length[integEps12],k},
            If[!(AssociationQ[rw]&&ListQ[rw["Pieces"]]&&exactQ[rw["Constant"]]),
              Print["    [gle] piece ",ii," (",Length[vars2[[ii]]]," folds): no ",If[round>1,"further ",""],"rewrite (",If[FailureQ[rw],StringTake[ToString[rw["Reason"]],UpTo[300]],"?"],")"],
              k=Length[rw["Pieces"]];
              Print["    [gle] piece ",ii," (",Length[vars2[[ii]]]," folds), rewrite ",round,": ",rw["Info"]["Note"],", kernels (defect, pinch, tail) ",rw["Info"]["Kernels"],
                " -> ",k," piece(s) (",Count[rw["Contours"],c_/;Length[c]<Length[vars2[[ii]]]]," with one fold fewer), tail constant ",N[rw["Constant"],14]];
              integEps12=Join[integEps12,rw["Pieces"]];contours2=Join[contours2,rw["Contours"]];vars2=Join[vars2,Keys/@rw["Contours"]];
              epsFac2=Join[epsFac2,ConstantArray[epsFac2[[ii]],k]];origF=Join[origF,rw["Pieces"]];origC=Join[origC,rw["Contours"]];
              vals=Join[vals,Table[pcGet[rw["Pieces"][[j]],rw["Contours"][[j]]],{j,k}]];
              desc[ii]=Range[n0+1,n0+k];rws[ii]=rw;newAll=Join[newAll,desc[ii]]]],{ii,pending}];
        pending=Keys[rws];
        If[pending==={},Break[]];
        newAll=Select[newAll,MissingQ[vals[[#]]]&];
        go=Select[newAll,!pcRefusedQ[integEps12[[#]],contours2[[#]]]&&!laneFirstQ[integEps12[[#]],contours2[[#]]]&];
        If[Length[go]<Length[newAll],Print["    [gle] ",Length[newAll]-Length[go]," of ",Length[newAll]," new piece(s) go to the lane first (refused by the pool earlier, or polygammas of non-unit slope outside the jet rung's class)"]];
        If[go=!={},
          vals[[go]]=ladderParallel[Transpose[{integEps12[[go]],contours2[[go]]}],parWorkers];
          Do[If[!MissingQ[vals[[jj]]]&&Length[vars2[[jj]]]<=2,pcPut[origF[[jj]],origC[[jj]],vals[[jj]],"worker (closed form / ladder, gated)","worker"]],{jj,go}]];
        sub=Select[newAll,MissingQ[vals[[#]]]&&Length[vars2[[#]]]>=2&];
        If[sub=!={}&&depth<$gleMaxDepth,gleLevel[sub,depth+1]];
        open=Select[newAll,MissingQ[vals[[#]]]&];
        (* the lane for what the pool and the next level left open: one lane worker per piece, up to the pool size.  (A
           lane worker used to start main-kernel processes for the sub-pieces of its piece, and such lanes exhausted the
           main-kernel licence on 2 October; since the launcher closes nested requests inside the worker, a lane worker
           is one subkernel.)  The lane closes the one-folds with powers of slope-two polygammas that the one-fold
           chain refuses, at a few minutes each. *)
        laneStage[open,Max[$sealedLaneWorkers,Min[Length[open],parWorkers]]];
        (* the pool for the lane-first pieces the lane left open *)
        With[{still=Select[open,MissingQ[vals[[#]]]&&laneFirstQ[integEps12[[#]],contours2[[#]]]&&!pcRefusedQ[integEps12[[#]],contours2[[#]]]&]},
          If[still=!={},
            vals[[still]]=ladderParallel[Transpose[{integEps12[[still]],contours2[[still]]}],parWorkers];
            Do[If[!MissingQ[vals[[jj]]]&&Length[vars2[[jj]]]<=2,pcPut[origF[[jj]],origC[[jj]],vals[[jj]],"worker (closed form / ladder, gated)","worker"]],{jj,still}]]];
        pending=Select[pending,Function[ii,
          If[NoneTrue[desc[ii],MissingQ[vals[[#]]]&],
            vals[[ii]]=rws[ii]["Constant"];
            Print["    [gle] piece ",ii,": closed by rewrite ",round," (",Length[desc[ii]]," piece(s) closed)"];False,
            Print["    [gle] piece ",ii,": ",Count[desc[ii],_?(MissingQ[vals[[#]]]&)]," of ",Length[desc[ii]]," piece(s) of rewrite ",round," stayed open -> withdrawn"];
            withdraw[ii];desc[ii]={};True]]]]];
    (* FIRST, before the lane: the pure-Gamma pieces of three or more folds the pool refused, and (4 October 2026) those
       with one first-order polygamma of a first-lemma fold variable (gleCopyFirstLemma; the lane has no closure for the
       three-fold of MB11's kernel residue 18 and spent 933 s refusing it).  The lane has no closure for a
       pinched pure-Gamma three-fold (MB8bu residue 21: it fails after 13 minutes), and of all the pool-refused pieces of the
       MB13, MB14 and MB8 families (refusal memos of 1-2 October) only those of residue 21 have a fold in the rung's class,
       so nothing changes for the pieces the lane closes; a piece without a rewrite goes on to the lane as before. *)
    If[rest=!={}&&TrueQ[$useGleRewrite]&&DownValues[gleRewritePiece]=!={},
      With[{pre=Select[rest,Length[vars2[[#]]]>=3&&(FreeQ[integEps12[[#]],PolyGamma]||(DownValues[gleCopyFirstLemmaQ]=!={}&&TrueQ[Quiet@gleCopyFirstLemmaQ[integEps12[[#]],contours2[[#]]]]))&],t2=AbsoluteTime[]},
        If[pre=!={},
          gleLevel[pre,1];gleTried=pre;
          rest=Flatten[Position[vals,_Missing,{1},Heads->False]];
          Print["    [gle] rewrite stage (pure-Gamma pieces of three or more folds, before the lane): ",Round[AbsoluteTime[]-t2]," s; ",Length[rest]," piece(s) open"]]]];
    (* 2026-09-29 08:5x: with $closeDeferEngine the sealed lane and the development engine are NOT entered; the closer
       refuses with the reason "deferred" so that the caller can try a cheaper exact move first (the handler's
       Mellin-Parseval decoupling of two-folds) and come back for the engine stages; the pieces already closed above are
       in the piece cache and are not recomputed *)
    If[rest=!={}&&TrueQ[$closeDeferEngine],
      Print["    [ladder] engine stages deferred ($closeDeferEngine): ",Length[rest]," piece(s) open"];
      Throw[Failure["Closer",<|"Reason"->"deferred: "<>ToString[Length[rest]]<>" piece(s) need the sealed lane/engine"|>],"deferEngine"]];
    (* 2026-09-28 SEALED LANE FIRST (see sealedLane below); only what it leaves open reaches the development engine *)
    If[rest=!={}&&TrueQ[$useSealedLane]&&DownValues[sealedLane]=!={},
      laneStage[rest];
      rest=Select[rest,MissingQ[vals[[#]]]&];
      Print["    [sealed] ",Length[rest]," piece(s) left for the development engine"]];
    (* AFTER the lane: every other multi-fold piece it left open (no such piece in the MB13 and MB14 families) *)
    If[rest=!={}&&TrueQ[$useGleRewrite]&&DownValues[gleRewritePiece]=!={},
      With[{cand=Select[Complement[rest,gleTried],Length[vars2[[#]]]>=2&],t2=AbsoluteTime[]},
        If[cand=!={},
          gleLevel[cand,1];
          rest=Flatten[Position[vals,_Missing,{1},Heads->False]];
          Print["    [gle] rewrite stage (after the lane): ",Round[AbsoluteTime[]-t2]," s; ",Length[rest]," piece(s) left for the development engine"]]]];
    If[rest=!={},
      vals[[rest]]=If[Length[rest]>=parMin,
        MBtoMPL`Private`mbtClosePiecesParallel[integEps12[[rest]],contours2[[rest]],vars2[[rest]],epsFac2[[rest]],parWorkers],
        Table[MBtoMPL`Private`mbtCachedMB2MPL[integEps12[[ii]],contours2[[ii]],vars2[[ii]]],{ii,rest}]];
      (* 2026-09-27: the engine writes wrong "clean" values on some classes (false zeros and wrong numbers seen on MB8au
         r24/r43, caught by the import gates): every engine value of one or two folds is gated by quadrature here; a
         failed gate makes the piece Missing (the term refuses instead of absorbing a wrong value); only gated values
         are cached, 3+ fold engine values are used but not cached *)
      Do[Module[{v=vals[[ii]],nf=Length[vars2[[ii]]],q,ok},
          If[!exactQ[v],Continue[]];
          If[nf<=2,
            {ok,q}=pieceGateQ[v,integEps12[[ii]],contours2[[ii]],nf];
            (* two structurally different constructions (the sealed release's worker and the development engine) that agree
               EXACTLY are accepted when the quadratures are inconclusive; the term gates I_0, I_1 arbitrate *)
            (* 2026-10-01: the two-construction rule needs EXACT agreement (a 30-digit numerical agreement is
               not exactness) and two genuinely different constructions: in the release layout the sealed lane is the
               release's own engine, so the rule is off there *)
            If[!ok&&KeyExistsQ[$sealedRefused,ii]&&!TrueQ[Global`$mfhReleaseLayoutQ]&&TrueQ[Quiet@TimeConstrained[PossibleZeroQ[Simplify[v-$sealedRefused[ii]]],60,False]],
              ok=True;Print["    [engine] two constructions agree exactly (sealed lane = engine, ",N[v,12],") though the quadrature gate is inconclusive: accepted (two-construction rule)"]];
            If[ok,pcPut[origF[[ii]],origC[[ii]],v,If[NumericQ[q]&&Abs[N[v,30]-q]<10^-5 Max[1,Abs[q]],"package engine (gated)","sealed lane = engine (two constructions)"],ToString[N[q,15],InputForm]],
              Print["    [engine] PIECE GATE FAIL (",nf," folds): engine ",N[v,12]," vs quadrature ",N[q,12]," -> refused"];vals[[ii]]=Missing["engine gate"]]]],
        {ii,rest}];
      (* 09-27 13:08: every piece left open is saved with its quadrature (C/open_pieces/<key>.m) for the class census *)
      Do[If[MissingQ[vals[[ii]]],Module[{od=FileNameJoin[{$closeStateDir,"open_pieces"}],fn},
          Quiet@CreateDirectory[od];fn=FileNameJoin[{od,pcKey[origF[[ii]],origC[[ii]]]<>".m"}];
          If[!FileExistsQ[fn],Quiet@Put[<|"F"->origF[[ii]],"Contour"->origC[[ii]],"Folds"->Length[vars2[[ii]]],"Date"->DateString["ISODateTime"]|>,fn]];
          Print["    [piece] left open (",Length[vars2[[ii]]]," folds): saved ",FileNameTake[fn]]]],{ii,rest}]];
    mbEva=vals];
  total=mbConstVal+If[mbEva==={},0,mbEva.epsFac2];
  Table[Coefficient[Quiet@Normal@Series[total,{ep,0,dd}],ep,k],{k,0,dd}]];
(* 2026-09-29: the two-dimensional GlobalAdaptive rule of quad is not reliable on every two-fold piece (MB13u r13:
   two pieces on which the sealed lane and the dev engine agree exactly, and the engine's own quadrature agrees to 1e-5, were
   REFUSED by a quad value 0.6% off with an imaginary part 4e-4).  A failed two-fold gate is therefore re-checked by iterated
   one-dimensional DoubleExponential quadratures before a value is refused, and two independent constructions that agree
   exactly (sealed lane = engine) are accepted when the quadratures stay inconclusive (the term gates I_0, I_1 arbitrate). *)
quadIter[g_,ctr_]:=Module[{vs=Keys[ctr],ts,ig,L=30},
  If[Length[vs]=!=2,Return[quad[g,ctr]]];
  ts=Table[Unique["Global`gt"],{2}];ig=g/.Thread[vs->(Values[ctr]+I ts)];
  Quiet@NIntegrate[NIntegrate[ig,Evaluate[{ts[[2]],-L,L}],WorkingPrecision->20,PrecisionGoal->8,MaxRecursion->30,
      Method->{"GlobalAdaptive","SingularityHandler"->"DoubleExponential","MaxErrorIncreases"->2000}],
    Evaluate[{ts[[1]],-L,L}],WorkingPrecision->20,PrecisionGoal->8,MaxRecursion->30,
    Method->{"GlobalAdaptive","SingularityHandler"->"DoubleExponential","MaxErrorIncreases"->2000}]/(2 Pi)^2];
pieceGateQ[v_,F_,ctr_,nf_]:=Module[{q=quad[F,ctr],ok,q2},
  ok=TrueQ[NumericQ[q]&&Abs[N[v,30]-q]<If[nf==1,10^-10,10^-5] Max[1,Abs[q]]];
  If[!ok&&nf==2,q2=quadIter[F,ctr];
    If[TrueQ[NumericQ[q2]&&Abs[N[v,30]-q2]<10^-5 Max[1,Abs[q2]]],ok=True;q=q2;Print["    [gate] two-fold piece accepted by the iterated quadrature (",N[q2,12],"; the 2-dim rule gave ",N[q,12],")"]]];
  {ok,q}];
quad[g_,ctr_]:=Module[{vs=Keys[ctr],ts,ig,L},
  ts=Table[Unique["Global`gt"],{Length[vs]}];L=Switch[Length[vs],1,60,2,30,_,18];
  ig=g/.Thread[vs->(Values[ctr]+I ts)];
  Quiet@Which[
    Length[vs]==0,N[g,20],
    Length[vs]==1,NIntegrate[ig,Evaluate[{ts[[1]],-L,L}],WorkingPrecision->25,PrecisionGoal->12,MaxRecursion->30]/(2 Pi),
    Length[vs]==2,NIntegrate[ig,Evaluate[Sequence@@({#,-L,L}&/@ts)],PrecisionGoal->6,MaxRecursion->16,MaxPoints->2*10^6]/(2 Pi)^2,
    True,NIntegrate[ig,Evaluate[Sequence@@({#,-L,L}&/@ts)],PrecisionGoal->5,MaxRecursion->12,MaxPoints->8*10^6,
      Method->{"GlobalAdaptive","MaxErrorIncreases"->4000}]/(2 Pi)^Length[vs]]];
gateTol[n_]:=Switch[n,0,10^-12,1,10^-9,2,10^-5,_,2 10^-4];
leadOf[e_]:=Module[{s=Quiet@Series[e,{ep,0,2}]},If[Head[s]===SeriesData,s[[4]]/s[[6]],If[TrueQ[Simplify[e]==0],Infinity,0]]];

(* gates of Taylor coefficients cf = {I_0, I_1, ..} of int_c2 G: quadrature of G and dG/deps at eps = 0 (<= 3 folds) *)
gateTaylor[G_,c2_,cf_,dep_]:=Module[{vs=Keys[c2],gates={},okAll},
  If[Length[vs]>=4,Return[<|"OK"->True,"Gates"->{{c2,"skipped",Length[vs]}}|>,Module]];
  okAll=Catch[
    Do[With[{q=quad[If[k==0,G/.ep->0,D[G,ep]/.ep->0],c2],
             corr=If[ValueQ[$xpieceTermOmit]&&ListQ[$xpieceTermOmit],Total[(Coefficient[#["EpsFac"],ep,k] #["Quad"])&/@$xpieceTermOmit],0]},
        (* 09-27 18:20: pieces omitted as members of a cross-residue pair are added back numerically, for the gate only *)
        With[{ok=TrueQ[NumericQ[q]&&NumericQ[N[cf[[k+1]],30]]&&Abs[q-N[cf[[k+1]],30]-corr]<=gateTol[Length[vs]] Max[1,Abs[q]]]},
          Print["   gate I_",k,": quadrature ",N[q,12]," vs ",N[cf[[k+1]],12],If[corr=!=0,Row[{" + omitted pair piece(s) ",N[corr,12]}],""],If[ok,"  PASS","  FAIL"]];
          AppendTo[gates,{c2,k,N[q,12],N[cf[[k+1]],16],ok}];
          If[!ok,Throw[False,"gate"]]]],{k,0,Min[dep,1]}];
    True,"gate"];
  <|"OK"->okAll,"Gates"->gates|>];
(* one-fold alternatives: the package's one-fold family ladder and the unit-scale Mellin tower, on the eps-dependent
   integrand at its STABLE contour (their contract: the contour is valid on a crossing-free interval around eps = 0) *)
oneFoldAlternatives[G_,c2_,dep_]:=Module[{z=Keys[c2][[1]],c=c2[[1,2]],tm,fam,mt},
  tm=MBint[G,{{ep->0},{z->c}}];
  fam=Quiet@TimeConstrained[MBtoMPL`Private`mbeOneFoldFamilyLaurent[{tm},ep,0,dep,False],closeSeconds,$Aborted];
  If[ListQ[fam]&&Length[fam]===dep+1&&exactQ[fam],Return[<|"Method"->"one-fold ladder","Taylor"->(Global`mbeCanonicalConstants/@fam)|>,Module]];
  mt=If[DownValues[MBMellinTower`mbeMellinLaurent]==={},$Failed,
    Quiet@TimeConstrained[MBMellinTower`mbeMellinLaurent[G,z,ep,c,0,dep,{},True,"Log"->(Null&)],closeSeconds,$Aborted]];
  If[!FailureQ[mt]&&mt=!=$Aborted&&mt=!=$Failed&&FreeQ[mt,MBMellinTower`mbeMellinLaurent|_MBint]&&exactQ[Table[Coefficient[mt,ep,k],{k,0,dep}]],
    Return[<|"Method"->"unit-scale Mellin tower","Taylor"->Table[Global`mbeCanonicalConstants[Coefficient[mt,ep,k]],{k,0,dep}]|>,Module]];
  Failure["OneFold",<|"Reason"->"ladder and Mellin tower refused"|>]];

(* close one term int_ctr g through eps^T: stabilization, prefactor split, Taylor coefficients, gates, alternatives *)
(* PREFACTOR SPLIT BY MONOMIALS: an integrand can carry a dressing SUM whose z-free parts are singular in eps (double-pole
   residues give 2 gE + psi(-4 eps) + psi(-3 eps) + psi(1 - z) - psi(eps + z)); splitting off only z-free FACTORS would
   leave a 1/eps inside G (G not analytic at eps = 0, lead too high, the eps^-1 part of G dropped).  The term is
   expanded into monomials, grouped by their z-dependent part, and every group gets its own z-free coefficient and lead. *)
splitByMonomials[g_,vs_List]:=Module[{mons,pairs},
  mons=With[{e=Expand[g]},If[Head[e]===Plus,List@@e,{e}]];
  pairs=Map[Function[m,Module[{fs=If[Head[m]===Times,List@@m,{m}],cz,gz},
      cz=Times@@Select[fs,FreeQ[#,Alternatives@@vs]&];gz=Times@@Select[fs,!FreeQ[#,Alternatives@@vs]&];{cz,gz}]],mons];
  {Total[#[[All,1]]],#[[1,2]]}&/@GatherBy[pairs,Last]];
(* 09-27 EXACT REWRITES BEFORE THE CANDIDATE CHAIN (MB14bu r71: the u-integration's Legendre split left
   2^(-7e-2z) Gamma(y) Gamma(y+1/2)/(sqrt(pi) Gamma(2y)) = 1 uncancelled, and a slope-two polygamma psi(1-7e-2z) on a unit
   kernel defeated every closer; after the rewrites b22 closed all groups, gates passing):
   (i) Gamma/PolyGamma arguments expanded (identical legs then cancel); (ii) Gamma(y) = 2^(1-2y) sqrt(pi) Gamma(2y)/Gamma(y+1/2)
   applied when Gamma(y+1/2) and Gamma(2y) both occur (the pair folds back); (iii) on a term with no slope-two Gamma leg
   left, psi^(k)(2x) = 2^(-k-1) (psi^(k)(x) + psi^(k)(x+1/2)) (+ log 2 for k = 0) for slope-two polygammas.  Each rewrite is
   an identity, checked at a complex point; a failed check keeps the original. *)
rewriteTerm[g_,vs_List]:=Module[{h,args,dens,pt,ok,slope2Q},
  slope2Q[a_]:=AnyTrue[vs,Abs[Coefficient[Expand[a],#]]===2&];
  h=g/.{Gamma[a_]:>Gamma[Expand[a]],PolyGamma[k_,a_]:>PolyGamma[k,Expand[a]]};
  args=DeleteDuplicates[Cases[h,Gamma[a_]:>a,{0,Infinity}]];
  dens=DeleteDuplicates[Cases[h,Power[Gamma[a_],n_/;n<0]:>a,{0,Infinity}]];
  h=h/.Gamma[y_]/;(!FreeQ[y,Alternatives@@vs]&&MemberQ[args,Expand[y+1/2]]&&MemberQ[dens,Expand[2 y]]):>
      2^(1-2 y) Sqrt[Pi] Gamma[Expand[2 y]]/Gamma[Expand[y+1/2]];
  h=PowerExpand[h]/.Power[2,e_]:>Power[2,Expand[e]];
  (* (ii') a DENOMINATOR pair 1/(Gamma(y)Gamma(y+1/2)) = 2^(2y-1)/(sqrt(pi) Gamma(2y)) when a numerator slope-two leg
     Gamma(2y + d), d free of the Mellin variables, then forms a slope-two RATIO (MB14bu r72 u-term 60: the ladder closes the
     folded form, both gates passing; it refused the split one) *)
  Module[{dn=DeleteDuplicates[Cases[h,Power[Gamma[a_],-1]:>Expand[a],{0,Infinity}]],nm2=DeleteDuplicates[Cases[h,Gamma[a_]:>Expand[a],{0,Infinity}]]},
    Do[If[MemberQ[dn,Expand[y+1/2]]&&!FreeQ[y,Alternatives@@vs]&&
          AnyTrue[nm2,Function[a,AllTrue[vs,Coefficient[a,#]===2 Coefficient[y,#]&]&&FreeQ[Expand[a-2 y],Alternatives@@vs]&&!MemberQ[dn,a]]],
        h=h Gamma[y] Gamma[Expand[y+1/2]] 2^(2 y-1)/(Sqrt[Pi] Gamma[Expand[2 y]]);
        h=PowerExpand[h]/.Power[2,e_]:>Power[2,Expand[e]];Break[]],{y,dn}]];
  If[FreeQ[h,Gamma[a_]/;slope2Q[a]],
    h=h/.PolyGamma[k_,a_]/;slope2Q[a]:>With[{x=Expand[a/2]},2^(-k-1) (PolyGamma[k,x]+PolyGamma[k,Expand[x+1/2]])+If[k===0,Log[2],0]]];
  If[h===g,Return[g,Module]];
  pt=Join[Thread[vs->(1/5+I/7+Range[Length[vs]]/11)],{ep->-1/97},If[$uSym===None,{},{$uSym->2/7}]];
  ok=TrueQ[Abs[N[(g/.pt)-(h/.pt),30]]<10^-20 Max[1,Abs[N[g/.pt,30]]]];
  If[ok,Print["   rewrite: exact identities applied (Legendre fold-back / slope-two polygamma duplication)"];h,g]];
(* 2026-09-28 ITEM-LEVEL RESULT CACHE.  A closed item (term) has one exact Laurent series through eps^T for given
   e0 and eta; the family census shows the same items recurring across residues and reruns, while only the 1-2 fold
   PIECES were cached so far (3+ fold items were recomputed on every rerun).  closeTerm looks up
   C/term_cache/<sha256 of {g, contour, T, e0, eta}>.m first (the stored integrand is compared exactly) and stores every
   result that came back from closeTermRaw with its gates passed; a refused term (Failure) is never stored. *)
If[!ValueQ[$termCacheDir],$termCacheDir=FileNameJoin[{$closeStateDir,"term_cache"}]];
Quiet@CreateDirectory[$termCacheDir];
closeTerm[g0_,ctr0_]:=Module[{key=Hash[{g0,Sort[Normal[ctr0]],T,e0,eta},"SHA256","HexString"],cf,r},
  cf=FileNameJoin[{$termCacheDir,key<>".m"}];
  r=If[FileExistsQ[cf],Quiet@Check[Get[cf],$Failed],$Failed];
  If[AssociationQ[r]&&r["G"]===g0&&KeyExistsQ[r,"Laurent"],
    Print["   [term cache] item served from ",FileNameTake[cf]];Return[KeyDrop[r,{"G","Contour","T","E0","Eta","Date"}],Module]];
  r=closeTermRaw[g0,ctr0];
  If[AssociationQ[r]&&KeyExistsQ[r,"Laurent"],
    Quiet@Put[Join[<|"G"->g0,"Contour"->ctr0,"T"->T,"E0"->e0,"Eta"->eta,"Date"->DateString["ISODateTime"]|>,r],cf]];
  r];
closeTermRaw[g0_,ctr0_]:=Module[{st,laur=0,pieces={},gates={},status},
  stabLog={};
  status=Catch[
    st=stabilize[rewriteTerm[g0,Keys[ctr0]],ctr0,0];
    (* each stabilized piece -> its monomial groups (same contour) *)
    st=Join@@Table[Module[{vs=Keys[s2[[2]]]},If[vs==={},{s2},{#[[1]] #[[2]],s2[[2]]}&/@splitByMonomials[s2[[1]],vs]]],{s2,st}];
    Do[Module[{g=s2[[1]],c2=s2[[2]],vs=Keys[s2[[2]]],Cz,L,dep,G,cf,gt,method="fixed-contour closer",alt},
        Cz=Times@@Select[If[Head[g]===Times,List@@g,{g}],FreeQ[#,Alternatives@@vs]&];
        G=Together[g/Cz];L=leadOf[Cz];dep=T-L;
        Print["   piece ",InputForm[c2],": prefactor lead ",L,", depth ",dep];
        Which[
          dep<0,AppendTo[pieces,<|"Contour"->c2,"Lead"->L,"Depth"->dep,"Value"->0|>],
          vs==={},laur+=Normal[Series[g,{ep,0,T}]];AppendTo[pieces,<|"Contour"->c2,"Lead"->L,"Depth"->dep,"ZeroFold"->True|>],
          True,
            (* one-folds: the one-fold ladder FIRST (exact towers, seconds; its contract -- a crossing-free interval around
               eps = 0 -- is the stability just established), then the fixed-contour closer; multi-folds: the closer.
               Every candidate is gated; the first that passes is used. *)
            (* a one-fold term with a slope-two DENOMINATOR (the u-Beta Gamma(A+1)Gamma(B+1)/Gamma(A+B+2)) goes to the
               slope-two closer first (uint_fcu_s2.m; b22 and the ladder refuse the slope, the engine's cubes refuse the
               quadratic letter); a refusal or a failed gate falls through to the old candidates *)
            Module[{cands=With[{base=If[Length[vs]==1,{"b22","ladder","closer","tower"},{"bn","closer"}]},
                  If[DownValues[s2towerTaylor]=!={}&&
                     (* any slope-two leg: a DENOMINATOR (Beta triple) or, since 09-27 11:10, a NUMERATOR (Beta pair) *)
                     (AnyTrue[Cases[G,Gamma[a_]:>a,{0,Infinity}],fcuS2Slope2Q[#,vs]&]||
                      (* the v3 driver hands the slope-two denominator over Gauss-multiplied: 2^(..z) Gamma(y)/Gamma(y+1/2) *)
                      s2UndoDuplication[G,vs]=!=G),
                    (* no package engine after a refused slope-two closer: on these terms it refused after hours
                       (quadratic letters) or wrote wrong "clean" values (09-27 import gates); the term stays OPEN and is
                       closed later by uint_v3close_v1.wls with the improved library *)
                    (* multi-fold slope-two terms (09-27 11:09): the closer's scale variable + finite-eps Barnes reductions
                       of the others first, then the old multi-fold candidates *)
                    (* 09-28 02:45: the fixed-contour closer as the LAST candidate of one-fold slope-two terms too: its
                       engine call now tries the SEALED lane first (time-budgeted, two-construction values) and every
                       candidate is gated; MB14bu r71 u-term 39's eta R term had no other candidate (ladder/tower value
                       -10.54 vs quadrature -5.13, correctly refused) *)
                    If[Length[vs]==1,{"s2tower","b22","ladder","tower","closer"},{"s2tower","bn","closer"}],base]],
                done=False,why={}},
              Do[If[done,Break[]];
                $xpieceTermOmit={};
                (* 2 October 2026: every candidate starts with the package switches of the loader (mbeFlagGuard.m): a
                   candidate stopped by its time limit inside an HPL/HypExp call left them changed for the next one *)
                Global`mbeFlagGuardRestore["closer, before "<>ToString[m]];
                cf=Switch[m,
                  "b22",With[{b=b22Taylor[G,c2,dep]},If[FailureQ[b],b,Global`mbeCanonicalConstants/@b]],
                  "bn",With[{b=bnTaylor[G,c2,dep]},If[FailureQ[b],b,Global`mbeCanonicalConstants/@b]],
                  "s2tower",s2towerTaylor[G,c2,dep],
                  "closer",taylor[G,c2,dep],
                  "ladder",With[{fam=Quiet@TimeConstrained[MBtoMPL`Private`mbeOneFoldFamilyLaurent[{MBint[G,{{ep->0},c2}]},ep,0,dep,False],ladderSeconds,$Aborted]},
                    If[ListQ[fam]&&Length[fam]===dep+1&&exactQ[fam],Global`mbeCanonicalConstants/@fam,Failure["Ladder",<|"Reason"->"ladder refused"|>]]],
                  "tower",With[{alt=oneFoldAlternatives[G,c2,dep]},If[FailureQ[alt],alt,alt["Taylor"]]]];
                (* 2026-09-29 17:1x: a refusal because the engine stages were DEFERRED ($closeDeferEngine) is marked in the
                   aggregated reason, so that the caller (the multifold handler) recognizes it and runs the full chain *)
                If[FailureQ[cf],AppendTo[why,m<>" refused"<>If[StringQ[cf["Reason"]]&&StringContainsQ[cf["Reason"],"deferred"]," (deferred)",""]];Print["   ",m," refused: ",cf["Reason"]];Continue[]];
                Print["   ",m,": I_k = ",N[cf,16]];
                gt=gateTaylor[G,c2,cf,dep];gates=Join[gates,gt["Gates"]];
                If[gt["OK"],done=True;method=Switch[m,"closer","fixed-contour closer","ladder","one-fold family ladder","b22","Barnes 2+2 closed form","bn","iterated Barnes 2+2 closed form",
                    "s2tower","slope-two closer (Beta triple or numerator pair, Mellin tower at the scale, exact last fold on pulled-back words, sixth-root reduction)",_,"one-fold alternatives"],
                  AppendTo[why,m<>" failed its gate"]],{m,cands}];
              If[!done,Throw[Failure["Close",<|"Reason"->StringRiffle[why,"; "]|>],"refuse"]]];
            laur+=Normal[Series[Cz Sum[cf[[k+1]] ep^k,{k,0,dep}],{ep,0,T}]];
            AppendTo[pieces,<|"Contour"->c2,"Lead"->L,"Depth"->dep,"Taylor"->cf,"Method"->method|>]]],{s2,st}];
    "ok","refuse"];
  If[status=!="ok",Return[If[Head[status]===Failure,status,Failure["Close",<|"Reason"->"stabilization refused"|>]],Module]];
  <|"Laurent"->Expand[laur],"Pieces"->pieces,"Gates"->gates,"Stabilization"->stabLog|>];

(* 09-27 15:00: DIOGENES (the pFq differential system in eps-form, Lee's algorithm) as the fallback of the HypExp block
   expanders hbbExpand / oftExpandBlocks (half-integer blocks of slope-two towers; validated on MB14bu r71 #2: the four
   5F4(1) blocks HypExp failed on, ladder result 0 through eps^-3 = the quadrature references) *)
If[FileExistsQ[FileNameJoin[{$closeLibDir,"mbeDiogenesFallback.m"}]],Get[FileNameJoin[{$closeLibDir,"mbeDiogenesFallback.m"}]]];
