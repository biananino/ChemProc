within ChemProc.Files.Icons;

model ConversionReactor "Basic graphical representation of Conversion Reactor"

annotation(
    Icon(coordinateSystem(extent = {{-100, -200}, {100, 200}}), graphics = {Line(points = {{-100, 120}, {-100, -120}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {100, 0}, points = {{0, 120}, {0, -120}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {0, 150}, points = {{-100, 0}, {-85, 20}, {-40, 40}, {40, 40}, {85, 20}, {100, 0}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier), Rectangle(origin = {0, 125}, lineColor = {0, 70, 70}, lineThickness = 0.3, extent = {{-120, 5}, {120, -5}}), Rectangle(origin = {0, -125}, lineColor = {0, 70, 70}, lineThickness = 0.3, extent = {{-120, 5}, {120, -5}}), Text(extent = {{-500, -220}, {500, -280}}, textString = "%name", fontSize = 10), Line(origin = {0, 80}, points = {{-100, 0}, {100, 0}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{100, -80}, {33.3, 80}, {-33.3, -80}, {-100, 80}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {-2, 1.58}, points = {{-100, -80}, {-33.3, 80}, {33.3, -80}, {100, 80}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {-100, 0}, points = {{0, 130}, {0, 150}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {100, 0}, points = {{0, 130}, {0, 150}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {-100, 0}, points = {{0, -130}, {0, -150}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {100, 0}, points = {{0, -130}, {0, -150}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {0, -150}, rotation = 180, points = {{-100, 0}, {-85, 20}, {-40, 40}, {40, 40}, {85, 20}, {100, 0}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier), Line(origin = {0, -80}, points = {{-100, 0}, {100, 0}}, color = {0, 70, 70}, thickness = 0.3)}),
    __OpenModelica_commandLineOptions = "",
    Diagram(coordinateSystem(extent = {{-100, -200}, {100, 200}})),
  Documentation(info = "<html>
<p>
Model that has only basic icon for conversion reactor unit operation (No declarations and no equations).
</p>
</html>"));
end ConversionReactor;
