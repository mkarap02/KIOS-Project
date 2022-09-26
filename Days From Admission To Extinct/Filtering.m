function [tab] = Filtering(tab)

    infmt='dd/MM/yyyy';
    datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')
    
    %Importing data from CasesData.csv file to a table named 'tab'
%     tab = readtable('CasesData-Copy.csv');
%     tab = sortrows(tab,'FirstSampling','ascend');
    
    %Delete data that the date of the first Vaccine Dose is earlier than
    %the first day of Vaccinations in Cyprus.
    StartOfVaccinations="27/12/2020";
    toDelete = tab.VaccineDose1<StartOfVaccinations;
    tab(toDelete,:) = [];

    %Delete the data that the date of Admission in hospital is before the
    %date of the First Sampling.
    toDelete = tab.AdmissionDate<tab.FirstSampling;
    tab(toDelete,:) = [];
    
    %Delete the data that the date of Recovery is before the
    %date of the First Sampling.
    toDelete = tab.FirstSampling>tab.RecoveredDate;
    tab(toDelete,:) = [];

    %Also deleted manually all the data that has Admission date and no
    %Discharged date.
    
       
end