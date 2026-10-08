(* Exact endpoint power counting for products of positive sums of cube
   monomials. A signed index +i means x_i, -i means 1-x_i. Multiplicity
   encodes integer powers. Denominator coefficients must be positive.
   This helper audits an abstract positive model; a caller must bind it
   to the original source. It never computes an integral coefficient. *)
Clear[pcpRationalQ,pcpSupportsAt,pcpAudit];
pcpRationalQ[q_] := IntegerQ[q]||Head[q]===Rational;
pcpSupportsAt[den_List,vertex_List] := Table[
  Table[Count[term,If[vertex[[ii]]===0,ii,-ii]],{ii,Length[vertex]}],{term,den}];
pcpAudit[low_List,high_List,denominators_List,powers_List] := Module[
  {n=Length[low],rates,ds,variables,all={},support,nu,cost,constraints,opt,
   witness,exactCost,record,start=AbsoluteTime[]},
  If[n===0||Length[high]=!=n||Length[denominators]=!=Length[powers]||
    !AllTrue[Join[low,high,powers],pcpRationalQ]||!AllTrue[powers,#>=0&]||
    !AllTrue[denominators,ListQ[#]&&Length[#]>0&&AllTrue[#,
       ListQ[#]&&AllTrue[#,IntegerQ[#]&&1<=Abs[#]<=n&]&]&],
    Return[<|"Complete"->False,"Reason"->"positive monomial model"|>]];
  rates=Table[Unique["pcRate"],{n}];ds=Table[Unique["pcDegree"],{Length[powers]}];
  variables=Join[rates,ds];
  Do[
    support=pcpSupportsAt[#,vertex]&/@denominators;
    nu=MapThread[If[#3===0,#1,#2]&,{low,high,vertex}];
    cost=(nu+1).rates-powers.ds;
    constraints=Join[Thread[rates>=0],{Total[rates]==1},Thread[ds>=0],
      Flatten[Table[Thread[support[[jj]].rates>=ds[[jj]]],{jj,Length[ds]}]]];
    opt=Quiet@TimeConstrained[Minimize[{cost,And@@constraints},variables,Reals],8,$Failed];
    If[!MatchQ[opt,{_?pcpRationalQ,{___Rule}}],
      Return[<|"Complete"->False,"Reason"->"exact linear optimization","Vertex"->vertex,"Result"->opt|>]];
    witness=rates/.opt[[2]];
    exactCost=(nu+1).witness-Sum[powers[[jj]]Min[support[[jj]].witness],{jj,Length[ds]}];
    If[!AllTrue[witness,pcpRationalQ[#]&&#>=0&]||Total[witness]=!=1||exactCost=!=opt[[1]],
      Return[<|"Complete"->False,"Reason"->"rate witness consistency","Vertex"->vertex|>]];
    record=<|"Vertex"->vertex,"Minimum"->opt[[1]],"Rates"->witness|>;
    AppendTo[all,record],{vertex,Tuples[{0,1},n]}];
  <|"Complete"->True,"LowPowers"->low,"HighPowers"->high,
    "DenominatorSupports"->denominators,"DenominatorPowers"->powers,
    "Minimum"->Min[Lookup[all,"Minimum"]],"Integrable"->AllTrue[all,#["Minimum"]>0&],
    "VertexCount"->Length[all],"Vertices"->all,"Seconds"->AbsoluteTime[]-start|>];
