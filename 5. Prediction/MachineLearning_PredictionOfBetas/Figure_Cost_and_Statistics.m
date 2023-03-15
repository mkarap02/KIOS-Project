close all;

var=1:j;      %Days range of the pandemic.
DatesTable=Trajectories.Dates(var);

figure(1)
plot(DatesTable,cell2mat(cellCost),LineWidth=1.0)
%hold on 
%plot(RmCost,LineWidth=1.0)
grid on
xlim([DatesTable(1) DatesTable(j)])
xlabel("Date")
ylabel("Cost")
title("Cost")

figure(2)
plot(DatesTable,cell2mat(cellDailyError),LineWidth=1.5)
%semilogy(DatesTable,F,LineWidth=1.5);
grid on
xlim([DatesTable(1) DatesTable(j)])
xlabel("Date")
ylabel("Infected Population")
title("Daily Error")

figure(3)
plot(DatesTable,cell2mat(cellPercentageErrorAvgOf7Days),LineWidth=1.5);
grid on
xlim([DatesTable(1) DatesTable(j)])
xlabel("Date")
ylabel("Percentage Error")
title("Average Percentage Error of every 7-days predicted window")

figure(5)
plot(DatesTable,cell2mat(cellPercentageErrorSumof7Days),LineWidth=1.5);
grid on
xlim([DatesTable(1) DatesTable(j)])
xlabel("Date")
ylabel("Percentage Error")
title("Summation Percentage Error of Every 7-days predicted window")

figure(6)
plot(DatesTable,cell2mat(cellTotalInfected(:,1)),LineWidth=1.5)
hold on
plot(DatesTable,cell2mat(cellTotalInfected(:,2)),LineWidth=1.5)
grid on
xlim([DatesTable(1) DatesTable(j)])
xlabel("Date")
ylabel("Infected Population")
title("Infected Population")
legend("Data","Prediction")

figure(7)
plot(Infected)
grid on
title("Infected Population")