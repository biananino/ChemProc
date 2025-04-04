within ChemProc.Files.Icons;

model DistillationColumn "Basic graphical representation of Distillation Column"

  annotation(
    Icon(coordinateSystem(extent = {{-250, -600}, {250, 600}}, initialScale = 0.1), graphics = {Line(points = {{-250, 400}, {-250, -400}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{-70, 400}, {-70, -400}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{-250, 400}, {-190, 440}, {-130, 440}, {-70, 400}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier), Ellipse(origin = {150, 505}, lineColor = {0, 70, 70}, lineThickness = 0.3, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Ellipse(origin = {150, -503}, lineColor = {0, 70, 70}, lineThickness = 0.3, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Line(points = {{50, 500}, {-160, 500}, {-160, 440}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{-70, 300}, {250, 300}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{150, 400}, {150, 300}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{50, -500}, {-160, -500}, {-160, -440}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{150, -300}, {150, -400}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{250, -300}, {-70, -300}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{50, -400}, {250, -600}}, color = {255, 0, 0}, thickness = 0.3), Line(points = {{50, 400}, {250, 600}}, color = {255, 0, 0}, thickness = 0.3), Line(points = {{230, 600}, {250, 600}, {250, 580}}, color = {255, 0, 0}, thickness = 0.3), Line(points = {{70, -400}, {50, -400}, {50, -420}}, color = {255, 0, 0}, thickness = 0.3), Line(points = {{-250, 250}, {-150, 250}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{-250, 83}, {-150, 83}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{-250, -84}, {-150, -84}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{-250, -250}, {-150, -250}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{-170, 167}, {-70, 167}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{-170, 0}, {-70, 0}}, color = {0, 70, 70}, thickness = 0.3), Line(points = {{-170, -167}, {-70, -167}}, color = {0, 70, 70}, thickness = 0.3), Text(extent = {{-500, -620}, {500, -680}}, textString = "%name", fontSize = 10), Line(points = {{-250, -400}, {-190, -440}, {-130, -440}, {-70, -400}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier)}),
    Diagram(coordinateSystem(extent = {{-250, -600}, {250, 600}})),
    __OpenModelica_commandLineOptions = "",
  Documentation(info = "<html>
<p>
Model that has only basic icon for distillation column unit operation (No declarations and no equations).
</p>
</html>"));
end DistillationColumn;
