within ChemProc.Files.ThermodynamicFunctions;

function EOSConstants
  extends Modelica.Icons.Function;
  input Integer NOC;
  input Real Tc[NOC], Pc[NOC];
  input Real T;
  output Real a[NOC];
  protected parameter Real R_gas = 8.314;
algorithm
  for i in 1:NOC loop
    a[i] := 0.42748 * R_gas ^ 2 * (Tc[i] ^ 2.5 / (Pc[i] * T ^ 0.5));
  end for;
end EOSConstants;
