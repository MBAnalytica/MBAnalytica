(* ::Package:: *)

(* Created with the Wolfram Language for Students - Personal Use Only : www.wolfram.com *)
HPLBasis5={HPL[{-1, 1, -1, -1, -1}, x_] :>  -(Pi^2*Log[2]^3)/9 + Log[2]^5/6 - 
   (Log[2]^4*Log[1 + x])/24 - (Log[2]^2*Log[1 + x]^3)/6 + 
   (Log[2]*Log[1 - x]*Log[1 + x]^3)/6 + (Log[2]*Log[1 + x]^4)/6 - 
   (Log[1 - x]*Log[1 + x]^4)/6 + 
   Pi^2*(-Log[2]^3/18 + (Log[2]^2*Log[1 + x])/24 + Log[1 + x]^3/36) - 
   (Log[1 + x]^3*PolyLog[2, (1 - x)/2])/6 - 
   Log[1 + x]^2*PolyLog[3, (1 + x)/2] + 4*Log[2]*PolyLog[4, 1/2] + 
   3*Log[1 + x]*PolyLog[4, (1 + x)/2] + 4*PolyLog[5, 1/2] - 
   4*PolyLog[5, (1 + x)/2] + (7*Log[2]^2*Zeta[3])/4 + 
   ((7*Log[2]^2)/4 - (7*Log[2]*Log[1 + x])/8)*Zeta[3] + 
   Log[2]*((Pi^2*Log[2]^2)/6 - Log[2]^4/6 - 4*PolyLog[4, 1/2] - 
     (7*Log[2]*Zeta[3])/2) + Log[1 + x]*(-(Pi^2*Log[2]^2)/24 + Log[2]^4/24 + 
     PolyLog[4, 1/2] + (7*Log[2]*Zeta[3])/8), HPL[{-1, 1, -1, -1, 1}, x_] :>  
  (-6*HPL[{3, 2}, (1 - x)/2])/7 + (6*HPL[{3, 2}, (-1 + x)/(1 + x)])/7 - 
   (15*HPL[{3, 2}, (1 + x)/2])/7 + (Pi^2*Log[2]^3)/12 - (7*Log[2]^5)/60 - 
   (4*Pi^4*Log[1 - x])/105 + (31*Log[2]^4*Log[1 - x])/84 - 
   (Log[2]^3*Log[1 - x]^2)/2 + (71*Pi^4*Log[1 + x])/1440 - 
   (23*Log[2]^4*Log[1 + x])/56 - (10*Log[2]^3*Log[1 - x]*Log[1 + x])/21 + 
   (3*Log[2]^2*Log[1 - x]^2*Log[1 + x])/2 + (8*Log[2]^3*Log[1 + x]^2)/7 - 
   (11*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/14 - 
   (3*Log[2]*Log[1 - x]^2*Log[1 + x]^2)/2 - (5*Log[2]^2*Log[1 + x]^3)/7 + 
   (19*Log[2]*Log[1 - x]*Log[1 + x]^3)/14 + (Log[1 - x]^2*Log[1 + x]^3)/2 - 
   (3*Log[2]*Log[1 + x]^4)/28 - (13*Log[1 - x]*Log[1 + x]^4)/28 + 
   (4*Log[1 + x]^5)/35 + (Log[2]^3*PolyLog[2, (1 - x)/2])/6 - 
   (Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/2 + 
   (Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - 
   (3*Log[2]^2*PolyLog[3, (1 - x)/2])/7 + 
   (6*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/7 - 
   (3*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/7 + 
   Pi^2*((17*Log[2]^3)/126 - (29*Log[2]^2*Log[1 - x])/84 + 
     (11*Log[2]^2*Log[1 + x])/168 + (29*Log[2]*Log[1 - x]*Log[1 + x])/42 - 
     (19*Log[2]*Log[1 + x]^2)/42 - (29*Log[1 - x]*Log[1 + x]^2)/84 + 
     (5*Log[1 + x]^3)/21 - (Log[2]*PolyLog[2, (1 - x)/2])/12 + 
     (Log[1 + x]*PolyLog[2, (1 - x)/2])/12 + (4*PolyLog[3, (1 + x)/2])/21) - 
   (11*Log[2]^2*PolyLog[3, (1 + x)/2])/7 + 
   (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/7 + 
   3*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2] - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/7 - 
   (3*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/7 - PolyLog[2, (1 - x)/2]*
    PolyLog[3, (1 + x)/2] - 3*Log[2]*PolyLog[4, 1/2] - 
   (18*Log[2]*PolyLog[4, (1 - x)/2])/7 + 
   (18*Log[1 + x]*PolyLog[4, (1 - x)/2])/7 - 
   (18*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/7 + 
   (18*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/7 - 
   (45*Log[2]*PolyLog[4, (1 + x)/2])/7 + 
   (24*Log[1 - x]*PolyLog[4, (1 + x)/2])/7 - 3*PolyLog[5, 1/2] - 
   6*PolyLog[5, (1 + x)/2] + (431*Pi^2*Zeta[3])/672 - 
   (21*Log[2]^2*Zeta[3])/16 + ((-31*Log[2]^2)/8 + (191*Log[2]*Log[1 - x])/
      56 + (12*Log[2]*Log[1 + x])/7 - (191*Log[1 - x]*Log[1 + x])/56 + 
     (9*Log[1 + x]^2)/7 + (7*PolyLog[2, (1 - x)/2])/8)*Zeta[3] + 
   Log[2]*((-113*Pi^4)/10080 - (Pi^2*Log[2]^2)/8 + Log[2]^4/8 + 
     3*PolyLog[4, 1/2] + (21*Log[2]*Zeta[3])/8) - (9*Zeta[5])/448, 
 HPL[{-1, 1, -1, 1, 1}, x_] :>  -HPL[{3, 2}, (1 - x)/2] + (Pi^2*Log[2]^3)/12 - 
   (7*Log[2]^5)/30 - (Pi^4*Log[1 - x])/45 + (5*Log[2]^4*Log[1 - x])/12 + 
   (Log[2]^3*Log[1 - x]^2)/6 - (Log[2]^2*Log[1 - x]^3)/2 + 
   (Log[2]^4*Log[1 + x])/8 - (5*Log[2]^3*Log[1 - x]*Log[1 + x])/6 + 
   Log[2]*Log[1 - x]^3*Log[1 + x] + (Log[2]^2*Log[1 - x]*Log[1 + x]^2)/2 - 
   (Log[2]*Log[1 - x]^2*Log[1 + x]^2)/2 - (Log[1 - x]^3*Log[1 + x]^2)/2 + 
   (Log[1 - x]^2*Log[1 + x]^3)/3 - (Log[1 - x]*Log[1 + x]^4)/12 - 
   (Log[2]^3*PolyLog[2, (1 - x)/2])/6 + 
   (Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 - 
   (Log[1 - x]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/2 - 
   (Log[1 - x]*PolyLog[2, (1 - x)/2]^2)/2 + 
   Pi^2*((5*Log[2]^3)/36 - (Log[2]^2*Log[1 - x])/4 - 
     (Log[2]*Log[1 - x]^2)/6 - (Log[2]^2*Log[1 + x])/8 + 
     (5*Log[2]*Log[1 - x]*Log[1 + x])/12 + (Log[1 - x]^2*Log[1 + x])/6 - 
     (Log[1 - x]*Log[1 + x]^2)/6 + (Log[2]*PolyLog[2, (1 - x)/2])/12) + 
   PolyLog[2, (1 - x)/2]*PolyLog[3, (1 - x)/2] - 
   Log[1 - x]^2*PolyLog[3, (1 + x)/2] - 3*Log[2]*PolyLog[4, 1/2] - 
   3*Log[2]*PolyLog[4, (1 - x)/2] - 2*Log[1 - x]*PolyLog[4, (1 - x)/2] + 
   3*Log[1 + x]*PolyLog[4, (1 - x)/2] - 
   2*Log[1 - x]*PolyLog[4, (-1 + x)/(1 + x)] + 
   2*Log[1 - x]*PolyLog[4, (1 + x)/2] - 3*PolyLog[5, 1/2] + 
   (23*Pi^2*Zeta[3])/96 - (21*Log[2]^2*Zeta[3])/16 + 
   ((-11*Log[2]^2)/4 + (23*Log[2]*Log[1 - x])/8 + Log[1 - x]^2 + 
     (21*Log[2]*Log[1 + x])/8 - (23*Log[1 - x]*Log[1 + x])/8 - 
     (7*PolyLog[2, (1 - x)/2])/8)*Zeta[3] + 
   Log[1 + x]*((Pi^2*Log[2]^2)/8 - Log[2]^4/8 - 3*PolyLog[4, 1/2] - 
     (21*Log[2]*Zeta[3])/8) + Log[2]*(-Pi^4/1440 - (Pi^2*Log[2]^2)/8 + 
     Log[2]^4/8 + 3*PolyLog[4, 1/2] + (21*Log[2]*Zeta[3])/8) + 
   (23*Zeta[5])/64, HPL[{-1, 1, 1, -1, -1}, x_] :>  
  (-3*HPL[{3, 2}, (1 - x)/2])/7 + (3*HPL[{3, 2}, (-1 + x)/(1 + x)])/7 - 
   (4*HPL[{3, 2}, (1 + x)/2])/7 - (53*Pi^4*Log[2])/10080 + (7*Log[2]^5)/120 - 
   (2*Pi^4*Log[1 - x])/105 + (17*Log[2]^4*Log[1 - x])/168 - 
   (Log[2]^3*Log[1 - x]^2)/4 + (Pi^4*Log[1 + x])/48 - 
   (29*Log[2]^4*Log[1 + x])/56 + (25*Log[2]^3*Log[1 - x]*Log[1 + x])/42 + 
   (Log[2]^2*Log[1 - x]^2*Log[1 + x])/4 + (23*Log[2]^3*Log[1 + x]^2)/28 - 
   (39*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/28 - (5*Log[2]^2*Log[1 + x]^3)/14 + 
   (13*Log[2]*Log[1 - x]*Log[1 + x]^3)/14 - (3*Log[2]*Log[1 + x]^4)/56 - 
   (13*Log[1 - x]*Log[1 + x]^4)/56 + (2*Log[1 + x]^5)/35 + 
   (Log[2]^3*PolyLog[2, (1 - x)/2])/6 - Log[2]^2*Log[1 + x]*
    PolyLog[2, (1 - x)/2] + Log[2]*Log[1 - x]*Log[1 + x]*
    PolyLog[2, (1 - x)/2] + (Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/2 - 
   (3*Log[2]^2*PolyLog[3, (1 - x)/2])/14 + 
   (3*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/7 - 
   (5*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/7 + 
   Pi^2*(-Log[2]^3/504 - (11*Log[2]^2*Log[1 - x])/84 + 
     (5*Log[2]^2*Log[1 + x])/28 + (5*Log[2]*Log[1 - x]*Log[1 + x])/28 - 
     (13*Log[2]*Log[1 + x]^2)/42 - (Log[1 - x]*Log[1 + x]^2)/21 + 
     (5*Log[1 + x]^3)/42 - (Log[2]*PolyLog[2, (1 - x)/2])/12 + 
     (Log[1 + x]*PolyLog[2, (1 - x)/2])/6 + (2*PolyLog[3, (1 + x)/2])/21) - 
   (11*Log[2]^2*PolyLog[3, (1 + x)/2])/14 + 
   (4*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/7 + 
   Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2] - 
   (4*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/7 - 
   (3*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/14 - PolyLog[2, (1 - x)/2]*
    PolyLog[3, (1 + x)/2] - (9*Log[2]*PolyLog[4, (1 - x)/2])/7 + 
   (9*Log[1 + x]*PolyLog[4, (1 - x)/2])/7 - 
   (9*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/7 + 
   (9*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/7 - 
   (12*Log[2]*PolyLog[4, (1 + x)/2])/7 + 
   (12*Log[1 - x]*PolyLog[4, (1 + x)/2])/7 - 3*PolyLog[5, (1 + x)/2] + 
   (45*Pi^2*Zeta[3])/224 + ((-9*Log[2]^2)/16 + (71*Log[2]*Log[1 - x])/56 - 
     (Log[2]*Log[1 + x])/7 - (71*Log[1 - x]*Log[1 + x])/56 + 
     (8*Log[1 + x]^2)/7 + (7*PolyLog[2, (1 - x)/2])/8)*Zeta[3] - 
   (85*Zeta[5])/448, HPL[{-1, 1, 1, 1, -1}, x_] :>  
  (-10*HPL[{3, 2}, (1 - x)/2])/7 - (4*HPL[{3, 2}, (-1 + x)/(1 + x)])/7 - 
   (4*HPL[{3, 2}, (1 + x)/2])/7 + (Pi^2*Log[2]^3)/18 - (13*Log[2]^5)/60 - 
   (2*Pi^4*Log[1 - x])/105 + (13*Log[2]^4*Log[1 - x])/42 - 
   (Log[2]^3*Log[1 - x]^2)/4 + (Log[2]^2*Log[1 - x]^3)/6 + 
   (67*Log[2]^4*Log[1 + x])/168 - (31*Log[2]^3*Log[1 - x]*Log[1 + x])/42 + 
   (Log[2]^2*Log[1 - x]^2*Log[1 + x])/4 - (Log[2]*Log[1 - x]^3*Log[1 + x])/
    6 - (3*Log[2]^3*Log[1 + x]^2)/7 + (6*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/
    7 + (Log[2]^2*Log[1 + x]^3)/7 - (4*Log[2]*Log[1 - x]*Log[1 + x]^3)/7 + 
   (Log[2]*Log[1 + x]^4)/14 + (Log[1 - x]*Log[1 + x]^4)/7 - 
   (3*Log[1 + x]^5)/70 - (Log[2]^3*PolyLog[2, (1 - x)/2])/6 + 
   (Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/2 - 
   (Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/2 - 
   (3*Log[2]^2*PolyLog[3, (1 - x)/2])/14 + Log[2]*Log[1 - x]*
    PolyLog[3, (1 - x)/2] - (4*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/7 + 
   (2*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/7 + PolyLog[2, (1 - x)/2]*
    PolyLog[3, (1 - x)/2] + Pi^2*((19*Log[2]^3)/126 - 
     (11*Log[2]^2*Log[1 - x])/84 + (Log[2]*Log[1 - x]^2)/24 - 
     (47*Log[2]^2*Log[1 + x])/168 + (5*Log[2]*Log[1 - x]*Log[1 + x])/28 - 
     (Log[1 - x]^2*Log[1 + x])/24 + (4*Log[2]*Log[1 + x]^2)/21 - 
     (Log[1 - x]*Log[1 + x]^2)/21 - Log[1 + x]^3/21 + 
     (Log[2]*PolyLog[2, (1 - x)/2])/12 - (Log[1 - x]*PolyLog[2, (1 - x)/2])/
      12 + PolyLog[3, (1 - x)/2]/12 + (2*PolyLog[3, (1 + x)/2])/21) - 
   (2*Log[2]^2*PolyLog[3, (1 + x)/2])/7 + 
   (4*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/7 - 
   (4*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/7 + 
   (2*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/7 - 2*Log[2]*PolyLog[4, 1/2] - 
   (30*Log[2]*PolyLog[4, (1 - x)/2])/7 + 
   (23*Log[1 + x]*PolyLog[4, (1 - x)/2])/7 + 
   (12*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/7 - 
   (12*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/7 - 
   (12*Log[2]*PolyLog[4, (1 + x)/2])/7 + 
   (12*Log[1 - x]*PolyLog[4, (1 + x)/2])/7 - 2*PolyLog[5, 1/2] - 
   4*PolyLog[5, (1 - x)/2] - 4*PolyLog[5, (-1 + x)/(1 + x)] + 
   (59*Pi^2*Zeta[3])/224 - (7*Log[2]^2*Zeta[3])/8 + 
   ((-53*Log[2]^2)/16 + (113*Log[2]*Log[1 - x])/56 + 
     (209*Log[2]*Log[1 + x])/56 - (113*Log[1 - x]*Log[1 + x])/56 - 
     (6*Log[1 + x]^2)/7 - (7*PolyLog[2, (1 - x)/2])/8)*Zeta[3] + 
   Log[1 + x]*(-Pi^4/90 + (Pi^2*Log[2]^2)/24 - Log[2]^4/24 - 
     PolyLog[4, 1/2] - (7*Log[2]*Zeta[3])/8) + 
   Log[2]*((19*Pi^4)/630 - (Pi^2*Log[2]^2)/12 + Log[2]^4/12 + 
     2*PolyLog[4, 1/2] + (7*Log[2]*Zeta[3])/4) - (515*Zeta[5])/224, 
 HPL[{-1, 1, 1, 1, 1}, x_] :>  -(Pi^2*Log[2]^3)/24 + Log[2]^5/24 - 
   (Log[2]*Log[1 - x]^4)/24 + (Log[1 - x]^4*Log[1 + x])/24 + 
   (Log[1 - x]^3*PolyLog[2, (1 - x)/2])/6 - 
   (Log[1 - x]^2*PolyLog[3, (1 - x)/2])/2 + Log[2]*PolyLog[4, 1/2] + 
   Log[1 - x]*PolyLog[4, (1 - x)/2] + PolyLog[5, 1/2] - 
   PolyLog[5, (1 - x)/2] + (7*Log[2]^2*Zeta[3])/8 + 
   Log[2]*((Pi^2*Log[2]^2)/24 - Log[2]^4/24 - PolyLog[4, 1/2] - 
     (7*Log[2]*Zeta[3])/8), HPL[{-2, -1, -1, -1}, x_] :>  
  -(Pi^2*Log[1 + x]^3)/36 - (Log[x]*Log[1 + x]^4)/8 + Log[1 + x]^5/20 - 
   (Log[1 + x]^3*PolyLog[2, -x])/6 - (Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/
    2 - Log[1 + x]*PolyLog[4, (1 + x)^(-1)] - PolyLog[5, (1 + x)^(-1)] + 
   Zeta[5], HPL[{-2, -1, -1, 1}, x_] :>  HPL[{-2, -1, -1, 1}, x], 
 HPL[{-2, -1, 1, -1}, x_] :>  HPL[{-2, -1, 1, -1}, x], 
 HPL[{-2, -1, 1, 1}, x_] :>  HPL[{3, 2}, (1 - x)/2]/7 - 
   HPL[{3, 2}, (-1 + x)/(1 + x)]/7 - HPL[{3, 2}, (1 + x)/2]/7 - 
   HPL[{-3, -1, 1}, (1 - x)/(1 + x)] - HPL[{-2, -1, -1, 1}, x] - 
   HPL[{-2, -1, 1, -1}, x] - (Pi^2*Log[2]^3)/6 + (3*Log[2]^5)/10 + 
   HPL[{2, 1, -1}, -x]*Log[1 - x] - (11*Log[2]^4*Log[1 - x])/84 - 
   (Log[2]^4*Log[x])/12 + (Log[2]^3*Log[1 - x]*Log[x])/6 - 
   (Log[2]^2*Log[1 - x]^2*Log[x])/4 - HPL[{2, 1, -1}, -x]*Log[1 + x] - 
   (31*Log[2]^4*Log[1 + x])/84 + (11*Log[2]^3*Log[1 - x]*Log[1 + x])/21 - 
   (Log[2]^3*Log[x]*Log[1 + x])/6 + (Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/
    2 + (10*Log[2]^3*Log[1 + x]^2)/21 - (11*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/
    14 + (Log[2]^2*Log[x]*Log[1 + x]^2)/4 - 
   (Log[2]*Log[1 - x]*Log[x]*Log[1 + x]^2)/2 + 
   (Log[1 - x]^2*Log[x]*Log[1 + x]^2)/4 - (3*Log[2]^2*Log[1 + x]^3)/14 + 
   (11*Log[2]*Log[1 - x]*Log[1 + x]^3)/21 - (Log[1 - x]^2*Log[1 + x]^3)/12 - 
   (Log[2]*Log[x]*Log[1 + x]^3)/6 + (Log[1 - x]*Log[x]*Log[1 + x]^3)/6 - 
   (Log[2]*Log[1 + x]^4)/42 - (5*Log[1 - x]*Log[1 + x]^4)/56 - 
   (Log[x]*Log[1 + x]^4)/24 + (19*Log[1 + x]^5)/840 - 
   (Log[2]^3*PolyLog[2, -x])/3 + (Log[2]^2*Log[1 - x]*PolyLog[2, -x])/2 - 
   (Log[2]*Log[1 - x]^2*PolyLog[2, -x])/2 + 
   (Log[2]^2*Log[1 + x]*PolyLog[2, -x])/2 + 
   (Log[1 - x]^2*Log[1 + x]*PolyLog[2, -x])/2 - 
   (Log[2]*Log[1 + x]^2*PolyLog[2, -x])/2 - 
   (3*Log[2]^2*PolyLog[3, (1 - x)/2])/7 + 
   (6*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/7 + 
   Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/2] - 
   (3*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/7 + 
   PolyLog[2, -x]*PolyLog[3, (1 - x)/2] + 
   (Log[1 - x]^2*PolyLog[3, (1 + x)^(-1)])/2 + 
   Pi^2*((-5*Log[2]^3)/84 + (13*Log[2]^2*Log[1 - x])/84 - 
     (Log[2]*Log[1 - x]^2)/24 + (Log[2]^2*Log[x])/12 - 
     (Log[2]*Log[1 - x]*Log[x])/12 + (Log[2]^2*Log[1 + x])/42 + 
     (Log[2]*Log[1 - x]*Log[1 + x])/42 + (Log[1 - x]^2*Log[1 + x])/12 + 
     (Log[2]*Log[x]*Log[1 + x])/12 - (9*Log[2]*Log[1 + x]^2)/56 - 
     (3*Log[1 - x]*Log[1 + x]^2)/56 - (Log[x]*Log[1 + x]^2)/12 + 
     (29*Log[1 + x]^3)/504 + (Log[2]*PolyLog[2, -x])/6 - 
     (Log[1 - x]*PolyLog[2, -x])/12 - (Log[1 + x]*PolyLog[2, -x])/12 + 
     PolyLog[3, (1 - x)/2]/12 + (3*PolyLog[3, (1 + x)/2])/28) - 
   (4*Log[2]^2*PolyLog[3, (1 + x)/2])/7 + 
   (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/7 + 
   Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2] - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/7 + 
   Log[x]*Log[1 + x]*PolyLog[3, (1 + x)/2] - 
   (3*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/7 + 
   PolyLog[2, -x]*PolyLog[3, (1 + x)/2] + 6*Log[2]*PolyLog[4, 1/2] - 
   (4*Log[2]*PolyLog[4, (1 - x)/2])/7 - Log[x]*PolyLog[4, (1 - x)/2] + 
   (4*Log[1 + x]*PolyLog[4, (1 - x)/2])/7 + 
   Log[1 - x]*PolyLog[4, (1 + x)^(-1)] - 
   (4*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/7 - 
   Log[x]*PolyLog[4, (-1 + x)/(1 + x)] + 
   (4*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/7 - 
   (10*Log[2]*PolyLog[4, (1 + x)/2])/7 + (3*Log[1 - x]*PolyLog[4, (1 + x)/2])/
    7 - Log[x]*PolyLog[4, (1 + x)/2] + Log[1 + x]*PolyLog[4, (1 + x)/2] + 
   6*PolyLog[5, 1/2] + PolyLog[5, (1 + x)^(-1)] - 2*PolyLog[5, (1 + x)/2] - 
   (19*Pi^2*Zeta[3])/336 + (21*Log[2]^2*Zeta[3])/8 + 
   ((7*Log[2]^2)/8 - (41*Log[2]*Log[1 - x])/28 - (7*Log[1 - x]^2)/16 - 
     (7*Log[2]*Log[x])/4 + (Log[1 - x]*Log[x])/8 + (41*Log[2]*Log[1 + x])/
      28 + (33*Log[1 - x]*Log[1 + x])/56 - (Log[x]*Log[1 + x])/8 - 
     (17*Log[1 + x]^2)/112 - (7*PolyLog[2, -x])/4)*Zeta[3] + 
   Log[2]*((37*Pi^4)/1008 + (Pi^2*Log[2]^2)/6 - Log[2]^4/6 - 
     4*PolyLog[4, 1/2] - (7*Log[2]*Zeta[3])/2) + 
   Log[1 + x]*(Pi^4/72 + (Pi^2*Log[2]^2)/24 - Log[2]^4/24 - PolyLog[4, 1/2] - 
     (7*Log[2]*Zeta[3])/8) + Log[1 - x]*((-61*Pi^4)/2520 - 
     (Pi^2*Log[2]^2)/24 + Log[2]^4/24 + PolyLog[4, 1/2] + 
     (7*Log[2]*Zeta[3])/8) + Log[x]*((-7*Pi^4)/720 - (Pi^2*Log[2]^2)/12 + 
     Log[2]^4/12 + 2*PolyLog[4, 1/2] + (7*Log[2]*Zeta[3])/4) - 
   (627*Zeta[5])/112, HPL[{-2, -2, -1}, x_] :>  -HPL[{3, 2}, (1 + x)^(-1)] - 
   (Pi^4*Log[x])/30 - (Pi^4*Log[1 + x])/360 + (7*Log[x]*Log[1 + x]^4)/24 - 
   (19*Log[1 + x]^5)/120 + (Log[x]*Log[1 + x]^2*PolyLog[2, -x])/2 - 
   (Log[1 + x]^3*PolyLog[2, -x])/6 + (Log[1 + x]*PolyLog[2, -x]^2)/2 + 
   Log[1 + x]^2*PolyLog[3, -x] + Pi^2*(-(Log[x]*Log[1 + x]^2)/12 + 
     (5*Log[1 + x]^3)/36 + (Log[1 + x]*PolyLog[2, -x])/6 + 
     PolyLog[3, (1 + x)^(-1)]/6) + Log[x]*Log[1 + x]*
    PolyLog[3, (1 + x)^(-1)] - (Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/2 + 
   PolyLog[2, -x]*PolyLog[3, (1 + x)^(-1)] - 2*Log[1 + x]*PolyLog[4, -x] + 
   3*Log[x]*PolyLog[4, (1 + x)^(-1)] - 5*Log[1 + x]*
    PolyLog[4, (1 + x)^(-1)] - 2*Log[1 + x]*PolyLog[4, x/(1 + x)] - 
   7*PolyLog[5, (1 + x)^(-1)] + (Pi^2*Zeta[3])/3 + 
   (2*Log[x]*Log[1 + x] - 2*Log[1 + x]^2 - PolyLog[2, -x])*Zeta[3] + 
   (3*Zeta[5])/2, HPL[{-2, 1, -1, -1}, x_] :>  -HPL[{-4, 1}, -x]/2 + 
   HPL[{-4, 1}, (-1 + x)/(1 + x)]/2 + HPL[{3, 2}, (1 - x)/2]/14 + 
   HPL[{3, 2}, -x]/14 + HPL[{3, 2}, (1 + x)^(-1)]/14 - 
   HPL[{3, 2}, (-1 + x)/(1 + x)]/14 - HPL[{3, 2}, x/(1 + x)]/14 - 
   HPL[{3, 2}, (1 + x)/2]/14 - HPL[{-2, -1, -1, 1}, x] - 
   HPL[{-2, -1, 1, -1}, x] + (Pi^2*Log[2]^3)/12 - Log[2]^5/8 - 
   (Log[2]^4*Log[1 - x])/336 + (Pi^4*Log[x])/420 + 
   (Log[2]^4*Log[1 + x])/336 + (Log[2]^3*Log[1 - x]*Log[1 + x])/84 + 
   (9*Log[2]^3*Log[1 + x]^2)/28 - (15*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/56 + 
   (Log[2]*Log[1 - x]^2*Log[1 + x]^2)/4 - (Log[1 - x]^3*Log[1 + x]^2)/12 + 
   (Log[1 - x]^2*Log[x]*Log[1 + x]^2)/4 - (27*Log[2]^2*Log[1 + x]^3)/56 + 
   (Log[2]*Log[1 - x]*Log[1 + x]^3)/84 + (61*Log[2]*Log[1 + x]^4)/168 - 
   (43*Log[1 - x]*Log[1 + x]^4)/336 + (7*Log[x]*Log[1 + x]^4)/48 - 
   (253*Log[1 + x]^5)/1680 + (Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/2 + 
   (Log[2]^2*PolyLog[3, (1 - x)/2])/28 - 
   (Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/14 - 
   (13*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/28 + 
   (Log[1 + x]^2*PolyLog[3, 1 - x])/2 - (13*Log[1 + x]^2*PolyLog[3, -x])/28 + 
   (Log[1 + x]^2*PolyLog[3, x])/2 + (Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/
    2 + Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)] - 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/14 + 
   (Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/14 + 
   Pi^2*((5*Log[2]^3)/126 - (Log[2]^2*Log[1 - x])/168 + 
     (Log[2]^2*Log[1 + x])/84 + (Log[2]*Log[1 - x]*Log[1 + x])/84 - 
     (31*Log[2]*Log[1 + x]^2)/168 - (Log[1 - x]*Log[1 + x]^2)/168 + 
     (Log[x]*Log[1 + x]^2)/168 + (113*Log[1 + x]^3)/504 - 
     PolyLog[3, (1 + x)^(-1)]/84 + PolyLog[3, (1 + x)/2]/84) - 
   (Log[2]^2*PolyLog[3, (1 + x)/2])/28 + 
   (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/14 - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/14 + 
   (Log[1 + x]^2*PolyLog[3, (1 + x)/2])/28 - 3*Log[2]*PolyLog[4, 1/2] + 
   (3*Log[2]*PolyLog[4, (1 - x)/2])/14 - (3*Log[1 + x]*PolyLog[4, (1 - x)/2])/
    14 + Log[1 + x]*PolyLog[4, 1 - x] + (2*Log[1 + x]*PolyLog[4, -x])/7 - 
   (Log[1 + x]*PolyLog[4, (4*x)/(1 + x)^2])/4 + 
   Log[1 - x]*PolyLog[4, (1 + x)^(-1)] - (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/
    14 - (11*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/14 - 
   (Log[2]*PolyLog[4, (1 - x)/(1 + x)])/2 + 
   (3*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/14 + 
   (2*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/7 - 
   (3*Log[1 + x]*PolyLog[4, x/(1 + x)])/14 + 
   Log[1 + x]*PolyLog[4, (2*x)/(1 + x)] - (3*Log[2]*PolyLog[4, (1 + x)/2])/
    14 + (3*Log[1 - x]*PolyLog[4, (1 + x)/2])/14 - 
   3*Log[1 + x]*PolyLog[4, (1 + x)/2] - (Log[1 + x]*PolyLog[4, 1 - x^2])/4 - 
   3*PolyLog[5, 1/2] + PolyLog[5, (1 - x)/2]/2 - PolyLog[5, 1 - x] + 
   PolyLog[5, -x]/4 - (3*PolyLog[5, x])/4 - PolyLog[5, (4*x)/(1 + x)^2]/8 + 
   PolyLog[5, (1 + x)^(-1)]/2 + (3*PolyLog[5, (1 - x)/(1 + x)])/4 - 
   PolyLog[5, (-1 + x)/(1 + x)]/4 - PolyLog[5, x/(1 + x)]/2 + 
   PolyLog[5, (2*x)/(1 + x)] + (5*PolyLog[5, (1 + x)/2])/2 + 
   PolyLog[5, 1 - x^2]/8 - (7*Pi^2*Zeta[3])/96 - (21*Log[2]^2*Zeta[3])/16 + 
   ((-21*Log[2]^2)/16 + (Log[2]*Log[1 - x])/7 - (Log[2]*Log[1 + x])/7 - 
     (Log[1 - x]*Log[1 + x])/7 - (Log[x]*Log[1 + x])/7 + (3*Log[1 + x]^2)/28)*
    Zeta[3] + Log[1 - x]*(-Pi^4/420 + (Pi^2*Log[2]^2)/24 - Log[2]^4/24 - 
     PolyLog[4, 1/2] - (7*Log[2]*Zeta[3])/8) + 
   Log[1 + x]*(Pi^4/168 - (Pi^2*Log[2]^2)/24 + Log[2]^4/24 + 
     PolyLog[4, 1/2] + (7*Log[2]*Zeta[3])/8) + 
   Log[2]*(-Pi^4/560 - (Pi^2*Log[2]^2)/8 + Log[2]^4/8 + 3*PolyLog[4, 1/2] + 
     (21*Log[2]*Zeta[3])/8) + (7*Zeta[5])/8, HPL[{-2, 1, -1, 1}, x_] :>  
  HPL[{-4, 1}, -x]/2 + HPL[{-4, 1}, (1 - x)/(1 + x)] + 
   (5*HPL[{-4, 1}, (-1 + x)/(1 + x)])/2 + HPL[{3, -2}, (1 - x)/(1 + x)]/2 + 
   HPL[{3, -2}, (-1 + x)/(1 + x)]/2 + (5*HPL[{3, 2}, (1 - x)/2])/7 - 
   HPL[{3, 2}, -x]/14 - HPL[{3, 2}, (1 + x)^(-1)]/14 + 
   (2*HPL[{3, 2}, (-1 + x)/(1 + x)])/7 + HPL[{3, 2}, x/(1 + x)]/14 + 
   (9*HPL[{3, 2}, (1 + x)/2])/7 + (3*HPL[{-3, -1, 1}, (1 - x)/(1 + x)])/2 + 
   HPL[{-2, 1, -2}, (1 - x)/(1 + x)]/2 - HPL[{2, -2, -1}, (1 - x)/(1 + x)]/
    2 + HPL[{-2, -1, -1, 1}, -x]/2 + HPL[{-2, -1, -1, 1}, x]/2 + 
   HPL[{-2, -1, 1, -1}, x] + (Pi^2*Log[2]^3)/18 - (17*Log[2]^5)/60 - 
   HPL[{2, 1, -1}, -x]*Log[1 - x] + (69*Log[2]^4*Log[1 - x])/112 - 
   (5*Log[2]^3*Log[1 - x]^2)/8 + (13*Log[2]^2*Log[1 - x]^3)/24 - 
   (Log[2]*Log[1 - x]^4)/6 + (Log[2]^4*Log[x])/8 - 
   (5*Log[2]^3*Log[1 - x]*Log[x])/12 + (Log[2]^2*Log[1 - x]^2*Log[x])/4 + 
   (Log[2]*Log[1 - x]^3*Log[x])/3 + HPL[{2, 1, -1}, -x]*Log[1 + x] + 
   (199*Log[2]^4*Log[1 + x])/336 - (17*Log[2]^3*Log[1 - x]*Log[1 + x])/14 + 
   (Log[2]^2*Log[1 - x]^2*Log[1 + x])/4 - (5*Log[2]*Log[1 - x]^3*Log[1 + x])/
    12 + (Log[1 - x]^4*Log[1 + x])/6 + (5*Log[2]^3*Log[x]*Log[1 + x])/12 - 
   (3*Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/4 - 
   (Log[1 - x]^3*Log[x]*Log[1 + x])/2 - (51*Log[2]^3*Log[1 + x]^2)/56 + 
   (51*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/28 + 
   (Log[2]*Log[1 - x]^2*Log[1 + x]^2)/8 - (Log[1 - x]^3*Log[1 + x]^2)/24 - 
   Log[2]^2*Log[x]*Log[1 + x]^2 + (3*Log[2]*Log[1 - x]*Log[x]*Log[1 + x]^2)/
    4 + (3*Log[1 - x]^2*Log[x]*Log[1 + x]^2)/8 + (31*Log[2]^2*Log[1 + x]^3)/
    56 - (17*Log[2]*Log[1 - x]*Log[1 + x]^3)/14 + 
   (Log[1 - x]^2*Log[1 + x]^3)/6 + (2*Log[2]*Log[x]*Log[1 + x]^3)/3 - 
   (2*Log[1 - x]*Log[x]*Log[1 + x]^3)/3 - (13*Log[2]*Log[1 + x]^4)/168 + 
   (11*Log[1 - x]*Log[1 + x]^4)/42 + (Log[x]*Log[1 + x]^4)/48 - 
   Log[1 + x]^5/24 - (2*Log[2]^3*PolyLog[2, (1 - x)/2])/3 + 
   (3*Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/4 - 
   (Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/4 + 
   (Log[1 - x]^3*PolyLog[2, (1 - x)/2])/12 - 
   (Log[1 - x]^2*Log[x]*PolyLog[2, (1 - x)/2])/4 + 
   (5*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/4 - 
   Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2] + 
   (Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/2 - 
   (3*Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/4 + 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - 
   (Log[x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/4 + 
   (Log[1 + x]^3*PolyLog[2, (1 - x)/2])/12 - (Log[2]*PolyLog[2, (1 - x)/2]^2)/
    2 + (Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/2 + (11*Log[2]^3*PolyLog[2, -x])/
    12 - (5*Log[2]^2*Log[1 - x]*PolyLog[2, -x])/4 + 
   Log[2]*Log[1 - x]^2*PolyLog[2, -x] - 
   (3*Log[2]^2*Log[1 + x]*PolyLog[2, -x])/2 + 
   (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, -x])/2 - 
   Log[1 - x]^2*Log[1 + x]*PolyLog[2, -x] + 
   (5*Log[2]*Log[1 + x]^2*PolyLog[2, -x])/4 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/4 - (Log[1 + x]^3*PolyLog[2, -x])/
    12 + (Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/2 - 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/2 - 
   (5*Log[2]^3*PolyLog[2, x])/12 + (Log[2]^2*Log[1 - x]*PolyLog[2, x])/2 - 
   (Log[2]*Log[1 - x]^2*PolyLog[2, x])/4 + 
   (3*Log[2]^2*Log[1 + x]*PolyLog[2, x])/4 - 
   (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, x])/2 - 
   (Log[2]*Log[1 + x]^2*PolyLog[2, x])/2 + 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/4 + (Log[1 + x]^3*PolyLog[2, x])/
    12 - (Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/2 + 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/2 + 
   (31*Log[2]^2*PolyLog[3, (1 - x)/2])/28 - Log[2]*Log[1 - x]*
    PolyLog[3, (1 - x)/2] + (Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/2])/2 - 
   (17*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/14 + 
   Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/2] - 
   2*Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/2] + 
   (17*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/28 - 
   2*PolyLog[2, -x]*PolyLog[3, (1 - x)/2] + 
   (PolyLog[2, x]*PolyLog[3, (1 - x)/2])/2 + 
   (Log[2]*Log[1 - x]*PolyLog[3, 1 - x])/2 - 
   (Log[2]*Log[1 + x]*PolyLog[3, 1 - x])/2 - Log[1 - x]*Log[1 + x]*
    PolyLog[3, 1 - x] + (Log[1 + x]^2*PolyLog[3, 1 - x])/4 + 
   (Log[2]^2*PolyLog[3, -x])/4 - Log[2]*Log[1 - x]*PolyLog[3, -x] + 
   (Log[2]*Log[1 + x]*PolyLog[3, -x])/2 + Log[1 - x]*Log[1 + x]*
    PolyLog[3, -x] - (2*Log[1 + x]^2*PolyLog[3, -x])/7 + 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, -x])/2 - (Log[2]^2*PolyLog[3, x])/4 + 
   Log[2]*Log[1 - x]*PolyLog[3, x] - (Log[2]*Log[1 + x]*PolyLog[3, x])/2 - 
   Log[1 - x]*Log[1 + x]*PolyLog[3, x] + (Log[1 + x]^2*PolyLog[3, x])/4 - 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, x])/2 - 
   (Log[2]^2*PolyLog[3, (2*x)/(-1 + x)])/4 + Log[2]*Log[1 - x]*
    PolyLog[3, (2*x)/(-1 + x)] - 
   (Log[2]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/2 - 
   Log[1 - x]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] + 
   (Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/4 - 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (2*x)/(-1 + x)])/2 - 
   (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)])/2 - 
   Log[1 - x]^2*PolyLog[3, (1 + x)^(-1)] + 
   (Log[2]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/2 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/2 + 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/14 - 
   (9*Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/28 - 
   (3*Log[2]^2*PolyLog[3, (1 - x)/(1 + x)])/4 + 
   (3*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/2 - 
   (3*Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)])/4 - 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (1 - x)/(1 + x)])/2 + 
   Pi^2*((71*Log[2]^3)/1008 - (97*Log[2]^2*Log[1 - x])/336 - 
     Log[1 - x]^3/72 - (5*Log[2]^2*Log[x])/48 + (Log[2]*Log[1 - x]*Log[x])/
      6 + (Log[1 - x]^2*Log[x])/48 - (Log[2]^2*Log[1 + x])/21 + 
     (2*Log[2]*Log[1 - x]*Log[1 + x])/7 - (5*Log[2]*Log[x]*Log[1 + x])/24 - 
     (Log[1 - x]*Log[x]*Log[1 + x])/12 + (15*Log[2]*Log[1 + x]^2)/112 - 
     (19*Log[1 - x]*Log[1 + x]^2)/84 + (17*Log[x]*Log[1 + x]^2)/84 + 
     Log[1 + x]^3/504 + (5*Log[2]*PolyLog[2, (1 - x)/2])/24 + 
     (Log[1 - x]*PolyLog[2, (1 - x)/2])/12 + (Log[x]*PolyLog[2, (1 - x)/2])/
      24 - (7*Log[1 + x]*PolyLog[2, (1 - x)/2])/24 - 
     (3*Log[2]*PolyLog[2, -x])/8 + (Log[1 - x]*PolyLog[2, -x])/6 + 
     (5*Log[1 + x]*PolyLog[2, -x])/24 + (Log[2]*PolyLog[2, x])/8 - 
     (Log[1 - x]*PolyLog[2, x])/24 - (Log[1 + x]*PolyLog[2, x])/12 - 
     PolyLog[3, (1 - x)/2]/3 + PolyLog[3, 1 - x]/24 - PolyLog[3, -x]/12 + 
     PolyLog[3, x]/12 + PolyLog[3, (2*x)/(-1 + x)]/12 - 
     (5*PolyLog[3, (1 + x)^(-1)])/168 - (13*PolyLog[3, (1 + x)/2])/28) + 
   (53*Log[2]^2*PolyLog[3, (1 + x)/2])/28 - 
   (9*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/7 + 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 + x)/2])/2 - 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2])/2 + 
   (9*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/7 - 
   2*Log[x]*Log[1 + x]*PolyLog[3, (1 + x)/2] + 
   (17*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/28 + PolyLog[2, (1 - x)/2]*
    PolyLog[3, (1 + x)/2] - 2*PolyLog[2, -x]*PolyLog[3, (1 + x)/2] + 
   (PolyLog[2, x]*PolyLog[3, (1 + x)/2])/2 - 2*Log[2]*PolyLog[4, 1/2] + 
   (65*Log[2]*PolyLog[4, (1 - x)/2])/14 + (3*Log[x]*PolyLog[4, (1 - x)/2])/
    2 - (65*Log[1 + x]*PolyLog[4, (1 - x)/2])/14 - 
   2*Log[2]*PolyLog[4, 1 - x] - Log[1 - x]*PolyLog[4, 1 - x] + 
   (5*Log[1 + x]*PolyLog[4, 1 - x])/2 - (Log[1 - x]*PolyLog[4, -x])/2 + 
   (3*Log[1 + x]*PolyLog[4, -x])/14 + (Log[1 - x]*PolyLog[4, x])/2 - 
   (Log[1 + x]*PolyLog[4, x])/2 + (Log[1 - x]*PolyLog[4, (4*x)/(1 + x)^2])/
    4 + 2*Log[2]*PolyLog[4, (1 + x)^(-1)] + 
   (Log[1 - x]*PolyLog[4, (1 + x)^(-1)])/2 + 
   (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/14 - 
   (31*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/14 + 
   (Log[2]*PolyLog[4, (1 - x)/(1 + x)])/2 + 
   (Log[1 - x]*PolyLog[4, (1 - x)/(1 + x)])/2 - 
   (Log[1 + x]*PolyLog[4, (1 - x)/(1 + x)])/2 + 
   (9*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/14 - 
   (Log[1 - x]*PolyLog[4, (-1 + x)/(1 + x)])/2 + 
   2*Log[x]*PolyLog[4, (-1 + x)/(1 + x)] - 
   (9*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/14 + 
   (3*Log[1 + x]*PolyLog[4, x/(1 + x)])/14 - 
   Log[1 - x]*PolyLog[4, (2*x)/(1 + x)] + (89*Log[2]*PolyLog[4, (1 + x)/2])/
    14 - (6*Log[1 - x]*PolyLog[4, (1 + x)/2])/7 + 
   (3*Log[x]*PolyLog[4, (1 + x)/2])/2 - (5*Log[1 + x]*PolyLog[4, (1 + x)/2])/
    2 + (Log[2]*PolyLog[4, 1 - x^2])/4 + (Log[1 - x]*PolyLog[4, 1 - x^2])/4 - 
   (Log[1 + x]*PolyLog[4, 1 - x^2])/4 - 2*PolyLog[5, 1/2] + 
   (7*PolyLog[5, (1 - x)/2])/2 - (3*PolyLog[5, 1 - x])/2 - PolyLog[5, -x]/4 + 
   (3*PolyLog[5, x])/4 + PolyLog[5, (4*x)/(1 + x)^2]/8 - 
   2*PolyLog[5, (1 + x)^(-1)] + (3*PolyLog[5, (1 - x)/(1 + x)])/2 + 
   2*PolyLog[5, (-1 + x)/(1 + x)] + PolyLog[5, x/(1 + x)]/2 - 
   PolyLog[5, (2*x)/(1 + x)] + (9*PolyLog[5, (1 + x)/2])/2 - 
   (Pi^2*Zeta[3])/14 - (7*Log[2]^2*Zeta[3])/8 + 
   ((53*Log[2]^2)/16 + (153*Log[2]*Log[1 - x])/112 + (7*Log[1 - x]^2)/8 + 
     (21*Log[2]*Log[x])/8 - (3*Log[1 - x]*Log[x])/4 - 
     (503*Log[2]*Log[1 + x])/112 + (23*Log[1 - x]*Log[1 + x])/28 + 
     (25*Log[x]*Log[1 + x])/28 - (11*Log[1 + x]^2)/112 - 
     PolyLog[2, (1 - x)/2]/8 + (57*PolyLog[2, -x])/16 - 
     (15*PolyLog[2, x])/16)*Zeta[3] + 
   Log[x]*((137*Pi^4)/10080 + (Pi^2*Log[2]^2)/8 - Log[2]^4/8 - 
     3*PolyLog[4, 1/2] - (21*Log[2]*Zeta[3])/8) + 
   Log[1 - x]*((271*Pi^4)/10080 + (5*Pi^2*Log[2]^2)/48 - (5*Log[2]^4)/48 - 
     (5*PolyLog[4, 1/2])/2 - (35*Log[2]*Zeta[3])/16) + 
   Log[2]*((-197*Pi^4)/2016 + (Pi^2*Log[2]^2)/24 - Log[2]^4/24 - 
     PolyLog[4, 1/2] - (7*Log[2]*Zeta[3])/8) + 
   Log[1 + x]*((37*Pi^4)/2016 - (5*Pi^2*Log[2]^2)/48 + (5*Log[2]^4)/48 + 
     (5*PolyLog[4, 1/2])/2 + (35*Log[2]*Zeta[3])/16) + (367*Zeta[5])/56, 
 HPL[{-2, 1, -2}, x_] :>  HPL[{-2, 1, -2}, x], HPL[{-2, 1, 1, -1}, x_] :>  
  -HPL[{-4, 1}, x]/2 - 2*HPL[{-4, 1}, (1 - x)/(1 + x)] - 
   3*HPL[{-4, 1}, (-1 + x)/(1 + x)] - HPL[{3, -2}, (1 - x)/(1 + x)]/2 - 
   HPL[{3, -2}, (-1 + x)/(1 + x)]/2 - (15*HPL[{3, 2}, (1 - x)/2])/14 - 
   HPL[{3, 2}, 1 - x]/14 + HPL[{3, 2}, x]/14 - HPL[{3, 2}, x/(-1 + x)]/14 + 
   HPL[{3, 2}, (-1 + x)/(1 + x)]/14 - (13*HPL[{3, 2}, (1 + x)/2])/14 - 
   HPL[{-3, -1, 1}, (1 - x)/(1 + x)]/2 - HPL[{-2, 1, -2}, (1 - x)/(1 + x)]/
    2 + HPL[{2, -2, -1}, (1 - x)/(1 + x)]/2 - HPL[{-2, -1, -1, 1}, -x]/2 + 
   HPL[{-2, -1, -1, 1}, x]/2 + (Pi^2*Log[2]^3)/9 - Log[2]^5/60 - 
   (19*Log[2]^4*Log[1 - x])/84 + (3*Log[2]^3*Log[1 - x]^2)/8 - 
   (7*Log[2]^2*Log[1 - x]^3)/24 + (Log[2]*Log[1 - x]^4)/24 + 
   (11*Log[1 - x]^5)/560 - (Log[2]^4*Log[x])/24 + 
   (Log[2]^3*Log[1 - x]*Log[x])/4 - (Log[2]*Log[1 - x]^3*Log[x])/6 - 
   (Log[1 - x]^4*Log[x])/42 - (53*Log[2]^4*Log[1 + x])/168 + 
   (13*Log[2]^3*Log[1 - x]*Log[1 + x])/84 + (Log[2]*Log[1 - x]^3*Log[1 + x])/
    12 + (Log[1 - x]^4*Log[1 + x])/32 - (Log[2]^3*Log[x]*Log[1 + x])/4 - 
   (Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/2 + 
   (Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/4 - 
   (Log[1 - x]^3*Log[x]*Log[1 + x])/12 + (65*Log[2]^3*Log[1 + x]^2)/168 - 
   (13*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/56 - 
   (Log[2]*Log[1 - x]^2*Log[1 + x]^2)/8 + (3*Log[2]^2*Log[x]*Log[1 + x]^2)/
    4 + (Log[2]*Log[1 - x]*Log[x]*Log[1 + x]^2)/4 - 
   (Log[1 - x]^2*Log[x]*Log[1 + x]^2)/8 - (Log[2]^2*Log[1 + x]^3)/7 + 
   (13*Log[2]*Log[1 - x]*Log[1 + x]^3)/84 - (Log[1 - x]^2*Log[1 + x]^3)/16 - 
   (2*Log[2]*Log[x]*Log[1 + x]^3)/3 + (5*Log[1 - x]*Log[x]*Log[1 + x]^3)/12 - 
   (Log[2]*Log[1 + x]^4)/14 - (13*Log[1 - x]*Log[1 + x]^4)/336 - 
   (Log[x]*Log[1 + x]^4)/6 + (767*Log[1 + x]^5)/3360 + 
   (2*Log[2]^3*PolyLog[2, (1 - x)/2])/3 - 
   (3*Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/4 + 
   (Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/4 - 
   (Log[1 - x]^3*PolyLog[2, (1 - x)/2])/12 + 
   (Log[1 - x]^2*Log[x]*PolyLog[2, (1 - x)/2])/4 - 
   (5*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/4 + 
   Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2] - 
   (Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/2 + 
   (3*Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/4 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 + 
   (Log[x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/4 - 
   (Log[1 + x]^3*PolyLog[2, (1 - x)/2])/12 + (Log[2]*PolyLog[2, (1 - x)/2]^2)/
    2 - (Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/2 - (7*Log[2]^3*PolyLog[2, -x])/
    12 + (3*Log[2]^2*Log[1 - x]*PolyLog[2, -x])/4 - 
   (Log[2]*Log[1 - x]^2*PolyLog[2, -x])/2 + Log[2]^2*Log[1 + x]*
    PolyLog[2, -x] - (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, -x])/2 - 
   (3*Log[2]*Log[1 + x]^2*PolyLog[2, -x])/4 + 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/4 + (Log[1 + x]^3*PolyLog[2, -x])/
    12 - (Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/2 + 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/2 + 
   (5*Log[2]^3*PolyLog[2, x])/12 - (Log[2]^2*Log[1 - x]*PolyLog[2, x])/2 + 
   (Log[2]*Log[1 - x]^2*PolyLog[2, x])/4 - 
   (3*Log[2]^2*Log[1 + x]*PolyLog[2, x])/4 + 
   (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, x])/2 + 
   (Log[2]*Log[1 + x]^2*PolyLog[2, x])/2 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/4 - (Log[1 + x]^3*PolyLog[2, x])/
    12 + (Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/2 - 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/2 - 
   (11*Log[2]^2*PolyLog[3, (1 - x)/2])/14 + Log[2]*Log[1 - x]*
    PolyLog[3, (1 - x)/2] - (Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/2])/2 + 
   (4*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/7 + 
   Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/2] - 
   (2*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/7 + 
   PolyLog[2, -x]*PolyLog[3, (1 - x)/2] - 
   (PolyLog[2, x]*PolyLog[3, (1 - x)/2])/2 - 
   (Log[2]*Log[1 - x]*PolyLog[3, 1 - x])/2 + (Log[1 - x]^2*PolyLog[3, 1 - x])/
    28 - (Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/14 + 
   (Log[2]*Log[1 + x]*PolyLog[3, 1 - x])/2 - (Log[1 + x]^2*PolyLog[3, 1 - x])/
    4 - (Log[2]^2*PolyLog[3, -x])/4 + Log[2]*Log[1 - x]*PolyLog[3, -x] - 
   (Log[2]*Log[1 + x]*PolyLog[3, -x])/2 + (Log[1 + x]^2*PolyLog[3, -x])/4 - 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, -x])/2 + (Log[2]^2*PolyLog[3, x])/4 - 
   Log[2]*Log[1 - x]*PolyLog[3, x] + (Log[1 - x]^2*PolyLog[3, x])/28 + 
   (Log[2]*Log[1 + x]*PolyLog[3, x])/2 - (Log[1 + x]^2*PolyLog[3, x])/4 + 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, x])/2 + 
   (Log[2]^2*PolyLog[3, (2*x)/(-1 + x)])/4 - Log[2]*Log[1 - x]*
    PolyLog[3, (2*x)/(-1 + x)] + 
   (Log[2]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/2 - 
   (Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/4 + 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (2*x)/(-1 + x)])/2 + 
   (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)])/2 - 
   (Log[2]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/2 - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/2 + 
   (Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/4 + 
   (3*Log[2]^2*PolyLog[3, (1 - x)/(1 + x)])/4 - 
   (3*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/2 + 
   (3*Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)])/4 + 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (1 - x)/(1 + x)])/2 + 
   Pi^2*((-5*Log[2]^3)/1008 - (11*Log[2]^2*Log[1 - x])/112 + 
     (Log[2]*Log[1 - x]^2)/24 + Log[1 - x]^3/126 + (Log[2]^2*Log[x])/48 - 
     (Log[2]*Log[1 - x]*Log[x])/12 + (5*Log[1 - x]^2*Log[x])/336 + 
     (Log[2]^2*Log[1 + x])/14 + (13*Log[2]*Log[1 - x]*Log[1 + x])/84 + 
     (Log[1 - x]^2*Log[1 + x])/16 + (Log[2]*Log[x]*Log[1 + x])/8 - 
     (Log[2]*Log[1 + x]^2)/336 - (Log[1 - x]*Log[1 + x]^2)/28 - 
     (Log[x]*Log[1 + x]^2)/12 - (89*Log[1 + x]^3)/336 - 
     (5*Log[2]*PolyLog[2, (1 - x)/2])/24 - (Log[1 - x]*PolyLog[2, (1 - x)/2])/
      12 - (Log[x]*PolyLog[2, (1 - x)/2])/24 + 
     (7*Log[1 + x]*PolyLog[2, (1 - x)/2])/24 + (5*Log[2]*PolyLog[2, -x])/24 - 
     (Log[1 - x]*PolyLog[2, -x])/12 - (Log[1 + x]*PolyLog[2, -x])/8 - 
     (Log[2]*PolyLog[2, x])/8 + (Log[1 - x]*PolyLog[2, x])/24 + 
     (Log[1 + x]*PolyLog[2, x])/12 + PolyLog[3, (1 - x)/2]/4 - 
     (5*PolyLog[3, 1 - x])/168 + PolyLog[3, -x]/12 - PolyLog[3, x]/12 - 
     PolyLog[3, (2*x)/(-1 + x)]/12 + PolyLog[3, (1 + x)^(-1)]/24 + 
     (9*PolyLog[3, (1 + x)/2])/28) - (17*Log[2]^2*PolyLog[3, (1 + x)/2])/14 + 
   (13*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/14 - 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 + x)/2])/2 + 
   (3*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2])/2 - 
   (13*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/14 + 
   Log[x]*Log[1 + x]*PolyLog[3, (1 + x)/2] - 
   (2*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/7 - PolyLog[2, (1 - x)/2]*
    PolyLog[3, (1 + x)/2] + PolyLog[2, -x]*PolyLog[3, (1 + x)/2] - 
   (PolyLog[2, x]*PolyLog[3, (1 + x)/2])/2 - 4*Log[2]*PolyLog[4, 1/2] - 
   (33*Log[2]*PolyLog[4, (1 - x)/2])/7 - (Log[x]*PolyLog[4, (1 - x)/2])/2 + 
   (26*Log[1 + x]*PolyLog[4, (1 - x)/2])/7 + 2*Log[2]*PolyLog[4, 1 - x] + 
   (3*Log[x]*PolyLog[4, 1 - x])/14 - (7*Log[1 + x]*PolyLog[4, 1 - x])/2 + 
   (Log[1 - x]*PolyLog[4, -x])/2 - (Log[1 + x]*PolyLog[4, -x])/2 - 
   (3*Log[1 - x]*PolyLog[4, x])/14 + (Log[1 + x]*PolyLog[4, x])/2 - 
   (3*Log[1 - x]*PolyLog[4, x/(-1 + x)])/14 + 
   2*Log[1 + x]*PolyLog[4, x/(-1 + x)] - 
   Log[1 + x]*PolyLog[4, (2*x)/(-1 + x)] + 
   (Log[1 + x]*PolyLog[4, (4*x)/(1 + x)^2])/4 - 
   2*Log[2]*PolyLog[4, (1 + x)^(-1)] - (Log[1 - x]*PolyLog[4, (1 + x)^(-1)])/
    2 + 4*Log[1 + x]*PolyLog[4, (1 + x)^(-1)] + 
   (2*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/7 - 
   (2*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/7 + 
   2*Log[1 + x]*PolyLog[4, x/(1 + x)] - 
   2*Log[1 + x]*PolyLog[4, (2*x)/(1 + x)] - (30*Log[2]*PolyLog[4, (1 + x)/2])/
    7 + (39*Log[1 - x]*PolyLog[4, (1 + x)/2])/14 - 
   (Log[x]*PolyLog[4, (1 + x)/2])/2 + (7*Log[1 + x]*PolyLog[4, (1 + x)/2])/
    2 - (Log[2]*PolyLog[4, 1 - x^2])/4 + (Log[1 + x]*PolyLog[4, 1 - x^2])/2 - 
   (Log[1 + x]*PolyLog[4, x^2/(-1 + x^2)])/4 - 4*PolyLog[5, 1/2] - 
   2*PolyLog[5, (1 - x)/2] + (3*PolyLog[5, 1 - x])/2 - (3*PolyLog[5, -x])/4 + 
   PolyLog[5, x]/4 - PolyLog[5, (-4*x)/(1 - x)^2]/8 - 
   PolyLog[5, x/(-1 + x)]/2 + PolyLog[5, (2*x)/(-1 + x)] + 
   (3*PolyLog[5, (1 + x)^(-1)])/2 - (9*PolyLog[5, (1 - x)/(1 + x)])/4 - 
   (11*PolyLog[5, (-1 + x)/(1 + x)])/4 - 4*PolyLog[5, (1 + x)/2] - 
   PolyLog[5, 1 - x^2]/8 + (13*Pi^2*Zeta[3])/96 - (7*Log[2]^2*Zeta[3])/4 + 
   ((-67*Log[2]^2)/16 + (355*Log[2]*Log[1 - x])/112 - (3*Log[1 - x]^2)/28 - 
     (7*Log[2]*Log[x])/8 + (69*Log[1 - x]*Log[x])/56 + 
     (387*Log[2]*Log[1 + x])/112 - (13*Log[1 - x]*Log[1 + x])/7 - 
     (11*Log[x]*Log[1 + x])/8 + (131*Log[1 + x]^2)/112 + 
     PolyLog[2, (1 - x)/2]/8 - (29*PolyLog[2, -x])/16 + 
     (15*PolyLog[2, x])/16)*Zeta[3] + 
   Log[1 + x]*((-7*Pi^4)/720 + (3*Pi^2*Log[2]^2)/16 - (3*Log[2]^4)/16 - 
     (9*PolyLog[4, 1/2])/2 - (63*Log[2]*Zeta[3])/16) + 
   Log[1 - x]*((-23*Pi^4)/630 - (Pi^2*Log[2]^2)/48 + Log[2]^4/48 + 
     PolyLog[4, 1/2]/2 + (7*Log[2]*Zeta[3])/16) + 
   Log[x]*((11*Pi^4)/10080 - (Pi^2*Log[2]^2)/24 + Log[2]^4/24 + 
     PolyLog[4, 1/2] + (7*Log[2]*Zeta[3])/8) + 
   Log[2]*((51*Pi^4)/1120 - (5*Pi^2*Log[2]^2)/24 + (5*Log[2]^4)/24 + 
     5*PolyLog[4, 1/2] + (35*Log[2]*Zeta[3])/8) - Zeta[5]/2, 
 HPL[{-2, 1, 1, 1}, x_] :>  HPL[{-4, 1}, x]/2 + HPL[{3, 2}, 1 - x]/14 - 
   HPL[{3, 2}, x]/14 + HPL[{3, 2}, x/(-1 + x)]/14 - (Pi^2*Log[2]^3)/12 + 
   Log[2]^5/8 - (Log[2]^4*Log[1 - x])/6 + (Log[2]^3*Log[1 - x]^2)/6 - 
   (Log[2]^2*Log[1 - x]^3)/4 + (5*Log[2]*Log[1 - x]^4)/24 - 
   (451*Log[1 - x]^5)/3360 + (Pi^4*Log[x])/420 + (5*Log[1 - x]^4*Log[x])/14 + 
   (Log[2]^3*Log[1 - x]*Log[1 + x])/3 + (Log[1 - x]^4*Log[1 + x])/24 - 
   (Log[1 - x]^3*Log[x]*Log[1 + x])/4 - (Log[2]^2*Log[1 - x]*Log[1 + x]^2)/
    2 + (Log[1 - x]^3*Log[1 + x]^2)/16 - (Log[1 - x]^2*Log[x]*Log[1 + x]^2)/
    4 + (Log[2]*Log[1 - x]*Log[1 + x]^3)/3 + (Log[1 - x]^2*Log[1 + x]^3)/24 + 
   (Log[1 - x]*Log[x]*Log[1 + x]^3)/4 - (23*Log[1 - x]*Log[1 + x]^4)/96 + 
   (Log[1 - x]^3*PolyLog[2, -x])/6 - (Log[1 - x]^2*PolyLog[3, (1 - x)/2])/2 + 
   Pi^2*(-Log[2]^3/24 + (Log[2]^2*Log[1 - x])/6 - (Log[2]*Log[1 - x]^2)/12 - 
     (127*Log[1 - x]^3)/1008 + (Log[1 - x]^2*Log[x])/168 - 
     (Log[2]*Log[1 - x]*Log[1 + x])/6 + (Log[1 - x]^2*Log[1 + x])/24 + 
     (13*Log[1 - x]*Log[1 + x]^2)/48 - PolyLog[3, 1 - x]/84) + 
   (13*Log[1 - x]^2*PolyLog[3, 1 - x])/28 + 
   (Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/14 - (Log[1 - x]^2*PolyLog[3, -x])/
    2 + (13*Log[1 - x]^2*PolyLog[3, x])/28 + 
   (Log[1 - x]^2*PolyLog[3, (2*x)/(-1 + x)])/2 + 3*Log[2]*PolyLog[4, 1/2] + 
   Log[1 - x]*PolyLog[4, (1 - x)/2] + Log[1 - x]*PolyLog[4, 1 - x] - 
   (3*Log[x]*PolyLog[4, 1 - x])/14 - (2*Log[1 - x]*PolyLog[4, x])/7 - 
   (25*Log[1 - x]*PolyLog[4, x/(-1 + x)])/14 + 
   Log[1 - x]*PolyLog[4, (2*x)/(-1 + x)] - 
   (Log[1 - x]*PolyLog[4, (4*x)/(1 + x)^2])/4 - 
   2*Log[1 - x]*PolyLog[4, (1 + x)^(-1)] - 
   2*Log[1 - x]*PolyLog[4, x/(1 + x)] + 
   2*Log[1 - x]*PolyLog[4, (2*x)/(1 + x)] - 
   2*Log[1 - x]*PolyLog[4, (1 + x)/2] - (Log[1 - x]*PolyLog[4, 1 - x^2])/4 + 
   (Log[1 - x]*PolyLog[4, x^2/(-1 + x^2)])/4 + 3*PolyLog[5, 1/2] - 
   3*PolyLog[5, (1 - x)/2] + PolyLog[5, 1 - x] + (3*PolyLog[5, -x])/4 - 
   PolyLog[5, x]/4 + PolyLog[5, (-4*x)/(1 - x)^2]/8 + 
   PolyLog[5, x/(-1 + x)]/2 - PolyLog[5, (2*x)/(-1 + x)] - 
   (Pi^2*Zeta[3])/42 + (21*Log[2]^2*Zeta[3])/16 + 
   ((21*Log[2]^2)/16 - (7*Log[2]*Log[1 - x])/2 - (43*Log[1 - x]^2)/56 + 
     (Log[1 - x]*Log[x])/7)*Zeta[3] + 
   Log[2]*((Pi^2*Log[2]^2)/8 - Log[2]^4/8 - 3*PolyLog[4, 1/2] - 
     (21*Log[2]*Zeta[3])/8) + Log[1 - x]*(Pi^4/240 - (Pi^2*Log[2]^2)/6 + 
     Log[2]^4/6 + 4*PolyLog[4, 1/2] + (7*Log[2]*Zeta[3])/2) - 
   (17*Zeta[5])/28, HPL[{-3, -1, -1}, x_] :>  HPL[{3, 2}, -x]/7 + 
   HPL[{3, 2}, (1 + x)^(-1)]/7 - HPL[{3, 2}, x/(1 + x)]/7 + 
   (Pi^4*Log[x])/210 + (Pi^4*Log[1 + x])/280 - (Log[x]*Log[1 + x]^4)/12 + 
   (3*Log[1 + x]^5)/70 - (3*Log[1 + x]^2*PolyLog[3, -x])/7 + 
   Pi^2*((Log[x]*Log[1 + x]^2)/84 - (5*Log[1 + x]^3)/126 - 
     PolyLog[3, (1 + x)^(-1)]/42) - 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/7 + 
   (Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/7 + (4*Log[1 + x]*PolyLog[4, -x])/
    7 - (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/7 + 
   (10*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/7 + 
   (4*Log[1 + x]*PolyLog[4, x/(1 + x)])/7 + 2*PolyLog[5, (1 + x)^(-1)] - 
   (Pi^2*Zeta[3])/21 + ((-2*Log[x]*Log[1 + x])/7 + (3*Log[1 + x]^2)/7)*
    Zeta[3] - (17*Zeta[5])/14, HPL[{-3, -1, 1}, x_] :>  HPL[{-3, -1, 1}, x], 
 HPL[{-3, -2}, x_] :>  HPL[{3, 2}, -x], HPL[{-3, 1, -1}, x_] :>  
  (47*HPL[{-4, 1}, -x])/32 - HPL[{-4, 1}, x]/32 - 
   (17*HPL[{-4, 1}, (1 - x)/(1 + x)])/32 - 
   (19*HPL[{-4, 1}, (-1 + x)/(1 + x)])/32 + HPL[{3, -2}, -x]/8 + 
   HPL[{3, -2}, x]/8 - (9*HPL[{3, 2}, (1 - x)/2])/112 - 
   (15*HPL[{3, 2}, 1 - x])/224 - (61*HPL[{3, 2}, -x])/224 - 
   (13*HPL[{3, 2}, x])/224 - (43*HPL[{3, 2}, x/(-1 + x)])/224 + 
   (23*HPL[{3, 2}, (2*x)/(-1 + x)])/224 - (33*HPL[{3, 2}, (1 + x)^(-1)])/
    224 + HPL[{3, 2}, (1 - x)/(1 + x)]/14 + 
   (25*HPL[{3, 2}, (-1 + x)/(1 + x)])/224 + (5*HPL[{3, 2}, x/(1 + x)])/224 - 
   (9*HPL[{3, 2}, (2*x)/(1 + x)])/224 + HPL[{3, 2}, (1 + x)/2]/56 + 
   (3*HPL[{3, 2}, x^2/(-1 + x^2)])/128 + HPL[{-3, -1, 1}, -x]/16 - 
   (15*HPL[{-3, -1, 1}, x])/16 - HPL[{-3, -1, 1}, (1 - x)/(1 + x)]/32 + 
   HPL[{-2, 1, -2}, -x]/16 + HPL[{-2, 1, -2}, x]/16 - 
   HPL[{-2, 1, -2}, (1 - x)/(1 + x)]/32 - HPL[{2, -2, -1}, -x]/16 - 
   HPL[{2, -2, -1}, x]/16 + HPL[{2, -2, -1}, (1 - x)/(1 + x)]/32 + 
   HPL[{-2, -1, -1, 1}, -x]/32 + HPL[{-2, -1, -1, 1}, x]/32 - 
   (35*Pi^2*Log[2]^3)/576 + (49*Log[2]^5)/480 - (157*Log[2]^4*Log[1 - x])/
    5376 + (Log[2]^3*Log[1 - x]^2)/48 + (13*Log[2]^2*Log[1 - x]^3)/768 - 
   (7*Log[2]*Log[1 - x]^4)/768 - (31*Log[1 - x]^5)/1344 - 
   (Log[2]^4*Log[x])/384 + (Log[2]^3*Log[1 - x]*Log[x])/192 + 
   (Log[2]^2*Log[1 - x]^2*Log[x])/64 + (11*Log[2]*Log[1 - x]^3*Log[x])/192 + 
   (677*Log[1 - x]^4*Log[x])/10752 - (179*Log[2]^4*Log[1 + x])/5376 + 
   (59*Log[2]^3*Log[1 - x]*Log[1 + x])/1344 - 
   (17*Log[2]^2*Log[1 - x]^2*Log[1 + x])/256 + 
   (Log[2]*Log[1 - x]^3*Log[1 + x])/384 + (87*Log[1 - x]^4*Log[1 + x])/1792 - 
   (Log[2]^3*Log[x]*Log[1 + x])/192 - (Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/
    32 - (7*Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/32 - 
   (25*Log[1 - x]^3*Log[x]*Log[1 + x])/128 - (185*Log[2]^3*Log[1 + x]^2)/
    1344 + (85*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/1792 + 
   (Log[2]*Log[1 - x]^2*Log[1 + x]^2)/64 + (15*Log[1 - x]^3*Log[1 + x]^2)/
    1792 + (Log[2]^2*Log[x]*Log[1 + x]^2)/32 + 
   (Log[2]*Log[1 - x]*Log[x]*Log[1 + x]^2)/4 + 
   (33*Log[1 - x]^2*Log[x]*Log[1 + x]^2)/256 + (545*Log[2]^2*Log[1 + x]^3)/
    1792 - (211*Log[2]*Log[1 - x]*Log[1 + x]^3)/2688 - 
   (101*Log[1 - x]^2*Log[1 + x]^3)/5376 - (7*Log[2]*Log[x]*Log[1 + x]^3)/64 + 
   (27*Log[1 - x]*Log[x]*Log[1 + x]^3)/128 - (389*Log[2]*Log[1 + x]^4)/1792 - 
   (209*Log[1 - x]*Log[1 + x]^4)/2688 - (101*Log[x]*Log[1 + x]^4)/512 + 
   (719*Log[1 + x]^5)/3360 + (Log[2]^3*PolyLog[2, (1 - x)/2])/24 - 
   (3*Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/64 + 
   (Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/64 - 
   (Log[1 - x]^3*PolyLog[2, (1 - x)/2])/192 + 
   (Log[1 - x]^2*Log[x]*PolyLog[2, (1 - x)/2])/64 - 
   (5*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/64 + 
   (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/16 - 
   (Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/32 + 
   (3*Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/64 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/32 + 
   (Log[x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/64 - 
   (Log[1 + x]^3*PolyLog[2, (1 - x)/2])/192 + 
   (Log[2]*PolyLog[2, (1 - x)/2]^2)/32 - (Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/
    32 - (3*Log[2]^3*PolyLog[2, -x])/64 + 
   (3*Log[2]^2*Log[1 - x]*PolyLog[2, -x])/64 - 
   (Log[1 - x]^2*Log[x]*PolyLog[2, -x])/32 + 
   (3*Log[2]^2*Log[1 + x]*PolyLog[2, -x])/32 - 
   (3*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, -x])/32 - 
   (Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, -x])/16 - 
   (3*Log[2]*Log[1 + x]^2*PolyLog[2, -x])/64 + 
   (3*Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/64 + 
   (Log[1 + x]^3*PolyLog[2, -x])/192 - 
   (Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/32 + 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/32 - 
   (Log[2]^3*PolyLog[2, x])/192 + (Log[2]^2*Log[1 - x]*PolyLog[2, x])/32 - 
   (Log[2]*Log[1 - x]^2*PolyLog[2, x])/64 - 
   (Log[2]^2*Log[1 + x]*PolyLog[2, x])/64 - 
   (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, x])/32 - 
   (Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, x])/16 + 
   (Log[2]*Log[1 + x]^2*PolyLog[2, x])/32 + 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/64 - 
   (Log[x]*Log[1 + x]^2*PolyLog[2, x])/32 + (Log[1 + x]^3*PolyLog[2, x])/
    192 + (Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/32 - 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/32 - 
   (Log[1 - x]*PolyLog[2, -x]*PolyLog[2, x])/16 - 
   (Log[1 + x]*PolyLog[2, -x]*PolyLog[2, x])/16 - 
   (25*Log[2]^2*PolyLog[3, (1 - x)/2])/448 + 
   (3*Log[1 - x]^2*PolyLog[3, (1 - x)/2])/128 + 
   (25*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/224 + 
   (3*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/2])/64 + 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/2])/32 - 
   (29*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/896 + 
   (PolyLog[2, -x]*PolyLog[3, (1 - x)/2])/16 + 
   (3*PolyLog[2, x]*PolyLog[3, (1 - x)/2])/32 - 
   (Log[2]*Log[1 - x]*PolyLog[3, 1 - x])/32 + 
   (11*Log[1 - x]^2*PolyLog[3, 1 - x])/224 - 
   (15*Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/224 + 
   (Log[2]*Log[1 + x]*PolyLog[3, 1 - x])/32 - 
   (3*Log[1 - x]*Log[1 + x]*PolyLog[3, 1 - x])/32 - 
   (Log[1 + x]^2*PolyLog[3, 1 - x])/16 - (PolyLog[2, -x]*PolyLog[3, 1 - x])/
    8 - (PolyLog[2, x]*PolyLog[3, 1 - x])/16 - (Log[2]^2*PolyLog[3, -x])/64 + 
   (Log[2]*Log[1 - x]*PolyLog[3, -x])/16 - (7*Log[1 - x]^2*PolyLog[3, -x])/
    64 - (Log[2]*Log[1 + x]*PolyLog[3, -x])/32 + 
   (27*Log[1 - x]*Log[1 + x]*PolyLog[3, -x])/32 - 
   (19*Log[1 + x]^2*PolyLog[3, -x])/448 - 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, -x])/32 + (Log[2]^2*PolyLog[3, x])/64 - 
   (Log[2]*Log[1 - x]*PolyLog[3, x])/16 + (11*Log[1 - x]^2*PolyLog[3, x])/
    224 + (Log[2]*Log[1 + x]*PolyLog[3, x])/32 - 
   (3*Log[1 - x]*Log[1 + x]*PolyLog[3, x])/32 - (Log[1 + x]^2*PolyLog[3, x])/
    8 + (PolyLog[2, (1 - x)/2]*PolyLog[3, x])/32 + 
   (Log[2]^2*PolyLog[3, (2*x)/(-1 + x)])/64 - 
   (Log[2]*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)])/16 + 
   (23*Log[1 - x]^2*PolyLog[3, (2*x)/(-1 + x)])/448 + 
   (Log[2]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/32 - 
   (9*Log[1 - x]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/224 + 
   (Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/224 + 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (2*x)/(-1 + x)])/32 + 
   (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)])/32 - 
   (3*Log[1 - x]^2*PolyLog[3, (1 + x)^(-1)])/64 - 
   (Log[2]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/32 - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/8 + 
   (33*Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/224 - 
   (13*Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/112 - 
   (PolyLog[2, -x]*PolyLog[3, (1 + x)^(-1)])/16 - 
   (PolyLog[2, x]*PolyLog[3, (1 + x)^(-1)])/8 + 
   (3*Log[2]^2*PolyLog[3, (1 - x)/(1 + x)])/64 + 
   (9*Log[2]*Log[1 - x]*PolyLog[3, (1 - x)/(1 + x)])/224 + 
   (3*Log[1 - x]^2*PolyLog[3, (1 - x)/(1 + x)])/128 + 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/(1 + x)])/14 - 
   (15*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/112 + 
   (3*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/448 - 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/14 + 
   (99*Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)])/896 + 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (1 - x)/(1 + x)])/32 + 
   (PolyLog[2, -x]*PolyLog[3, (1 - x)/(1 + x)])/16 + 
   (PolyLog[2, x]*PolyLog[3, (1 - x)/(1 + x)])/16 + 
   Pi^2*((-517*Log[2]^3)/16128 + (13*Log[2]^2*Log[1 - x])/896 - 
     (57*Log[2]*Log[1 - x]^2)/1792 - (559*Log[1 - x]^3)/16128 + 
     (Log[2]^2*Log[x])/768 + (107*Log[1 - x]^2*Log[x])/5376 - 
     (3*Log[2]^2*Log[1 + x])/1792 + (71*Log[2]*Log[1 - x]*Log[1 + x])/1344 + 
     (353*Log[1 - x]^2*Log[1 + x])/5376 + (Log[2]*Log[x]*Log[1 + x])/384 - 
     (3*Log[1 - x]*Log[x]*Log[1 + x])/56 + (9*Log[2]*Log[1 + x]^2)/128 + 
     (27*Log[1 - x]*Log[1 + x]^2)/448 + (Log[x]*Log[1 + x]^2)/84 - 
     (127*Log[1 + x]^3)/576 - (5*Log[2]*PolyLog[2, (1 - x)/2])/384 - 
     (Log[1 - x]*PolyLog[2, (1 - x)/2])/192 - (Log[x]*PolyLog[2, (1 - x)/2])/
      384 + (7*Log[1 + x]*PolyLog[2, (1 - x)/2])/384 + 
     (7*Log[2]*PolyLog[2, -x])/384 + (Log[1 - x]*PolyLog[2, -x])/192 - 
     (5*Log[1 + x]*PolyLog[2, -x])/384 + (Log[2]*PolyLog[2, x])/128 - 
     (Log[1 - x]*PolyLog[2, x])/128 - (Log[1 + x]*PolyLog[2, x])/96 + 
     PolyLog[3, (1 - x)/2]/384 + (23*PolyLog[3, 1 - x])/2688 + 
     PolyLog[3, -x]/192 - PolyLog[3, x]/192 - PolyLog[3, (2*x)/(-1 + x)]/
      192 + (73*PolyLog[3, (1 + x)^(-1)])/2688 - 
     (13*PolyLog[3, (1 - x)/(1 + x)])/896 - PolyLog[3, (1 + x)/2]/2688) - 
   (17*Log[2]^2*PolyLog[3, (1 + x)/2])/448 - 
   (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/56 + 
   (3*Log[1 - x]^2*PolyLog[3, (1 + x)/2])/128 + 
   (3*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2])/32 + 
   (29*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/448 + 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/32 - 
   (29*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/896 - 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (1 + x)/2])/16 + 
   (PolyLog[2, -x]*PolyLog[3, (1 + x)/2])/8 + 
   (PolyLog[2, x]*PolyLog[3, (1 + x)/2])/32 + (35*Log[2]*PolyLog[4, 1/2])/
    16 - (75*Log[2]*PolyLog[4, (1 - x)/2])/224 - 
   (Log[x]*PolyLog[4, (1 - x)/2])/32 + (75*Log[1 + x]*PolyLog[4, (1 - x)/2])/
    224 + (Log[2]*PolyLog[4, 1 - x])/8 + (Log[1 - x]*PolyLog[4, 1 - x])/8 + 
   (45*Log[x]*PolyLog[4, 1 - x])/224 - (37*Log[1 + x]*PolyLog[4, 1 - x])/32 - 
   (11*Log[1 - x]*PolyLog[4, -x])/32 - (167*Log[1 + x]*PolyLog[4, -x])/224 + 
   (25*Log[1 - x]*PolyLog[4, x])/224 - (11*Log[1 + x]*PolyLog[4, x])/32 - 
   (157*Log[1 - x]*PolyLog[4, x/(-1 + x)])/224 + 
   (17*Log[1 + x]*PolyLog[4, x/(-1 + x)])/16 + 
   (69*Log[1 - x]*PolyLog[4, (2*x)/(-1 + x)])/224 - 
   (69*Log[1 + x]*PolyLog[4, (2*x)/(-1 + x)])/224 - 
   (Log[1 - x]*PolyLog[4, (4*x)/(1 + x)^2])/32 + 
   (9*Log[1 + x]*PolyLog[4, (4*x)/(1 + x)^2])/32 - 
   (Log[2]*PolyLog[4, (1 + x)^(-1)])/8 - 
   (39*Log[1 - x]*PolyLog[4, (1 + x)^(-1)])/32 + 
   (99*Log[x]*PolyLog[4, (1 + x)^(-1)])/224 + 
   (405*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/224 + 
   (2*Log[2]*PolyLog[4, (1 - x)/(1 + x)])/7 - 
   (3*Log[x]*PolyLog[4, (1 - x)/(1 + x)])/14 - 
   (2*Log[1 + x]*PolyLog[4, (1 - x)/(1 + x)])/7 + 
   (11*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/56 + 
   (Log[x]*PolyLog[4, (-1 + x)/(1 + x)])/2 - 
   (11*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/56 - 
   (19*Log[1 - x]*PolyLog[4, x/(1 + x)])/16 + 
   (491*Log[1 + x]*PolyLog[4, x/(1 + x)])/224 + 
   (83*Log[1 - x]*PolyLog[4, (2*x)/(1 + x)])/224 - 
   (531*Log[1 + x]*PolyLog[4, (2*x)/(1 + x)])/224 - 
   (9*Log[2]*PolyLog[4, (1 + x)/2])/224 - 
   (17*Log[1 - x]*PolyLog[4, (1 + x)/2])/56 - (Log[x]*PolyLog[4, (1 + x)/2])/
    32 + (75*Log[1 + x]*PolyLog[4, (1 + x)/2])/32 - 
   (Log[2]*PolyLog[4, 1 - x^2])/64 - (Log[1 - x]*PolyLog[4, 1 - x^2])/32 + 
   (17*Log[1 + x]*PolyLog[4, 1 - x^2])/64 + 
   (13*Log[1 - x]*PolyLog[4, x^2/(-1 + x^2)])/128 - 
   (23*Log[1 + x]*PolyLog[4, x^2/(-1 + x^2)])/128 + (35*PolyLog[5, 1/2])/16 - 
   (21*PolyLog[5, (1 - x)/2])/32 + (45*PolyLog[5, 1 - x])/32 - 
   (9*PolyLog[5, -x])/32 + (55*PolyLog[5, x])/32 + 
   PolyLog[5, (-4*x)/(1 - x)^2]/128 - PolyLog[5, x/(-1 + x)]/32 + 
   (17*PolyLog[5, (4*x)/(1 + x)^2])/128 + (3*PolyLog[5, (1 + x)^(-1)])/8 - 
   (43*PolyLog[5, (1 - x)/(1 + x)])/64 - (29*PolyLog[5, (-1 + x)/(1 + x)])/
    64 + (47*PolyLog[5, x/(1 + x)])/32 - 2*PolyLog[5, (2*x)/(1 + x)] - 
   (63*PolyLog[5, (1 + x)/2])/32 - (11*PolyLog[5, 1 - x^2])/64 + 
   (3*Pi^2*Zeta[3])/64 + (245*Log[2]^2*Zeta[3])/256 + 
   ((111*Log[2]^2)/128 - (1285*Log[2]*Log[1 - x])/1792 - 
     (643*Log[1 - x]^2)/3584 - (7*Log[2]*Log[x])/128 + 
     (93*Log[1 - x]*Log[x])/224 + (1019*Log[2]*Log[1 + x])/1792 - 
     (173*Log[1 - x]*Log[1 + x])/256 - (57*Log[x]*Log[1 + x])/224 + 
     (1695*Log[1 + x]^2)/3584 + PolyLog[2, (1 - x)/2]/128 - 
     (11*PolyLog[2, -x])/256 + (5*PolyLog[2, x])/256)*Zeta[3] + 
   Log[1 + x]*((1591*Pi^4)/161280 + (23*Pi^2*Log[2]^2)/256 - 
     (23*Log[2]^4)/256 - (69*PolyLog[4, 1/2])/32 - (483*Log[2]*Zeta[3])/
      256) + Log[2]*((-3*Pi^4)/2240 + (17*Pi^2*Log[2]^2)/192 - 
     (17*Log[2]^4)/192 - (17*PolyLog[4, 1/2])/8 - (119*Log[2]*Zeta[3])/64) + 
   Log[x]*((17*Pi^4)/53760 - (Pi^2*Log[2]^2)/384 + Log[2]^4/384 + 
     PolyLog[4, 1/2]/16 + (7*Log[2]*Zeta[3])/128) + 
   Log[1 - x]*((-487*Pi^4)/40320 - (77*Pi^2*Log[2]^2)/768 + 
     (77*Log[2]^4)/768 + (77*PolyLog[4, 1/2])/32 + (539*Log[2]*Zeta[3])/
      256) - (1701*Zeta[5])/1024, HPL[{-3, 1, 1}, x_] :>  
  (3*HPL[{-4, 1}, x])/2 + HPL[{3, 2}, 1 - x]/14 - HPL[{3, 2}, x]/14 + 
   HPL[{3, 2}, x/(-1 + x)]/14 - (Pi^2*Log[2]^3)/18 + Log[2]^5/12 - 
   (Log[2]^4*Log[1 - x])/6 + (Log[2]^3*Log[1 - x]^2)/6 - 
   (Log[2]^2*Log[1 - x]^3)/6 + (Log[2]*Log[1 - x]^4)/12 - 
   (57*Log[1 - x]^5)/1120 + (Pi^4*Log[x])/420 + (3*Log[1 - x]^4*Log[x])/28 + 
   (Log[2]^3*Log[1 - x]*Log[1 + x])/3 + (Log[1 - x]^4*Log[1 + x])/24 - 
   (Log[1 - x]^3*Log[x]*Log[1 + x])/4 - (Log[2]^2*Log[1 - x]*Log[1 + x]^2)/
    2 + (Log[1 - x]^3*Log[1 + x]^2)/16 - (Log[1 - x]^2*Log[x]*Log[1 + x]^2)/
    4 + (Log[2]*Log[1 - x]*Log[1 + x]^3)/3 + (Log[1 - x]^2*Log[1 + x]^3)/24 + 
   (Log[1 - x]*Log[x]*Log[1 + x]^3)/4 - (23*Log[1 - x]*Log[1 + x]^4)/96 + 
   Pi^2*(-Log[2]^3/36 + (Log[2]^2*Log[1 - x])/6 - (Log[2]*Log[1 - x]^2)/12 - 
     (19*Log[1 - x]^3)/336 + (Log[1 - x]^2*Log[x])/168 - 
     (Log[2]*Log[1 - x]*Log[1 + x])/6 + (Log[1 - x]^2*Log[1 + x])/24 + 
     (13*Log[1 - x]*Log[1 + x]^2)/48 - PolyLog[3, 1 - x]/84) - 
   (Log[1 - x]^2*PolyLog[3, 1 - x])/28 + 
   (Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/14 - (Log[1 - x]^2*PolyLog[3, -x])/
    2 - (Log[1 - x]^2*PolyLog[3, x])/28 + 2*Log[2]*PolyLog[4, 1/2] + 
   Log[1 - x]*PolyLog[4, 1 - x] - (3*Log[x]*PolyLog[4, 1 - x])/14 - 
   (2*Log[1 - x]*PolyLog[4, x])/7 - (11*Log[1 - x]*PolyLog[4, x/(-1 + x)])/
    14 - (Log[1 - x]*PolyLog[4, (4*x)/(1 + x)^2])/4 - 
   2*Log[1 - x]*PolyLog[4, (1 + x)^(-1)] - 
   2*Log[1 - x]*PolyLog[4, x/(1 + x)] + 
   2*Log[1 - x]*PolyLog[4, (2*x)/(1 + x)] - 
   2*Log[1 - x]*PolyLog[4, (1 + x)/2] - (Log[1 - x]*PolyLog[4, 1 - x^2])/4 + 
   (Log[1 - x]*PolyLog[4, x^2/(-1 + x^2)])/4 + 2*PolyLog[5, 1/2] - 
   2*PolyLog[5, (1 - x)/2] + PolyLog[5, 1 - x] + (7*PolyLog[5, -x])/4 - 
   PolyLog[5, x]/4 + PolyLog[5, (-4*x)/(1 - x)^2]/8 + 
   (3*PolyLog[5, x/(-1 + x)])/2 - 2*PolyLog[5, (2*x)/(-1 + x)] - 
   (Pi^2*Zeta[3])/42 + (7*Log[2]^2*Zeta[3])/8 + 
   ((7*Log[2]^2)/8 - (7*Log[2]*Log[1 - x])/2 - (15*Log[1 - x]^2)/56 + 
     (Log[1 - x]*Log[x])/7)*Zeta[3] + 
   Log[2]*((Pi^2*Log[2]^2)/12 - Log[2]^4/12 - 2*PolyLog[4, 1/2] - 
     (7*Log[2]*Zeta[3])/4) + Log[1 - x]*(Pi^4/240 - (Pi^2*Log[2]^2)/6 + 
     Log[2]^4/6 + 4*PolyLog[4, 1/2] + (7*Log[2]*Zeta[3])/2) - 
   (17*Zeta[5])/28, HPL[{-4, -1}, x_] :>  -HPL[{3, 2}, -x]/7 - 
   HPL[{3, 2}, (1 + x)^(-1)]/7 + HPL[{3, 2}, x/(1 + x)]/7 - 
   (Pi^4*Log[x])/210 - (Pi^4*Log[1 + x])/280 - (Log[x]*Log[1 + x]^4)/24 + 
   Log[1 + x]^5/42 - (Log[1 + x]^2*PolyLog[3, -x])/14 + 
   Pi^2*(-(Log[x]*Log[1 + x]^2)/84 - Log[1 + x]^3/63 + 
     PolyLog[3, (1 + x)^(-1)]/42) + 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/7 - 
   (Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/7 - (4*Log[1 + x]*PolyLog[4, -x])/
    7 + (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/7 - 
   (3*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/7 + 
   (3*Log[1 + x]*PolyLog[4, x/(1 + x)])/7 + PolyLog[5, -x] - 
   PolyLog[5, (1 + x)^(-1)] + PolyLog[5, x/(1 + x)] + (Pi^2*Zeta[3])/21 + 
   ((2*Log[x]*Log[1 + x])/7 + Log[1 + x]^2/14)*Zeta[3] + (3*Zeta[5])/14, 
 HPL[{-4, 1}, x_] :>  HPL[{-4, 1}, x], HPL[{-5}, x_] :>  -PolyLog[5, -x], 
 HPL[{5}, x_] :>  PolyLog[5, x], HPL[{4, -1}, x_] :>  HPL[{-4, 1}, -x], 
 HPL[{3, -1, -1}, x_] :>  (-3*HPL[{-4, 1}, -x])/2 + HPL[{3, 2}, -x]/14 + 
   HPL[{3, 2}, (1 + x)^(-1)]/14 - HPL[{3, 2}, x/(1 + x)]/14 + 
   (Pi^2*Log[2]^3)/18 - Log[2]^5/12 + (Pi^4*Log[x])/420 + 
   (Pi^4*Log[1 + x])/560 + (Log[2]^3*Log[1 + x]^2)/6 - 
   (Log[2]^2*Log[1 + x]^3)/3 + (Log[2]*Log[1 + x]^4)/4 + 
   (7*Log[x]*Log[1 + x]^4)/48 - (61*Log[1 + x]^5)/420 + 
   (Log[1 + x]^2*PolyLog[3, -x])/28 + (Log[1 + x]^2*PolyLog[3, x])/2 + 
   Pi^2*(Log[2]^3/36 - (Log[2]*Log[1 + x]^2)/12 + (Log[x]*Log[1 + x]^2)/168 + 
     (5*Log[1 + x]^3)/42 - PolyLog[3, (1 + x)^(-1)]/84) - 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/14 + 
   (Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/14 - 2*Log[2]*PolyLog[4, 1/2] + 
   (2*Log[1 + x]*PolyLog[4, -x])/7 - (Log[1 + x]*PolyLog[4, (4*x)/(1 + x)^2])/
    4 - (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/14 - 
   (11*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/14 - 
   (17*Log[1 + x]*PolyLog[4, x/(1 + x)])/14 + 
   2*Log[1 + x]*PolyLog[4, (2*x)/(1 + x)] - 
   2*Log[1 + x]*PolyLog[4, (1 + x)/2] - 2*PolyLog[5, 1/2] + 
   PolyLog[5, -x]/4 - (7*PolyLog[5, x])/4 - PolyLog[5, (4*x)/(1 + x)^2]/8 - 
   PolyLog[5, (1 + x)^(-1)]/2 - (3*PolyLog[5, x/(1 + x)])/2 + 
   2*PolyLog[5, (2*x)/(1 + x)] + 2*PolyLog[5, (1 + x)/2] - 
   (Pi^2*Zeta[3])/42 - (7*Log[2]^2*Zeta[3])/8 + 
   ((-7*Log[2]^2)/8 - (Log[x]*Log[1 + x])/7 + (19*Log[1 + x]^2)/56)*Zeta[3] + 
   Log[2]*(-(Pi^2*Log[2]^2)/12 + Log[2]^4/12 + 2*PolyLog[4, 1/2] + 
     (7*Log[2]*Zeta[3])/4) + (25*Zeta[5])/28, 
 HPL[{3, -2}, x_] :>  HPL[{3, -2}, x], HPL[{3, 2}, x_] :>  HPL[{3, 2}, x], 
 HPL[{3, 1, -1}, x_] :>  -HPL[{-3, -1, 1}, -x], 
 HPL[{2, -1, -1, -1}, x_] :>  HPL[{-4, 1}, -x]/2 - HPL[{3, 2}, -x]/14 - 
   HPL[{3, 2}, (1 + x)^(-1)]/14 + HPL[{3, 2}, x/(1 + x)]/14 - 
   (Pi^2*Log[2]^3)/12 + Log[2]^5/8 - (Pi^4*Log[x])/420 - 
   (Pi^4*Log[1 + x])/560 - (Log[2]^3*Log[1 + x]^2)/6 - 
   (Log[2]*Log[1 - x]^2*Log[1 + x]^2)/4 + (Log[1 - x]^3*Log[1 + x]^2)/12 - 
   (Log[1 - x]^2*Log[x]*Log[1 + x]^2)/4 + (Log[2]^2*Log[1 + x]^3)/4 + 
   (Log[2]*Log[1 - x]*Log[1 + x]^3)/2 + (Log[1 - x]*Log[x]*Log[1 + x]^3)/2 - 
   (3*Log[2]*Log[1 + x]^4)/8 - (Log[1 - x]*Log[1 + x]^4)/4 - 
   (7*Log[x]*Log[1 + x]^4)/48 + (61*Log[1 + x]^5)/420 + 
   (Log[1 + x]^3*PolyLog[2, x])/6 + (13*Log[1 + x]^2*PolyLog[3, -x])/28 - 
   (Log[1 + x]^2*PolyLog[3, x])/2 - (Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/
    2 + Pi^2*(-Log[2]^3/24 + (Log[2]*Log[1 + x]^2)/12 + 
     (Log[1 - x]*Log[1 + x]^2)/12 - (Log[x]*Log[1 + x]^2)/168 - 
     (53*Log[1 + x]^3)/504 + PolyLog[3, (1 + x)^(-1)]/84) + 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/14 + 
   (3*Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/7 - 
   (Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)])/2 - 
   (Log[1 + x]^2*PolyLog[3, (1 + x)/2])/2 + 3*Log[2]*PolyLog[4, 1/2] - 
   (2*Log[1 + x]*PolyLog[4, -x])/7 + (Log[1 + x]*PolyLog[4, (4*x)/(1 + x)^2])/
    4 + (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/14 + 
   (11*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/14 + 
   (3*Log[1 + x]*PolyLog[4, x/(1 + x)])/14 - 
   Log[1 + x]*PolyLog[4, (2*x)/(1 + x)] + 
   3*Log[1 + x]*PolyLog[4, (1 + x)/2] + 3*PolyLog[5, 1/2] - 
   PolyLog[5, -x]/4 + (3*PolyLog[5, x])/4 + PolyLog[5, (4*x)/(1 + x)^2]/8 + 
   PolyLog[5, (1 + x)^(-1)]/2 + PolyLog[5, x/(1 + x)]/2 - 
   PolyLog[5, (2*x)/(1 + x)] - 3*PolyLog[5, (1 + x)/2] + (Pi^2*Zeta[3])/42 + 
   (21*Log[2]^2*Zeta[3])/16 + ((21*Log[2]^2)/16 + (Log[x]*Log[1 + x])/7 - 
     (19*Log[1 + x]^2)/56)*Zeta[3] + Log[2]*((Pi^2*Log[2]^2)/8 - Log[2]^4/8 - 
     3*PolyLog[4, 1/2] - (21*Log[2]*Zeta[3])/8) - (25*Zeta[5])/28, 
 HPL[{2, -1, -1, 1}, x_] :>  -HPL[{-4, 1}, -x]/2 + 
   HPL[{-4, 1}, (1 - x)/(1 + x)] + HPL[{3, -2}, (1 - x)/(1 + x)]/2 + 
   HPL[{3, -2}, (-1 + x)/(1 + x)]/2 - (3*HPL[{3, 2}, (1 - x)/2])/14 + 
   HPL[{3, 2}, -x]/14 + HPL[{3, 2}, (1 + x)^(-1)]/14 + 
   (17*HPL[{3, 2}, (-1 + x)/(1 + x)])/14 - HPL[{3, 2}, x/(1 + x)]/14 - 
   (25*HPL[{3, 2}, (1 + x)/2])/14 - HPL[{-3, -1, 1}, (1 - x)/(1 + x)]/2 - 
   HPL[{-2, 1, -2}, (1 - x)/(1 + x)]/2 + HPL[{2, -2, -1}, (1 - x)/(1 + x)]/
    2 + HPL[{-2, -1, -1, 1}, -x]/2 - HPL[{-2, -1, -1, 1}, x]/2 + 
   (Pi^2*Log[2]^3)/9 - Log[2]^5/60 - (5*Log[2]^4*Log[1 - x])/28 + 
   (Log[2]^3*Log[1 - x]^2)/8 - (13*Log[2]^2*Log[1 - x]^3)/24 + 
   (Log[2]*Log[1 - x]^4)/6 - (Log[2]^4*Log[x])/24 - 
   (Log[2]^3*Log[1 - x]*Log[x])/12 + (Log[2]^2*Log[1 - x]^2*Log[x])/2 - 
   (2*Log[2]*Log[1 - x]^3*Log[x])/3 - (89*Log[2]^4*Log[1 + x])/168 + 
   (13*Log[2]^3*Log[1 - x]*Log[1 + x])/28 + 
   (5*Log[2]^2*Log[1 - x]^2*Log[1 + x])/4 + 
   (5*Log[2]*Log[1 - x]^3*Log[1 + x])/12 - (Log[1 - x]^4*Log[1 + x])/6 + 
   (Log[2]^3*Log[x]*Log[1 + x])/12 - (Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/
    2 + (3*Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/4 + 
   (Log[1 - x]^3*Log[x]*Log[1 + x])/2 + (167*Log[2]^3*Log[1 + x]^2)/168 - 
   (109*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/56 - 
   (13*Log[2]*Log[1 - x]^2*Log[1 + x]^2)/8 + (Log[1 - x]^3*Log[1 + x]^2)/24 + 
   (Log[2]^2*Log[x]*Log[1 + x]^2)/4 - (Log[2]*Log[1 - x]*Log[x]*Log[1 + x]^2)/
    4 - (7*Log[1 - x]^2*Log[x]*Log[1 + x]^2)/8 - (3*Log[2]^2*Log[1 + x]^3)/
    7 + (55*Log[2]*Log[1 - x]*Log[1 + x]^3)/28 + (Log[1 - x]^2*Log[1 + x]^3)/
    2 - (Log[2]*Log[x]*Log[1 + x]^3)/6 + (Log[1 - x]*Log[x]*Log[1 + x]^3)/3 - 
   (29*Log[2]*Log[1 + x]^4)/168 - (193*Log[1 - x]*Log[1 + x]^4)/336 + 
   (Log[x]*Log[1 + x]^4)/16 + (29*Log[1 + x]^5)/240 + 
   (2*Log[2]^3*PolyLog[2, (1 - x)/2])/3 - 
   (3*Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/4 + 
   (Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/4 - 
   (Log[1 - x]^3*PolyLog[2, (1 - x)/2])/12 + 
   (Log[1 - x]^2*Log[x]*PolyLog[2, (1 - x)/2])/4 - 
   (5*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/4 + 
   Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2] - 
   (Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/2 + 
   (3*Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/4 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 + 
   (Log[x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/4 - 
   (Log[1 + x]^3*PolyLog[2, (1 - x)/2])/12 + (Log[2]*PolyLog[2, (1 - x)/2]^2)/
    2 - (Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/2 - (Log[2]^3*PolyLog[2, -x])/
    4 + (Log[2]^2*Log[1 - x]*PolyLog[2, -x])/4 + 
   (Log[2]^2*Log[1 + x]*PolyLog[2, -x])/2 - 
   (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, -x])/2 - 
   (Log[2]*Log[1 + x]^2*PolyLog[2, -x])/4 + 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/4 + (Log[1 + x]^3*PolyLog[2, -x])/
    12 - (Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/2 + 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/2 + 
   (Log[2]^3*PolyLog[2, x])/12 - (Log[2]*Log[1 - x]^2*PolyLog[2, x])/4 - 
   (Log[2]^2*Log[1 + x]*PolyLog[2, x])/4 + 
   (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, x])/2 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/4 - (Log[1 + x]^3*PolyLog[2, x])/
    12 + (Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/2 - 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/2 - 
   (5*Log[2]^2*PolyLog[3, (1 - x)/2])/14 + 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/2])/2 + 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/7 - 
   (5*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/14 + 
   (PolyLog[2, x]*PolyLog[3, (1 - x)/2])/2 - 
   (Log[2]*Log[1 - x]*PolyLog[3, 1 - x])/2 + 
   (Log[2]*Log[1 + x]*PolyLog[3, 1 - x])/2 - (Log[1 + x]^2*PolyLog[3, 1 - x])/
    4 - (Log[2]^2*PolyLog[3, -x])/4 + Log[2]*Log[1 - x]*PolyLog[3, -x] - 
   (Log[2]*Log[1 + x]*PolyLog[3, -x])/2 - Log[1 - x]*Log[1 + x]*
    PolyLog[3, -x] + (2*Log[1 + x]^2*PolyLog[3, -x])/7 - 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, -x])/2 + (Log[2]^2*PolyLog[3, x])/4 - 
   Log[2]*Log[1 - x]*PolyLog[3, x] + (Log[2]*Log[1 + x]*PolyLog[3, x])/2 + 
   Log[1 - x]*Log[1 + x]*PolyLog[3, x] - (Log[1 + x]^2*PolyLog[3, x])/4 + 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, x])/2 + 
   (Log[2]^2*PolyLog[3, (2*x)/(-1 + x)])/4 - Log[2]*Log[1 - x]*
    PolyLog[3, (2*x)/(-1 + x)] + 
   (Log[2]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/2 + 
   Log[1 - x]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)] - 
   (Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/4 + 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (2*x)/(-1 + x)])/2 + 
   (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)])/2 - 
   (Log[2]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/2 - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/2 - 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/14 + 
   (9*Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/28 + 
   (3*Log[2]^2*PolyLog[3, (1 - x)/(1 + x)])/4 - 
   Log[2]*Log[1 - x]*PolyLog[3, (1 - x)/(1 + x)] - 
   (Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/2 + 
   Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)] + 
   (Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)])/4 + 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (1 - x)/(1 + x)])/2 + 
   Pi^2*((83*Log[2]^3)/1008 - (85*Log[2]^2*Log[1 - x])/336 + 
     (Log[2]*Log[1 - x]^2)/6 + Log[1 - x]^3/72 + (Log[2]^2*Log[x])/48 + 
     (Log[2]*Log[1 - x]*Log[x])/12 - (Log[1 - x]^2*Log[x])/16 + 
     (11*Log[2]^2*Log[1 + x])/84 + (3*Log[2]*Log[1 - x]*Log[1 + x])/14 - 
     (Log[1 - x]^2*Log[1 + x])/6 - (Log[2]*Log[x]*Log[1 + x])/24 - 
     (29*Log[2]*Log[1 + x]^2)/112 - (Log[1 - x]*Log[1 + x]^2)/42 + 
     (Log[x]*Log[1 + x]^2)/168 + (31*Log[1 + x]^3)/252 - 
     (5*Log[2]*PolyLog[2, (1 - x)/2])/24 - (Log[1 - x]*PolyLog[2, (1 - x)/2])/
      12 - (Log[x]*PolyLog[2, (1 - x)/2])/24 + 
     (7*Log[1 + x]*PolyLog[2, (1 - x)/2])/24 + (Log[2]*PolyLog[2, -x])/24 - 
     (Log[1 + x]*PolyLog[2, -x])/24 + (Log[2]*PolyLog[2, x])/24 - 
     (Log[1 - x]*PolyLog[2, x])/24 - PolyLog[3, (1 - x)/2]/12 - 
     PolyLog[3, 1 - x]/24 + PolyLog[3, -x]/12 - PolyLog[3, x]/12 - 
     PolyLog[3, (2*x)/(-1 + x)]/12 + (5*PolyLog[3, (1 + x)^(-1)])/168 - 
     PolyLog[3, (1 - x)/(1 + x)]/12 + (11*PolyLog[3, (1 + x)/2])/84) - 
   (23*Log[2]^2*PolyLog[3, (1 + x)/2])/14 + 
   (11*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/14 + 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 + x)/2])/2 + 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2])/2 - 
   (11*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/14 - 
   (5*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/14 - PolyLog[2, (1 - x)/2]*
    PolyLog[3, (1 + x)/2] + (PolyLog[2, x]*PolyLog[3, (1 + x)/2])/2 - 
   4*Log[2]*PolyLog[4, 1/2] - (15*Log[2]*PolyLog[4, (1 - x)/2])/7 - 
   (Log[x]*PolyLog[4, (1 - x)/2])/2 + (15*Log[1 + x]*PolyLog[4, (1 - x)/2])/
    7 + 2*Log[2]*PolyLog[4, 1 - x] - (3*Log[1 + x]*PolyLog[4, 1 - x])/2 + 
   (Log[1 - x]*PolyLog[4, -x])/2 - (3*Log[1 + x]*PolyLog[4, -x])/14 - 
   (Log[1 - x]*PolyLog[4, x])/2 + (Log[1 + x]*PolyLog[4, x])/2 - 
   (Log[1 - x]*PolyLog[4, (4*x)/(1 + x)^2])/4 - 
   2*Log[2]*PolyLog[4, (1 + x)^(-1)] - (Log[1 - x]*PolyLog[4, (1 + x)^(-1)])/
    2 - (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/14 + 
   (31*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/14 - 
   (22*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/7 + 
   (22*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/7 - 
   (3*Log[1 + x]*PolyLog[4, x/(1 + x)])/14 + 
   Log[1 - x]*PolyLog[4, (2*x)/(1 + x)] - (48*Log[2]*PolyLog[4, (1 + x)/2])/
    7 + (33*Log[1 - x]*PolyLog[4, (1 + x)/2])/14 - 
   (Log[x]*PolyLog[4, (1 + x)/2])/2 + (3*Log[1 + x]*PolyLog[4, (1 + x)/2])/
    2 - (Log[2]*PolyLog[4, 1 - x^2])/4 + (Log[1 + x]*PolyLog[4, 1 - x^2])/4 - 
   4*PolyLog[5, 1/2] + PolyLog[5, (1 - x)/2] + (3*PolyLog[5, 1 - x])/2 + 
   PolyLog[5, -x]/4 - (3*PolyLog[5, x])/4 - PolyLog[5, (4*x)/(1 + x)^2]/8 + 
   2*PolyLog[5, (1 + x)^(-1)] - (5*PolyLog[5, (1 - x)/(1 + x)])/4 + 
   (9*PolyLog[5, (-1 + x)/(1 + x)])/4 - PolyLog[5, x/(1 + x)]/2 + 
   PolyLog[5, (2*x)/(1 + x)] - 7*PolyLog[5, (1 + x)/2] - 
   PolyLog[5, 1 - x^2]/8 + (135*Pi^2*Zeta[3])/224 - (7*Log[2]^2*Zeta[3])/4 + 
   ((-67*Log[2]^2)/16 + (267*Log[2]*Log[1 - x])/112 - (7*Log[2]*Log[x])/8 - 
     (3*Log[1 - x]*Log[x])/8 + (83*Log[2]*Log[1 + x])/112 - 
     (79*Log[1 - x]*Log[1 + x])/28 + (13*Log[x]*Log[1 + x])/56 + 
     (179*Log[1 + x]^2)/112 + PolyLog[2, (1 - x)/2]/8 - PolyLog[2, -x]/16 - 
     (13*PolyLog[2, x])/16)*Zeta[3] + 
   Log[1 + x]*((403*Pi^4)/10080 + (Pi^2*Log[2]^2)/48 - Log[2]^4/48 - 
     PolyLog[4, 1/2]/2 - (7*Log[2]*Zeta[3])/16) + 
   Log[1 - x]*((-11*Pi^4)/3360 - (Pi^2*Log[2]^2)/48 + Log[2]^4/48 + 
     PolyLog[4, 1/2]/2 + (7*Log[2]*Zeta[3])/16) + 
   Log[x]*((59*Pi^4)/10080 - (Pi^2*Log[2]^2)/24 + Log[2]^4/24 + 
     PolyLog[4, 1/2] + (7*Log[2]*Zeta[3])/8) + 
   Log[2]*((-317*Pi^4)/10080 - (5*Pi^2*Log[2]^2)/24 + (5*Log[2]^4)/24 + 
     5*PolyLog[4, 1/2] + (35*Log[2]*Zeta[3])/8) + (337*Zeta[5])/112, 
 HPL[{2, -1, -2}, x_] :>  (-5*HPL[{-4, 1}, -x])/16 - (5*HPL[{-4, 1}, x])/16 + 
   (27*HPL[{-4, 1}, (1 - x)/(1 + x)])/16 + 
   (17*HPL[{-4, 1}, (-1 + x)/(1 + x)])/16 - (3*HPL[{3, -2}, -x])/4 - 
   (3*HPL[{3, -2}, x])/4 + HPL[{3, -2}, (1 - x)/(1 + x)] + 
   HPL[{3, -2}, (-1 + x)/(1 + x)] + (11*HPL[{3, 2}, (1 - x)/2])/56 - 
   (75*HPL[{3, 2}, 1 - x])/112 - HPL[{3, 2}, -x]/112 - 
   (65*HPL[{3, 2}, x])/112 + (9*HPL[{3, 2}, x/(-1 + x)])/112 + 
   (3*HPL[{3, 2}, (2*x)/(-1 + x)])/112 - (85*HPL[{3, 2}, (1 + x)^(-1)])/112 + 
   (5*HPL[{3, 2}, (1 - x)/(1 + x)])/7 + (125*HPL[{3, 2}, (-1 + x)/(1 + x)])/
    112 - (55*HPL[{3, 2}, x/(1 + x)])/112 + (67*HPL[{3, 2}, (2*x)/(1 + x)])/
    112 - (23*HPL[{3, 2}, (1 + x)/2])/28 - HPL[{3, 2}, x^2/(-1 + x^2)]/64 + 
   (5*HPL[{-3, -1, 1}, -x])/8 + (5*HPL[{-3, -1, 1}, x])/8 - 
   (5*HPL[{-3, -1, 1}, (1 - x)/(1 + x)])/16 + (5*HPL[{-2, 1, -2}, -x])/8 - 
   (3*HPL[{-2, 1, -2}, x])/8 - (5*HPL[{-2, 1, -2}, (1 - x)/(1 + x)])/16 - 
   (5*HPL[{2, -2, -1}, -x])/8 - (5*HPL[{2, -2, -1}, x])/8 + 
   (5*HPL[{2, -2, -1}, (1 - x)/(1 + x)])/16 + (5*HPL[{-2, -1, -1, 1}, -x])/
    16 + (5*HPL[{-2, -1, -1, 1}, x])/16 - (5*Pi^2*Log[2]^3)/96 + 
   (3*Log[2]^5)/16 - (299*Log[2]^4*Log[1 - x])/896 + 
   (7*Log[2]^3*Log[1 - x]^2)/24 - (69*Log[2]^2*Log[1 - x]^3)/128 + 
   (77*Log[2]*Log[1 - x]^4)/384 - (53*Log[1 - x]^5)/1120 - 
   (5*Log[2]^4*Log[x])/192 - (9*Log[2]^3*Log[1 - x]*Log[x])/32 + 
   (21*Log[2]^2*Log[1 - x]^2*Log[x])/32 - (19*Log[2]*Log[1 - x]^3*Log[x])/
    32 + (195*Log[1 - x]^4*Log[x])/1792 - (261*Log[2]^4*Log[1 + x])/896 + 
   (173*Log[2]^3*Log[1 - x]*Log[1 + x])/224 + 
   (91*Log[2]^2*Log[1 - x]^2*Log[1 + x])/128 + 
   (53*Log[2]*Log[1 - x]^3*Log[1 + x])/192 - (95*Log[1 - x]^4*Log[1 + x])/
    2688 + (9*Log[2]^3*Log[x]*Log[1 + x])/32 - 
   (5*Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/16 + 
   (5*Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/16 - 
   (7*Log[1 - x]^3*Log[x]*Log[1 + x])/192 + (139*Log[2]^3*Log[1 + x]^2)/672 - 
   (1703*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/896 - 
   (35*Log[2]*Log[1 - x]^2*Log[1 + x]^2)/32 + (337*Log[1 - x]^3*Log[1 + x]^2)/
    2688 - (3*Log[2]^2*Log[x]*Log[1 + x]^2)/16 - 
   (107*Log[1 - x]^2*Log[x]*Log[1 + x]^2)/128 + (373*Log[2]^2*Log[1 + x]^3)/
    896 + (2641*Log[2]*Log[1 - x]*Log[1 + x]^3)/1344 + 
   (839*Log[1 - x]^2*Log[1 + x]^3)/2688 + (7*Log[2]*Log[x]*Log[1 + x]^3)/96 + 
   (133*Log[1 - x]*Log[x]*Log[1 + x]^3)/192 - (1915*Log[2]*Log[1 + x]^4)/
    2688 - (1045*Log[1 - x]*Log[1 + x]^4)/1344 - 
   (91*Log[x]*Log[1 + x]^4)/768 + (4*Log[1 + x]^5)/15 + 
   (5*Log[2]^3*PolyLog[2, (1 - x)/2])/12 - 
   (15*Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/32 + 
   (5*Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/32 - 
   (5*Log[1 - x]^3*PolyLog[2, (1 - x)/2])/96 + 
   (5*Log[1 - x]^2*Log[x]*PolyLog[2, (1 - x)/2])/32 - 
   (25*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/32 + 
   (5*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/8 - 
   (5*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/16 + 
   (15*Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/32 - 
   (5*Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/16 + 
   (5*Log[x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/32 - 
   (5*Log[1 + x]^3*PolyLog[2, (1 - x)/2])/96 + 
   (5*Log[2]*PolyLog[2, (1 - x)/2]^2)/16 - 
   (5*Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/16 - (13*Log[2]^3*PolyLog[2, -x])/
    96 - (Log[2]^2*Log[1 - x]*PolyLog[2, -x])/32 - 
   (5*Log[1 - x]^2*Log[x]*PolyLog[2, -x])/16 + 
   (7*Log[2]^2*Log[1 + x]*PolyLog[2, -x])/16 + 
   (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, -x])/16 + 
   (3*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, -x])/8 - 
   (15*Log[2]*Log[1 + x]^2*PolyLog[2, -x])/32 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/32 + 
   (5*Log[1 + x]^3*PolyLog[2, -x])/96 - 
   (5*Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/16 + 
   (5*Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/16 - 
   (5*Log[2]^3*PolyLog[2, x])/96 + (5*Log[2]^2*Log[1 - x]*PolyLog[2, x])/16 - 
   (5*Log[2]*Log[1 - x]^2*PolyLog[2, x])/32 - 
   (5*Log[2]^2*Log[1 + x]*PolyLog[2, x])/32 - 
   (5*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, x])/16 - 
   (5*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, x])/8 + 
   (5*Log[2]*Log[1 + x]^2*PolyLog[2, x])/16 + 
   (5*Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/32 + 
   (11*Log[x]*Log[1 + x]^2*PolyLog[2, x])/16 - (9*Log[1 + x]^3*PolyLog[2, x])/
    32 + (5*Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/16 - 
   (5*Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/16 - 
   (5*Log[1 - x]*PolyLog[2, -x]*PolyLog[2, x])/8 + 
   (3*Log[1 + x]*PolyLog[2, -x]*PolyLog[2, x])/8 - 
   (13*Log[2]^2*PolyLog[3, (1 - x)/2])/224 - 
   (Log[1 - x]^2*PolyLog[3, (1 - x)/2])/64 + Log[1 - x]*Log[x]*
    PolyLog[3, (1 - x)/2] + (13*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/
    112 - (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/2])/32 - 
   (11*Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/2])/16 - 
   (33*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/448 - 
   (3*PolyLog[2, -x]*PolyLog[3, (1 - x)/2])/8 + 
   (15*PolyLog[2, x]*PolyLog[3, (1 - x)/2])/16 - 
   (5*Log[2]*Log[1 - x]*PolyLog[3, 1 - x])/16 - 
   (Log[1 - x]^2*PolyLog[3, 1 - x])/112 - 
   (75*Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/112 + 
   (5*Log[2]*Log[1 + x]*PolyLog[3, 1 - x])/16 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, 1 - x])/16 - 
   (Log[1 + x]^2*PolyLog[3, 1 - x])/8 - (PolyLog[2, -x]*PolyLog[3, 1 - x])/
    4 - (5*PolyLog[2, x]*PolyLog[3, 1 - x])/8 - (5*Log[2]^2*PolyLog[3, -x])/
    32 + (5*Log[2]*Log[1 - x]*PolyLog[3, -x])/8 - 
   (19*Log[1 - x]^2*PolyLog[3, -x])/32 - (5*Log[2]*Log[1 + x]*PolyLog[3, -x])/
    16 - (9*Log[1 - x]*Log[1 + x]*PolyLog[3, -x])/16 + 
   (97*Log[1 + x]^2*PolyLog[3, -x])/224 - 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, -x])/16 + (5*Log[2]^2*PolyLog[3, x])/
    32 - (5*Log[2]*Log[1 - x]*PolyLog[3, x])/8 - (Log[1 - x]^2*PolyLog[3, x])/
    112 + (5*Log[2]*Log[1 + x]*PolyLog[3, x])/16 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, x])/16 - (3*Log[1 + x]^2*PolyLog[3, x])/
    4 + (5*PolyLog[2, (1 - x)/2]*PolyLog[3, x])/16 + 
   (5*Log[2]^2*PolyLog[3, (2*x)/(-1 + x)])/32 - 
   (5*Log[2]*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)])/8 + 
   (3*Log[1 - x]^2*PolyLog[3, (2*x)/(-1 + x)])/224 + 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/16 + 
   (67*Log[1 - x]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/112 - 
   (51*Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/112 + 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, (2*x)/(-1 + x)])/16 + 
   (5*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)])/16 + 
   (Log[1 - x]^2*PolyLog[3, (1 + x)^(-1)])/32 - 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/16 - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/4 + 
   (85*Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/112 + 
   (3*Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/56 + 
   (3*PolyLog[2, -x]*PolyLog[3, (1 + x)^(-1)])/8 + 
   (3*PolyLog[2, x]*PolyLog[3, (1 + x)^(-1)])/4 + 
   (15*Log[2]^2*PolyLog[3, (1 - x)/(1 + x)])/32 - 
   (67*Log[2]*Log[1 - x]*PolyLog[3, (1 - x)/(1 + x)])/112 - 
   (Log[1 - x]^2*PolyLog[3, (1 - x)/(1 + x)])/64 + 
   (5*Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/(1 + x)])/7 - 
   (19*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/56 + 
   (127*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/224 - 
   (5*Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/7 - 
   (65*Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)])/448 + 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, (1 - x)/(1 + x)])/16 - 
   (3*PolyLog[2, -x]*PolyLog[3, (1 - x)/(1 + x)])/8 + 
   (5*PolyLog[2, x]*PolyLog[3, (1 - x)/(1 + x)])/8 + 
   Pi^2*((103*Log[2]^3)/8064 - (85*Log[2]^2*Log[1 - x])/1344 + 
     (377*Log[2]*Log[1 - x]^2)/2688 - (443*Log[1 - x]^3)/8064 + 
     (5*Log[2]^2*Log[x])/384 + (Log[2]*Log[1 - x]*Log[x])/6 - 
     (137*Log[1 - x]^2*Log[x])/2688 + (67*Log[2]^2*Log[1 + x])/2688 - 
     (31*Log[2]*Log[1 - x]*Log[1 + x])/224 - (9*Log[1 - x]^2*Log[1 + x])/
      896 - (9*Log[2]*Log[x]*Log[1 + x])/64 - 
     (17*Log[1 - x]*Log[x]*Log[1 + x])/84 + (5*Log[2]*Log[1 + x]^2)/64 + 
     (79*Log[1 - x]*Log[1 + x]^2)/224 + (2*Log[x]*Log[1 + x]^2)/21 - 
     (25*Log[1 + x]^3)/224 - (25*Log[2]*PolyLog[2, (1 - x)/2])/192 - 
     (5*Log[1 - x]*PolyLog[2, (1 - x)/2])/96 - 
     (5*Log[x]*PolyLog[2, (1 - x)/2])/192 + 
     (35*Log[1 + x]*PolyLog[2, (1 - x)/2])/192 + (Log[2]*PolyLog[2, -x])/64 + 
     (13*Log[1 - x]*PolyLog[2, -x])/96 - (3*Log[1 + x]*PolyLog[2, -x])/64 + 
     (5*Log[2]*PolyLog[2, x])/64 - (5*Log[1 - x]*PolyLog[2, x])/64 + 
     (11*Log[1 + x]*PolyLog[2, x])/48 - (43*PolyLog[3, (1 - x)/2])/192 + 
     (115*PolyLog[3, 1 - x])/1344 + (5*PolyLog[3, -x])/96 - 
     (5*PolyLog[3, x])/96 - (5*PolyLog[3, (2*x)/(-1 + x)])/96 + 
     (205*PolyLog[3, (1 + x)^(-1)])/1344 - (307*PolyLog[3, (1 - x)/(1 + x)])/
      1344 - (39*PolyLog[3, (1 + x)/2])/448) - 
   (197*Log[2]^2*PolyLog[3, (1 + x)/2])/224 + 
   (23*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/28 - 
   (Log[1 - x]^2*PolyLog[3, (1 + x)/2])/64 + Log[1 - x]*Log[x]*
    PolyLog[3, (1 + x)/2] + (15*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2])/16 - 
   (191*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/224 - 
   (11*Log[x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/16 - 
   (33*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/448 - 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, (1 + x)/2])/8 + 
   (PolyLog[2, -x]*PolyLog[3, (1 + x)/2])/4 + 
   (5*PolyLog[2, x]*PolyLog[3, (1 + x)/2])/16 + (15*Log[2]*PolyLog[4, 1/2])/
    8 - (39*Log[2]*PolyLog[4, (1 - x)/2])/112 - 
   (5*Log[x]*PolyLog[4, (1 - x)/2])/16 + 
   (39*Log[1 + x]*PolyLog[4, (1 - x)/2])/112 + (5*Log[2]*PolyLog[4, 1 - x])/
    4 + (5*Log[1 - x]*PolyLog[4, 1 - x])/4 + (225*Log[x]*PolyLog[4, 1 - x])/
    112 - (25*Log[1 + x]*PolyLog[4, 1 - x])/16 + 
   (9*Log[1 - x]*PolyLog[4, -x])/16 - (67*Log[1 + x]*PolyLog[4, -x])/112 + 
   (125*Log[1 - x]*PolyLog[4, x])/112 + (9*Log[1 + x]*PolyLog[4, x])/16 - 
   (113*Log[1 - x]*PolyLog[4, x/(-1 + x)])/112 + 
   (5*Log[1 + x]*PolyLog[4, x/(-1 + x)])/8 + 
   (9*Log[1 - x]*PolyLog[4, (2*x)/(-1 + x)])/112 - 
   (9*Log[1 + x]*PolyLog[4, (2*x)/(-1 + x)])/112 - 
   (5*Log[1 - x]*PolyLog[4, (4*x)/(1 + x)^2])/16 + 
   (5*Log[1 + x]*PolyLog[4, (4*x)/(1 + x)^2])/16 - 
   (5*Log[2]*PolyLog[4, (1 + x)^(-1)])/4 - 
   (35*Log[1 - x]*PolyLog[4, (1 + x)^(-1)])/16 + 
   (255*Log[x]*PolyLog[4, (1 + x)^(-1)])/112 + 
   (25*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/112 - 
   (8*Log[2]*PolyLog[4, (1 - x)/(1 + x)])/7 - 
   (15*Log[x]*PolyLog[4, (1 - x)/(1 + x)])/7 + 
   (8*Log[1 + x]*PolyLog[4, (1 - x)/(1 + x)])/7 - 
   (57*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/28 + 
   Log[x]*PolyLog[4, (-1 + x)/(1 + x)] + 
   (57*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/28 - 
   (15*Log[1 - x]*PolyLog[4, x/(1 + x)])/8 - 
   (25*Log[1 + x]*PolyLog[4, x/(1 + x)])/112 + 
   (79*Log[1 - x]*PolyLog[4, (2*x)/(1 + x)])/112 - 
   (79*Log[1 + x]*PolyLog[4, (2*x)/(1 + x)])/112 - 
   (381*Log[2]*PolyLog[4, (1 + x)/2])/112 - 
   (Log[1 - x]*PolyLog[4, (1 + x)/2])/28 - (5*Log[x]*PolyLog[4, (1 + x)/2])/
    16 + (55*Log[1 + x]*PolyLog[4, (1 + x)/2])/16 - 
   (5*Log[2]*PolyLog[4, 1 - x^2])/32 - (5*Log[1 - x]*PolyLog[4, 1 - x^2])/
    16 + (5*Log[1 + x]*PolyLog[4, 1 - x^2])/32 + 
   (17*Log[1 - x]*PolyLog[4, x^2/(-1 + x^2)])/64 - 
   (3*Log[1 + x]*PolyLog[4, x^2/(-1 + x^2)])/64 + (15*PolyLog[5, 1/2])/8 + 
   (7*PolyLog[5, (1 - x)/2])/16 + PolyLog[5, 1 - x]/16 - 
   (5*PolyLog[5, -x])/16 - (5*PolyLog[5, x])/16 + 
   (5*PolyLog[5, (-4*x)/(1 - x)^2])/64 - (5*PolyLog[5, x/(-1 + x)])/16 + 
   (5*PolyLog[5, (4*x)/(1 + x)^2])/64 - (5*PolyLog[5, (1 + x)^(-1)])/4 + 
   (9*PolyLog[5, (1 - x)/(1 + x)])/32 + (79*PolyLog[5, (-1 + x)/(1 + x)])/
    32 - (5*PolyLog[5, x/(1 + x)])/16 - (107*PolyLog[5, (1 + x)/2])/16 + 
   PolyLog[5, 1 - x^2]/32 + (159*Pi^2*Zeta[3])/224 + 
   (105*Log[2]^2*Zeta[3])/128 + 
   ((-5*Log[2]^2)/64 - (153*Log[2]*Log[1 - x])/896 - 
     (639*Log[1 - x]^2)/1792 - (35*Log[2]*Log[x])/64 - 
     (67*Log[1 - x]*Log[x])/112 - (1177*Log[2]*Log[1 + x])/896 - 
     (369*Log[1 - x]*Log[1 + x])/128 + (87*Log[x]*Log[1 + x])/112 + 
     (1899*Log[1 + x]^2)/1792 + (5*PolyLog[2, (1 - x)/2])/64 + 
     (41*PolyLog[2, -x])/128 - (231*PolyLog[2, x])/128)*Zeta[3] + 
   Log[1 + x]*((1153*Pi^4)/26880 + (25*Pi^2*Log[2]^2)/384 - 
     (25*Log[2]^4)/384 - (25*PolyLog[4, 1/2])/16 - (175*Log[2]*Zeta[3])/
      128) + Log[2]*((-359*Pi^4)/10080 + (5*Pi^2*Log[2]^2)/96 - 
     (5*Log[2]^4)/96 - (5*PolyLog[4, 1/2])/4 - (35*Log[2]*Zeta[3])/32) + 
   Log[x]*((-961*Pi^4)/80640 - (5*Pi^2*Log[2]^2)/192 + (5*Log[2]^4)/192 + 
     (5*PolyLog[4, 1/2])/8 + (35*Log[2]*Zeta[3])/64) + 
   Log[1 - x]*((169*Pi^4)/20160 - (65*Pi^2*Log[2]^2)/384 + 
     (65*Log[2]^4)/384 + (65*PolyLog[4, 1/2])/16 + (455*Log[2]*Zeta[3])/
      128) + (6289*Zeta[5])/3584, HPL[{2, -1, 2}, x_] :>  
  -HPL[{-2, 1, -2}, -x], HPL[{2, -1, 1, -1}, x_] :>  
  HPL[{-4, 1}, -x]/2 + HPL[{-4, 1}, x] + HPL[{-4, 1}, (1 - x)/(1 + x)] + 
   2*HPL[{-4, 1}, (-1 + x)/(1 + x)] - HPL[{3, -2}, (1 - x)/(1 + x)]/2 - 
   HPL[{3, -2}, (-1 + x)/(1 + x)]/2 + (11*HPL[{3, 2}, (1 - x)/2])/14 + 
   HPL[{3, 2}, 1 - x]/7 - HPL[{3, 2}, -x]/14 - HPL[{3, 2}, x]/7 + 
   HPL[{3, 2}, x/(-1 + x)]/7 - HPL[{3, 2}, (1 + x)^(-1)]/14 - 
   (25*HPL[{3, 2}, (-1 + x)/(1 + x)])/14 + HPL[{3, 2}, x/(1 + x)]/14 + 
   (31*HPL[{3, 2}, (1 + x)/2])/14 + HPL[{-3, -1, 1}, (1 - x)/(1 + x)]/2 + 
   HPL[{-2, 1, -2}, (1 - x)/(1 + x)]/2 - 
   (3*HPL[{2, -2, -1}, (1 - x)/(1 + x)])/2 - HPL[{-2, -1, -1, 1}, -x]/2 - 
   HPL[{-2, -1, -1, 1}, x]/2 - HPL[{-2, -1, 1, -1}, x] - 
   HPL[{2, 1, -1}, -x]*Log[2] - HPL[{2, 1, -1}, x]*Log[2] - 
   (Pi^2*Log[2]^3)/18 - (2*Log[2]^5)/15 - (2*Log[2]^4*Log[1 - x])/21 + 
   (Log[2]^3*Log[1 - x]^2)/8 + (5*Log[2]^2*Log[1 - x]^3)/24 + 
   (11*Log[2]*Log[1 - x]^4)/96 - (11*Log[1 - x]^5)/280 + 
   (Log[2]^4*Log[x])/24 + (Log[2]^3*Log[1 - x]*Log[x])/12 - 
   Log[2]^2*Log[1 - x]^2*Log[x] + (Log[2]*Log[1 - x]^3*Log[x])/4 + 
   (Log[1 - x]^4*Log[x])/21 + (59*Log[2]^4*Log[1 + x])/56 - 
   (17*Log[2]^3*Log[1 - x]*Log[1 + x])/84 - 
   (3*Log[2]^2*Log[1 - x]^2*Log[1 + x])/4 - 
   (7*Log[2]*Log[1 - x]^3*Log[1 + x])/24 - (Log[1 - x]^4*Log[1 + x])/16 - 
   (Log[2]^3*Log[x]*Log[1 + x])/12 + 
   (3*Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/2 + 
   (Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/2 + 
   (Log[1 - x]^3*Log[x]*Log[1 + x])/6 - (103*Log[2]^3*Log[1 + x]^2)/56 + 
   (73*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/56 + 
   (9*Log[2]*Log[1 - x]^2*Log[1 + x]^2)/16 + (Log[1 - x]^3*Log[1 + x]^2)/24 - 
   (3*Log[2]^2*Log[x]*Log[1 + x]^2)/4 - 2*Log[2]*Log[1 - x]*Log[x]*
    Log[1 + x]^2 - (5*Log[1 - x]^2*Log[x]*Log[1 + x]^2)/8 + 
   (26*Log[2]^2*Log[1 + x]^3)/21 - (181*Log[2]*Log[1 - x]*Log[1 + x]^3)/168 + 
   (Log[1 - x]^2*Log[1 + x]^3)/8 + (11*Log[2]*Log[x]*Log[1 + x]^3)/12 + 
   (Log[1 - x]*Log[x]*Log[1 + x]^3)/3 - (11*Log[2]*Log[1 + x]^4)/672 + 
   (101*Log[1 - x]*Log[1 + x]^4)/336 + (Log[x]*Log[1 + x]^4)/48 - 
   (151*Log[1 + x]^5)/420 - (4*Log[2]^3*PolyLog[2, (1 - x)/2])/3 + 
   (5*Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/4 - 
   (Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/4 + 
   (Log[1 - x]^3*PolyLog[2, (1 - x)/2])/12 - 
   (Log[1 - x]^2*Log[x]*PolyLog[2, (1 - x)/2])/4 + 
   (11*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/4 - 
   2*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2] + 
   (Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/2 - 
   (7*Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/4 + 
   Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2] - 
   (Log[x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/4 + 
   (Log[1 + x]^3*PolyLog[2, (1 - x)/2])/4 - Log[2]*PolyLog[2, (1 - x)/2]^2 + 
   Log[1 + x]*PolyLog[2, (1 - x)/2]^2 + (Log[2]^3*PolyLog[2, -x])/4 + 
   (Log[2]^2*Log[1 - x]*PolyLog[2, -x])/4 - Log[2]^2*Log[1 + x]*
    PolyLog[2, -x] - (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, -x])/2 + 
   (3*Log[2]*Log[1 + x]^2*PolyLog[2, -x])/4 + 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/4 - (Log[1 + x]^3*PolyLog[2, -x])/
    4 + (Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/2 - 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/2 - 
   (Log[2]^3*PolyLog[2, x])/12 - (Log[2]^2*Log[1 - x]*PolyLog[2, x])/2 + 
   (Log[2]*Log[1 - x]^2*PolyLog[2, x])/4 + 
   (3*Log[2]^2*Log[1 + x]*PolyLog[2, x])/4 - 
   (Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, x])/2 - 
   (Log[2]*Log[1 + x]^2*PolyLog[2, x])/2 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/4 + (Log[1 + x]^3*PolyLog[2, x])/
    4 - (Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/2 + 
   (Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/2 + 
   (9*Log[2]^2*PolyLog[3, (1 - x)/2])/14 - 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/2])/2 - 
   (9*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/7 + 
   (9*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/14 - 
   (PolyLog[2, x]*PolyLog[3, (1 - x)/2])/2 + 
   (Log[2]*Log[1 - x]*PolyLog[3, 1 - x])/2 - (Log[1 - x]^2*PolyLog[3, 1 - x])/
    14 + (Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/7 - 
   (3*Log[2]*Log[1 + x]*PolyLog[3, 1 - x])/2 + 
   (Log[1 + x]^2*PolyLog[3, 1 - x])/4 + (Log[2]^2*PolyLog[3, -x])/4 - 
   Log[2]*Log[1 - x]*PolyLog[3, -x] + (Log[2]*Log[1 + x]*PolyLog[3, -x])/2 - 
   (2*Log[1 + x]^2*PolyLog[3, -x])/7 + (PolyLog[2, (1 - x)/2]*PolyLog[3, -x])/
    2 - (Log[2]^2*PolyLog[3, x])/4 + Log[2]*Log[1 - x]*PolyLog[3, x] - 
   (Log[1 - x]^2*PolyLog[3, x])/14 - (Log[2]*Log[1 + x]*PolyLog[3, x])/2 + 
   (Log[1 + x]^2*PolyLog[3, x])/4 - (PolyLog[2, (1 - x)/2]*PolyLog[3, x])/2 - 
   (Log[2]^2*PolyLog[3, (2*x)/(-1 + x)])/4 + Log[2]*Log[1 - x]*
    PolyLog[3, (2*x)/(-1 + x)] - 
   (Log[2]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/2 + 
   (Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/4 - 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (2*x)/(-1 + x)])/2 - 
   (3*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)])/2 + 
   (Log[2]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/2 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/2 + 
   (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/14 - 
   (9*Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/28 - 
   (7*Log[2]^2*PolyLog[3, (1 - x)/(1 + x)])/4 + 
   Log[2]*Log[1 - x]*PolyLog[3, (1 - x)/(1 + x)] + 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/2 - 
   (5*Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)])/4 - 
   (PolyLog[2, (1 - x)/2]*PolyLog[3, (1 - x)/(1 + x)])/2 + 
   Pi^2*((-155*Log[2]^3)/1008 + (93*Log[2]^2*Log[1 - x])/112 - 
     (5*Log[2]*Log[1 - x]^2)/48 - Log[1 - x]^3/504 - (Log[2]^2*Log[x])/48 - 
     (Log[2]*Log[1 - x]*Log[x])/12 - (Log[1 - x]^2*Log[x])/112 - 
     (55*Log[2]^2*Log[1 + x])/168 - (167*Log[2]*Log[1 - x]*Log[1 + x])/168 - 
     (Log[1 - x]^2*Log[1 + x])/8 + (Log[2]*Log[x]*Log[1 + x])/24 + 
     (Log[1 - x]*Log[x]*Log[1 + x])/6 + (29*Log[2]*Log[1 + x]^2)/84 + 
     (59*Log[1 - x]*Log[1 + x]^2)/168 - (5*Log[x]*Log[1 + x]^2)/56 + 
     (41*Log[1 + x]^3)/252 + (3*Log[2]*PolyLog[2, (1 - x)/2])/8 + 
     (Log[1 - x]*PolyLog[2, (1 - x)/2])/12 + (Log[x]*PolyLog[2, (1 - x)/2])/
      24 - (11*Log[1 + x]*PolyLog[2, (1 - x)/2])/24 - 
     (Log[2]*PolyLog[2, -x])/24 + (Log[1 + x]*PolyLog[2, -x])/24 - 
     (Log[2]*PolyLog[2, x])/24 + (Log[1 - x]*PolyLog[2, x])/24 + 
     PolyLog[3, (1 - x)/2]/12 + PolyLog[3, 1 - x]/56 - PolyLog[3, -x]/12 + 
     PolyLog[3, x]/12 + PolyLog[3, (2*x)/(-1 + x)]/12 - 
     (5*PolyLog[3, (1 + x)^(-1)])/168 + PolyLog[3, (1 - x)/(1 + x)]/12 - 
     (17*PolyLog[3, (1 + x)/2])/84) + (33*Log[2]^2*PolyLog[3, (1 + x)/2])/
    14 - (17*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/14 - 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 + x)/2])/2 - 
   (7*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2])/2 + 
   (31*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/14 + 
   (9*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/14 + 2*PolyLog[2, (1 - x)/2]*
    PolyLog[3, (1 + x)/2] - (PolyLog[2, x]*PolyLog[3, (1 + x)/2])/2 + 
   2*Log[2]*PolyLog[4, 1/2] + (34*Log[2]*PolyLog[4, (1 - x)/2])/7 + 
   (Log[x]*PolyLog[4, (1 - x)/2])/2 - (27*Log[1 + x]*PolyLog[4, (1 - x)/2])/
    7 - 5*Log[2]*PolyLog[4, 1 - x] - (3*Log[x]*PolyLog[4, 1 - x])/7 + 
   (11*Log[1 + x]*PolyLog[4, 1 - x])/2 - Log[1 - x]*PolyLog[4, -x] + 
   (5*Log[1 + x]*PolyLog[4, -x])/7 + (3*Log[1 - x]*PolyLog[4, x])/7 - 
   Log[1 + x]*PolyLog[4, x] + 2*Log[2]*PolyLog[4, x/(-1 + x)] + 
   (3*Log[1 - x]*PolyLog[4, x/(-1 + x)])/7 - 
   4*Log[1 + x]*PolyLog[4, x/(-1 + x)] - Log[2]*PolyLog[4, (2*x)/(-1 + x)] + 
   2*Log[1 + x]*PolyLog[4, (2*x)/(-1 + x)] - 
   (Log[1 + x]*PolyLog[4, (4*x)/(1 + x)^2])/4 + 
   5*Log[2]*PolyLog[4, (1 + x)^(-1)] + (Log[1 - x]*PolyLog[4, (1 + x)^(-1)])/
    2 + (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/14 - 
   (87*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/14 - 
   (Log[2]*PolyLog[4, (1 - x)/(1 + x)])/2 + 
   (47*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/14 - 
   2*Log[x]*PolyLog[4, (-1 + x)/(1 + x)] - 
   (20*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/7 + 
   2*Log[2]*PolyLog[4, x/(1 + x)] - (53*Log[1 + x]*PolyLog[4, x/(1 + x)])/
    14 - Log[2]*PolyLog[4, (2*x)/(1 + x)] + 
   3*Log[1 + x]*PolyLog[4, (2*x)/(1 + x)] + (64*Log[2]*PolyLog[4, (1 + x)/2])/
    7 - (93*Log[1 - x]*PolyLog[4, (1 + x)/2])/14 + 
   (Log[x]*PolyLog[4, (1 + x)/2])/2 - (9*Log[1 + x]*PolyLog[4, (1 + x)/2])/
    2 + (3*Log[2]*PolyLog[4, 1 - x^2])/4 - (3*Log[1 + x]*PolyLog[4, 1 - x^2])/
    4 - (Log[2]*PolyLog[4, x^2/(-1 + x^2)])/4 + 
   (Log[1 + x]*PolyLog[4, x^2/(-1 + x^2)])/2 + 2*PolyLog[5, 1/2] - 
   3*PolyLog[5, (1 - x)/2] - (3*PolyLog[5, 1 - x])/2 + (5*PolyLog[5, -x])/4 + 
   PolyLog[5, x]/4 + PolyLog[5, (-4*x)/(1 - x)^2]/4 + 
   PolyLog[5, x/(-1 + x)] - 2*PolyLog[5, (2*x)/(-1 + x)] + 
   PolyLog[5, (4*x)/(1 + x)^2]/8 - 2*PolyLog[5, (1 + x)^(-1)] + 
   (13*PolyLog[5, (1 - x)/(1 + x)])/4 - PolyLog[5, (-1 + x)/(1 + x)]/4 + 
   PolyLog[5, x/(1 + x)]/2 - PolyLog[5, (2*x)/(1 + x)] + 
   10*PolyLog[5, (1 + x)/2] + PolyLog[5, 1 - x^2]/8 - (19*Pi^2*Zeta[3])/28 + 
   (7*Log[2]^2*Zeta[3])/8 + ((133*Log[2]^2)/16 - (657*Log[2]*Log[1 - x])/
      112 + (3*Log[1 - x]^2)/14 + (7*Log[2]*Log[x])/8 - 
     (27*Log[1 - x]*Log[x])/28 - (225*Log[2]*Log[1 + x])/112 + 
     (31*Log[1 - x]*Log[1 + x])/7 + (39*Log[x]*Log[1 + x])/28 - 
     (499*Log[1 + x]^2)/112 - (9*PolyLog[2, (1 - x)/2])/8 + 
     (3*PolyLog[2, -x])/16 + (11*PolyLog[2, x])/16)*Zeta[3] + 
   Log[2]*((25*Pi^4)/1008 + (3*Pi^2*Log[2]^2)/8 - (3*Log[2]^4)/8 - 
     9*PolyLog[4, 1/2] - (63*Log[2]*Zeta[3])/8) + 
   Log[x]*((-23*Pi^4)/1120 + (Pi^2*Log[2]^2)/24 - Log[2]^4/24 - 
     PolyLog[4, 1/2] - (7*Log[2]*Zeta[3])/8) + 
   Log[1 - x]*((323*Pi^4)/5040 + (Pi^2*Log[2]^2)/48 - Log[2]^4/48 - 
     PolyLog[4, 1/2]/2 - (7*Log[2]*Zeta[3])/16) + 
   Log[1 + x]*((-17*Pi^4)/210 - (17*Pi^2*Log[2]^2)/48 + (17*Log[2]^4)/48 + 
     (17*PolyLog[4, 1/2])/2 + (119*Log[2]*Zeta[3])/16) - (199*Zeta[5])/448, 
 HPL[{2, -1, 1, 1}, x_] :>  -HPL[{-4, 1}, -x]/2 - HPL[{-4, 1}, x] - 
   2*HPL[{-4, 1}, (1 - x)/(1 + x)] - 2*HPL[{-4, 1}, (-1 + x)/(1 + x)] - 
   HPL[{3, -2}, (-1 + x)/(1 + x)] - (5*HPL[{3, 2}, (1 - x)/2])/7 - 
   HPL[{3, 2}, 1 - x]/7 + HPL[{3, 2}, -x]/14 + HPL[{3, 2}, x]/7 - 
   HPL[{3, 2}, x/(-1 + x)]/7 + HPL[{3, 2}, (1 + x)^(-1)]/14 - 
   (2*HPL[{3, 2}, (-1 + x)/(1 + x)])/7 - HPL[{3, 2}, x/(1 + x)]/14 - 
   (2*HPL[{3, 2}, (1 + x)/2])/7 + HPL[{-3, -1, 1}, (1 - x)/(1 + x)] + 
   HPL[{2, -2, -1}, (1 - x)/(1 + x)] + HPL[{-2, -1, -1, 1}, x] + 
   HPL[{-2, -1, 1, -1}, x] + HPL[{2, 1, -1}, -x]*Log[2] + 
   HPL[{2, 1, -1}, x]*Log[2] + (7*Pi^2*Log[2]^3)/36 - (11*Log[2]^5)/40 + 
   HPL[{2, 1, -1}, x]*Log[1 - x] + (9*Log[2]^4*Log[1 - x])/28 + 
   (Log[2]^2*Log[1 - x]^3)/12 - (35*Log[2]*Log[1 - x]^4)/96 + 
   (517*Log[1 - x]^5)/3360 + (Log[2]^4*Log[x])/12 + 
   (Log[2]^3*Log[1 - x]*Log[x])/6 + (Log[2]^2*Log[1 - x]^2*Log[x])/4 + 
   (5*Log[2]*Log[1 - x]^3*Log[x])/12 - (8*Log[1 - x]^4*Log[x])/21 - 
   HPL[{2, 1, -1}, x]*Log[1 + x] - (Log[2]^4*Log[1 + x])/14 - 
   (20*Log[2]^3*Log[1 - x]*Log[1 + x])/21 - 
   (Log[2]^2*Log[1 - x]^2*Log[1 + x])/2 + (17*Log[2]*Log[1 - x]^3*Log[1 + x])/
    24 - (Log[1 - x]^4*Log[1 + x])/96 - (Log[2]^3*Log[x]*Log[1 + x])/6 - 
   (3*Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/2 - 
   (Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/4 + 
   (2*Log[1 - x]^3*Log[x]*Log[1 + x])/3 + (19*Log[2]^3*Log[1 + x]^2)/42 + 
   (47*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/28 + 
   (Log[2]*Log[1 - x]^2*Log[1 + x]^2)/16 - (17*Log[1 - x]^3*Log[1 + x]^2)/
    48 + (3*Log[2]^2*Log[x]*Log[1 + x]^2)/4 + 
   (7*Log[2]*Log[1 - x]*Log[x]*Log[1 + x]^2)/4 - (71*Log[2]^2*Log[1 + x]^3)/
    84 - (209*Log[2]*Log[1 - x]*Log[1 + x]^3)/168 - 
   (5*Log[1 - x]^2*Log[1 + x]^3)/48 - (7*Log[2]*Log[x]*Log[1 + x]^3)/12 - 
   (2*Log[1 - x]*Log[x]*Log[1 + x]^3)/3 + (283*Log[2]*Log[1 + x]^4)/672 + 
   (107*Log[1 - x]*Log[1 + x]^4)/224 + (Log[x]*Log[1 + x]^4)/16 + 
   Log[1 + x]^5/32 + (2*Log[2]^3*PolyLog[2, (1 - x)/2])/3 - 
   (Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/2 - 
   (3*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/2 + 
   Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2] + 
   Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2] - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - 
   (Log[1 + x]^3*PolyLog[2, (1 - x)/2])/6 + (Log[2]*PolyLog[2, (1 - x)/2]^2)/
    2 - (Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/2 - 
   (Log[2]^2*Log[1 - x]*PolyLog[2, -x])/2 + 
   (Log[2]^2*Log[1 + x]*PolyLog[2, -x])/2 + Log[2]*Log[1 - x]*Log[1 + x]*
    PolyLog[2, -x] - (Log[2]*Log[1 + x]^2*PolyLog[2, -x])/2 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/2 + (Log[1 + x]^3*PolyLog[2, -x])/
    6 + (Log[2]^3*PolyLog[2, x])/3 + (Log[2]*Log[1 - x]^2*PolyLog[2, x])/2 - 
   Log[2]^2*Log[1 + x]*PolyLog[2, x] + 
   (Log[1 - x]^2*Log[1 + x]*PolyLog[2, x])/2 + Log[2]*Log[1 + x]^2*
    PolyLog[2, x] - (Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/2 - 
   (Log[1 + x]^3*PolyLog[2, x])/6 + (Log[2]^2*PolyLog[3, (1 - x)/2])/7 - 
   Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/2] - 
   (2*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/7 + 
   (Log[1 + x]^2*PolyLog[3, (1 - x)/2])/7 - 
   PolyLog[2, x]*PolyLog[3, (1 - x)/2] + (Log[1 - x]^2*PolyLog[3, 1 - x])/
    14 - (Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/7 + 
   Log[2]*Log[1 + x]*PolyLog[3, 1 - x] + Log[1 - x]*Log[1 + x]*
    PolyLog[3, 1 - x] - Log[1 + x]^2*PolyLog[3, 1 - x] + 
   (Log[1 - x]^2*PolyLog[3, -x])/2 + (Log[1 + x]^2*PolyLog[3, -x])/28 - 
   (3*Log[1 - x]^2*PolyLog[3, x])/7 - 
   (Log[1 - x]^2*PolyLog[3, (2*x)/(-1 + x)])/2 + 
   Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)] + 
   (Log[1 - x]^2*PolyLog[3, (1 + x)^(-1)])/2 - Log[1 - x]*Log[1 + x]*
    PolyLog[3, (1 + x)^(-1)] - (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/
    14 + (Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/14 + 
   Log[2]^2*PolyLog[3, (1 - x)/(1 + x)] - 
   (Log[1 - x]^2*PolyLog[3, (1 - x)/(1 + x)])/2 - 
   2*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)] + 
   Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)] + 
   Pi^2*((5*Log[2]^3)/56 - (11*Log[2]^2*Log[1 - x])/21 - 
     (7*Log[2]*Log[1 - x]^2)/48 + (15*Log[1 - x]^3)/112 - 
     (Log[2]^2*Log[x])/12 - (Log[2]*Log[1 - x]*Log[x])/12 + 
     (5*Log[1 - x]^2*Log[x])/168 + (3*Log[2]^2*Log[1 + x])/14 + 
     (33*Log[2]*Log[1 - x]*Log[1 + x])/56 + (Log[1 - x]^2*Log[1 + x])/16 + 
     (Log[2]*Log[x]*Log[1 + x])/12 + (Log[1 - x]*Log[x]*Log[1 + x])/12 + 
     (11*Log[2]*Log[1 + x]^2)/336 - (33*Log[1 - x]*Log[1 + x]^2)/112 - 
     (Log[x]*Log[1 + x]^2)/28 - (191*Log[1 + x]^3)/1008 - 
     (Log[2]*PolyLog[2, (1 - x)/2])/6 + (Log[1 + x]*PolyLog[2, (1 - x)/2])/
      6 - (Log[2]*PolyLog[2, x])/6 + (Log[1 - x]*PolyLog[2, x])/12 + 
     (Log[1 + x]*PolyLog[2, x])/12 + PolyLog[3, (1 - x)/2]/6 + 
     PolyLog[3, 1 - x]/42 - PolyLog[3, (1 + x)^(-1)]/84 + 
     (3*PolyLog[3, (1 + x)/2])/14) - (Log[2]^2*PolyLog[3, (1 + x)/2])/7 + 
   (2*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/7 - 
   (Log[1 - x]^2*PolyLog[3, (1 + x)/2])/2 - Log[1 - x]*Log[x]*
    PolyLog[3, (1 + x)/2] - (2*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/
    7 + (Log[1 + x]^2*PolyLog[3, (1 + x)/2])/7 - 
   PolyLog[2, (1 - x)/2]*PolyLog[3, (1 + x)/2] - 
   PolyLog[2, x]*PolyLog[3, (1 + x)/2] - 7*Log[2]*PolyLog[4, 1/2] - 
   (15*Log[2]*PolyLog[4, (1 - x)/2])/7 - Log[1 - x]*PolyLog[4, (1 - x)/2] + 
   Log[x]*PolyLog[4, (1 - x)/2] + (15*Log[1 + x]*PolyLog[4, (1 - x)/2])/7 + 
   3*Log[2]*PolyLog[4, 1 - x] - Log[1 - x]*PolyLog[4, 1 - x] + 
   (3*Log[x]*PolyLog[4, 1 - x])/7 - 3*Log[1 + x]*PolyLog[4, 1 - x] + 
   (Log[1 - x]*PolyLog[4, -x])/2 - (3*Log[1 + x]*PolyLog[4, -x])/14 + 
   (Log[1 - x]*PolyLog[4, x])/14 + (Log[1 + x]*PolyLog[4, x])/2 - 
   2*Log[2]*PolyLog[4, x/(-1 + x)] + (11*Log[1 - x]*PolyLog[4, x/(-1 + x)])/
    7 + 2*Log[1 + x]*PolyLog[4, x/(-1 + x)] + 
   Log[2]*PolyLog[4, (2*x)/(-1 + x)] - 
   Log[1 - x]*PolyLog[4, (2*x)/(-1 + x)] - 
   Log[1 + x]*PolyLog[4, (2*x)/(-1 + x)] + 
   (Log[1 - x]*PolyLog[4, (4*x)/(1 + x)^2])/4 - 
   3*Log[2]*PolyLog[4, (1 + x)^(-1)] - (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/
    14 + (45*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/14 + 
   (Log[2]*PolyLog[4, (1 - x)/(1 + x)])/2 + 
   (Log[1 - x]*PolyLog[4, (1 - x)/(1 + x)])/2 - 
   (Log[1 + x]*PolyLog[4, (1 - x)/(1 + x)])/2 + 
   (5*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/14 - 
   (Log[1 - x]*PolyLog[4, (-1 + x)/(1 + x)])/2 - 
   (5*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/14 - 
   2*Log[2]*PolyLog[4, x/(1 + x)] + 2*Log[1 - x]*PolyLog[4, x/(1 + x)] + 
   (25*Log[1 + x]*PolyLog[4, x/(1 + x)])/14 + 
   Log[2]*PolyLog[4, (2*x)/(1 + x)] - 2*Log[1 - x]*
    PolyLog[4, (2*x)/(1 + x)] - Log[1 + x]*PolyLog[4, (2*x)/(1 + x)] - 
   (6*Log[2]*PolyLog[4, (1 + x)/2])/7 + (20*Log[1 - x]*PolyLog[4, (1 + x)/2])/
    7 + Log[x]*PolyLog[4, (1 + x)/2] - (Log[2]*PolyLog[4, 1 - x^2])/2 + 
   (Log[1 + x]*PolyLog[4, 1 - x^2])/2 + (Log[2]*PolyLog[4, x^2/(-1 + x^2)])/
    4 - (Log[1 - x]*PolyLog[4, x^2/(-1 + x^2)])/4 - 
   (Log[1 + x]*PolyLog[4, x^2/(-1 + x^2)])/4 - 7*PolyLog[5, 1/2] + 
   2*PolyLog[5, (1 - x)/2] - (5*PolyLog[5, -x])/4 - PolyLog[5, x]/4 - 
   PolyLog[5, (-4*x)/(1 - x)^2]/4 - PolyLog[5, x/(-1 + x)] + 
   2*PolyLog[5, (2*x)/(-1 + x)] - PolyLog[5, (4*x)/(1 + x)^2]/8 - 
   PolyLog[5, (1 + x)^(-1)]/2 - 2*PolyLog[5, (1 - x)/(1 + x)] - 
   2*PolyLog[5, (-1 + x)/(1 + x)] - PolyLog[5, x/(1 + x)]/2 + 
   PolyLog[5, (2*x)/(1 + x)] + 2*PolyLog[5, (1 + x)/2] - 
   (13*Pi^2*Zeta[3])/224 - (49*Log[2]^2*Zeta[3])/16 + 
   ((-101*Log[2]^2)/16 + (179*Log[2]*Log[1 - x])/56 + (81*Log[1 - x]^2)/112 + 
     (7*Log[2]*Log[x])/4 + (5*Log[1 - x]*Log[x])/7 + 
     (87*Log[2]*Log[1 + x])/56 - (81*Log[1 - x]*Log[1 + x])/56 - 
     (8*Log[x]*Log[1 + x])/7 + (235*Log[1 + x]^2)/112 + 
     PolyLog[2, (1 - x)/2] - PolyLog[2, -x]/8 + (15*PolyLog[2, x])/8)*
    Zeta[3] + Log[1 + x]*((-29*Pi^4)/1008 + (5*Pi^2*Log[2]^2)/24 - 
     (5*Log[2]^4)/24 - 5*PolyLog[4, 1/2] - (35*Log[2]*Zeta[3])/8) + 
   Log[1 - x]*((-13*Pi^4)/630 + (Pi^2*Log[2]^2)/8 - Log[2]^4/8 - 
     3*PolyLog[4, 1/2] - (21*Log[2]*Zeta[3])/8) + 
   Log[x]*(-Pi^4/420 + (Pi^2*Log[2]^2)/12 - Log[2]^4/12 - 2*PolyLog[4, 1/2] - 
     (7*Log[2]*Zeta[3])/4) + Log[2]*((13*Pi^4)/1120 - (11*Pi^2*Log[2]^2)/24 + 
     (11*Log[2]^4)/24 + 11*PolyLog[4, 1/2] + (77*Log[2]*Zeta[3])/8) + 
   (9*Zeta[5])/448, HPL[{2, -2, -1}, x_] :>  HPL[{2, -2, -1}, x], 
 HPL[{2, -2, 1}, x_] :>  (-3*HPL[{-4, 1}, -x])/8 - (27*HPL[{-4, 1}, x])/8 - 
   (11*HPL[{-4, 1}, (1 - x)/(1 + x)])/8 - (17*HPL[{-4, 1}, (-1 + x)/(1 + x)])/
    8 - HPL[{3, -2}, -x]/2 - HPL[{3, -2}, x]/2 - 
   HPL[{3, -2}, (1 - x)/(1 + x)] - HPL[{3, -2}, (-1 + x)/(1 + x)] - 
   HPL[{3, 2}, (1 - x)/2]/4 + (43*HPL[{3, 2}, 1 - x])/56 - 
   (39*HPL[{3, 2}, -x])/56 - (15*HPL[{3, 2}, x])/56 - 
   (41*HPL[{3, 2}, x/(-1 + x)])/56 + (29*HPL[{3, 2}, (2*x)/(-1 + x)])/56 + 
   (45*HPL[{3, 2}, (1 + x)^(-1)])/56 - (6*HPL[{3, 2}, (1 - x)/(1 + x)])/7 - 
   (3*HPL[{3, 2}, (-1 + x)/(1 + x)])/8 - (17*HPL[{3, 2}, x/(1 + x)])/56 + 
   (13*HPL[{3, 2}, (2*x)/(1 + x)])/56 - HPL[{3, 2}, (1 + x)/2]/2 + 
   HPL[{3, 2}, x^2/(-1 + x^2)]/32 - (5*HPL[{-3, -1, 1}, -x])/4 + 
   (3*HPL[{-3, -1, 1}, x])/4 - (3*HPL[{-3, -1, 1}, (1 - x)/(1 + x)])/8 - 
   HPL[{-2, 1, -2}, -x]/4 + (3*HPL[{-2, 1, -2}, x])/4 - 
   (3*HPL[{-2, 1, -2}, (1 - x)/(1 + x)])/8 + (5*HPL[{2, -2, -1}, -x])/4 - 
   (3*HPL[{2, -2, -1}, x])/4 + (3*HPL[{2, -2, -1}, (1 - x)/(1 + x)])/8 + 
   (3*HPL[{-2, -1, -1, 1}, -x])/8 + (3*HPL[{-2, -1, -1, 1}, x])/8 + 
   (7*Pi^2*Log[2]^3)/144 + (7*Log[2]^5)/120 - (3*Log[2]^4*Log[1 - x])/64 - 
   (Log[2]^2*Log[1 - x]^3)/192 - (13*Log[2]*Log[1 - x]^4)/192 + 
   (79*Log[1 - x]^5)/1680 - (Log[2]^4*Log[x])/32 + 
   (19*Log[2]^3*Log[1 - x]*Log[x])/48 - (5*Log[2]^2*Log[1 - x]^2*Log[x])/16 - 
   (7*Log[2]*Log[1 - x]^3*Log[x])/48 - (67*Log[1 - x]^4*Log[x])/896 - 
   (71*Log[2]^4*Log[1 + x])/192 + (7*Log[2]^3*Log[1 - x]*Log[1 + x])/48 + 
   (5*Log[2]^2*Log[1 - x]^2*Log[1 + x])/64 + 
   (9*Log[2]*Log[1 - x]^3*Log[1 + x])/32 - (107*Log[1 - x]^4*Log[1 + x])/
    448 - (19*Log[2]^3*Log[x]*Log[1 + x])/48 - 
   (3*Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/8 + 
   (7*Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/8 + 
   (103*Log[1 - x]^3*Log[x]*Log[1 + x])/96 + (5*Log[2]^3*Log[1 + x]^2)/16 - 
   (15*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/64 - 
   (9*Log[2]*Log[1 - x]^2*Log[1 + x]^2)/16 - (65*Log[1 - x]^3*Log[1 + x]^2)/
    1344 + (7*Log[2]^2*Log[x]*Log[1 + x]^2)/8 - 
   (Log[2]*Log[1 - x]*Log[x]*Log[1 + x]^2)/2 - 
   (37*Log[1 - x]^2*Log[x]*Log[1 + x]^2)/64 + (23*Log[2]^2*Log[1 + x]^3)/
    192 + (41*Log[2]*Log[1 - x]*Log[1 + x]^3)/96 + 
   (121*Log[1 - x]^2*Log[1 + x]^3)/1344 - (23*Log[2]*Log[x]*Log[1 + x]^3)/
    48 + (9*Log[1 - x]*Log[x]*Log[1 + x]^3)/32 - 
   (67*Log[2]*Log[1 + x]^4)/192 + (43*Log[1 - x]*Log[1 + x]^4)/224 - 
   (85*Log[x]*Log[1 + x]^4)/384 + (179*Log[1 + x]^5)/840 + 
   (Log[2]^3*PolyLog[2, (1 - x)/2])/2 - 
   (9*Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/16 + 
   (3*Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/16 - 
   (Log[1 - x]^3*PolyLog[2, (1 - x)/2])/16 + 
   (3*Log[1 - x]^2*Log[x]*PolyLog[2, (1 - x)/2])/16 - 
   (15*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/16 + 
   (3*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/4 - 
   (3*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/8 + 
   (9*Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/16 - 
   (3*Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/8 + 
   (3*Log[x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/16 - 
   (Log[1 + x]^3*PolyLog[2, (1 - x)/2])/16 + 
   (3*Log[2]*PolyLog[2, (1 - x)/2]^2)/8 - 
   (3*Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/8 - (9*Log[2]^3*PolyLog[2, -x])/
    16 + (9*Log[2]^2*Log[1 - x]*PolyLog[2, -x])/16 + 
   (5*Log[1 - x]^2*Log[x]*PolyLog[2, -x])/8 + 
   (9*Log[2]^2*Log[1 + x]*PolyLog[2, -x])/8 - 
   (9*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, -x])/8 - 
   (3*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, -x])/4 - 
   (9*Log[2]*Log[1 + x]^2*PolyLog[2, -x])/16 + 
   (9*Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/16 + 
   (Log[1 + x]^3*PolyLog[2, -x])/16 - 
   (3*Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/8 + 
   (3*Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/8 + 
   (7*Log[2]^3*PolyLog[2, x])/16 - (5*Log[2]^2*Log[1 - x]*PolyLog[2, x])/8 + 
   (5*Log[2]*Log[1 - x]^2*PolyLog[2, x])/16 - (Log[1 - x]^3*PolyLog[2, x])/
    6 + (Log[1 - x]^2*Log[x]*PolyLog[2, x])/2 - 
   (11*Log[2]^2*Log[1 + x]*PolyLog[2, x])/16 + 
   (5*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, x])/8 + 
   (Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, x])/4 + 
   (3*Log[2]*Log[1 + x]^2*PolyLog[2, x])/8 - 
   (5*Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/16 - 
   (3*Log[x]*Log[1 + x]^2*PolyLog[2, x])/8 + (Log[1 + x]^3*PolyLog[2, x])/
    16 + (3*Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/8 - 
   (3*Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/8 + 
   (5*Log[1 - x]*PolyLog[2, -x]*PolyLog[2, x])/4 - 
   (3*Log[1 + x]*PolyLog[2, -x]*PolyLog[2, x])/4 - 
   (5*Log[2]^2*PolyLog[3, (1 - x)/2])/16 + 
   (Log[1 - x]^2*PolyLog[3, (1 - x)/2])/32 - Log[1 - x]*Log[x]*
    PolyLog[3, (1 - x)/2] + (5*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/8 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/2])/16 + 
   (11*Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/2])/8 - 
   (9*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/32 + 
   (3*PolyLog[2, -x]*PolyLog[3, (1 - x)/2])/4 - 
   (7*PolyLog[2, x]*PolyLog[3, (1 - x)/2])/8 - 
   (3*Log[2]*Log[1 - x]*PolyLog[3, 1 - x])/8 + 
   (17*Log[1 - x]^2*PolyLog[3, 1 - x])/56 + 
   (43*Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/56 + 
   (3*Log[2]*Log[1 + x]*PolyLog[3, 1 - x])/8 - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, 1 - x])/8 - 
   (Log[1 + x]^2*PolyLog[3, 1 - x])/4 + (PolyLog[2, -x]*PolyLog[3, 1 - x])/
    2 + (5*PolyLog[2, x]*PolyLog[3, 1 - x])/4 - (3*Log[2]^2*PolyLog[3, -x])/
    16 + (3*Log[2]*Log[1 - x]*PolyLog[3, -x])/4 + 
   (19*Log[1 - x]^2*PolyLog[3, -x])/16 - (3*Log[2]*Log[1 + x]*PolyLog[3, -x])/
    8 - (7*Log[1 - x]*Log[1 + x]*PolyLog[3, -x])/8 + 
   (31*Log[1 + x]^2*PolyLog[3, -x])/112 - 
   (3*PolyLog[2, (1 - x)/2]*PolyLog[3, -x])/8 - 
   PolyLog[2, x]*PolyLog[3, -x] + (3*Log[2]^2*PolyLog[3, x])/16 - 
   (3*Log[2]*Log[1 - x]*PolyLog[3, x])/4 + (17*Log[1 - x]^2*PolyLog[3, x])/
    56 + (3*Log[2]*Log[1 + x]*PolyLog[3, x])/8 + 
   (15*Log[1 - x]*Log[1 + x]*PolyLog[3, x])/8 - Log[1 + x]^2*PolyLog[3, x] + 
   (3*PolyLog[2, (1 - x)/2]*PolyLog[3, x])/8 + PolyLog[2, x]*PolyLog[3, x] + 
   (3*Log[2]^2*PolyLog[3, (2*x)/(-1 + x)])/16 - 
   (3*Log[2]*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)])/4 + 
   (29*Log[1 - x]^2*PolyLog[3, (2*x)/(-1 + x)])/112 + 
   (3*Log[2]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/8 + 
   (13*Log[1 - x]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/56 - 
   (17*Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/56 + 
   (3*PolyLog[2, (1 - x)/2]*PolyLog[3, (2*x)/(-1 + x)])/8 + 
   PolyLog[2, x]*PolyLog[3, (2*x)/(-1 + x)] + 
   (3*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)])/8 - 
   (Log[1 - x]^2*PolyLog[3, (1 + x)^(-1)])/16 - 
   (3*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/8 - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/2 - 
   (45*Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/56 + 
   (19*Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/28 - 
   (3*PolyLog[2, -x]*PolyLog[3, (1 + x)^(-1)])/4 - 
   (PolyLog[2, x]*PolyLog[3, (1 + x)^(-1)])/2 + 
   (9*Log[2]^2*PolyLog[3, (1 - x)/(1 + x)])/16 - 
   (13*Log[2]*Log[1 - x]*PolyLog[3, (1 - x)/(1 + x)])/56 + 
   (Log[1 - x]^2*PolyLog[3, (1 - x)/(1 + x)])/32 - 
   (6*Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/(1 + x)])/7 - 
   (25*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/28 + 
   (33*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/112 + 
   (6*Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/7 + 
   (81*Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)])/224 + 
   (3*PolyLog[2, (1 - x)/2]*PolyLog[3, (1 - x)/(1 + x)])/8 + 
   (3*PolyLog[2, -x]*PolyLog[3, (1 - x)/(1 + x)])/4 - 
   (PolyLog[2, x]*PolyLog[3, (1 - x)/(1 + x)])/4 + 
   Pi^2*((-19*Log[2]^3)/192 - (3*Log[2]^2*Log[1 - x])/32 + 
     (45*Log[2]*Log[1 - x]^2)/448 + (121*Log[1 - x]^3)/1344 + 
     (Log[2]^2*Log[x])/64 - (Log[2]*Log[1 - x]*Log[x])/6 - 
     (31*Log[1 - x]^2*Log[x])/1344 + (43*Log[2]^2*Log[1 + x])/192 + 
     (13*Log[2]*Log[1 - x]*Log[1 + x])/336 - (485*Log[1 - x]^2*Log[1 + x])/
      1344 + (19*Log[2]*Log[x]*Log[1 + x])/96 + 
     (13*Log[1 - x]*Log[x]*Log[1 + x])/42 - (13*Log[2]*Log[1 + x]^2)/672 - 
     (23*Log[1 - x]*Log[1 + x]^2)/112 - (17*Log[x]*Log[1 + x]^2)/84 - 
     (167*Log[1 + x]^3)/1008 - (5*Log[2]*PolyLog[2, (1 - x)/2])/32 - 
     (Log[1 - x]*PolyLog[2, (1 - x)/2])/16 - (Log[x]*PolyLog[2, (1 - x)/2])/
      32 + (7*Log[1 + x]*PolyLog[2, (1 - x)/2])/32 + 
     (7*Log[2]*PolyLog[2, -x])/32 - (13*Log[1 - x]*PolyLog[2, -x])/48 - 
     (5*Log[1 + x]*PolyLog[2, -x])/32 - (5*Log[2]*PolyLog[2, x])/32 - 
     (3*Log[1 - x]*PolyLog[2, x])/32 - (Log[1 + x]*PolyLog[2, x])/24 + 
     (9*PolyLog[3, (1 - x)/2])/32 - (107*PolyLog[3, 1 - x])/672 + 
     PolyLog[3, -x]/16 - PolyLog[3, x]/16 - PolyLog[3, (2*x)/(-1 + x)]/16 - 
     (23*PolyLog[3, (1 + x)^(-1)])/224 + (131*PolyLog[3, (1 - x)/(1 + x)])/
      672 + (35*PolyLog[3, (1 + x)/2])/96) - 
   (13*Log[2]^2*PolyLog[3, (1 + x)/2])/16 + 
   (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/2 + 
   (Log[1 - x]^2*PolyLog[3, (1 + x)/2])/32 - Log[1 - x]*Log[x]*
    PolyLog[3, (1 + x)/2] + (9*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2])/8 - 
   (7*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/16 + 
   (11*Log[x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/8 - 
   (9*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/32 - 
   (3*PolyLog[2, (1 - x)/2]*PolyLog[3, (1 + x)/2])/4 + 
   (3*PolyLog[2, -x]*PolyLog[3, (1 + x)/2])/2 - 
   (5*PolyLog[2, x]*PolyLog[3, (1 + x)/2])/8 - (7*Log[2]*PolyLog[4, 1/2])/4 - 
   (15*Log[2]*PolyLog[4, (1 - x)/2])/8 - (3*Log[x]*PolyLog[4, (1 - x)/2])/8 + 
   (15*Log[1 + x]*PolyLog[4, (1 - x)/2])/8 + (3*Log[2]*PolyLog[4, 1 - x])/2 - 
   (5*Log[1 - x]*PolyLog[4, 1 - x])/2 - (129*Log[x]*PolyLog[4, 1 - x])/56 + 
   (Log[1 + x]*PolyLog[4, 1 - x])/8 - (Log[1 - x]*PolyLog[4, -x])/8 + 
   (75*Log[1 + x]*PolyLog[4, -x])/56 - (53*Log[1 - x]*PolyLog[4, x])/56 - 
   (Log[1 + x]*PolyLog[4, x])/8 + (17*Log[1 - x]*PolyLog[4, x/(-1 + x)])/56 - 
   (5*Log[1 + x]*PolyLog[4, x/(-1 + x)])/4 + 
   (87*Log[1 - x]*PolyLog[4, (2*x)/(-1 + x)])/56 - 
   (87*Log[1 + x]*PolyLog[4, (2*x)/(-1 + x)])/56 + 
   (Log[1 - x]*PolyLog[4, (4*x)/(1 + x)^2])/8 + 
   (3*Log[1 + x]*PolyLog[4, (4*x)/(1 + x)^2])/8 - 
   (3*Log[2]*PolyLog[4, (1 + x)^(-1)])/2 + 
   (27*Log[1 - x]*PolyLog[4, (1 + x)^(-1)])/8 - 
   (135*Log[x]*PolyLog[4, (1 + x)^(-1)])/56 + 
   (303*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/56 + 
   (4*Log[2]*PolyLog[4, (1 - x)/(1 + x)])/7 + 
   (18*Log[x]*PolyLog[4, (1 - x)/(1 + x)])/7 - 
   (4*Log[1 + x]*PolyLog[4, (1 - x)/(1 + x)])/7 - 
   (Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/2 - 
   2*Log[x]*PolyLog[4, (-1 + x)/(1 + x)] + 
   (Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/2 + 
   (15*Log[1 - x]*PolyLog[4, x/(1 + x)])/4 + 
   (33*Log[1 + x]*PolyLog[4, x/(1 + x)])/56 - 
   (95*Log[1 - x]*PolyLog[4, (2*x)/(1 + x)])/56 - 
   (129*Log[1 + x]*PolyLog[4, (2*x)/(1 + x)])/56 - 
   (21*Log[2]*PolyLog[4, (1 + x)/2])/8 + (5*Log[1 - x]*PolyLog[4, (1 + x)/2])/
    2 - (3*Log[x]*PolyLog[4, (1 + x)/2])/8 + 
   (33*Log[1 + x]*PolyLog[4, (1 + x)/2])/8 - (3*Log[2]*PolyLog[4, 1 - x^2])/
    16 + (5*Log[1 - x]*PolyLog[4, 1 - x^2])/8 + 
   (3*Log[1 + x]*PolyLog[4, 1 - x^2])/16 - 
   (17*Log[1 - x]*PolyLog[4, x^2/(-1 + x^2)])/32 + 
   (3*Log[1 + x]*PolyLog[4, x^2/(-1 + x^2)])/32 - (7*PolyLog[5, 1/2])/4 + 
   (9*PolyLog[5, (1 - x)/2])/8 + (23*PolyLog[5, 1 - x])/8 - 
   (31*PolyLog[5, -x])/8 + PolyLog[5, x]/8 - (5*PolyLog[5, (-4*x)/(1 - x)^2])/
    32 - (27*PolyLog[5, x/(-1 + x)])/8 + 4*PolyLog[5, (2*x)/(-1 + x)] + 
   (3*PolyLog[5, (4*x)/(1 + x)^2])/32 + (17*PolyLog[5, (1 + x)^(-1)])/2 - 
   (49*PolyLog[5, (1 - x)/(1 + x)])/16 - (7*PolyLog[5, (-1 + x)/(1 + x)])/
    16 - (3*PolyLog[5, x/(1 + x)])/8 - (37*PolyLog[5, (1 + x)/2])/8 - 
   (5*PolyLog[5, 1 - x^2])/16 - (17*Pi^2*Zeta[3])/42 - 
   (49*Log[2]^2*Zeta[3])/64 + ((-59*Log[2]^2)/32 + (1521*Log[2]*Log[1 - x])/
      448 + (383*Log[1 - x]^2)/896 - (21*Log[2]*Log[x])/32 + 
     (25*Log[1 - x]*Log[x])/56 + (817*Log[2]*Log[1 + x])/448 + 
     (311*Log[1 - x]*Log[1 + x])/448 - (29*Log[x]*Log[1 + x])/56 - 
     (1019*Log[1 + x]^2)/896 + (3*PolyLog[2, (1 - x)/2])/32 - 
     (161*PolyLog[2, -x])/64 + (55*PolyLog[2, x])/64)*Zeta[3] + 
   Log[1 - x]*(Pi^4/480 + (19*Pi^2*Log[2]^2)/64 - (19*Log[2]^4)/64 - 
     (57*PolyLog[4, 1/2])/8 - (399*Log[2]*Zeta[3])/64) + 
   Log[x]*((281*Pi^4)/40320 - (Pi^2*Log[2]^2)/32 + Log[2]^4/32 + 
     (3*PolyLog[4, 1/2])/4 + (21*Log[2]*Zeta[3])/32) + 
   Log[1 + x]*((-407*Pi^4)/8064 - (17*Pi^2*Log[2]^2)/192 + 
     (17*Log[2]^4)/192 + (17*PolyLog[4, 1/2])/8 + (119*Log[2]*Zeta[3])/64) + 
   Log[2]*((199*Pi^4)/5040 - (5*Pi^2*Log[2]^2)/48 + (5*Log[2]^4)/48 + 
     (5*PolyLog[4, 1/2])/2 + (35*Log[2]*Zeta[3])/16) - (7513*Zeta[5])/1792, 
 HPL[{2, -3}, x_] :>  -3*HPL[{-4, 1}, -x] - 3*HPL[{-4, 1}, x] - 
   HPL[{3, -2}, -x] - 2*HPL[{3, -2}, x] - PolyLog[2, x]*PolyLog[3, -x], 
 HPL[{2, 3}, x_] :>  (-6*HPL[{3, 2}, 1 - x])/7 - (15*HPL[{3, 2}, x])/7 - 
   (6*HPL[{3, 2}, x/(-1 + x)])/7 - (Pi^4*Log[1 - x])/60 - 
   (9*Log[1 - x]^5)/140 - (Pi^4*Log[x])/35 + (3*Log[1 - x]^4*Log[x])/14 + 
   Pi^2*(-Log[1 - x]^3/14 - (Log[1 - x]^2*Log[x])/14 + PolyLog[3, 1 - x]/7) + 
   (3*Log[1 - x]^2*PolyLog[3, 1 - x])/7 - 
   (6*Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/7 + (3*Log[1 - x]^2*PolyLog[3, x])/
    7 + PolyLog[2, x]*PolyLog[3, x] + (18*Log[x]*PolyLog[4, 1 - x])/7 + 
   (24*Log[1 - x]*PolyLog[4, x])/7 - (18*Log[1 - x]*PolyLog[4, x/(-1 + x)])/
    7 - 6*PolyLog[5, x] - 6*PolyLog[5, x/(-1 + x)] + (2*Pi^2*Zeta[3])/7 + 
   ((-9*Log[1 - x]^2)/7 - (12*Log[1 - x]*Log[x])/7)*Zeta[3] - (33*Zeta[5])/7, 
 HPL[{2, 2, -1}, x_] :>  (5*HPL[{-4, 1}, -x])/32 + (101*HPL[{-4, 1}, x])/32 + 
   (37*HPL[{-4, 1}, (1 - x)/(1 + x)])/32 + 
   (47*HPL[{-4, 1}, (-1 + x)/(1 + x)])/32 + (3*HPL[{3, -2}, -x])/8 + 
   (3*HPL[{3, -2}, x])/8 + HPL[{3, -2}, (1 - x)/(1 + x)]/2 + 
   HPL[{3, -2}, (-1 + x)/(1 + x)]/2 + (3*HPL[{3, 2}, (1 - x)/2])/16 - 
   (53*HPL[{3, 2}, 1 - x])/224 + (65*HPL[{3, 2}, -x])/224 - 
   (31*HPL[{3, 2}, x])/224 + (87*HPL[{3, 2}, x/(-1 + x)])/224 - 
   (67*HPL[{3, 2}, (2*x)/(-1 + x)])/224 - (75*HPL[{3, 2}, (1 + x)^(-1)])/
    224 + (5*HPL[{3, 2}, (1 - x)/(1 + x)])/14 + 
   (5*HPL[{3, 2}, (-1 + x)/(1 + x)])/32 - (9*HPL[{3, 2}, x/(1 + x)])/224 - 
   (3*HPL[{3, 2}, (2*x)/(1 + x)])/224 + HPL[{3, 2}, (1 + x)/2]/8 + 
   HPL[{3, 2}, x^2/(-1 + x^2)]/128 + (27*HPL[{-3, -1, 1}, -x])/16 - 
   (5*HPL[{-3, -1, 1}, x])/16 + (5*HPL[{-3, -1, 1}, (1 - x)/(1 + x)])/32 + 
   (11*HPL[{-2, 1, -2}, -x])/16 - (5*HPL[{-2, 1, -2}, x])/16 + 
   (5*HPL[{-2, 1, -2}, (1 - x)/(1 + x)])/32 - (11*HPL[{2, -2, -1}, -x])/16 + 
   (5*HPL[{2, -2, -1}, x])/16 - (5*HPL[{2, -2, -1}, (1 - x)/(1 + x)])/32 - 
   (5*HPL[{-2, -1, -1, 1}, -x])/32 - (5*HPL[{-2, -1, -1, 1}, x])/32 - 
   (49*Pi^2*Log[2]^3)/576 + (7*Log[2]^5)/96 - (137*Log[2]^4*Log[1 - x])/768 + 
   (3*Log[2]^3*Log[1 - x]^2)/16 - (59*Log[2]^2*Log[1 - x]^3)/256 + 
   (115*Log[2]*Log[1 - x]^4)/768 - (73*Log[1 - x]^5)/1344 + 
   (5*Log[2]^4*Log[x])/384 - (37*Log[2]^3*Log[1 - x]*Log[x])/192 + 
   (11*Log[2]^2*Log[1 - x]^2*Log[x])/64 - (7*Log[2]*Log[1 - x]^3*Log[x])/
    192 + (317*Log[1 - x]^4*Log[x])/3584 + (121*Log[2]^4*Log[1 + x])/768 + 
   (21*Log[2]^3*Log[1 - x]*Log[1 + x])/64 + 
   (37*Log[2]^2*Log[1 - x]^2*Log[1 + x])/256 - 
   (53*Log[2]*Log[1 - x]^3*Log[1 + x])/384 + (479*Log[1 - x]^4*Log[1 + x])/
    5376 + (37*Log[2]^3*Log[x]*Log[1 + x])/192 + 
   (5*Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/32 - 
   (5*Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/32 - 
   (185*Log[1 - x]^3*Log[x]*Log[1 + x])/384 - (29*Log[2]^3*Log[1 + x]^2)/
    192 - (159*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/256 + 
   (3*Log[2]*Log[1 - x]^2*Log[1 + x]^2)/64 + (463*Log[1 - x]^3*Log[1 + x]^2)/
    5376 - (13*Log[2]^2*Log[x]*Log[1 + x]^2)/32 - 
   (21*Log[1 - x]^2*Log[x]*Log[1 + x]^2)/256 + (23*Log[2]^2*Log[1 + x]^3)/
    768 + (51*Log[2]*Log[1 - x]*Log[1 + x]^3)/128 + 
   (377*Log[1 - x]^2*Log[1 + x]^3)/5376 + (19*Log[2]*Log[x]*Log[1 + x]^3)/
    64 + (59*Log[1 - x]*Log[x]*Log[1 + x]^3)/384 + 
   (15*Log[2]*Log[1 + x]^4)/256 - (305*Log[1 - x]*Log[1 + x]^4)/896 + 
   (155*Log[x]*Log[1 + x]^4)/1536 - (27*Log[1 + x]^5)/280 - 
   (5*Log[2]^3*PolyLog[2, (1 - x)/2])/24 + 
   (15*Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/64 - 
   (5*Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/64 + 
   (5*Log[1 - x]^3*PolyLog[2, (1 - x)/2])/192 - 
   (5*Log[1 - x]^2*Log[x]*PolyLog[2, (1 - x)/2])/64 + 
   (25*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/64 - 
   (5*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/16 + 
   (5*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/32 - 
   (15*Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/64 + 
   (5*Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/32 - 
   (5*Log[x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/64 + 
   (5*Log[1 + x]^3*PolyLog[2, (1 - x)/2])/192 - 
   (5*Log[2]*PolyLog[2, (1 - x)/2]^2)/32 + 
   (5*Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/32 + (15*Log[2]^3*PolyLog[2, -x])/
    64 - (15*Log[2]^2*Log[1 - x]*PolyLog[2, -x])/64 - 
   (11*Log[1 - x]^2*Log[x]*PolyLog[2, -x])/32 - 
   (15*Log[2]^2*Log[1 + x]*PolyLog[2, -x])/32 + 
   (15*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, -x])/32 + 
   (5*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, -x])/16 + 
   (15*Log[2]*Log[1 + x]^2*PolyLog[2, -x])/64 - 
   (15*Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/64 - 
   (5*Log[1 + x]^3*PolyLog[2, -x])/192 + 
   (5*Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/32 - 
   (5*Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/32 - 
   (9*Log[2]^3*PolyLog[2, x])/64 + (11*Log[2]^2*Log[1 - x]*PolyLog[2, x])/
    32 - (27*Log[2]*Log[1 - x]^2*PolyLog[2, x])/64 + 
   (Log[1 - x]^3*PolyLog[2, x])/6 - (Log[1 - x]^2*Log[x]*PolyLog[2, x])/2 + 
   (5*Log[2]^2*Log[1 + x]*PolyLog[2, x])/64 + 
   (5*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, x])/32 + 
   (5*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, x])/16 - 
   (5*Log[2]*Log[1 + x]^2*PolyLog[2, x])/32 - 
   (5*Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/64 + 
   (5*Log[x]*Log[1 + x]^2*PolyLog[2, x])/32 - (5*Log[1 + x]^3*PolyLog[2, x])/
    192 - (5*Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/32 + 
   (5*Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/32 - 
   (11*Log[1 - x]*PolyLog[2, -x]*PolyLog[2, x])/16 + 
   (5*Log[1 + x]*PolyLog[2, -x]*PolyLog[2, x])/16 + 
   (Log[1 + x]*PolyLog[2, x]^2)/2 + (11*Log[2]^2*PolyLog[3, (1 - x)/2])/64 + 
   (Log[1 - x]^2*PolyLog[3, (1 - x)/2])/128 + 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/2])/2 - 
   (11*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/32 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/2])/64 - 
   (21*Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/2])/32 + 
   (23*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/128 - 
   (5*PolyLog[2, -x]*PolyLog[3, (1 - x)/2])/16 + 
   (17*PolyLog[2, x]*PolyLog[3, (1 - x)/2])/32 + 
   (5*Log[2]*Log[1 - x]*PolyLog[3, 1 - x])/32 - 
   (47*Log[1 - x]^2*PolyLog[3, 1 - x])/224 - 
   (53*Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/224 - 
   (5*Log[2]*Log[1 + x]*PolyLog[3, 1 - x])/32 - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, 1 - x])/32 + 
   (Log[1 + x]^2*PolyLog[3, 1 - x])/16 - (3*PolyLog[2, -x]*PolyLog[3, 1 - x])/
    8 - (11*PolyLog[2, x]*PolyLog[3, 1 - x])/16 + 
   (5*Log[2]^2*PolyLog[3, -x])/64 - (5*Log[2]*Log[1 - x]*PolyLog[3, -x])/16 - 
   (45*Log[1 - x]^2*PolyLog[3, -x])/64 + (5*Log[2]*Log[1 + x]*PolyLog[3, -x])/
    32 + (9*Log[1 - x]*Log[1 + x]*PolyLog[3, -x])/32 - 
   (33*Log[1 + x]^2*PolyLog[3, -x])/448 + 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, -x])/32 + 
   PolyLog[2, x]*PolyLog[3, -x] - (5*Log[2]^2*PolyLog[3, x])/64 + 
   (5*Log[2]*Log[1 - x]*PolyLog[3, x])/16 - (47*Log[1 - x]^2*PolyLog[3, x])/
    224 - (5*Log[2]*Log[1 + x]*PolyLog[3, x])/32 - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, x])/32 + (3*Log[1 + x]^2*PolyLog[3, x])/
    8 - (5*PolyLog[2, (1 - x)/2]*PolyLog[3, x])/32 - 
   PolyLog[2, x]*PolyLog[3, x] - (5*Log[2]^2*PolyLog[3, (2*x)/(-1 + x)])/64 + 
   (5*Log[2]*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)])/16 - 
   (67*Log[1 - x]^2*PolyLog[3, (2*x)/(-1 + x)])/448 - 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/32 - 
   (3*Log[1 - x]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/224 + 
   (19*Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/224 - 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, (2*x)/(-1 + x)])/32 - 
   PolyLog[2, x]*PolyLog[3, (2*x)/(-1 + x)] - 
   (5*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)])/32 - 
   (Log[1 - x]^2*PolyLog[3, (1 + x)^(-1)])/64 + 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/32 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/8 + 
   (75*Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/224 - 
   (27*Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/112 + 
   (5*PolyLog[2, -x]*PolyLog[3, (1 + x)^(-1)])/16 + 
   (5*PolyLog[2, x]*PolyLog[3, (1 + x)^(-1)])/8 - 
   (15*Log[2]^2*PolyLog[3, (1 - x)/(1 + x)])/64 + 
   (3*Log[2]*Log[1 - x]*PolyLog[3, (1 - x)/(1 + x)])/224 + 
   (Log[1 - x]^2*PolyLog[3, (1 - x)/(1 + x)])/128 + 
   (5*Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/(1 + x)])/14 + 
   (51*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/112 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/448 - 
   (5*Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/14 - 
   (191*Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)])/896 - 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, (1 - x)/(1 + x)])/32 - 
   (5*PolyLog[2, -x]*PolyLog[3, (1 - x)/(1 + x)])/16 - 
   (5*PolyLog[2, x]*PolyLog[3, (1 - x)/(1 + x)])/16 + 
   Pi^2*((31*Log[2]^3)/2304 + (83*Log[2]^2*Log[1 - x])/384 - 
     (505*Log[2]*Log[1 - x]^2)/5376 - (997*Log[1 - x]^3)/16128 - 
     (5*Log[2]^2*Log[x])/768 + (Log[2]*Log[1 - x]*Log[x])/12 - 
     (23*Log[1 - x]^2*Log[x])/5376 - (23*Log[2]^2*Log[1 + x])/256 - 
     (113*Log[2]*Log[1 - x]*Log[1 + x])/448 + (201*Log[1 - x]^2*Log[1 + x])/
      1792 - (37*Log[2]*Log[x]*Log[1 + x])/384 - 
     (17*Log[1 - x]*Log[x]*Log[1 + x])/168 + (29*Log[2]*Log[1 + x]^2)/896 + 
     (451*Log[1 - x]*Log[1 + x]^2)/1344 + (13*Log[x]*Log[1 + x]^2)/168 + 
     (409*Log[1 + x]^3)/4032 + (25*Log[2]*PolyLog[2, (1 - x)/2])/384 + 
     (5*Log[1 - x]*PolyLog[2, (1 - x)/2])/192 + 
     (5*Log[x]*PolyLog[2, (1 - x)/2])/384 - 
     (35*Log[1 + x]*PolyLog[2, (1 - x)/2])/384 - (35*Log[2]*PolyLog[2, -x])/
      384 + (9*Log[1 - x]*PolyLog[2, -x])/64 + (25*Log[1 + x]*PolyLog[2, -x])/
      384 + (17*Log[2]*PolyLog[2, x])/384 + (47*Log[1 - x]*PolyLog[2, x])/
      384 + (5*Log[1 + x]*PolyLog[2, x])/96 - (53*PolyLog[3, (1 - x)/2])/
      384 + (47*PolyLog[3, 1 - x])/896 - (5*PolyLog[3, -x])/192 + 
     (5*PolyLog[3, x])/192 + (5*PolyLog[3, (2*x)/(-1 + x)])/192 + 
     (115*PolyLog[3, (1 + x)^(-1)])/2688 - (79*PolyLog[3, (1 - x)/(1 + x)])/
      896 - (61*PolyLog[3, (1 + x)/2])/384) + 
   (19*Log[2]^2*PolyLog[3, (1 + x)/2])/64 - 
   (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/8 + 
   (Log[1 - x]^2*PolyLog[3, (1 + x)/2])/128 + 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 + x)/2])/2 - 
   (15*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2])/32 + 
   (9*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/64 - 
   (21*Log[x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/32 + 
   (23*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/128 + 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, (1 + x)/2])/16 - 
   (5*PolyLog[2, -x]*PolyLog[3, (1 + x)/2])/8 - 
   (5*PolyLog[2, x]*PolyLog[3, (1 + x)/2])/32 + (49*Log[2]*PolyLog[4, 1/2])/
    16 + (33*Log[2]*PolyLog[4, (1 - x)/2])/32 + 
   (5*Log[x]*PolyLog[4, (1 - x)/2])/32 - 
   (33*Log[1 + x]*PolyLog[4, (1 - x)/2])/32 - (5*Log[2]*PolyLog[4, 1 - x])/
    8 + (11*Log[1 - x]*PolyLog[4, 1 - x])/8 + (159*Log[x]*PolyLog[4, 1 - x])/
    224 + (25*Log[1 + x]*PolyLog[4, 1 - x])/32 - 
   (9*Log[1 - x]*PolyLog[4, -x])/32 - (125*Log[1 + x]*PolyLog[4, -x])/224 - 
   (61*Log[1 - x]*PolyLog[4, x])/224 - (9*Log[1 + x]*PolyLog[4, x])/32 - 
   (47*Log[1 - x]*PolyLog[4, x/(-1 + x)])/224 - 
   (5*Log[1 + x]*PolyLog[4, x/(-1 + x)])/16 - 
   (201*Log[1 - x]*PolyLog[4, (2*x)/(-1 + x)])/224 + 
   (201*Log[1 + x]*PolyLog[4, (2*x)/(-1 + x)])/224 - 
   (11*Log[1 - x]*PolyLog[4, (4*x)/(1 + x)^2])/32 - 
   (5*Log[1 + x]*PolyLog[4, (4*x)/(1 + x)^2])/32 + 
   (5*Log[2]*PolyLog[4, (1 + x)^(-1)])/8 - 
   (93*Log[1 - x]*PolyLog[4, (1 + x)^(-1)])/32 + 
   (225*Log[x]*PolyLog[4, (1 + x)^(-1)])/224 - 
   (505*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/224 - 
   (4*Log[2]*PolyLog[4, (1 - x)/(1 + x)])/7 - 
   (15*Log[x]*PolyLog[4, (1 - x)/(1 + x)])/14 + 
   (4*Log[1 + x]*PolyLog[4, (1 - x)/(1 + x)])/7 - 
   (Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/8 + 
   (Log[x]*PolyLog[4, (-1 + x)/(1 + x)])/2 + 
   (Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/8 - 
   (49*Log[1 - x]*PolyLog[4, x/(1 + x)])/16 - 
   (167*Log[1 + x]*PolyLog[4, x/(1 + x)])/224 + 
   (625*Log[1 - x]*PolyLog[4, (2*x)/(1 + x)])/224 + 
   (271*Log[1 + x]*PolyLog[4, (2*x)/(1 + x)])/224 + 
   (27*Log[2]*PolyLog[4, (1 + x)/2])/32 - 
   (25*Log[1 - x]*PolyLog[4, (1 + x)/2])/8 + (5*Log[x]*PolyLog[4, (1 + x)/2])/
    32 - (55*Log[1 + x]*PolyLog[4, (1 + x)/2])/32 + 
   (5*Log[2]*PolyLog[4, 1 - x^2])/64 - (11*Log[1 - x]*PolyLog[4, 1 - x^2])/
    32 - (5*Log[1 + x]*PolyLog[4, 1 - x^2])/64 + 
   (47*Log[1 - x]*PolyLog[4, x^2/(-1 + x^2)])/128 + 
   (3*Log[1 + x]*PolyLog[4, x^2/(-1 + x^2)])/128 + (49*PolyLog[5, 1/2])/16 - 
   (71*PolyLog[5, (1 - x)/2])/32 - PolyLog[5, 1 - x]/32 + 
   (117*PolyLog[5, -x])/32 - (11*PolyLog[5, x])/32 + 
   (27*PolyLog[5, (-4*x)/(1 - x)^2])/128 + (101*PolyLog[5, x/(-1 + x)])/32 - 
   4*PolyLog[5, (2*x)/(-1 + x)] - (5*PolyLog[5, (4*x)/(1 + x)^2])/128 - 
   (19*PolyLog[5, (1 + x)^(-1)])/8 + (119*PolyLog[5, (1 - x)/(1 + x)])/64 + 
   (49*PolyLog[5, (-1 + x)/(1 + x)])/64 + (5*PolyLog[5, x/(1 + x)])/32 + 
   (43*PolyLog[5, (1 + x)/2])/32 - PolyLog[5, 1 - x^2]/64 + 
   (81*Pi^2*Zeta[3])/448 + (343*Log[2]^2*Zeta[3])/256 + 
   ((229*Log[2]^2)/128 - (8807*Log[2]*Log[1 - x])/1792 - 
     (769*Log[1 - x]^2)/3584 + (35*Log[2]*Log[x])/128 - 
     (93*Log[1 - x]*Log[x])/224 - (2407*Log[2]*Log[1 + x])/1792 + 
     (23*Log[1 - x]*Log[1 + x])/1792 + (137*Log[x]*Log[1 + x])/224 + 
     (149*Log[1 + x]^2)/3584 - (5*PolyLog[2, (1 - x)/2])/128 + 
     (311*PolyLog[2, -x])/256 + (7*PolyLog[2, x])/256)*Zeta[3] + 
   Log[2]*((-41*Pi^4)/2240 + (9*Pi^2*Log[2]^2)/64 - (9*Log[2]^4)/64 - 
     (27*PolyLog[4, 1/2])/8 - (189*Log[2]*Zeta[3])/64) + 
   Log[x]*((-181*Pi^4)/53760 + (5*Pi^2*Log[2]^2)/384 - (5*Log[2]^4)/384 - 
     (5*PolyLog[4, 1/2])/16 - (35*Log[2]*Zeta[3])/128) + 
   Log[1 + x]*((3149*Pi^4)/161280 - (25*Pi^2*Log[2]^2)/768 + 
     (25*Log[2]^4)/768 + (25*PolyLog[4, 1/2])/32 + (175*Log[2]*Zeta[3])/
      256) + Log[1 - x]*((23*Pi^4)/1920 - (191*Pi^2*Log[2]^2)/768 + 
     (191*Log[2]^4)/768 + (191*PolyLog[4, 1/2])/32 + 
     (1337*Log[2]*Zeta[3])/256) - (1553*Zeta[5])/7168, 
 HPL[{2, 2, 1}, x_] :>  -HPL[{3, 2}, 1 - x] + (Pi^4*Log[1 - x])/360 + 
   Log[1 - x]^5/12 - (Pi^4*Log[x])/30 - (Log[1 - x]^4*Log[x])/3 - 
   (Log[1 - x]^2*Log[x]*PolyLog[2, x])/2 - (Log[1 - x]*PolyLog[2, x]^2)/2 + 
   Pi^2*(Log[1 - x]^3/6 - (Log[1 - x]^2*Log[x])/12 + 
     (Log[1 - x]*PolyLog[2, x])/6 + PolyLog[3, 1 - x]/6) - 
   Log[1 - x]*Log[x]*PolyLog[3, 1 - x] - PolyLog[2, x]*PolyLog[3, 1 - x] - 
   Log[1 - x]^2*PolyLog[3, x] - 2*Log[1 - x]*PolyLog[4, 1 - x] + 
   3*Log[x]*PolyLog[4, 1 - x] + 2*Log[1 - x]*PolyLog[4, x] + 
   2*Log[1 - x]*PolyLog[4, x/(-1 + x)] + (Pi^2*Zeta[3])/3 + 
   (Log[1 - x]^2 - 2*Log[1 - x]*Log[x] + PolyLog[2, x])*Zeta[3] - 
   (11*Zeta[5])/2, HPL[{2, 1, -1, -1}, x_] :>  -HPL[{-4, 1}, -x]/2 - 
   HPL[{-4, 1}, x]/2 - HPL[{-4, 1}, (1 - x)/(1 + x)] - 
   (3*HPL[{-4, 1}, (-1 + x)/(1 + x)])/2 - (5*HPL[{3, 2}, (1 - x)/2])/14 - 
   HPL[{3, 2}, 1 - x]/14 + HPL[{3, 2}, -x]/14 + HPL[{3, 2}, x]/14 - 
   HPL[{3, 2}, x/(-1 + x)]/14 + HPL[{3, 2}, (1 + x)^(-1)]/14 + 
   (5*HPL[{3, 2}, (-1 + x)/(1 + x)])/14 - HPL[{3, 2}, x/(1 + x)]/14 - 
   (9*HPL[{3, 2}, (1 + x)/2])/14 + HPL[{2, -2, -1}, (1 - x)/(1 + x)] + 
   HPL[{-2, -1, -1, 1}, x] + HPL[{-2, -1, 1, -1}, x] + 
   HPL[{2, 1, -1}, -x]*Log[2] + HPL[{2, 1, -1}, x]*Log[2] - 
   (Pi^2*Log[2]^3)/18 + (3*Log[2]^5)/20 + (5*Log[2]^4*Log[1 - x])/336 + 
   (Log[2]^2*Log[1 - x]^3)/12 - (5*Log[2]*Log[1 - x]^4)/32 + 
   (11*Log[1 - x]^5)/560 + (7*Pi^4*Log[x])/720 + 
   (Log[2]^2*Log[1 - x]^2*Log[x])/2 + (Log[2]*Log[1 - x]^3*Log[x])/4 - 
   (Log[1 - x]^4*Log[x])/42 - (145*Log[2]^4*Log[1 + x])/336 - 
   (5*Log[2]^3*Log[1 - x]*Log[1 + x])/84 - (Log[2]^2*Log[1 - x]^2*Log[1 + x])/
    4 + (5*Log[2]*Log[1 - x]^3*Log[1 + x])/24 + (Log[1 - x]^4*Log[1 + x])/
    32 - Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x] - 
   (3*Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/4 - 
   (Log[1 - x]^3*Log[x]*Log[1 + x])/12 + (25*Log[2]^3*Log[1 + x]^2)/28 + 
   (19*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/56 + 
   (Log[2]*Log[1 - x]^2*Log[1 + x]^2)/16 - (Log[1 - x]^3*Log[1 + x]^2)/24 + 
   (Log[2]^2*Log[x]*Log[1 + x]^2)/2 + 
   (7*Log[2]*Log[1 - x]*Log[x]*Log[1 + x]^2)/4 + 
   (Log[1 - x]^2*Log[x]*Log[1 + x]^2)/4 - (169*Log[2]^2*Log[1 + x]^3)/168 - 
   (59*Log[2]*Log[1 - x]*Log[1 + x]^3)/168 - (Log[1 - x]^2*Log[1 + x]^3)/16 - 
   (7*Log[2]*Log[x]*Log[1 + x]^3)/12 - (7*Log[1 - x]*Log[x]*Log[1 + x]^3)/
    12 + (81*Log[2]*Log[1 + x]^4)/224 + (47*Log[1 - x]*Log[1 + x]^4)/336 + 
   (5*Log[x]*Log[1 + x]^4)/48 + (211*Log[1 + x]^5)/3360 + 
   (2*Log[2]^3*PolyLog[2, (1 - x)/2])/3 - 
   (Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/2 - 
   (3*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/2 + 
   Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2] + 
   Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2] - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 - 
   (Log[1 + x]^3*PolyLog[2, (1 - x)/2])/6 + (Log[2]*PolyLog[2, (1 - x)/2]^2)/
    2 - (Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/2 - 
   (Log[2]^2*Log[1 - x]*PolyLog[2, -x])/2 + 
   (Log[2]^2*Log[1 + x]*PolyLog[2, -x])/2 + Log[2]*Log[1 - x]*Log[1 + x]*
    PolyLog[2, -x] - (Log[2]*Log[1 + x]^2*PolyLog[2, -x])/2 - 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/2 + (Log[1 + x]^3*PolyLog[2, -x])/
    6 + (Log[2]^2*Log[1 - x]*PolyLog[2, x])/2 - 
   (Log[2]^2*Log[1 + x]*PolyLog[2, x])/2 + 
   (Log[2]*Log[1 + x]^2*PolyLog[2, x])/2 - (Log[1 + x]^3*PolyLog[2, x])/6 - 
   (5*Log[2]^2*PolyLog[3, (1 - x)/2])/28 + 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/14 - 
   (5*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/28 + 
   (Log[1 - x]^2*PolyLog[3, 1 - x])/28 - 
   (Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/14 + 
   Log[2]*Log[1 + x]*PolyLog[3, 1 - x] - (Log[1 + x]^2*PolyLog[3, 1 - x])/2 + 
   (Log[1 + x]^2*PolyLog[3, -x])/28 + (Log[1 - x]^2*PolyLog[3, x])/28 + 
   Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)] - Log[1 - x]*Log[1 + x]*
    PolyLog[3, (1 + x)^(-1)] - (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/
    14 + (Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/14 + 
   Log[2]^2*PolyLog[3, (1 - x)/(1 + x)] - 2*Log[2]*Log[1 + x]*
    PolyLog[3, (1 - x)/(1 + x)] + Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)] + 
   Pi^2*((11*Log[2]^3)/168 - (29*Log[2]^2*Log[1 - x])/84 - 
     (Log[2]*Log[1 - x]^2)/16 - Log[1 - x]^3/168 + (Log[1 - x]^2*Log[x])/28 + 
     (25*Log[2]^2*Log[1 + x])/168 + (27*Log[2]*Log[1 - x]*Log[1 + x])/56 + 
     (Log[1 - x]^2*Log[1 + x])/16 - (Log[1 - x]*Log[x]*Log[1 + x])/12 - 
     (19*Log[2]*Log[1 + x]^2)/336 - (5*Log[1 - x]*Log[1 + x]^2)/28 + 
     (Log[x]*Log[1 + x]^2)/21 - (109*Log[1 + x]^3)/1008 - 
     (Log[2]*PolyLog[2, (1 - x)/2])/6 + (Log[1 + x]*PolyLog[2, (1 - x)/2])/
      6 + PolyLog[3, 1 - x]/84 - PolyLog[3, (1 + x)^(-1)]/84 + 
     (3*PolyLog[3, (1 + x)/2])/28) - (23*Log[2]^2*PolyLog[3, (1 + x)/2])/28 + 
   (9*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/14 + 
   Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2] - 
   (9*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/14 - 
   (5*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/28 - PolyLog[2, (1 - x)/2]*
    PolyLog[3, (1 + x)/2] + 2*Log[2]*PolyLog[4, 1/2] - 
   (29*Log[2]*PolyLog[4, (1 - x)/2])/14 + 
   (29*Log[1 + x]*PolyLog[4, (1 - x)/2])/14 + 3*Log[2]*PolyLog[4, 1 - x] + 
   (3*Log[x]*PolyLog[4, 1 - x])/14 - 3*Log[1 + x]*PolyLog[4, 1 - x] + 
   (Log[1 - x]*PolyLog[4, -x])/2 - (3*Log[1 + x]*PolyLog[4, -x])/14 - 
   (3*Log[1 - x]*PolyLog[4, x])/14 + (Log[1 + x]*PolyLog[4, x])/2 - 
   2*Log[2]*PolyLog[4, x/(-1 + x)] - (3*Log[1 - x]*PolyLog[4, x/(-1 + x)])/
    14 + 2*Log[1 + x]*PolyLog[4, x/(-1 + x)] + 
   Log[2]*PolyLog[4, (2*x)/(-1 + x)] - 
   Log[1 + x]*PolyLog[4, (2*x)/(-1 + x)] - 
   3*Log[2]*PolyLog[4, (1 + x)^(-1)] - Log[1 - x]*PolyLog[4, (1 + x)^(-1)] - 
   (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/14 + 
   (45*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/14 - 
   (4*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/7 + 
   Log[x]*PolyLog[4, (-1 + x)/(1 + x)] + 
   (4*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/7 - 
   2*Log[2]*PolyLog[4, x/(1 + x)] + (25*Log[1 + x]*PolyLog[4, x/(1 + x)])/
    14 + Log[2]*PolyLog[4, (2*x)/(1 + x)] - 
   Log[1 + x]*PolyLog[4, (2*x)/(1 + x)] - (41*Log[2]*PolyLog[4, (1 + x)/2])/
    14 + (27*Log[1 - x]*PolyLog[4, (1 + x)/2])/14 + 
   Log[1 + x]*PolyLog[4, (1 + x)/2] - (Log[2]*PolyLog[4, 1 - x^2])/2 + 
   (Log[1 + x]*PolyLog[4, 1 - x^2])/2 + (Log[2]*PolyLog[4, x^2/(-1 + x^2)])/
    4 - (Log[1 + x]*PolyLog[4, x^2/(-1 + x^2)])/4 + 2*PolyLog[5, 1/2] + 
   PolyLog[5, (1 - x)/2]/2 + PolyLog[5, 1 - x] - PolyLog[5, -x]/2 - 
   PolyLog[5, x]/2 - PolyLog[5, (-4*x)/(1 - x)^2]/8 - 
   PolyLog[5, x/(-1 + x)]/2 + PolyLog[5, (2*x)/(-1 + x)] - 
   PolyLog[5, (4*x)/(1 + x)^2]/8 + PolyLog[5, (1 + x)^(-1)]/2 - 
   (7*PolyLog[5, (1 - x)/(1 + x)])/4 - (3*PolyLog[5, (-1 + x)/(1 + x)])/4 - 
   PolyLog[5, x/(1 + x)]/2 + PolyLog[5, (2*x)/(1 + x)] - 
   (3*PolyLog[5, (1 + x)/2])/2 - PolyLog[5, 1 - x^2]/8 + 
   (23*Pi^2*Zeta[3])/336 + (7*Log[2]^2*Zeta[3])/8 + 
   ((-33*Log[2]^2)/8 + (23*Log[2]*Log[1 - x])/56 - (3*Log[1 - x]^2)/28 + 
     (41*Log[1 - x]*Log[x])/56 + (47*Log[2]*Log[1 + x])/56 - 
     (9*Log[1 - x]*Log[1 + x])/7 - (57*Log[x]*Log[1 + x])/56 + 
     (19*Log[1 + x]^2)/8 + PolyLog[2, (1 - x)/2] - PolyLog[2, -x]/8 + 
     PolyLog[2, x]/8)*Zeta[3] + Log[1 + x]*((31*Pi^4)/1680 + 
     (5*Pi^2*Log[2]^2)/24 - (5*Log[2]^4)/24 - 5*PolyLog[4, 1/2] - 
     (35*Log[2]*Zeta[3])/8) + Log[1 - x]*((-17*Pi^4)/630 - 
     (Pi^2*Log[2]^2)/24 + Log[2]^4/24 + PolyLog[4, 1/2] + 
     (7*Log[2]*Zeta[3])/8) + Log[2]*((223*Pi^4)/10080 - (Pi^2*Log[2]^2)/6 + 
     Log[2]^4/6 + 4*PolyLog[4, 1/2] + (7*Log[2]*Zeta[3])/2) - 
   (1703*Zeta[5])/448, HPL[{2, 1, -1, 1}, x_] :>  
  HPL[{-4, 1}, -x]/2 + HPL[{-4, 1}, x]/2 + 2*HPL[{-4, 1}, (1 - x)/(1 + x)] + 
   (3*HPL[{-4, 1}, (-1 + x)/(1 + x)])/2 + HPL[{3, -2}, (-1 + x)/(1 + x)] + 
   (9*HPL[{3, 2}, (1 - x)/2])/14 + HPL[{3, 2}, 1 - x]/14 - 
   HPL[{3, 2}, -x]/14 - HPL[{3, 2}, x]/14 + HPL[{3, 2}, x/(-1 + x)]/14 - 
   HPL[{3, 2}, (1 + x)^(-1)]/14 + (5*HPL[{3, 2}, (-1 + x)/(1 + x)])/14 + 
   HPL[{3, 2}, x/(1 + x)]/14 + (5*HPL[{3, 2}, (1 + x)/2])/14 - 
   HPL[{-3, -1, 1}, (1 - x)/(1 + x)] - HPL[{2, -2, -1}, (1 - x)/(1 + x)] - 
   HPL[{-2, -1, -1, 1}, -x] - HPL[{-2, -1, -1, 1}, x] - 
   HPL[{-2, -1, 1, -1}, x] - HPL[{2, 1, -1}, -x]*Log[2] - 
   HPL[{2, 1, -1}, x]*Log[2] - (Pi^2*Log[2]^3)/9 + (3*Log[2]^5)/20 + 
   (19*Pi^4*Log[1 - x])/1008 - HPL[{2, 1, -1}, x]*Log[1 - x] - 
   (17*Log[2]^4*Log[1 - x])/112 - (Log[2]^2*Log[1 - x]^3)/12 + 
   (5*Log[2]*Log[1 - x]^4)/32 - (11*Log[1 - x]^5)/560 - 
   (Log[2]^4*Log[x])/12 - (Log[2]^3*Log[1 - x]*Log[x])/6 - 
   (Log[2]^2*Log[1 - x]^2*Log[x])/4 - (5*Log[2]*Log[1 - x]^3*Log[x])/12 + 
   (Log[1 - x]^4*Log[x])/42 + HPL[{2, 1, -1}, x]*Log[1 + x] + 
   (23*Log[2]^4*Log[1 + x])/336 + (17*Log[2]^3*Log[1 - x]*Log[1 + x])/28 + 
   (Log[2]^2*Log[1 - x]^2*Log[1 + x])/4 - (5*Log[2]*Log[1 - x]^3*Log[1 + x])/
    24 - (Log[1 - x]^4*Log[1 + x])/32 + (Log[2]^3*Log[x]*Log[1 + x])/6 + 
   (3*Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/2 + 
   (Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/4 + 
   (Log[1 - x]^3*Log[x]*Log[1 + x])/12 - (37*Log[2]^3*Log[1 + x]^2)/84 - 
   (65*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/56 - 
   (Log[2]*Log[1 - x]^2*Log[1 + x]^2)/16 + (Log[1 - x]^3*Log[1 + x]^2)/24 - 
   (3*Log[2]^2*Log[x]*Log[1 + x]^2)/4 - 
   (7*Log[2]*Log[1 - x]*Log[x]*Log[1 + x]^2)/4 + 
   (Log[1 - x]^2*Log[x]*Log[1 + x]^2)/4 + (139*Log[2]^2*Log[1 + x]^3)/168 + 
   (151*Log[2]*Log[1 - x]*Log[1 + x]^3)/168 + (Log[1 - x]^2*Log[1 + x]^3)/
    16 + (7*Log[2]*Log[x]*Log[1 + x]^3)/12 + 
   (5*Log[1 - x]*Log[x]*Log[1 + x]^3)/12 - (275*Log[2]*Log[1 + x]^4)/672 - 
   (31*Log[1 - x]*Log[1 + x]^4)/112 - (Log[x]*Log[1 + x]^4)/16 - 
   (29*Log[1 + x]^5)/1120 - (2*Log[2]^3*PolyLog[2, (1 - x)/2])/3 + 
   (Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/2 + 
   (3*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/2 - 
   Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2] - 
   Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2] + 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/2 + 
   (Log[1 + x]^3*PolyLog[2, (1 - x)/2])/6 - (Log[2]*PolyLog[2, (1 - x)/2]^2)/
    2 + (Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/2 + 
   (Log[2]^2*Log[1 - x]*PolyLog[2, -x])/2 - 
   (Log[2]^2*Log[1 + x]*PolyLog[2, -x])/2 - Log[2]*Log[1 - x]*Log[1 + x]*
    PolyLog[2, -x] + (Log[2]*Log[1 + x]^2*PolyLog[2, -x])/2 + 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/2 - (Log[1 + x]^3*PolyLog[2, -x])/
    6 - (Log[2]^3*PolyLog[2, x])/3 - (Log[2]*Log[1 - x]^2*PolyLog[2, x])/2 + 
   Log[2]^2*Log[1 + x]*PolyLog[2, x] - Log[2]*Log[1 + x]^2*PolyLog[2, x] + 
   (Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/2 + (Log[1 + x]^3*PolyLog[2, x])/
    6 - (5*Log[2]^2*PolyLog[3, (1 - x)/2])/28 + 
   Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/2] + 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/14 - 
   (5*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/28 + 
   PolyLog[2, x]*PolyLog[3, (1 - x)/2] - (Log[1 - x]^2*PolyLog[3, 1 - x])/
    28 + (Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/14 - 
   Log[2]*Log[1 + x]*PolyLog[3, 1 - x] + Log[1 + x]^2*PolyLog[3, 1 - x] - 
   (Log[1 + x]^2*PolyLog[3, -x])/28 - (Log[1 - x]^2*PolyLog[3, x])/28 - 
   Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)] + Log[1 - x]*Log[1 + x]*
    PolyLog[3, (1 + x)^(-1)] + (Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/
    14 - (Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/14 - 
   Log[2]^2*PolyLog[3, (1 - x)/(1 + x)] + 2*Log[2]*Log[1 + x]*
    PolyLog[3, (1 - x)/(1 + x)] - Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)] + 
   Pi^2*((-23*Log[2]^3)/504 + (61*Log[2]^2*Log[1 - x])/168 + 
     (7*Log[2]*Log[1 - x]^2)/48 + Log[1 - x]^3/168 + (Log[2]^2*Log[x])/12 + 
     (Log[2]*Log[1 - x]*Log[x])/12 - (Log[1 - x]^2*Log[x])/28 - 
     (19*Log[2]^2*Log[1 + x])/84 - (73*Log[2]*Log[1 - x]*Log[1 + x])/168 - 
     (Log[1 - x]^2*Log[1 + x])/16 - (Log[2]*Log[x]*Log[1 + x])/12 - 
     (Log[1 - x]*Log[x]*Log[1 + x])/12 - (5*Log[2]*Log[1 + x]^2)/336 + 
     (Log[1 - x]*Log[1 + x]^2)/14 + (Log[x]*Log[1 + x]^2)/28 + 
     (169*Log[1 + x]^3)/1008 + (Log[2]*PolyLog[2, (1 - x)/2])/6 - 
     (Log[1 + x]*PolyLog[2, (1 - x)/2])/6 + (Log[2]*PolyLog[2, x])/6 - 
     (Log[1 - x]*PolyLog[2, x])/12 - (Log[1 + x]*PolyLog[2, x])/12 - 
     PolyLog[3, (1 - x)/2]/6 - PolyLog[3, 1 - x]/84 + 
     PolyLog[3, (1 + x)^(-1)]/84 - (19*PolyLog[3, (1 + x)/2])/84) + 
   (5*Log[2]^2*PolyLog[3, (1 + x)/2])/28 - 
   (5*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/14 + 
   Log[1 - x]*Log[x]*PolyLog[3, (1 + x)/2] + 
   (5*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/14 - 
   (5*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/28 + PolyLog[2, (1 - x)/2]*
    PolyLog[3, (1 + x)/2] + PolyLog[2, x]*PolyLog[3, (1 + x)/2] + 
   4*Log[2]*PolyLog[4, 1/2] + (27*Log[2]*PolyLog[4, (1 - x)/2])/14 - 
   Log[x]*PolyLog[4, (1 - x)/2] - (27*Log[1 + x]*PolyLog[4, (1 - x)/2])/14 - 
   3*Log[2]*PolyLog[4, 1 - x] - (3*Log[x]*PolyLog[4, 1 - x])/14 + 
   2*Log[1 + x]*PolyLog[4, 1 - x] - (Log[1 - x]*PolyLog[4, -x])/2 + 
   (3*Log[1 + x]*PolyLog[4, -x])/14 + (3*Log[1 - x]*PolyLog[4, x])/14 - 
   (Log[1 + x]*PolyLog[4, x])/2 + 2*Log[2]*PolyLog[4, x/(-1 + x)] + 
   (3*Log[1 - x]*PolyLog[4, x/(-1 + x)])/14 - 
   2*Log[1 + x]*PolyLog[4, x/(-1 + x)] - Log[2]*PolyLog[4, (2*x)/(-1 + x)] + 
   Log[1 + x]*PolyLog[4, (2*x)/(-1 + x)] + 
   3*Log[2]*PolyLog[4, (1 + x)^(-1)] + Log[1 - x]*PolyLog[4, (1 + x)^(-1)] + 
   (3*Log[x]*PolyLog[4, (1 + x)^(-1)])/14 - 
   (45*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/14 - 
   (4*Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/7 + 
   (4*Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/7 + 
   2*Log[2]*PolyLog[4, x/(1 + x)] - (25*Log[1 + x]*PolyLog[4, x/(1 + x)])/
    14 - Log[2]*PolyLog[4, (2*x)/(1 + x)] + 
   Log[1 + x]*PolyLog[4, (2*x)/(1 + x)] + (15*Log[2]*PolyLog[4, (1 + x)/2])/
    14 - (15*Log[1 - x]*PolyLog[4, (1 + x)/2])/14 - 
   Log[x]*PolyLog[4, (1 + x)/2] + (Log[2]*PolyLog[4, 1 - x^2])/2 - 
   (Log[1 + x]*PolyLog[4, 1 - x^2])/2 - (Log[2]*PolyLog[4, x^2/(-1 + x^2)])/
    4 + (Log[1 + x]*PolyLog[4, x^2/(-1 + x^2)])/4 + 4*PolyLog[5, 1/2] + 
   PolyLog[5, (1 - x)/2]/2 + PolyLog[5, -x]/2 + PolyLog[5, x]/2 + 
   PolyLog[5, (-4*x)/(1 - x)^2]/8 + PolyLog[5, x/(-1 + x)]/2 - 
   PolyLog[5, (2*x)/(-1 + x)] + PolyLog[5, (4*x)/(1 + x)^2]/8 - 
   PolyLog[5, (1 + x)^(-1)]/2 + (3*PolyLog[5, (1 - x)/(1 + x)])/4 + 
   (11*PolyLog[5, (-1 + x)/(1 + x)])/4 + PolyLog[5, x/(1 + x)]/2 - 
   PolyLog[5, (2*x)/(1 + x)] - (3*PolyLog[5, (1 + x)/2])/2 + 
   PolyLog[5, 1 - x^2]/8 + (11*Pi^2*Zeta[3])/84 + (7*Log[2]^2*Zeta[3])/4 + 
   (5*Log[2]^2 + (9*Log[2]*Log[1 - x])/56 + (3*Log[1 - x]^2)/28 - 
     (7*Log[2]*Log[x])/4 - (6*Log[1 - x]*Log[x])/7 - 
     (79*Log[2]*Log[1 + x])/56 + (5*Log[1 - x]*Log[1 + x])/7 + 
     (8*Log[x]*Log[1 + x])/7 - (101*Log[1 + x]^2)/56 - 
     PolyLog[2, (1 - x)/2] + PolyLog[2, -x]/8 - (15*PolyLog[2, x])/8)*
    Zeta[3] + Log[2]*((-11*Pi^4)/1120 + (Pi^2*Log[2]^2)/3 - Log[2]^4/3 - 
     8*PolyLog[4, 1/2] - 7*Log[2]*Zeta[3]) + 
   Log[x]*(-(Pi^2*Log[2]^2)/12 + Log[2]^4/12 + 2*PolyLog[4, 1/2] + 
     (7*Log[2]*Zeta[3])/4) + Log[1 + x]*((31*Pi^4)/1260 - (Pi^2*Log[2]^2)/6 + 
     Log[2]^4/6 + 4*PolyLog[4, 1/2] + (7*Log[2]*Zeta[3])/2) + 
   (593*Zeta[5])/448, HPL[{2, 1, -2}, x_] :>  (5*HPL[{-4, 1}, -x])/32 + 
   (5*HPL[{-4, 1}, x])/32 + (37*HPL[{-4, 1}, (1 - x)/(1 + x)])/32 + 
   (47*HPL[{-4, 1}, (-1 + x)/(1 + x)])/32 + (3*HPL[{3, -2}, -x])/8 + 
   (3*HPL[{3, -2}, x])/8 + HPL[{3, -2}, (1 - x)/(1 + x)]/2 + 
   HPL[{3, -2}, (-1 + x)/(1 + x)]/2 + (3*HPL[{3, 2}, (1 - x)/2])/16 - 
   (85*HPL[{3, 2}, 1 - x])/224 + (65*HPL[{3, 2}, -x])/224 + 
   HPL[{3, 2}, x]/224 + (55*HPL[{3, 2}, x/(-1 + x)])/224 - 
   (67*HPL[{3, 2}, (2*x)/(-1 + x)])/224 - (75*HPL[{3, 2}, (1 + x)^(-1)])/
    224 + (5*HPL[{3, 2}, (1 - x)/(1 + x)])/14 + 
   (5*HPL[{3, 2}, (-1 + x)/(1 + x)])/32 - (9*HPL[{3, 2}, x/(1 + x)])/224 - 
   (3*HPL[{3, 2}, (2*x)/(1 + x)])/224 + HPL[{3, 2}, (1 + x)/2]/8 + 
   HPL[{3, 2}, x^2/(-1 + x^2)]/128 - (5*HPL[{-3, -1, 1}, -x])/16 - 
   (5*HPL[{-3, -1, 1}, x])/16 + (5*HPL[{-3, -1, 1}, (1 - x)/(1 + x)])/32 - 
   (5*HPL[{-2, 1, -2}, -x])/16 - (5*HPL[{-2, 1, -2}, x])/16 + 
   (5*HPL[{-2, 1, -2}, (1 - x)/(1 + x)])/32 + (5*HPL[{2, -2, -1}, -x])/16 + 
   (5*HPL[{2, -2, -1}, x])/16 - (5*HPL[{2, -2, -1}, (1 - x)/(1 + x)])/32 - 
   (5*HPL[{-2, -1, -1, 1}, -x])/32 - (5*HPL[{-2, -1, -1, 1}, x])/32 + 
   (5*Pi^2*Log[2]^3)/192 - (3*Log[2]^5)/32 + (119*Log[2]^4*Log[1 - x])/768 - 
   (7*Log[2]^3*Log[1 - x]^2)/48 + (79*Log[2]^2*Log[1 - x]^3)/768 - 
   (13*Log[2]*Log[1 - x]^4)/768 + (319*Log[1 - x]^5)/6720 + 
   (5*Log[2]^4*Log[x])/384 - (37*Log[2]^3*Log[1 - x]*Log[x])/192 + 
   (11*Log[2]^2*Log[1 - x]^2*Log[x])/64 - (7*Log[2]*Log[1 - x]^3*Log[x])/
    192 - (451*Log[1 - x]^4*Log[x])/3584 + (121*Log[2]^4*Log[1 + x])/768 - 
   (65*Log[2]^3*Log[1 - x]*Log[1 + x])/192 + 
   (37*Log[2]^2*Log[1 - x]^2*Log[1 + x])/256 - 
   (53*Log[2]*Log[1 - x]^3*Log[1 + x])/384 + (31*Log[1 - x]^4*Log[1 + x])/
    5376 + (37*Log[2]^3*Log[x]*Log[1 + x])/192 + 
   (5*Log[2]^2*Log[1 - x]*Log[x]*Log[1 + x])/32 - 
   (5*Log[2]*Log[1 - x]^2*Log[x]*Log[1 + x])/32 + 
   (7*Log[1 - x]^3*Log[x]*Log[1 + x])/384 - (29*Log[2]^3*Log[1 + x]^2)/192 + 
   (97*Log[2]^2*Log[1 - x]*Log[1 + x]^2)/256 + 
   (3*Log[2]*Log[1 - x]^2*Log[1 + x]^2)/64 - (209*Log[1 - x]^3*Log[1 + x]^2)/
    5376 - (13*Log[2]^2*Log[x]*Log[1 + x]^2)/32 + 
   (107*Log[1 - x]^2*Log[x]*Log[1 + x]^2)/256 + (23*Log[2]^2*Log[1 + x]^3)/
    768 - (103*Log[2]*Log[1 - x]*Log[1 + x]^3)/384 - 
   (71*Log[1 - x]^2*Log[1 + x]^3)/5376 + (19*Log[2]*Log[x]*Log[1 + x]^3)/64 - 
   (133*Log[1 - x]*Log[x]*Log[1 + x]^3)/384 + (15*Log[2]*Log[1 + x]^4)/256 + 
   (373*Log[1 - x]*Log[1 + x]^4)/2688 + (155*Log[x]*Log[1 + x]^4)/1536 - 
   (27*Log[1 + x]^5)/280 - (5*Log[2]^3*PolyLog[2, (1 - x)/2])/24 + 
   (15*Log[2]^2*Log[1 - x]*PolyLog[2, (1 - x)/2])/64 - 
   (5*Log[2]*Log[1 - x]^2*PolyLog[2, (1 - x)/2])/64 + 
   (5*Log[1 - x]^3*PolyLog[2, (1 - x)/2])/192 - 
   (5*Log[1 - x]^2*Log[x]*PolyLog[2, (1 - x)/2])/64 + 
   (25*Log[2]^2*Log[1 + x]*PolyLog[2, (1 - x)/2])/64 - 
   (5*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/16 + 
   (5*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, (1 - x)/2])/32 - 
   (15*Log[2]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/64 + 
   (5*Log[1 - x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/32 - 
   (5*Log[x]*Log[1 + x]^2*PolyLog[2, (1 - x)/2])/64 + 
   (5*Log[1 + x]^3*PolyLog[2, (1 - x)/2])/192 - 
   (5*Log[2]*PolyLog[2, (1 - x)/2]^2)/32 + 
   (5*Log[1 + x]*PolyLog[2, (1 - x)/2]^2)/32 + (15*Log[2]^3*PolyLog[2, -x])/
    64 - (15*Log[2]^2*Log[1 - x]*PolyLog[2, -x])/64 + 
   (5*Log[1 - x]^2*Log[x]*PolyLog[2, -x])/32 - 
   (15*Log[2]^2*Log[1 + x]*PolyLog[2, -x])/32 + 
   (15*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, -x])/32 + 
   (5*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, -x])/16 + 
   (15*Log[2]*Log[1 + x]^2*PolyLog[2, -x])/64 - 
   (15*Log[1 - x]*Log[1 + x]^2*PolyLog[2, -x])/64 - 
   (5*Log[1 + x]^3*PolyLog[2, -x])/192 + 
   (5*Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/32 - 
   (5*Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, -x])/32 - 
   (59*Log[2]^3*PolyLog[2, x])/192 + (11*Log[2]^2*Log[1 - x]*PolyLog[2, x])/
    32 + (5*Log[2]*Log[1 - x]^2*PolyLog[2, x])/64 + 
   (37*Log[2]^2*Log[1 + x]*PolyLog[2, x])/64 - 
   (27*Log[2]*Log[1 - x]*Log[1 + x]*PolyLog[2, x])/32 - 
   (11*Log[1 - x]*Log[x]*Log[1 + x]*PolyLog[2, x])/16 - 
   (5*Log[2]*Log[1 + x]^2*PolyLog[2, x])/32 + 
   (27*Log[1 - x]*Log[1 + x]^2*PolyLog[2, x])/64 + 
   (5*Log[x]*Log[1 + x]^2*PolyLog[2, x])/32 - (5*Log[1 + x]^3*PolyLog[2, x])/
    192 - (5*Log[2]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/32 + 
   (5*Log[1 + x]*PolyLog[2, (1 - x)/2]*PolyLog[2, x])/32 + 
   (5*Log[1 - x]*PolyLog[2, -x]*PolyLog[2, x])/16 + 
   (5*Log[1 + x]*PolyLog[2, -x]*PolyLog[2, x])/16 - 
   (Log[1 + x]*PolyLog[2, x]^2)/2 + (11*Log[2]^2*PolyLog[3, (1 - x)/2])/64 + 
   (Log[1 - x]^2*PolyLog[3, (1 - x)/2])/128 + 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/2])/2 - 
   (11*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/2])/32 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/2])/64 - 
   (21*Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/2])/32 + 
   (23*Log[1 + x]^2*PolyLog[3, (1 - x)/2])/128 - 
   (5*PolyLog[2, -x]*PolyLog[3, (1 - x)/2])/16 + 
   (17*PolyLog[2, x]*PolyLog[3, (1 - x)/2])/32 + 
   (5*Log[2]*Log[1 - x]*PolyLog[3, 1 - x])/32 - 
   (31*Log[1 - x]^2*PolyLog[3, 1 - x])/224 - 
   (85*Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/224 - 
   (5*Log[2]*Log[1 + x]*PolyLog[3, 1 - x])/32 - 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, 1 - x])/32 + 
   (Log[1 + x]^2*PolyLog[3, 1 - x])/16 + (5*PolyLog[2, -x]*PolyLog[3, 1 - x])/
    8 - (11*PolyLog[2, x]*PolyLog[3, 1 - x])/16 + 
   (5*Log[2]^2*PolyLog[3, -x])/64 - (5*Log[2]*Log[1 - x]*PolyLog[3, -x])/16 + 
   (19*Log[1 - x]^2*PolyLog[3, -x])/64 + (5*Log[2]*Log[1 + x]*PolyLog[3, -x])/
    32 + (9*Log[1 - x]*Log[1 + x]*PolyLog[3, -x])/32 - 
   (33*Log[1 + x]^2*PolyLog[3, -x])/448 + 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, -x])/32 - (5*Log[2]^2*PolyLog[3, x])/
    64 + (5*Log[2]*Log[1 - x]*PolyLog[3, x])/16 - 
   (31*Log[1 - x]^2*PolyLog[3, x])/224 - (5*Log[2]*Log[1 + x]*PolyLog[3, x])/
    32 - (Log[1 - x]*Log[1 + x]*PolyLog[3, x])/32 + 
   (3*Log[1 + x]^2*PolyLog[3, x])/8 - (5*PolyLog[2, (1 - x)/2]*PolyLog[3, x])/
    32 - (5*Log[2]^2*PolyLog[3, (2*x)/(-1 + x)])/64 + 
   (5*Log[2]*Log[1 - x]*PolyLog[3, (2*x)/(-1 + x)])/16 - 
   (67*Log[1 - x]^2*PolyLog[3, (2*x)/(-1 + x)])/448 - 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/32 - 
   (3*Log[1 - x]*Log[1 + x]*PolyLog[3, (2*x)/(-1 + x)])/224 + 
   (19*Log[1 + x]^2*PolyLog[3, (2*x)/(-1 + x)])/224 - 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, (2*x)/(-1 + x)])/32 - 
   (5*Log[2]*Log[1 - x]*PolyLog[3, (1 + x)^(-1)])/32 - 
   (Log[1 - x]^2*PolyLog[3, (1 + x)^(-1)])/64 + 
   (5*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/32 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/8 + 
   (75*Log[x]*Log[1 + x]*PolyLog[3, (1 + x)^(-1)])/224 - 
   (27*Log[1 + x]^2*PolyLog[3, (1 + x)^(-1)])/112 + 
   (5*PolyLog[2, -x]*PolyLog[3, (1 + x)^(-1)])/16 - 
   (3*PolyLog[2, x]*PolyLog[3, (1 + x)^(-1)])/8 - 
   (15*Log[2]^2*PolyLog[3, (1 - x)/(1 + x)])/64 + 
   (3*Log[2]*Log[1 - x]*PolyLog[3, (1 - x)/(1 + x)])/224 + 
   (Log[1 - x]^2*PolyLog[3, (1 - x)/(1 + x)])/128 + 
   (5*Log[1 - x]*Log[x]*PolyLog[3, (1 - x)/(1 + x)])/14 + 
   (51*Log[2]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/112 + 
   (Log[1 - x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/448 - 
   (5*Log[x]*Log[1 + x]*PolyLog[3, (1 - x)/(1 + x)])/14 - 
   (191*Log[1 + x]^2*PolyLog[3, (1 - x)/(1 + x)])/896 - 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, (1 - x)/(1 + x)])/32 - 
   (5*PolyLog[2, -x]*PolyLog[3, (1 - x)/(1 + x)])/16 + 
   (11*PolyLog[2, x]*PolyLog[3, (1 - x)/(1 + x)])/16 + 
   Pi^2*((53*Log[2]^3)/768 - (15*Log[2]^2*Log[1 - x])/128 + 
     (391*Log[2]*Log[1 - x]^2)/5376 + (827*Log[1 - x]^3)/16128 - 
     (5*Log[2]^2*Log[x])/768 + (Log[2]*Log[1 - x]*Log[x])/12 - 
     (29*Log[1 - x]^2*Log[x])/1792 - (23*Log[2]^2*Log[1 + x])/256 + 
     (109*Log[2]*Log[1 - x]*Log[1 + x])/1344 + (155*Log[1 - x]^2*Log[1 + x])/
      5376 - (37*Log[2]*Log[x]*Log[1 + x])/384 - 
     (17*Log[1 - x]*Log[x]*Log[1 + x])/168 + (29*Log[2]*Log[1 + x]^2)/896 - 
     (277*Log[1 - x]*Log[1 + x]^2)/1344 + (13*Log[x]*Log[1 + x]^2)/168 + 
     (409*Log[1 + x]^3)/4032 + (25*Log[2]*PolyLog[2, (1 - x)/2])/384 + 
     (5*Log[1 - x]*PolyLog[2, (1 - x)/2])/192 + 
     (5*Log[x]*PolyLog[2, (1 - x)/2])/384 - 
     (35*Log[1 + x]*PolyLog[2, (1 - x)/2])/384 - (35*Log[2]*PolyLog[2, -x])/
      384 - (5*Log[1 - x]*PolyLog[2, -x])/192 + 
     (25*Log[1 + x]*PolyLog[2, -x])/384 + (49*Log[2]*PolyLog[2, x])/384 - 
     (17*Log[1 - x]*PolyLog[2, x])/384 - (Log[1 + x]*PolyLog[2, x])/32 - 
     (53*PolyLog[3, (1 - x)/2])/384 + (205*PolyLog[3, 1 - x])/2688 - 
     (5*PolyLog[3, -x])/192 + (5*PolyLog[3, x])/192 + 
     (5*PolyLog[3, (2*x)/(-1 + x)])/192 + (115*PolyLog[3, (1 + x)^(-1)])/
      2688 - (79*PolyLog[3, (1 - x)/(1 + x)])/896 - 
     (61*PolyLog[3, (1 + x)/2])/384) + (19*Log[2]^2*PolyLog[3, (1 + x)/2])/
    64 - (Log[2]*Log[1 - x]*PolyLog[3, (1 + x)/2])/8 + 
   (Log[1 - x]^2*PolyLog[3, (1 + x)/2])/128 + 
   (Log[1 - x]*Log[x]*PolyLog[3, (1 + x)/2])/2 - 
   (15*Log[2]*Log[1 + x]*PolyLog[3, (1 + x)/2])/32 + 
   (9*Log[1 - x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/64 - 
   (21*Log[x]*Log[1 + x]*PolyLog[3, (1 + x)/2])/32 + 
   (23*Log[1 + x]^2*PolyLog[3, (1 + x)/2])/128 + 
   (5*PolyLog[2, (1 - x)/2]*PolyLog[3, (1 + x)/2])/16 - 
   (5*PolyLog[2, -x]*PolyLog[3, (1 + x)/2])/8 + 
   (27*PolyLog[2, x]*PolyLog[3, (1 + x)/2])/32 - (15*Log[2]*PolyLog[4, 1/2])/
    16 + (33*Log[2]*PolyLog[4, (1 - x)/2])/32 + 
   (5*Log[x]*PolyLog[4, (1 - x)/2])/32 - 
   (33*Log[1 + x]*PolyLog[4, (1 - x)/2])/32 - (5*Log[2]*PolyLog[4, 1 - x])/
    8 - (5*Log[1 - x]*PolyLog[4, 1 - x])/8 + (255*Log[x]*PolyLog[4, 1 - x])/
    224 + (25*Log[1 + x]*PolyLog[4, 1 - x])/32 - 
   (9*Log[1 - x]*PolyLog[4, -x])/32 - (125*Log[1 + x]*PolyLog[4, -x])/224 + 
   (67*Log[1 - x]*PolyLog[4, x])/224 - (9*Log[1 + x]*PolyLog[4, x])/32 + 
   (305*Log[1 - x]*PolyLog[4, x/(-1 + x)])/224 - 
   (5*Log[1 + x]*PolyLog[4, x/(-1 + x)])/16 - 
   (201*Log[1 - x]*PolyLog[4, (2*x)/(-1 + x)])/224 + 
   (201*Log[1 + x]*PolyLog[4, (2*x)/(-1 + x)])/224 + 
   (5*Log[1 - x]*PolyLog[4, (4*x)/(1 + x)^2])/32 - 
   (5*Log[1 + x]*PolyLog[4, (4*x)/(1 + x)^2])/32 + 
   (5*Log[2]*PolyLog[4, (1 + x)^(-1)])/8 + 
   (35*Log[1 - x]*PolyLog[4, (1 + x)^(-1)])/32 + 
   (225*Log[x]*PolyLog[4, (1 + x)^(-1)])/224 - 
   (505*Log[1 + x]*PolyLog[4, (1 + x)^(-1)])/224 - 
   (4*Log[2]*PolyLog[4, (1 - x)/(1 + x)])/7 - 
   (15*Log[x]*PolyLog[4, (1 - x)/(1 + x)])/14 + 
   (4*Log[1 + x]*PolyLog[4, (1 - x)/(1 + x)])/7 - 
   (Log[2]*PolyLog[4, (-1 + x)/(1 + x)])/8 + 
   (Log[x]*PolyLog[4, (-1 + x)/(1 + x)])/2 + 
   (Log[1 + x]*PolyLog[4, (-1 + x)/(1 + x)])/8 + 
   (15*Log[1 - x]*PolyLog[4, x/(1 + x)])/16 - 
   (167*Log[1 + x]*PolyLog[4, x/(1 + x)])/224 - 
   (271*Log[1 - x]*PolyLog[4, (2*x)/(1 + x)])/224 + 
   (271*Log[1 + x]*PolyLog[4, (2*x)/(1 + x)])/224 + 
   (27*Log[2]*PolyLog[4, (1 + x)/2])/32 + 
   (7*Log[1 - x]*PolyLog[4, (1 + x)/2])/8 + (5*Log[x]*PolyLog[4, (1 + x)/2])/
    32 - (55*Log[1 + x]*PolyLog[4, (1 + x)/2])/32 + 
   (5*Log[2]*PolyLog[4, 1 - x^2])/64 + (5*Log[1 - x]*PolyLog[4, 1 - x^2])/
    32 - (5*Log[1 + x]*PolyLog[4, 1 - x^2])/64 - 
   (17*Log[1 - x]*PolyLog[4, x^2/(-1 + x^2)])/128 + 
   (3*Log[1 + x]*PolyLog[4, x^2/(-1 + x^2)])/128 - (15*PolyLog[5, 1/2])/16 + 
   (57*PolyLog[5, (1 - x)/2])/32 - (65*PolyLog[5, 1 - x])/32 + 
   (5*PolyLog[5, -x])/32 + (5*PolyLog[5, x])/32 - 
   (5*PolyLog[5, (-4*x)/(1 - x)^2])/128 + (5*PolyLog[5, x/(-1 + x)])/32 - 
   (5*PolyLog[5, (4*x)/(1 + x)^2])/128 - (19*PolyLog[5, (1 + x)^(-1)])/8 + 
   (119*PolyLog[5, (1 - x)/(1 + x)])/64 + (49*PolyLog[5, (-1 + x)/(1 + x)])/
    64 + (5*PolyLog[5, x/(1 + x)])/32 + (43*PolyLog[5, (1 + x)/2])/32 - 
   PolyLog[5, 1 - x^2]/64 + (307*Pi^2*Zeta[3])/1344 - 
   (105*Log[2]^2*Zeta[3])/256 + 
   ((5*Log[2]^2)/128 + (3737*Log[2]*Log[1 - x])/1792 + 
     (1151*Log[1 - x]^2)/3584 + (35*Log[2]*Log[x])/128 - 
     (157*Log[1 - x]*Log[x])/224 - (2407*Log[2]*Log[1 + x])/1792 + 
     (23*Log[1 - x]*Log[1 + x])/1792 + (137*Log[x]*Log[1 + x])/224 + 
     (149*Log[1 + x]^2)/3584 - (5*PolyLog[2, (1 - x)/2])/128 + 
     (55*PolyLog[2, -x])/256 - (217*PolyLog[2, x])/256)*Zeta[3] + 
   Log[1 - x]*((7*Pi^4)/1920 + (65*Pi^2*Log[2]^2)/768 - (65*Log[2]^4)/768 - 
     (65*PolyLog[4, 1/2])/32 - (455*Log[2]*Zeta[3])/256) + 
   Log[x]*((-437*Pi^4)/53760 + (5*Pi^2*Log[2]^2)/384 - (5*Log[2]^4)/384 - 
     (5*PolyLog[4, 1/2])/16 - (35*Log[2]*Zeta[3])/128) + 
   Log[2]*((-41*Pi^4)/2240 - (5*Pi^2*Log[2]^2)/192 + (5*Log[2]^4)/192 + 
     (5*PolyLog[4, 1/2])/8 + (35*Log[2]*Zeta[3])/64) + 
   Log[1 + x]*((3149*Pi^4)/161280 - (25*Pi^2*Log[2]^2)/768 + 
     (25*Log[2]^4)/768 + (25*PolyLog[4, 1/2])/32 + (175*Log[2]*Zeta[3])/
      256) + (7151*Zeta[5])/7168, HPL[{2, 1, 2}, x_] :>  
  (15*HPL[{3, 2}, 1 - x])/7 + (6*HPL[{3, 2}, x])/7 - 
   (6*HPL[{3, 2}, x/(-1 + x)])/7 - (Pi^4*Log[1 - x])/40 - 
   (4*Log[1 - x]^5)/35 + (Pi^4*Log[x])/14 + (13*Log[1 - x]^4*Log[x])/28 + 
   Log[1 - x]^2*Log[x]*PolyLog[2, x] + (Log[1 - x]*PolyLog[2, x]^2)/2 + 
   Pi^2*((-5*Log[1 - x]^3)/21 + (5*Log[1 - x]^2*Log[x])/28 - 
     (Log[1 - x]*PolyLog[2, x])/3 - (5*PolyLog[3, 1 - x])/14) + 
   (3*Log[1 - x]^2*PolyLog[3, 1 - x])/7 + 
   (15*Log[1 - x]*Log[x]*PolyLog[3, 1 - x])/7 + 
   2*PolyLog[2, x]*PolyLog[3, 1 - x] + (3*Log[1 - x]^2*PolyLog[3, x])/7 - 
   (45*Log[x]*PolyLog[4, 1 - x])/7 - (18*Log[1 - x]*PolyLog[4, x])/7 - 
   (18*Log[1 - x]*PolyLog[4, x/(-1 + x)])/7 + 6*PolyLog[5, 1 - x] - 
   (5*Pi^2*Zeta[3])/7 + ((-9*Log[1 - x]^2)/7 + (30*Log[1 - x]*Log[x])/7 - 
     2*PolyLog[2, x])*Zeta[3] + (81*Zeta[5])/14, 
 HPL[{2, 1, 1, -1}, x_] :>  HPL[{-2, -1, -1, 1}, -x], 
 HPL[{2, 1, 1, 1}, x_] :>  (Pi^2*Log[1 - x]^3)/36 - (Log[1 - x]^4*Log[x])/8 - 
   (Log[1 - x]^3*PolyLog[2, x])/6 - (Log[1 - x]^2*PolyLog[3, 1 - x])/2 + 
   Log[1 - x]*PolyLog[4, 1 - x] - PolyLog[5, 1 - x] + Zeta[5]};
