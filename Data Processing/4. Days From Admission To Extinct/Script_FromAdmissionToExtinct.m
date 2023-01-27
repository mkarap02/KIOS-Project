clc;
clear all;

% Import the csv file in CasesData table
CasesData = readtable('ClearedCasesData.csv');

infmt='dd/MM/yyyy';
d1="15/03/2020";
d2="08/05/2022";
datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')
date1=datetime(d1,"InputFormat",infmt);
date2=datetime(d2,"InputFormat",infmt);

%Function to specify period of time
[tab]=Dates(date1,date2);

data=height(tab);

% Calculation of days from admission to extinct
tab.DaysFromAdmisToExtinct= (tab.DischargedDate)-(tab.AdmissionDate);
tab.DaysFromAdmisToExtinct = days(tab.DaysFromAdmisToExtinct);

%TabDays=tab.DaysFromAdmisToExtinct;

countUn=0; countVacc=0; countBad=0;
sumUn=0; sumVacc=0;

 for i=1:data
     
     %Unvaccinated Hospitalised
     if ( (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14))  && (tab.DaysFromAdmisToExtinct(i)>=0) && (tab.PatientState(i) == 0))
         countUn=countUn+1;    %Count for Unvaccinated
         sumUn=sumUn+tab{i,9};
         %SelectedUn(i,1)=tab{i,1};
         TableUnvaccinatedDaysOfHospitalizations(i,1)=tab{i,9};
         
     %Vaccinated Hospitalised
     elseif  ((not(ismissing(tab.VaccineDose1(i))) ) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14) )  && ((tab.DaysFromAdmisToExtinct(i)>=0) && (tab.PatientState(i) == 0)) 
         countVacc=countVacc+1;     %Count for Vaccinated
         sumVacc=sumVacc+tab{i,9};
         %SelectedVacc(i,1)=tab{i,1};
         TableVaccinatedDaysOfHospitalizations(i,1)=tab{i,9};
 
     elseif ((tab.PatientState(i)==0) && (ismissing(tab.AdmissionDate(i)) || ismissing(tab.DischargedDate(i)) ) ) 
          countBad=countBad+1;
     end
     
 end
 
MeanDaysUnvaccinated=sumUn/countUn;
MeanDaysVaccinated=sumVacc/countVacc;
 
TableVaccinatedDaysOfHospitalizations( all(~TableVaccinatedDaysOfHospitalizations,2), : ) = []; %remove all rows with zeros
TableUnvaccinatedDaysOfHospitalizations( all(~TableUnvaccinatedDaysOfHospitalizations,2), : ) = [];
 
TableVaccinatedDaysOfHospitalizations = sortrows(TableVaccinatedDaysOfHospitalizations);
TableUnvaccinatedDaysOfHospitalizations = sortrows(TableUnvaccinatedDaysOfHospitalizations);
 
MedianDaysUnvaccinated=median(TableUnvaccinatedDaysOfHospitalizations);
MedianDaysVaccinated=median(TableVaccinatedDaysOfHospitalizations);