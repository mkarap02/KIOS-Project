clc;
clear all;

%Import the csv file in a table.
%Load Trajectories (reinfections removed):
    %we consider trajectories that:
        %1. infections are not under 100
        %2. susceptibles are not under 30000
Active = readtable('Trajectories_01092020_31032022.csv');
Trajectories=Active;
days=height(Trajectories);
%Load new vaccinations per day:
VaccinationsPerDay = readtable('NewPeopleVaccinatedEveryday.csv');

%Dividing all the states with the total population number
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

z=days-6;

for i=1:z%564   %loop for all the days
    
    %--------DATA--------

    %Function to specify period of time
    infmt='dd/MM/yyyy';
    d1=Trajectories.Dates(i); 
    d2=Trajectories.Dates(i+6);%(i+13)
    datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')
    date1=datetime(d1,"InputFormat",infmt);
    date2=datetime(d2,"InputFormat",infmt);
    [ClearedTrajectories]=Dates(Trajectories,date1,date2);           %Table with the data for the examined days
    [ClearedVaccinations]=Dates(VaccinationsPerDay,date1,date2);
    count=height(ClearedTrajectories);

    %Initialization of Model Parameters (from Thesis)
    param = 0.3899;                         %param=beta*(1-u)            Definition of R0 in SIDARE, proven in paper          

    if (d1<"07/01/2021")
        param1 = 0;
        param2 = 0;
        param3 = 0;
    else
        param1 = 0.19495;                   %param1=\tilde{beta}*(1-u)   Rate which a vaccinated person infect an unvaccinated person
        param2 = 0.05849;                   %param2=\hat{beta}*(1-u)     Rate which a vaccinated person infect another vaccinated person
        param3 = 0.11697;                   %param3=\bar{beta}*(1-u)     Rate which an unvaccinated person infect a vaccinated person
    end
    
    [InitialCost,x_init,C_init] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3);

    temp=param; temp1=param1; temp2=param2; temp3=param3;
    TempCost=InitialCost;

    numofiterations=0;
    x_rev=0;    C_rev=0;
    flag=0;
    percentage=0.01;
    minCost=0;
    
    while (flag == 0)
        change(1)=temp+temp*percentage;      %Increase of param
        change(2)=temp-temp*percentage;      %Decrease of param
        change(3)=temp1+temp1*percentage;    %Increase of param1
        change(4)=temp1-temp1*percentage;    %Decrease of param1
        change(5)=temp2+temp2*percentage;    %Increase of param2
        change(6)=temp2-temp2*percentage;    %Decrease of param2
        change(7)=temp3+temp3*percentage;    %Increase of param3
        change(8)=temp3-temp3*percentage;    %Decrease of param3

        [C(1,1),x{1,1},C_vec{1,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,change(1),temp1,temp2,temp3);
        [C(2,1),x{2,1},C_vec{2,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,change(2),temp1,temp2,temp3);
        [C(3,1),x{3,1},C_vec{3,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,temp,change(3),temp2,temp3);
        [C(4,1),x{4,1},C_vec{4,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,temp,change(4),temp2,temp3);
        [C(5,1),x{5,1},C_vec{5,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,temp,temp1,change(5),temp3);            
        [C(6,1),x{6,1},C_vec{6,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,temp,temp1,change(6),temp3);
        [C(7,1),x{7,1},C_vec{7,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,temp,temp1,temp2,change(7));
        [C(8,1),x{8,1},C_vec{8,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,temp,temp1,temp2,change(8));
        
        min(C)
        
        %Saving munimum cost for every iteration
        minCost(numofiterations+1,1)=min(C);

        %Find the parameter (minchange) that leads to the minimum cost (min(C)).
        if ( min(C) < TempCost )
            TempCost = min(C);
            minchange = find(C(:,1)==min(C));

            %if ((min(C)/TempCost) > 0.999)
                %percentage=0.001;
            %end

            if (minchange==1)
                temp = change(1);
                x_rev = x{1,1};
                C_rev = C_vec{1,1};

            elseif (minchange==2)
                temp = change(2);
                x_rev = x{2,1};
                C_rev = C_vec{2,1};

            elseif (minchange==3)
                temp1 = change(3);
                x_rev = x{3,1};
                C_rev = C_vec{3,1};

            elseif (minchange==4)
                temp1 = change(4);
                x_rev = x{4,1};
                C_rev = C_vec{4,1};

            elseif (minchange==5)
                temp2 = change(5);
                x_rev = x{5,1};
                C_rev = C_vec{5,1};

            elseif (minchange==6)
                temp2 = change(6);
                x_rev = x{6,1};
                C_rev = C_vec{6,1};

            elseif (minchange==7)
                temp3 = change(7);
                x_rev = x{7,1};
                C_rev = C_vec{7,1};

            elseif (minchange==8)
                temp3 = change(8);
                x_rev = x{8,1};
                C_rev = C_vec{8,1};
            
            end

            numofiterations = numofiterations + 1;   %counting iterations while flag becomes 1

        else 
            flag = 1;
        end  

    end
     
    %Checking if States sums up to 1 (population).
    ea=10e-15;
    for j=1:count%14
        sum=x_rev(1,j)+x_rev(2,j)+x_rev(3,j)+x_rev(4,j)+x_rev(5,j)+x_rev(6,j)+x_rev(7,j)+x_rev(8,j);
        %sum
        if abs(sum-1)>=ea
            display = ['SUM ERROR in day: ',i,' and num of day ',j];
            disp(display);
            return;
        end
    end

    %Save all data for everyday iteration: 
    cellIterations{i,1}=numofiterations; 
        %Trajectories:
    cellClearedTrajectories{i,1}=ClearedTrajectories;
    cellClearedVaccinations{i,1}=ClearedVaccinations;
        %States:
    cellXrev{i,1}=x_rev;
    cellX{i,1}=x;
        %Cost:
    cellC{i,1}=C;
    cellCrev{i,1}=C_rev;
    cellFinalCost{i,1}=TempCost;
    cellMinCost{i,1}=minCost;
    cellCvec{i,1}=C_vec;
    cellMinCost{i,1}=minCost;
        %Parameters:
    cellParam{i,1}=temp;
    cellParam{i,2}=Trajectories.Dates(i+6);
    cellParam1{i,1}=temp1;
    cellParam2{i,1}=temp2;
    cellParam3{i,1}=temp3;
   
end
