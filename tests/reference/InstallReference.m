(* Reference for the installation test: the one-fold Mellin-Barnes integral MB1 of the paper (MB tools convention,
   regulator e) and the real part of its expansion through e^0, known in closed form. *)
<|
  "Integral" -> (E^(2 (EulerGamma + I Pi) e) Gamma[-z1] Gamma[2 - 4 e] Gamma[4 - 4 e] Gamma[1 - z1 - 3 e] Gamma[1 - 2 e]
      Gamma[1 + z1 - e] Gamma[e] Gamma[z1 + e]^2)/(Gamma[4 - 8 e] Gamma[2 + z1 - 3 e] Gamma[2 - 2 e]),
  "Regulator" -> e,
  "Order" -> 0,
  "RealPart" -> 1/e^3 + 25/(3 e^2) + (584/9 - (13 Pi^2)/3)/e + 13600/27 - (647 Pi^2)/18 - (380 Zeta[3])/3
|>
