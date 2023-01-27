clc;
clear all;

% Import the csv file in CasesData table
CasesData = readtable('ClearedCasesData.csv');
data=height(CasesData);

%Creating new table.
sz = [750 3];
varTypes = ["datetime","double","double"];
varNames = ["Date","Unvaccinated Hospitalizations","Vaccinated Hospitalizations"];
Results = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

countA=0; countB=0; j=1;

for i=2:data
       
    if (CasesData.FirstSampling(i)==CasesData.FirstSampling(i-1))
    
        %Unvaccinated Hospitalised
        if ( (ismissing(CasesData.VaccineDose1(i)) || (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)<14))  && (not(ismissing(CasesData.AdmissionDate(i)))) )
            countA=countA+1;    %Count for Unvaccinated
  
        %Vaccinated Hospitalised
        elseif ( ((not(ismissing(CasesData.VaccineDose1(i))) ) && (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)>=14) )  && (not(ismissing(CasesData.AdmissionDate(i)))) )
            countB=countB+1;     %Count for Vaccinated

        end
        
    else
       Results(j,1)={CasesData.FirstSampling(i-1)};
       Results(j,2)={countA};
       Results(j,3)={countB};
       j=j+1;
       countA=0; countB=0;
       
       %Unvaccinated Hospitalised
       if ( (ismissing(CasesData.VaccineDose1(i)) || (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)<14))  && (not(ismissing(CasesData.AdmissionDate(i)))) )
            countA=countA+1;    %Count for Unvaccinated
  
        %Vaccinated Hospitalised
       elseif ( ((not(ismissing(CasesData.VaccineDose1(i))) ) && (CasesData.FirstSampling(i)-CasesData.VaccineDose1(i)>=14) )  && (not(ismissing(CasesData.AdmissionDate(i)))) )
            countB=countB+1;     %Count for Vaccinated

       end
       
       Results(j,1)={CasesData.FirstSampling(i-1)};
       Results(j,2)={countA};
       Results(j,3)={countB};  
       
    end
end
