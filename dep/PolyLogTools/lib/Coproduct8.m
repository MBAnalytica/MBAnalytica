(* ::Package:: *)

DeltaG[a1_, a2_, a3_] := CT[1, GReg[a1, a2, a3]] + 
    CT[GReg[a1, a3], GReg[a2, a1]] - CT[GReg[a2, a3], GReg[a1, a2]] + 
    CT[GReg[a2, a3], GReg[a1, a3]] + CT[GReg[a1, a2, a3], 1]
 
DeltaG[a1_, a2_, a3_, a4_] := CT[1, GReg[a1, a2, a3, a4]] + 
    CT[GReg[a1, a4], GReg[a2, a3, a1]] - CT[GReg[a2, a4], 
     GReg[a1, a2]*GReg[a3, a2]] + CT[GReg[a2, a4], 
     GReg[a1, a4]*GReg[a3, a2]] + CT[GReg[a3, a4], 
     GReg[a1, a3]*GReg[a2, a3]] - CT[GReg[a3, a4], 
     GReg[a1, a4]*GReg[a2, a3]] - CT[GReg[a3, a4], GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4], GReg[a1, a2, a4]] + CT[GReg[a1, a2, a4], GReg[a3, a2]] + 
    CT[GReg[a1, a3, a4], GReg[a2, a1]] - CT[GReg[a1, a3, a4], GReg[a2, a3]] - 
    CT[GReg[a2, a3, a4], GReg[a1, a2]] + CT[GReg[a2, a3, a4], GReg[a1, a4]] + 
    CT[GReg[a1, a2, a3, a4], 1]
 
DeltaG[a1_, a2_, a3_, a4_, a5_] := CT[1, GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a1, a5], GReg[a2, a3, a4, a1]] - CT[GReg[a2, a5], 
     GReg[a1, a2]*GReg[a3, a4, a2]] + CT[GReg[a2, a5], 
     GReg[a1, a5]*GReg[a3, a4, a2]] + CT[GReg[a3, a5], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]] - CT[GReg[a3, a5], 
     GReg[a1, a5]*GReg[a2, a3]*GReg[a4, a3]] - CT[GReg[a3, a5], 
     GReg[a4, a3]*GReg[a1, a2, a3]] + CT[GReg[a3, a5], 
     GReg[a4, a3]*GReg[a1, a2, a5]] - CT[GReg[a4, a5], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]] + CT[GReg[a4, a5], 
     GReg[a1, a5]*GReg[a2, a4]*GReg[a3, a4]] + CT[GReg[a4, a5], 
     GReg[a3, a4]*GReg[a1, a2, a4]] - CT[GReg[a4, a5], 
     GReg[a3, a4]*GReg[a1, a2, a5]] + CT[GReg[a4, a5], 
     GReg[a1, a4]*GReg[a2, a3, a4]] - CT[GReg[a4, a5], 
     GReg[a1, a5]*GReg[a2, a3, a4]] - CT[GReg[a4, a5], 
     GReg[a1, a2, a3, a4]] + CT[GReg[a4, a5], GReg[a1, a2, a3, a5]] + 
    CT[GReg[a1, a2, a5], GReg[a3, a4, a2]] + CT[GReg[a1, a3, a5], 
     GReg[a2, a1]*GReg[a4, a3]] - CT[GReg[a1, a3, a5], 
     GReg[a2, a3]*GReg[a4, a3]] - CT[GReg[a1, a4, a5], 
     GReg[a2, a1]*GReg[a3, a4]] + CT[GReg[a1, a4, a5], 
     GReg[a2, a4]*GReg[a3, a4]] + CT[GReg[a1, a4, a5], GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a5], GReg[a2, a3, a4]] - CT[GReg[a2, a3, a5], 
     GReg[a1, a2]*GReg[a4, a3]] + CT[GReg[a2, a3, a5], 
     GReg[a1, a5]*GReg[a4, a3]] - CT[GReg[a2, a4, a5], 
     GReg[a1, a2]*GReg[a3, a2]] + CT[GReg[a2, a4, a5], 
     GReg[a1, a5]*GReg[a3, a2]] + CT[GReg[a2, a4, a5], 
     GReg[a1, a2]*GReg[a3, a4]] - CT[GReg[a2, a4, a5], 
     GReg[a1, a5]*GReg[a3, a4]] + CT[GReg[a3, a4, a5], 
     GReg[a1, a3]*GReg[a2, a3]] - CT[GReg[a3, a4, a5], 
     GReg[a1, a5]*GReg[a2, a3]] - CT[GReg[a3, a4, a5], GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a5], GReg[a1, a2, a5]] + CT[GReg[a1, a2, a3, a5], 
     GReg[a4, a3]] + CT[GReg[a1, a2, a4, a5], GReg[a3, a2]] - 
    CT[GReg[a1, a2, a4, a5], GReg[a3, a4]] + CT[GReg[a1, a3, a4, a5], 
     GReg[a2, a1]] - CT[GReg[a1, a3, a4, a5], GReg[a2, a3]] - 
    CT[GReg[a2, a3, a4, a5], GReg[a1, a2]] + CT[GReg[a2, a3, a4, a5], 
     GReg[a1, a5]] + CT[GReg[a1, a2, a3, a4, a5], 1]
 
DeltaG[a1_, a2_, a3_, a4_, a5_, a6_] := 
   CT[1, GReg[a1, a2, a3, a4, a5, a6]] + CT[GReg[a1, a6], 
     GReg[a2, a3, a4, a5, a1]] - CT[GReg[a2, a6], 
     GReg[a1, a2]*GReg[a3, a4, a5, a2]] + CT[GReg[a2, a6], 
     GReg[a1, a6]*GReg[a3, a4, a5, a2]] + CT[GReg[a3, a6], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6], GReg[a1, a6]*GReg[a2, a3]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6], GReg[a1, a2, a3]*GReg[a4, a5, a3]] + 
    CT[GReg[a3, a6], GReg[a1, a2, a6]*GReg[a4, a5, a3]] - 
    CT[GReg[a4, a6], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a4, a6], GReg[a1, a6]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a4, a6], GReg[a3, a4]*GReg[a5, a4]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a6], GReg[a3, a4]*GReg[a5, a4]*GReg[a1, a2, a6]] + 
    CT[GReg[a4, a6], GReg[a1, a4]*GReg[a5, a4]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6], GReg[a1, a6]*GReg[a5, a4]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6], GReg[a5, a4]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6], GReg[a5, a4]*GReg[a1, a2, a3, a6]] + 
    CT[GReg[a5, a6], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a5, a6], GReg[a1, a6]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a5, a6], GReg[a3, a5]*GReg[a4, a5]*GReg[a1, a2, a5]] + 
    CT[GReg[a5, a6], GReg[a3, a5]*GReg[a4, a5]*GReg[a1, a2, a6]] - 
    CT[GReg[a5, a6], GReg[a1, a5]*GReg[a4, a5]*GReg[a2, a3, a5]] + 
    CT[GReg[a5, a6], GReg[a1, a6]*GReg[a4, a5]*GReg[a2, a3, a5]] - 
    CT[GReg[a5, a6], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6], GReg[a1, a6]*GReg[a2, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6], GReg[a1, a2, a5]*GReg[a3, a4, a5]] - 
    CT[GReg[a5, a6], GReg[a1, a2, a6]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6], GReg[a4, a5]*GReg[a1, a2, a3, a5]] - 
    CT[GReg[a5, a6], GReg[a4, a5]*GReg[a1, a2, a3, a6]] + 
    CT[GReg[a5, a6], GReg[a1, a5]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a6], GReg[a1, a6]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a6], GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a6], GReg[a1, a2, a3, a4, a6]] + CT[GReg[a1, a2, a6], 
     GReg[a3, a4, a5, a2]] + CT[GReg[a1, a3, a6], 
     GReg[a2, a1]*GReg[a4, a5, a3]] - CT[GReg[a1, a3, a6], 
     GReg[a2, a3]*GReg[a4, a5, a3]] - CT[GReg[a1, a4, a6], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a4]] + CT[GReg[a1, a4, a6], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]] + CT[GReg[a1, a4, a6], 
     GReg[a5, a4]*GReg[a2, a3, a1]] - CT[GReg[a1, a4, a6], 
     GReg[a5, a4]*GReg[a2, a3, a4]] + CT[GReg[a1, a5, a6], 
     GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]] - CT[GReg[a1, a5, a6], 
     GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]] - CT[GReg[a1, a5, a6], 
     GReg[a4, a5]*GReg[a2, a3, a1]] + CT[GReg[a1, a5, a6], 
     GReg[a4, a5]*GReg[a2, a3, a5]] - CT[GReg[a1, a5, a6], 
     GReg[a2, a1]*GReg[a3, a4, a5]] + CT[GReg[a1, a5, a6], 
     GReg[a2, a5]*GReg[a3, a4, a5]] + CT[GReg[a1, a5, a6], 
     GReg[a2, a3, a4, a1]] - CT[GReg[a1, a5, a6], GReg[a2, a3, a4, a5]] - 
    CT[GReg[a2, a3, a6], GReg[a1, a2]*GReg[a4, a5, a3]] + 
    CT[GReg[a2, a3, a6], GReg[a1, a6]*GReg[a4, a5, a3]] - 
    CT[GReg[a2, a4, a6], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]] + 
    CT[GReg[a2, a4, a6], GReg[a1, a6]*GReg[a3, a2]*GReg[a5, a4]] + 
    CT[GReg[a2, a4, a6], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]] - 
    CT[GReg[a2, a4, a6], GReg[a1, a6]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a2, a5, a6], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]] - 
    CT[GReg[a2, a5, a6], GReg[a1, a6]*GReg[a3, a2]*GReg[a4, a5]] - 
    CT[GReg[a2, a5, a6], GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]] + 
    CT[GReg[a2, a5, a6], GReg[a1, a6]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a2, a5, a6], GReg[a1, a2]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a6], GReg[a1, a6]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a6], GReg[a1, a2]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a5, a6], GReg[a1, a6]*GReg[a3, a4, a5]] + 
    CT[GReg[a3, a4, a6], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a4]] - 
    CT[GReg[a3, a4, a6], GReg[a1, a6]*GReg[a2, a3]*GReg[a5, a4]] - 
    CT[GReg[a3, a4, a6], GReg[a5, a4]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a6], GReg[a5, a4]*GReg[a1, a2, a6]] + 
    CT[GReg[a3, a5, a6], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]] - 
    CT[GReg[a3, a5, a6], GReg[a1, a6]*GReg[a2, a3]*GReg[a4, a3]] - 
    CT[GReg[a3, a5, a6], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]] + 
    CT[GReg[a3, a5, a6], GReg[a1, a6]*GReg[a2, a3]*GReg[a4, a5]] - 
    CT[GReg[a3, a5, a6], GReg[a4, a3]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a6], GReg[a4, a5]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a6], GReg[a4, a3]*GReg[a1, a2, a6]] - 
    CT[GReg[a3, a5, a6], GReg[a4, a5]*GReg[a1, a2, a6]] - 
    CT[GReg[a4, a5, a6], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]] + 
    CT[GReg[a4, a5, a6], GReg[a1, a6]*GReg[a2, a4]*GReg[a3, a4]] + 
    CT[GReg[a4, a5, a6], GReg[a3, a4]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a5, a6], GReg[a3, a4]*GReg[a1, a2, a6]] + 
    CT[GReg[a4, a5, a6], GReg[a1, a4]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6], GReg[a1, a6]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6], GReg[a1, a2, a3, a4]] + CT[GReg[a4, a5, a6], 
     GReg[a1, a2, a3, a6]] + CT[GReg[a1, a2, a3, a6], GReg[a4, a5, a3]] + 
    CT[GReg[a1, a2, a4, a6], GReg[a3, a2]*GReg[a5, a4]] - 
    CT[GReg[a1, a2, a4, a6], GReg[a3, a4]*GReg[a5, a4]] - 
    CT[GReg[a1, a2, a5, a6], GReg[a3, a2]*GReg[a4, a5]] + 
    CT[GReg[a1, a2, a5, a6], GReg[a3, a5]*GReg[a4, a5]] + 
    CT[GReg[a1, a2, a5, a6], GReg[a3, a4, a2]] - CT[GReg[a1, a2, a5, a6], 
     GReg[a3, a4, a5]] + CT[GReg[a1, a3, a4, a6], 
     GReg[a2, a1]*GReg[a5, a4]] - CT[GReg[a1, a3, a4, a6], 
     GReg[a2, a3]*GReg[a5, a4]] + CT[GReg[a1, a3, a5, a6], 
     GReg[a2, a1]*GReg[a4, a3]] - CT[GReg[a1, a3, a5, a6], 
     GReg[a2, a3]*GReg[a4, a3]] - CT[GReg[a1, a3, a5, a6], 
     GReg[a2, a1]*GReg[a4, a5]] + CT[GReg[a1, a3, a5, a6], 
     GReg[a2, a3]*GReg[a4, a5]] - CT[GReg[a1, a4, a5, a6], 
     GReg[a2, a1]*GReg[a3, a4]] + CT[GReg[a1, a4, a5, a6], 
     GReg[a2, a4]*GReg[a3, a4]] + CT[GReg[a1, a4, a5, a6], 
     GReg[a2, a3, a1]] - CT[GReg[a1, a4, a5, a6], GReg[a2, a3, a4]] - 
    CT[GReg[a2, a3, a4, a6], GReg[a1, a2]*GReg[a5, a4]] + 
    CT[GReg[a2, a3, a4, a6], GReg[a1, a6]*GReg[a5, a4]] - 
    CT[GReg[a2, a3, a5, a6], GReg[a1, a2]*GReg[a4, a3]] + 
    CT[GReg[a2, a3, a5, a6], GReg[a1, a6]*GReg[a4, a3]] + 
    CT[GReg[a2, a3, a5, a6], GReg[a1, a2]*GReg[a4, a5]] - 
    CT[GReg[a2, a3, a5, a6], GReg[a1, a6]*GReg[a4, a5]] - 
    CT[GReg[a2, a4, a5, a6], GReg[a1, a2]*GReg[a3, a2]] + 
    CT[GReg[a2, a4, a5, a6], GReg[a1, a6]*GReg[a3, a2]] + 
    CT[GReg[a2, a4, a5, a6], GReg[a1, a2]*GReg[a3, a4]] - 
    CT[GReg[a2, a4, a5, a6], GReg[a1, a6]*GReg[a3, a4]] + 
    CT[GReg[a3, a4, a5, a6], GReg[a1, a3]*GReg[a2, a3]] - 
    CT[GReg[a3, a4, a5, a6], GReg[a1, a6]*GReg[a2, a3]] - 
    CT[GReg[a3, a4, a5, a6], GReg[a1, a2, a3]] + CT[GReg[a3, a4, a5, a6], 
     GReg[a1, a2, a6]] + CT[GReg[a1, a2, a3, a4, a6], GReg[a5, a4]] + 
    CT[GReg[a1, a2, a3, a5, a6], GReg[a4, a3]] - CT[GReg[a1, a2, a3, a5, a6], 
     GReg[a4, a5]] + CT[GReg[a1, a2, a4, a5, a6], GReg[a3, a2]] - 
    CT[GReg[a1, a2, a4, a5, a6], GReg[a3, a4]] + CT[GReg[a1, a3, a4, a5, a6], 
     GReg[a2, a1]] - CT[GReg[a1, a3, a4, a5, a6], GReg[a2, a3]] - 
    CT[GReg[a2, a3, a4, a5, a6], GReg[a1, a2]] + CT[GReg[a2, a3, a4, a5, a6], 
     GReg[a1, a6]] + CT[GReg[a1, a2, a3, a4, a5, a6], 1]
 
DeltaG[a1_, a2_, a3_, a4_, a5_, a6_, a7_] := 
   CT[1, GReg[a1, a2, a3, a4, a5, a6, a7]] + CT[GReg[a1, a7], 
     GReg[a2, a3, a4, a5, a6, a1]] - CT[GReg[a2, a7], 
     GReg[a1, a2]*GReg[a3, a4, a5, a6, a2]] + CT[GReg[a2, a7], 
     GReg[a1, a7]*GReg[a3, a4, a5, a6, a2]] + CT[GReg[a3, a7], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a3, a7], GReg[a1, a7]*GReg[a2, a3]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a3, a7], GReg[a1, a2, a3]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a3, a7], GReg[a1, a2, a7]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a4, a7], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6, a4]] + CT[GReg[a4, a7], GReg[a1, a7]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a6, a4]] + CT[GReg[a4, a7], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a4, a7], GReg[a3, a4]*GReg[a1, a2, a7]*GReg[a5, a6, a4]] + 
    CT[GReg[a4, a7], GReg[a1, a4]*GReg[a2, a3, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a4, a7], GReg[a1, a7]*GReg[a2, a3, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a4, a7], GReg[a5, a6, a4]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a7], GReg[a5, a6, a4]*GReg[a1, a2, a3, a7]] + 
    CT[GReg[a5, a7], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a5, a7], GReg[a1, a7]*GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a5]] - CT[GReg[a5, a7], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*GReg[a1, a2, a5]] + 
    CT[GReg[a5, a7], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*
      GReg[a1, a2, a7]] - CT[GReg[a5, a7], GReg[a1, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a2, a3, a5]] + CT[GReg[a5, a7], 
     GReg[a1, a7]*GReg[a4, a5]*GReg[a6, a5]*GReg[a2, a3, a5]] - 
    CT[GReg[a5, a7], GReg[a1, a5]*GReg[a2, a5]*GReg[a6, a5]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a7], GReg[a1, a7]*GReg[a2, a5]*
      GReg[a6, a5]*GReg[a3, a4, a5]] + CT[GReg[a5, a7], 
     GReg[a6, a5]*GReg[a1, a2, a5]*GReg[a3, a4, a5]] - 
    CT[GReg[a5, a7], GReg[a6, a5]*GReg[a1, a2, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a7], GReg[a4, a5]*GReg[a6, a5]*GReg[a1, a2, a3, a5]] - 
    CT[GReg[a5, a7], GReg[a4, a5]*GReg[a6, a5]*GReg[a1, a2, a3, a7]] + 
    CT[GReg[a5, a7], GReg[a1, a5]*GReg[a6, a5]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a7], GReg[a1, a7]*GReg[a6, a5]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a7], GReg[a6, a5]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a7], GReg[a6, a5]*GReg[a1, a2, a3, a4, a7]] - 
    CT[GReg[a6, a7], GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a6, a7], GReg[a1, a7]*GReg[a2, a6]*GReg[a3, a6]*
      GReg[a4, a6]*GReg[a5, a6]] + CT[GReg[a6, a7], 
     GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a6]] - 
    CT[GReg[a6, a7], GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a1, a2, a7]] + CT[GReg[a6, a7], GReg[a1, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a2, a3, a6]] - CT[GReg[a6, a7], 
     GReg[a1, a7]*GReg[a4, a6]*GReg[a5, a6]*GReg[a2, a3, a6]] + 
    CT[GReg[a6, a7], GReg[a1, a6]*GReg[a2, a6]*GReg[a5, a6]*
      GReg[a3, a4, a6]] - CT[GReg[a6, a7], GReg[a1, a7]*GReg[a2, a6]*
      GReg[a5, a6]*GReg[a3, a4, a6]] - CT[GReg[a6, a7], 
     GReg[a5, a6]*GReg[a1, a2, a6]*GReg[a3, a4, a6]] + 
    CT[GReg[a6, a7], GReg[a5, a6]*GReg[a1, a2, a7]*GReg[a3, a4, a6]] + 
    CT[GReg[a6, a7], GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a6, a7], GReg[a1, a7]*GReg[a2, a6]*
      GReg[a3, a6]*GReg[a4, a5, a6]] - CT[GReg[a6, a7], 
     GReg[a3, a6]*GReg[a1, a2, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a6, a7], GReg[a3, a6]*GReg[a1, a2, a7]*GReg[a4, a5, a6]] - 
    CT[GReg[a6, a7], GReg[a1, a6]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a6, a7], GReg[a1, a7]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a6, a7], GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a3, a6]] + 
    CT[GReg[a6, a7], GReg[a4, a5, a6]*GReg[a1, a2, a3, a6]] + 
    CT[GReg[a6, a7], GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a3, a7]] - 
    CT[GReg[a6, a7], GReg[a4, a5, a6]*GReg[a1, a2, a3, a7]] - 
    CT[GReg[a6, a7], GReg[a1, a6]*GReg[a5, a6]*GReg[a2, a3, a4, a6]] + 
    CT[GReg[a6, a7], GReg[a1, a7]*GReg[a5, a6]*GReg[a2, a3, a4, a6]] - 
    CT[GReg[a6, a7], GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a7], GReg[a1, a7]*GReg[a2, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a7], GReg[a1, a2, a6]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a6, a7], GReg[a1, a2, a7]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a7], GReg[a5, a6]*GReg[a1, a2, a3, a4, a6]] - 
    CT[GReg[a6, a7], GReg[a5, a6]*GReg[a1, a2, a3, a4, a7]] + 
    CT[GReg[a6, a7], GReg[a1, a6]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a7], GReg[a1, a7]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a7], GReg[a1, a2, a3, a4, a5, a6]] + 
    CT[GReg[a6, a7], GReg[a1, a2, a3, a4, a5, a7]] + 
    CT[GReg[a1, a2, a7], GReg[a3, a4, a5, a6, a2]] + 
    CT[GReg[a1, a3, a7], GReg[a2, a1]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a1, a3, a7], GReg[a2, a3]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a1, a4, a7], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a4, a7], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a4, a7], GReg[a2, a3, a1]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a4, a7], GReg[a2, a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a5, a7], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a1, a5, a7], GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a5]] - CT[GReg[a1, a5, a7], 
     GReg[a4, a5]*GReg[a6, a5]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a5, a7], GReg[a4, a5]*GReg[a6, a5]*GReg[a2, a3, a5]] - 
    CT[GReg[a1, a5, a7], GReg[a2, a1]*GReg[a6, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a7], GReg[a2, a5]*GReg[a6, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a7], GReg[a6, a5]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a7], GReg[a6, a5]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a1, a6, a7], GReg[a2, a1]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a1, a6, a7], GReg[a2, a6]*GReg[a3, a6]*
      GReg[a4, a6]*GReg[a5, a6]] + CT[GReg[a1, a6, a7], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a6, a7], GReg[a4, a6]*GReg[a5, a6]*GReg[a2, a3, a6]] + 
    CT[GReg[a1, a6, a7], GReg[a2, a1]*GReg[a5, a6]*GReg[a3, a4, a6]] - 
    CT[GReg[a1, a6, a7], GReg[a2, a6]*GReg[a5, a6]*GReg[a3, a4, a6]] + 
    CT[GReg[a1, a6, a7], GReg[a2, a1]*GReg[a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a6, a7], GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a6, a7], GReg[a2, a3, a1]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a6, a7], GReg[a2, a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a6, a7], GReg[a5, a6]*GReg[a2, a3, a4, a1]] + 
    CT[GReg[a1, a6, a7], GReg[a5, a6]*GReg[a2, a3, a4, a6]] - 
    CT[GReg[a1, a6, a7], GReg[a2, a1]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a6, a7], GReg[a2, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a6, a7], GReg[a2, a3, a4, a5, a1]] - 
    CT[GReg[a1, a6, a7], GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a2, a3, a7], GReg[a1, a2]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a2, a3, a7], GReg[a1, a7]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a2, a4, a7], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a4, a7], GReg[a1, a7]*GReg[a3, a2]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a4, a7], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a2, a4, a7], GReg[a1, a7]*GReg[a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a5, a7], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a2, a5, a7], GReg[a1, a7]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a6, a5]] - CT[GReg[a2, a5, a7], 
     GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a2, a5, a7], GReg[a1, a7]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a2, a5, a7], GReg[a1, a2]*GReg[a6, a5]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a5, a7], GReg[a1, a7]*GReg[a6, a5]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a5, a7], GReg[a1, a2]*GReg[a6, a5]*
      GReg[a3, a4, a5]] - CT[GReg[a2, a5, a7], GReg[a1, a7]*GReg[a6, a5]*
      GReg[a3, a4, a5]] - CT[GReg[a2, a6, a7], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a6]*GReg[a5, a6]] + CT[GReg[a2, a6, a7], 
     GReg[a1, a7]*GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a2, a6, a7], GReg[a1, a2]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]] - CT[GReg[a2, a6, a7], GReg[a1, a7]*GReg[a3, a6]*
      GReg[a4, a6]*GReg[a5, a6]] + CT[GReg[a2, a6, a7], 
     GReg[a1, a2]*GReg[a5, a6]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a6, a7], GReg[a1, a7]*GReg[a5, a6]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a6, a7], GReg[a1, a2]*GReg[a5, a6]*GReg[a3, a4, a6]] + 
    CT[GReg[a2, a6, a7], GReg[a1, a7]*GReg[a5, a6]*GReg[a3, a4, a6]] + 
    CT[GReg[a2, a6, a7], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a6, a7], GReg[a1, a7]*GReg[a3, a2]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a6, a7], GReg[a1, a2]*GReg[a3, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a2, a6, a7], GReg[a1, a7]*GReg[a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a6, a7], GReg[a1, a2]*GReg[a3, a4, a5, a2]] + 
    CT[GReg[a2, a6, a7], GReg[a1, a7]*GReg[a3, a4, a5, a2]] + 
    CT[GReg[a2, a6, a7], GReg[a1, a2]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a2, a6, a7], GReg[a1, a7]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a3, a4, a7], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6, a4]] - 
    CT[GReg[a3, a4, a7], GReg[a1, a7]*GReg[a2, a3]*GReg[a5, a6, a4]] - 
    CT[GReg[a3, a4, a7], GReg[a1, a2, a3]*GReg[a5, a6, a4]] + 
    CT[GReg[a3, a4, a7], GReg[a1, a2, a7]*GReg[a5, a6, a4]] + 
    CT[GReg[a3, a5, a7], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a5]] - CT[GReg[a3, a5, a7], GReg[a1, a7]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a6, a5]] - CT[GReg[a3, a5, a7], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a3, a5, a7], GReg[a1, a7]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a3, a5, a7], GReg[a4, a3]*GReg[a6, a5]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a5, a7], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a5, a7], GReg[a4, a3]*GReg[a6, a5]*
      GReg[a1, a2, a7]] - CT[GReg[a3, a5, a7], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a1, a2, a7]] - CT[GReg[a3, a6, a7], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a6]] + CT[GReg[a3, a6, a7], 
     GReg[a1, a7]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6]] + 
    CT[GReg[a3, a6, a7], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a6]*
      GReg[a5, a6]] - CT[GReg[a3, a6, a7], GReg[a1, a7]*GReg[a2, a3]*
      GReg[a4, a6]*GReg[a5, a6]] + CT[GReg[a3, a6, a7], 
     GReg[a4, a3]*GReg[a5, a6]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a6, a7], GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a6, a7], GReg[a4, a3]*GReg[a5, a6]*GReg[a1, a2, a7]] + 
    CT[GReg[a3, a6, a7], GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a7]] + 
    CT[GReg[a3, a6, a7], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a7], GReg[a1, a7]*GReg[a2, a3]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a7], GReg[a1, a2, a3]*GReg[a4, a5, a3]] + 
    CT[GReg[a3, a6, a7], GReg[a1, a2, a7]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a7], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a6]] + 
    CT[GReg[a3, a6, a7], GReg[a1, a7]*GReg[a2, a3]*GReg[a4, a5, a6]] + 
    CT[GReg[a3, a6, a7], GReg[a1, a2, a3]*GReg[a4, a5, a6]] - 
    CT[GReg[a3, a6, a7], GReg[a1, a2, a7]*GReg[a4, a5, a6]] - 
    CT[GReg[a4, a5, a7], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a5]] + CT[GReg[a4, a5, a7], GReg[a1, a7]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a6, a5]] + CT[GReg[a4, a5, a7], 
     GReg[a3, a4]*GReg[a6, a5]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a5, a7], GReg[a3, a4]*GReg[a6, a5]*GReg[a1, a2, a7]] + 
    CT[GReg[a4, a5, a7], GReg[a1, a4]*GReg[a6, a5]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a7], GReg[a1, a7]*GReg[a6, a5]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a7], GReg[a6, a5]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a7], GReg[a6, a5]*GReg[a1, a2, a3, a7]] - 
    CT[GReg[a4, a6, a7], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]] + CT[GReg[a4, a6, a7], GReg[a1, a7]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a4]] + CT[GReg[a4, a6, a7], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]] - 
    CT[GReg[a4, a6, a7], GReg[a1, a7]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6]] + CT[GReg[a4, a6, a7], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a6, a7], GReg[a3, a4]*GReg[a5, a6]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a6, a7], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a1, a2, a7]] + CT[GReg[a4, a6, a7], GReg[a3, a4]*GReg[a5, a6]*
      GReg[a1, a2, a7]] + CT[GReg[a4, a6, a7], GReg[a1, a4]*GReg[a5, a4]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a6, a7], GReg[a1, a7]*GReg[a5, a4]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a6, a7], GReg[a1, a4]*GReg[a5, a6]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a6, a7], GReg[a1, a7]*GReg[a5, a6]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a6, a7], 
     GReg[a5, a4]*GReg[a1, a2, a3, a4]] + CT[GReg[a4, a6, a7], 
     GReg[a5, a6]*GReg[a1, a2, a3, a4]] + CT[GReg[a4, a6, a7], 
     GReg[a5, a4]*GReg[a1, a2, a3, a7]] - CT[GReg[a4, a6, a7], 
     GReg[a5, a6]*GReg[a1, a2, a3, a7]] + CT[GReg[a5, a6, a7], 
     GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a5, a6, a7], GReg[a1, a7]*GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]] - CT[GReg[a5, a6, a7], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a1, a2, a5]] + CT[GReg[a5, a6, a7], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a1, a2, a7]] - CT[GReg[a5, a6, a7], GReg[a1, a5]*GReg[a4, a5]*
      GReg[a2, a3, a5]] + CT[GReg[a5, a6, a7], GReg[a1, a7]*GReg[a4, a5]*
      GReg[a2, a3, a5]] - CT[GReg[a5, a6, a7], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a6, a7], GReg[a1, a7]*GReg[a2, a5]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a6, a7], GReg[a1, a2, a5]*
      GReg[a3, a4, a5]] - CT[GReg[a5, a6, a7], GReg[a1, a2, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a6, a7], 
     GReg[a4, a5]*GReg[a1, a2, a3, a5]] - CT[GReg[a5, a6, a7], 
     GReg[a4, a5]*GReg[a1, a2, a3, a7]] + CT[GReg[a5, a6, a7], 
     GReg[a1, a5]*GReg[a2, a3, a4, a5]] - CT[GReg[a5, a6, a7], 
     GReg[a1, a7]*GReg[a2, a3, a4, a5]] - CT[GReg[a5, a6, a7], 
     GReg[a1, a2, a3, a4, a5]] + CT[GReg[a5, a6, a7], 
     GReg[a1, a2, a3, a4, a7]] + CT[GReg[a1, a2, a3, a7], 
     GReg[a4, a5, a6, a3]] + CT[GReg[a1, a2, a4, a7], 
     GReg[a3, a2]*GReg[a5, a6, a4]] - CT[GReg[a1, a2, a4, a7], 
     GReg[a3, a4]*GReg[a5, a6, a4]] - CT[GReg[a1, a2, a5, a7], 
     GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a5]] + CT[GReg[a1, a2, a5, a7], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]] + CT[GReg[a1, a2, a5, a7], 
     GReg[a6, a5]*GReg[a3, a4, a2]] - CT[GReg[a1, a2, a5, a7], 
     GReg[a6, a5]*GReg[a3, a4, a5]] + CT[GReg[a1, a2, a6, a7], 
     GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]] - CT[GReg[a1, a2, a6, a7], 
     GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]] - CT[GReg[a1, a2, a6, a7], 
     GReg[a5, a6]*GReg[a3, a4, a2]] + CT[GReg[a1, a2, a6, a7], 
     GReg[a5, a6]*GReg[a3, a4, a6]] - CT[GReg[a1, a2, a6, a7], 
     GReg[a3, a2]*GReg[a4, a5, a6]] + CT[GReg[a1, a2, a6, a7], 
     GReg[a3, a6]*GReg[a4, a5, a6]] + CT[GReg[a1, a2, a6, a7], 
     GReg[a3, a4, a5, a2]] - CT[GReg[a1, a2, a6, a7], GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a3, a4, a7], GReg[a2, a1]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a3, a4, a7], GReg[a2, a3]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a3, a5, a7], GReg[a2, a1]*GReg[a4, a3]*GReg[a6, a5]] - 
    CT[GReg[a1, a3, a5, a7], GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a5]] - 
    CT[GReg[a1, a3, a5, a7], GReg[a2, a1]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a1, a3, a5, a7], GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a1, a3, a6, a7], GReg[a2, a1]*GReg[a4, a3]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a6, a7], GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a6, a7], GReg[a2, a1]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a1, a3, a6, a7], GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a6, a7], GReg[a2, a1]*GReg[a4, a5, a3]] - 
    CT[GReg[a1, a3, a6, a7], GReg[a2, a3]*GReg[a4, a5, a3]] - 
    CT[GReg[a1, a3, a6, a7], GReg[a2, a1]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a3, a6, a7], GReg[a2, a3]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a4, a5, a7], GReg[a2, a1]*GReg[a3, a4]*GReg[a6, a5]] + 
    CT[GReg[a1, a4, a5, a7], GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a5]] + 
    CT[GReg[a1, a4, a5, a7], GReg[a6, a5]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a5, a7], GReg[a6, a5]*GReg[a2, a3, a4]] - 
    CT[GReg[a1, a4, a6, a7], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a1, a4, a6, a7], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a1, a4, a6, a7], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6]] - 
    CT[GReg[a1, a4, a6, a7], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]] + 
    CT[GReg[a1, a4, a6, a7], GReg[a5, a4]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a6, a7], GReg[a5, a6]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a6, a7], GReg[a5, a4]*GReg[a2, a3, a4]] + 
    CT[GReg[a1, a4, a6, a7], GReg[a5, a6]*GReg[a2, a3, a4]] + 
    CT[GReg[a1, a5, a6, a7], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a1, a5, a6, a7], GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a1, a5, a6, a7], GReg[a4, a5]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a5, a6, a7], GReg[a4, a5]*GReg[a2, a3, a5]] - 
    CT[GReg[a1, a5, a6, a7], GReg[a2, a1]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a6, a7], GReg[a2, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a6, a7], GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a6, a7], GReg[a2, a3, a4, a5]] - 
    CT[GReg[a2, a3, a4, a7], GReg[a1, a2]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a3, a4, a7], GReg[a1, a7]*GReg[a5, a6, a4]] - 
    CT[GReg[a2, a3, a5, a7], GReg[a1, a2]*GReg[a4, a3]*GReg[a6, a5]] + 
    CT[GReg[a2, a3, a5, a7], GReg[a1, a7]*GReg[a4, a3]*GReg[a6, a5]] + 
    CT[GReg[a2, a3, a5, a7], GReg[a1, a2]*GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a2, a3, a5, a7], GReg[a1, a7]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a2, a3, a6, a7], GReg[a1, a2]*GReg[a4, a3]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a6, a7], GReg[a1, a7]*GReg[a4, a3]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a6, a7], GReg[a1, a2]*GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a2, a3, a6, a7], GReg[a1, a7]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a6, a7], GReg[a1, a2]*GReg[a4, a5, a3]] + 
    CT[GReg[a2, a3, a6, a7], GReg[a1, a7]*GReg[a4, a5, a3]] + 
    CT[GReg[a2, a3, a6, a7], GReg[a1, a2]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a3, a6, a7], GReg[a1, a7]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a4, a5, a7], GReg[a1, a2]*GReg[a3, a2]*GReg[a6, a5]] + 
    CT[GReg[a2, a4, a5, a7], GReg[a1, a7]*GReg[a3, a2]*GReg[a6, a5]] + 
    CT[GReg[a2, a4, a5, a7], GReg[a1, a2]*GReg[a3, a4]*GReg[a6, a5]] - 
    CT[GReg[a2, a4, a5, a7], GReg[a1, a7]*GReg[a3, a4]*GReg[a6, a5]] - 
    CT[GReg[a2, a4, a6, a7], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]] + 
    CT[GReg[a2, a4, a6, a7], GReg[a1, a7]*GReg[a3, a2]*GReg[a5, a4]] + 
    CT[GReg[a2, a4, a6, a7], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]] - 
    CT[GReg[a2, a4, a6, a7], GReg[a1, a7]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a2, a4, a6, a7], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a6]] - 
    CT[GReg[a2, a4, a6, a7], GReg[a1, a7]*GReg[a3, a2]*GReg[a5, a6]] - 
    CT[GReg[a2, a4, a6, a7], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6]] + 
    CT[GReg[a2, a4, a6, a7], GReg[a1, a7]*GReg[a3, a4]*GReg[a5, a6]] + 
    CT[GReg[a2, a5, a6, a7], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]] - 
    CT[GReg[a2, a5, a6, a7], GReg[a1, a7]*GReg[a3, a2]*GReg[a4, a5]] - 
    CT[GReg[a2, a5, a6, a7], GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]] + 
    CT[GReg[a2, a5, a6, a7], GReg[a1, a7]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a2, a5, a6, a7], GReg[a1, a2]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a6, a7], GReg[a1, a7]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a6, a7], GReg[a1, a2]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a5, a6, a7], GReg[a1, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a3, a4, a5, a7], GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a5]] - 
    CT[GReg[a3, a4, a5, a7], GReg[a1, a7]*GReg[a2, a3]*GReg[a6, a5]] - 
    CT[GReg[a3, a4, a5, a7], GReg[a6, a5]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a5, a7], GReg[a6, a5]*GReg[a1, a2, a7]] + 
    CT[GReg[a3, a4, a6, a7], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a4]] - 
    CT[GReg[a3, a4, a6, a7], GReg[a1, a7]*GReg[a2, a3]*GReg[a5, a4]] - 
    CT[GReg[a3, a4, a6, a7], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6]] + 
    CT[GReg[a3, a4, a6, a7], GReg[a1, a7]*GReg[a2, a3]*GReg[a5, a6]] - 
    CT[GReg[a3, a4, a6, a7], GReg[a5, a4]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a6, a7], GReg[a5, a6]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a6, a7], GReg[a5, a4]*GReg[a1, a2, a7]] - 
    CT[GReg[a3, a4, a6, a7], GReg[a5, a6]*GReg[a1, a2, a7]] + 
    CT[GReg[a3, a5, a6, a7], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]] - 
    CT[GReg[a3, a5, a6, a7], GReg[a1, a7]*GReg[a2, a3]*GReg[a4, a3]] - 
    CT[GReg[a3, a5, a6, a7], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]] + 
    CT[GReg[a3, a5, a6, a7], GReg[a1, a7]*GReg[a2, a3]*GReg[a4, a5]] - 
    CT[GReg[a3, a5, a6, a7], GReg[a4, a3]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a6, a7], GReg[a4, a5]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a6, a7], GReg[a4, a3]*GReg[a1, a2, a7]] - 
    CT[GReg[a3, a5, a6, a7], GReg[a4, a5]*GReg[a1, a2, a7]] - 
    CT[GReg[a4, a5, a6, a7], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]] + 
    CT[GReg[a4, a5, a6, a7], GReg[a1, a7]*GReg[a2, a4]*GReg[a3, a4]] + 
    CT[GReg[a4, a5, a6, a7], GReg[a3, a4]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a5, a6, a7], GReg[a3, a4]*GReg[a1, a2, a7]] + 
    CT[GReg[a4, a5, a6, a7], GReg[a1, a4]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6, a7], GReg[a1, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6, a7], GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a6, a7], GReg[a1, a2, a3, a7]] + 
    CT[GReg[a1, a2, a3, a4, a7], GReg[a5, a6, a4]] + 
    CT[GReg[a1, a2, a3, a5, a7], GReg[a4, a3]*GReg[a6, a5]] - 
    CT[GReg[a1, a2, a3, a5, a7], GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a1, a2, a3, a6, a7], GReg[a4, a3]*GReg[a5, a6]] + 
    CT[GReg[a1, a2, a3, a6, a7], GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a1, a2, a3, a6, a7], GReg[a4, a5, a3]] - 
    CT[GReg[a1, a2, a3, a6, a7], GReg[a4, a5, a6]] + 
    CT[GReg[a1, a2, a4, a5, a7], GReg[a3, a2]*GReg[a6, a5]] - 
    CT[GReg[a1, a2, a4, a5, a7], GReg[a3, a4]*GReg[a6, a5]] + 
    CT[GReg[a1, a2, a4, a6, a7], GReg[a3, a2]*GReg[a5, a4]] - 
    CT[GReg[a1, a2, a4, a6, a7], GReg[a3, a4]*GReg[a5, a4]] - 
    CT[GReg[a1, a2, a4, a6, a7], GReg[a3, a2]*GReg[a5, a6]] + 
    CT[GReg[a1, a2, a4, a6, a7], GReg[a3, a4]*GReg[a5, a6]] - 
    CT[GReg[a1, a2, a5, a6, a7], GReg[a3, a2]*GReg[a4, a5]] + 
    CT[GReg[a1, a2, a5, a6, a7], GReg[a3, a5]*GReg[a4, a5]] + 
    CT[GReg[a1, a2, a5, a6, a7], GReg[a3, a4, a2]] - 
    CT[GReg[a1, a2, a5, a6, a7], GReg[a3, a4, a5]] + 
    CT[GReg[a1, a3, a4, a5, a7], GReg[a2, a1]*GReg[a6, a5]] - 
    CT[GReg[a1, a3, a4, a5, a7], GReg[a2, a3]*GReg[a6, a5]] + 
    CT[GReg[a1, a3, a4, a6, a7], GReg[a2, a1]*GReg[a5, a4]] - 
    CT[GReg[a1, a3, a4, a6, a7], GReg[a2, a3]*GReg[a5, a4]] - 
    CT[GReg[a1, a3, a4, a6, a7], GReg[a2, a1]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a4, a6, a7], GReg[a2, a3]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a5, a6, a7], GReg[a2, a1]*GReg[a4, a3]] - 
    CT[GReg[a1, a3, a5, a6, a7], GReg[a2, a3]*GReg[a4, a3]] - 
    CT[GReg[a1, a3, a5, a6, a7], GReg[a2, a1]*GReg[a4, a5]] + 
    CT[GReg[a1, a3, a5, a6, a7], GReg[a2, a3]*GReg[a4, a5]] - 
    CT[GReg[a1, a4, a5, a6, a7], GReg[a2, a1]*GReg[a3, a4]] + 
    CT[GReg[a1, a4, a5, a6, a7], GReg[a2, a4]*GReg[a3, a4]] + 
    CT[GReg[a1, a4, a5, a6, a7], GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a5, a6, a7], GReg[a2, a3, a4]] - 
    CT[GReg[a2, a3, a4, a5, a7], GReg[a1, a2]*GReg[a6, a5]] + 
    CT[GReg[a2, a3, a4, a5, a7], GReg[a1, a7]*GReg[a6, a5]] - 
    CT[GReg[a2, a3, a4, a6, a7], GReg[a1, a2]*GReg[a5, a4]] + 
    CT[GReg[a2, a3, a4, a6, a7], GReg[a1, a7]*GReg[a5, a4]] + 
    CT[GReg[a2, a3, a4, a6, a7], GReg[a1, a2]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a4, a6, a7], GReg[a1, a7]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a5, a6, a7], GReg[a1, a2]*GReg[a4, a3]] + 
    CT[GReg[a2, a3, a5, a6, a7], GReg[a1, a7]*GReg[a4, a3]] + 
    CT[GReg[a2, a3, a5, a6, a7], GReg[a1, a2]*GReg[a4, a5]] - 
    CT[GReg[a2, a3, a5, a6, a7], GReg[a1, a7]*GReg[a4, a5]] - 
    CT[GReg[a2, a4, a5, a6, a7], GReg[a1, a2]*GReg[a3, a2]] + 
    CT[GReg[a2, a4, a5, a6, a7], GReg[a1, a7]*GReg[a3, a2]] + 
    CT[GReg[a2, a4, a5, a6, a7], GReg[a1, a2]*GReg[a3, a4]] - 
    CT[GReg[a2, a4, a5, a6, a7], GReg[a1, a7]*GReg[a3, a4]] + 
    CT[GReg[a3, a4, a5, a6, a7], GReg[a1, a3]*GReg[a2, a3]] - 
    CT[GReg[a3, a4, a5, a6, a7], GReg[a1, a7]*GReg[a2, a3]] - 
    CT[GReg[a3, a4, a5, a6, a7], GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a5, a6, a7], GReg[a1, a2, a7]] + 
    CT[GReg[a1, a2, a3, a4, a5, a7], GReg[a6, a5]] + 
    CT[GReg[a1, a2, a3, a4, a6, a7], GReg[a5, a4]] - 
    CT[GReg[a1, a2, a3, a4, a6, a7], GReg[a5, a6]] + 
    CT[GReg[a1, a2, a3, a5, a6, a7], GReg[a4, a3]] - 
    CT[GReg[a1, a2, a3, a5, a6, a7], GReg[a4, a5]] + 
    CT[GReg[a1, a2, a4, a5, a6, a7], GReg[a3, a2]] - 
    CT[GReg[a1, a2, a4, a5, a6, a7], GReg[a3, a4]] + 
    CT[GReg[a1, a3, a4, a5, a6, a7], GReg[a2, a1]] - 
    CT[GReg[a1, a3, a4, a5, a6, a7], GReg[a2, a3]] - 
    CT[GReg[a2, a3, a4, a5, a6, a7], GReg[a1, a2]] + 
    CT[GReg[a2, a3, a4, a5, a6, a7], GReg[a1, a7]] + 
    CT[GReg[a1, a2, a3, a4, a5, a6, a7], 1]
 
DeltaG[a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_] := 
   CT[1, GReg[a1, a2, a3, a4, a5, a6, a7, a8]] + 
    CT[GReg[a1, a8], GReg[a2, a3, a4, a5, a6, a7, a1]] - 
    CT[GReg[a2, a8], GReg[a1, a2]*GReg[a3, a4, a5, a6, a7, a2]] + 
    CT[GReg[a2, a8], GReg[a1, a8]*GReg[a3, a4, a5, a6, a7, a2]] + 
    CT[GReg[a3, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a3, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a3, a8], GReg[a1, a2, a3]*GReg[a4, a5, a6, a7, a3]] + 
    CT[GReg[a3, a8], GReg[a1, a2, a8]*GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a4, a8], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6, a7, a4]] + CT[GReg[a4, a8], GReg[a1, a8]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a6, a7, a4]] + CT[GReg[a4, a8], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a4, a8], GReg[a3, a4]*GReg[a1, a2, a8]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a4, a8], GReg[a1, a4]*GReg[a2, a3, a4]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a4, a8], GReg[a1, a8]*GReg[a2, a3, a4]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a4, a8], GReg[a1, a2, a3, a4]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a4, a8], GReg[a1, a2, a3, a8]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a5, a8], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a5, a8], GReg[a1, a8]*GReg[a2, a5]*
      GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a5, a8], GReg[a3, a5]*GReg[a4, a5]*GReg[a1, a2, a5]*
      GReg[a6, a7, a5]] + CT[GReg[a5, a8], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a1, a2, a8]*GReg[a6, a7, a5]] - CT[GReg[a5, a8], 
     GReg[a1, a5]*GReg[a4, a5]*GReg[a2, a3, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a5, a8], GReg[a1, a8]*GReg[a4, a5]*GReg[a2, a3, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a5, a8], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a3, a4, a5]*GReg[a6, a7, a5]] + CT[GReg[a5, a8], 
     GReg[a1, a8]*GReg[a2, a5]*GReg[a3, a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a5, a8], GReg[a1, a2, a5]*GReg[a3, a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a5, a8], GReg[a1, a2, a8]*GReg[a3, a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a5, a8], GReg[a4, a5]*GReg[a6, a7, a5]*GReg[a1, a2, a3, a5]] - 
    CT[GReg[a5, a8], GReg[a4, a5]*GReg[a6, a7, a5]*GReg[a1, a2, a3, a8]] + 
    CT[GReg[a5, a8], GReg[a1, a5]*GReg[a6, a7, a5]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a8], GReg[a1, a8]*GReg[a6, a7, a5]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a8], GReg[a6, a7, a5]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a8], GReg[a6, a7, a5]*GReg[a1, a2, a3, a4, a8]] - 
    CT[GReg[a6, a8], GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a6, a8], 
     GReg[a1, a8]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a6, a8], GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a1, a2, a6]] - CT[GReg[a6, a8], 
     GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a8]] + 
    CT[GReg[a6, a8], GReg[a1, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a6]] - CT[GReg[a6, a8], GReg[a1, a8]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a6]*GReg[a2, a3, a6]] + 
    CT[GReg[a6, a8], GReg[a1, a6]*GReg[a2, a6]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a3, a4, a6]] - CT[GReg[a6, a8], GReg[a1, a8]*GReg[a2, a6]*
      GReg[a5, a6]*GReg[a7, a6]*GReg[a3, a4, a6]] - 
    CT[GReg[a6, a8], GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a6]*
      GReg[a3, a4, a6]] + CT[GReg[a6, a8], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a8]*GReg[a3, a4, a6]] + CT[GReg[a6, a8], 
     GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*GReg[a7, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a6, a8], GReg[a1, a8]*GReg[a2, a6]*GReg[a3, a6]*GReg[a7, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a6, a8], GReg[a3, a6]*GReg[a7, a6]*
      GReg[a1, a2, a6]*GReg[a4, a5, a6]] + CT[GReg[a6, a8], 
     GReg[a3, a6]*GReg[a7, a6]*GReg[a1, a2, a8]*GReg[a4, a5, a6]] - 
    CT[GReg[a6, a8], GReg[a1, a6]*GReg[a7, a6]*GReg[a2, a3, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a6, a8], GReg[a1, a8]*GReg[a7, a6]*
      GReg[a2, a3, a6]*GReg[a4, a5, a6]] - CT[GReg[a6, a8], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a3, a6]] + 
    CT[GReg[a6, a8], GReg[a7, a6]*GReg[a4, a5, a6]*GReg[a1, a2, a3, a6]] + 
    CT[GReg[a6, a8], GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a3, a8]] - CT[GReg[a6, a8], GReg[a7, a6]*GReg[a4, a5, a6]*
      GReg[a1, a2, a3, a8]] - CT[GReg[a6, a8], GReg[a1, a6]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a2, a3, a4, a6]] + CT[GReg[a6, a8], 
     GReg[a1, a8]*GReg[a5, a6]*GReg[a7, a6]*GReg[a2, a3, a4, a6]] - 
    CT[GReg[a6, a8], GReg[a1, a6]*GReg[a2, a6]*GReg[a7, a6]*
      GReg[a3, a4, a5, a6]] + CT[GReg[a6, a8], GReg[a1, a8]*GReg[a2, a6]*
      GReg[a7, a6]*GReg[a3, a4, a5, a6]] + CT[GReg[a6, a8], 
     GReg[a7, a6]*GReg[a1, a2, a6]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a6, a8], GReg[a7, a6]*GReg[a1, a2, a8]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a8], GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a3, a4, a6]] - 
    CT[GReg[a6, a8], GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a3, a4, a8]] + 
    CT[GReg[a6, a8], GReg[a1, a6]*GReg[a7, a6]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a8], GReg[a1, a8]*GReg[a7, a6]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a8], GReg[a7, a6]*GReg[a1, a2, a3, a4, a5, a6]] + 
    CT[GReg[a6, a8], GReg[a7, a6]*GReg[a1, a2, a3, a4, a5, a8]] + 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a7, a8], 
     GReg[a1, a8]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a7, a8], GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a1, a2, a7]] + CT[GReg[a7, a8], 
     GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a8]] - 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a2, a3, a7]] + CT[GReg[a7, a8], GReg[a1, a8]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a7]] - 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a2, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a3, a4, a7]] + CT[GReg[a7, a8], GReg[a1, a8]*GReg[a2, a7]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a3, a4, a7]] + 
    CT[GReg[a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a7]*
      GReg[a3, a4, a7]] - CT[GReg[a7, a8], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a1, a2, a8]*GReg[a3, a4, a7]] - CT[GReg[a7, a8], 
     GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a7]*GReg[a6, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a8]*GReg[a2, a7]*GReg[a3, a7]*GReg[a6, a7]*
      GReg[a4, a5, a7]] + CT[GReg[a7, a8], GReg[a3, a7]*GReg[a6, a7]*
      GReg[a1, a2, a7]*GReg[a4, a5, a7]] - CT[GReg[a7, a8], 
     GReg[a3, a7]*GReg[a6, a7]*GReg[a1, a2, a8]*GReg[a4, a5, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a6, a7]*GReg[a2, a3, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a7, a8], GReg[a1, a8]*GReg[a6, a7]*
      GReg[a2, a3, a7]*GReg[a4, a5, a7]] - CT[GReg[a7, a8], 
     GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a8]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a7, a8], GReg[a3, a7]*GReg[a4, a7]*
      GReg[a1, a2, a7]*GReg[a5, a6, a7]] - CT[GReg[a7, a8], 
     GReg[a3, a7]*GReg[a4, a7]*GReg[a1, a2, a8]*GReg[a5, a6, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a4, a7]*GReg[a2, a3, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a7, a8], GReg[a1, a8]*GReg[a4, a7]*
      GReg[a2, a3, a7]*GReg[a5, a6, a7]] + CT[GReg[a7, a8], 
     GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a7, a8], GReg[a1, a8]*GReg[a2, a7]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a7, a8], GReg[a1, a2, a7]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a7, a8], GReg[a1, a2, a8]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a7, a8], GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a1, a2, a3, a7]] - CT[GReg[a7, a8], 
     GReg[a6, a7]*GReg[a4, a5, a7]*GReg[a1, a2, a3, a7]] - 
    CT[GReg[a7, a8], GReg[a4, a7]*GReg[a5, a6, a7]*GReg[a1, a2, a3, a7]] - 
    CT[GReg[a7, a8], GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a1, a2, a3, a8]] + CT[GReg[a7, a8], GReg[a6, a7]*GReg[a4, a5, a7]*
      GReg[a1, a2, a3, a8]] + CT[GReg[a7, a8], GReg[a4, a7]*GReg[a5, a6, a7]*
      GReg[a1, a2, a3, a8]] + CT[GReg[a7, a8], GReg[a1, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a2, a3, a4, a7]] - CT[GReg[a7, a8], 
     GReg[a1, a8]*GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a4, a7]] - 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a5, a6, a7]*GReg[a2, a3, a4, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a8]*GReg[a5, a6, a7]*GReg[a2, a3, a4, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a2, a7]*GReg[a6, a7]*
      GReg[a3, a4, a5, a7]] - CT[GReg[a7, a8], GReg[a1, a8]*GReg[a2, a7]*
      GReg[a6, a7]*GReg[a3, a4, a5, a7]] - CT[GReg[a7, a8], 
     GReg[a6, a7]*GReg[a1, a2, a7]*GReg[a3, a4, a5, a7]] + 
    CT[GReg[a7, a8], GReg[a6, a7]*GReg[a1, a2, a8]*GReg[a3, a4, a5, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a7]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a7, a8], GReg[a1, a8]*GReg[a2, a7]*
      GReg[a3, a7]*GReg[a4, a5, a6, a7]] - CT[GReg[a7, a8], 
     GReg[a3, a7]*GReg[a1, a2, a7]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a7, a8], GReg[a3, a7]*GReg[a1, a2, a8]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a2, a3, a7]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a8]*GReg[a2, a3, a7]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a2, a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a7, a8], GReg[a1, a2, a3, a8]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a3, a4, a7]] + 
    CT[GReg[a7, a8], GReg[a5, a6, a7]*GReg[a1, a2, a3, a4, a7]] + 
    CT[GReg[a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a3, a4, a8]] - 
    CT[GReg[a7, a8], GReg[a5, a6, a7]*GReg[a1, a2, a3, a4, a8]] - 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a6, a7]*GReg[a2, a3, a4, a5, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a8]*GReg[a6, a7]*GReg[a2, a3, a4, a5, a7]] - 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a8]*GReg[a2, a7]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a2, a7]*GReg[a3, a4, a5, a6, a7]] - 
    CT[GReg[a7, a8], GReg[a1, a2, a8]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a7, a8], GReg[a6, a7]*GReg[a1, a2, a3, a4, a5, a7]] - 
    CT[GReg[a7, a8], GReg[a6, a7]*GReg[a1, a2, a3, a4, a5, a8]] + 
    CT[GReg[a7, a8], GReg[a1, a7]*GReg[a2, a3, a4, a5, a6, a7]] - 
    CT[GReg[a7, a8], GReg[a1, a8]*GReg[a2, a3, a4, a5, a6, a7]] - 
    CT[GReg[a7, a8], GReg[a1, a2, a3, a4, a5, a6, a7]] + 
    CT[GReg[a7, a8], GReg[a1, a2, a3, a4, a5, a6, a8]] + 
    CT[GReg[a1, a2, a8], GReg[a3, a4, a5, a6, a7, a2]] + 
    CT[GReg[a1, a3, a8], GReg[a2, a1]*GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a1, a3, a8], GReg[a2, a3]*GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a1, a4, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a1, a4, a8], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a1, a4, a8], GReg[a2, a3, a1]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a1, a4, a8], GReg[a2, a3, a4]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a1, a5, a8], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a1, a5, a8], GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a7, a5]] - CT[GReg[a1, a5, a8], 
     GReg[a4, a5]*GReg[a2, a3, a1]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a5, a8], GReg[a4, a5]*GReg[a2, a3, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a5, a8], GReg[a2, a1]*GReg[a3, a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a5, a8], GReg[a2, a5]*GReg[a3, a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a5, a8], GReg[a6, a7, a5]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a8], GReg[a6, a7, a5]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a1, a6, a8], GReg[a2, a1]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a1, a6, a8], GReg[a2, a6]*GReg[a3, a6]*
      GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a1, a6, a8], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a6, a8], GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a6]] + CT[GReg[a1, a6, a8], GReg[a2, a1]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a3, a4, a6]] - CT[GReg[a1, a6, a8], 
     GReg[a2, a6]*GReg[a5, a6]*GReg[a7, a6]*GReg[a3, a4, a6]] + 
    CT[GReg[a1, a6, a8], GReg[a2, a1]*GReg[a3, a6]*GReg[a7, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a1, a6, a8], GReg[a2, a6]*GReg[a3, a6]*
      GReg[a7, a6]*GReg[a4, a5, a6]] - CT[GReg[a1, a6, a8], 
     GReg[a7, a6]*GReg[a2, a3, a1]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a6, a8], GReg[a7, a6]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a6, a8], GReg[a5, a6]*GReg[a7, a6]*GReg[a2, a3, a4, a1]] + 
    CT[GReg[a1, a6, a8], GReg[a5, a6]*GReg[a7, a6]*GReg[a2, a3, a4, a6]] - 
    CT[GReg[a1, a6, a8], GReg[a2, a1]*GReg[a7, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a6, a8], GReg[a2, a6]*GReg[a7, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a6, a8], GReg[a7, a6]*GReg[a2, a3, a4, a5, a1]] - 
    CT[GReg[a1, a6, a8], GReg[a7, a6]*GReg[a2, a3, a4, a5, a6]] + 
    CT[GReg[a1, a7, a8], GReg[a2, a1]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a1, a7, a8], GReg[a2, a7]*GReg[a3, a7]*
      GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a1, a7, a8], 
     GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a7, a8], GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a2, a3, a7]] - CT[GReg[a1, a7, a8], GReg[a2, a1]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a3, a4, a7]] + CT[GReg[a1, a7, a8], 
     GReg[a2, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a3, a4, a7]] - 
    CT[GReg[a1, a7, a8], GReg[a2, a1]*GReg[a3, a7]*GReg[a6, a7]*
      GReg[a4, a5, a7]] + CT[GReg[a1, a7, a8], GReg[a2, a7]*GReg[a3, a7]*
      GReg[a6, a7]*GReg[a4, a5, a7]] + CT[GReg[a1, a7, a8], 
     GReg[a6, a7]*GReg[a2, a3, a1]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a7, a8], GReg[a6, a7]*GReg[a2, a3, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a7, a8], GReg[a2, a1]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a1, a7, a8], GReg[a2, a7]*GReg[a3, a7]*
      GReg[a4, a7]*GReg[a5, a6, a7]] + CT[GReg[a1, a7, a8], 
     GReg[a4, a7]*GReg[a2, a3, a1]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a7, a8], GReg[a4, a7]*GReg[a2, a3, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a7, a8], GReg[a2, a1]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a7, a8], GReg[a2, a7]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a7, a8], GReg[a5, a6, a7]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a4, a7]] + 
    CT[GReg[a1, a7, a8], GReg[a5, a6, a7]*GReg[a2, a3, a4, a7]] + 
    CT[GReg[a1, a7, a8], GReg[a2, a1]*GReg[a6, a7]*GReg[a3, a4, a5, a7]] - 
    CT[GReg[a1, a7, a8], GReg[a2, a7]*GReg[a6, a7]*GReg[a3, a4, a5, a7]] + 
    CT[GReg[a1, a7, a8], GReg[a2, a1]*GReg[a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a1, a7, a8], GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a1, a7, a8], GReg[a2, a3, a1]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a1, a7, a8], GReg[a2, a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a1, a7, a8], GReg[a6, a7]*GReg[a2, a3, a4, a5, a1]] + 
    CT[GReg[a1, a7, a8], GReg[a6, a7]*GReg[a2, a3, a4, a5, a7]] - 
    CT[GReg[a1, a7, a8], GReg[a2, a1]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a1, a7, a8], GReg[a2, a7]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a1, a7, a8], GReg[a2, a3, a4, a5, a6, a1]] - 
    CT[GReg[a1, a7, a8], GReg[a2, a3, a4, a5, a6, a7]] - 
    CT[GReg[a2, a3, a8], GReg[a1, a2]*GReg[a4, a5, a6, a7, a3]] + 
    CT[GReg[a2, a3, a8], GReg[a1, a8]*GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a2, a4, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a2, a4, a8], GReg[a1, a8]*GReg[a3, a2]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a2, a4, a8], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a2, a4, a8], GReg[a1, a8]*GReg[a3, a4]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a2, a5, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a2, a5, a8], GReg[a1, a8]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a6, a7, a5]] - CT[GReg[a2, a5, a8], 
     GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a5, a8], GReg[a1, a8]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a2, a5, a8], GReg[a1, a2]*GReg[a3, a4, a2]*
      GReg[a6, a7, a5]] + CT[GReg[a2, a5, a8], GReg[a1, a8]*GReg[a3, a4, a2]*
      GReg[a6, a7, a5]] + CT[GReg[a2, a5, a8], GReg[a1, a2]*GReg[a3, a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a2, a5, a8], GReg[a1, a8]*GReg[a3, a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a2, a6, a8], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a2, a6, a8], 
     GReg[a1, a8]*GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a2, a6, a8], GReg[a1, a2]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a2, a6, a8], GReg[a1, a8]*GReg[a3, a6]*
      GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a2, a6, a8], 
     GReg[a1, a2]*GReg[a5, a6]*GReg[a7, a6]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a6, a8], GReg[a1, a8]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a3, a4, a2]] - CT[GReg[a2, a6, a8], GReg[a1, a2]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a3, a4, a6]] + CT[GReg[a2, a6, a8], 
     GReg[a1, a8]*GReg[a5, a6]*GReg[a7, a6]*GReg[a3, a4, a6]] + 
    CT[GReg[a2, a6, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a7, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a6, a8], GReg[a1, a8]*GReg[a3, a2]*
      GReg[a7, a6]*GReg[a4, a5, a6]] - CT[GReg[a2, a6, a8], 
     GReg[a1, a2]*GReg[a3, a6]*GReg[a7, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a2, a6, a8], GReg[a1, a8]*GReg[a3, a6]*GReg[a7, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a6, a8], GReg[a1, a2]*GReg[a7, a6]*
      GReg[a3, a4, a5, a2]] + CT[GReg[a2, a6, a8], GReg[a1, a8]*GReg[a7, a6]*
      GReg[a3, a4, a5, a2]] + CT[GReg[a2, a6, a8], GReg[a1, a2]*GReg[a7, a6]*
      GReg[a3, a4, a5, a6]] - CT[GReg[a2, a6, a8], GReg[a1, a8]*GReg[a7, a6]*
      GReg[a3, a4, a5, a6]] + CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a2, a7, a8], 
     GReg[a1, a8]*GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]] + CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a3, a7]*
      GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a2, a7, a8], 
     GReg[a1, a2]*GReg[a5, a7]*GReg[a6, a7]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a3, a4, a7]] - CT[GReg[a2, a7, a8], 
     GReg[a1, a8]*GReg[a5, a7]*GReg[a6, a7]*GReg[a3, a4, a7]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a6, a7]*
      GReg[a4, a5, a7]] + CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a3, a2]*
      GReg[a6, a7]*GReg[a4, a5, a7]] + CT[GReg[a2, a7, a8], 
     GReg[a1, a2]*GReg[a3, a7]*GReg[a6, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a3, a7]*GReg[a6, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a7]*GReg[a5, a6, a7]] + CT[GReg[a2, a7, a8], 
     GReg[a1, a8]*GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a3, a7]*
      GReg[a4, a7]*GReg[a5, a6, a7]] + CT[GReg[a2, a7, a8], 
     GReg[a1, a2]*GReg[a3, a4, a2]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a3, a4, a2]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a6, a7]*GReg[a3, a4, a5, a2]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a6, a7]*GReg[a3, a4, a5, a2]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a6, a7]*GReg[a3, a4, a5, a7]] + 
    CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a6, a7]*GReg[a3, a4, a5, a7]] + 
    CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a3, a2]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a3, a7]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a3, a4, a5, a6, a2]] + 
    CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a3, a4, a5, a6, a2]] + 
    CT[GReg[a2, a7, a8], GReg[a1, a2]*GReg[a3, a4, a5, a6, a7]] - 
    CT[GReg[a2, a7, a8], GReg[a1, a8]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a3, a4, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a3, a4, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a3, a4, a8], GReg[a1, a2, a3]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a3, a4, a8], GReg[a1, a2, a8]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a3, a5, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a7, a5]] - CT[GReg[a3, a5, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a6, a7, a5]] - CT[GReg[a3, a5, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a3, a5, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a3, a5, a8], GReg[a4, a3]*GReg[a1, a2, a3]*
      GReg[a6, a7, a5]] + CT[GReg[a3, a5, a8], GReg[a4, a5]*GReg[a1, a2, a3]*
      GReg[a6, a7, a5]] + CT[GReg[a3, a5, a8], GReg[a4, a3]*GReg[a1, a2, a8]*
      GReg[a6, a7, a5]] - CT[GReg[a3, a5, a8], GReg[a4, a5]*GReg[a1, a2, a8]*
      GReg[a6, a7, a5]] - CT[GReg[a3, a6, a8], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a3, a6, a8], 
     GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a3, a6, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a3, a6, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a3, a6, a8], 
     GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a6, a8], GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a6, a8], GReg[a4, a3]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a1, a2, a8]] + CT[GReg[a3, a6, a8], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a8]] + 
    CT[GReg[a3, a6, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a7, a6]*
      GReg[a4, a5, a3]] - CT[GReg[a3, a6, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a7, a6]*GReg[a4, a5, a3]] - CT[GReg[a3, a6, a8], 
     GReg[a7, a6]*GReg[a1, a2, a3]*GReg[a4, a5, a3]] + 
    CT[GReg[a3, a6, a8], GReg[a7, a6]*GReg[a1, a2, a8]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a7, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a3, a6, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a7, a6]*GReg[a4, a5, a6]] + CT[GReg[a3, a6, a8], 
     GReg[a7, a6]*GReg[a1, a2, a3]*GReg[a4, a5, a6]] - 
    CT[GReg[a3, a6, a8], GReg[a7, a6]*GReg[a1, a2, a8]*GReg[a4, a5, a6]] + 
    CT[GReg[a3, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a3, a7, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a3, a7, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a3, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a3, a7, a8], GReg[a4, a3]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a1, a2, a3]] + CT[GReg[a3, a7, a8], 
     GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a7, a8], GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a1, a2, a8]] - CT[GReg[a3, a7, a8], GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a1, a2, a8]] - CT[GReg[a3, a7, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a7]*GReg[a4, a5, a3]] + 
    CT[GReg[a3, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a6, a7]*
      GReg[a4, a5, a3]] + CT[GReg[a3, a7, a8], GReg[a6, a7]*GReg[a1, a2, a3]*
      GReg[a4, a5, a3]] - CT[GReg[a3, a7, a8], GReg[a6, a7]*GReg[a1, a2, a8]*
      GReg[a4, a5, a3]] + CT[GReg[a3, a7, a8], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a6, a7]*GReg[a4, a5, a7]] - CT[GReg[a3, a7, a8], 
     GReg[a1, a8]*GReg[a2, a3]*GReg[a6, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a3, a7, a8], GReg[a6, a7]*GReg[a1, a2, a3]*GReg[a4, a5, a7]] + 
    CT[GReg[a3, a7, a8], GReg[a6, a7]*GReg[a1, a2, a8]*GReg[a4, a5, a7]] - 
    CT[GReg[a3, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a5, a6, a7]] + CT[GReg[a3, a7, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a6, a7]] + CT[GReg[a3, a7, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a3, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a3, a7, a8], GReg[a4, a3]*GReg[a1, a2, a3]*
      GReg[a5, a6, a7]] - CT[GReg[a3, a7, a8], GReg[a4, a7]*GReg[a1, a2, a3]*
      GReg[a5, a6, a7]] - CT[GReg[a3, a7, a8], GReg[a4, a3]*GReg[a1, a2, a8]*
      GReg[a5, a6, a7]] + CT[GReg[a3, a7, a8], GReg[a4, a7]*GReg[a1, a2, a8]*
      GReg[a5, a6, a7]] + CT[GReg[a3, a7, a8], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a5, a6, a3]] - CT[GReg[a3, a7, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a4, a5, a6, a3]] - CT[GReg[a3, a7, a8], 
     GReg[a1, a2, a3]*GReg[a4, a5, a6, a3]] + CT[GReg[a3, a7, a8], 
     GReg[a1, a2, a8]*GReg[a4, a5, a6, a3]] - CT[GReg[a3, a7, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a3, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a3, a7, a8], GReg[a1, a2, a3]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a3, a7, a8], GReg[a1, a2, a8]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a4, a5, a8], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a7, a5]] + CT[GReg[a4, a5, a8], GReg[a1, a8]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a6, a7, a5]] + CT[GReg[a4, a5, a8], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a6, a7, a5]] - 
    CT[GReg[a4, a5, a8], GReg[a3, a4]*GReg[a1, a2, a8]*GReg[a6, a7, a5]] + 
    CT[GReg[a4, a5, a8], GReg[a1, a4]*GReg[a2, a3, a4]*GReg[a6, a7, a5]] - 
    CT[GReg[a4, a5, a8], GReg[a1, a8]*GReg[a2, a3, a4]*GReg[a6, a7, a5]] - 
    CT[GReg[a4, a5, a8], GReg[a6, a7, a5]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a8], GReg[a6, a7, a5]*GReg[a1, a2, a3, a8]] - 
    CT[GReg[a4, a6, a8], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a6]] + CT[GReg[a4, a6, a8], GReg[a1, a8]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a6]] + CT[GReg[a4, a6, a8], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a4, a6, a8], GReg[a1, a8]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a4, a6, a8], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a6]*GReg[a1, a2, a4]] - CT[GReg[a4, a6, a8], 
     GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a6, a8], GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a6]*
      GReg[a1, a2, a8]] + CT[GReg[a4, a6, a8], GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a1, a2, a8]] + CT[GReg[a4, a6, a8], 
     GReg[a1, a4]*GReg[a5, a4]*GReg[a7, a6]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6, a8], GReg[a1, a8]*GReg[a5, a4]*GReg[a7, a6]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a6, a8], GReg[a1, a4]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a2, a3, a4]] + CT[GReg[a4, a6, a8], 
     GReg[a1, a8]*GReg[a5, a6]*GReg[a7, a6]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6, a8], GReg[a5, a4]*GReg[a7, a6]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6, a8], GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6, a8], GReg[a5, a4]*GReg[a7, a6]*GReg[a1, a2, a3, a8]] - 
    CT[GReg[a4, a6, a8], GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a3, a8]] + 
    CT[GReg[a4, a7, a8], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a7]] - CT[GReg[a4, a7, a8], GReg[a1, a8]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]] - CT[GReg[a4, a7, a8], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a4, a7, a8], GReg[a1, a8]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a4, a7, a8], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a7]*GReg[a1, a2, a4]] + CT[GReg[a4, a7, a8], 
     GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a4]] + 
    CT[GReg[a4, a7, a8], GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]*
      GReg[a1, a2, a8]] - CT[GReg[a4, a7, a8], GReg[a3, a4]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a1, a2, a8]] - CT[GReg[a4, a7, a8], 
     GReg[a1, a4]*GReg[a5, a4]*GReg[a6, a7]*GReg[a2, a3, a4]] + 
    CT[GReg[a4, a7, a8], GReg[a1, a8]*GReg[a5, a4]*GReg[a6, a7]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a7, a8], GReg[a1, a4]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a2, a3, a4]] - CT[GReg[a4, a7, a8], 
     GReg[a1, a8]*GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a7, a8], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6, a4]] + CT[GReg[a4, a7, a8], GReg[a1, a8]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a6, a4]] + CT[GReg[a4, a7, a8], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a4, a7, a8], GReg[a3, a4]*GReg[a1, a2, a8]*GReg[a5, a6, a4]] + 
    CT[GReg[a4, a7, a8], GReg[a1, a4]*GReg[a2, a3, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a4, a7, a8], GReg[a1, a8]*GReg[a2, a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a4, a7, a8], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6, a7]] - CT[GReg[a4, a7, a8], GReg[a1, a8]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a6, a7]] - CT[GReg[a4, a7, a8], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a5, a6, a7]] + 
    CT[GReg[a4, a7, a8], GReg[a3, a4]*GReg[a1, a2, a8]*GReg[a5, a6, a7]] - 
    CT[GReg[a4, a7, a8], GReg[a1, a4]*GReg[a2, a3, a4]*GReg[a5, a6, a7]] + 
    CT[GReg[a4, a7, a8], GReg[a1, a8]*GReg[a2, a3, a4]*GReg[a5, a6, a7]] + 
    CT[GReg[a4, a7, a8], GReg[a5, a4]*GReg[a6, a7]*GReg[a1, a2, a3, a4]] - 
    CT[GReg[a4, a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a3, a4]] - 
    CT[GReg[a4, a7, a8], GReg[a5, a6, a4]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a7, a8], GReg[a5, a6, a7]*GReg[a1, a2, a3, a4]] - 
    CT[GReg[a4, a7, a8], GReg[a5, a4]*GReg[a6, a7]*GReg[a1, a2, a3, a8]] + 
    CT[GReg[a4, a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a3, a8]] + 
    CT[GReg[a4, a7, a8], GReg[a5, a6, a4]*GReg[a1, a2, a3, a8]] - 
    CT[GReg[a4, a7, a8], GReg[a5, a6, a7]*GReg[a1, a2, a3, a8]] + 
    CT[GReg[a5, a6, a8], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a6]] - CT[GReg[a5, a6, a8], GReg[a1, a8]*GReg[a2, a5]*
      GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a6]] - CT[GReg[a5, a6, a8], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a6]*GReg[a1, a2, a5]] + 
    CT[GReg[a5, a6, a8], GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a6]*
      GReg[a1, a2, a8]] - CT[GReg[a5, a6, a8], GReg[a1, a5]*GReg[a4, a5]*
      GReg[a7, a6]*GReg[a2, a3, a5]] + CT[GReg[a5, a6, a8], 
     GReg[a1, a8]*GReg[a4, a5]*GReg[a7, a6]*GReg[a2, a3, a5]] - 
    CT[GReg[a5, a6, a8], GReg[a1, a5]*GReg[a2, a5]*GReg[a7, a6]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a6, a8], GReg[a1, a8]*GReg[a2, a5]*
      GReg[a7, a6]*GReg[a3, a4, a5]] + CT[GReg[a5, a6, a8], 
     GReg[a7, a6]*GReg[a1, a2, a5]*GReg[a3, a4, a5]] - 
    CT[GReg[a5, a6, a8], GReg[a7, a6]*GReg[a1, a2, a8]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6, a8], GReg[a4, a5]*GReg[a7, a6]*GReg[a1, a2, a3, a5]] - 
    CT[GReg[a5, a6, a8], GReg[a4, a5]*GReg[a7, a6]*GReg[a1, a2, a3, a8]] + 
    CT[GReg[a5, a6, a8], GReg[a1, a5]*GReg[a7, a6]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a6, a8], GReg[a1, a8]*GReg[a7, a6]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a6, a8], GReg[a7, a6]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a6, a8], GReg[a7, a6]*GReg[a1, a2, a3, a4, a8]] + 
    CT[GReg[a5, a7, a8], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a5, a7, a8], GReg[a1, a8]*GReg[a2, a5]*
      GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]] - CT[GReg[a5, a7, a8], 
     GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]] + 
    CT[GReg[a5, a7, a8], GReg[a1, a8]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]] - CT[GReg[a5, a7, a8], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a1, a2, a5]] + CT[GReg[a5, a7, a8], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]*GReg[a1, a2, a5]] + 
    CT[GReg[a5, a7, a8], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*
      GReg[a1, a2, a8]] - CT[GReg[a5, a7, a8], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a1, a2, a8]] - CT[GReg[a5, a7, a8], 
     GReg[a1, a5]*GReg[a4, a5]*GReg[a6, a5]*GReg[a2, a3, a5]] + 
    CT[GReg[a5, a7, a8], GReg[a1, a8]*GReg[a4, a5]*GReg[a6, a5]*
      GReg[a2, a3, a5]] + CT[GReg[a5, a7, a8], GReg[a1, a5]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a2, a3, a5]] - CT[GReg[a5, a7, a8], 
     GReg[a1, a8]*GReg[a4, a5]*GReg[a6, a7]*GReg[a2, a3, a5]] - 
    CT[GReg[a5, a7, a8], GReg[a1, a5]*GReg[a2, a5]*GReg[a6, a5]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a7, a8], GReg[a1, a8]*GReg[a2, a5]*
      GReg[a6, a5]*GReg[a3, a4, a5]] + CT[GReg[a5, a7, a8], 
     GReg[a1, a5]*GReg[a2, a5]*GReg[a6, a7]*GReg[a3, a4, a5]] - 
    CT[GReg[a5, a7, a8], GReg[a1, a8]*GReg[a2, a5]*GReg[a6, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a7, a8], GReg[a6, a5]*GReg[a1, a2, a5]*
      GReg[a3, a4, a5]] - CT[GReg[a5, a7, a8], GReg[a6, a7]*GReg[a1, a2, a5]*
      GReg[a3, a4, a5]] - CT[GReg[a5, a7, a8], GReg[a6, a5]*GReg[a1, a2, a8]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a7, a8], GReg[a6, a7]*GReg[a1, a2, a8]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a7, a8], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a1, a2, a3, a5]] - CT[GReg[a5, a7, a8], GReg[a4, a5]*GReg[a6, a7]*
      GReg[a1, a2, a3, a5]] - CT[GReg[a5, a7, a8], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a1, a2, a3, a8]] + CT[GReg[a5, a7, a8], GReg[a4, a5]*GReg[a6, a7]*
      GReg[a1, a2, a3, a8]] + CT[GReg[a5, a7, a8], GReg[a1, a5]*GReg[a6, a5]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a5, a7, a8], GReg[a1, a8]*GReg[a6, a5]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a5, a7, a8], GReg[a1, a5]*GReg[a6, a7]*
      GReg[a2, a3, a4, a5]] + CT[GReg[a5, a7, a8], GReg[a1, a8]*GReg[a6, a7]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a5, a7, a8], 
     GReg[a6, a5]*GReg[a1, a2, a3, a4, a5]] + CT[GReg[a5, a7, a8], 
     GReg[a6, a7]*GReg[a1, a2, a3, a4, a5]] + CT[GReg[a5, a7, a8], 
     GReg[a6, a5]*GReg[a1, a2, a3, a4, a8]] - CT[GReg[a5, a7, a8], 
     GReg[a6, a7]*GReg[a1, a2, a3, a4, a8]] - CT[GReg[a6, a7, a8], 
     GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a6, a7, a8], GReg[a1, a8]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a6, a7, a8], GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a1, a2, a6]] - CT[GReg[a6, a7, a8], 
     GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a8]] + 
    CT[GReg[a6, a7, a8], GReg[a1, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a2, a3, a6]] - CT[GReg[a6, a7, a8], GReg[a1, a8]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a2, a3, a6]] + CT[GReg[a6, a7, a8], 
     GReg[a1, a6]*GReg[a2, a6]*GReg[a5, a6]*GReg[a3, a4, a6]] - 
    CT[GReg[a6, a7, a8], GReg[a1, a8]*GReg[a2, a6]*GReg[a5, a6]*
      GReg[a3, a4, a6]] - CT[GReg[a6, a7, a8], GReg[a5, a6]*GReg[a1, a2, a6]*
      GReg[a3, a4, a6]] + CT[GReg[a6, a7, a8], GReg[a5, a6]*GReg[a1, a2, a8]*
      GReg[a3, a4, a6]] + CT[GReg[a6, a7, a8], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a3, a6]*GReg[a4, a5, a6]] - CT[GReg[a6, a7, a8], 
     GReg[a1, a8]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a6, a7, a8], GReg[a3, a6]*GReg[a1, a2, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a6, a7, a8], GReg[a3, a6]*GReg[a1, a2, a8]*GReg[a4, a5, a6]] - 
    CT[GReg[a6, a7, a8], GReg[a1, a6]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a6, a7, a8], GReg[a1, a8]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a6, a7, a8], GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a3, a6]] + 
    CT[GReg[a6, a7, a8], GReg[a4, a5, a6]*GReg[a1, a2, a3, a6]] + 
    CT[GReg[a6, a7, a8], GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a3, a8]] - 
    CT[GReg[a6, a7, a8], GReg[a4, a5, a6]*GReg[a1, a2, a3, a8]] - 
    CT[GReg[a6, a7, a8], GReg[a1, a6]*GReg[a5, a6]*GReg[a2, a3, a4, a6]] + 
    CT[GReg[a6, a7, a8], GReg[a1, a8]*GReg[a5, a6]*GReg[a2, a3, a4, a6]] - 
    CT[GReg[a6, a7, a8], GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a7, a8], GReg[a1, a8]*GReg[a2, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a7, a8], GReg[a1, a2, a6]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a6, a7, a8], GReg[a1, a2, a8]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a7, a8], GReg[a5, a6]*GReg[a1, a2, a3, a4, a6]] - 
    CT[GReg[a6, a7, a8], GReg[a5, a6]*GReg[a1, a2, a3, a4, a8]] + 
    CT[GReg[a6, a7, a8], GReg[a1, a6]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a7, a8], GReg[a1, a8]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a7, a8], GReg[a1, a2, a3, a4, a5, a6]] + 
    CT[GReg[a6, a7, a8], GReg[a1, a2, a3, a4, a5, a8]] + 
    CT[GReg[a1, a2, a3, a8], GReg[a4, a5, a6, a7, a3]] + 
    CT[GReg[a1, a2, a4, a8], GReg[a3, a2]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a1, a2, a4, a8], GReg[a3, a4]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a1, a2, a5, a8], GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a2, a5, a8], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a2, a5, a8], GReg[a3, a4, a2]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a2, a5, a8], GReg[a3, a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a2, a6, a8], GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a1, a2, a6, a8], GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a6]] - CT[GReg[a1, a2, a6, a8], 
     GReg[a5, a6]*GReg[a7, a6]*GReg[a3, a4, a2]] + 
    CT[GReg[a1, a2, a6, a8], GReg[a5, a6]*GReg[a7, a6]*GReg[a3, a4, a6]] - 
    CT[GReg[a1, a2, a6, a8], GReg[a3, a2]*GReg[a7, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a2, a6, a8], GReg[a3, a6]*GReg[a7, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a2, a6, a8], GReg[a7, a6]*GReg[a3, a4, a5, a2]] - 
    CT[GReg[a1, a2, a6, a8], GReg[a7, a6]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]] + CT[GReg[a1, a2, a7, a8], GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a1, a2, a7, a8], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a3, a4, a2]] - 
    CT[GReg[a1, a2, a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a3, a4, a7]] + 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a2]*GReg[a6, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a7]*GReg[a6, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a4, a2]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a2, a7, a8], GReg[a6, a7]*GReg[a3, a4, a5, a2]] + 
    CT[GReg[a1, a2, a7, a8], GReg[a6, a7]*GReg[a3, a4, a5, a7]] - 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a2]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a7]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a4, a5, a6, a2]] - 
    CT[GReg[a1, a2, a7, a8], GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a1, a3, a4, a8], GReg[a2, a1]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a1, a3, a4, a8], GReg[a2, a3]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a1, a3, a5, a8], GReg[a2, a1]*GReg[a4, a3]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a3, a5, a8], GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a3, a5, a8], GReg[a2, a1]*GReg[a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a3, a5, a8], GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a3, a6, a8], GReg[a2, a1]*GReg[a4, a3]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a1, a3, a6, a8], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a1, a3, a6, a8], 
     GReg[a2, a1]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a1, a3, a6, a8], GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a1, a3, a6, a8], GReg[a2, a1]*GReg[a7, a6]*
      GReg[a4, a5, a3]] - CT[GReg[a1, a3, a6, a8], GReg[a2, a3]*GReg[a7, a6]*
      GReg[a4, a5, a3]] - CT[GReg[a1, a3, a6, a8], GReg[a2, a1]*GReg[a7, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a1, a3, a6, a8], GReg[a2, a3]*GReg[a7, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a1, a3, a7, a8], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a1, a3, a7, a8], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a1]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]] + CT[GReg[a1, a3, a7, a8], GReg[a2, a3]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a1, a3, a7, a8], 
     GReg[a2, a1]*GReg[a6, a7]*GReg[a4, a5, a3]] + 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a3]*GReg[a6, a7]*GReg[a4, a5, a3]] + 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a1]*GReg[a6, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a3]*GReg[a6, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a1]*GReg[a4, a3]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a1]*GReg[a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a3]*GReg[a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a1]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a3]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a1]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a1, a3, a7, a8], GReg[a2, a3]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a1, a4, a5, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a4, a5, a8], GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a4, a5, a8], GReg[a2, a3, a1]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a4, a5, a8], GReg[a2, a3, a4]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a4, a6, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a6]] + CT[GReg[a1, a4, a6, a8], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a7, a6]] + CT[GReg[a1, a4, a6, a8], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a1, a4, a6, a8], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a1, a4, a6, a8], GReg[a5, a4]*GReg[a7, a6]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a4, a6, a8], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a4, a6, a8], GReg[a5, a4]*GReg[a7, a6]*
      GReg[a2, a3, a4]] + CT[GReg[a1, a4, a6, a8], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a4]] + CT[GReg[a1, a4, a7, a8], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a6, a7]] - CT[GReg[a1, a4, a7, a8], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]] - 
    CT[GReg[a1, a4, a7, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a7]*
      GReg[a6, a7]] + CT[GReg[a1, a4, a7, a8], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a1, a4, a7, a8], 
     GReg[a5, a4]*GReg[a6, a7]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a4, a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a4, a7, a8], GReg[a5, a4]*GReg[a6, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a1, a4, a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a1, a4, a7, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a4, a7, a8], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a4, a7, a8], GReg[a2, a3, a1]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a4, a7, a8], GReg[a2, a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a4, a7, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a4, a7, a8], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a4, a7, a8], GReg[a2, a3, a1]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a4, a7, a8], GReg[a2, a3, a4]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a5, a6, a8], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a6]] - CT[GReg[a1, a5, a6, a8], GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a7, a6]] - CT[GReg[a1, a5, a6, a8], 
     GReg[a4, a5]*GReg[a7, a6]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a5, a6, a8], GReg[a4, a5]*GReg[a7, a6]*GReg[a2, a3, a5]] - 
    CT[GReg[a1, a5, a6, a8], GReg[a2, a1]*GReg[a7, a6]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a6, a8], GReg[a2, a5]*GReg[a7, a6]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a6, a8], GReg[a7, a6]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a6, a8], GReg[a7, a6]*GReg[a2, a3, a4, a5]] + 
    CT[GReg[a1, a5, a7, a8], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a1, a5, a7, a8], GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a5]] - CT[GReg[a1, a5, a7, a8], 
     GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]] + 
    CT[GReg[a1, a5, a7, a8], GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]] - CT[GReg[a1, a5, a7, a8], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a2, a3, a1]] + CT[GReg[a1, a5, a7, a8], GReg[a4, a5]*GReg[a6, a7]*
      GReg[a2, a3, a1]] + CT[GReg[a1, a5, a7, a8], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a2, a3, a5]] - CT[GReg[a1, a5, a7, a8], GReg[a4, a5]*GReg[a6, a7]*
      GReg[a2, a3, a5]] - CT[GReg[a1, a5, a7, a8], GReg[a2, a1]*GReg[a6, a5]*
      GReg[a3, a4, a5]] + CT[GReg[a1, a5, a7, a8], GReg[a2, a5]*GReg[a6, a5]*
      GReg[a3, a4, a5]] + CT[GReg[a1, a5, a7, a8], GReg[a2, a1]*GReg[a6, a7]*
      GReg[a3, a4, a5]] - CT[GReg[a1, a5, a7, a8], GReg[a2, a5]*GReg[a6, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a1, a5, a7, a8], 
     GReg[a6, a5]*GReg[a2, a3, a4, a1]] - CT[GReg[a1, a5, a7, a8], 
     GReg[a6, a7]*GReg[a2, a3, a4, a1]] - CT[GReg[a1, a5, a7, a8], 
     GReg[a6, a5]*GReg[a2, a3, a4, a5]] + CT[GReg[a1, a5, a7, a8], 
     GReg[a6, a7]*GReg[a2, a3, a4, a5]] - CT[GReg[a1, a6, a7, a8], 
     GReg[a2, a1]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a1, a6, a7, a8], GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a1, a6, a7, a8], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a6, a7, a8], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a2, a3, a6]] + CT[GReg[a1, a6, a7, a8], GReg[a2, a1]*GReg[a5, a6]*
      GReg[a3, a4, a6]] - CT[GReg[a1, a6, a7, a8], GReg[a2, a6]*GReg[a5, a6]*
      GReg[a3, a4, a6]] + CT[GReg[a1, a6, a7, a8], GReg[a2, a1]*GReg[a3, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a1, a6, a7, a8], GReg[a2, a6]*GReg[a3, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a1, a6, a7, a8], 
     GReg[a2, a3, a1]*GReg[a4, a5, a6]] + CT[GReg[a1, a6, a7, a8], 
     GReg[a2, a3, a6]*GReg[a4, a5, a6]] - CT[GReg[a1, a6, a7, a8], 
     GReg[a5, a6]*GReg[a2, a3, a4, a1]] + CT[GReg[a1, a6, a7, a8], 
     GReg[a5, a6]*GReg[a2, a3, a4, a6]] - CT[GReg[a1, a6, a7, a8], 
     GReg[a2, a1]*GReg[a3, a4, a5, a6]] + CT[GReg[a1, a6, a7, a8], 
     GReg[a2, a6]*GReg[a3, a4, a5, a6]] + CT[GReg[a1, a6, a7, a8], 
     GReg[a2, a3, a4, a5, a1]] - CT[GReg[a1, a6, a7, a8], 
     GReg[a2, a3, a4, a5, a6]] - CT[GReg[a2, a3, a4, a8], 
     GReg[a1, a2]*GReg[a5, a6, a7, a4]] + CT[GReg[a2, a3, a4, a8], 
     GReg[a1, a8]*GReg[a5, a6, a7, a4]] - CT[GReg[a2, a3, a5, a8], 
     GReg[a1, a2]*GReg[a4, a3]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a3, a5, a8], GReg[a1, a8]*GReg[a4, a3]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a3, a5, a8], GReg[a1, a2]*GReg[a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a2, a3, a5, a8], GReg[a1, a8]*GReg[a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a3, a6, a8], GReg[a1, a2]*GReg[a4, a3]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a2, a3, a6, a8], GReg[a1, a8]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a7, a6]] - CT[GReg[a2, a3, a6, a8], 
     GReg[a1, a2]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a2, a3, a6, a8], GReg[a1, a8]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a2, a3, a6, a8], GReg[a1, a2]*GReg[a7, a6]*
      GReg[a4, a5, a3]] + CT[GReg[a2, a3, a6, a8], GReg[a1, a8]*GReg[a7, a6]*
      GReg[a4, a5, a3]] + CT[GReg[a2, a3, a6, a8], GReg[a1, a2]*GReg[a7, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a3, a6, a8], GReg[a1, a8]*GReg[a7, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a3, a7, a8], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a2, a3, a7, a8], 
     GReg[a1, a8]*GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a2]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a2, a3, a7, a8], GReg[a1, a8]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a2, a3, a7, a8], 
     GReg[a1, a2]*GReg[a6, a7]*GReg[a4, a5, a3]] - 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a8]*GReg[a6, a7]*GReg[a4, a5, a3]] - 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a2]*GReg[a6, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a8]*GReg[a6, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a2]*GReg[a4, a3]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a8]*GReg[a4, a3]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a2]*GReg[a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a8]*GReg[a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a2]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a8]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a2]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a2, a3, a7, a8], GReg[a1, a8]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a2, a4, a5, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a4, a5, a8], GReg[a1, a8]*GReg[a3, a2]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a4, a5, a8], GReg[a1, a2]*GReg[a3, a4]*GReg[a6, a7, a5]] - 
    CT[GReg[a2, a4, a5, a8], GReg[a1, a8]*GReg[a3, a4]*GReg[a6, a7, a5]] - 
    CT[GReg[a2, a4, a6, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]*
      GReg[a7, a6]] + CT[GReg[a2, a4, a6, a8], GReg[a1, a8]*GReg[a3, a2]*
      GReg[a5, a4]*GReg[a7, a6]] + CT[GReg[a2, a4, a6, a8], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a6]] - 
    CT[GReg[a2, a4, a6, a8], GReg[a1, a8]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a6]] + CT[GReg[a2, a4, a6, a8], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a5, a6]*GReg[a7, a6]] - CT[GReg[a2, a4, a6, a8], 
     GReg[a1, a8]*GReg[a3, a2]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a2, a4, a6, a8], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a2, a4, a6, a8], GReg[a1, a8]*GReg[a3, a4]*
      GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a2, a4, a7, a8], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]*GReg[a6, a7]] - 
    CT[GReg[a2, a4, a7, a8], GReg[a1, a8]*GReg[a3, a2]*GReg[a5, a4]*
      GReg[a6, a7]] - CT[GReg[a2, a4, a7, a8], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a6, a7]] + CT[GReg[a2, a4, a7, a8], 
     GReg[a1, a8]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]] - 
    CT[GReg[a2, a4, a7, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a7]*
      GReg[a6, a7]] + CT[GReg[a2, a4, a7, a8], GReg[a1, a8]*GReg[a3, a2]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a2, a4, a7, a8], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a2, a4, a7, a8], GReg[a1, a8]*GReg[a3, a4]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a2, a4, a7, a8], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a5, a6, a4]] + CT[GReg[a2, a4, a7, a8], GReg[a1, a8]*GReg[a3, a2]*
      GReg[a5, a6, a4]] + CT[GReg[a2, a4, a7, a8], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a5, a6, a4]] - CT[GReg[a2, a4, a7, a8], GReg[a1, a8]*GReg[a3, a4]*
      GReg[a5, a6, a4]] + CT[GReg[a2, a4, a7, a8], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a5, a6, a7]] - CT[GReg[a2, a4, a7, a8], GReg[a1, a8]*GReg[a3, a2]*
      GReg[a5, a6, a7]] - CT[GReg[a2, a4, a7, a8], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a5, a6, a7]] + CT[GReg[a2, a4, a7, a8], GReg[a1, a8]*GReg[a3, a4]*
      GReg[a5, a6, a7]] + CT[GReg[a2, a5, a6, a8], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a7, a6]] - CT[GReg[a2, a5, a6, a8], 
     GReg[a1, a8]*GReg[a3, a2]*GReg[a4, a5]*GReg[a7, a6]] - 
    CT[GReg[a2, a5, a6, a8], GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a6]] + CT[GReg[a2, a5, a6, a8], GReg[a1, a8]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a7, a6]] - CT[GReg[a2, a5, a6, a8], 
     GReg[a1, a2]*GReg[a7, a6]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a6, a8], GReg[a1, a8]*GReg[a7, a6]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a6, a8], GReg[a1, a2]*GReg[a7, a6]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a5, a6, a8], GReg[a1, a8]*GReg[a7, a6]*GReg[a3, a4, a5]] + 
    CT[GReg[a2, a5, a7, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a2, a5, a7, a8], GReg[a1, a8]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a6, a5]] - CT[GReg[a2, a5, a7, a8], 
     GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a2, a5, a7, a8], GReg[a1, a8]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a2, a5, a7, a8], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a6, a7]] + CT[GReg[a2, a5, a7, a8], 
     GReg[a1, a8]*GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a7]] + 
    CT[GReg[a2, a5, a7, a8], GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]] - CT[GReg[a2, a5, a7, a8], GReg[a1, a8]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a7]] - CT[GReg[a2, a5, a7, a8], 
     GReg[a1, a2]*GReg[a6, a5]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a7, a8], GReg[a1, a8]*GReg[a6, a5]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a7, a8], GReg[a1, a2]*GReg[a6, a7]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a5, a7, a8], GReg[a1, a8]*GReg[a6, a7]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a7, a8], GReg[a1, a2]*GReg[a6, a5]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a5, a7, a8], GReg[a1, a8]*GReg[a6, a5]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a5, a7, a8], GReg[a1, a2]*GReg[a6, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a2, a5, a7, a8], GReg[a1, a8]*GReg[a6, a7]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a6, a7, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a2, a6, a7, a8], GReg[a1, a8]*GReg[a3, a2]*
      GReg[a4, a6]*GReg[a5, a6]] + CT[GReg[a2, a6, a7, a8], 
     GReg[a1, a2]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a2, a6, a7, a8], GReg[a1, a8]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a2, a6, a7, a8], GReg[a1, a2]*GReg[a5, a6]*
      GReg[a3, a4, a2]] - CT[GReg[a2, a6, a7, a8], GReg[a1, a8]*GReg[a5, a6]*
      GReg[a3, a4, a2]] - CT[GReg[a2, a6, a7, a8], GReg[a1, a2]*GReg[a5, a6]*
      GReg[a3, a4, a6]] + CT[GReg[a2, a6, a7, a8], GReg[a1, a8]*GReg[a5, a6]*
      GReg[a3, a4, a6]] + CT[GReg[a2, a6, a7, a8], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a6, a7, a8], GReg[a1, a8]*GReg[a3, a2]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a6, a7, a8], GReg[a1, a2]*GReg[a3, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a2, a6, a7, a8], GReg[a1, a8]*GReg[a3, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a6, a7, a8], 
     GReg[a1, a2]*GReg[a3, a4, a5, a2]] + CT[GReg[a2, a6, a7, a8], 
     GReg[a1, a8]*GReg[a3, a4, a5, a2]] + CT[GReg[a2, a6, a7, a8], 
     GReg[a1, a2]*GReg[a3, a4, a5, a6]] - CT[GReg[a2, a6, a7, a8], 
     GReg[a1, a8]*GReg[a3, a4, a5, a6]] + CT[GReg[a3, a4, a5, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a7, a5]] - 
    CT[GReg[a3, a4, a5, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a6, a7, a5]] - 
    CT[GReg[a3, a4, a5, a8], GReg[a1, a2, a3]*GReg[a6, a7, a5]] + 
    CT[GReg[a3, a4, a5, a8], GReg[a1, a2, a8]*GReg[a6, a7, a5]] + 
    CT[GReg[a3, a4, a6, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a4]*
      GReg[a7, a6]] - CT[GReg[a3, a4, a6, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a5, a4]*GReg[a7, a6]] - CT[GReg[a3, a4, a6, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a3, a4, a6, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a3, a4, a6, a8], GReg[a5, a4]*GReg[a7, a6]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a4, a6, a8], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a4, a6, a8], GReg[a5, a4]*GReg[a7, a6]*
      GReg[a1, a2, a8]] - CT[GReg[a3, a4, a6, a8], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a8]] - CT[GReg[a3, a4, a7, a8], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a5, a4]*GReg[a6, a7]] + CT[GReg[a3, a4, a7, a8], 
     GReg[a1, a8]*GReg[a2, a3]*GReg[a5, a4]*GReg[a6, a7]] + 
    CT[GReg[a3, a4, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a3, a4, a7, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a3, a4, a7, a8], 
     GReg[a5, a4]*GReg[a6, a7]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a4, a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a4, a7, a8], GReg[a5, a4]*GReg[a6, a7]*GReg[a1, a2, a8]] + 
    CT[GReg[a3, a4, a7, a8], GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a8]] + 
    CT[GReg[a3, a4, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6, a4]] - 
    CT[GReg[a3, a4, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a5, a6, a4]] - 
    CT[GReg[a3, a4, a7, a8], GReg[a1, a2, a3]*GReg[a5, a6, a4]] + 
    CT[GReg[a3, a4, a7, a8], GReg[a1, a2, a8]*GReg[a5, a6, a4]] - 
    CT[GReg[a3, a4, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6, a7]] + 
    CT[GReg[a3, a4, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a5, a6, a7]] + 
    CT[GReg[a3, a4, a7, a8], GReg[a1, a2, a3]*GReg[a5, a6, a7]] - 
    CT[GReg[a3, a4, a7, a8], GReg[a1, a2, a8]*GReg[a5, a6, a7]] + 
    CT[GReg[a3, a5, a6, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a7, a6]] - CT[GReg[a3, a5, a6, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a7, a6]] - CT[GReg[a3, a5, a6, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*GReg[a7, a6]] + 
    CT[GReg[a3, a5, a6, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a7, a6]] - CT[GReg[a3, a5, a6, a8], GReg[a4, a3]*GReg[a7, a6]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a5, a6, a8], GReg[a4, a5]*GReg[a7, a6]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a5, a6, a8], GReg[a4, a3]*GReg[a7, a6]*
      GReg[a1, a2, a8]] - CT[GReg[a3, a5, a6, a8], GReg[a4, a5]*GReg[a7, a6]*
      GReg[a1, a2, a8]] + CT[GReg[a3, a5, a7, a8], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a6, a5]] - CT[GReg[a3, a5, a7, a8], 
     GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a5]] - 
    CT[GReg[a3, a5, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a5]] + CT[GReg[a3, a5, a7, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a4, a5]*GReg[a6, a5]] - CT[GReg[a3, a5, a7, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a7]] + 
    CT[GReg[a3, a5, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a7]] + CT[GReg[a3, a5, a7, a8], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a5]*GReg[a6, a7]] - CT[GReg[a3, a5, a7, a8], 
     GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a7]] - 
    CT[GReg[a3, a5, a7, a8], GReg[a4, a3]*GReg[a6, a5]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a7, a8], GReg[a4, a5]*GReg[a6, a5]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a7, a8], GReg[a4, a3]*GReg[a6, a7]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a5, a7, a8], GReg[a4, a5]*GReg[a6, a7]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a7, a8], GReg[a4, a3]*GReg[a6, a5]*GReg[a1, a2, a8]] - 
    CT[GReg[a3, a5, a7, a8], GReg[a4, a5]*GReg[a6, a5]*GReg[a1, a2, a8]] - 
    CT[GReg[a3, a5, a7, a8], GReg[a4, a3]*GReg[a6, a7]*GReg[a1, a2, a8]] + 
    CT[GReg[a3, a5, a7, a8], GReg[a4, a5]*GReg[a6, a7]*GReg[a1, a2, a8]] - 
    CT[GReg[a3, a6, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a5, a6]] + CT[GReg[a3, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a6]] + CT[GReg[a3, a6, a7, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a3, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a3, a6, a7, a8], GReg[a4, a3]*GReg[a5, a6]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a6, a7, a8], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a6, a7, a8], GReg[a4, a3]*GReg[a5, a6]*
      GReg[a1, a2, a8]] + CT[GReg[a3, a6, a7, a8], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a1, a2, a8]] + CT[GReg[a3, a6, a7, a8], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a5, a3]] - CT[GReg[a3, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3]*
      GReg[a4, a5, a3]] - CT[GReg[a3, a6, a7, a8], 
     GReg[a1, a2, a3]*GReg[a4, a5, a3]] + CT[GReg[a3, a6, a7, a8], 
     GReg[a1, a2, a8]*GReg[a4, a5, a3]] - CT[GReg[a3, a6, a7, a8], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a6]] + 
    CT[GReg[a3, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a5, a6]] + 
    CT[GReg[a3, a6, a7, a8], GReg[a1, a2, a3]*GReg[a4, a5, a6]] - 
    CT[GReg[a3, a6, a7, a8], GReg[a1, a2, a8]*GReg[a4, a5, a6]] - 
    CT[GReg[a4, a5, a6, a8], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a7, a6]] + CT[GReg[a4, a5, a6, a8], GReg[a1, a8]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a7, a6]] + CT[GReg[a4, a5, a6, a8], 
     GReg[a3, a4]*GReg[a7, a6]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a5, a6, a8], GReg[a3, a4]*GReg[a7, a6]*GReg[a1, a2, a8]] + 
    CT[GReg[a4, a5, a6, a8], GReg[a1, a4]*GReg[a7, a6]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6, a8], GReg[a1, a8]*GReg[a7, a6]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6, a8], GReg[a7, a6]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a6, a8], GReg[a7, a6]*GReg[a1, a2, a3, a8]] - 
    CT[GReg[a4, a5, a7, a8], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a5]] + CT[GReg[a4, a5, a7, a8], GReg[a1, a8]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a6, a5]] + CT[GReg[a4, a5, a7, a8], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7]] - 
    CT[GReg[a4, a5, a7, a8], GReg[a1, a8]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a7]] + CT[GReg[a4, a5, a7, a8], GReg[a3, a4]*GReg[a6, a5]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a5, a7, a8], GReg[a3, a4]*GReg[a6, a7]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a5, a7, a8], GReg[a3, a4]*GReg[a6, a5]*
      GReg[a1, a2, a8]] + CT[GReg[a4, a5, a7, a8], GReg[a3, a4]*GReg[a6, a7]*
      GReg[a1, a2, a8]] + CT[GReg[a4, a5, a7, a8], GReg[a1, a4]*GReg[a6, a5]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a5, a7, a8], GReg[a1, a8]*GReg[a6, a5]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a5, a7, a8], GReg[a1, a4]*GReg[a6, a7]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a5, a7, a8], GReg[a1, a8]*GReg[a6, a7]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a5, a7, a8], 
     GReg[a6, a5]*GReg[a1, a2, a3, a4]] + CT[GReg[a4, a5, a7, a8], 
     GReg[a6, a7]*GReg[a1, a2, a3, a4]] + CT[GReg[a4, a5, a7, a8], 
     GReg[a6, a5]*GReg[a1, a2, a3, a8]] - CT[GReg[a4, a5, a7, a8], 
     GReg[a6, a7]*GReg[a1, a2, a3, a8]] - CT[GReg[a4, a6, a7, a8], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a4, a6, a7, a8], GReg[a1, a8]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]] + CT[GReg[a4, a6, a7, a8], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a6]] - CT[GReg[a4, a6, a7, a8], 
     GReg[a1, a8]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]] + 
    CT[GReg[a4, a6, a7, a8], GReg[a3, a4]*GReg[a5, a4]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a6, a7, a8], GReg[a3, a4]*GReg[a5, a6]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a6, a7, a8], GReg[a3, a4]*GReg[a5, a4]*GReg[a1, a2, a8]] + 
    CT[GReg[a4, a6, a7, a8], GReg[a3, a4]*GReg[a5, a6]*GReg[a1, a2, a8]] + 
    CT[GReg[a4, a6, a7, a8], GReg[a1, a4]*GReg[a5, a4]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6, a7, a8], GReg[a1, a8]*GReg[a5, a4]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6, a7, a8], GReg[a1, a4]*GReg[a5, a6]*GReg[a2, a3, a4]] + 
    CT[GReg[a4, a6, a7, a8], GReg[a1, a8]*GReg[a5, a6]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6, a7, a8], GReg[a5, a4]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6, a7, a8], GReg[a5, a6]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6, a7, a8], GReg[a5, a4]*GReg[a1, a2, a3, a8]] - 
    CT[GReg[a4, a6, a7, a8], GReg[a5, a6]*GReg[a1, a2, a3, a8]] + 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]] - CT[GReg[a5, a6, a7, a8], GReg[a1, a8]*GReg[a2, a5]*
      GReg[a3, a5]*GReg[a4, a5]] - CT[GReg[a5, a6, a7, a8], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a1, a2, a5]] + 
    CT[GReg[a5, a6, a7, a8], GReg[a3, a5]*GReg[a4, a5]*GReg[a1, a2, a8]] - 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a5]*GReg[a4, a5]*GReg[a2, a3, a5]] + 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a8]*GReg[a4, a5]*GReg[a2, a3, a5]] - 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a8]*GReg[a2, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a2, a5]*GReg[a3, a4, a5]] - 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a2, a8]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6, a7, a8], GReg[a4, a5]*GReg[a1, a2, a3, a5]] - 
    CT[GReg[a5, a6, a7, a8], GReg[a4, a5]*GReg[a1, a2, a3, a8]] + 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a5]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a6, a7, a8], GReg[a1, a2, a3, a4, a8]] + 
    CT[GReg[a1, a2, a3, a4, a8], GReg[a5, a6, a7, a4]] + 
    CT[GReg[a1, a2, a3, a5, a8], GReg[a4, a3]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a2, a3, a5, a8], GReg[a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a2, a3, a6, a8], GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a1, a2, a3, a6, a8], GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a1, a2, a3, a6, a8], GReg[a7, a6]*GReg[a4, a5, a3]] - 
    CT[GReg[a1, a2, a3, a6, a8], GReg[a7, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a2, a3, a7, a8], GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a2, a3, a7, a8], GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a2, a3, a7, a8], GReg[a6, a7]*GReg[a4, a5, a3]] + 
    CT[GReg[a1, a2, a3, a7, a8], GReg[a6, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a2, a3, a7, a8], GReg[a4, a3]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a2, a3, a7, a8], GReg[a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a2, a3, a7, a8], GReg[a4, a5, a6, a3]] - 
    CT[GReg[a1, a2, a3, a7, a8], GReg[a4, a5, a6, a7]] + 
    CT[GReg[a1, a2, a4, a5, a8], GReg[a3, a2]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a2, a4, a5, a8], GReg[a3, a4]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a2, a4, a6, a8], GReg[a3, a2]*GReg[a5, a4]*GReg[a7, a6]] - 
    CT[GReg[a1, a2, a4, a6, a8], GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a6]] - 
    CT[GReg[a1, a2, a4, a6, a8], GReg[a3, a2]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a1, a2, a4, a6, a8], GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a1, a2, a4, a7, a8], GReg[a3, a2]*GReg[a5, a4]*GReg[a6, a7]] + 
    CT[GReg[a1, a2, a4, a7, a8], GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]] + 
    CT[GReg[a1, a2, a4, a7, a8], GReg[a3, a2]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a2, a4, a7, a8], GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a1, a2, a4, a7, a8], GReg[a3, a2]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a2, a4, a7, a8], GReg[a3, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a2, a4, a7, a8], GReg[a3, a2]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a2, a4, a7, a8], GReg[a3, a4]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a2, a5, a6, a8], GReg[a3, a2]*GReg[a4, a5]*GReg[a7, a6]] + 
    CT[GReg[a1, a2, a5, a6, a8], GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a6]] + 
    CT[GReg[a1, a2, a5, a6, a8], GReg[a7, a6]*GReg[a3, a4, a2]] - 
    CT[GReg[a1, a2, a5, a6, a8], GReg[a7, a6]*GReg[a3, a4, a5]] - 
    CT[GReg[a1, a2, a5, a7, a8], GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a1, a2, a5, a7, a8], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a1, a2, a5, a7, a8], GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a7]] - 
    CT[GReg[a1, a2, a5, a7, a8], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]] + 
    CT[GReg[a1, a2, a5, a7, a8], GReg[a6, a5]*GReg[a3, a4, a2]] - 
    CT[GReg[a1, a2, a5, a7, a8], GReg[a6, a7]*GReg[a3, a4, a2]] - 
    CT[GReg[a1, a2, a5, a7, a8], GReg[a6, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a2, a5, a7, a8], GReg[a6, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a2, a6, a7, a8], GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a1, a2, a6, a7, a8], GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a1, a2, a6, a7, a8], GReg[a5, a6]*GReg[a3, a4, a2]] + 
    CT[GReg[a1, a2, a6, a7, a8], GReg[a5, a6]*GReg[a3, a4, a6]] - 
    CT[GReg[a1, a2, a6, a7, a8], GReg[a3, a2]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a2, a6, a7, a8], GReg[a3, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a2, a6, a7, a8], GReg[a3, a4, a5, a2]] - 
    CT[GReg[a1, a2, a6, a7, a8], GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a3, a4, a5, a8], GReg[a2, a1]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a3, a4, a5, a8], GReg[a2, a3]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a3, a4, a6, a8], GReg[a2, a1]*GReg[a5, a4]*GReg[a7, a6]] - 
    CT[GReg[a1, a3, a4, a6, a8], GReg[a2, a3]*GReg[a5, a4]*GReg[a7, a6]] - 
    CT[GReg[a1, a3, a4, a6, a8], GReg[a2, a1]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a1, a3, a4, a6, a8], GReg[a2, a3]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a1, a3, a4, a7, a8], GReg[a2, a1]*GReg[a5, a4]*GReg[a6, a7]] + 
    CT[GReg[a1, a3, a4, a7, a8], GReg[a2, a3]*GReg[a5, a4]*GReg[a6, a7]] + 
    CT[GReg[a1, a3, a4, a7, a8], GReg[a2, a1]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a3, a4, a7, a8], GReg[a2, a3]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a1, a3, a4, a7, a8], GReg[a2, a1]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a3, a4, a7, a8], GReg[a2, a3]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a3, a4, a7, a8], GReg[a2, a1]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a3, a4, a7, a8], GReg[a2, a3]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a3, a5, a6, a8], GReg[a2, a1]*GReg[a4, a3]*GReg[a7, a6]] - 
    CT[GReg[a1, a3, a5, a6, a8], GReg[a2, a3]*GReg[a4, a3]*GReg[a7, a6]] - 
    CT[GReg[a1, a3, a5, a6, a8], GReg[a2, a1]*GReg[a4, a5]*GReg[a7, a6]] + 
    CT[GReg[a1, a3, a5, a6, a8], GReg[a2, a3]*GReg[a4, a5]*GReg[a7, a6]] + 
    CT[GReg[a1, a3, a5, a7, a8], GReg[a2, a1]*GReg[a4, a3]*GReg[a6, a5]] - 
    CT[GReg[a1, a3, a5, a7, a8], GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a5]] - 
    CT[GReg[a1, a3, a5, a7, a8], GReg[a2, a1]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a1, a3, a5, a7, a8], GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a1, a3, a5, a7, a8], GReg[a2, a1]*GReg[a4, a3]*GReg[a6, a7]] + 
    CT[GReg[a1, a3, a5, a7, a8], GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a7]] + 
    CT[GReg[a1, a3, a5, a7, a8], GReg[a2, a1]*GReg[a4, a5]*GReg[a6, a7]] - 
    CT[GReg[a1, a3, a5, a7, a8], GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a7]] - 
    CT[GReg[a1, a3, a6, a7, a8], GReg[a2, a1]*GReg[a4, a3]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a6, a7, a8], GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a6, a7, a8], GReg[a2, a1]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a1, a3, a6, a7, a8], GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a6, a7, a8], GReg[a2, a1]*GReg[a4, a5, a3]] - 
    CT[GReg[a1, a3, a6, a7, a8], GReg[a2, a3]*GReg[a4, a5, a3]] - 
    CT[GReg[a1, a3, a6, a7, a8], GReg[a2, a1]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a3, a6, a7, a8], GReg[a2, a3]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a4, a5, a6, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a7, a6]] + 
    CT[GReg[a1, a4, a5, a6, a8], GReg[a2, a4]*GReg[a3, a4]*GReg[a7, a6]] + 
    CT[GReg[a1, a4, a5, a6, a8], GReg[a7, a6]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a5, a6, a8], GReg[a7, a6]*GReg[a2, a3, a4]] - 
    CT[GReg[a1, a4, a5, a7, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a6, a5]] + 
    CT[GReg[a1, a4, a5, a7, a8], GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a5]] + 
    CT[GReg[a1, a4, a5, a7, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a6, a7]] - 
    CT[GReg[a1, a4, a5, a7, a8], GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7]] + 
    CT[GReg[a1, a4, a5, a7, a8], GReg[a6, a5]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a5, a7, a8], GReg[a6, a7]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a5, a7, a8], GReg[a6, a5]*GReg[a2, a3, a4]] + 
    CT[GReg[a1, a4, a5, a7, a8], GReg[a6, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a1, a4, a6, a7, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a1, a4, a6, a7, a8], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a1, a4, a6, a7, a8], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6]] - 
    CT[GReg[a1, a4, a6, a7, a8], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]] + 
    CT[GReg[a1, a4, a6, a7, a8], GReg[a5, a4]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a6, a7, a8], GReg[a5, a6]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a6, a7, a8], GReg[a5, a4]*GReg[a2, a3, a4]] + 
    CT[GReg[a1, a4, a6, a7, a8], GReg[a5, a6]*GReg[a2, a3, a4]] + 
    CT[GReg[a1, a5, a6, a7, a8], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a1, a5, a6, a7, a8], GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a1, a5, a6, a7, a8], GReg[a4, a5]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a5, a6, a7, a8], GReg[a4, a5]*GReg[a2, a3, a5]] - 
    CT[GReg[a1, a5, a6, a7, a8], GReg[a2, a1]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a6, a7, a8], GReg[a2, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a6, a7, a8], GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a6, a7, a8], GReg[a2, a3, a4, a5]] - 
    CT[GReg[a2, a3, a4, a5, a8], GReg[a1, a2]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a3, a4, a5, a8], GReg[a1, a8]*GReg[a6, a7, a5]] - 
    CT[GReg[a2, a3, a4, a6, a8], GReg[a1, a2]*GReg[a5, a4]*GReg[a7, a6]] + 
    CT[GReg[a2, a3, a4, a6, a8], GReg[a1, a8]*GReg[a5, a4]*GReg[a7, a6]] + 
    CT[GReg[a2, a3, a4, a6, a8], GReg[a1, a2]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a2, a3, a4, a6, a8], GReg[a1, a8]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a2, a3, a4, a7, a8], GReg[a1, a2]*GReg[a5, a4]*GReg[a6, a7]] - 
    CT[GReg[a2, a3, a4, a7, a8], GReg[a1, a8]*GReg[a5, a4]*GReg[a6, a7]] - 
    CT[GReg[a2, a3, a4, a7, a8], GReg[a1, a2]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a2, a3, a4, a7, a8], GReg[a1, a8]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a2, a3, a4, a7, a8], GReg[a1, a2]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a3, a4, a7, a8], GReg[a1, a8]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a3, a4, a7, a8], GReg[a1, a2]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a3, a4, a7, a8], GReg[a1, a8]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a3, a5, a6, a8], GReg[a1, a2]*GReg[a4, a3]*GReg[a7, a6]] + 
    CT[GReg[a2, a3, a5, a6, a8], GReg[a1, a8]*GReg[a4, a3]*GReg[a7, a6]] + 
    CT[GReg[a2, a3, a5, a6, a8], GReg[a1, a2]*GReg[a4, a5]*GReg[a7, a6]] - 
    CT[GReg[a2, a3, a5, a6, a8], GReg[a1, a8]*GReg[a4, a5]*GReg[a7, a6]] - 
    CT[GReg[a2, a3, a5, a7, a8], GReg[a1, a2]*GReg[a4, a3]*GReg[a6, a5]] + 
    CT[GReg[a2, a3, a5, a7, a8], GReg[a1, a8]*GReg[a4, a3]*GReg[a6, a5]] + 
    CT[GReg[a2, a3, a5, a7, a8], GReg[a1, a2]*GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a2, a3, a5, a7, a8], GReg[a1, a8]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a2, a3, a5, a7, a8], GReg[a1, a2]*GReg[a4, a3]*GReg[a6, a7]] - 
    CT[GReg[a2, a3, a5, a7, a8], GReg[a1, a8]*GReg[a4, a3]*GReg[a6, a7]] - 
    CT[GReg[a2, a3, a5, a7, a8], GReg[a1, a2]*GReg[a4, a5]*GReg[a6, a7]] + 
    CT[GReg[a2, a3, a5, a7, a8], GReg[a1, a8]*GReg[a4, a5]*GReg[a6, a7]] + 
    CT[GReg[a2, a3, a6, a7, a8], GReg[a1, a2]*GReg[a4, a3]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a6, a7, a8], GReg[a1, a8]*GReg[a4, a3]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a6, a7, a8], GReg[a1, a2]*GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a2, a3, a6, a7, a8], GReg[a1, a8]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a6, a7, a8], GReg[a1, a2]*GReg[a4, a5, a3]] + 
    CT[GReg[a2, a3, a6, a7, a8], GReg[a1, a8]*GReg[a4, a5, a3]] + 
    CT[GReg[a2, a3, a6, a7, a8], GReg[a1, a2]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a3, a6, a7, a8], GReg[a1, a8]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a4, a5, a6, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a7, a6]] + 
    CT[GReg[a2, a4, a5, a6, a8], GReg[a1, a8]*GReg[a3, a2]*GReg[a7, a6]] + 
    CT[GReg[a2, a4, a5, a6, a8], GReg[a1, a2]*GReg[a3, a4]*GReg[a7, a6]] - 
    CT[GReg[a2, a4, a5, a6, a8], GReg[a1, a8]*GReg[a3, a4]*GReg[a7, a6]] - 
    CT[GReg[a2, a4, a5, a7, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a6, a5]] + 
    CT[GReg[a2, a4, a5, a7, a8], GReg[a1, a8]*GReg[a3, a2]*GReg[a6, a5]] + 
    CT[GReg[a2, a4, a5, a7, a8], GReg[a1, a2]*GReg[a3, a4]*GReg[a6, a5]] - 
    CT[GReg[a2, a4, a5, a7, a8], GReg[a1, a8]*GReg[a3, a4]*GReg[a6, a5]] + 
    CT[GReg[a2, a4, a5, a7, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a6, a7]] - 
    CT[GReg[a2, a4, a5, a7, a8], GReg[a1, a8]*GReg[a3, a2]*GReg[a6, a7]] - 
    CT[GReg[a2, a4, a5, a7, a8], GReg[a1, a2]*GReg[a3, a4]*GReg[a6, a7]] + 
    CT[GReg[a2, a4, a5, a7, a8], GReg[a1, a8]*GReg[a3, a4]*GReg[a6, a7]] - 
    CT[GReg[a2, a4, a6, a7, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]] + 
    CT[GReg[a2, a4, a6, a7, a8], GReg[a1, a8]*GReg[a3, a2]*GReg[a5, a4]] + 
    CT[GReg[a2, a4, a6, a7, a8], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]] - 
    CT[GReg[a2, a4, a6, a7, a8], GReg[a1, a8]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a2, a4, a6, a7, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a6]] - 
    CT[GReg[a2, a4, a6, a7, a8], GReg[a1, a8]*GReg[a3, a2]*GReg[a5, a6]] - 
    CT[GReg[a2, a4, a6, a7, a8], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6]] + 
    CT[GReg[a2, a4, a6, a7, a8], GReg[a1, a8]*GReg[a3, a4]*GReg[a5, a6]] + 
    CT[GReg[a2, a5, a6, a7, a8], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]] - 
    CT[GReg[a2, a5, a6, a7, a8], GReg[a1, a8]*GReg[a3, a2]*GReg[a4, a5]] - 
    CT[GReg[a2, a5, a6, a7, a8], GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]] + 
    CT[GReg[a2, a5, a6, a7, a8], GReg[a1, a8]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a2, a5, a6, a7, a8], GReg[a1, a2]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a6, a7, a8], GReg[a1, a8]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a6, a7, a8], GReg[a1, a2]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a5, a6, a7, a8], GReg[a1, a8]*GReg[a3, a4, a5]] + 
    CT[GReg[a3, a4, a5, a6, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a7, a6]] - 
    CT[GReg[a3, a4, a5, a6, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a7, a6]] - 
    CT[GReg[a3, a4, a5, a6, a8], GReg[a7, a6]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a5, a6, a8], GReg[a7, a6]*GReg[a1, a2, a8]] + 
    CT[GReg[a3, a4, a5, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a5]] - 
    CT[GReg[a3, a4, a5, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a6, a5]] - 
    CT[GReg[a3, a4, a5, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a7]] + 
    CT[GReg[a3, a4, a5, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a6, a7]] - 
    CT[GReg[a3, a4, a5, a7, a8], GReg[a6, a5]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a5, a7, a8], GReg[a6, a7]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a5, a7, a8], GReg[a6, a5]*GReg[a1, a2, a8]] - 
    CT[GReg[a3, a4, a5, a7, a8], GReg[a6, a7]*GReg[a1, a2, a8]] + 
    CT[GReg[a3, a4, a6, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a4]] - 
    CT[GReg[a3, a4, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a5, a4]] - 
    CT[GReg[a3, a4, a6, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6]] + 
    CT[GReg[a3, a4, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a5, a6]] - 
    CT[GReg[a3, a4, a6, a7, a8], GReg[a5, a4]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a6, a7, a8], GReg[a5, a6]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a6, a7, a8], GReg[a5, a4]*GReg[a1, a2, a8]] - 
    CT[GReg[a3, a4, a6, a7, a8], GReg[a5, a6]*GReg[a1, a2, a8]] + 
    CT[GReg[a3, a5, a6, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]] - 
    CT[GReg[a3, a5, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a3]] - 
    CT[GReg[a3, a5, a6, a7, a8], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]] + 
    CT[GReg[a3, a5, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3]*GReg[a4, a5]] - 
    CT[GReg[a3, a5, a6, a7, a8], GReg[a4, a3]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a6, a7, a8], GReg[a4, a5]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a6, a7, a8], GReg[a4, a3]*GReg[a1, a2, a8]] - 
    CT[GReg[a3, a5, a6, a7, a8], GReg[a4, a5]*GReg[a1, a2, a8]] - 
    CT[GReg[a4, a5, a6, a7, a8], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]] + 
    CT[GReg[a4, a5, a6, a7, a8], GReg[a1, a8]*GReg[a2, a4]*GReg[a3, a4]] + 
    CT[GReg[a4, a5, a6, a7, a8], GReg[a3, a4]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a5, a6, a7, a8], GReg[a3, a4]*GReg[a1, a2, a8]] + 
    CT[GReg[a4, a5, a6, a7, a8], GReg[a1, a4]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6, a7, a8], GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a6, a7, a8], GReg[a1, a2, a3, a8]] + 
    CT[GReg[a1, a2, a3, a4, a5, a8], GReg[a6, a7, a5]] + 
    CT[GReg[a1, a2, a3, a4, a6, a8], GReg[a5, a4]*GReg[a7, a6]] - 
    CT[GReg[a1, a2, a3, a4, a6, a8], GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a1, a2, a3, a4, a7, a8], GReg[a5, a4]*GReg[a6, a7]] + 
    CT[GReg[a1, a2, a3, a4, a7, a8], GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a1, a2, a3, a4, a7, a8], GReg[a5, a6, a4]] - 
    CT[GReg[a1, a2, a3, a4, a7, a8], GReg[a5, a6, a7]] + 
    CT[GReg[a1, a2, a3, a5, a6, a8], GReg[a4, a3]*GReg[a7, a6]] - 
    CT[GReg[a1, a2, a3, a5, a6, a8], GReg[a4, a5]*GReg[a7, a6]] + 
    CT[GReg[a1, a2, a3, a5, a7, a8], GReg[a4, a3]*GReg[a6, a5]] - 
    CT[GReg[a1, a2, a3, a5, a7, a8], GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a1, a2, a3, a5, a7, a8], GReg[a4, a3]*GReg[a6, a7]] + 
    CT[GReg[a1, a2, a3, a5, a7, a8], GReg[a4, a5]*GReg[a6, a7]] - 
    CT[GReg[a1, a2, a3, a6, a7, a8], GReg[a4, a3]*GReg[a5, a6]] + 
    CT[GReg[a1, a2, a3, a6, a7, a8], GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a1, a2, a3, a6, a7, a8], GReg[a4, a5, a3]] - 
    CT[GReg[a1, a2, a3, a6, a7, a8], GReg[a4, a5, a6]] + 
    CT[GReg[a1, a2, a4, a5, a6, a8], GReg[a3, a2]*GReg[a7, a6]] - 
    CT[GReg[a1, a2, a4, a5, a6, a8], GReg[a3, a4]*GReg[a7, a6]] + 
    CT[GReg[a1, a2, a4, a5, a7, a8], GReg[a3, a2]*GReg[a6, a5]] - 
    CT[GReg[a1, a2, a4, a5, a7, a8], GReg[a3, a4]*GReg[a6, a5]] - 
    CT[GReg[a1, a2, a4, a5, a7, a8], GReg[a3, a2]*GReg[a6, a7]] + 
    CT[GReg[a1, a2, a4, a5, a7, a8], GReg[a3, a4]*GReg[a6, a7]] + 
    CT[GReg[a1, a2, a4, a6, a7, a8], GReg[a3, a2]*GReg[a5, a4]] - 
    CT[GReg[a1, a2, a4, a6, a7, a8], GReg[a3, a4]*GReg[a5, a4]] - 
    CT[GReg[a1, a2, a4, a6, a7, a8], GReg[a3, a2]*GReg[a5, a6]] + 
    CT[GReg[a1, a2, a4, a6, a7, a8], GReg[a3, a4]*GReg[a5, a6]] - 
    CT[GReg[a1, a2, a5, a6, a7, a8], GReg[a3, a2]*GReg[a4, a5]] + 
    CT[GReg[a1, a2, a5, a6, a7, a8], GReg[a3, a5]*GReg[a4, a5]] + 
    CT[GReg[a1, a2, a5, a6, a7, a8], GReg[a3, a4, a2]] - 
    CT[GReg[a1, a2, a5, a6, a7, a8], GReg[a3, a4, a5]] + 
    CT[GReg[a1, a3, a4, a5, a6, a8], GReg[a2, a1]*GReg[a7, a6]] - 
    CT[GReg[a1, a3, a4, a5, a6, a8], GReg[a2, a3]*GReg[a7, a6]] + 
    CT[GReg[a1, a3, a4, a5, a7, a8], GReg[a2, a1]*GReg[a6, a5]] - 
    CT[GReg[a1, a3, a4, a5, a7, a8], GReg[a2, a3]*GReg[a6, a5]] - 
    CT[GReg[a1, a3, a4, a5, a7, a8], GReg[a2, a1]*GReg[a6, a7]] + 
    CT[GReg[a1, a3, a4, a5, a7, a8], GReg[a2, a3]*GReg[a6, a7]] + 
    CT[GReg[a1, a3, a4, a6, a7, a8], GReg[a2, a1]*GReg[a5, a4]] - 
    CT[GReg[a1, a3, a4, a6, a7, a8], GReg[a2, a3]*GReg[a5, a4]] - 
    CT[GReg[a1, a3, a4, a6, a7, a8], GReg[a2, a1]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a4, a6, a7, a8], GReg[a2, a3]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a5, a6, a7, a8], GReg[a2, a1]*GReg[a4, a3]] - 
    CT[GReg[a1, a3, a5, a6, a7, a8], GReg[a2, a3]*GReg[a4, a3]] - 
    CT[GReg[a1, a3, a5, a6, a7, a8], GReg[a2, a1]*GReg[a4, a5]] + 
    CT[GReg[a1, a3, a5, a6, a7, a8], GReg[a2, a3]*GReg[a4, a5]] - 
    CT[GReg[a1, a4, a5, a6, a7, a8], GReg[a2, a1]*GReg[a3, a4]] + 
    CT[GReg[a1, a4, a5, a6, a7, a8], GReg[a2, a4]*GReg[a3, a4]] + 
    CT[GReg[a1, a4, a5, a6, a7, a8], GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a5, a6, a7, a8], GReg[a2, a3, a4]] - 
    CT[GReg[a2, a3, a4, a5, a6, a8], GReg[a1, a2]*GReg[a7, a6]] + 
    CT[GReg[a2, a3, a4, a5, a6, a8], GReg[a1, a8]*GReg[a7, a6]] - 
    CT[GReg[a2, a3, a4, a5, a7, a8], GReg[a1, a2]*GReg[a6, a5]] + 
    CT[GReg[a2, a3, a4, a5, a7, a8], GReg[a1, a8]*GReg[a6, a5]] + 
    CT[GReg[a2, a3, a4, a5, a7, a8], GReg[a1, a2]*GReg[a6, a7]] - 
    CT[GReg[a2, a3, a4, a5, a7, a8], GReg[a1, a8]*GReg[a6, a7]] - 
    CT[GReg[a2, a3, a4, a6, a7, a8], GReg[a1, a2]*GReg[a5, a4]] + 
    CT[GReg[a2, a3, a4, a6, a7, a8], GReg[a1, a8]*GReg[a5, a4]] + 
    CT[GReg[a2, a3, a4, a6, a7, a8], GReg[a1, a2]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a4, a6, a7, a8], GReg[a1, a8]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a5, a6, a7, a8], GReg[a1, a2]*GReg[a4, a3]] + 
    CT[GReg[a2, a3, a5, a6, a7, a8], GReg[a1, a8]*GReg[a4, a3]] + 
    CT[GReg[a2, a3, a5, a6, a7, a8], GReg[a1, a2]*GReg[a4, a5]] - 
    CT[GReg[a2, a3, a5, a6, a7, a8], GReg[a1, a8]*GReg[a4, a5]] - 
    CT[GReg[a2, a4, a5, a6, a7, a8], GReg[a1, a2]*GReg[a3, a2]] + 
    CT[GReg[a2, a4, a5, a6, a7, a8], GReg[a1, a8]*GReg[a3, a2]] + 
    CT[GReg[a2, a4, a5, a6, a7, a8], GReg[a1, a2]*GReg[a3, a4]] - 
    CT[GReg[a2, a4, a5, a6, a7, a8], GReg[a1, a8]*GReg[a3, a4]] + 
    CT[GReg[a3, a4, a5, a6, a7, a8], GReg[a1, a3]*GReg[a2, a3]] - 
    CT[GReg[a3, a4, a5, a6, a7, a8], GReg[a1, a8]*GReg[a2, a3]] - 
    CT[GReg[a3, a4, a5, a6, a7, a8], GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a5, a6, a7, a8], GReg[a1, a2, a8]] + 
    CT[GReg[a1, a2, a3, a4, a5, a6, a8], GReg[a7, a6]] + 
    CT[GReg[a1, a2, a3, a4, a5, a7, a8], GReg[a6, a5]] - 
    CT[GReg[a1, a2, a3, a4, a5, a7, a8], GReg[a6, a7]] + 
    CT[GReg[a1, a2, a3, a4, a6, a7, a8], GReg[a5, a4]] - 
    CT[GReg[a1, a2, a3, a4, a6, a7, a8], GReg[a5, a6]] + 
    CT[GReg[a1, a2, a3, a5, a6, a7, a8], GReg[a4, a3]] - 
    CT[GReg[a1, a2, a3, a5, a6, a7, a8], GReg[a4, a5]] + 
    CT[GReg[a1, a2, a4, a5, a6, a7, a8], GReg[a3, a2]] - 
    CT[GReg[a1, a2, a4, a5, a6, a7, a8], GReg[a3, a4]] + 
    CT[GReg[a1, a3, a4, a5, a6, a7, a8], GReg[a2, a1]] - 
    CT[GReg[a1, a3, a4, a5, a6, a7, a8], GReg[a2, a3]] - 
    CT[GReg[a2, a3, a4, a5, a6, a7, a8], GReg[a1, a2]] + 
    CT[GReg[a2, a3, a4, a5, a6, a7, a8], GReg[a1, a8]] + 
    CT[GReg[a1, a2, a3, a4, a5, a6, a7, a8], 1]
 
DeltaG[a1_, a2_, a3_, a4_, a5_, a6_, a7_, a8_, a9_] := 
   CT[1, GReg[a1, a2, a3, a4, a5, a6, a7, a8, a9]] + 
    CT[GReg[a1, a9], GReg[a2, a3, a4, a5, a6, a7, a8, a1]] - 
    CT[GReg[a2, a9], GReg[a1, a2]*GReg[a3, a4, a5, a6, a7, a8, a2]] + 
    CT[GReg[a2, a9], GReg[a1, a9]*GReg[a3, a4, a5, a6, a7, a8, a2]] + 
    CT[GReg[a3, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a6, a7, a8, 
       a3]] - CT[GReg[a3, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a5, a6, a7, a8, a3]] - CT[GReg[a3, a9], 
     GReg[a1, a2, a3]*GReg[a4, a5, a6, a7, a8, a3]] + 
    CT[GReg[a3, a9], GReg[a1, a2, a9]*GReg[a4, a5, a6, a7, a8, a3]] - 
    CT[GReg[a4, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6, a7, a8, a4]] + CT[GReg[a4, a9], GReg[a1, a9]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a6, a7, a8, a4]] + CT[GReg[a4, a9], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a5, a6, a7, a8, a4]] - 
    CT[GReg[a4, a9], GReg[a3, a4]*GReg[a1, a2, a9]*GReg[a5, a6, a7, a8, 
       a4]] + CT[GReg[a4, a9], GReg[a1, a4]*GReg[a2, a3, a4]*
      GReg[a5, a6, a7, a8, a4]] - CT[GReg[a4, a9], 
     GReg[a1, a9]*GReg[a2, a3, a4]*GReg[a5, a6, a7, a8, a4]] - 
    CT[GReg[a4, a9], GReg[a1, a2, a3, a4]*GReg[a5, a6, a7, a8, a4]] + 
    CT[GReg[a4, a9], GReg[a1, a2, a3, a9]*GReg[a5, a6, a7, a8, a4]] + 
    CT[GReg[a5, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a5, a9], GReg[a1, a9]*GReg[a2, a5]*
      GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a5, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a1, a2, a5]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a5, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a1, a2, a9]*GReg[a6, a7, a8, a5]] - CT[GReg[a5, a9], 
     GReg[a1, a5]*GReg[a4, a5]*GReg[a2, a3, a5]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a5, a9], GReg[a1, a9]*GReg[a4, a5]*GReg[a2, a3, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a5, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a3, a4, a5]*GReg[a6, a7, a8, a5]] + CT[GReg[a5, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a4, a5]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a5, a9], GReg[a1, a2, a5]*GReg[a3, a4, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a5, a9], GReg[a1, a2, a9]*
      GReg[a3, a4, a5]*GReg[a6, a7, a8, a5]] + CT[GReg[a5, a9], 
     GReg[a4, a5]*GReg[a1, a2, a3, a5]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a5, a9], GReg[a4, a5]*GReg[a1, a2, a3, a9]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a5, a9], 
     GReg[a1, a5]*GReg[a2, a3, a4, a5]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a5, a9], GReg[a1, a9]*GReg[a2, a3, a4, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a5, a9], GReg[a6, a7, a8, a5]*
      GReg[a1, a2, a3, a4, a5]] + CT[GReg[a5, a9], GReg[a6, a7, a8, a5]*
      GReg[a1, a2, a3, a4, a9]] - CT[GReg[a6, a9], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a6, a9], GReg[a1, a9]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8, a6]] + CT[GReg[a6, a9], 
     GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a6, a9], GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a1, a2, a9]*GReg[a7, a8, a6]] + 
    CT[GReg[a6, a9], GReg[a1, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a2, a3, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a6, a9], GReg[a1, a9]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a2, a3, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a6, a9], GReg[a1, a6]*GReg[a2, a6]*GReg[a5, a6]*GReg[a3, a4, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a6, a9], GReg[a1, a9]*GReg[a2, a6]*
      GReg[a5, a6]*GReg[a3, a4, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a6, a9], GReg[a5, a6]*GReg[a1, a2, a6]*GReg[a3, a4, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a6, a9], GReg[a5, a6]*GReg[a1, a2, a9]*
      GReg[a3, a4, a6]*GReg[a7, a8, a6]] + CT[GReg[a6, a9], 
     GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a5, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a6, a9], GReg[a1, a9]*GReg[a2, a6]*
      GReg[a3, a6]*GReg[a4, a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a6, a9], GReg[a3, a6]*GReg[a1, a2, a6]*GReg[a4, a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a6, a9], GReg[a3, a6]*GReg[a1, a2, a9]*
      GReg[a4, a5, a6]*GReg[a7, a8, a6]] - CT[GReg[a6, a9], 
     GReg[a1, a6]*GReg[a2, a3, a6]*GReg[a4, a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a6, a9], GReg[a1, a9]*GReg[a2, a3, a6]*GReg[a4, a5, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a6, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8, a6]*GReg[a1, a2, a3, a6]] + CT[GReg[a6, a9], 
     GReg[a4, a5, a6]*GReg[a7, a8, a6]*GReg[a1, a2, a3, a6]] + 
    CT[GReg[a6, a9], GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8, a6]*
      GReg[a1, a2, a3, a9]] - CT[GReg[a6, a9], GReg[a4, a5, a6]*
      GReg[a7, a8, a6]*GReg[a1, a2, a3, a9]] - CT[GReg[a6, a9], 
     GReg[a1, a6]*GReg[a5, a6]*GReg[a7, a8, a6]*GReg[a2, a3, a4, a6]] + 
    CT[GReg[a6, a9], GReg[a1, a9]*GReg[a5, a6]*GReg[a7, a8, a6]*
      GReg[a2, a3, a4, a6]] - CT[GReg[a6, a9], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a7, a8, a6]*GReg[a3, a4, a5, a6]] + CT[GReg[a6, a9], 
     GReg[a1, a9]*GReg[a2, a6]*GReg[a7, a8, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a9], GReg[a1, a2, a6]*GReg[a7, a8, a6]*
      GReg[a3, a4, a5, a6]] - CT[GReg[a6, a9], GReg[a1, a2, a9]*
      GReg[a7, a8, a6]*GReg[a3, a4, a5, a6]] + CT[GReg[a6, a9], 
     GReg[a5, a6]*GReg[a7, a8, a6]*GReg[a1, a2, a3, a4, a6]] - 
    CT[GReg[a6, a9], GReg[a5, a6]*GReg[a7, a8, a6]*GReg[a1, a2, a3, a4, 
       a9]] + CT[GReg[a6, a9], GReg[a1, a6]*GReg[a7, a8, a6]*
      GReg[a2, a3, a4, a5, a6]] - CT[GReg[a6, a9], 
     GReg[a1, a9]*GReg[a7, a8, a6]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a9], GReg[a7, a8, a6]*GReg[a1, a2, a3, a4, a5, a6]] + 
    CT[GReg[a6, a9], GReg[a7, a8, a6]*GReg[a1, a2, a3, a4, a5, a9]] + 
    CT[GReg[a7, a9], GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a7, a9], GReg[a1, a9]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a7, a9], GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a1, a2, a7]] + CT[GReg[a7, a9], 
     GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a7, a9], GReg[a1, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a7]] + 
    CT[GReg[a7, a9], GReg[a1, a9]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a2, a3, a7]] - CT[GReg[a7, a9], 
     GReg[a1, a7]*GReg[a2, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a7]] + CT[GReg[a7, a9], GReg[a1, a9]*GReg[a2, a7]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a7]] + 
    CT[GReg[a7, a9], GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a7]*
      GReg[a3, a4, a7]] - CT[GReg[a7, a9], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a3, a4, a7]] - 
    CT[GReg[a7, a9], GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a4, a5, a7]] + CT[GReg[a7, a9], 
     GReg[a1, a9]*GReg[a2, a7]*GReg[a3, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a7]] + CT[GReg[a7, a9], GReg[a3, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a1, a2, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a7, a9], GReg[a3, a7]*GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a9]*
      GReg[a4, a5, a7]] + CT[GReg[a7, a9], GReg[a1, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a2, a3, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a7, a9], GReg[a1, a9]*GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a7, a9], GReg[a1, a7]*GReg[a2, a7]*
      GReg[a3, a7]*GReg[a4, a7]*GReg[a8, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a7, a9], GReg[a1, a9]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a8, a7]*GReg[a5, a6, a7]] + CT[GReg[a7, a9], 
     GReg[a3, a7]*GReg[a4, a7]*GReg[a8, a7]*GReg[a1, a2, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a7, a9], GReg[a3, a7]*GReg[a4, a7]*
      GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a5, a6, a7]] + 
    CT[GReg[a7, a9], GReg[a1, a7]*GReg[a4, a7]*GReg[a8, a7]*GReg[a2, a3, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a7, a9], GReg[a1, a9]*GReg[a4, a7]*
      GReg[a8, a7]*GReg[a2, a3, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a7, a9], GReg[a1, a7]*GReg[a2, a7]*GReg[a8, a7]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a7, a9], GReg[a1, a9]*GReg[a2, a7]*
      GReg[a8, a7]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a7, a9], GReg[a8, a7]*GReg[a1, a2, a7]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a7, a9], GReg[a8, a7]*GReg[a1, a2, a9]*
      GReg[a3, a4, a7]*GReg[a5, a6, a7]] + CT[GReg[a7, a9], 
     GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3, a7]] - CT[GReg[a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a7]*GReg[a1, a2, a3, a7]] - CT[GReg[a7, a9], 
     GReg[a4, a7]*GReg[a8, a7]*GReg[a5, a6, a7]*GReg[a1, a2, a3, a7]] - 
    CT[GReg[a7, a9], GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a7]*GReg[a1, a2, a3, a9]] + CT[GReg[a7, a9], 
     GReg[a4, a7]*GReg[a8, a7]*GReg[a5, a6, a7]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a7, a9], GReg[a1, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a4, a7]] - CT[GReg[a7, a9], GReg[a1, a9]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a4, a7]] - 
    CT[GReg[a7, a9], GReg[a1, a7]*GReg[a8, a7]*GReg[a5, a6, a7]*
      GReg[a2, a3, a4, a7]] + CT[GReg[a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a5, a6, a7]*GReg[a2, a3, a4, a7]] + CT[GReg[a7, a9], 
     GReg[a1, a7]*GReg[a2, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a5, a7]] - CT[GReg[a7, a9], GReg[a1, a9]*GReg[a2, a7]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a5, a7]] - 
    CT[GReg[a7, a9], GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a7]*
      GReg[a3, a4, a5, a7]] + CT[GReg[a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a9]*GReg[a3, a4, a5, a7]] + CT[GReg[a7, a9], 
     GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a7]*GReg[a8, a7]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a7, a9], GReg[a1, a9]*GReg[a2, a7]*
      GReg[a3, a7]*GReg[a8, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a7, a9], GReg[a3, a7]*GReg[a8, a7]*GReg[a1, a2, a7]*
      GReg[a4, a5, a6, a7]] + CT[GReg[a7, a9], GReg[a3, a7]*GReg[a8, a7]*
      GReg[a1, a2, a9]*GReg[a4, a5, a6, a7]] - CT[GReg[a7, a9], 
     GReg[a1, a7]*GReg[a8, a7]*GReg[a2, a3, a7]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a7, a9], GReg[a1, a9]*GReg[a8, a7]*GReg[a2, a3, a7]*
      GReg[a4, a5, a6, a7]] + CT[GReg[a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a7, a9], GReg[a8, a7]*GReg[a1, a2, a3, a9]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a7, a9], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a1, a2, a3, a4, a7]] + CT[GReg[a7, a9], 
     GReg[a8, a7]*GReg[a5, a6, a7]*GReg[a1, a2, a3, a4, a7]] + 
    CT[GReg[a7, a9], GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3, a4, a9]] - CT[GReg[a7, a9], 
     GReg[a8, a7]*GReg[a5, a6, a7]*GReg[a1, a2, a3, a4, a9]] - 
    CT[GReg[a7, a9], GReg[a1, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a4, a5, a7]] + CT[GReg[a7, a9], GReg[a1, a9]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a2, a3, a4, a5, a7]] - CT[GReg[a7, a9], 
     GReg[a1, a7]*GReg[a2, a7]*GReg[a8, a7]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a7, a9], GReg[a1, a9]*GReg[a2, a7]*GReg[a8, a7]*
      GReg[a3, a4, a5, a6, a7]] + CT[GReg[a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a7]*GReg[a3, a4, a5, a6, a7]] - 
    CT[GReg[a7, a9], GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a3, a4, a5, a6, 
       a7]] + CT[GReg[a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3, a4, a5, a7]] - CT[GReg[a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3, a4, a5, a9]] + 
    CT[GReg[a7, a9], GReg[a1, a7]*GReg[a8, a7]*GReg[a2, a3, a4, a5, a6, 
       a7]] - CT[GReg[a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a2, a3, a4, a5, a6, a7]] - CT[GReg[a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a3, a4, a5, a6, a7]] + 
    CT[GReg[a7, a9], GReg[a8, a7]*GReg[a1, a2, a3, a4, a5, a6, a9]] - 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a8]*
      GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a8]*
      GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a8, a9], GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a1, a2, a8]] - CT[GReg[a8, a9], 
     GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]] + CT[GReg[a8, a9], GReg[a1, a8]*GReg[a4, a8]*
      GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a2, a3, a8]] + CT[GReg[a8, a9], 
     GReg[a1, a8]*GReg[a2, a8]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a8]] - CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*
      GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a8]] - 
    CT[GReg[a8, a9], GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a8]*
      GReg[a3, a4, a8]] + CT[GReg[a8, a9], GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a3, a4, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a8]*GReg[a3, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a4, a5, a8]] - CT[GReg[a8, a9], 
     GReg[a1, a9]*GReg[a2, a8]*GReg[a3, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a4, a5, a8]] - CT[GReg[a8, a9], GReg[a3, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a1, a2, a8]*GReg[a4, a5, a8]] + 
    CT[GReg[a8, a9], GReg[a3, a8]*GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a9]*
      GReg[a4, a5, a8]] - CT[GReg[a8, a9], GReg[a1, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a2, a3, a8]*GReg[a4, a5, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a8]*
      GReg[a4, a5, a8]] + CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a8]*
      GReg[a3, a8]*GReg[a4, a8]*GReg[a7, a8]*GReg[a5, a6, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a8]*
      GReg[a7, a8]*GReg[a5, a6, a8]] - CT[GReg[a8, a9], 
     GReg[a3, a8]*GReg[a4, a8]*GReg[a7, a8]*GReg[a1, a2, a8]*
      GReg[a5, a6, a8]] + CT[GReg[a8, a9], GReg[a3, a8]*GReg[a4, a8]*
      GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a5, a6, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a4, a8]*GReg[a7, a8]*GReg[a2, a3, a8]*
      GReg[a5, a6, a8]] + CT[GReg[a8, a9], GReg[a1, a9]*GReg[a4, a8]*
      GReg[a7, a8]*GReg[a2, a3, a8]*GReg[a5, a6, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a8]*GReg[a7, a8]*GReg[a3, a4, a8]*
      GReg[a5, a6, a8]] + CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*
      GReg[a7, a8]*GReg[a3, a4, a8]*GReg[a5, a6, a8]] + 
    CT[GReg[a8, a9], GReg[a7, a8]*GReg[a1, a2, a8]*GReg[a3, a4, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a8, a9], GReg[a7, a8]*GReg[a1, a2, a9]*
      GReg[a3, a4, a8]*GReg[a5, a6, a8]] + CT[GReg[a8, a9], 
     GReg[a1, a8]*GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*
      GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a8, a9], GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*GReg[a1, a2, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a8, a9], GReg[a3, a8]*GReg[a4, a8]*
      GReg[a5, a8]*GReg[a1, a2, a9]*GReg[a6, a7, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a4, a8]*GReg[a5, a8]*GReg[a2, a3, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a8, a9], GReg[a1, a9]*GReg[a4, a8]*
      GReg[a5, a8]*GReg[a2, a3, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a8]*GReg[a5, a8]*GReg[a3, a4, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*
      GReg[a5, a8]*GReg[a3, a4, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a8, a9], GReg[a5, a8]*GReg[a1, a2, a8]*GReg[a3, a4, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a8, a9], GReg[a5, a8]*GReg[a1, a2, a9]*
      GReg[a3, a4, a8]*GReg[a6, a7, a8]] - CT[GReg[a8, a9], 
     GReg[a1, a8]*GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a5, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*
      GReg[a3, a8]*GReg[a4, a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a8, a9], GReg[a3, a8]*GReg[a1, a2, a8]*GReg[a4, a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a8, a9], GReg[a3, a8]*GReg[a1, a2, a9]*
      GReg[a4, a5, a8]*GReg[a6, a7, a8]] + CT[GReg[a8, a9], 
     GReg[a1, a8]*GReg[a2, a3, a8]*GReg[a4, a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a3, a8]*GReg[a4, a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a8, a9], GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3, a8]] + 
    CT[GReg[a8, a9], GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a8]*
      GReg[a1, a2, a3, a8]] + CT[GReg[a8, a9], GReg[a4, a8]*GReg[a7, a8]*
      GReg[a5, a6, a8]*GReg[a1, a2, a3, a8]] + CT[GReg[a8, a9], 
     GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a7, a8]*GReg[a1, a2, a3, a8]] - 
    CT[GReg[a8, a9], GReg[a4, a5, a8]*GReg[a6, a7, a8]*
      GReg[a1, a2, a3, a8]] + CT[GReg[a8, a9], GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a8, a9], GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a8]*
      GReg[a1, a2, a3, a9]] - CT[GReg[a8, a9], GReg[a4, a8]*GReg[a7, a8]*
      GReg[a5, a6, a8]*GReg[a1, a2, a3, a9]] - CT[GReg[a8, a9], 
     GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a7, a8]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a8, a9], GReg[a4, a5, a8]*GReg[a6, a7, a8]*
      GReg[a1, a2, a3, a9]] - CT[GReg[a8, a9], GReg[a1, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a4, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a4, a8]] + CT[GReg[a8, a9], GReg[a1, a8]*GReg[a7, a8]*
      GReg[a5, a6, a8]*GReg[a2, a3, a4, a8]] - CT[GReg[a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a5, a6, a8]*GReg[a2, a3, a4, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a5, a8]*GReg[a6, a7, a8]*
      GReg[a2, a3, a4, a8]] - CT[GReg[a8, a9], GReg[a1, a9]*GReg[a5, a8]*
      GReg[a6, a7, a8]*GReg[a2, a3, a4, a8]] - CT[GReg[a8, a9], 
     GReg[a1, a8]*GReg[a2, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a5, a8]] + CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a5, a8]] + 
    CT[GReg[a8, a9], GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a8]*
      GReg[a3, a4, a5, a8]] - CT[GReg[a8, a9], GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]*GReg[a3, a4, a5, a8]] + CT[GReg[a8, a9], 
     GReg[a1, a8]*GReg[a2, a8]*GReg[a6, a7, a8]*GReg[a3, a4, a5, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*GReg[a6, a7, a8]*
      GReg[a3, a4, a5, a8]] - CT[GReg[a8, a9], GReg[a1, a2, a8]*
      GReg[a6, a7, a8]*GReg[a3, a4, a5, a8]] + CT[GReg[a8, a9], 
     GReg[a1, a2, a9]*GReg[a6, a7, a8]*GReg[a3, a4, a5, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a8]*GReg[a3, a8]*GReg[a7, a8]*
      GReg[a4, a5, a6, a8]] + CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*
      GReg[a3, a8]*GReg[a7, a8]*GReg[a4, a5, a6, a8]] + 
    CT[GReg[a8, a9], GReg[a3, a8]*GReg[a7, a8]*GReg[a1, a2, a8]*
      GReg[a4, a5, a6, a8]] - CT[GReg[a8, a9], GReg[a3, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]*GReg[a4, a5, a6, a8]] + CT[GReg[a8, a9], 
     GReg[a1, a8]*GReg[a7, a8]*GReg[a2, a3, a8]*GReg[a4, a5, a6, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a7, a8]*GReg[a2, a3, a8]*
      GReg[a4, a5, a6, a8]] - CT[GReg[a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a3, a8]*GReg[a4, a5, a6, a8]] + 
    CT[GReg[a8, a9], GReg[a7, a8]*GReg[a1, a2, a3, a9]*
      GReg[a4, a5, a6, a8]] - CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a8]*
      GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a8]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a8, a9], GReg[a3, a8]*GReg[a4, a8]*
      GReg[a1, a2, a8]*GReg[a5, a6, a7, a8]] - CT[GReg[a8, a9], 
     GReg[a3, a8]*GReg[a4, a8]*GReg[a1, a2, a9]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a4, a8]*GReg[a2, a3, a8]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a8, a9], GReg[a1, a9]*GReg[a4, a8]*
      GReg[a2, a3, a8]*GReg[a5, a6, a7, a8]] + CT[GReg[a8, a9], 
     GReg[a1, a8]*GReg[a2, a8]*GReg[a3, a4, a8]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*GReg[a3, a4, a8]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a8, a9], GReg[a1, a2, a8]*
      GReg[a3, a4, a8]*GReg[a5, a6, a7, a8]] + CT[GReg[a8, a9], 
     GReg[a1, a2, a9]*GReg[a3, a4, a8]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a8, a9], GReg[a4, a8]*GReg[a1, a2, a3, a8]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a8, a9], 
     GReg[a4, a8]*GReg[a1, a2, a3, a9]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a3, a4, a8]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a8, a9], 
     GReg[a1, a9]*GReg[a2, a3, a4, a8]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a8, a9], GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a3, a4, a8]] - CT[GReg[a8, a9], 
     GReg[a7, a8]*GReg[a5, a6, a8]*GReg[a1, a2, a3, a4, a8]] - 
    CT[GReg[a8, a9], GReg[a5, a8]*GReg[a6, a7, a8]*GReg[a1, a2, a3, a4, 
       a8]] + CT[GReg[a8, a9], GReg[a5, a6, a7, a8]*GReg[a1, a2, a3, a4, 
       a8]] - CT[GReg[a8, a9], GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a3, a4, a9]] + CT[GReg[a8, a9], 
     GReg[a7, a8]*GReg[a5, a6, a8]*GReg[a1, a2, a3, a4, a9]] + 
    CT[GReg[a8, a9], GReg[a5, a8]*GReg[a6, a7, a8]*GReg[a1, a2, a3, a4, 
       a9]] - CT[GReg[a8, a9], GReg[a5, a6, a7, a8]*GReg[a1, a2, a3, a4, 
       a9]] + CT[GReg[a8, a9], GReg[a1, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a4, a5, a8]] - CT[GReg[a8, a9], GReg[a1, a9]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a2, a3, a4, a5, a8]] - CT[GReg[a8, a9], 
     GReg[a1, a8]*GReg[a6, a7, a8]*GReg[a2, a3, a4, a5, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a6, a7, a8]*GReg[a2, a3, a4, a5, 
       a8]] + CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a8]*GReg[a7, a8]*
      GReg[a3, a4, a5, a6, a8]] - CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*
      GReg[a7, a8]*GReg[a3, a4, a5, a6, a8]] - CT[GReg[a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a8]*GReg[a3, a4, a5, a6, a8]] + 
    CT[GReg[a8, a9], GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a3, a4, a5, a6, 
       a8]] + CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a8]*GReg[a3, a8]*
      GReg[a4, a5, a6, a7, a8]] - CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*
      GReg[a3, a8]*GReg[a4, a5, a6, a7, a8]] - CT[GReg[a8, a9], 
     GReg[a3, a8]*GReg[a1, a2, a8]*GReg[a4, a5, a6, a7, a8]] + 
    CT[GReg[a8, a9], GReg[a3, a8]*GReg[a1, a2, a9]*GReg[a4, a5, a6, a7, 
       a8]] - CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a3, a8]*
      GReg[a4, a5, a6, a7, a8]] + CT[GReg[a8, a9], 
     GReg[a1, a9]*GReg[a2, a3, a8]*GReg[a4, a5, a6, a7, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a2, a3, a8]*GReg[a4, a5, a6, a7, a8]] - 
    CT[GReg[a8, a9], GReg[a1, a2, a3, a9]*GReg[a4, a5, a6, a7, a8]] - 
    CT[GReg[a8, a9], GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3, a4, a5, 
       a8]] + CT[GReg[a8, a9], GReg[a6, a7, a8]*GReg[a1, a2, a3, a4, a5, 
       a8]] + CT[GReg[a8, a9], GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a3, a4, a5, a9]] - CT[GReg[a8, a9], 
     GReg[a6, a7, a8]*GReg[a1, a2, a3, a4, a5, a9]] - 
    CT[GReg[a8, a9], GReg[a1, a8]*GReg[a7, a8]*GReg[a2, a3, a4, a5, a6, 
       a8]] + CT[GReg[a8, a9], GReg[a1, a9]*GReg[a7, a8]*
      GReg[a2, a3, a4, a5, a6, a8]] - CT[GReg[a8, a9], 
     GReg[a1, a8]*GReg[a2, a8]*GReg[a3, a4, a5, a6, a7, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a8]*GReg[a3, a4, a5, a6, a7, 
       a8]] + CT[GReg[a8, a9], GReg[a1, a2, a8]*GReg[a3, a4, a5, a6, a7, 
       a8]] - CT[GReg[a8, a9], GReg[a1, a2, a9]*GReg[a3, a4, a5, a6, a7, 
       a8]] + CT[GReg[a8, a9], GReg[a7, a8]*GReg[a1, a2, a3, a4, a5, a6, 
       a8]] - CT[GReg[a8, a9], GReg[a7, a8]*GReg[a1, a2, a3, a4, a5, a6, 
       a9]] + CT[GReg[a8, a9], GReg[a1, a8]*GReg[a2, a3, a4, a5, a6, a7, 
       a8]] - CT[GReg[a8, a9], GReg[a1, a9]*GReg[a2, a3, a4, a5, a6, a7, 
       a8]] - CT[GReg[a8, a9], GReg[a1, a2, a3, a4, a5, a6, a7, a8]] + 
    CT[GReg[a8, a9], GReg[a1, a2, a3, a4, a5, a6, a7, a9]] + 
    CT[GReg[a1, a2, a9], GReg[a3, a4, a5, a6, a7, a8, a2]] + 
    CT[GReg[a1, a3, a9], GReg[a2, a1]*GReg[a4, a5, a6, a7, a8, a3]] - 
    CT[GReg[a1, a3, a9], GReg[a2, a3]*GReg[a4, a5, a6, a7, a8, a3]] - 
    CT[GReg[a1, a4, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6, a7, a8, 
       a4]] + CT[GReg[a1, a4, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6, a7, a8, a4]] + CT[GReg[a1, a4, a9], 
     GReg[a2, a3, a1]*GReg[a5, a6, a7, a8, a4]] - 
    CT[GReg[a1, a4, a9], GReg[a2, a3, a4]*GReg[a5, a6, a7, a8, a4]] + 
    CT[GReg[a1, a5, a9], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a1, a5, a9], GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a7, a8, a5]] - CT[GReg[a1, a5, a9], 
     GReg[a4, a5]*GReg[a2, a3, a1]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a1, a5, a9], GReg[a4, a5]*GReg[a2, a3, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a1, a5, a9], 
     GReg[a2, a1]*GReg[a3, a4, a5]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a1, a5, a9], GReg[a2, a5]*GReg[a3, a4, a5]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a1, a5, a9], GReg[a2, a3, a4, a1]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a1, a5, a9], GReg[a2, a3, a4, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a1, a6, a9], GReg[a2, a1]*GReg[a3, a6]*
      GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a6, a9], GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a6, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a2, a3, a1]*GReg[a7, a8, a6]] - CT[GReg[a1, a6, a9], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a2, a3, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a6, a9], GReg[a2, a1]*GReg[a5, a6]*GReg[a3, a4, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a6, a9], GReg[a2, a6]*GReg[a5, a6]*
      GReg[a3, a4, a6]*GReg[a7, a8, a6]] + CT[GReg[a1, a6, a9], 
     GReg[a2, a1]*GReg[a3, a6]*GReg[a4, a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a6, a9], GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a5, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a6, a9], GReg[a2, a3, a1]*
      GReg[a4, a5, a6]*GReg[a7, a8, a6]] + CT[GReg[a1, a6, a9], 
     GReg[a2, a3, a6]*GReg[a4, a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a6, a9], GReg[a5, a6]*GReg[a7, a8, a6]*
      GReg[a2, a3, a4, a1]] + CT[GReg[a1, a6, a9], 
     GReg[a5, a6]*GReg[a7, a8, a6]*GReg[a2, a3, a4, a6]] - 
    CT[GReg[a1, a6, a9], GReg[a2, a1]*GReg[a7, a8, a6]*
      GReg[a3, a4, a5, a6]] + CT[GReg[a1, a6, a9], 
     GReg[a2, a6]*GReg[a7, a8, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a6, a9], GReg[a7, a8, a6]*GReg[a2, a3, a4, a5, a1]] - 
    CT[GReg[a1, a6, a9], GReg[a7, a8, a6]*GReg[a2, a3, a4, a5, a6]] + 
    CT[GReg[a1, a7, a9], GReg[a2, a1]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a1, a7, a9], 
     GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]] - CT[GReg[a1, a7, a9], GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a7, a9], GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a7]] - CT[GReg[a1, a7, a9], GReg[a2, a1]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a7]] + 
    CT[GReg[a1, a7, a9], GReg[a2, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a7]] - CT[GReg[a1, a7, a9], GReg[a2, a1]*GReg[a3, a7]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a1, a7, a9], GReg[a2, a7]*GReg[a3, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a7]] + CT[GReg[a1, a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a1]*GReg[a4, a5, a7]] - CT[GReg[a1, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a7, a9], GReg[a2, a1]*GReg[a3, a7]*GReg[a4, a7]*GReg[a8, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a1, a7, a9], GReg[a2, a7]*GReg[a3, a7]*
      GReg[a4, a7]*GReg[a8, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a7, a9], GReg[a4, a7]*GReg[a8, a7]*GReg[a2, a3, a1]*
      GReg[a5, a6, a7]] - CT[GReg[a1, a7, a9], GReg[a4, a7]*GReg[a8, a7]*
      GReg[a2, a3, a7]*GReg[a5, a6, a7]] + CT[GReg[a1, a7, a9], 
     GReg[a2, a1]*GReg[a8, a7]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a7, a9], GReg[a2, a7]*GReg[a8, a7]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a1, a7, a9], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a2, a3, a4, a1]] - CT[GReg[a1, a7, a9], 
     GReg[a8, a7]*GReg[a5, a6, a7]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a7, a9], GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a4, a7]] + CT[GReg[a1, a7, a9], 
     GReg[a8, a7]*GReg[a5, a6, a7]*GReg[a2, a3, a4, a7]] + 
    CT[GReg[a1, a7, a9], GReg[a2, a1]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a5, a7]] - CT[GReg[a1, a7, a9], GReg[a2, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a3, a4, a5, a7]] + CT[GReg[a1, a7, a9], 
     GReg[a2, a1]*GReg[a3, a7]*GReg[a8, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a1, a7, a9], GReg[a2, a7]*GReg[a3, a7]*GReg[a8, a7]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a1, a7, a9], 
     GReg[a8, a7]*GReg[a2, a3, a1]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a1, a7, a9], GReg[a8, a7]*GReg[a2, a3, a7]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a1, a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a4, a5, a1]] + CT[GReg[a1, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a4, a5, a7]] - 
    CT[GReg[a1, a7, a9], GReg[a2, a1]*GReg[a8, a7]*GReg[a3, a4, a5, a6, 
       a7]] + CT[GReg[a1, a7, a9], GReg[a2, a7]*GReg[a8, a7]*
      GReg[a3, a4, a5, a6, a7]] + CT[GReg[a1, a7, a9], 
     GReg[a8, a7]*GReg[a2, a3, a4, a5, a6, a1]] - 
    CT[GReg[a1, a7, a9], GReg[a8, a7]*GReg[a2, a3, a4, a5, a6, a7]] - 
    CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a1, a8, a9], 
     GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a1, a8, a9], GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a8, a9], GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a8]] + CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a8]] + CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a3, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a3, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a4, a5, a8]] - CT[GReg[a1, a8, a9], GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a1]*GReg[a4, a5, a8]] + CT[GReg[a1, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a8]*GReg[a4, a5, a8]] + 
    CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a3, a8]*GReg[a4, a8]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a3, a8]*
      GReg[a4, a8]*GReg[a7, a8]*GReg[a5, a6, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a4, a8]*GReg[a7, a8]*GReg[a2, a3, a1]*
      GReg[a5, a6, a8]] + CT[GReg[a1, a8, a9], GReg[a4, a8]*GReg[a7, a8]*
      GReg[a2, a3, a8]*GReg[a5, a6, a8]] - CT[GReg[a1, a8, a9], 
     GReg[a2, a1]*GReg[a7, a8]*GReg[a3, a4, a8]*GReg[a5, a6, a8]] + 
    CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a7, a8]*GReg[a3, a4, a8]*
      GReg[a5, a6, a8]] + CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a3, a8]*
      GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a8, a9], GReg[a4, a8]*GReg[a5, a8]*
      GReg[a2, a3, a1]*GReg[a6, a7, a8]] + CT[GReg[a1, a8, a9], 
     GReg[a4, a8]*GReg[a5, a8]*GReg[a2, a3, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a5, a8]*GReg[a3, a4, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a5, a8]*
      GReg[a3, a4, a8]*GReg[a6, a7, a8]] - CT[GReg[a1, a8, a9], 
     GReg[a2, a1]*GReg[a3, a8]*GReg[a4, a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a5, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a8, a9], GReg[a2, a3, a1]*
      GReg[a4, a5, a8]*GReg[a6, a7, a8]] - CT[GReg[a1, a8, a9], 
     GReg[a2, a3, a8]*GReg[a4, a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a4, a1]] + CT[GReg[a1, a8, a9], 
     GReg[a7, a8]*GReg[a5, a6, a8]*GReg[a2, a3, a4, a1]] + 
    CT[GReg[a1, a8, a9], GReg[a5, a8]*GReg[a6, a7, a8]*
      GReg[a2, a3, a4, a1]] + CT[GReg[a1, a8, a9], GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a2, a3, a4, a8]] - CT[GReg[a1, a8, a9], 
     GReg[a7, a8]*GReg[a5, a6, a8]*GReg[a2, a3, a4, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a5, a8]*GReg[a6, a7, a8]*
      GReg[a2, a3, a4, a8]] - CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a3, a4, a5, a8]] + CT[GReg[a1, a8, a9], 
     GReg[a2, a8]*GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a5, a8]] + 
    CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a6, a7, a8]*
      GReg[a3, a4, a5, a8]] - CT[GReg[a1, a8, a9], 
     GReg[a2, a8]*GReg[a6, a7, a8]*GReg[a3, a4, a5, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a3, a8]*GReg[a7, a8]*
      GReg[a4, a5, a6, a8]] + CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a3, a8]*
      GReg[a7, a8]*GReg[a4, a5, a6, a8]] + CT[GReg[a1, a8, a9], 
     GReg[a7, a8]*GReg[a2, a3, a1]*GReg[a4, a5, a6, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a7, a8]*GReg[a2, a3, a8]*
      GReg[a4, a5, a6, a8]] - CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a3, a8]*
      GReg[a4, a8]*GReg[a5, a6, a7, a8]] + CT[GReg[a1, a8, a9], 
     GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a8, a9], GReg[a4, a8]*GReg[a2, a3, a1]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a1, a8, a9], 
     GReg[a4, a8]*GReg[a2, a3, a8]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a3, a4, a8]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a1, a8, a9], 
     GReg[a2, a8]*GReg[a3, a4, a8]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a2, a3, a4, a1]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a8, a9], GReg[a2, a3, a4, a8]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a8, a9], GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a4, a5, 
       a1]] - CT[GReg[a1, a8, a9], GReg[a6, a7, a8]*GReg[a2, a3, a4, a5, 
       a1]] - CT[GReg[a1, a8, a9], GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a4, a5, a8]] + CT[GReg[a1, a8, a9], 
     GReg[a6, a7, a8]*GReg[a2, a3, a4, a5, a8]] + 
    CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a7, a8]*GReg[a3, a4, a5, a6, 
       a8]] - CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a7, a8]*
      GReg[a3, a4, a5, a6, a8]] + CT[GReg[a1, a8, a9], 
     GReg[a2, a1]*GReg[a3, a8]*GReg[a4, a5, a6, a7, a8]] - 
    CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a3, a8]*GReg[a4, a5, a6, a7, 
       a8]] - CT[GReg[a1, a8, a9], GReg[a2, a3, a1]*GReg[a4, a5, a6, a7, 
       a8]] + CT[GReg[a1, a8, a9], GReg[a2, a3, a8]*GReg[a4, a5, a6, a7, 
       a8]] - CT[GReg[a1, a8, a9], GReg[a7, a8]*GReg[a2, a3, a4, a5, a6, 
       a1]] + CT[GReg[a1, a8, a9], GReg[a7, a8]*GReg[a2, a3, a4, a5, a6, 
       a8]] - CT[GReg[a1, a8, a9], GReg[a2, a1]*GReg[a3, a4, a5, a6, a7, 
       a8]] + CT[GReg[a1, a8, a9], GReg[a2, a8]*GReg[a3, a4, a5, a6, a7, 
       a8]] + CT[GReg[a1, a8, a9], GReg[a2, a3, a4, a5, a6, a7, a1]] - 
    CT[GReg[a1, a8, a9], GReg[a2, a3, a4, a5, a6, a7, a8]] - 
    CT[GReg[a2, a3, a9], GReg[a1, a2]*GReg[a4, a5, a6, a7, a8, a3]] + 
    CT[GReg[a2, a3, a9], GReg[a1, a9]*GReg[a4, a5, a6, a7, a8, a3]] - 
    CT[GReg[a2, a4, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a6, a7, a8, 
       a4]] + CT[GReg[a2, a4, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a5, a6, a7, a8, a4]] + CT[GReg[a2, a4, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6, a7, a8, a4]] - 
    CT[GReg[a2, a4, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a6, a7, a8, 
       a4]] + CT[GReg[a2, a5, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a2, a5, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a6, a7, a8, a5]] - CT[GReg[a2, a5, a9], 
     GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a2, a5, a9], GReg[a1, a9]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a2, a5, a9], 
     GReg[a1, a2]*GReg[a3, a4, a2]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a2, a5, a9], GReg[a1, a9]*GReg[a3, a4, a2]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a2, a5, a9], 
     GReg[a1, a2]*GReg[a3, a4, a5]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a2, a5, a9], GReg[a1, a9]*GReg[a3, a4, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a2, a6, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a2, a6, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a6, a9], GReg[a1, a2]*GReg[a3, a6]*
      GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a6, a9], GReg[a1, a9]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a6, a9], GReg[a1, a2]*GReg[a5, a6]*
      GReg[a3, a4, a2]*GReg[a7, a8, a6]] - CT[GReg[a2, a6, a9], 
     GReg[a1, a9]*GReg[a5, a6]*GReg[a3, a4, a2]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a6, a9], GReg[a1, a2]*GReg[a5, a6]*GReg[a3, a4, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a6, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a3, a4, a6]*GReg[a7, a8, a6]] + CT[GReg[a2, a6, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a6, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a2, a6, a9], GReg[a1, a2]*GReg[a3, a6]*
      GReg[a4, a5, a6]*GReg[a7, a8, a6]] + CT[GReg[a2, a6, a9], 
     GReg[a1, a9]*GReg[a3, a6]*GReg[a4, a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a6, a9], GReg[a1, a2]*GReg[a7, a8, a6]*
      GReg[a3, a4, a5, a2]] + CT[GReg[a2, a6, a9], 
     GReg[a1, a9]*GReg[a7, a8, a6]*GReg[a3, a4, a5, a2]] + 
    CT[GReg[a2, a6, a9], GReg[a1, a2]*GReg[a7, a8, a6]*
      GReg[a3, a4, a5, a6]] - CT[GReg[a2, a6, a9], 
     GReg[a1, a9]*GReg[a7, a8, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a2, a7, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]] - CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a3, a7]*
      GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a2, a7, a9], 
     GReg[a1, a2]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a7]] - 
    CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a7]] - CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a7]] + CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a3, a7]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a3, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a7]*GReg[a8, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a7]*GReg[a8, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a3, a7]*
      GReg[a4, a7]*GReg[a8, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a3, a7]*GReg[a4, a7]*GReg[a8, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a8, a7]*
      GReg[a3, a4, a2]*GReg[a5, a6, a7]] - CT[GReg[a2, a7, a9], 
     GReg[a1, a9]*GReg[a8, a7]*GReg[a3, a4, a2]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a8, a7]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a3, a4, a7]*GReg[a5, a6, a7]] + CT[GReg[a2, a7, a9], 
     GReg[a1, a2]*GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a5, a2]] - 
    CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a5, a2]] - CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a3, a4, a5, a7]] + CT[GReg[a2, a7, a9], 
     GReg[a1, a9]*GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a5, a7]] + 
    CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a8, a7]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a8, a7]*GReg[a4, a5, a6, a7]] - CT[GReg[a2, a7, a9], 
     GReg[a1, a2]*GReg[a3, a7]*GReg[a8, a7]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a3, a7]*GReg[a8, a7]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a8, a7]*
      GReg[a3, a4, a5, a6, a2]] + CT[GReg[a2, a7, a9], 
     GReg[a1, a9]*GReg[a8, a7]*GReg[a3, a4, a5, a6, a2]] + 
    CT[GReg[a2, a7, a9], GReg[a1, a2]*GReg[a8, a7]*GReg[a3, a4, a5, a6, 
       a7]] - CT[GReg[a2, a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a3, a4, a5, a6, a7]] - CT[GReg[a2, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a2, a8, a9], 
     GReg[a1, a9]*GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a2]] - CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a8]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a8]] + CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a4, a5, a8]] - CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a8]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a4, a5, a8]] + CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a8]*GReg[a7, a8]*GReg[a5, a6, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a8]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a8]*
      GReg[a4, a8]*GReg[a7, a8]*GReg[a5, a6, a8]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a8]*GReg[a4, a8]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a7, a8]*
      GReg[a3, a4, a2]*GReg[a5, a6, a8]] + CT[GReg[a2, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a3, a4, a2]*GReg[a5, a6, a8]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a7, a8]*GReg[a3, a4, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a7, a8]*
      GReg[a3, a4, a8]*GReg[a5, a6, a8]] + CT[GReg[a2, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a8]*
      GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a5, a8]*
      GReg[a3, a4, a2]*GReg[a6, a7, a8]] + CT[GReg[a2, a8, a9], 
     GReg[a1, a9]*GReg[a5, a8]*GReg[a3, a4, a2]*GReg[a6, a7, a8]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a5, a8]*GReg[a3, a4, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a5, a8]*
      GReg[a3, a4, a8]*GReg[a6, a7, a8]] - CT[GReg[a2, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a8]*
      GReg[a4, a5, a8]*GReg[a6, a7, a8]] - CT[GReg[a2, a8, a9], 
     GReg[a1, a9]*GReg[a3, a8]*GReg[a4, a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a5, a2]] + CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a3, a4, a5, a2]] + CT[GReg[a2, a8, a9], 
     GReg[a1, a2]*GReg[a6, a7, a8]*GReg[a3, a4, a5, a2]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a6, a7, a8]*
      GReg[a3, a4, a5, a2]] + CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a3, a4, a5, a8]] - CT[GReg[a2, a8, a9], 
     GReg[a1, a9]*GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a5, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a6, a7, a8]*
      GReg[a3, a4, a5, a8]] + CT[GReg[a2, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7, a8]*GReg[a3, a4, a5, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a7, a8]*
      GReg[a4, a5, a6, a8]] + CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a7, a8]*GReg[a4, a5, a6, a8]] + CT[GReg[a2, a8, a9], 
     GReg[a1, a2]*GReg[a3, a8]*GReg[a7, a8]*GReg[a4, a5, a6, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a8]*GReg[a7, a8]*
      GReg[a4, a5, a6, a8]] - CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a8]*GReg[a5, a6, a7, a8]] + CT[GReg[a2, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a8]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a8]*GReg[a4, a8]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a8]*
      GReg[a4, a8]*GReg[a5, a6, a7, a8]] + CT[GReg[a2, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4, a2]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a4, a2]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a2, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4, a8]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a4, a8]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a7, a8]*
      GReg[a3, a4, a5, a6, a2]] - CT[GReg[a2, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a3, a4, a5, a6, a2]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a7, a8]*GReg[a3, a4, a5, a6, 
       a8]] + CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a7, a8]*
      GReg[a3, a4, a5, a6, a8]] + CT[GReg[a2, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5, a6, a7, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5, a6, a7, 
       a8]] - CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a8]*
      GReg[a4, a5, a6, a7, a8]] + CT[GReg[a2, a8, a9], 
     GReg[a1, a9]*GReg[a3, a8]*GReg[a4, a5, a6, a7, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a4, a5, a6, a7, a2]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a4, a5, a6, a7, a2]] + 
    CT[GReg[a2, a8, a9], GReg[a1, a2]*GReg[a3, a4, a5, a6, a7, a8]] - 
    CT[GReg[a2, a8, a9], GReg[a1, a9]*GReg[a3, a4, a5, a6, a7, a8]] + 
    CT[GReg[a3, a4, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6, a7, a8, 
       a4]] - CT[GReg[a3, a4, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a5, a6, a7, a8, a4]] - CT[GReg[a3, a4, a9], 
     GReg[a1, a2, a3]*GReg[a5, a6, a7, a8, a4]] + 
    CT[GReg[a3, a4, a9], GReg[a1, a2, a9]*GReg[a5, a6, a7, a8, a4]] + 
    CT[GReg[a3, a5, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a3, a5, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a6, a7, a8, a5]] - CT[GReg[a3, a5, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a3, a5, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a3, a5, a9], 
     GReg[a4, a3]*GReg[a1, a2, a3]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a3, a5, a9], GReg[a4, a5]*GReg[a1, a2, a3]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a3, a5, a9], 
     GReg[a4, a3]*GReg[a1, a2, a9]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a3, a5, a9], GReg[a4, a5]*GReg[a1, a2, a9]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a3, a6, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a3, a6, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a3, a6, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a3, a6, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a3, a6, a9], GReg[a4, a3]*GReg[a5, a6]*
      GReg[a1, a2, a3]*GReg[a7, a8, a6]] - CT[GReg[a3, a6, a9], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a3]*GReg[a7, a8, a6]] - 
    CT[GReg[a3, a6, a9], GReg[a4, a3]*GReg[a5, a6]*GReg[a1, a2, a9]*
      GReg[a7, a8, a6]] + CT[GReg[a3, a6, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a1, a2, a9]*GReg[a7, a8, a6]] + CT[GReg[a3, a6, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a3]*GReg[a7, a8, a6]] - 
    CT[GReg[a3, a6, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5, a3]*
      GReg[a7, a8, a6]] - CT[GReg[a3, a6, a9], GReg[a1, a2, a3]*
      GReg[a4, a5, a3]*GReg[a7, a8, a6]] + CT[GReg[a3, a6, a9], 
     GReg[a1, a2, a9]*GReg[a4, a5, a3]*GReg[a7, a8, a6]] - 
    CT[GReg[a3, a6, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a3, a6, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a5, a6]*GReg[a7, a8, a6]] + CT[GReg[a3, a6, a9], 
     GReg[a1, a2, a3]*GReg[a4, a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a3, a6, a9], GReg[a1, a2, a9]*GReg[a4, a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a3, a7, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a3, a7, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a3, a7, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]] + CT[GReg[a3, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a3, a7, a9], GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a7, a9], GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a7, a9], GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a7, a9], GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a9]] - 
    CT[GReg[a3, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a3]] + CT[GReg[a3, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a4, a5, a3]] + 
    CT[GReg[a3, a7, a9], GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3]*
      GReg[a4, a5, a3]] - CT[GReg[a3, a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a9]*GReg[a4, a5, a3]] + CT[GReg[a3, a7, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a7]*GReg[a8, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a3, a7, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a3, a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3]*GReg[a4, a5, a7]] + CT[GReg[a3, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a4, a5, a7]] - 
    CT[GReg[a3, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*GReg[a8, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a3, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a8, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a3, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a7]*GReg[a8, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a3, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a7]*GReg[a8, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a3, a7, a9], GReg[a4, a3]*GReg[a8, a7]*GReg[a1, a2, a3]*
      GReg[a5, a6, a7]] - CT[GReg[a3, a7, a9], GReg[a4, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3]*GReg[a5, a6, a7]] - CT[GReg[a3, a7, a9], 
     GReg[a4, a3]*GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a5, a6, a7]] + 
    CT[GReg[a3, a7, a9], GReg[a4, a7]*GReg[a8, a7]*GReg[a1, a2, a9]*
      GReg[a5, a6, a7]] + CT[GReg[a3, a7, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a8, a7]*GReg[a4, a5, a6, a3]] - CT[GReg[a3, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a8, a7]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a3, a7, a9], GReg[a8, a7]*GReg[a1, a2, a3]*
      GReg[a4, a5, a6, a3]] + CT[GReg[a3, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a3, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a8, a7]*
      GReg[a4, a5, a6, a7]] + CT[GReg[a3, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a8, a7]*GReg[a4, a5, a6, a7]] + CT[GReg[a3, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a3]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a3, a7, a9], GReg[a8, a7]*GReg[a1, a2, a9]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a3, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a4, a3]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a8, a9], GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a8, a9], GReg[a4, a3]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a8, a9], GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a4, a5, a3]] - CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a8, a9], GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3]*
      GReg[a4, a5, a3]] + CT[GReg[a3, a8, a9], GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]*GReg[a4, a5, a3]] - CT[GReg[a3, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a4, a5, a8]] + CT[GReg[a3, a8, a9], GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a3]*GReg[a4, a5, a8]] - CT[GReg[a3, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a4, a5, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a7, a8]*GReg[a5, a6, a8]] - 
    CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a8]*GReg[a7, a8]*
      GReg[a5, a6, a8]] + CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a8]*GReg[a7, a8]*GReg[a5, a6, a8]] - 
    CT[GReg[a3, a8, a9], GReg[a4, a3]*GReg[a7, a8]*GReg[a1, a2, a3]*
      GReg[a5, a6, a8]] + CT[GReg[a3, a8, a9], GReg[a4, a8]*GReg[a7, a8]*
      GReg[a1, a2, a3]*GReg[a5, a6, a8]] + CT[GReg[a3, a8, a9], 
     GReg[a4, a3]*GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a5, a6, a8]] - 
    CT[GReg[a3, a8, a9], GReg[a4, a8]*GReg[a7, a8]*GReg[a1, a2, a9]*
      GReg[a5, a6, a8]] + CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a3, a8, a9], GReg[a4, a3]*GReg[a5, a8]*
      GReg[a1, a2, a3]*GReg[a6, a7, a8]] + CT[GReg[a3, a8, a9], 
     GReg[a4, a8]*GReg[a5, a8]*GReg[a1, a2, a3]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a4, a3]*GReg[a5, a8]*GReg[a1, a2, a9]*
      GReg[a6, a7, a8]] - CT[GReg[a3, a8, a9], GReg[a4, a8]*GReg[a5, a8]*
      GReg[a1, a2, a9]*GReg[a6, a7, a8]] - CT[GReg[a3, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a3]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5, a3]*
      GReg[a6, a7, a8]] + CT[GReg[a3, a8, a9], GReg[a1, a2, a3]*
      GReg[a4, a5, a3]*GReg[a6, a7, a8]] - CT[GReg[a3, a8, a9], 
     GReg[a1, a2, a9]*GReg[a4, a5, a3]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a5, a8]*GReg[a6, a7, a8]] - CT[GReg[a3, a8, a9], 
     GReg[a1, a2, a3]*GReg[a4, a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a2, a9]*GReg[a4, a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a7, a8]*GReg[a4, a5, a6, a3]] + CT[GReg[a3, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a7, a8]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a3, a8, a9], GReg[a7, a8]*GReg[a1, a2, a3]*
      GReg[a4, a5, a6, a3]] - CT[GReg[a3, a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a7, a8]*
      GReg[a4, a5, a6, a8]] - CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a7, a8]*GReg[a4, a5, a6, a8]] - CT[GReg[a3, a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a3]*GReg[a4, a5, a6, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a7, a8]*GReg[a1, a2, a9]*
      GReg[a4, a5, a6, a8]] - CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a6, a7, a8]] + CT[GReg[a3, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a8]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a8]*GReg[a5, a6, a7, a8]] + CT[GReg[a3, a8, a9], 
     GReg[a4, a3]*GReg[a1, a2, a3]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a3, a8, a9], GReg[a4, a8]*GReg[a1, a2, a3]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a3, a8, a9], 
     GReg[a4, a3]*GReg[a1, a2, a9]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a3, a8, a9], GReg[a4, a8]*GReg[a1, a2, a9]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a5, a6, a7, a3]] - CT[GReg[a3, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a3, a8, a9], GReg[a1, a2, a3]*GReg[a4, a5, a6, a7, a3]] + 
    CT[GReg[a3, a8, a9], GReg[a1, a2, a9]*GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a3, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5, a6, a7, 
       a8]] + CT[GReg[a3, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a5, a6, a7, a8]] + CT[GReg[a3, a8, a9], 
     GReg[a1, a2, a3]*GReg[a4, a5, a6, a7, a8]] - 
    CT[GReg[a3, a8, a9], GReg[a1, a2, a9]*GReg[a4, a5, a6, a7, a8]] - 
    CT[GReg[a4, a5, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a4, a5, a9], GReg[a1, a9]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a6, a7, a8, a5]] + CT[GReg[a4, a5, a9], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a4, a5, a9], GReg[a3, a4]*GReg[a1, a2, a9]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a4, a5, a9], 
     GReg[a1, a4]*GReg[a2, a3, a4]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a4, a5, a9], GReg[a1, a9]*GReg[a2, a3, a4]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a4, a5, a9], GReg[a1, a2, a3, a4]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a4, a5, a9], GReg[a1, a2, a3, a9]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a4, a6, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a8, a6]] + 
    CT[GReg[a4, a6, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a8, a6]] + CT[GReg[a4, a6, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a4, a6, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a4, a6, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a1, a2, a4]*GReg[a7, a8, a6]] - CT[GReg[a4, a6, a9], 
     GReg[a3, a4]*GReg[a5, a6]*GReg[a1, a2, a4]*GReg[a7, a8, a6]] - 
    CT[GReg[a4, a6, a9], GReg[a3, a4]*GReg[a5, a4]*GReg[a1, a2, a9]*
      GReg[a7, a8, a6]] + CT[GReg[a4, a6, a9], GReg[a3, a4]*GReg[a5, a6]*
      GReg[a1, a2, a9]*GReg[a7, a8, a6]] + CT[GReg[a4, a6, a9], 
     GReg[a1, a4]*GReg[a5, a4]*GReg[a2, a3, a4]*GReg[a7, a8, a6]] - 
    CT[GReg[a4, a6, a9], GReg[a1, a9]*GReg[a5, a4]*GReg[a2, a3, a4]*
      GReg[a7, a8, a6]] - CT[GReg[a4, a6, a9], GReg[a1, a4]*GReg[a5, a6]*
      GReg[a2, a3, a4]*GReg[a7, a8, a6]] + CT[GReg[a4, a6, a9], 
     GReg[a1, a9]*GReg[a5, a6]*GReg[a2, a3, a4]*GReg[a7, a8, a6]] - 
    CT[GReg[a4, a6, a9], GReg[a5, a4]*GReg[a7, a8, a6]*
      GReg[a1, a2, a3, a4]] + CT[GReg[a4, a6, a9], 
     GReg[a5, a6]*GReg[a7, a8, a6]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6, a9], GReg[a5, a4]*GReg[a7, a8, a6]*
      GReg[a1, a2, a3, a9]] - CT[GReg[a4, a6, a9], 
     GReg[a5, a6]*GReg[a7, a8, a6]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a4, a7, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a4, a7, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]*
      GReg[a8, a7]] - CT[GReg[a4, a7, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a4, a7, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a4, a7, a9], 
     GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a4]] + 
    CT[GReg[a4, a7, a9], GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a4]] + CT[GReg[a4, a7, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a9]] - 
    CT[GReg[a4, a7, a9], GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a4, a7, a9], GReg[a1, a4]*GReg[a5, a4]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a4]] + 
    CT[GReg[a4, a7, a9], GReg[a1, a9]*GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a7, a9], GReg[a1, a4]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a7, a9], GReg[a1, a9]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a7, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a8, a7]*GReg[a5, a6, a4]] + 
    CT[GReg[a4, a7, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a8, a7]*
      GReg[a5, a6, a4]] + CT[GReg[a4, a7, a9], GReg[a3, a4]*GReg[a8, a7]*
      GReg[a1, a2, a4]*GReg[a5, a6, a4]] - CT[GReg[a4, a7, a9], 
     GReg[a3, a4]*GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a5, a6, a4]] + 
    CT[GReg[a4, a7, a9], GReg[a1, a4]*GReg[a8, a7]*GReg[a2, a3, a4]*
      GReg[a5, a6, a4]] - CT[GReg[a4, a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a2, a3, a4]*GReg[a5, a6, a4]] + CT[GReg[a4, a7, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a8, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a4, a7, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a8, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a4, a7, a9], GReg[a3, a4]*GReg[a8, a7]*
      GReg[a1, a2, a4]*GReg[a5, a6, a7]] + CT[GReg[a4, a7, a9], 
     GReg[a3, a4]*GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a5, a6, a7]] - 
    CT[GReg[a4, a7, a9], GReg[a1, a4]*GReg[a8, a7]*GReg[a2, a3, a4]*
      GReg[a5, a6, a7]] + CT[GReg[a4, a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a2, a3, a4]*GReg[a5, a6, a7]] + CT[GReg[a4, a7, a9], 
     GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3, a4]] - 
    CT[GReg[a4, a7, a9], GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3, a4]] - CT[GReg[a4, a7, a9], 
     GReg[a8, a7]*GReg[a5, a6, a4]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a7, a9], GReg[a8, a7]*GReg[a5, a6, a7]*
      GReg[a1, a2, a3, a4]] - CT[GReg[a4, a7, a9], GReg[a5, a4]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a1, a2, a3, a9]] + CT[GReg[a4, a7, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a4, a7, a9], GReg[a8, a7]*GReg[a5, a6, a4]*
      GReg[a1, a2, a3, a9]] - CT[GReg[a4, a7, a9], 
     GReg[a8, a7]*GReg[a5, a6, a7]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a4, a8, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a4, a8, a9], 
     GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a8, a9], GReg[a3, a4]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a8, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a9]] + 
    CT[GReg[a4, a8, a9], GReg[a3, a4]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]] + CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a5, a4]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a4]] + 
    CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a7, a8]*GReg[a5, a6, a4]] - 
    CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a7, a8]*
      GReg[a5, a6, a4]] - CT[GReg[a4, a8, a9], GReg[a3, a4]*GReg[a7, a8]*
      GReg[a1, a2, a4]*GReg[a5, a6, a4]] + CT[GReg[a4, a8, a9], 
     GReg[a3, a4]*GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a5, a6, a4]] - 
    CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a7, a8]*GReg[a2, a3, a4]*
      GReg[a5, a6, a4]] + CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a7, a8]*
      GReg[a2, a3, a4]*GReg[a5, a6, a4]] - CT[GReg[a4, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a7, a8]*GReg[a5, a6, a8]] + 
    CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a7, a8]*
      GReg[a5, a6, a8]] + CT[GReg[a4, a8, a9], GReg[a3, a4]*GReg[a7, a8]*
      GReg[a1, a2, a4]*GReg[a5, a6, a8]] - CT[GReg[a4, a8, a9], 
     GReg[a3, a4]*GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a5, a6, a8]] + 
    CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a7, a8]*GReg[a2, a3, a4]*
      GReg[a5, a6, a8]] - CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a7, a8]*
      GReg[a2, a3, a4]*GReg[a5, a6, a8]] + CT[GReg[a4, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a7, a8]] - CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a4, a8, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a1, a2, a4]*GReg[a6, a7, a8]] + CT[GReg[a4, a8, a9], 
     GReg[a3, a4]*GReg[a5, a8]*GReg[a1, a2, a4]*GReg[a6, a7, a8]] + 
    CT[GReg[a4, a8, a9], GReg[a3, a4]*GReg[a5, a4]*GReg[a1, a2, a9]*
      GReg[a6, a7, a8]] - CT[GReg[a4, a8, a9], GReg[a3, a4]*GReg[a5, a8]*
      GReg[a1, a2, a9]*GReg[a6, a7, a8]] - CT[GReg[a4, a8, a9], 
     GReg[a1, a4]*GReg[a5, a4]*GReg[a2, a3, a4]*GReg[a6, a7, a8]] + 
    CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a5, a4]*GReg[a2, a3, a4]*
      GReg[a6, a7, a8]] + CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a5, a8]*
      GReg[a2, a3, a4]*GReg[a6, a7, a8]] - CT[GReg[a4, a8, a9], 
     GReg[a1, a9]*GReg[a5, a8]*GReg[a2, a3, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a4, a8, a9], GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a3, a4]] + CT[GReg[a4, a8, a9], GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a1, a2, a3, a4]] + CT[GReg[a4, a8, a9], 
     GReg[a7, a8]*GReg[a5, a6, a4]*GReg[a1, a2, a3, a4]] - 
    CT[GReg[a4, a8, a9], GReg[a7, a8]*GReg[a5, a6, a8]*
      GReg[a1, a2, a3, a4]] + CT[GReg[a4, a8, a9], 
     GReg[a5, a4]*GReg[a6, a7, a8]*GReg[a1, a2, a3, a4]] - 
    CT[GReg[a4, a8, a9], GReg[a5, a8]*GReg[a6, a7, a8]*
      GReg[a1, a2, a3, a4]] + CT[GReg[a4, a8, a9], GReg[a5, a4]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a1, a2, a3, a9]] - CT[GReg[a4, a8, a9], 
     GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a8, a9], GReg[a7, a8]*GReg[a5, a6, a4]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a4, a8, a9], 
     GReg[a7, a8]*GReg[a5, a6, a8]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a8, a9], GReg[a5, a4]*GReg[a6, a7, a8]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a4, a8, a9], 
     GReg[a5, a8]*GReg[a6, a7, a8]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6, a7, a4]] + CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a6, a7, a4]] + CT[GReg[a4, a8, a9], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a4, a8, a9], GReg[a3, a4]*GReg[a1, a2, a9]*
      GReg[a5, a6, a7, a4]] + CT[GReg[a4, a8, a9], 
     GReg[a1, a4]*GReg[a2, a3, a4]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a4, a8, a9], GReg[a1, a9]*GReg[a2, a3, a4]*
      GReg[a5, a6, a7, a4]] - CT[GReg[a4, a8, a9], GReg[a1, a2, a3, a4]*
      GReg[a5, a6, a7, a4]] + CT[GReg[a4, a8, a9], GReg[a1, a2, a3, a9]*
      GReg[a5, a6, a7, a4]] + CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a6, a7, a8]] - CT[GReg[a4, a8, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a4, a8, a9], GReg[a3, a4]*GReg[a1, a2, a4]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a4, a8, a9], 
     GReg[a3, a4]*GReg[a1, a2, a9]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a4, a8, a9], GReg[a1, a4]*GReg[a2, a3, a4]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a4, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3, a4]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a4, a8, a9], GReg[a1, a2, a3, a4]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a4, a8, a9], GReg[a1, a2, a3, a9]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a5, a6, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a8, a6]] - CT[GReg[a5, a6, a9], GReg[a1, a9]*GReg[a2, a5]*
      GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a8, a6]] - 
    CT[GReg[a5, a6, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a1, a2, a5]*
      GReg[a7, a8, a6]] + CT[GReg[a5, a6, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a1, a2, a9]*GReg[a7, a8, a6]] - CT[GReg[a5, a6, a9], 
     GReg[a1, a5]*GReg[a4, a5]*GReg[a2, a3, a5]*GReg[a7, a8, a6]] + 
    CT[GReg[a5, a6, a9], GReg[a1, a9]*GReg[a4, a5]*GReg[a2, a3, a5]*
      GReg[a7, a8, a6]] - CT[GReg[a5, a6, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a3, a4, a5]*GReg[a7, a8, a6]] + CT[GReg[a5, a6, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a4, a5]*GReg[a7, a8, a6]] + 
    CT[GReg[a5, a6, a9], GReg[a1, a2, a5]*GReg[a3, a4, a5]*
      GReg[a7, a8, a6]] - CT[GReg[a5, a6, a9], GReg[a1, a2, a9]*
      GReg[a3, a4, a5]*GReg[a7, a8, a6]] + CT[GReg[a5, a6, a9], 
     GReg[a4, a5]*GReg[a7, a8, a6]*GReg[a1, a2, a3, a5]] - 
    CT[GReg[a5, a6, a9], GReg[a4, a5]*GReg[a7, a8, a6]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a5, a6, a9], 
     GReg[a1, a5]*GReg[a7, a8, a6]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a6, a9], GReg[a1, a9]*GReg[a7, a8, a6]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a5, a6, a9], 
     GReg[a7, a8, a6]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a6, a9], GReg[a7, a8, a6]*GReg[a1, a2, a3, a4, a9]] + 
    CT[GReg[a5, a7, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a8, a7]] - CT[GReg[a5, a7, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*
      GReg[a8, a7]] - CT[GReg[a5, a7, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a5, a7, a9], GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a5, a7, a9], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]*GReg[a1, a2, a5]] + 
    CT[GReg[a5, a7, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a5]] + CT[GReg[a5, a7, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a8, a7]*GReg[a1, a2, a9]] - 
    CT[GReg[a5, a7, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a5, a7, a9], GReg[a1, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a8, a7]*GReg[a2, a3, a5]] + 
    CT[GReg[a5, a7, a9], GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]*
      GReg[a2, a3, a5]] + CT[GReg[a5, a7, a9], GReg[a1, a5]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a5]] - 
    CT[GReg[a5, a7, a9], GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a5]] - CT[GReg[a5, a7, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a6, a5]*GReg[a8, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a7, a9], GReg[a1, a9]*GReg[a2, a5]*GReg[a6, a5]*GReg[a8, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a7, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a5]] - 
    CT[GReg[a5, a7, a9], GReg[a1, a9]*GReg[a2, a5]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a1, a2, a5]*GReg[a3, a4, a5]] - CT[GReg[a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a5]*GReg[a3, a4, a5]] - 
    CT[GReg[a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*GReg[a1, a2, a9]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a9]*GReg[a3, a4, a5]] + CT[GReg[a5, a7, a9], 
     GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]*GReg[a1, a2, a3, a5]] - 
    CT[GReg[a5, a7, a9], GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3, a5]] - CT[GReg[a5, a7, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a8, a7]*GReg[a1, a2, a3, a9]] + CT[GReg[a5, a7, a9], 
     GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a5, a7, a9], GReg[a1, a5]*GReg[a6, a5]*GReg[a8, a7]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a5, a7, a9], GReg[a1, a9]*GReg[a6, a5]*
      GReg[a8, a7]*GReg[a2, a3, a4, a5]] - CT[GReg[a5, a7, a9], 
     GReg[a1, a5]*GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a4, a5]] + 
    CT[GReg[a5, a7, a9], GReg[a1, a9]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a1, a2, a3, a4, a5]] + CT[GReg[a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*GReg[a1, a2, a3, a4, 
       a9]] - CT[GReg[a5, a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3, a4, a9]] - CT[GReg[a5, a8, a9], 
     GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*
      GReg[a7, a8]] + CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a2, a5]*
      GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]] + 
    CT[GReg[a5, a8, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a5, a8, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a5, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a7, a8]*GReg[a1, a2, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a5]] - CT[GReg[a5, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a7, a8]*GReg[a1, a2, a9]] + 
    CT[GReg[a5, a8, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]] + CT[GReg[a5, a8, a9], GReg[a1, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a7, a8]*GReg[a2, a3, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]*
      GReg[a2, a3, a5]] - CT[GReg[a5, a8, a9], GReg[a1, a5]*GReg[a4, a5]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a5]] + 
    CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a5]] + CT[GReg[a5, a8, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a6, a5]*GReg[a7, a8]*GReg[a3, a4, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a2, a5]*GReg[a6, a5]*GReg[a7, a8]*
      GReg[a3, a4, a5]] - CT[GReg[a5, a8, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a2, a5]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a5]] - CT[GReg[a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a1, a2, a5]*GReg[a3, a4, a5]] + CT[GReg[a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*GReg[a1, a2, a9]*
      GReg[a3, a4, a5]] - CT[GReg[a5, a8, a9], GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]*GReg[a3, a4, a5]] + CT[GReg[a5, a8, a9], 
     GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a5, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a1, a2, a5]*GReg[a6, a7, a5]] + CT[GReg[a5, a8, a9], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a1, a2, a9]*GReg[a6, a7, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a1, a5]*GReg[a4, a5]*GReg[a2, a3, a5]*
      GReg[a6, a7, a5]] + CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a4, a5]*
      GReg[a2, a3, a5]*GReg[a6, a7, a5]] - CT[GReg[a5, a8, a9], 
     GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a4, a5]*
      GReg[a6, a7, a5]] + CT[GReg[a5, a8, a9], GReg[a1, a2, a5]*
      GReg[a3, a4, a5]*GReg[a6, a7, a5]] - CT[GReg[a5, a8, a9], 
     GReg[a1, a2, a9]*GReg[a3, a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a8]] + CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a2, a5]*
      GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a8]] + 
    CT[GReg[a5, a8, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a1, a2, a5]*
      GReg[a6, a7, a8]] - CT[GReg[a5, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a1, a2, a9]*GReg[a6, a7, a8]] + CT[GReg[a5, a8, a9], 
     GReg[a1, a5]*GReg[a4, a5]*GReg[a2, a3, a5]*GReg[a6, a7, a8]] - 
    CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a4, a5]*GReg[a2, a3, a5]*
      GReg[a6, a7, a8]] + CT[GReg[a5, a8, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a3, a4, a5]*GReg[a6, a7, a8]] - CT[GReg[a5, a8, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a4, a5]*GReg[a6, a7, a8]] - 
    CT[GReg[a5, a8, a9], GReg[a1, a2, a5]*GReg[a3, a4, a5]*
      GReg[a6, a7, a8]] + CT[GReg[a5, a8, a9], GReg[a1, a2, a9]*
      GReg[a3, a4, a5]*GReg[a6, a7, a8]] - CT[GReg[a5, a8, a9], 
     GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]*GReg[a1, a2, a3, a5]] + 
    CT[GReg[a5, a8, a9], GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a3, a5]] + CT[GReg[a5, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7, a5]*GReg[a1, a2, a3, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a4, a5]*GReg[a6, a7, a8]*
      GReg[a1, a2, a3, a5]] + CT[GReg[a5, a8, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a7, a8]*GReg[a1, a2, a3, a9]] - CT[GReg[a5, a8, a9], 
     GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a5, a8, a9], GReg[a4, a5]*GReg[a6, a7, a5]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a5, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7, a8]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a5, a8, a9], GReg[a1, a5]*GReg[a6, a5]*GReg[a7, a8]*
      GReg[a2, a3, a4, a5]] + CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a6, a5]*
      GReg[a7, a8]*GReg[a2, a3, a4, a5]] + CT[GReg[a5, a8, a9], 
     GReg[a1, a5]*GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a4, a5]] + CT[GReg[a5, a8, a9], 
     GReg[a1, a5]*GReg[a6, a7, a5]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a6, a7, a5]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a5, a8, a9], 
     GReg[a1, a5]*GReg[a6, a7, a8]*GReg[a2, a3, a4, a5]] + 
    CT[GReg[a5, a8, a9], GReg[a1, a9]*GReg[a6, a7, a8]*
      GReg[a2, a3, a4, a5]] + CT[GReg[a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a1, a2, a3, a4, a5]] - CT[GReg[a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3, a4, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a6, a7, a5]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a8, a9], GReg[a6, a7, a8]*GReg[a1, a2, a3, a4, a5]] - 
    CT[GReg[a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*GReg[a1, a2, a3, a4, 
       a9]] + CT[GReg[a5, a8, a9], GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a3, a4, a9]] + CT[GReg[a5, a8, a9], 
     GReg[a6, a7, a5]*GReg[a1, a2, a3, a4, a9]] - 
    CT[GReg[a5, a8, a9], GReg[a6, a7, a8]*GReg[a1, a2, a3, a4, a9]] - 
    CT[GReg[a6, a7, a9], GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a8, a7]] + CT[GReg[a6, a7, a9], 
     GReg[a1, a9]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a8, a7]] + CT[GReg[a6, a7, a9], GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a8, a7]*GReg[a1, a2, a6]] - 
    CT[GReg[a6, a7, a9], GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a1, a2, a9]] + CT[GReg[a6, a7, a9], GReg[a1, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a8, a7]*GReg[a2, a3, a6]] - 
    CT[GReg[a6, a7, a9], GReg[a1, a9]*GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a2, a3, a6]] + CT[GReg[a6, a7, a9], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a5, a6]*GReg[a8, a7]*GReg[a3, a4, a6]] - 
    CT[GReg[a6, a7, a9], GReg[a1, a9]*GReg[a2, a6]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a3, a4, a6]] - CT[GReg[a6, a7, a9], GReg[a5, a6]*GReg[a8, a7]*
      GReg[a1, a2, a6]*GReg[a3, a4, a6]] + CT[GReg[a6, a7, a9], 
     GReg[a5, a6]*GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a3, a4, a6]] + 
    CT[GReg[a6, a7, a9], GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*GReg[a8, a7]*
      GReg[a4, a5, a6]] - CT[GReg[a6, a7, a9], GReg[a1, a9]*GReg[a2, a6]*
      GReg[a3, a6]*GReg[a8, a7]*GReg[a4, a5, a6]] - 
    CT[GReg[a6, a7, a9], GReg[a3, a6]*GReg[a8, a7]*GReg[a1, a2, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a6, a7, a9], GReg[a3, a6]*GReg[a8, a7]*
      GReg[a1, a2, a9]*GReg[a4, a5, a6]] - CT[GReg[a6, a7, a9], 
     GReg[a1, a6]*GReg[a8, a7]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a6, a7, a9], GReg[a1, a9]*GReg[a8, a7]*GReg[a2, a3, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a6, a7, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a8, a7]*GReg[a1, a2, a3, a6]] + CT[GReg[a6, a7, a9], 
     GReg[a8, a7]*GReg[a4, a5, a6]*GReg[a1, a2, a3, a6]] + 
    CT[GReg[a6, a7, a9], GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a1, a2, a3, a9]] - CT[GReg[a6, a7, a9], 
     GReg[a8, a7]*GReg[a4, a5, a6]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a6, a7, a9], GReg[a1, a6]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a2, a3, a4, a6]] + CT[GReg[a6, a7, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a8, a7]*GReg[a2, a3, a4, a6]] - CT[GReg[a6, a7, a9], 
     GReg[a1, a6]*GReg[a2, a6]*GReg[a8, a7]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a7, a9], GReg[a1, a9]*GReg[a2, a6]*GReg[a8, a7]*
      GReg[a3, a4, a5, a6]] + CT[GReg[a6, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a6]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a6, a7, a9], GReg[a8, a7]*GReg[a1, a2, a9]*
      GReg[a3, a4, a5, a6]] + CT[GReg[a6, a7, a9], GReg[a5, a6]*GReg[a8, a7]*
      GReg[a1, a2, a3, a4, a6]] - CT[GReg[a6, a7, a9], 
     GReg[a5, a6]*GReg[a8, a7]*GReg[a1, a2, a3, a4, a9]] + 
    CT[GReg[a6, a7, a9], GReg[a1, a6]*GReg[a8, a7]*GReg[a2, a3, a4, a5, 
       a6]] - CT[GReg[a6, a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a2, a3, a4, a5, a6]] - CT[GReg[a6, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a3, a4, a5, a6]] + 
    CT[GReg[a6, a7, a9], GReg[a8, a7]*GReg[a1, a2, a3, a4, a5, a9]] - 
    CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]] - 
    CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8]] + CT[GReg[a6, a8, a9], 
     GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a1, a2, a6]] - CT[GReg[a6, a8, a9], GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a9]] + 
    CT[GReg[a6, a8, a9], GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a1, a2, a9]] + CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a6]*GReg[a2, a3, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a6]] - CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8]*GReg[a2, a3, a6]] + 
    CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a2, a3, a6]] + CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a5, a6]*GReg[a7, a6]*GReg[a3, a4, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a2, a6]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a3, a4, a6]] - CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a5, a6]*GReg[a7, a8]*GReg[a3, a4, a6]] + 
    CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a2, a6]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a3, a4, a6]] - CT[GReg[a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a6]*GReg[a3, a4, a6]] + CT[GReg[a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a8]*GReg[a1, a2, a6]*GReg[a3, a4, a6]] + 
    CT[GReg[a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a9]*
      GReg[a3, a4, a6]] - CT[GReg[a6, a8, a9], GReg[a5, a6]*GReg[a7, a8]*
      GReg[a1, a2, a9]*GReg[a3, a4, a6]] + CT[GReg[a6, a8, a9], 
     GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*GReg[a7, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a2, a6]*GReg[a3, a6]*GReg[a7, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a3, a6]*GReg[a7, a8]*GReg[a4, a5, a6]] + 
    CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a2, a6]*GReg[a3, a6]*GReg[a7, a8]*
      GReg[a4, a5, a6]] - CT[GReg[a6, a8, a9], GReg[a3, a6]*GReg[a7, a6]*
      GReg[a1, a2, a6]*GReg[a4, a5, a6]] + CT[GReg[a6, a8, a9], 
     GReg[a3, a6]*GReg[a7, a8]*GReg[a1, a2, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a6, a8, a9], GReg[a3, a6]*GReg[a7, a6]*GReg[a1, a2, a9]*
      GReg[a4, a5, a6]] - CT[GReg[a6, a8, a9], GReg[a3, a6]*GReg[a7, a8]*
      GReg[a1, a2, a9]*GReg[a4, a5, a6]] - CT[GReg[a6, a8, a9], 
     GReg[a1, a6]*GReg[a7, a6]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a7, a6]*GReg[a2, a3, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a7, a8]*
      GReg[a2, a3, a6]*GReg[a4, a5, a6]] - CT[GReg[a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a3, a6]] + CT[GReg[a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8]*GReg[a1, a2, a3, a6]] + CT[GReg[a6, a8, a9], 
     GReg[a7, a6]*GReg[a4, a5, a6]*GReg[a1, a2, a3, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a7, a8]*GReg[a4, a5, a6]*
      GReg[a1, a2, a3, a6]] + CT[GReg[a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a1, a2, a3, a9]] - CT[GReg[a6, a8, a9], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a6, a8, a9], GReg[a7, a6]*GReg[a4, a5, a6]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a6, a8, a9], 
     GReg[a7, a8]*GReg[a4, a5, a6]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a4, a6]] + CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a2, a3, a4, a6]] + CT[GReg[a6, a8, a9], 
     GReg[a1, a6]*GReg[a5, a6]*GReg[a7, a8]*GReg[a2, a3, a4, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a2, a3, a4, a6]] - CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a7, a6]*GReg[a3, a4, a5, a6]] + CT[GReg[a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a6]*GReg[a7, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a2, a6]*GReg[a7, a8]*
      GReg[a3, a4, a5, a6]] - CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a2, a6]*
      GReg[a7, a8]*GReg[a3, a4, a5, a6]] + CT[GReg[a6, a8, a9], 
     GReg[a7, a6]*GReg[a1, a2, a6]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a7, a8]*GReg[a1, a2, a6]*
      GReg[a3, a4, a5, a6]] - CT[GReg[a6, a8, a9], 
     GReg[a7, a6]*GReg[a1, a2, a9]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a8, a9], GReg[a7, a8]*GReg[a1, a2, a9]*
      GReg[a3, a4, a5, a6]] + CT[GReg[a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a3, a4, a6]] - CT[GReg[a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a8]*GReg[a1, a2, a3, a4, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a3, a4, 
       a9]] + CT[GReg[a6, a8, a9], GReg[a5, a6]*GReg[a7, a8]*
      GReg[a1, a2, a3, a4, a9]] + CT[GReg[a6, a8, a9], 
     GReg[a1, a6]*GReg[a7, a6]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a1, a9]*GReg[a7, a6]*GReg[a2, a3, a4, a5, 
       a6]] - CT[GReg[a6, a8, a9], GReg[a1, a6]*GReg[a7, a8]*
      GReg[a2, a3, a4, a5, a6]] + CT[GReg[a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a8, a9], GReg[a7, a6]*GReg[a1, a2, a3, a4, a5, a6]] + 
    CT[GReg[a6, a8, a9], GReg[a7, a8]*GReg[a1, a2, a3, a4, a5, a6]] + 
    CT[GReg[a6, a8, a9], GReg[a7, a6]*GReg[a1, a2, a3, a4, a5, a9]] - 
    CT[GReg[a6, a8, a9], GReg[a7, a8]*GReg[a1, a2, a3, a4, a5, a9]] + 
    CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a7, a8, a9], GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a2, a3, a7]] - CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a2, a7]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a3, a4, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a2, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a3, a4, a7]] + CT[GReg[a7, a8, a9], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a1, a2, a7]*GReg[a3, a4, a7]] - CT[GReg[a7, a8, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a9]*GReg[a3, a4, a7]] - 
    CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a7]*GReg[a6, a7]*
      GReg[a4, a5, a7]] + CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a2, a7]*
      GReg[a3, a7]*GReg[a6, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a3, a7]*GReg[a6, a7]*GReg[a1, a2, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a7, a8, a9], GReg[a3, a7]*GReg[a6, a7]*
      GReg[a1, a2, a9]*GReg[a4, a5, a7]] + CT[GReg[a7, a8, a9], 
     GReg[a1, a7]*GReg[a6, a7]*GReg[a2, a3, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a6, a7]*GReg[a2, a3, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a2, a7]*
      GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a7, a8, a9], GReg[a3, a7]*GReg[a4, a7]*
      GReg[a1, a2, a7]*GReg[a5, a6, a7]] - CT[GReg[a7, a8, a9], 
     GReg[a3, a7]*GReg[a4, a7]*GReg[a1, a2, a9]*GReg[a5, a6, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a4, a7]*GReg[a2, a3, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a4, a7]*
      GReg[a2, a3, a7]*GReg[a5, a6, a7]] + CT[GReg[a7, a8, a9], 
     GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a2, a7]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a7, a8, a9], GReg[a1, a2, a7]*
      GReg[a3, a4, a7]*GReg[a5, a6, a7]] + CT[GReg[a7, a8, a9], 
     GReg[a1, a2, a9]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a1, a2, a3, a7]] - CT[GReg[a7, a8, a9], 
     GReg[a6, a7]*GReg[a4, a5, a7]*GReg[a1, a2, a3, a7]] - 
    CT[GReg[a7, a8, a9], GReg[a4, a7]*GReg[a5, a6, a7]*
      GReg[a1, a2, a3, a7]] - CT[GReg[a7, a8, a9], GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a1, a2, a3, a9]] + CT[GReg[a7, a8, a9], 
     GReg[a6, a7]*GReg[a4, a5, a7]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a7, a8, a9], GReg[a4, a7]*GReg[a5, a6, a7]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a2, a3, a4, a7]] - CT[GReg[a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a4, a7]] - 
    CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a5, a6, a7]*
      GReg[a2, a3, a4, a7]] + CT[GReg[a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a6, a7]*GReg[a2, a3, a4, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a2, a7]*GReg[a6, a7]*
      GReg[a3, a4, a5, a7]] - CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a2, a7]*
      GReg[a6, a7]*GReg[a3, a4, a5, a7]] - CT[GReg[a7, a8, a9], 
     GReg[a6, a7]*GReg[a1, a2, a7]*GReg[a3, a4, a5, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a6, a7]*GReg[a1, a2, a9]*
      GReg[a3, a4, a5, a7]] + CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a2, a7]*
      GReg[a3, a7]*GReg[a4, a5, a6, a7]] - CT[GReg[a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a7, a8, a9], GReg[a3, a7]*GReg[a1, a2, a7]*
      GReg[a4, a5, a6, a7]] + CT[GReg[a7, a8, a9], 
     GReg[a3, a7]*GReg[a1, a2, a9]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a2, a3, a7]*
      GReg[a4, a5, a6, a7]] + CT[GReg[a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3, a7]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a1, a2, a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a7, a8, a9], GReg[a1, a2, a3, a9]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a7, a8, a9], GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a3, a4, 
       a7]] + CT[GReg[a7, a8, a9], GReg[a5, a6, a7]*GReg[a1, a2, a3, a4, 
       a7]] + CT[GReg[a7, a8, a9], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a1, a2, a3, a4, a9]] - CT[GReg[a7, a8, a9], 
     GReg[a5, a6, a7]*GReg[a1, a2, a3, a4, a9]] - 
    CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a6, a7]*GReg[a2, a3, a4, a5, 
       a7]] + CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a6, a7]*
      GReg[a2, a3, a4, a5, a7]] - CT[GReg[a7, a8, a9], 
     GReg[a1, a7]*GReg[a2, a7]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a2, a7]*GReg[a3, a4, a5, a6, 
       a7]] + CT[GReg[a7, a8, a9], GReg[a1, a2, a7]*GReg[a3, a4, a5, a6, 
       a7]] - CT[GReg[a7, a8, a9], GReg[a1, a2, a9]*GReg[a3, a4, a5, a6, 
       a7]] + CT[GReg[a7, a8, a9], GReg[a6, a7]*GReg[a1, a2, a3, a4, a5, 
       a7]] - CT[GReg[a7, a8, a9], GReg[a6, a7]*GReg[a1, a2, a3, a4, a5, 
       a9]] + CT[GReg[a7, a8, a9], GReg[a1, a7]*GReg[a2, a3, a4, a5, a6, 
       a7]] - CT[GReg[a7, a8, a9], GReg[a1, a9]*GReg[a2, a3, a4, a5, a6, 
       a7]] - CT[GReg[a7, a8, a9], GReg[a1, a2, a3, a4, a5, a6, a7]] + 
    CT[GReg[a7, a8, a9], GReg[a1, a2, a3, a4, a5, a6, a9]] + 
    CT[GReg[a1, a2, a3, a9], GReg[a4, a5, a6, a7, a8, a3]] + 
    CT[GReg[a1, a2, a4, a9], GReg[a3, a2]*GReg[a5, a6, a7, a8, a4]] - 
    CT[GReg[a1, a2, a4, a9], GReg[a3, a4]*GReg[a5, a6, a7, a8, a4]] - 
    CT[GReg[a1, a2, a5, a9], GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a1, a2, a5, a9], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a1, a2, a5, a9], GReg[a3, a4, a2]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a1, a2, a5, a9], GReg[a3, a4, a5]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a1, a2, a6, a9], GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a2, a6, a9], GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8, a6]] - CT[GReg[a1, a2, a6, a9], 
     GReg[a5, a6]*GReg[a3, a4, a2]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a2, a6, a9], GReg[a5, a6]*GReg[a3, a4, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a2, a6, a9], 
     GReg[a3, a2]*GReg[a4, a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a2, a6, a9], GReg[a3, a6]*GReg[a4, a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a2, a6, a9], 
     GReg[a7, a8, a6]*GReg[a3, a4, a5, a2]] - CT[GReg[a1, a2, a6, a9], 
     GReg[a7, a8, a6]*GReg[a3, a4, a5, a6]] - CT[GReg[a1, a2, a7, a9], 
     GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a1, a2, a7, a9], GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a1, a2, a7, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a2]] - 
    CT[GReg[a1, a2, a7, a9], GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a7]] + CT[GReg[a1, a2, a7, a9], GReg[a3, a2]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a4, a5, a7]] - CT[GReg[a1, a2, a7, a9], 
     GReg[a3, a7]*GReg[a6, a7]*GReg[a8, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a1, a2, a7, a9], GReg[a3, a2]*GReg[a4, a7]*GReg[a8, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a1, a2, a7, a9], GReg[a3, a7]*GReg[a4, a7]*
      GReg[a8, a7]*GReg[a5, a6, a7]] - CT[GReg[a1, a2, a7, a9], 
     GReg[a8, a7]*GReg[a3, a4, a2]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a2, a7, a9], GReg[a8, a7]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a1, a2, a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a5, a2]] + CT[GReg[a1, a2, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a5, a7]] - 
    CT[GReg[a1, a2, a7, a9], GReg[a3, a2]*GReg[a8, a7]*
      GReg[a4, a5, a6, a7]] + CT[GReg[a1, a2, a7, a9], 
     GReg[a3, a7]*GReg[a8, a7]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a1, a2, a7, a9], GReg[a8, a7]*GReg[a3, a4, a5, a6, a2]] - 
    CT[GReg[a1, a2, a7, a9], GReg[a8, a7]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a2]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a1, a2, a8, a9], 
     GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a1, a2, a8, a9], GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a2]] + CT[GReg[a1, a2, a8, a9], GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a3, a4, a8]] - CT[GReg[a1, a2, a8, a9], 
     GReg[a3, a2]*GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a8]] + 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a4, a5, a8]] - CT[GReg[a1, a2, a8, a9], GReg[a3, a2]*GReg[a4, a8]*
      GReg[a7, a8]*GReg[a5, a6, a8]] + CT[GReg[a1, a2, a8, a9], 
     GReg[a3, a8]*GReg[a4, a8]*GReg[a7, a8]*GReg[a5, a6, a8]] + 
    CT[GReg[a1, a2, a8, a9], GReg[a7, a8]*GReg[a3, a4, a2]*
      GReg[a5, a6, a8]] - CT[GReg[a1, a2, a8, a9], 
     GReg[a7, a8]*GReg[a3, a4, a8]*GReg[a5, a6, a8]] - 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a2]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a2, a8, a9], GReg[a3, a8]*GReg[a4, a8]*
      GReg[a5, a8]*GReg[a6, a7, a8]] + CT[GReg[a1, a2, a8, a9], 
     GReg[a5, a8]*GReg[a3, a4, a2]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a2, a8, a9], GReg[a5, a8]*GReg[a3, a4, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a2, a8, a9], 
     GReg[a3, a2]*GReg[a4, a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a8]*GReg[a4, a5, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a2, a8, a9], GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a5, a2]] - CT[GReg[a1, a2, a8, a9], 
     GReg[a6, a7, a8]*GReg[a3, a4, a5, a2]] - CT[GReg[a1, a2, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a5, a8]] + 
    CT[GReg[a1, a2, a8, a9], GReg[a6, a7, a8]*GReg[a3, a4, a5, a8]] + 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a2]*GReg[a7, a8]*
      GReg[a4, a5, a6, a8]] - CT[GReg[a1, a2, a8, a9], 
     GReg[a3, a8]*GReg[a7, a8]*GReg[a4, a5, a6, a8]] + 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a2]*GReg[a4, a8]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a1, a2, a8, a9], 
     GReg[a3, a8]*GReg[a4, a8]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a4, a2]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a4, a8]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a1, a2, a8, a9], GReg[a7, a8]*GReg[a3, a4, a5, a6, a2]] + 
    CT[GReg[a1, a2, a8, a9], GReg[a7, a8]*GReg[a3, a4, a5, a6, a8]] - 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a2]*GReg[a4, a5, a6, a7, a8]] + 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a8]*GReg[a4, a5, a6, a7, a8]] + 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a4, a5, a6, a7, a2]] - 
    CT[GReg[a1, a2, a8, a9], GReg[a3, a4, a5, a6, a7, a8]] + 
    CT[GReg[a1, a3, a4, a9], GReg[a2, a1]*GReg[a5, a6, a7, a8, a4]] - 
    CT[GReg[a1, a3, a4, a9], GReg[a2, a3]*GReg[a5, a6, a7, a8, a4]] + 
    CT[GReg[a1, a3, a5, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a1, a3, a5, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a1, a3, a5, a9], GReg[a2, a1]*GReg[a4, a5]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a1, a3, a5, a9], 
     GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a1, a3, a6, a9], GReg[a2, a1]*GReg[a4, a3]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a3, a6, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a7, a8, a6]] + CT[GReg[a1, a3, a6, a9], 
     GReg[a2, a1]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a3, a6, a9], GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a3, a6, a9], 
     GReg[a2, a1]*GReg[a4, a5, a3]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a3, a6, a9], GReg[a2, a3]*GReg[a4, a5, a3]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a3, a6, a9], 
     GReg[a2, a1]*GReg[a4, a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a3, a6, a9], GReg[a2, a3]*GReg[a4, a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a3, a7, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a1, a3, a7, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a1, a3, a7, a9], GReg[a2, a1]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a1, a3, a7, a9], 
     GReg[a2, a3]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a1, a3, a7, a9], GReg[a2, a1]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a3]] + CT[GReg[a1, a3, a7, a9], GReg[a2, a3]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a4, a5, a3]] + CT[GReg[a1, a3, a7, a9], 
     GReg[a2, a1]*GReg[a6, a7]*GReg[a8, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a3, a7, a9], GReg[a2, a3]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a1, a3, a7, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a8, a7]*GReg[a5, a6, a7]] + CT[GReg[a1, a3, a7, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a8, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a3, a7, a9], GReg[a2, a1]*GReg[a4, a7]*GReg[a8, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a1, a3, a7, a9], GReg[a2, a3]*GReg[a4, a7]*
      GReg[a8, a7]*GReg[a5, a6, a7]] + CT[GReg[a1, a3, a7, a9], 
     GReg[a2, a1]*GReg[a8, a7]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a1, a3, a7, a9], GReg[a2, a3]*GReg[a8, a7]*
      GReg[a4, a5, a6, a3]] - CT[GReg[a1, a3, a7, a9], 
     GReg[a2, a1]*GReg[a8, a7]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a1, a3, a7, a9], GReg[a2, a3]*GReg[a8, a7]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a1]*GReg[a4, a3]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a1]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a3]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a1]*GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a3]] - 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a3]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a4, a5, a3]] - CT[GReg[a1, a3, a8, a9], GReg[a2, a1]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a4, a5, a8]] + CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a3]*GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a8]] + 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a1]*GReg[a4, a3]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a1, a3, a8, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a7, a8]*GReg[a5, a6, a8]] - CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a1]*GReg[a4, a8]*GReg[a7, a8]*GReg[a5, a6, a8]] + 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a3]*GReg[a4, a8]*GReg[a7, a8]*
      GReg[a5, a6, a8]] + CT[GReg[a1, a3, a8, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a5, a8]*GReg[a6, a7, a8]] - CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a1]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a3, a8, a9], GReg[a2, a3]*GReg[a4, a8]*
      GReg[a5, a8]*GReg[a6, a7, a8]] - CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a1]*GReg[a4, a5, a3]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a3]*GReg[a4, a5, a3]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a1]*GReg[a4, a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a3]*GReg[a4, a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a3, a8, a9], GReg[a2, a1]*GReg[a7, a8]*
      GReg[a4, a5, a6, a3]] + CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a3]*GReg[a7, a8]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a1]*GReg[a7, a8]*
      GReg[a4, a5, a6, a8]] - CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a3]*GReg[a7, a8]*GReg[a4, a5, a6, a8]] - 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a1]*GReg[a4, a8]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a1, a3, a8, a9], 
     GReg[a2, a3]*GReg[a4, a8]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a1]*GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a3]*GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a1]*GReg[a4, a5, a6, a7, a8]] + 
    CT[GReg[a1, a3, a8, a9], GReg[a2, a3]*GReg[a4, a5, a6, a7, a8]] - 
    CT[GReg[a1, a4, a5, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a1, a4, a5, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a1, a4, a5, a9], GReg[a2, a3, a1]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a1, a4, a5, a9], GReg[a2, a3, a4]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a1, a4, a6, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a4, a6, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a7, a8, a6]] + CT[GReg[a1, a4, a6, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a4, a6, a9], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a4, a6, a9], 
     GReg[a5, a4]*GReg[a2, a3, a1]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a4, a6, a9], GReg[a5, a6]*GReg[a2, a3, a1]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a4, a6, a9], 
     GReg[a5, a4]*GReg[a2, a3, a4]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a4, a6, a9], GReg[a5, a6]*GReg[a2, a3, a4]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a4, a7, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a1, a4, a7, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a1, a4, a7, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a1, a4, a7, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a1, a4, a7, a9], GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a1]] + CT[GReg[a1, a4, a7, a9], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a2, a3, a1]] + CT[GReg[a1, a4, a7, a9], 
     GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a1, a4, a7, a9], GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a4]] - CT[GReg[a1, a4, a7, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a8, a7]*GReg[a5, a6, a4]] + CT[GReg[a1, a4, a7, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a8, a7]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a4, a7, a9], GReg[a8, a7]*GReg[a2, a3, a1]*
      GReg[a5, a6, a4]] - CT[GReg[a1, a4, a7, a9], 
     GReg[a8, a7]*GReg[a2, a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a4, a7, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a8, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a1, a4, a7, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a8, a7]*GReg[a5, a6, a7]] - CT[GReg[a1, a4, a7, a9], 
     GReg[a8, a7]*GReg[a2, a3, a1]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a4, a7, a9], GReg[a8, a7]*GReg[a2, a3, a4]*
      GReg[a5, a6, a7]] - CT[GReg[a1, a4, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a1, a4, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a1, a4, a8, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a1, a4, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a1, a4, a8, a9], GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a4, a8, a9], GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a2, a3, a1]] - CT[GReg[a1, a4, a8, a9], 
     GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a4]] + 
    CT[GReg[a1, a4, a8, a9], GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a4]] + CT[GReg[a1, a4, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a7, a8]*GReg[a5, a6, a4]] - CT[GReg[a1, a4, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a7, a8]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a4, a8, a9], GReg[a7, a8]*GReg[a2, a3, a1]*
      GReg[a5, a6, a4]] + CT[GReg[a1, a4, a8, a9], 
     GReg[a7, a8]*GReg[a2, a3, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a4, a8, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a7, a8]*
      GReg[a5, a6, a8]] + CT[GReg[a1, a4, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a7, a8]*GReg[a5, a6, a8]] + CT[GReg[a1, a4, a8, a9], 
     GReg[a7, a8]*GReg[a2, a3, a1]*GReg[a5, a6, a8]] - 
    CT[GReg[a1, a4, a8, a9], GReg[a7, a8]*GReg[a2, a3, a4]*
      GReg[a5, a6, a8]] + CT[GReg[a1, a4, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a6, a7, a8]] - CT[GReg[a1, a4, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a4, a8, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a4, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a8]*GReg[a6, a7, a8]] - CT[GReg[a1, a4, a8, a9], 
     GReg[a5, a4]*GReg[a2, a3, a1]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a4, a8, a9], GReg[a5, a8]*GReg[a2, a3, a1]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a4, a8, a9], 
     GReg[a5, a4]*GReg[a2, a3, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a4, a8, a9], GReg[a5, a8]*GReg[a2, a3, a4]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a4, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a5, a6, a7, a4]] + CT[GReg[a1, a4, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a1, a4, a8, a9], GReg[a2, a3, a1]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a1, a4, a8, a9], GReg[a2, a3, a4]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a1, a4, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a1, a4, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a1, a4, a8, a9], GReg[a2, a3, a1]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a4, a8, a9], GReg[a2, a3, a4]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a5, a6, a9], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a5, a6, a9], GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a7, a8, a6]] - CT[GReg[a1, a5, a6, a9], 
     GReg[a4, a5]*GReg[a2, a3, a1]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a5, a6, a9], GReg[a4, a5]*GReg[a2, a3, a5]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a5, a6, a9], 
     GReg[a2, a1]*GReg[a3, a4, a5]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a5, a6, a9], GReg[a2, a5]*GReg[a3, a4, a5]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a5, a6, a9], 
     GReg[a7, a8, a6]*GReg[a2, a3, a4, a1]] - CT[GReg[a1, a5, a6, a9], 
     GReg[a7, a8, a6]*GReg[a2, a3, a4, a5]] + CT[GReg[a1, a5, a7, a9], 
     GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]] - 
    CT[GReg[a1, a5, a7, a9], GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a8, a7]] - CT[GReg[a1, a5, a7, a9], 
     GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a1, a5, a7, a9], GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a1, a5, a7, a9], 
     GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a5, a7, a9], GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a1]] + CT[GReg[a1, a5, a7, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a8, a7]*GReg[a2, a3, a5]] - CT[GReg[a1, a5, a7, a9], 
     GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a5]] - 
    CT[GReg[a1, a5, a7, a9], GReg[a2, a1]*GReg[a6, a5]*GReg[a8, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a1, a5, a7, a9], GReg[a2, a5]*GReg[a6, a5]*
      GReg[a8, a7]*GReg[a3, a4, a5]] + CT[GReg[a1, a5, a7, a9], 
     GReg[a2, a1]*GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a5]] - 
    CT[GReg[a1, a5, a7, a9], GReg[a2, a5]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a1, a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a2, a3, a4, a1]] - CT[GReg[a1, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a2, a3, a4, a5]] + CT[GReg[a1, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a1, a5, a8, a9], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a7, a8]] + CT[GReg[a1, a5, a8, a9], 
     GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]] + 
    CT[GReg[a1, a5, a8, a9], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a1, a5, a8, a9], 
     GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a1, a5, a8, a9], GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a5, a8, a9], GReg[a4, a5]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a2, a3, a1]] - CT[GReg[a1, a5, a8, a9], 
     GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]*GReg[a2, a3, a5]] + 
    CT[GReg[a1, a5, a8, a9], GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a5]] + CT[GReg[a1, a5, a8, a9], GReg[a2, a1]*GReg[a6, a5]*
      GReg[a7, a8]*GReg[a3, a4, a5]] - CT[GReg[a1, a5, a8, a9], 
     GReg[a2, a5]*GReg[a6, a5]*GReg[a7, a8]*GReg[a3, a4, a5]] - 
    CT[GReg[a1, a5, a8, a9], GReg[a2, a1]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a5]] + CT[GReg[a1, a5, a8, a9], GReg[a2, a5]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a3, a4, a5]] + CT[GReg[a1, a5, a8, a9], 
     GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a5, a8, a9], GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a1, a5, a8, a9], 
     GReg[a4, a5]*GReg[a2, a3, a1]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a5, a8, a9], GReg[a4, a5]*GReg[a2, a3, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a1, a5, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a5, a8, a9], GReg[a2, a5]*GReg[a3, a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a1, a5, a8, a9], GReg[a2, a1]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a7, a8]] + CT[GReg[a1, a5, a8, a9], 
     GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a5, a8, a9], GReg[a4, a5]*GReg[a2, a3, a1]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a5, a8, a9], 
     GReg[a4, a5]*GReg[a2, a3, a5]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a5, a8, a9], GReg[a2, a1]*GReg[a3, a4, a5]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a5, a8, a9], 
     GReg[a2, a5]*GReg[a3, a4, a5]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a2, a3, a4, a1]] + CT[GReg[a1, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a4, a1]] + 
    CT[GReg[a1, a5, a8, a9], GReg[a6, a7, a5]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a8, a9], GReg[a6, a7, a8]*GReg[a2, a3, a4, a1]] + 
    CT[GReg[a1, a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a1, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a1, a5, a8, a9], GReg[a6, a7, a5]*GReg[a2, a3, a4, a5]] + 
    CT[GReg[a1, a5, a8, a9], GReg[a6, a7, a8]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a1, a6, a7, a9], GReg[a2, a1]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a8, a7]] + CT[GReg[a1, a6, a7, a9], 
     GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a1, a6, a7, a9], GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a6, a7, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a8, a7]*GReg[a2, a3, a6]] + CT[GReg[a1, a6, a7, a9], 
     GReg[a2, a1]*GReg[a5, a6]*GReg[a8, a7]*GReg[a3, a4, a6]] - 
    CT[GReg[a1, a6, a7, a9], GReg[a2, a6]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a3, a4, a6]] + CT[GReg[a1, a6, a7, a9], GReg[a2, a1]*GReg[a3, a6]*
      GReg[a8, a7]*GReg[a4, a5, a6]] - CT[GReg[a1, a6, a7, a9], 
     GReg[a2, a6]*GReg[a3, a6]*GReg[a8, a7]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a6, a7, a9], GReg[a8, a7]*GReg[a2, a3, a1]*
      GReg[a4, a5, a6]] + CT[GReg[a1, a6, a7, a9], 
     GReg[a8, a7]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a6, a7, a9], GReg[a5, a6]*GReg[a8, a7]*
      GReg[a2, a3, a4, a1]] + CT[GReg[a1, a6, a7, a9], 
     GReg[a5, a6]*GReg[a8, a7]*GReg[a2, a3, a4, a6]] - 
    CT[GReg[a1, a6, a7, a9], GReg[a2, a1]*GReg[a8, a7]*
      GReg[a3, a4, a5, a6]] + CT[GReg[a1, a6, a7, a9], 
     GReg[a2, a6]*GReg[a8, a7]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a6, a7, a9], GReg[a8, a7]*GReg[a2, a3, a4, a5, a1]] - 
    CT[GReg[a1, a6, a7, a9], GReg[a8, a7]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a1, a6, a8, a9], GReg[a2, a1]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a1, a6, a8, a9], 
     GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a1, a6, a8, a9], GReg[a2, a1]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8]] - CT[GReg[a1, a6, a8, a9], 
     GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]] + 
    CT[GReg[a1, a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8]*GReg[a2, a3, a1]] - CT[GReg[a1, a6, a8, a9], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*GReg[a2, a3, a6]] + 
    CT[GReg[a1, a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a2, a3, a6]] + CT[GReg[a1, a6, a8, a9], GReg[a2, a1]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a3, a4, a6]] - CT[GReg[a1, a6, a8, a9], 
     GReg[a2, a6]*GReg[a5, a6]*GReg[a7, a6]*GReg[a3, a4, a6]] - 
    CT[GReg[a1, a6, a8, a9], GReg[a2, a1]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a3, a4, a6]] + CT[GReg[a1, a6, a8, a9], GReg[a2, a6]*GReg[a5, a6]*
      GReg[a7, a8]*GReg[a3, a4, a6]] + CT[GReg[a1, a6, a8, a9], 
     GReg[a2, a1]*GReg[a3, a6]*GReg[a7, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a6, a8, a9], GReg[a2, a6]*GReg[a3, a6]*GReg[a7, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a1, a6, a8, a9], GReg[a2, a1]*GReg[a3, a6]*
      GReg[a7, a8]*GReg[a4, a5, a6]] + CT[GReg[a1, a6, a8, a9], 
     GReg[a2, a6]*GReg[a3, a6]*GReg[a7, a8]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a6, a8, a9], GReg[a7, a6]*GReg[a2, a3, a1]*
      GReg[a4, a5, a6]] + CT[GReg[a1, a6, a8, a9], 
     GReg[a7, a8]*GReg[a2, a3, a1]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a6, a8, a9], GReg[a7, a6]*GReg[a2, a3, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a1, a6, a8, a9], 
     GReg[a7, a8]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a4, a1]] + CT[GReg[a1, a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a8]*GReg[a2, a3, a4, a1]] + 
    CT[GReg[a1, a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a4, a6]] - CT[GReg[a1, a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a8]*GReg[a2, a3, a4, a6]] - 
    CT[GReg[a1, a6, a8, a9], GReg[a2, a1]*GReg[a7, a6]*
      GReg[a3, a4, a5, a6]] + CT[GReg[a1, a6, a8, a9], 
     GReg[a2, a6]*GReg[a7, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a6, a8, a9], GReg[a2, a1]*GReg[a7, a8]*
      GReg[a3, a4, a5, a6]] - CT[GReg[a1, a6, a8, a9], 
     GReg[a2, a6]*GReg[a7, a8]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a6, a8, a9], GReg[a7, a6]*GReg[a2, a3, a4, a5, a1]] - 
    CT[GReg[a1, a6, a8, a9], GReg[a7, a8]*GReg[a2, a3, a4, a5, a1]] - 
    CT[GReg[a1, a6, a8, a9], GReg[a7, a6]*GReg[a2, a3, a4, a5, a6]] + 
    CT[GReg[a1, a6, a8, a9], GReg[a7, a8]*GReg[a2, a3, a4, a5, a6]] + 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a1]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a1, a7, a8, a9], 
     GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a7, a8, a9], GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a2, a3, a1]] + CT[GReg[a1, a7, a8, a9], GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a2, a3, a7]] - CT[GReg[a1, a7, a8, a9], 
     GReg[a2, a1]*GReg[a5, a7]*GReg[a6, a7]*GReg[a3, a4, a7]] + 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a3, a4, a7]] - CT[GReg[a1, a7, a8, a9], GReg[a2, a1]*GReg[a3, a7]*
      GReg[a6, a7]*GReg[a4, a5, a7]] + CT[GReg[a1, a7, a8, a9], 
     GReg[a2, a7]*GReg[a3, a7]*GReg[a6, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a1, a7, a8, a9], GReg[a6, a7]*GReg[a2, a3, a1]*
      GReg[a4, a5, a7]] - CT[GReg[a1, a7, a8, a9], 
     GReg[a6, a7]*GReg[a2, a3, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a1]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a1, a7, a8, a9], GReg[a2, a7]*GReg[a3, a7]*
      GReg[a4, a7]*GReg[a5, a6, a7]] + CT[GReg[a1, a7, a8, a9], 
     GReg[a4, a7]*GReg[a2, a3, a1]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a7, a8, a9], GReg[a4, a7]*GReg[a2, a3, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a1, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a7]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a1, a7, a8, a9], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a2, a3, a4, a1]] - CT[GReg[a1, a7, a8, a9], 
     GReg[a5, a6, a7]*GReg[a2, a3, a4, a1]] - CT[GReg[a1, a7, a8, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a4, a7]] + 
    CT[GReg[a1, a7, a8, a9], GReg[a5, a6, a7]*GReg[a2, a3, a4, a7]] + 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a1]*GReg[a6, a7]*
      GReg[a3, a4, a5, a7]] - CT[GReg[a1, a7, a8, a9], 
     GReg[a2, a7]*GReg[a6, a7]*GReg[a3, a4, a5, a7]] + 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a1]*GReg[a3, a7]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a1, a7, a8, a9], 
     GReg[a2, a7]*GReg[a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a3, a1]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a1, a7, a8, a9], GReg[a6, a7]*GReg[a2, a3, a4, a5, a1]] + 
    CT[GReg[a1, a7, a8, a9], GReg[a6, a7]*GReg[a2, a3, a4, a5, a7]] - 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a1]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a7]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a3, a4, a5, a6, a1]] - 
    CT[GReg[a1, a7, a8, a9], GReg[a2, a3, a4, a5, a6, a7]] - 
    CT[GReg[a2, a3, a4, a9], GReg[a1, a2]*GReg[a5, a6, a7, a8, a4]] + 
    CT[GReg[a2, a3, a4, a9], GReg[a1, a9]*GReg[a5, a6, a7, a8, a4]] - 
    CT[GReg[a2, a3, a5, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a2, a3, a5, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a2, a3, a5, a9], GReg[a1, a2]*GReg[a4, a5]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a2, a3, a5, a9], 
     GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a2, a3, a6, a9], GReg[a1, a2]*GReg[a4, a3]*GReg[a5, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a2, a3, a6, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a7, a8, a6]] - CT[GReg[a2, a3, a6, a9], 
     GReg[a1, a2]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a2, a3, a6, a9], GReg[a1, a9]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a2, a3, a6, a9], 
     GReg[a1, a2]*GReg[a4, a5, a3]*GReg[a7, a8, a6]] + 
    CT[GReg[a2, a3, a6, a9], GReg[a1, a9]*GReg[a4, a5, a3]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a3, a6, a9], 
     GReg[a1, a2]*GReg[a4, a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a3, a6, a9], GReg[a1, a9]*GReg[a4, a5, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a2, a3, a7, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a2, a3, a7, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a2, a3, a7, a9], GReg[a1, a2]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a2, a3, a7, a9], 
     GReg[a1, a9]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a2, a3, a7, a9], GReg[a1, a2]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a3]] - CT[GReg[a2, a3, a7, a9], GReg[a1, a9]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a4, a5, a3]] - CT[GReg[a2, a3, a7, a9], 
     GReg[a1, a2]*GReg[a6, a7]*GReg[a8, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a2, a3, a7, a9], GReg[a1, a9]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a7]] + CT[GReg[a2, a3, a7, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a8, a7]*GReg[a5, a6, a7]] - CT[GReg[a2, a3, a7, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a8, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a3, a7, a9], GReg[a1, a2]*GReg[a4, a7]*GReg[a8, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a2, a3, a7, a9], GReg[a1, a9]*GReg[a4, a7]*
      GReg[a8, a7]*GReg[a5, a6, a7]] - CT[GReg[a2, a3, a7, a9], 
     GReg[a1, a2]*GReg[a8, a7]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a2, a3, a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a4, a5, a6, a3]] + CT[GReg[a2, a3, a7, a9], 
     GReg[a1, a2]*GReg[a8, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a2, a3, a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a4, a5, a6, a7]] + CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a2]*GReg[a4, a3]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a9]*GReg[a4, a3]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a2]*GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a9]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a2]*GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a3]] + 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a9]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a4, a5, a3]] + CT[GReg[a2, a3, a8, a9], GReg[a1, a2]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a4, a5, a8]] - CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a9]*GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a8]] - 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a2]*GReg[a4, a3]*GReg[a7, a8]*
      GReg[a5, a6, a8]] + CT[GReg[a2, a3, a8, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a7, a8]*GReg[a5, a6, a8]] + CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a2]*GReg[a4, a8]*GReg[a7, a8]*GReg[a5, a6, a8]] - 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a9]*GReg[a4, a8]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a2, a3, a8, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a5, a8]*GReg[a6, a7, a8]] + CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a2]*GReg[a4, a8]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a3, a8, a9], GReg[a1, a9]*GReg[a4, a8]*
      GReg[a5, a8]*GReg[a6, a7, a8]] + CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a2]*GReg[a4, a5, a3]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a9]*GReg[a4, a5, a3]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a2]*GReg[a4, a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a9]*GReg[a4, a5, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a2, a3, a8, a9], GReg[a1, a2]*GReg[a7, a8]*
      GReg[a4, a5, a6, a3]] - CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a2]*GReg[a7, a8]*
      GReg[a4, a5, a6, a8]] + CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a4, a5, a6, a8]] + 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a2]*GReg[a4, a8]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a2, a3, a8, a9], 
     GReg[a1, a9]*GReg[a4, a8]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a2]*GReg[a4, a5, a6, a7, a3]] + 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a9]*GReg[a4, a5, a6, a7, a3]] + 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a2]*GReg[a4, a5, a6, a7, a8]] - 
    CT[GReg[a2, a3, a8, a9], GReg[a1, a9]*GReg[a4, a5, a6, a7, a8]] - 
    CT[GReg[a2, a4, a5, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a6, a7, a8, a5]] + CT[GReg[a2, a4, a5, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a2, a4, a5, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a2, a4, a5, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a2, a4, a6, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a4, a6, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a5, a4]*GReg[a7, a8, a6]] + CT[GReg[a2, a4, a6, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a4, a6, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a4, a6, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a5, a6]*GReg[a7, a8, a6]] - CT[GReg[a2, a4, a6, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a4, a6, a9], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a4, a6, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a5, a6]*GReg[a7, a8, a6]] + CT[GReg[a2, a4, a7, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a2, a4, a7, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a4]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a2, a4, a7, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a2, a4, a7, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a2, a4, a7, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a2, a4, a7, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a2, a4, a7, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a2, a4, a7, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a2, a4, a7, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a8, a7]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a4, a7, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a8, a7]*
      GReg[a5, a6, a4]] + CT[GReg[a2, a4, a7, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a8, a7]*GReg[a5, a6, a4]] - CT[GReg[a2, a4, a7, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a8, a7]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a4, a7, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a8, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a2, a4, a7, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a8, a7]*GReg[a5, a6, a7]] - CT[GReg[a2, a4, a7, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a8, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a2, a4, a7, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a8, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a7, a8]*
      GReg[a5, a6, a4]] - CT[GReg[a2, a4, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a7, a8]*GReg[a5, a6, a4]] - CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a7, a8]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a7, a8]*
      GReg[a5, a6, a4]] - CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a7, a8]*GReg[a5, a6, a8]] + CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a7, a8]*GReg[a5, a6, a8]] + 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a4]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a2, a4, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a7, a8]*GReg[a5, a6, a8]] + CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a4]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a6, a7, a8]] + CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a2, a4, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a5, a8]*GReg[a6, a7, a8]] + CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a5, a6, a7, a4]] + CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a5, a6, a7, a4]] - CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a5, a6, a7, a8]] - CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a2, a4, a8, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a2, a4, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a2, a5, a6, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a7, a8, a6]] - CT[GReg[a2, a5, a6, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a7, a8, a6]] - CT[GReg[a2, a5, a6, a9], 
     GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a8, a6]] + 
    CT[GReg[a2, a5, a6, a9], GReg[a1, a9]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a8, a6]] - CT[GReg[a2, a5, a6, a9], 
     GReg[a1, a2]*GReg[a3, a4, a2]*GReg[a7, a8, a6]] + 
    CT[GReg[a2, a5, a6, a9], GReg[a1, a9]*GReg[a3, a4, a2]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a5, a6, a9], 
     GReg[a1, a2]*GReg[a3, a4, a5]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a5, a6, a9], GReg[a1, a9]*GReg[a3, a4, a5]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a5, a7, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]] - CT[GReg[a2, a5, a7, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]] - 
    CT[GReg[a2, a5, a7, a9], GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a8, a7]] + CT[GReg[a2, a5, a7, a9], 
     GReg[a1, a9]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]] - 
    CT[GReg[a2, a5, a7, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a2, a5, a7, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a2, a5, a7, a9], GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a2, a5, a7, a9], 
     GReg[a1, a9]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a2, a5, a7, a9], GReg[a1, a2]*GReg[a6, a5]*GReg[a8, a7]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a5, a7, a9], GReg[a1, a9]*GReg[a6, a5]*
      GReg[a8, a7]*GReg[a3, a4, a2]] + CT[GReg[a2, a5, a7, a9], 
     GReg[a1, a2]*GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a5, a7, a9], GReg[a1, a9]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a5, a7, a9], GReg[a1, a2]*GReg[a6, a5]*
      GReg[a8, a7]*GReg[a3, a4, a5]] - CT[GReg[a2, a5, a7, a9], 
     GReg[a1, a9]*GReg[a6, a5]*GReg[a8, a7]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a5, a7, a9], GReg[a1, a2]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a2, a5, a7, a9], GReg[a1, a9]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a3, a4, a5]] - CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]] + 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a7, a8]] + CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]] - 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a7, a8]] + CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a2]*GReg[a6, a5]*GReg[a7, a8]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a6, a5]*GReg[a7, a8]*
      GReg[a3, a4, a2]] - CT[GReg[a2, a5, a8, a9], GReg[a1, a2]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a3, a4, a2]] + CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a9]*GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a2]*GReg[a6, a5]*GReg[a7, a8]*
      GReg[a3, a4, a5]] + CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a6, a5]*
      GReg[a7, a8]*GReg[a3, a4, a5]] + CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a2]*GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a3, a4, a5]] + CT[GReg[a2, a5, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a6, a7, a5]] - CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a5]] + CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a7, a5]] - CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4, a2]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a3, a4, a2]*
      GReg[a6, a7, a5]] + CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a3, a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a2, a5, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a6, a7, a8]] + CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a7, a8]] + 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a7, a8]] + CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4, a2]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a3, a4, a2]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a5, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4, a5]*GReg[a6, a7, a8]] + 
    CT[GReg[a2, a5, a8, a9], GReg[a1, a9]*GReg[a3, a4, a5]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a6, a7, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]] + CT[GReg[a2, a6, a7, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a2, a6, a7, a9], GReg[a1, a2]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a8, a7]] - CT[GReg[a2, a6, a7, a9], 
     GReg[a1, a9]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a2, a6, a7, a9], GReg[a1, a2]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a3, a4, a2]] - CT[GReg[a2, a6, a7, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a8, a7]*GReg[a3, a4, a2]] - CT[GReg[a2, a6, a7, a9], 
     GReg[a1, a2]*GReg[a5, a6]*GReg[a8, a7]*GReg[a3, a4, a6]] + 
    CT[GReg[a2, a6, a7, a9], GReg[a1, a9]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a3, a4, a6]] + CT[GReg[a2, a6, a7, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a8, a7]*GReg[a4, a5, a6]] - CT[GReg[a2, a6, a7, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a8, a7]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a6, a7, a9], GReg[a1, a2]*GReg[a3, a6]*GReg[a8, a7]*
      GReg[a4, a5, a6]] + CT[GReg[a2, a6, a7, a9], GReg[a1, a9]*GReg[a3, a6]*
      GReg[a8, a7]*GReg[a4, a5, a6]] - CT[GReg[a2, a6, a7, a9], 
     GReg[a1, a2]*GReg[a8, a7]*GReg[a3, a4, a5, a2]] + 
    CT[GReg[a2, a6, a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a3, a4, a5, a2]] + CT[GReg[a2, a6, a7, a9], 
     GReg[a1, a2]*GReg[a8, a7]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a2, a6, a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a3, a4, a5, a6]] - CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a9]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]] - 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8]] - CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]] + 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a9]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8]] + CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a2]*GReg[a5, a6]*GReg[a7, a6]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a9]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a3, a4, a2]] - CT[GReg[a2, a6, a8, a9], GReg[a1, a2]*GReg[a5, a6]*
      GReg[a7, a8]*GReg[a3, a4, a2]] + CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a9]*GReg[a5, a6]*GReg[a7, a8]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a2]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a3, a4, a6]] + CT[GReg[a2, a6, a8, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a3, a4, a6]] + CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a2]*GReg[a5, a6]*GReg[a7, a8]*GReg[a3, a4, a6]] - 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a9]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a3, a4, a6]] + CT[GReg[a2, a6, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a7, a6]*GReg[a4, a5, a6]] - CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a7, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a2]*GReg[a3, a6]*GReg[a7, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a2, a6, a8, a9], GReg[a1, a9]*GReg[a3, a6]*
      GReg[a7, a6]*GReg[a4, a5, a6]] - CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a7, a8]*GReg[a4, a5, a6]] + 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a7, a8]*
      GReg[a4, a5, a6]] + CT[GReg[a2, a6, a8, a9], GReg[a1, a2]*GReg[a3, a6]*
      GReg[a7, a8]*GReg[a4, a5, a6]] - CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a9]*GReg[a3, a6]*GReg[a7, a8]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a2]*GReg[a7, a6]*
      GReg[a3, a4, a5, a2]] + CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a6]*GReg[a3, a4, a5, a2]] + 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a2]*GReg[a7, a8]*
      GReg[a3, a4, a5, a2]] - CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a3, a4, a5, a2]] + 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a2]*GReg[a7, a6]*
      GReg[a3, a4, a5, a6]] - CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a6]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a2, a6, a8, a9], GReg[a1, a2]*GReg[a7, a8]*
      GReg[a3, a4, a5, a6]] + CT[GReg[a2, a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a7, a8, a9], GReg[a1, a9]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a3, a4, a2]] + CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a2]*GReg[a5, a7]*GReg[a6, a7]*GReg[a3, a4, a7]] - 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a9]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a3, a4, a7]] - CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a6, a7]*GReg[a4, a5, a7]] + CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a6, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a7]*GReg[a6, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a2, a7, a8, a9], GReg[a1, a9]*GReg[a3, a7]*
      GReg[a6, a7]*GReg[a4, a5, a7]] - CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a7]*
      GReg[a4, a7]*GReg[a5, a6, a7]] - CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a7]*GReg[a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a4, a2]*
      GReg[a5, a6, a7]] - CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4, a2]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a6, a7]*
      GReg[a3, a4, a5, a2]] - CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7]*GReg[a3, a4, a5, a2]] - 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a6, a7]*
      GReg[a3, a4, a5, a7]] + CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7]*GReg[a3, a4, a5, a7]] + 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a5, a6, a7]] - CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a7]*
      GReg[a4, a5, a6, a7]] + CT[GReg[a2, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a7]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a4, a5, a6, a2]] + 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4, a5, a6, a2]] + 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a2]*GReg[a3, a4, a5, a6, a7]] - 
    CT[GReg[a2, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4, a5, a6, a7]] + 
    CT[GReg[a3, a4, a5, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a6, a7, a8, a5]] - CT[GReg[a3, a4, a5, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a3, a4, a5, a9], GReg[a1, a2, a3]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a3, a4, a5, a9], GReg[a1, a2, a9]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a3, a4, a6, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a4]*
      GReg[a7, a8, a6]] - CT[GReg[a3, a4, a6, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a5, a4]*GReg[a7, a8, a6]] - CT[GReg[a3, a4, a6, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a3, a4, a6, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a3, a4, a6, a9], 
     GReg[a5, a4]*GReg[a1, a2, a3]*GReg[a7, a8, a6]] + 
    CT[GReg[a3, a4, a6, a9], GReg[a5, a6]*GReg[a1, a2, a3]*
      GReg[a7, a8, a6]] + CT[GReg[a3, a4, a6, a9], 
     GReg[a5, a4]*GReg[a1, a2, a9]*GReg[a7, a8, a6]] - 
    CT[GReg[a3, a4, a6, a9], GReg[a5, a6]*GReg[a1, a2, a9]*
      GReg[a7, a8, a6]] - CT[GReg[a3, a4, a7, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a3, a4, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a3, a4, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a3, a4, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a3, a4, a7, a9], GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a4, a7, a9], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a1, a2, a3]] - CT[GReg[a3, a4, a7, a9], 
     GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a4, a7, a9], GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a4, a7, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a8, a7]*GReg[a5, a6, a4]] - CT[GReg[a3, a4, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a8, a7]*GReg[a5, a6, a4]] - 
    CT[GReg[a3, a4, a7, a9], GReg[a8, a7]*GReg[a1, a2, a3]*
      GReg[a5, a6, a4]] + CT[GReg[a3, a4, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a5, a6, a4]] - 
    CT[GReg[a3, a4, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a8, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a3, a4, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a8, a7]*GReg[a5, a6, a7]] + CT[GReg[a3, a4, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a3]*GReg[a5, a6, a7]] - 
    CT[GReg[a3, a4, a7, a9], GReg[a8, a7]*GReg[a1, a2, a9]*
      GReg[a5, a6, a7]] + CT[GReg[a3, a4, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a3, a4, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a3, a4, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a8]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a3, a4, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a3, a4, a8, a9], GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a4, a8, a9], GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a1, a2, a3]] + CT[GReg[a3, a4, a8, a9], 
     GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a9]] - 
    CT[GReg[a3, a4, a8, a9], GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a4, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a7, a8]*GReg[a5, a6, a4]] + CT[GReg[a3, a4, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a7, a8]*GReg[a5, a6, a4]] + 
    CT[GReg[a3, a4, a8, a9], GReg[a7, a8]*GReg[a1, a2, a3]*
      GReg[a5, a6, a4]] - CT[GReg[a3, a4, a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a5, a6, a4]] + 
    CT[GReg[a3, a4, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a3, a4, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a7, a8]*GReg[a5, a6, a8]] - CT[GReg[a3, a4, a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a3]*GReg[a5, a6, a8]] + 
    CT[GReg[a3, a4, a8, a9], GReg[a7, a8]*GReg[a1, a2, a9]*
      GReg[a5, a6, a8]] - CT[GReg[a3, a4, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a5, a4]*GReg[a6, a7, a8]] + CT[GReg[a3, a4, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a4]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a4, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a3, a4, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a5, a8]*GReg[a6, a7, a8]] + CT[GReg[a3, a4, a8, a9], 
     GReg[a5, a4]*GReg[a1, a2, a3]*GReg[a6, a7, a8]] - 
    CT[GReg[a3, a4, a8, a9], GReg[a5, a8]*GReg[a1, a2, a3]*
      GReg[a6, a7, a8]] - CT[GReg[a3, a4, a8, a9], 
     GReg[a5, a4]*GReg[a1, a2, a9]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a4, a8, a9], GReg[a5, a8]*GReg[a1, a2, a9]*
      GReg[a6, a7, a8]] + CT[GReg[a3, a4, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a5, a6, a7, a4]] - CT[GReg[a3, a4, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a3, a4, a8, a9], GReg[a1, a2, a3]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a3, a4, a8, a9], GReg[a1, a2, a9]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a3, a4, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a5, a6, a7, a8]] + CT[GReg[a3, a4, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a3, a4, a8, a9], GReg[a1, a2, a3]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a3, a4, a8, a9], GReg[a1, a2, a9]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a3, a5, a6, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a7, a8, a6]] - CT[GReg[a3, a5, a6, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a7, a8, a6]] - CT[GReg[a3, a5, a6, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*GReg[a7, a8, a6]] + 
    CT[GReg[a3, a5, a6, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a7, a8, a6]] - CT[GReg[a3, a5, a6, a9], 
     GReg[a4, a3]*GReg[a1, a2, a3]*GReg[a7, a8, a6]] + 
    CT[GReg[a3, a5, a6, a9], GReg[a4, a5]*GReg[a1, a2, a3]*
      GReg[a7, a8, a6]] + CT[GReg[a3, a5, a6, a9], 
     GReg[a4, a3]*GReg[a1, a2, a9]*GReg[a7, a8, a6]] - 
    CT[GReg[a3, a5, a6, a9], GReg[a4, a5]*GReg[a1, a2, a9]*
      GReg[a7, a8, a6]] + CT[GReg[a3, a5, a7, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a6, a5]*GReg[a8, a7]] - CT[GReg[a3, a5, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a5]*GReg[a8, a7]] - 
    CT[GReg[a3, a5, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a8, a7]] + CT[GReg[a3, a5, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]] - 
    CT[GReg[a3, a5, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a3, a5, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a3, a5, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a3, a5, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a3, a5, a7, a9], GReg[a4, a3]*GReg[a6, a5]*GReg[a8, a7]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a5, a7, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a8, a7]*GReg[a1, a2, a3]] + CT[GReg[a3, a5, a7, a9], 
     GReg[a4, a3]*GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a5, a7, a9], GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a5, a7, a9], GReg[a4, a3]*GReg[a6, a5]*
      GReg[a8, a7]*GReg[a1, a2, a9]] - CT[GReg[a3, a5, a7, a9], 
     GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]*GReg[a1, a2, a9]] - 
    CT[GReg[a3, a5, a7, a9], GReg[a4, a3]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a5, a7, a9], GReg[a4, a5]*GReg[a6, a7]*
      GReg[a8, a7]*GReg[a1, a2, a9]] - CT[GReg[a3, a5, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a5]*GReg[a7, a8]] + 
    CT[GReg[a3, a5, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a5]*GReg[a7, a8]] + CT[GReg[a3, a5, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]] - 
    CT[GReg[a3, a5, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a7, a8]] + CT[GReg[a3, a5, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a3, a5, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a3, a5, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a3, a5, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a3, a5, a8, a9], 
     GReg[a4, a3]*GReg[a6, a5]*GReg[a7, a8]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a5, a8, a9], GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a5, a8, a9], GReg[a4, a3]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a1, a2, a3]] + CT[GReg[a3, a5, a8, a9], 
     GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a5, a8, a9], GReg[a4, a3]*GReg[a6, a5]*GReg[a7, a8]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a5, a8, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a7, a8]*GReg[a1, a2, a9]] + CT[GReg[a3, a5, a8, a9], 
     GReg[a4, a3]*GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a9]] - 
    CT[GReg[a3, a5, a8, a9], GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a5, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a6, a7, a5]] - CT[GReg[a3, a5, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a7, a5]] - 
    CT[GReg[a3, a5, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a7, a5]] + CT[GReg[a3, a5, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a5]*GReg[a6, a7, a5]] - CT[GReg[a3, a5, a8, a9], 
     GReg[a4, a3]*GReg[a1, a2, a3]*GReg[a6, a7, a5]] + 
    CT[GReg[a3, a5, a8, a9], GReg[a4, a5]*GReg[a1, a2, a3]*
      GReg[a6, a7, a5]] + CT[GReg[a3, a5, a8, a9], 
     GReg[a4, a3]*GReg[a1, a2, a9]*GReg[a6, a7, a5]] - 
    CT[GReg[a3, a5, a8, a9], GReg[a4, a5]*GReg[a1, a2, a9]*
      GReg[a6, a7, a5]] - CT[GReg[a3, a5, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a6, a7, a8]] + CT[GReg[a3, a5, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a5, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a7, a8]] - CT[GReg[a3, a5, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a5]*GReg[a6, a7, a8]] + CT[GReg[a3, a5, a8, a9], 
     GReg[a4, a3]*GReg[a1, a2, a3]*GReg[a6, a7, a8]] - 
    CT[GReg[a3, a5, a8, a9], GReg[a4, a5]*GReg[a1, a2, a3]*
      GReg[a6, a7, a8]] - CT[GReg[a3, a5, a8, a9], 
     GReg[a4, a3]*GReg[a1, a2, a9]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a5, a8, a9], GReg[a4, a5]*GReg[a1, a2, a9]*
      GReg[a6, a7, a8]] - CT[GReg[a3, a6, a7, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a6]*GReg[a8, a7]] + CT[GReg[a3, a6, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a3, a6, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a8, a7]] - CT[GReg[a3, a6, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a3, a6, a7, a9], GReg[a4, a3]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a6, a7, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a8, a7]*GReg[a1, a2, a3]] - CT[GReg[a3, a6, a7, a9], 
     GReg[a4, a3]*GReg[a5, a6]*GReg[a8, a7]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a6, a7, a9], GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a6, a7, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a8, a7]*GReg[a4, a5, a3]] - CT[GReg[a3, a6, a7, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a8, a7]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a7, a9], GReg[a8, a7]*GReg[a1, a2, a3]*
      GReg[a4, a5, a3]] + CT[GReg[a3, a6, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a8, a7]*
      GReg[a4, a5, a6]] + CT[GReg[a3, a6, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a8, a7]*GReg[a4, a5, a6]] + CT[GReg[a3, a6, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a3]*GReg[a4, a5, a6]] - 
    CT[GReg[a3, a6, a7, a9], GReg[a8, a7]*GReg[a1, a2, a9]*
      GReg[a4, a5, a6]] - CT[GReg[a3, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a3, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a3, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a6]] - CT[GReg[a3, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a3, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a7, a8]] - CT[GReg[a3, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a8]] - 
    CT[GReg[a3, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8]] + CT[GReg[a3, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]] + 
    CT[GReg[a3, a6, a8, a9], GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a1, a2, a3]] - CT[GReg[a3, a6, a8, a9], 
     GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a8]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a6, a8, a9], GReg[a4, a3]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a1, a2, a9]] + CT[GReg[a3, a6, a8, a9], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a6, a8, a9], GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8]*GReg[a1, a2, a9]] + CT[GReg[a3, a6, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a7, a6]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a7, a6]*
      GReg[a4, a5, a3]] - CT[GReg[a3, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a7, a8]*GReg[a4, a5, a3]] + CT[GReg[a3, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a7, a8]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a8, a9], GReg[a7, a6]*GReg[a1, a2, a3]*
      GReg[a4, a5, a3]] + CT[GReg[a3, a6, a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a3]*GReg[a4, a5, a3]] + 
    CT[GReg[a3, a6, a8, a9], GReg[a7, a6]*GReg[a1, a2, a9]*
      GReg[a4, a5, a3]] - CT[GReg[a3, a6, a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a7, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a3, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a7, a6]*GReg[a4, a5, a6]] + CT[GReg[a3, a6, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a7, a8]*GReg[a4, a5, a6]] - 
    CT[GReg[a3, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a7, a8]*
      GReg[a4, a5, a6]] + CT[GReg[a3, a6, a8, a9], 
     GReg[a7, a6]*GReg[a1, a2, a3]*GReg[a4, a5, a6]] - 
    CT[GReg[a3, a6, a8, a9], GReg[a7, a8]*GReg[a1, a2, a3]*
      GReg[a4, a5, a6]] - CT[GReg[a3, a6, a8, a9], 
     GReg[a7, a6]*GReg[a1, a2, a9]*GReg[a4, a5, a6]] + 
    CT[GReg[a3, a6, a8, a9], GReg[a7, a8]*GReg[a1, a2, a9]*
      GReg[a4, a5, a6]] + CT[GReg[a3, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a3, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a3, a7, a8, a9], GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a7, a8, a9], GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a1, a2, a3]] + CT[GReg[a3, a7, a8, a9], 
     GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a9]] - 
    CT[GReg[a3, a7, a8, a9], GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a6, a7]*GReg[a4, a5, a3]] + CT[GReg[a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a6, a7]*GReg[a4, a5, a3]] + 
    CT[GReg[a3, a7, a8, a9], GReg[a6, a7]*GReg[a1, a2, a3]*
      GReg[a4, a5, a3]] - CT[GReg[a3, a7, a8, a9], 
     GReg[a6, a7]*GReg[a1, a2, a9]*GReg[a4, a5, a3]] + 
    CT[GReg[a3, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a3, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a6, a7]*GReg[a4, a5, a7]] - CT[GReg[a3, a7, a8, a9], 
     GReg[a6, a7]*GReg[a1, a2, a3]*GReg[a4, a5, a7]] + 
    CT[GReg[a3, a7, a8, a9], GReg[a6, a7]*GReg[a1, a2, a9]*
      GReg[a4, a5, a7]] - CT[GReg[a3, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a6, a7]] + CT[GReg[a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6, a7]] + 
    CT[GReg[a3, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a3, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a7]*GReg[a5, a6, a7]] + CT[GReg[a3, a7, a8, a9], 
     GReg[a4, a3]*GReg[a1, a2, a3]*GReg[a5, a6, a7]] - 
    CT[GReg[a3, a7, a8, a9], GReg[a4, a7]*GReg[a1, a2, a3]*
      GReg[a5, a6, a7]] - CT[GReg[a3, a7, a8, a9], 
     GReg[a4, a3]*GReg[a1, a2, a9]*GReg[a5, a6, a7]] + 
    CT[GReg[a3, a7, a8, a9], GReg[a4, a7]*GReg[a1, a2, a9]*
      GReg[a5, a6, a7]] + CT[GReg[a3, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a5, a6, a3]] - CT[GReg[a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a3, a7, a8, a9], GReg[a1, a2, a3]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a3, a7, a8, a9], GReg[a1, a2, a9]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a3, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a5, a6, a7]] + CT[GReg[a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a3, a7, a8, a9], GReg[a1, a2, a3]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a3, a7, a8, a9], GReg[a1, a2, a9]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a4, a5, a6, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a7, a8, a6]] + CT[GReg[a4, a5, a6, a9], GReg[a1, a9]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a7, a8, a6]] + CT[GReg[a4, a5, a6, a9], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a7, a8, a6]] - 
    CT[GReg[a4, a5, a6, a9], GReg[a3, a4]*GReg[a1, a2, a9]*
      GReg[a7, a8, a6]] + CT[GReg[a4, a5, a6, a9], 
     GReg[a1, a4]*GReg[a2, a3, a4]*GReg[a7, a8, a6]] - 
    CT[GReg[a4, a5, a6, a9], GReg[a1, a9]*GReg[a2, a3, a4]*
      GReg[a7, a8, a6]] - CT[GReg[a4, a5, a6, a9], 
     GReg[a7, a8, a6]*GReg[a1, a2, a3, a4]] + CT[GReg[a4, a5, a6, a9], 
     GReg[a7, a8, a6]*GReg[a1, a2, a3, a9]] - CT[GReg[a4, a5, a7, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a5]*GReg[a8, a7]] + 
    CT[GReg[a4, a5, a7, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a5]*GReg[a8, a7]] + CT[GReg[a4, a5, a7, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a4, a5, a7, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a4, a5, a7, a9], 
     GReg[a3, a4]*GReg[a6, a5]*GReg[a8, a7]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a5, a7, a9], GReg[a3, a4]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a5, a7, a9], GReg[a3, a4]*GReg[a6, a5]*
      GReg[a8, a7]*GReg[a1, a2, a9]] + CT[GReg[a4, a5, a7, a9], 
     GReg[a3, a4]*GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a9]] + 
    CT[GReg[a4, a5, a7, a9], GReg[a1, a4]*GReg[a6, a5]*GReg[a8, a7]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a5, a7, a9], GReg[a1, a9]*GReg[a6, a5]*
      GReg[a8, a7]*GReg[a2, a3, a4]] - CT[GReg[a4, a5, a7, a9], 
     GReg[a1, a4]*GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a4]] + 
    CT[GReg[a4, a5, a7, a9], GReg[a1, a9]*GReg[a6, a7]*GReg[a8, a7]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a1, a2, a3, a4]] + CT[GReg[a4, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a1, a2, a3, a9]] - CT[GReg[a4, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a4, a5, a8, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a5]*GReg[a7, a8]] - CT[GReg[a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a5]*GReg[a7, a8]] - 
    CT[GReg[a4, a5, a8, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a4, a5, a8, a9], GReg[a3, a4]*GReg[a6, a5]*GReg[a7, a8]*
      GReg[a1, a2, a4]] + CT[GReg[a4, a5, a8, a9], GReg[a3, a4]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a1, a2, a4]] + CT[GReg[a4, a5, a8, a9], 
     GReg[a3, a4]*GReg[a6, a5]*GReg[a7, a8]*GReg[a1, a2, a9]] - 
    CT[GReg[a4, a5, a8, a9], GReg[a3, a4]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a1, a2, a9]] - CT[GReg[a4, a5, a8, a9], GReg[a1, a4]*GReg[a6, a5]*
      GReg[a7, a8]*GReg[a2, a3, a4]] + CT[GReg[a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a6, a5]*GReg[a7, a8]*GReg[a2, a3, a4]] + 
    CT[GReg[a4, a5, a8, a9], GReg[a1, a4]*GReg[a6, a8]*GReg[a7, a8]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a5, a8, a9], GReg[a1, a9]*GReg[a6, a8]*
      GReg[a7, a8]*GReg[a2, a3, a4]] - CT[GReg[a4, a5, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7, a5]] + 
    CT[GReg[a4, a5, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a7, a5]] + CT[GReg[a4, a5, a8, a9], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a6, a7, a5]] - 
    CT[GReg[a4, a5, a8, a9], GReg[a3, a4]*GReg[a1, a2, a9]*
      GReg[a6, a7, a5]] + CT[GReg[a4, a5, a8, a9], 
     GReg[a1, a4]*GReg[a2, a3, a4]*GReg[a6, a7, a5]] - 
    CT[GReg[a4, a5, a8, a9], GReg[a1, a9]*GReg[a2, a3, a4]*
      GReg[a6, a7, a5]] + CT[GReg[a4, a5, a8, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a6, a7, a8]] - CT[GReg[a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a4, a5, a8, a9], GReg[a3, a4]*GReg[a1, a2, a4]*
      GReg[a6, a7, a8]] + CT[GReg[a4, a5, a8, a9], 
     GReg[a3, a4]*GReg[a1, a2, a9]*GReg[a6, a7, a8]] - 
    CT[GReg[a4, a5, a8, a9], GReg[a1, a4]*GReg[a2, a3, a4]*
      GReg[a6, a7, a8]] + CT[GReg[a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3, a4]*GReg[a6, a7, a8]] + 
    CT[GReg[a4, a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a1, a2, a3, a4]] - CT[GReg[a4, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3, a4]] - 
    CT[GReg[a4, a5, a8, a9], GReg[a6, a7, a5]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a8, a9], GReg[a6, a7, a8]*GReg[a1, a2, a3, a4]] - 
    CT[GReg[a4, a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a4, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a4, a5, a8, a9], GReg[a6, a7, a5]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a5, a8, a9], GReg[a6, a7, a8]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a6, a7, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a8, a7]] + CT[GReg[a4, a6, a7, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a8, a7]] + 
    CT[GReg[a4, a6, a7, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6]*GReg[a8, a7]] - CT[GReg[a4, a6, a7, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a4, a6, a7, a9], GReg[a3, a4]*GReg[a5, a4]*GReg[a8, a7]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a6, a7, a9], GReg[a3, a4]*GReg[a5, a6]*
      GReg[a8, a7]*GReg[a1, a2, a4]] - CT[GReg[a4, a6, a7, a9], 
     GReg[a3, a4]*GReg[a5, a4]*GReg[a8, a7]*GReg[a1, a2, a9]] + 
    CT[GReg[a4, a6, a7, a9], GReg[a3, a4]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a1, a2, a9]] + CT[GReg[a4, a6, a7, a9], GReg[a1, a4]*GReg[a5, a4]*
      GReg[a8, a7]*GReg[a2, a3, a4]] - CT[GReg[a4, a6, a7, a9], 
     GReg[a1, a9]*GReg[a5, a4]*GReg[a8, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6, a7, a9], GReg[a1, a4]*GReg[a5, a6]*GReg[a8, a7]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a6, a7, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a8, a7]*GReg[a2, a3, a4]] - CT[GReg[a4, a6, a7, a9], 
     GReg[a5, a4]*GReg[a8, a7]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6, a7, a9], GReg[a5, a6]*GReg[a8, a7]*
      GReg[a1, a2, a3, a4]] + CT[GReg[a4, a6, a7, a9], 
     GReg[a5, a4]*GReg[a8, a7]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a6, a7, a9], GReg[a5, a6]*GReg[a8, a7]*
      GReg[a1, a2, a3, a9]] - CT[GReg[a4, a6, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a6]] + 
    CT[GReg[a4, a6, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a7, a6]] + CT[GReg[a4, a6, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a4, a6, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a4, a6, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a8]] - 
    CT[GReg[a4, a6, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a7, a8]] - CT[GReg[a4, a6, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a8]] + 
    CT[GReg[a4, a6, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6]*GReg[a7, a8]] + CT[GReg[a4, a6, a8, a9], 
     GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a6]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a6, a8, a9], GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a6, a8, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a8]*GReg[a1, a2, a4]] + CT[GReg[a4, a6, a8, a9], 
     GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a8]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a6, a8, a9], GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a6]*
      GReg[a1, a2, a9]] + CT[GReg[a4, a6, a8, a9], GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a1, a2, a9]] + CT[GReg[a4, a6, a8, a9], 
     GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a8]*GReg[a1, a2, a9]] - 
    CT[GReg[a4, a6, a8, a9], GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a8]*
      GReg[a1, a2, a9]] + CT[GReg[a4, a6, a8, a9], GReg[a1, a4]*GReg[a5, a4]*
      GReg[a7, a6]*GReg[a2, a3, a4]] - CT[GReg[a4, a6, a8, a9], 
     GReg[a1, a9]*GReg[a5, a4]*GReg[a7, a6]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6, a8, a9], GReg[a1, a4]*GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a6, a8, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a7, a6]*GReg[a2, a3, a4]] - CT[GReg[a4, a6, a8, a9], 
     GReg[a1, a4]*GReg[a5, a4]*GReg[a7, a8]*GReg[a2, a3, a4]] + 
    CT[GReg[a4, a6, a8, a9], GReg[a1, a9]*GReg[a5, a4]*GReg[a7, a8]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a6, a8, a9], GReg[a1, a4]*GReg[a5, a6]*
      GReg[a7, a8]*GReg[a2, a3, a4]] - CT[GReg[a4, a6, a8, a9], 
     GReg[a1, a9]*GReg[a5, a6]*GReg[a7, a8]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6, a8, a9], GReg[a5, a4]*GReg[a7, a6]*
      GReg[a1, a2, a3, a4]] + CT[GReg[a4, a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6, a8, a9], GReg[a5, a4]*GReg[a7, a8]*
      GReg[a1, a2, a3, a4]] - CT[GReg[a4, a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a8]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6, a8, a9], GReg[a5, a4]*GReg[a7, a6]*
      GReg[a1, a2, a3, a9]] - CT[GReg[a4, a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a6]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a6, a8, a9], GReg[a5, a4]*GReg[a7, a8]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a4, a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a8]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a4, a7, a8, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a6, a7]] - CT[GReg[a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]] - 
    CT[GReg[a4, a7, a8, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a4, a7, a8, a9], GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]*
      GReg[a1, a2, a4]] + CT[GReg[a4, a7, a8, a9], GReg[a3, a4]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a1, a2, a4]] + CT[GReg[a4, a7, a8, a9], 
     GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]*GReg[a1, a2, a9]] - 
    CT[GReg[a4, a7, a8, a9], GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a4, a7, a8, a9], GReg[a1, a4]*GReg[a5, a4]*
      GReg[a6, a7]*GReg[a2, a3, a4]] + CT[GReg[a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a4]*GReg[a6, a7]*GReg[a2, a3, a4]] + 
    CT[GReg[a4, a7, a8, a9], GReg[a1, a4]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a7, a8, a9], GReg[a1, a9]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a2, a3, a4]] - CT[GReg[a4, a7, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a4, a7, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6, a4]] + CT[GReg[a4, a7, a8, a9], 
     GReg[a3, a4]*GReg[a1, a2, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a4, a7, a8, a9], GReg[a3, a4]*GReg[a1, a2, a9]*
      GReg[a5, a6, a4]] + CT[GReg[a4, a7, a8, a9], 
     GReg[a1, a4]*GReg[a2, a3, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a4, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3, a4]*
      GReg[a5, a6, a4]] + CT[GReg[a4, a7, a8, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a6, a7]] - CT[GReg[a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a7]] - 
    CT[GReg[a4, a7, a8, a9], GReg[a3, a4]*GReg[a1, a2, a4]*
      GReg[a5, a6, a7]] + CT[GReg[a4, a7, a8, a9], 
     GReg[a3, a4]*GReg[a1, a2, a9]*GReg[a5, a6, a7]] - 
    CT[GReg[a4, a7, a8, a9], GReg[a1, a4]*GReg[a2, a3, a4]*
      GReg[a5, a6, a7]] + CT[GReg[a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3, a4]*GReg[a5, a6, a7]] + 
    CT[GReg[a4, a7, a8, a9], GReg[a5, a4]*GReg[a6, a7]*
      GReg[a1, a2, a3, a4]] - CT[GReg[a4, a7, a8, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a3, a4]] - 
    CT[GReg[a4, a7, a8, a9], GReg[a5, a6, a4]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a7, a8, a9], GReg[a5, a6, a7]*GReg[a1, a2, a3, a4]] - 
    CT[GReg[a4, a7, a8, a9], GReg[a5, a4]*GReg[a6, a7]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a4, a7, a8, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a4, a7, a8, a9], GReg[a5, a6, a4]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a7, a8, a9], GReg[a5, a6, a7]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a5, a6, a7, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a8, a7]] - CT[GReg[a5, a6, a7, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a8, a7]] - 
    CT[GReg[a5, a6, a7, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a8, a7]*
      GReg[a1, a2, a5]] + CT[GReg[a5, a6, a7, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a8, a7]*GReg[a1, a2, a9]] - CT[GReg[a5, a6, a7, a9], 
     GReg[a1, a5]*GReg[a4, a5]*GReg[a8, a7]*GReg[a2, a3, a5]] + 
    CT[GReg[a5, a6, a7, a9], GReg[a1, a9]*GReg[a4, a5]*GReg[a8, a7]*
      GReg[a2, a3, a5]] - CT[GReg[a5, a6, a7, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a8, a7]*GReg[a3, a4, a5]] + CT[GReg[a5, a6, a7, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a8, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6, a7, a9], GReg[a8, a7]*GReg[a1, a2, a5]*
      GReg[a3, a4, a5]] - CT[GReg[a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a9]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6, a7, a9], GReg[a4, a5]*GReg[a8, a7]*
      GReg[a1, a2, a3, a5]] - CT[GReg[a5, a6, a7, a9], 
     GReg[a4, a5]*GReg[a8, a7]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a5, a6, a7, a9], GReg[a1, a5]*GReg[a8, a7]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a5, a6, a7, a9], 
     GReg[a1, a9]*GReg[a8, a7]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a6, a7, a9], GReg[a8, a7]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a6, a7, a9], GReg[a8, a7]*GReg[a1, a2, a3, a4, a9]] + 
    CT[GReg[a5, a6, a8, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a7, a6]] - CT[GReg[a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a6]] - 
    CT[GReg[a5, a6, a8, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a7, a8]] + CT[GReg[a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a8]] - 
    CT[GReg[a5, a6, a8, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a6]*
      GReg[a1, a2, a5]] + CT[GReg[a5, a6, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a8]*GReg[a1, a2, a5]] + CT[GReg[a5, a6, a8, a9], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a6]*GReg[a1, a2, a9]] - 
    CT[GReg[a5, a6, a8, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a8]*
      GReg[a1, a2, a9]] - CT[GReg[a5, a6, a8, a9], GReg[a1, a5]*GReg[a4, a5]*
      GReg[a7, a6]*GReg[a2, a3, a5]] + CT[GReg[a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a4, a5]*GReg[a7, a6]*GReg[a2, a3, a5]] + 
    CT[GReg[a5, a6, a8, a9], GReg[a1, a5]*GReg[a4, a5]*GReg[a7, a8]*
      GReg[a2, a3, a5]] - CT[GReg[a5, a6, a8, a9], GReg[a1, a9]*GReg[a4, a5]*
      GReg[a7, a8]*GReg[a2, a3, a5]] - CT[GReg[a5, a6, a8, a9], 
     GReg[a1, a5]*GReg[a2, a5]*GReg[a7, a6]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6, a8, a9], GReg[a1, a9]*GReg[a2, a5]*GReg[a7, a6]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a6, a8, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a7, a8]*GReg[a3, a4, a5]] - CT[GReg[a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a7, a8]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6, a8, a9], GReg[a7, a6]*GReg[a1, a2, a5]*
      GReg[a3, a4, a5]] - CT[GReg[a5, a6, a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a5]*GReg[a3, a4, a5]] - 
    CT[GReg[a5, a6, a8, a9], GReg[a7, a6]*GReg[a1, a2, a9]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a6, a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a9]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6, a8, a9], GReg[a4, a5]*GReg[a7, a6]*
      GReg[a1, a2, a3, a5]] - CT[GReg[a5, a6, a8, a9], 
     GReg[a4, a5]*GReg[a7, a8]*GReg[a1, a2, a3, a5]] - 
    CT[GReg[a5, a6, a8, a9], GReg[a4, a5]*GReg[a7, a6]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a5, a6, a8, a9], 
     GReg[a4, a5]*GReg[a7, a8]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a5, a6, a8, a9], GReg[a1, a5]*GReg[a7, a6]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a6]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a6, a8, a9], GReg[a1, a5]*GReg[a7, a8]*
      GReg[a2, a3, a4, a5]] + CT[GReg[a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a6, a8, a9], GReg[a7, a6]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a6, a8, a9], GReg[a7, a8]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a6, a8, a9], GReg[a7, a6]*GReg[a1, a2, a3, a4, a9]] - 
    CT[GReg[a5, a6, a8, a9], GReg[a7, a8]*GReg[a1, a2, a3, a4, a9]] + 
    CT[GReg[a5, a7, a8, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a5]] - CT[GReg[a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a5, a7, a8, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a7]] + CT[GReg[a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]] - 
    CT[GReg[a5, a7, a8, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*
      GReg[a1, a2, a5]] + CT[GReg[a5, a7, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a1, a2, a5]] + CT[GReg[a5, a7, a8, a9], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]*GReg[a1, a2, a9]] - 
    CT[GReg[a5, a7, a8, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a5, a7, a8, a9], GReg[a1, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a2, a3, a5]] + CT[GReg[a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a5]*GReg[a2, a3, a5]] + 
    CT[GReg[a5, a7, a8, a9], GReg[a1, a5]*GReg[a4, a5]*GReg[a6, a7]*
      GReg[a2, a3, a5]] - CT[GReg[a5, a7, a8, a9], GReg[a1, a9]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a2, a3, a5]] - CT[GReg[a5, a7, a8, a9], 
     GReg[a1, a5]*GReg[a2, a5]*GReg[a6, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a7, a8, a9], GReg[a1, a9]*GReg[a2, a5]*GReg[a6, a5]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a7, a8, a9], GReg[a1, a5]*GReg[a2, a5]*
      GReg[a6, a7]*GReg[a3, a4, a5]] - CT[GReg[a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a5]*GReg[a6, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a7, a8, a9], GReg[a6, a5]*GReg[a1, a2, a5]*
      GReg[a3, a4, a5]] - CT[GReg[a5, a7, a8, a9], 
     GReg[a6, a7]*GReg[a1, a2, a5]*GReg[a3, a4, a5]] - 
    CT[GReg[a5, a7, a8, a9], GReg[a6, a5]*GReg[a1, a2, a9]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a7, a8, a9], 
     GReg[a6, a7]*GReg[a1, a2, a9]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a7, a8, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a1, a2, a3, a5]] - CT[GReg[a5, a7, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7]*GReg[a1, a2, a3, a5]] - 
    CT[GReg[a5, a7, a8, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a1, a2, a3, a9]] + CT[GReg[a5, a7, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a5, a7, a8, a9], GReg[a1, a5]*GReg[a6, a5]*
      GReg[a2, a3, a4, a5]] - CT[GReg[a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a5]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a7, a8, a9], GReg[a1, a5]*GReg[a6, a7]*
      GReg[a2, a3, a4, a5]] + CT[GReg[a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a5, a7, a8, a9], GReg[a6, a5]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a7, a8, a9], GReg[a6, a7]*GReg[a1, a2, a3, a4, a5]] + 
    CT[GReg[a5, a7, a8, a9], GReg[a6, a5]*GReg[a1, a2, a3, a4, a9]] - 
    CT[GReg[a5, a7, a8, a9], GReg[a6, a7]*GReg[a1, a2, a3, a4, a9]] - 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*
      GReg[a4, a6]*GReg[a5, a6]] + CT[GReg[a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a6]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a6, a7, a8, a9], GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a1, a2, a6]] - CT[GReg[a6, a7, a8, a9], GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a1, a2, a9]] + CT[GReg[a6, a7, a8, a9], 
     GReg[a1, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a2, a3, a6]] - 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a9]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a2, a3, a6]] + CT[GReg[a6, a7, a8, a9], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a5, a6]*GReg[a3, a4, a6]] - CT[GReg[a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a6]*GReg[a5, a6]*GReg[a3, a4, a6]] - 
    CT[GReg[a6, a7, a8, a9], GReg[a5, a6]*GReg[a1, a2, a6]*
      GReg[a3, a4, a6]] + CT[GReg[a6, a7, a8, a9], 
     GReg[a5, a6]*GReg[a1, a2, a9]*GReg[a3, a4, a6]] + 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a6]*GReg[a2, a6]*GReg[a3, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a6]*
      GReg[a3, a6]*GReg[a4, a5, a6]] - CT[GReg[a6, a7, a8, a9], 
     GReg[a3, a6]*GReg[a1, a2, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a6, a7, a8, a9], GReg[a3, a6]*GReg[a1, a2, a9]*
      GReg[a4, a5, a6]] - CT[GReg[a6, a7, a8, a9], 
     GReg[a1, a6]*GReg[a2, a3, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a6, a7, a8, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a1, a2, a3, a6]] + CT[GReg[a6, a7, a8, a9], 
     GReg[a4, a5, a6]*GReg[a1, a2, a3, a6]] + CT[GReg[a6, a7, a8, a9], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a6, a7, a8, a9], GReg[a4, a5, a6]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a6]*GReg[a5, a6]*
      GReg[a2, a3, a4, a6]] + CT[GReg[a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a6]*GReg[a2, a3, a4, a6]] - 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a6]*GReg[a2, a6]*
      GReg[a3, a4, a5, a6]] + CT[GReg[a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a2, a6]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a2, a9]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a6, a7, a8, a9], GReg[a5, a6]*GReg[a1, a2, a3, a4, a6]] - 
    CT[GReg[a6, a7, a8, a9], GReg[a5, a6]*GReg[a1, a2, a3, a4, a9]] + 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a6]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3, a4, a5, a6]] - 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a2, a3, a4, a5, a6]] + 
    CT[GReg[a6, a7, a8, a9], GReg[a1, a2, a3, a4, a5, a9]] + 
    CT[GReg[a1, a2, a3, a4, a9], GReg[a5, a6, a7, a8, a4]] + 
    CT[GReg[a1, a2, a3, a5, a9], GReg[a4, a3]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a1, a2, a3, a5, a9], GReg[a4, a5]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a1, a2, a3, a6, a9], GReg[a4, a3]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a2, a3, a6, a9], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a2, a3, a6, a9], GReg[a4, a5, a3]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a2, a3, a6, a9], GReg[a4, a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a2, a3, a7, a9], GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]] - CT[GReg[a1, a2, a3, a7, a9], GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a1, a2, a3, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a4, a5, a3]] + 
    CT[GReg[a1, a2, a3, a7, a9], GReg[a6, a7]*GReg[a8, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a1, a2, a3, a7, a9], 
     GReg[a4, a3]*GReg[a8, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a2, a3, a7, a9], GReg[a4, a7]*GReg[a8, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a1, a2, a3, a7, a9], 
     GReg[a8, a7]*GReg[a4, a5, a6, a3]] - CT[GReg[a1, a2, a3, a7, a9], 
     GReg[a8, a7]*GReg[a4, a5, a6, a7]] - CT[GReg[a1, a2, a3, a8, a9], 
     GReg[a4, a3]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a1, a2, a3, a8, a9], GReg[a6, a8]*GReg[a7, a8]*
      GReg[a4, a5, a3]] - CT[GReg[a1, a2, a3, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a4, a5, a8]] + 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a4, a3]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a1, a2, a3, a8, a9], 
     GReg[a4, a8]*GReg[a7, a8]*GReg[a5, a6, a8]] + 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a4, a3]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a2, a3, a8, a9], 
     GReg[a4, a8]*GReg[a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a4, a5, a3]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a4, a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a7, a8]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a7, a8]*GReg[a4, a5, a6, a8]] - 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a4, a3]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a4, a8]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a4, a5, a6, a7, a3]] - 
    CT[GReg[a1, a2, a3, a8, a9], GReg[a4, a5, a6, a7, a8]] + 
    CT[GReg[a1, a2, a4, a5, a9], GReg[a3, a2]*GReg[a6, a7, a8, a5]] - 
    CT[GReg[a1, a2, a4, a5, a9], GReg[a3, a4]*GReg[a6, a7, a8, a5]] + 
    CT[GReg[a1, a2, a4, a6, a9], GReg[a3, a2]*GReg[a5, a4]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a2, a4, a6, a9], 
     GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a2, a4, a6, a9], GReg[a3, a2]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a2, a4, a6, a9], 
     GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a2, a4, a7, a9], GReg[a3, a2]*GReg[a5, a4]*GReg[a6, a7]*
      GReg[a8, a7]] + CT[GReg[a1, a2, a4, a7, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a1, a2, a4, a7, a9], 
     GReg[a3, a2]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a1, a2, a4, a7, a9], GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]] + CT[GReg[a1, a2, a4, a7, a9], GReg[a3, a2]*GReg[a8, a7]*
      GReg[a5, a6, a4]] - CT[GReg[a1, a2, a4, a7, a9], 
     GReg[a3, a4]*GReg[a8, a7]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a2, a4, a7, a9], GReg[a3, a2]*GReg[a8, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a1, a2, a4, a7, a9], 
     GReg[a3, a4]*GReg[a8, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a2]*GReg[a5, a4]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a1, a2, a4, a8, a9], 
     GReg[a3, a2]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a4]*GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a2]*GReg[a7, a8]*
      GReg[a5, a6, a4]] + CT[GReg[a1, a2, a4, a8, a9], 
     GReg[a3, a4]*GReg[a7, a8]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a2]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a1, a2, a4, a8, a9], 
     GReg[a3, a4]*GReg[a7, a8]*GReg[a5, a6, a8]] - 
    CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a2]*GReg[a5, a4]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a2, a4, a8, a9], 
     GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a2]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a2, a4, a8, a9], 
     GReg[a3, a4]*GReg[a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a2]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a4]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a2]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a2, a4, a8, a9], GReg[a3, a4]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a1, a2, a5, a6, a9], GReg[a3, a2]*GReg[a4, a5]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a2, a5, a6, a9], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a2, a5, a6, a9], GReg[a3, a4, a2]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a2, a5, a6, a9], GReg[a3, a4, a5]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a2, a5, a7, a9], GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a5]*
      GReg[a8, a7]] + CT[GReg[a1, a2, a5, a7, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a8, a7]] + CT[GReg[a1, a2, a5, a7, a9], 
     GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a1, a2, a5, a7, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]*
      GReg[a8, a7]] + CT[GReg[a1, a2, a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a3, a4, a2]] - CT[GReg[a1, a2, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a2]] - 
    CT[GReg[a1, a2, a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a1, a2, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a2, a5, a8, a9], GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a5]*
      GReg[a7, a8]] - CT[GReg[a1, a2, a5, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a7, a8]] - CT[GReg[a1, a2, a5, a8, a9], 
     GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a1, a2, a5, a8, a9], GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a1, a2, a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a3, a4, a2]] + CT[GReg[a1, a2, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a2]] + 
    CT[GReg[a1, a2, a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a3, a4, a5]] - CT[GReg[a1, a2, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a3, a4, a5]] - 
    CT[GReg[a1, a2, a5, a8, a9], GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a7, a5]] + CT[GReg[a1, a2, a5, a8, a9], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a2, a5, a8, a9], GReg[a3, a4, a2]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a2, a5, a8, a9], GReg[a3, a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a2, a5, a8, a9], GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a2, a5, a8, a9], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a2, a5, a8, a9], GReg[a3, a4, a2]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a2, a5, a8, a9], GReg[a3, a4, a5]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a2, a6, a7, a9], GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a8, a7]] - CT[GReg[a1, a2, a6, a7, a9], GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a8, a7]] - CT[GReg[a1, a2, a6, a7, a9], 
     GReg[a5, a6]*GReg[a8, a7]*GReg[a3, a4, a2]] + 
    CT[GReg[a1, a2, a6, a7, a9], GReg[a5, a6]*GReg[a8, a7]*
      GReg[a3, a4, a6]] - CT[GReg[a1, a2, a6, a7, a9], 
     GReg[a3, a2]*GReg[a8, a7]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a2, a6, a7, a9], GReg[a3, a6]*GReg[a8, a7]*
      GReg[a4, a5, a6]] + CT[GReg[a1, a2, a6, a7, a9], 
     GReg[a8, a7]*GReg[a3, a4, a5, a2]] - CT[GReg[a1, a2, a6, a7, a9], 
     GReg[a8, a7]*GReg[a3, a4, a5, a6]] + CT[GReg[a1, a2, a6, a8, a9], 
     GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a1, a2, a6, a8, a9], GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a1, a2, a6, a8, a9], GReg[a3, a2]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8]] + CT[GReg[a1, a2, a6, a8, a9], 
     GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a8]] - 
    CT[GReg[a1, a2, a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a3, a4, a2]] + CT[GReg[a1, a2, a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a8]*GReg[a3, a4, a2]] + 
    CT[GReg[a1, a2, a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a3, a4, a6]] - CT[GReg[a1, a2, a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a8]*GReg[a3, a4, a6]] - 
    CT[GReg[a1, a2, a6, a8, a9], GReg[a3, a2]*GReg[a7, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a1, a2, a6, a8, a9], 
     GReg[a3, a6]*GReg[a7, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a2, a6, a8, a9], GReg[a3, a2]*GReg[a7, a8]*
      GReg[a4, a5, a6]] - CT[GReg[a1, a2, a6, a8, a9], 
     GReg[a3, a6]*GReg[a7, a8]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a2, a6, a8, a9], GReg[a7, a6]*GReg[a3, a4, a5, a2]] - 
    CT[GReg[a1, a2, a6, a8, a9], GReg[a7, a8]*GReg[a3, a4, a5, a2]] - 
    CT[GReg[a1, a2, a6, a8, a9], GReg[a7, a6]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a1, a2, a6, a8, a9], GReg[a7, a8]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a1, a2, a7, a8, a9], GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]] + CT[GReg[a1, a2, a7, a8, a9], GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a3, a4, a2]] - 
    CT[GReg[a1, a2, a7, a8, a9], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a3, a4, a7]] + CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a3, a2]*GReg[a6, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a2, a7, a8, a9], GReg[a3, a7]*GReg[a6, a7]*
      GReg[a4, a5, a7]] + CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a3, a2]*GReg[a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a2, a7, a8, a9], GReg[a3, a7]*GReg[a4, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a3, a4, a2]*GReg[a5, a6, a7]] + CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a3, a4, a7]*GReg[a5, a6, a7]] - CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a6, a7]*GReg[a3, a4, a5, a2]] + CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a6, a7]*GReg[a3, a4, a5, a7]] - CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a3, a2]*GReg[a4, a5, a6, a7]] + CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a3, a7]*GReg[a4, a5, a6, a7]] + CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a3, a4, a5, a6, a2]] - CT[GReg[a1, a2, a7, a8, a9], 
     GReg[a3, a4, a5, a6, a7]] + CT[GReg[a1, a3, a4, a5, a9], 
     GReg[a2, a1]*GReg[a6, a7, a8, a5]] - CT[GReg[a1, a3, a4, a5, a9], 
     GReg[a2, a3]*GReg[a6, a7, a8, a5]] + CT[GReg[a1, a3, a4, a6, a9], 
     GReg[a2, a1]*GReg[a5, a4]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a3, a4, a6, a9], GReg[a2, a3]*GReg[a5, a4]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a3, a4, a6, a9], 
     GReg[a2, a1]*GReg[a5, a6]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a3, a4, a6, a9], GReg[a2, a3]*GReg[a5, a6]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a3, a4, a7, a9], 
     GReg[a2, a1]*GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a1, a3, a4, a7, a9], GReg[a2, a3]*GReg[a5, a4]*GReg[a6, a7]*
      GReg[a8, a7]] + CT[GReg[a1, a3, a4, a7, a9], GReg[a2, a1]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a1, a3, a4, a7, a9], 
     GReg[a2, a3]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a1, a3, a4, a7, a9], GReg[a2, a1]*GReg[a8, a7]*
      GReg[a5, a6, a4]] - CT[GReg[a1, a3, a4, a7, a9], 
     GReg[a2, a3]*GReg[a8, a7]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a3, a4, a7, a9], GReg[a2, a1]*GReg[a8, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a1, a3, a4, a7, a9], 
     GReg[a2, a3]*GReg[a8, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a1]*GReg[a5, a4]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a3]*GReg[a5, a4]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a1, a3, a4, a8, a9], 
     GReg[a2, a1]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a3]*GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a1]*GReg[a7, a8]*
      GReg[a5, a6, a4]] + CT[GReg[a1, a3, a4, a8, a9], 
     GReg[a2, a3]*GReg[a7, a8]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a1]*GReg[a7, a8]*
      GReg[a5, a6, a8]] - CT[GReg[a1, a3, a4, a8, a9], 
     GReg[a2, a3]*GReg[a7, a8]*GReg[a5, a6, a8]] - 
    CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a1]*GReg[a5, a4]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a3, a4, a8, a9], 
     GReg[a2, a3]*GReg[a5, a4]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a1]*GReg[a5, a8]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a3, a4, a8, a9], 
     GReg[a2, a3]*GReg[a5, a8]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a1]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a3]*GReg[a5, a6, a7, a4]] - 
    CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a1]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a3, a4, a8, a9], GReg[a2, a3]*GReg[a5, a6, a7, a8]] + 
    CT[GReg[a1, a3, a5, a6, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a7, a8, a6]] - CT[GReg[a1, a3, a5, a6, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a3, a5, a6, a9], GReg[a2, a1]*GReg[a4, a5]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a3, a5, a6, a9], 
     GReg[a2, a3]*GReg[a4, a5]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a3, a5, a7, a9], GReg[a2, a1]*GReg[a4, a3]*GReg[a6, a5]*
      GReg[a8, a7]] - CT[GReg[a1, a3, a5, a7, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a5]*GReg[a8, a7]] - CT[GReg[a1, a3, a5, a7, a9], 
     GReg[a2, a1]*GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]] + 
    CT[GReg[a1, a3, a5, a7, a9], GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a5]*
      GReg[a8, a7]] - CT[GReg[a1, a3, a5, a7, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a1, a3, a5, a7, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a1, a3, a5, a7, a9], GReg[a2, a1]*GReg[a4, a5]*GReg[a6, a7]*
      GReg[a8, a7]] - CT[GReg[a1, a3, a5, a7, a9], GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a1, a3, a5, a8, a9], 
     GReg[a2, a1]*GReg[a4, a3]*GReg[a6, a5]*GReg[a7, a8]] + 
    CT[GReg[a1, a3, a5, a8, a9], GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a5]*
      GReg[a7, a8]] + CT[GReg[a1, a3, a5, a8, a9], GReg[a2, a1]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a7, a8]] - CT[GReg[a1, a3, a5, a8, a9], 
     GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]] + 
    CT[GReg[a1, a3, a5, a8, a9], GReg[a2, a1]*GReg[a4, a3]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a1, a3, a5, a8, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a8]*GReg[a7, a8]] - CT[GReg[a1, a3, a5, a8, a9], 
     GReg[a2, a1]*GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a1, a3, a5, a8, a9], GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a1, a3, a5, a8, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a6, a7, a5]] - CT[GReg[a1, a3, a5, a8, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a3, a5, a8, a9], GReg[a2, a1]*GReg[a4, a5]*
      GReg[a6, a7, a5]] + CT[GReg[a1, a3, a5, a8, a9], 
     GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a3, a5, a8, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a6, a7, a8]] + CT[GReg[a1, a3, a5, a8, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a3, a5, a8, a9], GReg[a2, a1]*GReg[a4, a5]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a3, a5, a8, a9], 
     GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a3, a6, a7, a9], GReg[a2, a1]*GReg[a4, a3]*GReg[a5, a6]*
      GReg[a8, a7]] + CT[GReg[a1, a3, a6, a7, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a8, a7]] + CT[GReg[a1, a3, a6, a7, a9], 
     GReg[a2, a1]*GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]] - 
    CT[GReg[a1, a3, a6, a7, a9], GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a8, a7]] + CT[GReg[a1, a3, a6, a7, a9], GReg[a2, a1]*GReg[a8, a7]*
      GReg[a4, a5, a3]] - CT[GReg[a1, a3, a6, a7, a9], 
     GReg[a2, a3]*GReg[a8, a7]*GReg[a4, a5, a3]] - 
    CT[GReg[a1, a3, a6, a7, a9], GReg[a2, a1]*GReg[a8, a7]*
      GReg[a4, a5, a6]] + CT[GReg[a1, a3, a6, a7, a9], 
     GReg[a2, a3]*GReg[a8, a7]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a3, a6, a8, a9], GReg[a2, a1]*GReg[a4, a3]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a1, a3, a6, a8, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a7, a6]] + CT[GReg[a1, a3, a6, a8, a9], 
     GReg[a2, a1]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a1, a3, a6, a8, a9], GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a1, a3, a6, a8, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a7, a8]] - CT[GReg[a1, a3, a6, a8, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a8]] - 
    CT[GReg[a1, a3, a6, a8, a9], GReg[a2, a1]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8]] + CT[GReg[a1, a3, a6, a8, a9], GReg[a2, a3]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8]] + CT[GReg[a1, a3, a6, a8, a9], 
     GReg[a2, a1]*GReg[a7, a6]*GReg[a4, a5, a3]] - 
    CT[GReg[a1, a3, a6, a8, a9], GReg[a2, a3]*GReg[a7, a6]*
      GReg[a4, a5, a3]] - CT[GReg[a1, a3, a6, a8, a9], 
     GReg[a2, a1]*GReg[a7, a8]*GReg[a4, a5, a3]] + 
    CT[GReg[a1, a3, a6, a8, a9], GReg[a2, a3]*GReg[a7, a8]*
      GReg[a4, a5, a3]] - CT[GReg[a1, a3, a6, a8, a9], 
     GReg[a2, a1]*GReg[a7, a6]*GReg[a4, a5, a6]] + 
    CT[GReg[a1, a3, a6, a8, a9], GReg[a2, a3]*GReg[a7, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a1, a3, a6, a8, a9], 
     GReg[a2, a1]*GReg[a7, a8]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a3, a6, a8, a9], GReg[a2, a3]*GReg[a7, a8]*
      GReg[a4, a5, a6]] + CT[GReg[a1, a3, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a3, a7, a8, a9], GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a1, a3, a7, a8, a9], GReg[a2, a1]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a1, a3, a7, a8, a9], 
     GReg[a2, a3]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a3, a7, a8, a9], GReg[a2, a1]*GReg[a6, a7]*
      GReg[a4, a5, a3]] + CT[GReg[a1, a3, a7, a8, a9], 
     GReg[a2, a3]*GReg[a6, a7]*GReg[a4, a5, a3]] + 
    CT[GReg[a1, a3, a7, a8, a9], GReg[a2, a1]*GReg[a6, a7]*
      GReg[a4, a5, a7]] - CT[GReg[a1, a3, a7, a8, a9], 
     GReg[a2, a3]*GReg[a6, a7]*GReg[a4, a5, a7]] - 
    CT[GReg[a1, a3, a7, a8, a9], GReg[a2, a1]*GReg[a4, a3]*
      GReg[a5, a6, a7]] + CT[GReg[a1, a3, a7, a8, a9], 
     GReg[a2, a3]*GReg[a4, a3]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a3, a7, a8, a9], GReg[a2, a1]*GReg[a4, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a1, a3, a7, a8, a9], 
     GReg[a2, a3]*GReg[a4, a7]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a3, a7, a8, a9], GReg[a2, a1]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a1, a3, a7, a8, a9], GReg[a2, a3]*GReg[a4, a5, a6, a3]] - 
    CT[GReg[a1, a3, a7, a8, a9], GReg[a2, a1]*GReg[a4, a5, a6, a7]] + 
    CT[GReg[a1, a3, a7, a8, a9], GReg[a2, a3]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a1, a4, a5, a6, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a7, a8, a6]] + CT[GReg[a1, a4, a5, a6, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a7, a8, a6]] + 
    CT[GReg[a1, a4, a5, a6, a9], GReg[a2, a3, a1]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a4, a5, a6, a9], GReg[a2, a3, a4]*GReg[a7, a8, a6]] - 
    CT[GReg[a1, a4, a5, a7, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a6, a5]*
      GReg[a8, a7]] + CT[GReg[a1, a4, a5, a7, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a5]*GReg[a8, a7]] + CT[GReg[a1, a4, a5, a7, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a1, a4, a5, a7, a9], GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7]*
      GReg[a8, a7]] + CT[GReg[a1, a4, a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a4, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a2, a3, a4]] + CT[GReg[a1, a4, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a2, a3, a4]] + 
    CT[GReg[a1, a4, a5, a8, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a6, a5]*
      GReg[a7, a8]] - CT[GReg[a1, a4, a5, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a5]*GReg[a7, a8]] - CT[GReg[a1, a4, a5, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a1, a4, a5, a8, a9], GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a1, a4, a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a2, a3, a1]] + CT[GReg[a1, a4, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a4, a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a2, a3, a4]] - CT[GReg[a1, a4, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a2, a3, a4]] - 
    CT[GReg[a1, a4, a5, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a6, a7, a5]] + CT[GReg[a1, a4, a5, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a4, a5, a8, a9], GReg[a2, a3, a1]*GReg[a6, a7, a5]] - 
    CT[GReg[a1, a4, a5, a8, a9], GReg[a2, a3, a4]*GReg[a6, a7, a5]] + 
    CT[GReg[a1, a4, a5, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a6, a7, a8]] - CT[GReg[a1, a4, a5, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a4, a5, a8, a9], GReg[a2, a3, a1]*GReg[a6, a7, a8]] + 
    CT[GReg[a1, a4, a5, a8, a9], GReg[a2, a3, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a1, a4, a6, a7, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a8, a7]] + CT[GReg[a1, a4, a6, a7, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a8, a7]] + CT[GReg[a1, a4, a6, a7, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6]*GReg[a8, a7]] - 
    CT[GReg[a1, a4, a6, a7, a9], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a8, a7]] + CT[GReg[a1, a4, a6, a7, a9], GReg[a5, a4]*GReg[a8, a7]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a4, a6, a7, a9], 
     GReg[a5, a6]*GReg[a8, a7]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a6, a7, a9], GReg[a5, a4]*GReg[a8, a7]*
      GReg[a2, a3, a4]] + CT[GReg[a1, a4, a6, a7, a9], 
     GReg[a5, a6]*GReg[a8, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a1, a4, a6, a8, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a6]] + CT[GReg[a1, a4, a6, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a7, a6]] + CT[GReg[a1, a4, a6, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a1, a4, a6, a8, a9], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a1, a4, a6, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a7, a8]] - CT[GReg[a1, a4, a6, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a8]] - 
    CT[GReg[a1, a4, a6, a8, a9], GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a8]] + CT[GReg[a1, a4, a6, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6]*GReg[a7, a8]] + CT[GReg[a1, a4, a6, a8, a9], 
     GReg[a5, a4]*GReg[a7, a6]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a4, a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a4, a6, a8, a9], 
     GReg[a5, a4]*GReg[a7, a8]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a4, a6, a8, a9], GReg[a5, a6]*GReg[a7, a8]*
      GReg[a2, a3, a1]] - CT[GReg[a1, a4, a6, a8, a9], 
     GReg[a5, a4]*GReg[a7, a6]*GReg[a2, a3, a4]] + 
    CT[GReg[a1, a4, a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a2, a3, a4]] + CT[GReg[a1, a4, a6, a8, a9], 
     GReg[a5, a4]*GReg[a7, a8]*GReg[a2, a3, a4]] - 
    CT[GReg[a1, a4, a6, a8, a9], GReg[a5, a6]*GReg[a7, a8]*
      GReg[a2, a3, a4]] + CT[GReg[a1, a4, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]] - 
    CT[GReg[a1, a4, a7, a8, a9], GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a7]] - CT[GReg[a1, a4, a7, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a1, a4, a7, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a4, a7, a8, a9], GReg[a5, a4]*GReg[a6, a7]*
      GReg[a2, a3, a1]] + CT[GReg[a1, a4, a7, a8, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a4, a7, a8, a9], GReg[a5, a4]*GReg[a6, a7]*
      GReg[a2, a3, a4]] - CT[GReg[a1, a4, a7, a8, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a1, a4, a7, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a5, a6, a4]] + CT[GReg[a1, a4, a7, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a4, a7, a8, a9], GReg[a2, a3, a1]*GReg[a5, a6, a4]] - 
    CT[GReg[a1, a4, a7, a8, a9], GReg[a2, a3, a4]*GReg[a5, a6, a4]] + 
    CT[GReg[a1, a4, a7, a8, a9], GReg[a2, a1]*GReg[a3, a4]*
      GReg[a5, a6, a7]] - CT[GReg[a1, a4, a7, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6, a7]] - 
    CT[GReg[a1, a4, a7, a8, a9], GReg[a2, a3, a1]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a4, a7, a8, a9], GReg[a2, a3, a4]*GReg[a5, a6, a7]] + 
    CT[GReg[a1, a5, a6, a7, a9], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a8, a7]] - CT[GReg[a1, a5, a6, a7, a9], GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a8, a7]] - CT[GReg[a1, a5, a6, a7, a9], 
     GReg[a4, a5]*GReg[a8, a7]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a5, a6, a7, a9], GReg[a4, a5]*GReg[a8, a7]*
      GReg[a2, a3, a5]] - CT[GReg[a1, a5, a6, a7, a9], 
     GReg[a2, a1]*GReg[a8, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a6, a7, a9], GReg[a2, a5]*GReg[a8, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a1, a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a2, a3, a4, a1]] - CT[GReg[a1, a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a2, a3, a4, a5]] + CT[GReg[a1, a5, a6, a8, a9], 
     GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a6]] - 
    CT[GReg[a1, a5, a6, a8, a9], GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a6]] - CT[GReg[a1, a5, a6, a8, a9], GReg[a2, a1]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a7, a8]] + CT[GReg[a1, a5, a6, a8, a9], 
     GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a8]] - 
    CT[GReg[a1, a5, a6, a8, a9], GReg[a4, a5]*GReg[a7, a6]*
      GReg[a2, a3, a1]] + CT[GReg[a1, a5, a6, a8, a9], 
     GReg[a4, a5]*GReg[a7, a8]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a5, a6, a8, a9], GReg[a4, a5]*GReg[a7, a6]*
      GReg[a2, a3, a5]] - CT[GReg[a1, a5, a6, a8, a9], 
     GReg[a4, a5]*GReg[a7, a8]*GReg[a2, a3, a5]] - 
    CT[GReg[a1, a5, a6, a8, a9], GReg[a2, a1]*GReg[a7, a6]*
      GReg[a3, a4, a5]] + CT[GReg[a1, a5, a6, a8, a9], 
     GReg[a2, a5]*GReg[a7, a6]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a6, a8, a9], GReg[a2, a1]*GReg[a7, a8]*
      GReg[a3, a4, a5]] - CT[GReg[a1, a5, a6, a8, a9], 
     GReg[a2, a5]*GReg[a7, a8]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a6, a8, a9], GReg[a7, a6]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a6, a8, a9], GReg[a7, a8]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a6, a8, a9], GReg[a7, a6]*GReg[a2, a3, a4, a5]] + 
    CT[GReg[a1, a5, a6, a8, a9], GReg[a7, a8]*GReg[a2, a3, a4, a5]] + 
    CT[GReg[a1, a5, a7, a8, a9], GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a1, a5, a7, a8, a9], GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a5]] - CT[GReg[a1, a5, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]] + 
    CT[GReg[a1, a5, a7, a8, a9], GReg[a2, a5]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]] - CT[GReg[a1, a5, a7, a8, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a2, a3, a1]] + CT[GReg[a1, a5, a7, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7]*GReg[a2, a3, a1]] + 
    CT[GReg[a1, a5, a7, a8, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a2, a3, a5]] - CT[GReg[a1, a5, a7, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7]*GReg[a2, a3, a5]] - 
    CT[GReg[a1, a5, a7, a8, a9], GReg[a2, a1]*GReg[a6, a5]*
      GReg[a3, a4, a5]] + CT[GReg[a1, a5, a7, a8, a9], 
     GReg[a2, a5]*GReg[a6, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a7, a8, a9], GReg[a2, a1]*GReg[a6, a7]*
      GReg[a3, a4, a5]] - CT[GReg[a1, a5, a7, a8, a9], 
     GReg[a2, a5]*GReg[a6, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a1, a5, a7, a8, a9], GReg[a6, a5]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a7, a8, a9], GReg[a6, a7]*GReg[a2, a3, a4, a1]] - 
    CT[GReg[a1, a5, a7, a8, a9], GReg[a6, a5]*GReg[a2, a3, a4, a5]] + 
    CT[GReg[a1, a5, a7, a8, a9], GReg[a6, a7]*GReg[a2, a3, a4, a5]] - 
    CT[GReg[a1, a6, a7, a8, a9], GReg[a2, a1]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a1, a6, a7, a8, a9], GReg[a2, a6]*GReg[a3, a6]*
      GReg[a4, a6]*GReg[a5, a6]] + CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a2, a3, a1]] - 
    CT[GReg[a1, a6, a7, a8, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a2, a3, a6]] + CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a5, a6]*GReg[a3, a4, a6]] - 
    CT[GReg[a1, a6, a7, a8, a9], GReg[a2, a6]*GReg[a5, a6]*
      GReg[a3, a4, a6]] + CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a1, a6, a7, a8, a9], GReg[a2, a6]*GReg[a3, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a2, a3, a1]*GReg[a4, a5, a6]] + CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a2, a3, a6]*GReg[a4, a5, a6]] - CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a5, a6]*GReg[a2, a3, a4, a1]] + CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a5, a6]*GReg[a2, a3, a4, a6]] - CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4, a5, a6]] + CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a2, a6]*GReg[a3, a4, a5, a6]] + CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a2, a3, a4, a5, a1]] - CT[GReg[a1, a6, a7, a8, a9], 
     GReg[a2, a3, a4, a5, a6]] - CT[GReg[a2, a3, a4, a5, a9], 
     GReg[a1, a2]*GReg[a6, a7, a8, a5]] + CT[GReg[a2, a3, a4, a5, a9], 
     GReg[a1, a9]*GReg[a6, a7, a8, a5]] - CT[GReg[a2, a3, a4, a6, a9], 
     GReg[a1, a2]*GReg[a5, a4]*GReg[a7, a8, a6]] + 
    CT[GReg[a2, a3, a4, a6, a9], GReg[a1, a9]*GReg[a5, a4]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a3, a4, a6, a9], 
     GReg[a1, a2]*GReg[a5, a6]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a3, a4, a6, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a3, a4, a7, a9], 
     GReg[a1, a2]*GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a2, a3, a4, a7, a9], GReg[a1, a9]*GReg[a5, a4]*GReg[a6, a7]*
      GReg[a8, a7]] - CT[GReg[a2, a3, a4, a7, a9], GReg[a1, a2]*GReg[a5, a7]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a2, a3, a4, a7, a9], 
     GReg[a1, a9]*GReg[a5, a7]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a2, a3, a4, a7, a9], GReg[a1, a2]*GReg[a8, a7]*
      GReg[a5, a6, a4]] + CT[GReg[a2, a3, a4, a7, a9], 
     GReg[a1, a9]*GReg[a8, a7]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a3, a4, a7, a9], GReg[a1, a2]*GReg[a8, a7]*
      GReg[a5, a6, a7]] - CT[GReg[a2, a3, a4, a7, a9], 
     GReg[a1, a9]*GReg[a8, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a2]*GReg[a5, a4]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a9]*GReg[a5, a4]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a2, a3, a4, a8, a9], 
     GReg[a1, a2]*GReg[a5, a8]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a9]*GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a2]*GReg[a7, a8]*
      GReg[a5, a6, a4]] - CT[GReg[a2, a3, a4, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a5, a6, a4]] - 
    CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a2]*GReg[a7, a8]*
      GReg[a5, a6, a8]] + CT[GReg[a2, a3, a4, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a5, a6, a8]] + 
    CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a2]*GReg[a5, a4]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a3, a4, a8, a9], 
     GReg[a1, a9]*GReg[a5, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a2]*GReg[a5, a8]*
      GReg[a6, a7, a8]] + CT[GReg[a2, a3, a4, a8, a9], 
     GReg[a1, a9]*GReg[a5, a8]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a2]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a9]*GReg[a5, a6, a7, a4]] + 
    CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a2]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a2, a3, a4, a8, a9], GReg[a1, a9]*GReg[a5, a6, a7, a8]] - 
    CT[GReg[a2, a3, a5, a6, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a3, a5, a6, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a7, a8, a6]] + 
    CT[GReg[a2, a3, a5, a6, a9], GReg[a1, a2]*GReg[a4, a5]*
      GReg[a7, a8, a6]] - CT[GReg[a2, a3, a5, a6, a9], 
     GReg[a1, a9]*GReg[a4, a5]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a3, a5, a7, a9], GReg[a1, a2]*GReg[a4, a3]*GReg[a6, a5]*
      GReg[a8, a7]] + CT[GReg[a2, a3, a5, a7, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a6, a5]*GReg[a8, a7]] + CT[GReg[a2, a3, a5, a7, a9], 
     GReg[a1, a2]*GReg[a4, a5]*GReg[a6, a5]*GReg[a8, a7]] - 
    CT[GReg[a2, a3, a5, a7, a9], GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a5]*
      GReg[a8, a7]] + CT[GReg[a2, a3, a5, a7, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a2, a3, a5, a7, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a2, a3, a5, a7, a9], GReg[a1, a2]*GReg[a4, a5]*GReg[a6, a7]*
      GReg[a8, a7]] + CT[GReg[a2, a3, a5, a7, a9], GReg[a1, a9]*GReg[a4, a5]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a2, a3, a5, a8, a9], 
     GReg[a1, a2]*GReg[a4, a3]*GReg[a6, a5]*GReg[a7, a8]] - 
    CT[GReg[a2, a3, a5, a8, a9], GReg[a1, a9]*GReg[a4, a3]*GReg[a6, a5]*
      GReg[a7, a8]] - CT[GReg[a2, a3, a5, a8, a9], GReg[a1, a2]*GReg[a4, a5]*
      GReg[a6, a5]*GReg[a7, a8]] + CT[GReg[a2, a3, a5, a8, a9], 
     GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a5]*GReg[a7, a8]] - 
    CT[GReg[a2, a3, a5, a8, a9], GReg[a1, a2]*GReg[a4, a3]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a2, a3, a5, a8, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a2, a3, a5, a8, a9], 
     GReg[a1, a2]*GReg[a4, a5]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a2, a3, a5, a8, a9], GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a2, a3, a5, a8, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a6, a7, a5]] + CT[GReg[a2, a3, a5, a8, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a3, a5, a8, a9], GReg[a1, a2]*GReg[a4, a5]*
      GReg[a6, a7, a5]] - CT[GReg[a2, a3, a5, a8, a9], 
     GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a3, a5, a8, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a3, a5, a8, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a3, a5, a8, a9], GReg[a1, a2]*GReg[a4, a5]*
      GReg[a6, a7, a8]] + CT[GReg[a2, a3, a5, a8, a9], 
     GReg[a1, a9]*GReg[a4, a5]*GReg[a6, a7, a8]] + 
    CT[GReg[a2, a3, a6, a7, a9], GReg[a1, a2]*GReg[a4, a3]*GReg[a5, a6]*
      GReg[a8, a7]] - CT[GReg[a2, a3, a6, a7, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a8, a7]] - CT[GReg[a2, a3, a6, a7, a9], 
     GReg[a1, a2]*GReg[a4, a6]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a2, a3, a6, a7, a9], GReg[a1, a9]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a8, a7]] - CT[GReg[a2, a3, a6, a7, a9], GReg[a1, a2]*GReg[a8, a7]*
      GReg[a4, a5, a3]] + CT[GReg[a2, a3, a6, a7, a9], 
     GReg[a1, a9]*GReg[a8, a7]*GReg[a4, a5, a3]] + 
    CT[GReg[a2, a3, a6, a7, a9], GReg[a1, a2]*GReg[a8, a7]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a3, a6, a7, a9], 
     GReg[a1, a9]*GReg[a8, a7]*GReg[a4, a5, a6]] + 
    CT[GReg[a2, a3, a6, a8, a9], GReg[a1, a2]*GReg[a4, a3]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a2, a3, a6, a8, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a7, a6]] - CT[GReg[a2, a3, a6, a8, a9], 
     GReg[a1, a2]*GReg[a4, a6]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a2, a3, a6, a8, a9], GReg[a1, a9]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a2, a3, a6, a8, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a5, a6]*GReg[a7, a8]] + CT[GReg[a2, a3, a6, a8, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a8]] + 
    CT[GReg[a2, a3, a6, a8, a9], GReg[a1, a2]*GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8]] - CT[GReg[a2, a3, a6, a8, a9], GReg[a1, a9]*GReg[a4, a6]*
      GReg[a5, a6]*GReg[a7, a8]] - CT[GReg[a2, a3, a6, a8, a9], 
     GReg[a1, a2]*GReg[a7, a6]*GReg[a4, a5, a3]] + 
    CT[GReg[a2, a3, a6, a8, a9], GReg[a1, a9]*GReg[a7, a6]*
      GReg[a4, a5, a3]] + CT[GReg[a2, a3, a6, a8, a9], 
     GReg[a1, a2]*GReg[a7, a8]*GReg[a4, a5, a3]] - 
    CT[GReg[a2, a3, a6, a8, a9], GReg[a1, a9]*GReg[a7, a8]*
      GReg[a4, a5, a3]] + CT[GReg[a2, a3, a6, a8, a9], 
     GReg[a1, a2]*GReg[a7, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a3, a6, a8, a9], GReg[a1, a9]*GReg[a7, a6]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a3, a6, a8, a9], 
     GReg[a1, a2]*GReg[a7, a8]*GReg[a4, a5, a6]] + 
    CT[GReg[a2, a3, a6, a8, a9], GReg[a1, a9]*GReg[a7, a8]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a3, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a2, a3, a7, a8, a9], GReg[a1, a9]*GReg[a4, a3]*GReg[a5, a7]*
      GReg[a6, a7]] + CT[GReg[a2, a3, a7, a8, a9], GReg[a1, a2]*GReg[a4, a7]*
      GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a2, a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a4, a7]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a2, a3, a7, a8, a9], GReg[a1, a2]*GReg[a6, a7]*
      GReg[a4, a5, a3]] - CT[GReg[a2, a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7]*GReg[a4, a5, a3]] - 
    CT[GReg[a2, a3, a7, a8, a9], GReg[a1, a2]*GReg[a6, a7]*
      GReg[a4, a5, a7]] + CT[GReg[a2, a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7]*GReg[a4, a5, a7]] + 
    CT[GReg[a2, a3, a7, a8, a9], GReg[a1, a2]*GReg[a4, a3]*
      GReg[a5, a6, a7]] - CT[GReg[a2, a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a4, a3]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a3, a7, a8, a9], GReg[a1, a2]*GReg[a4, a7]*
      GReg[a5, a6, a7]] + CT[GReg[a2, a3, a7, a8, a9], 
     GReg[a1, a9]*GReg[a4, a7]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a3, a7, a8, a9], GReg[a1, a2]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a2, a3, a7, a8, a9], GReg[a1, a9]*GReg[a4, a5, a6, a3]] + 
    CT[GReg[a2, a3, a7, a8, a9], GReg[a1, a2]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a2, a3, a7, a8, a9], GReg[a1, a9]*GReg[a4, a5, a6, a7]] - 
    CT[GReg[a2, a4, a5, a6, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a7, a8, a6]] + CT[GReg[a2, a4, a5, a6, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a7, a8, a6]] + 
    CT[GReg[a2, a4, a5, a6, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a7, a8, a6]] - CT[GReg[a2, a4, a5, a6, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a7, a8, a6]] - 
    CT[GReg[a2, a4, a5, a7, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a6, a5]*
      GReg[a8, a7]] + CT[GReg[a2, a4, a5, a7, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a6, a5]*GReg[a8, a7]] + CT[GReg[a2, a4, a5, a7, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a6, a5]*GReg[a8, a7]] - 
    CT[GReg[a2, a4, a5, a7, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a6, a5]*
      GReg[a8, a7]] + CT[GReg[a2, a4, a5, a7, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a2, a4, a5, a7, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a2, a4, a5, a7, a9], GReg[a1, a2]*GReg[a3, a4]*GReg[a6, a7]*
      GReg[a8, a7]] + CT[GReg[a2, a4, a5, a7, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a6, a7]*GReg[a8, a7]] + CT[GReg[a2, a4, a5, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a6, a5]*GReg[a7, a8]] - 
    CT[GReg[a2, a4, a5, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a6, a5]*
      GReg[a7, a8]] - CT[GReg[a2, a4, a5, a8, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a6, a5]*GReg[a7, a8]] + CT[GReg[a2, a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a6, a5]*GReg[a7, a8]] - 
    CT[GReg[a2, a4, a5, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a2, a4, a5, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a2, a4, a5, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a2, a4, a5, a8, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a2, a4, a5, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a6, a7, a5]] + CT[GReg[a2, a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a4, a5, a8, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a6, a7, a5]] - CT[GReg[a2, a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a6, a7, a5]] + 
    CT[GReg[a2, a4, a5, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a6, a7, a8]] - CT[GReg[a2, a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a4, a5, a8, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a6, a7, a8]] + CT[GReg[a2, a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a6, a7, a8]] - 
    CT[GReg[a2, a4, a6, a7, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]*
      GReg[a8, a7]] + CT[GReg[a2, a4, a6, a7, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a5, a4]*GReg[a8, a7]] + CT[GReg[a2, a4, a6, a7, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]*GReg[a8, a7]] - 
    CT[GReg[a2, a4, a6, a7, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a8, a7]] + CT[GReg[a2, a4, a6, a7, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a5, a6]*GReg[a8, a7]] - CT[GReg[a2, a4, a6, a7, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a6]*GReg[a8, a7]] - 
    CT[GReg[a2, a4, a6, a7, a9], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a8, a7]] + CT[GReg[a2, a4, a6, a7, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a5, a6]*GReg[a8, a7]] - CT[GReg[a2, a4, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]*GReg[a7, a6]] + 
    CT[GReg[a2, a4, a6, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a4]*
      GReg[a7, a6]] + CT[GReg[a2, a4, a6, a8, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a7, a6]] - CT[GReg[a2, a4, a6, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a4]*GReg[a7, a6]] + 
    CT[GReg[a2, a4, a6, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a2, a4, a6, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a5, a6]*GReg[a7, a6]] - CT[GReg[a2, a4, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a2, a4, a6, a8, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a2, a4, a6, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a5, a4]*GReg[a7, a8]] - CT[GReg[a2, a4, a6, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a4]*GReg[a7, a8]] - 
    CT[GReg[a2, a4, a6, a8, a9], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a8]] + CT[GReg[a2, a4, a6, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a5, a4]*GReg[a7, a8]] - CT[GReg[a2, a4, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a6]*GReg[a7, a8]] + 
    CT[GReg[a2, a4, a6, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a6]*
      GReg[a7, a8]] + CT[GReg[a2, a4, a6, a8, a9], GReg[a1, a2]*GReg[a3, a4]*
      GReg[a5, a6]*GReg[a7, a8]] - CT[GReg[a2, a4, a6, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a6]*GReg[a7, a8]] + 
    CT[GReg[a2, a4, a7, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]*
      GReg[a6, a7]] - CT[GReg[a2, a4, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a5, a4]*GReg[a6, a7]] - CT[GReg[a2, a4, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]*GReg[a6, a7]] + 
    CT[GReg[a2, a4, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a7]] - CT[GReg[a2, a4, a7, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a2, a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a2, a4, a7, a8, a9], GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a2, a4, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a2, a4, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a6, a4]] + 
    CT[GReg[a2, a4, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a5, a6, a4]] + CT[GReg[a2, a4, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6, a4]] - 
    CT[GReg[a2, a4, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a5, a6, a4]] + CT[GReg[a2, a4, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a6, a7]] - 
    CT[GReg[a2, a4, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a5, a6, a7]] - CT[GReg[a2, a4, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6, a7]] + 
    CT[GReg[a2, a4, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a5, a6, a7]] + CT[GReg[a2, a5, a6, a7, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*GReg[a8, a7]] - 
    CT[GReg[a2, a5, a6, a7, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a8, a7]] - CT[GReg[a2, a5, a6, a7, a9], GReg[a1, a2]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a8, a7]] + CT[GReg[a2, a5, a6, a7, a9], 
     GReg[a1, a9]*GReg[a3, a5]*GReg[a4, a5]*GReg[a8, a7]] - 
    CT[GReg[a2, a5, a6, a7, a9], GReg[a1, a2]*GReg[a8, a7]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a5, a6, a7, a9], 
     GReg[a1, a9]*GReg[a8, a7]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a6, a7, a9], GReg[a1, a2]*GReg[a8, a7]*
      GReg[a3, a4, a5]] - CT[GReg[a2, a5, a6, a7, a9], 
     GReg[a1, a9]*GReg[a8, a7]*GReg[a3, a4, a5]] + 
    CT[GReg[a2, a5, a6, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a7, a6]] - CT[GReg[a2, a5, a6, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a7, a6]] - CT[GReg[a2, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*GReg[a7, a6]] + 
    CT[GReg[a2, a5, a6, a8, a9], GReg[a1, a9]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a6]] - CT[GReg[a2, a5, a6, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a7, a8]] + CT[GReg[a2, a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5]*GReg[a7, a8]] + 
    CT[GReg[a2, a5, a6, a8, a9], GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a8]] - CT[GReg[a2, a5, a6, a8, a9], GReg[a1, a9]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a7, a8]] - CT[GReg[a2, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a7, a6]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a6, a8, a9], GReg[a1, a9]*GReg[a7, a6]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a7, a8]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a5, a6, a8, a9], GReg[a1, a9]*GReg[a7, a8]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a7, a6]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a5, a6, a8, a9], GReg[a1, a9]*GReg[a7, a6]*
      GReg[a3, a4, a5]] - CT[GReg[a2, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a7, a8]*GReg[a3, a4, a5]] + 
    CT[GReg[a2, a5, a6, a8, a9], GReg[a1, a9]*GReg[a7, a8]*
      GReg[a3, a4, a5]] + CT[GReg[a2, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a2, a5, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a2, a5, a7, a8, a9], GReg[a1, a2]*GReg[a3, a5]*
      GReg[a4, a5]*GReg[a6, a5]] + CT[GReg[a2, a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a2, a5, a7, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]*
      GReg[a6, a7]] + CT[GReg[a2, a5, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a4, a5]*GReg[a6, a7]] + CT[GReg[a2, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]*GReg[a6, a7]] - 
    CT[GReg[a2, a5, a7, a8, a9], GReg[a1, a9]*GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]] - CT[GReg[a2, a5, a7, a8, a9], GReg[a1, a2]*GReg[a6, a5]*
      GReg[a3, a4, a2]] + CT[GReg[a2, a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a5]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a7, a8, a9], GReg[a1, a2]*GReg[a6, a7]*
      GReg[a3, a4, a2]] - CT[GReg[a2, a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7]*GReg[a3, a4, a2]] + 
    CT[GReg[a2, a5, a7, a8, a9], GReg[a1, a2]*GReg[a6, a5]*
      GReg[a3, a4, a5]] - CT[GReg[a2, a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a5]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a5, a7, a8, a9], GReg[a1, a2]*GReg[a6, a7]*
      GReg[a3, a4, a5]] + CT[GReg[a2, a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7]*GReg[a3, a4, a5]] - 
    CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a4, a6]*GReg[a5, a6]] + CT[GReg[a2, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a6]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a9]*GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a2]*GReg[a5, a6]*
      GReg[a3, a4, a2]] - CT[GReg[a2, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a6]*GReg[a3, a4, a2]] - 
    CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a2]*GReg[a5, a6]*
      GReg[a3, a4, a6]] + CT[GReg[a2, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a6]*GReg[a3, a4, a6]] + 
    CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a2]*GReg[a3, a2]*
      GReg[a4, a5, a6]] - CT[GReg[a2, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a2]*GReg[a3, a6]*
      GReg[a4, a5, a6]] + CT[GReg[a2, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a6]*GReg[a4, a5, a6]] - 
    CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a2]*GReg[a3, a4, a5, a2]] + 
    CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4, a5, a2]] + 
    CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a2]*GReg[a3, a4, a5, a6]] - 
    CT[GReg[a2, a6, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4, a5, a6]] + 
    CT[GReg[a3, a4, a5, a6, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a7, a8, a6]] - CT[GReg[a3, a4, a5, a6, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a7, a8, a6]] - 
    CT[GReg[a3, a4, a5, a6, a9], GReg[a1, a2, a3]*GReg[a7, a8, a6]] + 
    CT[GReg[a3, a4, a5, a6, a9], GReg[a1, a2, a9]*GReg[a7, a8, a6]] + 
    CT[GReg[a3, a4, a5, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a5]*
      GReg[a8, a7]] - CT[GReg[a3, a4, a5, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a6, a5]*GReg[a8, a7]] - CT[GReg[a3, a4, a5, a7, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a3, a4, a5, a7, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a6, a7]*
      GReg[a8, a7]] - CT[GReg[a3, a4, a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a4, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a5, a7, a9], GReg[a6, a5]*GReg[a8, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a4, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]*GReg[a1, a2, a9]] - 
    CT[GReg[a3, a4, a5, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a5]*
      GReg[a7, a8]] + CT[GReg[a3, a4, a5, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a6, a5]*GReg[a7, a8]] + CT[GReg[a3, a4, a5, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a3, a4, a5, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a3, a4, a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a4, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a4, a5, a8, a9], GReg[a6, a5]*GReg[a7, a8]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a4, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a4, a5, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a6, a7, a5]] - CT[GReg[a3, a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a6, a7, a5]] - 
    CT[GReg[a3, a4, a5, a8, a9], GReg[a1, a2, a3]*GReg[a6, a7, a5]] + 
    CT[GReg[a3, a4, a5, a8, a9], GReg[a1, a2, a9]*GReg[a6, a7, a5]] - 
    CT[GReg[a3, a4, a5, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a6, a7, a8]] + CT[GReg[a3, a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a4, a5, a8, a9], GReg[a1, a2, a3]*GReg[a6, a7, a8]] - 
    CT[GReg[a3, a4, a5, a8, a9], GReg[a1, a2, a9]*GReg[a6, a7, a8]] + 
    CT[GReg[a3, a4, a6, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a4]*
      GReg[a8, a7]] - CT[GReg[a3, a4, a6, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a5, a4]*GReg[a8, a7]] - CT[GReg[a3, a4, a6, a7, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a3, a4, a6, a7, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a6]*
      GReg[a8, a7]] - CT[GReg[a3, a4, a6, a7, a9], GReg[a5, a4]*GReg[a8, a7]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a4, a6, a7, a9], 
     GReg[a5, a6]*GReg[a8, a7]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a6, a7, a9], GReg[a5, a4]*GReg[a8, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a4, a6, a7, a9], 
     GReg[a5, a6]*GReg[a8, a7]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a4, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a4]*
      GReg[a7, a6]] - CT[GReg[a3, a4, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a5, a4]*GReg[a7, a6]] - CT[GReg[a3, a4, a6, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a3, a4, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a3, a4, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a5, a4]*GReg[a7, a8]] + CT[GReg[a3, a4, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a4]*GReg[a7, a8]] + 
    CT[GReg[a3, a4, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6]*
      GReg[a7, a8]] - CT[GReg[a3, a4, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a5, a6]*GReg[a7, a8]] - CT[GReg[a3, a4, a6, a8, a9], 
     GReg[a5, a4]*GReg[a7, a6]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a4, a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a4, a6, a8, a9], 
     GReg[a5, a4]*GReg[a7, a8]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a4, a6, a8, a9], GReg[a5, a6]*GReg[a7, a8]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a4, a6, a8, a9], 
     GReg[a5, a4]*GReg[a7, a6]*GReg[a1, a2, a9]] - 
    CT[GReg[a3, a4, a6, a8, a9], GReg[a5, a6]*GReg[a7, a6]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a4, a6, a8, a9], 
     GReg[a5, a4]*GReg[a7, a8]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a4, a6, a8, a9], GReg[a5, a6]*GReg[a7, a8]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a4, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a4]*GReg[a6, a7]] + 
    CT[GReg[a3, a4, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a4]*
      GReg[a6, a7]] + CT[GReg[a3, a4, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a5, a7]*GReg[a6, a7]] - CT[GReg[a3, a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a3, a4, a7, a8, a9], GReg[a5, a4]*GReg[a6, a7]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a4, a7, a8, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a4, a7, a8, a9], GReg[a5, a4]*GReg[a6, a7]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a4, a7, a8, a9], 
     GReg[a5, a7]*GReg[a6, a7]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a4, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a5, a6, a4]] - CT[GReg[a3, a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a6, a4]] - 
    CT[GReg[a3, a4, a7, a8, a9], GReg[a1, a2, a3]*GReg[a5, a6, a4]] + 
    CT[GReg[a3, a4, a7, a8, a9], GReg[a1, a2, a9]*GReg[a5, a6, a4]] - 
    CT[GReg[a3, a4, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a5, a6, a7]] + CT[GReg[a3, a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a5, a6, a7]] + 
    CT[GReg[a3, a4, a7, a8, a9], GReg[a1, a2, a3]*GReg[a5, a6, a7]] - 
    CT[GReg[a3, a4, a7, a8, a9], GReg[a1, a2, a9]*GReg[a5, a6, a7]] + 
    CT[GReg[a3, a5, a6, a7, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a8, a7]] - CT[GReg[a3, a5, a6, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a8, a7]] - CT[GReg[a3, a5, a6, a7, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*GReg[a8, a7]] + 
    CT[GReg[a3, a5, a6, a7, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a8, a7]] - CT[GReg[a3, a5, a6, a7, a9], GReg[a4, a3]*GReg[a8, a7]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a5, a6, a7, a9], 
     GReg[a4, a5]*GReg[a8, a7]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a6, a7, a9], GReg[a4, a3]*GReg[a8, a7]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a5, a6, a7, a9], 
     GReg[a4, a5]*GReg[a8, a7]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a5, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a7, a6]] - CT[GReg[a3, a5, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a7, a6]] - CT[GReg[a3, a5, a6, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*GReg[a7, a6]] + 
    CT[GReg[a3, a5, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a7, a6]] - CT[GReg[a3, a5, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a7, a8]] + CT[GReg[a3, a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*GReg[a7, a8]] + 
    CT[GReg[a3, a5, a6, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a7, a8]] - CT[GReg[a3, a5, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a5]*GReg[a7, a8]] - CT[GReg[a3, a5, a6, a8, a9], 
     GReg[a4, a3]*GReg[a7, a6]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a6, a8, a9], GReg[a4, a5]*GReg[a7, a6]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a5, a6, a8, a9], 
     GReg[a4, a3]*GReg[a7, a8]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a5, a6, a8, a9], GReg[a4, a5]*GReg[a7, a8]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a5, a6, a8, a9], 
     GReg[a4, a3]*GReg[a7, a6]*GReg[a1, a2, a9]] - 
    CT[GReg[a3, a5, a6, a8, a9], GReg[a4, a5]*GReg[a7, a6]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a5, a6, a8, a9], 
     GReg[a4, a3]*GReg[a7, a8]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a5, a6, a8, a9], GReg[a4, a5]*GReg[a7, a8]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a5, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*GReg[a6, a5]] - 
    CT[GReg[a3, a5, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a5]] - CT[GReg[a3, a5, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a5]*GReg[a6, a5]] + CT[GReg[a3, a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a3, a5, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a7]] + CT[GReg[a3, a5, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a6, a7]] + CT[GReg[a3, a5, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]*GReg[a6, a7]] - 
    CT[GReg[a3, a5, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a7]] - CT[GReg[a3, a5, a7, a8, a9], GReg[a4, a3]*GReg[a6, a5]*
      GReg[a1, a2, a3]] + CT[GReg[a3, a5, a7, a8, a9], 
     GReg[a4, a5]*GReg[a6, a5]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a7, a8, a9], GReg[a4, a3]*GReg[a6, a7]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a5, a7, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7]*GReg[a1, a2, a3]] + 
    CT[GReg[a3, a5, a7, a8, a9], GReg[a4, a3]*GReg[a6, a5]*
      GReg[a1, a2, a9]] - CT[GReg[a3, a5, a7, a8, a9], 
     GReg[a4, a5]*GReg[a6, a5]*GReg[a1, a2, a9]] - 
    CT[GReg[a3, a5, a7, a8, a9], GReg[a4, a3]*GReg[a6, a7]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a5, a7, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7]*GReg[a1, a2, a9]] - 
    CT[GReg[a3, a6, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]*
      GReg[a5, a6]] + CT[GReg[a3, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a3]*GReg[a5, a6]] + CT[GReg[a3, a6, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a3, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a3, a6, a7, a8, a9], GReg[a4, a3]*GReg[a5, a6]*
      GReg[a1, a2, a3]] - CT[GReg[a3, a6, a7, a8, a9], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a3]] - 
    CT[GReg[a3, a6, a7, a8, a9], GReg[a4, a3]*GReg[a5, a6]*
      GReg[a1, a2, a9]] + CT[GReg[a3, a6, a7, a8, a9], 
     GReg[a4, a6]*GReg[a5, a6]*GReg[a1, a2, a9]] + 
    CT[GReg[a3, a6, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a5, a3]] - CT[GReg[a3, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a7, a8, a9], GReg[a1, a2, a3]*GReg[a4, a5, a3]] + 
    CT[GReg[a3, a6, a7, a8, a9], GReg[a1, a2, a9]*GReg[a4, a5, a3]] - 
    CT[GReg[a3, a6, a7, a8, a9], GReg[a1, a3]*GReg[a2, a3]*
      GReg[a4, a5, a6]] + CT[GReg[a3, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]*GReg[a4, a5, a6]] + 
    CT[GReg[a3, a6, a7, a8, a9], GReg[a1, a2, a3]*GReg[a4, a5, a6]] - 
    CT[GReg[a3, a6, a7, a8, a9], GReg[a1, a2, a9]*GReg[a4, a5, a6]] - 
    CT[GReg[a4, a5, a6, a7, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a8, a7]] + CT[GReg[a4, a5, a6, a7, a9], GReg[a1, a9]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a8, a7]] + CT[GReg[a4, a5, a6, a7, a9], 
     GReg[a3, a4]*GReg[a8, a7]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a5, a6, a7, a9], GReg[a3, a4]*GReg[a8, a7]*
      GReg[a1, a2, a9]] + CT[GReg[a4, a5, a6, a7, a9], 
     GReg[a1, a4]*GReg[a8, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6, a7, a9], GReg[a1, a9]*GReg[a8, a7]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a3, a4]] + CT[GReg[a4, a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a3, a9]] - CT[GReg[a4, a5, a6, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a7, a6]] + 
    CT[GReg[a4, a5, a6, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a7, a6]] + CT[GReg[a4, a5, a6, a8, a9], GReg[a1, a4]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a7, a8]] - CT[GReg[a4, a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*GReg[a7, a8]] + 
    CT[GReg[a4, a5, a6, a8, a9], GReg[a3, a4]*GReg[a7, a6]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a5, a6, a8, a9], 
     GReg[a3, a4]*GReg[a7, a8]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a5, a6, a8, a9], GReg[a3, a4]*GReg[a7, a6]*
      GReg[a1, a2, a9]] + CT[GReg[a4, a5, a6, a8, a9], 
     GReg[a3, a4]*GReg[a7, a8]*GReg[a1, a2, a9]] + 
    CT[GReg[a4, a5, a6, a8, a9], GReg[a1, a4]*GReg[a7, a6]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a6]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6, a8, a9], GReg[a1, a4]*GReg[a7, a8]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a6, a8, a9], GReg[a7, a6]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a6, a8, a9], GReg[a7, a8]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a6, a8, a9], GReg[a7, a6]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a5, a6, a8, a9], GReg[a7, a8]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a5, a7, a8, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a5]] + CT[GReg[a4, a5, a7, a8, a9], GReg[a1, a9]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a6, a5]] + CT[GReg[a4, a5, a7, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a6, a7]] - 
    CT[GReg[a4, a5, a7, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a7]] + CT[GReg[a4, a5, a7, a8, a9], GReg[a3, a4]*GReg[a6, a5]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a5, a7, a8, a9], 
     GReg[a3, a4]*GReg[a6, a7]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a5, a7, a8, a9], GReg[a3, a4]*GReg[a6, a5]*
      GReg[a1, a2, a9]] + CT[GReg[a4, a5, a7, a8, a9], 
     GReg[a3, a4]*GReg[a6, a7]*GReg[a1, a2, a9]] + 
    CT[GReg[a4, a5, a7, a8, a9], GReg[a1, a4]*GReg[a6, a5]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a5]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a7, a8, a9], GReg[a1, a4]*GReg[a6, a7]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a5, a7, a8, a9], GReg[a6, a5]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a7, a8, a9], GReg[a6, a7]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a5, a7, a8, a9], GReg[a6, a5]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a5, a7, a8, a9], GReg[a6, a7]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a6, a7, a8, a9], GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]] + CT[GReg[a4, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a4]*
      GReg[a3, a4]*GReg[a5, a4]] + CT[GReg[a4, a6, a7, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]*GReg[a5, a6]] - 
    CT[GReg[a4, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6]] + CT[GReg[a4, a6, a7, a8, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a1, a2, a4]] - CT[GReg[a4, a6, a7, a8, a9], 
     GReg[a3, a4]*GReg[a5, a6]*GReg[a1, a2, a4]] - 
    CT[GReg[a4, a6, a7, a8, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a1, a2, a9]] + CT[GReg[a4, a6, a7, a8, a9], 
     GReg[a3, a4]*GReg[a5, a6]*GReg[a1, a2, a9]] + 
    CT[GReg[a4, a6, a7, a8, a9], GReg[a1, a4]*GReg[a5, a4]*
      GReg[a2, a3, a4]] - CT[GReg[a4, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a4]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6, a7, a8, a9], GReg[a1, a4]*GReg[a5, a6]*
      GReg[a2, a3, a4]] + CT[GReg[a4, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a6]*GReg[a2, a3, a4]] - 
    CT[GReg[a4, a6, a7, a8, a9], GReg[a5, a4]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6, a7, a8, a9], GReg[a5, a6]*GReg[a1, a2, a3, a4]] + 
    CT[GReg[a4, a6, a7, a8, a9], GReg[a5, a4]*GReg[a1, a2, a3, a9]] - 
    CT[GReg[a4, a6, a7, a8, a9], GReg[a5, a6]*GReg[a1, a2, a3, a9]] + 
    CT[GReg[a5, a6, a7, a8, a9], GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]] - CT[GReg[a5, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a5]*
      GReg[a3, a5]*GReg[a4, a5]] - CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a3, a5]*GReg[a4, a5]*GReg[a1, a2, a5]] + 
    CT[GReg[a5, a6, a7, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a1, a2, a9]] - CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a1, a5]*GReg[a4, a5]*GReg[a2, a3, a5]] + 
    CT[GReg[a5, a6, a7, a8, a9], GReg[a1, a9]*GReg[a4, a5]*
      GReg[a2, a3, a5]] - CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a1, a5]*GReg[a2, a5]*GReg[a3, a4, a5]] + 
    CT[GReg[a5, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a5]*
      GReg[a3, a4, a5]] + CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a1, a2, a5]*GReg[a3, a4, a5]] - CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a1, a2, a9]*GReg[a3, a4, a5]] + CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a4, a5]*GReg[a1, a2, a3, a5]] - CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a4, a5]*GReg[a1, a2, a3, a9]] + CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a1, a5]*GReg[a2, a3, a4, a5]] - CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3, a4, a5]] - CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a1, a2, a3, a4, a5]] + CT[GReg[a5, a6, a7, a8, a9], 
     GReg[a1, a2, a3, a4, a9]] + CT[GReg[a1, a2, a3, a4, a5, a9], 
     GReg[a6, a7, a8, a5]] + CT[GReg[a1, a2, a3, a4, a6, a9], 
     GReg[a5, a4]*GReg[a7, a8, a6]] - CT[GReg[a1, a2, a3, a4, a6, a9], 
     GReg[a5, a6]*GReg[a7, a8, a6]] - CT[GReg[a1, a2, a3, a4, a7, a9], 
     GReg[a5, a4]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a1, a2, a3, a4, a7, a9], GReg[a5, a7]*GReg[a6, a7]*
      GReg[a8, a7]] + CT[GReg[a1, a2, a3, a4, a7, a9], 
     GReg[a8, a7]*GReg[a5, a6, a4]] - CT[GReg[a1, a2, a3, a4, a7, a9], 
     GReg[a8, a7]*GReg[a5, a6, a7]] + CT[GReg[a1, a2, a3, a4, a8, a9], 
     GReg[a5, a4]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a1, a2, a3, a4, a8, a9], GReg[a5, a8]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a1, a2, a3, a4, a8, a9], 
     GReg[a7, a8]*GReg[a5, a6, a4]] + CT[GReg[a1, a2, a3, a4, a8, a9], 
     GReg[a7, a8]*GReg[a5, a6, a8]] - CT[GReg[a1, a2, a3, a4, a8, a9], 
     GReg[a5, a4]*GReg[a6, a7, a8]] + CT[GReg[a1, a2, a3, a4, a8, a9], 
     GReg[a5, a8]*GReg[a6, a7, a8]] + CT[GReg[a1, a2, a3, a4, a8, a9], 
     GReg[a5, a6, a7, a4]] - CT[GReg[a1, a2, a3, a4, a8, a9], 
     GReg[a5, a6, a7, a8]] + CT[GReg[a1, a2, a3, a5, a6, a9], 
     GReg[a4, a3]*GReg[a7, a8, a6]] - CT[GReg[a1, a2, a3, a5, a6, a9], 
     GReg[a4, a5]*GReg[a7, a8, a6]] + CT[GReg[a1, a2, a3, a5, a7, a9], 
     GReg[a4, a3]*GReg[a6, a5]*GReg[a8, a7]] - 
    CT[GReg[a1, a2, a3, a5, a7, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a8, a7]] - CT[GReg[a1, a2, a3, a5, a7, a9], 
     GReg[a4, a3]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a1, a2, a3, a5, a7, a9], GReg[a4, a5]*GReg[a6, a7]*
      GReg[a8, a7]] - CT[GReg[a1, a2, a3, a5, a8, a9], 
     GReg[a4, a3]*GReg[a6, a5]*GReg[a7, a8]] + 
    CT[GReg[a1, a2, a3, a5, a8, a9], GReg[a4, a5]*GReg[a6, a5]*
      GReg[a7, a8]] + CT[GReg[a1, a2, a3, a5, a8, a9], 
     GReg[a4, a3]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a1, a2, a3, a5, a8, a9], GReg[a4, a5]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a1, a2, a3, a5, a8, a9], 
     GReg[a4, a3]*GReg[a6, a7, a5]] - CT[GReg[a1, a2, a3, a5, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7, a5]] - CT[GReg[a1, a2, a3, a5, a8, a9], 
     GReg[a4, a3]*GReg[a6, a7, a8]] + CT[GReg[a1, a2, a3, a5, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7, a8]] - CT[GReg[a1, a2, a3, a6, a7, a9], 
     GReg[a4, a3]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a1, a2, a3, a6, a7, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a8, a7]] + CT[GReg[a1, a2, a3, a6, a7, a9], 
     GReg[a8, a7]*GReg[a4, a5, a3]] - CT[GReg[a1, a2, a3, a6, a7, a9], 
     GReg[a8, a7]*GReg[a4, a5, a6]] - CT[GReg[a1, a2, a3, a6, a8, a9], 
     GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a1, a2, a3, a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a1, a2, a3, a6, a8, a9], 
     GReg[a4, a3]*GReg[a5, a6]*GReg[a7, a8]] - 
    CT[GReg[a1, a2, a3, a6, a8, a9], GReg[a4, a6]*GReg[a5, a6]*
      GReg[a7, a8]] + CT[GReg[a1, a2, a3, a6, a8, a9], 
     GReg[a7, a6]*GReg[a4, a5, a3]] - CT[GReg[a1, a2, a3, a6, a8, a9], 
     GReg[a7, a8]*GReg[a4, a5, a3]] - CT[GReg[a1, a2, a3, a6, a8, a9], 
     GReg[a7, a6]*GReg[a4, a5, a6]] + CT[GReg[a1, a2, a3, a6, a8, a9], 
     GReg[a7, a8]*GReg[a4, a5, a6]] + CT[GReg[a1, a2, a3, a7, a8, a9], 
     GReg[a4, a3]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a2, a3, a7, a8, a9], GReg[a4, a7]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a1, a2, a3, a7, a8, a9], 
     GReg[a6, a7]*GReg[a4, a5, a3]] + CT[GReg[a1, a2, a3, a7, a8, a9], 
     GReg[a6, a7]*GReg[a4, a5, a7]] - CT[GReg[a1, a2, a3, a7, a8, a9], 
     GReg[a4, a3]*GReg[a5, a6, a7]] + CT[GReg[a1, a2, a3, a7, a8, a9], 
     GReg[a4, a7]*GReg[a5, a6, a7]] + CT[GReg[a1, a2, a3, a7, a8, a9], 
     GReg[a4, a5, a6, a3]] - CT[GReg[a1, a2, a3, a7, a8, a9], 
     GReg[a4, a5, a6, a7]] + CT[GReg[a1, a2, a4, a5, a6, a9], 
     GReg[a3, a2]*GReg[a7, a8, a6]] - CT[GReg[a1, a2, a4, a5, a6, a9], 
     GReg[a3, a4]*GReg[a7, a8, a6]] + CT[GReg[a1, a2, a4, a5, a7, a9], 
     GReg[a3, a2]*GReg[a6, a5]*GReg[a8, a7]] - 
    CT[GReg[a1, a2, a4, a5, a7, a9], GReg[a3, a4]*GReg[a6, a5]*
      GReg[a8, a7]] - CT[GReg[a1, a2, a4, a5, a7, a9], 
     GReg[a3, a2]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a1, a2, a4, a5, a7, a9], GReg[a3, a4]*GReg[a6, a7]*
      GReg[a8, a7]] - CT[GReg[a1, a2, a4, a5, a8, a9], 
     GReg[a3, a2]*GReg[a6, a5]*GReg[a7, a8]] + 
    CT[GReg[a1, a2, a4, a5, a8, a9], GReg[a3, a4]*GReg[a6, a5]*
      GReg[a7, a8]] + CT[GReg[a1, a2, a4, a5, a8, a9], 
     GReg[a3, a2]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a1, a2, a4, a5, a8, a9], GReg[a3, a4]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a1, a2, a4, a5, a8, a9], 
     GReg[a3, a2]*GReg[a6, a7, a5]] - CT[GReg[a1, a2, a4, a5, a8, a9], 
     GReg[a3, a4]*GReg[a6, a7, a5]] - CT[GReg[a1, a2, a4, a5, a8, a9], 
     GReg[a3, a2]*GReg[a6, a7, a8]] + CT[GReg[a1, a2, a4, a5, a8, a9], 
     GReg[a3, a4]*GReg[a6, a7, a8]] + CT[GReg[a1, a2, a4, a6, a7, a9], 
     GReg[a3, a2]*GReg[a5, a4]*GReg[a8, a7]] - 
    CT[GReg[a1, a2, a4, a6, a7, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a8, a7]] - CT[GReg[a1, a2, a4, a6, a7, a9], 
     GReg[a3, a2]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a1, a2, a4, a6, a7, a9], GReg[a3, a4]*GReg[a5, a6]*
      GReg[a8, a7]] + CT[GReg[a1, a2, a4, a6, a8, a9], 
     GReg[a3, a2]*GReg[a5, a4]*GReg[a7, a6]] - 
    CT[GReg[a1, a2, a4, a6, a8, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a6]] - CT[GReg[a1, a2, a4, a6, a8, a9], 
     GReg[a3, a2]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a1, a2, a4, a6, a8, a9], GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a1, a2, a4, a6, a8, a9], 
     GReg[a3, a2]*GReg[a5, a4]*GReg[a7, a8]] + 
    CT[GReg[a1, a2, a4, a6, a8, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a7, a8]] + CT[GReg[a1, a2, a4, a6, a8, a9], 
     GReg[a3, a2]*GReg[a5, a6]*GReg[a7, a8]] - 
    CT[GReg[a1, a2, a4, a6, a8, a9], GReg[a3, a4]*GReg[a5, a6]*
      GReg[a7, a8]] - CT[GReg[a1, a2, a4, a7, a8, a9], 
     GReg[a3, a2]*GReg[a5, a4]*GReg[a6, a7]] + 
    CT[GReg[a1, a2, a4, a7, a8, a9], GReg[a3, a4]*GReg[a5, a4]*
      GReg[a6, a7]] + CT[GReg[a1, a2, a4, a7, a8, a9], 
     GReg[a3, a2]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a2, a4, a7, a8, a9], GReg[a3, a4]*GReg[a5, a7]*
      GReg[a6, a7]] + CT[GReg[a1, a2, a4, a7, a8, a9], 
     GReg[a3, a2]*GReg[a5, a6, a4]] - CT[GReg[a1, a2, a4, a7, a8, a9], 
     GReg[a3, a4]*GReg[a5, a6, a4]] - CT[GReg[a1, a2, a4, a7, a8, a9], 
     GReg[a3, a2]*GReg[a5, a6, a7]] + CT[GReg[a1, a2, a4, a7, a8, a9], 
     GReg[a3, a4]*GReg[a5, a6, a7]] - CT[GReg[a1, a2, a5, a6, a7, a9], 
     GReg[a3, a2]*GReg[a4, a5]*GReg[a8, a7]] + 
    CT[GReg[a1, a2, a5, a6, a7, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a8, a7]] + CT[GReg[a1, a2, a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a3, a4, a2]] - CT[GReg[a1, a2, a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a3, a4, a5]] - CT[GReg[a1, a2, a5, a6, a8, a9], 
     GReg[a3, a2]*GReg[a4, a5]*GReg[a7, a6]] + 
    CT[GReg[a1, a2, a5, a6, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a6]] + CT[GReg[a1, a2, a5, a6, a8, a9], 
     GReg[a3, a2]*GReg[a4, a5]*GReg[a7, a8]] - 
    CT[GReg[a1, a2, a5, a6, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a7, a8]] + CT[GReg[a1, a2, a5, a6, a8, a9], 
     GReg[a7, a6]*GReg[a3, a4, a2]] - CT[GReg[a1, a2, a5, a6, a8, a9], 
     GReg[a7, a8]*GReg[a3, a4, a2]] - CT[GReg[a1, a2, a5, a6, a8, a9], 
     GReg[a7, a6]*GReg[a3, a4, a5]] + CT[GReg[a1, a2, a5, a6, a8, a9], 
     GReg[a7, a8]*GReg[a3, a4, a5]] - CT[GReg[a1, a2, a5, a7, a8, a9], 
     GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a1, a2, a5, a7, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a5]] + CT[GReg[a1, a2, a5, a7, a8, a9], 
     GReg[a3, a2]*GReg[a4, a5]*GReg[a6, a7]] - 
    CT[GReg[a1, a2, a5, a7, a8, a9], GReg[a3, a5]*GReg[a4, a5]*
      GReg[a6, a7]] + CT[GReg[a1, a2, a5, a7, a8, a9], 
     GReg[a6, a5]*GReg[a3, a4, a2]] - CT[GReg[a1, a2, a5, a7, a8, a9], 
     GReg[a6, a7]*GReg[a3, a4, a2]] - CT[GReg[a1, a2, a5, a7, a8, a9], 
     GReg[a6, a5]*GReg[a3, a4, a5]] + CT[GReg[a1, a2, a5, a7, a8, a9], 
     GReg[a6, a7]*GReg[a3, a4, a5]] + CT[GReg[a1, a2, a6, a7, a8, a9], 
     GReg[a3, a2]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a1, a2, a6, a7, a8, a9], GReg[a3, a6]*GReg[a4, a6]*
      GReg[a5, a6]] - CT[GReg[a1, a2, a6, a7, a8, a9], 
     GReg[a5, a6]*GReg[a3, a4, a2]] + CT[GReg[a1, a2, a6, a7, a8, a9], 
     GReg[a5, a6]*GReg[a3, a4, a6]] - CT[GReg[a1, a2, a6, a7, a8, a9], 
     GReg[a3, a2]*GReg[a4, a5, a6]] + CT[GReg[a1, a2, a6, a7, a8, a9], 
     GReg[a3, a6]*GReg[a4, a5, a6]] + CT[GReg[a1, a2, a6, a7, a8, a9], 
     GReg[a3, a4, a5, a2]] - CT[GReg[a1, a2, a6, a7, a8, a9], 
     GReg[a3, a4, a5, a6]] + CT[GReg[a1, a3, a4, a5, a6, a9], 
     GReg[a2, a1]*GReg[a7, a8, a6]] - CT[GReg[a1, a3, a4, a5, a6, a9], 
     GReg[a2, a3]*GReg[a7, a8, a6]] + CT[GReg[a1, a3, a4, a5, a7, a9], 
     GReg[a2, a1]*GReg[a6, a5]*GReg[a8, a7]] - 
    CT[GReg[a1, a3, a4, a5, a7, a9], GReg[a2, a3]*GReg[a6, a5]*
      GReg[a8, a7]] - CT[GReg[a1, a3, a4, a5, a7, a9], 
     GReg[a2, a1]*GReg[a6, a7]*GReg[a8, a7]] + 
    CT[GReg[a1, a3, a4, a5, a7, a9], GReg[a2, a3]*GReg[a6, a7]*
      GReg[a8, a7]] - CT[GReg[a1, a3, a4, a5, a8, a9], 
     GReg[a2, a1]*GReg[a6, a5]*GReg[a7, a8]] + 
    CT[GReg[a1, a3, a4, a5, a8, a9], GReg[a2, a3]*GReg[a6, a5]*
      GReg[a7, a8]] + CT[GReg[a1, a3, a4, a5, a8, a9], 
     GReg[a2, a1]*GReg[a6, a8]*GReg[a7, a8]] - 
    CT[GReg[a1, a3, a4, a5, a8, a9], GReg[a2, a3]*GReg[a6, a8]*
      GReg[a7, a8]] + CT[GReg[a1, a3, a4, a5, a8, a9], 
     GReg[a2, a1]*GReg[a6, a7, a5]] - CT[GReg[a1, a3, a4, a5, a8, a9], 
     GReg[a2, a3]*GReg[a6, a7, a5]] - CT[GReg[a1, a3, a4, a5, a8, a9], 
     GReg[a2, a1]*GReg[a6, a7, a8]] + CT[GReg[a1, a3, a4, a5, a8, a9], 
     GReg[a2, a3]*GReg[a6, a7, a8]] + CT[GReg[a1, a3, a4, a6, a7, a9], 
     GReg[a2, a1]*GReg[a5, a4]*GReg[a8, a7]] - 
    CT[GReg[a1, a3, a4, a6, a7, a9], GReg[a2, a3]*GReg[a5, a4]*
      GReg[a8, a7]] - CT[GReg[a1, a3, a4, a6, a7, a9], 
     GReg[a2, a1]*GReg[a5, a6]*GReg[a8, a7]] + 
    CT[GReg[a1, a3, a4, a6, a7, a9], GReg[a2, a3]*GReg[a5, a6]*
      GReg[a8, a7]] + CT[GReg[a1, a3, a4, a6, a8, a9], 
     GReg[a2, a1]*GReg[a5, a4]*GReg[a7, a6]] - 
    CT[GReg[a1, a3, a4, a6, a8, a9], GReg[a2, a3]*GReg[a5, a4]*
      GReg[a7, a6]] - CT[GReg[a1, a3, a4, a6, a8, a9], 
     GReg[a2, a1]*GReg[a5, a6]*GReg[a7, a6]] + 
    CT[GReg[a1, a3, a4, a6, a8, a9], GReg[a2, a3]*GReg[a5, a6]*
      GReg[a7, a6]] - CT[GReg[a1, a3, a4, a6, a8, a9], 
     GReg[a2, a1]*GReg[a5, a4]*GReg[a7, a8]] + 
    CT[GReg[a1, a3, a4, a6, a8, a9], GReg[a2, a3]*GReg[a5, a4]*
      GReg[a7, a8]] + CT[GReg[a1, a3, a4, a6, a8, a9], 
     GReg[a2, a1]*GReg[a5, a6]*GReg[a7, a8]] - 
    CT[GReg[a1, a3, a4, a6, a8, a9], GReg[a2, a3]*GReg[a5, a6]*
      GReg[a7, a8]] - CT[GReg[a1, a3, a4, a7, a8, a9], 
     GReg[a2, a1]*GReg[a5, a4]*GReg[a6, a7]] + 
    CT[GReg[a1, a3, a4, a7, a8, a9], GReg[a2, a3]*GReg[a5, a4]*
      GReg[a6, a7]] + CT[GReg[a1, a3, a4, a7, a8, a9], 
     GReg[a2, a1]*GReg[a5, a7]*GReg[a6, a7]] - 
    CT[GReg[a1, a3, a4, a7, a8, a9], GReg[a2, a3]*GReg[a5, a7]*
      GReg[a6, a7]] + CT[GReg[a1, a3, a4, a7, a8, a9], 
     GReg[a2, a1]*GReg[a5, a6, a4]] - CT[GReg[a1, a3, a4, a7, a8, a9], 
     GReg[a2, a3]*GReg[a5, a6, a4]] - CT[GReg[a1, a3, a4, a7, a8, a9], 
     GReg[a2, a1]*GReg[a5, a6, a7]] + CT[GReg[a1, a3, a4, a7, a8, a9], 
     GReg[a2, a3]*GReg[a5, a6, a7]] + CT[GReg[a1, a3, a5, a6, a7, a9], 
     GReg[a2, a1]*GReg[a4, a3]*GReg[a8, a7]] - 
    CT[GReg[a1, a3, a5, a6, a7, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a8, a7]] - CT[GReg[a1, a3, a5, a6, a7, a9], 
     GReg[a2, a1]*GReg[a4, a5]*GReg[a8, a7]] + 
    CT[GReg[a1, a3, a5, a6, a7, a9], GReg[a2, a3]*GReg[a4, a5]*
      GReg[a8, a7]] + CT[GReg[a1, a3, a5, a6, a8, a9], 
     GReg[a2, a1]*GReg[a4, a3]*GReg[a7, a6]] - 
    CT[GReg[a1, a3, a5, a6, a8, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a7, a6]] - CT[GReg[a1, a3, a5, a6, a8, a9], 
     GReg[a2, a1]*GReg[a4, a5]*GReg[a7, a6]] + 
    CT[GReg[a1, a3, a5, a6, a8, a9], GReg[a2, a3]*GReg[a4, a5]*
      GReg[a7, a6]] - CT[GReg[a1, a3, a5, a6, a8, a9], 
     GReg[a2, a1]*GReg[a4, a3]*GReg[a7, a8]] + 
    CT[GReg[a1, a3, a5, a6, a8, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a7, a8]] + CT[GReg[a1, a3, a5, a6, a8, a9], 
     GReg[a2, a1]*GReg[a4, a5]*GReg[a7, a8]] - 
    CT[GReg[a1, a3, a5, a6, a8, a9], GReg[a2, a3]*GReg[a4, a5]*
      GReg[a7, a8]] + CT[GReg[a1, a3, a5, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a3]*GReg[a6, a5]] - 
    CT[GReg[a1, a3, a5, a7, a8, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a5]] - CT[GReg[a1, a3, a5, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a5]*GReg[a6, a5]] + 
    CT[GReg[a1, a3, a5, a7, a8, a9], GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a5]] - CT[GReg[a1, a3, a5, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a3]*GReg[a6, a7]] + 
    CT[GReg[a1, a3, a5, a7, a8, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a6, a7]] + CT[GReg[a1, a3, a5, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a5]*GReg[a6, a7]] - 
    CT[GReg[a1, a3, a5, a7, a8, a9], GReg[a2, a3]*GReg[a4, a5]*
      GReg[a6, a7]] - CT[GReg[a1, a3, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a3]*GReg[a5, a6]] + 
    CT[GReg[a1, a3, a6, a7, a8, a9], GReg[a2, a3]*GReg[a4, a3]*
      GReg[a5, a6]] + CT[GReg[a1, a3, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a6]*GReg[a5, a6]] - 
    CT[GReg[a1, a3, a6, a7, a8, a9], GReg[a2, a3]*GReg[a4, a6]*
      GReg[a5, a6]] + CT[GReg[a1, a3, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a5, a3]] - CT[GReg[a1, a3, a6, a7, a8, a9], 
     GReg[a2, a3]*GReg[a4, a5, a3]] - CT[GReg[a1, a3, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a5, a6]] + CT[GReg[a1, a3, a6, a7, a8, a9], 
     GReg[a2, a3]*GReg[a4, a5, a6]] - CT[GReg[a1, a4, a5, a6, a7, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a8, a7]] + 
    CT[GReg[a1, a4, a5, a6, a7, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a8, a7]] + CT[GReg[a1, a4, a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a2, a3, a1]] - CT[GReg[a1, a4, a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a2, a3, a4]] - CT[GReg[a1, a4, a5, a6, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a7, a6]] + 
    CT[GReg[a1, a4, a5, a6, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a7, a6]] + CT[GReg[a1, a4, a5, a6, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a7, a8]] - 
    CT[GReg[a1, a4, a5, a6, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a7, a8]] + CT[GReg[a1, a4, a5, a6, a8, a9], 
     GReg[a7, a6]*GReg[a2, a3, a1]] - CT[GReg[a1, a4, a5, a6, a8, a9], 
     GReg[a7, a8]*GReg[a2, a3, a1]] - CT[GReg[a1, a4, a5, a6, a8, a9], 
     GReg[a7, a6]*GReg[a2, a3, a4]] + CT[GReg[a1, a4, a5, a6, a8, a9], 
     GReg[a7, a8]*GReg[a2, a3, a4]] - CT[GReg[a1, a4, a5, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a6, a5]] + 
    CT[GReg[a1, a4, a5, a7, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a5]] + CT[GReg[a1, a4, a5, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a6, a7]] - 
    CT[GReg[a1, a4, a5, a7, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a6, a7]] + CT[GReg[a1, a4, a5, a7, a8, a9], 
     GReg[a6, a5]*GReg[a2, a3, a1]] - CT[GReg[a1, a4, a5, a7, a8, a9], 
     GReg[a6, a7]*GReg[a2, a3, a1]] - CT[GReg[a1, a4, a5, a7, a8, a9], 
     GReg[a6, a5]*GReg[a2, a3, a4]] + CT[GReg[a1, a4, a5, a7, a8, a9], 
     GReg[a6, a7]*GReg[a2, a3, a4]] - CT[GReg[a1, a4, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a4]] + 
    CT[GReg[a1, a4, a6, a7, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a4]] + CT[GReg[a1, a4, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4]*GReg[a5, a6]] - 
    CT[GReg[a1, a4, a6, a7, a8, a9], GReg[a2, a4]*GReg[a3, a4]*
      GReg[a5, a6]] + CT[GReg[a1, a4, a6, a7, a8, a9], 
     GReg[a5, a4]*GReg[a2, a3, a1]] - CT[GReg[a1, a4, a6, a7, a8, a9], 
     GReg[a5, a6]*GReg[a2, a3, a1]] - CT[GReg[a1, a4, a6, a7, a8, a9], 
     GReg[a5, a4]*GReg[a2, a3, a4]] + CT[GReg[a1, a4, a6, a7, a8, a9], 
     GReg[a5, a6]*GReg[a2, a3, a4]] + CT[GReg[a1, a5, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a5]*GReg[a4, a5]] - 
    CT[GReg[a1, a5, a6, a7, a8, a9], GReg[a2, a5]*GReg[a3, a5]*
      GReg[a4, a5]] - CT[GReg[a1, a5, a6, a7, a8, a9], 
     GReg[a4, a5]*GReg[a2, a3, a1]] + CT[GReg[a1, a5, a6, a7, a8, a9], 
     GReg[a4, a5]*GReg[a2, a3, a5]] - CT[GReg[a1, a5, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4, a5]] + CT[GReg[a1, a5, a6, a7, a8, a9], 
     GReg[a2, a5]*GReg[a3, a4, a5]] + CT[GReg[a1, a5, a6, a7, a8, a9], 
     GReg[a2, a3, a4, a1]] - CT[GReg[a1, a5, a6, a7, a8, a9], 
     GReg[a2, a3, a4, a5]] - CT[GReg[a2, a3, a4, a5, a6, a9], 
     GReg[a1, a2]*GReg[a7, a8, a6]] + CT[GReg[a2, a3, a4, a5, a6, a9], 
     GReg[a1, a9]*GReg[a7, a8, a6]] - CT[GReg[a2, a3, a4, a5, a7, a9], 
     GReg[a1, a2]*GReg[a6, a5]*GReg[a8, a7]] + 
    CT[GReg[a2, a3, a4, a5, a7, a9], GReg[a1, a9]*GReg[a6, a5]*
      GReg[a8, a7]] + CT[GReg[a2, a3, a4, a5, a7, a9], 
     GReg[a1, a2]*GReg[a6, a7]*GReg[a8, a7]] - 
    CT[GReg[a2, a3, a4, a5, a7, a9], GReg[a1, a9]*GReg[a6, a7]*
      GReg[a8, a7]] + CT[GReg[a2, a3, a4, a5, a8, a9], 
     GReg[a1, a2]*GReg[a6, a5]*GReg[a7, a8]] - 
    CT[GReg[a2, a3, a4, a5, a8, a9], GReg[a1, a9]*GReg[a6, a5]*
      GReg[a7, a8]] - CT[GReg[a2, a3, a4, a5, a8, a9], 
     GReg[a1, a2]*GReg[a6, a8]*GReg[a7, a8]] + 
    CT[GReg[a2, a3, a4, a5, a8, a9], GReg[a1, a9]*GReg[a6, a8]*
      GReg[a7, a8]] - CT[GReg[a2, a3, a4, a5, a8, a9], 
     GReg[a1, a2]*GReg[a6, a7, a5]] + CT[GReg[a2, a3, a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7, a5]] + CT[GReg[a2, a3, a4, a5, a8, a9], 
     GReg[a1, a2]*GReg[a6, a7, a8]] - CT[GReg[a2, a3, a4, a5, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7, a8]] - CT[GReg[a2, a3, a4, a6, a7, a9], 
     GReg[a1, a2]*GReg[a5, a4]*GReg[a8, a7]] + 
    CT[GReg[a2, a3, a4, a6, a7, a9], GReg[a1, a9]*GReg[a5, a4]*
      GReg[a8, a7]] + CT[GReg[a2, a3, a4, a6, a7, a9], 
     GReg[a1, a2]*GReg[a5, a6]*GReg[a8, a7]] - 
    CT[GReg[a2, a3, a4, a6, a7, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a8, a7]] - CT[GReg[a2, a3, a4, a6, a8, a9], 
     GReg[a1, a2]*GReg[a5, a4]*GReg[a7, a6]] + 
    CT[GReg[a2, a3, a4, a6, a8, a9], GReg[a1, a9]*GReg[a5, a4]*
      GReg[a7, a6]] + CT[GReg[a2, a3, a4, a6, a8, a9], 
     GReg[a1, a2]*GReg[a5, a6]*GReg[a7, a6]] - 
    CT[GReg[a2, a3, a4, a6, a8, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a7, a6]] + CT[GReg[a2, a3, a4, a6, a8, a9], 
     GReg[a1, a2]*GReg[a5, a4]*GReg[a7, a8]] - 
    CT[GReg[a2, a3, a4, a6, a8, a9], GReg[a1, a9]*GReg[a5, a4]*
      GReg[a7, a8]] - CT[GReg[a2, a3, a4, a6, a8, a9], 
     GReg[a1, a2]*GReg[a5, a6]*GReg[a7, a8]] + 
    CT[GReg[a2, a3, a4, a6, a8, a9], GReg[a1, a9]*GReg[a5, a6]*
      GReg[a7, a8]] + CT[GReg[a2, a3, a4, a7, a8, a9], 
     GReg[a1, a2]*GReg[a5, a4]*GReg[a6, a7]] - 
    CT[GReg[a2, a3, a4, a7, a8, a9], GReg[a1, a9]*GReg[a5, a4]*
      GReg[a6, a7]] - CT[GReg[a2, a3, a4, a7, a8, a9], 
     GReg[a1, a2]*GReg[a5, a7]*GReg[a6, a7]] + 
    CT[GReg[a2, a3, a4, a7, a8, a9], GReg[a1, a9]*GReg[a5, a7]*
      GReg[a6, a7]] - CT[GReg[a2, a3, a4, a7, a8, a9], 
     GReg[a1, a2]*GReg[a5, a6, a4]] + CT[GReg[a2, a3, a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a6, a4]] + CT[GReg[a2, a3, a4, a7, a8, a9], 
     GReg[a1, a2]*GReg[a5, a6, a7]] - CT[GReg[a2, a3, a4, a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a6, a7]] - CT[GReg[a2, a3, a5, a6, a7, a9], 
     GReg[a1, a2]*GReg[a4, a3]*GReg[a8, a7]] + 
    CT[GReg[a2, a3, a5, a6, a7, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a8, a7]] + CT[GReg[a2, a3, a5, a6, a7, a9], 
     GReg[a1, a2]*GReg[a4, a5]*GReg[a8, a7]] - 
    CT[GReg[a2, a3, a5, a6, a7, a9], GReg[a1, a9]*GReg[a4, a5]*
      GReg[a8, a7]] - CT[GReg[a2, a3, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a4, a3]*GReg[a7, a6]] + 
    CT[GReg[a2, a3, a5, a6, a8, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a7, a6]] + CT[GReg[a2, a3, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a4, a5]*GReg[a7, a6]] - 
    CT[GReg[a2, a3, a5, a6, a8, a9], GReg[a1, a9]*GReg[a4, a5]*
      GReg[a7, a6]] + CT[GReg[a2, a3, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a4, a3]*GReg[a7, a8]] - 
    CT[GReg[a2, a3, a5, a6, a8, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a7, a8]] - CT[GReg[a2, a3, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a4, a5]*GReg[a7, a8]] + 
    CT[GReg[a2, a3, a5, a6, a8, a9], GReg[a1, a9]*GReg[a4, a5]*
      GReg[a7, a8]] - CT[GReg[a2, a3, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a3]*GReg[a6, a5]] + 
    CT[GReg[a2, a3, a5, a7, a8, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a6, a5]] + CT[GReg[a2, a3, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a5]*GReg[a6, a5]] - 
    CT[GReg[a2, a3, a5, a7, a8, a9], GReg[a1, a9]*GReg[a4, a5]*
      GReg[a6, a5]] + CT[GReg[a2, a3, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a3]*GReg[a6, a7]] - 
    CT[GReg[a2, a3, a5, a7, a8, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a6, a7]] - CT[GReg[a2, a3, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a5]*GReg[a6, a7]] + 
    CT[GReg[a2, a3, a5, a7, a8, a9], GReg[a1, a9]*GReg[a4, a5]*
      GReg[a6, a7]] + CT[GReg[a2, a3, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a3]*GReg[a5, a6]] - 
    CT[GReg[a2, a3, a6, a7, a8, a9], GReg[a1, a9]*GReg[a4, a3]*
      GReg[a5, a6]] - CT[GReg[a2, a3, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a6]*GReg[a5, a6]] + 
    CT[GReg[a2, a3, a6, a7, a8, a9], GReg[a1, a9]*GReg[a4, a6]*
      GReg[a5, a6]] - CT[GReg[a2, a3, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a5, a3]] + CT[GReg[a2, a3, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a4, a5, a3]] + CT[GReg[a2, a3, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a5, a6]] - CT[GReg[a2, a3, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a4, a5, a6]] - CT[GReg[a2, a4, a5, a6, a7, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a8, a7]] + 
    CT[GReg[a2, a4, a5, a6, a7, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a8, a7]] + CT[GReg[a2, a4, a5, a6, a7, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a8, a7]] - 
    CT[GReg[a2, a4, a5, a6, a7, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a8, a7]] - CT[GReg[a2, a4, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a7, a6]] + 
    CT[GReg[a2, a4, a5, a6, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a7, a6]] + CT[GReg[a2, a4, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a7, a6]] - 
    CT[GReg[a2, a4, a5, a6, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a7, a6]] + CT[GReg[a2, a4, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a7, a8]] - 
    CT[GReg[a2, a4, a5, a6, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a7, a8]] - CT[GReg[a2, a4, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a7, a8]] + 
    CT[GReg[a2, a4, a5, a6, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a7, a8]] - CT[GReg[a2, a4, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a6, a5]] + 
    CT[GReg[a2, a4, a5, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a6, a5]] + CT[GReg[a2, a4, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a6, a5]] - 
    CT[GReg[a2, a4, a5, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a6, a5]] + CT[GReg[a2, a4, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a6, a7]] - 
    CT[GReg[a2, a4, a5, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a6, a7]] - CT[GReg[a2, a4, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a6, a7]] + 
    CT[GReg[a2, a4, a5, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a6, a7]] - CT[GReg[a2, a4, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a4]] + 
    CT[GReg[a2, a4, a6, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a5, a4]] + CT[GReg[a2, a4, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a4]] - 
    CT[GReg[a2, a4, a6, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a5, a4]] + CT[GReg[a2, a4, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a5, a6]] - 
    CT[GReg[a2, a4, a6, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a5, a6]] - CT[GReg[a2, a4, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]*GReg[a5, a6]] + 
    CT[GReg[a2, a4, a6, a7, a8, a9], GReg[a1, a9]*GReg[a3, a4]*
      GReg[a5, a6]] + CT[GReg[a2, a5, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]*GReg[a4, a5]] - 
    CT[GReg[a2, a5, a6, a7, a8, a9], GReg[a1, a9]*GReg[a3, a2]*
      GReg[a4, a5]] - CT[GReg[a2, a5, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a5]*GReg[a4, a5]] + 
    CT[GReg[a2, a5, a6, a7, a8, a9], GReg[a1, a9]*GReg[a3, a5]*
      GReg[a4, a5]] - CT[GReg[a2, a5, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4, a2]] + CT[GReg[a2, a5, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4, a2]] + CT[GReg[a2, a5, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4, a5]] - CT[GReg[a2, a5, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4, a5]] + CT[GReg[a3, a4, a5, a6, a7, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a8, a7]] - 
    CT[GReg[a3, a4, a5, a6, a7, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a8, a7]] - CT[GReg[a3, a4, a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a3]] + CT[GReg[a3, a4, a5, a6, a7, a9], 
     GReg[a8, a7]*GReg[a1, a2, a9]] + CT[GReg[a3, a4, a5, a6, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a7, a6]] - 
    CT[GReg[a3, a4, a5, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a7, a6]] - CT[GReg[a3, a4, a5, a6, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a7, a8]] + 
    CT[GReg[a3, a4, a5, a6, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a7, a8]] - CT[GReg[a3, a4, a5, a6, a8, a9], 
     GReg[a7, a6]*GReg[a1, a2, a3]] + CT[GReg[a3, a4, a5, a6, a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a3]] + CT[GReg[a3, a4, a5, a6, a8, a9], 
     GReg[a7, a6]*GReg[a1, a2, a9]] - CT[GReg[a3, a4, a5, a6, a8, a9], 
     GReg[a7, a8]*GReg[a1, a2, a9]] + CT[GReg[a3, a4, a5, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a5]] - 
    CT[GReg[a3, a4, a5, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a6, a5]] - CT[GReg[a3, a4, a5, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a6, a7]] + 
    CT[GReg[a3, a4, a5, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a6, a7]] - CT[GReg[a3, a4, a5, a7, a8, a9], 
     GReg[a6, a5]*GReg[a1, a2, a3]] + CT[GReg[a3, a4, a5, a7, a8, a9], 
     GReg[a6, a7]*GReg[a1, a2, a3]] + CT[GReg[a3, a4, a5, a7, a8, a9], 
     GReg[a6, a5]*GReg[a1, a2, a9]] - CT[GReg[a3, a4, a5, a7, a8, a9], 
     GReg[a6, a7]*GReg[a1, a2, a9]] + CT[GReg[a3, a4, a6, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a4]] - 
    CT[GReg[a3, a4, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a5, a4]] - CT[GReg[a3, a4, a6, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a5, a6]] + 
    CT[GReg[a3, a4, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a5, a6]] - CT[GReg[a3, a4, a6, a7, a8, a9], 
     GReg[a5, a4]*GReg[a1, a2, a3]] + CT[GReg[a3, a4, a6, a7, a8, a9], 
     GReg[a5, a6]*GReg[a1, a2, a3]] + CT[GReg[a3, a4, a6, a7, a8, a9], 
     GReg[a5, a4]*GReg[a1, a2, a9]] - CT[GReg[a3, a4, a6, a7, a8, a9], 
     GReg[a5, a6]*GReg[a1, a2, a9]] + CT[GReg[a3, a5, a6, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a3]] - 
    CT[GReg[a3, a5, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a3]] - CT[GReg[a3, a5, a6, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]*GReg[a4, a5]] + 
    CT[GReg[a3, a5, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a3]*
      GReg[a4, a5]] - CT[GReg[a3, a5, a6, a7, a8, a9], 
     GReg[a4, a3]*GReg[a1, a2, a3]] + CT[GReg[a3, a5, a6, a7, a8, a9], 
     GReg[a4, a5]*GReg[a1, a2, a3]] + CT[GReg[a3, a5, a6, a7, a8, a9], 
     GReg[a4, a3]*GReg[a1, a2, a9]] - CT[GReg[a3, a5, a6, a7, a8, a9], 
     GReg[a4, a5]*GReg[a1, a2, a9]] - CT[GReg[a4, a5, a6, a7, a8, a9], 
     GReg[a1, a4]*GReg[a2, a4]*GReg[a3, a4]] + 
    CT[GReg[a4, a5, a6, a7, a8, a9], GReg[a1, a9]*GReg[a2, a4]*
      GReg[a3, a4]] + CT[GReg[a4, a5, a6, a7, a8, a9], 
     GReg[a3, a4]*GReg[a1, a2, a4]] - CT[GReg[a4, a5, a6, a7, a8, a9], 
     GReg[a3, a4]*GReg[a1, a2, a9]] + CT[GReg[a4, a5, a6, a7, a8, a9], 
     GReg[a1, a4]*GReg[a2, a3, a4]] - CT[GReg[a4, a5, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3, a4]] - CT[GReg[a4, a5, a6, a7, a8, a9], 
     GReg[a1, a2, a3, a4]] + CT[GReg[a4, a5, a6, a7, a8, a9], 
     GReg[a1, a2, a3, a9]] + CT[GReg[a1, a2, a3, a4, a5, a6, a9], 
     GReg[a7, a8, a6]] + CT[GReg[a1, a2, a3, a4, a5, a7, a9], 
     GReg[a6, a5]*GReg[a8, a7]] - CT[GReg[a1, a2, a3, a4, a5, a7, a9], 
     GReg[a6, a7]*GReg[a8, a7]] - CT[GReg[a1, a2, a3, a4, a5, a8, a9], 
     GReg[a6, a5]*GReg[a7, a8]] + CT[GReg[a1, a2, a3, a4, a5, a8, a9], 
     GReg[a6, a8]*GReg[a7, a8]] + CT[GReg[a1, a2, a3, a4, a5, a8, a9], 
     GReg[a6, a7, a5]] - CT[GReg[a1, a2, a3, a4, a5, a8, a9], 
     GReg[a6, a7, a8]] + CT[GReg[a1, a2, a3, a4, a6, a7, a9], 
     GReg[a5, a4]*GReg[a8, a7]] - CT[GReg[a1, a2, a3, a4, a6, a7, a9], 
     GReg[a5, a6]*GReg[a8, a7]] + CT[GReg[a1, a2, a3, a4, a6, a8, a9], 
     GReg[a5, a4]*GReg[a7, a6]] - CT[GReg[a1, a2, a3, a4, a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a6]] - CT[GReg[a1, a2, a3, a4, a6, a8, a9], 
     GReg[a5, a4]*GReg[a7, a8]] + CT[GReg[a1, a2, a3, a4, a6, a8, a9], 
     GReg[a5, a6]*GReg[a7, a8]] - CT[GReg[a1, a2, a3, a4, a7, a8, a9], 
     GReg[a5, a4]*GReg[a6, a7]] + CT[GReg[a1, a2, a3, a4, a7, a8, a9], 
     GReg[a5, a7]*GReg[a6, a7]] + CT[GReg[a1, a2, a3, a4, a7, a8, a9], 
     GReg[a5, a6, a4]] - CT[GReg[a1, a2, a3, a4, a7, a8, a9], 
     GReg[a5, a6, a7]] + CT[GReg[a1, a2, a3, a5, a6, a7, a9], 
     GReg[a4, a3]*GReg[a8, a7]] - CT[GReg[a1, a2, a3, a5, a6, a7, a9], 
     GReg[a4, a5]*GReg[a8, a7]] + CT[GReg[a1, a2, a3, a5, a6, a8, a9], 
     GReg[a4, a3]*GReg[a7, a6]] - CT[GReg[a1, a2, a3, a5, a6, a8, a9], 
     GReg[a4, a5]*GReg[a7, a6]] - CT[GReg[a1, a2, a3, a5, a6, a8, a9], 
     GReg[a4, a3]*GReg[a7, a8]] + CT[GReg[a1, a2, a3, a5, a6, a8, a9], 
     GReg[a4, a5]*GReg[a7, a8]] + CT[GReg[a1, a2, a3, a5, a7, a8, a9], 
     GReg[a4, a3]*GReg[a6, a5]] - CT[GReg[a1, a2, a3, a5, a7, a8, a9], 
     GReg[a4, a5]*GReg[a6, a5]] - CT[GReg[a1, a2, a3, a5, a7, a8, a9], 
     GReg[a4, a3]*GReg[a6, a7]] + CT[GReg[a1, a2, a3, a5, a7, a8, a9], 
     GReg[a4, a5]*GReg[a6, a7]] - CT[GReg[a1, a2, a3, a6, a7, a8, a9], 
     GReg[a4, a3]*GReg[a5, a6]] + CT[GReg[a1, a2, a3, a6, a7, a8, a9], 
     GReg[a4, a6]*GReg[a5, a6]] + CT[GReg[a1, a2, a3, a6, a7, a8, a9], 
     GReg[a4, a5, a3]] - CT[GReg[a1, a2, a3, a6, a7, a8, a9], 
     GReg[a4, a5, a6]] + CT[GReg[a1, a2, a4, a5, a6, a7, a9], 
     GReg[a3, a2]*GReg[a8, a7]] - CT[GReg[a1, a2, a4, a5, a6, a7, a9], 
     GReg[a3, a4]*GReg[a8, a7]] + CT[GReg[a1, a2, a4, a5, a6, a8, a9], 
     GReg[a3, a2]*GReg[a7, a6]] - CT[GReg[a1, a2, a4, a5, a6, a8, a9], 
     GReg[a3, a4]*GReg[a7, a6]] - CT[GReg[a1, a2, a4, a5, a6, a8, a9], 
     GReg[a3, a2]*GReg[a7, a8]] + CT[GReg[a1, a2, a4, a5, a6, a8, a9], 
     GReg[a3, a4]*GReg[a7, a8]] + CT[GReg[a1, a2, a4, a5, a7, a8, a9], 
     GReg[a3, a2]*GReg[a6, a5]] - CT[GReg[a1, a2, a4, a5, a7, a8, a9], 
     GReg[a3, a4]*GReg[a6, a5]] - CT[GReg[a1, a2, a4, a5, a7, a8, a9], 
     GReg[a3, a2]*GReg[a6, a7]] + CT[GReg[a1, a2, a4, a5, a7, a8, a9], 
     GReg[a3, a4]*GReg[a6, a7]] + CT[GReg[a1, a2, a4, a6, a7, a8, a9], 
     GReg[a3, a2]*GReg[a5, a4]] - CT[GReg[a1, a2, a4, a6, a7, a8, a9], 
     GReg[a3, a4]*GReg[a5, a4]] - CT[GReg[a1, a2, a4, a6, a7, a8, a9], 
     GReg[a3, a2]*GReg[a5, a6]] + CT[GReg[a1, a2, a4, a6, a7, a8, a9], 
     GReg[a3, a4]*GReg[a5, a6]] - CT[GReg[a1, a2, a5, a6, a7, a8, a9], 
     GReg[a3, a2]*GReg[a4, a5]] + CT[GReg[a1, a2, a5, a6, a7, a8, a9], 
     GReg[a3, a5]*GReg[a4, a5]] + CT[GReg[a1, a2, a5, a6, a7, a8, a9], 
     GReg[a3, a4, a2]] - CT[GReg[a1, a2, a5, a6, a7, a8, a9], 
     GReg[a3, a4, a5]] + CT[GReg[a1, a3, a4, a5, a6, a7, a9], 
     GReg[a2, a1]*GReg[a8, a7]] - CT[GReg[a1, a3, a4, a5, a6, a7, a9], 
     GReg[a2, a3]*GReg[a8, a7]] + CT[GReg[a1, a3, a4, a5, a6, a8, a9], 
     GReg[a2, a1]*GReg[a7, a6]] - CT[GReg[a1, a3, a4, a5, a6, a8, a9], 
     GReg[a2, a3]*GReg[a7, a6]] - CT[GReg[a1, a3, a4, a5, a6, a8, a9], 
     GReg[a2, a1]*GReg[a7, a8]] + CT[GReg[a1, a3, a4, a5, a6, a8, a9], 
     GReg[a2, a3]*GReg[a7, a8]] + CT[GReg[a1, a3, a4, a5, a7, a8, a9], 
     GReg[a2, a1]*GReg[a6, a5]] - CT[GReg[a1, a3, a4, a5, a7, a8, a9], 
     GReg[a2, a3]*GReg[a6, a5]] - CT[GReg[a1, a3, a4, a5, a7, a8, a9], 
     GReg[a2, a1]*GReg[a6, a7]] + CT[GReg[a1, a3, a4, a5, a7, a8, a9], 
     GReg[a2, a3]*GReg[a6, a7]] + CT[GReg[a1, a3, a4, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a5, a4]] - CT[GReg[a1, a3, a4, a6, a7, a8, a9], 
     GReg[a2, a3]*GReg[a5, a4]] - CT[GReg[a1, a3, a4, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a5, a6]] + CT[GReg[a1, a3, a4, a6, a7, a8, a9], 
     GReg[a2, a3]*GReg[a5, a6]] + CT[GReg[a1, a3, a5, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a3]] - CT[GReg[a1, a3, a5, a6, a7, a8, a9], 
     GReg[a2, a3]*GReg[a4, a3]] - CT[GReg[a1, a3, a5, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a4, a5]] + CT[GReg[a1, a3, a5, a6, a7, a8, a9], 
     GReg[a2, a3]*GReg[a4, a5]] - CT[GReg[a1, a4, a5, a6, a7, a8, a9], 
     GReg[a2, a1]*GReg[a3, a4]] + CT[GReg[a1, a4, a5, a6, a7, a8, a9], 
     GReg[a2, a4]*GReg[a3, a4]] + CT[GReg[a1, a4, a5, a6, a7, a8, a9], 
     GReg[a2, a3, a1]] - CT[GReg[a1, a4, a5, a6, a7, a8, a9], 
     GReg[a2, a3, a4]] - CT[GReg[a2, a3, a4, a5, a6, a7, a9], 
     GReg[a1, a2]*GReg[a8, a7]] + CT[GReg[a2, a3, a4, a5, a6, a7, a9], 
     GReg[a1, a9]*GReg[a8, a7]] - CT[GReg[a2, a3, a4, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a7, a6]] + CT[GReg[a2, a3, a4, a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a6]] + CT[GReg[a2, a3, a4, a5, a6, a8, a9], 
     GReg[a1, a2]*GReg[a7, a8]] - CT[GReg[a2, a3, a4, a5, a6, a8, a9], 
     GReg[a1, a9]*GReg[a7, a8]] - CT[GReg[a2, a3, a4, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a6, a5]] + CT[GReg[a2, a3, a4, a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a5]] + CT[GReg[a2, a3, a4, a5, a7, a8, a9], 
     GReg[a1, a2]*GReg[a6, a7]] - CT[GReg[a2, a3, a4, a5, a7, a8, a9], 
     GReg[a1, a9]*GReg[a6, a7]] - CT[GReg[a2, a3, a4, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a5, a4]] + CT[GReg[a2, a3, a4, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a4]] + CT[GReg[a2, a3, a4, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a5, a6]] - CT[GReg[a2, a3, a4, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a5, a6]] - CT[GReg[a2, a3, a5, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a3]] + CT[GReg[a2, a3, a5, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a4, a3]] + CT[GReg[a2, a3, a5, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a4, a5]] - CT[GReg[a2, a3, a5, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a4, a5]] - CT[GReg[a2, a4, a5, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a2]] + CT[GReg[a2, a4, a5, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a2]] + CT[GReg[a2, a4, a5, a6, a7, a8, a9], 
     GReg[a1, a2]*GReg[a3, a4]] - CT[GReg[a2, a4, a5, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a3, a4]] + CT[GReg[a3, a4, a5, a6, a7, a8, a9], 
     GReg[a1, a3]*GReg[a2, a3]] - CT[GReg[a3, a4, a5, a6, a7, a8, a9], 
     GReg[a1, a9]*GReg[a2, a3]] - CT[GReg[a3, a4, a5, a6, a7, a8, a9], 
     GReg[a1, a2, a3]] + CT[GReg[a3, a4, a5, a6, a7, a8, a9], 
     GReg[a1, a2, a9]] + CT[GReg[a1, a2, a3, a4, a5, a6, a7, a9], 
     GReg[a8, a7]] + CT[GReg[a1, a2, a3, a4, a5, a6, a8, a9], GReg[a7, a6]] - 
    CT[GReg[a1, a2, a3, a4, a5, a6, a8, a9], GReg[a7, a8]] + 
    CT[GReg[a1, a2, a3, a4, a5, a7, a8, a9], GReg[a6, a5]] - 
    CT[GReg[a1, a2, a3, a4, a5, a7, a8, a9], GReg[a6, a7]] + 
    CT[GReg[a1, a2, a3, a4, a6, a7, a8, a9], GReg[a5, a4]] - 
    CT[GReg[a1, a2, a3, a4, a6, a7, a8, a9], GReg[a5, a6]] + 
    CT[GReg[a1, a2, a3, a5, a6, a7, a8, a9], GReg[a4, a3]] - 
    CT[GReg[a1, a2, a3, a5, a6, a7, a8, a9], GReg[a4, a5]] + 
    CT[GReg[a1, a2, a4, a5, a6, a7, a8, a9], GReg[a3, a2]] - 
    CT[GReg[a1, a2, a4, a5, a6, a7, a8, a9], GReg[a3, a4]] + 
    CT[GReg[a1, a3, a4, a5, a6, a7, a8, a9], GReg[a2, a1]] - 
    CT[GReg[a1, a3, a4, a5, a6, a7, a8, a9], GReg[a2, a3]] - 
    CT[GReg[a2, a3, a4, a5, a6, a7, a8, a9], GReg[a1, a2]] + 
    CT[GReg[a2, a3, a4, a5, a6, a7, a8, a9], GReg[a1, a9]] + 
    CT[GReg[a1, a2, a3, a4, a5, a6, a7, a8, a9], 1]
