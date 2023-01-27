close all;

var=1:564;    %Days range of the pandemic.

A=cell2mat(cellParam);
B=cell2mat(cellParam1);
C=cell2mat(cellParam2);
D=cell2mat(cellParam3);

%Calculating Moving Average.
windowSize = 7;
MvAvgParam = movmean(A,windowSize);
MvAvgParam1 = movmean(B,windowSize);
MvAvgParam2 = movmean(C,windowSize);
MvAvgParam3 = movmean(D,windowSize);

%Removing and Filling Outliers.
FillParam=filloutliers(A,"nearest");
FillParam1=filloutliers(B,"nearest");
FillParam2=filloutliers(C,"nearest");
FillParam3=filloutliers(D,"nearest");

%Figures.
figure(1)
plot(cell2mat(cellParam(var,1)),LineWidth=1.0)
hold on
plot(MvAvgParam,LineWidth=1.0)
hold on
plot(FillParam,LineWidth=1.0)
xlim([1 538])
title("Param Figure")
legend("Initial Results","Results with Moving Average","Results with Outliers Removed")

figure(2)
plot(cell2mat(cellParam1(var,1)),LineWidth=1.0)
hold on
plot(MvAvgParam1,LineWidth=1.0)
hold on
plot(FillParam1,LineWidth=1.0)
xlim([1 538])
title("Param1 - vaccinated person infects an unvaccinated person")
legend("Initial Results","Results with Moving Average","Results with Outliers Removed")

figure(3)
plot(cell2mat(cellParam2(var,1)),LineWidth=1.0)
hold on
plot(MvAvgParam2,LineWidth=1.0)
hold on
plot(FillParam2,LineWidth=1.0)
xlim([1 538])
title("Param2 - vaccinated person infects another vaccinated person")
legend("Initial Results","Results with Moving Average","Results with Outliers Removed")

figure(4)
plot(cell2mat(cellParam3(var,1)),LineWidth=1.0)
hold on
plot(MvAvgParam3,LineWidth=1.0)
hold on
plot(FillParam3,LineWidth=1.0)
xlim([1 538])
title("Param3 - unvaccinated person infects a vaccinated person")
legend("Initial Results","Results with Moving Average","Results with Outliers Removed")