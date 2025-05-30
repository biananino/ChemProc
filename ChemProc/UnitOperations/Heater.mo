within ChemProc.UnitOperations;

model Heater "Model of a heater to heat a material stream"
  extends ChemProc.Files.Icons.Heater;
  
    parameter ChemProc.Files.ChemsepDatabase.GeneralProperties C[Nc] "Component instances array" annotation(
    Dialog(tab = "Heater Specifications", group = "Component Parameters"));
    parameter Integer Nc "Number of components" annotation(
    Dialog(tab = "Heater Specifications", group = "Component Parameters"));
  //========================================================================================
  Real Fin(unit = "mol/s", min = 0, start = Fg) "Inlet stream molar flow rate";
  Real Pin(unit = "Pa", min = 0, start = Pg) "Inlet stream pressure";
  Real Tin(unit = "K", min = 0, start = Tg) "Inlet stream temperature";
  Real Hin(unit = "kJ/kmol",start=Htotg) "inlet stream molar enthalpy";
  Real xvapin(unit = "-", min = 0, max = 1, start = xvapg) "Inlet stream vapor phase mole fraction";
  
  Real x_c[Nc](each unit = "-", each min = 0, each max = 1) "Component mole fraction";
  Real Q(unit = "W") "Heat added";
  Real Fout(unit = "mol/s", min = 0, start = Fg) "outlet stream molar flow rate";
  Real Pout(unit = "Pa", min = 0, start = Pg) "Outlet stream pressure";
  Real Tout(unit = "K", min = 0, start = Tg) "Outlet stream temperature";
  Real Tdel(unit = "K") "Temperature Increase";
  Real xvapout(unit = "-", min = 0, max = 1, start = xvapg) "Outlet stream vapor mole fraction";
  Real Hout(unit = "kJ/kmol",start=Htotg) "outlet mixture molar enthalpy";
  //========================================================================================
  parameter Real Pdel(unit = "Pa") "Pressure drop" annotation(
    Dialog(tab = "Heater Specifications", group = "Calculation Parameters"));
  parameter Real Eff(unit = "-") "Efficiency" annotation(
    Dialog(tab = "Heater Specifications", group = "Calculation Parameters"));
  //========================================================================================
  ChemProc.Files.Interfaces.matConn In(Nc = Nc) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ChemProc.Files.Interfaces.matConn Out(Nc = Nc) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ChemProc.Files.Interfaces.enConn En annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //=========================================================================================
  extends GuessModels.InitialGuess;
equation
//connector equations
  In.P = Pin;
  In.T = Tin;
  In.F = Fin;
  In.H = Hin;
  In.x_pc[1, :] = x_c[:];
  In.xvap = xvapin;
  Out.P = Pout;
  Out.T = Tout;
  Out.F = Fout;
  Out.H = Hout;
  Out.x_pc[1, :] = x_c[:];
  Out.xvap = xvapout;
  En.Q = Q;
//=============================================================================================
  Fin = Fout;
//material balance
  Hin + Eff * Q / Fin = Hout;
//energy balance
  Pin - Pdel = Pout;
//pressure calculation
  Tin + Tdel = Tout;
//temperature calculation
  annotation(
    Documentation(info = "<html>
    <p>The <b>Heater</b> is used to simulate the heating process of a material stream.</p>
    <p>The heater model have following connection ports:
    <ol>
    <li>Two Material Streams:</li>
    <ul>
    <li>feed stream</li>
    <li>outlet stream</li>
    </ul>
    <li>One Energy Stream:</li>
    <ul>
    <li>heat added</li>
    </ul>
    </ol>
    </p>
    
    <p>Following calculation parameters must be provided to the heater:
    <ol><li>Pressure Drop (<b>Pdel</b>)</li>
    <li>Efficiency (<b>Eff</b>)</li>
    </ol>
    <div>The above variables have been declared of type <i>parameter Real.</i></div>
    <div>During simulation, their values can specified directly under <b>Heater Specifications</b> by double clicking on the heater model instance.</div>
    </p>
    <p>In addition to the above parameters, any one additional variable from the below list must be provided for the model to simulate successfully:
    <ol>
    <li>Outlet Temperature (<b>Tout</b>)</li>
    <li>Temperature Increase (<b>Tdel</b>)</li>
    <li>Heat Added (<b>Q</b>)</li>
    <li>Outlet Stream Vapor Phase Mole Fraction (<b>xvapout</b>)</li>
    </ol>
    <div>These variables are declared of type <i>Real.</i></div>
    <div>During simulation, value of one of these variables need to be defined in the equation section.</div></p>
    <p>&nbsp;</p>
    
    <p>For detailed explanation on how to use this model to simulate a Heater, go to <a href=\"modelica://ChemProc.Examples.Heater\">Heater Example</a></p>
    </html>"));
end Heater;
