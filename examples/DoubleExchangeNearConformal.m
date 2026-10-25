(* DoubleExchangeNearConformal.m -- the bispectrum of the double exchange of a massive scalar, the combination A(k1, k2, k3)
   of Section 6.4 of the MBAnalytica paper (the channel whose cubic vertex carries k2), near the conformal mass:
   nu = 1/2 - delta, A = Sum_k A_k delta^k.  An association k -> A_k, k = 0, 1, 2, with every A_k in terms of
   PolyLogTools`G of rational functions of k1, k2, k3, Pi and zeta values; delta is the regulator of MBEvaluate.
   Assembled from the Subtraction results of the nine MB integrals of psi_KIKI, psi_K23, psi_K12 and psi_KK
   (CosmoTreeMB with "Point" -> the triangle (1, 9/10, 4/5)), with Phi_i in closed form; real part.
   At (k1, k2, k3) = (1, 9/10, 4/5): -2.0847304389144 + 4.3883142879364 delta - 9.5812231435701 delta^2.
   Verified there and at (1, 7/10, 9/10) against direct numerical integration (Section 6.5 of the paper). *)
<|0 -> -1/12*((-(Sqrt[k1]*Sqrt[k3]) + 6*k1*Sqrt[k1/(k1 + k2 + k3)]*
        Sqrt[k3/(k1 + k2 + k3)] - 6*k2*Sqrt[k1/(k1 + k2 + k3)]*
        Sqrt[k3/(k1 + k2 + k3)] - 6*k3*Sqrt[k1/(k1 + k2 + k3)]*
        Sqrt[k3/(k1 + k2 + k3)])*Pi^2)/(k1^(3/2)*(k1 - k2 - k3)*k3^(3/2)) - 
   (PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 1]*
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 1]*PolyLogTools`G[
      -1/2*(k1 + k2 + k3)/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 1]*
    (-1/2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4)) - 
   (PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
     -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 - k3/k1, 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
    (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) - 
   (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/
    (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4), 
 1 -> (Sqrt[k1/k3]*Pi^2*PolyLogTools`G[-1 - (k1 + k2 - k3)/(2*k3), 1])/
    (4*k1^(3/2)*Sqrt[k3]*(k1 + k2 + k3)) + 
   (Sqrt[k3/k1]*Pi^2*PolyLogTools`G[-1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (4*Sqrt[k1]*k3^(3/2)*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    (-1/12*Pi^2/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[-(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    (Pi^2/(12*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3)) + PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
     1]*(PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (-(PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
       (k1*k3*(k1 + k2 + k3))) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[-(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    (Pi^2/(12*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
       1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
       (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (-1/12*Pi^2/(k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(2 + (k1 + k2 - k3)/(2*k3))/
        (1 + (k1 + k2 - k3)/(2*k3)), 1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 
       (2 + (k1 + k2 - k3)/(2*k3))/(1 + (k1 + k2 - k3)/(2*k3)), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 
       k1/((-1 + k1/k3)*k3), 1]/(2*k1*(k1 - k2 - k3)*k3)) + 
   PolyLogTools`G[-(-1 + k1/k3)^(-1), 1]*
    ((PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
       PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1]*
       PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*(k1 - k2 - k3)*k3) - (PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 1]*
       PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*k3*(k1 - k2 + k3)) - (PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 1]*
       PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 1])/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    (-1/12*Pi^2/(k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[(-1 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3 - 
           (k1 + k2 - k3)/(2*k3)), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1]/
        (2*k1*k3*(-k1 + k2 + k3)))*PolyLogTools`G[
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1] - 
     PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + ((-3*k1^2 + 2*k1*k2 + 5*k2^2 + 4*k1*k3 + 
        4*k2*k3 - k3^2)*PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
         k1, 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) - PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
       1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
       1 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3))) + 
   PolyLogTools`G[(2 + (k1 + k2 - k3)/(2*k3))/(1 + (k1 + k2 - k3)/(2*k3)), 1]*
    ((PolyLogTools`G[(-1 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3 - 
          (k1 + k2 - k3)/(2*k3)), 1]*PolyLogTools`G[
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3)) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 1]*
    (-1/12*((-k1^(3/2) - Sqrt[k1]*k2 - Sqrt[k1]*k3 + 6*Sqrt[k1/k3]*k3^(3/2))*
        Pi^2)/(k1^(3/2)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((k1^2 - k1*k2 - 2*k2^2 + 2*k1*k3 + k2*k3 + k3^2)*
       PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       -1/2*(k1 + k2 - k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       -1/2*(k1 + k2 - k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1]*
    (PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1]*
    (PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*(k1^2 - 2*k1*k2 + k2^2 - k3^2)) - 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 1]*
    (PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^
         (-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) + 
     (PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 1]*PolyLogTools`G[
        (-2*k3)/(k1 + k2 - k3), 1])/(2*k1*k3*(k1 - k2 + k3)) - 
     (PolyLogTools`G[-1/2*(k1 + k2 - k3)/((k1/k3 - (k1 + k2 - k3)/(2*k3))*
           k3), 1]*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 1])/
      (2*k1*k3*(k1 - k2 + k3)) - 
     (PolyLogTools`G[-1/2*(k1 + k2 - k3)/((k1/k3 - (k1 + k2 - k3)/(2*k3))*
           k3), 1]*PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/
         (k1 + k2 - k3), 1])/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (2*k1)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/(k1 + k2 - k3), k1/((-1 + k1/k3)*k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 
       (2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 1]*
    (-(PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/(k1*(k1 + k2 - k3)*
        k3)) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]*
    (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     1]*(-1/2*(PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
        PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 
         1])/(k1*k3*(k1 - k2 + k3)) - 
     (8*k2*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1])/
      (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) - 
     (4*k2*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
        1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4)) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 1]*PolyLogTools`G[
      (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 1]*
    ((3*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       1]/(2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + 
   (PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1])/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(2 + (-k1 + k2 + k3)/(2*k1))/(1 + (-k1 + k2 + k3)/(2*k1)), 
     1]*(PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1]*
    (PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1]*
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(-1 + k3/k1)^(-1), 1]*
    (-1/2*(PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 1]*PolyLogTools`G[
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
       (k1*k3*(k1 - k2 + k3)) + 
     (PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
       PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
       PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1])/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1]*
    (-1/2*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/
       (k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k3*(-k1^2 + k2^2 - 2*k2*k3 + k3^2)) + 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (-(PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
       (k1*k3*(k1 + k2 + k3))) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) - 
   (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1]*
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    (-1/12*Pi^2/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + ((-k1^2 + 4*k1*k2 + 5*k2^2 + 4*k1*k3 + 
        2*k2*k3 - 3*k3^2)*PolyLogTools`G[0, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
       1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[-(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    (Pi^2/(12*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
       1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
       1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
       (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (2*k3)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 
       (2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (-1/12*Pi^2/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
      (-1/2*PolyLogTools`G[(-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
            (-k1 + k2 + k3)/(2*k1)), 1]/(k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1]/
        (2*k1*(k1 + k2 - k3)*k3)) - 
     (PolyLogTools`G[(-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
          (-k1 + k2 + k3)/(2*k1)), 1]*PolyLogTools`G[
        (2 + (-k1 + k2 + k3)/(2*k1))/(1 + (-k1 + k2 + k3)/(2*k1)), 1])/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 
       (2 + (-k1 + k2 + k3)/(2*k1))/(1 + (-k1 + k2 + k3)/(2*k1)), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(2 + (-k1 + k2 + k3)/(2*k1))/
        (1 + (-k1 + k2 + k3)/(2*k1)), 1, 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]*
    ((PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
        1])/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
          (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/(2*k1*k3*(-k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
    (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 - k2 - k3)*k3)) + 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 1]*
    (PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 1]*
      (PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         1]/(2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         1]/(2*k1*k3*(k1 + k2 + k3))) + 
     ((k1^2 - k1*k2 - 2*k2^2 - k1*k3 - 2*k2*k3)*PolyLogTools`G[0, 
        -1/2*(k1 + k2 + k3)/k1, 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) + PolyLogTools`G[0, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]*
    (-1/2*(PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
          (2*k1), 1]*PolyLogTools`G[((k1 + k2 + k3)*
           (-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1])/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       1]/(2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
    (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   (3*PolyLogTools`G[0, 0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[0, 0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (3*PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 1])/
    (2*k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k3, 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[0, 0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[0, 0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[0, 0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 - k2 + k3)) - 
   (3*PolyLogTools`G[0, 0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
       (2*k3), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 1, 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 1, (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 1, ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, 1, 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 1, (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   ((k1^2 - k1*k2 - 2*k2^2 + 2*k1*k3 + k2*k3 + k3^2)*
     PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   ((-3*k1^2 + 2*k1*k2 + 5*k2^2 + 4*k1*k3 + 4*k2*k3 - k3^2)*
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*(k1 - k2 - k3)*
     (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   ((-k1^2 - k1*k2 + 2*k2^2 - 2*k1*k3 + k2*k3 - k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   (k2*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
   ((k1 - 3*k2 - k3)*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 
      ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 1]/
    (k1*k3*(k1 + k2 + k3)) + (3*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 
      ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 1 - k3/k1, 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), 1, 1]/(k3*(-k1 + k2 + k3)*
     (k1 + k2 + k3)) + PolyLogTools`G[0, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k3*(-k1 + k2 + k3)*
     (k1 + k2 + k3)) + PolyLogTools`G[0, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 4*k1*k2 + 5*k2^2 + 4*k1*k3 + 2*k2*k3 - 3*k3^2)*
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*
     (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   ((-k1^2 - 2*k1*k2 - k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
    (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
      k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) + 
   ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/
    (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
      k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) - 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
     -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
        (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) - 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
     1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
      (1 + k1/k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
     (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 0, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, -1/2*(k1 + k2 + k3)/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
     -1/2*(k1 + k2 + k3)/k3, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
      (2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
     -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[1 - k3/k1, 0, 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1, 1, 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[(1 + k3/k1)^(-1), 0, 1, 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1, 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   ((-k1^2 - 4*k1*k2 - 3*k2^2 - 2*k1*k3 + 4*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1, 1])/
    (2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 - 2*k1*k2 + 3*k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 + 4*k1*k2 + 3*k2^2 + 2*k1*k3 - 4*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) - 
   (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1, 1])/
    ((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 1, 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 1, 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + 
   (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
    (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) - 
   (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
     1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
     2 + (-k1 + k2 + k3)/(2*k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
     (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]*
     Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*k3) - (PolyLogTools`G[1 - k3/k1, 1, 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) + (PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1]*
     Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]*Log[k3/k1])/
    (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) + 
   (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 1]*
    (((k1*Sqrt[k3] + k2*Sqrt[k3] + k3^(3/2) + 6*k1^(3/2)*Sqrt[k3/k1])*Pi^2)/
      (12*k1*(k1 - k2 - k3)*k3^(3/2)*(k1 + k2 + k3)) + 
     (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 1]*PolyLogTools`G[
        -(-1 + k3/k1)^(-1), 1])/(2*k1*(k1 - k2 - k3)*k3) + 
     (PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 1]*PolyLogTools`G[
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     ((-k1^2 - k1*k2 + 2*k2^2 - 2*k1*k3 + k2*k3 - k3^2)*
       PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
        k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) + 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[1 - k3/k1, 1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
       -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1]/
      (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
      ((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k1, 1])/(2*k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k3, 1])/(2*k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
        1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) - 
     (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 1]*Log[k3/k1])/
      (2*k1*(k1 + k2 - k3)*k3) - (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 1]*
       Log[k3/k1])/(2*k1*(k1 - k2 - k3)*k3) - 
     (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]*Log[k3/k1])/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
            (2*k1))), 1]*
      (-1/2*PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
         (k1*k3*(k1 - k2 + k3)) + (4*k2*Log[k3/k1])/(k1^4 - 2*k1^2*k2^2 + 
         k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4))) + 
   (-(k1^(3/2)*Sqrt[k3]*(k1 + k2 + k3)^(3/2)*Pi^2*Log[k3/k1]) - 
     Sqrt[k1]*k2*Sqrt[k3]*(k1 + k2 + k3)^(3/2)*Pi^2*Log[k3/k1] + 
     Sqrt[k1]*k3^(3/2)*(k1 + k2 + k3)^(3/2)*Pi^2*Log[k3/k1] + 
     6*k1^2*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^2*Log[(2*k1)/(k1 + k2 + k3)] + 
     12*k1*k2*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^2*Log[(2*k1)/(k1 + k2 + k3)] + 
     6*k2^2*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^2*Log[(2*k1)/(k1 + k2 + k3)] - 
     6*k3^2*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^2*Log[(2*k1)/(k1 + k2 + k3)] - 
     6*k1^2*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^2*Log[(2*k3)/(k1 + k2 + k3)] + 
     6*k2^2*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^2*Log[(2*k3)/(k1 + k2 + k3)] + 
     12*k2*k3*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^2*Log[(2*k3)/(k1 + k2 + k3)] + 
     6*k3^2*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^2*Log[(2*k3)/(k1 + k2 + k3)] - 
     3*k1^(7/2)*Sqrt[k3/(k1 + k2 + k3)]*Pi^2*Log[1 + (2*k1)/(k1 + k2 + k3)] - 
     3*k1^(5/2)*k2*Sqrt[k3/(k1 + k2 + k3)]*Pi^2*
      Log[1 + (2*k1)/(k1 + k2 + k3)] + 3*k1^(3/2)*k2^2*
      Sqrt[k3/(k1 + k2 + k3)]*Pi^2*Log[1 + (2*k1)/(k1 + k2 + k3)] + 
     3*Sqrt[k1]*k2^3*Sqrt[k3/(k1 + k2 + k3)]*Pi^2*
      Log[1 + (2*k1)/(k1 + k2 + k3)] + 3*k1^(5/2)*k3*Sqrt[k3/(k1 + k2 + k3)]*
      Pi^2*Log[1 + (2*k1)/(k1 + k2 + k3)] + 6*k1^(3/2)*k2*k3*
      Sqrt[k3/(k1 + k2 + k3)]*Pi^2*Log[1 + (2*k1)/(k1 + k2 + k3)] + 
     3*Sqrt[k1]*k2^2*k3*Sqrt[k3/(k1 + k2 + k3)]*Pi^2*
      Log[1 + (2*k1)/(k1 + k2 + k3)] + 3*k1^(3/2)*k3^2*
      Sqrt[k3/(k1 + k2 + k3)]*Pi^2*Log[1 + (2*k1)/(k1 + k2 + k3)] - 
     3*Sqrt[k1]*k2*k3^2*Sqrt[k3/(k1 + k2 + k3)]*Pi^2*
      Log[1 + (2*k1)/(k1 + k2 + k3)] - 3*Sqrt[k1]*k3^3*
      Sqrt[k3/(k1 + k2 + k3)]*Pi^2*Log[1 + (2*k1)/(k1 + k2 + k3)] - 
     3*k1^3*Sqrt[k3]*Sqrt[k1/(k1 + k2 + k3)]*Pi^2*
      Log[1 + (2*k3)/(k1 + k2 + k3)] - 3*k1^2*k2*Sqrt[k3]*
      Sqrt[k1/(k1 + k2 + k3)]*Pi^2*Log[1 + (2*k3)/(k1 + k2 + k3)] + 
     3*k1*k2^2*Sqrt[k3]*Sqrt[k1/(k1 + k2 + k3)]*Pi^2*
      Log[1 + (2*k3)/(k1 + k2 + k3)] + 3*k2^3*Sqrt[k3]*
      Sqrt[k1/(k1 + k2 + k3)]*Pi^2*Log[1 + (2*k3)/(k1 + k2 + k3)] + 
     3*k1^2*k3^(3/2)*Sqrt[k1/(k1 + k2 + k3)]*Pi^2*
      Log[1 + (2*k3)/(k1 + k2 + k3)] + 6*k1*k2*k3^(3/2)*
      Sqrt[k1/(k1 + k2 + k3)]*Pi^2*Log[1 + (2*k3)/(k1 + k2 + k3)] + 
     3*k2^2*k3^(3/2)*Sqrt[k1/(k1 + k2 + k3)]*Pi^2*
      Log[1 + (2*k3)/(k1 + k2 + k3)] + 3*k1*k3^(5/2)*Sqrt[k1/(k1 + k2 + k3)]*
      Pi^2*Log[1 + (2*k3)/(k1 + k2 + k3)] - 3*k2*k3^(5/2)*
      Sqrt[k1/(k1 + k2 + k3)]*Pi^2*Log[1 + (2*k3)/(k1 + k2 + k3)] - 
     3*k3^(7/2)*Sqrt[k1/(k1 + k2 + k3)]*Pi^2*Log[1 + (2*k3)/(k1 + k2 + k3)] + 
     18*k1^(3/2)*Sqrt[k3]*(k1 + k2 + k3)^(3/2)*Zeta[3] + 
     18*Sqrt[k1]*k2*Sqrt[k3]*(k1 + k2 + k3)^(3/2)*Zeta[3] - 
     18*Sqrt[k1]*k3^(3/2)*(k1 + k2 + k3)^(3/2)*Zeta[3])/
    (12*k1^(3/2)*(k1 - k2 - k3)*(k1 + k2 - k3)*k3^(3/2)*
     (k1 + k2 + k3)^(3/2)), 
 2 -> -1/2*(Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)*
      Pi^2*PolyLogTools`G[(2*k1)/(k1 - k2 - k3), 1]*
      PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 1])/(k1^(3/2)*k3^(3/2)*
      (k1 - k2 + k3)) - (Sqrt[k3/(k1 + k2 + k3)]*Pi^2*
     PolyLogTools`G[0, 1, (-2*k1)/(k1 + k2 + k3)])/
    (2*k1*k3^(3/2)*Sqrt[k1 + k2 + k3]) - 
   (Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*Pi^2*
     PolyLogTools`G[0, 1, (2*k1)/(k1 + k2 + k3)])/(2*k1^(3/2)*k3^(3/2)) - 
   (Sqrt[k1/(k1 + k2 + k3)]*Pi^2*PolyLogTools`G[0, 1, 
      (-2*k3)/(k1 + k2 + k3)])/(2*k1^(3/2)*k3*Sqrt[k1 + k2 + k3]) - 
   (Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*Pi^2*
     PolyLogTools`G[0, 1, (2*k3)/(k1 + k2 + k3)])/(2*k1^(3/2)*k3^(3/2)) + 
   (Sqrt[k1/k3]*Pi^2*PolyLogTools`G[0, -1 - (k1 + k2 - k3)/(2*k3), 1])/
    (4*k1^(3/2)*(k1 + k2 - k3)*Sqrt[k3]) + 
   PolyLogTools`G[0, -(-1 + k1/k3)^(-1), 1]*
    (PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   ((k1 - 7*k2 + 7*k3)*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]^2)/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
   ((-7*k1 + 7*k2 - k3)*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]^2)/
    (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)) - 
   (Sqrt[k3/k1]*Pi^2*PolyLogTools`G[0, -1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (4*Sqrt[k1]*(k1 - k2 - k3)*k3^(3/2)) - 
   (Sqrt[k1/k3]*Pi^2*PolyLogTools`G[-1 - (k1 + k2 - k3)/(2*k3), 1, 1])/
    (4*k1^(3/2)*Sqrt[k3]*(k1 + k2 + k3)) + 
   (Sqrt[k1/k3]*Pi^2*PolyLogTools`G[-1 - (k1 + k2 - k3)/(2*k3), 
      -1 - (k1 + k2 - k3)/(2*k3), 1])/(4*k1^(3/2)*Sqrt[k3]*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]*
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]*
    (PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (k1*(k1 - k2 - k3)*k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]*
    (PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (k1*k3*(-k1 + k2 + k3))) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     1 + (k1 + k2 - k3)/(2*k3), 1]*
    (PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (k1*k3*(-k1 + k2 + k3))) + PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
     1]*(((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + k3^2)*
       PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-k1^2 + 4*k1*k2 + 5*k2^2 + 4*k1*k3 + 2*k2*k3 - 3*k3^2)*
       PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3))) + 
   (Sqrt[k1/k3]*Pi^2*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(4*k1^(3/2)*Sqrt[k3]*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    (Pi^2/(6*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
      (k1*k3*(k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 
        2*k2*k3 + k3^2)*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
       1]/(k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
       (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
      (k1*k3*(k1 + k2 + k3))) + 
   (Pi^2*PolyLogTools`G[-(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(12*k1*(k1 + k2 - k3)*k3) - 
   (Pi^2*PolyLogTools`G[-(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
    (12*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (PolyLogTools`G[-(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[-(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    ((6*EulerGamma^2 - Pi^2)/(24*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]*((-6*EulerGamma^2 + Pi^2)/(24*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    ((-6*EulerGamma^2 + Pi^2)/(24*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (-1/6*Pi^2/(k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/(k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[k1/((-1 + k1/k3)*k3), k1/((-1 + k1/k3)*k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3)) + 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (Pi^2/(6*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, k1/((-1 + k1/k3)*k3), 
       1]/(2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 
       k1/((-1 + k1/k3)*k3), 1]/(2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (Pi^2/(6*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[0, k1/((-1 + k1/k3)*k3), 
       1]/(2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 
       1]/(2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 
       k1/((-1 + k1/k3)*k3), 1]/(2*k1*k3*(-k1 + k2 + k3))) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    ((-6*EulerGamma^2*k1^2 + 6*EulerGamma^2*k2^2 + 12*EulerGamma^2*k1*k3 - 
       6*EulerGamma^2*k3^2 - 3*k1^2*Pi^2 + 8*k1*k2*Pi^2 + 11*k2^2*Pi^2 + 
       10*k1*k3*Pi^2 + 4*k2*k3*Pi^2 - 7*k3^2*Pi^2)/(24*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        1 + (k1 + k2 - k3)/(2*k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
      (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[k1/((-1 + k1/k3)*k3), 
       k1/((-1 + k1/k3)*k3), 1]/(2*k1*k3*(k1 + k2 + k3))) - 
   (Sqrt[k1/k3]*Pi^2*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k3, 
      -1 - (k1 + k2 - k3)/(2*k3), 1])/(4*k1^(3/2)*(k1 + k2 - k3)*Sqrt[k3]) + 
   ((6*EulerGamma^2 - Pi^2)*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (24*k1*k3*(k1 + k2 + k3)) + 
   (Pi^2*PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (6*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     1]*(-(PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 + k2 + k3))) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3))) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    ((6*EulerGamma^2*k1^2 - 6*EulerGamma^2*k2^2 - 12*EulerGamma^2*k1*k3 + 
       6*EulerGamma^2*k3^2 + 5*k1^2*Pi^2 - 4*k1*k2*Pi^2 - 9*k2^2*Pi^2 - 
       10*k1*k3*Pi^2 - 4*k2*k3*Pi^2 + 5*k3^2*Pi^2)/(24*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        1 + (k1 + k2 - k3)/(2*k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
      (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 
       k1/((-1 + k1/k3)*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3))) - 
   (Pi^2*PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (12*k1*k3*(-k1 + k2 + k3)) + 
   (PolyLogTools`G[0, k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1]*
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[(2 + (k1 + k2 - k3)/(2*k3))/(1 + (k1 + k2 - k3)/(2*k3)), 
      1, 1]*PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   (PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 
      (2 + (k1 + k2 - k3)/(2*k3))/(1 + (k1 + k2 - k3)/(2*k3)), 1]*
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   (PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), k1/((-1 + k1/k3)*k3), 
      1]*PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    (-1/6*Pi^2/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*(k1 + k2 - k3)*k3) + ((-k1 + 3*k2 - 3*k3)*PolyLogTools`G[0, 
        (-2*k3)/(k1 + k2 - k3), 1])/(k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    (((-k1 + 3*k2 + 3*k3)*Pi^2)/(12*k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) - 
     ((k1 - 3*k2 - 3*k3)*PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 1])/
      (2*k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - (2*(k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - 
        k2*k3 + k3^2)*PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     ((-k1 + k2 + 3*k3)*PolyLogTools`G[0, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)) + 
     ((-k1^2 + 6*k1*k2 + 7*k2^2 + 4*k1*k3 + 4*k2*k3 - 3*k3^2)*
       PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     (3*PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
        (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1])/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       1 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1 + (k1 + k2 - k3)/(2*k3), 1]/
      (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
        k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(-k1 + k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[0, k1/((-1 + k1/k3)*k3), 1]*
    (PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     ((k1 - k2)*PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/
         k1, 1])/(k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    (-1/12*(Sqrt[k1]*Pi^2 - 3*Sqrt[k1/k3]*Sqrt[k3]*Pi^2)/
       (k1^(3/2)*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    (-1/12*(Sqrt[k1]*Pi^2 - 3*Sqrt[k1/k3]*Sqrt[k3]*Pi^2)/
       (k1^(3/2)*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + ((-k1^2 - k1*k2 + 2*k2^2 - k1*k3 + 2*k2*k3)*
       PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*k3*(k1 - k2 + k3))) + (PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 1]*
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 1]*PolyLogTools`G[
      ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*k3*(k1 - k2 + k3)) - 
   (PolyLogTools`G[0, (2*k1)/(k1 + k2 - k3), 1]*
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*k3*(k1 - k2 + k3)) - 
   (PolyLogTools`G[(2*k1)/(k1 + k2 - k3), k1/((-1 + k1/k3)*k3), 1]*
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*k3*(k1 - k2 + k3)) + 
   (PolyLogTools`G[(2*k1)/(k1 + k2 - k3), (2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/
       (k1 + k2 - k3), 1]*PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), 1]*
    ((Sqrt[k1]*Pi^2 - 3*Sqrt[k1/k3]*Sqrt[k3]*Pi^2)/
      (12*k1^(3/2)*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
        k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*
         k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    ((Sqrt[k1]*Pi^2 - 3*Sqrt[k1/k3]*Sqrt[k3]*Pi^2)/
      (12*k1^(3/2)*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + ((k1^2 + k1*k2 - 2*k2^2 - 2*k1*k3 + k2*k3 + 
        k3^2)*PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
        k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*
         k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3), 
     1]*PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1]*
    (PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1]*
    (-1/2*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   ((-(k1*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*Pi^2) - 
      k2*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*Pi^2 - 
      k3*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*Pi^2)*
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 1, 1])/
    (2*k1^(3/2)*k3^(3/2)*(k1 - k2 + k3)) + 
   (Pi^2*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(12*k1*(k1 + k2 - k3)*k3) + 
   ((6*EulerGamma^2*k1 - 6*EulerGamma^2*k2 + 6*EulerGamma^2*k3 + 3*k1*Pi^2 - 
      11*k2*Pi^2 + 11*k3*Pi^2)*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(24*k1*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)) + PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (Pi^2/(6*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^
         (-1), 1]/(k1*k3*(k1 - k2 + k3))) + 
   ((-6*EulerGamma^2*k1^(5/2) + 6*EulerGamma^2*Sqrt[k1]*k2^2 - 
      12*EulerGamma^2*k1^(3/2)*k3 - 6*EulerGamma^2*Sqrt[k1]*k3^2 - 
      7*k1^(5/2)*Pi^2 + 4*k1^(3/2)*k2*Pi^2 + 11*Sqrt[k1]*k2^2*Pi^2 - 
      18*k1^(3/2)*k3*Pi^2 - 12*k1*Sqrt[k1/k3]*k3^(3/2)*Pi^2 + 
      12*k2*Sqrt[k1/k3]*k3^(3/2)*Pi^2 - 11*Sqrt[k1]*k3^2*Pi^2 - 
      12*Sqrt[k1/k3]*k3^(5/2)*Pi^2)*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
      (-2*k3)/(k1 + k2 - k3), 1])/(24*k1^(3/2)*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 
     k1/((-1 + k1/k3)*k3), 1]*
    (PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
     -1/2*(k1 + k2 - k3)/k1, 1]*(PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
      (k1*(k1 + k2 - k3)*k3)) + PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 1]*
    ((2*(k1^2 - k1*k2 - 2*k2^2 + 2*k1*k3 + k2*k3 + k3^2)*
       PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^
         (-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (-1/6*Pi^2/(k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[-(-1 + k1/k3)^(-1), 1, 
       1]/(2*k1*(k1 - k2 - k3)*k3) + 
     ((-k1^2 - k1*k2 + 2*k2^2 - k1*k3 + 2*k2*k3)*PolyLogTools`G[
        (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2 + (k1 + k2 - k3)/(2*k3))/(1 + (k1 + k2 - k3)/(2*k3)), 
       1, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     ((k1 - k2)*PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[k1/((-1 + k1/k3)*k3), k1/((-1 + k1/k3)*k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     -1/2*(k1 + k2 - k3)/k1, 1]*(PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]*
    (-(PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
        -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     1]*(-1/12*((-k1 + 3*k2 - 3*k3)*Pi^2)/(k1*(k1 + k2 - k3)*k3*
        (k1 - k2 + k3)) + PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^
        (-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     ((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + k3^2)*
       PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-k1^2 + 4*k1*k2 + 5*k2^2 + 4*k1*k3 + 2*k2*k3 - 3*k3^2)*
       PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[-(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       -1/2*(k1 + k2 - k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       -1/2*(k1 + k2 - k3)/k1, 1]/(k1*k3*(k1 - k2 + k3)) + 
     (3*PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     ((k1 - 5*k2 + 5*k3)*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
        -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)) + ((-3*k1 + 5*k2 - 5*k3)*PolyLogTools`G[
        (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[-(-1 + k1/k3)^(-1), 1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     ((k1^2 + k1*k2 - 2*k2^2 - 2*k1*k3 + k2*k3 + k3^2)*
       PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
        (-2*k3)/(k1 + k2 - k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    (-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) - 
   (PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, 1]*
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]*
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]*
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1])/
    (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
      k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) + 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 1]*
    (-1/2*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
       (k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3))) + 
   (Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)*Pi^2*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 1, 1])/
    (2*k1^(3/2)*k3^(3/2)*(k1 - k2 + k3)) - 
   (PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^
       (-1), 1]*PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 
      1])/(2*k1*(k1 - k2 - k3)*k3) - 
   (Sqrt[k3/k1]*Pi^2*PolyLogTools`G[-1 - (-k1 + k2 + k3)/(2*k1), 1, 1])/
    (4*Sqrt[k1]*k3^(3/2)*(k1 + k2 + k3)) + 
   (Sqrt[k3/k1]*Pi^2*PolyLogTools`G[-1 - (-k1 + k2 + k3)/(2*k1), 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(4*Sqrt[k1]*k3^(3/2)*(k1 + k2 + k3)) + 
   (Pi^2*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (12*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]*
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    ((6*EulerGamma^2 - Pi^2)/(24*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    ((-6*EulerGamma^2 + Pi^2)/(24*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) - 
   (PolyLogTools`G[0, k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1]*
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
       (-k1 + k2 + k3)/(2*k1)), 1]*PolyLogTools`G[
     (2 + (-k1 + k2 + k3)/(2*k1))/(1 + (-k1 + k2 + k3)/(2*k1)), 1]*
    (PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3)) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
      (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (Pi^2*PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(12*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]*
    ((6*EulerGamma^2*k1^2*Sqrt[k3] - 6*EulerGamma^2*k2^2*Sqrt[k3] + 
       12*EulerGamma^2*k1*k3^(3/2) + 6*EulerGamma^2*k3^(5/2) + 
       13*k1^2*Sqrt[k3]*Pi^2 - 13*k2^2*Sqrt[k3]*Pi^2 + 22*k1*k3^(3/2)*Pi^2 - 
       4*k2*k3^(3/2)*Pi^2 + 9*k3^(5/2)*Pi^2 + 12*k1^(5/2)*Sqrt[k3/k1]*Pi^2 - 
       12*k1^(3/2)*k2*Sqrt[k3/k1]*Pi^2 + 12*k1^(3/2)*k3*Sqrt[k3/k1]*Pi^2)/
      (24*k1*(k1 - k2 - k3)*k3^(3/2)*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[1 - k3/k1, 1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
       -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-(-1 + k3/k1)^(-1), 1, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1]/
      (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
      ((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k1, 1])/(2*k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k3, 1])/(2*k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
        1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) - 
     (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 - k2 + k3))) + 
   (Pi^2*PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (6*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    (Pi^2/(6*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    (-1/12*Pi^2/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/k3, 1]/
      (k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    ((-2*Sqrt[k3]*Pi^2 - 3*Sqrt[k1]*Sqrt[k3/k1]*Pi^2)/
      (12*k1*(k1 + k2 - k3)*k3^(3/2)) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    ((Sqrt[k3]*Pi^2 - 3*Sqrt[k1]*Sqrt[k3/k1]*Pi^2)/(12*k1*(k1 + k2 - k3)*
       k3^(3/2)) + ((-2*k1*k2 - 2*k2^2 + k1*k3 + k2*k3 + k3^2)*
       PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-(-1 + k3/k1)^(-1), 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
      (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    ((-6*EulerGamma^2*k1 + 6*EulerGamma^2*k2 - 6*EulerGamma^2*k3 - 
       5*k1*Pi^2 + 5*k2*Pi^2 + 3*k3*Pi^2)/(24*k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*k3*(k1 - k2 + k3))) - (PolyLogTools`G[0, (2*k3)/(-k1 + k2 + k3), 1]*
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*k3*(k1 - k2 + k3)) - 
   (PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), k3/(k1*(-1 + k3/k1)), 1]*
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*k3*(k1 - k2 + k3)) + 
   (PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 
      (2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1]*
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 1]*
    ((-2*Sqrt[k3]*Pi^2 - 3*Sqrt[k1]*Sqrt[k3/k1]*Pi^2)/
      (12*k1*k3^(3/2)*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    ((Sqrt[k3]*Pi^2 - 3*Sqrt[k1]*Sqrt[k3/k1]*Pi^2)/
      (12*k1*k3^(3/2)*(k1 - k2 + k3)) + 
     ((k1^2 + k1*k2 - 2*k2^2 - 2*k1*k3 + k2*k3 + k3^2)*
       PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*
       k3) + PolyLogTools`G[-(-1 + k3/k1)^(-1), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
      (k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*
       k3) + PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (-1/6*Pi^2/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (Pi^2/(6*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (-(PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 + k2 + k3))) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[-(-1 + k3/k1)^(-1), 1, 1]*
    (-1/2*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
       (k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1]^2*
    (PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[0, -(-1 + k3/k1)^(-1), 1]*
    (PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]*
    (PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]*
    (-1/2*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1 + (-k1 + k2 + k3)/(2*k1), 1]*
    (-1/2*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*(k1 + k2 - k3)*k3)) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 
     k3/(k1*(-1 + k3/k1)), 1]*
    (PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1]*
    (PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*(k1 + k2 - k3)*k3) + ((-k2 + k3)*PolyLogTools`G[0, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]*
    (-1/2*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 1]*
    (((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + k3^2)*
       PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-3*k1^2 + 2*k1*k2 + 5*k2^2 + 4*k1*k3 + 4*k2*k3 - k3^2)*
       PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3))) + 
   (Sqrt[k3/k1]*Pi^2*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(4*Sqrt[k1]*k3^(3/2)*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    ((6*EulerGamma^2*k1^2 - 6*EulerGamma^2*k2^2 - 12*EulerGamma^2*k1*k3 + 
       6*EulerGamma^2*k3^2 + 3*k1^2*Pi^2 - 4*k1*k2*Pi^2 - 7*k2^2*Pi^2 - 
       6*k1*k3*Pi^2 - 4*k2*k3*Pi^2 + 3*k3^2*Pi^2)/(24*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 1]/
      (k1*k3*(k1 + k2 + k3)) + ((k1 - k2 - k3)*PolyLogTools`G[
        1 + (-k1 + k2 + k3)/(2*k1), 1 + (-k1 + k2 + k3)/(2*k1), 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) - PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    ((-3*k1*Pi^2 - 3*k2*Pi^2 + k3*Pi^2)/(12*k1*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) + ((-3*k1 - 3*k2 + k3)*PolyLogTools`G[0, 
        1 + (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[-(-1 + k3/k1)^(-1), 1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     (3*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
        (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1])/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
       1]/(k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
       1]/(k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    ((-6*EulerGamma^2*k1^2 + 6*EulerGamma^2*k2^2 + 12*EulerGamma^2*k1*k3 - 
       6*EulerGamma^2*k3^2 - k1^2*Pi^2 + 4*k1*k2*Pi^2 + 5*k2^2*Pi^2 - 
       2*k1*k3*Pi^2 + 8*k2*k3*Pi^2 + 3*k3^2*Pi^2)/(24*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 1]/
      (k1*k3*(k1 + k2 + k3)) + ((-k1 + k2 + k3)*PolyLogTools`G[
        1 + (-k1 + k2 + k3)/(2*k1), 1 + (-k1 + k2 + k3)/(2*k1), 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[0, -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    (Pi^2/(6*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
       1]/(k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
       (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (-1/2*PolyLogTools`G[-(-1 + k3/k1)^(-1), 1, 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     ((k1^2 + k1*k2 - 2*k2^2 - 2*k1*k3 + k2*k3 + k3^2)*
       PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
        (-2*k1)/(-k1 + k2 + k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)) - PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/
        (-k1 + k2 + k3), 1, 1]/(2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (-1/6*Pi^2/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + ((3*k1 + k2 - k3)*PolyLogTools`G[0, 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[-(-1 + k3/k1)^(-1), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     ((-k2 + k3)*PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + ((-2*k1*k2 - 2*k2^2 + k1*k3 + k2*k3 + k3^2)*
       PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2 + (-k1 + k2 + k3)/(2*k1))/
        (1 + (-k1 + k2 + k3)/(2*k1)), 1, 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (-1/12*Pi^2/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 
       (2 + (-k1 + k2 + k3)/(2*k1))/(1 + (-k1 + k2 + k3)/(2*k1)), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(2 + (-k1 + k2 + k3)/(2*k1))/
        (1 + (-k1 + k2 + k3)/(2*k1)), 1, 1]/(2*k1*(k1 + k2 - k3)*k3)) - 
   (Pi^2*PolyLogTools`G[-(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(12*k1*(k1 - k2 - k3)*k3) + 
   (Pi^2*PolyLogTools`G[-(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (12*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (-1/2*PolyLogTools`G[-(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 - k2 - k3)*k3)) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     1]*(-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
     (2*(k1^2 + k1*k2 - 2*k2^2 + 2*k1*k3 - k2*k3 + k3^2)*
       PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(-1 + k3/k1)^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/
      (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 
        2*k2*k3 + k3^2)*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
        k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) + 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + ((-3*k1^2 + 4*k1*k2 + 7*k2^2 + 4*k1*k3 + 
        6*k2*k3 - k3^2)*PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((3*k1 - 3*k2 + k3)*PolyLogTools`G[0, -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^
          (-1), 1])/(k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[0, -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((5*k1 - 5*k2 + 3*k3)*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
        (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     ((-5*k1 + 5*k2 - k3)*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
        -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[1 - k3/k1, 1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 1]/
      (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-(-1 + k3/k1)^(-1), 1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
      (k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       1]/(k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
      ((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k3, 1])/(k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(k1*k3*(k1 - k2 + k3)) + 
     (3*PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (2*k1*k3*(k1 - k2 + k3)) + ((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + 
        k3^2)*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-3*k1^2 + 2*k1*k2 + 5*k2^2 + 4*k1*k3 + 4*k2*k3 - k3^2)*
       PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 - k2 - k3)*k3)) + (Sqrt[k3/(k1 + k2 + k3)]*Sqrt[k1 + k2 + k3]*
     Pi^2*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*
        (-1 + (2*k1)/(k1 + k2 + k3))), 
      ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1])/
    (4*k1*k3^(3/2)*(-k1 + k2 + k3)) - 
   (Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k1 + k2 + k3]*Pi^2*
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
      ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1])/
    (4*k1^(3/2)*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]*
    (PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
          (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     (2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]*
    (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(-k1 + k2 + k3))) + 
   PolyLogTools`G[0, (2*k1)/(k1 + k2 + k3), 1]*
    (-1/2*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1]/
       (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[0, 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
          (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(k1*k3*(-k1 + k2 + k3))) + 
   (PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
      ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
      -1/2*(k1 + k2 + k3)/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]*(Pi^2/(6*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 - k2 - k3)*k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
    (-1/6*Pi^2/(k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(-k1 + k2 + k3))) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
        (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
    (-1/6*Pi^2/(k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(-k1 + k2 + k3))) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
    (Pi^2/(6*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + ((k1 + 2*k2 + 2*k3)*
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
        -1/2*(k1 + k2 + k3)/k3, 1])/(k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]*
    (Pi^2/(12*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]*
    (-1/12*Pi^2/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]*
    (PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]*
    (-1/2*PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
        ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
       (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
     -1/2*(k1 + k2 + k3)/k3, 1]*(Pi^2/(12*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[0, (2*k3)/(k1 + k2 + k3), 1]*
    (((-3*k1 - 3*k2 - k3)*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       1]/(k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*(k1 + k2 - k3)*k3)) + PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1]*
    (-1/12*Pi^2/(k1*k3*(k1 + k2 + k3)) + 
     ((-k1 - 2*k2 - 2*k3)*PolyLogTools`G[0, 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
          (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     ((2*k1 + 2*k2 + k3)*PolyLogTools`G[0, 
        ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     (3*PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1])/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
     (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]*
    (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1, 1]*
    (-1/2*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
         (2*k1), -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[0, (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]*
    (-1/2*PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
         (2*k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + PolyLogTools`G[(2*k3)/(k1 + k2 + k3), 1]*
    PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]*
    (-((PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
         1]*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
          (2*k3), 1])/(k1*(k1 + k2 - k3)*k3)) + 
     ((3*k1 + 3*k2 + k3)*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       1]/(k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*(k1 + k2 - k3)*k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     -1/2*(k1 + k2 + k3)/k1, 1]*
    (-1/2*PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 1]/
       (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3))) + 
   (PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
      ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
      -1/2*(k1 + k2 + k3)/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]*(Pi^2/(6*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
    (-1/6*Pi^2/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1]*
    (-1/6*Pi^2/(k1*(k1 + k2 - k3)*k3) + 
     ((3*k1^2 - 2*k1*k2 - 5*k2^2 - 4*k1*k3 - 4*k2*k3 + k3^2)*
       PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       1]/(2*k1*(k1 + k2 - k3)*k3) + 
     ((k1 - 3*k2 - k3)*PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
        -1/2*(k1 + k2 + k3)/k3, 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1, 
       1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
    (-1/2*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*
          (-1 + (2*k1)/(k1 + k2 + k3))), 1, 1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
    (PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
    (Pi^2/(6*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1, 
       1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + ((-2*k1 - 2*k2 - k3)*
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
        -1/2*(k1 + k2 + k3)/k3, 1])/(k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]*
    (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
     (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]*
    (-(PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
        1, 1]/(k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
    (-1/2*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
         (2*k3), 1, 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
     ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]*
    ((Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k1 + k2 + k3]*Pi^2)/
      (4*k1^(3/2)*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
    (-1/4*(Sqrt[k3/(k1 + k2 + k3)]*Sqrt[k1 + k2 + k3]*Pi^2)/
       (k1*k3^(3/2)*(-k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 1]*
    (-1/2*(PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/
          (2*k1), 1]*PolyLogTools`G[((k1 + k2 + k3)*
           (-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/(k1*k3*(k1 - k2 + k3)) - 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
       PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
        1])/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]*
    (-1/2*PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
        ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
       (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[0, 0, -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (4*k1^2*k3) - (EulerGamma*PolyLogTools`G[0, 0, 
      ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[0, 0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 
     1]/(4*k1^2*k3) - (EulerGamma*PolyLogTools`G[0, 0, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 0, -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (4*k1*k3^2) - (11*PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(4*k1*k3*(k1 + k2 + k3)) + 
   (11*PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
    (4*k1*k3*(k1 + k2 + k3)) + 
   ((-3*EulerGamma*k1 - 3*EulerGamma*k2 - EulerGamma*k3)*
     PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) - (EulerGamma*PolyLogTools`G[0, 
      ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (2*(EulerGamma*k1 + EulerGamma*k2)*PolyLogTools`G[0, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, 1])/(k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   (9*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(4*k1*(k1 + k2 - k3)*k3) + 
   (9*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1])/
    (4*k1*(k1 + k2 - k3)*k3) + 
   (9*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(4*k1*(k1 - k2 - k3)*k3) + 
   ((EulerGamma*k1 + 3*EulerGamma*k2 + 3*EulerGamma*k3)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3*
     (k1 + k2 + k3)) - (EulerGamma*PolyLogTools`G[0, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (2*(EulerGamma*k2 + EulerGamma*k3)*PolyLogTools`G[0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3*
     (k1 + k2 + k3)) + 
   (11*PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (4*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]*
    (PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     (3*PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
        -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (k1*k3*(-k1 + k2 + k3))) + 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
      (-2*k3)/(k1 + k2 - k3), 1])/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    ((EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
     (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
        (-2*k3)/(k1 + k2 - k3), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
     (5*PolyLogTools`G[0, 0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      1])/(k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^
        (-1), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 0, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3) - 
   (EulerGamma*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, 1])/(k1*(k1 + k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
      ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, 1])/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(2 + (k1 + k2 - k3)/(2*k3))/(1 + (k1 + k2 - k3)/(2*k3)), 1]*
    ((-11*PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(-k1 + k2 + k3)) - 
     (11*PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
      ((11*PolyLogTools`G[(-1 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3 - 
            (k1 + k2 - k3)/(2*k3)), 1])/(4*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[(-1 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3 - 
           (k1 + k2 - k3)/(2*k3)), (-1 - (k1 + k2 - k3)/(2*k3))/
          (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3)), 1]/(2*k1*(k1 - k2 - k3)*
         k3)) + (11*PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/
         k1, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[(-1 - (k1 + k2 - k3)/(2*k3))/
        (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3)), 1]*
      (PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*(k1 - k2 - k3)*k3)) + PolyLogTools`G[0, 0, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[0, 0, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3)) + PolyLogTools`G[-(-1 + k1/k3)^(-1), 1]*
    ((PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
       PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
      (2*k1*k3*(k1 + k2 + k3)) + 
     (11*PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(k1 + k2 + k3)) - 
     (11*PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*(k1 + k2 - k3)*k3) + 
     (11*PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(-k1 + k2 + k3)) + 
     (11*PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(k1 - k2 + k3)) - (PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 1]*
       PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1])/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
      (-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) + 
       (11*PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 1])/
        (4*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, (2*k1)/(k1 + k2 - k3), 
         1]/(2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 
         1, 1]/(2*k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 1]*
      ((11*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 1])/(4*k1*(k1 + k2 - k3)*
         k3) - PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
         1]/(2*k1*(k1 + k2 - k3)*k3)) + 
     (11*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
        ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(4*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
      (-1/12*Pi^2/(k1*k3*(-k1 + k2 + k3)) + 
       (11*PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1])/
        (4*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[0, 
         k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1, 1]/
        (2*k1*(k1 - k2 - k3)*k3)) - 
     (11*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(4*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
      ((-11*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
        (4*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3))) + 
     (PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1]*
       PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*(k1 - k2 - k3)*k3) - (PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 1]*
       PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, 0, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 0, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[0, 0, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1]*
    ((-11*PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(k1 - k2 + k3)) - 
     (11*PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(k1 - k2 + k3)) + 
     (11*PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 0, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, 0, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     (-2*k3)/(k1 + k2 - k3), 1]/(4*k1^2*k3) - 
   PolyLogTools`G[((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 
     (-2*k3)/(k1 + k2 - k3), 1]/(4*k1^2*k3) - 
   PolyLogTools`G[((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(4*k1^2*k3) - 
   PolyLogTools`G[((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/(4*k1^2*k3) + 
   PolyLogTools`G[((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, (-2*k3)/(k1 + k2 - k3), 1]/
    (4*k1^2*k3) + (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(k1*(k1 + k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(k1*(k1 + k2 - k3)*k3) - 
   (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
      (-2*k3)/(k1 + k2 - k3), 1])/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 1]*
    (-1/2*(EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
         -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(k1*(k1 + k2 - k3)*k3) - 
     (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
        (-2*k3)/(k1 + k2 - k3), 1])/(2*k1*(k1 + k2 - k3)*k3) + 
     (5*PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 1])/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
       (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
      (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
       (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3)) - 
   (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^
        (-1), 1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1])/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
      (-2*k3)/(k1 + k2 - k3), 1])/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1]*
    (((11 - 2*EulerGamma)*PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
         k1, 1])/(4*k1*k3*(k1 + k2 + k3)) + 
     ((-11 + 2*EulerGamma)*PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*
          k3)/k1, 1])/(4*k1*(k1 + k2 - k3)*k3) - 
     (11*PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*(k1 - k2 - k3)*k3) + 
     (11*PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]*
      (PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
         (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*
         k3) + PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
         -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3))) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
      (PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
        (k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[
         (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
         (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
         (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
         -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3))) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
      (PolyLogTools`G[0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
        (k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[
         (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
         (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
         (-2*k3)/(k1 + k2 - k3), 1]/(k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
      (-(PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
         (k1*k3*(k1 + k2 + k3))) - 
       PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
         (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
        (2*k1*k3*(k1 + k2 + k3))) + 
     (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
     (EulerGamma*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
      (2*k1*k3*(k1 + k2 + k3)) + ((11 - 2*EulerGamma)*
       PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*
          k3)/k1, 1])/(4*k1*(k1 + k2 - k3)*k3) + 
     ((-11 + 2*EulerGamma)*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
         k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]*
      (-1/12*(Sqrt[k1]*Pi^2 - 3*Sqrt[k1/k3]*Sqrt[k3]*Pi^2)/
         (k1^(3/2)*(k1 - k2 - k3)*k3) - 
       (11*PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
        (4*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, 
         (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[0, 
         ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*(k1 - k2 - k3)*k3) + ((-k1^2 - k1*k2 + 2*k2^2 - k1*k3 + 
          2*k2*k3)*PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*
            k3)/k1, 1])/(k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*
         (k1 + k2 + k3)) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
         1]/(2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
         (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
        (2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
         (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
        (2*k1*(k1 - k2 - k3)*k3) - 
       PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 1]*
      (-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) + 
       ((11 - 2*EulerGamma)*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 1])/
        (4*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 
         1]/(2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
         1]/(2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
         -1/2*(k1 + k2 - k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         -1/2*(k1 + k2 - k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]*
      ((Sqrt[k1]*Pi^2 - 3*Sqrt[k1/k3]*Sqrt[k3]*Pi^2)/(12*k1^(3/2)*k3*
         (k1 - k2 + k3)) + (11*PolyLogTools`G[
          ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
        (4*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, 
         ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, 
         ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(k1 - k2 + k3)) + ((k1^2 + k1*k2 - 2*k2^2 - 2*k1*k3 + 
          k2*k3 + k3^2)*PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*
            k3)/k1, 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
         (k1 - k2 + k3)) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
         ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
         ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*
         k3) + PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
        (2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 1]*
      (PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/(k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (k1/k3 - (k1 + k2 - k3)/(2*k3))^
          (-1), 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
     (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
        -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3) - 
     (EulerGamma*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
        (-2*k3)/(k1 + k2 - k3), 1])/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, 0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 0, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, 0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*(k1 - k2 - k3)*k3) - ((3*k1 - 3*k2 - k3)*PolyLogTools`G[0, 0, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, 0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 1, 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, 1, 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) - 
     PolyLogTools`G[0, 1, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
       1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     ((-k1^2 - k1*k2 + 2*k2^2 - k1*k3 + 2*k2*k3)*PolyLogTools`G[0, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + ((k1^2 + k1*k2 - 2*k2^2 - 2*k1*k3 + k2*k3 + 
        k3^2)*PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) - 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (k1/k3 - (k1 + k2 - k3)/(2*k3))^
        (-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       (-2*k3)/(k1 + k2 - k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
       -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
       -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       1]/(2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       (-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
       (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
      (k1*(k1 + k2 - k3)*k3)) - 
   (EulerGamma*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*(k1 - k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (k1*(k1 - k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
      (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1])/
    (k1*(k1 - k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
      (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*(k1 - k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      1])/(2*k1*(k1 - k2 - k3)*k3) - 
   (EulerGamma*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (EulerGamma*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1])/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (EulerGamma*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (EulerGamma*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
      -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3) + 
   (EulerGamma*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]*
    (-1/2*PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
       (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     (3*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^
         (-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(2 + (-k1 + k2 + k3)/(2*k1))/(1 + (-k1 + k2 + k3)/(2*k1)), 
     1]*((-11*PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/
         k3, 1])/(4*k1*(k1 + k2 - k3)*k3) - 
     (11*PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*(k1 + k2 - k3)*k3) + 
     (11*PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 0, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 0, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1]*
    ((-11*PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        1])/(4*k1*k3*(k1 - k2 + k3)) - 
     (11*PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*k3*(k1 - k2 + k3)) + 
     (11*PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 0, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, 0, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3))) - 
   (EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      (-2*k1)/(-k1 + k2 + k3), 1])/(k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    ((EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
     (EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
     (5*PolyLogTools`G[0, 0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) + 
   (EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      1])/(k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(-1 + k3/k1)^(-1), 1]*
    ((Pi^2*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (6*k1*(k1 + k2 - k3)*k3) + 
     (Pi^2*PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (6*k1*k3*(k1 - k2 + k3)) + 
     (11*PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*k3*(k1 + k2 + k3)) + 
     (11*PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*(k1 - k2 - k3)*k3) + 
     (11*PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*(k1 + k2 - k3)*k3) + 
     (11*PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*k3*(k1 - k2 + k3)) + 
     (PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
       PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
      (-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) + 
       (11*PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 1])/
        (4*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, (2*k3)/(-k1 + k2 + k3), 
         1]/(2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 
         1, 1]/(2*k1*k3*(k1 - k2 + k3))) - 
     (11*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(4*k1*(k1 - k2 - k3)*k3) - 
     (11*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(4*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
      (-1/6*Pi^2/(k1*k3*(k1 + k2 + k3)) - 
       (11*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
        (4*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*k3*(k1 + k2 + k3))) - 
     (PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1]*
       PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (2*k1*(k1 + k2 - k3)*k3) - (PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 1]*
       PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1]*
      (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*
         k3) - PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
         1]/(2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 
         -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
        (2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
        (2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
         (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
         -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3))) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
      (-1/12*Pi^2/(k1*(k1 + k2 - k3)*k3) + 
       (11*PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1])/
        (4*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 
         k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1, 1]/
        (2*k1*(k1 + k2 - k3)*k3)) + 
     (3*PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 1])/
      (k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, 0, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     (3*PolyLogTools`G[0, 0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 0, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     (3*PolyLogTools`G[0, 0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 0, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     (3*PolyLogTools`G[0, 0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (k1*k3*(k1 + k2 + k3)) - (3*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
        (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     (3*PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     (3*PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
        (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (3*PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - (2*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
        0, (-2*k1)/(-k1 + k2 + k3), 1])/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^
        (-1), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^
         (-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     (2*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^
         (-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     (2*PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
        (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (2*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^
         (-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[(k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (-2*k1)/(-k1 + k2 + k3), 1]/(4*k1*k3^2) - 
   PolyLogTools`G[(k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1, 
     (-2*k1)/(-k1 + k2 + k3), 1]/(4*k1*k3^2) - 
   PolyLogTools`G[(k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(4*k1*k3^2) - 
   PolyLogTools`G[(k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/(4*k1*k3^2) + 
   PolyLogTools`G[(k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, (-2*k1)/(-k1 + k2 + k3), 
     1]/(4*k1*k3^2) + 
   (PolyLogTools`G[(1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
       ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]*
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
      1, 1])/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]*
    (PolyLogTools`G[((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
      (-(PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
          1, 1]/(k1*k3*(k1 - k2 + k3))) + 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1, 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1, 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]*
    (-(PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
        1, ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
       (k1*k3*(k1 - k2 + k3))) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       1, 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
    ((PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]*
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
        1, 1])/(2*k1*k3*(k1 - k2 + k3)) - 
     (2*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
        1, 1, 1])/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     (2*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
        1, 1, 1])/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]*
    (-(PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
        1, 1, 1]/(k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       1, 1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 1]*
    ((PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
        1, 1])/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]*
      (PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         1, 1]/(k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]*
      ((Sqrt[k3/(k1 + k2 + k3)]*Sqrt[k1 + k2 + k3]*Pi^2)/
        (4*k1*k3^(3/2)*(-k1 + k2 + k3)) + 
       (3*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1])/
        (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 
         ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
         -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
         ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         1, 1]/(k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
      (-1/2*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*
            (-1 + (2*k1)/(k1 + k2 + k3))), (1 + (2*k1)/(k1 + k2 + k3) - 
            (2*k3)/(k1 + k2 + k3))/((2*k1)/(k1 + k2 + k3) - 
            (2*k3)/(k1 + k2 + k3)), 1]/(k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
          ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]*
      (-1/4*(Sqrt[k3/(k1 + k2 + k3)]*Sqrt[k1 + k2 + k3]*Pi^2)/
         (k1*k3^(3/2)*(-k1 - k2 + k3)) + 
       (3*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1])/
        (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 
         ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 
         ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
         -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
         ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
         ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         1, 1]/(k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
          ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         1, 1]/(k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
          ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
        (2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     (7*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k3, 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
         (2*k3), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 1]/
      (k1*k3*(k1 + k2 + k3)) + (3*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 
        ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, -1/2*(k1 + k2 + k3)/k3, 1]/
      (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, 
       ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       -1/2*(k1 + k2 + k3)/k3, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
        (2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     (2*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
        1, 1, 1])/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     (2*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
        1, 1, 1])/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
    (PolyLogTools`G[((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
      (PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
          ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
          ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
        (2*k1*k3*(k1 - k2 + k3))) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       1, 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       1, 1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3))) + 
   (3*PolyLogTools`G[0, 0, 0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (k1*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[0, 0, 0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (k1*(k1 + k2 - k3)*k3) - 
   (7*PolyLogTools`G[0, 0, 0, (-2*k1)/(-k1 + k2 + k3), 1])/
    (k1*(k1 - k2 - k3)*k3) + 
   (7*PolyLogTools`G[0, 0, 0, -1/2*(k1 + k2 + k3)/k3, 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[0, 0, 0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*k3*(k1 + k2 + k3)) + 
   (5*PolyLogTools`G[0, 0, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*(k1 - k2 - k3)*k3) + 
   (7*PolyLogTools`G[0, 0, 0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 0, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   (7*PolyLogTools`G[0, 0, 0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (k1*k3*(k1 - k2 + k3)) - 
   (7*PolyLogTools`G[0, 0, 0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (k1*k3*(k1 + k2 + k3)) - 
   (7*PolyLogTools`G[0, 0, 0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
       (2*k3), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 0, 1, 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 0, 1, 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 0, 1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 0, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, 0, 1, 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 0, 1, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, 0, 1, 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k1*k3*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[0, 0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[0, 0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 0, 1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
     1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (k1*k3*(k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + 
      k3^2)*PolyLogTools`G[0, 0, -1/2*(k1 + k2 - k3)/k1, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) - 
   (2*(k1^2 - k1*k2 - 2*k2^2 - k1*k3 - 2*k2*k3)*PolyLogTools`G[0, 0, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, 0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(4*k1*k3^2) - 
   PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(4*k1*k3^2) + 
   PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   (3*PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 
      (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 - k2 - k3)*k3) + 
   ((-7*k1 + k2 + k3)*PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(4*k1^2*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 2 + (-k1 + k2 + k3)/(2*k1), 
     1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(4*k1^2*k3) + 
   PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 0, -1/2*(-k1 + k2 + k3)/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   ((-k1^2 - 2*k1*k2 + 3*k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, 0, -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   (3*k2*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 
      1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
   (3*(k1 - 3*k2 - k3)*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k1, 
      ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) - 
   (2*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 
      1])/(k1*k3*(k1 + k2 + k3)) + 
   (7*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k3, 
      ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 0, 1 - k3/k1, 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 0, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 0, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 0, (1 + k3/k1)^(-1), 1, 1]/(k3*(-k1 + k2 + k3)*
     (k1 + k2 + k3)) + PolyLogTools`G[0, 0, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k3*(-k1 + k2 + k3)*
     (k1 + k2 + k3)) + PolyLogTools`G[0, 0, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) + 
   (2*(2*k1*k2 + 2*k2^2 + k1*k3 + k2*k3 - k3^2)*PolyLogTools`G[0, 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   (3*PolyLogTools`G[0, 0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (3*PolyLogTools`G[0, 0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 - k2 + k3)) + 
   (3*PolyLogTools`G[0, 0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-2*k1)/(-k1 + k2 + k3), 1])/(k1*k3*(k1 - k2 + k3)) + 
   (3*PolyLogTools`G[0, 0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, 0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
   ((-k1^2 - 2*k1*k2 - k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, 0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
    (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
      k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) + 
   ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, 0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/
    (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
      k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) - 
   (3*PolyLogTools`G[0, 0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[0, 0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   ((3*k1 + k2 + k3)*PolyLogTools`G[0, 0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-5*k1 - k2 - k3)*PolyLogTools`G[0, 0, -(1 + (-k1 + k2 + k3)/(2*k1))^
        (-1), -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 0, 1 + (-k1 + k2 + k3)/(2*k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, 0, 
     (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k1*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
       (2*k3), -1/2*(k1 + k2 + k3)/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/
       (2*k1), -1/2*(k1 + k2 + k3)/k1, 1])/(2*k1*k3*(-k1 + k2 + k3)) + 
   (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
         (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
    (2*k1*k3*(-k1 + k2 + k3)) - 
   (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
       (2*k1), -1/2*(k1 + k2 + k3)/k1, 1])/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (k1*(k1 - k2 - k3)*k3) + 
   (2*PolyLogTools`G[0, 1, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, 1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   (2*PolyLogTools`G[0, 1, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/(k1*(k1 - k2 - k3)*k3) + 
   ((3*k1^2 - 4*k1*k2 - 7*k2^2 - 6*k1*k3 - 4*k2*k3 + 3*k3^2)*
     PolyLogTools`G[0, 1, 1, 2 + (k1 + k2 - k3)/(2*k3), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-3*k1^2 + 4*k1*k2 + 7*k2^2 + 6*k1*k3 + 4*k2*k3 - 3*k3^2)*
     PolyLogTools`G[0, 1, 1, (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((3*k1 - 7*k2 + 7*k3)*PolyLogTools`G[0, 1, 1, 
      ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
   (2*PolyLogTools`G[0, 1, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/(k1*(k1 - k2 - k3)*k3) + 
   ((3*k1^2 - 4*k1*k2 - 7*k2^2 - 6*k1*k3 - 4*k2*k3 + 3*k3^2)*
     PolyLogTools`G[0, 1, 1, 2 + (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-7*k1 + 7*k2 - 3*k3)*PolyLogTools`G[0, 1, 1, 
      (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)) + 
   ((-3*k1^2 + 4*k1*k2 + 7*k2^2 + 6*k1*k3 + 4*k2*k3 - 3*k3^2)*
     PolyLogTools`G[0, 1, 1, (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + PolyLogTools`G[0, 1, 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[0, 1, (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   (2*k2*PolyLogTools`G[0, 1, 1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 1, 2 + (k1 + k2 - k3)/(2*k3), 1, 1]/
    ((k1 - k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + k1*k2 + 2*k2^2 + 2*k1*k3 + k2*k3 - k3^2)*
     PolyLogTools`G[0, 1, 2 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((k1^2 - 4*k1*k2 - 5*k2^2 - 4*k1*k3 - 2*k2*k3 + 
      3*k3^2)*PolyLogTools`G[0, 1, 2 + (k1 + k2 - k3)/(2*k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 1, 2 + (k1 + k2 - k3)/(2*k3), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (2*k2*PolyLogTools`G[0, 1, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
       (1 + k1/k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1, 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 1, (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 1, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   (2*(-k2 + k3)*PolyLogTools`G[0, 1, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/
       k1, ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, 1, ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 1, ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, (-2*k3)/(k1 + k2 - k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 1, (-2*k3)/(k1 + k2 - k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 1, (-2*k3)/(k1 + k2 - k3), 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 1, (-2*k1)/(-k1 + k2 + k3), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 1, (-2*k1)/(-k1 + k2 + k3), 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, 1, (-2*k1)/(-k1 + k2 + k3), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 1, 1 - k3/k1, 1, 1]/
    (k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, 1, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, (1 + k3/k1)^(-1), 1, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, 1, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, 1, (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, 1, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, 1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*(k1 - k2 - k3)*k3) + 
   (2*k2*PolyLogTools`G[0, 1, 1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, 2 + (-k1 + k2 + k3)/(2*k1), 1, 1]/
    (k1*(k1 + k2 - k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 1, 2 + (-k1 + k2 + k3)/(2*k1), (-2*k1)/(-k1 + k2 + k3), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + k1*k2 + 2*k2^2 + 2*k1*k3 + k2*k3 - k3^2)*
     PolyLogTools`G[0, 1, 2 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((3*k1^2 - 2*k1*k2 - 5*k2^2 - 4*k1*k3 - 4*k2*k3 + 
      k3^2)*PolyLogTools`G[0, 1, 2 + (-k1 + k2 + k3)/(2*k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   (2*(k1 - k2)*PolyLogTools`G[0, 1, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/
       k3, (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, 1, (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, 1, (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, 1, (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (2*k2*PolyLogTools`G[0, 1, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1, (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1, 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 1, (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) - 
   PolyLogTools`G[0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (k1/k3 - (k1 + k2 - k3)/(2*k3))^
      (-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (-2*k3)/(k1 + k2 - k3), 1]/(k1*k3*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      1])/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^
       (-1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
     0, (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + k1*k2 + 2*k2^2 + 2*k1*k3 + k2*k3 - k3^2)*
     PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 1, 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((k1^2 - 4*k1*k2 - 5*k2^2 - 4*k1*k3 - 2*k2*k3 + 
      3*k3^2)*PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 1, 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 1, (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   ((-k1^2 - 2*k1*k2 - k2^2 + 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) - PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1, 1]/((k1 - k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + k3^2)*
     PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((-k1^2 + 4*k1*k2 + 5*k2^2 + 4*k1*k3 + 2*k2*k3 - 
      3*k3^2)*PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
       (1 + k1/k3), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 4*k1*k2 + 5*k2^2 + 4*k1*k3 + 2*k2*k3 - 3*k3^2)*
     PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
      (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), 1, 2 + (k1 + k2 - k3)/(2*k3), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), 1, 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), (-2*k3)/(k1 + k2 - k3), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), (-2*k3)/(k1 + k2 - k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), (-2*k3)/(k1 + k2 - k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 0, 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1, 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), (-2*k3)/(k1 + k2 - k3), 
     1]/(2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 
     0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   ((3*k1 + 3*k2 + k3)*PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 
      -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]/(k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   ((-3*k1 - 3*k2 + k3)*PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) - PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   ((-k1^2 - k1*k2 + 2*k2^2 - k1*k3 + 2*k2*k3)*PolyLogTools`G[0, 
      ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, 1])/(k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 - k1*k2 + 2*k2^2 - k1*k3 + 2*k2*k3)*PolyLogTools`G[0, 
      ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 - 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 - 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*(k1 - k2 - k3)*
     (k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 0, (-2*k3)/(k1 + k2 - k3), 1]/
    (k1*(k1 + k2 - k3)*k3) + ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - 
      k3^2)*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1, 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1, 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1 + 3*k2 - 3*k3)*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1, 
      ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) - 
   PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 2 + (k1 + k2 - k3)/(2*k3), 1, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   ((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + k3^2)*
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 2 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((-k1^2 + 4*k1*k2 + 5*k2^2 + 4*k1*k3 + 2*k2*k3 - 
      3*k3^2)*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
      2 + (k1 + k2 - k3)/(2*k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
       (1 + k1/k3), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) - PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (k1*(k1 + k2 - k3)*k3) + (2*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
      (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1])/
    (k1*(k1 + k2 - k3)*k3) + (5*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 0, 
      (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 0, 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   (2*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 0, 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1, 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((3*k1 - 3*k2 + k3)*PolyLogTools`G[0, 
      (-2*k1)/(-k1 + k2 + k3), 1, (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/
       k3, 1])/(k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1, 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   (5*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
      (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     2 + (-k1 + k2 + k3)/(2*k1), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   ((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + k3^2)*
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 2 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((-3*k1^2 + 2*k1*k2 + 5*k2^2 + 4*k1*k3 + 4*k2*k3 - 
      k3^2)*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
      2 + (-k1 + k2 + k3)/(2*k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + (2*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   ((-k1 - 3*k2 - 3*k3)*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 
      -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 - k2 + k3)) + 
   (k2*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 0, -1/2*(k1 + k2 + k3)/k1, 
      1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
   ((k1 - 3*k2 - k3)*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 0, 
      ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
   (k2*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 
      ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   ((k1 - 3*k2 - k3)*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 
      ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
   ((k1 + k2)*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 
      ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 0, -1/2*(k1 + k2 + k3)/k3, 
      1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 0, 
      ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1])/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 
     -1/2*(k1 + k2 + k3)/k3, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
      (2*k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 
      ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
      -1/2*(k1 + k2 + k3)/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 1 - k3/k1, 0, 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 1 - k3/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 1 - k3/k1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 1 - k3/k1, 1, 1, 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 1 - k3/k1, 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 1 - k3/k1, 1 - k3/k1, 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 1 - k3/k1, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 1 - k3/k1, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 1 - k3/k1, (1 + k3/k1)^(-1), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 1 - k3/k1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1 - k3/k1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     1]/(2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, 1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (2*PolyLogTools`G[0, (1 + k3/k1)^(-1), 0, 1, 1])/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, 1]/(k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[0, (1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[0, (1 + k3/k1)^(-1), 1, 1, 1])/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   (2*PolyLogTools`G[0, (1 + k3/k1)^(-1), 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), 1 - k3/k1, 1, 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 1, 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k3*(-k1 + k2 + k3)*
     (k1 + k2 + k3)) + PolyLogTools`G[0, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3) - 
   (3*PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   ((-k1 + 3*k2 + 3*k3)*PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
       k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3*
     (k1 + k2 + k3)) - PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-2*k1)/(-k1 + k2 + k3), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   (2*PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(k1*(k1 - k2 - k3)*k3) - 
   (2*PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   ((-2*k1*k2 - 2*k2^2 + k1*k3 + k2*k3 + k3^2)*PolyLogTools`G[0, 
      (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-2*k1*k2 - 2*k2^2 + k1*k3 + k2*k3 + k3^2)*PolyLogTools`G[0, 
      (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (2*PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      (-2*k1)/(-k1 + k2 + k3), 1])/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^
      (-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
   ((-k1^2 - 4*k1*k2 - 3*k2^2 - 2*k1*k3 + 4*k2*k3 - k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1, 1])/
    (2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) - 
   (2*k2*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1 - k2)*PolyLogTools`G[0, 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 + 4*k1*k2 + 3*k2^2 + 2*k1*k3 - 4*k2*k3 + k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) + 
   ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1, 1])/
    (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 - 2*k1*k2 - k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + 
   (k2*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 1, 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1 - k2)*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 1, 1])/
    (k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1 - k2)*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1 + k2)*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1 + k2)*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   (k2*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1 + k2)*PolyLogTools`G[0, 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 - 2*k1*k2 - k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
    (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
      k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) + 
   ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
      k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 - 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 - 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*
     (k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   (5*PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
     0, (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 1, (-2*k1)/(-k1 + k2 + k3), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + k1*k2 + 2*k2^2 + 2*k1*k3 + k2*k3 - k3^2)*
     PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 1, 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((3*k1^2 - 2*k1*k2 - 5*k2^2 - 4*k1*k3 - 4*k2*k3 + 
      k3^2)*PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 1, 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 - 2*k1*k2 - k2^2 + 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
     1, 1]/(k1*(k1 + k2 - k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   ((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + k3^2)*
     PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-3*k1^2 + 2*k1*k2 + 5*k2^2 + 4*k1*k3 + 4*k2*k3 - k3^2)*
     PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((-3*k1^2 + 2*k1*k2 + 5*k2^2 + 4*k1*k3 + 4*k2*k3 - 
      k3^2)*PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
      (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), 1, 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), 1, 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), 
     (-2*k1)/(-k1 + k2 + k3), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), 
     (-2*k1)/(-k1 + k2 + k3), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
     1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1, 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1, 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
    (2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, (-2*k1)/(-k1 + k2 + k3), 
     1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 0, 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1, 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 0, 
     -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 0, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
     -1/2*(k1 + k2 + k3)/k3, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
      (2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 0, 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   ((-k1 - 3*k2 - 3*k3)*PolyLogTools`G[0, 
      ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1])/
    (2*k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1 + 2*k2 + 2*k3)*PolyLogTools`G[0, 
      ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
       (2*k1), 1])/(k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1 - 3*k2 - 3*k3)*PolyLogTools`G[0, 
      ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, 1])/(2*k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1 + 2*k2 + 2*k3)*PolyLogTools`G[0, 
      ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
       (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
    (k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
        (2*k3)/(k1 + k2 + k3)))/(2*k1), 0, 
     ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
        (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
        (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) - 
   PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 0, 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   ((3*k1 + 3*k2 + k3)*PolyLogTools`G[0, 
      ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   (2*(2*k1 + 2*k2 + k3)*PolyLogTools`G[0, 
      ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
       (2*k1), 1])/(k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((3*k1 + 3*k2 + k3)*PolyLogTools`G[0, 
      ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 0, 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   (5*PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 0, 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(-k1 + k2 + k3)) - 
   (3*PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 0, 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^
        (-1), 1])/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) - 
   (3*PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
      (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^
       (-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1, 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1, 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     2 + (k1 + k2 - k3)/(2*k3), 1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     2 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     2 + (k1 + k2 - k3)/(2*k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
      (1 + k1/k3), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     2 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     2 + (k1 + k2 - k3)/(2*k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
      (1 + k1/k3), 1]/(k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     1 + (k1 + k2 - k3)/(2*k3), 1, 2 + (k1 + k2 - k3)/(2*k3), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     1 + (k1 + k2 - k3)/(2*k3), 1, (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
      (1 + k1/k3), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     1 + (k1 + k2 - k3)/(2*k3), 1 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
     1 + (k1 + k2 - k3)/(2*k3), (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
      (1 + k1/k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (k1*k3*(-k1 + k2 + k3)) - PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^
      (-1), 0, 0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   (3*PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 0, 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(k1 - k2 + k3)) + 
   (5*PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 0, 
      (-2*k3)/(k1 + k2 - k3), 1])/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (k1/k3 - (k1 + k2 - k3)/(2*k3))^
      (-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   (3*PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
      (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
    (k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^
      (-1), (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) - 
   (3*PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
      (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, (-2*k3)/(k1 + k2 - k3), 1])/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (k1/k3 - (k1 + k2 - k3)/(2*k3))^
      (-1), (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), 0, -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), 0, (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
     1]/(2*k1*k3*(k1 - k2 + k3)) + 
   (2*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 0, 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(k1*k3*(k1 + k2 + k3)) + 
   (5*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 0, 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 0, 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(k1*k3*(k1 + k2 + k3)) - 
   (5*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 0, 
      (-2*k3)/(k1 + k2 - k3), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
    (k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, (-2*k3)/(k1 + k2 - k3), 1]/
    (k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^
       (-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^
       (-1), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 0, (-2*k3)/(k1 + k2 - k3), 1]/
    (k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     0, -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     0, -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     0, (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^
       (-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1]/
    (k1*k3*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 1, 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 1, 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 
      1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 
      (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 
      (-2*k3)/(k1 + k2 - k3), 2 + (k1 + k2 - k3)/(2*k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 
      (-2*k3)/(k1 + k2 - k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
       (1 + k1/k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - 5*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 1, 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + 5*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 1, 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
      2 + (k1 + k2 - k3)/(2*k3), 1, 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 2 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 2 + (k1 + k2 - k3)/(2*k3), 
     (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
    (k1*k3*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
      2 + (k1 + k2 - k3)/(2*k3), (-2*k3)/(k1 + k2 - k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1, 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
      (-2*k3)/(k1 + k2 - k3), 2 + (k1 + k2 - k3)/(2*k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
      (-2*k3)/(k1 + k2 - k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
       (1 + k1/k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      1 + (k1 + k2 - k3)/(2*k3), 0, (-2*k3)/(k1 + k2 - k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      1 + (k1 + k2 - k3)/(2*k3), 1, 2 + (k1 + k2 - k3)/(2*k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      1 + (k1 + k2 - k3)/(2*k3), 1, (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
       (1 + k1/k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      1 + (k1 + k2 - k3)/(2*k3), 1, (-2*k3)/(k1 + k2 - k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + 3*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      1 + (k1 + k2 - k3)/(2*k3), 1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(2*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1, 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
      (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      1 + (k1 + k2 - k3)/(2*k3), (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
       (1 + k1/k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + 5*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1, 2 + (k1 + k2 - k3)/(2*k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - 5*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1, (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
       (1 + k1/k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1, 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) - PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
     2 + (k1 + k2 - k3)/(2*k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
      (1 + k1/k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
      (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
       (1 + k1/k3), 1, 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
       (1 + k1/k3), (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), (-2*k3)/(k1 + k2 - k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), (-2*k3)/(k1 + k2 - k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 0, 
      (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1, 
      (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - 5*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1, 1])/
    (4*k1*k3^2*(k1 + k2 + k3)) + 
   ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 0, 0, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 0, -1/2*(k1 + k2 - k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, -1/2*(k1 + k2 - k3)/k1, 0, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
   (2*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
      -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
    (k1*(k1 + k2 - k3)*k3) + (2*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
      -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
     ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
     ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 0, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     -1/2*(k1 + k2 - k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) + 
   (2*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
       k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 
     ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     -1/2*(k1 + k2 - k3)/k1, 0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 
     ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/
      k1, 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
     ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   (5*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 0, 
      -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (2*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 0, 
      -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(k1*(k1 + k2 - k3)*k3) - 
   (5*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 0, 
      -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (2*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 0, (-2*k3)/(k1 + k2 - k3), 
      1])/(k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, (-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 0, (-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     0, -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     0, -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, (-2*k3)/(k1 + k2 - k3), 1]/
    (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^
       (-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^
       (-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 0, (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 0, 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 0, 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 0, 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 0, 
     (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 
     -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
     -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
     -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
     (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (3*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 
      (-2*k3)/(k1 + k2 - k3), (-2*k3)/(k1 + k2 - k3), 1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (3*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 0, (-2*k1)/(-k1 + k2 + k3), 
      1])/(2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     0, 0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (2*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*(k1 - k2 - k3)*k3) - 
   (3*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 0, 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 - k2 - k3)*k3) + 
   (2*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 0, 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
    (k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
     (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]/(k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
      (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1])/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]/(k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, (-2*k1)/(-k1 + k2 + k3), 1]/
    (k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 - k2 - k3)*k3) - 
   (3*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (3*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 + k2 - k3)*k3) + 
   (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, -1/2*(-k1 + k2 + k3)/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 + k2 - k3)*k3) - 
   (3*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     1]/(2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 0, -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(k1*(k1 - k2 - k3)*k3) + 
   (5*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3) - 
   (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, -1/2*(-k1 + k2 + k3)/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 - k2 - k3)*k3) - 
   (3*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/k3, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) + 
   (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/k3, 
      -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*k3) - (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
      -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(k1*(k1 - k2 - k3)*k3) - 
   (3*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3) + 
   (3*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
     (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, 0, -1/2*(k1 + k2 + k3)/k3, 1]/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, 0, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, 
     -1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, 
     -1/2*(k1 + k2 + k3)/k3, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
      (2*k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
     -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 0, 
     -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 0, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
     -1/2*(k1 + k2 + k3)/k3, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
      (2*k3), -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 0, 
     -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 0, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
     ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
     -1/2*(k1 + k2 + k3)/k3, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
      (2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[1 - k3/k1, 0, 0, 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 0, 0, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 0, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 0, 1, 1, 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 0, 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 0, 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 0, 1 - k3/k1, 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 0, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 0, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 0, (1 + k3/k1)^(-1), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 0, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 0, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     1]/(2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 0, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 0, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - (2*PolyLogTools`G[1 - k3/k1, 1, 0, 1, 1])/
    (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1, 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   (2*PolyLogTools`G[1 - k3/k1, 1, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      1])/(k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   (2*PolyLogTools`G[1 - k3/k1, 1, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/(k1*(k1 + k2 - k3)*k3) + 
   (2*PolyLogTools`G[1 - k3/k1, 1, 1, 1, 1])/(k1*(k1 + k2 - k3)*k3) - 
   (2*PolyLogTools`G[1 - k3/k1, 1, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 1, 1 - k3/k1, 1, 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 1, 1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1, 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1, (1 + k3/k1)^(-1), 
     1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 0, 1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 1, 1, 1]/
    (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
     1 - k3/k1, 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
     (1 + k3/k1)^(-1), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 1 - k3/k1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 1 - k3/k1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     1]/(2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 0, 
     1, 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 1, 
     1, 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
     1 - k3/k1, 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
     (1 + k3/k1)^(-1), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (2*PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 + k2 - k3)*k3) + 
   (3*PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   (2*PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, -1 - (-k1 + k2 + k3)/(2*k1), 
      1])/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 + k2 - k3)*k3) - 
   (3*PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1, 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
     1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (1 + k3/k1)^(-1), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[(1 + k3/k1)^(-1), 0, 0, 1, 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 0, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*k3*(k1 + k2 + k3)) + 
   (2*PolyLogTools`G[(1 + k3/k1)^(-1), 0, 1, 1, 1])/(k1*k3*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[(1 + k3/k1)^(-1), 0, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, 1 - k3/k1, 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 0, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 0, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 0, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 0, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 1, 0, 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 1, 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, 1]/(k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1, 1, 1])/(k1*k3*(k1 + k2 + k3)) + 
   (2*PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1 - k3/k1, 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 1, 
     (1 + k3/k1)^(-1), 1, 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 0, 
     1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 1, 
     1, 1]/(k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     1 - k3/k1, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 1 - k3/k1, 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 
     1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 
     (1 + k3/k1)^(-1), 1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     1]/(2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
       (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     (1 + k3/k1)^(-1), 0, 1, 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     (1 + k3/k1)^(-1), 1, 1, 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     (1 + k3/k1)^(-1), 1 - k3/k1, 1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     (1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     (1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     (1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 0, -1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (2*PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, -1 - (-k1 + k2 + k3)/(2*k1), 
      1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1, 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1, 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
     1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (1 + k3/k1)^(-1), 1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(k1*k3*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
    (k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k1, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k1, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k3, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k3, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 0, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     -1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) + 
   (2*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   (3*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
    (k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (5*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      1])/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   (2*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (3*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, -1/2*(-k1 + k2 + k3)/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1, 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1, 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     2 + (-k1 + k2 + k3)/(2*k1), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     2 + (-k1 + k2 + k3)/(2*k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     2 + (-k1 + k2 + k3)/(2*k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1 + (-k1 + k2 + k3)/(2*k1), 1, 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1 + (-k1 + k2 + k3)/(2*k1), 1, (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1 + (-k1 + k2 + k3)/(2*k1), 1 + (-k1 + k2 + k3)/(2*k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
     1 + (-k1 + k2 + k3)/(2*k1), (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k1*(k1 + k2 - k3)*k3) + 
   (3*PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
      (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) - 
   (5*PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1])/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-2*k1)/(-k1 + k2 + k3), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^
      (-1), 0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^
      (-1), 0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) - 
   (3*PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-2*k1)/(-k1 + k2 + k3), 0, (-2*k1)/(-k1 + k2 + k3), 1])/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 0, -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^
      (-1), (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]/(2*k1*k3*(k1 - k2 + k3)) - 
   (2*PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, (-2*k1)/(-k1 + k2 + k3), 1])/
    (k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^
      (-1), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^
      (-1), (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 - k2 + k3)) + 
   ((-k1^2 - 4*k1*k2 - 3*k2^2 - 2*k1*k3 + 4*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 0, 1, 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1^2 - k2^2 + 2*k1*k3 + k3^2)) + 
   ((3*k1^3 - 15*k1^2*k2 - 3*k1*k2^2 + 15*k2^3 + 3*k1^2*k3 + 2*k1*k2*k3 + 
      3*k2^2*k3 - 3*k1*k3^2 - 15*k2*k3^2 - 3*k3^3)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-2*k1^3 - 9*k1^2*k2 + 2*k1*k2^2 + 9*k2^3 - 2*k1^2*k3 + 2*k1*k2*k3 - 
      2*k2^2*k3 + 2*k1*k3^2 - 9*k2*k3^2 + 2*k3^3)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-3*k1^3 + 15*k1^2*k2 + 3*k1*k2^2 - 15*k2^3 + 3*k1^2*k3 + 2*k1*k2*k3 + 
      3*k2^2*k3 + 3*k1*k3^2 + 15*k2*k3^2 - 3*k3^3)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 4*k1*k2 + 3*k2^2 + 2*k1*k3 - 4*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 4*k1*k2 + 3*k2^2 + 2*k1*k3 - 4*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1, 1, 1])/
    (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 - 4*k1*k2 - 3*k2^2 - 2*k1*k3 + 4*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^3 + 9*k1^2*k2 + k1*k2^2 - 9*k2^3 - k1^2*k3 + 2*k1*k2*k3 - k2^2*k3 + 
      k1*k3^2 + 9*k2*k3^2 + k3^3)*PolyLogTools`G[
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((3*k1^2*k2 - 3*k2^3 + 2*k1*k2*k3 + 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1 - k3/k1, 1, 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1 - k3/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1 - k3/k1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     0, (1 + k3/k1)^(-1), 1, 1]/(k3*(-k1 - k2 + k3)*(k1 - k2 + k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k3*(-k1 - k2 + k3)*(k1 - k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k3*(-k1 - k2 + k3)*
     (k1 - k2 + k3)) + ((k1^3 - 9*k1^2*k2 - k1*k2^2 + 9*k2^3 - k1^2*k3 + 
      2*k1*k2*k3 - k2^2*k3 - k1*k3^2 - 9*k2*k3^2 + k3^3)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 - 2*k1*k2 + 3*k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
      1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*
     (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) - 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     0, (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
     (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k3*(-k1 - k2 + k3)*(k1 - k2 + k3)) + 
   ((-k1^2 - 4*k1*k2 - 3*k2^2 - 2*k1*k3 + 4*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
    (2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) + 
   ((k1^2 + 4*k1*k2 + 3*k2^2 + 2*k1*k3 - 4*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) + 
   ((-3*k1^2*k2 + 3*k2^3 - 10*k1*k2*k3 - 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 0, 1, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-3*k1^2*k2 + 3*k2^3 - 2*k1*k2*k3 - 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) - 
   (2*(3*k1^2*k2 - 3*k2^3 + 2*k1*k2*k3 + 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((3*k1^2*k2 - 3*k2^3 - 2*k1*k2*k3 + 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((3*k1^2*k2 - 3*k2^3 + 10*k1*k2*k3 + 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + 
   (16*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1, 1, 1])/
    ((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
   (16*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-3*k1^2*k2 + 3*k2^3 - 2*k1*k2*k3 - 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1 - k3/k1, 1, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-3*k1^2*k2 + 3*k2^3 - 2*k1*k2*k3 - 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1 - k3/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((3*k1^2*k2 - 3*k2^3 + 2*k1*k2*k3 + 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1 - k3/k1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((3*k1^2*k2 - 3*k2^3 - 2*k1*k2*k3 + 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, (1 + k3/k1)^(-1), 1, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((3*k1^2*k2 - 3*k2^3 - 2*k1*k2*k3 + 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-3*k1^2*k2 + 3*k2^3 + 2*k1*k2*k3 - 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((3*k1^2*k2 - 3*k2^3 + 2*k1*k2*k3 + 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((3*k1^2*k2 - 3*k2^3 + 2*k1*k2*k3 + 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-3*k1^2*k2 + 3*k2^3 + 2*k1*k2*k3 - 3*k2*k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
   (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
    ((k1 + k2 + k3)*(k1^3 - k1^2*k2 - k1*k2^2 + k2^3 - k1^2*k3 + 2*k1*k2*k3 - 
      k2^2*k3 - k1*k3^2 - k2*k3^2 + k3^3)) + 
   (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/((k1 - k2 - k3)*(k1 + k2 + k3)*(k1^2 - k2^2 + 2*k2*k3 - k3^2)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k1, 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k1, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k1, 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 - 2*k1*k2 + 3*k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 - 2*k1*k2 + 3*k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 0, 1, 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 1, 1, 1])/
    (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 1 - k3/k1, 1, 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 1 - k3/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 1 - k3/k1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, (1 + k3/k1)^(-1), 
      1, 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), -1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 0, 1, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*
     (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 1, 1, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 1 - k3/k1, 
      1, 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 1 - k3/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 1 - k3/k1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (1 + k3/k1)^(-1), 1, 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
      1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*
     (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*
     (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, -1 - (-k1 + k2 + k3)/(2*k1), 
      1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*
     (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*
     (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^3 + 6*k1^2*k2 + k1*k2^2 - 6*k2^3 - k1^2*k3 - k2^2*k3 + k1*k3^2 + 
      6*k2*k3^2 + k3^3)*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, -1 - (-k1 + k2 + k3)/(2*k1), 
      1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1^3 + 6*k1^2*k2 - k1*k2^2 - 6*k2^3 + k1^2*k3 + 
      k2^2*k3 - k1*k3^2 + 6*k2*k3^2 - k3^3)*PolyLogTools`G[
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^3 - 6*k1^2*k2 - k1*k2^2 + 6*k2^3 - k1^2*k3 - k2^2*k3 - k1*k3^2 - 
      6*k2*k3^2 + k3^3)*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 - 2*k1*k2 + 3*k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((-k1^2 - 4*k1*k2 - 3*k2^2 - 2*k1*k3 + 4*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1, 1])/
    (2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 - 2*k1*k2 + 3*k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 + 4*k1*k2 + 3*k2^2 + 2*k1*k3 - 4*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) - 
   (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1, 1])/
    ((k1 + k2 + k3)*(k1^3 - k1^2*k2 - k1*k2^2 + k2^3 - k1^2*k3 + 2*k1*k2*k3 - 
      k2^2*k3 - k1*k3^2 - k2*k3^2 + k3^3)) + 
   (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/((k1 - k2 - k3)*(k1 + k2 + k3)*(k1^2 - k2^2 + 2*k2*k3 - k3^2)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
    (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      1, 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (1 + k3/k1)^(-1), 1, 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
    (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) - 
   (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 
     (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     -1/2*(-k1 + k2 + k3)/k3, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 
     (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
     (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   (2*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
      (-2*k1)/(-k1 + k2 + k3), 1])/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (2*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(k1*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 0, 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
    (k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 0, (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 0, -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 0, -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, (-2*k1)/(-k1 + k2 + k3), 1]/
    (k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, (-2*k1)/(-k1 + k2 + k3), 
     1]/(k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   (3*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
    (2*k1*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 1, 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 1, 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 
      (-2*k1)/(-k1 + k2 + k3), 2 + (-k1 + k2 + k3)/(2*k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 
      (-2*k1)/(-k1 + k2 + k3), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 
      1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 
      (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-5*k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 1, 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((5*k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 1, 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
      (-2*k1)/(-k1 + k2 + k3), 2 + (-k1 + k2 + k3)/(2*k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
      (-2*k1)/(-k1 + k2 + k3), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
      2 + (-k1 + k2 + k3)/(2*k1), 1, 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
      2 + (-k1 + k2 + k3)/(2*k1), (-2*k1)/(-k1 + k2 + k3), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
     1, 2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
     2 + (-k1 + k2 + k3)/(2*k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
      (1 + k3/k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1, 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), 0, (-2*k1)/(-k1 + k2 + k3), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), 1, (-2*k1)/(-k1 + k2 + k3), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), 1, 2 + (-k1 + k2 + k3)/(2*k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), 1, (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((3*k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), 1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(2*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1, 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
      (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      1 + (-k1 + k2 + k3)/(2*k1), (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((5*k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 1, 2 + (-k1 + k2 + k3)/(2*k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-5*k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 1, (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), (-2*k1)/(-k1 + k2 + k3), 
      2 + (-k1 + k2 + k3)/(2*k1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), (-2*k1)/(-k1 + k2 + k3), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1, 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
      (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) - 
   PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
    (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
     2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
     (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
    (k1*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1, 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 0, 
      (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1, 
      (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-5*k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1, 1])/
    (4*k1^2*k3*(k1 + k2 + k3)) + 
   ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
   (3*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
      1, ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1])/
    (k1*k3*(k1 - k2 + k3)) + 
   (3*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
      1, ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1])/
    (k1*k3*(k1 - k2 + k3)) - 
   (3*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
      1, (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
       ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1])/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1, 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   (2*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
      ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
       ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1])/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
     ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
     ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 
     (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 0, 
     -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 0, 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 0, 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 0, 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 0, -1/2*(k1 + k2 + k3)/k1, 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 0, 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 0, 
     -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 0, 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 0, 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 0, -1/2*(k1 + k2 + k3)/k1, 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, 0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 
     ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
      (2*k1), -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 0, 
     -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
     -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
      (2*k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
   (3*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
      1, ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1])/
    (k1*k3*(k1 - k2 + k3)) - 
   (3*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
      1, ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1])/
    (k1*k3*(k1 - k2 + k3)) + 
   (3*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
      1, (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
       ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1])/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1, 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   (2*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
      ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
       ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1])/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 
     (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
    (k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
     (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
     ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
    (k1*k3*(k1 - k2 + k3)) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
      ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
     ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
    (2*k1*k3*(k1 - k2 + k3)) - 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
     ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
    (k1*k3*(k1 - k2 + k3)) + (PolyLogTools`G[0, 1, 2 + (k1 + k2 - k3)/(2*k3), 
      1]*(-11 - 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]*
     (-11 - 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]*
     (-11 - 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]*
     (-11 - 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1]*(-11 - 2*Log[k1/k3]))/
    (4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
      2 + (k1 + k2 - k3)/(2*k3), 1]*(-11 - 2*Log[k1/k3]))/
    (4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, 1, ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
     (-9 - 2*Log[k1/k3]))/(4*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
      ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*(9 + 2*Log[k1/k3]))/
    (4*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
      ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*(9 + 2*Log[k1/k3]))/
    (4*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[0, 1, (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]*
     (11 + 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
      1]*(11 + 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 2 + (k1 + k2 - k3)/(2*k3), 1]*
     (11 + 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 2 + (k1 + k2 - k3)/(2*k3), 
      1]*(11 + 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]*
     (11 + 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
      (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
      (2 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]*
     (11 + 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
   PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1]*
    (PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*(-11 - 2*Log[k1/k3]))/
      (4*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*(11 + 2*Log[k1/k3]))/
      (4*k1*k3*(k1 + k2 + k3))) + 
   (PolyLogTools`G[0, 1, 2 + (-k1 + k2 + k3)/(2*k1), 1]*(-11 - 2*Log[k3/k1]))/
    (4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*
     (-11 - 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*
     (-11 - 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*
     (-11 - 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 1]*(-11 - 2*Log[k3/k1]))/
    (4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
      2 + (-k1 + k2 + k3)/(2*k1), 1]*(-11 - 2*Log[k3/k1]))/
    (4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
      (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]*(-9 - 2*Log[k3/k1]))/
    (4*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]*(-9 - 2*Log[k3/k1]))/
    (4*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
     (-EulerGamma - 2*Log[k3/k1]))/(2*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
     (-EulerGamma - 2*Log[k3/k1]))/(2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*(EulerGamma - 2*Log[k3/k1]))/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (PolyLogTools`G[0, 0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
     Log[k3/k1])/(k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[0, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (PolyLogTools`G[0, 0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
     Log[k3/k1])/(k1*k3*(k1 - k2 + k3)) + 
   (PolyLogTools`G[0, 0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
    (k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (k1*(k1 - k2 - k3)*k3) + (PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[0, 1 - k3/k1, 1, 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[0, 1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[0, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) - (PolyLogTools`G[0, (1 + k3/k1)^(-1), 1, 1]*
     Log[k3/k1])/(k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   (PolyLogTools`G[0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
   (PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
    (k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*(k1 - k2 - k3)*k3) - 
   (PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
    (k1*k3*(k1 - k2 + k3)) + ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + 
      k3^2)*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]*Log[k3/k1])/
    (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
      k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) - 
   ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
      k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 
      1]*Log[k3/k1])/(k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
      -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*(k1 - k2 - k3)*k3) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*k3) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*(k1 - k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, 0, 1, 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[1 - k3/k1, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) + (PolyLogTools`G[1 - k3/k1, 1, 1, 1]*
     Log[k3/k1])/(k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 1, 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[1 - k3/k1, 1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]*
     Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 1, 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
      -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]*
     Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3) + (PolyLogTools`G[(1 + k3/k1)^(-1), 0, 1, 1]*
     Log[k3/k1])/(k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
       k3, 1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[(1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (k1*k3*(k1 + k2 + k3)) - (PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1, 1]*
     Log[k3/k1])/(k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 1, 
      1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
      1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 1, 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*
     Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]*
     Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
     Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 
      1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*k3*(k1 + k2 + k3)) - 
   (PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
    (k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
    (k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
    (k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      (-2*k1)/(-k1 + k2 + k3), 1]*Log[k3/k1])/(k1*k3*(k1 - k2 + k3)) - 
   (PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
    (k1*k3*(k1 - k2 + k3)) - 
   (PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
      (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]*
     Log[k3/k1])/(k1*k3*(k1 - k2 + k3)) - 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1, 1]*Log[k3/k1])/
    ((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
   (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*
     Log[k3/k1])/((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) - 
   ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 1, 1]*Log[k3/k1])/
    (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3*
     (k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*
     Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 1, 1]*
     Log[k3/k1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*
     Log[k3/k1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1]*
     Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
   ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
      (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*Log[k3/k1])/
    (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
   ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*Log[k3/k1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
     (k1 + k2 + k3)) - 
   (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]*
     Log[k3/k1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + 
     k3^4) + (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*
     Log[k3/k1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + 
     k3^4) + (PolyLogTools`G[0, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
     (-EulerGamma + Log[k3/k1]))/(2*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[0, 1, (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
     (9 + 2*Log[k3/k1]))/(4*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[0, 1, (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*
     (11 + 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 2 + (-k1 + k2 + k3)/(2*k1), 1]*
     (11 + 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
      1]*(11 + 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 2 + (-k1 + k2 + k3)/(2*k1), 
      1]*(11 + 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*
     (11 + 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
      (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
      (2 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*
     (11 + 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
      -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
     (-EulerGamma + 2*Log[k3/k1]))/(2*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
     (-EulerGamma + 2*Log[k3/k1]))/(2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, (-2*k1)/(-k1 + k2 + k3), 1]*
     (EulerGamma + 2*Log[k3/k1]))/(2*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*(EulerGamma + 2*Log[k3/k1]))/
    (2*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
      -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*(-11 + 4*Log[k3/k1]))/
    (4*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]*
     (-9 + 4*Log[k3/k1]))/(4*k1*(k1 - k2 - k3)*k3) + 
   (PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 1]*
     (-k1 + k2 + k3 + 4*k3*Log[k3/k1]))/(4*k1*(k1 - k2 - k3)*k3^2) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*
     (-(k1^2*Log[k3/k1]) - 4*k1*k2*Log[k3/k1] - 3*k2^2*Log[k3/k1] - 
      2*k1*k3*Log[k3/k1] + 4*k2*k3*Log[k3/k1] - k3^2*Log[k3/k1]))/
    (2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1, 1]*
     (k1^2*Log[k3/k1] + 4*k1*k2*Log[k3/k1] + 3*k2^2*Log[k3/k1] + 
      2*k1*k3*Log[k3/k1] - 4*k2*k3*Log[k3/k1] + k3^2*Log[k3/k1]))/
    (2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 1]*
    ((PolyLogTools`G[-(-1 + k3/k1)^(-1), 1]*PolyLogTools`G[0, 
        (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1]*
      (-(PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/(k1*(k1 - k2 - k3)*
          k3)) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
         (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*
         k3)) + (EulerGamma*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^
        (-1), (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     (PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]*
       (EulerGamma - Log[k3/k1]))/(2*k1*(k1 - k2 - k3)*k3) - 
     (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]*Log[k3/k1])/
      (k1*(k1 - k2 - k3)*k3)) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 1]*
    ((-2*PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 1])/
      (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]*Log[k3/k1])/
      (k1*(k1 + k2 - k3)*k3) + (PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
        (-2*k1)/(-k1 + k2 + k3), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]*
    ((2*PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 1])/
      (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]*Log[k3/k1])/
      (k1*k3*(k1 + k2 + k3)) - (PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
        (-2*k1)/(-k1 + k2 + k3), 1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
     1]*(PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 
       1]*(PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
      ((11*PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/
           (-k1 + k2 + k3), 1])/(4*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1, 
         1]/(2*k1*k3*(k1 - k2 + k3))) - 
     (16*k2*PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 1])/
      (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) - 
     (8*k2*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
        (-2*k1)/(-k1 + k2 + k3), 1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 
       2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) - 
     (4*k2*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
        (-2*k1)/(-k1 + k2 + k3), 1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 
       2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) + 
     (8*k2*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]*Log[k3/k1])/
      (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) + 
     (4*k2*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 
        1]*Log[k3/k1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 
       2*k2^2*k3^2 + k3^4)) + 
   (PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*(Pi^2 - 3*Log[k3/k1]^2))/
    (12*k1*(k1 + k2 - k3)*k3) + (PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1]*
     (Pi^2 - 3*Log[k3/k1]^2))/(12*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (1 + k3/k1), 1]*(Pi^2 - 3*Log[k3/k1]^2))/(12*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[1 - k3/k1, 1, 1]*(-Pi^2 + 3*Log[k3/k1]^2))/
    (12*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]*
     (-Pi^2 + 3*Log[k3/k1]^2))/(12*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*(-Pi^2 + 3*Log[k3/k1]^2))/
    (12*k1*k3*(k1 + k2 + k3)) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
      (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*(-Pi^2 + 3*Log[k3/k1]^2))/
    (12*k1*k3*(k1 + k2 + k3)) - 
   (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]*
     (k2*Pi^2 - 3*k2*Log[k3/k1]^2))/(3*(k1^4 - 2*k1^2*k2^2 + k2^4 - 
      2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4)) + 
   (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*
     (k2*Pi^2 - 3*k2*Log[k3/k1]^2))/(3*(k1^4 - 2*k1^2*k2^2 + k2^4 - 
      2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4)) + 
   (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]*
     (k1*Sqrt[k3]*Pi^2 - k2*Sqrt[k3]*Pi^2 - k3^(3/2)*Pi^2 + 
      3*k1^(3/2)*Sqrt[k3/k1]*Pi^2 + 3*Sqrt[k1]*k2*Sqrt[k3/k1]*Pi^2 - 
      3*Sqrt[k1]*k3*Sqrt[k3/k1]*Pi^2 - 3*k1*Sqrt[k3]*Log[k3/k1]^2 + 
      3*k2*Sqrt[k3]*Log[k3/k1]^2 + 3*k3^(3/2)*Log[k3/k1]^2))/
    (12*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3^(3/2)) + 
   PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1]*
    (PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^
         (-1), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*(-11 - 2*Log[k3/k1]))/
      (4*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*(11 + 2*Log[k3/k1]))/
      (4*k1*k3*(k1 + k2 + k3))) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1]*
    (((11 - 2*EulerGamma)*PolyLogTools`G[0, 
        (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(4*k1*k3*(k1 + k2 + k3)) + 
     ((11 - 2*EulerGamma)*PolyLogTools`G[0, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(4*k1*(k1 - k2 - k3)*k3) + 
     (11*PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*(k1 + k2 - k3)*k3) + 
     (11*PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*k3*(k1 - k2 + k3)) - 
     (EulerGamma*PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
        -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(2*k1*(k1 - k2 - k3)*
       k3) + ((-11 + 2*EulerGamma)*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(4*k1*(k1 - k2 - k3)*k3) + 
     ((-11 + 2*EulerGamma)*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
         k3, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]*
      (-1/2*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
          (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
         (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
         -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
      (PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
        (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
        (2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
         (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
         -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
      (-1/12*Pi^2/(k1*(k1 + k2 - k3)*k3) + 
       ((-11 + 2*EulerGamma)*PolyLogTools`G[
          (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
        (4*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
         1]/(2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 
         (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 
         1 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
         1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
         (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
        (2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
         1 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
      (PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
        (k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[
         (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
        (k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[
         (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
      ((Sqrt[k3]*Pi^2 - 3*Sqrt[k1]*Sqrt[k3/k1]*Pi^2)/(12*k1*(k1 + k2 - k3)*
         k3^(3/2)) + (11*PolyLogTools`G[
          (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
        (4*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
         1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 
         (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 + k2 - k3)*k3) + ((-2*k1*k2 - 2*k2^2 + k1*k3 + k2*k3 + 
          k3^2)*PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/
           k3, 1])/(k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
       PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
         1]/(2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
         1]/(2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
         (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
        (2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
        (2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
      ((Sqrt[k3]*Pi^2 - 3*Sqrt[k1]*Sqrt[k3/k1]*Pi^2)/(12*k1*k3^(3/2)*
         (k1 - k2 + k3)) + (11*PolyLogTools`G[
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
        (4*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
         1]/(2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, 
         (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 
         (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*k3*(k1 - k2 + k3)) + ((k1^2 + k1*k2 - 2*k2^2 - 2*k1*k3 + 
          k2*k3 + k3^2)*PolyLogTools`G[0, 
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
        (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
         (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*
         k3) + PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*
         k3) + PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
        (2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
      (-(PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
         (k1*k3*(k1 + k2 + k3))) - 
       PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
        (2*k1*k3*(k1 + k2 + k3))) - 
     (EulerGamma*PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 0, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, 0, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*(k1 + k2 - k3)*k3) + ((-k1 - 3*k2 + 3*k3)*PolyLogTools`G[0, 0, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, 0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, 1, 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 1, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 1, 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 2 + (-k1 + k2 + k3)/(2*k1), 
       1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     ((-2*k1*k2 - 2*k2^2 + k1*k3 + k2*k3 + k3^2)*PolyLogTools`G[0, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + ((k1^2 + k1*k2 - 2*k2^2 - 2*k1*k3 + k2*k3 + 
        k3^2)*PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 0, 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
      (k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       (-2*k1)/(-k1 + k2 + k3), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^
         (-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^
         (-1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]*Log[k3/k1])/
      (k1*(k1 - k2 - k3)*k3) - 
     (PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
       Log[k3/k1])/(k1*(k1 + k2 - k3)*k3) - 
     (PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
      (k1*k3*(k1 - k2 + k3)) + 
     (PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
      (k1*k3*(k1 + k2 + k3)) - 
     (PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
      (k1*(k1 + k2 - k3)*k3) - 
     (PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
        (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*Log[k3/k1])/
      (k1*k3*(k1 - k2 + k3)) + (PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 
        (-2*k1)/(-k1 + k2 + k3), 1]*(EulerGamma + 2*Log[k3/k1]))/
      (2*k1*(k1 - k2 - k3)*k3) + 
     (PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*(EulerGamma + 2*Log[k3/k1]))/
      (2*k1*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    (PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - (2*(k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - 
        k2*k3 + k3^2)*PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
        1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     (-2*EulerGamma^2 + Pi^2 - 2*Log[k3/k1]^2)/(8*k1*(k1 - k2 - k3)*k3)) + 
   PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
      k3, 1]*(-1/2*PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
       (k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     (2*EulerGamma^2 - Pi^2 + 2*Log[k3/k1]^2)/(8*k1*(k1 - k2 - k3)*k3)) + 
   PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
      (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*
    (PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + (-Pi^2 + 3*Log[k3/k1]^2)/
      (12*k1*(k1 - k2 - k3)*k3)) + 
   (PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, 1]*Log[(2*k1)/(k1 + k2 + k3)])/
    (2*k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]*
     Log[(2*k1)/(k1 + k2 + k3)])/(2*k1*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
       (2*k1), 1]*Log[(2*k1)/(k1 + k2 + k3)])/(k1*(k1 + k2 - k3)*k3) - 
   (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, 1]*Log[(2*k1)/(k1 + k2 + k3)])/
    (2*k1*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
    (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]*
      (Pi^2/(6*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[0, (2*k3)/(k1 + k2 + k3), 1]/(k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[0, (2*k3)/((k1 + k2 + k3)*
           (-1 + (2*k3)/(k1 + k2 + k3))), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]/
        (2*k1*(k1 + k2 - k3)*k3)) + 
     (3*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k3, 1])/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 0, 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1]*
       Log[(2*k1)/(k1 + k2 + k3)])/(2*k1*(k1 + k2 - k3)*k3) + 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
        -1/2*(k1 + k2 + k3)/k3, 1]*Log[(2*k1)/(k1 + k2 + k3)])/
      (2*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]*
    ((PolyLogTools`G[((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
        1, 1])/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]*
      (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1]/((k1 + k2 - k3)*k3*
         (k1 - k2 + k3)) + ((-k1 - k3)*PolyLogTools`G[0, 
          ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
        (k1*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
       ((-2*k1 - 2*k2 - k3)*PolyLogTools`G[0, 
          ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
        (k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
        (2*k1*k3*(k1 - k2 + k3)) + ((k1 + k3)*PolyLogTools`G[
          -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*
            (-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/(k1*k3*(k1 - k2 + k3)*
         (k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
         ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
         -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
         ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*(k1 + k2 - k3)*k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
      (-1/2*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*
            (-1 + (2*k1)/(k1 + k2 + k3))), (1 + (2*k1)/(k1 + k2 + k3) - 
            (2*k3)/(k1 + k2 + k3))/((2*k1)/(k1 + k2 + k3) - 
            (2*k3)/(k1 + k2 + k3)), 1]/(k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         1, 1]/(k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
          ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     (3*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k1, 1])/
      (2*k1*(k1 + k2 - k3)*k3) + 
     (3*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k3, 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
         (2*k3), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
     (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
         (2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*(k1 + k2 - k3)*k3) + ((k1 + k2)*PolyLogTools`G[0, 
        -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
         (2*k1), 1])/(k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 1]/
      (k1*k3*(k1 + k2 + k3)) + (3*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 
        ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     ((-5*k1 - 5*k2 - 3*k3)*PolyLogTools`G[0, 
        ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
        -1/2*(k1 + k2 + k3)/k1, 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((3*k1 + 3*k2 + k3)*PolyLogTools`G[0, 
        ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
        ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, 
       ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       -1/2*(k1 + k2 + k3)/k3, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
        (2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 0, 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 0, 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (k1*k3*(k1 - k2 + k3)) - (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1]*
       Log[(2*k1)/(k1 + k2 + k3)])/(2*k1*(k1 + k2 - k3)*k3) + 
     (PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
        1]*Log[(2*k1)/(k1 + k2 + k3)])/(2*k1*(k1 + k2 - k3)*k3) + 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
        -1/2*(k1 + k2 + k3)/k1, 1]*Log[(2*k1)/(k1 + k2 + k3)])/
      (2*k1*(k1 + k2 - k3)*k3) - 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
        ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
       Log[(2*k1)/(k1 + k2 + k3)])/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
      (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*
         k3) - PolyLogTools`G[0, ((k1 + k2 + k3)*
           (-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/(2*k1*(k1 + k2 - k3)*
         k3) - PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
          (2*k3), -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*(k1 + k2 - k3)*k3) + 
       (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
          1]*Log[(2*k1)/(k1 + k2 + k3)])/(2*k1*(k1 + k2 - k3)*k3))) + 
   (PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, 1]*Log[(2*k3)/(k1 + k2 + k3)])/
    (2*k1*k3*(-k1 + k2 + k3)) - 
   (PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
         (2*k3)/(k1 + k2 + k3)))/(2*k1), 
      ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
     Log[(2*k3)/(k1 + k2 + k3)])/(2*k1*k3*(-k1 + k2 + k3)) - 
   (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]*
     Log[(2*k3)/(k1 + k2 + k3)])/(2*k1*k3*(-k1 + k2 + k3)) + 
   (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
       (2*k1), 1]*Log[(2*k3)/(k1 + k2 + k3)])/(2*k1*k3*(-k1 + k2 + k3)) - 
   (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      -1/2*(k1 + k2 + k3)/k1, 1]*Log[(2*k3)/(k1 + k2 + k3)])/
    (2*k1*k3*(-k1 + k2 + k3)) + 
   (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
      ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
       (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
     Log[(2*k3)/(k1 + k2 + k3)])/(2*k1*k3*(-k1 + k2 + k3)) + 
   (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 
      ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
     (-2*k1*Log[(2*k1)/(k1 + k2 + k3)] + 2*k2*Log[(2*k1)/(k1 + k2 + k3)] + 
      2*k3*Log[(2*k1)/(k1 + k2 + k3)] + k1*Log[(2*k3)/(k1 + k2 + k3)] + 
      k2*Log[(2*k3)/(k1 + k2 + k3)] - k3*Log[(2*k3)/(k1 + k2 + k3)]))/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
   (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]*
     (k1*Log[(2*k1)/(k1 + k2 + k3)] - k2*Log[(2*k1)/(k1 + k2 + k3)] - 
      k3*Log[(2*k1)/(k1 + k2 + k3)] - k1*Log[(2*k3)/(k1 + k2 + k3)] - 
      k2*Log[(2*k3)/(k1 + k2 + k3)] + k3*Log[(2*k3)/(k1 + k2 + k3)]))/
    (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
   PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
    (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]*
      (Pi^2/(6*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[0, (2*k1)/(k1 + k2 + k3), 1]/(k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[0, (2*k1)/((k1 + k2 + k3)*
           (-1 + (2*k1)/(k1 + k2 + k3))), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         (2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]/
        (2*k1*k3*(-k1 + k2 + k3))) + 
     (3*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k3, 1])/
      (2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 0, 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, -1/2*(k1 + k2 + k3)/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1]*
       Log[(2*k3)/(k1 + k2 + k3)])/(2*k1*k3*(-k1 + k2 + k3)) + 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
        -1/2*(k1 + k2 + k3)/k3, 1]*Log[(2*k3)/(k1 + k2 + k3)])/
      (2*k1*k3*(-k1 + k2 + k3))) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 1]*
    (-1/2*(PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/
          (2*k1), 1]*PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*
           (-1 + (2*k1)/(k1 + k2 + k3))), 1, 1])/(k1*k3*(k1 - k2 + k3)) + 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]*
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
        ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1])/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]*
      (-1/4*(Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k1 + k2 + k3]*Pi^2)/
         (k1^(3/2)*(k1 - k2 - k3)*k3) + 
       ((-k2 - k3)*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1])/
        (k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
            (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
        (2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
         -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
            (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 1]*
      (-1/12*Pi^2/(k1*k3*(k1 + k2 + k3)) + 
       (PolyLogTools`G[(2*k3)/(k1 + k2 + k3), 1]*PolyLogTools`G[
          (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1])/
        (2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         1]*(PolyLogTools`G[(2*k1)/(k1 + k2 + k3), 1]/
          (2*k1*k3*(k1 + k2 + k3)) - 
         (k2*PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + 
                 k3))), 1])/(k1*k3*(k1 - k2 + k3)*(k1 + k2 + k3))) + 
       (PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
          1]*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
           (2*k3), 1])/(2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[0, (2*k1)/(k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[0, (2*k3)/(k1 + k2 + k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         (2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]/
        (2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         (2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]/
        (2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         1, 1]/(2*k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
      (PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
          ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
          ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]*
      ((Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k1 + k2 + k3]*Pi^2)/
        (4*k1^(3/2)*(k1 + k2 - k3)*k3) + 
       ((3*k1 + 3*k2 + k3)*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1])/
        (2*k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
        (2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
          ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
         ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
         -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
          ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1]/
        (2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
         ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     ((2*k1^2 - 3*k1*k2 - 5*k2^2 - k1*k3 - 6*k2*k3 - k3^2)*
       PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
           (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/(2*k1*k3*(-k1 + k2 + k3)) + 
     ((k1^2 + 2*k1*k2 + k2^2 - 2*k1*k3 + 2*k2*k3 + k3^2)*
       PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((k1 - 3*k2 - k3)*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 
        ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
     ((k1 + 2*k2 + 2*k3)*PolyLogTools`G[0, 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
        -1/2*(k1 + k2 + k3)/k1, 1])/(k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((k1 + 2*k2 + 2*k3)*PolyLogTools`G[0, 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
         (2*k1), 1])/(k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
          (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) - (2*(2*k1 + 2*k2 + k3)*
       PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/
         (2*k1), -1/2*(k1 + k2 + k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 0, 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 0, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 0, 
       -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3)))/(2*k1), 
        -1/2*(k1 + k2 + k3)/k1, 1]*Log[(2*k1)/(k1 + k2 + k3)])/
      (k1*(k1 + k2 - k3)*k3) - 
     (PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
           (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*Log[(2*k3)/(k1 + k2 + k3)])/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
        -1/2*(k1 + k2 + k3)/k1, 1]*Log[(2*k3)/(k1 + k2 + k3)])/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
         (2*k1), 1]*Log[(2*k3)/(k1 + k2 + k3)])/(2*k1*k3*(-k1 + k2 + k3)) + 
     (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1]*
       (-2*k1*Log[(2*k1)/(k1 + k2 + k3)] + 2*k2*Log[(2*k1)/(k1 + k2 + k3)] + 
        2*k3*Log[(2*k1)/(k1 + k2 + k3)] + k1*Log[(2*k3)/(k1 + k2 + k3)] + 
        k2*Log[(2*k3)/(k1 + k2 + k3)] - k3*Log[(2*k3)/(k1 + k2 + k3)]))/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(2*k1)/((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3))), 1]*
    (PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1]*
      (-1/2*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1]/
         (k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 
         1]/(2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
          (2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
          (2*k1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
        (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
         ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
         -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
         ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 + k2 + k3))) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]*
      (((k1 + 2*k2 + 2*k3)*PolyLogTools`G[0, 
          ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1])/
        (k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
          (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
            (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
         ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
            (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3)) + 
     PolyLogTools`G[(2*k1)/(k1 + k2 + k3), 1]*
      ((PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
          1]*PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/
           (2*k3), 1])/(k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 1]/
        (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
        (k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, 
         ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
            (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/(k1*k3*(-k1 + k2 + k3)) - 
       PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
        (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
         ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
        (k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
            (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/(k1*(k1 - k2 - k3)*k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*
      (PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         1, 1]/(k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
        (2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
         ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     (3*PolyLogTools`G[0, 0, -1/2*(k1 + k2 + k3)/k3, 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
         (2*k3), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
     (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/
         (2*k1), 1])/(2*k1*k3*(-k1 + k2 + k3)) + 
     (3*PolyLogTools`G[0, 0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
           (2*k3)/(k1 + k2 + k3)))/(2*k1), 1])/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) - PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 
       -1/2*(k1 + k2 + k3)/k3, 1]/(k1*k3*(k1 + k2 + k3)) + 
     (3*PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 
        ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     ((-k1 - 3*k2 - 3*k3)*PolyLogTools`G[0, 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1])/
      (2*k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((k1 + 2*k2 + 2*k3)*PolyLogTools`G[0, 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
         (2*k1), 1])/(k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
          (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
          (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k1, 
       ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, -1/2*(k1 + k2 + k3)/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 0, 
       ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       -1/2*(k1 + k2 + k3)/k3, ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/
        (2*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 + k3)/k3, 
       ((k1 + k2 + k3)*(-1 - (2*k1)/(k1 + k2 + k3)))/(2*k3), 
       -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 0, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 0, 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, -1/2*(k1 + k2 + k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       -1/2*(k1 + k2 + k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
        (2*k1), ((k1 + k2 + k3)*(-1 - (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1, 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1, 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 1, 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/((k1 + k2 + k3)*(-1 + (2*k3)/(k1 + k2 + k3))), 
       ((k1 + k2 + k3)*(1 + (2*k3)/(k1 + k2 + k3)))/(2*k3), 
       (1 + (2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3))/
        ((2*k1)/(k1 + k2 + k3) + (2*k3)/(k1 + k2 + k3)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     (PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
        1]*Log[(2*k3)/(k1 + k2 + k3)])/(2*k1*k3*(-k1 + k2 + k3)) - 
     (PolyLogTools`G[0, ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - 
           (2*k3)/(k1 + k2 + k3)))/(2*k1), 1]*Log[(2*k3)/(k1 + k2 + k3)])/
      (2*k1*k3*(-k1 + k2 + k3)) - 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
       Log[(2*k3)/(k1 + k2 + k3)])/(2*k1*k3*(-k1 + k2 + k3)) + 
     (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 
        ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3) - (2*k3)/(k1 + k2 + k3)))/
         (2*k1), 1]*Log[(2*k3)/(k1 + k2 + k3)])/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k1), 1]*
      (PolyLogTools`G[0, -1/2*(k1 + k2 + k3)/k3, 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[0, 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
         -1/2*(k1 + k2 + k3)/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
         ((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 1]/
        (2*k1*(k1 - k2 - k3)*k3) + 
       (PolyLogTools`G[((k1 + k2 + k3)*(-1 + (2*k1)/(k1 + k2 + k3)))/(2*k3), 
          1]*Log[(2*k3)/(k1 + k2 + k3)])/(2*k1*k3*(-k1 + k2 + k3)))) + 
   PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    ((11*PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (4*k1*(k1 + k2 - k3)*k3) + 
     (11*PolyLogTools`G[0, k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1])/
      (4*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1]*
      (-1/12*Pi^2/(k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[0, -(-1 + k3/k1)^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
        (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-(-1 + k3/k1)^(-1), 1, 1]/
        (2*k1*(k1 + k2 - k3)*k3)) + 
     (11*PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1])/
      (4*k1*(k1 + k2 - k3)*k3) + 
     (11*PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
        -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1])/(4*k1*(k1 + k2 - k3)*k3) - 
     (PolyLogTools`G[(2 + (-k1 + k2 + k3)/(2*k1))/
         (1 + (-k1 + k2 + k3)/(2*k1)), 1]*PolyLogTools`G[
        (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
        1])/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
      ((11*PolyLogTools`G[(-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
            (-k1 + k2 + k3)/(2*k1)), 1])/(4*k1*(k1 + k2 - k3)*k3) - 
       (11*PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1])/
        (4*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[(-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
           (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
          (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*
         k3) + PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1, 1]/
        (2*k1*(k1 + k2 - k3)*k3)) + 
     (11*PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 
        k3/(k1*(-1 + k3/k1)), 1])/(4*k1*(k1 + k2 - k3)*k3) - 
     (11*PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 
        (2 + (-k1 + k2 + k3)/(2*k1))/(1 + (-k1 + k2 + k3)/(2*k1)), 1])/
      (4*k1*(k1 + k2 - k3)*k3) - 
     (11*PolyLogTools`G[(2 + (-k1 + k2 + k3)/(2*k1))/
         (1 + (-k1 + k2 + k3)/(2*k1)), 1, 1])/(4*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
         (-k1 + k2 + k3)/(2*k1)), 1]*
      ((11*PolyLogTools`G[(2 + (-k1 + k2 + k3)/(2*k1))/
           (1 + (-k1 + k2 + k3)/(2*k1)), 1])/(4*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[0, -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
        (2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[(2 + (-k1 + k2 + k3)/(2*k1))/
          (1 + (-k1 + k2 + k3)/(2*k1)), 1, 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
     PolyLogTools`G[0, 0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 0, 
       k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, 1, k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1, 
       1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-2*k1)/(-k1 + k2 + k3), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), -(1 + (-k1 + k2 + k3)/(2*k1))^
         (-1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 0, 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 0, 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1, 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1, 
       (2 + (-k1 + k2 + k3)/(2*k1))/(1 + (-k1 + k2 + k3)/(2*k1)), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[(2 + (-k1 + k2 + k3)/(2*k1))/
        (1 + (-k1 + k2 + k3)/(2*k1)), 1, 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     (11*Pi^2 - 24*Zeta[3])/(24*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    ((11*PolyLogTools`G[0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1])/
      (4*k1*k3*(k1 - k2 + k3)) + (11*PolyLogTools`G[0, (2*k1)/(k1 + k2 - k3), 
        1])/(4*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 
       1]*(-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) - 
       (11*PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 1])/
        (4*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, -(-1 + k1/k3)^(-1), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
         1]/(2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[-(-1 + k1/k3)^(-1), 1, 
         1]/(2*k1*k3*(k1 - k2 + k3))) + 
     (11*PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
        (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3*(k1 - k2 + k3)) + 
     (11*PolyLogTools`G[(2*k1)/(k1 + k2 - k3), k1/((-1 + k1/k3)*k3), 1])/
      (4*k1*k3*(k1 - k2 + k3)) - (11*PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 
        (2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1])/
      (4*k1*k3*(k1 - k2 + k3)) + (11*PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 
        1])/(4*k1*k3*(k1 - k2 + k3)) - 
     (PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1]*
       PolyLogTools`G[-1/2*(k1 + k2 - k3)/((k1/k3 - (k1 + k2 - k3)/(2*k3))*
           k3), -1/2*(k1 + k2 - k3)/((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3), 1])/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 1]*
      ((11*PolyLogTools`G[-1/2*(k1 + k2 - k3)/((k1/k3 - (k1 + k2 - k3)/(2*
                k3))*k3), 1])/(4*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[-1/2*(k1 + k2 - k3)/((k1/k3 - (k1 + k2 - k3)/(2*k3))*
            k3), -1/2*(k1 + k2 - k3)/((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3), 1]/
        (2*k1*k3*(k1 - k2 + k3))) - 
     (11*PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1, 
        1])/(4*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3), 
       1]*((11*PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/
           (k1 + k2 - k3), 1])/(4*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1, 
         1]/(2*k1*k3*(k1 - k2 + k3))) + 
     PolyLogTools`G[0, 0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, 0, (2*k1)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 1, k1/((-1 + k1/k3)*k3), 
       1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), 1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (2*k1)/(k1 + k2 - k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, k1/((-1 + k1/k3)*k3), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
     (3*PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
        (-2*k3)/(k1 + k2 - k3), 1])/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-2*k3)/(k1 + k2 - k3), -(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 0, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 0, 
       k1/((-1 + k1/k3)*k3), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 1, k1/((-1 + k1/k3)*k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(2*k1)/(k1 + k2 - k3), 1, 
       (2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*(1 + (k1 + k2 - k3)/(2*k3))*k3)/(k1 + k2 - k3), 1, 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + (11*Pi^2 - 24*Zeta[3])/
      (24*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
    ((11*PolyLogTools`G[0, (2*k3)/(-k1 + k2 + k3), 1])/
      (4*k1*k3*(k1 - k2 + k3)) + 
     (11*PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1])/
      (4*k1*k3*(k1 - k2 + k3)) + (11*PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 
        k3/(k1*(-1 + k3/k1)), 1])/(4*k1*k3*(k1 - k2 + k3)) - 
     (11*PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 
        (2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1])/
      (4*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 1]*
      (-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/
        (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, -(-1 + k3/k1)^(-1), 1]/
        (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[-(-1 + k3/k1)^(-1), 1, 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     (11*PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1])/
      (4*k1*k3*(k1 - k2 + k3)) + 
     (11*PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
        (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1*k3*(k1 - k2 + k3)) - 
     (PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1]*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (2*k1*k3*(k1 - k2 + k3)) - 
     (11*PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 
        1, 1])/(4*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, 0, (2*k3)/(-k1 + k2 + k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 0, 
       (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, 1, k3/(k1*(-1 + k3/k1)), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, (2*k3)/(-k1 + k2 + k3), 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 0, 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 
       0, k3/(k1*(-1 + k3/k1)), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 1, k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 1, 
       (2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1, 
       1]/(2*k1*k3*(k1 - k2 + k3)) + 
     (3*PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
        (-2*k1)/(-k1 + k2 + k3), 1])/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 0, 
       -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-2*k1)/(-k1 + k2 + k3), -(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 
       -(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(2*k1*(1 + (-k1 + k2 + k3)/(2*k1)))/(-k1 + k2 + k3), 1, 
       1, 1]/(2*k1*k3*(k1 - k2 + k3)) + (11*Pi^2 - 24*Zeta[3])/
      (24*k1*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
    ((-11*PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1])/
      (4*k1*(k1 - k2 - k3)*k3) + 
     (11*PolyLogTools`G[0, k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1])/
      (4*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1]*
      (-1/12*Pi^2/(k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[0, -(-1 + k1/k3)^(-1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[-(-1 + k1/k3)^(-1), 1, 1]/
        (2*k1*(k1 - k2 - k3)*k3)) - 
     (11*PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
        -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1])/(4*k1*(k1 - k2 - k3)*k3) - 
     (11*PolyLogTools`G[(2 + (k1 + k2 - k3)/(2*k3))/
         (1 + (k1 + k2 - k3)/(2*k3)), 1, 1])/(4*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3 - 
         (k1 + k2 - k3)/(2*k3)), 1]*
      (PolyLogTools`G[0, -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/
        (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[(2 + (k1 + k2 - k3)/(2*k3))/
          (1 + (k1 + k2 - k3)/(2*k3)), 1, 1]/(2*k1*k3*(-k1 + k2 + k3))) + 
     (11*PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1])/
      (4*k1*k3*(-k1 + k2 + k3)) - 
     (11*PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 
        (2 + (k1 + k2 - k3)/(2*k3))/(1 + (k1 + k2 - k3)/(2*k3)), 1])/
      (4*k1*k3*(-k1 + k2 + k3)) + 
     (11*PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 
        k1/((-1 + k1/k3)*k3), 1])/(4*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, 0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[0, 0, 
       k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, 1, k1/((-1 + k1/k3)*k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, k1/((-1 + k1/k3)*k3), 1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 0, 
       (-2*k3)/(k1 + k2 - k3), 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       (k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), -(1 + (k1 + k2 - k3)/(2*k3))^(-1), 
       1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))^(-1), 
       -(1 + (k1 + k2 - k3)/(2*k3))^(-1), (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[(2 + (k1 + k2 - k3)/(2*k3))/
        (1 + (k1 + k2 - k3)/(2*k3)), 1, 1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 0, 1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 0, 
       k1/((-1 + k1/k3)*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1, 
       (2 + (k1 + k2 - k3)/(2*k3))/(1 + (k1 + k2 - k3)/(2*k3)), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1, 
       k1/((-1 + k1/k3)*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     (11*Pi^2 - 24*Zeta[3])/(24*k1*k3*(-k1 + k2 + k3))) + 
   PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    (PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
      (Pi^2/(6*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1]/
        (2*k1*(k1 + k2 - k3)*k3)) - PolyLogTools`G[0, 1, 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 0, 1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 0, k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1, 
       1]/(k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     (3*PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 
        k3/(k1*(-1 + k3/k1)), 1])/(2*k1*(k1 + k2 - k3)*k3) - 
     (PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1]*
       Log[k3/k1])/(k1*(k1 + k2 - k3)*k3) + (-(Pi^2*Log[k3/k1]) - 3*Zeta[3])/
      (6*k1*(k1 + k2 - k3)*k3)) + 
   PolyLogTools`G[(k3/k1 - (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    (PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
      (Pi^2/(6*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1]/(2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1]/
        (2*k1*k3*(k1 - k2 + k3))) - PolyLogTools`G[0, 1, 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 0, 1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 0, k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1, 
       1]/(k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     (3*PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 
        k3/(k1*(-1 + k3/k1)), 1])/(2*k1*k3*(k1 - k2 + k3)) - 
     (PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1]*
       Log[k3/k1])/(k1*k3*(k1 - k2 + k3)) + (-(Pi^2*Log[k3/k1]) - 3*Zeta[3])/
      (6*k1*k3*(k1 - k2 + k3))) + 
   (4*Sqrt[k1]*Sqrt[k3]*(k1 + k2 + k3)^(3/2)*Pi^4 - 
     25*k1*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^4 + 25*k2*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^4 + 
     25*k3*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^4 + 5*Sqrt[k1]*Sqrt[k3]*(k1 + k2 + k3)^(3/2)*
      Pi^2*Log[k3/k1]^2 - 30*k1*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^2*
      Log[(2*k1)/(k1 + k2 + k3)]^2 + 30*k2*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^2*
      Log[(2*k1)/(k1 + k2 + k3)]^2 + 30*k3*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^2*
      Log[(2*k1)/(k1 + k2 + k3)]^2 - 30*k1*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^2*
      Log[(2*k3)/(k1 + k2 + k3)]^2 + 30*k2*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^2*
      Log[(2*k3)/(k1 + k2 + k3)]^2 + 30*k3*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^2*
      Log[(2*k3)/(k1 + k2 + k3)]^2 + 60*k1*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^2*
      Log[(2*k1)/(k1 + k2 + k3)]*Log[1 - (2*k1)/(k1 + k2 + k3)] - 
     60*k2*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^2*Log[(2*k1)/(k1 + k2 + k3)]*
      Log[1 - (2*k1)/(k1 + k2 + k3)] - 60*k3*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^2*
      Log[(2*k1)/(k1 + k2 + k3)]*Log[1 - (2*k1)/(k1 + k2 + k3)] + 
     30*k1^(5/2)*Sqrt[k3/(k1 + k2 + k3)]*Pi^2*Log[(2*k1)/(k1 + k2 + k3)]*
      Log[1 + (2*k1)/(k1 + k2 + k3)] - 30*Sqrt[k1]*k2^2*
      Sqrt[k3/(k1 + k2 + k3)]*Pi^2*Log[(2*k1)/(k1 + k2 + k3)]*
      Log[1 + (2*k1)/(k1 + k2 + k3)] - 60*Sqrt[k1]*k2*k3*
      Sqrt[k3/(k1 + k2 + k3)]*Pi^2*Log[(2*k1)/(k1 + k2 + k3)]*
      Log[1 + (2*k1)/(k1 + k2 + k3)] - 30*Sqrt[k1]*k3^2*
      Sqrt[k3/(k1 + k2 + k3)]*Pi^2*Log[(2*k1)/(k1 + k2 + k3)]*
      Log[1 + (2*k1)/(k1 + k2 + k3)] + 60*k1*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^2*
      Log[(2*k3)/(k1 + k2 + k3)]*Log[1 - (2*k3)/(k1 + k2 + k3)] - 
     60*k2*Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*
      (k1 + k2 + k3)^(3/2)*Pi^2*Log[(2*k3)/(k1 + k2 + k3)]*
      Log[1 - (2*k3)/(k1 + k2 + k3)] - 60*k3*Sqrt[k1/(k1 + k2 + k3)]*
      Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)^(3/2)*Pi^2*
      Log[(2*k3)/(k1 + k2 + k3)]*Log[1 - (2*k3)/(k1 + k2 + k3)] + 
     30*k1^2*Sqrt[k3]*Sqrt[k1/(k1 + k2 + k3)]*Pi^2*Log[(2*k3)/(k1 + k2 + k3)]*
      Log[1 + (2*k3)/(k1 + k2 + k3)] - 30*k2^2*Sqrt[k3]*
      Sqrt[k1/(k1 + k2 + k3)]*Pi^2*Log[(2*k3)/(k1 + k2 + k3)]*
      Log[1 + (2*k3)/(k1 + k2 + k3)] - 60*k2*k3^(3/2)*Sqrt[k1/(k1 + k2 + k3)]*
      Pi^2*Log[(2*k3)/(k1 + k2 + k3)]*Log[1 + (2*k3)/(k1 + k2 + k3)] - 
     30*k3^(5/2)*Sqrt[k1/(k1 + k2 + k3)]*Pi^2*Log[(2*k3)/(k1 + k2 + k3)]*
      Log[1 + (2*k3)/(k1 + k2 + k3)] - 180*Sqrt[k1]*Sqrt[k3]*
      (k1 + k2 + k3)^(3/2)*Log[k3/k1]*Zeta[3])/(120*k1^(3/2)*(k1 - k2 - k3)*
     k3^(3/2)*(k1 + k2 + k3)^(3/2)) + PolyLogTools`G[(-2*k3)/(k1 + k2 - k3), 
     1]*((Sqrt[k1/k3]*Pi^2*PolyLogTools`G[-1 - (k1 + k2 - k3)/(2*k3), 1])/
      (4*k1^(3/2)*Sqrt[k3]*(k1 + k2 + k3)) + 
     (Sqrt[k1/(k1 + k2 + k3)]*Sqrt[k3/(k1 + k2 + k3)]*(k1 + k2 + k3)*Pi^2*
       PolyLogTools`G[(2*k1)/(k1 - k2 - k3), 1])/(2*k1^(3/2)*k3^(3/2)*
       (k1 - k2 + k3)) - (Sqrt[k1/k3]*Pi^2*PolyLogTools`G[
        -1/2*(k1 + k2 - k3)/k3, 1])/(4*k1^(3/2)*(k1 + k2 - k3)*Sqrt[k3]) + 
     ((-3*EulerGamma*k1 - 3*EulerGamma*k2 - EulerGamma*k3)*
       PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     (EulerGamma*PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*k3*(k1 + k2 + k3)) + 
     (EulerGamma*PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*(k1 + k2 - k3)*k3) - 
     (11*PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(k1 - k2 + k3)) - 
     (11*PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(k1 - k2 + k3)) + 
     (EulerGamma*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
        -1/2*(k1 + k2 - k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3) - 
     (EulerGamma*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
        ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 1]*
      ((-6*EulerGamma^2 + Pi^2)/(24*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[0, k1/((-1 + k1/k3)*k3), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
       PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1]/(2*k1*(k1 + k2 - k3)*k3)) + 
     (EulerGamma*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        -1/2*(k1 + k2 - k3)/k1, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
     (EulerGamma*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
     (11*PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3), 
       1]*(PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(k1 - k2 + k3))) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
       PolyLogTools`G[0, 0, -1/2*(k1 + k2 - k3)/k1, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 0, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, 0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, 0, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, 1, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 1, (-2*k3)/(k1 + k2 - k3), 
       1]/(2*k1*(k1 + k2 - k3)*k3) + 
     ((3*k1 + 3*k2 + k3)*PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 
        -1/2*(k1 + k2 - k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       -1/2*(k1 + k2 - k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + ((k1^2 + 2*k1*k2 - 3*k2^2 - 2*k1*k3 + 
        2*k2*k3 + k3^2)*PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*
          k3)/k1, -1/2*(k1 + k2 - k3)/k1, 1])/(2*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
     ((k1^2 + k1*k2 - 2*k2^2 - 2*k1*k3 + k2*k3 + k3^2)*
       PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     ((k1 - 3*k2 + 3*k3)*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 0, 
       -1/2*(k1 + k2 - k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     (2*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
        -1/2*(k1 + k2 - k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
        k1, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, -1/2*(k1 + k2 - k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       -1/2*(k1 + k2 - k3)/k1, -1/2*(k1 + k2 - k3)/k1, 1]/
      (k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, -1/2*(k1 + k2 - k3)/k1, 1]/
      (k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, -1/2*(k1 + k2 - k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, -1/2*(k1 + k2 - k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       -1/2*(k1 + k2 - k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1, 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*k3*(k1 - k2 + k3)) + (PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]*
       (-9 - 2*Log[k1/k3]))/(4*k1*(k1 + k2 - k3)*k3) + 
     (-9*k1*Pi^2 + 9*k2*Pi^2 - 9*k3*Pi^2 - 2*k1*Pi^2*Log[k1/k3] + 
       2*k2*Pi^2*Log[k1/k3] - 2*k3*Pi^2*Log[k1/k3] - 12*k1*Zeta[3] + 
       60*k2*Zeta[3] - 60*k3*Zeta[3])/(24*k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3))) + 
   PolyLogTools`G[-(k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    (-1/4*PolyLogTools`G[(k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3^2) + 
     PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 1]/
      (k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, 0, 
       (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, 1, (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + (2*(k1 - k2)*PolyLogTools`G[0, 1, 
        (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, 1, (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + ((3*k1 - 3*k2 + k3)*PolyLogTools`G[0, 
        (-2*k1)/(-k1 + k2 + k3), 1, 1])/(k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)) - PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1, 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 
       (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (k1*k3*(k1 - k2 + k3)) + (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]*
       (-9 - 2*Log[k3/k1]))/(4*k1*(k1 - k2 - k3)*k3) + 
     (PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
       (-9 - 2*Log[k3/k1]))/(4*k1*(k1 - k2 - k3)*k3) + 
     (-9*k1*Pi^2 + 9*k2*Pi^2 - 9*k3*Pi^2 - 2*k1*Pi^2*Log[k3/k1] + 
       2*k2*Pi^2*Log[k3/k1] - 2*k3*Pi^2*Log[k3/k1] - 60*k1*Zeta[3] + 
       60*k2*Zeta[3] - 12*k3*Zeta[3])/(24*k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3))) + 
   PolyLogTools`G[-(k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    (-1/4*PolyLogTools`G[((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1^2*k3) - 
     PolyLogTools`G[0, 0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 
       1]/(k1*(k1 + k2 - k3)*k3) - 
     (2*(-k2 + k3)*PolyLogTools`G[0, 1, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/
         k1, 1])/(k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[0, 1, ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 1, (-2*k3)/(k1 + k2 - k3), 
       1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + ((-k1 + 3*k2 - 3*k3)*
       PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
       ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1, 1]/
      (k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 
       ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     (PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
       (9 + 2*Log[k1/k3]))/(4*k1*(k1 + k2 - k3)*k3) + 
     (PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]*(9 + 2*Log[k1/k3]))/
      (4*k1*(k1 + k2 - k3)*k3) + (9*k1*Pi^2 - 9*k2*Pi^2 + 9*k3*Pi^2 + 
       2*k1*Pi^2*Log[k1/k3] - 2*k2*Pi^2*Log[k1/k3] + 2*k3*Pi^2*Log[k1/k3] + 
       12*k1*Zeta[3] - 60*k2*Zeta[3] + 60*k3*Zeta[3])/
      (24*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3))) + 
   PolyLogTools`G[(-2*k1)/(-k1 + k2 + k3), 1]*
    ((Sqrt[k3/k1]*Pi^2*PolyLogTools`G[-1 - (-k1 + k2 + k3)/(2*k1), 1])/
      (4*Sqrt[k1]*k3^(3/2)*(k1 + k2 + k3)) + 
     ((EulerGamma*k1 + 3*EulerGamma*k2 + 3*EulerGamma*k3)*
       PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 1])/
      (2*k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) - 
     (EulerGamma*PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (11*PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*k3*(k1 - k2 + k3)) - 
     (11*PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*k3*(k1 - k2 + k3)) - 
     (EulerGamma*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
        -1/2*(-k1 + k2 + k3)/k3, 1])/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-(-1 + k3/k1)^(-1), 1]*
      (-1/6*Pi^2/(k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/k3, 1]/
        (2*k1*(k1 - k2 - k3)*k3)) + 
     (EulerGamma*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        -1/2*(-k1 + k2 + k3)/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
     (EulerGamma*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
      ((-11*PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 1])/
        (4*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 1, 
         1]/(2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
              (2*k1))), -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
              (2*k1))), 1]/(2*k1*k3*(k1 - k2 + k3))) + 
     (11*PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1]*
      (-1/12*Pi^2/(k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]/
        (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 
         1]/(2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
         -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
       PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
        (2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
       PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (k1*k3*(k1 - k2 + k3))) + (PolyLogTools`G[(2*k3)/(-k1 + k2 + k3), 1]*
       PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, 0, 
       (-2*k1)/(-k1 + k2 + k3), 1]/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, 0, -1/2*(-k1 + k2 + k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + ((-k1^2 - 2*k1*k2 + 3*k2^2 - 2*k1*k3 + 
        2*k2*k3 - k3^2)*PolyLogTools`G[0, 0, -1/2*(-k1 + k2 + k3)/k3, 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 0, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, 0, 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
       1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, 0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 
        2*k2*k3 + k3^2)*PolyLogTools`G[0, 0, 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
        k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) - 
     PolyLogTools`G[0, 0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, 1, 
       (-2*k1)/(-k1 + k2 + k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, 1, k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, 1, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, 1, 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (k1*(k1 - k2 - k3)*k3) + ((-3*k1 + 3*k2 - k3)*PolyLogTools`G[0, 
        (-2*k1)/(-k1 + k2 + k3), 1, 1])/(k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)) + PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
       1]/(2*k1*(k1 + k2 - k3)*k3) + 
     ((-k1 - 3*k2 - 3*k3)*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 
        -1/2*(-k1 + k2 + k3)/k3, 1])/(k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, 1 - k3/k1, 1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, 1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 1 - k3/k1, 
       -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, 1 - k3/k1, -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     (2*PolyLogTools`G[0, (1 + k3/k1)^(-1), 1, 1])/(k3*(-k1 + k2 + k3)*
       (k1 + k2 + k3)) + PolyLogTools`G[0, (1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(k3*(-k1 + k2 + k3)*
       (k1 + k2 + k3)) + PolyLogTools`G[0, (1 + k3/k1)^(-1), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k3*(-k1 + k2 + k3)*
       (k1 + k2 + k3)) - PolyLogTools`G[0, (1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (k3*(-k1 + k2 + k3)*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     ((-k1^2 - 2*k1*k2 - k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
       PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k1, 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     (k2*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 1])/
      (k1*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1 + k2)*PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1])/(k1*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) + ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
        1])/(2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 
        2*k1*k2*k3 + k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) + 
     ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
        k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) - 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + ((k1^2 + 2*k1*k2 - 3*k2^2 - 2*k1*k3 + 
        2*k2*k3 + k3^2)*PolyLogTools`G[0, 
        (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, -1/2*(-k1 + k2 + k3)/k3, 
        1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
     ((k1^2 + k1*k2 - 2*k2^2 - 2*k1*k3 + k2*k3 + k3^2)*
       PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, -1/2*(-k1 + k2 + k3)/k3, 1]/
      (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 
       1]/(k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 0, 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
       -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(k1*(k1 - k2 - k3)*k3) - 
     (3*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, -1/2*(-k1 + k2 + k3)/k3, 
        1])/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/k3, 
        -1/2*(-k1 + k2 + k3)/k3, 1])/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, -1/2*(-k1 + k2 + k3)/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 0, 1, 1]/
      (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 0, 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[1 - k3/k1, 0, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 0, 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
       1]/(2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 0, 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - (2*PolyLogTools`G[1 - k3/k1, 1, 1, 1])/
      (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1, 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
       1]/(k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1, 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
       -1/2*(-k1 + k2 + k3)/k1, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
       -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 1, 1]/
      (k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 - k3/k1, 1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
       1]/(2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 1 - k3/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
       1, 1]/(k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
       (1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, (1 + k3/k1)^(-1), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
       1]/(2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[1 - k3/k1, 
       (1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
       -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
       -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
      (k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[1 - k3/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 0, 1, 
       1]/(2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 0, 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1, 1]/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + (3*PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 
        k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 1])/
      (2*k1*(k1 - k2 - k3)*k3) - (2*PolyLogTools`G[(1 + k3/k1)^(-1), 0, 1, 
        1])/(k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 0, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), 0, -1/2*(-k1 + k2 + k3)/
         (k1*(1 + k3/k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/
        k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), 0, -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/(k1*k3*(k1 + k2 + k3)) + 
     (2*PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1, 1])/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), 1, (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), 1, -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 1, 1]/
      (k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
       1]/(2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
       1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
         (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), 1 - k3/k1, 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
       (1 + k3/k1)^(-1), 1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
       (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), (1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), -1 - (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
       -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]/
      (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[(1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[(1 + k3/k1)^(-1), 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
       -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
       -1/2*(-k1 + k2 + k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
       -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
       -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 0, 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k1, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
       -1 - (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
       (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/k3, 1]/
      (k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, -1/2*(-k1 + k2 + k3)/k3, 1]/
      (k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, -1/2*(-k1 + k2 + k3)/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, -1/2*(-k1 + k2 + k3)/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + ((-k1^2 - 4*k1*k2 - 3*k2^2 - 2*k1*k3 + 
        4*k2*k3 - k3^2)*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 1, 1])/
      (k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) + 
     ((-k1^3 + 9*k1^2*k2 + k1*k2^2 - 9*k2^3 - k1^2*k3 + 2*k1*k2*k3 - 
        k2^2*k3 + k1*k3^2 + 9*k2*k3^2 + k3^3)*PolyLogTools`G[
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
        -1/2*(-k1 + k2 + k3)/k1, 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((3*k1^2*k2 - 3*k2^3 + 2*k1*k2*k3 + 3*k2*k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), 0, -1/2*(-k1 + k2 + k3)/k3, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^3 - 9*k1^2*k2 - k1*k2^2 + 9*k2^3 - k1^2*k3 + 2*k1*k2*k3 - k2^2*k3 - 
        k1*k3^2 - 9*k2*k3^2 + k3^3)*PolyLogTools`G[
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 0, 
        -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1])/(2*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), 0, -1 - (-k1 + k2 + k3)/(2*k1), 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 - 2*k1*k2 + 3*k2^2 - 2*k1*k3 + 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((k1^2 + 4*k1*k2 + 3*k2^2 + 2*k1*k3 - 4*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), 0, (-1 - (-k1 + k2 + k3)/(2*k1))/
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/(2*k1*k3*(k1 - k2 + k3)*
       (k1^2 + 2*k1*k2 + k2^2 - k3^2)) + 
     ((k1^2 + 4*k1*k2 + 3*k2^2 + 2*k1*k3 - 4*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), 0, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (2*k1*k3*(k1 - k2 + k3)*(k1^2 + 2*k1*k2 + k2^2 - k3^2)) - 
     (16*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1, 1])/
      ((k1 + k2 + k3)*(k1^3 - k1^2*k2 - k1*k2^2 + k2^3 - k1^2*k3 + 
        2*k1*k2*k3 - k2^2*k3 - k1*k3^2 - k2*k3^2 + k3^3)) + 
     (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
        1])/((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      ((k1 - k2 - k3)*(k1 + k2 + k3)*(k1^2 - k2^2 + 2*k2*k3 - k3^2)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k1, 
        -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1])/(2*k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k1, -1 - (-k1 + k2 + k3)/(2*k1), 
        1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k3, 
        -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1])/(2*k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), 1 - k3/k1, 1, 1])/(k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
       (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + 
        k3^2)*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
        -1/2*(-k1 + k2 + k3)/k1, 1])/(2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*
       (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + 
        k3^2)*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1 - k3/k1, 
        -1 - (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), 1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/(2*k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), 1 - k3/k1, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), (1 + k3/k1)^(-1), 1, 1])/(k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), (1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
          (k1*(1 + k3/k1)), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - 
        k3^2)*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), (1 + k3/k1)^(-1), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), (1 + k3/k1)^(-1), (-1 - (-k1 + k2 + k3)/(2*k1))/
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1])/(2*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), (1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
        -1/2*(-k1 + k2 + k3)/k1, 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) + ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + 
        k3^2)*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), -1/2*(-k1 + k2 + k3)/k3, 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
          (-k1 + k2 + k3)/(2*k1)), -1 - (-k1 + k2 + k3)/(2*k1), 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
          (-k1 + k2 + k3)/(2*k1)), (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
          (-k1 + k2 + k3)/(2*k1)), (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
        1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1])/
      (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 - 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k1, 1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), -1/2*(-k1 + k2 + k3)/k3, 1])/
      (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1])/(2*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
        1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) - 
     (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1])/
      (k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       -1/2*(-k1 + k2 + k3)/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1, 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (2*k1*k3*(k1 - k2 + k3)) - 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*k3*(k1 - k2 + k3)) + (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*(EulerGamma - Log[k3/k1]))/
      (2*k1*(k1 - k2 - k3)*k3) + (PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k1, 
        1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*k3) - 
     (PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]*Log[k3/k1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (PolyLogTools`G[0, (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - 
          (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/(2*k1*(k1 - k2 - k3)*k3) - 
     ((k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]*Log[k3/k1])/
      (2*k1*k3*(k1^3 + k1^2*k2 - k1*k2^2 - k2^3 + k1^2*k3 + 2*k1*k2*k3 + 
        k2^2*k3 - k1*k3^2 + k2*k3^2 - k3^3)) + 
     (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
        -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]*Log[k3/k1])/
      (2*k1*(k1 + k2 - k3)*k3) + (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 
        -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/(2*k1*(k1 + k2 - k3)*
       k3) - (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
        -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]*Log[k3/k1])/
      (2*k1*(k1 - k2 - k3)*k3) - (PolyLogTools`G[1 - k3/k1, 1, 1]*Log[k3/k1])/
      (k1*(k1 + k2 - k3)*k3) - 
     (PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/k1, 1]*Log[k3/k1])/
      (2*k1*(k1 + k2 - k3)*k3) - 
     (PolyLogTools`G[1 - k3/k1, -1 - (-k1 + k2 + k3)/(2*k1), 1]*Log[k3/k1])/
      (2*k1*(k1 + k2 - k3)*k3) + 
     (PolyLogTools`G[1 - k3/k1, (-1 - (-k1 + k2 + k3)/(2*k1))/
         (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*Log[k3/k1])/
      (2*k1*(k1 + k2 - k3)*k3) + 
     (PolyLogTools`G[1 - k3/k1, -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]*Log[k3/k1])/
      (2*k1*(k1 + k2 - k3)*k3) + (PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 
        k3/(k1*(-1 + k3/k1)), 1]*Log[k3/k1])/(k1*(k1 - k2 - k3)*k3) + 
     (PolyLogTools`G[(1 + k3/k1)^(-1), 1, 1]*Log[k3/k1])/
      (k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[(1 + k3/k1)^(-1), 
        -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]*Log[k3/k1])/
      (2*k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[(1 + k3/k1)^(-1), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
      (2*k1*k3*(k1 + k2 + k3)) - (PolyLogTools`G[(1 + k3/k1)^(-1), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
        1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) - 
     (PolyLogTools`G[(1 + k3/k1)^(-1), -1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]*Log[k3/k1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
        -1/2*(-k1 + k2 + k3)/k1, 1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) - 
     (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
        -1/2*(-k1 + k2 + k3)/k3, 1]*Log[k3/k1])/(2*k1*k3*(k1 + k2 + k3)) - 
     (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*Log[k3/k1])/
      (2*k1*k3*(k1 + k2 + k3)) - 
     (8*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1, 1]*Log[k3/k1])/
      ((k1 - k2 - k3)*(k1 + k2 - k3)*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k1, 1]*Log[k3/k1])/
      (2*k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
     ((k1^2 + 2*k1*k2 - 3*k2^2 + 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/k3, 1]*Log[k3/k1])/
      (2*k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) - 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
             (2*k1))), -1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]*Log[k3/k1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        (-1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 
        1]*Log[k3/k1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 
       2*k2^2*k3^2 + k3^4) + 
     (4*k2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/
          (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 
        -1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1))), 1]*
       Log[k3/k1])/(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + 
       k3^4) + (PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
       (-EulerGamma + Log[k3/k1]))/(2*k1*(k1 - k2 - k3)*k3) + 
     (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]*(9 + 2*Log[k3/k1]))/
      (4*k1*(k1 - k2 - k3)*k3) + 
     (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(1 + k3/k1)), 1]*
       (-Pi^2 + 3*Log[k3/k1]^2))/(12*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k1, 1]*(k1*Sqrt[k3]*Pi^2 - 
        k2*Sqrt[k3]*Pi^2 - k3^(3/2)*Pi^2 + 3*k1^(3/2)*Sqrt[k3/k1]*Pi^2 + 
        3*Sqrt[k1]*k2*Sqrt[k3/k1]*Pi^2 - 3*Sqrt[k1]*k3*Sqrt[k3/k1]*Pi^2 - 
        3*k1*Sqrt[k3]*Log[k3/k1]^2 + 3*k2*Sqrt[k3]*Log[k3/k1]^2 + 
        3*k3^(3/2)*Log[k3/k1]^2))/(12*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*
       k3^(3/2)) + PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 1]*
      ((-11*PolyLogTools`G[-(-1 + k3/k1)^(-1), 1])/(4*k1*(k1 - k2 - k3)*k3) + 
       ((-11 + 2*EulerGamma)*PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1])/
        (4*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1]/
        (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/
        (2*k1*(k1 - k2 - k3)*k3) + (2*EulerGamma^2 - Pi^2 + 2*Log[k3/k1]^2)/
        (8*k1*(k1 - k2 - k3)*k3)) + 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/(k1*(k3/k1 - (-k1 + k2 + k3)/
            (2*k1))), 1]*
      ((11*PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
        (4*k1*k3*(k1 - k2 + k3)) + PolyLogTools`G[0, 
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*k3*(k1 - k2 + k3)) - 
       PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*k3*(k1 - k2 + k3)) + (2*(k2*Pi^2 - 3*k2*Log[k3/k1]^2))/
        (3*(k1^4 - 2*k1^2*k2^2 + k2^4 - 2*k1^2*k3^2 - 2*k2^2*k3^2 + k3^4))) + 
     (9*k1*Pi^2 - 9*k2*Pi^2 + 9*k3*Pi^2 + 2*k1*Pi^2*Log[k3/k1] - 
       2*k2*Pi^2*Log[k3/k1] + 2*k3*Pi^2*Log[k3/k1] + 144*k1*Zeta[3] - 
       144*k2*Zeta[3] + 96*k3*Zeta[3])/(24*k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3))) + 
   PolyLogTools`G[-(1 + k1/k3 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    (PolyLogTools`G[0, 0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
      (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 
       1]/(k1*k3*(k1 + k2 + k3)) + 
     ((k1^2 - 4*k1*k2 - 5*k2^2 - 4*k1*k3 - 2*k2*k3 + 3*k3^2)*
       PolyLogTools`G[0, 1, 2 + (k1 + k2 - k3)/(2*k3), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     (2*k2*PolyLogTools`G[0, 1, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
         (1 + k1/k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, 1, ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[0, 1, (-2*k3)/(k1 + k2 - k3), 
       1]/(2*k1*k3*(k1 + k2 + k3)) + 
     ((k1^2 - 4*k1*k2 - 5*k2^2 - 4*k1*k3 - 2*k2*k3 + 3*k3^2)*
       PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 1, 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-k1^2 + 4*k1*k2 + 5*k2^2 + 4*k1*k3 + 2*k2*k3 - 3*k3^2)*
       PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
        2 + (k1 + k2 - k3)/(2*k3), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) + ((-k1^2 + 4*k1*k2 + 5*k2^2 + 4*k1*k3 + 2*k2*k3 - 
        3*k3^2)*PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
        (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), 1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), 
       (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     (3*PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
        (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, ((k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 
        2*k2*k3 + k3^2)*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-k1^2 + 4*k1*k2 + 5*k2^2 + 4*k1*k3 + 2*k2*k3 - 3*k3^2)*
       PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 2 + (k1 + k2 - k3)/(2*k3), 
        1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
       ((1 + k1/k3 + (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1, 
       1]/(k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
       (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]/
      (k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
      (k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       1 + (k1 + k2 - k3)/(2*k3), 1, 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
      (k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       1 + (k1 + k2 - k3)/(2*k3), (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
        (1 + k1/k3), 1]/(k1*k3*(-k1 + k2 + k3)) + 
     ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 1, 1])/
      (4*k1*k3^2*(k1 + k2 + k3)) + 
     ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 
        (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
      (4*k1*k3^2*(k1 + k2 + k3)) + 
     ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 
        (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
     ((-k1 - k2 + 5*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 1, 1])/
      (4*k1*k3^2*(k1 + k2 + k3)) - PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
       1, 2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
     ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
        (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
     ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        1 + (k1 + k2 - k3)/(2*k3), 1, 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
     ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1])/
      (4*k1*k3^2*(k1 + k2 + k3)) + 
     ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        1 + (k1 + k2 - k3)/(2*k3), (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/
         (1 + k1/k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
     ((k1 + k2 - 5*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        2 + (k1 + k2 - k3)/(2*k3), 1, 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
     ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        2 + (k1 + k2 - k3)/(2*k3), (-2*k3)/(k1 + k2 - k3), 1])/
      (4*k1*k3^2*(k1 + k2 + k3)) + 
     ((k1 + k2 - 5*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 
        (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1])/
      (4*k1*k3^2*(k1 + k2 + k3)) + 
     (PolyLogTools`G[0, (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]*
       (-11 - 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1]*(-11 - 2*Log[k1/k3]))/
      (4*k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        1, 1]*(-11 - 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]*
       (11 + 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        (1 + k1/k3 + (k1 + k2 - k3)/(2*k3))/(1 + k1/k3), 1]*
       (11 + 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
     (-11*k1^2*Pi^2 + 11*k2^2*Pi^2 + 22*k1*k3*Pi^2 - 11*k3^2*Pi^2 - 
       2*k1^2*Pi^2*Log[k1/k3] + 2*k2^2*Pi^2*Log[k1/k3] + 
       4*k1*k3*Pi^2*Log[k1/k3] - 2*k3^2*Pi^2*Log[k1/k3] - 12*k1^2*Zeta[3] + 
       48*k1*k2*Zeta[3] + 60*k2^2*Zeta[3] + 24*k1*k3*Zeta[3] + 
       48*k2*k3*Zeta[3] - 12*k3^2*Zeta[3])/(24*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[-(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))^(-1), 1]*
    (PolyLogTools`G[0, 0, (-2*k1)/(-k1 + k2 + k3), 1]/
      (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 0, 
       (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 1, (-2*k1)/(-k1 + k2 + k3), 
       1]/(2*k1*k3*(k1 + k2 + k3)) + 
     ((3*k1^2 - 2*k1*k2 - 5*k2^2 - 4*k1*k3 - 4*k2*k3 + k3^2)*
       PolyLogTools`G[0, 1, 2 + (-k1 + k2 + k3)/(2*k1), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, 1, (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - 
     (2*k2*PolyLogTools`G[0, 1, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
         (1 + k3/k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
     ((k1^2 - 2*k1*k2 - 3*k2^2 - 2*k1*k3 - 2*k2*k3 + k3^2)*
       PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-3*k1^2 + 2*k1*k2 + 5*k2^2 + 4*k1*k3 + 4*k2*k3 - k3^2)*
       PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 2 + (-k1 + k2 + k3)/(2*k1), 
        1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + ((3*k1^2 - 2*k1*k2 - 5*k2^2 - 4*k1*k3 - 
        4*k2*k3 + k3^2)*PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 1, 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-3*k1^2 + 2*k1*k2 + 5*k2^2 + 4*k1*k3 + 4*k2*k3 - k3^2)*
       PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
        2 + (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*
       k3*(k1 + k2 + k3)) + ((-3*k1^2 + 2*k1*k2 + 5*k2^2 + 4*k1*k3 + 
        4*k2*k3 - k3^2)*PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
        (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
      (2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), 1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), (-2*k1)/(-k1 + k2 + k3), 
       1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(1 + k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (k1*(k3/k1 + (-k1 + k2 + k3)/(2*k1)))/k3, 
       (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     (3*PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 
        (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1, 
       1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
       (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]/
      (k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
      (k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 1, 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
      (k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1 + (-k1 + k2 + k3)/(2*k1), (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
        (1 + k3/k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
     ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 1, 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) + 
     ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 
        (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
     ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 
        (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) + 
     ((5*k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 1, 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) + 
     ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
        (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
     ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        1 + (-k1 + k2 + k3)/(2*k1), 1, 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
     ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) + 
     ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        1 + (-k1 + k2 + k3)/(2*k1), (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
         (1 + k3/k1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
     ((-5*k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        2 + (-k1 + k2 + k3)/(2*k1), 1, 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
     ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        2 + (-k1 + k2 + k3)/(2*k1), (-2*k1)/(-k1 + k2 + k3), 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) + PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
       2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
      (k1*k3*(k1 + k2 + k3)) + ((-5*k1 + k2 + k3)*PolyLogTools`G[
        1 + (-k1 + k2 + k3)/(2*k1), (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/
         (1 + k3/k1), (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]*(-11 - 2*Log[k3/k1]))/
      (4*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[0, (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*
       (-11 - 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 1]*(-11 - 2*Log[k3/k1]))/
      (4*k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        2 + (-k1 + k2 + k3)/(2*k1), 1]*(11 + 2*Log[k3/k1]))/
      (4*k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        (1 + k3/k1 + (-k1 + k2 + k3)/(2*k1))/(1 + k3/k1), 1]*
       (11 + 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
     (-11*k1^2*Pi^2 + 11*k2^2*Pi^2 + 22*k1*k3*Pi^2 - 11*k3^2*Pi^2 - 
       2*k1^2*Pi^2*Log[k3/k1] + 2*k2^2*Pi^2*Log[k3/k1] + 
       4*k1*k3*Pi^2*Log[k3/k1] - 2*k3^2*Pi^2*Log[k3/k1] - 12*k1^2*Zeta[3] + 
       48*k1*k2*Zeta[3] + 60*k2^2*Zeta[3] + 24*k1*k3*Zeta[3] + 
       48*k2*k3*Zeta[3] - 12*k3^2*Zeta[3])/(24*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3))) + 
   PolyLogTools`G[-(1 + (k1 + k2 - k3)/(2*k3))^(-1), 1]*
    ((Sqrt[k1/k3]*Pi^2*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1])/
      (4*k1^(3/2)*Sqrt[k3]*(k1 + k2 + k3)) - 
     (EulerGamma*PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*k3*(k1 + k2 + k3)) + (2*(EulerGamma*k1 + EulerGamma*k2)*
       PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     (11*PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*(k1 - k2 - k3)*k3) - 
     (11*PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*k3*(-k1 + k2 + k3)) - 
     (EulerGamma*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, 
        ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
      ((6*EulerGamma^2 - Pi^2)/(24*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[0, k1/((-1 + k1/k3)*k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1, 1]/(2*k1*k3*(k1 + k2 + k3))) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]*
      ((11*PolyLogTools`G[(-1 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3 - 
            (k1 + k2 - k3)/(2*k3)), 1])/(4*k1*k3*(-k1 + k2 + k3)) - 
       (11*PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1])/
        (4*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[(-1 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3 - 
           (k1 + k2 - k3)/(2*k3)), (-1 - (k1 + k2 - k3)/(2*k3))/
          (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3)), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1, 1]/
        (2*k1*k3*(-k1 + k2 + k3))) + 
     (EulerGamma*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(2*k1*k3*(k1 + k2 + k3)) - 
     (EulerGamma*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*k3*(k1 + k2 + k3)) - 
     (11*PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (4*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[k1/((-1 + k1/k3)*k3), 1]*
      (Pi^2/(12*k1*(k1 - k2 - k3)*k3) + ((-11 + 2*EulerGamma)*
         PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
        (4*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 
         1 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, 
         ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
         1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
         1]/(2*k1*(k1 - k2 - k3)*k3) + 
       PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
         (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
         1 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) - 
       PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
       PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(-k1 + k2 + k3))) + 
     (PolyLogTools`G[k1/((1 + (k1 + k2 - k3)/(2*k3))*k3), 1]*
       PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (2*k1*k3*(-k1 + k2 + k3)) + PolyLogTools`G[(-1 - (k1 + k2 - k3)/(2*k3))/
        (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3)), 1]*
      (PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*k3*(-k1 + k2 + k3)) + 
       PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
         ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
        (2*k1*(k1 - k2 - k3)*k3)) - PolyLogTools`G[0, 0, 
       1 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*k3*(k1 + k2 + k3)) - (2*(k1^2 - k1*k2 - 2*k2^2 - k1*k3 - 2*k2*k3)*
       PolyLogTools`G[0, 0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + PolyLogTools`G[0, 0, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) - PolyLogTools`G[0, 0, (-2*k3)/(k1 + k2 - k3), 
       1]/(k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 1, 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     (2*k2*PolyLogTools`G[0, 1, 1 + (k1 + k2 - k3)/(2*k3), 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
     ((-k1^2 + k1*k2 + 2*k2^2 + 2*k1*k3 + k2*k3 - k3^2)*
       PolyLogTools`G[0, 1, 2 + (k1 + k2 - k3)/(2*k3), 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, 1, (-2*k3)/(k1 + k2 - k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
       1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       1 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     ((-k1^2 + k1*k2 + 2*k2^2 + 2*k1*k3 + k2*k3 - k3^2)*
       PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-k1^2 - 2*k1*k2 - k2^2 + 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
        1 + (k1 + k2 - k3)/(2*k3), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) + ((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + k3^2)*
       PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 
        2 + (k1 + k2 - k3)/(2*k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) - PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), 1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 2 + (k1 + k2 - k3)/(2*k3), 
       (-2*k3)/(k1 + k2 - k3), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, -1/2*(k1 + k2 - k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     ((-3*k1 - 3*k2 + k3)*PolyLogTools`G[0, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
         k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     ((-k1^2 - k1*k2 + 2*k2^2 - k1*k3 + 2*k2*k3)*PolyLogTools`G[0, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*(k1 - k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-k1^2 - k1*k2 + 2*k2^2 - k1*k3 + 2*k2*k3)*PolyLogTools`G[0, 
        ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 
        2*k2*k3 - k3^2)*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + ((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + 
        k3^2)*PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
        2 + (k1 + k2 - k3)/(2*k3), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) + PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/
        (-1 + k1/k3), 1, 1, 1]/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
       1 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
      (k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       (-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       1 + (k1 + k2 - k3)/(2*k3), 1]/(2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       1 + (k1 + k2 - k3)/(2*k3), 1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       1 + (k1 + k2 - k3)/(2*k3), 1 + (k1 + k2 - k3)/(2*k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))/(-1 + k1/k3), 
       1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 1, 1])/
      (4*k1*k3^2*(k1 + k2 + k3)) + 
     ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 
        1 + (k1 + k2 - k3)/(2*k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
     ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 0, 
        (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
     ((k1 + k2 - 5*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 1, 1])/
      (4*k1*k3^2*(k1 + k2 + k3)) + PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
       1, 2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
     ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 
        (-2*k3)/(k1 + k2 - k3), 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
     ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        1 + (k1 + k2 - k3)/(2*k3), 1, 1])/(4*k1*k3^2*(k1 + k2 + k3)) + 
     ((-k1 - k2 + 3*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        1 + (k1 + k2 - k3)/(2*k3), 1 + (k1 + k2 - k3)/(2*k3), 1])/
      (2*k1*k3^2*(k1 + k2 + k3)) + 
     ((-k1 - k2 + k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 1])/
      (4*k1*k3^2*(k1 + k2 + k3)) + 
     ((-k1 - k2 + 5*k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        2 + (k1 + k2 - k3)/(2*k3), 1, 1])/(4*k1*k3^2*(k1 + k2 + k3)) - 
     PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 2 + (k1 + k2 - k3)/(2*k3), 
       2 + (k1 + k2 - k3)/(2*k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
     ((k1 + k2 - k3)*PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        2 + (k1 + k2 - k3)/(2*k3), (-2*k3)/(k1 + k2 - k3), 1])/
      (4*k1*k3^2*(k1 + k2 + k3)) + 
     (2*PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, -1/2*(k1 + k2 - k3)/k1, 
        ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1])/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[-1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/
        k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 + k2 + k3)) + 
     (2*PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
        ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*
          k3)/k1, 1])/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 0, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(2*k1*k3*(-k1 + k2 + k3)) + 
     PolyLogTools`G[((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (2*k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       -1/2*(k1 + k2 - k3)/k1, ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[((k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-1 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 
       ((-2 + k1/k3 - (k1 + k2 - k3)/(2*k3))*k3)/k1, 1]/
      (k1*k3*(k1 - k2 + k3)) + (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        1 + (k1 + k2 - k3)/(2*k3), 1]*(-11 - 2*Log[k1/k3]))/
      (4*k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 
        2 + (k1 + k2 - k3)/(2*k3), 1]*(-11 - 2*Log[k1/k3]))/
      (4*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[0, 1 + (k1 + k2 - k3)/(2*k3), 1]*(11 + 2*Log[k1/k3]))/
      (4*k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[0, (-2*k3)/(k1 + k2 - k3), 
        1]*(11 + 2*Log[k1/k3]))/(4*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[1 + (k1 + k2 - k3)/(2*k3), 1, 1]*(11 + 2*Log[k1/k3]))/
      (4*k1*k3*(k1 + k2 + k3)) + (11*k1^2*Pi^2 - 11*k2^2*Pi^2 - 
       22*k1*k3*Pi^2 + 11*k3^2*Pi^2 + 2*k1^2*Pi^2*Log[k1/k3] - 
       2*k2^2*Pi^2*Log[k1/k3] - 4*k1*k3*Pi^2*Log[k1/k3] + 
       2*k3^2*Pi^2*Log[k1/k3] + 12*k1^2*Zeta[3] - 48*k1*k2*Zeta[3] - 
       60*k2^2*Zeta[3] - 24*k1*k3*Zeta[3] - 48*k2*k3*Zeta[3] + 
       12*k3^2*Zeta[3])/(24*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3))) + PolyLogTools`G[-(1 + (-k1 + k2 + k3)/(2*k1))^(-1), 
     1]*((Sqrt[k3/k1]*Pi^2*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1])/
      (4*Sqrt[k1]*k3^(3/2)*(k1 + k2 + k3)) - 
     (EulerGamma*PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (2*k1*k3*(k1 + k2 + k3)) - (2*(EulerGamma*k2 + EulerGamma*k3)*
       PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 - k2 - k3)*k3*(k1 + k2 + k3)) - 
     (11*PolyLogTools`G[0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*(k1 + k2 - k3)*k3) - 
     (11*PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*(k1 + k2 - k3)*k3) + 
     (EulerGamma*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]*
      ((6*EulerGamma^2 - Pi^2)/(24*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) - 
       PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1]/(2*k1*k3*(k1 + k2 + k3))) + 
     (EulerGamma*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(2*k1*k3*(k1 + k2 + k3)) - 
     (EulerGamma*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*k3*(k1 + k2 + k3)) + 
     (11*PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (4*k1*(k1 + k2 - k3)*k3) + 
     (PolyLogTools`G[k3/(k1*(1 + (-k1 + k2 + k3)/(2*k1))), 1]*
       PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (2*k1*(k1 + k2 - k3)*k3) + PolyLogTools`G[(-1 - (-k1 + k2 + k3)/(2*k1))/
        (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)), 1]*
      (PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 + k2 - k3)*k3) - 
       PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
         (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
        (2*k1*(k1 + k2 - k3)*k3)) - PolyLogTools`G[0, 0, 
       (-2*k1)/(-k1 + k2 + k3), 1]/(k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*k3*(k1 + k2 + k3)) + (2*(2*k1*k2 + 2*k2^2 + k1*k3 + k2*k3 - k3^2)*
       PolyLogTools`G[0, 0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, 0, (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 0, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - PolyLogTools`G[0, 0, 
       1 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, 1, (-2*k1)/(-k1 + k2 + k3), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[0, 1, k3/(k1*(-1 + k3/k1)), 
       1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, 1, (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1]/(2*k1*(k1 + k2 - k3)*k3) + 
     (2*k2*PolyLogTools`G[0, 1, 1 + (-k1 + k2 + k3)/(2*k1), 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3) + 
     ((-k1^2 + k1*k2 + 2*k2^2 + 2*k1*k3 + k2*k3 - k3^2)*
       PolyLogTools`G[0, 1, 2 + (-k1 + k2 + k3)/(2*k1), 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-k1^2 + 2*k1*k2 + 3*k2^2 + 2*k1*k3 + 2*k2*k3 - k3^2)*
       PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + ((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + 
        k3^2)*PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 
        2 + (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) - PolyLogTools`G[0, -1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[0, k3/(k1*(-1 + k3/k1)), 1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[0, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     ((-k1 + 3*k2 + 3*k3)*PolyLogTools`G[0, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3*
       (k1 + k2 + k3)) - PolyLogTools`G[0, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     ((-2*k1*k2 - 2*k2^2 + k1*k3 + k2*k3 + k3^2)*PolyLogTools`G[0, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 + k2 - k3)*k3*
       (k1 - k2 + k3)*(k1 + k2 + k3)) + 
     ((-2*k1*k2 - 2*k2^2 + k1*k3 + k2*k3 + k3^2)*PolyLogTools`G[0, 
        (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/
      (k1*(k1 + k2 - k3)*k3*(k1 - k2 + k3)*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
       1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[0, (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     ((-k1^2 + k1*k2 + 2*k2^2 + 2*k1*k3 + k2*k3 - k3^2)*
       PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 1, 1])/
      (k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*(k1 + k2 + k3)) + 
     ((-k1^2 - 2*k1*k2 - k2^2 + 2*k1*k3 - 2*k2*k3 - k3^2)*
       PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
        1 + (-k1 + k2 + k3)/(2*k1), 1])/(2*k1*(k1 - k2 - k3)*(k1 + k2 - k3)*
       k3*(k1 + k2 + k3)) + ((k1^2 - k1*k2 - 2*k2^2 - 2*k1*k3 - k2*k3 + k3^2)*
       PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 
        2 + (-k1 + k2 + k3)/(2*k1), 1])/(k1*(k1 - k2 - k3)*(k1 + k2 - k3)*k3*
       (k1 + k2 + k3)) - PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), 1, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[0, 2 + (-k1 + k2 + k3)/(2*k1), (-2*k1)/(-k1 + k2 + k3), 
       1]/(2*k1*k3*(k1 + k2 + k3)) - 
     (2*PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, -1/2*(-k1 + k2 + k3)/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[-1/2*(-k1 + k2 + k3)/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*(k1 - k2 - k3)*k3) - 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 0, 1, 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 0, k3/(k1*(-1 + k3/k1)), 1]/
      (2*k1*k3*(k1 + k2 + k3)) + PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 1, 
       1]/(k1*k3*(k1 + k2 + k3)) - PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 1, 
       k3/(k1*(-1 + k3/k1)), 1]/(2*k1*k3*(k1 + k2 + k3)) + 
     (3*PolyLogTools`G[k3/(k1*(-1 + k3/k1)), k3/(k1*(-1 + k3/k1)), 
        k3/(k1*(-1 + k3/k1)), 1])/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 + k2 + k3)) + 
     (2*PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
        (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1])/(k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*k3*(k1 + k2 + k3)) - 
     PolyLogTools`G[(k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 0, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1, 
       1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
       1 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
      (k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1, 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       (-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 1]/(2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 1, 1]/(2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 1 + (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) - 
     PolyLogTools`G[(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1))/(-1 + k3/k1), 
       1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
      (2*k1*(k1 + k2 - k3)*k3) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       -1/2*(-k1 + k2 + k3)/k3, (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/(k1*k3*(k1 - k2 + k3)) + 
     PolyLogTools`G[(k1*(k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-1 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 
       (k1*(-2 + k3/k1 - (-k1 + k2 + k3)/(2*k1)))/k3, 1]/
      (k1*k3*(k1 - k2 + k3)) + ((k1 - k2 - k3)*PolyLogTools`G[
        1 + (-k1 + k2 + k3)/(2*k1), 0, 1, 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
     ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 
        (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
     ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 0, 
        1 + (-k1 + k2 + k3)/(2*k1), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
     ((-5*k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 1, 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) + 
     ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
        (-2*k1)/(-k1 + k2 + k3), 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
     PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 1, 
       2 + (-k1 + k2 + k3)/(2*k1), 1]/(k1*k3*(k1 + k2 + k3)) + 
     ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        1 + (-k1 + k2 + k3)/(2*k1), 1, 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
     ((3*k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        1 + (-k1 + k2 + k3)/(2*k1), 1 + (-k1 + k2 + k3)/(2*k1), 1])/
      (2*k1^2*k3*(k1 + k2 + k3)) + 
     ((k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        1 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) + 
     ((5*k1 - k2 - k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        2 + (-k1 + k2 + k3)/(2*k1), 1, 1])/(4*k1^2*k3*(k1 + k2 + k3)) + 
     ((-k1 + k2 + k3)*PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        2 + (-k1 + k2 + k3)/(2*k1), (-2*k1)/(-k1 + k2 + k3), 1])/
      (4*k1^2*k3*(k1 + k2 + k3)) - PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
       2 + (-k1 + k2 + k3)/(2*k1), 2 + (-k1 + k2 + k3)/(2*k1), 1]/
      (k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        1 + (-k1 + k2 + k3)/(2*k1), 1]*(-11 - 2*Log[k3/k1]))/
      (4*k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        2 + (-k1 + k2 + k3)/(2*k1), 1]*(-11 - 2*Log[k3/k1]))/
      (4*k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[k3/(k1*(-1 + k3/k1)), 
        k3/(k1*(-1 + k3/k1)), 1]*Log[k3/k1])/(k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[0, (-2*k1)/(-k1 + k2 + k3), 1]*(11 + 2*Log[k3/k1]))/
      (4*k1*k3*(k1 + k2 + k3)) + 
     (PolyLogTools`G[0, 1 + (-k1 + k2 + k3)/(2*k1), 1]*(11 + 2*Log[k3/k1]))/
      (4*k1*k3*(k1 + k2 + k3)) + (PolyLogTools`G[1 + (-k1 + k2 + k3)/(2*k1), 
        1, 1]*(11 + 2*Log[k3/k1]))/(4*k1*k3*(k1 + k2 + k3)) + 
     (11*k1^2*Pi^2 - 11*k2^2*Pi^2 - 22*k1*k3*Pi^2 + 11*k3^2*Pi^2 + 
       6*k1^2*Pi^2*Log[k3/k1] - 6*k2^2*Pi^2*Log[k3/k1] - 
       12*k1*k3*Pi^2*Log[k3/k1] + 6*k3^2*Pi^2*Log[k3/k1] + 24*k1^2*Zeta[3] - 
       48*k1*k2*Zeta[3] - 72*k2^2*Zeta[3] - 48*k1*k3*Zeta[3] - 
       48*k2*k3*Zeta[3] + 24*k3^2*Zeta[3])/(24*k1*(k1 - k2 - k3)*
       (k1 + k2 - k3)*k3*(k1 + k2 + k3)))|>
