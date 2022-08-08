clc;
clear all;

% Import the csv file
Trajectories = readtable('Trajectories.csv');
Trajectories.VaccinatedSusceptible = zeros(785,1);

for i=2:785
    
    %Calculation of Suscceptibles
    Trajectories.Susceptible(i) = Trajectories.Susceptible(i-1) - (Trajectories.Infected(i)-Trajectories.Infected(i-1)) - (Trajectories.Vaccinations(i)-Trajectories.Vaccinations(i-1));
        
    %Calcualation of Vaccinated Susceptibles
    Trajectories.VaccinatedSusceptible(i) = Trajectories.VaccinatedSusceptible(i-1) + (Trajectories.Vaccinations(i)-Trajectories.Vaccinations(i-1)) - (Trajectories.VaccinatedInfected(i)-Trajectories.VaccinatedInfected(i-1));
        
end
