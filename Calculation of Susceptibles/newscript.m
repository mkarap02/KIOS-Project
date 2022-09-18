clc;
clear all;

% Import the csv file
Trajectories = readtable('TestTrajectories.csv');
Trajectories.Susceptible = zeros(785,1);
Trajectories.VaccinatedSusceptible = zeros(785,1);
Trajectories.Susceptible(1)=920000;

for i=2:785
            
    %Calculation of Suscceptibles
    Trajectories.Susceptible(i) = Trajectories.Susceptible(i-1) - Trajectories.Infections(i) - Trajectories.NewPeopleVaccinatedPerDay(i);
 
    %Calcualation of Vaccinated Susceptibles
    Trajectories.VaccinatedSusceptible(i) = Trajectories.VaccinatedSusceptible(i-1) + Trajectories.NewPeopleVaccinatedPerDay(i) - Trajectories.VaccinatedInfections(i);

end