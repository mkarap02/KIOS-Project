clc;
clear all;

n=473985;

% Import the csv file in CasesData table
CasesData = readtable('CasesData.csv');

D = readtable('CasesData.csv','Range','A1:D473986');
countA=0; countB=0; j=1;

D = sortrows(D,'FirstSampling','ascend');

DInfectionsUn=zeros(800,1);
DInfectionsVacc=zeros(800,1);

for i=2:n
       
    if (D.FirstSampling(i)==D.FirstSampling(i-1))
    
        %Unvaccinated Infected
        if (ismissing(D.VaccineDose1(i)) || (D.FirstSampling(i)-D.VaccineDose1(i)<14))
            countA=countA+1;    %Count for Unvaccinated
  
        %Vaccinated Infected
        elseif ((not(ismissing(D.VaccineDose1(i))) ) && (D.FirstSampling(i)-D.VaccineDose1(i)>=14))
            countB=countB+1;     %Count for Vaccinated

        end
        
    else
       DInfectionsUn(j,1)=countA;
       DInfectionsVacc(j,1)=countB;
       j=j+1;
       countA=0; countB=0;
       
       %Unvaccinated Infected
       if (ismissing(D.VaccineDose1(i)) || (D.FirstSampling(i)-D.VaccineDose1(i)<14))
            countA=countA+1;    %Count for Unvaccinated
  
        %Vaccinated Infected
       elseif ((not(ismissing(D.VaccineDose1(i))) ) && (D.FirstSampling(i)-D.VaccineDose1(i)>=14))
            countB=countB+1;     %Count for Vaccinated

       end
       
       DInfectionsUn(j,1)=countA;
       DInfectionsVacc(j,1)=countB;  
       
    end
end