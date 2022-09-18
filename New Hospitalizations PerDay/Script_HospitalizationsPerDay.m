clc;
clear all;

% Import the csv file in CasesData table
CasesData = readtable('CasesData-Copy.csv');

%Function to filter bad data
[tab]=Filtering();
data=height(tab);

%Creating new table.
sz = [750 3];
varTypes = ["datetime","double","double"];
varNames = ["Date","Unvaccinated Hospitalizations","Vaccinated Hospitalizations"];
Results = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

countA=0; countB=0; j=1;

for i=2:data
       
    if (tab.FirstSampling(i)==tab.FirstSampling(i-1))
    
        %Unvaccinated Hospitalised
        if ( (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14))  && (not(ismissing(tab.AdmissionDate(i)))) )
            countA=countA+1;    %Count for Unvaccinated
  
        %Vaccinated Hospitalised
        elseif ( ((not(ismissing(tab.VaccineDose1(i))) ) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14) )  && (not(ismissing(tab.AdmissionDate(i)))) )
            countB=countB+1;     %Count for Vaccinated

        end
        
    else
       Results(j,1)={tab.FirstSampling(i-1)};
       Results(j,2)={countA};
       Results(j,3)={countB};
       j=j+1;
       countA=0; countB=0;
       
       %Unvaccinated Hospitalised
       if ( (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14))  && (not(ismissing(tab.AdmissionDate(i)))) )
            countA=countA+1;    %Count for Unvaccinated
  
        %Vaccinated Hospitalised
       elseif ( ((not(ismissing(tab.VaccineDose1(i))) ) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14) )  && (not(ismissing(tab.AdmissionDate(i)))) )
            countB=countB+1;     %Count for Vaccinated

       end
       
       Results(j,1)={tab.FirstSampling(i-1)};
       Results(j,2)={countA};
       Results(j,3)={countB};  
       
    end
end
