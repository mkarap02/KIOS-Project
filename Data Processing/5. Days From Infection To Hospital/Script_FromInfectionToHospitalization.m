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

% Calculation of days
tab.DaysFromInfectToHosp = (tab.AdmissionDate)-(tab.FirstSampling);
tab.DaysFromInfectToHosp = days(tab.DaysFromInfectToHosp);

countUn=0; countVacc=0; countBad=0;
sumUn=0; sumVacc=0;

for i=1:data
    
    %Unvaccinated Hospitalised
    if ( (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14))  && (tab.DaysFromInfectToHosp(i)>=0) && (tab.DaysFromInfectToHosp(i)<=25) )
        countUn=countUn+1;    %Count for Unvaccinated
        sumUn=sumUn+tab{i,9};
        %TableDaysUnvaccinated(i,1)=tab{i,1};
        TableDaysUnvaccinated(i,1)=tab{i,9};
        
    %Vaccinated Hospitalised
    elseif ( ((not(ismissing(tab.VaccineDose1(i))) ) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14) )  && ((tab.DaysFromInfectToHosp(i)>=0) && (tab.DaysFromInfectToHosp(i)<=25)) )
        countVacc=countVacc+1;     %Count for Vaccinated
        sumVacc=sumVacc+tab{i,9};
        %TableDaysVaccinated(i,1)=tab{i,1};
        TableDaysVaccinated(i,1)=tab{i,9};

    elseif ((tab.DaysFromInfectToHosp(i)<0) || (tab.DaysFromInfectToHosp(i)>25)) 
        countBad=countBad+1;
    end
    
end

MeanDaysUnvaccinated=sumUn/countUn;
MeanDaysVaccinated=sumVacc/countVacc;

TableDaysVaccinated( all(~TableDaysVaccinated,2), : ) = []; %remove all rows with zeros
TableDaysUnvaccinated( all(~TableDaysUnvaccinated,2), : ) = [];

TableDaysVaccinated = sortrows(TableDaysVaccinated);
TableDaysUnvaccinated = sortrows(TableDaysUnvaccinated);

MedianDaysUnvaccinated=median(TableDaysUnvaccinated);
MedianDaysVaccinated=median(TableDaysVaccinated);
