(* Derived-data bank for exact hypergeometric expansions, independent of the MB target.  Normalize only the
   regulator and an optional radial variable.  Persist each completed block before the next expensive block;
   a later timeout therefore does not erase earlier work.  Deeper expansions may supply exact prefixes. *)
hbbSchema = "20260911b";
hbbSettings[] := {HPL`$HPLAnalyticContinuationSign, HPL`$HPLAutoConvertToKnownFunctions,
  HPL`$HPLAutoReduceToMinimalSet, HPL`$HPLAutoProductExpand, HPL`$HPLAutoLogExtract,
  HPL`$HPLAutoConvertToSimplerArgument};
hbbEngine[] := hbbEngine[] = {$Version, Table[With[{ff = Quiet@FindFile[pkg]},
  If[StringQ[ff] && FileExistsQ[ff], FileHash[ff, "SHA256"], pkg]], {pkg, {"HypExp`", "HPL`"}}]};
hbbExactQ[ee_] := MBAnalytica`SymbolicInt`Private`mbtInexactNumberFreeQ[ee] &&
  FreeQ[ee, $Failed | $Aborted | _Missing | _Failure | _Association | Indeterminate | ComplexInfinity | _DirectedInfinity | _ConditionalExpression |
    _Piecewise | _Integrate | _NIntegrate | _Limit | _Series | _SeriesCoefficient |
    HypergeometricPFQ | Hypergeometric2F1 | HypExp`HypExp];
hbbRequest[qq_, ep_, radial_] := qq /. Join[{ep -> HypExpBlockBank`epsilon},
  If[Head[radial] === Symbol && radial =!= None, {radial -> HypExpBlockBank`argument}, {}]];
hbbRestore[ee_, ep_, radial_] := ee /. Join[{HypExpBlockBank`epsilon -> ep},
  If[Head[radial] === Symbol && radial =!= None, {HypExpBlockBank`argument -> radial}, {}]];

hbbExpand[qq_, ep_, depth_Integer, budget_, radial_: None] := Module[
  {request, key, dir, candidates, rec, prefix, timing, normalized, file, tmp, useBank},
  request = hbbRequest[qq, ep, radial];
  useBank = ! TrueQ[Global`$oftNoHypExpBank] && StringQ[Global`$MBStandardDir];
  If[useBank,
    dir = FileNameJoin[{Global`$MBStandardCacheDir, "hypergeometric_blocks"}];
    key = IntegerString[Hash[{hbbSchema, hbbEngine[], hbbSettings[], request}, "SHA256"], 16, 16];
    candidates = If[DirectoryQ[dir], FileNames["b_" <> key <> "_d*.m", dir], {}];
    Do[
      rec = Quiet@Check[Get[ff], $Failed];
      If[AssociationQ[rec] && Lookup[rec, "Schema", None] === hbbSchema && Lookup[rec, "Input", None] === request &&
          IntegerQ[Lookup[rec, "Depth", None]] && rec["Depth"] >= depth && hbbExactQ[Lookup[rec, "Expansion", $Failed]],
        prefix = If[rec["Depth"] === depth, rec["Expansion"],
          Quiet@TimeConstrained[Normal@Series[rec["Expansion"], {HypExpBlockBank`epsilon, 0, depth}], 30, $Failed]];
        If[hbbExactQ[prefix], Return[<|"Seconds" -> 0, "Expansion" -> hbbRestore[prefix, ep, radial],
          "Cached" -> True, "Depth" -> depth, "AvailableDepth" -> rec["Depth"]|>, Module]]], {ff, candidates}]];
  timing = AbsoluteTiming[Quiet@TimeConstrained[HypExp`HypExp[qq, ep, depth], budget, $Failed]];
  If[useBank && hbbExactQ[timing[[2]]],
    normalized = hbbRequest[timing[[2]], ep, radial];
    Quiet@CreateDirectory[dir, CreateIntermediateDirectories -> True];
    file = FileNameJoin[{dir, "b_" <> key <> "_d" <> ToString[depth] <> ".m"}];
    If[! FileExistsQ[file],
      tmp = file <> "." <> CreateUUID[] <> ".tmp";
      Quiet@Check[Put[<|"Schema" -> hbbSchema, "Input" -> request, "Depth" -> depth,
        "Expansion" -> normalized, "Engine" -> hbbEngine[], "HPLSettings" -> hbbSettings[], "Seconds" -> timing[[1]]|>, tmp];
        If[! FileExistsQ[file], RenameFile[tmp, file], DeleteFile[tmp]], Null]]];
  <|"Seconds" -> timing[[1]], "Expansion" -> timing[[2]], "Cached" -> False, "Depth" -> depth|>];

Print["[mbeHypExpBlockBank] exact derived blocks, normalized regulator/radial variables and reusable Laurent prefixes."];
