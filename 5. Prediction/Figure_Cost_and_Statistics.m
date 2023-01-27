close all;

E=cell2mat(cellCost);
F=cell2mat(cellDailyError);

var=1:j;      %Days range of the pandemic.
DatesTable=Trajectories.Dates(var);

%Remove outliers:
RmCost=rmoutliers(E);

%Finding the average:
Avg=mean(RmCost);

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
plot(DatesTable,F,LineWidth=1.5)
%semilogy(DatesTable,F,LineWidth=1.5); 
grid on
xlim([DatesTable(1) DatesTable(j)])
xlabel("Date")
ylabel("Infected Population")
title("Daily Error")

figure(3)
plot(DatesTable,cell2mat(cellPercentageError),LineWidth=1.5);
grid on
xlim([DatesTable(1) DatesTable(j)])
xlabel("Date")
ylabel("Percentage Error")
title("Percentage Error")