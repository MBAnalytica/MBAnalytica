cLL[0, z_] := SVH[0, z]
 
cLL[1, z_] := SVH[1, z]
 
cLL[0, 0, z_] := SVH[0, z]^2/2
 
cLL[0, 1, z_] := (SVH[0, z]*SVH[1, z])/2 + SVH[0, 1, z]
 
cLL[1, 0, z_] := (SVH[0, z]*SVH[1, z])/2 - SVH[0, 1, z]
 
cLL[1, 1, z_] := SVH[1, z]^2/2
 
cLL[0, 0, 0, z_] := SVH[0, z]^3/6
 
cLL[0, 0, 1, z_] := (SVH[0, z]*SVH[0, 1, z])/2 + SVH[0, 0, 1, z]
 
cLL[0, 1, 0, z_] := (SVH[0, z]^2*SVH[1, z])/2 - 2*SVH[0, 0, 1, z]
 
cLL[0, 1, 1, z_] := (SVH[1, z]*SVH[0, 1, z])/2 + SVH[0, 1, 1, z]
 
cLL[1, 0, 0, z_] := -(SVH[0, z]*SVH[0, 1, z])/2 + SVH[0, 0, 1, z]
 
cLL[1, 0, 1, z_] := (SVH[0, z]*SVH[1, z]^2)/2 - 2*SVH[0, 1, 1, z]
 
cLL[1, 1, 0, z_] := -(SVH[1, z]*SVH[0, 1, z])/2 + SVH[0, 1, 1, z]
 
cLL[1, 1, 1, z_] := SVH[1, z]^3/6
 
cLL[0, 0, 0, 0, z_] := SVH[0, z]^4/24
 
cLL[0, 0, 0, 1, z_] := -(SVH[0, z]^3*SVH[1, z])/24 + 
    (SVH[0, z]*SVH[0, 0, 1, z])/2 + SVH[0, 0, 0, 1, z]
 
cLL[0, 0, 1, 0, z_] := (SVH[0, z]^3*SVH[1, z])/8 + 
    (SVH[0, z]^2*SVH[0, 1, z])/2 - (SVH[0, z]*SVH[0, 0, 1, z])/2 - 
    3*SVH[0, 0, 0, 1, z]
 
cLL[0, 0, 1, 1, z_] := -(SVH[0, z]^2*SVH[1, z]^2)/8 + 
    (SVH[1, z]*SVH[0, 0, 1, z])/2 + (SVH[0, z]*SVH[0, 1, 1, z])/2 + 
    SVH[0, 0, 1, 1, z] - SVH[1, z]*Zeta[3]
 
cLL[0, 1, 0, 0, z_] := (SVH[0, z]^3*SVH[1, z])/8 - 
    (SVH[0, z]^2*SVH[0, 1, z])/2 - (SVH[0, z]*SVH[0, 0, 1, z])/2 + 
    3*SVH[0, 0, 0, 1, z]
 
cLL[0, 1, 0, 1, z_] := (3*SVH[0, z]^2*SVH[1, z]^2)/8 + 
    (SVH[0, z]*SVH[1, z]*SVH[0, 1, z])/2 + SVH[0, 1, z]^2/2 - 
    SVH[1, z]*SVH[0, 0, 1, z] - SVH[0, z]*SVH[0, 1, 1, z] - 
    2*SVH[0, 0, 1, 1, z] + 2*SVH[1, z]*Zeta[3]
 
cLL[0, 1, 1, 0, z_] := -(SVH[0, z]^2*SVH[1, z]^2)/8 - SVH[0, 1, z]^2/2 + 
    SVH[0, z]*SVH[0, 1, 1, z]
 
cLL[0, 1, 1, 1, z_] := -(SVH[0, z]*SVH[1, z]^3)/24 + 
    (SVH[1, z]*SVH[0, 1, 1, z])/2 + SVH[0, 1, 1, 1, z] - SVH[1, z]*Zeta[3]
 
cLL[1, 0, 0, 0, z_] := -(SVH[0, z]^3*SVH[1, z])/24 + 
    (SVH[0, z]*SVH[0, 0, 1, z])/2 - SVH[0, 0, 0, 1, z]
 
cLL[1, 0, 0, 1, z_] := -(SVH[0, z]^2*SVH[1, z]^2)/8 - SVH[0, 1, z]^2/2 + 
    SVH[1, z]*SVH[0, 0, 1, z]
 
cLL[1, 0, 1, 0, z_] := (3*SVH[0, z]^2*SVH[1, z]^2)/8 - 
    (SVH[0, z]*SVH[1, z]*SVH[0, 1, z])/2 + SVH[0, 1, z]^2/2 - 
    SVH[1, z]*SVH[0, 0, 1, z] - SVH[0, z]*SVH[0, 1, 1, z] + 
    2*SVH[0, 0, 1, 1, z] - 2*SVH[1, z]*Zeta[3]
 
cLL[1, 0, 1, 1, z_] := (SVH[0, z]*SVH[1, z]^3)/8 + 
    (SVH[1, z]^2*SVH[0, 1, z])/2 - (SVH[1, z]*SVH[0, 1, 1, z])/2 - 
    3*SVH[0, 1, 1, 1, z] + 3*SVH[1, z]*Zeta[3]
 
cLL[1, 1, 0, 0, z_] := -(SVH[0, z]^2*SVH[1, z]^2)/8 + 
    (SVH[1, z]*SVH[0, 0, 1, z])/2 + (SVH[0, z]*SVH[0, 1, 1, z])/2 - 
    SVH[0, 0, 1, 1, z] + SVH[1, z]*Zeta[3]
 
cLL[1, 1, 0, 1, z_] := (SVH[0, z]*SVH[1, z]^3)/8 - 
    (SVH[1, z]^2*SVH[0, 1, z])/2 - (SVH[1, z]*SVH[0, 1, 1, z])/2 + 
    3*SVH[0, 1, 1, 1, z] - 3*SVH[1, z]*Zeta[3]
 
cLL[1, 1, 1, 0, z_] := -(SVH[0, z]*SVH[1, z]^3)/24 + 
    (SVH[1, z]*SVH[0, 1, 1, z])/2 - SVH[0, 1, 1, 1, z] + SVH[1, z]*Zeta[3]
 
cLL[1, 1, 1, 1, z_] := SVH[1, z]^4/24
 
cLL[0, 0, 0, 0, 0, z_] := SVH[0, z]^5/120
 
cLL[0, 0, 0, 0, 1, z_] := -(SVH[0, z]^3*SVH[0, 1, z])/24 + 
    (SVH[0, z]*SVH[0, 0, 0, 1, z])/2 + SVH[0, 0, 0, 0, 1, z]
 
cLL[0, 0, 0, 1, 0, z_] := -(SVH[0, z]^4*SVH[1, z])/24 + 
    (SVH[0, z]^3*SVH[0, 1, z])/6 + (SVH[0, z]^2*SVH[0, 0, 1, z])/2 - 
    SVH[0, z]*SVH[0, 0, 0, 1, z] - 4*SVH[0, 0, 0, 0, 1, z]
 
cLL[0, 0, 0, 1, 1, z_] := -(SVH[0, z]^2*SVH[1, z]*SVH[0, 1, z])/8 + 
    (SVH[1, z]*SVH[0, 0, 0, 1, z])/2 + (SVH[0, z]*SVH[0, 0, 1, 1, z])/2 + 
    SVH[0, 0, 0, 1, 1, z] - SVH[0, 1, z]*Zeta[3]
 
cLL[0, 0, 1, 0, 0, z_] := (SVH[0, z]^4*SVH[1, z])/8 - 
    SVH[0, z]^2*SVH[0, 0, 1, z] + 6*SVH[0, 0, 0, 0, 1, z]
 
cLL[0, 0, 1, 0, 1, z_] := (3*SVH[0, z]^2*SVH[1, z]*SVH[0, 1, z])/8 + 
    (SVH[0, 1, z]*SVH[0, 0, 1, z])/2 - (3*SVH[1, z]*SVH[0, 0, 0, 1, z])/2 - 
    SVH[0, z]*SVH[0, 0, 1, 1, z] + SVH[0, 0, 1, 0, 1, z] + 
    2*SVH[0, 1, z]*Zeta[3]
 
cLL[0, 0, 1, 1, 0, z_] := -(SVH[0, z]^3*SVH[1, z]^2)/8 + 
    (SVH[0, z]*SVH[1, z]*SVH[0, 0, 1, z])/2 - (SVH[0, 1, z]*SVH[0, 0, 1, z])/
     2 + (SVH[0, z]^2*SVH[0, 1, 1, z])/2 + (SVH[0, z]*SVH[0, 0, 1, 1, z])/2 - 
    3*SVH[0, 0, 0, 1, 1, z] - SVH[0, 0, 1, 0, 1, z] - 
    SVH[0, z]*SVH[1, z]*Zeta[3] + SVH[0, 1, z]*Zeta[3]
 
cLL[0, 0, 1, 1, 1, z_] := -(SVH[0, z]*SVH[1, z]^2*SVH[0, 1, z])/8 + 
    (SVH[1, z]*SVH[0, 0, 1, 1, z])/2 + (SVH[0, z]*SVH[0, 1, 1, 1, z])/2 + 
    SVH[0, 0, 1, 1, 1, z] - SVH[0, 1, z]*Zeta[3]
 
cLL[0, 1, 0, 0, 0, z_] := -(SVH[0, z]^4*SVH[1, z])/24 - 
    (SVH[0, z]^3*SVH[0, 1, z])/6 + (SVH[0, z]^2*SVH[0, 0, 1, z])/2 + 
    SVH[0, z]*SVH[0, 0, 0, 1, z] - 4*SVH[0, 0, 0, 0, 1, z]
 
cLL[0, 1, 0, 0, 1, z_] := -(SVH[0, z]^2*SVH[1, z]*SVH[0, 1, z])/8 + 
    (SVH[0, z]*SVH[0, 1, z]^2)/2 + (SVH[0, z]*SVH[1, z]*SVH[0, 0, 1, z])/2 - 
    (SVH[0, 1, z]*SVH[0, 0, 1, z])/2 + (3*SVH[1, z]*SVH[0, 0, 0, 1, z])/2 - 
    6*SVH[0, 0, 0, 1, 1, z] - 3*SVH[0, 0, 1, 0, 1, z]
 
cLL[0, 1, 0, 1, 0, z_] := (3*SVH[0, z]^3*SVH[1, z]^2)/8 - 
    (SVH[0, z]*SVH[0, 1, z]^2)/2 - 2*SVH[0, z]*SVH[1, z]*SVH[0, 0, 1, z] - 
    SVH[0, z]^2*SVH[0, 1, 1, z] + 12*SVH[0, 0, 0, 1, 1, z] + 
    4*SVH[0, 0, 1, 0, 1, z] + 2*SVH[0, z]*SVH[1, z]*Zeta[3] - 
    4*SVH[0, 1, z]*Zeta[3]
 
cLL[0, 1, 0, 1, 1, z_] := (3*SVH[0, z]*SVH[1, z]^2*SVH[0, 1, z])/8 + 
    (SVH[0, 1, z]*SVH[0, 1, 1, z])/2 - SVH[1, z]*SVH[0, 0, 1, 1, z] - 
    (3*SVH[0, z]*SVH[0, 1, 1, 1, z])/2 + SVH[0, 1, 0, 1, 1, z] + 
    3*SVH[0, 1, z]*Zeta[3]
 
cLL[0, 1, 1, 0, 0, z_] := -(SVH[0, z]^3*SVH[1, z]^2)/8 + 
    (SVH[0, z]*SVH[1, z]*SVH[0, 0, 1, z])/2 + (SVH[0, 1, z]*SVH[0, 0, 1, z])/
     2 + (SVH[0, z]^2*SVH[0, 1, 1, z])/2 - (SVH[0, z]*SVH[0, 0, 1, 1, z])/2 - 
    3*SVH[0, 0, 0, 1, 1, z] - SVH[0, 0, 1, 0, 1, z] + SVH[0, 1, z]*Zeta[3]
 
cLL[0, 1, 1, 0, 1, z_] := -(SVH[0, z]*SVH[1, z]^2*SVH[0, 1, z])/8 + 
    (SVH[1, z]*SVH[0, 1, z]^2)/2 + (SVH[0, z]*SVH[1, z]*SVH[0, 1, 1, z])/2 - 
    (SVH[0, 1, z]*SVH[0, 1, 1, z])/2 + (3*SVH[0, z]*SVH[0, 1, 1, 1, z])/2 - 
    6*SVH[0, 0, 1, 1, 1, z] - 3*SVH[0, 1, 0, 1, 1, z] - 3*SVH[0, 1, z]*Zeta[3]
 
cLL[0, 1, 1, 1, 0, z_] := -(SVH[0, z]^2*SVH[1, z]^3)/24 - 
    (SVH[1, z]*SVH[0, 1, z]^2)/2 + 4*SVH[0, 0, 1, 1, 1, z] + 
    2*SVH[0, 1, 0, 1, 1, z] - SVH[0, z]*SVH[1, z]*Zeta[3] + 
    2*SVH[0, 1, z]*Zeta[3]
 
cLL[0, 1, 1, 1, 1, z_] := -(SVH[1, z]^3*SVH[0, 1, z])/24 + 
    (SVH[1, z]*SVH[0, 1, 1, 1, z])/2 + SVH[0, 1, 1, 1, 1, z]
 
cLL[1, 0, 0, 0, 0, z_] := (SVH[0, z]^3*SVH[0, 1, z])/24 - 
    (SVH[0, z]*SVH[0, 0, 0, 1, z])/2 + SVH[0, 0, 0, 0, 1, z]
 
cLL[1, 0, 0, 0, 1, z_] := -(SVH[0, z]^3*SVH[1, z]^2)/24 - 
    (SVH[0, z]*SVH[0, 1, z]^2)/2 + 4*SVH[0, 0, 0, 1, 1, z] + 
    2*SVH[0, 0, 1, 0, 1, z]
 
cLL[1, 0, 0, 1, 0, z_] := (SVH[0, z]^2*SVH[1, z]*SVH[0, 1, z])/8 + 
    (SVH[0, z]*SVH[0, 1, z]^2)/2 + (SVH[0, z]*SVH[1, z]*SVH[0, 0, 1, z])/2 + 
    (SVH[0, 1, z]*SVH[0, 0, 1, z])/2 - (3*SVH[1, z]*SVH[0, 0, 0, 1, z])/2 - 
    6*SVH[0, 0, 0, 1, 1, z] - 3*SVH[0, 0, 1, 0, 1, z]
 
cLL[1, 0, 0, 1, 1, z_] := -(SVH[0, z]^2*SVH[1, z]^3)/8 + 
    (SVH[1, z]^2*SVH[0, 0, 1, z])/2 + (SVH[0, z]*SVH[1, z]*SVH[0, 1, 1, z])/
     2 - (SVH[0, 1, z]*SVH[0, 1, 1, z])/2 + (SVH[1, z]*SVH[0, 0, 1, 1, z])/
     2 - 3*SVH[0, 0, 1, 1, 1, z] - SVH[0, 1, 0, 1, 1, z] - SVH[1, z]^2*Zeta[3]
 
cLL[1, 0, 1, 0, 0, z_] := (-3*SVH[0, z]^2*SVH[1, z]*SVH[0, 1, z])/8 - 
    (SVH[0, 1, z]*SVH[0, 0, 1, z])/2 + (3*SVH[1, z]*SVH[0, 0, 0, 1, z])/2 + 
    SVH[0, z]*SVH[0, 0, 1, 1, z] + SVH[0, 0, 1, 0, 1, z] - 
    2*SVH[0, z]*SVH[1, z]*Zeta[3] + 2*SVH[0, 1, z]*Zeta[3]
 
cLL[1, 0, 1, 0, 1, z_] := (3*SVH[0, z]^2*SVH[1, z]^3)/8 - 
    (SVH[1, z]*SVH[0, 1, z]^2)/2 - SVH[1, z]^2*SVH[0, 0, 1, z] - 
    2*SVH[0, z]*SVH[1, z]*SVH[0, 1, 1, z] + 12*SVH[0, 0, 1, 1, 1, z] + 
    4*SVH[0, 1, 0, 1, 1, z] + 2*SVH[1, z]^2*Zeta[3]
 
cLL[1, 0, 1, 1, 0, z_] := (SVH[0, z]*SVH[1, z]^2*SVH[0, 1, z])/8 + 
    (SVH[1, z]*SVH[0, 1, z]^2)/2 + (SVH[0, z]*SVH[1, z]*SVH[0, 1, 1, z])/2 + 
    (SVH[0, 1, z]*SVH[0, 1, 1, z])/2 - (3*SVH[0, z]*SVH[0, 1, 1, 1, z])/2 - 
    6*SVH[0, 0, 1, 1, 1, z] - 3*SVH[0, 1, 0, 1, 1, z] + 
    3*SVH[0, z]*SVH[1, z]*Zeta[3] - 3*SVH[0, 1, z]*Zeta[3]
 
cLL[1, 0, 1, 1, 1, z_] := -(SVH[0, z]*SVH[1, z]^4)/24 + 
    (SVH[1, z]^3*SVH[0, 1, z])/6 + (SVH[1, z]^2*SVH[0, 1, 1, z])/2 - 
    SVH[1, z]*SVH[0, 1, 1, 1, z] - 4*SVH[0, 1, 1, 1, 1, z] - 
    SVH[1, z]^2*Zeta[3]
 
cLL[1, 1, 0, 0, 0, z_] := (SVH[0, z]^2*SVH[1, z]*SVH[0, 1, z])/8 - 
    (SVH[1, z]*SVH[0, 0, 0, 1, z])/2 - (SVH[0, z]*SVH[0, 0, 1, 1, z])/2 + 
    SVH[0, 0, 0, 1, 1, z] + SVH[0, z]*SVH[1, z]*Zeta[3] - SVH[0, 1, z]*Zeta[3]
 
cLL[1, 1, 0, 0, 1, z_] := -(SVH[0, z]^2*SVH[1, z]^3)/8 + 
    (SVH[1, z]^2*SVH[0, 0, 1, z])/2 + (SVH[0, z]*SVH[1, z]*SVH[0, 1, 1, z])/
     2 + (SVH[0, 1, z]*SVH[0, 1, 1, z])/2 - (SVH[1, z]*SVH[0, 0, 1, 1, z])/
     2 - 3*SVH[0, 0, 1, 1, 1, z] - SVH[0, 1, 0, 1, 1, z]
 
cLL[1, 1, 0, 1, 0, z_] := (-3*SVH[0, z]*SVH[1, z]^2*SVH[0, 1, z])/8 - 
    (SVH[0, 1, z]*SVH[0, 1, 1, z])/2 + SVH[1, z]*SVH[0, 0, 1, 1, z] + 
    (3*SVH[0, z]*SVH[0, 1, 1, 1, z])/2 + SVH[0, 1, 0, 1, 1, z] - 
    3*SVH[0, z]*SVH[1, z]*Zeta[3] - 2*SVH[1, z]^2*Zeta[3] + 
    3*SVH[0, 1, z]*Zeta[3]
 
cLL[1, 1, 0, 1, 1, z_] := (SVH[0, z]*SVH[1, z]^4)/8 - 
    SVH[1, z]^2*SVH[0, 1, 1, z] + 6*SVH[0, 1, 1, 1, 1, z] + 
    3*SVH[1, z]^2*Zeta[3]
 
cLL[1, 1, 1, 0, 0, z_] := (SVH[0, z]*SVH[1, z]^2*SVH[0, 1, z])/8 - 
    (SVH[1, z]*SVH[0, 0, 1, 1, z])/2 - (SVH[0, z]*SVH[0, 1, 1, 1, z])/2 + 
    SVH[0, 0, 1, 1, 1, z] + SVH[0, z]*SVH[1, z]*Zeta[3] + 
    SVH[1, z]^2*Zeta[3] - SVH[0, 1, z]*Zeta[3]
 
cLL[1, 1, 1, 0, 1, z_] := -(SVH[0, z]*SVH[1, z]^4)/24 - 
    (SVH[1, z]^3*SVH[0, 1, z])/6 + (SVH[1, z]^2*SVH[0, 1, 1, z])/2 + 
    SVH[1, z]*SVH[0, 1, 1, 1, z] - 4*SVH[0, 1, 1, 1, 1, z] - 
    3*SVH[1, z]^2*Zeta[3]
 
cLL[1, 1, 1, 1, 0, z_] := (SVH[1, z]^3*SVH[0, 1, z])/24 - 
    (SVH[1, z]*SVH[0, 1, 1, 1, z])/2 + SVH[0, 1, 1, 1, 1, z] + 
    SVH[1, z]^2*Zeta[3]
 
cLL[1, 1, 1, 1, 1, z_] := SVH[1, z]^5/120
