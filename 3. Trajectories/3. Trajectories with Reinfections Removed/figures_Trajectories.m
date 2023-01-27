close all;

figure (1)
plot(Results.Date,Results.Susceptible,LineWidth=1.5)
grid on
xlim([Results.Date(1) Results.Date(783)])
xlabel("Date")
ylabel("Population")
title("Susceptible")

figure (2)
plot(Results.Date,Results.VaccinatedSusceptible,LineWidth=1.5)
grid on
xlim([Results.Date(1) Results.Date(783)])
xlabel("Date")
ylabel("Population")
title("Vaccinated Susceptible")

figure (3)
plot(Results.Date,Results.Infected,LineWidth=1.5)
hold on
plot(Results.Date,Results.VaccinatedInfected,LineWidth=1.5)
grid on
xlim([Results.Date(1) Results.Date(783)])
xlabel("Date")
ylabel("Population")
legend("Unvaccinated Infected","Vaccinated Infected")
title("Infected")

figure (4)
plot(Results.Date,Results.Hospitalized,LineWidth=1.5)
grid on
xlim([Results.Date(1) Results.Date(783)])
xlabel("Date")
ylabel("Population")
title("Unvaccinated Hospitalized")

figure (5)
plot(Results.Date,Results.VaccinatedHospitalized,LineWidth=1.5)
grid on
xlim([Results.Date(1) Results.Date(783)])
xlabel("Date")
ylabel("Population")
title("Vaccinated Hospitalized")

figure (6)
plot(Results.Date,Results.Recovered,LineWidth=1.5)
grid on
xlim([Results.Date(1) Results.Date(783)])
xlabel("Date")
ylabel("Population")
title("Recovered")

figure (7)
plot(Results.Date,Results.Extinct,LineWidth=1.5)
grid on
xlim([Results.Date(1) Results.Date(783)])
xlabel("Date")
ylabel("Population")
title("Extinct")