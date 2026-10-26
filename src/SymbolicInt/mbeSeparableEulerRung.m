(* Prototype: exact separation of the WHOLE Euler integrand into independent
   connected components. Equality is certified before any smaller integral
   is evaluated. Finite sums of separated products preserve their grouping;
   a connected residual is not declared simpler just because a name changed. *)
serFactorCube[cube_, vars_List, ep_] := Module[
  {factored, factors, amplitude=1, dependent={}, supports, edges, components, groups,
   reconstruction, difference, assumptions},
  If[! MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[cube],
    Return[<|"Reduced"->False,"Reason"->"inexact input"|>]];
  factored=TimeConstrained[Factor[Together[cube]],30,$Failed];
  If[factored===$Failed,Return[<|"Reduced"->False,"Reason"->"whole-expression factorization budget"|>]];
  factors=If[Head[factored]===Times,List@@factored,{factored}];
  Do[If[FreeQ[fac,Alternatives@@vars],amplitude*=fac,AppendTo[dependent,fac]],{fac,factors}];
  supports=Table[Select[vars,Function[vr,!FreeQ[fac,vr]]],{fac,dependent}];
  edges=DeleteDuplicates[Flatten[(System`UndirectedEdge@@#& /@ Subsets[#,{2}])& /@ supports]];
  components=System`ConnectedComponents[System`Graph[vars,edges]];
  If[Length[components]<2,Return[<|"Reduced"->False,"Reason"->"the factored integrand is connected",
    "FactoredCube"->factored,"Supports"->supports|>]];
  groups=Table[<|"Cube"->(Times@@Select[dependent,Function[fac,!FreeQ[fac,Alternatives@@cv]]]),"Vars"->cv|>,
    {cv,components}];
  reconstruction=amplitude (Times@@Lookup[groups,"Cube"]);
  assumptions=And@@Join[Thread[vars>0],Thread[vars<1],{Element[ep,Reals]}];
  difference=TimeConstrained[FullSimplify[cube-reconstruction,Assumptions->assumptions],30,$Failed];
  If[difference=!=0,Return[<|"Reduced"->False,"Reason"->"whole-integrand equality was not certified"|>]];
  <|"Reduced"->True,"Class"->"SeparableEulerProduct","Prefactor"->amplitude,
    "Components"->groups,"OriginalCube"->cube,"OriginalVariables"->vars,
    "InputDimension"->Length[vars],"ComponentDimensions"->(Length/@components),
    "MaxDimension"->Max[Length/@components],"ExactIdentity"->True|>];

Print["[mbeSeparableEulerRung] prototype: whole-integrand factorization and exact independent-component certificate."];
