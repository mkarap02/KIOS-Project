function [C] = Cost(PredictionDates, x, T)

    c1=0; c2=0; c3=0; c4=0; c5=0; c6=0; c7=0; c8=0;     
    
    for i=1:T
        %c1 = c1 + (ExaminedTrajectories.Susceptible(i)-x(1,i))*((ExaminedTrajectories.Susceptible(i)-x(1,i)).');
        c2 = c2 + (PredictionDates.Infected(i)-x(2,i))*((PredictionDates.Infected(i)-x(2,i)).');
        c3 = c3 + (PredictionDates.VaccinatedInfected(i)-x(3,i))*((PredictionDates.VaccinatedInfected(i)-x(3,i)).');
        %c4 = c4 + (ExaminedTrajectories.Hospitalized(i)-x(4,i))*((ExaminedTrajectories.Hospitalized(i)-x(4,i)).');
        %c5 = c5 + (ExaminedTrajectories.Recovered(i)-x(5,i))*((ExaminedTrajectories.Recovered(i)-x(5,i)).');
        %c6 = c6 + (ExaminedTrajectories.Extinct(i)-x(6,i))*((ExaminedTrajectories.Extinct(i)-x(6,i)).');
        %c7 = c7 + (ExaminedTrajectories.VaccinatedSusceptible(i)-x(7,i))*((ExaminedTrajectories.VaccinatedSusceptible(i)-x(7,i)).');
        %c8 = c8 + (ExaminedTrajectories.VaccinatedHospitalized(i)-x(8,i))*((ExaminedTrajectories.VaccinatedHospitalized(i)-x(8,i)).');
    end

    %Cost Function
    C = c2 + c3;

end