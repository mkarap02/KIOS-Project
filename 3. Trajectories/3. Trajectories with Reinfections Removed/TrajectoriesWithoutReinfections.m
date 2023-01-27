clc;
clear all;

%Load Reinfections table with the full info about the case.
Reinfections =  readtable('ClearedReinfections.csv');
reinfect=height(Reinfections);

%Load Trajectories (that include reinfections).
Trajectories = readtable('Trajectories.csv');
Results=Trajectories;
states=height(Trajectories);

EndDay=Trajectories.Dates(states);
endindex=states;

%Calculation of new Trajectories.
    %From First Sampling date to the last day:
        %+1 to Susceptible or Vaccinated Susceptible
        %-1 from Recovered
for i=1:reinfect

    %finding the infection date of the reinfected case
    InfectionDay=Reinfections.FirstSampling(i);


    %finding the index value of every date ('15/03/2020'=1)
    for k=1:states
        if (Trajectories.Dates(k) == InfectionDay)
            infectionindex=k;
        end
    end


    %doing the math:
    for j=infectionindex:endindex

        %Susceptible State
        if (ismissing(Reinfections.VaccineDose1(i)) || (Reinfections.FirstSampling(i)-Reinfections.VaccineDose1(i)<14))
            Results.Susceptible(j)=Results.Susceptible(j)+1;
        %Vaccinated Susceptible State
        elseif ((not(ismissing(Reinfections.VaccineDose1(i))) ) && (Reinfections.FirstSampling(i)-Reinfections.VaccineDose1(i)>=14))
            Results.VaccSusceptible(j)=Results.VaccSusceptible(j)+1;
        else
            disp("Error in for")
            return;
        end

        %Recovered State
        Results.Recovered(j)=Results.Recovered(j)-1;

    end


end
