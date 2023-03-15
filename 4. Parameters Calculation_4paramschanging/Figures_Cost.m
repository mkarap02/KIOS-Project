%Final Cost: its the final minimum cost before flag becomes 1.

close all;

var=1:564;    %Days range of the pandemic.

E=cell2mat(cellFinalCost);

%Calculating Moving Average
windowSize = 7;
MvAvgCost = movmean(E,windowSize);

%Finding, Removing, and Filling Outliers.
FillCost=filloutliers(E,"nearest");

figure (1)
plot(cell2mat(cellFinalCost(var,1)),LineWidth=1.0)
hold on 
%plot(MvAvgCost,LineWidth=1.0)
%hold on
%plot(FillCost,LineWidth=1.0)
xlim([1 564])
title("Cost")
%legend("Initial Results","Results with Moving Average","Results with Outliers Removed")

figure(2)
plot(FillCost,LineWidth=1.0)
xlim([1 564])
title("Cost with outliers Removed")