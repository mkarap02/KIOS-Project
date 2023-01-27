close all;

var = 200;    %Day number of the pandemic.

figure(1);
plot(cellPrediction{var,1}(2,:),LineWidth=1.0)
hold on
plot(cellSevenDaysWindow{var,1}.Infected,LineWidth=1.0);
grid on
xlabel("Days")
ylabel("Percentage of Population")
title("Unvaccinated Infected")
legend("Predicted Trajectories","Trajectories from Data")

figure(2);
plot(cellPrediction{var,1}(3,:),LineWidth=1.0)
hold on
plot(cellSevenDaysWindow{var,1}.VaccinatedInfected,LineWidth=1.0);
grid on
xlabel("Days")
ylabel("Percentage of Population")
title("Vaccinated Infected")
legend("Predicted Trajectories","Trajectories from Data")
