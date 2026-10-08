(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Taushif Ahmed, Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias. *)
(* mbeReflZero.m — sidecar (2026-09-03): exact reflection-zero closer for the degenerate one-fold class.
   CLASS (found on the new MB12): one-fold pieces whose kernel is the no-window balanced product
   Gamma[-z]^a Gamma[1+z]^a (= (Pi/Sin[Pi z])^... after reflection) times a rational function, ODD under
   the reflection z -> -1-z.  On a contour in (-1,0) all poles sit at integers, so the contour deforms to
   Re z = -1/2 where the reflection maps the line to itself with orientation reversal: the integral is
   EXACTLY 0.  (MB12 instance: tails 1/(z(1+z)^2) + 1/(z^2(1+z)) = (2z+1)/(z^2(1+z)^2), odd; quadrature
   confirmed 1e-57.)  The DegClass ladder burned every budget on this piece and ledgered it SUSPECT.
   MECHANISM: wraps MBtoMPL`Private`mbeDirectCubeClose (DegClass attempt 0.5, the first special attempt).
   The wrapper returns 0 ONLY on a SYMBOLIC proof (FullSimplify[f(-1-z)+f(z)] === 0) plus an integer-pole
   certificate (every Gamma argument has integer constant part and unit slope; every denominator root is a
   real integer; the contour and -1/2 both lie in (-1,0)).  Anything else falls through to the original
   closer unchanged.  The sealed caller still gates the returned 0 against the piece quadrature (1e-6),
   so the fail-closed contract is untouched.  Load AFTER MB2MPL_subtraction.m. *)
If[DownValues[MBtoMPL`Private`mbeReflZeroOrig] === {} &&
   DownValues[MBtoMPL`Private`mbeDirectCubeClose] =!= {},
 Module[{},
  MBtoMPL`Private`$mbeReflZeroSaved = DownValues[MBtoMPL`Private`mbeDirectCubeClose];
  DownValues[MBtoMPL`Private`mbeReflZeroOrig] =
    MBtoMPL`Private`$mbeReflZeroSaved /.
      HoldPattern[MBtoMPL`Private`mbeDirectCubeClose] -> MBtoMPL`Private`mbeReflZeroOrig;
  (* symbolic + structural certificate; True/False, never throws *)
  MBtoMPL`Private`mbeReflZeroOddQ[ig_, z_, c0_] := Quiet@Check[Module[
     {gargs, gOK, dens, droots, dOK, cOK, cr, z01, z02, num1, num2, sym},
     (* fast numeric pre-reject at two off-axis points; EXACT test points so 30-digit
        arithmetic sees the cancellation (a machine-precision contour value poisons it) *)
     cr = Rationalize[c0, 10^-9];
     z01 = cr + 3 I/10; z02 = cr - 2 I/5;
     num1 = N[(ig /. z -> z01) + (ig /. z -> -1 - z01), 30];
     num2 = N[(ig /. z -> z02) + (ig /. z -> -1 - z02), 30];
     If[! (NumericQ[num1] && NumericQ[num2] &&
           Abs[num1] < 10^-18 (1 + Abs[N[ig /. z -> z01, 30]]) &&
           Abs[num2] < 10^-18 (1 + Abs[N[ig /. z -> z02, 30]])), Return[False]];
     (* integer-pole certificate *)
     gargs = Cases[ig, Gamma[a_] :> a, {0, Infinity}];
     gOK = AllTrue[gargs, IntegerQ[# /. z -> 0] && MemberQ[{-1, 0, 1}, D[#, z]] &];
     dens = DeleteCases[FactorList[Denominator[Together[ig /. Gamma[_] -> 1]]][[All, 1]], _?NumericQ];
     droots = Flatten[(z /. Quiet[Solve[# == 0, z]]) & /@ dens];
     dOK = AllTrue[droots, IntegerQ];
     cOK = TrueQ[-1 < c0 < 0];
     If[! (gOK && dOK && cOK), Return[False]];
     (* symbolic proof of oddness *)
     sym = Quiet@TimeConstrained[FullSimplify[(ig /. z -> -1 - z) + ig], 60, $Failed];
     sym === 0], False];
  Clear[MBtoMPL`Private`mbeDirectCubeClose];
  MBtoMPL`Private`mbeDirectCubeClose[ig_, ctr_, vrs_, to_] := Module[{z, c0},
    If[Length[vrs] === 1,
     z = First[vrs]; c0 = Quiet@Check[N[ctr[[1, 2]]], $Failed];
     If[NumericQ[c0] && TrueQ[MBtoMPL`Private`mbeReflZeroOddQ[ig, z, c0]],
      WriteString["stdout",
        "    [ReflZero] odd under z->-1-z, integer poles, contour in (-1,0) -> EXACT 0.\n"];
      Return[0, Module]]];
    MBtoMPL`Private`mbeReflZeroOrig[ig, ctr, vrs, to]];
  WriteString["stdout", "[mbeReflZero] sidecar installed (wraps mbeDirectCubeClose; exact-proof-gated).\n"]]];
