figure(1);
plot(x_rev(1,:))
hold on
plot(ClearedTrajectories.Susceptible);

figure(2);
plot(x_rev(2,:))
hold on
plot(ClearedTrajectories.Infected);

figure(3);
plot(x_rev(3,:))
hold on
plot(ClearedTrajectories.VaccinatedInfected);

figure(4);
plot(x_rev(4,:))
hold on
plot(ClearedTrajectories.Hospitalized);

figure(5);
plot(x_rev(5,:))
hold on
plot(ClearedTrajectories.Recovered);


figure(6);
plot(x_rev(6,:))
hold on
plot(ClearedTrajectories.Extinct);


figure(7);
plot(x_rev(7,:))
hold on
plot(ClearedTrajectories.VaccinatedSusceptible);

figure(8);
plot(x_rev(8,:))
hold on
plot(ClearedTrajectories.VaccinatedHospitalized);

