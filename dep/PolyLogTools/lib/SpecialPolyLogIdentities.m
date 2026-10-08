(* ::Package:: *)

(* ::Title:: *)
(*Special Identities*)


Unprotect[PolyLog];


G[0,1/4] := (-2Log[2]) /; PLT$AutoConvertToKnownConstants;
G[as__,1/4] /;  PLT$AutoConvertToKnownConstants && (Union[{as}]==={0}) := 1/Length[{as}]! G[0,1/4]^Length[{as}];

G[1,1/4] := Log[3]-2Log[2] /; PLT$AutoConvertToKnownConstants;
G[as__,1/4] /;  PLT$AutoConvertToKnownConstants && (Union[{as}]==={1}) := 1/Length[{as}]! G[1,1/4]^Length[{as}];

G[as__,3/4] /;  PLT$AutoConvertToKnownConstants && (Union[{as}]==={1}) := 1/Length[{as}]! G[0,1/4]^Length[{as}];
G[as__,3/4] /;  PLT$AutoConvertToKnownConstants && (Union[{as}]==={0}) := 1/Length[{as}]! G[1,1/4]^Length[{as}];


PolyLog[2,1/3] := -Log[2]^2/2 + Log[2]*Log[3] - Log[3]^2/2 - PolyLog[2, -1/2] /; PLT$AutoConvertToKnownConstants;
PolyLog[2, 2/3] := Pi^2/6 +Log[2]^2/2 - Log[3]^2/2 + PolyLog[2, -1/2] /; PLT$AutoConvertToKnownConstants;
PolyLog[2,-1/3] := -Pi^2/6 - Log[2]^2 + 2*Log[2]*Log[3] - Log[3]^2/2 - 2*PolyLog[2, -1/2] /; PLT$AutoConvertToKnownConstants;
PolyLog[2,1/4]:=(-Log[2]^2+2*PolyLog[2,-1/2]+Zeta[2])/;PLT$AutoConvertToKnownConstants;


PolyLog[2,3/4] := (-2 PolyLog[2,-1/2]-3Log[2]^2+2Log[2]Log[3]) /; PLT$AutoConvertToKnownConstants;


PolyLog[3,2/3] := (Pi^2*Log[2])/6 + Log[2]^3/6 - (Pi^2*Log[3])/6 - (Log[2]*Log[3]^2)/2 + Log[3]^3/3 - PolyLog[3, -1/2] - PolyLog[3, 1/3] + Zeta[3] /; PLT$AutoConvertToKnownConstants;
PolyLog[3,-1/3] := (Pi^2*Log[3])/6 - Log[3]^3/6 + 2*PolyLog[3, 1/3] - (13*Zeta[3])/6 /; PLT$AutoConvertToKnownConstants;

PolyLog[1,2,-1/2] := Log[2]^3/6 - (Log[2]^2*Log[3])/2 + (Log[2]*Log[3]^2)/2 - 
 Log[3]^3/6 + Log[2]*PolyLog[2, -1/2] - 
 Log[3]*PolyLog[2, -1/2] +  PolyLog[3, -1/2] +  PolyLog[3, 1/3] /; PLT$AutoConvertToKnownConstants;

PolyLog[1,2,-1/3] := (4*Log[2]^3)/3 - 3*Log[2]^2*Log[3] + 2*Log[2]*Log[3]^2 - 
 Log[3]^3/2 + 4*Log[2]*PolyLog[2, -1/2] - 2*Log[3]*PolyLog[2, -1/2] + 
 4*PolyLog[3, -1/2] + 2*PolyLog[3, 1/3] + (4*Zeta[3])/3 /; PLT$AutoConvertToKnownConstants;


PolyLog[3,1/4]:=(-(Pi^2*Log[2])/3+(2*Log[2]^3)/3+4*PolyLog[3,-1/2]+7/2Zeta[3])/;PLT$AutoConvertToKnownConstants;


PolyLog[3,3/4]:=(2*Log[2]^3-2*Log[2]^2*Log[3]+Log[3]^3/3-4*PolyLog[3,-1/2]-2*PolyLog[3,1/3]- 1/3Zeta[3]) /; PLT$AutoConvertToKnownConstants;


PolyLog[4,3/4]:=((5*Pi^2*Log[2]^2)/9-(19*Log[2]^4)/18-(2*Pi^2*Log[2]*Log[3])/3+(4*Log[2]^3*Log[3])/3+(Pi^2*Log[3]^2)/6-Log[2]^2*Log[3]^2+(2*Log[2]*Log[3]^3)/3-Log[3]^4/6-4*PolyLog[4,-1/2]-2*PolyLog[4,-1/3]+2*PolyLog[4,1/3]-(16*PolyLog[4,1/2])/3-4*PolyLog[4,2/3]+19/6 Zeta[4]) /; PLT$AutoConvertToKnownConstants;


PolyLog[4,1/4]:=(8*PolyLog[4,-1/2]+8*PolyLog[4,1/2])/;PLT$AutoConvertToKnownConstants;


PolyLog[5,1/4]:=(16*PolyLog[5,-1/2]+16*PolyLog[5,1/2])/;PLT$AutoConvertToKnownConstants;


PolyLog[2,2,1/2] := Pi^4/720 + Log[2]^4/24 - (Log[2]*Zeta[3])/8 /; PLT$AutoConvertToKnownConstants;

PolyLog[2,2,-1/2] := -Pi^4/90 - (Pi^2*Log[2]^2)/12 - Log[2]^4/12 + (Pi^2*Log[2]*Log[3])/6 + 
    (Log[2]^3*Log[3])/6 - (Pi^2*Log[3]^2)/12 - (Log[2]*Log[3]^3)/6 + Log[3]^4/12 + 
    Log[2]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, -1/2] + PolyLog[4, -1/2] + 
    PolyLog[4, 1/3] + PolyLog[4, 2/3] - Log[2]*Zeta[3] + Log[3]*Zeta[3] /; PLT$AutoConvertToKnownConstants;

PolyLog[2,2,1/3] := Pi^4/90 + (Pi^2*Log[2]^2)/12 + Log[2]^4/24 - (Pi^2*Log[2]*Log[3])/6 + 
    (Pi^2*Log[3]^2)/12 - (Log[2]^2*Log[3]^2)/4 + (Log[2]*Log[3]^3)/3 - 
    Log[3]^4/8 - Log[2]*PolyLog[3, 1/3] + Log[3]*PolyLog[3, 1/3] + 
    PolyLog[4, -1/2] + PolyLog[4, 1/3] - PolyLog[4, 2/3] + Log[2]*Zeta[3] - 
    Log[3]*Zeta[3] /; PLT$AutoConvertToKnownConstants;

PolyLog[2,2,2/3] := -Pi^4/120 - (Pi^2*Log[2]^2)/12 - Log[2]^4/24 + (Pi^2*Log[2]*Log[3])/6 + 
    (Log[2]^3*Log[3])/6 - (Pi^2*Log[3]^2)/12 - (Log[2]*Log[3]^3)/3 + 
    (5*Log[3]^4)/24 - Log[3]*PolyLog[3, -1/2] - Log[3]*PolyLog[3, 1/3] - 
    PolyLog[4, -1/2] - PolyLog[4, 1/3] + PolyLog[4, 2/3] /; PLT$AutoConvertToKnownConstants;

PolyLog[2,2,-1/3] := (13*Pi^4)/540 + 
 (2*Pi^2*Log[2]^2)/9 + 
 (5*Log[2]^4)/18 - 
 (2*Pi^2*Log[2]*Log[3])/3 + 
 (Pi^2*Log[3]^2)/4 - 
 Log[2]^2*Log[3]^2 + 
 (4*Log[2]*Log[3]^3)/3 - 
 (5*Log[3]^4)/12 - 
 4*Log[2]*PolyLog[3, 1/3] + 
 2*Log[3]*PolyLog[3, 1/3] + 
 4*PolyLog[4, -1/2] - 
 PolyLog[4, -1/3] + 
 2*PolyLog[4, 1/3] + 
 (8*PolyLog[4, 1/2])/3 - 
 4*PolyLog[4, 2/3] + 
 (19*Log[2]*Zeta[3])/3 - 
 (19*Log[3]*Zeta[3])/6 /; PLT$AutoConvertToKnownConstants;

PolyLog[2,2,1/4]:=((-8*Pi^2*Log[2]^2)/9+(7*Log[2]^4)/18+(2*Pi^2*Log[2]*Log[3])/3+(2*Log[2]^3*Log[3])/3-(Pi^2*Log[3]^2)/12-(2*Log[2]*Log[3]^3)/3+(5*Log[3]^4)/24+8*Log[2]*PolyLog[3,-1/2]-4*Log[3]*PolyLog[3,-1/2]+12*PolyLog[4,-1/2]+3*PolyLog[4,-1/3]-2*PolyLog[4,1/3]+(40*PolyLog[4,1/2])/3+4*PolyLog[4,2/3]+5*Log[2]*Zeta[3]-(5*Log[3]*Zeta[3])/2-13/6Zeta[4])/;PLT$AutoConvertToKnownConstants;

PolyLog[2,2,3/4]:=((8*Pi^2*Log[2]^2)/9+(17*Log[2]^4)/18-(2*Pi^2*Log[2]*Log[3])/3-(4*Log[2]^3*Log[3])/3+(Pi^2*Log[3]^2)/12-Log[2]^2*Log[3]^2+(4*Log[2]*Log[3]^3)/3-(5*Log[3]^4)/24-8*Log[2]*PolyLog[3,-1/2]-4*Log[2]*PolyLog[3,1/3]-12*PolyLog[4,-1/2]-3*PolyLog[4,-1/3]+2*PolyLog[4,1/3]-(40*PolyLog[4,1/2])/3-4*PolyLog[4,2/3]-(8*Log[2]*Zeta[3])/3+29/12Zeta[4]) /; PLT$AutoConvertToKnownConstants;


PolyLog[3, 2, -1/3] := -(Pi^4*Log[3])/270 - 
  (23*Log[2]^4*Log[3])/18 + 
  (2*Pi^2*Log[2]*Log[3]^2)/9 + 
  (28*Log[2]^3*Log[3]^2)/9 - 
  (11*Pi^2*Log[3]^3)/108 - 
  (25*Log[2]^2*Log[3]^3)/9 + 
  (8*Log[2]*Log[3]^4)/9 - 
  (19*Log[3]^5)/360 - 
  (16*Log[2]^2*PolyLog[3, 
     -1/2])/3 + 
  (32*Log[2]*Log[3]*PolyLog[3, 
     -1/2])/3 - 
  (16*Log[3]^2*PolyLog[3, 
     -1/2])/3 + 
  (20*Log[2]^2*PolyLog[3, 1/3])/
   3 - (28*Log[2]*Log[3]*
    PolyLog[3, 1/3])/3 + 
  (11*Log[3]^2*PolyLog[3, 1/3])/
   3 - (40*Log[2]*PolyLog[4, 
     -1/2])/3 + 
  (28*Log[3]*PolyLog[4, -1/2])/
   3 - (32*Log[2]*PolyLog[4, 
     1/3])/3 + 
  (26*Log[3]*PolyLog[4, 1/3])/
   3 - (16*Log[2]*PolyLog[4, 
     1/2])/3 + 
  (8*Log[3]*PolyLog[4, 1/2])/
   3 + (8*Log[2]*PolyLog[4, 
     2/3])/3 + 
  (4*Log[3]*PolyLog[4, 2/3])/
   3 - (8*PolyLog[5, -1/2])/3 - 
  3*PolyLog[5, -1/3] + 
  (10*PolyLog[5, 1/3])/3 - 
  (16*PolyLog[5, 1/2])/3 - 
  (8*PolyLog[5, 2/3])/3 + 
  (32*PolyLog[2, 3, -1/2])/3 - 
  PolyLog[2, 3, -1/3] - 
  (16*PolyLog[2, 3, 1/3])/3 - 
  (32*PolyLog[3, 2, -1/2])/3 + 
  (28*PolyLog[3, 2, 1/3])/3 + 
  (Pi^2*Zeta[3])/3 - 
  (11*Log[2]^2*Zeta[3])/3 + 
  Log[2]*Log[3]*Zeta[3] + 
  (Log[3]^2*Zeta[3])/12 - 
  (13*Zeta[5])/3 /; PLT$AutoConvertToKnownConstants;

PolyLog[2, 3, 2/3] := -(Pi^4*Log[3])/90 - 
  (Pi^2*Log[2]^2*Log[3])/12 - 
  (Log[2]^4*Log[3])/48 + 
  (Pi^2*Log[2]*Log[3]^2)/6 - 
  (Pi^2*Log[3]^3)/12 + 
  (5*Log[2]^2*Log[3]^3)/24 - 
  (Log[2]*Log[3]^4)/3 + 
  (7*Log[3]^5)/48 - 
  (Log[3]^2*PolyLog[3, -1/2])/
   2 - (Log[2]^2*PolyLog[3, 
     1/3])/4 + 
  (Log[2]*Log[3]*PolyLog[3, 
     1/3])/2 - 
  (3*Log[3]^2*PolyLog[3, 1/3])/
   4 - (Log[2]*PolyLog[4, 
     -1/2])/2 - 
  (Log[3]*PolyLog[4, -1/2])/2 - 
  Log[3]*PolyLog[4, 1/3] - 
  (Log[2]*PolyLog[4, 2/3])/2 + 
  (3*Log[3]*PolyLog[4, 2/3])/
   2 - (3*PolyLog[5, -1/2])/2 - 
  (3*PolyLog[5, 1/3])/2 + 
  (3*PolyLog[5, 2/3])/2 + 
  PolyLog[2, 3, 1/3]/2 + 
  PolyLog[3, 2, -1/2] - 
  PolyLog[3, 2, 1/3]/2 - 
  (Pi^2*Zeta[3])/6 - 
  (Log[2]^2*Zeta[3])/4 - 
  (Log[2]*Log[3]*Zeta[3])/2 + 
  (3*Log[3]^2*Zeta[3])/4 + 
  Zeta[5]/2 /; PLT$AutoConvertToKnownConstants;

PolyLog[3, 2, 2/3] := -(Pi^4*Log[3])/90 - 
  (Pi^2*Log[2]^2*Log[3])/12 + 
  (Log[2]^4*Log[3])/192 + 
  (Pi^2*Log[2]*Log[3]^2)/6 - 
  (5*Log[2]^3*Log[3]^2)/48 - 
  (Pi^2*Log[3]^3)/12 + 
  (9*Log[2]^2*Log[3]^3)/32 - 
  (13*Log[2]*Log[3]^4)/48 + 
  (17*Log[3]^5)/192 + 
  (Log[2]^2*PolyLog[3, -1/2])/
   6 - (Log[2]*Log[3]*
    PolyLog[3, -1/2])/3 + 
  (Log[3]^2*PolyLog[3, -1/2])/
   6 - (11*Log[2]^2*PolyLog[3, 
     1/3])/48 + 
  (11*Log[2]*Log[3]*PolyLog[3, 
     1/3])/24 - 
  (11*Log[3]^2*PolyLog[3, 1/3])/
   48 + (29*Log[2]*PolyLog[4, 
     -1/2])/24 - 
  (29*Log[3]*PolyLog[4, -1/2])/
   24 - (17*Log[2]*PolyLog[4, 
     1/3])/12 + 
  (17*Log[3]*PolyLog[4, 1/3])/
   12 - (Log[2]*PolyLog[4, 
     2/3])/8 + 
  (9*Log[3]*PolyLog[4, 2/3])/
   8 + (21*PolyLog[5, -1/2])/
   8 + (21*PolyLog[5, 1/3])/8 + 
  (3*PolyLog[5, 2/3])/8 - 
  PolyLog[2, 3, -1/2]/3 + 
  (11*PolyLog[2, 3, 1/3])/24 - 
  (5*PolyLog[3, 2, -1/2])/12 - 
  (53*PolyLog[3, 2, 1/3])/24 - 
  (Pi^2*Zeta[3])/6 + 
  (7*Log[2]^2*Zeta[3])/16 - 
  (15*Log[2]*Log[3]*Zeta[3])/
   8 + (23*Log[3]^2*Zeta[3])/
   16 + (13*Zeta[5])/8 /; PLT$AutoConvertToKnownConstants;

PolyLog[3, 2, 1/2] := -(Pi^4*Log[3])/720 - 
  (Pi^2*Log[2]^2*Log[3])/12 + 
  (71*Log[2]^4*Log[3])/384 + 
  (Pi^2*Log[2]*Log[3]^2)/12 - 
  (47*Log[2]^3*Log[3]^2)/96 - 
  (Pi^2*Log[3]^3)/36 + 
  (39*Log[2]^2*Log[3]^3)/64 - 
  (35*Log[2]*Log[3]^4)/96 + 
  (163*Log[3]^5)/1920 + 
  (5*Log[2]^2*PolyLog[3, -1/2])/
   6 - (5*Log[2]*Log[3]*
    PolyLog[3, -1/2])/3 + 
  (5*Log[3]^2*PolyLog[3, -1/2])/
   6 - (101*Log[2]^2*
    PolyLog[3, 1/3])/96 + 
  (101*Log[2]*Log[3]*
    PolyLog[3, 1/3])/48 - 
  (101*Log[3]^2*PolyLog[3, 
     1/3])/96 + 
  (107*Log[2]*PolyLog[4, -1/2])/
   48 - (107*Log[3]*PolyLog[4, 
     -1/2])/48 + 
  (37*Log[2]*PolyLog[4, 1/3])/
   24 - (37*Log[3]*PolyLog[4, 
     1/3])/24 + Log[2]*
   PolyLog[4, 1/2] - 
  (7*Log[2]*PolyLog[4, 2/3])/
   16 + (7*Log[3]*PolyLog[4, 
     2/3])/16 + 
  (11*PolyLog[5, -1/2])/16 + 
  (11*PolyLog[5, 1/3])/16 + 
  PolyLog[5, 1/2] + 
  (5*PolyLog[5, 2/3])/16 - 
  (5*PolyLog[2, 3, -1/2])/3 + 
  (101*PolyLog[2, 3, 1/3])/48 + 
  (37*PolyLog[3, 2, -1/2])/24 - 
  (107*PolyLog[3, 2, 1/3])/48 - 
  (Pi^2*Zeta[3])/12 + 
  (25*Log[2]^2*Zeta[3])/32 - 
  (9*Log[2]*Log[3]*Zeta[3])/
   16 + (9*Log[3]^2*Zeta[3])/
   32 - (9*Zeta[5])/32 /; PLT$AutoConvertToKnownConstants;

PolyLog[2, 3, 1/2] := -(Pi^4*Log[3])/90 - 
  (Pi^2*Log[2]^2*Log[3])/24 + 
  (3*Log[2]^4*Log[3])/32 + 
  (Pi^2*Log[2]*Log[3]^2)/24 - 
  (5*Log[2]^3*Log[3]^2)/24 - 
  (Pi^2*Log[3]^3)/72 + 
  (11*Log[2]^2*Log[3]^3)/48 - 
  (Log[2]*Log[3]^4)/8 + 
  (13*Log[3]^5)/480 + 
  (Log[2]^2*PolyLog[3, -1/2])/
   2 - Log[2]*Log[3]*
   PolyLog[3, -1/2] + 
  (Log[3]^2*PolyLog[3, -1/2])/
   2 - (3*Log[2]^2*PolyLog[3, 
     1/3])/8 + 
  (3*Log[2]*Log[3]*PolyLog[3, 
     1/3])/4 - 
  (3*Log[3]^2*PolyLog[3, 1/3])/
   8 + (7*Log[2]*PolyLog[4, 
     -1/2])/4 - 
  (7*Log[3]*PolyLog[4, -1/2])/
   4 + (Log[2]*PolyLog[4, 2/3])/
   4 - (Log[3]*PolyLog[4, 2/3])/
   4 + (7*PolyLog[5, -1/2])/4 + 
  (7*PolyLog[5, 1/3])/4 - 
  PolyLog[5, 1/2] - 
  (5*PolyLog[5, 2/3])/4 - 
  PolyLog[2, 3, -1/2] + 
  (3*PolyLog[2, 3, 1/3])/4 - 
  (7*PolyLog[3, 2, 1/3])/4 - 
  (Pi^2*Zeta[3])/12 + 
  (13*Log[2]^2*Zeta[3])/16 - 
  (3*Log[2]*Log[3]*Zeta[3])/4 + 
  (3*Log[3]^2*Zeta[3])/8 + 
  (103*Zeta[5])/32 /; PLT$AutoConvertToKnownConstants;

PolyLog[3, 2, -1/2] := (8*Pi^4*Log[2] - 8*Pi^4*
    Log[3] - 15*Log[2]^4*
    Log[3] + 60*Log[2]^3*
    Log[3]^2 - 90*Log[2]^2*
    Log[3]^3 + 60*Log[2]*
    Log[3]^4 - 15*Log[3]^5 + 
   180*Log[2]^2*PolyLog[3, 
     1/3] - 360*Log[2]*Log[3]*
    PolyLog[3, 1/3] + 
   180*Log[3]^2*PolyLog[3, 
     1/3] + 360*Log[2]*
    PolyLog[4, -1/2] - 
   360*Log[3]*PolyLog[4, 
     -1/2] - 720*Log[2]*
    PolyLog[4, 1/3] + 
   720*Log[3]*PolyLog[4, 1/3] + 
   360*Log[2]*PolyLog[4, 2/3] - 
   360*Log[3]*PolyLog[4, 2/3] + 
   1080*PolyLog[5, -1/2] + 
   1080*PolyLog[5, 1/3] - 
   1080*PolyLog[5, 2/3] - 
   360*PolyLog[2, 3, 1/3] - 
   360*PolyLog[3, 2, 1/3] + 
   180*Log[2]^2*Zeta[3] - 
   360*Log[2]*Log[3]*Zeta[3] + 
   180*Log[3]^2*Zeta[3] + 
   1080*Zeta[5])/720 /; PLT$AutoConvertToKnownConstants;

PolyLog[2, 3, -1/2] := (8*Pi^4*Log[2] - 18*Log[2]^5 - 
   8*Pi^4*Log[3] + 75*Log[2]^4*
    Log[3] - 120*Log[2]^3*
    Log[3]^2 + 90*Log[2]^2*
    Log[3]^3 - 30*Log[2]*
    Log[3]^4 + 3*Log[3]^5 + 
   360*Log[2]^2*PolyLog[3, 
     -1/2] - 720*Log[2]*Log[3]*
    PolyLog[3, -1/2] + 
   360*Log[3]^2*PolyLog[3, 
     -1/2] - 180*Log[2]^2*
    PolyLog[3, 1/3] + 
   360*Log[2]*Log[3]*
    PolyLog[3, 1/3] - 
   180*Log[3]^2*PolyLog[3, 
     1/3] + 1080*Log[2]*
    PolyLog[4, -1/2] - 
   1080*Log[3]*PolyLog[4, 
     -1/2] + 360*Log[2]*
    PolyLog[4, 2/3] - 
   360*Log[3]*PolyLog[4, 2/3] + 
   1080*PolyLog[5, -1/2] + 
   1080*PolyLog[5, 1/3] - 
   1080*PolyLog[5, 2/3] + 
   360*PolyLog[2, 3, 1/3] - 
   1080*PolyLog[3, 2, 1/3] + 
   180*Log[2]^2*Zeta[3] - 
   360*Log[2]*Log[3]*Zeta[3] + 
   180*Log[3]^2*Zeta[3] + 
   1080*Zeta[5])/720 /; PLT$AutoConvertToKnownConstants;

PolyLog[3, 2, 1/3] := (20*Pi^2*Log[2]^3 + 
   12*Log[2]^5 - 60*Pi^2*
    Log[2]^2*Log[3] - 
   15*Log[2]^4*Log[3] + 
   60*Pi^2*Log[2]*Log[3]^2 - 
   60*Log[2]^3*Log[3]^2 - 
   20*Pi^2*Log[3]^3 + 
   150*Log[2]^2*Log[3]^3 - 
   120*Log[2]*Log[3]^4 + 
   33*Log[3]^5 - 180*Log[2]^2*
    PolyLog[3, 1/3] + 
   360*Log[2]*Log[3]*
    PolyLog[3, 1/3] - 
   180*Log[3]^2*PolyLog[3, 
     1/3] + 360*Log[2]*
    PolyLog[4, -1/2] - 
   360*Log[3]*PolyLog[4, 
     -1/2] - 360*Log[2]*
    PolyLog[4, 2/3] + 
   360*Log[3]*PolyLog[4, 2/3] + 
   360*PolyLog[5, -1/2] + 
   360*PolyLog[5, 1/3] + 
   360*PolyLog[5, 2/3] + 
   360*PolyLog[2, 3, 1/3] + 
   180*Log[2]^2*Zeta[3] - 
   360*Log[2]*Log[3]*Zeta[3] + 
   180*Log[3]^2*Zeta[3] - 
   360*Zeta[5])/360 /; PLT$AutoConvertToKnownConstants;


Protect[PolyLog];


G[0,1,1/4]:=(-PolyLog[2,1/4])/;PLT$AutoConvertToKnownConstants;
G[0,0,1,1/4] := (-PolyLog[3,1/4])/;PLT$AutoConvertToKnownConstants;
G[0,0,0,1,1/4] := (-PolyLog[4,1/4])/;PLT$AutoConvertToKnownConstants;
G[0,1,1,1/4]:=(PolyLog[1,2,1/4])/;PLT$AutoConvertToKnownConstants;
G[0,0,1,1,1/4]:=(PolyLog[2,2,1/4])/;PLT$AutoConvertToKnownConstants;
G[0,1,1,1,1/4]:=(-PolyLog[1,3,1/4])/;PLT$AutoConvertToKnownConstants;


G[0,1,3/4]:=(-PolyLog[2,3/4])/;PLT$AutoConvertToKnownConstants;
G[0,0,1,3/4] := (-PolyLog[3,3/4])/;PLT$AutoConvertToKnownConstants;
G[0,0,0,1,3/4] := (-PolyLog[4,3/4])/;PLT$AutoConvertToKnownConstants;
G[0,1,1,3/4]:=(PolyLog[1,2,3/4])/;PLT$AutoConvertToKnownConstants;
G[0,0,1,1,3/4]:=(PolyLog[2,2,3/4])/;PLT$AutoConvertToKnownConstants;
G[0,1,1,1,3/4]:=(-PolyLog[1,3,3/4])/;PLT$AutoConvertToKnownConstants;
