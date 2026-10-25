(* ::Package:: *)

(* ::Title:: *)
(*MBAnalytica: Mellin-Barnes representations of cosmological tree integrals*)


(* ::Text:: *)
(*Read inside MBAnalytica`Private` by MBAnalytica.wl.  CosmoTreeMB turns the time integral of a tree (a wavefunction*)
(*coefficient of de Sitter, or one block of an in-in correlator)*)
(*  Int prod_v dt_v t_v^(r_v - 1) e^(-x_v t_v) prod_l K_nu_l(y_l t_>) I_nu_l(y_l t_<) prod_(K legs) K_nu(y t_v)*)
(*into balanced unit-slope MB integrals, one per orientation of the lines.  Each Bessel product is written with the*)
(*Poisson integrals (DLMF 10.32.2, 10.32.8), p = 2 w - 1, q = 1 + v; the factor (2 + v)^mu, mu = nu - 1/2, is split by one*)
(*fold and v is integrated; the times are scaled, t_v = t0 m_v with m_v a product of xi_l^(+-1) (xi_l = t_</t_> of line l)*)
(*along the path from vertex 1, and t0 is integrated.  The exponent E = sum_v c_v m_v + sum_l 2 y_l w_l m_(earlier),*)
(*c_v = x_v + sum_(v later) y_l - sum_(v earlier) y_l (+ y of each K leg at v), cleared of inverse xi's, is split into*)
(*its monomials; a negative c_v is cured by a push c m_later = c (1 - xi_l) m_later + c m_earlier.  The xi and w*)
(*integrals are Betas.  A conformally coupled line (mu = 0) has no fold.*)


(* ::Section:: *)
(*Times along the tree*)


(* m_v (exponents of the xi_l) and the Jacobian monomial of t_v, from vertex 1 along the tree *)
CosmoTreeM[Edges_List, Later_List, NV_Integer] := Module[{M, J, Todo, P, V},
  M = <|1 -> <||>|>;
  J = <||>;
  Todo = {1};
  While[Todo =!= {},
   P = First[Todo];
   Todo = Rest[Todo];
   Do[
    If[MemberQ[Edges[[L1]], P],
     V = First[DeleteCases[Edges[[L1]], P]];
     If[! KeyExistsQ[M, V],
      If[Later[[L1]] === P,
       M[V] = Merge[{M[P], <|L1 -> 1|>}, Total];
       J[V] = M[P],
       M[V] = Merge[{M[P], <|L1 -> -1|>}, Total];
       J[V] = Merge[{M[P], <|L1 -> -2|>}, Total]];
      AppendTo[Todo, V]]],
    {L1, Length[Edges]}]];
  If[Length[M] =!= NV, Return[$Failed]];
  Return[{KeySort[M], KeySort[J]}]];


(* the constant coefficient c_v of every vertex *)
CosmoVertexCoefficients[Edges_List, Later_List, XX_List, YY_List, KLegs_List] := Table[
  XX[[V]] + Total[Table[If[MemberQ[Edges[[L1]], V], If[Later[[L1]] === V, YY[[L1]], -YY[[L1]]], 0], {L1, Length[Edges]}]] +
    Total[Map[If[#[[1]] === V, #[[2]], 0] &, KLegs]],
  {V, Length[XX]}];


(* the coefficients after the pushes: a pushed vertex carries everything pushed into it *)
CosmoPushed[Edges_List, Push_List, C0_List] := Module[{Cs, Prev, Earlier},
  Cs = C0;
  Prev = C0;
  Do[
   Cs = C0;
   Do[
    If[Push[[V]] =!= 0,
     Earlier = First[DeleteCases[Edges[[Push[[V]]]], V]];
     Cs[[Earlier]] = Cs[[Earlier]] + Prev[[V]]],
    {V, Length[C0]}];
   Prev = Cs,
   {Length[C0]}];
  Return[Cs]];


(* every push map (each vertex keeps its coefficient or pushes it along a line on which it is the later end) with every
   coefficient either identically zero in the energies (its monomial is dropped, as at the boundary x_i = y_i of a
   mixing vertex) or positive at the point, fewest pushes first *)
CosmoPushChoices[Edges_List, Later_List, XP_List, YP_List, KP_List, XX_List, YY_List, KLegs_List] := Module[{NV, Options1,
    C0, CS, Good},
  NV = Length[XP];
  Options1 = Table[Join[{0}, Select[Range[Length[Edges]], Later[[#]] === V &]], {V, NV}];
  C0 = CosmoVertexCoefficients[Edges, Later, XP, YP, KP];
  CS = CosmoVertexCoefficients[Edges, Later, XX, YY, KLegs];
  Good = Select[Tuples[Options1], Function[Push, Module[{Cn = CosmoPushed[Edges, Push, C0], Cs = CosmoPushed[Edges, Push, CS]},
      AllTrue[Range[NV], PossibleZeroQ[Cs[[#]]] || TrueQ[Cn[[#]] > 0] &] && ! AllTrue[Cs, PossibleZeroQ]]]];
  Return[SortBy[Good, {Count[#, Except[0]] &, Identity}]]];


(* ::Section:: *)
(*The MB of one orientation*)


(* a line or K leg {mu, fold, variable, monomial} may carry a LIGHT SPLIT {..., mu', j}: with mu = n + mu' (n a positive
   integer, the light case nu = 3/2 - eps has n = 1, mu' = -eps) the factor (2 + v)^mu is written as
   sum_j Binomial[n, j] 2^(n - j) v^j (2 + v)^mu' and only (2 + v)^mu' is split by the fold; the term j has the fold Gammas
   Gamma[-z] Gamma[-mu' + z] and the v power mu + j + z.  Without the split the fold of (2 + v)^(1 - eps) pinches at z = 0
   AND z = 1 as eps -> 0 (Gamma[-1 + eps + z] Gamma[-z]), which leaves coefficient kernels with no separating contour *)
CosmoSplitMu[L_List] := If[Length[L] >= 6, L[[5]], L[[1]]];
CosmoSplitJ[L_List] := If[Length[L] >= 6, L[[6]], 0];
CosmoShift[L_List] := 1 + L[[1]] + If[L[[1]] === 0, 0, CosmoSplitJ[L] + L[[2]]];


(* the MB from the monomial data: Lines = {mu, fold, variable, monomial of t_later (Q-form)}, Monomials = {variable,
   exponents, (1 - var) exponents}; validated against hand-derived chain and star sectors *)
CosmoSectorMB[Spec_] := Module[{Vars, Lines, Mons, Base, PP, Zm, Pp, Gam, Pw, Betas, Ex, Om},
  Vars = Spec["Vars"];
  Lines = Spec["Lines"];
  Mons = Spec["Monomials"];
  Base = Spec["Base"];
  PP = Spec["P"];
  Zm = Table[Symbol["Global`z" <> ToString[I1]], {I1, Length[Mons]}];
  Pp = PP - Total[Map[CosmoShift, Lines]];
  Gam = Times @@ Map[If[#[[1]] === 0, 1, Gamma[-#[[2]]] Gamma[-CosmoSplitMu[#] + #[[2]]] Gamma[1 + #[[1]] + CosmoSplitJ[#] + #[[2]]]] &, Lines];
  Gam = Gam (Times @@ Map[Gamma[-#] &, Zm]) Gamma[Pp + Total[Zm]];
  Pw = (Times @@ Map[If[#[[1]] === 0, 1, #[[3]]^(-#[[2]])] &, Lines]) (Times @@ MapThread[#1[[1]]^#2 &, {Mons, Zm}]);
  Betas = Times @@ Map[Function[V1,
      Ex = Spec["Weights"][V1][[1]] - Total[Map[CosmoShift[#] Lookup[#[[4]], V1, 0] &, Lines]];
      Ex = Ex - Pp Lookup[Base, V1, 0] + Total[MapThread[#2 (Lookup[#1[[2]], V1, 0] - Lookup[Base, V1, 0]) &, {Mons, Zm}]];
      Om = Spec["Weights"][V1][[2]] + Total[MapThread[#2 Lookup[#1[[3]], V1, 0] &, {Mons, Zm}]];
      Gamma[Ex + 1] Gamma[Om + 1]/Gamma[Ex + Om + 2]], Vars];
  Return[Gam Pw Betas]];


(* the Poisson constants of a line and of a K leg in their variable u = 2 y/scale *)
CosmoLineFactor[Mu_, U_] := If[Mu === 0, 1, (U/4)^(2 (Mu + 1/2)) 2^(1 + 3 Mu) (U/2)^(-1 - Mu)/(Gamma[1 + Mu]^2 Gamma[-Mu])];
CosmoKLegFactor[Mu_, U_] := If[Mu === 0, Sqrt[Pi/2] (U/2)^(-1/2), Sqrt[Pi/2] (U/2)^(-1/2)/(Gamma[1 + Mu] Gamma[-Mu])];
(* the same with a light split {mu', j, n}: 1/Gamma[-mu'] instead of 1/Gamma[-mu], and Binomial[n, j] 2^(-j) (U/2)^(-j) *)
CosmoLineFactor[Mu_, U_, None] := CosmoLineFactor[Mu, U];
CosmoLineFactor[Mu_, U_, {MuF_, J_, Nn_}] := (U/4)^(2 (Mu + 1/2)) 2^(1 + 3 Mu) (U/2)^(-1 - Mu)/(Gamma[1 + Mu]^2 Gamma[-MuF]) *
  Binomial[Nn, J] 2^(-J) (U/2)^(-J);
CosmoKLegFactor[Mu_, U_, None] := CosmoKLegFactor[Mu, U];
CosmoKLegFactor[Mu_, U_, {MuF_, J_, Nn_}] := Sqrt[Pi/2] (U/2)^(-1/2)/(Gamma[1 + Mu] Gamma[-MuF]) Binomial[Nn, J] 2^(-J) (U/2)^(-J);
(* the integer part n of mu for the automatic light split: mu at eps = 0 (every symbol set to 0) when it is a positive integer *)
CosmoIntegerPart[Mu_] := Module[{M0 = Quiet[Mu /. Map[# -> 0 &, Cases[{Mu}, _Symbol?(! NumericQ[#] &), {0, Infinity}]]]},
  Return[If[IntegerQ[M0] && M0 >= 1, M0, 0]]];


CosmoOrientation[Edges_List, Later_List, Push_List, BaseV_Integer, RV_List, NuL_List, KLegs_List, XX_List, YY_List,
  VarName_String] := CosmoOrientation[Edges, Later, Push, BaseV, RV, NuL, KLegs, XX, YY, VarName,
  ConstantArray[None, Length[Edges] + Length[KLegs]]];
CosmoOrientation[Edges_List, Later_List, Push_List, BaseV_Integer, RV_List, NuL_List, KLegs_List, XX_List, YY_List,
  VarName_String, Splits_List] := Module[{NL, NK, NV, MJ, M, J, Xi, Ww, Uu, Zl, MuL, MuK, AV, AA, Q, ToXi, MQ, Weights, C0, Cs, Scale,
    Kept, VertexU, Mons, Lines, KLines, Spec, Earlier, Ex, URules, Integrand, Constants, Merged},
  NL = Length[Edges];
  NK = Length[KLegs];
  NV = Length[RV];
  MJ = CosmoTreeM[Edges, Later, NV];
  If[MJ === $Failed, Return[$Failed]];
  M = MJ[[1]];
  J = MJ[[2]];
  Xi = Table[Symbol["Global`k" <> ToString[L1]], {L1, NL}];
  Ww = Table[Symbol["Global`w" <> ToString[L1]], {L1, NL}];
  Kept = Select[DeleteCases[Range[NV], BaseV], ! PossibleZeroQ[CosmoPushed[Edges, Push,
      CosmoVertexCoefficients[Edges, Later, XX, YY, KLegs]][[#]]] &];
  Uu = Table[Symbol["Global`" <> VarName <> ToString[I1]], {I1, NL + NK + Length[Kept]}];
  Zl = Table[Symbol["Global`z" <> FromCharacterCode[96 + L1]], {L1, NL + NK}];
  MuL = NuL - 1/2;
  MuK = Map[#[[3]] - 1/2 &, KLegs];
  AV = Table[RV[[V]] + Total[Table[If[MemberQ[Edges[[L1]], V], NuL[[L1]], 0], {L1, NL}]] +
      Total[Map[If[#[[1]] === V, #[[3]], 0] &, KLegs]], {V, NV}];
  AA = Total[AV];
  Q = Association[Table[L1 -> Max[0, -Min[Map[Lookup[#, L1, 0] &, Values[M]]]], {L1, NL}]];
  ToXi[Assoc_] := Association[KeyValueMap[Xi[[#1]] -> #2 &, Select[Assoc, # =!= 0 &]]];
  MQ = Association[KeyValueMap[#1 -> ToXi[Merge[{#2, Q}, Total]] &, M]];
  Weights = Association[Join[
     Table[Ex = AA Q[L1] + Total[Table[(AV[[V]] - 1) Lookup[M[V], L1, 0], {V, NV}]] + Total[Map[Lookup[#, L1, 0] &, Values[J]]];
       Xi[[L1]] -> {Ex, 0}, {L1, NL}],
     Table[Ww[[L1]] -> {MuL[[L1]], MuL[[L1]]}, {L1, NL}]]];
  C0 = CosmoVertexCoefficients[Edges, Later, XX, YY, KLegs];
  Cs = CosmoPushed[Edges, Push, C0];
  Scale = Cs[[BaseV]];
  VertexU = Association[MapThread[#1 -> #2 &, {Kept, Uu[[NL + NK + 1 ;;]]}]];
  Mons = Join[
    Table[Earlier = First[DeleteCases[Edges[[L1]], Later[[L1]]]];
      {Uu[[L1]], Join[MQ[Earlier], <|Ww[[L1]] -> 1|>], <||>}, {L1, NL}],
    Map[{VertexU[#], MQ[#], If[Push[[#]] === 0, <||>, <|Xi[[Push[[#]]]] -> 1|>]} &, Kept]];
  Lines = Table[Join[{MuL[[L1]], Zl[[L1]], Uu[[L1]], MQ[Later[[L1]]]}, If[Splits[[L1]] === None, {}, Splits[[L1, 1 ;; 2]]]], {L1, NL}];
  KLines = Table[Join[{MuK[[K1]], Zl[[NL + K1]], Uu[[NL + K1]], MQ[KLegs[[K1, 1]]]},
     If[Splits[[NL + K1]] === None, {}, Splits[[NL + K1, 1 ;; 2]]]], {K1, NK}];
  Spec = <|"Vars" -> Join[Xi, Ww], "Weights" -> Weights, "Base" -> MQ[BaseV], "Monomials" -> Mons,
    "Lines" -> Join[Lines, KLines], "P" -> AA|>;
  Integrand = (Times @@ MapThread[CosmoLineFactor, {MuL, Uu[[1 ;; NL]], Splits[[1 ;; NL]]}]) *
    (Times @@ MapThread[CosmoKLegFactor, {MuK, Uu[[NL + 1 ;; NL + NK]], Splits[[NL + 1 ;; NL + NK]]}]) CosmoSectorMB[Spec];
  URules = Join[Table[Uu[[L1]] -> 2 YY[[L1]]/Scale, {L1, NL}], Table[Uu[[NL + K1]] -> 2 KLegs[[K1, 2]]/Scale, {K1, NK}],
    KeyValueMap[#2 -> Cs[[#1]]/Scale &, VertexU]];
  (* variables that are constants in the energies (u = 1 when the base is the line's own energy, at mixing vertices)
     are substituted, and variables equal to an earlier one are merged: fewer kinematic variables for MBEvaluate *)
  URules = Map[First[#] -> Together[Last[#]] &, URules];
  Constants = Select[URules, NumericQ[Last[#]] &];
  Integrand = Integrand /. Constants;
  URules = Complement[URules, Constants];
  URules = SortBy[URules, Position[Uu, First[#]] &];
  Merged = Flatten[Map[If[Length[#] > 1, Map[Function[R1, First[R1] -> First[First[#]]], Rest[#]], {}] &,
      GatherBy[URules, Last]]];
  Integrand = Integrand /. Merged;
  URules = Select[URules, ! MemberQ[Merged[[All, 1]], First[#]] &];
  Return[<|"Later" -> Later, "Push" -> Push, "Base" -> BaseV, "Integrand" -> Integrand, "Variables" -> URules,
    "Scale" -> Scale, "Prefactor" -> Scale^(-Total[RV]), "Term" -> Map[If[# === None, None, #[[2]]] &, Splits]|>]];


(* ::Section:: *)
(*User function*)


Options[CosmoTreeMB] = {"Energies" -> Automatic, "Point" -> Automatic, "KLegs" -> {}, "Orientations" -> All,
  "VariableName" -> "u", "LightSplit" -> False, "Terms" -> All, "PushChoice" -> 1};


CosmoTreeMB::point = "A numeric kinematic point {x, y} (or {x, y, K-leg energies}) is needed to choose the positive rewriting of each orientation.";
CosmoTreeMB::nopush = "Orientation `1` has no rewriting with positive coefficients at the given point.";
CosmoTreeMB::tree = "The lines `1` do not form a tree on the vertices 1, ..., `2`.";
CosmoTreeMB::unit = "At the given point, the kinematic variables `1` of the orientation with later vertices `2` are not all in the unit interval (values `3`); MBEvaluate takes them in 0 < x < 1.";


CosmoTreeMB[Edges_List, RV_List, NuL_List, OptionsPattern[]] := Module[{NV, NL, Energies, XX, YY, KLegs, Point1, XP, YP,
    KP, Orients, Results},
  NV = Length[RV];
  NL = Length[Edges];
  If[NL =!= NV - 1 || Length[NuL] =!= NL, Message[CosmoTreeMB::tree, Edges, NV]; Return[$Failed]];
  Energies = OptionValue["Energies"];
  If[Energies === Automatic,
   Energies = {Table[Symbol["Global`x" <> ToString[V]], {V, NV}], Table[Symbol["Global`y" <> ToString[L1]], {L1, NL}]}];
  {XX, YY} = Energies;
  KLegs = OptionValue["KLegs"];
  Point1 = OptionValue["Point"];
  If[Point1 === Automatic, Point1 = Energies];
  If[Length[Point1] === 2, Point1 = Append[Point1, KLegs[[All, 2]]]];
  {XP, YP, KP} = Point1;
  If[! VectorQ[Join[XP, YP], NumericQ], Message[CosmoTreeMB::point]; Return[$Failed]];
  (* the K-leg energies at the point: the third list of the point, or numbers given with the legs *)
  KP = MapThread[{#1[[1]], #2, #1[[3]]} &, {KLegs, KP}];
  If[! VectorQ[KP[[All, 2]], NumericQ], Message[CosmoTreeMB::point]; Return[$Failed]];
  Orients = OptionValue["Orientations"];
  If[Orients === All, Orients = Tuples[Edges]];
  If[CosmoTreeM[Edges, First[Orients], NV] === $Failed, Message[CosmoTreeMB::tree, Edges, NV]; Return[$Failed]];
  Results = Map[Function[Later, Module[{Pushes, Push, Cs, Free, BaseV, Choices, Terms1},
      Pushes = CosmoPushChoices[Edges, Later, XP, YP, KP, XX, YY, KLegs];
      If[Pushes === {}, Message[CosmoTreeMB::nopush, Later]; Return[$Failed, Module]];
      (* "PushChoice" -> n takes the n-th valid push (fewest pushes first; the last one if fewer exist): the MB of a hard
         orientation can close under another push *)
      Push = Pushes[[Min[OptionValue["PushChoice"], Length[Pushes]]]];
      Cs = CosmoPushed[Edges, Push, CosmoVertexCoefficients[Edges, Later, XP, YP, KP]];
      Free = Select[Range[NV], Push[[#]] === 0 && ! PossibleZeroQ[CosmoPushed[Edges, Push,
          CosmoVertexCoefficients[Edges, Later, XX, YY, KLegs]][[#]]] &];
      BaseV = First[MaximalBy[Free, Cs[[#]] &]];
      (* light split: every line or K leg with mu = n + mu' (n >= 1) gives the terms j = 0 .. n; "LightSplit" -> True
         finds n from mu at eps = 0, an integer forces n on every massive line and leg (tests); "Terms" selects terms *)
      Choices = Map[Function[Mu1, Module[{Nn = Which[OptionValue["LightSplit"] === True, CosmoIntegerPart[Mu1],
            IntegerQ[OptionValue["LightSplit"]] && Mu1 =!= 0, OptionValue["LightSplit"], True, 0]},
          If[Nn >= 1, Table[{Mu1 - Nn, J1, Nn}, {J1, 0, Nn}], {None}]]], Join[NuL - 1/2, Map[#[[3]] - 1/2 &, KLegs]]];
      Terms1 = Tuples[Choices];
      If[OptionValue["Terms"] =!= All,
        Terms1 = Select[Terms1, MemberQ[OptionValue["Terms"], Map[If[# === None, None, #[[2]]] &, #]] &]];
      Map[CosmoOrientation[Edges, Later, Push, BaseV, RV, NuL, KLegs, XX, YY, OptionValue["VariableName"], #] &, Terms1]]],
    Orients];
  Results = Flatten[Results];
  (* the positive rewriting makes the kinematic variables positive at the point; that they are also below 1, as
     MBEvaluate assumes, is checked here *)
  CosmoCheckUnit[Results, Join[Thread[XX -> XP], Thread[YY -> YP], Thread[KLegs[[All, 2]] -> KP[[All, 2]]]]];
  Return[Results]];


(* a message for every orientation whose kinematic variables are not all in (0, 1) at the point *)
CosmoCheckUnit[Results_List, PointRules_List] := Scan[Function[R1, Module[{Values1},
    If[! AssociationQ[R1], Return[Null, Module]];
    Values1 = N[R1["Variables"][[All, 2]] /. PointRules];
    If[! AllTrue[Values1, NumericQ[#] && 0 < # < 1 &],
      Message[CosmoTreeMB::unit, R1["Variables"][[All, 1]], R1["Later"], Values1]]]], Results];
