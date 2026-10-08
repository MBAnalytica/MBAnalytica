
Print["MBresolve 1.0"];
Print["by Alexander Smirnov"];
Print["more info in arXiv:0901.0386"];
Print["last modified 4 Jan 09"];

BeginPackage["MB`"]

(******************************************************************************
 *                                                                            *
 * Public                                                                     *
 *                                                                            *
 ******************************************************************************)

MBresolve::usage = "MBresolve[integrand,ep] resolves the singularities 
of the integrand, returning a list of MB integrals the same way as
MBrules followed my MBcontinue from the MB package"


Options[MBresolve] = {
  Verbose -> False,
  OptimizeNow -> False,
  ContourDebug -> False
};

Begin["`Private`"]

(******************************************************************************
 *                                                                            *
 * Private                                                                    *
 *                                                                            *
 ******************************************************************************)

RawPrint[x__]:=WriteString[$Output,x];
RawPrintLn[x__]:=WriteString[$Output,x,"\n"];
RawPrintLn[]:=WriteString[$Output,"\n"];

BadConfiguration[x_]:=Module[{temp},
    temp=(##[[1]]+##[[2]])&/@x;
    temp=Subsets[temp,{2}];
    temp=ExpandAll[Apply[Plus, temp, {1}]];
    temp=Select[temp,And[(Variables[##]==={}),##<=0,IntegerQ[##]]&];
    Length[temp]>0
]


MBfindResidues[{vars_,integrand_,conf_},LimVars_,{min_,max_},FixedPoint_,options___Rule]:=Module[{newpoint,function,point,badpoints,i,res,step,temp,
        opt = MB`Private`ParseOptions[MBfindResidues, options],verbose},
        verbose=Verbose/.opt;
    If[verbose,Print["Level: ",Length[vars]]];
    If[verbose,Print[conf]];
    If[FixedPoint===False,
       If[Length[vars]===0,
           If[verbose,Print["+"]];
           Return[{MBint[NONE,{Take[LimVars,1],{}}(*,conf/.LimVars*)]}]
        ];
        If[BadConfiguration[conf],If[verbose,Print["Bad configuration"]];Return[False]];
        If[Length[Union[(##[[1]])&/@conf]]=!=Length[conf],If[verbose,Print["Bad configuration"]];Return[False]];
        function=Plus@@(MB`Private`StepFunction/@(conf/.LimVars));
        point=Rationalize[NMinimize[function,vars,Method -> "DifferentialEvolution"],10^-5];
    ,
        point=Rationalize[FixedPoint,10^-5];
    ];
    If[point[[1]]>100,If[verbose,Print["?"]];Return[False]];
    If[verbose,Print[point]];
    If[point[[1]]<1,
        If[verbose,Print["+"]];
        Return[{MBint[NONE,{Take[LimVars,1],point[[2]]}(*,conf/.LimVars*)]}]
    ];    
    badpoints=Select[conf,(MB`Private`StepFunction[##/.Join[point[[2]],LimVars]]>0)&];
    If[verbose,Print[badpoints]];
    For[i=1,i<=Length[badpoints],i++,
        temp=badpoints[[i]];
        step={vars,integrand,conf/. {temp->temp+{0,1}}};
        temp=Plus@@temp;
        temp={Complement[Variables[temp],(##[[1]])&/@LimVars][[1]],temp};
        temp={Rule[temp[[1]],-(temp[[2]]/Coefficient[temp[[2]],temp[[1]]])/.(Rule[temp[[1]],0])],Sign[Coefficient[temp[[2]],temp[[1]]]]};
        If[verbose,Print[temp]];
        res={DeleteCases[vars,temp[[1]][[1]]],NONE,Union[Expand[DeleteCases[conf,badpoints[[i]]]/.temp[[1]]]]};
        res={res[[1]],res[[2]],Select[res[[3]],(Complement[Variables[##[[1]]],(##[[1]])&/@LimVars]=!={})&]};
        res=MBfindResidues[res,LimVars,{min,min+((max-min)/(Length[badpoints])+1)},False];
        If[res===False,Continue[]];
        Dots[min+((max-min)/(Length[badpoints]+1))];       
        step=MBfindResidues[step,LimVars,{min+((max-min)/(Length[badpoints]+1)),max},{point[[1]]-1,point[[2]]}];
        If[step===False,Continue[]];        
        Dots[max];
        Return[{MBmakeResidue[res,{temp[[2]],List@@(temp[[1]])}],step}];
    ];
    Return[False];
]

MBevaluateResidues[integrand_,residues_]:=Module[{temp},
    If[integrand===0,Return[{}]];
    If[Head[residues]===List,
        Return[MBevaluateResidues[integrand,##]&/@residues]
    ];
    If[Head[residues]===MBmakeResidue,
        MBevaluateResidues[residues[[2]][[1]]*MBresidue[integrand,residues[[2]][[2]]],residues[[1]]],
        Dots[];
        residues/.NONE->integrand
    ]
]


MBresolve[integrand_,ep_Symbol]:=MBresolve[integrand,{ep->0}]
MBresolve[integrand_,ep_Symbol,options___Rule]:=MBresolve[integrand,{ep->0},options]
MBresolve[integrand_,LimVars_List,options___Rule]:=Module[{args,vars,configuration,result,
            opt = MB`Private`ParseOptions[MBresolve, options],verbose},
            verbose=Verbose/.opt;
            optimizeNow=OptimizeNow/.opt;
    args = Cases[{Numerator[integrand]}, (Gamma | PolyGamma)[___, x_] :> x, -1];
    vars = Union[Cases[args /. LimVars, x_Symbol, -1]];
    args = Select[args,(Complement[Variables[##],(##[[1]])&/@LimVars]=!={})&];
    configuration={vars,integrand,{##,0}&/@args};
    PrepareDots[10];
    RawPrint["CREATING RESIDUES LIST"];
    RawPrintLn[MyTimingForm[AbsoluteTiming[
        result=MBfindResidues[configuration,LimVars,{0,10},False];
    ][[1]]]," seconds"];
    If[result===False,RawPrintLn["FAILED TO RESOLVE"];Return[False]];
    PrepareDots[Length[Position[result,MInt]]];
    RawPrint["EVALUATING RESIDUES"];
    RawPrintLn[MyTimingForm[AbsoluteTiming[
        result=MBevaluateResidues[integrand,result];
        result=Flatten[result,Infinity];
    ][[1]]]," seconds"];
    PrepareDots[Length[result]];
    If[optimizeNow,
        RawPrint["OPTIMIZING POINTS: "];
        RawPrintLn[MyTimingForm[AbsoluteTiming[
            result=MBshiftContours[result,If[TrueQ[ContourDebug/.opt],Verbose->True,Verbose->False]];
        ][[1]]]," seconds"];
    ];
    result
]

MyTimingForm[xx_]:=ToString[Chop[N[Round[xx,10^-4]],10^-4],InputForm]
PrepareDots[n_]:=Module[{temp},gn=n;gl={};For[gi=1,gi<=10,gi++,AppendTo[gl,Quotient[gi*gn,10]]];gi=0;]
Dots[]:=(gi++;While[And[Length[gl]>0,gi>=gl[[1]]],gl=Drop[gl,1];RawPrint["."]];)
Dots[x_]:=(gi=x;While[And[Length[gl]>0,gi>=gl[[1]]],gl=Drop[gl,1];RawPrint["."]];)

End[]

EndPackage[]
