(* Exact Standard-route differential MB results. Load with u and epsilon unassigned.
   u is unintegrated; formulas are pointwise on 0<u<1, with u=1 understood as a left limit.
   Full complex phases retained. HPL`HPL and PolyLogTools`G keep explicit contexts.
   Completed scope: MB1u-MB14u at each inclusive benchmark maximum minus four.
   Sharing copy: the MB1u-MB14u records below are unchanged from the research tree's mbu_results.m.
   Load: Get["/path/to/MB_standard/mbu_results.m"].
   Access a series: MB13uVal or MBuResults["MB13u"]["Series"].
   Access coefficients: MBuResults["MB13u"]["Coefficients"].
   This is a standalone symbolic answer record; loading it does not run integrations.
   Source/Derivation fields are provenance paths relative to the research tree,
   not files needed to load these results. Numeric HPL/GPL evaluation needs the bundled
   HPL/PolyLogTools packages; the formulas retain their explicit symbol contexts. *)

Global`MBuResults = <|"MB1u" -> <|"Route" -> "Standard", "Parameter" -> Global`u, "Regulator" -> Global`\[Epsilon], 
   "ParameterIntegrated" -> False, "Orders" -> {-3, 1}, "RemainderOrder" -> 2, 
   "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "No finite coefficientwise Laurent value: \
logarithmic divergences from epsilon^-2 onward. Use the documented left-limit asymptotic.", 
   "ComplexPhaseRetained" -> True, "Coefficients" -> 
    <|-3 -> 1, -2 -> 16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u], 
     -1 -> 80/3 - (13*Pi^2)/6 + HPL`HPL[{2}, Global`u] + 
       (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])^2/2, 
     0 -> 12544/81 + HPL`HPL[{3}, Global`u] + 3*HPL`HPL[{2, 1}, Global`u] + 
       (80/3 - (13*Pi^2)/6)*(16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u]) + 
       HPL`HPL[{2}, Global`u]*(16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u]) + 
       (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])^3/6 - (380*Zeta[3])/3, 
     1 -> 26240/27 - (1783*Pi^4)/180 + (80/3 - (13*Pi^2)/6)^2/2 + HPL`HPL[{4}, Global`u] + 
       4*HPL`HPL[{2, 2}, Global`u] + 3*HPL`HPL[{3, 1}, Global`u] + 9*HPL`HPL[{2, 1, 1}, Global`u] + 
       HPL`HPL[{2}, Global`u]*(80/3 - (13*Pi^2)/6 + (16/3 + (2*I)*Pi - Log[1 - Global`u] - 
            2*Log[Global`u])^2/2) + (HPL`HPL[{3}, Global`u] + 3*HPL`HPL[{2, 1}, Global`u])*
        (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u]) + 
       ((80/3 - (13*Pi^2)/6)*(16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])^2)/2 + 
       (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])^4/24 + 
       (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])*(12544/81 - (380*Zeta[3])/3)|>, 
   "Series" -> 12544/81 + Global`\[Epsilon]^(-3) + HPL`HPL[{3}, Global`u] + 3*HPL`HPL[{2, 1}, Global`u] + 
     (80/3 - (13*Pi^2)/6 + HPL`HPL[{2}, Global`u] + 
       (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])^2/2)/Global`\[Epsilon] + 
     (80/3 - (13*Pi^2)/6)*(16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u]) + 
     (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])/Global`\[Epsilon]^2 + 
     HPL`HPL[{2}, Global`u]*(16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u]) + 
     (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])^3/6 + 
     Global`\[Epsilon]*(26240/27 - (1783*Pi^4)/180 + (80/3 - (13*Pi^2)/6)^2/2 + HPL`HPL[{4}, Global`u] + 
       4*HPL`HPL[{2, 2}, Global`u] + 3*HPL`HPL[{3, 1}, Global`u] + 9*HPL`HPL[{2, 1, 1}, Global`u] + 
       HPL`HPL[{2}, Global`u]*(80/3 - (13*Pi^2)/6 + (16/3 + (2*I)*Pi - Log[1 - Global`u] - 
            2*Log[Global`u])^2/2) + (HPL`HPL[{3}, Global`u] + 3*HPL`HPL[{2, 1}, Global`u])*
        (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u]) + 
       ((80/3 - (13*Pi^2)/6)*(16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])^2)/2 + 
       (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])^4/24 + 
       (16/3 + (2*I)*Pi - Log[1 - Global`u] - 2*Log[Global`u])*(12544/81 - (380*Zeta[3])/3)) - 
     (380*Zeta[3])/3, "Validation" -> <|"ExactSourceAndCoefficientChecks" -> True, 
     "IndependentContourChecks" -> True|>, "Source" -> "differential_u_20260920/MB1u_result.m", 
   "Derivation" -> "differential_u_20260920/README.md", "Complete" -> True|>, 
 "MB2u" -> <|"Route" -> "Standard", "Orders" -> {-2, 0}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> 1, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-2 -> (12*((2*I)*Pi + Log[Global`u]))/(1 - Global`u), 
     -1 -> (-12*(-1/6*Pi^2 + HPL`HPL[{2}, Global`u] - (14/3 - 2*Log[1 - Global`u] - 
           3*Log[Global`u])*((2*I)*Pi + Log[Global`u]) - ((2*I)*Pi + Log[Global`u])^2/2))/
       (1 - Global`u), 0 -> (-12*(HPL`HPL[{3}, Global`u] - HPL`HPL[{2, 1}, Global`u] - 
         (Pi^2*((2*I)*Pi + Log[Global`u]))/6 - (226/9 - 2*Pi^2 + 
           (14/3 - 2*Log[1 - Global`u] - 3*Log[Global`u])^2/2)*((2*I)*Pi + Log[Global`u]) - 
         ((2*I)*Pi + Log[Global`u])^3/6 + (14/3 - 2*Log[1 - Global`u] - 3*Log[Global`u])*
          (-1/6*Pi^2 + HPL`HPL[{2}, Global`u] - ((2*I)*Pi + Log[Global`u])^2/2)))/(1 - Global`u)|>, 
   "Series" -> (12*((2*I)*Pi + Log[Global`u]))/((1 - Global`u)*Global`\[Epsilon]^2) - 
     (12*(-1/6*Pi^2 + HPL`HPL[{2}, Global`u] - (14/3 - 2*Log[1 - Global`u] - 3*Log[Global`u])*
         ((2*I)*Pi + Log[Global`u]) - ((2*I)*Pi + Log[Global`u])^2/2))/((1 - Global`u)*Global`\[Epsilon]) - 
     (12*(HPL`HPL[{3}, Global`u] - HPL`HPL[{2, 1}, Global`u] - (Pi^2*((2*I)*Pi + Log[Global`u]))/
         6 - (226/9 - 2*Pi^2 + (14/3 - 2*Log[1 - Global`u] - 3*Log[Global`u])^2/2)*
         ((2*I)*Pi + Log[Global`u]) - ((2*I)*Pi + Log[Global`u])^3/6 + 
        (14/3 - 2*Log[1 - Global`u] - 3*Log[Global`u])*(-1/6*Pi^2 + HPL`HPL[{2}, Global`u] - 
          ((2*I)*Pi + Log[Global`u])^2/2)))/(1 - Global`u), 
   "Validation" -> <|"MB21SourceFactor" -> True, "MB22SourceFactor" -> True, 
     "CoefficientRecurrence" -> {True, True, True}, "GammaNormalization" -> True, 
     "DefiningSeries" -> {True, True, True, True, True, True, True, True, True, True, True, True}, 
     "StandardResolveExpandSaved" -> True|>, "Complete" -> True, 
   "Source" -> "differential_u_20260920/campaign/MB2u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB3u" -> <|"Route" -> "Standard", "Orders" -> {-4, 0}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> 1, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-4 -> 3, -3 -> 14 + (6*I)*Pi - 3*Log[1 - Global`u] - 6*Log[Global`u], 
     -2 -> (240 + (56*I)*Pi - 25*Pi^2 + 6*HPL`HPL[{2}, Global`u] - 28*Log[1 - Global`u] - 
        (12*I)*Pi*Log[1 - Global`u] + 3*Log[1 - Global`u]^2 - 56*Log[Global`u] - 
        (24*I)*Pi*Log[Global`u] + 12*Log[1 - Global`u]*Log[Global`u] + 12*Log[Global`u]^2)/2, 
     -1 -> (5760 + (1440*I)*Pi - 350*Pi^2 - (102*I)*Pi^3 + 84*HPL`HPL[{2}, Global`u] + 
        (36*I)*Pi*HPL`HPL[{2}, Global`u] + 18*HPL`HPL[{3}, Global`u] + 
        54*HPL`HPL[{2, 1}, Global`u] - 720*Log[1 - Global`u] - (168*I)*Pi*Log[1 - Global`u] + 
        75*Pi^2*Log[1 - Global`u] - 18*HPL`HPL[{2}, Global`u]*Log[1 - Global`u] + 
        42*Log[1 - Global`u]^2 + (18*I)*Pi*Log[1 - Global`u]^2 - 3*Log[1 - Global`u]^3 - 
        1440*Log[Global`u] - (336*I)*Pi*Log[Global`u] + 150*Pi^2*Log[Global`u] - 
        36*HPL`HPL[{2}, Global`u]*Log[Global`u] + 168*Log[1 - Global`u]*Log[Global`u] + 
        (72*I)*Pi*Log[1 - Global`u]*Log[Global`u] - 18*Log[1 - Global`u]^2*Log[Global`u] + 
        168*Log[Global`u]^2 + (72*I)*Pi*Log[Global`u]^2 - 36*Log[1 - Global`u]*Log[Global`u]^2 - 
        24*Log[Global`u]^3 - 2280*Zeta[3])/6, 
     0 -> (921600 + (230400*I)*Pi - 60000*Pi^2 - (9520*I)*Pi^3 - 921*Pi^4 + 
        14400*HPL`HPL[{2}, Global`u] + (3360*I)*Pi*HPL`HPL[{2}, Global`u] - 
        1500*Pi^2*HPL`HPL[{2}, Global`u] + 1680*HPL`HPL[{3}, Global`u] + 
        (720*I)*Pi*HPL`HPL[{3}, Global`u] + 360*HPL`HPL[{4}, Global`u] + 
        5040*HPL`HPL[{2, 1}, Global`u] + (2160*I)*Pi*HPL`HPL[{2, 1}, Global`u] + 
        1440*HPL`HPL[{2, 2}, Global`u] + 1080*HPL`HPL[{3, 1}, Global`u] + 
        3240*HPL`HPL[{2, 1, 1}, Global`u] - 115200*Log[1 - Global`u] - 
        (28800*I)*Pi*Log[1 - Global`u] + 7000*Pi^2*Log[1 - Global`u] + 
        (2040*I)*Pi^3*Log[1 - Global`u] - 1680*HPL`HPL[{2}, Global`u]*Log[1 - Global`u] - 
        (720*I)*Pi*HPL`HPL[{2}, Global`u]*Log[1 - Global`u] - 360*HPL`HPL[{3}, Global`u]*
         Log[1 - Global`u] - 1080*HPL`HPL[{2, 1}, Global`u]*Log[1 - Global`u] + 
        7200*Log[1 - Global`u]^2 + (1680*I)*Pi*Log[1 - Global`u]^2 - 750*Pi^2*Log[1 - Global`u]^2 + 
        180*HPL`HPL[{2}, Global`u]*Log[1 - Global`u]^2 - 280*Log[1 - Global`u]^3 - 
        (120*I)*Pi*Log[1 - Global`u]^3 + 15*Log[1 - Global`u]^4 - 230400*Log[Global`u] - 
        (57600*I)*Pi*Log[Global`u] + 14000*Pi^2*Log[Global`u] + (4080*I)*Pi^3*Log[Global`u] - 
        3360*HPL`HPL[{2}, Global`u]*Log[Global`u] - (1440*I)*Pi*HPL`HPL[{2}, Global`u]*
         Log[Global`u] - 720*HPL`HPL[{3}, Global`u]*Log[Global`u] - 2160*HPL`HPL[{2, 1}, Global`u]*
         Log[Global`u] + 28800*Log[1 - Global`u]*Log[Global`u] + (6720*I)*Pi*Log[1 - Global`u]*
         Log[Global`u] - 3000*Pi^2*Log[1 - Global`u]*Log[Global`u] + 720*HPL`HPL[{2}, Global`u]*
         Log[1 - Global`u]*Log[Global`u] - 1680*Log[1 - Global`u]^2*Log[Global`u] - 
        (720*I)*Pi*Log[1 - Global`u]^2*Log[Global`u] + 120*Log[1 - Global`u]^3*Log[Global`u] + 
        28800*Log[Global`u]^2 + (6720*I)*Pi*Log[Global`u]^2 - 3000*Pi^2*Log[Global`u]^2 + 
        720*HPL`HPL[{2}, Global`u]*Log[Global`u]^2 - 3360*Log[1 - Global`u]*Log[Global`u]^2 - 
        (1440*I)*Pi*Log[1 - Global`u]*Log[Global`u]^2 + 360*Log[1 - Global`u]^2*Log[Global`u]^2 - 
        2240*Log[Global`u]^3 - (960*I)*Pi*Log[Global`u]^3 + 480*Log[1 - Global`u]*Log[Global`u]^3 + 
        240*Log[Global`u]^4 - 212800*Zeta[3] - (91200*I)*Pi*Zeta[3] + 45600*Log[1 - Global`u]*
         Zeta[3] + 91200*Log[Global`u]*Zeta[3])/120|>, 
   "Series" -> 3/Global`\[Epsilon]^4 + (14 + (6*I)*Pi - 3*Log[1 - Global`u] - 6*Log[Global`u])/
      Global`\[Epsilon]^3 + (240 + (56*I)*Pi - 25*Pi^2 + 6*HPL`HPL[{2}, Global`u] - 28*Log[1 - Global`u] - 
       (12*I)*Pi*Log[1 - Global`u] + 3*Log[1 - Global`u]^2 - 56*Log[Global`u] - 
       (24*I)*Pi*Log[Global`u] + 12*Log[1 - Global`u]*Log[Global`u] + 12*Log[Global`u]^2)/
      (2*Global`\[Epsilon]^2) + (5760 + (1440*I)*Pi - 350*Pi^2 - (102*I)*Pi^3 + 84*HPL`HPL[{2}, Global`u] + 
       (36*I)*Pi*HPL`HPL[{2}, Global`u] + 18*HPL`HPL[{3}, Global`u] + 
       54*HPL`HPL[{2, 1}, Global`u] - 720*Log[1 - Global`u] - (168*I)*Pi*Log[1 - Global`u] + 
       75*Pi^2*Log[1 - Global`u] - 18*HPL`HPL[{2}, Global`u]*Log[1 - Global`u] + 
       42*Log[1 - Global`u]^2 + (18*I)*Pi*Log[1 - Global`u]^2 - 3*Log[1 - Global`u]^3 - 
       1440*Log[Global`u] - (336*I)*Pi*Log[Global`u] + 150*Pi^2*Log[Global`u] - 
       36*HPL`HPL[{2}, Global`u]*Log[Global`u] + 168*Log[1 - Global`u]*Log[Global`u] + 
       (72*I)*Pi*Log[1 - Global`u]*Log[Global`u] - 18*Log[1 - Global`u]^2*Log[Global`u] + 
       168*Log[Global`u]^2 + (72*I)*Pi*Log[Global`u]^2 - 36*Log[1 - Global`u]*Log[Global`u]^2 - 
       24*Log[Global`u]^3 - 2280*Zeta[3])/(6*Global`\[Epsilon]) + 
     (921600 + (230400*I)*Pi - 60000*Pi^2 - (9520*I)*Pi^3 - 921*Pi^4 + 
       14400*HPL`HPL[{2}, Global`u] + (3360*I)*Pi*HPL`HPL[{2}, Global`u] - 
       1500*Pi^2*HPL`HPL[{2}, Global`u] + 1680*HPL`HPL[{3}, Global`u] + 
       (720*I)*Pi*HPL`HPL[{3}, Global`u] + 360*HPL`HPL[{4}, Global`u] + 
       5040*HPL`HPL[{2, 1}, Global`u] + (2160*I)*Pi*HPL`HPL[{2, 1}, Global`u] + 
       1440*HPL`HPL[{2, 2}, Global`u] + 1080*HPL`HPL[{3, 1}, Global`u] + 
       3240*HPL`HPL[{2, 1, 1}, Global`u] - 115200*Log[1 - Global`u] - 
       (28800*I)*Pi*Log[1 - Global`u] + 7000*Pi^2*Log[1 - Global`u] + 
       (2040*I)*Pi^3*Log[1 - Global`u] - 1680*HPL`HPL[{2}, Global`u]*Log[1 - Global`u] - 
       (720*I)*Pi*HPL`HPL[{2}, Global`u]*Log[1 - Global`u] - 360*HPL`HPL[{3}, Global`u]*
        Log[1 - Global`u] - 1080*HPL`HPL[{2, 1}, Global`u]*Log[1 - Global`u] + 
       7200*Log[1 - Global`u]^2 + (1680*I)*Pi*Log[1 - Global`u]^2 - 750*Pi^2*Log[1 - Global`u]^2 + 
       180*HPL`HPL[{2}, Global`u]*Log[1 - Global`u]^2 - 280*Log[1 - Global`u]^3 - 
       (120*I)*Pi*Log[1 - Global`u]^3 + 15*Log[1 - Global`u]^4 - 230400*Log[Global`u] - 
       (57600*I)*Pi*Log[Global`u] + 14000*Pi^2*Log[Global`u] + (4080*I)*Pi^3*Log[Global`u] - 
       3360*HPL`HPL[{2}, Global`u]*Log[Global`u] - (1440*I)*Pi*HPL`HPL[{2}, Global`u]*
        Log[Global`u] - 720*HPL`HPL[{3}, Global`u]*Log[Global`u] - 2160*HPL`HPL[{2, 1}, Global`u]*
        Log[Global`u] + 28800*Log[1 - Global`u]*Log[Global`u] + (6720*I)*Pi*Log[1 - Global`u]*
        Log[Global`u] - 3000*Pi^2*Log[1 - Global`u]*Log[Global`u] + 720*HPL`HPL[{2}, Global`u]*
        Log[1 - Global`u]*Log[Global`u] - 1680*Log[1 - Global`u]^2*Log[Global`u] - 
       (720*I)*Pi*Log[1 - Global`u]^2*Log[Global`u] + 120*Log[1 - Global`u]^3*Log[Global`u] + 
       28800*Log[Global`u]^2 + (6720*I)*Pi*Log[Global`u]^2 - 3000*Pi^2*Log[Global`u]^2 + 
       720*HPL`HPL[{2}, Global`u]*Log[Global`u]^2 - 3360*Log[1 - Global`u]*Log[Global`u]^2 - 
       (1440*I)*Pi*Log[1 - Global`u]*Log[Global`u]^2 + 360*Log[1 - Global`u]^2*Log[Global`u]^2 - 
       2240*Log[Global`u]^3 - (960*I)*Pi*Log[Global`u]^3 + 480*Log[1 - Global`u]*Log[Global`u]^3 + 
       240*Log[Global`u]^4 - 212800*Zeta[3] - (91200*I)*Pi*Zeta[3] + 
       45600*Log[1 - Global`u]*Zeta[3] + 91200*Log[Global`u]*Zeta[3])/120, 
   "Validation" -> <|"SourceKernelRatio" -> True, "RequiredMB1DepthAvailable" -> True, 
     "StandardResolveExpandSaved" -> True|>, "Complete" -> True, 
   "Source" -> "differential_u_20260920/campaign/MB3u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB4u" -> <|"Route" -> "Standard", "Orders" -> {-6, -3}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> -2, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-6 -> -Global`u^(-1), -5 -> 22/(3*Global`u) - ((2*I)*Pi)/Global`u + 
       (2*Log[1 - Global`u])/Global`u + (2*Log[Global`u])/Global`u, 
     -4 -> -16/Global`u + (((44*I)/3)*Pi)/Global`u + (29*Pi^2)/(6*Global`u) - 
       (3*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u - (44*Log[1 - Global`u])/(3*Global`u) + 
       ((4*I)*Pi*Log[1 - Global`u])/Global`u - (2*Log[1 - Global`u]^2)/Global`u - 
       (3*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (3*Log[(-1 + Global`u)/Global`u]^2)/(2*Global`u) - (44*Log[Global`u])/(3*Global`u) + 
       ((4*I)*Pi*Log[Global`u])/Global`u - (4*Log[1 - Global`u]*Log[Global`u])/Global`u - 
       (2*Log[Global`u]^2)/Global`u, -3 -> 32/(3*Global`u) - ((32*I)*Pi)/Global`u - 
       (319*Pi^2)/(9*Global`u) + ((7*I)*Pi^3)/Global`u + (22*PolyLogTools`G[0, 1, Global`u^(-1)])/
        Global`u - ((6*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u - 
       (3*PolyLogTools`G[0, 1, Global`u, 1])/Global`u - (3*PolyLogTools`G[0, Global`u, 1, 1])/
        Global`u + (3*PolyLogTools`G[0, Global`u, Global`u, 1])/Global`u + 
       (32*Log[1 - Global`u])/Global`u - (((88*I)/3)*Pi*Log[1 - Global`u])/Global`u - 
       (29*Pi^2*Log[1 - Global`u])/(3*Global`u) + (9*PolyLogTools`G[0, 1, Global`u^(-1)]*
         Log[1 - Global`u])/Global`u + (44*Log[1 - Global`u]^2)/(3*Global`u) - 
       ((4*I)*Pi*Log[1 - Global`u]^2)/Global`u + (4*Log[1 - Global`u]^3)/(3*Global`u) - 
       (5*Pi^2*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (22*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u - 
       ((6*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (3*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/Global`u - 
       (9*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/Global`u - 
       (9*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u])/(2*Global`u) - 
       (11*Log[(-1 + Global`u)/Global`u]^2)/Global`u + ((3*I)*Pi*Log[(-1 + Global`u)/Global`u]^2)/
        Global`u - (3*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/Global`u - 
       Log[(-1 + Global`u)/Global`u]^3/(2*Global`u) + (32*Log[Global`u])/Global`u - 
       (((88*I)/3)*Pi*Log[Global`u])/Global`u - (29*Pi^2*Log[Global`u])/(3*Global`u) + 
       (6*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/Global`u + 
       (88*Log[1 - Global`u]*Log[Global`u])/(3*Global`u) - 
       ((8*I)*Pi*Log[1 - Global`u]*Log[Global`u])/Global`u + (4*Log[1 - Global`u]^2*Log[Global`u])/
        Global`u + (6*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*Log[Global`u])/Global`u - 
       (3*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u])/Global`u + 
       (44*Log[Global`u]^2)/(3*Global`u) - ((4*I)*Pi*Log[Global`u]^2)/Global`u + 
       (4*Log[1 - Global`u]*Log[Global`u]^2)/Global`u + (4*Log[Global`u]^3)/(3*Global`u) + 
       (404*Zeta[3])/(3*Global`u)|>, "Series" -> -(1/(Global`u*Global`\[Epsilon]^6)) + 
     (22/(3*Global`u) - ((2*I)*Pi)/Global`u + (2*Log[1 - Global`u])/Global`u + 
       (2*Log[Global`u])/Global`u)/Global`\[Epsilon]^5 + (-16/Global`u + (((44*I)/3)*Pi)/Global`u + 
       (29*Pi^2)/(6*Global`u) - (3*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u - 
       (44*Log[1 - Global`u])/(3*Global`u) + ((4*I)*Pi*Log[1 - Global`u])/Global`u - 
       (2*Log[1 - Global`u]^2)/Global`u - (3*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/
        Global`u + (3*Log[(-1 + Global`u)/Global`u]^2)/(2*Global`u) - 
       (44*Log[Global`u])/(3*Global`u) + ((4*I)*Pi*Log[Global`u])/Global`u - 
       (4*Log[1 - Global`u]*Log[Global`u])/Global`u - (2*Log[Global`u]^2)/Global`u)/Global`\[Epsilon]^4 + 
     (32/(3*Global`u) - ((32*I)*Pi)/Global`u - (319*Pi^2)/(9*Global`u) + ((7*I)*Pi^3)/Global`u + 
       (22*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u - 
       ((6*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u - 
       (3*PolyLogTools`G[0, 1, Global`u, 1])/Global`u - (3*PolyLogTools`G[0, Global`u, 1, 1])/
        Global`u + (3*PolyLogTools`G[0, Global`u, Global`u, 1])/Global`u + 
       (32*Log[1 - Global`u])/Global`u - (((88*I)/3)*Pi*Log[1 - Global`u])/Global`u - 
       (29*Pi^2*Log[1 - Global`u])/(3*Global`u) + (9*PolyLogTools`G[0, 1, Global`u^(-1)]*
         Log[1 - Global`u])/Global`u + (44*Log[1 - Global`u]^2)/(3*Global`u) - 
       ((4*I)*Pi*Log[1 - Global`u]^2)/Global`u + (4*Log[1 - Global`u]^3)/(3*Global`u) - 
       (5*Pi^2*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (22*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u - 
       ((6*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (3*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/Global`u - 
       (9*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/Global`u - 
       (9*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u])/(2*Global`u) - 
       (11*Log[(-1 + Global`u)/Global`u]^2)/Global`u + ((3*I)*Pi*Log[(-1 + Global`u)/Global`u]^2)/
        Global`u - (3*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/Global`u - 
       Log[(-1 + Global`u)/Global`u]^3/(2*Global`u) + (32*Log[Global`u])/Global`u - 
       (((88*I)/3)*Pi*Log[Global`u])/Global`u - (29*Pi^2*Log[Global`u])/(3*Global`u) + 
       (6*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/Global`u + 
       (88*Log[1 - Global`u]*Log[Global`u])/(3*Global`u) - 
       ((8*I)*Pi*Log[1 - Global`u]*Log[Global`u])/Global`u + (4*Log[1 - Global`u]^2*Log[Global`u])/
        Global`u + (6*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*Log[Global`u])/Global`u - 
       (3*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u])/Global`u + 
       (44*Log[Global`u]^2)/(3*Global`u) - ((4*I)*Pi*Log[Global`u]^2)/Global`u + 
       (4*Log[1 - Global`u]*Log[Global`u]^2)/Global`u + (4*Log[Global`u]^3)/(3*Global`u) + 
       (404*Zeta[3])/(3*Global`u))/Global`\[Epsilon]^3, "Validation" -> 
    <|"AllDistinctSourceKernelsChecked" -> True, "NumericCheckFile" -> "MB4_kernel_checks.m"|>, 
   "Complete" -> True, "Source" -> "differential_u_20260920/campaign/MB4u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB5u" -> <|"Route" -> "Standard", "Orders" -> {-6, -3}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> -2, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-6 -> 7/((-1 + Global`u)*Global`u), 
     -5 -> -70/(3*(-1 + Global`u)*Global`u) + ((14*I)*Pi)/((-1 + Global`u)*Global`u) - 
       (23*Log[1 - Global`u])/((-1 + Global`u)*Global`u) - (14*Log[Global`u])/
        ((-1 + Global`u)*Global`u), -4 -> -616/(3*(-1 + Global`u)*Global`u) - 
       (((140*I)/3)*Pi)/((-1 + Global`u)*Global`u) - (70*Pi^2)/(3*(-1 + Global`u)*Global`u) - 
       (6*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u) - 
       (21*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (230*Log[1 - Global`u])/(3*(-1 + Global`u)*Global`u) - ((46*I)*Pi*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u) + (73*Log[1 - Global`u]^2)/(2*(-1 + Global`u)*Global`u) + 
       (21*Log[1 - Global`u]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u) + 
       (21*Log[Global`u^(-1)]^2)/(2*(-1 + Global`u)*Global`u) - 
       (6*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (3*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u) + 
       (140*Log[Global`u])/(3*(-1 + Global`u)*Global`u) - ((28*I)*Pi*Log[Global`u])/
        ((-1 + Global`u)*Global`u) + (46*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u) + (14*Log[Global`u]^2)/((-1 + Global`u)*Global`u), 
     -3 -> 4928/(3*(-1 + Global`u)*Global`u) - (((1232*I)/3)*Pi)/((-1 + Global`u)*Global`u) + 
       (700*Pi^2)/(9*(-1 + Global`u)*Global`u) - ((28*I)*Pi^3)/((-1 + Global`u)*Global`u) + 
       (20*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u) - 
       ((12*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u) + 
       (70*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) - 
       ((42*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (6*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u) - 
       (30*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (6*PolyLogTools`G[0, 1, Global`u, 1])/((-1 + Global`u)*Global`u) - 
       (15*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/((-1 + Global`u)*Global`u) + 
       (12*PolyLogTools`G[0, Global`u, 1, 1])/((-1 + Global`u)*Global`u) - 
       (18*PolyLogTools`G[0, Global`u, Global`u, 1])/((-1 + Global`u)*Global`u) - 
       (45*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/((-1 + Global`u)*Global`u) + 
       (9*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)*Global`u) + (2024*Log[1 - Global`u])/(3*(-1 + Global`u)*Global`u) + 
       (((460*I)/3)*Pi*Log[1 - Global`u])/((-1 + Global`u)*Global`u) + 
       (221*Pi^2*Log[1 - Global`u])/(3*(-1 + Global`u)*Global`u) + 
       (18*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/((-1 + Global`u)*Global`u) + 
       (18*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u) - (365*Log[1 - Global`u]^2)/(3*(-1 + Global`u)*Global`u) + 
       ((73*I)*Pi*Log[1 - Global`u]^2)/((-1 + Global`u)*Global`u) - (227*Log[1 - Global`u]^3)/
        (6*(-1 + Global`u)*Global`u) + (25*Pi^2*Log[Global`u^(-1)])/(2*(-1 + Global`u)*Global`u) + 
       (66*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u) + 
       (6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u) - (70*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u) + ((42*I)*Pi*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u) - (24*Log[1 - Global`u]^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u) - (33*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u) + (33*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/
        (2*(-1 + Global`u)*Global`u) - (35*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u) + 
       ((21*I)*Pi*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u) + 
       (6*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u) - 
       (27*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/(2*(-1 + Global`u)*Global`u) + 
       Log[Global`u^(-1)]^3/(2*(-1 + Global`u)*Global`u) - (10*Pi^2*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u) - (12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (20*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) - 
       ((12*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (18*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) - 
       (24*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u) - (12*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u) - (12*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (6*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) - 
       (10*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u) + 
       ((6*I)*Pi*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u) - 
       (18*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u) + 
       (2*Log[(-1 + Global`u)/Global`u]^3)/((-1 + Global`u)*Global`u) + 
       (1232*Log[Global`u])/(3*(-1 + Global`u)*Global`u) + (((280*I)/3)*Pi*Log[Global`u])/
        ((-1 + Global`u)*Global`u) + (140*Pi^2*Log[Global`u])/(3*(-1 + Global`u)*Global`u) + 
       (12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/((-1 + Global`u)*Global`u) + 
       (42*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u) - (460*Log[1 - Global`u]*Log[Global`u])/
        (3*(-1 + Global`u)*Global`u) + ((92*I)*Pi*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u) - (73*Log[1 - Global`u]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u) - (42*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/
        ((-1 + Global`u)*Global`u) - (21*Log[Global`u^(-1)]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u) + (12*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*
         Log[Global`u])/((-1 + Global`u)*Global`u) - (6*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u])/((-1 + Global`u)*Global`u) - (140*Log[Global`u]^2)/
        (3*(-1 + Global`u)*Global`u) + ((28*I)*Pi*Log[Global`u]^2)/((-1 + Global`u)*Global`u) - 
       (46*Log[1 - Global`u]*Log[Global`u]^2)/((-1 + Global`u)*Global`u) - 
       (28*Log[Global`u]^3)/(3*(-1 + Global`u)*Global`u) - (2522*Zeta[3])/
        (3*(-1 + Global`u)*Global`u)|>, "Series" -> 7/((-1 + Global`u)*Global`u*Global`\[Epsilon]^6) + 
     (-70/(3*(-1 + Global`u)*Global`u) + ((14*I)*Pi)/((-1 + Global`u)*Global`u) - 
       (23*Log[1 - Global`u])/((-1 + Global`u)*Global`u) - (14*Log[Global`u])/
        ((-1 + Global`u)*Global`u))/Global`\[Epsilon]^5 + (-616/(3*(-1 + Global`u)*Global`u) - 
       (((140*I)/3)*Pi)/((-1 + Global`u)*Global`u) - (70*Pi^2)/(3*(-1 + Global`u)*Global`u) - 
       (6*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u) - 
       (21*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (230*Log[1 - Global`u])/(3*(-1 + Global`u)*Global`u) - ((46*I)*Pi*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u) + (73*Log[1 - Global`u]^2)/(2*(-1 + Global`u)*Global`u) + 
       (21*Log[1 - Global`u]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u) + 
       (21*Log[Global`u^(-1)]^2)/(2*(-1 + Global`u)*Global`u) - 
       (6*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (3*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u) + 
       (140*Log[Global`u])/(3*(-1 + Global`u)*Global`u) - ((28*I)*Pi*Log[Global`u])/
        ((-1 + Global`u)*Global`u) + (46*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u) + (14*Log[Global`u]^2)/((-1 + Global`u)*Global`u))/Global`\[Epsilon]^4 + 
     (4928/(3*(-1 + Global`u)*Global`u) - (((1232*I)/3)*Pi)/((-1 + Global`u)*Global`u) + 
       (700*Pi^2)/(9*(-1 + Global`u)*Global`u) - ((28*I)*Pi^3)/((-1 + Global`u)*Global`u) + 
       (20*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u) - 
       ((12*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u) + 
       (70*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) - 
       ((42*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (6*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u) - 
       (30*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (6*PolyLogTools`G[0, 1, Global`u, 1])/((-1 + Global`u)*Global`u) - 
       (15*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/((-1 + Global`u)*Global`u) + 
       (12*PolyLogTools`G[0, Global`u, 1, 1])/((-1 + Global`u)*Global`u) - 
       (18*PolyLogTools`G[0, Global`u, Global`u, 1])/((-1 + Global`u)*Global`u) - 
       (45*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/((-1 + Global`u)*Global`u) + 
       (9*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)*Global`u) + (2024*Log[1 - Global`u])/(3*(-1 + Global`u)*Global`u) + 
       (((460*I)/3)*Pi*Log[1 - Global`u])/((-1 + Global`u)*Global`u) + 
       (221*Pi^2*Log[1 - Global`u])/(3*(-1 + Global`u)*Global`u) + 
       (18*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/((-1 + Global`u)*Global`u) + 
       (18*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u) - (365*Log[1 - Global`u]^2)/(3*(-1 + Global`u)*Global`u) + 
       ((73*I)*Pi*Log[1 - Global`u]^2)/((-1 + Global`u)*Global`u) - (227*Log[1 - Global`u]^3)/
        (6*(-1 + Global`u)*Global`u) + (25*Pi^2*Log[Global`u^(-1)])/(2*(-1 + Global`u)*Global`u) + 
       (66*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u) + 
       (6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u) - (70*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u) + ((42*I)*Pi*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u) - (24*Log[1 - Global`u]^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u) - (33*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u) + (33*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/
        (2*(-1 + Global`u)*Global`u) - (35*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u) + 
       ((21*I)*Pi*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u) + 
       (6*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u) - 
       (27*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/(2*(-1 + Global`u)*Global`u) + 
       Log[Global`u^(-1)]^3/(2*(-1 + Global`u)*Global`u) - (10*Pi^2*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u) - (12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (20*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) - 
       ((12*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (18*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) - 
       (24*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u) - (12*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u) - (12*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) + 
       (6*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) - 
       (10*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u) + 
       ((6*I)*Pi*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u) - 
       (18*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u) + 
       (2*Log[(-1 + Global`u)/Global`u]^3)/((-1 + Global`u)*Global`u) + 
       (1232*Log[Global`u])/(3*(-1 + Global`u)*Global`u) + (((280*I)/3)*Pi*Log[Global`u])/
        ((-1 + Global`u)*Global`u) + (140*Pi^2*Log[Global`u])/(3*(-1 + Global`u)*Global`u) + 
       (12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/((-1 + Global`u)*Global`u) + 
       (42*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u) - (460*Log[1 - Global`u]*Log[Global`u])/
        (3*(-1 + Global`u)*Global`u) + ((92*I)*Pi*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u) - (73*Log[1 - Global`u]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u) - (42*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/
        ((-1 + Global`u)*Global`u) - (21*Log[Global`u^(-1)]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u) + (12*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*
         Log[Global`u])/((-1 + Global`u)*Global`u) - (6*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u])/((-1 + Global`u)*Global`u) - (140*Log[Global`u]^2)/
        (3*(-1 + Global`u)*Global`u) + ((28*I)*Pi*Log[Global`u]^2)/((-1 + Global`u)*Global`u) - 
       (46*Log[1 - Global`u]*Log[Global`u]^2)/((-1 + Global`u)*Global`u) - 
       (28*Log[Global`u]^3)/(3*(-1 + Global`u)*Global`u) - (2522*Zeta[3])/
        (3*(-1 + Global`u)*Global`u))/Global`\[Epsilon]^3, 
   "Validation" -> <|"AllDistinctSourceKernelsChecked" -> True, "TwoParameterValues" -> {1/3, 2/3}, 
     "PoleChambersPreserved" -> True, "ExactCoefficientAtoms" -> True, "SourceKernelCount" -> 14, 
     "CheckManifest" -> "family_source_check_status.json"|>, "Complete" -> True, 
   "Source" -> "differential_u_20260920/campaign/MB5u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB6u" -> <|"Route" -> "Standard", "Orders" -> {-5, -2}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> -1, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-5 -> -7/Global`u, 
     -4 -> 115/(3*Global`u) - 10/((-1 + Global`u)*Global`u) - ((14*I)*Pi)/Global`u + 
       (14*Log[Global`u])/Global`u, -3 -> 367/(3*Global`u) + 250/(3*(-1 + Global`u)*Global`u) + 
       (((230*I)/3)*Pi)/Global`u - ((20*I)*Pi)/((-1 + Global`u)*Global`u) + 
       (37*Pi^2)/(2*Global`u) - (60*PolyLogTools`G[0, 1, -1])/Global`u + 
       (2*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u - 
       (30*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/Global`u + 
       (50*Log[1 - Global`u])/((-1 + Global`u)*Global`u) + 
       (30*Log[1 - Global`u]*Log[-1 + Global`u])/Global`u - (15*Log[-1 + Global`u]^2)/Global`u + 
       (30*Log[1 - Global`u]*Log[Global`u^(-1)])/Global`u + (15*Log[Global`u^(-1)]^2)/Global`u + 
       (2*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u - 
       Log[(-1 + Global`u)/Global`u]^2/Global`u - (230*Log[Global`u])/(3*Global`u) + 
       (20*Log[Global`u])/((-1 + Global`u)*Global`u) + ((28*I)*Pi*Log[Global`u])/Global`u - 
       (14*Log[Global`u]^2)/Global`u, -2 -> -5693/(3*Global`u) - 190/(3*(-1 + Global`u)*Global`u) + 
       (((734*I)/3)*Pi)/Global`u + (((500*I)/3)*Pi)/((-1 + Global`u)*Global`u) - 
       (601*Pi^2)/(6*Global`u) + (97*Pi^2)/(3*(-1 + Global`u)*Global`u) + 
       (((55*I)/3)*Pi^3)/Global`u + (320*PolyLogTools`G[0, 1, -1])/Global`u - 
       ((120*I)*Pi*PolyLogTools`G[0, 1, -1])/Global`u - (6*PolyLogTools`G[0, 1, Global`u^(-1)])/
        (-1 + Global`u) - (38*PolyLogTools`G[0, 1, Global`u^(-1)])/(3*Global`u) + 
       ((4*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u + 
       (60*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/(-1 + Global`u) + 
       (100*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/Global`u - 
       ((60*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/Global`u - 
       (60*PolyLogTools`G[-1, 0, -1, 1])/Global`u + (60*PolyLogTools`G[0, 0, 1, -1])/Global`u - 
       (4*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/Global`u + 
       (150*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/Global`u + 
       (2*PolyLogTools`G[0, 1, Global`u, 1])/Global`u - 
       (30*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/Global`u - 
       (2*PolyLogTools`G[0, Global`u, 1, 1])/Global`u - 
       (2*PolyLogTools`G[0, Global`u, Global`u, 1])/Global`u + 
       (120*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/Global`u + 
       (30*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/Global`u - 
       (60*PolyLogTools`G[0, 1, -1]*Log[2])/Global`u - (6*PolyLogTools`G[0, 1, Global`u^(-1)]*
         Log[(1 - Global`u)^(-1)])/Global`u - (1250*Log[1 - Global`u])/
        (3*(-1 + Global`u)*Global`u) + ((100*I)*Pi*Log[1 - Global`u])/((-1 + Global`u)*Global`u) + 
       (5*Pi^2*Log[1 - Global`u])/Global`u - (120*PolyLogTools`G[-1, -1, 1]*Log[1 - Global`u])/
        Global`u + (240*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u])/Global`u - 
       (4*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/Global`u + 
       (150*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/Global`u + 
       (60*Log[2]^2*Log[1 - Global`u])/Global`u - (125*Log[1 - Global`u]^2)/
        ((-1 + Global`u)*Global`u) + (6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)])/
        ((-1 + Global`u)*Global`u) - (3*Log[(-1 + Global`u)^(-1)]^2)/((-1 + Global`u)*Global`u) + 
       (40*Pi^2*Log[-1 + Global`u])/Global`u + (120*PolyLogTools`G[-1, -1, 1]*Log[-1 + Global`u])/
        Global`u - (240*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u])/Global`u - 
       (60*Log[2]^2*Log[-1 + Global`u])/Global`u - (160*Log[1 - Global`u]*Log[-1 + Global`u])/
        Global`u + ((60*I)*Pi*Log[1 - Global`u]*Log[-1 + Global`u])/Global`u - 
       (30*Log[1 - Global`u]^2*Log[-1 + Global`u])/Global`u + 
       (60*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u])/Global`u + 
       (30*Log[(-1 + Global`u)^(-1)]^2*Log[-1 + Global`u])/Global`u + 
       (80*Log[-1 + Global`u]^2)/Global`u - ((30*I)*Pi*Log[-1 + Global`u]^2)/Global`u + 
       (30*Log[1 - Global`u]*Log[-1 + Global`u]^2)/Global`u + 
       (120*PolyLogTools`G[0, 1, -1]*Log[2*(-1 + Global`u)])/Global`u + 
       (20*Pi^2*Log[Global`u^(-1)])/Global`u + (120*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/
        Global`u - (60*Log[1 - Global`u]*Log[Global`u^(-1)])/(-1 + Global`u) - 
       (100*Log[1 - Global`u]*Log[Global`u^(-1)])/Global`u + 
       ((60*I)*Pi*Log[1 - Global`u]*Log[Global`u^(-1)])/Global`u - 
       (30*Log[1 - Global`u]^2*Log[Global`u^(-1)])/Global`u + 
       (60*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)])/Global`u + 
       (30*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)])/Global`u - 
       (60*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/Global`u + 
       (30*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/Global`u - (30*Log[Global`u^(-1)]^2)/
        (-1 + Global`u) - (50*Log[Global`u^(-1)]^2)/Global`u + ((30*I)*Pi*Log[Global`u^(-1)]^2)/
        Global`u - (90*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/Global`u - 
       (30*Log[Global`u^(-1)]^3)/Global`u - (2*Pi^2*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/(-1 + Global`u) - 
       (38*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/(3*Global`u) + 
       ((4*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u - 
       (2*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/
        Global`u - (3*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (3*Log[(-1 + Global`u)/Global`u]^2)/(-1 + Global`u) + (19*Log[(-1 + Global`u)/Global`u]^2)/
        (3*Global`u) - ((2*I)*Pi*Log[(-1 + Global`u)/Global`u]^2)/Global`u + 
       (3*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2)/Global`u + 
       (Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/Global`u + 
       Log[(-1 + Global`u)/Global`u]^3/Global`u - (734*Log[Global`u])/(3*Global`u) - 
       (500*Log[Global`u])/(3*(-1 + Global`u)*Global`u) - (((460*I)/3)*Pi*Log[Global`u])/Global`u + 
       ((40*I)*Pi*Log[Global`u])/((-1 + Global`u)*Global`u) - (37*Pi^2*Log[Global`u])/Global`u + 
       (120*PolyLogTools`G[0, 1, -1]*Log[Global`u])/Global`u - 
       (4*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/Global`u + 
       (60*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/Global`u - 
       (100*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)*Global`u) - 
       (60*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u])/Global`u + 
       (30*Log[-1 + Global`u]^2*Log[Global`u])/Global`u - 
       (60*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/Global`u - 
       (30*Log[Global`u^(-1)]^2*Log[Global`u])/Global`u - 
       (4*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*Log[Global`u])/Global`u + 
       (2*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u])/Global`u + 
       (230*Log[Global`u]^2)/(3*Global`u) - (20*Log[Global`u]^2)/((-1 + Global`u)*Global`u) - 
       ((28*I)*Pi*Log[Global`u]^2)/Global`u + (28*Log[Global`u]^3)/(3*Global`u) + 
       (2294*Zeta[3])/(3*Global`u)|>, "Series" -> -7/(Global`u*Global`\[Epsilon]^5) + 
     (115/(3*Global`u) - ((14*I)*Pi)/Global`u - 10/((-1 + Global`u)*Global`u) + 
       (14*Log[Global`u])/Global`u)/Global`\[Epsilon]^4 + (367/(3*Global`u) + (((230*I)/3)*Pi)/Global`u + 
       (37*Pi^2)/(2*Global`u) + 250/(3*(-1 + Global`u)*Global`u) - 
       ((20*I)*Pi)/((-1 + Global`u)*Global`u) - (60*PolyLogTools`G[0, 1, -1])/Global`u + 
       (2*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u - 
       (30*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/Global`u + 
       (50*Log[1 - Global`u])/((-1 + Global`u)*Global`u) + 
       (30*Log[1 - Global`u]*Log[-1 + Global`u])/Global`u - (15*Log[-1 + Global`u]^2)/Global`u + 
       (30*Log[1 - Global`u]*Log[Global`u^(-1)])/Global`u + (15*Log[Global`u^(-1)]^2)/Global`u + 
       (2*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u - 
       Log[(-1 + Global`u)/Global`u]^2/Global`u - (230*Log[Global`u])/(3*Global`u) + 
       ((28*I)*Pi*Log[Global`u])/Global`u + (20*Log[Global`u])/((-1 + Global`u)*Global`u) - 
       (14*Log[Global`u]^2)/Global`u)/Global`\[Epsilon]^3 + 
     (-5693/(3*Global`u) + (((734*I)/3)*Pi)/Global`u - (601*Pi^2)/(6*Global`u) + 
       (((55*I)/3)*Pi^3)/Global`u - 190/(3*(-1 + Global`u)*Global`u) + 
       (((500*I)/3)*Pi)/((-1 + Global`u)*Global`u) + (97*Pi^2)/(3*(-1 + Global`u)*Global`u) + 
       (320*PolyLogTools`G[0, 1, -1])/Global`u - ((120*I)*Pi*PolyLogTools`G[0, 1, -1])/Global`u - 
       (6*PolyLogTools`G[0, 1, Global`u^(-1)])/(-1 + Global`u) - 
       (38*PolyLogTools`G[0, 1, Global`u^(-1)])/(3*Global`u) + 
       ((4*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u + 
       (60*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/(-1 + Global`u) + 
       (100*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/Global`u - 
       ((60*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/Global`u - 
       (60*PolyLogTools`G[-1, 0, -1, 1])/Global`u + (60*PolyLogTools`G[0, 0, 1, -1])/Global`u - 
       (4*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/Global`u + 
       (150*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/Global`u + 
       (2*PolyLogTools`G[0, 1, Global`u, 1])/Global`u - 
       (30*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/Global`u - 
       (2*PolyLogTools`G[0, Global`u, 1, 1])/Global`u - 
       (2*PolyLogTools`G[0, Global`u, Global`u, 1])/Global`u + 
       (120*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/Global`u + 
       (30*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/Global`u - 
       (60*PolyLogTools`G[0, 1, -1]*Log[2])/Global`u - (6*PolyLogTools`G[0, 1, Global`u^(-1)]*
         Log[(1 - Global`u)^(-1)])/Global`u + (5*Pi^2*Log[1 - Global`u])/Global`u - 
       (1250*Log[1 - Global`u])/(3*(-1 + Global`u)*Global`u) + ((100*I)*Pi*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u) - (120*PolyLogTools`G[-1, -1, 1]*Log[1 - Global`u])/Global`u + 
       (240*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u])/Global`u - 
       (4*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/Global`u + 
       (150*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/Global`u + 
       (60*Log[2]^2*Log[1 - Global`u])/Global`u - (125*Log[1 - Global`u]^2)/
        ((-1 + Global`u)*Global`u) + (6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)])/
        ((-1 + Global`u)*Global`u) - (3*Log[(-1 + Global`u)^(-1)]^2)/((-1 + Global`u)*Global`u) + 
       (40*Pi^2*Log[-1 + Global`u])/Global`u + (120*PolyLogTools`G[-1, -1, 1]*Log[-1 + Global`u])/
        Global`u - (240*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u])/Global`u - 
       (60*Log[2]^2*Log[-1 + Global`u])/Global`u - (160*Log[1 - Global`u]*Log[-1 + Global`u])/
        Global`u + ((60*I)*Pi*Log[1 - Global`u]*Log[-1 + Global`u])/Global`u - 
       (30*Log[1 - Global`u]^2*Log[-1 + Global`u])/Global`u + 
       (60*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u])/Global`u + 
       (30*Log[(-1 + Global`u)^(-1)]^2*Log[-1 + Global`u])/Global`u + 
       (80*Log[-1 + Global`u]^2)/Global`u - ((30*I)*Pi*Log[-1 + Global`u]^2)/Global`u + 
       (30*Log[1 - Global`u]*Log[-1 + Global`u]^2)/Global`u + 
       (120*PolyLogTools`G[0, 1, -1]*Log[2*(-1 + Global`u)])/Global`u + 
       (20*Pi^2*Log[Global`u^(-1)])/Global`u + (120*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/
        Global`u - (60*Log[1 - Global`u]*Log[Global`u^(-1)])/(-1 + Global`u) - 
       (100*Log[1 - Global`u]*Log[Global`u^(-1)])/Global`u + 
       ((60*I)*Pi*Log[1 - Global`u]*Log[Global`u^(-1)])/Global`u - 
       (30*Log[1 - Global`u]^2*Log[Global`u^(-1)])/Global`u + 
       (60*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)])/Global`u + 
       (30*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)])/Global`u - 
       (60*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/Global`u + 
       (30*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/Global`u - (30*Log[Global`u^(-1)]^2)/
        (-1 + Global`u) - (50*Log[Global`u^(-1)]^2)/Global`u + ((30*I)*Pi*Log[Global`u^(-1)]^2)/
        Global`u - (90*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/Global`u - 
       (30*Log[Global`u^(-1)]^3)/Global`u - (2*Pi^2*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/(-1 + Global`u) - 
       (38*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/(3*Global`u) + 
       ((4*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u - 
       (2*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/
        Global`u - (3*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (3*Log[(-1 + Global`u)/Global`u]^2)/(-1 + Global`u) + (19*Log[(-1 + Global`u)/Global`u]^2)/
        (3*Global`u) - ((2*I)*Pi*Log[(-1 + Global`u)/Global`u]^2)/Global`u + 
       (3*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2)/Global`u + 
       (Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/Global`u + 
       Log[(-1 + Global`u)/Global`u]^3/Global`u - (734*Log[Global`u])/(3*Global`u) - 
       (((460*I)/3)*Pi*Log[Global`u])/Global`u - (37*Pi^2*Log[Global`u])/Global`u - 
       (500*Log[Global`u])/(3*(-1 + Global`u)*Global`u) + ((40*I)*Pi*Log[Global`u])/
        ((-1 + Global`u)*Global`u) + (120*PolyLogTools`G[0, 1, -1]*Log[Global`u])/Global`u - 
       (4*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/Global`u + 
       (60*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/Global`u - 
       (100*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)*Global`u) - 
       (60*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u])/Global`u + 
       (30*Log[-1 + Global`u]^2*Log[Global`u])/Global`u - 
       (60*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/Global`u - 
       (30*Log[Global`u^(-1)]^2*Log[Global`u])/Global`u - 
       (4*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*Log[Global`u])/Global`u + 
       (2*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u])/Global`u + 
       (230*Log[Global`u]^2)/(3*Global`u) - ((28*I)*Pi*Log[Global`u]^2)/Global`u - 
       (20*Log[Global`u]^2)/((-1 + Global`u)*Global`u) + (28*Log[Global`u]^3)/(3*Global`u) + 
       (2294*Zeta[3])/(3*Global`u))/Global`\[Epsilon]^2, "Validation" -> 
    <|"AllDistinctSourceKernelsChecked" -> True, "TwoParameterValues" -> {1/3, 2/3}, 
     "PoleChambersPreserved" -> True, "ExactCoefficientAtoms" -> True, "SourceKernelCount" -> 15, 
     "CheckManifest" -> "family_source_check_status.json"|>, "Complete" -> True, 
   "Source" -> "differential_u_20260920/campaign/MB6u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB7u" -> <|"Route" -> "Standard", "Orders" -> {-5, -1}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> 0, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-5 -> 20/Global`u^2, 
     -4 -> (-20*(13 + 3*Log[1 - Global`u] + 9*Log[Global`u]))/(3*Global`u^2), 
     -3 -> (-10*(162 + 12*Pi^2 - 26*Log[1 - Global`u] - 3*Log[1 - Global`u]^2 - 78*Log[Global`u] - 
         18*Log[1 - Global`u]*Log[Global`u] - 27*Log[Global`u]^2))/(3*Global`u^2), 
     -2 -> (2*(8350 + 260*Pi^2 + 810*Log[1 - Global`u] + 60*Pi^2*Log[1 - Global`u] - 
         65*Log[1 - Global`u]^2 - 5*Log[1 - Global`u]^3 + 2430*Log[Global`u] + 
         180*Pi^2*Log[Global`u] - 390*Log[1 - Global`u]*Log[Global`u] - 
         45*Log[1 - Global`u]^2*Log[Global`u] - 585*Log[Global`u]^2 - 135*Log[1 - Global`u]*
          Log[Global`u]^2 - 135*Log[Global`u]^3 - 3416*Zeta[3]))/(3*Global`u^2), 
     -1 -> -1/18*(473400 - 19440*Pi^2 + 2628*Pi^4 + 100200*Log[1 - Global`u] + 
         3120*Pi^2*Log[1 - Global`u] + 4860*Log[1 - Global`u]^2 + 360*Pi^2*Log[1 - Global`u]^2 - 
         260*Log[1 - Global`u]^3 - 15*Log[1 - Global`u]^4 + 300600*Log[Global`u] + 
         9360*Pi^2*Log[Global`u] + 29160*Log[1 - Global`u]*Log[Global`u] + 
         2160*Pi^2*Log[1 - Global`u]*Log[Global`u] - 2340*Log[1 - Global`u]^2*Log[Global`u] - 
         180*Log[1 - Global`u]^3*Log[Global`u] + 43740*Log[Global`u]^2 + 
         3240*Pi^2*Log[Global`u]^2 - 7020*Log[1 - Global`u]*Log[Global`u]^2 - 
         810*Log[1 - Global`u]^2*Log[Global`u]^2 - 7020*Log[Global`u]^3 - 
         1620*Log[1 - Global`u]*Log[Global`u]^3 - 1215*Log[Global`u]^4 - 177632*Zeta[3] - 
         40992*Log[1 - Global`u]*Zeta[3] - 122976*Log[Global`u]*Zeta[3])/Global`u^2|>, 
   "Series" -> 20/(Global`u^2*Global`\[Epsilon]^5) - (20*(13 + 3*Log[1 - Global`u] + 9*Log[Global`u]))/
      (3*Global`u^2*Global`\[Epsilon]^4) - (10*(162 + 12*Pi^2 - 26*Log[1 - Global`u] - 
        3*Log[1 - Global`u]^2 - 78*Log[Global`u] - 18*Log[1 - Global`u]*Log[Global`u] - 
        27*Log[Global`u]^2))/(3*Global`u^2*Global`\[Epsilon]^3) + 
     (2*(8350 + 260*Pi^2 + 810*Log[1 - Global`u] + 60*Pi^2*Log[1 - Global`u] - 
        65*Log[1 - Global`u]^2 - 5*Log[1 - Global`u]^3 + 2430*Log[Global`u] + 
        180*Pi^2*Log[Global`u] - 390*Log[1 - Global`u]*Log[Global`u] - 
        45*Log[1 - Global`u]^2*Log[Global`u] - 585*Log[Global`u]^2 - 135*Log[1 - Global`u]*
         Log[Global`u]^2 - 135*Log[Global`u]^3 - 3416*Zeta[3]))/(3*Global`u^2*Global`\[Epsilon]^2) - 
     (473400 - 19440*Pi^2 + 2628*Pi^4 + 100200*Log[1 - Global`u] + 3120*Pi^2*Log[1 - Global`u] + 
       4860*Log[1 - Global`u]^2 + 360*Pi^2*Log[1 - Global`u]^2 - 260*Log[1 - Global`u]^3 - 
       15*Log[1 - Global`u]^4 + 300600*Log[Global`u] + 9360*Pi^2*Log[Global`u] + 
       29160*Log[1 - Global`u]*Log[Global`u] + 2160*Pi^2*Log[1 - Global`u]*Log[Global`u] - 
       2340*Log[1 - Global`u]^2*Log[Global`u] - 180*Log[1 - Global`u]^3*Log[Global`u] + 
       43740*Log[Global`u]^2 + 3240*Pi^2*Log[Global`u]^2 - 7020*Log[1 - Global`u]*Log[Global`u]^2 - 
       810*Log[1 - Global`u]^2*Log[Global`u]^2 - 7020*Log[Global`u]^3 - 
       1620*Log[1 - Global`u]*Log[Global`u]^3 - 1215*Log[Global`u]^4 - 177632*Zeta[3] - 
       40992*Log[1 - Global`u]*Zeta[3] - 122976*Log[Global`u]*Zeta[3])/(18*Global`u^2*Global`\[Epsilon]), 
   "Validation" -> <|"SourceKernelRatio" -> True, "GammaRatioExpansion" -> True, 
     "PreviousStandardResultExact" -> True, "StandardResolveExpandSaved" -> True|>, 
   "Complete" -> True, "Source" -> "differential_u_20260920/campaign/MB7u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB8u" -> <|"Route" -> "Standard", "Orders" -> {-6, -3}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> -2, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-6 -> (3*(-12 + 7*Global`u))/((-1 + Global`u)^2*Global`u^2), 
     -5 -> (36 - 35*Global`u - 21*Global`u^2 + (42*I)*Global`u*Pi + 144*Log[1 - Global`u] - 
        69*Global`u*Log[1 - Global`u] + 108*Log[Global`u] - 42*Global`u*Log[Global`u])/
       ((-1 + Global`u)^2*Global`u^2), -4 -> (9144 - 5290*Global`u + 606*Global`u^2 - 
        (276*I)*Global`u*Pi - (252*I)*Global`u^2*Pi + 234*Pi^2 - 414*Global`u*Pi^2 - 
        36*PolyLogTools`G[0, 1, -1] + 36*Global`u*PolyLogTools`G[0, 1, -1] + 
        90*PolyLogTools`G[0, 1, Global`u^(-1)] - 108*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)] + 
        1170*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
        378*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
        108*Log[(1 - Global`u)^(-1)] + 108*Global`u*Log[(1 - Global`u)^(-1)] - 
        756*Log[1 - Global`u] + 1356*Global`u*Log[1 - Global`u] - (828*I)*Global`u*Pi*
         Log[1 - Global`u] - 1836*Log[1 - Global`u]^2 + 666*Global`u*Log[1 - Global`u]^2 + 
        108*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)] - 54*Log[(-1 + Global`u)^(-1)]^2 + 
        18*Log[1 - Global`u]*Log[-1 + Global`u] - 18*Global`u*Log[1 - Global`u]*
         Log[-1 + Global`u] - 9*Log[-1 + Global`u]^2 + 9*Global`u*Log[-1 + Global`u]^2 + 
        108*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] - 1062*Log[1 - Global`u]*
         Log[Global`u^(-1)] + 378*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)] - 
        585*Log[Global`u^(-1)]^2 + 189*Global`u*Log[Global`u^(-1)]^2 + 
        108*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] + 
        90*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 45*Log[(-1 + Global`u)/Global`u]^2 + 
        54*Global`u*Log[(-1 + Global`u)/Global`u]^2 - 648*Log[Global`u] + 
        492*Global`u*Log[Global`u] + 252*Global`u^2*Log[Global`u] - (504*I)*Global`u*Pi*
         Log[Global`u] - 2592*Log[1 - Global`u]*Log[Global`u] + 828*Global`u*Log[1 - Global`u]*
         Log[Global`u] - 972*Log[Global`u]^2 + 252*Global`u*Log[Global`u]^2)/
       (6*(-1 + Global`u)^2*Global`u^2), -3 -> (-84560*Global`u + 58620*Global`u^2 + 
        5660*Global`u^3 - (21064*I)*Global`u^2*Pi + (2424*I)*Global`u^3*Pi + 24*Pi^2 + 
        504*Global`u*Pi^2 + 822*Global`u^2*Pi^2 + 582*Global`u^3*Pi^2 - (360*I)*Global`u*Pi^3 - 
        (984*I)*Global`u^2*Pi^3 - 576*PolyLogTools`G[-1, -1, 1] - 
        4320*Global`u*PolyLogTools`G[-1, -1, 1] + 4896*Global`u^2*PolyLogTools`G[-1, -1, 1] + 
        1152*PolyLogTools`G[0, 1, -1] - 10392*Global`u*PolyLogTools`G[0, 1, -1] + 
        1680*Global`u^2*PolyLogTools`G[0, 1, -1] - 1944*Global`u^3*PolyLogTools`G[0, 1, -1] - 
        (144*I)*Global`u*Pi*PolyLogTools`G[0, 1, -1] + (144*I)*Global`u^2*Pi*
         PolyLogTools`G[0, 1, -1] - 144*PolyLogTools`G[0, 1, Global`u^(-1)] + 
        420*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)] - 972*Global`u^2*
         PolyLogTools`G[0, 1, Global`u^(-1)] + 432*Global`u^3*PolyLogTools`G[0, 1, Global`u^(-1)] + 
        (360*I)*Global`u*Pi*PolyLogTools`G[0, 1, Global`u^(-1)] - (432*I)*Global`u^2*Pi*
         PolyLogTools`G[0, 1, Global`u^(-1)] - 576*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
        2316*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
        5076*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
        720*Global`u^3*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
        (360*I)*Global`u*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
        (1512*I)*Global`u^2*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
        432*Global`u*PolyLogTools`G[0, 1, Global`u] - 432*Global`u^2*PolyLogTools`G[0, 1, 
          Global`u] - 432*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] + 
        864*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] + 
        342*Global`u*PolyLogTools`G[-1, 0, -1, 1] + 90*Global`u^2*PolyLogTools`G[-1, 0, -1, 1] - 
        342*Global`u*PolyLogTools`G[0, 0, 1, -1] - 90*Global`u^2*PolyLogTools`G[0, 0, 1, -1] + 
        432*Global`u*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)] - 
        18*Global`u*PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 216*Global`u^2*
         PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 7344*Global`u*PolyLogTools`G[0, 0, 1, 
          (-1 + Global`u)/Global`u] - 1080*Global`u^2*PolyLogTools`G[0, 0, 1, 
          (-1 + Global`u)/Global`u] - 432*Global`u*PolyLogTools`G[0, 0, 1, Global`u] - 
        432*Global`u*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)] - 
        432*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] - 
        162*Global`u*PolyLogTools`G[0, 1, Global`u, 1] + 648*Global`u^2*
         PolyLogTools`G[0, 1, Global`u, 1] + 1764*Global`u*PolyLogTools`G[0, 1, 
          Global`u/(-1 + Global`u), 1] - 108*Global`u^2*PolyLogTools`G[0, 1, 
          Global`u/(-1 + Global`u), 1] + 216*Global`u*PolyLogTools`G[0, 1 - Global`u, 1, 1] - 
        432*Global`u*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] - 
        54*Global`u*PolyLogTools`G[0, Global`u, 1, 1] + 864*Global`u^2*PolyLogTools`G[0, Global`u, 
          1, 1] - 54*Global`u*PolyLogTools`G[0, Global`u, Global`u, 1] - 
        648*Global`u^2*PolyLogTools`G[0, Global`u, Global`u, 1] + 
        7956*Global`u*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] - 
        1188*Global`u^2*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] - 
        684*Global`u*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] + 
        324*Global`u^2*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] + 
        432*Global`u*PolyLogTools`G[Global`u^(-1), 0, 1, 1] + 342*Global`u*PolyLogTools`G[0, 1, -1]*
         Log[2] + 90*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[2] + 288*Log[2]^2 + 
        2160*Global`u*Log[2]^2 - 2448*Global`u^2*Log[2]^2 + 1800*Global`u*
         Log[(1 - Global`u)^(-1)] - 936*Global`u^2*Log[(1 - Global`u)^(-1)] - 
        348*Global`u*Pi^2*Log[(1 - Global`u)^(-1)] - 864*Global`u*PolyLogTools`G[-1, -1, 1]*
         Log[(1 - Global`u)^(-1)] - 864*Global`u*PolyLogTools`G[0, 1, -1]*
         Log[(1 - Global`u)^(-1)] + 72*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*
         Log[(1 - Global`u)^(-1)] - 432*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*
         Log[(1 - Global`u)^(-1)] - 792*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[(1 - Global`u)^(-1)] + 432*Global`u*Log[2]^2*Log[(1 - Global`u)^(-1)] + 
        144*Log[(1 - Global`u)^(-1)]^2 - 720*Global`u*Log[(1 - Global`u)^(-1)]^2 + 
        360*Global`u^2*Log[(1 - Global`u)^(-1)]^2 - 144*Global`u*Log[(1 - Global`u)^(-1)]^3 - 
        71208*Global`u*Log[1 - Global`u] + 27472*Global`u^2*Log[1 - Global`u] + 
        (4704*I)*Global`u^2*Pi*Log[1 - Global`u] - 2073*Global`u*Pi^2*Log[1 - Global`u] + 
        2547*Global`u^2*Pi^2*Log[1 - Global`u] - 1044*Global`u*PolyLogTools`G[-1, -1, 1]*
         Log[1 - Global`u] + 180*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[1 - Global`u] - 
        252*Global`u*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u] - 
        612*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u] - 
        900*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] + 
        216*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] - 
        3060*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] + 
        648*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] + 
        522*Global`u*Log[2]^2*Log[1 - Global`u] - 90*Global`u^2*Log[2]^2*Log[1 - Global`u] - 
        144*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 720*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[1 - Global`u] - 576*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] - 
        432*Global`u*Log[(1 - Global`u)^(-1)]^2*Log[1 - Global`u] + 
        3312*Global`u*Log[1 - Global`u]^2 - 6306*Global`u^2*Log[1 - Global`u]^2 - 
        126*Global`u^3*Log[1 - Global`u]^2 - (432*I)*Global`u*Pi*Log[1 - Global`u]^2 + 
        (2664*I)*Global`u^2*Pi*Log[1 - Global`u]^2 - 216*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[1 - Global`u]^2 + 5688*Global`u*Log[1 - Global`u]^3 - 
        1518*Global`u^2*Log[1 - Global`u]^3 - 864*Global`u*PolyLogTools`G[0, 1, -1]*
         Log[-2/(-1 + Global`u)] - 540*Global`u*Pi^2*Log[(-1 + Global`u)^(-1)] + 
        1728*Global`u*PolyLogTools`G[-1, -1, 1]*Log[(-1 + Global`u)^(-1)] - 
        1296*Global`u*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)^(-1)] - 
        864*Global`u*Log[2]^2*Log[(-1 + Global`u)^(-1)] + 720*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)^(-1)] - 216*Global`u^2*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)^(-1)] + (432*I)*Global`u*Pi*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)^(-1)] + 216*Global`u*Log[(1 - Global`u)^(-1)]^2*
         Log[(-1 + Global`u)^(-1)] + 4320*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)] - 
        216*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)] + 
        1800*Global`u*Log[(-1 + Global`u)^(-1)]^2 + 108*Global`u^2*Log[(-1 + Global`u)^(-1)]^2 - 
        (216*I)*Global`u*Pi*Log[(-1 + Global`u)^(-1)]^2 + 648*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)^(-1)]^2 + 108*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]^2 - 
        540*Global`u*Log[(-1 + Global`u)^(-1)]^3 - 93*Global`u*Pi^2*Log[-1 + Global`u] + 
        93*Global`u^2*Pi^2*Log[-1 + Global`u] + 180*Global`u*PolyLogTools`G[-1, -1, 1]*
         Log[-1 + Global`u] - 180*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[-1 + Global`u] - 
        72*Global`u*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u] + 
        72*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u] - 90*Global`u*Log[2]^2*
         Log[-1 + Global`u] + 90*Global`u^2*Log[2]^2*Log[-1 + Global`u] - 
        936*Global`u*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] + 
        1008*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] - 
        72*Global`u^3*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] + 1524*Global`u*Log[1 - Global`u]*
         Log[-1 + Global`u] + 1896*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u] + 
        900*Global`u^3*Log[1 - Global`u]*Log[-1 + Global`u] + (72*I)*Global`u*Pi*Log[1 - Global`u]*
         Log[-1 + Global`u] - (72*I)*Global`u^2*Pi*Log[1 - Global`u]*Log[-1 + Global`u] - 
        396*Global`u*Log[1 - Global`u]^2*Log[-1 + Global`u] + 396*Global`u^2*Log[1 - Global`u]^2*
         Log[-1 + Global`u] - 216*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*
         Log[-1 + Global`u] - 216*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
         Log[-1 + Global`u] + 216*Global`u^2*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
         Log[-1 + Global`u] - 108*Global`u*Log[(-1 + Global`u)^(-1)]^2*Log[-1 + Global`u] + 
        108*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*Log[-1 + Global`u] - 
        1230*Global`u*Log[-1 + Global`u]^2 - 444*Global`u^2*Log[-1 + Global`u]^2 - 
        486*Global`u^3*Log[-1 + Global`u]^2 - (36*I)*Global`u*Pi*Log[-1 + Global`u]^2 + 
        (36*I)*Global`u^2*Pi*Log[-1 + Global`u]^2 + 108*Global`u*Log[1 - Global`u]*
         Log[-1 + Global`u]^2 - 108*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u]^2 - 
        108*Global`u*Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u]^2 + 
        24*Global`u*Log[-1 + Global`u]^3 - 24*Global`u^2*Log[-1 + Global`u]^3 + 
        180*Global`u*PolyLogTools`G[0, 1, -1]*Log[2*(-1 + Global`u)] - 
        180*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[2*(-1 + Global`u)] - 
        2106*Global`u*Pi^2*Log[Global`u^(-1)] + 486*Global`u^2*Pi^2*Log[Global`u^(-1)] + 
        2880*Global`u*PolyLogTools`G[-1, -1, 1]*Log[Global`u^(-1)] + 
        3024*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[Global`u^(-1)] - 
        7272*Global`u*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)] + 
        1944*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)] + 
        432*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)] - 
        1080*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)] + 
        216*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)] - 
        1440*Global`u*Log[2]^2*Log[Global`u^(-1)] - 1512*Global`u^2*Log[2]^2*Log[Global`u^(-1)] - 
        576*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 360*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[Global`u^(-1)] + 504*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] - 
        72*Global`u^3*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 
        216*Global`u*Log[(1 - Global`u)^(-1)]^2*Log[Global`u^(-1)] + 
        2676*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)] - 4572*Global`u^2*Log[1 - Global`u]*
         Log[Global`u^(-1)] + 648*Global`u^3*Log[1 - Global`u]*Log[Global`u^(-1)] - 
        (360*I)*Global`u*Pi*Log[1 - Global`u]*Log[Global`u^(-1)] + (1512*I)*Global`u^2*Pi*
         Log[1 - Global`u]*Log[Global`u^(-1)] - 432*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[1 - Global`u]*Log[Global`u^(-1)] + 3060*Global`u*Log[1 - Global`u]^2*
         Log[Global`u^(-1)] - 864*Global`u^2*Log[1 - Global`u]^2*Log[Global`u^(-1)] - 
        648*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] - 
        216*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] + 
        216*Global`u^2*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] + 
        216*Global`u*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)] + 
        108*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)] + 
        864*Global`u*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 
        5220*Global`u*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)] - 
        972*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)] - 
        2178*Global`u*Log[-1 + Global`u]^2*Log[Global`u^(-1)] + 486*Global`u^2*Log[-1 + Global`u]^2*
         Log[Global`u^(-1)] + 288*Log[Global`u^(-1)]^2 + 1158*Global`u*Log[Global`u^(-1)]^2 - 
        2538*Global`u^2*Log[Global`u^(-1)]^2 + 360*Global`u^3*Log[Global`u^(-1)]^2 - 
        (180*I)*Global`u*Pi*Log[Global`u^(-1)]^2 + (756*I)*Global`u^2*Pi*Log[Global`u^(-1)]^2 - 
        216*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2 + 
        216*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2 + 
        1764*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)]^2 - 486*Global`u^2*Log[1 - Global`u]*
         Log[Global`u^(-1)]^2 - 570*Global`u*Log[Global`u^(-1)]^3 + 
        18*Global`u^2*Log[Global`u^(-1)]^3 - 60*Global`u*Pi^2*Log[(-1 + Global`u)/Global`u] - 
        468*Global`u^2*Pi^2*Log[(-1 + Global`u)/Global`u] + 1728*Global`u^2*
         PolyLogTools`G[-1, -1, 1]*Log[(-1 + Global`u)/Global`u] - 
        1296*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)/Global`u] - 
        216*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)/Global`u] - 
        864*Global`u^2*Log[2]^2*Log[(-1 + Global`u)/Global`u] + 144*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 504*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] + 1296*Global`u^2*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 432*Global`u^3*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] + (432*I)*Global`u^2*Pi*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] + 216*Global`u^2*Log[(1 - Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u] - 84*Global`u*Log[1 - Global`u]*
         Log[(-1 + Global`u)/Global`u] + 324*Global`u^2*Log[1 - Global`u]*
         Log[(-1 + Global`u)/Global`u] + (360*I)*Global`u*Pi*Log[1 - Global`u]*
         Log[(-1 + Global`u)/Global`u] - 216*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
         Log[(-1 + Global`u)/Global`u] - 900*Global`u*Log[1 - Global`u]^2*
         Log[(-1 + Global`u)/Global`u] + 144*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] + 
        1080*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 72*Global`u*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u] - 540*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u] - 216*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*
         Log[(-1 + Global`u)/Global`u] - 108*Global`u^2*Log[-1 + Global`u]^2*
         Log[(-1 + Global`u)/Global`u] - 216*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 432*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
         Log[(-1 + Global`u)/Global`u] + 108*Global`u*Log[Global`u^(-1)]^2*
         Log[(-1 + Global`u)/Global`u] + 72*Log[(-1 + Global`u)/Global`u]^2 - 
        210*Global`u*Log[(-1 + Global`u)/Global`u]^2 + 486*Global`u^2*Log[(-1 + Global`u)/Global`u]^
          2 - 216*Global`u^3*Log[(-1 + Global`u)/Global`u]^2 - (180*I)*Global`u*Pi*
         Log[(-1 + Global`u)/Global`u]^2 + (216*I)*Global`u^2*Pi*Log[(-1 + Global`u)/Global`u]^2 + 
        144*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
        540*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
        540*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2 - 
        108*Global`u^2*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2 - 
        216*Global`u^2*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
        12*Global`u*Log[(-1 + Global`u)/Global`u]^3 + 72*Global`u^2*Log[(-1 + Global`u)/Global`u]^
          3 - 54864*Global`u*Log[Global`u] + 21208*Global`u^2*Log[Global`u] - 
        2424*Global`u^3*Log[Global`u] + (1104*I)*Global`u^2*Pi*Log[Global`u] + 
        (1008*I)*Global`u^3*Pi*Log[Global`u] - 1584*Global`u*Pi^2*Log[Global`u] + 
        1656*Global`u^2*Pi^2*Log[Global`u] + 144*Global`u*PolyLogTools`G[0, 1, -1]*Log[Global`u] - 
        144*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[Global`u] - 
        360*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] + 
        432*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] - 
        6840*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] + 
        1512*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] + 
        648*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u] - 648*Global`u^2*
         Log[(1 - Global`u)^(-1)]*Log[Global`u] + 4536*Global`u*Log[1 - Global`u]*Log[Global`u] - 
        5784*Global`u^2*Log[1 - Global`u]*Log[Global`u] + (3312*I)*Global`u^2*Pi*Log[1 - Global`u]*
         Log[Global`u] + 10800*Global`u*Log[1 - Global`u]^2*Log[Global`u] - 
        2664*Global`u^2*Log[1 - Global`u]^2*Log[Global`u] - 432*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)^(-1)]*Log[Global`u] + 216*Global`u*Log[(-1 + Global`u)^(-1)]^2*
         Log[Global`u] - 72*Global`u*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u] + 
        72*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u] + 
        36*Global`u*Log[-1 + Global`u]^2*Log[Global`u] - 36*Global`u^2*Log[-1 + Global`u]^2*
         Log[Global`u] - 648*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*Log[Global`u] + 
        6192*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] - 
        1512*Global`u^2*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] + 
        3420*Global`u*Log[Global`u^(-1)]^2*Log[Global`u] - 756*Global`u^2*Log[Global`u^(-1)]^2*
         Log[Global`u] - 432*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*
         Log[Global`u] - 360*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*
         Log[Global`u] + 180*Global`u*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] - 
        216*Global`u^2*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] + 
        1944*Global`u*Log[Global`u]^2 - 1200*Global`u^2*Log[Global`u]^2 - 
        504*Global`u^3*Log[Global`u]^2 + (1008*I)*Global`u^2*Pi*Log[Global`u]^2 + 
        7776*Global`u*Log[1 - Global`u]*Log[Global`u]^2 - 1656*Global`u^2*Log[1 - Global`u]*
         Log[Global`u]^2 + 1944*Global`u*Log[Global`u]^3 - 336*Global`u^2*Log[Global`u]^3 - 
        108*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^2 + 
        60714*Global`u*Zeta[3] - 31038*Global`u^2*Zeta[3])/(12*(-1 + Global`u)^2*Global`u^3)|>, 
   "Series" -> (3*(-12 + 7*Global`u))/((-1 + Global`u)^2*Global`u^2*Global`\[Epsilon]^6) + 
     (36 - 35*Global`u + (42*I)*Pi*Global`u - 21*Global`u^2 + 144*Log[1 - Global`u] - 
       69*Global`u*Log[1 - Global`u] + 108*Log[Global`u] - 42*Global`u*Log[Global`u])/
      ((-1 + Global`u)^2*Global`u^2*Global`\[Epsilon]^5) + (9144 + 234*Pi^2 - 5290*Global`u - 
       (276*I)*Pi*Global`u - 414*Pi^2*Global`u + 606*Global`u^2 - (252*I)*Pi*Global`u^2 - 
       36*PolyLogTools`G[0, 1, -1] + 36*Global`u*PolyLogTools`G[0, 1, -1] + 
       90*PolyLogTools`G[0, 1, Global`u^(-1)] - 108*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)] + 
       1170*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       378*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 108*Log[(1 - Global`u)^(-1)] + 
       108*Global`u*Log[(1 - Global`u)^(-1)] - 756*Log[1 - Global`u] + 
       1356*Global`u*Log[1 - Global`u] - (828*I)*Pi*Global`u*Log[1 - Global`u] - 
       1836*Log[1 - Global`u]^2 + 666*Global`u*Log[1 - Global`u]^2 + 108*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)] - 54*Log[(-1 + Global`u)^(-1)]^2 + 
       18*Log[1 - Global`u]*Log[-1 + Global`u] - 18*Global`u*Log[1 - Global`u]*Log[-1 + Global`u] - 
       9*Log[-1 + Global`u]^2 + 9*Global`u*Log[-1 + Global`u]^2 + 108*Log[(1 - Global`u)^(-1)]*
        Log[Global`u^(-1)] - 1062*Log[1 - Global`u]*Log[Global`u^(-1)] + 
       378*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)] - 585*Log[Global`u^(-1)]^2 + 
       189*Global`u*Log[Global`u^(-1)]^2 + 108*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 90*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 
       45*Log[(-1 + Global`u)/Global`u]^2 + 54*Global`u*Log[(-1 + Global`u)/Global`u]^2 - 
       648*Log[Global`u] + 492*Global`u*Log[Global`u] - (504*I)*Pi*Global`u*Log[Global`u] + 
       252*Global`u^2*Log[Global`u] - 2592*Log[1 - Global`u]*Log[Global`u] + 
       828*Global`u*Log[1 - Global`u]*Log[Global`u] - 972*Log[Global`u]^2 + 
       252*Global`u*Log[Global`u]^2)/(6*(-1 + Global`u)^2*Global`u^2*Global`\[Epsilon]^4) + 
     (24*Pi^2 - 84560*Global`u + 504*Pi^2*Global`u - (360*I)*Pi^3*Global`u + 58620*Global`u^2 - 
       (21064*I)*Pi*Global`u^2 + 822*Pi^2*Global`u^2 - (984*I)*Pi^3*Global`u^2 + 5660*Global`u^3 + 
       (2424*I)*Pi*Global`u^3 + 582*Pi^2*Global`u^3 - 576*PolyLogTools`G[-1, -1, 1] - 
       4320*Global`u*PolyLogTools`G[-1, -1, 1] + 4896*Global`u^2*PolyLogTools`G[-1, -1, 1] + 
       1152*PolyLogTools`G[0, 1, -1] - 10392*Global`u*PolyLogTools`G[0, 1, -1] - 
       (144*I)*Pi*Global`u*PolyLogTools`G[0, 1, -1] + 1680*Global`u^2*PolyLogTools`G[0, 1, -1] + 
       (144*I)*Pi*Global`u^2*PolyLogTools`G[0, 1, -1] - 1944*Global`u^3*PolyLogTools`G[0, 1, -1] - 
       144*PolyLogTools`G[0, 1, Global`u^(-1)] + 420*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)] + 
       (360*I)*Pi*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)] - 
       972*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)] - (432*I)*Pi*Global`u^2*
        PolyLogTools`G[0, 1, Global`u^(-1)] + 432*Global`u^3*PolyLogTools`G[0, 1, Global`u^(-1)] - 
       576*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       2316*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       (360*I)*Pi*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       5076*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       (1512*I)*Pi*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       720*Global`u^3*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       432*Global`u*PolyLogTools`G[0, 1, Global`u] - 432*Global`u^2*PolyLogTools`G[0, 1, 
         Global`u] - 432*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] + 
       864*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] + 
       342*Global`u*PolyLogTools`G[-1, 0, -1, 1] + 90*Global`u^2*PolyLogTools`G[-1, 0, -1, 1] - 
       342*Global`u*PolyLogTools`G[0, 0, 1, -1] - 90*Global`u^2*PolyLogTools`G[0, 0, 1, -1] + 
       432*Global`u*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)] - 
       18*Global`u*PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 216*Global`u^2*
        PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 7344*Global`u*PolyLogTools`G[0, 0, 1, 
         (-1 + Global`u)/Global`u] - 1080*Global`u^2*PolyLogTools`G[0, 0, 1, 
         (-1 + Global`u)/Global`u] - 432*Global`u*PolyLogTools`G[0, 0, 1, Global`u] - 
       432*Global`u*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)] - 
       432*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] - 
       162*Global`u*PolyLogTools`G[0, 1, Global`u, 1] + 648*Global`u^2*
        PolyLogTools`G[0, 1, Global`u, 1] + 1764*Global`u*PolyLogTools`G[0, 1, 
         Global`u/(-1 + Global`u), 1] - 108*Global`u^2*PolyLogTools`G[0, 1, 
         Global`u/(-1 + Global`u), 1] + 216*Global`u*PolyLogTools`G[0, 1 - Global`u, 1, 1] - 
       432*Global`u*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] - 
       54*Global`u*PolyLogTools`G[0, Global`u, 1, 1] + 864*Global`u^2*PolyLogTools`G[0, Global`u, 
         1, 1] - 54*Global`u*PolyLogTools`G[0, Global`u, Global`u, 1] - 
       648*Global`u^2*PolyLogTools`G[0, Global`u, Global`u, 1] + 
       7956*Global`u*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] - 
       1188*Global`u^2*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] - 
       684*Global`u*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] + 
       324*Global`u^2*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] + 
       432*Global`u*PolyLogTools`G[Global`u^(-1), 0, 1, 1] + 342*Global`u*PolyLogTools`G[0, 1, -1]*
        Log[2] + 90*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[2] + 288*Log[2]^2 + 
       2160*Global`u*Log[2]^2 - 2448*Global`u^2*Log[2]^2 + 1800*Global`u*Log[(1 - Global`u)^(-1)] - 
       348*Pi^2*Global`u*Log[(1 - Global`u)^(-1)] - 936*Global`u^2*Log[(1 - Global`u)^(-1)] - 
       864*Global`u*PolyLogTools`G[-1, -1, 1]*Log[(1 - Global`u)^(-1)] - 
       864*Global`u*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)] + 
       72*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)] - 
       432*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)] - 
       792*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)] + 
       432*Global`u*Log[2]^2*Log[(1 - Global`u)^(-1)] + 144*Log[(1 - Global`u)^(-1)]^2 - 
       720*Global`u*Log[(1 - Global`u)^(-1)]^2 + 360*Global`u^2*Log[(1 - Global`u)^(-1)]^2 - 
       144*Global`u*Log[(1 - Global`u)^(-1)]^3 - 71208*Global`u*Log[1 - Global`u] - 
       2073*Pi^2*Global`u*Log[1 - Global`u] + 27472*Global`u^2*Log[1 - Global`u] + 
       (4704*I)*Pi*Global`u^2*Log[1 - Global`u] + 2547*Pi^2*Global`u^2*Log[1 - Global`u] - 
       1044*Global`u*PolyLogTools`G[-1, -1, 1]*Log[1 - Global`u] + 
       180*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[1 - Global`u] - 
       252*Global`u*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u] - 
       612*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u] - 
       900*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] + 
       216*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] - 
       3060*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] + 
       648*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] + 
       522*Global`u*Log[2]^2*Log[1 - Global`u] - 90*Global`u^2*Log[2]^2*Log[1 - Global`u] - 
       144*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 720*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[1 - Global`u] - 576*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] - 
       432*Global`u*Log[(1 - Global`u)^(-1)]^2*Log[1 - Global`u] + 
       3312*Global`u*Log[1 - Global`u]^2 - (432*I)*Pi*Global`u*Log[1 - Global`u]^2 - 
       6306*Global`u^2*Log[1 - Global`u]^2 + (2664*I)*Pi*Global`u^2*Log[1 - Global`u]^2 - 
       126*Global`u^3*Log[1 - Global`u]^2 - 216*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[1 - Global`u]^2 + 5688*Global`u*Log[1 - Global`u]^3 - 
       1518*Global`u^2*Log[1 - Global`u]^3 - 864*Global`u*PolyLogTools`G[0, 1, -1]*
        Log[-2/(-1 + Global`u)] - 540*Pi^2*Global`u*Log[(-1 + Global`u)^(-1)] + 
       1728*Global`u*PolyLogTools`G[-1, -1, 1]*Log[(-1 + Global`u)^(-1)] - 
       1296*Global`u*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)^(-1)] - 
       864*Global`u*Log[2]^2*Log[(-1 + Global`u)^(-1)] + 720*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)] + (432*I)*Pi*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)] - 216*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)] + 216*Global`u*Log[(1 - Global`u)^(-1)]^2*
        Log[(-1 + Global`u)^(-1)] + 4320*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)] - 
       216*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)] + 
       1800*Global`u*Log[(-1 + Global`u)^(-1)]^2 - (216*I)*Pi*Global`u*
        Log[(-1 + Global`u)^(-1)]^2 + 108*Global`u^2*Log[(-1 + Global`u)^(-1)]^2 + 
       648*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]^2 + 
       108*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]^2 - 
       540*Global`u*Log[(-1 + Global`u)^(-1)]^3 - 93*Pi^2*Global`u*Log[-1 + Global`u] + 
       93*Pi^2*Global`u^2*Log[-1 + Global`u] + 180*Global`u*PolyLogTools`G[-1, -1, 1]*
        Log[-1 + Global`u] - 180*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[-1 + Global`u] - 
       72*Global`u*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u] + 
       72*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u] - 90*Global`u*Log[2]^2*
        Log[-1 + Global`u] + 90*Global`u^2*Log[2]^2*Log[-1 + Global`u] - 
       936*Global`u*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] + 
       1008*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] - 
       72*Global`u^3*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] + 1524*Global`u*Log[1 - Global`u]*
        Log[-1 + Global`u] + (72*I)*Pi*Global`u*Log[1 - Global`u]*Log[-1 + Global`u] + 
       1896*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u] - (72*I)*Pi*Global`u^2*
        Log[1 - Global`u]*Log[-1 + Global`u] + 900*Global`u^3*Log[1 - Global`u]*
        Log[-1 + Global`u] - 396*Global`u*Log[1 - Global`u]^2*Log[-1 + Global`u] + 
       396*Global`u^2*Log[1 - Global`u]^2*Log[-1 + Global`u] - 
       216*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] - 
       216*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] + 
       216*Global`u^2*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] - 
       108*Global`u*Log[(-1 + Global`u)^(-1)]^2*Log[-1 + Global`u] + 
       108*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*Log[-1 + Global`u] - 
       1230*Global`u*Log[-1 + Global`u]^2 - (36*I)*Pi*Global`u*Log[-1 + Global`u]^2 - 
       444*Global`u^2*Log[-1 + Global`u]^2 + (36*I)*Pi*Global`u^2*Log[-1 + Global`u]^2 - 
       486*Global`u^3*Log[-1 + Global`u]^2 + 108*Global`u*Log[1 - Global`u]*Log[-1 + Global`u]^2 - 
       108*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u]^2 - 
       108*Global`u*Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u]^2 + 
       24*Global`u*Log[-1 + Global`u]^3 - 24*Global`u^2*Log[-1 + Global`u]^3 + 
       180*Global`u*PolyLogTools`G[0, 1, -1]*Log[2*(-1 + Global`u)] - 
       180*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[2*(-1 + Global`u)] - 
       2106*Pi^2*Global`u*Log[Global`u^(-1)] + 486*Pi^2*Global`u^2*Log[Global`u^(-1)] + 
       2880*Global`u*PolyLogTools`G[-1, -1, 1]*Log[Global`u^(-1)] + 
       3024*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[Global`u^(-1)] - 
       7272*Global`u*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)] + 
       1944*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)] + 
       432*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)] - 
       1080*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)] + 
       216*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)] - 
       1440*Global`u*Log[2]^2*Log[Global`u^(-1)] - 1512*Global`u^2*Log[2]^2*Log[Global`u^(-1)] - 
       576*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 360*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[Global`u^(-1)] + 504*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] - 
       72*Global`u^3*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 
       216*Global`u*Log[(1 - Global`u)^(-1)]^2*Log[Global`u^(-1)] + 2676*Global`u*Log[1 - Global`u]*
        Log[Global`u^(-1)] - (360*I)*Pi*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)] - 
       4572*Global`u^2*Log[1 - Global`u]*Log[Global`u^(-1)] + (1512*I)*Pi*Global`u^2*
        Log[1 - Global`u]*Log[Global`u^(-1)] + 648*Global`u^3*Log[1 - Global`u]*
        Log[Global`u^(-1)] - 432*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[Global`u^(-1)] + 3060*Global`u*Log[1 - Global`u]^2*Log[Global`u^(-1)] - 
       864*Global`u^2*Log[1 - Global`u]^2*Log[Global`u^(-1)] - 
       648*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] - 
       216*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] + 
       216*Global`u^2*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] + 
       216*Global`u*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)] + 
       108*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)] + 
       864*Global`u*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 
       5220*Global`u*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)] - 
       972*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)] - 
       2178*Global`u*Log[-1 + Global`u]^2*Log[Global`u^(-1)] + 486*Global`u^2*Log[-1 + Global`u]^2*
        Log[Global`u^(-1)] + 288*Log[Global`u^(-1)]^2 + 1158*Global`u*Log[Global`u^(-1)]^2 - 
       (180*I)*Pi*Global`u*Log[Global`u^(-1)]^2 - 2538*Global`u^2*Log[Global`u^(-1)]^2 + 
       (756*I)*Pi*Global`u^2*Log[Global`u^(-1)]^2 + 360*Global`u^3*Log[Global`u^(-1)]^2 - 
       216*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2 + 
       216*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2 + 
       1764*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)]^2 - 486*Global`u^2*Log[1 - Global`u]*
        Log[Global`u^(-1)]^2 - 570*Global`u*Log[Global`u^(-1)]^3 + 
       18*Global`u^2*Log[Global`u^(-1)]^3 - 60*Pi^2*Global`u*Log[(-1 + Global`u)/Global`u] - 
       468*Pi^2*Global`u^2*Log[(-1 + Global`u)/Global`u] + 1728*Global`u^2*
        PolyLogTools`G[-1, -1, 1]*Log[(-1 + Global`u)/Global`u] - 
       1296*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)/Global`u] - 
       216*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)/Global`u] - 
       864*Global`u^2*Log[2]^2*Log[(-1 + Global`u)/Global`u] + 144*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 504*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 1296*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + (432*I)*Pi*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 432*Global`u^3*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 216*Global`u^2*Log[(1 - Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] - 84*Global`u*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] + (360*I)*Pi*Global`u*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] + 324*Global`u^2*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] - 216*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] - 900*Global`u*Log[1 - Global`u]^2*
        Log[(-1 + Global`u)/Global`u] + 144*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] + 
       1080*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 72*Global`u*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] - 540*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] - 216*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*
        Log[(-1 + Global`u)/Global`u] - 108*Global`u^2*Log[-1 + Global`u]^2*
        Log[(-1 + Global`u)/Global`u] - 216*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 432*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 108*Global`u*Log[Global`u^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] + 72*Log[(-1 + Global`u)/Global`u]^2 - 
       210*Global`u*Log[(-1 + Global`u)/Global`u]^2 - (180*I)*Pi*Global`u*
        Log[(-1 + Global`u)/Global`u]^2 + 486*Global`u^2*Log[(-1 + Global`u)/Global`u]^2 + 
       (216*I)*Pi*Global`u^2*Log[(-1 + Global`u)/Global`u]^2 - 
       216*Global`u^3*Log[(-1 + Global`u)/Global`u]^2 + 144*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u]^2 + 540*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u]^2 + 540*Global`u*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]^2 - 108*Global`u^2*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]^2 - 216*Global`u^2*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u]^2 + 12*Global`u*Log[(-1 + Global`u)/Global`u]^3 + 
       72*Global`u^2*Log[(-1 + Global`u)/Global`u]^3 - 54864*Global`u*Log[Global`u] - 
       1584*Pi^2*Global`u*Log[Global`u] + 21208*Global`u^2*Log[Global`u] + 
       (1104*I)*Pi*Global`u^2*Log[Global`u] + 1656*Pi^2*Global`u^2*Log[Global`u] - 
       2424*Global`u^3*Log[Global`u] + (1008*I)*Pi*Global`u^3*Log[Global`u] + 
       144*Global`u*PolyLogTools`G[0, 1, -1]*Log[Global`u] - 144*Global`u^2*
        PolyLogTools`G[0, 1, -1]*Log[Global`u] - 360*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[Global`u] + 432*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] - 
       6840*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] + 
       1512*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] + 
       648*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u] - 648*Global`u^2*
        Log[(1 - Global`u)^(-1)]*Log[Global`u] + 4536*Global`u*Log[1 - Global`u]*Log[Global`u] - 
       5784*Global`u^2*Log[1 - Global`u]*Log[Global`u] + (3312*I)*Pi*Global`u^2*Log[1 - Global`u]*
        Log[Global`u] + 10800*Global`u*Log[1 - Global`u]^2*Log[Global`u] - 
       2664*Global`u^2*Log[1 - Global`u]^2*Log[Global`u] - 432*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)]*Log[Global`u] + 216*Global`u*Log[(-1 + Global`u)^(-1)]^2*
        Log[Global`u] - 72*Global`u*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u] + 
       72*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u] + 
       36*Global`u*Log[-1 + Global`u]^2*Log[Global`u] - 36*Global`u^2*Log[-1 + Global`u]^2*
        Log[Global`u] - 648*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*Log[Global`u] + 
       6192*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] - 
       1512*Global`u^2*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] + 
       3420*Global`u*Log[Global`u^(-1)]^2*Log[Global`u] - 756*Global`u^2*Log[Global`u^(-1)]^2*
        Log[Global`u] - 432*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u] - 360*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u] + 180*Global`u*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] - 
       216*Global`u^2*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] + 
       1944*Global`u*Log[Global`u]^2 - 1200*Global`u^2*Log[Global`u]^2 + 
       (1008*I)*Pi*Global`u^2*Log[Global`u]^2 - 504*Global`u^3*Log[Global`u]^2 + 
       7776*Global`u*Log[1 - Global`u]*Log[Global`u]^2 - 1656*Global`u^2*Log[1 - Global`u]*
        Log[Global`u]^2 + 1944*Global`u*Log[Global`u]^3 - 336*Global`u^2*Log[Global`u]^3 - 
       108*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^2 + 
       60714*Global`u*Zeta[3] - 31038*Global`u^2*Zeta[3])/(12*(-1 + Global`u)^2*Global`u^3*
       Global`\[Epsilon]^3), "Validation" -> <|"AllDistinctSourceKernelsChecked" -> True, 
     "TwoParameterValues" -> {1/3, 2/3}, "ComponentManifest" -> "family_source_check_status.json", 
     "NumericalChecksOnly" -> True, "HighFoldDiagnosticTolerance" -> 1/10000, 
     "ExactCoefficientAtoms" -> True|>, "Complete" -> True, 
   "Source" -> "differential_u_20260920/campaign/MB8u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB9u" -> <|"Route" -> "Standard", "Orders" -> {-6, -3}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> -2, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-6 -> -24/((-1 + Global`u)*Global`u^2), 
     -5 -> 80/((-1 + Global`u)*Global`u^2) + (96*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) + 
       (72*Log[Global`u])/((-1 + Global`u)*Global`u^2), 
     -4 -> 704/((-1 + Global`u)*Global`u^2) + (72*Pi^2)/((-1 + Global`u)*Global`u^2) - 
       (108*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) + 
       (12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (320*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) - (138*Log[1 - Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) - (12*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) - (6*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^2) - 
       (108*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (54*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u^2) - 
       (240*Log[Global`u])/((-1 + Global`u)*Global`u^2) - (288*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) - (108*Log[Global`u]^2)/((-1 + Global`u)*Global`u^2), 
     -3 -> -5632/((-1 + Global`u)*Global`u^2) - (240*Pi^2)/((-1 + Global`u)*Global`u^2) + 
       (360*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (40*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (324*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) + 
       (48*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (108*PolyLogTools`G[0, 1, Global`u, 1])/((-1 + Global`u)*Global`u^2) - 
       (12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/((-1 + Global`u)*Global`u^2) + 
       (216*PolyLogTools`G[0, Global`u, 1, 1])/((-1 + Global`u)*Global`u^2) + 
       (108*PolyLogTools`G[0, Global`u, Global`u, 1])/((-1 + Global`u)*Global`u^2) + 
       (36*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/((-1 + Global`u)*Global`u^2) + 
       (36*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)*Global`u^2) - (2816*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) - 
       (270*Pi^2*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) + 
       (108*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) - 
       (12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^2) + (460*Log[1 - Global`u]^2)/((-1 + Global`u)*Global`u^2) + 
       (112*Log[1 - Global`u]^3)/((-1 + Global`u)*Global`u^2) - (10*Pi^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (24*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (24*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (40*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (24*Log[1 - Global`u]^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) - (12*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (6*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (20*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^2) - 
       (12*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^2) - 
       (14*Log[Global`u^(-1)]^3)/((-1 + Global`u)*Global`u^2) - 
       (180*Pi^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (360*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (108*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (216*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^2) - (108*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (24*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^2) - (180*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) - (12*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) - (72*Log[(-1 + Global`u)/Global`u]^3)/
        ((-1 + Global`u)*Global`u^2) - (2112*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       (216*Pi^2*Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       (324*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       (36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (960*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (414*Log[1 - Global`u]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (36*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (18*Log[Global`u^(-1)]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (324*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*
         Log[Global`u])/((-1 + Global`u)*Global`u^2) - (162*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u])/((-1 + Global`u)*Global`u^2) + (360*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + (432*Log[1 - Global`u]*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + (108*Log[Global`u]^3)/((-1 + Global`u)*Global`u^2) + 
       (3388*Zeta[3])/((-1 + Global`u)*Global`u^2)|>, 
   "Series" -> -24/((-1 + Global`u)*Global`u^2*Global`\[Epsilon]^6) + 
     (80/((-1 + Global`u)*Global`u^2) + (96*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) + 
       (72*Log[Global`u])/((-1 + Global`u)*Global`u^2))/Global`\[Epsilon]^5 + 
     (704/((-1 + Global`u)*Global`u^2) + (72*Pi^2)/((-1 + Global`u)*Global`u^2) - 
       (108*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) + 
       (12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (320*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) - (138*Log[1 - Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) - (12*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) - (6*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^2) - 
       (108*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (54*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u^2) - 
       (240*Log[Global`u])/((-1 + Global`u)*Global`u^2) - (288*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) - (108*Log[Global`u]^2)/((-1 + Global`u)*Global`u^2))/
      Global`\[Epsilon]^4 + (-5632/((-1 + Global`u)*Global`u^2) - (240*Pi^2)/((-1 + Global`u)*Global`u^2) + 
       (360*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (40*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (324*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) + 
       (48*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (108*PolyLogTools`G[0, 1, Global`u, 1])/((-1 + Global`u)*Global`u^2) - 
       (12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/((-1 + Global`u)*Global`u^2) + 
       (216*PolyLogTools`G[0, Global`u, 1, 1])/((-1 + Global`u)*Global`u^2) + 
       (108*PolyLogTools`G[0, Global`u, Global`u, 1])/((-1 + Global`u)*Global`u^2) + 
       (36*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/((-1 + Global`u)*Global`u^2) + 
       (36*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)*Global`u^2) - (2816*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) - 
       (270*Pi^2*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) + 
       (108*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) - 
       (12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^2) + (460*Log[1 - Global`u]^2)/((-1 + Global`u)*Global`u^2) + 
       (112*Log[1 - Global`u]^3)/((-1 + Global`u)*Global`u^2) - (10*Pi^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (24*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (24*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (40*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (24*Log[1 - Global`u]^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) - (12*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (6*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (20*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^2) - 
       (12*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^2) - 
       (14*Log[Global`u^(-1)]^3)/((-1 + Global`u)*Global`u^2) - 
       (180*Pi^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (360*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (108*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (216*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^2) - (108*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (24*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^2) - (180*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) - (12*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) - (72*Log[(-1 + Global`u)/Global`u]^3)/
        ((-1 + Global`u)*Global`u^2) - (2112*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       (216*Pi^2*Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       (324*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       (36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (960*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (414*Log[1 - Global`u]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (36*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (18*Log[Global`u^(-1)]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (324*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*
         Log[Global`u])/((-1 + Global`u)*Global`u^2) - (162*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u])/((-1 + Global`u)*Global`u^2) + (360*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + (432*Log[1 - Global`u]*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + (108*Log[Global`u]^3)/((-1 + Global`u)*Global`u^2) + 
       (3388*Zeta[3])/((-1 + Global`u)*Global`u^2))/Global`\[Epsilon]^3, 
   "Validation" -> <|"AllDistinctSourceKernelsChecked" -> True, "TwoParameterValues" -> {1/3, 2/3}, 
     "PoleChambersPreserved" -> True, "ExactCoefficientAtoms" -> True, "SourceKernelCount" -> 7, 
     "CheckManifest" -> "family_source_check_status.json"|>, "Complete" -> True, 
   "Source" -> "differential_u_20260920/campaign/MB9u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB10u" -> <|"Route" -> "Standard", "Orders" -> {-6, -3}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> -2, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-6 -> -72/((-1 + Global`u)*Global`u^3), 
     -5 -> 48/((-1 + Global`u)*Global`u^3) + (288*Log[1 - Global`u])/((-1 + Global`u)*Global`u^3) + 
       (216*Log[Global`u])/((-1 + Global`u)*Global`u^3), 
     -4 -> 2752/((-1 + Global`u)*Global`u^3) + (216*Pi^2)/((-1 + Global`u)*Global`u^3) - 
       (324*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^3) + 
       (36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) - 
       (192*Log[1 - Global`u])/((-1 + Global`u)*Global`u^3) - (414*Log[1 - Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) - (36*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) - (18*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^3) - 
       (324*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) + 
       (162*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u^3) - 
       (144*Log[Global`u])/((-1 + Global`u)*Global`u^3) - (864*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) - (324*Log[Global`u]^2)/((-1 + Global`u)*Global`u^3), 
     -3 -> -11264/((-1 + Global`u)*Global`u^3) - (144*Pi^2)/((-1 + Global`u)*Global`u^3) + 
       (216*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^3) - 
       (24*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) + 
       (972*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^3) + 
       (144*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) - 
       (324*PolyLogTools`G[0, 1, Global`u, 1])/((-1 + Global`u)*Global`u^3) - 
       (36*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/((-1 + Global`u)*Global`u^3) + 
       (648*PolyLogTools`G[0, Global`u, 1, 1])/((-1 + Global`u)*Global`u^3) + 
       (324*PolyLogTools`G[0, Global`u, Global`u, 1])/((-1 + Global`u)*Global`u^3) + 
       (108*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/((-1 + Global`u)*Global`u^3) + 
       (108*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)*Global`u^3) - (11008*Log[1 - Global`u])/((-1 + Global`u)*Global`u^3) - 
       (810*Pi^2*Log[1 - Global`u])/((-1 + Global`u)*Global`u^3) + 
       (324*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/((-1 + Global`u)*Global`u^3) - 
       (36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^3) + (276*Log[1 - Global`u]^2)/((-1 + Global`u)*Global`u^3) + 
       (336*Log[1 - Global`u]^3)/((-1 + Global`u)*Global`u^3) - (30*Pi^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) + (72*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) + (72*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) + (24*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) + (72*Log[1 - Global`u]^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) - (36*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) + (18*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) + (12*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^3) - 
       (36*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^3) - 
       (42*Log[Global`u^(-1)]^3)/((-1 + Global`u)*Global`u^3) - 
       (540*Pi^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) + 
       (216*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) + 
       (324*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) - 
       (648*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^3) - (324*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) - 
       (72*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^3) - (108*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) - (36*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) - (216*Log[(-1 + Global`u)/Global`u]^3)/
        ((-1 + Global`u)*Global`u^3) - (8256*Log[Global`u])/((-1 + Global`u)*Global`u^3) - 
       (648*Pi^2*Log[Global`u])/((-1 + Global`u)*Global`u^3) + 
       (972*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/((-1 + Global`u)*Global`u^3) - 
       (108*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) + (576*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) + (1242*Log[1 - Global`u]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) + (108*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) + (54*Log[Global`u^(-1)]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) + (972*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*
         Log[Global`u])/((-1 + Global`u)*Global`u^3) - (486*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u])/((-1 + Global`u)*Global`u^3) + (216*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) + (1296*Log[1 - Global`u]*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) + (324*Log[Global`u]^3)/((-1 + Global`u)*Global`u^3) + 
       (10164*Zeta[3])/((-1 + Global`u)*Global`u^3)|>, 
   "Series" -> -72/((-1 + Global`u)*Global`u^3*Global`\[Epsilon]^6) + 
     (48/((-1 + Global`u)*Global`u^3) + (288*Log[1 - Global`u])/((-1 + Global`u)*Global`u^3) + 
       (216*Log[Global`u])/((-1 + Global`u)*Global`u^3))/Global`\[Epsilon]^5 + 
     (2752/((-1 + Global`u)*Global`u^3) + (216*Pi^2)/((-1 + Global`u)*Global`u^3) - 
       (324*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^3) + 
       (36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) - 
       (192*Log[1 - Global`u])/((-1 + Global`u)*Global`u^3) - (414*Log[1 - Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) - (36*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) - (18*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^3) - 
       (324*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) + 
       (162*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u^3) - 
       (144*Log[Global`u])/((-1 + Global`u)*Global`u^3) - (864*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) - (324*Log[Global`u]^2)/((-1 + Global`u)*Global`u^3))/
      Global`\[Epsilon]^4 + (-11264/((-1 + Global`u)*Global`u^3) - 
       (144*Pi^2)/((-1 + Global`u)*Global`u^3) + (216*PolyLogTools`G[0, 1, Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) - (24*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^3) + (972*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^3) + (144*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^3) - (324*PolyLogTools`G[0, 1, Global`u, 1])/
        ((-1 + Global`u)*Global`u^3) - (36*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)*Global`u^3) + (648*PolyLogTools`G[0, Global`u, 1, 1])/
        ((-1 + Global`u)*Global`u^3) + (324*PolyLogTools`G[0, Global`u, Global`u, 1])/
        ((-1 + Global`u)*Global`u^3) + (108*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/
        ((-1 + Global`u)*Global`u^3) + (108*PolyLogTools`G[0, Global`u/(-1 + Global`u), 
          Global`u/(-1 + Global`u), 1])/((-1 + Global`u)*Global`u^3) - 
       (11008*Log[1 - Global`u])/((-1 + Global`u)*Global`u^3) - (810*Pi^2*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^3) + (324*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^3) - (36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[1 - Global`u])/((-1 + Global`u)*Global`u^3) + (276*Log[1 - Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) + (336*Log[1 - Global`u]^3)/((-1 + Global`u)*Global`u^3) - 
       (30*Pi^2*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^3) + 
       (72*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^3) + 
       (72*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^3) + 
       (24*Log[1 - Global`u]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^3) + 
       (72*Log[1 - Global`u]^2*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^3) - 
       (36*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^3) + 
       (18*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^3) + 
       (12*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^3) - 
       (36*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^3) - 
       (42*Log[Global`u^(-1)]^3)/((-1 + Global`u)*Global`u^3) - 
       (540*Pi^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) + 
       (216*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) + 
       (324*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) - 
       (648*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^3) - (324*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^3) - 
       (72*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^3) - (108*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) - (36*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) - (216*Log[(-1 + Global`u)/Global`u]^3)/
        ((-1 + Global`u)*Global`u^3) - (8256*Log[Global`u])/((-1 + Global`u)*Global`u^3) - 
       (648*Pi^2*Log[Global`u])/((-1 + Global`u)*Global`u^3) + 
       (972*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/((-1 + Global`u)*Global`u^3) - 
       (108*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) + (576*Log[1 - Global`u]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) + (1242*Log[1 - Global`u]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) + (108*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) + (54*Log[Global`u^(-1)]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^3) + (972*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*
         Log[Global`u])/((-1 + Global`u)*Global`u^3) - (486*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u])/((-1 + Global`u)*Global`u^3) + (216*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) + (1296*Log[1 - Global`u]*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^3) + (324*Log[Global`u]^3)/((-1 + Global`u)*Global`u^3) + 
       (10164*Zeta[3])/((-1 + Global`u)*Global`u^3))/Global`\[Epsilon]^3, 
   "Validation" -> <|"AllDistinctSourceKernelsChecked" -> True, "TwoParameterValues" -> {1/3, 2/3}, 
     "PoleChambersPreserved" -> True, "ExactCoefficientAtoms" -> True, "SourceKernelCount" -> 7, 
     "CheckManifest" -> "family_source_check_status.json"|>, "Complete" -> True, 
   "Source" -> "differential_u_20260920/campaign/MB10u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB11u" -> <|"Route" -> "Standard", "Orders" -> {-6, -3}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> -2, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-6 -> 21/((-1 + Global`u)^2*Global`u^2) + 
       21/((-1 + Global`u)*Global`u^2), -5 -> 70/((-1 + Global`u)^2*Global`u^2) + 
       55/((-1 + Global`u)*Global`u^2) + ((42*I)*Pi)/((-1 + Global`u)^2*Global`u^2) + 
       ((42*I)*Pi)/((-1 + Global`u)*Global`u^2) - (69*Log[1 - Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (69*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) - 
       (42*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) - (42*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2), -4 -> -2522/(3*(-1 + Global`u)^2*Global`u^2) - 
       2393/(3*(-1 + Global`u)*Global`u^2) + ((140*I)*Pi)/((-1 + Global`u)^2*Global`u^2) + 
       ((110*I)*Pi)/((-1 + Global`u)*Global`u^2) - (70*Pi^2)/((-1 + Global`u)^2*Global`u^2) - 
       (70*Pi^2)/((-1 + Global`u)*Global`u^2) - (18*PolyLogTools`G[0, 1, Global`u^(-1)])/
        ((-1 + Global`u)^2*Global`u^2) - (18*PolyLogTools`G[0, 1, Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) - (54*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^2) - (9*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u) - (54*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - (230*Log[1 - Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (110*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) - 
       ((138*I)*Pi*Log[1 - Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       ((138*I)*Pi*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) + (219*Log[1 - Global`u]^2)/
        (2*(-1 + Global`u)^2*Global`u^2) + (219*Log[1 - Global`u]^2)/
        (2*(-1 + Global`u)*Global`u^2) + (54*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (9*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)^2*Global`u) + (54*Log[1 - Global`u]*Log[Global`u^(-1)])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (27*Log[Global`u^(-1)]^2)/
        ((-1 + Global`u)*Global`u^2) + (9*Log[Global`u^(-1)]^2)/(2*(-1 + Global`u)^2*Global`u) + 
       (27*Log[Global`u^(-1)]^2)/(Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (18*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       (18*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (9*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)^2*Global`u^2) + 
       (9*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u^2) - 
       (140*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) - (110*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) - ((84*I)*Pi*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       ((84*I)*Pi*Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       (138*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) + 
       (138*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       (42*Log[Global`u]^2)/((-1 + Global`u)^2*Global`u^2) + (42*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^2), -3 -> -298/(3*(-1 + Global`u)^2*Global`u^2) + 
       449/((-1 + Global`u)*Global`u^2) - (((5044*I)/3)*Pi)/((-1 + Global`u)^2*Global`u^2) - 
       (((4786*I)/3)*Pi)/((-1 + Global`u)*Global`u^2) + (6*Pi^2)/Global`u^2 - 
       (1391*Pi^2)/(6*(-1 + Global`u)^2*Global`u^2) - (911*Pi^2)/(6*(-1 + Global`u)*Global`u^2) + 
       (6*Pi^2)/((-1 + Global`u)*Global`u) - (12*Pi^2)/(1 - 2*Global`u + Global`u^2) - 
       (24*Pi^2)/(Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (18*Pi^2)/(Global`u*(1 - 2*Global`u + Global`u^2)) - 
       ((84*I)*Pi^3)/((-1 + Global`u)^2*Global`u^2) - ((84*I)*Pi^3)/((-1 + Global`u)*Global`u^2) - 
       (18*PolyLogTools`G[0, 1, -1])/((-1 + Global`u)^2*Global`u) - (72*PolyLogTools`G[0, 1, -1])/
        ((-1 + Global`u)*Global`u) + (216*PolyLogTools`G[0, 1, -1])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) - (36*PolyLogTools`G[0, 1, Global`u^(-1)])/
        Global`u^2 + (12*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)^2*Global`u^2) - 
       (42*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (72*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)^2*Global`u) - 
       ((36*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)^2*Global`u^2) - 
       ((36*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (30*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u) - 
       (36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) - 
       (126*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (54*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) - 
       ((108*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       ((18*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u) - 
       ((108*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (18*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/
        ((-1 + Global`u)^2*Global`u^2) + (18*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) - (18*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (72*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^2) - (36*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u) - (54*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (18*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (54*PolyLogTools`G[0, 1, Global`u, 1])/
        ((-1 + Global`u)^2*Global`u^2) + (18*PolyLogTools`G[0, 1, Global`u, 1])/
        ((-1 + Global`u)*Global`u^2) - (54*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)*Global`u^2) + (27*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)^2*Global`u) - (18*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (18*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (72*PolyLogTools`G[0, Global`u, 1, 1])/
        ((-1 + Global`u)^2*Global`u^2) + (36*PolyLogTools`G[0, Global`u, 1, 1])/
        ((-1 + Global`u)*Global`u^2) - (54*PolyLogTools`G[0, Global`u, Global`u, 1])/
        ((-1 + Global`u)^2*Global`u^2) - (54*PolyLogTools`G[0, Global`u, Global`u, 1])/
        ((-1 + Global`u)*Global`u^2) - (18*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/
        ((-1 + Global`u)^2*Global`u^2) - (126*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/
        ((-1 + Global`u)*Global`u^2) - (9*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/
        ((-1 + Global`u)^2*Global`u) - (72*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (54*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)*Global`u^2) - (27*PolyLogTools`G[0, Global`u/(-1 + Global`u), 
          Global`u/(-1 + Global`u), 1])/((-1 + Global`u)^2*Global`u) + 
       (54*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (72*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) - 
       (18*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1])/((-1 + Global`u)^2*Global`u) + 
       (36*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1])/((-1 + Global`u)*Global`u*
         (-2 + 2*Global`u)) - (54*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (108*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1])/
        (Global`u^2*(2 - 4*Global`u + 2*Global`u^2)) + (7978*Log[1 - Global`u])/
        (3*(-1 + Global`u)^2*Global`u^2) + (7972*Log[1 - Global`u])/(3*(-1 + Global`u)*
         Global`u^2) - ((460*I)*Pi*Log[1 - Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       ((220*I)*Pi*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) + (221*Pi^2*Log[1 - Global`u])/
        ((-1 + Global`u)^2*Global`u^2) + (221*Pi^2*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^2) + (54*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/
        ((-1 + Global`u)^2*Global`u^2) + (54*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^2) - (9*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[1 - Global`u])/((-1 + Global`u)^2*Global`u^2) + 
       (45*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^2) + (9*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[1 - Global`u])/((-1 + Global`u)^2*Global`u) + 
       (108*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/
        (Global`u^2*(2 - 4*Global`u + 2*Global`u^2)) + (365*Log[1 - Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) + (391*Log[1 - Global`u]^2)/(2*(-1 + Global`u)*Global`u^2) + 
       ((219*I)*Pi*Log[1 - Global`u]^2)/((-1 + Global`u)^2*Global`u^2) + 
       ((219*I)*Pi*Log[1 - Global`u]^2)/((-1 + Global`u)*Global`u^2) - 
       (227*Log[1 - Global`u]^3)/(2*(-1 + Global`u)^2*Global`u^2) - (227*Log[1 - Global`u]^3)/
        (2*(-1 + Global`u)*Global`u^2) + (9*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)])/
        ((-1 + Global`u)^2*Global`u^2) - (108*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (9*Log[(-1 + Global`u)^(-1)]^2)/
        (2*(-1 + Global`u)^2*Global`u^2) - (54*Log[(-1 + Global`u)^(-1)]^2)/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (9*Log[1 - Global`u]*Log[-1 + Global`u])/
        ((-1 + Global`u)^2*Global`u) + (36*Log[1 - Global`u]*Log[-1 + Global`u])/
        ((-1 + Global`u)*Global`u) - (108*Log[1 - Global`u]*Log[-1 + Global`u])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) - (9*Log[-1 + Global`u]^2)/
        (2*(-1 + Global`u)^2*Global`u) - (18*Log[-1 + Global`u]^2)/((-1 + Global`u)*Global`u) + 
       (54*Log[-1 + Global`u]^2)/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (3*Pi^2*Log[Global`u^(-1)])/((-1 + Global`u)^2*Global`u^2) + (39*Pi^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (9*Pi^2*Log[Global`u^(-1)])/(2*(-1 + Global`u)^2*Global`u) + 
       (6*Pi^2*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u*(-2 + 2*Global`u)) + 
       (27*Pi^2*Log[Global`u^(-1)])/(Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (3*Pi^2*Log[Global`u^(-1)])/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (18*Pi^2*Log[Global`u^(-1)])/(Global`u^2*(2 - 4*Global`u + 2*Global`u^2)) + 
       (216*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (18*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/((-1 + Global`u)^2*Global`u) + 
       (216*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/(Global`u^2*(1 - 2*Global`u + 
          Global`u^2)) - (72*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) - (36*PolyLogTools`G[0, 1, Global`u^(-1)]*
         Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) + 
       (18*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (18*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (36*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (18*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (12*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)^2*Global`u) + (36*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u*(-2 + 2*Global`u)) + (36*Log[1 - Global`u]*Log[Global`u^(-1)])/
        (1 - 2*Global`u + Global`u^2) + (162*Log[1 - Global`u]*Log[Global`u^(-1)])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - (36*Log[1 - Global`u]*Log[Global`u^(-1)])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (108*Log[1 - Global`u]*Log[Global`u^(-1)])/
        (Global`u*(2 - 4*Global`u + 2*Global`u^2)) + ((108*I)*Pi*Log[1 - Global`u]*
         Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) + 
       ((18*I)*Pi*Log[1 - Global`u]*Log[Global`u^(-1)])/((-1 + Global`u)^2*Global`u) + 
       ((108*I)*Pi*Log[1 - Global`u]*Log[Global`u^(-1)])/(Global`u^2*(1 - 2*Global`u + 
          Global`u^2)) - (54*Log[1 - Global`u]^2*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (18*Log[1 - Global`u]^2*Log[Global`u^(-1)])/((-1 + Global`u)^2*Global`u) - 
       (54*Log[1 - Global`u]^2*Log[Global`u^(-1)])/(Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (108*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) + 
       (9*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/((-1 + Global`u)^2*Global`u) - 
       (108*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (36*Log[1 - Global`u]*Log[-1 + Global`u]*
         Log[Global`u^(-1)])/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (54*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (9*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/(2*(-1 + Global`u)^2*Global`u) + 
       (54*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/(Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (18*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (15*Log[Global`u^(-1)]^2)/((-1 + Global`u)^2*Global`u) + (18*Log[Global`u^(-1)]^2)/
        ((-1 + Global`u)*Global`u) + (63*Log[Global`u^(-1)]^2)/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (27*Log[Global`u^(-1)]^2)/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + ((54*I)*Pi*Log[Global`u^(-1)]^2)/
        ((-1 + Global`u)*Global`u^2) + ((9*I)*Pi*Log[Global`u^(-1)]^2)/
        ((-1 + Global`u)^2*Global`u) + ((54*I)*Pi*Log[Global`u^(-1)]^2)/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (18*Log[(1 - Global`u)^(-1)]*
         Log[Global`u^(-1)]^2)/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (9*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/(2*(-1 + Global`u)^2*Global`u^2) - 
       (99*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/(2*(-1 + Global`u)*Global`u^2) + 
       (9*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/((-1 + Global`u)^2*Global`u) - 
       (81*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/(Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (36*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (54*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/(Global`u^2*(2 - 4*Global`u + 2*Global`u^2)) + 
       (3*Log[Global`u^(-1)]^3)/((-1 + Global`u)^2*Global`u^2) + (3*Log[Global`u^(-1)]^3)/
        ((-1 + Global`u)*Global`u^2) + (15*Log[Global`u^(-1)]^3)/(2*(-1 + Global`u)^2*Global`u) + 
       (6*Log[Global`u^(-1)]^3)/((-1 + Global`u)*Global`u*(-2 + 2*Global`u)) - 
       (9*Log[Global`u^(-1)]^3)/(Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (6*Log[Global`u^(-1)]^3)/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (18*Log[Global`u^(-1)]^3)/(Global`u^2*(2 - 4*Global`u + 2*Global`u^2)) - 
       (30*Pi^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       (30*Pi^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^2) - (36*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/
        Global`u^2 + (12*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (42*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^2) - (72*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u) - ((36*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - ((36*I)*Pi*Log[1 - Global`u]*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (54*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u^2) + 
       (54*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (72*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (72*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (36*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (36*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (18*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (18*Log[(-1 + Global`u)/Global`u]^2)/Global`u^2 - (6*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) + (21*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + (36*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)^2*Global`u) + ((18*I)*Pi*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) + ((18*I)*Pi*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) - (54*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) - (54*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + (18*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + (6*Log[(-1 + Global`u)/Global`u]^3)/
        ((-1 + Global`u)^2*Global`u^2) + (6*Log[(-1 + Global`u)/Global`u]^3)/
        ((-1 + Global`u)*Global`u^2) + (5044*Log[Global`u])/(3*(-1 + Global`u)^2*Global`u^2) + 
       (4786*Log[Global`u])/(3*(-1 + Global`u)*Global`u^2) - ((280*I)*Pi*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - ((220*I)*Pi*Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       (140*Pi^2*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) + (140*Pi^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (36*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u^2) + (36*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (108*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       (18*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u) + (108*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[Global`u])/(Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (460*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) + 
       (220*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       ((276*I)*Pi*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) + 
       ((276*I)*Pi*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       (219*Log[1 - Global`u]^2*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       (219*Log[1 - Global`u]^2*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       (108*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       (18*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/((-1 + Global`u)^2*Global`u) - 
       (108*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - (54*Log[Global`u^(-1)]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) - (9*Log[Global`u^(-1)]^2*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u) - (54*Log[Global`u^(-1)]^2*Log[Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (36*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u^2) + (36*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*
         Log[Global`u])/((-1 + Global`u)*Global`u^2) - (18*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u])/((-1 + Global`u)^2*Global`u^2) - (18*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u])/((-1 + Global`u)*Global`u^2) + (140*Log[Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) + (110*Log[Global`u]^2)/((-1 + Global`u)*Global`u^2) + 
       ((84*I)*Pi*Log[Global`u]^2)/((-1 + Global`u)^2*Global`u^2) + ((84*I)*Pi*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) - (138*Log[1 - Global`u]*Log[Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) - (138*Log[1 - Global`u]*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) - (28*Log[Global`u]^3)/((-1 + Global`u)^2*Global`u^2) - 
       (28*Log[Global`u]^3)/((-1 + Global`u)*Global`u^2) - (2594*Zeta[3])/
        ((-1 + Global`u)^2*Global`u^2) - (2558*Zeta[3])/((-1 + Global`u)*Global`u^2) - 
       (36*Zeta[3])/(Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (36*Zeta[3])/(Global`u*(1 - 2*Global`u + Global`u^2))|>, 
   "Series" -> (21/((-1 + Global`u)^2*Global`u^2) + 21/((-1 + Global`u)*Global`u^2))/Global`\[Epsilon]^6 + 
     (70/((-1 + Global`u)^2*Global`u^2) + ((42*I)*Pi)/((-1 + Global`u)^2*Global`u^2) + 
       55/((-1 + Global`u)*Global`u^2) + ((42*I)*Pi)/((-1 + Global`u)*Global`u^2) - 
       (69*Log[1 - Global`u])/((-1 + Global`u)^2*Global`u^2) - (69*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^2) - (42*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       (42*Log[Global`u])/((-1 + Global`u)*Global`u^2))/Global`\[Epsilon]^5 + 
     (-2522/(3*(-1 + Global`u)^2*Global`u^2) + ((140*I)*Pi)/((-1 + Global`u)^2*Global`u^2) - 
       (70*Pi^2)/((-1 + Global`u)^2*Global`u^2) - 2393/(3*(-1 + Global`u)*Global`u^2) + 
       ((110*I)*Pi)/((-1 + Global`u)*Global`u^2) - (70*Pi^2)/((-1 + Global`u)*Global`u^2) - 
       (18*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)^2*Global`u^2) - 
       (18*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (54*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (9*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u) - 
       (54*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - (230*Log[1 - Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - ((138*I)*Pi*Log[1 - Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (110*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) - 
       ((138*I)*Pi*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) + (219*Log[1 - Global`u]^2)/
        (2*(-1 + Global`u)^2*Global`u^2) + (219*Log[1 - Global`u]^2)/
        (2*(-1 + Global`u)*Global`u^2) + (54*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (9*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)^2*Global`u) + (54*Log[1 - Global`u]*Log[Global`u^(-1)])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (27*Log[Global`u^(-1)]^2)/
        ((-1 + Global`u)*Global`u^2) + (9*Log[Global`u^(-1)]^2)/(2*(-1 + Global`u)^2*Global`u) + 
       (27*Log[Global`u^(-1)]^2)/(Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (18*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       (18*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (9*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)^2*Global`u^2) + 
       (9*Log[(-1 + Global`u)/Global`u]^2)/((-1 + Global`u)*Global`u^2) - 
       (140*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) - ((84*I)*Pi*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (110*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       ((84*I)*Pi*Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       (138*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) + 
       (138*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       (42*Log[Global`u]^2)/((-1 + Global`u)^2*Global`u^2) + (42*Log[Global`u]^2)/
        ((-1 + Global`u)*Global`u^2))/Global`\[Epsilon]^4 + 
     ((6*Pi^2)/Global`u^2 - 298/(3*(-1 + Global`u)^2*Global`u^2) - 
       (((5044*I)/3)*Pi)/((-1 + Global`u)^2*Global`u^2) - 
       (1391*Pi^2)/(6*(-1 + Global`u)^2*Global`u^2) - ((84*I)*Pi^3)/((-1 + Global`u)^2*
         Global`u^2) + 449/((-1 + Global`u)*Global`u^2) - (((4786*I)/3)*Pi)/
        ((-1 + Global`u)*Global`u^2) - (911*Pi^2)/(6*(-1 + Global`u)*Global`u^2) - 
       ((84*I)*Pi^3)/((-1 + Global`u)*Global`u^2) + (6*Pi^2)/((-1 + Global`u)*Global`u) - 
       (12*Pi^2)/(1 - 2*Global`u + Global`u^2) - 
       (24*Pi^2)/(Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (18*Pi^2)/(Global`u*(1 - 2*Global`u + Global`u^2)) - (18*PolyLogTools`G[0, 1, -1])/
        ((-1 + Global`u)^2*Global`u) - (72*PolyLogTools`G[0, 1, -1])/((-1 + Global`u)*Global`u) + 
       (216*PolyLogTools`G[0, 1, -1])/(Global`u*(1 - 2*Global`u + Global`u^2)) - 
       (36*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u^2 + 
       (12*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)^2*Global`u^2) - 
       ((36*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)^2*Global`u^2) - 
       (42*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       ((36*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (72*PolyLogTools`G[0, 1, Global`u^(-1)])/((-1 + Global`u)^2*Global`u) - 
       ((108*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (30*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u) - 
       ((18*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u) - 
       (36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u) - 
       (126*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       ((108*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (54*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (18*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/
        ((-1 + Global`u)^2*Global`u^2) + (18*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) - (18*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (72*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^2) - (36*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u) - (54*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (18*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (54*PolyLogTools`G[0, 1, Global`u, 1])/
        ((-1 + Global`u)^2*Global`u^2) + (18*PolyLogTools`G[0, 1, Global`u, 1])/
        ((-1 + Global`u)*Global`u^2) - (54*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)*Global`u^2) + (27*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)^2*Global`u) - (18*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (18*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (72*PolyLogTools`G[0, Global`u, 1, 1])/
        ((-1 + Global`u)^2*Global`u^2) + (36*PolyLogTools`G[0, Global`u, 1, 1])/
        ((-1 + Global`u)*Global`u^2) - (54*PolyLogTools`G[0, Global`u, Global`u, 1])/
        ((-1 + Global`u)^2*Global`u^2) - (54*PolyLogTools`G[0, Global`u, Global`u, 1])/
        ((-1 + Global`u)*Global`u^2) - (18*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/
        ((-1 + Global`u)^2*Global`u^2) - (126*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/
        ((-1 + Global`u)*Global`u^2) - (9*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/
        ((-1 + Global`u)^2*Global`u) - (72*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (54*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        ((-1 + Global`u)*Global`u^2) - (27*PolyLogTools`G[0, Global`u/(-1 + Global`u), 
          Global`u/(-1 + Global`u), 1])/((-1 + Global`u)^2*Global`u) + 
       (54*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (72*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) - 
       (18*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1])/((-1 + Global`u)^2*Global`u) + 
       (36*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1])/((-1 + Global`u)*Global`u*
         (-2 + 2*Global`u)) - (54*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (108*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1])/
        (Global`u^2*(2 - 4*Global`u + 2*Global`u^2)) + (7978*Log[1 - Global`u])/
        (3*(-1 + Global`u)^2*Global`u^2) - ((460*I)*Pi*Log[1 - Global`u])/
        ((-1 + Global`u)^2*Global`u^2) + (221*Pi^2*Log[1 - Global`u])/
        ((-1 + Global`u)^2*Global`u^2) + (7972*Log[1 - Global`u])/(3*(-1 + Global`u)*Global`u^2) - 
       ((220*I)*Pi*Log[1 - Global`u])/((-1 + Global`u)*Global`u^2) + (221*Pi^2*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^2) + (54*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/
        ((-1 + Global`u)^2*Global`u^2) + (54*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^2) - (9*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[1 - Global`u])/((-1 + Global`u)^2*Global`u^2) + 
       (45*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/
        ((-1 + Global`u)*Global`u^2) + (9*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[1 - Global`u])/((-1 + Global`u)^2*Global`u) + 
       (108*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/
        (Global`u^2*(2 - 4*Global`u + 2*Global`u^2)) + (365*Log[1 - Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) + ((219*I)*Pi*Log[1 - Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) + (391*Log[1 - Global`u]^2)/(2*(-1 + Global`u)*Global`u^2) + 
       ((219*I)*Pi*Log[1 - Global`u]^2)/((-1 + Global`u)*Global`u^2) - 
       (227*Log[1 - Global`u]^3)/(2*(-1 + Global`u)^2*Global`u^2) - (227*Log[1 - Global`u]^3)/
        (2*(-1 + Global`u)*Global`u^2) + (9*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)])/
        ((-1 + Global`u)^2*Global`u^2) - (108*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (9*Log[(-1 + Global`u)^(-1)]^2)/
        (2*(-1 + Global`u)^2*Global`u^2) - (54*Log[(-1 + Global`u)^(-1)]^2)/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (9*Log[1 - Global`u]*Log[-1 + Global`u])/
        ((-1 + Global`u)^2*Global`u) + (36*Log[1 - Global`u]*Log[-1 + Global`u])/
        ((-1 + Global`u)*Global`u) - (108*Log[1 - Global`u]*Log[-1 + Global`u])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) - (9*Log[-1 + Global`u]^2)/
        (2*(-1 + Global`u)^2*Global`u) - (18*Log[-1 + Global`u]^2)/((-1 + Global`u)*Global`u) + 
       (54*Log[-1 + Global`u]^2)/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (3*Pi^2*Log[Global`u^(-1)])/((-1 + Global`u)^2*Global`u^2) + (39*Pi^2*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (9*Pi^2*Log[Global`u^(-1)])/(2*(-1 + Global`u)^2*Global`u) + 
       (6*Pi^2*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u*(-2 + 2*Global`u)) + 
       (27*Pi^2*Log[Global`u^(-1)])/(Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (3*Pi^2*Log[Global`u^(-1)])/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (18*Pi^2*Log[Global`u^(-1)])/(Global`u^2*(2 - 4*Global`u + 2*Global`u^2)) + 
       (216*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (18*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/((-1 + Global`u)^2*Global`u) + 
       (216*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/(Global`u^2*(1 - 2*Global`u + 
          Global`u^2)) - (72*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) - (36*PolyLogTools`G[0, 1, Global`u^(-1)]*
         Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) + 
       (18*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)])/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (18*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (36*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (18*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + ((108*I)*Pi*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u^2) + (12*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)^2*Global`u) + ((18*I)*Pi*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)^2*Global`u) + (36*Log[1 - Global`u]*Log[Global`u^(-1)])/
        ((-1 + Global`u)*Global`u*(-2 + 2*Global`u)) + (36*Log[1 - Global`u]*Log[Global`u^(-1)])/
        (1 - 2*Global`u + Global`u^2) + (162*Log[1 - Global`u]*Log[Global`u^(-1)])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + ((108*I)*Pi*Log[1 - Global`u]*
         Log[Global`u^(-1)])/(Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (36*Log[1 - Global`u]*Log[Global`u^(-1)])/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (108*Log[1 - Global`u]*Log[Global`u^(-1)])/(Global`u*(2 - 4*Global`u + 2*Global`u^2)) - 
       (54*Log[1 - Global`u]^2*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (18*Log[1 - Global`u]^2*Log[Global`u^(-1)])/((-1 + Global`u)^2*Global`u) - 
       (54*Log[1 - Global`u]^2*Log[Global`u^(-1)])/(Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (108*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) + 
       (9*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/((-1 + Global`u)^2*Global`u) - 
       (108*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (36*Log[1 - Global`u]*Log[-1 + Global`u]*
         Log[Global`u^(-1)])/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (54*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/((-1 + Global`u)*Global`u^2) - 
       (9*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/(2*(-1 + Global`u)^2*Global`u) + 
       (54*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/(Global`u^2*(1 - 2*Global`u + Global`u^2)) - 
       (18*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       ((54*I)*Pi*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u^2) + 
       (15*Log[Global`u^(-1)]^2)/((-1 + Global`u)^2*Global`u) + ((9*I)*Pi*Log[Global`u^(-1)]^2)/
        ((-1 + Global`u)^2*Global`u) + (18*Log[Global`u^(-1)]^2)/((-1 + Global`u)*Global`u) + 
       (63*Log[Global`u^(-1)]^2)/(Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       ((54*I)*Pi*Log[Global`u^(-1)]^2)/(Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (27*Log[Global`u^(-1)]^2)/(Global`u*(1 - 2*Global`u + Global`u^2)) + 
       (18*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2)/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (9*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/
        (2*(-1 + Global`u)^2*Global`u^2) - (99*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/
        (2*(-1 + Global`u)*Global`u^2) + (9*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/
        ((-1 + Global`u)^2*Global`u) - (81*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (36*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (54*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/
        (Global`u^2*(2 - 4*Global`u + 2*Global`u^2)) + (3*Log[Global`u^(-1)]^3)/
        ((-1 + Global`u)^2*Global`u^2) + (3*Log[Global`u^(-1)]^3)/((-1 + Global`u)*Global`u^2) + 
       (15*Log[Global`u^(-1)]^3)/(2*(-1 + Global`u)^2*Global`u) + (6*Log[Global`u^(-1)]^3)/
        ((-1 + Global`u)*Global`u*(-2 + 2*Global`u)) - (9*Log[Global`u^(-1)]^3)/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (6*Log[Global`u^(-1)]^3)/
        (Global`u*(1 - 2*Global`u + Global`u^2)) + (18*Log[Global`u^(-1)]^3)/
        (Global`u^2*(2 - 4*Global`u + 2*Global`u^2)) - (30*Pi^2*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (30*Pi^2*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)*Global`u^2) - (36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (36*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u^2 + 
       (12*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       ((36*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       (42*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       ((36*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (72*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u) + 
       (54*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)^2*Global`u^2) + 
       (54*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (72*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (72*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) - 
       (36*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u])/
        ((-1 + Global`u)^2*Global`u^2) - (36*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (18*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u])/((-1 + Global`u)*Global`u^2) + 
       (18*Log[(-1 + Global`u)/Global`u]^2)/Global`u^2 - (6*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) + ((18*I)*Pi*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) + (21*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + ((18*I)*Pi*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + (36*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)^2*Global`u) - (54*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) - (54*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + (18*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2)/
        ((-1 + Global`u)*Global`u^2) + (6*Log[(-1 + Global`u)/Global`u]^3)/
        ((-1 + Global`u)^2*Global`u^2) + (6*Log[(-1 + Global`u)/Global`u]^3)/
        ((-1 + Global`u)*Global`u^2) + (5044*Log[Global`u])/(3*(-1 + Global`u)^2*Global`u^2) - 
       ((280*I)*Pi*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) + (140*Pi^2*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u^2) + (4786*Log[Global`u])/(3*(-1 + Global`u)*Global`u^2) - 
       ((220*I)*Pi*Log[Global`u])/((-1 + Global`u)*Global`u^2) + (140*Pi^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (36*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u^2) + (36*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) + (108*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       (18*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u) + (108*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[Global`u])/(Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (460*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) + 
       ((276*I)*Pi*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) + 
       (220*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)*Global`u^2) + 
       ((276*I)*Pi*Log[1 - Global`u]*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       (219*Log[1 - Global`u]^2*Log[Global`u])/((-1 + Global`u)^2*Global`u^2) - 
       (219*Log[1 - Global`u]^2*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       (108*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/((-1 + Global`u)*Global`u^2) - 
       (18*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/((-1 + Global`u)^2*Global`u) - 
       (108*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) - (54*Log[Global`u^(-1)]^2*Log[Global`u])/
        ((-1 + Global`u)*Global`u^2) - (9*Log[Global`u^(-1)]^2*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u) - (54*Log[Global`u^(-1)]^2*Log[Global`u])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + 
       (36*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*Log[Global`u])/
        ((-1 + Global`u)^2*Global`u^2) + (36*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*
         Log[Global`u])/((-1 + Global`u)*Global`u^2) - (18*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u])/((-1 + Global`u)^2*Global`u^2) - (18*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u])/((-1 + Global`u)*Global`u^2) + (140*Log[Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) + ((84*I)*Pi*Log[Global`u]^2)/
        ((-1 + Global`u)^2*Global`u^2) + (110*Log[Global`u]^2)/((-1 + Global`u)*Global`u^2) + 
       ((84*I)*Pi*Log[Global`u]^2)/((-1 + Global`u)*Global`u^2) - 
       (138*Log[1 - Global`u]*Log[Global`u]^2)/((-1 + Global`u)^2*Global`u^2) - 
       (138*Log[1 - Global`u]*Log[Global`u]^2)/((-1 + Global`u)*Global`u^2) - 
       (28*Log[Global`u]^3)/((-1 + Global`u)^2*Global`u^2) - (28*Log[Global`u]^3)/
        ((-1 + Global`u)*Global`u^2) - (2594*Zeta[3])/((-1 + Global`u)^2*Global`u^2) - 
       (2558*Zeta[3])/((-1 + Global`u)*Global`u^2) - (36*Zeta[3])/
        (Global`u^2*(1 - 2*Global`u + Global`u^2)) + (36*Zeta[3])/
        (Global`u*(1 - 2*Global`u + Global`u^2)))/Global`\[Epsilon]^3, 
   "Validation" -> <|"AllDistinctSourceKernelsChecked" -> True, "TwoParameterValues" -> {1/3, 2/3}, 
     "PoleChambersPreserved" -> True, "ExactCoefficientAtoms" -> True, "SourceKernelCount" -> 21, 
     "CheckManifest" -> "family_source_check_status.json"|>, "Complete" -> True, 
   "Source" -> "differential_u_20260920/campaign/MB11u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB12u" -> <|"Route" -> "Standard", "Orders" -> {-5, -1}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> 0, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-5 -> -3, -4 -> -2 + 6*Log[Global`u], 
     -3 -> -64 + (13*Pi^2)/2 - 6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + 
       6*PolyLogTools`G[0, 1, Global`u^(-1)] - 6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       3*Log[1 - Global`u]^2 + 6*Log[1 - Global`u]*Log[Global`u^(-1)] + 3*Log[Global`u^(-1)]^2 + 
       6*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 3*Log[(-1 + Global`u)/Global`u]^2 + 
       4*Log[Global`u] - 6*Log[Global`u]^2 - 6*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 
       3*Log[Global`u/(-1 + Global`u)]^2, -2 -> -480 + (13*Pi^2)/3 - 
       4*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + 4*PolyLogTools`G[0, 1, Global`u^(-1)] - 
       4*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 12*PolyLogTools`G[-1, 0, -1, 1] + 
       12*PolyLogTools`G[0, 0, 1, -1] + 30*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)] + 
       42*PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 18*PolyLogTools`G[0, 0, 1, 
         (-1 + Global`u)/Global`u] - 18*PolyLogTools`G[0, 1, 1 - Global`u, 1] - 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] - 6*PolyLogTools`G[0, 1, Global`u, 1] - 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] + 
       6*PolyLogTools`G[0, 1 - Global`u, 1, 1] + 18*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 
         1] - 12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
       36*PolyLogTools`G[0, Global`u, 1, 1] + 18*PolyLogTools`G[0, Global`u, Global`u, 1] + 
       6*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] + 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] + 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1] - 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] + 
       Pi^2*Log[(1 - Global`u)^(-1)] - 12*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)] - 
       2*Pi^2*Log[1 - Global`u] - 36*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] + 
       2*Log[1 - Global`u]^2 - 3*Log[1 - Global`u]^3 + 12*PolyLogTools`G[0, 1, -1]*
        Log[-2/(-1 + Global`u)] - 3*Pi^2*Log[Global`u^(-1)] + 12*PolyLogTools`G[0, 1, -1]*
        Log[Global`u^(-1)] - 6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 
       4*Log[1 - Global`u]*Log[Global`u^(-1)] - 6*Log[1 - Global`u]^2*Log[Global`u^(-1)] - 
       6*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 3*Log[-1 + Global`u]^2*
        Log[Global`u^(-1)] + 2*Log[Global`u^(-1)]^2 - 9*Log[1 - Global`u]*Log[Global`u^(-1)]^2 - 
       5*Log[Global`u^(-1)]^3 + 2*Pi^2*Log[(-1 + Global`u)/Global`u] + 
       12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)/Global`u] + 
       4*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 12*Log[1 - Global`u]^2*
        Log[(-1 + Global`u)/Global`u] + 24*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 12*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] + 12*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 6*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] - 
       2*Log[(-1 + Global`u)/Global`u]^2 + 27*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2 - 
       10*Log[(-1 + Global`u)/Global`u]^3 + 128*Log[Global`u] - 14*Pi^2*Log[Global`u] - 
       12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] + 
       12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] - 
       6*Log[1 - Global`u]^2*Log[Global`u] - 12*Log[1 - Global`u]*Log[Global`u^(-1)]*
        Log[Global`u] - 6*Log[Global`u^(-1)]^2*Log[Global`u] - 12*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 6*Log[(-1 + Global`u)/Global`u]^2*
        Log[Global`u] - 4*Log[Global`u]^2 + 4*Log[Global`u]^3 - 
       9*Pi^2*Log[Global`u/(-1 + Global`u)] + 12*PolyLogTools`G[0, 1, -1]*
        Log[Global`u/(-1 + Global`u)] + 3*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 3*Log[-Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)] + 
       6*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] - 
       4*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 6*Log[Global`u]^2*
        Log[Global`u/(-1 + Global`u)] + 2*Log[Global`u/(-1 + Global`u)]^2 - 
       3*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^2 + 
       6*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)]^2 + 9*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 - 5*Log[Global`u/(-1 + Global`u)]^3 + 416*Zeta[3], 
     -1 -> -3840 + (416*Pi^2)/3 + (2707*Pi^4)/120 - 10*Pi^2*PolyLogTools`G[-1, -1, 1] - 
       4*Pi^2*PolyLogTools`G[0, 1, -1] - 6*PolyLogTools`G[0, 1, -1]^2 - 
       128*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + 
       16*Pi^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] - 12*PolyLogTools`G[-1, -1, 1]*
        PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + 12*PolyLogTools`G[0, 1, -1]*
        PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + Pi^2*PolyLogTools`G[0, 1, 1 - Global`u] + 
       128*PolyLogTools`G[0, 1, Global`u^(-1)] - 31*Pi^2*PolyLogTools`G[0, 1, Global`u^(-1)] + 
       12*PolyLogTools`G[-1, -1, 1]*PolyLogTools`G[0, 1, Global`u^(-1)] + 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*PolyLogTools`G[0, 1, Global`u^(-1)] - 
       128*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       8*Pi^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 12*PolyLogTools`G[0, 1, -1]*
        PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       6*PolyLogTools`G[0, 1, 1 - Global`u]*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       60*PolyLogTools`G[0, 1, Global`u^(-1)]*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       12*Pi^2*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] + 12*PolyLogTools`G[0, 1, -1]*
        PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 8*PolyLogTools`G[-1, 0, -1, 1] + 
       24*EulerGamma*PolyLogTools`G[-1, 0, -1, 1] + 8*PolyLogTools`G[0, 0, 1, -1] - 
       24*EulerGamma*PolyLogTools`G[0, 0, 1, -1] + 20*PolyLogTools`G[0, 0, 1, 
         (1 - Global`u)^(-1)] - 12*EulerGamma*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)] + 
       28*PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 12*EulerGamma*PolyLogTools`G[0, 0, 1, 
         Global`u^(-1)] + 12*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u] - 
       24*EulerGamma*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u] + 
       24*EulerGamma*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)] - 
       12*PolyLogTools`G[0, 1, 1 - Global`u, 1] + 6*EulerGamma*PolyLogTools`G[0, 1, 1 - Global`u, 
         1] - 4*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] + 
       12*EulerGamma*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] - 
       4*PolyLogTools`G[0, 1, Global`u, 1] - 6*EulerGamma*PolyLogTools`G[0, 1, Global`u, 1] - 
       8*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] - 
       12*EulerGamma*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] + 
       4*PolyLogTools`G[0, 1 - Global`u, 1, 1] + 12*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 
         1] - 6*EulerGamma*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1] - 
       8*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
       6*EulerGamma*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
       24*PolyLogTools`G[0, Global`u, 1, 1] + 12*PolyLogTools`G[0, Global`u, Global`u, 1] + 
       6*EulerGamma*PolyLogTools`G[0, Global`u, Global`u, 1] + 
       4*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] - 
       6*EulerGamma*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] + 
       8*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] + 
       12*EulerGamma*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1] - 
       12*EulerGamma*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 1] + 
       24*EulerGamma*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, Global`u/(-1 + Global`u), 1] + 
       4*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1] - 
       12*EulerGamma*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1] - 
       4*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       12*EulerGamma*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       8*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] - 
       24*EulerGamma*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] + 
       24*PolyLogTools`G[-1, 0, 0, -1, 1] + 12*PolyLogTools`G[0, -1, 0, -1, 1] + 
       24*PolyLogTools`G[0, 0, -1, -1, 1] + 60*PolyLogTools`G[0, 0, 0, 1, -1] - 
       108*PolyLogTools`G[0, 0, 0, 1, (1 - Global`u)^(-1)] - 
       12*PolyLogTools`G[0, 0, 0, 1, 1 - Global`u] + 270*PolyLogTools`G[0, 0, 0, 1, 
         Global`u^(-1)] - 54*PolyLogTools`G[0, 0, 0, 1, (-1 + Global`u)/Global`u] - 
       6*PolyLogTools`G[0, 0, 0, 1, Global`u/(-1 + Global`u)] + 
       72*PolyLogTools`G[0, 0, 1, 1 - Global`u, 1] - 
       6*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u, 1] - 
       102*PolyLogTools`G[0, 0, 1, Global`u, 1] + 12*PolyLogTools`G[0, 0, 1, 
         Global`u/(-1 + Global`u), 1] - 12*PolyLogTools`G[0, 0, (1 - Global`u)^(-1), 1, 1] - 
       36*PolyLogTools`G[0, 0, 1 - Global`u, 1, 1] - 72*PolyLogTools`G[0, 0, 1 - Global`u, 
         1 - Global`u, 1] - 54*PolyLogTools`G[0, 0, (-1 + Global`u)/Global`u, 1, 1] - 
       12*PolyLogTools`G[0, 0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1] + 
       162*PolyLogTools`G[0, 0, Global`u, 1, 1] + 114*PolyLogTools`G[0, 0, Global`u, Global`u, 1] + 
       12*PolyLogTools`G[0, 0, Global`u/(-1 + Global`u), 1, 1] - 
       6*PolyLogTools`G[0, 0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] + 
       6*PolyLogTools`G[0, 1, 0, 1 - Global`u, 1] - 6*PolyLogTools`G[0, 1, 0, 
         (-1 + Global`u)/Global`u, 1] + 24*PolyLogTools`G[0, 1, 0, Global`u, 1] + 
       12*PolyLogTools`G[0, 1, 0, Global`u/(-1 + Global`u), 1] + 
       6*PolyLogTools`G[0, 1, 1, (1 - Global`u)^(-1), 1] + 
       12*PolyLogTools`G[0, 1, 1, 1 - Global`u, 1] - 114*PolyLogTools`G[0, 1, 1, Global`u, 1] + 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1, 1] + 
       18*PolyLogTools`G[0, 1, 1 - Global`u, 1, 1] + 36*PolyLogTools`G[0, 1, 1 - Global`u, 
         1 - Global`u, 1] + 6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1, 1] + 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1] - 
       66*PolyLogTools`G[0, 1, Global`u, 1, 1] + 6*PolyLogTools`G[0, 1, Global`u, Global`u, 1] + 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] - 
       6*PolyLogTools`G[0, (1 - Global`u^(-2))^(-1), 0, (1 + Global`u)/((1 - Global`u^(-2))*
           Global`u), 1] + 6*PolyLogTools`G[0, (1 - Global`u^(-2))^(-1), 0, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), 1] - 
       6*PolyLogTools`G[0, (1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         ((-1 + Global`u)*(1 + Global`u))/((1 - Global`u^(-2))*Global`u^2), 1] + 
       6*PolyLogTools`G[0, (1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] - 
       6*PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1, 1] + 
       6*PolyLogTools`G[0, 1 - Global`u, 0, 1, 1] - 6*PolyLogTools`G[0, 1 - Global`u, 0, 
         1 - Global`u, 1] - 24*PolyLogTools`G[0, 1 - Global`u, 1, 1, 1] - 
       30*PolyLogTools`G[0, 1 - Global`u, 1, 1 - Global`u, 1] - 
       36*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1, 1] - 
       36*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1 - Global`u, 1] + 
       24*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 0, 1, 1] - 
       18*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1] - 
       6*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 1] - 
       96*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1, 1] + 
       60*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, (-1 + Global`u)/Global`u, 1] + 
       12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, Global`u/(-1 + Global`u), 1] + 
       42*PolyLogTools`G[0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1, 1] + 
       12*PolyLogTools`G[0, Global`u, 0, 1, 1] - 12*PolyLogTools`G[0, Global`u, 0, Global`u, 1] + 
       96*PolyLogTools`G[0, Global`u, 1, 1, 1] + 138*PolyLogTools`G[0, Global`u, 1, Global`u, 1] + 
       126*PolyLogTools`G[0, Global`u, Global`u, 1, 1] + 42*PolyLogTools`G[0, Global`u, Global`u, 
         Global`u, 1] - 18*PolyLogTools`G[0, Global`u/(-1 + Global`u), 0, 1, 1] + 
       6*PolyLogTools`G[0, Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), 0, Global`u/(-1 + Global`u), 1] - 
       18*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1, 1] - 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] + 
       18*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, Global`u/(-1 + Global`u), 1] + 
       24*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1, 1] - 
       24*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 1] + 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), ((-1 + Global`u)*(1 + Global`u))/
          ((1 - Global`u^(-2))*Global`u^2), 1] - 12*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), (-1 + Global`u^2)/
          ((1 - Global`u^(-2))*Global`u^2), 1] + 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), (-1 + Global`u^2)/
          ((1 - Global`u^(-2))*(-1 + Global`u)*Global`u), 1] + 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 - Global`u^(-2))^(-1), 0, 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] - 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 - Global`u^(-2))^(-1), 0, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), 1] + 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 - Global`u^(-2))^(-1), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), ((-1 + Global`u)*(1 + Global`u))/
          ((1 - Global`u^(-2))*Global`u^2), 1] - 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 
         (1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] + 
       12*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         0, ((-1 + Global`u)*(1 + Global`u))/((1 - Global`u^(-2))*Global`u^2), 1] - 
       12*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         0, (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] + 
       12*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         ((-1 + Global`u)*(1 + Global`u))/((1 - Global`u^(-2))*Global`u^2), 
         ((-1 + Global`u)*(1 + Global`u))/((1 - Global`u^(-2))*Global`u^2), 1] - 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         ((-1 + Global`u)*(1 + Global`u))/((1 - Global`u^(-2))*Global`u^2), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] - 
       12*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), ((-1 + Global`u)*(1 + Global`u))/
          ((1 - Global`u^(-2))*Global`u^2), 1] + 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), (1 + Global`u)/((1 - Global`u^(-2))*
           Global`u), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] - 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (-1 + Global`u^2)/((1 - Global`u^(-2))*
           Global`u^2), 0, (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), 1] + 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (-1 + Global`u^2)/((1 - Global`u^(-2))*
           Global`u^2), 0, (-1 + Global`u^2)/((1 - Global`u^(-2))*(-1 + Global`u)*Global`u), 1] + 
       6*PolyLogTools`G[1 - Global`u, 0, 1, (1 - Global`u)^(-1), 1] - 
       18*PolyLogTools`G[1 - Global`u, 0, 1, 1 - Global`u, 1] - 
       18*PolyLogTools`G[1 - Global`u, 0, 1 - Global`u, 1, 1] + 
       6*PolyLogTools`G[1 - Global`u, 0, (1 - Global`u)/(-1 + Global`u)^2, 
         (1 - Global`u)^2/(-1 + Global`u)^2, 1] + 6*PolyLogTools`G[1 - Global`u, 1, 0, 
         (1 - Global`u)^(-1), 1] - 18*PolyLogTools`G[1 - Global`u, 1, 0, 1 - Global`u, 1] - 
       24*PolyLogTools`G[1 - Global`u, 1, 1, (1 - Global`u)^(-1), 1] - 
       12*PolyLogTools`G[1 - Global`u, 1, (1 - Global`u)^(-1), 1, 1] + 
       42*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 0, 1, 1] - 
       24*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 0, (-1 + Global`u)/Global`u, 1] - 
       18*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 0, Global`u/(-1 + Global`u), 1] - 
       138*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1, 1] + 
       60*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, (-1 + Global`u)/Global`u, 1] + 
       36*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, Global`u/(-1 + Global`u), 1] + 
       42*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1, 1] + 
       6*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 1, 1] - 
       6*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 1] - 84*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, 0, 1, 1] + 
       60*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, 0, (-1 + Global`u)/Global`u, 1] + 
       24*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, 0, Global`u/(-1 + Global`u), 1] - 
       48*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, 1, Global`u/(-1 + Global`u), 1] - 
       12*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, Global`u/(-1 + Global`u), 1, 1] + 
       12*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 1] - 6*PolyLogTools`G[(-1 + Global`u)/Global`u, 
         (-1 + Global`u)/Global`u, 0, 1, 1] + 6*PolyLogTools`G[(-1 + Global`u)/Global`u, 
         (-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 1] - 
       12*PolyLogTools`G[(-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1, 
         Global`u/(-1 + Global`u), 1] + 12*PolyLogTools`G[Global`u, 0, 1, 1, 1] + 
       6*PolyLogTools`G[Global`u, 1, 0, 1, 1] - 30*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 0, 
         1, 1] + 6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 0, (-1 + Global`u)/Global`u, 1] + 
       24*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 0, Global`u/(-1 + Global`u), 1] + 
       18*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1, 1] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, (-1 + Global`u)/Global`u, 1] - 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, Global`u/(-1 + Global`u), 1] + 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1, 1] + 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 
         (-1 + Global`u)/Global`u, 1] + 12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 
         Global`u/(-1 + Global`u), 1, 1] + 18*PolyLogTools`G[Global`u/(-1 + Global`u), 1, 0, 1, 
         1] - 6*PolyLogTools`G[Global`u/(-1 + Global`u), 1, 0, Global`u/(-1 + Global`u), 1] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1, 1] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 
         (-1 + Global`u)/Global`u, 1] + 6*PolyLogTools`G[Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 0, 1, 1] - 6*PolyLogTools`G[Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1, 
         (-1 + Global`u)/Global`u, 1] - 6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), ((-1 + Global`u)*(-1 + Global`u^2))/
          ((1 - Global`u^(-2))*Global`u^3), ((-1 + Global`u)*(-1 + Global`u^2))/
          ((1 - Global`u^(-2))*Global`u^3), 1] + 6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), ((-1 + Global`u)*(-1 + Global`u^2))/
          ((1 - Global`u^(-2))*Global`u^3), (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), 
         1] - 6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/
          ((1 + Global`u^(-1))*Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*Global`u^2), 
         (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*Global`u), 1] - 
       6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/((1 + Global`u^(-1))*
           Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*Global`u), 
         (-1 + Global`u^2)/((1 + Global`u^(-1))*Global`u^2), 1] + 
       12*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/
          ((1 + Global`u^(-1))*Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*
           Global`u), (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*Global`u), 1] - 
       36*PolyLogTools`G[0, 0, 1, -1]*Log[2] + 5*Pi^2*Log[2]^2 + 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[2]^2 - 6*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[2]^2 + 6*PolyLogTools`G[0, 0, 1, -1]*Log[4] + (2*Pi^2*Log[(1 - Global`u)^(-1)])/3 - 
       EulerGamma*Pi^2*Log[(1 - Global`u)^(-1)] - 8*PolyLogTools`G[0, 1, -1]*
        Log[(1 - Global`u)^(-1)] - 24*EulerGamma*PolyLogTools`G[0, 1, -1]*
        Log[(1 - Global`u)^(-1)] - 4*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[(1 - Global`u)^(-1)] + 6*EulerGamma*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[(1 - Global`u)^(-1)] - 4*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(1 - Global`u)^(-1)] - 18*EulerGamma*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(1 - Global`u)^(-1)] + 36*PolyLogTools`G[-1, 0, -1, 1]*Log[(1 - Global`u)^(-1)] - 
       36*PolyLogTools`G[0, 0, 1, -1]*Log[(1 - Global`u)^(-1)] + 
       6*PolyLogTools`G[0, 0, 1, 1 - Global`u]*Log[(1 - Global`u)^(-1)] - 
       18*PolyLogTools`G[0, 0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)] - 
       48*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1]*Log[(1 - Global`u)^(-1)] + 
       12*PolyLogTools`G[0, 1, 1 - Global`u, 1]*Log[(1 - Global`u)^(-1)] + 
       18*PolyLogTools`G[0, 1, Global`u, 1]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1]*Log[(1 - Global`u)^(-1)] + 
       12*PolyLogTools`G[0, 1 - Global`u, 1, 1]*Log[(1 - Global`u)^(-1)] + 
       12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1]*Log[(1 - Global`u)^(-1)] + 
       6*PolyLogTools`G[0, Global`u, 1, 1]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[0, Global`u, Global`u, 1]*Log[(1 - Global`u)^(-1)] - 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1]*Log[(1 - Global`u)^(-1)] + 
       18*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1]*
        Log[(1 - Global`u)^(-1)] - 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1]*Log[(1 - Global`u)^(-1)] + 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, (-1 + Global`u^2)/((1 - Global`u^(-2))*
           Global`u^2), 1]*Log[(1 - Global`u)^(-1)] - 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), ((-1 + Global`u)*(1 + Global`u))/
          ((1 - Global`u^(-2))*Global`u^2), 1]*Log[(1 - Global`u)^(-1)] + 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[Global`u, 0, 1, 1]*Log[(1 - Global`u)^(-1)] + 
       12*PolyLogTools`G[Global`u, 0, Global`u, 1]*Log[(1 - Global`u)^(-1)] - 
       36*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1]*Log[(1 - Global`u)^(-1)] + 
       24*PolyLogTools`G[Global`u/(-1 + Global`u), 0, Global`u/(-1 + Global`u), 1]*
        Log[(1 - Global`u)^(-1)] - 24*PolyLogTools`G[0, 1, -1]*Log[2]*Log[(1 - Global`u)^(-1)] - 
       5*Pi^2*Log[(1 - Global`u)^(-1)]^2 + 12*PolyLogTools`G[-1, -1, 1]*
        Log[(1 - Global`u)^(-1)]^2 + 54*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)]^2 + 
       3*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)]^2 + 
       3*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[(1 - Global`u)^(-1)]^2 - 
       6*Log[2]^2*Log[(1 - Global`u)^(-1)]^2 - 4*EulerGamma*Log[(1 - Global`u)^(-1)]^3 + 
       (5*Log[(1 - Global`u)^(-1)]^4)/2 - (4*Pi^2*Log[1 - Global`u])/3 - 
       2*EulerGamma*Pi^2*Log[1 - Global`u] - 24*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[1 - Global`u] + 18*PolyLogTools`G[-1, 0, -1, 1]*Log[1 - Global`u] - 
       18*PolyLogTools`G[0, 0, 1, -1]*Log[1 - Global`u] - 
       12*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u] - 
       204*PolyLogTools`G[0, 0, 1, Global`u^(-1)]*Log[1 - Global`u] - 
       24*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] - 
       6*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)]*Log[1 - Global`u] + 
       6*PolyLogTools`G[0, 1, 1 - Global`u, 1]*Log[1 - Global`u] + 
       108*PolyLogTools`G[0, 1, Global`u, 1]*Log[1 - Global`u] + 
       6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1]*Log[1 - Global`u] - 
       6*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1]*Log[1 - Global`u] + 
       24*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1]*Log[1 - Global`u] + 
       6*PolyLogTools`G[0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1]*
        Log[1 - Global`u] - 96*PolyLogTools`G[0, Global`u, 1, 1]*Log[1 - Global`u] - 
       108*PolyLogTools`G[0, Global`u, Global`u, 1]*Log[1 - Global`u] - 
       18*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1]*Log[1 - Global`u] + 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1]*
        Log[1 - Global`u] + 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1]*Log[1 - Global`u] - 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, (-1 + Global`u^2)/((1 - Global`u^(-2))*
           Global`u^2), 1]*Log[1 - Global`u] + 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), ((-1 + Global`u)*(1 + Global`u))/
          ((1 - Global`u^(-2))*Global`u^2), 1]*Log[1 - Global`u] - 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1]*Log[1 - Global`u] - 
       12*PolyLogTools`G[Global`u, 0, 1, 1]*Log[1 - Global`u] + 
       12*PolyLogTools`G[Global`u, 0, Global`u, 1]*Log[1 - Global`u] - 
       24*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1]*Log[1 - Global`u] + 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1]*
        Log[1 - Global`u] + 18*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 
         Global`u/(-1 + Global`u), 1]*Log[1 - Global`u] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1]*
        Log[1 - Global`u] + 6*PolyLogTools`G[0, 1, -1]*Log[2]*Log[1 - Global`u] - 
       6*Pi^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] - 12*PolyLogTools`G[-1, -1, 1]*
        Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 36*PolyLogTools`G[0, 1, -1]*
        Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)]*
        Log[1 - Global`u] + 6*Log[2]^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 
       64*Log[1 - Global`u]^2 - (7*Pi^2*Log[1 - Global`u]^2)/2 + 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u]^2 + 
       60*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u]^2 - 2*Log[1 - Global`u]^3 + 
       (7*Log[1 - Global`u]^4)/4 - 6*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)]*
        Log[-4/(-1 + Global`u)] + 8*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)] - 
       24*EulerGamma*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)] - 
       24*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u]*Log[-2/(-1 + Global`u)] - 
       Pi^2*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)] - 24*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)] - 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)] - (Pi^2*Log[(-1 + Global`u)^(-1)]^2)/2 - 
       12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(-1 + Global`u)^(-1)]^2 - 
       3*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)^(-1)]^2 + 
       3*Pi^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] + 
       12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)]*
        Log[-1 + Global`u] + (3*Pi^2*Log[-1 + Global`u]^2)/2 + 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[-1 + Global`u]^2 - 
       Pi^2*Log[-Global`u^(-1)]^2 + 12*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[-Global`u^(-1)]^2 + 3*PolyLogTools`G[0, 1, 1 - Global`u]*Log[-Global`u^(-1)]^2 - 
       3*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[-Global`u^(-1)]^2 - 
       2*Pi^2*Log[Global`u^(-1)] + 5*EulerGamma*Pi^2*Log[Global`u^(-1)] + 
       8*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)] - 4*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[Global`u^(-1)] - 6*EulerGamma*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)] + 
       18*EulerGamma*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)] + 
       9*PolyLogTools`G[-1, 0, -1, 1]*Log[Global`u^(-1)] - 9*PolyLogTools`G[0, 0, 1, -1]*
        Log[Global`u^(-1)] + 24*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 
       18*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)] - 
       6*PolyLogTools`G[0, 1, 1 - Global`u, 1]*Log[Global`u^(-1)] - 
       6*PolyLogTools`G[0, 1, Global`u, 1]*Log[Global`u^(-1)] - 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1]*Log[Global`u^(-1)] + 
       24*PolyLogTools`G[0, 1 - Global`u, 1, 1]*Log[Global`u^(-1)] + 
       36*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1]*Log[Global`u^(-1)] - 
       6*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1]*Log[Global`u^(-1)] - 
       12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1]*
        Log[Global`u^(-1)] - 6*PolyLogTools`G[0, Global`u, 1, 1]*Log[Global`u^(-1)] + 
       6*PolyLogTools`G[0, Global`u, Global`u, 1]*Log[Global`u^(-1)] - 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1]*Log[Global`u^(-1)] - 
       30*PolyLogTools`G[1 - Global`u, 0, 1, 1]*Log[Global`u^(-1)] + 
       30*PolyLogTools`G[1 - Global`u, 0, 1 - Global`u, 1]*Log[Global`u^(-1)] + 
       12*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1]*Log[Global`u^(-1)] - 
       12*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1]*
        Log[Global`u^(-1)] + 6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, 
         (-1 + Global`u^2)/((1 + Global`u^(-1))*Global`u^2), (-1 + Global`u^2)/
          ((1 + Global`u^(-1))*Global`u^2), 1]*Log[Global`u^(-1)] - 
       6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/((1 + Global`u^(-1))*
           Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*Global`u), 1]*
        Log[Global`u^(-1)] + 9*PolyLogTools`G[0, 1, -1]*Log[2]*Log[Global`u^(-1)] - 
       Pi^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 6*PolyLogTools`G[0, 1, 1 - Global`u]*
        Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] - 60*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 128*Log[1 - Global`u]*Log[Global`u^(-1)] - 
       (21*Pi^2*Log[1 - Global`u]*Log[Global`u^(-1)])/2 + 30*PolyLogTools`G[-1, -1, 1]*
        Log[1 - Global`u]*Log[Global`u^(-1)] - 6*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u]*
        Log[Global`u^(-1)] + 6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[Global`u^(-1)] - 12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u]*
        Log[Global`u^(-1)] + 6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[1 - Global`u]*
        Log[Global`u^(-1)] - 15*Log[2]^2*Log[1 - Global`u]*Log[Global`u^(-1)] - 
       4*Log[1 - Global`u]^2*Log[Global`u^(-1)] + 3*Log[1 - Global`u]^3*Log[Global`u^(-1)] + 
       (3*Pi^2*Log[-1 + Global`u]*Log[Global`u^(-1)])/2 - 18*PolyLogTools`G[-1, -1, 1]*
        Log[-1 + Global`u]*Log[Global`u^(-1)] - 24*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u]*
        Log[Global`u^(-1)] + 9*Log[2]^2*Log[-1 + Global`u]*Log[Global`u^(-1)] - 
       4*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 6*Log[1 - Global`u]^2*
        Log[-1 + Global`u]*Log[Global`u^(-1)] + 6*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
        Log[-1 + Global`u]*Log[Global`u^(-1)] + 3*Log[(-1 + Global`u)^(-1)]^2*Log[-1 + Global`u]*
        Log[Global`u^(-1)] + 2*Log[-1 + Global`u]^2*Log[Global`u^(-1)] + 
       6*Log[1 - Global`u]*Log[-1 + Global`u]^2*Log[Global`u^(-1)] - 
       5*Log[-1 + Global`u]^3*Log[Global`u^(-1)] - 18*PolyLogTools`G[0, 1, -1]*
        Log[2*(-1 + Global`u)]*Log[Global`u^(-1)] + Pi^2*Log[-Global`u^(-1)]*Log[Global`u^(-1)] + 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[-Global`u^(-1)]*Log[Global`u^(-1)] + 
       6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[-Global`u^(-1)]*Log[Global`u^(-1)] + 
       64*Log[Global`u^(-1)]^2 - 4*Pi^2*Log[Global`u^(-1)]^2 - 24*PolyLogTools`G[0, 1, -1]*
        Log[Global`u^(-1)]^2 + 42*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2 - 
       3*PolyLogTools`G[0, 1, 1 - Global`u]*Log[Global`u^(-1)]^2 + 
       30*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)]^2 - 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)]^2 - 
       6*Log[1 - Global`u]*Log[Global`u^(-1)]^2 + (15*Log[1 - Global`u]^2*Log[Global`u^(-1)]^2)/2 + 
       6*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)]^2 + 
       3*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)]^2 + 12*Log[1 - Global`u]*Log[-1 + Global`u]*
        Log[Global`u^(-1)]^2 - 6*Log[-1 + Global`u]^2*Log[Global`u^(-1)]^2 - 
       (10*Log[Global`u^(-1)]^3)/3 + 4*EulerGamma*Log[Global`u^(-1)]^3 + 
       9*Log[1 - Global`u]*Log[Global`u^(-1)]^3 + (9*Log[Global`u^(-1)]^4)/4 + 
       (4*Pi^2*Log[(-1 + Global`u)/Global`u])/3 + 8*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(-1 + Global`u)/Global`u] + 48*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u]*
        Log[(-1 + Global`u)/Global`u] + 12*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)]*
        Log[(-1 + Global`u)/Global`u] + 24*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1]*
        Log[(-1 + Global`u)/Global`u] + 12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1]*
        Log[(-1 + Global`u)/Global`u] + 72*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1]*
        Log[(-1 + Global`u)/Global`u] - 36*PolyLogTools`G[0, Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 1]*Log[(-1 + Global`u)/Global`u] + 
       Pi^2*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] - 36*PolyLogTools`G[0, 1, -1]*
        Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] - 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] - 3*Log[(1 - Global`u)^(-1)]^3*
        Log[(-1 + Global`u)/Global`u] + 128*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 
       13*Pi^2*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 12*PolyLogTools`G[-1, -1, 1]*
        Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + 12*PolyLogTools`G[0, 1, -1]*
        Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 
       18*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] - 6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + 6*Log[2]^2*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] - 8*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u] + 
       12*Log[1 - Global`u]^3*Log[(-1 + Global`u)/Global`u] + 4*Pi^2*Log[(-1 + Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 16*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 48*Log[1 - Global`u]^2*Log[(-1 + Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 8*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] - 18*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] + 4*Log[(-1 + Global`u)^(-1)]^3*
        Log[(-1 + Global`u)/Global`u] - 40*Pi^2*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u] - 
       48*PolyLogTools`G[-1, -1, 1]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u] + 
       24*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u] - 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 24*Log[2]^2*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 8*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 6*Log[(1 - Global`u)^(-1)]^2*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 24*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u] + 72*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u] + 
       6*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 33*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 4*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] + 
       3*EulerGamma*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] - 
       12*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] + 
       12*Log[1 - Global`u]*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] - 
       2*Log[Global`u^(-1)]^3*Log[(-1 + Global`u)/Global`u] - 64*Log[(-1 + Global`u)/Global`u]^2 + 
       7*Pi^2*Log[(-1 + Global`u)/Global`u]^2 + 6*PolyLogTools`G[-1, -1, 1]*
        Log[(-1 + Global`u)/Global`u]^2 - 12*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)/Global`u]^
         2 - 3*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       51*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)/Global`u]^2 + 
       3*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[(-1 + Global`u)/Global`u]^2 - 
       3*Log[2]^2*Log[(-1 + Global`u)/Global`u]^2 - (3*Log[(1 - Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u]^2)/2 + 18*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^
         2 - 6*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2 - 
       48*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u]^2 + 39*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       (39*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u]^2)/2 - 
       3*EulerGamma*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       54*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       3*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2 - 
       27*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u]^2 - 
       (20*Log[(-1 + Global`u)/Global`u]^3)/3 + 3*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u]^3 + 56*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^3 - 
       Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^3 - (69*Log[(-1 + Global`u)/Global`u]^4)/
        4 - 2*Pi^2*Log[Global`u^(-1)]*Log[-Global`u] - 6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[Global`u^(-1)]*Log[-Global`u] - 12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[Global`u^(-1)]*Log[-Global`u] - 3*Pi^2*Log[-Global`u]^2 - 
       3*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[-Global`u]^2 - 
       3*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[-Global`u]^2 - 
       27*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[-Global`u]^2 + 
       3*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*Log[-Global`u]^2 + 
       (3*Log[(-1 + Global`u)/Global`u]^2*Log[-Global`u]^2)/2 + 960*Log[Global`u] - 
       (28*Pi^2*Log[Global`u])/3 + 2*EulerGamma*Pi^2*Log[Global`u] - 
       8*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] + 
       8*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
       8*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] + 
       12*PolyLogTools`G[-1, 0, -1, 1]*Log[Global`u] - 12*PolyLogTools`G[0, 0, 1, -1]*
        Log[Global`u] + 12*PolyLogTools`G[0, 0, 1, 1 - Global`u]*Log[Global`u] - 
       78*PolyLogTools`G[0, 0, 1, Global`u^(-1)]*Log[Global`u] - 
       18*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
       12*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] - 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1]*Log[Global`u] + 
       18*PolyLogTools`G[0, 1, 1 - Global`u, 1]*Log[Global`u] + 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1]*Log[Global`u] + 
       6*PolyLogTools`G[0, 1, Global`u, 1]*Log[Global`u] + 
       18*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1]*Log[Global`u] + 
       6*PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1]*Log[Global`u] + 
       24*PolyLogTools`G[0, 1 - Global`u, 1, 1]*Log[Global`u] + 
       30*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1]*Log[Global`u] + 
       12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1]*Log[Global`u] + 
       42*PolyLogTools`G[0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1]*Log[Global`u] - 
       72*PolyLogTools`G[0, Global`u, 1, 1]*Log[Global`u] - 
       36*PolyLogTools`G[0, Global`u, Global`u, 1]*Log[Global`u] - 
       6*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1]*Log[Global`u] - 
       18*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1]*Log[Global`u] - 
       30*PolyLogTools`G[1 - Global`u, 0, 1, 1]*Log[Global`u] + 
       48*PolyLogTools`G[1 - Global`u, 0, 1 - Global`u, 1]*Log[Global`u] - 
       6*PolyLogTools`G[1 - Global`u, 0, (1 - Global`u)/(-1 + Global`u)^2, 1]*Log[Global`u] + 
       12*PolyLogTools`G[1 - Global`u, 1, (1 - Global`u)^(-1), 1]*Log[Global`u] - 
       42*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1]*Log[Global`u] + 
       42*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1]*Log[Global`u] - 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1]*Log[Global`u] + 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1]*Log[Global`u] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1]*Log[Global`u] - 
       6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/((1 + Global`u^(-1))*
           Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*Global`u^2), 1]*Log[Global`u] + 
       6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/((1 + Global`u^(-1))*
           Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*Global`u), 1]*
        Log[Global`u] - 2*Pi^2*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
       12*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
       18*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
       18*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
       5*Pi^2*Log[1 - Global`u]*Log[Global`u] + 72*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[1 - Global`u]*Log[Global`u] + 36*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[1 - Global`u]*Log[Global`u] - 4*Log[1 - Global`u]^2*Log[Global`u] + 
       6*Log[1 - Global`u]^3*Log[Global`u] - 12*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)]*
        Log[Global`u] - 4*Pi^2*Log[-Global`u^(-1)]*Log[Global`u] + 12*PolyLogTools`G[-1, -1, 1]*
        Log[-Global`u^(-1)]*Log[Global`u] - 12*PolyLogTools`G[0, 1, -1]*Log[-Global`u^(-1)]*
        Log[Global`u] + 30*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[-Global`u^(-1)]*
        Log[Global`u] + 6*PolyLogTools`G[0, 1, 1 - Global`u]*Log[-Global`u^(-1)]*Log[Global`u] - 
       6*Log[2]^2*Log[-Global`u^(-1)]*Log[Global`u] + 3*Log[(1 - Global`u)^(-1)]*
        Log[-Global`u^(-1)]^2*Log[Global`u] - 4*Log[-Global`u^(-1)]^3*Log[Global`u] + 
       2*Pi^2*Log[Global`u^(-1)]*Log[Global`u] - 24*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)]*
        Log[Global`u] + 30*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[Global`u] - 8*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] + 
       12*Log[1 - Global`u]^2*Log[Global`u^(-1)]*Log[Global`u] + 12*Log[1 - Global`u]*
        Log[-1 + Global`u]*Log[Global`u^(-1)]*Log[Global`u] - 6*Log[-1 + Global`u]^2*
        Log[Global`u^(-1)]*Log[Global`u] - 4*Log[Global`u^(-1)]^2*Log[Global`u] + 
       3*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2*Log[Global`u] + 
       18*Log[1 - Global`u]*Log[Global`u^(-1)]^2*Log[Global`u] + 6*Log[Global`u^(-1)]^3*
        Log[Global`u] - 4*Pi^2*Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 
       24*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 
       30*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u] + 6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 6*Log[(1 - Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 8*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 24*Log[1 - Global`u]^2*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 48*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 
       24*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 
       24*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 
       12*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 
       4*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] - 54*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] + 19*Log[(-1 + Global`u)/Global`u]^3*
        Log[Global`u] + 4*Pi^2*Log[-Global`u]*Log[Global`u] + 6*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[-Global`u]*Log[Global`u] + 42*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[-Global`u]*Log[Global`u] - 6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[-Global`u]*Log[Global`u] - 3*Log[(-1 + Global`u)/Global`u]^2*Log[-Global`u]*
        Log[Global`u] - 128*Log[Global`u]^2 + (21*Pi^2*Log[Global`u]^2)/2 + 
       3*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u]^2 + 
       12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u]^2 - 
       12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u]^2 + 
       9*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u]^2 + 
       6*Log[1 - Global`u]^2*Log[Global`u]^2 + 6*Log[(1 - Global`u)^(-1)]*Log[-Global`u^(-1)]*
        Log[Global`u]^2 - 9*Log[-Global`u^(-1)]^2*Log[Global`u]^2 + 
       12*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u]^2 + 6*Log[Global`u^(-1)]^2*
        Log[Global`u]^2 - 3*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u]^2 + 12*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*Log[Global`u]^2 - 
       6*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u]^2 + (8*Log[Global`u]^3)/3 + 
       2*Log[(1 - Global`u)^(-1)]*Log[Global`u]^3 - 6*Log[-Global`u^(-1)]*Log[Global`u]^3 - 
       (7*Log[Global`u]^4)/2 - 6*Pi^2*Log[Global`u/(-1 + Global`u)] + 
       EulerGamma*Pi^2*Log[Global`u/(-1 + Global`u)] + 8*PolyLogTools`G[0, 1, -1]*
        Log[Global`u/(-1 + Global`u)] - 12*EulerGamma*PolyLogTools`G[0, 1, -1]*
        Log[Global`u/(-1 + Global`u)] + 24*PolyLogTools`G[0, 0, 1, Global`u^(-1)]*
        Log[Global`u/(-1 + Global`u)] + 24*PolyLogTools`G[0, Global`u, 1, 1]*
        Log[Global`u/(-1 + Global`u)] - 24*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u^(-1)]*
        Log[Global`u/(-1 + Global`u)] - 2*Log[-1 + Global`u^(-1)]^3*Log[Global`u/(-1 + Global`u)] - 
       2*Pi^2*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)] + 
       12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)]*
        Log[Global`u/(-1 + Global`u)] - 6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)] - 6*Log[-1 + Global`u^(-1)]^2*
        Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)] + 2*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 3*EulerGamma*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 6*Log[-1 + Global`u^(-1)]*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 12*PolyLogTools`G[-1, -1, 1]*Log[1 - Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[1 - Global`u]*Log[Global`u/(-1 + Global`u)] + 6*Log[2]^2*Log[1 - Global`u]*
        Log[Global`u/(-1 + Global`u)] - 3*Log[(1 - Global`u)^(-1)]^2*Log[1 - Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*Pi^2*Log[-Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] - 
       2*Log[-Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)] + 6*Log[-1 + Global`u^(-1)]*
        Log[-Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)] - 9*Log[-Global`u^(-1)]^3*
        Log[Global`u/(-1 + Global`u)] - 14*Pi^2*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] - 
       12*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] - 
       3*Log[1 - Global`u]^2*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] + 
       4*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] + 
       15*Log[-Global`u^(-1)]^2*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] - 
       12*Log[1 - Global`u]*Log[Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)] - 
       24*Log[-Global`u^(-1)]*Log[Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)] - 
       12*Log[Global`u^(-1)]^3*Log[Global`u/(-1 + Global`u)] - 4*Pi^2*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u/(-1 + Global`u)] + 
       6*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2*
        Log[Global`u/(-1 + Global`u)] - 3*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2*
        Log[Global`u/(-1 + Global`u)] - 4*Log[(-1 + Global`u)/Global`u]^3*
        Log[Global`u/(-1 + Global`u)] + 6*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*Log[-Global`u]*
        Log[Global`u/(-1 + Global`u)] + 3*Log[-Global`u^(-1)]*Log[-Global`u]^2*
        Log[Global`u/(-1 + Global`u)] - 128*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 
       9*Pi^2*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 12*PolyLogTools`G[-1, -1, 1]*
        Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 24*PolyLogTools`G[0, 1, -1]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 6*Log[2]^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*Log[-1 + Global`u^(-1)]^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 12*Log[-1 + Global`u^(-1)]*Log[(1 - Global`u)^(-1)]*
        Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 3*Log[(1 - Global`u)^(-1)]^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] + 6*Log[1 - Global`u]^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] + 12*Log[-1 + Global`u^(-1)]*Log[-Global`u^(-1)]*
        Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 3*Log[-Global`u^(-1)]^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 30*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] + 12*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 6*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 
       3*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 
       4*Log[Global`u]^2*Log[Global`u/(-1 + Global`u)] - 3*Log[Global`u]^3*
        Log[Global`u/(-1 + Global`u)] + 64*Log[Global`u/(-1 + Global`u)]^2 + 
       5*Pi^2*Log[Global`u/(-1 + Global`u)]^2 - 12*PolyLogTools`G[0, 1, -1]*
        Log[Global`u/(-1 + Global`u)]^2 + 3*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[Global`u/(-1 + Global`u)]^2 + 3*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 - 2*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^
         2 + 3*EulerGamma*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^2 - 
       3*Log[(1 - Global`u)^(-1)]^2*Log[Global`u/(-1 + Global`u)]^2 + 
       3*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[Global`u/(-1 + Global`u)]^2 - 
       3*Log[1 - Global`u]^2*Log[Global`u/(-1 + Global`u)]^2 - 
       (9*Log[-Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)]^2)/2 + 
       4*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)]^2 - 3*Log[1 - Global`u]*
        Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)]^2 - 39*Log[Global`u^(-1)]^2*
        Log[Global`u/(-1 + Global`u)]^2 - 6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 - (3*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u/(-1 + Global`u)]^2)/2 + 6*Log[Global`u^(-1)]*Log[-Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 + 3*Log[-Global`u]^2*Log[Global`u/(-1 + Global`u)]^2 + 
       6*Log[Global`u]*Log[Global`u/(-1 + Global`u)]^2 - 9*Log[-Global`u^(-1)]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 - 36*Log[Global`u^(-1)]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 - (21*Log[Global`u]^2*Log[Global`u/(-1 + Global`u)]^2)/2 - 
       (10*Log[Global`u/(-1 + Global`u)]^3)/3 - 18*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)]^
         3 - 23*Log[Global`u]*Log[Global`u/(-1 + Global`u)]^3 + 
       (37*Log[Global`u/(-1 + Global`u)]^4)/4 + (832*Zeta[3])/3 + 24*EulerGamma*Zeta[3] + 
       18*Log[(1 - Global`u)^(-1)]*Zeta[3] - 60*Log[1 - Global`u]*Zeta[3] + 
       33*Log[Global`u^(-1)]*Zeta[3] + 12*Log[(-1 + Global`u)/Global`u]*Zeta[3] - 
       790*Log[Global`u]*Zeta[3] + 24*Log[Global`u/(-1 + Global`u)]*Zeta[3]|>, 
   "Series" -> -3/Global`\[Epsilon]^5 + (-2 + 6*Log[Global`u])/Global`\[Epsilon]^4 + 
     (-64 + (13*Pi^2)/2 - 6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + 
       6*PolyLogTools`G[0, 1, Global`u^(-1)] - 6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       3*Log[1 - Global`u]^2 + 6*Log[1 - Global`u]*Log[Global`u^(-1)] + 3*Log[Global`u^(-1)]^2 + 
       6*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 3*Log[(-1 + Global`u)/Global`u]^2 + 
       4*Log[Global`u] - 6*Log[Global`u]^2 - 6*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 
       3*Log[Global`u/(-1 + Global`u)]^2)/Global`\[Epsilon]^3 + 
     (-480 + (13*Pi^2)/3 - 4*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + 
       4*PolyLogTools`G[0, 1, Global`u^(-1)] - 4*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       12*PolyLogTools`G[-1, 0, -1, 1] + 12*PolyLogTools`G[0, 0, 1, -1] + 
       30*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)] + 
       42*PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 18*PolyLogTools`G[0, 0, 1, 
         (-1 + Global`u)/Global`u] - 18*PolyLogTools`G[0, 1, 1 - Global`u, 1] - 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] - 6*PolyLogTools`G[0, 1, Global`u, 1] - 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] + 
       6*PolyLogTools`G[0, 1 - Global`u, 1, 1] + 18*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 
         1] - 12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
       36*PolyLogTools`G[0, Global`u, 1, 1] + 18*PolyLogTools`G[0, Global`u, Global`u, 1] + 
       6*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] + 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] + 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1] - 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] + 
       Pi^2*Log[(1 - Global`u)^(-1)] - 12*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)] - 
       2*Pi^2*Log[1 - Global`u] - 36*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] + 
       2*Log[1 - Global`u]^2 - 3*Log[1 - Global`u]^3 + 12*PolyLogTools`G[0, 1, -1]*
        Log[-2/(-1 + Global`u)] - 3*Pi^2*Log[Global`u^(-1)] + 12*PolyLogTools`G[0, 1, -1]*
        Log[Global`u^(-1)] - 6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 
       4*Log[1 - Global`u]*Log[Global`u^(-1)] - 6*Log[1 - Global`u]^2*Log[Global`u^(-1)] - 
       6*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 3*Log[-1 + Global`u]^2*
        Log[Global`u^(-1)] + 2*Log[Global`u^(-1)]^2 - 9*Log[1 - Global`u]*Log[Global`u^(-1)]^2 - 
       5*Log[Global`u^(-1)]^3 + 2*Pi^2*Log[(-1 + Global`u)/Global`u] + 
       12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)/Global`u] + 
       4*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 12*Log[1 - Global`u]^2*
        Log[(-1 + Global`u)/Global`u] + 24*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 12*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] + 12*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 6*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] - 
       2*Log[(-1 + Global`u)/Global`u]^2 + 27*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2 - 
       10*Log[(-1 + Global`u)/Global`u]^3 + 128*Log[Global`u] - 14*Pi^2*Log[Global`u] - 
       12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] + 
       12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] - 
       6*Log[1 - Global`u]^2*Log[Global`u] - 12*Log[1 - Global`u]*Log[Global`u^(-1)]*
        Log[Global`u] - 6*Log[Global`u^(-1)]^2*Log[Global`u] - 12*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 6*Log[(-1 + Global`u)/Global`u]^2*
        Log[Global`u] - 4*Log[Global`u]^2 + 4*Log[Global`u]^3 - 
       9*Pi^2*Log[Global`u/(-1 + Global`u)] + 12*PolyLogTools`G[0, 1, -1]*
        Log[Global`u/(-1 + Global`u)] + 3*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 3*Log[-Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)] + 
       6*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] - 
       4*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 6*Log[Global`u]^2*
        Log[Global`u/(-1 + Global`u)] + 2*Log[Global`u/(-1 + Global`u)]^2 - 
       3*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^2 + 
       6*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)]^2 + 9*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 - 5*Log[Global`u/(-1 + Global`u)]^3 + 416*Zeta[3])/
      Global`\[Epsilon]^2 + (-3840 + (416*Pi^2)/3 + (2707*Pi^4)/120 - 10*Pi^2*PolyLogTools`G[-1, -1, 1] - 
       4*Pi^2*PolyLogTools`G[0, 1, -1] - 6*PolyLogTools`G[0, 1, -1]^2 - 
       128*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + 
       16*Pi^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] - 12*PolyLogTools`G[-1, -1, 1]*
        PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + 12*PolyLogTools`G[0, 1, -1]*
        PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + Pi^2*PolyLogTools`G[0, 1, 1 - Global`u] + 
       128*PolyLogTools`G[0, 1, Global`u^(-1)] - 31*Pi^2*PolyLogTools`G[0, 1, Global`u^(-1)] + 
       12*PolyLogTools`G[-1, -1, 1]*PolyLogTools`G[0, 1, Global`u^(-1)] + 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*PolyLogTools`G[0, 1, Global`u^(-1)] - 
       128*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       8*Pi^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 12*PolyLogTools`G[0, 1, -1]*
        PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       6*PolyLogTools`G[0, 1, 1 - Global`u]*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       60*PolyLogTools`G[0, 1, Global`u^(-1)]*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       12*Pi^2*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] + 12*PolyLogTools`G[0, 1, -1]*
        PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 8*PolyLogTools`G[-1, 0, -1, 1] + 
       24*EulerGamma*PolyLogTools`G[-1, 0, -1, 1] + 8*PolyLogTools`G[0, 0, 1, -1] - 
       24*EulerGamma*PolyLogTools`G[0, 0, 1, -1] + 20*PolyLogTools`G[0, 0, 1, 
         (1 - Global`u)^(-1)] - 12*EulerGamma*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)] + 
       28*PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 12*EulerGamma*PolyLogTools`G[0, 0, 1, 
         Global`u^(-1)] + 12*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u] - 
       24*EulerGamma*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u] + 
       24*EulerGamma*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)] - 
       12*PolyLogTools`G[0, 1, 1 - Global`u, 1] + 6*EulerGamma*PolyLogTools`G[0, 1, 1 - Global`u, 
         1] - 4*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] + 
       12*EulerGamma*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] - 
       4*PolyLogTools`G[0, 1, Global`u, 1] - 6*EulerGamma*PolyLogTools`G[0, 1, Global`u, 1] - 
       8*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] - 
       12*EulerGamma*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] + 
       4*PolyLogTools`G[0, 1 - Global`u, 1, 1] + 12*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 
         1] - 6*EulerGamma*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1] - 
       8*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
       6*EulerGamma*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
       24*PolyLogTools`G[0, Global`u, 1, 1] + 12*PolyLogTools`G[0, Global`u, Global`u, 1] + 
       6*EulerGamma*PolyLogTools`G[0, Global`u, Global`u, 1] + 
       4*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] - 
       6*EulerGamma*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] + 
       8*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] + 
       12*EulerGamma*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1] - 
       12*EulerGamma*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 1] + 
       24*EulerGamma*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, Global`u/(-1 + Global`u), 1] + 
       4*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1] - 
       12*EulerGamma*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1] - 
       4*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       12*EulerGamma*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       8*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] - 
       24*EulerGamma*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] + 
       24*PolyLogTools`G[-1, 0, 0, -1, 1] + 12*PolyLogTools`G[0, -1, 0, -1, 1] + 
       24*PolyLogTools`G[0, 0, -1, -1, 1] + 60*PolyLogTools`G[0, 0, 0, 1, -1] - 
       108*PolyLogTools`G[0, 0, 0, 1, (1 - Global`u)^(-1)] - 
       12*PolyLogTools`G[0, 0, 0, 1, 1 - Global`u] + 270*PolyLogTools`G[0, 0, 0, 1, 
         Global`u^(-1)] - 54*PolyLogTools`G[0, 0, 0, 1, (-1 + Global`u)/Global`u] - 
       6*PolyLogTools`G[0, 0, 0, 1, Global`u/(-1 + Global`u)] + 
       72*PolyLogTools`G[0, 0, 1, 1 - Global`u, 1] - 
       6*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u, 1] - 
       102*PolyLogTools`G[0, 0, 1, Global`u, 1] + 12*PolyLogTools`G[0, 0, 1, 
         Global`u/(-1 + Global`u), 1] - 12*PolyLogTools`G[0, 0, (1 - Global`u)^(-1), 1, 1] - 
       36*PolyLogTools`G[0, 0, 1 - Global`u, 1, 1] - 72*PolyLogTools`G[0, 0, 1 - Global`u, 
         1 - Global`u, 1] - 54*PolyLogTools`G[0, 0, (-1 + Global`u)/Global`u, 1, 1] - 
       12*PolyLogTools`G[0, 0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1] + 
       162*PolyLogTools`G[0, 0, Global`u, 1, 1] + 114*PolyLogTools`G[0, 0, Global`u, Global`u, 1] + 
       12*PolyLogTools`G[0, 0, Global`u/(-1 + Global`u), 1, 1] - 
       6*PolyLogTools`G[0, 0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] + 
       6*PolyLogTools`G[0, 1, 0, 1 - Global`u, 1] - 6*PolyLogTools`G[0, 1, 0, 
         (-1 + Global`u)/Global`u, 1] + 24*PolyLogTools`G[0, 1, 0, Global`u, 1] + 
       12*PolyLogTools`G[0, 1, 0, Global`u/(-1 + Global`u), 1] + 
       6*PolyLogTools`G[0, 1, 1, (1 - Global`u)^(-1), 1] + 
       12*PolyLogTools`G[0, 1, 1, 1 - Global`u, 1] - 114*PolyLogTools`G[0, 1, 1, Global`u, 1] + 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1, 1] + 
       18*PolyLogTools`G[0, 1, 1 - Global`u, 1, 1] + 36*PolyLogTools`G[0, 1, 1 - Global`u, 
         1 - Global`u, 1] + 6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1, 1] + 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1] - 
       66*PolyLogTools`G[0, 1, Global`u, 1, 1] + 6*PolyLogTools`G[0, 1, Global`u, Global`u, 1] + 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] - 
       6*PolyLogTools`G[0, (1 - Global`u^(-2))^(-1), 0, (1 + Global`u)/((1 - Global`u^(-2))*
           Global`u), 1] + 6*PolyLogTools`G[0, (1 - Global`u^(-2))^(-1), 0, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), 1] - 
       6*PolyLogTools`G[0, (1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         ((-1 + Global`u)*(1 + Global`u))/((1 - Global`u^(-2))*Global`u^2), 1] + 
       6*PolyLogTools`G[0, (1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] - 
       6*PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1, 1] + 
       6*PolyLogTools`G[0, 1 - Global`u, 0, 1, 1] - 6*PolyLogTools`G[0, 1 - Global`u, 0, 
         1 - Global`u, 1] - 24*PolyLogTools`G[0, 1 - Global`u, 1, 1, 1] - 
       30*PolyLogTools`G[0, 1 - Global`u, 1, 1 - Global`u, 1] - 
       36*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1, 1] - 
       36*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1 - Global`u, 1] + 
       24*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 0, 1, 1] - 
       18*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1] - 
       6*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 1] - 
       96*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1, 1] + 
       60*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, (-1 + Global`u)/Global`u, 1] + 
       12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, Global`u/(-1 + Global`u), 1] + 
       42*PolyLogTools`G[0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1, 1] + 
       12*PolyLogTools`G[0, Global`u, 0, 1, 1] - 12*PolyLogTools`G[0, Global`u, 0, Global`u, 1] + 
       96*PolyLogTools`G[0, Global`u, 1, 1, 1] + 138*PolyLogTools`G[0, Global`u, 1, Global`u, 1] + 
       126*PolyLogTools`G[0, Global`u, Global`u, 1, 1] + 42*PolyLogTools`G[0, Global`u, Global`u, 
         Global`u, 1] - 18*PolyLogTools`G[0, Global`u/(-1 + Global`u), 0, 1, 1] + 
       6*PolyLogTools`G[0, Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), 0, Global`u/(-1 + Global`u), 1] - 
       18*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1, 1] - 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] + 
       18*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, Global`u/(-1 + Global`u), 1] + 
       24*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1, 1] - 
       24*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 1] + 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), ((-1 + Global`u)*(1 + Global`u))/
          ((1 - Global`u^(-2))*Global`u^2), 1] - 12*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), (-1 + Global`u^2)/
          ((1 - Global`u^(-2))*Global`u^2), 1] + 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), (-1 + Global`u^2)/
          ((1 - Global`u^(-2))*(-1 + Global`u)*Global`u), 1] + 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 - Global`u^(-2))^(-1), 0, 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] - 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 - Global`u^(-2))^(-1), 0, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), 1] + 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 - Global`u^(-2))^(-1), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), ((-1 + Global`u)*(1 + Global`u))/
          ((1 - Global`u^(-2))*Global`u^2), 1] - 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 
         (1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] + 
       12*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         0, ((-1 + Global`u)*(1 + Global`u))/((1 - Global`u^(-2))*Global`u^2), 1] - 
       12*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         0, (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] + 
       12*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         ((-1 + Global`u)*(1 + Global`u))/((1 - Global`u^(-2))*Global`u^2), 
         ((-1 + Global`u)*(1 + Global`u))/((1 - Global`u^(-2))*Global`u^2), 1] - 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         ((-1 + Global`u)*(1 + Global`u))/((1 - Global`u^(-2))*Global`u^2), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] - 
       12*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), ((-1 + Global`u)*(1 + Global`u))/
          ((1 - Global`u^(-2))*Global`u^2), 1] + 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), (1 + Global`u)/((1 - Global`u^(-2))*
           Global`u), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1] - 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (-1 + Global`u^2)/((1 - Global`u^(-2))*
           Global`u^2), 0, (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), 1] + 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (-1 + Global`u^2)/((1 - Global`u^(-2))*
           Global`u^2), 0, (-1 + Global`u^2)/((1 - Global`u^(-2))*(-1 + Global`u)*Global`u), 1] + 
       6*PolyLogTools`G[1 - Global`u, 0, 1, (1 - Global`u)^(-1), 1] - 
       18*PolyLogTools`G[1 - Global`u, 0, 1, 1 - Global`u, 1] - 
       18*PolyLogTools`G[1 - Global`u, 0, 1 - Global`u, 1, 1] + 
       6*PolyLogTools`G[1 - Global`u, 0, (1 - Global`u)/(-1 + Global`u)^2, 
         (1 - Global`u)^2/(-1 + Global`u)^2, 1] + 6*PolyLogTools`G[1 - Global`u, 1, 0, 
         (1 - Global`u)^(-1), 1] - 18*PolyLogTools`G[1 - Global`u, 1, 0, 1 - Global`u, 1] - 
       24*PolyLogTools`G[1 - Global`u, 1, 1, (1 - Global`u)^(-1), 1] - 
       12*PolyLogTools`G[1 - Global`u, 1, (1 - Global`u)^(-1), 1, 1] + 
       42*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 0, 1, 1] - 
       24*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 0, (-1 + Global`u)/Global`u, 1] - 
       18*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 0, Global`u/(-1 + Global`u), 1] - 
       138*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1, 1] + 
       60*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, (-1 + Global`u)/Global`u, 1] + 
       36*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, Global`u/(-1 + Global`u), 1] + 
       42*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1, 1] + 
       6*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 1, 1] - 
       6*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 1] - 84*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, 0, 1, 1] + 
       60*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, 0, (-1 + Global`u)/Global`u, 1] + 
       24*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, 0, Global`u/(-1 + Global`u), 1] - 
       48*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, 1, Global`u/(-1 + Global`u), 1] - 
       12*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, Global`u/(-1 + Global`u), 1, 1] + 
       12*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 1] - 6*PolyLogTools`G[(-1 + Global`u)/Global`u, 
         (-1 + Global`u)/Global`u, 0, 1, 1] + 6*PolyLogTools`G[(-1 + Global`u)/Global`u, 
         (-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 1] - 
       12*PolyLogTools`G[(-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1, 
         Global`u/(-1 + Global`u), 1] + 12*PolyLogTools`G[Global`u, 0, 1, 1, 1] + 
       6*PolyLogTools`G[Global`u, 1, 0, 1, 1] - 30*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 0, 
         1, 1] + 6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 0, (-1 + Global`u)/Global`u, 1] + 
       24*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 0, Global`u/(-1 + Global`u), 1] + 
       18*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1, 1] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, (-1 + Global`u)/Global`u, 1] - 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, Global`u/(-1 + Global`u), 1] + 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1, 1] + 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 
         (-1 + Global`u)/Global`u, 1] + 12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 
         Global`u/(-1 + Global`u), 1, 1] + 18*PolyLogTools`G[Global`u/(-1 + Global`u), 1, 0, 1, 
         1] - 6*PolyLogTools`G[Global`u/(-1 + Global`u), 1, 0, Global`u/(-1 + Global`u), 1] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1, 1] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 
         (-1 + Global`u)/Global`u, 1] + 6*PolyLogTools`G[Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 0, 1, 1] - 6*PolyLogTools`G[Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1, 
         (-1 + Global`u)/Global`u, 1] - 6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), ((-1 + Global`u)*(-1 + Global`u^2))/
          ((1 - Global`u^(-2))*Global`u^3), ((-1 + Global`u)*(-1 + Global`u^2))/
          ((1 - Global`u^(-2))*Global`u^3), 1] + 6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, 
         (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), ((-1 + Global`u)*(-1 + Global`u^2))/
          ((1 - Global`u^(-2))*Global`u^3), (-1 + Global`u^2)/((1 - Global`u^(-2))*Global`u^2), 
         1] - 6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/
          ((1 + Global`u^(-1))*Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*Global`u^2), 
         (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*Global`u), 1] - 
       6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/((1 + Global`u^(-1))*
           Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*Global`u), 
         (-1 + Global`u^2)/((1 + Global`u^(-1))*Global`u^2), 1] + 
       12*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/
          ((1 + Global`u^(-1))*Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*
           Global`u), (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*Global`u), 1] - 
       36*PolyLogTools`G[0, 0, 1, -1]*Log[2] + 5*Pi^2*Log[2]^2 + 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[2]^2 - 6*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[2]^2 + 6*PolyLogTools`G[0, 0, 1, -1]*Log[4] + (2*Pi^2*Log[(1 - Global`u)^(-1)])/3 - 
       EulerGamma*Pi^2*Log[(1 - Global`u)^(-1)] - 8*PolyLogTools`G[0, 1, -1]*
        Log[(1 - Global`u)^(-1)] - 24*EulerGamma*PolyLogTools`G[0, 1, -1]*
        Log[(1 - Global`u)^(-1)] - 4*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[(1 - Global`u)^(-1)] + 6*EulerGamma*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[(1 - Global`u)^(-1)] - 4*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(1 - Global`u)^(-1)] - 18*EulerGamma*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(1 - Global`u)^(-1)] + 36*PolyLogTools`G[-1, 0, -1, 1]*Log[(1 - Global`u)^(-1)] - 
       36*PolyLogTools`G[0, 0, 1, -1]*Log[(1 - Global`u)^(-1)] + 
       6*PolyLogTools`G[0, 0, 1, 1 - Global`u]*Log[(1 - Global`u)^(-1)] - 
       18*PolyLogTools`G[0, 0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)] - 
       48*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1]*Log[(1 - Global`u)^(-1)] + 
       12*PolyLogTools`G[0, 1, 1 - Global`u, 1]*Log[(1 - Global`u)^(-1)] + 
       18*PolyLogTools`G[0, 1, Global`u, 1]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1]*Log[(1 - Global`u)^(-1)] + 
       12*PolyLogTools`G[0, 1 - Global`u, 1, 1]*Log[(1 - Global`u)^(-1)] + 
       12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1]*Log[(1 - Global`u)^(-1)] + 
       6*PolyLogTools`G[0, Global`u, 1, 1]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[0, Global`u, Global`u, 1]*Log[(1 - Global`u)^(-1)] - 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1]*Log[(1 - Global`u)^(-1)] + 
       18*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1]*
        Log[(1 - Global`u)^(-1)] - 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1]*Log[(1 - Global`u)^(-1)] + 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, (-1 + Global`u^2)/((1 - Global`u^(-2))*
           Global`u^2), 1]*Log[(1 - Global`u)^(-1)] - 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), ((-1 + Global`u)*(1 + Global`u))/
          ((1 - Global`u^(-2))*Global`u^2), 1]*Log[(1 - Global`u)^(-1)] + 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1]*Log[(1 - Global`u)^(-1)] - 
       6*PolyLogTools`G[Global`u, 0, 1, 1]*Log[(1 - Global`u)^(-1)] + 
       12*PolyLogTools`G[Global`u, 0, Global`u, 1]*Log[(1 - Global`u)^(-1)] - 
       36*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1]*Log[(1 - Global`u)^(-1)] + 
       24*PolyLogTools`G[Global`u/(-1 + Global`u), 0, Global`u/(-1 + Global`u), 1]*
        Log[(1 - Global`u)^(-1)] - 24*PolyLogTools`G[0, 1, -1]*Log[2]*Log[(1 - Global`u)^(-1)] - 
       5*Pi^2*Log[(1 - Global`u)^(-1)]^2 + 12*PolyLogTools`G[-1, -1, 1]*
        Log[(1 - Global`u)^(-1)]^2 + 54*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)]^2 + 
       3*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)]^2 + 
       3*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[(1 - Global`u)^(-1)]^2 - 
       6*Log[2]^2*Log[(1 - Global`u)^(-1)]^2 - 4*EulerGamma*Log[(1 - Global`u)^(-1)]^3 + 
       (5*Log[(1 - Global`u)^(-1)]^4)/2 - (4*Pi^2*Log[1 - Global`u])/3 - 
       2*EulerGamma*Pi^2*Log[1 - Global`u] - 24*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[1 - Global`u] + 18*PolyLogTools`G[-1, 0, -1, 1]*Log[1 - Global`u] - 
       18*PolyLogTools`G[0, 0, 1, -1]*Log[1 - Global`u] - 
       12*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u] - 
       204*PolyLogTools`G[0, 0, 1, Global`u^(-1)]*Log[1 - Global`u] - 
       24*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] - 
       6*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)]*Log[1 - Global`u] + 
       6*PolyLogTools`G[0, 1, 1 - Global`u, 1]*Log[1 - Global`u] + 
       108*PolyLogTools`G[0, 1, Global`u, 1]*Log[1 - Global`u] + 
       6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1]*Log[1 - Global`u] - 
       6*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1]*Log[1 - Global`u] + 
       24*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1]*Log[1 - Global`u] + 
       6*PolyLogTools`G[0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1]*
        Log[1 - Global`u] - 96*PolyLogTools`G[0, Global`u, 1, 1]*Log[1 - Global`u] - 
       108*PolyLogTools`G[0, Global`u, Global`u, 1]*Log[1 - Global`u] - 
       18*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1]*Log[1 - Global`u] + 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1]*
        Log[1 - Global`u] + 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1]*Log[1 - Global`u] - 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 0, (-1 + Global`u^2)/((1 - Global`u^(-2))*
           Global`u^2), 1]*Log[1 - Global`u] + 6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), ((-1 + Global`u)*(1 + Global`u))/
          ((1 - Global`u^(-2))*Global`u^2), 1]*Log[1 - Global`u] - 
       6*PolyLogTools`G[(1 - Global`u^(-2))^(-1), (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 
         (1 + Global`u)/((1 - Global`u^(-2))*Global`u), 1]*Log[1 - Global`u] - 
       12*PolyLogTools`G[Global`u, 0, 1, 1]*Log[1 - Global`u] + 
       12*PolyLogTools`G[Global`u, 0, Global`u, 1]*Log[1 - Global`u] - 
       24*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1]*Log[1 - Global`u] + 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1]*
        Log[1 - Global`u] + 18*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 
         Global`u/(-1 + Global`u), 1]*Log[1 - Global`u] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1]*
        Log[1 - Global`u] + 6*PolyLogTools`G[0, 1, -1]*Log[2]*Log[1 - Global`u] - 
       6*Pi^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] - 12*PolyLogTools`G[-1, -1, 1]*
        Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 36*PolyLogTools`G[0, 1, -1]*
        Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)]*
        Log[1 - Global`u] + 6*Log[2]^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 
       64*Log[1 - Global`u]^2 - (7*Pi^2*Log[1 - Global`u]^2)/2 + 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u]^2 + 
       60*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u]^2 - 2*Log[1 - Global`u]^3 + 
       (7*Log[1 - Global`u]^4)/4 - 6*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)]*
        Log[-4/(-1 + Global`u)] + 8*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)] - 
       24*EulerGamma*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)] - 
       24*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u]*Log[-2/(-1 + Global`u)] - 
       Pi^2*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)] - 24*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)] - 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)] - (Pi^2*Log[(-1 + Global`u)^(-1)]^2)/2 - 
       12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(-1 + Global`u)^(-1)]^2 - 
       3*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)^(-1)]^2 + 
       3*Pi^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] + 
       12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)]*
        Log[-1 + Global`u] + (3*Pi^2*Log[-1 + Global`u]^2)/2 + 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[-1 + Global`u]^2 - 
       Pi^2*Log[-Global`u^(-1)]^2 + 12*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[-Global`u^(-1)]^2 + 3*PolyLogTools`G[0, 1, 1 - Global`u]*Log[-Global`u^(-1)]^2 - 
       3*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[-Global`u^(-1)]^2 - 
       2*Pi^2*Log[Global`u^(-1)] + 5*EulerGamma*Pi^2*Log[Global`u^(-1)] + 
       8*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)] - 4*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[Global`u^(-1)] - 6*EulerGamma*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)] + 
       18*EulerGamma*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)] + 
       9*PolyLogTools`G[-1, 0, -1, 1]*Log[Global`u^(-1)] - 9*PolyLogTools`G[0, 0, 1, -1]*
        Log[Global`u^(-1)] + 24*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 
       18*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)] - 
       6*PolyLogTools`G[0, 1, 1 - Global`u, 1]*Log[Global`u^(-1)] - 
       6*PolyLogTools`G[0, 1, Global`u, 1]*Log[Global`u^(-1)] - 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1]*Log[Global`u^(-1)] + 
       24*PolyLogTools`G[0, 1 - Global`u, 1, 1]*Log[Global`u^(-1)] + 
       36*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1]*Log[Global`u^(-1)] - 
       6*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1]*Log[Global`u^(-1)] - 
       12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1]*
        Log[Global`u^(-1)] - 6*PolyLogTools`G[0, Global`u, 1, 1]*Log[Global`u^(-1)] + 
       6*PolyLogTools`G[0, Global`u, Global`u, 1]*Log[Global`u^(-1)] - 
       12*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1]*Log[Global`u^(-1)] - 
       30*PolyLogTools`G[1 - Global`u, 0, 1, 1]*Log[Global`u^(-1)] + 
       30*PolyLogTools`G[1 - Global`u, 0, 1 - Global`u, 1]*Log[Global`u^(-1)] + 
       12*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1]*Log[Global`u^(-1)] - 
       12*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1]*
        Log[Global`u^(-1)] + 6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, 
         (-1 + Global`u^2)/((1 + Global`u^(-1))*Global`u^2), (-1 + Global`u^2)/
          ((1 + Global`u^(-1))*Global`u^2), 1]*Log[Global`u^(-1)] - 
       6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/((1 + Global`u^(-1))*
           Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*Global`u), 1]*
        Log[Global`u^(-1)] + 9*PolyLogTools`G[0, 1, -1]*Log[2]*Log[Global`u^(-1)] - 
       Pi^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 6*PolyLogTools`G[0, 1, 1 - Global`u]*
        Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] - 60*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 128*Log[1 - Global`u]*Log[Global`u^(-1)] - 
       (21*Pi^2*Log[1 - Global`u]*Log[Global`u^(-1)])/2 + 30*PolyLogTools`G[-1, -1, 1]*
        Log[1 - Global`u]*Log[Global`u^(-1)] - 6*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u]*
        Log[Global`u^(-1)] + 6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[Global`u^(-1)] - 12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u]*
        Log[Global`u^(-1)] + 6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[1 - Global`u]*
        Log[Global`u^(-1)] - 15*Log[2]^2*Log[1 - Global`u]*Log[Global`u^(-1)] - 
       4*Log[1 - Global`u]^2*Log[Global`u^(-1)] + 3*Log[1 - Global`u]^3*Log[Global`u^(-1)] + 
       (3*Pi^2*Log[-1 + Global`u]*Log[Global`u^(-1)])/2 - 18*PolyLogTools`G[-1, -1, 1]*
        Log[-1 + Global`u]*Log[Global`u^(-1)] - 24*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u]*
        Log[Global`u^(-1)] + 9*Log[2]^2*Log[-1 + Global`u]*Log[Global`u^(-1)] - 
       4*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 6*Log[1 - Global`u]^2*
        Log[-1 + Global`u]*Log[Global`u^(-1)] + 6*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
        Log[-1 + Global`u]*Log[Global`u^(-1)] + 3*Log[(-1 + Global`u)^(-1)]^2*Log[-1 + Global`u]*
        Log[Global`u^(-1)] + 2*Log[-1 + Global`u]^2*Log[Global`u^(-1)] + 
       6*Log[1 - Global`u]*Log[-1 + Global`u]^2*Log[Global`u^(-1)] - 
       5*Log[-1 + Global`u]^3*Log[Global`u^(-1)] - 18*PolyLogTools`G[0, 1, -1]*
        Log[2*(-1 + Global`u)]*Log[Global`u^(-1)] + Pi^2*Log[-Global`u^(-1)]*Log[Global`u^(-1)] + 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[-Global`u^(-1)]*Log[Global`u^(-1)] + 
       6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[-Global`u^(-1)]*Log[Global`u^(-1)] + 
       64*Log[Global`u^(-1)]^2 - 4*Pi^2*Log[Global`u^(-1)]^2 - 24*PolyLogTools`G[0, 1, -1]*
        Log[Global`u^(-1)]^2 + 42*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2 - 
       3*PolyLogTools`G[0, 1, 1 - Global`u]*Log[Global`u^(-1)]^2 + 
       30*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)]^2 - 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)]^2 - 
       6*Log[1 - Global`u]*Log[Global`u^(-1)]^2 + (15*Log[1 - Global`u]^2*Log[Global`u^(-1)]^2)/2 + 
       6*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)]^2 + 
       3*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)]^2 + 12*Log[1 - Global`u]*Log[-1 + Global`u]*
        Log[Global`u^(-1)]^2 - 6*Log[-1 + Global`u]^2*Log[Global`u^(-1)]^2 - 
       (10*Log[Global`u^(-1)]^3)/3 + 4*EulerGamma*Log[Global`u^(-1)]^3 + 
       9*Log[1 - Global`u]*Log[Global`u^(-1)]^3 + (9*Log[Global`u^(-1)]^4)/4 + 
       (4*Pi^2*Log[(-1 + Global`u)/Global`u])/3 + 8*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(-1 + Global`u)/Global`u] + 48*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u]*
        Log[(-1 + Global`u)/Global`u] + 12*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)]*
        Log[(-1 + Global`u)/Global`u] + 24*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1]*
        Log[(-1 + Global`u)/Global`u] + 12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1]*
        Log[(-1 + Global`u)/Global`u] + 72*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1]*
        Log[(-1 + Global`u)/Global`u] - 36*PolyLogTools`G[0, Global`u/(-1 + Global`u), 
         Global`u/(-1 + Global`u), 1]*Log[(-1 + Global`u)/Global`u] + 
       Pi^2*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] - 36*PolyLogTools`G[0, 1, -1]*
        Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] - 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] - 3*Log[(1 - Global`u)^(-1)]^3*
        Log[(-1 + Global`u)/Global`u] + 128*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 
       13*Pi^2*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 12*PolyLogTools`G[-1, -1, 1]*
        Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + 12*PolyLogTools`G[0, 1, -1]*
        Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 
       18*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] - 6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + 6*Log[2]^2*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] - 8*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u] + 
       12*Log[1 - Global`u]^3*Log[(-1 + Global`u)/Global`u] + 4*Pi^2*Log[(-1 + Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 16*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 48*Log[1 - Global`u]^2*Log[(-1 + Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 8*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] - 18*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] + 4*Log[(-1 + Global`u)^(-1)]^3*
        Log[(-1 + Global`u)/Global`u] - 40*Pi^2*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u] - 
       48*PolyLogTools`G[-1, -1, 1]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u] + 
       24*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u] - 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 24*Log[2]^2*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 8*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 6*Log[(1 - Global`u)^(-1)]^2*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 24*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u] + 72*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u] + 
       6*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 33*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 4*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] + 
       3*EulerGamma*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] - 
       12*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] + 
       12*Log[1 - Global`u]*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] - 
       2*Log[Global`u^(-1)]^3*Log[(-1 + Global`u)/Global`u] - 64*Log[(-1 + Global`u)/Global`u]^2 + 
       7*Pi^2*Log[(-1 + Global`u)/Global`u]^2 + 6*PolyLogTools`G[-1, -1, 1]*
        Log[(-1 + Global`u)/Global`u]^2 - 12*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)/Global`u]^
         2 - 3*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       51*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)/Global`u]^2 + 
       3*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[(-1 + Global`u)/Global`u]^2 - 
       3*Log[2]^2*Log[(-1 + Global`u)/Global`u]^2 - (3*Log[(1 - Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u]^2)/2 + 18*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^
         2 - 6*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2 - 
       48*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u]^2 + 39*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       (39*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u]^2)/2 - 
       3*EulerGamma*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       54*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       3*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2 - 
       27*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u]^2 - 
       (20*Log[(-1 + Global`u)/Global`u]^3)/3 + 3*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u]^3 + 56*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^3 - 
       Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^3 - (69*Log[(-1 + Global`u)/Global`u]^4)/
        4 - 2*Pi^2*Log[Global`u^(-1)]*Log[-Global`u] - 6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[Global`u^(-1)]*Log[-Global`u] - 12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[Global`u^(-1)]*Log[-Global`u] - 3*Pi^2*Log[-Global`u]^2 - 
       3*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[-Global`u]^2 - 
       3*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[-Global`u]^2 - 
       27*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[-Global`u]^2 + 
       3*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*Log[-Global`u]^2 + 
       (3*Log[(-1 + Global`u)/Global`u]^2*Log[-Global`u]^2)/2 + 960*Log[Global`u] - 
       (28*Pi^2*Log[Global`u])/3 + 2*EulerGamma*Pi^2*Log[Global`u] - 
       8*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] + 
       8*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
       8*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] + 
       12*PolyLogTools`G[-1, 0, -1, 1]*Log[Global`u] - 12*PolyLogTools`G[0, 0, 1, -1]*
        Log[Global`u] + 12*PolyLogTools`G[0, 0, 1, 1 - Global`u]*Log[Global`u] - 
       78*PolyLogTools`G[0, 0, 1, Global`u^(-1)]*Log[Global`u] - 
       18*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
       12*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] - 
       6*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1]*Log[Global`u] + 
       18*PolyLogTools`G[0, 1, 1 - Global`u, 1]*Log[Global`u] + 
       6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1]*Log[Global`u] + 
       6*PolyLogTools`G[0, 1, Global`u, 1]*Log[Global`u] + 
       18*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1]*Log[Global`u] + 
       6*PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1]*Log[Global`u] + 
       24*PolyLogTools`G[0, 1 - Global`u, 1, 1]*Log[Global`u] + 
       30*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1]*Log[Global`u] + 
       12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1]*Log[Global`u] + 
       42*PolyLogTools`G[0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1]*Log[Global`u] - 
       72*PolyLogTools`G[0, Global`u, 1, 1]*Log[Global`u] - 
       36*PolyLogTools`G[0, Global`u, Global`u, 1]*Log[Global`u] - 
       6*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1]*Log[Global`u] - 
       18*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1]*Log[Global`u] - 
       30*PolyLogTools`G[1 - Global`u, 0, 1, 1]*Log[Global`u] + 
       48*PolyLogTools`G[1 - Global`u, 0, 1 - Global`u, 1]*Log[Global`u] - 
       6*PolyLogTools`G[1 - Global`u, 0, (1 - Global`u)/(-1 + Global`u)^2, 1]*Log[Global`u] + 
       12*PolyLogTools`G[1 - Global`u, 1, (1 - Global`u)^(-1), 1]*Log[Global`u] - 
       42*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1]*Log[Global`u] + 
       42*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1]*Log[Global`u] - 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1]*Log[Global`u] + 
       6*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1]*Log[Global`u] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1]*Log[Global`u] - 
       6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/((1 + Global`u^(-1))*
           Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*Global`u^2), 1]*Log[Global`u] + 
       6*PolyLogTools`G[(-1 + Global`u^2)/Global`u^2, (-1 + Global`u^2)/((1 + Global`u^(-1))*
           Global`u^2), (-1 + Global`u^2)/((1 + Global`u^(-1))*(-1 + Global`u)*Global`u), 1]*
        Log[Global`u] - 2*Pi^2*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
       12*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
       18*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
       18*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
       5*Pi^2*Log[1 - Global`u]*Log[Global`u] + 72*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[1 - Global`u]*Log[Global`u] + 36*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[1 - Global`u]*Log[Global`u] - 4*Log[1 - Global`u]^2*Log[Global`u] + 
       6*Log[1 - Global`u]^3*Log[Global`u] - 12*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)]*
        Log[Global`u] - 4*Pi^2*Log[-Global`u^(-1)]*Log[Global`u] + 12*PolyLogTools`G[-1, -1, 1]*
        Log[-Global`u^(-1)]*Log[Global`u] - 12*PolyLogTools`G[0, 1, -1]*Log[-Global`u^(-1)]*
        Log[Global`u] + 30*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[-Global`u^(-1)]*
        Log[Global`u] + 6*PolyLogTools`G[0, 1, 1 - Global`u]*Log[-Global`u^(-1)]*Log[Global`u] - 
       6*Log[2]^2*Log[-Global`u^(-1)]*Log[Global`u] + 3*Log[(1 - Global`u)^(-1)]*
        Log[-Global`u^(-1)]^2*Log[Global`u] - 4*Log[-Global`u^(-1)]^3*Log[Global`u] + 
       2*Pi^2*Log[Global`u^(-1)]*Log[Global`u] - 24*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)]*
        Log[Global`u] + 30*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[Global`u] - 8*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] + 
       12*Log[1 - Global`u]^2*Log[Global`u^(-1)]*Log[Global`u] + 12*Log[1 - Global`u]*
        Log[-1 + Global`u]*Log[Global`u^(-1)]*Log[Global`u] - 6*Log[-1 + Global`u]^2*
        Log[Global`u^(-1)]*Log[Global`u] - 4*Log[Global`u^(-1)]^2*Log[Global`u] + 
       3*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2*Log[Global`u] + 
       18*Log[1 - Global`u]*Log[Global`u^(-1)]^2*Log[Global`u] + 6*Log[Global`u^(-1)]^3*
        Log[Global`u] - 4*Pi^2*Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 
       24*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 
       30*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u] + 6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 6*Log[(1 - Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 8*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 24*Log[1 - Global`u]^2*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 48*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 
       24*Log[(-1 + Global`u)^(-1)]^2*Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 
       24*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 
       12*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 
       4*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] - 54*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] + 19*Log[(-1 + Global`u)/Global`u]^3*
        Log[Global`u] + 4*Pi^2*Log[-Global`u]*Log[Global`u] + 6*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[-Global`u]*Log[Global`u] + 42*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[-Global`u]*Log[Global`u] - 6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[-Global`u]*Log[Global`u] - 3*Log[(-1 + Global`u)/Global`u]^2*Log[-Global`u]*
        Log[Global`u] - 128*Log[Global`u]^2 + (21*Pi^2*Log[Global`u]^2)/2 + 
       3*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u]^2 + 
       12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u]^2 - 
       12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u]^2 + 
       9*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u]^2 + 
       6*Log[1 - Global`u]^2*Log[Global`u]^2 + 6*Log[(1 - Global`u)^(-1)]*Log[-Global`u^(-1)]*
        Log[Global`u]^2 - 9*Log[-Global`u^(-1)]^2*Log[Global`u]^2 + 
       12*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u]^2 + 6*Log[Global`u^(-1)]^2*
        Log[Global`u]^2 - 3*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u]^2 + 12*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*Log[Global`u]^2 - 
       6*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u]^2 + (8*Log[Global`u]^3)/3 + 
       2*Log[(1 - Global`u)^(-1)]*Log[Global`u]^3 - 6*Log[-Global`u^(-1)]*Log[Global`u]^3 - 
       (7*Log[Global`u]^4)/2 - 6*Pi^2*Log[Global`u/(-1 + Global`u)] + 
       EulerGamma*Pi^2*Log[Global`u/(-1 + Global`u)] + 8*PolyLogTools`G[0, 1, -1]*
        Log[Global`u/(-1 + Global`u)] - 12*EulerGamma*PolyLogTools`G[0, 1, -1]*
        Log[Global`u/(-1 + Global`u)] + 24*PolyLogTools`G[0, 0, 1, Global`u^(-1)]*
        Log[Global`u/(-1 + Global`u)] + 24*PolyLogTools`G[0, Global`u, 1, 1]*
        Log[Global`u/(-1 + Global`u)] - 24*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u^(-1)]*
        Log[Global`u/(-1 + Global`u)] - 2*Log[-1 + Global`u^(-1)]^3*Log[Global`u/(-1 + Global`u)] - 
       2*Pi^2*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)] + 
       12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)]*
        Log[Global`u/(-1 + Global`u)] - 6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)] - 6*Log[-1 + Global`u^(-1)]^2*
        Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)] + 2*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 3*EulerGamma*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 6*Log[-1 + Global`u^(-1)]*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 12*PolyLogTools`G[-1, -1, 1]*Log[1 - Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*
        Log[1 - Global`u]*Log[Global`u/(-1 + Global`u)] + 6*Log[2]^2*Log[1 - Global`u]*
        Log[Global`u/(-1 + Global`u)] - 3*Log[(1 - Global`u)^(-1)]^2*Log[1 - Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*Pi^2*Log[-Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] - 
       2*Log[-Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)] + 6*Log[-1 + Global`u^(-1)]*
        Log[-Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)] - 9*Log[-Global`u^(-1)]^3*
        Log[Global`u/(-1 + Global`u)] - 14*Pi^2*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] - 
       12*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] - 
       3*Log[1 - Global`u]^2*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] + 
       4*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] + 
       15*Log[-Global`u^(-1)]^2*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)] - 
       12*Log[1 - Global`u]*Log[Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)] - 
       24*Log[-Global`u^(-1)]*Log[Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)] - 
       12*Log[Global`u^(-1)]^3*Log[Global`u/(-1 + Global`u)] - 4*Pi^2*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u/(-1 + Global`u)] + 
       6*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2*
        Log[Global`u/(-1 + Global`u)] - 3*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2*
        Log[Global`u/(-1 + Global`u)] - 4*Log[(-1 + Global`u)/Global`u]^3*
        Log[Global`u/(-1 + Global`u)] + 6*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*Log[-Global`u]*
        Log[Global`u/(-1 + Global`u)] + 3*Log[-Global`u^(-1)]*Log[-Global`u]^2*
        Log[Global`u/(-1 + Global`u)] - 128*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 
       9*Pi^2*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 12*PolyLogTools`G[-1, -1, 1]*
        Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 24*PolyLogTools`G[0, 1, -1]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 6*Log[2]^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 6*Log[-1 + Global`u^(-1)]^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 12*Log[-1 + Global`u^(-1)]*Log[(1 - Global`u)^(-1)]*
        Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 3*Log[(1 - Global`u)^(-1)]^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] + 6*Log[1 - Global`u]^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] + 12*Log[-1 + Global`u^(-1)]*Log[-Global`u^(-1)]*
        Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 3*Log[-Global`u^(-1)]^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 30*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] + 12*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 6*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 
       3*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u]*Log[Global`u/(-1 + Global`u)] + 
       4*Log[Global`u]^2*Log[Global`u/(-1 + Global`u)] - 3*Log[Global`u]^3*
        Log[Global`u/(-1 + Global`u)] + 64*Log[Global`u/(-1 + Global`u)]^2 + 
       5*Pi^2*Log[Global`u/(-1 + Global`u)]^2 - 12*PolyLogTools`G[0, 1, -1]*
        Log[Global`u/(-1 + Global`u)]^2 + 3*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[Global`u/(-1 + Global`u)]^2 + 3*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 - 2*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^
         2 + 3*EulerGamma*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^2 - 
       3*Log[(1 - Global`u)^(-1)]^2*Log[Global`u/(-1 + Global`u)]^2 + 
       3*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[Global`u/(-1 + Global`u)]^2 - 
       3*Log[1 - Global`u]^2*Log[Global`u/(-1 + Global`u)]^2 - 
       (9*Log[-Global`u^(-1)]^2*Log[Global`u/(-1 + Global`u)]^2)/2 + 
       4*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)]^2 - 3*Log[1 - Global`u]*
        Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)]^2 - 39*Log[Global`u^(-1)]^2*
        Log[Global`u/(-1 + Global`u)]^2 - 6*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 - (3*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u/(-1 + Global`u)]^2)/2 + 6*Log[Global`u^(-1)]*Log[-Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 + 3*Log[-Global`u]^2*Log[Global`u/(-1 + Global`u)]^2 + 
       6*Log[Global`u]*Log[Global`u/(-1 + Global`u)]^2 - 9*Log[-Global`u^(-1)]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 - 36*Log[Global`u^(-1)]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)]^2 - (21*Log[Global`u]^2*Log[Global`u/(-1 + Global`u)]^2)/2 - 
       (10*Log[Global`u/(-1 + Global`u)]^3)/3 - 18*Log[Global`u^(-1)]*Log[Global`u/(-1 + Global`u)]^
         3 - 23*Log[Global`u]*Log[Global`u/(-1 + Global`u)]^3 + 
       (37*Log[Global`u/(-1 + Global`u)]^4)/4 + (832*Zeta[3])/3 + 24*EulerGamma*Zeta[3] + 
       18*Log[(1 - Global`u)^(-1)]*Zeta[3] - 60*Log[1 - Global`u]*Zeta[3] + 
       33*Log[Global`u^(-1)]*Zeta[3] + 12*Log[(-1 + Global`u)/Global`u]*Zeta[3] - 
       790*Log[Global`u]*Zeta[3] + 24*Log[Global`u/(-1 + Global`u)]*Zeta[3])/Global`\[Epsilon], 
   "Validation" -> <|"AllDistinctSourceKernelsChecked" -> True, "TwoParameterValues" -> {1/3, 2/3}, 
     "PoleChambersPreserved" -> True, "ExactCoefficientAtoms" -> True, "SourceKernelCount" -> 77, 
     "CheckManifest" -> "family_source_check_status.json"|>, "Complete" -> True, 
   "Source" -> "differential_u_20260920/campaign/MB12u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB13u" -> <|"Route" -> "Standard", "Orders" -> {-6, -3}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> -2, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-6 -> 3/Global`u, -5 -> -22/Global`u - (12*Log[Global`u])/Global`u, 
     -4 -> 48/Global`u - (9*Pi^2)/(2*Global`u) + (12*PolyLogTools`G[0, 1, -1])/Global`u - 
       (3*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u + 
       (3*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/Global`u - 
       (6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)])/Global`u + (3*Log[(1 - Global`u)^(-1)]^2)/
        Global`u - (9*Log[1 - Global`u]^2)/(2*Global`u) - (3*Log[1 - Global`u]*Log[Global`u^(-1)])/
        Global`u - (3*Log[Global`u^(-1)]^2)/(2*Global`u) - 
       (3*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (3*Log[(-1 + Global`u)/Global`u]^2)/(2*Global`u) + (88*Log[Global`u])/Global`u + 
       (6*Log[(1 - Global`u)^(-1)]*Log[Global`u])/Global`u + (24*Log[Global`u]^2)/Global`u, 
     -3 -> -32/Global`u + (33*Pi^2)/Global`u + (6*PolyLogTools`G[(1 - Global`u)^(-1), 1]*
         PolyLogTools`G[1 - Global`u, 1]*PolyLogTools`G[-((1 - Global`u)/Global`u), 1])/Global`u - 
       (88*PolyLogTools`G[0, 1, -1])/Global`u + (22*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u - 
       (22*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/Global`u + 
       (44*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)])/Global`u + 
       (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[0, 
          (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[0, 
          (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u - 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), 1]*PolyLogTools`G[0, 1 - Global`u, 1])/Global`u - 
       (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[0, 1 - Global`u, 1])/
        Global`u - (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*
         PolyLogTools`G[(1 - Global`u)^(-1), (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u - 
       (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[(1 - Global`u)^(-1), 
          (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u - 
       (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[1 - Global`u, 1, 1])/
        Global`u - (6*PolyLogTools`G[-1, 0, -1, 1])/Global`u - 
       (6*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), -1, 1])/Global`u - 
       (6*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), 1, 1])/Global`u + 
       (6*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), -((2 - Global`u)/Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), (2 - Global`u)/Global`u, 1])/Global`u - 
       (6*PolyLogTools`G[-1, (2 - Global`u)/Global`u, -1, 1])/Global`u - 
       (6*PolyLogTools`G[-1, (2 - Global`u)/Global`u, 1, 1])/Global`u + 
       (6*PolyLogTools`G[-1, (2 - Global`u)/Global`u, -((2 - Global`u)/Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[-1, (2 - Global`u)/Global`u, (2 - Global`u)/Global`u, 1])/Global`u + 
       (6*PolyLogTools`G[0, 0, 1, -1])/Global`u - 
       (24*PolyLogTools`G[0, 0, 1, (1 - Sqrt[(4 - 3*Global`u)/Global`u])/2])/Global`u + 
       (24*PolyLogTools`G[0, 0, 1, -1/2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2/
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])])/Global`u - 
       (24*PolyLogTools`G[0, 0, 1, (1 + Sqrt[(4 - 3*Global`u)/Global`u])/2])/Global`u - 
       (24*PolyLogTools`G[0, 0, 1, -1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))])/Global`u + 
       (24*PolyLogTools`G[0, 0, 1, (1 + Sqrt[(4 - 3*Global`u)/Global`u])^2/
           (2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))])/Global`u + 
       (24*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/(-2 + Global`u)])/Global`u + 
       (3*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/Global`u + 
       (18*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/Global`u - 
       (30*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)])/Global`u + 
       (12*PolyLogTools`G[0, 0, 1, (-2*(-1 + Global`u)^2)/(3*Global`u - 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])])/Global`u + 
       (12*PolyLogTools`G[0, 0, 1, (2*(-1 + Global`u)^2)/(-3*Global`u + 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])])/Global`u - 
       (12*PolyLogTools`G[0, 0, (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u - 
       (12*PolyLogTools`G[0, 0, (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (12*PolyLogTools`G[0, 0, 1 - Global`u, 1])/Global`u + 
       (12*PolyLogTools`G[0, 1, -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/Global`u - 
       (12*PolyLogTools`G[0, 1, Global`u^(-1), 1])/Global`u + 
       (6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1])/Global`u + 
       (12*PolyLogTools`G[0, 1, -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[0, 1, 1/Sqrt[Global`u], 1])/Global`u - 
       (3*PolyLogTools`G[0, 1, Global`u, 1])/Global`u - 
       (9*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/Global`u - 
       (6*PolyLogTools`G[0, (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1, 1])/Global`u + 
       (6*PolyLogTools`G[0, (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), (1 - Global`u)^(-1), 1])/Global`u - 
       (6*PolyLogTools`G[0, (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1, 1])/Global`u + 
       (6*PolyLogTools`G[0, (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), (1 - Global`u)^(-1), 1])/Global`u - 
       (12*PolyLogTools`G[0, -2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1])/Global`u - 
       (12*PolyLogTools`G[0, -2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u + (12*PolyLogTools`G[0, (2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (1 + Sqrt[(4 - 3*Global`u)/Global`u])^2, 1, 1])/Global`u - 
       (12*PolyLogTools`G[0, 2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1])/Global`u - 
       (12*PolyLogTools`G[0, 2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u - (12*PolyLogTools`G[0, -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1, 1])/Global`u + 
       (12*PolyLogTools`G[0, -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), -2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1])/
        Global`u + (12*PolyLogTools`G[0, -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1])/
        Global`u + (12*PolyLogTools`G[0, (-2*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2, 1, 1])/Global`u - 
       (6*PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1])/Global`u + 
       (6*PolyLogTools`G[0, (1 - Global`u)^(-1), (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (6*PolyLogTools`G[0, (1 - Global`u)^(-1), (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (6*PolyLogTools`G[0, 1 - Global`u, 1, 1])/Global`u + 
       (24*PolyLogTools`G[0, (-2 + Global`u)/(-1 + Global`u), 1, 1])/Global`u - 
       (12*PolyLogTools`G[0, Global`u^(-1), 1, 1])/Global`u - 
       (24*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1])/Global`u - 
       (6*PolyLogTools`G[0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1])/Global`u + 
       (12*PolyLogTools`G[0, -(1/Sqrt[Global`u]), 1, 1])/Global`u + 
       (12*PolyLogTools`G[0, 1/Sqrt[Global`u], 1, 1])/Global`u + 
       (3*PolyLogTools`G[0, Global`u, Global`u, 1])/Global`u + 
       (33*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/Global`u + 
       (3*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[0, -1/2*(3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-1 + Global`u)^2, 1, 1])/Global`u + 
       (6*PolyLogTools`G[0, -1/2*(3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-1 + Global`u)^2, -1/2*(2*Global`u - 2*Global`u^2)/(-1 + Global`u)^2, 1])/Global`u + 
       (6*PolyLogTools`G[0, (-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (2*(-1 + Global`u)^2), 1, 1])/Global`u + 
       (6*PolyLogTools`G[0, (-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (2*(-1 + Global`u)^2), Global`u/(-1 + Global`u), 1])/Global`u - 
       (12*PolyLogTools`G[-2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u - (12*PolyLogTools`G[-2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1, 1])/
        Global`u - (12*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u - (12*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1, 1])/
        Global`u - (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 0, 1, 1])/Global`u + 
       (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 0, -2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          1])/Global`u + (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 0, 2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1])/
        Global`u + (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), -2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u + (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), (2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (1 + Sqrt[(4 - 3*Global`u)/Global`u])^2, 1, 1])/Global`u + 
       (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u + (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), (-2*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2, 1, 1])/Global`u - 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), 0, 1, 1])/Global`u + 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), 0, (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), 0, (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1, 1])/Global`u - 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), (1 - Global`u)^(-1), 1])/Global`u + 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1, 1])/Global`u - 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), (1 - Global`u)^(-1), 1])/Global`u - 
       (12*PolyLogTools`G[Global`u^(-1), 0, 1, 1])/Global`u - 
       (12*PolyLogTools`G[Global`u^(-1), 1, 0, 1])/Global`u - 
       (12*PolyLogTools`G[Global`u^(-1), 1, 1, 1])/Global`u + 
       (12*PolyLogTools`G[Global`u^(-1), 1, -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[Global`u^(-1), 1, 1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[Global`u^(-1), -(1/Sqrt[Global`u]), 1, 1])/Global`u + 
       (12*PolyLogTools`G[Global`u^(-1), 1/Sqrt[Global`u], 1, 1])/Global`u - 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), -1, 1, 1])/Global`u - 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, -1, 1])/Global`u - 
       (12*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, 1, 1])/Global`u + 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, -((2 - Global`u)/Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, (2 - Global`u)/Global`u, 1])/Global`u + 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), -((2 - Global`u)/Global`u), 1, 1])/Global`u + 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), (2 - Global`u)/Global`u, 1, 1])/Global`u - 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, -1, 1, 1])/Global`u - 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, 1, -1, 1])/Global`u - 
       (12*PolyLogTools`G[(2 - Global`u)/Global`u, 1, 1, 1])/Global`u + 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, 1, -((2 - Global`u)/Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, 1, (2 - Global`u)/Global`u, 1])/Global`u + 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, -((2 - Global`u)/Global`u), 1, 1])/Global`u + 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, (2 - Global`u)/Global`u, 1, 1])/Global`u + 
       (12*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1])/Global`u - 
       (6*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 1])/Global`u + 
       (12*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, Global`u/(-1 + Global`u), 1])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), 0, 1, 1])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 0, 1])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1, 1])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), Global`u^(-1), 1, 1])/Global`u - 
       (24*PolyLogTools`G[-(1/Sqrt[Global`u]), -(1/Sqrt[Global`u]), 1, 1])/Global`u - 
       (24*PolyLogTools`G[-(1/Sqrt[Global`u]), 1/Sqrt[Global`u], 1, 1])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], 0, 1, 1])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], 1, 0, 1])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], 1, 1, 1])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], 1, Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[1/Sqrt[Global`u], 1, -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[1/Sqrt[Global`u], 1, 1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], Global`u^(-1), 1, 1])/Global`u - 
       (24*PolyLogTools`G[1/Sqrt[Global`u], -(1/Sqrt[Global`u]), 1, 1])/Global`u - 
       (24*PolyLogTools`G[1/Sqrt[Global`u], 1/Sqrt[Global`u], 1, 1])/Global`u - 
       (12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1])/Global`u + 
       (12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, Global`u/(-1 + Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[Global`u/(-1 + Global`u), -1/2*(3*Global`u - 2*Global`u^2 + 
             Sqrt[-(Global`u*(-4 + 3*Global`u))])/(-1 + Global`u)^2, 1, 1])/Global`u - 
       (6*PolyLogTools`G[Global`u/(-1 + Global`u), -1/2*(3*Global`u - 2*Global`u^2 + 
             Sqrt[-(Global`u*(-4 + 3*Global`u))])/(-1 + Global`u)^2, 
          -1/2*(2*Global`u - 2*Global`u^2)/(-1 + Global`u)^2, 1])/Global`u + 
       (6*PolyLogTools`G[Global`u/(-1 + Global`u), (-3*Global`u + 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])/(2*(-1 + Global`u)^2), 1, 1])/Global`u - 
       (6*PolyLogTools`G[Global`u/(-1 + Global`u), (-3*Global`u + 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])/(2*(-1 + Global`u)^2), Global`u/(-1 + Global`u), 
          1])/Global`u - (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          Global`u^(-1), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, -(1/Sqrt[Global`u]), 
          1])/Global`u + (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          1/Sqrt[Global`u], 1])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, Global`u^(-1), 1])/
        Global`u + (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
          -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, 1/Sqrt[Global`u], 1])/
        Global`u - (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          Global`u^(-1), 0, 1])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1, 1])/
        Global`u + (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          Global`u^(-1), -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 0, 
          1])/Global`u + (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 1, 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 0, 1])/
        Global`u + (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], 1, 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          1/Sqrt[Global`u], 1])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, Global`u^(-1), 1])/
        Global`u + (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 1/Sqrt[Global`u], 1])/
        Global`u - (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
          Global`u^(-1), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, -(1/Sqrt[Global`u]), 
          1])/Global`u + (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
          1/Sqrt[Global`u], 1])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 0, 1])/
        Global`u - (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          Global`u^(-1), 1, 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 0, 
          1])/Global`u + (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 1, 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 0, 1])/
        Global`u + (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], 1, 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          1/Sqrt[Global`u], 1])/Global`u + 
       (6*PolyLogTools`G[-1/2*(3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-1 + Global`u)^2, 1, Global`u/(-1 + Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[-1/2*(3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-1 + Global`u)^2, -1/2*(2*Global`u - 2*Global`u^2)/(-1 + Global`u)^2, 
          -1/2*(2*Global`u - 2*Global`u^2)/((-1 + Global`u)*Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[(-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (2*(-1 + Global`u)^2), 1, Global`u/(-1 + Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[(-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (2*(-1 + Global`u)^2), Global`u/(-1 + Global`u), 1, 1])/Global`u + 
       (Pi^2*Log[2])/Global`u - (6*PolyLogTools`G[0, 1, -1]*Log[2])/Global`u + 
       (2*Pi^2*Log[4])/Global`u - (24*PolyLogTools`G[0, 1, -1]*Log[4])/Global`u + 
       (12*PolyLogTools`G[0, 1, (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/4]*Log[4])/Global`u - 
       (4*Pi^2*Log[-1 + (1 - Sqrt[(4 - 3*Global`u)/Global`u])/2 - 
           2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u])])/Global`u - 
       (4*Log[-1 + (1 - Sqrt[(4 - 3*Global`u)/Global`u])/2 - 
            2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u])]^3)/Global`u + 
       (48*PolyLogTools`G[0, 1, -1]*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/4])/Global`u + 
       (4*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/
                 Global`u])^2)/4]^3)/Global`u - 
       (2*Pi^2*Log[4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2])/Global`u + 
       (24*PolyLogTools`G[0, 1, -1]*Log[4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2])/Global`u - 
       (12*PolyLogTools`G[0, 1, (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/4]*
         Log[4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
            2])/Global`u - (4*Pi^2*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))])/Global`u - 
       (4*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/
                 Global`u])^2)/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))]^3)/Global`u - 
       (6*Log[4]*Log[-1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/
                Global`u]))]^2)/Global`u + 
       (6*Log[4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
            2]*Log[-1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/
                Global`u]))]^2)/Global`u - 
       (4*Pi^2*Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (24*PolyLogTools`G[0, 1, -1]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (12*PolyLogTools`G[0, 1, (1 - Sqrt[(4 - 3*Global`u)/Global`u])/2]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (12*PolyLogTools`G[0, 1, -1/2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2/
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])]*Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)])/Global`u + 
       (12*PolyLogTools`G[0, 1, (1 + Sqrt[(4 - 3*Global`u)/Global`u])/2]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u - (12*PolyLogTools`G[0, 1, -1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))]*Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)])/Global`u + 
       (12*PolyLogTools`G[0, 1, (1 + Sqrt[(4 - 3*Global`u)/Global`u])^2/
           (2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (12*PolyLogTools`G[-2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (12*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u - (6*Log[-1 + (1 - Sqrt[(4 - 3*Global`u)/Global`u])/2 - 
            2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u])]^2*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (6*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
             (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/4]^2*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u - (6*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
             (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/
                 Global`u]))]^2*Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)])/Global`u + 
       (12*Log[4]*Log[-1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))]*Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)])/Global`u - 
       (12*Log[4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2]*
         Log[-1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (11*Pi^2*Log[(1 - Global`u)^(-1)])/Global`u + 
       (12*PolyLogTools`G[-1, -1, 1]*Log[(1 - Global`u)^(-1)])/Global`u + 
       (48*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)])/Global`u - 
       (6*Log[2]^2*Log[(1 - Global`u)^(-1)])/Global`u - (22*Log[(1 - Global`u)^(-1)]^2)/Global`u + 
       (6*Log[(1 - Global`u)^(-1)]^3)/Global`u + (11*Pi^2*Log[1 - Global`u])/(2*Global`u) - 
       (24*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u])/Global`u + 
       (12*PolyLogTools`G[0, 1, (-1 + Global`u)/(-2 + Global`u)]*Log[1 - Global`u])/Global`u + 
       (6*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/Global`u + 
       (12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/Global`u + 
       (6*PolyLogTools`G[0, 1, (-2*(-1 + Global`u)^2)/(3*Global`u - 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])]*Log[1 - Global`u])/Global`u + 
       (6*PolyLogTools`G[0, 1, (2*(-1 + Global`u)^2)/(-3*Global`u + 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])]*Log[1 - Global`u])/Global`u + 
       (6*PolyLogTools`G[-1/2*(3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-1 + Global`u)^2, -1/2*(2*Global`u - 2*Global`u^2)/(-1 + Global`u)^2, 1]*
         Log[1 - Global`u])/Global`u + 
       (6*PolyLogTools`G[(-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (2*(-1 + Global`u)^2), Global`u/(-1 + Global`u), 1]*Log[1 - Global`u])/Global`u + 
       (33*Log[1 - Global`u]^2)/Global`u + (13*Log[1 - Global`u]^3)/(2*Global`u) - 
       (48*PolyLogTools`G[0, 1, -1]*Log[(2 - Global`u)^(-1)])/Global`u - 
       (6*Log[1 - Global`u]*Log[(2 - Global`u)^(-1)]^2)/Global`u - (4*Log[(2 - Global`u)^(-1)]^3)/
        Global`u + (12*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), 1]*Log[2 - Global`u])/
        Global`u + (12*PolyLogTools`G[-1, (2 - Global`u)/Global`u, 1]*Log[2 - Global`u])/Global`u + 
       (12*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, 1]*Log[2 - Global`u])/Global`u + 
       (12*PolyLogTools`G[(2 - Global`u)/Global`u, 1, 1]*Log[2 - Global`u])/Global`u + 
       (12*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)])/Global`u - 
       (Pi^2*Log[Global`u^(-1)])/(2*Global`u) + (6*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/
        Global`u + (6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)])/Global`u - 
       (3*Log[(1 - Global`u)^(-1)]^2*Log[Global`u^(-1)])/Global`u + 
       (22*Log[1 - Global`u]*Log[Global`u^(-1)])/Global`u + 
       (12*Log[1 - Global`u]^2*Log[Global`u^(-1)])/Global`u - 
       (9*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/Global`u + 
       (9*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/(2*Global`u) + (11*Log[Global`u^(-1)]^2)/
        Global`u - (9*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/(2*Global`u) - 
       (11*Log[Global`u^(-1)]^3)/(2*Global`u) - (Pi^2*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (22*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (6*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/Global`u - 
       (11*Log[(-1 + Global`u)/Global`u]^2)/Global`u - 
       (3*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2)/Global`u - 
       (9*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/(2*Global`u) - 
       Log[(-1 + Global`u)/Global`u]^3/Global`u + (9*Log[(1 - Global`u)^(-1)]*Log[-Global`u]^2)/
        Global`u - (192*Log[Global`u])/Global`u + (15*Pi^2*Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[-1, -1, 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[-1, (2 - Global`u)/Global`u, 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[0, 1, -1]*Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[Global`u^(-1), 1, 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[(2 - Global`u)/Global`u, 1, 1]*Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1]*Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], 1, 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1]*
         Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1]*
         Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1]*
         Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1]*
         Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1]*
         Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1]*
         Log[Global`u])/Global`u - (6*Log[2]^2*Log[Global`u])/Global`u - 
       (44*Log[(1 - Global`u)^(-1)]*Log[Global`u])/Global`u + 
       (18*Log[1 - Global`u]^2*Log[Global`u])/Global`u + (12*Log[1 - Global`u]*Log[Global`u^(-1)]*
         Log[Global`u])/Global`u + (6*Log[Global`u^(-1)]^2*Log[Global`u])/Global`u + 
       (12*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*Log[Global`u])/Global`u - 
       (6*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u])/Global`u - 
       (18*Log[(1 - Global`u)^(-1)]*Log[-Global`u]*Log[Global`u])/Global`u - 
       (176*Log[Global`u]^2)/Global`u - (6*Log[(1 - Global`u)^(-1)]*Log[Global`u]^2)/Global`u - 
       (32*Log[Global`u]^3)/Global`u - 
       (2*Pi^2*Log[(2 - Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])])/Global`u - 
       (3*Log[1 - Global`u]*Log[(2 - Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])]^2)/Global`u - 
       (2*Log[(2 - Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/(3*Global`u - 2*Global`u^2 + 
             Sqrt[-(Global`u*(-4 + 3*Global`u))])]^3)/Global`u - 
       (2*Pi^2*Log[(-2 + Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])])/Global`u - 
       (3*Log[1 - Global`u]*Log[(-2 + Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])]^2)/Global`u - 
       (2*Log[(-2 + Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/(-3*Global`u + 2*Global`u^2 + 
             Sqrt[-(Global`u*(-4 + 3*Global`u))])]^3)/Global`u - 
       (6*Log[1 - Global`u]*PolyLog[2, 1 - Global`u])/Global`u - 
       (6*Log[2]*PolyLog[2, (4*(1 - Global`u))/(2 - Global`u)^2])/Global`u - 
       (6*Log[Global`u]*PolyLog[2, Global`u])/Global`u + (12*PolyLog[3, Global`u])/Global`u - 
       (359*Zeta[3])/Global`u|>, "Series" -> 3/(Global`u*Global`\[Epsilon]^6) + 
     (-22/Global`u - (12*Log[Global`u])/Global`u)/Global`\[Epsilon]^5 + 
     (48/Global`u - (9*Pi^2)/(2*Global`u) + (12*PolyLogTools`G[0, 1, -1])/Global`u - 
       (3*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u + 
       (3*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/Global`u - 
       (6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)])/Global`u + (3*Log[(1 - Global`u)^(-1)]^2)/
        Global`u - (9*Log[1 - Global`u]^2)/(2*Global`u) - (3*Log[1 - Global`u]*Log[Global`u^(-1)])/
        Global`u - (3*Log[Global`u^(-1)]^2)/(2*Global`u) - 
       (3*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (3*Log[(-1 + Global`u)/Global`u]^2)/(2*Global`u) + (88*Log[Global`u])/Global`u + 
       (6*Log[(1 - Global`u)^(-1)]*Log[Global`u])/Global`u + (24*Log[Global`u]^2)/Global`u)/
      Global`\[Epsilon]^4 + (-32/Global`u + (33*Pi^2)/Global`u + (6*PolyLogTools`G[(1 - Global`u)^(-1), 1]*
         PolyLogTools`G[1 - Global`u, 1]*PolyLogTools`G[-((1 - Global`u)/Global`u), 1])/Global`u - 
       (88*PolyLogTools`G[0, 1, -1])/Global`u + (22*PolyLogTools`G[0, 1, Global`u^(-1)])/Global`u - 
       (22*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u])/Global`u + 
       (44*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)])/Global`u + 
       (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[0, 
          (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[0, 
          (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u - 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), 1]*PolyLogTools`G[0, 1 - Global`u, 1])/Global`u - 
       (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[0, 1 - Global`u, 1])/
        Global`u - (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*
         PolyLogTools`G[(1 - Global`u)^(-1), (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u - 
       (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[(1 - Global`u)^(-1), 
          (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u - 
       (6*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[1 - Global`u, 1, 1])/
        Global`u - (6*PolyLogTools`G[-1, 0, -1, 1])/Global`u - 
       (6*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), -1, 1])/Global`u - 
       (6*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), 1, 1])/Global`u + 
       (6*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), -((2 - Global`u)/Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), (2 - Global`u)/Global`u, 1])/Global`u - 
       (6*PolyLogTools`G[-1, (2 - Global`u)/Global`u, -1, 1])/Global`u - 
       (6*PolyLogTools`G[-1, (2 - Global`u)/Global`u, 1, 1])/Global`u + 
       (6*PolyLogTools`G[-1, (2 - Global`u)/Global`u, -((2 - Global`u)/Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[-1, (2 - Global`u)/Global`u, (2 - Global`u)/Global`u, 1])/Global`u + 
       (6*PolyLogTools`G[0, 0, 1, -1])/Global`u - 
       (24*PolyLogTools`G[0, 0, 1, (1 - Sqrt[(4 - 3*Global`u)/Global`u])/2])/Global`u + 
       (24*PolyLogTools`G[0, 0, 1, -1/2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2/
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])])/Global`u - 
       (24*PolyLogTools`G[0, 0, 1, (1 + Sqrt[(4 - 3*Global`u)/Global`u])/2])/Global`u - 
       (24*PolyLogTools`G[0, 0, 1, -1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))])/Global`u + 
       (24*PolyLogTools`G[0, 0, 1, (1 + Sqrt[(4 - 3*Global`u)/Global`u])^2/
           (2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))])/Global`u + 
       (24*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/(-2 + Global`u)])/Global`u + 
       (3*PolyLogTools`G[0, 0, 1, Global`u^(-1)])/Global`u + 
       (18*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u])/Global`u - 
       (30*PolyLogTools`G[0, 0, 1, Global`u/(-1 + Global`u)])/Global`u + 
       (12*PolyLogTools`G[0, 0, 1, (-2*(-1 + Global`u)^2)/(3*Global`u - 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])])/Global`u + 
       (12*PolyLogTools`G[0, 0, 1, (2*(-1 + Global`u)^2)/(-3*Global`u + 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])])/Global`u - 
       (12*PolyLogTools`G[0, 0, (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u - 
       (12*PolyLogTools`G[0, 0, (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (12*PolyLogTools`G[0, 0, 1 - Global`u, 1])/Global`u + 
       (12*PolyLogTools`G[0, 1, -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/Global`u - 
       (12*PolyLogTools`G[0, 1, Global`u^(-1), 1])/Global`u + 
       (6*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1])/Global`u + 
       (12*PolyLogTools`G[0, 1, -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[0, 1, 1/Sqrt[Global`u], 1])/Global`u - 
       (3*PolyLogTools`G[0, 1, Global`u, 1])/Global`u - 
       (9*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1])/Global`u - 
       (6*PolyLogTools`G[0, (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1, 1])/Global`u + 
       (6*PolyLogTools`G[0, (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), (1 - Global`u)^(-1), 1])/Global`u - 
       (6*PolyLogTools`G[0, (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1, 1])/Global`u + 
       (6*PolyLogTools`G[0, (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), (1 - Global`u)^(-1), 1])/Global`u - 
       (12*PolyLogTools`G[0, -2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1])/Global`u - 
       (12*PolyLogTools`G[0, -2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u + (12*PolyLogTools`G[0, (2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (1 + Sqrt[(4 - 3*Global`u)/Global`u])^2, 1, 1])/Global`u - 
       (12*PolyLogTools`G[0, 2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1])/Global`u - 
       (12*PolyLogTools`G[0, 2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u - (12*PolyLogTools`G[0, -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1, 1])/Global`u + 
       (12*PolyLogTools`G[0, -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), -2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1])/
        Global`u + (12*PolyLogTools`G[0, -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1])/
        Global`u + (12*PolyLogTools`G[0, (-2*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2, 1, 1])/Global`u - 
       (6*PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1])/Global`u + 
       (6*PolyLogTools`G[0, (1 - Global`u)^(-1), (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (6*PolyLogTools`G[0, (1 - Global`u)^(-1), (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (6*PolyLogTools`G[0, 1 - Global`u, 1, 1])/Global`u + 
       (24*PolyLogTools`G[0, (-2 + Global`u)/(-1 + Global`u), 1, 1])/Global`u - 
       (12*PolyLogTools`G[0, Global`u^(-1), 1, 1])/Global`u - 
       (24*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1])/Global`u - 
       (6*PolyLogTools`G[0, (-1 + Global`u)/Global`u, (-1 + Global`u)/Global`u, 1])/Global`u + 
       (12*PolyLogTools`G[0, -(1/Sqrt[Global`u]), 1, 1])/Global`u + 
       (12*PolyLogTools`G[0, 1/Sqrt[Global`u], 1, 1])/Global`u + 
       (3*PolyLogTools`G[0, Global`u, Global`u, 1])/Global`u + 
       (33*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1])/Global`u + 
       (3*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[0, -1/2*(3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-1 + Global`u)^2, 1, 1])/Global`u + 
       (6*PolyLogTools`G[0, -1/2*(3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-1 + Global`u)^2, -1/2*(2*Global`u - 2*Global`u^2)/(-1 + Global`u)^2, 1])/Global`u + 
       (6*PolyLogTools`G[0, (-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (2*(-1 + Global`u)^2), 1, 1])/Global`u + 
       (6*PolyLogTools`G[0, (-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (2*(-1 + Global`u)^2), Global`u/(-1 + Global`u), 1])/Global`u - 
       (12*PolyLogTools`G[-2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u - (12*PolyLogTools`G[-2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1, 1])/
        Global`u - (12*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u - (12*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1, 1])/
        Global`u - (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 0, 1, 1])/Global`u + 
       (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 0, -2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          1])/Global`u + (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 0, 2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1])/
        Global`u + (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), -2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u + (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), (2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (1 + Sqrt[(4 - 3*Global`u)/Global`u])^2, 1, 1])/Global`u + 
       (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), 2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1])/
        Global`u + (12*PolyLogTools`G[-4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])), (-2*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2, 1, 1])/Global`u - 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), 0, 1, 1])/Global`u + 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), 0, (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), 0, (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1])/Global`u + 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1, 1])/Global`u - 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), (1 - Global`u)^(-1), 1])/Global`u + 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), 1, 1])/Global`u - 
       (6*PolyLogTools`G[(1 - Global`u)^(-1), (1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)])/
           (-1 + Sqrt[-((-1 - 3*(1 - Global`u))/Global`u)]), (1 - Global`u)^(-1), 1])/Global`u - 
       (12*PolyLogTools`G[Global`u^(-1), 0, 1, 1])/Global`u - 
       (12*PolyLogTools`G[Global`u^(-1), 1, 0, 1])/Global`u - 
       (12*PolyLogTools`G[Global`u^(-1), 1, 1, 1])/Global`u + 
       (12*PolyLogTools`G[Global`u^(-1), 1, -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[Global`u^(-1), 1, 1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[Global`u^(-1), -(1/Sqrt[Global`u]), 1, 1])/Global`u + 
       (12*PolyLogTools`G[Global`u^(-1), 1/Sqrt[Global`u], 1, 1])/Global`u - 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), -1, 1, 1])/Global`u - 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, -1, 1])/Global`u - 
       (12*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, 1, 1])/Global`u + 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, -((2 - Global`u)/Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, (2 - Global`u)/Global`u, 1])/Global`u + 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), -((2 - Global`u)/Global`u), 1, 1])/Global`u + 
       (6*PolyLogTools`G[-((2 - Global`u)/Global`u), (2 - Global`u)/Global`u, 1, 1])/Global`u - 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, -1, 1, 1])/Global`u - 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, 1, -1, 1])/Global`u - 
       (12*PolyLogTools`G[(2 - Global`u)/Global`u, 1, 1, 1])/Global`u + 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, 1, -((2 - Global`u)/Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, 1, (2 - Global`u)/Global`u, 1])/Global`u + 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, -((2 - Global`u)/Global`u), 1, 1])/Global`u + 
       (6*PolyLogTools`G[(2 - Global`u)/Global`u, (2 - Global`u)/Global`u, 1, 1])/Global`u + 
       (12*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1])/Global`u - 
       (6*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, Global`u/(-1 + Global`u), 1])/Global`u + 
       (12*PolyLogTools`G[(-1 + Global`u)/Global`u, 1, Global`u/(-1 + Global`u), 1])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), 0, 1, 1])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 0, 1])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1, 1])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), Global`u^(-1), 1, 1])/Global`u - 
       (24*PolyLogTools`G[-(1/Sqrt[Global`u]), -(1/Sqrt[Global`u]), 1, 1])/Global`u - 
       (24*PolyLogTools`G[-(1/Sqrt[Global`u]), 1/Sqrt[Global`u], 1, 1])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], 0, 1, 1])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], 1, 0, 1])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], 1, 1, 1])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], 1, Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[1/Sqrt[Global`u], 1, -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[1/Sqrt[Global`u], 1, 1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], Global`u^(-1), 1, 1])/Global`u - 
       (24*PolyLogTools`G[1/Sqrt[Global`u], -(1/Sqrt[Global`u]), 1, 1])/Global`u - 
       (24*PolyLogTools`G[1/Sqrt[Global`u], 1/Sqrt[Global`u], 1, 1])/Global`u - 
       (12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1])/Global`u + 
       (12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, Global`u/(-1 + Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[Global`u/(-1 + Global`u), -1/2*(3*Global`u - 2*Global`u^2 + 
             Sqrt[-(Global`u*(-4 + 3*Global`u))])/(-1 + Global`u)^2, 1, 1])/Global`u - 
       (6*PolyLogTools`G[Global`u/(-1 + Global`u), -1/2*(3*Global`u - 2*Global`u^2 + 
             Sqrt[-(Global`u*(-4 + 3*Global`u))])/(-1 + Global`u)^2, 
          -1/2*(2*Global`u - 2*Global`u^2)/(-1 + Global`u)^2, 1])/Global`u + 
       (6*PolyLogTools`G[Global`u/(-1 + Global`u), (-3*Global`u + 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])/(2*(-1 + Global`u)^2), 1, 1])/Global`u - 
       (6*PolyLogTools`G[Global`u/(-1 + Global`u), (-3*Global`u + 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])/(2*(-1 + Global`u)^2), Global`u/(-1 + Global`u), 
          1])/Global`u - (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          Global`u^(-1), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, -(1/Sqrt[Global`u]), 
          1])/Global`u + (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          1/Sqrt[Global`u], 1])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, Global`u^(-1), 1])/
        Global`u + (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
          -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, 1/Sqrt[Global`u], 1])/
        Global`u - (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          Global`u^(-1), 0, 1])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1, 1])/
        Global`u + (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          Global`u^(-1), -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 0, 
          1])/Global`u + (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 1, 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 0, 1])/
        Global`u + (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], 1, 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          1/Sqrt[Global`u], 1])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, Global`u^(-1), 1])/
        Global`u + (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 1/Sqrt[Global`u], 1])/
        Global`u - (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
          Global`u^(-1), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, -(1/Sqrt[Global`u]), 
          1])/Global`u + (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
          1/Sqrt[Global`u], 1])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 0, 1])/
        Global`u - (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          Global`u^(-1), 1, 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          -(1/Sqrt[Global`u]), 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 0, 
          1])/Global`u + (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 1, 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          1/Sqrt[Global`u], 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 0, 1])/
        Global`u + (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], 1, 1])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          Global`u^(-1), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          -(1/Sqrt[Global`u]), 1])/Global`u - 
       (24*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          1/Sqrt[Global`u], 1])/Global`u + 
       (6*PolyLogTools`G[-1/2*(3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-1 + Global`u)^2, 1, Global`u/(-1 + Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[-1/2*(3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-1 + Global`u)^2, -1/2*(2*Global`u - 2*Global`u^2)/(-1 + Global`u)^2, 
          -1/2*(2*Global`u - 2*Global`u^2)/((-1 + Global`u)*Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[(-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (2*(-1 + Global`u)^2), 1, Global`u/(-1 + Global`u), 1])/Global`u + 
       (6*PolyLogTools`G[(-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (2*(-1 + Global`u)^2), Global`u/(-1 + Global`u), 1, 1])/Global`u + 
       (Pi^2*Log[2])/Global`u - (6*PolyLogTools`G[0, 1, -1]*Log[2])/Global`u + 
       (2*Pi^2*Log[4])/Global`u - (24*PolyLogTools`G[0, 1, -1]*Log[4])/Global`u + 
       (12*PolyLogTools`G[0, 1, (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/4]*Log[4])/Global`u - 
       (4*Pi^2*Log[-1 + (1 - Sqrt[(4 - 3*Global`u)/Global`u])/2 - 
           2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u])])/Global`u - 
       (4*Log[-1 + (1 - Sqrt[(4 - 3*Global`u)/Global`u])/2 - 
            2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u])]^3)/Global`u + 
       (48*PolyLogTools`G[0, 1, -1]*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/4])/Global`u + 
       (4*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/
                 Global`u])^2)/4]^3)/Global`u - 
       (2*Pi^2*Log[4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2])/Global`u + 
       (24*PolyLogTools`G[0, 1, -1]*Log[4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2])/Global`u - 
       (12*PolyLogTools`G[0, 1, (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/4]*
         Log[4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
            2])/Global`u - (4*Pi^2*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))])/Global`u - 
       (4*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/
                 Global`u])^2)/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))]^3)/Global`u - 
       (6*Log[4]*Log[-1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/
                Global`u]))]^2)/Global`u + 
       (6*Log[4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
            2]*Log[-1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/
                Global`u]))]^2)/Global`u - 
       (4*Pi^2*Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (24*PolyLogTools`G[0, 1, -1]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (12*PolyLogTools`G[0, 1, (1 - Sqrt[(4 - 3*Global`u)/Global`u])/2]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (12*PolyLogTools`G[0, 1, -1/2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2/
            (1 + Sqrt[(4 - 3*Global`u)/Global`u])]*Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)])/Global`u + 
       (12*PolyLogTools`G[0, 1, (1 + Sqrt[(4 - 3*Global`u)/Global`u])/2]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u - (12*PolyLogTools`G[0, 1, -1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))]*Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)])/Global`u + 
       (12*PolyLogTools`G[0, 1, (1 + Sqrt[(4 - 3*Global`u)/Global`u])^2/
           (2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]))]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (12*PolyLogTools`G[-2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (12*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 
          -4/((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u])), 1]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u - (6*Log[-1 + (1 - Sqrt[(4 - 3*Global`u)/Global`u])/2 - 
            2/(-1 + Sqrt[(4 - 3*Global`u)/Global`u])]^2*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (6*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
             (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/4]^2*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u - (6*Log[(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
             (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/
                 Global`u]))]^2*Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)])/Global`u + 
       (12*Log[4]*Log[-1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))]*Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*
            (1 + Sqrt[(4 - 3*Global`u)/Global`u]))/(4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
            (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2)])/Global`u - 
       (12*Log[4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + 
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^2]*
         Log[-1/4*((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))]*
         Log[((-1 + Sqrt[(4 - 3*Global`u)/Global`u])*(1 + Sqrt[(4 - 3*Global`u)/Global`u]))/
           (4 + 2*(-1 + Sqrt[(4 - 3*Global`u)/Global`u]) + (-1 + Sqrt[(4 - 3*Global`u)/Global`u])^
             2)])/Global`u + (11*Pi^2*Log[(1 - Global`u)^(-1)])/Global`u + 
       (12*PolyLogTools`G[-1, -1, 1]*Log[(1 - Global`u)^(-1)])/Global`u + 
       (48*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)])/Global`u - 
       (6*Log[2]^2*Log[(1 - Global`u)^(-1)])/Global`u - (22*Log[(1 - Global`u)^(-1)]^2)/Global`u + 
       (6*Log[(1 - Global`u)^(-1)]^3)/Global`u + (11*Pi^2*Log[1 - Global`u])/(2*Global`u) - 
       (24*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u])/Global`u + 
       (12*PolyLogTools`G[0, 1, (-1 + Global`u)/(-2 + Global`u)]*Log[1 - Global`u])/Global`u + 
       (6*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u])/Global`u + 
       (12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u])/Global`u + 
       (6*PolyLogTools`G[0, 1, (-2*(-1 + Global`u)^2)/(3*Global`u - 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])]*Log[1 - Global`u])/Global`u + 
       (6*PolyLogTools`G[0, 1, (2*(-1 + Global`u)^2)/(-3*Global`u + 2*Global`u^2 + 
            Sqrt[-(Global`u*(-4 + 3*Global`u))])]*Log[1 - Global`u])/Global`u + 
       (6*PolyLogTools`G[-1/2*(3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-1 + Global`u)^2, -1/2*(2*Global`u - 2*Global`u^2)/(-1 + Global`u)^2, 1]*
         Log[1 - Global`u])/Global`u + 
       (6*PolyLogTools`G[(-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (2*(-1 + Global`u)^2), Global`u/(-1 + Global`u), 1]*Log[1 - Global`u])/Global`u + 
       (33*Log[1 - Global`u]^2)/Global`u + (13*Log[1 - Global`u]^3)/(2*Global`u) - 
       (48*PolyLogTools`G[0, 1, -1]*Log[(2 - Global`u)^(-1)])/Global`u - 
       (6*Log[1 - Global`u]*Log[(2 - Global`u)^(-1)]^2)/Global`u - (4*Log[(2 - Global`u)^(-1)]^3)/
        Global`u + (12*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), 1]*Log[2 - Global`u])/
        Global`u + (12*PolyLogTools`G[-1, (2 - Global`u)/Global`u, 1]*Log[2 - Global`u])/Global`u + 
       (12*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, 1]*Log[2 - Global`u])/Global`u + 
       (12*PolyLogTools`G[(2 - Global`u)/Global`u, 1, 1]*Log[2 - Global`u])/Global`u + 
       (12*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)])/Global`u - 
       (Pi^2*Log[Global`u^(-1)])/(2*Global`u) + (6*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)])/
        Global`u + (6*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)])/Global`u - 
       (3*Log[(1 - Global`u)^(-1)]^2*Log[Global`u^(-1)])/Global`u + 
       (22*Log[1 - Global`u]*Log[Global`u^(-1)])/Global`u + 
       (12*Log[1 - Global`u]^2*Log[Global`u^(-1)])/Global`u - 
       (9*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)])/Global`u + 
       (9*Log[-1 + Global`u]^2*Log[Global`u^(-1)])/(2*Global`u) + (11*Log[Global`u^(-1)]^2)/
        Global`u - (9*Log[1 - Global`u]*Log[Global`u^(-1)]^2)/(2*Global`u) - 
       (11*Log[Global`u^(-1)]^3)/(2*Global`u) - (Pi^2*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (22*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u])/Global`u + 
       (6*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u])/Global`u - 
       (11*Log[(-1 + Global`u)/Global`u]^2)/Global`u - 
       (3*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2)/Global`u - 
       (9*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2)/(2*Global`u) - 
       Log[(-1 + Global`u)/Global`u]^3/Global`u + (9*Log[(1 - Global`u)^(-1)]*Log[-Global`u]^2)/
        Global`u - (192*Log[Global`u])/Global`u + (15*Pi^2*Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[-1, -1, 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[-1, -((2 - Global`u)/Global`u), 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[-1, (2 - Global`u)/Global`u, 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[0, 1, -1]*Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[Global`u^(-1), 1, 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[-((2 - Global`u)/Global`u), 1, 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[(2 - Global`u)/Global`u, 1, 1]*Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1]*Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[1/Sqrt[Global`u], 1, 1]*Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1]*
         Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1]*
         Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1]*
         Log[Global`u])/Global`u - 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1]*
         Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1]*
         Log[Global`u])/Global`u + 
       (12*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1]*
         Log[Global`u])/Global`u - (6*Log[2]^2*Log[Global`u])/Global`u - 
       (44*Log[(1 - Global`u)^(-1)]*Log[Global`u])/Global`u + 
       (18*Log[1 - Global`u]^2*Log[Global`u])/Global`u + (12*Log[1 - Global`u]*Log[Global`u^(-1)]*
         Log[Global`u])/Global`u + (6*Log[Global`u^(-1)]^2*Log[Global`u])/Global`u + 
       (12*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]*Log[Global`u])/Global`u - 
       (6*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u])/Global`u - 
       (18*Log[(1 - Global`u)^(-1)]*Log[-Global`u]*Log[Global`u])/Global`u - 
       (176*Log[Global`u]^2)/Global`u - (6*Log[(1 - Global`u)^(-1)]*Log[Global`u]^2)/Global`u - 
       (32*Log[Global`u]^3)/Global`u - 
       (2*Pi^2*Log[(2 - Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])])/Global`u - 
       (3*Log[1 - Global`u]*Log[(2 - Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (3*Global`u - 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])]^2)/Global`u - 
       (2*Log[(2 - Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/(3*Global`u - 2*Global`u^2 + 
             Sqrt[-(Global`u*(-4 + 3*Global`u))])]^3)/Global`u - 
       (2*Pi^2*Log[(-2 + Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
           (-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])])/Global`u - 
       (3*Log[1 - Global`u]*Log[(-2 + Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/
            (-3*Global`u + 2*Global`u^2 + Sqrt[-(Global`u*(-4 + 3*Global`u))])]^2)/Global`u - 
       (2*Log[(-2 + Global`u + Sqrt[-(Global`u*(-4 + 3*Global`u))])/(-3*Global`u + 2*Global`u^2 + 
             Sqrt[-(Global`u*(-4 + 3*Global`u))])]^3)/Global`u - 
       (6*Log[1 - Global`u]*PolyLog[2, 1 - Global`u])/Global`u - 
       (6*Log[2]*PolyLog[2, (4*(1 - Global`u))/(2 - Global`u)^2])/Global`u - 
       (6*Log[Global`u]*PolyLog[2, Global`u])/Global`u + (12*PolyLog[3, Global`u])/Global`u - 
       (359*Zeta[3])/Global`u)/Global`\[Epsilon]^3, "Validation" -> 
    <|"AllDistinctSourceKernelsChecked" -> True, "TwoParameterValues" -> {1/3, 2/3}, 
     "PoleChambersPreserved" -> True, "ExactCoefficientAtoms" -> True, "SourceKernelCount" -> 29, 
     "CheckManifest" -> "family_source_check_status.json"|>, "Complete" -> True, 
   "Source" -> "differential_u_20260920/campaign/MB13u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>, 
 "MB14u" -> <|"Route" -> "Standard", "Orders" -> {-6, -3}, "ParameterIntegrated" -> False, 
   "ComplexPhaseRetained" -> True, "Regulator" -> Global`\[Epsilon], "Parameter" -> Global`u, 
   "RemainderOrder" -> -2, "RequestedDomain" -> Inequality[0, Less, Global`u, LessEqual, 1], 
   "PointwiseDomain" -> 0 < Global`u < 1, "EndpointU1" -> "Interpret coefficientwise as a left \
limit. No finite endpoint value is asserted; endpoint distributions are not defined by this \
record.", "Coefficients" -> <|-6 -> (3*(-2 + Global`u))/((-1 + Global`u)*Global`u), 
     -5 -> (-2*(-22 + 11*Global`u - (6*I)*Pi - 6*Log[1 - Global`u] - 9*Log[Global`u] + 
         3*Global`u*Log[Global`u]))/((-1 + Global`u)*Global`u), 
     -4 -> (-384 + 192*Global`u - (352*I)*Pi + 84*Pi^2 - 18*Global`u*Pi^2 - 
        96*PolyLogTools`G[0, 1, -1] + 48*Global`u*PolyLogTools`G[0, 1, -1] + 
        24*Global`u*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] - 
        18*PolyLogTools`G[0, 1, Global`u^(-1)] - 24*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)] + 
        30*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
        24*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
        24*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 12*Log[(1 - Global`u)^(-1)]^2 - 
        352*Log[1 - Global`u] - (96*I)*Pi*Log[1 - Global`u] - 81*Log[1 - Global`u]^2 + 
        12*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)] - 6*Log[(-1 + Global`u)^(-1)]^2 - 
        12*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] + 12*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[-1 + Global`u] + 12*Log[1 - Global`u]*Log[-1 + Global`u] - 
        12*Global`u*Log[1 - Global`u]*Log[-1 + Global`u] - 12*Log[-1 + Global`u]^2 + 
        12*Global`u*Log[-1 + Global`u]^2 + 12*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[Global`u^(-1)] - 30*Log[1 - Global`u]*Log[Global`u^(-1)] - 
        12*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)] - 15*Log[Global`u^(-1)]^2 - 
        12*Global`u*Log[Global`u^(-1)]^2 + 12*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 18*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 
        12*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + 
        9*Log[(-1 + Global`u)/Global`u]^2 + 12*Global`u*Log[(-1 + Global`u)/Global`u]^2 - 
        528*Log[Global`u] + 176*Global`u*Log[Global`u] - (144*I)*Pi*Log[Global`u] - 
        24*Log[(1 - Global`u)^(-1)]*Log[Global`u] - 144*Log[1 - Global`u]*Log[Global`u] - 
        132*Log[Global`u]^2 + 24*Global`u*Log[Global`u]^2 + 24*Global`u*Log[Global`u]*
         Log[Global`u/(-1 + Global`u)] - 12*Global`u*Log[Global`u/(-1 + Global`u)]^2)/
       (4*(-1 + Global`u)*Global`u), -3 -> (256 + 128*Global`u - 128*Global`u^2 + (768*I)*Pi + 
        (768*I)*Global`u*Pi - 600*Pi^2 - 484*Global`u*Pi^2 + 132*Global`u^2*Pi^2 - (140*I)*Pi^3 - 
        (140*I)*Global`u*Pi^3 + 2*Pi^2*PolyLogTools`G[-((1 - Global`u)/Global`u), 1] + 
        2*Global`u*Pi^2*PolyLogTools`G[-((1 - Global`u)/Global`u), 1] - 
        12*PolyLogTools`G[(1 - Global`u)^(-1), 1]*PolyLogTools`G[1 - Global`u, 1]*
         PolyLogTools`G[-((1 - Global`u)/Global`u), 1] - 12*Global`u*
         PolyLogTools`G[(1 - Global`u)^(-1), 1]*PolyLogTools`G[1 - Global`u, 1]*
         PolyLogTools`G[-((1 - Global`u)/Global`u), 1] - 2*Global`u*Pi^2*
         PolyLogTools`G[Global`u/(-1 + Global`u), 1] - 2*Global`u^2*Pi^2*
         PolyLogTools`G[Global`u/(-1 + Global`u), 1] + 12*Global`u*PolyLogTools`G[Global`u^(-1), 1]*
         PolyLogTools`G[Global`u, 1]*PolyLogTools`G[Global`u/(-1 + Global`u), 1] + 
        12*Global`u^2*PolyLogTools`G[Global`u^(-1), 1]*PolyLogTools`G[Global`u, 1]*
         PolyLogTools`G[Global`u/(-1 + Global`u), 1] + 
        24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1] - 
        24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1] - 
        24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1] + 
        24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1] - 
        96*PolyLogTools`G[-1, -1, 1] - 96*Global`u*PolyLogTools`G[-1, -1, 1] + 
        560*PolyLogTools`G[0, 1, -1] + 304*Global`u*PolyLogTools`G[0, 1, -1] - 
        352*Global`u^2*PolyLogTools`G[0, 1, -1] + (96*I)*Pi*PolyLogTools`G[0, 1, -1] + 
        (96*I)*Global`u*Pi*PolyLogTools`G[0, 1, -1] - 48*PolyLogTools`G[0, 1, 
          (1 - Global`u)^(-1)] - 128*Global`u*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] - 
        176*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + 
        132*PolyLogTools`G[0, 1, Global`u^(-1)] + 308*Global`u*PolyLogTools`G[0, 1, 
          Global`u^(-1)] + 176*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)] + 
        (60*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)] + (60*I)*Global`u*Pi*
         PolyLogTools`G[0, 1, Global`u^(-1)] - 220*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
        396*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
        176*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
        (36*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - (36*I)*Global`u*Pi*
         PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
        176*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 
        176*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 
        (48*I)*Pi*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - (48*I)*Global`u*Pi*
         PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 
        48*PolyLogTools`G[0, 1, (1 + Global`u)^(-1)] + 48*Global`u*PolyLogTools`G[0, 1, 
          (1 + Global`u)^(-1)] - 12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*
         PolyLogTools`G[0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] - 
        12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
        12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
          (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
        12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
          (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] - 
        12*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (1 + Sqrt[(4 - 3*Global`u)/Global`u])/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] - 
        12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (1 + Sqrt[(4 - 3*Global`u)/Global`u])/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
        12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
          (1 + Sqrt[(4 - 3*Global`u)/Global`u])/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
        12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
          (1 + Sqrt[(4 - 3*Global`u)/Global`u])/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
        12*PolyLogTools`G[(1 - Global`u)^(-1), 1]*PolyLogTools`G[0, 1 - Global`u, 1] + 
        12*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1]*PolyLogTools`G[0, 1 - Global`u, 1] + 
        12*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[0, 1 - Global`u, 1] + 
        12*Global`u*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[0, 1 - Global`u, 
          1] + 12*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*
         PolyLogTools`G[0, 1 - Global`u, 1] + 12*Global`u^2*PolyLogTools`G[
          (-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 1 - Global`u, 1] - 
        12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 1 - Global`u, 
          1] - 12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*
         PolyLogTools`G[0, 1 - Global`u, 1] - 144*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*
         PolyLogTools`G[0, Global`u^(-1), 1] - 144*Global`u*PolyLogTools`G[-(-1 + Global`u)^(-1), 
          1]*PolyLogTools`G[0, Global`u^(-1), 1] + 72*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*
         PolyLogTools`G[0, Global`u^(-1), 1] + 72*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 
          1]*PolyLogTools`G[0, Global`u^(-1), 1] - 12*Global`u*PolyLogTools`G[Global`u^(-1), 1]*
         PolyLogTools`G[0, Global`u, 1] - 12*Global`u^2*PolyLogTools`G[Global`u^(-1), 1]*
         PolyLogTools`G[0, Global`u, 1] - 12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*
         PolyLogTools`G[0, Global`u, 1] - 12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*
         PolyLogTools`G[0, Global`u, 1] + 72*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*
         PolyLogTools`G[0, (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^
                4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] + 
        72*Global`u*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*PolyLogTools`G[0, 
          (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
        72*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
        72*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] + 
        72*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*PolyLogTools`G[0, 
          (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] + 
        72*Global`u*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*PolyLogTools`G[0, 
          (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
        72*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
        72*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] + 
        12*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
           (-1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1] + 
        12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
           (-1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1] + 
        12*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
           (1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1] + 
        12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
          (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
           (1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1] + 
        12*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[(1 - Global`u)^(-1), 1, 
          1] + 12*Global`u*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*
         PolyLogTools`G[(1 - Global`u)^(-1), 1, 1] + 12*PolyLogTools`G[-((1 - Global`u)/Global`u), 
          1]*PolyLogTools`G[1 - Global`u, 1, 1] + 12*Global`u*PolyLogTools`G[
          -((1 - Global`u)/Global`u), 1]*PolyLogTools`G[1 - Global`u, 1, 1] - 
        24*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u^(-1), 1, 
          1] - 24*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*
         PolyLogTools`G[Global`u^(-1), 1, 1] + 12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 
          1]*PolyLogTools`G[Global`u^(-1), (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
        12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u^(-1), 
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
        12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u^(-1), 
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
        12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u^(-1), 
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u, 1, 1] - 
        12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u, 1, 1] - 
        24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -1, 1] + 
        24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -1, 1] - 
        24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1] + 
        24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1] + 
        24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -((1 + Global`u)/(1 - Global`u)), 1] - 
        24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 
          -((1 + Global`u)/(1 - Global`u)), 1] + 
        24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), (1 + Global`u)/(1 - Global`u), 1] - 
        24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), (1 + Global`u)/(1 - Global`u), 
          1] + 24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -1, 1] - 
        24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -1, 1] + 
        24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1] - 
        24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1] - 
        24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -((1 + Global`u)/(1 - Global`u)), 1] + 
        24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -((1 + Global`u)/(1 - Global`u)), 
          1] - 24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), (1 + Global`u)/(1 - Global`u), 1] + 
        24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), (1 + Global`u)/(1 - Global`u), 
          1] - 18*PolyLogTools`G[-1, 0, -1, 1] - 72*Global`u*PolyLogTools`G[-1, 0, -1, 1] - 
        54*Global`u^2*PolyLogTools`G[-1, 0, -1, 1] + 
        24*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), -1, 1] + 
        24*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), -1, 1] + 
        24*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1, 1] + 
        24*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1, 1] - 
        24*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), -((1 + Global`u)/(1 - Global`u)), 
          1] - 24*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 
          -((1 + Global`u)/(1 - Global`u)), 1] - 24*PolyLogTools`G[-1, 
          -((1 + Global`u)/(1 - Global`u)), (1 + Global`u)/(1 - Global`u), 1] - 
        24*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 
          (1 + Global`u)/(1 - Global`u), 1] + 24*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 
          -1, 1] + 24*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), -1, 1] + 
        24*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1, 1] + 
        24*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1, 1] - 
        24*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), -((1 + Global`u)/(1 - Global`u)), 1] - 
        24*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 
          -((1 + Global`u)/(1 - Global`u)), 1] - 24*PolyLogTools`G[-1, 
          (1 + Global`u)/(1 - Global`u), (1 + Global`u)/(1 - Global`u), 1] - 
        24*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 
          (1 + Global`u)/(1 - Global`u), 1] + 18*PolyLogTools`G[0, 0, 1, -1] + 
        72*Global`u*PolyLogTools`G[0, 0, 1, -1] + 54*Global`u^2*PolyLogTools`G[0, 0, 1, -1] - 
        120*Global`u*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)] - 
        120*Global`u^2*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)] + 
        24*PolyLogTools`G[0, 0, 1, 1 - Global`u] + 12*Global`u*PolyLogTools`G[0, 0, 1, 
          1 - Global`u] - 12*Global`u^2*PolyLogTools`G[0, 0, 1, 1 - Global`u] + 
        210*PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 138*Global`u*PolyLogTools`G[0, 0, 1, 
          Global`u^(-1)] - 72*Global`u^2*PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 
        180*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u] + 
        108*Global`u*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u] - 
        72*Global`u^2*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u] + 
        48*PolyLogTools`G[0, 0, 1, Global`u] + 36*Global`u*PolyLogTools`G[0, 0, 1, Global`u] - 
        12*Global`u^2*PolyLogTools`G[0, 0, 1, Global`u] - 12*Global`u*PolyLogTools`G[0, 0, 1, 
          Global`u/(-1 + Global`u)] - 12*Global`u^2*PolyLogTools`G[0, 0, 1, 
          Global`u/(-1 + Global`u)] - 96*PolyLogTools`G[0, 0, 1, Global`u/(1 + Global`u)] - 
        96*Global`u*PolyLogTools`G[0, 0, 1, Global`u/(1 + Global`u)] + 
        24*Global`u*PolyLogTools`G[0, 0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
        24*Global`u^2*PolyLogTools`G[0, 0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
        24*Global`u*PolyLogTools`G[0, 0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
        24*Global`u^2*PolyLogTools`G[0, 0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
        24*Global`u*PolyLogTools`G[0, 0, (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/
           (1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 24*Global`u^2*PolyLogTools`G[0, 0, 
          (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
        24*Global`u*PolyLogTools`G[0, 0, (1 + Sqrt[(4 - 3*Global`u)/Global`u])/
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 24*Global`u^2*PolyLogTools`G[0, 0, 
          (1 + Sqrt[(4 - 3*Global`u)/Global`u])/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] - 
        24*PolyLogTools`G[0, 0, 1 - Global`u, 1] - 48*Global`u*PolyLogTools`G[0, 0, 1 - Global`u, 
          1] - 24*Global`u^2*PolyLogTools`G[0, 0, 1 - Global`u, 1] + 
        432*PolyLogTools`G[0, 0, Global`u^(-1), 1] + 432*Global`u*PolyLogTools`G[0, 0, 
          Global`u^(-1), 1] + 24*Global`u*PolyLogTools`G[0, 0, Global`u, 1] + 
        24*Global`u^2*PolyLogTools`G[0, 0, Global`u, 1] - 
        288*PolyLogTools`G[0, 0, (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
               (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/
                (-1 + Global`u)^4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/
                (-1 + Global`u)^4)])/(3*Global`u - 2*Global`u^2 + 
            Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
        288*Global`u*PolyLogTools`G[0, 0, (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
               (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/
                (-1 + Global`u)^4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/
                (-1 + Global`u)^4)])/(3*Global`u - 2*Global`u^2 + 
            Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
        288*PolyLogTools`G[0, 0, (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
               (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/
                (-1 + Global`u)^4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/
                (-1 + Global`u)^4)])/(-3*Global`u + 2*Global`u^2 + 
            Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
        288*Global`u*PolyLogTools`G[0, 0, (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
               (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/
                (-1 + Global`u)^4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/
                (-1 + Global`u)^4)])/(-3*Global`u + 2*Global`u^2 + 
            Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] + 
        24*PolyLogTools`G[0, 1, 1, (1 - Global`u)^(-1)] + 24*Global`u*PolyLogTools`G[0, 1, 1, 
          (1 - Global`u)^(-1)] - 48*Global`u*PolyLogTools`G[0, 1, 1, Global`u^(-1)] - 
        48*Global`u^2*PolyLogTools`G[0, 1, 1, Global`u^(-1)] - 
        12*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1] + 12*Global`u*PolyLogTools`G[0, 1, 
          (1 - Global`u)^(-1), 1] + 24*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1] - 
        24*Global`u*PolyLogTools`G[0, 1, -(1/Sqrt[1 - Global`u]), 1] - 
        24*Global`u^2*PolyLogTools`G[0, 1, -(1/Sqrt[1 - Global`u]), 1] - 
        24*Global`u*PolyLogTools`G[0, 1, 1/Sqrt[1 - Global`u], 1] - 
        24*Global`u^2*PolyLogTools`G[0, 1, 1/Sqrt[1 - Global`u], 1] - 
        12*PolyLogTools`G[0, 1, 1 - Global`u, 1] + 60*Global`u*PolyLogTools`G[0, 1, 1 - Global`u, 
          1] + 72*Global`u^2*PolyLogTools`G[0, 1, 1 - Global`u, 1] - 
        12*Global`u*PolyLogTools`G[0, 1, -(-1 + Global`u)^(-1), 1] - 
        12*Global`u^2*PolyLogTools`G[0, 1, -(-1 + Global`u)^(-1), 1] - 
        72*PolyLogTools`G[0, 1, Global`u^(-1), 1] - 48*Global`u*PolyLogTools`G[0, 1, Global`u^(-1), 
          1] + 24*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1), 1] - 
        12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] + 
        12*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] + 
        72*PolyLogTools`G[0, 1, -(1/Sqrt[Global`u]), 1] + 72*Global`u*PolyLogTools`G[0, 1, 
          -(1/Sqrt[Global`u]), 1] + 72*PolyLogTools`G[0, 1, 1/Sqrt[Global`u], 1] + 
        72*Global`u*PolyLogTools`G[0, 1, 1/Sqrt[Global`u], 1] - 
        114*PolyLogTools`G[0, 1, Global`u, 1] - 114*Global`u*PolyLogTools`G[0, 1, Global`u, 1] + 
        108*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] + 
        156*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] + 
        48*Global`u^2*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] + 
        12*Global`u*PolyLogTools`G[0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] + 
        12*Global`u^2*PolyLogTools`G[0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] - 
        12*Global`u*PolyLogTools`G[0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] - 
        12*Global`u^2*PolyLogTools`G[0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] + 
        12*Global`u*PolyLogTools`G[0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] + 
        12*Global`u^2*PolyLogTools`G[0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] - 
        12*Global`u*PolyLogTools`G[0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] - 
        12*Global`u^2*PolyLogTools`G[0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] + 
        24*Global`u*PolyLogTools`G[0, (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/
           (1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1] + 24*Global`u^2*
         PolyLogTools`G[0, (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/
           (1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1] + 24*Global`u*
         PolyLogTools`G[0, (1 + Sqrt[(4 - 3*Global`u)/Global`u])/
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1] + 24*Global`u^2*
         PolyLogTools`G[0, (1 + Sqrt[(4 - 3*Global`u)/Global`u])/
           (-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1] + 
        12*PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1] + 24*Global`u*
         PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1] + 12*Global`u^2*
         PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1] - 24*Global`u*PolyLogTools`G[0, 
          -(1/Sqrt[1 - Global`u]), 1, 1] - 24*Global`u^2*PolyLogTools`G[0, -(1/Sqrt[1 - Global`u]), 
          1, 1] - 24*Global`u*PolyLogTools`G[0, 1/Sqrt[1 - Global`u], 1, 1] - 
        24*Global`u^2*PolyLogTools`G[0, 1/Sqrt[1 - Global`u], 1, 1] - 
        24*PolyLogTools`G[0, 1 - Global`u, 1, 1] - 72*Global`u*PolyLogTools`G[0, 1 - Global`u, 1, 
          1] - 48*Global`u^2*PolyLogTools`G[0, 1 - Global`u, 1, 1] + 
        12*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1] - 
        48*Global`u*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1] - 
        60*Global`u^2*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1] - 
        48*PolyLogTools`G[0, Global`u^(-1), 1, 1] - 48*Global`u*PolyLogTools`G[0, Global`u^(-1), 1, 
          1] - 12*Global`u*PolyLogTools`G[0, Global`u^(-1), 
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u^2*PolyLogTools`G[0, Global`u^(-1), 
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u*PolyLogTools`G[0, Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u^2*PolyLogTools`G[0, Global`u^(-1), 
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
        120*PolyLogTools`G[0, Global`u^(-1), Global`u^(-1), 1] + 
        120*Global`u*PolyLogTools`G[0, Global`u^(-1), Global`u^(-1), 1] - 
        12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
        36*Global`u*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
        48*Global`u^2*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
        72*PolyLogTools`G[0, -(1/Sqrt[Global`u]), 1, 1] + 72*Global`u*
         PolyLogTools`G[0, -(1/Sqrt[Global`u]), 1, 1] + 72*PolyLogTools`G[0, 1/Sqrt[Global`u], 1, 
          1] + 72*Global`u*PolyLogTools`G[0, 1/Sqrt[Global`u], 1, 1] + 
        78*PolyLogTools`G[0, Global`u, 1, 1] + 18*Global`u*PolyLogTools`G[0, Global`u, 1, 1] - 
        60*Global`u^2*PolyLogTools`G[0, Global`u, 1, 1] + 174*PolyLogTools`G[0, Global`u, Global`u, 
          1] + 174*Global`u*PolyLogTools`G[0, Global`u, Global`u, 1] + 
        312*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] + 
        276*Global`u*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] - 
        36*Global`u^2*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] - 
        108*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] - 
        108*Global`u*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] - 
        96*PolyLogTools`G[0, (1 + Global`u)/Global`u, (1 + Global`u)/((1 + Global`u^(-1))*
            Global`u), 1] - 96*Global`u*PolyLogTools`G[0, (1 + Global`u)/Global`u, 
          (1 + Global`u)/((1 + Global`u^(-1))*Global`u), 1] - 
        72*PolyLogTools`G[0, (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^
                4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), Global`u^(-1), 
          1] - 72*Global`u*PolyLogTools`G[0, (2 - Global`u + 
            Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), Global`u^(-1), 
          1] - 72*PolyLogTools`G[0, (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
               (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/
                (-1 + Global`u)^4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/
                (-1 + Global`u)^4)])/(-3*Global`u + 2*Global`u^2 + 
            Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), Global`u^(-1), 
          1] - 72*Global`u*PolyLogTools`G[0, (-2 + Global`u + 
            Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
           (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
            2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
            Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), Global`u^(-1), 
          1] - 24*Global`u*PolyLogTools`G[0, (-1 - Global`u + Global`u*
             Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/(-1 + Global`u + 
            Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1, 1] - 
        24*Global`u^2*PolyLogTools`G[0, (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 
                3*Global`u^2)/Global`u^2])/(-1 + Global`u + Global`u*
             Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1, 1] + 
        12*Global`u*PolyLogTools`G[0, (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 
                3*Global`u^2)/Global`u^2])/(-1 + Global`u + Global`u*
             Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), -(-1 + Global`u)^(-1), 1] + 
        12*Global`u^2*PolyLogTools`G[0, (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 
                3*Global`u^2)/Global`u^2])/(-1 + Global`u + Global`u*
             Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), -(-1 + Global`u)^(-1), 1] - 
        24*Global`u*PolyLogTools`G[0, (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
               Global`u^2])/(1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^
                2]), 1, 1] - 24*Global`u^2*PolyLogTools`G[0, 
          (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
           (1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1, 1] + 
        12*Global`u*PolyLogTools`G[0, (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
               Global`u^2])/(1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^
                2]), -(-1 + Global`u)^(-1), 1] + 12*Global`u^2*PolyLogTools`G[0, 
          (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
           (1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 
          -(-1 + Global`u)^(-1), 1] + 24*PolyLogTools`G[1, 0, 1, (1 - Global`u)^(-1)] + 
        24*Global`u*PolyLogTools`G[1, 0, 1, (1 - Global`u)^(-1)] - 
        48*Global`u*PolyLogTools`G[1, 0, 1, Global`u^(-1)] - 48*Global`u^2*
         PolyLogTools`G[1, 0, 1, Global`u^(-1)] + 24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 
          0, 1, 1] + 24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 0, 1, 1] + 
        24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, 0, 1] + 
        24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 1, 0, 1] - 
        12*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1, 1] + 12*Global`u*
         PolyLogTools`G[(1 - Global`u)^(-1), 1, 1, 1] + 24*Global`u^2*
         PolyLogTools`G[(1 - Global`u)^(-1), 1, 1, 1] + 12*PolyLogTools`G[(1 - Global`u)^(-1), 1, 
          (1 - Global`u)^(-1), 1] + 12*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, 
          (1 - Global`u)^(-1), 1] - 24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 1, 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, 
          1/Sqrt[1 - Global`u], 1] - 24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 1, 
          1/Sqrt[1 - Global`u], 1] - 24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 
          -(1/Sqrt[1 - Global`u]), 1, 1] - 24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 
          -(1/Sqrt[1 - Global`u]), 1, 1] - 24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 
          1/Sqrt[1 - Global`u], 1, 1] - 24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 
          1/Sqrt[1 - Global`u], 1, 1] - 24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 0, 1, 
          1] - 24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 0, 1, 1] - 
        24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 0, 1] - 
        24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 0, 1] - 
        24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1, 1] - 
        24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1, 1] - 
        24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, (1 - Global`u)^(-1), 1] - 
        24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, (1 - Global`u)^(-1), 1] + 
        48*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, -(1/Sqrt[1 - Global`u]), 1] + 
        48*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, -(1/Sqrt[1 - Global`u]), 1] + 
        48*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1/Sqrt[1 - Global`u], 1] + 
        48*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1/Sqrt[1 - Global`u], 1] - 
        24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1, 1] - 
        24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1, 1] + 
        48*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1, 1] + 
        48*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1, 1] + 
        48*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1, 1] + 
        48*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1, 1] - 
        24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 0, 1, 1] - 
        24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 0, 1, 1] - 
        24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 0, 1] - 
        24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 0, 1] - 
        24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1, 1] - 
        24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1, 1] - 
        24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, (1 - Global`u)^(-1), 1] - 
        24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, (1 - Global`u)^(-1), 1] + 
        48*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, -(1/Sqrt[1 - Global`u]), 1] + 
        48*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, -(1/Sqrt[1 - Global`u]), 1] + 
        48*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1/Sqrt[1 - Global`u], 1] + 
        48*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1/Sqrt[1 - Global`u], 1] - 
        24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], (1 - Global`u)^(-1), 1, 1] - 
        24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], (1 - Global`u)^(-1), 1, 1] + 
        48*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], -(1/Sqrt[1 - Global`u]), 1, 1] + 
        48*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], -(1/Sqrt[1 - Global`u]), 1, 1] + 
        48*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1/Sqrt[1 - Global`u], 1, 1] + 
        48*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1/Sqrt[1 - Global`u], 1, 1] + 
        24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          0, (1 - Global`u)^(-1), 1] + 24*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, (1 - Global`u)^(-1), 
          1] - 24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), 0, -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*
         PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, 1/Sqrt[1 - Global`u], 
          1] - 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), 0, 1/Sqrt[1 - Global`u], 1] + 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, (1 - Global`u)^(-1), 
          1] + 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), 1, (1 - Global`u)^(-1), 1] - 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 1/Sqrt[1 - Global`u], 
          1] - 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), 1, 1/Sqrt[1 - Global`u], 1] + 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 0, 
          1] + 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), (1 - Global`u)^(-1), 0, 1] + 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 1, 
          1] + 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), (1 - Global`u)^(-1), 1, 1] - 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
          1/Sqrt[1 - Global`u], 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
          1/Sqrt[1 - Global`u], 1] - 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
          0, 1] - 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), -(1/Sqrt[1 - Global`u]), 0, 1] - 24*Global`u*
         PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          -(1/Sqrt[1 - Global`u]), 1, 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
          1, 1] - 24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), -(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1] - 
        24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), -(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1] + 
        48*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          -(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1] + 
        48*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), -(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1] + 
        48*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          -(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1] + 48*Global`u^2*
         PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          -(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1] - 
        24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          1/Sqrt[1 - Global`u], 0, 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 0, 
          1] - 24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), 1/Sqrt[1 - Global`u], 1, 1] - 24*Global`u^2*
         PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          1/Sqrt[1 - Global`u], 1, 1] - 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          (1 - Global`u)^(-1), 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          (1 - Global`u)^(-1), 1] + 48*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          -(1/Sqrt[1 - Global`u]), 1] + 48*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          -(1/Sqrt[1 - Global`u]), 1] + 48*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          1/Sqrt[1 - Global`u], 1] + 48*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          1/Sqrt[1 - Global`u], 1] + 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, (1 - Global`u)^(-1), 
          1] + 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), 0, (1 - Global`u)^(-1), 1] - 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, 1/Sqrt[1 - Global`u], 
          1] - 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), 0, 1/Sqrt[1 - Global`u], 1] + 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, (1 - Global`u)^(-1), 
          1] + 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), 1, (1 - Global`u)^(-1), 1] - 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 1/Sqrt[1 - Global`u], 
          1] - 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), 1, 1/Sqrt[1 - Global`u], 1] + 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 0, 
          1] + 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), (1 - Global`u)^(-1), 0, 1] + 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 1, 
          1] + 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), (1 - Global`u)^(-1), 1, 1] - 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
          -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
          1/Sqrt[1 - Global`u], 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
          1/Sqrt[1 - Global`u], 1] - 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
          0, 1] - 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), -(1/Sqrt[1 - Global`u]), 0, 1] - 24*Global`u*
         PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          -(1/Sqrt[1 - Global`u]), 1, 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
          1, 1] - 24*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), -(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1] - 
        24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), -(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1] + 
        48*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          -(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1] + 
        48*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), -(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1] + 
        48*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          -(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1] + 48*Global`u^2*
         PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          -(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1] - 
        24*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          1/Sqrt[1 - Global`u], 0, 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 0, 
          1] - 24*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
            Global`u), 1/Sqrt[1 - Global`u], 1, 1] - 24*Global`u^2*
         PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          1/Sqrt[1 - Global`u], 1, 1] - 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          (1 - Global`u)^(-1), 1] - 24*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          (1 - Global`u)^(-1), 1] + 48*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          -(1/Sqrt[1 - Global`u]), 1] + 48*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          -(1/Sqrt[1 - Global`u]), 1] + 48*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          1/Sqrt[1 - Global`u], 1] + 48*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
          1/Sqrt[1 - Global`u], 1] - 72*PolyLogTools`G[Global`u^(-1), 0, 1, 1] - 
        60*Global`u*PolyLogTools`G[Global`u^(-1), 0, 1, 1] + 12*Global`u^2*
         PolyLogTools`G[Global`u^(-1), 0, 1, 1] - 12*Global`u*PolyLogTools`G[Global`u^(-1), 0, 
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u^2*PolyLogTools`G[Global`u^(-1), 0, 
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u*PolyLogTools`G[Global`u^(-1), 0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
        12*Global`u^2*PolyLogTools`G[Global`u^(-1), 0, 
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
        48*PolyLogTools`G[Global`u^(-1), 0, Global`u^(-1), 1] + 
        48*Global`u*PolyLogTools`G[Global`u^(-1), 0, Global`u^(-1), 1] - 
        72*PolyLogTools`G[Global`u^(-1), 1, 0, 1] - 72*Global`u*PolyLogTools`G[Global`u^(-1), 1, 0, 
          1] - 72*PolyLogTools`G[Global`u^(-1), 1, 1, 1] - 
        48*Global`u*PolyLogTools`G[Global`u^(-1), 1, 1, 1] + 24*Global`u^2*
         PolyLogTools`G[Global`u^(-1), 1, 1, 1] - 24*Global`u*PolyLogTools`G[Global`u^(-1), 1, 
          Global`u^(-1), 1] - 24*Global`u^2*PolyLogTools`G[Global`u^(-1), 1, Global`u^(-1), 1] + 
        72*PolyLogTools`G[Global`u^(-1), 1, -(1/Sqrt[Global`u]), 1] + 
        72*Global`u*PolyLogTools`G[Global`u^(-1), 1, -(1/Sqrt[Global`u]), 1] + 
        72*PolyLogTools`G[Global`u^(-1), 1, 1/Sqrt[Global`u], 1] + 
        72*Global`u*PolyLogTools`G[Global`u^(-1), 1, 1/Sqrt[Global`u], 1] - 
        12*Global`u*PolyLogTools`G[Global`u^(-1), (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] - 
        12*Global`u^2*PolyLogTools`G[Global`u^(-1), (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] + 
        12*Global`u*PolyLogTools`G[Global`u^(-1), (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] + 
        12*Global`u^2*PolyLogTools`G[Global`u^(-1), (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] - 
        12*Global`u*PolyLogTools`G[Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] - 
        12*Global`u^2*PolyLogTools`G[Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] + 
        12*Global`u*PolyLogTools`G[Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] + 
        12*Global`u^2*PolyLogTools`G[Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
           (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] + 
        72*PolyLogTools`G[Global`u^(-1), -(1/Sqrt[Global`u]), 1, 1] + 
        72*Global`u*PolyLogTools`G[Global`u^(-1), -(1/Sqrt[Global`u]), 1, 1] + 
        72*PolyLogTools`G[Global`u^(-1), 1/Sqrt[Global`u], 1, 1] + 
        72*Global`u*PolyLogTools`G[Global`u^(-1), 1/Sqrt[Global`u], 1, 1] - 
        24*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1] - 
        24*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1] + 
        24*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1] + 
        36*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1] + 
        12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1] + 
        72*PolyLogTools`G[-(1/Sqrt[Global`u]), 0, 1, 1] + 72*Global`u*
         PolyLogTools`G[-(1/Sqrt[Global`u]), 0, 1, 1] + 72*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 
          0, 1] + 72*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 0, 1] + 
        72*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1, 1] + 72*Global`u*
         PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1, 1] + 72*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 
          Global`u^(-1), 1] + 72*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, Global`u^(-1), 
          1] - 144*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, -(1/Sqrt[Global`u]), 1] - 
        144*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, -(1/Sqrt[Global`u]), 1] - 
        144*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1/Sqrt[Global`u], 1] - 
        144*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1/Sqrt[Global`u], 1] + 
        72*PolyLogTools`G[-(1/Sqrt[Global`u]), Global`u^(-1), 1, 1] + 
        72*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), Global`u^(-1), 1, 1] - 
        144*PolyLogTools`G[-(1/Sqrt[Global`u]), -(1/Sqrt[Global`u]), 1, 1] - 
        144*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), -(1/Sqrt[Global`u]), 1, 1] - 
        144*PolyLogTools`G[-(1/Sqrt[Global`u]), 1/Sqrt[Global`u], 1, 1] - 
        144*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1/Sqrt[Global`u], 1, 1] + 
        72*PolyLogTools`G[1/Sqrt[Global`u], 0, 1, 1] + 72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 
          0, 1, 1] + 72*PolyLogTools`G[1/Sqrt[Global`u], 1, 0, 1] + 
        72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1, 0, 1] + 
        72*PolyLogTools`G[1/Sqrt[Global`u], 1, 1, 1] + 72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 
          1, 1, 1] + 72*PolyLogTools`G[1/Sqrt[Global`u], 1, Global`u^(-1), 1] + 
        72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1, Global`u^(-1), 1] - 
        144*PolyLogTools`G[1/Sqrt[Global`u], 1, -(1/Sqrt[Global`u]), 1] - 
        144*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1, -(1/Sqrt[Global`u]), 1] - 
        144*PolyLogTools`G[1/Sqrt[Global`u], 1, 1/Sqrt[Global`u], 1] - 
        144*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1, 1/Sqrt[Global`u], 1] + 
        72*PolyLogTools`G[1/Sqrt[Global`u], Global`u^(-1), 1, 1] + 
        72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], Global`u^(-1), 1, 1] - 
        144*PolyLogTools`G[1/Sqrt[Global`u], -(1/Sqrt[Global`u]), 1, 1] - 
        144*Global`u*PolyLogTools`G[1/Sqrt[Global`u], -(1/Sqrt[Global`u]), 1, 1] - 
        144*PolyLogTools`G[1/Sqrt[Global`u], 1/Sqrt[Global`u], 1, 1] - 
        144*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1/Sqrt[Global`u], 1, 1] + 
        12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1] + 
        12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1] - 
        12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] - 
        12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
        24*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] + 
        24*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] + 
        24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -1, 1, 1] + 
        24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -1, 1, 1] + 
        24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, -1, 1] + 
        24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, -1, 1] + 
        48*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1, 1] + 
        48*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1, 1] - 
        24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, -((1 + Global`u)/(1 - Global`u)), 
          1] - 24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 
          -((1 + Global`u)/(1 - Global`u)), 1] - 
        24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, (1 + Global`u)/(1 - Global`u), 1] - 
        24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 
          (1 + Global`u)/(1 - Global`u), 1] - 24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 
          -((1 + Global`u)/(1 - Global`u)), 1, 1] - 24*Global`u*PolyLogTools`G[
          -((1 + Global`u)/(1 - Global`u)), -((1 + Global`u)/(1 - Global`u)), 1, 1] - 
        24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), (1 + Global`u)/(1 - Global`u), 1, 1] - 
        24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), (1 + Global`u)/(1 - Global`u), 
          1, 1] + 24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -1, 1, 1] + 
        24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -1, 1, 1] + 
        24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, -1, 1] + 
        24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, -1, 1] + 
        48*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1, 1] + 
        48*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1, 1] - 
        24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, -((1 + Global`u)/(1 - Global`u)), 1] - 
        24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 
          -((1 + Global`u)/(1 - Global`u)), 1] - 24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 
          1, (1 + Global`u)/(1 - Global`u), 1] - 24*Global`u*PolyLogTools`G[
          (1 + Global`u)/(1 - Global`u), 1, (1 + Global`u)/(1 - Global`u), 1] - 
        24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -((1 + Global`u)/(1 - Global`u)), 1, 1] - 
        24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -((1 + Global`u)/(1 - Global`u)), 
          1, 1] - 24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), (1 + Global`u)/(1 - Global`u), 
          1, 1] - 24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 
          (1 + Global`u)/(1 - Global`u), 1, 1] - 
        72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, Global`u^(-1), 1] - 
        72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          Global`u^(-1), 1] + 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          -(1/Sqrt[Global`u]), 1] + 72*Global`u*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, -(1/Sqrt[Global`u]), 1] + 
        72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 1/Sqrt[Global`u], 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          1/Sqrt[Global`u], 1] - 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          1, Global`u^(-1), 1] - 72*Global`u*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, Global`u^(-1), 1] + 
        72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, -(1/Sqrt[Global`u]), 
          1] + 72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
          -(1/Sqrt[Global`u]), 1] + 72*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, 1/Sqrt[Global`u], 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
          1/Sqrt[Global`u], 1] - 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          Global`u^(-1), 0, 1] - 72*Global`u*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 0, 1] - 
        72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1, 1] - 
        72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          1, 1] + 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          -(1/Sqrt[Global`u]), 1] + 72*Global`u*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), -(1/Sqrt[Global`u]), 1] + 
        72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          1/Sqrt[Global`u], 1] + 72*Global`u*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1/Sqrt[Global`u], 1] + 
        72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 0, 
          1] + 72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 0, 1] + 72*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1, 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 1, 1] + 72*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), Global`u^(-1), 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), Global`u^(-1), 1] - 
        144*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          -(1/Sqrt[Global`u]), 1] - 144*Global`u*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), -(1/Sqrt[Global`u]), 
          1] - 144*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 1/Sqrt[Global`u], 1] - 144*Global`u*
         PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          1/Sqrt[Global`u], 1] + 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], 0, 1] + 72*Global`u*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 0, 1] + 
        72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1, 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], 1, 1] + 72*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], Global`u^(-1), 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], Global`u^(-1), 1] - 
        144*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          -(1/Sqrt[Global`u]), 1] - 144*Global`u*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], -(1/Sqrt[Global`u]), 
          1] - 144*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          1/Sqrt[Global`u], 1] - 144*Global`u*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1/Sqrt[Global`u], 1] - 
        72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, Global`u^(-1), 1] - 
        72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          Global`u^(-1), 1] + 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          -(1/Sqrt[Global`u]), 1] + 72*Global`u*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, -(1/Sqrt[Global`u]), 1] + 
        72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 1/Sqrt[Global`u], 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
          1/Sqrt[Global`u], 1] - 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          1, Global`u^(-1), 1] - 72*Global`u*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, Global`u^(-1), 1] + 
        72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, -(1/Sqrt[Global`u]), 
          1] + 72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
          -(1/Sqrt[Global`u]), 1] + 72*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, 1/Sqrt[Global`u], 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
          1/Sqrt[Global`u], 1] - 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          Global`u^(-1), 0, 1] - 72*Global`u*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 0, 1] - 
        72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1, 1] - 
        72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          1, 1] + 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          -(1/Sqrt[Global`u]), 1] + 72*Global`u*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), -(1/Sqrt[Global`u]), 1] + 
        72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
          1/Sqrt[Global`u], 1] + 72*Global`u*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1/Sqrt[Global`u], 1] + 
        72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 0, 
          1] + 72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 0, 1] + 72*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1, 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 1, 1] + 72*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), Global`u^(-1), 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), Global`u^(-1), 1] - 
        144*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          -(1/Sqrt[Global`u]), 1] - 144*Global`u*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), -(1/Sqrt[Global`u]), 
          1] - 144*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 1/Sqrt[Global`u], 1] - 144*Global`u*
         PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
          1/Sqrt[Global`u], 1] + 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], 0, 1] + 72*Global`u*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 0, 1] + 
        72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1, 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], 1, 1] + 72*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], Global`u^(-1), 1] + 
        72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], Global`u^(-1), 1] - 
        144*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          -(1/Sqrt[Global`u]), 1] - 144*Global`u*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], -(1/Sqrt[Global`u]), 
          1] - 144*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
          1/Sqrt[Global`u], 1] - 144*Global`u*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1/Sqrt[Global`u], 1] - 
        4*Pi^2*Log[2] - 4*Global`u*Pi^2*Log[2] + 54*PolyLogTools`G[0, 1, -1]*Log[2] - 
        54*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[2] + 48*Log[2]^2 + 48*Global`u*Log[2]^2 - 
        16*Global`u*Pi^2*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
            (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])] - 16*Global`u^2*Pi^2*
         Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
            (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])] - 
        16*Global`u*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
             (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])]^3 - 16*Global`u^2*
         Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/(1 + Sqrt[1 + (4*(1 - Global`u))/
                 Global`u])]^3 + 4*Pi^2*Log[1 - (1 - Global`u)^(-1)] + 
        4*Global`u*Pi^2*Log[1 - (1 - Global`u)^(-1)] - 8*Global`u*Pi^2*Log[1 - Global`u^(-1)] - 
        8*Global`u^2*Pi^2*Log[1 - Global`u^(-1)] + 24*Log[(1 - Global`u)^(-1)] + 
        24*Global`u*Log[(1 - Global`u)^(-1)] - 46*Pi^2*Log[(1 - Global`u)^(-1)] - 
        50*Global`u*Pi^2*Log[(1 - Global`u)^(-1)] - 4*Global`u^2*Pi^2*Log[(1 - Global`u)^(-1)] - 
        120*PolyLogTools`G[-1, -1, 1]*Log[(1 - Global`u)^(-1)] - 
        48*Global`u*PolyLogTools`G[-1, -1, 1]*Log[(1 - Global`u)^(-1)] + 
        72*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[(1 - Global`u)^(-1)] - 
        120*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)] - 
        48*Global`u*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)] + 
        72*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)] - 
        12*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[(1 - Global`u)^(-1)] + 
        12*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[(1 - Global`u)^(-1)] + 
        12*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)] - 
        36*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)] - 
        48*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[(1 - Global`u)^(-1)] - 
        108*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)] - 
        72*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)] + 
        36*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[(1 - Global`u)^(-1)] + 
        24*PolyLogTools`G[0, 1, Global`u]*Log[(1 - Global`u)^(-1)] + 
        24*Global`u*PolyLogTools`G[0, 1, Global`u]*Log[(1 - Global`u)^(-1)] + 
        60*Log[2]^2*Log[(1 - Global`u)^(-1)] + 24*Global`u*Log[2]^2*Log[(1 - Global`u)^(-1)] - 
        36*Global`u^2*Log[2]^2*Log[(1 - Global`u)^(-1)] - 12*Log[1 - (1 - Global`u)^(-1)]^2*
         Log[(1 - Global`u)^(-1)] - 12*Global`u*Log[1 - (1 - Global`u)^(-1)]^2*
         Log[(1 - Global`u)^(-1)] + 88*Log[(1 - Global`u)^(-1)]^2 + 
        88*Global`u*Log[(1 - Global`u)^(-1)]^2 + (24*I)*Pi*Log[(1 - Global`u)^(-1)]^2 + 
        (24*I)*Global`u*Pi*Log[(1 - Global`u)^(-1)]^2 + 6*Log[1 - (1 - Global`u)^(-1)]*
         Log[(1 - Global`u)^(-1)]^2 + 6*Global`u*Log[1 - (1 - Global`u)^(-1)]*
         Log[(1 - Global`u)^(-1)]^2 - 4*Log[(1 - Global`u)^(-1)]^3 - 
        4*Global`u*Log[(1 - Global`u)^(-1)]^3 + 792*Log[1 - Global`u] + 
        792*Global`u*Log[1 - Global`u] + (704*I)*Pi*Log[1 - Global`u] + 
        (704*I)*Global`u*Pi*Log[1 - Global`u] - 155*Pi^2*Log[1 - Global`u] - 
        140*Global`u*Pi^2*Log[1 - Global`u] + 15*Global`u^2*Pi^2*Log[1 - Global`u] + 
        36*PolyLogTools`G[-1, -1, 1]*Log[1 - Global`u] - 36*Global`u^2*PolyLogTools`G[-1, -1, 1]*
         Log[1 - Global`u] + 48*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1]*
         Log[1 - Global`u] + 48*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1]*
         Log[1 - Global`u] + 48*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1]*
         Log[1 - Global`u] + 48*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1]*
         Log[1 - Global`u] + 180*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u] + 
        48*Global`u*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u] - 
        132*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u] - 
        24*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u] - 
        36*Global`u*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u] - 
        12*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u] - 
        12*Global`u*PolyLogTools`G[0, 1, 1 - Global`u]*Log[1 - Global`u] - 
        12*Global`u^2*PolyLogTools`G[0, 1, 1 - Global`u]*Log[1 - Global`u] - 
        48*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] - 
        12*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] + 
        36*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] - 
        36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] - 
        96*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] - 
        60*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] - 
        24*PolyLogTools`G[0, 1, Global`u]*Log[1 - Global`u] - 
        12*Global`u*PolyLogTools`G[0, 1, Global`u]*Log[1 - Global`u] + 
        12*Global`u^2*PolyLogTools`G[0, 1, Global`u]*Log[1 - Global`u] - 
        24*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[1 - Global`u] - 
        12*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[1 - Global`u] + 
        12*Global`u^2*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[1 - Global`u] + 
        24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1]*Log[1 - Global`u] + 
        24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1]*Log[1 - Global`u] - 
        24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1]*Log[1 - Global`u] - 
        24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1]*Log[1 - Global`u] - 
        24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1]*Log[1 - Global`u] - 
        24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1]*Log[1 - Global`u] + 
        24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          (1 - Global`u)^(-1), 1]*Log[1 - Global`u] + 24*Global`u^2*
         PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
          (1 - Global`u)^(-1), 1]*Log[1 - Global`u] - 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
          1]*Log[1 - Global`u] - 24*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
          1]*Log[1 - Global`u] - 24*Global`u*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 1]*
         Log[1 - Global`u] - 24*Global`u^2*PolyLogTools`G[
          2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 1]*
         Log[1 - Global`u] + 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 1]*
         Log[1 - Global`u] + 24*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 1]*
         Log[1 - Global`u] - 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
          1]*Log[1 - Global`u] - 24*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
          1]*Log[1 - Global`u] - 24*Global`u*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 1]*
         Log[1 - Global`u] - 24*Global`u^2*PolyLogTools`G[
          2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 1]*
         Log[1 - Global`u] + 48*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1]*
         Log[1 - Global`u] + 48*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1]*
         Log[1 - Global`u] + 48*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1]*
         Log[1 - Global`u] + 48*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1]*
         Log[1 - Global`u] - 18*Log[2]^2*Log[1 - Global`u] + 18*Global`u^2*Log[2]^2*
         Log[1 - Global`u] - 24*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] - 
        24*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] + 12*Log[(1 - Global`u)^(-1)]^2*
         Log[1 - Global`u] + 12*Global`u*Log[(1 - Global`u)^(-1)]^2*Log[1 - Global`u] + 
        570*Log[1 - Global`u]^2 + 570*Global`u*Log[1 - Global`u]^2 + 
        (66*I)*Pi*Log[1 - Global`u]^2 + (66*I)*Global`u*Pi*Log[1 - Global`u]^2 + 
        6*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]^2 + 
        6*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]^2 + 128*Log[1 - Global`u]^3 + 
        130*Global`u*Log[1 - Global`u]^3 + 2*Global`u^2*Log[1 - Global`u]^3 + 
        72*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)] + 72*Global`u*PolyLogTools`G[0, 1, -1]*
         Log[-2/(-1 + Global`u)] - 18*Pi^2*Log[(-1 + Global`u)^(-1)] - 
        18*Global`u*Pi^2*Log[(-1 + Global`u)^(-1)] + 48*PolyLogTools`G[-1, -1, 1]*
         Log[(-1 + Global`u)^(-1)] + 48*Global`u*PolyLogTools`G[-1, -1, 1]*
         Log[(-1 + Global`u)^(-1)] - 72*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)^(-1)] - 
        72*Global`u*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)^(-1)] - 
        24*Log[2]^2*Log[(-1 + Global`u)^(-1)] - 24*Global`u*Log[2]^2*Log[(-1 + Global`u)^(-1)] - 
        88*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)] - 
        88*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)] - 
        24*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)] - 
        24*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)] + 
        44*Log[(-1 + Global`u)^(-1)]^2 + 44*Global`u*Log[(-1 + Global`u)^(-1)]^2 + 
        24*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]^2 + 
        24*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]^2 + 
        12*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]^2 + 12*Global`u*Log[1 - Global`u]*
         Log[(-1 + Global`u)^(-1)]^2 - 18*Log[(-1 + Global`u)^(-1)]^3 - 
        18*Global`u*Log[(-1 + Global`u)^(-1)]^3 + 3*Pi^2*Log[-1 + Global`u] - 
        3*Global`u^2*Pi^2*Log[-1 + Global`u] - 108*PolyLogTools`G[-1, -1, 1]*Log[-1 + Global`u] + 
        108*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[-1 + Global`u] - 120*PolyLogTools`G[0, 1, -1]*
         Log[-1 + Global`u] + 120*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u] + 
        54*Log[2]^2*Log[-1 + Global`u] - 54*Global`u^2*Log[2]^2*Log[-1 + Global`u] + 
        88*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] - 88*Global`u^2*Log[(1 - Global`u)^(-1)]*
         Log[-1 + Global`u] - 88*Log[1 - Global`u]*Log[-1 + Global`u] + 
        88*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u] + 48*Log[(1 - Global`u)^(-1)]*
         Log[1 - Global`u]*Log[-1 + Global`u] - 48*Global`u^2*Log[(1 - Global`u)^(-1)]*
         Log[1 - Global`u]*Log[-1 + Global`u] - 12*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] - 12*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] + 24*Log[1 - Global`u]*
         Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] - 24*Global`u^2*Log[1 - Global`u]*
         Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] + 12*Log[(-1 + Global`u)^(-1)]^2*
         Log[-1 + Global`u] - 12*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*Log[-1 + Global`u] + 
        88*Log[-1 + Global`u]^2 - 88*Global`u^2*Log[-1 + Global`u]^2 - 
        30*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]^2 + 30*Global`u^2*Log[(1 - Global`u)^(-1)]*
         Log[-1 + Global`u]^2 + 42*Log[1 - Global`u]*Log[-1 + Global`u]^2 - 
        42*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u]^2 - 6*Log[(-1 + Global`u)^(-1)]*
         Log[-1 + Global`u]^2 - 6*Global`u*Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u]^2 - 
        28*Log[-1 + Global`u]^3 + 28*Global`u^2*Log[-1 + Global`u]^3 - 
        108*PolyLogTools`G[0, 1, -1]*Log[2*(-1 + Global`u)] + 108*Global`u^2*
         PolyLogTools`G[0, 1, -1]*Log[2*(-1 + Global`u)] - 18*Pi^2*Log[Global`u^(-1)] - 
        2*Global`u*Pi^2*Log[Global`u^(-1)] + 16*Global`u^2*Pi^2*Log[Global`u^(-1)] + 
        264*PolyLogTools`G[-1, -1, 1]*Log[Global`u^(-1)] + 216*Global`u*PolyLogTools`G[-1, -1, 1]*
         Log[Global`u^(-1)] - 48*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[Global`u^(-1)] - 
        216*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)] - 168*Global`u*PolyLogTools`G[0, 1, -1]*
         Log[Global`u^(-1)] + 48*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)] + 
        12*Global`u*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 
        12*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 
        24*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)] + 
        24*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)] - 
        24*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)] - 
        24*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)] + 
        12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)] + 
        12*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)] - 
        132*Log[2]^2*Log[Global`u^(-1)] - 108*Global`u*Log[2]^2*Log[Global`u^(-1)] + 
        24*Global`u^2*Log[2]^2*Log[Global`u^(-1)] + 24*Global`u*Log[1 - Global`u^(-1)]^2*
         Log[Global`u^(-1)] + 24*Global`u^2*Log[1 - Global`u^(-1)]^2*Log[Global`u^(-1)] - 
        88*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] - 
        88*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 220*Log[1 - Global`u]*
         Log[Global`u^(-1)] + 308*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)] + 
        88*Global`u^2*Log[1 - Global`u]*Log[Global`u^(-1)] + (36*I)*Pi*Log[1 - Global`u]*
         Log[Global`u^(-1)] + (36*I)*Global`u*Pi*Log[1 - Global`u]*Log[Global`u^(-1)] - 
        48*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[Global`u^(-1)] - 
        48*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[Global`u^(-1)] + 
        60*Log[1 - Global`u]^2*Log[Global`u^(-1)] + 72*Global`u*Log[1 - Global`u]^2*
         Log[Global`u^(-1)] + 12*Global`u^2*Log[1 - Global`u]^2*Log[Global`u^(-1)] - 
        24*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] - 
        24*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] + 
        24*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] - 
        24*Global`u^2*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] + 
        24*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)] + 12*Global`u*Log[(-1 + Global`u)^(-1)]^2*
         Log[Global`u^(-1)] - 12*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)] + 
        12*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 
        24*Global`u*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 
        12*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 
        108*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 96*Global`u*Log[1 - Global`u]*
         Log[-1 + Global`u]*Log[Global`u^(-1)] - 12*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u]*
         Log[Global`u^(-1)] - 48*Log[-1 + Global`u]^2*Log[Global`u^(-1)] - 
        36*Global`u*Log[-1 + Global`u]^2*Log[Global`u^(-1)] + 12*Global`u^2*Log[-1 + Global`u]^2*
         Log[Global`u^(-1)] + 110*Log[Global`u^(-1)]^2 + 198*Global`u*Log[Global`u^(-1)]^2 + 
        88*Global`u^2*Log[Global`u^(-1)]^2 + (18*I)*Pi*Log[Global`u^(-1)]^2 + 
        (18*I)*Global`u*Pi*Log[Global`u^(-1)]^2 - 12*Global`u*Log[1 - Global`u^(-1)]*
         Log[Global`u^(-1)]^2 - 12*Global`u^2*Log[1 - Global`u^(-1)]*Log[Global`u^(-1)]^2 + 
        48*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2 + 30*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[Global`u^(-1)]^2 - 18*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2 + 
        78*Log[1 - Global`u]*Log[Global`u^(-1)]^2 + 126*Global`u*Log[1 - Global`u]*
         Log[Global`u^(-1)]^2 + 48*Global`u^2*Log[1 - Global`u]*Log[Global`u^(-1)]^2 - 
        12*Log[Global`u^(-1)]^3 + 12*Global`u*Log[Global`u^(-1)]^3 + 
        24*Global`u^2*Log[Global`u^(-1)]^3 - 8*Global`u*Pi^2*Log[(1 - Global`u)/Global`u] - 
        8*Global`u^2*Pi^2*Log[(1 - Global`u)/Global`u] - 24*Global`u*
         Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/(1 + Sqrt[1 + (4*(1 - Global`u))/
                 Global`u])]^2*Log[(1 - Global`u)/Global`u] - 24*Global`u^2*
         Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/(1 + Sqrt[1 + (4*(1 - Global`u))/
                 Global`u])]^2*Log[(1 - Global`u)/Global`u] - 
        12*Global`u*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
            (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])]*Log[(1 - Global`u)/Global`u]^2 - 
        12*Global`u^2*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
            (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])]*Log[(1 - Global`u)/Global`u]^2 - 
        2*Global`u*Log[(1 - Global`u)/Global`u]^3 - 2*Global`u^2*Log[(1 - Global`u)/Global`u]^3 - 
        110*Pi^2*Log[(-1 + Global`u)/Global`u] - 104*Global`u*Pi^2*Log[(-1 + Global`u)/Global`u] + 
        6*Global`u^2*Pi^2*Log[(-1 + Global`u)/Global`u] + 48*PolyLogTools`G[-1, -1, 1]*
         Log[(-1 + Global`u)/Global`u] + 48*Global`u*PolyLogTools`G[-1, -1, 1]*
         Log[(-1 + Global`u)/Global`u] - 72*Global`u*PolyLogTools`G[0, 1, -1]*
         Log[(-1 + Global`u)/Global`u] - 72*Global`u^2*PolyLogTools`G[0, 1, -1]*
         Log[(-1 + Global`u)/Global`u] + 12*PolyLogTools`G[0, 1, Global`u^(-1)]*
         Log[(-1 + Global`u)/Global`u] + 12*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*
         Log[(-1 + Global`u)/Global`u] + 72*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[(-1 + Global`u)/Global`u] + 72*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
         Log[(-1 + Global`u)/Global`u] - 24*Log[2]^2*Log[(-1 + Global`u)/Global`u] - 
        24*Global`u*Log[2]^2*Log[(-1 + Global`u)/Global`u] + 24*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 64*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 88*Global`u^2*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] + 156*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + 
        244*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + 
        88*Global`u^2*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + 
        (60*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + (60*I)*Global`u*Pi*
         Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 24*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 24*Global`u^2*Log[(1 - Global`u)^(-1)]*
         Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 108*Log[1 - Global`u]^2*
         Log[(-1 + Global`u)/Global`u] - 96*Global`u*Log[1 - Global`u]^2*
         Log[(-1 + Global`u)/Global`u] + 12*Global`u^2*Log[1 - Global`u]^2*
         Log[(-1 + Global`u)/Global`u] + 36*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] + 
        36*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 84*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 60*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] + 24*Global`u^2*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 42*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u] - 48*Global`u*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u] - 6*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*
         Log[(-1 + Global`u)/Global`u] - 12*Global`u*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*
         Log[(-1 + Global`u)/Global`u] - 12*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*
         Log[(-1 + Global`u)/Global`u] - 6*Global`u*Log[-1 + Global`u]^2*
         Log[(-1 + Global`u)/Global`u] - 6*Global`u^2*Log[-1 + Global`u]^2*
         Log[(-1 + Global`u)/Global`u] + 72*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
         Log[(-1 + Global`u)/Global`u] + 48*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 24*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
         Log[(-1 + Global`u)/Global`u] - 36*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] - 
        36*Global`u*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] - 
        66*Log[(-1 + Global`u)/Global`u]^2 - 154*Global`u*Log[(-1 + Global`u)/Global`u]^2 - 
        88*Global`u^2*Log[(-1 + Global`u)/Global`u]^2 - (30*I)*Pi*Log[(-1 + Global`u)/Global`u]^2 - 
        (30*I)*Global`u*Pi*Log[(-1 + Global`u)/Global`u]^2 - 24*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u]^2 + 18*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u]^2 + 42*Global`u^2*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u]^2 + 114*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2 + 
        114*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2 - 
        12*Global`u*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2 - 
        12*Global`u^2*Log[Global`u^(-1)]*Log[(-1 + Global`u)/Global`u]^2 - 
        70*Log[(-1 + Global`u)/Global`u]^3 - 58*Global`u*Log[(-1 + Global`u)/Global`u]^3 + 
        12*Global`u^2*Log[(-1 + Global`u)/Global`u]^3 - 36*Log[(1 - Global`u)^(-1)]*
         Log[-Global`u]^2 - 42*Global`u*Log[(1 - Global`u)^(-1)]*Log[-Global`u]^2 - 
        6*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-Global`u]^2 + 1176*Log[Global`u] + 
        744*Global`u*Log[Global`u] - 384*Global`u^2*Log[Global`u] + (1056*I)*Pi*Log[Global`u] + 
        (1056*I)*Global`u*Pi*Log[Global`u] - 248*Pi^2*Log[Global`u] - 
        220*Global`u*Pi^2*Log[Global`u] + 28*Global`u^2*Pi^2*Log[Global`u] + 
        24*PolyLogTools`G[-1, -1, 1]*Log[Global`u] + 24*Global`u*PolyLogTools`G[-1, -1, 1]*
         Log[Global`u] + 216*PolyLogTools`G[0, 1, -1]*Log[Global`u] + 
        144*Global`u*PolyLogTools`G[0, 1, -1]*Log[Global`u] - 72*Global`u^2*
         PolyLogTools`G[0, 1, -1]*Log[Global`u] + 12*Global`u*PolyLogTools`G[0, 1, 1 - Global`u]*
         Log[Global`u] + 12*Global`u^2*PolyLogTools`G[0, 1, 1 - Global`u]*Log[Global`u] + 
        84*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] + 
        144*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] + 
        60*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] - 
        132*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
        192*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
        60*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
        12*Global`u*PolyLogTools`G[0, 1, Global`u]*Log[Global`u] - 
        12*Global`u^2*PolyLogTools`G[0, 1, Global`u]*Log[Global`u] - 
        72*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] - 
        36*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] + 
        36*Global`u^2*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] - 
        48*PolyLogTools`G[0, 1, Global`u/(1 + Global`u)]*Log[Global`u] - 
        48*Global`u*PolyLogTools`G[0, 1, Global`u/(1 + Global`u)]*Log[Global`u] - 
        72*PolyLogTools`G[Global`u^(-1), 1, 1]*Log[Global`u] - 
        72*Global`u*PolyLogTools`G[Global`u^(-1), 1, 1]*Log[Global`u] + 
        72*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1]*Log[Global`u] + 
        72*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1]*Log[Global`u] + 
        72*PolyLogTools`G[1/Sqrt[Global`u], 1, 1]*Log[Global`u] + 
        72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1, 1]*Log[Global`u] - 
        72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1]*
         Log[Global`u] - 72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          Global`u^(-1), 1]*Log[Global`u] + 72*PolyLogTools`G[
          2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1]*Log[Global`u] + 
        72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 1]*Log[Global`u] + 
        72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1]*
         Log[Global`u] + 72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], 1]*Log[Global`u] - 
        72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1]*
         Log[Global`u] - 72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          Global`u^(-1), 1]*Log[Global`u] + 72*PolyLogTools`G[
          2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1]*Log[Global`u] + 
        72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          -(1/Sqrt[Global`u]), 1]*Log[Global`u] + 
        72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1]*
         Log[Global`u] + 72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
          1/Sqrt[Global`u], 1]*Log[Global`u] - 12*Log[2]^2*Log[Global`u] - 
        12*Global`u*Log[2]^2*Log[Global`u] + 176*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
        176*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u] + (48*I)*Pi*Log[(1 - Global`u)^(-1)]*
         Log[Global`u] + (48*I)*Global`u*Pi*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
        36*Log[(1 - Global`u)^(-1)]^2*Log[Global`u] + 36*Global`u*Log[(1 - Global`u)^(-1)]^2*
         Log[Global`u] + 1008*Log[1 - Global`u]*Log[Global`u] + 1104*Global`u*Log[1 - Global`u]*
         Log[Global`u] + (288*I)*Pi*Log[1 - Global`u]*Log[Global`u] + 
        (288*I)*Global`u*Pi*Log[1 - Global`u]*Log[Global`u] + 24*Log[(1 - Global`u)^(-1)]*
         Log[1 - Global`u]*Log[Global`u] + 12*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
         Log[Global`u] - 12*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[Global`u] + 
        186*Log[1 - Global`u]^2*Log[Global`u] + 186*Global`u*Log[1 - Global`u]^2*Log[Global`u] - 
        24*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[Global`u] - 
        24*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[Global`u] + 
        12*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u] + 12*Global`u*Log[(-1 + Global`u)^(-1)]^2*
         Log[Global`u] + 24*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u] - 
        24*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u] - 
        24*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u] + 24*Global`u^2*Log[1 - Global`u]*
         Log[-1 + Global`u]*Log[Global`u] + 24*Log[-1 + Global`u]^2*Log[Global`u] - 
        24*Global`u^2*Log[-1 + Global`u]^2*Log[Global`u] - 24*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[Global`u^(-1)]*Log[Global`u] - 24*Global`u^2*Log[(1 - Global`u)^(-1)]*
         Log[Global`u^(-1)]*Log[Global`u] + 132*Log[1 - Global`u]*Log[Global`u^(-1)]*
         Log[Global`u] + 168*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] + 
        36*Global`u^2*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] + 
        66*Log[Global`u^(-1)]^2*Log[Global`u] + 96*Global`u*Log[Global`u^(-1)]^2*Log[Global`u] + 
        30*Global`u^2*Log[Global`u^(-1)]^2*Log[Global`u] - 24*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 24*Global`u^2*Log[(1 - Global`u)^(-1)]*
         Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 84*Log[1 - Global`u]*
         Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 120*Global`u*Log[1 - Global`u]*
         Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 36*Global`u^2*Log[1 - Global`u]*
         Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 42*Log[(-1 + Global`u)/Global`u]^2*
         Log[Global`u] - 72*Global`u*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] - 
        30*Global`u^2*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] + 72*Log[(1 - Global`u)^(-1)]*
         Log[-Global`u]*Log[Global`u] + 84*Global`u*Log[(1 - Global`u)^(-1)]*Log[-Global`u]*
         Log[Global`u] + 12*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-Global`u]*Log[Global`u] + 
        1016*Log[Global`u]^2 + 744*Global`u*Log[Global`u]^2 - 176*Global`u^2*Log[Global`u]^2 + 
        (264*I)*Pi*Log[Global`u]^2 + (264*I)*Global`u*Pi*Log[Global`u]^2 + 
        54*Log[(1 - Global`u)^(-1)]*Log[Global`u]^2 + 54*Global`u*Log[(1 - Global`u)^(-1)]*
         Log[Global`u]^2 + 276*Log[1 - Global`u]*Log[Global`u]^2 + 294*Global`u*Log[1 - Global`u]*
         Log[Global`u]^2 + 18*Global`u^2*Log[1 - Global`u]*Log[Global`u]^2 + 188*Log[Global`u]^3 + 
        164*Global`u*Log[Global`u]^3 - 24*Global`u^2*Log[Global`u]^3 - 
        2*Pi^2*Log[Global`u/(-1 + Global`u)] + 34*Global`u*Pi^2*Log[Global`u/(-1 + Global`u)] + 
        36*Global`u^2*Pi^2*Log[Global`u/(-1 + Global`u)] + 24*PolyLogTools`G[0, 1, -1]*
         Log[Global`u/(-1 + Global`u)] - 24*Global`u^2*PolyLogTools`G[0, 1, -1]*
         Log[Global`u/(-1 + Global`u)] - 12*Global`u*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
         Log[Global`u/(-1 + Global`u)] - 12*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
         Log[Global`u/(-1 + Global`u)] + 6*Log[(1 - Global`u)^(-1)]^2*
         Log[Global`u/(-1 + Global`u)] - 6*Global`u^2*Log[(1 - Global`u)^(-1)]^2*
         Log[Global`u/(-1 + Global`u)] - 12*Global`u*Log[1 - Global`u]^2*
         Log[Global`u/(-1 + Global`u)] - 12*Global`u^2*Log[1 - Global`u]^2*
         Log[Global`u/(-1 + Global`u)] + 6*Global`u*Log[-Global`u^(-1)]^2*
         Log[Global`u/(-1 + Global`u)] + 6*Global`u^2*Log[-Global`u^(-1)]^2*
         Log[Global`u/(-1 + Global`u)] - 12*Global`u*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*
         Log[Global`u/(-1 + Global`u)] - 12*Global`u^2*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*
         Log[Global`u/(-1 + Global`u)] - 48*Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 
        128*Global`u*Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 176*Global`u^2*Log[Global`u]*
         Log[Global`u/(-1 + Global`u)] - 24*Log[1 - Global`u]*Log[Global`u]*
         Log[Global`u/(-1 + Global`u)] - 36*Global`u*Log[1 - Global`u]*Log[Global`u]*
         Log[Global`u/(-1 + Global`u)] - 12*Global`u^2*Log[1 - Global`u]*Log[Global`u]*
         Log[Global`u/(-1 + Global`u)] - 12*Global`u*Log[Global`u]^2*
         Log[Global`u/(-1 + Global`u)] - 12*Global`u^2*Log[Global`u]^2*
         Log[Global`u/(-1 + Global`u)] + 24*Log[Global`u/(-1 + Global`u)]^2 + 
        64*Global`u*Log[Global`u/(-1 + Global`u)]^2 + 88*Global`u^2*Log[Global`u/(-1 + Global`u)]^
          2 - 12*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^2 - 
        6*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^2 + 
        6*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u/(-1 + Global`u)]^2 - 
        36*Global`u*Log[Global`u]*Log[Global`u/(-1 + Global`u)]^2 - 36*Global`u^2*Log[Global`u]*
         Log[Global`u/(-1 + Global`u)]^2 + 30*Global`u*Log[Global`u/(-1 + Global`u)]^3 + 
        30*Global`u^2*Log[Global`u/(-1 + Global`u)]^3 + 16*Pi^2*Log[(1 + Global`u)^(-1)] + 
        16*Global`u*Pi^2*Log[(1 + Global`u)^(-1)] + 24*Log[Global`u]*Log[(1 + Global`u)^(-1)]^2 + 
        24*Global`u*Log[Global`u]*Log[(1 + Global`u)^(-1)]^2 + 16*Log[(1 + Global`u)^(-1)]^3 + 
        16*Global`u*Log[(1 + Global`u)^(-1)]^3 - 48*Log[Global`u]*Log[Global`u/(1 + Global`u)] + 
        48*Global`u*Log[Global`u]*Log[Global`u/(1 + Global`u)] + 
        24*Log[Global`u/(1 + Global`u)]^2 - 24*Global`u*Log[Global`u/(1 + Global`u)]^2 - 
        48*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1]*Log[1 + Global`u] - 
        48*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1]*Log[1 + Global`u] - 
        48*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1]*Log[1 + Global`u] - 
        48*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1]*Log[1 + Global`u] - 
        48*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1]*Log[1 + Global`u] - 
        48*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1]*Log[1 + Global`u] - 
        48*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1]*Log[1 + Global`u] - 
        48*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1]*Log[1 + Global`u] + 
        48*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1]*Log[(1 + Global`u)/(1 - Global`u)] - 
        48*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1]*
         Log[(1 + Global`u)/(1 - Global`u)] - 48*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1]*
         Log[(1 + Global`u)/(1 - Global`u)] + 48*Global`u*PolyLogTools`G[
          (1 + Global`u)/(1 - Global`u), 1]*Log[(1 + Global`u)/(1 - Global`u)] - 
        12*Log[Global`u]*PolyLog[2, 1 - (1 - Global`u)^(-1)] - 12*Global`u*Log[Global`u]*
         PolyLog[2, 1 - (1 - Global`u)^(-1)] + 24*Global`u*Log[1 - Global`u]*
         PolyLog[2, 1 - Global`u^(-1)] + 24*Global`u^2*Log[1 - Global`u]*
         PolyLog[2, 1 - Global`u^(-1)] + 12*Log[(1 - Global`u)^(-1)]*
         PolyLog[2, (1 - Global`u)^(-1)] + 12*Global`u*Log[(1 - Global`u)^(-1)]*
         PolyLog[2, (1 - Global`u)^(-1)] + 24*Global`u*Log[1 - Global`u]*PolyLog[2, 1 - Global`u] + 
        24*Global`u^2*Log[1 - Global`u]*PolyLog[2, 1 - Global`u] + 
        24*Log[2]*PolyLog[2, (4*Global`u)/(1 + Global`u)^2] + 24*Global`u*Log[2]*
         PolyLog[2, (4*Global`u)/(1 + Global`u)^2] - 24*Global`u*
         PolyLog[3, -((1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
            (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u]))] - 24*Global`u^2*
         PolyLog[3, -((1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
            (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u]))] - 12*PolyLog[3, (1 - Global`u)^(-1)] - 
        12*Global`u*PolyLog[3, (1 - Global`u)^(-1)] - 48*Global`u*PolyLog[3, 1 - Global`u] - 
        48*Global`u^2*PolyLog[3, 1 - Global`u] - 24*Global`u*PolyLog[3, Global`u^(-1)] - 
        24*Global`u^2*PolyLog[3, Global`u^(-1)] + 3622*Zeta[3] + 1916*Global`u*Zeta[3] - 
        1706*Global`u^2*Zeta[3])/(4*(-1 + Global`u)*Global`u*(1 + Global`u))|>, 
   "Series" -> (3*(-2 + Global`u))/((-1 + Global`u)*Global`u*Global`\[Epsilon]^6) - 
     (2*(-22 - (6*I)*Pi + 11*Global`u - 6*Log[1 - Global`u] - 9*Log[Global`u] + 
        3*Global`u*Log[Global`u]))/((-1 + Global`u)*Global`u*Global`\[Epsilon]^5) + 
     (-384 - (352*I)*Pi + 84*Pi^2 + 192*Global`u - 18*Pi^2*Global`u - 96*PolyLogTools`G[0, 1, -1] + 
       48*Global`u*PolyLogTools`G[0, 1, -1] + 24*Global`u*PolyLogTools`G[0, 1, 
         (1 - Global`u)^(-1)] - 18*PolyLogTools`G[0, 1, Global`u^(-1)] - 
       24*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)] + 
       30*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       24*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] + 
       24*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 12*Log[(1 - Global`u)^(-1)]^2 - 
       352*Log[1 - Global`u] - (96*I)*Pi*Log[1 - Global`u] - 81*Log[1 - Global`u]^2 + 
       12*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)] - 6*Log[(-1 + Global`u)^(-1)]^2 - 
       12*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] + 12*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[-1 + Global`u] + 12*Log[1 - Global`u]*Log[-1 + Global`u] - 
       12*Global`u*Log[1 - Global`u]*Log[-1 + Global`u] - 12*Log[-1 + Global`u]^2 + 
       12*Global`u*Log[-1 + Global`u]^2 + 12*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] - 
       30*Log[1 - Global`u]*Log[Global`u^(-1)] - 12*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)] - 
       15*Log[Global`u^(-1)]^2 - 12*Global`u*Log[Global`u^(-1)]^2 + 
       12*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] - 
       18*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] - 12*Global`u*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] + 9*Log[(-1 + Global`u)/Global`u]^2 + 
       12*Global`u*Log[(-1 + Global`u)/Global`u]^2 - 528*Log[Global`u] - (144*I)*Pi*Log[Global`u] + 
       176*Global`u*Log[Global`u] - 24*Log[(1 - Global`u)^(-1)]*Log[Global`u] - 
       144*Log[1 - Global`u]*Log[Global`u] - 132*Log[Global`u]^2 + 24*Global`u*Log[Global`u]^2 + 
       24*Global`u*Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 
       12*Global`u*Log[Global`u/(-1 + Global`u)]^2)/(4*(-1 + Global`u)*Global`u*Global`\[Epsilon]^4) + 
     (256 + (768*I)*Pi - 600*Pi^2 - (140*I)*Pi^3 + 128*Global`u + (768*I)*Pi*Global`u - 
       484*Pi^2*Global`u - (140*I)*Pi^3*Global`u - 128*Global`u^2 + 132*Pi^2*Global`u^2 + 
       2*Pi^2*PolyLogTools`G[-((1 - Global`u)/Global`u), 1] + 2*Pi^2*Global`u*
        PolyLogTools`G[-((1 - Global`u)/Global`u), 1] - 12*PolyLogTools`G[(1 - Global`u)^(-1), 1]*
        PolyLogTools`G[1 - Global`u, 1]*PolyLogTools`G[-((1 - Global`u)/Global`u), 1] - 
       12*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1]*PolyLogTools`G[1 - Global`u, 1]*
        PolyLogTools`G[-((1 - Global`u)/Global`u), 1] - 2*Pi^2*Global`u*
        PolyLogTools`G[Global`u/(-1 + Global`u), 1] - 2*Pi^2*Global`u^2*
        PolyLogTools`G[Global`u/(-1 + Global`u), 1] + 12*Global`u*PolyLogTools`G[Global`u^(-1), 1]*
        PolyLogTools`G[Global`u, 1]*PolyLogTools`G[Global`u/(-1 + Global`u), 1] + 
       12*Global`u^2*PolyLogTools`G[Global`u^(-1), 1]*PolyLogTools`G[Global`u, 1]*
        PolyLogTools`G[Global`u/(-1 + Global`u), 1] + 
       24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1] - 
       24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1] - 
       24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1] + 
       24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1] - 
       96*PolyLogTools`G[-1, -1, 1] - 96*Global`u*PolyLogTools`G[-1, -1, 1] + 
       560*PolyLogTools`G[0, 1, -1] + (96*I)*Pi*PolyLogTools`G[0, 1, -1] + 
       304*Global`u*PolyLogTools`G[0, 1, -1] + (96*I)*Pi*Global`u*PolyLogTools`G[0, 1, -1] - 
       352*Global`u^2*PolyLogTools`G[0, 1, -1] - 48*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] - 
       128*Global`u*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] - 
       176*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)] + 
       132*PolyLogTools`G[0, 1, Global`u^(-1)] + (60*I)*Pi*PolyLogTools`G[0, 1, Global`u^(-1)] + 
       308*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)] + (60*I)*Pi*Global`u*
        PolyLogTools`G[0, 1, Global`u^(-1)] + 176*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)] - 
       220*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       (36*I)*Pi*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       396*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       (36*I)*Pi*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       176*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u] - 
       176*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 
       (48*I)*Pi*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 
       176*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 
       (48*I)*Pi*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)] - 
       48*PolyLogTools`G[0, 1, (1 + Global`u)^(-1)] + 48*Global`u*PolyLogTools`G[0, 1, 
         (1 + Global`u)^(-1)] - 12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*
        PolyLogTools`G[0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
         (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
         (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
         (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] - 
       12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
       12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
         (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
       12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
         (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] - 
       12*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (1 + Sqrt[(4 - 3*Global`u)/Global`u])/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] - 
       12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (1 + Sqrt[(4 - 3*Global`u)/Global`u])/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
       12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
         (1 + Sqrt[(4 - 3*Global`u)/Global`u])/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
       12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 
         (1 + Sqrt[(4 - 3*Global`u)/Global`u])/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
       12*PolyLogTools`G[(1 - Global`u)^(-1), 1]*PolyLogTools`G[0, 1 - Global`u, 1] + 
       12*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1]*PolyLogTools`G[0, 1 - Global`u, 1] + 
       12*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[0, 1 - Global`u, 1] + 
       12*Global`u*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[0, 1 - Global`u, 
         1] + 12*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*
        PolyLogTools`G[0, 1 - Global`u, 1] + 12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 
         1]*PolyLogTools`G[0, 1 - Global`u, 1] - 12*Global`u*PolyLogTools`G[
         Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 1 - Global`u, 1] - 
       12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, 1 - Global`u, 
         1] - 144*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*PolyLogTools`G[0, Global`u^(-1), 1] - 
       144*Global`u*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*PolyLogTools`G[0, Global`u^(-1), 1] + 
       72*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, Global`u^(-1), 1] + 
       72*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, Global`u^(-1), 
         1] - 12*Global`u*PolyLogTools`G[Global`u^(-1), 1]*PolyLogTools`G[0, Global`u, 1] - 
       12*Global`u^2*PolyLogTools`G[Global`u^(-1), 1]*PolyLogTools`G[0, Global`u, 1] - 
       12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, Global`u, 1] - 
       12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[0, Global`u, 1] + 
       72*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*PolyLogTools`G[0, 
         (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] + 
       72*Global`u*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*PolyLogTools`G[0, 
         (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
       72*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
       72*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] + 
       72*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*PolyLogTools`G[0, 
         (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] + 
       72*Global`u*PolyLogTools`G[-(-1 + Global`u)^(-1), 1]*PolyLogTools`G[0, 
         (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
       72*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
       72*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] + 
       12*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
          (-1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1] + 
       12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
          (-1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1] + 
       12*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
          (1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1] + 
       12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 1]*PolyLogTools`G[0, 
         (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
          (1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1] + 
       12*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1] + 
       12*Global`u*PolyLogTools`G[-((1 - Global`u)/Global`u), 1]*
        PolyLogTools`G[(1 - Global`u)^(-1), 1, 1] + 12*PolyLogTools`G[-((1 - Global`u)/Global`u), 
         1]*PolyLogTools`G[1 - Global`u, 1, 1] + 12*Global`u*PolyLogTools`G[
         -((1 - Global`u)/Global`u), 1]*PolyLogTools`G[1 - Global`u, 1, 1] - 
       24*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u^(-1), 1, 
         1] - 24*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*
        PolyLogTools`G[Global`u^(-1), 1, 1] + 12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 
         1]*PolyLogTools`G[Global`u^(-1), (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
       12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u^(-1), 
         (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
       12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u^(-1), 
         (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
       12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u^(-1), 
         (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u, 1, 1] - 
       12*Global`u^2*PolyLogTools`G[Global`u/(-1 + Global`u), 1]*PolyLogTools`G[Global`u, 1, 1] - 
       24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -1, 1] + 
       24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -1, 1] - 
       24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1] + 
       24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1] + 
       24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -((1 + Global`u)/(1 - Global`u)), 1] - 
       24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 
         -((1 + Global`u)/(1 - Global`u)), 1] + 24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 
         (1 + Global`u)/(1 - Global`u), 1] - 24*Global`u*PolyLogTools`G[
         -((1 + Global`u)/(1 - Global`u)), (1 + Global`u)/(1 - Global`u), 1] + 
       24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -1, 1] - 
       24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -1, 1] + 
       24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1] - 
       24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1] - 
       24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -((1 + Global`u)/(1 - Global`u)), 1] + 
       24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -((1 + Global`u)/(1 - Global`u)), 
         1] - 24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), (1 + Global`u)/(1 - Global`u), 1] + 
       24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), (1 + Global`u)/(1 - Global`u), 
         1] - 18*PolyLogTools`G[-1, 0, -1, 1] - 72*Global`u*PolyLogTools`G[-1, 0, -1, 1] - 
       54*Global`u^2*PolyLogTools`G[-1, 0, -1, 1] + 
       24*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), -1, 1] + 
       24*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), -1, 1] + 
       24*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1, 1] + 
       24*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1, 1] - 
       24*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), -((1 + Global`u)/(1 - Global`u)), 
         1] - 24*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 
         -((1 + Global`u)/(1 - Global`u)), 1] - 24*PolyLogTools`G[-1, 
         -((1 + Global`u)/(1 - Global`u)), (1 + Global`u)/(1 - Global`u), 1] - 
       24*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 
         (1 + Global`u)/(1 - Global`u), 1] + 24*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 
         -1, 1] + 24*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), -1, 1] + 
       24*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1, 1] + 
       24*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1, 1] - 
       24*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), -((1 + Global`u)/(1 - Global`u)), 1] - 
       24*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 
         -((1 + Global`u)/(1 - Global`u)), 1] - 24*PolyLogTools`G[-1, 
         (1 + Global`u)/(1 - Global`u), (1 + Global`u)/(1 - Global`u), 1] - 
       24*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), (1 + Global`u)/(1 - Global`u), 
         1] + 18*PolyLogTools`G[0, 0, 1, -1] + 72*Global`u*PolyLogTools`G[0, 0, 1, -1] + 
       54*Global`u^2*PolyLogTools`G[0, 0, 1, -1] - 120*Global`u*PolyLogTools`G[0, 0, 1, 
         (1 - Global`u)^(-1)] - 120*Global`u^2*PolyLogTools`G[0, 0, 1, (1 - Global`u)^(-1)] + 
       24*PolyLogTools`G[0, 0, 1, 1 - Global`u] + 12*Global`u*PolyLogTools`G[0, 0, 1, 
         1 - Global`u] - 12*Global`u^2*PolyLogTools`G[0, 0, 1, 1 - Global`u] + 
       210*PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 138*Global`u*PolyLogTools`G[0, 0, 1, 
         Global`u^(-1)] - 72*Global`u^2*PolyLogTools`G[0, 0, 1, Global`u^(-1)] + 
       180*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u] + 
       108*Global`u*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u] - 
       72*Global`u^2*PolyLogTools`G[0, 0, 1, (-1 + Global`u)/Global`u] + 
       48*PolyLogTools`G[0, 0, 1, Global`u] + 36*Global`u*PolyLogTools`G[0, 0, 1, Global`u] - 
       12*Global`u^2*PolyLogTools`G[0, 0, 1, Global`u] - 12*Global`u*PolyLogTools`G[0, 0, 1, 
         Global`u/(-1 + Global`u)] - 12*Global`u^2*PolyLogTools`G[0, 0, 1, 
         Global`u/(-1 + Global`u)] - 96*PolyLogTools`G[0, 0, 1, Global`u/(1 + Global`u)] - 
       96*Global`u*PolyLogTools`G[0, 0, 1, Global`u/(1 + Global`u)] + 
       24*Global`u*PolyLogTools`G[0, 0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
       24*Global`u^2*PolyLogTools`G[0, 0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
       24*Global`u*PolyLogTools`G[0, 0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
       24*Global`u^2*PolyLogTools`G[0, 0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
       24*Global`u*PolyLogTools`G[0, 0, (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/
          (1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 24*Global`u^2*PolyLogTools`G[0, 0, 
         (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/(1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 
       24*Global`u*PolyLogTools`G[0, 0, (1 + Sqrt[(4 - 3*Global`u)/Global`u])/
          (-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] + 24*Global`u^2*PolyLogTools`G[0, 0, 
         (1 + Sqrt[(4 - 3*Global`u)/Global`u])/(-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1] - 
       24*PolyLogTools`G[0, 0, 1 - Global`u, 1] - 48*Global`u*PolyLogTools`G[0, 0, 1 - Global`u, 
         1] - 24*Global`u^2*PolyLogTools`G[0, 0, 1 - Global`u, 1] + 
       432*PolyLogTools`G[0, 0, Global`u^(-1), 1] + 432*Global`u*PolyLogTools`G[0, 0, 
         Global`u^(-1), 1] + 24*Global`u*PolyLogTools`G[0, 0, Global`u, 1] + 
       24*Global`u^2*PolyLogTools`G[0, 0, Global`u, 1] - 
       288*PolyLogTools`G[0, 0, (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
              (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^
                4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
       288*Global`u*PolyLogTools`G[0, 0, (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
              (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^
                4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
       288*PolyLogTools`G[0, 0, (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
              (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^
                4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] - 
       288*Global`u*PolyLogTools`G[0, 0, (-2 + Global`u + 
           Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), 1] + 
       24*PolyLogTools`G[0, 1, 1, (1 - Global`u)^(-1)] + 24*Global`u*PolyLogTools`G[0, 1, 1, 
         (1 - Global`u)^(-1)] - 48*Global`u*PolyLogTools`G[0, 1, 1, Global`u^(-1)] - 
       48*Global`u^2*PolyLogTools`G[0, 1, 1, Global`u^(-1)] - 
       12*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1] + 
       12*Global`u*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1] + 
       24*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1), 1] - 
       24*Global`u*PolyLogTools`G[0, 1, -(1/Sqrt[1 - Global`u]), 1] - 
       24*Global`u^2*PolyLogTools`G[0, 1, -(1/Sqrt[1 - Global`u]), 1] - 
       24*Global`u*PolyLogTools`G[0, 1, 1/Sqrt[1 - Global`u], 1] - 
       24*Global`u^2*PolyLogTools`G[0, 1, 1/Sqrt[1 - Global`u], 1] - 
       12*PolyLogTools`G[0, 1, 1 - Global`u, 1] + 60*Global`u*PolyLogTools`G[0, 1, 1 - Global`u, 
         1] + 72*Global`u^2*PolyLogTools`G[0, 1, 1 - Global`u, 1] - 
       12*Global`u*PolyLogTools`G[0, 1, -(-1 + Global`u)^(-1), 1] - 
       12*Global`u^2*PolyLogTools`G[0, 1, -(-1 + Global`u)^(-1), 1] - 
       72*PolyLogTools`G[0, 1, Global`u^(-1), 1] - 48*Global`u*PolyLogTools`G[0, 1, Global`u^(-1), 
         1] + 24*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1), 1] - 
       12*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] + 
       12*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u, 1] + 
       72*PolyLogTools`G[0, 1, -(1/Sqrt[Global`u]), 1] + 
       72*Global`u*PolyLogTools`G[0, 1, -(1/Sqrt[Global`u]), 1] + 
       72*PolyLogTools`G[0, 1, 1/Sqrt[Global`u], 1] + 72*Global`u*PolyLogTools`G[0, 1, 
         1/Sqrt[Global`u], 1] - 114*PolyLogTools`G[0, 1, Global`u, 1] - 
       114*Global`u*PolyLogTools`G[0, 1, Global`u, 1] + 
       108*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] + 
       156*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] + 
       48*Global`u^2*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u), 1] + 
       12*Global`u*PolyLogTools`G[0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] + 
       12*Global`u^2*PolyLogTools`G[0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] - 
       12*Global`u*PolyLogTools`G[0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] - 
       12*Global`u^2*PolyLogTools`G[0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] + 
       12*Global`u*PolyLogTools`G[0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] + 
       12*Global`u^2*PolyLogTools`G[0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] - 
       12*Global`u*PolyLogTools`G[0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] - 
       12*Global`u^2*PolyLogTools`G[0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] + 
       24*Global`u*PolyLogTools`G[0, (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/
          (1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1] + 24*Global`u^2*
        PolyLogTools`G[0, (-1 + Sqrt[(4 - 3*Global`u)/Global`u])/
          (1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1] + 
       24*Global`u*PolyLogTools`G[0, (1 + Sqrt[(4 - 3*Global`u)/Global`u])/
          (-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1] + 24*Global`u^2*
        PolyLogTools`G[0, (1 + Sqrt[(4 - 3*Global`u)/Global`u])/
          (-1 + Sqrt[(4 - 3*Global`u)/Global`u]), 1, 1] + 
       12*PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1] + 
       24*Global`u*PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1] + 
       12*Global`u^2*PolyLogTools`G[0, (1 - Global`u)^(-1), 1, 1] - 
       24*Global`u*PolyLogTools`G[0, -(1/Sqrt[1 - Global`u]), 1, 1] - 
       24*Global`u^2*PolyLogTools`G[0, -(1/Sqrt[1 - Global`u]), 1, 1] - 
       24*Global`u*PolyLogTools`G[0, 1/Sqrt[1 - Global`u], 1, 1] - 
       24*Global`u^2*PolyLogTools`G[0, 1/Sqrt[1 - Global`u], 1, 1] - 
       24*PolyLogTools`G[0, 1 - Global`u, 1, 1] - 72*Global`u*PolyLogTools`G[0, 1 - Global`u, 1, 
         1] - 48*Global`u^2*PolyLogTools`G[0, 1 - Global`u, 1, 1] + 
       12*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1] - 
       48*Global`u*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1] - 
       60*Global`u^2*PolyLogTools`G[0, 1 - Global`u, 1 - Global`u, 1] - 
       48*PolyLogTools`G[0, Global`u^(-1), 1, 1] - 48*Global`u*PolyLogTools`G[0, Global`u^(-1), 1, 
         1] - 12*Global`u*PolyLogTools`G[0, Global`u^(-1), 
         (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u^2*PolyLogTools`G[0, Global`u^(-1), 
         (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u*PolyLogTools`G[0, Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u^2*PolyLogTools`G[0, Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
       120*PolyLogTools`G[0, Global`u^(-1), Global`u^(-1), 1] + 
       120*Global`u*PolyLogTools`G[0, Global`u^(-1), Global`u^(-1), 1] - 
       12*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
       36*Global`u*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
       48*Global`u^2*PolyLogTools`G[0, (-1 + Global`u)/Global`u, 1, 1] + 
       72*PolyLogTools`G[0, -(1/Sqrt[Global`u]), 1, 1] + 
       72*Global`u*PolyLogTools`G[0, -(1/Sqrt[Global`u]), 1, 1] + 
       72*PolyLogTools`G[0, 1/Sqrt[Global`u], 1, 1] + 72*Global`u*PolyLogTools`G[0, 
         1/Sqrt[Global`u], 1, 1] + 78*PolyLogTools`G[0, Global`u, 1, 1] + 
       18*Global`u*PolyLogTools`G[0, Global`u, 1, 1] - 60*Global`u^2*PolyLogTools`G[0, Global`u, 1, 
         1] + 174*PolyLogTools`G[0, Global`u, Global`u, 1] + 
       174*Global`u*PolyLogTools`G[0, Global`u, Global`u, 1] + 
       312*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] + 
       276*Global`u*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] - 
       36*Global`u^2*PolyLogTools`G[0, Global`u/(-1 + Global`u), 1, 1] - 
       108*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] - 
       108*Global`u*PolyLogTools`G[0, Global`u/(-1 + Global`u), Global`u/(-1 + Global`u), 1] - 
       96*PolyLogTools`G[0, (1 + Global`u)/Global`u, (1 + Global`u)/((1 + Global`u^(-1))*Global`u), 
         1] - 96*Global`u*PolyLogTools`G[0, (1 + Global`u)/Global`u, 
         (1 + Global`u)/((1 + Global`u^(-1))*Global`u), 1] - 
       72*PolyLogTools`G[0, (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
              (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^
                4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), Global`u^(-1), 1] - 
       72*Global`u*PolyLogTools`G[0, (2 - Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
              (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^
                4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (3*Global`u - 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), Global`u^(-1), 1] - 
       72*PolyLogTools`G[0, (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
              (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^
                4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), Global`u^(-1), 1] - 
       72*Global`u*PolyLogTools`G[0, (-2 + Global`u + Sqrt[-((Global`u*(-4 + 3*Global`u))/
              (-1 + Global`u)^4)] - 2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^
                4)] + Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)])/
          (-3*Global`u + 2*Global`u^2 + Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] - 
           2*Global`u*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)] + 
           Global`u^2*Sqrt[-((Global`u*(-4 + 3*Global`u))/(-1 + Global`u)^4)]), Global`u^(-1), 1] - 
       24*Global`u*PolyLogTools`G[0, (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2])/(-1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2]), 1, 1] - 24*Global`u^2*PolyLogTools`G[0, 
         (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
          (-1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1, 1] + 
       12*Global`u*PolyLogTools`G[0, (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2])/(-1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2]), -(-1 + Global`u)^(-1), 1] + 12*Global`u^2*
        PolyLogTools`G[0, (-1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2])/(-1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2]), -(-1 + Global`u)^(-1), 1] - 
       24*Global`u*PolyLogTools`G[0, (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2])/(1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2]), 1, 1] - 24*Global`u^2*PolyLogTools`G[0, 
         (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2])/
          (1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/Global`u^2]), 1, 1] + 
       12*Global`u*PolyLogTools`G[0, (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2])/(1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2]), -(-1 + Global`u)^(-1), 1] + 12*Global`u^2*
        PolyLogTools`G[0, (1 + Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2])/(1 - Global`u + Global`u*Sqrt[(1 + 2*Global`u - 3*Global`u^2)/
              Global`u^2]), -(-1 + Global`u)^(-1), 1] + 
       24*PolyLogTools`G[1, 0, 1, (1 - Global`u)^(-1)] + 24*Global`u*PolyLogTools`G[1, 0, 1, 
         (1 - Global`u)^(-1)] - 48*Global`u*PolyLogTools`G[1, 0, 1, Global`u^(-1)] - 
       48*Global`u^2*PolyLogTools`G[1, 0, 1, Global`u^(-1)] + 
       24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 0, 1, 1] + 
       24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 0, 1, 1] + 
       24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, 0, 1] + 
       24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 1, 0, 1] - 
       12*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1, 1] + 
       12*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1, 1] + 
       24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1, 1] + 
       12*PolyLogTools`G[(1 - Global`u)^(-1), 1, (1 - Global`u)^(-1), 1] + 
       12*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, (1 - Global`u)^(-1), 1] - 
       24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, -(1/Sqrt[1 - Global`u]), 1] - 
       24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 1, -(1/Sqrt[1 - Global`u]), 1] - 
       24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1/Sqrt[1 - Global`u], 1] - 
       24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1/Sqrt[1 - Global`u], 1] - 
       24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), -(1/Sqrt[1 - Global`u]), 1, 1] - 
       24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), -(1/Sqrt[1 - Global`u]), 1, 1] - 
       24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1/Sqrt[1 - Global`u], 1, 1] - 
       24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 1/Sqrt[1 - Global`u], 1, 1] - 
       24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 0, 1, 1] - 
       24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 0, 1, 1] - 
       24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 0, 1] - 
       24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 0, 1] - 
       24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1, 1] - 
       24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1, 1] - 
       24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, (1 - Global`u)^(-1), 1] - 
       24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, (1 - Global`u)^(-1), 1] + 
       48*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, -(1/Sqrt[1 - Global`u]), 1] + 
       48*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, -(1/Sqrt[1 - Global`u]), 1] + 
       48*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1/Sqrt[1 - Global`u], 1] + 
       48*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1/Sqrt[1 - Global`u], 1] - 
       24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1, 1] - 
       24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1, 1] + 
       48*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1, 1] + 
       48*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1, 1] + 
       48*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1, 1] + 
       48*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1, 1] - 
       24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 0, 1, 1] - 
       24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 0, 1, 1] - 
       24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 0, 1] - 
       24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 0, 1] - 
       24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1, 1] - 
       24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1, 1] - 
       24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, (1 - Global`u)^(-1), 1] - 
       24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, (1 - Global`u)^(-1), 1] + 
       48*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, -(1/Sqrt[1 - Global`u]), 1] + 
       48*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, -(1/Sqrt[1 - Global`u]), 1] + 
       48*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1/Sqrt[1 - Global`u], 1] + 
       48*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1/Sqrt[1 - Global`u], 1] - 
       24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], (1 - Global`u)^(-1), 1, 1] - 
       24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], (1 - Global`u)^(-1), 1, 1] + 
       48*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], -(1/Sqrt[1 - Global`u]), 1, 1] + 
       48*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], -(1/Sqrt[1 - Global`u]), 1, 1] + 
       48*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1/Sqrt[1 - Global`u], 1, 1] + 
       48*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1/Sqrt[1 - Global`u], 1, 1] + 
       24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         0, (1 - Global`u)^(-1), 1] + 24*Global`u^2*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, (1 - Global`u)^(-1), 
         1] - 24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), 0, -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*
        PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, 1/Sqrt[1 - Global`u], 
         1] - 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), 0, 1/Sqrt[1 - Global`u], 1] + 24*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, (1 - Global`u)^(-1), 
         1] + 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), 1, (1 - Global`u)^(-1), 1] - 24*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 1/Sqrt[1 - Global`u], 
         1] - 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), 1, 1/Sqrt[1 - Global`u], 1] + 24*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 0, 
         1] + 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), (1 - Global`u)^(-1), 0, 1] + 24*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 1, 
         1] + 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), (1 - Global`u)^(-1), 1, 1] - 24*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
         1/Sqrt[1 - Global`u], 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
         1/Sqrt[1 - Global`u], 1] - 24*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
         0, 1] - 24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), -(1/Sqrt[1 - Global`u]), 0, 1] - 24*Global`u*
        PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), 1, 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
         1, 1] - 24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), -(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1] - 
       24*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1] + 
       48*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1] + 
       48*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1] + 
       48*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1] + 
       48*Global`u^2*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1] - 
       24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         1/Sqrt[1 - Global`u], 0, 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 0, 
         1] - 24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), 1/Sqrt[1 - Global`u], 1, 1] - 24*Global`u^2*
        PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         1/Sqrt[1 - Global`u], 1, 1] - 24*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         (1 - Global`u)^(-1), 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         (1 - Global`u)^(-1), 1] + 48*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         -(1/Sqrt[1 - Global`u]), 1] + 48*Global`u^2*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         -(1/Sqrt[1 - Global`u]), 1] + 48*Global`u*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         1/Sqrt[1 - Global`u], 1] + 48*Global`u^2*PolyLogTools`G[
         2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         1/Sqrt[1 - Global`u], 1] + 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, (1 - Global`u)^(-1), 
         1] + 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), 0, (1 - Global`u)^(-1), 1] - 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 0, 1/Sqrt[1 - Global`u], 
         1] - 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), 0, 1/Sqrt[1 - Global`u], 1] + 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, (1 - Global`u)^(-1), 
         1] + 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), 1, (1 - Global`u)^(-1), 1] - 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1, 1/Sqrt[1 - Global`u], 
         1] - 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), 1, 1/Sqrt[1 - Global`u], 1] + 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 0, 
         1] + 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), (1 - Global`u)^(-1), 0, 1] + 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 1, 
         1] + 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), (1 - Global`u)^(-1), 1, 1] - 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
         -(1/Sqrt[1 - Global`u]), 1] - 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
         1/Sqrt[1 - Global`u], 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), (1 - Global`u)^(-1), 
         1/Sqrt[1 - Global`u], 1] - 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
         0, 1] - 24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), -(1/Sqrt[1 - Global`u]), 0, 1] - 24*Global`u*
        PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), 1, 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), -(1/Sqrt[1 - Global`u]), 
         1, 1] - 24*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), -(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1] - 
       24*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), (1 - Global`u)^(-1), 1] + 
       48*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1] + 
       48*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), -(1/Sqrt[1 - Global`u]), 1] + 
       48*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1] + 
       48*Global`u^2*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), 1/Sqrt[1 - Global`u], 1] - 
       24*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         1/Sqrt[1 - Global`u], 0, 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 0, 
         1] - 24*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - 
           Global`u), 1/Sqrt[1 - Global`u], 1, 1] - 24*Global`u^2*
        PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         1/Sqrt[1 - Global`u], 1, 1] - 24*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         (1 - Global`u)^(-1), 1] - 24*Global`u^2*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         (1 - Global`u)^(-1), 1] + 48*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         -(1/Sqrt[1 - Global`u]), 1] + 48*Global`u^2*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         -(1/Sqrt[1 - Global`u]), 1] + 48*Global`u*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         1/Sqrt[1 - Global`u], 1] + 48*Global`u^2*PolyLogTools`G[
         2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 1/Sqrt[1 - Global`u], 
         1/Sqrt[1 - Global`u], 1] - 72*PolyLogTools`G[Global`u^(-1), 0, 1, 1] - 
       60*Global`u*PolyLogTools`G[Global`u^(-1), 0, 1, 1] + 
       12*Global`u^2*PolyLogTools`G[Global`u^(-1), 0, 1, 1] - 
       12*Global`u*PolyLogTools`G[Global`u^(-1), 0, (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u^2*PolyLogTools`G[Global`u^(-1), 0, 
         (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u*PolyLogTools`G[Global`u^(-1), 0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] - 
       12*Global`u^2*PolyLogTools`G[Global`u^(-1), 0, (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1] + 
       48*PolyLogTools`G[Global`u^(-1), 0, Global`u^(-1), 1] + 
       48*Global`u*PolyLogTools`G[Global`u^(-1), 0, Global`u^(-1), 1] - 
       72*PolyLogTools`G[Global`u^(-1), 1, 0, 1] - 72*Global`u*PolyLogTools`G[Global`u^(-1), 1, 0, 
         1] - 72*PolyLogTools`G[Global`u^(-1), 1, 1, 1] - 
       48*Global`u*PolyLogTools`G[Global`u^(-1), 1, 1, 1] + 
       24*Global`u^2*PolyLogTools`G[Global`u^(-1), 1, 1, 1] - 
       24*Global`u*PolyLogTools`G[Global`u^(-1), 1, Global`u^(-1), 1] - 
       24*Global`u^2*PolyLogTools`G[Global`u^(-1), 1, Global`u^(-1), 1] + 
       72*PolyLogTools`G[Global`u^(-1), 1, -(1/Sqrt[Global`u]), 1] + 
       72*Global`u*PolyLogTools`G[Global`u^(-1), 1, -(1/Sqrt[Global`u]), 1] + 
       72*PolyLogTools`G[Global`u^(-1), 1, 1/Sqrt[Global`u], 1] + 
       72*Global`u*PolyLogTools`G[Global`u^(-1), 1, 1/Sqrt[Global`u], 1] - 
       12*Global`u*PolyLogTools`G[Global`u^(-1), (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] - 
       12*Global`u^2*PolyLogTools`G[Global`u^(-1), (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] + 
       12*Global`u*PolyLogTools`G[Global`u^(-1), (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] + 
       12*Global`u^2*PolyLogTools`G[Global`u^(-1), (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] - 
       12*Global`u*PolyLogTools`G[Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] - 
       12*Global`u^2*PolyLogTools`G[Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), 1, 1] + 
       12*Global`u*PolyLogTools`G[Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] + 
       12*Global`u^2*PolyLogTools`G[Global`u^(-1), (1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)])/
          (-1 + Sqrt[(-1 - 3*Global`u)/(-1 + Global`u)]), Global`u^(-1), 1] + 
       72*PolyLogTools`G[Global`u^(-1), -(1/Sqrt[Global`u]), 1, 1] + 
       72*Global`u*PolyLogTools`G[Global`u^(-1), -(1/Sqrt[Global`u]), 1, 1] + 
       72*PolyLogTools`G[Global`u^(-1), 1/Sqrt[Global`u], 1, 1] + 
       72*Global`u*PolyLogTools`G[Global`u^(-1), 1/Sqrt[Global`u], 1, 1] - 
       24*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1] - 
       24*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, 1, 1] + 
       24*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1] + 
       36*Global`u*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1] + 
       12*Global`u^2*PolyLogTools`G[(-1 + Global`u)/Global`u, 0, (-1 + Global`u)/Global`u, 1] + 
       72*PolyLogTools`G[-(1/Sqrt[Global`u]), 0, 1, 1] + 
       72*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 0, 1, 1] + 
       72*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 0, 1] + 
       72*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 0, 1] + 
       72*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1, 1] + 
       72*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1, 1] + 
       72*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, Global`u^(-1), 1] + 
       72*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, Global`u^(-1), 1] - 
       144*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, -(1/Sqrt[Global`u]), 1] - 
       144*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, -(1/Sqrt[Global`u]), 1] - 
       144*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1/Sqrt[Global`u], 1] - 
       144*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1/Sqrt[Global`u], 1] + 
       72*PolyLogTools`G[-(1/Sqrt[Global`u]), Global`u^(-1), 1, 1] + 
       72*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), Global`u^(-1), 1, 1] - 
       144*PolyLogTools`G[-(1/Sqrt[Global`u]), -(1/Sqrt[Global`u]), 1, 1] - 
       144*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), -(1/Sqrt[Global`u]), 1, 1] - 
       144*PolyLogTools`G[-(1/Sqrt[Global`u]), 1/Sqrt[Global`u], 1, 1] - 
       144*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1/Sqrt[Global`u], 1, 1] + 
       72*PolyLogTools`G[1/Sqrt[Global`u], 0, 1, 1] + 72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 
         0, 1, 1] + 72*PolyLogTools`G[1/Sqrt[Global`u], 1, 0, 1] + 
       72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1, 0, 1] + 
       72*PolyLogTools`G[1/Sqrt[Global`u], 1, 1, 1] + 72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 
         1, 1, 1] + 72*PolyLogTools`G[1/Sqrt[Global`u], 1, Global`u^(-1), 1] + 
       72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1, Global`u^(-1), 1] - 
       144*PolyLogTools`G[1/Sqrt[Global`u], 1, -(1/Sqrt[Global`u]), 1] - 
       144*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1, -(1/Sqrt[Global`u]), 1] - 
       144*PolyLogTools`G[1/Sqrt[Global`u], 1, 1/Sqrt[Global`u], 1] - 
       144*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1, 1/Sqrt[Global`u], 1] + 
       72*PolyLogTools`G[1/Sqrt[Global`u], Global`u^(-1), 1, 1] + 
       72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], Global`u^(-1), 1, 1] - 
       144*PolyLogTools`G[1/Sqrt[Global`u], -(1/Sqrt[Global`u]), 1, 1] - 
       144*Global`u*PolyLogTools`G[1/Sqrt[Global`u], -(1/Sqrt[Global`u]), 1, 1] - 
       144*PolyLogTools`G[1/Sqrt[Global`u], 1/Sqrt[Global`u], 1, 1] - 
       144*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1/Sqrt[Global`u], 1, 1] + 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1] + 
       12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 0, 1, 1] - 
       12*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] - 
       12*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 0, (-1 + Global`u)/Global`u, 1] + 
       24*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] + 
       24*Global`u*PolyLogTools`G[Global`u/(-1 + Global`u), 1, (-1 + Global`u)/Global`u, 1] + 
       24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -1, 1, 1] + 
       24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -1, 1, 1] + 
       24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, -1, 1] + 
       24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, -1, 1] + 
       48*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1, 1] + 
       48*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1, 1] - 
       24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, -((1 + Global`u)/(1 - Global`u)), 
         1] - 24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 
         -((1 + Global`u)/(1 - Global`u)), 1] - 24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 
         1, (1 + Global`u)/(1 - Global`u), 1] - 24*Global`u*PolyLogTools`G[
         -((1 + Global`u)/(1 - Global`u)), 1, (1 + Global`u)/(1 - Global`u), 1] - 
       24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), -((1 + Global`u)/(1 - Global`u)), 1, 
         1] - 24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 
         -((1 + Global`u)/(1 - Global`u)), 1, 1] - 
       24*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), (1 + Global`u)/(1 - Global`u), 1, 1] - 
       24*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), (1 + Global`u)/(1 - Global`u), 
         1, 1] + 24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -1, 1, 1] + 
       24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -1, 1, 1] + 
       24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, -1, 1] + 
       24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, -1, 1] + 
       48*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1, 1] + 
       48*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1, 1] - 
       24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, -((1 + Global`u)/(1 - Global`u)), 1] - 
       24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 
         -((1 + Global`u)/(1 - Global`u)), 1] - 24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 
         (1 + Global`u)/(1 - Global`u), 1] - 24*Global`u*PolyLogTools`G[
         (1 + Global`u)/(1 - Global`u), 1, (1 + Global`u)/(1 - Global`u), 1] - 
       24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -((1 + Global`u)/(1 - Global`u)), 1, 1] - 
       24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), -((1 + Global`u)/(1 - Global`u)), 
         1, 1] - 24*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), (1 + Global`u)/(1 - Global`u), 1, 
         1] - 24*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 
         (1 + Global`u)/(1 - Global`u), 1, 1] - 
       72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, Global`u^(-1), 1] - 
       72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, Global`u^(-1), 
         1] + 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
         -(1/Sqrt[Global`u]), 1] + 72*Global`u*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, -(1/Sqrt[Global`u]), 1] + 
       72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 1/Sqrt[Global`u], 1] + 
       72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
         1/Sqrt[Global`u], 1] - 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         1, Global`u^(-1), 1] - 72*Global`u*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, Global`u^(-1), 1] + 
       72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, -(1/Sqrt[Global`u]), 
         1] + 72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
         -(1/Sqrt[Global`u]), 1] + 72*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, 1/Sqrt[Global`u], 1] + 
       72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
         1/Sqrt[Global`u], 1] - 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         Global`u^(-1), 0, 1] - 72*Global`u*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 0, 1] - 
       72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1, 1] - 
       72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1, 
         1] + 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
         -(1/Sqrt[Global`u]), 1] + 72*Global`u*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), -(1/Sqrt[Global`u]), 1] + 
       72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
         1/Sqrt[Global`u], 1] + 72*Global`u*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1/Sqrt[Global`u], 1] + 
       72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 0, 
         1] + 72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         -(1/Sqrt[Global`u]), 0, 1] + 72*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1, 1] + 
       72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         -(1/Sqrt[Global`u]), 1, 1] + 72*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), Global`u^(-1), 1] + 
       72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         -(1/Sqrt[Global`u]), Global`u^(-1), 1] - 
       144*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
         -(1/Sqrt[Global`u]), 1] - 144*Global`u*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), -(1/Sqrt[Global`u]), 
         1] - 144*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         -(1/Sqrt[Global`u]), 1/Sqrt[Global`u], 1] - 144*Global`u*
        PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
         1/Sqrt[Global`u], 1] + 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         1/Sqrt[Global`u], 0, 1] + 72*Global`u*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 0, 1] + 
       72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1, 1] + 
       72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
         1, 1] + 72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         1/Sqrt[Global`u], Global`u^(-1), 1] + 72*Global`u*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], Global`u^(-1), 1] - 
       144*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
         -(1/Sqrt[Global`u]), 1] - 144*Global`u*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], -(1/Sqrt[Global`u]), 
         1] - 144*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
         1/Sqrt[Global`u], 1] - 144*Global`u*PolyLogTools`G[
         2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1/Sqrt[Global`u], 1] - 
       72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, Global`u^(-1), 1] - 
       72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, Global`u^(-1), 
         1] + 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
         -(1/Sqrt[Global`u]), 1] + 72*Global`u*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, -(1/Sqrt[Global`u]), 1] + 
       72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 1/Sqrt[Global`u], 1] + 
       72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 0, 
         1/Sqrt[Global`u], 1] - 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         1, Global`u^(-1), 1] - 72*Global`u*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, Global`u^(-1), 1] + 
       72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, -(1/Sqrt[Global`u]), 
         1] + 72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
         -(1/Sqrt[Global`u]), 1] + 72*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, 1/Sqrt[Global`u], 1] + 
       72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1, 
         1/Sqrt[Global`u], 1] - 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         Global`u^(-1), 0, 1] - 72*Global`u*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 0, 1] - 
       72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1, 1] - 
       72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1, 
         1] + 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
         -(1/Sqrt[Global`u]), 1] + 72*Global`u*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), -(1/Sqrt[Global`u]), 1] + 
       72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 
         1/Sqrt[Global`u], 1] + 72*Global`u*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1/Sqrt[Global`u], 1] + 
       72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 0, 
         1] + 72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         -(1/Sqrt[Global`u]), 0, 1] + 72*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1, 1] + 
       72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         -(1/Sqrt[Global`u]), 1, 1] + 72*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), Global`u^(-1), 1] + 
       72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         -(1/Sqrt[Global`u]), Global`u^(-1), 1] - 
       144*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
         -(1/Sqrt[Global`u]), 1] - 144*Global`u*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), -(1/Sqrt[Global`u]), 
         1] - 144*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         -(1/Sqrt[Global`u]), 1/Sqrt[Global`u], 1] - 144*Global`u*
        PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 
         1/Sqrt[Global`u], 1] + 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         1/Sqrt[Global`u], 0, 1] + 72*Global`u*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 0, 1] + 
       72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1, 1] + 
       72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
         1, 1] + 72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         1/Sqrt[Global`u], Global`u^(-1), 1] + 72*Global`u*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], Global`u^(-1), 1] - 
       144*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
         -(1/Sqrt[Global`u]), 1] - 144*Global`u*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], -(1/Sqrt[Global`u]), 
         1] - 144*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 
         1/Sqrt[Global`u], 1] - 144*Global`u*PolyLogTools`G[
         2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1/Sqrt[Global`u], 1] - 
       4*Pi^2*Log[2] - 4*Pi^2*Global`u*Log[2] + 54*PolyLogTools`G[0, 1, -1]*Log[2] - 
       54*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[2] + 48*Log[2]^2 + 48*Global`u*Log[2]^2 - 
       16*Pi^2*Global`u*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
           (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])] - 16*Pi^2*Global`u^2*
        Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
           (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])] - 
       16*Global`u*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
            (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])]^3 - 
       16*Global`u^2*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
            (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])]^3 + 4*Pi^2*Log[1 - (1 - Global`u)^(-1)] + 
       4*Pi^2*Global`u*Log[1 - (1 - Global`u)^(-1)] - 8*Pi^2*Global`u*Log[1 - Global`u^(-1)] - 
       8*Pi^2*Global`u^2*Log[1 - Global`u^(-1)] + 24*Log[(1 - Global`u)^(-1)] - 
       46*Pi^2*Log[(1 - Global`u)^(-1)] + 24*Global`u*Log[(1 - Global`u)^(-1)] - 
       50*Pi^2*Global`u*Log[(1 - Global`u)^(-1)] - 4*Pi^2*Global`u^2*Log[(1 - Global`u)^(-1)] - 
       120*PolyLogTools`G[-1, -1, 1]*Log[(1 - Global`u)^(-1)] - 
       48*Global`u*PolyLogTools`G[-1, -1, 1]*Log[(1 - Global`u)^(-1)] + 
       72*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[(1 - Global`u)^(-1)] - 
       120*PolyLogTools`G[0, 1, -1]*Log[(1 - Global`u)^(-1)] - 48*Global`u*PolyLogTools`G[0, 1, -1]*
        Log[(1 - Global`u)^(-1)] + 72*Global`u^2*PolyLogTools`G[0, 1, -1]*
        Log[(1 - Global`u)^(-1)] - 12*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[(1 - Global`u)^(-1)] + 12*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[(1 - Global`u)^(-1)] + 12*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[(1 - Global`u)^(-1)] - 36*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[(1 - Global`u)^(-1)] - 48*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[(1 - Global`u)^(-1)] - 108*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(1 - Global`u)^(-1)] - 72*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(1 - Global`u)^(-1)] + 36*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(1 - Global`u)^(-1)] + 24*PolyLogTools`G[0, 1, Global`u]*Log[(1 - Global`u)^(-1)] + 
       24*Global`u*PolyLogTools`G[0, 1, Global`u]*Log[(1 - Global`u)^(-1)] + 
       60*Log[2]^2*Log[(1 - Global`u)^(-1)] + 24*Global`u*Log[2]^2*Log[(1 - Global`u)^(-1)] - 
       36*Global`u^2*Log[2]^2*Log[(1 - Global`u)^(-1)] - 12*Log[1 - (1 - Global`u)^(-1)]^2*
        Log[(1 - Global`u)^(-1)] - 12*Global`u*Log[1 - (1 - Global`u)^(-1)]^2*
        Log[(1 - Global`u)^(-1)] + 88*Log[(1 - Global`u)^(-1)]^2 + 
       (24*I)*Pi*Log[(1 - Global`u)^(-1)]^2 + 88*Global`u*Log[(1 - Global`u)^(-1)]^2 + 
       (24*I)*Pi*Global`u*Log[(1 - Global`u)^(-1)]^2 + 6*Log[1 - (1 - Global`u)^(-1)]*
        Log[(1 - Global`u)^(-1)]^2 + 6*Global`u*Log[1 - (1 - Global`u)^(-1)]*
        Log[(1 - Global`u)^(-1)]^2 - 4*Log[(1 - Global`u)^(-1)]^3 - 
       4*Global`u*Log[(1 - Global`u)^(-1)]^3 + 792*Log[1 - Global`u] + 
       (704*I)*Pi*Log[1 - Global`u] - 155*Pi^2*Log[1 - Global`u] + 792*Global`u*Log[1 - Global`u] + 
       (704*I)*Pi*Global`u*Log[1 - Global`u] - 140*Pi^2*Global`u*Log[1 - Global`u] + 
       15*Pi^2*Global`u^2*Log[1 - Global`u] + 36*PolyLogTools`G[-1, -1, 1]*Log[1 - Global`u] - 
       36*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[1 - Global`u] + 
       48*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1]*Log[1 - Global`u] + 
       48*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1]*Log[1 - Global`u] + 
       48*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1]*Log[1 - Global`u] + 
       48*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1]*Log[1 - Global`u] + 
       180*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u] + 48*Global`u*PolyLogTools`G[0, 1, -1]*
        Log[1 - Global`u] - 132*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[1 - Global`u] - 
       24*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u] - 
       36*Global`u*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u] - 
       12*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[1 - Global`u] - 
       12*Global`u*PolyLogTools`G[0, 1, 1 - Global`u]*Log[1 - Global`u] - 
       12*Global`u^2*PolyLogTools`G[0, 1, 1 - Global`u]*Log[1 - Global`u] - 
       48*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] - 
       12*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] + 
       36*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[1 - Global`u] - 
       36*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] - 
       96*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] - 
       60*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[1 - Global`u] - 
       24*PolyLogTools`G[0, 1, Global`u]*Log[1 - Global`u] - 
       12*Global`u*PolyLogTools`G[0, 1, Global`u]*Log[1 - Global`u] + 
       12*Global`u^2*PolyLogTools`G[0, 1, Global`u]*Log[1 - Global`u] - 
       24*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[1 - Global`u] - 
       12*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[1 - Global`u] + 
       12*Global`u^2*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[1 - Global`u] + 
       24*Global`u*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1]*Log[1 - Global`u] + 
       24*Global`u^2*PolyLogTools`G[(1 - Global`u)^(-1), 1, 1]*Log[1 - Global`u] - 
       24*Global`u*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1]*Log[1 - Global`u] - 
       24*Global`u^2*PolyLogTools`G[-(1/Sqrt[1 - Global`u]), 1, 1]*Log[1 - Global`u] - 
       24*Global`u*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1]*Log[1 - Global`u] - 
       24*Global`u^2*PolyLogTools`G[1/Sqrt[1 - Global`u], 1, 1]*Log[1 - Global`u] + 
       24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         (1 - Global`u)^(-1), 1]*Log[1 - Global`u] + 24*Global`u^2*
        PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         (1 - Global`u)^(-1), 1]*Log[1 - Global`u] - 24*Global`u*
        PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), 1]*Log[1 - Global`u] - 24*Global`u^2*
        PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), 1]*Log[1 - Global`u] - 
       24*Global`u*PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         1/Sqrt[1 - Global`u], 1]*Log[1 - Global`u] - 24*Global`u^2*
        PolyLogTools`G[2/(1 - Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         1/Sqrt[1 - Global`u], 1]*Log[1 - Global`u] + 24*Global`u*
        PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         (1 - Global`u)^(-1), 1]*Log[1 - Global`u] + 24*Global`u^2*
        PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         (1 - Global`u)^(-1), 1]*Log[1 - Global`u] - 24*Global`u*
        PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), 1]*Log[1 - Global`u] - 24*Global`u^2*
        PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         -(1/Sqrt[1 - Global`u]), 1]*Log[1 - Global`u] - 
       24*Global`u*PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         1/Sqrt[1 - Global`u], 1]*Log[1 - Global`u] - 24*Global`u^2*
        PolyLogTools`G[2/(1 + Sqrt[(4 - 3*(1 - Global`u))*(1 - Global`u)] - Global`u), 
         1/Sqrt[1 - Global`u], 1]*Log[1 - Global`u] + 
       48*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1]*Log[1 - Global`u] + 
       48*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1]*Log[1 - Global`u] + 
       48*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1]*Log[1 - Global`u] + 
       48*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1]*Log[1 - Global`u] - 
       18*Log[2]^2*Log[1 - Global`u] + 18*Global`u^2*Log[2]^2*Log[1 - Global`u] - 
       24*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u] - 24*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[1 - Global`u] + 12*Log[(1 - Global`u)^(-1)]^2*Log[1 - Global`u] + 
       12*Global`u*Log[(1 - Global`u)^(-1)]^2*Log[1 - Global`u] + 570*Log[1 - Global`u]^2 + 
       (66*I)*Pi*Log[1 - Global`u]^2 + 570*Global`u*Log[1 - Global`u]^2 + 
       (66*I)*Pi*Global`u*Log[1 - Global`u]^2 + 6*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[1 - Global`u]^2 + 6*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]^2 + 
       128*Log[1 - Global`u]^3 + 130*Global`u*Log[1 - Global`u]^3 + 
       2*Global`u^2*Log[1 - Global`u]^3 + 72*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)] + 
       72*Global`u*PolyLogTools`G[0, 1, -1]*Log[-2/(-1 + Global`u)] - 
       18*Pi^2*Log[(-1 + Global`u)^(-1)] - 18*Pi^2*Global`u*Log[(-1 + Global`u)^(-1)] + 
       48*PolyLogTools`G[-1, -1, 1]*Log[(-1 + Global`u)^(-1)] + 
       48*Global`u*PolyLogTools`G[-1, -1, 1]*Log[(-1 + Global`u)^(-1)] - 
       72*PolyLogTools`G[0, 1, -1]*Log[(-1 + Global`u)^(-1)] - 72*Global`u*PolyLogTools`G[0, 1, -1]*
        Log[(-1 + Global`u)^(-1)] - 24*Log[2]^2*Log[(-1 + Global`u)^(-1)] - 
       24*Global`u*Log[2]^2*Log[(-1 + Global`u)^(-1)] - 88*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)] - 88*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)] - 24*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)] - 24*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)] + 44*Log[(-1 + Global`u)^(-1)]^2 + 
       44*Global`u*Log[(-1 + Global`u)^(-1)]^2 + 24*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)]^2 + 24*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)]^2 + 12*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]^2 + 
       12*Global`u*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]^2 - 18*Log[(-1 + Global`u)^(-1)]^3 - 
       18*Global`u*Log[(-1 + Global`u)^(-1)]^3 + 3*Pi^2*Log[-1 + Global`u] - 
       3*Pi^2*Global`u^2*Log[-1 + Global`u] - 108*PolyLogTools`G[-1, -1, 1]*Log[-1 + Global`u] + 
       108*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[-1 + Global`u] - 120*PolyLogTools`G[0, 1, -1]*
        Log[-1 + Global`u] + 120*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[-1 + Global`u] + 
       54*Log[2]^2*Log[-1 + Global`u] - 54*Global`u^2*Log[2]^2*Log[-1 + Global`u] + 
       88*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u] - 88*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[-1 + Global`u] - 88*Log[1 - Global`u]*Log[-1 + Global`u] + 
       88*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u] + 48*Log[(1 - Global`u)^(-1)]*
        Log[1 - Global`u]*Log[-1 + Global`u] - 48*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[1 - Global`u]*Log[-1 + Global`u] - 12*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] - 12*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] + 24*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] - 24*Global`u^2*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u] + 12*Log[(-1 + Global`u)^(-1)]^2*
        Log[-1 + Global`u] - 12*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*Log[-1 + Global`u] + 
       88*Log[-1 + Global`u]^2 - 88*Global`u^2*Log[-1 + Global`u]^2 - 
       30*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]^2 + 30*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[-1 + Global`u]^2 + 42*Log[1 - Global`u]*Log[-1 + Global`u]^2 - 
       42*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u]^2 - 6*Log[(-1 + Global`u)^(-1)]*
        Log[-1 + Global`u]^2 - 6*Global`u*Log[(-1 + Global`u)^(-1)]*Log[-1 + Global`u]^2 - 
       28*Log[-1 + Global`u]^3 + 28*Global`u^2*Log[-1 + Global`u]^3 - 
       108*PolyLogTools`G[0, 1, -1]*Log[2*(-1 + Global`u)] + 108*Global`u^2*
        PolyLogTools`G[0, 1, -1]*Log[2*(-1 + Global`u)] - 18*Pi^2*Log[Global`u^(-1)] - 
       2*Pi^2*Global`u*Log[Global`u^(-1)] + 16*Pi^2*Global`u^2*Log[Global`u^(-1)] + 
       264*PolyLogTools`G[-1, -1, 1]*Log[Global`u^(-1)] + 216*Global`u*PolyLogTools`G[-1, -1, 1]*
        Log[Global`u^(-1)] - 48*Global`u^2*PolyLogTools`G[-1, -1, 1]*Log[Global`u^(-1)] - 
       216*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)] - 168*Global`u*PolyLogTools`G[0, 1, -1]*
        Log[Global`u^(-1)] + 48*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[Global`u^(-1)] + 
       12*Global`u*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 
       12*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 
       24*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)] + 
       24*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u^(-1)] - 
       24*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)] - 
       24*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u^(-1)] + 
       12*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)] + 
       12*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u^(-1)] - 
       132*Log[2]^2*Log[Global`u^(-1)] - 108*Global`u*Log[2]^2*Log[Global`u^(-1)] + 
       24*Global`u^2*Log[2]^2*Log[Global`u^(-1)] + 24*Global`u*Log[1 - Global`u^(-1)]^2*
        Log[Global`u^(-1)] + 24*Global`u^2*Log[1 - Global`u^(-1)]^2*Log[Global`u^(-1)] - 
       88*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] - 
       88*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)] + 220*Log[1 - Global`u]*
        Log[Global`u^(-1)] + (36*I)*Pi*Log[1 - Global`u]*Log[Global`u^(-1)] + 
       308*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)] + (36*I)*Pi*Global`u*Log[1 - Global`u]*
        Log[Global`u^(-1)] + 88*Global`u^2*Log[1 - Global`u]*Log[Global`u^(-1)] - 
       48*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[Global`u^(-1)] - 
       48*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[Global`u^(-1)] + 
       60*Log[1 - Global`u]^2*Log[Global`u^(-1)] + 72*Global`u*Log[1 - Global`u]^2*
        Log[Global`u^(-1)] + 12*Global`u^2*Log[1 - Global`u]^2*Log[Global`u^(-1)] - 
       24*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] - 
       24*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] + 
       24*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] - 
       24*Global`u^2*Log[1 - Global`u]*Log[(-1 + Global`u)^(-1)]*Log[Global`u^(-1)] + 
       24*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)] + 12*Global`u*Log[(-1 + Global`u)^(-1)]^2*
        Log[Global`u^(-1)] - 12*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u^(-1)] + 
       12*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 
       24*Global`u*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 
       12*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 
       108*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u^(-1)] + 96*Global`u*Log[1 - Global`u]*
        Log[-1 + Global`u]*Log[Global`u^(-1)] - 12*Global`u^2*Log[1 - Global`u]*Log[-1 + Global`u]*
        Log[Global`u^(-1)] - 48*Log[-1 + Global`u]^2*Log[Global`u^(-1)] - 
       36*Global`u*Log[-1 + Global`u]^2*Log[Global`u^(-1)] + 12*Global`u^2*Log[-1 + Global`u]^2*
        Log[Global`u^(-1)] + 110*Log[Global`u^(-1)]^2 + (18*I)*Pi*Log[Global`u^(-1)]^2 + 
       198*Global`u*Log[Global`u^(-1)]^2 + (18*I)*Pi*Global`u*Log[Global`u^(-1)]^2 + 
       88*Global`u^2*Log[Global`u^(-1)]^2 - 12*Global`u*Log[1 - Global`u^(-1)]*
        Log[Global`u^(-1)]^2 - 12*Global`u^2*Log[1 - Global`u^(-1)]*Log[Global`u^(-1)]^2 + 
       48*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2 + 30*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[Global`u^(-1)]^2 - 18*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]^2 + 
       78*Log[1 - Global`u]*Log[Global`u^(-1)]^2 + 126*Global`u*Log[1 - Global`u]*
        Log[Global`u^(-1)]^2 + 48*Global`u^2*Log[1 - Global`u]*Log[Global`u^(-1)]^2 - 
       12*Log[Global`u^(-1)]^3 + 12*Global`u*Log[Global`u^(-1)]^3 + 
       24*Global`u^2*Log[Global`u^(-1)]^3 - 8*Pi^2*Global`u*Log[(1 - Global`u)/Global`u] - 
       8*Pi^2*Global`u^2*Log[(1 - Global`u)/Global`u] - 
       24*Global`u*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
            (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])]^2*Log[(1 - Global`u)/Global`u] - 
       24*Global`u^2*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
            (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])]^2*Log[(1 - Global`u)/Global`u] - 
       12*Global`u*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
           (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])]*Log[(1 - Global`u)/Global`u]^2 - 
       12*Global`u^2*Log[1 + (1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
           (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u])]*Log[(1 - Global`u)/Global`u]^2 - 
       2*Global`u*Log[(1 - Global`u)/Global`u]^3 - 2*Global`u^2*Log[(1 - Global`u)/Global`u]^3 - 
       110*Pi^2*Log[(-1 + Global`u)/Global`u] - 104*Pi^2*Global`u*Log[(-1 + Global`u)/Global`u] + 
       6*Pi^2*Global`u^2*Log[(-1 + Global`u)/Global`u] + 48*PolyLogTools`G[-1, -1, 1]*
        Log[(-1 + Global`u)/Global`u] + 48*Global`u*PolyLogTools`G[-1, -1, 1]*
        Log[(-1 + Global`u)/Global`u] - 72*Global`u*PolyLogTools`G[0, 1, -1]*
        Log[(-1 + Global`u)/Global`u] - 72*Global`u^2*PolyLogTools`G[0, 1, -1]*
        Log[(-1 + Global`u)/Global`u] + 12*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 12*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 72*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(-1 + Global`u)/Global`u] + 72*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*
        Log[(-1 + Global`u)/Global`u] - 24*Log[2]^2*Log[(-1 + Global`u)/Global`u] - 
       24*Global`u*Log[2]^2*Log[(-1 + Global`u)/Global`u] + 24*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 64*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 88*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 156*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + 
       (60*I)*Pi*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u] + 244*Global`u*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] + (60*I)*Pi*Global`u*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] + 88*Global`u^2*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] - 24*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] - 24*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u] - 108*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u] - 
       96*Global`u*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u] + 
       12*Global`u^2*Log[1 - Global`u]^2*Log[(-1 + Global`u)/Global`u] + 
       36*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 36*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] - 84*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] - 60*Global`u*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] + 24*Global`u^2*Log[1 - Global`u]*
        Log[(-1 + Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u] - 42*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] - 48*Global`u*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] - 6*Global`u^2*Log[(-1 + Global`u)^(-1)]^2*
        Log[(-1 + Global`u)/Global`u] - 12*Global`u*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*
        Log[(-1 + Global`u)/Global`u] - 12*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*
        Log[(-1 + Global`u)/Global`u] - 6*Global`u*Log[-1 + Global`u]^2*
        Log[(-1 + Global`u)/Global`u] - 6*Global`u^2*Log[-1 + Global`u]^2*
        Log[(-1 + Global`u)/Global`u] + 72*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] + 48*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 24*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u] - 36*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] - 
       36*Global`u*Log[Global`u^(-1)]^2*Log[(-1 + Global`u)/Global`u] - 
       66*Log[(-1 + Global`u)/Global`u]^2 - (30*I)*Pi*Log[(-1 + Global`u)/Global`u]^2 - 
       154*Global`u*Log[(-1 + Global`u)/Global`u]^2 - (30*I)*Pi*Global`u*
        Log[(-1 + Global`u)/Global`u]^2 - 88*Global`u^2*Log[(-1 + Global`u)/Global`u]^2 - 
       24*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       18*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       42*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)/Global`u]^2 + 
       114*Log[1 - Global`u]*Log[(-1 + Global`u)/Global`u]^2 + 114*Global`u*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]^2 - 12*Global`u*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u]^2 - 12*Global`u^2*Log[Global`u^(-1)]*
        Log[(-1 + Global`u)/Global`u]^2 - 70*Log[(-1 + Global`u)/Global`u]^3 - 
       58*Global`u*Log[(-1 + Global`u)/Global`u]^3 + 12*Global`u^2*Log[(-1 + Global`u)/Global`u]^
         3 - 36*Log[(1 - Global`u)^(-1)]*Log[-Global`u]^2 - 42*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[-Global`u]^2 - 6*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-Global`u]^2 + 
       1176*Log[Global`u] + (1056*I)*Pi*Log[Global`u] - 248*Pi^2*Log[Global`u] + 
       744*Global`u*Log[Global`u] + (1056*I)*Pi*Global`u*Log[Global`u] - 
       220*Pi^2*Global`u*Log[Global`u] - 384*Global`u^2*Log[Global`u] + 
       28*Pi^2*Global`u^2*Log[Global`u] + 24*PolyLogTools`G[-1, -1, 1]*Log[Global`u] + 
       24*Global`u*PolyLogTools`G[-1, -1, 1]*Log[Global`u] + 216*PolyLogTools`G[0, 1, -1]*
        Log[Global`u] + 144*Global`u*PolyLogTools`G[0, 1, -1]*Log[Global`u] - 
       72*Global`u^2*PolyLogTools`G[0, 1, -1]*Log[Global`u] + 
       12*Global`u*PolyLogTools`G[0, 1, 1 - Global`u]*Log[Global`u] + 
       12*Global`u^2*PolyLogTools`G[0, 1, 1 - Global`u]*Log[Global`u] + 
       84*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] + 
       144*Global`u*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] + 
       60*Global`u^2*PolyLogTools`G[0, 1, Global`u^(-1)]*Log[Global`u] - 
       132*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
       192*Global`u*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
       60*Global`u^2*PolyLogTools`G[0, 1, (-1 + Global`u)/Global`u]*Log[Global`u] - 
       12*Global`u*PolyLogTools`G[0, 1, Global`u]*Log[Global`u] - 
       12*Global`u^2*PolyLogTools`G[0, 1, Global`u]*Log[Global`u] - 
       72*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] - 
       36*Global`u*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] + 
       36*Global`u^2*PolyLogTools`G[0, 1, Global`u/(-1 + Global`u)]*Log[Global`u] - 
       48*PolyLogTools`G[0, 1, Global`u/(1 + Global`u)]*Log[Global`u] - 
       48*Global`u*PolyLogTools`G[0, 1, Global`u/(1 + Global`u)]*Log[Global`u] - 
       72*PolyLogTools`G[Global`u^(-1), 1, 1]*Log[Global`u] - 
       72*Global`u*PolyLogTools`G[Global`u^(-1), 1, 1]*Log[Global`u] + 
       72*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1]*Log[Global`u] + 
       72*Global`u*PolyLogTools`G[-(1/Sqrt[Global`u]), 1, 1]*Log[Global`u] + 
       72*PolyLogTools`G[1/Sqrt[Global`u], 1, 1]*Log[Global`u] + 
       72*Global`u*PolyLogTools`G[1/Sqrt[Global`u], 1, 1]*Log[Global`u] - 
       72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1]*
        Log[Global`u] - 72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         Global`u^(-1), 1]*Log[Global`u] + 
       72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1]*
        Log[Global`u] + 72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         -(1/Sqrt[Global`u]), 1]*Log[Global`u] + 
       72*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1]*
        Log[Global`u] + 72*Global`u*PolyLogTools`G[2/(Global`u - Sqrt[(4 - 3*Global`u)*Global`u]), 
         1/Sqrt[Global`u], 1]*Log[Global`u] - 
       72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), Global`u^(-1), 1]*
        Log[Global`u] - 72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         Global`u^(-1), 1]*Log[Global`u] + 
       72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), -(1/Sqrt[Global`u]), 1]*
        Log[Global`u] + 72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         -(1/Sqrt[Global`u]), 1]*Log[Global`u] + 
       72*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 1/Sqrt[Global`u], 1]*
        Log[Global`u] + 72*Global`u*PolyLogTools`G[2/(Global`u + Sqrt[(4 - 3*Global`u)*Global`u]), 
         1/Sqrt[Global`u], 1]*Log[Global`u] - 12*Log[2]^2*Log[Global`u] - 
       12*Global`u*Log[2]^2*Log[Global`u] + 176*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
       (48*I)*Pi*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 176*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[Global`u] + (48*I)*Pi*Global`u*Log[(1 - Global`u)^(-1)]*Log[Global`u] + 
       36*Log[(1 - Global`u)^(-1)]^2*Log[Global`u] + 36*Global`u*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u] + 1008*Log[1 - Global`u]*Log[Global`u] + (288*I)*Pi*Log[1 - Global`u]*
        Log[Global`u] + 1104*Global`u*Log[1 - Global`u]*Log[Global`u] + 
       (288*I)*Pi*Global`u*Log[1 - Global`u]*Log[Global`u] + 24*Log[(1 - Global`u)^(-1)]*
        Log[1 - Global`u]*Log[Global`u] + 12*Global`u*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*
        Log[Global`u] - 12*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[1 - Global`u]*Log[Global`u] + 
       186*Log[1 - Global`u]^2*Log[Global`u] + 186*Global`u*Log[1 - Global`u]^2*Log[Global`u] - 
       24*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[Global`u] - 
       24*Global`u*Log[(1 - Global`u)^(-1)]*Log[(-1 + Global`u)^(-1)]*Log[Global`u] + 
       12*Log[(-1 + Global`u)^(-1)]^2*Log[Global`u] + 12*Global`u*Log[(-1 + Global`u)^(-1)]^2*
        Log[Global`u] + 24*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u] - 
       24*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-1 + Global`u]*Log[Global`u] - 
       24*Log[1 - Global`u]*Log[-1 + Global`u]*Log[Global`u] + 24*Global`u^2*Log[1 - Global`u]*
        Log[-1 + Global`u]*Log[Global`u] + 24*Log[-1 + Global`u]^2*Log[Global`u] - 
       24*Global`u^2*Log[-1 + Global`u]^2*Log[Global`u] - 24*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[Global`u^(-1)]*Log[Global`u] - 24*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[Global`u^(-1)]*Log[Global`u] + 132*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] + 
       168*Global`u*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] + 
       36*Global`u^2*Log[1 - Global`u]*Log[Global`u^(-1)]*Log[Global`u] + 
       66*Log[Global`u^(-1)]^2*Log[Global`u] + 96*Global`u*Log[Global`u^(-1)]^2*Log[Global`u] + 
       30*Global`u^2*Log[Global`u^(-1)]^2*Log[Global`u] - 24*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 24*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 84*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 120*Global`u*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] + 36*Global`u^2*Log[1 - Global`u]*
        Log[(-1 + Global`u)/Global`u]*Log[Global`u] - 42*Log[(-1 + Global`u)/Global`u]^2*
        Log[Global`u] - 72*Global`u*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] - 
       30*Global`u^2*Log[(-1 + Global`u)/Global`u]^2*Log[Global`u] + 72*Log[(1 - Global`u)^(-1)]*
        Log[-Global`u]*Log[Global`u] + 84*Global`u*Log[(1 - Global`u)^(-1)]*Log[-Global`u]*
        Log[Global`u] + 12*Global`u^2*Log[(1 - Global`u)^(-1)]*Log[-Global`u]*Log[Global`u] + 
       1016*Log[Global`u]^2 + (264*I)*Pi*Log[Global`u]^2 + 744*Global`u*Log[Global`u]^2 + 
       (264*I)*Pi*Global`u*Log[Global`u]^2 - 176*Global`u^2*Log[Global`u]^2 + 
       54*Log[(1 - Global`u)^(-1)]*Log[Global`u]^2 + 54*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[Global`u]^2 + 276*Log[1 - Global`u]*Log[Global`u]^2 + 294*Global`u*Log[1 - Global`u]*
        Log[Global`u]^2 + 18*Global`u^2*Log[1 - Global`u]*Log[Global`u]^2 + 188*Log[Global`u]^3 + 
       164*Global`u*Log[Global`u]^3 - 24*Global`u^2*Log[Global`u]^3 - 
       2*Pi^2*Log[Global`u/(-1 + Global`u)] + 34*Pi^2*Global`u*Log[Global`u/(-1 + Global`u)] + 
       36*Pi^2*Global`u^2*Log[Global`u/(-1 + Global`u)] + 24*PolyLogTools`G[0, 1, -1]*
        Log[Global`u/(-1 + Global`u)] - 24*Global`u^2*PolyLogTools`G[0, 1, -1]*
        Log[Global`u/(-1 + Global`u)] - 12*Global`u*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[Global`u/(-1 + Global`u)] - 12*Global`u^2*PolyLogTools`G[0, 1, (1 - Global`u)^(-1)]*
        Log[Global`u/(-1 + Global`u)] + 6*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 6*Global`u^2*Log[(1 - Global`u)^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 12*Global`u*Log[1 - Global`u]^2*
        Log[Global`u/(-1 + Global`u)] - 12*Global`u^2*Log[1 - Global`u]^2*
        Log[Global`u/(-1 + Global`u)] + 6*Global`u*Log[-Global`u^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] + 6*Global`u^2*Log[-Global`u^(-1)]^2*
        Log[Global`u/(-1 + Global`u)] - 12*Global`u*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*
        Log[Global`u/(-1 + Global`u)] - 12*Global`u^2*Log[-Global`u^(-1)]*Log[Global`u^(-1)]*
        Log[Global`u/(-1 + Global`u)] - 48*Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 
       128*Global`u*Log[Global`u]*Log[Global`u/(-1 + Global`u)] - 176*Global`u^2*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 24*Log[1 - Global`u]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 36*Global`u*Log[1 - Global`u]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 12*Global`u^2*Log[1 - Global`u]*Log[Global`u]*
        Log[Global`u/(-1 + Global`u)] - 12*Global`u*Log[Global`u]^2*Log[Global`u/(-1 + Global`u)] - 
       12*Global`u^2*Log[Global`u]^2*Log[Global`u/(-1 + Global`u)] + 
       24*Log[Global`u/(-1 + Global`u)]^2 + 64*Global`u*Log[Global`u/(-1 + Global`u)]^2 + 
       88*Global`u^2*Log[Global`u/(-1 + Global`u)]^2 - 12*Log[(1 - Global`u)^(-1)]*
        Log[Global`u/(-1 + Global`u)]^2 - 6*Global`u*Log[(1 - Global`u)^(-1)]*
        Log[Global`u/(-1 + Global`u)]^2 + 6*Global`u^2*Log[(1 - Global`u)^(-1)]*
        Log[Global`u/(-1 + Global`u)]^2 - 36*Global`u*Log[Global`u]*Log[Global`u/(-1 + Global`u)]^
         2 - 36*Global`u^2*Log[Global`u]*Log[Global`u/(-1 + Global`u)]^2 + 
       30*Global`u*Log[Global`u/(-1 + Global`u)]^3 + 30*Global`u^2*Log[Global`u/(-1 + Global`u)]^
         3 + 16*Pi^2*Log[(1 + Global`u)^(-1)] + 16*Pi^2*Global`u*Log[(1 + Global`u)^(-1)] + 
       24*Log[Global`u]*Log[(1 + Global`u)^(-1)]^2 + 24*Global`u*Log[Global`u]*
        Log[(1 + Global`u)^(-1)]^2 + 16*Log[(1 + Global`u)^(-1)]^3 + 
       16*Global`u*Log[(1 + Global`u)^(-1)]^3 - 48*Log[Global`u]*Log[Global`u/(1 + Global`u)] + 
       48*Global`u*Log[Global`u]*Log[Global`u/(1 + Global`u)] + 24*Log[Global`u/(1 + Global`u)]^2 - 
       24*Global`u*Log[Global`u/(1 + Global`u)]^2 - 
       48*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1]*Log[1 + Global`u] - 
       48*Global`u*PolyLogTools`G[-1, -((1 + Global`u)/(1 - Global`u)), 1]*Log[1 + Global`u] - 
       48*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1]*Log[1 + Global`u] - 
       48*Global`u*PolyLogTools`G[-1, (1 + Global`u)/(1 - Global`u), 1]*Log[1 + Global`u] - 
       48*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1]*Log[1 + Global`u] - 
       48*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1, 1]*Log[1 + Global`u] - 
       48*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1]*Log[1 + Global`u] - 
       48*Global`u*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1, 1]*Log[1 + Global`u] + 
       48*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1]*Log[(1 + Global`u)/(1 - Global`u)] - 
       48*Global`u*PolyLogTools`G[-((1 + Global`u)/(1 - Global`u)), 1]*
        Log[(1 + Global`u)/(1 - Global`u)] - 48*PolyLogTools`G[(1 + Global`u)/(1 - Global`u), 1]*
        Log[(1 + Global`u)/(1 - Global`u)] + 48*Global`u*PolyLogTools`G[
         (1 + Global`u)/(1 - Global`u), 1]*Log[(1 + Global`u)/(1 - Global`u)] - 
       12*Log[Global`u]*PolyLog[2, 1 - (1 - Global`u)^(-1)] - 12*Global`u*Log[Global`u]*
        PolyLog[2, 1 - (1 - Global`u)^(-1)] + 24*Global`u*Log[1 - Global`u]*
        PolyLog[2, 1 - Global`u^(-1)] + 24*Global`u^2*Log[1 - Global`u]*
        PolyLog[2, 1 - Global`u^(-1)] + 12*Log[(1 - Global`u)^(-1)]*
        PolyLog[2, (1 - Global`u)^(-1)] + 12*Global`u*Log[(1 - Global`u)^(-1)]*
        PolyLog[2, (1 - Global`u)^(-1)] + 24*Global`u*Log[1 - Global`u]*PolyLog[2, 1 - Global`u] + 
       24*Global`u^2*Log[1 - Global`u]*PolyLog[2, 1 - Global`u] + 
       24*Log[2]*PolyLog[2, (4*Global`u)/(1 + Global`u)^2] + 24*Global`u*Log[2]*
        PolyLog[2, (4*Global`u)/(1 + Global`u)^2] - 24*Global`u*
        PolyLog[3, -((1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
           (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u]))] - 24*Global`u^2*
        PolyLog[3, -((1 - Sqrt[1 + (4*(1 - Global`u))/Global`u])/
           (1 + Sqrt[1 + (4*(1 - Global`u))/Global`u]))] - 12*PolyLog[3, (1 - Global`u)^(-1)] - 
       12*Global`u*PolyLog[3, (1 - Global`u)^(-1)] - 48*Global`u*PolyLog[3, 1 - Global`u] - 
       48*Global`u^2*PolyLog[3, 1 - Global`u] - 24*Global`u*PolyLog[3, Global`u^(-1)] - 
       24*Global`u^2*PolyLog[3, Global`u^(-1)] + 3622*Zeta[3] + 1916*Global`u*Zeta[3] - 
       1706*Global`u^2*Zeta[3])/(4*(-1 + Global`u)*Global`u*(1 + Global`u)*Global`\[Epsilon]^3), 
   "Validation" -> <|"AllDistinctSourceKernelsChecked" -> True, "TwoParameterValues" -> {1/3, 2/3}, 
     "ComponentManifest" -> "family_source_check_status.json", "NumericalChecksOnly" -> True, 
     "HighFoldDiagnosticTolerance" -> 1/10000, "ExactCoefficientAtoms" -> True|>, 
   "Complete" -> True, "Source" -> "differential_u_20260920/campaign/MB14u_result.m", 
   "Derivation" -> "differential_u_20260920/campaign/SOLUTION_LOG.md"|>|>;

Global`MB1uVal = Global`MBuResults["MB1u"]["Series"];
Global`MB2uVal = Global`MBuResults["MB2u"]["Series"];
Global`MB3uVal = Global`MBuResults["MB3u"]["Series"];
Global`MB4uVal = Global`MBuResults["MB4u"]["Series"];
Global`MB5uVal = Global`MBuResults["MB5u"]["Series"];
Global`MB6uVal = Global`MBuResults["MB6u"]["Series"];
Global`MB7uVal = Global`MBuResults["MB7u"]["Series"];
Global`MB8uVal = Global`MBuResults["MB8u"]["Series"];
Global`MB9uVal = Global`MBuResults["MB9u"]["Series"];
Global`MB10uVal = Global`MBuResults["MB10u"]["Series"];
Global`MB11uVal = Global`MBuResults["MB11u"]["Series"];
Global`MB12uVal = Global`MBuResults["MB12u"]["Series"];
Global`MB13uVal = Global`MBuResults["MB13u"]["Series"];
Global`MB14uVal = Global`MBuResults["MB14u"]["Series"];

Global`MBuResults
