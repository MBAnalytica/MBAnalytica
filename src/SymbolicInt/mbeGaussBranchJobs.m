(* Durable jobs for finite, independently integrable Gauss branches.
   A manifest retains every occurrence, including equal-valued branches.
   Workers never query benchmarks. Assembly requires every matching result. *)
gbjSchema="gauss-branch-jobs-20260912a";
gbjDependencies[]={"mbeSharedAffineGaussRung.m","mbeSharedAffineStarRung.m",
  "mbeSharedAffinePairRung.m","mbeGaussBranchJobs.m","mbeFixedLetterGPLRung.m",
  "mbeRegularHPLBoundaryRung.m","mbeAbelTowerRung.m","mbeHypExpBlockBank.m"};
gbjImplementation[]:=Module[{files=FileNameJoin[{Global`$MBStandardDir,#}]&/@gbjDependencies[]},
  If[ListQ[Global`mbSerialDependencyFiles],files=Join[files,Global`mbSerialDependencyFiles]];
  {$Version,Table[{file,If[FileExistsQ[file],FileHash[file,"SHA256"],Missing["Absent"]]},
    {file,Sort[DeleteDuplicates[files]]}]}];
gbjJobHash[job_Association]:=IntegerString[Hash[KeyDrop[job,{"JobHash","ResultPath"}],"SHA256"],16,64];
gbjWriteManifest[red_Association,externalPref_,ep_,lo_Integer,hi_Integer,directory_String]:=Module[
  {terms,implementation,source,files={},job,path,manifest},
  If[!TrueQ[red["Reduced"]]||!KeyExistsQ[red,"Terms"]||hi<lo,Return[$Failed]];
  terms=red["Terms"];implementation=gbjImplementation[];
  source=IntegerString[Hash[{red,externalPref,ep,{lo,hi}},"SHA256"],16,64];
  Quiet@CreateDirectory[directory,CreateIntermediateDirectories->True];
  Do[path=FileNameJoin[{directory,"job_"<>IntegerString[jj,10,5]<>".m"}];
    job=<|"Schema"->gbjSchema,"SourceHash"->source,"Index"->jj,"TermCount"->Length[terms],
      "Reduction"->terms[[jj]],"ExternalPrefactor"->externalPref,"Epsilon"->ep,
      "Orders"->{lo,hi},"Implementation"->implementation|>;
    job=Join[job,<|"JobHash"->gbjJobHash[job],"ResultPath"->FileNameJoin[{directory,"result_"<>IntegerString[jj,10,5]<>".m"}]|>];
    sagAtomicPut[job,path];AppendTo[files,path],{jj,Length[terms]}];
  manifest=<|"Schema"->gbjSchema,"Class"->red["Class"],"SourceHash"->source,
    "InputDimension"->red["InputDimension"],"OutputDimension"->1,"Orders"->{lo,hi},
    "Epsilon"->ep,"TermCount"->Length[terms],"Jobs"->files,"Implementation"->implementation|>;
  path=FileNameJoin[{directory,"manifest.m"}];sagAtomicPut[manifest,path];path];

gbjCleanQ[value_,ep_,count_Integer]:=ListQ[value]&&Length[value]===count&&
  MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[value]&&!abtUnfinishedQ[value]&&
  FreeQ[value,ep|$Failed|$Aborted|Indeterminate|ComplexInfinity|_DirectedInfinity|_Integrate|_NIntegrate];
gbjRunJob[path_String,budget_:3600,verbose_:False]:=Module[
  {job,result,value,valid,started=AbsoluteTime[],orders},
  job=Quiet@Check[Get[path],$Failed];
  If[!AssociationQ[job]||Lookup[job,"Schema",None]=!=gbjSchema||
      Lookup[job,"JobHash",None]=!=gbjJobHash[job]||job["Implementation"]=!=gbjImplementation[],Return[$Failed]];
  orders=job["Orders"];
  value=TimeConstrained[sagCubeLaurent[job["Reduction"],job["ExternalPrefactor"],job["Epsilon"],
    orders[[1]],orders[[2]],verbose],budget,$Failed];
  valid=gbjCleanQ[value,job["Epsilon"],orders[[2]]-orders[[1]]+1];
  result=<|"Schema"->gbjSchema,"SourceHash"->job["SourceHash"],"JobHash"->job["JobHash"],
    "Index"->job["Index"],"Orders"->orders,"Clean"->valid,"Values"->value,
    "Seconds"->AbsoluteTime[]-started,"Run"->If[valid,Global`$sagLastRun,None]|>;
  sagAtomicPut[result,job["ResultPath"]];result];

gbjAssemble[path_String]:=Module[{manifest,values={},missing={},job,result,orders,total,jobPath},
  manifest=Quiet@Check[Get[path],$Failed];
  If[!AssociationQ[manifest]||Lookup[manifest,"Schema",None]=!=gbjSchema||
    manifest["Implementation"]=!=gbjImplementation[]||Length[manifest["Jobs"]]=!=manifest["TermCount"],
    Return[<|"Complete"->False,"Reason"->"invalid or obsolete manifest"|>]];
  orders=manifest["Orders"];
  Do[jobPath=manifest["Jobs"][[jj]];job=Quiet@Check[Get[jobPath],$Failed];
    If[!AssociationQ[job]||Lookup[job,"Schema",None]=!=gbjSchema||
       Lookup[job,"SourceHash",None]=!=manifest["SourceHash"]||Lookup[job,"Index",None]=!=jj||
       Lookup[job,"TermCount",None]=!=manifest["TermCount"]||Lookup[job,"Orders",None]=!=orders||
       Lookup[job,"Implementation",None]=!=manifest["Implementation"]||
       Lookup[job,"JobHash",None]=!=gbjJobHash[job],AppendTo[missing,jobPath];Continue[]];
    result=If[FileExistsQ[job["ResultPath"]],Quiet@Check[Get[job["ResultPath"]],$Failed],$Failed];
    If[!AssociationQ[result]||!TrueQ[Lookup[result,"Clean",False]]||
       Lookup[result,"Schema",None]=!=gbjSchema||Lookup[result,"SourceHash",None]=!=manifest["SourceHash"]||
       Lookup[result,"JobHash",None]=!=job["JobHash"]||Lookup[result,"Orders",None]=!=orders||
       !gbjCleanQ[Lookup[result,"Values",$Failed],manifest["Epsilon"],orders[[2]]-orders[[1]]+1],
       AppendTo[missing,jobPath],AppendTo[values,result["Values"]]],{jj,Length[manifest["Jobs"]]}];
  If[missing=!={}||Length[values]=!=manifest["TermCount"],
    Return[<|"Complete"->False,"MissingOrInvalidJobs"->missing,"Present"->Length[values],"Required"->manifest["TermCount"]|>]];
  total=If[values==={},ConstantArray[0,orders[[2]]-orders[[1]]+1],mbeCanonicalConstants/@Total[values]];
  <|"Complete"->gbjCleanQ[total,manifest["Epsilon"],orders[[2]]-orders[[1]]+1],
    "Values"->total,"Orders"->orders,"SourceHash"->manifest["SourceHash"],"TermCount"->Length[values]|>];

Print["[mbeGaussBranchJobs] durable one-dimensional jobs with complete-manifest exact assembly."];
