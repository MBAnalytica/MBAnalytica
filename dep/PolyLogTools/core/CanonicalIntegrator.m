(* ::Package:: *)

(* ::Title:: *)
(*Canonical integrator*)


PLT$DropConstantsInCanonicalIntegration = False;



(* ::Section:: *)
(*Canonical integration via the bar construction*)


On[Assert];
DecomposeList[ll_List,n_Integer]:= TakeComposition[ll,#]&/@Compositions[Length[ll],n]
TakeComposition[ll_List,comp_List]:=Prepend[TakeComposition[Drop[ll,First[comp]],Rest[comp]],Take[ll,First[comp]]];
TakeComposition[ll_List,{}]:={};
BarCoproduct[symbol_,n_Integer]:= Module[{sym},
sym=symbol/.CiTi[ws___]:>Total[BarCp/@DecomposeList[{ws},n]]
];
bintegrate[barCp_BarCp,hypercube_List]:= Module[{tmp,crit},
tmp = barCp[[1]];
Assert[Length[tmp]===Length[hypercube]];
crit = And@@Table[(!FreeQ[Variables[tmp[[i]]],hypercube[[i]]])||tmp[[i]]==={},{i,1,Length[tmp]}];
If[crit===False,Return[0]];
tmp = Product[dlog[hypercube[[i]],tmp[[i]]],{i,1,Length[hypercube]}];
Return[tmp];
];
barPath[ws_List,vars_List]:= BarCp[Table[ws[[i]]/.(#->0&/@Drop[vars,i]),{i,1,Length[ws]}]];
BarIntegrate[barCoproduct_,hypercube_List]:=Module[{tmp,i},
tmp = barCoproduct/. BarCp[x_]:>barPath[x,hypercube];
tmp=Expand[tmp/. q_BarCp:>bintegrate[q,hypercube]];
For[i=1,i<=Length[hypercube],i++,
tmp = tmp /.dlog[hypercube[[i]],ws_List]f_.:>Module[{ft,ttt,j,dlogs},
ft = f /._dlog:>1;
dlogs = f/ft;
ttt = ft;
For[j=1,j<=Length[ws],j++,
ttt =GIntegrate[ttt D[Log[ws[[j]]],hypercube[[i]]],hypercube[[i]]];
];
ttt dlogs
];
];
tmp
];
BarnonicalIntegrate[sym_,vars_List]:= BarIntegrate[BarCoproduct[sym,Length[vars]],Reverse[vars]];


BarAntipode[sum_Plus]:=BarAntipode/@sum;
BarAntipode[a_ b_]:=a BarAntipode[b]/;FreeQ[a,Bar];
BarAntipode[a_]:=a/;FreeQ[a,Bar];
BarAntipode[b_Bar]:=(-1)^Length[b]Reverse[b];


(* ::Section::Closed:: *)
(*TensorTypes*)


Clear[TensorType];
TensorType[_. * fciti_CanInt$FrozenCiTi, var_] := TensorType[fciti, var];
TensorType[fciti_CanInt$FrozenCiTi, var_] := TensorType[fciti, var] = Not[FreeQ[#,var]]& /@ (List @@ fciti)


(* ::Section:: *)
(*CanIntCollect*)


CanIntCollect[polynomial_, var_] := CanIntCollect[polynomial, var] = Collect[polynomial, var, Expand];


(* ::Section:: *)
(**)


CanInt::Weight = "Tensor is not homogeneous.";
CanInt::Linear = "Prime factors are not linear in `1`.";
CanInt::NonConvergence = "Something went wrong... The algortihm did not converge."


$CanonicalPrimeElementOrder = {};
$ConstantSymbolHandler = Null;
CanonicalIntegrate[symbol_, variables_List] := Block[{
    var,
    rest,
    tensor = flatTensor[Expand[symbol]],
    listi, weight,
    primes, type, worktens, fittedtensor, canonG = 0, tofittens,ctmp
    },

    If[variables === {},
       Return[symbol]
       ];

    var = First[variables];
    rest= Rest[variables];

    (* Check if homogeneous in weight *)
    listi = If[Head[tensor] === Plus, 
               List @@ tensor,
               {tensor}
              ];
    listi = Union[listi //. {_ CiTi[as__] :> CiTi[as], -CiTi[as__]:>CiTi[as]}];
    listi = Union[Length /@ listi];
    If[Length[listi] =!= 1,
       Message[CanInt::Weight];
       Return[0]
       ];

    weight = listi[[1]];

    (* Prime elements *)
    primes = FindPrimeElements[tensor];
    (* Check if linear in the first variable *)
    If[Not[FreeQ[Expand[D[primes,var]], var]],
       Message[CanInt::Linear, var];
       Return[0]
      ];


    (* Collect the prime factors in var, and store the results *)
    primes = CanIntCollect[#, var]& /@ primes;

    (* Switch to frozen tensors, and collect variables *)
    tensor = tensor /. CiTi -> CanInt$FrozenCiTi /. CanInt$FrozenCiTi[as__] :> (CanIntCollect[#,var]& /@ CanInt$FrozenCiTi[as]);
    (* Main loop *)
    worktens = tensor;

    Do[
       type = Join[Table[False, {count}], Table[True, {weight-count}]];
    tofittens = If[worktens =!= 0,
                   Select[Expand[worktens + $$$$NULL], TensorType[#, var] === type&],
                   0
                   ];

       If[tofittens =!= 0,
          tofittens = FindCanonicalGs[tofittens, type, var, rest];
		    canonG = canonG + tofittens;
         ];
       fittedtensor = flatTensor[CreateTensor[tofittens]]/. CiTi -> CanInt$FrozenCiTi /. CanInt$FrozenCiTi[as__] :> (CanIntCollect[#,var]& /@ CanInt$FrozenCiTi[as]);
       worktens = ReduceTensorProduct[Expand@ReduceTensorProduct@Expand[worktens - fittedtensor /.CiTi[ws__]:>CiTi@@(Collect[#,var]&/@{ws}) //. $CanonicalPrimeElementOrder]/.CanInt$FrozenCiTi:>CiTi];(*/.(q_Integer+x_)/;q<0:>-$a((-q)-x)/.$a->1/.CiTi:>CanInt$FrozenCiTi;*)
       worktens=worktens/.(-1+$x_):>-$a(1-$x)/.(-2+$x_):>-$a(2-$x)/.$a->1;
       worktens=If[PLT$DropConstantsInCanonicalIntegration,RemoveConstantEntries[worktens],worktens]/.CiTi:>CanInt$FrozenCiTi;
      (*Print[Style[worktens//InputForm,Orange]];*)
	  $ttt = worktens;
		If[!FreeQ[$QExtension,I],
			worktens = Expand[worktens //. CiTi -> CanInt$FrozenCiTi //. CanInt$FrozenCiTi[a___,2,b___]:>CanInt$FrozenCiTi[a,(1+I),b]+CanInt$FrozenCiTi[a,(1-I),b]//. $CanonicalPrimeElementOrder];
		]
		,
       {count, 0, weight}
       ];
     If[worktens =!= 0,
        Message[CanInt::NonConvergence];
        Print[Style["!!! ",Red]];
		Print[worktens//InputForm];
        Print[fittedtensor];
		Print[tofittens];
		$test = worktens;
       ];
	(*Print[Style[canonG,Blue]];*)
	canonG  = canonG /. CiTi[ws__] :> ConstantSymbol[ws]/;FreeQ[{ws},Alternatives@@var];
	(*Print[canonG];*)
	ctmp = Select[Expand[canonG+$dummy+$dummy2]/.ConstantSymbol->csym,!FreeQ[#,csym]&];   
	(*Print[Style[ctmp,Directive[Bold,Purple]]];*)
	If[$ConstantSymbolHandler =!=Null && ctmp =!= 0,
		ctmp = $ConstantSymbolHandler[ctmp];
		canonG = (canonG/._ConstantSymbol:>0) + ctmp;
	];
     Return[canonG];
];
    
    


(* ::Section:: *)
(*FindCanonicalGs*)


LeftRightCollector[sum_Plus, a_] := LeftRightCollector[#, a]& /@ sum;
LeftRightCollector[a_. c_CanInt$FrozenCiTiRight, b_] := LeftRightCollector[a, c b];


LeftRightSummer[list_List] := {Plus @@ list[[All,1]], list[[1,2]]};


CanInt$FrozenCiTiSplit[as__, ntype_List] := CanInt$FrozenCiTiLeft[Sequence @@ Take[{as}, ntype[[1]]]]*CanInt$FrozenCiTiRight[Sequence @@ Drop[{as}, ntype[[1]]]];


FindCanonicalGs[tensi_, typ_, vari_, resti_] := Block[{
    temptensi = tensi, nleft, nright
    },

    (* Numberize the type *)
    nleft = Count[typ, False];
    nright = Count[typ, True];

    (* Split the tensor according to their type *)
    temptensi = temptensi /.  CanInt$FrozenCiTi[as__] :> CanInt$FrozenCiTiSplit[as, {nleft, nright}];

    (* Filter out the right from the left *)
    temptensi = LeftRightCollector[temptensi,1] /. CanInt$FrozenCiTiLeft|CanInt$FrozenCiTiRight -> CanInt$FrozenCiTi /. CanInt$FrozenCiTi[] ->1;

    temptensi = If[Head[temptensi] === Plus,
       List @@ temptensi,
       {temptensi}
      ];

    temptensi = GatherBy[temptensi, Last];
    temptensi = LeftRightSummer /@ temptensi;
    temptensi = {If[Not[FreeQ[#1, CanInt$FrozenCiTi]], CanonicalIntegrate[#1 /. CanInt$FrozenCiTi -> CiTi, resti], #1], If[Not[FreeQ[#2, CanInt$FrozenCiTi]], CreateCanomicalGs[#2, vari], #2]}& @@@ temptensi;
    temptensi = Plus @@ (Times @@@ temptensi);

    Return[temptensi];
];
    
    
    

    


(* ::Section:: *)
(*CreateCanomicalGs*)


MakeGRatio[polynom_, vars_] := MakeGRatio[polynom, vars] = -(polynom)/D[polynom, vars] /. vars ->0;


CreateCanomicalGs[cc_CanInt$FrozenCiTi, varis_] := CreateCanomicalGs[cc, varis] = Block[{
     cctens = Reverse[cc]
     },
 
     cctens = MakeGRatio[#, varis]& /@ cctens;
     cctens = G @@ (Append[cctens, varis]);

     Return[cctens];
];
     


(* ::Section:: *)
(*FitCanonicalMZV*)


(* ::Subsection:: *)
(*FitCanonicalMZVTerm*)


FitCanonicalMZVTerm[symbmat_, variables_List] := Block[{
   mzvtensor = ToSymbol[symbmat]
   },
   mzvtensor = CanonicalIntegrate[mzvtensor, variables];

   Return[mzvtensor];
];

    


(* ::Subsection:: *)
(*FitCanonicalPi2*)


Options[FitCanonicalPi2] = {Debug -> False, Rules->{}};


FitCanonicalPi2[coprodn1_, lastentries_List, point_List, variables_List, OptionsPattern[]] := Block[{
    dn1 = coprodn1,
    symbolmatrix
    },

    symbolmatrix = FitPi2[coprodn1, lastentries, point,OptionValue[Rules]];
    If[OptionValue[Debug],
       Print[symbolmatrix]
      ];

    If[symbolmatrix === {},
       Return[0]
      ];
   
     symbolmatrix = Expand[Plus @@ (Times @@@ symbolmatrix) /. Pi -> 1];
     symbolmatrix = FitCanonicalMZVTerm[symbolmatrix, variables];

     Return[Pi^2 symbolmatrix];
];
       


(* ::Subsection:: *)
(*FitCanonicalZ3*)


Options[FitCanonicalZ3] = {Debug -> False, Rules->{}};


FitCanonicalZ3[coprodn1_, lastentries_List, point_List, variables_List, OptionsPattern[]] := Block[{
    dn1 = coprodn1,
    symbolmatrix
    },

    symbolmatrix = FitZ3[coprodn1, lastentries, point,OptionValue[Rules]];
    If[OptionValue[Debug],
       Print[symbolmatrix]
      ];

    If[symbolmatrix === {},
       Return[0]
      ];

     symbolmatrix = Expand[Plus @@ (Times @@@ symbolmatrix) /. Zeta[3] -> 1];
     symbolmatrix = FitCanonicalMZVTerm[symbolmatrix, variables];

     Return[Zeta[3]*symbolmatrix];
];
       


(* ::Subsection:: *)
(*FitCanonicalPi4*)


Options[FitCanonicalPi4] = {Debug -> False, Rules->{}};


FitCanonicalPi4[coprodn1_, lastentries_List, point_List, variables_List, OptionsPattern[]] := Block[{
    dn1 = coprodn1,
    symbolmatrix
    },

    symbolmatrix = FitPi4[coprodn1, lastentries, point,OptionValue[Rules]];
    If[OptionValue[Debug],
       Print[symbolmatrix]
      ];

    If[symbolmatrix === {},
       Return[0]
      ];

     symbolmatrix = Expand[Plus @@ (Times @@@ symbolmatrix) /. Pi -> 1];
     symbolmatrix = FitCanonicalMZVTerm[symbolmatrix, variables];

     Return[Pi^4*symbolmatrix];
];
       


(* ::Subsection:: *)
(*FitCanonicalIPi*)


Options[FitCanonicalIPi] = {Debug -> False, Rules->{}};


FitCanonicalIPi[coprodn1_, lastentries_List, point_List, variables_List, OptionsPattern[]] := Block[{
    dn1 = coprodn1,
    symbolmatrix
    },

    symbolmatrix = FitIPi[coprodn1, lastentries, point,OptionValue[Rules]];
    If[OptionValue[Debug],
       Print[symbolmatrix]
      ];

    If[symbolmatrix === {},
       Return[0]
      ];
     symbolmatrix = Expand[Plus @@ (Times @@@ symbolmatrix) /. Pi -> -I];
     symbolmatrix = FitCanonicalMZVTerm[symbolmatrix, variables];

     Return[I Pi symbolmatrix];
];
       


(* ::Subsection:: *)
(*FitCanonicalZ3IPi3*)


Options[FitCanonicalZ3IPi3] = {Debug -> False, Rules->{}};


FitCanonicalZ3IPi3[coprodn1_, lastentries_List, point_List, variables_List, OptionsPattern[]] := Block[{
    dn1 = coprodn1,
    symbolmatrix, Rsymbolmatrix, Isymbolmatrix
    },
     symbolmatrix = FitZ3IPi3[coprodn1, lastentries, point,OptionValue[Rules]];
    If[OptionValue[Debug],
       Print[symbolmatrix]
      ];

    If[symbolmatrix === {},
       Return[0]
      ];
   
     symbolmatrix = Expand[Plus @@ (Times @@@ symbolmatrix)];
     Rsymbolmatrix = Coefficient[symbolmatrix, Zeta[3], 1];
     Isymbolmatrix = Expand[-I Coefficient[symbolmatrix, Pi, 3]];
     Rsymbolmatrix = FitCanonicalMZVTerm[Rsymbolmatrix, variables];
     Isymbolmatrix = FitCanonicalMZVTerm[Isymbolmatrix, variables];

     Return[Zeta[3] Rsymbolmatrix + I Pi^3 Isymbolmatrix];
];
       


(* ::Subsection:: *)
(*FitCanonicalPi4IPiZ3*)


Options[FitCanonicalPi4IPiZ3] = {Debug -> False, Rules->{}};


FitCanonicalPi4IPiZ3[coprodn1_, lastentries_List, point_List, variables_List, OptionsPattern[]] := Block[{
    dn1 = coprodn1,
    symbolmatrix, Rsymbolmatrix, Isymbolmatrix,tc1,tc2,tc3,tn1,tn2,tn3
    },

    symbolmatrix = FitPi4IPiZ3[coprodn1, lastentries, point,OptionValue[Rules]];
    If[OptionValue[Debug],
       Print[symbolmatrix]
      ];

    If[symbolmatrix === {},
       Return[0]
      ];

     symbolmatrix = Expand[Plus @@ (Times @@@ symbolmatrix)]+$SymbMatDummy;
     (*Rsymbolmatrix = Coefficient[symbolmatrix, Pi, 4];
     Isymbolmatrix = Expand[-I Coefficient[Coefficient[symbolmatrix, Zeta[3],1], Pi, 1]];
     Rsymbolmatrix = FitCanonicalMZVTerm[Rsymbolmatrix, variables];
     Isymbolmatrix = FitCanonicalMZVTerm[Isymbolmatrix, variables];*)
     tc1 = Select[symbolmatrix,!FreeQ[#,$TranscendentalTag[Pi4,_]]&]//._$TranscendentalTag:>1;
     tc2 = Select[symbolmatrix,!FreeQ[#,$TranscendentalTag[Z3IPi,_]]&]//._$TranscendentalTag:>1;
	 tc3 = Select[symbolmatrix,!FreeQ[#,$TranscendentalTag[Li412,_]]&]//._$TranscendentalTag:>1;
	
     tc1 = FitCanonicalMZVTerm[tc1,variables];
	 tc2 = FitCanonicalMZVTerm[tc2,variables];
     tc3 = FitCanonicalMZVTerm[tc3,variables];

 

     Return[tc1 Pi^4 + tc2 Zeta[3]*I*Pi + tc3 * (PolyLog[4,1/2]+Log[2]^4/24+7/8 Zeta[3]Log[2]-1/4 Zeta[2]Log[2]^2)];

     (*Return[Pi^4 *Rsymbolmatrix+ I Pi Zeta[3]Isymbolmatrix];*)
];
       


(* ::Section:: *)
(*Constant Symbols*)


ConstantSymbol[ws__] := G@@Append[Table[0,{Length[{ws}]}],{ws}[[1]]]/;Length[Union[{ws}]]===1
ConstantSymbol[2,3] = -G[0,1,1/3]+G[0,0,3];
ConstantSymbol[3,2] = G[0,1,-2];


(* ::Section:: *)
(*Public function*)


FiberSymbol = CanonicalIntegrate;
