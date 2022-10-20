close all;

var=200:750;

figure(1)
plot(cell2mat(cellParam(var,1)))  
title("Param Figure")

figure(2)
plot(cell2mat(cellParam1(var,1)))    
title("Param1 Figure")

figure(3)
plot(cell2mat(cellParam2(var,1)))    
title("Param2 Figure")

figure(4)
plot(cell2mat(cellParam3(var,1)))    
title("Param3 Figure")

figure (5)
plot(cell2mat(cellFinalCost(var,1)))
title("Cost")