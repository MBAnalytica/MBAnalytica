(* ::Package:: *)

(* ::Title:: *)
(*Shuffle algebra*)


(* ::Section:: *)
(*Abstract formulation*)


(* ::Subsection:: *)
(*Concatenation of words*)


WordConcatenation[word[as___], word[bs___]] := word[as, bs];

WordConcatenation[w1___, sum_Plus, w2___] := WordConcatenation[w1, #, w2]& /@ sum;
WordConcatenation[w1___, Except[_word, k_] * w2_, w3___] := k WordConcatenation[w1,w2,w3];


(* ::Subsection:: *)
(*Shuffles*)


SetAttributes[WordShuffle, Orderless];


WordShuffle[word[], w_] := w;

WordShuffle[w1___, sum_Plus, w2___] := WordShuffle[w1, #, w2]& /@ sum;
WordShuffle[w1___, Except[_word, k_] * w2_, w3___] := k * WordShuffle[w1, w2, w3];


WordShuffle[word[x_, u___], word[y_, v___]] := WordConcatenation[word[x], WordShuffle[word[u], word[y,v]]] + 
                                               WordConcatenation[word[y], WordShuffle[word[x,u], word[v]]];


(* ::Subsubsection:: *)
(*Precompilation*)


WordShuffle[word[a1_],word[a2_]] = WordShuffle[word[a1],word[a2]];

WordShuffle[word[a1_],word[a2_,a3_]] = WordShuffle[word[a1],word[a2,a3]];

WordShuffle[word[a1_],word[a2_, a3_, a4_]] = WordShuffle[word[a1],word[a2, a3, a4]];
WordShuffle[word[a1_, a2_],word[a3_, a4_]] = WordShuffle[word[a1, a2],word[a3, a4]];

WordShuffle[word[a1_],word[a2_, a3_, a4_, a5_]] = WordShuffle[word[a1],word[a2, a3, a4, a5]];
WordShuffle[word[a1_, a2_],word[a3_, a4_, a5_]] = WordShuffle[word[a1, a2],word[a3, a4, a5]];

WordShuffle[word[a1_],word[a2_, a3_, a4_, a5_, a6_]] = WordShuffle[word[a1],word[a2, a3, a4, a5, a6]];
WordShuffle[word[a1_, a2_],word[a3_, a4_, a5_, a6_]] = WordShuffle[word[a1, a2],word[a3, a4, a5, a6]];
WordShuffle[word[a1_, a2_, a3_],word[a4_, a5_, a6_]] = WordShuffle[word[a1, a2, a3],word[a4, a5, a6]];

WordShuffle[word[a1_],word[a2_, a3_, a4_, a5_, a6_, a7_]] = WordShuffle[word[a1],word[a2, a3, a4, a5, a6, a7]];
WordShuffle[word[a1_, a2_],word[a3_, a4_, a5_, a6_, a7_]] = WordShuffle[word[a1, a2],word[a3, a4, a5, a6, a7]];
WordShuffle[word[a1_, a2_, a3_],word[a4_, a5_, a6_, a7_]] = WordShuffle[word[a1, a2, a3],word[a4, a5, a6, a7]];

WordShuffle[word[a1_],word[a2_, a3_, a4_, a5_, a6_, a7_, a8_]] = WordShuffle[word[a1],word[a2, a3, a4, a5, a6, a7, a8]];
WordShuffle[word[a1_, a2_],word[a3_, a4_, a5_, a6_, a7_, a8_]] = WordShuffle[word[a1, a2],word[a3, a4, a5, a6, a7, a8]];
WordShuffle[word[a1_, a2_, a3_],word[a4_, a5_, a6_, a7_, a8_]] = WordShuffle[word[a1, a2, a3],word[a4, a5, a6, a7, a8]];
WordShuffle[word[a1_, a2_, a3_, a4_],word[a5_, a6_, a7_, a8_]] = WordShuffle[word[a1, a2, a3, a4],word[a5, a6, a7, a8]];


WordShuffle[word[w1__], word[w2__], ws__] := WordShuffle[WordShuffle[word[w1], word[w2]], ws];


(* ::Section:: *)
(*Shuffle algebra in I notation*)


ShuffleI[expr_] := Expand[expr /. II -> IShuff] /. IShuff -> II;


IShuff /: IShuff[a0_, as1_List, a1_]IShuff[a0_, as2_List,a1_] := WordShuffle[word @@ as1, word @@ as2] /. word[as__] :> IShuff[a0,{as},a1];


(* ::Section:: *)
(*Shuffle algebra in G notation*)


GShuff /: GShuff[as1__, a1_]GShuff[as2__,a1_] := WordShuffle[word[as1], word[as2]] /. word[as__] :> GShuff[as,a1];
GShuff /: Power[GShuff[as1__, a1_], n_Integer] := (WordShuffle @@ Table[word[as1], {n}]) /. word[as__] :> GShuff[as,a1] /; (n > 1);


ShuffleG[expr_] := Block[{temp = cLTocG[HToG[HPLToH[expr]]]},
    temp = Expand[temp /. G -> GShuff] /. GShuff -> G;
    temp = Expand[temp /. cG -> GShuff] /. GShuff -> cG;
    Return[temp];
];


(* ::Section:: *)
(*Shuffle algebra in Gfix notation*)


ShuffleGfix[expr_] := Expand[expr /. Gfix -> GShuff] /. GShuff -> Gfix;


(* ::Section:: *)
(*Stuffle algebra*)


PrependIndex[elem_,list_Indices] := Prepend[list,elem];
PrependIndex[elem_,sum_Plus] := PrependIndex[elem,#]&/@sum;
PrependIndex[elem_,a_Integer list_Indices] := a PrependIndex[elem,list];


StuffleLiList[Indices[x_,u___],Indices[y_,v___]] := PrependIndex[x,StuffleLiList[Indices[u],Indices[y,v]]] + 
      PrependIndex[y,StuffleLiList[Indices[x,u],Indices[v]]]+PrependIndex[StuffleBracketLi[x,y],StuffleLiList[Indices[u],Indices[v]]];

StuffleLiList[Indices[],Indices[u___]] := Indices[u];
StuffleLiList[Indices[v___],Indices[]] := Indices[v];


StuffleBracketLi[{m1_,x1_},{m2_,x2_}] := {m1+m2,x1 x2};


LiStuff /: LiStuff[m1_List,x1_List]*LiStuff[m2_List,x2_List] := StuffleLiList[Indices@@Transpose[{m1,x1}],Indices@@Transpose[{m2,x2}]];
LiStuff /: Power[LiStuff[m_List,x_List],n_?(#>1&)] := Power[LiStuff[m,x],n-2]StuffleLiList[Indices@@Transpose[{m,x}],Indices@@Transpose[{m,x}]];
StuffleLi[expr_] := expr /. {PolyLog[n_, x_] :> Li[{n}, {x}]} //. {Li->LiStuff,Indices[inds__]:>Li@@Transpose[{inds}]}/.LiStuff->Li;



