close all;

var=1:538;      %Days range of the pandemic.

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
plot(FillParam,LineWidth=1.0)
xlim([1 538])
title("Param Figure")

figure(2)
plot(FillParam1,LineWidth=1.0)
xlim([1 538])
title("Param1 - vaccinated person infects an unvaccinated person")

figure(3)
plot(FillParam2,LineWidth=1.0)
xlim([1 538])
title("Param2 - vaccinated person infects another vaccinated person")

figure(4)
plot(FillParam3,LineWidth=1.0)
xlim([1 538])
title("Param3 - unvaccinated person infects a vaccinated person")
