clc;
clear all;

%Import files.
Step2 = readtable('Results_Step2.csv');
days=height(Step2);

CasesData = readtable('ClearedCasesData.csv');
data=height(CasesData);

%Creating the table.
sz = [days 3];
varTypes = ["datetime","double","double"];
varNames = ["Dates","Susceptible","VaccinatedSusceptible"];
Results = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

%Initializing the values of the table.
for i = 1:days
    Results(i,1)=Step2(i,1);
    Results(i,2)=Step2(i,2);
    Results(i,3)=Step2(i,3);
end

EndDay=CasesData.FirstSampling(data);
enddate=days;

for i=1:data
    
    InfectionDay=CasesData.FirstSampling(i);
    if (not(ismissing(CasesData.VaccineDose1(i))))
        VaccinationDay=CasesData.VaccineDose1(i);
    end
    
    for k=1:days
        if (Results.Dates(k) == InfectionDay)
            infectiondate=k;
        end
        if (not(ismissing(CasesData.VaccineDose1(i))))
            if (Results.Dates(k) == VaccinationDay)
                vaccinationdate=k;
            end
        end
    end
   
    if (not(ismissing(CasesData.VaccineDose1(i))))
        for j=vaccinationdate:enddate
            %all data that WERE VACCINATED after infection:
            if (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)<14)
                Results.Susceptible(j)=Results.Susceptible(j)+1;
                Results.VaccinatedSusceptible(j)=Results.VaccinatedSusceptible(j)-1;
            else
                break;
            end
        end
    end
    
end