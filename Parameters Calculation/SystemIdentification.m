function [C,x,C_vec] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h)

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
    
    Rho = 5.08;                         %Basic reproduction number for D-variant
    
    dt = 1;                             %time increments  
    T_days = count;                     %Number of days
    T = T_days/dt;

    %zeta = 0.1;                         %Initialisation of z

    %Epidem Function calling
    for k=2:T
        vaccperday = ClearedVaccinations.Vaccinations(k-1)/896005;
        x(:,k) = Dynamics(dt, x(:,k-1), param, param1, param2, param3, vaccperday, gamma_i, gamma_a, gamma_d, gamma_h, ksi_i, ksi_d, mu_a, mu_h);
        x(7,k) = ClearedTrajectories.VaccinatedSusceptible(k); %%% is k or k-1???*********            
    end

    %Function to calculate Cost
    [C,C_vec] = Cost(ClearedTrajectories, x, T_days);
    
end