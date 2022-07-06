clc;
clear all;

n=473985;

% Import the csv file in CasesData table
CasesData = readtable('CasesData.csv');

C = readtable('CasesData.csv','Range','A1:H473986');

countA=0; countB=0; j=1;
C = sortrows(C,'FirstSampling','ascend');

CHospitalizationsUn=zeros(800,1);
CHospitalizationsVacc=zeros(800,1);

for i=2:n
       
    if (C.FirstSampling(i)==C.FirstSampling(i-1))
    
        %Unvaccinated Hospitalised
        if ( (ismissing(C.VaccineDose1(i)) || (C.FirstSampling(i)-C.VaccineDose1(i)<14))  && (not(ismissing(C.AdmissionDate(i)))) )
            countA=countA+1;    %Count for Unvaccinated
  
        %Vaccinated Hospitalised
        elseif ( ((not(ismissing(C.VaccineDose1(i))) ) && (C.FirstSampling(i)-C.VaccineDose1(i)>=14) )  && (not(ismissing(C.AdmissionDate(i)))) )
            countB=countB+1;     %Count for Vaccinated

        end
        
    else
       CHospitalizationsUn(j,1)=countA;
       CHospitalizationsVacc(j,1)=countB;
       j=j+1;
       countA=0; countB=0;
       
       %Unvaccinated Hospitalised
       if ( (ismissing(C.VaccineDose1(i)) || (C.FirstSampling(i)-C.VaccineDose1(i)<14))  && (not(ismissing(C.AdmissionDate(i)))) )
            countA=countA+1;    %Count for Unvaccinated
  
        %Vaccinated Hospitalised
       elseif ( ((not(ismissing(C.VaccineDose1(i))) ) && (C.FirstSampling(i)-C.VaccineDose1(i)>=14) )  && (not(ismissing(C.AdmissionDate(i)))) )
            countB=countB+1;     %Count for Vaccinated

       end
       
       CHospitalizationsUn(j,1)=countA;
       CHospitalizationsVacc(j,1)=countB;  
       
    end
end
