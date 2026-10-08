(* ::Package:: *)

HPLBasis4 = {HPL[{-1, -1, -1, -1}, x_] :> Log[1 + x]^4/24, 
    HPL[{-1, -1, -1, 0}, x_] :> -Pi^4/90 - (Pi^2*Log[1 + x]^2)/12 + 
      Log[1 + x]^4/24 + PolyLog[4, (1 + x)^(-1)] + Log[1 + x]*Zeta[3], 
    HPL[{-1, -1, -1, 1}, x_] :> (Pi^2*Log[2]*Log[1 + x])/12 - 
      (Log[2]^3*Log[1 + x])/6 - (Pi^2*Log[1 + x]^2)/24 + 
      (Log[2]^2*Log[1 + x]^2)/4 - (Log[2]*Log[1 + x]^3)/6 - PolyLog[4, 1/2] + 
      PolyLog[4, (1 + x)/2] - (7*Log[1 + x]*Zeta[3])/8, 
    HPL[{-1, -1, -2}, x_] :> Pi^4/30 + (Pi^2*Log[1 + x]^2)/12 + 
      Log[1 + x]^4/24 - Log[1 + x]*PolyLog[3, (1 + x)^(-1)] - 
      3*PolyLog[4, (1 + x)^(-1)] - 2*Log[1 + x]*Zeta[3], 
    HPL[{-1, -1, 0, 0}, x_] :> Pi^4/90 - (Pi^2*Log[x]*Log[1 + x])/6 + 
      (Pi^2*Log[1 + x]^2)/12 - (Log[x]^2*Log[1 + x]^2)/4 + 
      (Log[x]*Log[1 + x]^3)/3 - Log[1 + x]^4/12 - 
      Log[x]*PolyLog[3, (1 + x)^(-1)] - PolyLog[4, -x] - 
      PolyLog[4, (1 + x)^(-1)] - PolyLog[4, x/(1 + x)] + Log[x]*Zeta[3] - 
      Log[1 + x]*Zeta[3], HPL[{-1, -1, 2}, x_] :> 
     Pi^4/480 + (Pi^2*Log[1 - x]*Log[1 + x])/12 + (Pi^2*Log[1 + x]^2)/12 - 
      (Log[1 - x]*Log[1 + x]^3)/6 + Log[1 - x]*PolyLog[3, (1 + x)^(-1)] + 
      PolyLog[4, 1 - x] - PolyLog[4, (1 - x)/(1 + x)]/2 + 
      PolyLog[4, (-1 + x)/(1 + x)]/2 - PolyLog[4, 1 - x^2]/4 - 
      (7*Log[1 - x]*Zeta[3])/8 - (5*Log[1 + x]*Zeta[3])/8, 
    HPL[{-1, -1, 1, -1}, x_] :> -(Pi^2*Log[2]*Log[1 + x])/6 + 
      (Log[2]^3*Log[1 + x])/3 + (Pi^2*Log[1 + x]^2)/24 - 
      (Log[2]^2*Log[1 + x]^2)/4 + Log[1 + x]*PolyLog[3, (1 + x)/2] + 
      3*PolyLog[4, 1/2] - 3*PolyLog[4, (1 + x)/2] + (7*Log[1 + x]*Zeta[3])/4, 
    HPL[{-1, -1, 1, 0}, x_] :> Pi^4/90 + (Pi^2*Log[2]*Log[x])/12 - 
      (Log[2]^3*Log[x])/6 - (Pi^2*Log[2]*Log[1 + x])/4 + 
      (Log[2]^3*Log[1 + x])/2 - (Pi^2*Log[x]*Log[1 + x])/12 + 
      (Log[2]^2*Log[x]*Log[1 + x])/2 + (5*Pi^2*Log[1 + x]^2)/24 - 
      (3*Log[2]^2*Log[1 + x]^2)/4 - (Log[2]*Log[x]*Log[1 + x]^2)/2 + 
      (Log[2]*Log[1 + x]^3)/2 + (Log[x]*Log[1 + x]^3)/6 - Log[1 + x]^4/6 + 
      Log[x]*PolyLog[3, (1 + x)/2] + 3*PolyLog[4, 1/2] + PolyLog[4, -x]/2 - 
      PolyLog[4, x]/2 - PolyLog[4, (4*x)/(1 + x)^2]/4 - 
      PolyLog[4, (1 + x)^(-1)] + PolyLog[4, (2*x)/(1 + x)] - 
      3*PolyLog[4, (1 + x)/2] - (7*Log[x]*Zeta[3])/8 + 
      (13*Log[1 + x]*Zeta[3])/8, HPL[{-1, -1, 1, 1}, x_] :> 
     (-7*Pi^4)/720 - (Pi^2*Log[2]*Log[1 - x])/6 + (Log[2]^3*Log[1 - x])/3 - 
      (Log[2]^2*Log[1 - x]^2)/4 + (Pi^2*Log[2]*Log[1 + x])/12 - 
      (Log[2]^3*Log[1 + x])/6 + (Pi^2*Log[1 - x]*Log[1 + x])/6 - 
      (Log[2]^2*Log[1 - x]*Log[1 + x])/2 + (Log[2]*Log[1 - x]^2*Log[1 + x])/
       2 - (Pi^2*Log[1 + x]^2)/12 + (Log[2]^2*Log[1 + x]^2)/4 - 
      (Log[1 - x]^2*Log[1 + x]^2)/4 + (Log[1 - x]*Log[1 + x]^3)/6 - 
      Log[1 + x]^4/24 - Log[1 - x]*PolyLog[3, (1 + x)/2] - 
      PolyLog[4, (1 - x)/2] - PolyLog[4, (-1 + x)/(1 + x)] + 
      PolyLog[4, (1 + x)/2] + Log[1 - x]*Zeta[3] - (Log[1 + x]*Zeta[3])/8, 
    HPL[{-1, -2, -1}, x_] :> -Pi^4/30 + (Pi^2*Log[1 + x]^2)/12 + 
      (Log[x]*Log[1 + x]^3)/2 - (5*Log[1 + x]^4)/24 + 
      (Log[1 + x]^2*PolyLog[2, -x])/2 + 2*Log[1 + x]*
       PolyLog[3, (1 + x)^(-1)] + 3*PolyLog[4, (1 + x)^(-1)] + 
      Log[1 + x]*Zeta[3], HPL[{-1, -2, 0}, x_] :> 
     -Pi^4/45 + (Pi^2*Log[x]*Log[1 + x])/3 - (Pi^2*Log[1 + x]^2)/6 + 
      Log[x]^2*Log[1 + x]^2 - (2*Log[x]*Log[1 + x]^3)/3 + Log[1 + x]^4/6 + 
      Log[x]*Log[1 + x]*PolyLog[2, -x] + PolyLog[2, -x]^2/2 + 
      2*Log[x]*PolyLog[3, (1 + x)^(-1)] + 2*PolyLog[4, -x] + 
      2*PolyLog[4, (1 + x)^(-1)] + 2*PolyLog[4, x/(1 + x)] - 
      2*Log[x]*Zeta[3] + 2*Log[1 + x]*Zeta[3], HPL[{-1, -2, 1}, x_] :> 
     (-11*Pi^4)/720 - Li[{2, 2}, {-1, x}] - Li[{2, 2}, 
       {1/2, (2*x)/(1 + x)}] - (Pi^2*Log[1 - x]*Log[1 + x])/2 + 
      Log[2]*Log[1 - x]^2*Log[1 + x] - (Log[1 - x]^3*Log[1 + x])/3 + 
      Log[1 - x]^2*Log[x]*Log[1 + x] + (Pi^2*Log[1 + x]^2)/8 - 
      (Log[2]^2*Log[1 + x]^2)/4 - (3*Log[2]*Log[1 - x]*Log[1 + x]^2)/2 - 
      2*Log[1 - x]*Log[x]*Log[1 + x]^2 + Log[2]*Log[1 + x]^3 + 
      (5*Log[1 - x]*Log[1 + x]^3)/6 + (5*Log[x]*Log[1 + x]^3)/6 - 
      (11*Log[1 + x]^4)/24 - (Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 + 
      (Pi^2*PolyLog[2, -x])/12 - (Log[2]^2*PolyLog[2, -x])/2 + 
      Log[2]*Log[1 - x]*PolyLog[2, -x] - Log[1 - x]*Log[1 + x]*
       PolyLog[2, -x] + (Log[1 + x]^2*PolyLog[2, -x])/2 - 
      PolyLog[2, (1 - x)/2]*PolyLog[2, -x] + PolyLog[2, -x]^2/2 - 
      (Log[1 + x]^2*PolyLog[2, x])/2 + 2*Log[1 + x]*PolyLog[3, x] + 
      2*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] - 
      2*Log[1 - x]*PolyLog[3, (1 + x)^(-1)] + 2*Log[1 + x]*
       PolyLog[3, (1 - x)/(1 + x)] - 2*PolyLog[4, 1 - x] - 
      (3*PolyLog[4, -x])/2 - PolyLog[4, x]/2 - PolyLog[4, (4*x)/(1 + x)^2]/
       4 + PolyLog[4, (1 + x)^(-1)] + PolyLog[4, (1 - x)/(1 + x)] - 
      PolyLog[4, (-1 + x)/(1 + x)] - 2*PolyLog[4, x/(1 + x)] + 
      PolyLog[4, (2*x)/(1 + x)] + PolyLog[4, 1 - x^2]/2 + 
      (7*Log[1 - x]*Zeta[3])/4 + (Log[1 + x]*Zeta[3])/4, 
    HPL[{-1, -3}, x_] :> -PolyLog[2, -x]^2/2 - Log[1 + x]*PolyLog[3, -x], 
    HPL[{-1, 0, 0, 0}, x_] :> (Log[x]^3*Log[1 + x])/6 + 
      (Log[x]^2*PolyLog[2, -x])/2 - Log[x]*PolyLog[3, -x] + PolyLog[4, -x], 
    HPL[{-1, 3}, x_] :> -Pi^4/360 - Li[{2, 2}, {-1, x}] + 
      (Pi^2*Log[1 - x]^2)/16 + Log[1 - x]^4/32 - (Log[1 - x]^3*Log[x])/12 - 
      (Pi^2*Log[1 - x]*Log[1 + x])/24 - (Log[1 - x]^3*Log[1 + x])/24 + 
      (Log[1 - x]^2*Log[x]*Log[1 + x])/4 - (5*Pi^2*Log[1 + x]^2)/48 - 
      (Log[1 - x]^2*Log[1 + x]^2)/16 + (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 - 
      (Log[1 - x]*Log[1 + x]^3)/24 - (Log[x]*Log[1 + x]^3)/12 + 
      (7*Log[1 + x]^4)/96 + PolyLog[2, -x]*PolyLog[2, x] + 
      Log[1 - x]*PolyLog[3, -x] + 2*Log[1 + x]*PolyLog[3, x] - 
      PolyLog[4, 1 - x] - PolyLog[4, -x] - PolyLog[4, x] + 
      PolyLog[4, x/(-1 + x)] + PolyLog[4, (1 + x)^(-1)] + 
      PolyLog[4, x/(1 + x)] + PolyLog[4, 1 - x^2]/4 - 
      PolyLog[4, x^2/(-1 + x^2)]/4 + (3*Log[1 - x]*Zeta[3])/4 + 
      (3*Log[1 + x]*Zeta[3])/4, HPL[{-1, 2, -1}, x_] :> 
     Pi^4/90 + Li[{2, 2}, {-1, x}] + Li[{2, 2}, {1/2, (2*x)/(1 + x)}] + 
      (Pi^2*Log[2]*Log[1 + x])/6 - (Log[2]^3*Log[1 + x])/3 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/4 + (Log[2]^2*Log[1 - x]*Log[1 + x])/2 - 
      Log[2]*Log[1 - x]^2*Log[1 + x] + (Log[1 - x]^3*Log[1 + x])/3 - 
      Log[1 - x]^2*Log[x]*Log[1 + x] - (3*Pi^2*Log[1 + x]^2)/8 + 
      (3*Log[2]^2*Log[1 + x]^2)/4 + (Log[2]*Log[1 - x]*Log[1 + x]^2)/2 + 
      Log[1 - x]*Log[x]*Log[1 + x]^2 - Log[2]*Log[1 + x]^3 - 
      (5*Log[x]*Log[1 + x]^3)/6 + (11*Log[1 + x]^4)/24 + 
      (Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - (Pi^2*PolyLog[2, -x])/12 + 
      (Log[2]^2*PolyLog[2, -x])/2 - Log[2]*Log[1 - x]*PolyLog[2, -x] - 
      (Log[1 + x]^2*PolyLog[2, -x])/2 + PolyLog[2, (1 - x)/2]*
       PolyLog[2, -x] - PolyLog[2, -x]^2/2 + (Log[1 + x]^2*PolyLog[2, x])/2 + 
      Log[1 + x]*PolyLog[3, (1 - x)/2] - Log[1 + x]*PolyLog[3, 1 - x] - 
      2*Log[1 + x]*PolyLog[3, x] - 2*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] - 
      Log[1 + x]*PolyLog[3, (1 + x)^(-1)] - Log[1 + x]*
       PolyLog[3, (1 - x)/(1 + x)] + Log[1 + x]*PolyLog[3, (1 + x)/2] + 
      (3*PolyLog[4, -x])/2 + PolyLog[4, x]/2 + PolyLog[4, (4*x)/(1 + x)^2]/
       4 - PolyLog[4, (1 + x)^(-1)] + 2*PolyLog[4, x/(1 + x)] - 
      PolyLog[4, (2*x)/(1 + x)] + (Log[1 + x]*Zeta[3])/4, 
    HPL[{-1, 2, 0}, x_] :> Li[{2, 2}, {-1, x}] + (Pi^2*Log[2]*Log[x])/6 - 
      (Log[2]^3*Log[x])/3 - (Pi^2*Log[1 - x]*Log[x])/12 + 
      (Log[2]^2*Log[1 - x]*Log[x])/2 - (Pi^2*Log[x]*Log[1 + x])/12 + 
      (Log[2]^2*Log[x]*Log[1 + x])/2 - Log[2]*Log[1 - x]*Log[x]*Log[1 + x] - 
      Log[1 - x]*Log[x]^2*Log[1 + x] + (Log[1 - x]*Log[x]*Log[1 + x]^2)/2 - 
      Log[1 - x]*Log[x]*PolyLog[2, -x] - PolyLog[2, -x]*PolyLog[2, x] + 
      Log[x]*PolyLog[3, (1 - x)/2] - Log[x]*PolyLog[3, 1 - x] - 
      2*Log[1 + x]*PolyLog[3, x] - Log[x]*PolyLog[3, (1 + x)^(-1)] + 
      Log[x]*PolyLog[3, (1 - x)/(1 + x)] + Log[x]*PolyLog[3, (1 + x)/2] - 
      (3*Log[x]*Zeta[3])/4, HPL[{-1, 2, 1}, x_] :> 
     Pi^4/288 - (Pi^2*Log[2]*Log[1 - x])/6 + (Log[2]^3*Log[1 - x])/3 + 
      (Pi^2*Log[1 - x]^2)/24 - (Log[2]^2*Log[1 - x]^2)/2 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/4 - (Log[2]^2*Log[1 - x]*Log[1 + x])/2 + 
      Log[2]*Log[1 - x]^2*Log[1 + x] + (Log[1 - x]^2*Log[x]*Log[1 + x])/2 + 
      (Pi^2*Log[1 + x]^2)/24 - (Log[1 - x]^2*Log[1 + x]^2)/2 - 
      Log[1 + x]^4/24 + (Log[1 - x]^2*PolyLog[2, -x])/2 - 
      Log[1 - x]*PolyLog[3, (1 - x)/2] + Log[1 - x]*PolyLog[3, 1 - x] + 
      Log[1 - x]*PolyLog[3, (1 + x)^(-1)] - Log[1 - x]*
       PolyLog[3, (1 - x)/(1 + x)] - Log[1 - x]*PolyLog[3, (1 + x)/2] - 
      PolyLog[4, (1 + x)^(-1)] + PolyLog[4, (1 - x)/(1 + x)]/2 - 
      PolyLog[4, (-1 + x)/(1 + x)]/2 - PolyLog[4, 1 - x^2]/4 + 
      (Log[1 - x]*Zeta[3])/8 + (Log[1 + x]*Zeta[3])/8, 
    HPL[{-1, 1, -1, -1}, x_] :> (Pi^2*Log[2]*Log[1 + x])/12 - 
      (Log[2]^3*Log[1 + x])/6 + (Pi^2*Log[1 + x]^2)/12 - 
      (Log[2]^2*Log[1 + x]^2)/2 + (Log[2]*Log[1 - x]*Log[1 + x]^2)/2 + 
      (Log[2]*Log[1 + x]^3)/2 - (Log[1 - x]*Log[1 + x]^3)/2 - 
      (Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - 2*Log[1 + x]*
       PolyLog[3, (1 + x)/2] - 3*PolyLog[4, 1/2] + 3*PolyLog[4, (1 + x)/2] - 
      (7*Log[1 + x]*Zeta[3])/8, HPL[{-1, 1, -1, 0}, x_] :> 
     -Pi^4/90 + Li[{2, 2}, {-1, x}] + Li[{2, 2}, {1/2, (2*x)/(1 + x)}] - 
      (Pi^2*Log[2]*Log[x])/6 + (Log[2]^3*Log[x])/3 + (Pi^2*Log[2]*Log[1 + x])/
       2 - Log[2]^3*Log[1 + x] + (Pi^2*Log[1 - x]*Log[1 + x])/3 - 
      Log[2]*Log[1 - x]^2*Log[1 + x] + (Log[1 - x]^3*Log[1 + x])/3 + 
      (Pi^2*Log[x]*Log[1 + x])/4 - (3*Log[2]^2*Log[x]*Log[1 + x])/2 + 
      Log[2]*Log[1 - x]*Log[x]*Log[1 + x] - Log[1 - x]^2*Log[x]*Log[1 + x] - 
      (17*Pi^2*Log[1 + x]^2)/24 + (7*Log[2]^2*Log[1 + x]^2)/4 + 
      (3*Log[2]*Log[1 - x]*Log[1 + x]^2)/2 + Log[2]*Log[x]*Log[1 + x]^2 + 
      Log[1 - x]*Log[x]*Log[1 + x]^2 - 2*Log[2]*Log[1 + x]^3 - 
      (Log[1 - x]*Log[1 + x]^3)/2 - (7*Log[x]*Log[1 + x]^3)/6 + 
      (19*Log[1 + x]^4)/24 - Log[x]*Log[1 + x]*PolyLog[2, (1 - x)/2] + 
      (Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - (Log[1 + x]^2*PolyLog[2, -x])/
       2 - PolyLog[2, -x]^2/2 + (Log[1 + x]^2*PolyLog[2, x])/2 - 
      2*Log[1 + x]*PolyLog[3, x] - 2*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] - 
      2*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)] - 
      2*Log[x]*PolyLog[3, (1 + x)/2] - 6*PolyLog[4, 1/2] + PolyLog[4, -x]/2 + 
      (3*PolyLog[4, x])/2 + (3*PolyLog[4, (4*x)/(1 + x)^2])/4 + 
      PolyLog[4, (1 + x)^(-1)] + 2*PolyLog[4, x/(1 + x)] - 
      3*PolyLog[4, (2*x)/(1 + x)] + 6*PolyLog[4, (1 + x)/2] + 
      (7*Log[x]*Zeta[3])/4 - (9*Log[1 + x]*Zeta[3])/4, 
    HPL[{-1, 1, -1, 1}, x_] :> (11*Pi^4)/480 - (Pi^2*Log[2]^2)/24 + 
      Log[2]^4/8 + (5*Pi^2*Log[2]*Log[1 - x])/12 - (7*Log[2]^3*Log[1 - x])/
       6 + Log[2]^2*Log[1 - x]^2 - (Pi^2*Log[2]*Log[1 + x])/6 + 
      (Log[2]^3*Log[1 + x])/3 - (5*Pi^2*Log[1 - x]*Log[1 + x])/12 + 
      (3*Log[2]^2*Log[1 - x]*Log[1 + x])/2 - 2*Log[2]*Log[1 - x]^2*
       Log[1 + x] + (Pi^2*Log[1 + x]^2)/6 - (Log[2]^2*Log[1 + x]^2)/2 + 
      Log[1 - x]^2*Log[1 + x]^2 - (Log[1 - x]*Log[1 + x]^3)/3 + 
      Log[1 + x]^4/12 - (Pi^2*PolyLog[2, (1 - x)/2])/12 + 
      (Log[2]^2*PolyLog[2, (1 - x)/2])/2 - Log[2]*Log[1 - x]*
       PolyLog[2, (1 - x)/2] + Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2] + 
      PolyLog[2, (1 - x)/2]^2/2 + 2*Log[1 - x]*PolyLog[3, (1 + x)/2] + 
      2*PolyLog[4, (1 - x)/2] + 2*PolyLog[4, (-1 + x)/(1 + x)] - 
      2*PolyLog[4, (1 + x)/2] - 2*Log[1 - x]*Zeta[3] + 
      (Log[1 + x]*Zeta[3])/4, HPL[{-1, 1, -2}, x_] :> 
     -Pi^4/90 - Li[{2, 2}, {-1, x}] - Li[{2, 2}, {1/2, (2*x)/(1 + x)}] - 
      (Pi^2*Log[2]*Log[1 + x])/12 + (Log[2]^3*Log[1 + x])/6 - 
      (Pi^2*Log[1 - x]*Log[1 + x])/6 + (Log[2]*Log[1 - x]^2*Log[1 + x])/2 - 
      (Log[1 - x]^3*Log[1 + x])/6 + (Log[1 - x]^2*Log[x]*Log[1 + x])/2 + 
      (3*Pi^2*Log[1 + x]^2)/8 - (3*Log[2]^2*Log[1 + x]^2)/4 - 
      (Log[2]*Log[1 - x]*Log[1 + x]^2)/2 - Log[1 - x]*Log[x]*Log[1 + x]^2 + 
      Log[2]*Log[1 + x]^3 + (5*Log[x]*Log[1 + x]^3)/6 - 
      (11*Log[1 + x]^4)/24 - (Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 + 
      (Log[1 + x]^2*PolyLog[2, -x])/2 + PolyLog[2, -x]^2/2 - 
      (Log[1 + x]^2*PolyLog[2, x])/2 + Log[1 + x]*PolyLog[3, -x] + 
      Log[1 + x]*PolyLog[3, x] + Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] + 
      Log[1 + x]*PolyLog[3, (1 + x)^(-1)] + Log[1 + x]*
       PolyLog[3, (1 - x)/(1 + x)] - Log[1 + x]*PolyLog[3, (1 + x)/2] - 
      (3*PolyLog[4, -x])/2 - PolyLog[4, x]/2 - PolyLog[4, (4*x)/(1 + x)^2]/
       4 + PolyLog[4, (1 + x)^(-1)] - 2*PolyLog[4, x/(1 + x)] + 
      PolyLog[4, (2*x)/(1 + x)] - (Log[1 + x]*Zeta[3])/8, 
    HPL[{-1, 1, 0, 0}, x_] :> -Pi^4/90 - (Pi^2*Log[2]*Log[x])/12 + 
      (Log[2]^3*Log[x])/6 + (Pi^2*Log[1 - x]*Log[x])/6 - 
      (Log[2]*Log[1 - x]^2*Log[x])/2 + (Log[1 - x]^3*Log[x])/6 + 
      (Pi^2*Log[x]^2)/24 - (Log[2]^2*Log[x]^2)/4 + 
      (Log[2]*Log[1 - x]*Log[x]^2)/2 - (Log[1 - x]^2*Log[x]^2)/2 + 
      (Pi^2*Log[2]*Log[1 + x])/6 - (Log[2]^3*Log[1 + x])/3 + 
      (Pi^2*Log[x]*Log[1 + x])/12 - (Log[2]^2*Log[x]*Log[1 + x])/2 + 
      Log[2]*Log[1 - x]*Log[x]*Log[1 + x] + (Log[1 - x]*Log[x]^2*Log[1 + x])/
       2 - (Pi^2*Log[1 + x]^2)/6 + (Log[2]^2*Log[1 + x]^2)/2 - 
      (Log[1 - x]*Log[x]*Log[1 + x]^2)/2 - (Log[2]*Log[1 + x]^3)/3 - 
      (Log[x]*Log[1 + x]^3)/6 + Log[1 + x]^4/6 - 
      (Log[x]^2*PolyLog[2, (1 - x)/2])/2 + Log[x]*PolyLog[3, -x] - 
      Log[x]*PolyLog[3, x] - Log[x]*PolyLog[3, (2*x)/(-1 + x)] + 
      Log[x]*PolyLog[3, (1 + x)^(-1)] - Log[x]*PolyLog[3, (1 - x)/(1 + x)] - 
      Log[x]*PolyLog[3, (1 + x)/2] - 2*PolyLog[4, 1/2] - PolyLog[4, -x]/2 + 
      (3*PolyLog[4, x])/2 + PolyLog[4, (4*x)/(1 + x)^2]/4 + 
      PolyLog[4, (1 + x)^(-1)] + PolyLog[4, x/(1 + x)] - 
      2*PolyLog[4, (2*x)/(1 + x)] + 2*PolyLog[4, (1 + x)/2] + 
      (7*Log[x]*Zeta[3])/8 - (3*Log[1 + x]*Zeta[3])/4, 
    HPL[{-1, 1, 2}, x_] :> Pi^4/144 + Li[{2, 2}, {-1, x}] - 
      Li[{2, 2}, {1/2, (2*x)/(-1 + x)}] + (Pi^2*Log[2]*Log[1 - x])/4 - 
      (Log[2]^3*Log[1 - x])/2 - (5*Pi^2*Log[1 - x]^2)/48 + 
      (3*Log[2]^2*Log[1 - x]^2)/4 - (Log[2]*Log[1 - x]^3)/3 + 
      (3*Log[1 - x]^4)/32 + (Log[1 - x]^3*Log[x])/4 + 
      (Pi^2*Log[2]*Log[1 + x])/6 - (Log[2]^3*Log[1 + x])/3 - 
      (3*Pi^2*Log[1 - x]*Log[1 + x])/8 + (Log[2]^2*Log[1 - x]*Log[1 + x])/2 - 
      Log[2]*Log[1 - x]^2*Log[1 + x] + (Log[1 - x]^3*Log[1 + x])/24 - 
      (Log[1 - x]^2*Log[x]*Log[1 + x])/4 - (7*Pi^2*Log[1 + x]^2)/48 + 
      (Log[2]^2*Log[1 + x]^2)/2 + (9*Log[1 - x]^2*Log[1 + x]^2)/16 - 
      (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 - (Log[2]*Log[1 + x]^3)/3 + 
      (Log[1 - x]*Log[1 + x]^3)/24 - (Log[x]*Log[1 + x]^3)/12 + 
      (17*Log[1 + x]^4)/96 + (Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 - 
      (Log[1 - x]^2*PolyLog[2, -x])/2 + (Log[1 - x]^2*PolyLog[2, x])/2 - 
      PolyLog[2, -x]*PolyLog[2, x] + PolyLog[2, x]^2/2 - 
      Log[1 - x]*PolyLog[3, -x] + Log[1 - x]*PolyLog[3, x] - 
      2*Log[1 + x]*PolyLog[3, x] - Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)] - 
      Log[1 - x]*PolyLog[3, (1 + x)^(-1)] + Log[1 - x]*
       PolyLog[3, (1 - x)/(1 + x)] + Log[1 - x]*PolyLog[3, (1 + x)/2] - 
      4*PolyLog[4, 1/2] + 2*PolyLog[4, (1 - x)/2] - PolyLog[4, 1 - x] + 
      (3*PolyLog[4, -x])/2 + PolyLog[4, x]/2 - 2*PolyLog[4, x/(-1 + x)] - 
      PolyLog[4, (2*x)/(-1 + x)] + PolyLog[4, (4*x)/(1 + x)^2]/4 + 
      2*PolyLog[4, (1 + x)^(-1)] - PolyLog[4, (1 - x)/(1 + x)] + 
      PolyLog[4, (-1 + x)/(1 + x)] - 2*PolyLog[4, (2*x)/(1 + x)] + 
      2*PolyLog[4, (1 + x)/2] + PolyLog[4, 1 - x^2]/4 + 
      PolyLog[4, x^2/(-1 + x^2)]/4 - (Log[1 - x]*Zeta[3])/8 - 
      (7*Log[1 + x]*Zeta[3])/4, HPL[{-1, 1, 1, -1}, x_] :> 
     -Pi^4/288 + (Pi^2*Log[2]^2)/24 - Log[2]^4/8 - (Pi^2*Log[2]*Log[1 - x])/
       12 + (Log[2]^3*Log[1 - x])/2 - (Log[2]^2*Log[1 - x]^2)/2 - 
      (Pi^2*Log[2]*Log[1 + x])/12 + (Log[2]^3*Log[1 + x])/6 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/12 - (Log[2]^2*Log[1 - x]*Log[1 + x])/2 + 
      (Log[2]*Log[1 - x]^2*Log[1 + x])/2 + (Pi^2*PolyLog[2, (1 - x)/2])/12 - 
      (Log[2]^2*PolyLog[2, (1 - x)/2])/2 + Log[2]*Log[1 - x]*
       PolyLog[2, (1 - x)/2] - PolyLog[2, (1 - x)/2]^2/2 - 
      Log[1 + x]*PolyLog[3, (1 - x)/2] + (7*Log[1 + x]*Zeta[3])/8, 
    HPL[{-1, 1, 1, 0}, x_] :> Pi^4/288 - Li[{2, 2}, {-1, x}] + 
      Li[{2, 2}, {1/2, (2*x)/(-1 + x)}] - (Pi^2*Log[2]*Log[1 - x])/12 + 
      (Log[2]^3*Log[1 - x])/6 - (Pi^2*Log[1 - x]^2)/8 - 
      (Log[2]^2*Log[1 - x]^2)/2 + (2*Log[2]*Log[1 - x]^3)/3 - 
      (7*Log[1 - x]^4)/24 - (Pi^2*Log[2]*Log[x])/12 + (Log[2]^3*Log[x])/6 - 
      (Log[2]*Log[1 - x]^2*Log[x])/2 + (Log[1 - x]^3*Log[x])/3 - 
      (Pi^2*Log[2]*Log[1 + x])/3 + (2*Log[2]^3*Log[1 + x])/3 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/6 + (3*Pi^2*Log[1 + x]^2)/8 - 
      Log[2]^2*Log[1 + x]^2 + (2*Log[2]*Log[1 + x]^3)/3 + 
      (Log[x]*Log[1 + x]^3)/3 - (3*Log[1 + x]^4)/8 - 
      (Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 + Log[1 - x]*Log[x]*
       PolyLog[2, (1 - x)/2] + (Log[1 - x]^2*PolyLog[2, -x])/2 - 
      (Log[1 - x]^2*PolyLog[2, x])/2 + PolyLog[2, -x]*PolyLog[2, x] - 
      PolyLog[2, x]^2/2 - Log[x]*PolyLog[3, (1 - x)/2] + 
      2*Log[1 + x]*PolyLog[3, x] + 2*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)] + 
      5*PolyLog[4, 1/2] - PolyLog[4, (1 - x)/2] + 2*PolyLog[4, 1 - x] - 
      PolyLog[4, -x] - PolyLog[4, x] + 2*PolyLog[4, (2*x)/(-1 + x)] - 
      PolyLog[4, (4*x)/(1 + x)^2]/2 - 3*PolyLog[4, (1 + x)^(-1)] + 
      PolyLog[4, (1 - x)/(1 + x)]/2 - PolyLog[4, (-1 + x)/(1 + x)]/2 - 
      2*PolyLog[4, x/(1 + x)] + 4*PolyLog[4, (2*x)/(1 + x)] - 
      4*PolyLog[4, (1 + x)/2] - PolyLog[4, 1 - x^2]/4 - 
      (7*Log[1 - x]*Zeta[3])/4 + (7*Log[x]*Zeta[3])/8 + 
      (13*Log[1 + x]*Zeta[3])/8, HPL[{-1, 1, 1, 1}, x_] :> 
     (Log[2]*Log[1 - x]^3)/6 - (Log[1 - x]^3*Log[1 + x])/6 - 
      (Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 + 
      Log[1 - x]*PolyLog[3, (1 - x)/2] + PolyLog[4, 1/2] - 
      PolyLog[4, (1 - x)/2], HPL[{-2, -1, -1}, x_] :> 
     Pi^4/90 - (Pi^2*Log[1 + x]^2)/12 - (Log[x]*Log[1 + x]^3)/3 + 
      Log[1 + x]^4/8 - (Log[1 + x]^2*PolyLog[2, -x])/2 - 
      Log[1 + x]*PolyLog[3, (1 + x)^(-1)] - PolyLog[4, (1 + x)^(-1)], 
    HPL[{-2, -1, 0}, x_] :> -(Pi^2*Log[x]*Log[1 + x])/6 - 
      (Log[x]^2*Log[1 + x]^2)/2 + (Log[x]*Log[1 + x]^3)/6 - 
      Log[x]*Log[1 + x]*PolyLog[2, -x] - PolyLog[2, -x]^2/2 - 
      Log[x]*PolyLog[3, (1 + x)^(-1)] + Log[x]*Zeta[3], 
    HPL[{-2, -1, 1}, x_] :> Pi^4/480 + Li[{2, 2}, {-1, x}] + 
      Li[{2, 2}, {1/2, (2*x)/(1 + x)}] + (Pi^2*Log[2]*Log[1 + x])/4 - 
      (Log[2]^3*Log[1 + x])/2 + (5*Pi^2*Log[1 - x]*Log[1 + x])/12 - 
      Log[2]*Log[1 - x]^2*Log[1 + x] + (Log[1 - x]^3*Log[1 + x])/3 - 
      Log[1 - x]^2*Log[x]*Log[1 + x] - (5*Pi^2*Log[1 + x]^2)/12 + 
      Log[2]^2*Log[1 + x]^2 + (3*Log[2]*Log[1 - x]*Log[1 + x]^2)/2 + 
      2*Log[1 - x]*Log[x]*Log[1 + x]^2 - (3*Log[2]*Log[1 + x]^3)/2 - 
      (2*Log[1 - x]*Log[1 + x]^3)/3 - Log[x]*Log[1 + x]^3 + 
      (5*Log[1 + x]^4)/8 + (Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - 
      (Pi^2*PolyLog[2, -x])/12 + (Log[2]^2*PolyLog[2, -x])/2 - 
      Log[2]*Log[1 - x]*PolyLog[2, -x] + Log[1 - x]*Log[1 + x]*
       PolyLog[2, -x] - (Log[1 + x]^2*PolyLog[2, -x])/2 + 
      PolyLog[2, (1 - x)/2]*PolyLog[2, -x] - PolyLog[2, -x]^2/2 + 
      (Log[1 + x]^2*PolyLog[2, x])/2 - 2*Log[1 + x]*PolyLog[3, x] - 
      2*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] + 
      Log[1 - x]*PolyLog[3, (1 + x)^(-1)] - 2*Log[1 + x]*
       PolyLog[3, (1 - x)/(1 + x)] - 3*PolyLog[4, 1/2] + PolyLog[4, 1 - x] + 
      PolyLog[4, -x] + PolyLog[4, x] + PolyLog[4, (4*x)/(1 + x)^2]/2 - 
      PolyLog[4, (1 - x)/(1 + x)]/2 + PolyLog[4, (-1 + x)/(1 + x)]/2 + 
      2*PolyLog[4, x/(1 + x)] - 2*PolyLog[4, (2*x)/(1 + x)] + 
      3*PolyLog[4, (1 + x)/2] - PolyLog[4, 1 - x^2]/4 - 
      (7*Log[1 - x]*Zeta[3])/8 - (5*Log[1 + x]*Zeta[3])/4, 
    HPL[{-2, -2}, x_] :> Pi^4/45 + (Pi^2*Log[1 + x]^2)/6 + 
      (Log[x]*Log[1 + x]^3)/3 - Log[1 + x]^4/6 + PolyLog[2, -x]^2/2 + 
      2*Log[1 + x]*PolyLog[3, -x] - 2*PolyLog[4, -x] - 
      2*PolyLog[4, (1 + x)^(-1)] - 2*PolyLog[4, x/(1 + x)] - 
      2*Log[1 + x]*Zeta[3], HPL[{-2, 0, 0}, x_] :> 
     -(Log[x]^2*PolyLog[2, -x])/2 + 2*Log[x]*PolyLog[3, -x] - 
      3*PolyLog[4, -x], HPL[{-2, 2}, x_] :> Pi^4/180 + Li[{2, 2}, {-1, x}] - 
      (Pi^2*Log[1 - x]^2)/8 - Log[1 - x]^4/16 + (Log[1 - x]^3*Log[x])/6 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/12 + (Log[1 - x]^3*Log[1 + x])/12 - 
      (Log[1 - x]^2*Log[x]*Log[1 + x])/2 + (5*Pi^2*Log[1 + x]^2)/24 + 
      (Log[1 - x]^2*Log[1 + x]^2)/8 - (Log[1 - x]*Log[x]*Log[1 + x]^2)/2 + 
      (Log[1 - x]*Log[1 + x]^3)/12 + (Log[x]*Log[1 + x]^3)/6 - 
      (7*Log[1 + x]^4)/48 - PolyLog[2, -x]*PolyLog[2, x] - 
      2*Log[1 - x]*PolyLog[3, -x] - 2*Log[1 + x]*PolyLog[3, x] + 
      2*PolyLog[4, 1 - x] + 2*PolyLog[4, -x] + 2*PolyLog[4, x] - 
      2*PolyLog[4, x/(-1 + x)] - 2*PolyLog[4, (1 + x)^(-1)] - 
      2*PolyLog[4, x/(1 + x)] - PolyLog[4, 1 - x^2]/2 + 
      PolyLog[4, x^2/(-1 + x^2)]/2 - (3*Log[1 - x]*Zeta[3])/2 - 
      (3*Log[1 + x]*Zeta[3])/2, HPL[{-2, 1, -1}, x_] :> 
     Pi^4/90 - Li[{2, 2}, {-1, x}] - Li[{2, 2}, {1/2, (2*x)/(1 + x)}] - 
      (7*Pi^2*Log[2]*Log[1 + x])/12 + (7*Log[2]^3*Log[1 + x])/6 - 
      (5*Pi^2*Log[1 - x]*Log[1 + x])/12 - (Log[2]^2*Log[1 - x]*Log[1 + x])/
       2 + (3*Log[2]*Log[1 - x]^2*Log[1 + x])/2 - (Log[1 - x]^3*Log[1 + x])/
       2 + (3*Log[1 - x]^2*Log[x]*Log[1 + x])/2 + (17*Pi^2*Log[1 + x]^2)/24 - 
      (7*Log[2]^2*Log[1 + x]^2)/4 - (3*Log[2]*Log[1 - x]*Log[1 + x]^2)/2 - 
      2*Log[1 - x]*Log[x]*Log[1 + x]^2 + 2*Log[2]*Log[1 + x]^3 + 
      (Log[1 - x]*Log[1 + x]^3)/2 + (7*Log[x]*Log[1 + x]^3)/6 - 
      (19*Log[1 + x]^4)/24 - (Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 + 
      (Pi^2*PolyLog[2, -x])/12 - (Log[2]^2*PolyLog[2, -x])/2 + 
      Log[2]*Log[1 - x]*PolyLog[2, -x] + (Log[1 + x]^2*PolyLog[2, -x])/2 - 
      PolyLog[2, (1 - x)/2]*PolyLog[2, -x] + PolyLog[2, -x]^2/2 - 
      (Log[1 + x]^2*PolyLog[2, x])/2 - Log[1 + x]*PolyLog[3, (1 - x)/2] + 
      Log[1 + x]*PolyLog[3, 1 - x] - Log[1 + x]*PolyLog[3, -x] + 
      3*Log[1 + x]*PolyLog[3, x] + 3*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] + 
      2*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)] + 6*PolyLog[4, 1/2] - 
      PolyLog[4, -x]/2 - (3*PolyLog[4, x])/2 - 
      (3*PolyLog[4, (4*x)/(1 + x)^2])/4 - PolyLog[4, (1 + x)^(-1)] - 
      2*PolyLog[4, x/(1 + x)] + 3*PolyLog[4, (2*x)/(1 + x)] - 
      6*PolyLog[4, (1 + x)/2] + (17*Log[1 + x]*Zeta[3])/8, 
    HPL[{-2, 1, 0}, x_] :> Pi^4/45 - Li[{2, 2}, {-1, x}] - 
      (Pi^2*Log[2]*Log[x])/12 + (Log[2]^3*Log[x])/6 - 
      (Pi^2*Log[1 - x]*Log[x])/12 - (Log[2]^2*Log[1 - x]*Log[x])/2 + 
      (Log[2]*Log[1 - x]^2*Log[x])/2 - (Log[1 - x]^3*Log[x])/6 + 
      (Log[1 - x]^2*Log[x]^2)/2 - (Pi^2*Log[2]*Log[1 + x])/3 + 
      (2*Log[2]^3*Log[1 + x])/3 + (Pi^2*Log[1 + x]^2)/3 - 
      Log[2]^2*Log[1 + x]^2 + (2*Log[2]*Log[1 + x]^3)/3 + 
      (Log[x]*Log[1 + x]^3)/3 - Log[1 + x]^4/3 + Log[1 - x]*Log[x]*
       PolyLog[2, -x] + PolyLog[2, -x]*PolyLog[2, x] - 
      Log[x]*PolyLog[3, (1 - x)/2] + Log[x]*PolyLog[3, 1 - x] - 
      Log[x]*PolyLog[3, -x] + Log[x]*PolyLog[3, x] + 
      2*Log[1 + x]*PolyLog[3, x] + Log[x]*PolyLog[3, (2*x)/(-1 + x)] + 
      4*PolyLog[4, 1/2] + PolyLog[4, -x] - 3*PolyLog[4, x] - 
      PolyLog[4, (4*x)/(1 + x)^2]/2 - 2*PolyLog[4, (1 + x)^(-1)] - 
      2*PolyLog[4, x/(1 + x)] + 4*PolyLog[4, (2*x)/(1 + x)] - 
      4*PolyLog[4, (1 + x)/2] - (Log[x]*Zeta[3])/8 + 
      (3*Log[1 + x]*Zeta[3])/2, HPL[{-2, 1, 1}, x_] :> 
     -Pi^4/72 + (3*Pi^2*Log[1 - x]^2)/16 + (Log[2]^2*Log[1 - x]^2)/4 - 
      (Log[2]*Log[1 - x]^3)/3 + (19*Log[1 - x]^4)/96 - 
      (7*Log[1 - x]^3*Log[x])/12 + (Pi^2*Log[2]*Log[1 + x])/6 - 
      (Log[2]^3*Log[1 + x])/3 - (Pi^2*Log[1 - x]*Log[1 + x])/24 - 
      (Log[1 - x]^3*Log[1 + x])/24 + (Log[1 - x]^2*Log[x]*Log[1 + x])/4 - 
      (13*Pi^2*Log[1 + x]^2)/48 + (Log[2]^2*Log[1 + x]^2)/2 - 
      (Log[1 - x]^2*Log[1 + x]^2)/16 + (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 - 
      (Log[2]*Log[1 + x]^3)/3 - (Log[1 - x]*Log[1 + x]^3)/24 - 
      (Log[x]*Log[1 + x]^3)/4 + (23*Log[1 + x]^4)/96 - 
      (Log[1 - x]^2*PolyLog[2, -x])/2 + Log[1 - x]*PolyLog[3, (1 - x)/2] - 
      Log[1 - x]*PolyLog[3, 1 - x] + Log[1 - x]*PolyLog[3, -x] - 
      Log[1 - x]*PolyLog[3, x] - Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)] - 
      PolyLog[4, 1/2] - PolyLog[4, (1 - x)/2] - PolyLog[4, 1 - x] - 
      PolyLog[4, -x]/2 + PolyLog[4, x]/2 + 2*PolyLog[4, x/(-1 + x)] - 
      PolyLog[4, (2*x)/(-1 + x)] + PolyLog[4, (4*x)/(1 + x)^2]/4 + 
      2*PolyLog[4, (1 + x)^(-1)] + 2*PolyLog[4, x/(1 + x)] - 
      2*PolyLog[4, (2*x)/(1 + x)] + 2*PolyLog[4, (1 + x)/2] + 
      PolyLog[4, 1 - x^2]/4 - PolyLog[4, x^2/(-1 + x^2)]/4 + 
      (7*Log[1 - x]*Zeta[3])/4, HPL[{-3, -1}, x_] :> 
     -Pi^4/90 - (Pi^2*Log[1 + x]^2)/12 - (Log[x]*Log[1 + x]^3)/6 + 
      Log[1 + x]^4/12 - Log[1 + x]*PolyLog[3, -x] + PolyLog[4, -x] + 
      PolyLog[4, (1 + x)^(-1)] + PolyLog[4, x/(1 + x)] + Log[1 + x]*Zeta[3], 
    HPL[{-3, 0}, x_] :> -(Log[x]*PolyLog[3, -x]) + 3*PolyLog[4, -x], 
    HPL[{-3, 1}, x_] :> -Pi^4/72 + (Pi^2*Log[1 - x]^2)/16 + Log[1 - x]^4/32 - 
      (Log[1 - x]^3*Log[x])/12 + (Pi^2*Log[2]*Log[1 + x])/6 - 
      (Log[2]^3*Log[1 + x])/3 - (Pi^2*Log[1 - x]*Log[1 + x])/24 - 
      (Log[1 - x]^3*Log[1 + x])/24 + (Log[1 - x]^2*Log[x]*Log[1 + x])/4 - 
      (13*Pi^2*Log[1 + x]^2)/48 + (Log[2]^2*Log[1 + x]^2)/2 - 
      (Log[1 - x]^2*Log[1 + x]^2)/16 + (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 - 
      (Log[2]*Log[1 + x]^3)/3 - (Log[1 - x]*Log[1 + x]^3)/24 - 
      (Log[x]*Log[1 + x]^3)/4 + (23*Log[1 + x]^4)/96 + 
      Log[1 - x]*PolyLog[3, -x] - 2*PolyLog[4, 1/2] - PolyLog[4, 1 - x] - 
      (3*PolyLog[4, -x])/2 + PolyLog[4, x]/2 + PolyLog[4, x/(-1 + x)] + 
      PolyLog[4, (4*x)/(1 + x)^2]/4 + 2*PolyLog[4, (1 + x)^(-1)] + 
      2*PolyLog[4, x/(1 + x)] - 2*PolyLog[4, (2*x)/(1 + x)] + 
      2*PolyLog[4, (1 + x)/2] + PolyLog[4, 1 - x^2]/4 - 
      PolyLog[4, x^2/(-1 + x^2)]/4 + (3*Log[1 - x]*Zeta[3])/4, 
    HPL[{-4}, x_] :> -PolyLog[4, -x], HPL[{0, 0, 0, 0}, x_] :> Log[x]^4/24, 
    HPL[{4}, x_] :> PolyLog[4, x], HPL[{3, -1}, x_] :> 
     Pi^4/90 - (Pi^2*Log[2]*Log[1 + x])/6 + (Log[2]^3*Log[1 + x])/3 + 
      (Pi^2*Log[1 + x]^2)/6 - (Log[2]^2*Log[1 + x]^2)/2 + 
      (Log[2]*Log[1 + x]^3)/3 + (Log[x]*Log[1 + x]^3)/6 - Log[1 + x]^4/6 + 
      Log[1 + x]*PolyLog[3, x] + 2*PolyLog[4, 1/2] + PolyLog[4, -x]/2 - 
      (3*PolyLog[4, x])/2 - PolyLog[4, (4*x)/(1 + x)^2]/4 - 
      PolyLog[4, (1 + x)^(-1)] - PolyLog[4, x/(1 + x)] + 
      2*PolyLog[4, (2*x)/(1 + x)] - 2*PolyLog[4, (1 + x)/2] + 
      (3*Log[1 + x]*Zeta[3])/4, HPL[{3, 0}, x_] :> Log[x]*PolyLog[3, x] - 
      3*PolyLog[4, x], HPL[{3, 1}, x_] :> Pi^4/90 + (Pi^2*Log[1 - x]^2)/12 + 
      Log[1 - x]^4/24 - (Log[1 - x]^3*Log[x])/6 - Log[1 - x]*PolyLog[3, x] - 
      PolyLog[4, 1 - x] + PolyLog[4, x] + PolyLog[4, x/(-1 + x)] + 
      Log[1 - x]*Zeta[3], HPL[{2, -1, -1}, x_] :> 
     -Pi^4/90 + (Pi^2*Log[2]*Log[1 + x])/6 - (Log[2]^3*Log[1 + x])/3 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/6 - (Log[2]*Log[1 - x]^2*Log[1 + x])/2 + 
      (Log[1 - x]^3*Log[1 + x])/6 - (Log[1 - x]^2*Log[x]*Log[1 + x])/2 - 
      (Pi^2*Log[1 + x]^2)/8 + (Log[2]^2*Log[1 + x]^2)/4 + 
      Log[2]*Log[1 - x]*Log[1 + x]^2 + Log[1 - x]*Log[x]*Log[1 + x]^2 - 
      (Log[2]*Log[1 + x]^3)/2 - (Log[1 - x]*Log[1 + x]^3)/2 - 
      (Log[x]*Log[1 + x]^3)/6 + Log[1 + x]^4/6 + (Log[1 + x]^2*PolyLog[2, x])/
       2 + Log[1 + x]*PolyLog[3, -x] - Log[1 + x]*PolyLog[3, x] - 
      Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] + 
      Log[1 + x]*PolyLog[3, (1 + x)^(-1)] - Log[1 + x]*
       PolyLog[3, (1 - x)/(1 + x)] - Log[1 + x]*PolyLog[3, (1 + x)/2] - 
      3*PolyLog[4, 1/2] - PolyLog[4, -x]/2 + PolyLog[4, x]/2 + 
      PolyLog[4, (4*x)/(1 + x)^2]/4 + PolyLog[4, (1 + x)^(-1)] - 
      PolyLog[4, (2*x)/(1 + x)] + 3*PolyLog[4, (1 + x)/2] - 
      (3*Log[1 + x]*Zeta[3])/4, HPL[{2, -1, 0}, x_] :> 
     -Pi^4/45 + Li[{2, 2}, {-1, x}] - (Pi^2*Log[2]*Log[x])/12 + 
      (Log[2]^3*Log[x])/6 + (Pi^2*Log[1 - x]*Log[x])/6 - 
      (Log[2]*Log[1 - x]^2*Log[x])/2 + (Log[1 - x]^3*Log[x])/6 - 
      (Log[1 - x]^2*Log[x]^2)/2 + (Pi^2*Log[2]*Log[1 + x])/3 - 
      (2*Log[2]^3*Log[1 + x])/3 + (Pi^2*Log[x]*Log[1 + x])/12 - 
      (Log[2]^2*Log[x]*Log[1 + x])/2 + Log[2]*Log[1 - x]*Log[x]*Log[1 + x] + 
      Log[1 - x]*Log[x]^2*Log[1 + x] - (Pi^2*Log[1 + x]^2)/3 + 
      Log[2]^2*Log[1 + x]^2 - (Log[1 - x]*Log[x]*Log[1 + x]^2)/2 - 
      (2*Log[2]*Log[1 + x]^3)/3 - (Log[x]*Log[1 + x]^3)/3 + Log[1 + x]^4/3 + 
      Log[x]*Log[1 + x]*PolyLog[2, x] + Log[x]*PolyLog[3, -x] - 
      Log[x]*PolyLog[3, x] - 2*Log[1 + x]*PolyLog[3, x] - 
      Log[x]*PolyLog[3, (2*x)/(-1 + x)] + Log[x]*PolyLog[3, (1 + x)^(-1)] - 
      Log[x]*PolyLog[3, (1 - x)/(1 + x)] - Log[x]*PolyLog[3, (1 + x)/2] - 
      4*PolyLog[4, 1/2] - PolyLog[4, -x] + 3*PolyLog[4, x] + 
      PolyLog[4, (4*x)/(1 + x)^2]/2 + 2*PolyLog[4, (1 + x)^(-1)] + 
      2*PolyLog[4, x/(1 + x)] - 4*PolyLog[4, (2*x)/(1 + x)] + 
      4*PolyLog[4, (1 + x)/2] + (7*Log[x]*Zeta[3])/8 - 
      (3*Log[1 + x]*Zeta[3])/2, HPL[{2, -1, 1}, x_] :> 
     Pi^4/72 - Li[{2, 2}, {-1, x}] + Li[{2, 2}, {1/2, (2*x)/(-1 + x)}] + 
      (Pi^2*Log[2]*Log[1 - x])/12 - (Log[2]^3*Log[1 - x])/6 - 
      (17*Pi^2*Log[1 - x]^2)/48 - (Log[2]^2*Log[1 - x]^2)/4 + 
      Log[2]*Log[1 - x]^3 - (47*Log[1 - x]^4)/96 + (11*Log[1 - x]^3*Log[x])/
       12 - (Pi^2*Log[2]*Log[1 + x])/2 + Log[2]^3*Log[1 + x] - 
      (Pi^2*Log[1 - x]*Log[1 + x])/24 + (Log[2]^2*Log[1 - x]*Log[1 + x])/2 - 
      Log[2]*Log[1 - x]^2*Log[1 + x] + (Log[1 - x]^3*Log[1 + x])/24 - 
      (5*Log[1 - x]^2*Log[x]*Log[1 + x])/4 + (29*Pi^2*Log[1 + x]^2)/48 - 
      (3*Log[2]^2*Log[1 + x]^2)/2 + (9*Log[1 - x]^2*Log[1 + x]^2)/16 - 
      (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 + Log[2]*Log[1 + x]^3 + 
      (Log[1 - x]*Log[1 + x]^3)/24 + (7*Log[x]*Log[1 + x]^3)/12 - 
      (55*Log[1 + x]^4)/96 - (Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 + 
      (Log[1 - x]^2*PolyLog[2, -x])/2 + (Pi^2*PolyLog[2, x])/12 - 
      (Log[2]^2*PolyLog[2, x])/2 + Log[2]*Log[1 - x]*PolyLog[2, x] - 
      (Log[1 - x]^2*PolyLog[2, x])/2 - Log[1 - x]*Log[1 + x]*PolyLog[2, x] - 
      PolyLog[2, (1 - x)/2]*PolyLog[2, x] + PolyLog[2, -x]*PolyLog[2, x] - 
      PolyLog[2, x]^2/2 - Log[1 - x]*PolyLog[3, -x] + 
      Log[1 - x]*PolyLog[3, x] + 2*Log[1 + x]*PolyLog[3, x] + 
      3*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)] - 
      Log[1 - x]*PolyLog[3, (1 + x)^(-1)] + Log[1 - x]*
       PolyLog[3, (1 - x)/(1 + x)] + Log[1 - x]*PolyLog[3, (1 + x)/2] + 
      6*PolyLog[4, 1/2] + 3*PolyLog[4, 1 - x] - PolyLog[4, -x]/2 - 
      (3*PolyLog[4, x])/2 - 2*PolyLog[4, x/(-1 + x)] + 
      3*PolyLog[4, (2*x)/(-1 + x)] - (3*PolyLog[4, (4*x)/(1 + x)^2])/4 - 
      4*PolyLog[4, (1 + x)^(-1)] - 4*PolyLog[4, x/(1 + x)] + 
      6*PolyLog[4, (2*x)/(1 + x)] - 6*PolyLog[4, (1 + x)/2] - 
      PolyLog[4, 1 - x^2]/4 + PolyLog[4, x^2/(-1 + x^2)]/4 - 
      (29*Log[1 - x]*Zeta[3])/8 + (3*Log[1 + x]*Zeta[3])/2, 
    HPL[{2, -2}, x_] :> -Li[{2, 2}, {-1, x}], HPL[{2, 0, 0}, x_] :> 
     (Log[x]^2*PolyLog[2, x])/2 - 2*Log[x]*PolyLog[3, x] + 3*PolyLog[4, x], 
    HPL[{2, 2}, x_] :> -Pi^4/45 - (Pi^2*Log[1 - x]^2)/6 - Log[1 - x]^4/12 + 
      (Log[1 - x]^3*Log[x])/3 + PolyLog[2, x]^2/2 + 
      2*Log[1 - x]*PolyLog[3, x] + 2*PolyLog[4, 1 - x] - 2*PolyLog[4, x] - 
      2*PolyLog[4, x/(-1 + x)] - 2*Log[1 - x]*Zeta[3], 
    HPL[{2, 1, -1}, x_] :> -Pi^4/288 + Li[{2, 2}, {-1, x}] - 
      Li[{2, 2}, {1/2, (2*x)/(-1 + x)}] + (Pi^2*Log[2]*Log[1 - x])/12 - 
      (Log[2]^3*Log[1 - x])/6 + (Pi^2*Log[1 - x]^2)/8 + 
      (Log[2]^2*Log[1 - x]^2)/2 - (2*Log[2]*Log[1 - x]^3)/3 + 
      (7*Log[1 - x]^4)/24 - (Log[1 - x]^3*Log[x])/3 + 
      (Pi^2*Log[2]*Log[1 + x])/3 - (2*Log[2]^3*Log[1 + x])/3 - 
      (3*Pi^2*Log[1 + x]^2)/8 + Log[2]^2*Log[1 + x]^2 - 
      (2*Log[2]*Log[1 + x]^3)/3 - (Log[x]*Log[1 + x]^3)/3 + 
      (3*Log[1 + x]^4)/8 + (Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 - 
      (Log[1 - x]^2*PolyLog[2, -x])/2 - (Pi^2*PolyLog[2, x])/12 + 
      (Log[2]^2*PolyLog[2, x])/2 - Log[2]*Log[1 - x]*PolyLog[2, x] + 
      (Log[1 - x]^2*PolyLog[2, x])/2 + PolyLog[2, (1 - x)/2]*PolyLog[2, x] - 
      PolyLog[2, -x]*PolyLog[2, x] + PolyLog[2, x]^2/2 - 
      Log[1 + x]*PolyLog[3, 1 - x] - 2*Log[1 + x]*PolyLog[3, x] - 
      2*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)] - 5*PolyLog[4, 1/2] + 
      PolyLog[4, (1 - x)/2] - 2*PolyLog[4, 1 - x] + PolyLog[4, -x] + 
      PolyLog[4, x] - 2*PolyLog[4, (2*x)/(-1 + x)] + 
      PolyLog[4, (4*x)/(1 + x)^2]/2 + 3*PolyLog[4, (1 + x)^(-1)] - 
      PolyLog[4, (1 - x)/(1 + x)]/2 + PolyLog[4, (-1 + x)/(1 + x)]/2 + 
      2*PolyLog[4, x/(1 + x)] - 4*PolyLog[4, (2*x)/(1 + x)] + 
      4*PolyLog[4, (1 + x)/2] + PolyLog[4, 1 - x^2]/4 + 
      (7*Log[1 - x]*Zeta[3])/4 - (5*Log[1 + x]*Zeta[3])/8, 
    HPL[{2, 1, 0}, x_] :> (Pi^2*Log[1 - x]*Log[x])/6 - 
      (Log[1 - x]^2*Log[x]^2)/2 - Log[1 - x]*Log[x]*PolyLog[2, x] - 
      PolyLog[2, x]^2/2 - Log[x]*PolyLog[3, 1 - x] + Log[x]*Zeta[3], 
    HPL[{2, 1, 1}, x_] :> Pi^4/90 - (Pi^2*Log[1 - x]^2)/12 + 
      (Log[1 - x]^3*Log[x])/3 + (Log[1 - x]^2*PolyLog[2, x])/2 + 
      Log[1 - x]*PolyLog[3, 1 - x] - PolyLog[4, 1 - x], 
    HPL[{1, -1, -1, -1}, x_] :> -(Pi^2*Log[1 + x]^2)/12 + 
      (Log[2]^2*Log[1 + x]^2)/2 - (Log[2]*Log[1 - x]*Log[1 + x]^2)/2 - 
      (Log[2]*Log[1 + x]^3)/3 + (Log[1 - x]*Log[1 + x]^3)/3 + 
      (Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 + 
      Log[1 + x]*PolyLog[3, (1 + x)/2] + PolyLog[4, 1/2] - 
      PolyLog[4, (1 + x)/2], HPL[{1, -1, -1, 0}, x_] :> 
     -Pi^4/480 - Li[{2, 2}, {-1, x}] - Li[{2, 2}, {1/2, (2*x)/(1 + x)}] + 
      (Pi^2*Log[2]*Log[x])/12 - (Log[2]^3*Log[x])/6 - 
      (Pi^2*Log[2]*Log[1 + x])/4 + (Log[2]^3*Log[1 + x])/2 - 
      (Pi^2*Log[1 - x]*Log[1 + x])/4 + Log[2]*Log[1 - x]^2*Log[1 + x] - 
      (Log[1 - x]^3*Log[1 + x])/3 - (Pi^2*Log[x]*Log[1 + x])/6 + 
      Log[2]^2*Log[x]*Log[1 + x] - Log[2]*Log[1 - x]*Log[x]*Log[1 + x] + 
      Log[1 - x]^2*Log[x]*Log[1 + x] + (5*Pi^2*Log[1 + x]^2)/12 - 
      Log[2]^2*Log[1 + x]^2 - (3*Log[2]*Log[1 - x]*Log[1 + x]^2)/2 - 
      (Log[2]*Log[x]*Log[1 + x]^2)/2 - Log[1 - x]*Log[x]*Log[1 + x]^2 + 
      (3*Log[2]*Log[1 + x]^3)/2 + (Log[1 - x]*Log[1 + x]^3)/2 + 
      Log[x]*Log[1 + x]^3 - (5*Log[1 + x]^4)/8 + Log[x]*Log[1 + x]*
       PolyLog[2, (1 - x)/2] - (Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 + 
      (Log[1 + x]^2*PolyLog[2, -x])/2 + PolyLog[2, -x]^2/2 - 
      (Log[1 + x]^2*PolyLog[2, x])/2 + 2*Log[1 + x]*PolyLog[3, x] + 
      2*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] + 
      2*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)] + 
      Log[x]*PolyLog[3, (1 + x)/2] + 3*PolyLog[4, 1/2] - PolyLog[4, 1 - x] - 
      PolyLog[4, -x] - PolyLog[4, x] - PolyLog[4, (4*x)/(1 + x)^2]/2 + 
      PolyLog[4, (1 - x)/(1 + x)]/2 - PolyLog[4, (-1 + x)/(1 + x)]/2 - 
      2*PolyLog[4, x/(1 + x)] + 2*PolyLog[4, (2*x)/(1 + x)] - 
      3*PolyLog[4, (1 + x)/2] + PolyLog[4, 1 - x^2]/4 - 
      (Log[1 - x]*Zeta[3])/8 - (7*Log[x]*Zeta[3])/8 + 
      (5*Log[1 + x]*Zeta[3])/4, HPL[{1, -1, -1, 1}, x_] :> 
     -Pi^4/288 + (Pi^2*Log[2]^2)/24 - Log[2]^4/8 - (Pi^2*Log[2]*Log[1 - x])/
       6 + (2*Log[2]^3*Log[1 - x])/3 - (Log[2]^2*Log[1 - x]^2)/2 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/6 - Log[2]^2*Log[1 - x]*Log[1 + x] + 
      Log[2]*Log[1 - x]^2*Log[1 + x] + (Log[2]*Log[1 - x]*Log[1 + x]^2)/2 - 
      (Log[1 - x]^2*Log[1 + x]^2)/2 + (Pi^2*PolyLog[2, (1 - x)/2])/12 - 
      (Log[2]^2*PolyLog[2, (1 - x)/2])/2 + Log[2]*Log[1 - x]*
       PolyLog[2, (1 - x)/2] - Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2] - 
      PolyLog[2, (1 - x)/2]^2/2 - Log[1 - x]*PolyLog[3, (1 + x)/2] + 
      (7*Log[1 - x]*Zeta[3])/8, HPL[{1, -1, -2}, x_] :> 
     (11*Pi^4)/720 + Li[{2, 2}, {-1, x}] + Li[{2, 2}, {1/2, (2*x)/(1 + x)}] - 
      (Pi^2*Log[2]*Log[1 + x])/12 + (Log[2]^3*Log[1 + x])/6 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/12 - (Log[2]^2*Log[1 - x]*Log[1 + x])/2 - 
      (Log[2]*Log[1 - x]^2*Log[1 + x])/2 + (Log[1 - x]^3*Log[1 + x])/6 - 
      (Log[1 - x]^2*Log[x]*Log[1 + x])/2 - (Pi^2*Log[1 + x]^2)/8 + 
      (Log[2]^2*Log[1 + x]^2)/4 + (3*Log[2]*Log[1 - x]*Log[1 + x]^2)/2 + 
      Log[1 - x]*Log[x]*Log[1 + x]^2 - Log[2]*Log[1 + x]^3 - 
      (Log[1 - x]*Log[1 + x]^3)/2 - (5*Log[x]*Log[1 + x]^3)/6 + 
      (11*Log[1 + x]^4)/24 + (Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - 
      (Log[1 + x]^2*PolyLog[2, -x])/2 - PolyLog[2, -x]^2/2 + 
      (Log[1 + x]^2*PolyLog[2, x])/2 - Log[1 + x]*PolyLog[3, (1 - x)/2] + 
      Log[1 + x]*PolyLog[3, 1 - x] - Log[1 + x]*PolyLog[3, -x] - 
      Log[1 + x]*PolyLog[3, x] - Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] - 
      2*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)] + 2*PolyLog[4, 1 - x] + 
      (3*PolyLog[4, -x])/2 + PolyLog[4, x]/2 + PolyLog[4, (4*x)/(1 + x)^2]/
       4 - PolyLog[4, (1 + x)^(-1)] - PolyLog[4, (1 - x)/(1 + x)] + 
      PolyLog[4, (-1 + x)/(1 + x)] + 2*PolyLog[4, x/(1 + x)] - 
      PolyLog[4, (2*x)/(1 + x)] - PolyLog[4, 1 - x^2]/2 + 
      (Log[1 - x]*Zeta[3])/4 - (3*Log[1 + x]*Zeta[3])/8, 
    HPL[{1, -1, 0, 0}, x_] :> Pi^4/72 - (Pi^2*Log[1 - x]^2)/16 - 
      Log[1 - x]^4/32 - (Pi^2*Log[2]*Log[x])/12 + (Log[2]^3*Log[x])/6 - 
      (Pi^2*Log[1 - x]*Log[x])/12 - (Log[2]^2*Log[1 - x]*Log[x])/2 + 
      (Log[2]*Log[1 - x]^2*Log[x])/2 - (Log[1 - x]^3*Log[x])/12 - 
      (Pi^2*Log[x]^2)/24 + (Log[2]^2*Log[x]^2)/4 - 
      (Log[2]*Log[1 - x]*Log[x]^2)/2 + (Log[1 - x]^2*Log[x]^2)/2 - 
      (Pi^2*Log[2]*Log[1 + x])/6 + (Log[2]^3*Log[1 + x])/3 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/24 + (Log[1 - x]^3*Log[1 + x])/24 - 
      (Log[1 - x]^2*Log[x]*Log[1 + x])/4 + (13*Pi^2*Log[1 + x]^2)/48 - 
      (Log[2]^2*Log[1 + x]^2)/2 + (Log[1 - x]^2*Log[1 + x]^2)/16 - 
      (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 + (Log[2]*Log[1 + x]^3)/3 + 
      (Log[1 - x]*Log[1 + x]^3)/24 + (Log[x]*Log[1 + x]^3)/4 - 
      (23*Log[1 + x]^4)/96 + (Log[x]^2*PolyLog[2, (1 - x)/2])/2 - 
      Log[x]*PolyLog[3, (1 - x)/2] + Log[x]*PolyLog[3, 1 - x] - 
      Log[x]*PolyLog[3, -x] + Log[x]*PolyLog[3, x] + 
      Log[x]*PolyLog[3, (2*x)/(-1 + x)] + 2*PolyLog[4, 1/2] + 
      PolyLog[4, 1 - x] + (3*PolyLog[4, -x])/2 - PolyLog[4, x]/2 - 
      PolyLog[4, x/(-1 + x)] - PolyLog[4, (4*x)/(1 + x)^2]/4 - 
      2*PolyLog[4, (1 + x)^(-1)] - 2*PolyLog[4, x/(1 + x)] + 
      2*PolyLog[4, (2*x)/(1 + x)] - 2*PolyLog[4, (1 + x)/2] - 
      PolyLog[4, 1 - x^2]/4 + PolyLog[4, x^2/(-1 + x^2)]/4 - 
      (3*Log[1 - x]*Zeta[3])/4 - (Log[x]*Zeta[3])/8, 
    HPL[{1, -1, 2}, x_] :> -Pi^4/72 - Li[{2, 2}, {-1, x}] + 
      Li[{2, 2}, {1/2, (2*x)/(-1 + x)}] - (Pi^2*Log[2]*Log[1 - x])/12 + 
      (Log[2]^3*Log[1 - x])/6 + (5*Pi^2*Log[1 - x]^2)/48 - 
      (Log[2]^2*Log[1 - x]^2)/4 + (Log[2]*Log[1 - x]^3)/3 - 
      (3*Log[1 - x]^4)/32 - (Log[1 - x]^3*Log[x])/4 - 
      (Pi^2*Log[2]*Log[1 + x])/6 + (Log[2]^3*Log[1 + x])/3 - 
      (Pi^2*Log[1 - x]*Log[1 + x])/24 - (Log[1 - x]^3*Log[1 + x])/24 + 
      (Log[1 - x]^2*Log[x]*Log[1 + x])/4 + (Pi^2*Log[1 + x]^2)/16 - 
      (Log[2]^2*Log[1 + x]^2)/2 - (Log[1 - x]^2*Log[1 + x]^2)/16 + 
      (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 + (Log[2]*Log[1 + x]^3)/3 - 
      (Log[1 - x]*Log[1 + x]^3)/24 + (Log[x]*Log[1 + x]^3)/12 - 
      (3*Log[1 + x]^4)/32 - (Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 + 
      (Log[1 - x]^2*PolyLog[2, -x])/2 - (Log[1 - x]^2*PolyLog[2, x])/2 + 
      PolyLog[2, -x]*PolyLog[2, x] - PolyLog[2, x]^2/2 + 
      Log[1 - x]*PolyLog[3, (1 - x)/2] - Log[1 - x]*PolyLog[3, 1 - x] + 
      Log[1 - x]*PolyLog[3, -x] - Log[1 - x]*PolyLog[3, x] + 
      2*Log[1 + x]*PolyLog[3, x] + Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)] + 
      4*PolyLog[4, 1/2] - 2*PolyLog[4, (1 - x)/2] + PolyLog[4, 1 - x] - 
      (3*PolyLog[4, -x])/2 - PolyLog[4, x]/2 + 2*PolyLog[4, x/(-1 + x)] + 
      PolyLog[4, (2*x)/(-1 + x)] - PolyLog[4, (4*x)/(1 + x)^2]/4 + 
      2*PolyLog[4, (2*x)/(1 + x)] - 2*PolyLog[4, (1 + x)/2] + 
      PolyLog[4, 1 - x^2]/4 - PolyLog[4, x^2/(-1 + x^2)]/4 + 
      (5*Log[1 - x]*Zeta[3])/8 + (3*Log[1 + x]*Zeta[3])/2, 
    HPL[{1, -1, 1, -1}, x_] :> (-23*Pi^4)/1440 - (Pi^2*Log[2]^2)/24 + 
      Log[2]^4/8 - (Pi^2*Log[2]*Log[1 - x])/12 - (Log[2]^3*Log[1 - x])/6 + 
      (Pi^2*Log[2]*Log[1 + x])/3 - (2*Log[2]^3*Log[1 + x])/3 + 
      Log[2]^2*Log[1 - x]*Log[1 + x] - (Pi^2*Log[1 + x]^2)/6 + 
      (Log[2]^2*Log[1 + x]^2)/2 - Log[2]*Log[1 - x]*Log[1 + x]^2 + 
      (Log[1 - x]*Log[1 + x]^3)/3 - Log[1 + x]^4/12 - 
      (Pi^2*PolyLog[2, (1 - x)/2])/12 + (Log[2]^2*PolyLog[2, (1 - x)/2])/2 - 
      Log[2]*Log[1 - x]*PolyLog[2, (1 - x)/2] + PolyLog[2, (1 - x)/2]^2/2 + 
      2*Log[1 + x]*PolyLog[3, (1 - x)/2] - 2*PolyLog[4, (1 - x)/2] - 
      2*PolyLog[4, (-1 + x)/(1 + x)] + 2*PolyLog[4, (1 + x)/2] + 
      (Log[1 - x]*Zeta[3])/4 - 2*Log[1 + x]*Zeta[3], 
    HPL[{1, -1, 1, 0}, x_] :> -Pi^4/72 + Li[{2, 2}, {-1, x}] - 
      Li[{2, 2}, {1/2, (2*x)/(-1 + x)}] + (3*Pi^2*Log[1 - x]^2)/16 + 
      (Log[2]^2*Log[1 - x]^2)/4 - (Log[2]*Log[1 - x]^3)/2 + 
      (31*Log[1 - x]^4)/96 + (Pi^2*Log[2]*Log[x])/6 - (Log[2]^3*Log[x])/3 - 
      (Pi^2*Log[1 - x]*Log[x])/12 + (Log[2]^2*Log[1 - x]*Log[x])/2 - 
      (5*Log[1 - x]^3*Log[x])/12 + (Pi^2*Log[2]*Log[1 + x])/2 - 
      Log[2]^3*Log[1 + x] - (Pi^2*Log[1 - x]*Log[1 + x])/24 - 
      (Log[1 - x]^3*Log[1 + x])/24 + (Log[1 - x]^2*Log[x]*Log[1 + x])/4 - 
      (29*Pi^2*Log[1 + x]^2)/48 + (3*Log[2]^2*Log[1 + x]^2)/2 - 
      (Log[1 - x]^2*Log[1 + x]^2)/16 + (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 - 
      Log[2]*Log[1 + x]^3 - (Log[1 - x]*Log[1 + x]^3)/24 - 
      (7*Log[x]*Log[1 + x]^3)/12 + (55*Log[1 + x]^4)/96 + 
      (Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 - Log[1 - x]*Log[x]*
       PolyLog[2, (1 - x)/2] - (Log[1 - x]^2*PolyLog[2, -x])/2 + 
      (Log[1 - x]^2*PolyLog[2, x])/2 - PolyLog[2, -x]*PolyLog[2, x] + 
      PolyLog[2, x]^2/2 + 2*Log[x]*PolyLog[3, (1 - x)/2] - 
      2*Log[1 + x]*PolyLog[3, x] - 2*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)] - 
      6*PolyLog[4, 1/2] - 3*PolyLog[4, 1 - x] + PolyLog[4, -x]/2 + 
      (3*PolyLog[4, x])/2 + 2*PolyLog[4, x/(-1 + x)] - 
      3*PolyLog[4, (2*x)/(-1 + x)] + (3*PolyLog[4, (4*x)/(1 + x)^2])/4 + 
      4*PolyLog[4, (1 + x)^(-1)] + 4*PolyLog[4, x/(1 + x)] - 
      6*PolyLog[4, (2*x)/(1 + x)] + 6*PolyLog[4, (1 + x)/2] + 
      PolyLog[4, 1 - x^2]/4 - PolyLog[4, x^2/(-1 + x^2)]/4 + 
      (11*Log[1 - x]*Zeta[3])/4 - (7*Log[x]*Zeta[3])/4 - 
      (3*Log[1 + x]*Zeta[3])/2, HPL[{1, -1, 1, 1}, x_] :> 
     (Pi^2*Log[2]*Log[1 - x])/12 - (Log[2]^3*Log[1 - x])/6 + 
      (Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 - 2*Log[1 - x]*
       PolyLog[3, (1 - x)/2] - 3*PolyLog[4, 1/2] + 3*PolyLog[4, (1 - x)/2] - 
      (7*Log[1 - x]*Zeta[3])/8, HPL[{1, -2, -1}, x_] :> 
     -Pi^4/480 + (Pi^2*Log[2]*Log[1 + x])/6 - (Log[2]^3*Log[1 + x])/3 + 
      (Log[2]^2*Log[1 - x]*Log[1 + x])/2 - (Pi^2*Log[1 + x]^2)/6 + 
      (Log[2]^2*Log[1 + x]^2)/2 - Log[2]*Log[1 - x]*Log[1 + x]^2 - 
      (Log[1 - x]*Log[x]*Log[1 + x]^2)/2 + (Log[1 - x]*Log[1 + x]^3)/2 - 
      (Log[1 + x]^2*PolyLog[2, x])/2 + Log[1 + x]*PolyLog[3, (1 - x)/2] - 
      Log[1 + x]*PolyLog[3, 1 - x] - Log[1 + x]*PolyLog[3, (1 + x)^(-1)] + 
      Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)] + 
      Log[1 + x]*PolyLog[3, (1 + x)/2] - PolyLog[4, 1 - x] + 
      PolyLog[4, (1 - x)/(1 + x)]/2 - PolyLog[4, (-1 + x)/(1 + x)]/2 + 
      PolyLog[4, 1 - x^2]/4 - (Log[1 - x]*Zeta[3])/8 - 
      (Log[1 + x]*Zeta[3])/8, HPL[{1, -2, 0}, x_] :> 
     -Pi^4/180 - Li[{2, 2}, {-1, x}] + (Pi^2*Log[1 - x]^2)/8 + 
      Log[1 - x]^4/16 + (Pi^2*Log[2]*Log[x])/6 - (Log[2]^3*Log[x])/3 - 
      (Pi^2*Log[1 - x]*Log[x])/12 + (Log[2]^2*Log[1 - x]*Log[x])/2 - 
      (Log[1 - x]^3*Log[x])/6 - (Pi^2*Log[1 - x]*Log[1 + x])/12 - 
      (Log[1 - x]^3*Log[1 + x])/12 - (Pi^2*Log[x]*Log[1 + x])/12 + 
      (Log[2]^2*Log[x]*Log[1 + x])/2 - Log[2]*Log[1 - x]*Log[x]*Log[1 + x] + 
      (Log[1 - x]^2*Log[x]*Log[1 + x])/2 - Log[1 - x]*Log[x]^2*Log[1 + x] - 
      (5*Pi^2*Log[1 + x]^2)/24 - (Log[1 - x]^2*Log[1 + x]^2)/8 + 
      Log[1 - x]*Log[x]*Log[1 + x]^2 - (Log[1 - x]*Log[1 + x]^3)/12 - 
      (Log[x]*Log[1 + x]^3)/6 + (7*Log[1 + x]^4)/48 - 
      Log[x]*Log[1 + x]*PolyLog[2, x] + Log[x]*PolyLog[3, (1 - x)/2] - 
      Log[x]*PolyLog[3, 1 - x] + 2*Log[1 + x]*PolyLog[3, x] - 
      Log[x]*PolyLog[3, (1 + x)^(-1)] + Log[x]*PolyLog[3, (1 - x)/(1 + x)] + 
      Log[x]*PolyLog[3, (1 + x)/2] - 2*PolyLog[4, 1 - x] - 2*PolyLog[4, -x] - 
      2*PolyLog[4, x] + 2*PolyLog[4, x/(-1 + x)] + 
      2*PolyLog[4, (1 + x)^(-1)] + 2*PolyLog[4, x/(1 + x)] + 
      PolyLog[4, 1 - x^2]/2 - PolyLog[4, x^2/(-1 + x^2)]/2 + 
      (3*Log[1 - x]*Zeta[3])/2 - (3*Log[x]*Zeta[3])/4 + 
      (3*Log[1 + x]*Zeta[3])/2, HPL[{1, -2, 1}, x_] :> 
     Pi^4/72 + Li[{2, 2}, {-1, x}] - Li[{2, 2}, {1/2, (2*x)/(-1 + x)}] + 
      (Pi^2*Log[1 - x]^2)/16 + (Log[2]^2*Log[1 - x]^2)/4 - 
      (5*Log[2]*Log[1 - x]^3)/6 + (25*Log[1 - x]^4)/96 - 
      (Log[1 - x]^3*Log[x])/4 + (Pi^2*Log[2]*Log[1 + x])/6 - 
      (Log[2]^3*Log[1 + x])/3 + (Pi^2*Log[1 - x]*Log[1 + x])/8 - 
      (Log[2]^2*Log[1 - x]*Log[1 + x])/2 + Log[2]*Log[1 - x]^2*Log[1 + x] + 
      (Log[1 - x]^3*Log[1 + x])/24 + (3*Log[1 - x]^2*Log[x]*Log[1 + x])/4 - 
      (Pi^2*Log[1 + x]^2)/16 + (Log[2]^2*Log[1 + x]^2)/2 - 
      (7*Log[1 - x]^2*Log[1 + x]^2)/16 - (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 - 
      (Log[2]*Log[1 + x]^3)/3 + (Log[1 - x]*Log[1 + x]^3)/24 - 
      (Log[x]*Log[1 + x]^3)/12 + (3*Log[1 + x]^4)/32 + 
      (Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 - (Log[1 - x]^2*PolyLog[2, -x])/
       2 - (Pi^2*PolyLog[2, x])/12 + (Log[2]^2*PolyLog[2, x])/2 - 
      Log[2]*Log[1 - x]*PolyLog[2, x] + (Log[1 - x]^2*PolyLog[2, x])/2 + 
      Log[1 - x]*Log[1 + x]*PolyLog[2, x] + PolyLog[2, (1 - x)/2]*
       PolyLog[2, x] - PolyLog[2, -x]*PolyLog[2, x] + PolyLog[2, x]^2/2 - 
      Log[1 - x]*PolyLog[3, (1 - x)/2] + Log[1 - x]*PolyLog[3, 1 - x] - 
      2*Log[1 + x]*PolyLog[3, x] - 2*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)] + 
      Log[1 - x]*PolyLog[3, (1 + x)^(-1)] - Log[1 - x]*
       PolyLog[3, (1 - x)/(1 + x)] - Log[1 - x]*PolyLog[3, (1 + x)/2] - 
      4*PolyLog[4, 1/2] + 2*PolyLog[4, (1 - x)/2] - PolyLog[4, 1 - x] + 
      (3*PolyLog[4, -x])/2 + PolyLog[4, x]/2 - 2*PolyLog[4, x/(-1 + x)] - 
      PolyLog[4, (2*x)/(-1 + x)] + PolyLog[4, (4*x)/(1 + x)^2]/4 - 
      2*PolyLog[4, (2*x)/(1 + x)] + 2*PolyLog[4, (1 + x)/2] - 
      PolyLog[4, 1 - x^2]/4 + PolyLog[4, x^2/(-1 + x^2)]/4 + 
      (Log[1 - x]*Zeta[3])/4 - (3*Log[1 + x]*Zeta[3])/2, 
    HPL[{1, -3}, x_] :> Pi^4/360 + Li[{2, 2}, {-1, x}] - 
      (Pi^2*Log[1 - x]^2)/16 - Log[1 - x]^4/32 + (Log[1 - x]^3*Log[x])/12 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/24 + (Log[1 - x]^3*Log[1 + x])/24 - 
      (Log[1 - x]^2*Log[x]*Log[1 + x])/4 + (5*Pi^2*Log[1 + x]^2)/48 + 
      (Log[1 - x]^2*Log[1 + x]^2)/16 - (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 + 
      (Log[1 - x]*Log[1 + x]^3)/24 + (Log[x]*Log[1 + x]^3)/12 - 
      (7*Log[1 + x]^4)/96 - Log[1 + x]*PolyLog[3, x] + PolyLog[4, 1 - x] + 
      PolyLog[4, -x] + PolyLog[4, x] - PolyLog[4, x/(-1 + x)] - 
      PolyLog[4, (1 + x)^(-1)] - PolyLog[4, x/(1 + x)] - 
      PolyLog[4, 1 - x^2]/4 + PolyLog[4, x^2/(-1 + x^2)]/4 - 
      (3*Log[1 - x]*Zeta[3])/4 - (3*Log[1 + x]*Zeta[3])/4, 
    HPL[{1, 0, 0, 0}, x_] :> -(Log[1 - x]*Log[x]^3)/6 - 
      (Log[x]^2*PolyLog[2, x])/2 + Log[x]*PolyLog[3, x] - PolyLog[4, x], 
    HPL[{1, 3}, x_] :> -PolyLog[2, x]^2/2 - Log[1 - x]*PolyLog[3, x], 
    HPL[{1, 2, -1}, x_] :> -Pi^4/144 - Li[{2, 2}, {-1, x}] + 
      Li[{2, 2}, {1/2, (2*x)/(-1 + x)}] - (Pi^2*Log[2]*Log[1 - x])/6 + 
      (Log[2]^3*Log[1 - x])/3 - (Pi^2*Log[1 - x]^2)/16 - 
      (3*Log[2]^2*Log[1 - x]^2)/4 + (5*Log[2]*Log[1 - x]^3)/6 - 
      (25*Log[1 - x]^4)/96 + (Log[1 - x]^3*Log[x])/4 - 
      (Pi^2*Log[2]*Log[1 + x])/6 + (Log[2]^3*Log[1 + x])/3 - 
      (Pi^2*Log[1 - x]*Log[1 + x])/24 - (Log[1 - x]^3*Log[1 + x])/24 + 
      (Log[1 - x]^2*Log[x]*Log[1 + x])/4 + (7*Pi^2*Log[1 + x]^2)/48 - 
      (Log[2]^2*Log[1 + x]^2)/2 - (Log[1 - x]^2*Log[1 + x]^2)/16 + 
      (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 + (Log[2]*Log[1 + x]^3)/3 - 
      (Log[1 - x]*Log[1 + x]^3)/24 + (Log[x]*Log[1 + x]^3)/12 - 
      (17*Log[1 + x]^4)/96 - (Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 + 
      (Log[1 - x]^2*PolyLog[2, -x])/2 + (Pi^2*PolyLog[2, x])/12 - 
      (Log[2]^2*PolyLog[2, x])/2 + Log[2]*Log[1 - x]*PolyLog[2, x] - 
      (Log[1 - x]^2*PolyLog[2, x])/2 - PolyLog[2, (1 - x)/2]*PolyLog[2, x] + 
      PolyLog[2, -x]*PolyLog[2, x] - PolyLog[2, x]^2/2 + 
      2*Log[1 + x]*PolyLog[3, 1 - x] + 2*Log[1 + x]*PolyLog[3, x] + 
      2*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)] + 4*PolyLog[4, 1/2] - 
      2*PolyLog[4, (1 - x)/2] + PolyLog[4, 1 - x] - (3*PolyLog[4, -x])/2 - 
      PolyLog[4, x]/2 + 2*PolyLog[4, x/(-1 + x)] + 
      PolyLog[4, (2*x)/(-1 + x)] - PolyLog[4, (4*x)/(1 + x)^2]/4 - 
      2*PolyLog[4, (1 + x)^(-1)] + PolyLog[4, (1 - x)/(1 + x)] - 
      PolyLog[4, (-1 + x)/(1 + x)] + 2*PolyLog[4, (2*x)/(1 + x)] - 
      2*PolyLog[4, (1 + x)/2] - PolyLog[4, 1 - x^2]/4 - 
      PolyLog[4, x^2/(-1 + x^2)]/4 - (3*Log[1 - x]*Zeta[3])/4 - 
      (Log[1 + x]*Zeta[3])/4, HPL[{1, 2, 0}, x_] :> 
     Pi^4/45 + (Pi^2*Log[1 - x]^2)/6 + Log[1 - x]^4/12 - 
      (Pi^2*Log[1 - x]*Log[x])/3 - (Log[1 - x]^3*Log[x])/3 + 
      Log[1 - x]^2*Log[x]^2 + Log[1 - x]*Log[x]*PolyLog[2, x] + 
      PolyLog[2, x]^2/2 + 2*Log[x]*PolyLog[3, 1 - x] - 2*PolyLog[4, 1 - x] + 
      2*PolyLog[4, x] + 2*PolyLog[4, x/(-1 + x)] + 2*Log[1 - x]*Zeta[3] - 
      2*Log[x]*Zeta[3], HPL[{1, 2, 1}, x_] :> 
     -Pi^4/30 + (Pi^2*Log[1 - x]^2)/12 - (Log[1 - x]^3*Log[x])/2 - 
      (Log[1 - x]^2*PolyLog[2, x])/2 - 2*Log[1 - x]*PolyLog[3, 1 - x] + 
      3*PolyLog[4, 1 - x] - Log[1 - x]*Zeta[3], HPL[{1, 1, -1, -1}, x_] :> 
     (7*Pi^4)/720 + (Pi^2*Log[2]*Log[1 - x])/12 - (Log[2]^3*Log[1 - x])/6 + 
      (Log[2]^2*Log[1 - x]^2)/4 - (Pi^2*Log[2]*Log[1 + x])/6 + 
      (Log[2]^3*Log[1 + x])/3 - (Log[2]^2*Log[1 - x]*Log[1 + x])/2 + 
      (Pi^2*Log[1 + x]^2)/12 - (Log[2]^2*Log[1 + x]^2)/4 + 
      (Log[2]*Log[1 - x]*Log[1 + x]^2)/2 - (Log[1 - x]*Log[1 + x]^3)/6 + 
      Log[1 + x]^4/24 - Log[1 + x]*PolyLog[3, (1 - x)/2] + 
      PolyLog[4, (1 - x)/2] + PolyLog[4, (-1 + x)/(1 + x)] - 
      PolyLog[4, (1 + x)/2] - (Log[1 - x]*Zeta[3])/8 + Log[1 + x]*Zeta[3], 
    HPL[{1, 1, -1, 0}, x_] :> Pi^4/72 + (Pi^2*Log[2]*Log[1 - x])/12 - 
      (Log[2]^3*Log[1 - x])/6 - (5*Pi^2*Log[1 - x]^2)/48 + 
      (Log[2]^2*Log[1 - x]^2)/4 - (Log[2]*Log[1 - x]^3)/6 - Log[1 - x]^4/32 - 
      (Pi^2*Log[2]*Log[x])/12 + (Log[2]^3*Log[x])/6 + 
      (Pi^2*Log[1 - x]*Log[x])/12 - (Log[2]^2*Log[1 - x]*Log[x])/2 + 
      (Log[2]*Log[1 - x]^2*Log[x])/2 + (Log[1 - x]^3*Log[x])/12 - 
      (Pi^2*Log[2]*Log[1 + x])/6 + (Log[2]^3*Log[1 + x])/3 + 
      (Pi^2*Log[1 - x]*Log[1 + x])/24 + (Log[1 - x]^3*Log[1 + x])/24 - 
      (Log[1 - x]^2*Log[x]*Log[1 + x])/4 + (13*Pi^2*Log[1 + x]^2)/48 - 
      (Log[2]^2*Log[1 + x]^2)/2 + (Log[1 - x]^2*Log[1 + x]^2)/16 - 
      (Log[1 - x]*Log[x]*Log[1 + x]^2)/4 + (Log[2]*Log[1 + x]^3)/3 + 
      (Log[1 - x]*Log[1 + x]^3)/24 + (Log[x]*Log[1 + x]^3)/4 - 
      (23*Log[1 + x]^4)/96 - Log[x]*PolyLog[3, (1 - x)/2] + PolyLog[4, 1/2] + 
      PolyLog[4, (1 - x)/2] + PolyLog[4, 1 - x] + PolyLog[4, -x]/2 - 
      PolyLog[4, x]/2 - 2*PolyLog[4, x/(-1 + x)] + 
      PolyLog[4, (2*x)/(-1 + x)] - PolyLog[4, (4*x)/(1 + x)^2]/4 - 
      2*PolyLog[4, (1 + x)^(-1)] - 2*PolyLog[4, x/(1 + x)] + 
      2*PolyLog[4, (2*x)/(1 + x)] - 2*PolyLog[4, (1 + x)/2] - 
      PolyLog[4, 1 - x^2]/4 + PolyLog[4, x^2/(-1 + x^2)]/4 - 
      (13*Log[1 - x]*Zeta[3])/8 + (7*Log[x]*Zeta[3])/8, 
    HPL[{1, 1, -1, 1}, x_] :> -(Pi^2*Log[2]*Log[1 - x])/6 + 
      (Log[2]^3*Log[1 - x])/3 + (Pi^2*Log[1 - x]^2)/24 - 
      (Log[2]^2*Log[1 - x]^2)/4 + Log[1 - x]*PolyLog[3, (1 - x)/2] + 
      3*PolyLog[4, 1/2] - 3*PolyLog[4, (1 - x)/2] + (7*Log[1 - x]*Zeta[3])/4, 
    HPL[{1, 1, -2}, x_] :> -Pi^4/288 + (Pi^2*Log[1 - x]^2)/24 - 
      (Pi^2*Log[1 + x]^2)/24 + Log[1 + x]^4/24 - 
      Log[1 + x]*PolyLog[3, 1 - x] + PolyLog[4, (1 + x)^(-1)] - 
      PolyLog[4, (1 - x)/(1 + x)]/2 + PolyLog[4, (-1 + x)/(1 + x)]/2 + 
      PolyLog[4, 1 - x^2]/4 + (5*Log[1 - x]*Zeta[3])/8 + 
      (7*Log[1 + x]*Zeta[3])/8, HPL[{1, 1, 0, 0}, x_] :> 
     -Pi^4/90 - (Pi^2*Log[1 - x]^2)/12 - Log[1 - x]^4/24 + 
      (Pi^2*Log[1 - x]*Log[x])/6 + (Log[1 - x]^3*Log[x])/6 - 
      (Log[1 - x]^2*Log[x]^2)/4 - Log[x]*PolyLog[3, 1 - x] + 
      PolyLog[4, 1 - x] - PolyLog[4, x] - PolyLog[4, x/(-1 + x)] - 
      Log[1 - x]*Zeta[3] + Log[x]*Zeta[3], HPL[{1, 1, 2}, x_] :> 
     Pi^4/30 + (Pi^2*Log[1 - x]^2)/12 + Log[1 - x]*PolyLog[3, 1 - x] - 
      3*PolyLog[4, 1 - x] + 2*Log[1 - x]*Zeta[3], HPL[{1, 1, 1, -1}, x_] :> 
     (Pi^2*Log[2]*Log[1 - x])/12 - (Log[2]^3*Log[1 - x])/6 - 
      (Pi^2*Log[1 - x]^2)/24 + (Log[2]^2*Log[1 - x]^2)/4 - 
      (Log[2]*Log[1 - x]^3)/6 - PolyLog[4, 1/2] + PolyLog[4, (1 - x)/2] - 
      (7*Log[1 - x]*Zeta[3])/8, HPL[{1, 1, 1, 0}, x_] :> 
     -Pi^4/90 - (Pi^2*Log[1 - x]^2)/12 + PolyLog[4, 1 - x] - 
      Log[1 - x]*Zeta[3], HPL[{1, 1, 1, 1}, x_] :> Log[1 - x]^4/24}
