(* Research composition of whole factorization identities and admitted Euler
   classes. No full scalar-dispatcher installation yet. Common regulator
   orientation, conservative factor valuations and complete series remainders
   are checked before a product can be served. No target identifiers. *)
(* A failure marker or an unresolved symbol is not a constant integral.
   This syntax gate only restricts the admitted analytic expressions;
   convergence remains the responsibility of each structural class. *)
ecSourceQ[expr_,allowed_List]:=!ListQ[expr]&&
 MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[expr]&&!abtUnfinishedQ[expr]&&
 FreeQ[expr,True|False|$Failed|$TimedOut|$Aborted|Indeterminate|ComplexInfinity|_DirectedInfinity]&&
 Cases[expr,ss_Symbol/;!MemberQ[allowed,ss]&&!NumericQ[ss]&&
   !MemberQ[{HPL`HPLs6,HPL`HPLs7a,HPL`HPLs7b,HPL`HPLs8a,HPL`HPLs8b},ss],
   {0,Infinity},Heads->False]==={}&&
 Cases[expr,qq_/;!AtomQ[qq]&&!MemberQ[{Plus,Times,Power,Log,Gamma,PolyGamma,Zeta,PolyLog,
   HPL`HPL,PolyLogTools`G,List},Head[qq]],{0,Infinity},Heads->False]==={};
ecValuesQ[values_,ep_,count_Integer]:=gbjCleanQ[values,ep,count]&&AllTrue[values,ecSourceQ[#,{ }] &];
ecIntervals[rr_Association]:=Join[If[KeyExistsQ[rr,"EpsilonInterval"],{rr["EpsilonInterval"]},{}],
  Join@@(ecIntervals/@Values[rr])];
ecIntervals[rr_List]:=Join@@(ecIntervals/@rr);
ecIntervals[_]:={};
ecCommonInterval[node_]:=Module[{intervals=ecIntervals[node],common},
 If[intervals==={},Return[{-1/100,1/100}]];
 common={Max[intervals[[All,1]]],Min[intervals[[All,2]]]};
 If[TrueQ[common[[1]]<common[[2]]]&&TrueQ[common[[1]]<=0<=common[[2]]],common,$Failed]];

ecReductionLower[red_Association,ep_]:=Module[{terms,bounds,lead},
 If[KeyExistsQ[red,"Terms"],
   terms=red["Terms"];
   bounds=ecReductionLower[If[KeyExistsQ[#,"Reduction"],#["Reduction"],#],ep]&/@terms;
   Return[If[bounds=!={}&&AllTrue[bounds,IntegerQ],Min[bounds],$Failed]]];
 If[!KeyExistsQ[red,"Prefactor"],Return[$Failed]];
 lead=TimeConstrained[oftLeadOrder[red["Prefactor"],ep,4],60,$Failed];
 If[!IntegerQ[lead],Return[$Failed]];
 (* The admitted Gauss blocks have nonzero lower parameters at the origin.
    In the beta class, any vanishing lower sum is paired with its vanishing
    numerator endpoint parameter; its PFQ has no extra epsilon pole. *)
 lead-Lookup[red,"DerivativeOrder",0]];

ecBuildTree[cube_,vars_List,ep_,depth_:0]:=Module[
 {sep,nodes,lead,red,kind,lower,node,classes,rr,betaVars},
 If[depth>8||Length[DeleteDuplicates[vars]]=!=Length[vars]||MemberQ[vars,ep]||
   !AllTrue[vars,Head[#]===Symbol&]||!ecSourceQ[cube,Append[vars,ep]],
   Return[<|"Reduced"->False,"Reason"->"invalid source or composition depth"|>]];
 If[FreeQ[cube,Alternatives@@vars],
   lead=If[cube===0,0,TimeConstrained[oftLeadOrder[cube,ep,4],30,$Failed]];
   Return[<|"Reduced"->IntegerQ[lead],"Kind"->"Constant","Value"->cube,"LowerBound"->lead,
     "OriginalCube"->cube,"Vars"->vars|>]];
 If[Length[vars]>=3,
   sep=TimeConstrained[serFactorCube[cube,vars,ep],35,<|"Reduced"->False|>];
   If[AssociationQ[sep]&&TrueQ[sep["Reduced"]],
     nodes=ecBuildTree[#["Cube"],#["Vars"],ep,depth+1]&/@sep["Components"];
     lead=TimeConstrained[oftLeadOrder[sep["Prefactor"],ep,4],30,$Failed];
     If[IntegerQ[lead]&&AllTrue[nodes,TrueQ[#["Reduced"]]&],
       node=<|"Reduced"->True,"Kind"->"Product","Separation"->sep,"Children"->nodes,
         "LowerBound"->lead+Total[Lookup[nodes,"LowerBound"]],"OriginalCube"->cube,"Vars"->vars|>;
       If[ecCommonInterval[node]=!=$Failed,Return[node]]]]];
 betaVars=If[Length[vars]===1,Append[vars,Unique["ecUnitDummy"]],vars];
 classes=Join[If[Length[vars]<=2,{{"Beta",btkReduceCube}},{}],
   If[Length[vars]===3,{{"Gauss",ablReduceCube}},{}],
   {{"Gauss",sgsReduceCube}},If[Length[vars]>=4,{{"Gauss",sapReduceCube}},{}],
   If[Length[vars]<=3,{{"FiniteSum",fesReduceCube}},{}]];
 Do[red=TimeConstrained[cl[[2]][cube,If[cl[[1]]==="Beta",betaVars,vars],ep],20,<|"Reduced"->False|>];
   If[AssociationQ[red]&&TrueQ[red["Reduced"]],
     lower=ecReductionLower[red,ep];
     If[IntegerQ[lower],Return[<|"Reduced"->True,"Kind"->cl[[1]],"Reduction"->red,"LowerBound"->lower,
       "OriginalCube"->cube,"Vars"->vars|>,Module]]],{cl,classes}];
 If[Length[vars]>2,
   Do[red=TimeConstrained[closer[cube,vars,ep],25,<|"Reduced"->False|>];
     If[AssociationQ[red]&&TrueQ[red["Reduced"]]&&Length[red["Vars"]]<Length[vars],
       rr=ecBuildTree[red["Cube"],red["Vars"],ep,depth+1];
       If[TrueQ[rr["Reduced"]],Return[<|"Reduced"->True,"Kind"->"LocalMoment","Reduction"->red,
         "Child"->rr,"LowerBound"->rr["LowerBound"],"OriginalCube"->cube,"Vars"->vars|>,Module]]],
     {closer,{almReduceCube,walmReduceCube}}]];
 <|"Reduced"->False,"Reason"->"no complete composition of admitted classes","Vars"->vars|>];

ecEvaluateTree[node_Association,pref_,ep_,lo_Integer,hi_Integer,verbose_:False]:=Module[
 {kind=node["Kind"],children,lower,pre,prefLead,upper,vals,series={},total,result,jj},
 If[!TrueQ[node["Reduced"]],Return[$Failed]];
 Switch[kind,
  "Constant",total=Series[pref node["Value"],{ep,0,hi}];
    result=mbeCanonicalConstants/@Table[abtCoefficient[total,ep,jj],{jj,lo,hi}],
  "Beta",result=btkCubeLaurent[node["Reduction"],pref,ep,lo,hi,verbose],
  "Gauss",result=sgsCubeLaurent[node["Reduction"],pref,ep,lo,hi,verbose],
  "FiniteSum",result=fesCubeLaurent[node["Reduction"],pref,ep,lo,hi,verbose],
  "LocalMoment",result=ecEvaluateTree[node["Child"],pref,ep,lo,hi,verbose],
  "Product",
    children=node["Children"];lower=Lookup[children,"LowerBound"];
    pre=pref node["Separation"]["Prefactor"];prefLead=oftLeadOrder[pre,ep,Max[0,hi]];
    If[!IntegerQ[prefLead],Return[$Failed]];
    Do[upper=hi-prefLead-(Total[lower]-lower[[jj]]);
      If[upper<lower[[jj]],Return[ConstantArray[0,hi-lo+1],Module]];
      vals=ecEvaluateTree[children[[jj]],1,ep,lower[[jj]],upper,verbose];
      If[!ecValuesQ[vals,ep,upper-lower[[jj]]+1],Return[$Failed,Module]];
      AppendTo[series,SeriesData[ep,0,vals,lower[[jj]],upper+1,1]],{jj,Length[children]}];
    total=Series[pre Times@@series,{ep,0,hi}];
    If[Head[total]===SeriesData&&total[[5]]/total[[6]]<hi+1,Return[$Failed]];
    If[Head[total]=!=SeriesData&&!PolynomialQ[total,ep],Return[$Failed]];
    result=mbeCanonicalConstants/@Table[abtCoefficient[total,ep,jj],{jj,lo,hi}],
  _,Return[$Failed]];
 If[ecValuesQ[result,ep,hi-lo+1],result,$Failed]];

ecComposeLaurent[cube_,vars_List,pref_,ep_,lo_Integer,hi_Integer,verbose_:False]:=Module[
 {tree,interval,values,result,orientation,attempts={}},
 If[lo>hi||!ecSourceQ[cube,Append[vars,ep]]||!ecSourceQ[pref,{ep}],
   Return[<|"Complete"->False,"Reason"->"invalid or inexact source/prefactor"|>]];
 Do[tree=ecBuildTree[cube/.ep->orientation ep,vars,ep];
   AppendTo[attempts,KeyTake[tree,{"Reduced","Kind","Reason"}]];
   If[!TrueQ[tree["Reduced"]],Continue[]];interval=ecCommonInterval[tree];
   If[interval===$Failed,Continue[]];
   values=ecEvaluateTree[tree,pref/.ep->orientation ep,ep,lo,hi,verbose];
   If[!ecValuesQ[values,ep,hi-lo+1],Continue[]];
   result=MapThread[#1 orientation^#2&,{values,Range[lo,hi]}];
   Return[<|"Complete"->True,"Values"->result,"Orders"->{lo,hi},"Tree"->tree,
     "RegulatorOrientation"->orientation,"CommonEpsilonInterval"->Sort[orientation interval],
     "SourceHash"->Hash[{cube,vars,pref,ep},"SHA256"]|>,Module],{orientation,{1,-1}}];
 <|"Complete"->False,"Attempts"->attempts|>];

Print["[mbeEulerCompositionRung] research: exact class compositions with common regulator and complete Laurent-depth checks."];
