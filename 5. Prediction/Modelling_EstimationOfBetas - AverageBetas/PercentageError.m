function [RelativeError] = PercentageError(TrajectoriesForPredictionWindow, x, T)

    data=0; prediction=0; error=0;

    for m=1:T

        data=TrajectoriesForPredictionWindow.Infected(m)+TrajectoriesForPredictionWindow.VaccinatedInfected(m);
        prediction=x(2,m)+x(3,m);
 
        error = error + abs(prediction/data-1);

    end
    

    RelativeError = error / T;

end