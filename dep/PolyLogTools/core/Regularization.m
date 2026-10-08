(* ::Package:: *)

(* ::Title:: *)
(*Regularization*)


(* ::Section:: *)
(*Master routine*)


FindSingularSequence[asi_List, asing_] := Block[{},

   If[Length[asi] == 0,
      Return[asi]
     ];

   If[asi[[1]] === asing,
      Return[FindSingularSequence[Rest[asi], asing]];
     ];

   Return[asi];
   ];


(* ::Section:: *)
(*GRegularized*)


GReg[as__, x_] := GReg[as, x] = Block[{
    aslist = List[as],
    a1,
    asingular, anonsingular,
    regularized, REGULARIZATION$x
    },

    a1 = aslist[[1]];

    If[a1 =!= x, 
       Return[G[as, x]];
      ];

    anonsingular = FindSingularSequence[Rest[aslist], x];

    If[anonsingular ==={},
       Return[0]
      ];

    asingular = Table[x,{Length[aslist] - Length[anonsingular]}];

    regularized = Expand[Gfix[as,x] - ShuffleGfix[Gfix[Sequence @@ asingular, REGULARIZATION$x]Gfix[Sequence @@ anonsingular, REGULARIZATION$x]] /. REGULARIZATION$x -> x];
    
    Return[regularized /. Gfix -> GReg];
];

    


(* ::Section:: *)
(*Extraction of Zeroes*)


ExtractZeroes[expr_] := Expand[expr /. {G -> GZero,
        g_cG :> SV[GZero @@ g],
        g_cC :> ProductProjectorSV[SV[GZero @@ g]]
}];


Clear[GZero];
GZero[as__, x_] := GZero[as, x] = Module[{
    aslist = List[as],
    a1,
    asingular, anonsingular,
    regularized, REGULARIZATION$x
    },
    
    a1 = aslist[[-1]];

    If[a1 =!= 0, 
       Return[G[as, x]];
      ];

    anonsingular = Reverse[FindSingularSequence[Reverse[aslist], 0]];

    If[anonsingular ==={},
       Return[G[as,x]]
      ];
      
    asingular = Table[0,{Length[aslist] - Length[anonsingular]}];
    regularized = Expand[Gfix[as,x] + Gfix[Sequence @@ asingular, x]Gfix[Sequence @@ anonsingular, x]- ShuffleGfix[Gfix[Sequence @@ asingular, REGULARIZATION$x]Gfix[Sequence @@ anonsingular, REGULARIZATION$x]] /. REGULARIZATION$x -> x];

    Return[regularized /. Gfix -> GZero];
];

    




(* ::Section:: *)
(*Extraction of Singularities*)


(* ::Text:: *)
(*type = 0,1:*)
(*    type = 0: stuffle regularization (as used by HPL)*)
(*    type = 1: shuffle regularization*)
(*default is stuffle regularization*)


Options[ExtractSingularities] = {Regularization -> Stuffle};

ExtractSingularities[expr_, OptionsPattern[]] := Block[{
    RegularizationType = OptionValue[Regularization],
    temp = expr
    },
    RegularizationType = If[RegularizationType === Stuffle, 0, 1];

    temp = Expand[temp /. {G[ws__, x_] :> GSing[ws,x,RegularizationType],
          cG[ws__, x_] :> SV[GSing[ws,x,RegularizationType]],
          cC[ws__, x_] :> ProductProjectorSV[SV[GSing[ws,x,RegularizationType]]]}];

    temp = temp /. {G[as__,a_] :> G@@Table[1,{Length[{as}]+1}]/;Union[{as,a}] === {a},
          cG[as__,a_] :> cG@@Table[1,{Length[{as}]+1}]/;Union[{as,a}] === {a},
          cC[as__,a_,a_] :> 0/;Union[{as,a}] === {a}};

    Return[temp];
];

ExtractShuffleSingularities[expr_] := ExtractSingularities[expr, Regularization -> Shuffle];


GSing[as__, x_, type_] := GSing[as, x, type] = Block[{
    aslist = List[as],
    a1,
    asingular, anonsingular,
    regularized, REGULARIZATION$x, singularterm, singularweight
    },

    a1 = aslist[[1]];

    If[a1 =!= x, 
       Return[G[as, x]];
      ];

    anonsingular = FindSingularSequence[aslist, x];

    If[anonsingular ==={},
       Return[G[as,x]]
      ];

    asingular = Table[x,{Length[aslist] - Length[anonsingular]}];

    singularterm = Gfix[Sequence @@ asingular, x];
    If[type == 1,
       singularweight = Length[asingular];
       singularterm = 1/singularweight! G[x,x]^singularweight;
       ];
       

    regularized = Expand[Gfix[as,x] + singularterm*Gfix[Sequence @@ anonsingular, x]- ShuffleGfix[Gfix[Sequence @@ asingular, REGULARIZATION$x]Gfix[Sequence @@ anonsingular, REGULARIZATION$x]] /. REGULARIZATION$x -> x];
 
    Return[regularized /. Gfix[wwss__, xx_] :> GSing[wwss, xx, type]];
];

    


ShuffleRegulate = ExtractShuffleSingularities;
