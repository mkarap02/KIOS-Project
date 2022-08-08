clc;
clear all;

% Import the csv file in a table
Active = readtable('Trajectories.csv');
Trajectories=Active;
%Trajectories = readtable('Trajectories.csv','Range','B1:I786');

% Dividing all the states with the total population number
Trajectories.Susceptible=Trajectories.Susceptible/896005;
Trajectories.VaccinatedSusceptible=Trajectories.VaccinatedSusceptible/896005;
Trajectories.Infected=Trajectories.Infected/896005;
Trajectories.VaccinatedInfected=Trajectories.VaccinatedInfected/896005;
Trajectories.Hospitalized=Trajectories.Hospitalized/896005;
Trajectories.VaccinatedHospitalized=Trajectories.VaccinatedHospitalized/896005;
Trajectories.Recovered=Trajectories.Recovered/896005;
Trajectories.Extinct=Trajectories.Extinct/896005;


%--------DATA--------

%Function to specify period of time
    %01/02/2021  
    %01/03/2021
infmt='dd/MM/yyyy';
d1="01/02/2021";
d2="14/02/2021";
datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')
date1=datetime(d1,"InputFormat",infmt);
date2=datetime(d2,"InputFormat",infmt);
[ClearedTrajectories]=Dates(Trajectories,date1,date2);  %Table with the data for the examined days
count=height(ClearedTrajectories);



%--------MODEL--------

%x = (s,i,d,a,r,e,v,h)
%S : Susceptible x(1,1)
%I : Infected detected x(2,1)
%D : Vaccinated infected Detected x(3,1)
%A : Acutely Symptomatic x(4,1)
%R : Recovered x(5,1)
%E : Extinct x(6,1)
%V : Vaccinated Susceptible x(7,1)
%H : Vaccinated acutely symptomatic x(8,1)

%Initial conditions
x(1,1) = 0.9922902;
x(2,1) = 0.0024464;
x(3,1) = 0.0000145;
x(4,1) = 0.0001607;
x(5,1) = 0.0275143;
x(6,1) = 0.0000201;
x(7,1) = 0.0052488;
x(8,1) = 0.0000011;

%Initialization of Model Parameters (from Thesis)
H_in = 0.06925;                     %Percentage of hospitalized - range between 5% and 12%
a_d = 0.0953;                  %so the infection mortality rate is 0.66%
gamma_i = 0.0714;                     %Recovery rate from infected detected
gamma_a = 0.0807;                  %Recovery rate from acutely symptomatic
gamma_d = 1/14;                     %Recovery rate from vaccinated infected detected
gamma_h = 1/12.39;                  %Recovery rate from vaccinated acutely symptomatic
ksi_i = 0.0053;      %Transition rate from infected detected to acutely symptomatic
ksi_d = 0.000265;                   %Transition rate from vaccinated infected detected to vaccinated acutely symptomatic
mu_a = 0.00085;         %Transition rate from acutely symptomatic to deceased
mu_h = 0.0085;                      %Transition rate from vaccinated acutely symptomatic to deceased

Rho = 5.08;                         %Basic reproduction number for D-variant

param = 0.3899;                     %param=beta*(1-u)              Definition of R0 in SIDARE, proven in paper          
param1 = 0.19495;                   %param1=\tilde{beta}*(1-u)     Rate which a vaccinated person infect an unvaccinated person
param2 = 0.05849;                   %param2=\hat{beta}*(1-u)       Rate which a vaccinated person infect another vaccinated person
param3 = 0.11697;                   %param3=\bar{beta}*(1-u)       Rate which an unvaccinated person infect a vaccinated person

dt = 1;                             %time increments  
T_days = count;                     %Number of days
T = T_days/dt;

zeta = 0.1;                         %Initialisation of z


%Epidem Function calling
for k=2:T
    x(:,k) = Dynamics(dt, x(:,k-1), param, param1, param2, param3, zeta, gamma_i, gamma_a, gamma_d, gamma_h, ksi_i, ksi_d, mu_a, mu_h);
end

%Function to calculate Cost
[C] = Cost(ClearedTrajectories, x, T_days);