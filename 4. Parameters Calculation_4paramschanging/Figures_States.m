close all;

var=520;    %Day number of the pandemic.

figure(1);
plot(cellXrev{var,1}(1,:))
hold on
plot(cellClearedTrajectories{var,1}.Susceptible)
title("Susceptible");

figure(2);
plot(cellXrev{var,1}(2,:),LineWidth=1.0)
hold on
plot(cellClearedTrajectories{var,1}.Infected,LineWidth=1.0)
grid on
title("Unvaccinated Infected");
xlabel('Days');
ylabel('Percentage of Population');
xlim([1 14])
legend("Model Results","Data")

figure(3);
%plot(x_rev(3,:))
plot(cellXrev{var,1}(3,:),LineWidth=1.0)
hold on
plot(cellClearedTrajectories{var,1}.VaccinatedInfected,LineWidth=1.0)
grid on
title("Vaccinated Infected");
xlabel('Days');
ylabel('Percentage of Population');
xlim([1 14])
legend("Model Results","Data")

figure(4);
%plot(x_rev(4,:))
plot(cellXrev{var,1}(4,:))
hold on
plot(cellClearedTrajectories{var,1}.Hospitalized)
title("Unvaccinated Hospitalized");

figure(5);
%plot(x_rev(5,:))
plot(cellXrev{var,1}(5,:))
hold on
plot(cellClearedTrajectories{var,1}.Recovered)
title("Recovered");

figure(6);
plot(cellXrev{var,1}(6,:))
hold on
plot(cellClearedTrajectories{var,1}.Extinct)
title("Extinct");

figure(7);
plot(cellXrev{var,1}(7,:))
hold on
plot(cellClearedTrajectories{var,1}.VaccinatedSusceptible)
title("Vaccinated Susceptible");

figure(8);
plot(cellXrev{var,1}(8,:))
hold on
plot(cellClearedTrajectories{var,1}.VaccinatedHospitalized)
title("Vaccinated Hospitalized");
