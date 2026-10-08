(* ::Package:: *)

BuildShuffleBasis::usage = "BuildShuffleBasis builds a complete basis from bases of the ideals of the shuffle algebra at different weights.
Usage:
	BuildShuffleBasis[w1Ideals,w2Ideals,...]
Result:
	{w1Basis,w2Basis,...}
	w1Basis is just the unmodified input w1Ideals, while w2Basis is w2Ideals ~ w1Ideals \[CircleDot] w1Ideals  etc ";
BuildShuffleBasis[basisIdeals__List]:=Block[{ll={basisIdeals},w=TranscendentalWeight[{basisIdeals}[[-1,1]]],w2p,w3p,w3p21,w4p,w4p22,w4p211,w4p31,res},
	If[w=!=Length[ll],Print["Malformed basis of ideals given"];Abort[]];
	If[w>=1,
		res={ll[[1]]};
	];
	If[w >=2,
		w2p=Union@Flatten@Outer[Times,ll[[1]],ll[[1]]];
		res=Append[res,Union@Join[ll[[2]],w2p]];
	];
	If[w >=3,
		w3p=Union@Flatten@Outer[Times,ll[[1]],w2p];
		w3p21 = Union@Flatten@Outer[Times,ll[[1]],ll[[2]]];
		res=Append[res,Union@Join[ll[[3]],w3p,w3p21]];
	];
	If[w>=4,
		w4p = Union@Flatten@Outer[Times,ll[[1]],w3p];
		w4p22 = Union@Flatten@Outer[Times,ll[[2]],ll[[2]]];
		w4p211 = Union@Flatten@Outer[Times,ll[[2]],w2p];
		w4p31 = Union@Flatten@Outer[Times,ll[[3]],ll[[1]]];
		res=Append[res,Union@Join[ll[[4]],w4p,w4p22,w4p211,w4p31]];
	];
	If[w>=5,
		Print[Style["BuildShuffleBasis[] currently only supports bases up to weight 4",Directive[Bold,Orange]]];
	];
	res
];

FitToSymbolBasis[symbol_]:=Module[{tensors = Union[Cases[symbol,_CiTi,Infinity]],eqns,coarr},
				  coarr = CoefficientArrays[symbol,tensors];
				  Assert[First[coarr]===0];
				  eqs=Last/@ArrayRules[Last[coarr]];
				  Flatten[Solve[eqs==0]]]

DoSlFit::usage="\!\(\*
StyleBox[\"DoSlFit\",\nFontWeight->\"Bold\"]\) tries to fit the given symbol to the tensor basis symbols[[w]] of the appropriate weight w.
functions and symbols should be obtained from BuildShuffleBasis. The function will output an error and abort if the 
given symbol contains prime elements that are not in the basis.";
DoSlFit[gsym_,functions_List,symbols_List,w_Integer]:=Block[{fres,wBasis,wBasisF,slres,ddel},
	wBasisF = Sum[functions[[w,i]]c[i],{i,Length[functions[[w]]]}];
	wBasis = Sum[symbols[[w,i]]c[i],{i,Length[symbols[[w]]]}];
		   
	fres = FitToSymbolBasis[wBasis-gsym];
	If[fres ==={},
		Print[Style["Failed to fit the given symbol at weight "<>ToString[w] <> " to the given basis",Orange]];
		Print["Prime elements of the symbol: ",FindPrimeElements[gsym]];
		Print["Prime elements of the basis: ",Union@Flatten[ FindPrimeElements/@(Flatten@symbols)]];
        (*Abort[];*)
        Return[$Failed];
	];
	wBasisF/.fres
];

$PLTSimplifyImaginary=False;
DoFit[g_,functions_List,symbols_List,{point__Rule},1]:=Block[{gsym,slres,ddel,num,rnum,inum},
	gsym = ComputeSymbol[g];
    If[$PLTSimplifyImaginary,
        gsym = (gsym//.im->I)//.Complex[a_,b_]:>(a+b*im);];
	slres = DoSlFit[gsym,functions,symbols,1];
	ddel = g-slres;
	num = Ginsh[ddel,{point}];
	rnum=Re[num];
	inum=Im[num];
	Assert[Abs[rnum]<10^(-20)];
	inum = If[Abs[inum] < 10^(-20),0,Rationalize[inum/Pi,10^(-20)]];
	slres + inum I Pi
];


DoFit[g_,functions_List,symbols_List,{point__Rule},2]:=Block[{gsym,slres,ddel,d11,ll,numl,c11,num},
	gsym = ComputeSymbol[g];
    If[$PLTSimplifyImaginary,
        gsym = (gsym//.im->I)//.Complex[a_,b_]:>(a+b*im);];
	slres = DoSlFit[gsym,functions,symbols,2];
	ddel = g-slres;
	d11 =Expand[Delta11[ddel]/.CT[a_,b_]:>CT[a,b/.G:>GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]]]];
	ll = GatherBy[(List@@d11)/.f_. CT[a_,b_]:>{f a, b},#[[2]]&];
	ll = {Total[#[[;;,1]]],#[[1,2]]}&/@ll;
	numl = {Rationalize[Ginsh[#[[1]],{point}]/Pi,10^(-20)]Pi,#[[2]]}&/@ll;
	c11 = Total[Times@@@numl];
	
	ddel = g - (slres + c11);
	num = Rationalize[Ginsh[ddel,{point}]/Zeta[2],10^(-20)]Zeta[2];
	slres + c11 + num
];


DoFit[g_,functions_List,symbols_List,{point__Rule},3]:=Block[{gsym,slres,ddel,d111,ll,numl,c111,d21,c21,num,buml,inum,rnum},
	gsym = ComputeSymbol[g];
    If[$PLTSimplifyImaginary,
        gsym = (gsym//.im->I)//.Complex[a_,b_]:>(a+b*im);];
	slres = DoSlFit[gsym,functions,symbols,3];
	ddel = g-slres;
	d111 =Expand[Delta111[ddel]/.CT[a_,b_,c_]:>CT[a,Sequence@@({b,c}/.G:>GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]])]];
	ll = GatherBy[(List@@d111)/.f_. CT[a_,b_,c_]:>{f a, ToSymbol[CT@@{b,c}]},#[[2]]&];
	ll = {Total[#[[;;,1]]],#[[1,2]]}&/@ll;
	numl = {Rationalize[Ginsh[#[[1]],{point}]/Pi,10^(-20)]Pi,#[[2]]}&/@ll;
	numl=Select[numl,!(Abs[#[[1]]]<10^(-20))&];
	buml = Total[Times@@@(numl/.Pi->1)];
	c111 = Pi DoSlFit[buml,functions,symbols,2];

	ddel = g-(slres+c111);

	d21= Expand[Delta21[ddel]/.CT[a_,xs__]:>CT[a,Sequence@@({xs}/.G:>GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]])]];
	ll = GatherBy[(List@@d21)/.f_. CT[a_,xs___]:>{f a, ToSymbol[CT@@{xs}]},#[[2]]&];
	ll = {Total[#[[;;,1]]],#[[1,2]]}&/@ll;

	numl = {Rationalize[Ginsh[#[[1]],{point}]/Zeta[2],10^(-20)]Zeta[2],#[[2]]}&/@ll;
	numl=Select[numl,!(Abs[#[[1]]]<10^(-20))&];
	buml = Total[Times@@@(numl/.Pi->1)];
	
	c21 = Pi^2 DoSlFit[buml,functions,symbols,1];
	
	ddel = g - (slres + c111+c21);
    (*	num = Rationalize[Ginsh[ddel,{point}]/Zeta[3],10^(-20)]Zeta[3];
	slres + c111 + c21+num*)
    num = Ginsh[ddel,{point}];
    rnum = Rationalize[Re[num]/Zeta[3]]*Zeta[3];
    inum = Rationalize[Im[num]/Pi^3]*Pi^3;
    slres + c111 + c21 + rnum + inum
];


BumlZ3Pi3[num_]:= Block[{rnum,inum,rf,if},
	rnum=Re[num];
	inum = Im[num];

	rf = If[Abs[rnum]>10^(-20),Rationalize[rnum/Zeta[3],10^(-20)]Zeta[3],0];
	if = If[Abs[inum]> 10^(-20),Rationalize[inum/Pi^3,10^(-20)]Pi^3,0];
	rf + I if
];


DoFit[g_,functions_List,symbols_List,{point__Rule},4]:=Block[{gsym,slres,ddel,d1111,ll,numl,c1111,d211,c211,d31,c31,num,buml,rnum,inum,pp1,pp2,buz3,bup3},
	gsym = ComputeSymbol[g];
    If[$PLTSimplifyImaginary,
        gsym = (gsym//.im->I)//.Complex[a_,b_]:>(a+b*im);];
	Print["Fitting at symbol level"];
	slres = DoSlFit[gsym,functions,symbols,4];
	ddel = g-slres;
	Print["Now we fix the beyond the symbol terms"];
	d1111 =Expand[Delta1111[ddel]/.CT[a_,b_,c_,d_]:>CT[a,Sequence@@({b,c,d}/.G:>GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]])]];
	ll = GatherBy[(List@@d1111)/.f_. CT[a_,b_,c_,d_]:>{f a, ToSymbol[CT@@{b,c,d}]},#[[2]]&];
	ll = {Total[#[[;;,1]]],#[[1,2]]}&/@ll;
	numl = {Rationalize[Ginsh[#[[1]],{point}]/Pi,10^(-20)]Pi,#[[2]]}&/@ll;
	numl=Select[numl,!(Abs[#[[1]]]<10^(-20))&];
	buml = Total[Times@@@(numl/.Pi->1)];
	c1111 = Pi DoSlFit[buml,functions,symbols,3];
	(*Print[Style["Subscript[H, 1]\[CircleTimes]Subscript[H, 1]\[CircleTimes]Subscript[H, 1]\[CircleTimes]Subscript[H, 1] is fixed: \n",Bold],c1111];
*)	ddel = g-(slres+c1111);

	d211= Expand[Delta211[ddel]/.CT[a_,xs__]:>CT[a,Sequence@@({xs}/.G:>GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]])]];
	ll = GatherBy[(List@@d211)/.f_. CT[a_,xs___]:>{f a, ToSymbol[CT@@{xs}]},#[[2]]&];
	ll = {Total[#[[;;,1]]],#[[1,2]]}&/@ll;

	numl = {Rationalize[Ginsh[#[[1]],{point}]/Zeta[2],10^(-20)]Zeta[2],#[[2]]}&/@ll;
	numl= Select[numl,!(Abs[#[[1]]]<10^(-20))&];
	buml = Total[Times@@@(numl/.Pi->1)];
	c211 = Pi^2 DoSlFit[buml,functions,symbols,2];
	(*Print[Style["Subscript[H, 2]\[CircleTimes]Subscript[H, 1]\[CircleTimes]Subscript[H, 1] is fixed: \n",Bold],c211];
	*)
	ddel = g - (slres + c1111+c211);

	d31= Expand[Delta31[ddel]/.CT[a_,xs__]:>CT[a,Sequence@@({xs}/.G:>GLog/.Log[x_]:>PowerExpand[Log[Factorize[x,variables]]]//.$CanonicalPrimeElementOrder/.Log[x_]:>Log[flat[x]])]];
	ll = GatherBy[(List@@d31)/.f_. CT[a_,xs___]:>{f a, ToSymbol[CT@@{xs}]},#[[2]]&];
	$ll=ll = {Total[#[[;;,1]]],#[[1,2]]}&/@ll;

	numl = {BumlZ3Pi3[Ginsh[#[[1]],{point}]],#[[2]]}&/@ll;
	numl=Select[numl,!(Abs[#[[1]]]<10^(-20))&];
	buml=Total[Times@@@numl];
	buz3 = Coefficient[buml,Zeta[3]];
	bup3 = Coefficient[buml,Pi,3];
	buz3 = DoSlFit[buz3,functions,symbols,1]Zeta[3];
	bup3 = DoSlFit[bup3,functions,symbols,1]Pi^3;
	c31 = buz3+bup3;
	(*Print[Style["Subscript[H, 3]\[CircleTimes]Subscript[H, 1] is fixed: \n",Bold],c31];
*)

	$test=ddel = g - (slres + c1111+c211+c31);

	num = Ginsh[ddel,{point},PrecisionGoal->60];
	rnum=Re[num];
	inum=Im[num];
	rnum = If[Abs[rnum] >10^(-20),
	pp1 = RunPSLQ[rnum,{Zeta[4],PolyLog[4,1/2]+Log[2]^4/24+7/8 Zeta[3]Log[2]-1/4 Zeta[2]Log[2]^2,(Pi^2*Log[3]^2)/12-Log[3]^4/24+PolyLog[4,-1/3]-2*PolyLog[4,1/3]-(13*Log[3]*Zeta[3])/6},40];
	pp2 = RunPSLQ[rnum,{Zeta[4],PolyLog[4,1/2]+Log[2]^4/24+7/8 Zeta[3]Log[2]-1/4 Zeta[2]Log[2]^2,(Pi^2*Log[3]^2)/12-Log[3]^4/24+PolyLog[4,-1/3]-2*PolyLog[4,1/3]-(13*Log[3]*Zeta[3])/6},50];
	If[Expand[pp1-pp2]=!=0,Print[Style["PSLQ failed to converge for weight 4 constants.",Directive[Orange,Bold]]];Print[pp1,"\tvs.\t",pp2];Abort[]];
	pp2
	,0];
	inum = If[Abs[inum] > 10^(-20),
	Rationalize[inum/(Pi Zeta[3]),10^(-20)]Pi Zeta[3],0];
	
slres + c1111 + c211+c31+rnum+I inum
];


ReduceFG[theG_,_,_]/;TranscendentalWeight[theG]>4:=Print[Style["Unsupported weight: ",Orange],TranscendentalWeight[theG]];
ReduceFG[theG_G,functions_List,{point__Rule}]/;((Length[functions]>=TranscendentalWeight[theG])&&TranscendentalWeight[theG]<=4):=Block[{weight = TranscendentalWeight[theG],res,syml,delta},
	Print["Reducing an expression of weight ",weight];
	syml = Table[ComputeSymbol[functions[[i,j]]],{i,Length[functions]},{j,Length[functions[[i]]]}];
	res = DoFit[theG,functions,syml,{point},weight];
	delta=Ginsh[theG-res,{point}];
	If[Abs[delta] < 10^(-20),Print[Style["Success",Directive[Green,Bold]]," \[Delta] = ",delta],Print[Style["Error: ", Directive[Red,Bold]]," \[Delta] = ",delta]];
	res
];
ReduceFGEx[theG_,functions_List,{point__Rule}]:=Block[{weight,tmp,res,syml,delta},
	tmp=Union[TranscendentalWeight/@If[Head[Expand[theG]]===Plus,List@@Expand[theG],{theG}]];
	If[Length[tmp]=!=1,Print["Error: Expression is not of homogeneous weight!"];Abort[];];
	weight = tmp[[1]];
	Print["Reducing an expression of weight ",weight];
	syml = Table[ComputeSymbol[functions[[i,j]]],{i,Length[functions]},{j,Length[functions[[i]]]}];
	res = DoFit[theG,functions,syml,{point},weight];
	delta=Ginsh[theG-res,{point}];
	If[Abs[delta] < 10^(-20),Print[Style["Success",Directive[Green,Bold]]," \[Delta] = ",delta],Print[Style["Error: ", Directive[Red,Bold]]," \[Delta] = ",delta]];
	res
];
