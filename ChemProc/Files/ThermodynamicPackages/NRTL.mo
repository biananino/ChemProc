within ChemProc.Files.ThermodynamicPackages;

  model NRTL
    import ChemProc.Files.ThermodynamicFunctions.*;
    parameter Integer Nc "Number of components";
    parameter ChemProc.Files.ChemsepDatabase.GeneralProperties C[Nc];
    Real x_pc[3, Nc](each unit = "-", each min = 0, each max = 1);
    Real P(unit = "Pa", min = 0) "Pressure";
    Real T(unit = "K") "Temperature";
    Real Pbubl(unit = "Pa", min = 0) "Bubble point pressure";
    Real Pdew(unit = "Pa", min = 0) "dew point pressure";
    ChemProc.Files.Models.gammaNRTL Gma(Nc = Nc, C = C, x_c = x_pc[2, :], T = T), GmaDew(Nc = Nc, C = C, x_c = xliqdew_c, T = T), GmaBubl(Nc = Nc, C = C, x_c = x_pc[1, :], T = T);
    Real xliqdew_c[Nc], rho_c[Nc];
    Real Cpres_p[3] "residual specific heat", Hres_p[3] "residual enthalpy", Sres_p[3] "residual Entropy", K_c[Nc], gma_c[Nc](each start = 1), gmabubl_c[Nc](each start = 1), gmadew_c[Nc](each start = 1);
    Real philiqbubl_c[Nc], phivapdew_c[Nc], Pvap_c[Nc];
  equation
    gma_c= Gma.gma_c;
    for i in 1:Nc loop
      xliqdew_c[i] = x_pc[1, i] * Pdew / (gmadew_c[i] * Pvap_c[i]);
      rho_c[i] = ChemProc.Files.ThermodynamicFunctions.Dens(C[i].LiqDen, C[i].Tc, T, P);
    end for;
    for i in 1:Nc loop
      philiqbubl_c[i] = 1;
      phivapdew_c[i] = 1;
    end for;
    for i in 1:Nc loop
      gmabubl_c[i] = GmaBubl.gma_c[i];
      gmadew_c[i] = GmaDew.gma_c[i];
    end for;
    for i in 1:Nc loop
      Pvap_c[i] = ChemProc.Files.ThermodynamicFunctions.Psat(C[i].VP, T);
    end for;
    for i in 1:Nc loop
      K_c[i] = gma_c[i] * Pvap_c[i] / P;
    end for;
    Cpres_p[:] = zeros(3);
    Hres_p[:] = zeros(3);
    Sres_p = zeros(3);
  end NRTL;
