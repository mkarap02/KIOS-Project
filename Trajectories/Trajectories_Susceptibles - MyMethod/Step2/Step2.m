clc;
clear all;

%Import files.
Step1 = readtable('Results_Step1.csv');
days=height(Step1);

CasesData = readtable('CasesData-Copy.csv');

%Function to filter bad data.
[CasesData]=Filtering();
data=height(CasesData);

EndDay=CasesData.FirstSampling(data);
enddate=days;

for i=1:data

    InfectionDay=CasesData.FirstSampling(i);

    for k=1:days
        if (Step1.Dates(k) == InfectionDay)
            infectiondate=k;
        end
    end

    for j=infectiondate:enddate
        %Unvaccinated Infections
        if (ismissing(CasesData.VaccineDose1(i)) || (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)<14))
            Step1.Susceptible(j)=Step1.Susceptible(j)-1;    
        end
        %Vaccinated Infections
        if ((not(ismissing(CasesData.VaccineDose1(i))) ) && (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)>=14))
            Step1.VaccinatedSusceptible(j)=Step1.VaccinatedSusceptible(j)-1;    
        end
    end

    
end

