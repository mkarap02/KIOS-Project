function [C,C_vec] = Cost(ClearedTrajectories, x, T_days)

    c1=0; c2=0; c3=0; c4=0; c5=0; c6=0; c7=0; c8=0;     
    
    for i=1:T_days
        %c1 = c1 + (ClearedTrajectories.Susceptible(i)-x(1,i))*((ClearedTrajectories.Susceptible(i)-x(1,i)).');
        c2 = c2 + (ClearedTrajectories.Infected(i)-x(2,i))*((ClearedTrajectories.Infected(i)-x(2,i)).');
        c3 = c3 + (ClearedTrajectories.VaccinatedInfected(i)-x(3,i))*((ClearedTrajectories.VaccinatedInfected(i)-x(3,i)).');
        %c4 = c4 + (ClearedTrajectories.Hospitalized(i)-x(4,i))*((ClearedTrajectories.Hospitalized(i)-x(4,i)).');
        %c5 = c5 + (ClearedTrajectories.Recovered(i)-x(5,i))*((ClearedTrajectories.Recovered(i)-x(5,i)).');
        %c6 = c6 + (ClearedTrajectories.Extinct(i)-x(6,i))*((ClearedTrajectories.Extinct(i)-x(6,i)).');
        %c7 = c7 + (ClearedTrajectories.VaccinatedSusceptible(i)-x(7,i))*((ClearedTrajectories.VaccinatedSusceptible(i)-x(7,i)).');
        %c8 = c8 + (ClearedTrajectories.VaccinatedHospitalized(i)-x(8,i))*((ClearedTrajectories.VaccinatedHospitalized(i)-x(8,i)).');
    end

    %C_vec = [c1;c2;c3;c4;c5;c6;c7;c8];
    C_vec = [c2;c3];

    %Cost Function
    %C = c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8;
    C = c2 + c3;

end