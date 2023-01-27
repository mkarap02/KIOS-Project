function [RelativeError] = PercentageError(PredictionDates, x, T)

    cost1=0; cost2=0;    

    for i=1:T

        %cost1= cost1 +abs((x(2,i)+x(3,i))-(PredictionDates.Infected(i)+PredictionDates.VaccinatedInfected(i)))/abs(PredictionDates.Infected(i)+PredictionDates.VaccinatedInfected(i));
        cost1 = cost1 + abs( (x(2,i)+x(3,i))/(PredictionDates.Infected(i)+PredictionDates.VaccinatedInfected(i)) -1 );

        %cost1 = cost1 + sqrt( x(2,i)*((x(2,1)).') + x(3,i)*((x(3,1)).') );
        %cost2 = cost2 + sqrt( PredictionDates.Infected(i)*PredictionDates.Infected(i).' + PredictionDates.VaccinatedInfected(i)*PredictionDates.VaccinatedInfected(i).' );

    end
    
    RelativeError = cost1/T;
    %RelativeError = abs((cost1/cost2)-1);
end