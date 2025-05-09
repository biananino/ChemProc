within ChemProc.Files.Models.ReactionManager;

function BaseCalc "Function to determine the base component in a reaction equation"
extends Modelica.Icons.Function;
input Integer Nc"Numner of components";
input Real F[Nc]"Stream flow rate";
input Real Sc[Nc]"Stoichiometric coefficient of the model";
output Integer N"Component index of the result check";

protected
Real v1;
Real v2;

algorithm

for i in 1:Nc loop
 if Sc[i]<0 then
 N:=i;
 break;
 end if;
end for;

v1:=F[N]/abs(Sc[N]);
 
for i in 1:Nc loop
if Sc[i]<0 then
 v2:=F[i]/abs(Sc[i]);
if v2<v1 then
 N:=i;
 v1:=v2;
 end if;
 end if;
 end for;
end BaseCalc;
