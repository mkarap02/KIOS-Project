close all;

var=1:564;      %Days range of the pandemic.

DatesTable=Trajectories.Dates(var);

A=cell2mat(cellParam);
B=cell2mat(cellParam1);
C=cell2mat(cellParam2);
D=cell2mat(cellParam3);

%Finding Outliers.
OutParam=isoutlier(A);
OutParam1=isoutlier(B);
OutParam2=isoutlier(C);
OutParam3=isoutlier(D);

%Finding the outliers values.
%ind=find(OutParam);

%Remove outliers.
RmParam=rmoutliers(A);
RmParam1=rmoutliers(B);
RmParam2=rmoutliers(C);
RmParam3=rmoutliers(D);

%Removing and Filling Outliers.
FillParam=filloutliers(A,"nearest");
FillParam1=filloutliers(B,"nearest");
FillParam2=filloutliers(C,"nearest");
FillParam3=filloutliers(D,"nearest");


%Figures.
figure(1)
plot(DatesTable,FillParam,LineWidth=1.5)
grid on
xlim([DatesTable(1) DatesTable(538)]);
title('$\beta(1-u)$','Interpreter','latex')
legend("Parameter Value","Measures")

figure(2)
plot(DatesTable,FillParam1,LineWidth=1.5)
grid on
xlim([DatesTable(1) DatesTable(538)]);
title('$\tilde{\beta}(1-u)$','Interpreter','latex')
legend("Parameter Value","Measures")

figure(3)
plot(DatesTable,FillParam2,LineWidth=1.5)
grid on
xlim([DatesTable(1) DatesTable(538)]);
title('$\hat{\beta}(1-u)$','Interpreter','latex')
legend("Parameter Value","Measures")

figure(4)
plot(DatesTable,FillParam3,LineWidth=1.5)
grid on
xlim([DatesTable(1) DatesTable(538)]);
title('$\bar{\beta}(1-u)$','Interpreter','latex')
legend("Parameter Value","Measures")
