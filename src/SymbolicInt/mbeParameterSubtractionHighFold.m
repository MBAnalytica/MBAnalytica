(* ::Package:: *)
(* mbeParameterSubtractionHighFold.m -- development sidecar (2026-09-22).
   The parameter Subtraction ladder extended by the classes used in the differential campaign
   differential_u_subtraction_to14_20260922 (MB6u, MB10u, MB11u, ...).  Same identities as the research drivers
   prepare_component.wls / prepare_bounded_cubes.wls / adaptive_cube2.wls / prepare_normalized.wls /
   run_native_orders.py / root_audit.py / collect_candidate.wls; only their orchestration is packaged here.
   No target recognition, no result bank.  Loaded after mbeParameterSubtractionDispatch.m; PSExpand delegates high-fold resolved residues to PSHResidue.

   PSHExpand[f, eps, contract, lo, hi, seconds, cache] -- same contract as PSExpand:
     0. a sum is expanded term by term;
     1. exact Barnes reduction + endpoint-subtracted Gauss series (PSExactReducedSeries), as PSExpand;
     2. fresh contour resolution; every residue with a Gamma function inside a sum is normalized exactly
        (integer part of each power split off, inert powers, Factor, identity verified by Together);
     3. zero folds: Gamma/Bell series;
     4. one fold: external-factor tower (PSExpand's towerTerm), else the scaled tower with the damping variable kept
        (splitScale + abtLaurentOne with the endpoint at the scale), else a faithful cube (step 5);
     5. several folds: positive faithful cubes -- PSCubeCandidates (<=3 folds) or the bounded order search (>3);
        dangerous compound corners are audited; a corner-free inversion is searched over all elimination orders and
        pairing plans before any sector decomposition; otherwise fcuBlowUp sectors;
        every sector: PSPrepareCube with the adaptive prefactor-valuation series, native finite coefficient jobs with
        parallel integration orders, and for residues with >= $PSHAuditMinFold folds the exact algebraic-root audit;
     6. the Laurent polynomial is collected exactly by transcendental atoms (Together per coefficient) and checked
        structurally.
   A refused residue refuses the whole call; no residue is filled by zero. *)
BeginPackage["MBParameterSubtractionHF`"];
PSHExpand::usage = "PSHExpand[f,eps,contract,lo,hi,seconds,cache]: parameter Subtraction ladder with high-fold classes.";
PSHResidue::usage = "PSHResidue[term,index,eps,lo,hi,parameters,seconds,cache] attempts a bounded positive high-fold Euler subtraction.";
$PSHNativeSeconds::usage = "Seconds per integration order of a native coefficient job (default 1200).";
$PSHNativeWorkers::usage = "Concurrent native processes (default 16).";
$PSHAuditMinFold::usage = "Residues with at least this many MB folds get the algebraic-root audit (default 4).";
$PSHAdaptiveSeconds::usage = "Time for the corner-free inversion search of one residue (default 3600).";
$PSHBlowUpSeconds::usage = "Time for the sector decomposition of one candidate (default 1800).";
$PSHPrepareSeconds::usage = "Time for the face subtraction and series of one sector (default 3600).";
$PSHTrace::usage = "Per-residue record of the last PSHExpand call.";
$PSHRefusedJobSets::usage = "Keys (MBParameterSubtraction`Private`psJobSetKey) of the job sets the plain cube ladder of the same residue has already integrated and refused; a single-sector candidate with the same jobs is not integrated again.";
Begin["`Private`"];
If[!ValueQ[$PSHDeadline], $PSHDeadline = Infinity];
If[!ValueQ[$PSHNativeSeconds], $PSHNativeSeconds = 1200];
If[!ValueQ[$PSHNativeWorkers], $PSHNativeWorkers = 16];
If[!ValueQ[$PSHAuditMinFold], $PSHAuditMinFold = 4];
If[!ValueQ[$PSHAdaptiveSeconds], $PSHAdaptiveSeconds = 3600];
If[!ValueQ[$PSHBlowUpSeconds], $PSHBlowUpSeconds = 1800];
If[!ValueQ[$PSHPrepareSeconds], $PSHPrepareSeconds = 3600];
$here = DirectoryName[ExpandFileName[$InputFileName]];
refuse[msg_, data_ : <||>] := Failure["ParameterSubtraction", Join[<|"Reason" -> msg|>, data]];
ff[e_] := If[Head[e] === Times, List @@ e, {e}];

(* ---- 2. exact normalization of a sum over a common Gamma product ---- *)
inertSplit[e_, ep_] := e /. Power[b_, x_] /; !IntegerQ[x] && !FreeQ[x, ep | _Symbol] :>
  Module[{k = If[Head[x] === Plus, Total[Select[List @@ x, IntegerQ]], 0]}, b^k inertPow[b, x - k]];
gammaInSumQ[f_] := !FreeQ[Cases[f, _Plus, Infinity], Gamma];
normalizeResidue[f_, ep_] := Module[{fi = inertSplit[f, ep], fn, ok},
  fn = Factor[fi]; ok = TimeConstrained[Together[fi - fn] === 0, 120, False];
  If[!TrueQ[ok] || gammaInSumQ[fn /. inertPow -> Power], Return[refuse["Residue normalization failed"], Module]];
  fn /. inertPow -> Power];

(* ---- 5. PSPrepareCube with the adaptive prefactor-valuation series ---- *)
prefValuationSeries[f_, e_, h_] := Module[{k = Max[0, h], v},
  While[k <= Max[0, h] + 12, v = MBParameterSubtraction`PSGammaSeries[f, e, k];
    If[Head[v] =!= SeriesData || v[[3]] =!= {}, Return[v, Module]]; k++]; v];
DownValues[prepareV] = DownValues[MBParameterSubtraction`PSPrepareCube] /.
  {HoldPattern[MBParameterSubtraction`PSPrepareCube] -> prepareV,
   HoldPattern[MBParameterSubtraction`PSGammaSeries[f_, e_, Max[0, h_]]] :> prefValuationSeries[f, e, h]};

(* ---- 4. scaled one-fold tower with the damping variable ---- *)
scaledTower[term_, ep_, lo_, hi_, pars_, dom_, seconds_] := Module[
  {z = First[Keys[term[[2, 2]]]], cc = term[[2, 2, 1, 2]], sc, bb, bare, vals},
  sc = MBParameter`Private`splitScale[term[[1]], z, {z}, dom];
  If[!AssociationQ[sc], Return[refuse["No scale split"], Module]]; bb = sc["Scale"]; bare = sc["Rest"];
  If[bb === 1, vals = TimeConstrained[Global`oftAbelClose[term, ep, lo, hi, False], seconds, $Aborted],
    If[!MBParameter`Private`prove[0 < bb < 1, dom],
      If[!MBParameter`Private`prove[0 < 1/bb < 1, dom], Return[refuse["Scale not in the unit interval"], Module]];
      bb = 1/bb; bare = bare /. z -> -z; cc = -cc];
    vals = Block[{Global`abtEndpoint}, Global`abtEndpoint[v_, x_] := v /. x -> bb;
      TimeConstrained[Global`abtLaurentOne[bare, z, ep, cc, lo, hi, False], seconds, $Aborted]]];
  If[ListQ[vals] && Length[vals] === hi - lo + 1 && FreeQ[vals, $Failed | $Aborted | _Real],
    Total[MapThread[#1 ep^#2 &, {vals, Range[lo, hi]}]], refuse["Scaled tower refused", <|"Values" -> vals|>]]];

(* ---- 5. candidates: bounded order search, then the corner-free search over all orders and plans ---- *)
invertRow[f_, vars_, ctr_, ep_, oo_, en_, pp_, dr_, pars_, secs_] := Module[{inv, norm, leaf, cube, axes, fs, cf},
  inv = TimeConstrained[Global`fcuInvertV2[If[AssociationQ[dr], dr["K"], f], vars, ctr, ep, oo, en, pp, dr], secs, $Aborted];
  If[!AssociationQ[inv] || TrueQ[inv["Failed"]], Return[None, Module]];
  norm = TimeConstrained[Global`psuNormalizeCube[inv["Cube"], inv["Vars"], ep, pars], secs, $Aborted];
  If[!AssociationQ[norm], Return[None, Module]];
  leaf = MBParameterSubtraction`Private`freeAffineLeaves[norm["Expression"], inv["Vars"], pars];
  cube = leaf["Expression"]; axes = leaf["Variables"];
  fs = ff[cube]; cf = Times @@ Select[fs, FreeQ[#, Alternatives @@ axes] &]; cube = Times @@ Select[fs, !FreeQ[#, Alternatives @@ axes] &];
  <|"Cube" -> cube, "Variables" -> axes, "Prefactor" -> If[AssociationQ[dr], dr["Prefactor"], 1] inv["Prefactor"] cf,
    "Order" -> oo, "Plan" -> pp, "SafeEpsilon" -> en, "Dressing" -> dr, "Inversion" -> inv,
    "PositivityProofs" -> norm["PositivityProofs"], "AffineLeafProofs" -> leaf["Proof"]|>];
corners[row_, ep_] := TimeConstrained[Length[Global`fcuCornerLetters[row["Cube"], row["Variables"], ep]], 30, Infinity];
candidateSearch[term_, ep_, pars_] := Module[{f = term[[1]], ctr = term[[2, 2]], vars, gn, en, dr, score, ordered, orders,
    rows = {}, row, best, t0 = AbsoluteTime[], all},
  vars = Keys[ctr];
  If[Length[vars] <= 3, rows = MBParameterSubtraction`PSCubeCandidates[term, ep, pars]; If[!ListQ[rows], rows = {}]];
  gn = MBParameter`Private`gammaQuotientNormalize[f, vars]; If[AssociationQ[gn], f = gn["Expression"]];
  en = ep -> Global`fcuSafeEps[f, vars, ctr, ep];
  dr = TimeConstrained[Global`fcuDress[f, vars, ctr, en, ep], 60, $Aborted];
  If[dr =!= None && (!AssociationQ[dr] || TrueQ[dr["Failed"]]), If[rows === {}, Return[refuse["Faithful dressing refused", <|"Detail" -> dr|>], Module]]];
  If[Length[vars] > 3,
    score[v_] := Count[Cases[f, Gamma[a_] :> a, Infinity], a_ /; !FreeQ[a, v]];
    ordered = SortBy[vars, {score[#], ToString[#]} &];
    orders = DeleteDuplicates[{ordered, Reverse[ordered], vars, Reverse[vars], RotateLeft[ordered], RotateRight[ordered]}];
    Do[row = invertRow[f, vars, ctr, ep, oo, en, pp, dr, pars, 30]; If[AssociationQ[row], AppendTo[rows, row]];
      If[Length[rows] >= 3, Break[]], {oo, orders}, {pp, {{}, {2}}}]];
  rows = (Append[#, "Corners" -> corners[#, ep]] &) /@ rows;
  If[rows =!= {} && Min[Lookup[rows, "Corners"]] === 0,
    Return[SortBy[rows, {#["Corners"], Length[#["Variables"]]} &], Module]];
  (* corner-free search over every elimination order and pairing plan *)
  If[AssociationQ[dr] || dr === None,
    all = SortBy[Permutations[vars], Hash];
    Catch[Do[If[AbsoluteTime[] - t0 > $PSHAdaptiveSeconds, Throw[Null, cf]];
      row = invertRow[f, vars, ctr, ep, oo, en, pp, dr, pars, 20];
      If[AssociationQ[row] && Length[row["Variables"]] <= 11, row = Append[row, "Corners" -> corners[row, ep]]; AppendTo[rows, row];
        If[row["Corners"] === 0, Throw[Null, cf]]], {oo, all}, {pp, {{}, {2}, {3}}}], cf]];
  If[rows === {}, refuse["No positive faithful cube construction"], SortBy[rows, {#["Corners"], Length[#["Variables"]]} &]]];

(* ---- 5. fibration-guided integration orders (2026-09-23) ----
   A variable is integrable only while every letter containing it is linear in it (Panzer, linear reducibility).
   Letters = irreducible factors of the denominators and Log arguments, the atoms x, 1-x excluded.  Affine leaves
   (in exactly one letter, to degree one) first, then the variables linear in every letter (fewer letters first),
   variables of degree >= 2 in some letter last; all permutations inside the three blocks, capped.  Measured on the
   differential campaign: jobs refused in every saved order ("nonlinear factor") close in the leaf-first orders. *)
atomLetterQ[f_, vars_] := MatchQ[Expand[f], v_Symbol /; MemberQ[vars, v]] || MatchQ[Expand[f], 1 - (v_Symbol /; MemberQ[vars, v])] ||
  MatchQ[Expand[f], -1 + (v_Symbol /; MemberQ[vars, v])];
jobLetters[e_, vars_] := Module[{dens, logs},
  dens = Cases[{e}, Power[b_, x_?Negative] :> b, {0, Infinity}];
  logs = Cases[{e}, Log[a_] :> a, {0, Infinity}];
  logs = Flatten[If[Head[#] === Times || Head[#] === Power, {Numerator[#], Denominator[#]}, {#}] & /@ logs];
  Select[DeleteDuplicates[Flatten[(First /@ FactorList[#]) & /@ DeleteDuplicates[Select[Flatten[{dens, logs}], !FreeQ[#, Alternatives @@ vars] &]]]],
    !FreeQ[#, Alternatives @@ vars] && !atomLetterQ[#, vars] &]];
heurOrders[e_, vars_List, nmax_Integer] := Module[{L, deg, leaves, quad, lin},
  L = TimeConstrained[jobLetters[e, vars], 90, $Aborted]; If[L === $Aborted, Return[{}, Module]];
  deg = AssociationMap[Function[v, Max[0, Exponent[#, v] & /@ L]], vars];
  leaves = Select[vars, Function[v, With[{c = Select[L, !FreeQ[#, v] &]}, Length[c] === 1 && Exponent[c[[1]], v] === 1]]];
  quad = Select[vars, deg[#] >= 2 && !MemberQ[leaves, #] &];
  lin = SortBy[Complement[vars, leaves, quad], Count[L, p_ /; !FreeQ[p, #]] &];
  <|"Orders" -> Take[Flatten[Outer[Join, Permutations[leaves], Permutations[lin], Permutations[quad], 1], 2], UpTo[nmax]],
    "Structural" -> (leaves =!= {} || quad =!= {})|>];

(* ---- 5. exact absolute-convergence certificate of one finite coefficient job (Nilsson-Passare interior condition;
   subtraction_syed.tex, pilot section "Exact convergence of the rational boundary candidates").  Map x -> y/(1+y) with
   the Jacobian; every denominator factor must have coefficients of one sign uniformly for 0<u<1 (u = t/(1+t)); for
   every numerator monomial y^a, a+1 must be an interior point of sum_j b_j Newt(P_j) (exact rational LP weights with a
   positive margin, all equalities rechecked) and the Minkowski sum must be full-dimensional.  Logarithms are
   independent symbols (absorbed by the strict margin).  A certified job may run without the backend's divergence scan,
   which false-positives on convergent multi-pole integrands (MB13u residue 12, job 1) and doubles the cost. ---- *)
newtonCertificate[e0_, vars_List, pars_List] := Module[{logs, rat, y, num, den, fl, facs, ok, supports, full, mons,
    posQ, lpOK},
  posQ[p_] := Module[{ts = Table[Unique["pshT"], {Length[pars]}], q, cs},
    q = Together[p /. Thread[pars -> ts/(1 + ts)]]; cs = Last /@ CoefficientRules[Expand[Numerator[q]], Join[y, ts]];
    VectorQ[cs, NumericQ] && (AllTrue[cs, # >= 0 &] || AllTrue[cs, # <= 0 &])];
  logs = Union[Cases[e0, _Log, Infinity]];
  rat = e0 /. Thread[logs -> Table[Unique["pshL"], {Length[logs]}]];
  y = Table[Unique["pshY"], {Length[vars]}];
  rat = Together[(rat /. Thread[vars -> y/(1 + y)]) Times @@ ((1 + #)^-2 & /@ y)];
  num = Expand[Numerator[rat]]; den = Denominator[rat];
  fl = Select[FactorList[den], !FreeQ[#[[1]], Alternatives @@ y] &];
  facs = Table[<|"P" -> Expand[f[[1]]], "b" -> f[[2]]|>, {f, fl}];
  ok = AllTrue[facs, posQ[#["P"]] &];
  If[!ok, Return[False, Module]];
  supports = Table[Union[First /@ CoefficientRules[f["P"], y]], {f, facs}];
  full = MatrixRank[Flatten[Table[(# - First[s]) & /@ s, {s, supports}], 1]] === Length[y];
  If[!full, Return[False, Module]];
  mons = Union[First /@ CoefficientRules[num, y]];
  lpOK[a_] := Module[{nl = Total[Length /@ supports], cols, Aeq, beq, sol},
    cols = Flatten[Table[{j, m}, {j, Length[supports]}, {m, Length[supports[[j]]]}], 1];
    Aeq = Join[Table[Table[facs[[c[[1]], "b"]] supports[[c[[1]], c[[2]], k]], {c, cols}], {k, Length[y]}],
      Table[Table[If[c[[1]] === jj, 1, 0], {c, cols}], {jj, Length[supports]}]];
    beq = Join[a + 1, ConstantArray[1, Length[supports]]];
    sol = Quiet@LinearProgramming[Append[ConstantArray[0, nl], -1],
      Join[Map[Append[#, 0] &, Aeq], Table[Append[UnitVector[nl, c], -1], {c, nl}]],
      Join[Thread[{beq, 0}], ConstantArray[{0, 1}, nl]],
      Append[ConstantArray[{0, Infinity}, nl], {-Infinity, Infinity}]];
    VectorQ[sol, NumericQ] && Last[sol] > 0 && AllTrue[Aeq.Most[sol] - beq, # == 0 &]];
  AllTrue[mons, lpOK]];

(* ---- 5. native jobs: parallel orders, optional algebraic-root audit ---- *)
integrateJobs[jobs_List, pars_List, dir_String, audit_, cache_] := Module[
  {np, rules, reverseRules, rows = {}, cn = <||>, direct = <||>, vars, f, dep, constant, orders, rq, input, output, proc,
   result, values, id, lastFoldValues, uncertified, responses},
  np = Table[Symbol["Global`psParameter" <> ToString[i]], {i, Length[pars]}];
  rules = Thread[pars -> np]; reverseRules = Thread[np -> pars];
  Do[id = j["ID"]; vars = j["Variables"]; f = j["Integrand"];
    If[vars === {}, AssociateTo[direct, id -> f]; Continue[]];
    dep = Select[ff[f], !FreeQ[#, Alternatives @@ vars] &]; constant = Times @@ Complement[ff[f], dep];
    AssociateTo[cn, id -> constant];
    orders = DeleteDuplicates[{Global`fcuKernelFirstOrder[Times @@ dep, vars], vars, Reverse[vars], RotateLeft[vars], RotateRight[vars]}];
    With[{h = heurOrders[Times @@ dep, vars, 48]},
      If[AssociationQ[h], orders = DeleteDuplicates[If[TrueQ[h["Structural"]], Join[h["Orders"], orders], Join[orders, h["Orders"]]]]]];
    rq = Global`ivfNativeRequest[Global`ivfPolyLogToHlog[(Times @@ dep /. rules) /. Global`constToHF], vars, First[orders], True, np];
    rq["algebraic_letters"] = False; rq["spectator_algebraic_letters"] = False;
    AppendTo[rows, <|"id" -> id, "request" -> rq, "orders" -> (SymbolName /@ # & /@ orders)|>], {j, jobs}];
  input = FileNameJoin[{dir, "requests.json"}]; output = FileNameJoin[{dir, "responses.json"}];
  Export[input, <|"jobs" -> rows, "binary" -> MBParameterSubtraction`PSNativeEngine[], "cache" -> TrueQ[cache], "job_seconds" -> $PSHNativeSeconds,
    "record_directory" -> FileNameJoin[{dir, "native"}], "workers" -> $PSHNativeWorkers, "audit" -> TrueQ[audit],
    "watch" -> MBParameterSubtraction`Private`psWatchList[rows],
    "deadline_unix" -> If[$PSHDeadline===Infinity,UnixTime[]+3600,UnixTime[]+Max[0,$PSHDeadline-AbsoluteTime[]]]|>, "RawJSON"];
  proc = RunProcess[Join[MBAnalytica`Portable`TimeoutArgs[Max[1,Ceiling[If[$PSHDeadline===Infinity,3600,$PSHDeadline-AbsoluteTime[]]]], 2],
    {MBParameterSubtraction`Private`psPython[], FileNameJoin[{$here, "mbe_parameter_subtraction_native_par.py"}], input, output}]];
  If[!AssociationQ[proc] || proc["ExitCode"] =!= 0 || !FileExistsQ[output], Return[refuse["Native runner failed", <|"Directory" -> dir|>], Module]];
  result = Import[output, "RawJSON"];
  If[KeyExistsQ[result, "aborted"], Return[refuse["A finite coefficient job closes neither natively nor by the exact last fold (not certifiably convergent alone)",
    <|"Directory" -> dir, "Jobs" -> {ToString[result["aborted"]]}|>], Module]];
  (* release R3.1 (4 October 2026): the second native pass with longer limits for jobs left open for lack of time
     (MBParameterSubtraction`Private`psNativeRetry; the same one as in the plain cube ladder) *)
  result = MBParameterSubtraction`Private`psNativeRetry[dir, input, result,
    If[$PSHDeadline === Infinity, 3600, $PSHDeadline - AbsoluteTime[]]];
  If[KeyExistsQ[result, "Doomed"], Return[refuse["A finite coefficient job closes neither natively nor by the exact last fold (not certifiably convergent alone)",
    <|"Directory" -> dir, "Jobs" -> result["Doomed"]|>], Module]];
  (* release R3.1 (3 October 2026): a record is certified only when it succeeded AND, when the root audit ran, its
     verdict is "safe"; other records are treated as unclosed ones (the 29 September edit below had let them through
     whenever every record succeeded) *)
  uncertified = Union[MBParameterSubtraction`Private`psIds[Select[result["records"], !TrueQ[#["success"]] &]],
    If[TrueQ[audit], ToString /@ Keys[Select[Replace[Lookup[result, "audit", <||>], Except[_Association] -> <||>], # =!= "safe" &]], {}],
    Complement[MBParameterSubtraction`Private`psIds[rows], MBParameterSubtraction`Private`psIds[result["records"]]]];
  (* 2026-09-29 (general multifold handler): unclosed native jobs go to the EXACT LAST-FOLD rung before the candidate is
     refused (the same fallback as in the cube ladder, mbeParameterSubtractionCube.m; certificate required; records
     lastfold_<id>.m in the job directory; $mfhNoLastFold disables) *)
  lastFoldValues = <||>;
  If[uncertified =!= {} && !TrueQ[Global`$mfhNoLastFold],
    Module[{lf, lfs},
      If[DownValues[MBExactLastFold`mbeExactLastFold] === {} && FileExistsQ[FileNameJoin[{$here, "mbeExactLastFoldRung.m"}]],
        Quiet@Get[FileNameJoin[{$here, "mbeExactLastFoldRung.m"}]]];
      If[DownValues[MBExactLastFold`mbeExactLastFold] =!= {},
        (* release R3.1 (4 October 2026): in parallel on subkernels (MBParameterSubtraction`Private`psLastFoldMany), the
           same rung call per job as the serial loop before *)
        lfs = MBParameterSubtraction`Private`psLastFoldMany[dir, uncertified, MBParameterSubtraction`Private`psLastFoldEngine[], 1200, 2400];
        Do[lf = Lookup[lfs, fid, $Failed];
          If[AssociationQ[lf] && lf["Status"] === "LASTFOLD_DONE" && MBParameter`Private`exactQ[lf["Value"] /. reverseRules, pars],
            AssociateTo[lastFoldValues, fid -> lf["Value"]];
            AppendTo[MBParameter`Private`$trace, <|"Class" -> "ExactLastFoldRung", "Job" -> fid, "Directory" -> dir, "Record" -> lf["RecordFile"], "ValueAt" -> lf["ValueAt"]|>]],
          {fid, uncertified}]]]];
  If[!SubsetQ[Keys[lastFoldValues], uncertified],
    Return[refuse["Finite coefficient integrals not all certified" <> If[TrueQ[audit], " and root-audited", ""],
    <|"Directory" -> dir, "Failed" -> Complement[uncertified, Keys[lastFoldValues]], "Audit" -> Lookup[result, "audit", <||>]|>], Module]];
  values = direct;
  responses = Association[(ToString[#["id"]] -> Lookup[#, "response", <||>]) & /@ result["records"]];
  Do[id = row["id"]; AssociateTo[values, id -> cn[id] (If[KeyExistsQ[lastFoldValues, ToString[id]], lastFoldValues[ToString[id]],
      MBParameterSubtraction`Private`parseNativeStrict[responses[ToString[id]]]] /. reverseRules)], {row, rows}];
  If[!AllTrue[Values[values], MBParameter`Private`exactQ[#, pars] &], Return[refuse["Native output failed the exact contract"], Module]];
  <|"Values" -> values, "Directory" -> dir, "Audit" -> result["audit"]|>];

cubeCandidate[term_, i_, ep_, lo_, hi_, pars_, root_, cache_, cand_] := Module[{sectors, total = 0, dir, prep, int, fold, log = {}},
  fold = Length[term[[2, 2]]];
  sectors = If[cand["Corners"] === 0, {{cand["Cube"], cand["Variables"]}},
    Block[{Global`$fcuBlowUp = True, Global`$fcuMaxSectors = 64, Global`$fcuTrace = {}, Global`fcuSplitPowers},
      Global`fcuSplitPowers[ex_, vs_] := Module[{n = Global`psuNormalizeCube[ex, vs, ep, pars]},
        If[AssociationQ[n] && KeyExistsQ[n, "Expression"], n["Expression"], Global`fcu$fail["parameter sector normalization refused"]]];
      Catch[TimeConstrained[Global`fcuBlowUp[cand["Cube"], cand["Variables"], ep, False], $PSHBlowUpSeconds, $Aborted], Global`fcu$tag]]];
  If[!ListQ[sectors], Return[refuse["Sector decomposition refused", <|"Residue" -> i|>], Module]];
  Do[dir = FileNameJoin[{root, "residue_" <> ToString[i] <> "_sector_" <> ToString[s]}];
    If[!DirectoryQ[dir], CreateDirectory[dir, CreateIntermediateDirectories -> True]];
    prep = TimeConstrained[prepareV[Join[cand, <|"Cube" -> sectors[[s, 1]], "Variables" -> sectors[[s, 2]]|>], ep, lo, hi, pars], $PSHPrepareSeconds, $Aborted];
    If[!AssociationQ[prep] || FailureQ[prep], Return[refuse["Sector preparation refused", <|"Residue" -> i, "Sector" -> s, "Detail" -> prep|>], Module]];
    (* release R3.1 (4 October 2026): a single-sector candidate whose jobs are exactly those of a plain cube candidate of
       this residue that was integrated and refused (same integrands, variables and cube orders; same native limit) is
       not integrated again -- for at most three folds candidateSearch starts from the plain candidates, and a
       corner-free one is the same cube (MB11u term 17: five candidates repeated job for job, about 50 min) *)
    If[Length[sectors] === 1 && ListQ[$PSHRefusedJobSets] &&
        MemberQ[$PSHRefusedJobSets, MBParameterSubtraction`Private`psJobSetKey[prep["Jobs"]]],
      Return[refuse["Same jobs as a refused plain cube candidate", <|"Residue" -> i, "Sector" -> s|>], Module]];
    Put[prep, FileNameJoin[{dir, "prepared.m"}]];
    int = integrateJobs[prep["Jobs"], pars, dir, fold >= $PSHAuditMinFold, cache];
    If[FailureQ[int], Return[int, Module]];
    total += MBParameterSubtraction`PSAssembleCube[prep, int["Values"], ep, lo, hi];
    AppendTo[log, <|"Sector" -> s, "Jobs" -> Length[prep["Jobs"]], "Directory" -> dir, "Audit" -> int["Audit"]|>], {s, Length[sectors]}];
  AppendTo[$PSHTrace, <|"Residue" -> i, "Class" -> "PositiveFaithfulCube", "Folds" -> fold, "Candidate" -> KeyTake[cand, {"Order", "Plan", "Corners"}],
    "Dimensions" -> Length[cand["Variables"]], "Sectors" -> log|>];
  total];

(* A new candidate replaces the whole residue, including successful sectors
   of a previously failed candidate. Never mix partial decompositions. *)
cubeResidue[term_, i_, ep_, lo_, hi_, pars_, root_, cache_] := Module[{cands, answer, trials={}, dir},
  cands=candidateSearch[term,ep,pars];If[FailureQ[cands],Return[cands,Module]];
  Do[If[AbsoluteTime[]>=$PSHDeadline,Return[refuse["Residue deadline exhausted",<|"Residue"->i,"Trials"->trials|>],Module]];
    dir=FileNameJoin[{root,"candidate_"<>ToString[j]}];
    answer=cubeCandidate[term,i,ep,lo,hi,pars,dir,cache,cands[[j]]];
    If[!FailureQ[answer]&&MBParameter`Private`exactQ[answer,Append[pars,ep]],Return[answer,Module]];
    AppendTo[trials,<|"Candidate"->j,"Result"->answer|>],{j,Length[cands]}];
  refuse["No complete faithful candidate",<|"Residue"->i,"Trials"->trials|>]];

(* The public ladder delegates one resolved residue, preserving its census,
   earlier coefficients, and remaining wall-time budget. Native divergence
   checks remain enabled. No research finite-part override is used. *)
PSHResidue[term_, i_, ep_Symbol, lo_Integer, hi_Integer, pars_List, seconds_, cache_] := Module[
 {root, answer, normalized=term},
 root=If[StringQ[MBParameterSubtraction`$PSNativeDirectory],
   FileNameJoin[{MBParameterSubtraction`$PSNativeDirectory,"high_fold"}],CreateDirectory[]];
 If[!DirectoryQ[root],CreateDirectory[root,CreateIntermediateDirectories->True]];
 If[gammaInSumQ[term[[1]]],With[{n=normalizeResidue[term[[1]],ep]},
   If[FailureQ[n],Return[n,Module]];normalized={n,term[[2]]}]];
 answer=Block[{$PSHDeadline=AbsoluteTime[]+seconds,$PSHAdaptiveSeconds=Min[120,seconds],$PSHBlowUpSeconds=Min[120,seconds],
   $PSHPrepareSeconds=Min[120,seconds],$PSHNativeSeconds=Min[60,seconds],$PSHAuditMinFold=0,$PSHTrace={}},
   TimeConstrained[cubeResidue[normalized,i,ep,lo,hi,pars,root,cache],seconds,
     refuse["High-fold residue time limit",<|"Residue"->i,"Directory"->root|>]]];
 If[!FailureQ[answer]&&!MBParameter`Private`exactQ[answer,Append[pars,ep]],
   refuse["High-fold residue exactness contract",<|"Residue"->i|>],answer]];

(* ---- 6. exact collection and structural guard ---- *)
atomQ[x_] := MatchQ[x, _PolyLogTools`G | _Global`G | _HPL`HPL | _PolyLog | _Log | _Zeta | Pi | EulerGamma];
collectOne[e0_] := Module[{e = Expand[e0], atoms, syms},
  atoms = Union[Cases[e, _?atomQ, {0, Infinity}]]; atoms = Select[atoms, FreeQ[#, Alternatives @@ DeleteCases[atoms, #]] &];
  If[atoms === {}, Return[Together[e], Module]];
  syms = Table[Unique["pshAtom"], {Length[atoms]}];
  Total[(Together[#[[2]]] Times @@ (syms^#[[1]])) & /@ CoefficientRules[Expand[e /. Thread[atoms -> syms]], syms]] /. Thread[syms -> atoms]];
structureQ[e_] := FreeQ[e /. HPL`HPL[_List, x_] :> HPL`HPL[idx, x], _List | $Failed | $Aborted | _Real];

PSHExpand[f_, ep_Symbol, c_Association, lo_Integer, hi_Integer, seconds_, cache_] := Catch[Module[
  {pars = c["Parameters"], dom = c["Assumptions"], red, ans, resolved, term, values = {}, tor, root, co},
  If[Head[f] === Plus,
    Return[Total[Table[With[{r = PSHExpand[t, ep, Join[c, <|"Variables" -> Complement[MBParameter`Private`symbols[Cases[t, Gamma[a_] :> a, Infinity]], Append[pars, ep]]|>], lo, hi, seconds, cache]},
      If[FailureQ[r], Throw[r, pshTag], r]], {t, List @@ f}]], Module]];
  red = MBParameter`MBParameterReduce[f, ep, "ExternalParameters" -> pars, "ParameterAssumptions" -> dom, "MBVariables" -> c["Variables"], "ParameterTimeConstraint" -> 45];
  If[AssociationQ[red], ans = MBParameterSubtraction`PSExactReducedSeries[red["Expression"], ep, lo, hi, pars];
    If[!FailureQ[ans] && MBParameter`Private`exactQ[ans, Append[pars, ep]], Return[ans, Module]]];
  resolved = MBParameter`Private`parameterResolve[f, ep, 180];
  If[!ListQ[resolved], Throw[refuse["Fresh contour resolution failed", <|"Details" -> resolved|>], pshTag]];
  root = If[StringQ[MBParameterSubtraction`$PSNativeDirectory], MBParameterSubtraction`$PSNativeDirectory, CreateDirectory[]];
  $PSHTrace = {};
  Do[term = resolved[[i]];
    If[gammaInSumQ[term[[1]]], With[{n = normalizeResidue[term[[1]], ep]}, If[FailureQ[n], Throw[n, pshTag]]; term = {n, term[[2]]}]];
    Which[
      term[[2, 2]] === {},
        ans = MBParameterSubtraction`PSGammaSeries[term[[1]], ep, hi]; If[FailureQ[ans], Throw[ans, pshTag]];
        AppendTo[values, Normal[ans]]; AppendTo[$PSHTrace, <|"Residue" -> i, "Class" -> "ZeroFoldGammaBell"|>],
      Length[term[[2, 2]]] === 1 && AssociationQ[tor = MBParameterSubtraction`Private`towerTerm[term, ep, lo, hi, pars, seconds, cache]] &&
          MBParameter`Private`exactQ[tor["Expression"], Append[pars, ep]],
        AppendTo[values, tor["Expression"]]; AppendTo[$PSHTrace, <|"Residue" -> i, "Class" -> "ExternalFactorExactTower"|>],
      Length[term[[2, 2]]] === 1 && !FailureQ[ans = scaledTower[term, ep, lo, hi, pars, dom, 900]],
        AppendTo[values, ans]; AppendTo[$PSHTrace, <|"Residue" -> i, "Class" -> "ScaledTowerDampingVariable"|>],
      True,
        ans = cubeResidue[term, i, ep, lo, hi, pars, root, cache]; If[FailureQ[ans], Throw[ans, pshTag]]; AppendTo[values, ans]],
    {i, Length[resolved]}];
  co = Table[collectOne[Coefficient[Expand[Total[values]], ep, k]], {k, lo, hi}];
  If[!AllTrue[co, structureQ], Throw[refuse["Structural guard"], pshTag]];
  Total[MapThread[#1 ep^#2 &, {co, Range[lo, hi]}]]], pshTag];
End[];
EndPackage[];
Print["[mbeParameterSubtractionHighFold] high-fold parameter Subtraction ladder (resolved-residue adapter wired into public dispatch)."];
