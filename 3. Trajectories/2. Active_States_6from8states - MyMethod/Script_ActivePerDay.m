clc;
clear all;

%Import the csv file in CasesData table.
CasesData = readtable('ClearedCasesData.csv');
data=height(tab);

infmt='dd/MM/yyyy';
d1="15/03/2020";    
d2="06/05/2022";
datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')
date1=datetime(d1,"InputFormat",infmt);
date2=datetime(d2,"InputFormat",infmt);
d=date1:date2;

Dates =[d.'];   
days=height(d.');              %counter for the days of the specified period (date1 to date2)


%Initial conditions 
infecUn=0;  infecVacc=0;        %infected population at the start of the pandemic
recov=0;                        %recovered population at the start of the pandemic
hospUn=0;  hospVacc=0;          %hospitalized population at the start of the pandemic
ext=0;

Active=table(Dates);    %creation of the table

for j=1:days %For loop for everyday of the pandemic
    
    for i=1:data %For loop for all the data (CasesData.csv)
        
        %Infected, Vaccinated Infected and Suscpetible States
        %Unvaccinated Infected
        if ( (Active.Dates(j)==tab.FirstSampling(i)) && (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14)) )
            infecUn = infecUn + 1;
        %Vaccinated Infected
        elseif ( (Active.Dates(j)==tab.FirstSampling(i)) && (not(ismissing(tab.VaccineDose1(i))) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14)) ) 
            infecVacc = infecVacc + 1;
        end
        
        
        %Hospitalized and Vaccinated Hospitalized States                       
        %Unvaccinated Hospitalized
        if (Active.Dates(j)==tab.AdmissionDate(i) && (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14)) )
            hospUn = hospUn + 1;
            infecUn = infecUn - 1;
        %Vaccinated Hospitalized
        elseif (Active.Dates(j)==tab.AdmissionDate(i) && (not(ismissing(tab.VaccineDose1(i)))) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14) ) 
            hospVacc = hospVacc + 1;
            infecVacc = infecVacc - 1;
        end
        
        
        %Recovered State
        if (Active.Dates(j)==tab.RecoveredDate(i) && (tab.PatientState(i)==1) && (ismissing(tab.AdmissionDate(i))))
            recov = recov + 1;
            %Remove infections (that are not hospitalized) from Infected states
            if ( (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14)) && (tab.PatientState(i)==1) )
                infecUn = infecUn - 1;
            elseif ( (not(ismissing(tab.VaccineDose1(i))) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14)) && (tab.PatientState(i)==1) ) 
                infecVacc = infecVacc - 1;
            end
        end
        
        
        %Remove hospitalizations from Hospitalized states
        if (Active.Dates(j)==tab.DischargedDate(i) && (tab.PatientState(i)==1))
            recov = recov + 1;
            if ( (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14)) && (tab.PatientState(i)==1) && not(ismissing(tab.AdmissionDate(i))) )
                hospUn = hospUn - 1;
            elseif ( (not(ismissing(tab.VaccineDose1(i))) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14)) && (tab.PatientState(i)==1) && not(ismissing(tab.AdmissionDate(i))) ) 
                hospVacc = hospVacc - 1;
            end
        end              

        
        %Extinct State
        if ( (tab.PatientState(i)==0) && (tab.DischargedDate(i)==Active.Dates(j)) )
            ext = ext + 1;
            if ( (ismissing(tab.VaccineDose1(i)) || (tab.FirstSampling(i)-tab.VaccineDose1(i)<14)) && not(ismissing(tab.AdmissionDate(i))) )
                hospUn = hospUn - 1;
            elseif ( (not(ismissing(tab.VaccineDose1(i))) && (tab.FirstSampling(i)-tab.VaccineDose1(i)>=14)) && not(ismissing(tab.AdmissionDate(i))) ) 
                hospVacc = hospVacc - 1;
            end
        end
        
    end
    
    Active.Infected(j) = infecUn;
    Active.VaccinatedInfected(j) = infecVacc;
    Active.Hospitalized(j) = hospUn;
    Active.VaccinatedHospitalized(j) = hospVacc;
    Active.Recovered(j) = recov;
    Active.Extinct(j) = ext;
    
end