(* mbeParameterSubtractionRoots.m -- development sidecar (2026-09-23), loaded AFTER mbeParameterSubtractionCube.m.
   Extends MBParameterSubtraction`Private`parseNative to native responses computed with algebraic_letters and
   spectator_algebraic_letters enabled.  HyperFLINT splits an irreducible quadratic lc x^2 + b x + c of the current
   integration variable into inert roots Wm_k, Wp_k (and WmOverWp_k), listed per response in "algebraic_letters" with
   exact strings lc, sum = -b/lc, product = c/lc, disc = b^2 - 4 lc c.  Binary convention (hyperflint_syntax.md 2.5,
   back_substitute source): Wm = sum/2 - Sqrt[disc]/(2 lc), Wp = sum/2 + Sqrt[disc]/(2 lc).  The letter table is
   process-local (indices collide across responses), so the rules are built from each response's own table.
   Responses without algebraic letters are parsed exactly as before.  An unmapped root atom is refused: no branch is
   chosen by hand.  Contour tags (2026-09-23): HyperFLINT/HyperIntica write an on-path pole as PV-part +
   delta[var]*(I Pi)*(residue part), an exact tagging of the two conjugate deformations; for integrands analytic on the
   open integration domain both deformations give the same integral, so the value is the delta-free part: delta -> 0.
   The structure (linear in delta, delta only with I Pi, delta-free part free of I and Pi) is checked by the
   certification (certify_alg.py) before a record is accepted.  Validated on MB8au r12 s1 job 28 against direct
   quadrature. *)
Begin["MBParameterSubtraction`Private`"];
rootParse[s_String] := Block[{$Context = "Global`", $ContextPath = {"System`", "Global`"}},
  ToExpression[StringReplace[s, "_" -> "$"], InputForm]];
rootRulesOf[r_Association] := Module[{alg = Lookup[r, "algebraic_letters", {}]},
  If[!ListQ[alg], alg = {}];
  Flatten[Table[Module[{k = ToString[a["idx"]], lc = rootParse[a["lc"]], sm = rootParse[a["sum"]], disc = rootParse[a["disc"]], wm, wp},
     wm = sm/2 - Sqrt[disc]/(2 lc); wp = sm/2 + Sqrt[disc]/(2 lc);
     {Symbol["Global`Wm$" <> k] -> wm, Symbol["Global`Wp$" <> k] -> wp, Symbol["Global`WmOverWp$" <> k] -> wm/wp,
      Symbol["Global`sqrt$disc$" <> k] -> Sqrt[disc]}], {a, alg}]]];
parseNative[r_Association] := Module[{parse, value, rules = rootRulesOf[r], rows},
  If[!ListQ[Lookup[r, "result", None]] || AnyTrue[{"failed", "divergent", "error"}, KeyExistsQ[r, #] &],
    Return[refuse["Native finite integral not certified"], Module]];
  parse[s_String] := rootParse[s] /. rules /. Global`atomRules /. Global`delta[_] -> 0;
  rows = r["result"];
  If[!FreeQ[parse /@ Join[rows[[All, "coef"]], Flatten[rows[[All, "key"]]]],
      s_Symbol /; StringMatchQ[SymbolName[s], ("Wm$" | "Wp$" | "WmOverWp$" | "sqrt$disc$") ~~ __] || SymbolName[s] === "delta"],
    Return[refuse["Unmapped algebraic letter or unresolved contour marker in native output"], Module]];
  value = Total[Table[parse[row["coef"]] Times @@ (periodWord[parse /@ #] & /@ row["key"]), {row, rows}]];
  Global`gvExact[value]];
End[];
Print["[mbeParameterSubtractionRoots] native responses with algebraic letters: Wm/Wp realized per response; contour tags delta -> 0 (development)."];
