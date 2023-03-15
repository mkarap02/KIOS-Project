clc;
clear all;

% Import the csv file in a table.
Trajectories = readtable('Trajectories_01092020_31032022.csv');
Active=Trajectories;
days=height(Trajectories);
ParametersResults = readtable('EstimatedParameters_7daysWindow.csv');  %Values of the 4 parameters from System Identification
VaccinationsPerDay = readtable('NewPeopleVaccinatedEveryday.csv');             %New vaccinations per day

%Dividing all the states with the total population number.
population=920000;
Trajectories.Susceptible=Trajectories.Susceptible/population;
Trajectories.VaccinatedSusceptible=Trajectories.VaccinatedSusceptible/population;
Trajectories.Infected=Trajectories.Infected/population;
Trajectories.VaccinatedInfected=Trajectories.VaccinatedInfected/population;
Trajectories.Hospitalized=Trajectories.Hospitalized/population;
Trajectories.VaccinatedHospitalized=Trajectories.VaccinatedHospitalized/population;
Trajectories.Recovered=Trajectories.Recovered/population;
Trajectories.Extinct=Trajectories.Extinct/population;
VaccinationsPerDay.NewPeopleVaccinatedPerDay=VaccinationsPerDay.NewPeopleVaccinatedPerDay/population;


%Initialization of Model Parameters (from Thesis).
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

j=days-13;  %20

for i = 1:j

    %Function to specify period of time.
    infmt='dd/MM/yyyy';
    d1=Trajectories.Dates(i); 
    d2=Trajectories.Dates(i+6);%13
    [RealTrajectoriesWindow]=Dates(Trajectories,d1,d2);        %Table with the real-Trajectories
    [VaccinationsWindow]=Dates(VaccinationsPerDay,d1,d2);
    
    %The 7days-window for prediction.
    pd1=Trajectories.Dates(i+7);%14
    pd2=Trajectories.Dates(i+13);%20
    [TrajectoriesForPredictionWindow]=Dates(Trajectories,pd1,pd2);
    
    param = ParametersResults.Param(i);    %i+7       %param=beta*(1-u)            Definition of R0 in SIDARE, proven in paper          
    param1 = ParametersResults.Param1(i);         %param1=\tilde{beta}*(1-u)   Rate which a vaccinated person infect an unvaccinated person
    param2 = ParametersResults.Param2(i);         %param2=\hat{beta}*(1-u)     Rate which a vaccinated person infect another vaccinated person
    param3 = ParametersResults.Param3(i);         %param3=\bar{beta}*(1-u)     Rate which an unvaccinated person infect a vaccinated person
    
    dt = 1;    %time increments  
    T = 7;     %Number of prediction days
    
    %--------MODEL--------   
    %Initial conditions:%14
    x(1,1) = Trajectories.Susceptible(i+7);            %S : Susceptible
    x(2,1) = Trajectories.Infected(i+7);               %I : Infected detected
    x(3,1) = Trajectories.VaccinatedInfected(i+7);     %D : Vaccinated infected Detected
    x(4,1) = Trajectories.Hospitalized(i+7);           %A : Acutely Symptomatic
    x(5,1) = Trajectories.Recovered(i+7);              %R : Recovered
    x(6,1) = Trajectories.Extinct(i+7);                %E : Extinct
    x(7,1) = Trajectories.VaccinatedSusceptible(i+7);  %V : Vaccinated Susceptible
    x(8,1) = Trajectories.VaccinatedHospitalized(i+7); %H : Vaccinated acutely symptomatic
    
    for k=2:T
        vaccperday = VaccinationsWindow.NewPeopleVaccinatedPerDay(k-1);
        x(:,k) = Dynamics(dt, x(:,k-1), param, param1, param2, param3, vaccperday, gamma_i, gamma_a, gamma_d, gamma_h, ksi_i, ksi_d, mu_a, mu_h);
    end

    %Calculating COST:
    [C] = Cost(TrajectoriesForPredictionWindow, x, T);


    %************************************
    %SAVING RESULTS : Save all data for EVERY 7-DAYS WINDOW iteration:
    cellPrediction{i,1} = x;                                                       %the prediction trajectories       
    cellTrajectoriesForPredictionWindow{i,1} = TrajectoriesForPredictionWindow;    %the real 7 days trajectories are going to predict
    cellCost{i,1} = C;
    cellRealTrajectoriesWindow{i,1} = RealTrajectoriesWindow;                      %the 7 days window used (information before prediction)
    cellParam{i,1} = param; cellParam1{i,1} = param1; cellParam2{i,1} = param2; cellParam3{i,1} = param3;

    

    %************************************
    %Calculating Total Infected Population for EVERY 7-DAYS WINDOW (Total = Infected + Vacc.Infected)
        %first column is REAL DATA
        %second columns is PREDICTED DATA
    sum=0; sum2=0;
    for z=1:T
        sum=sum+cellTrajectoriesForPredictionWindow{i,1}.Infected(z)+cellTrajectoriesForPredictionWindow{i,1}.VaccinatedInfected(z);
        sum2=sum2+cellPrediction{i,1}(2,z)+cellPrediction{i,1}(3,z);
    end
    cellTotalInfected{i,1}=population*sum/T;
    cellTotalInfected{i,2}=population*sum2/T;

    %Total EVERYDAY infected (Total = Infectd + Vacc.Infected)
    Infected=population*(Trajectories.Infected+Trajectories.VaccinatedInfected);



    %************************************
    %STATISTICS
    %Average error for every sliding 7-days window (in cellDailyError):
    [ErrorResults] = DailyError(TrajectoriesForPredictionWindow, x, T);
    cellDailyError{i,1} = (ErrorResults/T)*population;
   
    %AVG Relative Error for every sliding 7-days window:
    [RelativeError] = PercentageError(TrajectoriesForPredictionWindow, x, T);
    cellPercentageErrorAvgOf7Days{i,1}=RelativeError*100;

    %SUM Relative Error for every sliding 7-days window:
    [RelativeError2] = PercentageError2(TrajectoriesForPredictionWindow, x, T);
    cellPercentageErrorSumof7Days{i,1}=RelativeError2*100;

end

MeanPercentageErrorAvgOf7Days=mean(cell2mat(cellPercentageErrorAvgOf7Days));   
StdPercentageErrorAvgOf7Days=std(cell2mat(cellPercentageErrorAvgOf7Days));      %standard deviation  

MeanDailyError=mean(cell2mat(cellDailyError));
StdDailyError=std(cell2mat(cellDailyError));

MeanPercentageErrorSumOf7Days=mean(cell2mat(cellPercentageErrorSumof7Days));
StdPercentageErrorSumOf7Days=std(cell2mat(cellPercentageErrorSumof7Days));
