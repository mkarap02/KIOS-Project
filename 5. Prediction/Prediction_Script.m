clc;
clear all;

% Import the csv file in a table.
Trajectories = readtable('Trajectories_01092020_31032022.csv');
Active=Trajectories;
days=height(Trajectories);
ParametersResults = readtable('Parameters_Results.csv');            %Values of the 4 parameters from System Identification
VaccinationsPerDay = readtable('NewPeopleVaccinatedEveryday.csv');    %New vaccinations per day

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

j=days-20;  %20 %j=557

for i = 1:j

    %Function to specify period of time.
    infmt='dd/MM/yyyy';
    d1=Trajectories.Dates(i); 
    d2=Trajectories.Dates(i+13);%13
    [FourteenDaysWindowTrajectories]=Dates(Trajectories,d1,d2);        %Table with the real-Trajectories
    [FourteenDaysWindowVaccinations]=Dates(VaccinationsPerDay,d1,d2);
    
    %The 7days-window for prediction.
    pd1=Trajectories.Dates(i+14);%14
    pd2=Trajectories.Dates(i+20);%20
    [SevendaysWindow]=Dates(Trajectories,pd1,pd2);
    
    param = ParametersResults.Param(i);           %param=beta*(1-u)            Definition of R0 in SIDARE, proven in paper          
    param1 = ParametersResults.Param1(i);         %param1=\tilde{beta}*(1-u)   Rate which a vaccinated person infect an unvaccinated person
    param2 = ParametersResults.Param2(i);         %param2=\hat{beta}*(1-u)     Rate which a vaccinated person infect another vaccinated person
    param3 = ParametersResults.Param3(i);         %param3=\bar{beta}*(1-u)     Rate which an unvaccinated person infect a vaccinated person
    
    dt = 1;    %time increments  
    T = 7;     %Number of prediction days
    
    %--------MODEL--------   
    %Initial conditions:%14
    x(1,1) = Trajectories.Susceptible(i+14);            %S : Susceptible
    x(2,1) = Trajectories.Infected(i+14);               %I : Infected detected
    x(3,1) = Trajectories.VaccinatedInfected(i+14);     %D : Vaccinated infected Detected
    x(4,1) = Trajectories.Hospitalized(i+14);           %A : Acutely Symptomatic
    x(5,1) = Trajectories.Recovered(i+14);              %R : Recovered
    x(6,1) = Trajectories.Extinct(i+14);                %E : Extinct
    x(7,1) = Trajectories.VaccinatedSusceptible(i+14);  %V : Vaccinated Susceptible
    x(8,1) = Trajectories.VaccinatedHospitalized(i+14); %H : Vaccinated acutely symptomatic
    
    for k=2:T
        vaccperday = FourteenDaysWindowVaccinations.NewPeopleVaccinatedPerDay(k-1);
        x(:,k) = Dynamics(dt, x(:,k-1), param, param1, param2, param3, vaccperday, gamma_i, gamma_a, gamma_d, gamma_h, ksi_i, ksi_d, mu_a, mu_h);
    end

    %Calculating COST:
    [C] = Cost(SevendaysWindow, x, T);


    %************************************
    %SAVING RESULTS : Save all data for EVERY 7-DAYS WINDOW iteration:
    cellPrediction{i,1} = x;                            %the prediction trajectoris       
    cellSevenDaysWindow{i,1} = SevendaysWindow;         %the real 7 days trajectories
    cellCost{i,1} = C;
    cellFourteenDaysWindowTrajectories{i,1} = FourteenDaysWindowTrajectories;   %the 14 days window used
    cellParam{i,1} = param; cellParam1{i,1} = param1; cellParam2{i,1} = param2; cellParam3{i,1} = param3;

    

    %************************************
    %Calculating Total Infected Population for EVERY 7-DAYS WINDOW (Total = Infected + Vacc.Infected)
        %first column is REAL DATA
        %second columns is PREDICTED DATA
    sum=0; sum2=0;
    for z=1:T
        sum=sum+cellSevenDaysWindow{i,1}.Infected(z)+cellSevenDaysWindow{i,1}.VaccinatedInfected(z);
        sum2=sum2+cellPrediction{i,1}(2,z)+cellPrediction{i,1}(3,z);
    end
    cellTotalInfected{i,1}=population*sum;
    cellTotalInfected{i,2}=population*sum2;

    %Total EVERYDAY infected (Total = Infectd + Vacc.Infected)
    Infected=population*(Trajectories.Infected+Trajectories.VaccinatedInfected);


    %************************************
    %STATISTICS
    %Average error for every sliding 7-days window (in cellDailyError):
    [ErrorResults] = DailyError(SevendaysWindow, x, T);
    cellDailyError{i,1} = population*ErrorResults;
    
    %Relative Error for every sliding 7-days window (in cellPercentageError):
    [RelativeError] = PercentageError(SevendaysWindow, x, T);
    cellPercentageError{i,1}=RelativeError*100;

end

MeanPercentageError=mean(cell2mat(cellPercentageError));   
StdPercentageError=std(cell2mat(cellPercentageError));      %standard deviation  

MeanAvgError=mean(cell2mat(cellDailyError));
StdAvgError=std(cell2mat(cellDailyError));
