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


(* every push map (each vertex keeps its coefficient or pushes it along a line on which it is the later end) with all
   coefficients positive at the point, fewest pushes first *)
CosmoPushChoices[Edges_List, Later_List, XP_List, YP_List, KLegs_List] := Module[{NV, Options1, C0, Good},
  NV = Length[XP];
  Options1 = Table[Join[{0}, Select[Range[Length[Edges]], Later[[#]] === V &]], {V, NV}];
  C0 = CosmoVertexCoefficients[Edges, Later, XP, YP, KLegs];
  Good = Select[Tuples[Options1], Min[CosmoPushed[Edges, #, C0]] > 0 &];
  Return[SortBy[Good, {Count[#, Except[0]] &, Identity}]]];


(* ::Section:: *)
(*The MB of one orientation*)


(* the MB from the monomial data: Lines = {mu, fold, variable, monomial of t_later (Q-form)}, Monomials = {variable,
   exponents, (1 - var) exponents}; validated against hand-derived chain and star sectors *)
CosmoSectorMB[Spec_] := Module[{Vars, Lines, Mons, Base, PP, Zm, Pp, Gam, Pw, Betas, Ex, Om},
  Vars = Spec["Vars"];
  Lines = Spec["Lines"];
  Mons = Spec["Monomials"];
  Base = Spec["Base"];
  PP = Spec["P"];
  Zm = Table[Symbol["Global`z" <> ToString[I1]], {I1, Length[Mons]}];
  Pp = PP - Total[Map[(1 + #[[1]] + If[#[[1]] === 0, 0, #[[2]]]) &, Lines]];
  Gam = Times @@ Map[If[#[[1]] === 0, 1, Gamma[-#[[2]]] Gamma[-#[[1]] + #[[2]]] Gamma[1 + #[[1]] + #[[2]]]] &, Lines];
  Gam = Gam (Times @@ Map[Gamma[-#] &, Zm]) Gamma[Pp + Total[Zm]];
  Pw = (Times @@ Map[If[#[[1]] === 0, 1, #[[3]]^(-#[[2]])] &, Lines]) (Times @@ MapThread[#1[[1]]^#2 &, {Mons, Zm}]);
  Betas = Times @@ Map[Function[V1,
      Ex = Spec["Weights"][V1][[1]] - Total[Map[(1 + #[[1]] + If[#[[1]] === 0, 0, #[[2]]]) Lookup[#[[4]], V1, 0] &, Lines]];
      Ex = Ex - Pp Lookup[Base, V1, 0] + Total[MapThread[#2 (Lookup[#1[[2]], V1, 0] - Lookup[Base, V1, 0]) &, {Mons, Zm}]];
      Om = Spec["Weights"][V1][[2]] + Total[MapThread[#2 Lookup[#1[[3]], V1, 0] &, {Mons, Zm}]];
      Gamma[Ex + 1] Gamma[Om + 1]/Gamma[Ex + Om + 2]], Vars];
  Return[Gam Pw Betas]];


(* the Poisson constants of a line and of a K leg in their variable u = 2 y/scale *)
CosmoLineFactor[Mu_, U_] := If[Mu === 0, 1, (U/4)^(2 (Mu + 1/2)) 2^(1 + 3 Mu) (U/2)^(-1 - Mu)/(Gamma[1 + Mu]^2 Gamma[-Mu])];
CosmoKLegFactor[Mu_, U_] := If[Mu === 0, Sqrt[Pi/2] (U/2)^(-1/2), Sqrt[Pi/2] (U/2)^(-1/2)/(Gamma[1 + Mu] Gamma[-Mu])];


CosmoOrientation[Edges_List, Later_List, Push_List, BaseV_Integer, RV_List, NuL_List, KLegs_List, XX_List, YY_List,
  VarName_String] := Module[{NL, NK, NV, MJ, M, J, Xi, Ww, Uu, Zl, MuL, MuK, AV, AA, Q, ToXi, MQ, Weights, C0, Cs, Scale,
    VertexU, Mons, Lines, KLines, Spec, Earlier, Ex, URules, Integrand},
  NL = Length[Edges];
  NK = Length[KLegs];
  NV = Length[RV];
  MJ = CosmoTreeM[Edges, Later, NV];
  If[MJ === $Failed, Return[$Failed]];
  M = MJ[[1]];
  J = MJ[[2]];
  Xi = Table[Symbol["Global`k" <> ToString[L1]], {L1, NL}];
  Ww = Table[Symbol["Global`w" <> ToString[L1]], {L1, NL}];
  Uu = Table[Symbol["Global`" <> VarName <> ToString[I1]], {I1, NL + NK + NV - 1}];
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
  VertexU = Association[MapThread[#1 -> #2 &, {DeleteCases[Range[NV], BaseV], Uu[[NL + NK + 1 ;;]]}]];
  Mons = Join[
    Table[Earlier = First[DeleteCases[Edges[[L1]], Later[[L1]]]];
      {Uu[[L1]], Join[MQ[Earlier], <|Ww[[L1]] -> 1|>], <||>}, {L1, NL}],
    Map[{VertexU[#], MQ[#], If[Push[[#]] === 0, <||>, <|Xi[[Push[[#]]]] -> 1|>]} &, DeleteCases[Range[NV], BaseV]]];
  Lines = Table[{MuL[[L1]], Zl[[L1]], Uu[[L1]], MQ[Later[[L1]]]}, {L1, NL}];
  KLines = Table[{MuK[[K1]], Zl[[NL + K1]], Uu[[NL + K1]], MQ[KLegs[[K1, 1]]]}, {K1, NK}];
  Spec = <|"Vars" -> Join[Xi, Ww], "Weights" -> Weights, "Base" -> MQ[BaseV], "Monomials" -> Mons,
    "Lines" -> Join[Lines, KLines], "P" -> AA|>;
  Integrand = (Times @@ MapThread[CosmoLineFactor, {MuL, Uu[[1 ;; NL]]}]) *
    (Times @@ MapThread[CosmoKLegFactor, {MuK, Uu[[NL + 1 ;; NL + NK]]}]) CosmoSectorMB[Spec];
  URules = Join[Table[Uu[[L1]] -> 2 YY[[L1]]/Scale, {L1, NL}], Table[Uu[[NL + K1]] -> 2 KLegs[[K1, 2]]/Scale, {K1, NK}],
    KeyValueMap[#2 -> Cs[[#1]]/Scale &, VertexU]];
  Return[<|"Later" -> Later, "Push" -> Push, "Base" -> BaseV, "Integrand" -> Integrand, "Variables" -> URules,
    "Scale" -> Scale, "Prefactor" -> Scale^(-Total[RV])|>]];


(* ::Section:: *)
(*User function*)


Options[CosmoTreeMB] = {"Energies" -> Automatic, "Point" -> Automatic, "KLegs" -> {}, "Orientations" -> All,
  "VariableName" -> "u"};


CosmoTreeMB::point = "A numeric kinematic point {x, y} (or {x, y, K-leg energies}) is needed to choose the positive rewriting of each orientation.";
CosmoTreeMB::nopush = "Orientation `1` has no rewriting with positive coefficients at the given point.";
CosmoTreeMB::tree = "The lines `1` do not form a tree on the vertices 1, ..., `2`.";


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
  Results = Map[Function[Later, Module[{Pushes, Push, Cs, Free, BaseV},
      Pushes = CosmoPushChoices[Edges, Later, XP, YP, KP];
      If[Pushes === {}, Message[CosmoTreeMB::nopush, Later]; Return[$Failed, Module]];
      Push = First[Pushes];
      Cs = CosmoPushed[Edges, Push, CosmoVertexCoefficients[Edges, Later, XP, YP, KP]];
      Free = Select[Range[NV], Push[[#]] === 0 &];
      BaseV = First[MaximalBy[Free, Cs[[#]] &]];
      CosmoOrientation[Edges, Later, Push, BaseV, RV, NuL, KLegs, XX, YY, OptionValue["VariableName"]]]], Orients];
  Return[Results]];
