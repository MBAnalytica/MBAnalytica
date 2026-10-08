(* uint_altint.m (2026-09-26): exact int_0^1 f(x) dx of an INTEGRABLE integrand built from rational functions of x,
   Log and PolyLog at the arguments x, 1-x, 1+x, -x, 1/x, -1/x, 1+1/x (the alphabet {0, 1, -1}).
   1. Log/PolyLog -> HPL (explicit log splitting on the positive half-line, no branch ambiguity for 0<x<1),
      HPLConvertToSimplerArgument for -x, 1-x, -1/x, 1/x;  HPL -> G with letters in {0, 1, -1}.
   2. Primitive by PolyLogTools`GIntegrate; derivative certificate (shuffle-reduced DG[P] - f == 0).
   3. Endpoints: x = 1 shuffle-regularized, every regulator coefficient (words 1..1 at 1) must vanish (numerically,
      Ginsh via gsafe); x = 0: G(w;0) = 0 for every non-empty word; the coefficient of every power of Log[x] of the
      complete primitive's small-x form must vanish (checked numerically at two small points).  For an integrable
      integrand the regularized limits are the ordinary limits (equivalence theorem of the subtraction note).
   4. Gate (never a producer): NIntegrate of the ORIGINAL f (native Log/PolyLog) against the exact value.
   Returns the exact value or $Failed (reason in $altIntLastFailure). *)
altFail[why_,detail_:None]:=(Global`$altIntLastFailure=<|"Reason"->why,"Detail"->detail|>;Throw[$Failed,altTag]);
(* inversion on the negative axis (no cut crossed for x > 0):
   Li_n(-1/x) = (-1)^n [ -Log[x]^n/n! - 2 Sum_{k=1}^{Floor[n/2]} Log[x]^(n-2k)/(n-2k)! Li_2k(-1) - Li_n(-x) ] *)
altInversion[n_Integer,x_]:=(-1)^n (-Log[x]^n/n!+2 Sum[Log[x]^(n-2k)/(n-2k)! PolyLog[2k,-1],{k,1,Floor[n/2]}]-PolyLog[n,-x]);
(* Li_n(1/x), 0<x<1, is on the cut: Mathematica returns the value below the cut; the HPL continuation gives the value
   above it; for real x the two are complex conjugates and every imaginary part of the converted form is explicit *)
altInverseCut[n_Integer,x_]:=Module[{h=Block[{HPL`$HPLAutoConvertToSimplerArgument=False},HPL`HPLConvertToSimplerArgument[HPL`HPL[{n},1/x]]]},
  h/.Complex[a_,b_]:>Complex[a,-b]];
(* Log of a rational function of x with no zero/pole inside (0,1): split over the factors x, 1+x, 1-x and constants,
   principal branch (Log of a negative value = Log|.| + I Pi), as used by the tower rung's numeric gate *)
altSplitLog[z_,x_]:=Module[{t=Together[z],fl,out=0,sgn=1,c},
  fl=Join[FactorList[Numerator[t]],{#[[1]],-#[[2]]}&/@FactorList[Denominator[t]]];
  Do[Module[{f=Expand[fk[[1]]],k=fk[[2]]},
      Which[
        FreeQ[f,x],If[TrueQ[f<0],sgn*=(-1)^k;out+=k Log[-f],out+=k Log[f]],
        f===x,out+=k Log[x],
        f===1+x,out+=k Log[1+x],
        f===1-x,out+=k Log[1-x],
        f===-x,sgn*=(-1)^k;out+=k Log[x],
        f===-1-x,sgn*=(-1)^k;out+=k Log[1+x],
        f===-1+x,sgn*=(-1)^k;out+=k Log[1-x],
        True,altFail["logarithm of an unsupported factor",f]]],{fk,fl}];
  If[sgn===-1,out+I Pi,out]];
altOnePlus[n_Integer,x_]:=Module[{yy,h},
  h=Block[{HPL`$HPLAutoConvertToSimplerArgument=False},HPL`HPLConvertToSimplerArgument[HPL`HPL[{n},1-yy]]];
  h=h/.HPL`HPL[w_List,yy]:>HPL`HPL[w,-x];   (* H(w;y) at y = -x: continuation through the upper half plane *)
  h];
altPullbackMobius[w_List,x_]:=Module[{maps},
  maps=Table[Switch[a,0,{{1,0},{-1,-1}},1,{{-1,-1}},_,altFail["letter outside {0,1} at x/(1+x)",a]],{a,w}];
  Total[Map[Function[choice,(Times@@(First/@choice)) PolyLogTools`G[Sequence@@(Last/@choice),x]],Tuples[maps]]]];
altToHPL[e_,x_]:=Module[{r},
  r=e/.{PolyLog[n_Integer,z_]/;TrueQ[Together[z+1/x]===0]:>altInversion[n,x]};
  (* Li_n(1+x), 0<x<1, on Mathematica's branch (limit from below the cut): as HPL[{n},1-y] continued to y = -x + i0 *)
  r=r/.{PolyLog[n_Integer,z_]/;TrueQ[Together[z-1-x]===0]:>altOnePlus[n,x]};
  r=r/.{PolyLog[n_Integer,z_]/;TrueQ[Together[z-1/x]===0]:>altInverseCut[n,x]};
  (* any other argument z(x) > 1 on (0,1): Mathematica's value below the cut,
     Li_n(z) = -(-1)^n Li_n(1/z) - (2 Pi I)^n/n! BernoulliB[n, 1 + Log[z]/(2 Pi I)] *)
  r=r/.{PolyLog[n_Integer,z_]/;!FreeQ[z,x]&&AllTrue[{1/7,1/3,2/3,6/7},TrueQ[N[z/.x->#]>1]&]:>
      (-(-1)^n PolyLog[n,Together[1/z]]-(2 Pi I)^n/n! BernoulliB[n,1+Log[z]/(2 Pi I)])};
  r=r/.PolyLog[m_Integer,-1]:>-(1-2^(1-m))Zeta[m];
  r=r/.Log[z_]/;!FreeQ[z,x]&&!MemberQ[{x,1+x,1-x},z]:>altSplitLog[z,x];
  r=r/.{Log[x]->HPL`HPL[{0},x],Log[1-x]->-HPL`HPL[{1},x],Log[1+x]->HPL`HPL[{-1},x],
        Log[1/x]->-HPL`HPL[{0},x],Log[x^-1]->-HPL`HPL[{0},x],Log[1+1/x]->HPL`HPL[{-1},x]-HPL`HPL[{0},x],
        Log[(1+x)/x]->HPL`HPL[{-1},x]-HPL`HPL[{0},x],Log[1+x^-1]->HPL`HPL[{-1},x]-HPL`HPL[{0},x]};
  r=r/.{PolyLog[n_Integer,z_]/;!FreeQ[z,x]:>HPL`HPL[{n},z],PolyLog[n_Integer,p_Integer,z_]/;!FreeQ[z,x]:>HPL`HPL[Join[{n+1},ConstantArray[1,p-1]],z]};
  If[!FreeQ[r,Log[a_]/;!FreeQ[a,x]],altFail["unsupported logarithm",Cases[r,Log[a_]/;!FreeQ[a,x],Infinity]]];
  r];
altIntegrate[f_,x_,gsafeF_,opts___]:=Catch[Block[
  {HPL`$HPLAutoConvertToKnownFunctions=False,HPL`$HPLAutoReduceToMinimalSet=False,HPL`$HPLAutoProductExpand=False,
   HPL`$HPLAutoLogExtract=False,HPL`$HPLAutoConvertToSimplerArgument=False},
  Module[{hh,gg,letters,prim,dres,up,regs,low,lowLog,val,numv,exact,checkPts},
  Global`$altIntLastFailure=None;
  If[f===0,Return[0,Module]];
  hh=altToHPL[Expand[f],x];
  hh=HPL`HPLConvertToSimplerArgument[hh];
  (* HPLs at x/(1+x) (not reduced by the package): pass to G at x/(1+x), then the exact pullback below *)
  hh=hh/.h:HPL`HPL[_,z_]/;TrueQ[Together[z-x/(1+x)]===0]:>Global`altAtMobius[PolyLogTools`HPLToG[h/.z->Global`altYY]];
  If[!FreeQ[hh,HPL`HPL[_,z_]/;!FreeQ[z,x]&&z=!=x],altFail["HPL arguments not reduced to x",Cases[hh,HPL`HPL[_,z_]/;!FreeQ[z,x]&&z=!=x,Infinity]]];
  gg=Expand[PolyLogTools`HPLToG[hh]];
  (* pullback of G words at y = x/(1+x) (base point 0 -> 0, exact for every word incl. trailing zeros):
     dy/y = dx/x - dx/(1+x)  (letter 0 -> [0] - [-1]);   dy/(y-1) = -dx/(1+x)  (letter 1 -> -[-1]) *)
  gg=Expand[gg/.Global`altAtMobius[e_]:>Expand[e/.g_PolyLogTools`G/;Last[g]===Global`altYY:>altPullbackMobius[Most[List@@g],x]]];
  letters=Union[Flatten[Cases[gg,g_PolyLogTools`G/;!FreeQ[g,x]:>Most[List@@g],{0,Infinity}]]];
  (* conversion gate: the G form must equal the original integrand pointwise (native Log/PolyLog vs Ginsh) *)
  Do[Module[{a=Quiet@N[f/.x->pt,30],b=gsafeF[gg/.x->pt]},
      If[!(NumericQ[a]&&NumericQ[b]&&Abs[a-b]<10^-15 (1+Abs[a])),altFail["conversion gate at x = "<>ToString[pt],{a,b}]]],{pt,{1/3,5/7}}];
  If[!SubsetQ[{0,1,-1},letters],altFail["letters outside {0,1,-1}",letters]];
  prim=TimeConstrained[PolyLogTools`GIntegrate[gg,x],900,$Failed];
  If[!FreeQ[prim,$Failed|$Aborted|PolyLogTools`GIntegrate|_Integrate],altFail["no primitive",prim]];
  dres=TimeConstrained[PolyLogTools`GCoefficientSimplify[Expand[PolyLogTools`ShuffleG[PolyLogTools`DG[prim,x]-gg]]],600,$Failed];
  If[!TrueQ[dres===0],
    (* numeric fallback for the derivative certificate at two interior points *)
    checkPts={2/7,5/9};
    If[!AllTrue[checkPts,Abs[gsafeF[dres/.x->#]]<10^-20&],altFail["primitive derivative check failed",dres]]];
  (* x = 1 *)
  up=PolyLogTools`ShuffleRegulate[prim/.x->1];
  up=up/.PolyLogTools`G[o__,1]/;MatchQ[{o},{1..}]:>Global`altReg^Length[{o}]/Length[{o}]!;
  regs=Table[Coefficient[Expand[up],Global`altReg,j],{j,1,Max[1,Exponent[up,Global`altReg]]}];
  If[!AllTrue[regs,Abs[gsafeF[#]]<10^-18&],altFail["regulator does not cancel at x = 1",regs]];
  up=Expand[up/.Global`altReg->0];
  If[!FreeQ[up,ComplexInfinity|Indeterminate|DirectedInfinity],altFail["pole at x = 1 in the primitive's coefficients"]];
  (* x = 0: non-zero words vanish; all-zero words are powers of Log[x]/n!; the complete coefficient of every positive
     power must vanish and no rational pole may survive *)
  low=prim/.g_PolyLogTools`G/;Last[g]===x&&!MatchQ[Most[List@@g],{0..}]:>0;
  low=low/.g_PolyLogTools`G/;Last[g]===x&&MatchQ[Most[List@@g],{0..}]:>Global`altL^(Length[g]-1)/(Length[g]-1)!;
  low=Together/@Collect[Expand[low],Global`altL];
  lowLog=Table[Coefficient[low,Global`altL,j],{j,1,Max[1,Exponent[low,Global`altL]]}];
  If[!AllTrue[lowLog,TrueQ[Simplify[#/.x->0]==0]||TrueQ[Limit[#,x->0]==0]&],altFail["logarithms do not cancel at x = 0",lowLog]];
  low=Coefficient[low,Global`altL,0];
  low=Quiet@Limit[low,x->0];
  If[!FreeQ[low,ComplexInfinity|Indeterminate|DirectedInfinity|Limit],altFail["no finite limit at x = 0",low]];
  exact=Global`mbeCanonicalConstants[up-low];
  (* gate: native quadrature of the original integrand *)
  numv=Quiet@NIntegrate[f,{x,0,1},WorkingPrecision->30,PrecisionGoal->14,MaxRecursion->40,Method->"DoubleExponential"];
  If[!(NumericQ[numv]&&Abs[gsafeF[exact]-numv]<10^-9 (1+Abs[numv])),altFail["quadrature gate",{N[numv,15],N[gsafeF[exact],15]}]];
  exact]],altTag];
Print["[uint_altint] exact integrals on (0,1) over the alphabet {0,1,-1} with derivative, regulator, zero-endpoint and quadrature gates."];
