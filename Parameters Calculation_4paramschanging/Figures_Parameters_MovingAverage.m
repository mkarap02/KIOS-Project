close all;

windowSize = 7;

A=cell2mat(cellParam);
B=cell2mat(cellParam1);
C=cell2mat(cellParam2);
D=cell2mat(cellParam3);
E=cell2mat(cellFinalCost);

MvAvgParam = movmean(A,windowSize);
MvAvgParam1 = movmean(B,windowSize);
MvAvgParam2 = movmean(C,windowSize);
MvAvgParam3 = movmean(D,windowSize);
MvAvgCost = movmean(E,windowSize);

figure(1)
plot(A,LineWidth=1.5)
hold on
plot(MvAvgParam,LineWidth=1.5)
xlim([1 538])
title("Param")
legend("Initial Results","Results with Moving Average")

figure(2)
plot(B,LineWidth=1.5)
hold on
plot(MvAvgParam1,LineWidth=1.5)
xlim([1 538])
title("Param1")
legend("Initial Results","Results with Moving Average")

figure(3)
plot(C,LineWidth=1.5)
hold on
plot(MvAvgParam2,LineWidth=1.5)
xlim([1 538])
title("Param2")
legend("Initial Results","Results with Moving Average")

figure(4)
plot(D,LineWidth=1.5)
hold on
plot(MvAvgParam3,LineWidth=1.5)
xlim([1 538])
title("Param3")
legend("Initial Results","Results with Moving Average")
