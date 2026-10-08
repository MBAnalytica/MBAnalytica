(* ::Package:: *)

HPLBasis2 = {HPL[{-1, -1}, x_] :> Log[1 + x]^2/2, 
    HPL[{-1, 0}, x_] :> Log[x]*Log[1 + x] + PolyLog[2, -x], 
    HPL[{-1, 1}, x_] :> Pi^2/12 - Log[2]^2/2 + Log[2]*Log[1 - x] - 
      Log[1 - x]*Log[1 + x] - PolyLog[2, (1 - x)/2], 
    HPL[{-2}, x_] :> -PolyLog[2, -x], HPL[{0, 0}, x] :> Log[x]^2/2, 
    HPL[{2}, x_] :> PolyLog[2, x], HPL[{1, -1}, x] :> 
     -Pi^2/12 + Log[2]^2/2 - Log[2]*Log[1 - x] + PolyLog[2, (1 - x)/2], 
    HPL[{1, 0}, x_] :> -(Log[1 - x]*Log[x]) - PolyLog[2, x], 
    HPL[{1, 1}, x_] :> Log[1 - x]^2/2}
