(* External-parameter contract and Standard/Subtraction dispatch. 22 September 2026.
   No answer library, target identifiers, numerical fits or core changes.
   The source is the meromorphic continuation of a separating Barnes contour.
   Exact identities are applied before Laurent coefficient extraction. *)
BeginPackage["MBParameter`"];
MBParameterReduce::usage = "MBParameterReduce[f,eps,options] returns an exact scaled-Barnes reduction record, or Failure. ExternalParameters and ParameterAssumptions declare external variables and the open domain.";
MBParameterExpand::usage = "MBParameterExpand[f,eps,options] returns exact Laurent coefficients with external parameters. Unsupported cases return Failure, never a partial sum.";
$LastParameterRun::usage = "Provenance and diagnostics for the last parameter expansion.";
Options[MBParameterReduce] = {"ExternalParameters" -> {}, "ParameterAssumptions" -> True,
  "MBVariables" -> Automatic, "ParameterTimeConstraint" -> 300};
Options[MBParameterExpand] = Join[Options[MBParameterReduce], {
  "EpsOrderMin" -> -3, "EpsOrderMax" -> 0, "Verbose" -> True,
  "Route" -> "Standard", "DiskCache" -> True, "Simplify" -> True}];
Begin["`Private`"];
ClearAll[factors, symbols, exactQ, fail, prove, affineQ, contract, splitScale,
  chamber, eliminate, reduce, valuation, series, expandProduct, expandSource, publicRun];
factors[x_] := If[Head[x] === Times, List @@ x, {x}];
symbols[x_] := DeleteDuplicates@Cases[x, s_Symbol /; Context[s] =!= "System`", {0, Infinity}];
fail[why_, detail_: <||>] := Failure["MBParameter", Join[<|"Reason" -> why|>, detail]];
prove[q_, dom_] := TrueQ@Quiet@TimeConstrained[FullSimplify[q, Assumptions -> dom], 10, False];
affineQ[x_, vv_] := PolynomialQ[x, vv] && AllTrue[CoefficientRules[x, vv],
  Total[First[#]] <= 1 && MatchQ[Last[#], _Integer | _Rational] &];
exactQ[x_, allowed_List] := FreeQ[x,
  $Failed | $TimedOut | $Aborted | Indeterminate | ComplexInfinity | _DirectedInfinity |
  _Failure | _Missing | _ConditionalExpression | _Piecewise | _Integrate | _NIntegrate |
  _Sum | _NSum | _Limit | _Series | _SeriesCoefficient | _Derivative |
  _Hypergeometric2F1 | _HypergeometricPFQ | _HypExp`HypExp |
  _HyperIntica`ZeroInfPeriod | _HyperIntica`HyperIntica] &&
  Cases[x, q_?NumberQ /; Precision[q] =!= Infinity, {0, Infinity}] === {} &&
  Complement[symbols[x], allowed] === {} &&
  AllTrue[DeleteDuplicates@Cases[x, h_[___] :> h, {0, Infinity}],
    MemberQ[{Plus, Times, Power, Log, Exp, PolyLog, Gamma, PolyGamma, Zeta,
      HPL`HPL, PolyLogTools`G, List, Rational, Complex}, #] &];

contract[f_, ep_, pars_, dom_, given_] := Module[{args, inferred, vars, bases, denBases},
  If[!ListQ[pars] || !AllTrue[pars, MatchQ[#, _Symbol] &] ||
    Length[DeleteDuplicates[pars]] =!= Length[pars] || MemberQ[pars, ep],
    Return[fail["ExternalParameters must be distinct symbols, excluding epsilon."], Module]];
  If[!FreeQ[f, _Real], Return[fail["The source contains inexact numbers."], Module]];
  args = Cases[f, Gamma[a_] :> a, Infinity];
  inferred = Complement[symbols[args], Append[pars, ep]];
  vars = If[given === Automatic, inferred, given];
  If[!ListQ[vars] || !AllTrue[vars, MatchQ[#, _Symbol] &] ||
     Length[DeleteDuplicates[vars]] =!= Length[vars] ||
     Intersection[vars, Append[pars, ep]] =!= {} || Sort[vars] =!= Sort[inferred],
    Return[fail["MBVariables must match the Gamma variables and be disjoint from parameters and epsilon."], Module]];
  If[Complement[symbols[f], Join[vars, pars, {ep}]] =!= {},
    Return[fail["The source contains undeclared symbols."], Module]];
  If[!FreeQ[args, Alternatives @@ pars],
    Return[fail["External parameters in Gamma arguments require a different rung."], Module]];
  If[!AllTrue[args, affineQ[#, Append[vars, ep]] &],
    Return[fail["Gamma arguments must be rational affine in MB variables and epsilon."], Module]];
  If[pars =!= {} && !prove[Element[pars, Reals], dom],
    Return[fail["ParameterAssumptions must imply that external parameters are real."], Module]];
  If[pars =!= {} && !TrueQ[Quiet@TimeConstrained[Resolve[Exists[pars, dom], Reals], 10, False]],
    Return[fail["The real parameter domain is empty or could not be certified nonempty."], Module]];
  (* Every noninteger power involving a parameter is interpreted on a proven
     positive base; Log bases must also be positive. No PowerExpand is used. *)
  bases = DeleteDuplicates@Join[
    Cases[f, Power[b_, p_] /; !IntegerQ[p] && !FreeQ[b, Alternatives @@ pars] :> b, {0, Infinity}],
    Cases[f, Log[b_] /; !FreeQ[b, Alternatives @@ pars] :> b, {0, Infinity}]];
  If[!AllTrue[bases, FreeQ[#, Alternatives @@ Append[vars, ep]] && prove[# > 0, dom] &],
    Return[fail["Cannot prove positivity of every parameter power/log base on the supplied domain.", <|"Bases" -> bases|>], Module]];
  denBases = DeleteDuplicates@Cases[f, Power[b_, n_Integer?Negative] /;
    !FreeQ[b, Alternatives @@ pars] :> b, {0, Infinity}];
  If[!AllTrue[denBases, FreeQ[#, Alternatives @@ Append[vars, ep]] && prove[# != 0, dom] &],
    Return[fail["A parameter-dependent denominator can vanish or moves an MB/regulator pole outside the supported scale class."], Module]];
  <|"Variables" -> vars, "Parameters" -> pars, "Assumptions" -> dom, "PositiveBases" -> bases|>];

splitScale[f_, v_, allVars_, dom_] := Module[{ff = factors[f], kin, rest, yy},
  kin = Select[ff, MatchQ[#, _Power] && !FreeQ[#[[2]], v] &];
  If[!AllTrue[kin, FreeQ[#[[1]], Alternatives @@ allVars] &&
      PolynomialQ[#[[2]], v] && Exponent[#[[2]], v] === 1 &&
      MatchQ[Coefficient[#[[2]], v], _Integer | _Rational] && prove[#[[1]] > 0, dom] &], Return[$Failed, Module]];
  rest = Times @@ Select[ff, !MemberQ[kin, #] &];
  yy = Times @@ (#[[1]]^Coefficient[#[[2]], v] & /@ kin);
  <|"Rest" -> rest Times @@ (#[[1]]^(#[[2]] /. v -> 0) & /@ kin), "Scale" -> yy|>];

chamber[f_, vars_, ep_] := Module[{legs, inequalities, pt},
  If[vars === {}, Return[{}, Module]];
  legs = Select[Cases[Numerator[f], Gamma[a_] :> a, Infinity], !FreeQ[#, Alternatives @@ vars] &];
  (* The defining separating chamber need not meet a neighbourhood of zero.
     Barnes identities are meromorphic in epsilon; a distant nonempty chamber
     is sufficient before continuing the resulting expression to zero. *)
  inequalities = And @@ Join[(# > 0 & /@ legs), {ep != 0}];
  pt = Quiet@TimeConstrained[FindInstance[inequalities, Append[vars, ep], Reals], 15, {}];
  If[!ListQ[pt] || pt === {} || !TrueQ[inequalities /. First[pt]], $Failed, First[pt]]];

(* Transverse Barnes I and scaled (1,1)/(2,2) kernels, with arbitrary
   polynomial insertions absorbed through a finite Newton expansion. *)
eliminate[f_, v_, vars_, ep_, dom_] := Module[{sc, p, pl, mn, a, b, yy, cs, value, n, g},
  sc = splitScale[f, v, vars, dom]; If[sc === $Failed, Return[$Failed, Module]];
  p = Global`mbeBPRParse[sc["Rest"], v]; If[p === $Failed, Return[$Failed, Module]];
  p = Global`mbeBPRDenToPoly[p, v]; If[p === $Failed, Return[$Failed, Module]];
  pl = Select[p["num"], Coefficient[#, v] === 1 &];
  mn = Select[p["num"], Coefficient[#, v] === -1 &];
  If[!MemberQ[{{1, 1}, {2, 2}}, {Length[pl], Length[mn]}], Return[$Failed, Module]];
  yy = sc["Scale"];
  (* A nontrivial Gauss block may not retain another MB variable. *)
  If[yy =!= 1 && Length[pl] === 2 &&
    !FreeQ[Join[pl, mn], Alternatives @@ DeleteCases[vars, v]], Return[$Failed, Module]];
  If[Exponent[p["poly"], v] > 32, Return[$Failed, Module]];
  a = Expand[pl /. v -> 0]; b = Expand[mn /. v -> 0];
  If[yy =!= 1 && Length[a] === 2,
    b = SortBy[b, Total[Abs[(a + #) /. ep -> 0]] &]];
  cs = Global`mbeBPRNewton[p["poly"], v, First[a]];
  value = Sum[
    If[Length[a] === 1,
      cs[[n + 1]] yy^b[[1]] Gamma[a[[1]] + n + b[[1]]]/(1 + yy)^(a[[1]] + n + b[[1]]),
      g = Times @@ Flatten[Outer[Gamma[#1 + #2] &, a + {n, 0}, b]]/
        Gamma[Total[a] + n + Total[b]];
      cs[[n + 1]] g If[yy === 1, 1,
        yy^b[[1]] Hypergeometric2F1[a[[1]] + n + b[[1]], a[[2]] + b[[1]],
          Total[a] + n + Total[b], 1 - yy]]], {n, 0, Length[cs] - 1}];
  <|"Expression" -> p["rest"] value, "Step" -> <|"Class" ->
    If[yy === 1 && Length[a] === 2, "TransverseBarnesI", "ScaledBarnes"],
    "Variable" -> v, "Scale" -> yy, "GammaCounts" -> {Length[a], Length[b]},
    "PolynomialDegree" -> Exponent[p["poly"], v]|>|>];

reduce[f_, vars_, ep_, dom_] := Module[{current = f, remaining = vars, steps = {}, r, found},
  While[remaining =!= {},
    found = False;
    Do[r = eliminate[current, v, remaining, ep, dom];
      If[AssociationQ[r], current = r["Expression"]; AppendTo[steps, r["Step"]];
        remaining = DeleteCases[remaining, v]; found = True; Break[]], {v, remaining}];
    If[!found, Return[fail["No scaled/transverse Barnes class matches the remaining kernel.",
      <|"RemainingVariables" -> remaining, "Steps" -> steps,
        "PartialExpression" -> current|>], Module]]];
  <|"Expression" -> current, "Steps" -> steps|>];

MBParameterReduce[f_, ep_Symbol, OptionsPattern[]] := Module[{c, pt, r},
  c = contract[f, ep, OptionValue["ExternalParameters"], OptionValue["ParameterAssumptions"], OptionValue["MBVariables"]];
  If[FailureQ[c], Return[c, Module]];
  pt = chamber[f, c["Variables"], ep];
  If[pt === $Failed, Return[fail["No separating Gamma chamber found."], Module]];
  r = TimeConstrained[reduce[f, c["Variables"], ep, c["Assumptions"]],
    OptionValue["ParameterTimeConstraint"], fail["Barnes reduction timed out."]];
  If[FailureQ[r], Return[Failure[r[[1]], Join[r[[2]], c,
    <|"SeparatingPoint" -> pt, "Continuation" -> "Meromorphic from separating contour"|>]], Module]];
  Join[r, c, <|"SeparatingPoint" -> pt, "Continuation" -> "Meromorphic from separating contour",
    "Source" -> f, "Regulator" -> ep|>]];

valuation[f_, ep_] := Module[{s},
  If[FreeQ[f, ep], Return[0, Module]];
  s = Quiet@Check[Series[f, {ep, 0, 0}], $Failed];
  If[Head[s] === SeriesData, If[s[[6]] === 1, s[[4]], $Failed],
    If[FreeQ[s, ep] && s =!= 0 && s =!= $Failed, 0, $Failed]]];
series[f_, ep_, lo_, hi_] := Module[{s, out},
  s = Quiet@Check[Series[f, {ep, 0, hi}], $Failed];
  If[s === $Failed, Return[fail["Laurent expansion failed."], Module]];
  If[Head[s] === SeriesData && s[[6]] =!= 1,
    Return[fail["Fractional regulator powers are outside the Laurent contract."], Module]];
  out = Total@Table[If[Head[s] === SeriesData, SeriesCoefficient[s, k], Coefficient[Expand[s], ep, k]] ep^k, {k, lo, hi}];
  out];
expandProduct[f_, ep_, lo_, hi_, pars_, seconds_, cache_] := Module[
  {blocks, pref, lead, expansions, result, x, v, weights, depth},
  blocks = Select[factors[f], !FreeQ[#, _Hypergeometric2F1 | _HypergeometricPFQ] &];
  pref = Times @@ Select[factors[f], FreeQ[#, _Hypergeometric2F1 | _HypergeometricPFQ] &];
  If[blocks === {}, Return[series[pref, ep, lo, hi], Module]];
  (* Only a product of ordinary hypergeometric blocks with nonnegative
     regulator valuation is covered by this rung. Resonant lower parameters
     are refused, not assigned an assumed regular leading term. *)
  If[!AllTrue[blocks, MatchQ[#, _Hypergeometric2F1 | _HypergeometricPFQ | Power[_Hypergeometric2F1 | _HypergeometricPFQ, _Integer?Positive]] &],
    Return[fail["Hypergeometric block is not multiplicatively separated."], Module]];
  blocks = Flatten[blocks /. Power[h : (_Hypergeometric2F1 | _HypergeometricPFQ), n_Integer?Positive] :> ConstantArray[h, n]];
  If[AnyTrue[blocks, Function[h, With[{den = If[Head[h] === Hypergeometric2F1, {h[[3]]}, h[[2]]]},
      AnyTrue[den /. ep -> 0, IntegerQ[#] && # <= 0 &]]]], Return[fail["Resonant lower hypergeometric parameter."], Module]];
  lead = valuation[pref, ep]; If[lead === $Failed, Return[fail["Cannot determine the prefactor Laurent valuation."], Module]];
  depth = Max[0, hi - lead];
  expansions = Table[
    If[FreeQ[h, ep], h,
      Block[{Global`$oftNoHypExpBank = !TrueQ[cache]},
        If[DownValues[Global`hbbExpand] =!= {},
          Global`hbbExpand[h, ep, depth, seconds]["Expansion"],
          Quiet@TimeConstrained[HypExp`HypExp[h, ep, depth], seconds, $Failed]]]], {h, blocks}];
  If[!And @@ (exactQ[#, Append[pars, ep]] & /@ expansions),
    Return[fail["Hypergeometric coefficient expansion did not close exactly.", <|"Depth" -> depth|>], Module]];
  series[pref Times @@ expansions, ep, lo, hi]];

expandSource[f_, ep_, c_, lo_, hi_, seconds_, cache_] := Module[
  {red, fs, const, bare, lead, value, terms, values, lowerBound, partial, pc},
  (* Linearity keeps the original terms intact; a failed sibling aborts the sum. *)
  If[Head[f] === Plus,
    values = expandSource[#, ep, c, lo, hi, seconds, cache] & /@ (List @@ f);
    If[AnyTrue[values, FailureQ], Return[fail["At least one source summand failed.", <|"Failures" -> Select[values, FailureQ]|>], Module]];
    Return[Total[values], Module]];
  red = MBParameterReduce[f, ep, "ExternalParameters" -> c["Parameters"],
    "ParameterAssumptions" -> c["Assumptions"], "MBVariables" -> Automatic,
    "ParameterTimeConstraint" -> seconds];
  If[!FailureQ[red],
    AppendTo[$trace, KeyDrop[red, {"Source", "Expression"}]];
    terms = If[Head[Expand[red["Expression"]]] === Plus, List @@ Expand[red["Expression"]], {red["Expression"]}];
    values = expandProduct[#, ep, lo, hi, c["Parameters"], seconds, cache] & /@ terms;
    If[AnyTrue[values, FailureQ], Return[First@Select[values, FailureQ], Module]];
    Return[Total[values], Module]];
  (* Preserve a proved fold reduction even if it does not close the entire
     source. Continue the smaller source through the same general ladder. *)
  If[FailureQ[red] && Lookup[red[[2]], "Steps", {}] =!= {} &&
      KeyExistsQ[red[[2]], "PartialExpression"],
    partial = red[[2]]["PartialExpression"];
    pc = contract[partial, ep, c["Parameters"], c["Assumptions"], Automatic];
    If[!FailureQ[pc] && Length[pc["Variables"]] < Length[c["Variables"]],
      AppendTo[$trace, <|"Class" -> "PartialBarnesReduction", "Steps" -> red[[2]]["Steps"],
        "SeparatingPoint" -> red[[2]]["SeparatingPoint"], "VariablesBefore" -> c["Variables"],
        "VariablesAfter" -> pc["Variables"], "Expression" -> partial|>];
      Return[expandSource[partial, ep, pc, lo, hi, seconds, cache], Module]]];
  (* Parameter-independent MB kernels can use the existing Standard ladder.
     Factor the complete external prefactor before accounting for its depth. *)
  fs = factors[f];
  (* Keep epsilon-only Gamma normalization on the constant ladder. Stripping
     it needlessly asks that ladder for many positive epsilon orders. *)
  const = Times @@ Select[fs, FreeQ[#, Alternatives @@ c["Variables"]] &&
    !FreeQ[#, Alternatives @@ c["Parameters"]] &];
  bare = Times @@ Select[fs, ! (FreeQ[#, Alternatives @@ c["Variables"]] &&
    !FreeQ[#, Alternatives @@ c["Parameters"]]) &];
  If[const =!= 1 && FreeQ[bare, Alternatives @@ c["Parameters"]],
    lead = valuation[const, ep]; If[lead === $Failed, Return[red, Module]];
    lowerBound = -Length[c["Variables"]] - Total[(Which[
      MatchQ[#, Gamma[_]], 1, MatchQ[#, Power[Gamma[_], _Integer?Positive]], #[[2]], True, 0] &) /@ factors[bare]];
    value = MBAnalytica`SymbolicInt`MBresolveToMPL[bare, ep, "Route" -> "Standard", "EpsOrderMin" -> Min[lo - lead, lowerBound],
      "EpsOrderMax" -> hi - lead, "Verbose" -> False, "PieceKernels" -> 0,
      "UseCertifiedLibrary" -> False, "DiskCache" -> cache];
    If[!exactQ[value, {ep}] || MBAnalytica`SymbolicInt`Private`$mbtFailedPieces =!= {},
      Return[fail["The parameter-independent Standard factor did not close."], Module]];
    AppendTo[$trace, <|"Class" -> "ExternalFactor", "PrefactorOrder" -> lead|>];
    Return[series[const value, ep, lo, hi], Module]];
  If[DownValues[resolvedExpansion] =!= {},
    resolvedExpansion[f, ep, c, lo, hi, seconds], red]];

MBParameterExpand[f_, ep_Symbol, opts : OptionsPattern[]] := Module[
  {c, result, lo = OptionValue["EpsOrderMin"], hi = OptionValue["EpsOrderMax"], t = AbsoluteTime[], streams},
  $LastParameterRun = <|"Complete" -> False, "Source" -> f, "Regulator" -> ep|>;
  If[!MemberQ[{"Standard", "Subtraction"}, OptionValue["Route"]], Return[fail["Parameter rungs require Route -> Standard or Subtraction."], Module]];
  If[!IntegerQ[lo] || !IntegerQ[hi] || lo > hi, Return[fail["Invalid Laurent order interval."], Module]];
  c = contract[f, ep, OptionValue["ExternalParameters"], OptionValue["ParameterAssumptions"], OptionValue["MBVariables"]];
  If[FailureQ[c], $LastParameterRun = Join[$LastParameterRun, <|"Failure" -> c|>]; Return[c, Module]];
  streams = CreateDirectory[];
  result = Block[{$trace = {}, $pieceValues = <||>, $pieceChecks = <||>,
      $closureMemo = <||>, $fixedBarnesMemo = <||>, $sourceGateSamples = <||>, $parameterResidueRepairs = {},
      ProcessLink`Private`$TempPrefix = FileNameJoin[{streams, "wl-stream-"}]},
    With[{r = TimeConstrained[If[OptionValue["Route"] === "Subtraction",
      MBParameterSubtraction`PSExpand[f, ep, c, lo, hi, OptionValue["ParameterTimeConstraint"], OptionValue["DiskCache"]],
      expandSource[f, ep, c, lo, hi, OptionValue["ParameterTimeConstraint"], OptionValue["DiskCache"]]],
      OptionValue["ParameterTimeConstraint"], fail["Parameter expansion timed out."]]},
      $LastParameterRun = Join[$LastParameterRun, c, <|"Steps" -> $trace, "Orders" -> {lo, hi}, "Route" -> OptionValue["Route"]|>]; r]];
  Quiet@DeleteDirectory[streams, DeleteContents -> True];
  If[!FailureQ[result] && !exactQ[result, Append[c["Parameters"], ep]],
    result = fail["Final expression failed the exact parameter-result contract."]];
  If[!FailureQ[result] && (!AllTrue[Table[Coefficient[Expand[result], ep, k], {k, lo, hi}], FreeQ[#, ep] &] ||
      Expand[result - Total@Table[Coefficient[Expand[result], ep, k] ep^k, {k, lo, hi}]] =!= 0),
    result = fail["The result is not a Laurent polynomial with regulator-free coefficients."]];
  $LastParameterRun = Join[$LastParameterRun, <|"Complete" -> !FailureQ[result],
    "Seconds" -> AbsoluteTime[] - t, "EndpointConvention" -> "Open parameter domain; endpoints require separate limits"|>];
  If[FailureQ[result], $LastParameterRun = Join[$LastParameterRun, <|"Failure" -> result|>]];
  If[TrueQ[OptionValue["Verbose"]], Print["[ExternalParameter] ", If[FailureQ[result], result, "exact class closure complete"]]];
  result];

(* Reinstall the same conditional definition idempotently. A full loader
   reload resets core Options, so a persistent "installed" flag alone is
   insufficient. Ordinary calls (ExternalParameters -> {}) bypass this code. *)
Module[{},
  Options[MBAnalytica`SymbolicInt`MBresolveToMPL] = Join[Options[MBAnalytica`SymbolicInt`MBresolveToMPL],
    FilterRules[Options[MBParameterReduce], Except[Alternatives @@ (First /@ Options[MBAnalytica`SymbolicInt`MBresolveToMPL])]]];
  MBAnalytica`SymbolicInt`MBresolveToMPL[f_, ep_Symbol, opts : OptionsPattern[]] /;
      ("ExternalParameters" /. {opts} /. Options[MBAnalytica`SymbolicInt`MBresolveToMPL]) =!= {} :=
    MBParameterExpand[f, ep, Sequence @@ FilterRules[Join[{opts}, Options[MBAnalytica`SymbolicInt`MBresolveToMPL]], Options[MBParameterExpand]]];
  $installed = True];
End[];
EndPackage[];
Print["[mbeExternalParameterRung] explicit external parameters; scaled/transverse Barnes classes; exact Laurent contract."];
