(* A derivative certificate for rational-coefficient polynomials in GPLs
   whose letters are independent of the differentiated endpoint.  The
   defining iterated integral gives d G[a,w;x]/dx = G[w;x]/(x-a), at every
   weight.  Variable letters and nonrational coefficients are refused. *)
gfdDerivative[expr_, xx_] := Module[
  {words, atoms, polynomial, coefficients, heads, functions, derivativeRules, result},
  words = DeleteDuplicates[Cases[expr, g_PolyLogTools`G /; ! FreeQ[g, xx], {0, Infinity}]];
  If[! AllTrue[words, Last[#] === xx && Length[#] >= 2 && FreeQ[Most[List @@ #], xx] &], Return[$Failed]];
  atoms = Table[Unique["gfdAtom"], {Length[words]}];
  polynomial = expr /. Thread[words -> atoms];
  If[atoms =!= {} && ! PolynomialQ[polynomial, atoms], Return[$Failed]];
  coefficients = If[atoms === {}, {polynomial}, Last /@ CoefficientRules[polynomial, atoms]];
  If[! AllTrue[coefficients, With[{rat = Together[#]},
      PolynomialQ[Numerator[rat], xx] && PolynomialQ[Denominator[rat], xx]] &], Return[$Failed]];
  heads = Table[Unique["gfdFunction"], {Length[words]}];
  functions = #[xx] & /@ heads;
  derivativeRules = Table[With[{ff = heads[[jj]], word = List @@ words[[jj]]},
    Derivative[1][ff][xx] -> (PolyLogTools`G @@ Rest[word])/(xx - First[word])], {jj, Length[words]}];
  result = D[polynomial /. Thread[atoms -> functions], xx] /. derivativeRules /.
    Thread[functions -> words];
  If[! FreeQ[result, Alternatives @@ heads], $Failed, result]];

Print["[mbeFixedLetterGPLRung] arbitrary-weight endpoint derivatives with constant letters and rational coefficients."];
