within ChemProc.Files.ThermodynamicFunctions;

  function HLiqId "Function to compute the Enthalpy of Ideal Liquid"
    extends Modelica.Icons.Function;
    input Real SH(unit = "J/kmol") "from chemsep database std. Heat of formation";
    input Real VapCp[6] "from chemsep database";
    input Real HOV[6] "from chemsep database";
    input Real Tc "critical temp, from chemsep database";
    input Real T(unit = "K") "Temperature";
    output Real Hliq(unit = "J/mol") "Molar Enthalpy";
  algorithm
    Hliq := HVapId(SH, VapCp, HOV, Tc, T) - ThermodynamicFunctions.HV(HOV, Tc, T);
  end HLiqId;
