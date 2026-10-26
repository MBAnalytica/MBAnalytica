(* Finite-regulator, source-derived multifold reductions. No target names or values.
   Strict subclass: fixed pole-free product contour, certified exponential decay,
   positive external scales, separating unit-slope Barnes kernels. No contour move.
   A reduced representation is NOT a evaluated Laurent coefficient. *)
ClearAll[mfrReduce, mfrDecayCertificate, mfrStep, mfrLegs, mfrAffineQ,
 mfrFactors, mfrPositiveQ, mfrSameContourCensus, mfrResidueLaurent, mfrResidueZero];
mfrFactors[f_] := If[Head[f] === Times, List @@ f, {f}];
mfrAffineQ[f_, vs_] := PolynomialQ[f, vs] &&
 AllTrue[CoefficientRules[f, vs], Total[First[#]] <= 1 && MatchQ[Last[#], _Integer | _Rational] &];
(* Parse factors, never recursively count Gamma underneath a denominator. *)
mfrLegs[f_] := Module[{legs = {}, rest = 1},
 Do[Which[Head[t] === Gamma, AppendTo[legs, {Expand[t[[1]]], 1}],
   MatchQ[t, Power[_Gamma, _Integer]], AppendTo[legs, {Expand[t[[1, 1]]], t[[2]]}],
   True, rest *= t], {t, mfrFactors[f]}]; <|"Legs" -> legs, "Rest" -> rest|>];
mfrPositiveQ[f_, dom_] := TrueQ[TimeConstrained[FullSimplify[f > 0, Assumptions -> dom], 3, False]];

(* A stable contour integral is holomorphic after its complete scalar
   prefactor is removed. A prefactor vanishing beyond the requested order
   therefore needs no Euler inversion. This is a proved zero, not a timeout. *)
mfrResidueZero[f_, ctr_List, ep_Symbol, hi_Integer, dom_:True] := Module[
 {vs=First/@ctr, factors=mfrFactors[f], pref, bare, cert, ser, valuation, unit=1},
 If[vs==={},Return[Failure["MultifoldDepth",<|"Reason"->"No contour"|>]]];
 pref=Times@@Select[factors,FreeQ[#,Alternatives@@vs]&];
 bare=Times@@Select[factors,!FreeQ[#,Alternatives@@vs]&];
 cert=mfrDecayCertificate[bare,ctr,ep,dom];If[FailureQ[cert],Return[cert]];
 ser=TimeConstrained[Series[pref,{ep,0,Max[0,hi]}],15,$Failed];
 If[Head[ser]=!=SeriesData,
   unit=Exp[ep];
   ser=TimeConstrained[Quiet@Check[Series[unit pref,{ep,0,Max[0,hi]}],$Failed],15,$Failed]];
 (* Exp[ep] is a holomorphic unit and preserves the prefactor valuation. *)
 valuation=If[Head[ser]===SeriesData,If[ser[[3]]==={},ser[[5]],ser[[4]]]/ser[[6]],-Infinity];
 If[!TrueQ[valuation>hi],
   Return[Failure["MultifoldDepth",<|"Reason"->"Prefactor contributes at requested order"|>]]];
 <|"Expression"->0,"Class"->"CertifiedRegulatedDepthZero","Source"->f,
   "Contour"->ctr,"Prefactor"->pref,"ValuationUnit"->unit,"ValuationSeries"->ser,
   "ValuationLowerBound"->valuation,
   "RequestedMaximum"->hi,"Certificate"->cert|>];

mfrDecayCertificate[f_, ctr_List, ep_Symbol, dom_:True] := Catch[Module[
 {vs = First /@ ctr, parse, legs, rest, radius = 1/100, rows = {}, q, c, s, dist,
  vec, lead, key, groups, weights, surviving, scaleOK = True, polynomial = 1},
 If[!DuplicateFreeQ[Append[vs, ep]] || !AllTrue[vs, MatchQ[#, _Symbol] &] ||
   !AllTrue[Last /@ ctr, MatchQ[#, _Integer | _Rational] &],
   Throw[Failure["MultifoldDomain", <|"Reason" -> "Exact distinct contour variables required"|>]]];
 If[!FreeQ[f, _Real | Indeterminate | ComplexInfinity],
   Throw[Failure["MultifoldDomain", <|"Reason" -> "Inexact or singular source"|>]]];
 parse = mfrLegs[f]; legs = parse["Legs"]; rest = parse["Rest"];
 Do[If[FreeQ[t, Alternatives @@ vs], Continue[]];
   If[MatchQ[t, Power[_, _]] && FreeQ[t[[1]], Alternatives @@ Append[vs, ep]] &&
       mfrAffineQ[t[[2]], Append[vs, ep]] && mfrPositiveQ[t[[1]], dom], Continue[]];
   polynomial *= t, {t, mfrFactors[rest]}];
 If[!PolynomialQ[polynomial, vs], Throw[Failure["MultifoldDecay", <|"Reason" -> "Nonpolynomial dressing or unproved positive scale"|>]]];
 Do[If[FreeQ[l[[1]], Alternatives @@ vs], Continue[]];
   If[!mfrAffineQ[l[[1]], Append[vs, ep]], Throw[Failure["MultifoldDomain", <|"Reason" -> "Non-affine Gamma argument"|>]]];
   q = Expand[l[[1]] /. ctr]; c = q /. ep -> 0; s = Coefficient[q, ep];
   If[l[[2]] > 0,
     dist = If[c > 0, c, Min[Abs[c - Floor[c]], Abs[c - Ceiling[c]]]];
     If[dist === 0, Throw[Failure["MultifoldContour", <|"Reason" -> "Numerator pole on contour at zero regulator", "Leg" -> l[[1]]|>]]];
     If[s =!= 0, radius = Min[radius, dist/(2 Abs[s])]]];
   vec = Coefficient[l[[1]], #] & /@ vs; lead = SelectFirst[vec, # =!= 0 &];
   key = vec/lead; AppendTo[rows, {key, l[[2]] Abs[lead]}], {l, legs}];
 groups = GatherBy[rows, First];
 weights = {#[[1, 1]], Total[#[[All, 2]]]} & /@ groups;
 If[AnyTrue[weights, Last[#] < 0 &],
   Throw[Failure["MultifoldDecay", <|"Reason" -> "Simple absolute-slope cancellation cannot prove decay", "Weights" -> weights|>]]];
 surviving = First /@ Select[weights, Last[#] > 0 &];
 If[vs =!= {} && (surviving === {} || MatrixRank[surviving] =!= Length[vs]),
   Throw[Failure["MultifoldDecay", <|"Reason" -> "Remaining exponential forms do not span every contour direction"|>]]];
 <|"Certified" -> True, "Radius" -> radius, "Weights" -> weights,
   "Rank" -> Length[vs], "Contour" -> ctr, "Domain" -> dom,
   "SourceHash" -> Hash[{f, ctr, ep, dom}, "SHA256"],
   "Proof" -> "Stirling: nonnegative absolute-slope sum with spanning positive forms; fixed pole-free contours"|>
]];

mfrStep[f_, ctr_List, ep_, radius_, kinds_List] := Module[
 {vs = First /@ ctr, parse, active, up, down, den, rest, p, a, b, c, d, ee, ff, ss,
  form, check, mins, offset, orient, out},
 parse = mfrLegs[f];
 Do[active = Select[parse["Legs"], !FreeQ[#[[1]], v] &];
   If[active === {} || !AllTrue[active, Abs[Coefficient[#[[1]], v]] === 1 &], Continue[]];
   rest = Cancel[f/(Times @@ (Gamma[#[[1]]]^#[[2]] & /@ active))];
   If[!FreeQ[rest, v], Continue[]];
   mins = Flatten[Table[(#[[1]] /. ctr /. ep -> e0) & /@ Select[active, Last[#] > 0 &], {e0, {-radius, radius}}]];
   If[mins === {} || !AllTrue[mins, TrueQ[# > 0] &], Continue[]];
   up = Flatten[ConstantArray[First[#] /. v -> 0, Last[#]] & /@ Select[active, Last[#] > 0 && Coefficient[First[#], v] === 1 &]];
   down = Flatten[ConstantArray[First[#] /. v -> 0, Last[#]] & /@ Select[active, Last[#] > 0 && Coefficient[First[#], v] === -1 &]];
   den = Select[active, Last[#] < 0 &];
   If[MemberQ[kinds, "BarnesI"] && Length[up] === 2 && Length[down] === 2 && den === {},
     out = rest Times @@ Flatten[Outer[Gamma[#1 + #2] &, up, down]]/Gamma[Total[up] + Total[down]];
     Return[<|"Expression" -> out, "Variable" -> v, "Contour" -> DeleteCases[ctr, v -> _],
       "Class" -> "BarnesI", "Kernel" -> f/rest, "Rest" -> rest, "Margins" -> mins, "Crossings" -> {}|>, Module]];
   If[!MemberQ[kinds, "FiveGamma"] || Length[den] =!= 1 || den[[1, 2]] =!= -1, Continue[]];
   orient = Coefficient[den[[1, 1]], v];
   {p, offset} = If[orient === 1, {up, down}, {down, up}];
   If[Length[p] =!= 3 || Length[offset] =!= 2, Continue[]];
   ff = Expand[den[[1, 1]] /. v -> 0];
   Do[c = p[[j]]; {a, b} = Delete[p, j]; {d, ee} = offset;
     check = Flatten[Table[Expand /@ {ff-c,c+d,c+ee} /. ctr /. ep -> e0, {e0, {-radius, radius}}]];
     If[!AllTrue[check, TrueQ[# > 0] &], Continue[]];
     ss = Expand[a+b+d+ee];
     form = Gamma[a+d]Gamma[a+ee]Gamma[b+d]Gamma[b+ee]Gamma[c+ee]/(Gamma[ss]Gamma[ff+ee]) *
       HypergeometricPFQ[{a+ee,b+ee,ff-c},{ss,ff+ee},1];
     Return[<|"Expression" -> rest form, "Variable" -> v, "Contour" -> DeleteCases[ctr, v -> _],
       "Class" -> "FiveGamma", "Kernel" -> f/rest, "Rest" -> rest,
       "Margins" -> Join[mins, check], "Crossings" -> {}, "Excess" -> Expand[c+d]|>, Module], {j,3}],
 {v,vs}]; Failure["MultifoldPattern", <|"Reason" -> "No admitted separating fold in this representation"|>]];

Options[mfrReduce] = {"Assumptions" -> True, "Moves" -> {"BarnesI", "FiveGamma"}, "Seconds" -> 30};
mfrReduce[f_, ctr_List, ep_Symbol, OptionsPattern[]] := Module[
 {cert, current = f, line = ctr, steps = {}, trial, started = AbsoluteTime[], kinds = OptionValue["Moves"]},
 cert = mfrDecayCertificate[f, ctr, ep, OptionValue["Assumptions"]];
 If[FailureQ[cert], Return[cert, Module]];
 While[line =!= {} && AbsoluteTime[]-started < OptionValue["Seconds"],
   trial = TimeConstrained[mfrStep[current, line, ep, cert["Radius"], {"BarnesI"}~Intersection~kinds],
     Max[.1, OptionValue["Seconds"]-(AbsoluteTime[]-started)], $Failed];
   If[!AssociationQ[trial] && MemberQ[kinds,"FiveGamma"],
     trial = TimeConstrained[mfrStep[current, line, ep, cert["Radius"], {"FiveGamma"}],
       Max[.1, OptionValue["Seconds"]-(AbsoluteTime[]-started)], $Failed]];
   If[!AssociationQ[trial], Break[]];
   AppendTo[steps, KeyDrop[trial,"Expression"]]; current = trial["Expression"]; line = trial["Contour"]];
 <|"Expression" -> current, "Contour" -> line, "Steps" -> steps, "Certificate" -> cert,
   "Source" -> f, "SourceContour" -> ctr, "Regulator" -> ep, "Reduced" -> (Length[steps]>0),
   "InputFolds" -> Length[ctr], "OutputFolds" -> Length[line],
   "Status" -> If[line === {}, "ClosedRepresentation", "ReducedRepresentation"],
   "CoefficientStatus" -> "NotEvaluated"|>];

(* A conservative census: exact equality after order-preserving variable renaming,
   and the same contour real parts and regulator metadata. No contour-cell guessing. *)
mfrSameContourCensus[terms_List] := Module[{groups, key, slots, output = {}, records = {}, vs, renamed, coeff, core, ratio, representative},
 key[t_] := Module[{v = First /@ t[[2,2]], r, c, g},
   r = t[[1]] /. Thread[v -> Array[mfrAxis, Length[v]]];
   c = Times @@ Select[mfrFactors[r], NumberQ]; g = Cancel[r/c];
   {g, Last /@ t[[2,2]], t[[2,1]]}];
 If[!AllTrue[terms, MatchQ[#[[2]], {_List,_List}] &], Return[terms,Module]];
 groups = GatherBy[Range[Length[terms]], key[terms[[#]]] &];
 Do[representative = terms[[First[g]]]; vs = First /@ representative[[2,2]];
   renamed = Table[terms[[i,1]] /. Thread[(First /@ terms[[i,2,2]]) -> vs], {i,g}];
   core = Factor[Total[renamed]];
   AppendTo[records,<|"Occurrences" -> g, "Cancelled" -> (core === 0)|>];
   If[core =!= 0, AppendTo[output, ReplacePart[representative,1 -> core]]], {g,groups}];
 Global`$mfrLastCensus = records; output];

(* Existing package engines evaluate a smaller pure-Gamma residue. A hypergeometric
   function of spectator MB variables remains a representation, never a scalar. *)
mfrResidueLaurent[term_, ep_, lo_, hi_, verbose_] := Module[{red, reduced, ans, ser},
 If[TrueQ[Global`$mfrActive] || TrueQ[Global`$mfrDisabled], Return[$Failed,Module]];
 red = mfrReduce[term[[1]], term[[2,2]], ep, "Moves" -> {"BarnesI"}];
 Global`$mfrLastRun = red;
 If[!AssociationQ[red] || !TrueQ[red["Reduced"]], Return[$Failed,Module]];
 reduced = ReplacePart[term,{1 -> red["Expression"], {2,2} -> red["Contour"]}];
 ans = Block[{Global`$mfrActive = True}, Which[
   red["Contour"] === {}, ser = Quiet@Series[red["Expression"],{ep,0,hi}];
     Table[Coefficient[Expand[Normal[ser]],ep,k],{k,lo,hi}],
   Length[red["Contour"]] === 1,
     Block[{Global`$oftFamilyCacheKey=None,Global`$oftFamilyCacheValue=$Failed},
       MBAnalytica`SymbolicInt`Private`mbeOneFoldFamilyLaurent[{reduced},ep,lo,hi,verbose]],
   True, Global`oftMultiFoldHandler[reduced,ep,lo,hi,verbose]]];
 If[!ListQ[ans] || Length[ans] =!= hi-lo+1 || !FreeQ[ans, $Failed | $Aborted | _Failure | ep | _Real | _Missing],
   Return[$Failed,Module]]; ans];
Print["[mbeMultifoldFamilyRung] certified finite-regulator Barnes chains; conservative family census; no answer bank."];

(* Two Euler fibers as ONE Gauss difference. Positivity is tested by the existing
   projective coefficient-sign prover. Outer continuation remains an explicit duty. *)
ClearAll[mfrEulerPair];
mfrEulerPair[f_, vars_List, ep_Symbol, pars_List:{}] := Module[
 {powers, p, base, rest, zrest, az, bz, a, b, c, alpha, beta, mu, k0, k1,
  axes, margins, moment, density, radius = 1/100},
 If[DownValues[psuPolynomialSign] === {}, Return[Failure["EulerPair",<|"Reason"->"Positivity prover not loaded"|>],Module]];
 Do[powers = Select[mfrFactors[f], MatchQ[#,Power[_,_]] && !FreeQ[#[[1]],y] &];
   If[Length[powers] =!= 1, Continue[]]; {base,p} = List @@ First[powers];
   If[!PolynomialQ[base,vars] || Exponent[base,y] =!= 1 || !mfrAffineQ[p,{ep}], Continue[]];
   rest = f/base^p; If[!FreeQ[rest,y],Continue[]];
   Do[If[!PolynomialQ[base,z] || Exponent[base,z] =!= 1,Continue[]];
     a = Expand[base /. {y->0,z->0}]; b = Coefficient[base,z]; c = Coefficient[base,y];
     If[!FreeQ[{b,c},y|z],Continue[]];
     az = Total[Cases[mfrFactors[rest],Power[z,q_] :> q]];
     bz = Total[Cases[mfrFactors[rest],Power[bb_,q_] /; Expand[bb-(1-z)]===0 :> q]];
     If[!mfrAffineQ[az,{ep}] || !mfrAffineQ[bz,{ep}],Continue[]];
     zrest = Cancel[rest/(z^az (1-z)^bz)]; If[!FreeQ[zrest,z],Continue[]];
     axes = Join[DeleteCases[vars,y|z],pars];
     If[!AllTrue[{a,b,c},psuPolynomialSign[#,axes]===1&],Continue[]];
     {alpha,beta,mu} = {az+1,bz+1,p+1}; If[mu===0,Continue[]];
     margins = {alpha,beta}/.ep->-radius;
     If[!AllTrue[margins,TrueQ[#>0]&] || !AllTrue[{alpha,beta}/.ep->0,TrueQ[#>=0]&],Continue[]];
     k0 = Expand[a+b]; k1 = Expand[k0+c];
     moment[k_] := k^mu Hypergeometric2F1[-mu,beta,alpha+beta,b/k];
     density = zrest Beta[alpha,beta](moment[k1]-moment[k0])/(mu c);
     Return[<|"Expression"->density,"Variables"->DeleteCases[vars,y|z],"Eliminated"->{y,z},
       "A"->a,"B"->b,"C"->c,"K0"->k0,"K1"->k1,"Power"->p,"BetaParameters"->{alpha,beta},
       "Source"->f,"SourceHash"->Hash[{f,vars,ep,pars},"SHA256"],"Interval"->{-radius,0},
       "GroupedDifference"->True,"Status"->"InnerIdentity",
       "OuterContinuation"->Missing["SourceBoundMajorantRequired"],"CoefficientStatus"->"NotEvaluated"|>,Module],
     {z,DeleteCases[vars,y]}],{y,vars}];
 Failure["EulerPair",<|"Reason"->"No positive affine leaf and beta fiber pair"|>]];
