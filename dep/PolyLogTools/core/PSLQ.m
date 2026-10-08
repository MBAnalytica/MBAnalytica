(* ::Package:: *)

(* ::Title:: *)
(*The PSLQ algorithm (based on P. Bertok' s package)*)


(* ::Section:: *)
(*My add ons*)


Options[RunPSLQ] = {Ginsh -> False, Rules -> {}};


PSLQ$Ginsh = False;


RunPSLQ[input_, basis_List, pre_, OptionsPattern[]] := Block[{inp, out},

   inp = Prepend[(basis//.$TranscendentalTag[a_,x_]:>x)//.OptionValue[Rules], input//.OptionValue[Rules]];
   PSLQ$Ginsh = OptionValue[Ginsh];
   out = PSLQ[inp, pre];
   PSLQ$Ginsh = False;
   Return[Expand[(-Rest[out].basis)/out[[1]]]]

];

qRunPSLQ[input_,basis_List,prec_]:= Module[{ll,rr},
	ll = Prepend[basis,-input];
	rr = FindIntegerNullVector[ll,WorkingPrecision->10^(-prec)];
	rr = Rationalize/@rr;
	Return[Rest[rr].basis];
]; 


(* ::Section:: *)
(*PSLQ based on Mathematica's FindIntegerNullVector*)


(* ::Text:: *)
(*There are two versions: one uses Ginsh to get numerics, the other one simply Mathematica's internal numerical routines. They are distinguished by an option.*)


Options[PSLQFit]=Options[RunPSLQ];
Options[PSLQFitMathematica]=Options[PSLQFit];
Options[PSLQFitGinsh]=Options[PSLQFit];


PSLQFit[input_,basis_List,prec_,OptionsPattern[]] := If[OptionValue[Ginsh],
    PSLQFitGinsh[input,basis,prec,Rules->OptionValue[Rules]],
   PSLQFitMathematica[input,basis,prec,Rules->OptionValue[Rules]]
];


PSLQFitMathematica[in_,basis_List,prec_,OptionsPattern[]] := Block[{pre,input=N[in,prec]},
    pre=FindIntegerNullVector[Prepend[basis,input]//.OptionValue[Rules]];
    Return[-Rest[pre].basis/pre[[1]]]
];


PSLQFitGinsh[in_,basis_List,prec_,OptionsPattern[]]:=Block[{pre=prec,Nbasis,Repart,Impart,input=N[in,prec]},
   pre=If[pre===MachinePrecision,15,pre]+5;
   Nbasis=Ginsh[#,{},PrecisionGoal->pre]&/@(basis //. OptionValue[Rules]);


   Repart=If[N[Re[input]]!=0.,
             FindIntegerNullVector[Re/@Prepend[Nbasis,input]],
             0];
   Impart=If[N[Im[input]]!=0.,
             FindIntegerNullVector[Im/@Prepend[I Nbasis,input]],
             0];

   If[(Impart=!=0)&&(Impart[[1]]===0), Return[$Failed]];
   If[(Repart=!=0)&&(Repart[[1]]===0), Return[$Failed]];


    Repart=If[Repart===0,
              0,
              -Rest[Repart]/Repart[[1]]];

    Impart=If[Impart===0,
              0,
              -Rest[Impart]/Impart[[1]]];
    pre=Repart+I Impart;
    If[pre===0,Return[0]];
    Return[pre.basis]
];


(* ::Section:: *)
(*PSLQ ((c) P. Bertok)*)


PSLQ[inx_List,prec_]:=
Block[
{
x,
n=Length[inx],
\[Gamma]=2/Sqrt[3],
A,B,H,D,Dinv,t,i,j,k,l,iter,
\[Alpha],\[Beta],\[Lambda],\[Delta],r,R
},
(*Initialize*)
(* CD: Here we introduce a hack, because wen= want to be able to use Ginsh instead of N *)
x = If[Not[PSLQ$Ginsh],
       N[inx /Sqrt[inx . inx],prec],
       Ginsh[#,{}, PrecisionGoal -> prec]& /@ (inx /Sqrt[inx . inx])
     ];


s=Sqrt[MapIndexed[Plus@@Drop[x^2,First[#2]-1]&,x]];
A=B=IdentityMatrix[n];
H=Table[Which[
i>j,(-x[[i]]*x[[j]])/(s[[j]]*s[[j+1]]),
i==j,s[[i+1]]/s[[i]],
i<j,0
],{i,1,n},{j,1,n-1}];
(* Reduce H *)
t=HermiteReduce[H];
D=First[t];
Dinv = Inverse[D];
(*Update*)
H=Last[t];x=x.Dinv;A=D.A;B=B.Dinv;
For[iter=0,iter<$IterationLimit,++iter,
(* Step One *)
r=MaxIndex[MapIndexed[\[Gamma]^First[#2] Abs[#1]&,Tr[H,List]]];
If[r<n-1,\[Alpha]=H[[r,r]];\[Beta]=H[[r+1,r]];\[Lambda]=H[[r+1,r+1]];\[Delta]=Sqrt[\[Beta]^2+\[Lambda]^2]];
R=IdentityMatrix[n];t=R[[r]];R[[r]]=R[[r+1]];R[[r+1]]=t;
x=x.R;H=R.H;A=R.A;B=B.R;
(* Step Two *)
If[r<n-1,
H=H.Table[
Which[
i==r&&j==r,\[Beta]/\[Delta],
i==r&&j==r+1,-\[Lambda]/\[Delta],
i==r+1&&j==r,\[Lambda]/\[Delta],
i==r+1&&j==r+1,\[Beta]/\[Delta],
i==j&&j!=r||i==j&&j!=r+1,1,
True,0],
{i,1,n-1},{j,1,n-1}]
];
(* Step Three *)
t=HermiteReduce[H];
D=First[t];
Dinv = Inverse[D];
(*Update*)
H=Last[t];x=x.Dinv;A=D.A;B=B.Dinv;
(* Step Four *)
If[Min[Abs[Union[x,Tr[H,List]]]]<=10^(-prec+5),Break[]]
];(*Main Iteraton*)
Return[Transpose[B][[MaxIndex[-Abs[x]]]]]
]


Recognize2[n_,po_,v_]:=PSLQ[N[Table[n^i,{i,0,po}],100],100].Table[v^i,{i,0,po}];

MaxIndex[x_List]:= Block[{i=1,j},Do[If[x[[j]]>x[[i]],i=j],{j,2,Length[x]}];i];

HermiteReduce[H_]:=Block[
{n=Length[H],i,j,k,q,H2=H,D=IdentityMatrix[Length[H]]},
Do[
q=Round[H[[i,j]]/H[[j,j]]];
Do[H2[[i,k]]-=q H2[[j,k]],{k,1,j}];
Do[D[[i,k]]-=q D[[j,k]],{k,1,n}];
,{i,2,n},{j,i-1,1,-1}];
{D,H2}
]
