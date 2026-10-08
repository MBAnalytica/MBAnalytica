(* Exact local moments with logarithmic dressing, before epsilon expansion.
   The eliminated variable occurs only in log(x)^m/(A+B x)^p, with
   integer m>=0,p>=1 and certified positive affine endpoints. *)
almReduceCube[cube_,vars_List,ep_]:=Module[
 {factors,dependent,rest,power,logPower,base,aa,bb,other,result,aux,reflected,expr},
 Do[reflected=If[flip,cube/.xx->1-xx,cube];
   factors=If[Head[reflected]===Times,List@@reflected,{reflected}];
   dependent=Select[factors,!FreeQ[#,xx]&];rest=Times@@Select[factors,FreeQ[#,xx]&];
   logPower=0;power=None;
   Do[Which[
     fac===Log[xx],logPower++,
     MatchQ[fac,Power[Log[xx],_Integer?NonNegative]],logPower+=fac[[2]],
     MatchQ[fac,Power[_,_Integer?Negative]]&&power===None,power=fac,
     True,power=$Failed;Break[]],{fac,dependent}];
   If[power===None||power===$Failed,Continue[]];
   base=Expand[power[[1]]];
   If[!PolynomialQ[base,xx]||Exponent[base,xx]=!=1,Continue[]];
   If[TrueQ[(base/.Thread[vars->1/2])<0],rest*=(-1)^power[[2]];base=-base];
   aa=Expand[base/.xx->0];bb=Coefficient[base,xx];other=DeleteCases[vars,xx];
   If[!alePositiveQ[aa,other]||!alePositiveQ[Expand[aa+bb],other]||
     !(alePositiveQ[bb,other]||alePositiveQ[-bb,other]),Continue[]];
   aux=Unique["almAffineConstant"];
   expr=(-1)^(logPower+1)Factorial[logPower]PolyLog[logPower+1,-bb/aux]/bb;
   result=rest ((-1)^(-power[[2]]-1)/Factorial[-power[[2]]-1])
     (D[expr,{aux,-power[[2]]-1}]/.aux->aa);
   Return[<|"Reduced"->True,"Class"->"AffineLogMoment","Cube"->result,"Vars"->other,
     "Variable"->xx,"Reflected"->flip,"LogPower"->logPower,"DenominatorPower"->-power[[2]],
     "AffineConstant"->aa,"AffineSlope"->bb,"PositiveEndpoints"->True,
     "OriginalCube"->cube,"OriginalVariables"->vars|>,Module],
   {xx,vars},{flip,{False,True}}];
 <|"Reduced"->False,"Reason"->"no admitted affine logarithmic moment"|>];

Print["[mbeAffineLogMomentRung] prototype: positive affine integer-pole logarithmic moments."];
