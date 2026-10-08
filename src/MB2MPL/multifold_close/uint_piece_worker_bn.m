(* uint_piece_worker_bn.m  (2026-09-27; robust worker 2026-10-01) -- subkernel worker of the Mellin-space
   route (one-fold AND multi-fold eps-free MB pieces, polygamma-dressed allowed).  File protocol as the package's
   mbt_piece_worker.m: the master writes <job>/meta.m and <job>/p_####.m (<|"F" -> integrand, "Contour" -> {z -> c}|>),
   sets Global`$ladJobRoot (and $ladStride) in every subkernel and sends Get of this file to each of them.
   ROBUST PROTOCOL (1 October 2026):
     - a worker takes a SLOT by an atomic directory creation (<job>/slot_<i>; i is its index and log name w_<i>.log); the
       old per-kernel assignment Global`$ladLO is honoured when the master still sets it;
     - pieces are CLAIMED dynamically (<job>/claim_####, atomic): the worker first walks its affinity list (assign_<i>.m,
       pieces of one Gamma kernel, when the master wrote one) and then every other piece, so no worker idles while another
       holds a serial queue; a piece with an r_ file or a claim is skipped; a STOP file ends the loop;
     - a HEARTBEAT <job>/hb_<i>.m names the piece and closer stage the worker is in (for the master's deadline census);
     - the closer chain and the exact rewrites are those of uint_piece_chain.m (budgets from meta: "Seconds" ladder,
       "S2Seconds" slope-two closer, "UnitSeconds" unit tower, "PieceSeconds" total per piece); every served value is gated
       by the contour quadrature of the piece and every refusal reason is written to the r_ file.
   Output goes to <job>/w_<i>.log (never through the MathLink: see the package's note on ginsh stderr floods). *)
Off[General::shdw];
ladJob=Global`$ladJobRoot;ladStride=Global`$ladStride;
ladSlot=If[IntegerQ[Global`$ladLO],Global`$ladLO,
  SelectFirst[Range[1,1024],Quiet@CreateDirectory[FileNameJoin[{ladJob,"slot_"<>ToString[#]}]]=!=$Failed&,0]];
ladLO=ladSlot;
ladLog=OpenWrite[FileNameJoin[{ladJob,"w_"<>ToString[ladLO]<>".log"}],FormatType->OutputForm];
$Output={ladLog};$Messages={ladLog};
Unprotect[WriteString];WriteString["stdout",a___]:=WriteString[ladLog,a];Protect[WriteString];
With[{ini=FileNameJoin[{$UserBaseDirectory,"Kernel","init.m"}]},If[FileExistsQ[ini],Quiet@Get[ini]]];
ladMeta=Get[FileNameJoin[{ladJob,"meta.m"}]];
Global`$HistoryLength=0;Global`$MBSerialPieceKernels=0;Global`$fcuMaxWorkers=0;Global`$IV$NoLibrary=True;
Global`$oftNoSubkernels=True;Global`$fcuNoSubkernels=True;
SetDirectory[ladMeta["pkgDir"]];
Get[If[FileExistsQ["load_standard_w10.m"],"load_standard_w10.m","load_standard.m"]];Get["mbeMellinTowerRung.m"];   (* development or release loader *)
If[!StringQ[ladJob]||!IntegerQ[ladLO]||!AssociationQ[ladMeta],
  Print["[ladder-worker] job parameters lost after the loader"];Close[ladLog];Abort[]];
ladEp=ladMeta["Regulator"];
Quiet@MBtoMPL`MBresolveToMPL[Gamma[1+ladEp]^2/Gamma[1+2 ladEp],ladEp,"EpsOrderMin"->0,"EpsOrderMax"->0,"Route"->"Standard",
  "Verbose"->False,"DiskCache"->False,"UseCertifiedLibrary"->False];
MBtoMPL`Private`$mbtUseMB2MPLDiskCache=False;MBtoMPL`Private`$mbtUseDoABCache=False;MBtoMPL`Private`$mbtUseCertifiedLibrary=False;
(* a subkernel cannot launch subkernels: the package would fall back to separate math PROCESSES (main-kernel seats,
   beyond the user's 10-main-kernel cap).  Every inner piece closure runs serially in this worker. *)
MBtoMPL`Private`$mbtPieceKernels=0;Global`$mbtSubkernelCap=0;Global`$mbtWorkerMode="Subkernels";
(* 2 October 2026: the release's launcher fell back to process workers all the same (27 of 40 pool workers started main
   kernels); the flag makes it close a nested request in this worker *)
Global`$mbtNestedInWorker=True;
Print["[ladder-worker] subkernel ",$KernelID," PID ",$ProcessID," slot ",ladLO," ready ",DateString[]];
(* budgets *)
ladSec[key_,d_]:=With[{v=Lookup[ladMeta,key,d]},If[NumericQ[v]&&v>0,v,d]];
ladLadderSec=ladSec["Seconds",300];ladS2Sec=ladSec["S2Seconds",2400];ladUnitSec=ladSec["UnitSeconds",1800];ladPieceSec=ladSec["PieceSeconds",3600];
(* the closed forms, the slope-two closer and the unit tower; their globals: the regulator ep, the decision point e0, the
   closer time, the library directory *)
ladLibDir=ladMeta["libDir"]/.Missing[__]:>FileNameJoin[{ladMeta["pkgDir"],If[DirectoryQ[FileNameJoin[{ladMeta["pkgDir"],"multifold_close"}]],"multifold_close","differential_u_subtraction_to14_20260922"]}];
Get[FileNameJoin[{ladLibDir,"uint_b22_lib.m"}]];Get[FileNameJoin[{ladLibDir,"uint_bn_lib.m"}]];If[FileExistsQ[FileNameJoin[{ladLibDir,"uint_bg_lib.m"}]],Get[FileNameJoin[{ladLibDir,"uint_bg_lib.m"}]]];
(* 2 October 2026: the shared names of the closer libraries are bound through the SAME resolution the libraries use (after
   the loader a bare ep is MB`ep and a bare eta PolyLogTools`eta; the handler's mfhSetName does this in the main kernel).
   An explicit Global`ep left the libraries' regulator unbound in the workers: every closer that hands a kernel carrying
   the regulator to the Mellin tower (the Euler copy route of the two-fold closer, the jet rung's tower and psi-integral
   engines) refused in a worker while it passed in a main kernel (MB8au residue 43, pieces 71 and 79, 1 October). *)
ladSetName[name_String,val_]:=With[{h=ToExpression[name,InputForm,Hold]},Set@@Join[h,Hold[val]]];
ladSetName["ep",ladEp];ladSetName["e0",-1/40];ladSetName["eta",1/160];ladSetName["closeSeconds",ladLadderSec];
Global`ep=ladEp;Global`e0=-1/40;Global`eta=1/160;Global`closeSeconds=ladLadderSec;Global`$closeLibDir=ladLibDir;
SetEnvironment["MBE_L6_ACCEPT_BASIS"->"1"];
If[DownValues[Global`bwsL6Reduce]==={}&&FileExistsQ[FileNameJoin[{ladMeta["pkgDir"],"mbeLevel6Reduce.m"}]],Get[FileNameJoin[{ladMeta["pkgDir"],"mbeLevel6Reduce.m"}]]];
If[FileExistsQ[FileNameJoin[{ladLibDir,"uint_fcu_s2.m"}]],Quiet@Get[FileNameJoin[{ladLibDir,"uint_fcu_s2.m"}]]];
ladHeart[k_,stage_]:=Quiet@Put[<|"piece"->k,"stage"->stage,"since"->AbsoluteTime[],"date"->DateString[]|>,FileNameJoin[{ladJob,"hb_"<>ToString[ladLO]<>".m"}]];
Get[FileNameJoin[{ladLibDir,"uint_piece_chain.m"}]];
(* 2026-10-01: the general two-fold closer (psi split, Gamma copies by a finite-regulator Barnes lemma, generalized Barnes ->
   Euler kernel -> Mellin tower -> exact last fold), consulted by the chain's multi-fold branch after the iterated 2+2 *)
If[FileExistsQ[FileNameJoin[{ladLibDir,"uint_gb_euler.m"}]],Quiet@Get[FileNameJoin[{ladLibDir,"uint_gb_euler.m"}]]];
If[FileExistsQ[FileNameJoin[{ladLibDir,"uint_jet_rung.m"}]],Quiet@Get[FileNameJoin[{ladLibDir,"uint_jet_rung.m"}]]];ladJetSec=ladSec["JetSeconds",2400];
(* ---- the work loop: affinity list first, then every piece; claims are atomic directories ---- *)
ladN=ladMeta["nPieces"];
ladMine=With[{af=FileNameJoin[{ladJob,"assign_"<>ToString[ladLO]<>".m"}]},If[FileExistsQ[af],Quiet@Check[Get[af],{}],{}]];
ladOrder=DeleteDuplicates[Join[If[ListQ[ladMine],ladMine,{}],Range[1,ladN]]];
ladClaimQ[k_]:=Quiet@CreateDirectory[FileNameJoin[{ladJob,"claim_"<>IntegerString[k,10,4]}]]=!=$Failed;
Do[Module[{pf=FileNameJoin[{ladJob,"p_"<>IntegerString[k,10,4]<>".m"}],rf=FileNameJoin[{ladJob,"r_"<>IntegerString[k,10,4]<>".m"}],p,t0=AbsoluteTime[],r,res},
    If[!FileExistsQ[pf]||FileExistsQ[rf]||FileExistsQ[FileNameJoin[{ladJob,"STOP"}]],Continue[]];
    If[!ladClaimQ[k],Continue[]];
    p=Get[pf];
    r=Quiet@Check[ladClosePiece[p["F"],Normal[p["Contour"]],k],Failure["Piece",<|"Reason"->"messages/abort in the worker"|>]];
    res=If[AssociationQ[r]&&ladExactQ[r["Value"]],
      <|"status"->"Clean","value"->Global`mbeCanonicalConstants[r["Value"]],"seconds"->Round[AbsoluteTime[]-t0],"method"->r["Method"],"quad"->ToString[N[r["Quad"],15],InputForm],"worker"->ladLO|>,
      <|"status"->"Failed","reason"->ladReason[r],"seconds"->Round[AbsoluteTime[]-t0],"worker"->ladLO|>];
    Put[res,rf<>".tmp"];RenameFile[rf<>".tmp",rf,OverwriteTarget->True];
    Print["[ladder-worker] piece ",k,": ",res["status"]," in ",res["seconds"]," s",If[res["status"]==="Clean"," ("<>res["method"]<>")"," -- "<>StringTake[res["reason"],UpTo[600]]]]],
  {k,ladOrder}];
ladHeart[0,"done"];
Put[<|"slot"->ladLO,"date"->DateString[]|>,FileNameJoin[{ladJob,"done_"<>ToString[ladLO]<>".m"}]];
Print["[ladder-worker] slot ",ladLO," done ",DateString[]];
Close[ladLog];
