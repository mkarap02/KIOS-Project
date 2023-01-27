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

%Policies=[8 7 8.5 11.5 12.5 13 12 13 14.5 12.5 14.5 13.5 13 13.5 16 15 14 13.5 12.5 12 13 13 12 10.5 10.5 11.5 10 11 8 7 6 7];
Policies1=[0.59375/2; 0.5625/2; 0.5/2; 0.4375/2; 0.53125/2; 0.71875/2; 0.78125/2; 0.8125/2; 0.75/2; 0.8125/2; 0.90625/2; 0.78125/2; 0.90625/2; 0.84375/2; 0.8125/2; 0.84375/2; 1/2; 0.9375/2; 0.875/2; 0.84375/2; 0.78125/2; 0.75/2; 0.8125/2; 0.8125/2; 0.75/2; 0.65625/2; 0.65625/2; 0.71875/2; 0.625/2; 0.6875/2; 0.5/2; 0.4375/6; 0.375/6; 0.4375/6];
Policies2=[0.59375/6; 0.5625/6; 0.5/6; 0.4375/6; 0.53125/6; 0.71875/6; 0.78125/6; 0.8125/6; 0.75/6; 0.8125/6; 0.90625/6; 0.78125/6; 0.90625/6; 0.84375/6; 0.8125/6; 0.84375/6; 1/6; 0.9375/6; 0.875/6; 0.84375/6; 0.78125/6; 0.75/6; 0.8125/6; 0.8125/6; 0.75/6; 0.65625/6; 0.65625/6; 0.71875/6; 0.625/6; 0.6875/6; 0.5/6; 0.4375/6; 0.375/6; 0.4375/6];
sz = [34 2];
varTypes = ["datetime","double"];
varNames = ["Dates","Policy"];
PoliciesTab1 = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);
PoliciesTab2 = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);
PoliciesTab1.Dates(1)=Trajectories.Dates(1);
PoliciesTab1.Dates(2)=Trajectories.Dates(14);
PoliciesTab1.Dates(3)=Trajectories.Dates(39);
PoliciesTab1.Dates(4)=Trajectories.Dates(48);
PoliciesTab1.Dates(5)=Trajectories.Dates(50);
PoliciesTab1.Dates(6)=Trajectories.Dates(53);
PoliciesTab1.Dates(7)=Trajectories.Dates(64);
PoliciesTab1.Dates(8)=Trajectories.Dates(73);
PoliciesTab1.Dates(9)=Trajectories.Dates(91);
PoliciesTab1.Dates(10)=Trajectories.Dates(94);
PoliciesTab1.Dates(11)=Trajectories.Dates(112);
PoliciesTab1.Dates(12)=Trajectories.Dates(115);
PoliciesTab1.Dates(13)=Trajectories.Dates(117);
PoliciesTab1.Dates(14)=Trajectories.Dates(120);
PoliciesTab1.Dates(15)=Trajectories.Dates(123);
PoliciesTab1.Dates(16)=Trajectories.Dates(125);
PoliciesTab1.Dates(17)=Trajectories.Dates(132);
PoliciesTab1.Dates(18)=Trajectories.Dates(154);
PoliciesTab1.Dates(19)=Trajectories.Dates(182);
PoliciesTab1.Dates(20)=Trajectories.Dates(197);
PoliciesTab1.Dates(21)=Trajectories.Dates(213);
PoliciesTab1.Dates(22)=Trajectories.Dates(214);
PoliciesTab1.Dates(23)=Trajectories.Dates(238);
PoliciesTab1.Dates(24)=Trajectories.Dates(252);
PoliciesTab1.Dates(25)=Trajectories.Dates(267);
PoliciesTab1.Dates(26)=Trajectories.Dates(281);
PoliciesTab1.Dates(27)=Trajectories.Dates(295);
PoliciesTab1.Dates(28)=Trajectories.Dates(330);
PoliciesTab1.Dates(29)=Trajectories.Dates(366);
PoliciesTab1.Dates(30)=Trajectories.Dates(456);
PoliciesTab1.Dates(31)=Trajectories.Dates(488);
PoliciesTab1.Dates(32)=Trajectories.Dates(497);
PoliciesTab1.Dates(33)=Trajectories.Dates(513);
PoliciesTab1.Dates(34)=Trajectories.Dates(577);
PoliciesTab1.Policy=Policies1;
PoliciesTab2.Dates=PoliciesTab1.Dates;
PoliciesTab2.Policy=Policies2;

%Figures.
figure(1)
plot(DatesTable,FillParam,LineWidth=1.5)
hold on
plot(PoliciesTab1.Dates,PoliciesTab1.Policy,LineStyle="-.",LineWidth=1.0);
grid on
%plot([5 5],ylim,"Color",'g','LineWidth',1.0,'LineStyle','--'); %Drawing vertical lines in plot
%plot([25 25],ylim,"Color",'y','LineWidth',1.0,'LineStyle','--');
%plot([75 75],ylim,"Color",'r','LineWidth',1.0,'LineStyle','--');
%plot([160 160],ylim,"Color",'y','LineWidth',1.0,'LineStyle','--');
%plot([430 430],ylim,"Color",'r','LineWidth',1.0,'LineStyle','--');
%plot([470 470],ylim,"Color",'g','LineWidth',1.0,'LineStyle','--');
xlim([DatesTable(1) DatesTable(564)]);
title('$\beta(1-u)$','Interpreter','latex')
legend("Parameter Value","Measures")

figure(2)
plot(DatesTable,FillParam1,LineWidth=1.5)
hold on
plot(PoliciesTab1.Dates,PoliciesTab1.Policy,LineStyle="-.",LineWidth=1.0);
grid on
xlim([DatesTable(1) DatesTable(564)]);
title('$\tilde{\beta}(1-u)$','Interpreter','latex')
legend("Parameter Value","Measures")

figure(3)
plot(DatesTable,FillParam2,LineWidth=1.5)
hold on
plot(PoliciesTab2.Dates,PoliciesTab2.Policy,LineStyle="-.",LineWidth=1.0);
grid on
xlim([DatesTable(1) DatesTable(564)]);
title('$\hat{\beta}(1-u)$','Interpreter','latex')
legend("Parameter Value","Measures")

figure(4)
plot(DatesTable,FillParam3,LineWidth=1.5)
hold on
plot(PoliciesTab1.Dates,PoliciesTab1.Policy,LineStyle="-.",LineWidth=1.0);
grid on
xlim([DatesTable(1) DatesTable(564)]);
title('$\bar{\beta}(1-u)$','Interpreter','latex')
legend("Parameter Value","Measures")
