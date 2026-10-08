(* Experimental, unwired structural Euler reduction.  If a variable occurs only in one affine power,
   integrate that variable exactly before Laurent expansion and face subtraction.  Positive endpoints
   and a fixed nonzero slope are certified by multiaffine vertex values.  The endpoint difference is
   kept in a single cube expression, including its removable regulator zero.  No target signatures. *)
alePositiveQ[pp_, vv_List] := Module[{vals},
  If[! PolynomialQ[pp, vv] || Length[vv] > 8 || ! AllTrue[vv, Exponent[pp, #] <= 1 &], Return[False]];
  vals = (Expand[pp] /. Thread[vv -> #]) & /@ Tuples[{0, 1}, Length[vv]];
  AllTrue[vals, (IntegerQ[#] || Head[#] === Rational) && TrueQ[# >= 0] &] && AnyTrue[vals, TrueQ[# > 0] &]];

aleReduceCube[cc_, vv_List, ep_] := Module[{factors, dependent, power, rest, aa, bb, pp, other, result},
  factors = If[Head[cc] === Times, List @@ cc, {cc}];
  Do[
    dependent = Select[factors, ! FreeQ[#, xx] &];
    If[Length[dependent] =!= 1, Continue[]];
    power = First[dependent];
    If[! MatchQ[power, Power[_, _]], Continue[]];
    {aa, pp} = List @@ power;
    If[! PolynomialQ[aa, xx] || Exponent[aa, xx] =!= 1 || ! FreeQ[pp, Alternatives @@ vv] ||
       ! sbrAffineQ[pp, {ep}], Continue[]];
    bb = Coefficient[aa, xx]; aa = Expand[aa /. xx -> 0]; other = DeleteCases[vv, xx];
    If[! alePositiveQ[aa, other] || ! alePositiveQ[Expand[aa + bb], other] ||
       ! (alePositiveQ[bb, other] || alePositiveQ[-bb, other]), Continue[]];
    rest = Times @@ DeleteCases[factors, power];
    If[! FreeQ[rest, xx], Continue[]];
    result = rest If[TrueQ[pp === -1], (Log[aa + bb] - Log[aa])/bb,
      ((aa + bb)^(pp + 1) - aa^(pp + 1))/(bb (pp + 1))];
    Return[<|"Reduced" -> True, "Variable" -> xx, "OriginalCube" -> cc, "OriginalVariables" -> vv,
      "Cube" -> result, "Vars" -> other, "AffineConstant" -> aa, "AffineSlope" -> bb,
      "Exponent" -> pp, "PositiveEndpoints" -> True|>, Module], {xx, vv}];
  <|"Reduced" -> False, "Reason" -> "no single affine-power variable with certified positive endpoints"|>];

(* Prototype terminal adapter using the existing face subtraction and whole-piece integrator.  It has its
   own derived-data bank and refuses any missing exact integral; no whole-source monomial fallback is used. *)
aleCubeLaurent[red_Association, pref_, ep_, lo_Integer, hi_Integer, verbose_: False] := Catch[Module[
  {norm, vv, pieces, logs, prefSeries, prefLead, cubeLo, cubeHi, bankDir, key, coefs = <||>, jobs, value,
   bank, bankOf, whole, series, result, start = AbsoluteTime[], run = {}},
  If[! TrueQ[red["Reduced"]], Throw[$Failed, aleTag]];
  vv = red["Vars"];
  norm = Catch[Global`fcuNormalize[red["Cube"], vv, ep], Global`fcu$tag];
  If[AssociationQ[norm], Throw[$Failed, aleTag]];
  pieces = Catch[Global`fcuFacePieces[norm, vv, ep], Global`fcu$tag];
  If[! ListQ[pieces], Throw[$Failed, aleTag]];
  logs = Global`fcuStructuralLogs[pieces, vv];
  prefSeries = Series[pref, {ep, 0, hi + 2}];
  prefLead = Global`fcuLeadOrderOfSeries[prefSeries, pref]; cubeHi = hi - prefLead;
  cubeLo = Min[Global`fcuLeadOrder[Global`fcuApplyOps[#, #["R"], ep], ep, Max[0, cubeHi]] & /@ pieces];
  If[cubeLo === Infinity, Return[ConstantArray[0, hi - lo + 1], Module]];
  bankDir = FileNameJoin[{Global`$MBStandardCacheDir, "affine_euler_leaf"}];
  Quiet@CreateDirectory[bankDir, CreateIntermediateDirectories -> True];
  key = IntegerString[Hash[{"affine-leaf-v1", norm, vv}, "SHA256"], 16, 16];
  If[verbose, Print["    [affine Euler leaf] ", red["Variable"], " integrated; ", Length[vv], " variables, ",
    Length[pieces], " structural sources, cube orders ", {cubeLo, cubeHi}, ", key ", key]];
  Do[
    bank = FileNameJoin[{bankDir, "o_" <> key <> "_e" <> ToString[kk] <> ".m"}];
    If[FileExistsQ[bank] && TrueQ[Global`$fcuBankRead], coefs[kk] = Get[bank]; Continue[]];
    jobs = Join @@ (Global`fcuPieceOrder[#, kk, ep, logs] & /@ pieces);
    Put[jobs, FileNameJoin[{bankDir, "jobs_" <> key <> "_e" <> ToString[kk] <> ".m"}]];
    bankOf = Function[pc, FileNameJoin[{bankDir, "p_" <> key <> "_e" <> ToString[kk] <> "_" <>
      IntegerString[Hash[pc, "SHA256"], 16, 16] <> ".m"}]];
    If[verbose, Print["    [affine Euler leaf] cube order ", kk, ": ", Length[jobs], " whole pieces"]];
    whole = Global`fcuRunJobs[jobs, {}, bankOf, verbose, "affine leaf eps^" <> ToString[kk]];
    If[MemberQ[whole, $Failed] || ! MBtoMPL`Private`mbtInexactNumberFreeQ[whole], Throw[$Failed, aleTag]];
    coefs[kk] = Total[whole]; Put[coefs[kk], bank];
    AppendTo[run, <|"CubeOrder" -> kk, "Jobs" -> Length[jobs]|>], {kk, cubeLo, cubeHi}];
  series = Series[pref Sum[coefs[kk] ep^kk, {kk, cubeLo, cubeHi}], {ep, 0, hi}];
  result = Table[abtCoefficient[series, ep, kk], {kk, lo, hi}];
  If[abtUnfinishedQ[result] || ! FreeQ[result, ep | $Failed | $Aborted | Indeterminate | ComplexInfinity | _DirectedInfinity] ||
    ! MBtoMPL`Private`mbtInexactNumberFreeQ[result], Throw[$Failed, aleTag]];
  Global`$aleLastRun = <|"Key" -> key, "ReducedVariable" -> red["Variable"], "Variables" -> vv,
    "Orders" -> {lo, hi}, "Jobs" -> run, "Seconds" -> AbsoluteTime[] - start|>;
  Global`mbeCanonicalConstants /@ result], aleTag];

Print["[mbeAffineEulerLeafRung] experimental positive affine-power Euler integration; dispatcher unchanged."];
