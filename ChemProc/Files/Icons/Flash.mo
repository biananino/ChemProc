within ChemProc.Files.Icons;

model Flash "Basic graphical representation of Flash Separator"

annotation(
     Icon(coordinateSystem(extent = {{-100, -200}, {100, 200}}, initialScale = 0.1), graphics = {Line(origin = {-100, 0}, points = {{0, 120}, {0, -120}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {100, 0}, points = {{0, 120}, {0, -120}}, color = {0, 70, 70}, thickness = 0.3), Rectangle(origin = {0, 125}, lineColor = {0, 70, 70}, lineThickness = 0.3, extent = {{-120, 5}, {120, -5}}), Rectangle(origin = {0, -125}, lineColor = {0, 70, 70}, lineThickness = 0.3, extent = {{-120, 5}, {120, -5}}), Text(extent = {{-500, -220}, {500, -280}}, textString = "%name", fontSize = 10), Line(origin = {-100, 0}, points = {{0, 130}, {0, 150}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {100, 0}, points = {{0, 130}, {0, 150}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {-100, 0}, points = {{0, -130}, {0, -150}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {100, 0}, points = {{0, -130}, {0, -150}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {0, 150}, points = {{-100, 0}, {-85, 20}, {-40, 40}, {40, 40}, {85, 20}, {100, 0}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier), Line(origin = {0, -150}, rotation = 180, points = {{-100, 0}, {-85, 20}, {-40, 40}, {40, 40}, {85, 20}, {100, 0}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier), Line(points = {{-100, 0}, {-87.5, -20}, {-62.5, 20}, {-37.5, -20}, {-12.5, 20}, {12.5, -20}, {37.5, 20}, {62.5, -20}, {87.5, 20}, {100, 0}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier)}),
   
    __OpenModelica_commandLineOptions = "",
     Documentation(info = "<html>
<p>
Model that has only basic icon for flash unit operation (No declarations and no equations).
</p>
</html>"));
end Flash;
