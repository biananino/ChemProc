within ChemProc.UnitOperations;
model RecycleBlock 
  extends ChemProc.Files.Icons.Recycle;
//========================================================================================
      Real Fin(start = Fg) "inlet mixture molar flow rate";
      Real Fout(start = Fg) "outlet mixture molar flow rate";
      Real Pin(start = Pg) "Inlet pressure";
      Real Pout(start = Pg) "Outlet pressure";
      Real Tin(start = Tg) "Inlet Temperature";
      Real Tout(start = Tg) "Outlet Temperature";
      //========================================================================================
      Real xin_c[Nc](each min = 0, each max = 1, start = xguess) "mixture mole fraction";
      Real xout_c[Nc](each min = 0, each max = 1, start = xguess);
      parameter Integer Nc "number of components";
      parameter ChemProc.Files.ChemsepDatabase.GeneralProperties C[Nc];
      //========================================================================================
      ChemProc.Files.Interfaces.matConn inlet(Nc = Nc) annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ChemProc.Files.Interfaces.matConn outlet(Nc = Nc) annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //=========================================================================================
      extends ChemProc.GuessModels.InitialGuess;
    equation
//connector equations
      inlet.P = Pin;
      inlet.T = Tin;
      inlet.F = Fin;
      inlet.x_pc[1, :] = xin_c[:];
      outlet.P = Pout;
      outlet.T = Tout;
      outlet.F = Fout;
      outlet.x_pc[1, :] = xout_c[:];
//=============================================================================================
      Fin = Fout;
//material balance
      xin_c = xout_c;
//energy balance
      Pin = Pout;
//pressure calculation
      Tin = Tout;
//temperature calculation
  
    end RecycleBlock;
