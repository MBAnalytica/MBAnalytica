(* mbeDiogenesFallback.m  (2026-09-27) -- the DIFFERENTIAL-EQUATION expansion of a hypergeometric block as the fallback
   of the HypExp block expander hbbExpand (mbeHypExpBlockBank.m).
   DIOGENES (M. A. Bezuglov, A. I. Onishchenko, arXiv:2312.06242) writes the pFq as a Fuchsian system for (F, theta F, ...),
   reduces it to eps-form by Lee's algorithm (with the rational variable changes of its Table 1 when the eigenvalues are
   rational, e.g. z = z2^2 for half-integer lower parameters), and integrates it in multiple polylogarithms with the boundary
   value F(0) = 1.  It covers blocks on which HypExp returns a failure marker (half-integer classes beyond its tables).
   Used only when HypExp fails; runs in its OWN subkernel (DIOGENES redefines Appell symbols of the main stack).
   Output admitted: letters in {0, 1, -1}, variable = the block argument (Case A) or its square root (Case C, z2[2, zz]);
   G[{a..}, v] -> (-1)^#(a = 1) HPL[{a..}, v] (a-notation).  Argument c x (x the radial variable) with c > 0, or a positive
   number.  Everything else refuses ($Failed), and the caller keeps its refusal. *)
(* the DIOGENES package directory (DIOGENES.wl; GPL-3.0, not shipped with the release): Global`$MBStandardDiogenesPath when
   set, else <package root>/vendor/DIOGENES; when the directory is absent the fallback is NOT installed and the block
   expanders keep their own refusals (no value depends on it: the exact results of the record were obtained without it) *)
If[!ValueQ[$diogPath],$diogPath=If[StringQ[Global`$MBStandardDiogenesPath],Global`$MBStandardDiogenesPath,
  FileNameJoin[{ParentDirectory[DirectoryName[$InputFileName]],"vendor","DIOGENES"}]]];
$diogAvailableQ=DirectoryQ[$diogPath]&&FileExistsQ[FileNameJoin[{$diogPath,"DIOGENES.wl"}]];
If[!ValueQ[$diogKernel],$diogKernel=None];
If[!ValueQ[$diogBudget],$diogBudget=600];
If[!ValueQ[$diogLog],$diogLog={}];
diogEnsure[]:=Module[{},
  If[$diogKernel===None||!MemberQ[Kernels[],$diogKernel],
    $diogKernel=First[LaunchKernels[1]];
    ParallelEvaluate[SetDirectory[$diogPath];Quiet[Get["DIOGENES.wl"]];SetDirectory[$HomeDirectory],$diogKernel]];
  $diogKernel];
diogFail[why_]:=(AppendTo[$diogLog,why];$Failed);
(* the spool client: $diogServiceSpool = the directory served by diog_service.wls (heartbeat service_alive.txt) *)
If[!ValueQ[$diogServiceSpool],$diogServiceSpool=None];
diogServiceQ[]:=StringQ[$diogServiceSpool]&&DirectoryQ[$diogServiceSpool]&&FileExistsQ[FileNameJoin[{$diogServiceSpool,"service_alive.txt"}]];
diogServiceExpand[req_,depth_]:=Module[{id,rf,resf,t0=AbsoluteTime[],r,str},
  id=IntegerString[$ProcessID,36]<>"_"<>IntegerString[Round[AbsoluteTime[] 1000],36]<>"_"<>IntegerString[RandomInteger[10^6],36];
  rf=FileNameJoin[{$diogServiceSpool,"req_"<>id<>".m"}];resf=FileNameJoin[{$diogServiceSpool,"res_"<>id<>".m"}];
  str=Block[{$ContextPath={"System`"}},ToString[req,InputForm]];
  Put[{"PFQ"->str,"Depth"->depth,"Budget"->$diogBudget},rf<>".tmp"];RenameFile[rf<>".tmp",rf];
  While[!FileExistsQ[resf]&&AbsoluteTime[]-t0<$diogBudget+90,Pause[0.5]];
  If[!FileExistsQ[resf],Quiet@DeleteFile[rf];AppendTo[$diogLog,"service timeout"];Return[$Failed,Module]];
  r=Quiet@Check[Get[resf],$Failed];Quiet@DeleteFile[resf];
  If[!ListQ[r]||Lookup[r,"Result","$Failed"]==="$Failed",Return[$Failed,Module]];
  Quiet@Check[ToExpression[Lookup[r,"Result"],InputForm],$Failed]];
diogExpand[qq_,ep_,depth_Integer,radial_:None]:=Catch[Module[{num,den,arg,c,zz=Global`diogZZ,eD=Global`diogEps,req,res,
    conv,letters,vars,ok},
  If[Head[qq]=!=HypergeometricPFQ||Length[qq]=!=3,Throw[diogFail["not a pFq"],"dg"]];
  {num,den,arg}=List@@qq;
  c=If[radial=!=None&&!FreeQ[arg,radial],Together[arg/radial],arg];
  If[!(NumericQ[c]&&Element[c,Reals]&&c=!=0),Throw[diogFail["argument coefficient not a nonzero real: "<>ToString[arg,InputForm]],"dg"]];
  If[radial=!=None&&!FreeQ[arg,radial]&&!FreeQ[c,radial],Throw[diogFail["argument not linear in the radial variable"],"dg"]];
  req=HypergeometricPFQ[num/.ep->eD,den/.ep->eD,zz];
  (* 1 October 2026: the SPOOL SERVICE first (diog_service.wls in its own main kernel; no subkernel of the shared pool,
     whose exhaustion by the piece workers or a regression left this fallback dead or crashed the caller); the subkernel
     path when no service is running *)
  res=If[diogServiceQ[],diogServiceExpand[req,depth],
    diogEnsure[];
    ParallelEvaluate[Quiet@TimeConstrained[Normal[DIOGENES`ExpandHypergeometry[req,eD,depth]],$diogBudget,$Failed],$diogKernel]];
  If[res===$Failed||!FreeQ[res,HypergeometricPFQ|DIOGENES`HypergeometricPFQHold|$Aborted],Throw[diogFail["DIOGENES did not expand the block"],"dg"]];
  (* Case C square roots; any other variable change refuses *)
  res=res/.{DIOGENES`z2[2,zz]:>Sqrt[zz]};
  If[!FreeQ[res,DIOGENES`z1|DIOGENES`z2|DIOGENES`z3|DIOGENES`z4|DIOGENES`f],Throw[diogFail["variable change outside cases A, C"],"dg"]];
  letters=DeleteDuplicates[Flatten[Cases[res,DIOGENES`G[l_List,_]:>l,{0,Infinity}]]];
  vars=DeleteDuplicates[Cases[res,DIOGENES`G[_,v_]:>v,{0,Infinity}]];
  If[!SubsetQ[{0,1,-1},letters],Throw[diogFail["letters outside {0,1,-1}: "<>ToString[letters]],"dg"]];
  If[!SubsetQ[{zz,Sqrt[zz]},vars],Throw[diogFail["G variable outside {z, sqrt z}: "<>ToString[vars,InputForm]],"dg"]];
  (* a negative argument is admitted only without square roots (Case A: HPLs at a negative argument are alternating sums) *)
  If[c<0&&!FreeQ[res,Sqrt[zz]],Throw[diogFail["square root of a negative argument"],"dg"]];
  conv=res/.DIOGENES`G[l_List,v_]:>(-1)^Count[l,1] HPL`HPL[l,v];
  conv=conv/.zz->If[radial===None,c,c radial]/.eD->ep;
  (* numerical check of the whole conversion at a small argument and a small eps against the defining series (a gate, never
     a producer): the truncation error is O(eps^(depth+1)) *)
  ok=Module[{pt=If[radial===None,{},{radial->1/7}],e1=1/997,lhs,exact},
    If[radial===None&&Abs[c]>=1,True,
      exact=N[(qq/.pt)/.ep->e1,40];
      lhs=N[(conv/.pt)/.ep->e1,40];
      TrueQ[NumericQ[exact]&&Abs[lhs-exact]<10^(-3 (depth+1)+2) Max[1,Abs[exact]]]]];
  If[!ok,Throw[diogFail["conversion check failed"],"dg"]];
  AppendTo[$diogLog,"expanded "<>ToString[Short[qq,3],InputForm]];
  Expand[conv]],"dg"];

(* the wrapper: HypExp first (with its bank); on a failure marker or an unexpanded block, DIOGENES *)
If[TrueQ[$diogAvailableQ]&&DownValues[Global`hbbExpand]=!={}&&!ValueQ[$diogWrapped],
  $diogWrapped=True;
  DownValues[Global`hbbExpandHypExp]=DownValues[Global`hbbExpand]/.HoldPattern[Global`hbbExpand]:>Global`hbbExpandHypExp;
  Global`hbbExpand[qq_,ep_,depth_Integer,budget_,radial_:None]:=Module[{r=Global`hbbExpandHypExp[qq,ep,depth,budget,radial],ex,d},
    ex=Lookup[r,"Expansion",$Failed];
    If[!FreeQ[ex,$Failed|$Aborted|HypergeometricPFQ|Hypergeometric2F1|HypExp`HypExp]||
       !FreeQ[ex,s_Symbol/;StringContainsQ[SymbolName[Unevaluated[s]],"Failed"],{0,Infinity},Heads->True],
      d=diogExpand[qq,ep,depth,radial];
      If[d=!=$Failed,Print["    [diogenes] block expanded by the differential equation (eps-form): ",InputForm[Short[qq,3]]];
        r=<|"Seconds"->0,"Expansion"->d,"Cached"->False,"Depth"->depth,"Engine"->"DIOGENES"|>]];
    r];
  Print["[mbeDiogenesFallback] DIOGENES (pFq differential system in eps-form) installed as the fallback of hbbExpand."]];
(* the same fallback in the one-fold rungs' block expander (the parallel path calls HypExp directly, and a failure marker
   $HypExpFailed inside an expansion was not recognized there) *)
diogFailSymQ[x_]:=!FreeQ[x,s_Symbol/;StringContainsQ[SymbolName[Unevaluated[s]],"Failed"],{0,Infinity},Heads->True];
If[TrueQ[$diogAvailableQ]&&DownValues[Global`oftExpandBlocks]=!={}&&!ValueQ[$diogWrappedOFT],
  $diogWrappedOFT=True;
  DownValues[Global`oftExpandBlocksHypExp]=DownValues[Global`oftExpandBlocks]/.HoldPattern[Global`oftExpandBlocks]:>Global`oftExpandBlocksHypExp;
  Global`oftExpandBlocks[blocks_List,eps_,verbose_]:=Module[{r=Global`oftExpandBlocksHypExp[blocks,eps,verbose],need,bad,fixed,ok=True},
    need=Merge[Table[Association[b["PFQ"]->b["Depth"]],{b,blocks}],Max];
    If[AssociationQ[r],
      bad=Select[Keys[r],diogFailSymQ[r[#]]||!FreeQ[r[#],HypergeometricPFQ|HypExp`HypExp]&];
      If[bad==={},Return[r,Module]];
      fixed=r;
      Do[With[{d=diogExpand[k,eps,need[k],None]},
          If[d===$Failed,ok=False;Break[]];Print["    [diogenes] tower block expanded by the differential equation: ",InputForm[Short[k,3]]];fixed[k]=d],{k,bad}];
      If[ok,fixed,$Failed],
      (* HypExp refused a block outright: every block again, serially, through hbbExpand (HypExp, then DIOGENES) *)
      Module[{res=Association@Table[k->Lookup[Global`hbbExpand[k,eps,need[k],Global`$oftHypExpBudget],"Expansion",$Failed],{k,Keys[need]}]},
        If[AnyTrue[Values[res],!FreeQ[#,$Failed|$Aborted|HypergeometricPFQ|HypExp`HypExp]||diogFailSymQ[#]&],$Failed,res]]]];
  Print["[mbeDiogenesFallback] DIOGENES installed as the fallback of the one-fold rungs' block expander (oftExpandBlocks)."]];
If[!TrueQ[$diogAvailableQ],Print["[mbeDiogenesFallback] DIOGENES not found (",$diogPath,"): the differential-equation fallback of the block expanders is not installed."]];
