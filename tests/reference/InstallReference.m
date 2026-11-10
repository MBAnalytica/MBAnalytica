(* Reference for the installation test: two Mellin-Barnes integrals of the paper (MB tools convention, regulator e).
   TestMB, the one-fold integral of the worked example of the paper (MB1 of Examples.nb), and the real part of its
   expansion through e^0, known in closed form; the Gauss function 2F1(1, e; 1 - e; x) of Section 6.1, an integral in
   the kinematic variable y = 1 - x, and its expansion through e^2, 1 - e Log[1 - x] + e^2 (Li2(x) + Log[1 - x]^2),
   compared numerically at two values of y. *)
{
  <|
    "Name" -> "TestMB",
    "Integral" -> (E^(2 (EulerGamma + I Pi) e) Gamma[-z1] Gamma[2 - 4 e] Gamma[4 - 4 e] Gamma[1 - z1 - 3 e] Gamma[1 - 2 e]
        Gamma[1 + z1 - e] Gamma[e] Gamma[z1 + e]^2)/(Gamma[4 - 8 e] Gamma[2 + z1 - 3 e] Gamma[2 - 2 e]),
    "Regulator" -> e,
    "Order" -> 0,
    "RealPart" -> 1/e^3 + 25/(3 e^2) + (584/9 - (13 Pi^2)/3)/e + 13600/27 - (647 Pi^2)/18 - (380 Zeta[3])/3
  |>,
  <|
    "Name" -> "2F1",
    "Integral" -> Gamma[1 - e]/(Gamma[e] Gamma[-e] Gamma[1 - 2 e]) Gamma[1 + z1] Gamma[e + z1] Gamma[-2 e - z1] Gamma[-z1] y^z1,
    "Regulator" -> e,
    "Order" -> 2,
    "Variable" -> y,
    "ClosedForm" -> 1 - e Log[y] + e^2 (PolyLog[2, 1 - y] + Log[y]^2),
    "Points" -> {1/3, 3/4}
  |>
}
