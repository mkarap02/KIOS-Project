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
[tab]=Filtering(tab);
data=height(tab);

% Calculation of days in hospital duration
tab.DaysInHospital = (tab.DischargedDate)-(tab.AdmissionDate);
tab.DaysInHospital = days(tab.DaysInHospital);

countUn=0; countVacc=0; countBad=0;
sumUn=0; sumVacc=0;

for i=1:data
    
    %Unvaccinated Hospitalised
    if ( (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14))  && (not(ismissing(tab.DaysInHospital(i)))) )
        SelectedUn(i,1)=tab{i,1};
        SelectedUn(i,2)=tab{i,9};
        countUn=countUn+1;    %Count for Unvaccinated
        sumUn=sumUn+tab{i,9};
        
    %Vaccinated Hospitalised
    elseif ( ((not(ismissing(tab.VaccineDose1(i))) ) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14) )  && (not(ismissing(tab.DaysInHospital(i)))) )
        SelectedVacc(i,1)=tab{i,1};
        SelectedVacc(i,2)=tab{i,9};
        countVacc=countVacc+1;     %Count for Vaccinated
        sumVacc=sumVacc+tab{i,9};

    elseif (ismissing(tab.DischargedDate(i)) && not(ismissing(tab.AdmissionDate(i))) )
        countBad=countBad+1;
    end
    
end
meanDaysInHospitalUn=sumUn/countUn;
meanDaysInHospitalVacc=sumVacc/countVacc;

SelectedVacc( all(~SelectedVacc,2), : ) = []; %remove all rows with zeros
SelectedUn( all(~SelectedUn,2), : ) = [];

SelectedVacc = sortrows(SelectedVacc,2);
SelectedUn = sortrows(SelectedUn,2);

medianDaysOfHospitalizationUn=median(SelectedUn);
medianDaysOfHospitalizationVacc=median(SelectedVacc);