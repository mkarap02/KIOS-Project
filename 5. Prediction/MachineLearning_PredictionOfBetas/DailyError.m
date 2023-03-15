function [ErrorResults] = DailyError(TrajectoriesForPredictionWindow, x, T)

    data=0; prediction=0; error=0;

    for m=1:T
        
        data=0; prediction=0;

        data=TrajectoriesForPredictionWindow.Infected(m)+TrajectoriesForPredictionWindow.VaccinatedInfected(m);
        prediction=x(2,m)+x(3,m);

        error = error + abs(prediction-data);

    end


    ErrorResults = error / T;

end