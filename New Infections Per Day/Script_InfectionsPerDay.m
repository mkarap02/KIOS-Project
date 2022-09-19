clc;
clear all;

% Import the csv file in CasesData table
CasesData = readtable('CasesData-Copy.csv');

%Function to filter bad data
[tab]=Filtering();
data=height(tab);

%Creating new table.
sz = [800 3];
varTypes = ["datetime","double","double"];
varNames = ["Date","Infections","Vaccinated Infections"];
Results = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

countA=0; countB=0; j=1;

for i=2:data
       
    if (tab.FirstSampling(i)==tab.FirstSampling(i-1))
    
        %Unvaccinated Infected
        if (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14))
            countA=countA+1;    %Count for Unvaccinated
  
        %Vaccinated Infected
        elseif ((not(ismissing(tab.VaccineDose1(i))) ) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14))
            countB=countB+1;     %Count for Vaccinated
 
        end
         
    else
        Results(j,2)={countA};
        Results(j,3)={countB};
        Results(j,1)={tab.FirstSampling(i-1)};
        j=j+1;
        countA=0; countB=0;
        
        %Unvaccinated Infected
        if (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14))
             countA=countA+1;    %Count for Unvaccinated
   
        %Vaccinated Infected
        elseif ((not(ismissing(tab.VaccineDose1(i))) ) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14))
             countB=countB+1;     %Count for Vaccinated
 
        end
        
        Results(j,2)={countA};
        Results(j,3)={countB}; 
        Results(j,1)={tab.FirstSampling(i-1)};
        
    end
end