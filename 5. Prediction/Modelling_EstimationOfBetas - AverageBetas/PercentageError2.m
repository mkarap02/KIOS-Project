function [RelativeError2] = PercentageError2(TrajectoriesForPredictionWindow, x, T)


    data=0; prediction=0;  

    for m=1:T

        data = data + TrajectoriesForPredictionWindow.Infected(m) + TrajectoriesForPredictionWindow.VaccinatedInfected(m);
        prediction = prediction + x(2,m) + x(3,m);

    end
   

    RelativeError2 = abs((prediction/data)-1);


end