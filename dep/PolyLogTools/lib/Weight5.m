(* ::Package:: *)

Weight5Tensor[x1_, x2_, x3_, x4_, x5_, x6_] := -CiTi[x1, x1 - x2, x2 - x3, x3 - x4, x4 - x5] + 
    CiTi[x1, x1 - x2, x2 - x3, x3 - x4, x5 - x6] - 
    CiTi[x1, x1 - x2, x2 - x3, x3 - x5, x3 - x4] + 
    CiTi[x1, x1 - x2, x2 - x3, x3 - x5, x4 - x5] + 
    CiTi[x1, x1 - x2, x2 - x3, x4 - x6, x4 - x5] - 
    CiTi[x1, x1 - x2, x2 - x3, x4 - x6, x5 - x6] + 
    CiTi[x1, x1 - x2, x2 - x3, x5 - x6, x3 - x4] - 
    CiTi[x1, x1 - x2, x2 - x3, x5 - x6, x4 - x5] - 
    CiTi[x1, x1 - x2, x2 - x4, x2 - x3, x4 - x5] + 
    CiTi[x1, x1 - x2, x2 - x4, x2 - x3, x5 - x6] + 
    CiTi[x1, x1 - x2, x2 - x4, x3 - x4, x4 - x5] - 
    CiTi[x1, x1 - x2, x2 - x4, x3 - x4, x5 - x6] - 
    CiTi[x1, x1 - x2, x2 - x4, x4 - x5, x2 - x3] + 
    CiTi[x1, x1 - x2, x2 - x4, x4 - x5, x3 - x4] + 
    CiTi[x1, x1 - x2, x2 - x4, x5 - x6, x2 - x3] - 
    CiTi[x1, x1 - x2, x2 - x4, x5 - x6, x3 - x4] - 
    CiTi[x1, x1 - x2, x2 - x5, x2 - x3, x3 - x4] + 
    CiTi[x1, x1 - x2, x2 - x5, x2 - x3, x4 - x5] - 
    CiTi[x1, x1 - x2, x2 - x5, x2 - x4, x2 - x3] + 
    CiTi[x1, x1 - x2, x2 - x5, x2 - x4, x3 - x4] + 
    CiTi[x1, x1 - x2, x2 - x5, x3 - x5, x3 - x4] - 
    CiTi[x1, x1 - x2, x2 - x5, x3 - x5, x4 - x5] + 
    CiTi[x1, x1 - x2, x2 - x5, x4 - x5, x2 - x3] - 
    CiTi[x1, x1 - x2, x2 - x5, x4 - x5, x3 - x4] + 
    CiTi[x1, x1 - x2, x3 - x6, x3 - x4, x4 - x5] - 
    CiTi[x1, x1 - x2, x3 - x6, x3 - x4, x5 - x6] + 
    CiTi[x1, x1 - x2, x3 - x6, x3 - x5, x3 - x4] - 
    CiTi[x1, x1 - x2, x3 - x6, x3 - x5, x4 - x5] - 
    CiTi[x1, x1 - x2, x3 - x6, x4 - x6, x4 - x5] + 
    CiTi[x1, x1 - x2, x3 - x6, x4 - x6, x5 - x6] - 
    CiTi[x1, x1 - x2, x3 - x6, x5 - x6, x3 - x4] + 
    CiTi[x1, x1 - x2, x3 - x6, x5 - x6, x4 - x5] + 
    CiTi[x1, x1 - x2, x4 - x6, x2 - x3, x4 - x5] - 
    CiTi[x1, x1 - x2, x4 - x6, x2 - x3, x5 - x6] - 
    CiTi[x1, x1 - x2, x4 - x6, x3 - x4, x4 - x5] + 
    CiTi[x1, x1 - x2, x4 - x6, x3 - x4, x5 - x6] + 
    CiTi[x1, x1 - x2, x4 - x6, x4 - x5, x2 - x3] - 
    CiTi[x1, x1 - x2, x4 - x6, x4 - x5, x3 - x4] - 
    CiTi[x1, x1 - x2, x4 - x6, x5 - x6, x2 - x3] + 
    CiTi[x1, x1 - x2, x4 - x6, x5 - x6, x3 - x4] + 
    CiTi[x1, x1 - x2, x5 - x6, x2 - x3, x3 - x4] - 
    CiTi[x1, x1 - x2, x5 - x6, x2 - x3, x4 - x5] + 
    CiTi[x1, x1 - x2, x5 - x6, x2 - x4, x2 - x3] - 
    CiTi[x1, x1 - x2, x5 - x6, x2 - x4, x3 - x4] - 
    CiTi[x1, x1 - x2, x5 - x6, x3 - x5, x3 - x4] + 
    CiTi[x1, x1 - x2, x5 - x6, x3 - x5, x4 - x5] - 
    CiTi[x1, x1 - x2, x5 - x6, x4 - x5, x2 - x3] + 
    CiTi[x1, x1 - x2, x5 - x6, x4 - x5, x3 - x4] - 
    CiTi[x1, x1 - x3, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x1, x1 - x3, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x1, x1 - x3, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x1, x1 - x3, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x1, x1 - x3, x1 - x2, x4 - x6, x4 - x5] - 
    CiTi[x1, x1 - x3, x1 - x2, x4 - x6, x5 - x6] + 
    CiTi[x1, x1 - x3, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x1, x1 - x3, x1 - x2, x5 - x6, x4 - x5] + 
    CiTi[x1, x1 - x3, x2 - x3, x3 - x4, x4 - x5] - 
    CiTi[x1, x1 - x3, x2 - x3, x3 - x4, x5 - x6] + 
    CiTi[x1, x1 - x3, x2 - x3, x3 - x5, x3 - x4] - 
    CiTi[x1, x1 - x3, x2 - x3, x3 - x5, x4 - x5] - 
    CiTi[x1, x1 - x3, x2 - x3, x4 - x6, x4 - x5] + 
    CiTi[x1, x1 - x3, x2 - x3, x4 - x6, x5 - x6] - 
    CiTi[x1, x1 - x3, x2 - x3, x5 - x6, x3 - x4] + 
    CiTi[x1, x1 - x3, x2 - x3, x5 - x6, x4 - x5] - 
    CiTi[x1, x1 - x3, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x1, x1 - x3, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x1, x1 - x3, x3 - x4, x2 - x3, x4 - x5] - 
    CiTi[x1, x1 - x3, x3 - x4, x2 - x3, x5 - x6] - 
    CiTi[x1, x1 - x3, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x1, x1 - x3, x3 - x4, x4 - x5, x2 - x3] + 
    CiTi[x1, x1 - x3, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x1, x1 - x3, x3 - x4, x5 - x6, x2 - x3] - 
    CiTi[x1, x1 - x3, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x1, x1 - x3, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x1, x1 - x3, x3 - x5, x2 - x3, x3 - x4] - 
    CiTi[x1, x1 - x3, x3 - x5, x2 - x3, x4 - x5] - 
    CiTi[x1, x1 - x3, x3 - x5, x3 - x4, x1 - x2] + 
    CiTi[x1, x1 - x3, x3 - x5, x3 - x4, x2 - x3] + 
    CiTi[x1, x1 - x3, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x1, x1 - x3, x3 - x5, x4 - x5, x2 - x3] + 
    CiTi[x1, x1 - x3, x4 - x6, x1 - x2, x4 - x5] - 
    CiTi[x1, x1 - x3, x4 - x6, x1 - x2, x5 - x6] - 
    CiTi[x1, x1 - x3, x4 - x6, x2 - x3, x4 - x5] + 
    CiTi[x1, x1 - x3, x4 - x6, x2 - x3, x5 - x6] + 
    CiTi[x1, x1 - x3, x4 - x6, x4 - x5, x1 - x2] - 
    CiTi[x1, x1 - x3, x4 - x6, x4 - x5, x2 - x3] - 
    CiTi[x1, x1 - x3, x4 - x6, x5 - x6, x1 - x2] + 
    CiTi[x1, x1 - x3, x4 - x6, x5 - x6, x2 - x3] + 
    CiTi[x1, x1 - x3, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x1, x1 - x3, x5 - x6, x1 - x2, x4 - x5] - 
    CiTi[x1, x1 - x3, x5 - x6, x2 - x3, x3 - x4] + 
    CiTi[x1, x1 - x3, x5 - x6, x2 - x3, x4 - x5] + 
    CiTi[x1, x1 - x3, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x1, x1 - x3, x5 - x6, x3 - x4, x2 - x3] - 
    CiTi[x1, x1 - x3, x5 - x6, x4 - x5, x1 - x2] + 
    CiTi[x1, x1 - x3, x5 - x6, x4 - x5, x2 - x3] - 
    CiTi[x1, x1 - x4, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x1, x1 - x4, x1 - x2, x2 - x3, x5 - x6] + 
    CiTi[x1, x1 - x4, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x1, x1 - x4, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x1, x1 - x4, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x1, x1 - x4, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x1, x1 - x4, x1 - x2, x5 - x6, x2 - x3] - 
    CiTi[x1, x1 - x4, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x1, x1 - x4, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x1, x1 - x4, x1 - x3, x1 - x2, x5 - x6] + 
    CiTi[x1, x1 - x4, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x1, x1 - x4, x1 - x3, x2 - x3, x5 - x6] - 
    CiTi[x1, x1 - x4, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x1, x1 - x4, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x1, x1 - x4, x1 - x3, x5 - x6, x1 - x2] - 
    CiTi[x1, x1 - x4, x1 - x3, x5 - x6, x2 - x3] + 
    CiTi[x1, x1 - x4, x2 - x4, x2 - x3, x4 - x5] - 
    CiTi[x1, x1 - x4, x2 - x4, x2 - x3, x5 - x6] - 
    CiTi[x1, x1 - x4, x2 - x4, x3 - x4, x4 - x5] + 
    CiTi[x1, x1 - x4, x2 - x4, x3 - x4, x5 - x6] + 
    CiTi[x1, x1 - x4, x2 - x4, x4 - x5, x2 - x3] - 
    CiTi[x1, x1 - x4, x2 - x4, x4 - x5, x3 - x4] - 
    CiTi[x1, x1 - x4, x2 - x4, x5 - x6, x2 - x3] + 
    CiTi[x1, x1 - x4, x2 - x4, x5 - x6, x3 - x4] + 
    CiTi[x1, x1 - x4, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x1, x1 - x4, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x1, x1 - x4, x3 - x4, x2 - x3, x4 - x5] + 
    CiTi[x1, x1 - x4, x3 - x4, x2 - x3, x5 - x6] + 
    CiTi[x1, x1 - x4, x3 - x4, x4 - x5, x1 - x2] - 
    CiTi[x1, x1 - x4, x3 - x4, x4 - x5, x2 - x3] - 
    CiTi[x1, x1 - x4, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x1, x1 - x4, x3 - x4, x5 - x6, x2 - x3] - 
    CiTi[x1, x1 - x4, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x1, x1 - x4, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x1, x1 - x4, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x1, x1 - x4, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x1, x1 - x4, x4 - x5, x2 - x4, x2 - x3] - 
    CiTi[x1, x1 - x4, x4 - x5, x2 - x4, x3 - x4] + 
    CiTi[x1, x1 - x4, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x1, x1 - x4, x4 - x5, x3 - x4, x2 - x3] + 
    CiTi[x1, x1 - x4, x5 - x6, x1 - x2, x2 - x3] - 
    CiTi[x1, x1 - x4, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x1, x1 - x4, x5 - x6, x1 - x3, x1 - x2] - 
    CiTi[x1, x1 - x4, x5 - x6, x1 - x3, x2 - x3] - 
    CiTi[x1, x1 - x4, x5 - x6, x2 - x4, x2 - x3] + 
    CiTi[x1, x1 - x4, x5 - x6, x2 - x4, x3 - x4] - 
    CiTi[x1, x1 - x4, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x1, x1 - x4, x5 - x6, x3 - x4, x2 - x3] - 
    CiTi[x1, x1 - x5, x1 - x2, x2 - x3, x3 - x4] + 
    CiTi[x1, x1 - x5, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x1, x1 - x5, x1 - x2, x2 - x4, x2 - x3] + 
    CiTi[x1, x1 - x5, x1 - x2, x2 - x4, x3 - x4] + 
    CiTi[x1, x1 - x5, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x1, x1 - x5, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x1, x1 - x5, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x1, x1 - x5, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x1, x1 - x5, x1 - x3, x1 - x2, x3 - x4] + 
    CiTi[x1, x1 - x5, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x1, x1 - x5, x1 - x3, x2 - x3, x3 - x4] - 
    CiTi[x1, x1 - x5, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x1, x1 - x5, x1 - x3, x3 - x4, x1 - x2] + 
    CiTi[x1, x1 - x5, x1 - x3, x3 - x4, x2 - x3] + 
    CiTi[x1, x1 - x5, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x1, x1 - x5, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x1, x1 - x5, x1 - x4, x1 - x2, x2 - x3] + 
    CiTi[x1, x1 - x5, x1 - x4, x1 - x2, x3 - x4] - 
    CiTi[x1, x1 - x5, x1 - x4, x1 - x3, x1 - x2] + 
    CiTi[x1, x1 - x5, x1 - x4, x1 - x3, x2 - x3] + 
    CiTi[x1, x1 - x5, x1 - x4, x2 - x4, x2 - x3] - 
    CiTi[x1, x1 - x5, x1 - x4, x2 - x4, x3 - x4] + 
    CiTi[x1, x1 - x5, x1 - x4, x3 - x4, x1 - x2] - 
    CiTi[x1, x1 - x5, x1 - x4, x3 - x4, x2 - x3] + 
    CiTi[x1, x1 - x5, x2 - x5, x2 - x3, x3 - x4] - 
    CiTi[x1, x1 - x5, x2 - x5, x2 - x3, x4 - x5] + 
    CiTi[x1, x1 - x5, x2 - x5, x2 - x4, x2 - x3] - 
    CiTi[x1, x1 - x5, x2 - x5, x2 - x4, x3 - x4] - 
    CiTi[x1, x1 - x5, x2 - x5, x3 - x5, x3 - x4] + 
    CiTi[x1, x1 - x5, x2 - x5, x3 - x5, x4 - x5] - 
    CiTi[x1, x1 - x5, x2 - x5, x4 - x5, x2 - x3] + 
    CiTi[x1, x1 - x5, x2 - x5, x4 - x5, x3 - x4] + 
    CiTi[x1, x1 - x5, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x1, x1 - x5, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x1, x1 - x5, x3 - x5, x2 - x3, x3 - x4] + 
    CiTi[x1, x1 - x5, x3 - x5, x2 - x3, x4 - x5] + 
    CiTi[x1, x1 - x5, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x1, x1 - x5, x3 - x5, x3 - x4, x2 - x3] - 
    CiTi[x1, x1 - x5, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x1, x1 - x5, x3 - x5, x4 - x5, x2 - x3] + 
    CiTi[x1, x1 - x5, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x1, x1 - x5, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x1, x1 - x5, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x1, x1 - x5, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x1, x1 - x5, x4 - x5, x2 - x4, x2 - x3] + 
    CiTi[x1, x1 - x5, x4 - x5, x2 - x4, x3 - x4] - 
    CiTi[x1, x1 - x5, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x1, x1 - x5, x4 - x5, x3 - x4, x2 - x3] + 
    CiTi[x1, x2 - x6, x2 - x3, x3 - x4, x4 - x5] - 
    CiTi[x1, x2 - x6, x2 - x3, x3 - x4, x5 - x6] + 
    CiTi[x1, x2 - x6, x2 - x3, x3 - x5, x3 - x4] - 
    CiTi[x1, x2 - x6, x2 - x3, x3 - x5, x4 - x5] - 
    CiTi[x1, x2 - x6, x2 - x3, x4 - x6, x4 - x5] + 
    CiTi[x1, x2 - x6, x2 - x3, x4 - x6, x5 - x6] - 
    CiTi[x1, x2 - x6, x2 - x3, x5 - x6, x3 - x4] + 
    CiTi[x1, x2 - x6, x2 - x3, x5 - x6, x4 - x5] + 
    CiTi[x1, x2 - x6, x2 - x4, x2 - x3, x4 - x5] - 
    CiTi[x1, x2 - x6, x2 - x4, x2 - x3, x5 - x6] - 
    CiTi[x1, x2 - x6, x2 - x4, x3 - x4, x4 - x5] + 
    CiTi[x1, x2 - x6, x2 - x4, x3 - x4, x5 - x6] + 
    CiTi[x1, x2 - x6, x2 - x4, x4 - x5, x2 - x3] - 
    CiTi[x1, x2 - x6, x2 - x4, x4 - x5, x3 - x4] - 
    CiTi[x1, x2 - x6, x2 - x4, x5 - x6, x2 - x3] + 
    CiTi[x1, x2 - x6, x2 - x4, x5 - x6, x3 - x4] + 
    CiTi[x1, x2 - x6, x2 - x5, x2 - x3, x3 - x4] - 
    CiTi[x1, x2 - x6, x2 - x5, x2 - x3, x4 - x5] + 
    CiTi[x1, x2 - x6, x2 - x5, x2 - x4, x2 - x3] - 
    CiTi[x1, x2 - x6, x2 - x5, x2 - x4, x3 - x4] - 
    CiTi[x1, x2 - x6, x2 - x5, x3 - x5, x3 - x4] + 
    CiTi[x1, x2 - x6, x2 - x5, x3 - x5, x4 - x5] - 
    CiTi[x1, x2 - x6, x2 - x5, x4 - x5, x2 - x3] + 
    CiTi[x1, x2 - x6, x2 - x5, x4 - x5, x3 - x4] - 
    CiTi[x1, x2 - x6, x3 - x6, x3 - x4, x4 - x5] + 
    CiTi[x1, x2 - x6, x3 - x6, x3 - x4, x5 - x6] - 
    CiTi[x1, x2 - x6, x3 - x6, x3 - x5, x3 - x4] + 
    CiTi[x1, x2 - x6, x3 - x6, x3 - x5, x4 - x5] + 
    CiTi[x1, x2 - x6, x3 - x6, x4 - x6, x4 - x5] - 
    CiTi[x1, x2 - x6, x3 - x6, x4 - x6, x5 - x6] + 
    CiTi[x1, x2 - x6, x3 - x6, x5 - x6, x3 - x4] - 
    CiTi[x1, x2 - x6, x3 - x6, x5 - x6, x4 - x5] - 
    CiTi[x1, x2 - x6, x4 - x6, x2 - x3, x4 - x5] + 
    CiTi[x1, x2 - x6, x4 - x6, x2 - x3, x5 - x6] + 
    CiTi[x1, x2 - x6, x4 - x6, x3 - x4, x4 - x5] - 
    CiTi[x1, x2 - x6, x4 - x6, x3 - x4, x5 - x6] - 
    CiTi[x1, x2 - x6, x4 - x6, x4 - x5, x2 - x3] + 
    CiTi[x1, x2 - x6, x4 - x6, x4 - x5, x3 - x4] + 
    CiTi[x1, x2 - x6, x4 - x6, x5 - x6, x2 - x3] - 
    CiTi[x1, x2 - x6, x4 - x6, x5 - x6, x3 - x4] - 
    CiTi[x1, x2 - x6, x5 - x6, x2 - x3, x3 - x4] + 
    CiTi[x1, x2 - x6, x5 - x6, x2 - x3, x4 - x5] - 
    CiTi[x1, x2 - x6, x5 - x6, x2 - x4, x2 - x3] + 
    CiTi[x1, x2 - x6, x5 - x6, x2 - x4, x3 - x4] + 
    CiTi[x1, x2 - x6, x5 - x6, x3 - x5, x3 - x4] - 
    CiTi[x1, x2 - x6, x5 - x6, x3 - x5, x4 - x5] + 
    CiTi[x1, x2 - x6, x5 - x6, x4 - x5, x2 - x3] - 
    CiTi[x1, x2 - x6, x5 - x6, x4 - x5, x3 - x4] + 
    CiTi[x1, x3 - x6, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x1, x3 - x6, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x1, x3 - x6, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x1, x3 - x6, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x1, x3 - x6, x1 - x2, x4 - x6, x4 - x5] + 
    CiTi[x1, x3 - x6, x1 - x2, x4 - x6, x5 - x6] - 
    CiTi[x1, x3 - x6, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x1, x3 - x6, x1 - x2, x5 - x6, x4 - x5] - 
    CiTi[x1, x3 - x6, x2 - x3, x3 - x4, x4 - x5] + 
    CiTi[x1, x3 - x6, x2 - x3, x3 - x4, x5 - x6] - 
    CiTi[x1, x3 - x6, x2 - x3, x3 - x5, x3 - x4] + 
    CiTi[x1, x3 - x6, x2 - x3, x3 - x5, x4 - x5] + 
    CiTi[x1, x3 - x6, x2 - x3, x4 - x6, x4 - x5] - 
    CiTi[x1, x3 - x6, x2 - x3, x4 - x6, x5 - x6] + 
    CiTi[x1, x3 - x6, x2 - x3, x5 - x6, x3 - x4] - 
    CiTi[x1, x3 - x6, x2 - x3, x5 - x6, x4 - x5] + 
    CiTi[x1, x3 - x6, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x1, x3 - x6, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x1, x3 - x6, x3 - x4, x2 - x3, x4 - x5] + 
    CiTi[x1, x3 - x6, x3 - x4, x2 - x3, x5 - x6] + 
    CiTi[x1, x3 - x6, x3 - x4, x4 - x5, x1 - x2] - 
    CiTi[x1, x3 - x6, x3 - x4, x4 - x5, x2 - x3] - 
    CiTi[x1, x3 - x6, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x1, x3 - x6, x3 - x4, x5 - x6, x2 - x3] + 
    CiTi[x1, x3 - x6, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x1, x3 - x6, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x1, x3 - x6, x3 - x5, x2 - x3, x3 - x4] + 
    CiTi[x1, x3 - x6, x3 - x5, x2 - x3, x4 - x5] + 
    CiTi[x1, x3 - x6, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x1, x3 - x6, x3 - x5, x3 - x4, x2 - x3] - 
    CiTi[x1, x3 - x6, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x1, x3 - x6, x3 - x5, x4 - x5, x2 - x3] - 
    CiTi[x1, x3 - x6, x4 - x6, x1 - x2, x4 - x5] + 
    CiTi[x1, x3 - x6, x4 - x6, x1 - x2, x5 - x6] + 
    CiTi[x1, x3 - x6, x4 - x6, x2 - x3, x4 - x5] - 
    CiTi[x1, x3 - x6, x4 - x6, x2 - x3, x5 - x6] - 
    CiTi[x1, x3 - x6, x4 - x6, x4 - x5, x1 - x2] + 
    CiTi[x1, x3 - x6, x4 - x6, x4 - x5, x2 - x3] + 
    CiTi[x1, x3 - x6, x4 - x6, x5 - x6, x1 - x2] - 
    CiTi[x1, x3 - x6, x4 - x6, x5 - x6, x2 - x3] - 
    CiTi[x1, x3 - x6, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x1, x3 - x6, x5 - x6, x1 - x2, x4 - x5] + 
    CiTi[x1, x3 - x6, x5 - x6, x2 - x3, x3 - x4] - 
    CiTi[x1, x3 - x6, x5 - x6, x2 - x3, x4 - x5] - 
    CiTi[x1, x3 - x6, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x1, x3 - x6, x5 - x6, x3 - x4, x2 - x3] + 
    CiTi[x1, x3 - x6, x5 - x6, x4 - x5, x1 - x2] - 
    CiTi[x1, x3 - x6, x5 - x6, x4 - x5, x2 - x3] + 
    CiTi[x1, x4 - x6, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x1, x4 - x6, x1 - x2, x2 - x3, x5 - x6] - 
    CiTi[x1, x4 - x6, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x1, x4 - x6, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x1, x4 - x6, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x1, x4 - x6, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x1, x4 - x6, x1 - x2, x5 - x6, x2 - x3] + 
    CiTi[x1, x4 - x6, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x1, x4 - x6, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x1, x4 - x6, x1 - x3, x1 - x2, x5 - x6] - 
    CiTi[x1, x4 - x6, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x1, x4 - x6, x1 - x3, x2 - x3, x5 - x6] + 
    CiTi[x1, x4 - x6, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x1, x4 - x6, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x1, x4 - x6, x1 - x3, x5 - x6, x1 - x2] + 
    CiTi[x1, x4 - x6, x1 - x3, x5 - x6, x2 - x3] - 
    CiTi[x1, x4 - x6, x2 - x4, x2 - x3, x4 - x5] + 
    CiTi[x1, x4 - x6, x2 - x4, x2 - x3, x5 - x6] + 
    CiTi[x1, x4 - x6, x2 - x4, x3 - x4, x4 - x5] - 
    CiTi[x1, x4 - x6, x2 - x4, x3 - x4, x5 - x6] - 
    CiTi[x1, x4 - x6, x2 - x4, x4 - x5, x2 - x3] + 
    CiTi[x1, x4 - x6, x2 - x4, x4 - x5, x3 - x4] + 
    CiTi[x1, x4 - x6, x2 - x4, x5 - x6, x2 - x3] - 
    CiTi[x1, x4 - x6, x2 - x4, x5 - x6, x3 - x4] - 
    CiTi[x1, x4 - x6, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x1, x4 - x6, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x1, x4 - x6, x3 - x4, x2 - x3, x4 - x5] - 
    CiTi[x1, x4 - x6, x3 - x4, x2 - x3, x5 - x6] - 
    CiTi[x1, x4 - x6, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x1, x4 - x6, x3 - x4, x4 - x5, x2 - x3] + 
    CiTi[x1, x4 - x6, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x1, x4 - x6, x3 - x4, x5 - x6, x2 - x3] + 
    CiTi[x1, x4 - x6, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x1, x4 - x6, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x1, x4 - x6, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x1, x4 - x6, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x1, x4 - x6, x4 - x5, x2 - x4, x2 - x3] + 
    CiTi[x1, x4 - x6, x4 - x5, x2 - x4, x3 - x4] - 
    CiTi[x1, x4 - x6, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x1, x4 - x6, x4 - x5, x3 - x4, x2 - x3] - 
    CiTi[x1, x4 - x6, x5 - x6, x1 - x2, x2 - x3] + 
    CiTi[x1, x4 - x6, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x1, x4 - x6, x5 - x6, x1 - x3, x1 - x2] + 
    CiTi[x1, x4 - x6, x5 - x6, x1 - x3, x2 - x3] + 
    CiTi[x1, x4 - x6, x5 - x6, x2 - x4, x2 - x3] - 
    CiTi[x1, x4 - x6, x5 - x6, x2 - x4, x3 - x4] + 
    CiTi[x1, x4 - x6, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x1, x4 - x6, x5 - x6, x3 - x4, x2 - x3] + 
    CiTi[x1, x5 - x6, x1 - x2, x2 - x3, x3 - x4] - 
    CiTi[x1, x5 - x6, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x1, x5 - x6, x1 - x2, x2 - x4, x2 - x3] - 
    CiTi[x1, x5 - x6, x1 - x2, x2 - x4, x3 - x4] - 
    CiTi[x1, x5 - x6, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x1, x5 - x6, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x1, x5 - x6, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x1, x5 - x6, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x1, x5 - x6, x1 - x3, x1 - x2, x3 - x4] - 
    CiTi[x1, x5 - x6, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x1, x5 - x6, x1 - x3, x2 - x3, x3 - x4] + 
    CiTi[x1, x5 - x6, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x1, x5 - x6, x1 - x3, x3 - x4, x1 - x2] - 
    CiTi[x1, x5 - x6, x1 - x3, x3 - x4, x2 - x3] - 
    CiTi[x1, x5 - x6, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x1, x5 - x6, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x1, x5 - x6, x1 - x4, x1 - x2, x2 - x3] - 
    CiTi[x1, x5 - x6, x1 - x4, x1 - x2, x3 - x4] + 
    CiTi[x1, x5 - x6, x1 - x4, x1 - x3, x1 - x2] - 
    CiTi[x1, x5 - x6, x1 - x4, x1 - x3, x2 - x3] - 
    CiTi[x1, x5 - x6, x1 - x4, x2 - x4, x2 - x3] + 
    CiTi[x1, x5 - x6, x1 - x4, x2 - x4, x3 - x4] - 
    CiTi[x1, x5 - x6, x1 - x4, x3 - x4, x1 - x2] + 
    CiTi[x1, x5 - x6, x1 - x4, x3 - x4, x2 - x3] - 
    CiTi[x1, x5 - x6, x2 - x5, x2 - x3, x3 - x4] + 
    CiTi[x1, x5 - x6, x2 - x5, x2 - x3, x4 - x5] - 
    CiTi[x1, x5 - x6, x2 - x5, x2 - x4, x2 - x3] + 
    CiTi[x1, x5 - x6, x2 - x5, x2 - x4, x3 - x4] + 
    CiTi[x1, x5 - x6, x2 - x5, x3 - x5, x3 - x4] - 
    CiTi[x1, x5 - x6, x2 - x5, x3 - x5, x4 - x5] + 
    CiTi[x1, x5 - x6, x2 - x5, x4 - x5, x2 - x3] - 
    CiTi[x1, x5 - x6, x2 - x5, x4 - x5, x3 - x4] - 
    CiTi[x1, x5 - x6, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x1, x5 - x6, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x1, x5 - x6, x3 - x5, x2 - x3, x3 - x4] - 
    CiTi[x1, x5 - x6, x3 - x5, x2 - x3, x4 - x5] - 
    CiTi[x1, x5 - x6, x3 - x5, x3 - x4, x1 - x2] + 
    CiTi[x1, x5 - x6, x3 - x5, x3 - x4, x2 - x3] + 
    CiTi[x1, x5 - x6, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x1, x5 - x6, x3 - x5, x4 - x5, x2 - x3] - 
    CiTi[x1, x5 - x6, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x1, x5 - x6, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x1, x5 - x6, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x1, x5 - x6, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x1, x5 - x6, x4 - x5, x2 - x4, x2 - x3] - 
    CiTi[x1, x5 - x6, x4 - x5, x2 - x4, x3 - x4] + 
    CiTi[x1, x5 - x6, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x1, x5 - x6, x4 - x5, x3 - x4, x2 - x3] - 
    CiTi[x2, x1, x2 - x3, x3 - x4, x4 - x5] + CiTi[x2, x1, x2 - x3, x3 - x4, 
     x5 - x6] - CiTi[x2, x1, x2 - x3, x3 - x5, x3 - x4] + 
    CiTi[x2, x1, x2 - x3, x3 - x5, x4 - x5] + CiTi[x2, x1, x2 - x3, x4 - x6, 
     x4 - x5] - CiTi[x2, x1, x2 - x3, x4 - x6, x5 - x6] + 
    CiTi[x2, x1, x2 - x3, x5 - x6, x3 - x4] - CiTi[x2, x1, x2 - x3, x5 - x6, 
     x4 - x5] - CiTi[x2, x1, x2 - x4, x2 - x3, x4 - x5] + 
    CiTi[x2, x1, x2 - x4, x2 - x3, x5 - x6] + CiTi[x2, x1, x2 - x4, x3 - x4, 
     x4 - x5] - CiTi[x2, x1, x2 - x4, x3 - x4, x5 - x6] - 
    CiTi[x2, x1, x2 - x4, x4 - x5, x2 - x3] + CiTi[x2, x1, x2 - x4, x4 - x5, 
     x3 - x4] + CiTi[x2, x1, x2 - x4, x5 - x6, x2 - x3] - 
    CiTi[x2, x1, x2 - x4, x5 - x6, x3 - x4] - CiTi[x2, x1, x2 - x5, x2 - x3, 
     x3 - x4] + CiTi[x2, x1, x2 - x5, x2 - x3, x4 - x5] - 
    CiTi[x2, x1, x2 - x5, x2 - x4, x2 - x3] + CiTi[x2, x1, x2 - x5, x2 - x4, 
     x3 - x4] + CiTi[x2, x1, x2 - x5, x3 - x5, x3 - x4] - 
    CiTi[x2, x1, x2 - x5, x3 - x5, x4 - x5] + CiTi[x2, x1, x2 - x5, x4 - x5, 
     x2 - x3] - CiTi[x2, x1, x2 - x5, x4 - x5, x3 - x4] + 
    CiTi[x2, x1, x3 - x6, x3 - x4, x4 - x5] - CiTi[x2, x1, x3 - x6, x3 - x4, 
     x5 - x6] + CiTi[x2, x1, x3 - x6, x3 - x5, x3 - x4] - 
    CiTi[x2, x1, x3 - x6, x3 - x5, x4 - x5] - CiTi[x2, x1, x3 - x6, x4 - x6, 
     x4 - x5] + CiTi[x2, x1, x3 - x6, x4 - x6, x5 - x6] - 
    CiTi[x2, x1, x3 - x6, x5 - x6, x3 - x4] + CiTi[x2, x1, x3 - x6, x5 - x6, 
     x4 - x5] + CiTi[x2, x1, x4 - x6, x2 - x3, x4 - x5] - 
    CiTi[x2, x1, x4 - x6, x2 - x3, x5 - x6] - CiTi[x2, x1, x4 - x6, x3 - x4, 
     x4 - x5] + CiTi[x2, x1, x4 - x6, x3 - x4, x5 - x6] + 
    CiTi[x2, x1, x4 - x6, x4 - x5, x2 - x3] - CiTi[x2, x1, x4 - x6, x4 - x5, 
     x3 - x4] - CiTi[x2, x1, x4 - x6, x5 - x6, x2 - x3] + 
    CiTi[x2, x1, x4 - x6, x5 - x6, x3 - x4] + CiTi[x2, x1, x5 - x6, x2 - x3, 
     x3 - x4] - CiTi[x2, x1, x5 - x6, x2 - x3, x4 - x5] + 
    CiTi[x2, x1, x5 - x6, x2 - x4, x2 - x3] - CiTi[x2, x1, x5 - x6, x2 - x4, 
     x3 - x4] - CiTi[x2, x1, x5 - x6, x3 - x5, x3 - x4] + 
    CiTi[x2, x1, x5 - x6, x3 - x5, x4 - x5] - CiTi[x2, x1, x5 - x6, x4 - x5, 
     x2 - x3] + CiTi[x2, x1, x5 - x6, x4 - x5, x3 - x4] + 
    CiTi[x2, x1 - x2, x2 - x3, x3 - x4, x4 - x5] - 
    CiTi[x2, x1 - x2, x2 - x3, x3 - x4, x5 - x6] + 
    CiTi[x2, x1 - x2, x2 - x3, x3 - x5, x3 - x4] - 
    CiTi[x2, x1 - x2, x2 - x3, x3 - x5, x4 - x5] - 
    CiTi[x2, x1 - x2, x2 - x3, x4 - x6, x4 - x5] + 
    CiTi[x2, x1 - x2, x2 - x3, x4 - x6, x5 - x6] - 
    CiTi[x2, x1 - x2, x2 - x3, x5 - x6, x3 - x4] + 
    CiTi[x2, x1 - x2, x2 - x3, x5 - x6, x4 - x5] + 
    CiTi[x2, x1 - x2, x2 - x4, x2 - x3, x4 - x5] - 
    CiTi[x2, x1 - x2, x2 - x4, x2 - x3, x5 - x6] - 
    CiTi[x2, x1 - x2, x2 - x4, x3 - x4, x4 - x5] + 
    CiTi[x2, x1 - x2, x2 - x4, x3 - x4, x5 - x6] + 
    CiTi[x2, x1 - x2, x2 - x4, x4 - x5, x2 - x3] - 
    CiTi[x2, x1 - x2, x2 - x4, x4 - x5, x3 - x4] - 
    CiTi[x2, x1 - x2, x2 - x4, x5 - x6, x2 - x3] + 
    CiTi[x2, x1 - x2, x2 - x4, x5 - x6, x3 - x4] + 
    CiTi[x2, x1 - x2, x2 - x5, x2 - x3, x3 - x4] - 
    CiTi[x2, x1 - x2, x2 - x5, x2 - x3, x4 - x5] + 
    CiTi[x2, x1 - x2, x2 - x5, x2 - x4, x2 - x3] - 
    CiTi[x2, x1 - x2, x2 - x5, x2 - x4, x3 - x4] - 
    CiTi[x2, x1 - x2, x2 - x5, x3 - x5, x3 - x4] + 
    CiTi[x2, x1 - x2, x2 - x5, x3 - x5, x4 - x5] - 
    CiTi[x2, x1 - x2, x2 - x5, x4 - x5, x2 - x3] + 
    CiTi[x2, x1 - x2, x2 - x5, x4 - x5, x3 - x4] - 
    CiTi[x2, x1 - x2, x3 - x6, x3 - x4, x4 - x5] + 
    CiTi[x2, x1 - x2, x3 - x6, x3 - x4, x5 - x6] - 
    CiTi[x2, x1 - x2, x3 - x6, x3 - x5, x3 - x4] + 
    CiTi[x2, x1 - x2, x3 - x6, x3 - x5, x4 - x5] + 
    CiTi[x2, x1 - x2, x3 - x6, x4 - x6, x4 - x5] - 
    CiTi[x2, x1 - x2, x3 - x6, x4 - x6, x5 - x6] + 
    CiTi[x2, x1 - x2, x3 - x6, x5 - x6, x3 - x4] - 
    CiTi[x2, x1 - x2, x3 - x6, x5 - x6, x4 - x5] - 
    CiTi[x2, x1 - x2, x4 - x6, x2 - x3, x4 - x5] + 
    CiTi[x2, x1 - x2, x4 - x6, x2 - x3, x5 - x6] + 
    CiTi[x2, x1 - x2, x4 - x6, x3 - x4, x4 - x5] - 
    CiTi[x2, x1 - x2, x4 - x6, x3 - x4, x5 - x6] - 
    CiTi[x2, x1 - x2, x4 - x6, x4 - x5, x2 - x3] + 
    CiTi[x2, x1 - x2, x4 - x6, x4 - x5, x3 - x4] + 
    CiTi[x2, x1 - x2, x4 - x6, x5 - x6, x2 - x3] - 
    CiTi[x2, x1 - x2, x4 - x6, x5 - x6, x3 - x4] - 
    CiTi[x2, x1 - x2, x5 - x6, x2 - x3, x3 - x4] + 
    CiTi[x2, x1 - x2, x5 - x6, x2 - x3, x4 - x5] - 
    CiTi[x2, x1 - x2, x5 - x6, x2 - x4, x2 - x3] + 
    CiTi[x2, x1 - x2, x5 - x6, x2 - x4, x3 - x4] + 
    CiTi[x2, x1 - x2, x5 - x6, x3 - x5, x3 - x4] - 
    CiTi[x2, x1 - x2, x5 - x6, x3 - x5, x4 - x5] + 
    CiTi[x2, x1 - x2, x5 - x6, x4 - x5, x2 - x3] - 
    CiTi[x2, x1 - x2, x5 - x6, x4 - x5, x3 - x4] - 
    CiTi[x2, x2 - x3, x1, x3 - x4, x4 - x5] + CiTi[x2, x2 - x3, x1, x3 - x4, 
     x5 - x6] - CiTi[x2, x2 - x3, x1, x3 - x5, x3 - x4] + 
    CiTi[x2, x2 - x3, x1, x3 - x5, x4 - x5] + CiTi[x2, x2 - x3, x1, x4 - x6, 
     x4 - x5] - CiTi[x2, x2 - x3, x1, x4 - x6, x5 - x6] + 
    CiTi[x2, x2 - x3, x1, x5 - x6, x3 - x4] - CiTi[x2, x2 - x3, x1, x5 - x6, 
     x4 - x5] + CiTi[x2, x2 - x3, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x2, x2 - x3, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x2, x2 - x3, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x2, x2 - x3, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x2, x2 - x3, x1 - x2, x4 - x6, x4 - x5] + 
    CiTi[x2, x2 - x3, x1 - x2, x4 - x6, x5 - x6] - 
    CiTi[x2, x2 - x3, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x2, x2 - x3, x1 - x2, x5 - x6, x4 - x5] - 
    CiTi[x2, x2 - x3, x3 - x4, x1, x4 - x5] + CiTi[x2, x2 - x3, x3 - x4, x1, 
     x5 - x6] + CiTi[x2, x2 - x3, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x2, x2 - x3, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x2, x2 - x3, x3 - x4, x4 - x5, x1] + CiTi[x2, x2 - x3, x3 - x4, 
     x4 - x5, x1 - x2] + CiTi[x2, x2 - x3, x3 - x4, x5 - x6, x1] - 
    CiTi[x2, x2 - x3, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x2, x2 - x3, x3 - x5, x1, x3 - x4] + CiTi[x2, x2 - x3, x3 - x5, x1, 
     x4 - x5] + CiTi[x2, x2 - x3, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x2, x2 - x3, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x2, x2 - x3, x3 - x5, x3 - x4, x1] + CiTi[x2, x2 - x3, x3 - x5, 
     x3 - x4, x1 - x2] + CiTi[x2, x2 - x3, x3 - x5, x4 - x5, x1] - 
    CiTi[x2, x2 - x3, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x2, x2 - x3, x4 - x6, x1, x4 - x5] - CiTi[x2, x2 - x3, x4 - x6, x1, 
     x5 - x6] - CiTi[x2, x2 - x3, x4 - x6, x1 - x2, x4 - x5] + 
    CiTi[x2, x2 - x3, x4 - x6, x1 - x2, x5 - x6] + 
    CiTi[x2, x2 - x3, x4 - x6, x4 - x5, x1] - CiTi[x2, x2 - x3, x4 - x6, 
     x4 - x5, x1 - x2] - CiTi[x2, x2 - x3, x4 - x6, x5 - x6, x1] + 
    CiTi[x2, x2 - x3, x4 - x6, x5 - x6, x1 - x2] + 
    CiTi[x2, x2 - x3, x5 - x6, x1, x3 - x4] - CiTi[x2, x2 - x3, x5 - x6, x1, 
     x4 - x5] - CiTi[x2, x2 - x3, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x2, x2 - x3, x5 - x6, x1 - x2, x4 - x5] + 
    CiTi[x2, x2 - x3, x5 - x6, x3 - x4, x1] - CiTi[x2, x2 - x3, x5 - x6, 
     x3 - x4, x1 - x2] - CiTi[x2, x2 - x3, x5 - x6, x4 - x5, x1] + 
    CiTi[x2, x2 - x3, x5 - x6, x4 - x5, x1 - x2] - 
    CiTi[x2, x2 - x4, x1, x2 - x3, x4 - x5] + CiTi[x2, x2 - x4, x1, x2 - x3, 
     x5 - x6] + CiTi[x2, x2 - x4, x1, x3 - x4, x4 - x5] - 
    CiTi[x2, x2 - x4, x1, x3 - x4, x5 - x6] - CiTi[x2, x2 - x4, x1, x4 - x5, 
     x2 - x3] + CiTi[x2, x2 - x4, x1, x4 - x5, x3 - x4] + 
    CiTi[x2, x2 - x4, x1, x5 - x6, x2 - x3] - CiTi[x2, x2 - x4, x1, x5 - x6, 
     x3 - x4] + CiTi[x2, x2 - x4, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x2, x2 - x4, x1 - x2, x2 - x3, x5 - x6] - 
    CiTi[x2, x2 - x4, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x2, x2 - x4, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x2, x2 - x4, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x2, x2 - x4, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x2, x2 - x4, x1 - x2, x5 - x6, x2 - x3] + 
    CiTi[x2, x2 - x4, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x2, x2 - x4, x2 - x3, x1, x4 - x5] + CiTi[x2, x2 - x4, x2 - x3, x1, 
     x5 - x6] + CiTi[x2, x2 - x4, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x2, x2 - x4, x2 - x3, x1 - x2, x5 - x6] - 
    CiTi[x2, x2 - x4, x2 - x3, x4 - x5, x1] + CiTi[x2, x2 - x4, x2 - x3, 
     x4 - x5, x1 - x2] + CiTi[x2, x2 - x4, x2 - x3, x5 - x6, x1] - 
    CiTi[x2, x2 - x4, x2 - x3, x5 - x6, x1 - x2] + 
    CiTi[x2, x2 - x4, x3 - x4, x1, x4 - x5] - CiTi[x2, x2 - x4, x3 - x4, x1, 
     x5 - x6] - CiTi[x2, x2 - x4, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x2, x2 - x4, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x2, x2 - x4, x3 - x4, x4 - x5, x1] - CiTi[x2, x2 - x4, x3 - x4, 
     x4 - x5, x1 - x2] - CiTi[x2, x2 - x4, x3 - x4, x5 - x6, x1] + 
    CiTi[x2, x2 - x4, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x2, x2 - x4, x4 - x5, x1, x2 - x3] + CiTi[x2, x2 - x4, x4 - x5, x1, 
     x3 - x4] + CiTi[x2, x2 - x4, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x2, x2 - x4, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x2, x2 - x4, x4 - x5, x2 - x3, x1] + CiTi[x2, x2 - x4, x4 - x5, 
     x2 - x3, x1 - x2] + CiTi[x2, x2 - x4, x4 - x5, x3 - x4, x1] - 
    CiTi[x2, x2 - x4, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x2, x2 - x4, x5 - x6, x1, x2 - x3] - CiTi[x2, x2 - x4, x5 - x6, x1, 
     x3 - x4] - CiTi[x2, x2 - x4, x5 - x6, x1 - x2, x2 - x3] + 
    CiTi[x2, x2 - x4, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x2, x2 - x4, x5 - x6, x2 - x3, x1] - CiTi[x2, x2 - x4, x5 - x6, 
     x2 - x3, x1 - x2] - CiTi[x2, x2 - x4, x5 - x6, x3 - x4, x1] + 
    CiTi[x2, x2 - x4, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x2, x2 - x5, x1, x2 - x3, x3 - x4] + CiTi[x2, x2 - x5, x1, x2 - x3, 
     x4 - x5] - CiTi[x2, x2 - x5, x1, x2 - x4, x2 - x3] + 
    CiTi[x2, x2 - x5, x1, x2 - x4, x3 - x4] + CiTi[x2, x2 - x5, x1, x3 - x5, 
     x3 - x4] - CiTi[x2, x2 - x5, x1, x3 - x5, x4 - x5] + 
    CiTi[x2, x2 - x5, x1, x4 - x5, x2 - x3] - CiTi[x2, x2 - x5, x1, x4 - x5, 
     x3 - x4] + CiTi[x2, x2 - x5, x1 - x2, x2 - x3, x3 - x4] - 
    CiTi[x2, x2 - x5, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x2, x2 - x5, x1 - x2, x2 - x4, x2 - x3] - 
    CiTi[x2, x2 - x5, x1 - x2, x2 - x4, x3 - x4] - 
    CiTi[x2, x2 - x5, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x2, x2 - x5, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x2, x2 - x5, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x2, x2 - x5, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x2, x2 - x5, x2 - x3, x1, x3 - x4] + CiTi[x2, x2 - x5, x2 - x3, x1, 
     x4 - x5] + CiTi[x2, x2 - x5, x2 - x3, x1 - x2, x3 - x4] - 
    CiTi[x2, x2 - x5, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x2, x2 - x5, x2 - x3, x3 - x4, x1] + CiTi[x2, x2 - x5, x2 - x3, 
     x3 - x4, x1 - x2] + CiTi[x2, x2 - x5, x2 - x3, x4 - x5, x1] - 
    CiTi[x2, x2 - x5, x2 - x3, x4 - x5, x1 - x2] - 
    CiTi[x2, x2 - x5, x2 - x4, x1, x2 - x3] + CiTi[x2, x2 - x5, x2 - x4, x1, 
     x3 - x4] + CiTi[x2, x2 - x5, x2 - x4, x1 - x2, x2 - x3] - 
    CiTi[x2, x2 - x5, x2 - x4, x1 - x2, x3 - x4] - 
    CiTi[x2, x2 - x5, x2 - x4, x2 - x3, x1] + CiTi[x2, x2 - x5, x2 - x4, 
     x2 - x3, x1 - x2] + CiTi[x2, x2 - x5, x2 - x4, x3 - x4, x1] - 
    CiTi[x2, x2 - x5, x2 - x4, x3 - x4, x1 - x2] + 
    CiTi[x2, x2 - x5, x3 - x5, x1, x3 - x4] - CiTi[x2, x2 - x5, x3 - x5, x1, 
     x4 - x5] - CiTi[x2, x2 - x5, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x2, x2 - x5, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x2, x2 - x5, x3 - x5, x3 - x4, x1] - CiTi[x2, x2 - x5, x3 - x5, 
     x3 - x4, x1 - x2] - CiTi[x2, x2 - x5, x3 - x5, x4 - x5, x1] + 
    CiTi[x2, x2 - x5, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x2, x2 - x5, x4 - x5, x1, x2 - x3] - CiTi[x2, x2 - x5, x4 - x5, x1, 
     x3 - x4] - CiTi[x2, x2 - x5, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x2, x2 - x5, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x2, x2 - x5, x4 - x5, x2 - x3, x1] - CiTi[x2, x2 - x5, x4 - x5, 
     x2 - x3, x1 - x2] - CiTi[x2, x2 - x5, x4 - x5, x3 - x4, x1] + 
    CiTi[x2, x2 - x5, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x2, x3 - x6, x1, x3 - x4, x4 - x5] - CiTi[x2, x3 - x6, x1, x3 - x4, 
     x5 - x6] + CiTi[x2, x3 - x6, x1, x3 - x5, x3 - x4] - 
    CiTi[x2, x3 - x6, x1, x3 - x5, x4 - x5] - CiTi[x2, x3 - x6, x1, x4 - x6, 
     x4 - x5] + CiTi[x2, x3 - x6, x1, x4 - x6, x5 - x6] - 
    CiTi[x2, x3 - x6, x1, x5 - x6, x3 - x4] + CiTi[x2, x3 - x6, x1, x5 - x6, 
     x4 - x5] - CiTi[x2, x3 - x6, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x2, x3 - x6, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x2, x3 - x6, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x2, x3 - x6, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x2, x3 - x6, x1 - x2, x4 - x6, x4 - x5] - 
    CiTi[x2, x3 - x6, x1 - x2, x4 - x6, x5 - x6] + 
    CiTi[x2, x3 - x6, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x2, x3 - x6, x1 - x2, x5 - x6, x4 - x5] + 
    CiTi[x2, x3 - x6, x3 - x4, x1, x4 - x5] - CiTi[x2, x3 - x6, x3 - x4, x1, 
     x5 - x6] - CiTi[x2, x3 - x6, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x2, x3 - x6, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x2, x3 - x6, x3 - x4, x4 - x5, x1] - CiTi[x2, x3 - x6, x3 - x4, 
     x4 - x5, x1 - x2] - CiTi[x2, x3 - x6, x3 - x4, x5 - x6, x1] + 
    CiTi[x2, x3 - x6, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x2, x3 - x6, x3 - x5, x1, x3 - x4] - CiTi[x2, x3 - x6, x3 - x5, x1, 
     x4 - x5] - CiTi[x2, x3 - x6, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x2, x3 - x6, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x2, x3 - x6, x3 - x5, x3 - x4, x1] - CiTi[x2, x3 - x6, x3 - x5, 
     x3 - x4, x1 - x2] - CiTi[x2, x3 - x6, x3 - x5, x4 - x5, x1] + 
    CiTi[x2, x3 - x6, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x2, x3 - x6, x4 - x6, x1, x4 - x5] + CiTi[x2, x3 - x6, x4 - x6, x1, 
     x5 - x6] + CiTi[x2, x3 - x6, x4 - x6, x1 - x2, x4 - x5] - 
    CiTi[x2, x3 - x6, x4 - x6, x1 - x2, x5 - x6] - 
    CiTi[x2, x3 - x6, x4 - x6, x4 - x5, x1] + CiTi[x2, x3 - x6, x4 - x6, 
     x4 - x5, x1 - x2] + CiTi[x2, x3 - x6, x4 - x6, x5 - x6, x1] - 
    CiTi[x2, x3 - x6, x4 - x6, x5 - x6, x1 - x2] - 
    CiTi[x2, x3 - x6, x5 - x6, x1, x3 - x4] + CiTi[x2, x3 - x6, x5 - x6, x1, 
     x4 - x5] + CiTi[x2, x3 - x6, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x2, x3 - x6, x5 - x6, x1 - x2, x4 - x5] - 
    CiTi[x2, x3 - x6, x5 - x6, x3 - x4, x1] + CiTi[x2, x3 - x6, x5 - x6, 
     x3 - x4, x1 - x2] + CiTi[x2, x3 - x6, x5 - x6, x4 - x5, x1] - 
    CiTi[x2, x3 - x6, x5 - x6, x4 - x5, x1 - x2] + 
    CiTi[x2, x4 - x6, x1, x2 - x3, x4 - x5] - CiTi[x2, x4 - x6, x1, x2 - x3, 
     x5 - x6] - CiTi[x2, x4 - x6, x1, x3 - x4, x4 - x5] + 
    CiTi[x2, x4 - x6, x1, x3 - x4, x5 - x6] + CiTi[x2, x4 - x6, x1, x4 - x5, 
     x2 - x3] - CiTi[x2, x4 - x6, x1, x4 - x5, x3 - x4] - 
    CiTi[x2, x4 - x6, x1, x5 - x6, x2 - x3] + CiTi[x2, x4 - x6, x1, x5 - x6, 
     x3 - x4] - CiTi[x2, x4 - x6, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x2, x4 - x6, x1 - x2, x2 - x3, x5 - x6] + 
    CiTi[x2, x4 - x6, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x2, x4 - x6, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x2, x4 - x6, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x2, x4 - x6, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x2, x4 - x6, x1 - x2, x5 - x6, x2 - x3] - 
    CiTi[x2, x4 - x6, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x2, x4 - x6, x2 - x3, x1, x4 - x5] - CiTi[x2, x4 - x6, x2 - x3, x1, 
     x5 - x6] - CiTi[x2, x4 - x6, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x2, x4 - x6, x2 - x3, x1 - x2, x5 - x6] + 
    CiTi[x2, x4 - x6, x2 - x3, x4 - x5, x1] - CiTi[x2, x4 - x6, x2 - x3, 
     x4 - x5, x1 - x2] - CiTi[x2, x4 - x6, x2 - x3, x5 - x6, x1] + 
    CiTi[x2, x4 - x6, x2 - x3, x5 - x6, x1 - x2] - 
    CiTi[x2, x4 - x6, x3 - x4, x1, x4 - x5] + CiTi[x2, x4 - x6, x3 - x4, x1, 
     x5 - x6] + CiTi[x2, x4 - x6, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x2, x4 - x6, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x2, x4 - x6, x3 - x4, x4 - x5, x1] + CiTi[x2, x4 - x6, x3 - x4, 
     x4 - x5, x1 - x2] + CiTi[x2, x4 - x6, x3 - x4, x5 - x6, x1] - 
    CiTi[x2, x4 - x6, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x2, x4 - x6, x4 - x5, x1, x2 - x3] - CiTi[x2, x4 - x6, x4 - x5, x1, 
     x3 - x4] - CiTi[x2, x4 - x6, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x2, x4 - x6, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x2, x4 - x6, x4 - x5, x2 - x3, x1] - CiTi[x2, x4 - x6, x4 - x5, 
     x2 - x3, x1 - x2] - CiTi[x2, x4 - x6, x4 - x5, x3 - x4, x1] + 
    CiTi[x2, x4 - x6, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x2, x4 - x6, x5 - x6, x1, x2 - x3] + CiTi[x2, x4 - x6, x5 - x6, x1, 
     x3 - x4] + CiTi[x2, x4 - x6, x5 - x6, x1 - x2, x2 - x3] - 
    CiTi[x2, x4 - x6, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x2, x4 - x6, x5 - x6, x2 - x3, x1] + CiTi[x2, x4 - x6, x5 - x6, 
     x2 - x3, x1 - x2] + CiTi[x2, x4 - x6, x5 - x6, x3 - x4, x1] - 
    CiTi[x2, x4 - x6, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x2, x5 - x6, x1, x2 - x3, x3 - x4] - CiTi[x2, x5 - x6, x1, x2 - x3, 
     x4 - x5] + CiTi[x2, x5 - x6, x1, x2 - x4, x2 - x3] - 
    CiTi[x2, x5 - x6, x1, x2 - x4, x3 - x4] - CiTi[x2, x5 - x6, x1, x3 - x5, 
     x3 - x4] + CiTi[x2, x5 - x6, x1, x3 - x5, x4 - x5] - 
    CiTi[x2, x5 - x6, x1, x4 - x5, x2 - x3] + CiTi[x2, x5 - x6, x1, x4 - x5, 
     x3 - x4] - CiTi[x2, x5 - x6, x1 - x2, x2 - x3, x3 - x4] + 
    CiTi[x2, x5 - x6, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x2, x5 - x6, x1 - x2, x2 - x4, x2 - x3] + 
    CiTi[x2, x5 - x6, x1 - x2, x2 - x4, x3 - x4] + 
    CiTi[x2, x5 - x6, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x2, x5 - x6, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x2, x5 - x6, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x2, x5 - x6, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x2, x5 - x6, x2 - x3, x1, x3 - x4] - CiTi[x2, x5 - x6, x2 - x3, x1, 
     x4 - x5] - CiTi[x2, x5 - x6, x2 - x3, x1 - x2, x3 - x4] + 
    CiTi[x2, x5 - x6, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x2, x5 - x6, x2 - x3, x3 - x4, x1] - CiTi[x2, x5 - x6, x2 - x3, 
     x3 - x4, x1 - x2] - CiTi[x2, x5 - x6, x2 - x3, x4 - x5, x1] + 
    CiTi[x2, x5 - x6, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x2, x5 - x6, x2 - x4, x1, x2 - x3] - CiTi[x2, x5 - x6, x2 - x4, x1, 
     x3 - x4] - CiTi[x2, x5 - x6, x2 - x4, x1 - x2, x2 - x3] + 
    CiTi[x2, x5 - x6, x2 - x4, x1 - x2, x3 - x4] + 
    CiTi[x2, x5 - x6, x2 - x4, x2 - x3, x1] - CiTi[x2, x5 - x6, x2 - x4, 
     x2 - x3, x1 - x2] - CiTi[x2, x5 - x6, x2 - x4, x3 - x4, x1] + 
    CiTi[x2, x5 - x6, x2 - x4, x3 - x4, x1 - x2] - 
    CiTi[x2, x5 - x6, x3 - x5, x1, x3 - x4] + CiTi[x2, x5 - x6, x3 - x5, x1, 
     x4 - x5] + CiTi[x2, x5 - x6, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x2, x5 - x6, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x2, x5 - x6, x3 - x5, x3 - x4, x1] + CiTi[x2, x5 - x6, x3 - x5, 
     x3 - x4, x1 - x2] + CiTi[x2, x5 - x6, x3 - x5, x4 - x5, x1] - 
    CiTi[x2, x5 - x6, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x2, x5 - x6, x4 - x5, x1, x2 - x3] + CiTi[x2, x5 - x6, x4 - x5, x1, 
     x3 - x4] + CiTi[x2, x5 - x6, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x2, x5 - x6, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x2, x5 - x6, x4 - x5, x2 - x3, x1] + CiTi[x2, x5 - x6, x4 - x5, 
     x2 - x3, x1 - x2] + CiTi[x2, x5 - x6, x4 - x5, x3 - x4, x1] - 
    CiTi[x2, x5 - x6, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x3, x1, x1 - x2, x3 - x4, x4 - x5] + CiTi[x3, x1, x1 - x2, x3 - x4, 
     x5 - x6] - CiTi[x3, x1, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x3, x1, x1 - x2, x3 - x5, x4 - x5] + CiTi[x3, x1, x1 - x2, x4 - x6, 
     x4 - x5] - CiTi[x3, x1, x1 - x2, x4 - x6, x5 - x6] + 
    CiTi[x3, x1, x1 - x2, x5 - x6, x3 - x4] - CiTi[x3, x1, x1 - x2, x5 - x6, 
     x4 - x5] + CiTi[x3, x1, x2 - x3, x3 - x4, x4 - x5] - 
    CiTi[x3, x1, x2 - x3, x3 - x4, x5 - x6] + CiTi[x3, x1, x2 - x3, x3 - x5, 
     x3 - x4] - CiTi[x3, x1, x2 - x3, x3 - x5, x4 - x5] - 
    CiTi[x3, x1, x2 - x3, x4 - x6, x4 - x5] + CiTi[x3, x1, x2 - x3, x4 - x6, 
     x5 - x6] - CiTi[x3, x1, x2 - x3, x5 - x6, x3 - x4] + 
    CiTi[x3, x1, x2 - x3, x5 - x6, x4 - x5] - CiTi[x3, x1, x3 - x4, x1 - x2, 
     x4 - x5] + CiTi[x3, x1, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x3, x1, x3 - x4, x2 - x3, x4 - x5] - CiTi[x3, x1, x3 - x4, x2 - x3, 
     x5 - x6] - CiTi[x3, x1, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x3, x1, x3 - x4, x4 - x5, x2 - x3] + CiTi[x3, x1, x3 - x4, x5 - x6, 
     x1 - x2] - CiTi[x3, x1, x3 - x4, x5 - x6, x2 - x3] - 
    CiTi[x3, x1, x3 - x5, x1 - x2, x3 - x4] + CiTi[x3, x1, x3 - x5, x1 - x2, 
     x4 - x5] + CiTi[x3, x1, x3 - x5, x2 - x3, x3 - x4] - 
    CiTi[x3, x1, x3 - x5, x2 - x3, x4 - x5] - CiTi[x3, x1, x3 - x5, x3 - x4, 
     x1 - x2] + CiTi[x3, x1, x3 - x5, x3 - x4, x2 - x3] + 
    CiTi[x3, x1, x3 - x5, x4 - x5, x1 - x2] - CiTi[x3, x1, x3 - x5, x4 - x5, 
     x2 - x3] + CiTi[x3, x1, x4 - x6, x1 - x2, x4 - x5] - 
    CiTi[x3, x1, x4 - x6, x1 - x2, x5 - x6] - CiTi[x3, x1, x4 - x6, x2 - x3, 
     x4 - x5] + CiTi[x3, x1, x4 - x6, x2 - x3, x5 - x6] + 
    CiTi[x3, x1, x4 - x6, x4 - x5, x1 - x2] - CiTi[x3, x1, x4 - x6, x4 - x5, 
     x2 - x3] - CiTi[x3, x1, x4 - x6, x5 - x6, x1 - x2] + 
    CiTi[x3, x1, x4 - x6, x5 - x6, x2 - x3] + CiTi[x3, x1, x5 - x6, x1 - x2, 
     x3 - x4] - CiTi[x3, x1, x5 - x6, x1 - x2, x4 - x5] - 
    CiTi[x3, x1, x5 - x6, x2 - x3, x3 - x4] + CiTi[x3, x1, x5 - x6, x2 - x3, 
     x4 - x5] + CiTi[x3, x1, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x3, x1, x5 - x6, x3 - x4, x2 - x3] - CiTi[x3, x1, x5 - x6, x4 - x5, 
     x1 - x2] + CiTi[x3, x1, x5 - x6, x4 - x5, x2 - x3] - 
    CiTi[x3, x2, x1, x3 - x4, x4 - x5] + CiTi[x3, x2, x1, x3 - x4, x5 - x6] - 
    CiTi[x3, x2, x1, x3 - x5, x3 - x4] + CiTi[x3, x2, x1, x3 - x5, x4 - x5] + 
    CiTi[x3, x2, x1, x4 - x6, x4 - x5] - CiTi[x3, x2, x1, x4 - x6, x5 - x6] + 
    CiTi[x3, x2, x1, x5 - x6, x3 - x4] - CiTi[x3, x2, x1, x5 - x6, x4 - x5] + 
    CiTi[x3, x2, x1 - x2, x3 - x4, x4 - x5] - CiTi[x3, x2, x1 - x2, x3 - x4, 
     x5 - x6] + CiTi[x3, x2, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x3, x2, x1 - x2, x3 - x5, x4 - x5] - CiTi[x3, x2, x1 - x2, x4 - x6, 
     x4 - x5] + CiTi[x3, x2, x1 - x2, x4 - x6, x5 - x6] - 
    CiTi[x3, x2, x1 - x2, x5 - x6, x3 - x4] + CiTi[x3, x2, x1 - x2, x5 - x6, 
     x4 - x5] - CiTi[x3, x2, x3 - x4, x1, x4 - x5] + 
    CiTi[x3, x2, x3 - x4, x1, x5 - x6] + CiTi[x3, x2, x3 - x4, x1 - x2, 
     x4 - x5] - CiTi[x3, x2, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x3, x2, x3 - x4, x4 - x5, x1] + CiTi[x3, x2, x3 - x4, x4 - x5, 
     x1 - x2] + CiTi[x3, x2, x3 - x4, x5 - x6, x1] - 
    CiTi[x3, x2, x3 - x4, x5 - x6, x1 - x2] - CiTi[x3, x2, x3 - x5, x1, 
     x3 - x4] + CiTi[x3, x2, x3 - x5, x1, x4 - x5] + 
    CiTi[x3, x2, x3 - x5, x1 - x2, x3 - x4] - CiTi[x3, x2, x3 - x5, x1 - x2, 
     x4 - x5] - CiTi[x3, x2, x3 - x5, x3 - x4, x1] + 
    CiTi[x3, x2, x3 - x5, x3 - x4, x1 - x2] + CiTi[x3, x2, x3 - x5, x4 - x5, 
     x1] - CiTi[x3, x2, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x3, x2, x4 - x6, x1, x4 - x5] - CiTi[x3, x2, x4 - x6, x1, x5 - x6] - 
    CiTi[x3, x2, x4 - x6, x1 - x2, x4 - x5] + CiTi[x3, x2, x4 - x6, x1 - x2, 
     x5 - x6] + CiTi[x3, x2, x4 - x6, x4 - x5, x1] - 
    CiTi[x3, x2, x4 - x6, x4 - x5, x1 - x2] - CiTi[x3, x2, x4 - x6, x5 - x6, 
     x1] + CiTi[x3, x2, x4 - x6, x5 - x6, x1 - x2] + 
    CiTi[x3, x2, x5 - x6, x1, x3 - x4] - CiTi[x3, x2, x5 - x6, x1, x4 - x5] - 
    CiTi[x3, x2, x5 - x6, x1 - x2, x3 - x4] + CiTi[x3, x2, x5 - x6, x1 - x2, 
     x4 - x5] + CiTi[x3, x2, x5 - x6, x3 - x4, x1] - 
    CiTi[x3, x2, x5 - x6, x3 - x4, x1 - x2] - CiTi[x3, x2, x5 - x6, x4 - x5, 
     x1] + CiTi[x3, x2, x5 - x6, x4 - x5, x1 - x2] + 
    CiTi[x3, x1 - x3, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x3, x1 - x3, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x3, x1 - x3, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x3, x1 - x3, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x3, x1 - x3, x1 - x2, x4 - x6, x4 - x5] + 
    CiTi[x3, x1 - x3, x1 - x2, x4 - x6, x5 - x6] - 
    CiTi[x3, x1 - x3, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x3, x1 - x3, x1 - x2, x5 - x6, x4 - x5] - 
    CiTi[x3, x1 - x3, x2 - x3, x3 - x4, x4 - x5] + 
    CiTi[x3, x1 - x3, x2 - x3, x3 - x4, x5 - x6] - 
    CiTi[x3, x1 - x3, x2 - x3, x3 - x5, x3 - x4] + 
    CiTi[x3, x1 - x3, x2 - x3, x3 - x5, x4 - x5] + 
    CiTi[x3, x1 - x3, x2 - x3, x4 - x6, x4 - x5] - 
    CiTi[x3, x1 - x3, x2 - x3, x4 - x6, x5 - x6] + 
    CiTi[x3, x1 - x3, x2 - x3, x5 - x6, x3 - x4] - 
    CiTi[x3, x1 - x3, x2 - x3, x5 - x6, x4 - x5] + 
    CiTi[x3, x1 - x3, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x3, x1 - x3, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x3, x1 - x3, x3 - x4, x2 - x3, x4 - x5] + 
    CiTi[x3, x1 - x3, x3 - x4, x2 - x3, x5 - x6] + 
    CiTi[x3, x1 - x3, x3 - x4, x4 - x5, x1 - x2] - 
    CiTi[x3, x1 - x3, x3 - x4, x4 - x5, x2 - x3] - 
    CiTi[x3, x1 - x3, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x3, x1 - x3, x3 - x4, x5 - x6, x2 - x3] + 
    CiTi[x3, x1 - x3, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x3, x1 - x3, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x3, x1 - x3, x3 - x5, x2 - x3, x3 - x4] + 
    CiTi[x3, x1 - x3, x3 - x5, x2 - x3, x4 - x5] + 
    CiTi[x3, x1 - x3, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x3, x1 - x3, x3 - x5, x3 - x4, x2 - x3] - 
    CiTi[x3, x1 - x3, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x3, x1 - x3, x3 - x5, x4 - x5, x2 - x3] - 
    CiTi[x3, x1 - x3, x4 - x6, x1 - x2, x4 - x5] + 
    CiTi[x3, x1 - x3, x4 - x6, x1 - x2, x5 - x6] + 
    CiTi[x3, x1 - x3, x4 - x6, x2 - x3, x4 - x5] - 
    CiTi[x3, x1 - x3, x4 - x6, x2 - x3, x5 - x6] - 
    CiTi[x3, x1 - x3, x4 - x6, x4 - x5, x1 - x2] + 
    CiTi[x3, x1 - x3, x4 - x6, x4 - x5, x2 - x3] + 
    CiTi[x3, x1 - x3, x4 - x6, x5 - x6, x1 - x2] - 
    CiTi[x3, x1 - x3, x4 - x6, x5 - x6, x2 - x3] - 
    CiTi[x3, x1 - x3, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x3, x1 - x3, x5 - x6, x1 - x2, x4 - x5] + 
    CiTi[x3, x1 - x3, x5 - x6, x2 - x3, x3 - x4] - 
    CiTi[x3, x1 - x3, x5 - x6, x2 - x3, x4 - x5] - 
    CiTi[x3, x1 - x3, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x3, x1 - x3, x5 - x6, x3 - x4, x2 - x3] + 
    CiTi[x3, x1 - x3, x5 - x6, x4 - x5, x1 - x2] - 
    CiTi[x3, x1 - x3, x5 - x6, x4 - x5, x2 - x3] + 
    CiTi[x3, x2 - x3, x1, x3 - x4, x4 - x5] - CiTi[x3, x2 - x3, x1, x3 - x4, 
     x5 - x6] + CiTi[x3, x2 - x3, x1, x3 - x5, x3 - x4] - 
    CiTi[x3, x2 - x3, x1, x3 - x5, x4 - x5] - CiTi[x3, x2 - x3, x1, x4 - x6, 
     x4 - x5] + CiTi[x3, x2 - x3, x1, x4 - x6, x5 - x6] - 
    CiTi[x3, x2 - x3, x1, x5 - x6, x3 - x4] + CiTi[x3, x2 - x3, x1, x5 - x6, 
     x4 - x5] - CiTi[x3, x2 - x3, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x3, x2 - x3, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x3, x2 - x3, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x3, x2 - x3, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x3, x2 - x3, x1 - x2, x4 - x6, x4 - x5] - 
    CiTi[x3, x2 - x3, x1 - x2, x4 - x6, x5 - x6] + 
    CiTi[x3, x2 - x3, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x3, x2 - x3, x1 - x2, x5 - x6, x4 - x5] + 
    CiTi[x3, x2 - x3, x3 - x4, x1, x4 - x5] - CiTi[x3, x2 - x3, x3 - x4, x1, 
     x5 - x6] - CiTi[x3, x2 - x3, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x3, x2 - x3, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x3, x2 - x3, x3 - x4, x4 - x5, x1] - CiTi[x3, x2 - x3, x3 - x4, 
     x4 - x5, x1 - x2] - CiTi[x3, x2 - x3, x3 - x4, x5 - x6, x1] + 
    CiTi[x3, x2 - x3, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x3, x2 - x3, x3 - x5, x1, x3 - x4] - CiTi[x3, x2 - x3, x3 - x5, x1, 
     x4 - x5] - CiTi[x3, x2 - x3, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x3, x2 - x3, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x3, x2 - x3, x3 - x5, x3 - x4, x1] - CiTi[x3, x2 - x3, x3 - x5, 
     x3 - x4, x1 - x2] - CiTi[x3, x2 - x3, x3 - x5, x4 - x5, x1] + 
    CiTi[x3, x2 - x3, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x3, x2 - x3, x4 - x6, x1, x4 - x5] + CiTi[x3, x2 - x3, x4 - x6, x1, 
     x5 - x6] + CiTi[x3, x2 - x3, x4 - x6, x1 - x2, x4 - x5] - 
    CiTi[x3, x2 - x3, x4 - x6, x1 - x2, x5 - x6] - 
    CiTi[x3, x2 - x3, x4 - x6, x4 - x5, x1] + CiTi[x3, x2 - x3, x4 - x6, 
     x4 - x5, x1 - x2] + CiTi[x3, x2 - x3, x4 - x6, x5 - x6, x1] - 
    CiTi[x3, x2 - x3, x4 - x6, x5 - x6, x1 - x2] - 
    CiTi[x3, x2 - x3, x5 - x6, x1, x3 - x4] + CiTi[x3, x2 - x3, x5 - x6, x1, 
     x4 - x5] + CiTi[x3, x2 - x3, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x3, x2 - x3, x5 - x6, x1 - x2, x4 - x5] - 
    CiTi[x3, x2 - x3, x5 - x6, x3 - x4, x1] + CiTi[x3, x2 - x3, x5 - x6, 
     x3 - x4, x1 - x2] + CiTi[x3, x2 - x3, x5 - x6, x4 - x5, x1] - 
    CiTi[x3, x2 - x3, x5 - x6, x4 - x5, x1 - x2] - 
    CiTi[x3, x3 - x4, x1, x1 - x2, x4 - x5] + CiTi[x3, x3 - x4, x1, x1 - x2, 
     x5 - x6] + CiTi[x3, x3 - x4, x1, x2 - x3, x4 - x5] - 
    CiTi[x3, x3 - x4, x1, x2 - x3, x5 - x6] - CiTi[x3, x3 - x4, x1, x4 - x5, 
     x1 - x2] + CiTi[x3, x3 - x4, x1, x4 - x5, x2 - x3] + 
    CiTi[x3, x3 - x4, x1, x5 - x6, x1 - x2] - CiTi[x3, x3 - x4, x1, x5 - x6, 
     x2 - x3] - CiTi[x3, x3 - x4, x2, x1, x4 - x5] + 
    CiTi[x3, x3 - x4, x2, x1, x5 - x6] + CiTi[x3, x3 - x4, x2, x1 - x2, 
     x4 - x5] - CiTi[x3, x3 - x4, x2, x1 - x2, x5 - x6] - 
    CiTi[x3, x3 - x4, x2, x4 - x5, x1] + CiTi[x3, x3 - x4, x2, x4 - x5, 
     x1 - x2] + CiTi[x3, x3 - x4, x2, x5 - x6, x1] - 
    CiTi[x3, x3 - x4, x2, x5 - x6, x1 - x2] + CiTi[x3, x3 - x4, x1 - x3, 
     x1 - x2, x4 - x5] - CiTi[x3, x3 - x4, x1 - x3, x1 - x2, x5 - x6] - 
    CiTi[x3, x3 - x4, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x3, x3 - x4, x1 - x3, x2 - x3, x5 - x6] + 
    CiTi[x3, x3 - x4, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x3, x3 - x4, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x3, x3 - x4, x1 - x3, x5 - x6, x1 - x2] + 
    CiTi[x3, x3 - x4, x1 - x3, x5 - x6, x2 - x3] + 
    CiTi[x3, x3 - x4, x2 - x3, x1, x4 - x5] - CiTi[x3, x3 - x4, x2 - x3, x1, 
     x5 - x6] - CiTi[x3, x3 - x4, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x3, x3 - x4, x2 - x3, x1 - x2, x5 - x6] + 
    CiTi[x3, x3 - x4, x2 - x3, x4 - x5, x1] - CiTi[x3, x3 - x4, x2 - x3, 
     x4 - x5, x1 - x2] - CiTi[x3, x3 - x4, x2 - x3, x5 - x6, x1] + 
    CiTi[x3, x3 - x4, x2 - x3, x5 - x6, x1 - x2] - 
    CiTi[x3, x3 - x4, x4 - x5, x1, x1 - x2] + CiTi[x3, x3 - x4, x4 - x5, x1, 
     x2 - x3] - CiTi[x3, x3 - x4, x4 - x5, x2, x1] + 
    CiTi[x3, x3 - x4, x4 - x5, x2, x1 - x2] + CiTi[x3, x3 - x4, x4 - x5, 
     x1 - x3, x1 - x2] - CiTi[x3, x3 - x4, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x3, x3 - x4, x4 - x5, x2 - x3, x1] - CiTi[x3, x3 - x4, x4 - x5, 
     x2 - x3, x1 - x2] + CiTi[x3, x3 - x4, x5 - x6, x1, x1 - x2] - 
    CiTi[x3, x3 - x4, x5 - x6, x1, x2 - x3] + CiTi[x3, x3 - x4, x5 - x6, x2, 
     x1] - CiTi[x3, x3 - x4, x5 - x6, x2, x1 - x2] - 
    CiTi[x3, x3 - x4, x5 - x6, x1 - x3, x1 - x2] + 
    CiTi[x3, x3 - x4, x5 - x6, x1 - x3, x2 - x3] - 
    CiTi[x3, x3 - x4, x5 - x6, x2 - x3, x1] + CiTi[x3, x3 - x4, x5 - x6, 
     x2 - x3, x1 - x2] - CiTi[x3, x3 - x5, x1, x1 - x2, x3 - x4] + 
    CiTi[x3, x3 - x5, x1, x1 - x2, x4 - x5] + CiTi[x3, x3 - x5, x1, x2 - x3, 
     x3 - x4] - CiTi[x3, x3 - x5, x1, x2 - x3, x4 - x5] - 
    CiTi[x3, x3 - x5, x1, x3 - x4, x1 - x2] + CiTi[x3, x3 - x5, x1, x3 - x4, 
     x2 - x3] + CiTi[x3, x3 - x5, x1, x4 - x5, x1 - x2] - 
    CiTi[x3, x3 - x5, x1, x4 - x5, x2 - x3] - CiTi[x3, x3 - x5, x2, x1, 
     x3 - x4] + CiTi[x3, x3 - x5, x2, x1, x4 - x5] + 
    CiTi[x3, x3 - x5, x2, x1 - x2, x3 - x4] - CiTi[x3, x3 - x5, x2, x1 - x2, 
     x4 - x5] - CiTi[x3, x3 - x5, x2, x3 - x4, x1] + 
    CiTi[x3, x3 - x5, x2, x3 - x4, x1 - x2] + CiTi[x3, x3 - x5, x2, x4 - x5, 
     x1] - CiTi[x3, x3 - x5, x2, x4 - x5, x1 - x2] + 
    CiTi[x3, x3 - x5, x1 - x3, x1 - x2, x3 - x4] - 
    CiTi[x3, x3 - x5, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x3, x3 - x5, x1 - x3, x2 - x3, x3 - x4] + 
    CiTi[x3, x3 - x5, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x3, x3 - x5, x1 - x3, x3 - x4, x1 - x2] - 
    CiTi[x3, x3 - x5, x1 - x3, x3 - x4, x2 - x3] - 
    CiTi[x3, x3 - x5, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x3, x3 - x5, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x3, x3 - x5, x2 - x3, x1, x3 - x4] - CiTi[x3, x3 - x5, x2 - x3, x1, 
     x4 - x5] - CiTi[x3, x3 - x5, x2 - x3, x1 - x2, x3 - x4] + 
    CiTi[x3, x3 - x5, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x3, x3 - x5, x2 - x3, x3 - x4, x1] - CiTi[x3, x3 - x5, x2 - x3, 
     x3 - x4, x1 - x2] - CiTi[x3, x3 - x5, x2 - x3, x4 - x5, x1] + 
    CiTi[x3, x3 - x5, x2 - x3, x4 - x5, x1 - x2] - 
    CiTi[x3, x3 - x5, x3 - x4, x1, x1 - x2] + CiTi[x3, x3 - x5, x3 - x4, x1, 
     x2 - x3] - CiTi[x3, x3 - x5, x3 - x4, x2, x1] + 
    CiTi[x3, x3 - x5, x3 - x4, x2, x1 - x2] + CiTi[x3, x3 - x5, x3 - x4, 
     x1 - x3, x1 - x2] - CiTi[x3, x3 - x5, x3 - x4, x1 - x3, x2 - x3] + 
    CiTi[x3, x3 - x5, x3 - x4, x2 - x3, x1] - CiTi[x3, x3 - x5, x3 - x4, 
     x2 - x3, x1 - x2] + CiTi[x3, x3 - x5, x4 - x5, x1, x1 - x2] - 
    CiTi[x3, x3 - x5, x4 - x5, x1, x2 - x3] + CiTi[x3, x3 - x5, x4 - x5, x2, 
     x1] - CiTi[x3, x3 - x5, x4 - x5, x2, x1 - x2] - 
    CiTi[x3, x3 - x5, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x3, x3 - x5, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x3, x3 - x5, x4 - x5, x2 - x3, x1] + CiTi[x3, x3 - x5, x4 - x5, 
     x2 - x3, x1 - x2] + CiTi[x3, x4 - x6, x1, x1 - x2, x4 - x5] - 
    CiTi[x3, x4 - x6, x1, x1 - x2, x5 - x6] - CiTi[x3, x4 - x6, x1, x2 - x3, 
     x4 - x5] + CiTi[x3, x4 - x6, x1, x2 - x3, x5 - x6] + 
    CiTi[x3, x4 - x6, x1, x4 - x5, x1 - x2] - CiTi[x3, x4 - x6, x1, x4 - x5, 
     x2 - x3] - CiTi[x3, x4 - x6, x1, x5 - x6, x1 - x2] + 
    CiTi[x3, x4 - x6, x1, x5 - x6, x2 - x3] + CiTi[x3, x4 - x6, x2, x1, 
     x4 - x5] - CiTi[x3, x4 - x6, x2, x1, x5 - x6] - 
    CiTi[x3, x4 - x6, x2, x1 - x2, x4 - x5] + CiTi[x3, x4 - x6, x2, x1 - x2, 
     x5 - x6] + CiTi[x3, x4 - x6, x2, x4 - x5, x1] - 
    CiTi[x3, x4 - x6, x2, x4 - x5, x1 - x2] - CiTi[x3, x4 - x6, x2, x5 - x6, 
     x1] + CiTi[x3, x4 - x6, x2, x5 - x6, x1 - x2] - 
    CiTi[x3, x4 - x6, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x3, x4 - x6, x1 - x3, x1 - x2, x5 - x6] + 
    CiTi[x3, x4 - x6, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x3, x4 - x6, x1 - x3, x2 - x3, x5 - x6] - 
    CiTi[x3, x4 - x6, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x3, x4 - x6, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x3, x4 - x6, x1 - x3, x5 - x6, x1 - x2] - 
    CiTi[x3, x4 - x6, x1 - x3, x5 - x6, x2 - x3] - 
    CiTi[x3, x4 - x6, x2 - x3, x1, x4 - x5] + CiTi[x3, x4 - x6, x2 - x3, x1, 
     x5 - x6] + CiTi[x3, x4 - x6, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x3, x4 - x6, x2 - x3, x1 - x2, x5 - x6] - 
    CiTi[x3, x4 - x6, x2 - x3, x4 - x5, x1] + CiTi[x3, x4 - x6, x2 - x3, 
     x4 - x5, x1 - x2] + CiTi[x3, x4 - x6, x2 - x3, x5 - x6, x1] - 
    CiTi[x3, x4 - x6, x2 - x3, x5 - x6, x1 - x2] + 
    CiTi[x3, x4 - x6, x4 - x5, x1, x1 - x2] - CiTi[x3, x4 - x6, x4 - x5, x1, 
     x2 - x3] + CiTi[x3, x4 - x6, x4 - x5, x2, x1] - 
    CiTi[x3, x4 - x6, x4 - x5, x2, x1 - x2] - CiTi[x3, x4 - x6, x4 - x5, 
     x1 - x3, x1 - x2] + CiTi[x3, x4 - x6, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x3, x4 - x6, x4 - x5, x2 - x3, x1] + CiTi[x3, x4 - x6, x4 - x5, 
     x2 - x3, x1 - x2] - CiTi[x3, x4 - x6, x5 - x6, x1, x1 - x2] + 
    CiTi[x3, x4 - x6, x5 - x6, x1, x2 - x3] - CiTi[x3, x4 - x6, x5 - x6, x2, 
     x1] + CiTi[x3, x4 - x6, x5 - x6, x2, x1 - x2] + 
    CiTi[x3, x4 - x6, x5 - x6, x1 - x3, x1 - x2] - 
    CiTi[x3, x4 - x6, x5 - x6, x1 - x3, x2 - x3] + 
    CiTi[x3, x4 - x6, x5 - x6, x2 - x3, x1] - CiTi[x3, x4 - x6, x5 - x6, 
     x2 - x3, x1 - x2] + CiTi[x3, x5 - x6, x1, x1 - x2, x3 - x4] - 
    CiTi[x3, x5 - x6, x1, x1 - x2, x4 - x5] - CiTi[x3, x5 - x6, x1, x2 - x3, 
     x3 - x4] + CiTi[x3, x5 - x6, x1, x2 - x3, x4 - x5] + 
    CiTi[x3, x5 - x6, x1, x3 - x4, x1 - x2] - CiTi[x3, x5 - x6, x1, x3 - x4, 
     x2 - x3] - CiTi[x3, x5 - x6, x1, x4 - x5, x1 - x2] + 
    CiTi[x3, x5 - x6, x1, x4 - x5, x2 - x3] + CiTi[x3, x5 - x6, x2, x1, 
     x3 - x4] - CiTi[x3, x5 - x6, x2, x1, x4 - x5] - 
    CiTi[x3, x5 - x6, x2, x1 - x2, x3 - x4] + CiTi[x3, x5 - x6, x2, x1 - x2, 
     x4 - x5] + CiTi[x3, x5 - x6, x2, x3 - x4, x1] - 
    CiTi[x3, x5 - x6, x2, x3 - x4, x1 - x2] - CiTi[x3, x5 - x6, x2, x4 - x5, 
     x1] + CiTi[x3, x5 - x6, x2, x4 - x5, x1 - x2] - 
    CiTi[x3, x5 - x6, x1 - x3, x1 - x2, x3 - x4] + 
    CiTi[x3, x5 - x6, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x3, x5 - x6, x1 - x3, x2 - x3, x3 - x4] - 
    CiTi[x3, x5 - x6, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x3, x5 - x6, x1 - x3, x3 - x4, x1 - x2] + 
    CiTi[x3, x5 - x6, x1 - x3, x3 - x4, x2 - x3] + 
    CiTi[x3, x5 - x6, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x3, x5 - x6, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x3, x5 - x6, x2 - x3, x1, x3 - x4] + CiTi[x3, x5 - x6, x2 - x3, x1, 
     x4 - x5] + CiTi[x3, x5 - x6, x2 - x3, x1 - x2, x3 - x4] - 
    CiTi[x3, x5 - x6, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x3, x5 - x6, x2 - x3, x3 - x4, x1] + CiTi[x3, x5 - x6, x2 - x3, 
     x3 - x4, x1 - x2] + CiTi[x3, x5 - x6, x2 - x3, x4 - x5, x1] - 
    CiTi[x3, x5 - x6, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x3, x5 - x6, x3 - x4, x1, x1 - x2] - CiTi[x3, x5 - x6, x3 - x4, x1, 
     x2 - x3] + CiTi[x3, x5 - x6, x3 - x4, x2, x1] - 
    CiTi[x3, x5 - x6, x3 - x4, x2, x1 - x2] - CiTi[x3, x5 - x6, x3 - x4, 
     x1 - x3, x1 - x2] + CiTi[x3, x5 - x6, x3 - x4, x1 - x3, x2 - x3] - 
    CiTi[x3, x5 - x6, x3 - x4, x2 - x3, x1] + CiTi[x3, x5 - x6, x3 - x4, 
     x2 - x3, x1 - x2] - CiTi[x3, x5 - x6, x4 - x5, x1, x1 - x2] + 
    CiTi[x3, x5 - x6, x4 - x5, x1, x2 - x3] - CiTi[x3, x5 - x6, x4 - x5, x2, 
     x1] + CiTi[x3, x5 - x6, x4 - x5, x2, x1 - x2] + 
    CiTi[x3, x5 - x6, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x3, x5 - x6, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x3, x5 - x6, x4 - x5, x2 - x3, x1] - CiTi[x3, x5 - x6, x4 - x5, 
     x2 - x3, x1 - x2] - CiTi[x4, x1, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x4, x1, x1 - x2, x2 - x3, x5 - x6] + CiTi[x4, x1, x1 - x2, x3 - x4, 
     x4 - x5] - CiTi[x4, x1, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x4, x1, x1 - x2, x4 - x5, x2 - x3] + CiTi[x4, x1, x1 - x2, x4 - x5, 
     x3 - x4] + CiTi[x4, x1, x1 - x2, x5 - x6, x2 - x3] - 
    CiTi[x4, x1, x1 - x2, x5 - x6, x3 - x4] - CiTi[x4, x1, x1 - x3, x1 - x2, 
     x4 - x5] + CiTi[x4, x1, x1 - x3, x1 - x2, x5 - x6] + 
    CiTi[x4, x1, x1 - x3, x2 - x3, x4 - x5] - CiTi[x4, x1, x1 - x3, x2 - x3, 
     x5 - x6] - CiTi[x4, x1, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x4, x1, x1 - x3, x4 - x5, x2 - x3] + CiTi[x4, x1, x1 - x3, x5 - x6, 
     x1 - x2] - CiTi[x4, x1, x1 - x3, x5 - x6, x2 - x3] + 
    CiTi[x4, x1, x2 - x4, x2 - x3, x4 - x5] - CiTi[x4, x1, x2 - x4, x2 - x3, 
     x5 - x6] - CiTi[x4, x1, x2 - x4, x3 - x4, x4 - x5] + 
    CiTi[x4, x1, x2 - x4, x3 - x4, x5 - x6] + CiTi[x4, x1, x2 - x4, x4 - x5, 
     x2 - x3] - CiTi[x4, x1, x2 - x4, x4 - x5, x3 - x4] - 
    CiTi[x4, x1, x2 - x4, x5 - x6, x2 - x3] + CiTi[x4, x1, x2 - x4, x5 - x6, 
     x3 - x4] + CiTi[x4, x1, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x4, x1, x3 - x4, x1 - x2, x5 - x6] - CiTi[x4, x1, x3 - x4, x2 - x3, 
     x4 - x5] + CiTi[x4, x1, x3 - x4, x2 - x3, x5 - x6] + 
    CiTi[x4, x1, x3 - x4, x4 - x5, x1 - x2] - CiTi[x4, x1, x3 - x4, x4 - x5, 
     x2 - x3] - CiTi[x4, x1, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x4, x1, x3 - x4, x5 - x6, x2 - x3] - CiTi[x4, x1, x4 - x5, x1 - x2, 
     x2 - x3] + CiTi[x4, x1, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x4, x1, x4 - x5, x1 - x3, x1 - x2] + CiTi[x4, x1, x4 - x5, x1 - x3, 
     x2 - x3] + CiTi[x4, x1, x4 - x5, x2 - x4, x2 - x3] - 
    CiTi[x4, x1, x4 - x5, x2 - x4, x3 - x4] + CiTi[x4, x1, x4 - x5, x3 - x4, 
     x1 - x2] - CiTi[x4, x1, x4 - x5, x3 - x4, x2 - x3] + 
    CiTi[x4, x1, x5 - x6, x1 - x2, x2 - x3] - CiTi[x4, x1, x5 - x6, x1 - x2, 
     x3 - x4] + CiTi[x4, x1, x5 - x6, x1 - x3, x1 - x2] - 
    CiTi[x4, x1, x5 - x6, x1 - x3, x2 - x3] - CiTi[x4, x1, x5 - x6, x2 - x4, 
     x2 - x3] + CiTi[x4, x1, x5 - x6, x2 - x4, x3 - x4] - 
    CiTi[x4, x1, x5 - x6, x3 - x4, x1 - x2] + CiTi[x4, x1, x5 - x6, x3 - x4, 
     x2 - x3] - CiTi[x4, x2, x1, x2 - x3, x4 - x5] + 
    CiTi[x4, x2, x1, x2 - x3, x5 - x6] + CiTi[x4, x2, x1, x3 - x4, x4 - x5] - 
    CiTi[x4, x2, x1, x3 - x4, x5 - x6] - CiTi[x4, x2, x1, x4 - x5, x2 - x3] + 
    CiTi[x4, x2, x1, x4 - x5, x3 - x4] + CiTi[x4, x2, x1, x5 - x6, x2 - x3] - 
    CiTi[x4, x2, x1, x5 - x6, x3 - x4] + CiTi[x4, x2, x1 - x2, x2 - x3, 
     x4 - x5] - CiTi[x4, x2, x1 - x2, x2 - x3, x5 - x6] - 
    CiTi[x4, x2, x1 - x2, x3 - x4, x4 - x5] + CiTi[x4, x2, x1 - x2, x3 - x4, 
     x5 - x6] + CiTi[x4, x2, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x4, x2, x1 - x2, x4 - x5, x3 - x4] - CiTi[x4, x2, x1 - x2, x5 - x6, 
     x2 - x3] + CiTi[x4, x2, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x4, x2, x2 - x3, x1, x4 - x5] + CiTi[x4, x2, x2 - x3, x1, x5 - x6] + 
    CiTi[x4, x2, x2 - x3, x1 - x2, x4 - x5] - CiTi[x4, x2, x2 - x3, x1 - x2, 
     x5 - x6] - CiTi[x4, x2, x2 - x3, x4 - x5, x1] + 
    CiTi[x4, x2, x2 - x3, x4 - x5, x1 - x2] + CiTi[x4, x2, x2 - x3, x5 - x6, 
     x1] - CiTi[x4, x2, x2 - x3, x5 - x6, x1 - x2] + 
    CiTi[x4, x2, x3 - x4, x1, x4 - x5] - CiTi[x4, x2, x3 - x4, x1, x5 - x6] - 
    CiTi[x4, x2, x3 - x4, x1 - x2, x4 - x5] + CiTi[x4, x2, x3 - x4, x1 - x2, 
     x5 - x6] + CiTi[x4, x2, x3 - x4, x4 - x5, x1] - 
    CiTi[x4, x2, x3 - x4, x4 - x5, x1 - x2] - CiTi[x4, x2, x3 - x4, x5 - x6, 
     x1] + CiTi[x4, x2, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x4, x2, x4 - x5, x1, x2 - x3] + CiTi[x4, x2, x4 - x5, x1, x3 - x4] + 
    CiTi[x4, x2, x4 - x5, x1 - x2, x2 - x3] - CiTi[x4, x2, x4 - x5, x1 - x2, 
     x3 - x4] - CiTi[x4, x2, x4 - x5, x2 - x3, x1] + 
    CiTi[x4, x2, x4 - x5, x2 - x3, x1 - x2] + CiTi[x4, x2, x4 - x5, x3 - x4, 
     x1] - CiTi[x4, x2, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x4, x2, x5 - x6, x1, x2 - x3] - CiTi[x4, x2, x5 - x6, x1, x3 - x4] - 
    CiTi[x4, x2, x5 - x6, x1 - x2, x2 - x3] + CiTi[x4, x2, x5 - x6, x1 - x2, 
     x3 - x4] + CiTi[x4, x2, x5 - x6, x2 - x3, x1] - 
    CiTi[x4, x2, x5 - x6, x2 - x3, x1 - x2] - CiTi[x4, x2, x5 - x6, x3 - x4, 
     x1] + CiTi[x4, x2, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x4, x3, x1, x1 - x2, x4 - x5] + CiTi[x4, x3, x1, x1 - x2, x5 - x6] + 
    CiTi[x4, x3, x1, x2 - x3, x4 - x5] - CiTi[x4, x3, x1, x2 - x3, x5 - x6] - 
    CiTi[x4, x3, x1, x4 - x5, x1 - x2] + CiTi[x4, x3, x1, x4 - x5, x2 - x3] + 
    CiTi[x4, x3, x1, x5 - x6, x1 - x2] - CiTi[x4, x3, x1, x5 - x6, x2 - x3] - 
    CiTi[x4, x3, x2, x1, x4 - x5] + CiTi[x4, x3, x2, x1, x5 - x6] + 
    CiTi[x4, x3, x2, x1 - x2, x4 - x5] - CiTi[x4, x3, x2, x1 - x2, x5 - x6] - 
    CiTi[x4, x3, x2, x4 - x5, x1] + CiTi[x4, x3, x2, x4 - x5, x1 - x2] + 
    CiTi[x4, x3, x2, x5 - x6, x1] - CiTi[x4, x3, x2, x5 - x6, x1 - x2] + 
    CiTi[x4, x3, x1 - x3, x1 - x2, x4 - x5] - CiTi[x4, x3, x1 - x3, x1 - x2, 
     x5 - x6] - CiTi[x4, x3, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x4, x3, x1 - x3, x2 - x3, x5 - x6] + CiTi[x4, x3, x1 - x3, x4 - x5, 
     x1 - x2] - CiTi[x4, x3, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x4, x3, x1 - x3, x5 - x6, x1 - x2] + CiTi[x4, x3, x1 - x3, x5 - x6, 
     x2 - x3] + CiTi[x4, x3, x2 - x3, x1, x4 - x5] - 
    CiTi[x4, x3, x2 - x3, x1, x5 - x6] - CiTi[x4, x3, x2 - x3, x1 - x2, 
     x4 - x5] + CiTi[x4, x3, x2 - x3, x1 - x2, x5 - x6] + 
    CiTi[x4, x3, x2 - x3, x4 - x5, x1] - CiTi[x4, x3, x2 - x3, x4 - x5, 
     x1 - x2] - CiTi[x4, x3, x2 - x3, x5 - x6, x1] + 
    CiTi[x4, x3, x2 - x3, x5 - x6, x1 - x2] - CiTi[x4, x3, x4 - x5, x1, 
     x1 - x2] + CiTi[x4, x3, x4 - x5, x1, x2 - x3] - 
    CiTi[x4, x3, x4 - x5, x2, x1] + CiTi[x4, x3, x4 - x5, x2, x1 - x2] + 
    CiTi[x4, x3, x4 - x5, x1 - x3, x1 - x2] - CiTi[x4, x3, x4 - x5, x1 - x3, 
     x2 - x3] + CiTi[x4, x3, x4 - x5, x2 - x3, x1] - 
    CiTi[x4, x3, x4 - x5, x2 - x3, x1 - x2] + CiTi[x4, x3, x5 - x6, x1, 
     x1 - x2] - CiTi[x4, x3, x5 - x6, x1, x2 - x3] + 
    CiTi[x4, x3, x5 - x6, x2, x1] - CiTi[x4, x3, x5 - x6, x2, x1 - x2] - 
    CiTi[x4, x3, x5 - x6, x1 - x3, x1 - x2] + CiTi[x4, x3, x5 - x6, x1 - x3, 
     x2 - x3] - CiTi[x4, x3, x5 - x6, x2 - x3, x1] + 
    CiTi[x4, x3, x5 - x6, x2 - x3, x1 - x2] + CiTi[x4, x1 - x4, x1 - x2, 
     x2 - x3, x4 - x5] - CiTi[x4, x1 - x4, x1 - x2, x2 - x3, x5 - x6] - 
    CiTi[x4, x1 - x4, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x4, x1 - x4, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x4, x1 - x4, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x4, x1 - x4, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x4, x1 - x4, x1 - x2, x5 - x6, x2 - x3] + 
    CiTi[x4, x1 - x4, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x4, x1 - x4, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x4, x1 - x4, x1 - x3, x1 - x2, x5 - x6] - 
    CiTi[x4, x1 - x4, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x4, x1 - x4, x1 - x3, x2 - x3, x5 - x6] + 
    CiTi[x4, x1 - x4, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x4, x1 - x4, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x4, x1 - x4, x1 - x3, x5 - x6, x1 - x2] + 
    CiTi[x4, x1 - x4, x1 - x3, x5 - x6, x2 - x3] - 
    CiTi[x4, x1 - x4, x2 - x4, x2 - x3, x4 - x5] + 
    CiTi[x4, x1 - x4, x2 - x4, x2 - x3, x5 - x6] + 
    CiTi[x4, x1 - x4, x2 - x4, x3 - x4, x4 - x5] - 
    CiTi[x4, x1 - x4, x2 - x4, x3 - x4, x5 - x6] - 
    CiTi[x4, x1 - x4, x2 - x4, x4 - x5, x2 - x3] + 
    CiTi[x4, x1 - x4, x2 - x4, x4 - x5, x3 - x4] + 
    CiTi[x4, x1 - x4, x2 - x4, x5 - x6, x2 - x3] - 
    CiTi[x4, x1 - x4, x2 - x4, x5 - x6, x3 - x4] - 
    CiTi[x4, x1 - x4, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x4, x1 - x4, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x4, x1 - x4, x3 - x4, x2 - x3, x4 - x5] - 
    CiTi[x4, x1 - x4, x3 - x4, x2 - x3, x5 - x6] - 
    CiTi[x4, x1 - x4, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x4, x1 - x4, x3 - x4, x4 - x5, x2 - x3] + 
    CiTi[x4, x1 - x4, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x4, x1 - x4, x3 - x4, x5 - x6, x2 - x3] + 
    CiTi[x4, x1 - x4, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x4, x1 - x4, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x4, x1 - x4, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x4, x1 - x4, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x4, x1 - x4, x4 - x5, x2 - x4, x2 - x3] + 
    CiTi[x4, x1 - x4, x4 - x5, x2 - x4, x3 - x4] - 
    CiTi[x4, x1 - x4, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x4, x1 - x4, x4 - x5, x3 - x4, x2 - x3] - 
    CiTi[x4, x1 - x4, x5 - x6, x1 - x2, x2 - x3] + 
    CiTi[x4, x1 - x4, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x4, x1 - x4, x5 - x6, x1 - x3, x1 - x2] + 
    CiTi[x4, x1 - x4, x5 - x6, x1 - x3, x2 - x3] + 
    CiTi[x4, x1 - x4, x5 - x6, x2 - x4, x2 - x3] - 
    CiTi[x4, x1 - x4, x5 - x6, x2 - x4, x3 - x4] + 
    CiTi[x4, x1 - x4, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x4, x1 - x4, x5 - x6, x3 - x4, x2 - x3] + 
    CiTi[x4, x2 - x4, x1, x2 - x3, x4 - x5] - CiTi[x4, x2 - x4, x1, x2 - x3, 
     x5 - x6] - CiTi[x4, x2 - x4, x1, x3 - x4, x4 - x5] + 
    CiTi[x4, x2 - x4, x1, x3 - x4, x5 - x6] + CiTi[x4, x2 - x4, x1, x4 - x5, 
     x2 - x3] - CiTi[x4, x2 - x4, x1, x4 - x5, x3 - x4] - 
    CiTi[x4, x2 - x4, x1, x5 - x6, x2 - x3] + CiTi[x4, x2 - x4, x1, x5 - x6, 
     x3 - x4] - CiTi[x4, x2 - x4, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x4, x2 - x4, x1 - x2, x2 - x3, x5 - x6] + 
    CiTi[x4, x2 - x4, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x4, x2 - x4, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x4, x2 - x4, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x4, x2 - x4, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x4, x2 - x4, x1 - x2, x5 - x6, x2 - x3] - 
    CiTi[x4, x2 - x4, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x4, x2 - x4, x2 - x3, x1, x4 - x5] - CiTi[x4, x2 - x4, x2 - x3, x1, 
     x5 - x6] - CiTi[x4, x2 - x4, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x4, x2 - x4, x2 - x3, x1 - x2, x5 - x6] + 
    CiTi[x4, x2 - x4, x2 - x3, x4 - x5, x1] - CiTi[x4, x2 - x4, x2 - x3, 
     x4 - x5, x1 - x2] - CiTi[x4, x2 - x4, x2 - x3, x5 - x6, x1] + 
    CiTi[x4, x2 - x4, x2 - x3, x5 - x6, x1 - x2] - 
    CiTi[x4, x2 - x4, x3 - x4, x1, x4 - x5] + CiTi[x4, x2 - x4, x3 - x4, x1, 
     x5 - x6] + CiTi[x4, x2 - x4, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x4, x2 - x4, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x4, x2 - x4, x3 - x4, x4 - x5, x1] + CiTi[x4, x2 - x4, x3 - x4, 
     x4 - x5, x1 - x2] + CiTi[x4, x2 - x4, x3 - x4, x5 - x6, x1] - 
    CiTi[x4, x2 - x4, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x4, x2 - x4, x4 - x5, x1, x2 - x3] - CiTi[x4, x2 - x4, x4 - x5, x1, 
     x3 - x4] - CiTi[x4, x2 - x4, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x4, x2 - x4, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x4, x2 - x4, x4 - x5, x2 - x3, x1] - CiTi[x4, x2 - x4, x4 - x5, 
     x2 - x3, x1 - x2] - CiTi[x4, x2 - x4, x4 - x5, x3 - x4, x1] + 
    CiTi[x4, x2 - x4, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x4, x2 - x4, x5 - x6, x1, x2 - x3] + CiTi[x4, x2 - x4, x5 - x6, x1, 
     x3 - x4] + CiTi[x4, x2 - x4, x5 - x6, x1 - x2, x2 - x3] - 
    CiTi[x4, x2 - x4, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x4, x2 - x4, x5 - x6, x2 - x3, x1] + CiTi[x4, x2 - x4, x5 - x6, 
     x2 - x3, x1 - x2] + CiTi[x4, x2 - x4, x5 - x6, x3 - x4, x1] - 
    CiTi[x4, x2 - x4, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x4, x3 - x4, x1, x1 - x2, x4 - x5] - CiTi[x4, x3 - x4, x1, x1 - x2, 
     x5 - x6] - CiTi[x4, x3 - x4, x1, x2 - x3, x4 - x5] + 
    CiTi[x4, x3 - x4, x1, x2 - x3, x5 - x6] + CiTi[x4, x3 - x4, x1, x4 - x5, 
     x1 - x2] - CiTi[x4, x3 - x4, x1, x4 - x5, x2 - x3] - 
    CiTi[x4, x3 - x4, x1, x5 - x6, x1 - x2] + CiTi[x4, x3 - x4, x1, x5 - x6, 
     x2 - x3] + CiTi[x4, x3 - x4, x2, x1, x4 - x5] - 
    CiTi[x4, x3 - x4, x2, x1, x5 - x6] - CiTi[x4, x3 - x4, x2, x1 - x2, 
     x4 - x5] + CiTi[x4, x3 - x4, x2, x1 - x2, x5 - x6] + 
    CiTi[x4, x3 - x4, x2, x4 - x5, x1] - CiTi[x4, x3 - x4, x2, x4 - x5, 
     x1 - x2] - CiTi[x4, x3 - x4, x2, x5 - x6, x1] + 
    CiTi[x4, x3 - x4, x2, x5 - x6, x1 - x2] - CiTi[x4, x3 - x4, x1 - x3, 
     x1 - x2, x4 - x5] + CiTi[x4, x3 - x4, x1 - x3, x1 - x2, x5 - x6] + 
    CiTi[x4, x3 - x4, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x4, x3 - x4, x1 - x3, x2 - x3, x5 - x6] - 
    CiTi[x4, x3 - x4, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x4, x3 - x4, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x4, x3 - x4, x1 - x3, x5 - x6, x1 - x2] - 
    CiTi[x4, x3 - x4, x1 - x3, x5 - x6, x2 - x3] - 
    CiTi[x4, x3 - x4, x2 - x3, x1, x4 - x5] + CiTi[x4, x3 - x4, x2 - x3, x1, 
     x5 - x6] + CiTi[x4, x3 - x4, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x4, x3 - x4, x2 - x3, x1 - x2, x5 - x6] - 
    CiTi[x4, x3 - x4, x2 - x3, x4 - x5, x1] + CiTi[x4, x3 - x4, x2 - x3, 
     x4 - x5, x1 - x2] + CiTi[x4, x3 - x4, x2 - x3, x5 - x6, x1] - 
    CiTi[x4, x3 - x4, x2 - x3, x5 - x6, x1 - x2] + 
    CiTi[x4, x3 - x4, x4 - x5, x1, x1 - x2] - CiTi[x4, x3 - x4, x4 - x5, x1, 
     x2 - x3] + CiTi[x4, x3 - x4, x4 - x5, x2, x1] - 
    CiTi[x4, x3 - x4, x4 - x5, x2, x1 - x2] - CiTi[x4, x3 - x4, x4 - x5, 
     x1 - x3, x1 - x2] + CiTi[x4, x3 - x4, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x4, x3 - x4, x4 - x5, x2 - x3, x1] + CiTi[x4, x3 - x4, x4 - x5, 
     x2 - x3, x1 - x2] - CiTi[x4, x3 - x4, x5 - x6, x1, x1 - x2] + 
    CiTi[x4, x3 - x4, x5 - x6, x1, x2 - x3] - CiTi[x4, x3 - x4, x5 - x6, x2, 
     x1] + CiTi[x4, x3 - x4, x5 - x6, x2, x1 - x2] + 
    CiTi[x4, x3 - x4, x5 - x6, x1 - x3, x1 - x2] - 
    CiTi[x4, x3 - x4, x5 - x6, x1 - x3, x2 - x3] + 
    CiTi[x4, x3 - x4, x5 - x6, x2 - x3, x1] - CiTi[x4, x3 - x4, x5 - x6, 
     x2 - x3, x1 - x2] - CiTi[x4, x4 - x5, x1, x1 - x2, x2 - x3] + 
    CiTi[x4, x4 - x5, x1, x1 - x2, x3 - x4] - CiTi[x4, x4 - x5, x1, x1 - x3, 
     x1 - x2] + CiTi[x4, x4 - x5, x1, x1 - x3, x2 - x3] + 
    CiTi[x4, x4 - x5, x1, x2 - x4, x2 - x3] - CiTi[x4, x4 - x5, x1, x2 - x4, 
     x3 - x4] + CiTi[x4, x4 - x5, x1, x3 - x4, x1 - x2] - 
    CiTi[x4, x4 - x5, x1, x3 - x4, x2 - x3] - CiTi[x4, x4 - x5, x2, x1, 
     x2 - x3] + CiTi[x4, x4 - x5, x2, x1, x3 - x4] + 
    CiTi[x4, x4 - x5, x2, x1 - x2, x2 - x3] - CiTi[x4, x4 - x5, x2, x1 - x2, 
     x3 - x4] - CiTi[x4, x4 - x5, x2, x2 - x3, x1] + 
    CiTi[x4, x4 - x5, x2, x2 - x3, x1 - x2] + CiTi[x4, x4 - x5, x2, x3 - x4, 
     x1] - CiTi[x4, x4 - x5, x2, x3 - x4, x1 - x2] - 
    CiTi[x4, x4 - x5, x3, x1, x1 - x2] + CiTi[x4, x4 - x5, x3, x1, x2 - x3] - 
    CiTi[x4, x4 - x5, x3, x2, x1] + CiTi[x4, x4 - x5, x3, x2, x1 - x2] + 
    CiTi[x4, x4 - x5, x3, x1 - x3, x1 - x2] - CiTi[x4, x4 - x5, x3, x1 - x3, 
     x2 - x3] + CiTi[x4, x4 - x5, x3, x2 - x3, x1] - 
    CiTi[x4, x4 - x5, x3, x2 - x3, x1 - x2] + CiTi[x4, x4 - x5, x1 - x4, 
     x1 - x2, x2 - x3] - CiTi[x4, x4 - x5, x1 - x4, x1 - x2, x3 - x4] + 
    CiTi[x4, x4 - x5, x1 - x4, x1 - x3, x1 - x2] - 
    CiTi[x4, x4 - x5, x1 - x4, x1 - x3, x2 - x3] - 
    CiTi[x4, x4 - x5, x1 - x4, x2 - x4, x2 - x3] + 
    CiTi[x4, x4 - x5, x1 - x4, x2 - x4, x3 - x4] - 
    CiTi[x4, x4 - x5, x1 - x4, x3 - x4, x1 - x2] + 
    CiTi[x4, x4 - x5, x1 - x4, x3 - x4, x2 - x3] + 
    CiTi[x4, x4 - x5, x2 - x4, x1, x2 - x3] - CiTi[x4, x4 - x5, x2 - x4, x1, 
     x3 - x4] - CiTi[x4, x4 - x5, x2 - x4, x1 - x2, x2 - x3] + 
    CiTi[x4, x4 - x5, x2 - x4, x1 - x2, x3 - x4] + 
    CiTi[x4, x4 - x5, x2 - x4, x2 - x3, x1] - CiTi[x4, x4 - x5, x2 - x4, 
     x2 - x3, x1 - x2] - CiTi[x4, x4 - x5, x2 - x4, x3 - x4, x1] + 
    CiTi[x4, x4 - x5, x2 - x4, x3 - x4, x1 - x2] + 
    CiTi[x4, x4 - x5, x3 - x4, x1, x1 - x2] - CiTi[x4, x4 - x5, x3 - x4, x1, 
     x2 - x3] + CiTi[x4, x4 - x5, x3 - x4, x2, x1] - 
    CiTi[x4, x4 - x5, x3 - x4, x2, x1 - x2] - CiTi[x4, x4 - x5, x3 - x4, 
     x1 - x3, x1 - x2] + CiTi[x4, x4 - x5, x3 - x4, x1 - x3, x2 - x3] - 
    CiTi[x4, x4 - x5, x3 - x4, x2 - x3, x1] + CiTi[x4, x4 - x5, x3 - x4, 
     x2 - x3, x1 - x2] + CiTi[x4, x5 - x6, x1, x1 - x2, x2 - x3] - 
    CiTi[x4, x5 - x6, x1, x1 - x2, x3 - x4] + CiTi[x4, x5 - x6, x1, x1 - x3, 
     x1 - x2] - CiTi[x4, x5 - x6, x1, x1 - x3, x2 - x3] - 
    CiTi[x4, x5 - x6, x1, x2 - x4, x2 - x3] + CiTi[x4, x5 - x6, x1, x2 - x4, 
     x3 - x4] - CiTi[x4, x5 - x6, x1, x3 - x4, x1 - x2] + 
    CiTi[x4, x5 - x6, x1, x3 - x4, x2 - x3] + CiTi[x4, x5 - x6, x2, x1, 
     x2 - x3] - CiTi[x4, x5 - x6, x2, x1, x3 - x4] - 
    CiTi[x4, x5 - x6, x2, x1 - x2, x2 - x3] + CiTi[x4, x5 - x6, x2, x1 - x2, 
     x3 - x4] + CiTi[x4, x5 - x6, x2, x2 - x3, x1] - 
    CiTi[x4, x5 - x6, x2, x2 - x3, x1 - x2] - CiTi[x4, x5 - x6, x2, x3 - x4, 
     x1] + CiTi[x4, x5 - x6, x2, x3 - x4, x1 - x2] + 
    CiTi[x4, x5 - x6, x3, x1, x1 - x2] - CiTi[x4, x5 - x6, x3, x1, x2 - x3] + 
    CiTi[x4, x5 - x6, x3, x2, x1] - CiTi[x4, x5 - x6, x3, x2, x1 - x2] - 
    CiTi[x4, x5 - x6, x3, x1 - x3, x1 - x2] + CiTi[x4, x5 - x6, x3, x1 - x3, 
     x2 - x3] - CiTi[x4, x5 - x6, x3, x2 - x3, x1] + 
    CiTi[x4, x5 - x6, x3, x2 - x3, x1 - x2] - CiTi[x4, x5 - x6, x1 - x4, 
     x1 - x2, x2 - x3] + CiTi[x4, x5 - x6, x1 - x4, x1 - x2, x3 - x4] - 
    CiTi[x4, x5 - x6, x1 - x4, x1 - x3, x1 - x2] + 
    CiTi[x4, x5 - x6, x1 - x4, x1 - x3, x2 - x3] + 
    CiTi[x4, x5 - x6, x1 - x4, x2 - x4, x2 - x3] - 
    CiTi[x4, x5 - x6, x1 - x4, x2 - x4, x3 - x4] + 
    CiTi[x4, x5 - x6, x1 - x4, x3 - x4, x1 - x2] - 
    CiTi[x4, x5 - x6, x1 - x4, x3 - x4, x2 - x3] - 
    CiTi[x4, x5 - x6, x2 - x4, x1, x2 - x3] + CiTi[x4, x5 - x6, x2 - x4, x1, 
     x3 - x4] + CiTi[x4, x5 - x6, x2 - x4, x1 - x2, x2 - x3] - 
    CiTi[x4, x5 - x6, x2 - x4, x1 - x2, x3 - x4] - 
    CiTi[x4, x5 - x6, x2 - x4, x2 - x3, x1] + CiTi[x4, x5 - x6, x2 - x4, 
     x2 - x3, x1 - x2] + CiTi[x4, x5 - x6, x2 - x4, x3 - x4, x1] - 
    CiTi[x4, x5 - x6, x2 - x4, x3 - x4, x1 - x2] - 
    CiTi[x4, x5 - x6, x3 - x4, x1, x1 - x2] + CiTi[x4, x5 - x6, x3 - x4, x1, 
     x2 - x3] - CiTi[x4, x5 - x6, x3 - x4, x2, x1] + 
    CiTi[x4, x5 - x6, x3 - x4, x2, x1 - x2] + CiTi[x4, x5 - x6, x3 - x4, 
     x1 - x3, x1 - x2] - CiTi[x4, x5 - x6, x3 - x4, x1 - x3, x2 - x3] + 
    CiTi[x4, x5 - x6, x3 - x4, x2 - x3, x1] - CiTi[x4, x5 - x6, x3 - x4, 
     x2 - x3, x1 - x2] - CiTi[x5, x1, x1 - x2, x2 - x3, x3 - x4] + 
    CiTi[x5, x1, x1 - x2, x2 - x3, x4 - x5] - CiTi[x5, x1, x1 - x2, x2 - x4, 
     x2 - x3] + CiTi[x5, x1, x1 - x2, x2 - x4, x3 - x4] + 
    CiTi[x5, x1, x1 - x2, x3 - x5, x3 - x4] - CiTi[x5, x1, x1 - x2, x3 - x5, 
     x4 - x5] + CiTi[x5, x1, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x5, x1, x1 - x2, x4 - x5, x3 - x4] - CiTi[x5, x1, x1 - x3, x1 - x2, 
     x3 - x4] + CiTi[x5, x1, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x5, x1, x1 - x3, x2 - x3, x3 - x4] - CiTi[x5, x1, x1 - x3, x2 - x3, 
     x4 - x5] - CiTi[x5, x1, x1 - x3, x3 - x4, x1 - x2] + 
    CiTi[x5, x1, x1 - x3, x3 - x4, x2 - x3] + CiTi[x5, x1, x1 - x3, x4 - x5, 
     x1 - x2] - CiTi[x5, x1, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x5, x1, x1 - x4, x1 - x2, x2 - x3] + CiTi[x5, x1, x1 - x4, x1 - x2, 
     x3 - x4] - CiTi[x5, x1, x1 - x4, x1 - x3, x1 - x2] + 
    CiTi[x5, x1, x1 - x4, x1 - x3, x2 - x3] + CiTi[x5, x1, x1 - x4, x2 - x4, 
     x2 - x3] - CiTi[x5, x1, x1 - x4, x2 - x4, x3 - x4] + 
    CiTi[x5, x1, x1 - x4, x3 - x4, x1 - x2] - CiTi[x5, x1, x1 - x4, x3 - x4, 
     x2 - x3] + CiTi[x5, x1, x2 - x5, x2 - x3, x3 - x4] - 
    CiTi[x5, x1, x2 - x5, x2 - x3, x4 - x5] + CiTi[x5, x1, x2 - x5, x2 - x4, 
     x2 - x3] - CiTi[x5, x1, x2 - x5, x2 - x4, x3 - x4] - 
    CiTi[x5, x1, x2 - x5, x3 - x5, x3 - x4] + CiTi[x5, x1, x2 - x5, x3 - x5, 
     x4 - x5] - CiTi[x5, x1, x2 - x5, x4 - x5, x2 - x3] + 
    CiTi[x5, x1, x2 - x5, x4 - x5, x3 - x4] + CiTi[x5, x1, x3 - x5, x1 - x2, 
     x3 - x4] - CiTi[x5, x1, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x5, x1, x3 - x5, x2 - x3, x3 - x4] + CiTi[x5, x1, x3 - x5, x2 - x3, 
     x4 - x5] + CiTi[x5, x1, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x5, x1, x3 - x5, x3 - x4, x2 - x3] - CiTi[x5, x1, x3 - x5, x4 - x5, 
     x1 - x2] + CiTi[x5, x1, x3 - x5, x4 - x5, x2 - x3] + 
    CiTi[x5, x1, x4 - x5, x1 - x2, x2 - x3] - CiTi[x5, x1, x4 - x5, x1 - x2, 
     x3 - x4] + CiTi[x5, x1, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x5, x1, x4 - x5, x1 - x3, x2 - x3] - CiTi[x5, x1, x4 - x5, x2 - x4, 
     x2 - x3] + CiTi[x5, x1, x4 - x5, x2 - x4, x3 - x4] - 
    CiTi[x5, x1, x4 - x5, x3 - x4, x1 - x2] + CiTi[x5, x1, x4 - x5, x3 - x4, 
     x2 - x3] - CiTi[x5, x2, x1, x2 - x3, x3 - x4] + 
    CiTi[x5, x2, x1, x2 - x3, x4 - x5] - CiTi[x5, x2, x1, x2 - x4, x2 - x3] + 
    CiTi[x5, x2, x1, x2 - x4, x3 - x4] + CiTi[x5, x2, x1, x3 - x5, x3 - x4] - 
    CiTi[x5, x2, x1, x3 - x5, x4 - x5] + CiTi[x5, x2, x1, x4 - x5, x2 - x3] - 
    CiTi[x5, x2, x1, x4 - x5, x3 - x4] + CiTi[x5, x2, x1 - x2, x2 - x3, 
     x3 - x4] - CiTi[x5, x2, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x5, x2, x1 - x2, x2 - x4, x2 - x3] - CiTi[x5, x2, x1 - x2, x2 - x4, 
     x3 - x4] - CiTi[x5, x2, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x5, x2, x1 - x2, x3 - x5, x4 - x5] - CiTi[x5, x2, x1 - x2, x4 - x5, 
     x2 - x3] + CiTi[x5, x2, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x5, x2, x2 - x3, x1, x3 - x4] + CiTi[x5, x2, x2 - x3, x1, x4 - x5] + 
    CiTi[x5, x2, x2 - x3, x1 - x2, x3 - x4] - CiTi[x5, x2, x2 - x3, x1 - x2, 
     x4 - x5] - CiTi[x5, x2, x2 - x3, x3 - x4, x1] + 
    CiTi[x5, x2, x2 - x3, x3 - x4, x1 - x2] + CiTi[x5, x2, x2 - x3, x4 - x5, 
     x1] - CiTi[x5, x2, x2 - x3, x4 - x5, x1 - x2] - 
    CiTi[x5, x2, x2 - x4, x1, x2 - x3] + CiTi[x5, x2, x2 - x4, x1, x3 - x4] + 
    CiTi[x5, x2, x2 - x4, x1 - x2, x2 - x3] - CiTi[x5, x2, x2 - x4, x1 - x2, 
     x3 - x4] - CiTi[x5, x2, x2 - x4, x2 - x3, x1] + 
    CiTi[x5, x2, x2 - x4, x2 - x3, x1 - x2] + CiTi[x5, x2, x2 - x4, x3 - x4, 
     x1] - CiTi[x5, x2, x2 - x4, x3 - x4, x1 - x2] + 
    CiTi[x5, x2, x3 - x5, x1, x3 - x4] - CiTi[x5, x2, x3 - x5, x1, x4 - x5] - 
    CiTi[x5, x2, x3 - x5, x1 - x2, x3 - x4] + CiTi[x5, x2, x3 - x5, x1 - x2, 
     x4 - x5] + CiTi[x5, x2, x3 - x5, x3 - x4, x1] - 
    CiTi[x5, x2, x3 - x5, x3 - x4, x1 - x2] - CiTi[x5, x2, x3 - x5, x4 - x5, 
     x1] + CiTi[x5, x2, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x5, x2, x4 - x5, x1, x2 - x3] - CiTi[x5, x2, x4 - x5, x1, x3 - x4] - 
    CiTi[x5, x2, x4 - x5, x1 - x2, x2 - x3] + CiTi[x5, x2, x4 - x5, x1 - x2, 
     x3 - x4] + CiTi[x5, x2, x4 - x5, x2 - x3, x1] - 
    CiTi[x5, x2, x4 - x5, x2 - x3, x1 - x2] - CiTi[x5, x2, x4 - x5, x3 - x4, 
     x1] + CiTi[x5, x2, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x5, x3, x1, x1 - x2, x3 - x4] + CiTi[x5, x3, x1, x1 - x2, x4 - x5] + 
    CiTi[x5, x3, x1, x2 - x3, x3 - x4] - CiTi[x5, x3, x1, x2 - x3, x4 - x5] - 
    CiTi[x5, x3, x1, x3 - x4, x1 - x2] + CiTi[x5, x3, x1, x3 - x4, x2 - x3] + 
    CiTi[x5, x3, x1, x4 - x5, x1 - x2] - CiTi[x5, x3, x1, x4 - x5, x2 - x3] - 
    CiTi[x5, x3, x2, x1, x3 - x4] + CiTi[x5, x3, x2, x1, x4 - x5] + 
    CiTi[x5, x3, x2, x1 - x2, x3 - x4] - CiTi[x5, x3, x2, x1 - x2, x4 - x5] - 
    CiTi[x5, x3, x2, x3 - x4, x1] + CiTi[x5, x3, x2, x3 - x4, x1 - x2] + 
    CiTi[x5, x3, x2, x4 - x5, x1] - CiTi[x5, x3, x2, x4 - x5, x1 - x2] + 
    CiTi[x5, x3, x1 - x3, x1 - x2, x3 - x4] - CiTi[x5, x3, x1 - x3, x1 - x2, 
     x4 - x5] - CiTi[x5, x3, x1 - x3, x2 - x3, x3 - x4] + 
    CiTi[x5, x3, x1 - x3, x2 - x3, x4 - x5] + CiTi[x5, x3, x1 - x3, x3 - x4, 
     x1 - x2] - CiTi[x5, x3, x1 - x3, x3 - x4, x2 - x3] - 
    CiTi[x5, x3, x1 - x3, x4 - x5, x1 - x2] + CiTi[x5, x3, x1 - x3, x4 - x5, 
     x2 - x3] + CiTi[x5, x3, x2 - x3, x1, x3 - x4] - 
    CiTi[x5, x3, x2 - x3, x1, x4 - x5] - CiTi[x5, x3, x2 - x3, x1 - x2, 
     x3 - x4] + CiTi[x5, x3, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x5, x3, x2 - x3, x3 - x4, x1] - CiTi[x5, x3, x2 - x3, x3 - x4, 
     x1 - x2] - CiTi[x5, x3, x2 - x3, x4 - x5, x1] + 
    CiTi[x5, x3, x2 - x3, x4 - x5, x1 - x2] - CiTi[x5, x3, x3 - x4, x1, 
     x1 - x2] + CiTi[x5, x3, x3 - x4, x1, x2 - x3] - 
    CiTi[x5, x3, x3 - x4, x2, x1] + CiTi[x5, x3, x3 - x4, x2, x1 - x2] + 
    CiTi[x5, x3, x3 - x4, x1 - x3, x1 - x2] - CiTi[x5, x3, x3 - x4, x1 - x3, 
     x2 - x3] + CiTi[x5, x3, x3 - x4, x2 - x3, x1] - 
    CiTi[x5, x3, x3 - x4, x2 - x3, x1 - x2] + CiTi[x5, x3, x4 - x5, x1, 
     x1 - x2] - CiTi[x5, x3, x4 - x5, x1, x2 - x3] + 
    CiTi[x5, x3, x4 - x5, x2, x1] - CiTi[x5, x3, x4 - x5, x2, x1 - x2] - 
    CiTi[x5, x3, x4 - x5, x1 - x3, x1 - x2] + CiTi[x5, x3, x4 - x5, x1 - x3, 
     x2 - x3] - CiTi[x5, x3, x4 - x5, x2 - x3, x1] + 
    CiTi[x5, x3, x4 - x5, x2 - x3, x1 - x2] - CiTi[x5, x4, x1, x1 - x2, 
     x2 - x3] + CiTi[x5, x4, x1, x1 - x2, x3 - x4] - 
    CiTi[x5, x4, x1, x1 - x3, x1 - x2] + CiTi[x5, x4, x1, x1 - x3, x2 - x3] + 
    CiTi[x5, x4, x1, x2 - x4, x2 - x3] - CiTi[x5, x4, x1, x2 - x4, x3 - x4] + 
    CiTi[x5, x4, x1, x3 - x4, x1 - x2] - CiTi[x5, x4, x1, x3 - x4, x2 - x3] - 
    CiTi[x5, x4, x2, x1, x2 - x3] + CiTi[x5, x4, x2, x1, x3 - x4] + 
    CiTi[x5, x4, x2, x1 - x2, x2 - x3] - CiTi[x5, x4, x2, x1 - x2, x3 - x4] - 
    CiTi[x5, x4, x2, x2 - x3, x1] + CiTi[x5, x4, x2, x2 - x3, x1 - x2] + 
    CiTi[x5, x4, x2, x3 - x4, x1] - CiTi[x5, x4, x2, x3 - x4, x1 - x2] - 
    CiTi[x5, x4, x3, x1, x1 - x2] + CiTi[x5, x4, x3, x1, x2 - x3] - 
    CiTi[x5, x4, x3, x2, x1] + CiTi[x5, x4, x3, x2, x1 - x2] + 
    CiTi[x5, x4, x3, x1 - x3, x1 - x2] - CiTi[x5, x4, x3, x1 - x3, x2 - x3] + 
    CiTi[x5, x4, x3, x2 - x3, x1] - CiTi[x5, x4, x3, x2 - x3, x1 - x2] + 
    CiTi[x5, x4, x1 - x4, x1 - x2, x2 - x3] - CiTi[x5, x4, x1 - x4, x1 - x2, 
     x3 - x4] + CiTi[x5, x4, x1 - x4, x1 - x3, x1 - x2] - 
    CiTi[x5, x4, x1 - x4, x1 - x3, x2 - x3] - CiTi[x5, x4, x1 - x4, x2 - x4, 
     x2 - x3] + CiTi[x5, x4, x1 - x4, x2 - x4, x3 - x4] - 
    CiTi[x5, x4, x1 - x4, x3 - x4, x1 - x2] + CiTi[x5, x4, x1 - x4, x3 - x4, 
     x2 - x3] + CiTi[x5, x4, x2 - x4, x1, x2 - x3] - 
    CiTi[x5, x4, x2 - x4, x1, x3 - x4] - CiTi[x5, x4, x2 - x4, x1 - x2, 
     x2 - x3] + CiTi[x5, x4, x2 - x4, x1 - x2, x3 - x4] + 
    CiTi[x5, x4, x2 - x4, x2 - x3, x1] - CiTi[x5, x4, x2 - x4, x2 - x3, 
     x1 - x2] - CiTi[x5, x4, x2 - x4, x3 - x4, x1] + 
    CiTi[x5, x4, x2 - x4, x3 - x4, x1 - x2] + CiTi[x5, x4, x3 - x4, x1, 
     x1 - x2] - CiTi[x5, x4, x3 - x4, x1, x2 - x3] + 
    CiTi[x5, x4, x3 - x4, x2, x1] - CiTi[x5, x4, x3 - x4, x2, x1 - x2] - 
    CiTi[x5, x4, x3 - x4, x1 - x3, x1 - x2] + CiTi[x5, x4, x3 - x4, x1 - x3, 
     x2 - x3] - CiTi[x5, x4, x3 - x4, x2 - x3, x1] + 
    CiTi[x5, x4, x3 - x4, x2 - x3, x1 - x2] + CiTi[x5, x1 - x5, x1 - x2, 
     x2 - x3, x3 - x4] - CiTi[x5, x1 - x5, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x5, x1 - x5, x1 - x2, x2 - x4, x2 - x3] - 
    CiTi[x5, x1 - x5, x1 - x2, x2 - x4, x3 - x4] - 
    CiTi[x5, x1 - x5, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x5, x1 - x5, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x5, x1 - x5, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x5, x1 - x5, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x5, x1 - x5, x1 - x3, x1 - x2, x3 - x4] - 
    CiTi[x5, x1 - x5, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x5, x1 - x5, x1 - x3, x2 - x3, x3 - x4] + 
    CiTi[x5, x1 - x5, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x5, x1 - x5, x1 - x3, x3 - x4, x1 - x2] - 
    CiTi[x5, x1 - x5, x1 - x3, x3 - x4, x2 - x3] - 
    CiTi[x5, x1 - x5, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x5, x1 - x5, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x5, x1 - x5, x1 - x4, x1 - x2, x2 - x3] - 
    CiTi[x5, x1 - x5, x1 - x4, x1 - x2, x3 - x4] + 
    CiTi[x5, x1 - x5, x1 - x4, x1 - x3, x1 - x2] - 
    CiTi[x5, x1 - x5, x1 - x4, x1 - x3, x2 - x3] - 
    CiTi[x5, x1 - x5, x1 - x4, x2 - x4, x2 - x3] + 
    CiTi[x5, x1 - x5, x1 - x4, x2 - x4, x3 - x4] - 
    CiTi[x5, x1 - x5, x1 - x4, x3 - x4, x1 - x2] + 
    CiTi[x5, x1 - x5, x1 - x4, x3 - x4, x2 - x3] - 
    CiTi[x5, x1 - x5, x2 - x5, x2 - x3, x3 - x4] + 
    CiTi[x5, x1 - x5, x2 - x5, x2 - x3, x4 - x5] - 
    CiTi[x5, x1 - x5, x2 - x5, x2 - x4, x2 - x3] + 
    CiTi[x5, x1 - x5, x2 - x5, x2 - x4, x3 - x4] + 
    CiTi[x5, x1 - x5, x2 - x5, x3 - x5, x3 - x4] - 
    CiTi[x5, x1 - x5, x2 - x5, x3 - x5, x4 - x5] + 
    CiTi[x5, x1 - x5, x2 - x5, x4 - x5, x2 - x3] - 
    CiTi[x5, x1 - x5, x2 - x5, x4 - x5, x3 - x4] - 
    CiTi[x5, x1 - x5, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x5, x1 - x5, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x5, x1 - x5, x3 - x5, x2 - x3, x3 - x4] - 
    CiTi[x5, x1 - x5, x3 - x5, x2 - x3, x4 - x5] - 
    CiTi[x5, x1 - x5, x3 - x5, x3 - x4, x1 - x2] + 
    CiTi[x5, x1 - x5, x3 - x5, x3 - x4, x2 - x3] + 
    CiTi[x5, x1 - x5, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x5, x1 - x5, x3 - x5, x4 - x5, x2 - x3] - 
    CiTi[x5, x1 - x5, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x5, x1 - x5, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x5, x1 - x5, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x5, x1 - x5, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x5, x1 - x5, x4 - x5, x2 - x4, x2 - x3] - 
    CiTi[x5, x1 - x5, x4 - x5, x2 - x4, x3 - x4] + 
    CiTi[x5, x1 - x5, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x5, x1 - x5, x4 - x5, x3 - x4, x2 - x3] + 
    CiTi[x5, x2 - x5, x1, x2 - x3, x3 - x4] - CiTi[x5, x2 - x5, x1, x2 - x3, 
     x4 - x5] + CiTi[x5, x2 - x5, x1, x2 - x4, x2 - x3] - 
    CiTi[x5, x2 - x5, x1, x2 - x4, x3 - x4] - CiTi[x5, x2 - x5, x1, x3 - x5, 
     x3 - x4] + CiTi[x5, x2 - x5, x1, x3 - x5, x4 - x5] - 
    CiTi[x5, x2 - x5, x1, x4 - x5, x2 - x3] + CiTi[x5, x2 - x5, x1, x4 - x5, 
     x3 - x4] - CiTi[x5, x2 - x5, x1 - x2, x2 - x3, x3 - x4] + 
    CiTi[x5, x2 - x5, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x5, x2 - x5, x1 - x2, x2 - x4, x2 - x3] + 
    CiTi[x5, x2 - x5, x1 - x2, x2 - x4, x3 - x4] + 
    CiTi[x5, x2 - x5, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x5, x2 - x5, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x5, x2 - x5, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x5, x2 - x5, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x5, x2 - x5, x2 - x3, x1, x3 - x4] - CiTi[x5, x2 - x5, x2 - x3, x1, 
     x4 - x5] - CiTi[x5, x2 - x5, x2 - x3, x1 - x2, x3 - x4] + 
    CiTi[x5, x2 - x5, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x5, x2 - x5, x2 - x3, x3 - x4, x1] - CiTi[x5, x2 - x5, x2 - x3, 
     x3 - x4, x1 - x2] - CiTi[x5, x2 - x5, x2 - x3, x4 - x5, x1] + 
    CiTi[x5, x2 - x5, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x5, x2 - x5, x2 - x4, x1, x2 - x3] - CiTi[x5, x2 - x5, x2 - x4, x1, 
     x3 - x4] - CiTi[x5, x2 - x5, x2 - x4, x1 - x2, x2 - x3] + 
    CiTi[x5, x2 - x5, x2 - x4, x1 - x2, x3 - x4] + 
    CiTi[x5, x2 - x5, x2 - x4, x2 - x3, x1] - CiTi[x5, x2 - x5, x2 - x4, 
     x2 - x3, x1 - x2] - CiTi[x5, x2 - x5, x2 - x4, x3 - x4, x1] + 
    CiTi[x5, x2 - x5, x2 - x4, x3 - x4, x1 - x2] - 
    CiTi[x5, x2 - x5, x3 - x5, x1, x3 - x4] + CiTi[x5, x2 - x5, x3 - x5, x1, 
     x4 - x5] + CiTi[x5, x2 - x5, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x5, x2 - x5, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x5, x2 - x5, x3 - x5, x3 - x4, x1] + CiTi[x5, x2 - x5, x3 - x5, 
     x3 - x4, x1 - x2] + CiTi[x5, x2 - x5, x3 - x5, x4 - x5, x1] - 
    CiTi[x5, x2 - x5, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x5, x2 - x5, x4 - x5, x1, x2 - x3] + CiTi[x5, x2 - x5, x4 - x5, x1, 
     x3 - x4] + CiTi[x5, x2 - x5, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x5, x2 - x5, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x5, x2 - x5, x4 - x5, x2 - x3, x1] + CiTi[x5, x2 - x5, x4 - x5, 
     x2 - x3, x1 - x2] + CiTi[x5, x2 - x5, x4 - x5, x3 - x4, x1] - 
    CiTi[x5, x2 - x5, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x5, x3 - x5, x1, x1 - x2, x3 - x4] - CiTi[x5, x3 - x5, x1, x1 - x2, 
     x4 - x5] - CiTi[x5, x3 - x5, x1, x2 - x3, x3 - x4] + 
    CiTi[x5, x3 - x5, x1, x2 - x3, x4 - x5] + CiTi[x5, x3 - x5, x1, x3 - x4, 
     x1 - x2] - CiTi[x5, x3 - x5, x1, x3 - x4, x2 - x3] - 
    CiTi[x5, x3 - x5, x1, x4 - x5, x1 - x2] + CiTi[x5, x3 - x5, x1, x4 - x5, 
     x2 - x3] + CiTi[x5, x3 - x5, x2, x1, x3 - x4] - 
    CiTi[x5, x3 - x5, x2, x1, x4 - x5] - CiTi[x5, x3 - x5, x2, x1 - x2, 
     x3 - x4] + CiTi[x5, x3 - x5, x2, x1 - x2, x4 - x5] + 
    CiTi[x5, x3 - x5, x2, x3 - x4, x1] - CiTi[x5, x3 - x5, x2, x3 - x4, 
     x1 - x2] - CiTi[x5, x3 - x5, x2, x4 - x5, x1] + 
    CiTi[x5, x3 - x5, x2, x4 - x5, x1 - x2] - CiTi[x5, x3 - x5, x1 - x3, 
     x1 - x2, x3 - x4] + CiTi[x5, x3 - x5, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x5, x3 - x5, x1 - x3, x2 - x3, x3 - x4] - 
    CiTi[x5, x3 - x5, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x5, x3 - x5, x1 - x3, x3 - x4, x1 - x2] + 
    CiTi[x5, x3 - x5, x1 - x3, x3 - x4, x2 - x3] + 
    CiTi[x5, x3 - x5, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x5, x3 - x5, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x5, x3 - x5, x2 - x3, x1, x3 - x4] + CiTi[x5, x3 - x5, x2 - x3, x1, 
     x4 - x5] + CiTi[x5, x3 - x5, x2 - x3, x1 - x2, x3 - x4] - 
    CiTi[x5, x3 - x5, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x5, x3 - x5, x2 - x3, x3 - x4, x1] + CiTi[x5, x3 - x5, x2 - x3, 
     x3 - x4, x1 - x2] + CiTi[x5, x3 - x5, x2 - x3, x4 - x5, x1] - 
    CiTi[x5, x3 - x5, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x5, x3 - x5, x3 - x4, x1, x1 - x2] - CiTi[x5, x3 - x5, x3 - x4, x1, 
     x2 - x3] + CiTi[x5, x3 - x5, x3 - x4, x2, x1] - 
    CiTi[x5, x3 - x5, x3 - x4, x2, x1 - x2] - CiTi[x5, x3 - x5, x3 - x4, 
     x1 - x3, x1 - x2] + CiTi[x5, x3 - x5, x3 - x4, x1 - x3, x2 - x3] - 
    CiTi[x5, x3 - x5, x3 - x4, x2 - x3, x1] + CiTi[x5, x3 - x5, x3 - x4, 
     x2 - x3, x1 - x2] - CiTi[x5, x3 - x5, x4 - x5, x1, x1 - x2] + 
    CiTi[x5, x3 - x5, x4 - x5, x1, x2 - x3] - CiTi[x5, x3 - x5, x4 - x5, x2, 
     x1] + CiTi[x5, x3 - x5, x4 - x5, x2, x1 - x2] + 
    CiTi[x5, x3 - x5, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x5, x3 - x5, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x5, x3 - x5, x4 - x5, x2 - x3, x1] - CiTi[x5, x3 - x5, x4 - x5, 
     x2 - x3, x1 - x2] + CiTi[x5, x4 - x5, x1, x1 - x2, x2 - x3] - 
    CiTi[x5, x4 - x5, x1, x1 - x2, x3 - x4] + CiTi[x5, x4 - x5, x1, x1 - x3, 
     x1 - x2] - CiTi[x5, x4 - x5, x1, x1 - x3, x2 - x3] - 
    CiTi[x5, x4 - x5, x1, x2 - x4, x2 - x3] + CiTi[x5, x4 - x5, x1, x2 - x4, 
     x3 - x4] - CiTi[x5, x4 - x5, x1, x3 - x4, x1 - x2] + 
    CiTi[x5, x4 - x5, x1, x3 - x4, x2 - x3] + CiTi[x5, x4 - x5, x2, x1, 
     x2 - x3] - CiTi[x5, x4 - x5, x2, x1, x3 - x4] - 
    CiTi[x5, x4 - x5, x2, x1 - x2, x2 - x3] + CiTi[x5, x4 - x5, x2, x1 - x2, 
     x3 - x4] + CiTi[x5, x4 - x5, x2, x2 - x3, x1] - 
    CiTi[x5, x4 - x5, x2, x2 - x3, x1 - x2] - CiTi[x5, x4 - x5, x2, x3 - x4, 
     x1] + CiTi[x5, x4 - x5, x2, x3 - x4, x1 - x2] + 
    CiTi[x5, x4 - x5, x3, x1, x1 - x2] - CiTi[x5, x4 - x5, x3, x1, x2 - x3] + 
    CiTi[x5, x4 - x5, x3, x2, x1] - CiTi[x5, x4 - x5, x3, x2, x1 - x2] - 
    CiTi[x5, x4 - x5, x3, x1 - x3, x1 - x2] + CiTi[x5, x4 - x5, x3, x1 - x3, 
     x2 - x3] - CiTi[x5, x4 - x5, x3, x2 - x3, x1] + 
    CiTi[x5, x4 - x5, x3, x2 - x3, x1 - x2] - CiTi[x5, x4 - x5, x1 - x4, 
     x1 - x2, x2 - x3] + CiTi[x5, x4 - x5, x1 - x4, x1 - x2, x3 - x4] - 
    CiTi[x5, x4 - x5, x1 - x4, x1 - x3, x1 - x2] + 
    CiTi[x5, x4 - x5, x1 - x4, x1 - x3, x2 - x3] + 
    CiTi[x5, x4 - x5, x1 - x4, x2 - x4, x2 - x3] - 
    CiTi[x5, x4 - x5, x1 - x4, x2 - x4, x3 - x4] + 
    CiTi[x5, x4 - x5, x1 - x4, x3 - x4, x1 - x2] - 
    CiTi[x5, x4 - x5, x1 - x4, x3 - x4, x2 - x3] - 
    CiTi[x5, x4 - x5, x2 - x4, x1, x2 - x3] + CiTi[x5, x4 - x5, x2 - x4, x1, 
     x3 - x4] + CiTi[x5, x4 - x5, x2 - x4, x1 - x2, x2 - x3] - 
    CiTi[x5, x4 - x5, x2 - x4, x1 - x2, x3 - x4] - 
    CiTi[x5, x4 - x5, x2 - x4, x2 - x3, x1] + CiTi[x5, x4 - x5, x2 - x4, 
     x2 - x3, x1 - x2] + CiTi[x5, x4 - x5, x2 - x4, x3 - x4, x1] - 
    CiTi[x5, x4 - x5, x2 - x4, x3 - x4, x1 - x2] - 
    CiTi[x5, x4 - x5, x3 - x4, x1, x1 - x2] + CiTi[x5, x4 - x5, x3 - x4, x1, 
     x2 - x3] - CiTi[x5, x4 - x5, x3 - x4, x2, x1] + 
    CiTi[x5, x4 - x5, x3 - x4, x2, x1 - x2] + CiTi[x5, x4 - x5, x3 - x4, 
     x1 - x3, x1 - x2] - CiTi[x5, x4 - x5, x3 - x4, x1 - x3, x2 - x3] + 
    CiTi[x5, x4 - x5, x3 - x4, x2 - x3, x1] - CiTi[x5, x4 - x5, x3 - x4, 
     x2 - x3, x1 - x2] + CiTi[x1 - x6, x1 - x2, x2 - x3, x3 - x4, x4 - x5] - 
    CiTi[x1 - x6, x1 - x2, x2 - x3, x3 - x4, x5 - x6] + 
    CiTi[x1 - x6, x1 - x2, x2 - x3, x3 - x5, x3 - x4] - 
    CiTi[x1 - x6, x1 - x2, x2 - x3, x3 - x5, x4 - x5] - 
    CiTi[x1 - x6, x1 - x2, x2 - x3, x4 - x6, x4 - x5] + 
    CiTi[x1 - x6, x1 - x2, x2 - x3, x4 - x6, x5 - x6] - 
    CiTi[x1 - x6, x1 - x2, x2 - x3, x5 - x6, x3 - x4] + 
    CiTi[x1 - x6, x1 - x2, x2 - x3, x5 - x6, x4 - x5] + 
    CiTi[x1 - x6, x1 - x2, x2 - x4, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x1 - x2, x2 - x4, x2 - x3, x5 - x6] - 
    CiTi[x1 - x6, x1 - x2, x2 - x4, x3 - x4, x4 - x5] + 
    CiTi[x1 - x6, x1 - x2, x2 - x4, x3 - x4, x5 - x6] + 
    CiTi[x1 - x6, x1 - x2, x2 - x4, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x1 - x2, x2 - x4, x4 - x5, x3 - x4] - 
    CiTi[x1 - x6, x1 - x2, x2 - x4, x5 - x6, x2 - x3] + 
    CiTi[x1 - x6, x1 - x2, x2 - x4, x5 - x6, x3 - x4] + 
    CiTi[x1 - x6, x1 - x2, x2 - x5, x2 - x3, x3 - x4] - 
    CiTi[x1 - x6, x1 - x2, x2 - x5, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x1 - x2, x2 - x5, x2 - x4, x2 - x3] - 
    CiTi[x1 - x6, x1 - x2, x2 - x5, x2 - x4, x3 - x4] - 
    CiTi[x1 - x6, x1 - x2, x2 - x5, x3 - x5, x3 - x4] + 
    CiTi[x1 - x6, x1 - x2, x2 - x5, x3 - x5, x4 - x5] - 
    CiTi[x1 - x6, x1 - x2, x2 - x5, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x1 - x2, x2 - x5, x4 - x5, x3 - x4] - 
    CiTi[x1 - x6, x1 - x2, x3 - x6, x3 - x4, x4 - x5] + 
    CiTi[x1 - x6, x1 - x2, x3 - x6, x3 - x4, x5 - x6] - 
    CiTi[x1 - x6, x1 - x2, x3 - x6, x3 - x5, x3 - x4] + 
    CiTi[x1 - x6, x1 - x2, x3 - x6, x3 - x5, x4 - x5] + 
    CiTi[x1 - x6, x1 - x2, x3 - x6, x4 - x6, x4 - x5] - 
    CiTi[x1 - x6, x1 - x2, x3 - x6, x4 - x6, x5 - x6] + 
    CiTi[x1 - x6, x1 - x2, x3 - x6, x5 - x6, x3 - x4] - 
    CiTi[x1 - x6, x1 - x2, x3 - x6, x5 - x6, x4 - x5] - 
    CiTi[x1 - x6, x1 - x2, x4 - x6, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x1 - x2, x4 - x6, x2 - x3, x5 - x6] + 
    CiTi[x1 - x6, x1 - x2, x4 - x6, x3 - x4, x4 - x5] - 
    CiTi[x1 - x6, x1 - x2, x4 - x6, x3 - x4, x5 - x6] - 
    CiTi[x1 - x6, x1 - x2, x4 - x6, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x1 - x2, x4 - x6, x4 - x5, x3 - x4] + 
    CiTi[x1 - x6, x1 - x2, x4 - x6, x5 - x6, x2 - x3] - 
    CiTi[x1 - x6, x1 - x2, x4 - x6, x5 - x6, x3 - x4] - 
    CiTi[x1 - x6, x1 - x2, x5 - x6, x2 - x3, x3 - x4] + 
    CiTi[x1 - x6, x1 - x2, x5 - x6, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x1 - x2, x5 - x6, x2 - x4, x2 - x3] + 
    CiTi[x1 - x6, x1 - x2, x5 - x6, x2 - x4, x3 - x4] + 
    CiTi[x1 - x6, x1 - x2, x5 - x6, x3 - x5, x3 - x4] - 
    CiTi[x1 - x6, x1 - x2, x5 - x6, x3 - x5, x4 - x5] + 
    CiTi[x1 - x6, x1 - x2, x5 - x6, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x1 - x2, x5 - x6, x4 - x5, x3 - x4] + 
    CiTi[x1 - x6, x1 - x3, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x1 - x6, x1 - x3, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x1 - x6, x1 - x3, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x1 - x6, x1 - x3, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x1 - x6, x1 - x3, x1 - x2, x4 - x6, x4 - x5] + 
    CiTi[x1 - x6, x1 - x3, x1 - x2, x4 - x6, x5 - x6] - 
    CiTi[x1 - x6, x1 - x3, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x1 - x6, x1 - x3, x1 - x2, x5 - x6, x4 - x5] - 
    CiTi[x1 - x6, x1 - x3, x2 - x3, x3 - x4, x4 - x5] + 
    CiTi[x1 - x6, x1 - x3, x2 - x3, x3 - x4, x5 - x6] - 
    CiTi[x1 - x6, x1 - x3, x2 - x3, x3 - x5, x3 - x4] + 
    CiTi[x1 - x6, x1 - x3, x2 - x3, x3 - x5, x4 - x5] + 
    CiTi[x1 - x6, x1 - x3, x2 - x3, x4 - x6, x4 - x5] - 
    CiTi[x1 - x6, x1 - x3, x2 - x3, x4 - x6, x5 - x6] + 
    CiTi[x1 - x6, x1 - x3, x2 - x3, x5 - x6, x3 - x4] - 
    CiTi[x1 - x6, x1 - x3, x2 - x3, x5 - x6, x4 - x5] + 
    CiTi[x1 - x6, x1 - x3, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x1 - x6, x1 - x3, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x1 - x6, x1 - x3, x3 - x4, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x1 - x3, x3 - x4, x2 - x3, x5 - x6] + 
    CiTi[x1 - x6, x1 - x3, x3 - x4, x4 - x5, x1 - x2] - 
    CiTi[x1 - x6, x1 - x3, x3 - x4, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x1 - x3, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x1 - x6, x1 - x3, x3 - x4, x5 - x6, x2 - x3] + 
    CiTi[x1 - x6, x1 - x3, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x1 - x6, x1 - x3, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x1 - x6, x1 - x3, x3 - x5, x2 - x3, x3 - x4] + 
    CiTi[x1 - x6, x1 - x3, x3 - x5, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x1 - x3, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x1 - x6, x1 - x3, x3 - x5, x3 - x4, x2 - x3] - 
    CiTi[x1 - x6, x1 - x3, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x1 - x6, x1 - x3, x3 - x5, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x1 - x3, x4 - x6, x1 - x2, x4 - x5] + 
    CiTi[x1 - x6, x1 - x3, x4 - x6, x1 - x2, x5 - x6] + 
    CiTi[x1 - x6, x1 - x3, x4 - x6, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x1 - x3, x4 - x6, x2 - x3, x5 - x6] - 
    CiTi[x1 - x6, x1 - x3, x4 - x6, x4 - x5, x1 - x2] + 
    CiTi[x1 - x6, x1 - x3, x4 - x6, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x1 - x3, x4 - x6, x5 - x6, x1 - x2] - 
    CiTi[x1 - x6, x1 - x3, x4 - x6, x5 - x6, x2 - x3] - 
    CiTi[x1 - x6, x1 - x3, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x1 - x6, x1 - x3, x5 - x6, x1 - x2, x4 - x5] + 
    CiTi[x1 - x6, x1 - x3, x5 - x6, x2 - x3, x3 - x4] - 
    CiTi[x1 - x6, x1 - x3, x5 - x6, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x1 - x3, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x1 - x6, x1 - x3, x5 - x6, x3 - x4, x2 - x3] + 
    CiTi[x1 - x6, x1 - x3, x5 - x6, x4 - x5, x1 - x2] - 
    CiTi[x1 - x6, x1 - x3, x5 - x6, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x1 - x4, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x1 - x4, x1 - x2, x2 - x3, x5 - x6] - 
    CiTi[x1 - x6, x1 - x4, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x1 - x6, x1 - x4, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x1 - x6, x1 - x4, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x1 - x4, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x1 - x6, x1 - x4, x1 - x2, x5 - x6, x2 - x3] + 
    CiTi[x1 - x6, x1 - x4, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x1 - x6, x1 - x4, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x1 - x6, x1 - x4, x1 - x3, x1 - x2, x5 - x6] - 
    CiTi[x1 - x6, x1 - x4, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x1 - x4, x1 - x3, x2 - x3, x5 - x6] + 
    CiTi[x1 - x6, x1 - x4, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x1 - x6, x1 - x4, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x1 - x4, x1 - x3, x5 - x6, x1 - x2] + 
    CiTi[x1 - x6, x1 - x4, x1 - x3, x5 - x6, x2 - x3] - 
    CiTi[x1 - x6, x1 - x4, x2 - x4, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x1 - x4, x2 - x4, x2 - x3, x5 - x6] + 
    CiTi[x1 - x6, x1 - x4, x2 - x4, x3 - x4, x4 - x5] - 
    CiTi[x1 - x6, x1 - x4, x2 - x4, x3 - x4, x5 - x6] - 
    CiTi[x1 - x6, x1 - x4, x2 - x4, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x1 - x4, x2 - x4, x4 - x5, x3 - x4] + 
    CiTi[x1 - x6, x1 - x4, x2 - x4, x5 - x6, x2 - x3] - 
    CiTi[x1 - x6, x1 - x4, x2 - x4, x5 - x6, x3 - x4] - 
    CiTi[x1 - x6, x1 - x4, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x1 - x6, x1 - x4, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x1 - x6, x1 - x4, x3 - x4, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x1 - x4, x3 - x4, x2 - x3, x5 - x6] - 
    CiTi[x1 - x6, x1 - x4, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x1 - x6, x1 - x4, x3 - x4, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x1 - x4, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x1 - x6, x1 - x4, x3 - x4, x5 - x6, x2 - x3] + 
    CiTi[x1 - x6, x1 - x4, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x1 - x6, x1 - x4, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x1 - x6, x1 - x4, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x1 - x6, x1 - x4, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x1 - x6, x1 - x4, x4 - x5, x2 - x4, x2 - x3] + 
    CiTi[x1 - x6, x1 - x4, x4 - x5, x2 - x4, x3 - x4] - 
    CiTi[x1 - x6, x1 - x4, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x1 - x6, x1 - x4, x4 - x5, x3 - x4, x2 - x3] - 
    CiTi[x1 - x6, x1 - x4, x5 - x6, x1 - x2, x2 - x3] + 
    CiTi[x1 - x6, x1 - x4, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x1 - x6, x1 - x4, x5 - x6, x1 - x3, x1 - x2] + 
    CiTi[x1 - x6, x1 - x4, x5 - x6, x1 - x3, x2 - x3] + 
    CiTi[x1 - x6, x1 - x4, x5 - x6, x2 - x4, x2 - x3] - 
    CiTi[x1 - x6, x1 - x4, x5 - x6, x2 - x4, x3 - x4] + 
    CiTi[x1 - x6, x1 - x4, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x1 - x6, x1 - x4, x5 - x6, x3 - x4, x2 - x3] + 
    CiTi[x1 - x6, x1 - x5, x1 - x2, x2 - x3, x3 - x4] - 
    CiTi[x1 - x6, x1 - x5, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x1 - x5, x1 - x2, x2 - x4, x2 - x3] - 
    CiTi[x1 - x6, x1 - x5, x1 - x2, x2 - x4, x3 - x4] - 
    CiTi[x1 - x6, x1 - x5, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x1 - x6, x1 - x5, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x1 - x6, x1 - x5, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x1 - x5, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x1 - x6, x1 - x5, x1 - x3, x1 - x2, x3 - x4] - 
    CiTi[x1 - x6, x1 - x5, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x1 - x6, x1 - x5, x1 - x3, x2 - x3, x3 - x4] + 
    CiTi[x1 - x6, x1 - x5, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x1 - x5, x1 - x3, x3 - x4, x1 - x2] - 
    CiTi[x1 - x6, x1 - x5, x1 - x3, x3 - x4, x2 - x3] - 
    CiTi[x1 - x6, x1 - x5, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x1 - x6, x1 - x5, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x1 - x5, x1 - x4, x1 - x2, x2 - x3] - 
    CiTi[x1 - x6, x1 - x5, x1 - x4, x1 - x2, x3 - x4] + 
    CiTi[x1 - x6, x1 - x5, x1 - x4, x1 - x3, x1 - x2] - 
    CiTi[x1 - x6, x1 - x5, x1 - x4, x1 - x3, x2 - x3] - 
    CiTi[x1 - x6, x1 - x5, x1 - x4, x2 - x4, x2 - x3] + 
    CiTi[x1 - x6, x1 - x5, x1 - x4, x2 - x4, x3 - x4] - 
    CiTi[x1 - x6, x1 - x5, x1 - x4, x3 - x4, x1 - x2] + 
    CiTi[x1 - x6, x1 - x5, x1 - x4, x3 - x4, x2 - x3] - 
    CiTi[x1 - x6, x1 - x5, x2 - x5, x2 - x3, x3 - x4] + 
    CiTi[x1 - x6, x1 - x5, x2 - x5, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x1 - x5, x2 - x5, x2 - x4, x2 - x3] + 
    CiTi[x1 - x6, x1 - x5, x2 - x5, x2 - x4, x3 - x4] + 
    CiTi[x1 - x6, x1 - x5, x2 - x5, x3 - x5, x3 - x4] - 
    CiTi[x1 - x6, x1 - x5, x2 - x5, x3 - x5, x4 - x5] + 
    CiTi[x1 - x6, x1 - x5, x2 - x5, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x1 - x5, x2 - x5, x4 - x5, x3 - x4] - 
    CiTi[x1 - x6, x1 - x5, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x1 - x6, x1 - x5, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x1 - x6, x1 - x5, x3 - x5, x2 - x3, x3 - x4] - 
    CiTi[x1 - x6, x1 - x5, x3 - x5, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x1 - x5, x3 - x5, x3 - x4, x1 - x2] + 
    CiTi[x1 - x6, x1 - x5, x3 - x5, x3 - x4, x2 - x3] + 
    CiTi[x1 - x6, x1 - x5, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x1 - x6, x1 - x5, x3 - x5, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x1 - x5, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x1 - x6, x1 - x5, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x1 - x6, x1 - x5, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x1 - x6, x1 - x5, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x1 - x6, x1 - x5, x4 - x5, x2 - x4, x2 - x3] - 
    CiTi[x1 - x6, x1 - x5, x4 - x5, x2 - x4, x3 - x4] + 
    CiTi[x1 - x6, x1 - x5, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x1 - x6, x1 - x5, x4 - x5, x3 - x4, x2 - x3] - 
    CiTi[x1 - x6, x2 - x6, x2 - x3, x3 - x4, x4 - x5] + 
    CiTi[x1 - x6, x2 - x6, x2 - x3, x3 - x4, x5 - x6] - 
    CiTi[x1 - x6, x2 - x6, x2 - x3, x3 - x5, x3 - x4] + 
    CiTi[x1 - x6, x2 - x6, x2 - x3, x3 - x5, x4 - x5] + 
    CiTi[x1 - x6, x2 - x6, x2 - x3, x4 - x6, x4 - x5] - 
    CiTi[x1 - x6, x2 - x6, x2 - x3, x4 - x6, x5 - x6] + 
    CiTi[x1 - x6, x2 - x6, x2 - x3, x5 - x6, x3 - x4] - 
    CiTi[x1 - x6, x2 - x6, x2 - x3, x5 - x6, x4 - x5] - 
    CiTi[x1 - x6, x2 - x6, x2 - x4, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x2 - x6, x2 - x4, x2 - x3, x5 - x6] + 
    CiTi[x1 - x6, x2 - x6, x2 - x4, x3 - x4, x4 - x5] - 
    CiTi[x1 - x6, x2 - x6, x2 - x4, x3 - x4, x5 - x6] - 
    CiTi[x1 - x6, x2 - x6, x2 - x4, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x2 - x6, x2 - x4, x4 - x5, x3 - x4] + 
    CiTi[x1 - x6, x2 - x6, x2 - x4, x5 - x6, x2 - x3] - 
    CiTi[x1 - x6, x2 - x6, x2 - x4, x5 - x6, x3 - x4] - 
    CiTi[x1 - x6, x2 - x6, x2 - x5, x2 - x3, x3 - x4] + 
    CiTi[x1 - x6, x2 - x6, x2 - x5, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x2 - x6, x2 - x5, x2 - x4, x2 - x3] + 
    CiTi[x1 - x6, x2 - x6, x2 - x5, x2 - x4, x3 - x4] + 
    CiTi[x1 - x6, x2 - x6, x2 - x5, x3 - x5, x3 - x4] - 
    CiTi[x1 - x6, x2 - x6, x2 - x5, x3 - x5, x4 - x5] + 
    CiTi[x1 - x6, x2 - x6, x2 - x5, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x2 - x6, x2 - x5, x4 - x5, x3 - x4] + 
    CiTi[x1 - x6, x2 - x6, x3 - x6, x3 - x4, x4 - x5] - 
    CiTi[x1 - x6, x2 - x6, x3 - x6, x3 - x4, x5 - x6] + 
    CiTi[x1 - x6, x2 - x6, x3 - x6, x3 - x5, x3 - x4] - 
    CiTi[x1 - x6, x2 - x6, x3 - x6, x3 - x5, x4 - x5] - 
    CiTi[x1 - x6, x2 - x6, x3 - x6, x4 - x6, x4 - x5] + 
    CiTi[x1 - x6, x2 - x6, x3 - x6, x4 - x6, x5 - x6] - 
    CiTi[x1 - x6, x2 - x6, x3 - x6, x5 - x6, x3 - x4] + 
    CiTi[x1 - x6, x2 - x6, x3 - x6, x5 - x6, x4 - x5] + 
    CiTi[x1 - x6, x2 - x6, x4 - x6, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x2 - x6, x4 - x6, x2 - x3, x5 - x6] - 
    CiTi[x1 - x6, x2 - x6, x4 - x6, x3 - x4, x4 - x5] + 
    CiTi[x1 - x6, x2 - x6, x4 - x6, x3 - x4, x5 - x6] + 
    CiTi[x1 - x6, x2 - x6, x4 - x6, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x2 - x6, x4 - x6, x4 - x5, x3 - x4] - 
    CiTi[x1 - x6, x2 - x6, x4 - x6, x5 - x6, x2 - x3] + 
    CiTi[x1 - x6, x2 - x6, x4 - x6, x5 - x6, x3 - x4] + 
    CiTi[x1 - x6, x2 - x6, x5 - x6, x2 - x3, x3 - x4] - 
    CiTi[x1 - x6, x2 - x6, x5 - x6, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x2 - x6, x5 - x6, x2 - x4, x2 - x3] - 
    CiTi[x1 - x6, x2 - x6, x5 - x6, x2 - x4, x3 - x4] - 
    CiTi[x1 - x6, x2 - x6, x5 - x6, x3 - x5, x3 - x4] + 
    CiTi[x1 - x6, x2 - x6, x5 - x6, x3 - x5, x4 - x5] - 
    CiTi[x1 - x6, x2 - x6, x5 - x6, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x2 - x6, x5 - x6, x4 - x5, x3 - x4] - 
    CiTi[x1 - x6, x3 - x6, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x1 - x6, x3 - x6, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x1 - x6, x3 - x6, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x1 - x6, x3 - x6, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x1 - x6, x3 - x6, x1 - x2, x4 - x6, x4 - x5] - 
    CiTi[x1 - x6, x3 - x6, x1 - x2, x4 - x6, x5 - x6] + 
    CiTi[x1 - x6, x3 - x6, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x1 - x6, x3 - x6, x1 - x2, x5 - x6, x4 - x5] + 
    CiTi[x1 - x6, x3 - x6, x2 - x3, x3 - x4, x4 - x5] - 
    CiTi[x1 - x6, x3 - x6, x2 - x3, x3 - x4, x5 - x6] + 
    CiTi[x1 - x6, x3 - x6, x2 - x3, x3 - x5, x3 - x4] - 
    CiTi[x1 - x6, x3 - x6, x2 - x3, x3 - x5, x4 - x5] - 
    CiTi[x1 - x6, x3 - x6, x2 - x3, x4 - x6, x4 - x5] + 
    CiTi[x1 - x6, x3 - x6, x2 - x3, x4 - x6, x5 - x6] - 
    CiTi[x1 - x6, x3 - x6, x2 - x3, x5 - x6, x3 - x4] + 
    CiTi[x1 - x6, x3 - x6, x2 - x3, x5 - x6, x4 - x5] - 
    CiTi[x1 - x6, x3 - x6, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x1 - x6, x3 - x6, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x1 - x6, x3 - x6, x3 - x4, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x3 - x6, x3 - x4, x2 - x3, x5 - x6] - 
    CiTi[x1 - x6, x3 - x6, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x1 - x6, x3 - x6, x3 - x4, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x3 - x6, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x1 - x6, x3 - x6, x3 - x4, x5 - x6, x2 - x3] - 
    CiTi[x1 - x6, x3 - x6, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x1 - x6, x3 - x6, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x1 - x6, x3 - x6, x3 - x5, x2 - x3, x3 - x4] - 
    CiTi[x1 - x6, x3 - x6, x3 - x5, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x3 - x6, x3 - x5, x3 - x4, x1 - x2] + 
    CiTi[x1 - x6, x3 - x6, x3 - x5, x3 - x4, x2 - x3] + 
    CiTi[x1 - x6, x3 - x6, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x1 - x6, x3 - x6, x3 - x5, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x3 - x6, x4 - x6, x1 - x2, x4 - x5] - 
    CiTi[x1 - x6, x3 - x6, x4 - x6, x1 - x2, x5 - x6] - 
    CiTi[x1 - x6, x3 - x6, x4 - x6, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x3 - x6, x4 - x6, x2 - x3, x5 - x6] + 
    CiTi[x1 - x6, x3 - x6, x4 - x6, x4 - x5, x1 - x2] - 
    CiTi[x1 - x6, x3 - x6, x4 - x6, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x3 - x6, x4 - x6, x5 - x6, x1 - x2] + 
    CiTi[x1 - x6, x3 - x6, x4 - x6, x5 - x6, x2 - x3] + 
    CiTi[x1 - x6, x3 - x6, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x1 - x6, x3 - x6, x5 - x6, x1 - x2, x4 - x5] - 
    CiTi[x1 - x6, x3 - x6, x5 - x6, x2 - x3, x3 - x4] + 
    CiTi[x1 - x6, x3 - x6, x5 - x6, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x3 - x6, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x1 - x6, x3 - x6, x5 - x6, x3 - x4, x2 - x3] - 
    CiTi[x1 - x6, x3 - x6, x5 - x6, x4 - x5, x1 - x2] + 
    CiTi[x1 - x6, x3 - x6, x5 - x6, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x4 - x6, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x4 - x6, x1 - x2, x2 - x3, x5 - x6] + 
    CiTi[x1 - x6, x4 - x6, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x1 - x6, x4 - x6, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x1 - x6, x4 - x6, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x4 - x6, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x1 - x6, x4 - x6, x1 - x2, x5 - x6, x2 - x3] - 
    CiTi[x1 - x6, x4 - x6, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x1 - x6, x4 - x6, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x1 - x6, x4 - x6, x1 - x3, x1 - x2, x5 - x6] + 
    CiTi[x1 - x6, x4 - x6, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x4 - x6, x1 - x3, x2 - x3, x5 - x6] - 
    CiTi[x1 - x6, x4 - x6, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x1 - x6, x4 - x6, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x4 - x6, x1 - x3, x5 - x6, x1 - x2] - 
    CiTi[x1 - x6, x4 - x6, x1 - x3, x5 - x6, x2 - x3] + 
    CiTi[x1 - x6, x4 - x6, x2 - x4, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x4 - x6, x2 - x4, x2 - x3, x5 - x6] - 
    CiTi[x1 - x6, x4 - x6, x2 - x4, x3 - x4, x4 - x5] + 
    CiTi[x1 - x6, x4 - x6, x2 - x4, x3 - x4, x5 - x6] + 
    CiTi[x1 - x6, x4 - x6, x2 - x4, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x4 - x6, x2 - x4, x4 - x5, x3 - x4] - 
    CiTi[x1 - x6, x4 - x6, x2 - x4, x5 - x6, x2 - x3] + 
    CiTi[x1 - x6, x4 - x6, x2 - x4, x5 - x6, x3 - x4] + 
    CiTi[x1 - x6, x4 - x6, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x1 - x6, x4 - x6, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x1 - x6, x4 - x6, x3 - x4, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x4 - x6, x3 - x4, x2 - x3, x5 - x6] + 
    CiTi[x1 - x6, x4 - x6, x3 - x4, x4 - x5, x1 - x2] - 
    CiTi[x1 - x6, x4 - x6, x3 - x4, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x4 - x6, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x1 - x6, x4 - x6, x3 - x4, x5 - x6, x2 - x3] - 
    CiTi[x1 - x6, x4 - x6, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x1 - x6, x4 - x6, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x1 - x6, x4 - x6, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x1 - x6, x4 - x6, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x1 - x6, x4 - x6, x4 - x5, x2 - x4, x2 - x3] - 
    CiTi[x1 - x6, x4 - x6, x4 - x5, x2 - x4, x3 - x4] + 
    CiTi[x1 - x6, x4 - x6, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x1 - x6, x4 - x6, x4 - x5, x3 - x4, x2 - x3] + 
    CiTi[x1 - x6, x4 - x6, x5 - x6, x1 - x2, x2 - x3] - 
    CiTi[x1 - x6, x4 - x6, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x1 - x6, x4 - x6, x5 - x6, x1 - x3, x1 - x2] - 
    CiTi[x1 - x6, x4 - x6, x5 - x6, x1 - x3, x2 - x3] - 
    CiTi[x1 - x6, x4 - x6, x5 - x6, x2 - x4, x2 - x3] + 
    CiTi[x1 - x6, x4 - x6, x5 - x6, x2 - x4, x3 - x4] - 
    CiTi[x1 - x6, x4 - x6, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x1 - x6, x4 - x6, x5 - x6, x3 - x4, x2 - x3] - 
    CiTi[x1 - x6, x5 - x6, x1 - x2, x2 - x3, x3 - x4] + 
    CiTi[x1 - x6, x5 - x6, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x5 - x6, x1 - x2, x2 - x4, x2 - x3] + 
    CiTi[x1 - x6, x5 - x6, x1 - x2, x2 - x4, x3 - x4] + 
    CiTi[x1 - x6, x5 - x6, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x1 - x6, x5 - x6, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x1 - x6, x5 - x6, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x5 - x6, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x1 - x6, x5 - x6, x1 - x3, x1 - x2, x3 - x4] + 
    CiTi[x1 - x6, x5 - x6, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x1 - x6, x5 - x6, x1 - x3, x2 - x3, x3 - x4] - 
    CiTi[x1 - x6, x5 - x6, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x1 - x6, x5 - x6, x1 - x3, x3 - x4, x1 - x2] + 
    CiTi[x1 - x6, x5 - x6, x1 - x3, x3 - x4, x2 - x3] + 
    CiTi[x1 - x6, x5 - x6, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x1 - x6, x5 - x6, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x1 - x6, x5 - x6, x1 - x4, x1 - x2, x2 - x3] + 
    CiTi[x1 - x6, x5 - x6, x1 - x4, x1 - x2, x3 - x4] - 
    CiTi[x1 - x6, x5 - x6, x1 - x4, x1 - x3, x1 - x2] + 
    CiTi[x1 - x6, x5 - x6, x1 - x4, x1 - x3, x2 - x3] + 
    CiTi[x1 - x6, x5 - x6, x1 - x4, x2 - x4, x2 - x3] - 
    CiTi[x1 - x6, x5 - x6, x1 - x4, x2 - x4, x3 - x4] + 
    CiTi[x1 - x6, x5 - x6, x1 - x4, x3 - x4, x1 - x2] - 
    CiTi[x1 - x6, x5 - x6, x1 - x4, x3 - x4, x2 - x3] + 
    CiTi[x1 - x6, x5 - x6, x2 - x5, x2 - x3, x3 - x4] - 
    CiTi[x1 - x6, x5 - x6, x2 - x5, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x5 - x6, x2 - x5, x2 - x4, x2 - x3] - 
    CiTi[x1 - x6, x5 - x6, x2 - x5, x2 - x4, x3 - x4] - 
    CiTi[x1 - x6, x5 - x6, x2 - x5, x3 - x5, x3 - x4] + 
    CiTi[x1 - x6, x5 - x6, x2 - x5, x3 - x5, x4 - x5] - 
    CiTi[x1 - x6, x5 - x6, x2 - x5, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x5 - x6, x2 - x5, x4 - x5, x3 - x4] + 
    CiTi[x1 - x6, x5 - x6, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x1 - x6, x5 - x6, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x1 - x6, x5 - x6, x3 - x5, x2 - x3, x3 - x4] + 
    CiTi[x1 - x6, x5 - x6, x3 - x5, x2 - x3, x4 - x5] + 
    CiTi[x1 - x6, x5 - x6, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x1 - x6, x5 - x6, x3 - x5, x3 - x4, x2 - x3] - 
    CiTi[x1 - x6, x5 - x6, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x1 - x6, x5 - x6, x3 - x5, x4 - x5, x2 - x3] + 
    CiTi[x1 - x6, x5 - x6, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x1 - x6, x5 - x6, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x1 - x6, x5 - x6, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x1 - x6, x5 - x6, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x1 - x6, x5 - x6, x4 - x5, x2 - x4, x2 - x3] + 
    CiTi[x1 - x6, x5 - x6, x4 - x5, x2 - x4, x3 - x4] - 
    CiTi[x1 - x6, x5 - x6, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x1 - x6, x5 - x6, x4 - x5, x3 - x4, x2 - x3] + 
    CiTi[x2 - x6, x1, x2 - x3, x3 - x4, x4 - x5] - 
    CiTi[x2 - x6, x1, x2 - x3, x3 - x4, x5 - x6] + 
    CiTi[x2 - x6, x1, x2 - x3, x3 - x5, x3 - x4] - 
    CiTi[x2 - x6, x1, x2 - x3, x3 - x5, x4 - x5] - 
    CiTi[x2 - x6, x1, x2 - x3, x4 - x6, x4 - x5] + 
    CiTi[x2 - x6, x1, x2 - x3, x4 - x6, x5 - x6] - 
    CiTi[x2 - x6, x1, x2 - x3, x5 - x6, x3 - x4] + 
    CiTi[x2 - x6, x1, x2 - x3, x5 - x6, x4 - x5] + 
    CiTi[x2 - x6, x1, x2 - x4, x2 - x3, x4 - x5] - 
    CiTi[x2 - x6, x1, x2 - x4, x2 - x3, x5 - x6] - 
    CiTi[x2 - x6, x1, x2 - x4, x3 - x4, x4 - x5] + 
    CiTi[x2 - x6, x1, x2 - x4, x3 - x4, x5 - x6] + 
    CiTi[x2 - x6, x1, x2 - x4, x4 - x5, x2 - x3] - 
    CiTi[x2 - x6, x1, x2 - x4, x4 - x5, x3 - x4] - 
    CiTi[x2 - x6, x1, x2 - x4, x5 - x6, x2 - x3] + 
    CiTi[x2 - x6, x1, x2 - x4, x5 - x6, x3 - x4] + 
    CiTi[x2 - x6, x1, x2 - x5, x2 - x3, x3 - x4] - 
    CiTi[x2 - x6, x1, x2 - x5, x2 - x3, x4 - x5] + 
    CiTi[x2 - x6, x1, x2 - x5, x2 - x4, x2 - x3] - 
    CiTi[x2 - x6, x1, x2 - x5, x2 - x4, x3 - x4] - 
    CiTi[x2 - x6, x1, x2 - x5, x3 - x5, x3 - x4] + 
    CiTi[x2 - x6, x1, x2 - x5, x3 - x5, x4 - x5] - 
    CiTi[x2 - x6, x1, x2 - x5, x4 - x5, x2 - x3] + 
    CiTi[x2 - x6, x1, x2 - x5, x4 - x5, x3 - x4] - 
    CiTi[x2 - x6, x1, x3 - x6, x3 - x4, x4 - x5] + 
    CiTi[x2 - x6, x1, x3 - x6, x3 - x4, x5 - x6] - 
    CiTi[x2 - x6, x1, x3 - x6, x3 - x5, x3 - x4] + 
    CiTi[x2 - x6, x1, x3 - x6, x3 - x5, x4 - x5] + 
    CiTi[x2 - x6, x1, x3 - x6, x4 - x6, x4 - x5] - 
    CiTi[x2 - x6, x1, x3 - x6, x4 - x6, x5 - x6] + 
    CiTi[x2 - x6, x1, x3 - x6, x5 - x6, x3 - x4] - 
    CiTi[x2 - x6, x1, x3 - x6, x5 - x6, x4 - x5] - 
    CiTi[x2 - x6, x1, x4 - x6, x2 - x3, x4 - x5] + 
    CiTi[x2 - x6, x1, x4 - x6, x2 - x3, x5 - x6] + 
    CiTi[x2 - x6, x1, x4 - x6, x3 - x4, x4 - x5] - 
    CiTi[x2 - x6, x1, x4 - x6, x3 - x4, x5 - x6] - 
    CiTi[x2 - x6, x1, x4 - x6, x4 - x5, x2 - x3] + 
    CiTi[x2 - x6, x1, x4 - x6, x4 - x5, x3 - x4] + 
    CiTi[x2 - x6, x1, x4 - x6, x5 - x6, x2 - x3] - 
    CiTi[x2 - x6, x1, x4 - x6, x5 - x6, x3 - x4] - 
    CiTi[x2 - x6, x1, x5 - x6, x2 - x3, x3 - x4] + 
    CiTi[x2 - x6, x1, x5 - x6, x2 - x3, x4 - x5] - 
    CiTi[x2 - x6, x1, x5 - x6, x2 - x4, x2 - x3] + 
    CiTi[x2 - x6, x1, x5 - x6, x2 - x4, x3 - x4] + 
    CiTi[x2 - x6, x1, x5 - x6, x3 - x5, x3 - x4] - 
    CiTi[x2 - x6, x1, x5 - x6, x3 - x5, x4 - x5] + 
    CiTi[x2 - x6, x1, x5 - x6, x4 - x5, x2 - x3] - 
    CiTi[x2 - x6, x1, x5 - x6, x4 - x5, x3 - x4] - 
    CiTi[x2 - x6, x1 - x2, x2 - x3, x3 - x4, x4 - x5] + 
    CiTi[x2 - x6, x1 - x2, x2 - x3, x3 - x4, x5 - x6] - 
    CiTi[x2 - x6, x1 - x2, x2 - x3, x3 - x5, x3 - x4] + 
    CiTi[x2 - x6, x1 - x2, x2 - x3, x3 - x5, x4 - x5] + 
    CiTi[x2 - x6, x1 - x2, x2 - x3, x4 - x6, x4 - x5] - 
    CiTi[x2 - x6, x1 - x2, x2 - x3, x4 - x6, x5 - x6] + 
    CiTi[x2 - x6, x1 - x2, x2 - x3, x5 - x6, x3 - x4] - 
    CiTi[x2 - x6, x1 - x2, x2 - x3, x5 - x6, x4 - x5] - 
    CiTi[x2 - x6, x1 - x2, x2 - x4, x2 - x3, x4 - x5] + 
    CiTi[x2 - x6, x1 - x2, x2 - x4, x2 - x3, x5 - x6] + 
    CiTi[x2 - x6, x1 - x2, x2 - x4, x3 - x4, x4 - x5] - 
    CiTi[x2 - x6, x1 - x2, x2 - x4, x3 - x4, x5 - x6] - 
    CiTi[x2 - x6, x1 - x2, x2 - x4, x4 - x5, x2 - x3] + 
    CiTi[x2 - x6, x1 - x2, x2 - x4, x4 - x5, x3 - x4] + 
    CiTi[x2 - x6, x1 - x2, x2 - x4, x5 - x6, x2 - x3] - 
    CiTi[x2 - x6, x1 - x2, x2 - x4, x5 - x6, x3 - x4] - 
    CiTi[x2 - x6, x1 - x2, x2 - x5, x2 - x3, x3 - x4] + 
    CiTi[x2 - x6, x1 - x2, x2 - x5, x2 - x3, x4 - x5] - 
    CiTi[x2 - x6, x1 - x2, x2 - x5, x2 - x4, x2 - x3] + 
    CiTi[x2 - x6, x1 - x2, x2 - x5, x2 - x4, x3 - x4] + 
    CiTi[x2 - x6, x1 - x2, x2 - x5, x3 - x5, x3 - x4] - 
    CiTi[x2 - x6, x1 - x2, x2 - x5, x3 - x5, x4 - x5] + 
    CiTi[x2 - x6, x1 - x2, x2 - x5, x4 - x5, x2 - x3] - 
    CiTi[x2 - x6, x1 - x2, x2 - x5, x4 - x5, x3 - x4] + 
    CiTi[x2 - x6, x1 - x2, x3 - x6, x3 - x4, x4 - x5] - 
    CiTi[x2 - x6, x1 - x2, x3 - x6, x3 - x4, x5 - x6] + 
    CiTi[x2 - x6, x1 - x2, x3 - x6, x3 - x5, x3 - x4] - 
    CiTi[x2 - x6, x1 - x2, x3 - x6, x3 - x5, x4 - x5] - 
    CiTi[x2 - x6, x1 - x2, x3 - x6, x4 - x6, x4 - x5] + 
    CiTi[x2 - x6, x1 - x2, x3 - x6, x4 - x6, x5 - x6] - 
    CiTi[x2 - x6, x1 - x2, x3 - x6, x5 - x6, x3 - x4] + 
    CiTi[x2 - x6, x1 - x2, x3 - x6, x5 - x6, x4 - x5] + 
    CiTi[x2 - x6, x1 - x2, x4 - x6, x2 - x3, x4 - x5] - 
    CiTi[x2 - x6, x1 - x2, x4 - x6, x2 - x3, x5 - x6] - 
    CiTi[x2 - x6, x1 - x2, x4 - x6, x3 - x4, x4 - x5] + 
    CiTi[x2 - x6, x1 - x2, x4 - x6, x3 - x4, x5 - x6] + 
    CiTi[x2 - x6, x1 - x2, x4 - x6, x4 - x5, x2 - x3] - 
    CiTi[x2 - x6, x1 - x2, x4 - x6, x4 - x5, x3 - x4] - 
    CiTi[x2 - x6, x1 - x2, x4 - x6, x5 - x6, x2 - x3] + 
    CiTi[x2 - x6, x1 - x2, x4 - x6, x5 - x6, x3 - x4] + 
    CiTi[x2 - x6, x1 - x2, x5 - x6, x2 - x3, x3 - x4] - 
    CiTi[x2 - x6, x1 - x2, x5 - x6, x2 - x3, x4 - x5] + 
    CiTi[x2 - x6, x1 - x2, x5 - x6, x2 - x4, x2 - x3] - 
    CiTi[x2 - x6, x1 - x2, x5 - x6, x2 - x4, x3 - x4] - 
    CiTi[x2 - x6, x1 - x2, x5 - x6, x3 - x5, x3 - x4] + 
    CiTi[x2 - x6, x1 - x2, x5 - x6, x3 - x5, x4 - x5] - 
    CiTi[x2 - x6, x1 - x2, x5 - x6, x4 - x5, x2 - x3] + 
    CiTi[x2 - x6, x1 - x2, x5 - x6, x4 - x5, x3 - x4] + 
    CiTi[x2 - x6, x2 - x3, x1, x3 - x4, x4 - x5] - 
    CiTi[x2 - x6, x2 - x3, x1, x3 - x4, x5 - x6] + 
    CiTi[x2 - x6, x2 - x3, x1, x3 - x5, x3 - x4] - 
    CiTi[x2 - x6, x2 - x3, x1, x3 - x5, x4 - x5] - 
    CiTi[x2 - x6, x2 - x3, x1, x4 - x6, x4 - x5] + 
    CiTi[x2 - x6, x2 - x3, x1, x4 - x6, x5 - x6] - 
    CiTi[x2 - x6, x2 - x3, x1, x5 - x6, x3 - x4] + 
    CiTi[x2 - x6, x2 - x3, x1, x5 - x6, x4 - x5] - 
    CiTi[x2 - x6, x2 - x3, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x2 - x6, x2 - x3, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x2 - x6, x2 - x3, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x2 - x6, x2 - x3, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x2 - x6, x2 - x3, x1 - x2, x4 - x6, x4 - x5] - 
    CiTi[x2 - x6, x2 - x3, x1 - x2, x4 - x6, x5 - x6] + 
    CiTi[x2 - x6, x2 - x3, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x2 - x6, x2 - x3, x1 - x2, x5 - x6, x4 - x5] + 
    CiTi[x2 - x6, x2 - x3, x3 - x4, x1, x4 - x5] - 
    CiTi[x2 - x6, x2 - x3, x3 - x4, x1, x5 - x6] - 
    CiTi[x2 - x6, x2 - x3, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x2 - x6, x2 - x3, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x2 - x6, x2 - x3, x3 - x4, x4 - x5, x1] - 
    CiTi[x2 - x6, x2 - x3, x3 - x4, x4 - x5, x1 - x2] - 
    CiTi[x2 - x6, x2 - x3, x3 - x4, x5 - x6, x1] + 
    CiTi[x2 - x6, x2 - x3, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x2 - x6, x2 - x3, x3 - x5, x1, x3 - x4] - 
    CiTi[x2 - x6, x2 - x3, x3 - x5, x1, x4 - x5] - 
    CiTi[x2 - x6, x2 - x3, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x2 - x6, x2 - x3, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x2 - x6, x2 - x3, x3 - x5, x3 - x4, x1] - 
    CiTi[x2 - x6, x2 - x3, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x2 - x6, x2 - x3, x3 - x5, x4 - x5, x1] + 
    CiTi[x2 - x6, x2 - x3, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x2 - x6, x2 - x3, x4 - x6, x1, x4 - x5] + 
    CiTi[x2 - x6, x2 - x3, x4 - x6, x1, x5 - x6] + 
    CiTi[x2 - x6, x2 - x3, x4 - x6, x1 - x2, x4 - x5] - 
    CiTi[x2 - x6, x2 - x3, x4 - x6, x1 - x2, x5 - x6] - 
    CiTi[x2 - x6, x2 - x3, x4 - x6, x4 - x5, x1] + 
    CiTi[x2 - x6, x2 - x3, x4 - x6, x4 - x5, x1 - x2] + 
    CiTi[x2 - x6, x2 - x3, x4 - x6, x5 - x6, x1] - 
    CiTi[x2 - x6, x2 - x3, x4 - x6, x5 - x6, x1 - x2] - 
    CiTi[x2 - x6, x2 - x3, x5 - x6, x1, x3 - x4] + 
    CiTi[x2 - x6, x2 - x3, x5 - x6, x1, x4 - x5] + 
    CiTi[x2 - x6, x2 - x3, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x2 - x6, x2 - x3, x5 - x6, x1 - x2, x4 - x5] - 
    CiTi[x2 - x6, x2 - x3, x5 - x6, x3 - x4, x1] + 
    CiTi[x2 - x6, x2 - x3, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x2 - x6, x2 - x3, x5 - x6, x4 - x5, x1] - 
    CiTi[x2 - x6, x2 - x3, x5 - x6, x4 - x5, x1 - x2] + 
    CiTi[x2 - x6, x2 - x4, x1, x2 - x3, x4 - x5] - 
    CiTi[x2 - x6, x2 - x4, x1, x2 - x3, x5 - x6] - 
    CiTi[x2 - x6, x2 - x4, x1, x3 - x4, x4 - x5] + 
    CiTi[x2 - x6, x2 - x4, x1, x3 - x4, x5 - x6] + 
    CiTi[x2 - x6, x2 - x4, x1, x4 - x5, x2 - x3] - 
    CiTi[x2 - x6, x2 - x4, x1, x4 - x5, x3 - x4] - 
    CiTi[x2 - x6, x2 - x4, x1, x5 - x6, x2 - x3] + 
    CiTi[x2 - x6, x2 - x4, x1, x5 - x6, x3 - x4] - 
    CiTi[x2 - x6, x2 - x4, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x2 - x6, x2 - x4, x1 - x2, x2 - x3, x5 - x6] + 
    CiTi[x2 - x6, x2 - x4, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x2 - x6, x2 - x4, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x2 - x6, x2 - x4, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x2 - x6, x2 - x4, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x2 - x6, x2 - x4, x1 - x2, x5 - x6, x2 - x3] - 
    CiTi[x2 - x6, x2 - x4, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x2 - x6, x2 - x4, x2 - x3, x1, x4 - x5] - 
    CiTi[x2 - x6, x2 - x4, x2 - x3, x1, x5 - x6] - 
    CiTi[x2 - x6, x2 - x4, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x2 - x6, x2 - x4, x2 - x3, x1 - x2, x5 - x6] + 
    CiTi[x2 - x6, x2 - x4, x2 - x3, x4 - x5, x1] - 
    CiTi[x2 - x6, x2 - x4, x2 - x3, x4 - x5, x1 - x2] - 
    CiTi[x2 - x6, x2 - x4, x2 - x3, x5 - x6, x1] + 
    CiTi[x2 - x6, x2 - x4, x2 - x3, x5 - x6, x1 - x2] - 
    CiTi[x2 - x6, x2 - x4, x3 - x4, x1, x4 - x5] + 
    CiTi[x2 - x6, x2 - x4, x3 - x4, x1, x5 - x6] + 
    CiTi[x2 - x6, x2 - x4, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x2 - x6, x2 - x4, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x2 - x6, x2 - x4, x3 - x4, x4 - x5, x1] + 
    CiTi[x2 - x6, x2 - x4, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x2 - x6, x2 - x4, x3 - x4, x5 - x6, x1] - 
    CiTi[x2 - x6, x2 - x4, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x2 - x6, x2 - x4, x4 - x5, x1, x2 - x3] - 
    CiTi[x2 - x6, x2 - x4, x4 - x5, x1, x3 - x4] - 
    CiTi[x2 - x6, x2 - x4, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x2 - x6, x2 - x4, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x2 - x6, x2 - x4, x4 - x5, x2 - x3, x1] - 
    CiTi[x2 - x6, x2 - x4, x4 - x5, x2 - x3, x1 - x2] - 
    CiTi[x2 - x6, x2 - x4, x4 - x5, x3 - x4, x1] + 
    CiTi[x2 - x6, x2 - x4, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x2 - x6, x2 - x4, x5 - x6, x1, x2 - x3] + 
    CiTi[x2 - x6, x2 - x4, x5 - x6, x1, x3 - x4] + 
    CiTi[x2 - x6, x2 - x4, x5 - x6, x1 - x2, x2 - x3] - 
    CiTi[x2 - x6, x2 - x4, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x2 - x6, x2 - x4, x5 - x6, x2 - x3, x1] + 
    CiTi[x2 - x6, x2 - x4, x5 - x6, x2 - x3, x1 - x2] + 
    CiTi[x2 - x6, x2 - x4, x5 - x6, x3 - x4, x1] - 
    CiTi[x2 - x6, x2 - x4, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x2 - x6, x2 - x5, x1, x2 - x3, x3 - x4] - 
    CiTi[x2 - x6, x2 - x5, x1, x2 - x3, x4 - x5] + 
    CiTi[x2 - x6, x2 - x5, x1, x2 - x4, x2 - x3] - 
    CiTi[x2 - x6, x2 - x5, x1, x2 - x4, x3 - x4] - 
    CiTi[x2 - x6, x2 - x5, x1, x3 - x5, x3 - x4] + 
    CiTi[x2 - x6, x2 - x5, x1, x3 - x5, x4 - x5] - 
    CiTi[x2 - x6, x2 - x5, x1, x4 - x5, x2 - x3] + 
    CiTi[x2 - x6, x2 - x5, x1, x4 - x5, x3 - x4] - 
    CiTi[x2 - x6, x2 - x5, x1 - x2, x2 - x3, x3 - x4] + 
    CiTi[x2 - x6, x2 - x5, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x2 - x6, x2 - x5, x1 - x2, x2 - x4, x2 - x3] + 
    CiTi[x2 - x6, x2 - x5, x1 - x2, x2 - x4, x3 - x4] + 
    CiTi[x2 - x6, x2 - x5, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x2 - x6, x2 - x5, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x2 - x6, x2 - x5, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x2 - x6, x2 - x5, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x2 - x6, x2 - x5, x2 - x3, x1, x3 - x4] - 
    CiTi[x2 - x6, x2 - x5, x2 - x3, x1, x4 - x5] - 
    CiTi[x2 - x6, x2 - x5, x2 - x3, x1 - x2, x3 - x4] + 
    CiTi[x2 - x6, x2 - x5, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x2 - x6, x2 - x5, x2 - x3, x3 - x4, x1] - 
    CiTi[x2 - x6, x2 - x5, x2 - x3, x3 - x4, x1 - x2] - 
    CiTi[x2 - x6, x2 - x5, x2 - x3, x4 - x5, x1] + 
    CiTi[x2 - x6, x2 - x5, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x2 - x6, x2 - x5, x2 - x4, x1, x2 - x3] - 
    CiTi[x2 - x6, x2 - x5, x2 - x4, x1, x3 - x4] - 
    CiTi[x2 - x6, x2 - x5, x2 - x4, x1 - x2, x2 - x3] + 
    CiTi[x2 - x6, x2 - x5, x2 - x4, x1 - x2, x3 - x4] + 
    CiTi[x2 - x6, x2 - x5, x2 - x4, x2 - x3, x1] - 
    CiTi[x2 - x6, x2 - x5, x2 - x4, x2 - x3, x1 - x2] - 
    CiTi[x2 - x6, x2 - x5, x2 - x4, x3 - x4, x1] + 
    CiTi[x2 - x6, x2 - x5, x2 - x4, x3 - x4, x1 - x2] - 
    CiTi[x2 - x6, x2 - x5, x3 - x5, x1, x3 - x4] + 
    CiTi[x2 - x6, x2 - x5, x3 - x5, x1, x4 - x5] + 
    CiTi[x2 - x6, x2 - x5, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x2 - x6, x2 - x5, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x2 - x6, x2 - x5, x3 - x5, x3 - x4, x1] + 
    CiTi[x2 - x6, x2 - x5, x3 - x5, x3 - x4, x1 - x2] + 
    CiTi[x2 - x6, x2 - x5, x3 - x5, x4 - x5, x1] - 
    CiTi[x2 - x6, x2 - x5, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x2 - x6, x2 - x5, x4 - x5, x1, x2 - x3] + 
    CiTi[x2 - x6, x2 - x5, x4 - x5, x1, x3 - x4] + 
    CiTi[x2 - x6, x2 - x5, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x2 - x6, x2 - x5, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x2 - x6, x2 - x5, x4 - x5, x2 - x3, x1] + 
    CiTi[x2 - x6, x2 - x5, x4 - x5, x2 - x3, x1 - x2] + 
    CiTi[x2 - x6, x2 - x5, x4 - x5, x3 - x4, x1] - 
    CiTi[x2 - x6, x2 - x5, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x2 - x6, x3 - x6, x1, x3 - x4, x4 - x5] + 
    CiTi[x2 - x6, x3 - x6, x1, x3 - x4, x5 - x6] - 
    CiTi[x2 - x6, x3 - x6, x1, x3 - x5, x3 - x4] + 
    CiTi[x2 - x6, x3 - x6, x1, x3 - x5, x4 - x5] + 
    CiTi[x2 - x6, x3 - x6, x1, x4 - x6, x4 - x5] - 
    CiTi[x2 - x6, x3 - x6, x1, x4 - x6, x5 - x6] + 
    CiTi[x2 - x6, x3 - x6, x1, x5 - x6, x3 - x4] - 
    CiTi[x2 - x6, x3 - x6, x1, x5 - x6, x4 - x5] + 
    CiTi[x2 - x6, x3 - x6, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x2 - x6, x3 - x6, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x2 - x6, x3 - x6, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x2 - x6, x3 - x6, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x2 - x6, x3 - x6, x1 - x2, x4 - x6, x4 - x5] + 
    CiTi[x2 - x6, x3 - x6, x1 - x2, x4 - x6, x5 - x6] - 
    CiTi[x2 - x6, x3 - x6, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x2 - x6, x3 - x6, x1 - x2, x5 - x6, x4 - x5] - 
    CiTi[x2 - x6, x3 - x6, x3 - x4, x1, x4 - x5] + 
    CiTi[x2 - x6, x3 - x6, x3 - x4, x1, x5 - x6] + 
    CiTi[x2 - x6, x3 - x6, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x2 - x6, x3 - x6, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x2 - x6, x3 - x6, x3 - x4, x4 - x5, x1] + 
    CiTi[x2 - x6, x3 - x6, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x2 - x6, x3 - x6, x3 - x4, x5 - x6, x1] - 
    CiTi[x2 - x6, x3 - x6, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x2 - x6, x3 - x6, x3 - x5, x1, x3 - x4] + 
    CiTi[x2 - x6, x3 - x6, x3 - x5, x1, x4 - x5] + 
    CiTi[x2 - x6, x3 - x6, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x2 - x6, x3 - x6, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x2 - x6, x3 - x6, x3 - x5, x3 - x4, x1] + 
    CiTi[x2 - x6, x3 - x6, x3 - x5, x3 - x4, x1 - x2] + 
    CiTi[x2 - x6, x3 - x6, x3 - x5, x4 - x5, x1] - 
    CiTi[x2 - x6, x3 - x6, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x2 - x6, x3 - x6, x4 - x6, x1, x4 - x5] - 
    CiTi[x2 - x6, x3 - x6, x4 - x6, x1, x5 - x6] - 
    CiTi[x2 - x6, x3 - x6, x4 - x6, x1 - x2, x4 - x5] + 
    CiTi[x2 - x6, x3 - x6, x4 - x6, x1 - x2, x5 - x6] + 
    CiTi[x2 - x6, x3 - x6, x4 - x6, x4 - x5, x1] - 
    CiTi[x2 - x6, x3 - x6, x4 - x6, x4 - x5, x1 - x2] - 
    CiTi[x2 - x6, x3 - x6, x4 - x6, x5 - x6, x1] + 
    CiTi[x2 - x6, x3 - x6, x4 - x6, x5 - x6, x1 - x2] + 
    CiTi[x2 - x6, x3 - x6, x5 - x6, x1, x3 - x4] - 
    CiTi[x2 - x6, x3 - x6, x5 - x6, x1, x4 - x5] - 
    CiTi[x2 - x6, x3 - x6, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x2 - x6, x3 - x6, x5 - x6, x1 - x2, x4 - x5] + 
    CiTi[x2 - x6, x3 - x6, x5 - x6, x3 - x4, x1] - 
    CiTi[x2 - x6, x3 - x6, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x2 - x6, x3 - x6, x5 - x6, x4 - x5, x1] + 
    CiTi[x2 - x6, x3 - x6, x5 - x6, x4 - x5, x1 - x2] - 
    CiTi[x2 - x6, x4 - x6, x1, x2 - x3, x4 - x5] + 
    CiTi[x2 - x6, x4 - x6, x1, x2 - x3, x5 - x6] + 
    CiTi[x2 - x6, x4 - x6, x1, x3 - x4, x4 - x5] - 
    CiTi[x2 - x6, x4 - x6, x1, x3 - x4, x5 - x6] - 
    CiTi[x2 - x6, x4 - x6, x1, x4 - x5, x2 - x3] + 
    CiTi[x2 - x6, x4 - x6, x1, x4 - x5, x3 - x4] + 
    CiTi[x2 - x6, x4 - x6, x1, x5 - x6, x2 - x3] - 
    CiTi[x2 - x6, x4 - x6, x1, x5 - x6, x3 - x4] + 
    CiTi[x2 - x6, x4 - x6, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x2 - x6, x4 - x6, x1 - x2, x2 - x3, x5 - x6] - 
    CiTi[x2 - x6, x4 - x6, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x2 - x6, x4 - x6, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x2 - x6, x4 - x6, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x2 - x6, x4 - x6, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x2 - x6, x4 - x6, x1 - x2, x5 - x6, x2 - x3] + 
    CiTi[x2 - x6, x4 - x6, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x2 - x6, x4 - x6, x2 - x3, x1, x4 - x5] + 
    CiTi[x2 - x6, x4 - x6, x2 - x3, x1, x5 - x6] + 
    CiTi[x2 - x6, x4 - x6, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x2 - x6, x4 - x6, x2 - x3, x1 - x2, x5 - x6] - 
    CiTi[x2 - x6, x4 - x6, x2 - x3, x4 - x5, x1] + 
    CiTi[x2 - x6, x4 - x6, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x2 - x6, x4 - x6, x2 - x3, x5 - x6, x1] - 
    CiTi[x2 - x6, x4 - x6, x2 - x3, x5 - x6, x1 - x2] + 
    CiTi[x2 - x6, x4 - x6, x3 - x4, x1, x4 - x5] - 
    CiTi[x2 - x6, x4 - x6, x3 - x4, x1, x5 - x6] - 
    CiTi[x2 - x6, x4 - x6, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x2 - x6, x4 - x6, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x2 - x6, x4 - x6, x3 - x4, x4 - x5, x1] - 
    CiTi[x2 - x6, x4 - x6, x3 - x4, x4 - x5, x1 - x2] - 
    CiTi[x2 - x6, x4 - x6, x3 - x4, x5 - x6, x1] + 
    CiTi[x2 - x6, x4 - x6, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x2 - x6, x4 - x6, x4 - x5, x1, x2 - x3] + 
    CiTi[x2 - x6, x4 - x6, x4 - x5, x1, x3 - x4] + 
    CiTi[x2 - x6, x4 - x6, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x2 - x6, x4 - x6, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x2 - x6, x4 - x6, x4 - x5, x2 - x3, x1] + 
    CiTi[x2 - x6, x4 - x6, x4 - x5, x2 - x3, x1 - x2] + 
    CiTi[x2 - x6, x4 - x6, x4 - x5, x3 - x4, x1] - 
    CiTi[x2 - x6, x4 - x6, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x2 - x6, x4 - x6, x5 - x6, x1, x2 - x3] - 
    CiTi[x2 - x6, x4 - x6, x5 - x6, x1, x3 - x4] - 
    CiTi[x2 - x6, x4 - x6, x5 - x6, x1 - x2, x2 - x3] + 
    CiTi[x2 - x6, x4 - x6, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x2 - x6, x4 - x6, x5 - x6, x2 - x3, x1] - 
    CiTi[x2 - x6, x4 - x6, x5 - x6, x2 - x3, x1 - x2] - 
    CiTi[x2 - x6, x4 - x6, x5 - x6, x3 - x4, x1] + 
    CiTi[x2 - x6, x4 - x6, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x2 - x6, x5 - x6, x1, x2 - x3, x3 - x4] + 
    CiTi[x2 - x6, x5 - x6, x1, x2 - x3, x4 - x5] - 
    CiTi[x2 - x6, x5 - x6, x1, x2 - x4, x2 - x3] + 
    CiTi[x2 - x6, x5 - x6, x1, x2 - x4, x3 - x4] + 
    CiTi[x2 - x6, x5 - x6, x1, x3 - x5, x3 - x4] - 
    CiTi[x2 - x6, x5 - x6, x1, x3 - x5, x4 - x5] + 
    CiTi[x2 - x6, x5 - x6, x1, x4 - x5, x2 - x3] - 
    CiTi[x2 - x6, x5 - x6, x1, x4 - x5, x3 - x4] + 
    CiTi[x2 - x6, x5 - x6, x1 - x2, x2 - x3, x3 - x4] - 
    CiTi[x2 - x6, x5 - x6, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x2 - x6, x5 - x6, x1 - x2, x2 - x4, x2 - x3] - 
    CiTi[x2 - x6, x5 - x6, x1 - x2, x2 - x4, x3 - x4] - 
    CiTi[x2 - x6, x5 - x6, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x2 - x6, x5 - x6, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x2 - x6, x5 - x6, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x2 - x6, x5 - x6, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x2 - x6, x5 - x6, x2 - x3, x1, x3 - x4] + 
    CiTi[x2 - x6, x5 - x6, x2 - x3, x1, x4 - x5] + 
    CiTi[x2 - x6, x5 - x6, x2 - x3, x1 - x2, x3 - x4] - 
    CiTi[x2 - x6, x5 - x6, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x2 - x6, x5 - x6, x2 - x3, x3 - x4, x1] + 
    CiTi[x2 - x6, x5 - x6, x2 - x3, x3 - x4, x1 - x2] + 
    CiTi[x2 - x6, x5 - x6, x2 - x3, x4 - x5, x1] - 
    CiTi[x2 - x6, x5 - x6, x2 - x3, x4 - x5, x1 - x2] - 
    CiTi[x2 - x6, x5 - x6, x2 - x4, x1, x2 - x3] + 
    CiTi[x2 - x6, x5 - x6, x2 - x4, x1, x3 - x4] + 
    CiTi[x2 - x6, x5 - x6, x2 - x4, x1 - x2, x2 - x3] - 
    CiTi[x2 - x6, x5 - x6, x2 - x4, x1 - x2, x3 - x4] - 
    CiTi[x2 - x6, x5 - x6, x2 - x4, x2 - x3, x1] + 
    CiTi[x2 - x6, x5 - x6, x2 - x4, x2 - x3, x1 - x2] + 
    CiTi[x2 - x6, x5 - x6, x2 - x4, x3 - x4, x1] - 
    CiTi[x2 - x6, x5 - x6, x2 - x4, x3 - x4, x1 - x2] + 
    CiTi[x2 - x6, x5 - x6, x3 - x5, x1, x3 - x4] - 
    CiTi[x2 - x6, x5 - x6, x3 - x5, x1, x4 - x5] - 
    CiTi[x2 - x6, x5 - x6, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x2 - x6, x5 - x6, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x2 - x6, x5 - x6, x3 - x5, x3 - x4, x1] - 
    CiTi[x2 - x6, x5 - x6, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x2 - x6, x5 - x6, x3 - x5, x4 - x5, x1] + 
    CiTi[x2 - x6, x5 - x6, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x2 - x6, x5 - x6, x4 - x5, x1, x2 - x3] - 
    CiTi[x2 - x6, x5 - x6, x4 - x5, x1, x3 - x4] - 
    CiTi[x2 - x6, x5 - x6, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x2 - x6, x5 - x6, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x2 - x6, x5 - x6, x4 - x5, x2 - x3, x1] - 
    CiTi[x2 - x6, x5 - x6, x4 - x5, x2 - x3, x1 - x2] - 
    CiTi[x2 - x6, x5 - x6, x4 - x5, x3 - x4, x1] + 
    CiTi[x2 - x6, x5 - x6, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x3 - x6, x1, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x3 - x6, x1, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x3 - x6, x1, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x3 - x6, x1, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x3 - x6, x1, x1 - x2, x4 - x6, x4 - x5] + 
    CiTi[x3 - x6, x1, x1 - x2, x4 - x6, x5 - x6] - 
    CiTi[x3 - x6, x1, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x3 - x6, x1, x1 - x2, x5 - x6, x4 - x5] - 
    CiTi[x3 - x6, x1, x2 - x3, x3 - x4, x4 - x5] + 
    CiTi[x3 - x6, x1, x2 - x3, x3 - x4, x5 - x6] - 
    CiTi[x3 - x6, x1, x2 - x3, x3 - x5, x3 - x4] + 
    CiTi[x3 - x6, x1, x2 - x3, x3 - x5, x4 - x5] + 
    CiTi[x3 - x6, x1, x2 - x3, x4 - x6, x4 - x5] - 
    CiTi[x3 - x6, x1, x2 - x3, x4 - x6, x5 - x6] + 
    CiTi[x3 - x6, x1, x2 - x3, x5 - x6, x3 - x4] - 
    CiTi[x3 - x6, x1, x2 - x3, x5 - x6, x4 - x5] + 
    CiTi[x3 - x6, x1, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x1, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x3 - x6, x1, x3 - x4, x2 - x3, x4 - x5] + 
    CiTi[x3 - x6, x1, x3 - x4, x2 - x3, x5 - x6] + 
    CiTi[x3 - x6, x1, x3 - x4, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x1, x3 - x4, x4 - x5, x2 - x3] - 
    CiTi[x3 - x6, x1, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x3 - x6, x1, x3 - x4, x5 - x6, x2 - x3] + 
    CiTi[x3 - x6, x1, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x3 - x6, x1, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x1, x3 - x5, x2 - x3, x3 - x4] + 
    CiTi[x3 - x6, x1, x3 - x5, x2 - x3, x4 - x5] + 
    CiTi[x3 - x6, x1, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x3 - x6, x1, x3 - x5, x3 - x4, x2 - x3] - 
    CiTi[x3 - x6, x1, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x1, x3 - x5, x4 - x5, x2 - x3] - 
    CiTi[x3 - x6, x1, x4 - x6, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x1, x4 - x6, x1 - x2, x5 - x6] + 
    CiTi[x3 - x6, x1, x4 - x6, x2 - x3, x4 - x5] - 
    CiTi[x3 - x6, x1, x4 - x6, x2 - x3, x5 - x6] - 
    CiTi[x3 - x6, x1, x4 - x6, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x1, x4 - x6, x4 - x5, x2 - x3] + 
    CiTi[x3 - x6, x1, x4 - x6, x5 - x6, x1 - x2] - 
    CiTi[x3 - x6, x1, x4 - x6, x5 - x6, x2 - x3] - 
    CiTi[x3 - x6, x1, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x3 - x6, x1, x5 - x6, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x1, x5 - x6, x2 - x3, x3 - x4] - 
    CiTi[x3 - x6, x1, x5 - x6, x2 - x3, x4 - x5] - 
    CiTi[x3 - x6, x1, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x3 - x6, x1, x5 - x6, x3 - x4, x2 - x3] + 
    CiTi[x3 - x6, x1, x5 - x6, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x1, x5 - x6, x4 - x5, x2 - x3] + 
    CiTi[x3 - x6, x2, x1, x3 - x4, x4 - x5] - CiTi[x3 - x6, x2, x1, x3 - x4, 
     x5 - x6] + CiTi[x3 - x6, x2, x1, x3 - x5, x3 - x4] - 
    CiTi[x3 - x6, x2, x1, x3 - x5, x4 - x5] - CiTi[x3 - x6, x2, x1, x4 - x6, 
     x4 - x5] + CiTi[x3 - x6, x2, x1, x4 - x6, x5 - x6] - 
    CiTi[x3 - x6, x2, x1, x5 - x6, x3 - x4] + CiTi[x3 - x6, x2, x1, x5 - x6, 
     x4 - x5] - CiTi[x3 - x6, x2, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x3 - x6, x2, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x3 - x6, x2, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x3 - x6, x2, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x3 - x6, x2, x1 - x2, x4 - x6, x4 - x5] - 
    CiTi[x3 - x6, x2, x1 - x2, x4 - x6, x5 - x6] + 
    CiTi[x3 - x6, x2, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x3 - x6, x2, x1 - x2, x5 - x6, x4 - x5] + 
    CiTi[x3 - x6, x2, x3 - x4, x1, x4 - x5] - CiTi[x3 - x6, x2, x3 - x4, x1, 
     x5 - x6] - CiTi[x3 - x6, x2, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x2, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x3 - x6, x2, x3 - x4, x4 - x5, x1] - CiTi[x3 - x6, x2, x3 - x4, 
     x4 - x5, x1 - x2] - CiTi[x3 - x6, x2, x3 - x4, x5 - x6, x1] + 
    CiTi[x3 - x6, x2, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x3 - x6, x2, x3 - x5, x1, x3 - x4] - CiTi[x3 - x6, x2, x3 - x5, x1, 
     x4 - x5] - CiTi[x3 - x6, x2, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x3 - x6, x2, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x2, x3 - x5, x3 - x4, x1] - CiTi[x3 - x6, x2, x3 - x5, 
     x3 - x4, x1 - x2] - CiTi[x3 - x6, x2, x3 - x5, x4 - x5, x1] + 
    CiTi[x3 - x6, x2, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x2, x4 - x6, x1, x4 - x5] + CiTi[x3 - x6, x2, x4 - x6, x1, 
     x5 - x6] + CiTi[x3 - x6, x2, x4 - x6, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x2, x4 - x6, x1 - x2, x5 - x6] - 
    CiTi[x3 - x6, x2, x4 - x6, x4 - x5, x1] + CiTi[x3 - x6, x2, x4 - x6, 
     x4 - x5, x1 - x2] + CiTi[x3 - x6, x2, x4 - x6, x5 - x6, x1] - 
    CiTi[x3 - x6, x2, x4 - x6, x5 - x6, x1 - x2] - 
    CiTi[x3 - x6, x2, x5 - x6, x1, x3 - x4] + CiTi[x3 - x6, x2, x5 - x6, x1, 
     x4 - x5] + CiTi[x3 - x6, x2, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x3 - x6, x2, x5 - x6, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x2, x5 - x6, x3 - x4, x1] + CiTi[x3 - x6, x2, x5 - x6, 
     x3 - x4, x1 - x2] + CiTi[x3 - x6, x2, x5 - x6, x4 - x5, x1] - 
    CiTi[x3 - x6, x2, x5 - x6, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x1 - x3, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x3 - x6, x1 - x3, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x3 - x6, x1 - x3, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x3 - x6, x1 - x3, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x3 - x6, x1 - x3, x1 - x2, x4 - x6, x4 - x5] - 
    CiTi[x3 - x6, x1 - x3, x1 - x2, x4 - x6, x5 - x6] + 
    CiTi[x3 - x6, x1 - x3, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x3 - x6, x1 - x3, x1 - x2, x5 - x6, x4 - x5] + 
    CiTi[x3 - x6, x1 - x3, x2 - x3, x3 - x4, x4 - x5] - 
    CiTi[x3 - x6, x1 - x3, x2 - x3, x3 - x4, x5 - x6] + 
    CiTi[x3 - x6, x1 - x3, x2 - x3, x3 - x5, x3 - x4] - 
    CiTi[x3 - x6, x1 - x3, x2 - x3, x3 - x5, x4 - x5] - 
    CiTi[x3 - x6, x1 - x3, x2 - x3, x4 - x6, x4 - x5] + 
    CiTi[x3 - x6, x1 - x3, x2 - x3, x4 - x6, x5 - x6] - 
    CiTi[x3 - x6, x1 - x3, x2 - x3, x5 - x6, x3 - x4] + 
    CiTi[x3 - x6, x1 - x3, x2 - x3, x5 - x6, x4 - x5] - 
    CiTi[x3 - x6, x1 - x3, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x1 - x3, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x3 - x6, x1 - x3, x3 - x4, x2 - x3, x4 - x5] - 
    CiTi[x3 - x6, x1 - x3, x3 - x4, x2 - x3, x5 - x6] - 
    CiTi[x3 - x6, x1 - x3, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x1 - x3, x3 - x4, x4 - x5, x2 - x3] + 
    CiTi[x3 - x6, x1 - x3, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x3 - x6, x1 - x3, x3 - x4, x5 - x6, x2 - x3] - 
    CiTi[x3 - x6, x1 - x3, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x3 - x6, x1 - x3, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x1 - x3, x3 - x5, x2 - x3, x3 - x4] - 
    CiTi[x3 - x6, x1 - x3, x3 - x5, x2 - x3, x4 - x5] - 
    CiTi[x3 - x6, x1 - x3, x3 - x5, x3 - x4, x1 - x2] + 
    CiTi[x3 - x6, x1 - x3, x3 - x5, x3 - x4, x2 - x3] + 
    CiTi[x3 - x6, x1 - x3, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x1 - x3, x3 - x5, x4 - x5, x2 - x3] + 
    CiTi[x3 - x6, x1 - x3, x4 - x6, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x1 - x3, x4 - x6, x1 - x2, x5 - x6] - 
    CiTi[x3 - x6, x1 - x3, x4 - x6, x2 - x3, x4 - x5] + 
    CiTi[x3 - x6, x1 - x3, x4 - x6, x2 - x3, x5 - x6] + 
    CiTi[x3 - x6, x1 - x3, x4 - x6, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x1 - x3, x4 - x6, x4 - x5, x2 - x3] - 
    CiTi[x3 - x6, x1 - x3, x4 - x6, x5 - x6, x1 - x2] + 
    CiTi[x3 - x6, x1 - x3, x4 - x6, x5 - x6, x2 - x3] + 
    CiTi[x3 - x6, x1 - x3, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x3 - x6, x1 - x3, x5 - x6, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x1 - x3, x5 - x6, x2 - x3, x3 - x4] + 
    CiTi[x3 - x6, x1 - x3, x5 - x6, x2 - x3, x4 - x5] + 
    CiTi[x3 - x6, x1 - x3, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x3 - x6, x1 - x3, x5 - x6, x3 - x4, x2 - x3] - 
    CiTi[x3 - x6, x1 - x3, x5 - x6, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x1 - x3, x5 - x6, x4 - x5, x2 - x3] - 
    CiTi[x3 - x6, x2 - x3, x1, x3 - x4, x4 - x5] + 
    CiTi[x3 - x6, x2 - x3, x1, x3 - x4, x5 - x6] - 
    CiTi[x3 - x6, x2 - x3, x1, x3 - x5, x3 - x4] + 
    CiTi[x3 - x6, x2 - x3, x1, x3 - x5, x4 - x5] + 
    CiTi[x3 - x6, x2 - x3, x1, x4 - x6, x4 - x5] - 
    CiTi[x3 - x6, x2 - x3, x1, x4 - x6, x5 - x6] + 
    CiTi[x3 - x6, x2 - x3, x1, x5 - x6, x3 - x4] - 
    CiTi[x3 - x6, x2 - x3, x1, x5 - x6, x4 - x5] + 
    CiTi[x3 - x6, x2 - x3, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x3 - x6, x2 - x3, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x3 - x6, x2 - x3, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x3 - x6, x2 - x3, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x3 - x6, x2 - x3, x1 - x2, x4 - x6, x4 - x5] + 
    CiTi[x3 - x6, x2 - x3, x1 - x2, x4 - x6, x5 - x6] - 
    CiTi[x3 - x6, x2 - x3, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x3 - x6, x2 - x3, x1 - x2, x5 - x6, x4 - x5] - 
    CiTi[x3 - x6, x2 - x3, x3 - x4, x1, x4 - x5] + 
    CiTi[x3 - x6, x2 - x3, x3 - x4, x1, x5 - x6] + 
    CiTi[x3 - x6, x2 - x3, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x2 - x3, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x3 - x6, x2 - x3, x3 - x4, x4 - x5, x1] + 
    CiTi[x3 - x6, x2 - x3, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x2 - x3, x3 - x4, x5 - x6, x1] - 
    CiTi[x3 - x6, x2 - x3, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x3 - x6, x2 - x3, x3 - x5, x1, x3 - x4] + 
    CiTi[x3 - x6, x2 - x3, x3 - x5, x1, x4 - x5] + 
    CiTi[x3 - x6, x2 - x3, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x3 - x6, x2 - x3, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x2 - x3, x3 - x5, x3 - x4, x1] + 
    CiTi[x3 - x6, x2 - x3, x3 - x5, x3 - x4, x1 - x2] + 
    CiTi[x3 - x6, x2 - x3, x3 - x5, x4 - x5, x1] - 
    CiTi[x3 - x6, x2 - x3, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x2 - x3, x4 - x6, x1, x4 - x5] - 
    CiTi[x3 - x6, x2 - x3, x4 - x6, x1, x5 - x6] - 
    CiTi[x3 - x6, x2 - x3, x4 - x6, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x2 - x3, x4 - x6, x1 - x2, x5 - x6] + 
    CiTi[x3 - x6, x2 - x3, x4 - x6, x4 - x5, x1] - 
    CiTi[x3 - x6, x2 - x3, x4 - x6, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x2 - x3, x4 - x6, x5 - x6, x1] + 
    CiTi[x3 - x6, x2 - x3, x4 - x6, x5 - x6, x1 - x2] + 
    CiTi[x3 - x6, x2 - x3, x5 - x6, x1, x3 - x4] - 
    CiTi[x3 - x6, x2 - x3, x5 - x6, x1, x4 - x5] - 
    CiTi[x3 - x6, x2 - x3, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x3 - x6, x2 - x3, x5 - x6, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x2 - x3, x5 - x6, x3 - x4, x1] - 
    CiTi[x3 - x6, x2 - x3, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x3 - x6, x2 - x3, x5 - x6, x4 - x5, x1] + 
    CiTi[x3 - x6, x2 - x3, x5 - x6, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x3 - x4, x1, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x3 - x4, x1, x1 - x2, x5 - x6] - 
    CiTi[x3 - x6, x3 - x4, x1, x2 - x3, x4 - x5] + 
    CiTi[x3 - x6, x3 - x4, x1, x2 - x3, x5 - x6] + 
    CiTi[x3 - x6, x3 - x4, x1, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x3 - x4, x1, x4 - x5, x2 - x3] - 
    CiTi[x3 - x6, x3 - x4, x1, x5 - x6, x1 - x2] + 
    CiTi[x3 - x6, x3 - x4, x1, x5 - x6, x2 - x3] + 
    CiTi[x3 - x6, x3 - x4, x2, x1, x4 - x5] - CiTi[x3 - x6, x3 - x4, x2, x1, 
     x5 - x6] - CiTi[x3 - x6, x3 - x4, x2, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x3 - x4, x2, x1 - x2, x5 - x6] + 
    CiTi[x3 - x6, x3 - x4, x2, x4 - x5, x1] - CiTi[x3 - x6, x3 - x4, x2, 
     x4 - x5, x1 - x2] - CiTi[x3 - x6, x3 - x4, x2, x5 - x6, x1] + 
    CiTi[x3 - x6, x3 - x4, x2, x5 - x6, x1 - x2] - 
    CiTi[x3 - x6, x3 - x4, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x3 - x4, x1 - x3, x1 - x2, x5 - x6] + 
    CiTi[x3 - x6, x3 - x4, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x3 - x6, x3 - x4, x1 - x3, x2 - x3, x5 - x6] - 
    CiTi[x3 - x6, x3 - x4, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x3 - x4, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x3 - x6, x3 - x4, x1 - x3, x5 - x6, x1 - x2] - 
    CiTi[x3 - x6, x3 - x4, x1 - x3, x5 - x6, x2 - x3] - 
    CiTi[x3 - x6, x3 - x4, x2 - x3, x1, x4 - x5] + 
    CiTi[x3 - x6, x3 - x4, x2 - x3, x1, x5 - x6] + 
    CiTi[x3 - x6, x3 - x4, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x3 - x4, x2 - x3, x1 - x2, x5 - x6] - 
    CiTi[x3 - x6, x3 - x4, x2 - x3, x4 - x5, x1] + 
    CiTi[x3 - x6, x3 - x4, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x3 - x4, x2 - x3, x5 - x6, x1] - 
    CiTi[x3 - x6, x3 - x4, x2 - x3, x5 - x6, x1 - x2] + 
    CiTi[x3 - x6, x3 - x4, x4 - x5, x1, x1 - x2] - 
    CiTi[x3 - x6, x3 - x4, x4 - x5, x1, x2 - x3] + 
    CiTi[x3 - x6, x3 - x4, x4 - x5, x2, x1] - CiTi[x3 - x6, x3 - x4, x4 - x5, 
     x2, x1 - x2] - CiTi[x3 - x6, x3 - x4, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x3 - x6, x3 - x4, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x3 - x6, x3 - x4, x4 - x5, x2 - x3, x1] + 
    CiTi[x3 - x6, x3 - x4, x4 - x5, x2 - x3, x1 - x2] - 
    CiTi[x3 - x6, x3 - x4, x5 - x6, x1, x1 - x2] + 
    CiTi[x3 - x6, x3 - x4, x5 - x6, x1, x2 - x3] - 
    CiTi[x3 - x6, x3 - x4, x5 - x6, x2, x1] + CiTi[x3 - x6, x3 - x4, x5 - x6, 
     x2, x1 - x2] + CiTi[x3 - x6, x3 - x4, x5 - x6, x1 - x3, x1 - x2] - 
    CiTi[x3 - x6, x3 - x4, x5 - x6, x1 - x3, x2 - x3] + 
    CiTi[x3 - x6, x3 - x4, x5 - x6, x2 - x3, x1] - 
    CiTi[x3 - x6, x3 - x4, x5 - x6, x2 - x3, x1 - x2] + 
    CiTi[x3 - x6, x3 - x5, x1, x1 - x2, x3 - x4] - 
    CiTi[x3 - x6, x3 - x5, x1, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x3 - x5, x1, x2 - x3, x3 - x4] + 
    CiTi[x3 - x6, x3 - x5, x1, x2 - x3, x4 - x5] + 
    CiTi[x3 - x6, x3 - x5, x1, x3 - x4, x1 - x2] - 
    CiTi[x3 - x6, x3 - x5, x1, x3 - x4, x2 - x3] - 
    CiTi[x3 - x6, x3 - x5, x1, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x3 - x5, x1, x4 - x5, x2 - x3] + 
    CiTi[x3 - x6, x3 - x5, x2, x1, x3 - x4] - CiTi[x3 - x6, x3 - x5, x2, x1, 
     x4 - x5] - CiTi[x3 - x6, x3 - x5, x2, x1 - x2, x3 - x4] + 
    CiTi[x3 - x6, x3 - x5, x2, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x3 - x5, x2, x3 - x4, x1] - CiTi[x3 - x6, x3 - x5, x2, 
     x3 - x4, x1 - x2] - CiTi[x3 - x6, x3 - x5, x2, x4 - x5, x1] + 
    CiTi[x3 - x6, x3 - x5, x2, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x3 - x5, x1 - x3, x1 - x2, x3 - x4] + 
    CiTi[x3 - x6, x3 - x5, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x3 - x5, x1 - x3, x2 - x3, x3 - x4] - 
    CiTi[x3 - x6, x3 - x5, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x3 - x6, x3 - x5, x1 - x3, x3 - x4, x1 - x2] + 
    CiTi[x3 - x6, x3 - x5, x1 - x3, x3 - x4, x2 - x3] + 
    CiTi[x3 - x6, x3 - x5, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x3 - x5, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x3 - x6, x3 - x5, x2 - x3, x1, x3 - x4] + 
    CiTi[x3 - x6, x3 - x5, x2 - x3, x1, x4 - x5] + 
    CiTi[x3 - x6, x3 - x5, x2 - x3, x1 - x2, x3 - x4] - 
    CiTi[x3 - x6, x3 - x5, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x3 - x5, x2 - x3, x3 - x4, x1] + 
    CiTi[x3 - x6, x3 - x5, x2 - x3, x3 - x4, x1 - x2] + 
    CiTi[x3 - x6, x3 - x5, x2 - x3, x4 - x5, x1] - 
    CiTi[x3 - x6, x3 - x5, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x3 - x5, x3 - x4, x1, x1 - x2] - 
    CiTi[x3 - x6, x3 - x5, x3 - x4, x1, x2 - x3] + 
    CiTi[x3 - x6, x3 - x5, x3 - x4, x2, x1] - CiTi[x3 - x6, x3 - x5, x3 - x4, 
     x2, x1 - x2] - CiTi[x3 - x6, x3 - x5, x3 - x4, x1 - x3, x1 - x2] + 
    CiTi[x3 - x6, x3 - x5, x3 - x4, x1 - x3, x2 - x3] - 
    CiTi[x3 - x6, x3 - x5, x3 - x4, x2 - x3, x1] + 
    CiTi[x3 - x6, x3 - x5, x3 - x4, x2 - x3, x1 - x2] - 
    CiTi[x3 - x6, x3 - x5, x4 - x5, x1, x1 - x2] + 
    CiTi[x3 - x6, x3 - x5, x4 - x5, x1, x2 - x3] - 
    CiTi[x3 - x6, x3 - x5, x4 - x5, x2, x1] + CiTi[x3 - x6, x3 - x5, x4 - x5, 
     x2, x1 - x2] + CiTi[x3 - x6, x3 - x5, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x3 - x6, x3 - x5, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x3 - x6, x3 - x5, x4 - x5, x2 - x3, x1] - 
    CiTi[x3 - x6, x3 - x5, x4 - x5, x2 - x3, x1 - x2] - 
    CiTi[x3 - x6, x4 - x6, x1, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x4 - x6, x1, x1 - x2, x5 - x6] + 
    CiTi[x3 - x6, x4 - x6, x1, x2 - x3, x4 - x5] - 
    CiTi[x3 - x6, x4 - x6, x1, x2 - x3, x5 - x6] - 
    CiTi[x3 - x6, x4 - x6, x1, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x4 - x6, x1, x4 - x5, x2 - x3] + 
    CiTi[x3 - x6, x4 - x6, x1, x5 - x6, x1 - x2] - 
    CiTi[x3 - x6, x4 - x6, x1, x5 - x6, x2 - x3] - 
    CiTi[x3 - x6, x4 - x6, x2, x1, x4 - x5] + CiTi[x3 - x6, x4 - x6, x2, x1, 
     x5 - x6] + CiTi[x3 - x6, x4 - x6, x2, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x4 - x6, x2, x1 - x2, x5 - x6] - 
    CiTi[x3 - x6, x4 - x6, x2, x4 - x5, x1] + CiTi[x3 - x6, x4 - x6, x2, 
     x4 - x5, x1 - x2] + CiTi[x3 - x6, x4 - x6, x2, x5 - x6, x1] - 
    CiTi[x3 - x6, x4 - x6, x2, x5 - x6, x1 - x2] + 
    CiTi[x3 - x6, x4 - x6, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x4 - x6, x1 - x3, x1 - x2, x5 - x6] - 
    CiTi[x3 - x6, x4 - x6, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x3 - x6, x4 - x6, x1 - x3, x2 - x3, x5 - x6] + 
    CiTi[x3 - x6, x4 - x6, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x4 - x6, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x3 - x6, x4 - x6, x1 - x3, x5 - x6, x1 - x2] + 
    CiTi[x3 - x6, x4 - x6, x1 - x3, x5 - x6, x2 - x3] + 
    CiTi[x3 - x6, x4 - x6, x2 - x3, x1, x4 - x5] - 
    CiTi[x3 - x6, x4 - x6, x2 - x3, x1, x5 - x6] - 
    CiTi[x3 - x6, x4 - x6, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x4 - x6, x2 - x3, x1 - x2, x5 - x6] + 
    CiTi[x3 - x6, x4 - x6, x2 - x3, x4 - x5, x1] - 
    CiTi[x3 - x6, x4 - x6, x2 - x3, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x4 - x6, x2 - x3, x5 - x6, x1] + 
    CiTi[x3 - x6, x4 - x6, x2 - x3, x5 - x6, x1 - x2] - 
    CiTi[x3 - x6, x4 - x6, x4 - x5, x1, x1 - x2] + 
    CiTi[x3 - x6, x4 - x6, x4 - x5, x1, x2 - x3] - 
    CiTi[x3 - x6, x4 - x6, x4 - x5, x2, x1] + CiTi[x3 - x6, x4 - x6, x4 - x5, 
     x2, x1 - x2] + CiTi[x3 - x6, x4 - x6, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x3 - x6, x4 - x6, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x3 - x6, x4 - x6, x4 - x5, x2 - x3, x1] - 
    CiTi[x3 - x6, x4 - x6, x4 - x5, x2 - x3, x1 - x2] + 
    CiTi[x3 - x6, x4 - x6, x5 - x6, x1, x1 - x2] - 
    CiTi[x3 - x6, x4 - x6, x5 - x6, x1, x2 - x3] + 
    CiTi[x3 - x6, x4 - x6, x5 - x6, x2, x1] - CiTi[x3 - x6, x4 - x6, x5 - x6, 
     x2, x1 - x2] - CiTi[x3 - x6, x4 - x6, x5 - x6, x1 - x3, x1 - x2] + 
    CiTi[x3 - x6, x4 - x6, x5 - x6, x1 - x3, x2 - x3] - 
    CiTi[x3 - x6, x4 - x6, x5 - x6, x2 - x3, x1] + 
    CiTi[x3 - x6, x4 - x6, x5 - x6, x2 - x3, x1 - x2] - 
    CiTi[x3 - x6, x5 - x6, x1, x1 - x2, x3 - x4] + 
    CiTi[x3 - x6, x5 - x6, x1, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x5 - x6, x1, x2 - x3, x3 - x4] - 
    CiTi[x3 - x6, x5 - x6, x1, x2 - x3, x4 - x5] - 
    CiTi[x3 - x6, x5 - x6, x1, x3 - x4, x1 - x2] + 
    CiTi[x3 - x6, x5 - x6, x1, x3 - x4, x2 - x3] + 
    CiTi[x3 - x6, x5 - x6, x1, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x5 - x6, x1, x4 - x5, x2 - x3] - 
    CiTi[x3 - x6, x5 - x6, x2, x1, x3 - x4] + CiTi[x3 - x6, x5 - x6, x2, x1, 
     x4 - x5] + CiTi[x3 - x6, x5 - x6, x2, x1 - x2, x3 - x4] - 
    CiTi[x3 - x6, x5 - x6, x2, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x5 - x6, x2, x3 - x4, x1] + CiTi[x3 - x6, x5 - x6, x2, 
     x3 - x4, x1 - x2] + CiTi[x3 - x6, x5 - x6, x2, x4 - x5, x1] - 
    CiTi[x3 - x6, x5 - x6, x2, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x5 - x6, x1 - x3, x1 - x2, x3 - x4] - 
    CiTi[x3 - x6, x5 - x6, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x3 - x6, x5 - x6, x1 - x3, x2 - x3, x3 - x4] + 
    CiTi[x3 - x6, x5 - x6, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x3 - x6, x5 - x6, x1 - x3, x3 - x4, x1 - x2] - 
    CiTi[x3 - x6, x5 - x6, x1 - x3, x3 - x4, x2 - x3] - 
    CiTi[x3 - x6, x5 - x6, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x3 - x6, x5 - x6, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x3 - x6, x5 - x6, x2 - x3, x1, x3 - x4] - 
    CiTi[x3 - x6, x5 - x6, x2 - x3, x1, x4 - x5] - 
    CiTi[x3 - x6, x5 - x6, x2 - x3, x1 - x2, x3 - x4] + 
    CiTi[x3 - x6, x5 - x6, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x3 - x6, x5 - x6, x2 - x3, x3 - x4, x1] - 
    CiTi[x3 - x6, x5 - x6, x2 - x3, x3 - x4, x1 - x2] - 
    CiTi[x3 - x6, x5 - x6, x2 - x3, x4 - x5, x1] + 
    CiTi[x3 - x6, x5 - x6, x2 - x3, x4 - x5, x1 - x2] - 
    CiTi[x3 - x6, x5 - x6, x3 - x4, x1, x1 - x2] + 
    CiTi[x3 - x6, x5 - x6, x3 - x4, x1, x2 - x3] - 
    CiTi[x3 - x6, x5 - x6, x3 - x4, x2, x1] + CiTi[x3 - x6, x5 - x6, x3 - x4, 
     x2, x1 - x2] + CiTi[x3 - x6, x5 - x6, x3 - x4, x1 - x3, x1 - x2] - 
    CiTi[x3 - x6, x5 - x6, x3 - x4, x1 - x3, x2 - x3] + 
    CiTi[x3 - x6, x5 - x6, x3 - x4, x2 - x3, x1] - 
    CiTi[x3 - x6, x5 - x6, x3 - x4, x2 - x3, x1 - x2] + 
    CiTi[x3 - x6, x5 - x6, x4 - x5, x1, x1 - x2] - 
    CiTi[x3 - x6, x5 - x6, x4 - x5, x1, x2 - x3] + 
    CiTi[x3 - x6, x5 - x6, x4 - x5, x2, x1] - CiTi[x3 - x6, x5 - x6, x4 - x5, 
     x2, x1 - x2] - CiTi[x3 - x6, x5 - x6, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x3 - x6, x5 - x6, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x3 - x6, x5 - x6, x4 - x5, x2 - x3, x1] + 
    CiTi[x3 - x6, x5 - x6, x4 - x5, x2 - x3, x1 - x2] + 
    CiTi[x4 - x6, x1, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x4 - x6, x1, x1 - x2, x2 - x3, x5 - x6] - 
    CiTi[x4 - x6, x1, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x4 - x6, x1, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x4 - x6, x1, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x4 - x6, x1, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x4 - x6, x1, x1 - x2, x5 - x6, x2 - x3] + 
    CiTi[x4 - x6, x1, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x4 - x6, x1, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x4 - x6, x1, x1 - x3, x1 - x2, x5 - x6] - 
    CiTi[x4 - x6, x1, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x4 - x6, x1, x1 - x3, x2 - x3, x5 - x6] + 
    CiTi[x4 - x6, x1, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x4 - x6, x1, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x4 - x6, x1, x1 - x3, x5 - x6, x1 - x2] + 
    CiTi[x4 - x6, x1, x1 - x3, x5 - x6, x2 - x3] - 
    CiTi[x4 - x6, x1, x2 - x4, x2 - x3, x4 - x5] + 
    CiTi[x4 - x6, x1, x2 - x4, x2 - x3, x5 - x6] + 
    CiTi[x4 - x6, x1, x2 - x4, x3 - x4, x4 - x5] - 
    CiTi[x4 - x6, x1, x2 - x4, x3 - x4, x5 - x6] - 
    CiTi[x4 - x6, x1, x2 - x4, x4 - x5, x2 - x3] + 
    CiTi[x4 - x6, x1, x2 - x4, x4 - x5, x3 - x4] + 
    CiTi[x4 - x6, x1, x2 - x4, x5 - x6, x2 - x3] - 
    CiTi[x4 - x6, x1, x2 - x4, x5 - x6, x3 - x4] - 
    CiTi[x4 - x6, x1, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x4 - x6, x1, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x4 - x6, x1, x3 - x4, x2 - x3, x4 - x5] - 
    CiTi[x4 - x6, x1, x3 - x4, x2 - x3, x5 - x6] - 
    CiTi[x4 - x6, x1, x3 - x4, x4 - x5, x1 - x2] + 
    CiTi[x4 - x6, x1, x3 - x4, x4 - x5, x2 - x3] + 
    CiTi[x4 - x6, x1, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x4 - x6, x1, x3 - x4, x5 - x6, x2 - x3] + 
    CiTi[x4 - x6, x1, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x4 - x6, x1, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x4 - x6, x1, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x4 - x6, x1, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x4 - x6, x1, x4 - x5, x2 - x4, x2 - x3] + 
    CiTi[x4 - x6, x1, x4 - x5, x2 - x4, x3 - x4] - 
    CiTi[x4 - x6, x1, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x4 - x6, x1, x4 - x5, x3 - x4, x2 - x3] - 
    CiTi[x4 - x6, x1, x5 - x6, x1 - x2, x2 - x3] + 
    CiTi[x4 - x6, x1, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x4 - x6, x1, x5 - x6, x1 - x3, x1 - x2] + 
    CiTi[x4 - x6, x1, x5 - x6, x1 - x3, x2 - x3] + 
    CiTi[x4 - x6, x1, x5 - x6, x2 - x4, x2 - x3] - 
    CiTi[x4 - x6, x1, x5 - x6, x2 - x4, x3 - x4] + 
    CiTi[x4 - x6, x1, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x4 - x6, x1, x5 - x6, x3 - x4, x2 - x3] + 
    CiTi[x4 - x6, x2, x1, x2 - x3, x4 - x5] - CiTi[x4 - x6, x2, x1, x2 - x3, 
     x5 - x6] - CiTi[x4 - x6, x2, x1, x3 - x4, x4 - x5] + 
    CiTi[x4 - x6, x2, x1, x3 - x4, x5 - x6] + CiTi[x4 - x6, x2, x1, x4 - x5, 
     x2 - x3] - CiTi[x4 - x6, x2, x1, x4 - x5, x3 - x4] - 
    CiTi[x4 - x6, x2, x1, x5 - x6, x2 - x3] + CiTi[x4 - x6, x2, x1, x5 - x6, 
     x3 - x4] - CiTi[x4 - x6, x2, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x4 - x6, x2, x1 - x2, x2 - x3, x5 - x6] + 
    CiTi[x4 - x6, x2, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x4 - x6, x2, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x4 - x6, x2, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x4 - x6, x2, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x4 - x6, x2, x1 - x2, x5 - x6, x2 - x3] - 
    CiTi[x4 - x6, x2, x1 - x2, x5 - x6, x3 - x4] + 
    CiTi[x4 - x6, x2, x2 - x3, x1, x4 - x5] - CiTi[x4 - x6, x2, x2 - x3, x1, 
     x5 - x6] - CiTi[x4 - x6, x2, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x4 - x6, x2, x2 - x3, x1 - x2, x5 - x6] + 
    CiTi[x4 - x6, x2, x2 - x3, x4 - x5, x1] - CiTi[x4 - x6, x2, x2 - x3, 
     x4 - x5, x1 - x2] - CiTi[x4 - x6, x2, x2 - x3, x5 - x6, x1] + 
    CiTi[x4 - x6, x2, x2 - x3, x5 - x6, x1 - x2] - 
    CiTi[x4 - x6, x2, x3 - x4, x1, x4 - x5] + CiTi[x4 - x6, x2, x3 - x4, x1, 
     x5 - x6] + CiTi[x4 - x6, x2, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x4 - x6, x2, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x4 - x6, x2, x3 - x4, x4 - x5, x1] + CiTi[x4 - x6, x2, x3 - x4, 
     x4 - x5, x1 - x2] + CiTi[x4 - x6, x2, x3 - x4, x5 - x6, x1] - 
    CiTi[x4 - x6, x2, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x4 - x6, x2, x4 - x5, x1, x2 - x3] - CiTi[x4 - x6, x2, x4 - x5, x1, 
     x3 - x4] - CiTi[x4 - x6, x2, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x4 - x6, x2, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x4 - x6, x2, x4 - x5, x2 - x3, x1] - CiTi[x4 - x6, x2, x4 - x5, 
     x2 - x3, x1 - x2] - CiTi[x4 - x6, x2, x4 - x5, x3 - x4, x1] + 
    CiTi[x4 - x6, x2, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x4 - x6, x2, x5 - x6, x1, x2 - x3] + CiTi[x4 - x6, x2, x5 - x6, x1, 
     x3 - x4] + CiTi[x4 - x6, x2, x5 - x6, x1 - x2, x2 - x3] - 
    CiTi[x4 - x6, x2, x5 - x6, x1 - x2, x3 - x4] - 
    CiTi[x4 - x6, x2, x5 - x6, x2 - x3, x1] + CiTi[x4 - x6, x2, x5 - x6, 
     x2 - x3, x1 - x2] + CiTi[x4 - x6, x2, x5 - x6, x3 - x4, x1] - 
    CiTi[x4 - x6, x2, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x4 - x6, x3, x1, x1 - x2, x4 - x5] - CiTi[x4 - x6, x3, x1, x1 - x2, 
     x5 - x6] - CiTi[x4 - x6, x3, x1, x2 - x3, x4 - x5] + 
    CiTi[x4 - x6, x3, x1, x2 - x3, x5 - x6] + CiTi[x4 - x6, x3, x1, x4 - x5, 
     x1 - x2] - CiTi[x4 - x6, x3, x1, x4 - x5, x2 - x3] - 
    CiTi[x4 - x6, x3, x1, x5 - x6, x1 - x2] + CiTi[x4 - x6, x3, x1, x5 - x6, 
     x2 - x3] + CiTi[x4 - x6, x3, x2, x1, x4 - x5] - 
    CiTi[x4 - x6, x3, x2, x1, x5 - x6] - CiTi[x4 - x6, x3, x2, x1 - x2, 
     x4 - x5] + CiTi[x4 - x6, x3, x2, x1 - x2, x5 - x6] + 
    CiTi[x4 - x6, x3, x2, x4 - x5, x1] - CiTi[x4 - x6, x3, x2, x4 - x5, 
     x1 - x2] - CiTi[x4 - x6, x3, x2, x5 - x6, x1] + 
    CiTi[x4 - x6, x3, x2, x5 - x6, x1 - x2] - CiTi[x4 - x6, x3, x1 - x3, 
     x1 - x2, x4 - x5] + CiTi[x4 - x6, x3, x1 - x3, x1 - x2, x5 - x6] + 
    CiTi[x4 - x6, x3, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x4 - x6, x3, x1 - x3, x2 - x3, x5 - x6] - 
    CiTi[x4 - x6, x3, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x4 - x6, x3, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x4 - x6, x3, x1 - x3, x5 - x6, x1 - x2] - 
    CiTi[x4 - x6, x3, x1 - x3, x5 - x6, x2 - x3] - 
    CiTi[x4 - x6, x3, x2 - x3, x1, x4 - x5] + CiTi[x4 - x6, x3, x2 - x3, x1, 
     x5 - x6] + CiTi[x4 - x6, x3, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x4 - x6, x3, x2 - x3, x1 - x2, x5 - x6] - 
    CiTi[x4 - x6, x3, x2 - x3, x4 - x5, x1] + CiTi[x4 - x6, x3, x2 - x3, 
     x4 - x5, x1 - x2] + CiTi[x4 - x6, x3, x2 - x3, x5 - x6, x1] - 
    CiTi[x4 - x6, x3, x2 - x3, x5 - x6, x1 - x2] + 
    CiTi[x4 - x6, x3, x4 - x5, x1, x1 - x2] - CiTi[x4 - x6, x3, x4 - x5, x1, 
     x2 - x3] + CiTi[x4 - x6, x3, x4 - x5, x2, x1] - 
    CiTi[x4 - x6, x3, x4 - x5, x2, x1 - x2] - CiTi[x4 - x6, x3, x4 - x5, 
     x1 - x3, x1 - x2] + CiTi[x4 - x6, x3, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x4 - x6, x3, x4 - x5, x2 - x3, x1] + CiTi[x4 - x6, x3, x4 - x5, 
     x2 - x3, x1 - x2] - CiTi[x4 - x6, x3, x5 - x6, x1, x1 - x2] + 
    CiTi[x4 - x6, x3, x5 - x6, x1, x2 - x3] - CiTi[x4 - x6, x3, x5 - x6, x2, 
     x1] + CiTi[x4 - x6, x3, x5 - x6, x2, x1 - x2] + 
    CiTi[x4 - x6, x3, x5 - x6, x1 - x3, x1 - x2] - 
    CiTi[x4 - x6, x3, x5 - x6, x1 - x3, x2 - x3] + 
    CiTi[x4 - x6, x3, x5 - x6, x2 - x3, x1] - CiTi[x4 - x6, x3, x5 - x6, 
     x2 - x3, x1 - x2] - CiTi[x4 - x6, x1 - x4, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x4 - x6, x1 - x4, x1 - x2, x2 - x3, x5 - x6] + 
    CiTi[x4 - x6, x1 - x4, x1 - x2, x3 - x4, x4 - x5] - 
    CiTi[x4 - x6, x1 - x4, x1 - x2, x3 - x4, x5 - x6] - 
    CiTi[x4 - x6, x1 - x4, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x4 - x6, x1 - x4, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x4 - x6, x1 - x4, x1 - x2, x5 - x6, x2 - x3] - 
    CiTi[x4 - x6, x1 - x4, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x4 - x6, x1 - x4, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x4 - x6, x1 - x4, x1 - x3, x1 - x2, x5 - x6] + 
    CiTi[x4 - x6, x1 - x4, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x4 - x6, x1 - x4, x1 - x3, x2 - x3, x5 - x6] - 
    CiTi[x4 - x6, x1 - x4, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x4 - x6, x1 - x4, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x4 - x6, x1 - x4, x1 - x3, x5 - x6, x1 - x2] - 
    CiTi[x4 - x6, x1 - x4, x1 - x3, x5 - x6, x2 - x3] + 
    CiTi[x4 - x6, x1 - x4, x2 - x4, x2 - x3, x4 - x5] - 
    CiTi[x4 - x6, x1 - x4, x2 - x4, x2 - x3, x5 - x6] - 
    CiTi[x4 - x6, x1 - x4, x2 - x4, x3 - x4, x4 - x5] + 
    CiTi[x4 - x6, x1 - x4, x2 - x4, x3 - x4, x5 - x6] + 
    CiTi[x4 - x6, x1 - x4, x2 - x4, x4 - x5, x2 - x3] - 
    CiTi[x4 - x6, x1 - x4, x2 - x4, x4 - x5, x3 - x4] - 
    CiTi[x4 - x6, x1 - x4, x2 - x4, x5 - x6, x2 - x3] + 
    CiTi[x4 - x6, x1 - x4, x2 - x4, x5 - x6, x3 - x4] + 
    CiTi[x4 - x6, x1 - x4, x3 - x4, x1 - x2, x4 - x5] - 
    CiTi[x4 - x6, x1 - x4, x3 - x4, x1 - x2, x5 - x6] - 
    CiTi[x4 - x6, x1 - x4, x3 - x4, x2 - x3, x4 - x5] + 
    CiTi[x4 - x6, x1 - x4, x3 - x4, x2 - x3, x5 - x6] + 
    CiTi[x4 - x6, x1 - x4, x3 - x4, x4 - x5, x1 - x2] - 
    CiTi[x4 - x6, x1 - x4, x3 - x4, x4 - x5, x2 - x3] - 
    CiTi[x4 - x6, x1 - x4, x3 - x4, x5 - x6, x1 - x2] + 
    CiTi[x4 - x6, x1 - x4, x3 - x4, x5 - x6, x2 - x3] - 
    CiTi[x4 - x6, x1 - x4, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x4 - x6, x1 - x4, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x4 - x6, x1 - x4, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x4 - x6, x1 - x4, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x4 - x6, x1 - x4, x4 - x5, x2 - x4, x2 - x3] - 
    CiTi[x4 - x6, x1 - x4, x4 - x5, x2 - x4, x3 - x4] + 
    CiTi[x4 - x6, x1 - x4, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x4 - x6, x1 - x4, x4 - x5, x3 - x4, x2 - x3] + 
    CiTi[x4 - x6, x1 - x4, x5 - x6, x1 - x2, x2 - x3] - 
    CiTi[x4 - x6, x1 - x4, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x4 - x6, x1 - x4, x5 - x6, x1 - x3, x1 - x2] - 
    CiTi[x4 - x6, x1 - x4, x5 - x6, x1 - x3, x2 - x3] - 
    CiTi[x4 - x6, x1 - x4, x5 - x6, x2 - x4, x2 - x3] + 
    CiTi[x4 - x6, x1 - x4, x5 - x6, x2 - x4, x3 - x4] - 
    CiTi[x4 - x6, x1 - x4, x5 - x6, x3 - x4, x1 - x2] + 
    CiTi[x4 - x6, x1 - x4, x5 - x6, x3 - x4, x2 - x3] - 
    CiTi[x4 - x6, x2 - x4, x1, x2 - x3, x4 - x5] + 
    CiTi[x4 - x6, x2 - x4, x1, x2 - x3, x5 - x6] + 
    CiTi[x4 - x6, x2 - x4, x1, x3 - x4, x4 - x5] - 
    CiTi[x4 - x6, x2 - x4, x1, x3 - x4, x5 - x6] - 
    CiTi[x4 - x6, x2 - x4, x1, x4 - x5, x2 - x3] + 
    CiTi[x4 - x6, x2 - x4, x1, x4 - x5, x3 - x4] + 
    CiTi[x4 - x6, x2 - x4, x1, x5 - x6, x2 - x3] - 
    CiTi[x4 - x6, x2 - x4, x1, x5 - x6, x3 - x4] + 
    CiTi[x4 - x6, x2 - x4, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x4 - x6, x2 - x4, x1 - x2, x2 - x3, x5 - x6] - 
    CiTi[x4 - x6, x2 - x4, x1 - x2, x3 - x4, x4 - x5] + 
    CiTi[x4 - x6, x2 - x4, x1 - x2, x3 - x4, x5 - x6] + 
    CiTi[x4 - x6, x2 - x4, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x4 - x6, x2 - x4, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x4 - x6, x2 - x4, x1 - x2, x5 - x6, x2 - x3] + 
    CiTi[x4 - x6, x2 - x4, x1 - x2, x5 - x6, x3 - x4] - 
    CiTi[x4 - x6, x2 - x4, x2 - x3, x1, x4 - x5] + 
    CiTi[x4 - x6, x2 - x4, x2 - x3, x1, x5 - x6] + 
    CiTi[x4 - x6, x2 - x4, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x4 - x6, x2 - x4, x2 - x3, x1 - x2, x5 - x6] - 
    CiTi[x4 - x6, x2 - x4, x2 - x3, x4 - x5, x1] + 
    CiTi[x4 - x6, x2 - x4, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x4 - x6, x2 - x4, x2 - x3, x5 - x6, x1] - 
    CiTi[x4 - x6, x2 - x4, x2 - x3, x5 - x6, x1 - x2] + 
    CiTi[x4 - x6, x2 - x4, x3 - x4, x1, x4 - x5] - 
    CiTi[x4 - x6, x2 - x4, x3 - x4, x1, x5 - x6] - 
    CiTi[x4 - x6, x2 - x4, x3 - x4, x1 - x2, x4 - x5] + 
    CiTi[x4 - x6, x2 - x4, x3 - x4, x1 - x2, x5 - x6] + 
    CiTi[x4 - x6, x2 - x4, x3 - x4, x4 - x5, x1] - 
    CiTi[x4 - x6, x2 - x4, x3 - x4, x4 - x5, x1 - x2] - 
    CiTi[x4 - x6, x2 - x4, x3 - x4, x5 - x6, x1] + 
    CiTi[x4 - x6, x2 - x4, x3 - x4, x5 - x6, x1 - x2] - 
    CiTi[x4 - x6, x2 - x4, x4 - x5, x1, x2 - x3] + 
    CiTi[x4 - x6, x2 - x4, x4 - x5, x1, x3 - x4] + 
    CiTi[x4 - x6, x2 - x4, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x4 - x6, x2 - x4, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x4 - x6, x2 - x4, x4 - x5, x2 - x3, x1] + 
    CiTi[x4 - x6, x2 - x4, x4 - x5, x2 - x3, x1 - x2] + 
    CiTi[x4 - x6, x2 - x4, x4 - x5, x3 - x4, x1] - 
    CiTi[x4 - x6, x2 - x4, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x4 - x6, x2 - x4, x5 - x6, x1, x2 - x3] - 
    CiTi[x4 - x6, x2 - x4, x5 - x6, x1, x3 - x4] - 
    CiTi[x4 - x6, x2 - x4, x5 - x6, x1 - x2, x2 - x3] + 
    CiTi[x4 - x6, x2 - x4, x5 - x6, x1 - x2, x3 - x4] + 
    CiTi[x4 - x6, x2 - x4, x5 - x6, x2 - x3, x1] - 
    CiTi[x4 - x6, x2 - x4, x5 - x6, x2 - x3, x1 - x2] - 
    CiTi[x4 - x6, x2 - x4, x5 - x6, x3 - x4, x1] + 
    CiTi[x4 - x6, x2 - x4, x5 - x6, x3 - x4, x1 - x2] - 
    CiTi[x4 - x6, x3 - x4, x1, x1 - x2, x4 - x5] + 
    CiTi[x4 - x6, x3 - x4, x1, x1 - x2, x5 - x6] + 
    CiTi[x4 - x6, x3 - x4, x1, x2 - x3, x4 - x5] - 
    CiTi[x4 - x6, x3 - x4, x1, x2 - x3, x5 - x6] - 
    CiTi[x4 - x6, x3 - x4, x1, x4 - x5, x1 - x2] + 
    CiTi[x4 - x6, x3 - x4, x1, x4 - x5, x2 - x3] + 
    CiTi[x4 - x6, x3 - x4, x1, x5 - x6, x1 - x2] - 
    CiTi[x4 - x6, x3 - x4, x1, x5 - x6, x2 - x3] - 
    CiTi[x4 - x6, x3 - x4, x2, x1, x4 - x5] + CiTi[x4 - x6, x3 - x4, x2, x1, 
     x5 - x6] + CiTi[x4 - x6, x3 - x4, x2, x1 - x2, x4 - x5] - 
    CiTi[x4 - x6, x3 - x4, x2, x1 - x2, x5 - x6] - 
    CiTi[x4 - x6, x3 - x4, x2, x4 - x5, x1] + CiTi[x4 - x6, x3 - x4, x2, 
     x4 - x5, x1 - x2] + CiTi[x4 - x6, x3 - x4, x2, x5 - x6, x1] - 
    CiTi[x4 - x6, x3 - x4, x2, x5 - x6, x1 - x2] + 
    CiTi[x4 - x6, x3 - x4, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x4 - x6, x3 - x4, x1 - x3, x1 - x2, x5 - x6] - 
    CiTi[x4 - x6, x3 - x4, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x4 - x6, x3 - x4, x1 - x3, x2 - x3, x5 - x6] + 
    CiTi[x4 - x6, x3 - x4, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x4 - x6, x3 - x4, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x4 - x6, x3 - x4, x1 - x3, x5 - x6, x1 - x2] + 
    CiTi[x4 - x6, x3 - x4, x1 - x3, x5 - x6, x2 - x3] + 
    CiTi[x4 - x6, x3 - x4, x2 - x3, x1, x4 - x5] - 
    CiTi[x4 - x6, x3 - x4, x2 - x3, x1, x5 - x6] - 
    CiTi[x4 - x6, x3 - x4, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x4 - x6, x3 - x4, x2 - x3, x1 - x2, x5 - x6] + 
    CiTi[x4 - x6, x3 - x4, x2 - x3, x4 - x5, x1] - 
    CiTi[x4 - x6, x3 - x4, x2 - x3, x4 - x5, x1 - x2] - 
    CiTi[x4 - x6, x3 - x4, x2 - x3, x5 - x6, x1] + 
    CiTi[x4 - x6, x3 - x4, x2 - x3, x5 - x6, x1 - x2] - 
    CiTi[x4 - x6, x3 - x4, x4 - x5, x1, x1 - x2] + 
    CiTi[x4 - x6, x3 - x4, x4 - x5, x1, x2 - x3] - 
    CiTi[x4 - x6, x3 - x4, x4 - x5, x2, x1] + CiTi[x4 - x6, x3 - x4, x4 - x5, 
     x2, x1 - x2] + CiTi[x4 - x6, x3 - x4, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x4 - x6, x3 - x4, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x4 - x6, x3 - x4, x4 - x5, x2 - x3, x1] - 
    CiTi[x4 - x6, x3 - x4, x4 - x5, x2 - x3, x1 - x2] + 
    CiTi[x4 - x6, x3 - x4, x5 - x6, x1, x1 - x2] - 
    CiTi[x4 - x6, x3 - x4, x5 - x6, x1, x2 - x3] + 
    CiTi[x4 - x6, x3 - x4, x5 - x6, x2, x1] - CiTi[x4 - x6, x3 - x4, x5 - x6, 
     x2, x1 - x2] - CiTi[x4 - x6, x3 - x4, x5 - x6, x1 - x3, x1 - x2] + 
    CiTi[x4 - x6, x3 - x4, x5 - x6, x1 - x3, x2 - x3] - 
    CiTi[x4 - x6, x3 - x4, x5 - x6, x2 - x3, x1] + 
    CiTi[x4 - x6, x3 - x4, x5 - x6, x2 - x3, x1 - x2] + 
    CiTi[x4 - x6, x4 - x5, x1, x1 - x2, x2 - x3] - 
    CiTi[x4 - x6, x4 - x5, x1, x1 - x2, x3 - x4] + 
    CiTi[x4 - x6, x4 - x5, x1, x1 - x3, x1 - x2] - 
    CiTi[x4 - x6, x4 - x5, x1, x1 - x3, x2 - x3] - 
    CiTi[x4 - x6, x4 - x5, x1, x2 - x4, x2 - x3] + 
    CiTi[x4 - x6, x4 - x5, x1, x2 - x4, x3 - x4] - 
    CiTi[x4 - x6, x4 - x5, x1, x3 - x4, x1 - x2] + 
    CiTi[x4 - x6, x4 - x5, x1, x3 - x4, x2 - x3] + 
    CiTi[x4 - x6, x4 - x5, x2, x1, x2 - x3] - CiTi[x4 - x6, x4 - x5, x2, x1, 
     x3 - x4] - CiTi[x4 - x6, x4 - x5, x2, x1 - x2, x2 - x3] + 
    CiTi[x4 - x6, x4 - x5, x2, x1 - x2, x3 - x4] + 
    CiTi[x4 - x6, x4 - x5, x2, x2 - x3, x1] - CiTi[x4 - x6, x4 - x5, x2, 
     x2 - x3, x1 - x2] - CiTi[x4 - x6, x4 - x5, x2, x3 - x4, x1] + 
    CiTi[x4 - x6, x4 - x5, x2, x3 - x4, x1 - x2] + 
    CiTi[x4 - x6, x4 - x5, x3, x1, x1 - x2] - CiTi[x4 - x6, x4 - x5, x3, x1, 
     x2 - x3] + CiTi[x4 - x6, x4 - x5, x3, x2, x1] - 
    CiTi[x4 - x6, x4 - x5, x3, x2, x1 - x2] - CiTi[x4 - x6, x4 - x5, x3, 
     x1 - x3, x1 - x2] + CiTi[x4 - x6, x4 - x5, x3, x1 - x3, x2 - x3] - 
    CiTi[x4 - x6, x4 - x5, x3, x2 - x3, x1] + CiTi[x4 - x6, x4 - x5, x3, 
     x2 - x3, x1 - x2] - CiTi[x4 - x6, x4 - x5, x1 - x4, x1 - x2, x2 - x3] + 
    CiTi[x4 - x6, x4 - x5, x1 - x4, x1 - x2, x3 - x4] - 
    CiTi[x4 - x6, x4 - x5, x1 - x4, x1 - x3, x1 - x2] + 
    CiTi[x4 - x6, x4 - x5, x1 - x4, x1 - x3, x2 - x3] + 
    CiTi[x4 - x6, x4 - x5, x1 - x4, x2 - x4, x2 - x3] - 
    CiTi[x4 - x6, x4 - x5, x1 - x4, x2 - x4, x3 - x4] + 
    CiTi[x4 - x6, x4 - x5, x1 - x4, x3 - x4, x1 - x2] - 
    CiTi[x4 - x6, x4 - x5, x1 - x4, x3 - x4, x2 - x3] - 
    CiTi[x4 - x6, x4 - x5, x2 - x4, x1, x2 - x3] + 
    CiTi[x4 - x6, x4 - x5, x2 - x4, x1, x3 - x4] + 
    CiTi[x4 - x6, x4 - x5, x2 - x4, x1 - x2, x2 - x3] - 
    CiTi[x4 - x6, x4 - x5, x2 - x4, x1 - x2, x3 - x4] - 
    CiTi[x4 - x6, x4 - x5, x2 - x4, x2 - x3, x1] + 
    CiTi[x4 - x6, x4 - x5, x2 - x4, x2 - x3, x1 - x2] + 
    CiTi[x4 - x6, x4 - x5, x2 - x4, x3 - x4, x1] - 
    CiTi[x4 - x6, x4 - x5, x2 - x4, x3 - x4, x1 - x2] - 
    CiTi[x4 - x6, x4 - x5, x3 - x4, x1, x1 - x2] + 
    CiTi[x4 - x6, x4 - x5, x3 - x4, x1, x2 - x3] - 
    CiTi[x4 - x6, x4 - x5, x3 - x4, x2, x1] + CiTi[x4 - x6, x4 - x5, x3 - x4, 
     x2, x1 - x2] + CiTi[x4 - x6, x4 - x5, x3 - x4, x1 - x3, x1 - x2] - 
    CiTi[x4 - x6, x4 - x5, x3 - x4, x1 - x3, x2 - x3] + 
    CiTi[x4 - x6, x4 - x5, x3 - x4, x2 - x3, x1] - 
    CiTi[x4 - x6, x4 - x5, x3 - x4, x2 - x3, x1 - x2] - 
    CiTi[x4 - x6, x5 - x6, x1, x1 - x2, x2 - x3] + 
    CiTi[x4 - x6, x5 - x6, x1, x1 - x2, x3 - x4] - 
    CiTi[x4 - x6, x5 - x6, x1, x1 - x3, x1 - x2] + 
    CiTi[x4 - x6, x5 - x6, x1, x1 - x3, x2 - x3] + 
    CiTi[x4 - x6, x5 - x6, x1, x2 - x4, x2 - x3] - 
    CiTi[x4 - x6, x5 - x6, x1, x2 - x4, x3 - x4] + 
    CiTi[x4 - x6, x5 - x6, x1, x3 - x4, x1 - x2] - 
    CiTi[x4 - x6, x5 - x6, x1, x3 - x4, x2 - x3] - 
    CiTi[x4 - x6, x5 - x6, x2, x1, x2 - x3] + CiTi[x4 - x6, x5 - x6, x2, x1, 
     x3 - x4] + CiTi[x4 - x6, x5 - x6, x2, x1 - x2, x2 - x3] - 
    CiTi[x4 - x6, x5 - x6, x2, x1 - x2, x3 - x4] - 
    CiTi[x4 - x6, x5 - x6, x2, x2 - x3, x1] + CiTi[x4 - x6, x5 - x6, x2, 
     x2 - x3, x1 - x2] + CiTi[x4 - x6, x5 - x6, x2, x3 - x4, x1] - 
    CiTi[x4 - x6, x5 - x6, x2, x3 - x4, x1 - x2] - 
    CiTi[x4 - x6, x5 - x6, x3, x1, x1 - x2] + CiTi[x4 - x6, x5 - x6, x3, x1, 
     x2 - x3] - CiTi[x4 - x6, x5 - x6, x3, x2, x1] + 
    CiTi[x4 - x6, x5 - x6, x3, x2, x1 - x2] + CiTi[x4 - x6, x5 - x6, x3, 
     x1 - x3, x1 - x2] - CiTi[x4 - x6, x5 - x6, x3, x1 - x3, x2 - x3] + 
    CiTi[x4 - x6, x5 - x6, x3, x2 - x3, x1] - CiTi[x4 - x6, x5 - x6, x3, 
     x2 - x3, x1 - x2] + CiTi[x4 - x6, x5 - x6, x1 - x4, x1 - x2, x2 - x3] - 
    CiTi[x4 - x6, x5 - x6, x1 - x4, x1 - x2, x3 - x4] + 
    CiTi[x4 - x6, x5 - x6, x1 - x4, x1 - x3, x1 - x2] - 
    CiTi[x4 - x6, x5 - x6, x1 - x4, x1 - x3, x2 - x3] - 
    CiTi[x4 - x6, x5 - x6, x1 - x4, x2 - x4, x2 - x3] + 
    CiTi[x4 - x6, x5 - x6, x1 - x4, x2 - x4, x3 - x4] - 
    CiTi[x4 - x6, x5 - x6, x1 - x4, x3 - x4, x1 - x2] + 
    CiTi[x4 - x6, x5 - x6, x1 - x4, x3 - x4, x2 - x3] + 
    CiTi[x4 - x6, x5 - x6, x2 - x4, x1, x2 - x3] - 
    CiTi[x4 - x6, x5 - x6, x2 - x4, x1, x3 - x4] - 
    CiTi[x4 - x6, x5 - x6, x2 - x4, x1 - x2, x2 - x3] + 
    CiTi[x4 - x6, x5 - x6, x2 - x4, x1 - x2, x3 - x4] + 
    CiTi[x4 - x6, x5 - x6, x2 - x4, x2 - x3, x1] - 
    CiTi[x4 - x6, x5 - x6, x2 - x4, x2 - x3, x1 - x2] - 
    CiTi[x4 - x6, x5 - x6, x2 - x4, x3 - x4, x1] + 
    CiTi[x4 - x6, x5 - x6, x2 - x4, x3 - x4, x1 - x2] + 
    CiTi[x4 - x6, x5 - x6, x3 - x4, x1, x1 - x2] - 
    CiTi[x4 - x6, x5 - x6, x3 - x4, x1, x2 - x3] + 
    CiTi[x4 - x6, x5 - x6, x3 - x4, x2, x1] - CiTi[x4 - x6, x5 - x6, x3 - x4, 
     x2, x1 - x2] - CiTi[x4 - x6, x5 - x6, x3 - x4, x1 - x3, x1 - x2] + 
    CiTi[x4 - x6, x5 - x6, x3 - x4, x1 - x3, x2 - x3] - 
    CiTi[x4 - x6, x5 - x6, x3 - x4, x2 - x3, x1] + 
    CiTi[x4 - x6, x5 - x6, x3 - x4, x2 - x3, x1 - x2] + 
    CiTi[x5 - x6, x1, x1 - x2, x2 - x3, x3 - x4] - 
    CiTi[x5 - x6, x1, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x5 - x6, x1, x1 - x2, x2 - x4, x2 - x3] - 
    CiTi[x5 - x6, x1, x1 - x2, x2 - x4, x3 - x4] - 
    CiTi[x5 - x6, x1, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x5 - x6, x1, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x5 - x6, x1, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x5 - x6, x1, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x5 - x6, x1, x1 - x3, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x1, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x5 - x6, x1, x1 - x3, x2 - x3, x3 - x4] + 
    CiTi[x5 - x6, x1, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x5 - x6, x1, x1 - x3, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x1, x1 - x3, x3 - x4, x2 - x3] - 
    CiTi[x5 - x6, x1, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x5 - x6, x1, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x5 - x6, x1, x1 - x4, x1 - x2, x2 - x3] - 
    CiTi[x5 - x6, x1, x1 - x4, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x1, x1 - x4, x1 - x3, x1 - x2] - 
    CiTi[x5 - x6, x1, x1 - x4, x1 - x3, x2 - x3] - 
    CiTi[x5 - x6, x1, x1 - x4, x2 - x4, x2 - x3] + 
    CiTi[x5 - x6, x1, x1 - x4, x2 - x4, x3 - x4] - 
    CiTi[x5 - x6, x1, x1 - x4, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x1, x1 - x4, x3 - x4, x2 - x3] - 
    CiTi[x5 - x6, x1, x2 - x5, x2 - x3, x3 - x4] + 
    CiTi[x5 - x6, x1, x2 - x5, x2 - x3, x4 - x5] - 
    CiTi[x5 - x6, x1, x2 - x5, x2 - x4, x2 - x3] + 
    CiTi[x5 - x6, x1, x2 - x5, x2 - x4, x3 - x4] + 
    CiTi[x5 - x6, x1, x2 - x5, x3 - x5, x3 - x4] - 
    CiTi[x5 - x6, x1, x2 - x5, x3 - x5, x4 - x5] + 
    CiTi[x5 - x6, x1, x2 - x5, x4 - x5, x2 - x3] - 
    CiTi[x5 - x6, x1, x2 - x5, x4 - x5, x3 - x4] - 
    CiTi[x5 - x6, x1, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x1, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x5 - x6, x1, x3 - x5, x2 - x3, x3 - x4] - 
    CiTi[x5 - x6, x1, x3 - x5, x2 - x3, x4 - x5] - 
    CiTi[x5 - x6, x1, x3 - x5, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x1, x3 - x5, x3 - x4, x2 - x3] + 
    CiTi[x5 - x6, x1, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x5 - x6, x1, x3 - x5, x4 - x5, x2 - x3] - 
    CiTi[x5 - x6, x1, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x5 - x6, x1, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x1, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x5 - x6, x1, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x5 - x6, x1, x4 - x5, x2 - x4, x2 - x3] - 
    CiTi[x5 - x6, x1, x4 - x5, x2 - x4, x3 - x4] + 
    CiTi[x5 - x6, x1, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x1, x4 - x5, x3 - x4, x2 - x3] + 
    CiTi[x5 - x6, x2, x1, x2 - x3, x3 - x4] - CiTi[x5 - x6, x2, x1, x2 - x3, 
     x4 - x5] + CiTi[x5 - x6, x2, x1, x2 - x4, x2 - x3] - 
    CiTi[x5 - x6, x2, x1, x2 - x4, x3 - x4] - CiTi[x5 - x6, x2, x1, x3 - x5, 
     x3 - x4] + CiTi[x5 - x6, x2, x1, x3 - x5, x4 - x5] - 
    CiTi[x5 - x6, x2, x1, x4 - x5, x2 - x3] + CiTi[x5 - x6, x2, x1, x4 - x5, 
     x3 - x4] - CiTi[x5 - x6, x2, x1 - x2, x2 - x3, x3 - x4] + 
    CiTi[x5 - x6, x2, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x5 - x6, x2, x1 - x2, x2 - x4, x2 - x3] + 
    CiTi[x5 - x6, x2, x1 - x2, x2 - x4, x3 - x4] + 
    CiTi[x5 - x6, x2, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x5 - x6, x2, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x5 - x6, x2, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x5 - x6, x2, x1 - x2, x4 - x5, x3 - x4] + 
    CiTi[x5 - x6, x2, x2 - x3, x1, x3 - x4] - CiTi[x5 - x6, x2, x2 - x3, x1, 
     x4 - x5] - CiTi[x5 - x6, x2, x2 - x3, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x2, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x5 - x6, x2, x2 - x3, x3 - x4, x1] - CiTi[x5 - x6, x2, x2 - x3, 
     x3 - x4, x1 - x2] - CiTi[x5 - x6, x2, x2 - x3, x4 - x5, x1] + 
    CiTi[x5 - x6, x2, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x5 - x6, x2, x2 - x4, x1, x2 - x3] - CiTi[x5 - x6, x2, x2 - x4, x1, 
     x3 - x4] - CiTi[x5 - x6, x2, x2 - x4, x1 - x2, x2 - x3] + 
    CiTi[x5 - x6, x2, x2 - x4, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x2, x2 - x4, x2 - x3, x1] - CiTi[x5 - x6, x2, x2 - x4, 
     x2 - x3, x1 - x2] - CiTi[x5 - x6, x2, x2 - x4, x3 - x4, x1] + 
    CiTi[x5 - x6, x2, x2 - x4, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x2, x3 - x5, x1, x3 - x4] + CiTi[x5 - x6, x2, x3 - x5, x1, 
     x4 - x5] + CiTi[x5 - x6, x2, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x2, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x5 - x6, x2, x3 - x5, x3 - x4, x1] + CiTi[x5 - x6, x2, x3 - x5, 
     x3 - x4, x1 - x2] + CiTi[x5 - x6, x2, x3 - x5, x4 - x5, x1] - 
    CiTi[x5 - x6, x2, x3 - x5, x4 - x5, x1 - x2] - 
    CiTi[x5 - x6, x2, x4 - x5, x1, x2 - x3] + CiTi[x5 - x6, x2, x4 - x5, x1, 
     x3 - x4] + CiTi[x5 - x6, x2, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x5 - x6, x2, x4 - x5, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x2, x4 - x5, x2 - x3, x1] + CiTi[x5 - x6, x2, x4 - x5, 
     x2 - x3, x1 - x2] + CiTi[x5 - x6, x2, x4 - x5, x3 - x4, x1] - 
    CiTi[x5 - x6, x2, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x3, x1, x1 - x2, x3 - x4] - CiTi[x5 - x6, x3, x1, x1 - x2, 
     x4 - x5] - CiTi[x5 - x6, x3, x1, x2 - x3, x3 - x4] + 
    CiTi[x5 - x6, x3, x1, x2 - x3, x4 - x5] + CiTi[x5 - x6, x3, x1, x3 - x4, 
     x1 - x2] - CiTi[x5 - x6, x3, x1, x3 - x4, x2 - x3] - 
    CiTi[x5 - x6, x3, x1, x4 - x5, x1 - x2] + CiTi[x5 - x6, x3, x1, x4 - x5, 
     x2 - x3] + CiTi[x5 - x6, x3, x2, x1, x3 - x4] - 
    CiTi[x5 - x6, x3, x2, x1, x4 - x5] - CiTi[x5 - x6, x3, x2, x1 - x2, 
     x3 - x4] + CiTi[x5 - x6, x3, x2, x1 - x2, x4 - x5] + 
    CiTi[x5 - x6, x3, x2, x3 - x4, x1] - CiTi[x5 - x6, x3, x2, x3 - x4, 
     x1 - x2] - CiTi[x5 - x6, x3, x2, x4 - x5, x1] + 
    CiTi[x5 - x6, x3, x2, x4 - x5, x1 - x2] - CiTi[x5 - x6, x3, x1 - x3, 
     x1 - x2, x3 - x4] + CiTi[x5 - x6, x3, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x5 - x6, x3, x1 - x3, x2 - x3, x3 - x4] - 
    CiTi[x5 - x6, x3, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x5 - x6, x3, x1 - x3, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x3, x1 - x3, x3 - x4, x2 - x3] + 
    CiTi[x5 - x6, x3, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x5 - x6, x3, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x5 - x6, x3, x2 - x3, x1, x3 - x4] + CiTi[x5 - x6, x3, x2 - x3, x1, 
     x4 - x5] + CiTi[x5 - x6, x3, x2 - x3, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x3, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x5 - x6, x3, x2 - x3, x3 - x4, x1] + CiTi[x5 - x6, x3, x2 - x3, 
     x3 - x4, x1 - x2] + CiTi[x5 - x6, x3, x2 - x3, x4 - x5, x1] - 
    CiTi[x5 - x6, x3, x2 - x3, x4 - x5, x1 - x2] + 
    CiTi[x5 - x6, x3, x3 - x4, x1, x1 - x2] - CiTi[x5 - x6, x3, x3 - x4, x1, 
     x2 - x3] + CiTi[x5 - x6, x3, x3 - x4, x2, x1] - 
    CiTi[x5 - x6, x3, x3 - x4, x2, x1 - x2] - CiTi[x5 - x6, x3, x3 - x4, 
     x1 - x3, x1 - x2] + CiTi[x5 - x6, x3, x3 - x4, x1 - x3, x2 - x3] - 
    CiTi[x5 - x6, x3, x3 - x4, x2 - x3, x1] + CiTi[x5 - x6, x3, x3 - x4, 
     x2 - x3, x1 - x2] - CiTi[x5 - x6, x3, x4 - x5, x1, x1 - x2] + 
    CiTi[x5 - x6, x3, x4 - x5, x1, x2 - x3] - CiTi[x5 - x6, x3, x4 - x5, x2, 
     x1] + CiTi[x5 - x6, x3, x4 - x5, x2, x1 - x2] + 
    CiTi[x5 - x6, x3, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x5 - x6, x3, x4 - x5, x1 - x3, x2 - x3] + 
    CiTi[x5 - x6, x3, x4 - x5, x2 - x3, x1] - CiTi[x5 - x6, x3, x4 - x5, 
     x2 - x3, x1 - x2] + CiTi[x5 - x6, x4, x1, x1 - x2, x2 - x3] - 
    CiTi[x5 - x6, x4, x1, x1 - x2, x3 - x4] + CiTi[x5 - x6, x4, x1, x1 - x3, 
     x1 - x2] - CiTi[x5 - x6, x4, x1, x1 - x3, x2 - x3] - 
    CiTi[x5 - x6, x4, x1, x2 - x4, x2 - x3] + CiTi[x5 - x6, x4, x1, x2 - x4, 
     x3 - x4] - CiTi[x5 - x6, x4, x1, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x4, x1, x3 - x4, x2 - x3] + CiTi[x5 - x6, x4, x2, x1, 
     x2 - x3] - CiTi[x5 - x6, x4, x2, x1, x3 - x4] - 
    CiTi[x5 - x6, x4, x2, x1 - x2, x2 - x3] + CiTi[x5 - x6, x4, x2, x1 - x2, 
     x3 - x4] + CiTi[x5 - x6, x4, x2, x2 - x3, x1] - 
    CiTi[x5 - x6, x4, x2, x2 - x3, x1 - x2] - CiTi[x5 - x6, x4, x2, x3 - x4, 
     x1] + CiTi[x5 - x6, x4, x2, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x4, x3, x1, x1 - x2] - CiTi[x5 - x6, x4, x3, x1, x2 - x3] + 
    CiTi[x5 - x6, x4, x3, x2, x1] - CiTi[x5 - x6, x4, x3, x2, x1 - x2] - 
    CiTi[x5 - x6, x4, x3, x1 - x3, x1 - x2] + CiTi[x5 - x6, x4, x3, x1 - x3, 
     x2 - x3] - CiTi[x5 - x6, x4, x3, x2 - x3, x1] + 
    CiTi[x5 - x6, x4, x3, x2 - x3, x1 - x2] - CiTi[x5 - x6, x4, x1 - x4, 
     x1 - x2, x2 - x3] + CiTi[x5 - x6, x4, x1 - x4, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x4, x1 - x4, x1 - x3, x1 - x2] + 
    CiTi[x5 - x6, x4, x1 - x4, x1 - x3, x2 - x3] + 
    CiTi[x5 - x6, x4, x1 - x4, x2 - x4, x2 - x3] - 
    CiTi[x5 - x6, x4, x1 - x4, x2 - x4, x3 - x4] + 
    CiTi[x5 - x6, x4, x1 - x4, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x4, x1 - x4, x3 - x4, x2 - x3] - 
    CiTi[x5 - x6, x4, x2 - x4, x1, x2 - x3] + CiTi[x5 - x6, x4, x2 - x4, x1, 
     x3 - x4] + CiTi[x5 - x6, x4, x2 - x4, x1 - x2, x2 - x3] - 
    CiTi[x5 - x6, x4, x2 - x4, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x4, x2 - x4, x2 - x3, x1] + CiTi[x5 - x6, x4, x2 - x4, 
     x2 - x3, x1 - x2] + CiTi[x5 - x6, x4, x2 - x4, x3 - x4, x1] - 
    CiTi[x5 - x6, x4, x2 - x4, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x4, x3 - x4, x1, x1 - x2] + CiTi[x5 - x6, x4, x3 - x4, x1, 
     x2 - x3] - CiTi[x5 - x6, x4, x3 - x4, x2, x1] + 
    CiTi[x5 - x6, x4, x3 - x4, x2, x1 - x2] + CiTi[x5 - x6, x4, x3 - x4, 
     x1 - x3, x1 - x2] - CiTi[x5 - x6, x4, x3 - x4, x1 - x3, x2 - x3] + 
    CiTi[x5 - x6, x4, x3 - x4, x2 - x3, x1] - CiTi[x5 - x6, x4, x3 - x4, 
     x2 - x3, x1 - x2] - CiTi[x5 - x6, x1 - x5, x1 - x2, x2 - x3, x3 - x4] + 
    CiTi[x5 - x6, x1 - x5, x1 - x2, x2 - x3, x4 - x5] - 
    CiTi[x5 - x6, x1 - x5, x1 - x2, x2 - x4, x2 - x3] + 
    CiTi[x5 - x6, x1 - x5, x1 - x2, x2 - x4, x3 - x4] + 
    CiTi[x5 - x6, x1 - x5, x1 - x2, x3 - x5, x3 - x4] - 
    CiTi[x5 - x6, x1 - x5, x1 - x2, x3 - x5, x4 - x5] + 
    CiTi[x5 - x6, x1 - x5, x1 - x2, x4 - x5, x2 - x3] - 
    CiTi[x5 - x6, x1 - x5, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x5 - x6, x1 - x5, x1 - x3, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x1 - x5, x1 - x3, x1 - x2, x4 - x5] + 
    CiTi[x5 - x6, x1 - x5, x1 - x3, x2 - x3, x3 - x4] - 
    CiTi[x5 - x6, x1 - x5, x1 - x3, x2 - x3, x4 - x5] - 
    CiTi[x5 - x6, x1 - x5, x1 - x3, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x1 - x5, x1 - x3, x3 - x4, x2 - x3] + 
    CiTi[x5 - x6, x1 - x5, x1 - x3, x4 - x5, x1 - x2] - 
    CiTi[x5 - x6, x1 - x5, x1 - x3, x4 - x5, x2 - x3] - 
    CiTi[x5 - x6, x1 - x5, x1 - x4, x1 - x2, x2 - x3] + 
    CiTi[x5 - x6, x1 - x5, x1 - x4, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x1 - x5, x1 - x4, x1 - x3, x1 - x2] + 
    CiTi[x5 - x6, x1 - x5, x1 - x4, x1 - x3, x2 - x3] + 
    CiTi[x5 - x6, x1 - x5, x1 - x4, x2 - x4, x2 - x3] - 
    CiTi[x5 - x6, x1 - x5, x1 - x4, x2 - x4, x3 - x4] + 
    CiTi[x5 - x6, x1 - x5, x1 - x4, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x1 - x5, x1 - x4, x3 - x4, x2 - x3] + 
    CiTi[x5 - x6, x1 - x5, x2 - x5, x2 - x3, x3 - x4] - 
    CiTi[x5 - x6, x1 - x5, x2 - x5, x2 - x3, x4 - x5] + 
    CiTi[x5 - x6, x1 - x5, x2 - x5, x2 - x4, x2 - x3] - 
    CiTi[x5 - x6, x1 - x5, x2 - x5, x2 - x4, x3 - x4] - 
    CiTi[x5 - x6, x1 - x5, x2 - x5, x3 - x5, x3 - x4] + 
    CiTi[x5 - x6, x1 - x5, x2 - x5, x3 - x5, x4 - x5] - 
    CiTi[x5 - x6, x1 - x5, x2 - x5, x4 - x5, x2 - x3] + 
    CiTi[x5 - x6, x1 - x5, x2 - x5, x4 - x5, x3 - x4] + 
    CiTi[x5 - x6, x1 - x5, x3 - x5, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x1 - x5, x3 - x5, x1 - x2, x4 - x5] - 
    CiTi[x5 - x6, x1 - x5, x3 - x5, x2 - x3, x3 - x4] + 
    CiTi[x5 - x6, x1 - x5, x3 - x5, x2 - x3, x4 - x5] + 
    CiTi[x5 - x6, x1 - x5, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x1 - x5, x3 - x5, x3 - x4, x2 - x3] - 
    CiTi[x5 - x6, x1 - x5, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x5 - x6, x1 - x5, x3 - x5, x4 - x5, x2 - x3] + 
    CiTi[x5 - x6, x1 - x5, x4 - x5, x1 - x2, x2 - x3] - 
    CiTi[x5 - x6, x1 - x5, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x1 - x5, x4 - x5, x1 - x3, x1 - x2] - 
    CiTi[x5 - x6, x1 - x5, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x5 - x6, x1 - x5, x4 - x5, x2 - x4, x2 - x3] + 
    CiTi[x5 - x6, x1 - x5, x4 - x5, x2 - x4, x3 - x4] - 
    CiTi[x5 - x6, x1 - x5, x4 - x5, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x1 - x5, x4 - x5, x3 - x4, x2 - x3] - 
    CiTi[x5 - x6, x2 - x5, x1, x2 - x3, x3 - x4] + 
    CiTi[x5 - x6, x2 - x5, x1, x2 - x3, x4 - x5] - 
    CiTi[x5 - x6, x2 - x5, x1, x2 - x4, x2 - x3] + 
    CiTi[x5 - x6, x2 - x5, x1, x2 - x4, x3 - x4] + 
    CiTi[x5 - x6, x2 - x5, x1, x3 - x5, x3 - x4] - 
    CiTi[x5 - x6, x2 - x5, x1, x3 - x5, x4 - x5] + 
    CiTi[x5 - x6, x2 - x5, x1, x4 - x5, x2 - x3] - 
    CiTi[x5 - x6, x2 - x5, x1, x4 - x5, x3 - x4] + 
    CiTi[x5 - x6, x2 - x5, x1 - x2, x2 - x3, x3 - x4] - 
    CiTi[x5 - x6, x2 - x5, x1 - x2, x2 - x3, x4 - x5] + 
    CiTi[x5 - x6, x2 - x5, x1 - x2, x2 - x4, x2 - x3] - 
    CiTi[x5 - x6, x2 - x5, x1 - x2, x2 - x4, x3 - x4] - 
    CiTi[x5 - x6, x2 - x5, x1 - x2, x3 - x5, x3 - x4] + 
    CiTi[x5 - x6, x2 - x5, x1 - x2, x3 - x5, x4 - x5] - 
    CiTi[x5 - x6, x2 - x5, x1 - x2, x4 - x5, x2 - x3] + 
    CiTi[x5 - x6, x2 - x5, x1 - x2, x4 - x5, x3 - x4] - 
    CiTi[x5 - x6, x2 - x5, x2 - x3, x1, x3 - x4] + 
    CiTi[x5 - x6, x2 - x5, x2 - x3, x1, x4 - x5] + 
    CiTi[x5 - x6, x2 - x5, x2 - x3, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x2 - x5, x2 - x3, x1 - x2, x4 - x5] - 
    CiTi[x5 - x6, x2 - x5, x2 - x3, x3 - x4, x1] + 
    CiTi[x5 - x6, x2 - x5, x2 - x3, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x2 - x5, x2 - x3, x4 - x5, x1] - 
    CiTi[x5 - x6, x2 - x5, x2 - x3, x4 - x5, x1 - x2] - 
    CiTi[x5 - x6, x2 - x5, x2 - x4, x1, x2 - x3] + 
    CiTi[x5 - x6, x2 - x5, x2 - x4, x1, x3 - x4] + 
    CiTi[x5 - x6, x2 - x5, x2 - x4, x1 - x2, x2 - x3] - 
    CiTi[x5 - x6, x2 - x5, x2 - x4, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x2 - x5, x2 - x4, x2 - x3, x1] + 
    CiTi[x5 - x6, x2 - x5, x2 - x4, x2 - x3, x1 - x2] + 
    CiTi[x5 - x6, x2 - x5, x2 - x4, x3 - x4, x1] - 
    CiTi[x5 - x6, x2 - x5, x2 - x4, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x2 - x5, x3 - x5, x1, x3 - x4] - 
    CiTi[x5 - x6, x2 - x5, x3 - x5, x1, x4 - x5] - 
    CiTi[x5 - x6, x2 - x5, x3 - x5, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x2 - x5, x3 - x5, x1 - x2, x4 - x5] + 
    CiTi[x5 - x6, x2 - x5, x3 - x5, x3 - x4, x1] - 
    CiTi[x5 - x6, x2 - x5, x3 - x5, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x2 - x5, x3 - x5, x4 - x5, x1] + 
    CiTi[x5 - x6, x2 - x5, x3 - x5, x4 - x5, x1 - x2] + 
    CiTi[x5 - x6, x2 - x5, x4 - x5, x1, x2 - x3] - 
    CiTi[x5 - x6, x2 - x5, x4 - x5, x1, x3 - x4] - 
    CiTi[x5 - x6, x2 - x5, x4 - x5, x1 - x2, x2 - x3] + 
    CiTi[x5 - x6, x2 - x5, x4 - x5, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x2 - x5, x4 - x5, x2 - x3, x1] - 
    CiTi[x5 - x6, x2 - x5, x4 - x5, x2 - x3, x1 - x2] - 
    CiTi[x5 - x6, x2 - x5, x4 - x5, x3 - x4, x1] + 
    CiTi[x5 - x6, x2 - x5, x4 - x5, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x3 - x5, x1, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x3 - x5, x1, x1 - x2, x4 - x5] + 
    CiTi[x5 - x6, x3 - x5, x1, x2 - x3, x3 - x4] - 
    CiTi[x5 - x6, x3 - x5, x1, x2 - x3, x4 - x5] - 
    CiTi[x5 - x6, x3 - x5, x1, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x3 - x5, x1, x3 - x4, x2 - x3] + 
    CiTi[x5 - x6, x3 - x5, x1, x4 - x5, x1 - x2] - 
    CiTi[x5 - x6, x3 - x5, x1, x4 - x5, x2 - x3] - 
    CiTi[x5 - x6, x3 - x5, x2, x1, x3 - x4] + CiTi[x5 - x6, x3 - x5, x2, x1, 
     x4 - x5] + CiTi[x5 - x6, x3 - x5, x2, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x3 - x5, x2, x1 - x2, x4 - x5] - 
    CiTi[x5 - x6, x3 - x5, x2, x3 - x4, x1] + CiTi[x5 - x6, x3 - x5, x2, 
     x3 - x4, x1 - x2] + CiTi[x5 - x6, x3 - x5, x2, x4 - x5, x1] - 
    CiTi[x5 - x6, x3 - x5, x2, x4 - x5, x1 - x2] + 
    CiTi[x5 - x6, x3 - x5, x1 - x3, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x3 - x5, x1 - x3, x1 - x2, x4 - x5] - 
    CiTi[x5 - x6, x3 - x5, x1 - x3, x2 - x3, x3 - x4] + 
    CiTi[x5 - x6, x3 - x5, x1 - x3, x2 - x3, x4 - x5] + 
    CiTi[x5 - x6, x3 - x5, x1 - x3, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x3 - x5, x1 - x3, x3 - x4, x2 - x3] - 
    CiTi[x5 - x6, x3 - x5, x1 - x3, x4 - x5, x1 - x2] + 
    CiTi[x5 - x6, x3 - x5, x1 - x3, x4 - x5, x2 - x3] + 
    CiTi[x5 - x6, x3 - x5, x2 - x3, x1, x3 - x4] - 
    CiTi[x5 - x6, x3 - x5, x2 - x3, x1, x4 - x5] - 
    CiTi[x5 - x6, x3 - x5, x2 - x3, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x3 - x5, x2 - x3, x1 - x2, x4 - x5] + 
    CiTi[x5 - x6, x3 - x5, x2 - x3, x3 - x4, x1] - 
    CiTi[x5 - x6, x3 - x5, x2 - x3, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x3 - x5, x2 - x3, x4 - x5, x1] + 
    CiTi[x5 - x6, x3 - x5, x2 - x3, x4 - x5, x1 - x2] - 
    CiTi[x5 - x6, x3 - x5, x3 - x4, x1, x1 - x2] + 
    CiTi[x5 - x6, x3 - x5, x3 - x4, x1, x2 - x3] - 
    CiTi[x5 - x6, x3 - x5, x3 - x4, x2, x1] + CiTi[x5 - x6, x3 - x5, x3 - x4, 
     x2, x1 - x2] + CiTi[x5 - x6, x3 - x5, x3 - x4, x1 - x3, x1 - x2] - 
    CiTi[x5 - x6, x3 - x5, x3 - x4, x1 - x3, x2 - x3] + 
    CiTi[x5 - x6, x3 - x5, x3 - x4, x2 - x3, x1] - 
    CiTi[x5 - x6, x3 - x5, x3 - x4, x2 - x3, x1 - x2] + 
    CiTi[x5 - x6, x3 - x5, x4 - x5, x1, x1 - x2] - 
    CiTi[x5 - x6, x3 - x5, x4 - x5, x1, x2 - x3] + 
    CiTi[x5 - x6, x3 - x5, x4 - x5, x2, x1] - CiTi[x5 - x6, x3 - x5, x4 - x5, 
     x2, x1 - x2] - CiTi[x5 - x6, x3 - x5, x4 - x5, x1 - x3, x1 - x2] + 
    CiTi[x5 - x6, x3 - x5, x4 - x5, x1 - x3, x2 - x3] - 
    CiTi[x5 - x6, x3 - x5, x4 - x5, x2 - x3, x1] + 
    CiTi[x5 - x6, x3 - x5, x4 - x5, x2 - x3, x1 - x2] - 
    CiTi[x5 - x6, x4 - x5, x1, x1 - x2, x2 - x3] + 
    CiTi[x5 - x6, x4 - x5, x1, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x4 - x5, x1, x1 - x3, x1 - x2] + 
    CiTi[x5 - x6, x4 - x5, x1, x1 - x3, x2 - x3] + 
    CiTi[x5 - x6, x4 - x5, x1, x2 - x4, x2 - x3] - 
    CiTi[x5 - x6, x4 - x5, x1, x2 - x4, x3 - x4] + 
    CiTi[x5 - x6, x4 - x5, x1, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x4 - x5, x1, x3 - x4, x2 - x3] - 
    CiTi[x5 - x6, x4 - x5, x2, x1, x2 - x3] + CiTi[x5 - x6, x4 - x5, x2, x1, 
     x3 - x4] + CiTi[x5 - x6, x4 - x5, x2, x1 - x2, x2 - x3] - 
    CiTi[x5 - x6, x4 - x5, x2, x1 - x2, x3 - x4] - 
    CiTi[x5 - x6, x4 - x5, x2, x2 - x3, x1] + CiTi[x5 - x6, x4 - x5, x2, 
     x2 - x3, x1 - x2] + CiTi[x5 - x6, x4 - x5, x2, x3 - x4, x1] - 
    CiTi[x5 - x6, x4 - x5, x2, x3 - x4, x1 - x2] - 
    CiTi[x5 - x6, x4 - x5, x3, x1, x1 - x2] + CiTi[x5 - x6, x4 - x5, x3, x1, 
     x2 - x3] - CiTi[x5 - x6, x4 - x5, x3, x2, x1] + 
    CiTi[x5 - x6, x4 - x5, x3, x2, x1 - x2] + CiTi[x5 - x6, x4 - x5, x3, 
     x1 - x3, x1 - x2] - CiTi[x5 - x6, x4 - x5, x3, x1 - x3, x2 - x3] + 
    CiTi[x5 - x6, x4 - x5, x3, x2 - x3, x1] - CiTi[x5 - x6, x4 - x5, x3, 
     x2 - x3, x1 - x2] + CiTi[x5 - x6, x4 - x5, x1 - x4, x1 - x2, x2 - x3] - 
    CiTi[x5 - x6, x4 - x5, x1 - x4, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x4 - x5, x1 - x4, x1 - x3, x1 - x2] - 
    CiTi[x5 - x6, x4 - x5, x1 - x4, x1 - x3, x2 - x3] - 
    CiTi[x5 - x6, x4 - x5, x1 - x4, x2 - x4, x2 - x3] + 
    CiTi[x5 - x6, x4 - x5, x1 - x4, x2 - x4, x3 - x4] - 
    CiTi[x5 - x6, x4 - x5, x1 - x4, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x4 - x5, x1 - x4, x3 - x4, x2 - x3] + 
    CiTi[x5 - x6, x4 - x5, x2 - x4, x1, x2 - x3] - 
    CiTi[x5 - x6, x4 - x5, x2 - x4, x1, x3 - x4] - 
    CiTi[x5 - x6, x4 - x5, x2 - x4, x1 - x2, x2 - x3] + 
    CiTi[x5 - x6, x4 - x5, x2 - x4, x1 - x2, x3 - x4] + 
    CiTi[x5 - x6, x4 - x5, x2 - x4, x2 - x3, x1] - 
    CiTi[x5 - x6, x4 - x5, x2 - x4, x2 - x3, x1 - x2] - 
    CiTi[x5 - x6, x4 - x5, x2 - x4, x3 - x4, x1] + 
    CiTi[x5 - x6, x4 - x5, x2 - x4, x3 - x4, x1 - x2] + 
    CiTi[x5 - x6, x4 - x5, x3 - x4, x1, x1 - x2] - 
    CiTi[x5 - x6, x4 - x5, x3 - x4, x1, x2 - x3] + 
    CiTi[x5 - x6, x4 - x5, x3 - x4, x2, x1] - CiTi[x5 - x6, x4 - x5, x3 - x4, 
     x2, x1 - x2] - CiTi[x5 - x6, x4 - x5, x3 - x4, x1 - x3, x1 - x2] + 
    CiTi[x5 - x6, x4 - x5, x3 - x4, x1 - x3, x2 - x3] - 
    CiTi[x5 - x6, x4 - x5, x3 - x4, x2 - x3, x1] + 
    CiTi[x5 - x6, x4 - x5, x3 - x4, x2 - x3, x1 - x2]
