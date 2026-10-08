(* ::Package:: *)

(* ::Title:: *)
(*Denominator reduction*)


(* ::Section:: *)
(*CheckPrimePolynomials*)


Polys::NonPoly = "Only polynomials are accepted as prime elements.";
Polys::Dupl = "Found duplicated in list of polynomials. They are removed.";
Polys::Prime = "Some of the polynomials were not prime. They are factored into prime polynomials.";


CheckPrimePolynomials[list_List]:=Block[{check,list2 = flat /@ Expand[list]},

    check=And@@(PolynomialQ/@list2);
    If[Not[check],
       Message[Polys::NonPoly];
       Return[{}];
       ];

    check=(Length[list2]==Length[Union[list2]]);
    If[Not[check],
       Message[Polys::Dupl];
       ];
    list2=Union[list2];

    list2=Factor[list2,Extension->$QExtension];
    check=Union[Head/@list2];
    If[Not[FreeQ[check,Times|Power]],
       Message[Polys::Prime];
       list2=If[Head[#]===Times,Sequence@@#,#]&/@list2;
       list2=If[Head[#]===Power,#[[1]],#]&/@list2;
       list2=Union[list2];
       ];

    Return[list2];
];




(* ::Section:: *)
(*ReduceSet*)


IsLinearQ=FreeQ[D[#1,#2],#2]&;


Options[ReduceSet]={CheckPrimePolynomials->True};


ReduceSet[set_List,var_,allv_:{},OptionsPattern[]]:=Block[{islinear,
   contractionsdeletions,mixed,polys=set,allvars=allv
   },

   If[OptionValue[CheckPrimePolynomials],
      polys=CheckPrimePolynomials[polys];
      If[polys==={},
         Return[False]
         ];
      ];

    If[allvars==={},
       allvars=Variables[set];
      ];

    (* Check if all linear *)
    islinear=IsLinearQ[set,var];

    (* If not, stop *)
    If[Not[islinear],
       Return[False]
       ];

    contractionsdeletions={#/.var->0,D[#,var]}&/@set;
    mixed=Flatten[Table[contractionsdeletions[[i,1]]contractionsdeletions[[j,2]]-contractionsdeletions[[j,1]]contractionsdeletions[[i,2]],{i,Length[contractionsdeletions]},{j,Length[contractionsdeletions]}]];
    mixed=Union[Flatten[contractionsdeletions],mixed];
    mixed=Union[Flatten[ImprovedFactorList/@mixed]/.FactorListTerm[a_,_]:>a];
    mixed=DeleteCases[mixed,Alternatives@@allvars];

    mixed=Select[mixed,Not[FreeQ[#,Alternatives@@allvars]]&];

    Return[mixed];
];



(* ::Section:: *)
(*IsGoodIntegrationOrder*)


Options[IsGoodIntegrationOrder]={Dialog->False, CheckPrimePolynomials -> True};

IsGoodIntegrationOrder[set_List,path_List,OptionsPattern[]]:=Block[{polys=set,intvars=path,curvar},

   If[OptionValue[CheckPrimePolynomials],
      polys=CheckPrimePolynomials[polys];
      ];

   If[polys==={},
      Return[False]
     ];

   Catch[While[Length[intvars]>1,
               curvar=intvars[[1]];
               polys=ReduceSet[polys,curvar,intvars,CheckPrimePolynomials->False];
               If[polys===False,
                  Throw[False]
                  ];
               If[OptionValue[Dialog],
                  Print[curvar," -> ", polys]
                 ];
               intvars=Rest[intvars];
               ]
         ];

   Return[True];
];


(* ::Section:: *)
(*FindIntegrationOrder*)


Polys::Perms = "Number of integration variables should not exceed `1`.";


Options[FindIntegrationOrder]={CheckPrimePolynomials->True};


FindIntegrationOrder[set_List,vars_List,OptionsPattern[]]:=Block[{n=Length[vars],perms,polls,work,permn,found=False},

   If[n<=PLT$MaxDenominatorReductionVariables,
      perms=Permutations[vars],
      Message[Polys::Perms, PLT$MaxDenominatorReductionVariables]; Abort[]
      ];

   polls=CheckPrimePolynomials[set];

   permn=0;
   While[Not[found]&&(permn<n!),
         permn=permn+1;
         found=IsGoodIntegrationOrder[polls,perms[[permn]],CheckPrimePolynomials->False];
         ];

    If[found,Return[perms[[permn]]],Return[{}]];

];


CheckPrimePolynomials::usage = "\t (True,False)\t Default: True \n Determines whether the function is suppossed to test if the polygons form a set of prime polynomials before each step in the integration."
