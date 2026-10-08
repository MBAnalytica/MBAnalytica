(* AUTHORSHIP (release R2, 2026-09-07): part of the IntVolFLINT addition to MB2MPL (the hyperlogarithm-integrator bridge: JSON requests, word evaluation, numeric checks). Author: Syed Mehedi Hasan; backends: HyperFLINT and HyperIntica (SubTropica; M. Giroux, S. Mizera, G. Salvatori, arXiv:2604.20954), HyperIntica being a native Mathematica reimplementation of E. Panzer's HyperInt (arXiv:1403.3385). *)
(* hf_machinery.m — shared HyperFLINT cube integrator + numeric eval. Requires load_standard_w10 + HyperIntica loaded. *)
hfBin=If[ValueQ[Global`$MBStandardHyperFLINTBinary],
  Global`$MBStandardHyperFLINTBinary,
  FileNameJoin[{DirectoryName[ExpandFileName[$InputFileName]], "vendor",
    "HyperFLINT", "bin", "hyperflint"}]];
mzvPath=If[ValueQ[Global`$MBStandardHyperFLINTData],
  Global`$MBStandardHyperFLINTData,
  FileNameJoin[{DirectoryName[ExpandFileName[$InputFileName]], "vendor",
    "HyperFLINT", "data", "mzv_reductions.json"}]];
constToHF={EulerGamma->Global`hfEG,Pi->Global`hfPI,Zeta[3]->Global`hfZ3,Zeta[5]->Global`hfZ5,Log[2]->Global`hfLOG2};
jsonStr[a_]:=StringReplace[ExportString[a,"JSON","Compact"->True],"\\/"->"/"];
runHF[body_,tmo_]:=Module[{inF=FileNameJoin[{$TemporaryDirectory,"hfm_in_"<>ToString[$ProcessID]<>".json"}],outF=FileNameJoin[{$TemporaryDirectory,"hfm_out_"<>ToString[$ProcessID]<>".json"}],r},
  Quiet@DeleteFile[outF]; Export[inF,body,"Text"];
  RunProcess[{"bash","-c","ulimit -s unlimited; timeout "<>ToString[tmo]<>" env OMP_NUM_THREADS="<>ToString[If[IntegerQ[Global`$ivfThreadsSingle],Global`$ivfThreadsSingle,8]]<>" "<>hfBin<>" eval-json < "<>inF<>" > "<>outF<>" 2>/dev/null"}];   (* threads follow the IntVolFLINT scaling when set (2026-09-08) *)
  If[!FileExistsQ[outF]||FileByteCount[outF]===0,Return[$Failed]]; r=Quiet@Import[outF,"RawJSON"]; If[!AssociationQ[r],$Failed,r]];
mzvAtom[s_String]:=Module[{idx},idx=ToExpression/@(StringSplit[StringDrop[s,4],"$"]/.m_String:>StringReplace[m,"m"->"-"]); HyperIntica`mzv@@idx];
atomRules={Global`hfEG->EulerGamma,Global`hfPI->Pi,Global`hfZ3->Zeta[3],Global`hfZ5->Zeta[5],Global`hfLOG2->Log[2],
  s_Symbol/;StringMatchQ[SymbolName[s],"mzv$"~~__]:>mzvAtom[SymbolName[s]],s_Symbol/;SymbolName[s]==="Log2"->Log[2]};
parseResp[r_]:=Module[{rows,alg,rootRules,parse,cache,wordVal,val,refus},
  If[!ListQ[Lookup[r,"result",Null]]||KeyExistsQ[r,"failed"]||KeyExistsQ[r,"divergent"]||KeyExistsQ[r,"error"],Return[<|"ok"->False,"reason"->Lookup[r,"reason",Lookup[r,"error","noresult"]]|>]];
  rows=r["result"]; If[rows==={},Return[<|"ok"->True,"val"->0|>]];
  alg=Lookup[r,"algebraic_letters",{}]; If[!ListQ[alg],alg={}];
  rootRules=Flatten[Table[Module[{k=a["idx"],lc=ToExpression[a["lc"]],sum=ToExpression[a["sum"]],disc=ToExpression[a["disc"]]},
     {Symbol["Global`Wm$"<>ToString[k]]->sum/2-Sqrt[disc]/(2 lc),Symbol["Global`Wp$"<>ToString[k]]->sum/2+Sqrt[disc]/(2 lc),
      Symbol["Global`WmOverWp$"<>ToString[k]]->(sum/2-Sqrt[disc]/(2 lc))/(sum/2+Sqrt[disc]/(2 lc)),Symbol["Global`sqrt$disc$"<>ToString[k]]->Sqrt[disc]}],{a,alg}]];
  parse[s_String]:=ToExpression[StringReplace[s,"_"->"$"],InputForm]/.rootRules/.atomRules;
  cache=<||>; wordVal[w_List]:=(If[!KeyExistsQ[cache,w],cache[w]=HyperIntica`ZeroInfPeriodAsMpl[parse/@w]];cache[w]);
  val=Total[Table[parse[row["coef"]] Times@@(wordVal[#]&/@row["key"]),{row,rows}]];
  refus=DeleteDuplicates[Cases[val,_HyperIntica`ZeroInfPeriod,{0,Infinity}]];
  <|"ok"->(refus==={}),"val"->val,"reason"->If[refus==={},"","refused"]|>];
exprStr[f_]:=StringReplace[ToString[f,InputForm],{" "->"",RegularExpression["[A-Za-z][A-Za-z0-9]*`"]->""}];
cubeHF[f0_,vars_,tmo_]:=Module[{f=f0/.constToHF,orders,req,r,pr,out=$Failed,firstClean=$Failed,lastReason="none"},
  orders=Take[DeleteDuplicates[Join[{vars,Reverse[vars],RotateLeft[vars,1],RotateRight[vars,1]},Permutations[vars]]],
    UpTo[Module[{oc=Quiet@ToExpression[Environment["NBP_HFORDERS"]/. $Failed->"10"]},If[IntegerQ[oc]&&oc>0,oc,10]]]];
  Do[req=<|"op"->"hyperflint","expr"->exprStr[f],"vars_int"->(SymbolName/@o),
      "vars"->Join[SymbolName/@vars,{"hfEG","hfPI","hfZ3","hfZ5","hfLOG2"}],"vars_int_from"->ConstantArray["0",Length[vars]],
      "vars_int_to"->ConstantArray["1",Length[vars]],"mzv_data_path"->mzvPath,"algebraic_letters"->True,"canonical_emission"->True|>;
    r=runHF[jsonStr[req],tmo]; If[r===$Failed,lastReason="HF-fail";Continue[]];
    pr=parseResp[r]; lastReason=Lookup[pr,"reason","?"];
    If[TrueQ[pr["ok"]],If[firstClean===$Failed,firstClean=pr];If[FreeQ[pr["val"],_Real],out=pr;Break[]]],{o,orders}];
  Which[out=!=$Failed,out,firstClean=!=$Failed,firstClean,True,<|"ok"->False,"reason"->lastReason|>]];
gvExact[e_]:=e/.h_[a_List,b_List]/;SymbolName[h]==="Mpl":>PolyLogTools`LiToG[PolyLogTools`Li[a,b]]/.h_[ms__Integer]/;SymbolName[h]==="mzv":>PolyLogTools`LiToG[PolyLogTools`Li[Abs/@{ms},Sign/@{ms}]];
canonHF[x_]:=ToRadicals[RootReduce[Together[x]]];
gnumHF[g_PolyLogTools`G]:=gnumHF[g]=Module[{gc=If[FreeQ[g,_Root],g,Map[canonHF,g]]},Quiet[N[PolyLogTools`Ginsh[gc,{},PolyLogTools`PrecisionGoal->50],42]]];
gvN[e0_]:=Module[{e=Quiet@PolyLogTools`ShuffleRegulate[Expand[gvExact[e0]]],gs,vv},gs=DeleteDuplicates[Cases[e,_PolyLogTools`G,{0,Infinity}]];If[gs==={},N[e,38],vv=AssociationMap[gnumHF,gs];If[AnyTrue[Values[vv],!NumberQ[#]&],$Failed,N[e/.vv,38]]]];
renameVarsHF[ig_,vars_]:=Module[{rules},rules=(#->Symbol["Global`"<>StringReplace[ToString[#,InputForm],{"["->"","]"->""}]])&/@vars; {ig/.rules,vars/.rules}];
