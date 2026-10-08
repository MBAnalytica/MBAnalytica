(*  BarnesRoutines.m 

    David A. Kosower

    Version 1.1.1, July 22, 2009

      Package to automate application of Barnes lemmas to Mellin-Barnes
   integrals.  Intended for use with the output of Czakon's MB.

      There are six externally-visible routines,
   Process; DoBarnes1; DoBarnes2; DoAllBarnes; ExpandInt and SetVerbosity.

   The first two apply the first and second Barnes lemmas to a Mellin-Barnes
   integral, represented as in MB by an MBint object.  Both try to make
   linear changes of variables in order to enable the use of the Barnes
   lemmas.  The application of the Barnes lemmas includes some derivatives
   of the first Barnes lemma, and some corollaries of the second due to
   V. A. Smirnov.  The third routine, DoAllBarnes, applies the Barnes lemmas
   repeatedly to a list of functions.  It has an optional second argument,
   which if True, applies the lemmas to integrals of decreasing dimension
   starting with the highest-dimensional one.  All these routines have a
   last optional argument, which specifies a bound on the absolute value of
   integer coefficients in linear transformations.  For some massive integrals,
   it may be useful to set this to 2 instead of the default value of 1.

*)

Print["Barnes Routines, v 1.1.0 of June 5, 2009"];

(* Need to repair FindInstance in version 6.0; otherwise it will effectively
   hang when multiple points are requested *)
If [$VersionNumber >= 6,
   SetSystemOptions["ReduceOptions"->{"RandomInstances"->True}]];

BeginPackage["BarnesRoutines`"];

DoAllBarnes::usage = \
"DoAllBarnes[intlist_List,progressive_:False,bound_:1] repeatedly applies \
the Barnes lemmas to a list of integrals.  It first applies the second \
Barnes lemma, then the first Barnes lemma.  If the second argument is True, \
the lemmas are progressively applied to integrals of decreasing dimension \
starting with the highest-dimensional ones.  The last argument is passed to \
DoBarnes1 and DoBarnes2.";

DoBarnes1::usage = \
"DoBarnes1[int_MBint,bound_:1] applies the first Barnes lemma to the given \
MB integral.  It first looks for a linear transformation of the integration \
variables which will make such an application possible. The optional argument \
specifies a bound on the integer coefficients in such a transformation.";

DoBarnes2::usage = \
"DoBarnes2[int_MBint,bound_:1] applies the second Barnes lemma to the given \
MB integral.  It first looks for a linear transformation of the integration \
variables which will make such an application possible. The optional argument \
specifies a bound on the integer coefficients in such a transformation.";

ExpandInt::usage = \
"ExpandInt[int_MBint] expands the integrand, and then replaces the integral \
of a sum by a list of MB integrals.";

SetVerbosity::usage = \
"SetVerbosity[n_Integer] sets the reporting level for Barnes routines. \
Levels run from 0 to 3, and routines report more information at higher levels.";

MBDimension;
SummarizeDimensions;
MergeAll;
Process;

(* Reveal other routines by special request... the list should be a list
   of strings *)
ToExpression /@ Global`ExposeBarnesRoutines;

(* Barnes1; Barnes2; conflict with MB's... *)

Begin["`Private`"];

MBint = MB`MBint;
MBmerge = MB`MBmerge;
MBcontinue = MB`MBcontinue;
MBresidue = MB`MBresidue;

verbosity = 0;
(* 0: silence; 1: minimal tracking information; 2..4: more information;
   5: debugging *)
SetVerbosity[v_Integer] := (verbosity = v);

blip := If [verbosity >= 1,WriteString[$Output,"."]];

Warning[args__] := 
  If [verbosity >= 1,WriteString[$Output,args,"\n"]];

Error[args__] := 
  If [verbosity >= 0,WriteString[$Output,args,"\n"]];

(* Return a list of all Gammas and PolyGammas appearing in numerators in
   "expr", that is those that might give rise to poles *)
NumeratorGammas[expr_List] := Union[Flatten[NumeratorGammas /@ expr]];
NumeratorGammas[expr_Plus] := 
  Union[Flatten[NumeratorGammas /@ (List @@ expr)]];
NumeratorGammas[expr_] := NumeratorGammas[Expand[expr]] /; expr =!= Expand[expr];
NumeratorGammas[expr_] := 
  Select[Variables[Numerator[expr]],MemberQ[{Gamma,PolyGamma},Head[#]]&];

FindPoles[expr_,var_,lower_,upper_,contour_] :=
  (* Finds potential poles in "expr" for var between "lower" and "upper"
      assuming only sources are Gamma or PolyGamma functions. "Contour" fixes
      the other variables *)
  Module[{study,count,fixrest,final,n,possible,constraints},
    study = expr /. (fixrest=Select[contour,#[[1]] =!= var&]);
    objects = NumeratorGammas[expr];
    objects = Last[#]& /@ objects;
    (* We need to find all possible nonpositive integer values for these
       objects with var in the specified range. "n" denotes a nonnegative
       integer.   All objects are linear in all variables.  
       FindInstance doesn't seem to be able to handle this if we use 
       Element[#,Integers] so
       we replace that with Sin[Pi #] == 0.  We increase the number of
       instances until we're sure we've found them all.  Once we have
       found the poles, we need the solutions in terms of the other variables
       and an integer offset, so we translate back 
    8/9/07: need to find fractional values too! Just take sign of D[#,var];
        >>> this doesn't yet fix things <<< *)
    possible = Select[objects,!FreeQ[#,var]&];
    possible = (Flatten[Solve[#==0,var]][[1,2]]- Sign[D[#,var]] n)& /@ possible;
    constraints = ((# /. fixrest) >= lower && (# /. fixrest) <= upper && 
                Sin[n Pi]==0 && n >= 0)& /@ possible;
    instances = {};  previousInstances = Null;  count = 5;
    While[instances != previousInstances || previousInstances == Null,
       previousInstances = instances;
       instances = FindInstance[#,n,Integers,count]& /@ constraints;
       final = MapThread[Outer[ReplaceAll,{#1},#2]&,{possible,instances},1];
       count *= 2];
    {var,#}& /@ Union[Flatten[final]]
    ];
   
ShiftContours[integral_MBint,targetContour0_List] :=
   (* Returns a list of integrals whose sum equals the original integral,
      where the original integral has its contours shifted according to
      the arguments.  The first integral is the shifted one (whose contours
      are then a linear approximation to an optimal one.)  The additional 
      integrals are residue terms in one of the variables.  
      1/31/08: Sort both contours to prevent improper mismatches arising
               from ordering of variables alone *)
  Module[{integrand=integral[[1]],sourceContour=Sort[integral[[2,2]]],vars,
          source,target,sign,perturb,perturbedInt,
          targetContour=Sort[targetContour0],
          condition=integral[[2,1]]},
    vars = #[[1]]& /@ sourceContour;
    If [(#[[1]]& /@ targetContour) =!= vars,
       Error["Variable mismatch! ",vars," vs ",(#[[1]]& /@ targetContour)];
       Return[{integral}]];
    added={};
    (* 8/2/07 If some variables appear with an integer factor other than
              +/- 1 inside Gamma functions, this may give rise to contributions
              with factors of 1/n in front of other Mellin variables,
              because they will appear that way in the residues.  We
              try to minimize (often eliminate) these problems by tackling
              these variables last. *)
    last = Select[vars,AppearWithNonUnityFactorQ[#,integrand]&];
    If [Length[last] > 0,
        If [verbosity >= 2,WriteString[$Output,"(Dangerous vars: ",last,")"]];
        sourceContour = Join[Select[sourceContour,!MemberQ[last,#[[1]]]&],
                             Select[sourceContour,MemberQ[last,#[[1]]]&]];
        targetContour = Join[Select[targetContour,!MemberQ[last,#[[1]]]&],
                             Select[targetContour,MemberQ[last,#[[1]]]&]];
        vars = #[[1]]& /@ sourceContour];
    (**)
    currentContour = sourceContour;
    Do[(* Do we cross poles going from the source to the destination contour? *)
       source = sourceContour[[j,2]];  target = targetContour[[j,2]];
       poles = 
          FindPoles[integrand,vars[[j]],Min[source,target],
                    Max[source,target],currentContour];
       If [Head[vars[[j]]] =!= Symbol, Throw["Not valid variable!"]];
       sign = If [source < target,-1,1];
       If [verbosity >= 4,
          WriteString[$Output,"var: ",vars[[j]],"; poles: ",poles]];
       (* 8/10/07: Switch to MBresidue to avoid bugs in Residue;
                   e.g. in Math 5.2 it can't seem to evaluate
                     Residue[PolyGamma[1,2 z3+z6],{z3,-1/2-z6/2}] (fixed
                     in Math 6.0 but we can't always use it because of
                     other bugs)
        *)
       addedInt = sign (Plus @@ ((blip; MBresidue[integrand,#])& /@ poles));
       (* It can happen that individual poles are singular though
          the expression as a whole is finite on the contour base;
          if that happens, perturb the contour slightly, and check that
          no new poles are crossed *)
       If [BadQ[addedInt /. currentContour],
           If [BadQ[MLimit[addedInt,currentContour]],
              Warning["Warning: added integral singular on contour!"];
              Return[{integral}]];
           (* spurious singularity: perturb *)
           perturb = Array[sourceContour[[#,1]] -> 
                                sourceContour[[#,2]]+1/Prime[100+#]&,
                              Length[sourceContour]];
           If [Length[perturbedInt=ShiftContours[integral,perturb]] > 1,
               Warning["Poles found in perturbation!"];
               Return[{integral}]];
           If [verbosity >= 3,
               WriteString[$Output,"Perturbing and re-shifting\n"]];
           Return[ShiftContours[perturbedInt[[1]],targetContour]];
           ];
       If [verbosity >= 3,WriteString[$Output,"\n"]];
       currentContour = Join[targetContour[[Range[1,j]]],
                           sourceContour[[Range[j+1,Length[sourceContour]]]]];
       If [addedInt == 0,Continue[]];
       added = Join[added,{MBint[addedInt,{condition,
                     Join[targetContour[[Range[1,j-1]]],
                        sourceContour[[Range[j+1,Length[sourceContour]]]]]}]}];
       ,{j,1,Length[vars]}];
    Join[{MBint[integrand,{condition,targetContour}]},added]
    ];

BadQ[v_] := MemberQ[{ComplexInfinity,Indeterminate,Infinity,-Infinity},v];

NaivelyBadIntQ[int_MBint] := BadQ[int[[1]] /. int[[2,2]]];
BadIntQ[int_MBint] := BadQ[MLimit[int[[1]],int[[2,2]]]];

(* Replace variable in contour *)
ReplaceContourVar[contour_,var_,newvar_,
                  rep_ (* Expression in terms of old vars *)] :=
   Module[{pos=Flatten[Position[contour[[All,1]],var]][[1]]},
      Join[contour[[Range[pos-1]]],{newvar -> (rep /. contour)},
           contour[[Range[pos+1,Length[contour]]]]]];
            
(* Replace the expression "rep" (which should be var+x) by "var",
   that is "var" is the new name *)
ReplaceVar[integral_MBint,var_,rep_] :=
  Module[{newvar},
    MBint[integral[[1]] /. Flatten[Solve[newvar == rep,var]],
      {integral[[2,1]],ReplaceContourVar[integral[[2,2]],var,newvar,rep]}] /.
      newvar -> var];

(* Replace "var" by the expression "rep" (which should be var+x), that
   is "var" is the original variable *)
ReplaceVar2[integral_MBint,var_ -> rep_] :=
  Module[{newvar,newrep},
    newrep = newvar /. Flatten[Solve[var == (rep /. var->newvar),newvar]];
    MBint[integral[[1]] /. var -> rep,
      {integral[[2,1]],
       ReplaceContourVar[integral[[2,2]],var,newvar,newrep]}] /.
      newvar -> var];

(* Replace variables using the replacement list "rep",
   and create new contour.  "rep" is assumed to be a non-degenerate
   change of variables *)
ReplaceVar3[integral_MBint,rep_List] :=
  Module[{newcontour},
    newcontour = Equal @@ #& /@ integral[[2,2]];
    newcontour = newcontour /. rep;
    vars = Cases[newcontour,_Symbol,-1];
    newcontour = Flatten[Solve[newcontour,vars]];
    MBint[integral[[1]] /. rep,
      {integral[[2,1]],newcontour}]];

ReplaceAllVars[integral_MBint,reps_List] :=
  Module[{result=integral},
    Scan[(result = ReplaceVar2[result,#])&,reps];  result];

(* 2/6/09: Take care of integrands that simplify just upon expansion! *)
ExpandInt[int_MBint] :=
  MBint[Expand[First[int]],Sequence @@ Rest[int]] /;
     MemberQ[{Integer,Symbol,Times},Head[Expand[First[int]]]];
ExpandInt[int_MBint] := 
  MBint[#,Sequence @@ Rest[int]]& /@ (List @@ Expand[int[[1]]]) /; 
     (* 10/2/06 Need to expand things that start out as sums too! 
        int[[1]] =!= Expand[int[[1]]] && *) Head[Expand[int[[1]]]] === Plus;
ExpandInt[int_MBint] := int;

ExpandArgs[expr_] := expr /. a_^n_ :> a^Expand[n] /. {
  Gamma[a_] :> Gamma[Expand[a]],
  PolyGamma[n_, a_] :> PolyGamma[n, Expand[a]]};

MBDimension[int_MBint] := Length[int[[2,2]]];
MellinVars[int_MBint] := First /@ int[[2,2]];
(* Added 7/11/09 *)
AllMellinVars[intlist_List] := Union[MellinVars /@ intlist];


SummarizeDimensions[ints_List] :=
  Module[{dims=(MBDimension /@ ints)},
    If [Length[dims] == 0,Return[{""},Module]];
    ToString[Count[dims,#]]<>" x "<>ToString[#]& /@
               Reverse[Range[(Max @@ dims)+1]-1]
    ];

(* Simplified version of DoAllBarnesIntermixedWithMerging, M.C.;
   retained from v 1.0.0 *)

DoAllBarnes[intlist_List,progressive_:False,bound_:1] :=
  (* "progressive" means apply only to integrals above a limit.  The limit
     starts out as the maximal dimension, and is lowered by one on each
     pass *)
  Module[{result,previous={},limit=1,others},
    If [verbosity >= 1, WriteString[$Output,"[",Length[intlist],"]"]];
    If [verbosity >= 2, WriteString[$Output,"\n"]];
    result = Flatten[ExpandInt /@ intlist];
    If [progressive, limit = Max @@ (MBDimension /@ result)];
    (* Note that SortForMerging does not produce a canonical order... *)
    While[Union[result] =!= Union[previous],
       previous = result;
       If [verbosity >= 1,
           WriteString[$Output,SummarizeDimensions[result],"\n"]];
       (* Barnes2 *)
       If [verbosity >= 2, WriteString[$Output,"Barnes 2\n"]];
       others = Select[result,MBDimension[#] < limit&];
       result = Select[result,MBDimension[#] >= limit&];
       result = Flatten[DoBarnes2 /@ result];
       result = Flatten[ExpandInt /@ result];
       result = Join[result,others];
       result = MBmerge[result];
       If [verbosity >= 1, WriteString[$Output,"[",Length[result],"]"]];
       result = Flatten[ExpandInt /@ result];
       (* Barnes1 *)
       If [verbosity >= 2, WriteString[$Output,"Barnes 1\n"]];
       others = Select[result,MBDimension[#] < limit&];
       result = Select[result,MBDimension[#] >= limit&];
       result = Flatten[DoBarnes1 /@ result];
       result = Flatten[ExpandInt /@ result];
       result = Join[result,others];
       result = MBmerge[result];
       If [verbosity >= 1, WriteString[$Output,"[",Length[result],"]"]];
       result = Flatten[ExpandInt /@ result];
       If [Head[interfile] === String,
         (* interfile should have been defined by our caller... *)
         xresult = result;
         Save[interfile<>".m",limit,xresult];  Clear[xresult]];
       If [limit > 1, limit -= 1]];
    result];

(* Find a linear transformation of the variables that allows 
   the first Barnes lemma to be applied; the integrand must be a
   pure product.  It returns a list {var,replacements} specifying
   the variable to which the 1st Barnes lemma should be applied after
   performing the replacements using ReplaceVar2 (or an empty list if
   no solution is found).  The list of replacements may be empty of course.
   10/3/06: Look for transformation-free solution (i.e. just plain variable)
            preferentially.
 *)
(* 8/19/07: Need to make code work for one-dimensional integrals too; TBD *)
FindBarnesable[int_MBint,bound_:1] :=
  Module[{integrand=int[[1]],vars=#[[1]]& /@ int[[2,2]],
          numer,denom,transform,rep,args,constraint,avars,j,dvars,
          zrep,c,backup={},backupZrep = {},backupVar,allsols,powers,
          dummy1,dummy2},
     (* Avoid errors that would otherwise arise... *)
     If [NumberQ[integrand],Return[{}]];
     If [integrand =!= Expand[integrand] || Head[integrand] =!= Times,
        Warning["FB requires pure-product integrand!"];
        Return[{}]];
     (* The code below won't really work in one-dimensional cases, so
        ignore this *)
     If [Length[vars]<=1,Return[{}]];
     xnumer = numer = Numerator[integrand];
     xdenom = denom = Denominator[integrand];
     xvars = vars;
     denom *= dummy1 * dummy2; (* Make sure it's always a product *)
     (* 9/29/06 Be careful to treat T^(z1-z2) as a single exponent,
                even though one will appear in the numerator, the 
                other in the denominator; we can't use Variables to
                extract this properly *)
     powers = 1;
     (* 1/16/08: check for anything to the power of a Mellin var *)
     If [Head[numer]===Times,
        (* 12/24/07: Incorporate fixes from barnesroutines.m; 
                     don't allow constants^variable...
        powers = Select[numer,Head[#]===Power && 
              (MemberQ[{Symbol,Integer,Real},Head[First[#]]] || 
               MatchQ[First[#],_Symbol[_]])&]*)
        powers =  Select[numer,Head[#]===Power && 
                              Intersection[Variables[#[[2]]],vars] != {}&]
        ];
     If [Head[denom]===Times,
        (*powers /= Select[denom,Head[#]===Power && 
              (MemberQ[{Symbol,Integer,Real},Head[First[#]]] || 
               MatchQ[First[#],_Symbol[_]])&] *)
        powers /=  Select[denom,Head[#]===Power && 
                              Intersection[Variables[#[[2]]],vars] != {}&]];
     denom = denom /. {dummy1->1,dummy2->1};
     xpowers = powers;
     (* The basic approach is to require the variable (after limited
        linear changes) to be present in only four gamma functions,
        only in the numerator, with (++--) coefficients. *)
     (* Need to keep track of multiplicity in numerator *)
     numer = List @@ numer;
     (* Lone powers of PolyGamma[0,x] can be treated if x matches one of
        the Gamma functions; the matching to the Gammas is enforced below  *)
     allowedNumer = Select[numer,MatchQ[#,PolyGamma[0,_]]&];
     numer = numer /. 
             f_[x__]^p_ :> Array[f[x]&,p] /; MemberQ[{Gamma,PolyGamma,ShiftedPolyGamma},f];
     numer = Flatten[numer];
     (* 12/13/07: Allow "ShiftedPolyGamma" which stands for
                  PolyGamma[0] + EulerGamma, too; it is used to clean
                  up appearances of EulerGamma *)
     otherNumer = Select[numer,MemberQ[{PolyGamma,ShiftedPolyGamma},Head[#]]&];
     (* Let var appear in PolyGamma[0,_], so long as the PolyGamma
        appears only in the first power, and in the same way as in one
        of the Gammas; otherwise, it's a forbidden form, which we tack
        on to the "denom" set. *)
     allowedNumer = Select[allowedNumer,MemberQ[numer,Gamma[Last[#]]]&];
     otherNumer = Complement[otherNumer,allowedNumer];
     numer = Select[numer,MemberQ[{Gamma},Head[#]]&];
     denom = Select[Variables[denom],MemberQ[{Gamma,PolyGamma},Head[#]]&];
     (* Extract arguments of these special functions *)
     numer = Last /@ numer;
     denom = Last /@ denom;
     If [Head[powers] === Times,
        powers = Last /@ (List @@ powers)];
     If [Head[powers] === Power,
        powers = {Last[powers]}];
     If [Head[powers] === Integer,
        powers = {}];
     allowedNumer = Last /@ allowedNumer;
     (* If something is both in "allowed" and "other" (e.g. PolyGamma[0,x]
        & PolyGamma[1,x] appear), it's not allowed... *)
     otherNumer = Last /@ otherNumer;
     allowedNumer = Complement[allowedNumer,otherNumer];
     denom = Join[denom,powers];
     denom = Join[denom,otherNumer];
     transform = Array[c,{Length[vars],Length[vars]}];
     (* Diagonal elements 1 *)
     transform = transform /. c[i_,i_]->1;
     rep = Thread[vars->transform.vars];
     args = D[numer /. rep,#]& /@ vars;
     dargs = D[denom /. rep,#]& /@ vars;
     dvars = Variables /@ dargs;
     If [verbosity >= 2,WriteString[$Output,"Looking at "]];
     Do[If [verbosity >= 2,WriteString[$Output,vars[[j]]]];
       (* Look for simplest changes of variables *)
       avars = Variables[args[[j]]];
       constraint = And @@ (-bound <= # <= bound & /@ avars);
       constraint = constraint && (And @@ (# == 0& /@ dargs[[j]]));
       eqns = args[[j]].args[[j]] == 4 \
                   && (Plus @@ args[[j]]) == 0&& constraint;
       sol=Flatten[FindInstance[eqns,Join[avars,dvars[[j]]],Integers]];
       (* Prune down to either modified variables, or target variable *)
       zrep = Select[rep /. sol /. c[__]->0,#[[1]]=!=#[[2]]&];
       If [Length[sol] > 0,
           If [verbosity >= 2, blip;
               WriteString[$Output," ",If [Length[zrep] > 0,InputForm[zrep],
                         "[No change of variable needed]\n"]]];
           Return[{vars[[j]],zrep},Module]];
       If [Length[sol] > 0 && Length[zrep] == 0,
           If [verbosity >= 2,
               WriteString[$Output,". [No change of variable needed]\n"]];
           Return[{vars[[j]],zrep},Module]];
       (* Otherwise file it away *)
       If [Length[sol] > 0 && Length[backup] == 0, 
           backup = sol;  backupZrep = zrep;  backupVar = vars[[j]],
           If [verbosity >= 2, WriteString[$Output,";"]]];
       ,{j,1,Length[vars]}];
     (* No simple solution? Return back-up solution if any *)
     If [Length[backup] > 0,
         If [verbosity >= 2,WriteString[$Output,". ",InputForm[backupZrep],"\n"]];
         Return[{backupVar,backupZrep},Module]];
     If [verbosity >= 2,WriteString[$Output," solution not found\n"]];
     {}
     ];

(* We use weak (>=, <=) inequalities & not just strong (>,<) ones
   in FindBarnesable & FindBarnesable2 (as well as elsewhere); this
   should make FindInstance run much faster for them (according to 
     forums.wolfram.com/mathgroup/archive/2006/Jan/msg00387.html)
*)

SetSystemOptions["InequalitySolvingOptions"->{"BrownProjection"->False}];

FBtimeLimit = 60;
(* 9/25/06: Same thing for second Barnes lemma *)
(* 9/29/06: this routine sometimes seems to hang or at least be very very
            slow in Mathematica 5.0;
            seems to work fine in Mathematica 5.2 *)
(* 6/1/07: For differentiation trick (introduction of parameter & 
           differentiating with respect to it), need to include fixedVars
           (int[[2,1]]) in the list of variables to be replaced by prime
           numbers (and the MBint object has to be updated to include them)
*)
FindBarnesable2[int_MBint,bound_:1] :=
  Module[{integrand=int[[1]],vars=#[[1]]& /@ int[[2,2]],
          primevars=#[[1]]& /@ Flatten[int[[2,{2,1}]]],
          numer,denom,transform,rep,args,constraint,avars,j,dvars,
          zrep,p,c,backup={},backupZrep = {},backupVar,powers,
          dummy1,dummy2},
     (* Avoid errors that would otherwise arise... *)
     If [NumberQ[integrand],Return[{}]];
     (* The code below won't really work in one-dimensional cases, so
        ignore this *)
     If [Length[vars]<=1,Return[{}]];
     If [integrand =!= Expand[integrand] || Head[integrand] =!= Times,
        Warning["FB requires pure-product integrand!"];
        Return[{}]];
     numer = Numerator[integrand];
     denom = Denominator[integrand];
     denom *= dummy1 * dummy2; (* Make sure it's always a product *)
     powers = 1;
     (* 1/16/08: check for anything to the power of a Mellin var *)
     If [Head[numer]===Times,
        powers =  Select[numer,Head[#]===Power && 
                              Intersection[Variables[#[[2]]],vars] != {}&]];
     If [Head[denom]===Times,
        powers /=  Select[denom,Head[#]===Power && 
                              Intersection[Variables[#[[2]]],vars] != {}&]];
     denom = denom /. {dummy1->1,dummy2->1};
     (* The basic approach is to require the variable (after limited
        linear changes) to be present in exactly five numerator gamma 
        functions and one denominator function, with either (+++--;+)
        or (---++;-) coefficients. *)
     (* Need to keep track of multiplicity in numerator *)
     numer = List @@ numer;
     numer = numer /. 
             f_[x__]^p_ :> Array[f[x]&,p] /; MemberQ[{Gamma,PolyGamma,ShiftedPolyGamma},f];
     numer = Flatten[numer];
     otherNumer = Select[numer,MemberQ[{PolyGamma,ShiftedPolyGamma},Head[#]]&];
     numer = Select[numer,MemberQ[{Gamma},Head[#]]&];
     denom = Select[Variables[denom],MemberQ[{Gamma,PolyGamma},Head[#]]&];
     (* Don't allow PolyGammas for the moment *)
     disallow = otherNumer;
     (* Extract arguments of these special functions *)
     numer = Last /@ numer;
     denom = Last /@ denom;
     If [Head[powers] === Times,
        powers = Last /@ (List @@ powers)];
     If [Head[powers] === Power,
        powers = {Last[powers]}];
     If [Head[powers] === Integer,
        powers = {}];
     disallow = Last /@ disallow;
     denom = Join[denom];
     disallow = Join[disallow,powers];
     transform = Array[c,{Length[vars],Length[vars]}];
     (* Diagonal elements 1 *)
     transform = transform /. c[i_,i_]->1;
     rep = Thread[vars->transform.vars];
     args = D[numer /. rep,#]& /@ vars;
     dargs = D[denom /. rep,#]& /@ vars;
     disargs = D[disallow /. rep,#]& /@ vars;
     dvars = Variables /@ dargs;
     If [verbosity >= 2,WriteString[$Output,"Looking at "]];
     Do[If [verbosity >= 2,WriteString[$Output,vars[[j]]]];
       (* Look for simplest changes of variables *)
       avars = Variables[args[[j]]];
       constraint = And @@ (-bound <= # <= bound & /@ avars);
       constraint = constraint && (And @@ (# == 0& /@ disargs[[j]]));
       (* There's an additional constraint for residual == -1:
            one numerator argument has to be one less than the denominator 
            argument (that is we must have 
                  G[a+z] G[b+z] G[c-z] G[2-a-b-c-z] G[e-z]/G[1+e-z])
          to do it in one go we introduce a selector variable p,
                  sum p_i = 1, and 0 <= p_i <= 1,
          and require that (p*coeffs).numer - denom = -1,
          along with the constraint that p.coeffs = 1 or -1 (according
          to the sum of numerator coeffs),
          so that p_i corresponds to a "live" numerator *)
       pvars = Array[p,Length[args[[j]]]];
       pConstraint = And @@ (0 <= # <= 1 & /@ pvars);
       pConstraint = (Plus @@ pvars == 1) && pConstraint;
       (* Residuals should be summed over all terms where the var
          is present after the transformation, with sign independent
          of the sign of the var inside the term -- square the coefficient
          (which ultimately will be +/- 1) to get that *)
       residual = denom.(dargs[[j]]^2) - numer.(args[[j]]^2);
       (* Fix other variables to their contour values to "distinct" values
          to avoid problems with non-constant expressions in FindInstance;
          they must of course cancel if we're to find a solution *)
       residual = residual /. vars[[j]]->0;
       residual = residual /. Array[(primevars[[#]]->1/Prime[100+#])&,Length[primevars]];
       xresidual = Expand[residual];
       (* This picks out only terms which actually have the variable --
          but multiplied by the sign in the denominator = overall sign
          in numerator; take that into account below... *)
       difference = (pvars args[[j]]).numer-denom.dargs[[j]];
       difference = difference /. vars[[j]]->0;
       difference = difference /. 
           Array[(primevars[[#]]->1/Prime[100+#])&,Length[primevars]];
       xdifference = Expand[difference];
       eqns = args[[j]].args[[j]] == 5 \
                   && dargs[[j]].dargs[[j]] == 1 \
                   && ((Plus @@ args[[j]] == 1 && Plus @@ dargs[[j]] == 1) ||
                       (Plus @@ args[[j]] == -1 && Plus @@ dargs[[j]] == -1)) \
                   && (residual == 0 || residual == 1 || residual == 2 
                      || (residual == -1 && difference == -(Plus @@ dargs[[j]])
                           && pvars.args[[j]] == Plus @@ args[[j]]
                           && pConstraint)) \
                   && constraint;
       (* To speed things up, first look for a solution without
          changes of variable; we want such solutions preferentially
          anyway *)
       If [pass == 1,eqns = eqns /. {c[__]->0}];
       (* In higher dimensions, it appears to hang; limit the amount of
          time to stop that... *)
       sol = TimeConstrained[Flatten[FindInstance[eqns,Join[avars,dvars[[j]],pvars],Integers]],FBtimeLimit,{}];
xintegrand = integrand; xj = j; xv = vars;
xsol = sol; xargs = args[[j]]; xdargs = dargs[[j]]; xpvars = pvars;
       If [!FreeQ[sol,FindInstance],Throw["oops FindInstance left!"]];
       (* Prune down either to modified variables, or target variable *)
       zrep = Select[rep /. sol /. c[__]->0,#[[1]]=!=#[[2]]&];
       If [Length[sol] > 0 && Length[zrep] == 0,
           If [verbosity >= 2,
               WriteString[$Output,". [No change of variable needed]\n"]];
           Return[{vars[[j]],zrep},Module]];
       (* With multiple passes, no need to file it away -- just return it *)
       If [Length[sol] > 0 && pass > 1, 
           If [verbosity >= 2,WriteString[$Output,". ",InputForm[zrep],"\n"]];
           Return[{vars[[j]],zrep},Module]];
       If [verbosity >= 2, WriteString[$Output,";"]];
       ,{pass,1,2},{j,1,Length[vars]}];
     (* No simple solution? Return back-up solution if any
        Not needed with multiple passes as above *)
     If [verbosity >= 2, WriteString[$Output," solution not found\n"]];
     {}
     ];

(* Replacements which can increase the chances of applying the Barnes
   lemmas 

   10/14/06: Tightened conditions on powers

   2/8/07: Increase applicability by testing differences rather than
           requiring specific integers
*)
simplifyForBarnes = {
  Gamma[mz_]^p1_. Gamma[1+z_]^p2_./Gamma[1+mz_] :> 
        -Gamma[-z]^(p1-1) Gamma[1+z]^(p2-1) Gamma[z] /; Expand[z+mz]==0,
  Gamma[mz_]^p_. Gamma[1+z_]/Gamma[1+mz_]^2 :>
        -Gamma[-z]^(p-1) Gamma[z]/Gamma[1-z] /; Expand[z+mz]==0,
  Gamma[mz_]^p1_. Gamma[zp1_]^p2_./Gamma[mzm1_] :> 
        -Gamma[1-zp1]^(p1-1) Gamma[1+zp1] Gamma[zp1]^(p2-1) /; 
                    Expand[zp1+mz]==1 && Expand[mz-mzm1]==1,
  (* Added 3/5/07 *)
  Gamma[mza_]^p1_. Gamma[zb_]^p2_./Gamma[zbp1_] :>
        -Gamma[mza-1] Gamma[mza]^(p1-1) Gamma[zb]^(p2-1) /;
                    Expand[mza+zbp1]==2 && Expand[zbp1-zb]==1,
  (* Added 3/6/07 *)
  Gamma[mza_]^p1_. Gamma[zb_]^p2_./Gamma[zbp2_] :>
        Gamma[mza-2] Gamma[mza]^(p1-1) Gamma[zb]^(p2-1) /;
                    Expand[mza+zbp2]==3 && Expand[zbp2-zb]==2,
  Gamma[-1+mz_]^p1_. Gamma[2+z_]^p2_./Gamma[mz_] :> 
        -Gamma[-1-z]^(p1-1) Gamma[2+z]^(p2-1) Gamma[1+z] /; 
             Expand[z+mz]==0 && p1>0 && p2>0,
  Gamma[-1+mz_]^p_. Gamma[2+z_]/Gamma[mz_]^2 :> 
        -Gamma[-1-z]^(p-1) Gamma[1+z]/Gamma[-z] /; Expand[z+mz]==0 && p>0,
  Gamma[-1+mz_]^p_. Gamma[2+z_]/Gamma[1+z_] :> 
        -Gamma[mz] Gamma[-1+mz]^(p-1) /; Expand[z+mz]==0 && p>0,
  (* Added 10/14/06 *)
  (Gamma[-1+mz_] Gamma[mz_] Gamma[2+z_])/Gamma[1+mz_] :> 
        Gamma[-z]*Gamma[z] /; Expand[z+mz]==0,
  (* Be careful if we have both PolyGamma[0,1-z] & PolyGamma[0,1+z];
     that would cause simplifyForBarnes to oscillate back & forth between
     the two equivalent representations *)
  Gamma[mz_] Gamma[1+z_] PolyGamma[0,1+mz_] :> 
        -Gamma[1-z] Gamma[z] PolyGamma[0,1-z] /; 
               Expand[z+mz]==0 && Head[mz] === Times,
  Gamma[mz_] Gamma[1+z_]^p_./Gamma[2+z_] :> 
        -Gamma[-1-z] Gamma[1+z]^(p-1) /; Expand[z+mz]==0,
  Gamma[mz_] Gamma[1+z_]^p_./Gamma[2+z_]^2 :> 
        -Gamma[-1-z] Gamma[1+z]^(p-1)/Gamma[2+z]  /; Expand[z+mz]==0,
  Gamma[-1+mz_] Gamma[1+z_] Gamma[2+z_]/Gamma[mz_] :> 
        -Gamma[1+z]^2 /; Expand[z+mz]==0,
  Gamma[1+mz_] Gamma[mz_] Gamma[z_]/Gamma[1+z_] :> 
        -Gamma[-z]^2 /; Expand[z+mz]==0,
  Gamma[-2+mz_]^p1_. Gamma[3+z_]^p2_./Gamma[-1+mz_] :>
        -Gamma[2+z] Gamma[-2-z]^(p1-1) Gamma[3+z]^(p2-1) /; Expand[z+mz]==0,
  Gamma[1+za_] Gamma[mza_]^p_./Gamma[1+mza_] :> 
     -Gamma[za] Gamma[mza]^(p-1) /; Expand[za+mza]==0,
  Gamma[-1-za_-zb_] Gamma[2+za_+zb_]/Gamma[-za_-zb_] -> -Gamma[1+za+zb],
  Gamma[-za_-zb_] Gamma[1+za_+zb_]^p_./Gamma[2+za_+zb_] ->
               -Gamma[-1-za-zb] Gamma[1+za+zb],
  Gamma[za_-zb_]^2 Gamma[1-za_+zb_]/Gamma[1+za_-zb_] -> 
       -Gamma[za-zb] Gamma[zb-za],
  Gamma[-1-za_-zb_] Gamma[2+za_+zb_] PolyGamma[0,1+za_+zb_] ->
     -Gamma[-za-zb] Gamma[1+za+zb] PolyGamma[0,1+za+zb],
  Gamma[-1-za_-zb_] Gamma[2+za_+zb_] PolyGamma[0,-za_-zb_] ->
     -Gamma[-za-zb] Gamma[1+za+zb] PolyGamma[0,-za-zb]};

  (* The following sometimes blocks Barnes, if a PolyGamma is present...
     and the FreeQ's don't seem to accomplish what they're supposed to,
     so drop it for the moment 
     Should it in any case be done only if -1-z1-z2 < 0? *)
  Gamma[-1-z1_-z2_] Gamma[2+z1_+z2_] rest_?(FreeQ[#,PolyGamma[0,2+z1_+z2_]]&) :> 
     -Gamma[-z1-z2] Gamma[1+z1+z2] rest /; 
       FreeQ[rest,PolyGamma[0,-1-z1-z2]] && FreeQ[rest,PolyGamma[0,2+z1+z2]];

Perturb[integral_MBint] := 
  Module[{perturb,contour=integral[[2,2]]},
     perturb = Array[contour[[#,1]] -> contour[[#,2]]+1/Prime[100+#]&,
                     Length[contour]];
     If [Length[CleanInt[perturbedInt=ShiftContours[integral,perturb]]] > 1,
        Warning["Poles found in perturbation!"];
        Return[integral]];
     perturbedInt[[1]]];

(* Using the Barnes lemma may result in integrals which are naively
   divergent -- separate terms are independently divergent on the 
   contour, but the poles actually cancel between terms.  We assume
   they're not genuinely divergent -- that will anyhow eventually be
   picked up by perturbing code.  To repair this we perturb the 
   contours *)
RepairNaivelyBad[int_MBint] :=
  If [NaivelyBadIntQ[int],
     Warning["Warning: generated naively divergent integral!"];
     If [verbosity >= 5,
        xtarget = int;
        file = ToString[Unique[Global`xtag]];
        WriteString[$Output," [",file,"]"];
        Save[file<>".m",xtarget]];
     If [BadIntQ[int],
         Error["Oops! Generated genuinely divergent integral"];
         Throw[DivergentIntegral]];
     Perturb[int],int];

(* 7/30/07: Need to expand exponents too! *)
(* 11/5/07: Simply try Barnes on one dimensional integrals *)

(* 1/31/08: Former form (2nd term) doesn't seem to always work in 
            denominators *)
expandArgs = 
  {f_[x_]:>f[Expand[x]] /; MemberQ[{Gamma,PolyGamma,Power},f],
   f_[x1___,x2_]:>f[x1,Expand[x2]] /; MemberQ[{Gamma,PolyGamma,Power},f]};

DoBarnes1[int_MBint,bound_:1] :=
  Module[{sol,result,anySol = False},
   result = RepairNaivelyBad /@ (
   (sol = FindBarnesable[# //. simplifyForBarnes,bound];
   If [Length[sol]>0, anySol = True;
       If [verbosity >= 1, WriteString[$Output,"Doing ",sol[[1]]]];
           currentTarget = #;
          Barnes1[ReplaceAllVars[# //. simplifyForBarnes,sol[[2]]] //. 
              expandArgs,
                            sol[[1]]],
       If [MBDimension[#]==1,Barnes1[#,First[MellinVars[#]]],#]]
   )& /@ Flatten[{ExpandInt[int]}]);
   result = ExpandArgs[result];
(*
   If [!FreeQ[result,Gamma[_/2]],Throw["Half-int 1 G"]];
   If [!FreeQ[result,_?ZVarQ/2],Throw["Half-int 1"]];
*)
   If [verbosity >= 1 && MBDimension[int] == 1,
      If [Union[MBDimension /@ result] =!= {1},
          WriteString[$Output,"; ",{MBDimension[int]} -> (MBDimension /@ result),"\n"];,
          WriteString[$Output,"; failed\n"]]];
   If [anySol,
      If [verbosity >= 1,
         WriteString[$Output,"; ",{MBDimension[int]} -> (MBDimension /@ result)],"\n"];
      If [{MBDimension[int]} == (MBDimension /@ result),
          Warning["missed?"]]];
   CheckRes /@ result;
   result];

(* 11/5/07: Simply try Barnes on one dimensional integrals *)
DoBarnes2[int_MBint,bound_:1] :=
  Module[{sol,result,anySol = False,bad},
    result = RepairNaivelyBad /@ (
    (sol = FindBarnesable2[# //. simplifyForBarnes,bound];
    If [Length[sol]>0, anySol = True;
       If [verbosity >= 1, WriteString[$Output,"Doing ",sol[[1]]]];
            currentTarget = #;
           Barnes2[ReplaceAllVars[# //. simplifyForBarnes,sol[[2]]] //. 
               expandArgs,
                   sol[[1]]],
        If [MBDimension[#]==1,Barnes2[#,First[MellinVars[#]]],#]]
    )& /@ Flatten[{ExpandInt[int]}]);
    result = ExpandArgs[result];
    If [True,
      bad = Select[result,NaivelyBadIntQ];
      If [Length[bad] > 0,
         If [verbosity >= 1,
            WriteString[$Output,
                        "B2: ",Length[bad]," naively divergent integrals\n"]];
         bad = Select[bad,BadIntQ];
         Error["B2: ",Length[bad]," genuinely divergent integrals"]]];
(*
   If [!FreeQ[result,Gamma[_/2]],Throw["Half-int 2 G"]];
   If [!FreeQ[result,_?ZVarQ/2],Throw["Half-int 2"]];
*)
   If [verbosity >= 1 && MBDimension[int] == 1,
      If [Union[MBDimension /@ result] =!= {1},
          WriteString[$Output,"; ",{MBDimension[int]} -> (MBDimension /@ result),"\n"];,
          WriteString[$Output,"; failed\n"]]];
   If [anySol,
       If [verbosity >= 1,
          WriteString[$Output,
                  "; ",{MBDimension[int]} -> (MBDimension /@ result),"\n"]];
      If [{MBDimension[int]} == (MBDimension /@ result),
           Warning["missed?"]]];
   CheckRes /@ result;
   result];

debugBarnes = False;
verboseBarnes = False;
searchTimeLimit = 60;
recordFailedBarnes = False;
failedBarnes1 = {};
failedBarnes2 = {};

CanonicalGamma[expr_,vars_List] :=
   expr //. {Gamma[x_] :> Gamma[x+1]/x /; (x /. (#->0& /@ vars)) <= 0,
             Gamma[x_] :> Gamma[x-1] (x-1) /; (x /. (#->0& /@ vars)) > 1,
             PolyGamma[j_,x_] :> PolyGamma[j,1+x]-(-1)^j j!/x^(j+1) /; 
                                        (x /. (#->0& /@ vars)) <= 0,
             PolyGamma[j_,x_] :> PolyGamma[j,x-1]+(-1)^j j!/(x-1)^(j+1) /; 
                                        (x /. (#->0& /@ vars)) > 1
              };

(* For use inside integrands, avoid introducing rational factors *)
CanonicalPolyGamma[expr_,vars_List] :=
   expr //. {PolyGamma[j_,x_] :> 
                PolyGamma[j,1+x]-(-1)^j j! (Gamma[x]/Gamma[1+x])^(j+1) /; 
                                        (x /. (#->0& /@ vars)) < 1,
             PolyGamma[j_,x_] :> 
                PolyGamma[j,x-1]+(-1)^j j!(Gamma[x-1]/Gamma[x])^(j+1) /; 
                                        (x /. (#->0& /@ vars)) > 1
              };

Barnes1[MBint[integrand_, {fixedVarRules_List, intVarRules_List}], z_Symbol] := 
Block[{original = MBint[integrand, {fixedVarRules, intVarRules}],
  rules = Flatten[{fixedVarRules, intVarRules}],
  integ = integrand,
  x, pos, a, b, p, neg, c, d, n, xx, xx0, int, fixed, cont, ct, orig,
  patterns, pattern, continuation, continue, shift},

  (* Modified 9/24/06 (DAK) to match forms with PolyGamma[0,ai+z] in them *)
  (* "patterns" is a list of pattern->replacement entries; note that
     the values of "a", "b", "c", "d" are determined below.  *)
  patterns = {
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] ->
      Gamma[a + c]*Gamma[a + d]*Gamma[b + c]*Gamma[b + d]/Gamma[a + b + c + d],
     (* Single PolyGamma with matching argument *)
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] PolyGamma[0,a+z] ->
      Gamma[a + c]*Gamma[a + d]*Gamma[b + c]*Gamma[b + d]*
          (PolyGamma[0,a+c]+PolyGamma[0,a+d]-PolyGamma[0,a+b+c+d])/
              Gamma[a + b + c + d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] PolyGamma[0,b+z] ->
      Gamma[a + c]*Gamma[a + d]*Gamma[b + c]*Gamma[b + d]*
          (PolyGamma[0,b+c]+PolyGamma[0,b+d]-PolyGamma[0,a+b+c+d])/
              Gamma[a + b + c + d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] PolyGamma[0,c-z] ->
      Gamma[a + c]*Gamma[a + d]*Gamma[b + c]*Gamma[b + d]*
          (PolyGamma[0,a+c]+PolyGamma[0,b+c]-PolyGamma[0,a+b+c+d])/
              Gamma[a + b + c + d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] PolyGamma[0,d-z] ->
      Gamma[a + c]*Gamma[a + d]*Gamma[b + c]*Gamma[b + d]*
          (PolyGamma[0,a+d]+PolyGamma[0,b+d]-PolyGamma[0,a+b+c+d])/
              Gamma[a + b + c + d],
     (* Pairs of PolyGammas with matching argument *)
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,a+z] PolyGamma[0,b+z] ->
         Gamma[a + c]*Gamma[b + c]*Gamma[a + d]*Gamma[b + d]*
          (PolyGamma[0, a + c]*PolyGamma[0, b + c] + PolyGamma[0, b + c]*
           PolyGamma[0, a + d] + PolyGamma[0, a + c]*PolyGamma[0, b + d] +
           PolyGamma[0, a + d]*PolyGamma[0, b + d] - PolyGamma[0, a + c]*
           PolyGamma[0, a + b + c + d] - PolyGamma[0, b + c]*
           PolyGamma[0, a + b + c + d] - PolyGamma[0, a + d]*
           PolyGamma[0, a + b + c + d] - PolyGamma[0, b + d]*
           PolyGamma[0, a + b + c + d] + PolyGamma[0, a + b + c + d]^2 -
           PolyGamma[1, a + b + c + d])/Gamma[a + b + c + d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,a+z] PolyGamma[0,c-z] ->
         Gamma[a + c]*Gamma[b + c]*Gamma[a + d]*Gamma[b + d]*
          (PolyGamma[0, a + c]^2 + PolyGamma[0, a + c]*PolyGamma[0, b + c] +
           PolyGamma[0, a + c]*PolyGamma[0, a + d] + PolyGamma[0, b + c]*
           PolyGamma[0, a + d] - 
           2*PolyGamma[0, a + c]*PolyGamma[0, a + b + c + d] -
           PolyGamma[0, b + c]*PolyGamma[0, a + b + c + d] -
           PolyGamma[0, a + d]*PolyGamma[0, a + b + c + d] +
           PolyGamma[0, a + b + c + d]^2 + PolyGamma[1, a + c] -
           PolyGamma[1, a + b + c + d])/Gamma[a + b + c + d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,a+z] PolyGamma[0,d-z] ->
         Gamma[a + c]*Gamma[b + c]*Gamma[a + d]*Gamma[b + d]*
          (PolyGamma[0, a + c]*PolyGamma[0, a + d] + PolyGamma[0, a + d]^2 +
           PolyGamma[0, a + c]*PolyGamma[0, b + d] + PolyGamma[0, a + d]*
           PolyGamma[0, b + d] - 
           PolyGamma[0, a + c]*PolyGamma[0, a + b + c + d] -
           2*PolyGamma[0, a + d]*PolyGamma[0, a + b + c + d] -
           PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d] +
           PolyGamma[0, a + b + c + d]^2 + PolyGamma[1, a + d] -
           PolyGamma[1, a + b + c + d])/Gamma[a + b + c + d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,b+z] PolyGamma[0,c-z] ->
         Gamma[a + c]*Gamma[b + c]*Gamma[a + d]*Gamma[b + d]*
          (PolyGamma[0, a + c]*PolyGamma[0, b + c] + PolyGamma[0, b + c]^2 +
           PolyGamma[0, a + c]*PolyGamma[0, b + d] + PolyGamma[0, b + c]*
           PolyGamma[0, b + d] - 
           PolyGamma[0, a + c]*PolyGamma[0, a + b + c + d] -
           2*PolyGamma[0, b + c]*PolyGamma[0, a + b + c + d] -
           PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d] +
           PolyGamma[0, a + b + c + d]^2 + PolyGamma[1, b + c] -
           PolyGamma[1, a + b + c + d])/Gamma[a + b + c + d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,b+z] PolyGamma[0,d-z] ->
         Gamma[a + c]*Gamma[b + c]*Gamma[a + d]*Gamma[b + d]*
          (PolyGamma[0, b + c]*PolyGamma[0, a + d] + PolyGamma[0, b + c]*
           PolyGamma[0, b + d] + PolyGamma[0, a + d]*PolyGamma[0, b + d] +
           PolyGamma[0, b + d]^2 - 
           PolyGamma[0, b + c]*PolyGamma[0, a + b + c + d] -
           PolyGamma[0, a + d]*PolyGamma[0, a + b + c + d] -
           2*PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d] +
           PolyGamma[0, a + b + c + d]^2 + PolyGamma[1, b + d] -
           PolyGamma[1, a + b + c + d])/Gamma[a + b + c + d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,c-z] PolyGamma[0,d-z] ->
         Gamma[a + c]*Gamma[b + c]*Gamma[a + d]*Gamma[b + d]*
          (PolyGamma[0, a + c]*PolyGamma[0, a + d] + PolyGamma[0, b + c]*
           PolyGamma[0, a + d] + PolyGamma[0, a + c]*PolyGamma[0, b + d] +
           PolyGamma[0, b + c]*PolyGamma[0, b + d] - PolyGamma[0, a + c]*
           PolyGamma[0, a + b + c + d] - PolyGamma[0, b + c]*
           PolyGamma[0, a + b + c + d] - PolyGamma[0, a + d]*
           PolyGamma[0, a + b + c + d] - PolyGamma[0, b + d]*
           PolyGamma[0, a + b + c + d] + PolyGamma[0, a + b + c + d]^2 -
           PolyGamma[1, a + b + c + d])/Gamma[a + b + c + d],
      (* 9/30/06 Triplets of PolyGammas with different arguments *)
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,a+z] PolyGamma[0,b+z] PolyGamma[0,c-z] ->
         (Gamma[a + c]*Gamma[b + c]*Gamma[a + d]*Gamma[b + d]*
           (PolyGamma[0, a + c]^2*PolyGamma[0, b + c] + PolyGamma[0, a + c]*
             PolyGamma[0, b+c]^2+PolyGamma[0, a+c]*PolyGamma[0, b+c]*
             PolyGamma[0, a+d]+PolyGamma[0, b+c]^2*PolyGamma[0, a+d] +
            PolyGamma[0, a+c]^2*PolyGamma[0, b+d]+PolyGamma[0, a+c]*
             PolyGamma[0, b+c]*PolyGamma[0, b+d]+PolyGamma[0, a+c]*
             PolyGamma[0, a+d]*PolyGamma[0, b+d]+PolyGamma[0, b+c]*
             PolyGamma[0, a+d]*PolyGamma[0, b+d] - PolyGamma[0, a+c]^2*
             PolyGamma[0, a+b+c+d] - 3*PolyGamma[0, a+c]*PolyGamma[0, b+c]*
             PolyGamma[0, a+b+c+d] - PolyGamma[0, b+c]^2*
             PolyGamma[0, a+b+c+d] - PolyGamma[0, a+c]*PolyGamma[0, a+d]*
             PolyGamma[0, a+b+c+d] - 2*PolyGamma[0, b+c]*PolyGamma[0, a+d]*
             PolyGamma[0, a+b+c+d] - 2*PolyGamma[0, a+c]*PolyGamma[0, b+d]*
             PolyGamma[0, a+b+c+d] - PolyGamma[0, b+c]*PolyGamma[0, b+d]*
             PolyGamma[0, a+b+c+d] - PolyGamma[0, a+d]*PolyGamma[0, b+d]*
             PolyGamma[0, a+b+c+d]+2*PolyGamma[0, a+c]*
             PolyGamma[0, a+b+c+d]^2+2*PolyGamma[0, b+c]*
             PolyGamma[0, a+b+c+d]^2+PolyGamma[0, a+d]*
             PolyGamma[0, a+b+c+d]^2+PolyGamma[0, b+d]*
             PolyGamma[0, a+b+c+d]^2 - PolyGamma[0, a+b+c+d]^3 +
            PolyGamma[0, b+c]*PolyGamma[1, a+c]+PolyGamma[0, b+d]*
             PolyGamma[1, a+c] - PolyGamma[0, a+b+c+d]*PolyGamma[1, a+c] +
            PolyGamma[0, a+c]*PolyGamma[1, b+c]+PolyGamma[0, a+d]*
             PolyGamma[1, b+c] - PolyGamma[0, a+b+c+d]*PolyGamma[1, b+c] -
            2*PolyGamma[0, a+c]*PolyGamma[1, a+b+c+d] -
            2*PolyGamma[0, b+c]*PolyGamma[1, a+b+c+d] -
            PolyGamma[0, a+d]*PolyGamma[1, a+b+c+d] -
            PolyGamma[0, b+d]*PolyGamma[1, a+b+c+d] +
            3*PolyGamma[0, a+b+c+d]*PolyGamma[1, a+b+c+d] -
            PolyGamma[2, a+b+c+d]))/Gamma[a+b+c+d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,a+z] PolyGamma[0,b+z] PolyGamma[0,d-z] ->
         (Gamma[a+c]*Gamma[b+c]*Gamma[a+d]*Gamma[b+d]*
           (PolyGamma[0, a+c]*PolyGamma[0, b+c]*PolyGamma[0, a+d] +
            PolyGamma[0, b+c]*PolyGamma[0, a+d]^2+PolyGamma[0, a+c]*
             PolyGamma[0, b+c]*PolyGamma[0, b+d]+PolyGamma[0, a+c]*
             PolyGamma[0, a+d]*PolyGamma[0, b+d]+PolyGamma[0, b+c]*
             PolyGamma[0, a+d]*PolyGamma[0, b+d]+PolyGamma[0, a+d]^2*
             PolyGamma[0, b+d]+PolyGamma[0, a+c]*PolyGamma[0, b+d]^2 +
            PolyGamma[0, a+d]*PolyGamma[0, b+d]^2 - PolyGamma[0, a+c]*
             PolyGamma[0, b+c]*PolyGamma[0, a+b+c+d] -
            PolyGamma[0, a+c]*PolyGamma[0, a+d]*PolyGamma[0, a+b+c+d] -
            2*PolyGamma[0, b+c]*PolyGamma[0, a+d]*PolyGamma[0, a+b+c+d] -
            PolyGamma[0, a+d]^2*PolyGamma[0, a+b+c+d] -
            2*PolyGamma[0, a+c]*PolyGamma[0, b+d]*PolyGamma[0, a+b+c+d] -
            PolyGamma[0, b+c]*PolyGamma[0, b+d]*PolyGamma[0, a+b+c+d] -
            3*PolyGamma[0, a+d]*PolyGamma[0, b+d]*PolyGamma[0, a+b+c+d] -
            PolyGamma[0, b+d]^2*PolyGamma[0, a+b+c+d] +
            PolyGamma[0, a+c]*PolyGamma[0, a+b+c+d]^2 +
            PolyGamma[0, b+c]*PolyGamma[0, a+b+c+d]^2 +
            2*PolyGamma[0, a+d]*PolyGamma[0, a+b+c+d]^2 +
            2*PolyGamma[0, b+d]*PolyGamma[0, a+b+c+d]^2 -
            PolyGamma[0, a+b+c+d]^3+PolyGamma[0, b+c]*PolyGamma[1, a+d] +
            PolyGamma[0, b+d]*PolyGamma[1, a+d] - PolyGamma[0, a+b+c+d]*
             PolyGamma[1, a+d]+PolyGamma[0, a+c]*PolyGamma[1, b+d] +
            PolyGamma[0, a+d]*PolyGamma[1, b+d] - PolyGamma[0, a+b+c+d]*
             PolyGamma[1, b+d] - PolyGamma[0, a+c]*PolyGamma[1, a+b+c+d] -
            PolyGamma[0, b+c]*PolyGamma[1, a+b+c+d] -
            2*PolyGamma[0, a+d]*PolyGamma[1, a+b+c+d] -
            2*PolyGamma[0, b+d]*PolyGamma[1, a+b+c+d] +
            3*PolyGamma[0, a+b+c+d]*PolyGamma[1, a+b+c+d] -
            PolyGamma[2, a+b+c+d]))/Gamma[a+b+c+d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,a+z] PolyGamma[0,c-z] PolyGamma[0,d-z] ->
         (Gamma[a+c]*Gamma[b+c]*Gamma[a+d]*Gamma[b+d]*
           (PolyGamma[0, a+c]^2*PolyGamma[0, a+d]+PolyGamma[0, a+c]*
             PolyGamma[0, b+c]*PolyGamma[0, a+d]+PolyGamma[0, a+c]*
             PolyGamma[0, a+d]^2+PolyGamma[0, b+c]*PolyGamma[0, a+d]^2 +
            PolyGamma[0, a+c]^2*PolyGamma[0, b+d]+PolyGamma[0, a+c]*
             PolyGamma[0, b+c]*PolyGamma[0, b+d]+PolyGamma[0, a+c]*
             PolyGamma[0, a+d]*PolyGamma[0, b+d]+PolyGamma[0, b+c]*
             PolyGamma[0, a+d]*PolyGamma[0, b+d] - PolyGamma[0, a+c]^2*
             PolyGamma[0, a+b+c+d] - PolyGamma[0, a+c]*PolyGamma[0, b+c]*
             PolyGamma[0, a+b+c+d] - 3*PolyGamma[0, a+c]*PolyGamma[0, a+d]*
             PolyGamma[0, a+b+c+d] - 2*PolyGamma[0, b+c]*PolyGamma[0, a+d]*
             PolyGamma[0, a+b+c+d] - PolyGamma[0, a+d]^2*
             PolyGamma[0, a+b+c+d] - 2*PolyGamma[0, a+c]*PolyGamma[0, b+d]*
             PolyGamma[0, a+b+c+d] - PolyGamma[0, b+c]*PolyGamma[0, b+d]*
             PolyGamma[0, a+b+c+d] - PolyGamma[0, a+d]*PolyGamma[0, b+d]*
             PolyGamma[0, a+b+c+d]+2*PolyGamma[0, a+c]*
             PolyGamma[0, a+b+c+d]^2+PolyGamma[0, b+c]*
             PolyGamma[0, a+b+c+d]^2+2*PolyGamma[0, a+d]*
             PolyGamma[0, a+b+c+d]^2+PolyGamma[0, b+d]*
             PolyGamma[0, a+b+c+d]^2 - PolyGamma[0, a+b+c+d]^3 +
            PolyGamma[0, a+d]*PolyGamma[1, a+c]+PolyGamma[0, b+d]*
             PolyGamma[1, a+c] - PolyGamma[0, a+b+c+d]*PolyGamma[1, a+c] +
            PolyGamma[0, a+c]*PolyGamma[1, a+d]+PolyGamma[0, b+c]*
             PolyGamma[1, a+d] - PolyGamma[0, a+b+c+d]*PolyGamma[1, a+d] -
            2*PolyGamma[0, a+c]*PolyGamma[1, a+b+c+d] -
            PolyGamma[0, b+c]*PolyGamma[1, a+b+c+d] -
            2*PolyGamma[0, a+d]*PolyGamma[1, a+b+c+d] -
            PolyGamma[0, b+d]*PolyGamma[1, a+b+c+d] +
            3*PolyGamma[0, a+b+c+d]*PolyGamma[1, a+b+c+d] -
            PolyGamma[2, a+b+c+d]))/Gamma[a+b+c+d],
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,b+z] PolyGamma[0,c-z] PolyGamma[0,d-z] ->
         (Gamma[a+c]*Gamma[b+c]*Gamma[a+d]*Gamma[b+d]*
           (PolyGamma[0, a+c]*PolyGamma[0, b+c]*PolyGamma[0, a+d] +
            PolyGamma[0, b+c]^2*PolyGamma[0, a+d]+PolyGamma[0, a+c]*
             PolyGamma[0, b+c]*PolyGamma[0, b+d]+PolyGamma[0, b+c]^2*
             PolyGamma[0, b+d]+PolyGamma[0, a+c]*PolyGamma[0, a+d]*
             PolyGamma[0, b+d]+PolyGamma[0, b+c]*PolyGamma[0, a+d]*
             PolyGamma[0, b+d]+PolyGamma[0, a+c]*PolyGamma[0, b+d]^2 +
            PolyGamma[0, b+c]*PolyGamma[0, b+d]^2 - PolyGamma[0, a+c]*
             PolyGamma[0, b+c]*PolyGamma[0, a+b+c+d] -
            PolyGamma[0, b+c]^2*PolyGamma[0, a+b+c+d] -
            PolyGamma[0, a+c]*PolyGamma[0, a+d]*PolyGamma[0, a+b+c+d] -
            2*PolyGamma[0, b+c]*PolyGamma[0, a+d]*PolyGamma[0, a+b+c+d] -
            2*PolyGamma[0, a+c]*PolyGamma[0, b+d]*PolyGamma[0, a+b+c+d] -
            3*PolyGamma[0, b+c]*PolyGamma[0, b+d]*PolyGamma[0, a+b+c+d] -
            PolyGamma[0, a+d]*PolyGamma[0, b+d]*PolyGamma[0, a+b+c+d] -
            PolyGamma[0, b+d]^2*PolyGamma[0, a+b+c+d] +
            PolyGamma[0, a+c]*PolyGamma[0, a+b+c+d]^2 +
            2*PolyGamma[0, b+c]*PolyGamma[0, a+b+c+d]^2 +
            PolyGamma[0, a+d]*PolyGamma[0, a+b+c+d]^2 +
            2*PolyGamma[0, b+d]*PolyGamma[0, a+b+c+d]^2 -
            PolyGamma[0, a+b+c+d]^3+PolyGamma[0, a+d]*PolyGamma[1, b+c] +
            PolyGamma[0, b+d]*PolyGamma[1, b+c] - PolyGamma[0, a+b+c+d]*
             PolyGamma[1, b+c]+PolyGamma[0, a+c]*PolyGamma[1, b+d] +
            PolyGamma[0, b+c]*PolyGamma[1, b+d] - PolyGamma[0, a+b+c+d]*
             PolyGamma[1, b+d] - PolyGamma[0, a+c]*PolyGamma[1, a+b+c+d] -
            2*PolyGamma[0, b+c]*PolyGamma[1, a+b+c+d] -
            PolyGamma[0, a+d]*PolyGamma[1, a+b+c+d] -
            2*PolyGamma[0, b+d]*PolyGamma[1, a+b+c+d] +
            3*PolyGamma[0, a+b+c+d]*PolyGamma[1, a+b+c+d] -
            PolyGamma[2, a+b+c+d]))/Gamma[a+b+c+d],
      (* 9/30/06 Quadruplet of PolyGammas with different arguments *)
     Gamma[a + z]*Gamma[b + z]*Gamma[c - z]*Gamma[d - z] \
        PolyGamma[0,a+z] PolyGamma[0,b+z] PolyGamma[0,c-z] PolyGamma[0,d-z] ->
     (Gamma[a + c]*Gamma[b + c]*Gamma[a + d]*Gamma[b + d]*
      (PolyGamma[0, a + c]^2*PolyGamma[0, b + c]*PolyGamma[0, a + d] + 
       PolyGamma[0, a + c]*PolyGamma[0, b + c]^2*PolyGamma[0, a + d] + 
       PolyGamma[0, a + c]*PolyGamma[0, b + c]*PolyGamma[0, a + d]^2 + 
       PolyGamma[0, b + c]^2*PolyGamma[0, a + d]^2 + PolyGamma[0, a + c]^2*
        PolyGamma[0, b + c]*PolyGamma[0, b + d] + PolyGamma[0, a + c]*
        PolyGamma[0, b + c]^2*PolyGamma[0, b + d] + PolyGamma[0, a + c]^2*
        PolyGamma[0, a + d]*PolyGamma[0, b + d] + 2*PolyGamma[0, a + c]*
        PolyGamma[0, b + c]*PolyGamma[0, a + d]*PolyGamma[0, b + d] + 
       PolyGamma[0, b + c]^2*PolyGamma[0, a + d]*PolyGamma[0, b + d] + 
       PolyGamma[0, a + c]*PolyGamma[0, a + d]^2*PolyGamma[0, b + d] + 
       PolyGamma[0, b + c]*PolyGamma[0, a + d]^2*PolyGamma[0, b + d] + 
       PolyGamma[0, a + c]^2*PolyGamma[0, b + d]^2 + PolyGamma[0, a + c]*
        PolyGamma[0, b + c]*PolyGamma[0, b + d]^2 + PolyGamma[0, a + c]*
        PolyGamma[0, a + d]*PolyGamma[0, b + d]^2 + PolyGamma[0, b + c]*
        PolyGamma[0, a + d]*PolyGamma[0, b + d]^2 - PolyGamma[0, a + c]^2*
        PolyGamma[0, b + c]*PolyGamma[0, a + b + c + d] - 
       PolyGamma[0, a + c]*PolyGamma[0, b + c]^2*PolyGamma[0, 
         a + b + c + d] - PolyGamma[0, a + c]^2*PolyGamma[0, a + d]*
        PolyGamma[0, a + b + c + d] - 4*PolyGamma[0, a + c]*
        PolyGamma[0, b + c]*PolyGamma[0, a + d]*PolyGamma[0, a + b + c + d] - 
       2*PolyGamma[0, b + c]^2*PolyGamma[0, a + d]*PolyGamma[0, 
         a + b + c + d] - PolyGamma[0, a + c]*PolyGamma[0, a + d]^2*
        PolyGamma[0, a + b + c + d] - 2*PolyGamma[0, b + c]*
        PolyGamma[0, a + d]^2*PolyGamma[0, a + b + c + d] - 
       2*PolyGamma[0, a + c]^2*PolyGamma[0, b + d]*PolyGamma[0, 
         a + b + c + d] - 4*PolyGamma[0, a + c]*PolyGamma[0, b + c]*
        PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d] - 
       PolyGamma[0, b + c]^2*PolyGamma[0, b + d]*PolyGamma[0, 
         a + b + c + d] - 4*PolyGamma[0, a + c]*PolyGamma[0, a + d]*
        PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d] - 
       4*PolyGamma[0, b + c]*PolyGamma[0, a + d]*PolyGamma[0, b + d]*
        PolyGamma[0, a + b + c + d] - PolyGamma[0, a + d]^2*
        PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d] - 
       2*PolyGamma[0, a + c]*PolyGamma[0, b + d]^2*PolyGamma[0, 
         a + b + c + d] - PolyGamma[0, b + c]*PolyGamma[0, b + d]^2*
        PolyGamma[0, a + b + c + d] - PolyGamma[0, a + d]*
        PolyGamma[0, b + d]^2*PolyGamma[0, a + b + c + d] + 
       PolyGamma[0, a + c]^2*PolyGamma[0, a + b + c + d]^2 + 
       3*PolyGamma[0, a + c]*PolyGamma[0, b + c]*PolyGamma[0, a + b + c + d]^
         2 + PolyGamma[0, b + c]^2*PolyGamma[0, a + b + c + d]^2 + 
       3*PolyGamma[0, a + c]*PolyGamma[0, a + d]*PolyGamma[0, a + b + c + d]^
         2 + 4*PolyGamma[0, b + c]*PolyGamma[0, a + d]*
        PolyGamma[0, a + b + c + d]^2 + PolyGamma[0, a + d]^2*
        PolyGamma[0, a + b + c + d]^2 + 4*PolyGamma[0, a + c]*
        PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d]^2 + 
       3*PolyGamma[0, b + c]*PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d]^
         2 + 3*PolyGamma[0, a + d]*PolyGamma[0, b + d]*
        PolyGamma[0, a + b + c + d]^2 + PolyGamma[0, b + d]^2*
        PolyGamma[0, a + b + c + d]^2 - 2*PolyGamma[0, a + c]*
        PolyGamma[0, a + b + c + d]^3 - 2*PolyGamma[0, b + c]*
        PolyGamma[0, a + b + c + d]^3 - 2*PolyGamma[0, a + d]*
        PolyGamma[0, a + b + c + d]^3 - 2*PolyGamma[0, b + d]*
        PolyGamma[0, a + b + c + d]^3 + PolyGamma[0, a + b + c + d]^4 + 
       PolyGamma[0, b + c]*PolyGamma[0, a + d]*PolyGamma[1, a + c] + 
       PolyGamma[0, b + c]*PolyGamma[0, b + d]*PolyGamma[1, a + c] + 
       PolyGamma[0, a + d]*PolyGamma[0, b + d]*PolyGamma[1, a + c] + 
       PolyGamma[0, b + d]^2*PolyGamma[1, a + c] - PolyGamma[0, b + c]*
        PolyGamma[0, a + b + c + d]*PolyGamma[1, a + c] - 
       PolyGamma[0, a + d]*PolyGamma[0, a + b + c + d]*PolyGamma[1, a + c] - 
       2*PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d]*
        PolyGamma[1, a + c] + PolyGamma[0, a + b + c + d]^2*
        PolyGamma[1, a + c] + PolyGamma[0, a + c]*PolyGamma[0, a + d]*
        PolyGamma[1, b + c] + PolyGamma[0, a + d]^2*PolyGamma[1, b + c] + 
       PolyGamma[0, a + c]*PolyGamma[0, b + d]*PolyGamma[1, b + c] + 
       PolyGamma[0, a + d]*PolyGamma[0, b + d]*PolyGamma[1, b + c] - 
       PolyGamma[0, a + c]*PolyGamma[0, a + b + c + d]*PolyGamma[1, b + c] - 
       2*PolyGamma[0, a + d]*PolyGamma[0, a + b + c + d]*
        PolyGamma[1, b + c] - PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d]*
        PolyGamma[1, b + c] + PolyGamma[0, a + b + c + d]^2*
        PolyGamma[1, b + c] + PolyGamma[0, a + c]*PolyGamma[0, b + c]*
        PolyGamma[1, a + d] + PolyGamma[0, b + c]^2*PolyGamma[1, a + d] + 
       PolyGamma[0, a + c]*PolyGamma[0, b + d]*PolyGamma[1, a + d] + 
       PolyGamma[0, b + c]*PolyGamma[0, b + d]*PolyGamma[1, a + d] - 
       PolyGamma[0, a + c]*PolyGamma[0, a + b + c + d]*PolyGamma[1, a + d] - 
       2*PolyGamma[0, b + c]*PolyGamma[0, a + b + c + d]*
        PolyGamma[1, a + d] - PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d]*
        PolyGamma[1, a + d] + PolyGamma[0, a + b + c + d]^2*
        PolyGamma[1, a + d] + PolyGamma[1, b + c]*PolyGamma[1, a + d] + 
       PolyGamma[0, a + c]^2*PolyGamma[1, b + d] + PolyGamma[0, a + c]*
        PolyGamma[0, b + c]*PolyGamma[1, b + d] + PolyGamma[0, a + c]*
        PolyGamma[0, a + d]*PolyGamma[1, b + d] + PolyGamma[0, b + c]*
        PolyGamma[0, a + d]*PolyGamma[1, b + d] - 2*PolyGamma[0, a + c]*
        PolyGamma[0, a + b + c + d]*PolyGamma[1, b + d] - 
       PolyGamma[0, b + c]*PolyGamma[0, a + b + c + d]*PolyGamma[1, b + d] - 
       PolyGamma[0, a + d]*PolyGamma[0, a + b + c + d]*PolyGamma[1, b + d] + 
       PolyGamma[0, a + b + c + d]^2*PolyGamma[1, b + d] + 
       PolyGamma[1, a + c]*PolyGamma[1, b + d] - PolyGamma[0, a + c]^2*
        PolyGamma[1, a + b + c + d] - 3*PolyGamma[0, a + c]*
        PolyGamma[0, b + c]*PolyGamma[1, a + b + c + d] - 
       PolyGamma[0, b + c]^2*PolyGamma[1, a + b + c + d] - 
       3*PolyGamma[0, a + c]*PolyGamma[0, a + d]*PolyGamma[1, 
         a + b + c + d] - 4*PolyGamma[0, b + c]*PolyGamma[0, a + d]*
        PolyGamma[1, a + b + c + d] - PolyGamma[0, a + d]^2*
        PolyGamma[1, a + b + c + d] - 4*PolyGamma[0, a + c]*
        PolyGamma[0, b + d]*PolyGamma[1, a + b + c + d] - 
       3*PolyGamma[0, b + c]*PolyGamma[0, b + d]*PolyGamma[1, 
         a + b + c + d] - 3*PolyGamma[0, a + d]*PolyGamma[0, b + d]*
        PolyGamma[1, a + b + c + d] - PolyGamma[0, b + d]^2*
        PolyGamma[1, a + b + c + d] + 6*PolyGamma[0, a + c]*
        PolyGamma[0, a + b + c + d]*PolyGamma[1, a + b + c + d] + 
       6*PolyGamma[0, b + c]*PolyGamma[0, a + b + c + d]*
        PolyGamma[1, a + b + c + d] + 6*PolyGamma[0, a + d]*
        PolyGamma[0, a + b + c + d]*PolyGamma[1, a + b + c + d] + 
       6*PolyGamma[0, b + d]*PolyGamma[0, a + b + c + d]*
        PolyGamma[1, a + b + c + d] - 6*PolyGamma[0, a + b + c + d]^2*
        PolyGamma[1, a + b + c + d] - PolyGamma[1, a + c]*
        PolyGamma[1, a + b + c + d] - PolyGamma[1, b + c]*
        PolyGamma[1, a + b + c + d] - PolyGamma[1, a + d]*
        PolyGamma[1, a + b + c + d] - PolyGamma[1, b + d]*
        PolyGamma[1, a + b + c + d] + 3*PolyGamma[1, a + b + c + d]^2 - 
       2*PolyGamma[0, a + c]*PolyGamma[2, a + b + c + d] - 
       2*PolyGamma[0, b + c]*PolyGamma[2, a + b + c + d] - 
       2*PolyGamma[0, a + d]*PolyGamma[2, a + b + c + d] - 
       2*PolyGamma[0, b + d]*PolyGamma[2, a + b + c + d] + 
       4*PolyGamma[0, a + b + c + d]*PolyGamma[2, a + b + c + d] - 
       PolyGamma[3, a + b + c + d]))/Gamma[a + b + c + d]};

  (* Include "xx" to be ready for shifting parameters *)
  shift = {a->a+xx,b->b+xx,c->c+xx,d->d+xx};
  patterns = #[[1]]->(#[[2]] /. shift)& /@ patterns;
  (* For the analytic continuation *)
  continuations = #[[1]]->(#[[1]] /. shift)& /@ patterns;

  integ = integ /. f_[x_] :> f[Expand[x]] /; MemberQ[{Gamma,PolyGamma},f];
  pos = Cases[{Numerator[integrand]},
    Gamma[x_] :> x /; Coefficient[x, z] == +1, -1] /. z -> 0;
  If[Length[pos] == 1, pos = {First[pos], First[pos]}];
  If[Length[pos] != 2, Return[original]];
  a = First[pos];
  b = Last[pos];

  neg = Cases[{Numerator[integrand]},
    Gamma[x_] :> x /; Coefficient[x, z] == -1, -1] /. z -> 0;
  If[Length[neg] == 1, neg = {First[neg], First[neg]}];
  If[Length[neg] != 2, Return[original]];
  c = First[neg];
  d = Last[neg];

  If [debugBarnes,
      Global`xparms = {a,b,c,d};
      Global`xpatterns = patterns];

  patterns = patterns /. 
                f_[x_] :> f[Expand[x]] /; MemberQ[{Gamma,PolyGamma},f];
  (* Does any pattern match all appearances of "z"? *)
  pattern = Scan[If [!MemberQ[integ /. #,z,-1],Return[#]]&,
                 patterns];
  If [verbosity >= 4,WriteString[$Output,pattern,"\n"]];

  (* Nope... just return original expression *)
  If [pattern === Null,
     If [recordFailedBarnes,failedBarnes1 = Join[failedBarnes1,{original}]];
     Return[original]];

  (* Determine minimum xx value which will make all Gamma arguments positive,
     hence the integral well-defined on the given contour with properly
     separated poles *)
  p = -Min[pos /. rules];
  n = +Min[neg /. rules];
  xx0 = Max[{p - z, z - n} /. rules];

  (* No poles crossed going to xx = 0: *)
  If[xx0 < 0,
    Return[DeleteCases[original /. (pattern /. xx->0),
      z -> _, -1]]];

  (* Otherwise, we Need to shift "a", etc; take matching continuation 
     to our resolution *)
  continue = continuations[[Flatten[Position[patterns,pattern]]]];
  int = integ /. continue;

  If [debugBarnes, Global`xcontinue = continue];

  fixed = DeleteCases[Join[fixedVarRules, intVarRules, {xx -> xx0 + 10^-10}],
    z -> _, -1];

  If [debugBarnes, Global`xint0 = int];
  cont = MBmerge[MBcontinue[int, xx -> 0, {fixed, {z -> (z /. intVarRules)}},
    Verbose -> False]];

  ct = -cont[[1,1]];
  orig = integ /. pattern;

  If [!FreeQ[orig,z] || !FreeQ[ct,z],
     WriteString[$Output,"Barnes1 oops!\n"];Throw["oops!"]];

  (* Cannot handle cases with poles in xx;  for obscure reasons,
     Series may hang on orig+ct (even when it succeeds on each term
     separately); so first do the Series on each term separately; even
     just adding the two series can cause it to hang, so be careful there
     too *)
  (*
  int = Normal[Simplify[Series[Normal[Series[orig,{xx,0,0}]] 
                               + Normal[Series[ct,{xx,0,0}]], {xx, 0, 0}]]];
  *)
  int = (Normal[Series[orig,{xx,0,0}]] + Normal[Series[ct,{xx,0,0}]]);
  If [verbosity >= 4,WriteString[$Output,"Done 1st stage series\n"]];
  (* It can happen that the coefficient of 1/xx is zero but not manifestly
     so, because of different PolyGammas appearing *)
  int = int /. xx^p_. x_ :> xx^p FactorSquareFree[CanonicalGamma[x,
                               Complement[#[[1]]& /@ intVarRules,{z}]]];
  int = Normal[Simplify[Series[int, {xx, 0, 0}]]];

  If [!FreeQ[int,xx],
     If [recordFailedBarnes,failedBarnes1 = Join[failedBarnes1,{original}]];
     Return[original]];

  Return[MBint[int,
    {fixedVarRules, DeleteCases[intVarRules, z -> _, -1]}]]]
 
Barnes2[MBint[integrand_, {fixedVarRules_List, intVarRules_List}], z_Symbol] := 
Block[{original = MBint[integrand, {fixedVarRules, intVarRules}], sign = +1,
  integ = integrand, rules = Flatten[{fixedVarRules, intVarRules}], x, i, j,
  tpos, pos = {}, a, b, c, p, tneg, neg = {}, d, e, n, 
  xx, xx0, int, fixed, cont, ct, orig,
  patterns, pattern, continuations, continue, patterns2, continuations2,
  shift, shift2, constraint, cvars, fixCoeff, result},

  (* Modified 9/25/06 (DAK) to match forms with f=a+b+c+d+e+small int *)
  (* "patterns" is a list of pattern->replacement entries; note that
     the values of "a", "b", "c", "d", "e", "f" are determined
     below. 
   *)
  patterns = {
      Gamma[a + z]*Gamma[b + z]*Gamma[c + z]*Gamma[d - z]*Gamma[e - z]/
      Gamma[Expand[a + b + c + d  + e] + z] ->
      Gamma[a + d]*Gamma[b + d]*Gamma[c + d]*
      Gamma[a + e]*Gamma[b + e]*Gamma[c + e]/
      (Gamma[a + b + d + e]*Gamma[a + c + d + e]*Gamma[b + c + d + e]),
      (* From Appendix D of Smirnov's book, or his barnes.m *)
      Gamma[a + z]*Gamma[b + z]*Gamma[c + z]*Gamma[d - z]*Gamma[e - z]/
      Gamma[Expand[a + b + c + d  + e]+1 + z] ->
      (Gamma[b + d]*Gamma[a + e]*
    (-(Gamma[1 + a + d]*Gamma[1 + c + d]*Gamma[-a - c - d - e]*Gamma[b + e]) +
      Gamma[a + d]*Gamma[c + d]*Gamma[1 - a - c - d - e]*Gamma[1 + b + e])*
      Gamma[c + e])/(Gamma[1 - a - c - d - e]*Gamma[1 + a + b + d + e]*
       Gamma[a + c + d + e]*Gamma[1 + b + c + d + e]),
      (* From Appendix D of Smirnov's book, or his barnes.m *)
      Gamma[a + z]*Gamma[b + z]*Gamma[c + z]*Gamma[d - z]*Gamma[e - z]/
      Gamma[Expand[a + b + c + d  + e]+2 + z] ->
         (Gamma[b + d]*Gamma[a + e]*(Gamma[2 + a + d]*Gamma[2 + c + d]*
         Gamma[-1 - a - c - d - e]*Gamma[b + e] - 2*Gamma[1 + a + d]*
         Gamma[1 + c + d]*Gamma[-a - c - d - e]*Gamma[1 + b + e] +
       Gamma[a + d]*Gamma[c + d]*Gamma[1 - a - c - d - e]*Gamma[2 + b + e])*
      Gamma[c + e])/(Gamma[1 - a - c - d - e]*Gamma[2 + a + b + d + e]*
       Gamma[a + c + d + e]*Gamma[2 + b + c + d + e])};
  patterns2 = {
      (* From Smirnov's Mel51ozIR, residual = -1, modified to make a<->b
         symmetry manifest *)
      Gamma[a+z] Gamma[b+z] Gamma[c+z] Gamma[Expand[2-a-b-e]-z] Gamma[e-z]/
             Gamma[1+c+z] -> 
       -Gamma[1 - a - e]*Gamma[1 - b - e]*Gamma[a + e]*Gamma[b + e] *
        (1-Gamma[2-a-b-e + c]*Gamma[e + c]/(Gamma[1-a + c]*Gamma[1-b + c])),
      (* Similar with b<->c *)
      Gamma[a+z] Gamma[c+z] Gamma[b+z] Gamma[Expand[2-a-c-e]-z] Gamma[e-z]/
             Gamma[1+b+z] -> 
       -Gamma[1 - a - e]*Gamma[1 - c - e]*Gamma[a + e]*Gamma[c + e] *
        (1-Gamma[2-a-c-e + b]*Gamma[e + b]/(Gamma[1-a + b]*Gamma[1-c + b])),
       (* And a<->c *)
      Gamma[c+z] Gamma[b+z] Gamma[a+z] Gamma[Expand[2-c-b-e]-z] Gamma[e-z]/
             Gamma[1+a+z] -> 
       -Gamma[1 - b - e]*Gamma[1 - c - e]*Gamma[b + e]*Gamma[c + e] *
        (1-Gamma[2-b-c-e+a]*Gamma[e+a]/(Gamma[1-b+a]*Gamma[1-c+a]))
       };

  (* Include "xx" to be ready for shifting parameters *)
  shift = {a->a+xx,b->b+xx,c->c+xx,d->d+xx,e->e+xx};
  patterns = #[[1]]->(#[[2]] /. shift)& /@ patterns;
  (* For the analytic continuation *)
  continuations = #[[1]]->(#[[1]] /. shift)& /@ patterns;

  (* In patterns2, we need different analytic continuations, because the
     Gamma functions involve e-c as well as a+c etc; we leave the
     coefficients open in order to maximize the chance of finding
     a region in which we can define the integral... *)
  shift2 = {a->a+ca xx,b->b+cb xx,d->d-(ca+cb-ce) xx,c->c+cc xx,e->e-ce xx};
  patterns2 = #[[1]]->(#[[2]] /. shift2)& /@ patterns2;
  continuations2 = #[[1]]->(#[[1]] /. shift2)& /@ patterns2;

  patterns = Join[patterns,patterns2];
  continuations = Join[continuations,continuations2];

  integ = integ /. f_[x_] :> f[Expand[x]] /; MemberQ[{Gamma,PolyGamma},f];
  If[MemberQ[{Denominator[integrand]}, Gamma[x_.-z], -1],
    sign = -1;
    integ = integ /. z -> -z;
    rules = rules /. (z -> x_) -> (z -> -x)];

  tpos = Cases[{Numerator[integ]},
    Gamma[x_] :> x /; Coefficient[x, z] == +1, -1] /. z -> 0;

  Do[
    Do[AppendTo[pos, tpos[[i]]],
    {j, Exponent[integ, Gamma[tpos[[i]] + z]]}],
  {i, Length[tpos]}];

  If[Length[pos] != 3, Return[original]]; 

  a = pos[[1]];
  b = pos[[2]];
  c = pos[[3]];

  tneg = Cases[{Numerator[integ]},
    Gamma[x_] :> x /; Coefficient[x, z] == -1, -1] /. z -> 0;

  Do[
    Do[AppendTo[neg, tneg[[i]]],
    {j, Exponent[integ, Gamma[tneg[[i]] - z]]}],
  {i, Length[tneg]}];

  If[Length[neg] != 2, Return[original]]; 

  d = neg[[1]];
  e = neg[[2]];

  patterns = patterns /. 
                f_[x_] :> f[Expand[x]] /; MemberQ[{Gamma,PolyGamma},f];
  patterns2 = patterns2 /. 
                f_[x_] :> f[Expand[x]] /; MemberQ[{Gamma,PolyGamma},f];

  If [debugBarnes,
     Global`xparms = {a,b,c,d,e};
     Global`xpatterns = patterns];

  (* Does any pattern match all appearances of "z"? *)
  pattern = Scan[If [!MemberQ[integ /. #,z,-1],Return[#]]&,
                 patterns];

  extraCare = MemberQ[patterns2,pattern];
  If [debugBarnes,Global`xpattern = pattern];
  If [verbosity >= 4,
      WriteString[$Output,
         "Picked pattern ",Flatten[Position[patterns,pattern]][[1]],
            " of ",Length[patterns],"\n"]];

  (* Nope... just return original expression *)
  If [pattern === Null,
     If [recordFailedBarnes,failedBarnes2 = Join[failedBarnes2,{original}]];
     Return[original]];

  (* Find the minimum xx value which makes all Gammas positive. 
     If it's negative, no poles are crossed on our way to xx = 0. *)
  (* The original code assumed the coefficient of xx in all parameters
     was +1:
  p = -Min[pos /. rules];
  n = +Min[neg /. rules];
  xx0 = Max[{p - z, z - n} /. rules];
   
  If[xx0 < 0,
    Return[DeleteCases[original /. z -> sign*z /. (pattern /. xx->0),
      sign*z -> _, -1]]];

    but we need to take a more general approach, because in the last
    set of patterns, the coefficient is different from 1.
   *)
  continue = continuations[[Flatten[Position[patterns,pattern]]]];
  constraint = 
    Select[Variables[Numerator[integ /. continue]],!FreeQ[#,xx]&] /. rules;
  cvars = Union[Cases[constraint,_Symbol,-1]];

  constraint = (And @@ (Last[#]>0 & /@ constraint));
  If [debugBarnes,
      Global`xconstraint = constraint;
      Global`xcvars = cvars];

  (* It's expensive to reduce this in generality.  Does a simple choice
     for ca, cb, cc, ce work? *)
  fixCoeff = {ca->1,cb->1,cc->1,ce->1};
  If[TrueQ[!(reduced = Reduce[Global`con1=constraint /. fixCoeff,xx])],
     (* False for all xx; need to work harder. *)
     (* Can we find a solution with xx->0? *)
     If [constraint /. xx->0,constraint = True,
     (* Otherwise, we hunt... and would like to pick the one with 
        smallest absolute value for xx.  However, this appears to 
        ultimately cause a memory fault [core dump] (!) in Mathematica 5.2 
        when taking residues, if the size of the numerator and denominator 
        in the rational fraction are too large; so try to minimize them 
        instead *)
     (* It's better to use strict rather than weak inequalities... (< vs <=) *)
     bound = And @@ ((# != 0 && -1 < # < 1)& /@ Select[cvars,#=!=xx&]);
     If [verbosity >= 4,WriteString[$Output,"Looking for instance\n"]];
     (* Try to find a lone solution first; it's much faster *)
     fixCoeff = FindInstance[constraint && bound,cvars,Rationals];
     If [fixCoeff != {},
(*Print[InputForm[fixCoeff]];
Print[InputForm[{constraint && bound,cvars}]];*)
     TimeConstrained[
     (* 8/9/07 This seems to be *much* slower in Mathematica 6.0 than in
               5.2, maybe even hanging, leading to other nastinesses *)
     fixCoeff = \
       Sort[Global`list=FindInstance[constraint && bound,cvars,Rationals,10],
            Abs[Denominator[ ca cb cc ce xx /. #1]] < 
                Abs[Denominator[ca cb cc ce xx /. #2]]&],searchTimeLimit,{}]];
     If [verbosity >= 4,
        WriteString[$Output,"Found ",Length[fixCoeff]," instance(s)\n"]];
     If [fixCoeff == {}, (* No possible solution *) constraint = False,
        (* Just fix the parameters ca, cb, cc, ce for now *)
        fixCoeff = DeleteCases[fixCoeff[[1]],xx->_,-1];
        constraint = constraint /. fixCoeff;
        constraint = Reduce[constraint,xx]]],
      (* otherwise, simple choice is OK *) constraint=reduced];
  
  (* If it can't be satisfied, punt *)
  If [TrueQ[!constraint],
     Warning["Warning: no separation of poles possible in Barnes2"];
     If [recordFailedBarnes,failedBarnes2 = Join[failedBarnes2,{original}]];
     Return[original]];

  If [constraint /. xx->0 (* No poles between proper definition & origin *),
    (* We need to be careful, because just substituting xx->0 might
       (very occasionally) lead to an ill-defined result; this seems to
       happen with the last three patterns; so we do a series expansion *)
    result = DeleteCases[original /. z -> sign*z /. pattern,
      sign*z -> _, -1];
    If [extraCare,
      Global`xresult = result = MBint[
           FactorSquareFree[Normal[Series[result[[1]],{xx,0,0}]]],
           result[[2]]],
      result = result /. xx->0];
    Global`xBresult = result;
    If [!FreeQ[result,xx],
       If [recordFailedBarnes,failedBarnes2 = Join[failedBarnes2,{original}]];
       Return[original]];
    Return[result]];

  (* Otherwise, need to shift "a", etc; use matching continuation 
     to our pattern.  Pick the "simplest" xx0 within the range *)
  xx0 = Sort[Flatten[xx /. FindInstance[constraint,cvars,Rationals,20]],
             Abs[Denominator[#1]]<Abs[Denominator[#2]]&][[1]];
  If [verbosity >= 4, WriteString[$Output,"Picked xx0 = ",xx0,"\n"]];
  int = integ /. continue;
  int = int /. fixCoeff;

  fixed = DeleteCases[Join[fixedVarRules, intVarRules, {xx -> xx0 + 10^-10}],
    z -> _, -1];

  (* "Residue" inside MBresidue inside MBcontinue can be a source of
     memory faults in Mathematica 5.2... watch out! *)
  If [debugBarnes,Global`MBarg2 = {fixed, {z -> (sign*z /. intVarRules)}}];
  cont = MBmerge[Global`xcont1=MBcontinue[int, xx -> 0,
    {fixed, {z -> (sign*z /. intVarRules)}}, Verbose -> verbosity >= 4]];

  (* If xx is forced to be negative, away from zero, we can still
     have a situation with no counterterm; then we follow the same
     code as above when the constraint region includes xx = 0, starting
     from the final continued form *)
  If [Length[cont] == 1 (* No poles between proper definition & origin *),
    (* We need to be careful, because just substituting xx->0 might
       (very occasionally) lead to an ill-defined result; this seems to
       happen with the last three patterns; so we do a series expansion *)
    result = DeleteCases[cont[[1]] /. z -> sign*z /. pattern,
      sign*z -> _, -1];
    If [extraCare,
      Global`xresult = result = MBint[
           FactorSquareFree[Normal[Series[result[[1]],{xx,0,0}]]],
           result[[2]]],
      result = result /. xx->0];
    Global`xBresult = result;
    If [!FreeQ[result,xx],
       If [recordFailedBarnes,failedBarnes2 = Join[failedBarnes2,{original}]];
       Return[original]];
    Return[result]];

  ct = -cont[[1,1]];
  orig = integ /. pattern;
  If [extraCare,  (* See earlier discussion *)
     orig = FactorSquareFree /@ Series[orig,{xx,0,0}];
     ];  
  Global`xorig1 = orig;
  Global`xfixCoeff = fixCoeff;
  orig = Normal[orig];
  orig = orig /. fixCoeff;

  If [debugBarnes,
     Global`xinteg = integ;
     Global`xorig = orig;
     Global`xct = ct];

  If [verbosity >= 4,WriteString[$Output,"Obtained counterterm\n"]];
  If [!FreeQ[orig,z] || !FreeQ[ct,z],
     WriteString[$Output,"Barnes2 oops!\n"];  Throw["oops!"]];
  (* Cannot handle cases with poles in xx;  also, for obscure reasons,
     Series may hang on orig+ct (even when it succeeds on each term
     separately; so first do the Series on each term separately...) 
     10/7/06: That isn't always enough, so clean up in between... *)
  int = (Normal[Series[orig,{xx,0,0}]] + Normal[Series[ct,{xx,0,0}]]);
  Global`xint0 = int;
  If [verbosity >= 4,WriteString[$Output,"Done 1st stage series\n"]];
  (* It can happen that the coefficient of 1/xx is zero but not manifestly
     so, because of different PolyGammas appearing *)
  int = int /. xx^p_. x_ :> xx^p FactorSquareFree[CanonicalGamma[x,
                               Complement[#[[1]]& /@ intVarRules,{z}]]];
  int = Normal[Simplify[Series[int, {xx, 0, 0}]]];

  Global`xint = int;
(*Print[xint=Normal[Series[int,{xx,0,-1}]]];*)
  If [!FreeQ[int,xx],
     If [recordFailedBarnes,failedBarnes2 = Join[failedBarnes2,{original}]];
     Return[original]];

  Return[MBint[int,
    {fixedVarRules, DeleteCases[intVarRules, z -> _, -1]}]]]
 
enableAdditionalBarnes = \
    {Gamma[1+za_+zb_]/Gamma[za_+zb_] Gamma[1+za_]^p_. Gamma[-1+zb_] ->
         Gamma[1+za]^(p-1) (Gamma[2+za] Gamma[-1+zb]+Gamma[1+za] Gamma[zb]),
     Gamma[1+za_+zb_]/(Gamma[1-za_] Gamma[1-zb_]) :>
         -Gamma[za+zb](Gamma[1-za]/Gamma[-za]+Gamma[1-zb]/Gamma[-zb])/
                       (Gamma[1-za] Gamma[1-zb]),
     Gamma[mza_]^p_. Gamma[-1+mzb_] Gamma[2+za_+zb_]/
               (Gamma[1+mza_] Gamma[mzb_]) :>
         -Gamma[-za]^(p-1) Gamma[1+za+zb]*
                (Gamma[-za]/Gamma[1-za]+Gamma[-1-zb]/Gamma[-zb]) /;
              Expand[za+mza] == 0 && Expand[zb+mzb] == 0,
  (* Added 10/14/06, should perhaps be in simplifyForBarnes but that isn't
     allowed to produce multiple terms *)
  Gamma[z_]^p1_. Gamma[2+z_]^p2_. Gamma[1+z_]^p3_ :> 
        Gamma[z]^(p1-1) Gamma[2+z]^(p2-1) Gamma[1+z]^(p3+1) *
            (Gamma[z] + Gamma[1+z]) /; p1>0 && p2>0 && p3<0,
  Gamma[mz_]^p1_. Gamma[2+z_]^p2_. Gamma[1+z_]^p3_ :> 
        Gamma[-z]^(p1-1) Gamma[2+z]^(p2-1) Gamma[1+z]^(p3+1) *
           (Gamma[-z] - Gamma[1-z]) /; p1>0 && p2>0 && p3<0 && Expand[mz+z]==0,
  (* Expressions like Gamma[a+z] PolyGamma[0,1+a+z]
     should be split up into integrals doable by 1st Barnes
     lemma (Gamma[a+z] PolyGamma[0,a+z]) and those potentially
     doable by the 2nd Barnes lemma.  This should be applied
     only after all Barnes lemmas and merging has been exhausted *) \
    Gamma[a_.+z_]^p_. PolyGamma[0,b_.+z_] :> 
         Gamma[a+z]^p (PolyGamma[0,b+z-1] + Gamma[b+z-1]/Gamma[b+z]) /;
       IntegerQ[Expand[b-a]] && Expand[b-a] >= 1,
    (* 12/03/07 Add similar separations for powers of PolyGamma[0,],
       and lone powers of PolyGamma[1,] (in preparation for Barnes1 learning
       how to do double derivatives) *)
    Gamma[a_.+z_]^p1_. PolyGamma[0,b_.+z_]^p2_. :> 
         Gamma[a+z]^p1 (PolyGamma[0,b+z-1] + Gamma[b+z-1]/Gamma[b+z])^p2 /;
       IntegerQ[Expand[b-a]] && Expand[b-a] >= 1 && p2 <= p1,
    Gamma[a_.+z_]^p_. PolyGamma[1,b_.+z_] :> 
         Gamma[a+z]^p (PolyGamma[1,b+z-1] - Gamma[b+z-1]^2/Gamma[b+z]^2) /;
       IntegerQ[Expand[b-a]] && Expand[b-a] >= 1,
(*     Gamma[a_.-z_]^p_. PolyGamma[0,b_.-z_] :> 
         Gamma[a-z]^p (PolyGamma[0,b-z-1] + Gamma[b-z-1]/Gamma[b-z]) /;
       Expand[b-a] == 1, *)
     Gamma[a_.+z_]^p_. PolyGamma[0,b_.+z_] :> 
         Gamma[a+z]^p (PolyGamma[0,b+z+1] - Gamma[b+z]/Gamma[b+z+1]) /;
       IntegerQ[Expand[b-a]] && Expand[b-a] <= -1}

(* New (in v 1.1.0) routine Process to do processing... *)
mergeLinearMapping = True;

Options[Process] = {MergeFirst->True,MergeWithLinearMapping->False};

Process[ints_List,level_Integer,options___Rule] :=
  Module[{done={},undone,rest,prior={},limit=5,
          mergeFirst,mergeWithLinearMapping},
    mergeFirst = MergeFirst /. {options} /. Options[Process];
    mergeWithLinearMapping = MergeWithLinearMapping /. {options} /. 
       Options[Process];
    If [verbosity >= 1,WriteString[$Output,"Processing level ",level,"\n"]];
    undone = Select[ints,MBDimension[#] == level&];
    rest = Select[ints,MBDimension[#] != level&];
    undone = Flatten[ExpandInt /@ undone];
    If [mergeFirst,
      undone = MergeAll[undone];
      undone = Flatten[ExpandInt /@ undone];
      If [mergeWithLinearMapping,
         undone = MergeAllWithLinearMapping[undone];
         undone = Flatten[ExpandInt /@ undone]]];
    If [verbosity >= 1,WriteString[$Output,"Barnes 1"]];
    undone = Flatten[(blip; last = #; DoBarnes1[#])& /@ undone];
    done = Join[done,Select[undone,MBDimension[#] < level&]];
    undone = Select[undone,MBDimension[#] == level&];
    count = limit;
    If [verbosity >= 1,WriteString[$Output,"; Barnes 1"]];
    While [count-- > 0,
       undone = undone /. enableAdditionalBarnes;
       undone = Flatten[ExpandInt /@ undone];
       undone = undone /. simplifyForBarnes;
       prior = undone;
       undone = Flatten[(blip; DoBarnes1[#])& /@ undone];
       done = Join[done,Select[undone,MBDimension[#] < level&]];
       undone = Select[undone,MBDimension[#] == level&];
       If [Sort[prior] === Sort[undone],Break[]]];
    count = limit;
    If [verbosity >= 1,WriteString[$Output,"; Barnes 1"]];
    While [count-- > 0,
       prior = undone;
       undone = undone /. simplifyForBarnes;
       prior = undone;
       undone = Flatten[(blip; DoBarnes1[#])& /@ undone];
       done = Join[done,Select[undone,MBDimension[#] < level&]];
       undone = Select[undone,MBDimension[#] == level&];
       If [Sort[prior] === Sort[undone],Break[]]];
    If [verbosity >= 1,WriteString[$Output,"; Interim: ",
                SummarizeDimensions[Join[undone,done,rest]],"\n"]];
    If [verbosity >= 1,WriteString[$Output,"Partial fractioning\n"]];
    xundone = undone = Flatten[DoPartialFractioning /@ undone];
    If [verbosity >= 1,WriteString[$Output,"Non-unity removal\n"]];
    undone = Flatten[DoNonUnityRemoval /@ undone];
    count = limit;
    If [verbosity >= 1,WriteString[$Output,"; Barnes 1"]];
    While [count-- > 0,
       undone = undone /. enableAdditionalBarnes;
       undone = Flatten[ExpandInt /@ undone];
       undone = undone /. simplifyForBarnes;
       prior = undone;
       undone = Flatten[(blip; DoBarnes1[#])& /@ undone];
       done = Join[done,Select[undone,MBDimension[#] < level&]];
       undone = Select[undone,MBDimension[#] == level&];
       If [Sort[prior] === Sort[undone],Break[]]];
    count = limit;
    If [verbosity >= 1,WriteString[$Output,"; Barnes 2"]];
    While [count-- > 0,
       undone = undone /. simplifyForBarnes;
       prior = undone;
       undone = Flatten[(blip; DoBarnes2[#])& /@ undone];
       done = Join[done,Select[undone,MBDimension[#] < level&]];
       undone = Select[undone,MBDimension[#] == level&];
       If [Sort[prior] === Sort[undone],Break[]]];
    done = Flatten[ExpandInt /@ done];
    done = MergeAll[done];
    done = Flatten[ExpandInt /@ done];
    If [mergeWithLinearMapping,
      done = MergeAllWithLinearMapping[done];
      done = Flatten[ExpandInt /@ done]];
    undone = Select[undone,First[#]=!=0&];
    done = Join[undone,done,rest];
    If [verbosity >= 1,WriteString[$Output,"\nFinal: ",
                          SummarizeDimensions[done],"\n"]];
    SortByDimension[done]];

Process[ints_List,levels_List,options___Rule] :=
  Module[{max,min,dims,result,d},result=ints;
    If [Length[ints] == 0,Return[ints,Module]];
    dims = Intersection[MBDimension /@ result,levels];
    max = Max @@ dims;  min = Min @@ dims;
    Do[result = Process[result,d];
       ,{d,max,min,-1}];
    result];

(* Routines needed by Process; extracted 7/11/09 from process.m *)

SortByDimension[l_List] :=
   Sort[l,Length[#1[[2,2]]] > Length[#2[[2,2]]]&];

(* Returns relabeling needed to make "expr2" into "expr1", if one
   exists, the empty list if one doesn't.  The relabeling can of course
   be the identity relabeling! 
*)
Relabeling[expr1_Times,expr2_Times,mvars1_List,mvars2_List] :=
  Module[{gammalist1,gammalist2,maxlength1,maxlength2,lists1,lists2,pattern1,
          pattern2,extract1,extract2},
    gammalist1 = Select[Variables[expr1],Head[#]===Gamma&];
    maxlength1 = Max @@ (LeafCount @@ #& /@ gammalist1);
    gammalist2 = Select[Variables[expr2],Head[#]===Gamma&];
    maxlength2 = Max @@ (LeafCount @@ #& /@ gammalist2);
    If [maxlength1 != maxlength2 || Length[gammalist1] != Length[gammalist2],
       Return[{}]];
    (* Break up the product into lists of products with same-LeafCount 
       arguments -- as it appears in "expr" (i.e. with powers etc.)
       Non-Gamma objects are a separate entry *)
    lists1 = 
      Array[Function[j,Select[gammalist1,LeafCount @@ # == j&]],maxlength1];
    terms1 = Function[l,Select[expr1,Intersection[Variables[#],l] =!= {}&]] /@
                      lists1;
    terms1 = Join[terms1,{expr1/(Times @@ terms1)}];
    (* Need to turn each sublist back into a product to avoid issues of
       different orderings... *)
    lists2 = 
      Array[Function[j,Select[gammalist2,LeafCount @@ # == j&]],maxlength2];
    terms2 = Function[l,Select[expr2,Intersection[Variables[#],l] =!= {}&]] /@
                      lists2;
    terms2 = Join[terms2,{expr2/(Times @@ terms2)}];
    pattern1 = terms1 /. 
                 x_?(MemberQ[mvars1,#]&) :> Pattern @@ {ToExpression["v"<>ToString[x]],_};
    pattern2 = terms2 /. 
                 x_?(MemberQ[mvars2,#]&) :> Pattern @@ {ToExpression["v"<>ToString[x]],_};
    If [!MatchQ[terms2,pattern2],Return[{}]];
    (* Use the pattern to extract the list of variables *)
    extract1 = Union[Cases[expr1,_?(MemberQ[mvars1,#]&),-1]];
    extract1 = extract1 /. x_?(MemberQ[mvars1,#]&) :> ToExpression["v"<>ToString[x]];
    extract1 = pattern1->extract1;
    extract2 = Union[Cases[expr2,_?(MemberQ[mvars2,#]&),-1]];
    extract2 = extract2 /. x_?(MemberQ[mvars2,#]&) :> ToExpression["v"<>ToString[x]];
    extract2 = pattern2->extract2;
    (* Extract z variables *)
    varlist1 = terms1 /. extract1;
    varlist2 = terms2 /. extract2;
    (* The remapping from 2->1 is then: *)
    relabel = Thread[varlist2->varlist1]
    ]
Relabeling[0,0,__] = {dummy->dummy};
Relabeling[1,1,__] = {dummy->dummy};
Relabeling[0,1,__] = {};

(* Utilities to identify integrals that are identical, because
   integrands are proportional up to relabeling, and contours are "equivalent";
   these will be used on integrals after expansion into separate integrals
   for each term (ExpandInt)
*)

FreeAllVarsQ[expr_,vars_List] :=
  Intersection[Variables[expr],vars] == {};

(* 9/26/06: Search more generally for a linear change of z variables, with 
            coefficients +/- 1, that maps one expression into another.
            Return the empty list if none is found. 
*)

Class[Power[x_Gamma,p_],_] := p;
Class[Gamma[x_],_] := 1;
(* *** continue here *** *)
Class[Power[x_Symbol,p_],vars_List] := x /;
   Not[FreeAllVarsQ[p,vars]];
(* (Not[FreeQ[#,z_?(MemberQ[#,vars]&)]]&)],vars_List] := x; *)
(* Added 12/07/07 *)
Class[PolyGamma[n_,z_]] := P[n,1];
Class[PolyGamma[n_,z_]^p_] := P[n,p];

(* Constant here means: independent of any Mellin integration variable;
   updated 7/12/09 *)
ConstantQ[expr_,mvars_List:{}] := 
  FreeAllVarsQ[expr,mvars];

(* Does the expression depend on z-dependent powers of S or T? *)
NonTrivialQ[expr_] := !TrivialQ[expr];

(* No z-dependent powers of a parameter *)
TrivialQ[expr_,mvars_List:{}] := 
  FreeQ[expr,p_^(a_.+x_?(!FreeAllVarsQ[#,mvars]&))] && 
  FreeQ[expr,p_^(a_.-x_?(!FreeAllVarsQ[#,mvars]&))];

(* In comparing integrands, it is best to ignore PolyGamma factors
   too, that is to allow them to differ between integrals being combined
   after relabeling 
*)
NonCoreQ[expr_,mvars_List] := FreeQ[expr,Gamma] && TrivialQ[expr,mvars];
CoreQ[expr_,mvars_List] := !FreeQ[expr,Gamma] || NonTrivialQ[expr,mvars];

CoreFactor[0,_] = 0;
CoreFactor[1,_] = 1;
CoreFactor[expr_Times,mvars_List:{}] := Select[expr,CoreQ[#,mvars]&];
CoreFactor[expr_,mvars_List:{}] := 1 /; NonCoreQ[expr,mvars];

HashA[core_,vars_List] := 
  Hash[core /. Gamma->xGamma /. x_?(MemberQ[vars,#]&)->z] + LeafCount[core];
MergeValue[expr_,hash_:HashA,vars_:{}] := hash[CoreFactor[expr,vars],vars];

(* For merging allowing more general changes of variables, we cannot
   use the above hash values, because it isn't invariant under the changes;
   instead, we look at the pattern of classes.
*)
HashB[core_,vars_List:{}] := Hash[Sort[Class[#,vars]& /@ (List @@ core)]];
HashB[core_Integer,vars_List:{}] := Hash[{}];

shiftNeeded = {};
(* Merge two integrals if possible; returns a list of the 
   resulting integral(s).
   9/25/06: Keep track of origins (third argument to MBint if present) *)
KMerge[{MBint[int1_,contour1_,origins1___],MBint[int2_,contour2_,origins2___]}] :=
   Module[{mvars1,mvars2,expr1,expr2},
     mvars1=MellinVars[MBint[int1,contour1]];
     mvars2=MellinVars[MBint[int2,contour2]];
     expr1=CoreFactor[int1,mvars1];
     expr2=CoreFactor[int2,mvars2];
(*WriteString[$Output,"M expr1: ",InputForm[expr1],"\n"];
WriteString[$Output,"M expr2: ",InputForm[expr2],"\n"];*)
     If [(LeafCount[expr1] != LeafCount[expr2]) \
         || (Length[contour1[[2]]] != Length[contour2[[2]]]) \
         || contour1[[1]] =!= contour2[[1]],
        Return[{MBint[int1,contour1,origins1],MBint[int2,contour2,origins2]}]];
     (* 8/16/07 Speed up merging of zero-dimensional integrals *)
     If [MBDimension[MBint[int1,contour1]] == 0,
        Return[{MBint[FactorSquareFree[int1+int2],
                   Sequence @@ Join[{contour1},Thread[Join[{origins1},{origins2}]]]]},Module]];
     If [(relabel=Relabeling[expr1,expr2,mvars1,mvars2]) === {},
(*WriteString[$Output,"relabel x: ",relabel,"\n"];*)
        Return[{MBint[int1,contour1,origins1],MBint[int2,contour2,origins2]}]];
(*WriteString[$Output,"relabel: ",relabel,"\n"];*)
     (* 1/11/08: Need to sort contour1 too! *)
     If [(Sort /@ (contour2 /. relabel)) === (Sort /@ contour1),
        Return[{MBint[FactorSquareFree[int1+(int2 /. relabel)],
                   Sequence @@ Join[{contour1},Thread[Join[{origins1},{origins2}]]] ]}]];
     (* Avoid silly error messages... *)
     If [expr2 === 0,
         Return[{MBint[int1,Sequence @@ Join[{contour1},
                                            Thread[Join[{origins1},{origins2}]] ]]}]];
     If [expr1 === 0,
         Return[{MBint[int2,Sequence @@ Join[{contour2},
                                            Thread[Join[{origins1},{origins2}]] ]]}]];
     (* Otherwise need to shift contours *)
     shiftNeeded = Join[shiftNeeded,
                        {{MBint[int1,contour1],MBint[int2,contour2]}}];
     (* First integral will be shifted one; additional ones if any,
        residue terms from the shift *)
     (* So far, this does not appear to have generated accidentally
        divergent integrals, so no need to use DoMergingWithShift,
        though perhaps in principle we should *)
xint1 = int1;
xint2 = int2; xrelabel = relabel; xcontour2 = contour2; xcontour1 = contour1;
     (* 8/01/07: Need to sort contour1 too *)
     shifted = ShiftContours[MBint[int2 /. relabel,
                                   Sort /@ (contour2 /. relabel)],
                             Sort[contour1[[2]]]];
     If [avoidNonUnityCoefficients && HasNonUnityFactorQ[#[[1]]& /@ shifted],
        If [verbosity >= 3, WriteString[$Output,"(evaded c z)"]];
        Return[{MBint[int1,contour1,origins1],MBint[int2,contour2,origins2]},
               Module]];
     (**)         
     Join[{MBint[FactorSquareFree[int1+shifted[[1,1]]],
            Sequence @@ Join[{contour1},Thread[Join[{origins1},{origins2}]]]]},
          Flatten[ExpandInt[MBint[FactorSquareFree[#[[1]]],#[[2]],origins2]]& /@ Rest[shifted]]]
     ];

(* Merge two integrals, allowing linear remappings of variables, if possible *)
MergeWithLinearMapping[{MBint[int1o_,contour1o_],MBint[int2o_,contour2o_]}] :=
   Module[{mvars1=MellinVars[MBint[int1,contour1]],
           mvars2=MellinVars[MBint[int2,contour2]],
           expr1=CoreFactor[int1o,mvars1],expr2=CoreFactor[int2o,mvars2],
           contour1=contour1o,contour2=contour2o,int1=int1o,int2=int2o,
           mb1,mb2},
     If [(Length[contour1[[2]]] != Length[contour2[[2]]]) \
         || contour1[[1]] =!= contour2[[1]],
        Return[{MBint[int1,contour1],MBint[int2,contour2]}]];
     If [LeafCount[expr2] < LeafCount[expr1],
         (* Swap *)  temp = expr2; expr2 = expr1; expr1 = temp;
         temp = contour2;  contour2 = contour1;  contour1 = temp;
         temp = int2;  int2 = int1;  int1 = temp];
     If [(remap=FindLinearMapping[expr1,expr2]) === {},
        Return[{MBint[int1o,contour1o],MBint[int2o,contour2o]}]];
     (* Avoid silly error messages... *)
     If [expr1 === 0 && expr2 === 0,
         Return[{MBint[int1,contour1]}]];
     If [expr1 === 0,
         Return[{MBint[int2,contour1]}]];
     If [expr2 === 0,
         Return[{MBint[int1,contour1]}]];
     mb1 = MBint[int1,contour1];
     mb2 = MBint[int2,contour2];
     mb2 = ReplaceVar3[mb2,remap];
     int2 = mb2[[1]];  contour2 = Sort /@ mb2[[2]];
     If [contour2 === contour1,
        Return[{MBint[FactorSquareFree[int1+int2],contour1]}]];
     (* Otherwise need to shift contours *)
     shiftNeeded = Join[shiftNeeded,
                        {{MBint[int1,contour1],MBint[int2,contour2]}}];
     (* First integral will be shifted one; additional ones if any,
        residue terms from the shift *)
(*     shifted = ShiftContours[MBint[int2,contour2],contour1[[2]]];*)
     result = DoMergingWithShift[int1,int2,contour1,contour2];
(* *** shifted to new routine *** *)
(*
     Join[{MBint[FactorSquareFree[int1+shifted[[1,1]]],contour1]},
         Flatten[ExpandInt[MBint[FactorSquareFree[#[[1]]],#[[2]] ]]& /@ 
                              Rest[shifted]]];
     ( * Be careful that this doesn't turn int2 into a divergent
        integral (pole on the contour); if it does, first
        try shifting the other way; if that doesn't work either,
        perturb the contour & shift *both* integrals to the new contour * )
     If [Or @@ (NaivelyBadIntQ /@ shifted)
         ( * More expensive check, do it 2nd: * )
         && Or @@ (BadIntQ /@ shifted),
         shifted = ShiftContours[MBint[int1,Sort /@ contour1],
                                 Sort[contour2[[2]]]];
                                  (* Sort both 1/31/08 *)
         result = \
          Join[{MBint[FactorSquareFree[int2+shifted[[1,1]]],contour2]},
            Flatten[ExpandInt[MBint[FactorSquareFree[#[[1]]],#[[2]] ]]& /@ 
                                Rest[shifted]]]];
     If [Or @@ (NaivelyBadIntQ /@ shifted)
         ( * More expensive check, do it 2nd: * )
         && Or @@ (BadIntQ /@ shifted),
         first = Perturb[MBint[int1,contour1]];    
         shifted = ShiftContours[MBint[int2,Sort /@ contour2],
                                 Sort[first[[2,2]]]]; (* Sort both 1/31/08 *)
         result = \
          Join[{MBint[FactorSquareFree[first[[1]]+shifted[[1,1]]],first[[2,2]]]},
            Flatten[ExpandInt[MBint[FactorSquareFree[#[[1]]],#[[2]] ]]& /@ 
                              Rest[shifted]]]];
*)
     result
     ];

SortForMerging[intlist_List,hash_:HashA] :=
 Sort[intlist,(MergeValue[#1[[1]],hash,AllMellinVars[intlist]] < 
               MergeValue[#2[[1]],hash,AllMellinVars[intlist]])
              || ((MergeValue[#1[[1]],hash,AllMellinVars[intlist]] == 
                   MergeValue[#2[[1]],hash,AllMellinVars[intlist]])
                   && Length[MellinVars[#1]] < Length[MellinVars[#2]])&];

SortForMergingWithLinearMapping[intlist_List] := 
   SortForMerging[intlist,HashB];

count = 0;
withSecondaries = {};
(* MergeList assumes that only mergeable expressions have identical
   hashes and hence will end up next to each other.  Hence it cannot be used
   for merging with linear remappings, but only for simpler mergings based
   on relabeling.  It should be applied to a list sorted using
   SortForMerging above *)
MergeList[intlist_List,ping_:False] :=
 Module[{merged,source=intlist,result,i=1,done=False},
   secondariesSeen = False;
   While[i < Length[source],
     merged = KMerge[source[[{i,i+1}]]];
     If [merged === source[[{i,i+1}]],i += 1,
        xsourceML = source[[{i,i+1}]];
        xmerged = merged;
(*
If [!TwoZFreeQ[merged],Print["Warning: 2 z generated (ML)"];
Save["merged2z.m",merged,xsourceML]];
If [!FreeQ[merged,Residue],
Save["badmerge.m",merged,xsourceML]; Throw["Bad merge"]];
If [!FreeQ[merged,Gamma[_/2]],Print["Warning: half-int z generated (ML)"]];
*)
        If [ping,blip];
        If [Length[merged] > 1,If [verbosity >= 2,WriteString[$Output,"(s)"]];
             secondariesSeen = True;
             withSecondaries = Join[withSecondaries,{source[[{i,i+1}]]}]];
        (* Put secondary [residue] terms in "merged" at the end, so as
           not to disturb further possible mergings; in principle another
           round of sorting & merging should be done afterwards *)
        source = Join[source[[Range[i-1]]],{First[merged]},
                      source[[Range[i+2,Length[source]]]],Rest[merged]] ];
     ];
   source
   ] /; Length[intlist] >= 2;
MergeList[intlist_List,ping_:False] := intlist /; Length[intlist] < 2;

(* Merge repeatedly, to exhaust all possible mergings including residue
   terms from previous mergings *)
MergeAll[ints_List,ping_:False] :=
  Module[{merged=ints,prior={}},
    While[Sort[merged] =!= Sort[prior],
       If [ping,If [verbosity >= 2,WriteString[$Output,"|"]]];
       prior = merged;
       merged = SortForMerging[merged];
       If [ping,If [verbosity >= 2,WriteString[$Output,Length[merged],"+"]]];
       xmerged = merged = MergeList[merged,ping]];
    merged ];


(* Merge repeatedly, to exhaust all possible mergings including residue
   terms from previous mergings *)
mcount = 0;
MergeAllWithLinearMapping[ints_List,ping_:False] :=
  Module[{merged=ints,prior={},count=1},
    xintsLM = ints;
    While[Sort[merged] =!= Sort[prior] && count++ < 5,
       If [verbosity >= 2,WriteString[$Output,"\n|"]];
       prior = merged;
       merged = SortForMergingWithLinearMapping[merged];
       xpriorMALM = prior;
       If [count == 5,
          (* Why are we doing this so many times?  *)
          file = ToString[Unique[mgtag]];
          (*WriteString[$Output," [",file,"]"];
          Save[file<>".m",xpriorMALM]*)];
       xmerged = merged = MergeListWithLinearMapping[merged,ping];
       (* Merging may result in some integrals being expanded (if they
          arise as a result of shifting contours); it's better to re-merge
          these with Merge rather than MergeWithLinearMapping *)
       merged = SortForMerging[merged];
       If [verbosity >= 2,WriteString[$Output,"&"]];
       xmerged2 = merged = MergeList[merged,ping];
       ];
    merged ];

NonIntegerQ[i_] := !IntegerQ[i];
PatternN[prefix_Symbol,i_Integer] := 
  Optional[Pattern @@ {ToExpression[ToString[prefix]<>ToString[i]],_}];

(*
  Search for, and perform, replacements like

   Gamma[3+z1+z2] Gamma[1+z1] Gamma[1+z2]/(Gamma[2+z1] Gamma[2+z2]) ->
        Gamma[2+z1+z2] (Gamma[1+z1]/Gamma[2+z1] + Gamma[1+z2]/Gamma[2+z2])

  which then open new possibilities for applying Barnes lemmas.

  We search first for all ratios of Gamma functions which yield a simple
  rational function; then for numerator Gammas whose arguments are of
  the form one plus (or -1 minus) a linear combination of arguments in 
  the former list (with coefficients +/- 1)
*)
FPFtimeLimit = 480;
FindPartialFractioning[int_MBint,bound_:1] :=
  Module[{integrand=int[[1]],numer,denom,rational,params,aux,linear,
          sol,result,vars=#[[1]]& /@ int[[2,2]],dummy1,dummy2,rep={}},
     xsource = int;
     (* Avoid errors that would otherwise arise... *)
     If [NumberQ[integrand],Return[{}]];
     If [integrand =!= Expand[integrand] || Head[integrand] =!= Times,
        (* FPF requires pure-product integrand *)
        Return[{}]];
     (* The code below won't really work in one-dimensional cases, so
        ignore this *)
     If [Length[vars]<=1,Return[{}]];
     numer = Numerator[integrand];
     denom = Denominator[integrand];
     numer *= dummy1 dummy2;
     numer = List @@ numer;
     numer = numer /. 
             f_[x__]^p_ :> Array[f[x]&,p] /; MemberQ[{Gamma,PolyGamma},f];
     numer = Union[Flatten[numer]];
     numer = Select[numer,Head[#] === Gamma&];
     numer = First /@ numer;
     (**)
     denom *= dummy1 dummy2;
     denom = List @@ denom;
     denom = denom /. 
             f_[x__]^p_ :> Array[f[x]&,p] /; MemberQ[{Gamma,PolyGamma},f];
     denom = Union[Flatten[denom]];
     denom = Select[denom,Head[#] === Gamma&];
     denom = First /@ denom;
     (* "rational" is list of eligible denominator arguments *)
     rational = Flatten[Outer[If [Expand[#2-#1] === 1,{#2},{}]&,numer,denom]];
     xrat = rational;
     (* Now hunt for numerators that are suitable linear combinations *)
     params = Array[c,Length[rational]];
     linear = params.(rational-1);
     indep = D[linear,#]& /@ vars;
     eqns = And @@ (-bound <= # <= bound & /@ params);
     (* Need to enforce no cancellation between different c[i] -- this isn't
        right 
     eqns = eqns && And @@ (# != 0 & /@ indep); *)
     (* Only consider numerator Gammas whose arguments don't differ by
        a simple integer from eligible denominators (i.e. wouldn't be a 
        sum of two or more) *)
     xnumer1 = numer;
     numer = Select[numer,And @@ (NonIntegerQ /@ (denom-#))
                          && And @@ (NonIntegerQ /@ (denom+#))&];
     xnumer2 = numer;
     (* And only consider numerator Gammas whose arguments are built out
        of the same variables as in the legitimate denominators *)
     allowedVars = Union @@ Variables /@ rational;
     numer = Select[numer,Complement[Variables[#],allowedVars] == {}&];
     xnumer3 = numer;
     If [False,
     (* Look for all possible solutions simultaneously -- only one numerator
        is allowed in any given solution *)
     aux = Array[ca,Length[numer]];
     eqns = eqns && (aux.aux == 1) && (aux.numer-1 - linear == 0);
     xeqns = eqns;
     (* Need values for MB integration variables to use FindInstance *)
     eqns = eqns /. Array[(vars[[#]] -> 1/Prime[100+#])&,Length[vars]];
     xaux = aux;
     (* Don't let it hang *)
     sol=TimeConstrained[Flatten[FindInstance[eqns,Join[params,aux],Integers]],
                         FPFtimeLimit,{}];];
     xparams = params;
     (* Is it faster to sweep through the numerators one by one??? 
        Or is the quadratic constraint aux.aux responsible for slowness? *)
     eqnBase = eqns;
     (* Sweep in order of increasing # variables *)
     numer = Sort[numer, Length[Intersection[vars,Variables[#1]]] <
                         Length[Intersection[vars,Variables[#2]]] &];
     xdenom = denom;
     xrational = rational;
     xlinear = linear;
     xnumer = numer;
     Clear[found];
     Do[eqns = eqnBase && (numer[[ix]]-1 - linear == 0);
        (* Need values for MB integration variables to use FindInstance *)
        eqns = eqns /. Array[(vars[[#]] -> 1/Prime[100+#])&,Length[vars]];
        (* Don't let it hang *)
        sol=TimeConstrained[Flatten[FindInstance[eqns,params,Integers]],
                            FPFtimeLimit,{}];
        If [Length[sol]>0,found = ix; Break[]];
        ,{ix,1,Length[numer]}];
     (* To enhance: pick solution with fewest denominators,
        that is fewest resulting terms, by incrementally working up 
        in |c|^2 *)
     If [Length[sol]>0,
         ratios = Times @@ Array[If [(params[[#]] /. sol) != 0,
                                Gamma[rational[[#]]-1]^PatternN[pn,#]*
                                Gamma[rational[[#]]]^PatternN[pd,#],1]&,
                                 Length[rational]];
         xratios = ratios = ratios /. sol;
         rep = Gamma[numer[[found]] /. sol]*ratios ->
               Gamma[(numer[[found]]-1) /. sol]*
                     (ratios /. Pattern->({##}[[1]]&) /. Optional->Identity)*
                  (params.(Gamma[#]/Gamma[#-1]& /@ rational) /. sol)];
     rep
    ];   

DoPartialFractioning[int_MBint,bound_:1] :=
  Module[{sol,result,anySol = False},
   result = RepairNaivelyBad /@ Flatten[
   (xsol = sol = FindPartialFractioning[#,bound];
   If [Length[sol]>0, anySol = True; 
       If [verbosity >= 1,WriteString[$Output,"Partial fractioning using ",
                         Intersection[Cases[sol[[1]],_Symbol,-1],
                                      #[[1]]& /@ int[[2,2]]]]];
       currentTarget = #;
       ExpandInt[# /. sol],#])& /@ Flatten[{ExpandInt[int]}]];
   If [anySol && verbosity >= 1,
      WriteString[$Output,"; ",{MBDimension[int]} -> (MBDimension /@ result),"\n"];];
   CheckRes /@ result;
   result];

(* 8/7/07
   Find a linear transformation of the variables that allows all non-unity
   (!= +/- 1) coefficients of Mellin variables inside Gamma or PolyGamma
   functions to be removed.
*)
FNURtimeLimit = 60;
FindNonUnityRemoval[int_MBint,bound_:1] :=
  Module[{integrand=int[[1]],vars=#[[1]]& /@ int[[2,2]],eliminate,
          functions,transform,rep,args,constraint,avars,j,dvars,eqns,
          zrep,c,backup={},backupZrep = {},backupVar,allsols,det},
     (* Avoid errors that would otherwise arise... *)
     If [NumberQ[integrand],Return[{}]];
     If [integrand =!= Expand[integrand] || Head[integrand] =!= Times,
        (* FNUR requires pure-product integrand *)
        Return[{}]];
     (* The code below won't really work in one-dimensional cases, so
        ignore this *)
     If [Length[vars]<=1,Return[{}]];
     functions = Select[Variables[integrand],
                    MemberQ[{Gamma,PolyGamma},Head[#]]&];
     functions = Last /@ functions;
     xfunc = functions;
     transform = Array[c,{Length[vars],Length[vars]}];
     (* Diagonal elements 1 *)
     transform = transform /. c[i_,i_]->1;
     det = Det[transform];     
     rep = Thread[vars->transform.vars];
     fargs = D[functions /. rep,#]& /@ vars;
     fargs = Flatten[fargs];
     If [And @@ (-1 <= # <= 1 & /@ (fargs /. c[_,_]->0)),
         (*Print["No change needed."];*)  Return[{},Module]];
     (* Bounded coefficients in transformation *)
     coeffs = Flatten[Variables /@ fargs];
     coeffs = Union[coeffs];
     constraint = And @@ (-bound <= # <= bound & /@ coeffs);
     xconstraint = constraint;
     (* Eliminate non-unity factors *)
     fargs = Union[fargs];
     eliminate = And @@ (-1 <= # <= 1 & /@ fargs);    
     (* We need to impose det != 0; but if there are a lot of variables,
        this is very slow.  Generate several instances, and pick the
        first with non-zero determinant instead *)
     eqns = eliminate && constraint;
     xeqns = eqns;
     (* Time limit added 12/04/07 *)
     xsol = sol=TimeConstrained[FindInstance[eqns,coeffs,Integers,10],
                            FNURtimeLimit,{}];
     If [Length[sol] > 0,
        sol = Select[sol,(det /. #) != 0&]];
     If [Length[sol] > 0, sol = First[sol]];
     xrsol=sol;
     If [Length[sol] > 0, 
        zrep = Select[rep /. sol,#[[1]] =!= #[[2]]&];
        (*Print[zrep];*)
        Return[zrep,Module]];
     If [verbosity >= 2, WriteString[$Output,"solution not found.\n"]];  
     Return[{}];
  ];

DoNonUnityRemoval[int_MBint,bound_:1] :=
  Module[{sol,result,anySol = False},
   result = Flatten[
   (xsol = sol = FindNonUnityRemoval[#,bound];
    If [Length[sol]>0, anySol = True; 
       currentTarget = #;
       ReplaceVar3[#,sol] /. f_[z_]:>f[Expand[z]] /; 
                              MemberQ[{Gamma,PolyGamma},f],#])& /@ 
         Flatten[{ExpandInt[int]}]];
   result];

(* and routines it needs... from process.m *)
(*<<process.m;*)

End[];
EndPackage[];
