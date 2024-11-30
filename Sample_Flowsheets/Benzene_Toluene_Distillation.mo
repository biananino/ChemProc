package Benzene_Toluene_Distillation

  model Material_Streams
    // //instantiation of chemsep database
    import data = Simulator.Files.ChemsepDatabase;
    extends Simulator.Streams.MaterialStream(Nc = Nc, C = C, F_pc(each start = 1), x_pc(each start = 0.33), T(start = sum(C.Tb) / Nc));
    //material stream extended in which parameter NOC and comp are given values and other variables are given start values
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    //thermodynamic package Raoults law is extended
  end Material_Streams;

//Flowsheet: Methanol-Water Distillation
//Thermodynamic-Package:Raoults Law

  model Flowsheet_Two
      import data = Simulator.Files.ChemsepDatabase;
      //instantiation of Benzene
      parameter data.Benzene ben;
      //instantiation of Toluene
      parameter data.Toluene tol;
      //Number of Components
      parameter Integer Nc = 2;
      parameter data.GeneralProperties C[Nc] = {ben, tol};
      Benzene_Toluene_Distillation.Material_Streams Input(Nc = Nc, C = C) annotation(
        Placement(visible = true, transformation(origin = {-110, 36}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Benzene_Toluene_Distillation.Material_Streams Preheated_Feed(Nc = Nc, C = C, T(start = 353), x_pc(each start = 0.333), P(start = 101325)) annotation(
        Placement(visible = true, transformation(origin = {-22, 36}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Benzene_Toluene_Distillation.rigDist.DistColumn DC(Nc = Nc, C = C, Nt = 24, InT_s = {11}, each tray.Fliq_s(each start = 100), each tray.Fvap_s(each start = 150), each tray.T(start = 366)) annotation(
        Placement(visible = true, transformation(origin = {20, 36}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
      Benzene_Toluene_Distillation.Material_Streams Distillate(Nc = Nc, C = C) annotation(
        Placement(visible = true, transformation(origin = {56, 54}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Benzene_Toluene_Distillation.Material_Streams Bottoms(Nc = Nc, C = C, x_pc(each start = 0.5)) annotation(
        Placement(visible = true, transformation(origin = {63, 19}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      Simulator.Streams.EnergyStream C_Duty annotation(
        Placement(visible = true, transformation(origin = {52, 72}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Simulator.Streams.EnergyStream R_duty annotation(
        Placement(visible = true, transformation(origin = {58, -4}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Benzene_Toluene_Distillation.Material_Streams Outlet(Nc = Nc, C = C) annotation(
        Placement(visible = true, transformation(origin = {-23, 79}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      Simulator.UnitOperations.HeatExchanger rigorous_HX1(Nc=Nc,C=C,Pdelh=0,Pdelc=0,Qloss=0,Cmode="Outlet_Temparatures", Mode = "CounterCurrent") annotation(
      Placement(visible = true, transformation(origin = {-66, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
    connect(rigorous_HX1.In_Hot, Bottoms.Out) annotation(
      Line(points = {{-74, 60}, {-124, 60}, {-124, -20}, {82, -20}, {82, 18}, {70, 18}, {70, 20}}));
    connect(DC.Rduty, R_duty.In) annotation(
      Line(points = {{37, 12}, {52, 12}, {52, -4}}));
    connect(rigorous_HX1.Out_Hot, Outlet.In) annotation(
      Line(points = {{-58, 60}, {-46, 60}, {-46, 80}, {-30, 80}, {-30, 80}}));
    connect(rigorous_HX1.Out_Cold, Preheated_Feed.In) annotation(
      Line(points = {{-58, 54}, {-48, 54}, {-48, 36}, {-28, 36}, {-28, 36}, {-28, 36}}));
    connect(rigorous_HX1.In_Cold, Input.Out) annotation(
      Line(points = {{-74, 54}, {-88, 54}, {-88, 36}, {-104, 36}, {-104, 36}}));
    connect(DC.Bot, Bottoms.In) annotation(
      Line(points = {{44, 19}, {56, 19}}));
    connect(DC.Dist, Distillate.In) annotation(
      Line(points = {{44, 53}, {49, 53}, {49, 54}, {50, 54}}));
    connect(C_Duty.In, DC.Cduty) annotation(
      Line(points = {{46, 72}, {46, 57.5}, {34, 57.5}, {34, 59}}));
    connect(Preheated_Feed.Out, DC.In_s[1]) annotation(
      Line(points = {{-16, 36}, {-16, 34.5}, {-4, 34.5}, {-4, 35}}));
  //Design-Variables-
  
  //Inlet mixture molar composition
    Input.x_pc[1, :] = {0.5, 0.5};
      Input.T = 298.15;
      Input.F_p[1] = 27.78;
  //Input pressure
    Input.P = 101325;
  ////heat exchenger data
  
    
    rigorous_HX1.U=1000;
    rigorous_HX1.Qact=64017.165375;
  //Distillation Column
    DC.condenser.P = 101325;
      DC.reboiler.P = 101325;
  //Reflux Ratio
    DC.RR = 10;
  //Bottoms product molar flow rate
    Bottoms.F_p[1] = 12.5;
  end Flowsheet_Two;


//===============================================================================================

  package rigDist
    model Condensor
      extends Simulator.UnitOperations.DistillationColumn.Cond;
      extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    end Condensor;

    model Tray
      extends Simulator.UnitOperations.DistillationColumn.DistTray;
      extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    end Tray;

    model Reboiler
      extends Simulator.UnitOperations.DistillationColumn.Reb;
      extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    end Reboiler;

    model DistColumn
      extends Simulator.UnitOperations.DistillationColumn.DistCol(
      redeclare Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, T(start = 300)),
      redeclare Reboiler reboiler(Nc = Nc, C = C),
      redeclare Tray tray[Nt - 2](each Nc = Nc, each C = C, each Fliq_s(each start = 150), each Fvap_s(each start = 150)));
      
    end DistColumn;
  end rigDist;
end Benzene_Toluene_Distillation;