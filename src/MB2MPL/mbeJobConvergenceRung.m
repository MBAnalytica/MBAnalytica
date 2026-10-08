(* ::Package:: *)
(* mbeJobConvergenceRung.m (2026-09-25): item 1 of the Subtraction-route saturation list, an EXACT convergence
   certificate for an eps-free native coefficient job BEFORE any integration.  A job integrand is
     N(x) * prod_j P_j(x)^(-p_j) * (logarithms),   N a monomial in the atoms x_i, 1-x_i (up to sign), P_j polynomials.
   Each P_j is expanded in the multivariate Bernstein basis  prod_i x_i^k_i (1-x_i)^(d_i-k_i)  (degree elevation up to
   "Elevation" steps): non-negative Bernstein coefficients with a strict positive minimum certify P_j > 0 on the open cube
   and give its atom-monomial support.  The positive model then goes through the exact endpoint power count of
   mbePositiveCubePowerCount.m (pcpAudit: exact linear programs at every vertex).  A strictly positive minimum
   certifies absolute convergence of the job on the cube (logarithms are absorbed by the strict margin, theory:
   subtraction_syed.tex 'A generic test of every simultaneous endpoint scaling').  A job that is NOT certified must be
   integrated only as part of its union sum (Step 4), never alone.  Nothing here evaluates an integral. *)
BeginPackage["MBJobConvergence`"];
mbeJobConvergenceCertificate::usage="mbeJobConvergenceCertificate[expr,vars,opts] -> <|\"Certified\"->True|False,\"Minimum\"->..,\"Reason\"->..,\"Model\"->..|> for an eps-free integrand over the unit cube in vars (parameters must be positive on their domain: option \"ParameterAssumptions\").";
mbeBernsteinModel::usage="mbeBernsteinModel[poly,vars,elevation] -> <|\"Positive\"->True|False,\"Terms\"->{signed index lists},\"Coefficients\"->..|>.";
Begin["`Private`"];
Get[FileNameJoin[{DirectoryName[$InputFileName],"mbePositiveCubePowerCount.m"}]];
bernstein1[poly_,x_,d_]:=Module[{c=CoefficientList[poly,x],n},n=Length[c]-1;
  If[n>d,Return[$Failed]];
  (* Bernstein coefficients b_k = sum_{j<=k} C(k,j)/C(d,j) a_j *)
  Table[Sum[Binomial[k,j]/Binomial[d,j]*If[j<=n,c[[j+1]],0],{j,0,k}],{k,0,d}]];
bernsteinMulti[poly_,vars_,degs_]:=Module[{p=poly,coeffs},
  (* iterated: expand in x_1 then each Bernstein coefficient (a polynomial in the other variables) in x_2, ... *)
  coeffs=<|{}->poly|>;
  Do[Module[{new=<||>},
    Do[Module[{b=bernstein1[coeffs[key],vars[[i]],degs[[i]]]},If[b===$Failed,Return[$Failed,Module]];
      Do[new[Append[key,k]]=Together[b[[k+1]]],{k,0,degs[[i]]}]],{key,Keys[coeffs]}];
    coeffs=new],{i,Length[vars]}];
  coeffs];
Options[mbeBernsteinModel]={"Elevation"->3,"ParameterAssumptions"->True};
mbeBernsteinModel[poly_,vars_List,OptionsPattern[]]:=Module[{degs0,dom=OptionValue["ParameterAssumptions"],result=$Failed},
  degs0=Exponent[poly,#]&/@vars;
  Do[Module[{degs=degs0+e,cf,pos,terms},
    cf=bernsteinMulti[poly,vars,degs];
    If[cf===$Failed,Continue[]];
    pos=AllTrue[Values[cf],TrueQ[Simplify[#>=0,Assumptions->dom]]&]&&AnyTrue[Values[cf],TrueQ[Simplify[#>0,Assumptions->dom]]&];
    If[pos,
      terms=Table[Join[Flatten[Table[ConstantArray[i,key[[i]]],{i,Length[vars]}]],Flatten[Table[ConstantArray[-i,degs[[i]]-key[[i]]],{i,Length[vars]}]]],{key,Select[Keys[cf],!TrueQ[Simplify[cf[#]==0,Assumptions->dom]]&]}];
      result=<|"Positive"->True,"Degrees"->degs,"Elevation"->e,"Terms"->terms,"Coefficients"->cf|>;Break[]]],{e,0,OptionValue["Elevation"]}];
  If[result===$Failed,<|"Positive"->False,"Reason"->"no non-negative Bernstein expansion up to elevation "<>ToString[OptionValue["Elevation"]]|>,result]];
(* 09-26 (v2 "Pareto" numerator model): the product of the numerator factors' Bernstein majorants enters the
   endpoint power count through min_k s_k.w at every vertex; that minimum over a Minkowski sum of supports is attained
   on componentwise-MINIMAL exponent vectors, and the Pareto front of a Minkowski sum is contained in the Minkowski sum
   of the factors' Pareto fronts.  So the per-vertex term set is built as a pruned Minkowski sum (tens of vectors),
   never as the Cartesian product of all Bernstein terms (which the v1 model capped at 400 and then replaced by the
   supremum majorant, losing every numerator zero: MB8au r12 j57 was refused with minimum -3 although its cutoff scans
   converge).  Sound and no less sharp than the full product model. *)
paretoMinimal[vecs_List]:=Module[{s=SortBy[DeleteDuplicates[vecs],Total],keep={}},
  Do[If[!AnyTrue[keep,AllTrue[Thread[#<=v],TrueQ]&],AppendTo[keep,v]],{v,s}];keep];
minkowskiPareto[A_List,B_List]:=paretoMinimal[Flatten[Outer[Plus,A,B,1],1]];
vertexLP[nu_List,denSupports_List,powers_List,tmo_]:=Module[{n=Length[nu],rates,ds,cost,constraints,opt,witness,exactCost},
  rates=Table[Unique["pcRate"],{n}];ds=Table[Unique["pcDegree"],{Length[powers]}];
  cost=(nu+1).rates-If[powers==={},0,powers.ds];
  constraints=Join[Thread[rates>=0],{Total[rates]==1},Thread[ds>=0],Flatten[Table[Thread[denSupports[[jj]].rates>=ds[[jj]]],{jj,Length[ds]}]]];
  opt=Quiet@TimeConstrained[Minimize[{cost,And@@constraints},Join[rates,ds],Reals],tmo,$Failed];
  If[!MatchQ[opt,{_?pcpRationalQ,{___Rule}}],Return[$Failed]];
  witness=rates/.opt[[2]];
  exactCost=(nu+1).witness-Sum[powers[[jj]]Min[denSupports[[jj]].witness],{jj,Length[ds]}];
  If[!AllTrue[witness,pcpRationalQ[#]&&#>=0&]||Total[witness]=!=1||exactCost=!=opt[[1]],Return[$Failed]];
  <|"Minimum"->opt[[1]],"Rates"->witness|>];
Options[mbeJobConvergenceCertificate]={"Elevation"->3,"ParameterAssumptions"->True,"MaxNumeratorTerms"->400,"NumeratorModel"->"Pareto","LPTimeout"->8};
mbeJobConvergenceCertificate[expr_,vars_List,OptionsPattern[]]:=Module[{dom=OptionValue["ParameterAssumptions"],e,fs,low,high,dens={},pows={},logs=0,model,audit,bad=None,numTerms,numNote="",numFacs={},pareto=OptionValue["NumeratorModel"]==="Pareto",n=Length[vars]},
  e=Together[expr/.Log[_]->1];
  low=ConstantArray[0,Length[vars]];high=ConstantArray[0,Length[vars]];
  fs=FactorList[Numerator[e]];
  (* numerator: atoms shift the exponents; any other polynomial factor is expanded in the Bernstein basis and the
     integrand is majorized term by term (|sum| <= sum |c_k| * monomial_k): every Bernstein monomial must pass, which
     keeps the vanishing structure of the factor at the faces (sound majorant; sufficiency may be lost) *)
  numTerms={{ConstantArray[0,Length[vars]],ConstantArray[0,Length[vars]]}};   (* list of {lowShift,highShift} *)
  Do[Module[{f=fac[[1]],m=fac[[2]],i,cf,degs,keys},
    Which[FreeQ[f,Alternatives@@vars],Null,
      (i=Position[vars,f])=!={},low[[i[[1,1]]]]+=m,
      (i=Position[vars,Expand[1-f]])=!={},high[[i[[1,1]]]]+=m,
      (i=Position[vars,Expand[f+1]])=!={},high[[i[[1,1]]]]+=m,   (* f = x-1 = -(1-x) *)
      True,degs=Exponent[f,#]&/@vars;cf=bernsteinMulti[f,vars,degs];
        If[cf===$Failed,bad="numerator Bernstein expansion failed: "<>ToString[InputForm[f]],
          keys=Select[Keys[cf],!TrueQ[Simplify[cf[#]==0,Assumptions->dom]]&];
          If[pareto,AppendTo[numFacs,{keys,degs,m}],
            Do[numTerms=Flatten[Table[{t[[1]]+k,t[[2]]+(degs-k)},{t,numTerms},{k,keys}],1],{m}]]]]],{fac,fs}];
  If[bad=!=None,Return[<|"Certified"->False,"Reason"->bad|>]];
  If[!pareto&&Length[numTerms]>OptionValue["MaxNumeratorTerms"],numTerms={{ConstantArray[0,Length[vars]],ConstantArray[0,Length[vars]]}};numNote="numerator polynomials majorized by their supremum (Bernstein expansion too large)",numNote=""];   (* a polynomial is bounded on the closed cube: dropping it is a sound majorant that loses its vanishing structure *)
  Do[Module[{f=fac[[1]],m=fac[[2]],i,bm},
    Which[FreeQ[f,Alternatives@@vars],Null,
      (i=Position[vars,f])=!={},low[[i[[1,1]]]]-=m,
      (i=Position[vars,Expand[1-f]])=!={},high[[i[[1,1]]]]-=m,
      (i=Position[vars,Expand[f+1]])=!={},high[[i[[1,1]]]]-=m,
      True,bm=mbeBernsteinModel[If[TrueQ[Simplify[(f/.Thread[vars->1/2])<0,Assumptions->dom]],-f,f],vars,"Elevation"->OptionValue["Elevation"],"ParameterAssumptions"->dom];
        If[!TrueQ[bm["Positive"]],bad="denominator factor without positive model: "<>ToString[InputForm[f]],AppendTo[dens,bm["Terms"]];AppendTo[pows,m]]]],{fac,FactorList[Denominator[e]]}];
  If[bad=!=None,Return[<|"Certified"->False,"Reason"->bad|>]];
  If[pareto,
    Module[{recs,tmo=OptionValue["LPTimeout"],failed=None,maxTerms=0},
      recs=Table[Module[{nu0=MapThread[If[#3===0,#1,#2]&,{low,high,vertex}],sup=pcpSupportsAt[#,vertex]&/@dens,S={ConstantArray[0,n]},vals},
          Do[Module[{V=paretoMinimal[Table[Table[If[vertex[[i]]===0,k[[i]],nf[[2,i]]-k[[i]]],{i,n}],{k,nf[[1]]}]]},Do[S=minkowskiPareto[S,V],{nf[[3]]}]],{nf,numFacs}];
          maxTerms=Max[maxTerms,Length[S]];
          vals=Table[vertexLP[nu0+s,sup,pows,tmo],{s,S}];
          If[MemberQ[vals,$Failed],failed=vertex;$Failed,<|"Vertex"->vertex,"Minimum"->Min[Lookup[vals,"Minimum"]],"Terms"->Length[S]|>]],{vertex,Tuples[{0,1},n]}];
      If[failed=!=None,Return[<|"Certified"->False,"Reason"->"power count incomplete: exact linear optimization at vertex "<>ToString[failed]|>]];
      Return[<|"Certified"->AllTrue[recs,#["Minimum"]>0&],"Minimum"->Min[Lookup[recs,"Minimum"]],"LowPowers"->low,"HighPowers"->high,"NumeratorFactors"->Length[numFacs],"NumeratorTerms"->maxTerms,"DenominatorTerms"->Length/@dens,"Note"->"Pareto/Minkowski numerator model (v2)","Vertices"->recs|>]]];
  Module[{audits,minAll},
    audits=Table[If[dens==={},pcpAudit[low+t[[1]],high+t[[2]],{{{1}}},{0}],pcpAudit[low+t[[1]],high+t[[2]],dens,pows]],{t,numTerms}];
    If[!AllTrue[audits,TrueQ[#["Complete"]]&],Return[<|"Certified"->False,"Reason"->"power count incomplete: "<>ToString[Lookup[SelectFirst[audits,!TrueQ[#["Complete"]]&],"Reason",""]]|>]];
    minAll=Min[Lookup[audits,"Minimum"]];
    <|"Certified"->AllTrue[audits,TrueQ[#["Integrable"]]&],"Minimum"->minAll,"LowPowers"->low,"HighPowers"->high,"NumeratorTerms"->Length[numTerms],"DenominatorTerms"->Length/@dens,"Note"->numNote|>]];
End[];
EndPackage[];
