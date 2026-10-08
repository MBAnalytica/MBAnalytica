(* Public parameter Subtraction class ladder. No target recognition or result bank. *)
BeginPackage["MBParameterSubtraction`"];
PSExpand::usage="PSExpand[f,eps,contract,lo,hi,seconds,cache] evaluates the parameter Subtraction ladder.";
Begin["`Private`"];
truncate[f_,ep_,lo_,hi_]:=Total@Table[Coefficient[Expand[f],ep,k]ep^k,{k,lo,hi}];

towerTerm[term_,ep_,lo_,hi_,pars_,seconds_,cache_]:=Module[
 {vars=Keys[term[[2,2]]],scale,bare,cl,blocks,out,pref,lead,ex},
 If[Length[vars]=!=1,Return[refuse["Not a one-fold tower"],Module]];
 scale=Times@@Select[ff[term[[1]]],FreeQ[#,Alternatives@@vars]&&!FreeQ[#,Alternatives@@pars]&];
 bare=Times@@Select[ff[term[[1]]],!(FreeQ[#,Alternatives@@vars]&&!FreeQ[#,Alternatives@@pars])&];
 If[!FreeQ[bare,Alternatives@@pars],Return[refuse["External scale lies inside the tower"],Module]];
 pref=PSGammaSeries[scale,ep,Max[0,hi]];If[FailureQ[pref],Return[pref,Module]];
 lead=Global`fcuLeadOrderOfSeries[pref,scale];If[!IntegerQ[lead],Return[refuse["External tower prefactor valuation"],Module]];
 cl=TimeConstrained[Global`oftCloseOne[bare,First[vars],ep,term[[2,2,1,2]],ep->Global`fcuSafeEps[bare,vars,term[[2,2]],ep],hi-lead],Min[60,seconds],$Failed];
 If[!AssociationQ[cl]||TrueQ[cl["Failed"]],Return[refuse["Both tower directions refused",<|"Details"->cl|>],Module]];
 blocks=Block[{Global`$oftNoSubkernels=True,Global`$oftNoHypExpBank=!TrueQ[cache],Global`$oftHypExpBudget=seconds},Global`oftExpandBlocks[cl["Blocks"],ep,False]];
 If[!AssociationQ[blocks],Return[refuse["Exact tower block expansion refused"],Module]];
 out=PSGammaSeries[scale cl["Others"],ep,hi];If[FailureQ[out],Return[out,Module]];
 Do[ex=b["PFQ"]/.blocks;
 If[!FreeQ[ex,_HypergeometricPFQ|_Hypergeometric2F1|_HypExp`HypExp],Return[refuse["Unexpanded tower block"],Module]];
 pref=PSGammaSeries[scale b["Pref"],ep,hi];If[FailureQ[pref],Return[pref,Module]];
 out+=pref ex,{b,cl["Blocks"]}];
 <|"Expression"->truncate[Normal[out],ep,lo,hi],"Class"->"ExternalFactorExactTower",
 "Closure"->cl,"BlockExpansions"->blocks,"ExternalFactor"->scale|>];

(* release R3.1: PSExpand = the ladder below (psExpandMain: census, Barnes and handler reductions, the closing ladder per
   term); when it refuses an integrand, a SECOND PASS takes the ORIGINAL resolved residues of that integrand (no census,
   no reductions) and closes each with the same closing ladder, whose last closer is the per-residue Standard closer --
   so a residue is never left unclosed because a merged or reduced form of it is harder than the residue itself.  The
   second pass is an independent evaluation of the whole integrand; nothing of the refused first pass is kept. *)
PSExpand[f_,ep_Symbol,c_Association,lo_Integer,hi_Integer,seconds_,cache_]:=Module[{t0=AbsoluteTime[],r,r2},
 r=psExpandMain[f,ep,c,lo,hi,seconds,cache];
 If[!FailureQ[r]||Head[f]===Plus||TrueQ[Global`$orsHelperMode]||TrueQ[Global`$psNoSecondPass],Return[r,Module]];
 AppendTo[MBParameter`Private`$trace,<|"Class"->"SecondPassOverOriginalResidues","FirstPassRefusal"->r|>];
 r2=psSecondPass[f,ep,c,lo,hi,Max[1,seconds-(AbsoluteTime[]-t0)],cache];
 If[FailureQ[r2],Failure["ParameterSubtraction",<|"Reason"->"Both passes refused","FirstPass"->r,"SecondPass"->r2|>],r2]];

psSecondPass[f_,ep_Symbol,c_Association,lo_Integer,hi_Integer,seconds_,cache_]:=Catch[Module[
 {pars=c["Parameters"],dom=c["Assumptions"],resolved,term,ans,values={},t0=AbsoluteTime[],timeLeft,baseRoot=$PSNativeDirectory},
 timeLeft[]:=Max[1,seconds-(AbsoluteTime[]-t0)];
 resolved=MBParameter`Private`parameterResolve[f,ep,Min[90,timeLeft[]]];
 If[!ListQ[resolved],Throw[refuse["Second pass: contour resolution failed",<|"Details"->resolved|>],seriesTag]];
 Do[term=resolved[[i]];
   If[term[[2,2]]==={},ans=PSGammaSeries[term[[1]],ep,hi];If[FailureQ[ans],Throw[ans,seriesTag]];
     AppendTo[values,truncate[Normal[ans],ep,lo,hi]];Continue[]];
   ans=psHeavy[term,i,ep,lo,hi,pars,dom,timeLeft[],cache,baseRoot];
   If[FailureQ[ans],Throw[ans,seriesTag]];
   AppendTo[values,ans["Value"]];
   Scan[AppendTo[MBParameter`Private`$trace,Join[#,<|"Pass"->2|>]]&,ans["Trace"]],{i,Length[resolved]}];
 truncate[Total[values],ep,lo,hi]],seriesTag];

psExpandMain[f_,ep_Symbol,c_Association,lo_Integer,hi_Integer,seconds_,cache_]:=Catch[Module[
 {pars=c["Parameters"],dom=c["Assumptions"],red,ans,terms,values={},resolved,term,tor,candidates,prep,int,res,
 trialLog,completed,runRoot,dir,started=AbsoluteTime[],timeLeft,baseRoot=$PSNativeDirectory,psHelpers={{},None}},
 timeLeft[]:=Max[1,seconds-(AbsoluteTime[]-started)];
 If[Head[f]===Plus,
 terms=List@@f;Do[res=PSExpand[t,ep,Join[c,<|"Variables"->Complement[MBParameter`Private`symbols[Cases[t,Gamma[a_]:>a,Infinity]],Append[pars,ep]]|>],lo,hi,timeLeft[],cache];
 If[FailureQ[res],Throw[res,seriesTag]];AppendTo[values,res],{t,terms}];
 Return[truncate[Total[values],ep,lo,hi],Module]];
 red=MBParameter`MBParameterReduce[f,ep,"ExternalParameters"->pars,"ParameterAssumptions"->dom,
 "MBVariables"->c["Variables"],"ParameterTimeConstraint"->Min[45,timeLeft[]]];
 If[AssociationQ[red],ans=PSExactReducedSeries[red["Expression"],ep,lo,hi,pars];
 If[!FailureQ[ans]&&MBParameter`Private`exactQ[ans,Append[pars,ep]],
 AppendTo[MBParameter`Private`$trace,<|"Class"->"ExactBarnesThenEndpointSubtractedGauss","Reduction"->red,
 "Orders"->{lo,hi}|>];Return[ans,Module]]];
 resolved=MBParameter`Private`parameterResolve[f,ep,Min[90,timeLeft[]]];
 If[!ListQ[resolved],Throw[refuse["Fresh contour resolution failed",<|"Details"->resolved|>],seriesTag]];
 AppendTo[MBParameter`Private`$trace,<|"Class"->"FreshResolution","Source"->f,"Resolved"->resolved|>];
 If[DownValues[Global`mfrSameContourCensus]=!={} && !TrueQ[Global`$mfrDisabled],
   resolved=Global`mfrSameContourCensus[resolved];
   AppendTo[MBParameter`Private`$trace,<|"Class"->"ExactSameContourFamilyCensus","Occurrences"->Global`$mfrLastCensus|>]];
 (* release R3.1: a helper process (oft_residue_helper.wls) takes the queue in its own order; the main process starts
    the helpers for a queue with enough terms with folds (mbeResidueStore.m) and stops them at the end *)
 If[StringQ[Global`$psQueueOrder]&&Length[resolved]>1,resolved=resolved[[Global`orsPermute[Length[resolved],Global`$psQueueOrder]]]];
 psHelpers=If[DownValues[Global`orsPSLaunch]=!={},Global`orsPSLaunch[f,ep,c,lo,hi,timeLeft[],cache,resolved],{{},None}];
 Internal`WithLocalSettings[Null,
 (* 2026-09-29: the resolved list is a QUEUE; the general multifold handler may replace a multi-fold term by its exactly
    reduced terms (appended to the queue), each going through the same ladder *)
 i=0;While[i<Length[resolved],i++;term=resolved[[i]];
 If[TrueQ[Global`$orsHelperMode]&&TrueQ[Global`$psStopQ[]],Break[]];
 If[term[[2,2]]=!={} && DownValues[Global`mfrResidueZero]=!={} && !TrueQ[Global`$mfrDisabled],
   red=Global`mfrResidueZero[term[[1]],term[[2,2]],ep,hi,dom];
   If[AssociationQ[red],AppendTo[values,0];AppendTo[MBParameter`Private`$trace,Join[<|"Residue"->i|>,red]];Continue[]]];
 If[Length[term[[2,2]]]>1 && DownValues[Global`mfrReduce]=!={} && !TrueQ[Global`$mfrDisabled],
   red=Global`mfrReduce[term[[1]],term[[2,2]],ep,"Moves"->{"BarnesI"},"Assumptions"->dom,"Seconds"->Min[20,timeLeft[]]];
   If[AssociationQ[red]&&TrueQ[red["Reduced"]],
     AppendTo[MBParameter`Private`$trace,<|"Residue"->i,"Class"->"CertifiedMultifoldBarnesChain","Reduction"->red|>];
     term=ReplacePart[term,{1->red["Expression"],{2,2}->red["Contour"]}]]];
 (* 2026-09-29 GENERAL MULTIFOLD HANDLER, differential mode (mbeMultifoldHandler.m): stabilized finite-eps Barnes chains
    (first, second, collapsed generalized lemma, unimodular pivots) with the external parameter kept as a scale; a term that
    loses folds is replaced by its reduced terms (exact identities at the decision point, every output stabilized), which
    re-enter this ladder; no reduction -> the term continues unchanged. *)
 If[Length[term[[2,2]]]>1 && TrueQ[Global`$mfhEnabled] && !TrueQ[Global`$mfhParameterOff] && DownValues[Global`mfhReduce]=!={} &&
    !TrueQ[Global`$mfhActive] && Length[pars]===1 && !TrueQ[Lookup[term[[2,1]],"mfhReduced",False]],
   red=Block[{Global`$mfhActive=True},Quiet@Check[
     Global`mfhSetup[ep,"Target"->hi,"Low"->lo,"CloseSeconds"->Min[600,timeLeft[]],"BarnesSeconds"->Min[180,timeLeft[]],
       "Parameter"->First[pars],"ParallelPieces"->False];
     Global`mfhReduce[term[[1]],term[[2,2]]],$Failed]];
   AppendTo[MBParameter`Private`$trace,<|"Residue"->i,"Class"->"GeneralMultifoldHandlerAttempt","InputFolds"->Length[term[[2,2]]],
     "Outcome"->Which[!AssociationQ[red],ToString[Head[red]]<>If[FailureQ[red],": "<>ToString[red["Reason"]],""],
       Max[red["OutputFolds"]]<Length[term[[2,2]]],"reduced",True,"no fold removed"],
     "OutputFolds"->If[AssociationQ[red],red["OutputFolds"],None],"Trace"->If[AssociationQ[red],red["Trace"],None]|>];
   If[AssociationQ[red]&&ListQ[red["Terms"]]&&red["Terms"]=!={}&&Max[red["OutputFolds"]]<Length[term[[2,2]]],
     AppendTo[MBParameter`Private`$trace,<|"Residue"->i,"Class"->"GeneralMultifoldHandlerReduction","InputFolds"->Length[term[[2,2]]],
       "OutputFolds"->red["OutputFolds"],"Trace"->red["Trace"],"Source"->term|>];
     resolved=Join[resolved,Table[MBint[t[[1]],{Append[term[[2,1]],"mfhReduced"->True],t[[2]]}],{t,red["Terms"]}]];
     Continue[]]];
 If[term[[2,2]]==={},ans=PSGammaSeries[term[[1]],ep,hi];
 If[FailureQ[ans],Throw[ans,seriesTag]];
 AppendTo[values,truncate[Normal[ans],ep,lo,hi]];AppendTo[MBParameter`Private`$trace,<|"Residue"->i,"Class"->"ZeroFoldGammaBell"|>];Continue[]];
 (* release R3.1: the closing ladder of the term (psHeavyValue, below), read from the residue store when another process
    of this integral has closed it (mbeResidueStore.m); a helper skips a term it does not close *)
 ans=psHeavy[term,i,ep,lo,hi,pars,dom,timeLeft[],cache,baseRoot];
 If[FailureQ[ans],If[TrueQ[Global`$orsHelperMode],Continue[],Throw[ans,seriesTag]]];
 AppendTo[values,ans["Value"]];Scan[AppendTo[MBParameter`Private`$trace,#]&,ans["Trace"]];
 If[TrueQ[Global`$orsLastFromStore],AppendTo[MBParameter`Private`$trace,<|"Residue"->i,"Class"->"ResidueStore","Source"->term|>]]
 ];
 truncate[Total[values],ep,lo,hi],
 If[psHelpers[[1]]=!={},Global`orsStopHelpers[psHelpers[[1]],psHelpers[[2]]]]]
],seriesTag];

(* release R3.1: the closing ladder of ONE resolved term, unchanged in substance: the exact unscaled tower, the scaled
   tower with the damping variable (one fold), the high-fold ladder (more than three folds), the positive faithful
   cubes, and -- for at most three folds -- the corner-aware ladder when the plain cubes refuse.  Returns
   <|"Value" -> exact series, "Trace" -> {trace entries}|> or a Failure. *)
psHeavyValue[term_,i_,ep_,lo_,hi_,pars_,dom_,seconds_,cache_,baseRoot_]:=Catch[Module[
 {t0=AbsoluteTime[],timeLeft,tor,ans,candidates,trialLog={},prep,dir,int,refusedSets={}},
 timeLeft[]:=Max[1,seconds-(AbsoluteTime[]-t0)];
 tor=towerTerm[term,ep,lo,hi,pars,timeLeft[],cache];
 If[AssociationQ[tor]&&MBParameter`Private`exactQ[tor["Expression"],Append[pars,ep]],
   Throw[<|"Value"->tor["Expression"],"Trace"->{Join[<|"Residue"->i|>,KeyDrop[tor,"Expression"]]}|>,psHeavyTag]];
 If[Length[term[[2,2]]]===1 && DownValues[MBParameterSubtractionHF`Private`scaledTower]=!={},
   (* release R3.1 (4 October 2026): 900 s, was 90 s -- MB11u's residue 3 (a one-fold with the scale (1-u)^-z) closes
      exactly here in 92 s and fell through to closers that cannot close its psi^4 coefficient kernel *)
   tor=MBParameterSubtractionHF`Private`scaledTower[term,ep,lo,hi,pars,dom,Min[900,timeLeft[]]];
   If[!FailureQ[tor]&&MBParameter`Private`exactQ[tor,Append[pars,ep]],
     Throw[<|"Value"->tor,"Trace"->{<|"Residue"->i,"Class"->"ScaledTowerDampingVariable","Source"->term|>}|>,psHeavyTag]]];
 If[!AllTrue[pars,MBParameter`Private`prove[0<#<1,dom]&],
   Throw[refuse["Faithful parameter cubes require external parameters in the open unit interval"],psHeavyTag]];
 If[Length[term[[2,2]]]>3 && DownValues[MBParameterSubtractionHF`PSHResidue]=!={},
   ans=MBParameterSubtractionHF`PSHResidue[term,i,ep,lo,hi,pars,timeLeft[],cache];
   If[!FailureQ[ans],Throw[<|"Value"->ans,"Trace"->{<|"Residue"->i,"Class"->"HighFoldFaithfulEulerSubtraction","Source"->term|>}|>,psHeavyTag]];
   (* a refused high-fold term goes to the last closer below, as every other term *)
   AppendTo[trialLog,ans];
   ans=psStandardTerm[term,i,ep,lo,hi,pars,dom,timeLeft[]];
   Throw[If[FailureQ[ans],refuse["High-fold term refused by the high-fold ladder and the per-residue Standard closer",
     <|"Residue"->i,"Trials"->Append[trialLog,ans]|>],
     Join[ans,<|"Trace"->{Join[First[ans["Trace"]],<|"RefusedTrials"->trialLog|>]}|>]],psHeavyTag]];
 candidates=PSCubeCandidates[term,ep,pars];
 (* a residue of at most three folds that the plain cube ladder cannot close (no positive construction without
    corners, or no complete candidate) goes to the corner-aware ladder of mbeParameterSubtractionHighFold.m (candidate
    search over orders and plans, sector decomposition of corners), with the same gates; only its refusal refuses *)
 If[FailureQ[candidates],AppendTo[trialLog,candidates];candidates={}];
 Do[prep=PSPrepareCube[candidate,ep,lo,hi,pars];If[FailureQ[prep],AppendTo[trialLog,prep];Continue[]];
   dir=If[StringQ[baseRoot],FileNameJoin[{baseRoot,"residue_"<>ToString[i],"trial_"<>ToString[Length[trialLog]+1]}],CreateDirectory[]];
   If[!DirectoryQ[dir],CreateDirectory[dir,CreateIntermediateDirectories->True]];
   Put[prep,FileNameJoin[{dir,"prepared.m"}]];
   int=Block[{$PSNativeDirectory=dir},PSIntegrateJobs[prep["Jobs"],pars,timeLeft[],cache]];
   If[FailureQ[int],AppendTo[trialLog,int];AppendTo[refusedSets,psJobSetKey[prep["Jobs"]]];Continue[]];
   ans=PSAssembleCube[prep,int["Values"],ep,lo,hi];
   If[!MBParameter`Private`exactQ[ans,Append[pars,ep]],AppendTo[trialLog,refuse["Cube assembly exactness contract"]];Continue[]];
   Throw[<|"Value"->ans,"Trace"->{<|"Residue"->i,"Class"->"ParameterFaithfulEulerSubtraction",
     "PrefactorLead"->prep["PrefactorLead"],"CubeRange"->prep["CubeRange"],"Cube"->prep["Cube"],
     "Variables"->prep["Variables"],"Source"->term,"PositivityProofs"->prep["PositivityProofs"],
     "AffineLeafProofs"->prep["AffineLeafProofs"],"Orders"->candidate["Order"],"Plan"->candidate["Plan"],
     "Native"->KeyDrop[int,"Values"],"RefusedTrials"->trialLog|>}|>,psHeavyTag],{candidate,candidates}];
 If[DownValues[MBParameterSubtractionHF`PSHResidue]=!={},
   (* release R3.1 (4 October 2026): the job sets refused above go with the call, so that the high-fold ladder does not
      integrate the same corner-free cubes a second time *)
   ans=Block[{MBParameterSubtractionHF`$PSHRefusedJobSets=refusedSets},
     MBParameterSubtractionHF`PSHResidue[term,i,ep,lo,hi,pars,timeLeft[],cache]];
   If[!FailureQ[ans],Throw[<|"Value"->ans,"Trace"->{<|"Residue"->i,"Class"->"HighFoldFaithfulEulerSubtraction",
     "Source"->term,"After"->"PlainCubeLadderRefused","RefusedTrials"->trialLog|>}|>,psHeavyTag]];
   AppendTo[trialLog,ans]];
 (* the last closer of a term every closer above refused: the per-residue Standard closer (psStandardTerm) *)
 ans=psStandardTerm[term,i,ep,lo,hi,pars,dom,timeLeft[]];
 If[!FailureQ[ans],Throw[Join[ans,<|"Trace"->{Join[First[ans["Trace"]],<|"RefusedTrials"->trialLog|>]}|>],psHeavyTag]];
 AppendTo[trialLog,ans];
 refuse["No certified complete cube closure",<|"Residue"->i,"Trials"->trialLog|>]],psHeavyTag];

(* release R3.1: the PER-RESIDUE STANDARD CLOSER of this ladder, for a term that every Subtraction closer above refused
   -- the rule the inclusive Subtraction route has always had for its residues (mbeOneFoldTowerRung.m: the multi-fold
   slot falls back to the per-residue Standard closer).  The term is expanded at ITS OWN contour (MBexpand), and every
   eps-free coefficient kernel is closed by the closer of the external-parameter Standard route,
   MBParameter`Private`closePiece (exact, with its source gate), exactly as MBParameter`Private`resolvedExpansion does
   for a whole source.  Only the WHOLE-integral fallback to the Standard route is excluded from the Subtraction route;
   this one closes one residue and is recorded in the trace ("PerResidueStandardCloser"). *)
psStandardTerm[term_,i_,ep_,lo_,hi_,pars_,dom_,seconds_]:=Catch[Module[
 {xx,ctr,vars,terms,power,coefficient,constant,kernel,key,value,total=0,count=0,t0=AbsoluteTime[]},
 If[DownValues[MBParameter`Private`closePiece]==={},Throw[refuse["No per-residue Standard closer installed"],psStdTag]];
 xx=Quiet@MB`MBexpand[{term},1,{ep,0,hi}];
 If[!ListQ[xx]||!AllTrue[xx,MatchQ[#,MB`MBint[_,{_,_List}]]&],Throw[refuse["Per-residue Standard closer: expansion failed"],psStdTag]];
 Do[ctr=part[[2,2]]/.r_Real:>SetPrecision[r,Infinity];vars=First/@ctr;
   terms=If[Head[Expand[part[[1]]]]===Plus,List@@Expand[part[[1]]],{Expand[part[[1]]]}];
   Do[power=Exponent[Numerator[Together[tm]],ep]-Exponent[Denominator[Together[tm]],ep];
     If[!IntegerQ[power],Throw[refuse["Per-residue Standard closer: noninteger Laurent order"],psStdTag]];
     If[power<lo||power>hi,Continue[]];
     coefficient=Cancel[tm/ep^power];
     If[!FreeQ[coefficient,ep],Throw[refuse["Per-residue Standard closer: regulator left in a coefficient"],psStdTag]];
     constant=Times@@Select[MBParameter`Private`factors[coefficient],FreeQ[#,Alternatives@@vars]&];
     kernel=Times@@Select[MBParameter`Private`factors[coefficient],!FreeQ[#,Alternatives@@vars]&];
     key=Hash[{kernel,ctr,pars,dom},"SHA256"];
     value=If[AssociationQ[MBParameter`Private`$pieceValues]&&KeyExistsQ[MBParameter`Private`$pieceValues,key],
       MBParameter`Private`$pieceValues[key],
       If[vars==={},kernel,MBParameter`Private`closePiece[kernel,ctr,vars,pars,dom,
         Max[1,Min[Which[Length[vars]>=4,1200,True,600],seconds-(AbsoluteTime[]-t0)]]]]];
     If[FailureQ[value],Throw[refuse["Per-residue Standard closer: a coefficient kernel failed",
       <|"Order"->power,"Kernel"->kernel,"Contour"->ctr,"Cause"->value|>],psStdTag]];
     If[AssociationQ[MBParameter`Private`$pieceValues],AssociateTo[MBParameter`Private`$pieceValues,key->value]];
     total+=constant ep^power value;count++,{tm,terms}],{part,xx}];
 total=truncate[total,ep,lo,hi];
 If[!MBParameter`Private`exactQ[total,Append[pars,ep]],Throw[refuse["Per-residue Standard closer: exactness contract"],psStdTag]];
 <|"Value"->total,"Trace"->{<|"Residue"->i,"Class"->"PerResidueStandardCloser","Source"->term,"Kernels"->count|>}|>],psStdTag];
psHeavy[args___]:=If[DownValues[Global`orsPSHeavy]=!={},Global`orsPSHeavy[args],psHeavyValue[args]];
End[];EndPackage[];
Print["[mbeParameterSubtractionDispatch] exact source reductions, unscaled towers and parameter Euler subtraction."];
