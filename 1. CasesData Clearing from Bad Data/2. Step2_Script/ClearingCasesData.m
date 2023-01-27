clc;
clear all;

infmt='dd/MM/yyyy';
datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')

%Import files.
CasesData = readtable('ClearedCasesData_Manually.csv');

%Delete data that the date of the first Vaccine Dose is earlier than the first day of Vaccinations in Cyprus.
StartOfVaccinations="27/12/2020";
toDelete = CasesData.VaccineDose1<StartOfVaccinations;
CasesData(toDelete,:) = [];

%Delete the data that the Discharged date is before Admission date.
toDelete = CasesData.AdmissionDate>CasesData.DischargedDate;
CasesData(toDelete,:) = [];

%Delete the data that the date of Admission in hospital is before the date of the First Sampling.
toDelete = CasesData.AdmissionDate<CasesData.FirstSampling;
CasesData(toDelete,:) = [];
    
%Delete the data that the date of Recovery is before the
%date of the First Sampling.
toDelete = CasesData.FirstSampling>CasesData.RecoveredDate;
CasesData(toDelete,:) = [];

data=height(CasesData);