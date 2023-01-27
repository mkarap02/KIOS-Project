clc;
clear all;

%Import csv file.
    %These data concern the new people that every single day get vaccinated.
NewPeopleVaccinatedEveryday = readtable('NewPeopleVaccinatedEveryday.csv');
data=height(NewPeopleVaccinatedEveryday);

population=920000;

%Creating the table.
sz = [data 4];
varTypes = ["datetime","double","double","double"];
varNames = ["Dates","Susceptible","NewPeopleVaccinatedPerDay","VaccinatedSusceptible"];
Results = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

%Initializing the values of the table.
for i = 1:data
    Results(i,1)=NewPeopleVaccinatedEveryday(i,1);
    Results(i,3)=NewPeopleVaccinatedEveryday(i,2);
end

Results(1,2)={population};

%Calculating:
for i = 2:data
    Results.Susceptible(i) = Results.Susceptible(i-1) - Results.NewPeopleVaccinatedPerDay(i);
    Results.VaccinatedSusceptible(i) = Results.VaccinatedSusceptible(i-1) + Results.NewPeopleVaccinatedPerDay(i);
end
