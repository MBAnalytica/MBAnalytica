(* ::Package:: *)

(* ::Title:: *)
(*Coproduct for polylogarithms*)


(* ::Section:: *)
(*The tensor algebra*)


CT[as___, sum_Plus, bs___] := CT[as,#,bs]& /@ sum;

CT[as___, k_Integer * b_, cs___] := k * CT[as,b,cs];
CT[as___, k_Rational * b_, cs___] := k * CT[as,b,cs];
CT[as___, k_Complex * b_, cs___] := k * CT[as,b,cs];

CT[as___, k_ * sum_Plus, bs___] := CT[as, Expand[k*sum],bs];


CT /: CT[as__]*CT[bs__] := CT @@ ({as}{bs}) /; Length[{as}] == Length[{bs}];
CT /: Power[CT[as__], n_Integer] := Power[#,n]& /@ CT[as] /; (n > 1);


CT[as___, CT[bs___], cs___] := CT[as, bs ,cs];


CT[__, Pi^_. * _., ___] := 0;
CT[___, 0, ___] = 0;


CT[as___,HeavisideTheta[x_]y_.,bs___]:= HeavisideTheta[x]CT[as,y,bs];


(* ::Section:: *)
(*The coproduct*)


Delta[sum_Plus] := Delta /@ sum;

Delta[k_Integer * a_] := k * Delta[a];
Delta[k_Rational * a_] := k * Delta[a];
Delta[k_Complex * a_] := k * Delta[a];

Delta[Except[1, k_Integer]] := k;
Delta[k_Rational] := k;
Delta[k_Complex] := k;

Delta[1] = CT[1,1];

Delta[a_ * b_] := Expand[Delta[a]*Delta[b]];
Delta[Power[a_, n_Integer]] := Expand[Power[Delta[a], n]] /; (n > 1);


Delta[G[a_,x_]] := CT[1, G[a,x]] + CT[G[a,x], 1];
Delta[G[a_, as__, x_]] := DeltaG[a, as, x];

Delta[hpl_H] := Delta[HToG[hpl]];
Delta[hpl_HPL] := Delta[HPLToH[hpl]];

Delta[cl_Cl] := CT[cl,1] + CT[1,cl];
Delta[GR[as__]] := Module[{$$x}, 1/2*Delta[G[as,$$x]]+1/2*Delta[G[Sequence@@Conjugate[{as}],$$x]] //. $$x->1];
Delta[GI[as__]] := Module[{$$x}, -I/2*Delta[G[as,$$x]]+I/2*Delta[G[Sequence@@Conjugate[{as}],$$x]] //. $$x->1];

Delta[Log[a_]] := CT[1, Log[a]] + CT[Log[a],1];
Delta[Log[a_]^(n_Integer)] := Sum[Binomial[n,k]CT[Log[a]^k, Log[a]^(n-k)], {k, 0, n}];
Delta[PolyLog[n_Integer, x_]] := CT[1, PolyLog[n,x]] + CT[PolyLog[n,x], 1] + Sum[1/k! CT[PolyLog[n-k, x], Log[x]^k], {k,1, n-1}];
Delta[PolyLog[n_, m_, x_]] := (-1)^m DeltaG[Sequence @@ Table[0, {n}], Sequence @@ Table[1, {m}], x];

Delta[Zeta[n_Integer]] := CT[1,Zeta[n]] + CT[Zeta[n],1] /; OddQ[n] && (n > 1);
Delta[Pi] := CT[Pi,1];
Delta[Power[Pi, n_Integer]] := CT[Pi^n, 1] /; (n > 1);
Delta[Catalan] = CT[Catalan, 1] + CT[1, Catalan];

Delta[HPLs6] = CT[1, HPLs6] + CT[HPLs6, 1] + (3*CT[Zeta[3], Zeta[3]])/4 + (31*CT[Zeta[5], Log[2]])/16;
Delta[HPLs7a] = CT[1, HPLs7a] + CT[HPLs7a, 1] - CT[Pi^2, Zeta[5]]/192 + CT[Pi^4, Zeta[3]]/48 + CT[Log[2], HPLs6] - (5*CT[Log[2], Zeta[3]^2])/4 - (31*CT[Log[2], Log[2]*Zeta[5]])/16 - (31*CT[Log[2]^2, Zeta[5]])/32 + CT[Pi^2*Log[2]^2, Zeta[3]]/12 - CT[Log[2]^4, Zeta[3]]/12 - 2*CT[PolyLog[4, 1/2], Zeta[3]] - (7*CT[Log[2]*Zeta[3], Zeta[3]])/4;
Delta[HPLs7b] = CT[1, HPLs7b] + CT[HPLs6, Log[2]] + CT[HPLs7b, 1] + (95*CT[Pi^2, Zeta[5]])/192 + (17*CT[Pi^4, Zeta[3]])/720 - (7*CT[Pi^6, Log[2]])/8640 + (31*CT[Log[2], Log[2]*Zeta[5]])/16 + (31*CT[Log[2]^2, Zeta[5]])/32 + CT[Pi^2*Log[2]^2, Zeta[3]]/16 - CT[Log[2]^4, Zeta[3]]/16 - (3*CT[PolyLog[4,1/2], Zeta[3]])/2 + (21*CT[Zeta[3], Log[2]*Zeta[3]])/16 + (9*CT[Zeta[3]^2, Log[2]])/32 + (31*CT[Zeta[5], Log[2]^2])/16 + (31*CT[Log[2]*Zeta[5], Log[2]])/16;
Delta[HPLs8a] = CT[1, HPLs8a] + CT[HPLs8a, 1] - 5*CT[Zeta[3], Zeta[5]];
Delta[HPLs8b] = CT[1, HPLs8b] + CT[HPLs8b, 1] + (15*CT[Zeta[3], Zeta[5]])/16 + (3*CT[Zeta[5], Zeta[3]])/4 + (127*CT[Zeta[7], Log[2]])/64;
Delta[HPLs8c] = CT[1, HPLs8c] + CT[HPLs6, Log[2]^2] + CT[HPLs7b, Log[2]] + CT[HPLs8c, 1] + CT[Pi^2, HPLs6]/12 + (19*CT[Pi^2, Zeta[3]^2])/128 + CT[Pi^2, Log[2]*Zeta[5]]/2 + (59*CT[Pi^4, Log[2]*Zeta[3]])/1920 - (7*CT[Pi^6, Log[2]^2])/8640 + CT[Log[2], HPLs6*Log[2]] + (9*CT[Log[2], Log[2]*Zeta[3]^2])/32 + CT[HPLs6*Log[2], Log[2]] + CT[Pi^2*Log[2], Zeta[5]]/2 + (59*CT[Pi^4*Log[2], Zeta[3]])/1920 - (7*CT[Pi^6*Log[2], Log[2]])/8640 + CT[Log[2]^2, HPLs6]/2 + (9*CT[Log[2]^2, Zeta[3]^2])/64 + CT[Pi^2*Log[2]^2, Log[2]*Zeta[3]]/16 + CT[Pi^2*Log[2]^3, Zeta[3]]/48 - CT[Log[2]^4, Log[2]*Zeta[3]]/16 - CT[Log[2]^5, Zeta[3]]/80 - (3*CT[PolyLog[4, 1/2], Log[2]*Zeta[3]])/2 + (3*CT[PolyLog[5, 1/2], Zeta[3]])/2 + (21*CT[Zeta[3], Log[2]^2*Zeta[3]])/16 + (5*CT[Zeta[3], Zeta[5]])/8 + (23*CT[Pi^2*Zeta[3], Zeta[3]])/64 + (41*CT[Pi^4*Zeta[3], Log[2]])/5760 + (21*CT[Log[2]*Zeta[3], Log[2]*Zeta[3]])/16 + (21*CT[Log[2]^2*Zeta[3], Zeta[3]])/32 + (9*CT[Zeta[3]^2, Log[2]^2])/32 + (9*CT[Log[2]*Zeta[3]^2, Log[2]])/32 + (31*CT[Zeta[5], Log[2]^3])/24 - (1281*CT[Zeta[5], Zeta[3]])/256 + CT[Pi^2*Zeta[5], Log[2]]/6 + (31*CT[Log[2]*Zeta[5], Log[2]^2])/16 - (63*CT[Zeta[7], Log[2]])/32;
Delta[HPLs8d] = CT[1, HPLs8d] + CT[HPLs6, Log[2]^2]/2 - CT[HPLs7a, Log[2]] + CT[HPLs8d, 1] + (5*CT[Pi^2, HPLs6])/12 + CT[Pi^2, Zeta[3]^2]/24 - CT[Pi^4, Log[2]^4]/4320 - CT[Pi^4, PolyLog[4, 1/2]]/180 - CT[Pi^6, Log[2]^2]/1080 + CT[HPLs6*Log[2], Log[2]] - CT[Pi^6*Log[2], Log[2]]/540 - CT[Zeta[3], Log[2]^5]/60 + 2*CT[Zeta[3], PolyLog[5, 1/2]] - (61*CT[Zeta[3], Zeta[5]])/16 + (19*CT[Pi^2*Zeta[3], Zeta[3]])/48 + (37*CT[Pi^4*Zeta[3], Log[2]])/1440 + CT[Pi^2*Log[2]^2*Zeta[3], Log[2]]/12 - CT[Log[2]^4*Zeta[3], Log[2]]/12 - 2*CT[PolyLog[4, 1/2]*Zeta[3], Log[2]] +  CT[Zeta[3]^2, Log[2]^2]/4 - (5*CT[Log[2]*Zeta[3]^2, Log[2]])/4 + (31*CT[Zeta[5], Log[2]^3])/96 - (455*CT[Zeta[5], Zeta[3]])/128 + (77*CT[Pi^2*Zeta[5], Log[2]])/96 - (31*CT[Log[2]^2*Zeta[5], Log[2]])/32 - (1145*CT[Zeta[7], Log[2]])/128;
Delta[Li[ms_List, xs_List]] := Delta[LiG[ms, xs]];

Delta[MZV[ms_List]] := Block[{$$x, delta},
  delta = Delta[HPLToH[HPL[ms ,$$x]]];
  Return[Expand[delta //. $$x -> 1]];
];
   



Delta[c[i_]] := c[i];


Delta[a_?(TranscendentalWeight[#]===0&)] := a;


Delta[CT[as__,b_]] := CT[as, Delta[b]];


Delta[HeavisideTheta[$zz_]] := HeavisideTheta[$zz];


(* ::Section:: *)
(*Weights*)


Clear[ElementaryTranscendentalWeight]


ElementaryTranscendentalWeight[a_ * b_] := ElementaryTranscendentalWeight[a] + ElementaryTranscendentalWeight[b];
ElementaryTranscendentalWeight[Power[a_, n_Integer]] := n * ElementaryTranscendentalWeight[a];

ElementaryTranscendentalWeight[CT[as__]] := ElementaryTranscendentalWeight /@ CTTW[as];


ElementaryTranscendentalWeight[G[ws__, x_]] := Length[{ws}];
ElementaryTranscendentalWeight[cG[ws__, x_]] := Length[{ws}];
ElementaryTranscendentalWeight[cC[ws__, x_]] := Length[{ws}];
ElementaryTranscendentalWeight[H[ws__, x_]] := Length[{ws}];
ElementaryTranscendentalWeight[HPL[ws_List, x_]] := ElementaryTranscendentalWeight[HPLToH[HPL[ws,x]]];
ElementaryTranscendentalWeight[PolyLog[n_, _]] := n;
ElementaryTranscendentalWeight[Cl[n_, _]] := n;
ElementaryTranscendentalWeight[PolyLog[n_, m_, _]] := n + m;
ElementaryTranscendentalWeight[Log[_]] := 1;
ElementaryTranscendentalWeight[cL[ws__, x_]] := Length[{ws}];

ElementaryTranscendentalWeight[Pi] = 1;
ElementaryTranscendentalWeight[Zeta[n_]] := n;
ElementaryTranscendentalWeight[MZV[w_List]] := Plus @@ (Abs /@ w);
ElementaryTranscendentalWeight[HPLs6]=6;
ElementaryTranscendentalWeight[HPLs7a]=7;
ElementaryTranscendentalWeight[HPLs7b]=7;
ElementaryTranscendentalWeight[HPLs8a]=8;
ElementaryTranscendentalWeight[HPLs8b]=8;
ElementaryTranscendentalWeight[HPLs8c]=8;
ElementaryTranscendentalWeight[HPLs8d]=8;


ElementaryTranscendentalWeight[_Integer|_Rational|_Complex] = 0;

ElementaryTranscendentalWeight[Catalan] = 2;




TranscendentalWeight[expr_] := Module[{tw=ElementaryTranscendentalWeight[expr],unknowns},
    tw //. ElementaryTranscendentalWeight[Except[sum_Plus]] :> 0];


GetWeightTerms[expr_, n_Integer] := Block[{temp=Expand[expr], weight},

    If[Head[temp] === Plus, Return[Select[Expand[expr], TranscendentalWeight[#] === n&]]];

    weight = TranscendentalWeight[temp];
    temp = If[weight ==n, temp, 0];  

    Return[temp];]



DecomposeDelta[expr_] := Block[{
    temp = Expand[expr//.CT[a__]:>CT[Sequence@@(Expand/@{a})]]
    },

    temp = If[Head[temp] === Plus, 
              List @@ temp,
              {temp}
             ];

    temp = GatherBy[temp, TranscendentalWeight];
   
    temp = Prepend[#, List @@ TranscendentalWeight[#[[1]]]]& /@ temp;

    temp = {#[[1]], Plus @@ Rest[#]}& /@ temp;

    Return[temp];

];
    
    


DeltaComponent[list_List, index_List] := Block[{temp},
    temp = Cases[list, {index, __}];
    If[temp =!= {}, 
       Return[temp[[1,2]]],
       Return[0]];
];


(* ::Section:: *)
(*Shorthands*)


Delta[{i_,j_},g_] := DeltaComponent[DecomposeDelta[Delta[g]],{i,j}];

Delta[{is__,j_,k_},g_] /; Total[{is,j,k}] > 8 := Delta[{Total[{is,j}],k},g] /. CT[a_,b_]:> CT[Expand[Delta[{is,j}, a]],b];
Delta[{is__,j_,k_},g_] /; Total[{is,j,k}] <= 8 := Symbol["Delta" <> (StringJoin @@ (ToString/@{is,j,k}))][g];


Delta11 = DeltaComponent[DecomposeDelta[Delta[#]], {1,1}]&;

Delta21 = DeltaComponent[DecomposeDelta[Delta[#]], {2,1}]&;
Delta12 = DeltaComponent[DecomposeDelta[Delta[#]], {1,2}]&;
Delta111 = Delta21[#] /. CT[aa_, bb_] :> CT[Expand[Delta11[aa]], bb]&

Delta31 = DeltaComponent[DecomposeDelta[Delta[#]], {3,1}]&;
Delta13 = DeltaComponent[DecomposeDelta[Delta[#]], {1,3}]&;
Delta22 = DeltaComponent[DecomposeDelta[Delta[#]], {2,2}]&;


Delta211 = Delta31[#] /. CT[aa_, bb_] :> CT[Expand[Delta21[aa]], bb]&;
Delta121 = Delta31[#] /. CT[aa_, bb_] :> CT[Expand[Delta12[aa]], bb]&;
Delta112 = Delta22[#] /. CT[aa_, bb_] :> CT[Expand[Delta11[aa]], bb]&;

Delta1111 = Delta31[#] /. CT[aa_, bb_] :> CT[Expand[Delta111[aa]], bb]&;


Delta41 = DeltaComponent[DecomposeDelta[Delta[#]], {4,1}]&;
Delta14 = DeltaComponent[DecomposeDelta[Delta[#]], {1,4}]&;
Delta23 = DeltaComponent[DecomposeDelta[Delta[#]], {2,3}]&;
Delta32 = DeltaComponent[DecomposeDelta[Delta[#]], {3,2}]&;

Delta311 = Delta41[#] /. CT[aa_, bb_] :> CT[Expand[Delta31[aa]], bb]&;
Delta131 = Delta41[#] /. CT[aa_, bb_] :> CT[Expand[Delta13[aa]], bb]&;
Delta113 = Delta23[#] /. CT[aa_, bb_] :> CT[Expand[Delta11[aa]], bb]&;

Delta221 = Delta41[#] /. CT[aa_, bb_] :> CT[Expand[Delta22[aa]], bb]&;
Delta212 = Delta32[#] /. CT[aa_, bb_] :> CT[Expand[Delta21[aa]], bb]&;
Delta122 = Delta32[#] /. CT[aa_, bb_] :> CT[Expand[Delta12[aa]], bb]&;

Delta2111 = Delta41[#] /. CT[aa_, bb_] :> CT[Expand[Delta211[aa]], bb]&;
Delta1211 = Delta41[#] /. CT[aa_, bb_] :> CT[Expand[Delta121[aa]], bb]&;
Delta1121 = Delta41[#] /. CT[aa_, bb_] :> CT[Expand[Delta112[aa]], bb]&;
Delta1112 = Delta32[#] /. CT[aa_, bb_] :> CT[Expand[Delta111[aa]], bb]&;

Delta11111 = Delta41[#] /. CT[aa_, bb_] :> CT[Expand[Delta1111[aa]], bb]&;

Delta51 = DeltaComponent[DecomposeDelta[Delta[#]], {5,1}]&;
Delta15 = DeltaComponent[DecomposeDelta[Delta[#]], {1,5}]&;
Delta24 = DeltaComponent[DecomposeDelta[Delta[#]], {2,4}]&;
Delta42 = DeltaComponent[DecomposeDelta[Delta[#]], {4,2}]&;
Delta33 = DeltaComponent[DecomposeDelta[Delta[#]], {3,3}]&;


Delta411 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta41[aa]], bb]&;
Delta141 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta14[aa]], bb]&;
Delta114 = Delta24[#] /. CT[aa_, bb_] :> CT[Expand[Delta11[aa]], bb]&;

Delta123 = Delta33[#] /. CT[aa_, bb_] :> CT[Expand[Delta12[aa]], bb]&;
Delta132 = Delta42[#] /. CT[aa_, bb_] :> CT[Expand[Delta13[aa]], bb]&;
Delta213 = Delta33[#] /. CT[aa_, bb_] :> CT[Expand[Delta21[aa]], bb]&;
Delta231 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta23[aa]], bb]&;
Delta312 = Delta42[#] /. CT[aa_, bb_] :> CT[Expand[Delta31[aa]], bb]&;
Delta321 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta32[aa]], bb]&;

Delta222 = Delta42[#] /. CT[aa_, bb_] :> CT[Expand[Delta22[aa]], bb]&;

Delta3111 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta311[aa]], bb]&;
Delta1311 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta131[aa]], bb]&;
Delta1131 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta113[aa]], bb]&;
Delta1113 = Delta33[#] /. CT[aa_, bb_] :> CT[Expand[Delta111[aa]], bb]&;

Delta2211 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta221[aa]], bb]&;
Delta2121 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta212[aa]], bb]&;
Delta2112 = Delta42[#] /. CT[aa_, bb_] :> CT[Expand[Delta211[aa]], bb]&;
Delta1221 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta122[aa]], bb]&;
Delta1212 = Delta42[#] /. CT[aa_, bb_] :> CT[Expand[Delta121[aa]], bb]&;
Delta1122 = Delta42[#] /. CT[aa_, bb_] :> CT[Expand[Delta112[aa]], bb]&;

Delta21111 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta2111[aa]], bb]&;
Delta12111 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta1211[aa]], bb]&;
Delta11211 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta1121[aa]], bb]&;
Delta11121 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta1112[aa]], bb]&;
Delta11112 = Delta42[#] /. CT[aa_, bb_] :> CT[Expand[Delta1111[aa]], bb]&;

Delta111111 = Delta51[#] /. CT[aa_, bb_] :> CT[Expand[Delta11111[aa]], bb]&;

Delta61 = DeltaComponent[DecomposeDelta[Delta[#]], {6,1}]&;
Delta16 = DeltaComponent[DecomposeDelta[Delta[#]], {1,6}]&;
Delta25 = DeltaComponent[DecomposeDelta[Delta[#]], {2,5}]&;
Delta52 = DeltaComponent[DecomposeDelta[Delta[#]], {5,2}]&;
Delta34 = DeltaComponent[DecomposeDelta[Delta[#]], {3,4}]&;
Delta43 = DeltaComponent[DecomposeDelta[Delta[#]], {4,3}]&;

Delta511 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta51[aa]], bb]&;
Delta151 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta15[aa]], bb]&;
Delta115 = Delta25[#] /. CT[aa_, bb_] :> CT[Expand[Delta11[aa]], bb]&;

Delta421 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta42[aa]], bb]&;
Delta412 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta41[aa]], bb]&;
Delta241 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta24[aa]], bb]&;
Delta214 = Delta34[#] /. CT[aa_, bb_] :> CT[Expand[Delta21[aa]], bb]&;
Delta142 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta14[aa]], bb]&;
Delta124 = Delta34[#] /. CT[aa_, bb_] :> CT[Expand[Delta12[aa]], bb]&;

Delta322 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta32[aa]], bb]&;
Delta232 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta23[aa]], bb]&;
Delta223 = Delta43[#] /. CT[aa_, bb_] :> CT[Expand[Delta22[aa]], bb]&;

Delta331 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta33[aa]], bb]&;
Delta313 = Delta43[#] /. CT[aa_, bb_] :> CT[Expand[Delta31[aa]], bb]&;
Delta133 = Delta43[#] /. CT[aa_, bb_] :> CT[Expand[Delta13[aa]], bb]&;

Delta4111 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta411[aa]], bb]&;
Delta1411 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta141[aa]], bb]&;
Delta1141 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta114[aa]], bb]&;
Delta1114 = Delta34[#] /. CT[aa_, bb_] :> CT[Expand[Delta111[aa]], bb]&;

Delta3211 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta321[aa]], bb]&;
Delta3121 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta312[aa]], bb]&;
Delta3112 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta311[aa]], bb]&;
Delta2311 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta231[aa]], bb]&;
Delta2131 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta213[aa]], bb]&;
Delta2113 = Delta43[#] /. CT[aa_, bb_] :> CT[Expand[Delta211[aa]], bb]&;
Delta1321 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta132[aa]], bb]&;
Delta1312 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta131[aa]], bb]&;
Delta1231 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta123[aa]], bb]&;
Delta1213 = Delta43[#] /. CT[aa_, bb_] :> CT[Expand[Delta121[aa]], bb]&;
Delta1132 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta113[aa]], bb]&;
Delta1123 = Delta43[#] /. CT[aa_, bb_] :> CT[Expand[Delta112[aa]], bb]&;

Delta2221 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta222[aa]], bb]&;
Delta2212 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta221[aa]], bb]&;
Delta2122 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta212[aa]], bb]&;
Delta1222 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta122[aa]], bb]&;

Delta31111 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta3111[aa]], bb]&;
Delta13111 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta1311[aa]], bb]&;
Delta11311 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta1131[aa]], bb]&;
Delta11131 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta1113[aa]], bb]&;
Delta11113 = Delta43[#] /. CT[aa_, bb_] :> CT[Expand[Delta1111[aa]], bb]&;

Delta22111 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta2211[aa]], bb]&;
Delta21211 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta2121[aa]], bb]&;
Delta21121 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta2112[aa]], bb]&;
Delta21112 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta2111[aa]], bb]&;
Delta12211 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta1221[aa]], bb]&;
Delta12121 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta1212[aa]], bb]&;
Delta12112 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta1211[aa]], bb]&;
Delta11221 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta1122[aa]], bb]&;
Delta11212 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta1121[aa]], bb]&;
Delta11122 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta1112[aa]], bb]&;

Delta211111 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta21111[aa]], bb]&;
Delta121111 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta12111[aa]], bb]&;
Delta112111 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta11211[aa]], bb]&;
Delta111211 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta11121[aa]], bb]&;
Delta111121 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta11121[aa]], bb]&;
Delta111112 = Delta52[#] /. CT[aa_, bb_] :> CT[Expand[Delta11111[aa]], bb]&;

Delta1111111 = Delta61[#] /. CT[aa_, bb_] :> CT[Expand[Delta111111[aa]], bb]&;


Delta71 = DeltaComponent[DecomposeDelta[Delta[#]], {7,1}]&;
Delta17 = DeltaComponent[DecomposeDelta[Delta[#]], {1,7}]&;
Delta26 = DeltaComponent[DecomposeDelta[Delta[#]], {2,6}]&;
Delta62 = DeltaComponent[DecomposeDelta[Delta[#]], {6,2}]&;
Delta35 = DeltaComponent[DecomposeDelta[Delta[#]], {3,5}]&;
Delta53 = DeltaComponent[DecomposeDelta[Delta[#]], {5,3}]&;
Delta44 = DeltaComponent[DecomposeDelta[Delta[#]], {4,4}]&;

Delta611 = Delta71[#] /. CT[aa_, bb_] :> CT[Expand[Delta61[aa]], bb]&;
Delta5111 = Delta71[#] /. CT[aa_, bb_] :> CT[Expand[Delta511[aa]], bb]&;
Delta41111 = Delta71[#] /. CT[aa_, bb_] :> CT[Expand[Delta4111[aa]], bb]&;
Delta311111 = Delta71[#] /. CT[aa_, bb_] :> CT[Expand[Delta31111[aa]], bb]&;
Delta2111111 = Delta71[#] /. CT[aa_, bb_] :> CT[Expand[Delta211111[aa]], bb]&;
Delta11111111 = Delta71[#] /. CT[aa_, bb_] :> CT[Expand[Delta1111111[aa]], bb]&;




(* ::Section:: *)
(*Delta4*)


(* ::Text:: *)
(*This is a shorthand to get the {1,1,1,1} component of n expression made out of *classical* polylogs*)


Delta4[sum_Plus]:=Delta4/@sum;

Delta4[k_Integer * a_] := k * Delta4[a];
Delta4[k_Rational * a_] := k * Delta4[a];
Delta4[k_Complex * a_] := k * Delta4[a];
Delta4[cc_c rest_] := cc Delta4[rest];

Delta4[Log[a_]Log[b_]Log[c_]Log[d_]] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[Log[a]Log[b]Log[c]Log[d]]]]],{1,1,1,1}];
Delta4[Log[a_]Log[b_]Log[c_]^2] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[Log[a]Log[b]Log[c]^2]]]],{1,1,1,1}];
Delta4[Log[a_]Log[b_]^3] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[Log[a]Log[b]^3]]]],{1,1,1,1}];
Delta4[Log[a_]^2 Log[b_]^2] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[Log[a]^2 Log[b]^2]]]],{1,1,1,1}];
Delta4[Log[a_]^4] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[Log[a]^4]]]],{1,1,1,1}];

Delta4[PolyLog[2,a_] Log[b_]Log[c_]] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[PolyLog[2,a] Log[b]Log[c]]]]],{1,1,1,1}];
Delta4[PolyLog[2,a_] Log[b_]^2] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[PolyLog[2,a] Log[b]^2]]]],{1,1,1,1}];
Delta4[PolyLog[2,a_] PolyLog[2,b_]] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[PolyLog[2,a] PolyLog[2,b]]]]],{1,1,1,1}];
Delta4[PolyLog[2,a_]^2] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[PolyLog[2,a]^2]]]],{1,1,1,1}];

Delta4[PolyLog[3,a_] Log[b_]] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[PolyLog[3,a] Log[b]]]]],{1,1,1,1}];

Delta4[PolyLog[4,a_]] = DeltaComponent[DecomposeDelta[Delta[Delta[Delta[PolyLog[4,a]]]]],{1,1,1,1}];


(* ::Section:: *)
(*ToSymbol*)


ToSymbol[expr_] := flatTensor[ReduceTensorProduct[expr /. CT[Pi,__]:> 0 /. CT -> $$citi //. {Log[a_] :> a, G[a_,b_] :> (GLog[a,b] /. Pi -> 0)} /. $$citi -> CiTi]];


(* ::Section:: *)
(*Fitting the zeta valued terms*)


FitMZV::Tensor = "Non vanishing symbol for `1`. Aborting fitting.";


FitMZV[expr_, entries_List, transnumber_, point_, constraint_:{}] := DeleteCases[{#, FitMZV[expr, #, transnumber, point, constraint]}& /@ entries, {_,0}];


FitMZV[expr_,entry_CT,transnumber_, point_, constraint_:{}]:=Block[
   {term,
    zerotensor,
    numerics,
    real, imaginary, $DummyVar
    },

   term = Select[expr+$DummyVar, Not[FreeQ[#, CT[_, Sequence @@ entry]]]&] /. CT[a_,__] :> a;
   zerotensor = Expand[flatTensor[CreateTensor[term]]];
   If[!FreeQ[$QExtension,I] && zerotensor =!=0,
		zerotensor = Expand[zerotensor //. CiTi -> CanInt$FrozenCiTi //. CanInt$FrozenCiTi[a___,2,b___]:>CanInt$FrozenCiTi[a,(1+I),b]+CanInt$FrozenCiTi[a,(1-I),b]//.CanInt$FrozenCiTi:>CiTi//. $CanonicalPrimeElementOrder];
		]
  If[zerotensor =!= 0,  
     Message[FitMZV::Tensor,entry];
     Print[zerotensor];
     Abort[];
     ];
  
  numerics = Ginsh[GToH[term /. constraint], point, PrecisionGoal -> 80]/transnumber;
  real = Re[numerics];
  imaginary = Im[numerics];

  If[Abs[real] < 10^(-35), 
     real = 0
     ];
  real = Rationalize[real];
  If[Abs[imaginary] < 10^(-35), 
     imaginary = 0
     ];
  imaginary = Rationalize[imaginary];

  Return[transnumber real + I transnumber imaginary];
];


FitIPi[expr_, entry_, point_, constraint_:{}] := FitMZV[expr, entry, Pi, point, constraint];
FitPi2[expr_, entry_, point_, constraint_:{}] := FitMZV[expr, entry, Pi^2, point, constraint];
FitZ3[expr_, entry_, point_, constraint_:{}] := FitMZV[expr, entry, Zeta[3], point, constraint];
FitPi4[expr_, entry_, point_, constraint_:{}] := FitMZV[expr, entry, Pi^4, point, constraint];



SymbolizePi2[list_List] := (Plus @@ (Times @@@ ToSymbol[list])) /. Pi^2 -> 1;
SymbolizeZ3[list_List] := (Plus @@ (Times @@@ ToSymbol[list])) /. Zeta[3] -> 1;
SymbolizePi4[list_List] := (Plus @@ (Times @@@ ToSymbol[list])) /. Pi^4 -> 1;


GetLastEntries[expr_,n_Integer] := Block[{temp = expr},
    
    If[expr ===0,
       Return[{}]
      ];
    
    temp = If[Head[temp] === Plus, 
              List@@temp, {temp}];
    temp = temp //. _ CT[as__]:> CT[as];
    temp = temp /. CT[as__] :> Take[CT[as],-n];
    temp = Union[temp];

    Return[temp];
];


(* ::Section:: *)
(*Fitting the zeta valued terms with PSLQ*)


FitMZVPSLQ[expr_, entries_List, transnumber_List, point_, constraint_:{}] := DeleteCases[{#, FitMZVPSLQ[expr, #, transnumber, point, constraint]}& /@ entries, {_,0}];


FitMZVPSLQ[expr_,entry_CT,transnumber_List, point_, constraint_:{}]:=Block[
   {term = Expand[expr],
    zerotensor,
    numerics,
    real, imaginary, 
    (*realbasis = DeleteCases[Re[transnumber], 0], 
    imagbasis = DeleteCases[Im[transnumber], 0]*)
	realbasis = transnumber[[Flatten[Position[Re[#//.$TranscendentalTag[a_,x_]:>x]=!=0&/@transnumber,True]]]],
	imagbasis = 1/I transnumber[[Flatten[Position[Im[#//.$TranscendentalTag[a_,x_]:>x]=!=0&/@transnumber,True]]]],rr,qq,del
    },

   term = If[Head[term] === Plus,
             Select[term, Not[FreeQ[#, CT[_, Sequence @@ entry]]]&],
             If[FreeQ[term, CT[_, Sequence @@ entry]], 0, term]   
            ];
    term = term //. CT[a_,__] :> a;
	zerotensor = Expand[flatTensor[CreateTensor[term]]];
    If[!FreeQ[$QExtension,I] && zerotensor =!=0,
		zerotensor = Expand[zerotensor //. CiTi -> CanInt$FrozenCiTi //. CanInt$FrozenCiTi[a___,2,b___]:>CanInt$FrozenCiTi[a,(1+I),b]+CanInt$FrozenCiTi[a,(1-I),b]//.CanInt$FrozenCiTi:>CiTi//. $CanonicalPrimeElementOrder];
		];
  If[zerotensor =!= 0,  
     Message[FitMZV::Tensor,entry];
     Print[zerotensor];
     Abort[];
     ];
  numerics = Ginsh[GToH[term /. constraint], point,PrecisionGoal->100];
  real = Re[numerics];
  imaginary = Im[numerics];

  real = If[Abs[real] < 10^(-35), 
            0,
            If[Length[realbasis] == 1,
               Rationalize[real/(realbasis[[1]])//.$TranscendentalTag[a_,x_]:>x]realbasis[[1]],
               RunPSLQ[real, realbasis, 30]   
              ]
           ];

  imaginary = If[Abs[imaginary] < 10^(-35), 
                 0,
                 If[Length[imagbasis] == 1,
                    Rationalize[imaginary/(imagbasis[[1]])//.$TranscendentalTag[a_,x_]:>x]imagbasis[[1]],
                    RunPSLQ[imaginary, imagbasis, 30]   
                   ]
                ];
  Return[real + I imaginary];
];


FitZ3IPi3[expr_, entry_, point_, constraint_:{}] := FitMZVPSLQ[expr, entry, {Zeta[3], I Pi^3}, point, constraint];
FitZ5[expr_, entry_, point_, constraint_:{}] := FitMZVPSLQ[expr, entry, {Zeta[3]Pi^2, Zeta[5]}, point, constraint];
FitPi4IPiZ3[expr_, entry_, point_, constraint_:{}] := FitMZVPSLQ[expr, entry, {$TranscendentalTag[Pi4,Pi^4], $TranscendentalTag[Z3IPi,I Pi Zeta[3]], $TranscendentalTag[Li412,(PolyLog[4,1/2]+Log[2]^4/24+7/8 Zeta[3]Log[2]-1/4 Zeta[2]Log[2]^2)]}, point, constraint];


(* ::Section:: *)
(*Antipode*)


Antipode[Log[x_]]:=-Log[x];
Antipode[sum_Plus]:=Antipode/@sum;
Antipode[a_ b_]:=Antipode[a] Antipode[b];
Antipode[a_]:=a/;TranscendentalWeight[a]===0;
Antipode[g_G]:=Block[{$CT},-g-Plus@@(Last/@DeleteCases[DecomposeDelta[Delta[g]],{{___,0,___},__}]//.CT[a_,b_]:>$CT[a,Antipode[b]])//.$CT->Times];
Antipode[g_H]:=Block[{$CT},-g-Plus@@(Last/@DeleteCases[DecomposeDelta[Delta[g]],{{___,0,___},__}]//.CT[a_,b_]:>$CT[a,Antipode[b]])//.$CT->Times];
Antipode[g_PolyLog]:=Block[{$CT},-g-Plus@@(Last/@DeleteCases[DecomposeDelta[Delta[g]],{{___,0,___},__}]//.CT[a_,b_]:>$CT[a,Antipode[b]])//.$CT->Times];
Antipode[g_Zeta]:=-g;
Antipode[g_MZV]:=Block[{$CT},-g-Plus@@(Last/@DeleteCases[DecomposeDelta[Delta[g]],{{___,0,___},__}]//.CT[a_,b_]:>$CT[a,Antipode[b]])//.$CT->Times];
Antipode[Power[a_,n_]]:=Antipode[a]^n;


Antipode::undef = "Antipode is undefined for `1`.";


Antipode[Pi] := (Message[Antipode::undef,Pi];$Failed);


(* ::Section:: *)
(*Coradical decomposition*)


Format[CTCR[as__],TraditionalForm]:=CircleTimes[as];


CTShuff[as1___] CTShuff[as2___]^:=WordShuffle[word[as1],word[as2]]/. word[as__]:>CTShuff[as];
CTShuff/:CTShuff[as1___]^n_Integer:=WordShuffle@@Table[word[as1],{n}]/. word[as__]:>CTShuff[as]/;n>1;
ShuffleCT[expr_]:=Expand[Expand[expr]/. CTCR->CTShuff]/. {CTShuff[cs__]:>CTCR[cs]};


CTCR[as___,Except[1,n_Integer]b_,bs___]:=n CTCR[as,b,bs];
CTCR[as___,Except[1,n_Integer],bs___]:=n CTCR[as,1,bs];
CTCR[as___,n_Rational b_,bs___]:=n CTCR[as,b,bs];
CTCR[as___,n_Rational,bs___]:=n CTCR[as,1,bs];
CTCR[as___,n_Complex b_,bs___]:=n CTCR[as,b,bs];
CTCR[as___,n_Complex,bs___]:=n CTCR[as,1,bs];
CTCR[as___,Pi^n_. b_,bs___]:=Pi^n CTCR[as,b,bs];
CTCR[as___,Pi^n_.,bs___]:=Pi^n CTCR[as,1,bs];
CTCR[as___,c_CTCR,bs___]:=CTCR[as,Sequence@@c,bs];
CTCR[as___,sum_Plus,bs___]:=CTCR[as,#,bs]&/@sum;
CTCR[as___,1,bs___]:=CTCR[as,bs];


CoradicalDecomposition[sum_Plus,rules___]:=CoradicalDecomposition[#,rules]&/@sum;
CoradicalDecomposition[a_ b_,rules___]:=ShuffleCT[CoradicalDecomposition[a,rules]CoradicalDecomposition[b,rules]];
CoradicalDecomposition[Power[a_,n_],rules___]:=ShuffleCT[CoradicalDecomposition[a,rules]^n];
CoradicalDecomposition[n_Integer,___]:=n;
CoradicalDecomposition[n_Rational,___]:=n;
CoradicalDecomposition[n_Complex,___]:=n;
CoradicalDecomposition[Pi,___]:=Pi;
CoradicalDecomposition[l_Log,rules___]:=ComputeCoradicalDecomposition[l,rules];
CoradicalDecomposition[l_Cl,rules___]:=ComputeCoradicalDecomposition[l,rules];
CoradicalDecomposition[l_Zeta,___]:=CTCR[l];
CoradicalDecomposition[l_G,rules___]:=ComputeCoradicalDecomposition[l,rules];
CoradicalDecomposition[GI[as__],rules___]:=Module[{$$x,rim={rules},repls}, 
   repls = Cases[rim,Rule[Rules,_]|RuleDelayed[Rules,_]];
   rim = DeleteCases[rim,Rule[Rules,_]|RuleDelayed[Rules,_]];
   If[(Head[repls] === Rule) || (Head[repls] === RuleDelayed),
      rim = Append[rim, Rules -> Join[repls[[2]], {$$x->1}]]
      ];
    Return[-I/2*ComputeCoradicalDecomposition[G[as,$$x],rim]+I/2*ComputeCoradicalDecomposition[G[Sequence@@Conjugate[{as}],$$x],rim] ];
    ];
    
CoradicalDecomposition[GR[as__],rules___]:=Module[{$$x,rim={rules},repls}, 
   repls = Cases[rim,Rule[Rules,_]|RuleDelayed[Rules,_]][[1]];
   rim = DeleteCases[rim,Rule[Rules,_]|RuleDelayed[Rules,_]];
   If[(Head[repls] === Rule) || (Head[repls] === RuleDelayed),
      rim = Append[rim, Rules -> Join[repls[[2]], {$$x->1}]]
      ];
    Return[1/2*ComputeCoradicalDecomposition[G[as,$$x],rim]+1/2*ComputeCoradicalDecomposition[G[Sequence@@Conjugate[{as}],$$x],rim ]];
    ];
    
CoradicalDecomposition[l_H,rules___]:=ComputeCoradicalDecomposition[l, rules];
CoradicalDecomposition[l_PolyLog,rules___]:=ComputeCoradicalDecomposition[l,rules];
CoradicalDecomposition[l_Li,rules___]:=ComputeCoradicalDecomposition[l,rules];
CoradicalDecomposition[l_MZV,rules___]:=ComputeCoradicalDecomposition[l,rules];
CoradicalDecomposition[HPLs6,rules___] := ComputeCoradicalDecomposition[HPLs6,rules];


Options[ComputeCoradicalDecomposition] = {Rules -> {}, Primitives -> Automatic};


ComputeCoradicalDecomposition[expr_,OptionsPattern[]]:=Block[{temp=Expand[expr],rules=OptionValue[Rules]},

   If[MatchQ[expr,_Log|_Cl],
      Return[CTCR[expr]//.rules]
      ];

   If[Not[FreeQ[temp,HPL[{1},1]]], Message[Coradical::Div]];
   temp=Expand[temp //. rules /. HPL[{1},1]:>0];
   temp = Expand[Delta[temp]-CT[temp,1]]//.{CT[_,1]|CT[1,_]:>0,CT[_,G[as__,_]]/;Length[{as}]>1:>0,CT[_,H[as__,_]]/;Length[{as}]>1:>0,CT[_,_PolyLog]:>0,CT[_,_MZV]:>0,CT[_,_Power]|CT[_,_Times]:>0};
   temp = Expand[temp /.MakePLT$ExpRules[GR]/.MakePLT$ExpRules[GI]/.MakePLT$ExpRules[G] //. CT[_,_GR|_GI]:>0//.PLT$Exp->Exp];
   If[temp===0,Return[expr//.rules//.PLT$Exp->Exp]];
   Return[temp/.CT[a_,b_]:>CTCR[CoradicalDecomposition[a,Rules->rules,Primitives->Automatic],b//.rules]];
];
