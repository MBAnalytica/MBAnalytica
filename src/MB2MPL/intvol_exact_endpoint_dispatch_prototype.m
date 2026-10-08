(* AUTHORSHIP (release R2, 2026-09-07): part of the IntVol package (exact endpoint / interior-wall / weight-two gauge modules of the Euler-integral backend). Author: Syed Mehedi Hasan. *)
(* Compose the exact endpoint and wall certificates.  A conditional endpoint
   becomes a value only after every wall reported by that endpoint is green. *)

ClearAll[IVEX$Evaluate];

IVEX$Evaluate[antiderivative_, x_, {lo_, hi_}, cellVariables_List,
    proofRecord_: Missing["NotSupplied"]] :=
 Module[{inputPrimitiveHash, variableWeightTwoGPLs, loweringNeeded,
   loweringRecord, workingPrimitive, endpointRecord, endpointStatus,
   wallRows, loweringBranchRecord, loweringBranchGate, wallRecords,
   wallGate, primitiveHash, status, gate},
  inputPrimitiveHash = IntegerString[
    Hash[antiderivative, "SHA256"], 16, 64];
  variableWeightTwoGPLs = Select[IVEP$GPLCases[antiderivative],
    Function[gpl, With[{args = List @@ gpl},
      Length[args] === 3 && Last[args] === 1 &&
        ! FreeQ[Most[args], x]]]];
  loweringNeeded = variableWeightTwoGPLs =!= {};
  loweringRecord = If[loweringNeeded,
    If[! AssociationQ[proofRecord] ||
        ! TrueQ[Lookup[proofRecord, "SourcePartitionGate", False]] ||
        ! TrueQ[Lookup[proofRecord, "ProofGate", False]] ||
        ! ListQ[Lookup[proofRecord, "SourceRepairRecords", $Failed]] ||
        ! ListQ[Lookup[proofRecord, "SourceGaugeRules", $Failed]] ||
        Lookup[proofRecord, "LastIntegrand", $Failed] === $Failed,
      <|"Status" -> "Failed",
        "FailReason" -> "WeightTwoLoweringProofRecord"|>,
      IVE2$Lower[antiderivative, proofRecord["LastIntegrand"], x,
        proofRecord["SourceRepairRecords"],
        proofRecord["SourceGaugeRules"]]],
    <|"Status" -> "NotApplicable",
      "FailReason" -> "NoVariableWeightTwoGPL", "Gate" -> True|>];
  If[loweringNeeded &&
      (! AssociationQ[loweringRecord] ||
        Lookup[loweringRecord, "Status", "Failed"] =!= "Certified" ||
        ! TrueQ[Lookup[loweringRecord, "SourceOnly", False]] ||
        ! TrueQ[Lookup[loweringRecord, "NoNumericalOracle", False]] ||
        ! TrueQ[Lookup[loweringRecord, "Gate", False]]),
    Return[<|"Status" -> "Failed",
      "FailReason" -> "WeightTwoLoweringFailed",
      "InputPrimitiveHash" -> inputPrimitiveHash,
      "VariableWeightTwoGPLs" -> variableWeightTwoGPLs,
      "LoweringRecord" -> loweringRecord, "Gate" -> False|>]];
  workingPrimitive = If[loweringNeeded,
    loweringRecord["FixedPrimitive"], antiderivative];
  primitiveHash = IntegerString[
    Hash[workingPrimitive, "SHA256"], 16, 64];
  endpointRecord = IVEP$Evaluate[
    workingPrimitive, x, {lo, hi}, cellVariables];
  If[! AssociationQ[endpointRecord],
    Return[<|"Status" -> "Failed",
      "FailReason" -> "EndpointRecordMissing"|>]];
  endpointStatus = Lookup[endpointRecord, "Status", "Failed"];
  If[! MemberQ[{"Certified", "Conditional"}, endpointStatus] ||
      ! TrueQ[Lookup[endpointRecord, "Gate", False]],
    Return[<|"Status" -> endpointStatus,
      "FailReason" -> Lookup[endpointRecord, "FailReason",
        "EndpointCertificateFailed"],
      "EndpointRecord" -> endpointRecord, "Gate" -> False|>]];
  wallRows = Lookup[endpointRecord, "WallRows", {}];
  If[endpointStatus === "Conditional" &&
      (! TrueQ[Lookup[endpointRecord, "RequiresWallAudit", False]] ||
        wallRows === {}),
    Return[<|"Status" -> "Conditional",
      "FailReason" -> "UnresolvedNonWallEndpointCondition",
      "EndpointRecord" -> endpointRecord, "Gate" -> False|>]];
  loweringBranchRecord = If[loweringNeeded,
    IVE2$BranchConnectivityAudit[loweringRecord, x, wallRows],
    <|"Status" -> "NotApplicable",
      "FailReason" -> "NoWeightTwoLowering", "Gate" -> True|>];
  loweringBranchGate = AssociationQ[loweringBranchRecord] &&
    TrueQ[Lookup[loweringBranchRecord, "Gate", False]];
  If[! loweringBranchGate,
    Return[<|"Status" -> "Failed",
      "FailReason" -> "WeightTwoBranchConnectivityFailed",
      "InputPrimitiveHash" -> inputPrimitiveHash,
      "PrimitiveHash" -> primitiveHash,
      "EndpointRecord" -> endpointRecord,
      "LoweringRecord" -> loweringRecord,
      "LoweringBranchRecord" -> loweringBranchRecord,
      "Gate" -> False|>]];
  wallRecords = Table[With[{wall = row["Letter"]},
    If[IVEIW$ExactRationalQ[wall],
      IVEIW$Evaluate[workingPrimitive, x, {lo, hi}, wall],
      IVEW$Evaluate[workingPrimitive, x, {lo, hi}, cellVariables,
        wall]]], {row, wallRows}];
  wallGate = Length[wallRecords] === Length[wallRows] &&
    AllTrue[wallRecords, AssociationQ[#] &&
      TrueQ[Lookup[#, "SourceOnly", False]] &&
      TrueQ[Lookup[#, "NoNumericalOracle", False]] &&
      Lookup[#, "Status", "Failed"] === "Certified" &&
      TrueQ[Lookup[#, "Gate", False]] &];
  gate = TrueQ[Lookup[endpointRecord, "SourceOnly", False]] &&
    TrueQ[Lookup[endpointRecord, "NoNumericalOracle", False]] &&
    TrueQ[endpointRecord["Gate"]] && wallGate;
  status = If[gate, "Certified", "Failed"];
  <|"SchemaVersion" -> 1, "SourceOnly" -> True,
    "NoNumericalOracle" -> True, "Status" -> status,
    "Variable" -> x, "Interval" -> {lo, hi},
    "CellVariables" -> cellVariables,
    "InputPrimitiveHash" -> inputPrimitiveHash,
    "PrimitiveHash" -> primitiveHash,
    "VariableWeightTwoGPLs" -> variableWeightTwoGPLs,
    "LoweringRecord" -> loweringRecord,
    "LoweringBranchRecord" -> loweringBranchRecord,
    "LoweringBranchGate" -> loweringBranchGate,
    "EndpointRecord" -> endpointRecord, "WallRows" -> wallRows,
    "WallRecords" -> wallRecords, "WallGate" -> wallGate,
    "Value" -> If[gate, endpointRecord["Value"], $Failed],
    "Gate" -> gate|>
  ];
