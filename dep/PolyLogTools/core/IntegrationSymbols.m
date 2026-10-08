(* ::Package:: *)

(* ::Section:: *)
(*ImprovedFactorList*)


FactorListTerm[Power[expr_, n_], m_] := FactorListTerm[expr,n m];

FactorListTerm /: {xs___, FactorListTerm[expr_, n1_], ys___, FactorListTerm[expr_, n2_], zs___} := {xs, FactorListTerm[expr, n1 + n2], ys, zs};

FactorListTerm[m_?(IntegerQ[#] && Not[PrimeQ[#]] && (Abs[#] > 1)&), n_?(# > 0&)] := Sequence @@ (FactorListTerm @@@ FactorInteger[m^n]);



ImprovedFactorList[expr_] := Block[{faclist = FactorListTerm @@@ FactorList[PowerExpand[expr]]},

(*    faclist = faclist //. {terms1___, FactorListTerm[term_, n1_], terms2___, FactorListTerm[term_, n2_], terms3___} :> {terms1, FactorListTerm[term,n1+n2], terms2, terms3};*)
    faclist = faclist //. FactorListTerm[exp_, n_] :> FactorListTerm[Factor[exp], n];
    faclist = faclist //. {terms1___, FactorListTerm[Times[term_, terms__], n_], terms2___} :> {terms1, FactorListTerm[term, n], Sequence @@ (FactorListTerm[#, n]& /@ {terms}), terms2};
(*    faclist = faclist //. {terms1___, FactorListTerm[term_, n1_], terms2___, FactorListTerm[term_, n2_], terms3___} :> {terms1, FactorListTerm[term,n1+n2], terms2, terms3};*)
(*    faclist = faclist //. FactorListTerm[exp_, n_] :> FactorListTerm[Simplify[Abs[exp]] /. Abs -> Identity, n];*)
    Return[faclist];

];

    





(* ::Section:: *)
(*ConstructPartitions*)


MakeSigns[n_?(#>1&)] := MakeSigns[n] = Block[{
    aargs=Table[Unique["s"],{n-1}],
    counter,dum,tab,MyTable
    },
    
    counter={#,{-1,1}}& /@ aargs;
    tab = MyTable[dum @@ aargs, Sequence @@ counter];
    Prepend[#,1]&/@(Flatten[tab/.MyTable->Table]/.dum->List)];

MakeSigns[1]={1};


AddSigns[part_]:=part*#&/@MakeSigns[Length[part]];


SignedPartitions[n_]:=Block[{
   parts=Partitions[n]
   },
   Union@@(AddSigns/@parts)];


ConstructPartitions[n_, p_, offset_:0] := Block[{
   offtab = party@@Table[0,{offset}],
   parts},

   parts=SignedPartitions[p];
   parts=First/@GatherBy[parts,Sort];
   parts=Select[parts,Length[#]<=n&];
   parts=Inner[Rule,Range[Length[#]],#,List]&/@parts;
   parts=party@@@(SparseArray[#,n,0]&/@parts);
   parts = Flatten[(Permutations/@parts)];
   If[offset > 0,
      parts = Join[#,offtab]& /@ parts
     ];
      
   Return[parts]
];


InverseParty[party[sign_, powers__]] := party[sign, Sequence @@ (-{powers})];


InverseParty[party2[a_, b_]] := party2[InverseParty[a], InverseParty[b]];


(* ::Section:: *)
(*SetUp*)


flat=If[StringTake[ToString[Expand[#]/.Power->Pom,InputForm],1]==="-",Expand[-#],Expand[#]]&;

flatFactorListTerm[FactorListTerm[expr_, power_]] := Block[{fl = flat[expr]},

     If[fl =!= Expand[expr],
        Return[{FactorListTerm[-1, power], FactorListTerm[fl, power]}],
        Return[{FactorListTerm[fl, power]}]
        ];

];


SortPrimes[list_] := SortBy[list, PrimeElementOrder];
SortFactorListTerms[list_] := SortBy[list, PrimeElementOrder[#[[1]]]&];


Options[SetupPrimes] := Options[InitializeArgumentSearch];

SetupPrimes[OptionsPattern[]] := Block[{
    primestart = OptionValue[PrimeCounter],
    isnotgoodprime = True,
    primenumbers},

    $PrimeElements = Sort[flat /@ $PrimeElements];
    If[Not[ValueQ[$Tester]],
       $Tester = $PrimeElements];

    $Tester = Sort[flat /@ $Tester];

    $Filler = FactorListTerm[#,0]& /@ $Tester;

    (* Set up the Ordering *)
    Do[PrimeElementOrder[$Tester[[i]]] = i, {i, Length[$Tester]}];

    If[OptionValue[Verbose],
       Print["**** Creating prime numbers for survey..."];
      ];
    While[isnotgoodprime,
         $PrimeNumberRules = Table[$Variables[[i]] -> Prime[primestart +i - 1], {i, Length[$Variables]}];
         $SurveyNumbers = $Tester /. $PrimeNumberRules;
         If[OptionValue[Verbose],
            Print["     - Try: ", $PrimeNumberRules];
            Print["              -> ", $SurveyNumbers];
            ];
         If[Length[DeleteDuplicates[Abs /@ $SurveyNumbers]] != Length[$SurveyNumbers], 
            primestart++,
            isnotgoodprime = False; 
            ];
         ];

];

      

     
    

   

   


(* ::Section:: *)
(*Wrapper*)


Options[InitializeArgumentSearch] = {Verbose -> False, PrimeCounter-> 100, SymbolEntries -> {}};


Init::Fail = "Error: Argument of InitializeArgumentSearch must be either a list of polynomials or the path to some input file.";
Init::Polynom = "Error: Prime elements should be polynomials.";


InitializeArgumentSearch[primes_,OptionsPattern[]] := Block[{},

   Which[Head[primes] === List, 
         $PrimeElements = primes;
         If[OptionValue[SymbolEntries] === {},
            $Tester = $PrimeElements
            ];
         PLT$Depth1Arguments = {};
         $Passed={};
         $NotPassed = {},
         (**)
         Head[primes] === String, 
         Get[primes],
         True, Message[Init::Fail];Abort[]
         ];

   PLT$OneParty = party @@ Prepend[Table[0, {Length[$Tester]}], 1];

   $ArgFinderLevel = 1;

   $Variables = Variables[Union[$PrimeElements, $Tester]];
   If[Not[And @@ (PolynomialQ[#, $Variables]& /@ Union[$PrimeElements, $Tester])],
     Message[Init::Polynom]; Abort[]
     ];    

   $ToBeTested = {};

   SetupPrimes[Verbose -> OptionValue[Verbose], PrimeCounter -> OptionValue[PrimeCounter]];

   Print["Everything is set up!"];
];

   


FindDepth1Arguments[n_Integer] := Block[{results},

   Print[Style["Searching for arguments at level ", Red], Style[Dynamic[$ArgFinderLevel], Red], Style[".", Red]];
   Print["Remaining: ", Dynamic[Length[$ToBeTested]], "/", Length[$ToBeTested], "."];
   Print["Arguments found: ", Dynamic[Length[$Passed]], "."];
   

   While[$ArgFinderLevel <= n,
         FindLiArguments[$ArgFinderLevel];
         $ArgFinderLevel = $ArgFinderLevel+1;
         ];

   PLT$Depth1Arguments = $Passed;
   results = CreateFunctions[$Passed];
   results = Union[S3Orbit /@ results];

   Print["Found ", 6*Length[results], " arguments that group into ", Length[results], " orbits of S3."];
   Return[results];
];


S3S2Orbit[party2[a_,b_]]:=Block[{pre},
   pre={party2[a,b],party2[1-a,1-b],party2[a/(a-1),b/(b-1)]};
   pre=pre/.party2[x_,y_]:>party2[Factor[Simplify[a]],Factor[Simplify[b]]];
   pre=Flatten[pre/.party2[x_,y_]:>party2[1/x,1/y]];
   pre=Join[pre,Reverse/@pre];
   Return[pre];
];


PartyQuotient[party[s1_,as__],party[s2_,bs__]] := party @@ Prepend[{as}- {bs},s1*s2];


FindArg::Depth = "Depth sepcification must be 2 or higher."


TestHighDepth[list_List, pass_List] := Block[{SortedPairs, pairs},

  SortedPairs[l_List] := Union[Sort /@ DeleteCases[Tuples[l,2], {a_,a_}]];

  pairs = SortedPairs[list];
  pairs = PartyQuotient @@@ pairs;
  
  pairs = Complement[pairs, pass];
  If[pairs === {}, Return[list], Return[{}]];

];
  

   


FindHigherDepthArguments[n_Integer] := Block[{results, ansatz, PLT$S3orbit,
   passed = Prepend[PLT$Depth1Arguments, PLT$OneParty], 
   completetrivial = Table[PLT$OneParty, {n}]
   },

   If[n < 2, 
      Message[FindArg::Depth];Return[]
     ];

   ansatz = DeleteCases[Tuples[passed, n], completetrivial];
   ansatz = DeleteCases[TestHighDepth[#, passed]& /@ ansatz, {}];
   results = partyn[n] @@@ ansatz;
  
   results = CreateFunctions[results] //. party2|partyn[_] :> List;
   results = Sort /@ (S3Orbit /@ results);
   results = Union /@ Union[PLT$S3orbit @@@ results];
   results = results //. PLT$S3orbit -> List;
   

   Return[results];
];
   

   

   

   


DumpArgumentSearch[file_String] := Block[{outfile=file},

   outfile = If[StringTake[outfile, -3] === ".mx", outfile, outfile <> ".mx"];
   DumpSave[outfile, {$PrimeElements, $Tester, $Passed, $NotPassed}];
   Print["Saved output in ", outfile, "."];
];


(* ::Section:: *)
(*ConstructArgument*)


ConstructArgument[primes_, powers_] := Block[{base = Inner[Power,primes,List@@powers,Times]},
     Return[{base, -base}]
];


CheckNumFactorization[number_, base_] := Block[{bool = False},
     Do[
              If[Mod[number, base[[i]]] == 0, bool = True;Break[]],
              {i,Length[base]}];
              
     Return[bool];
];
       



TestLiArgument[party[sign_, powers__]] := Block[{
    pows = {powers}, mpows, powplus, powminus,
    testnumber, bool, testexpression, nogood, testit,
    testnumberNum, testnumberDen, s1, s2,s3,s4,s5,s6,good,
    testexpressionorig, signminus
    },

    powplus = pows //. {xs___, a_?(#<0&), ys___} :> {xs, 0, ys};
    powminus = pows //. {xs___, a_?(#>0&), ys___} :> {xs, 0, ys};

    (* Check numerically *)
    testnumberNum = (Times @@ (Power @@@ Transpose[{$SurveyNumbers, powplus}]));
    testnumberDen = (Times @@ (Power @@@ Transpose[{$SurveyNumbers, -powminus}]));
    testnumber = Numerator[Factor[1-CreateFunction[party[sign,powers]]]];
    bool = If[(testnumber === 1) || (testnumber === -1),
              True,
              CheckNumFactorization[Abs[testnumber]//.$PrimeNumberRules, $SurveyNumbers] 
            ];


    If[Not[bool],
       mpows = -pows;
       nogood = {party[sign, powers], party[sign, Sequence @@ mpows]};
       $ToBeTested = DeleteCases[$ToBeTested, Alternatives @@ nogood];
       $NotPassed = Join[$NotPassed, nogood];
       Return[0]
      ];

    testexpression = CreateFunction[party[sign, powers]];
    testexpression = ImprovedFactorList[1-testexpression];
    testit = DeleteCases[flat[First[#]]& /@ testexpression, 1];

    If[Complement[testit, $Tester] =!= {},
       mpows = -pows;
       nogood = {party[sign, powers], party[sign, Sequence @@ mpows]};
       $ToBeTested = DeleteCases[$ToBeTested, Alternatives @@ nogood];
       $NotPassed = Join[$NotPassed, nogood];
       Return[0]
      ];     

     testexpression = Flatten[flatFactorListTerm /@ testexpression];
     signminus = (Cases[testexpression, FactorListTerm[-1,_]]);
     signminus = If[signminus === {},
        1,Power @@ signminus[[1]]];
     testexpression = SortFactorListTerms[Union[DeleteCases[testexpression, FactorListTerm[(-1)|1, _]], $Filler]];
     s1 = party[sign, powers];
     s2 = party[signminus, Sequence @@ (Last /@ testexpression)];

     (* the element 1-1/R *)
     testexpressionorig =  Inner[FactorListTerm, $Tester, -pows, List];
     testexpressionorig = SortFactorListTerms[Join[testexpressionorig, testexpression,$Filler]];
     s3 = party[-sign signminus, Sequence @@ (Last /@ testexpressionorig)];

     (* The inverses *)
     s4 = InverseParty[s1];
     s5 = InverseParty[s2];
     s6 = InverseParty[s3];

     good = {s1,s2,s3,s4,s5,s6};

     (* Finished *)
     $ToBeTested = DeleteCases[$ToBeTested, Alternatives @@ good];
     $Passed = Join[$Passed, good];
     Return[1];
];
     
     
     
     

     
 
     
     
     
    
    
    

    
    
    
    

   


$Passed = {};
$NotPassed = {};
FindLiArguments[n_] := Block[{
   offset, primes, tester,
   partitions,
   testLength},

   primes = $PrimeElements;
   tester = $Tester;
   offset = Length[tester] - Length[primes];
   partitions = ConstructPartitions[Length[primes],n, offset];

   $ToBeTested = Union[Prepend[#,1]&/@partitions,Prepend[#,-1]&/@partitions];
   $ToBeTested = Complement[$ToBeTested, $Passed, $NotPassed];

   While[Length[$ToBeTested] != 0,
         TestLiArgument[$ToBeTested[[1]]]
        ];

];

    


CollectInverse[list_List]:=Gather[list,Abs[Simplify[Factor[#1 #2]]]===1&]


(* ::Section:: *)
(*G22*)


ConvoluteR1Set[list_List] := Union[Flatten[Table[party2[list[[i]], list[[j]]],{i,Length[list]},{j,i-1}]]];


(* ::Section:: *)
(*FindPrimeElements*)


FindPrimeElements[expr_] := Block[{tensor = Expand[expr]},

    tensor = tensor /. Tens[a__] :> Identity @@@ CiTi[a];

    tensor = If[Head[tensor] === Plus,
                List @@ tensor,
                {tensor}
               ];

    tensor = Union[tensor //. _ * CiTi[w__] :> CiTi[w]];
    tensor = Union[tensor /. CiTi -> Sequence];

    Return[tensor];

];
    
    


(* ::Section:: *)
(*CreateFunctions*)


CreateFunctions[list_] := CreateFunction /@ list;


CreateFunction[party[sign_, powers__]] := sign (Times @@ (Power @@@ Transpose[{$Tester, {powers}}]));

CreateFunction[party2[a_,b_]] := CreateFunction /@ party2[a,b];

CreateFunction[partyn[n_][as__]] := partyn[n][Sequence@@(CreateFunction /@ {as})];

    


(* ::Section:: *)
(**)


MakeParty[expr_]:=Block[{testexpression=ImprovedFactorList[expr],signminus},
testexpression = Flatten[flatFactorListTerm /@ testexpression];
     signminus = (Cases[testexpression, FactorListTerm[-1,_]]);
     signminus = If[signminus === {},
        1,Power @@ signminus[[1]]];
     testexpression = SortFactorListTerms[Union[DeleteCases[testexpression, FactorListTerm[(-1)|1, _]], $Filler]];
Return[party[signminus,Sequence @@ (Last /@ testexpression)]];
];


(* ::Section:: *)
(**)


PartyProduct[party2[party[s1_,as__], party[s2_,bs__]]] := party[s1 s2, Sequence @@ ({as} + {bs})];

PartyProduct[list_List] := PartyProduct /@ list;


PartyInvert[party[s_,as__]] := party[s, Sequence @@ (-{as})];

PartyInvert[party2[as__]] := PartyInvert /@ party2[as];

PartyInvert[list_List] := PartyInvert /@ list;


GatherInverses[list_List] := Union[Sort /@ ({#, PartyInvert[#]}& /@ list)];


ConstructLi22Set[r1set_] := Block[{

    ansatz = ConvoluteR1Set[r1set]

    },
    Print["* Found ", Length[ansatz], " possible arguments."];

    ansatz = Select[ansatz, TestLiArgument[PartyProduct[#]] == 1&];

    Print["* Passed = ", Length[ansatz]];

    Return[ansatz];
];

   


(* ::Section:: *)
(*Equation extractor*)


Clear[$TransBaseExtractor]


$TranscendenceBasis = {};


GetEquations::NoBasis = "No basis was defined.";


$TransBaseExtractor[sum_Plus, a_, trans_:$TranscendenceBasis] := $TransBaseExtractor[#, a, trans]& /@ sum;
$TransBaseExtractor[a_. x_^n_., b_, trans_:$TranscendenceBasis] := $TransBaseExtractor[a, x^n b, trans] /; MemberQ[trans, x];


Options[GetEquations] = {
                         Dialog    -> False,
                         TranscendenceBasis :> $TranscendenceBasis
                        };


EquationCollector[list_List] := TransBase$Elem[Plus @@ (First/@list), list[[1,2]]];


Clear[GetEquations]


GetEquations[expr_, OptionsPattern[]]:= Block[{
    temp = Expand[expr],
    diag = OptionValue[Dialog], 
    transcendencebasis = OptionValue[TranscendenceBasis]
    },

    If[transcendencebasis === {},
       Message[GetEquations::NoBasis];
       Return[];
      ];

    If[diag,
       Print["Transcendence basis with ", Length[transcendencebasis], " used:"];
       Print[transcendencebasis];
      ];

    If[Head[temp]===List,
       Return[Union[Flatten[GetEquations[#,TranscendenceBasis -> transcendencebasis]& /@ temp]]];
      ];

    temp = Expand[$TransBaseExtractor[temp, 1, transcendencebasis]];
    temp = If[Head[temp] === Plus, List@@ temp, {temp}];
    temp = GatherBy[temp, #[[2]]&];
    temp = EquationCollector /@ temp;

    If[Not[diag],
       temp = First /@ temp;
      ];

    Return[Union[temp]];

];
    
    
    
    


(* ::Section:: *)
(**)


FindDepth1Arguments[]:=Block[{out={},counter=1,goon=True,newout},
    While[goon,newout=FindDepth1Arguments[counter];
    If[Length[newout]>Length[out],
       out=newout;
       counter++,
       goon=False]];
    Return[newout]
];


GetDepth1Arguments[ncut_Integer] := Block[{out={},counter=1},
   While[counter <= ncut, out = FindDepth1Arguments[counter]];
   Return[out];
];
