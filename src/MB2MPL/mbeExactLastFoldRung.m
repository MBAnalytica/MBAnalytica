(* ::Package:: *)
(* mbeExactLastFoldRung.m (2026-09-25): the EXACT LAST FOLD of a native parameter-subtraction job as a package
   rung.  The integrator (HyperFLINT, diagnostic build) is exact on the first n-1 variables of a job but mishandles the
   last one whenever letters of the (n-1)-fold result coalesce with an endpoint of the last variable (an integrable
   compound corner): it raises a false divergence at one side and returns a silently wrong value at the other.  Theory:
   subtraction_syed.tex, Remark scopelimits (the per-coordinate regularized limit needs normal crossings) and section
   rationalmoving (fixed-letter fibration with an INTERIOR basepoint).  This rung closes every native job as
     stage 1  engine on the first n-1 variables (divergence scan on, nonlinear-factor drops refused)
              -> S(x) = sum_k c_k(x) G(w_k(x);1), letters rational in the last variable x and the parameter;
     stage 2  exact fibration of x in PolyLogTools (total differential DG + GIntegrate; letter denominators of any
              degree in x through placeholder roots; the constant fixed EXACTLY at the interior basepoint u/2);
     stage 3  int_0^1 S dx = [fixed-letter primitive at x=1, shuffle-regularized: every regulator coefficient must
              vanish exactly (REG_NONCANCEL otherwise)] - [primitive at 0: all-zero words must cancel].
   Dev gates (never producers; the exact result never depends on them): S vs S_fib at two interior points, the
   regulator cancellation, an optional numeric cross-check against the engine's own n-fold value (mbeLastFoldEngineCrossCheck)
   and the static coalescence detector (mbeLastFoldCoalescenceQ) that names the defect condition.
   Numerics: Ginsh through hf_machinery`gnumHF, except {0,+-1}-alphabet words at argument exactly 1, which Ginsh
   mis-signs (H(w;1) for G(w;1)); those go through the HPL tables.  The numeric test point is moved off any letter or
   coefficient singularity (r38: the letter 2u/(3u-1) is infinite at u=1/3).
   Records: GROUPDIR/lastfold_<id><suffix>.m with RequestHash (python canonical), Stage1File/Stage1Hash, ScanOn, Value
   (exact, psParameter1 symbolic); admitted by build_strict_snapshots_fable_v2.py, consumed by assemble_component_fable_v3.wls.
   Requires (loaded by the caller): load_standard_w10.m, mbeParameterSubtractionRoots.m, hf_machinery.m. *)
BeginPackage["MBExactLastFold`"];
mbeExactLastFold::usage="mbeExactLastFold[gdir,jobId,opts] runs the exact last fold of native job jobId of GROUPDIR gdir and returns an association with \"Status\" (\"LASTFOLD_DONE\" or a refusal tag), \"Value\", \"RecordFile\", the gates and the stage-1 binding.  Options: \"Order\" (Automatic = the job's first certified order, or a list of variable names), \"Engine\", \"TestPoint\", \"Basepoint\", \"OutSuffix\", \"RequestsFile\", \"Write\", \"CrossCheck\", \"EngineSeconds\".";
mbeLastFoldStage1::usage="mbeLastFoldStage1[gdir,job,order,opts] runs the engine on the first n-1 variables of the order and returns <|\"Status\",\"S\",\"File\",\"Hash\",\"RequestHash\",\"Terms\"|>.";
mbeLastFoldFibrate::usage="mbeLastFoldFibrate[S,x,basepoint] returns <|\"Status\",\"Sfib\",\"RootBack\"|>: the fixed-letter fibration of S in x.";
mbeLastFoldIntegrate::usage="mbeLastFoldIntegrate[Sfib,rootBack,x,gnum] returns <|\"Status\",\"Value\",\"RegulatorCoefficients\",\"ZeroWordCoefficient\"|>.";
mbeLastFoldCoalescenceQ::usage="mbeLastFoldCoalescenceQ[S,x,u0] reports the defect condition of the integrator's last fold: letters of S coalescing with 0, 1 or each other at x->0 or x->1.";
mbeLastFoldEngineCrossCheck::usage="mbeLastFoldEngineCrossCheck[job,order,engine,exactValue,gnum,opts] runs the engine on all n variables and compares numerically.";
mbeLastFoldCertificate::usage="mbeLastFoldCertificate[job] is the exact convergence certificate that the rung requires before it integrates a native job alone: an association with \"Certified\" (True or False; \"Reason\" -> \"certificate timeout\" when its 600 s ran out).";
Begin["`Private`"];
G=PolyLogTools`G;
u=Global`psParameter1;
canonicalRequestHash[reqFile_,jid_]:=StringTrim[RunProcess[{"python3","-c","import json,sys,hashlib;j=[x for x in json.load(open(sys.argv[1]))['jobs'] if x['id']==sys.argv[2]][0];print(hashlib.sha256(json.dumps(j['request'],sort_keys=True,separators=(',',':')).encode()).hexdigest())",reqFile,jid},"StandardOutput"]];
(* the integrator binary (release R3, 29 September 2026): "Engine" -> Automatic resolves to Global`$mbeLastFoldEngine when set,
   else the configured hyperlogarithm integrator Global`$MBStandardHyperFLINTBinary (configure_runtime.m), else the release's
   vendor binary next to this file; an explicit path is used as given.  No absolute path lives in this file. *)
$mbeLastFoldRungDir=If[StringQ[$InputFileName]&&$InputFileName=!="",DirectoryName[$InputFileName],Directory[]];
lastFoldEngine[e_String]:=e;
lastFoldEngine[_]:=Which[StringQ[Global`$mbeLastFoldEngine],Global`$mbeLastFoldEngine,
  StringQ[Global`$MBStandardHyperFLINTBinary],Global`$MBStandardHyperFLINTBinary,
  True,FileNameJoin[{$mbeLastFoldRungDir,"vendor","IntVolFLINT","bin","hyperflint"}]];
engineRun[request_,engine_,seconds_]:=Module[{run},
  run=TimeConstrained[RunProcess[{"prlimit","--stack=unlimited",engine,"eval-json"},All,ExportString[request,"RawJSON"],
    ProcessEnvironment-><|"OMP_NUM_THREADS"->"1","HF_DIAG_NONLINEAR"->"throw","PATH"->Environment["PATH"],"HOME"->Environment["HOME"]|>],seconds,$Failed];
  If[run===$Failed,Return[<|"Status"->"ENGINE_TIMEOUT"|>]];
  If[StringContainsQ[run["StandardError"],"HF_DIAG_DROPPED_NONLINEAR"],Return[<|"Status"->"ENGINE_DROPPED"|>]];
  Module[{resp=Quiet@Check[ImportString[run["StandardOutput"],"RawJSON"],$Failed]},
    If[!AssociationQ[resp]||!ListQ[Lookup[resp,"result",$Failed]],
      Return[<|"Status"->"ENGINE_FAILED","Reason"->If[AssociationQ[resp],ToString[Lookup[resp,"reason",""]],StringTake[run["StandardOutput"],UpTo[200]]]|>]];
    <|"Status"->"ok","Response"->resp,"Stdout"->run["StandardOutput"]|>]];
parseResponse[resp_]:=Module[{S},
  S=MBParameterSubtraction`Private`parseNative[resp]/.Global`hfPI->Pi/.Global`hfEG->EulerGamma/.Global`hfZ3->Zeta[3]/.Global`hfZ5->Zeta[5]/.Global`hfLOG2->Log[2];
  If[!FreeQ[S,Global`delta],Return[$Failed]];
  S=Expand[S];S=S/.HoldPattern[Times[a___,g1_G,g2_G,b___]]:>Times[a,b,PolyLogTools`ShuffleG[g1 g2]];S=Expand[S/.HoldPattern[Power[g_G,2]]:>PolyLogTools`ShuffleG[g g]];
  Expand[S]];
Options[mbeLastFoldStage1]={"Engine"->Automatic,"OutSuffix"->"","RequestsFile"->Automatic,"EngineSeconds"->2400};
mbeLastFoldStage1[gdir_String,job_Association,order_List,OptionsPattern[]]:=Module[{head=Most[order],r1,run,file,hash,reqFile,rh,S},
  reqFile=If[OptionValue["RequestsFile"]===Automatic,gdir<>"/requests.json",OptionValue["RequestsFile"]];
  r1=job["request"];r1["vars_int"]=head;r1["vars_int_from"]=ConstantArray["0",Length[head]];r1["vars_int_to"]=ConstantArray["1",Length[head]];r1["check_divergences"]=True;
  run=engineRun[r1,lastFoldEngine[OptionValue["Engine"]],OptionValue["EngineSeconds"]];
  If[run["Status"]=!="ok",Return[<|"Status"->StringReplace[run["Status"],"ENGINE"->"STAGE1"],"Reason"->Lookup[run,"Reason",""]|>]];
  file="lastfold_stage1_"<>job["id"]<>OptionValue["OutSuffix"]<>".json";
  Module[{st=OpenWrite[gdir<>"/"<>file]},WriteString[st,run["Stdout"]];Close[st]];
  hash=FileHash[gdir<>"/"<>file,"SHA256","HexString"];
  rh=canonicalRequestHash[reqFile,job["id"]];
  If[!StringMatchQ[rh,Repeated[HexadecimalCharacter,{64}]],Return[<|"Status"->"REQUEST_HASH_FAILED"|>]];
  S=parseResponse[run["Response"]];
  If[S===$Failed,Return[<|"Status"->"STAGE1_HAS_CONTOUR_TAGS"|>]];
  <|"Status"->"ok","S"->S,"File"->file,"Hash"->hash,"RequestHash"->rh,"Terms"->Length[run["Response"]["result"]]|>];
(* ---- fibration state (single-threaded) ---- *)
rootReg=<||>;rootBack={};rootCounter=0;fibCache=<||>;basepoint=u/2;xv=Null;refusal=None;
(* algebraic constants: the engine's algebraic letters (Wm/Wp realized as Sqrt[d(u)]) and the roots of irreducible
   quadratics are carried as FORMAL symbols lfSq<n> (one per squarefree radicand class), so that the rational algebra
   of the fibration (Together/Apart/FactorList) never rationalizes a conjugate pair into an unsplit quadratic
   (MB14au r51 s2: FIB_BAD_WORD).  Back substitution: backRules[] = lfRoot -> explicit roots, lfSq -> Sqrt[d]. *)
sqReg=<||>;sqBack={};sqCounter=0;
sqSym[r_]:=sqSym[r]=Module[{hit=None},
  Do[Module[{q,sq},q=Simplify[r/r0,Assumptions->0<u<1];sq=Simplify[Sqrt[q],Assumptions->0<u<1];
    If[FreeQ[sq,Power[_,_Rational]]&&FreeQ[sq,Abs]&&FreeQ[sq,Sqrt],hit=sq*sqReg[r0];Break[]]],{r0,Keys[sqReg]}];
  If[hit=!=None,Return[hit]];
  Module[{sym=Symbol["Global`lfSq"<>ToString[++sqCounter]]},sqReg[r]=sym;sqBack=Join[sqBack,{sym->Sqrt[r]}];sym]];
(* a radicand carrying perfect-square factors in the fibration variable (engine root realizations such as
   Sqrt[(1-x)^2 x^2 d(u)]) is split: the even powers come out (sign fixed on (0,1)), the rest must be free of x *)
squareSplit[r_]:=Module[{fl=FactorList[Together[r]],sqf=1,rest=1,sg},
  Do[Module[{f=fac[[1]],m=fac[[2]]},
    If[EvenQ[m]&&!FreeQ[f,xv],sg=Sign[N[f/.xv->1/2/.u->1/3]];sqf=sqf (sg f)^(m/2),rest=rest f^m]],{fac,fl}];
  {sqf,Together[rest]}];
algebraize[e_]:=(e/.Power[r_,Rational[pp_,2]]/;!FreeQ[r,xv]&&!FreeQ[r,u]:>With[{ss=squareSplit[r]},If[FreeQ[ss[[2]],xv],ss[[1]]^pp Power[ss[[2]],pp/2],Power[r,pp/2]]])/.Power[r_,Rational[pp_,2]]/;FreeQ[r,xv]&&!FreeQ[r,u]:>sqSym[Together[r]]^pp;
backRules[]:=Join[rootBack/.sqBack,sqBack];
rootSyms[f_]:=Module[{deg=Exponent[f,xv],key,rts,syms},
  key=Expand[f/Coefficient[f,xv,deg]];
  If[KeyExistsQ[rootReg,key],Return[rootReg[key]]];
  rts=algebraize[xv/.Solve[key==0,xv]];
  If[Length[rts]=!=deg,refusal="ROOTS_REFUSED degree "<>ToString[deg];Throw[$Failed,lastfold]];
  syms=Table[Symbol["Global`lfRoot"<>ToString[++rootCounter]],{deg}];
  rootBack=Join[rootBack,Thread[syms->rts]];rootReg[key]=syms;syms];
splitRational[c_]:=Module[{t=Together[c],num,den,fl},
  num=Numerator[t];den=Denominator[t];fl=FactorList[den];
  den=Times@@Table[With[{f=fac[[1]],m=fac[[2]]},Which[FreeQ[f,xv],f^m,Exponent[f,xv]==1,f^m,True,With[{ss=rootSyms[f]},(Coefficient[f,xv,Exponent[f,xv]] Times@@((xv-#)&/@ss))^m]]],{fac,fl}];
  Apart[num/den,xv]];
(* term collection by G-monomial: the fibration of a word is a sum of many terms sharing the same words with different
   rational coefficients; without collection the products explode (thousands of terms per weight-3 word, hours at
   weight 4-5).  One Together per distinct monomial replaces thousands of partial-fraction calls. *)
collectWords[e_]:=If[Head[e]===Plus&&Length[e]>8,
  Module[{gs=DeleteDuplicates[Cases[e,_G,{0,Infinity}]]},If[gs==={},e,Expand[Collect[e,gs,Together],_G]]],e];   (* Collect nests successive variables: expand only with respect to the words *)
fib[expr_]:=Module[{e=Expand[expr],words,rules},
  words=Select[DeleteDuplicates[Cases[e,_G,{0,Infinity}]],!FreeQ[#,xv]&];
  If[words==={},Return[e]];
  rules=Table[w->fibWord[w],{w,words}];collectWords[Expand[e/.rules]]];
fibProgress=0;fibT0=0;
fibWord[w_G]:=If[KeyExistsQ[fibCache,w],fibCache[w],fibCache[w]=Module[{d,dfib,prim,c,tw=AbsoluteTime[],res},
  If[fibT0===0,fibT0=AbsoluteTime[]];fibProgress++;If[Mod[fibProgress,25]==0,Print["    [fibration] ",fibProgress," words, ",Round[AbsoluteTime[]-fibT0]," s, weight ",Length[w]-1]];
  res=fibWordBody[w];If[AbsoluteTime[]-tw>30,Print["    [fibration] slow word ",Round[AbsoluteTime[]-tw]," s, weight ",Length[w]-1,", letters ",LeafCount[Most[List@@w]]]];res]];
fibWordBody[w_G]:=Module[{d,dfib,prim,c},
  d=Expand[PolyLogTools`DG[w,xv]];dfib=collectWords[Expand[fib[d]]];
  prim=collectWords[Expand[Total[Map[integrateTerm,List@@(dfib+Global`zzz)/.Global`zzz->0]]/.G[xv]->1]];
  c=(w/.xv->basepoint)-(prim/.xv->basepoint);prim+c];
integrateTerm[0]:=0;
(* 2026-09-29: a WEIGHT-ZERO term of a differential (rational in xv, no word; the differential of a weight-one
   word) has no G factor.  The empty word G[xv] cannot stand for it because PolyLogTools evaluates G[xv] to 1, which the
   product test then refused ("FIB_BAD_PRODUCT" on MB13u residue 10, public differential rerun).  Its primitive is written
   directly: a simple pole c/(xv-a) integrates to c G(a;xv), a higher pole to a rational function, a polynomial to a polynomial. *)
integrateRationalPart[pt_]:=Module[{den,fl,lin,m,a,c},
  If[PolynomialQ[pt,xv],Return[Module[{cl=CoefficientList[pt,xv]},Sum[cl[[j+1]] xv^(j+1)/(j+1),{j,0,Length[cl]-1}]]]];
  den=Denominator[Together[pt]];fl=Select[FactorList[den],!FreeQ[#[[1]],xv]&];
  If[Length[fl]=!=1||Exponent[fl[[1,1]],xv]=!=1,refusal="ENDPOINT_BAD_TERM higher pole not linear "<>ToString[Short[pt,3],InputForm];Throw[$Failed,lastfold]];
  lin=fl[[1,1]];m=fl[[1,2]];a=-(lin/.xv->0)/Coefficient[lin,xv];c=Together[pt (xv-a)^m];
  If[!FreeQ[c,xv],refusal="ENDPOINT_BAD_TERM non-constant numerator "<>ToString[Short[pt,3],InputForm];Throw[$Failed,lastfold]];
  If[m==1,c G[a,xv],-c/((m-1)(xv-a)^(m-1))]];
integrateTerm[t_]:=Module[{fs,gx,rest,cconst,crat,pf,gprod},
  fs=If[Head[t]===Times,List@@t,{t}];
  gx=Select[fs,MatchQ[#,G[__,xv]]||MatchQ[#,Power[G[__,xv],_Integer]]&];rest=Times@@Complement[fs,gx];
  If[!FreeQ[rest,xv]&&!FreeQ[Cases[rest,_G,{0,Infinity}],xv],refusal="FIB_BAD_WORD "<>ToString[Short[t,3],InputForm];Throw[$Failed,lastfold]];
  If[gx==={},
    cconst=Times@@Cases[rest,_G];crat=rest/cconst;
    If[!FreeQ[cconst,xv],refusal="FIB_BAD_COEF";Throw[$Failed,lastfold]];
    pf=splitRational[crat];
    Return[cconst*Total[Map[integrateRationalPart,DeleteCases[List@@(pf+Global`zzz)/.Global`zzz->0,0]]]]];
  gprod=Times@@gx;
  If[Length[gx]>1||MatchQ[gprod,Power[_G,_]],gprod=Expand[PolyLogTools`ShuffleG[gprod]]];
  If[Head[gprod]===Plus,Return[Total[integrateTerm[rest #]&/@List@@gprod]]];
  If[gprod===1,gprod=G[xv]];
  If[Head[gprod]===Times,Module[{nf=Times@@Select[List@@gprod,FreeQ[#,xv]&]},rest=rest nf;gprod=gprod/nf]];
  If[!MatchQ[gprod,_G],refusal="FIB_BAD_PRODUCT";Throw[$Failed,lastfold]];
  cconst=Times@@Cases[rest,_G];crat=rest/cconst;
  If[!FreeQ[cconst,xv],refusal="FIB_BAD_COEF";Throw[$Failed,lastfold]];
  pf=splitRational[crat];
  cconst*Total[Map[Function[pt,integratePart[pt,gprod]],DeleteCases[List@@(pf+Global`zzz)/.Global`zzz->0,0]]]];
(* ---- one partial-fraction part times one word: simple poles by the fixed-letter integral, HIGHER poles by parts
   (int G(w;x)/(x-a)^m = -G(w;x)/((m-1)(x-a)^(m-1)) + 1/(m-1) int G(w';x)/((x-a_1)(x-a)^(m-1)), G' = G(w';x)/(x-a_1)),
   POLYNOMIAL parts by parts as well (int x^k G(w;x) = x^(k+1)/(k+1) G(w;x) - 1/(k+1) int x^(k+1) G(w';x)/(x-a_1)).
   The word G[xv] with no letters is the constant 1. ---- *)
integratePart[pt_,g_]:=Module[{res,den,fl,lin,m,a,c,w,rest,dg},
  If[PolynomialQ[pt,xv],Return[polyIntPoly[pt,g]]];
  res=PolyLogTools`GIntegrate[pt g,xv];
  If[FreeQ[res,PolyLogTools`Gint],Return[res]];
  den=Denominator[Together[pt]];fl=Select[FactorList[den],!FreeQ[#[[1]],xv]&];
  If[Length[fl]=!=1||Exponent[fl[[1,1]],xv]=!=1,refusal="ENDPOINT_BAD_TERM higher pole not linear "<>ToString[Short[pt,3],InputForm];Throw[$Failed,lastfold]];
  lin=fl[[1,1]];m=fl[[1,2]];a=-(lin/.xv->0)/Coefficient[lin,xv];c=Together[pt (xv-a)^m];
  If[!FreeQ[c,xv],refusal="ENDPOINT_BAD_TERM non-constant numerator "<>ToString[Short[pt,3],InputForm];Throw[$Failed,lastfold]];
  If[m==1,refusal="ENDPOINT_BAD_TERM simple pole not integrated "<>ToString[Short[pt g,3],InputForm];Throw[$Failed,lastfold]];
  w=Most[List@@g];
  If[w==={},Return[-c/((m-1)(xv-a)^(m-1))]];
  dg=G@@Append[Rest[w],xv];   (* G' = dg/(xv - a_1) *)
  -c g/((m-1)(xv-a)^(m-1))+c/(m-1) Total[Map[Function[pp,integratePart[pp,dg]],DeleteCases[List@@(Apart[1/((xv-First[w])(xv-a)^(m-1)),xv]+Global`zzz)/.Global`zzz->0,0]]]];
polyInt[c_,k_Integer,g_G]:=Module[{w=Most[List@@g],a1,wr,q,r},
  If[w==={},Return[c xv^(k+1)/(k+1)]];
  a1=First[w];wr=Rest[w];
  q=PolynomialQuotient[xv^(k+1),xv-a1,xv];r=PolynomialRemainder[xv^(k+1),xv-a1,xv];
  c xv^(k+1)/(k+1) g-c/(k+1) (polyIntPoly[q,G@@Append[wr,xv]]+r G@@Join[{a1},wr,{xv}])];
polyIntPoly[0,_]:=0;
polyIntPoly[q_,g_G]:=Module[{cl=CoefficientList[q,xv]},Sum[If[cl[[j+1]]===0,0,polyInt[cl[[j+1]],j,g]],{j,0,Length[cl]-1}]];
(* 2026-10-04: a ONE-letter word leaves the empty word G(x) in the by-parts step of polyInt, and PolyLogTools evaluates
   G[x] to 1, so the call arrives as polyIntPoly[q,1]; it is the plain polynomial primitive.  Without this rule the call
   stayed unevaluated in the primitive and the derivative gate refused the job (NUMERIC_FAILED: MB6u, 4 October). *)
polyIntPoly[q_,1]:=Module[{cl=CoefficientList[q,xv]},Sum[cl[[j+1]] xv^(j+1)/(j+1),{j,0,Length[cl]-1}]];
mbeLastFoldFibrate[S_,x_Symbol,bp_]:=Module[{Sfib,S1},
  rootReg=<||>;rootBack={};rootCounter=0;fibCache=<||>;basepoint=bp;xv=x;refusal=None;sqReg=<||>;sqBack={};sqCounter=0;fibProgress=0;fibT0=0;
  DownValues[sqSym]=Select[DownValues[sqSym],FreeQ[First[#],HoldPattern[sqSym[_?(!MatchQ[#,_Pattern]&)]]]&];   (* the memo of the previous fibration is cleared with its registry *)
  S1=algebraize[S];
  Sfib=Catch[collectWords[fib[S1]],lastfold];
  If[Sfib===$Failed,Return[<|"Status"->refusal|>]];
  If[!FreeQ[Sfib,PolyLogTools`Gint]||!FreeQ[Sfib,Derivative],Return[<|"Status"->"FIB_INCOMPLETE"|>]];
  <|"Status"->"ok","Sfib"->Sfib,"S"->S1,"RootBack"->backRules[],"AlgebraicConstants"->sqBack|>];

(* ---- endpoint jets at the zero side (theory: 'ordinary endpoints from a complete cutoff expansion') ----
   A term c(x) G(w;x) of the primitive may carry a rational pole of c at x=0 against a word vanishing there; the plain
   substitution x->0 gives 0*Infinity.  The regularized limit is the x^0 L^0 coefficient of the product of the Laurent
   expansion of c and the exact expansion of the word,  G(w;x) = sum_k q_k(L) x^k,  L = log x, obtained from the
   iterated-integral definition (all-zero words = L^m/m!; a leading zero integrates dt/t; a nonzero leading letter a
   expands 1/(t-a) = -sum_m t^m/a^(m+1)).  Negative powers and every positive power of L must cancel in the SUM over
   the terms (ENDPOINT_NONCANCEL otherwise): no term is assigned a finite part of its own. *)
Lsym=Global`lfLog;
gser[{},x_,n_]:=1;
gser[w_List,x_,n_]:=gser[w,x,n]=Module[{a=First[w],rest=Rest[w],inner,res=0,terms},
  If[AllTrue[w,#===0&],Return[Lsym^Length[w]/Length[w]!]];
  inner=Expand[gser[rest,x,n]];
  terms=DeleteCases[List@@(inner+Global`zzz)/.Global`zzz->0,0];   (* the zzz device leaves a literal 0 term: Exponent[0,x] is -Infinity *)
  Do[Module[{k=Exponent[t,x],j=Exponent[t,Lsym],c},c=Cancel[t/(x^k Lsym^j)];
    If[a===0,If[k>=1,res+=c*intPow[k-1,j,x,n]],res+=c*Sum[-(1/a^(m+1))*intPow[k+m,j,x,n],{m,0,n}]]],{t,terms}];
  Expand[res]];
intPow[k_,j_,x_,n_]:=If[k+1>n,0,x^(k+1) Sum[(-1)^i j!/(j-i)! Lsym^(j-i)/(k+1)^(i+1),{i,0,j}]];   (* int_0^x t^k log^j t dt *)
regLimitZero[P_,x_]:=Module[{terms,total=0},
  terms=DeleteCases[List@@(Expand[P]+Global`zzz)/.Global`zzz->0,0];
  Do[Module[{fs,gx,rest,ratpart,constpart,p,ser,lau},
    fs=If[Head[t]===Times,List@@t,{t}];
    gx=Select[fs,MatchQ[#,G[__,x]]&];rest=Times@@Complement[fs,gx];
    constpart=Times@@Select[If[Head[rest]===Times,List@@rest,{rest}],!FreeQ[#,G]&];ratpart=Together[rest/constpart];
    If[!FreeQ[ratpart,G]||!FreeQ[constpart,x],refusal="ENDPOINT_BAD_TERM "<>ToString[Short[t,3],InputForm];Throw[$Failed,lastfold]];
    p=Max[0,Exponent[Denominator[ratpart],x,Min]];
    If[p==0,
      total+=constpart*(ratpart/.x->0)*Times@@(If[Most[List@@#]=!={},0,1]&/@gx),
      ser=Expand[Times@@(gser[Most[List@@#],x,p]&/@gx)];
      lau=Normal[Series[ratpart,{x,0,0}]];
      total+=constpart*Coefficient[Expand[lau*ser],x,0]+constpart*Sum[Coefficient[Expand[lau*ser],x,-k]*x^-k,{k,1,p}]]],{t,terms}];
  Expand[total]];

(* the primitive must differentiate back to the fibrated integrand: symmetric finite difference at an interior gate
   point with Ginsh numerics (step 10^-9, truncation ~10^-18); refusal PRIMITIVE_DERIVATIVE_FAILED beyond 10^-8 relative
   to the integrand (4 October 2026: with 20-digit values the difference quotient of a primitive of size ~10^3 carried an
   error of ~10^-8 and refused correct primitives; the numerics now carry 40 digits and the bound is relative) *)
derivativeGate[primp_,Sfib_,x_,gnum_]:=Module[{tp=First[gatePts],h=10^-9,pP,pM,sv,dv},
  pP=gnum[primp/.x->tp+h];pM=gnum[primp/.x->tp-h];sv=gnum[Sfib/.x->tp];
  dv=If[NumericQ[pP]&&NumericQ[pM]&&NumericQ[sv],(pP-pM)/(2h)-sv,"NUMERIC_FAILED"];
  <|"Pass"->(NumericQ[dv]&&Abs[dv]<10^-8 Max[1,Abs[sv]]),"Residual"->dv|>];
mbeLastFoldIntegrate[Sfib_,rb_List,x_Symbol,gnum_]:=Module[{primp,at1p,at0p,regc,regn,zw,cz,val},
  xv=x;refusal=None;   (* rootBack/sqBack: the module state of the preceding mbeLastFoldFibrate call (rb is its explicit form) *)
  primp=Catch[Total[Map[integrateTerm,List@@(Expand[Sfib]+Global`zzz)/.Global`zzz->0]],lastfold];
  If[primp===$Failed,Return[<|"Status"->refusal|>]];
  primp=primp/.G[x]->1;
  Module[{dg=derivativeGate[primp,Sfib,x,gnum]},If[!TrueQ[dg["Pass"]],Return[<|"Status"->"PRIMITIVE_DERIVATIVE_FAILED","Residual"->dg["Residual"],"Primitive"->primp|>]]];
  at1p=PolyLogTools`ShuffleRegulate[primp/.x->1];
  at1p=at1p/.G[o__,1]/;MatchQ[{o},{1..}]:>Global`lfReg^Length[{o}]/Length[{o}]!;
  at1p=at1p/.HPL`HPL[{1},1]->Global`lfReg;
  regc=Table[Coefficient[Expand[at1p],Global`lfReg,j],{j,1,Max[1,Exponent[at1p,Global`lfReg]]}];
  regn=gnum[#/.backRules[]]&/@regc;
  If[!AllTrue[regn,NumericQ[#]&&Abs[#]<10^-12&],Return[<|"Status"->"REG_NONCANCEL","RegulatorCoefficients"->regn,"Primitive"->primp|>]];
  at1p=at1p/.Global`lfReg->0;
  If[!FreeQ[at1p,ComplexInfinity|Indeterminate|DirectedInfinity],Return[<|"Status"->"ENDPOINT_POLE_AT_ONE","Primitive"->primp|>]];   (* coefficient pole at x=1: needs the reflected fibration *)
  at0p=Catch[regLimitZero[primp,x],lastfold];
  If[at0p===$Failed,Return[<|"Status"->refusal,"Primitive"->primp|>]];
  Module[{lc=Table[gnum[Coefficient[Coefficient[at0p,x,0],Lsym,j]/.backRules[]],{j,1,Max[1,Exponent[at0p,Lsym]]}],
      pc=Flatten[Table[gnum[Coefficient[Coefficient[at0p,x,-k],Lsym,j]/.backRules[]],{k,1,Max[1,-Exponent[at0p,x,Min]]},{j,0,Max[0,Exponent[at0p,Lsym]]}]]},
    cz=Join[lc,pc];   (* every x^-k L^j and x^0 L^(j>=1) coefficient must vanish numerically *)
    If[!AllTrue[cz,NumericQ[#]&&Abs[#]<10^-12&],Return[<|"Status"->"ZERO_NONCANCEL","ZeroWordCoefficient"->cz,"Primitive"->primp|>]]];
  at0p=Coefficient[Coefficient[Expand[at0p],Lsym,0],x,0];   (* the x^0 L^0 coefficient; the gated negative powers vanish identically but not syntactically *)
  val=(at1p-at0p)/.backRules[];
  If[!FreeQ[val,_Symbol?(StringStartsQ[SymbolName[#],"lfRoot"|"lfSq"]&)],Return[<|"Status"->"BACKSUB_INCOMPLETE","Primitive"->primp|>]];
  <|"Status"->"ok","Value"->val,"RegulatorCoefficients"->regn,"ZeroWordCoefficient"->cz,"Primitive"->primp|>];

(* ---- half-range integration [0,1/2]: primitive at the interior point 1/2 minus the regularized zero endpoint;
   the [1/2,1] half is the same functional applied to the reflected integrand S(1-y) (item 2, x=1 side: a coefficient
   pole at x=1 is a coefficient pole at y=0 of the reflected primitive, handled by the exact jets). *)
splitPoint=1/2;
mbeLastFoldIntegrateHalf[Sfib_,rb_List,x_Symbol,gnum_]:=Module[{primp,atH,at0p,cz,val},
  xv=x;refusal=None;
  primp=Catch[Total[Map[integrateTerm,DeleteCases[List@@(Expand[Sfib]+Global`zzz)/.Global`zzz->0,0]]],lastfold];
  If[primp===$Failed,Return[<|"Status"->refusal|>]];
  primp=primp/.G[x]->1;
  Module[{dg=derivativeGate[primp,Sfib,x,gnum]},If[!TrueQ[dg["Pass"]],Return[<|"Status"->"PRIMITIVE_DERIVATIVE_FAILED","Residual"->dg["Residual"],"Primitive"->primp|>]]];
  atH=primp/.x->splitPoint;
  If[!FreeQ[atH,ComplexInfinity|Indeterminate|DirectedInfinity],Return[<|"Status"->"MIDPOINT_POLE","Primitive"->primp|>]];
  at0p=Catch[regLimitZero[primp,x],lastfold];
  If[at0p===$Failed,Return[<|"Status"->refusal,"Primitive"->primp|>]];
  Module[{lc=Table[gnum[Coefficient[Coefficient[at0p,x,0],Lsym,j]/.backRules[]],{j,1,Max[1,Exponent[at0p,Lsym]]}],
      pc=Flatten[Table[gnum[Coefficient[Coefficient[at0p,x,-k],Lsym,j]/.backRules[]],{k,1,Max[1,-Exponent[at0p,x,Min]]},{j,0,Max[0,Exponent[at0p,Lsym]]}]]},
    cz=Join[lc,pc];
    If[!AllTrue[cz,NumericQ[#]&&Abs[#]<10^-12&],Return[<|"Status"->"ZERO_NONCANCEL","ZeroWordCoefficient"->cz,"Primitive"->primp|>]]];
  at0p=Coefficient[Coefficient[Expand[at0p],Lsym,0],x,0];
  val=(atH-at0p)/.backRules[];
  If[!FreeQ[val,_Symbol?(StringStartsQ[SymbolName[#],"lfRoot"|"lfSq"]&)],Return[<|"Status"->"BACKSUB_INCOMPLETE","Primitive"->primp|>]];
  <|"Status"->"ok","Value"->val,"RegulatorCoefficients"->{0},"ZeroWordCoefficient"->cz,"Primitive"->primp|>];

(* ---- numerics ---- *)
gsafe[g_G]:=Module[{ls=Most[List@@g],z=Last[g]},If[z===1&&ls=!={}&&SubsetQ[{0,1,-1},ls]&&First[ls]=!=1,(-1)^Count[ls,1]*N[HPL`HPL[ls,1],42],Global`gnumHF[g]]];
lastNumericFailure="";
makeGnum[u0_]:=Function[e,Module[{v=(e/.backRules[])/.u->u0,bad},
  bad=DeleteDuplicates[Cases[v,g_G/;!FreeQ[Most[List@@g],ComplexInfinity|DirectedInfinity[_]|Indeterminate],{0,Infinity}]];
  If[bad=!={},lastNumericFailure=ToString[InputForm[Take[bad,UpTo[2]]]];"NUMERIC_INFINITE_LETTER",
    v=v/.g_G:>gsafe[g];v=N[v,40];
    If[NumericQ[v],v,lastNumericFailure=ToString[InputForm[Take[DeleteDuplicates[Cases[v,_Symbol|_G|_HPL`HPL,{0,Infinity}]],UpTo[3]]]];"NUMERIC_FAILED"]]]];
finiteQ[e_,uc_,x_]:=Module[{v=Quiet@N[e/.u->uc/.x->First[gatePts],30]},NumericQ[v]&&Abs[v]<10^30];
literalQ[l_,c_]:=l===c||TrueQ[Simplify[l-c]==0];   (* a letter that is 0 or 1 identically (in any form) is not an accidental coincidence *)
gatePts={3/10,7/10};   (* interior gate points of the last variable, chosen off every letter pole (gatePointsFor) *)
gatePointsFor[S_,x_,uc_]:=Module[{ls=Select[DeleteDuplicates[Flatten[Cases[S,G[w__,x|1]:>{w},{0,Infinity}]]],!FreeQ[#,x]&],ok},
  ok[xp_]:=AllTrue[ls,Module[{v=Quiet@N[#/.u->uc/.x->xp,30]},NumericQ[v]&&Abs[v]<10^30]&]&&finiteQ[S/.g_G:>1/.x->xp,uc,x];
  Take[Select[{3/10,7/10,2/5,3/5,2/9,5/7,3/11,7/9,1/2,4/9,5/9,1/7},ok,3],UpTo[2]]];
letterOkQ[l_,uc_,x_]:=AllTrue[gatePts,Module[{v=Quiet@N[l/.u->uc/.x->#,30]},NumericQ[v]&&Abs[v]<10^30&&(literalQ[l,0]||Abs[v]>10^-25)&&(literalQ[l,1]||Abs[v-1]>10^-25)]&];
lastTestPointReason="";
pickTestPoint[exprs_List,rb_List,x_,cands_List]:=Module[{ls,singQ,pick},
  ls=DeleteDuplicates[Flatten[Cases[exprs/.rb,G[w__,x|1]:>{w},{0,Infinity}]]];
  singQ[uc_]:=!AllTrue[ls,letterOkQ[#,uc,x]&]||!AllTrue[exprs,finiteQ[(#/.rb)/.g_G:>1,uc,x]&];
  pick=SelectFirst[cands,!singQ[#]&,None];
  If[pick===None,Module[{uc=First[cands],badL,badE},
    badL=Select[ls,!letterOkQ[#,uc,x]&];badE=Select[exprs,!finiteQ[(#/.rb)/.g_G:>1,uc,x]&];
    lastTestPointReason=ToString[InputForm[Take[badL,UpTo[3]]]]<>If[badE=!={}," coefficient singular",""]]];
  pick];
(* ---- the defect condition of the integrator's last fold ---- *)
mbeLastFoldCoalescenceQ[S_,x_Symbol,u0_]:=Module[{ls,lim,hits={},pairs={}},
  ls=DeleteDuplicates[Flatten[Cases[S,G[w__,1]:>{w},{0,Infinity}]]];ls=Select[ls,!FreeQ[#,x]&];
  lim[l_,pt_]:=Quiet@Check[Limit[l/.u->u0,x->pt],Indeterminate];
  Do[Module[{v=lim[l,pt]},
    Which[v===0,AppendTo[hits,{l,pt,"->0"}],v===1,AppendTo[hits,{l,pt,"->1"}],!NumericQ[v],AppendTo[hits,{l,pt,"->"<>ToString[v]}]]],{l,ls},{pt,{0,1}}];
  Do[If[i<j,Module[{d=lim[ls[[i]]-ls[[j]],pt]},If[d===0,AppendTo[pairs,{ls[[i]],ls[[j]],pt}]]]],{i,Length[ls]},{j,Length[ls]},{pt,{0,1}}];
  <|"Coalescing"->(hits=!={}||pairs=!={}),"EndpointHits"->hits,"PairHits"->pairs,"MovingLetters"->Length[ls]|>];
(* ---- cross-check against the engine's own n-fold value (dev gate) ---- *)
Options[mbeLastFoldEngineCrossCheck]={"Engine"->Automatic,"EngineSeconds"->2400};
mbeLastFoldEngineCrossCheck[job_Association,order_List,exact_,gnum_,OptionsPattern[]]:=Module[{r,run,S,ve,vx},
  r=job["request"];r["vars_int"]=order;r["vars_int_from"]=ConstantArray["0",Length[order]];r["vars_int_to"]=ConstantArray["1",Length[order]];r["check_divergences"]=True;
  run=engineRun[r,lastFoldEngine[OptionValue["Engine"]],OptionValue["EngineSeconds"]];
  If[run["Status"]=!="ok",Return[<|"Engine"->run["Status"],"Reason"->Lookup[run,"Reason",""],"Agree"->None|>]];
  S=parseResponse[run["Response"]];If[S===$Failed,Return[<|"Engine"->"CONTOUR_TAGS","Agree"->None|>]];
  ve=gnum[S];vx=gnum[exact];
  If[!(NumericQ[ve]&&NumericQ[vx]),Return[<|"Engine"->"ok","EngineNumeric"->ve,"ExactNumeric"->vx,"Agree"->None|>]];
  <|"Engine"->"ok","EngineNumeric"->ve,"ExactNumeric"->vx,"Rel"->Abs[ve-vx]/Max[1,Abs[vx]],"Agree"->(Abs[ve-vx]/Max[1,Abs[vx]]<10^-15)|>];
(* item 1 of the rung as a function of its own (release R3.1, 4 October 2026: the u-dependent Subtraction ladder asks the
   same question before it spends time on a cube candidate, so that both always get the same answer) *)
mbeLastFoldCertificate[job_Association]:=Module[{f=ToExpression[job["request"]["expr"],InputForm],vs=Symbol["Global`"<>#]&/@job["request"]["vars_int"]},
  If[!ValueQ[MBJobConvergence`mbeJobConvergenceCertificate],Get[FileNameJoin[{$mbeLastFoldRungDir,"mbeJobConvergenceRung.m"}]]];
  Quiet@TimeConstrained[MBJobConvergence`mbeJobConvergenceCertificate[f,vs,"ParameterAssumptions"->0<u<1],600,<|"Certified"->False,"Reason"->"certificate timeout"|>]];

(* ---- the rung ---- *)
Options[mbeExactLastFold]={"Order"->Automatic,"Engine"->Automatic,"TestPoint"->1/3,"Basepoint"->Automatic,
  "OutSuffix"->"","RequestsFile"->Automatic,"Write"->True,"CrossCheck"->False,"EngineSeconds"->2400,"Log"->Print,"RequireCertificate"->True,"SplitAtHalf"->False};
mbeExactLastFold[gdir_String,jid_String,OptionsPattern[]]:=Module[{log=OptionValue["Log"],reqFile,req,job,order,xName,x,head,st,S0,fb,Sfib,rb,cands,u0,gnum,gnumAny,gate1,co,ig,value,vnum,cc,rec,file,t0,tf,cert},
  reqFile=If[OptionValue["RequestsFile"]===Automatic,gdir<>"/requests.json",OptionValue["RequestsFile"]];
  req=Import[reqFile,"RawJSON"];If[!KeyExistsQ[req,"jobs"],req=<|"jobs"->{req}|>];job=SelectFirst[req["jobs"],#["id"]===jid&];
  If[!AssociationQ[job],Return[<|"Status"->"NO_SUCH_JOB"|>]];
  order=If[OptionValue["Order"]===Automatic,job["orders"][[1]],OptionValue["Order"]];
  If[Sort[order]=!=Sort[job["request"]["vars_int"]],log["ORDER_MISMATCH ",order," vs vars_int ",job["request"]["vars_int"]];Return[<|"Status"->"ORDER_MISMATCH"|>]];   (* requests.json can list orders of a reduced representation (MB14au r51 s2) *)
  xName=Last[order];x=Symbol["Global`"<>xName];head=Most[order];
  (* item 1: exact convergence certificate of the job on the cube (Bernstein positive models + endpoint power count);
     an uncertified job is integrated only as part of its union sum, never as a singleton *)
  cert=mbeLastFoldCertificate[job];
  log["CONVERGENCE_CERTIFICATE certified ",cert["Certified"]," minimum ",Lookup[cert,"Minimum",""]," ",Lookup[cert,"Reason",""]];
  If[TrueQ[OptionValue["RequireCertificate"]]&&!TrueQ[cert["Certified"]],log["UNCERTIFIED_SINGLETON"];Return[<|"Status"->"UNCERTIFIED_SINGLETON","Certificate"->cert|>]];
  t0=AbsoluteTime[];
  st=mbeLastFoldStage1[gdir,job,order,"Engine"->lastFoldEngine[OptionValue["Engine"]],"OutSuffix"->OptionValue["OutSuffix"],"RequestsFile"->reqFile,"EngineSeconds"->OptionValue["EngineSeconds"]];
  If[st["Status"]=!="ok",log[st["Status"]," ",Lookup[st,"Reason",""]];Return[st]];
  S0=st["S"];
  log["STAGE1 ok ",Round[AbsoluteTime[]-t0]," s, terms ",st["Terms"]];
  log["S: ",Length[List@@(S0+Global`zzz)]-1," terms, ",Length[DeleteDuplicates[Cases[S0,_G,{0,Infinity}]]]," words"];
  tf=AbsoluteTime[];
  fb=mbeLastFoldFibrate[S0,x,If[OptionValue["Basepoint"]===Automatic,u/2,OptionValue["Basepoint"]]];
  If[fb["Status"]=!="ok",log[fb["Status"]];Return[Join[fb,<|"Stage1"->KeyDrop[st,"S"]|>]]];
  Sfib=fb["Sfib"];rb=fb["RootBack"];S0=fb["S"];
  log["FIBRATION done ",Round[AbsoluteTime[]-tf]," s; algebraic constants ",Length[fb["AlgebraicConstants"]]];
  cands=DeleteDuplicates[Join[{OptionValue["TestPoint"]},{2/7,3/11,5/17,7/23,4/15}]];
  gatePts=gatePointsFor[S0/.rb,x,First[cands]];
  If[Length[gatePts]<2,log["GATEPOINTS_REFUSED"];Return[<|"Status"->"GATEPOINTS_REFUSED"|>]];
  log["GATEPOINTS ",gatePts];
  u0=pickTestPoint[{S0,Sfib},rb,x,cands];
  If[u0===None,log["TESTPOINT_REFUSED after fibration: ",lastTestPointReason];Return[<|"Status"->"TESTPOINT_REFUSED","Reason"->lastTestPointReason|>]];
  log["TESTPOINT after fibration u0 = ",u0];
  gnum=makeGnum[u0];
  gnumAny=Function[e,Module[{r="NUMERIC_FAILED"},Do[r=makeGnum[uc][e];If[NumericQ[r],u0=uc;Break[]],{uc,Prepend[DeleteCases[cands,u0],u0]}];r]];   (* the exact result never depends on the test point *)
  gate1=Table[{xp,gnum[S0/.x->xp],gnum[(Sfib/.rb)/.x->xp]},{xp,gatePts}];
  Do[log["GATE1 x=",g[[1]]," S ",g[[2]]," Sfib ",g[[3]]],{g,gate1}];
  If[!AllTrue[gate1,NumericQ[#[[2]]]&&NumericQ[#[[3]]]&&Abs[#[[2]]-#[[3]]]<10^-12&],log["GATE1_FAILED ",lastNumericFailure];Return[<|"Status"->"GATE1_FAILED","Gate1"->gate1,"Reason"->lastNumericFailure|>]];
  co=mbeLastFoldCoalescenceQ[S0,x,u0];
  log["COALESCENCE ",co["Coalescing"]," endpoint hits ",Length[co["EndpointHits"]]," pair hits ",Length[co["PairHits"]]];
  ig=If[TrueQ[OptionValue["SplitAtHalf"]],<|"Status"->"ENDPOINT_POLE_AT_ONE"|>,mbeLastFoldIntegrate[Sfib,rb,x,gnumAny]];
  If[ig["Status"]==="ENDPOINT_POLE_AT_ONE",
    (* split at 1/2: [0,1/2] from the fibration above, [1/2,1] from the fibration of the reflected integrand S(1-y) *)
    Module[{igA,SR,fbR,igB,sp,ls},
      (* the split point must not coincide with a letter of either fibration at any numeric test point (r38: a root
         equals 1/2 exactly at u=1/3); the exact result does not depend on it *)
      ls=DeleteDuplicates[Flatten[Cases[Sfib/.rb,G[ww__,x]:>{ww},{0,Infinity}]]];
      sp=SelectFirst[{1/2,2/5,3/5,3/7,4/7,5/11,6/11,5/13,8/13},Function[sc,AllTrue[cands,Function[uc,AllTrue[ls,Module[{v=Quiet@N[#/.u->uc,30]},!NumericQ[v]||Abs[v-sc]>10^-12&&Abs[v-(1-sc)]>10^-12]&]]]],None];
      If[sp===None,log["SPLITPOINT_REFUSED"];Return[<|"Status"->"SPLITPOINT_REFUSED"|>]];
      splitPoint=sp;
      log["SPLIT_AT ",sp,": reflected fibration for the [",sp,",1] half"];
      igA=mbeLastFoldIntegrateHalf[Sfib,rb,x,gnumAny];
      If[igA["Status"]=!="ok",log["HALF_A ",igA["Status"]," ",Lookup[igA,"ZeroWordCoefficient",Lookup[igA,"Residual",""]]," numeric failure: ",lastNumericFailure];Return[Join[KeyDrop[igA,"Primitive"],<|"Stage1"->KeyDrop[st,"S"]|>]]];
      SR=Expand[S0/.x->1-x];SR=SR/.G[ws__,1]:>G[Sequence@@(Together/@{ws}),1];
      splitPoint=1-sp;   (* the reflected half runs over y in [0,1-sp] *)
      fbR=mbeLastFoldFibrate[SR,x,(1-sp)/2];
      If[fbR["Status"]=!="ok",log["HALF_B_FIB ",fbR["Status"]];Return[<|"Status"->fbR["Status"],"Stage1"->KeyDrop[st,"S"]|>]];
      log["REFLECTED FIBRATION done; algebraic constants ",Length[fbR["AlgebraicConstants"]]];
      igB=mbeLastFoldIntegrateHalf[fbR["Sfib"],fbR["RootBack"],x,gnumAny];
      If[igB["Status"]=!="ok",log["HALF_B ",igB["Status"]," ",Lookup[igB,"ZeroWordCoefficient",Lookup[igB,"Residual",""]]," numeric failure: ",lastNumericFailure];Return[Join[KeyDrop[igB,"Primitive"],<|"Stage1"->KeyDrop[st,"S"]|>]]];
      log["HALVES ",gnumAny[igA["Value"]]," + ",gnumAny[igB["Value"]]];
      ig=<|"Status"->"ok","Value"->igA["Value"]+igB["Value"],"RegulatorCoefficients"->{0},"ZeroWordCoefficient"->Join[igA["ZeroWordCoefficient"],igB["ZeroWordCoefficient"]],"Primitive"->igA["Primitive"]|>]];
  If[ig["Status"]=!="ok",log[ig["Status"]," ",Lookup[ig,"RegulatorCoefficients",Lookup[ig,"ZeroWordCoefficient",""]]," ",lastNumericFailure];Return[Join[KeyDrop[ig,"Primitive"],<|"Stage1"->KeyDrop[st,"S"]|>]]];
  log["PIECE 1 regulator coefficients ",N[ig["RegulatorCoefficients"],10]];
  value=ig["Value"];
  rb=backRules[];
  Module[{u1=pickTestPoint[{S0,Sfib,ig["Primitive"]},rb,x,cands]},If[u1=!=None&&u1=!=u0,u0=u1;gnum=makeGnum[u0];log["TESTPOINT after integration u0 = ",u0]]];
  vnum=gnumAny[value];gnum=makeGnum[u0];
  log["VALUE u=",u0," ",vnum];
  If[!NumericQ[vnum],log["NUMERIC_FAILED ",lastNumericFailure];Return[<|"Status"->"NUMERIC_FAILED","Value"->value,"Reason"->lastNumericFailure|>]];
  cc=If[TrueQ[OptionValue["CrossCheck"]],mbeLastFoldEngineCrossCheck[job,order,value,gnum,"Engine"->lastFoldEngine[OptionValue["Engine"]],"EngineSeconds"->OptionValue["EngineSeconds"]],None];
  If[cc=!=None,log["ENGINE_CROSSCHECK ",cc["Engine"]," ",Lookup[cc,"Reason",""]," engine ",Lookup[cc,"EngineNumeric",""]," exact ",Lookup[cc,"ExactNumeric",""]," agree ",cc["Agree"]]];
  rec=<|"ID"->jid,"Order"->order,"LastVariable"->xName,"Stage1Hash"->st["Hash"],"RequestHash"->st["RequestHash"],"Stage1Order"->head,"ScanOn"->True,"Stage1File"->st["File"],
    "Value"->value,"Breakpoints"->{0,1},"Rationalization"->{},"ValueAt"-><|"u"->u0,"numeric"->ToString[vnum]|>,
    "Coalescence"->co,"EngineCrossCheck"->cc,"RegulatorCoefficients"->ToString/@N[ig["RegulatorCoefficients"],10],"ConvergenceCertificate"->KeyDrop[cert,"Audit"],
    "Tool"->"mbeExactLastFoldRung.m v1 whole-range","Date"->DateString[]|>;
  file=gdir<>"/lastfold_"<>jid<>OptionValue["OutSuffix"]<>".m";
  If[TrueQ[OptionValue["Write"]],Put[rec,file];log["LASTFOLD_DONE ",gdir," job ",jid," file lastfold_",jid,OptionValue["OutSuffix"],".m"]];
  Join[<|"Status"->"LASTFOLD_DONE","RecordFile"->file,"Gate1"->gate1|>,rec]];
End[];
EndPackage[];
