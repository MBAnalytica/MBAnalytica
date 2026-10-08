G[-1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*Log[2] - Log[3]
 
G[0, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[3]
 
G[1, 1/3] /; PLT$AutoConvertToKnownConstants := Log[2] - Log[3]
 
G[-1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*Log[2]^2 - 2*Log[2]*Log[3] + Log[3]^2/2
 
G[-1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^2/6 - Log[2]^2 + Log[3]^2/2 - 2*PolyLog[2, -1/2]
 
G[-1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^2/12 + Log[2]^2 - Log[2]*Log[3] + Log[3]^2/2 - 
    PolyLog[2, -1/2]
 
G[0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := Pi^2/6 + Log[2]^2 - 2*Log[2]*Log[3] + Log[3]^2/2 + 
    2*PolyLog[2, -1/2]
 
G[0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := Log[3]^2/2
 
G[0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := Log[2]^2/2 - Log[2]*Log[3] + Log[3]^2/2 + PolyLog[2, -1/2]
 
G[1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := Pi^2/12 + Log[2]^2 - 2*Log[2]*Log[3] + Log[3]^2/2 + 
    PolyLog[2, -1/2]
 
G[1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[2]^2/2 + Log[3]^2/2 - PolyLog[2, -1/2]
 
G[1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := Log[2]^2/2 - Log[2]*Log[3] + Log[3]^2/2
 
G[-1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (4*Log[2]^3)/3 - 2*Log[2]^2*Log[3] + 
    Log[2]*Log[3]^2 - Log[3]^3/6
 
G[-1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2])/3 - (2*Log[2]^3)/3 + (Pi^2*Log[3])/6 + 
    Log[2]*Log[3]^2 - Log[3]^3/2 + 4*PolyLog[3, -1/2] + 2*PolyLog[3, 1/3] + 
    (4*Zeta[3])/3
 
G[-1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2])/12 + Log[2]^3 + (Pi^2*Log[3])/12 - 
    (3*Log[2]^2*Log[3])/2 + Log[2]*Log[3]^2 - Log[3]^3/3 + PolyLog[3, -1/2] + 
    PolyLog[3, 1/3] - Zeta[3]/8
 
G[-1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[2])/3 - (2*Log[2]^3)/3 - (Pi^2*Log[3])/6 + 
    Log[2]^2*Log[3] - Log[2]*Log[3]^2 + Log[3]^3/2 - 
    4*Log[2]*PolyLog[2, -1/2] + 2*Log[3]*PolyLog[2, -1/2] - 
    8*PolyLog[3, -1/2] - 4*PolyLog[3, 1/3] - (8*Zeta[3])/3
 
G[-1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := Log[2]^2*Log[3] - Log[2]*Log[3]^2 + Log[3]^3/6 + 
    2*Log[3]*PolyLog[2, -1/2] - 2*PolyLog[3, 1/3] + (13*Zeta[3])/6
 
G[-1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[2]^3/3 + Log[2]^2*Log[3] - Log[2]*Log[3]^2 + 
    Log[3]^3/3 - 2*Log[2]*PolyLog[2, -1/2] + 2*Log[3]*PolyLog[2, -1/2] - 
    4*PolyLog[3, -1/2] - 3*PolyLog[3, 1/3] - (11*Zeta[3])/24
 
G[-1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[3])/12 + Log[3]^3/6 - 
    2*Log[2]*PolyLog[2, -1/2] + Log[3]*PolyLog[2, -1/2] - 
    2*PolyLog[3, -1/2] - 2*PolyLog[3, 1/3] + Zeta[3]/4
 
G[-1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2])/6 - Log[2]^3/2 + (Log[2]^2*Log[3])/2 - 
    Log[3]^3/6 + Log[3]*PolyLog[2, -1/2] + 3*PolyLog[3, -1/2] + (11*Zeta[3])/4
 
G[-1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2])/12 + Log[2]^3/6 - 
    Log[2]*PolyLog[2, -1/2] + Log[3]*PolyLog[2, -1/2] - PolyLog[3, 1/3] + 
    (7*Zeta[3])/8
 
G[0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (4*Log[2]^3)/3 - 3*Log[2]^2*Log[3] + 
    2*Log[2]*Log[3]^2 - Log[3]^3/2 + 4*Log[2]*PolyLog[2, -1/2] - 
    2*Log[3]*PolyLog[2, -1/2] + 4*PolyLog[3, -1/2] + 2*PolyLog[3, 1/3] + 
    (4*Zeta[3])/3
 
G[0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[3])/6 - Log[2]^2*Log[3] + 2*Log[2]*Log[3]^2 - 
    (5*Log[3]^3)/6 - 2*Log[3]*PolyLog[2, -1/2] + 4*PolyLog[3, 1/3] - 
    (13*Zeta[3])/3
 
G[0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[2])/6 + (5*Log[2]^3)/6 + (Pi^2*Log[3])/12 - 
    (5*Log[2]^2*Log[3])/2 + 2*Log[2]*Log[3]^2 - (2*Log[3]^3)/3 + 
    2*Log[2]*PolyLog[2, -1/2] - 2*Log[3]*PolyLog[2, -1/2] + 
    PolyLog[3, -1/2] + 3*PolyLog[3, 1/3] - (55*Zeta[3])/24
 
G[0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[3])/6 + Log[3]^3/6 - 2*PolyLog[3, 1/3] + 
    (13*Zeta[3])/6
 
G[0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[3]^3/6
 
G[0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -PolyLog[3, 1/3]
 
G[0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2])/6 + Log[2]^3/2 - (Pi^2*Log[3])/12 - 
    Log[2]^2*Log[3] + Log[2]*Log[3]^2 - Log[3]^3/6 + 
    2*Log[2]*PolyLog[2, -1/2] - Log[3]*PolyLog[2, -1/2] + 
    3*PolyLog[3, -1/2] + (11*Zeta[3])/4
 
G[0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -(Log[2]^2*Log[3])/2 + Log[2]*Log[3]^2 - Log[3]^3/2 - 
    Log[3]*PolyLog[2, -1/2] + 2*PolyLog[3, 1/3]
 
G[0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := Log[2]^3/3 - Log[2]^2*Log[3] + Log[2]*Log[3]^2 - 
    Log[3]^3/3 + Log[2]*PolyLog[2, -1/2] - Log[3]*PolyLog[2, -1/2] + 
    PolyLog[3, -1/2] + PolyLog[3, 1/3]
 
G[1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[2])/12 + Log[2]^3 - (5*Log[2]^2*Log[3])/2 + 
    (3*Log[2]*Log[3]^2)/2 - Log[3]^3/3 + 2*Log[2]*PolyLog[2, -1/2] - 
    Log[3]*PolyLog[2, -1/2] + PolyLog[3, -1/2] + PolyLog[3, 1/3] - Zeta[3]/8
 
G[1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[2]^3/6 + (Pi^2*Log[3])/6 - (Log[2]^2*Log[3])/2 + 
    (3*Log[2]*Log[3]^2)/2 - (2*Log[3]^3)/3 - Log[3]*PolyLog[2, -1/2] + 
    PolyLog[3, -1/2] + 3*PolyLog[3, 1/3] - (55*Zeta[3])/24
 
G[1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[2])/12 + (2*Log[2]^3)/3 + (Pi^2*Log[3])/12 - 
    2*Log[2]^2*Log[3] + (3*Log[2]*Log[3]^2)/2 - Log[3]^3/2 + 
    Log[2]*PolyLog[2, -1/2] - Log[3]*PolyLog[2, -1/2] + 2*PolyLog[3, 1/3] - 
    (7*Zeta[3])/4
 
G[1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[2])/6 - Log[2]^3/3 - (Pi^2*Log[3])/6 + 
    (Log[2]^2*Log[3])/2 - (Log[2]*Log[3]^2)/2 + Log[3]^3/3 - 
    2*Log[2]*PolyLog[2, -1/2] + Log[3]*PolyLog[2, -1/2] - 
    4*PolyLog[3, -1/2] - 3*PolyLog[3, 1/3] - (11*Zeta[3])/24
 
G[1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (Log[2]^2*Log[3])/2 - (Log[2]*Log[3]^2)/2 + 
    Log[3]*PolyLog[2, -1/2] - PolyLog[3, 1/3]
 
G[1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[2]^3/6 + (Log[2]^2*Log[3])/2 - 
    (Log[2]*Log[3]^2)/2 + Log[3]^3/6 - Log[2]*PolyLog[2, -1/2] + 
    Log[3]*PolyLog[2, -1/2] - 2*PolyLog[3, -1/2] - 2*PolyLog[3, 1/3]
 
G[1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := Log[2]^3/6 - (Pi^2*Log[3])/12 - (Log[2]^2*Log[3])/2 + 
    (Log[2]*Log[3]^2)/2 - PolyLog[3, 1/3] + (7*Zeta[3])/8
 
G[1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[2]^3/6 + (Log[2]*Log[3]^2)/2 - Log[3]^3/3 + 
    PolyLog[3, -1/2] + PolyLog[3, 1/3]
 
G[1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := Log[2]^3/6 - (Log[2]^2*Log[3])/2 + (Log[2]*Log[3]^2)/2 - 
    Log[3]^3/6
 
G[-1, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (2*Log[2]^4)/3 - (4*Log[2]^3*Log[3])/3 + 
    Log[2]^2*Log[3]^2 - (Log[2]*Log[3]^3)/3 + Log[3]^4/24
 
G[-1, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (13*Pi^4)/540 + (2*Pi^2*Log[2]^2)/9 - 
    (7*Log[2]^4)/18 - (Pi^2*Log[2]*Log[3])/3 + (Pi^2*Log[3]^2)/12 + 
    (Log[2]*Log[3]^3)/3 - Log[3]^4/8 - 4*PolyLog[4, -1/2] - 
    2*PolyLog[4, -1/3] + 2*PolyLog[4, 1/3] - (16*PolyLog[4, 1/2])/3 - 
    4*PolyLog[4, 2/3] + 2*Log[2]*Zeta[3] - Log[3]*Zeta[3]
 
G[-1, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (2*Log[2]^4)/3 - (Pi^2*Log[2]*Log[3])/12 - 
    (7*Log[2]^3*Log[3])/6 + (Pi^2*Log[3]^2)/24 + (3*Log[2]^2*Log[3]^2)/4 - 
    (Log[2]*Log[3]^3)/6 + PolyLog[4, 1/2] - PolyLog[4, 2/3] + 
    (7*Log[2]*Zeta[3])/4 - (7*Log[3]*Zeta[3])/8
 
G[-1, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-13*Pi^4)/180 - (4*Pi^2*Log[2]^2)/3 - 
    Log[2]^4/6 + (5*Pi^2*Log[2]*Log[3])/3 + (2*Log[2]^3*Log[3])/3 - 
    (5*Pi^2*Log[3]^2)/12 + 2*Log[2]^2*Log[3]^2 - 3*Log[2]*Log[3]^3 + 
    (7*Log[3]^4)/8 + 8*Log[2]*PolyLog[3, -1/2] - 4*Log[3]*PolyLog[3, -1/2] + 
    4*Log[2]*PolyLog[3, 1/3] - 2*Log[3]*PolyLog[3, 1/3] + 
    12*PolyLog[4, -1/2] + 6*PolyLog[4, -1/3] - 6*PolyLog[4, 1/3] + 
    16*PolyLog[4, 1/2] + 12*PolyLog[4, 2/3] - (10*Log[2]*Zeta[3])/3 + 
    (5*Log[3]*Zeta[3])/3
 
G[-1, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (-13*Pi^4)/540 - (2*Pi^2*Log[2]^2)/9 - 
    (5*Log[2]^4)/18 + (2*Pi^2*Log[2]*Log[3])/3 + (2*Log[2]^3*Log[3])/3 - 
    (Pi^2*Log[3]^2)/4 - Log[2]*Log[3]^3 + Log[3]^4/2 - 
    4*Log[3]*PolyLog[3, -1/2] - 2*Log[3]*PolyLog[3, 1/3] - 
    4*PolyLog[4, -1/2] + PolyLog[4, -1/3] - 2*PolyLog[4, 1/3] - 
    (8*PolyLog[4, 1/2])/3 + 4*PolyLog[4, 2/3] - 2*Log[2]*Zeta[3] - 
    (Log[3]*Zeta[3])/3
 
G[-1, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-19*Pi^4)/240 - (29*Pi^2*Log[2]^2)/24 + 
    Log[2]^4/24 + (4*Pi^2*Log[2]*Log[3])/3 + (2*Log[2]^3*Log[3])/3 - 
    (13*Pi^2*Log[3]^2)/48 + Log[2]^2*Log[3]^2 - 2*Log[2]*Log[3]^3 + 
    (61*Log[3]^4)/96 + 4*Log[2]*PolyLog[3, -1/2] - 
    4*Log[3]*PolyLog[3, -1/2] + 2*Log[2]*PolyLog[3, 1/3] - 
    2*Log[3]*PolyLog[3, 1/3] + 4*PolyLog[4, -1/2] + (19*PolyLog[4, -1/3])/4 - 
    (13*PolyLog[4, 1/3])/2 + 13*PolyLog[4, 1/2] + 8*PolyLog[4, 2/3] + 
    (59*Log[2]*Zeta[3])/24 - (11*Log[3]*Zeta[3])/6
 
G[-1, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2]^2)/6 + (Pi^2*Log[2]*Log[3])/2 - 
    (Log[2]^3*Log[3])/2 - (5*Pi^2*Log[3]^2)/24 + (5*Log[2]^2*Log[3]^2)/4 - 
    (7*Log[2]*Log[3]^3)/6 + Log[3]^4/3 + 2*Log[2]*PolyLog[3, -1/2] - 
    Log[3]*PolyLog[3, -1/2] + 2*Log[2]*PolyLog[3, 1/3] - 
    Log[3]*PolyLog[3, 1/3] - 3*PolyLog[4, 1/2] + 3*PolyLog[4, 2/3] - 
    (11*Log[2]*Zeta[3])/2 + (11*Log[3]*Zeta[3])/4
 
G[-1, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (71*Pi^4)/2160 + (13*Pi^2*Log[2]^2)/36 - 
    (47*Log[2]^4)/72 - (Pi^2*Log[2]*Log[3])/6 + (Log[2]^3*Log[3])/6 - 
    (Pi^2*Log[3]^2)/12 + Log[3]^4/8 - Log[3]*PolyLog[3, -1/2] - 
    Log[3]*PolyLog[3, 1/3] - 5*PolyLog[4, -1/2] - 3*PolyLog[4, -1/3] + 
    3*PolyLog[4, 1/3] - (32*PolyLog[4, 1/2])/3 - 2*PolyLog[4, 2/3] - 
    (13*Log[2]*Zeta[3])/4 + (7*Log[3]*Zeta[3])/4
 
G[-1, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-7*Pi^4)/720 - (Pi^2*Log[2]^2)/6 + Log[2]^4/4 + 
    (Pi^2*Log[2]*Log[3])/4 - (Log[2]^3*Log[3])/2 - (Pi^2*Log[3]^2)/12 + 
    (3*Log[2]^2*Log[3]^2)/4 - (2*Log[2]*Log[3]^3)/3 + (5*Log[3]^4)/24 + 
    Log[2]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, -1/2] + 
    Log[2]*PolyLog[3, 1/3] - Log[3]*PolyLog[3, 1/3] - PolyLog[4, -1/2] - 
    PolyLog[4, 1/3] + PolyLog[4, 2/3] - (Log[2]*Zeta[3])/4 + 
    (Log[3]*Zeta[3])/8
 
G[-1, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (13*Pi^4)/180 + (5*Pi^2*Log[2]^2)/3 - Log[2]^4/2 - 
    2*Pi^2*Log[2]*Log[3] + (2*Log[2]^3*Log[3])/3 + (Pi^2*Log[3]^2)/2 - 
    (7*Log[2]^2*Log[3]^2)/2 + 4*Log[2]*Log[3]^3 - (9*Log[3]^4)/8 - 
    4*Log[2]^2*PolyLog[2, -1/2] + 4*Log[2]*Log[3]*PolyLog[2, -1/2] - 
    Log[3]^2*PolyLog[2, -1/2] - 16*Log[2]*PolyLog[3, -1/2] + 
    8*Log[3]*PolyLog[3, -1/2] - 8*Log[2]*PolyLog[3, 1/3] + 
    4*Log[3]*PolyLog[3, 1/3] - 12*PolyLog[4, -1/2] - 6*PolyLog[4, -1/3] + 
    6*PolyLog[4, 1/3] - 16*PolyLog[4, 1/2] - 12*PolyLog[4, 2/3] + 
    (2*Log[2]*Zeta[3])/3 - (Log[3]*Zeta[3])/3
 
G[-1, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (67*Pi^4)/1080 + (11*Pi^2*Log[2]^2)/18 + 
    (19*Log[2]^4)/18 - (4*Pi^2*Log[2]*Log[3])/3 - (4*Log[2]^3*Log[3])/3 + 
    (5*Pi^2*Log[3]^2)/12 - (Log[2]^2*Log[3]^2)/2 + 2*Log[2]*Log[3]^3 - 
    (7*Log[3]^4)/8 + (Pi^2*PolyLog[2, -1/2])/3 + 
    2*Log[2]^2*PolyLog[2, -1/2] - Log[3]^2*PolyLog[2, -1/2] + 
    2*PolyLog[2, -1/2]^2 + 8*Log[3]*PolyLog[3, -1/2] + 
    4*Log[3]*PolyLog[3, 1/3] + 8*PolyLog[4, -1/2] - 2*PolyLog[4, -1/3] + 
    4*PolyLog[4, 1/3] + (16*PolyLog[4, 1/2])/3 - 8*PolyLog[4, 2/3] + 
    4*Log[2]*Zeta[3] + (2*Log[3]*Zeta[3])/3
 
G[-1, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (11*Pi^4)/144 + (31*Pi^2*Log[2]^2)/24 + 
    Log[2]^4/12 - (5*Pi^2*Log[2]*Log[3])/3 - (Log[2]^3*Log[3])/3 + 
    (19*Pi^2*Log[3]^2)/48 - (7*Log[2]^2*Log[3]^2)/4 + 
    (17*Log[2]*Log[3]^3)/6 - (89*Log[3]^4)/96 + (Pi^2*PolyLog[2, -1/2])/6 - 
    2*Log[2]^2*PolyLog[2, -1/2] + 2*Log[2]*Log[3]*PolyLog[2, -1/2] - 
    Log[3]^2*PolyLog[2, -1/2] + PolyLog[2, -1/2]^2 - 
    8*Log[2]*PolyLog[3, -1/2] + 8*Log[3]*PolyLog[3, -1/2] - 
    4*Log[2]*PolyLog[3, 1/3] + 4*Log[3]*PolyLog[3, 1/3] + 
    3*PolyLog[4, -1/2] - (15*PolyLog[4, -1/3])/4 + (11*PolyLog[4, 1/3])/2 - 
    3*PolyLog[4, 1/2] - 9*PolyLog[4, 2/3] - (5*Log[2]*Zeta[3])/12 + 
    (17*Log[3]*Zeta[3])/12
 
G[-1, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^4/72 - (Pi^2*Log[2]^2)/6 - Log[2]^4/2 + 
    2*Log[2]^3*Log[3] + (Pi^2*Log[3]^2)/12 - (5*Log[2]^2*Log[3]^2)/2 + 
    (4*Log[2]*Log[3]^3)/3 - (7*Log[3]^4)/24 - (Pi^2*PolyLog[2, -1/2])/3 - 
    2*Log[2]^2*PolyLog[2, -1/2] + 4*Log[2]*Log[3]*PolyLog[2, -1/2] - 
    Log[3]^2*PolyLog[2, -1/2] - 2*PolyLog[2, -1/2]^2 - 
    4*Log[2]*PolyLog[3, 1/3] + 2*Log[3]*PolyLog[3, 1/3] + 
    (13*Log[2]*Zeta[3])/3 - (13*Log[3]*Zeta[3])/6
 
G[-1, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[3]^2)/12 - (Log[2]^2*Log[3]^2)/2 + 
    (2*Log[2]*Log[3]^3)/3 - Log[3]^4/4 - Log[3]^2*PolyLog[2, -1/2] + 
    2*Log[3]*PolyLog[3, 1/3] + PolyLog[4, -1/3] - (13*Log[3]*Zeta[3])/6
 
G[-1, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-5*Pi^4)/432 - (5*Pi^2*Log[2]^2)/36 - Log[2]^4/9 + 
    Log[2]^3*Log[3] + (Pi^2*Log[3]^2)/12 - (3*Log[2]^2*Log[3]^2)/2 + 
    Log[2]*Log[3]^3 - (7*Log[3]^4)/24 - Log[2]^2*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] - Log[3]^2*PolyLog[2, -1/2] - 
    PolyLog[2, -1/2]^2 - 2*Log[2]*PolyLog[3, 1/3] + 
    2*Log[3]*PolyLog[3, 1/3] + PolyLog[4, -1/3] - PolyLog[4, 1/3] + 
    (10*PolyLog[4, 1/2])/3 + (35*Log[2]*Zeta[3])/12 - (13*Log[3]*Zeta[3])/6
 
G[-1, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (59*Pi^4)/720 + (9*Pi^2*Log[2]^2)/8 - 
    (5*Log[2]^4)/6 - Pi^2*Log[2]*Log[3] + (4*Log[2]^3*Log[3])/3 + 
    (7*Pi^2*Log[3]^2)/48 - (13*Log[2]^2*Log[3]^2)/4 + 
    (17*Log[2]*Log[3]^3)/6 - (65*Log[3]^4)/96 - (Pi^2*PolyLog[2, -1/2])/6 - 
    2*Log[2]^2*PolyLog[2, -1/2] + 4*Log[2]*Log[3]*PolyLog[2, -1/2] - 
    Log[3]^2*PolyLog[2, -1/2] - PolyLog[2, -1/2]^2 - 
    8*Log[2]*PolyLog[3, -1/2] + 4*Log[3]*PolyLog[3, -1/2] - 
    6*Log[2]*PolyLog[3, 1/3] + 3*Log[3]*PolyLog[3, 1/3] - 
    11*PolyLog[4, -1/2] - (23*PolyLog[4, -1/3])/4 + (15*PolyLog[4, 1/3])/2 - 
    23*PolyLog[4, 1/2] - 7*PolyLog[4, 2/3] - (65*Log[2]*Zeta[3])/12 + 
    (65*Log[3]*Zeta[3])/24
 
G[-1, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (101*Pi^4)/1440 + (2*Pi^2*Log[2]^2)/3 + 
    Log[2]^4/12 - (2*Pi^2*Log[2]*Log[3])/3 - (2*Log[2]^3*Log[3])/3 + 
    (5*Pi^2*Log[3]^2)/48 - (Log[2]^2*Log[3]^2)/2 + (4*Log[2]*Log[3]^3)/3 - 
    (15*Log[3]^4)/32 + Log[2]^2*PolyLog[2, -1/2] - 
    Log[3]^2*PolyLog[2, -1/2] + PolyLog[2, -1/2]^2 + 
    4*Log[3]*PolyLog[3, -1/2] + 3*Log[3]*PolyLog[3, 1/3] + 
    4*PolyLog[4, -1/2] - (11*PolyLog[4, -1/3])/4 + (13*PolyLog[4, 1/3])/2 - 
    8*PolyLog[4, 1/2] - 4*PolyLog[4, 2/3] - 3*Log[2]*Zeta[3] + 
    (47*Log[3]*Zeta[3])/24
 
G[-1, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (49*Pi^4)/1080 + (25*Pi^2*Log[2]^2)/36 - 
    (11*Log[2]^4)/72 - (5*Pi^2*Log[2]*Log[3])/6 + (Log[2]^3*Log[3])/3 + 
    (3*Pi^2*Log[3]^2)/16 - (7*Log[2]^2*Log[3]^2)/4 + 2*Log[2]*Log[3]^3 - 
    (19*Log[3]^4)/32 - Log[2]^2*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] - Log[3]^2*PolyLog[2, -1/2] - 
    4*Log[2]*PolyLog[3, -1/2] + 4*Log[3]*PolyLog[3, -1/2] - 
    3*Log[2]*PolyLog[3, 1/3] + 3*Log[3]*PolyLog[3, 1/3] - PolyLog[4, -1/2] - 
    (11*PolyLog[4, -1/3])/4 + (9*PolyLog[4, 1/3])/2 - 
    (20*PolyLog[4, 1/2])/3 - 5*PolyLog[4, 2/3] - (5*Log[2]*Zeta[3])/6 + 
    (23*Log[3]*Zeta[3])/24
 
G[-1, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[2]^2)/6 - (7*Pi^2*Log[2]*Log[3])/12 + 
    (Log[2]^3*Log[3])/2 + (Pi^2*Log[3]^2)/4 - (5*Log[2]^2*Log[3]^2)/4 + 
    (4*Log[2]*Log[3]^3)/3 - (5*Log[3]^4)/12 - 2*Log[2]^2*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] - (Log[3]^2*PolyLog[2, -1/2])/2 - 
    4*Log[2]*PolyLog[3, -1/2] + 2*Log[3]*PolyLog[3, -1/2] - 
    4*Log[2]*PolyLog[3, 1/3] + 2*Log[3]*PolyLog[3, 1/3] + 3*PolyLog[4, 1/2] - 
    3*PolyLog[4, 2/3] + (23*Log[2]*Zeta[3])/4 - (23*Log[3]*Zeta[3])/8
 
G[-1, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (13*Pi^4)/432 + (23*Pi^2*Log[2]^2)/72 + 
    (5*Log[2]^4)/36 - (Pi^2*Log[2]*Log[3])/2 - (Log[2]^3*Log[3])/3 + 
    (3*Pi^2*Log[3]^2)/16 - (Log[2]^2*Log[3]^2)/4 + (2*Log[2]*Log[3]^3)/3 - 
    (11*Log[3]^4)/32 + (Pi^2*PolyLog[2, -1/2])/6 + 
    Log[2]^2*PolyLog[2, -1/2] - (Log[3]^2*PolyLog[2, -1/2])/2 + 
    PolyLog[2, -1/2]^2 + 2*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]*PolyLog[3, 1/3] - PolyLog[4, -1/2] + PolyLog[4, -1/3]/4 + 
    (3*PolyLog[4, 1/3])/2 - (5*PolyLog[4, 1/2])/3 - 3*PolyLog[4, 2/3] + 
    2*Log[2]*Zeta[3] - (5*Log[3]*Zeta[3])/4
 
G[-1, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (11*Pi^4)/480 + (Pi^2*Log[2]^2)/4 - 
    (5*Pi^2*Log[2]*Log[3])/12 + (Pi^2*Log[3]^2)/8 - (Log[2]^2*Log[3]^2)/2 + 
    (5*Log[2]*Log[3]^3)/6 - (7*Log[3]^4)/24 + (Pi^2*PolyLog[2, -1/2])/12 - 
    Log[2]^2*PolyLog[2, -1/2] + Log[2]*Log[3]*PolyLog[2, -1/2] - 
    (Log[3]^2*PolyLog[2, -1/2])/2 + PolyLog[2, -1/2]^2/2 - 
    2*Log[2]*PolyLog[3, -1/2] + 2*Log[3]*PolyLog[3, -1/2] - 
    2*Log[2]*PolyLog[3, 1/3] + 2*Log[3]*PolyLog[3, 1/3] + 
    2*PolyLog[4, -1/2] + 2*PolyLog[4, 1/3] - 2*PolyLog[4, 2/3] + 
    (Log[2]*Zeta[3])/2 - (Log[3]*Zeta[3])/4
 
G[-1, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-23*Pi^4)/240 - (11*Pi^2*Log[2]^2)/8 + 
    Log[2]^4/6 + Pi^2*Log[2]*Log[3] + (3*Log[2]^3*Log[3])/2 - 
    (Pi^2*Log[3]^2)/48 - (Log[2]^2*Log[3]^2)/4 - Log[2]*Log[3]^3 + 
    (25*Log[3]^4)/96 - (Pi^2*PolyLog[2, -1/2])/6 - 
    Log[2]^2*PolyLog[2, -1/2] + 2*Log[2]*Log[3]*PolyLog[2, -1/2] - 
    (Log[3]^2*PolyLog[2, -1/2])/2 - PolyLog[2, -1/2]^2 + 
    6*Log[2]*PolyLog[3, -1/2] - 3*Log[3]*PolyLog[3, -1/2] + 
    11*PolyLog[4, -1/2] + (23*PolyLog[4, -1/3])/4 - (15*PolyLog[4, 1/3])/2 + 
    23*PolyLog[4, 1/2] + 7*PolyLog[4, 2/3] + 10*Log[2]*Zeta[3] - 
    5*Log[3]*Zeta[3]
 
G[-1, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (-71*Pi^4)/2160 - (13*Pi^2*Log[2]^2)/36 - 
    Log[2]^4/72 + (Pi^2*Log[2]*Log[3])/2 + (Log[2]^3*Log[3])/2 - 
    (Log[2]^2*Log[3]^2)/4 - (Log[2]*Log[3]^3)/3 + Log[3]^4/8 - 
    (Log[3]^2*PolyLog[2, -1/2])/2 - 3*Log[3]*PolyLog[3, -1/2] - 
    3*PolyLog[4, -1/2] + 3*PolyLog[4, -1/3] - 4*PolyLog[4, 1/3] + 
    (8*PolyLog[4, 1/2])/3 + 3*PolyLog[4, 2/3] + (3*Log[2]*Zeta[3])/2 - 
    (7*Log[3]*Zeta[3])/2
 
G[-1, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-169*Pi^4)/4320 - (53*Pi^2*Log[2]^2)/72 - 
    (5*Log[2]^4)/36 + (5*Pi^2*Log[2]*Log[3])/6 + Log[2]^3*Log[3] - 
    (Pi^2*Log[3]^2)/6 - (Log[2]^2*Log[3]^2)/4 - (2*Log[2]*Log[3]^3)/3 + 
    Log[3]^4/4 - (Log[2]^2*PolyLog[2, -1/2])/2 + 
    Log[2]*Log[3]*PolyLog[2, -1/2] - (Log[3]^2*PolyLog[2, -1/2])/2 - 
    PolyLog[2, -1/2]^2/2 + 3*Log[2]*PolyLog[3, -1/2] - 
    3*Log[3]*PolyLog[3, -1/2] + 4*PolyLog[4, -1/2] + 3*PolyLog[4, -1/3] - 
    3*PolyLog[4, 1/3] + (23*PolyLog[4, 1/2])/3 + 5*PolyLog[4, 2/3] + 
    (5*Log[2]*Zeta[3])/4 - (3*Log[3]*Zeta[3])/2
 
G[-1, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^4/288 - (Pi^2*Log[2]^2)/12 - Log[2]^4/6 + 
    (5*Log[2]^3*Log[3])/6 + (Pi^2*Log[3]^2)/24 - Log[2]^2*Log[3]^2 + 
    (Log[2]*Log[3]^3)/2 - Log[3]^4/8 - (Pi^2*PolyLog[2, -1/2])/12 - 
    Log[2]^2*PolyLog[2, -1/2] + 2*Log[2]*Log[3]*PolyLog[2, -1/2] - 
    (Log[3]^2*PolyLog[2, -1/2])/2 - PolyLog[2, -1/2]^2/2 - 
    2*Log[2]*PolyLog[3, 1/3] + Log[3]*PolyLog[3, 1/3] + 
    (7*Log[2]*Zeta[3])/4 - (7*Log[3]*Zeta[3])/8
 
G[-1, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (7*Pi^4)/720 + (Pi^2*Log[2]^2)/6 - Log[2]^4/6 - 
    (Pi^2*Log[2]*Log[3])/6 + (Pi^2*Log[3]^2)/12 - (Log[2]^2*Log[3]^2)/4 + 
    (Log[2]*Log[3]^3)/3 - Log[3]^4/8 + (Log[2]^2*PolyLog[2, -1/2])/2 - 
    (Log[3]^2*PolyLog[2, -1/2])/2 + PolyLog[2, -1/2]^2/2 + 
    Log[3]*PolyLog[3, 1/3] - 3*PolyLog[4, -1/2] + PolyLog[4, 1/3] - 
    4*PolyLog[4, 1/2] - PolyLog[4, 2/3] + (Log[2]*Zeta[3])/4 - Log[3]*Zeta[3]
 
G[-1, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[2]^4/12 + (Log[2]^3*Log[3])/3 - 
    (Log[2]^2*Log[3]^2)/2 + (Log[2]*Log[3]^3)/3 - Log[3]^4/12 - 
    (Log[2]^2*PolyLog[2, -1/2])/2 + Log[2]*Log[3]*PolyLog[2, -1/2] - 
    (Log[3]^2*PolyLog[2, -1/2])/2 - Log[2]*PolyLog[3, 1/3] + 
    Log[3]*PolyLog[3, 1/3] + PolyLog[4, 1/3] - PolyLog[4, 1/2]
 
G[0, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-13*Pi^4)/540 - (5*Pi^2*Log[2]^2)/9 + 
    (19*Log[2]^4)/18 + (2*Pi^2*Log[2]*Log[3])/3 - (8*Log[2]^3*Log[3])/3 - 
    (Pi^2*Log[3]^2)/6 + (7*Log[2]^2*Log[3]^2)/2 - (7*Log[2]*Log[3]^3)/3 + 
    (13*Log[3]^4)/24 + 4*Log[2]^2*PolyLog[2, -1/2] - 
    4*Log[2]*Log[3]*PolyLog[2, -1/2] + Log[3]^2*PolyLog[2, -1/2] + 
    8*Log[2]*PolyLog[3, -1/2] - 4*Log[3]*PolyLog[3, -1/2] + 
    4*Log[2]*PolyLog[3, 1/3] - 2*Log[3]*PolyLog[3, 1/3] + 
    4*PolyLog[4, -1/2] + 2*PolyLog[4, -1/3] - 2*PolyLog[4, 1/3] + 
    (16*PolyLog[4, 1/2])/3 + 4*PolyLog[4, 2/3] + (2*Log[2]*Zeta[3])/3 - 
    (Log[3]*Zeta[3])/3
 
G[0, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^4/72 - (Pi^2*Log[2]^2)/6 - Log[2]^4/2 + 
    (Pi^2*Log[2]*Log[3])/3 + (2*Log[2]^3*Log[3])/3 - (Pi^2*Log[3]^2)/12 + 
    (Log[2]^2*Log[3]^2)/2 - Log[2]*Log[3]^3 + (3*Log[3]^4)/8 - 
    (Pi^2*PolyLog[2, -1/2])/3 - 2*Log[2]^2*PolyLog[2, -1/2] + 
    Log[3]^2*PolyLog[2, -1/2] - 2*PolyLog[2, -1/2]^2 - 
    4*Log[3]*PolyLog[3, -1/2] - 2*Log[3]*PolyLog[3, 1/3] - 
    (4*Log[3]*Zeta[3])/3
 
G[0, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-13*Pi^4)/432 - (4*Pi^2*Log[2]^2)/9 + 
    (19*Log[2]^4)/36 + (7*Pi^2*Log[2]*Log[3])/12 - (3*Log[2]^3*Log[3])/2 - 
    (Pi^2*Log[3]^2)/8 + (9*Log[2]^2*Log[3]^2)/4 - (11*Log[2]*Log[3]^3)/6 + 
    Log[3]^4/2 - (Pi^2*PolyLog[2, -1/2])/6 + 2*Log[2]^2*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] + Log[3]^2*PolyLog[2, -1/2] - 
    PolyLog[2, -1/2]^2 + 4*Log[2]*PolyLog[3, -1/2] - 
    4*Log[3]*PolyLog[3, -1/2] + 2*Log[2]*PolyLog[3, 1/3] - 
    2*Log[3]*PolyLog[3, 1/3] - 2*PolyLog[4, -1/2] + 2*PolyLog[4, -1/3] - 
    2*PolyLog[4, 1/3] + (2*PolyLog[4, 1/2])/3 + 3*PolyLog[4, 2/3] + 
    (29*Log[2]*Zeta[3])/24 - (29*Log[3]*Zeta[3])/24
 
G[0, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-37*Pi^4)/1080 - (5*Pi^2*Log[2]^2)/18 - 
    Log[2]^4/18 + Pi^2*Log[2]*Log[3] - 2*Log[2]^3*Log[3] - 
    (5*Pi^2*Log[3]^2)/12 + (9*Log[2]^2*Log[3]^2)/2 - (11*Log[2]*Log[3]^3)/3 + 
    (23*Log[3]^4)/24 + (Pi^2*PolyLog[2, -1/2])/3 + 
    2*Log[2]^2*PolyLog[2, -1/2] - 4*Log[2]*Log[3]*PolyLog[2, -1/2] + 
    Log[3]^2*PolyLog[2, -1/2] + 2*PolyLog[2, -1/2]^2 + 
    8*Log[2]*PolyLog[3, 1/3] - 4*Log[3]*PolyLog[3, 1/3] - 
    8*PolyLog[4, -1/2] + 2*PolyLog[4, -1/3] - 4*PolyLog[4, 1/3] - 
    (16*PolyLog[4, 1/2])/3 + 8*PolyLog[4, 2/3] - (38*Log[2]*Zeta[3])/3 + 
    (19*Log[3]*Zeta[3])/3
 
G[0, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[3]^2)/4 + (Log[2]^2*Log[3]^2)/2 - 
    Log[2]*Log[3]^3 + (7*Log[3]^4)/12 + Log[3]^2*PolyLog[2, -1/2] - 
    4*Log[3]*PolyLog[3, 1/3] - 3*PolyLog[4, -1/3] + (13*Log[3]*Zeta[3])/3
 
G[0, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-203*Pi^4)/4320 - (7*Pi^2*Log[2]^2)/18 + 
    (5*Log[2]^4)/36 + (2*Pi^2*Log[2]*Log[3])/3 - Log[2]^3*Log[3] - 
    (13*Pi^2*Log[3]^2)/48 + (5*Log[2]^2*Log[3]^2)/2 - (7*Log[2]*Log[3]^3)/3 + 
    (23*Log[3]^4)/32 + Log[2]^2*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] + Log[3]^2*PolyLog[2, -1/2] + 
    PolyLog[2, -1/2]^2 + 4*Log[2]*PolyLog[3, 1/3] - 
    4*Log[3]*PolyLog[3, 1/3] - 4*PolyLog[4, -1/2] + (3*PolyLog[4, -1/3])/4 - 
    (9*PolyLog[4, 1/3])/2 + (4*PolyLog[4, 1/2])/3 + 4*PolyLog[4, 2/3] - 
    (17*Log[2]*Zeta[3])/6 + (17*Log[3]*Zeta[3])/6
 
G[0, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-7*Pi^4)/432 - (5*Pi^2*Log[2]^2)/72 + 
    (19*Log[2]^4)/36 + (Pi^2*Log[2]*Log[3])/2 - (5*Log[2]^3*Log[3])/2 - 
    (11*Pi^2*Log[3]^2)/48 + (15*Log[2]^2*Log[3]^2)/4 - 
    (5*Log[2]*Log[3]^3)/2 + (19*Log[3]^4)/32 + (Pi^2*PolyLog[2, -1/2])/6 + 
    2*Log[2]^2*PolyLog[2, -1/2] - 4*Log[2]*Log[3]*PolyLog[2, -1/2] + 
    Log[3]^2*PolyLog[2, -1/2] + PolyLog[2, -1/2]^2 + 
    2*Log[2]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, -1/2] + 
    6*Log[2]*PolyLog[3, 1/3] - 3*Log[3]*PolyLog[3, 1/3] + PolyLog[4, -1/2] - 
    PolyLog[4, -1/3]/4 - (3*PolyLog[4, 1/3])/2 + (5*PolyLog[4, 1/2])/3 + 
    3*PolyLog[4, 2/3] - (79*Log[2]*Zeta[3])/12 + (79*Log[3]*Zeta[3])/24
 
G[0, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (-19*Pi^4)/4320 + (Pi^2*Log[2]^2)/18 - Log[2]^4/18 - 
    (Pi^2*Log[2]*Log[3])/6 + (Log[2]^3*Log[3])/6 - (5*Pi^2*Log[3]^2)/48 + 
    (Log[2]^2*Log[3]^2)/2 - (2*Log[2]*Log[3]^3)/3 + (37*Log[3]^4)/96 - 
    Log[2]^2*PolyLog[2, -1/2] + Log[3]^2*PolyLog[2, -1/2] - 
    PolyLog[2, -1/2]^2 - Log[3]*PolyLog[3, -1/2] - 3*Log[3]*PolyLog[3, 1/3] + 
    2*PolyLog[4, -1/2] - (13*PolyLog[4, -1/3])/4 + (3*PolyLog[4, 1/3])/2 + 
    (8*PolyLog[4, 1/2])/3 - 2*PolyLog[4, 2/3] + (55*Log[3]*Zeta[3])/24
 
G[0, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-23*Pi^4)/1440 - (Pi^2*Log[2]^2)/8 + 
    (11*Log[2]^4)/24 + (Pi^2*Log[2]*Log[3])/4 - (3*Log[2]^3*Log[3])/2 - 
    (5*Pi^2*Log[3]^2)/48 + (9*Log[2]^2*Log[3]^2)/4 - (5*Log[2]*Log[3]^3)/3 + 
    (15*Log[3]^4)/32 + Log[2]^2*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] + Log[3]^2*PolyLog[2, -1/2] + 
    Log[2]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, -1/2] + 
    3*Log[2]*PolyLog[3, 1/3] - 3*Log[3]*PolyLog[3, 1/3] - 
    PolyLog[4, -1/3]/4 - (5*PolyLog[4, 1/3])/2 + 3*PolyLog[4, 1/2] + 
    PolyLog[4, 2/3] - (2*Log[2]*Zeta[3])/3 + (2*Log[3]*Zeta[3])/3
 
G[0, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (13*Pi^4)/540 + (2*Pi^2*Log[2]^2)/9 + 
    (5*Log[2]^4)/18 - (2*Pi^2*Log[2]*Log[3])/3 + (Pi^2*Log[3]^2)/4 - 
    Log[2]^2*Log[3]^2 + (4*Log[2]*Log[3]^3)/3 - (5*Log[3]^4)/12 - 
    4*Log[2]*PolyLog[3, 1/3] + 2*Log[3]*PolyLog[3, 1/3] + 
    4*PolyLog[4, -1/2] - PolyLog[4, -1/3] + 2*PolyLog[4, 1/3] + 
    (8*PolyLog[4, 1/2])/3 - 4*PolyLog[4, 2/3] + (19*Log[2]*Zeta[3])/3 - 
    (19*Log[3]*Zeta[3])/6
 
G[0, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[3]^2)/6 - Log[3]^4/6 + 
    2*Log[3]*PolyLog[3, 1/3] + 3*PolyLog[4, -1/3] - (13*Log[3]*Zeta[3])/6
 
G[0, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (37*Pi^4)/1440 + (Pi^2*Log[2]^2)/6 - Log[2]^4/24 - 
    (Pi^2*Log[2]*Log[3])/3 + (7*Pi^2*Log[3]^2)/48 - (Log[2]^2*Log[3]^2)/4 + 
    (Log[2]*Log[3]^3)/2 - (7*Log[3]^4)/32 - 2*Log[2]*PolyLog[3, 1/3] + 
    2*Log[3]*PolyLog[3, 1/3] + PolyLog[4, -1/2] + (5*PolyLog[4, -1/3])/4 + 
    (3*PolyLog[4, 1/3])/2 - 2*PolyLog[4, 1/2] - PolyLog[4, 2/3] + 
    (17*Log[2]*Zeta[3])/12 - (17*Log[3]*Zeta[3])/12
 
G[0, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -PolyLog[4, -1/3]
 
G[0, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := Log[3]^4/24
 
G[0, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -PolyLog[4, 1/3]
 
G[0, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (71*Pi^4)/2160 + (13*Pi^2*Log[2]^2)/36 + 
    Log[2]^4/72 - (Pi^2*Log[2]*Log[3])/3 + (Pi^2*Log[3]^2)/24 - 
    (3*Log[2]^2*Log[3]^2)/4 + (5*Log[2]*Log[3]^3)/6 - (5*Log[3]^4)/24 - 
    2*Log[2]*PolyLog[3, 1/3] + Log[3]*PolyLog[3, 1/3] + 3*PolyLog[4, -1/2] - 
    3*PolyLog[4, -1/3] + 4*PolyLog[4, 1/3] - (8*PolyLog[4, 1/2])/3 - 
    3*PolyLog[4, 2/3] - (3*Log[2]*Zeta[3])/2 + (3*Log[3]*Zeta[3])/4
 
G[0, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := Log[3]*PolyLog[3, 1/3] + 3*PolyLog[4, 1/3]
 
G[0, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := Pi^4/90 + (Pi^2*Log[2]^2)/12 + Log[2]^4/24 - 
    (Pi^2*Log[2]*Log[3])/6 + (Pi^2*Log[3]^2)/12 - (Log[2]^2*Log[3]^2)/4 + 
    (Log[2]*Log[3]^3)/3 - Log[3]^4/8 - Log[2]*PolyLog[3, 1/3] + 
    Log[3]*PolyLog[3, 1/3] + PolyLog[4, -1/2] + PolyLog[4, 1/3] - 
    PolyLog[4, 2/3] + Log[2]*Zeta[3] - Log[3]*Zeta[3]
 
G[0, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-71*Pi^4)/2160 - (25*Pi^2*Log[2]^2)/36 + 
    (47*Log[2]^4)/72 + (Pi^2*Log[2]*Log[3])/4 - (2*Log[2]^3*Log[3])/3 + 
    (Pi^2*Log[3]^2)/12 + (5*Log[2]^2*Log[3]^2)/4 - (5*Log[2]*Log[3]^3)/6 + 
    Log[3]^4/8 + 2*Log[2]^2*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] + (Log[3]^2*PolyLog[2, -1/2])/2 + 
    6*Log[2]*PolyLog[3, -1/2] - 3*Log[3]*PolyLog[3, -1/2] + 
    5*PolyLog[4, -1/2] + 3*PolyLog[4, -1/3] - 3*PolyLog[4, 1/3] + 
    (32*PolyLog[4, 1/2])/3 + 2*PolyLog[4, 2/3] + (35*Log[2]*Zeta[3])/4 - 
    (35*Log[3]*Zeta[3])/8
 
G[0, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (19*Pi^4)/4320 - (5*Pi^2*Log[2]^2)/36 - 
    (4*Log[2]^4)/9 + (Pi^2*Log[2]*Log[3])/3 + (Log[2]^3*Log[3])/2 + 
    (Pi^2*Log[3]^2)/48 + (Log[2]^2*Log[3]^2)/4 - (5*Log[2]*Log[3]^3)/6 + 
    (19*Log[3]^4)/96 - (Pi^2*PolyLog[2, -1/2])/6 - 
    Log[2]^2*PolyLog[2, -1/2] + (Log[3]^2*PolyLog[2, -1/2])/2 - 
    PolyLog[2, -1/2]^2 - 3*Log[3]*PolyLog[3, -1/2] - 2*PolyLog[4, -1/2] + 
    (13*PolyLog[4, -1/3])/4 - (3*PolyLog[4, 1/3])/2 - (8*PolyLog[4, 1/2])/3 + 
    2*PolyLog[4, 2/3] - (11*Log[3]*Zeta[3])/4
 
G[0, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-17*Pi^4)/864 - (4*Pi^2*Log[2]^2)/9 + Log[2]^4/36 + 
    (5*Pi^2*Log[2]*Log[3])/12 - (Log[2]^3*Log[3])/6 - (Pi^2*Log[3]^2)/24 + 
    Log[2]^2*Log[3]^2 - Log[2]*Log[3]^3 + Log[3]^4/4 - 
    (Pi^2*PolyLog[2, -1/2])/12 + Log[2]^2*PolyLog[2, -1/2] - 
    Log[2]*Log[3]*PolyLog[2, -1/2] + (Log[3]^2*PolyLog[2, -1/2])/2 - 
    PolyLog[2, -1/2]^2/2 + 3*Log[2]*PolyLog[3, -1/2] - 
    3*Log[3]*PolyLog[3, -1/2] - 2*PolyLog[4, -1/2] + 3*PolyLog[4, -1/3] - 
    PolyLog[4, 1/3] - PolyLog[4, 1/2]/3 + 3*PolyLog[4, 2/3] + 
    (7*Log[2]*Zeta[3])/4 - (7*Log[3]*Zeta[3])/4
 
G[0, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-101*Pi^4)/1440 - (7*Pi^2*Log[2]^2)/12 + 
    (5*Log[2]^4)/12 + (Pi^2*Log[2]*Log[3])/2 - Log[2]^3*Log[3] - 
    (Pi^2*Log[3]^2)/48 + (9*Log[2]^2*Log[3]^2)/4 - (11*Log[2]*Log[3]^3)/6 + 
    (37*Log[3]^4)/96 + (Pi^2*PolyLog[2, -1/2])/6 + 
    Log[2]^2*PolyLog[2, -1/2] - 2*Log[2]*Log[3]*PolyLog[2, -1/2] + 
    (Log[3]^2*PolyLog[2, -1/2])/2 + PolyLog[2, -1/2]^2 + 
    4*Log[2]*PolyLog[3, 1/3] - 2*Log[3]*PolyLog[3, 1/3] - 
    4*PolyLog[4, -1/2] + (11*PolyLog[4, -1/3])/4 - (13*PolyLog[4, 1/3])/2 + 
    8*PolyLog[4, 1/2] + 4*PolyLog[4, 2/3] + 3*Log[2]*Zeta[3] - 
    (3*Log[3]*Zeta[3])/2
 
G[0, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (Log[2]^2*Log[3]^2)/4 - (Log[2]*Log[3]^3)/2 + 
    Log[3]^4/4 + (Log[3]^2*PolyLog[2, -1/2])/2 - 2*Log[3]*PolyLog[3, 1/3] - 
    3*PolyLog[4, 1/3]
 
G[0, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^4/45 - (Pi^2*Log[2]^2)/6 + Log[2]^4/24 + 
    (Pi^2*Log[2]*Log[3])/3 - (Log[2]^3*Log[3])/2 - (Pi^2*Log[3]^2)/6 + 
    (5*Log[2]^2*Log[3]^2)/4 - (7*Log[2]*Log[3]^3)/6 + (3*Log[3]^4)/8 + 
    (Log[2]^2*PolyLog[2, -1/2])/2 - Log[2]*Log[3]*PolyLog[2, -1/2] + 
    (Log[3]^2*PolyLog[2, -1/2])/2 + PolyLog[2, -1/2]^2/2 + 
    2*Log[2]*PolyLog[3, 1/3] - 2*Log[3]*PolyLog[3, 1/3] - 
    2*PolyLog[4, -1/2] - 2*PolyLog[4, 1/3] + 2*PolyLog[4, 2/3] - 
    2*Log[2]*Zeta[3] + 2*Log[3]*Zeta[3]
 
G[0, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-7*Pi^4)/720 - (Pi^2*Log[2]^2)/8 + Log[2]^4/3 + 
    (Pi^2*Log[2]*Log[3])/6 - Log[2]^3*Log[3] - (Pi^2*Log[3]^2)/24 + 
    (3*Log[2]^2*Log[3]^2)/2 - Log[2]*Log[3]^3 + (5*Log[3]^4)/24 + 
    (Pi^2*PolyLog[2, -1/2])/12 + Log[2]^2*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] + (Log[3]^2*PolyLog[2, -1/2])/2 + 
    PolyLog[2, -1/2]^2/2 + 2*Log[2]*PolyLog[3, -1/2] - 
    Log[3]*PolyLog[3, -1/2] + 2*Log[2]*PolyLog[3, 1/3] - 
    Log[3]*PolyLog[3, 1/3] + 3*PolyLog[4, -1/2] - PolyLog[4, 1/3] + 
    4*PolyLog[4, 1/2] + PolyLog[4, 2/3] - (Log[2]*Zeta[3])/4 + 
    (Log[3]*Zeta[3])/8
 
G[0, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[2]^4/8 + (Log[2]^3*Log[3])/6 + 
    (Log[2]^2*Log[3]^2)/4 - (Log[2]*Log[3]^3)/2 + (5*Log[3]^4)/24 - 
    (Log[2]^2*PolyLog[2, -1/2])/2 + (Log[3]^2*PolyLog[2, -1/2])/2 - 
    PolyLog[2, -1/2]^2/2 - Log[3]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, 1/3]
 
G[0, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^4/90 - (Pi^2*Log[2]^2)/12 + Log[2]^4/12 + 
    (Pi^2*Log[2]*Log[3])/6 - (Log[2]^3*Log[3])/2 - (Pi^2*Log[3]^2)/12 + 
    Log[2]^2*Log[3]^2 - (5*Log[2]*Log[3]^3)/6 + Log[3]^4/4 + 
    (Log[2]^2*PolyLog[2, -1/2])/2 - Log[2]*Log[3]*PolyLog[2, -1/2] + 
    (Log[3]^2*PolyLog[2, -1/2])/2 + Log[2]*PolyLog[3, -1/2] - 
    Log[3]*PolyLog[3, -1/2] + Log[2]*PolyLog[3, 1/3] - 
    Log[3]*PolyLog[3, 1/3] + PolyLog[4, 2/3] - Log[2]*Zeta[3] + Log[3]*Zeta[3]
 
G[1, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (2*Log[2]^4)/3 + (Pi^2*Log[2]*Log[3])/6 - 
    (13*Log[2]^3*Log[3])/6 - (Pi^2*Log[3]^2)/12 + (9*Log[2]^2*Log[3]^2)/4 - 
    (7*Log[2]*Log[3]^3)/6 + Log[3]^4/4 + 2*Log[2]^2*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] + (Log[3]^2*PolyLog[2, -1/2])/2 + 
    2*Log[2]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, -1/2] + 
    2*Log[2]*PolyLog[3, 1/3] - Log[3]*PolyLog[3, 1/3] - PolyLog[4, 1/2] + 
    PolyLog[4, 2/3] - 2*Log[2]*Zeta[3] + Log[3]*Zeta[3]
 
G[1, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (7*Pi^4)/432 + (7*Pi^2*Log[2]^2)/36 - 
    (7*Log[2]^4)/36 - (Pi^2*Log[2]*Log[3])/6 + (Log[2]^3*Log[3])/6 + 
    (Log[2]^2*Log[3]^2)/4 - (Log[2]*Log[3]^3)/6 + Log[3]^4/12 - 
    (Pi^2*PolyLog[2, -1/2])/6 - Log[2]^2*PolyLog[2, -1/2] + 
    (Log[3]^2*PolyLog[2, -1/2])/2 - PolyLog[2, -1/2]^2 - 
    Log[3]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, 1/3] + 2*PolyLog[4, -1/2] - 
    2*PolyLog[4, -1/3] + 2*PolyLog[4, 1/3] - (2*PolyLog[4, 1/2])/3 - 
    3*PolyLog[4, 2/3] + (Log[2]*Zeta[3])/8
 
G[1, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^4/288 + Log[2]^4/2 + (Pi^2*Log[2]*Log[3])/12 - 
    (3*Log[2]^3*Log[3])/2 - (Pi^2*Log[3]^2)/24 + (3*Log[2]^2*Log[3]^2)/2 - 
    (5*Log[2]*Log[3]^3)/6 + (5*Log[3]^4)/24 - (Pi^2*PolyLog[2, -1/2])/12 + 
    Log[2]^2*PolyLog[2, -1/2] - Log[2]*Log[3]*PolyLog[2, -1/2] + 
    (Log[3]^2*PolyLog[2, -1/2])/2 - PolyLog[2, -1/2]^2/2 + 
    Log[2]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, -1/2] + 
    Log[2]*PolyLog[3, 1/3] - Log[3]*PolyLog[3, 1/3] - (Log[2]*Zeta[3])/8 + 
    (Log[3]*Zeta[3])/8
 
G[1, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^4/16 - (17*Pi^2*Log[2]^2)/24 - Log[2]^4/12 + 
    (7*Pi^2*Log[2]*Log[3])/6 - (5*Log[2]^3*Log[3])/6 - 
    (17*Pi^2*Log[3]^2)/48 + (13*Log[2]^2*Log[3]^2)/4 - 
    (19*Log[2]*Log[3]^3)/6 + (27*Log[3]^4)/32 + (Pi^2*PolyLog[2, -1/2])/6 + 
    Log[2]^2*PolyLog[2, -1/2] - 2*Log[2]*Log[3]*PolyLog[2, -1/2] + 
    (Log[3]^2*PolyLog[2, -1/2])/2 + PolyLog[2, -1/2]^2 + 
    2*Log[2]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, -1/2] + 
    6*Log[2]*PolyLog[3, 1/3] - 3*Log[3]*PolyLog[3, 1/3] - 
    3*PolyLog[4, -1/2] + (15*PolyLog[4, -1/3])/4 - (11*PolyLog[4, 1/3])/2 + 
    3*PolyLog[4, 1/2] + 9*PolyLog[4, 2/3] - (41*Log[2]*Zeta[3])/6 + 
    (85*Log[3]*Zeta[3])/24
 
G[1, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (-37*Pi^4)/1440 - (Pi^2*Log[2]^2)/6 + Log[2]^4/24 + 
    (Pi^2*Log[2]*Log[3])/6 + (Log[2]^3*Log[3])/6 - (3*Pi^2*Log[3]^2)/16 + 
    (Log[2]^2*Log[3]^2)/4 - (5*Log[2]*Log[3]^3)/6 + (15*Log[3]^4)/32 + 
    (Log[3]^2*PolyLog[2, -1/2])/2 - Log[3]*PolyLog[3, -1/2] - 
    3*Log[3]*PolyLog[3, 1/3] - PolyLog[4, -1/2] - (5*PolyLog[4, -1/3])/4 - 
    (3*PolyLog[4, 1/3])/2 + 2*PolyLog[4, 1/2] + PolyLog[4, 2/3] + 
    (3*Log[2]*Zeta[3])/4 + (37*Log[3]*Zeta[3])/24
 
G[1, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-223*Pi^4)/4320 - (47*Pi^2*Log[2]^2)/72 + 
    Log[2]^4/9 + (5*Pi^2*Log[2]*Log[3])/6 - (Log[2]^3*Log[3])/3 - 
    (5*Pi^2*Log[3]^2)/24 + (7*Log[2]^2*Log[3]^2)/4 - 2*Log[2]*Log[3]^3 + 
    (29*Log[3]^4)/48 + (Log[2]^2*PolyLog[2, -1/2])/2 - 
    Log[2]*Log[3]*PolyLog[2, -1/2] + (Log[3]^2*PolyLog[2, -1/2])/2 + 
    PolyLog[2, -1/2]^2/2 + Log[2]*PolyLog[3, -1/2] - 
    Log[3]*PolyLog[3, -1/2] + 3*Log[2]*PolyLog[3, 1/3] - 
    3*Log[3]*PolyLog[3, 1/3] - 2*PolyLog[4, -1/2] + (5*PolyLog[4, -1/3])/2 - 
    6*PolyLog[4, 1/3] + (17*PolyLog[4, 1/2])/3 + 5*PolyLog[4, 2/3] - 
    (Log[2]*Zeta[3])/24 + (Log[3]*Zeta[3])/24
 
G[1, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-23*Pi^4)/1440 - (Pi^2*Log[2]^2)/12 + Log[2]^4/3 + 
    (Pi^2*Log[2]*Log[3])/3 - (5*Log[2]^3*Log[3])/3 - (Pi^2*Log[3]^2)/8 + 
    (5*Log[2]^2*Log[3]^2)/2 - (5*Log[2]*Log[3]^3)/3 + (3*Log[3]^4)/8 + 
    (Pi^2*PolyLog[2, -1/2])/12 + Log[2]^2*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] + (Log[3]^2*PolyLog[2, -1/2])/2 + 
    PolyLog[2, -1/2]^2/2 + 4*Log[2]*PolyLog[3, 1/3] - 
    2*Log[3]*PolyLog[3, 1/3] - 2*PolyLog[4, -1/2] - 2*PolyLog[4, 1/3] + 
    2*PolyLog[4, 2/3] - (15*Log[2]*Zeta[3])/4 + (7*Log[3]*Zeta[3])/4
 
G[1, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (17*Pi^4)/864 + (17*Pi^2*Log[2]^2)/72 - 
    Log[2]^4/36 - (Pi^2*Log[2]*Log[3])/3 + (Log[2]^2*Log[3]^2)/4 - 
    (Log[2]*Log[3]^3)/6 + Log[3]^4/6 - (Log[2]^2*PolyLog[2, -1/2])/2 + 
    (Log[3]^2*PolyLog[2, -1/2])/2 - PolyLog[2, -1/2]^2/2 - 
    2*Log[3]*PolyLog[3, 1/3] + 2*PolyLog[4, -1/2] - 3*PolyLog[4, -1/3] + 
    PolyLog[4, 1/3] + PolyLog[4, 1/2]/3 - 3*PolyLog[4, 2/3] + 
    Log[2]*Zeta[3] + (3*Log[3]*Zeta[3])/4
 
G[1, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2]^2)/12 + (5*Log[2]^4)/12 + 
    (Pi^2*Log[2]*Log[3])/12 - (7*Log[2]^3*Log[3])/6 + 
    (3*Log[2]^2*Log[3]^2)/2 - Log[2]*Log[3]^3 + Log[3]^4/4 + 
    (Log[2]^2*PolyLog[2, -1/2])/2 - Log[2]*Log[3]*PolyLog[2, -1/2] + 
    (Log[3]^2*PolyLog[2, -1/2])/2 + 2*Log[2]*PolyLog[3, 1/3] - 
    2*Log[3]*PolyLog[3, 1/3] - 3*PolyLog[4, 1/3] + 3*PolyLog[4, 1/2] + 
    (7*Log[2]*Zeta[3])/8 - (7*Log[3]*Zeta[3])/8
 
G[1, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (19*Pi^4)/240 + (29*Pi^2*Log[2]^2)/24 - 
    (3*Log[2]^4)/8 - (4*Pi^2*Log[2]*Log[3])/3 + (Log[2]^3*Log[3])/3 + 
    (13*Pi^2*Log[3]^2)/48 - (9*Log[2]^2*Log[3]^2)/4 + (8*Log[2]*Log[3]^3)/3 - 
    (23*Log[3]^4)/32 - 2*Log[2]^2*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] - (Log[3]^2*PolyLog[2, -1/2])/2 - 
    8*Log[2]*PolyLog[3, -1/2] + 4*Log[3]*PolyLog[3, -1/2] - 
    6*Log[2]*PolyLog[3, 1/3] + 3*Log[3]*PolyLog[3, 1/3] - 
    4*PolyLog[4, -1/2] - (19*PolyLog[4, -1/3])/4 + (13*PolyLog[4, 1/3])/2 - 
    13*PolyLog[4, 1/2] - 8*PolyLog[4, 2/3] - (49*Log[2]*Zeta[3])/24 + 
    (23*Log[3]*Zeta[3])/24
 
G[1, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (203*Pi^4)/4320 + (17*Pi^2*Log[2]^2)/36 + 
    (13*Log[2]^4)/36 - (2*Pi^2*Log[2]*Log[3])/3 - (2*Log[2]^3*Log[3])/3 + 
    (3*Pi^2*Log[3]^2)/16 - (Log[2]^2*Log[3]^2)/4 + Log[2]*Log[3]^3 - 
    (15*Log[3]^4)/32 + (Pi^2*PolyLog[2, -1/2])/6 + 
    Log[2]^2*PolyLog[2, -1/2] - (Log[3]^2*PolyLog[2, -1/2])/2 + 
    PolyLog[2, -1/2]^2 + 4*Log[3]*PolyLog[3, -1/2] + 
    3*Log[3]*PolyLog[3, 1/3] + 4*PolyLog[4, -1/2] - (3*PolyLog[4, -1/3])/4 + 
    (9*PolyLog[4, 1/3])/2 - (4*PolyLog[4, 1/2])/3 - 4*PolyLog[4, 2/3] - 
    (3*Log[2]*Zeta[3])/2 + (47*Log[3]*Zeta[3])/24
 
G[1, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (223*Pi^4)/4320 + (31*Pi^2*Log[2]^2)/36 - 
    Log[2]^4/9 - Pi^2*Log[2]*Log[3] - (Log[2]^3*Log[3])/6 + 
    (Pi^2*Log[3]^2)/6 - Log[2]^2*Log[3]^2 + (5*Log[2]*Log[3]^3)/3 - 
    (25*Log[3]^4)/48 + (Pi^2*PolyLog[2, -1/2])/12 - 
    Log[2]^2*PolyLog[2, -1/2] + Log[2]*Log[3]*PolyLog[2, -1/2] - 
    (Log[3]^2*PolyLog[2, -1/2])/2 + PolyLog[2, -1/2]^2/2 - 
    4*Log[2]*PolyLog[3, -1/2] + 4*Log[3]*PolyLog[3, -1/2] - 
    3*Log[2]*PolyLog[3, 1/3] + 3*Log[3]*PolyLog[3, 1/3] + 
    2*PolyLog[4, -1/2] - (5*PolyLog[4, -1/3])/2 + 6*PolyLog[4, 1/3] - 
    (17*PolyLog[4, 1/2])/3 - 5*PolyLog[4, 2/3] - (65*Log[2]*Zeta[3])/24 + 
    (65*Log[3]*Zeta[3])/24
 
G[1, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (5*Pi^4)/432 + (Pi^2*Log[2]^2)/18 - 
    (7*Log[2]^4)/18 + Log[2]^3*Log[3] - (5*Log[2]^2*Log[3]^2)/4 + 
    (2*Log[2]*Log[3]^3)/3 - Log[3]^4/8 - (Pi^2*PolyLog[2, -1/2])/6 - 
    Log[2]^2*PolyLog[2, -1/2] + 2*Log[2]*Log[3]*PolyLog[2, -1/2] - 
    (Log[3]^2*PolyLog[2, -1/2])/2 - PolyLog[2, -1/2]^2 - 
    2*Log[2]*PolyLog[3, 1/3] + Log[3]*PolyLog[3, 1/3] - PolyLog[4, -1/3] + 
    PolyLog[4, 1/3] - (10*PolyLog[4, 1/2])/3 - (3*Log[2]*Zeta[3])/4
 
G[1, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -(Log[2]^2*Log[3]^2)/4 + (Log[2]*Log[3]^3)/3 - 
    Log[3]^4/12 - (Log[3]^2*PolyLog[2, -1/2])/2 + Log[3]*PolyLog[3, 1/3] + 
    PolyLog[4, 1/3]
 
G[1, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[2]^4/8 + (Log[2]^3*Log[3])/2 - 
    (3*Log[2]^2*Log[3]^2)/4 + (Log[2]*Log[3]^3)/2 - Log[3]^4/8 - 
    (Log[2]^2*PolyLog[2, -1/2])/2 + Log[2]*Log[3]*PolyLog[2, -1/2] - 
    (Log[3]^2*PolyLog[2, -1/2])/2 - PolyLog[2, -1/2]^2/2 - 
    Log[2]*PolyLog[3, 1/3] + Log[3]*PolyLog[3, 1/3]
 
G[1, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (169*Pi^4)/4320 + (19*Pi^2*Log[2]^2)/36 - 
    (7*Log[2]^4)/36 - (2*Pi^2*Log[2]*Log[3])/3 + (2*Log[2]^3*Log[3])/3 + 
    (5*Pi^2*Log[3]^2)/24 - 2*Log[2]^2*Log[3]^2 + (11*Log[2]*Log[3]^3)/6 - 
    Log[3]^4/2 - (Pi^2*PolyLog[2, -1/2])/12 - Log[2]^2*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[2, -1/2] - (Log[3]^2*PolyLog[2, -1/2])/2 - 
    PolyLog[2, -1/2]^2/2 - 4*Log[2]*PolyLog[3, -1/2] + 
    2*Log[3]*PolyLog[3, -1/2] - 4*Log[2]*PolyLog[3, 1/3] + 
    2*Log[3]*PolyLog[3, 1/3] - 4*PolyLog[4, -1/2] - 3*PolyLog[4, -1/3] + 
    3*PolyLog[4, 1/3] - (23*PolyLog[4, 1/2])/3 - 5*PolyLog[4, 2/3] + 
    (3*Log[2]*Zeta[3])/2 - (5*Log[3]*Zeta[3])/4
 
G[1, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := Pi^4/45 + (Pi^2*Log[2]^2)/6 + (5*Log[2]^4)/24 - 
    (Pi^2*Log[2]*Log[3])/3 - (Log[2]^3*Log[3])/3 + (Pi^2*Log[3]^2)/6 - 
    (Log[2]^2*Log[3]^2)/4 + (2*Log[2]*Log[3]^3)/3 - (7*Log[3]^4)/24 + 
    (Log[2]^2*PolyLog[2, -1/2])/2 - (Log[3]^2*PolyLog[2, -1/2])/2 + 
    PolyLog[2, -1/2]^2/2 + 2*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]*PolyLog[3, 1/3] + 2*PolyLog[4, -1/2] + 2*PolyLog[4, 1/3] - 
    2*PolyLog[4, 2/3] + 2*Log[2]*Zeta[3] - 2*Log[3]*Zeta[3]
 
G[1, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := Pi^4/30 + (Pi^2*Log[2]^2)/4 + Log[2]^4/12 - 
    (Pi^2*Log[2]*Log[3])/2 + (Log[2]^3*Log[3])/6 + (Pi^2*Log[3]^2)/4 - 
    Log[2]^2*Log[3]^2 + (7*Log[2]*Log[3]^3)/6 - (5*Log[3]^4)/12 - 
    (Log[2]^2*PolyLog[2, -1/2])/2 + Log[2]*Log[3]*PolyLog[2, -1/2] - 
    (Log[3]^2*PolyLog[2, -1/2])/2 - 2*Log[2]*PolyLog[3, -1/2] + 
    2*Log[3]*PolyLog[3, -1/2] - 2*Log[2]*PolyLog[3, 1/3] + 
    2*Log[3]*PolyLog[3, 1/3] - 3*PolyLog[4, 2/3] + 3*Log[2]*Zeta[3] - 
    3*Log[3]*Zeta[3]
 
G[1, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (7*Pi^4)/720 + (Pi^2*Log[2]^2)/12 + Log[2]^4/12 - 
    (Pi^2*Log[2]*Log[3])/4 - (Log[2]^3*Log[3])/6 + (Pi^2*Log[3]^2)/12 + 
    (Log[2]*Log[3]^3)/3 - Log[3]^4/8 - 2*Log[2]*PolyLog[3, 1/3] + 
    Log[3]*PolyLog[3, 1/3] + PolyLog[4, -1/2] + PolyLog[4, 1/3] - 
    PolyLog[4, 2/3] + (15*Log[2]*Zeta[3])/8 - (7*Log[3]*Zeta[3])/8
 
G[1, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (23*Pi^4)/1440 + (5*Pi^2*Log[2]^2)/24 - Log[2]^4/8 - 
    (Pi^2*Log[2]*Log[3])/6 + (Pi^2*Log[3]^2)/48 - (5*Log[3]^4)/96 + 
    Log[3]*PolyLog[3, 1/3] + PolyLog[4, -1/3]/4 + (5*PolyLog[4, 1/3])/2 - 
    3*PolyLog[4, 1/2] - PolyLog[4, 2/3] - (13*Log[2]*Zeta[3])/8 + 
    (3*Log[3]*Zeta[3])/4
 
G[1, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[2]^2)/8 - Log[2]^4/12 - 
    (Pi^2*Log[2]*Log[3])/12 - (Log[2]^3*Log[3])/6 - (Pi^2*Log[3]^2)/24 + 
    (Log[2]^2*Log[3]^2)/4 - Log[2]*PolyLog[3, 1/3] + Log[3]*PolyLog[3, 1/3] + 
    3*PolyLog[4, 1/3] - 3*PolyLog[4, 1/2] - (7*Log[2]*Zeta[3])/4 + 
    (7*Log[3]*Zeta[3])/4
 
G[1, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-49*Pi^4)/1080 - (11*Pi^2*Log[2]^2)/18 - 
    Log[2]^4/72 + (2*Pi^2*Log[2]*Log[3])/3 + (Log[2]^3*Log[3])/6 - 
    (5*Pi^2*Log[3]^2)/48 + Log[2]^2*Log[3]^2 - (4*Log[2]*Log[3]^3)/3 + 
    (11*Log[3]^4)/32 + 2*Log[2]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, -1/2] + 
    2*Log[2]*PolyLog[3, 1/3] - Log[3]*PolyLog[3, 1/3] + PolyLog[4, -1/2] + 
    (11*PolyLog[4, -1/3])/4 - (9*PolyLog[4, 1/3])/2 + 
    (20*PolyLog[4, 1/2])/3 + 5*PolyLog[4, 2/3] + (3*Log[2]*Zeta[3])/8 - 
    (Log[3]*Zeta[3])/2
 
G[1, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^4/90 - (Pi^2*Log[2]^2)/12 - Log[2]^4/24 + 
    (Pi^2*Log[2]*Log[3])/6 + (Log[2]^3*Log[3])/6 - (Pi^2*Log[3]^2)/12 - 
    (Log[2]*Log[3]^3)/3 + (5*Log[3]^4)/24 - Log[3]*PolyLog[3, -1/2] - 
    Log[3]*PolyLog[3, 1/3] - PolyLog[4, -1/2] - PolyLog[4, 1/3] + 
    PolyLog[4, 2/3] - Log[2]*Zeta[3] + Log[3]*Zeta[3]
 
G[1, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -Pi^4/30 - (Pi^2*Log[2]^2)/4 - Log[2]^4/6 + 
    (Pi^2*Log[2]*Log[3])/2 + (Log[2]^3*Log[3])/6 - (Pi^2*Log[3]^2)/4 + 
    (Log[2]^2*Log[3]^2)/2 - (5*Log[2]*Log[3]^3)/6 + Log[3]^4/3 + 
    Log[2]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, -1/2] + 
    Log[2]*PolyLog[3, 1/3] - Log[3]*PolyLog[3, 1/3] + 3*PolyLog[4, 2/3] - 
    3*Log[2]*Zeta[3] + 3*Log[3]*Zeta[3]
 
G[1, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2]^2)/24 + Log[2]^4/12 - 
    (Log[2]^3*Log[3])/6 + (Pi^2*Log[3]^2)/24 + (Log[2]^2*Log[3]^2)/4 - 
    (Log[2]*Log[3]^3)/6 - PolyLog[4, 1/3] + PolyLog[4, 1/2] + 
    (7*Log[2]*Zeta[3])/8 - (7*Log[3]*Zeta[3])/8
 
G[1, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := Pi^4/90 + (Pi^2*Log[2]^2)/12 - 
    (Pi^2*Log[2]*Log[3])/6 + (Pi^2*Log[3]^2)/12 - PolyLog[4, 2/3] + 
    Log[2]*Zeta[3] - Log[3]*Zeta[3]
 
G[1, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := Log[2]^4/24 - (Log[2]^3*Log[3])/6 + 
    (Log[2]^2*Log[3]^2)/4 - (Log[2]*Log[3]^3)/6 + Log[3]^4/24
 
G[-1, -1, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (4*Log[2]^5)/15 - (2*Log[2]^4*Log[3])/3 + 
    (2*Log[2]^3*Log[3]^2)/3 - (Log[2]^2*Log[3]^3)/3 + (Log[2]*Log[3]^4)/12 - 
    Log[3]^5/120
 
G[-1, -1, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (13*Pi^4*Log[2])/270 + (14*Pi^2*Log[2]^3)/27 + 
    (3*Log[2]^5)/5 - (11*Pi^4*Log[3])/540 - (13*Pi^2*Log[2]^2*Log[3])/9 - 
    (7*Log[2]^4*Log[3])/18 + (5*Pi^2*Log[2]*Log[3]^2)/6 - 
    2*Log[2]^3*Log[3]^2 - (5*Pi^2*Log[3]^3)/36 + (10*Log[2]^2*Log[3]^3)/3 - 
    (19*Log[2]*Log[3]^4)/12 + (5*Log[3]^5)/24 - 6*Log[2]^2*PolyLog[3, 1/3] + 
    4*Log[2]*Log[3]*PolyLog[3, 1/3] + 12*Log[2]*PolyLog[4, -1/2] - 
    4*Log[3]*PolyLog[4, -1/2] - 4*Log[2]*PolyLog[4, -1/3] + 
    2*Log[3]*PolyLog[4, -1/3] + 4*Log[2]*PolyLog[4, 1/3] + 
    (32*Log[2]*PolyLog[4, 1/2])/3 - (16*Log[3]*PolyLog[4, 1/2])/3 - 
    12*Log[2]*PolyLog[4, 2/3] + 4*Log[3]*PolyLog[4, 2/3] + 
    20*PolyLog[5, -1/2] + 4*PolyLog[5, -1/3] - 2*PolyLog[5, 1/3] + 
    (64*PolyLog[5, 1/2])/3 + 4*PolyLog[5, 2/3] + 2*PolyLog[2, 3, -1/3] - 
    4*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/3 + (38*Log[2]^2*Zeta[3])/3 - 
    (32*Log[2]*Log[3]*Zeta[3])/3 + (8*Log[3]^2*Zeta[3])/3 + 3*Zeta[5]
 
G[-1, -1, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2]^3)/18 + Log[2]^5/3 - 
    (2*Log[2]^4*Log[3])/3 + (Pi^2*Log[2]*Log[3]^2)/24 + 
    (7*Log[2]^3*Log[3]^2)/12 - (Pi^2*Log[3]^3)/72 - (Log[2]^2*Log[3]^3)/4 + 
    (Log[2]*Log[3]^4)/24 + 2*Log[2]*PolyLog[4, 1/2] - 
    Log[3]*PolyLog[4, 1/2] + PolyLog[5, 1/2] - PolyLog[5, 2/3] + 
    (7*Log[2]^2*Zeta[3])/4 - (7*Log[2]*Log[3]*Zeta[3])/4 + 
    (7*Log[3]^2*Zeta[3])/16
 
G[-1, -1, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-13*Pi^4*Log[2])/90 - (44*Pi^2*Log[2]^3)/27 - 
    (143*Log[2]^5)/45 + (31*Pi^4*Log[3])/540 + (44*Pi^2*Log[2]^2*Log[3])/9 + 
    (35*Log[2]^4*Log[3])/18 - (17*Pi^2*Log[2]*Log[3]^2)/6 + 
    8*Log[2]^3*Log[3]^2 + (17*Pi^2*Log[3]^3)/36 - (38*Log[2]^2*Log[3]^3)/3 + 
    (23*Log[2]*Log[3]^4)/4 - (17*Log[3]^5)/24 + 24*Log[2]^2*PolyLog[3, 1/3] - 
    16*Log[2]*Log[3]*PolyLog[3, 1/3] - 56*Log[2]*PolyLog[4, -1/2] + 
    20*Log[3]*PolyLog[4, -1/2] + 12*Log[2]*PolyLog[4, -1/3] - 
    6*Log[3]*PolyLog[4, -1/3] - 12*Log[2]*PolyLog[4, 1/3] - 
    2*Log[3]*PolyLog[4, 1/3] - (160*Log[2]*PolyLog[4, 1/2])/3 + 
    (80*Log[3]*PolyLog[4, 1/2])/3 + 40*Log[2]*PolyLog[4, 2/3] - 
    12*Log[3]*PolyLog[4, 2/3] - 80*PolyLog[5, -1/2] - 16*PolyLog[5, -1/3] + 
    8*PolyLog[5, 1/3] - (256*PolyLog[5, 1/2])/3 - 16*PolyLog[5, 2/3] - 
    8*PolyLog[2, 3, -1/3] + 16*PolyLog[2, 3, 1/3] + (4*Pi^2*Zeta[3])/3 - 
    (140*Log[2]^2*Zeta[3])/3 + (116*Log[2]*Log[3]*Zeta[3])/3 - 
    (29*Log[3]^2*Zeta[3])/3 - 12*Zeta[5]
 
G[-1, -1, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (-13*Pi^4*Log[2])/270 - (4*Pi^2*Log[2]^3)/9 - 
    (5*Log[2]^5)/9 + Pi^2*Log[2]^2*Log[3] + (2*Log[2]^4*Log[3])/3 - 
    (Pi^2*Log[2]*Log[3]^2)/2 + (4*Log[2]^3*Log[3]^2)/3 + (Pi^2*Log[3]^3)/12 - 
    (7*Log[2]^2*Log[3]^3)/3 + Log[2]*Log[3]^4 - Log[3]^5/8 + 
    4*Log[2]^2*PolyLog[3, 1/3] - 4*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    Log[3]^2*PolyLog[3, 1/3] - 8*Log[2]*PolyLog[4, -1/2] + 
    8*Log[3]*PolyLog[4, -1/2] + 2*Log[2]*PolyLog[4, -1/3] + 
    Log[3]*PolyLog[4, -1/3] - 4*Log[2]*PolyLog[4, 1/3] - 
    (16*Log[2]*PolyLog[4, 1/2])/3 + 8*Log[3]*PolyLog[4, 1/2] + 
    8*Log[2]*PolyLog[4, 2/3] - PolyLog[2, 3, -1/3] - 
    (25*Log[2]^2*Zeta[3])/3 + (19*Log[2]*Log[3]*Zeta[3])/3 - 
    (13*Log[3]^2*Zeta[3])/12
 
G[-1, -1, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, 0, 1, 0, -1, 1/2] - 
    (53*Pi^4*Log[2])/288 - (9*Pi^2*Log[2]^3)/8 - (131*Log[2]^5)/120 + 
    (181*Pi^4*Log[3])/2160 + (187*Pi^2*Log[2]^2*Log[3])/72 + 
    (47*Log[2]^4*Log[3])/72 - (5*Pi^2*Log[2]*Log[3]^2)/4 + 
    (10*Log[2]^3*Log[3]^2)/3 + (7*Pi^2*Log[3]^3)/48 - 
    (31*Log[2]^2*Log[3]^3)/6 + (17*Log[2]*Log[3]^4)/8 - (29*Log[3]^5)/160 + 
    10*Log[2]^2*PolyLog[3, 1/3] - 6*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (Log[3]^2*PolyLog[3, 1/3])/2 - 24*Log[2]*PolyLog[4, -1/2] + 
    10*Log[3]*PolyLog[4, -1/2] + 5*Log[2]*PolyLog[4, -1/3] - 
    (3*Log[3]*PolyLog[4, -1/3])/2 - 4*Log[2]*PolyLog[4, 1/3] - 
    3*Log[3]*PolyLog[4, 1/3] - 14*Log[2]*PolyLog[4, 1/2] + 
    (17*Log[3]*PolyLog[4, 1/2])/3 + 16*Log[2]*PolyLog[4, 2/3] - 
    2*Log[3]*PolyLog[4, 2/3] - 29*PolyLog[5, -1/2] - 
    (15*PolyLog[5, -1/3])/4 - (5*PolyLog[5, 1/3])/2 - 27*PolyLog[5, 1/2] - 
    (7*PolyLog[2, 3, -1/3])/2 + 8*PolyLog[2, 3, 1/3] + (49*Pi^2*Zeta[3])/96 - 
    (397*Log[2]^2*Zeta[3])/24 + (313*Log[2]*Log[3]*Zeta[3])/24 - 
    (73*Log[3]^2*Zeta[3])/24 - (439*Zeta[5])/64
 
G[-1, -1, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (2*Pi^2*Log[2]^3)/9 - 
    (Pi^2*Log[2]^2*Log[3])/6 - (Log[2]^4*Log[3])/3 + (Log[2]^3*Log[3]^2)/3 + 
    (Pi^2*Log[3]^3)/72 - (Log[2]^2*Log[3]^3)/12 - 6*Log[2]*PolyLog[4, 1/2] + 
    3*Log[3]*PolyLog[4, 1/2] - 2*Log[2]*PolyLog[4, 2/3] + 
    Log[3]*PolyLog[4, 2/3] - 4*PolyLog[5, 1/2] + 4*PolyLog[5, 2/3] - 
    (7*Log[2]^2*Zeta[3])/2 + (7*Log[2]*Log[3]*Zeta[3])/2 - 
    (7*Log[3]^2*Zeta[3])/8
 
G[-1, -1, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, 0, 1, 0, -1, 1/2] + 
    (2*Pi^4*Log[2])/27 + (23*Pi^2*Log[2]^3)/54 - (31*Log[2]^5)/120 - 
    (139*Pi^4*Log[3])/2160 - (13*Pi^2*Log[2]^2*Log[3])/18 + 
    (19*Log[2]^4*Log[3])/72 + (Pi^2*Log[2]*Log[3]^2)/4 - 
    (Log[2]^3*Log[3]^2)/2 + (2*Log[2]^2*Log[3]^3)/3 - (Log[2]*Log[3]^4)/8 - 
    Log[3]^5/15 - (3*Log[2]^2*PolyLog[3, 1/3])/2 - 
    Log[2]*Log[3]*PolyLog[3, 1/3] + (3*Log[3]^2*PolyLog[3, 1/3])/2 + 
    3*Log[2]*PolyLog[4, -1/2] + Log[3]*PolyLog[4, -1/2] - 
    2*Log[2]*PolyLog[4, -1/3] + Log[3]*PolyLog[4, -1/3] - 
    Log[2]*PolyLog[4, 1/3] + 3*Log[3]*PolyLog[4, 1/3] - 
    (20*Log[2]*PolyLog[4, 1/2])/3 + (16*Log[3]*PolyLog[4, 1/2])/3 - 
    3*Log[2]*PolyLog[4, 2/3] + 10*PolyLog[5, -1/2] + 4*PolyLog[5, 1/3] + 
    (2*PolyLog[5, 1/2])/3 - 3*PolyLog[5, 2/3] + PolyLog[2, 3, -1/3] - 
    5*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/16 + (29*Log[2]^2*Zeta[3])/24 - 
    (13*Log[2]*Log[3]*Zeta[3])/12 + (17*Log[3]^2*Zeta[3])/24 + 
    (269*Zeta[5])/24
 
G[-1, -1, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-7*Pi^4*Log[2])/720 - (Pi^2*Log[2]^3)/18 + 
    (11*Log[2]^5)/60 - (Pi^4*Log[3])/720 + (Pi^2*Log[2]^2*Log[3])/12 - 
    (5*Log[2]^4*Log[3])/12 - (Pi^2*Log[2]*Log[3]^2)/24 + 
    (Log[2]^3*Log[3]^2)/2 - (5*Log[2]^2*Log[3]^3)/12 + 
    (5*Log[2]*Log[3]^4)/24 - Log[3]^5/24 + (Log[2]^2*PolyLog[3, 1/3])/2 - 
    Log[2]*Log[3]*PolyLog[3, 1/3] + (Log[3]^2*PolyLog[3, 1/3])/2 - 
    Log[2]*PolyLog[4, -1/2] + Log[3]*PolyLog[4, -1/2] - 
    Log[2]*PolyLog[4, 1/3] + Log[3]*PolyLog[4, 1/3] - PolyLog[5, 1/2] - 
    PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/12 + (3*Log[2]^2*Zeta[3])/4 - 
    (3*Log[2]*Log[3]*Zeta[3])/4 + (7*Log[3]^2*Zeta[3])/16 + (63*Zeta[5])/32
 
G[-1, -1, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (13*Pi^4*Log[2])/90 + (10*Pi^2*Log[2]^3)/9 + 
    (23*Log[2]^5)/5 - (Pi^4*Log[3])/20 - 5*Pi^2*Log[2]^2*Log[3] - 
    (13*Log[2]^4*Log[3])/6 + 3*Pi^2*Log[2]*Log[3]^2 - 
    (31*Log[2]^3*Log[3]^2)/3 - (Pi^2*Log[3]^3)/2 + 15*Log[2]^2*Log[3]^3 - 
    (25*Log[2]*Log[3]^4)/4 + (5*Log[3]^5)/8 + 8*Log[2]^2*PolyLog[3, -1/2] - 
    8*Log[2]*Log[3]*PolyLog[3, -1/2] + 2*Log[3]^2*PolyLog[3, -1/2] - 
    32*Log[2]^2*PolyLog[3, 1/3] + 20*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    Log[3]^2*PolyLog[3, 1/3] + 96*Log[2]*PolyLog[4, -1/2] - 
    36*Log[3]*PolyLog[4, -1/2] - 12*Log[2]*PolyLog[4, -1/3] + 
    6*Log[3]*PolyLog[4, -1/3] + 12*Log[2]*PolyLog[4, 1/3] + 
    6*Log[3]*PolyLog[4, 1/3] + 96*Log[2]*PolyLog[4, 1/2] - 
    48*Log[3]*PolyLog[4, 1/2] - 48*Log[2]*PolyLog[4, 2/3] + 
    12*Log[3]*PolyLog[4, 2/3] + 120*PolyLog[5, -1/2] + 24*PolyLog[5, -1/3] - 
    12*PolyLog[5, 1/3] + 128*PolyLog[5, 1/2] + 24*PolyLog[5, 2/3] + 
    12*PolyLog[2, 3, -1/3] - 24*PolyLog[2, 3, 1/3] - 2*Pi^2*Zeta[3] + 
    (200*Log[2]^2*Zeta[3])/3 - (164*Log[2]*Log[3]*Zeta[3])/3 + 
    (41*Log[3]^2*Zeta[3])/3 + 18*Zeta[5]
 
G[-1, -1, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, -1, 0, -1, 1/2] - (16*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (347*Pi^4*Log[2])/1620 - (32*Pi^2*Log[2]^3)/81 - (353*Log[2]^5)/270 - 
    (119*Pi^4*Log[3])/1080 + (22*Pi^2*Log[2]^2*Log[3])/9 + 
    (37*Log[2]^4*Log[3])/18 - (17*Pi^2*Log[2]*Log[3]^2)/6 + 
    (2*Log[2]^3*Log[3]^2)/3 + (11*Pi^2*Log[3]^3)/12 - 
    (17*Log[2]^2*Log[3]^3)/3 + (65*Log[2]*Log[3]^4)/12 - (181*Log[3]^5)/120 - 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (2*Log[3]^3*PolyLog[2, -1/2])/3 - 
    2*Log[2]*PolyLog[2, -1/2]^2 + 2*Log[3]*PolyLog[2, -1/2]^2 - 
    (2*Pi^2*PolyLog[3, -1/2])/3 - 8*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    6*Log[3]^2*PolyLog[3, -1/2] - 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/3 + 6*Log[2]^2*PolyLog[3, 1/3] - 
    8*Log[2]*Log[3]*PolyLog[3, 1/3] + 3*Log[3]^2*PolyLog[3, 1/3] - 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 20*Log[2]*PolyLog[4, -1/2] + 
    4*Log[2]*PolyLog[4, -1/3] - 8*Log[3]*PolyLog[4, -1/3] + 
    2*Log[3]*PolyLog[4, 1/3] - (80*Log[2]*PolyLog[4, 1/2])/3 + 
    (16*Log[3]*PolyLog[4, 1/2])/3 + 24*Log[2]*PolyLog[4, 2/3] - 
    28*Log[3]*PolyLog[4, 2/3] - (148*PolyLog[5, -1/2])/3 - 
    14*PolyLog[5, -1/3] + 10*PolyLog[5, 1/3] - (544*PolyLog[5, 1/2])/9 - 
    44*PolyLog[5, 2/3] - 2*PolyLog[2, 3, -1/3] + (11*Pi^2*Zeta[3])/18 - 
    9*Log[2]^2*Zeta[3] + (38*Log[2]*Log[3]*Zeta[3])/3 - 6*Log[3]^2*Zeta[3] + 
    (227*Zeta[5])/9
 
G[-1, -1, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] - (20*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1549*Pi^4*Log[2])/6480 - (323*Pi^2*Log[2]^3)/648 - (127*Log[2]^5)/1080 - 
    (61*Pi^4*Log[3])/480 + (7*Pi^2*Log[2]^2*Log[3])/6 + 
    (55*Log[2]^4*Log[3])/48 - (23*Pi^2*Log[2]*Log[3]^2)/16 + 
    (25*Pi^2*Log[3]^3)/48 - (71*Log[2]^2*Log[3]^3)/24 + 
    (103*Log[2]*Log[3]^4)/32 - (191*Log[3]^5)/192 - 
    (Log[2]^3*PolyLog[2, -1/2])/3 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    Log[2]*PolyLog[2, -1/2]^2 + Log[3]*PolyLog[2, -1/2]^2 - 
    (Pi^2*PolyLog[3, -1/2])/3 + 6*Log[2]^2*PolyLog[3, -1/2] - 
    8*Log[2]*Log[3]*PolyLog[3, -1/2] + 4*Log[3]^2*PolyLog[3, -1/2] - 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/6 + 
    Log[2]^2*PolyLog[3, 1/3] - (9*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (27*Log[3]^2*PolyLog[3, 1/3])/8 - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    12*Log[2]*PolyLog[4, -1/2] - (15*Log[3]*PolyLog[4, -1/2])/2 + 
    (15*Log[2]*PolyLog[4, -1/3])/4 - (39*Log[3]*PolyLog[4, -1/3])/8 - 
    (9*Log[2]*PolyLog[4, 1/3])/2 + (27*Log[3]*PolyLog[4, 1/3])/4 + 
    7*Log[2]*PolyLog[4, 1/2] - 3*Log[3]*PolyLog[4, 1/2] + 
    14*Log[2]*PolyLog[4, 2/3] - (37*Log[3]*PolyLog[4, 2/3])/2 - 
    (38*PolyLog[5, -1/2])/3 - (51*PolyLog[5, -1/3])/8 + 10*PolyLog[5, 1/3] - 
    (170*PolyLog[5, 1/2])/9 - 30*PolyLog[5, 2/3] + 
    (9*PolyLog[2, 3, -1/3])/8 - 7*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/72 + 
    (55*Log[2]^2*Zeta[3])/12 - (35*Log[2]*Log[3]*Zeta[3])/24 - 
    (95*Log[3]^2*Zeta[3])/96 + (2899*Zeta[5])/144
 
G[-1, -1, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (16*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (191*Pi^4*Log[2])/1620 + (104*Pi^2*Log[2]^3)/81 + (653*Log[2]^5)/270 + 
    (29*Pi^4*Log[3])/216 - (35*Pi^2*Log[2]^2*Log[3])/9 - 
    (22*Log[2]^4*Log[3])/9 + (19*Pi^2*Log[2]*Log[3]^2)/6 - 
    (16*Log[2]^3*Log[3]^2)/3 - (11*Pi^2*Log[3]^3)/12 + 
    (32*Log[2]^2*Log[3]^3)/3 - (77*Log[2]*Log[3]^4)/12 + (83*Log[3]^5)/60 + 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 - 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (2*Log[3]^3*PolyLog[2, -1/2])/3 + 
    2*Log[2]*PolyLog[2, -1/2]^2 - 2*Log[3]*PolyLog[2, -1/2]^2 + 
    (2*Pi^2*PolyLog[3, -1/2])/3 - 2*Log[3]^2*PolyLog[3, -1/2] + 
    4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/3 - 
    18*Log[2]^2*PolyLog[3, 1/3] + 16*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    4*Log[3]^2*PolyLog[3, 1/3] + 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    36*Log[2]*PolyLog[4, -1/2] - 20*Log[3]*PolyLog[4, -1/2] - 
    8*Log[2]*PolyLog[4, -1/3] + 4*Log[3]*PolyLog[4, -1/3] + 
    8*Log[2]*PolyLog[4, 1/3] + (112*Log[2]*PolyLog[4, 1/2])/3 - 
    (80*Log[3]*PolyLog[4, 1/2])/3 - 40*Log[2]*PolyLog[4, 2/3] + 
    24*Log[3]*PolyLog[4, 2/3] + (148*PolyLog[5, -1/2])/3 + 
    14*PolyLog[5, -1/3] - 10*PolyLog[5, 1/3] + (544*PolyLog[5, 1/2])/9 + 
    44*PolyLog[5, 2/3] + 5*PolyLog[2, 3, -1/3] - (11*Pi^2*Zeta[3])/18 + 
    30*Log[2]^2*Zeta[3] - (91*Log[2]*Log[3]*Zeta[3])/3 + 
    (115*Log[3]^2*Zeta[3])/12 - (227*Zeta[5])/9
 
G[-1, -1, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (-2*Pi^2*Log[2]^3)/27 - (14*Log[2]^5)/45 + 
    (11*Pi^4*Log[3])/540 + (4*Pi^2*Log[2]^2*Log[3])/9 + 
    (7*Log[2]^4*Log[3])/18 - (Pi^2*Log[2]*Log[3]^2)/2 + 
    (Log[2]^3*Log[3]^2)/3 + (5*Pi^2*Log[3]^3)/36 - Log[2]^2*Log[3]^3 + 
    (5*Log[2]*Log[3]^4)/6 - (29*Log[3]^5)/120 + 2*Log[3]^2*PolyLog[3, -1/2] + 
    2*Log[2]^2*PolyLog[3, 1/3] - 4*Log[2]*PolyLog[4, -1/2] + 
    4*Log[3]*PolyLog[4, -1/2] + 2*Log[2]*PolyLog[4, -1/3] - 
    2*Log[3]*PolyLog[4, -1/3] - (16*Log[2]*PolyLog[4, 1/2])/3 + 
    (16*Log[3]*PolyLog[4, 1/2])/3 + 4*Log[2]*PolyLog[4, 2/3] - 
    4*Log[3]*PolyLog[4, 2/3] - 4*PolyLog[5, -1/2] - 3*PolyLog[5, -1/3] + 
    2*PolyLog[5, 1/3] - (16*PolyLog[5, 1/2])/3 - 4*PolyLog[5, 2/3] - 
    PolyLog[2, 3, -1/3] + 4*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/3 - 
    (13*Log[2]^2*Zeta[3])/3 + (13*Log[2]*Log[3]*Zeta[3])/3 - 
    (11*Log[3]^2*Zeta[3])/12 - 3*Zeta[5]
 
G[-1, -1, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + (14*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (553*Pi^4*Log[2])/6480 + (283*Pi^2*Log[2]^3)/324 + (218*Log[2]^5)/135 + 
    (229*Pi^4*Log[3])/2160 - (85*Pi^2*Log[2]^2*Log[3])/36 - 
    (14*Log[2]^4*Log[3])/9 + (7*Pi^2*Log[2]*Log[3]^2)/4 - 
    (23*Log[2]^3*Log[3]^2)/6 - (17*Pi^2*Log[3]^3)/36 + 
    (43*Log[2]^2*Log[3]^3)/6 - (97*Log[2]*Log[3]^4)/24 + (4*Log[3]^5)/5 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    Log[2]*PolyLog[2, -1/2]^2 - Log[3]*PolyLog[2, -1/2]^2 + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 12*Log[2]^2*PolyLog[3, 1/3] + 
    12*Log[2]*Log[3]*PolyLog[3, 1/3] - 3*Log[3]^2*PolyLog[3, 1/3] + 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 24*Log[2]*PolyLog[4, -1/2] - 
    12*Log[3]*PolyLog[4, -1/2] - 5*Log[2]*PolyLog[4, -1/3] + 
    2*Log[3]*PolyLog[4, -1/3] + 8*Log[2]*PolyLog[4, 1/3] - 
    2*Log[3]*PolyLog[4, 1/3] + (76*Log[2]*PolyLog[4, 1/2])/3 - 
    (58*Log[3]*PolyLog[4, 1/2])/3 - 26*Log[2]*PolyLog[4, 2/3] + 
    14*Log[3]*PolyLog[4, 2/3] + (98*PolyLog[5, -1/2])/3 + 
    9*PolyLog[5, -1/3] - 9*PolyLog[5, 1/3] + (350*PolyLog[5, 1/2])/9 + 
    28*PolyLog[5, 2/3] + 3*PolyLog[2, 3, -1/3] + 2*PolyLog[2, 3, 1/3] - 
    (17*Pi^2*Zeta[3])/48 + (221*Log[2]^2*Zeta[3])/12 - 
    (217*Log[2]*Log[3]*Zeta[3])/12 + (65*Log[3]^2*Zeta[3])/12 - 
    (2083*Zeta[5])/144
 
G[-1, -1, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] - (7*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (401*Pi^4*Log[2])/2592 + (118*Pi^2*Log[2]^3)/81 + (1877*Log[2]^5)/540 - 
    (13*Pi^4*Log[3])/288 - (61*Pi^2*Log[2]^2*Log[3])/12 - 
    (29*Log[2]^4*Log[3])/16 + (53*Pi^2*Log[2]*Log[3]^2)/16 - 
    (26*Log[2]^3*Log[3]^2)/3 - (11*Pi^2*Log[3]^3)/16 + 
    (323*Log[2]^2*Log[3]^3)/24 - (607*Log[2]*Log[3]^4)/96 + 
    (289*Log[3]^5)/320 + (Log[2]^3*PolyLog[2, -1/2])/3 - 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/3 + Log[2]*PolyLog[2, -1/2]^2 - 
    Log[3]*PolyLog[2, -1/2]^2 + (Pi^2*PolyLog[3, -1/2])/3 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/6 - 
    27*Log[2]^2*PolyLog[3, 1/3] + (33*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (Log[3]^2*PolyLog[3, 1/3])/8 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    68*Log[2]*PolyLog[4, -1/2] - (53*Log[3]*PolyLog[4, -1/2])/2 - 
    (37*Log[2]*PolyLog[4, -1/3])/4 + (37*Log[3]*PolyLog[4, -1/3])/8 + 
    (7*Log[2]*PolyLog[4, 1/3])/2 + (35*Log[3]*PolyLog[4, 1/3])/4 + 
    61*Log[2]*PolyLog[4, 1/2] - 27*Log[3]*PolyLog[4, 1/2] - 
    46*Log[2]*PolyLog[4, 2/3] + (33*Log[3]*PolyLog[4, 2/3])/2 + 
    (299*PolyLog[5, -1/2])/3 + (141*PolyLog[5, -1/3])/8 - 
    (5*PolyLog[5, 1/3])/2 + (899*PolyLog[5, 1/2])/9 + 30*PolyLog[5, 2/3] + 
    (75*PolyLog[2, 3, -1/3])/8 - 17*PolyLog[2, 3, 1/3] - 
    (421*Pi^2*Zeta[3])/288 + (1199*Log[2]^2*Zeta[3])/24 - 
    (1051*Log[2]*Log[3]*Zeta[3])/24 + (1147*Log[3]^2*Zeta[3])/96 + 
    (257*Zeta[5])/576
 
G[-1, -1, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] - (41*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (3623*Pi^4*Log[2])/12960 - (983*Pi^2*Log[2]^3)/648 - (941*Log[2]^5)/216 - 
    (329*Pi^4*Log[3])/1440 + (17*Pi^2*Log[2]^2*Log[3])/3 + 
    4*Log[2]^4*Log[3] - (55*Pi^2*Log[2]*Log[3]^2)/12 + 
    (17*Log[2]^3*Log[3]^2)/2 + (55*Pi^2*Log[3]^3)/48 - 
    (52*Log[2]^2*Log[3]^3)/3 + (85*Log[2]*Log[3]^4)/8 - (1057*Log[3]^5)/480 - 
    (Log[2]^3*PolyLog[2, -1/2])/3 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    Log[2]*PolyLog[2, -1/2]^2 + Log[3]*PolyLog[2, -1/2]^2 - 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] + 4*Log[3]^2*PolyLog[3, -1/2] - 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 28*Log[2]^2*PolyLog[3, 1/3] - 
    28*Log[2]*Log[3]*PolyLog[3, 1/3] + (15*Log[3]^2*PolyLog[3, 1/3])/2 - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 60*Log[2]*PolyLog[4, -1/2] + 
    26*Log[3]*PolyLog[4, -1/2] + 15*Log[2]*PolyLog[4, -1/3] - 
    (49*Log[3]*PolyLog[4, -1/3])/4 - 24*Log[2]*PolyLog[4, 1/3] + 
    (31*Log[3]*PolyLog[4, 1/3])/2 - 81*Log[2]*PolyLog[4, 1/2] + 
    48*Log[3]*PolyLog[4, 1/2] + 62*Log[2]*PolyLog[4, 2/3] - 
    40*Log[3]*PolyLog[4, 2/3] - (257*PolyLog[5, -1/2])/3 - 
    30*PolyLog[5, -1/3] + 37*PolyLog[5, 1/3] - (1118*PolyLog[5, 1/2])/9 - 
    72*PolyLog[5, 2/3] - (15*PolyLog[2, 3, -1/3])/2 + 2*PolyLog[2, 3, 1/3] + 
    (55*Pi^2*Zeta[3])/48 - (2219*Log[2]^2*Zeta[3])/48 + 
    (79*Log[2]*Log[3]*Zeta[3])/2 - (239*Log[3]^2*Zeta[3])/24 + 
    (21169*Zeta[5])/576
 
G[-1, -1, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -6*G[0, 0, 1, 0, -1, 1/2] + 
    (307*Pi^4*Log[2])/2160 - (8*Pi^2*Log[2]^3)/27 - Log[2]^5/6 - 
    (371*Pi^4*Log[3])/4320 + (41*Pi^2*Log[2]^2*Log[3])/72 + 
    (107*Log[2]^4*Log[3])/144 - (5*Pi^2*Log[2]*Log[3]^2)/8 + 
    (Log[2]^3*Log[3]^2)/6 + (3*Pi^2*Log[3]^3)/16 - 
    (47*Log[2]^2*Log[3]^3)/24 + (31*Log[2]*Log[3]^4)/16 - 
    (527*Log[3]^5)/960 + 2*Log[2]^2*PolyLog[3, -1/2] - 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] + 2*Log[3]^2*PolyLog[3, -1/2] + 
    Log[2]^2*PolyLog[3, 1/3] - (9*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (23*Log[3]^2*PolyLog[3, 1/3])/8 + 4*Log[2]*PolyLog[4, -1/2] - 
    (3*Log[3]*PolyLog[4, -1/2])/2 + (7*Log[2]*PolyLog[4, -1/3])/2 - 
    (33*Log[3]*PolyLog[4, -1/3])/8 - 9*Log[2]*PolyLog[4, 1/3] + 
    (41*Log[3]*PolyLog[4, 1/3])/4 - (5*Log[2]*PolyLog[4, 1/2])/3 + 
    (10*Log[3]*PolyLog[4, 1/2])/3 + 8*Log[2]*PolyLog[4, 2/3] - 
    (21*Log[3]*PolyLog[4, 2/3])/2 - (45*PolyLog[5, -1/3])/8 + 
    (27*PolyLog[5, 1/3])/2 - (43*PolyLog[5, 1/2])/3 - 18*PolyLog[5, 2/3] + 
    (5*PolyLog[2, 3, -1/3])/8 - 5*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/48 + 
    (67*Log[2]^2*Zeta[3])/16 - (25*Log[2]*Log[3]*Zeta[3])/6 + 
    (43*Log[3]^2*Zeta[3])/32 + (919*Zeta[5])/64
 
G[-1, -1, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2]^3)/2 + 
    (5*Pi^2*Log[2]^2*Log[3])/6 - (11*Pi^2*Log[2]*Log[3]^2)/24 + 
    Log[2]^3*Log[3]^2 + (Pi^2*Log[3]^3)/12 - (5*Log[2]^2*Log[3]^3)/3 + 
    (11*Log[2]*Log[3]^4)/12 - Log[3]^5/6 + 2*Log[2]^2*PolyLog[3, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] + (Log[3]^2*PolyLog[3, -1/2])/2 + 
    2*Log[2]^2*PolyLog[3, 1/3] - 2*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (Log[3]^2*PolyLog[3, 1/3])/2 + 6*Log[2]*PolyLog[4, 1/2] - 
    3*Log[3]*PolyLog[4, 1/2] + 6*Log[2]*PolyLog[4, 2/3] - 
    3*Log[3]*PolyLog[4, 2/3] + 6*PolyLog[5, 1/2] - 6*PolyLog[5, 2/3] - 
    (Log[2]^2*Zeta[3])/4 + (Log[2]*Log[3]*Zeta[3])/4 - (Log[3]^2*Zeta[3])/16
 
G[-1, -1, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, 1, 0, -1, 1/2] + (9*Pi^4*Log[2])/80 + (115*Pi^2*Log[2]^3)/216 + 
    (83*Log[2]^5)/72 - (71*Pi^4*Log[3])/4320 - (25*Pi^2*Log[2]^2*Log[3])/18 - 
    (13*Log[2]^4*Log[3])/144 + (13*Pi^2*Log[2]*Log[3]^2)/48 - 
    (47*Log[2]^3*Log[3]^2)/12 + (25*Pi^2*Log[3]^3)/144 + 
    (109*Log[2]^2*Log[3]^3)/24 - (113*Log[2]*Log[3]^4)/96 - 
    (43*Log[3]^5)/320 - (Log[2]^3*PolyLog[2, -1/2])/3 + 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/3 - Log[2]*PolyLog[2, -1/2]^2 + 
    Log[3]*PolyLog[2, -1/2]^2 - (Pi^2*PolyLog[3, -1/2])/6 + 
    Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (5*Log[3]^2*PolyLog[3, -1/2])/2 - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/6 - 10*Log[2]^2*PolyLog[3, 1/3] + 
    (13*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + (Log[3]^2*PolyLog[3, 1/3])/8 - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 22*Log[2]*PolyLog[4, -1/2] - 
    (21*Log[3]*PolyLog[4, -1/2])/2 - (23*Log[2]*PolyLog[4, -1/3])/4 + 
    (23*Log[3]*PolyLog[4, -1/3])/8 + (21*Log[2]*PolyLog[4, 1/3])/2 - 
    (19*Log[3]*PolyLog[4, 1/3])/4 + (82*Log[2]*PolyLog[4, 1/2])/3 - 
    (41*Log[3]*PolyLog[4, 1/2])/3 - 14*Log[2]*PolyLog[4, 2/3] - 
    (Log[3]*PolyLog[4, 2/3])/2 + 30*PolyLog[5, -1/2] + 
    (71*PolyLog[5, -1/3])/8 - 9*PolyLog[5, 1/3] + (145*PolyLog[5, 1/2])/3 + 
    3*PolyLog[5, 2/3] + (23*PolyLog[2, 3, -1/3])/8 - 5*PolyLog[2, 3, 1/3] - 
    (Pi^2*Zeta[3])/48 + (217*Log[2]^2*Zeta[3])/12 - 
    (251*Log[2]*Log[3]*Zeta[3])/24 + (23*Log[3]^2*Zeta[3])/96 - 
    (67*Zeta[5])/12
 
G[-1, -1, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    (9*Pi^4*Log[2])/160 - (Pi^2*Log[2]^3)/6 - (23*Log[2]^5)/120 - 
    (11*Pi^4*Log[3])/480 + (5*Pi^2*Log[2]^2*Log[3])/8 + (Log[2]^4*Log[3])/3 - 
    (2*Pi^2*Log[2]*Log[3]^2)/3 + (Log[2]^3*Log[3]^2)/3 + (Pi^2*Log[3]^3)/4 - 
    (5*Log[2]^2*Log[3]^3)/4 + (13*Log[2]*Log[3]^4)/12 - (13*Log[3]^5)/40 - 
    (Log[2]^3*PolyLog[2, -1/2])/6 + (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + (Log[3]*PolyLog[2, -1/2]^2)/2 - 
    (Pi^2*PolyLog[3, -1/2])/12 + 2*Log[2]^2*PolyLog[3, -1/2] - 
    3*Log[2]*Log[3]*PolyLog[3, -1/2] + (3*Log[3]^2*PolyLog[3, -1/2])/2 - 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/12 + 
    Log[2]^2*PolyLog[3, 1/3] - Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (Log[3]^2*PolyLog[3, 1/3])/2 - PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    2*Log[2]*PolyLog[4, -1/2] - 2*Log[3]*PolyLog[4, -1/2] + 
    2*Log[2]*PolyLog[4, 1/3] - 2*Log[3]*PolyLog[4, 1/3] + 
    5*Log[2]*PolyLog[4, 2/3] - 5*Log[3]*PolyLog[4, 2/3] + 3*PolyLog[5, 1/2] - 
    7*PolyLog[5, 2/3] + (Pi^2*Zeta[3])/4 - (7*Log[2]^2*Zeta[3])/2 + 
    (9*Log[2]*Log[3]*Zeta[3])/2 - (19*Log[3]^2*Zeta[3])/8 + (73*Zeta[5])/64
 
G[-1, -1, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, 1, 0, -1, 1/2] - (581*Pi^4*Log[2])/2160 - 
    (235*Pi^2*Log[2]^3)/216 - (101*Log[2]^5)/60 + (763*Pi^4*Log[3])/4320 + 
    (103*Pi^2*Log[2]^2*Log[3])/36 + (41*Log[2]^4*Log[3])/144 - 
    (49*Pi^2*Log[2]*Log[3]^2)/48 + (21*Log[2]^3*Log[3]^2)/4 - 
    (13*Pi^2*Log[3]^3)/144 - (157*Log[2]^2*Log[3]^3)/24 + 
    (173*Log[2]*Log[3]^4)/96 + (67*Log[3]^5)/320 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    Log[2]*PolyLog[2, -1/2]^2 - Log[3]*PolyLog[2, -1/2]^2 + 
    (Pi^2*PolyLog[3, -1/2])/6 - Log[2]^2*PolyLog[3, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] - (3*Log[3]^2*PolyLog[3, -1/2])/2 + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/6 + 
    (29*Log[2]^2*PolyLog[3, 1/3])/2 - (11*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (29*Log[3]^2*PolyLog[3, 1/3])/8 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    41*Log[2]*PolyLog[4, -1/2] + (25*Log[3]*PolyLog[4, -1/2])/2 + 
    (23*Log[2]*PolyLog[4, -1/3])/4 - (23*Log[3]*PolyLog[4, -1/3])/8 - 
    (3*Log[2]*PolyLog[4, 1/3])/2 - (29*Log[3]*PolyLog[4, 1/3])/4 - 
    (86*Log[2]*PolyLog[4, 1/2])/3 + (25*Log[3]*PolyLog[4, 1/2])/3 + 
    19*Log[2]*PolyLog[4, 2/3] + (5*Log[3]*PolyLog[4, 2/3])/2 - 
    60*PolyLog[5, -1/2] - (71*PolyLog[5, -1/3])/8 - 3*PolyLog[5, 1/3] - 
    (151*PolyLog[5, 1/2])/3 + 6*PolyLog[5, 2/3] - (47*PolyLog[2, 3, -1/3])/
     8 + 20*PolyLog[2, 3, 1/3] + (23*Pi^2*Zeta[3])/24 - 
    (677*Log[2]^2*Zeta[3])/24 + (491*Log[2]*Log[3]*Zeta[3])/24 - 
    (395*Log[3]^2*Zeta[3])/96 - (673*Zeta[5])/24
 
G[-1, -1, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, 0, 1, 0, -1, 1/2] - 
    (13*Pi^4*Log[2])/120 + (11*Pi^2*Log[2]^3)/27 + (589*Log[2]^5)/360 + 
    (83*Pi^4*Log[3])/720 - (7*Pi^2*Log[2]^2*Log[3])/4 - 
    (23*Log[2]^4*Log[3])/24 + (4*Pi^2*Log[2]*Log[3]^2)/3 - 
    (15*Log[2]^3*Log[3]^2)/4 - (5*Pi^2*Log[3]^3)/18 + 
    (13*Log[2]^2*Log[3]^3)/2 - (11*Log[2]*Log[3]^4)/3 + (157*Log[3]^5)/240 + 
    (Log[3]^2*PolyLog[3, -1/2])/2 - 11*Log[2]^2*PolyLog[3, 1/3] + 
    12*Log[2]*Log[3]*PolyLog[3, 1/3] - 3*Log[3]^2*PolyLog[3, 1/3] + 
    22*Log[2]*PolyLog[4, -1/2] - 7*Log[3]*PolyLog[4, -1/2] - 
    5*Log[2]*PolyLog[4, -1/3] + (11*Log[3]*PolyLog[4, -1/3])/2 + 
    12*Log[2]*PolyLog[4, 1/3] - 10*Log[3]*PolyLog[4, 1/3] + 
    (106*Log[2]*PolyLog[4, 1/2])/3 - 16*Log[3]*PolyLog[4, 1/2] - 
    22*Log[2]*PolyLog[4, 2/3] + 14*Log[3]*PolyLog[4, 2/3] + 
    35*PolyLog[5, -1/2] + (27*PolyLog[5, -1/3])/2 - 19*PolyLog[5, 1/3] + 
    (184*PolyLog[5, 1/2])/3 + 29*PolyLog[5, 2/3] + 
    (5*PolyLog[2, 3, -1/3])/2 + 2*PolyLog[2, 3, 1/3] - (7*Pi^2*Zeta[3])/48 + 
    (395*Log[2]^2*Zeta[3])/24 - (37*Log[2]*Log[3]*Zeta[3])/3 + 
    (53*Log[3]^2*Zeta[3])/24 - (193*Zeta[5])/8
 
G[-1, -1, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] + 
    6*G[0, 0, 1, 0, -1, 1/2] - (877*Pi^4*Log[2])/4320 + (Pi^2*Log[2]^3)/6 - 
    Log[2]^5/18 + (101*Pi^4*Log[3])/720 - (Pi^2*Log[2]^2*Log[3])/6 - 
    (7*Log[2]^4*Log[3])/16 + (23*Pi^2*Log[2]*Log[3]^2)/48 - 
    (Log[2]^3*Log[3]^2)/3 - (5*Pi^2*Log[3]^3)/24 + (15*Log[2]^2*Log[3]^3)/8 - 
    (187*Log[2]*Log[3]^4)/96 + (193*Log[3]^5)/320 + 
    (Log[2]^3*PolyLog[2, -1/2])/6 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]*PolyLog[2, -1/2]^2)/2 - (Log[3]*PolyLog[2, -1/2]^2)/2 - 
    (Log[2]^2*PolyLog[3, -1/2])/2 + Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (Log[3]^2*PolyLog[3, -1/2])/2 + PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (3*Log[2]^2*PolyLog[3, 1/3])/2 + (13*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (33*Log[3]^2*PolyLog[3, 1/3])/8 + PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    3*Log[2]*PolyLog[4, -1/2] - (Log[3]*PolyLog[4, -1/2])/2 - 
    (5*Log[2]*PolyLog[4, -1/3])/4 + (17*Log[3]*PolyLog[4, -1/3])/8 + 
    (17*Log[2]*PolyLog[4, 1/3])/2 - (41*Log[3]*PolyLog[4, 1/3])/4 - 
    (10*Log[2]*PolyLog[4, 1/2])/3 - 3*Log[3]*PolyLog[4, 1/2] - 
    8*Log[2]*PolyLog[4, 2/3] + (23*Log[3]*PolyLog[4, 2/3])/2 - 
    5*PolyLog[5, -1/2] + (27*PolyLog[5, -1/3])/8 - (23*PolyLog[5, 1/3])/2 + 
    2*PolyLog[5, 1/2] + 24*PolyLog[5, 2/3] - (7*PolyLog[2, 3, -1/3])/8 + 
    11*PolyLog[2, 3, 1/3] + (35*Pi^2*Zeta[3])/96 - 
    (329*Log[2]^2*Zeta[3])/48 + (121*Log[2]*Log[3]*Zeta[3])/24 - 
    (139*Log[3]^2*Zeta[3])/96 - (633*Zeta[5])/32
 
G[-1, -1, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    (67*Pi^4*Log[2])/1440 + (17*Log[2]^5)/120 + (53*Pi^4*Log[3])/1440 - 
    (5*Pi^2*Log[2]^2*Log[3])/24 - (Log[2]^4*Log[3])/3 + 
    (3*Pi^2*Log[2]*Log[3]^2)/8 + (Log[2]^3*Log[3]^2)/6 - (Pi^2*Log[3]^3)/6 + 
    (5*Log[2]^2*Log[3]^3)/12 - (5*Log[2]*Log[3]^4)/8 + (29*Log[3]^5)/120 + 
    (Log[2]^3*PolyLog[2, -1/2])/6 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]*PolyLog[2, -1/2]^2)/2 - (Log[3]*PolyLog[2, -1/2]^2)/2 + 
    (Pi^2*PolyLog[3, -1/2])/12 - (Log[3]^2*PolyLog[3, -1/2])/2 + 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/12 - 
    (Log[2]^2*PolyLog[3, 1/3])/2 + Log[2]*Log[3]*PolyLog[3, 1/3] - 
    Log[3]^2*PolyLog[3, 1/3] + PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    Log[2]*PolyLog[4, -1/2] - Log[2]*PolyLog[4, 1/3] - 
    3*Log[2]*PolyLog[4, 2/3] + 4*Log[3]*PolyLog[4, 2/3] + 7*PolyLog[5, 2/3] + 
    3*PolyLog[2, 3, 1/3] + (3*Log[2]^2*Zeta[3])/4 - 
    (7*Log[2]*Log[3]*Zeta[3])/4 + (15*Log[3]^2*Zeta[3])/16 - (451*Zeta[5])/64
 
G[-1, -1, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, 1, 0, -1, 1/2] + (67*Pi^4*Log[2])/720 - (5*Pi^2*Log[2]^3)/36 - 
    (23*Log[2]^5)/60 - (13*Pi^4*Log[3])/240 + (Pi^2*Log[2]^2*Log[3])/2 + 
    (3*Log[2]^4*Log[3])/4 - (2*Pi^2*Log[2]*Log[3]^2)/3 + 
    (Log[2]^3*Log[3]^2)/6 + (Pi^2*Log[3]^3)/4 - (19*Log[2]^2*Log[3]^3)/12 + 
    (19*Log[2]*Log[3]^4)/12 - (59*Log[3]^5)/120 - (Log[2]^3*PolyLog[2, -1/2])/
     6 + (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + (Log[3]*PolyLog[2, -1/2]^2)/2 + 
    (Log[2]^2*PolyLog[3, -1/2])/2 - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (3*Log[3]^2*PolyLog[3, -1/2])/2 - PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (3*Log[2]^2*PolyLog[3, 1/3])/2 - 4*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (5*Log[3]^2*PolyLog[3, 1/3])/2 - PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    2*Log[2]*PolyLog[4, -1/2] + 3*Log[3]*PolyLog[4, -1/2] - 
    2*Log[2]*PolyLog[4, 1/3] + 3*Log[3]*PolyLog[4, 1/3] - 
    2*Log[2]*PolyLog[4, 1/2] + 4*Log[3]*PolyLog[4, 1/2] + 
    6*Log[2]*PolyLog[4, 2/3] - 7*Log[3]*PolyLog[4, 2/3] + 
    4*PolyLog[5, -1/2] + 4*PolyLog[5, 1/3] + 4*PolyLog[5, 1/2] - 
    12*PolyLog[5, 2/3] - 4*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/48 - 
    (5*Log[2]^2*Zeta[3])/8 + (7*Log[2]*Log[3]*Zeta[3])/4 - Log[3]^2*Zeta[3] + 
    (231*Zeta[5])/32
 
G[-1, -1, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (-7*Pi^4*Log[2])/720 - Log[2]^5/30 + 
    (Pi^4*Log[3])/90 + (Pi^2*Log[2]^2*Log[3])/12 - 
    (Pi^2*Log[2]*Log[3]^2)/12 + (Log[2]^3*Log[3]^2)/12 + (Pi^2*Log[3]^3)/36 - 
    (Log[2]^2*Log[3]^3)/6 + (Log[2]*Log[3]^4)/8 - Log[3]^5/30 + 
    (Log[2]^2*PolyLog[3, -1/2])/2 - Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (Log[3]^2*PolyLog[3, -1/2])/2 - 2*Log[2]*PolyLog[4, 1/2] + 
    Log[3]*PolyLog[4, 1/2] + PolyLog[5, -1/2] + PolyLog[5, 1/3] - 
    PolyLog[5, 1/2] + PolyLog[5, 2/3] + PolyLog[2, 3, 1/3] + 
    (Pi^2*Zeta[3])/12 - Log[2]^2*Zeta[3] + Log[2]*Log[3]*Zeta[3] - 
    (Log[3]^2*Zeta[3])/2 - (33*Zeta[5])/32
 
G[-1, 0, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-13*Pi^4*Log[2])/270 + 
    (10*Pi^2*Log[2]^3)/27 - (17*Log[2]^5)/5 + (Pi^4*Log[3])/108 + 
    (13*Pi^2*Log[2]^2*Log[3])/9 + (37*Log[2]^4*Log[3])/18 - 
    Pi^2*Log[2]*Log[3]^2 + (13*Log[2]^3*Log[3]^2)/3 + (Pi^2*Log[3]^3)/6 - 
    (37*Log[2]^2*Log[3]^3)/6 + (25*Log[2]*Log[3]^4)/12 - Log[3]^5/24 - 
    (8*Log[2]^3*PolyLog[2, -1/2])/3 + 4*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    16*Log[2]^2*PolyLog[3, -1/2] + 16*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    4*Log[3]^2*PolyLog[3, -1/2] + 16*Log[2]^2*PolyLog[3, 1/3] - 
    8*Log[2]*Log[3]*PolyLog[3, 1/3] - 2*Log[3]^2*PolyLog[3, 1/3] - 
    72*Log[2]*PolyLog[4, -1/2] + 28*Log[3]*PolyLog[4, -1/2] + 
    4*Log[2]*PolyLog[4, -1/3] - 2*Log[3]*PolyLog[4, -1/3] - 
    4*Log[2]*PolyLog[4, 1/3] - 6*Log[3]*PolyLog[4, 1/3] - 
    (224*Log[2]*PolyLog[4, 1/2])/3 + (112*Log[3]*PolyLog[4, 1/2])/3 + 
    24*Log[2]*PolyLog[4, 2/3] - 4*Log[3]*PolyLog[4, 2/3] - 
    80*PolyLog[5, -1/2] - 16*PolyLog[5, -1/3] + 8*PolyLog[5, 1/3] - 
    (256*PolyLog[5, 1/2])/3 - 16*PolyLog[5, 2/3] - 8*PolyLog[2, 3, -1/3] + 
    16*PolyLog[2, 3, 1/3] + (4*Pi^2*Zeta[3])/3 - 44*Log[2]^2*Zeta[3] + 
    36*Log[2]*Log[3]*Zeta[3] - 9*Log[3]^2*Zeta[3] - 12*Zeta[5]
 
G[-1, 0, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 12*G[0, -1, 0, -1, -1, 1/2] + 
    12*G[0, 0, -1, 0, -1, 1/2] + 16*G[0, 0, 1, 0, -1, 1/2] - 
    (161*Pi^4*Log[2])/540 + (116*Pi^2*Log[2]^3)/27 + (713*Log[2]^5)/90 + 
    (109*Pi^4*Log[3])/360 - (27*Pi^2*Log[2]^2*Log[3])/2 - 
    (61*Log[2]^4*Log[3])/6 + (67*Pi^2*Log[2]*Log[3]^2)/6 - 
    (34*Log[2]^3*Log[3]^2)/3 - (37*Pi^2*Log[3]^3)/12 + 
    (63*Log[2]^2*Log[3]^3)/2 - (87*Log[2]*Log[3]^4)/4 + (201*Log[3]^5)/40 + 
    (2*Pi^2*Log[2]*PolyLog[2, -1/2])/3 + (10*Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/3 - 6*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    4*Log[2]*Log[3]^2*PolyLog[2, -1/2] - Log[3]^3*PolyLog[2, -1/2] + 
    6*Log[2]*PolyLog[2, -1/2]^2 - 6*Log[3]*PolyLog[2, -1/2]^2 + 
    (4*Pi^2*PolyLog[3, -1/2])/3 - 4*Log[2]^2*PolyLog[3, -1/2] + 
    24*Log[2]*Log[3]*PolyLog[3, -1/2] - 16*Log[3]^2*PolyLog[3, -1/2] + 
    4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (2*Pi^2*PolyLog[3, 1/3])/3 - 
    44*Log[2]^2*PolyLog[3, 1/3] + 48*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    14*Log[3]^2*PolyLog[3, 1/3] + 8*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    108*Log[2]*PolyLog[4, -1/2] - 48*Log[3]*PolyLog[4, -1/2] - 
    24*Log[2]*PolyLog[4, -1/3] + 18*Log[3]*PolyLog[4, -1/3] + 
    24*Log[2]*PolyLog[4, 1/3] - 6*Log[3]*PolyLog[4, 1/3] + 
    112*Log[2]*PolyLog[4, 1/2] - 64*Log[3]*PolyLog[4, 1/2] - 
    120*Log[2]*PolyLog[4, 2/3] + 84*Log[3]*PolyLog[4, 2/3] + 
    148*PolyLog[5, -1/2] + 42*PolyLog[5, -1/3] - 30*PolyLog[5, 1/3] + 
    (544*PolyLog[5, 1/2])/3 + 132*PolyLog[5, 2/3] + 12*PolyLog[2, 3, -1/3] - 
    (37*Pi^2*Zeta[3])/18 + (227*Log[2]^2*Zeta[3])/3 - 
    76*Log[2]*Log[3]*Zeta[3] + (151*Log[3]^2*Zeta[3])/6 - 
    (8*PolyLog[2, -1/2]*Zeta[3])/3 - (227*Zeta[5])/3
 
G[-1, 0, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (25*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (3199*Pi^4*Log[2])/12960 + (803*Pi^2*Log[2]^3)/324 + 
    (2303*Log[2]^5)/1080 + (857*Pi^4*Log[3])/4320 - 
    (461*Pi^2*Log[2]^2*Log[3])/72 - (497*Log[2]^4*Log[3])/144 + 
    (259*Pi^2*Log[2]*Log[3]^2)/48 - (61*Log[2]^3*Log[3]^2)/12 - 
    (14*Pi^2*Log[3]^3)/9 + (347*Log[2]^2*Log[3]^3)/24 - 
    (1033*Log[2]*Log[3]^4)/96 + (2593*Log[3]^5)/960 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - Log[2]^3*PolyLog[2, -1/2] - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/3 + 3*Log[2]*PolyLog[2, -1/2]^2 - 
    3*Log[3]*PolyLog[2, -1/2]^2 + (2*Pi^2*PolyLog[3, -1/2])/3 - 
    14*Log[2]^2*PolyLog[3, -1/2] + 20*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    10*Log[3]^2*PolyLog[3, -1/2] + 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/3 - (37*Log[2]^2*PolyLog[3, 1/3])/2 + 
    (47*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (75*Log[3]^2*PolyLog[3, 1/3])/8 + 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 17*Log[2]*PolyLog[4, -1/2] - 
    (15*Log[3]*PolyLog[4, -1/2])/2 - (43*Log[2]*PolyLog[4, -1/3])/4 + 
    (67*Log[3]*PolyLog[4, -1/3])/8 + (27*Log[2]*PolyLog[4, 1/3])/2 - 
    (35*Log[3]*PolyLog[4, 1/3])/4 + (62*Log[2]*PolyLog[4, 1/2])/3 - 
    (40*Log[3]*PolyLog[4, 1/2])/3 - 53*Log[2]*PolyLog[4, 2/3] + 
    (87*Log[3]*PolyLog[4, 2/3])/2 + (157*PolyLog[5, -1/2])/3 + 
    (121*PolyLog[5, -1/3])/8 - (31*PolyLog[5, 1/3])/2 + 
    (616*PolyLog[5, 1/2])/9 + 66*PolyLog[5, 2/3] + 
    (19*PolyLog[2, 3, -1/3])/8 + 10*PolyLog[2, 3, 1/3] - 
    (119*Pi^2*Zeta[3])/288 + (151*Log[2]^2*Zeta[3])/8 - 
    (45*Log[2]*Log[3]*Zeta[3])/2 + (833*Log[3]^2*Zeta[3])/96 + 
    (PolyLog[2, -1/2]*Zeta[3])/4 - (27491*Zeta[5])/576
 
G[-1, 0, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -16*G[0, -1, 0, -1, -1, 1/2] - 
    16*G[0, 0, -1, 0, -1, 1/2] - (64*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (473*Pi^4*Log[2])/1620 - (533*Pi^2*Log[2]^3)/81 - (1501*Log[2]^5)/135 - 
    (161*Pi^4*Log[3])/360 + (113*Pi^2*Log[2]^2*Log[3])/6 + 
    (25*Log[2]^4*Log[3])/2 - (29*Pi^2*Log[2]*Log[3]^2)/2 + 
    (65*Log[2]^3*Log[3]^2)/3 + (47*Pi^2*Log[3]^3)/12 - 
    (283*Log[2]^2*Log[3]^3)/6 + (347*Log[2]*Log[3]^4)/12 - 
    (739*Log[3]^5)/120 - (2*Pi^2*Log[2]*PolyLog[2, -1/2])/3 - 
    (4*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/3 + 
    6*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 6*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (5*Log[3]^3*PolyLog[2, -1/2])/3 - 4*Log[2]*PolyLog[2, -1/2]^2 + 
    6*Log[3]*PolyLog[2, -1/2]^2 - (4*Pi^2*PolyLog[3, -1/2])/3 + 
    8*Log[2]^2*PolyLog[3, -1/2] - 16*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    12*Log[3]^2*PolyLog[3, -1/2] - (2*Pi^2*PolyLog[3, 1/3])/3 + 
    76*Log[2]^2*PolyLog[3, 1/3] - 72*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    18*Log[3]^2*PolyLog[3, 1/3] - 8*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    160*Log[2]*PolyLog[4, -1/2] + 88*Log[3]*PolyLog[4, -1/2] + 
    36*Log[2]*PolyLog[4, -1/3] - 18*Log[3]*PolyLog[4, -1/3] - 
    40*Log[2]*PolyLog[4, 1/3] + 4*Log[3]*PolyLog[4, 1/3] - 
    160*Log[2]*PolyLog[4, 1/2] + 112*Log[3]*PolyLog[4, 1/2] + 
    176*Log[2]*PolyLog[4, 2/3] - 104*Log[3]*PolyLog[4, 2/3] - 
    (592*PolyLog[5, -1/2])/3 - 56*PolyLog[5, -1/3] + 40*PolyLog[5, 1/3] - 
    (2176*PolyLog[5, 1/2])/9 - 176*PolyLog[5, 2/3] - 20*PolyLog[2, 3, -1/3] + 
    (26*Pi^2*Zeta[3])/9 - (376*Log[2]^2*Zeta[3])/3 + 
    124*Log[2]*Log[3]*Zeta[3] - 39*Log[3]^2*Zeta[3] + 
    (16*PolyLog[2, -1/2]*Zeta[3])/3 + (908*Zeta[5])/9
 
G[-1, 0, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (8*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (323*Pi^4*Log[2])/1620 - (2*Pi^2*Log[2]^3)/81 + (331*Log[2]^5)/270 - 
    (103*Pi^4*Log[3])/540 - (2*Pi^2*Log[2]^2*Log[3])/9 - 
    (11*Log[2]^4*Log[3])/18 - (Pi^2*Log[2]*Log[3]^2)/2 - 
    2*Log[2]^3*Log[3]^2 + (5*Pi^2*Log[3]^3)/12 + (7*Log[2]^2*Log[3]^3)/6 + 
    (7*Log[2]*Log[3]^4)/6 - (29*Log[3]^5)/40 - (2*Log[2]^3*PolyLog[2, -1/2])/
     3 + (Log[3]^3*PolyLog[2, -1/2])/3 - 2*Log[2]*PolyLog[2, -1/2]^2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 8*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 6*Log[2]^2*PolyLog[3, 1/3] - 
    8*Log[2]*Log[3]*PolyLog[3, 1/3] + 7*Log[3]^2*PolyLog[3, 1/3] + 
    32*Log[2]*PolyLog[4, -1/2] - 20*Log[3]*PolyLog[4, -1/2] - 
    10*Log[2]*PolyLog[4, -1/3] + 7*Log[3]*PolyLog[4, -1/3] + 
    6*Log[3]*PolyLog[4, 1/3] + (104*Log[2]*PolyLog[4, 1/2])/3 - 
    (80*Log[3]*PolyLog[4, 1/2])/3 - 4*Log[2]*PolyLog[4, 2/3] - 
    8*Log[3]*PolyLog[4, 2/3] + (128*PolyLog[5, -1/2])/3 + 
    14*PolyLog[5, -1/3] - 4*PolyLog[5, 1/3] + (416*PolyLog[5, 1/2])/9 - 
    16*PolyLog[5, 2/3] + 5*PolyLog[2, 3, -1/3] - 28*PolyLog[2, 3, 1/3] - 
    (7*Pi^2*Zeta[3])/6 + (62*Log[2]^2*Zeta[3])/3 - 
    (41*Log[2]*Log[3]*Zeta[3])/3 + (13*Log[3]^2*Zeta[3])/12 - 
    (13*PolyLog[2, -1/2]*Zeta[3])/3 + (703*Zeta[5])/18
 
G[-1, 0, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -10*G[0, -1, 0, -1, -1, 1/2] - 
    6*G[0, 0, -1, 0, -1, 1/2] - (26*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (73*Pi^4*Log[2])/405 - (1201*Pi^2*Log[2]^3)/324 - (136*Log[2]^5)/27 - 
    (1327*Pi^4*Log[3])/4320 + (359*Pi^2*Log[2]^2*Log[3])/36 + 
    (437*Log[2]^4*Log[3])/72 - (187*Pi^2*Log[2]*Log[3]^2)/24 + 
    (65*Log[2]^3*Log[3]^2)/6 + (313*Pi^2*Log[3]^3)/144 - 
    (99*Log[2]^2*Log[3]^3)/4 + (767*Log[2]*Log[3]^4)/48 - (18*Log[3]^5)/5 - 
    Log[2]^3*PolyLog[2, -1/2] + 3*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    3*Log[2]*Log[3]^2*PolyLog[2, -1/2] + Log[3]^3*PolyLog[2, -1/2] - 
    3*Log[2]*PolyLog[2, -1/2]^2 + 3*Log[3]*PolyLog[2, -1/2]^2 + 
    6*Log[2]^2*PolyLog[3, -1/2] - 12*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    6*Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    38*Log[2]^2*PolyLog[3, 1/3] - 43*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (53*Log[3]^2*PolyLog[3, 1/3])/4 - 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    70*Log[2]*PolyLog[4, -1/2] + 37*Log[3]*PolyLog[4, -1/2] + 
    (29*Log[2]*PolyLog[4, -1/3])/2 - (25*Log[3]*PolyLog[4, -1/3])/4 - 
    23*Log[2]*PolyLog[4, 1/3] + (13*Log[3]*PolyLog[4, 1/3])/2 - 
    (182*Log[2]*PolyLog[4, 1/2])/3 + (128*Log[3]*PolyLog[4, 1/2])/3 + 
    92*Log[2]*PolyLog[4, 2/3] - 59*Log[3]*PolyLog[4, 2/3] - 
    (248*PolyLog[5, -1/2])/3 - 22*PolyLog[5, -1/3] + (37*PolyLog[5, 1/3])/2 - 
    (908*PolyLog[5, 1/2])/9 - 102*PolyLog[5, 2/3] - 
    (33*PolyLog[2, 3, -1/3])/4 - 14*PolyLog[2, 3, 1/3] + 
    (13*Pi^2*Zeta[3])/12 - (311*Log[2]^2*Zeta[3])/6 + 
    (659*Log[2]*Log[3]*Zeta[3])/12 - (889*Log[3]^2*Zeta[3])/48 + 
    (11*PolyLog[2, -1/2]*Zeta[3])/12 + (42109*Zeta[5])/576
 
G[-1, 0, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -8*G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, -1, 0, -1, 1/2] - (10*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1091*Pi^4*Log[2])/6480 - (223*Pi^2*Log[2]^3)/162 - (1043*Log[2]^5)/270 - 
    (473*Pi^4*Log[3])/2160 + (421*Pi^2*Log[2]^2*Log[3])/72 + 
    (139*Log[2]^4*Log[3])/36 - (131*Pi^2*Log[2]*Log[3]^2)/24 + 
    7*Log[2]^3*Log[3]^2 + (241*Pi^2*Log[3]^3)/144 - 
    (187*Log[2]^2*Log[3]^3)/12 + (499*Log[2]*Log[3]^4)/48 - 
    (1193*Log[3]^5)/480 - (4*Log[2]^3*PolyLog[2, -1/2])/3 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 4*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    4*Log[2]*Log[3]^2*PolyLog[2, -1/2] + Log[3]^3*PolyLog[2, -1/2] - 
    2*Log[2]*PolyLog[2, -1/2]^2 + 3*Log[3]*PolyLog[2, -1/2]^2 - 
    (2*Pi^2*PolyLog[3, -1/2])/3 + 4*Log[3]^2*PolyLog[3, -1/2] - 
    4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/3 + 
    27*Log[2]^2*PolyLog[3, 1/3] - 26*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    8*Log[3]^2*PolyLog[3, 1/3] - 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    52*Log[2]*PolyLog[4, -1/2] + 27*Log[3]*PolyLog[4, -1/2] + 
    (13*Log[2]*PolyLog[4, -1/3])/2 - (13*Log[3]*PolyLog[4, -1/3])/4 - 
    7*Log[2]*PolyLog[4, 1/3] - (3*Log[3]*PolyLog[4, 1/3])/2 - 
    (184*Log[2]*PolyLog[4, 1/2])/3 + (107*Log[3]*PolyLog[4, 1/2])/3 + 
    60*Log[2]*PolyLog[4, 2/3] - 41*Log[3]*PolyLog[4, 2/3] - 
    (238*PolyLog[5, -1/2])/3 - (35*PolyLog[5, -1/3])/2 + 11*PolyLog[5, 1/3] - 
    (892*PolyLog[5, 1/2])/9 - 72*PolyLog[5, 2/3] - 7*PolyLog[2, 3, -1/3] - 
    6*PolyLog[2, 3, 1/3] + (139*Pi^2*Zeta[3])/144 - 
    (191*Log[2]^2*Zeta[3])/4 + (307*Log[2]*Log[3]*Zeta[3])/6 - 
    (403*Log[3]^2*Zeta[3])/24 - (PolyLog[2, -1/2]*Zeta[3])/2 + 
    (15895*Zeta[5])/288
 
G[-1, 0, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] + 
    10*G[0, 0, -1, 0, -1, 1/2] + (52*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (991*Pi^4*Log[2])/12960 + (655*Pi^2*Log[2]^3)/162 + (4429*Log[2]^5)/540 + 
    (283*Pi^4*Log[3])/2160 - (851*Pi^2*Log[2]^2*Log[3])/72 - 
    (1217*Log[2]^4*Log[3])/144 + (131*Pi^2*Log[2]*Log[3]^2)/16 - 
    15*Log[2]^3*Log[3]^2 - (263*Pi^2*Log[3]^3)/144 + 
    (733*Log[2]^2*Log[3]^3)/24 - (551*Log[2]*Log[3]^4)/32 + 
    (3043*Log[3]^5)/960 + (Pi^2*Log[2]*PolyLog[2, -1/2])/3 + 
    (5*Log[2]^3*PolyLog[2, -1/2])/3 - 3*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    2*Log[2]*PolyLog[2, -1/2]^2 - 3*Log[3]*PolyLog[2, -1/2]^2 + 
    8*Log[2]*Log[3]*PolyLog[3, -1/2] - 8*Log[3]^2*PolyLog[3, -1/2] - 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 50*Log[2]^2*PolyLog[3, 1/3] + 
    (81*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (51*Log[3]^2*PolyLog[3, 1/3])/8 + 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 126*Log[2]*PolyLog[4, -1/2] - 
    (131*Log[3]*PolyLog[4, -1/2])/2 - (127*Log[2]*PolyLog[4, -1/3])/4 + 
    (157*Log[3]*PolyLog[4, -1/3])/8 + (65*Log[2]*PolyLog[4, 1/3])/2 - 
    (25*Log[3]*PolyLog[4, 1/3])/4 + (386*Log[2]*PolyLog[4, 1/2])/3 - 
    (262*Log[3]*PolyLog[4, 1/2])/3 - 112*Log[2]*PolyLog[4, 2/3] + 
    (115*Log[3]*PolyLog[4, 2/3])/2 + (466*PolyLog[5, -1/2])/3 + 
    (385*PolyLog[5, -1/3])/8 - (73*PolyLog[5, 1/3])/2 + 
    (1666*PolyLog[5, 1/2])/9 + 96*PolyLog[5, 2/3] + 
    (127*PolyLog[2, 3, -1/3])/8 - 23*PolyLog[2, 3, 1/3] - 
    (45*Pi^2*Zeta[3])/16 + (711*Log[2]^2*Zeta[3])/8 - 
    (1843*Log[2]*Log[3]*Zeta[3])/24 + (1967*Log[3]^2*Zeta[3])/96 - 
    (11*PolyLog[2, -1/2]*Zeta[3])/2 - (12581*Zeta[5])/576
 
G[-1, 0, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + 5*G[0, 0, 1, 0, -1, 1/2] + 
    (97*Pi^4*Log[2])/1440 + (3*Pi^2*Log[2]^3)/4 + (13*Log[2]^5)/10 - 
    (47*Pi^4*Log[3])/720 - (5*Pi^2*Log[2]^2*Log[3])/3 - 
    (21*Log[2]^4*Log[3])/16 + (5*Pi^2*Log[2]*Log[3]^2)/8 - 
    (13*Log[2]^3*Log[3]^2)/6 + (5*Pi^2*Log[3]^3)/144 + 
    (31*Log[2]^2*Log[3]^3)/8 - (3*Log[2]*Log[3]^4)/2 + (37*Log[3]^5)/960 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - (2*Log[2]^3*PolyLog[2, -1/2])/3 + 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/3 - 2*Log[2]^2*PolyLog[3, -1/2] + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - 2*Log[3]^2*PolyLog[3, -1/2] - 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 6*Log[2]^2*PolyLog[3, 1/3] + 
    (3*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + (15*Log[3]^2*PolyLog[3, 1/3])/8 + 
    21*Log[2]*PolyLog[4, -1/2] - (21*Log[3]*PolyLog[4, -1/2])/2 - 
    9*Log[2]*PolyLog[4, -1/3] + (51*Log[3]*PolyLog[4, -1/3])/8 + 
    7*Log[2]*PolyLog[4, 1/3] - (7*Log[3]*PolyLog[4, 1/3])/4 + 
    26*Log[2]*PolyLog[4, 1/2] - 17*Log[3]*PolyLog[4, 1/2] - 
    13*Log[2]*PolyLog[4, 2/3] + (5*Log[3]*PolyLog[4, 2/3])/2 + 
    26*PolyLog[5, -1/2] + (91*PolyLog[5, -1/3])/8 - (19*PolyLog[5, 1/3])/2 + 
    38*PolyLog[5, 1/2] + PolyLog[5, 2/3] + (21*PolyLog[2, 3, -1/3])/8 - 
    13*PolyLog[2, 3, 1/3] - (21*Pi^2*Zeta[3])/32 + 
    (161*Log[2]^2*Zeta[3])/12 - (91*Log[2]*Log[3]*Zeta[3])/12 + 
    (91*Log[3]^2*Zeta[3])/96 - (7*PolyLog[2, -1/2]*Zeta[3])/4 + 
    (2515*Zeta[5])/192
 
G[-1, 0, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (16*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (17*Pi^4*Log[2])/405 + (149*Pi^2*Log[2]^3)/81 + (713*Log[2]^5)/270 + 
    (13*Pi^4*Log[3])/135 - (49*Pi^2*Log[2]^2*Log[3])/9 - 
    (14*Log[2]^4*Log[3])/9 + (25*Pi^2*Log[2]*Log[3]^2)/6 - 
    9*Log[2]^3*Log[3]^2 - (13*Pi^2*Log[3]^3)/12 + (31*Log[2]^2*Log[3]^3)/2 - 
    9*Log[2]*Log[3]^4 + (221*Log[3]^5)/120 - 2*Log[2]^3*PolyLog[2, -1/2] + 
    4*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/3 - 2*Log[2]*PolyLog[2, -1/2]^2 - 
    4*Log[2]^2*PolyLog[3, -1/2] + 8*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    4*Log[3]^2*PolyLog[3, -1/2] - 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    24*Log[2]^2*PolyLog[3, 1/3] + 24*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    6*Log[3]^2*PolyLog[3, 1/3] + 44*Log[2]*PolyLog[4, -1/2] - 
    24*Log[3]*PolyLog[4, -1/2] - 10*Log[2]*PolyLog[4, -1/3] + 
    5*Log[3]*PolyLog[4, -1/3] + 12*Log[2]*PolyLog[4, 1/3] - 
    2*Log[3]*PolyLog[4, 1/3] + (128*Log[2]*PolyLog[4, 1/2])/3 - 
    (88*Log[3]*PolyLog[4, 1/2])/3 - 48*Log[2]*PolyLog[4, 2/3] + 
    28*Log[3]*PolyLog[4, 2/3] + (148*PolyLog[5, -1/2])/3 + 
    14*PolyLog[5, -1/3] - 10*PolyLog[5, 1/3] + (544*PolyLog[5, 1/2])/9 + 
    44*PolyLog[5, 2/3] + 5*PolyLog[2, 3, -1/3] - (5*Pi^2*Zeta[3])/6 + 
    37*Log[2]^2*Zeta[3] - 36*Log[2]*Log[3]*Zeta[3] + 11*Log[3]^2*Zeta[3] - 
    (8*PolyLog[2, -1/2]*Zeta[3])/3 - (227*Zeta[5])/9
 
G[-1, 0, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 12*G[0, -1, 0, -1, -1, 1/2] - 
    12*G[0, 0, -1, 0, -1, 1/2] - 8*G[0, 0, 1, 0, -1, 1/2] - 
    (323*Pi^4*Log[2])/540 + (14*Pi^2*Log[2]^3)/27 - (163*Log[2]^5)/90 + 
    (9*Pi^4*Log[3])/20 - (13*Pi^2*Log[2]^2*Log[3])/6 - 
    (3*Log[2]^4*Log[3])/2 + (14*Pi^2*Log[2]*Log[3]^2)/3 + 
    5*Log[2]^3*Log[3]^2 - (19*Pi^2*Log[3]^3)/9 + (17*Log[2]^2*Log[3]^3)/6 - 
    9*Log[2]*Log[3]^4 + (89*Log[3]^5)/24 + 2*Log[2]^3*PolyLog[2, -1/2] - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/3 - 4*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    6*Log[2]*PolyLog[2, -1/2]^2 - 4*Log[3]*PolyLog[2, -1/2]^2 - 
    12*Log[2]^2*PolyLog[3, -1/2] + 24*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    12*Log[3]^2*PolyLog[3, -1/2] + 12*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/3 + 8*Log[2]^2*PolyLog[3, 1/3] + 
    24*Log[2]*Log[3]*PolyLog[3, 1/3] - 22*Log[3]^2*PolyLog[3, 1/3] + 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 72*Log[2]*PolyLog[4, -1/2] + 
    36*Log[3]*PolyLog[4, -1/2] + 18*Log[2]*PolyLog[4, -1/3] - 
    9*Log[3]*PolyLog[4, -1/3] - 18*Log[3]*PolyLog[4, 1/3] - 
    72*Log[2]*PolyLog[4, 1/2] + 48*Log[3]*PolyLog[4, 1/2] - 
    12*Log[2]*PolyLog[4, 2/3] + 48*Log[3]*PolyLog[4, 2/3] - 
    104*PolyLog[5, -1/2] - 24*PolyLog[5, -1/3] - (320*PolyLog[5, 1/2])/3 + 
    72*PolyLog[5, 2/3] - 9*PolyLog[2, 3, -1/3] + 60*PolyLog[2, 3, 1/3] + 
    (41*Pi^2*Zeta[3])/36 - (229*Log[2]^2*Zeta[3])/6 + 
    15*Log[2]*Log[3]*Zeta[3] + (10*Log[3]^2*Zeta[3])/3 + 
    (26*PolyLog[2, -1/2]*Zeta[3])/3 - (595*Zeta[5])/6
 
G[-1, 0, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 8*G[0, -1, 0, -1, -1, 1/2] - 
    6*G[0, 0, -1, 0, -1, 1/2] - 4*G[0, 0, 1, 0, -1, 1/2] - 
    (19*Pi^4*Log[2])/60 + (29*Pi^2*Log[2]^3)/36 - (13*Log[2]^5)/20 + 
    (131*Pi^4*Log[3])/480 - (35*Pi^2*Log[2]^2*Log[3])/12 - 
    (Log[2]^4*Log[3])/6 + (95*Pi^2*Log[2]*Log[3]^2)/24 - Log[2]^3*Log[3]^2 - 
    (73*Pi^2*Log[3]^3)/48 + (41*Log[2]^2*Log[3]^3)/6 - 
    (385*Log[2]*Log[3]^4)/48 + (27*Log[3]^5)/10 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/3 - (Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    2*Log[2]*PolyLog[2, -1/2]^2 - 2*Log[3]*PolyLog[2, -1/2]^2 - 
    8*Log[2]^2*PolyLog[3, -1/2] + 16*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    8*Log[3]^2*PolyLog[3, -1/2] + 6*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/6 - (9*Log[2]^2*PolyLog[3, 1/3])/2 + 
    22*Log[2]*Log[3]*PolyLog[3, 1/3] - (59*Log[3]^2*PolyLog[3, 1/3])/4 + 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 29*Log[2]*PolyLog[4, -1/2] + 
    14*Log[3]*PolyLog[4, -1/2] + (15*Log[2]*PolyLog[4, -1/3])/2 - 
    (15*Log[3]*PolyLog[4, -1/3])/4 + 4*Log[2]*PolyLog[4, 1/3] - 
    (23*Log[3]*PolyLog[4, 1/3])/2 - 32*Log[2]*PolyLog[4, 1/2] + 
    22*Log[3]*PolyLog[4, 1/2] - 21*Log[2]*PolyLog[4, 2/3] + 
    36*Log[3]*PolyLog[4, 2/3] - 47*PolyLog[5, -1/2] - 10*PolyLog[5, -1/3] - 
    (5*PolyLog[5, 1/3])/2 - 42*PolyLog[5, 1/2] + 55*PolyLog[5, 2/3] - 
    (15*PolyLog[2, 3, -1/3])/4 + 35*PolyLog[2, 3, 1/3] + 
    (73*Pi^2*Zeta[3])/144 - (127*Log[2]^2*Zeta[3])/12 - 
    (7*Log[2]*Log[3]*Zeta[3])/6 + (223*Log[3]^2*Zeta[3])/48 + 
    (55*PolyLog[2, -1/2]*Zeta[3])/12 - (4481*Zeta[5])/64
 
G[-1, 0, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -8*G[0, -1, 0, -1, -1, 1/2] + 
    8*G[0, 0, -1, 0, -1, 1/2] + (16*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (323*Pi^4*Log[2])/810 - (28*Pi^2*Log[2]^3)/81 + (163*Log[2]^5)/135 - 
    (3*Pi^4*Log[3])/10 + (3*Pi^2*Log[2]^2*Log[3])/2 + (4*Log[2]^4*Log[3])/3 - 
    3*Pi^2*Log[2]*Log[3]^2 - (14*Log[2]^3*Log[3]^2)/3 + (4*Pi^2*Log[3]^3)/3 - 
    (Log[2]^2*Log[3]^3)/6 + 5*Log[2]*Log[3]^4 - (9*Log[3]^5)/4 - 
    (4*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/3 + 
    4*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 4*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    Log[3]^3*PolyLog[2, -1/2] - 4*Log[2]*PolyLog[2, -1/2]^2 + 
    4*Log[3]*PolyLog[2, -1/2]^2 + 8*Log[2]^2*PolyLog[3, -1/2] - 
    16*Log[2]*Log[3]*PolyLog[3, -1/2] + 8*Log[3]^2*PolyLog[3, -1/2] - 
    8*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/3 - 
    6*Log[2]^2*PolyLog[3, 1/3] - 12*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    13*Log[3]^2*PolyLog[3, 1/3] - 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    48*Log[2]*PolyLog[4, -1/2] - 24*Log[3]*PolyLog[4, -1/2] - 
    10*Log[2]*PolyLog[4, -1/3] + 5*Log[3]*PolyLog[4, -1/3] + 
    12*Log[3]*PolyLog[4, 1/3] + 48*Log[2]*PolyLog[4, 1/2] - 
    32*Log[3]*PolyLog[4, 1/2] + 8*Log[2]*PolyLog[4, 2/3] - 
    32*Log[3]*PolyLog[4, 2/3] + (208*PolyLog[5, -1/2])/3 + 
    16*PolyLog[5, -1/3] + (640*PolyLog[5, 1/2])/9 - 48*PolyLog[5, 2/3] + 
    6*PolyLog[2, 3, -1/3] - 40*PolyLog[2, 3, 1/3] - (23*Pi^2*Zeta[3])/36 + 
    (157*Log[2]^2*Zeta[3])/6 - (43*Log[2]*Log[3]*Zeta[3])/3 - 
    (5*Log[3]^2*Zeta[3])/12 - (13*PolyLog[2, -1/2]*Zeta[3])/3 + 
    (595*Zeta[5])/9
 
G[-1, 0, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[3]^3)/18 + (Log[2]^2*Log[3]^3)/6 - 
    (Log[2]*Log[3]^4)/4 + Log[3]^5/8 + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    Log[3]^2*PolyLog[3, 1/3] - Log[3]*PolyLog[4, -1/3] - PolyLog[5, -1/3] + 
    (13*Log[3]^2*Zeta[3])/12
 
G[-1, 0, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (4*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (683*Pi^4*Log[2])/3240 - (95*Pi^2*Log[2]^3)/162 - (4*Log[2]^5)/27 - 
    (67*Pi^4*Log[3])/360 + (11*Pi^2*Log[2]^2*Log[3])/6 + 
    (5*Log[2]^4*Log[3])/4 - (13*Pi^2*Log[2]*Log[3]^2)/6 - 
    (Log[2]^3*Log[3]^2)/3 + (7*Pi^2*Log[3]^3)/9 - (7*Log[2]^2*Log[3]^3)/2 + 
    (17*Log[2]*Log[3]^4)/4 - (67*Log[3]^5)/48 - (2*Log[2]^3*PolyLog[2, -1/2])/
     3 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 2*Log[2]*Log[3]^2*
     PolyLog[2, -1/2] + (2*Log[3]^3*PolyLog[2, -1/2])/3 - 
    2*Log[2]*PolyLog[2, -1/2]^2 + 2*Log[3]*PolyLog[2, -1/2]^2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 8*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    4*Log[3]^2*PolyLog[3, -1/2] - 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    3*Log[2]^2*PolyLog[3, 1/3] - 12*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (15*Log[3]^2*PolyLog[3, 1/3])/2 - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    12*Log[2]*PolyLog[4, -1/2] - 6*Log[3]*PolyLog[4, -1/2] - 
    2*Log[2]*PolyLog[4, -1/3] + (Log[3]*PolyLog[4, -1/3])/2 - 
    6*Log[2]*PolyLog[4, 1/3] + 9*Log[3]*PolyLog[4, 1/3] + 
    12*Log[2]*PolyLog[4, 1/2] - 8*Log[3]*PolyLog[4, 1/2] + 
    16*Log[2]*PolyLog[4, 2/3] - 22*Log[3]*PolyLog[4, 2/3] + 
    (64*PolyLog[5, -1/2])/3 + (7*PolyLog[5, -1/3])/2 + 5*PolyLog[5, 1/3] + 
    (160*PolyLog[5, 1/2])/9 - 36*PolyLog[5, 2/3] + 
    (3*PolyLog[2, 3, -1/3])/2 - 20*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/4 + 
    (61*Log[2]^2*Zeta[3])/12 - (2*Log[2]*Log[3]*Zeta[3])/3 - 
    (31*Log[3]^2*Zeta[3])/24 + (11651*Zeta[5])/288
 
G[-1, 0, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    8*G[0, 0, -1, 0, -1, 1/2] + (10*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (23*Pi^4*Log[2])/81 + (71*Pi^2*Log[2]^3)/81 + (1207*Log[2]^5)/540 - 
    (359*Pi^4*Log[3])/2160 - (79*Pi^2*Log[2]^2*Log[3])/36 - 
    (49*Log[2]^4*Log[3])/72 + (Pi^2*Log[2]*Log[3]^2)/2 - 
    (37*Log[2]^3*Log[3]^2)/6 + (5*Pi^2*Log[3]^3)/24 + 
    (85*Log[2]^2*Log[3]^3)/12 - (35*Log[2]*Log[3]^4)/24 - (49*Log[3]^5)/120 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/3 - (4*Log[2]^3*PolyLog[2, -1/2])/3 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 3*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    3*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (2*Log[3]^3*PolyLog[2, -1/2])/3 - 
    3*Log[2]*PolyLog[2, -1/2]^2 + 2*Log[3]*PolyLog[2, -1/2]^2 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]^2*PolyLog[3, -1/2] - 8*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/6 - (27*Log[2]^2*PolyLog[3, 1/3])/2 + 
    3*Log[2]*Log[3]*PolyLog[3, 1/3] + (11*Log[3]^2*PolyLog[3, 1/3])/2 - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 51*Log[2]*PolyLog[4, -1/2] - 
    27*Log[3]*PolyLog[4, -1/2] - 10*Log[2]*PolyLog[4, -1/3] + 
    5*Log[3]*PolyLog[4, -1/3] + Log[2]*PolyLog[4, 1/3] + 
    10*Log[3]*PolyLog[4, 1/3] + (146*Log[2]*PolyLog[4, 1/2])/3 - 
    (88*Log[3]*PolyLog[4, 1/2])/3 - 19*Log[2]*PolyLog[4, 2/3] - 
    5*Log[3]*PolyLog[4, 2/3] + (193*PolyLog[5, -1/2])/3 + 
    14*PolyLog[5, -1/3] + 2*PolyLog[5, 1/3] + (586*PolyLog[5, 1/2])/9 - 
    9*PolyLog[5, 2/3] + 6*PolyLog[2, 3, -1/3] - 25*PolyLog[2, 3, 1/3] - 
    (127*Pi^2*Zeta[3])/144 + (377*Log[2]^2*Zeta[3])/12 - 
    (149*Log[2]*Log[3]*Zeta[3])/6 + (125*Log[3]^2*Zeta[3])/24 - 
    (11*PolyLog[2, -1/2]*Zeta[3])/2 + (3721*Zeta[5])/144
 
G[-1, 0, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, -1, 0, -1, -1, 1/2] - 
    6*G[0, 0, -1, 0, -1, 1/2] - (10*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (395*Pi^4*Log[2])/1296 + (271*Pi^2*Log[2]^3)/324 + (7*Log[2]^5)/270 + 
    (59*Pi^4*Log[3])/216 - (23*Pi^2*Log[2]^2*Log[3])/9 - 
    (55*Log[2]^4*Log[3])/36 + (13*Pi^2*Log[2]*Log[3]^2)/4 - 
    (Log[2]^3*Log[3]^2)/6 - (23*Pi^2*Log[3]^3)/18 + 
    (37*Log[2]^2*Log[3]^3)/6 - (57*Log[2]*Log[3]^4)/8 + (569*Log[3]^5)/240 + 
    Log[2]^3*PolyLog[2, -1/2] - 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + 3*Log[2]*PolyLog[2, -1/2]^2 - 
    2*Log[3]*PolyLog[2, -1/2]^2 - 6*Log[2]^2*PolyLog[3, -1/2] + 
    12*Log[2]*Log[3]*PolyLog[3, -1/2] - 6*Log[3]^2*PolyLog[3, -1/2] + 
    6*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 4*Log[2]^2*PolyLog[3, 1/3] + 
    20*Log[2]*Log[3]*PolyLog[3, 1/3] - (27*Log[3]^2*PolyLog[3, 1/3])/2 + 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 20*Log[2]*PolyLog[4, -1/2] + 
    10*Log[3]*PolyLog[4, -1/2] + 5*Log[2]*PolyLog[4, -1/3] - 
    (7*Log[3]*PolyLog[4, -1/3])/2 + 8*Log[2]*PolyLog[4, 1/3] - 
    12*Log[3]*PolyLog[4, 1/3] - (70*Log[2]*PolyLog[4, 1/2])/3 + 
    (40*Log[3]*PolyLog[4, 1/2])/3 - 22*Log[2]*PolyLog[4, 2/3] + 
    32*Log[3]*PolyLog[4, 2/3] - (106*PolyLog[5, -1/2])/3 - 
    (17*PolyLog[5, -1/3])/2 - 4*PolyLog[5, 1/3] - (340*PolyLog[5, 1/2])/9 + 
    52*PolyLog[5, 2/3] - (5*PolyLog[2, 3, -1/3])/2 + 30*PolyLog[2, 3, 1/3] + 
    (7*Pi^2*Zeta[3])/24 - (211*Log[2]^2*Zeta[3])/24 - 
    (7*Log[2]*Log[3]*Zeta[3])/6 + (35*Log[3]^2*Zeta[3])/8 - 
    (16445*Zeta[5])/288
 
G[-1, 0, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, 1, 0, -1, 1/2] - (59*Pi^4*Log[2])/2160 - (Pi^2*Log[2]^3)/108 - 
    (29*Log[2]^5)/180 + (11*Pi^4*Log[3])/540 - (7*Pi^2*Log[2]^2*Log[3])/18 + 
    (13*Log[2]^4*Log[3])/72 + (3*Pi^2*Log[2]*Log[3]^2)/4 - 
    (Log[2]^3*Log[3]^2)/6 - (Pi^2*Log[3]^3)/3 + (13*Log[2]^2*Log[3]^3)/12 - 
    (35*Log[2]*Log[3]^4)/24 + (8*Log[3]^5)/15 - (Log[2]^3*PolyLog[2, -1/2])/
     3 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*
     PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    2*Log[2]^2*PolyLog[3, -1/2] + 4*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    2*Log[3]^2*PolyLog[3, -1/2] + (Log[2]^2*PolyLog[3, 1/3])/2 + 
    3*Log[2]*Log[3]*PolyLog[3, 1/3] - (5*Log[3]^2*PolyLog[3, 1/3])/2 - 
    7*Log[2]*PolyLog[4, -1/2] + 3*Log[3]*PolyLog[4, -1/2] + 
    3*Log[2]*PolyLog[4, -1/3] - 2*Log[3]*PolyLog[4, -1/3] - 
    4*Log[2]*PolyLog[4, 1/3] + 2*Log[3]*PolyLog[4, 1/3] - 
    6*Log[2]*PolyLog[4, 1/2] + (16*Log[3]*PolyLog[4, 1/2])/3 - 
    Log[2]*PolyLog[4, 2/3] + 5*Log[3]*PolyLog[4, 2/3] - 11*PolyLog[5, -1/2] - 
    4*PolyLog[5, -1/3] + 5*PolyLog[5, 1/3] - (44*PolyLog[5, 1/2])/3 + 
    5*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3] + 5*PolyLog[2, 3, 1/3] + 
    (Pi^2*Zeta[3])/48 - (7*Log[2]^2*Zeta[3])/8 - (17*Log[2]*Log[3]*Zeta[3])/
     6 + (5*Log[3]^2*Zeta[3])/2 - (157*Zeta[5])/16
 
G[-1, 0, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, 1, 0, -1, 1/2] - (113*Pi^4*Log[2])/720 + 
    (77*Pi^2*Log[2]^3)/216 - (107*Log[2]^5)/45 + (491*Pi^4*Log[3])/4320 + 
    (43*Pi^2*Log[2]^2*Log[3])/72 + (235*Log[2]^4*Log[3])/144 + 
    (Pi^2*Log[2]*Log[3]^2)/16 + (5*Log[2]^3*Log[3]^2)/4 - 
    (2*Pi^2*Log[3]^3)/9 - (29*Log[2]^2*Log[3]^3)/24 - 
    (31*Log[2]*Log[3]^4)/32 + (217*Log[3]^5)/320 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - (5*Log[2]^3*PolyLog[2, -1/2])/3 + 
    4*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/3 - Log[2]*PolyLog[2, -1/2]^2 - 
    10*Log[2]^2*PolyLog[3, -1/2] + 12*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    4*Log[3]^2*PolyLog[3, -1/2] + (15*Log[2]^2*PolyLog[3, 1/3])/2 + 
    (5*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (45*Log[3]^2*PolyLog[3, 1/3])/8 - 
    53*Log[2]*PolyLog[4, -1/2] + (37*Log[3]*PolyLog[4, -1/2])/2 + 
    (Log[2]*PolyLog[4, -1/3])/4 - (Log[3]*PolyLog[4, -1/3])/8 + 
    (15*Log[2]*PolyLog[4, 1/3])/2 - (47*Log[3]*PolyLog[4, 1/3])/4 - 
    (160*Log[2]*PolyLog[4, 1/2])/3 + (62*Log[3]*PolyLog[4, 1/2])/3 + 
    9*Log[2]*PolyLog[4, 2/3] + (15*Log[3]*PolyLog[4, 2/3])/2 - 
    60*PolyLog[5, -1/2] - (71*PolyLog[5, -1/3])/8 - 3*PolyLog[5, 1/3] - 
    (151*PolyLog[5, 1/2])/3 + 6*PolyLog[5, 2/3] - (47*PolyLog[2, 3, -1/3])/
     8 + 20*PolyLog[2, 3, 1/3] + (47*Pi^2*Zeta[3])/48 - 
    (63*Log[2]^2*Zeta[3])/2 + (189*Log[2]*Log[3]*Zeta[3])/8 - 
    (157*Log[3]^2*Zeta[3])/32 + (PolyLog[2, -1/2]*Zeta[3])/4 - 
    (673*Zeta[5])/24
 
G[-1, 0, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 12*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + (26*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (6503*Pi^4*Log[2])/12960 + (961*Pi^2*Log[2]^3)/324 + (602*Log[2]^5)/135 + 
    (223*Pi^4*Log[3])/432 - (733*Pi^2*Log[2]^2*Log[3])/72 - 
    (931*Log[2]^4*Log[3])/144 + (467*Pi^2*Log[2]*Log[3]^2)/48 - 
    (15*Log[2]^3*Log[3]^2)/2 - (143*Pi^2*Log[3]^3)/48 + 
    (201*Log[2]^2*Log[3]^3)/8 - (1951*Log[2]*Log[3]^4)/96 + 
    (1037*Log[3]^5)/192 + (7*Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/3 - 5*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    3*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (2*Log[3]^3*PolyLog[2, -1/2])/3 + 
    6*Log[2]*PolyLog[2, -1/2]^2 - 5*Log[3]*PolyLog[2, -1/2]^2 + 
    (2*Pi^2*PolyLog[3, -1/2])/3 - 8*Log[2]^2*PolyLog[3, -1/2] + 
    24*Log[2]*Log[3]*PolyLog[3, -1/2] - 14*Log[3]^2*PolyLog[3, -1/2] + 
    10*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/2 - 
    31*Log[2]^2*PolyLog[3, 1/3] + (107*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (197*Log[3]^2*PolyLog[3, 1/3])/8 + 6*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    38*Log[2]*PolyLog[4, -1/2] - (25*Log[3]*PolyLog[4, -1/2])/2 - 
    (29*Log[2]*PolyLog[4, -1/3])/4 + (75*Log[3]*PolyLog[4, -1/3])/8 + 
    (59*Log[2]*PolyLog[4, 1/3])/2 - (119*Log[3]*PolyLog[4, 1/3])/4 + 
    (160*Log[2]*PolyLog[4, 1/2])/3 - (50*Log[3]*PolyLog[4, 1/2])/3 - 
    92*Log[2]*PolyLog[4, 2/3] + (169*Log[3]*PolyLog[4, 2/3])/2 + 
    (152*PolyLog[5, -1/2])/3 + (159*PolyLog[5, -1/3])/8 - 
    (77*PolyLog[5, 1/3])/2 + (986*PolyLog[5, 1/2])/9 + 140*PolyLog[5, 2/3] + 
    (29*PolyLog[2, 3, -1/3])/8 + 39*PolyLog[2, 3, 1/3] - 
    (11*Pi^2*Zeta[3])/72 + (817*Log[2]^2*Zeta[3])/24 - 
    (953*Log[2]*Log[3]*Zeta[3])/24 + (1399*Log[3]^2*Zeta[3])/96 + 
    (55*PolyLog[2, -1/2]*Zeta[3])/12 - (80647*Zeta[5])/576
 
G[-1, 0, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 7*G[0, -1, 0, -1, -1, 1/2] - 
    3*G[0, 0, -1, 0, -1, 1/2] + (17*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (991*Pi^4*Log[2])/2592 + (1295*Pi^2*Log[2]^3)/648 + (461*Log[2]^5)/540 + 
    (389*Pi^4*Log[3])/1080 - (193*Pi^2*Log[2]^2*Log[3])/36 - 
    (257*Log[2]^4*Log[3])/144 + (127*Pi^2*Log[2]*Log[3]^2)/24 - 
    (59*Log[2]^3*Log[3]^2)/12 - (61*Pi^2*Log[3]^3)/36 + 
    (113*Log[2]^2*Log[3]^3)/8 - (569*Log[2]*Log[3]^4)/48 + 
    (3169*Log[3]^5)/960 - (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - 
    (Log[2]^3*PolyLog[2, -1/2])/6 - (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 - (Log[3]^3*PolyLog[2, -1/2])/6 + (5*Log[2]*PolyLog[2, -1/2]^2)/2 - 
    (5*Log[3]*PolyLog[2, -1/2]^2)/2 + (Pi^2*PolyLog[3, -1/2])/3 - 
    11*Log[2]^2*PolyLog[3, -1/2] + 18*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    9*Log[3]^2*PolyLog[3, -1/2] + 7*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/4 - (33*Log[2]^2*PolyLog[3, 1/3])/2 + 
    (65*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (135*Log[3]^2*PolyLog[3, 1/3])/8 + 
    3*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 7*Log[2]*PolyLog[4, -1/2] + 
    (9*Log[3]*PolyLog[4, -1/2])/2 - (9*Log[2]*PolyLog[4, -1/3])/2 + 
    (41*Log[3]*PolyLog[4, -1/3])/8 + 23*Log[2]*PolyLog[4, 1/3] - 
    (97*Log[3]*PolyLog[4, 1/3])/4 - (16*Log[2]*PolyLog[4, 1/2])/3 + 
    (11*Log[3]*PolyLog[4, 1/2])/3 - 48*Log[2]*PolyLog[4, 2/3] + 
    (101*Log[3]*PolyLog[4, 2/3])/2 + (32*PolyLog[5, -1/2])/3 + 
    (55*PolyLog[5, -1/3])/8 - 24*PolyLog[5, 1/3] + (359*PolyLog[5, 1/2])/9 + 
    83*PolyLog[5, 2/3] - (5*PolyLog[2, 3, -1/3])/8 + 32*PolyLog[2, 3, 1/3] + 
    (119*Pi^2*Zeta[3])/288 - (Log[2]^2*Zeta[3])/24 - 
    (91*Log[2]*Log[3]*Zeta[3])/12 + (143*Log[3]^2*Zeta[3])/32 + 
    (7*PolyLog[2, -1/2]*Zeta[3])/2 - (49351*Zeta[5])/576
 
G[-1, 0, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -12*G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, -1, 0, -1, 1/2] + (4*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1033*Pi^4*Log[2])/6480 - (214*Pi^2*Log[2]^3)/81 - (1021*Log[2]^5)/270 - 
    (25*Pi^4*Log[3])/96 + (26*Pi^2*Log[2]^2*Log[3])/3 + 
    (11*Log[2]^4*Log[3])/2 - (63*Pi^2*Log[2]*Log[3]^2)/8 + 
    (31*Log[2]^3*Log[3]^2)/6 + (347*Pi^2*Log[3]^3)/144 - 
    (107*Log[2]^2*Log[3]^3)/6 + (673*Log[2]*Log[3]^4)/48 - 
    (355*Log[3]^5)/96 - (Pi^2*Log[2]*PolyLog[2, -1/2])/3 - 
    (4*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/3 + 
    5*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 5*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (4*Log[3]^3*PolyLog[2, -1/2])/3 - 4*Log[2]*PolyLog[2, -1/2]^2 + 
    5*Log[3]*PolyLog[2, -1/2]^2 - (2*Pi^2*PolyLog[3, -1/2])/3 + 
    8*Log[2]^2*PolyLog[3, -1/2] - 16*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    10*Log[3]^2*PolyLog[3, -1/2] - 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/2 + 25*Log[2]^2*PolyLog[3, 1/3] - 
    32*Log[2]*Log[3]*PolyLog[3, 1/3] + 13*Log[3]^2*PolyLog[3, 1/3] - 
    6*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 36*Log[2]*PolyLog[4, -1/2] + 
    22*Log[3]*PolyLog[4, -1/2] + (7*Log[2]*PolyLog[4, -1/3])/2 - 
    (7*Log[3]*PolyLog[4, -1/3])/4 - Log[2]*PolyLog[4, 1/3] - 
    (3*Log[3]*PolyLog[4, 1/3])/2 - 36*Log[2]*PolyLog[4, 1/2] + 
    16*Log[3]*PolyLog[4, 1/2] + 72*Log[2]*PolyLog[4, 2/3] - 
    58*Log[3]*PolyLog[4, 2/3] - (104*PolyLog[5, -1/2])/3 - 
    8*PolyLog[5, -1/3] + PolyLog[5, 1/3] - (416*PolyLog[5, 1/2])/9 - 
    92*PolyLog[5, 2/3] - (9*PolyLog[2, 3, -1/3])/2 - 20*PolyLog[2, 3, 1/3] + 
    (97*Pi^2*Zeta[3])/144 - (875*Log[2]^2*Zeta[3])/24 + 
    (533*Log[2]*Log[3]*Zeta[3])/12 - (821*Log[3]^2*Zeta[3])/48 + 
    (11*PolyLog[2, -1/2]*Zeta[3])/12 + (25445*Zeta[5])/288
 
G[-1, 0, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + 8*G[0, 0, 1, 0, -1, 1/2] + 
    (23*Pi^4*Log[2])/540 + (47*Pi^2*Log[2]^3)/54 + (467*Log[2]^5)/180 - 
    (Pi^4*Log[3])/90 - (17*Pi^2*Log[2]^2*Log[3])/6 - (5*Log[2]^4*Log[3])/3 + 
    (3*Pi^2*Log[2]*Log[3]^2)/2 - (17*Log[2]^3*Log[3]^2)/3 - 
    (Pi^2*Log[3]^3)/8 + (53*Log[2]^2*Log[3]^3)/6 - (47*Log[2]*Log[3]^4)/12 + 
    (17*Log[3]^5)/40 - (Log[2]^3*PolyLog[2, -1/2])/3 + 
    (Log[3]^3*PolyLog[2, -1/2])/3 - Log[2]*PolyLog[2, -1/2]^2 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 17*Log[2]^2*PolyLog[3, 1/3] + 
    10*Log[2]*Log[3]*PolyLog[3, 1/3] - (Log[3]^2*PolyLog[3, 1/3])/2 + 
    44*Log[2]*PolyLog[4, -1/2] - 24*Log[3]*PolyLog[4, -1/2] - 
    12*Log[2]*PolyLog[4, -1/3] + (35*Log[3]*PolyLog[4, -1/3])/4 + 
    14*Log[2]*PolyLog[4, 1/3] - (17*Log[3]*PolyLog[4, 1/3])/2 + 
    56*Log[2]*PolyLog[4, 1/2] - 32*Log[3]*PolyLog[4, 1/2] - 
    30*Log[2]*PolyLog[4, 2/3] + 10*Log[3]*PolyLog[4, 2/3] + 
    56*PolyLog[5, -1/2] + (83*PolyLog[5, -1/3])/4 - (47*PolyLog[5, 1/3])/2 + 
    (272*PolyLog[5, 1/2])/3 + 20*PolyLog[5, 2/3] + 6*PolyLog[2, 3, -1/3] - 
    14*PolyLog[2, 3, 1/3] - (3*Pi^2*Zeta[3])/4 + (63*Log[2]^2*Zeta[3])/2 - 
    22*Log[2]*Log[3]*Zeta[3] + (169*Log[3]^2*Zeta[3])/48 - (153*Zeta[5])/32
 
G[-1, 0, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -7*G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] + (13*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1679*Pi^4*Log[2])/12960 - (191*Pi^2*Log[2]^3)/648 - (17*Log[2]^5)/54 - 
    (35*Pi^4*Log[3])/288 + (43*Pi^2*Log[2]^2*Log[3])/24 + 
    (79*Log[2]^4*Log[3])/48 - (61*Pi^2*Log[2]*Log[3]^2)/24 - 
    (7*Log[2]^3*Log[3]^2)/4 + (37*Pi^2*Log[3]^3)/36 - 
    (15*Log[2]^2*Log[3]^3)/8 + (175*Log[2]*Log[3]^4)/48 - 
    (1339*Log[3]^5)/960 - (5*Log[2]^3*PolyLog[2, -1/2])/6 + 
    (5*Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (5*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (5*Log[3]^3*PolyLog[2, -1/2])/
     6 - (5*Log[2]*PolyLog[2, -1/2]^2)/2 + (5*Log[3]*PolyLog[2, -1/2]^2)/2 + 
    5*Log[2]^2*PolyLog[3, -1/2] - 10*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    5*Log[3]^2*PolyLog[3, -1/2] - 3*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Log[2]^2*PolyLog[3, 1/3])/2 - (13*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (41*Log[3]^2*PolyLog[3, 1/3])/8 - 3*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    13*Log[2]*PolyLog[4, -1/2] - (11*Log[3]*PolyLog[4, -1/2])/2 - 
    (13*Log[2]*PolyLog[4, -1/3])/2 + (37*Log[3]*PolyLog[4, -1/3])/8 + 
    11*Log[2]*PolyLog[4, 1/3] - (29*Log[3]*PolyLog[4, 1/3])/4 + 
    11*Log[2]*PolyLog[4, 1/2] - 10*Log[3]*PolyLog[4, 1/2] + 
    12*Log[2]*PolyLog[4, 2/3] - (39*Log[3]*PolyLog[4, 2/3])/2 + 
    (58*PolyLog[5, -1/2])/3 + (67*PolyLog[5, -1/3])/8 - 13*PolyLog[5, 1/3] + 
    (268*PolyLog[5, 1/2])/9 - 27*PolyLog[5, 2/3] + 
    (15*PolyLog[2, 3, -1/3])/8 - 17*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/48 - 
    (35*Log[2]^2*Zeta[3])/48 + (59*Log[2]*Log[3]*Zeta[3])/6 - 
    (667*Log[3]^2*Zeta[3])/96 + (21163*Zeta[5])/576
 
G[-1, 0, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -5*G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + (4*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (787*Pi^4*Log[2])/6480 - (497*Pi^2*Log[2]^3)/648 - (287*Log[2]^5)/135 - 
    (91*Pi^4*Log[3])/540 + (127*Pi^2*Log[2]^2*Log[3])/36 + 
    (175*Log[2]^4*Log[3])/72 - (83*Pi^2*Log[2]*Log[3]^2)/24 + 
    (35*Log[2]^3*Log[3]^2)/12 + (79*Pi^2*Log[3]^3)/72 - 
    (25*Log[2]^2*Log[3]^3)/3 + (151*Log[2]*Log[3]^4)/24 - 
    (791*Log[3]^5)/480 - (7*Log[2]^3*PolyLog[2, -1/2])/6 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + (7*Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 - (7*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + 
    (5*Log[3]^3*PolyLog[2, -1/2])/6 - (5*Log[2]*PolyLog[2, -1/2]^2)/2 + 
    (5*Log[3]*PolyLog[2, -1/2]^2)/2 - (Pi^2*PolyLog[3, -1/2])/3 + 
    Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    3*Log[3]^2*PolyLog[3, -1/2] - 5*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/4 + (29*Log[2]^2*PolyLog[3, 1/3])/2 - 
    16*Log[2]*Log[3]*PolyLog[3, 1/3] + (25*Log[3]^2*PolyLog[3, 1/3])/4 - 
    3*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 24*Log[2]*PolyLog[4, -1/2] + 
    10*Log[3]*PolyLog[4, -1/2] + Log[2]*PolyLog[4, -1/3] - 
    (Log[3]*PolyLog[4, -1/3])/2 - 3*Log[2]*PolyLog[4, 1/3] + 
    Log[3]*PolyLog[4, 1/3] - (92*Log[2]*PolyLog[4, 1/2])/3 + 
    (40*Log[3]*PolyLog[4, 1/2])/3 + 35*Log[2]*PolyLog[4, 2/3] - 
    27*Log[3]*PolyLog[4, 2/3] - (110*PolyLog[5, -1/2])/3 - 
    7*PolyLog[5, -1/3] + (13*PolyLog[5, 1/3])/2 - (443*PolyLog[5, 1/2])/9 - 
    48*PolyLog[5, 2/3] - (13*PolyLog[2, 3, -1/3])/4 - 9*PolyLog[2, 3, 1/3] + 
    (65*Pi^2*Zeta[3])/144 - (281*Log[2]^2*Zeta[3])/12 + 
    (105*Log[2]*Log[3]*Zeta[3])/4 - (145*Log[3]^2*Zeta[3])/16 - 
    (7*PolyLog[2, -1/2]*Zeta[3])/4 + (1579*Zeta[5])/36
 
G[-1, 0, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 5*G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + (20*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (653*Pi^4*Log[2])/3240 + (637*Pi^2*Log[2]^3)/324 + (3697*Log[2]^5)/1080 + 
    (113*Pi^4*Log[3])/540 - (56*Pi^2*Log[2]^2*Log[3])/9 - 
    (305*Log[2]^4*Log[3])/72 + (21*Pi^2*Log[2]*Log[3]^2)/4 - 
    (73*Log[2]^3*Log[3]^2)/12 - (35*Pi^2*Log[3]^3)/24 + 
    (191*Log[2]^2*Log[3]^3)/12 - (269*Log[2]*Log[3]^4)/24 + 
    (107*Log[3]^5)/40 + (7*Log[2]^3*PolyLog[2, -1/2])/6 - 
    (5*Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (5*Log[2]*PolyLog[2, -1/2]^2)/2 - (5*Log[3]*PolyLog[2, -1/2]^2)/2 - 
    3*Log[2]^2*PolyLog[3, -1/2] + 10*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    7*Log[3]^2*PolyLog[3, -1/2] + 3*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (45*Log[2]^2*PolyLog[3, 1/3])/2 + 28*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (21*Log[3]^2*PolyLog[3, 1/3])/2 + 3*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    41*Log[2]*PolyLog[4, -1/2] - 20*Log[3]*PolyLog[4, -1/2] - 
    10*Log[2]*PolyLog[4, -1/3] + (31*Log[3]*PolyLog[4, -1/3])/4 + 
    18*Log[2]*PolyLog[4, 1/3] - (25*Log[3]*PolyLog[4, 1/3])/2 + 
    (140*Log[2]*PolyLog[4, 1/2])/3 - (80*Log[3]*PolyLog[4, 1/2])/3 - 
    58*Log[2]*PolyLog[4, 2/3] + 43*Log[3]*PolyLog[4, 2/3] + 
    (149*PolyLog[5, -1/2])/3 + (71*PolyLog[5, -1/3])/4 - 
    (45*PolyLog[5, 1/3])/2 + (680*PolyLog[5, 1/2])/9 + 71*PolyLog[5, 2/3] + 
    5*PolyLog[2, 3, -1/3] + 8*PolyLog[2, 3, 1/3] - (41*Pi^2*Zeta[3])/48 + 
    (385*Log[2]^2*Zeta[3])/12 - (95*Log[2]*Log[3]*Zeta[3])/3 + 
    (159*Log[3]^2*Zeta[3])/16 - (7285*Zeta[5])/144
 
G[-1, 0, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, 0, 1, 0, -1, 1/2] - (23*Pi^4*Log[2])/480 + 
    (49*Pi^2*Log[2]^3)/72 + (59*Log[2]^5)/120 + (187*Pi^4*Log[3])/4320 - 
    (109*Pi^2*Log[2]^2*Log[3])/72 - (73*Log[2]^4*Log[3])/144 + 
    (25*Pi^2*Log[2]*Log[3]^2)/24 - (13*Log[2]^3*Log[3]^2)/6 - 
    (2*Pi^2*Log[3]^3)/9 + (35*Log[2]^2*Log[3]^3)/8 - 
    (45*Log[2]*Log[3]^4)/16 + (581*Log[3]^5)/960 - 
    (Log[2]^3*PolyLog[2, -1/2])/3 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    2*Log[2]^2*PolyLog[3, -1/2] + 4*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    2*Log[3]^2*PolyLog[3, -1/2] - (11*Log[2]^2*PolyLog[3, 1/3])/2 + 
    (15*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (23*Log[3]^2*PolyLog[3, 1/3])/8 + 
    7*Log[2]*PolyLog[4, -1/2] - (7*Log[3]*PolyLog[4, -1/2])/2 - 
    (9*Log[2]*PolyLog[4, -1/3])/2 + (29*Log[3]*PolyLog[4, -1/3])/8 + 
    9*Log[2]*PolyLog[4, 1/3] - (29*Log[3]*PolyLog[4, 1/3])/4 + 
    6*Log[2]*PolyLog[4, 1/2] - (14*Log[3]*PolyLog[4, 1/2])/3 - 
    13*Log[2]*PolyLog[4, 2/3] + (19*Log[3]*PolyLog[4, 2/3])/2 + 
    10*PolyLog[5, -1/2] + (43*PolyLog[5, -1/3])/8 - 9*PolyLog[5, 1/3] + 
    19*PolyLog[5, 1/2] + 15*PolyLog[5, 2/3] + (7*PolyLog[2, 3, -1/3])/8 + 
    PolyLog[2, 3, 1/3] - (7*Pi^2*Zeta[3])/96 + (13*Log[2]^2*Zeta[3])/4 - 
    (11*Log[2]*Log[3]*Zeta[3])/6 - (Log[3]^2*Zeta[3])/32 - (153*Zeta[5])/16
 
G[-1, 1, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (4*Pi^2*Log[2]^3)/9 - Pi^2*Log[2]^2*Log[3] + 
    (Log[2]^4*Log[3])/3 + (2*Pi^2*Log[2]*Log[3]^2)/3 - 
    (5*Log[2]^3*Log[3]^2)/3 - (5*Pi^2*Log[3]^3)/36 + 
    (29*Log[2]^2*Log[3]^3)/12 - (4*Log[2]*Log[3]^4)/3 + Log[3]^5/4 - 
    (4*Log[2]^3*PolyLog[2, -1/2])/3 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    4*Log[2]^2*PolyLog[3, -1/2] + 4*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    Log[3]^2*PolyLog[3, -1/2] - 4*Log[2]^2*PolyLog[3, 1/3] + 
    4*Log[2]*Log[3]*PolyLog[3, 1/3] - Log[3]^2*PolyLog[3, 1/3] - 
    2*Log[2]*PolyLog[4, 1/2] + Log[3]*PolyLog[4, 1/2] - 
    6*Log[2]*PolyLog[4, 2/3] + 3*Log[3]*PolyLog[4, 2/3] - 4*PolyLog[5, 1/2] + 
    4*PolyLog[5, 2/3] + 4*Log[2]^2*Zeta[3] - 4*Log[2]*Log[3]*Zeta[3] + 
    Log[3]^2*Zeta[3]
 
G[-1, 1, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] - G[0, 0, 1, 0, -1, 1/2]/3 - 
    (1379*Pi^4*Log[2])/12960 + (203*Pi^2*Log[2]^3)/162 + 
    (1291*Log[2]^5)/1080 + (379*Pi^4*Log[3])/4320 - 
    (253*Pi^2*Log[2]^2*Log[3])/72 - (439*Log[2]^4*Log[3])/144 + 
    (167*Pi^2*Log[2]*Log[3]^2)/48 - (85*Pi^2*Log[3]^3)/72 + 
    (47*Log[2]^2*Log[3]^3)/8 - (563*Log[2]*Log[3]^4)/96 + 
    (1687*Log[3]^5)/960 + (Pi^2*Log[2]*PolyLog[2, -1/2])/3 + 
    (5*Log[2]^3*PolyLog[2, -1/2])/3 - (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    3*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/2 + 3*Log[2]*PolyLog[2, -1/2]^2 - 
    3*Log[3]*PolyLog[2, -1/2]^2 + (Pi^2*PolyLog[3, -1/2])/3 - 
    4*Log[2]^2*PolyLog[3, -1/2] + 12*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    7*Log[3]^2*PolyLog[3, -1/2] + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/3 - (9*Log[2]^2*PolyLog[3, 1/3])/2 + 
    (21*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (45*Log[3]^2*PolyLog[3, 1/3])/8 + 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 7*Log[2]*PolyLog[4, -1/2] - 
    (9*Log[3]*PolyLog[4, -1/2])/2 - (5*Log[2]*PolyLog[4, -1/3])/4 + 
    (5*Log[3]*PolyLog[4, -1/3])/8 - (3*Log[2]*PolyLog[4, 1/3])/2 + 
    (11*Log[3]*PolyLog[4, 1/3])/4 + (Log[2]*PolyLog[4, 1/2])/3 - 
    (8*Log[3]*PolyLog[4, 1/2])/3 - 25*Log[2]*PolyLog[4, 2/3] + 
    (51*Log[3]*PolyLog[4, 2/3])/2 + (29*PolyLog[5, -1/2])/3 - 
    PolyLog[5, -1/3]/8 + (7*PolyLog[5, 1/3])/2 + (11*PolyLog[5, 1/2])/9 + 
    33*PolyLog[5, 2/3] + (5*PolyLog[2, 3, -1/3])/8 + 8*PolyLog[2, 3, 1/3] - 
    (19*Pi^2*Zeta[3])/32 + (79*Log[2]^2*Zeta[3])/12 - 
    (89*Log[2]*Log[3]*Zeta[3])/6 + (785*Log[3]^2*Zeta[3])/96 - 
    (4*PolyLog[2, -1/2]*Zeta[3])/3 - (12679*Zeta[5])/576
 
G[-1, 1, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] - 
    (149*Pi^4*Log[2])/1440 + (2*Pi^2*Log[2]^3)/3 + (19*Log[2]^5)/40 + 
    (101*Pi^4*Log[3])/1440 - (25*Pi^2*Log[2]^2*Log[3])/12 - Log[2]^4*Log[3] + 
    (49*Pi^2*Log[2]*Log[3]^2)/24 - Log[2]^3*Log[3]^2 - 
    (49*Pi^2*Log[3]^3)/72 + (25*Log[2]^2*Log[3]^3)/6 - 
    (11*Log[2]*Log[3]^4)/3 + (127*Log[3]^5)/120 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 - (Log[2]^3*PolyLog[2, -1/2])/2 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 - (Log[3]^3*PolyLog[2, -1/2])/6 + (3*Log[2]*PolyLog[2, -1/2]^2)/2 - 
    (3*Log[3]*PolyLog[2, -1/2]^2)/2 + (Pi^2*PolyLog[3, -1/2])/6 - 
    5*Log[2]^2*PolyLog[3, -1/2] + 8*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    4*Log[3]^2*PolyLog[3, -1/2] + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/6 - 5*Log[2]^2*PolyLog[3, 1/3] + 
    8*Log[2]*Log[3]*PolyLog[3, 1/3] - 4*Log[3]^2*PolyLog[3, 1/3] + 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 15*Log[2]*PolyLog[4, 2/3] + 
    15*Log[3]*PolyLog[4, 2/3] - 3*PolyLog[5, 1/2] + 21*PolyLog[5, 2/3] + 
    6*PolyLog[2, 3, 1/3] - (23*Pi^2*Zeta[3])/96 + (47*Log[2]^2*Zeta[3])/8 - 
    (71*Log[2]*Log[3]*Zeta[3])/8 + (71*Log[3]^2*Zeta[3])/16 + 
    (PolyLog[2, -1/2]*Zeta[3])/8 - (975*Zeta[5])/64
 
G[-1, 1, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -8*G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, -1, 0, -1, 1/2] - (10*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (311*Pi^4*Log[2])/6480 - (475*Pi^2*Log[2]^3)/162 - (1193*Log[2]^5)/270 - 
    (373*Pi^4*Log[3])/2160 + (611*Pi^2*Log[2]^2*Log[3])/72 + 
    (197*Log[2]^4*Log[3])/36 - (53*Pi^2*Log[2]*Log[3]^2)/8 + 
    (23*Log[2]^3*Log[3]^2)/3 + (263*Pi^2*Log[3]^3)/144 - 
    (77*Log[2]^2*Log[3]^3)/4 + (611*Log[2]*Log[3]^4)/48 - 
    (1393*Log[3]^5)/480 - (Pi^2*Log[2]*PolyLog[2, -1/2])/3 - 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 
    3*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 3*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (5*Log[3]^3*PolyLog[2, -1/2])/6 - 2*Log[2]*PolyLog[2, -1/2]^2 + 
    3*Log[3]*PolyLog[2, -1/2]^2 - (Pi^2*PolyLog[3, -1/2])/3 + 
    6*Log[2]^2*PolyLog[3, -1/2] - 12*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    7*Log[3]^2*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/3 + 
    29*Log[2]^2*PolyLog[3, 1/3] - 30*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    9*Log[3]^2*PolyLog[3, 1/3] - 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    60*Log[2]*PolyLog[4, -1/2] + 31*Log[3]*PolyLog[4, -1/2] + 
    (29*Log[2]*PolyLog[4, -1/3])/2 - (29*Log[3]*PolyLog[4, -1/3])/4 - 
    15*Log[2]*PolyLog[4, 1/3] + (5*Log[3]*PolyLog[4, 1/3])/2 - 
    (176*Log[2]*PolyLog[4, 1/2])/3 + (103*Log[3]*PolyLog[4, 1/2])/3 + 
    72*Log[2]*PolyLog[4, 2/3] - 47*Log[3]*PolyLog[4, 2/3] - 
    (238*PolyLog[5, -1/2])/3 - (35*PolyLog[5, -1/3])/2 + 11*PolyLog[5, 1/3] - 
    (892*PolyLog[5, 1/2])/9 - 72*PolyLog[5, 2/3] - 7*PolyLog[2, 3, -1/3] - 
    6*PolyLog[2, 3, 1/3] + (59*Pi^2*Zeta[3])/48 - (136*Log[2]^2*Zeta[3])/3 + 
    (553*Log[2]*Log[3]*Zeta[3])/12 - (187*Log[3]^2*Zeta[3])/12 + 
    (8*PolyLog[2, -1/2]*Zeta[3])/3 + (15895*Zeta[5])/288
 
G[-1, 1, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + (4*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (533*Pi^4*Log[2])/12960 - (217*Pi^2*Log[2]^3)/324 - (41*Log[2]^5)/135 - 
    (89*Pi^4*Log[3])/1080 + (113*Pi^2*Log[2]^2*Log[3])/72 + 
    (83*Log[2]^4*Log[3])/144 - (61*Pi^2*Log[2]*Log[3]^2)/48 + 
    (4*Log[2]^3*Log[3]^2)/3 + (53*Pi^2*Log[3]^3)/144 - 
    (29*Log[2]^2*Log[3]^3)/8 + (265*Log[2]*Log[3]^4)/96 - 
    (221*Log[3]^5)/320 - (Log[2]^3*PolyLog[2, -1/2])/3 + 
    (Log[3]^3*PolyLog[2, -1/2])/6 - Log[2]*PolyLog[2, -1/2]^2 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (9*Log[2]^2*PolyLog[3, 1/3])/2 - (19*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (31*Log[3]^2*PolyLog[3, 1/3])/8 + Log[2]*PolyLog[4, -1/2] + 
    (Log[3]*PolyLog[4, -1/2])/2 - (Log[2]*PolyLog[4, -1/3])/4 - 
    (Log[3]*PolyLog[4, -1/3])/8 - (11*Log[2]*PolyLog[4, 1/3])/2 + 
    (17*Log[3]*PolyLog[4, 1/3])/4 + (14*Log[2]*PolyLog[4, 1/2])/3 - 
    (8*Log[3]*PolyLog[4, 1/2])/3 + 13*Log[2]*PolyLog[4, 2/3] - 
    (21*Log[3]*PolyLog[4, 2/3])/2 + (31*PolyLog[5, -1/2])/3 - 
    (9*PolyLog[5, -1/3])/8 + (5*PolyLog[5, 1/3])/2 + (52*PolyLog[5, 1/2])/9 - 
    19*PolyLog[5, 2/3] + PolyLog[2, 3, -1/3]/8 - 10*PolyLog[2, 3, 1/3] - 
    (Pi^2*Zeta[3])/4 - (19*Log[2]^2*Zeta[3])/12 + (65*Log[2]*Log[3]*Zeta[3])/
     24 - (83*Log[3]^2*Zeta[3])/96 - (13*PolyLog[2, -1/2]*Zeta[3])/6 + 
    (12919*Zeta[5])/576
 
G[-1, 1, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -5*G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] - (11*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1103*Pi^4*Log[2])/12960 - (1697*Pi^2*Log[2]^3)/648 - 
    (325*Log[2]^5)/108 - (Pi^4*Log[3])/6 + (20*Pi^2*Log[2]^2*Log[3])/3 + 
    (175*Log[2]^4*Log[3])/48 - (59*Pi^2*Log[2]*Log[3]^2)/12 + 
    (85*Log[2]^3*Log[3]^2)/12 + (91*Pi^2*Log[3]^3)/72 - 
    (383*Log[2]^2*Log[3]^3)/24 + (61*Log[2]*Log[3]^4)/6 - 
    (711*Log[3]^5)/320 - (Log[2]^3*PolyLog[2, -1/2])/2 + 
    (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/2 - 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 + (3*Log[3]*PolyLog[2, -1/2]^2)/2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 8*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    4*Log[3]^2*PolyLog[3, -1/2] - PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (49*Log[2]^2*PolyLog[3, 1/3])/2 - (55*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (67*Log[3]^2*PolyLog[3, 1/3])/8 - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    45*Log[2]*PolyLog[4, -1/2] + (47*Log[3]*PolyLog[4, -1/2])/2 + 
    11*Log[2]*PolyLog[4, -1/3] - (45*Log[3]*PolyLog[4, -1/3])/8 - 
    18*Log[2]*PolyLog[4, 1/3] + (29*Log[3]*PolyLog[4, 1/3])/4 - 
    (100*Log[2]*PolyLog[4, 1/2])/3 + 23*Log[3]*PolyLog[4, 1/2] + 
    58*Log[2]*PolyLog[4, 2/3] - (73*Log[3]*PolyLog[4, 2/3])/2 - 
    (158*PolyLog[5, -1/2])/3 - (111*PolyLog[5, -1/3])/8 + 
    12*PolyLog[5, 1/3] - (563*PolyLog[5, 1/2])/9 - 61*PolyLog[5, 2/3] - 
    (43*PolyLog[2, 3, -1/3])/8 - 8*PolyLog[2, 3, 1/3] + (5*Pi^2*Zeta[3])/8 - 
    (727*Log[2]^2*Zeta[3])/24 + (715*Log[2]*Log[3]*Zeta[3])/24 - 
    (871*Log[3]^2*Zeta[3])/96 + (11*PolyLog[2, -1/2]*Zeta[3])/24 + 
    (23965*Zeta[5])/576
 
G[-1, 1, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] + 
    (101*Pi^4*Log[2])/720 - (Pi^2*Log[2]^3)/2 - (17*Log[2]^5)/30 - 
    (169*Pi^4*Log[3])/1440 + (11*Pi^2*Log[2]^2*Log[3])/6 + 
    (4*Log[2]^4*Log[3])/3 - (25*Pi^2*Log[2]*Log[3]^2)/12 + 
    (Log[2]^3*Log[3]^2)/3 + (53*Pi^2*Log[3]^3)/72 - 
    (11*Log[2]^2*Log[3]^3)/3 + (15*Log[2]*Log[3]^4)/4 - (47*Log[3]^5)/40 - 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/2 - Log[2]*PolyLog[2, -1/2]^2 + 
    (3*Log[3]*PolyLog[2, -1/2]^2)/2 - (Pi^2*PolyLog[3, -1/2])/6 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    3*Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/6 + 4*Log[2]^2*PolyLog[3, 1/3] - 
    8*Log[2]*Log[3]*PolyLog[3, 1/3] + 5*Log[3]^2*PolyLog[3, 1/3] - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 2*Log[3]*PolyLog[4, -1/2] + 
    2*Log[3]*PolyLog[4, 1/3] + 16*Log[2]*PolyLog[4, 2/3] - 
    18*Log[3]*PolyLog[4, 2/3] - 28*PolyLog[5, 2/3] - 12*PolyLog[2, 3, 1/3] - 
    (Pi^2*Zeta[3])/48 - (15*Log[2]^2*Zeta[3])/4 + (31*Log[2]*Log[3]*Zeta[3])/
     4 - (31*Log[3]^2*Zeta[3])/8 - (PolyLog[2, -1/2]*Zeta[3])/4 + 
    (451*Zeta[5])/16
 
G[-1, 1, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] + 
    3*G[0, 0, -1, 0, -1, 1/2] + 4*G[0, 0, 1, 0, -1, 1/2] + 
    (67*Pi^4*Log[2])/4320 + (25*Pi^2*Log[2]^3)/18 + (439*Log[2]^5)/180 + 
    (13*Pi^4*Log[3])/432 - (35*Pi^2*Log[2]^2*Log[3])/9 - 
    (409*Log[2]^4*Log[3])/144 + (133*Pi^2*Log[2]*Log[3]^2)/48 - 
    4*Log[2]^3*Log[3]^2 - (49*Pi^2*Log[3]^3)/72 + (73*Log[2]^2*Log[3]^3)/8 - 
    (529*Log[2]*Log[3]^4)/96 + (1073*Log[3]^5)/960 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + (5*Log[2]^3*PolyLog[2, -1/2])/6 - 
    (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + Log[2]*Log[3]^2*
     PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    Log[2]*PolyLog[2, -1/2]^2 - (3*Log[3]*PolyLog[2, -1/2]^2)/2 - 
    Log[2]^2*PolyLog[3, -1/2] + 4*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    3*Log[3]^2*PolyLog[3, -1/2] - PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    14*Log[2]^2*PolyLog[3, 1/3] + (25*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (23*Log[3]^2*PolyLog[3, 1/3])/8 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    35*Log[2]*PolyLog[4, -1/2] - (39*Log[3]*PolyLog[4, -1/2])/2 - 
    (35*Log[2]*PolyLog[4, -1/3])/4 + (35*Log[3]*PolyLog[4, -1/3])/8 + 
    (17*Log[2]*PolyLog[4, 1/3])/2 - (7*Log[3]*PolyLog[4, 1/3])/4 + 
    (106*Log[2]*PolyLog[4, 1/2])/3 - (71*Log[3]*PolyLog[4, 1/2])/3 - 
    34*Log[2]*PolyLog[4, 2/3] + (37*Log[3]*PolyLog[4, 2/3])/2 + 
    44*PolyLog[5, -1/2] + (81*PolyLog[5, -1/3])/8 - (19*PolyLog[5, 1/3])/2 + 
    54*PolyLog[5, 1/2] + 28*PolyLog[5, 2/3] + (35*PolyLog[2, 3, -1/3])/8 - 
    5*PolyLog[2, 3, 1/3] - (41*Pi^2*Zeta[3])/48 + (313*Log[2]^2*Zeta[3])/12 - 
    (575*Log[2]*Log[3]*Zeta[3])/24 + (707*Log[3]^2*Zeta[3])/96 - 
    (11*PolyLog[2, -1/2]*Zeta[3])/4 - (2297*Zeta[5])/192
 
G[-1, 1, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + (113*Pi^4*Log[2])/1440 - (Pi^2*Log[2]^3)/3 + 
    Log[2]^5/40 - (7*Pi^4*Log[3])/90 + (2*Pi^2*Log[2]^2*Log[3])/3 + 
    (Log[2]^4*Log[3])/12 - (5*Pi^2*Log[2]*Log[3]^2)/8 + 
    (3*Log[2]^3*Log[3]^2)/4 + (7*Pi^2*Log[3]^3)/36 - 
    (11*Log[2]^2*Log[3]^3)/6 + (3*Log[2]*Log[3]^4)/2 - (5*Log[3]^5)/12 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 - (Log[2]^3*PolyLog[2, -1/2])/3 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 + (Log[3]^3*PolyLog[2, -1/2])/6 - PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (5*Log[2]^2*PolyLog[3, 1/3])/2 - 5*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (5*Log[3]^2*PolyLog[3, 1/3])/2 - 3*Log[2]*PolyLog[4, 1/3] + 
    3*Log[3]*PolyLog[4, 1/3] + 6*Log[2]*PolyLog[4, 1/2] - 
    3*Log[3]*PolyLog[4, 1/2] + 7*Log[2]*PolyLog[4, 2/3] - 
    7*Log[3]*PolyLog[4, 2/3] + 3*PolyLog[5, 1/2] - 14*PolyLog[5, 2/3] - 
    7*PolyLog[2, 3, 1/3] - (23*Pi^2*Zeta[3])/96 + (15*Log[2]^2*Zeta[3])/8 - 
    (7*Log[2]*Log[3]*Zeta[3])/8 + (7*Log[3]^2*Zeta[3])/16 - 
    (7*PolyLog[2, -1/2]*Zeta[3])/8 + (873*Zeta[5])/64
 
G[-1, 1, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] - (7*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1933*Pi^4*Log[2])/12960 + (191*Pi^2*Log[2]^3)/162 + (548*Log[2]^5)/135 - 
    (61*Pi^4*Log[3])/1440 - (65*Pi^2*Log[2]^2*Log[3])/12 - 
    (77*Log[2]^4*Log[3])/48 + (61*Pi^2*Log[2]*Log[3]^2)/16 - 
    (121*Log[2]^3*Log[3]^2)/12 - (13*Pi^2*Log[3]^3)/16 + 
    (367*Log[2]^2*Log[3]^3)/24 - (237*Log[2]*Log[3]^4)/32 + 
    (1067*Log[3]^5)/960 - Log[2]^3*PolyLog[2, -1/2] + 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/6 - Log[2]*PolyLog[2, -1/2]^2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (Log[3]^2*PolyLog[3, -1/2])/2 - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    29*Log[2]^2*PolyLog[3, 1/3] + (41*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (7*Log[3]^2*PolyLog[3, 1/3])/8 + 82*Log[2]*PolyLog[4, -1/2] - 
    (67*Log[3]*PolyLog[4, -1/2])/2 - (29*Log[2]*PolyLog[4, -1/3])/4 + 
    (29*Log[3]*PolyLog[4, -1/3])/8 + (3*Log[2]*PolyLog[4, 1/3])/2 + 
    (39*Log[3]*PolyLog[4, 1/3])/4 + 81*Log[2]*PolyLog[4, 1/2] - 
    37*Log[3]*PolyLog[4, 1/2] - 48*Log[2]*PolyLog[4, 2/3] + 
    (35*Log[3]*PolyLog[4, 2/3])/2 + (299*PolyLog[5, -1/2])/3 + 
    (141*PolyLog[5, -1/3])/8 - (5*PolyLog[5, 1/3])/2 + 
    (899*PolyLog[5, 1/2])/9 + 30*PolyLog[5, 2/3] + 
    (75*PolyLog[2, 3, -1/3])/8 - 17*PolyLog[2, 3, 1/3] - 
    (151*Pi^2*Zeta[3])/96 + (487*Log[2]^2*Zeta[3])/8 - 
    (107*Log[2]*Log[3]*Zeta[3])/2 + (461*Log[3]^2*Zeta[3])/32 - 
    (4*PolyLog[2, -1/2]*Zeta[3])/3 + (257*Zeta[5])/576
 
G[-1, 1, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] - 
    10*G[0, 0, -1, 0, -1, 1/2] - (50*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (269*Pi^4*Log[2])/2592 - (85*Pi^2*Log[2]^3)/81 - (133*Log[2]^5)/27 + 
    (4*Pi^4*Log[3])/135 + (307*Pi^2*Log[2]^2*Log[3])/72 + 
    (379*Log[2]^4*Log[3])/144 - (91*Pi^2*Log[2]*Log[3]^2)/48 + 
    (121*Log[2]^3*Log[3]^2)/12 - (Pi^2*Log[3]^3)/16 - 
    (341*Log[2]^2*Log[3]^3)/24 + (491*Log[2]*Log[3]^4)/96 - 
    (27*Log[3]^5)/320 + (2*Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/6 + 2*Log[2]*PolyLog[2, -1/2]^2 - 
    Log[3]*PolyLog[2, -1/2]^2 - (Pi^2*PolyLog[3, -1/2])/2 - 
    7*Log[2]^2*PolyLog[3, -1/2] + 8*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (5*Log[3]^2*PolyLog[3, -1/2])/2 + 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    29*Log[2]^2*PolyLog[3, 1/3] - (27*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (35*Log[3]^2*PolyLog[3, 1/3])/8 - 96*Log[2]*PolyLog[4, -1/2] + 
    (81*Log[3]*PolyLog[4, -1/2])/2 + (89*Log[2]*PolyLog[4, -1/3])/4 - 
    (135*Log[3]*PolyLog[4, -1/3])/8 - (43*Log[2]*PolyLog[4, 1/3])/2 + 
    (27*Log[3]*PolyLog[4, 1/3])/4 - (352*Log[2]*PolyLog[4, 1/2])/3 + 
    (182*Log[3]*PolyLog[4, 1/2])/3 + 50*Log[2]*PolyLog[4, 2/3] - 
    (25*Log[3]*PolyLog[4, 2/3])/2 - (434*PolyLog[5, -1/2])/3 - 
    (319*PolyLog[5, -1/3])/8 + (67*PolyLog[5, 1/3])/2 - 
    (1742*PolyLog[5, 1/2])/9 - 30*PolyLog[5, 2/3] - 
    (89*PolyLog[2, 3, -1/3])/8 + 31*PolyLog[2, 3, 1/3] + 
    (55*Pi^2*Zeta[3])/48 - (371*Log[2]^2*Zeta[3])/6 + 
    (1001*Log[2]*Log[3]*Zeta[3])/24 - (605*Log[3]^2*Zeta[3])/96 + 
    (13*PolyLog[2, -1/2]*Zeta[3])/3 - (11*Zeta[5])/576
 
G[-1, 1, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] - 
    5*G[0, 0, -1, 0, -1, 1/2] - (25*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (887*Pi^4*Log[2])/12960 - (5*Pi^2*Log[2]^3)/81 - (391*Log[2]^5)/540 + 
    (23*Pi^4*Log[3])/540 - (31*Pi^2*Log[2]^2*Log[3])/72 + 
    (131*Log[2]^4*Log[3])/144 + Pi^2*Log[2]*Log[3]^2 + 
    (Log[2]^3*Log[3]^2)/6 - (17*Pi^2*Log[3]^3)/36 + (3*Log[2]^2*Log[3]^3)/8 - 
    (17*Log[2]*Log[3]^4)/12 + (637*Log[3]^5)/960 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - (Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]*PolyLog[2, -1/2]^2)/2 - (Log[3]*PolyLog[2, -1/2]^2)/2 - 
    (Pi^2*PolyLog[3, -1/2])/4 + 3*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (3*Log[3]^2*PolyLog[3, -1/2])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Log[2]^2*PolyLog[3, 1/3])/2 + (11*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (35*Log[3]^2*PolyLog[3, 1/3])/8 - 11*Log[2]*PolyLog[4, -1/2] + 
    (9*Log[3]*PolyLog[4, -1/2])/2 + 9*Log[2]*PolyLog[4, -1/3] - 
    (59*Log[3]*PolyLog[4, -1/3])/8 - 8*Log[2]*PolyLog[4, 1/3] + 
    (19*Log[3]*PolyLog[4, 1/3])/4 - (68*Log[2]*PolyLog[4, 1/2])/3 + 
    (43*Log[3]*PolyLog[4, 1/2])/3 + 2*Log[2]*PolyLog[4, 2/3] + 
    (9*Log[3]*PolyLog[4, 2/3])/2 - (124*PolyLog[5, -1/2])/3 - 
    (105*PolyLog[5, -1/3])/8 + 14*PolyLog[5, 1/3] - (589*PolyLog[5, 1/2])/9 + 
    5*PolyLog[5, 2/3] - (13*PolyLog[2, 3, -1/3])/8 + 12*PolyLog[2, 3, 1/3] + 
    (Pi^2*Zeta[3])/24 - (35*Log[2]^2*Zeta[3])/12 - 
    (41*Log[2]*Log[3]*Zeta[3])/24 + (251*Log[3]^2*Zeta[3])/96 + 
    (55*PolyLog[2, -1/2]*Zeta[3])/24 - (4027*Zeta[5])/576
 
G[-1, 1, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    8*G[0, 0, -1, 0, -1, 1/2] + (10*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (173*Pi^4*Log[2])/810 + (59*Pi^2*Log[2]^3)/324 + (521*Log[2]^5)/270 - 
    (313*Pi^4*Log[3])/2160 - (35*Pi^2*Log[2]^2*Log[3])/36 - 
    (5*Log[2]^4*Log[3])/18 - (59*Log[2]^3*Log[3]^2)/12 + (Pi^2*Log[3]^3)/4 + 
    (53*Log[2]^2*Log[3]^3)/12 + (Log[2]*Log[3]^4)/24 - (79*Log[3]^5)/120 - 
    (Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/6 - Log[2]*PolyLog[2, -1/2]^2 + 
    Log[3]*PolyLog[2, -1/2]^2 + (Pi^2*PolyLog[3, -1/2])/2 + 
    5*Log[2]^2*PolyLog[3, -1/2] - 10*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (7*Log[3]^2*PolyLog[3, -1/2])/2 - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (23*Log[2]^2*PolyLog[3, 1/3])/2 - Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (13*Log[3]^2*PolyLog[3, 1/3])/2 + 45*Log[2]*PolyLog[4, -1/2] - 
    24*Log[3]*PolyLog[4, -1/2] - 6*Log[2]*PolyLog[4, -1/3] + 
    3*Log[3]*PolyLog[4, -1/3] - 5*Log[2]*PolyLog[4, 1/3] + 
    13*Log[3]*PolyLog[4, 1/3] + (142*Log[2]*PolyLog[4, 1/2])/3 - 
    (86*Log[3]*PolyLog[4, 1/2])/3 - 13*Log[2]*PolyLog[4, 2/3] - 
    8*Log[3]*PolyLog[4, 2/3] + (193*PolyLog[5, -1/2])/3 + 
    14*PolyLog[5, -1/3] + 2*PolyLog[5, 1/3] + (586*PolyLog[5, 1/2])/9 - 
    9*PolyLog[5, 2/3] + 6*PolyLog[2, 3, -1/3] - 25*PolyLog[2, 3, 1/3] - 
    (29*Pi^2*Zeta[3])/48 + (67*Log[2]^2*Zeta[3])/2 - 
    (113*Log[2]*Log[3]*Zeta[3])/4 + (25*Log[3]^2*Zeta[3])/4 - 
    (13*PolyLog[2, -1/2]*Zeta[3])/6 + (3721*Zeta[5])/144
 
G[-1, 1, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, 0, 1, 0, -1, 1/2] + 
    (37*Pi^4*Log[2])/1080 - (7*Pi^2*Log[2]^3)/9 - (77*Log[2]^5)/45 - 
    (11*Pi^4*Log[3])/216 + (89*Pi^2*Log[2]^2*Log[3])/36 + 
    (49*Log[2]^4*Log[3])/36 - (7*Pi^2*Log[2]*Log[3]^2)/4 + 
    (47*Log[2]^3*Log[3]^2)/12 + (11*Pi^2*Log[3]^3)/36 - 
    (85*Log[2]^2*Log[3]^3)/12 + (47*Log[2]*Log[3]^4)/12 - 
    (161*Log[3]^5)/240 + (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (3*Log[3]^2*PolyLog[3, -1/2])/2 + (25*Log[2]^2*PolyLog[3, 1/3])/2 - 
    11*Log[2]*Log[3]*PolyLog[3, 1/3] + 2*Log[3]^2*PolyLog[3, 1/3] - 
    25*Log[2]*PolyLog[4, -1/2] + 14*Log[3]*PolyLog[4, -1/2] + 
    7*Log[2]*PolyLog[4, -1/3] - (13*Log[3]*PolyLog[4, -1/3])/2 - 
    11*Log[2]*PolyLog[4, 1/3] + 8*Log[3]*PolyLog[4, 1/3] - 
    (92*Log[2]*PolyLog[4, 1/2])/3 + (56*Log[3]*PolyLog[4, 1/2])/3 + 
    25*Log[2]*PolyLog[4, 2/3] - 14*Log[3]*PolyLog[4, 2/3] - 
    29*PolyLog[5, -1/2] - (27*PolyLog[5, -1/3])/2 + 16*PolyLog[5, 1/3] - 
    48*PolyLog[5, 1/2] - 25*PolyLog[5, 2/3] - (7*PolyLog[2, 3, -1/3])/2 + 
    3*PolyLog[2, 3, 1/3] + (11*Pi^2*Zeta[3])/24 - (233*Log[2]^2*Zeta[3])/12 + 
    (91*Log[2]*Log[3]*Zeta[3])/6 - (49*Log[3]^2*Zeta[3])/24 + (155*Zeta[5])/12
 
G[-1, 1, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (239*Pi^4*Log[2])/2160 - 
    (11*Pi^2*Log[2]^3)/27 + (11*Log[2]^5)/180 - (53*Pi^4*Log[3])/540 + 
    (35*Pi^2*Log[2]^2*Log[3])/36 + (41*Log[2]^4*Log[3])/72 - 
    Pi^2*Log[2]*Log[3]^2 - (Log[2]^3*Log[3]^2)/6 + (11*Pi^2*Log[3]^3)/36 - 
    (23*Log[2]^2*Log[3]^3)/12 + (55*Log[2]*Log[3]^4)/24 - (43*Log[3]^5)/60 - 
    (Log[2]^3*PolyLog[2, -1/2])/6 + (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + (Log[3]*PolyLog[2, -1/2]^2)/2 + 
    (5*Log[2]^2*PolyLog[3, -1/2])/2 - 5*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (5*Log[3]^2*PolyLog[3, -1/2])/2 - PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (3*Log[2]^2*PolyLog[3, 1/3])/2 - 7*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (9*Log[3]^2*PolyLog[3, 1/3])/2 + 8*Log[2]*PolyLog[4, -1/2] - 
    4*Log[3]*PolyLog[4, -1/2] + Log[2]*PolyLog[4, -1/3] - 
    2*Log[3]*PolyLog[4, -1/3] - 9*Log[2]*PolyLog[4, 1/3] + 
    11*Log[3]*PolyLog[4, 1/3] + 8*Log[2]*PolyLog[4, 1/2] - 
    (16*Log[3]*PolyLog[4, 1/2])/3 + 8*Log[2]*PolyLog[4, 2/3] - 
    12*Log[3]*PolyLog[4, 2/3] + 16*PolyLog[5, -1/2] + 9*PolyLog[5, 1/3] + 
    (14*PolyLog[5, 1/2])/3 - 19*PolyLog[5, 2/3] + PolyLog[2, 3, -1/3] - 
    11*PolyLog[2, 3, 1/3] - (11*Pi^2*Zeta[3])/48 + 
    (155*Log[2]^2*Zeta[3])/24 - (35*Log[2]*Log[3]*Zeta[3])/6 + 
    (11*Log[3]^2*Zeta[3])/6 + (4483*Zeta[5])/192
 
G[-1, 1, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, 0, -1, 0, -1, 1/2] + 
    (14*Pi^4*Log[2])/45 + (7*Pi^2*Log[2]^3)/8 + (107*Log[2]^5)/30 - 
    (169*Pi^4*Log[3])/1440 - (7*Pi^2*Log[2]^2*Log[3])/2 - 
    (37*Log[2]^4*Log[3])/24 + (43*Pi^2*Log[2]*Log[3]^2)/24 - 
    (97*Log[2]^3*Log[3]^2)/12 - (5*Pi^2*Log[3]^3)/24 + 
    (43*Log[2]^2*Log[3]^3)/4 - (59*Log[2]*Log[3]^4)/16 + (49*Log[3]^5)/480 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - (Log[2]^3*PolyLog[2, -1/2])/2 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    Log[2]*PolyLog[2, -1/2]^2 + (Log[3]*PolyLog[2, -1/2]^2)/2 + 
    (Pi^2*PolyLog[3, -1/2])/4 + 3*Log[2]^2*PolyLog[3, -1/2] - 
    6*Log[2]*Log[3]*PolyLog[3, -1/2] + (3*Log[3]^2*PolyLog[3, -1/2])/2 - 
    3*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 22*Log[2]^2*PolyLog[3, 1/3] + 
    9*Log[2]*Log[3]*PolyLog[3, 1/3] + (17*Log[3]^2*PolyLog[3, 1/3])/4 + 
    70*Log[2]*PolyLog[4, -1/2] - 31*Log[3]*PolyLog[4, -1/2] - 
    (23*Log[2]*PolyLog[4, -1/3])/2 + (23*Log[3]*PolyLog[4, -1/3])/4 + 
    3*Log[2]*PolyLog[4, 1/3] + (23*Log[3]*PolyLog[4, 1/3])/2 + 
    78*Log[2]*PolyLog[4, 1/2] - 39*Log[3]*PolyLog[4, 1/2] - 
    34*Log[2]*PolyLog[4, 2/3] + 4*Log[3]*PolyLog[4, 2/3] + 
    104*PolyLog[5, -1/2] + (81*PolyLog[5, -1/3])/4 - 3*PolyLog[5, 1/3] + 
    124*PolyLog[5, 1/2] + 8*PolyLog[5, 2/3] + (35*PolyLog[2, 3, -1/3])/4 - 
    26*PolyLog[2, 3, 1/3] - (67*Pi^2*Zeta[3])/48 + 
    (593*Log[2]^2*Zeta[3])/12 - (509*Log[2]*Log[3]*Zeta[3])/12 + 
    (521*Log[3]^2*Zeta[3])/48 - (11*PolyLog[2, -1/2]*Zeta[3])/4 + 
    (475*Zeta[5])/96
 
G[-1, 1, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    5*G[0, 0, -1, 0, -1, 1/2] - 8*G[0, 0, 1, 0, -1, 1/2] - 
    (73*Pi^4*Log[2])/4320 - (11*Pi^2*Log[2]^3)/27 - (199*Log[2]^5)/120 + 
    (239*Pi^4*Log[3])/4320 + (97*Pi^2*Log[2]^2*Log[3])/72 + 
    (133*Log[2]^4*Log[3])/144 - (23*Pi^2*Log[2]*Log[3]^2)/48 + 
    (41*Log[2]^3*Log[3]^2)/12 - (Pi^2*Log[3]^3)/8 - 
    (35*Log[2]^2*Log[3]^3)/8 + (37*Log[2]*Log[3]^4)/32 + (59*Log[3]^5)/320 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (Log[3]^3*PolyLog[2, -1/2])/6 + Log[2]*PolyLog[2, -1/2]^2 - 
    (Log[3]*PolyLog[2, -1/2]^2)/2 - (7*Log[2]^2*PolyLog[3, -1/2])/2 + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - (Log[3]^2*PolyLog[3, -1/2])/2 + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 10*Log[2]^2*PolyLog[3, 1/3] - 
    (3*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (31*Log[3]^2*PolyLog[3, 1/3])/8 - 
    39*Log[2]*PolyLog[4, -1/2] + (33*Log[3]*PolyLog[4, -1/2])/2 + 
    (37*Log[2]*PolyLog[4, -1/3])/4 - (61*Log[3]*PolyLog[4, -1/3])/8 - 
    (11*Log[2]*PolyLog[4, 1/3])/2 - (3*Log[3]*PolyLog[4, 1/3])/4 - 
    (122*Log[2]*PolyLog[4, 1/2])/3 + (74*Log[3]*PolyLog[4, 1/2])/3 + 
    16*Log[2]*PolyLog[4, 2/3] - (5*Log[3]*PolyLog[4, 2/3])/2 - 
    63*PolyLog[5, -1/2] - (135*PolyLog[5, -1/3])/8 + (21*PolyLog[5, 1/3])/2 - 
    (202*PolyLog[5, 1/2])/3 - 6*PolyLog[5, 2/3] - (37*PolyLog[2, 3, -1/3])/
     8 + 17*PolyLog[2, 3, 1/3] + (31*Pi^2*Zeta[3])/48 - 
    (511*Log[2]^2*Zeta[3])/24 + (337*Log[2]*Log[3]*Zeta[3])/24 - 
    (121*Log[3]^2*Zeta[3])/96 - (1337*Zeta[5])/64
 
G[-1, 1, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, 1, 0, -1, 1/2] + (43*Pi^4*Log[2])/540 - 
    (43*Pi^2*Log[2]^3)/108 - (2*Log[2]^5)/45 - (253*Pi^4*Log[3])/4320 + 
    (37*Pi^2*Log[2]^2*Log[3])/72 + (67*Log[2]^4*Log[3])/144 - 
    (11*Pi^2*Log[2]*Log[3]^2)/48 + (Log[2]^3*Log[3]^2)/6 - 
    (Pi^2*Log[3]^3)/72 - (9*Log[2]^2*Log[3]^3)/8 + (83*Log[2]*Log[3]^4)/96 - 
    (57*Log[3]^5)/320 - (Log[2]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 + (Log[3]^3*PolyLog[2, -1/2])/6 + (Log[2]^2*PolyLog[3, -1/2])/2 - 
    Log[2]*Log[3]*PolyLog[3, -1/2] + (Log[3]^2*PolyLog[3, -1/2])/2 + 
    (3*Log[2]^2*PolyLog[3, 1/3])/2 - (5*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (9*Log[3]^2*PolyLog[3, 1/3])/8 - Log[2]*PolyLog[4, -1/2] + 
    (Log[3]*PolyLog[4, -1/2])/2 + (13*Log[2]*PolyLog[4, -1/3])/4 - 
    (25*Log[3]*PolyLog[4, -1/3])/8 - (15*Log[2]*PolyLog[4, 1/3])/2 + 
    (29*Log[3]*PolyLog[4, 1/3])/4 + 2*Log[2]*PolyLog[4, 1/2] + 
    (2*Log[3]*PolyLog[4, 1/2])/3 + 6*Log[2]*PolyLog[4, 2/3] - 
    (11*Log[3]*PolyLog[4, 2/3])/2 - 4*PolyLog[5, -1/2] - 
    (27*PolyLog[5, -1/3])/8 + (15*PolyLog[5, 1/3])/2 - 
    (26*PolyLog[5, 1/2])/3 - 11*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3]/8 - 
    2*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/24 + (95*Log[2]^2*Zeta[3])/24 - 
    (143*Log[2]*Log[3]*Zeta[3])/24 + (299*Log[3]^2*Zeta[3])/96 + 
    (353*Zeta[5])/48
 
G[-1, 1, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    (13*Pi^4*Log[2])/480 + (Pi^2*Log[2]^3)/6 - Log[2]^5/40 + 
    (17*Pi^4*Log[3])/720 - (2*Pi^2*Log[2]^2*Log[3])/3 + 
    (7*Log[2]^4*Log[3])/12 + (17*Pi^2*Log[2]*Log[3]^2)/24 - 
    (7*Log[2]^3*Log[3]^2)/4 - (2*Pi^2*Log[3]^3)/9 + 
    (29*Log[2]^2*Log[3]^3)/12 - (13*Log[2]*Log[3]^4)/8 + (49*Log[3]^5)/120 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 - (5*Log[2]^3*PolyLog[2, -1/2])/6 + 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/6 - (Log[2]*PolyLog[2, -1/2]^2)/2 - 
    Log[2]^2*PolyLog[3, -1/2] + 2*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    Log[3]^2*PolyLog[3, -1/2] - (7*Log[2]^2*PolyLog[3, 1/3])/2 + 
    5*Log[2]*Log[3]*PolyLog[3, 1/3] - 2*Log[3]^2*PolyLog[3, 1/3] + 
    Log[2]*PolyLog[4, -1/2] - Log[3]*PolyLog[4, -1/2] + 
    Log[2]*PolyLog[4, 1/3] - Log[3]*PolyLog[4, 1/3] - 
    5*Log[2]*PolyLog[4, 2/3] + 5*Log[3]*PolyLog[4, 2/3] + 7*PolyLog[5, 2/3] + 
    3*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/96 + (23*Log[2]^2*Zeta[3])/8 - 
    (31*Log[2]*Log[3]*Zeta[3])/8 + (23*Log[3]^2*Zeta[3])/16 + 
    (PolyLog[2, -1/2]*Zeta[3])/8 - (451*Zeta[5])/64
 
G[-1, 1, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 5*G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, -1, 0, -1, 1/2] - (4*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (2831*Pi^4*Log[2])/12960 + (695*Pi^2*Log[2]^3)/648 + (17*Log[2]^5)/54 + 
    (29*Pi^4*Log[3])/144 - (35*Pi^2*Log[2]^2*Log[3])/12 - 
    (77*Log[2]^4*Log[3])/48 + (149*Pi^2*Log[2]*Log[3]^2)/48 - 
    (5*Log[2]^3*Log[3]^2)/6 - (155*Pi^2*Log[3]^3)/144 + 
    (151*Log[2]^2*Log[3]^3)/24 - (605*Log[2]*Log[3]^4)/96 + 
    (621*Log[3]^5)/320 + Log[2]^3*PolyLog[2, -1/2] - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (5*Log[2]*PolyLog[2, -1/2]^2)/2 - 2*Log[3]*PolyLog[2, -1/2]^2 - 
    5*Log[2]^2*PolyLog[3, -1/2] + 10*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    5*Log[3]^2*PolyLog[3, -1/2] + 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/6 - (11*Log[2]^2*PolyLog[3, 1/3])/2 + 
    (35*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (83*Log[3]^2*PolyLog[3, 1/3])/8 + 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 9*Log[2]*PolyLog[4, -1/2] + 
    (9*Log[3]*PolyLog[4, -1/2])/2 + (9*Log[2]*PolyLog[4, -1/3])/4 - 
    (9*Log[3]*PolyLog[4, -1/3])/8 + (15*Log[2]*PolyLog[4, 1/3])/2 - 
    (39*Log[3]*PolyLog[4, 1/3])/4 - 14*Log[2]*PolyLog[4, 1/2] + 
    9*Log[3]*PolyLog[4, 1/2] - 23*Log[2]*PolyLog[4, 2/3] + 
    (55*Log[3]*PolyLog[4, 2/3])/2 - (46*PolyLog[5, -1/2])/3 - 
    (25*PolyLog[5, -1/3])/8 - 5*PolyLog[5, 1/3] - (115*PolyLog[5, 1/2])/9 + 
    44*PolyLog[5, 2/3] - (9*PolyLog[2, 3, -1/3])/8 + 22*PolyLog[2, 3, 1/3] + 
    (17*Pi^2*Zeta[3])/96 - (7*Log[2]^2*Zeta[3])/2 - 
    (7*Log[2]*Log[3]*Zeta[3])/2 + (109*Log[3]^2*Zeta[3])/32 + 
    (55*PolyLog[2, -1/2]*Zeta[3])/24 - (26689*Zeta[5])/576
 
G[-1, 1, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] - 
    3*G[0, 0, -1, 0, -1, 1/2] - (49*Pi^4*Log[2])/288 + 
    (65*Pi^2*Log[2]^3)/72 + (7*Log[2]^5)/24 + (Pi^4*Log[3])/6 - 
    (29*Pi^2*Log[2]^2*Log[3])/12 - (5*Log[2]^4*Log[3])/12 + 
    (7*Pi^2*Log[2]*Log[3]^2)/3 - (8*Log[2]^3*Log[3]^2)/3 - 
    (3*Pi^2*Log[3]^3)/4 + (13*Log[2]^2*Log[3]^3)/2 - (21*Log[2]*Log[3]^4)/4 + 
    (29*Log[3]^5)/20 - (Pi^2*Log[2]*PolyLog[2, -1/2])/12 - 
    (Log[2]^3*PolyLog[2, -1/2])/6 - (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + Log[2]*PolyLog[2, -1/2]^2 - 
    Log[3]*PolyLog[2, -1/2]^2 - 3*Log[2]^2*PolyLog[3, -1/2] + 
    6*Log[2]*Log[3]*PolyLog[3, -1/2] - 3*Log[3]^2*PolyLog[3, -1/2] + 
    3*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/12 - 
    (17*Log[2]^2*PolyLog[3, 1/3])/2 + 16*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    8*Log[3]^2*PolyLog[3, 1/3] + PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    9*Log[2]*PolyLog[4, 1/3] - 9*Log[3]*PolyLog[4, 1/3] - 
    6*Log[2]*PolyLog[4, 1/2] + 3*Log[3]*PolyLog[4, 1/2] - 
    21*Log[2]*PolyLog[4, 2/3] + 21*Log[3]*PolyLog[4, 2/3] - 
    6*PolyLog[5, -1/2] - 6*PolyLog[5, 1/3] - 3*PolyLog[5, 1/2] + 
    36*PolyLog[5, 2/3] + 15*PolyLog[2, 3, 1/3] + (7*Pi^2*Zeta[3])/48 + 
    (5*Log[2]^2*Zeta[3])/4 - (17*Log[2]*Log[3]*Zeta[3])/4 + 
    (17*Log[3]^2*Zeta[3])/8 + (7*PolyLog[2, -1/2]*Zeta[3])/4 - 
    (2223*Zeta[5])/64
 
G[-1, 1, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -5*G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + (4*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (47*Pi^4*Log[2])/1296 - (1199*Pi^2*Log[2]^3)/648 - (1253*Log[2]^5)/540 - 
    (287*Pi^4*Log[3])/2160 + (191*Pi^2*Log[2]^2*Log[3])/36 + 
    (28*Log[2]^4*Log[3])/9 - (101*Pi^2*Log[2]*Log[3]^2)/24 + 
    4*Log[2]^3*Log[3]^2 + (169*Pi^2*Log[3]^3)/144 - 
    (34*Log[2]^2*Log[3]^3)/3 + (129*Log[2]*Log[3]^4)/16 - (39*Log[3]^5)/20 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - (Log[2]^3*PolyLog[2, -1/2])/2 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/2 - 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 + 2*Log[3]*PolyLog[2, -1/2]^2 + 
    5*Log[2]^2*PolyLog[3, -1/2] - 10*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    5*Log[3]^2*PolyLog[3, -1/2] - PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/6 + (33*Log[2]^2*PolyLog[3, 1/3])/2 - 
    20*Log[2]*Log[3]*PolyLog[3, 1/3] + (29*Log[3]^2*PolyLog[3, 1/3])/4 - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 28*Log[2]*PolyLog[4, -1/2] + 
    12*Log[3]*PolyLog[4, -1/2] + (13*Log[2]*PolyLog[4, -1/3])/2 - 
    (13*Log[3]*PolyLog[4, -1/3])/4 - 10*Log[2]*PolyLog[4, 1/3] + 
    (9*Log[3]*PolyLog[4, 1/3])/2 - (76*Log[2]*PolyLog[4, 1/2])/3 + 
    (32*Log[3]*PolyLog[4, 1/2])/3 + 43*Log[2]*PolyLog[4, 2/3] - 
    31*Log[3]*PolyLog[4, 2/3] - (110*PolyLog[5, -1/2])/3 - 
    7*PolyLog[5, -1/3] + (13*PolyLog[5, 1/3])/2 - (443*PolyLog[5, 1/2])/9 - 
    48*PolyLog[5, 2/3] - (13*PolyLog[2, 3, -1/3])/4 - 9*PolyLog[2, 3, 1/3] + 
    (61*Pi^2*Zeta[3])/96 - (125*Log[2]^2*Zeta[3])/6 + 
    (521*Log[2]*Log[3]*Zeta[3])/24 - (373*Log[3]^2*Zeta[3])/48 + 
    (11*PolyLog[2, -1/2]*Zeta[3])/24 + (1579*Zeta[5])/36
 
G[-1, 1, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + 2*G[0, 0, 1, 0, -1, 1/2] - (Pi^4*Log[2])/180 - 
    (2*Pi^2*Log[2]^3)/9 - (7*Log[2]^5)/40 - (Pi^4*Log[3])/45 + 
    (2*Pi^2*Log[2]^2*Log[3])/3 + (3*Log[2]^4*Log[3])/8 - 
    (7*Pi^2*Log[2]*Log[3]^2)/12 + (Log[2]^3*Log[3]^2)/3 + (Pi^2*Log[3]^3)/6 - 
    (5*Log[2]^2*Log[3]^3)/4 + Log[2]*Log[3]^4 - (31*Log[3]^5)/120 - 
    (Log[2]^3*PolyLog[2, -1/2])/6 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + Log[2]^2*PolyLog[3, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] + Log[3]^2*PolyLog[3, -1/2] - 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] + (3*Log[2]^2*PolyLog[3, 1/3])/2 - 
    3*Log[2]*Log[3]*PolyLog[3, 1/3] + Log[3]^2*PolyLog[3, 1/3] + 
    2*Log[2]*PolyLog[4, -1/2] + Log[3]*PolyLog[4, -1/2] - 
    Log[2]*PolyLog[4, 1/3] + 2*Log[2]*PolyLog[4, 1/2] + 
    5*Log[2]*PolyLog[4, 2/3] - 4*Log[3]*PolyLog[4, 2/3] + 
    10*PolyLog[5, -1/2] - PolyLog[5, 1/3] + 8*PolyLog[5, 1/2] - 
    6*PolyLog[5, 2/3] - 3*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/16 - 
    (17*Log[2]^2*Zeta[3])/8 + 3*Log[2]*Log[3]*Zeta[3] - Log[3]^2*Zeta[3] + 
    (141*Zeta[5])/16
 
G[-1, 1, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -3*G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + 2*G[0, 0, 1, 0, -1, 1/2] + 
    (47*Pi^4*Log[2])/1440 - (31*Pi^2*Log[2]^3)/72 - (73*Log[2]^5)/120 - 
    (Pi^4*Log[3])/30 + (19*Pi^2*Log[2]^2*Log[3])/12 + (5*Log[2]^4*Log[3])/4 - 
    (19*Pi^2*Log[2]*Log[3]^2)/12 + (19*Pi^2*Log[3]^3)/36 - 
    (5*Log[2]^2*Log[3]^3)/2 + (5*Log[2]*Log[3]^4)/2 - (3*Log[3]^5)/4 - 
    (Log[2]^3*PolyLog[2, -1/2])/3 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    Log[2]*PolyLog[2, -1/2]^2 + Log[3]*PolyLog[2, -1/2]^2 + 
    3*Log[2]^2*PolyLog[3, -1/2] - 6*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    3*Log[3]^2*PolyLog[3, -1/2] - PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (5*Log[2]^2*PolyLog[3, 1/3])/2 - 5*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (5*Log[3]^2*PolyLog[3, 1/3])/2 - PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    Log[2]*PolyLog[4, 1/3] - Log[3]*PolyLog[4, 1/3] - 
    3*Log[2]*PolyLog[4, 1/2] + 11*Log[2]*PolyLog[4, 2/3] - 
    11*Log[3]*PolyLog[4, 2/3] - PolyLog[5, 1/3] - 2*PolyLog[5, 1/2] - 
    14*PolyLog[5, 2/3] - 6*PolyLog[2, 3, 1/3] + (23*Pi^2*Zeta[3])/96 - 
    (87*Log[2]^2*Zeta[3])/16 + 8*Log[2]*Log[3]*Zeta[3] - 4*Log[3]^2*Zeta[3] + 
    (919*Zeta[5])/64
 
G[-1, 1, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + (Pi^4*Log[2])/9 - (41*Pi^2*Log[2]^3)/72 - 
    (5*Log[2]^5)/12 - (Pi^4*Log[3])/9 + (19*Pi^2*Log[2]^2*Log[3])/12 + 
    (13*Log[2]^4*Log[3])/12 - (37*Pi^2*Log[2]*Log[3]^2)/24 + 
    (5*Log[2]^3*Log[3]^2)/12 + (Pi^2*Log[3]^3)/2 - (19*Log[2]^2*Log[3]^3)/6 + 
    3*Log[2]*Log[3]^4 - (53*Log[3]^5)/60 - (Log[2]^3*PolyLog[2, -1/2])/2 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 - (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/
     3 - Log[2]*PolyLog[2, -1/2]^2 + Log[3]*PolyLog[2, -1/2]^2 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/12 + 4*Log[2]^2*PolyLog[3, 1/3] - 
    8*Log[2]*Log[3]*PolyLog[3, 1/3] + (9*Log[3]^2*PolyLog[3, 1/3])/2 - 
    PolyLog[2, -1/2]*PolyLog[3, 1/3] - 4*Log[2]*PolyLog[4, 1/3] + 
    5*Log[3]*PolyLog[4, 1/3] + 2*Log[2]*PolyLog[4, 1/2] - 
    Log[3]*PolyLog[4, 1/2] + 14*Log[2]*PolyLog[4, 2/3] - 
    14*Log[3]*PolyLog[4, 2/3] + 4*PolyLog[5, -1/2] + 4*PolyLog[5, 1/3] + 
    2*PolyLog[5, 1/2] - 24*PolyLog[5, 2/3] - 10*PolyLog[2, 3, 1/3] - 
    (7*Pi^2*Zeta[3])/96 - (9*Log[2]^2*Zeta[3])/8 + 
    (25*Log[2]*Log[3]*Zeta[3])/8 - (25*Log[3]^2*Zeta[3])/16 - 
    (7*PolyLog[2, -1/2]*Zeta[3])/8 + (741*Zeta[5])/32
 
G[-1, 1, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] - (49*Pi^4*Log[2])/720 + (5*Pi^2*Log[2]^3)/12 + 
    (9*Log[2]^5)/20 + (Pi^4*Log[3])/15 - (4*Pi^2*Log[2]^2*Log[3])/3 - 
    (11*Log[2]^4*Log[3])/12 + (4*Pi^2*Log[2]*Log[3]^2)/3 - 
    (7*Log[2]^3*Log[3]^2)/12 - (4*Pi^2*Log[3]^3)/9 + 3*Log[2]^2*Log[3]^3 - 
    (65*Log[2]*Log[3]^4)/24 + (47*Log[3]^5)/60 + (Log[2]^3*PolyLog[2, -1/2])/
     2 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + Log[2]*PolyLog[2, -1/2]^2 - 
    Log[3]*PolyLog[2, -1/2]^2 - 2*Log[2]^2*PolyLog[3, -1/2] + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - 2*Log[3]^2*PolyLog[3, -1/2] + 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] - 3*Log[2]^2*PolyLog[3, 1/3] + 
    7*Log[2]*Log[3]*PolyLog[3, 1/3] - 4*Log[3]^2*PolyLog[3, 1/3] + 
    PolyLog[2, -1/2]*PolyLog[3, 1/3] + 3*Log[2]*PolyLog[4, 1/3] - 
    4*Log[3]*PolyLog[4, 1/3] + 2*Log[2]*PolyLog[4, 1/2] - 
    11*Log[2]*PolyLog[4, 2/3] + 11*Log[3]*PolyLog[4, 2/3] + 
    PolyLog[5, -1/2] - 4*PolyLog[5, 1/3] + 6*PolyLog[5, 1/2] + 
    17*PolyLog[5, 2/3] + 7*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/12 + 
    3*Log[2]^2*Zeta[3] - 5*Log[2]*Log[3]*Zeta[3] + (5*Log[3]^2*Zeta[3])/2 - 
    (543*Zeta[5])/32
 
G[-1, 1, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[2]^5/24 + (5*Log[2]^4*Log[3])/24 - 
    (5*Log[2]^3*Log[3]^2)/12 + (5*Log[2]^2*Log[3]^3)/12 - 
    (5*Log[2]*Log[3]^4)/24 + Log[3]^5/24 - (Log[2]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 + (Log[3]^3*PolyLog[2, -1/2])/6 - (Log[2]^2*PolyLog[3, 1/3])/2 + 
    Log[2]*Log[3]*PolyLog[3, 1/3] - (Log[3]^2*PolyLog[3, 1/3])/2 + 
    Log[2]*PolyLog[4, 1/3] - Log[3]*PolyLog[4, 1/3] - PolyLog[5, 1/3] + 
    PolyLog[5, 1/2]
 
G[0, -1, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-10*Pi^2*Log[2]^3)/27 + (62*Log[2]^5)/45 + 
    (Pi^4*Log[3])/270 + (Pi^2*Log[2]^2*Log[3])/9 - (19*Log[2]^4*Log[3])/9 + 
    (4*Log[2]^3*Log[3]^2)/3 - (Log[2]^2*Log[3]^3)/2 + (Log[2]*Log[3]^4)/3 - 
    Log[3]^5/8 + (8*Log[2]^3*PolyLog[2, -1/2])/3 - 
    4*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/3 + 8*Log[2]^2*PolyLog[3, -1/2] - 
    8*Log[2]*Log[3]*PolyLog[3, -1/2] + 2*Log[3]^2*PolyLog[3, -1/2] - 
    2*Log[2]^2*PolyLog[3, 1/3] + Log[3]^2*PolyLog[3, 1/3] + 
    20*Log[2]*PolyLog[4, -1/2] - 8*Log[3]*PolyLog[4, -1/2] + 
    2*Log[3]*PolyLog[4, 1/3] + (64*Log[2]*PolyLog[4, 1/2])/3 - 
    (32*Log[3]*PolyLog[4, 1/2])/3 - 4*Log[2]*PolyLog[4, 2/3] + 
    20*PolyLog[5, -1/2] + 4*PolyLog[5, -1/3] - 2*PolyLog[5, 1/3] + 
    (64*PolyLog[5, 1/2])/3 + 4*PolyLog[5, 2/3] + 2*PolyLog[2, 3, -1/3] - 
    4*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/3 + (34*Log[2]^2*Zeta[3])/3 - 
    (28*Log[2]*Log[3]*Zeta[3])/3 + (7*Log[3]^2*Zeta[3])/3 + 3*Zeta[5]
 
G[0, -1, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -8*G[0, -1, 0, -1, -1, 1/2] - 
    8*G[0, 0, -1, 0, -1, 1/2] - (32*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (73*Pi^4*Log[2])/405 - (244*Pi^2*Log[2]^3)/81 - (743*Log[2]^5)/135 - 
    (13*Pi^4*Log[3])/60 + (53*Pi^2*Log[2]^2*Log[3])/6 + 
    (43*Log[2]^4*Log[3])/6 - 7*Pi^2*Log[2]*Log[3]^2 + 8*Log[2]^3*Log[3]^2 + 
    (23*Pi^2*Log[3]^3)/12 - (127*Log[2]^2*Log[3]^3)/6 + 14*Log[2]*Log[3]^4 - 
    (377*Log[3]^5)/120 - (2*Pi^2*Log[2]*PolyLog[2, -1/2])/3 - 
    (8*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/3 + 
    4*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/3 - 4*Log[2]*PolyLog[2, -1/2]^2 + 
    4*Log[3]*PolyLog[2, -1/2]^2 - (2*Pi^2*PolyLog[3, -1/2])/3 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 16*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    10*Log[3]^2*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/3 + 
    30*Log[2]^2*PolyLog[3, 1/3] - 32*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    9*Log[3]^2*PolyLog[3, 1/3] - 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    72*Log[2]*PolyLog[4, -1/2] + 36*Log[3]*PolyLog[4, -1/2] + 
    16*Log[2]*PolyLog[4, -1/3] - 10*Log[3]*PolyLog[4, -1/3] - 
    16*Log[2]*PolyLog[4, 1/3] + 2*Log[3]*PolyLog[4, 1/3] - 
    (224*Log[2]*PolyLog[4, 1/2])/3 + 48*Log[3]*PolyLog[4, 1/2] + 
    80*Log[2]*PolyLog[4, 2/3] - 52*Log[3]*PolyLog[4, 2/3] - 
    (296*PolyLog[5, -1/2])/3 - 28*PolyLog[5, -1/3] + 20*PolyLog[5, 1/3] - 
    (1088*PolyLog[5, 1/2])/9 - 88*PolyLog[5, 2/3] - 8*PolyLog[2, 3, -1/3] + 
    (13*Pi^2*Zeta[3])/9 - 50*Log[2]^2*Zeta[3] + (146*Log[2]*Log[3]*Zeta[3])/
     3 - 16*Log[3]^2*Zeta[3] + (8*PolyLog[2, -1/2]*Zeta[3])/3 + 
    (454*Zeta[5])/9
 
G[0, -1, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] - (8*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (763*Pi^4*Log[2])/6480 - (415*Pi^2*Log[2]^3)/324 - (359*Log[2]^5)/540 - 
    (49*Pi^4*Log[3])/540 + (121*Pi^2*Log[2]^2*Log[3])/36 + 
    (13*Log[2]^4*Log[3])/18 - (23*Pi^2*Log[2]*Log[3]^2)/8 + 
    (41*Log[2]^3*Log[3]^2)/12 + (61*Pi^2*Log[3]^3)/72 - 
    (31*Log[2]^2*Log[3]^3)/4 + (137*Log[2]*Log[3]^4)/24 - (35*Log[3]^5)/24 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + (4*Log[2]^3*PolyLog[2, -1/2])/3 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    2*Log[2]*PolyLog[2, -1/2]^2 + 2*Log[3]*PolyLog[2, -1/2]^2 - 
    (Pi^2*PolyLog[3, -1/2])/3 + 8*Log[2]^2*PolyLog[3, -1/2] - 
    12*Log[2]*Log[3]*PolyLog[3, -1/2] + 6*Log[3]^2*PolyLog[3, -1/2] - 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/6 + 
    9*Log[2]^2*PolyLog[3, 1/3] - 12*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    5*Log[3]^2*PolyLog[3, 1/3] - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    8*Log[2]*PolyLog[4, -1/2] + 4*Log[3]*PolyLog[4, -1/2] + 
    4*Log[2]*PolyLog[4, -1/3] - 3*Log[3]*PolyLog[4, -1/3] - 
    4*Log[2]*PolyLog[4, 1/3] + 2*Log[3]*PolyLog[4, 1/3] - 
    7*Log[2]*PolyLog[4, 1/2] + (13*Log[3]*PolyLog[4, 1/2])/3 + 
    26*Log[2]*PolyLog[4, 2/3] - 22*Log[3]*PolyLog[4, 2/3] - 
    (62*PolyLog[5, -1/2])/3 - 5*PolyLog[5, -1/3] + 4*PolyLog[5, 1/3] - 
    (209*PolyLog[5, 1/2])/9 - 33*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3] - 
    6*PolyLog[2, 3, 1/3] + (41*Pi^2*Zeta[3])/144 - (65*Log[2]^2*Zeta[3])/8 + 
    (41*Log[2]*Log[3]*Zeta[3])/4 - (215*Log[3]^2*Zeta[3])/48 - 
    (PolyLog[2, -1/2]*Zeta[3])/4 + (6695*Zeta[5])/288
 
G[0, -1, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 12*G[0, -1, 0, -1, -1, 1/2] + 
    12*G[0, 0, -1, 0, -1, 1/2] + 16*G[0, 0, 1, 0, -1, 1/2] - 
    (73*Pi^4*Log[2])/270 + (119*Pi^2*Log[2]^3)/27 + (683*Log[2]^5)/90 + 
    (13*Pi^4*Log[3])/36 - (73*Pi^2*Log[2]^2*Log[3])/6 - 
    (19*Log[2]^4*Log[3])/2 + (28*Pi^2*Log[2]*Log[3]^2)/3 - 
    (37*Log[2]^3*Log[3]^2)/3 - (31*Pi^2*Log[3]^3)/12 + 
    (59*Log[2]^2*Log[3]^3)/2 - (37*Log[2]*Log[3]^4)/2 + (161*Log[3]^5)/40 + 
    (2*Pi^2*Log[2]*PolyLog[2, -1/2])/3 + (2*Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/3 - 4*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    4*Log[2]*Log[3]^2*PolyLog[2, -1/2] - Log[3]^3*PolyLog[2, -1/2] + 
    2*Log[2]*PolyLog[2, -1/2]^2 - 4*Log[3]*PolyLog[2, -1/2]^2 + 
    (2*Pi^2*PolyLog[3, -1/2])/3 - 8*Log[2]^2*PolyLog[3, -1/2] + 
    16*Log[2]*Log[3]*PolyLog[3, -1/2] - 10*Log[3]^2*PolyLog[3, -1/2] - 
    4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/3 - 
    46*Log[2]^2*PolyLog[3, 1/3] + 44*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    11*Log[3]^2*PolyLog[3, 1/3] + 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    108*Log[2]*PolyLog[4, -1/2] - 60*Log[3]*PolyLog[4, -1/2] - 
    24*Log[2]*PolyLog[4, -1/3] + 12*Log[3]*PolyLog[4, -1/3] + 
    24*Log[2]*PolyLog[4, 1/3] + 112*Log[2]*PolyLog[4, 1/2] - 
    80*Log[3]*PolyLog[4, 1/2] - 120*Log[2]*PolyLog[4, 2/3] + 
    72*Log[3]*PolyLog[4, 2/3] + 148*PolyLog[5, -1/2] + 42*PolyLog[5, -1/3] - 
    30*PolyLog[5, 1/3] + (544*PolyLog[5, 1/2])/3 + 132*PolyLog[5, 2/3] + 
    12*PolyLog[2, 3, -1/3] - (41*Pi^2*Zeta[3])/18 + 
    (223*Log[2]^2*Zeta[3])/3 - (218*Log[2]*Log[3]*Zeta[3])/3 + 
    (145*Log[3]^2*Zeta[3])/6 - (16*PolyLog[2, -1/2]*Zeta[3])/3 - 
    (227*Zeta[5])/3
 
G[0, -1, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, -1, 0, -1, 1/2] - (8*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (323*Pi^4*Log[2])/1620 + (20*Pi^2*Log[2]^3)/81 - (79*Log[2]^5)/270 + 
    (83*Pi^4*Log[3])/540 - (8*Pi^2*Log[2]^2*Log[3])/9 - 
    (5*Log[2]^4*Log[3])/18 + (4*Pi^2*Log[2]*Log[3]^2)/3 + 
    (Log[2]^3*Log[3]^2)/3 - (7*Pi^2*Log[3]^3)/12 + (11*Log[2]^2*Log[3]^3)/6 - 
    (8*Log[2]*Log[3]^4)/3 + (19*Log[3]^5)/20 + (2*Log[2]^3*PolyLog[2, -1/2])/
     3 - (Log[3]^3*PolyLog[2, -1/2])/3 + 2*Log[2]*PolyLog[2, -1/2]^2 - 
    4*Log[2]^2*PolyLog[3, -1/2] + 8*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    2*Log[3]^2*PolyLog[3, -1/2] + 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    8*Log[2]*Log[3]*PolyLog[3, 1/3] - 5*Log[3]^2*PolyLog[3, 1/3] - 
    20*Log[2]*PolyLog[4, -1/2] + 12*Log[3]*PolyLog[4, -1/2] + 
    4*Log[2]*PolyLog[4, -1/3] - 2*Log[3]*PolyLog[4, -1/3] - 
    4*Log[3]*PolyLog[4, 1/3] - (56*Log[2]*PolyLog[4, 1/2])/3 + 
    (40*Log[3]*PolyLog[4, 1/2])/3 - 8*Log[2]*PolyLog[4, 2/3] + 
    16*Log[3]*PolyLog[4, 2/3] - (92*PolyLog[5, -1/2])/3 - 
    5*PolyLog[5, -1/3] - 2*PolyLog[5, 1/3] - (272*PolyLog[5, 1/2])/9 + 
    28*PolyLog[5, 2/3] - 2*PolyLog[2, 3, -1/3] + 16*PolyLog[2, 3, 1/3] + 
    (Pi^2*Zeta[3])/6 - (23*Log[2]^2*Zeta[3])/3 + (8*Log[2]*Log[3]*Zeta[3])/
     3 + 2*Log[3]^2*Zeta[3] + (13*PolyLog[2, -1/2]*Zeta[3])/3 - 
    (541*Zeta[5])/18
 
G[0, -1, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 8*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + 13*G[0, 0, 1, 0, -1, 1/2] - 
    (1249*Pi^4*Log[2])/4320 + (751*Pi^2*Log[2]^3)/216 + (2219*Log[2]^5)/360 + 
    (29*Pi^4*Log[3])/72 - (233*Pi^2*Log[2]^2*Log[3])/24 - 7*Log[2]^4*Log[3] + 
    (181*Pi^2*Log[2]*Log[3]^2)/24 - (37*Log[2]^3*Log[3]^2)/3 - 
    (101*Pi^2*Log[3]^3)/48 + (107*Log[2]^2*Log[3]^3)/4 - 
    (793*Log[2]*Log[3]^4)/48 + (107*Log[3]^5)/30 + 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 - 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (2*Log[3]^3*PolyLog[2, -1/2])/3 + 
    2*Log[2]*PolyLog[2, -1/2]^2 - 2*Log[3]*PolyLog[2, -1/2]^2 - 
    6*Log[2]^2*PolyLog[3, -1/2] + 12*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    6*Log[3]^2*PolyLog[3, -1/2] - 42*Log[2]^2*PolyLog[3, 1/3] + 
    45*Log[2]*Log[3]*PolyLog[3, 1/3] - (51*Log[3]^2*PolyLog[3, 1/3])/4 + 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 82*Log[2]*PolyLog[4, -1/2] - 
    43*Log[3]*PolyLog[4, -1/2] - (39*Log[2]*PolyLog[4, -1/3])/2 + 
    (39*Log[3]*PolyLog[4, -1/3])/4 + 31*Log[2]*PolyLog[4, 1/3] - 
    (23*Log[3]*PolyLog[4, 1/3])/2 + 91*Log[2]*PolyLog[4, 1/2] - 
    65*Log[3]*PolyLog[4, 1/2] - 102*Log[2]*PolyLog[4, 2/3] + 
    63*Log[3]*PolyLog[4, 2/3] + 103*PolyLog[5, -1/2] + 34*PolyLog[5, -1/3] - 
    (75*PolyLog[5, 1/3])/2 + (442*PolyLog[5, 1/2])/3 + 118*PolyLog[5, 2/3] + 
    (39*PolyLog[2, 3, -1/3])/4 + 8*PolyLog[2, 3, 1/3] - 
    (73*Pi^2*Zeta[3])/48 + (2939*Log[2]^2*Zeta[3])/48 - 
    (1457*Log[2]*Log[3]*Zeta[3])/24 + (935*Log[3]^2*Zeta[3])/48 - 
    (11*PolyLog[2, -1/2]*Zeta[3])/12 - (7769*Zeta[5])/96
 
G[0, -1, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] - G[0, 0, 1, 0, -1, 1/2]/3 - 
    (2159*Pi^4*Log[2])/12960 + (77*Pi^2*Log[2]^3)/162 + (991*Log[2]^5)/1080 + 
    (449*Pi^4*Log[3])/4320 - (149*Pi^2*Log[2]^2*Log[3])/72 - 
    (323*Log[2]^4*Log[3])/144 + (115*Pi^2*Log[2]*Log[3]^2)/48 + 
    (5*Log[2]^3*Log[3]^2)/6 - (31*Pi^2*Log[3]^3)/36 + 
    (23*Log[2]^2*Log[3]^3)/8 - (113*Log[2]*Log[3]^4)/32 + 
    (1127*Log[3]^5)/960 + Log[2]^3*PolyLog[2, -1/2] - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 3*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    3*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (2*Log[3]^3*PolyLog[2, -1/2])/3 + 
    Log[2]*PolyLog[2, -1/2]^2 - 2*Log[3]*PolyLog[2, -1/2]^2 + 
    (Pi^2*PolyLog[3, -1/2])/3 - 2*Log[2]^2*PolyLog[3, -1/2] + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - 4*Log[3]^2*PolyLog[3, -1/2] + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/6 - 
    (9*Log[2]^2*PolyLog[3, 1/3])/2 + (13*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (29*Log[3]^2*PolyLog[3, 1/3])/8 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    3*Log[2]*PolyLog[4, -1/2] - (5*Log[3]*PolyLog[4, -1/2])/2 + 
    (11*Log[2]*PolyLog[4, -1/3])/4 - (11*Log[3]*PolyLog[4, -1/3])/8 - 
    (11*Log[2]*PolyLog[4, 1/3])/2 + (19*Log[3]*PolyLog[4, 1/3])/4 + 
    (5*Log[2]*PolyLog[4, 1/2])/3 - (Log[3]*PolyLog[4, 1/2])/3 - 
    19*Log[2]*PolyLog[4, 2/3] + (39*Log[3]*PolyLog[4, 2/3])/2 + 
    (29*PolyLog[5, -1/2])/3 - PolyLog[5, -1/3]/8 + (7*PolyLog[5, 1/3])/2 + 
    (11*PolyLog[5, 1/2])/9 + 33*PolyLog[5, 2/3] + (5*PolyLog[2, 3, -1/3])/8 + 
    8*PolyLog[2, 3, 1/3] - (127*Pi^2*Zeta[3])/288 + 
    (95*Log[2]^2*Zeta[3])/12 - (95*Log[2]*Log[3]*Zeta[3])/8 + 
    (191*Log[3]^2*Zeta[3])/32 + (PolyLog[2, -1/2]*Zeta[3])/2 - 
    (12679*Zeta[5])/576
 
G[0, -1, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] - 
    8*G[0, 0, -1, 0, -1, 1/2] - (47*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (11*Pi^4*Log[2])/810 - (2165*Pi^2*Log[2]^3)/648 - (7687*Log[2]^5)/1080 - 
    (239*Pi^4*Log[3])/1440 + (223*Pi^2*Log[2]^2*Log[3])/24 + 
    (337*Log[2]^4*Log[3])/48 - (293*Pi^2*Log[2]*Log[3]^2)/48 + 
    (83*Log[2]^3*Log[3]^2)/6 + (95*Pi^2*Log[3]^3)/72 - 
    (629*Log[2]^2*Log[3]^3)/24 + (1337*Log[2]*Log[3]^4)/96 - 
    (461*Log[3]^5)/192 - (Pi^2*Log[2]*PolyLog[2, -1/2])/3 - 
    (4*Log[2]^3*PolyLog[2, -1/2])/3 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] - Log[2]*PolyLog[2, -1/2]^2 + 
    2*Log[3]*PolyLog[2, -1/2]^2 - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    4*Log[3]^2*PolyLog[3, -1/2] + 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    44*Log[2]^2*PolyLog[3, 1/3] - (73*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (47*Log[3]^2*PolyLog[3, 1/3])/8 - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    110*Log[2]*PolyLog[4, -1/2] + (117*Log[3]*PolyLog[4, -1/2])/2 + 
    (107*Log[2]*PolyLog[4, -1/3])/4 - (123*Log[3]*PolyLog[4, -1/3])/8 - 
    (65*Log[2]*PolyLog[4, 1/3])/2 + (31*Log[3]*PolyLog[4, 1/3])/4 - 
    (355*Log[2]*PolyLog[4, 1/2])/3 + 82*Log[3]*PolyLog[4, 1/2] + 
    94*Log[2]*PolyLog[4, 2/3] - (87*Log[3]*PolyLog[4, 2/3])/2 - 
    (419*PolyLog[5, -1/2])/3 - (361*PolyLog[5, -1/3])/8 + 
    (75*PolyLog[5, 1/3])/2 - (1652*PolyLog[5, 1/2])/9 - 82*PolyLog[5, 2/3] - 
    (107*PolyLog[2, 3, -1/3])/8 + 17*PolyLog[2, 3, 1/3] + 
    (47*Pi^2*Zeta[3])/24 - (1209*Log[2]^2*Zeta[3])/16 + 
    (1565*Log[2]*Log[3]*Zeta[3])/24 - (1603*Log[3]^2*Zeta[3])/96 + 
    (11*PolyLog[2, -1/2]*Zeta[3])/2 + (4801*Zeta[5])/144
 
G[0, -1, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] - 3*G[0, 0, 1, 0, -1, 1/2] - 
    (43*Pi^4*Log[2])/432 - (13*Pi^2*Log[2]^3)/27 - (25*Log[2]^5)/36 + 
    (323*Pi^4*Log[3])/4320 + (67*Pi^2*Log[2]^2*Log[3])/72 + 
    (Log[2]^4*Log[3])/144 - (Pi^2*Log[2]*Log[3]^2)/16 + 
    (8*Log[2]^3*Log[3]^2)/3 - (13*Pi^2*Log[3]^3)/72 - 
    (71*Log[2]^2*Log[3]^3)/24 + (19*Log[2]*Log[3]^4)/32 + (61*Log[3]^5)/320 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + (2*Log[2]^3*PolyLog[2, -1/2])/3 - 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/3 + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    5*Log[2]^2*PolyLog[3, 1/3] - (Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (17*Log[3]^2*PolyLog[3, 1/3])/8 - 20*Log[2]*PolyLog[4, -1/2] + 
    (21*Log[3]*PolyLog[4, -1/2])/2 + (27*Log[2]*PolyLog[4, -1/3])/4 - 
    (35*Log[3]*PolyLog[4, -1/3])/8 - (9*Log[2]*PolyLog[4, 1/3])/2 - 
    (Log[3]*PolyLog[4, 1/3])/4 - 19*Log[2]*PolyLog[4, 1/2] + 
    (38*Log[3]*PolyLog[4, 1/2])/3 + 7*Log[2]*PolyLog[4, 2/3] + 
    (5*Log[3]*PolyLog[4, 2/3])/2 - 25*PolyLog[5, -1/2] - 
    (73*PolyLog[5, -1/3])/8 + (7*PolyLog[5, 1/3])/2 - 
    (89*PolyLog[5, 1/2])/3 + 5*PolyLog[5, 2/3] - (19*PolyLog[2, 3, -1/3])/8 + 
    11*PolyLog[2, 3, 1/3] + (3*Pi^2*Zeta[3])/8 - (81*Log[2]^2*Zeta[3])/8 + 
    (125*Log[2]*Log[3]*Zeta[3])/24 + (Log[3]^2*Zeta[3])/32 + 
    (7*PolyLog[2, -1/2]*Zeta[3])/4 - (715*Zeta[5])/48
 
G[0, -1, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, -1, 0, -1, 1/2] - (16*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (73*Pi^4*Log[2])/810 - (113*Pi^2*Log[2]^3)/81 - (563*Log[2]^5)/270 - 
    (13*Pi^4*Log[3])/108 + (35*Pi^2*Log[2]^2*Log[3])/9 + 
    (23*Log[2]^4*Log[3])/18 - 3*Pi^2*Log[2]*Log[3]^2 + 7*Log[2]^3*Log[3]^2 + 
    (5*Pi^2*Log[3]^3)/6 - (71*Log[2]^2*Log[3]^3)/6 + (41*Log[2]*Log[3]^4)/6 - 
    (57*Log[3]^5)/40 + 2*Log[2]^3*PolyLog[2, -1/2] - 
    4*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/3 + 2*Log[2]*PolyLog[2, -1/2]^2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 8*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    4*Log[3]^2*PolyLog[3, -1/2] + 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    16*Log[2]^2*PolyLog[3, 1/3] - 16*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    4*Log[3]^2*PolyLog[3, 1/3] - 36*Log[2]*PolyLog[4, -1/2] + 
    20*Log[3]*PolyLog[4, -1/2] + 8*Log[2]*PolyLog[4, -1/3] - 
    4*Log[3]*PolyLog[4, -1/3] - 8*Log[2]*PolyLog[4, 1/3] - 
    (112*Log[2]*PolyLog[4, 1/2])/3 + (80*Log[3]*PolyLog[4, 1/2])/3 + 
    40*Log[2]*PolyLog[4, 2/3] - 24*Log[3]*PolyLog[4, 2/3] - 
    (148*PolyLog[5, -1/2])/3 - 14*PolyLog[5, -1/3] + 10*PolyLog[5, 1/3] - 
    (544*PolyLog[5, 1/2])/9 - 44*PolyLog[5, 2/3] - 2*PolyLog[2, 3, -1/3] + 
    (5*Pi^2*Zeta[3])/6 - (73*Log[2]^2*Zeta[3])/3 + 
    (70*Log[2]*Log[3]*Zeta[3])/3 - (47*Log[3]^2*Zeta[3])/6 + 
    (8*PolyLog[2, -1/2]*Zeta[3])/3 + (227*Zeta[5])/9
 
G[0, -1, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -16*G[0, -1, 0, -1, -1, 1/2] + 
    16*G[0, 0, -1, 0, -1, 1/2] + (32*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (323*Pi^4*Log[2])/405 - (80*Pi^2*Log[2]^3)/81 + (158*Log[2]^5)/135 - 
    (209*Pi^4*Log[3])/360 + (25*Pi^2*Log[2]^2*Log[3])/6 + 
    (19*Log[2]^4*Log[3])/6 - 7*Pi^2*Log[2]*Log[3]^2 - 
    (14*Log[2]^3*Log[3]^2)/3 + (107*Pi^2*Log[3]^3)/36 - 
    (15*Log[2]^2*Log[3]^3)/2 + (41*Log[2]*Log[3]^4)/3 - (611*Log[3]^5)/120 - 
    (8*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/3 + 
    6*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 4*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    Log[3]^3*PolyLog[2, -1/2] - 8*Log[2]*PolyLog[2, -1/2]^2 + 
    6*Log[3]*PolyLog[2, -1/2]^2 + 16*Log[2]^2*PolyLog[3, -1/2] - 
    32*Log[2]*Log[3]*PolyLog[3, -1/2] + 16*Log[3]^2*PolyLog[3, -1/2] - 
    16*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (2*Pi^2*PolyLog[3, 1/3])/3 - 
    4*Log[2]^2*PolyLog[3, 1/3] - 32*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    26*Log[3]^2*PolyLog[3, 1/3] - 8*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    80*Log[2]*PolyLog[4, -1/2] - 40*Log[3]*PolyLog[4, -1/2] - 
    16*Log[2]*PolyLog[4, -1/3] + 6*Log[3]*PolyLog[4, -1/3] + 
    20*Log[3]*PolyLog[4, 1/3] + (224*Log[2]*PolyLog[4, 1/2])/3 - 
    48*Log[3]*PolyLog[4, 1/2] + 32*Log[2]*PolyLog[4, 2/3] - 
    72*Log[3]*PolyLog[4, 2/3] + (368*PolyLog[5, -1/2])/3 + 
    20*PolyLog[5, -1/3] + 8*PolyLog[5, 1/3] + (1088*PolyLog[5, 1/2])/9 - 
    112*PolyLog[5, 2/3] + 8*PolyLog[2, 3, -1/3] - 64*PolyLog[2, 3, 1/3] + 
    (Pi^2*Zeta[3])/18 + 35*Log[2]^2*Zeta[3] - (20*Log[2]*Log[3]*Zeta[3])/3 - 
    (19*Log[3]^2*Zeta[3])/2 - (26*PolyLog[2, -1/2]*Zeta[3])/3 + 
    (1082*Zeta[5])/9
 
G[0, -1, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -10*G[0, -1, 0, -1, -1, 1/2] + 
    8*G[0, 0, -1, 0, -1, 1/2] - (2*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (6863*Pi^4*Log[2])/12960 - (631*Pi^2*Log[2]^3)/324 - 
    (1007*Log[2]^5)/540 - (1927*Pi^4*Log[3])/4320 + 
    (115*Pi^2*Log[2]^2*Log[3])/18 + (379*Log[2]^4*Log[3])/144 - 
    (319*Pi^2*Log[2]*Log[3]^2)/48 + (13*Log[2]^3*Log[3]^2)/2 + 
    (331*Pi^2*Log[3]^3)/144 - (425*Log[2]^2*Log[3]^3)/24 + 
    (1387*Log[2]*Log[3]^4)/96 - (3881*Log[3]^5)/960 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    3*Log[2]*PolyLog[2, -1/2]^2 + 3*Log[3]*PolyLog[2, -1/2]^2 + 
    10*Log[2]^2*PolyLog[3, -1/2] - 20*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    10*Log[3]^2*PolyLog[3, -1/2] - 8*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/3 + 21*Log[2]^2*PolyLog[3, 1/3] - 
    (75*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + (149*Log[3]^2*PolyLog[3, 1/3])/8 - 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 2*Log[2]*PolyLog[4, -1/2] - 
    (5*Log[3]*PolyLog[4, -1/2])/2 + (9*Log[2]*PolyLog[4, -1/3])/4 - 
    (17*Log[3]*PolyLog[4, -1/3])/8 - (35*Log[2]*PolyLog[4, 1/3])/2 + 
    (69*Log[3]*PolyLog[4, 1/3])/4 - 4*Log[2]*PolyLog[4, 1/2] + 
    (11*Log[3]*PolyLog[4, 1/2])/3 + 62*Log[2]*PolyLog[4, 2/3] - 
    (123*Log[3]*PolyLog[4, 2/3])/2 + (64*PolyLog[5, -1/2])/3 - 
    (49*PolyLog[5, -1/3])/8 + 23*PolyLog[5, 1/3] - (2*PolyLog[5, 1/2])/9 - 
    104*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3]/8 - 33*PolyLog[2, 3, 1/3] + 
    (103*Pi^2*Zeta[3])/144 - (127*Log[2]^2*Zeta[3])/8 + 
    (197*Log[2]*Log[3]*Zeta[3])/8 - (1217*Log[3]^2*Zeta[3])/96 - 
    (55*PolyLog[2, -1/2]*Zeta[3])/12 + (25565*Zeta[5])/288
 
G[0, -1, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 12*G[0, -1, 0, -1, -1, 1/2] - 
    12*G[0, 0, -1, 0, -1, 1/2] - 8*G[0, 0, 1, 0, -1, 1/2] - 
    (323*Pi^4*Log[2])/540 + (14*Pi^2*Log[2]^3)/27 - (163*Log[2]^5)/90 + 
    (167*Pi^4*Log[3])/360 - (13*Pi^2*Log[2]^2*Log[3])/6 - 2*Log[2]^4*Log[3] + 
    (13*Pi^2*Log[2]*Log[3]^2)/3 + 7*Log[2]^3*Log[3]^2 - 
    (71*Pi^2*Log[3]^3)/36 + (Log[2]^2*Log[3]^3)/6 - (22*Log[2]*Log[3]^4)/3 + 
    (10*Log[3]^5)/3 + 2*Log[2]^3*PolyLog[2, -1/2] - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/3 - 6*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    6*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (5*Log[3]^3*PolyLog[2, -1/2])/3 + 
    6*Log[2]*PolyLog[2, -1/2]^2 - 6*Log[3]*PolyLog[2, -1/2]^2 - 
    12*Log[2]^2*PolyLog[3, -1/2] + 24*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    12*Log[3]^2*PolyLog[3, -1/2] + 12*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (2*Pi^2*PolyLog[3, 1/3])/3 + 10*Log[2]^2*PolyLog[3, 1/3] + 
    16*Log[2]*Log[3]*PolyLog[3, 1/3] - 19*Log[3]^2*PolyLog[3, 1/3] + 
    8*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 72*Log[2]*PolyLog[4, -1/2] + 
    36*Log[3]*PolyLog[4, -1/2] + 12*Log[2]*PolyLog[4, -1/3] - 
    6*Log[3]*PolyLog[4, -1/3] - 18*Log[3]*PolyLog[4, 1/3] - 
    72*Log[2]*PolyLog[4, 1/2] + 48*Log[3]*PolyLog[4, 1/2] - 
    12*Log[2]*PolyLog[4, 2/3] + 48*Log[3]*PolyLog[4, 2/3] - 
    104*PolyLog[5, -1/2] - 24*PolyLog[5, -1/3] - (320*PolyLog[5, 1/2])/3 + 
    72*PolyLog[5, 2/3] - 9*PolyLog[2, 3, -1/3] + 60*PolyLog[2, 3, 1/3] + 
    (7*Pi^2*Zeta[3])/9 - (121*Log[2]^2*Zeta[3])/3 + 
    (71*Log[2]*Log[3]*Zeta[3])/3 + (Log[3]^2*Zeta[3])/12 + 
    (13*PolyLog[2, -1/2]*Zeta[3])/3 - (595*Zeta[5])/6
 
G[0, -1, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (5*Pi^2*Log[3]^3)/36 - (Log[2]^2*Log[3]^3)/6 + 
    (Log[2]*Log[3]^4)/3 - Log[3]^5/4 - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    2*Log[3]^2*PolyLog[3, 1/3] + 3*Log[3]*PolyLog[4, -1/3] + 
    4*PolyLog[5, -1/3] - (13*Log[3]^2*Zeta[3])/6
 
G[0, -1, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, -1, 0, -1, -1, 1/2] - 
    6*G[0, 0, -1, 0, -1, 1/2] - (2*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (2123*Pi^4*Log[2])/6480 + (299*Pi^2*Log[2]^3)/324 + (113*Log[2]^5)/270 + 
    (641*Pi^4*Log[3])/2160 - (101*Pi^2*Log[2]^2*Log[3])/36 - 
    (19*Log[2]^4*Log[3])/9 + (13*Pi^2*Log[2]*Log[3]^2)/4 + 
    (Log[2]^3*Log[3]^2)/6 - (41*Pi^2*Log[3]^3)/36 + 
    (35*Log[2]^2*Log[3]^3)/6 - (53*Log[2]*Log[3]^4)/8 + (253*Log[3]^5)/120 + 
    Log[2]^3*PolyLog[2, -1/2] - 3*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    3*Log[2]*Log[3]^2*PolyLog[2, -1/2] - Log[3]^3*PolyLog[2, -1/2] + 
    3*Log[2]*PolyLog[2, -1/2]^2 - 3*Log[3]*PolyLog[2, -1/2]^2 - 
    6*Log[2]^2*PolyLog[3, -1/2] + 12*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    6*Log[3]^2*PolyLog[3, -1/2] + 6*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    5*Log[2]^2*PolyLog[3, 1/3] + 18*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    11*Log[3]^2*PolyLog[3, 1/3] + 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    16*Log[2]*PolyLog[4, -1/2] + 8*Log[3]*PolyLog[4, -1/2] + 
    Log[2]*PolyLog[4, -1/3] + Log[3]*PolyLog[4, -1/3] + 
    10*Log[2]*PolyLog[4, 1/3] - 14*Log[3]*PolyLog[4, 1/3] - 
    (38*Log[2]*PolyLog[4, 1/2])/3 + (22*Log[3]*PolyLog[4, 1/2])/3 - 
    26*Log[2]*PolyLog[4, 2/3] + 34*Log[3]*PolyLog[4, 2/3] - 
    (86*PolyLog[5, -1/2])/3 - 2*PolyLog[5, -1/3] - 11*PolyLog[5, 1/3] - 
    (140*PolyLog[5, 1/2])/9 + 56*PolyLog[5, 2/3] - 2*PolyLog[2, 3, -1/3] + 
    30*PolyLog[2, 3, 1/3] + (11*Pi^2*Zeta[3])/24 - 
    (155*Log[2]^2*Zeta[3])/24 + (Log[2]*Log[3]*Zeta[3])/4 + 
    (5*Log[3]^2*Zeta[3])/3 - (4627*Zeta[5])/72
 
G[0, -1, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] - 
    10*G[0, 0, -1, 0, -1, 1/2] - (50*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (2923*Pi^4*Log[2])/12960 - (673*Pi^2*Log[2]^3)/324 - (139*Log[2]^5)/27 - 
    (23*Pi^4*Log[3])/4320 + (43*Pi^2*Log[2]^2*Log[3])/9 + 
    (455*Log[2]^4*Log[3])/144 - (89*Pi^2*Log[2]*Log[3]^2)/48 + 
    (40*Log[2]^3*Log[3]^2)/3 + (Pi^2*Log[3]^3)/144 - 
    (437*Log[2]^2*Log[3]^3)/24 + (613*Log[2]*Log[3]^4)/96 - 
    (67*Log[3]^5)/320 - (Pi^2*Log[2]*PolyLog[2, -1/2])/3 + 
    (5*Log[2]^3*PolyLog[2, -1/2])/3 - (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    4*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 4*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    Log[3]^3*PolyLog[2, -1/2] + 4*Log[2]*PolyLog[2, -1/2]^2 - 
    3*Log[3]*PolyLog[2, -1/2]^2 - 4*Log[2]^2*PolyLog[3, -1/2] + 
    8*Log[2]*Log[3]*PolyLog[3, -1/2] - 4*Log[3]^2*PolyLog[3, -1/2] + 
    10*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/3 + 
    33*Log[2]^2*PolyLog[3, 1/3] - (43*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (19*Log[3]^2*PolyLog[3, 1/3])/8 + 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    104*Log[2]*PolyLog[4, -1/2] + (111*Log[3]*PolyLog[4, -1/2])/2 + 
    (95*Log[2]*PolyLog[4, -1/3])/4 - (95*Log[3]*PolyLog[4, -1/3])/8 - 
    (61*Log[2]*PolyLog[4, 1/3])/2 + (15*Log[3]*PolyLog[4, 1/3])/4 - 
    (344*Log[2]*PolyLog[4, 1/2])/3 + (247*Log[3]*PolyLog[4, 1/2])/3 + 
    58*Log[2]*PolyLog[4, 2/3] - (19*Log[3]*PolyLog[4, 2/3])/2 - 
    (434*PolyLog[5, -1/2])/3 - (319*PolyLog[5, -1/3])/8 + 
    (67*PolyLog[5, 1/3])/2 - (1742*PolyLog[5, 1/2])/9 - 30*PolyLog[5, 2/3] - 
    (89*PolyLog[2, 3, -1/3])/8 + 31*PolyLog[2, 3, 1/3] + 
    (179*Pi^2*Zeta[3])/144 - (725*Log[2]^2*Zeta[3])/12 + 
    (403*Log[2]*Log[3]*Zeta[3])/8 - (339*Log[3]^2*Zeta[3])/32 + 
    (11*PolyLog[2, -1/2]*Zeta[3])/2 - (11*Zeta[5])/576
 
G[0, -1, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -8*G[0, -1, 0, -1, -1, 1/2] + 
    8*G[0, 0, -1, 0, -1, 1/2] - (28*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1699*Pi^4*Log[2])/3240 - (553*Pi^2*Log[2]^3)/162 - (283*Log[2]^5)/54 - 
    (2567*Pi^4*Log[3])/4320 + (91*Pi^2*Log[2]^2*Log[3])/9 + 
    (227*Log[2]^4*Log[3])/36 - (53*Pi^2*Log[2]*Log[3]^2)/6 + 
    (37*Log[2]^3*Log[3]^2)/3 + (389*Pi^2*Log[3]^3)/144 - 
    (59*Log[2]^2*Log[3]^3)/2 + (83*Log[2]*Log[3]^4)/4 - (2459*Log[3]^5)/480 - 
    (4*Log[2]^3*PolyLog[2, -1/2])/3 + 3*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    4*Log[2]*PolyLog[2, -1/2]^2 + 3*Log[3]*PolyLog[2, -1/2]^2 + 
    8*Log[2]^2*PolyLog[3, -1/2] - 16*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    8*Log[3]^2*PolyLog[3, -1/2] - 8*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    42*Log[2]^2*PolyLog[3, 1/3] - 60*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    25*Log[3]^2*PolyLog[3, 1/3] - 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    48*Log[2]*PolyLog[4, -1/2] + 24*Log[3]*PolyLog[4, -1/2] + 
    14*Log[2]*PolyLog[4, -1/3] - (31*Log[3]*PolyLog[4, -1/3])/4 - 
    44*Log[2]*PolyLog[4, 1/3] + (69*Log[3]*PolyLog[4, 1/3])/2 - 
    (196*Log[2]*PolyLog[4, 1/2])/3 + (136*Log[3]*PolyLog[4, 1/2])/3 + 
    104*Log[2]*PolyLog[4, 2/3] - 80*Log[3]*PolyLog[4, 2/3] - 
    (124*PolyLog[5, -1/2])/3 - (49*PolyLog[5, -1/3])/2 + 55*PolyLog[5, 1/3] - 
    (952*PolyLog[5, 1/2])/9 - 144*PolyLog[5, 2/3] - 7*PolyLog[2, 3, -1/3] - 
    32*PolyLog[2, 3, 1/3] + (11*Pi^2*Zeta[3])/12 - 
    (545*Log[2]^2*Zeta[3])/12 + (148*Log[2]*Log[3]*Zeta[3])/3 - 
    (71*Log[3]^2*Zeta[3])/4 + (8911*Zeta[5])/72
 
G[0, -1, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] - 
    7*G[0, 0, 1, 0, -1, 1/2] + (547*Pi^4*Log[2])/4320 - 
    (119*Pi^2*Log[2]^3)/72 - (1003*Log[2]^5)/360 - (751*Pi^4*Log[3])/4320 + 
    (325*Pi^2*Log[2]^2*Log[3])/72 + (343*Log[2]^4*Log[3])/144 - 
    (27*Pi^2*Log[2]*Log[3]^2)/8 + (47*Log[2]^3*Log[3]^2)/6 + 
    (131*Pi^2*Log[3]^3)/144 - (347*Log[2]^2*Log[3]^3)/24 + 
    (407*Log[2]*Log[3]^4)/48 - (561*Log[3]^5)/320 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]^2*PolyLog[3, -1/2] + 22*Log[2]^2*PolyLog[3, 1/3] - 
    (49*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + (59*Log[3]^2*PolyLog[3, 1/3])/8 - 
    40*Log[2]*PolyLog[4, -1/2] + (41*Log[3]*PolyLog[4, -1/2])/2 + 
    (21*Log[2]*PolyLog[4, -1/3])/2 - (45*Log[3]*PolyLog[4, -1/3])/8 - 
    21*Log[2]*PolyLog[4, 1/3] + (45*Log[3]*PolyLog[4, 1/3])/4 - 
    (137*Log[2]*PolyLog[4, 1/2])/3 + (98*Log[3]*PolyLog[4, 1/2])/3 + 
    48*Log[2]*PolyLog[4, 2/3] - (57*Log[3]*PolyLog[4, 2/3])/2 - 
    47*PolyLog[5, -1/2] - (145*PolyLog[5, -1/3])/8 + (51*PolyLog[5, 1/3])/2 - 
    76*PolyLog[5, 1/2] - 54*PolyLog[5, 2/3] - (39*PolyLog[2, 3, -1/3])/8 - 
    PolyLog[2, 3, 1/3] + (5*Pi^2*Zeta[3])/6 - (1421*Log[2]^2*Zeta[3])/48 + 
    (85*Log[2]*Log[3]*Zeta[3])/3 - (859*Log[3]^2*Zeta[3])/96 + 
    (6427*Zeta[5])/192
 
G[0, -1, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, 1, 0, -1, 1/2] + (143*Pi^4*Log[2])/2160 + 
    (31*Pi^2*Log[2]^3)/216 + (37*Log[2]^5)/24 + (59*Pi^4*Log[3])/4320 - 
    (23*Pi^2*Log[2]^2*Log[3])/72 - (353*Log[2]^4*Log[3])/144 - 
    (7*Pi^2*Log[2]*Log[3]^2)/48 + (2*Log[2]^3*Log[3]^2)/3 + 
    (5*Pi^2*Log[3]^3)/36 + (13*Log[2]^2*Log[3]^3)/24 + 
    (17*Log[2]*Log[3]^4)/96 - (73*Log[3]^5)/320 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + (5*Log[2]^3*PolyLog[2, -1/2])/3 - 
    4*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/3 + Log[2]*PolyLog[2, -1/2]^2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 6*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (5*Log[3]^2*PolyLog[3, -1/2])/2 - 3*Log[2]^2*PolyLog[3, 1/3] + 
    (Log[2]*Log[3]*PolyLog[3, 1/3])/2 + (9*Log[3]^2*PolyLog[3, 1/3])/8 + 
    24*Log[2]*PolyLog[4, -1/2] - (23*Log[3]*PolyLog[4, -1/2])/2 - 
    (25*Log[2]*PolyLog[4, -1/3])/4 + (25*Log[3]*PolyLog[4, -1/3])/8 + 
    (15*Log[2]*PolyLog[4, 1/3])/2 - (13*Log[3]*PolyLog[4, 1/3])/4 + 
    (92*Log[2]*PolyLog[4, 1/2])/3 - (55*Log[3]*PolyLog[4, 1/2])/3 - 
    8*Log[2]*PolyLog[4, 2/3] - (Log[3]*PolyLog[4, 2/3])/2 + 
    30*PolyLog[5, -1/2] + (71*PolyLog[5, -1/3])/8 - 9*PolyLog[5, 1/3] + 
    (145*PolyLog[5, 1/2])/3 + 3*PolyLog[5, 2/3] + (23*PolyLog[2, 3, -1/3])/
     8 - 5*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/24 + (75*Log[2]^2*Zeta[3])/8 - 
    (57*Log[2]*Log[3]*Zeta[3])/8 + (25*Log[3]^2*Zeta[3])/32 - 
    (PolyLog[2, -1/2]*Zeta[3])/4 - (67*Zeta[5])/12
 
G[0, -1, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -12*G[0, -1, 0, -1, -1, 1/2] + 
    8*G[0, 0, -1, 0, -1, 1/2] + (16*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (3391*Pi^4*Log[2])/6480 - (187*Pi^2*Log[2]^3)/324 + (29*Log[2]^5)/27 - 
    (37*Pi^4*Log[3])/90 + (59*Pi^2*Log[2]^2*Log[3])/24 + 
    (61*Log[2]^4*Log[3])/24 - (115*Pi^2*Log[2]*Log[3]^2)/24 - 
    (59*Log[2]^3*Log[3]^2)/12 + (305*Pi^2*Log[3]^3)/144 - 
    (41*Log[2]^2*Log[3]^3)/12 + (433*Log[2]*Log[3]^4)/48 - 
    (431*Log[3]^5)/120 - (7*Log[2]^3*PolyLog[2, -1/2])/3 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/3 + 5*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    3*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (2*Log[3]^3*PolyLog[2, -1/2])/3 - 
    6*Log[2]*PolyLog[2, -1/2]^2 + 5*Log[3]*PolyLog[2, -1/2]^2 - 
    (Pi^2*PolyLog[3, -1/2])/6 + 11*Log[2]^2*PolyLog[3, -1/2] - 
    24*Log[2]*Log[3]*PolyLog[3, -1/2] + (25*Log[3]^2*PolyLog[3, -1/2])/2 - 
    10*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/2 - 
    7*Log[2]^2*PolyLog[3, 1/3] - 21*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (77*Log[3]^2*PolyLog[3, 1/3])/4 - 6*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    56*Log[2]*PolyLog[4, -1/2] - 28*Log[3]*PolyLog[4, -1/2] - 
    (29*Log[2]*PolyLog[4, -1/3])/2 + (15*Log[3]*PolyLog[4, -1/3])/2 + 
    3*Log[2]*PolyLog[4, 1/3] + 13*Log[3]*PolyLog[4, 1/3] + 
    (164*Log[2]*PolyLog[4, 1/2])/3 - 37*Log[3]*PolyLog[4, 1/2] + 
    16*Log[2]*PolyLog[4, 2/3] - 48*Log[3]*PolyLog[4, 2/3] + 
    (220*PolyLog[5, -1/2])/3 + (89*PolyLog[5, -1/3])/4 + 
    (652*PolyLog[5, 1/2])/9 - 72*PolyLog[5, 2/3] + 
    (29*PolyLog[2, 3, -1/3])/4 - 50*PolyLog[2, 3, 1/3] - 
    (71*Pi^2*Zeta[3])/144 + (743*Log[2]^2*Zeta[3])/24 - 
    (113*Log[2]*Log[3]*Zeta[3])/12 - (127*Log[3]^2*Zeta[3])/24 - 
    (55*PolyLog[2, -1/2]*Zeta[3])/12 + (13705*Zeta[5])/144
 
G[0, -1, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -7*G[0, -1, 0, -1, -1, 1/2] + 
    6*G[0, 0, -1, 0, -1, 1/2] + (7*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (2269*Pi^4*Log[2])/6480 - (229*Pi^2*Log[2]^3)/324 + (119*Log[2]^5)/270 - 
    (1249*Pi^4*Log[3])/4320 + (199*Pi^2*Log[2]^2*Log[3])/72 + 
    (5*Log[2]^4*Log[3])/72 - (179*Pi^2*Log[2]*Log[3]^2)/48 + 
    (5*Log[2]^3*Log[3]^2)/3 + (35*Pi^2*Log[3]^3)/24 - 
    (43*Log[2]^2*Log[3]^3)/6 + (249*Log[2]*Log[3]^4)/32 - 
    (411*Log[3]^5)/160 + (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + 
    (Log[2]^3*PolyLog[2, -1/2])/6 + (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 + (Log[3]^3*PolyLog[2, -1/2])/6 - (5*Log[2]*PolyLog[2, -1/2]^2)/2 + 
    (5*Log[3]*PolyLog[2, -1/2]^2)/2 - (Pi^2*PolyLog[3, -1/2])/12 + 
    8*Log[2]^2*PolyLog[3, -1/2] - 15*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (15*Log[3]^2*PolyLog[3, -1/2])/2 - 7*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/4 + (11*Log[2]^2*PolyLog[3, 1/3])/2 - 
    21*Log[2]*Log[3]*PolyLog[3, 1/3] + (55*Log[3]^2*PolyLog[3, 1/3])/4 - 
    3*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 28*Log[2]*PolyLog[4, -1/2] - 
    15*Log[3]*PolyLog[4, -1/2] - (27*Log[2]*PolyLog[4, -1/3])/4 + 
    (7*Log[3]*PolyLog[4, -1/3])/2 - (11*Log[2]*PolyLog[4, 1/3])/2 + 
    12*Log[3]*PolyLog[4, 1/3] + 26*Log[2]*PolyLog[4, 1/2] - 
    (52*Log[3]*PolyLog[4, 1/2])/3 + 22*Log[2]*PolyLog[4, 2/3] - 
    35*Log[3]*PolyLog[4, 2/3] + (118*PolyLog[5, -1/2])/3 + 
    10*PolyLog[5, -1/3] + (15*PolyLog[5, 1/3])/2 + (307*PolyLog[5, 1/2])/9 - 
    55*PolyLog[5, 2/3] + (13*PolyLog[2, 3, -1/3])/4 - 31*PolyLog[2, 3, 1/3] - 
    (65*Pi^2*Zeta[3])/288 + (43*Log[2]^2*Zeta[3])/6 + 
    (71*Log[2]*Log[3]*Zeta[3])/24 - (41*Log[3]^2*Zeta[3])/8 - 
    (7*PolyLog[2, -1/2]*Zeta[3])/2 + (2269*Zeta[5])/36
 
G[0, -1, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 12*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + (26*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (6257*Pi^4*Log[2])/12960 + (539*Pi^2*Log[2]^3)/162 + 
    (1309*Log[2]^5)/270 + (2663*Pi^4*Log[3])/4320 - 
    (173*Pi^2*Log[2]^2*Log[3])/18 - (1115*Log[2]^4*Log[3])/144 + 
    (421*Pi^2*Log[2]*Log[3]^2)/48 - (83*Log[2]^3*Log[3]^2)/12 - 
    (407*Pi^2*Log[3]^3)/144 + (563*Log[2]^2*Log[3]^3)/24 - 
    (583*Log[2]*Log[3]^4)/32 + (929*Log[3]^5)/192 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/3 + (4*Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/3 - 5*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    5*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (4*Log[3]^3*PolyLog[2, -1/2])/3 + 
    4*Log[2]*PolyLog[2, -1/2]^2 - 5*Log[3]*PolyLog[2, -1/2]^2 + 
    (Pi^2*PolyLog[3, -1/2])/6 - 11*Log[2]^2*PolyLog[3, -1/2] + 
    22*Log[2]*Log[3]*PolyLog[3, -1/2] - (23*Log[3]^2*PolyLog[3, -1/2])/2 + 
    4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/2 - 
    31*Log[2]^2*PolyLog[3, 1/3] + (95*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (173*Log[3]^2*PolyLog[3, 1/3])/8 + 6*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    42*Log[2]*PolyLog[4, -1/2] - (51*Log[3]*PolyLog[4, -1/2])/2 - 
    (55*Log[2]*PolyLog[4, -1/3])/4 + (55*Log[3]*PolyLog[4, -1/3])/8 + 
    (65*Log[2]*PolyLog[4, 1/3])/2 - (95*Log[3]*PolyLog[4, 1/3])/4 + 
    (176*Log[2]*PolyLog[4, 1/2])/3 - (127*Log[3]*PolyLog[4, 1/2])/3 - 
    96*Log[2]*PolyLog[4, 2/3] + (159*Log[3]*PolyLog[4, 2/3])/2 + 
    (152*PolyLog[5, -1/2])/3 + (159*PolyLog[5, -1/3])/8 - 
    (77*PolyLog[5, 1/3])/2 + (986*PolyLog[5, 1/2])/9 + 140*PolyLog[5, 2/3] + 
    (29*PolyLog[2, 3, -1/3])/8 + 39*PolyLog[2, 3, 1/3] - 
    (11*Pi^2*Zeta[3])/18 + (751*Log[2]^2*Zeta[3])/24 - 
    (317*Log[2]*Log[3]*Zeta[3])/8 + (509*Log[3]^2*Zeta[3])/32 - 
    (11*PolyLog[2, -1/2]*Zeta[3])/12 - (80647*Zeta[5])/576
 
G[0, -1, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + 4*G[0, 0, 1, 0, -1, 1/2] - 
    (157*Pi^4*Log[2])/1080 + (79*Pi^2*Log[2]^3)/54 + (457*Log[2]^5)/180 + 
    (85*Pi^4*Log[3])/432 - (38*Pi^2*Log[2]^2*Log[3])/9 - 
    (173*Log[2]^4*Log[3])/72 + (13*Pi^2*Log[2]*Log[3]^2)/4 - 
    (79*Log[2]^3*Log[3]^2)/12 - (19*Pi^2*Log[3]^3)/24 + 
    (38*Log[2]^2*Log[3]^3)/3 - (15*Log[2]*Log[3]^4)/2 + (117*Log[3]^5)/80 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    Log[2]*PolyLog[2, -1/2]^2 - 2*Log[2]^2*PolyLog[3, -1/2] + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - (3*Log[3]^2*PolyLog[3, -1/2])/2 + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (41*Log[2]^2*PolyLog[3, 1/3])/2 + 
    23*Log[2]*Log[3]*PolyLog[3, 1/3] - (11*Log[3]^2*PolyLog[3, 1/3])/2 + 
    31*Log[2]*PolyLog[4, -1/2] - 15*Log[3]*PolyLog[4, -1/2] - 
    9*Log[2]*PolyLog[4, -1/3] + (31*Log[3]*PolyLog[4, -1/3])/4 + 
    19*Log[2]*PolyLog[4, 1/3] - (23*Log[3]*PolyLog[4, 1/3])/2 + 
    36*Log[2]*PolyLog[4, 1/2] - (80*Log[3]*PolyLog[4, 1/2])/3 - 
    45*Log[2]*PolyLog[4, 2/3] + 29*Log[3]*PolyLog[4, 2/3] + 
    31*PolyLog[5, -1/2] + (79*PolyLog[5, -1/3])/4 - (49*PolyLog[5, 1/3])/2 + 
    (160*PolyLog[5, 1/2])/3 + 55*PolyLog[5, 2/3] + 
    (9*PolyLog[2, 3, -1/3])/2 + 5*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/8 + 
    (107*Log[2]^2*Zeta[3])/4 - 25*Log[2]*Log[3]*Zeta[3] + 
    (293*Log[3]^2*Zeta[3])/48 - (1087*Zeta[5])/32
 
G[0, -1, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 7*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + (11*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (541*Pi^4*Log[2])/1620 + (983*Pi^2*Log[2]^3)/648 + (1999*Log[2]^5)/1080 + 
    (1303*Pi^4*Log[3])/4320 - (313*Pi^2*Log[2]^2*Log[3])/72 - 
    (257*Log[2]^4*Log[3])/72 + (67*Pi^2*Log[2]*Log[3]^2)/16 - 
    (7*Log[2]^3*Log[3]^2)/3 - (97*Pi^2*Log[3]^3)/72 + 
    (31*Log[2]^2*Log[3]^3)/3 - (279*Log[2]*Log[3]^4)/32 + 
    (383*Log[3]^5)/160 + (5*Log[2]^3*PolyLog[2, -1/2])/6 - 
    (5*Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (5*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (5*Log[3]^3*PolyLog[2, -1/2])/
     6 + (5*Log[2]*PolyLog[2, -1/2]^2)/2 - (5*Log[3]*PolyLog[2, -1/2]^2)/2 - 
    (13*Log[2]^2*PolyLog[3, -1/2])/2 + 13*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (13*Log[3]^2*PolyLog[3, -1/2])/2 + 3*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (25*Log[2]^2*PolyLog[3, 1/3])/2 + 22*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (41*Log[3]^2*PolyLog[3, 1/3])/4 + 3*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    10*Log[2]*PolyLog[4, -1/2] - 7*Log[3]*PolyLog[4, -1/2] - 
    (19*Log[2]*PolyLog[4, -1/3])/4 + 4*Log[3]*PolyLog[4, -1/3] + 
    (25*Log[2]*PolyLog[4, 1/3])/2 - 11*Log[3]*PolyLog[4, 1/3] + 
    (41*Log[2]*PolyLog[4, 1/2])/3 - (35*Log[3]*PolyLog[4, 1/2])/3 - 
    44*Log[2]*PolyLog[4, 2/3] + 41*Log[3]*PolyLog[4, 2/3] + 
    (35*PolyLog[5, -1/2])/3 + (17*PolyLog[5, -1/3])/2 - 
    (31*PolyLog[5, 1/3])/2 + (254*PolyLog[5, 1/2])/9 + 71*PolyLog[5, 2/3] + 
    (3*PolyLog[2, 3, -1/3])/4 + 22*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/6 + 
    (437*Log[2]^2*Zeta[3])/48 - (323*Log[2]*Log[3]*Zeta[3])/24 + 
    (145*Log[3]^2*Zeta[3])/24 - (9007*Zeta[5])/144
 
G[0, -1, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 5*G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, -1, 0, -1, 1/2] - (4*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (649*Pi^4*Log[2])/2592 + (217*Pi^2*Log[2]^3)/324 + (61*Log[2]^5)/108 + 
    (53*Pi^4*Log[3])/240 - (7*Pi^2*Log[2]^2*Log[3])/3 - 
    (107*Log[2]^4*Log[3])/48 + (133*Pi^2*Log[2]*Log[3]^2)/48 + 
    (7*Log[2]^3*Log[3]^2)/6 - (37*Pi^2*Log[3]^3)/36 + 
    (29*Log[2]^2*Log[3]^3)/8 - (467*Log[2]*Log[3]^4)/96 + 
    (1613*Log[3]^5)/960 + (7*Log[2]^3*PolyLog[2, -1/2])/6 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - (7*Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 + (7*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - 
    (5*Log[3]^3*PolyLog[2, -1/2])/6 + (5*Log[2]*PolyLog[2, -1/2]^2)/2 - 
    (5*Log[3]*PolyLog[2, -1/2]^2)/2 + (Pi^2*PolyLog[3, -1/2])/12 - 
    4*Log[2]^2*PolyLog[3, -1/2] + 8*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (9*Log[3]^2*PolyLog[3, -1/2])/2 + 5*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/4 - (7*Log[2]^2*PolyLog[3, 1/3])/2 + 
    (23*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (67*Log[3]^2*PolyLog[3, 1/3])/8 + 
    3*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 9*Log[2]*PolyLog[4, -1/2] + 
    (9*Log[3]*PolyLog[4, -1/2])/2 + (7*Log[2]*PolyLog[4, -1/3])/4 - 
    (7*Log[3]*PolyLog[4, -1/3])/8 + (5*Log[2]*PolyLog[4, 1/3])/2 - 
    (29*Log[3]*PolyLog[4, 1/3])/4 - 8*Log[2]*PolyLog[4, 1/2] + 
    6*Log[3]*PolyLog[4, 1/2] - 21*Log[2]*PolyLog[4, 2/3] + 
    (53*Log[3]*PolyLog[4, 2/3])/2 - (46*PolyLog[5, -1/2])/3 - 
    (25*PolyLog[5, -1/3])/8 - 5*PolyLog[5, 1/3] - (115*PolyLog[5, 1/2])/9 + 
    44*PolyLog[5, 2/3] - (9*PolyLog[2, 3, -1/3])/8 + 22*PolyLog[2, 3, 1/3] + 
    (19*Pi^2*Zeta[3])/144 - (5*Log[2]^2*Zeta[3])/3 - 
    (91*Log[2]*Log[3]*Zeta[3])/24 + (331*Log[3]^2*Zeta[3])/96 + 
    (7*PolyLog[2, -1/2]*Zeta[3])/4 - (26689*Zeta[5])/576
 
G[0, -1, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -5*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] - (8*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (595*Pi^4*Log[2])/2592 - (361*Pi^2*Log[2]^3)/324 - (191*Log[2]^5)/135 - 
    (331*Pi^4*Log[3])/1440 + (27*Pi^2*Log[2]^2*Log[3])/8 + 
    (131*Log[2]^4*Log[3])/48 - (55*Pi^2*Log[2]*Log[3]^2)/16 + 
    2*Log[2]^3*Log[3]^2 + (7*Pi^2*Log[3]^3)/6 - (211*Log[2]^2*Log[3]^3)/24 + 
    (247*Log[2]*Log[3]^4)/32 - (2129*Log[3]^5)/960 - 
    (7*Log[2]^3*PolyLog[2, -1/2])/6 + (5*Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 - (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/
     6 - (5*Log[2]*PolyLog[2, -1/2]^2)/2 + (5*Log[3]*PolyLog[2, -1/2]^2)/2 + 
    (9*Log[2]^2*PolyLog[3, -1/2])/2 - 10*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (11*Log[3]^2*PolyLog[3, -1/2])/2 - 3*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (19*Log[2]^2*PolyLog[3, 1/3])/2 - (41*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (91*Log[3]^2*PolyLog[3, 1/3])/8 - 3*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    6*Log[2]*PolyLog[4, -1/2] + (9*Log[3]*PolyLog[4, -1/2])/2 + 
    (3*Log[2]*PolyLog[4, -1/3])/4 - (Log[3]*PolyLog[4, -1/3])/8 - 
    (21*Log[2]*PolyLog[4, 1/3])/2 + (49*Log[3]*PolyLog[4, 1/3])/4 - 
    10*Log[2]*PolyLog[4, 1/2] + 6*Log[3]*PolyLog[4, 1/2] + 
    32*Log[2]*PolyLog[4, 2/3] - (63*Log[3]*PolyLog[4, 2/3])/2 - 
    (20*PolyLog[5, -1/2])/3 - (7*PolyLog[5, -1/3])/8 + 14*PolyLog[5, 1/3] - 
    (218*PolyLog[5, 1/2])/9 - 53*PolyLog[5, 2/3] - 
    (3*PolyLog[2, 3, -1/3])/8 - 19*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/12 - 
    (157*Log[2]^2*Zeta[3])/24 + (91*Log[2]*Log[3]*Zeta[3])/8 - 
    (545*Log[3]^2*Zeta[3])/96 + (31021*Zeta[5])/576
 
G[0, -1, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, 0, 1, 0, -1, 1/2] + (Pi^4*Log[2])/270 - 
    (29*Pi^2*Log[2]^3)/108 - (13*Log[2]^5)/45 - (13*Pi^4*Log[3])/720 + 
    (3*Pi^2*Log[2]^2*Log[3])/4 - (5*Log[2]^4*Log[3])/24 - 
    (9*Pi^2*Log[2]*Log[3]^2)/16 + (9*Log[2]^3*Log[3]^2)/4 + 
    (11*Pi^2*Log[3]^3)/72 - (13*Log[2]^2*Log[3]^3)/4 + 
    (175*Log[2]*Log[3]^4)/96 - (181*Log[3]^5)/480 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    (Log[2]^2*PolyLog[3, -1/2])/2 - Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (Log[3]^2*PolyLog[3, -1/2])/2 + (9*Log[2]^2*PolyLog[3, 1/3])/2 - 
    6*Log[2]*Log[3]*PolyLog[3, 1/3] + (9*Log[3]^2*PolyLog[3, 1/3])/4 - 
    6*Log[2]*PolyLog[4, -1/2] + 3*Log[3]*PolyLog[4, -1/2] + 
    (5*Log[2]*PolyLog[4, -1/3])/4 - (Log[3]*PolyLog[4, -1/3])/2 - 
    (11*Log[2]*PolyLog[4, 1/3])/2 + 4*Log[3]*PolyLog[4, 1/3] - 
    7*Log[2]*PolyLog[4, 1/2] + 5*Log[3]*PolyLog[4, 1/2] + 
    7*Log[2]*PolyLog[4, 2/3] - 4*Log[3]*PolyLog[4, 2/3] - 
    7*PolyLog[5, -1/2] - 2*PolyLog[5, -1/3] + (13*PolyLog[5, 1/3])/2 - 
    (43*PolyLog[5, 1/2])/3 - 7*PolyLog[5, 2/3] - (3*PolyLog[2, 3, -1/3])/4 + 
    (Pi^2*Zeta[3])/8 - (229*Log[2]^2*Zeta[3])/48 + 
    (115*Log[2]*Log[3]*Zeta[3])/24 - (19*Log[3]^2*Zeta[3])/12 + 
    (925*Zeta[5])/192
 
G[0, 0, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -PolyLog[2, 3, -1/3]
 
G[0, 0, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, -1, 0, -1, 1/2] - (8*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (323*Pi^4*Log[2])/1620 + (20*Pi^2*Log[2]^3)/81 - (79*Log[2]^5)/270 + 
    (31*Pi^4*Log[3])/216 - (10*Pi^2*Log[2]^2*Log[3])/9 - 
    (19*Log[2]^4*Log[3])/18 + 2*Pi^2*Log[2]*Log[3]^2 + 
    (5*Log[2]^3*Log[3]^2)/3 - (31*Pi^2*Log[3]^3)/36 + 
    (5*Log[2]^2*Log[3]^3)/3 - (11*Log[2]*Log[3]^4)/3 + (169*Log[3]^5)/120 + 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 - 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (2*Log[3]^3*PolyLog[2, -1/2])/3 + 
    2*Log[2]*PolyLog[2, -1/2]^2 - 2*Log[3]*PolyLog[2, -1/2]^2 - 
    4*Log[2]^2*PolyLog[3, -1/2] + 8*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    4*Log[3]^2*PolyLog[3, -1/2] + 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/3 + 2*Log[2]^2*PolyLog[3, 1/3] + 
    8*Log[2]*Log[3]*PolyLog[3, 1/3] - 7*Log[3]^2*PolyLog[3, 1/3] + 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 20*Log[2]*PolyLog[4, -1/2] + 
    8*Log[3]*PolyLog[4, -1/2] + 4*Log[2]*PolyLog[4, -1/3] - 
    Log[3]*PolyLog[4, -1/3] - 6*Log[3]*PolyLog[4, 1/3] - 
    (56*Log[2]*PolyLog[4, 1/2])/3 + (32*Log[3]*PolyLog[4, 1/2])/3 - 
    8*Log[2]*PolyLog[4, 2/3] + 20*Log[3]*PolyLog[4, 2/3] - 
    (92*PolyLog[5, -1/2])/3 - 5*PolyLog[5, -1/3] - 2*PolyLog[5, 1/3] - 
    (272*PolyLog[5, 1/2])/9 + 28*PolyLog[5, 2/3] - 2*PolyLog[2, 3, -1/3] + 
    16*PolyLog[2, 3, 1/3] - (7*Pi^2*Zeta[3])/36 - (59*Log[2]^2*Zeta[3])/6 + 
    (2*Log[2]*Log[3]*Zeta[3])/3 + (41*Log[3]^2*Zeta[3])/12 - (541*Zeta[5])/18
 
G[0, 0, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + (5*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (823*Pi^4*Log[2])/6480 + (587*Pi^2*Log[2]^3)/648 + (761*Log[2]^5)/540 + 
    (517*Pi^4*Log[3])/4320 - (199*Pi^2*Log[2]^2*Log[3])/72 - 
    (229*Log[2]^4*Log[3])/144 + (37*Pi^2*Log[2]*Log[3]^2)/16 - 
    (13*Log[2]^3*Log[3]^2)/4 - (25*Pi^2*Log[3]^3)/36 + 
    (179*Log[2]^2*Log[3]^3)/24 - (481*Log[2]*Log[3]^4)/96 + 
    (1141*Log[3]^5)/960 + (Log[2]^3*PolyLog[2, -1/2])/3 - 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/3 + Log[2]*PolyLog[2, -1/2]^2 - 
    Log[3]*PolyLog[2, -1/2]^2 - 2*Log[2]^2*PolyLog[3, -1/2] + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - 2*Log[3]^2*PolyLog[3, -1/2] + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/6 - 
    (23*Log[2]^2*PolyLog[3, 1/3])/2 + (27*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (39*Log[3]^2*PolyLog[3, 1/3])/8 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    13*Log[2]*PolyLog[4, -1/2] - (11*Log[3]*PolyLog[4, -1/2])/2 - 
    (19*Log[2]*PolyLog[4, -1/3])/4 + (23*Log[3]*PolyLog[4, -1/3])/8 + 
    (19*Log[2]*PolyLog[4, 1/3])/2 - (23*Log[3]*PolyLog[4, 1/3])/4 + 
    (47*Log[2]*PolyLog[4, 1/2])/3 - (32*Log[3]*PolyLog[4, 1/2])/3 - 
    27*Log[2]*PolyLog[4, 2/3] + (39*Log[3]*PolyLog[4, 2/3])/2 + 
    (23*PolyLog[5, -1/2])/3 + (69*PolyLog[5, -1/3])/8 - 
    (23*PolyLog[5, 1/3])/2 + (164*PolyLog[5, 1/2])/9 + 34*PolyLog[5, 2/3] + 
    (15*PolyLog[2, 3, -1/3])/8 + 4*PolyLog[2, 3, 1/3] - 
    (83*Pi^2*Zeta[3])/144 + (725*Log[2]^2*Zeta[3])/48 - 
    (91*Log[2]*Log[3]*Zeta[3])/6 + (533*Log[3]^2*Zeta[3])/96 - 
    (2965*Zeta[5])/144
 
G[0, 0, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (8*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (323*Pi^4*Log[2])/1620 - (2*Pi^2*Log[2]^3)/81 + (331*Log[2]^5)/270 - 
    (169*Pi^4*Log[3])/1080 + (2*Pi^2*Log[2]^2*Log[3])/9 + 
    (4*Log[2]^4*Log[3])/9 - (4*Pi^2*Log[2]*Log[3]^2)/3 - 
    (11*Log[2]^3*Log[3]^2)/3 + (25*Pi^2*Log[3]^3)/36 + 
    (4*Log[2]^2*Log[3]^3)/3 + (7*Log[2]*Log[3]^4)/3 - (19*Log[3]^5)/15 - 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (2*Log[3]^3*PolyLog[2, -1/2])/3 - 
    2*Log[2]*PolyLog[2, -1/2]^2 + 2*Log[3]*PolyLog[2, -1/2]^2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 8*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    4*Log[3]^2*PolyLog[3, -1/2] - 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/3 - 8*Log[2]^2*PolyLog[3, 1/3] - 
    4*Log[2]*Log[3]*PolyLog[3, 1/3] + 8*Log[3]^2*PolyLog[3, 1/3] - 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 32*Log[2]*PolyLog[4, -1/2] - 
    12*Log[3]*PolyLog[4, -1/2] - 4*Log[2]*PolyLog[4, -1/3] + 
    2*Log[3]*PolyLog[4, -1/3] + 10*Log[3]*PolyLog[4, 1/3] + 
    (104*Log[2]*PolyLog[4, 1/2])/3 - (64*Log[3]*PolyLog[4, 1/2])/3 - 
    4*Log[2]*PolyLog[4, 2/3] - 16*Log[3]*PolyLog[4, 2/3] + 
    (128*PolyLog[5, -1/2])/3 + 14*PolyLog[5, -1/3] - 4*PolyLog[5, 1/3] + 
    (416*PolyLog[5, 1/2])/9 - 16*PolyLog[5, 2/3] + 5*PolyLog[2, 3, -1/3] - 
    28*PolyLog[2, 3, 1/3] - (29*Pi^2*Zeta[3])/36 + (137*Log[2]^2*Zeta[3])/6 - 
    14*Log[2]*Log[3]*Zeta[3] + (3*Log[3]^2*Zeta[3])/2 + (703*Zeta[5])/18
 
G[0, 0, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[3]^3)/12 + Log[3]^5/12 - 
    Log[3]^2*PolyLog[3, 1/3] - 3*Log[3]*PolyLog[4, -1/3] - 
    6*PolyLog[5, -1/3] + (13*Log[3]^2*Zeta[3])/12
 
G[0, 0, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + (16*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (53*Pi^4*Log[2])/810 + (127*Pi^2*Log[2]^3)/162 + (1189*Log[2]^5)/540 + 
    (103*Pi^4*Log[3])/4320 - (37*Pi^2*Log[2]^2*Log[3])/18 - 
    (10*Log[2]^4*Log[3])/9 + (5*Pi^2*Log[2]*Log[3]^2)/6 - 
    (35*Log[2]^3*Log[3]^2)/6 - (11*Pi^2*Log[3]^3)/144 + 
    (23*Log[2]^2*Log[3]^3)/3 - (31*Log[2]*Log[3]^4)/12 + (3*Log[3]^5)/32 - 
    (Log[2]^3*PolyLog[2, -1/2])/3 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    Log[2]*PolyLog[2, -1/2]^2 + Log[3]*PolyLog[2, -1/2]^2 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    16*Log[2]^2*PolyLog[3, 1/3] + 10*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (Log[3]^2*PolyLog[3, 1/3])/2 - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    40*Log[2]*PolyLog[4, -1/2] - 18*Log[3]*PolyLog[4, -1/2] - 
    8*Log[2]*PolyLog[4, -1/3] + (5*Log[3]*PolyLog[4, -1/3])/2 + 
    12*Log[2]*PolyLog[4, 1/3] - Log[3]*PolyLog[4, 1/3] + 
    (136*Log[2]*PolyLog[4, 1/2])/3 - (92*Log[3]*PolyLog[4, 1/2])/3 - 
    26*Log[2]*PolyLog[4, 2/3] + 4*Log[3]*PolyLog[4, 2/3] + 
    (148*PolyLog[5, -1/2])/3 + (57*PolyLog[5, -1/3])/4 - 
    (33*PolyLog[5, 1/3])/2 + (616*PolyLog[5, 1/2])/9 + 16*PolyLog[5, 2/3] + 
    (11*PolyLog[2, 3, -1/3])/2 - 14*PolyLog[2, 3, 1/3] - 
    (11*Pi^2*Zeta[3])/12 + (175*Log[2]^2*Zeta[3])/6 - 
    (47*Log[2]*Log[3]*Zeta[3])/2 + (139*Log[3]^2*Zeta[3])/24 + 
    (343*Zeta[5])/144
 
G[0, 0, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + (4*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1199*Pi^4*Log[2])/12960 - (109*Pi^2*Log[2]^3)/324 - (209*Log[2]^5)/540 - 
    (397*Pi^4*Log[3])/4320 + (11*Pi^2*Log[2]^2*Log[3])/9 + 
    (109*Log[2]^4*Log[3])/144 - (21*Pi^2*Log[2]*Log[3]^2)/16 + 
    (Log[2]^3*Log[3]^2)/2 + (67*Pi^2*Log[3]^3)/144 - 
    (67*Log[2]^2*Log[3]^3)/24 + (85*Log[2]*Log[3]^4)/32 - 
    (261*Log[3]^5)/320 - (Log[2]^3*PolyLog[2, -1/2])/3 + 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/3 - Log[2]*PolyLog[2, -1/2]^2 + 
    Log[3]*PolyLog[2, -1/2]^2 + 2*Log[2]^2*PolyLog[3, -1/2] - 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] + 2*Log[3]^2*PolyLog[3, -1/2] - 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/6 + 
    (5*Log[2]^2*PolyLog[3, 1/3])/2 - (11*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (31*Log[3]^2*PolyLog[3, 1/3])/8 - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    3*Log[2]*PolyLog[4, -1/2] - (3*Log[3]*PolyLog[4, -1/2])/2 + 
    (9*Log[2]*PolyLog[4, -1/3])/4 - (9*Log[3]*PolyLog[4, -1/3])/8 - 
    (5*Log[2]*PolyLog[4, 1/3])/2 + (17*Log[3]*PolyLog[4, 1/3])/4 + 
    (2*Log[2]*PolyLog[4, 1/2])/3 - (7*Log[3]*PolyLog[4, 1/2])/3 + 
    11*Log[2]*PolyLog[4, 2/3] - (25*Log[3]*PolyLog[4, 2/3])/2 + 
    (31*PolyLog[5, -1/2])/3 - (9*PolyLog[5, -1/3])/8 + 
    (5*PolyLog[5, 1/3])/2 + (52*PolyLog[5, 1/2])/9 - 19*PolyLog[5, 2/3] + 
    PolyLog[2, 3, -1/3]/8 - 10*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/72 - 
    (11*Log[2]^2*Zeta[3])/12 + (21*Log[2]*Log[3]*Zeta[3])/8 - 
    (53*Log[3]^2*Zeta[3])/32 + (12919*Zeta[5])/576
 
G[0, 0, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + (2*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (757*Pi^4*Log[2])/6480 + (79*Pi^2*Log[2]^3)/324 + (11*Log[2]^5)/135 + 
    (443*Pi^4*Log[3])/4320 - (31*Pi^2*Log[2]^2*Log[3])/36 - 
    (13*Log[2]^4*Log[3])/18 + (5*Pi^2*Log[2]*Log[3]^2)/4 + 
    (Log[2]^3*Log[3]^2)/3 - (73*Pi^2*Log[3]^3)/144 + 
    (11*Log[2]^2*Log[3]^3)/6 - (61*Log[2]*Log[3]^4)/24 + (29*Log[3]^5)/32 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    Log[2]*PolyLog[2, -1/2]^2 - Log[3]*PolyLog[2, -1/2]^2 - 
    2*Log[2]^2*PolyLog[3, -1/2] + 4*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    2*Log[3]^2*PolyLog[3, -1/2] + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Log[2]^2*PolyLog[3, 1/3])/2 + 7*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (11*Log[3]^2*PolyLog[3, 1/3])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    7*Log[2]*PolyLog[4, -1/2] + 2*Log[3]*PolyLog[4, -1/2] + 
    2*Log[2]*PolyLog[4, -1/3] - (9*Log[3]*PolyLog[4, -1/3])/4 + 
    3*Log[2]*PolyLog[4, 1/3] - (13*Log[3]*PolyLog[4, 1/3])/2 - 
    (10*Log[2]*PolyLog[4, 1/2])/3 + (8*Log[3]*PolyLog[4, 1/2])/3 - 
    7*Log[2]*PolyLog[4, 2/3] + 12*Log[3]*PolyLog[4, 2/3] - 
    (31*PolyLog[5, -1/2])/3 - (15*PolyLog[5, -1/3])/2 - 3*PolyLog[5, 1/3] - 
    (4*PolyLog[5, 1/2])/9 + 17*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3] + 
    11*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/6 - (97*Log[2]^2*Zeta[3])/24 + 
    (Log[2]*Log[3]*Zeta[3])/3 + (13*Log[3]^2*Zeta[3])/8 - (8039*Zeta[5])/288
 
G[0, 0, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, 0, 1, 0, -1, 1/2] - (Pi^4*Log[2])/90 + 
    (5*Pi^2*Log[2]^3)/8 + (47*Log[2]^5)/40 + (17*Pi^4*Log[3])/288 - 
    (41*Pi^2*Log[2]^2*Log[3])/24 - Log[2]^4*Log[3] + 
    (19*Pi^2*Log[2]*Log[3]^2)/16 - 3*Log[2]^3*Log[3]^2 - 
    (5*Pi^2*Log[3]^3)/16 + (16*Log[2]^2*Log[3]^3)/3 - 
    (93*Log[2]*Log[3]^4)/32 + (133*Log[3]^5)/240 - 
    (19*Log[2]^2*PolyLog[3, 1/3])/2 + 10*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (11*Log[3]^2*PolyLog[3, 1/3])/4 + 18*Log[2]*PolyLog[4, -1/2] - 
    9*Log[3]*PolyLog[4, -1/2] - (13*Log[2]*PolyLog[4, -1/3])/4 + 
    Log[3]*PolyLog[4, -1/3] + (19*Log[2]*PolyLog[4, 1/3])/2 - 
    5*Log[3]*PolyLog[4, 1/3] + 21*Log[2]*PolyLog[4, 1/2] - 
    15*Log[3]*PolyLog[4, 1/2] - 18*Log[2]*PolyLog[4, 2/3] + 
    9*Log[3]*PolyLog[4, 2/3] + 21*PolyLog[5, -1/2] + 
    (21*PolyLog[5, -1/3])/4 - 12*PolyLog[5, 1/3] + 36*PolyLog[5, 1/2] + 
    18*PolyLog[5, 2/3] + (9*PolyLog[2, 3, -1/3])/4 - PolyLog[2, 3, 1/3] - 
    (3*Pi^2*Zeta[3])/8 + (649*Log[2]^2*Zeta[3])/48 - 
    (307*Log[2]*Log[3]*Zeta[3])/24 + (95*Log[3]^2*Zeta[3])/24 - 
    (793*Zeta[5])/64
 
G[0, 0, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (-2*Pi^2*Log[2]^3)/27 - (14*Log[2]^5)/45 - 
    (Pi^4*Log[3])/270 + (2*Pi^2*Log[2]^2*Log[3])/9 + (Log[2]^4*Log[3])/9 + 
    (2*Log[2]^3*Log[3]^2)/3 - (Pi^2*Log[3]^3)/36 - (2*Log[2]^2*Log[3]^3)/3 + 
    (11*Log[3]^5)/120 + 2*Log[2]^2*PolyLog[3, 1/3] - 
    Log[3]^2*PolyLog[3, 1/3] - 4*Log[2]*PolyLog[4, -1/2] - 
    2*Log[3]*PolyLog[4, 1/3] - (16*Log[2]*PolyLog[4, 1/2])/3 + 
    (8*Log[3]*PolyLog[4, 1/2])/3 + 4*Log[2]*PolyLog[4, 2/3] - 
    4*PolyLog[5, -1/2] - 3*PolyLog[5, -1/3] + 2*PolyLog[5, 1/3] - 
    (16*PolyLog[5, 1/2])/3 - 4*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3] + 
    4*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/3 - (13*Log[2]^2*Zeta[3])/3 + 
    (7*Log[2]*Log[3]*Zeta[3])/3 - (7*Log[3]^2*Zeta[3])/12 - 3*Zeta[5]
 
G[0, 0, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := Log[3]*PolyLog[4, -1/3] + 4*PolyLog[5, -1/3]
 
G[0, 0, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, 0, 1, 0, -1, 1/2] + 
    (37*Pi^4*Log[2])/2160 - (37*Pi^2*Log[2]^3)/108 - (137*Log[2]^5)/180 - 
    (73*Pi^4*Log[3])/1440 + (11*Pi^2*Log[2]^2*Log[3])/12 + 
    (5*Log[2]^4*Log[3])/8 - (7*Pi^2*Log[2]*Log[3]^2)/12 + 
    (11*Log[2]^3*Log[3]^2)/6 + (7*Pi^2*Log[3]^3)/48 - 
    (37*Log[2]^2*Log[3]^3)/12 + (37*Log[2]*Log[3]^4)/24 - (25*Log[3]^5)/96 + 
    (11*Log[2]^2*PolyLog[3, 1/3])/2 - 5*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    Log[3]^2*PolyLog[3, 1/3] - 11*Log[2]*PolyLog[4, -1/2] + 
    5*Log[3]*PolyLog[4, -1/2] + 2*Log[2]*PolyLog[4, -1/3] - 
    (Log[3]*PolyLog[4, -1/3])/2 - 5*Log[2]*PolyLog[4, 1/3] + 
    2*Log[3]*PolyLog[4, 1/3] - 14*Log[2]*PolyLog[4, 1/2] + 
    10*Log[3]*PolyLog[4, 1/2] + 11*Log[2]*PolyLog[4, 2/3] - 
    5*Log[3]*PolyLog[4, 2/3] - 13*PolyLog[5, -1/2] - (9*PolyLog[5, -1/3])/4 + 
    (13*PolyLog[5, 1/3])/2 - (68*PolyLog[5, 1/2])/3 - 11*PolyLog[5, 2/3] - 
    (3*PolyLog[2, 3, -1/3])/2 + PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/4 - 
    (67*Log[2]^2*Zeta[3])/8 + (29*Log[2]*Log[3]*Zeta[3])/4 - 
    2*Log[3]^2*Zeta[3] + (817*Zeta[5])/96
 
G[0, 0, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -PolyLog[5, -1/3]
 
G[0, 0, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -Log[3]^5/120
 
G[0, 0, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -PolyLog[5, 1/3]
 
G[0, 0, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, 0, 1, 0, -1, 1/2] + 
    (37*Pi^4*Log[2])/1080 - (7*Pi^2*Log[2]^3)/9 - (77*Log[2]^5)/45 - 
    (181*Pi^4*Log[3])/2160 + (19*Pi^2*Log[2]^2*Log[3])/9 + 
    (97*Log[2]^4*Log[3])/72 - (4*Pi^2*Log[2]*Log[3]^2)/3 + 
    (25*Log[2]^3*Log[3]^2)/6 + (7*Pi^2*Log[3]^3)/24 - 
    (83*Log[2]^2*Log[3]^3)/12 + (41*Log[2]*Log[3]^4)/12 - 
    (131*Log[3]^5)/240 + (25*Log[2]^2*PolyLog[3, 1/3])/2 - 
    11*Log[2]*Log[3]*PolyLog[3, 1/3] + 2*Log[3]^2*PolyLog[3, 1/3] - 
    25*Log[2]*PolyLog[4, -1/2] + 11*Log[3]*PolyLog[4, -1/2] + 
    7*Log[2]*PolyLog[4, -1/3] - (7*Log[3]*PolyLog[4, -1/3])/2 - 
    13*Log[2]*PolyLog[4, 1/3] + 5*Log[3]*PolyLog[4, 1/3] - 
    (92*Log[2]*PolyLog[4, 1/2])/3 + (64*Log[3]*PolyLog[4, 1/2])/3 + 
    25*Log[2]*PolyLog[4, 2/3] - 11*Log[3]*PolyLog[4, 2/3] - 
    29*PolyLog[5, -1/2] - (27*PolyLog[5, -1/3])/2 + 16*PolyLog[5, 1/3] - 
    48*PolyLog[5, 1/2] - 25*PolyLog[5, 2/3] - (7*PolyLog[2, 3, -1/3])/2 + 
    3*PolyLog[2, 3, 1/3] + (11*Pi^2*Zeta[3])/24 - (233*Log[2]^2*Zeta[3])/12 + 
    (50*Log[2]*Log[3]*Zeta[3])/3 - (25*Log[3]^2*Zeta[3])/6 + (155*Zeta[5])/12
 
G[0, 0, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := Log[3]*PolyLog[4, 1/3] + 4*PolyLog[5, 1/3]
 
G[0, 0, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[2]^3)/18 + Log[2]^5/30 - 
    (Pi^2*Log[2]^2*Log[3])/6 - (Log[2]^4*Log[3])/24 + 
    (Pi^2*Log[2]*Log[3]^2)/6 - (Log[2]^3*Log[3]^2)/6 - (Pi^2*Log[3]^3)/18 + 
    (5*Log[2]^2*Log[3]^3)/12 - (Log[2]*Log[3]^4)/3 + (11*Log[3]^5)/120 - 
    (Log[2]^2*PolyLog[3, 1/3])/2 + Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (Log[3]^2*PolyLog[3, 1/3])/2 + Log[2]*PolyLog[4, -1/2] - 
    Log[3]*PolyLog[4, -1/2] - Log[2]*PolyLog[4, 2/3] + 
    Log[3]*PolyLog[4, 2/3] + PolyLog[5, -1/2] + PolyLog[5, 1/3] + 
    PolyLog[5, 2/3] + PolyLog[2, 3, 1/3] + (Log[2]^2*Zeta[3])/2 - 
    Log[2]*Log[3]*Zeta[3] + (Log[3]^2*Zeta[3])/2 - Zeta[5]
 
G[0, 0, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, 0, 1, 0, -1, 1/2] - 
    (23*Pi^4*Log[2])/540 + (61*Pi^2*Log[2]^3)/54 + (599*Log[2]^5)/360 + 
    (83*Pi^4*Log[3])/720 - (29*Pi^2*Log[2]^2*Log[3])/12 - 
    (13*Log[2]^4*Log[3])/8 + (37*Pi^2*Log[2]*Log[3]^2)/24 - 
    (55*Log[2]^3*Log[3]^2)/12 - (13*Pi^2*Log[3]^3)/36 + 
    (49*Log[2]^2*Log[3]^3)/6 - (53*Log[2]*Log[3]^4)/12 + (197*Log[3]^5)/240 - 
    13*Log[2]^2*PolyLog[3, 1/3] + 14*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    4*Log[3]^2*PolyLog[3, 1/3] + 28*Log[2]*PolyLog[4, -1/2] - 
    15*Log[3]*PolyLog[4, -1/2] - 11*Log[2]*PolyLog[4, -1/3] + 
    (11*Log[3]*PolyLog[4, -1/3])/2 + 20*Log[2]*PolyLog[4, 1/3] - 
    11*Log[3]*PolyLog[4, 1/3] + 30*Log[2]*PolyLog[4, 1/2] - 
    24*Log[3]*PolyLog[4, 1/2] - 28*Log[2]*PolyLog[4, 2/3] + 
    15*Log[3]*PolyLog[4, 2/3] + 35*PolyLog[5, -1/2] + 
    (27*PolyLog[5, -1/3])/2 - 19*PolyLog[5, 1/3] + (184*PolyLog[5, 1/2])/3 + 
    29*PolyLog[5, 2/3] + (5*PolyLog[2, 3, -1/3])/2 + 2*PolyLog[2, 3, 1/3] - 
    (7*Pi^2*Zeta[3])/48 + (323*Log[2]^2*Zeta[3])/24 - 
    (151*Log[2]*Log[3]*Zeta[3])/12 + (151*Log[3]^2*Zeta[3])/48 - 
    (193*Zeta[5])/8
 
G[0, 0, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + 4*G[0, 0, 1, 0, -1, 1/2] - 
    (157*Pi^4*Log[2])/1080 + (79*Pi^2*Log[2]^3)/54 + (457*Log[2]^5)/180 + 
    (689*Pi^4*Log[3])/4320 - (163*Pi^2*Log[2]^2*Log[3])/36 - 
    (89*Log[2]^4*Log[3])/36 + (7*Pi^2*Log[2]*Log[3]^2)/2 - 
    6*Log[2]^3*Log[3]^2 - (43*Pi^2*Log[3]^3)/48 + (38*Log[2]^2*Log[3]^3)/3 - 
    8*Log[2]*Log[3]^4 + (827*Log[3]^5)/480 + (Log[2]^3*PolyLog[2, -1/2])/3 - 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/3 + Log[2]*PolyLog[2, -1/2]^2 - 
    Log[3]*PolyLog[2, -1/2]^2 - 2*Log[2]^2*PolyLog[3, -1/2] + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - 2*Log[3]^2*PolyLog[3, -1/2] + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/6 - 
    (39*Log[2]^2*PolyLog[3, 1/3])/2 + 23*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (15*Log[3]^2*PolyLog[3, 1/3])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    31*Log[2]*PolyLog[4, -1/2] - 16*Log[3]*PolyLog[4, -1/2] - 
    9*Log[2]*PolyLog[4, -1/3] + (15*Log[3]*PolyLog[4, -1/3])/2 + 
    19*Log[2]*PolyLog[4, 1/3] - 14*Log[3]*PolyLog[4, 1/3] + 
    36*Log[2]*PolyLog[4, 1/2] - (64*Log[3]*PolyLog[4, 1/2])/3 - 
    45*Log[2]*PolyLog[4, 2/3] + 30*Log[3]*PolyLog[4, 2/3] + 
    31*PolyLog[5, -1/2] + (79*PolyLog[5, -1/3])/4 - (49*PolyLog[5, 1/3])/2 + 
    (160*PolyLog[5, 1/2])/3 + 55*PolyLog[5, 2/3] + 
    (9*PolyLog[2, 3, -1/3])/2 + 5*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/8 + 
    (107*Log[2]^2*Zeta[3])/4 - (47*Log[2]*Log[3]*Zeta[3])/2 + 
    (13*Log[3]^2*Zeta[3])/2 - (1087*Zeta[5])/32
 
G[0, 0, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] + 4*G[0, 0, 1, 0, -1, 1/2] - 
    (119*Pi^4*Log[2])/1440 + (34*Pi^2*Log[2]^3)/27 + (701*Log[2]^5)/360 + 
    (77*Pi^4*Log[3])/720 - (13*Pi^2*Log[2]^2*Log[3])/4 - 
    (85*Log[2]^4*Log[3])/48 + (107*Pi^2*Log[2]*Log[3]^2)/48 - 
    (61*Log[2]^3*Log[3]^2)/12 - (37*Pi^2*Log[3]^3)/72 + 
    (229*Log[2]^2*Log[3]^3)/24 - (523*Log[2]*Log[3]^4)/96 + 
    (1007*Log[3]^5)/960 + (Log[2]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 - (Log[3]^3*PolyLog[2, -1/2])/6 + (Log[2]*PolyLog[2, -1/2]^2)/2 - 
    (Log[3]*PolyLog[2, -1/2]^2)/2 - Log[2]^2*PolyLog[3, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] - Log[3]^2*PolyLog[3, -1/2] + 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/12 - 
    (31*Log[2]^2*PolyLog[3, 1/3])/2 + (31*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (33*Log[3]^2*PolyLog[3, 1/3])/8 + PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    27*Log[2]*PolyLog[4, -1/2] - (25*Log[3]*PolyLog[4, -1/2])/2 - 
    (41*Log[2]*PolyLog[4, -1/3])/4 + (53*Log[3]*PolyLog[4, -1/3])/8 + 
    (33*Log[2]*PolyLog[4, 1/3])/2 - (37*Log[3]*PolyLog[4, 1/3])/4 + 
    (86*Log[2]*PolyLog[4, 1/2])/3 - 19*Log[3]*PolyLog[4, 1/2] - 
    34*Log[2]*PolyLog[4, 2/3] + (39*Log[3]*PolyLog[4, 2/3])/2 + 
    27*PolyLog[5, -1/2] + (135*PolyLog[5, -1/3])/8 - (35*PolyLog[5, 1/3])/2 + 
    (140*PolyLog[5, 1/2])/3 + 37*PolyLog[5, 2/3] + 
    (29*PolyLog[2, 3, -1/3])/8 - (13*Pi^2*Zeta[3])/24 + 
    (229*Log[2]^2*Zeta[3])/12 - (383*Log[2]*Log[3]*Zeta[3])/24 + 
    (389*Log[3]^2*Zeta[3])/96 - (241*Zeta[5])/12
 
G[0, 0, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + 8*G[0, 0, 1, 0, -1, 1/2] + 
    (23*Pi^4*Log[2])/540 + (47*Pi^2*Log[2]^3)/54 + (467*Log[2]^5)/180 + 
    (17*Pi^4*Log[3])/288 - (13*Pi^2*Log[2]^2*Log[3])/6 - 
    (19*Log[2]^4*Log[3])/12 + (5*Pi^2*Log[2]*Log[3]^2)/6 - 
    (13*Log[2]^3*Log[3]^2)/2 - (Pi^2*Log[3]^3)/48 + 
    (53*Log[2]^2*Log[3]^3)/6 - (37*Log[2]*Log[3]^4)/12 + (59*Log[3]^5)/480 - 
    (Log[2]^3*PolyLog[2, -1/2])/3 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    Log[2]*PolyLog[2, -1/2]^2 + Log[3]*PolyLog[2, -1/2]^2 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/6 - 18*Log[2]^2*PolyLog[3, 1/3] + 
    12*Log[2]*Log[3]*PolyLog[3, 1/3] + (Log[3]^2*PolyLog[3, 1/3])/2 - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 44*Log[2]*PolyLog[4, -1/2] - 
    20*Log[3]*PolyLog[4, -1/2] - 12*Log[2]*PolyLog[4, -1/3] + 
    6*Log[3]*PolyLog[4, -1/3] + 20*Log[2]*PolyLog[4, 1/3] - 
    5*Log[3]*PolyLog[4, 1/3] + 56*Log[2]*PolyLog[4, 1/2] - 
    40*Log[3]*PolyLog[4, 1/2] - 30*Log[2]*PolyLog[4, 2/3] + 
    6*Log[3]*PolyLog[4, 2/3] + 56*PolyLog[5, -1/2] + 
    (83*PolyLog[5, -1/3])/4 - (47*PolyLog[5, 1/3])/2 + 
    (272*PolyLog[5, 1/2])/3 + 20*PolyLog[5, 2/3] + 6*PolyLog[2, 3, -1/3] - 
    14*PolyLog[2, 3, 1/3] - (3*Pi^2*Zeta[3])/4 + (63*Log[2]^2*Zeta[3])/2 - 
    25*Log[2]*Log[3]*Zeta[3] + (21*Log[3]^2*Zeta[3])/4 - (153*Zeta[5])/32
 
G[0, 0, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -(Log[3]^2*PolyLog[3, 1/3])/2 - 
    3*Log[3]*PolyLog[4, 1/3] - 6*PolyLog[5, 1/3]
 
G[0, 0, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + (Pi^4*Log[2])/18 - (13*Pi^2*Log[2]^3)/36 - 
    (7*Log[2]^5)/24 - (Pi^4*Log[3])/18 + (13*Pi^2*Log[2]^2*Log[3])/12 + 
    (13*Log[2]^4*Log[3])/24 - (13*Pi^2*Log[2]*Log[3]^2)/12 + 
    (3*Log[2]^3*Log[3]^2)/4 + (13*Pi^2*Log[3]^3)/36 - 
    (31*Log[2]^2*Log[3]^3)/12 + (53*Log[2]*Log[3]^4)/24 - (5*Log[3]^5)/8 - 
    (Log[2]^3*PolyLog[2, -1/2])/6 + (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + (Log[3]*PolyLog[2, -1/2]^2)/2 + 
    Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    Log[3]^2*PolyLog[3, -1/2] - PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    3*Log[2]^2*PolyLog[3, 1/3] - 6*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    3*Log[3]^2*PolyLog[3, 1/3] - PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    2*Log[2]*PolyLog[4, -1/2] + 2*Log[3]*PolyLog[4, -1/2] - 
    2*Log[2]*PolyLog[4, 1/3] + 2*Log[3]*PolyLog[4, 1/3] + 
    9*Log[2]*PolyLog[4, 2/3] - 9*Log[3]*PolyLog[4, 2/3] - 
    14*PolyLog[5, 2/3] - 7*PolyLog[2, 3, 1/3] - 2*Log[2]^2*Zeta[3] + 
    4*Log[2]*Log[3]*Zeta[3] - 2*Log[3]^2*Zeta[3] + 14*Zeta[5]
 
G[0, 0, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + 2*G[0, 0, 1, 0, -1, 1/2] + (Pi^4*Log[2])/60 - 
    (Pi^2*Log[2]^3)/18 - (11*Log[2]^5)/120 - (17*Pi^4*Log[3])/720 + 
    (5*Pi^2*Log[2]^2*Log[3])/12 + (Log[2]^4*Log[3])/6 - 
    (11*Pi^2*Log[2]*Log[3]^2)/24 - (Log[2]^3*Log[3]^2)/12 + 
    (Pi^2*Log[3]^3)/6 - (7*Log[2]^2*Log[3]^3)/12 + (3*Log[2]*Log[3]^4)/4 - 
    (31*Log[3]^5)/120 - (Log[2]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 + (Log[3]^3*PolyLog[2, -1/2])/6 - (Log[2]*PolyLog[2, -1/2]^2)/2 + 
    (Log[3]*PolyLog[2, -1/2]^2)/2 + Log[2]^2*PolyLog[3, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] + Log[3]^2*PolyLog[3, -1/2] - 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/12 + 
    (Log[2]^2*PolyLog[3, 1/3])/2 - Log[2]*Log[3]*PolyLog[3, 1/3] + 
    Log[3]^2*PolyLog[3, 1/3] - PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    4*Log[2]*PolyLog[4, -1/2] - 3*Log[3]*PolyLog[4, -1/2] + 
    Log[2]*PolyLog[4, 1/3] + 2*Log[2]*PolyLog[4, 1/2] - 
    4*Log[3]*PolyLog[4, 1/2] + 3*Log[2]*PolyLog[4, 2/3] - 
    4*Log[3]*PolyLog[4, 2/3] + 10*PolyLog[5, -1/2] - PolyLog[5, 1/3] + 
    8*PolyLog[5, 1/2] - 6*PolyLog[5, 2/3] - 3*PolyLog[2, 3, 1/3] + 
    (Pi^2*Zeta[3])/16 - (Log[2]^2*Zeta[3])/8 + (Log[2]*Log[3]*Zeta[3])/4 - 
    (9*Log[3]^2*Zeta[3])/16 + (141*Zeta[5])/16
 
G[0, 0, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] - (Pi^4*Log[2])/18 + (7*Pi^2*Log[2]^3)/36 + 
    (23*Log[2]^5)/120 + (2*Pi^4*Log[3])/45 - (2*Pi^2*Log[2]^2*Log[3])/3 - 
    (11*Log[2]^4*Log[3])/24 + (3*Pi^2*Log[2]*Log[3]^2)/4 - 
    (Log[2]^3*Log[3]^2)/4 - (5*Pi^2*Log[3]^3)/18 + 
    (19*Log[2]^2*Log[3]^3)/12 - (37*Log[2]*Log[3]^4)/24 + (19*Log[3]^5)/40 + 
    (Log[2]^3*PolyLog[2, -1/2])/6 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]*PolyLog[2, -1/2]^2)/2 - (Log[3]*PolyLog[2, -1/2]^2)/2 - 
    Log[2]^2*PolyLog[3, -1/2] + 2*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    Log[3]^2*PolyLog[3, -1/2] + PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (3*Log[2]^2*PolyLog[3, 1/3])/2 + 4*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (5*Log[3]^2*PolyLog[3, 1/3])/2 + PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    Log[2]*PolyLog[4, -1/2] + 2*Log[2]*PolyLog[4, 1/3] - 
    3*Log[3]*PolyLog[4, 1/3] - 6*Log[2]*PolyLog[4, 2/3] + 
    7*Log[3]*PolyLog[4, 2/3] - 3*PolyLog[5, -1/2] - 3*PolyLog[5, 1/3] + 
    11*PolyLog[5, 2/3] + 4*PolyLog[2, 3, 1/3] + (Log[2]^2*Zeta[3])/2 - 
    2*Log[2]*Log[3]*Zeta[3] + (3*Log[3]^2*Zeta[3])/2 - 11*Zeta[5]
 
G[0, 0, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -PolyLog[2, 3, 1/3]
 
G[0, 1, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, 0, 1, 0, -1, 1/2] + (Pi^4*Log[2])/120 - 
    (17*Pi^2*Log[2]^3)/27 + (257*Log[2]^5)/360 - (17*Pi^4*Log[3])/540 + 
    (11*Pi^2*Log[2]^2*Log[3])/36 - (7*Log[2]^4*Log[3])/18 + 
    (5*Log[2]^3*Log[3]^2)/12 - (3*Log[2]^2*Log[3]^3)/4 + 
    (5*Log[2]*Log[3]^4)/8 - (23*Log[3]^5)/120 + (4*Log[2]^3*PolyLog[2, -1/2])/
     3 - 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*
     PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    6*Log[2]^2*PolyLog[3, -1/2] - 6*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (3*Log[3]^2*PolyLog[3, -1/2])/2 - (3*Log[2]^2*PolyLog[3, 1/3])/2 - 
    Log[2]*Log[3]*PolyLog[3, 1/3] + (3*Log[3]^2*PolyLog[3, 1/3])/2 + 
    13*Log[2]*PolyLog[4, -1/2] - 4*Log[3]*PolyLog[4, -1/2] + 
    4*Log[2]*PolyLog[4, -1/3] - 2*Log[3]*PolyLog[4, -1/3] - 
    7*Log[2]*PolyLog[4, 1/3] + 6*Log[3]*PolyLog[4, 1/3] + 
    (44*Log[2]*PolyLog[4, 1/2])/3 - (13*Log[3]*PolyLog[4, 1/2])/3 + 
    Log[2]*PolyLog[4, 2/3] - 3*Log[3]*PolyLog[4, 2/3] + 10*PolyLog[5, -1/2] + 
    4*PolyLog[5, 1/3] + (2*PolyLog[5, 1/2])/3 - 3*PolyLog[5, 2/3] + 
    PolyLog[2, 3, -1/3] - 5*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/16 + 
    (317*Log[2]^2*Zeta[3])/24 - (34*Log[2]*Log[3]*Zeta[3])/3 + 
    (17*Log[3]^2*Zeta[3])/6 + (269*Zeta[5])/24
 
G[0, 1, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] - 
    8*G[0, 0, -1, 0, -1, 1/2] - (47*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (67*Pi^4*Log[2])/1620 - (2111*Pi^2*Log[2]^3)/648 - (7507*Log[2]^5)/1080 - 
    (43*Pi^4*Log[3])/288 + (227*Pi^2*Log[2]^2*Log[3])/24 + 
    (97*Log[2]^4*Log[3])/16 - (289*Pi^2*Log[2]*Log[3]^2)/48 + 
    (173*Log[2]^3*Log[3]^2)/12 + (85*Pi^2*Log[3]^3)/72 - 
    (631*Log[2]^2*Log[3]^3)/24 + (435*Log[2]*Log[3]^4)/32 - 
    (421*Log[3]^5)/192 - (Pi^2*Log[2]*PolyLog[2, -1/2])/3 - 
    Log[2]^3*PolyLog[2, -1/2] + (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/6 - 
    Log[2]*PolyLog[2, -1/2]^2 + Log[3]*PolyLog[2, -1/2]^2 - 
    (Pi^2*PolyLog[3, -1/2])/2 - Log[2]^2*PolyLog[3, -1/2] - 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] + (7*Log[3]^2*PolyLog[3, -1/2])/2 + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 45*Log[2]^2*PolyLog[3, 1/3] - 
    (73*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + (39*Log[3]^2*PolyLog[3, 1/3])/8 - 
    110*Log[2]*PolyLog[4, -1/2] + (103*Log[3]*PolyLog[4, -1/2])/2 + 
    (107*Log[2]*PolyLog[4, -1/3])/4 - (131*Log[3]*PolyLog[4, -1/3])/8 - 
    (65*Log[2]*PolyLog[4, 1/3])/2 + (35*Log[3]*PolyLog[4, 1/3])/4 - 
    (355*Log[2]*PolyLog[4, 1/2])/3 + 72*Log[3]*PolyLog[4, 1/2] + 
    94*Log[2]*PolyLog[4, 2/3] - (85*Log[3]*PolyLog[4, 2/3])/2 - 
    (419*PolyLog[5, -1/2])/3 - (361*PolyLog[5, -1/3])/8 + 
    (75*PolyLog[5, 1/3])/2 - (1652*PolyLog[5, 1/2])/9 - 82*PolyLog[5, 2/3] - 
    (107*PolyLog[2, 3, -1/3])/8 + 17*PolyLog[2, 3, 1/3] + 
    (3*Pi^2*Zeta[3])/2 - (3727*Log[2]^2*Zeta[3])/48 + 
    (371*Log[2]*Log[3]*Zeta[3])/6 - (1367*Log[3]^2*Zeta[3])/96 + 
    (4*PolyLog[2, -1/2]*Zeta[3])/3 + (4801*Zeta[5])/144
 
G[0, 1, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] - 
    3*G[0, 0, -1, 0, -1, 1/2] - 6*G[0, 0, 1, 0, -1, 1/2] + 
    (11*Pi^4*Log[2])/720 - (13*Pi^2*Log[2]^3)/9 - (97*Log[2]^5)/60 - 
    (253*Pi^4*Log[3])/4320 + (29*Pi^2*Log[2]^2*Log[3])/9 + 
    (55*Log[2]^4*Log[3])/36 - (49*Pi^2*Log[2]*Log[3]^2)/24 + 
    (19*Log[2]^3*Log[3]^2)/4 + (29*Pi^2*Log[3]^3)/72 - 
    (26*Log[2]^2*Log[3]^3)/3 + (115*Log[2]*Log[3]^4)/24 - (69*Log[3]^5)/80 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 + (5*Log[2]^3*PolyLog[2, -1/2])/6 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + (Log[3]*PolyLog[2, -1/2]^2)/2 - 
    (Pi^2*PolyLog[3, -1/2])/4 + 4*Log[2]^2*PolyLog[3, -1/2] - 
    5*Log[2]*Log[3]*PolyLog[3, -1/2] + (5*Log[3]^2*PolyLog[3, -1/2])/2 + 
    13*Log[2]^2*PolyLog[3, 1/3] - 12*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (5*Log[3]^2*PolyLog[3, 1/3])/2 - 28*Log[2]*PolyLog[4, -1/2] + 
    14*Log[3]*PolyLog[4, -1/2] + 10*Log[2]*PolyLog[4, -1/3] - 
    (13*Log[3]*PolyLog[4, -1/3])/2 - 13*Log[2]*PolyLog[4, 1/3] + 
    6*Log[3]*PolyLog[4, 1/3] - 28*Log[2]*PolyLog[4, 1/2] + 
    (56*Log[3]*PolyLog[4, 1/2])/3 + 30*Log[2]*PolyLog[4, 2/3] - 
    16*Log[3]*PolyLog[4, 2/3] - 47*PolyLog[5, -1/2] - 
    (27*PolyLog[5, -1/3])/2 + 13*PolyLog[5, 1/3] - 64*PolyLog[5, 1/2] - 
    28*PolyLog[5, 2/3] - (7*PolyLog[2, 3, -1/3])/2 + 2*PolyLog[2, 3, 1/3] + 
    (7*Pi^2*Zeta[3])/32 - (367*Log[2]^2*Zeta[3])/24 + 
    (307*Log[2]*Log[3]*Zeta[3])/24 - (125*Log[3]^2*Zeta[3])/48 - 
    (PolyLog[2, -1/2]*Zeta[3])/8 + (3323*Zeta[5])/192
 
G[0, 1, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] + 
    10*G[0, 0, -1, 0, -1, 1/2] + (52*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (1237*Pi^4*Log[2])/12960 + (1247*Pi^2*Log[2]^3)/324 + 
    (4039*Log[2]^5)/540 + (817*Pi^4*Log[3])/4320 - 
    (187*Pi^2*Log[2]^2*Log[3])/18 - (973*Log[2]^4*Log[3])/144 + 
    (109*Pi^2*Log[2]*Log[3]^2)/16 - (197*Log[2]^3*Log[3]^2)/12 - 
    (73*Pi^2*Log[3]^3)/48 + (695*Log[2]^2*Log[3]^3)/24 - 
    (469*Log[2]*Log[3]^4)/32 + (761*Log[3]^5)/320 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/3 - (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/6 - Log[3]*PolyLog[2, -1/2]^2 + 
    (Pi^2*PolyLog[3, -1/2])/2 - Log[2]^2*PolyLog[3, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] - (5*Log[3]^2*PolyLog[3, -1/2])/2 - 
    4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 52*Log[2]^2*PolyLog[3, 1/3] + 
    (81*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (35*Log[3]^2*PolyLog[3, 1/3])/8 + 
    122*Log[2]*PolyLog[4, -1/2] - (121*Log[3]*PolyLog[4, -1/2])/2 - 
    (101*Log[2]*PolyLog[4, -1/3])/4 + (101*Log[3]*PolyLog[4, -1/3])/8 + 
    (59*Log[2]*PolyLog[4, 1/3])/2 + (3*Log[3]*PolyLog[4, 1/3])/4 + 
    (370*Log[2]*PolyLog[4, 1/2])/3 - (263*Log[3]*PolyLog[4, 1/2])/3 - 
    108*Log[2]*PolyLog[4, 2/3] + (93*Log[3]*PolyLog[4, 2/3])/2 + 
    (466*PolyLog[5, -1/2])/3 + (385*PolyLog[5, -1/3])/8 - 
    (73*PolyLog[5, 1/3])/2 + (1666*PolyLog[5, 1/2])/9 + 96*PolyLog[5, 2/3] + 
    (127*PolyLog[2, 3, -1/3])/8 - 23*PolyLog[2, 3, 1/3] - 
    (113*Pi^2*Zeta[3])/48 + (2167*Log[2]^2*Zeta[3])/24 - 
    (1921*Log[2]*Log[3]*Zeta[3])/24 + (2107*Log[3]^2*Zeta[3])/96 - 
    (8*PolyLog[2, -1/2]*Zeta[3])/3 - (12581*Zeta[5])/576
 
G[0, 1, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + (2*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (757*Pi^4*Log[2])/6480 + (79*Pi^2*Log[2]^3)/324 + (11*Log[2]^5)/135 + 
    (107*Pi^4*Log[3])/864 - (23*Pi^2*Log[2]^2*Log[3])/36 - 
    (23*Log[2]^4*Log[3])/72 + (5*Pi^2*Log[2]*Log[3]^2)/6 - 
    (5*Log[2]^3*Log[3]^2)/12 - (61*Pi^2*Log[3]^3)/144 + 
    (23*Log[2]^2*Log[3]^3)/12 - (15*Log[2]*Log[3]^4)/8 + (21*Log[3]^5)/32 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    Log[2]*PolyLog[2, -1/2]^2 - 2*Log[2]^2*PolyLog[3, -1/2] + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - (Log[3]^2*PolyLog[3, -1/2])/2 + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (3*Log[2]^2*PolyLog[3, 1/3])/2 + 
    7*Log[2]*Log[3]*PolyLog[3, 1/3] - (9*Log[3]^2*PolyLog[3, 1/3])/2 - 
    7*Log[2]*PolyLog[4, -1/2] + 5*Log[3]*PolyLog[4, -1/2] + 
    2*Log[2]*PolyLog[4, -1/3] - (17*Log[3]*PolyLog[4, -1/3])/4 + 
    3*Log[2]*PolyLog[4, 1/3] - (7*Log[3]*PolyLog[4, 1/3])/2 - 
    (10*Log[2]*PolyLog[4, 1/2])/3 + (10*Log[3]*PolyLog[4, 1/2])/3 - 
    7*Log[2]*PolyLog[4, 2/3] + 9*Log[3]*PolyLog[4, 2/3] - 
    (31*PolyLog[5, -1/2])/3 - (15*PolyLog[5, -1/3])/2 - 3*PolyLog[5, 1/3] - 
    (4*PolyLog[5, 1/2])/9 + 17*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3] + 
    11*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/6 - (71*Log[2]^2*Zeta[3])/24 - 
    (5*Log[2]*Log[3]*Zeta[3])/12 + (8*Log[3]^2*Zeta[3])/3 + 
    (13*PolyLog[2, -1/2]*Zeta[3])/6 - (8039*Zeta[5])/288
 
G[0, 1, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (29*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (28*Pi^4*Log[2])/405 + (1565*Pi^2*Log[2]^3)/648 + (1043*Log[2]^5)/216 + 
    (299*Pi^4*Log[3])/1440 - (161*Pi^2*Log[2]^2*Log[3])/24 - 
    (35*Log[2]^4*Log[3])/8 + (223*Pi^2*Log[2]*Log[3]^2)/48 - 
    (65*Log[2]^3*Log[3]^2)/6 - (43*Pi^2*Log[3]^3)/36 + 
    (59*Log[2]^2*Log[3]^3)/3 - (337*Log[2]*Log[3]^4)/32 + 
    (929*Log[3]^5)/480 + (Log[2]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 - (Log[3]^3*PolyLog[2, -1/2])/6 + (Log[2]*PolyLog[2, -1/2]^2)/2 - 
    (Log[3]*PolyLog[2, -1/2]^2)/2 - (3*Log[2]^2*PolyLog[3, -1/2])/2 + 
    3*Log[2]*Log[3]*PolyLog[3, -1/2] - (3*Log[3]^2*PolyLog[3, -1/2])/2 - 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] - 34*Log[2]^2*PolyLog[3, 1/3] + 
    31*Log[2]*Log[3]*PolyLog[3, 1/3] - (25*Log[3]^2*PolyLog[3, 1/3])/4 + 
    72*Log[2]*PolyLog[4, -1/2] - 35*Log[3]*PolyLog[4, -1/2] - 
    (61*Log[2]*PolyLog[4, -1/3])/4 + 6*Log[3]*PolyLog[4, -1/3] + 
    (47*Log[2]*PolyLog[4, 1/3])/2 - 5*Log[3]*PolyLog[4, 1/3] + 
    (239*Log[2]*PolyLog[4, 1/2])/3 - 55*Log[3]*PolyLog[4, 1/2] - 
    72*Log[2]*PolyLog[4, 2/3] + 35*Log[3]*PolyLog[4, 2/3] + 
    (263*PolyLog[5, -1/2])/3 + 27*PolyLog[5, -1/3] - (59*PolyLog[5, 1/3])/2 + 
    (1106*PolyLog[5, 1/2])/9 + 71*PolyLog[5, 2/3] + 
    (37*PolyLog[2, 3, -1/3])/4 - 6*PolyLog[2, 3, 1/3] - 
    (37*Pi^2*Zeta[3])/24 + (329*Log[2]^2*Zeta[3])/6 - 
    (613*Log[2]*Log[3]*Zeta[3])/12 + (745*Log[3]^2*Zeta[3])/48 - 
    (11*PolyLog[2, -1/2]*Zeta[3])/24 - (5563*Zeta[5])/144
 
G[0, 1, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] + 
    3*G[0, 0, -1, 0, -1, 1/2] + 4*G[0, 0, 1, 0, -1, 1/2] - 
    (163*Pi^4*Log[2])/4320 + (17*Pi^2*Log[2]^3)/24 + (359*Log[2]^5)/180 + 
    (71*Pi^4*Log[3])/1080 - (185*Pi^2*Log[2]^2*Log[3])/72 - 
    (245*Log[2]^4*Log[3])/144 + (97*Pi^2*Log[2]*Log[3]^2)/48 - 
    (49*Log[2]^3*Log[3]^2)/12 - (19*Pi^2*Log[3]^3)/36 + 
    (59*Log[2]^2*Log[3]^3)/8 - (385*Log[2]*Log[3]^4)/96 + 
    (713*Log[3]^5)/960 + (Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[3]*PolyLog[2, -1/2]^2)/2 + (Pi^2*PolyLog[3, -1/2])/4 + 
    Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (Log[3]^2*PolyLog[3, -1/2])/2 - 15*Log[2]^2*PolyLog[3, 1/3] + 
    (25*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (15*Log[3]^2*PolyLog[3, 1/3])/8 + 
    31*Log[2]*PolyLog[4, -1/2] - (31*Log[3]*PolyLog[4, -1/2])/2 - 
    (11*Log[2]*PolyLog[4, -1/3])/4 + (11*Log[3]*PolyLog[4, -1/3])/8 + 
    (13*Log[2]*PolyLog[4, 1/3])/2 + (5*Log[3]*PolyLog[4, 1/3])/4 + 
    (104*Log[2]*PolyLog[4, 1/2])/3 - (70*Log[3]*PolyLog[4, 1/2])/3 - 
    28*Log[2]*PolyLog[4, 2/3] + (27*Log[3]*PolyLog[4, 2/3])/2 + 
    44*PolyLog[5, -1/2] + (81*PolyLog[5, -1/3])/8 - (19*PolyLog[5, 1/3])/2 + 
    54*PolyLog[5, 1/2] + 28*PolyLog[5, 2/3] + (35*PolyLog[2, 3, -1/3])/8 - 
    5*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/8 + (647*Log[2]^2*Zeta[3])/24 - 
    (629*Log[2]*Log[3]*Zeta[3])/24 + (731*Log[3]^2*Zeta[3])/96 + 
    (PolyLog[2, -1/2]*Zeta[3])/4 - (2297*Zeta[5])/192
 
G[0, 1, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -6*G[0, 0, -1, 0, -1, 1/2] - 
    8*G[0, 0, 1, 0, -1, 1/2] - (121*Pi^4*Log[2])/2160 - 
    (193*Pi^2*Log[2]^3)/108 - (64*Log[2]^5)/15 + (Pi^4*Log[3])/480 + 
    (41*Pi^2*Log[2]^2*Log[3])/8 + (29*Log[2]^4*Log[3])/8 - 
    (23*Pi^2*Log[2]*Log[3]^2)/8 + (101*Log[2]^3*Log[3]^2)/12 + 
    (5*Pi^2*Log[3]^3)/12 - (43*Log[2]^2*Log[3]^3)/3 + 
    (311*Log[2]*Log[3]^4)/48 - (359*Log[3]^5)/480 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - (Log[2]^3*PolyLog[2, -1/2])/2 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (Log[3]*PolyLog[2, -1/2]^2)/2 - (3*Log[2]^2*PolyLog[3, -1/2])/2 + 
    (3*Log[3]^2*PolyLog[3, -1/2])/2 + 3*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    26*Log[2]^2*PolyLog[3, 1/3] - 15*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (7*Log[3]^2*PolyLog[3, 1/3])/4 - 70*Log[2]*PolyLog[4, -1/2] + 
    35*Log[3]*PolyLog[4, -1/2] + (37*Log[2]*PolyLog[4, -1/3])/2 - 
    (49*Log[3]*PolyLog[4, -1/3])/4 - 15*Log[2]*PolyLog[4, 1/3] - 
    (5*Log[3]*PolyLog[4, 1/3])/2 - (220*Log[2]*PolyLog[4, 1/2])/3 + 
    49*Log[3]*PolyLog[4, 1/2] + 52*Log[2]*PolyLog[4, 2/3] - 
    18*Log[3]*PolyLog[4, 2/3] - 86*PolyLog[5, -1/2] - 
    (135*PolyLog[5, -1/3])/4 + 17*PolyLog[5, 1/3] - (308*PolyLog[5, 1/2])/3 - 
    36*PolyLog[5, 2/3] - (37*PolyLog[2, 3, -1/3])/4 + 22*PolyLog[2, 3, 1/3] + 
    (37*Pi^2*Zeta[3])/24 - (1193*Log[2]^2*Zeta[3])/24 + 
    (469*Log[2]*Log[3]*Zeta[3])/12 - (415*Log[3]^2*Zeta[3])/48 + 
    (11*PolyLog[2, -1/2]*Zeta[3])/4 - (209*Zeta[5])/32
 
G[0, 1, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] - (8*Pi^4*Log[2])/135 - (11*Pi^2*Log[2]^3)/216 + 
    (31*Log[2]^5)/180 + (323*Pi^4*Log[3])/4320 - (17*Pi^2*Log[2]^2*Log[3])/
     72 - (29*Log[2]^4*Log[3])/144 + (9*Pi^2*Log[2]*Log[3]^2)/16 - 
    (Log[2]^3*Log[3]^2)/2 - (7*Pi^2*Log[3]^3)/24 + (11*Log[2]^2*Log[3]^3)/8 - 
    (121*Log[2]*Log[3]^4)/96 + (27*Log[3]^5)/64 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 + (Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 - (Log[3]^3*PolyLog[2, -1/2])/6 + (Log[2]^2*PolyLog[3, -1/2])/2 - 
    Log[2]*Log[3]*PolyLog[3, -1/2] + (Log[3]^2*PolyLog[3, -1/2])/2 + 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] - 3*Log[2]^2*PolyLog[3, 1/3] + 
    (13*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (27*Log[3]^2*PolyLog[3, 1/3])/8 - 
    Log[2]*PolyLog[4, -1/2] + (Log[3]*PolyLog[4, -1/2])/2 + 
    (13*Log[2]*PolyLog[4, -1/3])/4 - (25*Log[3]*PolyLog[4, -1/3])/8 + 
    (7*Log[2]*PolyLog[4, 1/3])/2 - (15*Log[3]*PolyLog[4, 1/3])/4 + 
    2*Log[2]*PolyLog[4, 1/2] - (7*Log[3]*PolyLog[4, 1/2])/3 - 
    5*Log[2]*PolyLog[4, 2/3] + (11*Log[3]*PolyLog[4, 2/3])/2 - 
    PolyLog[5, -1/2] - (27*PolyLog[5, -1/3])/8 - (13*PolyLog[5, 1/3])/2 + 
    (16*PolyLog[5, 1/2])/3 + 12*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3]/8 + 
    7*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/48 + (121*Log[2]^2*Zeta[3])/48 - 
    (35*Log[2]*Log[3]*Zeta[3])/6 + (293*Log[3]^2*Zeta[3])/96 + 
    (7*PolyLog[2, -1/2]*Zeta[3])/8 - (89*Zeta[5])/6
 
G[0, 1, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] - (41*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (361*Pi^4*Log[2])/2592 - (1847*Pi^2*Log[2]^3)/648 - (833*Log[2]^5)/216 - 
    (19*Pi^4*Log[3])/80 + (155*Pi^2*Log[2]^2*Log[3])/24 + 
    (79*Log[2]^4*Log[3])/24 - (33*Pi^2*Log[2]*Log[3]^2)/8 + 
    (71*Log[2]^3*Log[3]^2)/6 + (47*Pi^2*Log[3]^3)/48 - 
    (81*Log[2]^2*Log[3]^3)/4 + (515*Log[2]*Log[3]^4)/48 - 
    (937*Log[3]^5)/480 + Log[2]^3*PolyLog[2, -1/2] - 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/6 + Log[2]*PolyLog[2, -1/2]^2 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]^2*PolyLog[3, -1/2] + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    33*Log[2]^2*PolyLog[3, 1/3] - 32*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (15*Log[3]^2*PolyLog[3, 1/3])/2 - 68*Log[2]*PolyLog[4, -1/2] + 
    34*Log[3]*PolyLog[4, -1/2] + (41*Log[2]*PolyLog[4, -1/3])/2 - 
    (41*Log[3]*PolyLog[4, -1/3])/4 - 37*Log[2]*PolyLog[4, 1/3] + 
    (31*Log[3]*PolyLog[4, 1/3])/2 - 65*Log[2]*PolyLog[4, 1/2] + 
    53*Log[3]*PolyLog[4, 1/2] + 70*Log[2]*PolyLog[4, 2/3] - 
    36*Log[3]*PolyLog[4, 2/3] - (257*PolyLog[5, -1/2])/3 - 
    30*PolyLog[5, -1/3] + 37*PolyLog[5, 1/3] - (1118*PolyLog[5, 1/2])/9 - 
    72*PolyLog[5, 2/3] - (15*PolyLog[2, 3, -1/3])/2 + 2*PolyLog[2, 3, 1/3] + 
    (55*Pi^2*Zeta[3])/48 - (633*Log[2]^2*Zeta[3])/16 + 
    (277*Log[2]*Log[3]*Zeta[3])/8 - (77*Log[3]^2*Zeta[3])/8 + 
    (4*PolyLog[2, -1/2]*Zeta[3])/3 + (21169*Zeta[5])/576
 
G[0, 1, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -8*G[0, -1, 0, -1, -1, 1/2] + 
    8*G[0, 0, -1, 0, -1, 1/2] - (28*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1699*Pi^4*Log[2])/3240 - (553*Pi^2*Log[2]^3)/162 - (283*Log[2]^5)/54 - 
    (2467*Pi^4*Log[3])/4320 + (377*Pi^2*Log[2]^2*Log[3])/36 + 
    (217*Log[2]^4*Log[3])/36 - 9*Pi^2*Log[2]*Log[3]^2 + 
    (37*Log[2]^3*Log[3]^2)/3 + (377*Pi^2*Log[3]^3)/144 - 
    (353*Log[2]^2*Log[3]^3)/12 + (247*Log[2]*Log[3]^4)/12 - 
    (793*Log[3]^5)/160 - (4*Log[2]^3*PolyLog[2, -1/2])/3 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 3*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/2 - 
    4*Log[2]*PolyLog[2, -1/2]^2 + 3*Log[3]*PolyLog[2, -1/2]^2 + 
    8*Log[2]^2*PolyLog[3, -1/2] - 16*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    8*Log[3]^2*PolyLog[3, -1/2] - 8*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/3 + 42*Log[2]^2*PolyLog[3, 1/3] - 
    60*Log[2]*Log[3]*PolyLog[3, 1/3] + 24*Log[3]^2*PolyLog[3, 1/3] - 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 48*Log[2]*PolyLog[4, -1/2] + 
    24*Log[3]*PolyLog[4, -1/2] + 14*Log[2]*PolyLog[4, -1/3] - 
    (39*Log[3]*PolyLog[4, -1/3])/4 - 44*Log[2]*PolyLog[4, 1/3] + 
    (73*Log[3]*PolyLog[4, 1/3])/2 - (196*Log[2]*PolyLog[4, 1/2])/3 + 
    (116*Log[3]*PolyLog[4, 1/2])/3 + 104*Log[2]*PolyLog[4, 2/3] - 
    80*Log[3]*PolyLog[4, 2/3] - (124*PolyLog[5, -1/2])/3 - 
    (49*PolyLog[5, -1/3])/2 + 55*PolyLog[5, 1/3] - (952*PolyLog[5, 1/2])/9 - 
    144*PolyLog[5, 2/3] - 7*PolyLog[2, 3, -1/3] - 32*PolyLog[2, 3, 1/3] + 
    (11*Pi^2*Zeta[3])/12 - (571*Log[2]^2*Zeta[3])/12 + 
    (287*Log[2]*Log[3]*Zeta[3])/6 - (187*Log[3]^2*Zeta[3])/12 - 
    (13*PolyLog[2, -1/2]*Zeta[3])/3 + (8911*Zeta[5])/72
 
G[0, 1, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -5*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] - (29*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (941*Pi^4*Log[2])/3240 - (2039*Pi^2*Log[2]^3)/648 - 
    (4813*Log[2]^5)/1080 - (349*Pi^4*Log[3])/864 + 
    (307*Pi^2*Log[2]^2*Log[3])/36 + (307*Log[2]^4*Log[3])/72 - 
    (319*Pi^2*Log[2]*Log[3]^2)/48 + (51*Log[2]^3*Log[3]^2)/4 + 
    (133*Pi^2*Log[3]^3)/72 - (305*Log[2]^2*Log[3]^3)/12 + 
    (1531*Log[2]*Log[3]^4)/96 - (1697*Log[3]^5)/480 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 + (3*Log[3]*PolyLog[2, -1/2]^2)/2 + 
    5*Log[2]^2*PolyLog[3, -1/2] - 10*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    5*Log[3]^2*PolyLog[3, -1/2] - 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/6 + 39*Log[2]^2*PolyLog[3, 1/3] - 
    47*Log[2]*Log[3]*PolyLog[3, 1/3] + (65*Log[3]^2*PolyLog[3, 1/3])/4 - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 56*Log[2]*PolyLog[4, -1/2] + 
    27*Log[3]*PolyLog[4, -1/2] + (69*Log[2]*PolyLog[4, -1/3])/4 - 
    10*Log[3]*PolyLog[4, -1/3] - (83*Log[2]*PolyLog[4, 1/3])/2 + 
    27*Log[3]*PolyLog[4, 1/3] - (191*Log[2]*PolyLog[4, 1/2])/3 + 
    (133*Log[3]*PolyLog[4, 1/2])/3 + 88*Log[2]*PolyLog[4, 2/3] - 
    59*Log[3]*PolyLog[4, 2/3] - (167*PolyLog[5, -1/2])/3 - 
    27*PolyLog[5, -1/3] + (95*PolyLog[5, 1/3])/2 - (1022*PolyLog[5, 1/2])/9 - 
    109*PolyLog[5, 2/3] - (29*PolyLog[2, 3, -1/3])/4 - 
    16*PolyLog[2, 3, 1/3] + (13*Pi^2*Zeta[3])/12 - 
    (1039*Log[2]^2*Zeta[3])/24 + (253*Log[2]*Log[3]*Zeta[3])/6 - 
    (635*Log[3]^2*Zeta[3])/48 - (55*PolyLog[2, -1/2]*Zeta[3])/24 + 
    (24575*Zeta[5])/288
 
G[0, 1, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, -1, 0, -1, -1, 1/2] - 
    6*G[0, 0, -1, 0, -1, 1/2] - (10*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (395*Pi^4*Log[2])/1296 + (271*Pi^2*Log[2]^3)/324 + (7*Log[2]^5)/270 + 
    (113*Pi^4*Log[3])/432 - (25*Pi^2*Log[2]^2*Log[3])/9 - 
    (59*Log[2]^4*Log[3])/36 + (41*Pi^2*Log[2]*Log[3]^2)/12 + 
    (5*Log[2]^3*Log[3]^2)/6 - (23*Pi^2*Log[3]^3)/18 + 
    (19*Log[2]^2*Log[3]^3)/4 - (151*Log[2]*Log[3]^4)/24 + (173*Log[3]^5)/80 + 
    Log[2]^3*PolyLog[2, -1/2] - (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    3*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 3*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (5*Log[3]^3*PolyLog[2, -1/2])/6 + 3*Log[2]*PolyLog[2, -1/2]^2 - 
    3*Log[3]*PolyLog[2, -1/2]^2 - 6*Log[2]^2*PolyLog[3, -1/2] + 
    12*Log[2]*Log[3]*PolyLog[3, -1/2] - 6*Log[3]^2*PolyLog[3, -1/2] + 
    6*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/3 - 
    3*Log[2]^2*PolyLog[3, 1/3] + 16*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (23*Log[3]^2*PolyLog[3, 1/3])/2 + 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    20*Log[2]*PolyLog[4, -1/2] + 10*Log[3]*PolyLog[4, -1/2] + 
    5*Log[2]*PolyLog[4, -1/3] - (5*Log[3]*PolyLog[4, -1/3])/2 + 
    2*Log[2]*PolyLog[4, 1/3] - 10*Log[3]*PolyLog[4, 1/3] - 
    (70*Log[2]*PolyLog[4, 1/2])/3 + (50*Log[3]*PolyLog[4, 1/2])/3 - 
    22*Log[2]*PolyLog[4, 2/3] + 32*Log[3]*PolyLog[4, 2/3] - 
    (106*PolyLog[5, -1/2])/3 - (17*PolyLog[5, -1/3])/2 - 4*PolyLog[5, 1/3] - 
    (340*PolyLog[5, 1/2])/9 + 52*PolyLog[5, 2/3] - 
    (5*PolyLog[2, 3, -1/3])/2 + 30*PolyLog[2, 3, 1/3] + (7*Pi^2*Zeta[3])/24 - 
    (185*Log[2]^2*Zeta[3])/24 - (5*Log[2]*Log[3]*Zeta[3])/12 + 
    (79*Log[3]^2*Zeta[3])/24 + (13*PolyLog[2, -1/2]*Zeta[3])/6 - 
    (16445*Zeta[5])/288
 
G[0, 1, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -(Log[2]^2*Log[3]^3)/12 + (Log[2]*Log[3]^4)/6 - 
    Log[3]^5/12 - (Log[3]^3*PolyLog[2, -1/2])/6 + Log[3]^2*PolyLog[3, 1/3] + 
    3*Log[3]*PolyLog[4, 1/3] + 4*PolyLog[5, 1/3]
 
G[0, 1, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] - 
    3*G[0, 0, -1, 0, -1, 1/2] - (Pi^4*Log[2])/6 + (3*Pi^2*Log[2]^3)/4 + 
    (27*Log[2]^5)/40 + (Pi^4*Log[3])/6 - (9*Pi^2*Log[2]^2*Log[3])/4 - 
    (11*Log[2]^4*Log[3])/8 + (9*Pi^2*Log[2]*Log[3]^2)/4 - 
    (5*Log[2]^3*Log[3]^2)/4 - (3*Pi^2*Log[3]^3)/4 + 
    (21*Log[2]^2*Log[3]^3)/4 - (37*Log[2]*Log[3]^4)/8 + (53*Log[3]^5)/40 + 
    (Log[2]^3*PolyLog[2, -1/2])/2 - (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/2 + 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 - (3*Log[3]*PolyLog[2, -1/2]^2)/2 - 
    3*Log[2]^2*PolyLog[3, -1/2] + 6*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    3*Log[3]^2*PolyLog[3, -1/2] + 3*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (13*Log[2]^2*PolyLog[3, 1/3])/2 + 13*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (13*Log[3]^2*PolyLog[3, 1/3])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    6*Log[2]*PolyLog[4, 1/3] - 6*Log[3]*PolyLog[4, 1/3] - 
    21*Log[2]*PolyLog[4, 2/3] + 21*Log[3]*PolyLog[4, 2/3] - 
    6*PolyLog[5, -1/2] - 6*PolyLog[5, 1/3] + 36*PolyLog[5, 2/3] + 
    15*PolyLog[2, 3, 1/3] + 3*Log[2]^2*Zeta[3] - 6*Log[2]*Log[3]*Zeta[3] + 
    3*Log[3]^2*Zeta[3] - 36*Zeta[5]
 
G[0, 1, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    5*G[0, 0, -1, 0, -1, 1/2] - 8*G[0, 0, 1, 0, -1, 1/2] - 
    (53*Pi^4*Log[2])/864 - (89*Pi^2*Log[2]^3)/108 - (73*Log[2]^5)/40 + 
    (83*Pi^4*Log[3])/2160 + (113*Pi^2*Log[2]^2*Log[3])/72 + 
    (143*Log[2]^4*Log[3])/144 - (5*Pi^2*Log[2]*Log[3]^2)/16 + 
    (31*Log[2]^3*Log[3]^2)/6 - (Pi^2*Log[3]^3)/6 - 
    (151*Log[2]^2*Log[3]^3)/24 + (151*Log[2]*Log[3]^4)/96 + 
    (217*Log[3]^5)/960 - (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + 
    (5*Log[2]^3*PolyLog[2, -1/2])/6 - (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/2 + 2*Log[2]*PolyLog[2, -1/2]^2 - 
    (3*Log[3]*PolyLog[2, -1/2]^2)/2 - 2*Log[2]^2*PolyLog[3, -1/2] + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - 2*Log[3]^2*PolyLog[3, -1/2] + 
    5*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/6 + 
    12*Log[2]^2*PolyLog[3, 1/3] - (11*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (23*Log[3]^2*PolyLog[3, 1/3])/8 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    43*Log[2]*PolyLog[4, -1/2] + (45*Log[3]*PolyLog[4, -1/2])/2 + 
    (37*Log[2]*PolyLog[4, -1/3])/4 - (37*Log[3]*PolyLog[4, -1/3])/8 - 
    (19*Log[2]*PolyLog[4, 1/3])/2 - (7*Log[3]*PolyLog[4, 1/3])/4 - 
    (122*Log[2]*PolyLog[4, 1/2])/3 + (97*Log[3]*PolyLog[4, 1/2])/3 + 
    20*Log[2]*PolyLog[4, 2/3] + (Log[3]*PolyLog[4, 2/3])/2 - 
    63*PolyLog[5, -1/2] - (135*PolyLog[5, -1/3])/8 + (21*PolyLog[5, 1/3])/2 - 
    (202*PolyLog[5, 1/2])/3 - 6*PolyLog[5, 2/3] - (37*PolyLog[2, 3, -1/3])/
     8 + 17*PolyLog[2, 3, 1/3] + (31*Pi^2*Zeta[3])/48 - 
    (287*Log[2]^2*Zeta[3])/12 + (445*Log[2]*Log[3]*Zeta[3])/24 - 
    (325*Log[3]^2*Zeta[3])/96 + (11*PolyLog[2, -1/2]*Zeta[3])/4 - 
    (1337*Zeta[5])/64
 
G[0, 1, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (2*Pi^4*Log[2])/9 - (7*Pi^2*Log[2]^3)/9 - 
    (23*Log[2]^5)/30 - (Pi^4*Log[3])/5 + (5*Pi^2*Log[2]^2*Log[3])/2 + 
    (13*Log[2]^4*Log[3])/8 - (8*Pi^2*Log[2]*Log[3]^2)/3 + 
    (3*Log[2]^3*Log[3]^2)/2 + (17*Pi^2*Log[3]^3)/18 - 
    (79*Log[2]^2*Log[3]^3)/12 + 6*Log[2]*Log[3]^4 - (71*Log[3]^5)/40 - 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 + (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 - Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    2*Log[2]*PolyLog[2, -1/2]^2 + (3*Log[3]*PolyLog[2, -1/2]^2)/2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 8*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    4*Log[3]^2*PolyLog[3, -1/2] - 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    7*Log[2]^2*PolyLog[3, 1/3] - 16*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    9*Log[3]^2*PolyLog[3, 1/3] - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    4*Log[2]*PolyLog[4, -1/2] - 2*Log[3]*PolyLog[4, -1/2] - 
    8*Log[2]*PolyLog[4, 1/3] + 10*Log[3]*PolyLog[4, 1/3] + 
    24*Log[2]*PolyLog[4, 2/3] - 26*Log[3]*PolyLog[4, 2/3] + 
    12*PolyLog[5, -1/2] + 12*PolyLog[5, 1/3] - 44*PolyLog[5, 2/3] - 
    16*PolyLog[2, 3, 1/3] - 2*Log[2]^2*Zeta[3] + 6*Log[2]*Log[3]*Zeta[3] - 
    4*Log[3]^2*Zeta[3] + 44*Zeta[5]
 
G[0, 1, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + (Pi^4*Log[2])/30 - 
    (5*Pi^2*Log[2]^3)/36 - (11*Log[2]^5)/120 - (Pi^4*Log[3])/30 + 
    (5*Pi^2*Log[2]^2*Log[3])/12 + (Log[2]^4*Log[3])/12 - 
    (5*Pi^2*Log[2]*Log[3]^2)/12 + (7*Log[2]^3*Log[3]^2)/12 + 
    (5*Pi^2*Log[3]^3)/36 - (4*Log[2]^2*Log[3]^3)/3 + 
    (25*Log[2]*Log[3]^4)/24 - (17*Log[3]^5)/60 + (Log[2]^3*PolyLog[2, -1/2])/
     6 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    Log[3]^2*PolyLog[3, -1/2] + Log[2]^2*PolyLog[3, 1/3] - 
    2*Log[2]*Log[3]*PolyLog[3, 1/3] + Log[3]^2*PolyLog[3, 1/3] + 
    4*Log[2]*PolyLog[4, 2/3] - 4*Log[3]*PolyLog[4, 2/3] - 7*PolyLog[5, 2/3] - 
    (Log[2]^2*Zeta[3])/2 + Log[2]*Log[3]*Zeta[3] - (Log[3]^2*Zeta[3])/2 + 
    7*Zeta[5]
 
G[0, 1, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, 1, 0, -1, 1/2] + (53*Pi^4*Log[2])/720 - (31*Pi^2*Log[2]^3)/72 + 
    (7*Log[2]^5)/60 - (13*Pi^4*Log[3])/240 + (11*Pi^2*Log[2]^2*Log[3])/12 - 
    (5*Log[2]^4*Log[3])/12 - (19*Pi^2*Log[2]*Log[3]^2)/24 + 
    2*Log[2]^3*Log[3]^2 + (Pi^2*Log[3]^3)/4 - (37*Log[2]^2*Log[3]^3)/12 + 
    2*Log[2]*Log[3]^4 - (59*Log[3]^5)/120 + (Pi^2*Log[2]*PolyLog[2, -1/2])/
     12 + (5*Log[2]^3*PolyLog[2, -1/2])/6 - 2*Log[2]^2*Log[3]*
     PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/6 + (Log[2]*PolyLog[2, -1/2]^2)/2 + 
    3*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (3*Log[3]^2*PolyLog[3, -1/2])/2 + 4*Log[2]^2*PolyLog[3, 1/3] - 
    6*Log[2]*Log[3]*PolyLog[3, 1/3] + (5*Log[3]^2*PolyLog[3, 1/3])/2 + 
    4*Log[2]*PolyLog[4, -1/2] - Log[3]*PolyLog[4, -1/2] - 
    4*Log[2]*PolyLog[4, 1/3] + 3*Log[3]*PolyLog[4, 1/3] + 
    6*Log[2]*PolyLog[4, 1/2] + 8*Log[2]*PolyLog[4, 2/3] - 
    7*Log[3]*PolyLog[4, 2/3] + 4*PolyLog[5, -1/2] + 4*PolyLog[5, 1/3] + 
    4*PolyLog[5, 1/2] - 12*PolyLog[5, 2/3] - 4*PolyLog[2, 3, 1/3] + 
    (Pi^2*Zeta[3])/48 - (19*Log[2]^2*Zeta[3])/16 + 
    (17*Log[2]*Log[3]*Zeta[3])/8 - (17*Log[3]^2*Zeta[3])/16 - 
    (PolyLog[2, -1/2]*Zeta[3])/8 + (231*Zeta[5])/32
 
G[0, 1, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -5*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] - (8*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (595*Pi^4*Log[2])/2592 - (88*Pi^2*Log[2]^3)/81 - (719*Log[2]^5)/540 - 
    (17*Pi^4*Log[3])/72 + (41*Pi^2*Log[2]^2*Log[3])/12 + 
    (39*Log[2]^4*Log[3])/16 - (169*Pi^2*Log[2]*Log[3]^2)/48 + 
    (9*Log[2]^3*Log[3]^2)/4 + (173*Pi^2*Log[3]^3)/144 - 
    (211*Log[2]^2*Log[3]^3)/24 + (725*Log[2]*Log[3]^4)/96 - 
    (2039*Log[3]^5)/960 - Log[2]^3*PolyLog[2, -1/2] + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (5*Log[2]*PolyLog[2, -1/2]^2)/2 + 2*Log[3]*PolyLog[2, -1/2]^2 - 
    (Pi^2*PolyLog[3, -1/2])/6 + 4*Log[2]^2*PolyLog[3, -1/2] - 
    10*Log[2]*Log[3]*PolyLog[3, -1/2] + (11*Log[3]^2*PolyLog[3, -1/2])/2 - 
    4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/6 + 
    10*Log[2]^2*PolyLog[3, 1/3] - (41*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (83*Log[3]^2*PolyLog[3, 1/3])/8 - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    6*Log[2]*PolyLog[4, -1/2] + (3*Log[3]*PolyLog[4, -1/2])/2 + 
    (3*Log[2]*PolyLog[4, -1/3])/4 - (3*Log[3]*PolyLog[4, -1/3])/8 - 
    (21*Log[2]*PolyLog[4, 1/3])/2 + (43*Log[3]*PolyLog[4, 1/3])/4 - 
    10*Log[2]*PolyLog[4, 1/2] + 5*Log[3]*PolyLog[4, 1/2] + 
    32*Log[2]*PolyLog[4, 2/3] - (63*Log[3]*PolyLog[4, 2/3])/2 - 
    (20*PolyLog[5, -1/2])/3 - (7*PolyLog[5, -1/3])/8 + 14*PolyLog[5, 1/3] - 
    (218*PolyLog[5, 1/2])/9 - 53*PolyLog[5, 2/3] - 
    (3*PolyLog[2, 3, -1/3])/8 - 19*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/12 - 
    (123*Log[2]^2*Zeta[3])/16 + (53*Log[2]*Log[3]*Zeta[3])/4 - 
    (201*Log[3]^2*Zeta[3])/32 - (55*PolyLog[2, -1/2]*Zeta[3])/24 + 
    (31021*Zeta[5])/576
 
G[0, 1, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -3*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] - 2*G[0, 0, 1, 0, -1, 1/2] + 
    (247*Pi^4*Log[2])/1440 - (55*Pi^2*Log[2]^3)/72 - (23*Log[2]^5)/40 - 
    (Pi^4*Log[3])/6 + (7*Pi^2*Log[2]^2*Log[3])/3 + (3*Log[2]^4*Log[3])/4 - 
    (29*Pi^2*Log[2]*Log[3]^2)/12 + (11*Log[2]^3*Log[3]^2)/4 + 
    (5*Pi^2*Log[3]^3)/6 - (41*Log[2]^2*Log[3]^3)/6 + 
    (131*Log[2]*Log[3]^4)/24 - (91*Log[3]^5)/60 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 + (Log[2]^3*PolyLog[2, -1/2])/6 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 - Log[2]*PolyLog[2, -1/2]^2 + Log[3]*PolyLog[2, -1/2]^2 - 
    (Pi^2*PolyLog[3, -1/2])/12 + 4*Log[2]^2*PolyLog[3, -1/2] - 
    7*Log[2]*Log[3]*PolyLog[3, -1/2] + (7*Log[3]^2*PolyLog[3, -1/2])/2 - 
    3*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/12 + 
    (17*Log[2]^2*PolyLog[3, 1/3])/2 - 16*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    8*Log[3]^2*PolyLog[3, 1/3] - PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    10*Log[2]*PolyLog[4, 1/3] + 10*Log[3]*PolyLog[4, 1/3] - 
    3*Log[2]*PolyLog[4, 1/2] + 3*Log[3]*PolyLog[4, 1/2] + 
    22*Log[2]*PolyLog[4, 2/3] - 22*Log[3]*PolyLog[4, 2/3] - 
    3*PolyLog[5, -1/2] + 13*PolyLog[5, 1/3] - 16*PolyLog[5, 1/2] - 
    37*PolyLog[5, 2/3] - 15*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/96 - 
    (71*Log[2]^2*Zeta[3])/16 + (35*Log[2]*Log[3]*Zeta[3])/4 - 
    (35*Log[3]^2*Zeta[3])/8 - (7*PolyLog[2, -1/2]*Zeta[3])/4 + 
    (2339*Zeta[5])/64
 
G[0, 1, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 5*G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + (20*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (653*Pi^4*Log[2])/3240 + (655*Pi^2*Log[2]^3)/324 + (3607*Log[2]^5)/1080 + 
    (55*Pi^4*Log[3])/216 - (205*Pi^2*Log[2]^2*Log[3])/36 - 
    (295*Log[2]^4*Log[3])/72 + (55*Pi^2*Log[2]*Log[3]^2)/12 - 
    (25*Log[2]^3*Log[3]^2)/4 - (191*Pi^2*Log[3]^3)/144 + 
    (59*Log[2]^2*Log[3]^3)/4 - (77*Log[2]*Log[3]^4)/8 + (353*Log[3]^5)/160 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + (Log[2]^3*PolyLog[2, -1/2])/2 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/2 + 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 - 2*Log[3]*PolyLog[2, -1/2]^2 + 
    (Pi^2*PolyLog[3, -1/2])/6 - 4*Log[2]^2*PolyLog[3, -1/2] + 
    8*Log[2]*Log[3]*PolyLog[3, -1/2] - (9*Log[3]^2*PolyLog[3, -1/2])/2 + 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/6 - 
    23*Log[2]^2*PolyLog[3, 1/3] + 26*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (17*Log[3]^2*PolyLog[3, 1/3])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    41*Log[2]*PolyLog[4, -1/2] - 21*Log[3]*PolyLog[4, -1/2] - 
    10*Log[2]*PolyLog[4, -1/3] + 5*Log[3]*PolyLog[4, -1/3] + 
    18*Log[2]*PolyLog[4, 1/3] - 8*Log[3]*PolyLog[4, 1/3] + 
    (140*Log[2]*PolyLog[4, 1/2])/3 - (100*Log[3]*PolyLog[4, 1/2])/3 - 
    58*Log[2]*PolyLog[4, 2/3] + 38*Log[3]*PolyLog[4, 2/3] + 
    (149*PolyLog[5, -1/2])/3 + (71*PolyLog[5, -1/3])/4 - 
    (45*PolyLog[5, 1/3])/2 + (680*PolyLog[5, 1/2])/9 + 71*PolyLog[5, 2/3] + 
    5*PolyLog[2, 3, -1/3] + 8*PolyLog[2, 3, 1/3] - (41*Pi^2*Zeta[3])/48 + 
    (1529*Log[2]^2*Zeta[3])/48 - (769*Log[2]*Log[3]*Zeta[3])/24 + 
    (32*Log[3]^2*Zeta[3])/3 - (11*PolyLog[2, -1/2]*Zeta[3])/24 - 
    (7285*Zeta[5])/144
 
G[0, 1, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] - (Pi^4*Log[2])/18 + (7*Pi^2*Log[2]^3)/36 + 
    (23*Log[2]^5)/120 + (Pi^4*Log[3])/18 - (7*Pi^2*Log[2]^2*Log[3])/12 - 
    (7*Log[2]^4*Log[3])/24 + (7*Pi^2*Log[2]*Log[3]^2)/12 - 
    (7*Log[2]^3*Log[3]^2)/12 - (7*Pi^2*Log[3]^3)/36 + 
    (19*Log[2]^2*Log[3]^3)/12 - (29*Log[2]*Log[3]^4)/24 + (37*Log[3]^5)/120 + 
    (Log[2]^3*PolyLog[2, -1/2])/6 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]*PolyLog[2, -1/2]^2)/2 - Log[2]^2*PolyLog[3, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] - (Log[3]^2*PolyLog[3, -1/2])/2 + 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] - 2*Log[2]^2*PolyLog[3, 1/3] + 
    4*Log[2]*Log[3]*PolyLog[3, 1/3] - (3*Log[3]^2*PolyLog[3, 1/3])/2 - 
    Log[2]*PolyLog[4, -1/2] + Log[3]*PolyLog[4, -1/2] + 
    2*Log[2]*PolyLog[4, 1/3] - 2*Log[3]*PolyLog[4, 1/3] - 
    6*Log[2]*PolyLog[4, 2/3] + 6*Log[3]*PolyLog[4, 2/3] - 
    3*PolyLog[5, -1/2] - 3*PolyLog[5, 1/3] + 11*PolyLog[5, 2/3] + 
    4*PolyLog[2, 3, 1/3] + (Log[2]^2*Zeta[3])/2 - Log[2]*Log[3]*Zeta[3] + 
    (Log[3]^2*Zeta[3])/2 - 11*Zeta[5]
 
G[0, 1, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] - (Pi^4*Log[2])/10 + 
    (5*Pi^2*Log[2]^3)/12 + (53*Log[2]^5)/120 + (Pi^4*Log[3])/10 - 
    (5*Pi^2*Log[2]^2*Log[3])/4 - (13*Log[2]^4*Log[3])/12 + 
    (5*Pi^2*Log[2]*Log[3]^2)/4 - (Log[2]^3*Log[3]^2)/12 - 
    (5*Pi^2*Log[3]^3)/12 + (7*Log[2]^2*Log[3]^3)/3 - 
    (55*Log[2]*Log[3]^4)/24 + (41*Log[3]^5)/60 + (Log[2]^3*PolyLog[2, -1/2])/
     3 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*
     PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    Log[2]*PolyLog[2, -1/2]^2 - Log[3]*PolyLog[2, -1/2]^2 - 
    (5*Log[2]^2*PolyLog[3, -1/2])/2 + 5*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (5*Log[3]^2*PolyLog[3, -1/2])/2 + PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (5*Log[2]^2*PolyLog[3, 1/3])/2 + 5*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (5*Log[3]^2*PolyLog[3, 1/3])/2 + PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    12*Log[2]*PolyLog[4, 2/3] + 12*Log[3]*PolyLog[4, 2/3] + 
    21*PolyLog[5, 2/3] + 6*PolyLog[2, 3, 1/3] + (3*Log[2]^2*Zeta[3])/2 - 
    3*Log[2]*Log[3]*Zeta[3] + (3*Log[3]^2*Zeta[3])/2 - 21*Zeta[5]
 
G[0, 1, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] - (13*Pi^4*Log[2])/144 + (17*Pi^2*Log[2]^3)/72 + 
    (11*Log[2]^5)/30 + (7*Pi^4*Log[3])/90 - (11*Pi^2*Log[2]^2*Log[3])/12 - 
    (11*Log[2]^4*Log[3])/12 + (25*Pi^2*Log[2]*Log[3]^2)/24 + 
    (Log[2]^3*Log[3]^2)/6 - (7*Pi^2*Log[3]^3)/18 + (5*Log[2]^2*Log[3]^3)/3 - 
    (15*Log[2]*Log[3]^4)/8 + (37*Log[3]^5)/60 + (Log[2]^3*PolyLog[2, -1/2])/
     2 - (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - 
    (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    Log[2]*PolyLog[2, -1/2]^2 - Log[3]*PolyLog[2, -1/2]^2 + 
    (Pi^2*PolyLog[3, -1/2])/12 - Log[2]^2*PolyLog[3, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] - (3*Log[3]^2*PolyLog[3, -1/2])/2 + 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/12 - 
    (5*Log[2]^2*PolyLog[3, 1/3])/2 + 5*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    3*Log[3]^2*PolyLog[3, 1/3] + PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    3*Log[2]*PolyLog[4, 1/3] - 3*Log[3]*PolyLog[4, 1/3] + 
    2*Log[2]*PolyLog[4, 1/2] - Log[3]*PolyLog[4, 1/2] - 
    9*Log[2]*PolyLog[4, 2/3] + 10*Log[3]*PolyLog[4, 2/3] + PolyLog[5, -1/2] - 
    4*PolyLog[5, 1/3] + 6*PolyLog[5, 1/2] + 17*PolyLog[5, 2/3] + 
    7*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/12 + (23*Log[2]^2*Zeta[3])/16 - 
    (23*Log[2]*Log[3]*Zeta[3])/8 + (31*Log[3]^2*Zeta[3])/16 + 
    (7*PolyLog[2, -1/2]*Zeta[3])/8 - (543*Zeta[5])/32
 
G[0, 1, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + (Pi^4*Log[2])/15 - 
    (5*Pi^2*Log[2]^3)/18 - (7*Log[2]^5)/20 - (Pi^4*Log[3])/18 + 
    (11*Pi^2*Log[2]^2*Log[3])/12 + (11*Log[2]^4*Log[3])/12 - 
    Pi^2*Log[2]*Log[3]^2 + (13*Pi^2*Log[3]^3)/36 - 2*Log[2]^2*Log[3]^3 + 
    (25*Log[2]*Log[3]^4)/12 - (13*Log[3]^5)/20 - (Log[2]^3*PolyLog[2, -1/2])/
     2 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - Log[2]*PolyLog[2, -1/2]^2 + 
    Log[3]*PolyLog[2, -1/2]^2 + (3*Log[2]^2*PolyLog[3, -1/2])/2 - 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] + (5*Log[3]^2*PolyLog[3, -1/2])/2 - 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] + (3*Log[2]^2*PolyLog[3, 1/3])/2 - 
    4*Log[2]*Log[3]*PolyLog[3, 1/3] + (5*Log[3]^2*PolyLog[3, 1/3])/2 - 
    PolyLog[2, -1/2]*PolyLog[3, 1/3] + 8*Log[2]*PolyLog[4, 2/3] - 
    9*Log[3]*PolyLog[4, 2/3] - 14*PolyLog[5, 2/3] - 4*PolyLog[2, 3, 1/3] - 
    Log[2]^2*Zeta[3] + 3*Log[2]*Log[3]*Zeta[3] - 2*Log[3]^2*Zeta[3] + 
    14*Zeta[5]
 
G[0, 1, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2]^3)/18 + (Pi^2*Log[2]^2*Log[3])/6 - 
    (Log[2]^4*Log[3])/8 - (Pi^2*Log[2]*Log[3]^2)/6 + (Log[2]^3*Log[3]^2)/2 + 
    (Pi^2*Log[3]^3)/18 - (3*Log[2]^2*Log[3]^3)/4 + (Log[2]*Log[3]^4)/2 - 
    Log[3]^5/8 + (Log[2]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 - (Log[3]^3*PolyLog[2, -1/2])/6 + (Log[2]^2*PolyLog[3, -1/2])/2 - 
    Log[2]*Log[3]*PolyLog[3, -1/2] + (Log[3]^2*PolyLog[3, -1/2])/2 + 
    (Log[2]^2*PolyLog[3, 1/3])/2 - Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (Log[3]^2*PolyLog[3, 1/3])/2 + Log[2]*PolyLog[4, 2/3] - 
    Log[3]*PolyLog[4, 2/3] - PolyLog[5, 2/3] - (Log[2]^2*Zeta[3])/2 + 
    Log[2]*Log[3]*Zeta[3] - (Log[3]^2*Zeta[3])/2 + Zeta[5]
 
G[1, -1, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2]^3)/9 + Log[2]^5/3 + 
    (Pi^2*Log[2]^2*Log[3])/3 - (4*Log[2]^4*Log[3])/3 - 
    (Pi^2*Log[2]*Log[3]^2)/4 + (25*Log[2]^3*Log[3]^2)/12 + 
    (Pi^2*Log[3]^3)/18 - (7*Log[2]^2*Log[3]^3)/4 + (3*Log[2]*Log[3]^4)/4 - 
    Log[3]^5/8 + (4*Log[2]^3*PolyLog[2, -1/2])/3 - 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/6 + 2*Log[2]^2*PolyLog[3, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] + (Log[3]^2*PolyLog[3, -1/2])/2 + 
    2*Log[2]^2*PolyLog[3, 1/3] - 2*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (Log[3]^2*PolyLog[3, 1/3])/2 + 2*Log[2]*PolyLog[4, 2/3] - 
    Log[3]*PolyLog[4, 2/3] + PolyLog[5, 1/2] - PolyLog[5, 2/3] - 
    2*Log[2]^2*Zeta[3] + 2*Log[2]*Log[3]*Zeta[3] - (Log[3]^2*Zeta[3])/2
 
G[1, -1, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] - (8*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (829*Pi^4*Log[2])/6480 - (70*Pi^2*Log[2]^3)/81 - (749*Log[2]^5)/540 - 
    (31*Pi^4*Log[3])/270 + (89*Pi^2*Log[2]^2*Log[3])/36 + 
    (47*Log[2]^4*Log[3])/18 - (7*Pi^2*Log[2]*Log[3]^2)/3 + 
    (13*Log[2]^3*Log[3]^2)/12 + (7*Pi^2*Log[3]^3)/9 - 
    (67*Log[2]^2*Log[3]^3)/12 + (55*Log[2]*Log[3]^4)/12 - (5*Log[3]^5)/4 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/3 - (4*Log[2]^3*PolyLog[2, -1/2])/3 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    2*Log[2]*PolyLog[2, -1/2]^2 + 2*Log[3]*PolyLog[2, -1/2]^2 - 
    (Pi^2*PolyLog[3, -1/2])/6 + 3*Log[2]^2*PolyLog[3, -1/2] - 
    8*Log[2]*Log[3]*PolyLog[3, -1/2] + (9*Log[3]^2*PolyLog[3, -1/2])/2 - 
    (Pi^2*PolyLog[3, 1/3])/6 + 6*Log[2]^2*PolyLog[3, 1/3] - 
    10*Log[2]*Log[3]*PolyLog[3, 1/3] + (9*Log[3]^2*PolyLog[3, 1/3])/2 - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 12*Log[2]*PolyLog[4, -1/2] + 
    8*Log[3]*PolyLog[4, -1/2] + 2*Log[2]*PolyLog[4, -1/3] - 
    Log[3]*PolyLog[4, -1/3] - 2*Log[2]*PolyLog[4, 1/3] - 
    (37*Log[2]*PolyLog[4, 1/2])/3 + (32*Log[3]*PolyLog[4, 1/2])/3 + 
    22*Log[2]*PolyLog[4, 2/3] - 19*Log[3]*PolyLog[4, 2/3] - 
    (62*PolyLog[5, -1/2])/3 - 5*PolyLog[5, -1/3] + 4*PolyLog[5, 1/3] - 
    (209*PolyLog[5, 1/2])/9 - 33*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3] - 
    6*PolyLog[2, 3, 1/3] + (5*Pi^2*Zeta[3])/12 - (22*Log[2]^2*Zeta[3])/3 + 
    (31*Log[2]*Log[3]*Zeta[3])/3 - (61*Log[3]^2*Zeta[3])/12 + 
    (4*PolyLog[2, -1/2]*Zeta[3])/3 + (6695*Zeta[5])/288
 
G[1, -1, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    (Pi^4*Log[2])/15 - (7*Pi^2*Log[2]^3)/18 + Log[2]^5/60 - 
    (2*Pi^4*Log[3])/45 + (29*Pi^2*Log[2]^2*Log[3])/24 - (Log[2]^4*Log[3])/3 - 
    (7*Pi^2*Log[2]*Log[3]^2)/6 + (19*Log[2]^3*Log[3]^2)/12 + 
    (7*Pi^2*Log[3]^3)/18 - 3*Log[2]^2*Log[3]^3 + (7*Log[2]*Log[3]^4)/3 - 
    (13*Log[3]^5)/20 - (Pi^2*Log[2]*PolyLog[2, -1/2])/12 + 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - Log[2]*PolyLog[2, -1/2]^2 + 
    Log[3]*PolyLog[2, -1/2]^2 - (Pi^2*PolyLog[3, -1/2])/12 + 
    3*Log[2]^2*PolyLog[3, -1/2] - 5*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (5*Log[3]^2*PolyLog[3, -1/2])/2 - PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/12 + 3*Log[2]^2*PolyLog[3, 1/3] - 
    5*Log[2]*Log[3]*PolyLog[3, 1/3] + (5*Log[3]^2*PolyLog[3, 1/3])/2 - 
    PolyLog[2, -1/2]*PolyLog[3, 1/3] + Log[2]*PolyLog[4, 1/2] - 
    Log[3]*PolyLog[4, 1/2] + 9*Log[2]*PolyLog[4, 2/3] - 
    9*Log[3]*PolyLog[4, 2/3] + 2*PolyLog[5, 1/2] - 14*PolyLog[5, 2/3] - 
    4*PolyLog[2, 3, 1/3] + (5*Pi^2*Zeta[3])/32 - (17*Log[2]^2*Zeta[3])/8 + 
    (13*Log[2]*Log[3]*Zeta[3])/4 - (33*Log[3]^2*Zeta[3])/16 - 
    (PolyLog[2, -1/2]*Zeta[3])/8 + (325*Zeta[5])/32
 
G[1, -1, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (25*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (635*Pi^4*Log[2])/2592 + (140*Pi^2*Log[2]^3)/81 + (2783*Log[2]^5)/1080 + 
    (1039*Pi^4*Log[3])/4320 - (319*Pi^2*Log[2]^2*Log[3])/72 - 
    (613*Log[2]^4*Log[3])/144 + (59*Pi^2*Log[2]*Log[3]^2)/16 - 
    (35*Log[2]^3*Log[3]^2)/12 - (83*Pi^2*Log[3]^3)/72 + 
    (247*Log[2]^2*Log[3]^3)/24 - (725*Log[2]*Log[3]^4)/96 + 
    (611*Log[3]^5)/320 + (Pi^2*Log[2]*PolyLog[2, -1/2])/3 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/2 + Log[2]*PolyLog[2, -1/2]^2 - 
    2*Log[3]*PolyLog[2, -1/2]^2 + (Pi^2*PolyLog[3, -1/2])/6 - 
    5*Log[2]^2*PolyLog[3, -1/2] + 10*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (11*Log[3]^2*PolyLog[3, -1/2])/2 - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/6 - (27*Log[2]^2*PolyLog[3, 1/3])/2 + 
    (35*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (55*Log[3]^2*PolyLog[3, 1/3])/8 + 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 33*Log[2]*PolyLog[4, -1/2] - 
    (43*Log[3]*PolyLog[4, -1/2])/2 - (35*Log[2]*PolyLog[4, -1/3])/4 + 
    (35*Log[3]*PolyLog[4, -1/3])/8 + (23*Log[2]*PolyLog[4, 1/3])/2 - 
    (19*Log[3]*PolyLog[4, 1/3])/4 + (106*Log[2]*PolyLog[4, 1/2])/3 - 
    (86*Log[3]*PolyLog[4, 1/2])/3 - 47*Log[2]*PolyLog[4, 2/3] + 
    (69*Log[3]*PolyLog[4, 2/3])/2 + (157*PolyLog[5, -1/2])/3 + 
    (121*PolyLog[5, -1/3])/8 - (31*PolyLog[5, 1/3])/2 + 
    (616*PolyLog[5, 1/2])/9 + 66*PolyLog[5, 2/3] + 
    (19*PolyLog[2, 3, -1/3])/8 + 10*PolyLog[2, 3, 1/3] - 
    (21*Pi^2*Zeta[3])/32 + (47*Log[2]^2*Zeta[3])/3 - 
    (391*Log[2]*Log[3]*Zeta[3])/24 + (679*Log[3]^2*Zeta[3])/96 - 
    (8*PolyLog[2, -1/2]*Zeta[3])/3 - (27491*Zeta[5])/576
 
G[1, -1, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + (5*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (979*Pi^4*Log[2])/6480 + (443*Pi^2*Log[2]^3)/648 + (611*Log[2]^5)/540 + 
    (491*Pi^4*Log[3])/4320 - (161*Pi^2*Log[2]^2*Log[3])/72 - 
    (161*Log[2]^4*Log[3])/144 + (89*Pi^2*Log[2]*Log[3]^2)/48 - 
    (35*Log[2]^3*Log[3]^2)/12 - (37*Pi^2*Log[3]^3)/72 + 
    (151*Log[2]^2*Log[3]^3)/24 - (401*Log[2]*Log[3]^4)/96 + 
    (901*Log[3]^5)/960 + (Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Log[3]^3*PolyLog[2, -1/2])/6 + Log[2]*PolyLog[2, -1/2]^2 - 
    2*Log[2]^2*PolyLog[3, -1/2] + 4*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (3*Log[3]^2*PolyLog[3, -1/2])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (19*Log[2]^2*PolyLog[3, 1/3])/2 + (23*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (27*Log[3]^2*PolyLog[3, 1/3])/8 + 9*Log[2]*PolyLog[4, -1/2] - 
    (7*Log[3]*PolyLog[4, -1/2])/2 - (15*Log[2]*PolyLog[4, -1/3])/4 + 
    (31*Log[3]*PolyLog[4, -1/3])/8 + (15*Log[2]*PolyLog[4, 1/3])/2 - 
    (23*Log[3]*PolyLog[4, 1/3])/4 + 13*Log[2]*PolyLog[4, 1/2] - 
    (22*Log[3]*PolyLog[4, 1/2])/3 - 23*Log[2]*PolyLog[4, 2/3] + 
    (37*Log[3]*PolyLog[4, 2/3])/2 + (23*PolyLog[5, -1/2])/3 + 
    (69*PolyLog[5, -1/3])/8 - (23*PolyLog[5, 1/3])/2 + 
    (164*PolyLog[5, 1/2])/9 + 34*PolyLog[5, 2/3] + 
    (15*PolyLog[2, 3, -1/3])/8 + 4*PolyLog[2, 3, 1/3] - 
    (19*Pi^2*Zeta[3])/48 + (175*Log[2]^2*Zeta[3])/16 - 
    (81*Log[2]*Log[3]*Zeta[3])/8 + (113*Log[3]^2*Zeta[3])/32 + 
    (13*PolyLog[2, -1/2]*Zeta[3])/6 - (2965*Zeta[5])/144
 
G[1, -1, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + (29*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (1591*Pi^4*Log[2])/6480 + (595*Pi^2*Log[2]^3)/324 + (743*Log[2]^5)/216 + 
    (599*Pi^4*Log[3])/2160 - (367*Pi^2*Log[2]^2*Log[3])/72 - 
    (293*Log[2]^4*Log[3])/72 + (49*Pi^2*Log[2]*Log[3]^2)/12 - 
    (27*Log[2]^3*Log[3]^2)/4 - (167*Pi^2*Log[3]^3)/144 + 
    15*Log[2]^2*Log[3]^3 - (227*Log[2]*Log[3]^4)/24 + (333*Log[3]^5)/160 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    Log[2]*PolyLog[2, -1/2]^2 - Log[3]*PolyLog[2, -1/2]^2 - 
    (7*Log[2]^2*PolyLog[3, -1/2])/2 + 7*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (7*Log[3]^2*PolyLog[3, -1/2])/2 - 23*Log[2]^2*PolyLog[3, 1/3] + 
    26*Log[2]*Log[3]*PolyLog[3, 1/3] - 8*Log[3]^2*PolyLog[3, 1/3] + 
    PolyLog[2, -1/2]*PolyLog[3, 1/3] + 44*Log[2]*PolyLog[4, -1/2] - 
    24*Log[3]*PolyLog[4, -1/2] - 12*Log[2]*PolyLog[4, -1/3] + 
    7*Log[3]*PolyLog[4, -1/3] + 21*Log[2]*PolyLog[4, 1/3] - 
    11*Log[3]*PolyLog[4, 1/3] + 53*Log[2]*PolyLog[4, 1/2] - 
    (119*Log[3]*PolyLog[4, 1/2])/3 - 58*Log[2]*PolyLog[4, 2/3] + 
    38*Log[3]*PolyLog[4, 2/3] + (173*PolyLog[5, -1/2])/3 + 
    (87*PolyLog[5, -1/3])/4 - (55*PolyLog[5, 1/3])/2 + 
    (803*PolyLog[5, 1/2])/9 + 73*PolyLog[5, 2/3] + 5*PolyLog[2, 3, -1/3] + 
    7*PolyLog[2, 3, 1/3] - (25*Pi^2*Zeta[3])/32 + (1499*Log[2]^2*Zeta[3])/
     48 - (739*Log[2]*Log[3]*Zeta[3])/24 + (29*Log[3]^2*Zeta[3])/3 - 
    (11*PolyLog[2, -1/2]*Zeta[3])/24 - (29113*Zeta[5])/576
 
G[1, -1, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] - 
    (149*Pi^4*Log[2])/1440 + (Pi^2*Log[2]^3)/2 + (19*Log[2]^5)/40 + 
    (Pi^4*Log[3])/15 - (11*Pi^2*Log[2]^2*Log[3])/8 - (3*Log[2]^4*Log[3])/2 + 
    (31*Pi^2*Log[2]*Log[3]^2)/24 + (3*Log[2]^3*Log[3]^2)/4 - 
    (4*Pi^2*Log[3]^3)/9 + (5*Log[2]^2*Log[3]^3)/3 - (25*Log[2]*Log[3]^4)/12 + 
    (41*Log[3]^5)/60 + (Log[2]^3*PolyLog[2, -1/2])/2 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 + (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/
     3 + (Log[2]*PolyLog[2, -1/2]^2)/2 - Log[3]*PolyLog[2, -1/2]^2 + 
    (Pi^2*PolyLog[3, -1/2])/12 - 2*Log[2]^2*PolyLog[3, -1/2] + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - (5*Log[3]^2*PolyLog[3, -1/2])/2 + 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/12 - 
    2*Log[2]^2*PolyLog[3, 1/3] + 4*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (5*Log[3]^2*PolyLog[3, 1/3])/2 + PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    3*Log[2]*PolyLog[4, 1/2] + 3*Log[3]*PolyLog[4, 1/2] - 
    12*Log[2]*PolyLog[4, 2/3] + 12*Log[3]*PolyLog[4, 2/3] - 
    3*PolyLog[5, 1/2] + 21*PolyLog[5, 2/3] + 6*PolyLog[2, 3, 1/3] - 
    (11*Pi^2*Zeta[3])/48 + (Log[2]^2*Zeta[3])/4 - (Log[2]*Log[3]*Zeta[3])/2 + 
    (13*Log[3]^2*Zeta[3])/8 + (PolyLog[2, -1/2]*Zeta[3])/4 - (975*Zeta[5])/64
 
G[1, -1, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] - 
    3*G[0, 0, -1, 0, -1, 1/2] - 6*G[0, 0, 1, 0, -1, 1/2] + 
    (37*Pi^4*Log[2])/1080 - (11*Pi^2*Log[2]^3)/12 - (817*Log[2]^5)/360 - 
    (41*Pi^4*Log[3])/432 + (91*Pi^2*Log[2]^2*Log[3])/36 + 
    (187*Log[2]^4*Log[3])/72 - (11*Pi^2*Log[2]*Log[3]^2)/6 + 
    (23*Log[2]^3*Log[3]^2)/6 + (17*Pi^2*Log[3]^3)/36 - 
    (47*Log[2]^2*Log[3]^3)/6 + (53*Log[2]*Log[3]^4)/12 - (69*Log[3]^5)/80 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - (2*Log[2]^3*PolyLog[2, -1/2])/3 + 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] - (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + Log[3]*PolyLog[2, -1/2]^2 + 
    (Log[2]^2*PolyLog[3, -1/2])/2 - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (3*Log[3]^2*PolyLog[3, -1/2])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (25*Log[2]^2*PolyLog[3, 1/3])/2 - 12*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    3*Log[3]^2*PolyLog[3, 1/3] - PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    33*Log[2]*PolyLog[4, -1/2] + 19*Log[3]*PolyLog[4, -1/2] + 
    7*Log[2]*PolyLog[4, -1/3] - (7*Log[3]*PolyLog[4, -1/3])/2 - 
    10*Log[2]*PolyLog[4, 1/3] + 3*Log[3]*PolyLog[4, 1/3] - 
    (116*Log[2]*PolyLog[4, 1/2])/3 + (88*Log[3]*PolyLog[4, 1/2])/3 + 
    28*Log[2]*PolyLog[4, 2/3] - 14*Log[3]*PolyLog[4, 2/3] - 
    47*PolyLog[5, -1/2] - (27*PolyLog[5, -1/3])/2 + 13*PolyLog[5, 1/3] - 
    64*PolyLog[5, 1/2] - 28*PolyLog[5, 2/3] - (7*PolyLog[2, 3, -1/3])/2 + 
    2*PolyLog[2, 3, 1/3] + (43*Pi^2*Zeta[3])/96 - (1019*Log[2]^2*Zeta[3])/
     48 + (245*Log[2]*Log[3]*Zeta[3])/12 - (17*Log[3]^2*Zeta[3])/3 + 
    (11*PolyLog[2, -1/2]*Zeta[3])/4 + (3323*Zeta[5])/192
 
G[1, -1, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] - (17*Pi^4*Log[2])/288 + (Pi^2*Log[2]^3)/6 + 
    (13*Log[2]^5)/40 + (13*Pi^4*Log[3])/240 - (Pi^2*Log[2]^2*Log[3])/2 - 
    (5*Log[2]^4*Log[3])/6 + (13*Pi^2*Log[2]*Log[3]^2)/24 + 
    (Log[2]^3*Log[3]^2)/4 - (7*Pi^2*Log[3]^3)/36 + 
    (11*Log[2]^2*Log[3]^3)/12 - Log[2]*Log[3]^4 + (37*Log[3]^5)/120 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 + (Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 - (Log[3]^3*PolyLog[2, -1/2])/6 - (Log[2]^2*PolyLog[3, -1/2])/2 + 
    Log[2]*Log[3]*PolyLog[3, -1/2] - (Log[3]^2*PolyLog[3, -1/2])/2 + 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] - (3*Log[2]^2*PolyLog[3, 1/3])/2 + 
    3*Log[2]*Log[3]*PolyLog[3, 1/3] - (3*Log[3]^2*PolyLog[3, 1/3])/2 - 
    Log[2]*PolyLog[4, -1/2] + Log[3]*PolyLog[4, -1/2] + 
    2*Log[2]*PolyLog[4, 1/3] - 2*Log[3]*PolyLog[4, 1/3] - 
    6*Log[2]*PolyLog[4, 2/3] + 6*Log[3]*PolyLog[4, 2/3] - 
    3*PolyLog[5, -1/2] - 3*PolyLog[5, 1/3] + 11*PolyLog[5, 2/3] + 
    4*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/96 + (7*Log[2]^2*Zeta[3])/8 - 
    (7*Log[2]*Log[3]*Zeta[3])/4 + (15*Log[3]^2*Zeta[3])/16 + 
    (7*PolyLog[2, -1/2]*Zeta[3])/8 - (675*Zeta[5])/64
 
G[1, -1, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] - (20*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1027*Pi^4*Log[2])/6480 - (629*Pi^2*Log[2]^3)/648 - (487*Log[2]^5)/1080 - 
    (59*Pi^4*Log[3])/480 + (41*Pi^2*Log[2]^2*Log[3])/24 + 
    (35*Log[2]^4*Log[3])/48 - (21*Pi^2*Log[2]*Log[3]^2)/16 + 
    (11*Log[2]^3*Log[3]^2)/4 + (5*Pi^2*Log[3]^3)/12 - 
    (131*Log[2]^2*Log[3]^3)/24 + (347*Log[2]*Log[3]^4)/96 - 
    (169*Log[3]^5)/192 + Log[2]^3*PolyLog[2, -1/2] - 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/6 + Log[2]*PolyLog[2, -1/2]^2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 6*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (5*Log[3]^2*PolyLog[3, -1/2])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    5*Log[2]^2*PolyLog[3, 1/3] - (17*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (31*Log[3]^2*PolyLog[3, 1/3])/8 - 6*Log[2]*PolyLog[4, -1/2] + 
    (15*Log[3]*PolyLog[4, -1/2])/2 + (21*Log[2]*PolyLog[4, -1/3])/4 - 
    (21*Log[3]*PolyLog[4, -1/3])/8 - (19*Log[2]*PolyLog[4, 1/3])/2 + 
    (25*Log[3]*PolyLog[4, 1/3])/4 - 3*Log[2]*PolyLog[4, 1/2] + 
    10*Log[3]*PolyLog[4, 1/2] + 20*Log[2]*PolyLog[4, 2/3] - 
    (31*Log[3]*PolyLog[4, 2/3])/2 - (38*PolyLog[5, -1/2])/3 - 
    (51*PolyLog[5, -1/3])/8 + 10*PolyLog[5, 1/3] - (170*PolyLog[5, 1/2])/9 - 
    30*PolyLog[5, 2/3] + (9*PolyLog[2, 3, -1/3])/8 - 7*PolyLog[2, 3, 1/3] + 
    (Pi^2*Zeta[3])/24 + (Log[2]^2*Zeta[3])/6 + (5*Log[2]*Log[3]*Zeta[3])/24 - 
    (101*Log[3]^2*Zeta[3])/96 + (4*PolyLog[2, -1/2]*Zeta[3])/3 + 
    (2899*Zeta[5])/144
 
G[1, -1, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -10*G[0, -1, 0, -1, -1, 1/2] + 
    8*G[0, 0, -1, 0, -1, 1/2] - (2*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (7307*Pi^4*Log[2])/12960 - (133*Pi^2*Log[2]^3)/81 - (887*Log[2]^5)/540 - 
    (373*Pi^4*Log[3])/864 + (419*Pi^2*Log[2]^2*Log[3])/72 + 
    (551*Log[2]^4*Log[3])/144 - (311*Pi^2*Log[2]*Log[3]^2)/48 + 
    (29*Log[2]^3*Log[3]^2)/12 + (41*Pi^2*Log[3]^3)/18 - 
    (341*Log[2]^2*Log[3]^3)/24 + (1303*Log[2]*Log[3]^4)/96 - 
    (3851*Log[3]^5)/960 - (5*Log[2]^3*PolyLog[2, -1/2])/3 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 4*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    3*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (5*Log[3]^3*PolyLog[2, -1/2])/6 - 
    5*Log[2]*PolyLog[2, -1/2]^2 + 4*Log[3]*PolyLog[2, -1/2]^2 - 
    (Pi^2*PolyLog[3, -1/2])/6 + 9*Log[2]^2*PolyLog[3, -1/2] - 
    20*Log[2]*Log[3]*PolyLog[3, -1/2] + (21*Log[3]^2*PolyLog[3, -1/2])/2 - 
    10*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/2 + 
    14*Log[2]^2*PolyLog[3, 1/3] - (67*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (145*Log[3]^2*PolyLog[3, 1/3])/8 - 6*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    10*Log[2]*PolyLog[4, -1/2] - (15*Log[3]*PolyLog[4, -1/2])/2 + 
    (Log[2]*PolyLog[4, -1/3])/4 - (31*Log[3]*PolyLog[4, -1/3])/8 - 
    (27*Log[2]*PolyLog[4, 1/3])/2 + (75*Log[3]*PolyLog[4, 1/3])/4 + 
    (4*Log[2]*PolyLog[4, 1/2])/3 - (14*Log[3]*PolyLog[4, 1/2])/3 + 
    54*Log[2]*PolyLog[4, 2/3] - (125*Log[3]*PolyLog[4, 2/3])/2 + 
    (64*PolyLog[5, -1/2])/3 - (49*PolyLog[5, -1/3])/8 + 23*PolyLog[5, 1/3] - 
    (2*PolyLog[5, 1/2])/9 - 104*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3]/8 - 
    33*PolyLog[2, 3, 1/3] + (53*Pi^2*Zeta[3])/72 - (21*Log[2]^2*Zeta[3])/4 + 
    (397*Log[2]*Log[3]*Zeta[3])/24 - (349*Log[3]^2*Zeta[3])/32 - 
    (13*PolyLog[2, -1/2]*Zeta[3])/3 + (25565*Zeta[5])/288
 
G[1, -1, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -6*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] - (22*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (2543*Pi^4*Log[2])/6480 - (695*Pi^2*Log[2]^3)/324 - (1429*Log[2]^5)/540 - 
    (251*Pi^4*Log[3])/720 + (37*Pi^2*Log[2]^2*Log[3])/6 + 
    (37*Log[2]^4*Log[3])/12 - (263*Pi^2*Log[2]*Log[3]^2)/48 + 
    (23*Log[2]^3*Log[3]^2)/3 + (245*Pi^2*Log[3]^3)/144 - 
    (53*Log[2]^2*Log[3]^3)/3 + (1201*Log[2]*Log[3]^4)/96 - 
    (299*Log[3]^5)/96 + (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - 
    (Log[2]^3*PolyLog[2, -1/2])/6 + (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/3 - 2*Log[2]*PolyLog[2, -1/2]^2 + 
    2*Log[3]*PolyLog[2, -1/2]^2 - (Pi^2*PolyLog[3, -1/2])/12 + 
    7*Log[2]^2*PolyLog[3, -1/2] - 13*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (13*Log[3]^2*PolyLog[3, -1/2])/2 - 5*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/4 + 24*Log[2]^2*PolyLog[3, 1/3] - 
    33*Log[2]*Log[3]*PolyLog[3, 1/3] + (27*Log[3]^2*PolyLog[3, 1/3])/2 - 
    3*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 21*Log[2]*PolyLog[4, -1/2] + 
    9*Log[3]*PolyLog[4, -1/2] + (39*Log[2]*PolyLog[4, -1/3])/4 - 
    (27*Log[3]*PolyLog[4, -1/3])/4 - (47*Log[2]*PolyLog[4, 1/3])/2 + 
    (35*Log[3]*PolyLog[4, 1/3])/2 - 27*Log[2]*PolyLog[4, 1/2] + 
    19*Log[3]*PolyLog[4, 1/2] + 63*Log[2]*PolyLog[4, 2/3] - 
    51*Log[3]*PolyLog[4, 2/3] - (64*PolyLog[5, -1/2])/3 - 
    (33*PolyLog[5, -1/3])/2 + 29*PolyLog[5, 1/3] - (454*PolyLog[5, 1/2])/9 - 
    90*PolyLog[5, 2/3] - 3*PolyLog[2, 3, -1/3] - 18*PolyLog[2, 3, 1/3] + 
    (247*Pi^2*Zeta[3])/288 - (583*Log[2]^2*Zeta[3])/24 + 
    (631*Log[2]*Log[3]*Zeta[3])/24 - (499*Log[3]^2*Zeta[3])/48 - 
    (55*PolyLog[2, -1/2]*Zeta[3])/24 + (2393*Zeta[5])/36
 
G[1, -1, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 8*G[0, -1, 0, -1, -1, 1/2] - 
    6*G[0, 0, -1, 0, -1, 1/2] - 4*G[0, 0, 1, 0, -1, 1/2] - 
    (17*Pi^4*Log[2])/48 + (11*Pi^2*Log[2]^3)/18 - (7*Log[2]^5)/30 + 
    (5*Pi^4*Log[3])/16 - (29*Pi^2*Log[2]^2*Log[3])/12 - 
    (15*Log[2]^4*Log[3])/8 + (7*Pi^2*Log[2]*Log[3]^2)/2 + 
    (29*Log[2]^3*Log[3]^2)/12 - (103*Pi^2*Log[3]^3)/72 + 
    (10*Log[2]^2*Log[3]^3)/3 - (149*Log[2]*Log[3]^4)/24 + 
    (377*Log[3]^5)/160 + (4*Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 4*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    4*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (7*Log[3]^3*PolyLog[2, -1/2])/6 + 
    4*Log[2]*PolyLog[2, -1/2]^2 - 4*Log[3]*PolyLog[2, -1/2]^2 + 
    (Pi^2*PolyLog[3, -1/2])/6 - 7*Log[2]^2*PolyLog[3, -1/2] + 
    14*Log[2]*Log[3]*PolyLog[3, -1/2] - (15*Log[3]^2*PolyLog[3, -1/2])/2 + 
    8*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/2 + 
    (Log[2]^2*PolyLog[3, 1/3])/2 + 14*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (49*Log[3]^2*PolyLog[3, 1/3])/4 + 6*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    31*Log[2]*PolyLog[4, -1/2] + 15*Log[3]*PolyLog[4, -1/2] + 
    5*Log[2]*PolyLog[4, -1/3] - (5*Log[3]*PolyLog[4, -1/3])/2 + 
    Log[2]*PolyLog[4, 1/3] - 10*Log[3]*PolyLog[4, 1/3] - 
    28*Log[2]*PolyLog[4, 1/2] + 20*Log[3]*PolyLog[4, 1/2] - 
    19*Log[2]*PolyLog[4, 2/3] + 35*Log[3]*PolyLog[4, 2/3] - 
    47*PolyLog[5, -1/2] - 10*PolyLog[5, -1/3] - (5*PolyLog[5, 1/3])/2 - 
    42*PolyLog[5, 1/2] + 55*PolyLog[5, 2/3] - (15*PolyLog[2, 3, -1/3])/4 + 
    35*PolyLog[2, 3, 1/3] + (11*Pi^2*Zeta[3])/36 - 
    (325*Log[2]^2*Zeta[3])/24 + (10*Log[2]*Log[3]*Zeta[3])/3 + 
    (19*Log[3]^2*Zeta[3])/6 + (13*PolyLog[2, -1/2]*Zeta[3])/6 - 
    (4481*Zeta[5])/64
 
G[1, -1, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, 0, 1, 0, -1, 1/2] + 
    (37*Pi^4*Log[2])/2160 - (37*Pi^2*Log[2]^3)/108 - (137*Log[2]^5)/180 - 
    (Pi^4*Log[3])/40 + (13*Pi^2*Log[2]^2*Log[3])/12 + 
    (7*Log[2]^4*Log[3])/12 - (3*Pi^2*Log[2]*Log[3]^2)/4 + 
    (7*Log[2]^3*Log[3]^2)/4 + (17*Pi^2*Log[3]^3)/72 - 
    (13*Log[2]^2*Log[3]^3)/4 + (47*Log[2]*Log[3]^4)/24 - (23*Log[3]^5)/48 - 
    (Log[3]^3*PolyLog[2, -1/2])/6 + (Log[3]^2*PolyLog[3, -1/2])/2 + 
    (11*Log[2]^2*PolyLog[3, 1/3])/2 - 5*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (5*Log[3]^2*PolyLog[3, 1/3])/2 - 11*Log[2]*PolyLog[4, -1/2] + 
    6*Log[3]*PolyLog[4, -1/2] + 3*Log[2]*PolyLog[4, -1/3] - 
    (Log[3]*PolyLog[4, -1/3])/4 - 5*Log[2]*PolyLog[4, 1/3] + 
    (7*Log[3]*PolyLog[4, 1/3])/2 - 14*Log[2]*PolyLog[4, 1/2] + 
    8*Log[3]*PolyLog[4, 1/2] + 11*Log[2]*PolyLog[4, 2/3] - 
    6*Log[3]*PolyLog[4, 2/3] - 13*PolyLog[5, -1/2] - (9*PolyLog[5, -1/3])/4 + 
    (13*PolyLog[5, 1/3])/2 - (68*PolyLog[5, 1/2])/3 - 11*PolyLog[5, 2/3] - 
    (3*PolyLog[2, 3, -1/3])/2 + PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/4 - 
    (67*Log[2]^2*Zeta[3])/8 + (13*Log[2]*Log[3]*Zeta[3])/2 - 
    (115*Log[3]^2*Zeta[3])/48 + (817*Zeta[5])/96
 
G[1, -1, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] - 
    3*G[0, 0, -1, 0, -1, 1/2] - G[0, 0, 1, 0, -1, 1/2]/3 - 
    (511*Pi^4*Log[2])/2592 + (377*Pi^2*Log[2]^3)/648 + (251*Log[2]^5)/540 + 
    (823*Pi^4*Log[3])/4320 - (133*Pi^2*Log[2]^2*Log[3])/72 - 
    (211*Log[2]^4*Log[3])/144 + (17*Pi^2*Log[2]*Log[3]^2)/8 - 
    (Log[2]^3*Log[3]^2)/4 - (3*Pi^2*Log[3]^3)/4 + (33*Log[2]^2*Log[3]^3)/8 - 
    (69*Log[2]*Log[3]^4)/16 + (1283*Log[3]^5)/960 + 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 - 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - (2*Log[3]^3*PolyLog[2, -1/2])/3 + 
    2*Log[2]*PolyLog[2, -1/2]^2 - 2*Log[3]*PolyLog[2, -1/2]^2 - 
    (7*Log[2]^2*PolyLog[3, -1/2])/2 + 7*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (7*Log[3]^2*PolyLog[3, -1/2])/2 + 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    4*Log[2]^2*PolyLog[3, 1/3] + (23*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (53*Log[3]^2*PolyLog[3, 1/3])/8 + 3*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    7*Log[2]*PolyLog[4, -1/2] + (7*Log[3]*PolyLog[4, -1/2])/2 + 
    (Log[2]*PolyLog[4, -1/3])/2 + (3*Log[3]*PolyLog[4, -1/3])/8 + 
    5*Log[2]*PolyLog[4, 1/3] - (27*Log[3]*PolyLog[4, 1/3])/4 - 
    (11*Log[2]*PolyLog[4, 1/2])/3 + (4*Log[3]*PolyLog[4, 1/2])/3 - 
    18*Log[2]*PolyLog[4, 2/3] + (43*Log[3]*PolyLog[4, 2/3])/2 - 
    (40*PolyLog[5, -1/2])/3 - (3*PolyLog[5, -1/3])/8 - 6*PolyLog[5, 1/3] - 
    (46*PolyLog[5, 1/2])/9 + 36*PolyLog[5, 2/3] - (7*PolyLog[2, 3, -1/3])/8 + 
    18*PolyLog[2, 3, 1/3] + (5*Pi^2*Zeta[3])/24 - (17*Log[2]^2*Zeta[3])/16 - 
    (41*Log[2]*Log[3]*Zeta[3])/12 + (73*Log[3]^2*Zeta[3])/32 - 
    (5827*Zeta[5])/144
 
G[1, -1, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] - 
    5*G[0, 0, -1, 0, -1, 1/2] - (25*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (1163*Pi^4*Log[2])/12960 - (139*Pi^2*Log[2]^3)/648 - (541*Log[2]^5)/540 + 
    (53*Pi^4*Log[3])/4320 - (23*Pi^2*Log[2]^2*Log[3])/72 + 
    (91*Log[2]^4*Log[3])/144 + (47*Pi^2*Log[2]*Log[3]^2)/48 + 
    (31*Log[2]^3*Log[3]^2)/12 - (7*Pi^2*Log[3]^3)/16 - 
    (17*Log[2]^2*Log[3]^3)/8 - (53*Log[2]*Log[3]^4)/96 + (547*Log[3]^5)/960 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + Log[2]^3*PolyLog[2, -1/2] - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - (5*Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 + (5*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - 
    (2*Log[3]^3*PolyLog[2, -1/2])/3 + (5*Log[2]*PolyLog[2, -1/2]^2)/2 - 
    2*Log[3]*PolyLog[2, -1/2]^2 + (Pi^2*PolyLog[3, -1/2])/12 - 
    2*Log[2]^2*PolyLog[3, -1/2] + 4*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (5*Log[3]^2*PolyLog[3, -1/2])/2 + 6*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/4 + (7*Log[2]^2*PolyLog[3, 1/3])/2 - 
    (Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (23*Log[3]^2*PolyLog[3, 1/3])/8 + 
    3*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 26*Log[2]*PolyLog[4, -1/2] + 
    (35*Log[3]*PolyLog[4, -1/2])/2 + (33*Log[2]*PolyLog[4, -1/3])/4 - 
    (33*Log[3]*PolyLog[4, -1/3])/8 - (25*Log[2]*PolyLog[4, 1/3])/2 + 
    (13*Log[3]*PolyLog[4, 1/3])/4 - (103*Log[2]*PolyLog[4, 1/2])/3 + 
    (95*Log[3]*PolyLog[4, 1/2])/3 + 5*Log[2]*PolyLog[4, 2/3] + 
    (13*Log[3]*PolyLog[4, 2/3])/2 - (124*PolyLog[5, -1/2])/3 - 
    (105*PolyLog[5, -1/3])/8 + 14*PolyLog[5, 1/3] - (589*PolyLog[5, 1/2])/9 + 
    5*PolyLog[5, 2/3] - (13*PolyLog[2, 3, -1/3])/8 + 12*PolyLog[2, 3, 1/3] + 
    (23*Pi^2*Zeta[3])/288 - (191*Log[2]^2*Zeta[3])/24 + 
    (45*Log[2]*Log[3]*Zeta[3])/8 + (3*Log[3]^2*Zeta[3])/32 + 
    (11*PolyLog[2, -1/2]*Zeta[3])/4 - (4027*Zeta[5])/576
 
G[1, -1, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -5*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] - (29*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (4673*Pi^4*Log[2])/12960 - (1661*Pi^2*Log[2]^3)/648 - 
    (5173*Log[2]^5)/1080 - (365*Pi^4*Log[3])/864 + 
    (287*Pi^2*Log[2]^2*Log[3])/36 + (371*Log[2]^4*Log[3])/72 - 
    (161*Pi^2*Log[2]*Log[3]^2)/24 + (32*Log[2]^3*Log[3]^2)/3 + 
    (275*Pi^2*Log[3]^3)/144 - (95*Log[2]^2*Log[3]^3)/4 + 
    (253*Log[2]*Log[3]^4)/16 - (881*Log[3]^5)/240 - 
    (5*Log[2]^3*PolyLog[2, -1/2])/6 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    (5*Log[2]*PolyLog[2, -1/2]^2)/2 + 2*Log[3]*PolyLog[2, -1/2]^2 + 
    (9*Log[2]^2*PolyLog[3, -1/2])/2 - 10*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (11*Log[3]^2*PolyLog[3, -1/2])/2 - 5*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (71*Log[2]^2*PolyLog[3, 1/3])/2 - 45*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (67*Log[3]^2*PolyLog[3, 1/3])/4 - 3*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    52*Log[2]*PolyLog[4, -1/2] + 25*Log[3]*PolyLog[4, -1/2] + 
    (29*Log[2]*PolyLog[4, -1/3])/2 - (39*Log[3]*PolyLog[4, -1/3])/4 - 
    35*Log[2]*PolyLog[4, 1/3] + (53*Log[3]*PolyLog[4, 1/3])/2 - 
    (215*Log[2]*PolyLog[4, 1/2])/3 + (140*Log[3]*PolyLog[4, 1/2])/3 + 
    84*Log[2]*PolyLog[4, 2/3] - 60*Log[3]*PolyLog[4, 2/3] - 
    (167*PolyLog[5, -1/2])/3 - 27*PolyLog[5, -1/3] + (95*PolyLog[5, 1/3])/2 - 
    (1022*PolyLog[5, 1/2])/9 - 109*PolyLog[5, 2/3] - 
    (29*PolyLog[2, 3, -1/3])/4 - 16*PolyLog[2, 3, 1/3] + 
    (13*Pi^2*Zeta[3])/12 - (2167*Log[2]^2*Zeta[3])/48 + 
    (533*Log[2]*Log[3]*Zeta[3])/12 - (109*Log[3]^2*Zeta[3])/8 + 
    (24575*Zeta[5])/288
 
G[1, -1, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] - 
    5*G[0, 0, 1, 0, -1, 1/2] + (473*Pi^4*Log[2])/4320 - 
    (205*Pi^2*Log[2]^3)/216 - (19*Log[2]^5)/12 - (7*Pi^4*Log[3])/60 + 
    (5*Pi^2*Log[2]^2*Log[3])/2 + (37*Log[2]^4*Log[3])/24 - 
    (15*Pi^2*Log[2]*Log[3]^2)/8 + (17*Log[2]^3*Log[3]^2)/4 + 
    (71*Pi^2*Log[3]^3)/144 - (33*Log[2]^2*Log[3]^3)/4 + 
    (239*Log[2]*Log[3]^4)/48 - (167*Log[3]^5)/160 + 
    (Log[2]^3*PolyLog[2, -1/2])/6 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (3*Log[2]^2*PolyLog[3, -1/2])/2 - 3*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (3*Log[3]^2*PolyLog[3, -1/2])/2 + 12*Log[2]^2*PolyLog[3, 1/3] - 
    14*Log[2]*Log[3]*PolyLog[3, 1/3] + (9*Log[3]^2*PolyLog[3, 1/3])/2 - 
    21*Log[2]*PolyLog[4, -1/2] + 11*Log[3]*PolyLog[4, -1/2] + 
    (15*Log[2]*PolyLog[4, -1/3])/2 - 5*Log[3]*PolyLog[4, -1/3] - 
    15*Log[2]*PolyLog[4, 1/3] + 10*Log[3]*PolyLog[4, 1/3] - 
    (80*Log[2]*PolyLog[4, 1/2])/3 + 20*Log[3]*PolyLog[4, 1/2] + 
    28*Log[2]*PolyLog[4, 2/3] - 18*Log[3]*PolyLog[4, 2/3] - 
    26*PolyLog[5, -1/2] - (51*PolyLog[5, -1/3])/4 + (39*PolyLog[5, 1/3])/2 - 
    (145*PolyLog[5, 1/2])/3 - 34*PolyLog[5, 2/3] - 
    (5*PolyLog[2, 3, -1/3])/2 - PolyLog[2, 3, 1/3] + (41*Pi^2*Zeta[3])/96 - 
    (349*Log[2]^2*Zeta[3])/24 + (53*Log[2]*Log[3]*Zeta[3])/4 - 
    (191*Log[3]^2*Zeta[3])/48 + (64*Zeta[5])/3
 
G[1, -1, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    (5*Pi^4*Log[2])/288 - (Pi^2*Log[2]^3)/3 + (17*Log[2]^5)/120 + 
    (5*Pi^2*Log[2]^2*Log[3])/6 - Log[2]^4*Log[3] - 
    (13*Pi^2*Log[2]*Log[3]^2)/24 + (29*Log[2]^3*Log[3]^2)/12 + 
    (5*Pi^2*Log[3]^3)/36 - (11*Log[2]^2*Log[3]^3)/4 + 
    (17*Log[2]*Log[3]^4)/12 - (17*Log[3]^5)/60 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 + (5*Log[2]^3*PolyLog[2, -1/2])/6 - 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/6 + (Log[2]*PolyLog[2, -1/2]^2)/2 + 
    Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    Log[3]^2*PolyLog[3, -1/2] + 4*Log[2]^2*PolyLog[3, 1/3] - 
    4*Log[2]*Log[3]*PolyLog[3, 1/3] + Log[3]^2*PolyLog[3, 1/3] - 
    2*Log[2]*PolyLog[4, -1/2] - 2*Log[2]*PolyLog[4, 1/3] + 
    3*Log[2]*PolyLog[4, 1/2] - 3*Log[3]*PolyLog[4, 1/2] + 
    6*Log[2]*PolyLog[4, 2/3] - 4*Log[3]*PolyLog[4, 2/3] + 3*PolyLog[5, 1/2] - 
    7*PolyLog[5, 2/3] + (23*Pi^2*Zeta[3])/96 - (17*Log[2]^2*Zeta[3])/8 + 
    (Log[2]*Log[3]*Zeta[3])/4 - (9*Log[3]^2*Zeta[3])/16 - 
    (PolyLog[2, -1/2]*Zeta[3])/8 + (73*Zeta[5])/64
 
G[1, -1, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -7*G[0, -1, 0, -1, -1, 1/2] + 
    6*G[0, 0, -1, 0, -1, 1/2] + (7*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1187*Pi^4*Log[2])/3240 - (193*Pi^2*Log[2]^3)/324 + (43*Log[2]^5)/540 - 
    (8*Pi^4*Log[3])/27 + (161*Pi^2*Log[2]^2*Log[3])/72 + 
    (139*Log[2]^4*Log[3])/72 - (27*Pi^2*Log[2]*Log[3]^2)/8 - 
    (4*Log[2]^3*Log[3]^2)/3 + (199*Pi^2*Log[3]^3)/144 - 
    (29*Log[2]^2*Log[3]^3)/6 + (111*Log[2]*Log[3]^4)/16 - (73*Log[3]^5)/30 - 
    (4*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 
    3*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/2 - (7*Log[2]*PolyLog[2, -1/2]^2)/2 + 
    3*Log[3]*PolyLog[2, -1/2]^2 + 7*Log[2]^2*PolyLog[3, -1/2] - 
    14*Log[2]*Log[3]*PolyLog[3, -1/2] + 7*Log[3]^2*PolyLog[3, -1/2] - 
    6*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/3 + 
    (Log[2]^2*PolyLog[3, 1/3])/2 - 18*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (53*Log[3]^2*PolyLog[3, 1/3])/4 - 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    27*Log[2]*PolyLog[4, -1/2] - 12*Log[3]*PolyLog[4, -1/2] - 
    (13*Log[2]*PolyLog[4, -1/3])/2 + (13*Log[3]*PolyLog[4, -1/3])/4 - 
    4*Log[2]*PolyLog[4, 1/3] + (25*Log[3]*PolyLog[4, 1/3])/2 + 
    (73*Log[2]*PolyLog[4, 1/2])/3 - (47*Log[3]*PolyLog[4, 1/2])/3 + 
    19*Log[2]*PolyLog[4, 2/3] - 34*Log[3]*PolyLog[4, 2/3] + 
    (118*PolyLog[5, -1/2])/3 + 10*PolyLog[5, -1/3] + (15*PolyLog[5, 1/3])/2 + 
    (307*PolyLog[5, 1/2])/9 - 55*PolyLog[5, 2/3] + 
    (13*PolyLog[2, 3, -1/3])/4 - 31*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/8 + 
    (317*Log[2]^2*Zeta[3])/24 - (25*Log[2]*Log[3]*Zeta[3])/12 - 
    (185*Log[3]^2*Zeta[3])/48 - (55*PolyLog[2, -1/2]*Zeta[3])/24 + 
    (2269*Zeta[5])/36
 
G[1, -1, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (33*Pi^4*Log[2])/160 - (8*Pi^2*Log[2]^3)/9 - 
    (19*Log[2]^5)/30 - (289*Pi^4*Log[3])/1440 + (17*Pi^2*Log[2]^2*Log[3])/6 + 
    (2*Log[2]^4*Log[3])/3 - (23*Pi^2*Log[2]*Log[3]^2)/8 + 
    (10*Log[2]^3*Log[3]^2)/3 + (71*Pi^2*Log[3]^3)/72 - 8*Log[2]^2*Log[3]^3 + 
    (51*Log[2]*Log[3]^4)/8 - (71*Log[3]^5)/40 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 + (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 + (3*Log[3]*PolyLog[2, -1/2]^2)/2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 8*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    4*Log[3]^2*PolyLog[3, -1/2] - 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/6 + 10*Log[2]^2*PolyLog[3, 1/3] - 
    18*Log[2]*Log[3]*PolyLog[3, 1/3] + 9*Log[3]^2*PolyLog[3, 1/3] - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 2*Log[2]*PolyLog[4, -1/2] - 
    2*Log[3]*PolyLog[4, -1/2] - 10*Log[2]*PolyLog[4, 1/3] + 
    10*Log[3]*PolyLog[4, 1/3] + 26*Log[2]*PolyLog[4, 2/3] - 
    26*Log[3]*PolyLog[4, 2/3] + 12*PolyLog[5, -1/2] + 12*PolyLog[5, 1/3] - 
    44*PolyLog[5, 2/3] - 16*PolyLog[2, 3, 1/3] + (3*Pi^2*Zeta[3])/16 - 
    (23*Log[2]^2*Zeta[3])/4 + (19*Log[2]*Log[3]*Zeta[3])/2 - 
    (39*Log[3]^2*Zeta[3])/8 - (7*PolyLog[2, -1/2]*Zeta[3])/4 + 
    (675*Zeta[5])/16
 
G[1, -1, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 7*G[0, -1, 0, -1, -1, 1/2] - 
    3*G[0, 0, -1, 0, -1, 1/2] + (17*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (5327*Pi^4*Log[2])/12960 + (245*Pi^2*Log[2]^3)/162 + 
    (1061*Log[2]^5)/540 + (377*Pi^4*Log[3])/864 - (155*Pi^2*Log[2]^2*Log[3])/
     36 - (613*Log[2]^4*Log[3])/144 + (221*Pi^2*Log[2]*Log[3]^2)/48 - 
    (11*Log[2]^3*Log[3]^2)/6 - (79*Pi^2*Log[3]^3)/48 + 
    (259*Log[2]^2*Log[3]^3)/24 - (937*Log[2]*Log[3]^4)/96 + 
    (2759*Log[3]^5)/960 + (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + 
    (5*Log[2]^3*PolyLog[2, -1/2])/6 - (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    3*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 3*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (5*Log[3]^3*PolyLog[2, -1/2])/6 + (5*Log[2]*PolyLog[2, -1/2]^2)/2 - 
    3*Log[3]*PolyLog[2, -1/2]^2 - 7*Log[2]^2*PolyLog[3, -1/2] + 
    14*Log[2]*Log[3]*PolyLog[3, -1/2] - 7*Log[3]^2*PolyLog[3, -1/2] + 
    3*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/3 - 
    (23*Log[2]^2*PolyLog[3, 1/3])/2 + (51*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (115*Log[3]^2*PolyLog[3, 1/3])/8 + 4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    8*Log[2]*PolyLog[4, -1/2] - (17*Log[3]*PolyLog[4, -1/2])/2 - 
    (19*Log[2]*PolyLog[4, -1/3])/4 + (19*Log[3]*PolyLog[4, -1/3])/8 + 
    (35*Log[2]*PolyLog[4, 1/3])/2 - (71*Log[3]*PolyLog[4, 1/3])/4 + 
    (55*Log[2]*PolyLog[4, 1/2])/3 - (59*Log[3]*PolyLog[4, 1/2])/3 - 
    47*Log[2]*PolyLog[4, 2/3] + (93*Log[3]*PolyLog[4, 2/3])/2 + 
    (32*PolyLog[5, -1/2])/3 + (55*PolyLog[5, -1/3])/8 - 24*PolyLog[5, 1/3] + 
    (359*PolyLog[5, 1/2])/9 + 83*PolyLog[5, 2/3] - 
    (5*PolyLog[2, 3, -1/3])/8 + 32*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/12 + 
    (31*Log[2]^2*Zeta[3])/6 - (343*Log[2]*Log[3]*Zeta[3])/24 + 
    (679*Log[3]^2*Zeta[3])/96 - (11*PolyLog[2, -1/2]*Zeta[3])/24 - 
    (49351*Zeta[5])/576
 
G[1, -1, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] + 4*G[0, 0, 1, 0, -1, 1/2] - 
    (499*Pi^4*Log[2])/4320 + (97*Pi^2*Log[2]^3)/108 + (29*Log[2]^5)/15 + 
    (173*Pi^4*Log[3])/1440 - (67*Pi^2*Log[2]^2*Log[3])/24 - 
    (83*Log[2]^4*Log[3])/48 + (103*Pi^2*Log[2]*Log[3]^2)/48 - 
    (14*Log[2]^3*Log[3]^2)/3 - (37*Pi^2*Log[3]^3)/72 + 
    (209*Log[2]^2*Log[3]^3)/24 - (479*Log[2]*Log[3]^4)/96 + 
    (887*Log[3]^5)/960 + (Log[2]^3*PolyLog[2, -1/2])/6 - 
    (Log[3]^3*PolyLog[2, -1/2])/6 + (Log[2]*PolyLog[2, -1/2]^2)/2 - 
    Log[2]^2*PolyLog[3, -1/2] + 2*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    Log[3]^2*PolyLog[3, -1/2] + PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (29*Log[2]^2*PolyLog[3, 1/3])/2 + (29*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (21*Log[3]^2*PolyLog[3, 1/3])/8 + 24*Log[2]*PolyLog[4, -1/2] - 
    (23*Log[3]*PolyLog[4, -1/2])/2 - (29*Log[2]*PolyLog[4, -1/3])/4 + 
    (53*Log[3]*PolyLog[4, -1/3])/8 + (25*Log[2]*PolyLog[4, 1/3])/2 - 
    (25*Log[3]*PolyLog[4, 1/3])/4 + (94*Log[2]*PolyLog[4, 1/2])/3 - 
    22*Log[3]*PolyLog[4, 1/2] - 31*Log[2]*PolyLog[4, 2/3] + 
    (39*Log[3]*PolyLog[4, 2/3])/2 + 27*PolyLog[5, -1/2] + 
    (135*PolyLog[5, -1/3])/8 - (35*PolyLog[5, 1/3])/2 + 
    (140*PolyLog[5, 1/2])/3 + 37*PolyLog[5, 2/3] + 
    (29*PolyLog[2, 3, -1/3])/8 - (13*Pi^2*Zeta[3])/24 + 
    (247*Log[2]^2*Zeta[3])/12 - (461*Log[2]*Log[3]*Zeta[3])/24 + 
    (473*Log[3]^2*Zeta[3])/96 - (241*Zeta[5])/12
 
G[1, -1, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + 4*G[0, 0, 1, 0, -1, 1/2] - 
    (1139*Pi^4*Log[2])/4320 + (199*Pi^2*Log[2]^3)/216 + (7*Log[2]^5)/6 + 
    (107*Pi^4*Log[3])/480 - (21*Pi^2*Log[2]^2*Log[3])/8 - 
    (55*Log[2]^4*Log[3])/24 + (21*Pi^2*Log[2]*Log[3]^2)/8 - 
    (19*Log[2]^3*Log[3]^2)/12 - (31*Pi^2*Log[3]^3)/36 + 
    (41*Log[2]^2*Log[3]^3)/6 - (93*Log[2]*Log[3]^4)/16 + (257*Log[3]^5)/160 + 
    (Log[2]^3*PolyLog[2, -1/2])/2 - (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/2 + 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 - (3*Log[3]*PolyLog[2, -1/2]^2)/2 - 
    4*Log[2]^2*PolyLog[3, -1/2] + 8*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    4*Log[3]^2*PolyLog[3, -1/2] + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    8*Log[2]^2*PolyLog[3, 1/3] + 15*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (29*Log[3]^2*PolyLog[3, 1/3])/4 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    6*Log[2]*PolyLog[4, -1/2] - 5*Log[3]*PolyLog[4, -1/2] - 
    (7*Log[2]*PolyLog[4, -1/3])/2 + (13*Log[3]*PolyLog[4, -1/3])/4 + 
    10*Log[2]*PolyLog[4, 1/3] - (19*Log[3]*PolyLog[4, 1/3])/2 + 
    (29*Log[2]*PolyLog[4, 1/2])/3 - 9*Log[3]*PolyLog[4, 1/2] - 
    29*Log[2]*PolyLog[4, 2/3] + 28*Log[3]*PolyLog[4, 2/3] + 
    8*PolyLog[5, -1/2] + (27*PolyLog[5, -1/3])/4 - 13*PolyLog[5, 1/3] + 
    (64*PolyLog[5, 1/2])/3 + 50*PolyLog[5, 2/3] + PolyLog[2, 3, -1/3]/4 + 
    16*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/16 + (101*Log[2]^2*Zeta[3])/24 - 
    (41*Log[2]*Log[3]*Zeta[3])/6 + (157*Log[3]^2*Zeta[3])/48 - 
    (4169*Zeta[5])/96
 
G[1, -1, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] - 
    3*G[0, 0, -1, 0, -1, 1/2] - (Pi^4*Log[2])/6 + (13*Pi^2*Log[2]^3)/18 + 
    (19*Log[2]^5)/24 + (49*Pi^4*Log[3])/288 - (9*Pi^2*Log[2]^2*Log[3])/4 - 
    (11*Log[2]^4*Log[3])/6 + (7*Pi^2*Log[2]*Log[3]^2)/3 - 
    (5*Log[2]^3*Log[3]^2)/12 - (19*Pi^2*Log[3]^3)/24 + 
    (9*Log[2]^2*Log[3]^3)/2 - (35*Log[2]*Log[3]^4)/8 + (53*Log[3]^5)/40 + 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 - (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/2 + (3*Log[2]*PolyLog[2, -1/2]^2)/2 - 
    (3*Log[3]*PolyLog[2, -1/2]^2)/2 - 3*Log[2]^2*PolyLog[3, -1/2] + 
    6*Log[2]*Log[3]*PolyLog[3, -1/2] - 3*Log[3]^2*PolyLog[3, -1/2] + 
    3*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/6 - 
    (11*Log[2]^2*PolyLog[3, 1/3])/2 + 11*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (13*Log[3]^2*PolyLog[3, 1/3])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    3*Log[2]*PolyLog[4, 1/3] - 6*Log[3]*PolyLog[4, 1/3] - 
    21*Log[2]*PolyLog[4, 2/3] + 21*Log[3]*PolyLog[4, 2/3] - 
    6*PolyLog[5, -1/2] - 6*PolyLog[5, 1/3] - 3*PolyLog[5, 1/2] + 
    36*PolyLog[5, 2/3] + 15*PolyLog[2, 3, 1/3] + (7*Pi^2*Zeta[3])/96 + 
    (31*Log[2]^2*Zeta[3])/8 - (31*Log[2]*Log[3]*Zeta[3])/4 + 
    (55*Log[3]^2*Zeta[3])/16 + (7*PolyLog[2, -1/2]*Zeta[3])/8 - 
    (2223*Zeta[5])/64
 
G[1, -1, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -3*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] - 2*G[0, 0, 1, 0, -1, 1/2] + 
    (29*Pi^4*Log[2])/160 - (47*Pi^2*Log[2]^3)/72 - (109*Log[2]^5)/120 - 
    (127*Pi^4*Log[3])/720 + (25*Pi^2*Log[2]^2*Log[3])/12 + 
    (5*Log[2]^4*Log[3])/3 - (13*Pi^2*Log[2]*Log[3]^2)/6 + 
    (3*Log[2]^3*Log[3]^2)/2 + (13*Pi^2*Log[3]^3)/18 - 
    (71*Log[2]^2*Log[3]^3)/12 + (31*Log[2]*Log[3]^4)/6 - (59*Log[3]^5)/40 - 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 + (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 - Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 + (3*Log[3]*PolyLog[2, -1/2]^2)/2 + 
    3*Log[2]^2*PolyLog[3, -1/2] - 6*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    3*Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (13*Log[2]^2*PolyLog[3, 1/3])/2 - 15*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (17*Log[3]^2*PolyLog[3, 1/3])/2 - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    3*Log[2]*PolyLog[4, -1/2] + 3*Log[3]*PolyLog[4, -1/2] - 
    9*Log[2]*PolyLog[4, 1/3] + 12*Log[3]*PolyLog[4, 1/3] - 
    7*Log[2]*PolyLog[4, 1/2] + 4*Log[3]*PolyLog[4, 1/2] + 
    21*Log[2]*PolyLog[4, 2/3] - 21*Log[3]*PolyLog[4, 2/3] - 
    3*PolyLog[5, -1/2] + 13*PolyLog[5, 1/3] - 16*PolyLog[5, 1/2] - 
    37*PolyLog[5, 2/3] - 15*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/96 - 
    (53*Log[2]^2*Zeta[3])/16 + (23*Log[2]*Log[3]*Zeta[3])/4 - 
    (5*Log[3]^2*Zeta[3])/2 + (2339*Zeta[5])/64
 
G[1, -1, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := Log[2]^5/12 - (5*Log[2]^4*Log[3])/12 + 
    (5*Log[2]^3*Log[3]^2)/6 - (5*Log[2]^2*Log[3]^3)/6 + 
    (5*Log[2]*Log[3]^4)/12 - Log[3]^5/12 + (Log[2]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 - (Log[3]^3*PolyLog[2, -1/2])/6 + Log[2]^2*PolyLog[3, 1/3] - 
    2*Log[2]*Log[3]*PolyLog[3, 1/3] + Log[3]^2*PolyLog[3, 1/3] - 
    3*Log[2]*PolyLog[4, 1/3] + 3*Log[3]*PolyLog[4, 1/3] - 
    Log[2]*PolyLog[4, 1/2] + Log[3]*PolyLog[4, 1/2] + 4*PolyLog[5, 1/3] - 
    4*PolyLog[5, 1/2]
 
G[1, 0, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, 0, 1, 0, -1, 1/2] - 
    (43*Pi^4*Log[2])/864 + (53*Pi^2*Log[2]^3)/72 - (523*Log[2]^5)/360 + 
    (31*Pi^4*Log[3])/1080 - (Pi^2*Log[2]^2*Log[3])/18 + 
    (23*Log[2]^4*Log[3])/36 - (5*Pi^2*Log[2]*Log[3]^2)/24 + 
    (5*Log[2]^3*Log[3]^2)/6 + (Pi^2*Log[3]^3)/24 - (3*Log[2]^2*Log[3]^3)/4 - 
    (5*Log[2]*Log[3]^4)/48 + (13*Log[3]^5)/80 - (4*Log[2]^3*PolyLog[2, -1/2])/
     3 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*
     PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    8*Log[2]^2*PolyLog[3, -1/2] + 8*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    2*Log[3]^2*PolyLog[3, -1/2] + 4*Log[2]^2*PolyLog[3, 1/3] - 
    2*Log[3]^2*PolyLog[3, 1/3] - 28*Log[2]*PolyLog[4, -1/2] + 
    10*Log[3]*PolyLog[4, -1/2] - (5*Log[2]*PolyLog[4, -1/3])/2 + 
    (5*Log[3]*PolyLog[4, -1/3])/4 + 7*Log[2]*PolyLog[4, 1/3] - 
    (15*Log[3]*PolyLog[4, 1/3])/2 - (104*Log[2]*PolyLog[4, 1/2])/3 + 
    (40*Log[3]*PolyLog[4, 1/2])/3 + 4*Log[2]*PolyLog[4, 2/3] + 
    2*Log[3]*PolyLog[4, 2/3] - 29*PolyLog[5, -1/2] - 
    (15*PolyLog[5, -1/3])/4 - (5*PolyLog[5, 1/3])/2 - 27*PolyLog[5, 1/2] - 
    (7*PolyLog[2, 3, -1/3])/2 + 8*PolyLog[2, 3, 1/3] + (49*Pi^2*Zeta[3])/96 - 
    (521*Log[2]^2*Zeta[3])/24 + (229*Log[2]*Log[3]*Zeta[3])/12 - 
    (229*Log[3]^2*Zeta[3])/48 - (439*Zeta[5])/64
 
G[1, 0, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 8*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + 13*G[0, 0, 1, 0, -1, 1/2] - 
    (1309*Pi^4*Log[2])/4320 + (763*Pi^2*Log[2]^3)/216 + (2279*Log[2]^5)/360 + 
    (27*Pi^4*Log[3])/80 - 11*Pi^2*Log[2]^2*Log[3] - 
    (179*Log[2]^4*Log[3])/24 + (215*Pi^2*Log[2]*Log[3]^2)/24 - 
    (67*Log[2]^3*Log[3]^2)/6 - (175*Pi^2*Log[3]^3)/72 + 
    (83*Log[2]^2*Log[3]^3)/3 - (895*Log[2]*Log[3]^4)/48 + 
    (679*Log[3]^5)/160 + (Pi^2*Log[2]*PolyLog[2, -1/2])/3 + 
    2*Log[2]^3*PolyLog[2, -1/2] - (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    4*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 3*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (5*Log[3]^3*PolyLog[2, -1/2])/6 + 4*Log[2]*PolyLog[2, -1/2]^2 - 
    4*Log[3]*PolyLog[2, -1/2]^2 + (2*Pi^2*PolyLog[3, -1/2])/3 - 
    4*Log[2]^2*PolyLog[3, -1/2] + 16*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    10*Log[3]^2*PolyLog[3, -1/2] + 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/2 - 40*Log[2]^2*PolyLog[3, 1/3] + 
    47*Log[2]*Log[3]*PolyLog[3, 1/3] - (61*Log[3]^2*PolyLog[3, 1/3])/4 + 
    6*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 82*Log[2]*PolyLog[4, -1/2] - 
    39*Log[3]*PolyLog[4, -1/2] - (39*Log[2]*PolyLog[4, -1/3])/2 + 
    (29*Log[3]*PolyLog[4, -1/3])/2 + 31*Log[2]*PolyLog[4, 1/3] - 
    18*Log[3]*PolyLog[4, 1/3] + 91*Log[2]*PolyLog[4, 1/2] - 
    52*Log[3]*PolyLog[4, 1/2] - 102*Log[2]*PolyLog[4, 2/3] + 
    71*Log[3]*PolyLog[4, 2/3] + 103*PolyLog[5, -1/2] + 34*PolyLog[5, -1/3] - 
    (75*PolyLog[5, 1/3])/2 + (442*PolyLog[5, 1/2])/3 + 118*PolyLog[5, 2/3] + 
    (39*PolyLog[2, 3, -1/3])/4 + 8*PolyLog[2, 3, 1/3] - (13*Pi^2*Zeta[3])/9 + 
    (2929*Log[2]^2*Zeta[3])/48 - (233*Log[2]*Log[3]*Zeta[3])/4 + 
    (217*Log[3]^2*Zeta[3])/12 - (4*PolyLog[2, -1/2]*Zeta[3])/3 - 
    (7769*Zeta[5])/96
 
G[1, 0, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + (29*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (1273*Pi^4*Log[2])/6480 + (865*Pi^2*Log[2]^3)/324 + (167*Log[2]^5)/54 + 
    (493*Pi^4*Log[3])/2160 - (491*Pi^2*Log[2]^2*Log[3])/72 - 
    (131*Log[2]^4*Log[3])/36 + (83*Pi^2*Log[2]*Log[3]^2)/16 - 
    8*Log[2]^3*Log[3]^2 - (11*Pi^2*Log[3]^3)/8 + (53*Log[2]^2*Log[3]^3)/3 - 
    (1097*Log[2]*Log[3]^4)/96 + (51*Log[3]^5)/20 + 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 - (Log[2]^3*PolyLog[2, -1/2])/3 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 + Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    2*Log[2]*PolyLog[2, -1/2]^2 - 2*Log[3]*PolyLog[2, -1/2]^2 + 
    (Pi^2*PolyLog[3, -1/2])/3 - 8*Log[2]^2*PolyLog[3, -1/2] + 
    12*Log[2]*Log[3]*PolyLog[3, -1/2] - 6*Log[3]^2*PolyLog[3, -1/2] + 
    3*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/4 - 
    (53*Log[2]^2*PolyLog[3, 1/3])/2 + 30*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    10*Log[3]^2*PolyLog[3, 1/3] + 3*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    38*Log[2]*PolyLog[4, -1/2] - 18*Log[3]*PolyLog[4, -1/2] - 
    (59*Log[2]*PolyLog[4, -1/3])/4 + (39*Log[3]*PolyLog[4, -1/3])/4 + 
    (51*Log[2]*PolyLog[4, 1/3])/2 - (31*Log[3]*PolyLog[4, 1/3])/2 + 
    (122*Log[2]*PolyLog[4, 1/2])/3 - (82*Log[3]*PolyLog[4, 1/2])/3 - 
    63*Log[2]*PolyLog[4, 2/3] + 43*Log[3]*PolyLog[4, 2/3] + 
    (173*PolyLog[5, -1/2])/3 + (87*PolyLog[5, -1/3])/4 - 
    (55*PolyLog[5, 1/3])/2 + (803*PolyLog[5, 1/2])/9 + 73*PolyLog[5, 2/3] + 
    5*PolyLog[2, 3, -1/3] + 7*PolyLog[2, 3, 1/3] - (107*Pi^2*Zeta[3])/144 + 
    (355*Log[2]^2*Zeta[3])/12 - (343*Log[2]*Log[3]*Zeta[3])/12 + 
    (71*Log[3]^2*Zeta[3])/8 + (PolyLog[2, -1/2]*Zeta[3])/8 - 
    (29113*Zeta[5])/576
 
G[1, 0, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -10*G[0, -1, 0, -1, -1, 1/2] - 
    6*G[0, 0, -1, 0, -1, 1/2] - (26*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (311*Pi^4*Log[2])/1296 - (1111*Pi^2*Log[2]^3)/324 - (145*Log[2]^5)/27 - 
    (691*Pi^4*Log[3])/2160 + (91*Pi^2*Log[2]^2*Log[3])/9 + 
    (487*Log[2]^4*Log[3])/72 - (17*Pi^2*Log[2]*Log[3]^2)/2 + 
    10*Log[2]^3*Log[3]^2 + (59*Pi^2*Log[3]^3)/24 - (74*Log[2]^2*Log[3]^3)/3 + 
    (50*Log[2]*Log[3]^4)/3 - (1883*Log[3]^5)/480 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/3 - Log[2]^3*PolyLog[2, -1/2] + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 4*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    4*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (7*Log[3]^3*PolyLog[2, -1/2])/6 - 
    3*Log[2]*PolyLog[2, -1/2]^2 + 4*Log[3]*PolyLog[2, -1/2]^2 - 
    (2*Pi^2*PolyLog[3, -1/2])/3 + 6*Log[2]^2*PolyLog[3, -1/2] - 
    12*Log[2]*Log[3]*PolyLog[3, -1/2] + 8*Log[3]^2*PolyLog[3, -1/2] - 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/2 + 
    37*Log[2]^2*PolyLog[3, 1/3] - 41*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (55*Log[3]^2*PolyLog[3, 1/3])/4 - 6*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    70*Log[2]*PolyLog[4, -1/2] + 41*Log[3]*PolyLog[4, -1/2] + 
    15*Log[2]*PolyLog[4, -1/3] - (15*Log[3]*PolyLog[4, -1/3])/2 - 
    18*Log[2]*PolyLog[4, 1/3] + 6*Log[3]*PolyLog[4, 1/3] - 
    (206*Log[2]*PolyLog[4, 1/2])/3 + (148*Log[3]*PolyLog[4, 1/2])/3 + 
    92*Log[2]*PolyLog[4, 2/3] - 63*Log[3]*PolyLog[4, 2/3] - 
    (248*PolyLog[5, -1/2])/3 - 22*PolyLog[5, -1/3] + (37*PolyLog[5, 1/3])/2 - 
    (908*PolyLog[5, 1/2])/9 - 102*PolyLog[5, 2/3] - 
    (33*PolyLog[2, 3, -1/3])/4 - 14*PolyLog[2, 3, 1/3] + 
    (145*Pi^2*Zeta[3])/144 - (1391*Log[2]^2*Zeta[3])/24 + 
    (191*Log[2]*Log[3]*Zeta[3])/3 - (251*Log[3]^2*Zeta[3])/12 + 
    (8*PolyLog[2, -1/2]*Zeta[3])/3 + (42109*Zeta[5])/576
 
G[1, 0, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + (16*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (53*Pi^4*Log[2])/810 + (127*Pi^2*Log[2]^3)/162 + (1189*Log[2]^5)/540 - 
    (5*Pi^4*Log[3])/216 - (22*Pi^2*Log[2]^2*Log[3])/9 - 
    (53*Log[2]^4*Log[3])/36 + (5*Pi^2*Log[2]*Log[3]^2)/4 - 
    5*Log[2]^3*Log[3]^2 - (7*Pi^2*Log[3]^3)/72 + (91*Log[2]^2*Log[3]^3)/12 - 
    (19*Log[2]*Log[3]^4)/6 + (5*Log[3]^5)/16 - (Log[2]^3*PolyLog[2, -1/2])/
     3 + (Log[3]^3*PolyLog[2, -1/2])/6 - Log[2]*PolyLog[2, -1/2]^2 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 15*Log[2]^2*PolyLog[3, 1/3] + 
    8*Log[2]*Log[3]*PolyLog[3, 1/3] + 40*Log[2]*PolyLog[4, -1/2] - 
    22*Log[3]*PolyLog[4, -1/2] - 11*Log[2]*PolyLog[4, -1/3] + 
    (25*Log[3]*PolyLog[4, -1/3])/4 + 12*Log[2]*PolyLog[4, 1/3] - 
    (11*Log[3]*PolyLog[4, 1/3])/2 + (136*Log[2]*PolyLog[4, 1/2])/3 - 
    (88*Log[3]*PolyLog[4, 1/2])/3 - 26*Log[2]*PolyLog[4, 2/3] + 
    8*Log[3]*PolyLog[4, 2/3] + (148*PolyLog[5, -1/2])/3 + 
    (57*PolyLog[5, -1/3])/4 - (33*PolyLog[5, 1/3])/2 + 
    (616*PolyLog[5, 1/2])/9 + 16*PolyLog[5, 2/3] + 
    (11*PolyLog[2, 3, -1/3])/2 - 14*PolyLog[2, 3, 1/3] - 
    (11*Pi^2*Zeta[3])/12 + (337*Log[2]^2*Zeta[3])/12 - 
    (119*Log[2]*Log[3]*Zeta[3])/6 + (143*Log[3]^2*Zeta[3])/48 - 
    (13*PolyLog[2, -1/2]*Zeta[3])/6 + (343*Zeta[5])/144
 
G[1, 0, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -6*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + (2*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (1333*Pi^4*Log[2])/12960 - (329*Pi^2*Log[2]^3)/324 - (523*Log[2]^5)/540 - 
    (11*Pi^4*Log[3])/96 + (37*Pi^2*Log[2]^2*Log[3])/12 + 
    (49*Log[2]^4*Log[3])/24 - (145*Pi^2*Log[2]*Log[3]^2)/48 + 
    Log[2]^3*Log[3]^2 + (143*Pi^2*Log[3]^3)/144 - (71*Log[2]^2*Log[3]^3)/12 + 
    (171*Log[2]*Log[3]^4)/32 - (37*Log[3]^5)/24 - 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + (2*Log[3]^3*PolyLog[2, -1/2])/3 - 
    2*Log[2]*PolyLog[2, -1/2]^2 + 2*Log[3]*PolyLog[2, -1/2]^2 + 
    4*Log[2]^2*PolyLog[3, -1/2] - 8*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    4*Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (13*Log[2]^2*PolyLog[3, 1/3])/2 - 12*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (23*Log[3]^2*PolyLog[3, 1/3])/4 - 3*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    6*Log[2]*PolyLog[4, -1/2] + 5*Log[3]*PolyLog[4, -1/2] - 
    (Log[2]*PolyLog[4, -1/3])/4 + (Log[3]*PolyLog[4, -1/3])/2 + 
    (3*Log[2]*PolyLog[4, 1/3])/2 - 2*Log[3]*PolyLog[4, 1/3] - 
    (2*Log[2]*PolyLog[4, 1/2])/3 + 24*Log[2]*PolyLog[4, 2/3] - 
    23*Log[3]*PolyLog[4, 2/3] - (16*PolyLog[5, -1/2])/3 + 
    (3*PolyLog[5, -1/3])/4 - 6*PolyLog[5, 1/3] + (8*PolyLog[5, 1/2])/9 - 
    34*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3]/4 - 14*PolyLog[2, 3, 1/3] + 
    (Pi^2*Zeta[3])/24 - (121*Log[2]^2*Zeta[3])/16 + 
    (325*Log[2]*Log[3]*Zeta[3])/24 - (13*Log[3]^2*Zeta[3])/2 + 
    (11*PolyLog[2, -1/2]*Zeta[3])/24 + (9859*Zeta[5])/288
 
G[1, 0, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -5*G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] - (11*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (2231*Pi^4*Log[2])/12960 - (457*Pi^2*Log[2]^3)/324 - (82*Log[2]^5)/27 - 
    (97*Pi^4*Log[3])/480 + (121*Pi^2*Log[2]^2*Log[3])/24 + 
    (49*Log[2]^4*Log[3])/16 - (73*Pi^2*Log[2]*Log[3]^2)/16 + 
    (19*Log[2]^3*Log[3]^2)/3 + (65*Pi^2*Log[3]^3)/48 - 
    (329*Log[2]^2*Log[3]^3)/24 + (869*Log[2]*Log[3]^4)/96 - 
    (681*Log[3]^5)/320 - (5*Log[2]^3*PolyLog[2, -1/2])/6 + 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + (5*Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 - (5*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + 
    (2*Log[3]^3*PolyLog[2, -1/2])/3 - (3*Log[2]*PolyLog[2, -1/2]^2)/2 + 
    2*Log[3]*PolyLog[2, -1/2]^2 - (Pi^2*PolyLog[3, -1/2])/3 + 
    Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    3*Log[3]^2*PolyLog[3, -1/2] - 3*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/4 + (45*Log[2]^2*PolyLog[3, 1/3])/2 - 
    (47*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + (63*Log[3]^2*PolyLog[3, 1/3])/8 - 
    3*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 40*Log[2]*PolyLog[4, -1/2] + 
    (41*Log[3]*PolyLog[4, -1/2])/2 + (23*Log[2]*PolyLog[4, -1/3])/4 - 
    (23*Log[3]*PolyLog[4, -1/3])/8 - (15*Log[2]*PolyLog[4, 1/3])/2 + 
    (11*Log[3]*PolyLog[4, 1/3])/4 - 43*Log[2]*PolyLog[4, 1/2] + 
    27*Log[3]*PolyLog[4, 1/2] + 51*Log[2]*PolyLog[4, 2/3] - 
    (69*Log[3]*PolyLog[4, 2/3])/2 - (158*PolyLog[5, -1/2])/3 - 
    (111*PolyLog[5, -1/3])/8 + 12*PolyLog[5, 1/3] - (563*PolyLog[5, 1/2])/9 - 
    61*PolyLog[5, 2/3] - (43*PolyLog[2, 3, -1/3])/8 - 8*PolyLog[2, 3, 1/3] + 
    (169*Pi^2*Zeta[3])/288 - (299*Log[2]^2*Zeta[3])/8 + 
    (977*Log[2]*Log[3]*Zeta[3])/24 - (1217*Log[3]^2*Zeta[3])/96 - 
    (PolyLog[2, -1/2]*Zeta[3])/4 + (23965*Zeta[5])/576
 
G[1, 0, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (29*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (953*Pi^4*Log[2])/12960 + (1655*Pi^2*Log[2]^3)/648 + 
    (1121*Log[2]^5)/216 + (77*Pi^4*Log[3])/480 - (31*Pi^2*Log[2]^2*Log[3])/
     4 - (127*Log[2]^4*Log[3])/24 + (45*Pi^2*Log[2]*Log[3]^2)/8 - 
    (39*Log[2]^3*Log[3]^2)/4 - (187*Pi^2*Log[3]^3)/144 + 
    (245*Log[2]^2*Log[3]^3)/12 - (583*Log[2]*Log[3]^4)/48 + 
    (577*Log[3]^5)/240 + (Pi^2*Log[2]*PolyLog[2, -1/2])/6 + 
    Log[2]^3*PolyLog[2, -1/2] - 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 - 2*Log[3]*PolyLog[2, -1/2]^2 - 
    Log[2]^2*PolyLog[3, -1/2] + 6*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    5*Log[3]^2*PolyLog[3, -1/2] - (65*Log[2]^2*PolyLog[3, 1/3])/2 + 
    31*Log[2]*Log[3]*PolyLog[3, 1/3] - (31*Log[3]^2*PolyLog[3, 1/3])/4 + 
    3*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 74*Log[2]*PolyLog[4, -1/2] - 
    39*Log[3]*PolyLog[4, -1/2] - (37*Log[2]*PolyLog[4, -1/3])/2 + 
    (47*Log[3]*PolyLog[4, -1/3])/4 + 25*Log[2]*PolyLog[4, 1/3] - 
    (25*Log[3]*PolyLog[4, 1/3])/2 + (247*Log[2]*PolyLog[4, 1/2])/3 - 
    52*Log[3]*PolyLog[4, 1/2] - 74*Log[2]*PolyLog[4, 2/3] + 
    42*Log[3]*PolyLog[4, 2/3] + (263*PolyLog[5, -1/2])/3 + 
    27*PolyLog[5, -1/3] - (59*PolyLog[5, 1/3])/2 + (1106*PolyLog[5, 1/2])/9 + 
    71*PolyLog[5, 2/3] + (37*PolyLog[2, 3, -1/3])/4 - 6*PolyLog[2, 3, 1/3] - 
    (37*Pi^2*Zeta[3])/24 + (859*Log[2]^2*Zeta[3])/16 - 
    (553*Log[2]*Log[3]*Zeta[3])/12 + (35*Log[3]^2*Zeta[3])/3 - 
    (11*PolyLog[2, -1/2]*Zeta[3])/4 - (5563*Zeta[5])/144
 
G[1, 0, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + 3*G[0, 0, 1, 0, -1, 1/2] + 
    (139*Pi^4*Log[2])/4320 + (79*Pi^2*Log[2]^3)/108 + (83*Log[2]^5)/72 - 
    (Pi^4*Log[3])/216 - (59*Pi^2*Log[2]^2*Log[3])/36 - 
    (163*Log[2]^4*Log[3])/144 + (37*Pi^2*Log[2]*Log[3]^2)/48 - 
    (5*Log[2]^3*Log[3]^2)/2 - (Pi^2*Log[3]^3)/16 + 
    (107*Log[2]^2*Log[3]^3)/24 - (199*Log[2]*Log[3]^4)/96 + 
    (77*Log[3]^5)/320 + (Pi^2*Log[2]*PolyLog[2, -1/2])/12 - 
    (Log[2]^3*PolyLog[2, -1/2])/3 + (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    Log[2]^2*PolyLog[3, -1/2] + 2*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    Log[3]^2*PolyLog[3, -1/2] - PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (15*Log[2]^2*PolyLog[3, 1/3])/2 + (11*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (3*Log[3]^2*PolyLog[3, 1/3])/8 + 19*Log[2]*PolyLog[4, -1/2] - 
    (19*Log[3]*PolyLog[4, -1/2])/2 - (29*Log[2]*PolyLog[4, -1/3])/4 + 
    (39*Log[3]*PolyLog[4, -1/3])/8 + (21*Log[2]*PolyLog[4, 1/3])/2 - 
    (23*Log[3]*PolyLog[4, 1/3])/4 + 22*Log[2]*PolyLog[4, 1/2] - 
    (47*Log[3]*PolyLog[4, 1/2])/3 - 15*Log[2]*PolyLog[4, 2/3] + 
    (11*Log[3]*PolyLog[4, 2/3])/2 + 22*PolyLog[5, -1/2] + 
    (75*PolyLog[5, -1/3])/8 - 13*PolyLog[5, 1/3] + (113*PolyLog[5, 1/2])/3 + 
    9*PolyLog[5, 2/3] + (19*PolyLog[2, 3, -1/3])/8 - 7*PolyLog[2, 3, 1/3] - 
    (19*Pi^2*Zeta[3])/48 + (89*Log[2]^2*Zeta[3])/8 - 
    (173*Log[2]*Log[3]*Zeta[3])/24 + (33*Log[3]^2*Zeta[3])/32 - 
    (7*PolyLog[2, -1/2]*Zeta[3])/8 + (73*Zeta[5])/192
 
G[1, 0, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + (14*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (247*Pi^4*Log[2])/6480 + (445*Pi^2*Log[2]^3)/324 + (391*Log[2]^5)/270 + 
    (19*Pi^4*Log[3])/270 - (61*Pi^2*Log[2]^2*Log[3])/18 - 
    (10*Log[2]^4*Log[3])/9 + (5*Pi^2*Log[2]*Log[3]^2)/2 - 
    (11*Log[2]^3*Log[3]^2)/2 - (23*Pi^2*Log[3]^3)/36 + 
    (39*Log[2]^2*Log[3]^3)/4 - (137*Log[2]*Log[3]^4)/24 + (47*Log[3]^5)/40 - 
    Log[2]^3*PolyLog[2, -1/2] + 2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    Log[2]*PolyLog[2, -1/2]^2 - 2*Log[2]^2*PolyLog[3, -1/2] + 
    4*Log[2]*Log[3]*PolyLog[3, -1/2] - 2*Log[3]^2*PolyLog[3, -1/2] - 
    2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 15*Log[2]^2*PolyLog[3, 1/3] + 
    16*Log[2]*Log[3]*PolyLog[3, 1/3] - (9*Log[3]^2*PolyLog[3, 1/3])/2 + 
    28*Log[2]*PolyLog[4, -1/2] - 16*Log[3]*PolyLog[4, -1/2] - 
    8*Log[2]*PolyLog[4, -1/3] + 4*Log[3]*PolyLog[4, -1/3] + 
    12*Log[2]*PolyLog[4, 1/3] - 5*Log[3]*PolyLog[4, 1/3] + 
    (64*Log[2]*PolyLog[4, 1/2])/3 - (56*Log[3]*PolyLog[4, 1/2])/3 - 
    30*Log[2]*PolyLog[4, 2/3] + 18*Log[3]*PolyLog[4, 2/3] + 
    (98*PolyLog[5, -1/2])/3 + 9*PolyLog[5, -1/3] - 9*PolyLog[5, 1/3] + 
    (350*PolyLog[5, 1/2])/9 + 28*PolyLog[5, 2/3] + 3*PolyLog[2, 3, -1/3] + 
    2*PolyLog[2, 3, 1/3] - (17*Pi^2*Zeta[3])/48 + (73*Log[2]^2*Zeta[3])/4 - 
    19*Log[2]*Log[3]*Zeta[3] + (23*Log[3]^2*Zeta[3])/4 - 
    (4*PolyLog[2, -1/2]*Zeta[3])/3 - (2083*Zeta[5])/144
 
G[1, 0, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 6*G[0, -1, 0, -1, -1, 1/2] - 
    6*G[0, 0, -1, 0, -1, 1/2] - (2*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (2123*Pi^4*Log[2])/6480 + (299*Pi^2*Log[2]^3)/324 + (113*Log[2]^5)/270 + 
    (77*Pi^4*Log[3])/270 - (109*Pi^2*Log[2]^2*Log[3])/36 - 
    (31*Log[2]^4*Log[3])/18 + (43*Pi^2*Log[2]*Log[3]^2)/12 - 
    (5*Log[2]^3*Log[3]^2)/6 - (47*Pi^2*Log[3]^3)/36 + 
    (29*Log[2]^2*Log[3]^3)/4 - (61*Log[2]*Log[3]^4)/8 + (12*Log[3]^5)/5 + 
    Log[2]^3*PolyLog[2, -1/2] - (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/6 + 3*Log[2]*PolyLog[2, -1/2]^2 - 
    2*Log[3]*PolyLog[2, -1/2]^2 - 6*Log[2]^2*PolyLog[3, -1/2] + 
    12*Log[2]*Log[3]*PolyLog[3, -1/2] - 6*Log[3]^2*PolyLog[3, -1/2] + 
    6*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/6 - 
    6*Log[2]^2*PolyLog[3, 1/3] + 22*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (27*Log[3]^2*PolyLog[3, 1/3])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    16*Log[2]*PolyLog[4, -1/2] + 8*Log[3]*PolyLog[4, -1/2] + 
    4*Log[2]*PolyLog[4, -1/3] - Log[3]*PolyLog[4, -1/3] + 
    10*Log[2]*PolyLog[4, 1/3] - 15*Log[3]*PolyLog[4, 1/3] - 
    (38*Log[2]*PolyLog[4, 1/2])/3 + (32*Log[3]*PolyLog[4, 1/2])/3 - 
    26*Log[2]*PolyLog[4, 2/3] + 34*Log[3]*PolyLog[4, 2/3] - 
    (86*PolyLog[5, -1/2])/3 - 2*PolyLog[5, -1/3] - 11*PolyLog[5, 1/3] - 
    (140*PolyLog[5, 1/2])/9 + 56*PolyLog[5, 2/3] - 2*PolyLog[2, 3, -1/3] + 
    30*PolyLog[2, 3, 1/3] + (11*Pi^2*Zeta[3])/24 - 
    (103*Log[2]^2*Zeta[3])/24 - (10*Log[2]*Log[3]*Zeta[3])/3 + 
    (23*Log[3]^2*Zeta[3])/6 + (13*PolyLog[2, -1/2]*Zeta[3])/3 - 
    (4627*Zeta[5])/72
 
G[1, 0, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] - 
    3*G[0, 0, -1, 0, -1, 1/2] - G[0, 0, 1, 0, -1, 1/2]/3 - 
    (259*Pi^4*Log[2])/1620 + (521*Pi^2*Log[2]^3)/648 + (127*Log[2]^5)/1080 + 
    (331*Pi^4*Log[3])/2160 - (85*Pi^2*Log[2]^2*Log[3])/36 - 
    (65*Log[2]^4*Log[3])/144 + (121*Pi^2*Log[2]*Log[3]^2)/48 - 
    (23*Log[2]^3*Log[3]^2)/12 - (41*Pi^2*Log[3]^3)/48 + 
    (143*Log[2]^2*Log[3]^3)/24 - (173*Log[2]*Log[3]^4)/32 + 
    (511*Log[3]^5)/320 - (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - 
    (Log[2]^3*PolyLog[2, -1/2])/6 - (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + Log[2]*PolyLog[2, -1/2]^2 - 
    Log[3]*PolyLog[2, -1/2]^2 - 4*Log[2]^2*PolyLog[3, -1/2] + 
    8*Log[2]*Log[3]*PolyLog[3, -1/2] - 4*Log[3]^2*PolyLog[3, -1/2] + 
    3*PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/12 - 
    (13*Log[2]^2*PolyLog[3, 1/3])/2 + (31*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - 
    (69*Log[3]^2*PolyLog[3, 1/3])/8 + PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    6*Log[2]*PolyLog[4, -1/2] + (5*Log[3]*PolyLog[4, -1/2])/2 + 
    (3*Log[2]*PolyLog[4, -1/3])/4 + (Log[3]*PolyLog[4, -1/3])/8 + 
    (15*Log[2]*PolyLog[4, 1/3])/2 - (37*Log[3]*PolyLog[4, 1/3])/4 - 
    9*Log[2]*PolyLog[4, 1/2] + (20*Log[3]*PolyLog[4, 1/2])/3 - 
    19*Log[2]*PolyLog[4, 2/3] + (45*Log[3]*PolyLog[4, 2/3])/2 - 
    (40*PolyLog[5, -1/2])/3 - (3*PolyLog[5, -1/3])/8 - 6*PolyLog[5, 1/3] - 
    (46*PolyLog[5, 1/2])/9 + 36*PolyLog[5, 2/3] - (7*PolyLog[2, 3, -1/3])/8 + 
    18*PolyLog[2, 3, 1/3] + (5*Pi^2*Zeta[3])/24 - (17*Log[2]^2*Zeta[3])/12 - 
    (83*Log[2]*Log[3]*Zeta[3])/24 + (257*Log[3]^2*Zeta[3])/96 + 
    (55*PolyLog[2, -1/2]*Zeta[3])/24 - (5827*Zeta[5])/144
 
G[1, 0, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (4*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (683*Pi^4*Log[2])/3240 - (95*Pi^2*Log[2]^3)/162 - (4*Log[2]^5)/27 - 
    (67*Pi^4*Log[3])/360 + (23*Pi^2*Log[2]^2*Log[3])/12 + 
    (5*Log[2]^4*Log[3])/4 - (7*Pi^2*Log[2]*Log[3]^2)/3 - 
    (Log[2]^3*Log[3]^2)/3 + (31*Pi^2*Log[3]^3)/36 - 
    (43*Log[2]^2*Log[3]^3)/12 + (53*Log[2]*Log[3]^4)/12 - (71*Log[3]^5)/48 - 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/2 - 2*Log[2]*PolyLog[2, -1/2]^2 + 
    2*Log[3]*PolyLog[2, -1/2]^2 + 4*Log[2]^2*PolyLog[3, -1/2] - 
    8*Log[2]*Log[3]*PolyLog[3, -1/2] + 4*Log[3]^2*PolyLog[3, -1/2] - 
    4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/6 + 
    3*Log[2]^2*PolyLog[3, 1/3] - 12*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    8*Log[3]^2*PolyLog[3, 1/3] - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    12*Log[2]*PolyLog[4, -1/2] - 6*Log[3]*PolyLog[4, -1/2] - 
    3*Log[2]*PolyLog[4, -1/3] + (3*Log[3]*PolyLog[4, -1/3])/2 - 
    4*Log[2]*PolyLog[4, 1/3] + 8*Log[3]*PolyLog[4, 1/3] + 
    12*Log[2]*PolyLog[4, 1/2] - 8*Log[3]*PolyLog[4, 1/2] + 
    16*Log[2]*PolyLog[4, 2/3] - 22*Log[3]*PolyLog[4, 2/3] + 
    (64*PolyLog[5, -1/2])/3 + (7*PolyLog[5, -1/3])/2 + 5*PolyLog[5, 1/3] + 
    (160*PolyLog[5, 1/2])/9 - 36*PolyLog[5, 2/3] + 
    (3*PolyLog[2, 3, -1/3])/2 - 20*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/4 + 
    4*Log[2]^2*Zeta[3] + (3*Log[2]*Log[3]*Zeta[3])/2 - 
    (19*Log[3]^2*Zeta[3])/8 - (13*PolyLog[2, -1/2]*Zeta[3])/6 + 
    (11651*Zeta[5])/288
 
G[1, 0, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (Log[2]^2*Log[3]^3)/12 - (Log[2]*Log[3]^4)/8 + 
    Log[3]^5/24 + (Log[3]^3*PolyLog[2, -1/2])/6 - (Log[3]^2*PolyLog[3, 1/3])/
     2 - Log[3]*PolyLog[4, 1/3] - PolyLog[5, 1/3]
 
G[1, 0, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + (Pi^4*Log[2])/9 - (Pi^2*Log[2]^3)/2 - 
    (9*Log[2]^5)/20 - (Pi^4*Log[3])/9 + (3*Pi^2*Log[2]^2*Log[3])/2 + 
    (11*Log[2]^4*Log[3])/12 - (3*Pi^2*Log[2]*Log[3]^2)/2 + 
    (5*Log[2]^3*Log[3]^2)/6 + (Pi^2*Log[3]^3)/2 - (7*Log[2]^2*Log[3]^3)/2 + 
    (37*Log[2]*Log[3]^4)/12 - (53*Log[3]^5)/60 - (Log[2]^3*PolyLog[2, -1/2])/
     3 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*
     PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    Log[2]*PolyLog[2, -1/2]^2 + Log[3]*PolyLog[2, -1/2]^2 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (9*Log[2]^2*PolyLog[3, 1/3])/2 - 9*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (9*Log[3]^2*PolyLog[3, 1/3])/2 - PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    5*Log[2]*PolyLog[4, 1/3] + 5*Log[3]*PolyLog[4, 1/3] + 
    14*Log[2]*PolyLog[4, 2/3] - 14*Log[3]*PolyLog[4, 2/3] + 
    4*PolyLog[5, -1/2] + 4*PolyLog[5, 1/3] - 24*PolyLog[5, 2/3] - 
    10*PolyLog[2, 3, 1/3] - 2*Log[2]^2*Zeta[3] + 4*Log[2]*Log[3]*Zeta[3] - 
    2*Log[3]^2*Zeta[3] + 24*Zeta[5]
 
G[1, 0, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    4*G[0, 0, -1, 0, -1, 1/2] + (31*Pi^4*Log[2])/216 + (Pi^2*Log[2]^3)/27 + 
    (3*Log[2]^5)/40 - (283*Pi^4*Log[3])/2160 + (11*Pi^2*Log[2]^2*Log[3])/72 + 
    (31*Log[2]^4*Log[3])/72 - (5*Pi^2*Log[2]*Log[3]^2)/8 - 
    (2*Log[2]^3*Log[3]^2)/3 + (11*Pi^2*Log[3]^3)/36 - (Log[2]^2*Log[3]^3)/2 + 
    (4*Log[2]*Log[3]^4)/3 - (11*Log[3]^5)/20 + (Pi^2*Log[2]*PolyLog[2, -1/2])/
     6 - (2*Log[2]^3*PolyLog[2, -1/2])/3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/
     12 + (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 + Log[3]*PolyLog[2, -1/2]^2 + 
    Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    Log[3]^2*PolyLog[3, -1/2] - 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/12 + (Log[2]^2*PolyLog[3, 1/3])/2 - 
    5*Log[2]*Log[3]*PolyLog[3, 1/3] + 4*Log[3]^2*PolyLog[3, 1/3] - 
    PolyLog[2, -1/2]*PolyLog[3, 1/3] + 11*Log[2]*PolyLog[4, -1/2] - 
    7*Log[3]*PolyLog[4, -1/2] - 2*Log[2]*PolyLog[4, -1/3] + 
    Log[3]*PolyLog[4, -1/3] - 5*Log[2]*PolyLog[4, 1/3] + 
    7*Log[3]*PolyLog[4, 1/3] + (16*Log[2]*PolyLog[4, 1/2])/3 - 
    (8*Log[3]*PolyLog[4, 1/2])/3 + 5*Log[2]*PolyLog[4, 2/3] - 
    9*Log[3]*PolyLog[4, 2/3] + 16*PolyLog[5, -1/2] + 9*PolyLog[5, 1/3] + 
    (14*PolyLog[5, 1/2])/3 - 19*PolyLog[5, 2/3] + PolyLog[2, 3, -1/3] - 
    11*PolyLog[2, 3, 1/3] - (11*Pi^2*Zeta[3])/48 + (43*Log[2]^2*Zeta[3])/12 - 
    (5*Log[2]*Log[3]*Zeta[3])/6 - (7*Log[3]^2*Zeta[3])/24 - 
    (11*PolyLog[2, -1/2]*Zeta[3])/4 + (4483*Zeta[5])/192
 
G[1, 0, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] - 
    3*G[0, 0, -1, 0, -1, 1/2] - (Pi^4*Log[2])/6 + (3*Pi^2*Log[2]^3)/4 + 
    (27*Log[2]^5)/40 + (Pi^4*Log[3])/6 - (9*Pi^2*Log[2]^2*Log[3])/4 - 
    (5*Log[2]^4*Log[3])/4 + (9*Pi^2*Log[2]*Log[3]^2)/4 - 
    (7*Log[2]^3*Log[3]^2)/4 - (3*Pi^2*Log[3]^3)/4 + 6*Log[2]^2*Log[3]^3 - 
    (41*Log[2]*Log[3]^4)/8 + (29*Log[3]^5)/20 + (Log[2]^3*PolyLog[2, -1/2])/
     2 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (3*Log[2]*PolyLog[2, -1/2]^2)/2 - 
    Log[3]*PolyLog[2, -1/2]^2 - 3*Log[2]^2*PolyLog[3, -1/2] + 
    6*Log[2]*Log[3]*PolyLog[3, -1/2] - 3*Log[3]^2*PolyLog[3, -1/2] + 
    3*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 7*Log[2]^2*PolyLog[3, 1/3] + 
    15*Log[2]*Log[3]*PolyLog[3, 1/3] - 8*Log[3]^2*PolyLog[3, 1/3] + 
    PolyLog[2, -1/2]*PolyLog[3, 1/3] + 9*Log[2]*PolyLog[4, 1/3] - 
    9*Log[3]*PolyLog[4, 1/3] - 21*Log[2]*PolyLog[4, 2/3] + 
    21*Log[3]*PolyLog[4, 2/3] - 6*PolyLog[5, -1/2] - 6*PolyLog[5, 1/3] + 
    36*PolyLog[5, 2/3] + 15*PolyLog[2, 3, 1/3] + 3*Log[2]^2*Zeta[3] - 
    6*Log[2]*Log[3]*Zeta[3] + 3*Log[3]^2*Zeta[3] - 36*Zeta[5]
 
G[1, 0, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - (Pi^4*Log[2])/45 + 
    (2*Pi^2*Log[2]^3)/9 + (2*Log[2]^5)/15 + (Pi^4*Log[3])/45 - 
    (2*Pi^2*Log[2]^2*Log[3])/3 - (Log[2]^4*Log[3])/8 + 
    (2*Pi^2*Log[2]*Log[3]^2)/3 - (5*Log[2]^3*Log[3]^2)/6 - 
    (2*Pi^2*Log[3]^3)/9 + (23*Log[2]^2*Log[3]^3)/12 - (3*Log[2]*Log[3]^4)/2 + 
    (49*Log[3]^5)/120 - (Log[2]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 + (Log[3]^3*PolyLog[2, -1/2])/6 - Log[2]^2*PolyLog[3, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] - Log[3]^2*PolyLog[3, -1/2] - 
    2*Log[2]^2*PolyLog[3, 1/3] + 4*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    2*Log[3]^2*PolyLog[3, 1/3] + Log[2]*PolyLog[4, -1/2] - 
    Log[3]*PolyLog[4, -1/2] + Log[2]*PolyLog[4, 1/3] - 
    Log[3]*PolyLog[4, 1/3] - 5*Log[2]*PolyLog[4, 2/3] + 
    5*Log[3]*PolyLog[4, 2/3] + 7*PolyLog[5, 2/3] + 3*PolyLog[2, 3, 1/3] + 
    (3*Log[2]^2*Zeta[3])/2 - 3*Log[2]*Log[3]*Zeta[3] + 
    (3*Log[3]^2*Zeta[3])/2 - 7*Zeta[5]
 
G[1, 0, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] + 
    6*G[0, 0, 1, 0, -1, 1/2] - (227*Pi^4*Log[2])/1440 + 
    (65*Pi^2*Log[2]^3)/72 + Log[2]^5/24 + (193*Pi^4*Log[3])/1440 - 
    (37*Pi^2*Log[2]^2*Log[3])/24 - (5*Log[2]^4*Log[3])/16 + 
    (23*Pi^2*Log[2]*Log[3]^2)/16 - (11*Log[2]^3*Log[3]^2)/4 - 
    (11*Pi^2*Log[3]^3)/24 + (43*Log[2]^2*Log[3]^3)/8 - 
    (367*Log[2]*Log[3]^4)/96 + (313*Log[3]^5)/320 - 
    (Pi^2*Log[2]*PolyLog[2, -1/2])/12 - (5*Log[2]^3*PolyLog[2, -1/2])/6 + 
    2*Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/6 - (Log[2]*PolyLog[2, -1/2]^2)/2 - 
    5*Log[2]^2*PolyLog[3, -1/2] + 6*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    2*Log[3]^2*PolyLog[3, -1/2] - 6*Log[2]^2*PolyLog[3, 1/3] + 
    (23*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (45*Log[3]^2*PolyLog[3, 1/3])/8 - 
    6*Log[2]*PolyLog[4, -1/2] - (3*Log[3]*PolyLog[4, -1/2])/2 - 
    (17*Log[2]*PolyLog[4, -1/3])/4 + (17*Log[3]*PolyLog[4, -1/3])/8 + 
    (23*Log[2]*PolyLog[4, 1/3])/2 - (41*Log[3]*PolyLog[4, 1/3])/4 - 
    8*Log[2]*PolyLog[4, 1/2] - 6*Log[3]*PolyLog[4, 1/2] - 
    16*Log[2]*PolyLog[4, 2/3] + (29*Log[3]*PolyLog[4, 2/3])/2 - 
    5*PolyLog[5, -1/2] + (27*PolyLog[5, -1/3])/8 - (23*PolyLog[5, 1/3])/2 + 
    2*PolyLog[5, 1/2] + 24*PolyLog[5, 2/3] - (7*PolyLog[2, 3, -1/3])/8 + 
    11*PolyLog[2, 3, 1/3] + (35*Pi^2*Zeta[3])/96 - (13*Log[2]^2*Zeta[3])/24 - 
    (95*Log[2]*Log[3]*Zeta[3])/24 + (143*Log[3]^2*Zeta[3])/96 + 
    (PolyLog[2, -1/2]*Zeta[3])/8 - (633*Zeta[5])/32
 
G[1, 0, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 7*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + (11*G[0, 0, 1, 0, -1, 1/2])/3 - 
    (4271*Pi^4*Log[2])/12960 + (911*Pi^2*Log[2]^3)/648 + 
    (1789*Log[2]^5)/1080 + (223*Pi^4*Log[3])/864 - 
    (43*Pi^2*Log[2]^2*Log[3])/9 - (229*Log[2]^4*Log[3])/72 + 
    (119*Pi^2*Log[2]*Log[3]^2)/24 - (7*Log[2]^3*Log[3]^2)/3 - 
    (79*Pi^2*Log[3]^3)/48 + (67*Log[2]^2*Log[3]^3)/6 - 
    (481*Log[2]*Log[3]^4)/48 + (229*Log[3]^5)/80 + 
    (4*Log[2]^3*PolyLog[2, -1/2])/3 - (Pi^2*Log[3]*PolyLog[2, -1/2])/6 - 
    3*Log[2]^2*Log[3]*PolyLog[2, -1/2] + 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/2 + (7*Log[2]*PolyLog[2, -1/2]^2)/2 - 
    3*Log[3]*PolyLog[2, -1/2]^2 + (Pi^2*PolyLog[3, -1/2])/3 - 
    5*Log[2]^2*PolyLog[3, -1/2] + 14*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    8*Log[3]^2*PolyLog[3, -1/2] + 6*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/3 - 12*Log[2]^2*PolyLog[3, 1/3] + 
    25*Log[2]*Log[3]*PolyLog[3, 1/3] - (51*Log[3]^2*PolyLog[3, 1/3])/4 + 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 8*Log[2]*PolyLog[4, -1/2] - 
    Log[3]*PolyLog[4, -1/2] - (3*Log[2]*PolyLog[4, -1/3])/2 + 
    (15*Log[3]*PolyLog[4, -1/3])/4 + 11*Log[2]*PolyLog[4, 1/3] - 
    (25*Log[3]*PolyLog[4, 1/3])/2 + 11*Log[2]*PolyLog[4, 1/2] - 
    (4*Log[3]*PolyLog[4, 1/2])/3 - 42*Log[2]*PolyLog[4, 2/3] + 
    44*Log[3]*PolyLog[4, 2/3] + (35*PolyLog[5, -1/2])/3 + 
    (17*PolyLog[5, -1/3])/2 - (31*PolyLog[5, 1/3])/2 + 
    (254*PolyLog[5, 1/2])/9 + 71*PolyLog[5, 2/3] + 
    (3*PolyLog[2, 3, -1/3])/4 + 22*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/6 + 
    (41*Log[2]^2*Zeta[3])/4 - (69*Log[2]*Log[3]*Zeta[3])/4 + 
    (135*Log[3]^2*Zeta[3])/16 + (55*PolyLog[2, -1/2]*Zeta[3])/24 - 
    (9007*Zeta[5])/144
 
G[1, 0, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := 4*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] + 4*G[0, 0, 1, 0, -1, 1/2] - 
    (211*Pi^4*Log[2])/864 + (32*Pi^2*Log[2]^3)/27 + (5*Log[2]^5)/6 + 
    (293*Pi^4*Log[3])/1440 - (10*Pi^2*Log[2]^2*Log[3])/3 - 
    (31*Log[2]^4*Log[3])/24 + (13*Pi^2*Log[2]*Log[3]^2)/4 - 
    (10*Log[2]^3*Log[3]^2)/3 - (25*Pi^2*Log[3]^3)/24 + 
    (107*Log[2]^2*Log[3]^3)/12 - (343*Log[2]*Log[3]^4)/48 + 
    (931*Log[3]^5)/480 - (Pi^2*Log[2]*PolyLog[2, -1/2])/12 - 
    (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 - (Log[3]^3*PolyLog[2, -1/2])/6 + (3*Log[2]*PolyLog[2, -1/2]^2)/2 - 
    (3*Log[3]*PolyLog[2, -1/2]^2)/2 + (Pi^2*PolyLog[3, -1/2])/6 - 
    6*Log[2]^2*PolyLog[3, -1/2] + 10*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    5*Log[3]^2*PolyLog[3, -1/2] + 4*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/6 - 11*Log[2]^2*PolyLog[3, 1/3] + 
    19*Log[2]*Log[3]*PolyLog[3, 1/3] - (37*Log[3]^2*PolyLog[3, 1/3])/4 + 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + Log[3]*PolyLog[4, -1/2] - 
    (7*Log[2]*PolyLog[4, -1/3])/2 + (13*Log[3]*PolyLog[4, -1/3])/4 + 
    12*Log[2]*PolyLog[4, 1/3] - (23*Log[3]*PolyLog[4, 1/3])/2 + 
    (5*Log[2]*PolyLog[4, 1/2])/3 - Log[3]*PolyLog[4, 1/2] - 
    31*Log[2]*PolyLog[4, 2/3] + 30*Log[3]*PolyLog[4, 2/3] + 
    8*PolyLog[5, -1/2] + (27*PolyLog[5, -1/3])/4 - 13*PolyLog[5, 1/3] + 
    (64*PolyLog[5, 1/2])/3 + 50*PolyLog[5, 2/3] + PolyLog[2, 3, -1/3]/4 + 
    16*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/16 + (67*Log[2]^2*Zeta[3])/12 - 
    (28*Log[2]*Log[3]*Zeta[3])/3 + (211*Log[3]^2*Zeta[3])/48 + 
    (7*PolyLog[2, -1/2]*Zeta[3])/4 - (4169*Zeta[5])/96
 
G[1, 0, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -7*G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] + (13*G[0, 0, 1, 0, -1, 1/2])/3 + 
    (673*Pi^4*Log[2])/6480 - (425*Pi^2*Log[2]^3)/648 + Log[2]^5/54 - 
    (53*Pi^4*Log[3])/720 + (19*Pi^2*Log[2]^2*Log[3])/8 + 
    (73*Log[2]^4*Log[3])/48 - (131*Pi^2*Log[2]*Log[3]^2)/48 - 
    (13*Log[2]^3*Log[3]^2)/6 + (143*Pi^2*Log[3]^3)/144 - 
    (15*Log[2]^2*Log[3]^3)/8 + (379*Log[2]*Log[3]^4)/96 - 
    (1429*Log[3]^5)/960 - (Pi^2*Log[2]*PolyLog[2, -1/2])/6 - 
    (5*Log[2]^3*PolyLog[2, -1/2])/6 + (Pi^2*Log[3]*PolyLog[2, -1/2])/6 + 
    3*Log[2]^2*Log[3]*PolyLog[2, -1/2] - 3*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (5*Log[3]^3*PolyLog[2, -1/2])/6 - (5*Log[2]*PolyLog[2, -1/2]^2)/2 + 
    3*Log[3]*PolyLog[2, -1/2]^2 - (Pi^2*PolyLog[3, -1/2])/3 + 
    5*Log[2]^2*PolyLog[3, -1/2] - 10*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    6*Log[3]^2*PolyLog[3, -1/2] - 3*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/3 - Log[2]^2*PolyLog[3, 1/3] - 
    (11*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + (45*Log[3]^2*PolyLog[3, 1/3])/8 - 
    4*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 13*Log[2]*PolyLog[4, -1/2] - 
    (7*Log[3]*PolyLog[4, -1/2])/2 - (15*Log[2]*PolyLog[4, -1/3])/4 + 
    (15*Log[3]*PolyLog[4, -1/3])/8 + (17*Log[2]*PolyLog[4, 1/3])/2 - 
    (11*Log[3]*PolyLog[4, 1/3])/4 + 19*Log[2]*PolyLog[4, 1/2] - 
    18*Log[3]*PolyLog[4, 1/2] + 12*Log[2]*PolyLog[4, 2/3] - 
    (43*Log[3]*PolyLog[4, 2/3])/2 + (58*PolyLog[5, -1/2])/3 + 
    (67*PolyLog[5, -1/3])/8 - 13*PolyLog[5, 1/3] + (268*PolyLog[5, 1/2])/9 - 
    27*PolyLog[5, 2/3] + (15*PolyLog[2, 3, -1/3])/8 - 17*PolyLog[2, 3, 1/3] - 
    (Pi^2*Zeta[3])/48 + (13*Log[2]^2*Zeta[3])/2 - (9*Log[2]*Log[3]*Zeta[3])/
     8 - (103*Log[3]^2*Zeta[3])/32 + (11*PolyLog[2, -1/2]*Zeta[3])/24 + 
    (21163*Zeta[5])/576
 
G[1, 0, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + (Pi^4*Log[2])/18 - (13*Pi^2*Log[2]^3)/36 - 
    (7*Log[2]^5)/24 - (7*Pi^4*Log[3])/90 + (11*Pi^2*Log[2]^2*Log[3])/12 + 
    (Log[2]^4*Log[3])/3 - (3*Pi^2*Log[2]*Log[3]^2)/4 + 
    (7*Log[2]^3*Log[3]^2)/6 + (7*Pi^2*Log[3]^3)/36 - 
    (31*Log[2]^2*Log[3]^3)/12 + (43*Log[2]*Log[3]^4)/24 - (5*Log[3]^5)/12 - 
    (Log[2]^3*PolyLog[2, -1/2])/6 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + Log[2]^2*PolyLog[3, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] - PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (7*Log[2]^2*PolyLog[3, 1/3])/2 - 7*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (5*Log[3]^2*PolyLog[3, 1/3])/2 - 2*Log[2]*PolyLog[4, -1/2] - 
    5*Log[2]*PolyLog[4, 1/3] + 3*Log[3]*PolyLog[4, 1/3] + 
    9*Log[2]*PolyLog[4, 2/3] - 7*Log[3]*PolyLog[4, 2/3] - 
    14*PolyLog[5, 2/3] - 7*PolyLog[2, 3, 1/3] - 2*Log[2]^2*Zeta[3] + 
    2*Log[2]*Log[3]*Zeta[3] + 14*Zeta[5]
 
G[1, 0, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -4*G[0, -1, 0, -1, -1, 1/2] + (Pi^4*Log[2])/9 - 
    (13*Pi^2*Log[2]^3)/18 - (79*Log[2]^5)/120 - (Pi^4*Log[3])/9 + 
    (13*Pi^2*Log[2]^2*Log[3])/6 + (35*Log[2]^4*Log[3])/24 - 
    (13*Pi^2*Log[2]*Log[3]^2)/6 + (3*Log[2]^3*Log[3]^2)/4 + 
    (13*Pi^2*Log[3]^3)/18 - (53*Log[2]^2*Log[3]^3)/12 + 
    (97*Log[2]*Log[3]^4)/24 - (47*Log[3]^5)/40 - (Log[2]^3*PolyLog[2, -1/2])/
     2 + (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (3*Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/2 - 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 + (3*Log[3]*PolyLog[2, -1/2]^2)/2 + 
    3*Log[2]^2*PolyLog[3, -1/2] - 6*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    3*Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    5*Log[2]^2*PolyLog[3, 1/3] - 10*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    5*Log[3]^2*PolyLog[3, 1/3] - 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    2*Log[2]*PolyLog[4, -1/2] + 2*Log[3]*PolyLog[4, -1/2] - 
    2*Log[2]*PolyLog[4, 1/3] + 2*Log[3]*PolyLog[4, 1/3] + 
    18*Log[2]*PolyLog[4, 2/3] - 18*Log[3]*PolyLog[4, 2/3] - 
    28*PolyLog[5, 2/3] - 12*PolyLog[2, 3, 1/3] - 4*Log[2]^2*Zeta[3] + 
    8*Log[2]*Log[3]*Zeta[3] - 4*Log[3]^2*Zeta[3] + 28*Zeta[5]
 
G[1, 0, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -3*G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + 2*G[0, 0, 1, 0, -1, 1/2] + 
    (43*Pi^4*Log[2])/480 - (5*Pi^2*Log[2]^3)/72 - (23*Log[2]^5)/120 - 
    (41*Pi^4*Log[3])/720 + (17*Pi^2*Log[2]^2*Log[3])/24 + 
    (2*Log[2]^4*Log[3])/3 - (11*Pi^2*Log[2]*Log[3]^2)/12 - 
    (3*Log[2]^3*Log[3]^2)/4 + (3*Pi^2*Log[3]^3)/8 - (2*Log[2]^2*Log[3]^3)/3 + 
    (11*Log[2]*Log[3]^4)/8 - (13*Log[3]^5)/24 - (2*Log[2]^3*PolyLog[2, -1/2])/
     3 + (Pi^2*Log[3]*PolyLog[2, -1/2])/12 + 2*Log[2]^2*Log[3]*
     PolyLog[2, -1/2] - 2*Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/2 - (3*Log[2]*PolyLog[2, -1/2]^2)/2 + 
    (3*Log[3]*PolyLog[2, -1/2]^2)/2 - (Pi^2*PolyLog[3, -1/2])/6 + 
    Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]^2*PolyLog[3, -1/2] - 3*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/6 + Log[2]^2*PolyLog[3, 1/3] - 
    2*Log[2]*Log[3]*PolyLog[3, 1/3] + 2*Log[3]^2*PolyLog[3, 1/3] - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 3*Log[2]*PolyLog[4, -1/2] - 
    3*Log[3]*PolyLog[4, -1/2] + Log[2]*PolyLog[4, 1/2] - 
    4*Log[3]*PolyLog[4, 1/2] + 6*Log[2]*PolyLog[4, 2/3] - 
    9*Log[3]*PolyLog[4, 2/3] - PolyLog[5, 1/3] - 2*PolyLog[5, 1/2] - 
    14*PolyLog[5, 2/3] - 6*PolyLog[2, 3, 1/3] + (23*Pi^2*Zeta[3])/96 - 
    (Log[2]^2*Zeta[3])/8 + (Log[2]*Log[3]*Zeta[3])/4 - 
    (25*Log[3]^2*Zeta[3])/16 - (7*PolyLog[2, -1/2]*Zeta[3])/8 + 
    (919*Zeta[5])/64
 
G[1, 0, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, -1, 0, -1, -1, 1/2] - (Pi^4*Log[2])/10 + 
    (5*Pi^2*Log[2]^3)/12 + (29*Log[2]^5)/60 + (Pi^4*Log[3])/15 - 
    (3*Pi^2*Log[2]^2*Log[3])/2 - (11*Log[2]^4*Log[3])/8 + 
    (7*Pi^2*Log[2]*Log[3]^2)/4 + (Log[2]^3*Log[3]^2)/6 - 
    (2*Pi^2*Log[3]^3)/3 + (35*Log[2]^2*Log[3]^3)/12 - 
    (13*Log[2]*Log[3]^4)/4 + (127*Log[3]^5)/120 + 
    (2*Log[2]^3*PolyLog[2, -1/2])/3 - (3*Log[2]^2*Log[3]*PolyLog[2, -1/2])/
     2 + Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (3*Log[2]*PolyLog[2, -1/2]^2)/2 - (3*Log[3]*PolyLog[2, -1/2]^2)/2 - 
    2*Log[2]^2*PolyLog[3, -1/2] + 6*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    4*Log[3]^2*PolyLog[3, -1/2] + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    2*Log[2]^2*PolyLog[3, 1/3] + 6*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    4*Log[3]^2*PolyLog[3, 1/3] + 2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    12*Log[2]*PolyLog[4, 2/3] + 15*Log[3]*PolyLog[4, 2/3] + 
    21*PolyLog[5, 2/3] + 6*PolyLog[2, 3, 1/3] + (3*Log[2]^2*Zeta[3])/2 - 
    6*Log[2]*Log[3]*Zeta[3] + (9*Log[3]^2*Zeta[3])/2 - 21*Zeta[5]
 
G[1, 0, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^4*Log[2])/90 + (5*Pi^2*Log[2]^3)/36 + 
    Log[2]^5/12 + (Pi^4*Log[3])/90 - (5*Pi^2*Log[2]^2*Log[3])/12 - 
    (Log[2]^4*Log[3])/12 + (5*Pi^2*Log[2]*Log[3]^2)/12 - 
    (Log[2]^3*Log[3]^2)/2 - (5*Pi^2*Log[3]^3)/36 + (7*Log[2]^2*Log[3]^3)/6 - 
    (11*Log[2]*Log[3]^4)/12 + Log[3]^5/4 - (Log[2]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 + (Log[3]^3*PolyLog[2, -1/2])/6 - Log[2]^2*PolyLog[3, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] - Log[3]^2*PolyLog[3, -1/2] - 
    Log[2]^2*PolyLog[3, 1/3] + 2*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    Log[3]^2*PolyLog[3, 1/3] - 3*Log[2]*PolyLog[4, 2/3] + 
    3*Log[3]*PolyLog[4, 2/3] + 4*PolyLog[5, 2/3] + Log[2]^2*Zeta[3] - 
    2*Log[2]*Log[3]*Zeta[3] + Log[3]^2*Zeta[3] - 4*Zeta[5]
 
G[1, 1, -1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (7*Pi^4*Log[2])/720 + (Pi^2*Log[2]^3)/9 + 
    Log[2]^5/60 - (Pi^4*Log[3])/90 - (Pi^2*Log[2]^2*Log[3])/4 + 
    (Pi^2*Log[2]*Log[3]^2)/12 - (Log[2]^3*Log[3]^2)/6 + 
    (Log[2]^2*Log[3]^3)/3 - (Log[2]*Log[3]^4)/8 - 
    (3*Log[2]^2*PolyLog[3, 1/3])/2 + Log[2]*Log[3]*PolyLog[3, 1/3] + 
    Log[2]*PolyLog[4, -1/2] + Log[2]*PolyLog[4, 1/3] - 
    Log[2]*PolyLog[4, 1/2] + Log[3]*PolyLog[4, 1/2] - 
    Log[2]*PolyLog[4, 2/3] - PolyLog[5, 1/2] - PolyLog[2, 3, 1/3] - 
    (Pi^2*Zeta[3])/12 + Log[2]^2*Zeta[3] + (63*Zeta[5])/32
 
G[1, 1, -1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, -1, 0, -1, 1/2] - 3*G[0, 0, 1, 0, -1, 1/2] - 
    (5*Pi^4*Log[2])/72 - (7*Pi^2*Log[2]^3)/108 - (13*Log[2]^5)/18 + 
    (211*Pi^4*Log[3])/4320 - (Pi^2*Log[2]^2*Log[3])/72 - 
    (7*Log[2]^4*Log[3])/144 + (31*Pi^2*Log[2]*Log[3]^2)/48 + 
    (13*Log[2]^3*Log[3]^2)/6 - (25*Pi^2*Log[3]^3)/72 - 
    (11*Log[2]^2*Log[3]^3)/8 - (79*Log[2]*Log[3]^4)/96 + (181*Log[3]^5)/320 + 
    (Log[2]^3*PolyLog[2, -1/2])/3 - Log[2]^2*Log[3]*PolyLog[2, -1/2] + 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] - (Log[3]^3*PolyLog[2, -1/2])/3 + 
    Log[2]*PolyLog[2, -1/2]^2 - Log[3]*PolyLog[2, -1/2]^2 - 
    2*Log[2]^2*PolyLog[3, -1/2] + 4*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    2*Log[3]^2*PolyLog[3, -1/2] + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/6 + 5*Log[2]^2*PolyLog[3, 1/3] + 
    (3*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (29*Log[3]^2*PolyLog[3, 1/3])/8 + 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 18*Log[2]*PolyLog[4, -1/2] + 
    (15*Log[3]*PolyLog[4, -1/2])/2 + (19*Log[2]*PolyLog[4, -1/3])/4 - 
    (19*Log[3]*PolyLog[4, -1/3])/8 - (5*Log[2]*PolyLog[4, 1/3])/2 - 
    (13*Log[3]*PolyLog[4, 1/3])/4 - (59*Log[2]*PolyLog[4, 1/2])/3 + 
    (40*Log[3]*PolyLog[4, 1/2])/3 + 4*Log[2]*PolyLog[4, 2/3] + 
    (13*Log[3]*PolyLog[4, 2/3])/2 - 25*PolyLog[5, -1/2] - 
    (73*PolyLog[5, -1/3])/8 + (7*PolyLog[5, 1/3])/2 - 
    (89*PolyLog[5, 1/2])/3 + 5*PolyLog[5, 2/3] - (19*PolyLog[2, 3, -1/3])/8 + 
    11*PolyLog[2, 3, 1/3] + (11*Pi^2*Zeta[3])/48 - 
    (277*Log[2]^2*Zeta[3])/24 + (37*Log[2]*Log[3]*Zeta[3])/6 - 
    (7*Log[3]^2*Zeta[3])/96 - (715*Zeta[5])/48
 
G[1, 1, -1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] - (11*Pi^4*Log[2])/240 + (5*Pi^2*Log[2]^3)/18 + 
    (29*Log[2]^5)/120 + (23*Pi^4*Log[3])/480 - (7*Pi^2*Log[2]^2*Log[3])/8 - 
    (Log[2]^4*Log[3])/2 + (5*Pi^2*Log[2]*Log[3]^2)/6 - 
    (5*Log[2]^3*Log[3]^2)/12 - (5*Pi^2*Log[3]^3)/18 + 
    (23*Log[2]^2*Log[3]^3)/12 - (5*Log[2]*Log[3]^4)/3 + (19*Log[3]^5)/40 + 
    (Log[2]^3*PolyLog[2, -1/2])/6 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]*PolyLog[2, -1/2]^2)/2 - (Log[3]*PolyLog[2, -1/2]^2)/2 - 
    Log[2]^2*PolyLog[3, -1/2] + 2*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    Log[3]^2*PolyLog[3, -1/2] + PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/12 - 3*Log[2]^2*PolyLog[3, 1/3] + 
    5*Log[2]*Log[3]*PolyLog[3, 1/3] - (5*Log[3]^2*PolyLog[3, 1/3])/2 + 
    PolyLog[2, -1/2]*PolyLog[3, 1/3] + 3*Log[2]*PolyLog[4, 1/3] - 
    3*Log[3]*PolyLog[4, 1/3] - 7*Log[2]*PolyLog[4, 2/3] + 
    7*Log[3]*PolyLog[4, 2/3] - 3*PolyLog[5, -1/2] - 3*PolyLog[5, 1/3] + 
    11*PolyLog[5, 2/3] + 4*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/12 + 
    (31*Log[2]^2*Zeta[3])/16 - (23*Log[2]*Log[3]*Zeta[3])/8 + 
    (23*Log[3]^2*Zeta[3])/16 - (675*Zeta[5])/64
 
G[1, 1, -1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] + 
    2*G[0, 0, -1, 0, -1, 1/2] + 5*G[0, 0, 1, 0, -1, 1/2] + 
    (11*Pi^4*Log[2])/480 + (5*Pi^2*Log[2]^3)/72 + (4*Log[2]^5)/5 - 
    (3*Pi^4*Log[3])/160 + (Pi^2*Log[2]^2*Log[3])/6 - (5*Log[2]^4*Log[3])/48 - 
    (13*Pi^2*Log[2]*Log[3]^2)/16 - (13*Log[2]^3*Log[3]^2)/6 + 
    (53*Pi^2*Log[3]^3)/144 + (31*Log[2]^2*Log[3]^3)/24 + 
    (29*Log[2]*Log[3]^4)/32 - (563*Log[3]^5)/960 - 
    (Log[2]^3*PolyLog[2, -1/2])/3 + Log[2]^2*Log[3]*PolyLog[2, -1/2] - 
    Log[2]*Log[3]^2*PolyLog[2, -1/2] + (Log[3]^3*PolyLog[2, -1/2])/3 - 
    Log[2]*PolyLog[2, -1/2]^2 + Log[3]*PolyLog[2, -1/2]^2 + 
    2*Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    2*Log[3]^2*PolyLog[3, -1/2] - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/6 - 5*Log[2]^2*PolyLog[3, 1/3] - 
    (Log[2]*Log[3]*PolyLog[3, 1/3])/2 + (27*Log[3]^2*PolyLog[3, 1/3])/8 - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] + 18*Log[2]*PolyLog[4, -1/2] - 
    (15*Log[3]*PolyLog[4, -1/2])/2 - (19*Log[2]*PolyLog[4, -1/3])/4 + 
    (19*Log[3]*PolyLog[4, -1/3])/8 + (13*Log[2]*PolyLog[4, 1/3])/2 + 
    (5*Log[3]*PolyLog[4, 1/3])/4 + 23*Log[2]*PolyLog[4, 1/2] - 
    17*Log[3]*PolyLog[4, 1/2] - 6*Log[2]*PolyLog[4, 2/3] - 
    (11*Log[3]*PolyLog[4, 2/3])/2 + 26*PolyLog[5, -1/2] + 
    (91*PolyLog[5, -1/3])/8 - (19*PolyLog[5, 1/3])/2 + 38*PolyLog[5, 1/2] + 
    PolyLog[5, 2/3] + (21*PolyLog[2, 3, -1/3])/8 - 13*PolyLog[2, 3, 1/3] - 
    (49*Pi^2*Zeta[3])/96 + (81*Log[2]^2*Zeta[3])/8 - 
    (29*Log[2]*Log[3]*Zeta[3])/8 - (5*Log[3]^2*Zeta[3])/32 + 
    (2515*Zeta[5])/192
 
G[1, 1, -1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, 0, 1, 0, -1, 1/2] - 
    (53*Pi^4*Log[2])/1440 + (11*Pi^2*Log[2]^3)/24 + (73*Log[2]^5)/60 + 
    (11*Pi^4*Log[3])/160 - (3*Pi^2*Log[2]^2*Log[3])/2 - 
    (11*Log[2]^4*Log[3])/12 + (25*Pi^2*Log[2]*Log[3]^2)/24 - 
    (17*Log[2]^3*Log[3]^2)/6 - (11*Pi^2*Log[3]^3)/48 + 
    (59*Log[2]^2*Log[3]^3)/12 - (125*Log[2]*Log[3]^4)/48 + 
    (113*Log[3]^5)/240 - (17*Log[2]^2*PolyLog[3, 1/3])/2 + 
    8*Log[2]*Log[3]*PolyLog[3, 1/3] - (9*Log[3]^2*PolyLog[3, 1/3])/4 + 
    17*Log[2]*PolyLog[4, -1/2] - 8*Log[3]*PolyLog[4, -1/2] - 
    (9*Log[2]*PolyLog[4, -1/3])/2 + 2*Log[3]*PolyLog[4, -1/3] + 
    8*Log[2]*PolyLog[4, 1/3] - 6*Log[3]*PolyLog[4, 1/3] + 
    23*Log[2]*PolyLog[4, 1/2] - 14*Log[3]*PolyLog[4, 1/2] - 
    17*Log[2]*PolyLog[4, 2/3] + 9*Log[3]*PolyLog[4, 2/3] + 
    21*PolyLog[5, -1/2] + (21*PolyLog[5, -1/3])/4 - 12*PolyLog[5, 1/3] + 
    36*PolyLog[5, 1/2] + 18*PolyLog[5, 2/3] + (9*PolyLog[2, 3, -1/3])/4 - 
    PolyLog[2, 3, 1/3] - (3*Pi^2*Zeta[3])/8 + (211*Log[2]^2*Zeta[3])/16 - 
    (21*Log[2]*Log[3]*Zeta[3])/2 + (39*Log[3]^2*Zeta[3])/16 - (793*Zeta[5])/64
 
G[1, 1, -1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + 3*G[0, 0, 1, 0, -1, 1/2] - (Pi^4*Log[2])/288 + 
    (35*Pi^2*Log[2]^3)/216 + (19*Log[2]^5)/18 + (67*Pi^4*Log[3])/2160 - 
    (4*Pi^2*Log[2]^2*Log[3])/9 - (89*Log[2]^4*Log[3])/144 + 
    (Pi^2*Log[2]*Log[3]^2)/24 - (29*Log[2]^3*Log[3]^2)/12 + 
    (Pi^2*Log[3]^3)/24 + (71*Log[2]^2*Log[3]^3)/24 - 
    (37*Log[2]*Log[3]^4)/48 - (59*Log[3]^5)/960 - (Log[2]^3*PolyLog[2, -1/2])/
     6 + (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + (Log[3]*PolyLog[2, -1/2]^2)/2 + 
    Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    Log[3]^2*PolyLog[3, -1/2] - PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (13*Log[2]^2*PolyLog[3, 1/3])/2 + (7*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (5*Log[3]^2*PolyLog[3, 1/3])/8 - PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    17*Log[2]*PolyLog[4, -1/2] - (15*Log[3]*PolyLog[4, -1/2])/2 - 
    (9*Log[2]*PolyLog[4, -1/3])/2 + (17*Log[3]*PolyLog[4, -1/3])/8 + 
    7*Log[2]*PolyLog[4, 1/3] - (9*Log[3]*PolyLog[4, 1/3])/4 + 
    (74*Log[2]*PolyLog[4, 1/2])/3 - (55*Log[3]*PolyLog[4, 1/2])/3 - 
    11*Log[2]*PolyLog[4, 2/3] + (3*Log[3]*PolyLog[4, 2/3])/2 + 
    22*PolyLog[5, -1/2] + (75*PolyLog[5, -1/3])/8 - 13*PolyLog[5, 1/3] + 
    (113*PolyLog[5, 1/2])/3 + 9*PolyLog[5, 2/3] + (19*PolyLog[2, 3, -1/3])/
     8 - 7*PolyLog[2, 3, 1/3] - (19*Pi^2*Zeta[3])/48 + 
    (149*Log[2]^2*Zeta[3])/12 - (235*Log[2]*Log[3]*Zeta[3])/24 + 
    (223*Log[3]^2*Zeta[3])/96 + (73*Zeta[5])/192
 
G[1, 1, -1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + 
    G[0, 0, -1, 0, -1, 1/2] + (Pi^4*Log[2])/18 - (23*Pi^2*Log[2]^3)/72 - 
    (37*Log[2]^5)/120 - (89*Pi^4*Log[3])/1440 + (25*Pi^2*Log[2]^2*Log[3])/
     24 + (Log[2]^4*Log[3])/2 - (9*Pi^2*Log[2]*Log[3]^2)/8 + 
    (5*Log[2]^3*Log[3]^2)/6 + (13*Pi^2*Log[3]^3)/36 - 
    (31*Log[2]^2*Log[3]^3)/12 + (53*Log[2]*Log[3]^4)/24 - (5*Log[3]^5)/8 - 
    (Log[2]^3*PolyLog[2, -1/2])/6 + (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + (Log[3]*PolyLog[2, -1/2]^2)/2 + 
    Log[2]^2*PolyLog[3, -1/2] - 2*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    Log[3]^2*PolyLog[3, -1/2] - PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/12 + (5*Log[2]^2*PolyLog[3, 1/3])/2 - 
    5*Log[2]*Log[3]*PolyLog[3, 1/3] + 3*Log[3]^2*PolyLog[3, 1/3] - 
    PolyLog[2, -1/2]*PolyLog[3, 1/3] - 2*Log[2]*PolyLog[4, -1/2] + 
    2*Log[3]*PolyLog[4, -1/2] + Log[2]*PolyLog[4, 1/3] + 
    2*Log[3]*PolyLog[4, 1/3] + 9*Log[2]*PolyLog[4, 2/3] - 
    9*Log[3]*PolyLog[4, 2/3] + 3*PolyLog[5, 1/2] - 14*PolyLog[5, 2/3] - 
    7*PolyLog[2, 3, 1/3] - (Pi^2*Zeta[3])/6 - (23*Log[2]^2*Zeta[3])/8 + 
    (23*Log[2]*Log[3]*Zeta[3])/4 - (15*Log[3]^2*Zeta[3])/8 + (873*Zeta[5])/64
 
G[1, 1, -1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    G[0, 0, -1, 0, -1, 1/2] - (19*Pi^4*Log[2])/480 + (67*Pi^2*Log[2]^3)/216 + 
    (14*Log[2]^5)/45 + (119*Pi^4*Log[3])/2160 - (19*Pi^2*Log[2]^2*Log[3])/
     18 - (73*Log[2]^4*Log[3])/144 + (49*Pi^2*Log[2]*Log[3]^2)/48 - 
    (7*Log[2]^3*Log[3]^2)/12 - (7*Pi^2*Log[3]^3)/24 + 
    (55*Log[2]^2*Log[3]^3)/24 - (67*Log[2]*Log[3]^4)/32 + 
    (113*Log[3]^5)/192 + (Log[2]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 - (Log[3]^3*PolyLog[2, -1/2])/6 + (Log[2]*PolyLog[2, -1/2]^2)/2 - 
    (Log[3]*PolyLog[2, -1/2]^2)/2 - Log[2]^2*PolyLog[3, -1/2] + 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] - Log[3]^2*PolyLog[3, -1/2] + 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] - (5*Log[2]^2*PolyLog[3, 1/3])/2 + 
    (13*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (31*Log[3]^2*PolyLog[3, 1/3])/8 + 
    PolyLog[2, -1/2]*PolyLog[3, 1/3] + Log[2]*PolyLog[4, -1/2] - 
    (3*Log[3]*PolyLog[4, -1/2])/2 + (Log[2]*PolyLog[4, -1/3])/4 - 
    (Log[3]*PolyLog[4, -1/3])/8 + (9*Log[2]*PolyLog[4, 1/3])/2 - 
    (31*Log[3]*PolyLog[4, 1/3])/4 + (7*Log[2]*PolyLog[4, 1/2])/3 + 
    (Log[3]*PolyLog[4, 1/2])/3 - 8*Log[2]*PolyLog[4, 2/3] + 
    (17*Log[3]*PolyLog[4, 2/3])/2 - PolyLog[5, -1/2] - 
    (27*PolyLog[5, -1/3])/8 - (13*PolyLog[5, 1/3])/2 + 
    (16*PolyLog[5, 1/2])/3 + 12*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3]/8 + 
    7*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/48 + (41*Log[2]^2*Zeta[3])/24 - 
    (59*Log[2]*Log[3]*Zeta[3])/24 + (47*Log[3]^2*Zeta[3])/96 - (89*Zeta[5])/6
 
G[1, 1, -1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2]^3)/24 + Log[2]^5/12 + 
    (Pi^2*Log[2]^2*Log[3])/12 - (Log[2]^4*Log[3])/6 - 
    (Pi^2*Log[2]*Log[3]^2)/24 + (Log[2]^3*Log[3]^2)/12 - 
    (Log[2]^2*PolyLog[3, 1/3])/2 + Log[2]*Log[3]*PolyLog[3, 1/3] - 
    (Log[3]^2*PolyLog[3, 1/3])/2 + 3*Log[2]*PolyLog[4, 1/3] - 
    3*Log[3]*PolyLog[4, 1/3] + 3*Log[2]*PolyLog[4, 1/2] - 
    3*Log[3]*PolyLog[4, 1/2] - 6*PolyLog[5, 1/3] + 6*PolyLog[5, 1/2] + 
    (7*Log[2]^2*Zeta[3])/16 - (7*Log[2]*Log[3]*Zeta[3])/8 + 
    (7*Log[3]^2*Zeta[3])/16
 
G[1, 1, 0, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -6*G[0, 0, 1, 0, -1, 1/2] + 
    (47*Pi^4*Log[2])/360 - (103*Pi^2*Log[2]^3)/216 - (17*Log[2]^5)/72 - 
    (517*Pi^4*Log[3])/4320 + (7*Pi^2*Log[2]^2*Log[3])/18 + 
    (115*Log[2]^4*Log[3])/144 - (11*Pi^2*Log[2]*Log[3]^2)/48 + 
    (11*Log[2]^3*Log[3]^2)/12 + (5*Pi^2*Log[3]^3)/48 - 
    (53*Log[2]^2*Log[3]^3)/24 + (45*Log[2]*Log[3]^4)/32 - 
    (109*Log[3]^5)/320 + 2*Log[2]^2*PolyLog[3, -1/2] - 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] + (Log[3]^2*PolyLog[3, -1/2])/2 + 
    2*Log[2]^2*PolyLog[3, 1/3] - (9*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (19*Log[3]^2*PolyLog[3, 1/3])/8 + 2*Log[2]*PolyLog[4, -1/2] + 
    (3*Log[3]*PolyLog[4, -1/2])/2 + (17*Log[2]*PolyLog[4, -1/3])/4 - 
    (17*Log[3]*PolyLog[4, -1/3])/8 - (23*Log[2]*PolyLog[4, 1/3])/2 + 
    (33*Log[3]*PolyLog[4, 1/3])/4 - (4*Log[2]*PolyLog[4, 1/2])/3 + 
    (29*Log[3]*PolyLog[4, 1/2])/3 + 10*Log[2]*PolyLog[4, 2/3] - 
    (15*Log[3]*PolyLog[4, 2/3])/2 - (45*PolyLog[5, -1/3])/8 + 
    (27*PolyLog[5, 1/3])/2 - (43*PolyLog[5, 1/2])/3 - 18*PolyLog[5, 2/3] + 
    (5*PolyLog[2, 3, -1/3])/8 - 5*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/48 + 
    (151*Log[2]^2*Zeta[3])/48 - (31*Log[2]*Log[3]*Zeta[3])/12 + 
    (65*Log[3]^2*Zeta[3])/96 + (919*Zeta[5])/64
 
G[1, 1, 0, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -2*G[0, -1, 0, -1, -1, 1/2] - 
    7*G[0, 0, 1, 0, -1, 1/2] + (25*Pi^4*Log[2])/144 - (89*Pi^2*Log[2]^3)/72 - 
    (331*Log[2]^5)/120 - (379*Pi^4*Log[3])/2160 + (299*Pi^2*Log[2]^2*Log[3])/
     72 + (389*Log[2]^4*Log[3])/144 - (161*Pi^2*Log[2]*Log[3]^2)/48 + 
    (23*Log[2]^3*Log[3]^2)/4 + (127*Pi^2*Log[3]^3)/144 - 
    (293*Log[2]^2*Log[3]^3)/24 + (737*Log[2]*Log[3]^4)/96 - 
    (521*Log[3]^5)/320 - (Log[2]^3*PolyLog[2, -1/2])/3 + 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] - Log[2]*Log[3]^2*PolyLog[2, -1/2] + 
    (Log[3]^3*PolyLog[2, -1/2])/3 - Log[2]*PolyLog[2, -1/2]^2 + 
    Log[3]*PolyLog[2, -1/2]^2 - (Pi^2*PolyLog[3, -1/2])/6 + 
    Log[2]^2*PolyLog[3, -1/2] - 4*Log[2]*Log[3]*PolyLog[3, -1/2] + 
    (5*Log[3]^2*PolyLog[3, -1/2])/2 - 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    (Pi^2*PolyLog[3, 1/3])/6 + 19*Log[2]^2*PolyLog[3, 1/3] - 
    (41*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + (47*Log[3]^2*PolyLog[3, 1/3])/8 - 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 36*Log[2]*PolyLog[4, -1/2] + 
    (31*Log[3]*PolyLog[4, -1/2])/2 + (39*Log[2]*PolyLog[4, -1/3])/4 - 
    (61*Log[3]*PolyLog[4, -1/3])/8 - (33*Log[2]*PolyLog[4, 1/3])/2 + 
    (45*Log[3]*PolyLog[4, 1/3])/4 - 47*Log[2]*PolyLog[4, 1/2] + 
    (82*Log[3]*PolyLog[4, 1/2])/3 + 44*Log[2]*PolyLog[4, 2/3] - 
    (59*Log[3]*PolyLog[4, 2/3])/2 - 47*PolyLog[5, -1/2] - 
    (145*PolyLog[5, -1/3])/8 + (51*PolyLog[5, 1/3])/2 - 76*PolyLog[5, 1/2] - 
    54*PolyLog[5, 2/3] - (39*PolyLog[2, 3, -1/3])/8 - PolyLog[2, 3, 1/3] + 
    (5*Pi^2*Zeta[3])/6 - (463*Log[2]^2*Zeta[3])/16 + 
    (213*Log[2]*Log[3]*Zeta[3])/8 - (249*Log[3]^2*Zeta[3])/32 + 
    (6427*Zeta[5])/192
 
G[1, 1, 0, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] - 
    5*G[0, 0, 1, 0, -1, 1/2] + (25*Pi^4*Log[2])/216 - 
    (193*Pi^2*Log[2]^3)/216 - (13*Log[2]^5)/8 - (59*Pi^4*Log[3])/480 + 
    (19*Pi^2*Log[2]^2*Log[3])/8 + (7*Log[2]^4*Log[3])/4 - 
    (29*Pi^2*Log[2]*Log[3]^2)/16 + (15*Log[2]^3*Log[3]^2)/4 + 
    (Pi^2*Log[3]^3)/2 - (91*Log[2]^2*Log[3]^3)/12 + 
    (437*Log[2]*Log[3]^4)/96 - (19*Log[3]^5)/20 - (Log[2]^3*PolyLog[2, -1/2])/
     6 + (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 + (Log[3]^3*PolyLog[2, -1/2])/6 - 
    (Log[2]*PolyLog[2, -1/2]^2)/2 + (Log[3]*PolyLog[2, -1/2]^2)/2 - 
    (Pi^2*PolyLog[3, -1/2])/12 + 2*Log[2]^2*PolyLog[3, -1/2] - 
    3*Log[2]*Log[3]*PolyLog[3, -1/2] + (3*Log[3]^2*PolyLog[3, -1/2])/2 - 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Pi^2*PolyLog[3, 1/3])/12 + 
    (23*Log[2]^2*PolyLog[3, 1/3])/2 - 12*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (7*Log[3]^2*PolyLog[3, 1/3])/2 - PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    18*Log[2]*PolyLog[4, -1/2] + 8*Log[3]*PolyLog[4, -1/2] + 
    (31*Log[2]*PolyLog[4, -1/3])/4 - (21*Log[3]*PolyLog[4, -1/3])/4 - 
    (27*Log[2]*PolyLog[4, 1/3])/2 + (17*Log[3]*PolyLog[4, 1/3])/2 - 
    (77*Log[2]*PolyLog[4, 1/2])/3 + 19*Log[3]*PolyLog[4, 1/2] + 
    28*Log[2]*PolyLog[4, 2/3] - 18*Log[3]*PolyLog[4, 2/3] - 
    26*PolyLog[5, -1/2] - (51*PolyLog[5, -1/3])/4 + (39*PolyLog[5, 1/3])/2 - 
    (145*PolyLog[5, 1/2])/3 - 34*PolyLog[5, 2/3] - 
    (5*PolyLog[2, 3, -1/3])/2 - PolyLog[2, 3, 1/3] + (41*Pi^2*Zeta[3])/96 - 
    (733*Log[2]^2*Zeta[3])/48 + (175*Log[2]*Log[3]*Zeta[3])/12 - 
    (55*Log[3]^2*Zeta[3])/12 + (64*Zeta[5])/3
 
G[1, 1, 0, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 2*G[0, -1, 0, -1, -1, 1/2] - 
    2*G[0, 0, 1, 0, -1, 1/2] - (41*Pi^4*Log[2])/1080 - 
    (7*Pi^2*Log[2]^3)/108 - (3*Log[2]^5)/10 + (43*Pi^4*Log[3])/2160 - 
    (Pi^2*Log[2]^2*Log[3])/9 - (Log[2]^4*Log[3])/18 + 
    (5*Pi^2*Log[2]*Log[3]^2)/12 + (5*Log[2]^3*Log[3]^2)/4 - 
    (2*Pi^2*Log[3]^3)/9 - (5*Log[2]^2*Log[3]^3)/6 - (Log[2]*Log[3]^4)/3 + 
    (17*Log[3]^5)/60 + (Log[2]^3*PolyLog[2, -1/2])/3 - 
    Log[2]^2*Log[3]*PolyLog[2, -1/2] + Log[2]*Log[3]^2*PolyLog[2, -1/2] - 
    (Log[3]^3*PolyLog[2, -1/2])/3 + Log[2]*PolyLog[2, -1/2]^2 - 
    Log[3]*PolyLog[2, -1/2]^2 + (Pi^2*PolyLog[3, -1/2])/6 - 
    Log[2]^2*PolyLog[3, -1/2] + 2*Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (3*Log[3]^2*PolyLog[3, -1/2])/2 + 2*PolyLog[2, -1/2]*PolyLog[3, -1/2] + 
    (Pi^2*PolyLog[3, 1/3])/6 + (5*Log[2]^2*PolyLog[3, 1/3])/2 - 
    Log[2]*Log[3]*PolyLog[3, 1/3] - Log[3]^2*PolyLog[3, 1/3] + 
    2*PolyLog[2, -1/2]*PolyLog[3, 1/3] - 9*Log[2]*PolyLog[4, -1/2] + 
    4*Log[3]*PolyLog[4, -1/2] + 2*Log[2]*PolyLog[4, -1/3] - 
    Log[3]*PolyLog[4, -1/3] - 5*Log[2]*PolyLog[4, 1/3] + 
    2*Log[3]*PolyLog[4, 1/3] - (28*Log[2]*PolyLog[4, 1/2])/3 + 
    (26*Log[3]*PolyLog[4, 1/2])/3 + Log[2]*PolyLog[4, 2/3] + 
    4*Log[3]*PolyLog[4, 2/3] - 11*PolyLog[5, -1/2] - 4*PolyLog[5, -1/3] + 
    5*PolyLog[5, 1/3] - (44*PolyLog[5, 1/2])/3 + 5*PolyLog[5, 2/3] - 
    PolyLog[2, 3, -1/3] + 5*PolyLog[2, 3, 1/3] + (Pi^2*Zeta[3])/48 - 
    (113*Log[2]^2*Zeta[3])/24 + (37*Log[2]*Log[3]*Zeta[3])/12 + 
    (5*Log[3]^2*Zeta[3])/12 - (157*Zeta[5])/16
 
G[1, 1, 0, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[2]^3)/18 + Log[2]^5/30 + 
    (Pi^4*Log[3])/90 - (Pi^2*Log[2]^2*Log[3])/12 - (Log[2]^3*Log[3]^2)/4 + 
    (Pi^2*Log[3]^3)/36 + (Log[2]^2*Log[3]^3)/3 - (Log[2]*Log[3]^4)/12 - 
    Log[3]^5/30 + (Log[3]^2*PolyLog[3, -1/2])/2 - (Log[2]^2*PolyLog[3, 1/3])/
     2 + Log[2]*Log[3]*PolyLog[3, 1/3] + Log[2]*PolyLog[4, -1/2] + 
    Log[2]*PolyLog[4, 1/3] - Log[2]*PolyLog[4, 2/3] + PolyLog[5, -1/2] + 
    PolyLog[5, 1/3] + PolyLog[5, 2/3] + PolyLog[2, 3, 1/3] + 
    (Log[2]^2*Zeta[3])/2 - (Log[3]^2*Zeta[3])/2 - Zeta[5]
 
G[1, 1, 0, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - (Pi^4*Log[2])/30 + 
    (5*Pi^2*Log[2]^3)/36 + (2*Log[2]^5)/15 + (Pi^4*Log[3])/30 - 
    (5*Pi^2*Log[2]^2*Log[3])/12 - (7*Log[2]^4*Log[3])/24 + 
    (5*Pi^2*Log[2]*Log[3]^2)/12 - (Log[2]^3*Log[3]^2)/6 - 
    (5*Pi^2*Log[3]^3)/36 + (11*Log[2]^2*Log[3]^3)/12 - 
    (5*Log[2]*Log[3]^4)/6 + (29*Log[3]^5)/120 + (Log[2]^3*PolyLog[2, -1/2])/
     6 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]*PolyLog[2, -1/2]^2)/2 - (Log[3]*PolyLog[2, -1/2]^2)/2 - 
    (Log[2]^2*PolyLog[3, -1/2])/2 + Log[2]*Log[3]*PolyLog[3, -1/2] - 
    (Log[3]^2*PolyLog[3, -1/2])/2 + PolyLog[2, -1/2]*PolyLog[3, -1/2] - 
    Log[2]^2*PolyLog[3, 1/3] + 2*Log[2]*Log[3]*PolyLog[3, 1/3] - 
    Log[3]^2*PolyLog[3, 1/3] + PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    4*Log[2]*PolyLog[4, 2/3] + 4*Log[3]*PolyLog[4, 2/3] + 7*PolyLog[5, 2/3] + 
    3*PolyLog[2, 3, 1/3] + (Log[2]^2*Zeta[3])/2 - Log[2]*Log[3]*Zeta[3] + 
    (Log[3]^2*Zeta[3])/2 - 7*Zeta[5]
 
G[1, 1, 0, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := G[0, -1, 0, -1, -1, 1/2] - 
    4*G[0, 0, 1, 0, -1, 1/2] + (5*Pi^4*Log[2])/96 - (7*Pi^2*Log[2]^3)/27 - 
    (29*Log[2]^5)/90 - (139*Pi^4*Log[3])/2160 + (13*Pi^2*Log[2]^2*Log[3])/
     36 + (59*Log[2]^4*Log[3])/144 - (13*Pi^2*Log[2]*Log[3]^2)/48 + 
    (13*Log[2]^3*Log[3]^2)/12 + (Pi^2*Log[3]^3)/24 - 
    (15*Log[2]^2*Log[3]^3)/8 + (33*Log[2]*Log[3]^4)/32 - (57*Log[3]^5)/320 + 
    (Log[2]^3*PolyLog[2, -1/2])/6 - (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 + 
    (Log[2]*Log[3]^2*PolyLog[2, -1/2])/2 - (Log[3]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]*PolyLog[2, -1/2]^2)/2 - (Log[3]*PolyLog[2, -1/2]^2)/2 + 
    (Pi^2*PolyLog[3, -1/2])/12 - (Log[3]^2*PolyLog[3, -1/2])/2 + 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] + (Pi^2*PolyLog[3, 1/3])/12 + 
    (5*Log[2]^2*PolyLog[3, 1/3])/2 - (9*Log[2]*Log[3]*PolyLog[3, 1/3])/2 + 
    (13*Log[3]^2*PolyLog[3, 1/3])/8 + PolyLog[2, -1/2]*PolyLog[3, 1/3] - 
    5*Log[2]*PolyLog[4, -1/2] + (9*Log[3]*PolyLog[4, -1/2])/2 + 
    (Log[2]*PolyLog[4, -1/3])/4 - (Log[3]*PolyLog[4, -1/3])/8 - 
    (9*Log[2]*PolyLog[4, 1/3])/2 + (17*Log[3]*PolyLog[4, 1/3])/4 - 
    (17*Log[2]*PolyLog[4, 1/2])/3 + (25*Log[3]*PolyLog[4, 1/2])/3 + 
    7*Log[2]*PolyLog[4, 2/3] - (7*Log[3]*PolyLog[4, 2/3])/2 - 
    4*PolyLog[5, -1/2] - (27*PolyLog[5, -1/3])/8 + (15*PolyLog[5, 1/3])/2 - 
    (26*PolyLog[5, 1/2])/3 - 11*PolyLog[5, 2/3] - PolyLog[2, 3, -1/3]/8 - 
    2*PolyLog[2, 3, 1/3] - (5*Pi^2*Zeta[3])/24 - (23*Log[2]^2*Zeta[3])/12 + 
    (73*Log[2]*Log[3]*Zeta[3])/24 - (Log[3]^2*Zeta[3])/96 + (353*Zeta[5])/48
 
G[1, 1, 0, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, -1, 0, -1, -1, 1/2] + (Pi^4*Log[2])/18 + 
    (Pi^2*Log[2]^3)/36 - Log[2]^5/20 - (Pi^4*Log[3])/45 + 
    (Pi^2*Log[2]^2*Log[3])/6 + (3*Log[2]^4*Log[3])/8 - 
    (5*Pi^2*Log[2]*Log[3]^2)/12 - (Log[2]^3*Log[3]^2)/2 + 
    (2*Pi^2*Log[3]^3)/9 - (Log[2]^2*Log[3]^3)/4 + (3*Log[2]*Log[3]^4)/4 - 
    (13*Log[3]^5)/40 - (Log[2]^3*PolyLog[2, -1/2])/6 + 
    (Log[2]^2*Log[3]*PolyLog[2, -1/2])/2 - (Log[2]*Log[3]^2*PolyLog[2, -1/2])/
     2 + (Log[3]^3*PolyLog[2, -1/2])/6 - (Log[2]*PolyLog[2, -1/2]^2)/2 + 
    (Log[3]*PolyLog[2, -1/2]^2)/2 + (Log[2]^2*PolyLog[3, -1/2])/2 - 
    2*Log[2]*Log[3]*PolyLog[3, -1/2] + (3*Log[3]^2*PolyLog[3, -1/2])/2 - 
    PolyLog[2, -1/2]*PolyLog[3, -1/2] - (Log[2]^2*PolyLog[3, 1/3])/2 + 
    (Log[3]^2*PolyLog[3, 1/3])/2 - PolyLog[2, -1/2]*PolyLog[3, 1/3] + 
    2*Log[2]*PolyLog[4, -1/2] - 2*Log[3]*PolyLog[4, -1/2] + 
    2*Log[2]*PolyLog[4, 1/3] - 2*Log[3]*PolyLog[4, 1/3] + 
    2*Log[2]*PolyLog[4, 2/3] - 5*Log[3]*PolyLog[4, 2/3] - 7*PolyLog[5, 2/3] + 
    (3*Log[2]^2*Zeta[3])/2 - (3*Log[3]^2*Zeta[3])/2 + 7*Zeta[5]
 
G[1, 1, 0, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^4*Log[2])/30 - (Pi^2*Log[2]^3)/12 - 
    Log[2]^5/12 - (Pi^4*Log[3])/30 + (Pi^2*Log[2]^2*Log[3])/4 + 
    (Log[2]^4*Log[3])/6 - (Pi^2*Log[2]*Log[3]^2)/4 + (Log[2]^3*Log[3]^2)/6 + 
    (Pi^2*Log[3]^3)/12 - (2*Log[2]^2*Log[3]^3)/3 + (7*Log[2]*Log[3]^4)/12 - 
    Log[3]^5/6 + (Log[2]^2*PolyLog[3, -1/2])/2 - 
    Log[2]*Log[3]*PolyLog[3, -1/2] + (Log[3]^2*PolyLog[3, -1/2])/2 + 
    (Log[2]^2*PolyLog[3, 1/3])/2 - Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (Log[3]^2*PolyLog[3, 1/3])/2 + 3*Log[2]*PolyLog[4, 2/3] - 
    3*Log[3]*PolyLog[4, 2/3] - 6*PolyLog[5, 2/3] + 6*Zeta[5]
 
G[1, 1, 1, -1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^2*Log[2]^3)/24 + Log[2]^5/20 + 
    (Pi^4*Log[3])/720 - (Pi^2*Log[2]^2*Log[3])/6 - (Log[2]^4*Log[3])/12 + 
    (5*Pi^2*Log[2]*Log[3]^2)/24 - (Log[2]^3*Log[3]^2)/12 - 
    (Pi^2*Log[3]^3)/18 + (Log[2]^2*Log[3]^3)/3 - (Log[2]*Log[3]^4)/3 + 
    (11*Log[3]^5)/120 - (Log[2]^2*PolyLog[3, 1/3])/2 + 
    Log[2]*Log[3]*PolyLog[3, 1/3] - (Log[3]^2*PolyLog[3, 1/3])/2 + 
    Log[2]*PolyLog[4, -1/2] - Log[3]*PolyLog[4, -1/2] - 
    Log[2]*PolyLog[4, 1/3] - Log[2]*PolyLog[4, 2/3] + 
    Log[3]*PolyLog[4, 2/3] + PolyLog[5, -1/2] + PolyLog[5, 1/3] - 
    PolyLog[5, 1/2] + PolyLog[5, 2/3] + PolyLog[2, 3, 1/3] + 
    (Pi^2*Zeta[3])/12 + (15*Log[2]^2*Zeta[3])/16 - 
    (15*Log[2]*Log[3]*Zeta[3])/8 + (7*Log[3]^2*Zeta[3])/16 - (33*Zeta[5])/32
 
G[1, 1, 1, -1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -G[0, 0, 1, 0, -1, 1/2] + (17*Pi^4*Log[2])/864 - 
    (19*Pi^2*Log[2]^3)/216 - (179*Log[2]^5)/360 - (49*Pi^4*Log[3])/1440 + 
    (3*Pi^2*Log[2]^2*Log[3])/8 + (5*Log[2]^4*Log[3])/12 - 
    (7*Pi^2*Log[2]*Log[3]^2)/24 + Log[2]^3*Log[3]^2 + 
    (11*Pi^2*Log[3]^3)/144 - (7*Log[2]^2*Log[3]^3)/4 + 
    (15*Log[2]*Log[3]^4)/16 - (19*Log[3]^5)/120 + 
    3*Log[2]^2*PolyLog[3, 1/3] - 3*Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (3*Log[3]^2*PolyLog[3, 1/3])/4 - 6*Log[2]*PolyLog[4, -1/2] + 
    3*Log[3]*PolyLog[4, -1/2] + (3*Log[2]*PolyLog[4, -1/3])/2 - 
    (3*Log[3]*PolyLog[4, -1/3])/4 - 3*Log[2]*PolyLog[4, 1/3] + 
    (5*Log[3]*PolyLog[4, 1/3])/2 - 10*Log[2]*PolyLog[4, 1/2] + 
    7*Log[3]*PolyLog[4, 1/2] + 6*Log[2]*PolyLog[4, 2/3] - 
    3*Log[3]*PolyLog[4, 2/3] - 7*PolyLog[5, -1/2] - 2*PolyLog[5, -1/3] + 
    (13*PolyLog[5, 1/3])/2 - (43*PolyLog[5, 1/2])/3 - 7*PolyLog[5, 2/3] - 
    (3*PolyLog[2, 3, -1/3])/4 + (Pi^2*Zeta[3])/8 - (21*Log[2]^2*Zeta[3])/4 + 
    (39*Log[2]*Log[3]*Zeta[3])/8 - (19*Log[3]^2*Zeta[3])/16 + 
    (925*Zeta[5])/192
 
G[1, 1, 1, -1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := (5*Pi^2*Log[2]^3)/72 - Log[2]^5/12 - 
    (Pi^2*Log[2]^2*Log[3])/8 + (Log[2]^4*Log[3])/12 + 
    (Pi^2*Log[2]*Log[3]^2)/24 + (Log[2]^3*Log[3]^2)/12 + (Pi^2*Log[3]^3)/72 - 
    (Log[2]^2*Log[3]^3)/12 - Log[2]*PolyLog[4, 1/3] + 
    Log[3]*PolyLog[4, 1/3] - 3*Log[2]*PolyLog[4, 1/2] + 
    3*Log[3]*PolyLog[4, 1/2] + 4*PolyLog[5, 1/3] - 4*PolyLog[5, 1/2] - 
    (7*Log[2]^2*Zeta[3])/8 + (7*Log[2]*Log[3]*Zeta[3])/4 - 
    (7*Log[3]^2*Zeta[3])/8
 
G[1, 1, 1, 0, -1, 1/3] /; PLT$AutoConvertToKnownConstants := 3*G[0, 0, 1, 0, -1, 1/2] - 
    (307*Pi^4*Log[2])/4320 + (13*Pi^2*Log[2]^3)/72 + (29*Log[2]^5)/45 + 
    (67*Pi^4*Log[3])/864 - (35*Pi^2*Log[2]^2*Log[3])/72 - 
    (95*Log[2]^4*Log[3])/144 + (7*Pi^2*Log[2]*Log[3]^2)/16 - 
    (4*Log[2]^3*Log[3]^2)/3 - (7*Pi^2*Log[3]^3)/48 + 
    (19*Log[2]^2*Log[3]^3)/8 - (125*Log[2]*Log[3]^4)/96 + 
    (251*Log[3]^5)/960 - 4*Log[2]^2*PolyLog[3, 1/3] + 
    (9*Log[2]*Log[3]*PolyLog[3, 1/3])/2 - (11*Log[3]^2*PolyLog[3, 1/3])/8 + 
    8*Log[2]*PolyLog[4, -1/2] - (9*Log[3]*PolyLog[4, -1/2])/2 - 
    (7*Log[2]*PolyLog[4, -1/3])/4 + (7*Log[3]*PolyLog[4, -1/3])/8 + 
    (9*Log[2]*PolyLog[4, 1/3])/2 - (11*Log[3]*PolyLog[4, 1/3])/4 + 
    (38*Log[2]*PolyLog[4, 1/2])/3 - (34*Log[3]*PolyLog[4, 1/2])/3 - 
    10*Log[2]*PolyLog[4, 2/3] + (11*Log[3]*PolyLog[4, 2/3])/2 + 
    10*PolyLog[5, -1/2] + (43*PolyLog[5, -1/3])/8 - 9*PolyLog[5, 1/3] + 
    19*PolyLog[5, 1/2] + 15*PolyLog[5, 2/3] + (7*PolyLog[2, 3, -1/3])/8 + 
    PolyLog[2, 3, 1/3] - (7*Pi^2*Zeta[3])/96 + (281*Log[2]^2*Zeta[3])/48 - 
    (37*Log[2]*Log[3]*Zeta[3])/6 + (163*Log[3]^2*Zeta[3])/96 - 
    (153*Zeta[5])/16
 
G[1, 1, 1, 0, 0, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^4*Log[2])/90 - (Pi^2*Log[2]^3)/12 - 
    Log[2]^5/24 + (Pi^2*Log[2]^2*Log[3])/6 + (Log[2]^4*Log[3])/24 - 
    (Pi^2*Log[2]*Log[3]^2)/12 + (Log[2]^3*Log[3]^2)/6 - 
    (Log[2]^2*Log[3]^3)/3 + (5*Log[2]*Log[3]^4)/24 - Log[3]^5/24 + 
    (Log[2]^2*PolyLog[3, 1/3])/2 - Log[2]*Log[3]*PolyLog[3, 1/3] + 
    (Log[3]^2*PolyLog[3, 1/3])/2 - Log[2]*PolyLog[4, -1/2] + 
    Log[3]*PolyLog[4, -1/2] - Log[2]*PolyLog[4, 1/3] + 
    Log[3]*PolyLog[4, 1/3] + Log[2]*PolyLog[4, 2/3] - PolyLog[2, 3, 1/3] - 
    Log[2]^2*Zeta[3] + Log[2]*Log[3]*Zeta[3]
 
G[1, 1, 1, 0, 1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^4*Log[2])/30 - (Pi^2*Log[2]^3)/36 + 
    (Pi^4*Log[3])/30 + (Pi^2*Log[2]^2*Log[3])/12 - 
    (Pi^2*Log[2]*Log[3]^2)/12 + (Pi^2*Log[3]^3)/36 - Log[2]*PolyLog[4, 2/3] + 
    Log[3]*PolyLog[4, 2/3] + 4*PolyLog[5, 2/3] - Log[2]^2*Zeta[3] + 
    2*Log[2]*Log[3]*Zeta[3] - Log[3]^2*Zeta[3] - 4*Zeta[5]
 
G[1, 1, 1, 1, -1, 1/3] /; PLT$AutoConvertToKnownConstants := -(Pi^2*Log[2]^3)/36 + Log[2]^5/24 + 
    (Pi^2*Log[2]^2*Log[3])/24 - (Log[2]^4*Log[3])/12 + 
    (Log[2]^3*Log[3]^2)/12 - (Pi^2*Log[3]^3)/72 - (Log[2]^2*Log[3]^3)/12 + 
    (Log[2]*Log[3]^4)/24 + Log[2]*PolyLog[4, 1/2] - Log[3]*PolyLog[4, 1/2] - 
    PolyLog[5, 1/3] + PolyLog[5, 1/2] + (7*Log[2]^2*Zeta[3])/16 - 
    (7*Log[2]*Log[3]*Zeta[3])/8 + (7*Log[3]^2*Zeta[3])/16
 
G[1, 1, 1, 1, 0, 1/3] /; PLT$AutoConvertToKnownConstants := (Pi^4*Log[2])/90 + (Pi^2*Log[2]^3)/36 - 
    (Pi^4*Log[3])/90 - (Pi^2*Log[2]^2*Log[3])/12 + 
    (Pi^2*Log[2]*Log[3]^2)/12 - (Pi^2*Log[3]^3)/36 - PolyLog[5, 2/3] + 
    (Log[2]^2*Zeta[3])/2 - Log[2]*Log[3]*Zeta[3] + (Log[3]^2*Zeta[3])/2 + 
    Zeta[5]
 
G[1, 1, 1, 1, 1, 1/3] /; PLT$AutoConvertToKnownConstants := Log[2]^5/120 - (Log[2]^4*Log[3])/24 + 
    (Log[2]^3*Log[3]^2)/12 - (Log[2]^2*Log[3]^3)/12 + (Log[2]*Log[3]^4)/24 - 
    Log[3]^5/120
