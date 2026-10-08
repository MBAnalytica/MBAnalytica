(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Syed Mehedi Hasan, Taushif Ahmed, Andreas Rapakoulias, Sumit Banik. *)
(* mbeAffineBellRung.m — sidecar rung (2026-09-04, DRAFT until the abp probe validates): closes psi-dressed
   balanced-kernel one-folds via the affine-Bell producer (mbe_affine_bell_lib.m, AUTO kernel spec).
   CLASS (found on the new MB12 mop-up set): 1-fold pieces  Rat(z) * Gamma-kernel * psi^(m)(affine)^k  where the
   kernel is balanced (Beta-pairable after shifts) and the psi arguments are integer shifts of a leg — e.g.
   3 G(-z)^2 G(z) G(1+z)^2 psi(z)^2 / G(2+z), which defeats attempt 0 (unfaithful), the tower (psi-power > 1),
   and every cube attempt within worker budgets.
   MECHANISM: extends the mbeDirectCubeClose wrap (attempt 0.5) installed by mbeReflZero.m — order inside the wrap:
     (1) reflection-zero exact test (existing), (2) affine-Bell producer, (3) original closer.
   The producer runs with its OWN 40-digit contour gate ("Gate"->True) AND the sealed caller re-gates the returned
   value against the piece quadrature — double-gated, fail-closed.  Load AFTER mbeReflZero.m. *)
If[DownValues[MBtoMPL`Private`mbeReflZeroOrig] =!= {} &&
   DownValues[Global`abpClose] === {},
  Quiet@Check[Get[FileNameJoin[{DirectoryName[ExpandFileName[$InputFileName]], "mbe_affine_bell_lib.m"}]], Null]];
If[DownValues[MBtoMPL`Private`mbeReflZeroOrig] =!= {} &&
   DownValues[Global`abpClose] =!= {} &&
   DownValues[MBtoMPL`Private`mbeABRungOrig] === {},
 Module[{},
  If[! AssociationQ[Global`abpCubeMemo], Global`abpCubeMemo = <||>];
  (* save the CURRENT mbeDirectCubeClose (= the ReflZero wrapper) and re-wrap *)
  MBtoMPL`Private`$mbeABRungSaved = DownValues[MBtoMPL`Private`mbeDirectCubeClose];
  DownValues[MBtoMPL`Private`mbeABRungOrig] =
    MBtoMPL`Private`$mbeABRungSaved /.
      HoldPattern[MBtoMPL`Private`mbeDirectCubeClose] -> MBtoMPL`Private`mbeABRungOrig;
  Clear[MBtoMPL`Private`mbeDirectCubeClose];
  MBtoMPL`Private`mbeDirectCubeClose[ig_, ctr_, vrs_, to_] := Module[{z, c0, v},
    If[Length[vrs] === 1 && ! FreeQ[ig, PolyGamma],
     z = First[vrs]; c0 = Quiet@Check[N[ctr[[1, 2]]], $Failed];
     If[NumericQ[c0],
      v = Quiet@CheckAbort[TimeConstrained[
         Global`abpClose[ig, z, c0, "AUTO", "Timeout" -> Max[300, to], "Gate" -> True, "Log" -> None],
         Max[900, 3 to], $Failed], $Failed];
      If[v =!= $Failed && FreeQ[v, $Failed | Indeterminate | ComplexInfinity] && NumericQ[Quiet@N[v]],
       WriteString["stdout", "    [ABRung] affine-Bell producer closed the psi-dressed piece (gated).\n"];
       Return[v, Module]]]];
    MBtoMPL`Private`mbeABRungOrig[ig, ctr, vrs, to]];
  WriteString["stdout", "[mbeAffineBellRung] sidecar installed (attempt-0.5 chain: ReflZero -> affine-Bell -> original).\n"]]];
