package BTX
  model ms"material stream"
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end ms;
  
   model Condensor
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Condensor;


  model Tray
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Tray;


  model Reboiler
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.NRTL;
  end Reboiler;

  model DistColumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol(
      redeclare Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, T(start = 400)),
      redeclare Reboiler reboiler(Nc = Nc, C = C), 
      redeclare Tray tray[Nt - 2](each Nc = Nc, each C = C, each Fliq_s(each start = 10), each Fvap_s(each start = 10)));
  end DistColumn;
  
  model flowsheet
    import feed_data = Simulator.Files.ChemsepDatabase;
    parameter feed_data.Benzene benzene;
    parameter feed_data.Toluene toluene;
    parameter feed_data.Pxylene xylene;
    parameter Integer Nc = 3;
    parameter feed_data.GeneralProperties C[Nc] = {benzene, toluene, xylene};
    BTX.ms feed(Nc  = Nc, C = C)  annotation(
      Placement(visible = true, transformation(origin = {-76, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BTX.DistColumn distColumn1(Nc = Nc, C = C, InT_s = {10}, Nt = 20, Ni = 1)  annotation(
      Placement(visible = true, transformation(origin = {-26, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BTX.ms ben(Nc = Nc, C = C)  annotation(
      Placement(visible = true, transformation(origin = {26, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BTX.ms bott(Nc = Nc, C = C)  annotation(
      Placement(visible = true, transformation(origin = {42, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream energy_Stream1 annotation(
      Placement(visible = true, transformation(origin = {-27, 35}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Simulator.Streams.EnergyStream energy_Stream2 annotation(
      Placement(visible = true, transformation(origin = {-25, -7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  BTX.DistColumn distColumn2(Nc = Nc, C = C, InT_s = {15}, Nt = 30)  annotation(
      Placement(visible = true, transformation(origin = {102, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BTX.ms tol(Nc = Nc, C = C)  annotation(
      Placement(visible = true, transformation(origin = {160, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ms xyl(Nc = Nc, C = C)  annotation(
      Placement(visible = true, transformation(origin = {158, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Simulator.Streams.EnergyStream energy_Stream3 annotation(
      Placement(visible = true, transformation(origin = {102, -2.22045e-16}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Simulator.Streams.EnergyStream energy_Stream4 annotation(
      Placement(visible = true, transformation(origin = {102, 36}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  equation
    connect(distColumn1.Dist, ben.In) annotation(
      Line(points = {{-16, 22}, {-10, 22}, {-10, 62}, {16, 62}}));
    connect(energy_Stream1.Out, distColumn1.Cduty) annotation(
      Line(points = {{-22, 35}, {-22, 29.5}, {-20, 29.5}, {-20, 24}}));
    connect(distColumn2.Rduty, energy_Stream3.Out) annotation(
      Line(points = {{110, 8}, {110, 3.5}, {106, 3.5}, {106, 0}}));
    connect(distColumn2.Cduty, energy_Stream4.Out) annotation(
      Line(points = {{108, 28}, {108, 32}, {106, 32}, {106, 36}}));
    connect(distColumn1.Rduty, energy_Stream2.Out) annotation(
      Line(points = {{-18, 4}, {-18, -1.5}, {-20, -1.5}, {-20, -7}}));
    connect(distColumn2.Dist, tol.In) annotation(
      Line(points = {{112, 26}, {138, 26}, {138, 50}, {150, 50}}));
    connect(distColumn2.Bot, xyl.In) annotation(
      Line(points = {{112, 10}, {138, 10}, {138, -22}, {148, -22}, {148, -22}}));
    connect(bott.Out, distColumn2.In_s[1]) annotation(
      Line(points = {{52, -22}, {68, -22}, {68, 18}, {92, 18}, {92, 18}}));
    connect(distColumn1.Bot, bott.In) annotation(
      Line(points = {{-16, 6}, {-10, 6}, {-10, -22}, {32, -22}}));
    connect(feed.Out, distColumn1.In_s[1]) annotation(
      Line(points = {{-66, 12}, {-36, 12}, {-36, 14}, {-36, 14}}));
    feed.P = 101325;
    feed.T = 298.15;
    feed.x_pc[1, :] = {0.333, 0.333, 0.333};
    feed.F_p[1] = 10.049;
  
    distColumn1.condenser.P = 101325;
    distColumn1.reboiler.P = 101325;
    distColumn1.RR = 2;
    bott.F_p[1] = 6.7;
    
    distColumn2.condenser.P = 101325;
    distColumn2.reboiler.P = 101325;
    distColumn2.RR = 3;
    xyl.F_p[1] = 3.349;
  annotation(
      Diagram(coordinateSystem(extent = {{-100, -100}, {200, 100}}, initialScale = 0.1), graphics = {Text(origin = {14, 106}, extent = {{-44, 20}, {96, -50}}, textString = "BTX separation columns", fontName = "MV Boli"), Text(origin = {125, 76}, extent = {{-69, 14}, {-1, -4}}, textString = "-MehulKumar Sutariya", fontName = "Segoe Script"), Text(origin = {63, -93}, extent = {{-91, -1}, {87, -7}}, textString = "Total time = 1500 seconds"), Text(origin = {19, 55}, extent = {{-7, 5}, {25, -17}}, textString = "Benzene"), Text(origin = {157, 36}, extent = {{-15, 8}, {19, -10}}, textString = "Toluene"), Text(origin = {166, -43}, extent = {{-18, 9}, {8, -1}}, textString = "Xylene"), Text(origin = {-78, -9}, extent = {{-10, 7}, {10, -7}}, textString = "FEED")}),
      Icon(coordinateSystem(extent = {{-100, -100}, {200, 100}})),
      __OpenModelica_commandLineOptions = "");
      end flowsheet;






end BTX;