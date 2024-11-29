package Ethylene_Glycol_Production
  model Inlet_Stream
    // //instantiation of chemsep database
    import data = Simulator.Files.ChemsepDatabase;
    //instantiation of ethanol
    parameter data.Ethyleneoxide eth;
    //instantiation of Acetic acid
    parameter data.Water wat;
    //instantiation of water
    parameter data.Ethyleneglycol eg;
    extends Simulator.Streams.MaterialStream(Nc = Nc, C = {eth, wat, eg}, F_pc(each start = 1), x_pc(each start = 0.33), T(start = sum(C.Tb) / Nc));
    //material stream extended in which parameter NOC and comp are given values and other variables are given start values
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw(Nc = Nc, C = {eth, wat, eg}); 
    //thermodynamic package Raoults law is extended
  end Inlet_Stream;

  model PFR_Test
    //Solver: Dassl Number of Intervals: 50-100
    //Advisable to select the first component as the base component
    // Importing the thermodynamic data from chemsep database
    import data = Simulator.Files.ChemsepDatabase;
    //instantiation of ethanol
    parameter data.Ethyleneoxide eth;
    //instantiation of acetic acid
    parameter data.Ethyleneglycol eg;
    //instantiation of water
    parameter data.Water wat;
    parameter Integer Nc = 3;
    parameter data.GeneralProperties C[Nc] = {eth, wat, eg};
   
    //Instantiating the material stream model(as inlet and outlet) and also the model for CSTR with connectors
    Simulator.UnitOperations.PFR.PFR pfr1(Nc = 3, Nr = 1, C = {eth, wat, eg}, Mode = "Define Outlet Temperature", Phase = "Gaseous", Tdef = 420, Pdel = 2.03, Basis = "Molar Fractions", BC_r = {1}) annotation(
      Placement(visible = true, transformation(origin = {-2, 52}, extent = {{-50, -50}, {50, 50}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Inlet_Streams(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-59, 53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Outlet_Streams(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {64, 52}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Simulator.Streams.EnergyStream Energy annotation(
      Placement(visible = true, transformation(origin = {-33, 19}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.UnitOperations.Mixer Mixer(Nc = 3, NI = 2, C = {eth, wat, eg}, outPress = "Inlet_Minimum") annotation(
      Placement(visible = true, transformation(origin = {-100, 52}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Inlet_One(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-137, 83}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Inlet_Two(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-137, 19}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.UnitOperations.Cooler Cooler(Pdel = 0, Eff = 1, Nc = 3, C = {eth, wat, eg}) annotation(
      Placement(visible = true, transformation(origin = {117, 59}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Final_Stream(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {166, 58}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Simulator.Streams.EnergyStream Energy_II annotation(
      Placement(visible = true, transformation(origin = {133, 17}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Distillate(Nc = Nc, C = C) annotation(
      Placement(visible = true, transformation(origin = {-47, -27}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Flowsheet_Final.Inlet_Stream Bottoms(Nc = Nc, C = C, x_pc(each start=0.7)) annotation(
      Placement(visible = true, transformation(origin = {-47, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Simulator.Streams.EnergyStream C_duty annotation(
      Placement(visible = true, transformation(origin = {-66, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulator.Streams.EnergyStream R_duty annotation(
      Placement(visible = true, transformation(origin = {-3, -87}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    Flowsheet_Final.DC.DistColumn DC(Nc = Nc, C = C, Nt = 8, InT_s = {5},each tray.Fliq_s(each  start = 100), each tray.Fvap_s(each start = 150), each tray.T(start=366)) annotation(
      Placement(visible = true, transformation(origin = {-116, -50}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
  
  equation
  
    connect(DC.Rduty, R_duty.In) annotation(
      Line(points = {{-93, -82}, {-12, -82}, {-12, -87}}));
    connect(DC.Bot, Bottoms.In) annotation(
      Line(points = {{-84, -73}, {-54, -73}}));
    connect(DC.Dist, Distillate.In) annotation(
      Line(points = {{-84, -27}, {-54, -27}}));
    connect(DC.Cduty, C_duty.In) annotation(
      Line(points = {{-97, -19}, {-76, -19}, {-76, -6}}));
    connect(Final_Stream.Out, DC.In_s[1]) annotation(
      Line(points = {{174, 58}, {194, 58}, {194, 4}, {-174, 4}, {-174, -51}, {-147, -51}}));
    connect(Cooler.Out, Final_Stream.In) annotation(
      Line(points = {{146, 58}, {146, 57.5}, {158, 57.5}, {158, 58}}));
    connect(Inlet_One.Out, Mixer.In[1]) annotation(
      Line(points = {{-130, 83}, {-100, 83}, {-100, 52}}));
    connect(Inlet_Two.Out, Mixer.In[2]) annotation(
      Line(points = {{-130, 19}, {-100, 19}, {-100, 52}}));
    connect(Mixer.Out, Inlet_Streams.In) annotation(
      Line(points = {{-80, 52}, {-75.5, 52}, {-75.5, 53}, {-66, 53}}));
    connect(Inlet_Streams.Out, pfr1.In) annotation(
      Line(points = {{-52, 53}, {-45.5, 53}, {-45.5, 52}, {-42, 52}}));
    connect(Energy_II.Out, Cooler.En) annotation(
      Line(points = {{140, 17}, {140, 30.5}, {117, 30.5}, {117, 31}}));
    connect(pfr1.Out, Outlet_Streams.In) annotation(
      Line(points = {{42, 52}, {56, 52}}));
    connect(Energy.In, pfr1.En) annotation(
      Line(points = {{-40, 19}, {-8, 19}, {-8, 29}}));
    connect(Outlet_Streams.Out, Cooler.In) annotation(
      Line(points = {{72, 52}, {79, 52}, {79, 59}, {88, 59}}));
  //Design Variables
  //Molar Flow Rate of outlet stream of reactor
  //Pressure of the stream out of the reactor
    Inlet_One.P = 200000;
    Inlet_One.T = 395;
    
    Inlet_Two.P = 100000;
    Inlet_Two.T = 385;
    
    Inlet_One.F_p[1] = 20;
    Inlet_Two.F_p[1] = 80;
    
    Inlet_One.x_pc[1, :] = {1,0,0};
    Inlet_Two.x_pc[1, :] = {0,1,0};
  
  //Conversion of Base component - Ethylene Oxide
    pfr1.X_r[1] = 0.4199;
  
  //Cooler-Outlet temperature
    Cooler.Out.T = 250;
  
  //Distillation Column
    DC.condenser.P = 101325;
    DC.reboiler.P = 101325;
    DC.RR = 2;
    Bottoms.F_p[1] =10;
  
  annotation(
      Diagram(coordinateSystem(extent = {{-200, 100}, {260, -100}})));
  end PFR_Test;




























































































































  package Shortcut_DC
    model Shortcut
      extends Simulator.UnitOperations.ShortcutColumn;
      extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
    end Shortcut;
  end Shortcut_DC;

  package DC
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
  end DC;
end Ethylene_Glycol_Production;
