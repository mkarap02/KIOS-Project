clc;
clear all;

% Import the csv file in CasesData table
CasesData = readtable('CasesData.csv');

infmt='dd/MM/yyyy';
d1="07/03/2020";
d2="13/05/2022";
datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')
date1=datetime(d1,"InputFormat",infmt);
date2=datetime(d2,"InputFormat",infmt);

%Function to specify period of time
    %07/03/2020
    %13/05/2022
[tab]=Dates(date1,date2);
count=height(tab);

% Calculation of days in hospital duration
tab.DaysFromInfectToHosp = (tab.AdmissionDate)-(tab.FirstSampling);
tab.DaysFromInfectToHosp = days(tab.DaysFromInfectToHosp);

countUn=0; countVacc=0; countBad=0;
sumUn=0; sumVacc=0;

for i=1:count
    
    %Unvaccinated Hospitalised
    if ( (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14))  && (tab.DaysFromInfectToHosp(i)>=0) && (tab.DaysFromInfectToHosp(i)<=25) )
        countUn=countUn+1;    %Count for Unvaccinated
        sumUn=sumUn+tab{i,11};
        SelectedUn(i,1)=tab{i,1};
        SelectedUn(i,2)=tab{i,11};
        
    %Vaccinated Hospitalised
    elseif ( ((not(ismissing(tab.VaccineDose1(i))) ) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14) )  && ((tab.DaysFromInfectToHosp(i)>=0) && (tab.DaysFromInfectToHosp(i)<=25)) )
        countVacc=countVacc+1;     %Count for Vaccinated
        sumVacc=sumVacc+tab{i,11};
        SelectedVacc(i,1)=tab{i,1};
        SelectedVacc(i,2)=tab{i,11};

    elseif ((tab.DaysFromInfectToHosp(i)<0) || (tab.DaysFromInfectToHosp(i)>25)) 
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
