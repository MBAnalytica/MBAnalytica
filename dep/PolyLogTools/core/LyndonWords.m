(* ::Package:: *)

(* ::Title:: *)
(*LyndonWord Decomposition*)


(* ::Section:: *)
(*Numer of Lyndon words*)


NLyndon[n_,p_] := 1/n Sum[MoebiusMu[d] p^(n/d), {d, Divisors[n]}];


(* ::Section:: *)
(*LyndonWords*)


(* ::Text:: *)
(*Lyndon words up to weight 4, for an alphabet with 4 letters*)


<<"LyndonWords2.m";
<<"LyndonWords3.m";
<<"LyndonWords4.m";


(* ::Text:: *)
(*Lyndon words up to weight 6, for an alphabet with 5 letters*)


<<"LyndonWords5.m";
<<"LyndonWords6.m";


(* ::Section:: *)
(*Read in the Lyndon word decompositions up to weight 5*)


<<"LyndonDecompositionRules2.m";

<<"LyndonDecompositionRules3.m";

<<"LyndonDecompositionRules4.m";

<<"LyndonDecompositionRules5.m";

<<"LyndonDecompositionRules6.m";


PLT$LynDecRules2 = Dispatch[LyndonDecompositionRules2];
PLT$LynDecRules3 = Dispatch[LyndonDecompositionRules3];
PLT$LynDecRules4 = Dispatch[LyndonDecompositionRules4];
PLT$LynDecRules5 = Dispatch[LyndonDecompositionRules5];
PLT$LynDecRules6 = Dispatch[LyndonDecompositionRules6];


(* ::Section:: *)
(*Decomposition*)


Options[DecomposeToLyndonWords] := {Alphabet :> $Alphabet};


DecomposeToLyndonWords[Except[_G|_cG|_cC,expr_], OptionsPattern[]] := HToG[expr] /. {g_ :> DecomposeToLyndonWords[g, Alphabet -> OptionValue[Alphabet]] /; MemberQ[{G,cG,cC},Head[g]]};


LynWord::AlphabetBound = "Only alphabets with at most `1` letters are supported. Some elements will not get reduced.";
LynWord::Divergence = "Lyndon word decomposition resulted in divergent quantity. Decomposition for `1` was not performed.";
LynWord::Alphabet = "`1` contains a letter that is not in alphabet `2`. Decomposition was not performed.";


DecomposeToLyndonWords[g_cG, OptionsPattern[]] := SV[DecomposeToLyndonWords[ProjSV[g], Alphabet -> OptionValue[Alphabet]]];


DecomposeToLyndonWords[g_cC, OptionsPattern[]] := ProductProjectorSV[DecomposeToLyndonWords[cG @@ g, Alphabet -> OptionValue[Alphabet]]];


DecomposeToLyndonWords[G[bs__,x_], OptionsPattern[]] := DecomposeToLyndonWords[G[bs,x], Alphabet -> OptionValue[Alphabet]] = Block[{
   $Letter,
   wor=word[bs],
   replace,abstractword,fct,alph,
   rules = Symbol["LyndonWords"<>ToString[Length[{bs}]]],
   $AlphabetOrder,$AlphabetSort   
   },

   $AlphabetOrder = Position[$Letter /@ OptionValue[Alphabet],#][[1,1]]&;
   $AlphabetSort[list_] := Sort[list, $AlphabetOrder[#1] < $AlphabetOrder[#2]&];

   If[(Length[OptionValue[Alphabet]] > $AlphabetBound) && (Length[Union[{bs}]] > $AlphabetBound),
      Message[LynWord::AlphabetBound, $AlphabetBound]
     ];


   wor = $Letter /@ wor;
   alph = Union[List@@wor];

   If[Complement[alph, $Letter /@ OptionValue[Alphabet]] =!= {},
      Message[LynWord::Alphabet, G[bs, x], OptionValue[Alphabet]];
      Return[G[bs, x]];
      ];

   alph = $AlphabetSort[alph]; 

   replace = Inner[Rule, (List @@ alph), Table[Symbol["a"<>ToString[i]],{i,Length[alph]}], List];

   abstractword = wor /. replace;
   abstractword = abstractword //. PLT$LynDecRules4 //. PLT$LynDecRules5 //. PLT$LynDecRules6(* /. LyndonDecompositionRules7 /. LyndonDecompositionRules8*);

   fct = Expand[abstractword /. word[bbs__] :> G[bbs,x] /. (Reverse/@replace) //. $Letter -> Identity];

   If[Not[FreeQ[fct, HPL[{1},1]|G[1,___,1]|G[a_,___,a_]]],
      Message[LynWord::Divergence, G[bs,x]];
      Return[G[bs,x]]
      ];

   Return[fct];
];
