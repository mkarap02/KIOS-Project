clc;
clear all;

% Import the csv file in CasesData table
CasesData = readtable('CasesData.csv');

infmt='dd/MM/yyyy';
d1="01/04/2021";
d2="30/04/2021";
datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')
date1=datetime(d1,"InputFormat",infmt);
date2=datetime(d2,"InputFormat",infmt);

%Function to specify period of time
    %07/03/2020
    %13/05/2022
[tab]=Dates(date1,date2);
count=height(tab);

% Calculation of days from admission to extinct
tab.DaysFromAdmisToExtinct = (tab.DischargedDate)-(tab.AdmissionDate);
tab.DaysFromAdmisToExtinct = days(tab.DaysFromAdmisToExtinct);

countUn=0; countVacc=0; countBad=0;
sumUn=0; sumVacc=0;

 for i=1:count
     
     %Unvaccinated Hospitalised
     if ( (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14))  && (tab.DaysFromAdmisToExtinct(i)>=0) && (tab.PatientState(i) == 0) && (tab.CauseOfDeath(i) == "COVID19") )
         countUn=countUn+1;    %Count for Unvaccinated
         sumUn=sumUn+tab{i,11};
         SelectedUn(i,1)=tab{i,1};
         SelectedUn(i,2)=tab{i,11};
         
     %Vaccinated Hospitalised
     elseif  ((not(ismissing(tab.VaccineDose1(i))) ) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14) )  && ((tab.DaysFromAdmisToExtinct(i)>=0) && (tab.PatientState(i) == 0) && (tab.CauseOfDeath(i) == "COVID19") ) 
         countVacc=countVacc+1;     %Count for Vaccinated
         sumVacc=sumVacc+tab{i,11};
         SelectedVacc(i,1)=tab{i,1};
         SelectedVacc(i,2)=tab{i,11};
 
     elseif (((tab.PatientState(i)==0) && (tab.CauseOfDeath(i) == "COVID19")) && (ismissing(tab.AdmissionDate(i)) || ismissing(tab.DischargedDate(i)) ) ) 
          countBad=countBad+1;
     end
     
 end
 
meanUn=sumUn/countUn;
meanVacc=sumVacc/countVacc;
 
SelectedVacc( all(~SelectedVacc,2), : ) = []; %remove all rows with zeros
SelectedUn( all(~SelectedUn,2), : ) = [];
 
SelectedVacc = sortrows(SelectedVacc,2);
SelectedUn = sortrows(SelectedUn,2);
 
medianUn=median(SelectedUn);
medianVacc=median(SelectedVacc);