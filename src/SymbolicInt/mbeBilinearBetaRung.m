(* Double beta integrals with kernel (1-x y)^(-h), polynomial numerators
   and logarithmic dressing.  Exact Euler moments give 3F2(1).
   Auxiliary shifts are lambda*epsilon; derivatives are taken symbolically
   AFTER epsilon expansion, retaining rational dependence on lambda.
   Prototype, not installed in the scalar dispatcher. *)
btkFail[why_]:=Throw[<|"Reduced"->False,"Reason"->why|>,btkTag];
btkParameters[pars_List,logPowers_List,amplitude_,ep_]:=Catch[Module[
 {aa,bb,cc,dd,hh,forms,delta=1/40,sign,origin,slope,shifted,lams,pref,pfq,ops},
 If[Length[pars]=!=5||Length[logPowers]=!=5||!AllTrue[logPowers,IntegerQ[#]&&#>=0&]||
   !AllTrue[pars,sbrAffineQ[#,{ep}]&]||!MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[amplitude],
   btkFail["rational-affine parameters and nonnegative integer log powers required"]];
 {aa,bb,cc,dd,hh}=pars;forms=Expand/@{aa,bb,cc,dd,bb+dd-hh};
 If[!TrueQ[(Last[forms]/.ep->0)>0],btkFail["strict corner excess required"]];
 Do[origin=ff/.ep->0;slope=Coefficient[ff,ep];
   If[TrueQ[origin>0]&&slope=!=0,delta=Min[delta,origin/(2Abs[slope])]],{ff,forms}];
 sign=SelectFirst[{1,-1},Function[sg,AllTrue[forms,TrueQ[(#/.ep->0)>=0&&(#/.ep->sg delta)>0]&]],None];
 If[sign===None,btkFail["no common half-interval for endpoint powers"]];
 lams=Table[Symbol["BilinearBeta`lambda"<>ToString[jj]],{jj,5}];
 shifted=pars+ep MapThread[If[#2>0,#1,0]&,{lams,logPowers}]*{1,1,1,1,-1};
 {aa,bb,cc,dd,hh}=shifted;
 pref=amplitude Gamma[aa]Gamma[bb]Gamma[cc]Gamma[dd]/(Gamma[aa+bb]Gamma[cc+dd]);
 pfq=HypergeometricPFQ[{hh,aa,cc},{aa+bb,cc+dd},1];
 ops=Select[Transpose[{lams,logPowers}],Last[#]>0&];
 <|"Reduced"->True,"Class"->"BilinearBetaLog","Parameters"->pars,"LogPowers"->logPowers,
   "Amplitude"->amplitude,"Prefactor"->pref,"PFQ"->pfq,"Ops"->ops,"Lambdas"->lams,
   "DerivativeOrder"->Total[logPowers],"EpsilonInterval"->Sort[{0,sign delta}],
   "EndpointForms"->forms,"CornerExcess"->Last[forms]|>],btkTag];

btkExpandLogs[expr_,vars_List]:=expr/.(HoldPattern[Log[arg_]]/;!FreeQ[arg,Alternatives@@vars]):>
 Module[{ff=Quiet@Check[fcuPosFactors[arg,vars],$Failed]},
  If[ListQ[ff]&&First[ff]===1&&AllTrue[Last[ff],
    (sbrRationalQ[First[#]]&&First[#]>0)||alePositiveQ[First[#],vars]&],
    Total[Last[#]Log[First[#]]&/@Last[ff]],Log[arg]]];

btkTryChart[cube_,vars_List,ep_,reflect_List]:=Catch[Module[
 {xx=vars[[1]],yy=vars[[2]],expr,bases,atoms,dummies,poly,monomials,terms={},factorList,
  exponents,logs,amplitude,base,power,hit,scale,red,rational,allFactors,reconstruction,held},
 expr=cube/.MapThread[#1->If[#2,1-#1,#1]&,{vars,reflect}];
 expr=Catch[fcuNormalize[expr,vars,ep],Global`fcu$tag];
 If[AssociationQ[expr],btkFail["positive-base normalization refused"]];
 expr=btkExpandLogs[expr,vars];bases={xx,1-xx,yy,1-yy,1-xx yy};
 (* Normalize integer offsets BEFORE treating epsilon powers as independent
    atoms. Otherwise x^(n+q eps)-x^(n+1+q eps) loses its (1-x) endpoint
    zero and is split into terms with an inadmissible corner. The inert
    head prevents Times from immediately merging the offset back. *)
 held=expr/.(HoldPattern[Power[bb_,ee_]]/;!FreeQ[bb,Alternatives@@vars]&&
     !IntegerQ[ee]&&sbrAffineQ[ee,{ep}]):>With[{nn=If[IntegerQ[ee/.ep->0],ee/.ep->0,0]},
       bb^nn btkRegulatedPower[bb,Expand[ee-nn]]];
 atoms=DeleteDuplicates[Cases[held,_btkRegulatedPower,{0,Infinity}]];
 atoms=Join[atoms,DeleteDuplicates[Cases[expr,l_Log/;!FreeQ[l,Alternatives@@vars]:>l,{0,Infinity}]]];
 dummies=Table[Unique["btkAtom"],{Length[atoms]}];poly=Together[held/.Thread[atoms->dummies]];
 If[dummies=!={}&&!PolynomialQ[poly,dummies],btkFail["not a finite polynomial in endpoint powers and logs"]];
 monomials=If[dummies==={},{{}->poly},CoefficientRules[poly,dummies]];
 Do[exponents={0,0,0,0,0};logs={0,0,0,0,0};amplitude=1;
   rational=Factor[Together[Last[monomial]]];
   factorList=If[Head[rational]===Times,List@@rational,{rational}];
   allFactors=Join[factorList,MapThread[Power,{atoms,First[monomial]}]/.btkRegulatedPower->Power];
   Do[If[fac===1,Continue[]];
     If[FreeQ[fac,Alternatives@@vars],amplitude*=fac;Continue[]];
     If[Head[fac]===Log||(Head[fac]===Power&&Head[fac[[1]]]===Log),
       {base,power}=If[Head[fac]===Log,{fac[[1]],1},{fac[[1,1]],fac[[2]]}];
       hit=SelectFirst[Range[5],TrueQ[Expand[base-bases[[#]]]===0]&,None];
       If[hit===None||!IntegerQ[power]||power<0,btkFail["unsupported logarithmic base"]];
       logs[[hit]]+=power;Continue[]];
     {base,power}=If[Head[fac]===Power,List@@fac,{fac,1}];base=Expand[base];
     hit=SelectFirst[Range[5],TrueQ[Expand[base-bases[[#]]]===0]&,None];
     If[hit===None&&IntegerQ[power],
       hit=SelectFirst[Range[5],TrueQ[Expand[base+bases[[#]]]===0]&,None];
       If[hit=!=None,amplitude*=(-1)^power]];
     If[hit===None||!sbrAffineQ[power,{ep}],btkFail["factor outside the bilinear beta class"]];
     exponents[[hit]]+=power,{fac,allFactors}];
   red=btkParameters[Join[Take[exponents,4]+1,{-Last[exponents]}],logs,amplitude,ep];
   If[!TrueQ[red["Reduced"]],btkFail[red["Reason"]]];AppendTo[terms,red],{monomial,monomials}];
 reconstruction=Total[Table[tm["Amplitude"]Times@@MapThread[Power,
   {bases,Join[Take[tm["Parameters"],4]-1,{-Last[tm["Parameters"]]}]}]
   Times@@MapThread[Power,{Log/@bases,tm["LogPowers"]}],{tm,terms}]];
 If[!TrueQ[TimeConstrained[FullSimplify[expr-reconstruction,
   Assumptions->And@@Join[Thread[vars>0],Thread[vars<1],{Element[ep,Reals]}]],20,$Failed]===0],
   btkFail["whole-integrand reconstruction not certified"]];
 <|"Reduced"->True,"Class"->"BilinearBetaLogSum","Terms"->terms,
   "InputDimension"->2,"TermCount"->Length[terms],"ExactIdentity"->True,
   "OriginalCube"->cube,"Vars"->vars,"Reflections"->reflect|>],btkTag];

btkReduceCube[cube_,vars_List,ep_]:=Module[{red,reasons={}},
 If[Length[vars]=!=2,Return[<|"Reduced"->False,"Reason"->"two variables required"|>]];
 Do[red=btkTryChart[cube,vars,ep,reflect];
   If[TrueQ[red["Reduced"]],Return[red,Module]];AppendTo[reasons,red["Reason"]],{reflect,Tuples[{False,True},2]}];
 <|"Reduced"->False,"Reason"->"no admitted beta-product chart","Refusals"->DeleteDuplicates[reasons]|>];

btkTermLaurent[red_Association,externalPref_,ep_,lo_Integer,hi_Integer,verbose_:False]:=Module[
 {pref,pfq,k,top,lead,depth,expansion,series,answer,coefficient,denominator,shiftedOrders,started=AbsoluteTime[]},
 If[!TrueQ[red["Reduced"]],Return[$Failed]];
 k=red["DerivativeOrder"];top=hi+k;pref=externalPref red["Prefactor"];pfq=red["PFQ"];
 lead=oftLeadOrder[pref,ep,Max[0,top]];depth=Max[0,top-lead];
 If[verbose,Print["    [bilinear beta] log order ",k," depth ",depth," parameters ",red["Parameters"]]];
 expansion=If[FreeQ[pfq,HypergeometricPFQ|Hypergeometric2F1],pfq,hbbExpand[pfq,ep,depth,1800]["Expansion"]];
 If[!hbbExactQ[expansion],Return[$Failed]];
 series=Series[pref expansion,{ep,0,top}];
 answer=Table[coefficient=Together[abtCoefficient[series,ep,jj+k]];
   denominator=Denominator[coefficient]/.Thread[red["Lambdas"]->0];
   If[denominator===0||!FreeQ[denominator,Indeterminate|ComplexInfinity],Return[$Failed,Module]];
   coefficient=If[red["Ops"]==={},coefficient,D[coefficient,Sequence@@red["Ops"]]];
   mbeCanonicalConstants[coefficient/.Thread[red["Lambdas"]->0]],{jj,lo,hi}];
 If[abtUnfinishedQ[answer]||!FreeQ[answer,ep|$Failed|$Aborted|Indeterminate|ComplexInfinity|_DirectedInfinity]||
   !FreeQ[answer,Alternatives@@red["Lambdas"]]||
   !MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[answer],Return[$Failed]];
 Global`$btkLastRun=<|"Orders"->{lo,hi},"DerivativeOrder"->k,"BlockDepth"->depth,"Seconds"->AbsoluteTime[]-started|>;
 answer];

btkCubeLaurent[red_Association,pref_,ep_,lo_Integer,hi_Integer,verbose_:False]:=Module[{values={},value},
 If[!TrueQ[red["Reduced"]],Return[$Failed]];
 Do[value=btkTermLaurent[term,pref,ep,lo,hi,verbose];If[!ListQ[value],Return[$Failed,Module]];AppendTo[values,value],
   {term,Lookup[red,"Terms",{red}]}];mbeCanonicalConstants/@Total[values]];

Print["[mbeBilinearBetaRung] prototype: beta-product 3F2 moments with exact symbolic logarithmic derivatives."];
