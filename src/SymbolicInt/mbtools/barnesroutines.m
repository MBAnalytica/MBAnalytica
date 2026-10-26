(* ::Package:: *)
(* MBAnalytica loader for barnesroutines.m (D. A. Kosower; MB tools).  The file is in dep/MB unmodified; this loader
   loads it and then applies one fix to BarnesRoutines`Private`FindBarnesable2, by replacing two expressions in its
   saved definition.

   THE FIX (2026-07-14).  FindBarnesable2 passes FindInstance a constraint system that includes disargs == 0, the
   exponent of the non-Gamma prefactor.  For an integral carrying the MS-bar factor E^(EulerGamma eps) and a phase
   (-1)^(2 z), that exponent gives equations such as 2 EulerGamma c[2,1] + 2 I Pi c[2,1] == 0.  The equation is
   correct (it says c[2,1] == 0), but FindInstance returns unevaluated on a system with transcendental coefficients
   and several integer unknowns, and the original code then Throws "oops FindInstance left!", which kills the run.
   FindBarnesInstance divides every equation by its variable-free factors that are provably nonzero (an equivalence:
   no solution is gained or lost) and, if FindInstance still cannot evaluate, returns {} ("no Barnes change of
   variable found").  The caller then applies no Barnes lemma at that variable: a simplification is lost, never
   correctness. *)

Get[FileNameJoin[{ParentDirectory[ParentDirectory[ParentDirectory[DirectoryName[ExpandFileName[$InputFileName]]]]],
  "dep", "MB", "barnesroutines.m"}]];

Begin["BarnesRoutines`Private`"];

StripProvenConstant[Difference_, Vars_List] := Module[{Factored, Parts, Keep, FreeParts},
  Factored = Factor[Difference];
  If[Head[Factored] =!= Times, Return[Factored]];
  Parts = List @@ Factored;
  Keep = Select[Parts, ! FreeQ[#, Alternatives @@ Vars] &];
  FreeParts = Select[Parts, FreeQ[#, Alternatives @@ Vars] &];
  (* only factors proved nonzero are divided out *)
  If[Keep =!= {} && AllTrue[FreeParts, (PossibleZeroQ[#] === False) &], Return[Times @@ Keep]];
  Return[Factored]];

NormaliseEquations[Equations_, Vars_List] :=
  Equations /. HoldPattern[Equal[Lhs_, Rhs_]] :> Equal[StripProvenConstant[Lhs - Rhs, Vars], 0];

FindBarnesInstance[Equations_, Vars_List, Field_] := Module[{Unknowns, Normalised, Solution},
  Unknowns = DeleteDuplicates[Vars];
  Normalised = NormaliseEquations[Equations, Unknowns];
  Solution = TimeConstrained[Flatten[FindInstance[Normalised, Unknowns, Field]], FBtimeLimit, {}];
  If[FreeQ[Solution, FindInstance], Return[Solution]];
  Solution = TimeConstrained[Flatten[FindInstance[Equations, Unknowns, Field]], FBtimeLimit, {}];
  If[FreeQ[Solution, FindInstance], Return[Solution]];
  Message[FindBarnesInstance::stuck, Short[Normalised, 3]];
  Return[{}]];

FindBarnesInstance::stuck = "FindInstance could not evaluate the Barnes constraint system even after \
normalisation; no change of variable is applied here (this only forgoes a Barnes simplification). System: `1`";

Module[{OldRules, NewRules, CountCall, CountThrow},
  OldRules = DownValues[FindBarnesable2];
  CountCall = Count[OldRules, HoldPattern[TimeConstrained[Flatten[FindInstance[_, _, Integers]], _, {}]], Infinity];
  CountThrow = Count[OldRules, HoldPattern[If[! FreeQ[_, FindInstance], Throw["oops FindInstance left!"]]], Infinity];
  If[CountCall =!= 1 || CountThrow =!= 1,
    Print["[MBAnalytica] WARNING: barnesroutines.m is not the expected upstream version; the FindInstance fix ",
      "was NOT applied (found ", CountCall, " call(s) and ", CountThrow, " throw(s), expected 1 and 1)."];
    Return[Null, Module]];
  NewRules = OldRules /. {
    HoldPattern[TimeConstrained[Flatten[FindInstance[Eqs_, Vs_, Integers]], _, {}]] :>
      FindBarnesInstance[Eqs, Vs, Integers],
    HoldPattern[If[! FreeQ[_, FindInstance], Throw["oops FindInstance left!"]]] :> Null};
  DownValues[FindBarnesable2] = NewRules;
  BarnesFixApplied = True];

End[];
