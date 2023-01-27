function [ErrorResults] = DailyError(PredictionDates, x, T)

    cost=0; 
    
    for i=1:T

        cost = cost + (abs(x(2,i) - PredictionDates.Infected(i)) + abs(x(3,i) - PredictionDates.VaccinatedInfected(i)));

    end

    ErrorResults =cost/T;

end