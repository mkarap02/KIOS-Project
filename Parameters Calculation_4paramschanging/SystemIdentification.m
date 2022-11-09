function [C,x,C_vec] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3)

    %--------MODEL--------   
    %x = (s,i,d,a,r,e,v,h)
    
    %Initial conditions
    x(1,1) = ClearedTrajectories.Susceptible(1);            %S : Susceptible
    x(2,1) = ClearedTrajectories.Infected(1);               %I : Infected detected
    x(3,1) = ClearedTrajectories.VaccinatedInfected(1);     %D : Vaccinated infected Detected
    x(4,1) = ClearedTrajectories.Hospitalized(1);           %A : Acutely Symptomatic
    x(5,1) = ClearedTrajectories.Recovered(1);              %R : Recovered
    x(6,1) = ClearedTrajectories.Extinct(1);                %E : Extinct
    x(7,1) = ClearedTrajectories.VaccinatedSusceptible(1);  %V : Vaccinated Susceptible
    x(8,1) = ClearedTrajectories.VaccinatedHospitalized(1); %H : Vaccinated acutely symptomatic
    
    %Initialization of Model Parameters (from Thesis)
    H_in = 0.06925;                     %Percentage of hospitalized - range between 5% and 12%
    a_d = 0.0953;                       %so the infection mortality rate is 0.66%
    gamma_i = 0.0714;                   %Recovery rate from infected detected
    gamma_a = 0.0807;                   %Recovery rate from acutely symptomatic
    gamma_d = 1/14;                     %Recovery rate from vaccinated infected detected
    gamma_h = 1/12.39;                  %Recovery rate from vaccinated acutely symptomatic
    ksi_i = 0.0053;                     %Transition rate from infected detected to acutely symptomatic
    ksi_d = 0.000265;                   %Transition rate from vaccinated infected detected to vaccinated acutely symptomatic
    mu_a = 0.00085;                     %Transition rate from acutely symptomatic to deceased
    mu_h = 0.0085;                      %Transition rate from vaccinated acutely symptomatic to deceased
    
    Rho = 5.08;                         %Basic reproduction number for D-variant
    
    dt = 1;                             %time increments  
    T_days = count;                     %Number of days
    T = T_days/dt;

    %Epidem Function calling
    for k=2:T
        vaccperday = ClearedVaccinations.NewPeopleVaccinatedPerDay(k-1);
        x(:,k) = Dynamics(dt, x(:,k-1), param, param1, param2, param3, vaccperday, gamma_i, gamma_a, gamma_d, gamma_h, ksi_i, ksi_d, mu_a, mu_h);
        %x(7,k) = ClearedTrajectories.VaccinatedSusceptible(k);
    end

    %Function to calculate Cost
    [C,C_vec] = Cost(ClearedTrajectories, x, T_days);
    
end