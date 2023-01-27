clc;
clear all;

% Import the csv file in CasesData CasesDatale
CasesData = readtable('ClearedCasesData.csv');
data=height(CasesData);

%Creating new CasesData.
sz = [800 3];
varTypes = ["datetime","double","double"];
varNames = ["Date","Infections","Vaccinated Infections"];
Results = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

countA=0; countB=0; j=1;

for i=2:data
       
    if (CasesData.FirstSampling(i)==CasesData.FirstSampling(i-1))
    
        %Unvaccinated Infected
        if (ismissing(CasesData.VaccineDose1(i)) || (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)<14))
            countA=countA+1;    %Count for Unvaccinated
  
        %Vaccinated Infected
        elseif ((not(ismissing(CasesData.VaccineDose1(i))) ) && (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)>=14))
            countB=countB+1;     %Count for Vaccinated
 
        end
         
    else
        Results(j,2)={countA};
        Results(j,3)={countB};
        Results(j,1)={CasesData.FirstSampling(i-1)};
        j=j+1;
        countA=0; countB=0;
        
        %Unvaccinated Infected
        if (ismissing(CasesData.VaccineDose1(i)) || (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)<14))
             countA=countA+1;    %Count for Unvaccinated
   
        %Vaccinated Infected
        elseif ((not(ismissing(CasesData.VaccineDose1(i))) ) && (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)>=14))
             countB=countB+1;     %Count for Vaccinated
 
        end
        
        Results(j,2)={countA};
        Results(j,3)={countB}; 
        Results(j,1)={CasesData.FirstSampling(i-1)};
        
    end
end