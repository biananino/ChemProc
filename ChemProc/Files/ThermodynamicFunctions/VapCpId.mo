within ChemProc.Files.ThermodynamicFunctions;

  function VapCpId "Function to compute Vapor Specific Heat at given temperature"
    extends Modelica.Icons.Function;
    input Real VapCp[6] "from chemsep database";
    input Real T(unit = "K") "Temperature";
    output Real Cpvap(unit = "J/mol.K") "specific heat";
  algorithm
    Cpvap := (VapCp[2] + exp(VapCp[3] / T + VapCp[4] + VapCp[5] * T + VapCp[6] * T ^ 2)) / 1000;
  end VapCpId;
