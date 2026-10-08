(* User-supplied differential MB integrands, 2026-09-20.
   Gamma factors are stored as argument lists, with repetitions preserving powers.
   No integration is performed. Get returns an Association. Symbols live in an
   isolated context; use data["Regulator"], data["Parameter"] and each variable list.
   A phase p means Exp[2 (EulerGamma + p I Pi) epsilon]. *)
BeginPackage["MBStandardUExamples`"];
ClearAll[u, \[Epsilon], make, add, entries];
entries = <||>;
make[sgn_, ph_, up_, xp_, ng_List, dg_List] := (
 sgn Exp[2 (EulerGamma + ph I Pi) \[Epsilon]] u^up (1-u)^xp
  (Times @@ (Gamma /@ ng))/(Times @@ (Gamma /@ dg)));
add[name_, id_, sgn_, ph_, up_, xp_, ng_List, dg_List, vars_List, bmax_] :=
 AssociateTo[entries, name -> <|"Label" -> id, "Sign" -> sgn,
  "Phase" -> ph, "UPower" -> up, "OneMinusUPower" -> xp,
  "NumeratorGammaArguments" -> ng, "DenominatorGammaArguments" -> dg,
  "MBVariables" -> vars, "MBFold" -> Length[vars],
  "InclusiveBenchmarkMax" -> bmax,
  "Integrand" -> make[sgn,ph,up,xp,ng,dg]|>];

With[{e=\[Epsilon]},
add["MB1u",101,1,1,-2 e,z321-e,
 {-z321,2-4 e,4-4 e,1-z321-3 e,e,z321+e,z321+e},
 {4-8 e,2-2 e},{z321},5];
add["MB21u",104,1,1,-2 e,-1-2 e,
 {1-4 e,1-4 e,4-4 e,-e,-e,-e,e,1+e,1+e},
 {2-8 e,2-2 e,2-2 e,-2 e},{},4];
add["MB22u",104,1,0,-3 e,z411-e,
 {-z411,1+z411,1+z411,1-4 e,1-4 e,4-4 e,1-e,-1-z411-e,e,e},
 {2-8 e,2-2 e,2-2 e,-2 e},{z411},4];
add["MB3u",105,-1,1,-2 e,z321-e,
 {-z321,1-4 e,4-4 e,1-z321-3 e,-e,e,z321+e,z321+e},
 {3-8 e,1-2 e,1-e},{z321},4];
add["MB4u",106,-1,1,-1-2 e,z321-e,
 {-z321,-z4,-z4,1+z4,1-4 e,4-4 e,-z321-z4-3 e,z4-e,-4 e,-e,e,1+e,z321+e,1+z321+z4+e},
 {1-8 e,1-z4-4 e,1-e,1-e,-2 e,1+z4+e},{z321,z4},1];
add["MB5u",107,-1,1,-1-2 e,z321-e,
 {-z321,-z4,-z4,1+z4,-z5,-1-4 e,4-4 e,z5-2 e,z4-e,-1-z321-z4-z5-e,z5-e,1+z321+z4+z5-e,-4 e,-e,-e,1+e,1+z321+e,1-z5+2 e},
 {-1-8 e,-z4-z5-2 e,1-e,1-e,1-e,1+z4+z5-e,-2 e,-2 e},{z321,z4,z5},1];
add["MB6u",108,-1,1,-1-2 e,z321-e,
 {-z321,-z4,-z4,1+z4,-1-4 e,4-4 e,-1-z321-z4-3 e,-1-z4-2 e,z321-e,z4-e,-4 e,-e,-e,1+e,1+e,1+z321+e,2+z321+z4+e},
 {-1-8 e,-1-z4-4 e,-z4-2 e,1-e,1-e,1-e,1+z321-e,-2 e,2+z4+e},{z321,z4},2];
add["MB7u",109,1,0,-2-3 e,-e,
 {-z69,-z69,1+z69,-2-4 e,4-4 e,-1-z69-2 e,-z69-e,z69-e,-4 e,-e,-e,-e,-e,1+e,1+e},
 {-2-8 e,-z69-2 e,-z69-2 e,1-e,1-e,1-e,1-e,-2 e,-2 e},{z69},3];
add["MB8au",110,-1,1,-1-2 e,z321+z611-e,
 {-z321,-z4,-z4,1+z4,-z611,-z7,-z8,1+z611+z8,-2-4 e,-1-4 e,4-4 e,-1+z7+z8-2 e,-1-e,z4-e,-1-z321-z4-z7-e,-1-z611+z7-e,1+z321+z4+z7+z8-e,-e,1+e,2+e,1+z321-z8+e,2+z611-z7-z8+2 e},
 {-3-8 e,-1-2 e,-z4-z7-2 e,1-e,1-e,1-e,1+z4+z7+z8-e,-2 e,1-z8+e},{z321,z4,z611,z7,z8},1];
add["MB8bu",110,-1,0,-2-3 e,z321+z611-e,
 {-z321,-z4,-z4,1+z4,-z611,-z7,-2-4 e,-1-4 e,4-4 e,z4-e,-1-z321-z4-z7-e,-1-z611+z7-e,z611+z8-e,z7+z8-e,1+z321+z4+z7+z8-e,-e,-e,1+e,1+e,1+z321-z8+e,1+z611-z7-z8+e},
 {-3-8 e,-1-2 e,-z4-z7-2 e,1-e,1-e,1-e,1+z4+z7+z8-e,-2 e},{z321,z4,z611,z7,z8},1];
add["MB9u",111,1,0,-2-3 e,z321-e,
 {-z321,1+z321,1+z321,-z5,-1-4 e,-1-4 e,4-4 e,-1-z321+z5-3 e,z5-2 e,z5-e,z5-e,-e,-e,-e,-e,1+e,1+e,1+z321-z5+e},
 {-2-8 e,z5-3 e,z5-3 e,1-e,1-e,1-e,1+z321-e,-2 e,-2 e},{z321,z5},1];
add["MB10u",113,1,0,-3-3 e,z321-e,
 {-z321,1+z321,1+z321,-z5,-2-4 e,-2-4 e,4-4 e,-1-z321+z5-3 e,z5-2 e,-1-e,z5-e,z5-e,-e,-e,-e,1+e,2+e,1+z321-z5+e},
 {-4-8 e,z5-3 e,z5-3 e,-1-2 e,1-e,1-e,1-e,1+z321-e,-2 e},{z321,z5},1];
add["MB11u",114,-1,1,-2(1+e),z321-e,
 {-z321,-z4,-z4,1+z4,-z5,-2-4 e,-1-4 e,4-4 e,z5-2 e,-1+z4-e,-1-z321-z4-z5-e,z5-e,1+z321+z4+z5-e,-e,-e,2+e,1+z321+e,1-z5+2 e},
 {-3-8 e,-1-2 e,-z4-z5-2 e,1-e,1-e,1-e,1+z4+z5-e,-2 e},{z321,z4,z5},1];
add["MB12u",408,1,0,z2131+z23-e,z231+z321-e,
 {-z2131,-z23,-z231,-z321,-z331,-z5,1-4 e,1-4 e,4-4 e,-z23-z231-z331-4 e,-z2131-z321-z331-z5-2 e,z5-2 e,z2131+z321+z5-e,-e,z23+z231+e,z2131+z231+z331+e,1+z23+z321+z331+e,1-z5+2 e},
 {2-8 e,1-z5-4 e,-z331-3 e,1-e,1-e,-2 e},{z2131,z23,z231,z321,z331,z5},3];
add["MB13u",418,1,0,z2131+z23-e,z231+z321-e,
 {-z2131,-z23,-z231,-z321,-z331,-z5,1+z5,-z89,1+z89,4-4 e,-1-z2131-z321-z331+z89-4 e,-z23-z231-z331+z5+z89-4 e,z5-2 e,z89-2 e,-4 e,-4 e,-e,-e,1+z2131+z321+e,1+z2131+z231+z331+e,z23+z231-z5+e,z23+z321+z331-z89+e},
 {z5+z89-6 e,-z331+z89-3 e,1-e,1-e,1-e,-8 e,-2 e,-2 e},{z2131,z23,z231,z321,z331,z5,z89},1];
(* MB14u = MB14au + MB14bu (two eight-folds).  Served by MBStandardRunU["MB14u"] like the other families (benchmark
   maximum minus four); the inclusive MB14 (the u-integral) is summed by the general multifold handler
   (run_multifold_family.wls). *)
add["MB14au",416,1,0,-e + z2131 + z23,-e + z231 + z321 + z611,
 {-z2131,-z23,-z231,-z321,-z331,-z611,-z7,-z8,1 + z611 + z8,4 - 4*e,-4*e - z23 - z231 - z331 + z8,-2*e - z2131 - z321 - z331 - z7,-1 - 2*e + z7 + z8,-1 - e,-1 - e - z611 + z7,-e + z2131 + z321 + z7 + z8,2 + e,e + z23 + z231,e + z2131 + z231 + z331,1 + e + z23 + z321 + z331 - z8,2 + 2*e + z611 - z7 - z8,-4*e,-4*e},
 {1 - 4*e - z7,-3*e - z331 + z8,-1 - 2*e,1 - e,1 - e,-e + z7 + z8,-8*e,1 + e - z8},{z2131,z23,z231,z321,z331,z611,z7,z8},1];
add["MB14bu",416,1,-1,-1 - 2*e + z2131 + z23,-e + z231 + z321 + z611,
 {-z2131,-z23,-z231,-z321,-z331,-z611,-z7,4 - 4*e,-4*e - z23 - z231 - z331 + z8,-2*e - z2131 - z321 - z331 - z7,-1 - e - z611 + z7,-e + z611 + z8,-e + z2131 + z321 + z7 + z8,-e,1 + e,e + z23 + z231,e + z2131 + z231 + z331,1 + e + z23 + z321 + z331 - z8,1 + e + z611 - z7 - z8,-4*e,-4*e},
 {1 - 4*e - z7,-3*e - z331 + z8,-1 - 2*e,1 - e,1 - e,-8*e},{z2131,z23,z231,z321,z331,z611,z7,z8},1];
 ];
result = <|"Regulator" -> \[Epsilon], "Parameter" -> u, "Targets" -> entries,
 "ComponentGroups" -> <|"MB2u" -> {"MB21u", "MB22u"}, "MB8u" -> {"MB8au", "MB8bu"}, "MB14u" -> {"MB14au", "MB14bu"}|>,
 "OrderRanges" -> <|"MB1u" -> {-3,1}, "MB2u" -> {-2,0}, "MB3u" -> {-4,0},
 "MB4u" -> {-6,-3}, "MB5u" -> {-6,-3}, "MB6u" -> {-5,-2}, "MB7u" -> {-5,-1},
 "MB8u" -> {-6,-3}, "MB9u" -> {-6,-3}, "MB10u" -> {-6,-3}, "MB11u" -> {-6,-3},
 "MB12u" -> {-5,-1}, "MB13u" -> {-6,-3}, "MB14u" -> {-6,-3}|>,
 "TimeConstraints" -> <|"MB14u" -> 7200|>,
 (* release R3.1: the ranges verified on the Subtraction route (MBSubtractionRunU[name] without a range) -- each family to
    the order it had been computed to before -- and the Subtraction budget of a family (seconds; a ceiling, not a
    measurement: RUNTIME_RECORD.txt has the measured times) *)
 "SubtractionOrderRanges" -> <|"MB1u" -> {-3,4}, "MB2u" -> {-2,3}, "MB3u" -> {-4,3},
 "MB4u" -> {-6,0}, "MB5u" -> {-6,0}, "MB6u" -> {-5,1}, "MB7u" -> {-5,2},
 "MB8u" -> {-6,-3}, "MB9u" -> {-6,0}, "MB10u" -> {-6,0}, "MB11u" -> {-6,0},
 "MB12u" -> {-5,-1}, "MB13u" -> {-6,-3}, "MB14u" -> {-6,-3}|>,
 "SubtractionTimeConstraints" -> <|"MB1u" -> 86400, "MB2u" -> 86400, "MB3u" -> 86400, "MB4u" -> 86400, "MB5u" -> 86400,
 "MB6u" -> 86400, "MB7u" -> 86400, "MB8u" -> 86400, "MB9u" -> 86400, "MB10u" -> 86400, "MB11u" -> 86400, "MB12u" -> 86400,
 "MB13u" -> 86400, "MB14u" -> 86400|>|>;
EndPackage[];
MBStandardUExamples`result
