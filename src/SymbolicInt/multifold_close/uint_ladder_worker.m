(* uint_ladder_worker.m  (2026-09-27) -- subkernel worker of the Mellin-space route: closes eps-free ONE-FOLD MB
   pieces (polygamma-dressed allowed) by the one-fold tower ladder of the theory (MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent:
   towers both directions, regulated copies for the dressing).  File protocol as the package's mbt_piece_worker.m:
   the master writes <job>/meta.m and <job>/p_####.m (<|"F" -> integrand, "Contour" -> {z -> c}|>), sets
   Global`$ladJobRoot / $ladLO / $ladStride in each subkernel, and runs this file; the worker handles pieces
   k = LO, LO + STRIDE, ... and writes r_####.m <|"status" -> "Clean" | "Failed", "value" -> exact value|> atomically.
   Output goes to <job>/w_<LO>.log (never through the MathLink: see the package's note on ginsh stderr floods). *)
Off[General::shdw];
ladJob=Global`$ladJobRoot;ladLO=Global`$ladLO;ladStride=Global`$ladStride;
ladLog=OpenWrite[FileNameJoin[{ladJob,"w_"<>ToString[ladLO]<>".log"}],FormatType->OutputForm];
$Output={ladLog};$Messages={ladLog};
Unprotect[WriteString];WriteString["stdout",a___]:=WriteString[ladLog,a];Protect[WriteString];
With[{ini=FileNameJoin[{$UserBaseDirectory,"Kernel","init.m"}]},If[FileExistsQ[ini],Quiet@Get[ini]]];
ladMeta=Get[FileNameJoin[{ladJob,"meta.m"}]];
Global`$HistoryLength=0;Global`$MBSerialPieceKernels=0;Global`$fcuMaxWorkers=0;Global`$IV$NoLibrary=True;
Global`$oftNoSubkernels=True;Global`$fcuNoSubkernels=True;
SetDirectory[ladMeta["pkgDir"]];
Get[If[FileExistsQ["load_standard_w10.m"],"load_standard_w10.m","load_standard.m"]];Get["mbeMellinTowerRung.m"];   (* development or release loader *)
If[!StringQ[ladJob]||!IntegerQ[ladLO]||!IntegerQ[ladStride]||!AssociationQ[ladMeta],
  Print["[ladder-worker] job parameters lost after the loader"];Close[ladLog];Abort[]];
ladEp=ladMeta["Regulator"];
Quiet@MBAnalytica`SymbolicInt`MBresolveToMPL[Gamma[1+ladEp]^2/Gamma[1+2 ladEp],ladEp,"EpsOrderMin"->0,"EpsOrderMax"->0,"Route"->"Standard",
  "Verbose"->False,"DiskCache"->False,"UseCertifiedLibrary"->False];
MBAnalytica`SymbolicInt`Private`$mbtUseMBSymbolicIntDiskCache=False;MBAnalytica`SymbolicInt`Private`$mbtUseDoABCache=False;MBAnalytica`SymbolicInt`Private`$mbtUseCertifiedLibrary=False;
(* a subkernel cannot launch subkernels: the package would fall back to separate math PROCESSES (main-kernel seats,
   beyond the user's 10-main-kernel cap).  Every inner piece closure runs serially in this worker. *)
MBAnalytica`SymbolicInt`Private`$mbtPieceKernels=0;Global`$mbtSubkernelCap=0;Global`$mbtWorkerMode="Subkernels";
Print["[ladder-worker] subkernel ",$KernelID," PID ",$ProcessID," LO=",ladLO," STRIDE=",ladStride," ready ",DateString[]];
ladExactQ[x_]:=FreeQ[x,_Real|$Failed|$Aborted|$TimedOut|Indeterminate|ComplexInfinity|DirectedInfinity|_MBint|_HypergeometricPFQ|_SeriesData|_Missing|_Failure];
(* the pieces assigned to this worker (grouped by Gamma kernel by the master); stride fallback *)
ladMine=With[{af=FileNameJoin[{ladJob,"assign_"<>ToString[ladLO]<>".m"}]},If[FileExistsQ[af],Get[af],Range[ladLO,ladMeta["nPieces"],ladStride]]];
(* 2026-09-27 03:30: the Barnes 2+2 closed form (uint_b22_lib.m: one Gamma copy per polygamma, first lemma with Newton
   expansion and crossed residues, quadrature-gated) is tried FIRST -- about 1 s per piece against 50-300 s in the ladder,
   identical values on every piece both close; the ladder remains the fallback for the pieces outside the 2+2 class *)
ladB22=FileNameJoin[{ladMeta["libDir"]/.Missing[__]:>FileNameJoin[{ladMeta["pkgDir"],If[DirectoryQ[FileNameJoin[{ladMeta["pkgDir"],"multifold_close"}]],"multifold_close","differential_u_subtraction_to14_20260922"]}],"uint_b22_lib.m"}];
If[FileExistsQ[ladB22],Get[ladB22]];
Do[Module[{pf=FileNameJoin[{ladJob,"p_"<>IntegerString[k,10,4]<>".m"}],rf=FileNameJoin[{ladJob,"r_"<>IntegerString[k,10,4]<>".m"}],p,fam,t0=AbsoluteTime[],res,b22},
    If[!FileExistsQ[pf]||FileExistsQ[rf],Continue[]];
    p=Get[pf];
    b22=If[DownValues[b22Gated]=!={}&&FreeQ[p["F"],ladEp],Quiet@b22Gated[p["F"],p["Contour"],120],Failure["B22",<|"Reason"->"not loaded"|>]];
    res=If[AssociationQ[b22]&&ladExactQ[b22["Value"]],
      <|"status"->"Clean","value"->Global`mbeCanonicalConstants[b22["Value"]],"seconds"->Round[AbsoluteTime[]-t0],"method"->"barnes22"|>,
      fam=Quiet@TimeConstrained[MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[{MBint[p["F"],{{ladEp->0},p["Contour"]}]},ladEp,0,0,False],ladMeta["Seconds"],$Aborted];
      If[ListQ[fam]&&Length[fam]==1&&ladExactQ[fam]&&FreeQ[fam,ladEp],
        <|"status"->"Clean","value"->Global`mbeCanonicalConstants[fam[[1]]],"seconds"->Round[AbsoluteTime[]-t0],"method"->"ladder"|>,
        <|"status"->"Failed","reason"->ToString[Short[fam,2],InputForm],"b22"->If[FailureQ[b22],b22["Reason"],"?"],"seconds"->Round[AbsoluteTime[]-t0]|>]];
    Put[res,rf<>".tmp"];RenameFile[rf<>".tmp",rf,OverwriteTarget->True];
    Print["[ladder-worker] piece ",k,": ",res["status"]," in ",res["seconds"]," s"]],
  {k,ladMine}];
Print["[ladder-worker] LO=",ladLO," done ",DateString[]];
Close[ladLog];
