close all;

var=1:538;    %Days range of the pandemic.

figure(1)
plot(cell2mat(cellParam(var,1)),LineWidth=1.0)
xlim([1 538])
title("Param Figure")

figure(2)
plot(cell2mat(cellParam1(var,1)),LineWidth=1.0)
xlim([1 538])
title("Param1 - vaccinated person infects an unvaccinated person")

figure(3)
plot(cell2mat(cellParam2(var,1)),LineWidth=1.0)
xlim([1 538])
title("Param2 - vaccinated person infects another vaccinated person")

figure(4)
plot(cell2mat(cellParam3(var,1)),LineWidth=1.0)
xlim([1 538])
title("Param3 - unvaccinated person infects a vaccinated person")
