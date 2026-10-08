(* ::Package:: *)

(* ::Title:: *)
(*Reduction of MPLs*)


(* ::Section::Closed:: *)
(*Factorize*)


Factorize[ff_, ll_] := Block[{
   factlist, facttmp, replist, 
   MONEpow = 0, out, MONE
   },

   factlist = FactorList[ff,Extension->$QExtension];
   replist = Table[ll[[i]] -> Random[], {i, 1, Length[ll]}];
   Do[facttmp = factlist[[i]];
      If[Re[Chop[Evaluate[facttmp[[1]] /. replist]]] < 0,
         MONEpow = MONEpow + facttmp[[2]];
         factlist = Delete[factlist, i];
         factlist = Insert[factlist, {Expand[(-1)*facttmp[[1]]], facttmp[[2]]}, i]
         ], 
      {i, 1, Length[factlist]}];

   factlist = Append[factlist, {MONE, MONEpow}];
   out = Product[factlist[[i, 1]]^factlist[[i, 2]], {i, 1, Length[factlist]}];

   Return[out /. {MONE -> -1}]
];


(* ::Section:: *)
(*CheckIfUniformWeight*)


CheckIfUniformWeight[expr_]:=Block[{temp=Expand[expr]},
   temp = If[Head[temp] === Plus,
             List@@temp, {temp}
            ];

   temp=Union[TranscendentalWeight/@temp];
   If[Length[temp]=!=1,
      Return[False],Return[True]
     ];
];


InitialiseFitBasis[weight_Integer] := Block[{basis = PLT$FitBasis, hashes},

   If[Not[And@@(CheckIfUniformWeight /@ basis)],
      Message[FitBasis::NotUniform];
      Return[];
     ];

   basis = DeleteCases[GetWeightTerms[#,weight]&/@basis,0];

   hashes = Hash /@ basis;
   Return[Inner[$TranscendentalTag,hashes,basis,List]];
];


Options[ReduceCG] = {Debug->False,PrecisionGoal->80,Point->Automatic,Rules->{}, ProgressIndicator -> True};
Options[ReduceCG1] := Options[ReduceCG];
Options[ReduceCG2] := Options[ReduceCG];
Options[ReduceCG3] := Options[ReduceCG];
Options[ReduceCG4] := Options[ReduceCG];
Options[ReduceCG5] := Options[ReduceCG];
Options[ReduceExpression] := Options[ReduceCG];


(* ::Section:: *)
(*ReduceCG*)


(* ::Subsection:: *)
(*Weight 6*)


(* The historical experimental weight-6 reducer below was disabled, but the
   master ReduceCG dispatcher still calls ReduceCG6.  Leaving that symbol
   undefined makes an exact GPL turn into the unevaluated expression
   ReduceCG6[..., List[...], Rule[...]], which is then sent to ginsh and
   rejected.  Reduction is optional: when no proved weight-6 basis reduction
   is installed, retain the exact GPL itself.  This is the same fail-closed
   identity behavior used by ReduceCG78 outside its certified table alphabet. *)
Options[ReduceCG6] := Options[ReduceCG];
ReduceCG6[expr_, variables_List, OptionsPattern[]] := expr;

(*Options[ReduceCG6] = {Point -> Automatic, Rules -> {}};*)


(*ReduceCG6::PSLQ = "PSQL did not converge for weight 6";
ReduceCG6[expr_,variables_List,OptionsPattern[]]:=Block[{
   temp = expr,
   tensor = flatTensor[CreateTensor[expr]],
   tores, d111111, d21111, lastentries, d3111, d411,d51, number, point, Rnumber, Inumber,aa,p1,p2
   },

   point = If[OptionValue[Point] === Automatic,
              Table[ii->Random[Real,0.5],{ii,DeleteCases[variables,NumericQ]}],
              OptionValue[Point]
             ];

   tores = CanonicalIntegrate[tensor, variables];

   d111111 = Expand[Delta111111[expr-tores]/.CT[a_,b_,c_,d_,e_,f_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							c/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							d/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							e/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							f/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
				]]//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder;
   lastentries = GetLastEntries[d111111,5];
   temp = FitCanonicalIPi[d111111,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores+temp;

   d21111 = Expand[Delta21111[expr-tores]/.CT[a_,b_,c_,d_,e_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							c/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							d/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							e/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
							]]//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder;
   lastentries = GetLastEntries[d21111,4];
   temp = FitCanonicalPi2[d21111,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores + temp;

   d3111 = Expand[Delta3111[expr-tores]/.CT[a_,b_,c_,d_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							c/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							d/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
							]]//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder;
   lastentries = GetLastEntries[d3111,3];
   temp = FitCanonicalZ3IPi3[d3111,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores+temp;

   d411 = Expand[Delta411[expr-tores]/.CT[a_,b_,c_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							c/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
							]]//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder;
   lastentries = GetLastEntries[d411,2];
   vPrint[lastentries];
   temp = FitCanonicalPi4IPiZ3[d411,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores + temp;

   d51 = Expand[Delta51[expr-tores]/.CT[a_,b_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							]]//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder;
   lastentries = GetLastEntries[d51,1];
   vPrint[Style["Del51",Purple]];
   vPrint[Style["Last Entries",Purple]];
   vPrint[lastentries];
   (*temp = FitCanonicalPi4IPiZ3[d41,lastentries,point,variables,Rules->OptionValue[Rules]];*)
   (*tores = tores + temp;*)


   number = Ginsh[expr-tores //. OptionValue[Rules],point,PrecisionGoal->80];
   Rnumber = Re[number];
   Inumber = Im[number];

  (* Rnumber = If[Abs[Rnumber]<10^(-35),
                0,
                p1 = RunPSLQ[Rnumber,{Zeta[5],Pi^2 Zeta[3],-(Pi^2*Log[2]^3)/36 + Log[2]^5/30 + Log[2]*PolyLog[4, 1/2] + 
 PolyLog[5, 1/2] + (7*Log[2]^2*Zeta[3])/16},50];
				p2 = RunPSLQ[Rnumber,{Zeta[5],Pi^2 Zeta[3],-(Pi^2*Log[2]^3)/36 + Log[2]^5/30 + Log[2]*PolyLog[4, 1/2] + 
 PolyLog[5, 1/2] + (7*Log[2]^2*Zeta[3])/16},60];
				If[Expand[p1-p2]=!=0,Message[ReduceCG5::PSLQ]];
				p2
                ];
   Inumber = If[Abs[Inumber]<10^(-35),
                0,
				p1 =  RunPSLQ[Inumber,{Pi^5,Pi(PolyLog[4,1/2]+Log[2]^4/24+7/8 Zeta[3]Log[2]-1/4 Zeta[2]Log[2]^2)},50];
				p2 =  RunPSLQ[Inumber,{Pi^5,Pi(PolyLog[4,1/2]+Log[2]^4/24+7/8 Zeta[3]Log[2]-1/4 Zeta[2]Log[2]^2)},60];
				If[Expand[p1-p2]=!=0,Message[ReduceCG5::PSLQ]];
				p2
                ];

   tores = tores + Rnumber + I Inumber;*)
   Return[tores];
];*)


(* ::Subsection:: *)
(*Weight 5*)


ReduceCG5::PSLQ = "PSQL did not converge for weight 5";
ReduceCG5[expr_,variables_List,OptionsPattern[]]:=Block[{
   temp = expr,
   tensor = flatTensor[CreateTensor[expr]],
   tores, d11111, d2111, lastentries, d311, d41, number, point, Rnumber, Inumber,aa,p1,p2
   },


   point = If[OptionValue[Point] === Automatic,
              vPrint[Style["Using random point.",Gray]];Table[ii->Random[Real,0.5],{ii,DeleteCases[variables,NumericQ]}],
              OptionValue[Point]
             ];

   tores = CanonicalIntegrate[tensor, variables];


   d11111 = Expand[Delta11111[expr-tores]/.CT[a_,b_,c_,d_,e_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							c/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							d/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							e/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
				]];
   d11111 = If[!FreeQ[$QExtension,I],d11111//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder,d11111];
   lastentries = GetLastEntries[d11111,4];
   vPrint["--",Style["Fitting I Pi",Orange]];
   temp = FitCanonicalIPi[d11111,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores+temp;

   d2111 = Expand[Delta2111[expr-tores]/.CT[a_,b_,c_,d_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							c/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							d/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
							]];
   d2111 = If[!FreeQ[$QExtension,I],d2111//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder,d2111];
   lastentries = GetLastEntries[d2111,3];
   vPrint["--",Style["Fitting Pi^2",Orange]];
   temp = FitCanonicalPi2[d2111,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores + temp;

   d311 = Expand[Delta311[expr-tores]/.CT[a_,b_,c_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							c/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
							]];
   d311 = If[!FreeQ[$QExtension,I],d311//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder,d311];
   lastentries = GetLastEntries[d311,2];
   vPrint["--",Style["Fitting Zeta3, I Pi^3",Orange]];
   temp = FitCanonicalZ3IPi3[d311,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores+temp;
   
   d41 = Expand[Delta41[expr-tores]/.CT[a_,b_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
							]];
   d41 = If[!FreeQ[$QExtension,I],d41//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder,d41];
   lastentries = GetLastEntries[d41,1];
   vPrint["--",Style["Fitting Pi^4, I Pi Zeta3",Orange]];
   temp = FitCanonicalPi4IPiZ3[d41,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores+temp;

   

   number = Ginsh[expr-tores //. OptionValue[Rules],point,PrecisionGoal->OptionValue[PrecisionGoal]];
   Rnumber = Re[number];
   Inumber = Im[number];

   Rnumber = If[Abs[Rnumber]<10^(-35),
                0,
                p1 = RunPSLQ[Rnumber,{Zeta[5],Pi^2 Zeta[3],-(Pi^2*Log[2]^3)/36 + Log[2]^5/30 + Log[2]*PolyLog[4, 1/2] + 
 PolyLog[5, 1/2] + (7*Log[2]^2*Zeta[3])/16},30];
				p2 = RunPSLQ[Rnumber,{Zeta[5],Pi^2 Zeta[3],-(Pi^2*Log[2]^3)/36 + Log[2]^5/30 + Log[2]*PolyLog[4, 1/2] + 
 PolyLog[5, 1/2] + (7*Log[2]^2*Zeta[3])/16},40];
				If[Expand[p1-p2]=!=0,Message[ReduceCG5::PSLQ]];
				p2
                ];
   Inumber = If[Abs[Inumber]<10^(-35),
                0,
				p1 =  RunPSLQ[Inumber,{Pi^5,Pi(PolyLog[4,1/2]+Log[2]^4/24+7/8 Zeta[3]Log[2]-1/4 Zeta[2]Log[2]^2)},30];
				p2 =  RunPSLQ[Inumber,{Pi^5,Pi(PolyLog[4,1/2]+Log[2]^4/24+7/8 Zeta[3]Log[2]-1/4 Zeta[2]Log[2]^2)},40];
				If[Expand[p1-p2]=!=0,Message[ReduceCG5::PSLQ]];
				p2
                ];

   tores = tores + Rnumber + I Inumber;
   Return[tores];
];


(* ::Subsection:: *)
(*Weight 4*)


ReduceCG4::PSLQ = "PSQL did not converge for weight 4";
ReduceCG4[expr_,variables_List,OptionsPattern[]]:=Block[{
   temp=expr,
   tensor=flatTensor[CreateTensor[expr]],
   tores,d1111,d211,lastentries,d31,number,point,Rnumber,Inumber,p1,p2
   },

   point = If[OptionValue[Point]===Automatic,
              vPrint[Style["Using random point.",Gray]];Table[ii->Random[Real,0.5],{ii,DeleteCases[variables,NumericQ]}],
              OptionValue[Point]
              ];

   tores = CanonicalIntegrate[tensor,variables];
   d1111 = Expand[Delta1111[Expand[expr-tores]]/.CT[a_,b_,c_,d_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							c/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							d/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
				]];
   d1111 = If[!FreeQ[$QExtension,I],d1111//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder,d1111];
   lastentries = GetLastEntries[d1111,3];
   vPrint["--",Style["Fitting I Pi",Orange]];
   temp = FitCanonicalIPi[d1111,lastentries,point,variables,Debug->False,Rules->OptionValue[Rules]];
   tores = tores+temp;
   
   d211 = Expand[Delta211[Expand[expr-tores]]/.CT[a_,b_,c_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							c/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
					]];
   d211 = If[!FreeQ[$QExtension,I],d211//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder,d211];
   lastentries = GetLastEntries[d211,2];
   vPrint["--",Style["Fitting Pi^2",Orange]];
   temp = FitCanonicalPi2[d211,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores+temp;
   
   d31 = Expand[Delta31[expr-tores]/.CT[a_,b_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
						]];
   d31 = If[!FreeQ[$QExtension,I],d31//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder,d31];
   lastentries = GetLastEntries[d31,1];
   vPrint["--",Style["Fitting Zeta3, I Pi^3",Orange]];
   temp = FitCanonicalZ3IPi3[d31,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores+temp;
   (***************hack ------ GToH should be automatic  *******)
   number = Ginsh[GToH[expr-tores]//.OptionValue[Rules],point,PrecisionGoal->OptionValue[PrecisionGoal]];
   Rnumber = Re[number];
   Inumber = Im[number];

   Rnumber = If[Abs[Rnumber]<10^(-35),
                0,
                p1 = RunPSLQ[Rnumber,{Zeta[4],PolyLog[4,1/2]+Log[2]^4/24+7/8 Zeta[3]Log[2]-1/4 Zeta[2]Log[2]^2,(Pi^2*Log[3]^2)/12-Log[3]^4/24+PolyLog[4,-1/3]-2*PolyLog[4,1/3]-(13*Log[3]*Zeta[3])/6},50];
				p2 = RunPSLQ[Rnumber,{Zeta[4],PolyLog[4,1/2]+Log[2]^4/24+7/8 Zeta[3]Log[2]-1/4 Zeta[2]Log[2]^2,(Pi^2*Log[3]^2)/12-Log[3]^4/24+PolyLog[4,-1/3]-2*PolyLog[4,1/3]-(13*Log[3]*Zeta[3])/6},60];
				If[Expand[p1-p2]=!=0,Message[ReduceCG4::PSLQ]];
				p2
                ];
   Inumber = If[Abs[Inumber]<10^(-35),
                0,
                Rationalize[Inumber/( Pi Zeta[3])]
                ];


   tores = tores + Rnumber + I Inumber Pi Zeta[3];
   Return[tores];
];


(* ::Subsection:: *)
(*Weight 3*)


ReduceCG3[expr_,variables_List,OptionsPattern[]]:=Block[{
   temp = expr,
   tensor = flatTensor[CreateTensor[expr]],
   tores,d111,d21,lastentries,number,point,Rnumber,Inumber
   },

   point = If[OptionValue[Point]===Automatic,
              vPrint[Style["Using random point.",Gray]];Table[ii->Random[Real,0.5],{ii,DeleteCases[variables,NumericQ]}],
              OptionValue[Point]
             ];

   tores = CanonicalIntegrate[tensor,variables];

   d111 = Expand[Delta111[expr-tores]/.CT[a_,b_,c_]:>CT[a,
							b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]],
							c/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]
				]];
   d111 =  If[!FreeQ[$QExtension,I],d111//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder,d111];
   lastentries = GetLastEntries[d111,2];
   vPrint["--",Style["Fitting I Pi",Orange]];
   temp = FitCanonicalIPi[d111,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores+temp;

   d21 = Expand[Delta21[expr-tores]/.CT[a_,b_]:>CT[a,b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]]];
   d21 = If[!FreeQ[$QExtension,I],d21//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder,d21];
   lastentries = GetLastEntries[d21,1];
   vPrint["--",Style["Fitting Pi^2",Orange]];
   temp = FitCanonicalPi2[d21,lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores+temp;

   number = Ginsh[expr-tores //. OptionValue[Rules] ,point,PrecisionGoal->OptionValue[PrecisionGoal]];
   Rnumber = Re[number];
   Inumber = Im[number];

   Rnumber = If[Abs[Rnumber]<10^(-35),
                0,
                Rationalize[Rnumber/Zeta[3]]
                ];
   Inumber=If[Abs[Inumber]<10^(-35),
              0,
              Rationalize[Inumber/Pi^3]
              ];


   tores = tores+Rnumber Zeta[3]+ I Pi^3 Inumber;
   Return[tores];
];


(* ::Subsection:: *)
(*Weight 2*)


ReduceCG2[expr_,variables_List,OptionsPattern[]]:=Block[{
   temp = expr,
   tensor = flatTensor[CreateTensor[expr]],  
   tores,d11,lastentries,number,point,Rnumber,Inumber,theipi
   },
   point = If[OptionValue[Point]===Automatic,
		      vPrint[Style["Using random point.",Gray]];Table[ii->Random[Real,0.5],{ii,DeleteCases[variables,NumericQ]}],
              OptionValue[Point]
              ];
   tores = CanonicalIntegrate[tensor,variables]/.G[a___,x_]:>G[Sequence@@(Simplify/@{a}),x];
   
   d11 = Expand[Delta11[expr-tores]/.CT[a_,b_]:>CT[a,b/.G->GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]]];
   d11 = If[!FreeQ[$QExtension,I],d11//.CT[a___,Log[2],b___]:>CT[a,Log[1+I],b]+CT[a,Log[1-I],b]//.$CanonicalPrimeElementOrder,d11];
   lastentries = GetLastEntries[d11,1];
   theipi=temp = FitCanonicalIPi[d11, lastentries,point,variables,Rules->OptionValue[Rules]];
   tores = tores+temp/.G[a___,x_]:>G[Sequence@@(Simplify/@{a}),x];
   number = Ginsh[expr-tores //. OptionValue[Rules],point,PrecisionGoal->80];
   Rnumber = Re[number];
   Inumber = Im[number];

   Rnumber = If[Abs[Rnumber]<10^(-35),
                0,
                Rationalize[Rnumber/Zeta[2]]
                ];
   Inumber = If[Abs[Inumber]<10^(-35),
                0,
				(*Rationalize[Inumber/Catalan]*)
				vPrint[Style["Warning, I Pi has been flipped!",Orange]];
				tores = tores - 2 theipi;
				number = Ginsh[expr-tores //. OptionValue[Rules],point,PrecisionGoal->80];
				Rnumber = Re[number];
			    Inumber = Im[number];
				Rnumber = If[Abs[Rnumber]<10^(-35),
                  0,
                  Rationalize[Rnumber/Zeta[2]]
                 ];
				Inumber = If[Abs[Inumber]<10^(-35),
                 0,
                 Message[W2Fit::FATAL,Inumber]
				 ];
                ];
   tores = tores + Rnumber Zeta[2] + Inumber;
   Return[tores];
];


(* ::Subsection::Closed:: *)
(*Weight 1*)


ReduceCG1::NonZero = "Difference of real parts did not evaluate to zero after rewriting.";

ReduceCG1[expr_,variables_List,OptionsPattern[]]:=Block[{
   temp = expr,
   tensor = flatTensor[CreateTensor[expr]],  
   tores,naive,d1,lastentries,number,point,Rnumber,Inumber,theipi
   },
   point = If[OptionValue[Point]===Automatic,
		      vPrint[Style["Using random point.",Gray]];Table[ii->Random[Real,0.5],{ii,DeleteCases[variables,NumericQ]}],
              OptionValue[Point]
              ];
   tores = CanonicalIntegrate[tensor,variables]/.G[a___,x_]:>G[Sequence@@(Simplify/@{a}),x];
   naive = expr /.Log[x_]:>G[0,x];
   d1=naive-tores;

   number = Ginsh[d1 //. OptionValue[Rules],point,PrecisionGoal->80];
   Rnumber = Re[number];
   Inumber = Im[number];

   Rnumber = If[Abs[Rnumber]<10^(-35),
                0,
                Message[ReduceCG1::NonZero];
				Abort[];
			];
   Inumber = If[Abs[Inumber]<10^(-35),
                0,
			   Rationalize[Inumber/Pi]
     		];
   tores = tores + Inumber I Pi;
   Return[tores];
];


(* ::Input:: *)
(**)


(* ::Input:: *)
(**)


(* ::Subsection:: *)
(*Master*)


ReduceCG[g_G,variables_List,OptionsPattern[]]:=Block[{weight=TranscendentalWeight[g],result,check,point,recheck,imcheck},

    If[Not[ValueQ[$Checker]],
       $Checker = {}
       ];

    If[Not[ValueQ[$GCounter]],
       $GCounter=0
      ];

	$GCounter=$GCounter+1;

	vPrint[Style["Rewriting...",Purple]];
	vPrint[$GCounter,")  ",g];
    vPrint["Point: ",OptionValue[Point]];
   result=Which[weight==1,ReduceCG1[g,variables,Point->OptionValue[Point], Rules -> OptionValue[Rules]],
   			 weight==2,ReduceCG2[g,variables,Point->OptionValue[Point], Rules -> OptionValue[Rules]],
                weight==3,ReduceCG3[g,variables,Point->OptionValue[Point], Rules -> OptionValue[Rules],PrecisionGoal->OptionValue[PrecisionGoal]],
                weight==4,ReduceCG4[g,variables,Point->OptionValue[Point], Rules -> OptionValue[Rules],PrecisionGoal->OptionValue[PrecisionGoal]],
                weight==5,ReduceCG5[g,variables,Point->OptionValue[Point], Rules -> OptionValue[Rules]],
                weight==6,ReduceCG6[g,variables,Point->OptionValue[Point], Rules -> OptionValue[Rules]],
                weight==7||weight==8||weight==9||weight==10,Return[ReduceCG78[g,variables,Point->OptionValue[Point], Rules -> OptionValue[Rules]]],
                True,Message[Red::G]
               ];

    point = If[OptionValue[Point]===Automatic,
               Table[ii->Random[Real,0.5],{ii,DeleteCases[variables,NumericQ]}],
               OptionValue[Point]
              ];

    check = Ginsh[g-result //. OptionValue[Rules],point];
    recheck = Re[check];
    imcheck = Im[check];
    If[Abs[recheck]<10^(-31),
       recheck=0];
    If[Abs[imcheck]<10^(-31),
       imcheck=0
      ];
    check = recheck + I imcheck;
    
    If[OptionValue[Debug],
       Print["( ", $GCounter, " ) >>> Cross check: ", check];
      ];
	AppendTo[$Checker,{g, check}];
    
    If[check =!= 0, result = result PLT$Failed];
    
    Return[g->result];
];


ReduceCG[list_List,variables_List,OptionsPattern[]]:=Block[{result,passed,failed},
	$Checker = {};
	$GCounter=0;

   If[OptionValue[Debug],
      Print["Rewriting ", Length[list], " functions..."];
     ];


    result = ReduceCG[#,variables,Point->OptionValue[Point], Rules -> OptionValue[Rules], Debug -> OptionValue[Debug], PrecisionGoal->OptionValue[PrecisionGoal]]&/@list;
    passed = Count[$Checker,{_,0}];
    failed = Length[$Checker]-passed;

    
    If[OptionValue[Debug],
       If[failed==0,
          Print[Style["All Passed!",Green]],
          Print[Style["Some failed!",Red]]
          ];
       Print["Passed: ",passed," / ", Length[$Checker]];
       Print["Failed: ",failed," / ", Length[$Checker]];
      ];

    If[failed =!= 0,
       Print["The following functions could not be reduced: ", First /@ $Checker]
       ];
    
    Return[result];
];


ReduceExpression[expr_,variables_List,OptionsPattern[]]:=Block[{point,rules,gs,red,alpha,mex},
	point = If[OptionValue[Point]===Automatic,
		      Table[ii->Random[Real,0.5],{ii,DeleteCases[variables,NumericQ]}],
              OptionValue[Point]
              ];
    rules = OptionValue[Rules];
	alpha = GetGIndices[expr];
	mex = DecomposeToLyndonWords[expr,Alphabet->alpha];
	gs = GetGs[mex];
	red = ReduceCG[gs,variables,Rules->rules,Point->point,Debug -> OptionValue[Debug]];
	Return[GatherTranscendentals[ShuffleG[expr //. red]]];
];


(*ReduceExpression[expr_,variables_List,OptionsPattern[]]:= Block[{matrix,res,total,nn,rules,point},
	point = If[OptionValue[Point]===Automatic,
		      Table[ii->Random[Real,0.5],{ii,DeleteCases[variables,NumericQ]}],
              OptionValue[Point]
              ];
    rules = OptionValue[Rules];
	matrix = GatherObjectsMatrix[expr,Gather->Rationals];
	res = ReduceCGExpression[#[[1]],variables,Rules->rules,Point->point, Debug -> OptionValue[Debug]]&/@matrix;
	total = Sum[res[[i]]matrix[[i,2]],{i,1,Length[matrix]}];
	nn = Ginsh[expr-total/.rules,point];
	nn = If[Abs[Re[nn]]<10^(-35),0,Re[nn]]+I If[Abs[Im[nn]]<10^(-35),0,Im[nn]];

    
    If[OptionValue[Debug],
   	If[nn===0,Print[Style["\.08Total check succeeded!",Green]],Print[Style["Total check failed:",Red],nn]];
      ];

	Return[total];
];*)


(*ReduceCGExpression::fail = "Weight `1` failed!";
ReduceCGExpression::totalFail = "Total expression failed.";
ReduceCGExpression[expr_,variables_List,OptionsPattern[]]:=Block[{o1,o2,o3,o4,o5,ohigh,r1=0,r2=0,r3=0,r4=0,r5=0,nn,point,rules,result},
	point = If[OptionValue[Point]===Automatic,
		      Table[ii->Random[Real,0.5],{ii,DeleteCases[variables,NumericQ]}],
              OptionValue[Point]
              ];
    rules = OptionValue[Rules];
	
	o1 = GetWeightTerms[expr,1];
	If[o1 =!= 0,
		vPrint["--- ",Style["Reducing weight 1",Orange]];
		r1 = ReduceCG1[o1,variables,Point->point,Rules->rules];
		nn = Ginsh[o1-r1/.rules,point];
		nn = If[Abs[Re[nn]]<10^(-35),0,Re[nn]]+I If[Abs[Im[nn]]<10^(-35),0,Im[nn]];
		vPrint[">>> Cross check weight 1: ", nn];
		If[nn =!= 0, Message[ReduceCGExpression::fail,1]];
	];

	o2 = GetWeightTerms[expr,2];
	
	If[o2 =!= 0,
		vPrint["--- ",Style["Reducing weight 2",Orange]];
		r2 = ReduceCG2[o2,variables,Point->point,Rules->rules];
		nn = Ginsh[o2-r2/.rules,point];
		nn = If[Abs[Re[nn]]<10^(-35),0,Re[nn]]+I If[Abs[Im[nn]]<10^(-35),0,Im[nn]];
		vPrint[">>> Cross check weight 2: ", nn];
		If[nn =!= 0, Message[ReduceCGExpression::fail,2]];
	];

	o3 = GetWeightTerms[expr,3];
	
	If[o3 =!= 0,
		vPrint["--- ",Style["Reducing weight 3",Orange]];
		r3 = ReduceCG3[o3,variables,Point->point,Rules->rules];
		nn = Ginsh[o3-r3/.rules,point];
        $Transfer = o3;
		nn = If[Abs[Re[nn]]<10^(-35),0,Re[nn]]+I If[Abs[Im[nn]]<10^(-35),0,Im[nn]];
		vPrint[">>> Cross check weight 3: ", nn];
		If[nn =!= 0, Message[ReduceCGExpression::fail,3];Abort[]];
	];

	o4 = GetWeightTerms[expr,4];
	
	If[o4 =!= 0,
		vPrint["--- ",Style["Reducing weight 4",Orange]];
		r4 = ReduceCG4[o4,variables,Point->point,Rules->rules];
		nn = Ginsh[o4-r4/.rules,point];
		nn = If[Abs[Re[nn]]<10^(-35),0,Re[nn]]+I If[Abs[Im[nn]]<10^(-35),0,Im[nn]];
		vPrint[">>> Cross check weight 4: ", nn];
		If[nn =!= 0, Message[ReduceCGExpression::fail,4]];
	];
	
	o5 = GetWeightTerms[expr,5];
	If[o5 =!= 0,
		vPrint["--- ",Style["Reducing weight 5",Orange]];
		r5 = ReduceCG5[o5,variables,Point->point,Rules->rules];
		nn = Ginsh[o5-r5/.rules,point];
		nn = If[Abs[Re[nn]]<10^(-35),0,Re[nn]]+I If[Abs[Im[nn]]<10^(-35),0,Im[nn]];
		vPrint[">>> Cross check weight 5: ", nn];
		If[nn =!= 0, Message[ReduceCGExpression::fail,5]];
	];
	result = r1 + r2 + r3 + r4 + r5;
	ohigh = Expand[expr - o1 -o2 -o3 -o4 -o5];
	nn = Ginsh[(o1+o2+o3+o4+o5)-result/.rules,point];
	nn = If[Abs[Re[nn]]<10^(-35),0,Re[nn]]+I If[Abs[Im[nn]]<10^(-35),0,Im[nn]];

    If[OptionValue[Debug],
   	Print[">>> Cross check total expression: ", nn];
      ];

	If[nn =!= 0, Message[ReduceCGExpression::totalFail]];
	Return[result+ohigh];
];*)


(* ::Section:: *)
(*FiberExpression*)


(* ::Subsection:: *)
(*CheckAlphabetLinearityQ*)


Fiber::Linear = "Cannot fiber `1`. Alphabet is not linear in `2`.";


CheckAlphabetLinearityQ[gg_G, vars_List] := CheckAlphabetLinearityQ[gg, vars] = Block[{symb = ComputeSymbol[gg]},
    symb = FindPrimeElements[symb];
    symb = Table[{$$x, And @@ (IsLinearQ[#, $$x]&/@ symb)}, {$$x, vars}];
    If[Not[#[[2]]], Message[Fiber::Linear, gg, #[[1]]]]& /@ symb;
    Return[{gg,And @@ (Last /@ symb)}];
];


(* ::Subsection:: *)
(*ReduceCGSingleG*)


Options[ReduceCGSingleG] := Options[ReduceCG];


Fiber::Failed = "Fatal error: rewritten expression does not match input numerically for `1`.";
Fiber::SkippedCheck = "Ginsh unavailable; fiber numeric check skipped for `1`.";


ReduceCGSingleG[gg_G,vars_List,point_List] := ReduceCGSingleG[gg,vars,point] = Block[{testQ,fintest,rule},
    testQ = CheckAlphabetLinearityQ[gg, vars];
    If[Not[testQ[[2]]], Return[Rule[gg,gg]]
       ];
    rule = ReduceCG[gg,vars,Point -> point];
    fintest = Quiet@Check[Ginsh[rule[[1]] - rule[[2]], point], $GinshUnavailable];
    Which[
      NumericQ[fintest] && Chop[N[fintest], 10^-8] =!= 0,
        Message[Fiber::Failed, gg]; Return[Rule[gg,gg]],
      fintest =!= 0 && !NumericQ[fintest],
        Message[Fiber::SkippedCheck, gg]];
    Return[rule];
]; 




(* ::Subsection:: *)
(*FiberExpression*)


Options[ToFibrationBasis] := Join[Options[ReduceCG],{Save -> "",Input -> "",FitValue -> Automatic}];
SetOptions[ToFibrationBasis, ProgressIndicator -> False];


DoWithCounterReduceCGSingleG[gg_,vars_List,point_List] := Module[{},
    PLT$FibrationCounter++;
    ReduceCGSingleG[gg,vars,point]
];


PLT$FibrationCounter = 0;


ToFibrationBasis[x_List,y_,O:OptionsPattern[]]:=Function[t,ToFibrationBasis[t,y,O],Listable][x]
ToFibrationBasis[expr_,vars_List,OptionsPattern[]] := Module[{$gs,temp = LiToG[HPLToG[HToG[expr]]],point,Ngs,outlist = {},
    progressindicator = OptionValue[ProgressIndicator],
    $cgs,$ccs,$hs,$hpls,$logs,$polylogs,varlist,$hgs,$hplgs,$loggs,$polyloggs,$cggs,disp,outlist2},

  (*  If[Head[expr] === List, 
       Return[ToFibrationBasis[#,vars,FitValue->OptionValue[FitValue],Save->OptionValue[Save],Input->OptionValue[Input],ProgressIndicator->OptionValue[ProgressIndicator],Debug->OptionValue[Debug]]&/@expr]
      ];*)

    outlist = If[OptionValue[Input] =!= "",
               Get[OptionValue[Input]], {}
             ];


    PLT$FibrationCounter = 0;
    point = OptionValue[FitValue];
    If[point === Automatic,
       point = Rule[#,Random[]]& /@ vars 
      ];

    varlist = Union[Variables[temp]//.CT -> Sequence];
    varlist = Union @@ (Variables /@ varlist);
    $gs = Select[Cases[varlist, _G], Not[FreeQ[#,Alternatives@@vars]]&];
    $cgs = Select[Cases[varlist, _cG], Not[FreeQ[#,Alternatives@@vars]]&];
    $ccs = Select[Cases[varlist, _cC], Not[FreeQ[#,Alternatives@@vars]]&];
    $hs = Select[Cases[varlist, _Log|_PolyLog], Not[FreeQ[#,Alternatives@@vars]]&];

    $hgs = $hs //. {Log[x_]:> G[0,x],
                    PolyLog[n_,x_] :> - G[Sequence@@Table[0,{n-1}],1,x],
                    PolyLog[m_,n_,x_] :> (-1)^n * G[Sequence@@Table[0,{m}],Sequence@@Table[1,{m}],x]
                    };
    $cggs = G @@@ Complement[$cgs, First /@ outlist];
    $ccs = Complement[$ccs, First /@ outlist];
    $gs = Complement[Union[$gs,GetGs[$hgs]], First /@ outlist];
    
    If[progressindicator,
       Ngs = Length[Union[$gs,$cgs,$ccs]];
       Print["Working on ", Dynamic[PLT$FibrationCounter],"/",Ngs]
      ];
    
    If[$gs =!= {},
       outlist = If[progressindicator,
                    DoWithCounterReduceCGSingleG[#,vars,point]& /@ $gs,
                    ReduceCGSingleG[#,vars,point]& /@ $gs
                    ];
       outlist = DeleteCases[outlist, Rule[x_,x_]];
       disp = Dispatch[outlist];
       $hgs = Inner[Rule, $hs, $hgs //. disp, List];
       outlist = Join[outlist, $hgs,outlist];
      ];

    If[($cgs =!= {}) || ($ccs =!= {}),
       point = If[Im[#[[2]]] == 0., Rule[#[[1]],#[[2]]+I*0.01],#]&/@point
       ];

    If[$cgs =!= {},
       outlist2 = If[progressindicator,
                     DoWithCounterReduceCGSingleG[#,vars,point]& /@ $cggs,
                     ReduceCGSingleG[#,vars,point]& /@ $cggs
                     ];
       outlist2 = DeleteCases[outlist2, Rule[x_,x_]];
       outlist2 = Rule[SV[#[[1]]], SV[Expand[#[[2]]]]]& /@outlist2;
       outlist = Join[outlist,outlist2];
      ];

    If[$ccs =!= {},
       outlist2 = If[progressindicator,
                     DoWithCounterReducecC[#,vars,point]& /@ $ccs,
                     ReducecC[#,vars,point]& /@ $ccs
                     ];
       outlist2 = DeleteCases[outlist2, Rule[x_,x_]];
       outlist2 = Rule[SV[#[[1]]], SV[Expand[#[[2]]]]]& /@outlist2;
       outlist = Join[outlist,outlist2];
      ];

    If[OptionValue[Save] =!= "",
       Put[outlist, OptionValue[Save]];
       ];
       
    Return[temp //. outlist];
];  


FitcCConstant[nn_,base_] := Block[{pslq1,pslq2},
    pslq1 = PSLQFit[nn,base,15];
    pslq2 = PSLQFit[nn,base,20];
    If[Expand[pslq1 - pslq2] =!= 0, Return[PLT$Constant[nn]]];
    Return[pslq1];
];


ReducecC[gg_cC,vars_List,point_List] := ReducecC[gg,vars,point] = Block[{testQ,fintest,rule,gcc = G@@gg,symbcC,weight=Length[gg]-1,num,const},
    testQ = CheckAlphabetLinearityQ[gcc, vars];
    If[Not[testQ[[2]]], Return[Rule[gg,gg]]
       ];

    symbcC = ProductProjectorSV[SV[Expand[FiberSymbol[ComputeSymbol[gcc],vars]]]];
    num = Ginsh[gg-symbcC, point];

    const= If[num === 0, 0,
              Which[weight == 1, PLT$Constant[num],
                    weight ==2, PLT$Constant[num],
                    weight ==3, FitcCConstant[num, {Zeta[3]}],
                    weight ==4, FitcCConstant[num, {PolyLog[4,1/2]}],
                    weight ==5, FitcCConstant[num, {Zeta[5],PolyLog[5,1/2]}],
                    weight ==6, FitcCConstant[num, {PolyLog[6,1/2]}],
                    True, PLT$Constant[num]
                    ]
                 ];
 
    rule = Rule[gg, symbcC + const];

    If[FreeQ[rule,PLT$Constant],
       fintest = Quiet@Check[Ginsh[rule[[1]] - rule[[2]], point], $GinshUnavailable];
       Which[
         NumericQ[fintest] && Chop[N[fintest], 10^-8] =!= 0,
           Message[Fiber::Failed, gg]; Return[Rule[gg,gg]],
         fintest =!= 0 && !NumericQ[fintest],
           Message[Fiber::SkippedCheck, gg]];
      ];
    Return[rule];
];


DoWithCounterReducecC[gg_,vars_List,point_List] := Module[{},
    PLT$FibrationCounter++;
    ReducecC[gg,vars,point]
];
