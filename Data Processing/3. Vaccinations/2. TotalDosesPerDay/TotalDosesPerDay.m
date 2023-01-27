%Active Vaccinated Per Day
    %New Doses per day are from Our World in Data
    %The results are concern the entire Cyprus population 
    %(not only the Active Vaccinated from CasesData.csv that concers Vaccinated Infection only)
    %Also the results are the total number of new doses in population. No
    %total vaccinated people.

clc;
clear all;

% Import the csv file
NewDosesOfVaccinesPerDay = readtable('NewDosesOfVaccinesPerDay.csv');

%Creating table.
sz = [785 2];
varTypes = ["datetime","double"];
varNames = ["Dates","ActiveVaccinated"];
ActiveVaccinatedEveryday = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

%Initializing Dates in ActiveVaccinatedEveryday table.
for i=1:785
     ActiveVaccinatedEveryday(i,1) = NewDosesOfVaccinesPerDay(i,1);
end

%Calculating Active Vaccinated population Per Day
for i=2:785
     ActiveVaccinatedEveryday.ActiveVaccinated(i) = ActiveVaccinatedEveryday.ActiveVaccinated(i-1) + NewDosesOfVaccinesPerDay.NewDosesPerDay(i-1);
end
