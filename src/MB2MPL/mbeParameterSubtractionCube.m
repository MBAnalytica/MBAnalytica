(* Source-derived, parameter-aware faithful Euler subtraction. *)
BeginPackage["MBParameterSubtraction`"];
PSCubeCandidates::usage="PSCubeCandidates[term,eps,pars] constructs faithful positive Euler cubes of a resolved contour term.";
PSPrepareCube::usage="PSPrepareCube[candidate,eps,lo,hi,pars] forms exact endpoint moments before extracting finite coefficient integrals.";
PSIntegrateJobs::usage="PSIntegrateJobs[jobs,pars,seconds,cache] integrates certified finite coefficient jobs and returns GPL expressions and provenance.";
PSAssembleCube::usage="PSAssembleCube[prepared,values,eps,lo,hi] convolves exact prefactors with integrated endpoint moments.";
$PSNativeDirectory::usage="Optional directory for reproducible native intermediate certificates.";
$PSNativeSeconds::usage="Time allowed per native variable ordering.";
$PSNativeRetrySeconds::usage="Time allowed per native variable ordering in the second native pass (jobs left open for lack of time by the first pass; default 300).";
$PSNativeRetryBudget::usage="Wall-clock budget of the second native pass of one batch (default 2400 s).";
PSNativeEngine::usage="PSNativeEngine[] is the hyperlogarithm integrator of the parameter Subtraction ladder: the guarded build Global`$MBStandardHyperFLINTGuardedBinary (a letter factor that is not linear in the integration variable refuses the word transformation instead of being dropped) when it is installed, else Global`$ivfBin.";
Begin["`Private`"];
$codeDirectory=DirectoryName[ExpandFileName[$InputFileName]];
(* release R3.1 (4 October 2026): 60 s, was 45 s -- the native limit of the high-fold ladder, so that a candidate the
   high-fold ladder skips as already refused here was integrated under the same limit *)
If[!ValueQ[$PSNativeSeconds],$PSNativeSeconds=60];
(* release R3.1 (3 October 2026): the native jobs of this ladder run on the guarded integrator and the configured Python *)
PSNativeEngine[]:=If[StringQ[Global`$MBStandardHyperFLINTGuardedBinary]&&FileExistsQ[Global`$MBStandardHyperFLINTGuardedBinary],
 Global`$MBStandardHyperFLINTGuardedBinary,Global`$ivfBin];
(* the exact last-fold rung of this ladder: an explicitly configured last-fold engine (Global`$mbeLastFoldEngine), else
   the guarded integrator *)
psLastFoldEngine[]:=If[StringQ[Global`$mbeLastFoldEngine],Global`$mbeLastFoldEngine,PSNativeEngine[]];
psPython[]:=If[StringQ[Global`$MBStandardPythonExecutable],Global`$MBStandardPythonExecutable,"python3"];
(* release R3.1 (4 October 2026): the exact last folds of the uncertified jobs of one batch IN PARALLEL.  Every job is the
   same call of the rung (mbeExactLastFoldRung.m) with the same options, time limits and gates as the serial loop it
   replaces (MB6u: 50 jobs of 4-30 minutes each ran one after another); only where a job runs changes: on subkernels
   that load the release as the faithful-cube workers do (load_standard.m), at most Global`$psLastFoldWorkers (default
   16) and within the policy cap of free subkernels (Global`mbtSubkernelCapDynamic).  A job that no worker returned
   (a lost kernel), a single job, no free subkernel, or Global`$psLastFoldSerial = True: the serial loop in this kernel.
   Returns jobId -> the rung's result; the caller applies the exact contract and records the trace as before. *)
psLastFoldOne[dir_String,fid_String,eng_String,es_,tl_]:=Quiet@TimeConstrained[MBExactLastFold`mbeExactLastFold[dir,fid,"Log"->(Null&),
 "Write"->True,"Engine"->eng,"EngineSeconds"->es,"RequireCertificate"->True],tl,$TimedOut];
psLastFoldMany[dir_String,fids_List,eng_String,es_,tl_]:=Module[{res=<||>,ks={},own={},cap,nW,base=Global`$MBStandardDir,jobs,rr,ii},
 If[Length[fids]>=2&&!TrueQ[Global`$psLastFoldSerial]&&StringQ[base]&&DirectoryQ[base],
  If[Kernels[]=!={},ks=Kernels[],
   cap=If[DownValues[Global`mbtSubkernelCapDynamic]=!={},Global`mbtSubkernelCapDynamic[],0];
   nW=Max[0,Min[cap,Length[fids],If[IntegerQ[Global`$psLastFoldWorkers],Global`$psLastFoldWorkers,16]]];
   If[nW>=2,Quiet[LaunchKernels[nW]];own=Kernels[];ks=own]];   (* the pool was empty: every kernel now in it is ours to close *)
  If[ks=!={},
   (* one round trip loads the release where needed and reports whether the rung is defined; every kernel of the pool
      must carry it (ParallelSubmit schedules on the whole pool), else serial.  (A separate ParallelEvaluate per kernel
      took 22 s each in the master, 4 October.) *)
   Module[{ok=With[{d=base},Quiet@ParallelEvaluate[Off[General::shdw];SetDirectory[d];
       If[!MemberQ[$Packages,"MBtoMPL`"]||Length[DownValues[MBExactLastFold`mbeExactLastFold]]===0,
         Block[{$Output={}},Quiet@Get[FileNameJoin[{d,"load_standard.m"}]]]];
       Length[DownValues[MBExactLastFold`mbeExactLastFold]]>0,ks,DistributedContexts->None]]},
     If[!(ListQ[ok]&&Length[ok]===Length[ks]&&AllTrue[ok,TrueQ]),ks={}]]];
  If[ks=!={},
   jobs=Table[With[{dd=dir,f=fid,e=eng,s=es,t=tl},ParallelSubmit[{f,Quiet@TimeConstrained[MBExactLastFold`mbeExactLastFold[dd,f,"Log"->(Null&),
     "Write"->True,"Engine"->e,"EngineSeconds"->s,"RequireCertificate"->True],t,$TimedOut]}]],{fid,fids}];
   While[jobs=!={},{rr,ii,jobs}=WaitNext[jobs];If[ListQ[rr]&&Length[rr]===2&&StringQ[rr[[1]]],AssociateTo[res,rr[[1]]->rr[[2]]]]]];
  If[own=!={},Quiet@CloseKernels[own]]];
 Do[If[!KeyExistsQ[res,fid],AssociateTo[res,fid->psLastFoldOne[dir,fid,eng,es,tl]]],{fid,fids}];
 res];
(* job ids of a list of rows or records, as strings (Lookup on an empty list would return Missing, not {}) *)
psIds[l_List]:=ToString[#["id"]]&/@l;
(* release R3.1 (4 October 2026): the key of a prepared job set (integrands, variables, cube orders), with which the
   high-fold ladder skips a candidate whose jobs the plain cube ladder has already integrated and refused *)
psJobSetKey[jobs_List]:=Hash[Sort[{#["Integrand"],#["Variables"],#["CubeOrder"]}&/@jobs],"SHA256"];
(* release R3.1 (4 October 2026): a SECOND native pass with longer limits for the jobs the first pass left open for lack
   of time -- no certified integration order within the per-order limit, or an algebraic-root audit that did not
   finish ("audit_failed") -- before they go to the exact last fold.  Same runner, same request (same orders, same
   audit, same certification test); only "job_seconds" ($PSNativeRetrySeconds; the audit gets four times it) and the
   wall budget ($PSNativeRetryBudget) change.  A retried record and its verdict replace the first ones; a verdict
   "differs" or "roots" (a different value or a root letter) is final and never retried.  MB11u term 13, cube
   candidate 1: jobs 20 and 35 certify natively in 74 s and 93 s (every order timed out at 45 s), and the audits of
   jobs 19, 32 and 34 need more than 4 x 45 s; these five singletons are not certifiably convergent, so the last fold
   cannot take them and the candidate was refused. *)
If[!ValueQ[$PSNativeRetrySeconds],$PSNativeRetrySeconds=300];
If[!ValueQ[$PSNativeRetryBudget],$PSNativeRetryBudget=2400];
(* the integration orders of a failed record that ran out of time (the others returned a verdict that more time cannot
   change: a divergence, a refused nonlinear letter, an engine error) *)
psTimedOutOrders[rec_Association]:=DeleteDuplicates@Cases[Lookup[rec,"trials",{}],
 t_Association/;MemberQ[{"TimeoutExpired","DeadlineExpired"},Lookup[t,"error",""]]:>t["order"]];
(* release R3.1 (4 October 2026): before the second pass, the candidate is refused at once when one of its jobs can be
   closed by no pass and not by the exact last fold either: a job that failed natively in every order with a verdict that
   is not a time limit, or whose audit verdict is final ("differs", "roots"), and that the last fold's own convergence
   certificate refuses (MBExactLastFold`mbeLastFoldCertificate: a job that is not certifiably convergent alone is
   integrated only inside its union sum).  The outcome is the one the full chain would reach -- the same certificate
   refuses the same job in the last fold -- without the second pass and the last folds of a candidate that cannot close
   (MB11u: four refused candidates of one residue, each with 10-11 such jobs, certificate refusals in 0.1-1.2 s).  A
   certificate that runs out of time decides nothing here.  The second pass itself runs only the orders that ran out of
   time, and for an unfinished audit only the record's winning order. *)
(* the last fold's certificate refuses this job (a certificate that ran out of time decides nothing); one evaluation
   per request in a session *)
If[!AssociationQ[$psCertMemo],$psCertMemo=<||>];
psLoadCertificate[]:=(If[DownValues[MBExactLastFold`mbeLastFoldCertificate]==={}&&FileExistsQ[FileNameJoin[{$codeDirectory,"mbeExactLastFoldRung.m"}]],
   Quiet@Get[FileNameJoin[{$codeDirectory,"mbeExactLastFoldRung.m"}]]];DownValues[MBExactLastFold`mbeLastFoldCertificate]=!={});
psCertificateRefusedQ[job_Association]:=Module[{key=Hash[{job["request"]["expr"],job["request"]["vars_int"]},"SHA256"],cert},
 If[KeyExistsQ[$psCertMemo,key],Return[$psCertMemo[key],Module]];
 cert=MBExactLastFold`mbeLastFoldCertificate[job];
 $psCertMemo[key]=(AssociationQ[cert]&&cert["Certified"]===False&&Lookup[cert,"Reason",""]=!="certificate timeout")];
(* the jobs of a batch that the native runner watches (mbe_parameter_subtraction_native_par.py: their orders first; the
   batch stops when one of them can close neither natively nor by the last fold) *)
psWatchList[rows_List]:=If[!psLoadCertificate[],{},ToString[#["id"]]&/@Select[rows,psCertificateRefusedQ]];
psDoomedJobs[input_String,result_Association]:=Module[{req,recs,aud,genuine,final,cand,jobs,cert},
 If[!psLoadCertificate[],Return[{},Module]];
 recs=Association[(ToString[#["id"]]->#)&/@result["records"]];
 aud=Replace[Lookup[result,"audit",<||>],Except[_Association]-><||>];
 genuine=Keys[Select[recs,!TrueQ[#["success"]]&&psTimedOutOrders[#]==={}&]];
 final=ToString/@Keys[Select[aud,MemberQ[{"differs","roots"},#]&]];
 cand=Union[genuine,final];If[cand==={},Return[{},Module]];
 req=Quiet@Import[input,"RawJSON"];If[!AssociationQ[req]||!ListQ[req["jobs"]],Return[{},Module]];
 jobs=Association[(ToString[#["id"]]->#)&/@req["jobs"]];
 Select[cand,KeyExistsQ[jobs,#]&&psCertificateRefusedQ[jobs[#]]&]];
psNativeRetry[dir_String,input_String,result_Association,seconds_]:=Module[{ids,req,budget,in2,out2,streams,proc,r2,recs,aud,doomed,orders},
 doomed=psDoomedJobs[input,result];
 If[doomed=!={},Return[Join[result,<|"Doomed"->doomed|>],Module]];
 recs=Association[(ToString[#["id"]]->#)&/@result["records"]];
 aud=Replace[Lookup[result,"audit",<||>],Except[_Association]-><||>];
 (* job -> the orders to run again *)
 orders=Join[
   Select[psTimedOutOrders/@Select[recs,!TrueQ[#["success"]]&],#=!={}&],
   Association[(#->Select[{Lookup[recs[#],"order_used",None]},ListQ])&/@Select[ToString/@Keys[Select[aud,#==="audit_failed"&]],KeyExistsQ[recs,#]&]]];
 orders=Select[orders,#=!={}&];ids=Keys[orders];
 budget=Floor[Min[$PSNativeRetryBudget,seconds-60]];
 If[ids==={}||!NumericQ[budget]||budget<2 $PSNativeRetrySeconds,Return[result,Module]];
 req=Import[input,"RawJSON"];If[!AssociationQ[req]||!ListQ[req["jobs"]],Return[result,Module]];
 req["jobs"]=(Join[#,<|"orders"->orders[ToString[#["id"]]]|>]&)/@Select[req["jobs"],MemberQ[ids,ToString[#["id"]]]&];
 req["job_seconds"]=$PSNativeRetrySeconds;req["deadline_unix"]=UnixTime[]+budget;
 in2=FileNameJoin[{dir,"requests_retry.json"}];out2=FileNameJoin[{dir,"responses_retry.json"}];
 Export[in2,req,"RawJSON"];
 streams=CreateDirectory[];
 proc=Internal`WithLocalSettings[Null,Block[{ProcessLink`Private`$TempPrefix=FileNameJoin[{streams,"wl-"}]},
   RunProcess[{"timeout","--kill-after=2",ToString[budget+30],psPython[],
     FileNameJoin[{$codeDirectory,"mbe_parameter_subtraction_native_par.py"}],in2,out2}]],
   Quiet@DeleteDirectory[streams,DeleteContents->True]];
 If[!AssociationQ[proc]||proc["ExitCode"]=!=0||!FileExistsQ[out2],Return[result,Module]];
 r2=Quiet@Import[out2,"RawJSON"];If[!AssociationQ[r2]||!ListQ[r2["records"]],Return[result,Module]];
 recs=Association[(ToString[#["id"]]->#)&/@result["records"]];
 Scan[(recs[ToString[#["id"]]]=#)&,r2["records"]];
 aud=Join[Replace[Lookup[result,"audit",<||>],Except[_Association]-><||>],Replace[Lookup[r2,"audit",<||>],Except[_Association]-><||>]];
 Join[result,<|"records"->Values[recs],"audit"->aud,"Retried"->ids|>]];

freeAffineLeaves[cube_,vars_,pars_]:=Module[{f=cube,vv=vars,proof={},dep,d,a,b,old,again=True},
 While[again,again=False;
 Do[dep=Select[ff[f],!FreeQ[#,v]&];
 If[Length[dep]=!=1||!MatchQ[First[dep],Power[_, -2]],Continue[]];
 d=First[dep][[1]];If[!PolynomialQ[d,v]||Exponent[d,v]=!=1,Continue[]];
 a=Expand[d/.v->0];b=Expand[d/.v->1];
 If[Global`psuPolynomialSign[a,Join[DeleteCases[vv,v],pars]]=!=1||Global`psuPolynomialSign[b,Join[DeleteCases[vv,v],pars]]=!=1,Continue[]];
 old=f;f=(Times@@DeleteCases[ff[f],First[dep]])/(a b);vv=DeleteCases[vv,v];
 AppendTo[proof,<|"Class"->"PositiveAffineReciprocalSquare","Variable"->v,"Denominator"->d,"Endpoints"->{a,b},"Identity"->1/(a b)|>];
 again=True;Break[],{v,vv}]];
 <|"Expression"->f,"Variables"->vv,"Proof"->proof|>];

PSCubeCandidates[term_,ep_Symbol,pars_List]:=Module[
 {f=term[[1]],ctr=term[[2,2]],vars,en,dr,gn,inv,norm,leaf,pref,cube,axes,cf,rows={},orders},
 vars=Keys[ctr];If[vars==={}||Length[vars]>3,Return[refuse["Faithful cube fold bound exceeded or no contour"],Module]];
 gn=MBParameter`Private`gammaQuotientNormalize[f,vars];If[AssociationQ[gn],f=gn["Expression"]];
 en=ep->Global`fcuSafeEps[f,vars,ctr,ep];
 dr=TimeConstrained[Global`fcuDress[f,vars,ctr,en,ep],30,$Failed];
 If[dr=!=None&&(!AssociationQ[dr]||TrueQ[dr["Failed"]]),Return[refuse["Faithful dressing refused",<|"Detail"->dr|>],Module]];
 orders=Permutations[vars];
 Do[inv=TimeConstrained[Global`fcuInvertV2[If[AssociationQ[dr],dr["K"],f],vars,ctr,ep,order,en,plan,dr],20,$Failed];
 If[!AssociationQ[inv]||TrueQ[inv["Failed"]],Continue[]];
 norm=TimeConstrained[Global`psuNormalizeCube[inv["Cube"],inv["Vars"],ep,pars],20,$Failed];If[!AssociationQ[norm],Continue[]];
 leaf=freeAffineLeaves[norm["Expression"],inv["Vars"],pars];cube=leaf["Expression"];axes=leaf["Variables"];
 cf=Times@@Select[ff[cube],FreeQ[#,Alternatives@@axes]&];cube=Times@@Select[ff[cube],!FreeQ[#,Alternatives@@axes]&];
 pref=If[AssociationQ[dr],dr["Prefactor"],1]inv["Prefactor"]cf;
 AppendTo[rows,<|"Cube"->cube,"Variables"->axes,"Prefactor"->pref,"Order"->order,"Plan"->plan,
 "Source"->term,"SafeEpsilon"->en,"Dressing"->dr,"Inversion"->inv,"PositivityProofs"->norm["PositivityProofs"],"AffineLeafProofs"->leaf["Proof"]|>],
 {order,orders},{plan,{{},{2},{3}}}];
 If[rows==={},refuse["No positive faithful cube construction"],
 SortBy[DeleteDuplicatesBy[rows,{#["Cube"],#["Variables"],#["Prefactor"]}&],{Length[#["Variables"]],LeafCount[#["Cube"]]}&]]];

PSPrepareCube[r_Association,ep_Symbol,lo_Integer,hi_Integer,pars_List]:=Catch[Module[
 {pcs,pl,ps,top,series,low,logs,jobs={},jj,idx=0,minCube,prefSer},
 ps=PSGammaSeries[r["Prefactor"],ep,Max[0,hi]];If[FailureQ[ps],Throw[ps,seriesTag]];
 pl=Global`fcuLeadOrderOfSeries[ps,r["Prefactor"]];If[!IntegerQ[pl],Throw[refuse["Unresolved cube prefactor valuation"],seriesTag]];
 top=hi-pl;
 pcs=Catch[Global`fcuFacePieces[r["Cube"],r["Variables"],ep],Global`fcu$tag];
 If[!ListQ[pcs],Throw[refuse["Endpoint face subtraction refused",<|"Details"->pcs|>],seriesTag]];
 logs=Global`fcuStructuralLogs[pcs,r["Variables"]];
 series=Table[TimeConstrained[Series[Global`fcuApplyOps[p,p["R"],ep],{ep,0,Max[0,top]}],120,$Failed],{p,pcs}];
 If[!FreeQ[series,$Failed|_Series|Indeterminate|ComplexInfinity],Throw[refuse["Endpoint moment expansion refused"],seriesTag]];
 low=MapThread[Global`fcuLeadOrderOfSeries[#1,Global`fcuApplyOps[#2,#2["R"],ep]]&,{series,pcs}];
 minCube=Min[low];If[minCube===Infinity,minCube=0];
 prefSer=PSGammaSeries[r["Prefactor"],ep,hi-minCube];If[FailureQ[prefSer],Throw[prefSer,seriesTag]];
 Do[If[low[[j]]===Infinity,Continue[]];
 Do[jj=Global`fcuPieceSeriesJobs[pcs[[j]],series[[j]],k,ep,logs];
 Do[idx++;AppendTo[jobs,<|"ID"->ToString[idx],"CubeOrder"->k,"Piece"->j,"Integrand"->q[[1]],"Variables"->q[[2]]|>],{q,jj}],{k,low[[j]],top}],{j,Length[pcs]}];
 Join[r,<|"PrefactorLead"->pl,"CubeRange"->{minCube,top},"Pieces"->pcs,"PieceSeries"->series,
 "PrefactorSeries"->prefSer,"Jobs"->jobs|>]
],seriesTag];

(* Direct projective GPL conversion avoids expression swell in Mpl conversion.
   Native output is a tangentially regularized period on [0,infinity]. *)
regWord[{}]=1;
regWord[w_List]:=regWord[w]=Module[{m=Length[TakeWhile[w,#===1&]],tail},
 Which[m===0,If[AllTrue[w,#===0&],0,PolyLogTools`G@@Append[w,1]],m===Length[w],0,
 True,tail=Rest[w];-Total[Table[regWord[Insert[tail,1,j+1]],{j,m,Length[tail]}]]/m]];
periodWord[w_List]:=periodWord[w]=Module[{rows={{1,{}}}},
 Do[rows=Flatten[Table[If[a===-1,{{-r[[1]],Append[r[[2]],1]}},
 {{r[[1]],Append[r[[2]],Cancel[a/(1+a)]]},{-r[[1]],Append[r[[2]],1]}}],{r,rows}],1],{a,w}];
 Total[#[[1]]regWord[#[[2]]]&/@rows]];
(* the strict parser of this ladder (release R3.1: its own name, so that mbeParameterSubtractionRoots.m keeps
   parseNative, the parser of the exact last-fold rung, as in release R3) *)
parseNativeStrict[r_Association]:=Module[{parse,value},
 If[!ListQ[Lookup[r,"result",None]]||AnyTrue[{"failed","divergent","error"},KeyExistsQ[r,#]&],Return[refuse["Native finite integral not certified"],Module]];
 If[Lookup[r,"algebraic_letters",{}]=!={}&&Lookup[r,"algebraic_letters",False]=!=False,Return[refuse["Unexpected algebraic letters"],Module]];
 parse[s_String]:=Block[{$Context="Global`",$ContextPath={"System`","Global`"}},ToExpression[StringReplace[s,"_"->"$"],InputForm]]/.Global`atomRules;
 value=Total[Table[parse[row["coef"]]Times@@(periodWord[parse/@#]&/@row["key"]),{row,r["result"]}]];
 Global`gvExact[value]];
(* a tree that does not load mbeParameterSubtractionRoots.m gets parseNative from here *)
If[DownValues[parseNative]==={},parseNative[r_Association]:=parseNativeStrict[r]];

PSIntegrateJobs[jobs_List,pars_List,seconds_,cache_]:=Module[
 {dir,np,rules,reverseRules,rows={},cn=<||>,direct=<||>,vars,f,dep,constant,orders,rq,lastFoldValues,uncertified,
 input,output,proc,result,values,record,id,streams},
 dir=If[StringQ[$PSNativeDirectory],$PSNativeDirectory,CreateDirectory[]];
 If[!DirectoryQ[dir],CreateDirectory[dir,CreateIntermediateDirectories->True]];
 np=Table[Symbol["Global`psParameter"<>ToString[i]],{i,Length[pars]}];
 rules=Thread[pars->np];reverseRules=Thread[np->pars];
 Do[id=j["ID"];vars=j["Variables"];f=j["Integrand"];
 If[vars==={},AssociateTo[direct,id->f];Continue[]];
 dep=Select[ff[f],!FreeQ[#,Alternatives@@vars]&];constant=Times@@Complement[ff[f],dep];
 AssociateTo[cn,id->constant];
 orders=DeleteDuplicates[{Global`fcuKernelFirstOrder[Times@@dep,vars],vars,Reverse[vars],RotateLeft[vars],RotateRight[vars]}];
 If[DownValues[MBParameterSubtractionHF`Private`heurOrders]=!={},
   With[{h=MBParameterSubtractionHF`Private`heurOrders[Times@@dep,vars,48]},
     If[AssociationQ[h],orders=DeleteDuplicates[If[TrueQ[h["Structural"]],Join[h["Orders"],orders],Join[orders,h["Orders"]]]]]]];
 rq=Global`ivfNativeRequest[Global`ivfPolyLogToHlog[(Times@@dep/.rules)/.Global`constToHF],vars,First[orders],True,np];
 rq["algebraic_letters"]=False;rq["spectator_algebraic_letters"]=False;
 AppendTo[rows,<|"id"->id,"request"->rq,"orders"->(SymbolName/@#&/@orders)|>],{j,jobs}];
 input=FileNameJoin[{dir,"requests.json"}];output=FileNameJoin[{dir,"responses.json"}];
 Export[input,<|"jobs"->rows,"binary"->PSNativeEngine[],"cache"->TrueQ[cache],"job_seconds"->Min[seconds,$PSNativeSeconds],
 "record_directory"->FileNameJoin[{dir,"native"}],"workers"->With[{nw=MBParameterSubtractionHF`$PSHNativeWorkers},If[IntegerQ[nw]&&nw>3,nw,3]],"audit"->True,"deadline_unix"->UnixTime[]+seconds,
 "watch"->psWatchList[rows]|>,"RawJSON"];
 streams=CreateDirectory[];
 proc=Internal`WithLocalSettings[Null,Block[{ProcessLink`Private`$TempPrefix=FileNameJoin[{streams,"wl-"}]},
 RunProcess[{"timeout",ToString[Ceiling[seconds]],psPython[],FileNameJoin[{$codeDirectory,"mbe_parameter_subtraction_native_par.py"}],input,output}]],
 Quiet@DeleteDirectory[streams,DeleteContents->True]];
 If[!AssociationQ[proc]||proc["ExitCode"]=!=0||!FileExistsQ[output],Return[refuse["Native coefficient job runner refused or timed out",<|"Directory"->dir|>],Module]];
 result=Import[output,"RawJSON"];
 (* the runner stopped at a watched job that can close neither natively nor by the last fold (its certificate refuses
    it): the candidate cannot close *)
 If[KeyExistsQ[result,"aborted"],Return[refuse["A finite coefficient job closes neither natively nor by the exact last fold (not certifiably convergent alone)",
   <|"Directory"->dir,"Jobs"->{ToString[result["aborted"]]}|>],Module]];
 result=psNativeRetry[dir,input,result,seconds];
 If[KeyExistsQ[result,"Doomed"],Return[refuse["A finite coefficient job closes neither natively nor by the exact last fold (not certifiably convergent alone)",
   <|"Directory"->dir,"Jobs"->result["Doomed"]|>],Module]];
 (* release R3.1 (3 October 2026): a record is certified only when it succeeded AND its algebraic-root audit is "safe";
    a record with root letters, a different audited value or a failed audit run is treated as an unclosed one (the
    29 September edit below had let such records through whenever every record succeeded) *)
 uncertified=Union[psIds[Select[result["records"],!TrueQ[#["success"]]&]],
   ToString/@Keys[Select[Replace[Lookup[result,"audit",<||>],Except[_Association]-><||>],#=!="safe"&]],
   Complement[psIds[rows],psIds[result["records"]]]];
 (* 2026-09-29 (general multifold handler): a native job the engine leaves unclosed goes to the EXACT LAST-FOLD rung
    (mbeExactLastFoldRung.m: engine on the first n-1 variables, fixed-letter fibration of the last variable at an interior
    basepoint, complete endpoint jets; convergence certificate required) before the whole cube is refused.  The rung reads the
    same requests.json (parameter psParameter1) and writes lastfold_<id>.m into the job directory. *)
 lastFoldValues=<||>;
 If[uncertified=!={}&&!TrueQ[Global`$mfhNoLastFold],
   Module[{lf,lfs},
     If[DownValues[MBExactLastFold`mbeExactLastFold]==={}&&FileExistsQ[FileNameJoin[{$codeDirectory,"mbeExactLastFoldRung.m"}]],
       Quiet@Get[FileNameJoin[{$codeDirectory,"mbeExactLastFoldRung.m"}]]];
     If[DownValues[MBExactLastFold`mbeExactLastFold]=!={},
       lfs=psLastFoldMany[dir,uncertified,psLastFoldEngine[],Min[1200,Ceiling[seconds]],Min[2400,Ceiling[seconds]]];
       Do[lf=Lookup[lfs,fid,$Failed];
          If[AssociationQ[lf]&&lf["Status"]==="LASTFOLD_DONE"&&MBParameter`Private`exactQ[lf["Value"]/.reverseRules,pars],
            AssociateTo[lastFoldValues,fid->lf["Value"]];
            AppendTo[MBParameter`Private`$trace,<|"Class"->"ExactLastFoldRung","Job"->fid,"Directory"->dir,"Record"->lf["RecordFile"],"ValueAt"->lf["ValueAt"]|>]],
         {fid,uncertified}]]]];
 If[!SubsetQ[Keys[lastFoldValues],uncertified],
   Return[refuse["Some finite coefficient integrals remain unclosed or failed the root audit",<|"Directory"->dir,"FailedJobs"->Complement[uncertified,Keys[lastFoldValues]],"Audit"->Lookup[result,"audit",<||>]|>],Module]];
 values=direct;
 record=Association[(ToString[#["id"]]->Lookup[#,"response",<||>])&/@result["records"]];
 Do[id=row["id"];AssociateTo[values,id->cn[id](If[KeyExistsQ[lastFoldValues,ToString[id]],lastFoldValues[ToString[id]],parseNativeStrict[record[ToString[id]]]]/.reverseRules)],{row,rows}];
 If[!AllTrue[Values[values],MBParameter`Private`exactQ[#,pars]&],Return[refuse["Native output failed exact coefficient contract",<|"Directory"->dir|>],Module]];
 <|"Values"->values,"Directory"->dir,"Count"->Length[jobs],"NativeCount"->Length[rows],"EndpointDivergencesChecked"->True|>];

PSAssembleCube[prepared_Association,values_Association,ep_Symbol,lo_Integer,hi_Integer]:=Module[{pr=prepared["PrefactorSeries"],jobs=prepared["Jobs"]},
 Total@Table[Expand[Total[Table[With[{k=n-j["CubeOrder"]},
 If[Head[pr]===SeriesData,SeriesCoefficient[pr,k],Coefficient[Expand[pr],ep,k]]]values[j["ID"]],{j,jobs}]]]ep^n,{n,lo,hi}]];
End[];EndPackage[];
Print["[mbeParameterSubtractionCube] positive faithful cubes, endpoint moments, finite native integrals and GPL assembly."];
