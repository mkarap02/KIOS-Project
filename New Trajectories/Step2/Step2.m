clc;
clear all;

%Import files.
Step1 = readtable('Results_Step1.csv');
days=height(Step1);

CasesData = readtable('CasesData-Copy.csv');

%Function to filter bad data.
[CasesData]=Filtering();
data=height(CasesData);

flag=0;

for i=1:data

    flag=0;

    day1=CasesData.FirstSampling(i);
    day2=CasesData.FirstSampling(data);

    for k=1:days
        if (Step1.Dates(k) == day1)
            var1=k;
        end
        if (Step1.Dates(k) == day2)
            var2=k;
        end
    end

    while (flag == 0)
        for j=var1:var2

            %Unvaccinated Infections
            if (ismissing(CasesData.VaccineDose1(i)) || (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)<14))
                Step1.Susceptible(j)=Step1.Susceptible(j)-1;    
            end
            %Vaccinated Infections
            if ((not(ismissing(CasesData.VaccineDose1(i))) ) && (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)>=14))
                Step1.VaccinatedSusceptible(j)=Step1.VaccinatedSusceptible(j)-1;    
            end
                
            if (j==var2)
                flag=1;
            end
        end
    end

    

end

