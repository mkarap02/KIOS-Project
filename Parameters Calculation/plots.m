close all;

figure(1);
%plot(x_rev(1,:))
plot(cellXrev{600, 1}(1,:))
hold on
plot(ClearedTrajectories.Susceptible);
title("Susceptible");

figure(2);
%plot(x_rev(2,:))
plot(cellXrev{600, 1}(2,:))
hold on
plot(ClearedTrajectories.Infected);
title("Unvaccinated Infected");

figure(3);
%plot(x_rev(3,:))
plot(cellXrev{600, 1}(3,:))
hold on
plot(ClearedTrajectories.VaccinatedInfected);
title("Vaccinated Infected");

figure(4);
%plot(x_rev(4,:))
plot(cellXrev{600, 1}(4,:))
hold on
plot(ClearedTrajectories.Hospitalized);
title("Unvaccinated Hospitalized (Acutely Symptomatic)");

figure(5);
%plot(x_rev(5,:))
plot(cellXrev{600, 1}(5,:))
hold on
plot(ClearedTrajectories.Recovered);
title("Recovered");

figure(6);
%plot(x_rev(6,:))
plot(cellXrev{600, 1}(6,:))
hold on
plot(ClearedTrajectories.Extinct);
title("Extinct");

figure(7);
%plot(x_rev(7,:))
plot(cellXrev{600, 1}(7,:))
hold on
plot(ClearedTrajectories.VaccinatedSusceptible);
title("Vaccinated Susceptible");

figure(8);
%plot(x_rev(8,:))
plot(cellXrev{600, 1}(8,:))
hold on
plot(ClearedTrajectories.VaccinatedHospitalized);
title("Vaccinated Hospitalized");
