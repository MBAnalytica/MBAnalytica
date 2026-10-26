(* Research adapter: finite sums of independently admissible Euler classes.
   Group equal regulated-power/log monomials, factor their COMPLETE rational
   coefficients, retain endpoint zeros, and require one common interval.
   Individual divergent terms and incomplete Laurent sums are refused. *)
Clear[fesReduceCube];
fesReduceCube[cube_,vars_List,ep_,marginalStar_:False]:=Catch[Module[
 {normalized,held,atoms,dummies,polynomial,monomials,reconstructed,pieces={},terms={},
  part,red,handler,intervals,common,identity,classes,rational},
 If[!MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[cube],
   Throw[<|"Reduced"->False,"Reason"->"inexact source"|>,fesTag]];
 normalized=Catch[fcuNormalize[cube,vars,ep],Global`fcu$tag];
 If[AssociationQ[normalized],Throw[<|"Reduced"->False,"Reason"->"positive-base normalization refused"|>,fesTag]];
 held=normalized/.(HoldPattern[Power[bb_,ee_]]/;!FreeQ[bb,Alternatives@@vars]&&
     !IntegerQ[ee]&&sbrAffineQ[ee,{ep}]):>With[{nn=If[IntegerQ[ee/.ep->0],ee/.ep->0,0]},
       bb^nn fesRegulatedPower[bb,Expand[ee-nn]]];
 atoms=Join[DeleteDuplicates[Cases[held,_fesRegulatedPower,{0,Infinity}]],
   DeleteDuplicates[Cases[held,l_Log/;!FreeQ[l,Alternatives@@vars]:>l,{0,Infinity}]]];
 dummies=Table[Unique["fesAtom"],{Length[atoms]}];
 polynomial=Together[held/.Thread[atoms->dummies]];
 If[dummies=!={}&&!PolynomialQ[polynomial,dummies],
   Throw[<|"Reduced"->False,"Reason"->"not a finite polynomial in regulated powers and logs"|>,fesTag]];
 monomials=If[dummies==={},{{}->polynomial},CoefficientRules[polynomial,dummies]];
 reconstructed=Total[Last[#]Times@@MapThread[Power,{dummies,First[#]}]&/@monomials];
 identity=TrueQ[Cancel[Together[polynomial-reconstructed]]===0];
 If[!identity,Throw[<|"Reduced"->False,"Reason"->"whole source reconstruction failed"|>,fesTag]];
 classes=Join[If[Length[vars]===2,{{"Beta",btkReduceCube}},{}],
   If[Length[vars]===3,{{"Blend",ablReduceCube}},{}],{{"Star",sgsReduceCube}},
   If[TrueQ[marginalStar],{{"Star",msgReduceCube}},{}],
   If[Length[vars]>=4,{{"Pair",sapReduceCube}},{}]];
 Do[
   (* Orient INTEGER rational factors without expanding their product.
      The full fcuNormalize expands this product and loses the endpoint
      zero again. Sign changes here are integer-power algebra only; the
      downstream class still proves its positive-base/convergence rules. *)
   rational=Times@@(Function[ff,With[{base=First[ff],power=Last[ff]},
     If[TrueQ[(base/.Thread[vars->1/2])<0],(-1)^power Expand[-base]^power,base^power]]]/@
     FactorList[Together[Last[monomial]]]);
   part=rational Times@@MapThread[Power,{atoms,First[monomial]}]/.fesRegulatedPower->Power;
   AppendTo[pieces,part];red=<|"Reduced"->False|>;
   Do[handler=cl[[2]];red=TimeConstrained[handler[part,vars,ep],8,<|"Reduced"->False,"Reason"->"class budget"|>];
     If[AssociationQ[red]&&TrueQ[red["Reduced"]],
       AppendTo[terms,<|"Kind"->cl[[1]],"SourcePiece"->part,"Reduction"->red|>];Break[]],{cl,classes}];
   If[!AssociationQ[red]||!TrueQ[red["Reduced"]],
     Throw[<|"Reduced"->False,"Reason"->"an entire grouped term has no admitted convergent class",
       "FailedPiece"->part,"AdmittedCount"->Length[terms]|>,fesTag]],{monomial,monomials}];
 intervals=Cases[Lookup[terms,"Reduction"],rr_Association/;KeyExistsQ[rr,"EpsilonInterval"]:>rr["EpsilonInterval"],{0,Infinity}];
 If[intervals==={},Throw[<|"Reduced"->False,"Reason"->"no convergence intervals"|>,fesTag]];
 common={Max[intervals[[All,1]]],Min[intervals[[All,2]]]};
 If[!TrueQ[common[[1]]<common[[2]]]||!MemberQ[common,0],
   Throw[<|"Reduced"->False,"Reason"->"no common punctured regulator interval","Intervals"->intervals|>,fesTag]];
 <|"Reduced"->True,"Class"->"FiniteEulerSum","OriginalCube"->cube,"Vars"->vars,
   "Terms"->terms,"TermCount"->Length[terms],"SourceIdentity"->identity,
   "EpsilonInterval"->common,"InputDimension"->Length[vars],
   "Grouping"->"complete rational coefficient per regulated-power/log monomial"|>
 ],fesTag];

fesCubeLaurent[red_Association,pref_,ep_,lo_Integer,hi_Integer,verbose_:False]:=Module[
 {values={},value,answer,records={}},
 If[!TrueQ[red["Reduced"]]||!TrueQ[red["SourceIdentity"]],Return[$Failed]];
 Do[value=Switch[term["Kind"],
    "Beta",btkCubeLaurent[term["Reduction"],pref,ep,lo,hi,verbose],
    "Blend"|"Star"|"Pair",sgsCubeLaurent[term["Reduction"],pref,ep,lo,hi,verbose],_,$Failed];
   If[!gbjCleanQ[value,ep,hi-lo+1],Return[$Failed,Module]];
   AppendTo[values,value];AppendTo[records,<|"Term"->term,"Values"->value|>],{term,red["Terms"]}];
 answer=mbeCanonicalConstants/@Total[values];
 If[!gbjCleanQ[answer,ep,hi-lo+1],Return[$Failed]];
 Global`$fesLastRun=<|"Orders"->{lo,hi},"Terms"->records,"EpsilonInterval"->red["EpsilonInterval"]|>;
 answer];

Print["[mbeFiniteEulerSumRung] research: finite grouped sums with a common convergence interval; no independent finite parts."];
