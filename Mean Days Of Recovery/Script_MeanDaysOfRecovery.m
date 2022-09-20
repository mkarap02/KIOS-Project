clc;
clear all;

% Import the csv file in CasesData table
CasesData = readtable('CasesData-Copy.csv');

infmt='dd/MM/yyyy';
d1="10/03/2020";
d2="06/05/2022";
datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')
date1=datetime(d1,"InputFormat",infmt);
date2=datetime(d2,"InputFormat",infmt);

%Function to specify period of time
[tab]=Dates(date1,date2);

%Function to filter bad data
    %***Also deleted all deceased people.
[tab]=Filtering(tab);
data=height(tab);

% Commands for Infection date and Recovery date duration 
for j=1:data
    if (ismissing(tab.AdmissionDate(j)))
        tab.DaysOfRecovery(j) = (tab.RecoveredDate(j))-(tab.FirstSampling(j));
    elseif (not(ismissing(tab.AdmissionDate(j))) )
        tab.DaysOfRecovery(j) = (tab.DischargedDate(j))-(tab.FirstSampling(j));
    end
end

tab.DaysOfRecovery = days(tab.DaysOfRecovery);

countUn=0; countVacc=0; countBad=0;
sumUn=0; sumVacc=0;

for i=1:data
    
    %Unvaccinated Infected
    if ( ( (tab.DaysOfRecovery(i)>2) && (tab.DaysOfRecovery(i)<=60) ) && (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14) ) )
        SelectedUn(i,1)= tab{i,1};      %CaseID
        SelectedUn(i,2)=tab{i,9};      %DaysOfRecovery
        countUn=countUn+1;              %count for Unvaccinated
        sumUn=sumUn+tab{i,9};
        
    %Vaccinated Infected
    elseif ( ( (tab.DaysOfRecovery(i)>2) && (tab.DaysOfRecovery(i)<=60) ) && ( (not(ismissing(tab.VaccineDose1(i))) ) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14) ) )
        SelectedVacc(i,1)= tab{i,1};    %CaseID
        SelectedVacc(i,2)=tab{i,9};    %DaysOfRecovery
        countVacc=countVacc+1;          %count for Vaccinated
        sumVacc=sumVacc+tab{i,9};
        
    else
        countBad=countBad+1;
        
    end  
end
meanDaysOfRecoveryUn=sumUn/countUn;
meanDaysOfRecoveryVacc=sumVacc/countVacc;

SelectedVacc( all(~SelectedVacc,2), : ) = []; %remove all rows with zeros
SelectedUn( all(~SelectedUn,2), : ) = [];

SelectedVacc = sortrows(SelectedVacc,2);
SelectedUn = sortrows(SelectedUn,2);

medianDaysOfRecoveryUn=median(SelectedUn);
medianDaysOfRecoveryVacc=median(SelectedVacc);
