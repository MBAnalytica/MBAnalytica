(* ::Package:: *)

HPLBasis3 = {HPL[{-1, -1, -1}, x_] :> Log[1 + x]^3/6, 
    HPL[{-1, -1, 0}, x_] :> -(Pi^2*Log[1 + x])/6 + Log[1 + x]^3/6 - 
      PolyLog[3, (1 + x)^(-1)] + Zeta[3], HPL[{-1, -1, 1}, x_] :> 
     (Pi^2*Log[2])/12 - Log[2]^3/6 - (Pi^2*Log[1 + x])/12 + 
      (Log[2]^2*Log[1 + x])/2 - (Log[2]*Log[1 + x]^2)/2 + 
      PolyLog[3, (1 + x)/2] - (7*Zeta[3])/8, HPL[{-1, -2}, x_] :> 
     (Pi^2*Log[1 + x])/3 + Log[x]*Log[1 + x]^2 - Log[1 + x]^3/3 + 
      Log[1 + x]*PolyLog[2, -x] + 2*PolyLog[3, (1 + x)^(-1)] - 2*Zeta[3], 
    HPL[{-1, 0, 0}, x_] :> (Log[x]^2*Log[1 + x])/2 + Log[x]*PolyLog[2, -x] - 
      PolyLog[3, -x], HPL[{-1, 2}, x_] :> (Pi^2*Log[2])/6 - Log[2]^3/3 - 
      (Pi^2*Log[1 - x])/12 + (Log[2]^2*Log[1 - x])/2 - (Pi^2*Log[1 + x])/12 + 
      (Log[2]^2*Log[1 + x])/2 - Log[2]*Log[1 - x]*Log[1 + x] - 
      Log[1 - x]*Log[x]*Log[1 + x] + (Log[1 - x]*Log[1 + x]^2)/2 - 
      Log[1 - x]*PolyLog[2, -x] + PolyLog[3, (1 - x)/2] - PolyLog[3, 1 - x] - 
      PolyLog[3, (1 + x)^(-1)] + PolyLog[3, (1 - x)/(1 + x)] + 
      PolyLog[3, (1 + x)/2] - (3*Zeta[3])/4, HPL[{-1, 1, -1}, x_] :> 
     -(Pi^2*Log[2])/6 + Log[2]^3/3 + (Pi^2*Log[1 + x])/4 - 
      (3*Log[2]^2*Log[1 + x])/2 + Log[2]*Log[1 - x]*Log[1 + x] + 
      Log[2]*Log[1 + x]^2 - Log[1 - x]*Log[1 + x]^2 - 
      Log[1 + x]*PolyLog[2, (1 - x)/2] - 2*PolyLog[3, (1 + x)/2] + 
      (7*Zeta[3])/4, HPL[{-1, 1, 0}, x_] :> -(Pi^2*Log[2])/12 + Log[2]^3/6 + 
      (Pi^2*Log[1 - x])/6 - (Log[2]*Log[1 - x]^2)/2 + Log[1 - x]^3/6 + 
      (Pi^2*Log[x])/12 - (Log[2]^2*Log[x])/2 + Log[2]*Log[1 - x]*Log[x] - 
      (Log[1 - x]^2*Log[x])/2 + (Pi^2*Log[1 + x])/12 - 
      (Log[2]^2*Log[1 + x])/2 + Log[2]*Log[1 - x]*Log[1 + x] - 
      (Log[1 - x]*Log[1 + x]^2)/2 - Log[x]*PolyLog[2, (1 - x)/2] + 
      PolyLog[3, -x] - PolyLog[3, x] - PolyLog[3, (2*x)/(-1 + x)] + 
      PolyLog[3, (1 + x)^(-1)] - PolyLog[3, (1 - x)/(1 + x)] - 
      PolyLog[3, (1 + x)/2] + (7*Zeta[3])/8, HPL[{-1, 1, 1}, x_] :> 
     -(Pi^2*Log[2])/12 + Log[2]^3/6 - (Log[2]*Log[1 - x]^2)/2 + 
      (Log[1 - x]^2*Log[1 + x])/2 + Log[1 - x]*PolyLog[2, (1 - x)/2] - 
      PolyLog[3, (1 - x)/2] + (7*Zeta[3])/8, HPL[{-2, -1}, x_] :> 
     -(Pi^2*Log[1 + x])/6 - (Log[x]*Log[1 + x]^2)/2 + Log[1 + x]^3/6 - 
      Log[1 + x]*PolyLog[2, -x] - PolyLog[3, (1 + x)^(-1)] + Zeta[3], 
    HPL[{-2, 0}, x_] :> -(Log[x]*PolyLog[2, -x]) + 2*PolyLog[3, -x], 
    HPL[{-2, 1}, x_] :> -(Pi^2*Log[2])/12 + Log[2]^3/6 - 
      (Pi^2*Log[1 - x])/12 - (Log[2]^2*Log[1 - x])/2 + 
      (Log[2]*Log[1 - x]^2)/2 - Log[1 - x]^3/6 + (Log[1 - x]^2*Log[x])/2 + 
      Log[1 - x]*PolyLog[2, -x] - PolyLog[3, (1 - x)/2] + PolyLog[3, 1 - x] - 
      PolyLog[3, -x] + PolyLog[3, x] + PolyLog[3, (2*x)/(-1 + x)] - 
      Zeta[3]/8, HPL[{-3}, x_] :> -PolyLog[3, -x], 
    HPL[{0, 0, 0}, x_] :> Log[x]^3/6, HPL[{3}, x_] :> PolyLog[3, x], 
    HPL[{2, -1}, x_] :> -(Pi^2*Log[2])/12 + Log[2]^3/6 + (Pi^2*Log[1 - x])/6 - 
      (Log[2]*Log[1 - x]^2)/2 + Log[1 - x]^3/6 - (Log[1 - x]^2*Log[x])/2 + 
      (Pi^2*Log[1 + x])/12 - (Log[2]^2*Log[1 + x])/2 + 
      Log[2]*Log[1 - x]*Log[1 + x] + Log[1 - x]*Log[x]*Log[1 + x] - 
      (Log[1 - x]*Log[1 + x]^2)/2 + Log[1 + x]*PolyLog[2, x] + 
      PolyLog[3, -x] - PolyLog[3, x] - PolyLog[3, (2*x)/(-1 + x)] + 
      PolyLog[3, (1 + x)^(-1)] - PolyLog[3, (1 - x)/(1 + x)] - 
      PolyLog[3, (1 + x)/2] + (7*Zeta[3])/8, HPL[{2, 0}, x_] :> 
     Log[x]*PolyLog[2, x] - 2*PolyLog[3, x], HPL[{2, 1}, x_] :> 
     (Pi^2*Log[1 - x])/6 - (Log[1 - x]^2*Log[x])/2 - 
      Log[1 - x]*PolyLog[2, x] - PolyLog[3, 1 - x] + Zeta[3], 
    HPL[{1, -1, -1}, x_] :> (Pi^2*Log[2])/12 - Log[2]^3/6 - 
      (Pi^2*Log[1 + x])/6 + Log[2]^2*Log[1 + x] - Log[2]*Log[1 - x]*
       Log[1 + x] - (Log[2]*Log[1 + x]^2)/2 + (Log[1 - x]*Log[1 + x]^2)/2 + 
      Log[1 + x]*PolyLog[2, (1 - x)/2] + PolyLog[3, (1 + x)/2] - 
      (7*Zeta[3])/8, HPL[{1, -1, 0}, x_] :> -(Pi^2*Log[2])/12 + Log[2]^3/6 - 
      (Pi^2*Log[1 - x])/12 - (Log[2]^2*Log[1 - x])/2 + 
      (Log[2]*Log[1 - x]^2)/2 - Log[1 - x]^3/6 - (Pi^2*Log[x])/12 + 
      (Log[2]^2*Log[x])/2 - Log[2]*Log[1 - x]*Log[x] + 
      (Log[1 - x]^2*Log[x])/2 + Log[x]*PolyLog[2, (1 - x)/2] - 
      PolyLog[3, (1 - x)/2] + PolyLog[3, 1 - x] - PolyLog[3, -x] + 
      PolyLog[3, x] + PolyLog[3, (2*x)/(-1 + x)] - Zeta[3]/8, 
    HPL[{1, -1, 1}, x_] :> (Pi^2*Log[2])/6 - Log[2]^3/3 - 
      (Pi^2*Log[1 - x])/12 + (Log[2]^2*Log[1 - x])/2 - 
      Log[1 - x]*PolyLog[2, (1 - x)/2] + 2*PolyLog[3, (1 - x)/2] - 
      (7*Zeta[3])/4, HPL[{1, -2}, x_] :> (Pi^2*Log[2])/6 - Log[2]^3/3 - 
      (Pi^2*Log[1 - x])/12 + (Log[2]^2*Log[1 - x])/2 - (Pi^2*Log[1 + x])/12 + 
      (Log[2]^2*Log[1 + x])/2 - Log[2]*Log[1 - x]*Log[1 + x] - 
      Log[1 - x]*Log[x]*Log[1 + x] + (Log[1 - x]*Log[1 + x]^2)/2 - 
      Log[1 + x]*PolyLog[2, x] + PolyLog[3, (1 - x)/2] - PolyLog[3, 1 - x] - 
      PolyLog[3, (1 + x)^(-1)] + PolyLog[3, (1 - x)/(1 + x)] + 
      PolyLog[3, (1 + x)/2] - (3*Zeta[3])/4, HPL[{1, 0, 0}, x_] :> 
     -(Log[1 - x]*Log[x]^2)/2 - Log[x]*PolyLog[2, x] + PolyLog[3, x], 
    HPL[{1, 2}, x_] :> -(Pi^2*Log[1 - x])/3 + Log[1 - x]^2*Log[x] + 
      Log[1 - x]*PolyLog[2, x] + 2*PolyLog[3, 1 - x] - 2*Zeta[3], 
    HPL[{1, 1, -1}, x_] :> -(Pi^2*Log[2])/12 + Log[2]^3/6 + 
      (Pi^2*Log[1 - x])/12 - (Log[2]^2*Log[1 - x])/2 + 
      (Log[2]*Log[1 - x]^2)/2 - PolyLog[3, (1 - x)/2] + (7*Zeta[3])/8, 
    HPL[{1, 1, 0}, x_] :> (Pi^2*Log[1 - x])/6 - PolyLog[3, 1 - x] + Zeta[3], 
    HPL[{1, 1, 1}, x_] :> -Log[1 - x]^3/6}
