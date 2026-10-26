(* AUTHORSHIP (release R2, 2026-09-07): component of the MBSymbolicInt package (Standard route). Authors of MBSymbolicInt: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* mbeLevel6Reduce.m -- sidecar (2026-09-05): EXACT reduction of HyperFLINT raw words whose letters are sixth roots of
   unity (the intrinsic Landau letter 1 - w + w^2 of the MB13 two-fold degenerate-pairing family) to known constants,
   through the published Henn-Smirnov-Smirnov tables (arXiv:1512.08389; level6_tables/, weights <= 4;
   provenance and standing in level6_tables/PROVENANCE.md).
   Chain (every step an exact identity):  Mpl/mzv words -> PolyLogTools G (LiToG, the verbatim-matched bridge)
   -> endpoint 1 (NormalizeG) -> letters canonicalised to {0, +-1, r1..r4} -> G = GR + I GI -> real part
   (the value is real; the imaginary part must reduce to 0) -> sl-tables -> basis -> known constants
   (GI[r2] = -Pi/3, GR[-1] = Log 2, GR[r4] = Log[3]/2, GR[0,0,1] = -Zeta[3]).  Anything else left symbolic makes
   the result inexact and the caller refuses it (fail-closed).  Numeric self-gate: the tables' 4000-digit basis
   values against HyperFLINT's own numeric of the raw words (a development gate, not a producer). *)
(* MBAnalytica layout: the tables are in dep/level6_tables, two folders above src/SymbolicInt (the release had them next to
   this file; the silent DirectoryQ test below then skipped the load and every sixth-root reduction was refused) *)
Global`$bwsL6Dir = FileNameJoin[{ParentDirectory[ParentDirectory[DirectoryName[ExpandFileName[$InputFileName]]]], "dep",
  "level6_tables"}] <> $PathnameSeparator;
Global`$bwsL6Loaded = False;
(* 2026-09-05 (worker test): the table files name their symbols GI, GR, r1..r4 UNQUALIFIED.  Read inside the running
   engines (lazy load from a piece computation) they resolved to symbols of another context, so no rule matched the
   Global`GI/GR words the reducer builds ("imaginary part does not reduce to 0" on every worker piece while the same
   chain reduced at top level).  Read the files in a Global`-only context, and load eagerly at install time. *)
bwsL6Get[f_] := Block[{$Context = "Global`", $ContextPath = {"Global`", "System`"}}, Get[f]];
bwsL6Load[] := If[! TrueQ[Global`$bwsL6Loaded],
  Module[{d = Global`$bwsL6Dir, tabs, vals},
    tabs = Join @@ (bwsL6Get[d <> #] & /@ {"sl1re.m", "sl1im.m", "sl2re.m", "sl2im.m", "sl3re.m", "sl3im.m", "sl4re.m", "sl4im.m"});
    Global`$bwsL6Disp = Dispatch[tabs];
    vals = Join @@ (bwsL6Get[d <> #] & /@ {"maptores4000rew1.txt", "maptores4000imw1.txt", "maptores4000rew2.txt", "maptores4000imw2.txt",
       "maptores4000rew3.txt", "maptores4000imw3.txt", "maptores4000rew4.txt", "maptores4000imw4.txt"});
    Global`$bwsL6Vals = vals;
    Global`$bwsL6Loaded = True;
    WriteString["stdout", "    [L6] sixth-root reduction tables loaded (" <> ToString[Length[tabs]] <> " rules, " <>
      ToString[Length[vals]] <> " basis values; first rule " <> ToString[First[tabs], InputForm] <> ")\n"]]];
(* canonical exact form of a constant built from Pi, Zeta, Log 2, Log 3: logarithms of positive numerics are expanded
   (an exact identity for positive arguments), Log 2 / Log 3 are collected as polynomial placeholders so that their
   cancellation is a polynomial identity (06:40: Simplify alone left "(143/24) Log 2 Zeta[3] - Log[32 2^(23/24)] Zeta[3]"
   and "Log[2] Log[531441/64]" uncancelled, and the two-construction gate then refused equal values) *)
bwsL6LogCanon[e_] := Module[{f},
  f = e /. Log[x_] /; NumericQ[x] && FreeQ[x, Complex] && TrueQ[Positive[x]] :> PowerExpand[Log[x]];
  f = Expand[f /. {Log[2] -> Global`l6LogTwo, Log[3] -> Global`l6LogThree}];
  Simplify[f] /. {Global`l6LogTwo -> Log[2], Global`l6LogThree -> Log[3]}];
bwsL6RootTab := {{0, 0}, {1, 1}, {-1, -1}, {Exp[Pi I/3], Global`r1}, {Exp[-Pi I/3], Global`r2}, {Exp[2 Pi I/3], Global`r3}, {Exp[-2 Pi I/3], Global`r4}};
bwsL6Letter[a_] := Module[{n = N[a, 30], m}, m = SelectFirst[bwsL6RootTab, Abs[N[#[[1]], 30] - n] < 10^-20 &, $Failed];
  If[m === $Failed, Throw[{"unknown letter", a}, "l6"], m[[2]]]];
bwsL6MplToG[x_] := x /. h_[a_List, b_List] /; SymbolName[h] === "Mpl" :> PolyLogTools`LiToG[PolyLogTools`Li[a, b]] /.
                   h_[ms__Integer] /; SymbolName[h] === "mzv" :> PolyLogTools`LiToG[PolyLogTools`Li[Abs /@ {ms}, Sign /@ {ms}]];
bwsL6ToGRGI[PolyLogTools`G[as__, x_]] := Module[{ls}, If[x =!= 1, Throw[{"endpoint", x}, "l6"]];
  ls = bwsL6Letter /@ {as}; If[First[ls] === 1, Throw[{"divergent", {as}}, "l6"]];
  Global`GR @@ ls + I Global`GI @@ ls];
bwsL6ReIm[e_] := Module[{objs, syms, rules, back, ee, re, im},
  objs = Union[Cases[e, _Global`GR | _Global`GI, {0, Infinity}]];
  syms = Table[Unique["hb"], {Length[objs]}];
  rules = Thread[objs -> syms]; back = Thread[syms -> objs];
  ee = Expand[(e /. rules) /. {(I - Sqrt[3])/(I + Sqrt[3]) -> Exp[2 Pi I/3], (I + Sqrt[3])/(I - Sqrt[3]) -> Exp[-2 Pi I/3]}];
  re = Simplify[ComplexExpand[Re[ee]]] /. back; im = Simplify[ComplexExpand[Im[ee]]] /. back;
  {re, im}];
bwsL6Known = {Global`GI[Global`r2] -> -Pi/3, Global`GR[-1] -> Log[2], Global`GR[Global`r4] -> Log[3]/2, Global`GR[0, 0, 1] -> -Zeta[3]};
(* exact sixth-root basis constants L6`GR[..] / L6`GI[..] (letters as strings "r1".."r4"): numeric values from the
   4000-digit tables (opt-in path above) *)
bwsL6Tag[x_] := Switch[x, Global`r1, "r1", Global`r2, "r2", Global`r3, "r3", Global`r4, "r4", _, x];
bwsL6Untag[x_] := Switch[x, "r1", Global`r1, "r2", Global`r2, "r3", Global`r3, "r4", Global`r4, _, x];
N[L6`GR[a___], p_] := (bwsL6Load[]; N[(Global`GR @@ (bwsL6Untag /@ {a})) /. Global`$bwsL6Vals, p]);
N[L6`GI[a___], p_] := (bwsL6Load[]; N[(Global`GI @@ (bwsL6Untag /@ {a})) /. Global`$bwsL6Vals, p]);
(* returns an exact expression in known constants, or $Failed *)
bwsL6Reduce[raw_] := Catch[Module[{g, x, re, im, rr, ri, num, val, hfnum},
  bwsL6Load[];
  g = Block[{PolyLogTools`PLT$AutoConvertToKnownConstants = False},
    Expand[bwsL6MplToG[raw] /. gg : PolyLogTools`G[___, y_] /; y =!= 1 :> PolyLogTools`NormalizeG[gg]]];
  x = g /. gg_PolyLogTools`G :> bwsL6ToGRGI[gg];
  {re, im} = bwsL6ReIm[x];
  rr = Expand[re //. Global`$bwsL6Disp]; rr = Expand[rr //. Global`$bwsL6Disp];
  ri = Expand[im //. Global`$bwsL6Disp]; ri = Expand[ri //. Global`$bwsL6Disp];
  rr = Collect[rr, _Global`GR | _Global`GI, Simplify]; ri = Collect[ri, _Global`GR | _Global`GI, Simplify];
  If[! PossibleZeroQ[ri], WriteString["stdout", "    [L6] imaginary part does not reduce to 0: " <> ToString[Short[ri, 3], InputForm] <> "\n"]; Throw[$Failed, "l6"]];
  (* the known constants (exact identities) go in BEFORE the numeric self-gate: the 4000-digit table carries the basis
     elements only, and GR[-1] = log 2 is a basis element with no table value (06:25: every real part was refused with
     "2.5 GR[-1]" left inside the numeric; in the standalone test PolyLogTools' own GR had evaluated it) *)
  val = rr /. bwsL6Known;
  num = Quiet@N[val /. Global`$bwsL6Vals, 30];
  hfnum = Quiet@Global`ivfNumericCheck[raw, {}];
  If[! (NumericQ[num] && NumericQ[hfnum] && Abs[num - hfnum] < 10^-8 (1 + Abs[hfnum])),
    WriteString["stdout", "    [L6] basis-value numeric " <> ToString[num] <> " vs HyperFLINT numeric " <> ToString[hfnum] <> " -> refused\n"]; Throw[$Failed, "l6"]];
  val = bwsL6LogCanon[val];
  (* 2026-09-27 (opt-in, environment MBE_L6_ACCEPT_BASIS=1, set only by the Mellin-space route tools): the remaining
     elements are BASIS elements of the tables (each has its 4000-digit value, used by the self-gate above), e.g.
     GI[0,r2] = Im G(0,r2;1) = -Im Li2(e^(i Pi/3)) = -Cl2(Pi/3).  They are kept as exact symbols L6`GR/L6`GI (letters
     tagged as strings), numerically evaluable through the table values; the caller's own gates and the final exact
     benchmark comparison (where they must cancel) decide.  Default (variable unset): refused, as before. *)
  If[! FreeQ[val, Global`GR | Global`GI],
    If[Environment["MBE_L6_ACCEPT_BASIS"] === "1",
      val = val /. {Global`GR[a___] :> (L6`GR @@ (bwsL6Tag /@ {a})), Global`GI[a___] :> (L6`GI @@ (bwsL6Tag /@ {a}))};
      WriteString["stdout", "    [L6] reduced to sixth-root BASIS constants, kept exact (MBE_L6_ACCEPT_BASIS=1): " <> ToString[Short[val, 4], InputForm] <> "\n"],
      WriteString["stdout", "    [L6] reduced to sixth-root basis elements that are not pure known constants: " <> ToString[Short[val, 4], InputForm] <> " -> refused\n"]; Throw[$Failed, "l6"]]];
  WriteString["stdout", "    [L6] sixth-root constants reduced exactly: " <> ToString[val, InputForm] <> "\n"];
  val], "l6"];
WriteString["stdout", "[mbeLevel6Reduce] sidecar installed (bwsL6Reduce: Henn-Smirnov-Smirnov sixth-root tables, weight <= 4).\n"];
(* eager load at install time (top level), so a table problem is visible in the load log and not first inside a piece *)
If[DirectoryQ[Global`$bwsL6Dir], Quiet@Check[bwsL6Load[], WriteString["stdout", "    [L6] table load FAILED at install\n"]],
  WriteString["stdout", "    [L6] WARNING: no tables at " <> Global`$bwsL6Dir <> " -- sixth-root reductions will be refused\n"]];
