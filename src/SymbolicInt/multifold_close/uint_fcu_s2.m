(* uint_fcu_s2.m  (2026-09-27) -- SLOPE-TWO CLOSER of the Mellin-space route: slope-two denominator legs for the
   package's faithful-cube rung (mbeFaithfulCubeRung.m, fcuResidueLaurent), and the sixth-root reduction of its values.

   Class.  A stuck term int_c G(z, eps) (stable contour, any number of folds) whose Gamma product has a DENOMINATOR leg
   Gamma(l) of slope +-2 in some Mellin variable.  In this route it is the u-Beta Gamma(A+1)Gamma(B+1)/Gamma(A+B+2) of
   Step 1 whenever A and B share a Mellin variable with the same sign (MB8bu r35/r36, MB8au r24/r43, MB14au r17/r22).
   The rung pairs every denominator with a SAME-slope numerator (its rules S1/S2) and refuses this leg ("no same-slope
   numerator partner"); the Barnes closed forms and the tower ladder need unit slopes.

   Theory (Standard paper, lemma "Pairing rules", rule (C), cross-variable triple, no slope condition):
       Gamma(g1) Gamma(g2) / Gamma(g1 + g2) = Int_0^1 v^(g1-1) (1-v)^(g2-1) dv          (Re g1, Re g2 > 0 on the contour),
   with two NUMERATOR legs g1, g2 whose sum differs from l by an integer n: Gamma(g1+g2)/Gamma(l) = (l)_n (n >= 0,
   polynomial) or 1/(l+n)_(-n) (n < 0, rationals).  A numerator leg of non-positive real part is raised first,
   Gamma(g) = Gamma(g+k)/(g)_k.  The Beta variable v is handed to the rung as INITIAL EULER STRUCTURE (its "dressing"
   slot, the same slot that carries the polygamma representations): the Mellin variables enter only through the
   kinematic powers v^z (1-v)^z, which the per-variable kernel collapse Gamma(a+b) Lam^a (1+Lam)^(-a-b) absorbs, and every
   leg the inversion sees has unit slope.  Everything else (contour regularisation, S1/S2 pairs, merged rationals, the
   master subtraction equation on the faces, the blow-up of compound corners, the per-order pieces on subkernels) is the
   rung's.  The inversion is at finite eps, so the polygamma dressing of the Taylor coefficients never appears (no
   scale cube).  The price is a QUADRATIC letter 1 + v(1-v) X in the cube, whose roots are sixth roots of unity at X = 1:
   the package integrator (IntVolIntegrate, IntVolFLINT hook) integrates such cubes exactly (checked 09-27 against
   NIntegrate on six integrals with the conic letter, weights 2-4, one and two variables), but its VALUE CONTRACT
   (N[] must evaluate the value) refuses G words with complex letters, which only Ginsh evaluates; the contract is
   switched off inside this closer and replaced by the term gates of the caller (quadrature of G and dG/deps).

   Values.  The coefficients carry G(a..;1) with a in {0, +-1, e^(+-i Pi/3), e^(+-2 i Pi/3)}: uintL6Reduce rewrites
   depth-one words of numeric argument as logarithms (bwsL6Reduce refuses G(0;2)) and reduces through the
   Henn-Smirnov-Smirnov tables (weight <= 4; mbeLevel6Reduce.m, MBE_L6_ACCEPT_BASIS=1 keeps the basis constants as exact
   L6`GR/L6`GI symbols).  The family sum is pure MZV (MB8Val), so these constants must cancel there.

   Wraps Global`fcuDress (the rung's hook) only while $fcuS2Beta is True; no package file is edited. *)

If[!TrueQ[Global`$fcuS2Installed],
  If[DownValues[Global`fcuDress]==={},Print["[uint_fcu_s2] faithful-cube rung not loaded -- nothing installed"],
    DownValues[Global`fcuDressOrig]=DownValues[Global`fcuDress]/.HoldPattern[Global`fcuDress]->Global`fcuDressOrig;
    Global`$fcuS2Installed=True]];
If[!ValueQ[Global`$fcuS2Beta],Global`$fcuS2Beta=False];

fcuS2Slope2Q[l_,zs_List]:=AnyTrue[zs,Abs[Coefficient[Expand[l],#]]===2&];
fcuS2Rat[x_]:=Rationalize[x,0];
(* the triple extraction: {fNew, Beta dressing, Beta variables, trace} or None (nothing to extract / no partners) *)
fcuS2Extract[f_,zs_List,ctrAll_,eN_,eps_]:=Catch[Module[{terms0,gp,K,D,cnt=<||>,extraD=1,dfac=1,vars={},tr={},nv=0,guard=0,
    reVal,numArgs,den,cands,best,g1,g2,k1,k2,n,m,v,newK},
  reVal[x_]:=Re[N[x/.ctrAll/.eN,30]];
  terms0=If[Head[f]===Plus,List@@f,{f}];
  gp=Function[t,Times@@Cases[If[Head[t]===Times,List@@t,{t}],Gamma[_]|Power[Gamma[_],_Integer]]];
  K=gp[terms0[[1]]];D=Together[f/K];
  If[!FreeQ[D,Gamma],D=Expand[Together[Total[Table[Cancel[t/K],{t,terms0}]]]]];
  If[!FreeQ[D,Gamma],Throw[None,"s2"]];
  Do[Which[MatchQ[t,Power[Gamma[_],_Integer]],cnt[Expand[t[[1,1]]]]=Lookup[cnt,Expand[t[[1,1]]],0]+t[[2]],
      MatchQ[t,Gamma[_]],cnt[Expand[t[[1]]]]=Lookup[cnt,Expand[t[[1]]],0]+1],{t,If[Head[K]===Times,List@@K,{K}]}];
  (* FIRST cancel same-slope pairs at integer distance (a BALANCED slope-two pair Gamma(b+n)/Gamma(b) is the
     polynomial (b)_n, not a triple): only the remaining slope-two denominators are Beta triples (09-27: with the pair
     left in, the extraction built a second, spurious triple) *)
  Module[{changed=True,g2=0},
    While[changed&&g2++<50,changed=False;
      Do[If[!changed&&Lookup[cnt,a,0]>0&&Lookup[cnt,b,0]<0&&fcuS2Slope2Q[b,zs]&&
            AllTrue[zs,Coefficient[a,#]===Coefficient[b,#]&],
          With[{n=Expand[a-b]},If[IntegerQ[n]&&n=!=0,
            cnt[a]-=1;cnt[b]+=1;
            extraD=extraD If[n>0,Product[b+j,{j,0,n-1}],1/Product[a+j,{j,0,-n-1}]];
            AppendTo[tr,{"s2-pair",a,b,"n"->n}];changed=True]]],{a,Keys[cnt]},{b,Keys[cnt]}]]];
  While[(den=SelectFirst[Keys[cnt],cnt[#]<0&&fcuS2Slope2Q[#,zs]&,None])=!=None,
    If[++guard>12,Throw[None,"s2"]];
    numArgs=Select[Keys[cnt],cnt[#]>0&];
    cands={};
    Do[Module[{a=numArgs[[i]],b=numArgs[[j]],nn,ra,rb,ka,kb,sl,off=0},
        If[i===j&&cnt[a]<2,Continue[]];
        (* the partners of a Beta triple are UNIT-slope legs (|slope| <= 1 in every Mellin variable) *)
        If[!AllTrue[zs,Abs[Coefficient[a,#]]<=1&&Abs[Coefficient[b,#]]<=1&],Continue[]];
        nn=Expand[a+b-den];
        (* 09-27 v6: an EPS-OFFSET partner, a + b - den = n + d with d proportional to eps and free of the Mellin variables
           (a regulator copy on the slope-two leg, psi(L)/Gamma(L) = -d/de 1/Gamma(L+e)): the triple takes b' = b - d,
           Gamma(a) Gamma(b') / Gamma(den) = B(a, b') exactly, and the inner kernel keeps the unit-slope copy ratio
           Gamma(b)/Gamma(b') *)
        If[!(NumericQ[nn]&&IntegerQ[nn]),
          If[FreeQ[nn,Alternatives@@zs]&&!FreeQ[nn,eps]&&IntegerQ[nn/.eps->0]&&PolynomialQ[nn,eps]&&Exponent[nn,eps]===1,
            off=-Expand[nn-(nn/.eps->0)];nn=nn/.eps->0,
            Continue[]]];
        ra=reVal[a];rb=reVal[b+off];
        If[!NumericQ[ra]||!NumericQ[rb],Continue[]];
        ka=If[ra>0,0,Floor[-ra]+1];kb=If[rb>0,0,Floor[-rb]+1];
        If[reVal[a+ka]==0||reVal[b+off+kb]==0,Continue[]];
        (* unit slopes in every slope-two variable of the denominator preferred, then no offset, fewest raises, |n| *)
        sl=Total[Table[If[Abs[Coefficient[den,z]]===2&&!(Abs[Coefficient[a,z]]===1&&Abs[Coefficient[b,z]]===1),1,0],{z,zs}]];
        AppendTo[cands,{{sl,If[off===0,0,1],ka+kb,Abs[nn]},{a,b,ka,kb,nn,off}}]],
      {i,Length[numArgs]},{j,i,Length[numArgs]}];
    If[cands==={},Throw[None,"s2"]];
    best=First[SortBy[cands,First]][[2]];
    {g1,g2,k1,k2,n}=Most[best];
    cnt[g1]-=1;cnt[g2]-=1;cnt[den]+=1;
    If[Last[best]=!=0,
      extraD=extraD Gamma[g2]/Gamma[g2+Last[best]];
      AppendTo[tr,{"s2-offset",g2,"->",g2+Last[best]}];
      g2=Expand[g2+Last[best]]];
    (* raises of the numerator legs: Gamma(g) = Gamma(g + k)/(g)_k *)
    extraD=extraD/(Product[g1+j,{j,0,k1-1}] Product[g2+j,{j,0,k2-1}]);
    m=n+k1+k2;
    (* Gamma(g1'+g2')/Gamma(den), g1'+g2' = den + m *)
    extraD=extraD If[m>=0,Product[den+j,{j,0,m-1}],1/Product[den+m+j,{j,0,-m-1}]];
    v=Symbol["Global`fcs2v"<>ToString[++nv]];AppendTo[vars,v];
    dfac=dfac v^(g1+k1-1) (1-v)^(g2+k2-1);
    AppendTo[tr,{"s2-triple",den,g1,g2,"n"->n,"raise"->{k1,k2},"var"->v}]];
  If[vars==={},Throw[None,"s2"]];
  newK=Times@@(Gamma[#]^cnt[#]&/@Keys[cnt]);
  {newK D extraD,dfac,vars,tr}],"s2"];

Global`fcuDress[f_,zs_List,ctrAll_,eN_,eps_]/;TrueQ[Global`$fcuS2Beta]:=Module[{ex,d0},
  ex=fcuS2Extract[f,zs,ctrAll,eN,eps];
  If[ex===None,Return[Global`fcuDressOrig[f,zs,ctrAll,eN,eps],Module]];
  Print["    [s2] slope-two triples as initial Euler structure: ",InputForm[ex[[4]]]];
  d0=Global`fcuDressOrig[ex[[1]],zs,ctrAll,eN,eps];
  Which[
    AssociationQ[d0]&&TrueQ[d0["Failed"]],d0,
    d0===None,<|"Failed"->False,"K"->ex[[1]],"Dressing"->ex[[2]],"Vars"->ex[[3]],"Prefactor"->1,"Trace"->ex[[4]]|>,
    True,<|"Failed"->False,"K"->d0["K"],"Dressing"->ex[[2]] d0["Dressing"],"Vars"->Join[ex[[3]],d0["Vars"]],
      "Prefactor"->d0["Prefactor"],"Trace"->Join[ex[[4]],d0["Trace"]]|>]];

(* ---------- sixth-root reduction of a served value ---------- *)
uintL6Canon[x_]:=Module[{w=x},
  w=w/.HoldPattern[PolyLogTools`G[0,z_]]/;NumericQ[z]:>Log[z];
  w=w/.g:HoldPattern[PolyLogTools`G[__]]/;Length[g]>=3&&AllTrue[Most[List@@g],#===0&]&&NumericQ[Last[g]]:>
      Log[Last[g]]^(Length[g]-1)/(Length[g]-1)!;
  w=w/.HoldPattern[PolyLogTools`G[a_,z_]]/;NumericQ[a]&&a=!=0&&NumericQ[z]:>Log[1-z/a];
  w];
uintL6Reduce[x_]:=Module[{w=uintL6Canon[x],r},
  If[FreeQ[w,_PolyLogTools`G],Return[Global`mbeCanonicalConstants[w],Module]];
  If[DownValues[Global`bwsL6Reduce]==={},Return[$Failed,Module]];
  r=Quiet@Global`bwsL6Reduce[w];
  If[r===$Failed||ListQ[r]||!FreeQ[r,_PolyLogTools`G],$Failed,r]];

(* ---------- the closer: Taylor coefficients I_0..I_dep of int_c2 G at eps = 0 ---------- *)
If[!ValueQ[$s2Workers],$s2Workers=6];
s2cubeTaylor[G_,c2_,dep_]:=Module[{res,out,ks,t0=AbsoluteTime[]},
  If[DownValues[Global`fcuResidueLaurent]==={},Return[Failure["S2Cube",<|"Reason"->"faithful-cube rung not loaded"|>],Module]];
  If[!AnyTrue[Cases[G,Power[Gamma[a_],n_/;n<0]:>a,{0,Infinity}],fcuS2Slope2Q[#,Keys[c2]]&],
    Return[Failure["S2Cube",<|"Reason"->"no slope-two denominator"|>],Module]];
  SetEnvironment["MBE_L6_ACCEPT_BASIS"->"1"];
  (* subkernels for the pieces, prepared by the rung's own launcher; value contract off in every worker *)
  ks={};
  If[$s2Workers>0&&Kernels[]==={},
    (* the drivers set $fcuMaxWorkers = 0 (no workers inside the package pipeline); this closer launches its own *)
    ks=Block[{Global`$fcuMaxWorkers=$s2Workers},Quiet@Global`fcuLaunchWorkers[True,$s2Workers]];
    If[ks=!={},Quiet@ParallelEvaluate[Global`$IVFValueContract=False;SetEnvironment["MBE_L6_ACCEPT_BASIS"->"1"],ks]]];
  res=Block[{Global`$fcuS2Beta=True,Global`$IVFValueContract=False},
    Quiet@TimeConstrained[Global`fcuResidueLaurent[MBint[G,{{ep->0},c2}],ep,0,dep,True],Max[600,closeSeconds],$Aborted]];
  If[ks=!={},Quiet@CloseKernels[]];
  Print["    [s2cube] faithful cube (slope-two triples): ",Round[AbsoluteTime[]-t0]," s"];
  If[!ListQ[res]||Length[res]=!=dep+1,Return[Failure["S2Cube",<|"Reason"->"faithful cube refused: "<>ToString[Short[res,3],InputForm]|>],Module]];
  out=uintL6Reduce/@res;
  If[MemberQ[out,$Failed],Return[Failure["S2Cube",<|"Reason"->"sixth-root reduction refused"|>],Module]];
  out];
(* ---------- the faithful cube as a GENERAL multi-fold closer of a stuck term (unit slopes; slope-two denominators through
   the Beta triple above): Taylor coefficients I_0..I_dep of int_c2 G at eps = 0, pieces on subkernels, values reduced
   (sixth roots when present) -- the Subtraction route's own rung, used where the Barnes closed forms refuse ---------- *)
fcuTaylor[G_,c2_,dep_]:=Module[{res,out,ks={},t0=AbsoluteTime[]},
  If[DownValues[Global`fcuResidueLaurent]==={},Return[Failure["FCU",<|"Reason"->"faithful-cube rung not loaded"|>],Module]];
  SetEnvironment["MBE_L6_ACCEPT_BASIS"->"1"];
  If[$s2Workers>0&&Kernels[]==={},
    ks=Block[{Global`$fcuMaxWorkers=$s2Workers},Quiet@Global`fcuLaunchWorkers[True,$s2Workers]];
    If[ks=!={},Quiet@ParallelEvaluate[Global`$IVFValueContract=False;SetEnvironment["MBE_L6_ACCEPT_BASIS"->"1"],ks]]];
  res=Block[{Global`$fcuS2Beta=True,Global`$IVFValueContract=False},
    Quiet@TimeConstrained[Global`fcuResidueLaurent[MBint[G,{{ep->0},c2}],ep,0,dep,True],Max[600,closeSeconds],$Aborted]];
  If[ks=!={},Quiet@CloseKernels[]];
  Print["    [fcu] faithful cube: ",Round[AbsoluteTime[]-t0]," s"];
  If[!ListQ[res]||Length[res]=!=dep+1,Return[Failure["FCU",<|"Reason"->"faithful cube refused: "<>ToString[Short[res,3],InputForm]|>],Module]];
  out=uintL6Reduce/@res;
  If[MemberQ[out,$Failed],Return[Failure["FCU",<|"Reason"->"value reduction refused"|>],Module]];
  out];

(* ---------- the ECONOMICAL form (09-27, measured): Beta undo + inner Mellin tower at the scale + outer IVF fold ----------
   The whole-term faithful cube above is exact but builds a five-variable cube for MB8bu r35 whose kernel letter
   L = x1(1-x3) + v(1-v) x2 x3 x4 has a log-divergent compound corner at {v -> 0, x3 -> 1}; its blow-up mixes v into the
   sector variables and the integrator refuses those pieces (nonlinear factor with coefficients in later variables).
   The corner is an artefact of representing the inner scaled integral J(Y) = Int dz Y^z K(z) by a kernel collapse.
   Closing the inner integral in MELLIN space instead -- by the package's Mellin-tower rung (mbeMellinTowerRung.m:
   radial towers at a positive parameter scale, epsilon-symbolic, two-sided contour gate), Y = v(1-v) in (0, 1/4] -- gives
   J(Y, eps) in logarithms and polylogarithms of Y with the Y -> 0 behaviour explicit (the first right pole), and the
   outer one-dimensional integral
       I(eps) = Int_0^1 dv v^(alpha(eps)-1) (1-v)^(beta(eps)-1) J(v(1-v), eps)
   is integrable order by order (Re(z + alpha) > 0 on the contour is the Beta condition; the right poles give
   J = O(Y^(p0)) with Re(p0 + alpha) > 0).  Its Taylor coefficients are one-variable integrals of Log/PolyLog of the
   quadratic v - v^2, which IntVolIntegrate takes through its G/HPL -> Hlog conversion (letter polynomials of degree <= 2);
   the conic letter 1 - v + v^2 appears only in the last (and only) variable, the class the integrator was checked on. *)
(* rationals/polynomials in z as Gamma ratios, 1/l = Gamma(l)/Gamma(l+1), l = Gamma(l+1)/Gamma(l): TOP-LEVEL FACTORS ONLY
   (a ReplaceAll would also rewrite the affine ARGUMENTS of the Gamma functions -- the first run did exactly that) *)
s2Rat2Gamma[e_,z_]:=Times@@(Function[t,Which[
    MatchQ[t,Power[l_,k_Integer]/;k=!=0&&PolynomialQ[l,z]&&Exponent[l,z]===1],
      If[t[[2]]<0,(Gamma[t[[1]]]/Gamma[t[[1]]+1])^(-t[[2]]),(Gamma[t[[1]]+1]/Gamma[t[[1]]])^t[[2]]],
    Head[t]=!=Gamma&&PolynomialQ[t,z]&&Exponent[t,z]===1,Gamma[t+1]/Gamma[t],
    True,t]]/@If[Head[e]===Times,List@@e,{e}]);
(* ---------- the inner J(Y) as a PURE EULER integrand (09-27, measured) ----------
   IntVolIntegrate is exact on Euler integrands whose letters are polynomials (the conic 1 - v + v^2 included), but its
   G/HPL -> Hlog conversion of a polylogarithm of the COMPOSITE argument Y = v - v^2 served a wrong regularized value
   (6.7495 for 1.3792 on MB8bu r35 pos 1).  So J(Y) is rewritten as an Euler integral in which Y enters only
   polynomially: fibration basis in Y (PolyLogTools ToFibrationBasis: G words with letters in {0, 1}, argument linear),
   trailing zeros extracted (G(0^n; Y) = log^n(Y)/n!), and every remaining word by the nested simplex
   t_1 = Y x_1, t_i = t_(i-1) x_i:
       G(a_1..a_n; Y) = Int_[0,1]^n prod_i  Y x_1..x_(i-1) / (Y x_1..x_i - a_i)  dx_i      (a_n != 0),
   one block of variables per G factor of a product (blocks shared across the terms of the sum).  The whole order-k
   outer integrand is ONE integrand over (v, blocks): its total is convergent (Beta condition + first right pole), its
   separate terms need not be, and one call with one chart and one order keeps the engine's (linear) endpoint
   regularization consistent: the regularized value of the whole equals its value.  Check: MB8bu r35 pos 1 order 0 =
   1.37924843411612618366 (term quadrature ...618438), reduced to 2 + 4 Sqrt[3] GI[0,r2] + 16 Zeta[3]/3. *)
(* plain symbols (the engine parses variables by name: an indexed s2x[b, i] reached HyperFLINT as a "function") *)
s2GKernel[as_List,Y_,blk_]:=Module[{n=Length[as],x,P},
  x=Table[Symbol["Global`s2xB"<>ToString[blk]<>"n"<>ToString[i]],{i,n}];P[i_]:=Times@@Take[x,i];
  {Product[If[as[[i]]===0,1/x[[i]],Y P[i-1]/(Y P[i]-as[[i]])],{i,n}],x}];
s2ToEuler[expr_,Y_]:=Catch[Module[{f,terms,out=0,vars={}},
  f=s2Fib[expr,Y];
  If[f===$Failed||!FreeQ[f,PolyLogTools`ToFibrationBasis],Throw[$Failed,"s2e"]];
  f=Expand[f];
  (* trailing zeros out, all-zero words to logarithms *)
  f=Expand[f/.g:PolyLogTools`G[__,0,Y]/;!MatchQ[g,PolyLogTools`G[0..,Y]]:>PolyLogTools`ExtractZeroes[g]];
  f=Expand[f/.HoldPattern[PolyLogTools`G[zs:0..,Y]]:>Log[Y]^Length[{zs}]/Length[{zs}]!];
  If[!FreeQ[f,PolyLogTools`G[__,0,Y]]||!FreeQ[f,PolyLogTools`ExtractZeroes],Throw[$Failed,"s2e"]];
  terms=If[Head[f]===Plus,List@@f,{f}];
  Do[Module[{fs=If[Head[t]===Times,List@@t,{t}],gs,rest,acc,blk=0},
      gs=Flatten[Table[If[MatchQ[a,Power[PolyLogTools`G[__,Y],_Integer?Positive]],ConstantArray[a[[1]],a[[2]]],
          If[MatchQ[a,PolyLogTools`G[__,Y]],{a},{}]],{a,fs}]];
      rest=Times@@Select[fs,FreeQ[#,PolyLogTools`G[__,Y]]&];
      acc=rest;
      Do[Module[{kv=s2GKernel[Most[List@@g],Y,++blk]},acc=acc kv[[1]];vars=Union[vars,kv[[2]]]],{g,gs}];
      out+=acc],{t,terms}];
  If[!FreeQ[out,PolyLogTools`G[__,Y]],Throw[$Failed,"s2e"]];
  {out,vars}],"s2e"];
(* the outer fold through the package integrator: exact path first, then the whole-integrand regularized run; the value
   contract of the integrator (N[] evaluable) replaced by Ginsh evaluability, since sixth-root G words need Ginsh *)
s2IVF[integ_,vars_]:=Module[{res,lr},
  res=Block[{Global`$IVFValueContract=False},Quiet@TimeConstrained[Global`IntVolIntegrate[integ,vars,"Verbose"->False],Max[300,closeSeconds],$TimedOut]];
  If[!AssociationQ[res]||res["Result"]===$Failed,
    res=Block[{Global`$IVFFinitePartMode=True,Global`$IVFValueContract=False,Global`ivfCleanValueQ},
      Global`ivfCleanValueQ[w_]:=FreeQ[w,_Real]&&NumericQ[Quiet@N[w/.g_PolyLogTools`G:>Global`gnumHF[g],20]];
      Quiet@TimeConstrained[Global`IntVolIntegrate[integ,vars,"Verbose"->False],Max[300,closeSeconds],$TimedOut]]];
  If[!AssociationQ[res]||res["Result"]===$Failed,Return[$Failed,Module]];
  lr=Lookup[res,"LamRules",{}];
  <|"Value"->(res["Result"]//.lr),"Regularized"->TrueQ[Lookup[res,"Regularized",False]],"Engine"->Lookup[res,"Engine",""]|>];
(* ---------- the OUTER FOLD BY THE PACKAGE'S EXACT LAST FOLD (09-27 10:40; the IntVolIntegrate route above is the fallback) --------
   The Euler-cube route of the outer fold is exact but slow (a 4-variable order-1 integrand took > 20 min).  The outer
   integral is one-dimensional, so it is closed as a last fold (mbeExactLastFoldRung.m: partial fractions with root
   placeholders, PolyLogTools GIntegrate, higher poles and polynomial parts by parts, derivative gate, x = 1 shuffle-
   regularized with every regulator coefficient vanishing, x = 0 by the complete jets with every log/pole cancelling).
   The inner words are PULLED BACK exactly to fixed letters in v: for letters a_i in {0,1} and a_n != 0,
       G(a_1, w; Y(v)) = sum_rho G(rho, PB(w); v),   rho over the roots of Y(v) = a_1,   PB(a) = sum_rho G(rho; v),
   since d/dv log(Y(v) - a) = sum_rho 1/(v - rho) (Y - a = -(v - rho_1)(v - rho_2)) and both sides vanish at v = 0
   (Y(0) = 0); the roots are {0, 1} for a = 0 and the sixth roots (1 +- I Sqrt[3])/2 for a = 1, carried as the rung's
   placeholder symbols of v^2 - v + 1 (so the partial fractions of 1/(1 - v + v^2)^k use the same symbols); trailing zeros
   are extracted first and log Y = G(0; v) + G(1; v).  No composite argument ever reaches an integrator. *)
(* 09-27 13:10 (polylogtools_syntax.md, project rules 4 and 9): ToFibrationBasis fits symbol-kernel constants
   numerically, so every call pins its fit point (2/15 lies inside every scale domain used here: (0,1/4] for a slope-two
   denominator, (0,1) for the unit scale, (0,infinity) for the numerator pair, and avoids the letters 0, +-1, 1/4); and
   every primitive is certified by its exact derivative (DG, shuffle-linearized, collected by word, each coefficient
   identically zero; root placeholders replaced by their radicals, RootReduce per coefficient) *)
(* 2026-10-01 STRAY G HEADS: PolyLogTools parses GiNaC output with ToExpression, so a word head "G" resolves to
   Global`G whenever that symbol EXISTS (a HypExp evaluation creates it); such words are neither canonicalized nor
   evaluated numerically (the "G[0, 2.0]" in gate values, "NUMERIC_FAILED" jets).  Every word head named G that is not
   PolyLogTools`G is mapped back. *)
s2GHeadFix[e_]:=e/.h_Symbol[a__]/;SymbolName[Unevaluated[h]]==="G"&&Context[h]=!="PolyLogTools`":>PolyLogTools`G[a];
s2Fib[e_,var_]:=s2GHeadFix[Quiet@Check[PolyLogTools`ToFibrationBasis[e,{var},PolyLogTools`FitValue->{var->2/15}],$Failed]];
s2ExactDerivQ[primp_,integ_,x_,back_:{}]:=Module[{d,ws,cs,zeroQ},
  zeroQ[c_]:=Module[{t=Together[Expand[c/.back]],num,cl},
    If[t===0,Return[True,Module]];
    num=Expand[Numerator[t]];
    cl=If[PolynomialQ[num,x],CoefficientList[num,x],{num}];
    AllTrue[cl,Function[q,With[{r=Quiet@TimeConstrained[RootReduce[q],120,$TimedOut]},If[r===$TimedOut,Throw["undecided","s2dq"],r===0]]]]];
  Catch[
    d=Expand[PolyLogTools`DG[primp,x]-integ];
    d=Expand[PolyLogTools`ShuffleG[d]];
    ws=DeleteDuplicates[Cases[d,PolyLogTools`G[__,x],{0,Infinity}]];
    cs=Coefficient[d,#]&/@ws;
    AllTrue[Append[cs,Expand[d/.Thread[ws->0]]],zeroQ],"s2dq"]];
s2LastFoldLoadedQ[]:=(If[DownValues[MBExactLastFold`mbeLastFoldIntegrate]==={},
    Quiet@Get[FileNameJoin[{ParentDirectory[$closeLibDir],"mbeExactLastFoldRung.m"}]]];
  (* the rung's integration by parts recurses to the EMPTY word G[x], which PolyLogTools evaluates to 1 (the rung's own
     callers clear G): the integral of a polynomial or rational part times the empty word, added at run time *)
  If[FreeQ[DownValues[MBExactLastFold`Private`polyIntPoly],HoldPattern[MBExactLastFold`Private`polyIntPoly[_,1]]],
    MBExactLastFold`Private`polyIntPoly[q_,1]:=Integrate[q,MBExactLastFold`Private`xv];
    MBExactLastFold`Private`integratePart[pt_,1]:=s2RatPrimitive[pt,MBExactLastFold`Private`xv]];
  DownValues[MBExactLastFold`mbeLastFoldIntegrate]=!={});
s2PBpre[rho_,1]:=PolyLogTools`G[rho,s2PBv];
(* 2026-10-01 10:4x: HoldPattern holds the GLOBAL s2PBv unevaluated (the 08:52 HoldPattern wrapping made this rule match the
   literal symbol s2PBv instead of its value Global`s2pv: every weight >= 2 pullback lost its outer letter and the conversion
   gate refused the whole slope-two outer fold); the variable is evaluated through With *)
s2PBpre[rho_,e_]:=With[{pv=s2PBv},Expand[e]/.HoldPattern[PolyLogTools`G[w__,pv]]:>PolyLogTools`G[rho,w,pv]];
(* s2PBword (the pullback of one word, memoized) is (re)defined by s2OuterExact for each call: the placeholders change *)
(* inner coefficient (function of Y) -> fixed-letter words in v *)
s2JtoV[J_,Y_]:=Module[{f},
  If[J===0,Return[0,Module]];
  f=s2Fib[J,Y];
  If[f===$Failed||!FreeQ[f,PolyLogTools`ToFibrationBasis],Throw[Failure["S2Outer",<|"Reason"->"fibration basis in Y refused"|>],"s2o"]];
  f=Expand[f];
  f=Expand[f/.g:PolyLogTools`G[__,0,Y]/;!MatchQ[g,PolyLogTools`G[0..,Y]]:>PolyLogTools`ExtractZeroes[g]];
  f=Expand[f/.HoldPattern[PolyLogTools`G[zs:0..,Y]]:>Log[Y]^Length[{zs}]/Length[{zs}]!];
  If[!FreeQ[f,PolyLogTools`G[__,0,Y]|PolyLogTools`ExtractZeroes],Throw[Failure["S2Outer",<|"Reason"->"trailing zeros not extracted"|>],"s2o"]];
  f=f/.HoldPattern[PolyLogTools`G[w__,Y]]:>s2PBword[{w}];
  f=f/.Log[Y]->s2LogS;
  If[!FreeQ[f,(Log|PolyLog|HPL`HPL|PolyLogTools`G)[___,a_]/;!FreeQ[a,Y]],Throw[Failure["S2Outer",<|"Reason"->"transcendental Y-dependence left"|>],"s2o"]];
  Expand[f/.Y->s2Scale]];
(* primitive of a G-free rational part (the rung's word integration needs the empty word G[x] inert; PolyLogTools
   evaluates it to 1): partial fractions with the rung's placeholders, c/(x-a) -> c G(a;x), c/(x-a)^m -> -c/((m-1)(x-a)^(m-1)) *)
s2RatPrimitive[R_,x_]:=Module[{pf,parts},
  If[R===0,Return[0,Module]];
  pf=MBExactLastFold`Private`splitRational[R];
  parts=DeleteCases[List@@(pf+Global`zzz)/.Global`zzz->0,0];
  Total[Map[Function[pt,If[PolynomialQ[pt,x],Integrate[pt,x],
    Module[{den=Denominator[Together[pt]],fl,lin,m,a,c},
      fl=Select[FactorList[den],!FreeQ[#[[1]],x]&];
      If[Length[fl]=!=1||Exponent[fl[[1,1]],x]=!=1,Throw[Failure["S2Outer",<|"Reason"->"rational part not a linear pole: "<>ToString[pt,InputForm]|>],"s2o"]];
      lin=fl[[1,1]];m=fl[[1,2]];a=-(lin/.x->0)/Coefficient[lin,x];c=Together[pt (x-a)^m];
      If[!FreeQ[c,x],Throw[Failure["S2Outer",<|"Reason"->"rational part numerator: "<>ToString[pt,InputForm]|>],"s2o"]];
      If[m==1,c PolyLogTools`G[a,x],-c/((m-1)(x-a)^(m-1))]]]],parts]]];
(* the COMPLETE jet of a primitive at x = 0: every term's rational Laurent part times the exact series of its words
   (all-zero words = L^m/m!, L = log x) -- also for terms WITHOUT a rational pole.  (The rung's regLimitZero sets the
   all-zero words of pole-free terms to 0 but keeps the logarithms of the other terms: on the slope-two outer fold that
   mixed convention left a spurious log coefficient -1 at a convergent endpoint.)  Returns sum over k <= 0 of x^k c_k(L). *)
s2RegLimitZero[P_,x_]:=Module[{terms,total=0,G=PolyLogTools`G},
  terms=DeleteCases[List@@(Expand[P]+Global`zzz)/.Global`zzz->0,0];
  Do[Module[{fs,isW,gx,rest,ratpart,constpart,p,ser,lau},
    fs=If[Head[t]===Times,List@@t,{t}];
    isW[f_]:=MatchQ[f,G[__,x]|Power[G[__,x],_Integer?Positive]];
    gx=Flatten[Replace[Select[fs,isW],Power[g_,n_]:>ConstantArray[g,n],{1}]];
    rest=Times@@Select[fs,!isW[#]&];
    constpart=Times@@Select[If[Head[rest]===Times,List@@rest,{rest}],!FreeQ[#,G]&];ratpart=Together[rest/constpart];
    If[!FreeQ[ratpart,G]||!FreeQ[constpart,x],Throw[Failure["S2Outer",<|"Reason"->"jet term outside the class: "<>ToString[Short[t,3],InputForm]|>],"s2o"]];
    p=Max[0,Exponent[Denominator[ratpart],x,Min]];
    ser=Expand[Times@@(MBExactLastFold`Private`gser[Most[List@@#],x,p]&/@gx)];
    lau=Normal[Series[ratpart,{x,0,0}]];
    total+=constpart*Sum[Coefficient[Expand[lau*ser],x,-k] x^-k,{k,0,p}]],{t,terms}];
  Expand[total]];
(* the complete jet of a primitive at x = 1 (individual terms may carry rational poles at 1 that cancel in the sum):
   G(w; 1-y) = sum_k Greg(a_(k+1)..a_n; 1) G(1-a_1, .., 1-a_k; y) (path composition, tangential base point at 1:
   MBMellinTower's mtGreg), then the rung's zero-side jet in y; every negative power and every power of log y must
   cancel NUMERICALLY in the sum (no term gets a finite part of its own) *)
s2JetOne[primp_,x_,gnum_]:=Module[{y=Global`s2py,pr,at,lc,pc,Lsym=MBExactLastFold`Private`Lsym},
  pr=primp/.HoldPattern[PolyLogTools`G[w__,x]]:>Sum[MBMellinTower`Private`mtGreg[Drop[{w},k],1] (PolyLogTools`G@@Append[1-Take[{w},k],y]),{k,0,Length[{w}]}];
  pr=Expand[pr/.x->1-y];
  at=s2RegLimitZero[pr,y];
  lc=Table[gnum[Coefficient[Coefficient[at,y,0],Lsym,j]],{j,1,Max[1,Exponent[at,Lsym]]}];
  pc=Flatten[Table[gnum[Coefficient[Coefficient[at,y,-k],Lsym,j]],{k,1,Max[1,-Exponent[at,y,Min]]},{j,0,Max[0,Exponent[at,Lsym]]}]];
  If[!AllTrue[Join[lc,pc],NumericQ[#]&&Abs[#]<10^-12&],Throw[Failure["S2Outer",<|"Reason"->"jet at 1 does not cancel: "<>ToString[N[Join[lc,pc],6]]|>],"s2o"]];
  Coefficient[Coefficient[Expand[at],Lsym,0],y,0]];
(* the last fold of the complete integrand: the rung's word integration (partial fractions, GIntegrate, higher poles and
   polynomial parts by parts) + the rational primitive, the rung's derivative gate, the jets at 0 (rung) and at 1 (above) *)
s2LFIntegrate[integ_,x_,gnum_]:=Module[{terms,gt,rt,primp,dg,at0p,at1p,lc,pc,Lsym=MBExactLastFold`Private`Lsym},
  MBExactLastFold`Private`xv=x;MBExactLastFold`Private`refusal=None;
  terms=DeleteCases[List@@(Expand[integ]+Global`zzz)/.Global`zzz->0,0];
  gt=Select[terms,!FreeQ[#,PolyLogTools`G[__,x]]&];rt=Select[terms,FreeQ[#,PolyLogTools`G[__,x]]&];
  (* 2026-10-01: phase timings (the slope-two closer ran past its 2400 s budget on MB8au r43 pieces 34/39 at order 1) *)
  Module[{tA=AbsoluteTime[],tB},
  primp=Catch[Total[MBExactLastFold`Private`integrateTerm/@gt],MBExactLastFold`Private`lastfold];
  If[primp===$Failed,Throw[Failure["S2Outer",<|"Reason"->"word integration: "<>ToString[MBExactLastFold`Private`refusal]|>],"s2o"]];
  primp=Expand[(primp/.HoldPattern[PolyLogTools`G[x]]->1)+s2RatPrimitive[Total[rt],x]];
  tB=AbsoluteTime[];Print["    [s2tower]   last fold: ",Length[gt]," word terms + ",Length[rt]," rational, primitive in ",Round[tB-tA]," s (",LeafCount[primp]," leaves)"];tA=tB;
  dg=MBExactLastFold`Private`derivativeGate[primp,integ,x,gnum];
  If[!TrueQ[dg["Pass"]],Throw[Failure["S2Outer",<|"Reason"->"primitive derivative gate: "<>ToString[dg["Residual"]]|>],"s2o"]];
  tB=AbsoluteTime[];Print["    [s2tower]   derivative gate ",Round[tB-tA]," s"];tA=tB;
  With[{ex=s2ExactDerivQ[primp,integ,x,s2Back[]]},
    If[ex===False,Throw[Failure["S2Outer",<|"Reason"->"exact derivative certificate failed"|>],"s2o"]];
    If[ex==="undecided",Print["    [s2tower] exact derivative certificate undecided (RootReduce time limit); numeric gate passed"]]];
  tB=AbsoluteTime[];Print["    [s2tower]   exact derivative certificate ",Round[tB-tA]," s"];tA=tB;
  at1p=s2JetOne[primp,x,gnum];
  tB=AbsoluteTime[];Print["    [s2tower]   jet at 1: ",Round[tB-tA]," s"];tA=tB;
  at0p=s2RegLimitZero[primp,x];
  Print["    [s2tower]   jet at 0: ",Round[AbsoluteTime[]-tA]," s"]];
  lc=Table[gnum[Coefficient[Coefficient[at0p,x,0],Lsym,j]],{j,1,Max[1,Exponent[at0p,Lsym]]}];
  pc=Flatten[Table[gnum[Coefficient[Coefficient[at0p,x,-k],Lsym,j]],{k,1,Max[1,-Exponent[at0p,x,Min]]},{j,0,Max[0,Exponent[at0p,Lsym]]}]];
  If[!AllTrue[Join[lc,pc],NumericQ[#]&&Abs[#]<10^-12&],Throw[Failure["S2Outer",<|"Reason"->"jet at 0 does not cancel: "<>ToString[N[Join[lc,pc],6]]|>],"s2o"]];
  at0p=Coefficient[Coefficient[Expand[at0p],Lsym,0],x,0];
  (at1p-at0p)/.s2Back[]];
(* Taylor coefficients of the outer integral, orders 0..dep, from the inner coefficients Jk (functions of Y) and the
   weight coefficients wser (functions of v with Log[v], Log[1-v]); returns the list of exact values or a Failure *)
(* GENERAL SCALE MAP (09-27 10:55): the scale is a rational function S(v) with S(0) = 0 (v(1-v) for a slope-two
   denominator, v^2/(1-v) for a slope-two numerator); for an inner letter a the pullback kernel is
   d log(S - a) = sum over the zeros rho of the numerator of S - a of m/(v - rho) minus the same over its poles, every
   irreducible factor through the rung's root placeholders; a pulled-back letter strictly inside (0,1) is refused (it
   would lie on the integration path); log S = log C + sum m G(rho; v), C = lim S/v^m0 > 0. *)
s2LetterRoots[a_]:=If[KeyExistsQ[s2RootTab,a],s2RootTab[a],s2RootTab[a]=Module[{t=Together[s2Scale-a],out={},x=s2PBv},
  Do[Module[{f=fl[[1]],m=sg fl[[2]]},
      If[!FreeQ[f,x],
        If[Exponent[f,x]==1,AppendTo[out,{-(f/.x->0)/Coefficient[f,x],m}],
          Do[AppendTo[out,{rs,m}],{rs,MBExactLastFold`Private`rootSyms[f]}]]]],
    {sg,{1,-1}},{fl,FactorList[If[sg==1,Numerator[t],Denominator[t]]]}];
  Do[With[{nv=Quiet@N[r[[1]]/.MBExactLastFold`Private`backRules[],30]},
      If[NumericQ[nv]&&Abs[Im[nv]]<10^-20&&0<Re[nv]<1&&!MemberQ[{0,1},r[[1]]],
        Throw[Failure["S2Outer",<|"Reason"->"pulled-back letter "<>ToString[N[nv,8]]<>" inside (0,1) for the inner letter "<>ToString[a,InputForm]|>],"s2o"]]],{r,out}];
  out]];
(* the placeholders are substituted back as EXPLICIT RADICALS: Solve returns the sixth roots as (-1)^(1/3), a form in
   which PolyLogTools evaluates G words at 1 symbolically into Clausen symbols (Cl[2, Pi/3]) that nothing evaluates
   numerically ("NUMERIC_FAILED" at the endpoint check); with (1 +- I Sqrt[3])/2 Ginsh evaluates every word *)
(* the root FORM matters: PolyLogTools evaluates G words with the letter (-1)^(1/3) into Clausen symbols and rewrites
   letters 1/2 + I Sqrt[3]/2 (Plus form, e.g. from ComplexExpand) into its GR/GI symbols -- both bypass the sixth-root
   reduction; the Together form (1 + I Sqrt[3])/2 stays a plain G word, as in the IntVolIntegrate values bwsL6Reduce takes *)
s2Back[]:=MBExactLastFold`Private`backRules[]/.Rule[a_,b_]:>Rule[a,Together[ComplexExpand[b]]];
(* numerics (gates only): explicit complex letters inside G make PolyLogTools rewrite G(..;1) into GR/GI symbols, so the
   words are evaluated by Ginsh with the placeholders substituted INSIDE GiNaC (its substitution list); {0,+-1}-words at
   argument 1 through the HPL tables with the sign (the Ginsh argument-one trap) *)
s2GnumWord[g_]:=Module[{ls=Most[List@@g],z=Last[g],rules},
  If[z===1&&ls=!={}&&SubsetQ[{0,1,-1},ls]&&First[ls]=!=1,Return[(-1)^Count[ls,1] N[HPL`HPL[ls,1],42],Module]];
  rules=Select[s2BackN,!FreeQ[g,First[#]]&];
  Quiet@TimeConstrained[N[PolyLogTools`Ginsh[g,rules,PolyLogTools`PrecisionGoal->40],30],120,$TimedOut]];
s2Gnum[e_]:=Module[{w},
  If[!ValueQ[s2BackN]||Length[s2BackN]=!=Length[MBExactLastFold`Private`backRules[]],s2BackN=s2Back[]/.Rule[a_,b_]:>Rule[a,N[b,50]]];
  w=s2GHeadFix[e]/.g_PolyLogTools`G:>s2GnumWord[g];w=Quiet@N[w/.s2Back[],20];
  If[NumericQ[w],w,"NUMERIC_FAILED"]];
s2OuterExact[Jk_List,wser_List,dep_,Y_,v_,S_:Automatic,extra_:0]:=Catch[Module[{gnum,W,JV,out={},t0,y0,EX},
  If[!s2LastFoldLoadedQ[],Throw[Failure["S2Outer",<|"Reason"->"exact last-fold rung not loaded"|>],"s2o"]];
  (* reset the rung's registry (placeholders of irreducible denominators) *)
  MBExactLastFold`mbeLastFoldFibrate[0,s2PBv,1/2];
  s2Scale=Together[If[S===Automatic,s2PBv-s2PBv^2,S/.v->s2PBv]];
  If[!TrueQ[(s2Scale/.s2PBv->0)===0],Throw[Failure["S2Outer",<|"Reason"->"scale map does not vanish at 0: "<>ToString[s2Scale,InputForm]|>],"s2o"]];
  MBExactLastFold`Private`gatePts={3/10,7/10};
  gnum=s2Gnum;
  s2RootTab=<||>;
  s2LogS=Module[{rs=s2LetterRoots[0],m0,cc},
    m0=Total[Cases[rs,{0,m_}:>m]];cc=Together[Limit[s2Scale/s2PBv^m0,s2PBv->0]];
    If[!(NumericQ[cc]&&TrueQ[cc>0]),Throw[Failure["S2Outer",<|"Reason"->"scale constant at 0 not positive"|>],"s2o"]];
    Log[cc]+Total[(#[[2]] PolyLogTools`G[#[[1]],s2PBv])&/@rs]];
  s2PBroots=DeleteDuplicates[Cases[Values[s2RootTab],_Symbol,{0,Infinity}]];
  Clear[s2BackN];   (* numeric root values rebuilt lazily from the current registry *)
  DownValues[s2PBword]={HoldPattern[s2PBword[{}]]:>1,HoldPattern[s2PBword[w_List]]:>(s2PBword[w]=Total[(#[[2]] s2PBpre[#[[1]],s2PBword[Rest[w]]])&/@s2LetterRoots[First[w]]])};
  y0=s2Scale/.s2PBv->3/10;
  W=Table[Expand[(wser[[j]]/.v->s2PBv)/.{Log[s2PBv]->PolyLogTools`G[0,s2PBv],Log[1-s2PBv]->PolyLogTools`G[1,s2PBv]}],{j,Length[wser]}];
  If[!FreeQ[W,Log|PolyLog],Throw[Failure["S2Outer",<|"Reason"->"weight not in Log[v], Log[1-v]"|>],"s2o"]];
  JV=Table[s2JtoV[Jk[[m]],Y],{m,Length[Jk]}];
  EX=Expand[(extra/.v->s2PBv)/.{Log[s2PBv]->PolyLogTools`G[0,s2PBv],Log[1-s2PBv]->PolyLogTools`G[1,s2PBv]}];
  Do[Module[{integ,ig,val,chk},t0=AbsoluteTime[];
      integ=Expand[Sum[W[[j+1]] JV[[k-j+1]],{j,0,k}]+If[k==0,EX,0]];
      If[integ===0,AppendTo[out,0];Continue[]];
      (* conversion gate (never a producer): the pulled-back integrand against the original at v = 3/10 *)
      (* both sides through Ginsh: the inner coefficients can carry G words (the rational operator), which N leaves
         unevaluated (a false refusal at 12:31) *)
      chk={gnum[Sum[(wser[[j+1]]/.v->3/10) (Jk[[k-j+1]]/.Y->y0),{j,0,k}]+If[k==0,extra/.v->3/10,0]],gnum[integ/.s2PBv->3/10]};
      If[!(NumericQ[chk[[1]]]&&NumericQ[chk[[2]]]&&Abs[chk[[1]]-chk[[2]]]<10^-15 Max[1,Abs[chk[[1]]]])&&StringQ[$s2OuterDump],
        Put[<|"Jk"->Jk,"wser"->wser,"JV"->JV,"W"->W,"Scale"->s2Scale,"Y"->Y,"v"->v,"Order"->k,"Check"->chk,"RootBack"->MBExactLastFold`Private`backRules[]|>,$s2OuterDump<>".conv"]];
      If[!(NumericQ[chk[[1]]]&&NumericQ[chk[[2]]]&&Abs[chk[[1]]-chk[[2]]]<10^-15 Max[1,Abs[chk[[1]]]]),
        Throw[Failure["S2Outer",<|"Reason"->"pullback conversion gate at order "<>ToString[k]<>": "<>ToString[N[chk,15]]|>],"s2o"]];
      Print["    [s2tower]   order ",k,": pulled-back integrand ",LeafCount[integ]," leaves, conversion gate ",Round[AbsoluteTime[]-t0]," s"];
      ig=Catch[s2LFIntegrate[integ,s2PBv,gnum],"s2o"];
      If[FailureQ[ig]&&StringQ[$s2OuterDump],Put[<|"Integrand"->integ,"Order"->k,"Reason"->ig["Reason"],"Roots"->s2PBroots,"RootBack"->MBExactLastFold`Private`backRules[]|>,$s2OuterDump]];
      If[FailureQ[ig],Throw[Failure["S2Outer",<|"Reason"->"last fold at order "<>ToString[k]<>": "<>ig["Reason"]|>],"s2o"]];
      Module[{tL=AbsoluteTime[]},val=uintL6Reduce[ig];Print["    [s2tower]   sixth-root reduction ",Round[AbsoluteTime[]-tL]," s"]];
      If[val===$Failed,Throw[Failure["S2Outer",<|"Reason"->"sixth-root reduction refused at order "<>ToString[k]|>],"s2o"]];
      Print["    [s2tower] exact outer fold order ",k,": ",Round[AbsoluteTime[]-t0]," s, conversion gate ",N[chk[[1]],12],", value ",N[val,16]];
      AppendTo[out,val]],{k,0,dep}];
  out],"s2o"];
s2PBv=Global`s2pv;
(* UNDO the Gauss multiplication of a slope-two denominator (09-27): the Mellin-space driver (uint_mellin_v3.wls) applies
   Gauss multiplication to every u-term before its closers, so a u-Beta Gamma(x)^2/Gamma(2x) reaches closeTerm as
   2^(1-2x) sqrt(pi) Gamma(x)/Gamma(x+1/2).  Legendre's duplication run backwards,
       Gamma(y)/Gamma(y+1/2) = Gamma(y)^2 2^(2y-1)/(sqrt(pi) Gamma(2y)),
   is applied to a denominator leg Gamma(y+1/2) of slope +-1 with its numerator partner Gamma(y) while the integrand
   carries a power of 2 whose exponent depends on the Mellin variables with the matching sign; it is exact for every y,
   removes the 2-power and restores the slope-two denominator that the Beta undo needs.  Checked at a complex point. *)
(* POLYNOMIAL OUT OF THE INNER INTEGRAND (09-27, MB8au r24): same-slope Gamma legs at integer distance -- e.g. the
   balanced slope-two pair Gamma(2-2eps+2z)/Gamma(-2eps+2z) = (2z-2eps)(2z-2eps+1) left after the Beta triple -- are
   polynomials (or reciprocal products) in z; the tower rung would Gauss-multiply them into half-integer legs and its
   gate refused the result (-46 + 46 I for 1.4649).  A polynomial P(z) multiplying Y^z is the operator P(Y d/dY) acting
   on Y^z, so J_P(Y) = P(Y d/dY) J(Y): the tower closes the Gamma part only.  Returns {Gamma part, P(z)} or $Failed. *)
s2SplitPoly[f_,z_]:=Catch[Module[{fs=If[Head[f]===Times,List@@f,{f}],cnt=<||>,rest=1,P=1,keys,changed=True,guard=0},
  Do[Which[MatchQ[t,Power[Gamma[_],_Integer]],cnt[Expand[t[[1,1]]]]=Lookup[cnt,Expand[t[[1,1]]],0]+t[[2]],
      MatchQ[t,Gamma[_]],cnt[Expand[t[[1]]]]=Lookup[cnt,Expand[t[[1]]],0]+1,
      FreeQ[t,z],rest=rest t,
      PolynomialQ[t,z],P=P t,
      MatchQ[t,Power[l_,k_Integer?Negative]/;PolynomialQ[l,z]&&Exponent[l,z]===1],rest=rest t,
      True,Throw[$Failed,"sp"]],{t,fs}];
  (* same-slope pairs at integer distance: Gamma(b+n)/Gamma(b) = (b)_n, Gamma(a)/Gamma(a+n) = 1/(a)_n *)
  While[changed&&guard++<50,changed=False;
    keys=Keys[Select[cnt,#=!=0&]];
    Do[If[!changed&&Lookup[cnt,a,0]>0&&Lookup[cnt,b,0]<0&&Coefficient[a,z]===Coefficient[b,z]&&Coefficient[a,z]=!=0,
        With[{n=Expand[a-b]},If[IntegerQ[n]&&n=!=0,
          cnt[a]-=1;cnt[b]+=1;
          If[n>0,P=P Product[b+j,{j,0,n-1}],rest=rest/Product[a+j,{j,0,-n-1}]];
          changed=True]]],{a,keys},{b,keys}]];
  (* reciprocal linear factors become unit-slope Gamma ratios (a slope-two linear factor 2z + c = 2 (z + c/2)) *)
  rest=Times@@(Function[t,If[MatchQ[t,Power[l_,k_Integer?Negative]/;PolynomialQ[l,z]&&Exponent[l,z]===1],
      With[{l=t[[1]],k=-t[[2]],s=Coefficient[t[[1]],z]},
        (Gamma[Expand[l/s]]/Gamma[Expand[l/s]+1])^k s^(-k)],t]]/@If[Head[rest]===Times,List@@rest,{rest}]);
  {rest Times@@(Gamma[#]^cnt[#]&/@Keys[cnt]),Expand[P]}],"sp"];
(* POLYNOMIAL ABSORPTION (Standard paper, lemma polyabsorb): a linear factor q = s L + (q0 - s L0) of the polynomial times
   a unit-slope numerator leg Gamma(L) is s Gamma(L+1) + (q0 - s L0) Gamma(L): every factor of P(z) is absorbed, one at a
   time, into a leg; the leg is chosen so that no two legs of the result coincide exactly (the tower rung refuses
   coincident legs; absorbing into a repeated leg Gamma(L)^2 splits it).  Returns a SUM of pure Gamma kernels (the tower
   rung closes sums term by term) or $Failed; P(Y d/dY) remains the fallback.  Cheaper than the operator: no derivatives,
   the outer integrand keeps its weight and pole orders. *)
s2AbsorbPoly[K_,P_,z_]:=Catch[Module[{fl=FactorList[P],terms,lin={},coef=1},
  Do[Which[FreeQ[f[[1]],z],coef=coef f[[1]]^f[[2]],
      PolynomialQ[f[[1]],z]&&Exponent[f[[1]],z]===1,Do[AppendTo[lin,f[[1]]],{f[[2]]}],
      True,Throw[$Failed,"ab"]],{f,fl}];
  terms={{coef,K}};
  Do[Module[{new={}},
      Do[Module[{c=tm[[1]],k=tm[[2]],legs,cnt,choose,L,s,q0,L0},
          cnt=<||>;
          Do[Which[MatchQ[t,Power[Gamma[_],_Integer]],cnt[Expand[t[[1,1]]]]=Lookup[cnt,Expand[t[[1,1]]],0]+t[[2]],
              MatchQ[t,Gamma[_]],cnt[Expand[t[[1]]]]=Lookup[cnt,Expand[t[[1]]],0]+1],{t,If[Head[k]===Times,List@@k,{k}]}];
          legs=Select[Keys[cnt],cnt[#]>0&&Abs[Coefficient[#,z]]===1&];
          If[legs==={},Throw[$Failed,"ab"]];
          (* prefer a repeated leg (splits a coincidence), then a leg whose shift does not create a coincidence *)
          choose=SortBy[legs,{If[cnt[#]>1,0,1],If[Lookup[cnt,Expand[#+1],0]>0,1,0]}&];
          L=First[choose];s=Coefficient[q,z]/Coefficient[L,z];q0=Expand[q/.z->0];L0=Expand[L/.z->0];
          AppendTo[new,{c s,k Gamma[L+1]/Gamma[L]}];
          If[!PossibleZeroQ[q0-s L0],AppendTo[new,{c Expand[q0-s L0],k}]]],{tm,terms}];
      terms=new],{q,lin}];
  (* no exactly coincident unit-slope legs may remain in any term *)
  Do[Module[{k=tm[[2]],cnt=<||>},
      Do[Which[MatchQ[t,Power[Gamma[_],_Integer]],cnt[Expand[t[[1,1]]]]=Lookup[cnt,Expand[t[[1,1]]],0]+t[[2]],
          MatchQ[t,Gamma[_]],cnt[Expand[t[[1]]]]=Lookup[cnt,Expand[t[[1]]],0]+1],{t,If[Head[k]===Times,List@@k,{k}]}];
      If[AnyTrue[Keys[cnt],cnt[#]>1&&Coefficient[#,z]=!=0&],Throw[$Failed,"ab"]]],{tm,terms}];
  Total[#[[1]] #[[2]]&/@terms]],"ab"];
(* PARTIAL ABSORPTION (2 October 2026): the linear factors of P into the legs, the irreducible remainder as an operator.
   Used when the tower refuses the Gamma part with the whole polynomial as P(Y d/dY) (MB8bu residue 21: the kernel
   Gamma(-2-z) Gamma(-2+e/7-z) Gamma(1+z) Gamma(1+e/7+z) with P = z (1+z) (2+z) (9+16z+8z^2) failed the tower gate at order
   eps^1 -- its natural tower bases meet the poles of the up legs -- while the kernels with the linear factors absorbed
   pass).  Returns {sum of Gamma kernels, remaining polynomial} or $Failed (no linear factor, or no admissible leg). *)
s2AbsorbPolyPartial[K_,P_,z_]:=Module[{fl=FactorList[P],lin=1,rest=1,ab},
  Do[If[FreeQ[f[[1]],z]||(PolynomialQ[f[[1]],z]&&Exponent[f[[1]],z]===1),lin=lin f[[1]]^f[[2]],rest=rest f[[1]]^f[[2]]],{f,fl}];
  If[FreeQ[lin,z]||FreeQ[rest,z],Return[$Failed,Module]];
  ab=s2AbsorbPoly[K,lin,z];
  If[ab===$Failed,$Failed,{ab,Expand[rest]}]];
s2PolyOperator[P_,z_,J_,Y_]:=Module[{cs=CoefficientList[P,z]},
  Sum[cs[[k+1]] Nest[Y D[#,Y]&,J,k],{k,0,Length[cs]-1}]];
(* ---------- RATIONAL FACTORS OF THE INNER KERNEL AS OPERATORS (09-27 12:40; MB8au r43) ----------
   A reciprocal linear factor of the inner kernel was converted to Gamma(w+a)/Gamma(w+a+1): a contiguous upper/lower pair in
   every tower block, which the radial expansion refuses ("a radial hypergeometric block did not expand").  On Y^w it is an
   operator instead, as the polynomial is (w Y^w = Theta Y^w, Theta = Y d/dY): 1/(w+a) Y^w = (Theta+a)^(-1) Y^w, the log
   insertion of the faithful conversion and the Euler contiguous reduction of the tower lemma, applied to the closed inner
   function.  For J(Y) = int_c K(w) Y^w dw/(2 pi i) and a = a0 + a1 eps with a0 an integer,
       int_c K(w) Y^w/(w+a) dw/(2 pi i) = Y^(-a) [F(Y) - FP_(t->0) F] - Y^(-a) Cl,        F'(t) = t^(a-1) J(t),
   FP = the t^0 log^0 coefficient of the complete jet of the eps-expanded primitive.  G(t) = int_c K(w) t^(w+a)/(w+a) is a
   primitive (Y^a J_R = G(Y)); for t -> 0 it is minus the sum over the right poles q of K(w)/(w+a) of the residues of
   K(w) t^(w+a)/(w+a); poles with q0 + a0 != 0 give powers t^(q0+a0) (no finite part), and the poles at w* = -a0 at eps = 0
   (the CLUSTER) give -Cl = -sum of the residues of K(w)/(w+a) there.  The cluster is empty when -a0 lies LEFT of the contour
   (then t^(a-1) J is integrable at 0 order by order and every pole and log of the jet must cancel -- checked); when it lies
   RIGHT, Cl is the residue at w* of the eps-expansion of K(w)/(w+a) at fixed w (the integral around the cluster is analytic
   in eps).  Only J on (0, Y) is used.  The factors are applied one at a time; the cluster kernel carries the factors
   already applied; every application is gated by the contour integration of each eps-coefficient at the scale points. *)
s2SplitPolyR[f_,z_]:=Catch[Module[{fs=If[Head[f]===Times,List@@f,{f}],cnt=<||>,rest=1,P=1,keys,changed=True,guard=0,rl,lins={},out={}},
  Do[Which[MatchQ[t,Power[Gamma[_],_Integer]],cnt[Expand[t[[1,1]]]]=Lookup[cnt,Expand[t[[1,1]]],0]+t[[2]],
      MatchQ[t,Gamma[_]],cnt[Expand[t[[1]]]]=Lookup[cnt,Expand[t[[1]]],0]+1,
      FreeQ[t,z],rest=rest t,
      PolynomialQ[t,z],P=P t,
      MatchQ[t,Power[l_,k_Integer?Negative]/;PolynomialQ[l,z]&&Exponent[l,z]===1],rest=rest t,
      True,Throw[$Failed,"spr"]],{t,fs}];
  While[changed&&guard++<50,changed=False;
    keys=Keys[Select[cnt,#=!=0&]];
    Do[If[!changed&&Lookup[cnt,a,0]>0&&Lookup[cnt,b,0]<0&&Coefficient[a,z]===Coefficient[b,z]&&Coefficient[a,z]=!=0,
        With[{n=Expand[a-b]},If[IntegerQ[n]&&n=!=0,
          cnt[a]-=1;cnt[b]+=1;
          If[n>0,P=P Product[b+j,{j,0,n-1}],rest=rest/Product[a+j,{j,0,-n-1}]];
          changed=True]]],{a,keys},{b,keys}]];
  (* the reciprocal linear factors with their multiplicity; a zero of P at a pole cancels that factor *)
  rl=If[Head[rest]===Times,List@@rest,{rest}];rest=1;
  Do[If[MatchQ[t,Power[l_,k_Integer?Negative]/;PolynomialQ[l,z]&&Exponent[l,z]===1],
      Do[AppendTo[lins,Expand[t[[1]]]],{-t[[2]]}],rest=rest t],{t,rl}];
  P=Expand[P];
  Do[With[{r=-(l/.z->0)/Coefficient[l,z]},
      If[P=!=1&&Together[P/.z->r]===0,P=Expand[Together[P/l]],AppendTo[out,l]]],{l,lins}];
  {rest Times@@(Gamma[#]^cnt[#]&/@Keys[cnt]),P,out}],"spr"];
(* a fixed-letter primitive in x with the rung's word integration, the rational primitive and the derivative gate *)
s2PrimitiveT[integ_,x_,gnum_]:=Module[{terms,gt,rt,primp,dg},
  MBExactLastFold`Private`xv=x;MBExactLastFold`Private`refusal=None;
  terms=DeleteCases[List@@(Expand[integ]+Global`zzz)/.Global`zzz->0,0];
  gt=Select[terms,!FreeQ[#,PolyLogTools`G[__,x]]&];rt=Select[terms,FreeQ[#,PolyLogTools`G[__,x]]&];
  primp=Catch[Total[MBExactLastFold`Private`integrateTerm/@gt],MBExactLastFold`Private`lastfold];
  If[primp===$Failed,Throw[Failure["S2Outer",<|"Reason"->"word integration: "<>ToString[MBExactLastFold`Private`refusal]|>],"s2o"]];
  primp=Expand[(primp/.HoldPattern[PolyLogTools`G[x]]->1)+s2RatPrimitive[Total[rt],x]];
  dg=MBExactLastFold`Private`derivativeGate[primp,integ,x,gnum];
  If[!TrueQ[dg["Pass"]],Throw[Failure["S2Outer",<|"Reason"->"primitive derivative gate: "<>ToString[dg["Residual"]]|>],"s2o"]];
  With[{ex=s2ExactDerivQ[primp,integ,x,s2Back[]]},
    If[ex===False,Throw[Failure["S2Outer",<|"Reason"->"exact derivative certificate failed"|>],"s2o"]];
    If[ex==="undecided",Print["    [s2tower] exact derivative certificate undecided (RootReduce time limit); numeric gate passed"]]];
  primp];
(* one factor 1/l(w), l = s (w + a), applied to the inner Laurent coefficients Jl (orders lo..dep, functions of Y) of the
   kernel Kcl; returns the new list *)
s2RatOpApply[Jl_List,l_,Kcl_,w_,c_,Y_,lo_,dep_,gpts_]:=Module[{s=Coefficient[l,w],a,a0,a1,caseR,t=Global`s2rt,Jt,phi,Gk,Cl,JR,
    LY=Log[Y],e0v,gnum=s2Gnum,Lsym=MBExactLastFold`Private`Lsym,gate,t0=AbsoluteTime[]},
  a=Expand[(l/.w->0)/s];a0=a/.ep->0;a1=Coefficient[a,ep];
  If[Expand[a-a0-a1 ep]=!=0||!(IntegerQ[a0]||IntegerQ[2 a0])||!NumericQ[a1],
    Throw[Failure["S2Tower",<|"Reason"->"rational operator: pole "<>ToString[-a,InputForm]<>" not an integer or half-integer plus a multiple of eps"|>],"s2t"]];
  If[-a0==c,Throw[Failure["S2Tower",<|"Reason"->"rational operator: pole on the contour at eps = 0"|>],"s2t"]];
  caseR=TrueQ[-a0>c];
  (* 2026-10-01: a HALF-INTEGER pole left of the contour (c + a0 > 0) through the scale substitution
     Y = x^2: J_a(Y) = 2 Y^-a int_0^sqrt(Y) x^(2a-1) J(x^2) dx -- the primitive in x has integer powers and the letters
     {0, 1, -1}; log^n(t) = (2 log x)^n.  Certificate: the tower gate below (the differential identity (Theta+a) J_a = J
     holds by construction, the zero boundary jet is checked).  A half-integer pole right of the contour is refused. *)
  halfQ=!IntegerQ[a0];
  If[halfQ&&caseR,Throw[Failure["S2Tower",<|"Reason"->"rational operator: half-integer pole right of the contour (cluster bookkeeping not implemented)"|>],"s2t"]];
  e0v=If[NumericQ[Global`e0],Global`e0,-1/40];
  If[TrueQ[((-a/.ep->e0v)>c)]=!=caseR||TrueQ[(-a/.ep->e0v)==c],
    Throw[Failure["S2Tower",<|"Reason"->"rational operator: the pole crosses the contour between e0 and 0"|>],"s2t"]];
  If[!s2LastFoldLoadedQ[],Throw[Failure["S2Tower",<|"Reason"->"exact last-fold rung not loaded"|>],"s2t"]];
  MBExactLastFold`mbeLastFoldFibrate[0,t,1/2];   (* fresh registry; the integration variable t *)
  MBExactLastFold`Private`gatePts=First/@gpts;Clear[s2BackN];
  Jt=Table[If[Jl[[m-lo+1]]===0,0,
      Module[{f=If[halfQ,s2Fib[s2WordsToG[PowerExpand[Jl[[m-lo+1]]/.Y->t^2],t],t],s2Fib[Jl[[m-lo+1]]/.Y->t,t]]},
        If[f===$Failed||!FreeQ[f,PolyLogTools`ToFibrationBasis],Throw[Failure["S2Tower",<|"Reason"->"rational operator: fibration basis of the inner coefficient refused"|>],"s2t"]];
        Expand[f/.Log[t]->PolyLogTools`G[0,t]]]],{m,lo,dep}];
  (* phi[n,m] = F(Y) - FP_0 F for F' = log^n(t) t^(a0-1) J_m(t); half-integer a0: t stands for x = sqrt(Y), F' = 2 (2 log x)^n
     x^(2 a0 - 1) J_m(x^2), and F is evaluated at x = sqrt(Y) *)
  phi[n_,m_]:=phi[n,m]=If[Jt[[m-lo+1]]===0,0,Module[{integ,pr,jet,fp,lc,pc},
    integ=If[halfQ,Expand[2 2^n n! (PolyLogTools`G@@Append[ConstantArray[0,n],t]) t^(2 a0-1) Jt[[m-lo+1]]],
      Expand[n! (PolyLogTools`G@@Append[ConstantArray[0,n],t]) t^(a0-1) Jt[[m-lo+1]]]];
    pr=Catch[s2PrimitiveT[integ,t,gnum],"s2o"];
    If[FailureQ[pr],Throw[Failure["S2Tower",<|"Reason"->"rational operator: "<>pr["Reason"]|>],"s2t"]];
    If[MBExactLastFold`Private`backRules[]=!={},Throw[Failure["S2Tower",<|"Reason"->"rational operator: the primitive needs root placeholders"|>],"s2t"]];
    jet=Catch[s2RegLimitZero[pr,t],"s2o"];
    If[FailureQ[jet],Throw[Failure["S2Tower",<|"Reason"->"rational operator: "<>jet["Reason"]|>],"s2t"]];
    If[!caseR,
      lc=Table[gnum[Coefficient[Coefficient[jet,t,0],Lsym,j]],{j,1,Max[1,Exponent[jet,Lsym]]}];
      pc=Flatten[Table[gnum[Coefficient[Coefficient[jet,t,-k],Lsym,j]],{k,1,Max[1,-Exponent[jet,t,Min]]},{j,0,Max[0,Exponent[jet,Lsym]]}]];
      If[!AllTrue[Join[lc,pc],NumericQ[#]&&Abs[#]<10^-12&],
        Throw[Failure["S2Tower",<|"Reason"->"rational operator: the jet at 0 does not cancel for a pole left of the contour: "<>ToString[N[Join[lc,pc],6]]|>],"s2t"]]];
    fp=Coefficient[Coefficient[Expand[jet],t,0],Lsym,0];
    Expand[(pr/.t->If[halfQ,Sqrt[Y],Y])-fp]]];
  (* the cluster residues (pole right of the contour) *)
  Cl=If[!caseR,ConstantArray[0,dep-lo+1],
    Module[{d=Global`s2cd,ser,lead,res},
      ser=Quiet@Series[(Kcl/(w+a))/.w->-a0+d,{ep,0,dep}];
      If[Head[ser]=!=SeriesData,Throw[Failure["S2Tower",<|"Reason"->"rational operator: no eps-expansion of the cluster kernel"|>],"s2t"]];
      lead=ser[[4]]/ser[[6]];
      res=Table[Module[{ck=SeriesCoefficient[ser,k],sr},
          If[ck===0,0,sr=Quiet@Series[ck,{d,0,-1}];
            If[Head[sr]=!=SeriesData,Throw[Failure["S2Tower",<|"Reason"->"rational operator: cluster residue at order "<>ToString[k]|>],"s2t"]];
            Expand[SeriesCoefficient[sr,-1]]]],{k,Min[lo,lead],dep}];
      If[Min[lo,lead]<lo&&!AllTrue[Take[res,lo-Min[lo,lead]],PossibleZeroQ],
        Throw[Failure["S2Tower",<|"Reason"->"rational operator: cluster residue below the inner leading order"|>],"s2t"]];
      Take[res,-(dep-lo+1)]]];
  (* (t/Y)^(a1 eps) expanded; no 0^0 when a1 = 0 *)
  Gk=Table[phi[0,k]+If[a1===0,0,Sum[a1^n/n! phi[n,k-n],{n,1,k-lo}]]-Cl[[k-lo+1]],{k,lo,dep}];
  JR=Table[Expand[Y^(-a0)/s (Gk[[k-lo+1]]+If[a1===0,0,Sum[(-a1 LY)^j/j! Gk[[k-j-lo+1]],{j,1,k-lo}]])],{k,lo,dep}];
  (* gate: contour integration of every eps-coefficient of the new kernel at the scale points *)
  gate=Quiet@MBMellinTower`mbeMellinTowerGate[Kcl/l Y^w,w,ep,c,lo,dep,JR,{Y},gpts,600,(Null&)];
  If[!TrueQ[gate["Passed"]],
    Throw[Failure["S2Tower",<|"Reason"->"rational operator: contour gate failed: "<>ToString[N[{#["Order"],#["Point"],#["Reference"],#["Value"]}&/@gate["Rows"],8]]|>],"s2t"]];
  Print["    [s2tower] rational factor 1/(",InputForm[l],"): pole ",If[caseR,"right (cluster residue)","left"]," of the contour, gate ",
    N[Max[#["Relative"]&/@gate["Rows"]],3],", ",Round[AbsoluteTime[]-t0]," s"];
  JR];
s2TwoExp[f_,zs_]:=Total[Cases[If[Head[f]===Times,List@@f,{f}],Power[2,e_]/;!FreeQ[e,Alternatives@@zs]:>e]];
s2UndoDuplication[G_,zs_]:=Module[{g=G,guard=0,changed=False,ok,pt},
  While[guard++<6,
    Module[{e2=Expand[s2TwoExp[g,zs]],dens,nums,cand=None},
      If[e2===0||FreeQ[e2,Alternatives@@zs],Break[]];
      dens=Cases[If[Head[g]===Times,List@@g,{g}],Power[Gamma[a_],n_Integer/;n<0]:>Expand[a]];
      nums=Cases[If[Head[g]===Times,List@@g,{g}],Gamma[a_]|Power[Gamma[a_],n_Integer/;n>0]:>Expand[a]];
      Do[Module[{y=Expand[d-1/2]},
          If[cand===None&&MemberQ[nums,y]&&AnyTrue[zs,Coefficient[y,#]=!=0&&Sign[Coefficient[y,#]]===-Sign[Coefficient[e2,#]]&],cand=y]],{d,dens}];
      (* 09-27 11:40: the NUMERATOR form (MB14au r22): a slope-two numerator Gamma(2y) reaches closeTerm as
         2^(2y-1) Gamma(y) Gamma(y+1/2)/sqrt(pi); both legs in the numerator, the 2-power with the sign of y *)
      If[cand===None,
        Do[Module[{y=Expand[n1]},
            If[cand===None&&MemberQ[nums,Expand[y+1/2]]&&AnyTrue[zs,Coefficient[y,#]=!=0&&Sign[Coefficient[y,#]]===Sign[Coefficient[e2,#]]&],cand={"num",y}]],{n1,nums}];
        If[cand=!=None,
          g=g Gamma[2 cand[[2]]] Sqrt[Pi] 2^(1-2 cand[[2]])/(Gamma[cand[[2]]] Gamma[cand[[2]]+1/2]);
          g=PowerExpand[g]/.Power[2,e_]:>Power[2,Expand[e]];changed=True;Continue[]]];
      If[cand===None,Break[]];
      (* replace the factor Gamma(y)/Gamma(y+1/2) by Gamma(y)^2 2^(2y-1)/(sqrt(pi) Gamma(2y)) *)
      g=g (Gamma[cand]^2 2^(2 cand-1)/(Sqrt[Pi] Gamma[2 cand])) (Gamma[cand+1/2]/Gamma[cand]);
      g=PowerExpand[g]/.Power[2,e_]:>Power[2,Expand[e]];
      changed=True]];
  If[!changed,Return[G,Module]];
  pt=Join[Thread[zs->(1/5+I/7+Range[Length[zs]]/11)],{ep->-1/97}];
  ok=TrueQ[Abs[N[(G/.pt)-(g/.pt),30]]<10^-20 Max[1,Abs[N[G/.pt,30]]]];
  If[ok,g,G]];
s2towerTaylor[G0_,c2_,dep_]:=Module[{G=s2UndoDuplication[G0,Keys[c2]]},
  If[G=!=G0,Print["    [s2tower] Gauss multiplication undone: slope-two denominator restored"]];
  s2towerTaylorCore[G,c2,dep]];
(* SLOPE-TWO NUMERATOR (09-27 11:00; MB14au r22, r38: Gamma(1+2eps+2z) over unit legs, no slope-two denominator).
   Beta pairing with a unit numerator leg of the opposite orientation,
       Gamma(2z+c) Gamma(d-z) = Gamma(z+c+d) Int_0^1 t^(2z+c-1) (1-t)^(d-z-1) dt      (Re(2z+c), Re(d-z) > 0 on the contour),
   gives the positive scale X = t^2/(1-t) in (0, infinity) and a unit-slope inner kernel (the new leg Gamma(z+c+d)); the
   inner closed form must hold on the whole half-line (gate points on both sides of 1), and its letters pull back to
   fixed letters in t (letter -1: X + 1 = (t^2 - t + 1)/(1 - t), the sixth roots again; a letter landing inside (0,1)
   is refused by s2LetterRoots).  A unit leg of non-positive real part is raised, Gamma(d) = Gamma(d+k)/(d)_k.  The
   orientation is normalized first (z -> -z for a slope -2 leg).  Returns <|K, al, be|> (weight t^al (1-t)^be) or None. *)
s2NumExtract[G_,z_,c_,eN_]:=Module[{fs=If[Head[G]===Times,List@@G,{G}],num2,down,reVal,cands={},best,s2,d,k,cc,dd},
  reVal[x_]:=Re[N[(x/.z->c)/.eN,30]];
  num2=Cases[fs,Gamma[a_]/;Coefficient[Expand[a],z]===2:>Expand[a]];
  down=DeleteDuplicates[Cases[fs,(Gamma[a_]|Power[Gamma[a_],n_Integer?Positive])/;Coefficient[Expand[a],z]===-1:>Expand[a]]];
  Do[Module[{ra=reVal[s],rb=reVal[dl],kk},
      If[!NumericQ[ra]||!NumericQ[rb]||ra<=0,Continue[]];
      kk=If[rb>0,0,Floor[-rb]+1];
      AppendTo[cands,{{kk,-Min[ra,rb+kk]},{s,dl,kk}}]],{s,num2},{dl,down}];
  If[cands==={},Return[None,Module]];
  {s2,d,k}=First[SortBy[cands,First]][[2]];
  cc=Expand[s2-2 z];dd=Expand[d+z]+k;
  <|"K"->G/(Gamma[s2] Gamma[d]) Gamma[z+cc+dd]/Product[d+j,{j,0,k-1}],"al"->cc-1,"be"->dd-1,"Pair"->{s2,d,k}|>];
(* ---------- MULTI-FOLD SLOPE-TWO TERMS (09-27 11:05) ----------
   After the Beta undo the scale enters through ONE linear form w = L(z), the common Mellin part of the two exponents of
   the triple (two different forms would be two independent scales: refused).  A unimodular change z_k -> (w - ...)/c_k
   (c_k = +-1, Jacobian one, straight contour Re w = L(c)) makes w a variable.  The other variables carry no scale and are
   removed by Barnes' lemmas at FINITE eps (first, second, generalized when its 3F2(1) collapses; each A-gated with its
   crossed residues -- mbe_barnes_lib.m), every output stabilized (uint_close_lib.m: identities at e0 plus stable final
   terms, as in the Mellin-space route).  What remains are one-folds in w carrying the scale (the Mellin tower rung at
   the scale) and residues in w (explicit powers of Y, expanded in eps).  The inner Taylor coefficients are SUMMED over
   these items -- negative orders of single items must cancel in the sum (checked) -- and the outer fold is taken ONCE,
   on the complete inner function. *)
s2TryReduce[f_,ctr_,v_]:=Module[{r,cl},
  r=Quiet@mblBarnes1[f,v,ctr,ep,e0];
  If[AssociationQ[r]&&FreeQ[r["Terms"],ComplexInfinity|Indeterminate|_DirectedInfinity],Return[{"B1",r["Terms"]},Module]];
  r=Quiet@mblBarnes2[f,v,ctr,ep,e0];
  If[AssociationQ[r]&&FreeQ[r["Terms"],ComplexInfinity|Indeterminate|_DirectedInfinity],Return[{"B2",r["Terms"]},Module]];
  r=Quiet@mblBarnesGen[f,v,ctr,ep,e0];
  If[AssociationQ[r],cl=Quiet@FunctionExpand[r["PFQ"]];
    If[FreeQ[cl,HypergeometricPFQ]&&FreeQ[r["Terms"]/.r["PFQ"]->cl,ComplexInfinity|Indeterminate|_DirectedInfinity],
      Return[{"BG",r["Terms"]/.r["PFQ"]->cl},Module]]];
  None];
(* the Barnes reductions of every variable except keep; the scale factor Y^keep rides along (the A-gates integrate only
   the Gamma part of the reduced variable; residues in keep carry Y^(pole)); returns {{f_i, ctr_i}..} *)
s2ReduceOthers[f0_,ctr0_,keep_,Y_]:=Block[{$uSym=Y},Module[{terms,out,progress=True,pass=0,trace={}},
  terms=Catch[stabilize[f0,ctr0,0],"refuse"];
  If[!ListQ[terms],Throw[Failure["S2Tower",<|"Reason"->"stabilization of the inner integrand refused"|>],"s2t"]];
  While[progress&&pass<25,pass++;progress=False;out={};
    Do[Module[{f=t[[1]],ctr=t[[2]],r=None,vd=None},
        Do[If[v===keep,Continue[]];r=s2TryReduce[f,ctr,v];If[r=!=None,vd=v;Break[]],{v,Keys[ctr]}];
        If[vd===None,AppendTo[out,t],
          progress=True;AppendTo[trace,{Length[ctr],vd,r[[1]],Length[r[[2]]]}];
          Module[{st=Catch[Join@@(stabilize[#,DeleteCases[ctr,vd->_],0]&/@r[[2]]),"refuse"]},
            If[!ListQ[st],Throw[Failure["S2Tower",<|"Reason"->"stabilization after a Barnes lemma refused"|>],"s2t"]];
            out=Join[out,st]]]],{t,terms}];
    terms=out];
  Print["    [s2tower] inner Barnes reductions (keeping the scale variable ",keep,"): ",InputForm[DeleteDuplicates[trace]],"; items: ",Length[terms]," with folds ",Tally[Length[#[[2]]]&/@terms]];
  terms]];
(* Laurent coefficients lo..dep (functions of Y) of ONE inner item: a one-fold in w with the scale, or a residue in w *)
s2ItemLaurent[f_,ctr_,w_,Y_,lo_,dep_,dom_,gpts_]:=Module[{},
  Which[
    ctr==={},
      Module[{s},
        If[FreeQ[f,ep],Return[Table[If[k==0,f,0],{k,lo,dep}],Module]];
        s=Quiet@Series[f,{ep,0,dep}];
        If[Head[s]=!=SeriesData,Throw[Failure["S2Tower",<|"Reason"->"zero-fold inner item: no Laurent series"|>],"s2t"]];
        If[s[[4]]/s[[6]]<lo,Throw[Failure["S2Tower",<|"Reason"->"zero-fold inner item starts below eps^"<>ToString[lo]|>],"s2t"]];
        Table[Expand[SeriesCoefficient[s,k]],{k,lo,dep}]],
    Keys[ctr]==={w},
      Module[{c=w/.ctr,fK=Together[f/Y^w],Kf,Pz,Rl,sp,kernels,J=ConstantArray[0,dep-lo+1],Kcl,towerSum},
        If[!FreeQ[fK,Y],Throw[Failure["S2Tower",<|"Reason"->"inner item: the scale enters other than as Y^w"|>],"s2t"]];
        sp=s2SplitPolyR[fK,w];
        If[sp===$Failed,Throw[Failure["S2Tower",<|"Reason"->"inner integrand not a Gamma product times a rational function"|>],"s2t"]];
        {Kf,Pz,Rl}=sp;
        If[!FreeQ[Kf/.Gamma[_]->1,w],Throw[Failure["S2Tower",<|"Reason"->"non-Gamma w-dependence left: "<>ToString[Short[Kf,4],InputForm]|>],"s2t"]];
        If[AnyTrue[Cases[Kf,Gamma[q_]:>q,{0,Infinity}],Abs[Coefficient[#,w]]>=2&],
          Throw[Failure["S2Tower",<|"Reason"->"slope-two legs left after the triple and the polynomial reduction: "<>ToString[Short[Kf,4],InputForm]|>],"s2t"]];
        (* the polynomial: P(Y d/dY) on the ONE closure of the Gamma part; absorption into unit-slope legs only when the Gamma
           part carries exactly coincident legs (the tower rung refuses them, absorption splits them) *)
        (* 2026-10-01: absorption FIRST whenever the polynomial factors into linear factors over the rationals
           (MB8au r43 pieces 34/39: P of degree 3 applied as P(Y d/dY) gave an order-1 outer integrand of 2365 word terms
           and a 600k-leaf primitive, past the 2400 s budget; absorbed, the same piece is a sum of a few plain Gamma
           kernels, each a tower closure without derivatives); the operator remains the fallback *)
        If[Pz=!=1,Module[{ab},
          ab=TimeConstrained[s2AbsorbPoly[Kf,Pz,w],120,$Failed];
          If[ab=!=$Failed,Print["    [s2tower] polynomial factor P = ",InputForm[Pz]," absorbed into the legs (",Length[If[Head[ab]===Plus,List@@ab,{ab}]]," Gamma kernels)"];Kf=ab;Pz=1,
            Print["    [s2tower] polynomial factor P = ",InputForm[Pz]," applied as P(Y d/dY)"]]]];
        towerSum[kf_,pz_]:=Module[{JJ=ConstantArray[0,dep-lo+1]},
          Do[Module[{Jser},
              Jser=Quiet@TimeConstrained[MBMellinTower`mbeMellinLaurent[kk Y^w,w,ep,c,lo,dep,{Y},dom,"GatePoints"->gpts,"Log"->(Null&)],Max[900,closeSeconds],$Aborted];
              If[Jser===$Aborted||FailureQ[Jser]||!FreeQ[Jser,MBMellinTower`mbeMellinLaurent|_MBint|HypergeometricPFQ|$Failed]||!FreeQ[Jser,s_Symbol/;StringContainsQ[SymbolName[Unevaluated[s]],"Failed"]],
                Print["    [s2tower] inner integrand ",InputForm[kk]," on ",InputForm[ctr]];
                Print["    [s2tower] inner tower refusal ",InputForm[If[FailureQ[Jser],Lookup[Jser[[2]],"Detail",Jser],Jser]]];
                Throw[Failure["S2Tower",<|"Reason"->"inner Mellin tower refused: "<>ToString[Short[Jser,4],InputForm]|>],"s2t"]];
              If[pz=!=1,Jser=Expand[s2PolyOperator[pz,w,Jser,Y]]];
              JJ+=Table[Coefficient[Expand[Jser],ep,k],{k,lo,dep}]],{kk,If[Head[kf]===Plus,List@@kf,{kf}]}];
          JJ];
        J=Catch[towerSum[Kf,Pz],"s2t"];
        (* 2 October 2026: the tower refused the Gamma part with a polynomial as an operator -> the linear factors of the
           polynomial into the legs (other Gamma kernels, other tower bases), the irreducible remainder as the operator *)
        If[FailureQ[J]&&Pz=!=1,
          Module[{pa=TimeConstrained[s2AbsorbPolyPartial[Kf,Pz,w],120,$Failed]},
            If[pa=!=$Failed&&Head[Kf]=!=Plus,
              Print["    [s2tower] inner tower refused with P as an operator; its linear factors absorbed into the legs (",Length[If[Head[pa[[1]]]===Plus,List@@pa[[1]],{pa[[1]]}]]," Gamma kernels), the factor ",InputForm[pa[[2]]]," as P(Y d/dY)"];
              Kf=pa[[1]];Pz=pa[[2]];
              J=Catch[towerSum[Kf,Pz],"s2t"]]]];
        If[FailureQ[J],Throw[J,"s2t"]];
        If[!FreeQ[J,ep],Throw[Failure["S2Tower",<|"Reason"->"inner Laurent not a polynomial in eps"|>],"s2t"]];
        (* the reciprocal linear factors: (Theta + a)^(-1) one at a time, the cluster kernel carrying those already applied *)
        If[Rl=!={},
          Print["    [s2tower] rational factor ",InputForm[1/Times@@Rl]," applied as (Y d/dY + a)^-1 on the closed inner function"];
          Kcl=Kf Pz;
          Do[J=s2RatOpApply[J,l,Kcl,w,c,Y,lo,dep,gpts];Kcl=Kcl/l,{l,Rl}]];
        J],
    True,Throw[Failure["S2Tower",<|"Reason"->"Mellin variables other than the scale left after the Barnes reductions: "<>ToString[Keys[ctr]]|>],"s2t"]]];
s2towerTaylorCore[G0_,c20_,dep_]:=Catch[Module[{G=G0,c2=c20,zs=Keys[c20],eN,ex,v,dfac,al,be,mode="den",Kraw,scaleS,dom,gpts,
    L,w,ctrW,items,lo,Jtot,wser,out,t0=AbsoluteTime[],Y=Global`s2Y},
  If[DownValues[MBMellinTower`mbeMellinLaurent]==={},Throw[Failure["S2Tower",<|"Reason"->"Mellin-tower rung not loaded"|>],"s2t"]];
  eN=ep->Global`fcuSafeEps[G,zs,Normal[c2],ep];
  ex=fcuS2Extract[G,zs,Normal[c2],eN,ep];
  If[ex===None,
    (* no slope-two denominator: a slope-two NUMERATOR (one-fold; orientation normalized, z -> -z maps Re z = c to -c) *)
    If[Length[zs]=!=1,Throw[Failure["S2Tower",<|"Reason"->"no slope-two triple (a multi-fold slope-two numerator is not in the class yet)"|>],"s2t"]];
    Module[{z=zs[[1]],c=c2[[1,2]],nx},
      If[!FreeQ[G,Gamma[q_]/;Coefficient[Expand[q],z]===-2]&&FreeQ[G,Gamma[q_]/;Coefficient[Expand[q],z]===2],
        G=G/.z->-z;c=-c;c2={z->c};Print["    [s2tower] orientation normalized (z -> -z) for the slope-two numerator"]];
      nx=s2NumExtract[G,z,c,eN];
      If[nx===None,Throw[Failure["S2Tower",<|"Reason"->"no slope-two triple and no numerator pair"|>],"s2t"]];
      mode="num";v=Global`fcs2t;Kraw=nx["K"];al=nx["al"];be=nx["be"];L=z;
      Print["    [s2tower] slope-two NUMERATOR: Beta pair ",InputForm[nx["Pair"]],", scale t^2/(1-t)"]],
    If[Length[ex[[3]]]=!=1,Throw[Failure["S2Tower",<|"Reason"->"more than one triple"|>],"s2t"]];
    v=ex[[3,1]];dfac=ex[[2]];
    (* dfac = v^(g1-1) (1-v)^(g2-1): the Mellin parts of both exponents must be ONE linear form L (the scale Y^L) *)
    Module[{e1=Cases[dfac,Power[v,e_]:>e,{0,Infinity}],e2=Cases[dfac,Power[1-v,e_]:>e,{0,Infinity}],L1,L2},
      If[Length[e1]=!=1||Length[e2]=!=1,Throw[Failure["S2Tower",<|"Reason"->"Beta dressing not v^a (1-v)^b: "<>ToString[dfac,InputForm]|>],"s2t"]];
      L1=Expand[e1[[1]]-(e1[[1]]/.Thread[zs->0])];L2=Expand[e2[[1]]-(e2[[1]]/.Thread[zs->0])];
      If[L1===0||Expand[L1-L2]=!=0,Throw[Failure["S2Tower",<|"Reason"->"triple exponents with different Mellin parts (two scales): "<>ToString[ex[[4]],InputForm]|>],"s2t"]];
      L=L1;al=Expand[e1[[1]]/.Thread[zs->0]];be=Expand[e2[[1]]/.Thread[zs->0]]];
    Kraw=ex[[1]]];
  (* a caller's dressing of the INNER kernel (the piece closer: regulated copies), applied after the Beta structure is fixed *)
  (* 09-27 16:10: the hook receives the Mellin VARIABLE of a one-fold (its leg tests use Coefficient[., w]; with the scale
     form L = -z they recognized no leg of slope +1, so integer-distance legs of the inner kernel stayed unmerged: MB14bu r28,
     inner tower Indeterminate) *)
  If[ValueQ[$s2InnerHook]&&$s2InnerHook=!=None,Kraw=$s2InnerHook[Kraw,If[Length[zs]===1,zs[[1]],L]]];
  (* the scale variable w = L: a unimodular change when L is not a single variable *)
  If[MemberQ[zs,L],w=L;ctrW=c2,
    Module[{k=SelectFirst[zs,MemberQ[{1,-1},Coefficient[L,#]]&,None],ck},
      If[k===None,Throw[Failure["S2Tower",<|"Reason"->"scale form without a unit coefficient: "<>ToString[L,InputForm]|>],"s2t"]];
      ck=Coefficient[L,k];w=Unique["Global`s2w"];
      Kraw=Kraw/.k->Expand[(w-(L-ck k))/ck];ctrW=Append[DeleteCases[c2,k->_],w->Expand[L/.c2]];
      Print["    [s2tower] scale variable ",w," = ",InputForm[L]," (unimodular change of ",k,")"]]];
  If[mode==="den",scaleS=v-v^2;dom=0<Y<1/4;gpts={{1/7},{1/5}},scaleS=v^2/(1-v);dom=0<Y;gpts={{1/5},{3}}];
  (* the inner items: the other Mellin variables Barnes-reduced at finite eps (one-folds: nothing to reduce) *)
  items=If[Length[ctrW]===1,{{Kraw Y^w,ctrW}},s2ReduceOthers[Kraw Y^w,ctrW,w,Y]];
  lo=If[Length[items]===1,0,-4];
  Jtot=ConstantArray[0,dep-lo+1];
  Do[Jtot+=s2ItemLaurent[it[[1]],it[[2]],w,Y,lo,dep,dom,gpts],{it,items}];
  (* poles of single items cancel in the sum (the term is holomorphic at eps = 0): checked at two scale points *)
  If[lo<0,Module[{neg=Table[N[Jtot[[k-lo+1]]/.Y->#,30],{k,lo,-1}]&/@{1/7,1/5}},
    If[!AllTrue[Flatten[neg],NumericQ[#]&&Abs[#]<10^-15&],Throw[Failure["S2Tower",<|"Reason"->"inner items: negative orders do not cancel: "<>ToString[N[neg,6]]|>],"s2t"]]]];
  Jtot=Drop[Jtot,-lo];
  Print["    [s2tower] inner J(Y) closed (",Length[items]," item(s), ",Round[AbsoluteTime[]-t0]," s, leaves ",LeafCount[Jtot],")"];
  (* the Series-of-a-constant trap: an eps-free weight (the pieces) is not a SeriesData, and SeriesCoefficient of it stays
     unevaluated -- polynomial coefficient extraction then *)
  wser=Table[With[{sw=Quiet@Series[v^al (1-v)^be,{ep,0,dep}]},If[Head[sw]===SeriesData,SeriesCoefficient[sw,j],Coefficient[Expand[v^al (1-v)^be],ep,j]]],{j,0,dep}];
  (* the outer fold, ONCE on the complete inner function: the package's exact last fold on pulled-back words; the Euler
     cube (IntVolIntegrate) as the fallback *)
  out=s2OuterExact[Jtot,wser,dep,Y,v,scaleS];
  If[!(ListQ[out]&&Length[out]===dep+1),
    Print["    [s2tower] exact outer fold refused (",If[FailureQ[out],out["Reason"],ToString[Short[out,2]]],"): Euler-cube fallback"];
    If[TrueQ[$s2NoCubeFallback]||mode=!="den",Throw[Failure["S2Tower",<|"Reason"->"exact outer fold refused: "<>If[FailureQ[out],out["Reason"],"?"]|>],"s2t"]];
    Module[{eus=Table[s2ToEuler[Jtot[[m]],Y],{m,dep+1}]},
      If[MemberQ[eus,$Failed],Throw[Failure["S2Tower",<|"Reason"->"inner J(Y) not convertible to an Euler integrand"|>],"s2t"]];
      out=Table[Module[{integ,vars,r,red},
          integ=Expand[Sum[wser[[j+1]] eus[[k-j+1,1]],{j,0,k}]/.Y->v-v^2];
          If[integ===0,0,
            vars=Select[Join[{v},Union@@Table[eus[[k-j+1,2]],{j,0,k}]],!FreeQ[integ,#]&];
            r=s2IVF[integ,vars];
            If[r===$Failed,Throw[Failure["S2Tower",<|"Reason"->"outer IntVolIntegrate refused at order "<>ToString[k]|>],"s2t"]];
            red=uintL6Reduce[r["Value"]];
            If[red===$Failed,Throw[Failure["S2Tower",<|"Reason"->"sixth-root reduction refused at order "<>ToString[k]|>],"s2t"]];
            red]],{k,0,dep}]]];
  out=Table[Global`mbeCanonicalConstants[Expand[o]],{o,out}];
  Do[Print["    [s2tower] order ",k-1,": value ",N[out[[k]],16]],{k,dep+1}];
  Print["    [s2tower] done (",Round[AbsoluteTime[]-t0]," s total)"];
  out],"s2t"];
(* ---------- slope-two PIECES (09-27 11:14) ----------
   The multi-fold closer of the Mellin-space route expands a term at fixed contours (MBexpand) and applies the Barnes lemmas
   at eps = 0 (DoAllBarnes), where patterns appear that the finite-eps lemmas do not see (MB8au r43: the z7 legs
   Gamma(-eps-z7)/Gamma(-2eps-z7) become 1 only at eps = 0).  Its eps-free one-fold pieces with slope-two legs defeated the
   ladder (wrong values, caught by the new gate) and the engine (wrong "clean" values, caught by the piece gates).  In the
   171 such pieces of the job directories the dressing has degree <= 1 in 157: psi(L) K = d/de [K Gamma(L+e)/Gamma(L)] at
   e = 0, and the piece being eps-free, the regulator e is played by ep: the slope-two closer at depth 1 returns the piece
   as its order-1 Taylor coefficient (depth 0 without dressing).  Degree two (psi', psi psi) is refused for now.  Every
   value is gated by the 1-dim contour quadrature (relative 1e-10), like every worker value. *)
(* coincident unit-slope legs of the inner kernel, Gamma(L)^p -> Gamma(L) Gamma(L + nu ep) ... Gamma(L + (p-1) nu ep): the
   integral is analytic in the shifts (no pole crosses the fixed contour), so its value at ep = 0 is the unsplit one *)
(* 09-27 v6: INTEGER-DISTANCE LEGS of one orientation ("coincident tower bases beyond the degenerate-pair class"): the
   numerator legs Gamma(s w + c) of one slope s whose offsets differ by integers (same eps part) are merged into ONE base
   power times a polynomial, Gamma(B + n) = (B)_n Gamma(B) with B the leg of smallest offset (n >= 0, no new poles); the
   exact power is then split by s2SplitCoincident.  Denominator legs are left alone (no poles). *)
s2MergeIntegerLegs[K_,w_]:=Catch[Module[{fs=If[Head[K]===Times,List@@K,{K}],legs={},rest=1,cls,out=1,poly=1,off},
  Do[Which[
      MatchQ[t,Gamma[a_]/;MemberQ[{1,-1},Coefficient[Expand[a],w]]],AppendTo[legs,{Expand[t[[1]]],1}],
      MatchQ[t,Power[Gamma[a_],p_Integer/;p>0]/;MemberQ[{1,-1},Coefficient[Expand[a],w]]],AppendTo[legs,{Expand[t[[1,1]]],t[[2]]}],
      True,rest=rest t],{t,fs}];
  (* offset class: the eps part and the fractional part of the eps-free offset (Floor, so 1/2 and 3/2 share a class) *)
  off[a_]:=Expand[a/.w->0];
  cls=GatherBy[legs,{Coefficient[#[[1]],w],Expand[off[#[[1]]]-Floor[off[#[[1]]]/.ep->0]]}&];
  Do[Module[{base=First[SortBy[c,(off[#[[1]]]/.ep->0)&]][[1]],k=Total[c[[All,2]]]},
      Do[With[{n=Expand[l[[1]]-base]},If[!IntegerQ[n]||n<0,Throw[$Failed,"s2m"]];poly=poly Pochhammer[base,n]^l[[2]]],{l,c}];
      out=out Gamma[base]^k],{c,cls}];
  {out rest,Expand[FunctionExpand[poly]]}],"s2m"];
s2NormalizeInner[Kin_,w_,nu_]:=Module[{m=s2MergeIntegerLegs[Kin,w]},
  If[m===$Failed,s2SplitCoincident[Kin,w,nu],s2SplitCoincident[m[[1]],w,nu] m[[2]]]];
s2SplitCoincident[K_,w_,nu_]:=Times@@(Function[t,Which[
    MatchQ[t,Power[Gamma[a_],p_Integer/;p>=2]/;Abs[Coefficient[Expand[a],w]]===1],
      With[{a=t[[1,1]],p=t[[2]]},Gamma[a] Product[Gamma[a+j nu ep],{j,1,p-1}]],
    True,t]]/@If[Head[K]===Times,List@@K,{K}]);
s2PieceClose[F_,ctr_List]:=Module[{z,fs,pg,K,psiL=None,run,r1,r2},
  If[Length[ctr]=!=1||!FreeQ[F,ep],Return[Failure["S2Piece",<|"Reason"->"one-fold eps-free pieces only"|>],Module]];
  z=ctr[[1,1]];fs=If[Head[F]===Times,List@@F,{F}];
  pg=Select[fs,!FreeQ[#,PolyGamma]&];
  Which[
    pg==={},Null,
    Length[pg]===1&&MatchQ[pg[[1]],PolyGamma[0,a_]/;Abs[Coefficient[Expand[a],z]]===1],psiL=pg[[1,2]],
    (* 09-27 v6: psi of the argument of a slope-two LEG of the kernel (the Beta denominator or a numerator): the copy
       rides on that leg itself (s2PsiLegClose) *)
    Length[pg]===1&&MatchQ[pg[[1]],PolyGamma[0,a_]/;Abs[Coefficient[Expand[a],z]]===2]&&
      MemberQ[{-1,1},s2LegPower[F/pg[[1]],pg[[1,2]]]],Return[s2PsiLegClose[F,ctr],Module],
    Length[pg]===1&&MatchQ[pg[[1]],PolyGamma[_Integer,a_]/;Abs[Coefficient[Expand[a],z]]>=2],Return[s2PsiIntClose[F,ctr],Module],
    True,Return[Failure["S2Piece",<|"Reason"->"polygamma dressing outside the class (degree >= 2, or psi' of a unit argument): "<>ToString[pg,InputForm]|>],Module]];
  K=F/(Times@@pg);
  (* no slope-two Gamma left once same-slope integer-distance pairs cancel (Gamma(1+2z)/Gamma(2z) = 2z): a unit-slope
     piece, closed by the Barnes closed forms *)
  If[With[{sp=s2SplitPoly[K,z]},sp=!=$Failed&&!AnyTrue[Cases[sp[[1]],Gamma[q_]:>q,{0,Infinity}],Abs[Coefficient[#,z]]>=2&]],
    Return[Catch[s2UnitPieceValue[F,ctr],"s2p"],Module]];
  (* the dressing rides on the INNER kernel (after the Beta structure is fixed): coincident legs split with nu = 1/7,
     the polygamma as the copy Gamma(L + kappa ep)/Gamma(L); two samples kappa = 1, 2 with the same splitting: the
     order-1 difference is the polygamma term exactly (the splitting derivatives cancel), the order-0 parts agree *)
  (* 09-27 16:10: integer-distance legs merged first (s2NormalizeInner, as in s2PsiLegClose), then split *)
  run[kap_,dep_]:=Block[{$s2InnerHook=Function[{Kin,w},s2NormalizeInner[Kin If[psiL===None,1,Gamma[psiL+kap ep]/Gamma[psiL]],w,1/7]]},
    s2towerTaylor[K,ctr,dep]];
  If[psiL===None,
    r1=run[1,0];If[FailureQ[r1],r1,r1[[1]]],
    r1=run[1,1];If[FailureQ[r1],Return[r1,Module]];
    r2=run[2,1];If[FailureQ[r2],Return[r2,Module]];
    If[!TrueQ[Abs[N[r1[[1]]-r2[[1]],30]]<10^-20],Return[Failure["S2Piece",<|"Reason"->"sample orders 0 disagree"|>],Module]];
    Global`mbeCanonicalConstants[Expand[r2[[2]]-r1[[2]]]]]];
(* PSI OF A SLOPE-k ARGUMENT ON A UNIT-SLOPE KERNEL (09-27 11:28; 5 of 12 sampled pieces: Gamma(1+2z)/Gamma(2z) = 2z has
   cancelled, psi(1+2z), psi(2z), psi'(1+2z) remain).  For Re x > 0,
       psi(x) = -gamma + Int_0^1 (1 - t^(x-1))/(1-t) dt,    psi^(m)(x) = (-1)^(m+1) Int_0^1 t^(x-1) log^m(t)/(1-t) dt  (m >= 1),
   and with x = k z + c0 the Mellin variable enters through (t^k)^z: the piece is an outer t-integral of J(X) = Int X^z K(z)
   (unit-slope kernel, scale X = t^k in (0,1), the Mellin tower rung; coincident legs split by a regulator) plus, for
   m = 0, the constant J(1) = Int K (Barnes closed forms).  A contour with Re x <= 0 is moved by psi(x) = psi(x+n) -
   sum_j 1/(x+j): the rational pieces go to the Barnes closed forms.  The t-integral is the exact outer fold with the
   pullback S = t^k (letters 0 and the k-th roots of the inner letters; a root inside (0,1) is refused). *)
s2UnitPieceValue[K0_,ctr_]:=Module[{K=K0,b,fs,pg,sp},
  (* same-slope integer-distance pairs first (Gamma(1+2z)/Gamma(2z) = 2z): the Barnes closed forms refuse slope-two legs *)
  fs=If[Head[K0]===Times,List@@K0,{K0}];pg=Times@@Select[fs,!FreeQ[#,PolyGamma]&];
  sp=s2SplitPoly[K0/pg,ctr[[1,1]]];If[sp=!=$Failed,K=pg sp[[1]] sp[[2]]];
  b=If[DownValues[Global`b22Gated]=!={},Quiet@Global`b22Gated[K,ctr,300],$Failed];
  If[!AssociationQ[b]&&DownValues[Global`bgGated]=!={},b=Quiet@Global`bgGated[K,ctr,600]];
  If[AssociationQ[b],b["Value"],Throw[Failure["S2Piece",<|"Reason"->"unit-slope sub-piece not closed by the Barnes closed forms"|>],"s2p"]]];
s2PsiIntClose[F_,ctr_List]:=Catch[Module[{z=ctr[[1,1]],c=ctr[[1,2]],fs,pg,m,arg,k,c0,K,sp,Kg,P,X=Global`s2X,t=Global`s2pt,
    n=0,ratSum=0,Jser,J0,J1,res,val},
  fs=If[Head[F]===Times,List@@F,{F}];pg=Select[fs,!FreeQ[#,PolyGamma]&];
  If[Length[pg]=!=1||!MatchQ[pg[[1]],PolyGamma[_Integer,_]],Throw[Failure["S2Piece",<|"Reason"->"psi-integral class: one polygamma factor"|>],"s2p"]];
  {m,arg}={pg[[1,1]],Expand[pg[[1,2]]]};k=Coefficient[arg,z];
  If[!IntegerQ[k]||Abs[k]<2,Throw[Failure["S2Piece",<|"Reason"->"psi-integral class: slope >= 2"|>],"s2p"]];
  If[k<0,Throw[s2PsiIntClose[F/.z->-z,{z->-c}],"s2p"]];
  c0=Expand[arg/.z->0];
  If[!IntegerQ[c0],Throw[Failure["S2Piece",<|"Reason"->"psi-integral class: non-integer offset "<>ToString[c0,InputForm]|>],"s2p"]];
  K=F/pg[[1]];
  (* Re x > 0 on the contour: psi^(m)(x) = psi^(m)(x+n) - (-1)^m m! sum_j 1/(x+j)^(m+1) *)
  While[k c+c0+n<=0,n++];
  If[n>0,ratSum=Sum[(-1)^m m! s2UnitPieceValue[Together[K/(arg+j)^(m+1)],ctr],{j,0,n-1}];c0=c0+n;arg=arg+n];
  sp=s2SplitPoly[K,z];
  If[sp===$Failed,Throw[Failure["S2Piece",<|"Reason"->"psi-integral class: kernel not a Gamma product times a polynomial"|>],"s2p"]];
  {Kg,P}=sp;
  If[AnyTrue[Cases[Kg,Gamma[q_]:>q,{0,Infinity}],Abs[Coefficient[#,z]]>=2&],Throw[Failure["S2Piece",<|"Reason"->"psi-integral class: slope-two legs in the kernel"|>],"s2p"]];
  Jser=Quiet@TimeConstrained[MBMellinTower`mbeMellinLaurent[s2SplitCoincident[Kg,z,1/7] X^z,z,ep,c,0,0,{X},0<X<1,"GatePoints"->{{1/7},{1/2}},"Log"->(Null&)],Max[900,closeSeconds],$Aborted];
  If[Jser===$Aborted||FailureQ[Jser]||!FreeQ[Jser,MBMellinTower`mbeMellinLaurent|_MBint|HypergeometricPFQ|$Failed],
    Throw[Failure["S2Piece",<|"Reason"->"psi-integral class: inner tower refused: "<>ToString[Short[Jser,3],InputForm]|>],"s2p"]];
  J0=Coefficient[Expand[Jser],ep,0];
  If[P=!=1,J0=Expand[s2PolyOperator[P,z,J0,X]]];
  res=If[m==0,
    J1=s2UnitPieceValue[K,ctr];
    s2OuterExact[{J0},{-t^(c0-1)/(1-t)},0,X,t,t^k,J1/(1-t)],
    (* 2 October 2026: psi^(m)(a) = -Int_0^1 t^(a-1) log^m(t)/(1-t) dt for EVERY m >= 1 (the earlier sign (-1)^(m+1) was
       wrong for odd m: every psi' piece was refused by its gate) *)
    s2OuterExact[{J0},{-t^(c0-1) Log[t]^m/(1-t)},0,X,t,t^k]];
  If[!(ListQ[res]&&Length[res]===1),Throw[Failure["S2Piece",<|"Reason"->"psi-integral class: outer fold: "<>If[FailureQ[res],res["Reason"],"?"]|>],"s2p"]];
  (* psi^(m)(x) = psi^(m)(x+n) - (-1)^m m! sum_j 1/(x+j)^(m+1): the rational pieces are SUBTRACTED *)
  val=res[[1]]+If[m==0,-EulerGamma J1,0]-ratSum;
  Global`mbeCanonicalConstants[Expand[val]]],"s2p"];
(* ---------- PSI ON A SLOPE-TWO LEG (09-27 v6; MB14bu r61: 5 Gamma(1-z)Gamma(-1+z)^2 Gamma(-z)Gamma(z)^2 psi(-1+2z)/Gamma(-1+2z))
   The polygamma of the argument L of a slope-two leg Gamma(L)^(+-1) of the kernel is a regulator derivative on that leg,
       psi(L)/Gamma(L) = -d/de [1/Gamma(L+e)],   psi(L) Gamma(L) = d/de Gamma(L+e)    (e = 0),
   and with e = kappa ep the piece is -T_1/kappa (resp. +T_1/kappa), T_k the Taylor coefficients of the regulated one-fold
   by the slope-two closer: the Beta triple takes the eps-offset partner (fcuS2Extract v6: B(a, b + e) and the unit-slope
   copy Gamma(b)/Gamma(b+e) on the inner kernel), or the numerator pair carries e in its weight.  Two samples kappa = 1, 2:
   T_0 must agree (the undressed piece), T_1 must scale with kappa. *)
s2LegPower[K_,L_]:=Module[{fs=If[Head[K]===Times,List@@K,{K}],Le=Expand[L]},
  Total[Join[Cases[fs,Power[Gamma[q_],n_Integer]/;Expand[q]===Le:>n],Cases[fs,Gamma[q_]/;Expand[q]===Le:>1]]]];
s2PsiLegClose[F_,ctr_List]:=Catch[Module[{z=ctr[[1,1]],fs,pg,L,K,p,sgn,Fk,r,t0=AbsoluteTime[]},
  fs=If[Head[F]===Times,List@@F,{F}];pg=Select[fs,!FreeQ[#,PolyGamma]&];
  L=Expand[pg[[1,2]]];K=F/pg[[1]];p=s2LegPower[K,L];
  Which[p===-1,sgn=-1;Fk[kap_]:=K Gamma[L]/Gamma[L+kap ep],
        p===1,sgn=1;Fk[kap_]:=K Gamma[L+kap ep]/Gamma[L],
        True,Throw[Failure["S2Piece",<|"Reason"->"psi on a slope-two leg: leg power not +-1"|>],"s2l"]];
  (* coincident unit legs of the inner kernel are split by nu ep (nu = 1/7, as in s2PieceClose); the splitting adds the
     same kappa-independent part S to every T_1, so T_1(kappa) = kappa X + S: X = T_1(2) - T_1(1), checked by kappa = 3 *)
  r=Table[With[{t=Block[{$s2InnerHook=Function[{Kin,w},s2NormalizeInner[Kin,w,1/7]]},s2towerTaylor[Fk[kap],ctr,1]]},
      If[FailureQ[t],Throw[Failure["S2Piece",<|"Reason"->"psi on a slope-two leg: "<>t["Reason"]|>],"s2l"]];t],{kap,{1,2,3}}];
  If[!TrueQ[Abs[N[r[[1,1]]-r[[2,1]],30]]<10^-20 Max[1,Abs[N[r[[1,1]],30]]]&&Abs[N[r[[1,1]]-r[[3,1]],30]]<10^-20 Max[1,Abs[N[r[[1,1]],30]]]],
    Throw[Failure["S2Piece",<|"Reason"->"psi on a slope-two leg: sample orders 0 disagree"|>],"s2l"]];
  If[!TrueQ[Abs[N[(r[[3,2]]-r[[2,2]])-(r[[2,2]]-r[[1,2]]),30]]<10^-20 Max[1,Abs[N[r[[2,2]]-r[[1,2]],30]]]],
    Throw[Failure["S2Piece",<|"Reason"->"psi on a slope-two leg: order 1 not linear in the copy"|>],"s2l"]];
  Print["    [s2leg] psi on the slope-two leg ",InputForm[L]," (power ",p,"): closed in ",Round[AbsoluteTime[]-t0]," s"];
  Global`mbeCanonicalConstants[Expand[sgn (r[[2,2]]-r[[1,2]])]]],"s2l"];
s2PieceSlope2Q[F_,ctr_List]:=Length[ctr]===1&&AnyTrue[Cases[F,Gamma[a_]|PolyGamma[_,a_]:>a,{0,Infinity}],Abs[Coefficient[Expand[#],ctr[[1,1]]]]===2&];
s2PieceGated[F_,ctr_List,sec_:900]:=Module[{v,q,z,c,tt},
  If[!s2PieceSlope2Q[F,ctr],Return[Failure["S2Piece",<|"Reason"->"no slope-two leg"|>],Module]];
  z=ctr[[1,1]];c=ctr[[1,2]];
  v=TimeConstrained[s2PieceClose[F,ctr],sec,Failure["S2Piece",<|"Reason"->"time limit"|>]];
  If[FailureQ[v],Return[v,Module]];
  q=Quiet@TimeConstrained[NIntegrate[(F/.z->c+I tt)/(2 Pi),{tt,-60,60},WorkingPrecision->30,PrecisionGoal->14,MaxRecursion->40],300,$TimedOut];
  If[!TrueQ[NumericQ[q]&&NumericQ[N[v,30]]&&Abs[N[v,40]-q]<10^-10 Max[1,Abs[q]]],
    Return[Failure["S2Piece",<|"Reason"->"gate: "<>ToString[N[v,15]]<>" vs quadrature "<>ToString[N[q,15]]|>],Module]];
  <|"Value"->v,"Quad"->q|>];
(* ---------- UNIT-SLOPE PIECES THROUGH THE SCALE (09-27 12:55; MB8au r12 p3) ----------
   An eps-free one-fold piece K(z) prod_j psi(L_j) with unit slopes whose residue sums diverge (a kernel growing along the
   real axis, e.g. (pi/sin pi z)^2 x rational x psi^2: the trig rung finds no closing side, the regulated tower refuses the
   marginal blocks) is the Abel limit Y -> 1 of J(Y) = int_c K prod psi(L_j) Y^z: J is continuous on (0,1] (|Y^z| = Y^c,
   exponential decay in Im z).  Each polygamma is a regulator derivative of a Gamma copy, psi(L) = d/de Gamma(L+e)/Gamma(L)
   at e = 0, with a distinct multiple a_j of ep per factor; coincident legs are split by nu ep; the mixed difference over
   the subsets S of the copies, sum_S (-1)^(d-|S|) F_S, at order ep^d equals (prod a_j) int K prod psi(L_j) (every other
   term lacks a copy or is of higher order).  Each F_S is closed at the scale by s2ItemLaurent (Mellin tower; polynomial
   and rational factors as operators, gated), the limit Y -> 1 is the complete jet at 1 (every pole and log must cancel),
   and the piece value is gated by its contour quadrature (s2UnitPieceGated). *)
(* 2026-10-01: the functions of a HALF-INTEGER tower as G words in x = Sqrt[Y].  The Mellin tower rung returns
   HPL`HPL words at the argument Sqrt[Y] in the HPL package's "simpler argument" alphabet, whose indices plus and minus
   are the letter COMBINATIONS f_plus = f_1 + f_(-1), f_minus = f_1 - f_(-1) (checked: H(plus; x) = log((1+x)/(1-x)),
   H(minus; x) = -log(1-x^2), H(0,plus; x) = Li2(x) - Li2(-x)); by multilinearity every such index is expanded into the
   two standard indices, PolyLogTools' HPLToG gives the G words (polylogarithms of +-x and logarithms where it prefers
   them), and those are written as words with the letters {0, 1, -1}.  The conversion is checked numerically at x = 1/3. *)
(* an HPL word as G words WITHOUT evaluating anything of the HPL package (its automatic conversions -- and HypExp, once
   loaded, changes them globally -- rewrite words into polylogarithms of x^2, 1-x^2, ..): compressed indices m -> 0^(|m|-1)
   sign(m), the indices plus/minus expanded multilinearly, and H(a; x) = (-1)^(number of indices +1) G(a; x) *)
(* the HPL package's automatic conversions decide the FORM of the Mellin tower rung's output on return (HypExp, once loaded,
   switches them on globally; the half-integer towers then come back as polylogarithms of Y, 1-Y, Y/(Y-1) instead of HPL
   words at Sqrt[Y]): the unit towers run with the rung's own settings, so the words stay words and s2WordsToG converts them *)
SetAttributes[s2HPLBlock,HoldFirst];
s2HPLBlock[expr_]:=Block[{HPL`$HPLAutoConvertToKnownFunctions=False,HPL`$HPLAutoReduceToMinimalSet=False,HPL`$HPLAutoConvertToSimplerArgument=False,
  HPL`$HPLAutoProductExpand=False,HPL`$HPLAutoLogExtract=True},expr];
s2HPLword[idx_List,a_]:=Module[{ex=Flatten[idx/.{m_Integer/;Abs[m]>=2:>Join[ConstantArray[0,Abs[m]-1],{Sign[m]}]}],lists},
  lists={{ex,1}};
  Do[lists=Join@@(Function[{l},With[{w=l[[1]],cc=l[[2]]},If[MemberQ[{HPL`plus,HPL`minus},w[[j]]],
      {{ReplacePart[w,j->1],cc},{ReplacePart[w,j->-1],cc If[w[[j]]===HPL`plus,1,-1]}},{{w,cc}}]]]/@lists),{j,Length[ex]}];
  Total[(#[[2]] (-1)^Count[#[[1]],1] PolyLogTools`G[Sequence@@#[[1]],a])&/@lists]];
s2WordsToG[e0_,x_]:=Module[{e=e0,G=PolyLogTools`G,chk0,chk1},
  e=e/.HPL`HPL[idx_List,a_]:>s2HPLword[idx,a];
  e=e/.PolyLog[n_Integer,c_. x]/;MemberQ[{1,-1},c]:>-G[Sequence@@ConstantArray[0,n-1],1/c,x];
  e=e/.PolyLog[n_Integer,x^2]:>-2^(n-1) (G[Sequence@@ConstantArray[0,n-1],1,x]+G[Sequence@@ConstantArray[0,n-1],-1,x]);
  (* polylogarithms of 1-u and u/(u-1), u = x^2 (the integer towers' closed forms once the HPL package has loaded its tables):
     Li_n(f) = -G(0^(n-1),1; f), rewritten by PolyLogTools' fibration IN u into words at u with the letters {0, 1} (one
     second; the HPL package's own argument transformation of u/(u-1) does not return), then u = x^2: words at x^2, which
     the fibration in x handles *)
  e=e/.PolyLog[n_Integer,f_]/;!FreeQ[f,x]:>Module[{uu=Global`s2uu,fu,h},
      fu=Together[f/.x^2->uu];
      If[!FreeQ[fu,x],-G[Sequence@@ConstantArray[0,n-1],1,Together[f]],
        h=s2Fib[-G[Sequence@@ConstantArray[0,n-1],1,fu],uu];
        If[h===$Failed||!FreeQ[h,PolyLogTools`ToFibrationBasis]||!FreeQ[h,G[__,a_]/;a=!=uu&&!FreeQ[a,uu]],
          Throw[Failure["S2Piece",<|"Reason"->"half-integer tower: polylogarithm of "<>ToString[f,InputForm]<>" not fibrated in u"|>],"s2u"]];
        h/.uu->x^2]];
  e=e/.Log[1-x^2]->G[1,x]+G[-1,x];
  e=e/.{Log[1-x^2]->G[1,x]+G[-1,x],Log[-1+x^2]->G[1,x]+G[-1,x]+I Pi,Log[(1+x)/(1-x)]->G[-1,x]-G[1,x],Log[(1-x)/(1+x)]->G[1,x]-G[-1,x],
    Log[1-x]->G[1,x],Log[1+x]->G[-1,x],Log[x]->G[0,x],Log[x^2]->2 G[0,x]};
  e=Expand[e];
  (* numerics of the check: words with the letters {0, +-1} at a numeric argument through the HPL package (PolyLogTools' N
     leaves such words unevaluated), the rest through Ginsh *)
  chk0=Quiet@N[e0/.x->1/3,25];
  chk1=Quiet@N[(e/.x->1/3)/.HoldPattern[PolyLogTools`G[w__,u_?NumericQ]]/;SubsetQ[{0,1,-1},{w}]:>(-1)^Count[{w},1] HPL`HPL[{w},u],25];
  If[!NumericQ[chk1],chk1=Quiet@s2Gnum[e/.x->1/3]];
  If[!(NumericQ[chk0]&&NumericQ[chk1]&&Abs[chk0-chk1]<10^-15 Max[1,Abs[chk0]]),
    Throw[Failure["S2Piece",<|"Reason"->"half-integer tower: conversion of the HPL words to G words failed its check: "<>ToString[N[{chk0,chk1},12]]<>
      "; non-numeric terms: "<>ToString[Short[Select[With[{ne=Expand[N[e/.x->1/3,25]]},If[Head[ne]===Plus,List@@ne,{ne}]],!NumericQ[#]&],5],InputForm]|>],"s2u"]];
  e];
s2UnitLimit[Jk_,Y_]:=Module[{x=Global`s2ux,f,val,half,J},
  If[Jk===0,Return[0,Module]];
  If[!s2LastFoldLoadedQ[],Throw[Failure["S2Piece",<|"Reason"->"exact last-fold rung not loaded"|>],"s2u"]];
  MBExactLastFold`mbeLastFoldFibrate[0,x,1/2];Clear[s2BackN];MBExactLastFold`Private`gatePts={1/3,2/3};
  half=!FreeQ[Jk,Power[Y,_Rational]]||!FreeQ[Jk,HPL`HPL];
  If[!half,
    f=s2Fib[Jk/.Y->x,x];
    If[f===$Failed||!FreeQ[f,PolyLogTools`ToFibrationBasis],half=True]];
  If[half,
    (* HALF-INTEGER TOWERS (psi(3/2+z) monomials of the duplication rewrite, MB8au r43 pieces 62/63/64/71): J(Y) carries
       Y^(1/2) and HPL words at Sqrt[Y]; with Y = x^2 (x > 0 on (0,1)) every power is integer and the words are G words
       in x with the letters {0, 1, -1}; the limit Y -> 1 is the jet at x = 1 *)
    J=s2WordsToG[PowerExpand[Jk/.Y->x^2],x];
    If[!FreeQ[J,HPL`HPL]||!FreeQ[J,(PolyLog|Log)[___,a_]/;!FreeQ[a,x]],
      Throw[Failure["S2Piece",<|"Reason"->"half-integer tower: functions outside the G class after the conversion: "<>
        ToString[Short[DeleteDuplicates[Cases[J,(HPL`HPL|PolyLog|Log)[___,a_]/;!FreeQ[a,x],{0,Infinity}]],3],InputForm]|>],"s2u"]];
    f=s2Fib[J,x];
    If[f===$Failed||!FreeQ[f,PolyLogTools`ToFibrationBasis],Throw[Failure["S2Piece",<|"Reason"->"unit piece: fibration basis refused (in Y and in Y = x^2)"|>],"s2u"]];
    Print["    [s2unit] half-integer tower: the limit Y -> 1 taken through Y = x^2 (HPL words converted to G words in x)"]];
  f=Expand[f/.Log[x]->PolyLogTools`G[0,x]];
  val=Catch[s2JetOne[f,x,s2Gnum],"s2o"];
  If[FailureQ[val],Throw[Failure["S2Piece",<|"Reason"->"unit piece: the limit Y -> 1: "<>val["Reason"]|>],"s2u"]];
  Expand[s2GHeadFix[val]/.s2Back[]]];
(* ---------- HIGHER POLYGAMMAS IN THE UNIT PIECE (1 October 2026): the generating function ----------
   A dressing prod_j psi^(m_j)(L_j) (repeats allowed) is read off the Taylor coefficients of Gamma copies with DISTINCT
   multiples: for every distinct argument L with weight w_L = sum over its factors of (m_j + 1) take w_L copies
   Gamma(L + a_{L,i} ep)/Gamma(L), i = 1..w_L.  With the formal symbols P[L,k] = psi^(k)(L),
       log prod copies = sum_{L,i} sum_{k>=1} P[L,k-1] (a_{L,i} ep)^k / k!,
   and the coefficient of ep^N (N = sum_L w_L) is a polynomial in the P's whose coefficients are polynomials in the
   multiples; the monomials of weight w_L in the P[L,.] are the partitions of w_L and their coefficients are the power
   sums of the a_{L,i}, independent as soon as there are w_L copies.  Monomials with proportional coefficient
   polynomials form one unknown; the target monomial must be alone in its group (checked).  As many multiple vectors as
   groups are sampled (rational, distinct from the nu = 1/7 splitting of coincident legs), each sample closed at the
   scale by s2ItemLaurent at order N and taken to Y -> 1 by the complete jet, and the exact linear system gives the
   target.  The first-order class (every m_j = 0) keeps the inclusion-exclusion over copy subsets below (s2UnitPieceTowerV1). *)
s2UnitPieceTowerGF[F_,ctr_List]:=Catch[Module[{z=ctr[[1,1]],c=ctr[[1,2]],fs,dress={},K=1,Ls,wL,Nw,a,e,logGen,cN,P,target,mons,coefs,groups,nG,
    Q={},Ivals={},sol,Ks,Y=Global`s2Yu,t0=AbsoluteTime[],tryS=0,tg},
  If[Length[ctr]=!=1,Throw[Failure["S2Piece",<|"Reason"->"unit piece: one fold only"|>],"s2u"]];
  If[!FreeQ[F,ep],Throw[Failure["S2Piece",<|"Reason"->"unit piece: eps-free pieces only"|>],"s2u"]];
  fs=If[Head[F]===Times,List@@F,{F}];
  Do[Which[MatchQ[t,PolyGamma[_Integer?NonNegative,_]],AppendTo[dress,{Expand[t[[2]]],t[[1]]}],
      MatchQ[t,Power[PolyGamma[_Integer?NonNegative,_],_Integer?Positive]],dress=Join[dress,ConstantArray[{Expand[t[[1,2]]],t[[1,1]]},t[[2]]]],
      !FreeQ[t,PolyGamma],Throw[Failure["S2Piece",<|"Reason"->"unit piece: polygamma factor outside the class: "<>ToString[t,InputForm]|>],"s2u"],
      True,K=K t],{t,fs}];
  If[dress==={},Throw[Failure["S2Piece",<|"Reason"->"unit piece: no polygamma dressing"|>],"s2u"]];
  Ls=DeleteDuplicates[dress[[All,1]]];
  wL=Association@Table[L->Total[Cases[dress,{L,m_}:>m+1]],{L,Ls}];
  Nw=Total[Values[wL]];
  If[Nw>5,Throw[Failure["S2Piece",<|"Reason"->"unit piece: dressing weight "<>ToString[Nw]<>" above five"|>],"s2u"]];
  (* the inner kernel with its coincident legs split by FIXED multiples of ep (s2NormalizeInner: Gamma(L')^p -> Gamma(L')
     Gamma(L' + ep/7) ...): those split copies expand in ep as well, psi(L') ep/7 + ..., and their products with the
     sampled copies survive at order Nw -- they enter the generating polynomial as copies with fixed multiples (the
     inclusion-exclusion of the first-order class cancels them automatically; the linear solve must see them) *)
  Ks=s2NormalizeInner[K,z,1/7];
  Module[{fixed={}},
    Do[Which[MatchQ[t,Gamma[arg_]/;!FreeQ[arg,ep]],With[{cc=Coefficient[Expand[t[[1]]],ep]},AppendTo[fixed,{Expand[t[[1]]-cc ep],cc}]],
        MatchQ[t,Power[Gamma[arg_],n_Integer?Positive]/;!FreeQ[arg,ep]],With[{cc=Coefficient[Expand[t[[1,1]]],ep]},Do[AppendTo[fixed,{Expand[t[[1,1]]-cc ep],cc}],{t[[2]]}]],
        !FreeQ[t,ep],Throw[Failure["S2Piece",<|"Reason"->"unit piece: eps-dependence of the split kernel outside Gamma copies: "<>ToString[t,InputForm]|>],"s2u"]],
      {t,If[Head[Ks]===Times,List@@Ks,{Ks}]}];
    Global`$s2GFfixed=fixed;
    (* the formal generating polynomial: coefficient of e^Nw, its monomials in the P's and their coefficient polynomials *)
    logGen=Sum[Sum[Sum[P[L,k-1] (a[L,i] e)^k/k!,{k,1,Nw}],{i,wL[L]}],{L,Ls}]+
      Sum[Sum[P[fx[[1]],k-1] (fx[[2]] e)^k/k!,{k,1,Nw}],{fx,fixed}]];
  cN=Expand[SeriesCoefficient[Series[Exp[logGen],{e,0,Nw}],Nw]];
  target=Times@@(P[#[[1]],#[[2]]]&/@dress);
  Module[{rulesP=DeleteDuplicates[Cases[cN,P[__],{0,Infinity}]],cl},
    cl=CoefficientRules[cN,rulesP];
    mons=Times@@(rulesP^#)&/@Keys[cl];coefs=Values[cl]];
  If[!MemberQ[mons,target],Throw[Failure["S2Piece",<|"Reason"->"unit piece: target monomial absent from the generating polynomial"|>],"s2u"]];
  (* groups of proportional coefficient polynomials (their ratio free of the multiples) *)
  groups=Module[{left=Range[Length[mons]],out={}},
    While[left=!={},Module[{i=First[left],g},
      g=Select[left,FreeQ[Together[coefs[[#]]/coefs[[i]]],a]&];
      AppendTo[out,g];left=Complement[left,g]]];out];
  nG=Length[groups];
  tg=Position[groups,_?(MemberQ[mons[[#]],target]&),{1},Heads->False][[1,1]];
  If[Length[groups[[tg]]]=!=1,Throw[Failure["S2Piece",<|"Reason"->"unit piece: target monomial shares its coefficient polynomial with "<>
      ToString[mons[[DeleteCases[groups[[tg]],Position[mons,target][[1,1]]]]]/.P[L_,k_]:>PolyGamma[k,L],InputForm]|>],"s2u"]];
  (* IDENTIFIABILITY: the group polynomials q_g(a) may be linearly dependent as functions of the multiples (the fixed copies
     add constants); the target is determined iff no linear dependency sum_g c_g q_g = 0 involves it.  The samples then
     only have to span the row space (rank r of the q's), and the target is read off with a left inverse. *)
  Module[{qs=Table[Expand[First[coefs[[g]]]],{g,groups}],avars,M,r,null,et},
    avars=DeleteDuplicates[Cases[qs,a[__],{0,Infinity}]];
    M=If[avars==={},List/@qs,Module[{rules=CoefficientRules[#,avars]&/@qs,keys},keys=DeleteDuplicates[Join@@(Keys/@rules)];Table[Lookup[rl,Key[k],0],{rl,rules},{k,keys}]]];
    r=MatrixRank[M];null=NullSpace[Transpose[M]];
    If[AnyTrue[null,#[[tg]]=!=0&],Throw[Failure["S2Piece",<|"Reason"->"unit piece: the target monomial is not identifiable from the generating function (a linear dependency of the coefficient polynomials involves it)"|>],"s2u"]];
    Print["    [s2unit-gf] dressing ",InputForm[target/.P[L_,k_]:>PolyGamma[k,L]],": weight ",Nw,", ",Nw," sampled + ",Length[Global`$s2GFfixed]," fixed Gamma copies, ",Length[mons]," monomials in ",nG," groups of rank ",r," -> ",r," samples"];
    (* sample multiple vectors until the rows span the row space; every sample is one inner closure at order Nw and its
       limit Y -> 1.  The multiples of ONE sample must not all be functions of a single parameter (then the rows span only
       {1, s, s^2, ..}): a deterministic generic rational per copy and try. *)
    While[Length[Q]<r&&tryS<r+8,tryS++;
      Module[{sub=Flatten[Table[a[L,i]->1+(i-1)/2+Mod[7 tryS+13 i+17 Position[Ls,L][[1,1]],29]/61+Mod[11 tryS i+3 Position[Ls,L][[1,1]],23]/97,{L,Ls},{i,wL[L]}]],row,KS,J,val},
        row=qs/.sub;
        If[MatrixRank[Append[Q,row]]<=Length[Q],Continue[]];
        KS=Ks Times@@(Gamma[#[[1]]+(#[[2]]/.sub) ep]/Gamma[#[[1]]]&/@Flatten[Table[{L,a[L,i]},{L,Ls},{i,wL[L]}],1]);
        J=s2HPLBlock[Catch[s2ItemLaurent[KS Y^z,{z->c},z,Y,0,Nw,0<Y<1,{{1/3},{2/3}}],"s2t"]];
        If[FailureQ[J],Throw[Failure["S2Piece",<|"Reason"->"unit piece: inner closure refused: "<>J["Reason"]|>],"s2u"]];
        val=s2HPLBlock[s2UnitLimit[J[[Nw+1]],Y]];
        AppendTo[Q,row];AppendTo[Ivals,val];
        Print["    [s2unit-gf] sample ",Length[Q],"/",r," closed (",Round[AbsoluteTime[]-t0]," s)"]]];
    If[Length[Q]<r,Throw[Failure["S2Piece",<|"Reason"->"unit piece: no "<>ToString[r]<>" independent samples"|>],"s2u"]];
    (* left inverse: lambda . Q = e_target, exact; the target integral is lambda . Ivals *)
    et=UnitVector[nG,tg];
    sol=Quiet@LinearSolve[Transpose[Q],et];
    If[!ListQ[sol]||!FreeQ[sol,LinearSolve],Throw[Failure["S2Piece",<|"Reason"->"unit piece: left inverse for the target failed"|>],"s2u"]];
    Print["    [s2unit-gf] piece of weight ",Nw," closed through the scale (",r," samples, ",Round[AbsoluteTime[]-t0]," s)"];
    Global`mbeCanonicalConstants[Expand[sol.Ivals]]]],"s2u"];
s2UnitPieceTower[F_,ctr_List]:=If[FreeQ[F,PolyGamma[k_Integer/;k>=1,_]],s2UnitPieceTowerV1[F,ctr],s2UnitPieceTowerGF[F,ctr]];
s2UnitPieceTowerV1[F_,ctr_List]:=Catch[Module[{z=ctr[[1,1]],c=ctr[[1,2]],fs,pg={},K=1,d,as,Ks,Y=Global`s2Yu,vals,t0=AbsoluteTime[]},
  If[Length[ctr]=!=1,Throw[Failure["S2Piece",<|"Reason"->"unit piece: one fold only"|>],"s2u"]];
  If[!FreeQ[F,ep],Throw[Failure["S2Piece",<|"Reason"->"unit piece: eps-free pieces only"|>],"s2u"]];
  fs=If[Head[F]===Times,List@@F,{F}];
  Do[Which[MatchQ[t,PolyGamma[0,_]],AppendTo[pg,t],
      MatchQ[t,Power[PolyGamma[0,_],_Integer?Positive]],pg=Join[pg,ConstantArray[t[[1]],t[[2]]]],
      !FreeQ[t,PolyGamma],Throw[Failure["S2Piece",<|"Reason"->"unit piece: a polygamma of order >= 1 (not in the class)"|>],"s2u"],
      True,K=K t],{t,fs}];
  d=Length[pg];
  If[d>3,Throw[Failure["S2Piece",<|"Reason"->"unit piece: dressing degree above three"|>],"s2u"]];
  as=Table[1+(j-1)/2,{j,d}];
  (* 2026-10-01 (MB8au r43 piece 28, kernel Gamma(-2-z)Gamma(-z)Gamma(1+z)^2): integer-distance legs of one
     orientation are merged into one base power times a polynomial BEFORE the coincident split (as s2PieceClose does
     through s2NormalizeInner); unmerged they left double poles on every rung of the right tower and the inner tower
     failed its own gate *)
  Ks=s2NormalizeInner[K,z,1/7];
  vals=Table[Module[{KS,J},
      KS=Ks Product[Gamma[pg[[j,2]]+as[[j]] ep]/Gamma[pg[[j,2]]],{j,S}];
      J=s2HPLBlock[Catch[s2ItemLaurent[KS Y^z,{z->c},z,Y,0,d,0<Y<1,{{1/3},{2/3}}],"s2t"]];
      If[FailureQ[J],Throw[Failure["S2Piece",<|"Reason"->"unit piece: inner closure refused: "<>J["Reason"]|>],"s2u"]];
      (-1)^(d-Length[S]) s2HPLBlock[s2UnitLimit[J[[d+1]],Y]]],{S,Subsets[Range[d]]}];
  Print["    [s2unit] piece of dressing degree ",d," closed through the scale (",2^d," copy subsets, ",Round[AbsoluteTime[]-t0]," s)"];
  Global`mbeCanonicalConstants[Expand[Total[vals]/Times@@as]]],"s2u"];
s2UnitPieceGated[F_,ctr_List,sec_:1800]:=Module[{v,q,z,c,tt},
  If[Length[ctr]=!=1,Return[Failure["S2Piece",<|"Reason"->"one fold only"|>],Module]];
  z=ctr[[1,1]];c=ctr[[1,2]];
  v=TimeConstrained[s2UnitPieceTower[F,ctr],sec,Failure["S2Piece",<|"Reason"->"time limit"|>]];
  If[FailureQ[v],Return[v,Module]];
  q=Quiet@TimeConstrained[NIntegrate[(F/.z->c+I tt)/(2 Pi),{tt,-60,60},WorkingPrecision->30,PrecisionGoal->14,MaxRecursion->40],300,$TimedOut];
  If[!TrueQ[NumericQ[q]&&NumericQ[N[v/.s2Back[],30]]&&Abs[N[v,40]-q]<10^-10 Max[1,Abs[q]]],
    Return[Failure["S2Piece",<|"Reason"->"gate: "<>ToString[N[v,15]]<>" vs quadrature "<>ToString[N[q,15]]|>],Module]];
  <|"Value"->v,"Quad"->q|>];
Print["[uint_fcu_s2] slope-two closer installed (Beta triple or numerator pair; multi-fold: scale variable + finite-eps Barnes reductions of the others; inner Mellin tower at the scale; outer fold by the exact last fold on pulled-back words, Euler-cube fallback; L6 reduction)."];
