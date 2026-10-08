(* Parameter-local repair of removable Gamma factors concealed inside sums.
   The historical MB residue routine can differentiate an uncancelled 0/0.
   Only an exact rational cancellation or an exact Laurent coefficient is
   accepted. No invalid residue is silently dropped or assigned zero. *)
BeginPackage["MBParameter`"];
Begin["`Private`"];
$parameterResolveLPFile = FileNameJoin[{DirectoryName[ExpandFileName[$InputFileName]], "mbeResolveLP.m"}];
If[DownValues[baseParameterResidue] === {},
  DownValues[baseParameterResidue] = DownValues[MB`MBresidue] /.
    HoldPattern[MB`MBresidue] -> baseParameterResidue];
ClearAll[parameterResidue, withParameterResidues];
parameterResidue[f_, pole_] := Module[{value, normalized, method, identity},
  value = baseParameterResidue[f, pole];
  If[FreeQ[value, Indeterminate | ComplexInfinity | _DirectedInfinity], Return[value, Module]];
  normalized = Cancel[f];
  identity = TrueQ[Cancel[f - normalized] === 0];
  If[!identity, Return[value, Module]];
  value = Quiet@baseParameterResidue[normalized, pole]; method = "Exact rational Gamma cancellation";
  If[!FreeQ[value, Indeterminate | ComplexInfinity | _DirectedInfinity],
    value = Quiet@TimeConstrained[SeriesCoefficient[normalized, {pole[[1]], pole[[2]], -1}], 20, $Failed];
    method = "Exact Laurent residue after rational cancellation"];
  If[FreeQ[value, Indeterminate | ComplexInfinity | _DirectedInfinity | $Failed | _SeriesCoefficient | _Series],
    If[!ListQ[$parameterResidueRepairs], $parameterResidueRepairs = {}];
    AppendTo[$parameterResidueRepairs, <|"Source" -> f, "Pole" -> pole, "NormalizedSource" -> normalized,
      "RationalIdentity" -> identity, "Method" -> method, "Residue" -> value|>]];
  value];
SetAttributes[withParameterResidues, HoldAll];
withParameterResidues[body_] := Internal`InheritedBlock[{MB`MBresidue},
  Clear[MB`MBresidue];
  MB`MBresidue[f_, pole_] := parameterResidue[f, pole];
  body];

(* The release uses rational contour search only inside parameter resolution.
   Both the residue and contour-search definitions are restored afterwards. *)
parameterResolutionValidQ[r_] := ListQ[r] &&
  FreeQ[r, Indeterminate | $Failed | $TimedOut | ComplexInfinity | _DirectedInfinity | _Part] &&
  AllTrue[r, MatchQ[#, MB`MBint[_, {_, _List}]] &];
parameterResolve[f_, ep_, seconds_] := Internal`InheritedBlock[
  {MB`Private`MBfindResidues, Global`mbeLPFindResiduesOrig, Global`mbeLPContourPoint,
   Global`$mbeLPNodes, Global`$mbeLPFallbacks},
  Module[{rr, raw},
    If[DownValues[Global`mbeLPFindResiduesOrig] === {} && FileExistsQ[$parameterResolveLPFile],
      Get[$parameterResolveLPFile]];
    raw[] := withParameterResidues[Quiet@If[DownValues[Global`mbeRCResolveOrig] === {},
      MB`MBresolve[f, ep], Global`mbeRCResolveOrig[f, ep]]];
    rr = raw[];
    If[!parameterResolutionValidQ[rr] && DownValues[Global`mbeLPFindResiduesOrig] =!= {},
      DownValues[MB`Private`MBfindResidues] = DownValues[Global`mbeLPFindResiduesOrig] /.
        HoldPattern[Global`mbeLPFindResiduesOrig] -> MB`Private`MBfindResidues;
      rr = Quiet@TimeConstrained[raw[], Min[180, seconds], $TimedOut]];
    rr]];
End[];
EndPackage[];
Print["[mbeParameterResidueRung] local exact cancellation of removable Gamma poles; original source/residue audit."];
