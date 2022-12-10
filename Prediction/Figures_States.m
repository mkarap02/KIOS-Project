close all;

var = 200;    %Day number of the pandemic.
E=cell2mat(cellCost);
%Remove outliers:
RmCost=rmoutliers(E);
%Finding the average:
Avg=mean(RmCost);

figure(1);
plot(cellPredictedTrajectories{var,1}(2,:),LineWidth=1.0)
hold on
plot(cellData{var,1}.Infected,LineWidth=1.0);
title("Unvaccinated Infected")
legend("Predicted Trajectories","Trajectories from Data")

figure(2);
plot(cellPredictedTrajectories{var,1}(3,:),LineWidth=1.0)
hold on
plot(cellData{var,1}.VaccinatedInfected,LineWidth=1.0);
title("Vaccinated Infected")
legend("Predicted Trajectories","Trajectories from Data")

figure(3)
plot(cell2mat(cellCost),LineWidth=1.0)
%hold on 
%plot(RmCost,LineWidth=1.0)
title("Cost")