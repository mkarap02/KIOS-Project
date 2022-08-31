clc;
clear all;

% Import the csv file in a table
Active = readtable('Trajectories.csv');
Trajectories=Active;
%Trajectories = readtable('Trajectories.csv','Range','B1:I786');
VaccinationsPerDay = readtable('VaccinationsPerDay.csv');

% Dividing all the states with the total population number
Trajectories.Susceptible=Trajectories.Susceptible/896005;
Trajectories.VaccinatedSusceptible=Trajectories.VaccinatedSusceptible/896005;
Trajectories.Infected=Trajectories.Infected/896005;
Trajectories.VaccinatedInfected=Trajectories.VaccinatedInfected/896005;
Trajectories.Hospitalized=Trajectories.Hospitalized/896005;
Trajectories.VaccinatedHospitalized=Trajectories.VaccinatedHospitalized/896005;
Trajectories.Recovered=Trajectories.Recovered/896005;
Trajectories.Extinct=Trajectories.Extinct/896005;
VaccinationsPerDay.Vaccinations=VaccinationsPerDay.Vaccinations/896005;

for i=324:324   %loop for all the days
    
        %--------DATA--------

        %Function to specify period of time
            %01/02/2021  
            %01/03/2021
        infmt='dd/MM/yyyy';
        d1=Trajectories.Dates(i); %"01/02/2021";
        d2=Trajectories.Dates(i+13);
        datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')
        date1=datetime(d1,"InputFormat",infmt);
        date2=datetime(d2,"InputFormat",infmt);
        [ClearedTrajectories]=Dates(Trajectories,date1,date2);  %Table with the data for the examined days
        [ClearedVaccinations]=Dates(VaccinationsPerDay,date1,date2);
        count=height(ClearedTrajectories);

        param = 0.3899;                     %param=beta*(1-u)              Definition of R0 in SIDARE, proven in paper          
        param1 = 0.19495;                   %param1=\tilde{beta}*(1-u)     Rate which a vaccinated person infect an unvaccinated person
        param2 = 0.05849;                   %param2=\hat{beta}*(1-u)       Rate which a vaccinated person infect another vaccinated person
        param3 = 0.11697;                   %param3=\bar{beta}*(1-u)       Rate which an unvaccinated person infect a vaccinated person

        %Initialization of Model Parameters (from Thesis)
        gamma_i = 0.0714;                   %Recovery rate from infected detected
        gamma_a = 0.0807;                   %Recovery rate from acutely symptomatic
        gamma_d = 1/14;                     %Recovery rate from vaccinated infected detected
        gamma_h = 1/12.39;                  %Recovery rate from vaccinated acutely symptomatic
        ksi_i = 0.0053;                     %Transition rate from infected detected to acutely symptomatic
        ksi_d = 0.000265;                   %Transition rate from vaccinated infected detected to vaccinated acutely symptomatic
        mu_a = 0.00085;                     %Transition rate from acutely symptomatic to deceased
        mu_h = 0.0085;                      %Transition rate from vaccinated acutely symptomatic to deceased

        [InitialCost,x_init,C_init] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);

        temp=param; temp1=param1; temp2=param2; temp3=param3;
        temp_gi=gamma_i; temp_ga=gamma_a; temp_gd=gamma_d; temp_gh=gamma_h;
        temp_ki=ksi_i; temp_kd=ksi_d;
        temp_mua=mu_a; temp_muh=mu_h;
        TempCost=InitialCost;

        numofiterations=0;
        flag=0;
        percentage=0.01;

        while (flag == 0)

            change(1)=temp+temp*percentage;      %Increase of param
            change(2)=temp-temp*percentage;      %Decrease of param
            change(3)=temp1+temp1*percentage;    %Increase of param1
            change(4)=temp1-temp1*percentage;    %Decrease of param1
            change(5)=temp2+temp2*percentage;    %Increase of param2
            change(6)=temp2-temp2*percentage;    %Decrease of param2
            change(7)=temp3+temp3*percentage;    %Increase of param3
            change(8)=temp3-temp3*percentage;    %Decrease of param3
            change(9)=temp_gi+temp_gi*percentage;
            change(10)=temp_gi-temp_gi*percentage;
            change(11)=temp_ga+temp_ga*percentage;
            change(12)=temp_ga-temp_ga*percentage;
            change(13)=temp_gd+temp_gd*percentage;
            change(14)=temp_gd-temp_gd*percentage;
            change(15)=temp_gh+temp_gh*percentage;
            change(16)=temp_gh-temp_gh*percentage;
            change(17)=temp_ki+temp_ki*percentage;
            change(18)=temp_ki-temp_ki*percentage;
            change(19)=temp_kd+temp_kd*percentage;
            change(20)=temp_kd-temp_kd*percentage;
            change(21)=temp_mua+temp_mua*percentage;
            change(22)=temp_mua-temp_mua*percentage;
            change(23)=temp_muh+temp_muh*percentage;
            change(24)=temp_muh-temp_muh*percentage;

            [C(1,1),x{1,1},C_vec{1,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,change(1),param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(2,1),x{2,1},C_vec{2,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,change(2),param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(3,1),x{3,1},C_vec{3,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,change(3),param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(4,1),x{4,1},C_vec{4,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,change(4),param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(5,1),x{5,1},C_vec{5,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,change(5),param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(6,1),x{6,1},C_vec{6,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,change(6),param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(7,1),x{7,1},C_vec{7,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,change(7),gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(8,1),x{8,1},C_vec{8,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,change(8),gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(9,1),x{9,1},C_vec{9,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,change(9),gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(10,1),x{10,1},C_vec{10,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,change(10),gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(11,1),x{11,1},C_vec{11,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,change(11),gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(12,1),x{12,1},C_vec{12,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,change(12),gamma_d,gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(13,1),x{13,1},C_vec{13,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,change(13),gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(14,1),x{14,1},C_vec{14,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,change(14),gamma_h,ksi_i,ksi_d,mu_a,mu_h);
            [C(15,1),x{15,1},C_vec{15,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,change(15),ksi_i,ksi_d,mu_a,mu_h);
            [C(16,1),x{16,1},C_vec{16,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,change(16),ksi_i,ksi_d,mu_a,mu_h);
            [C(17,1),x{17,1},C_vec{17,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,change(17),ksi_d,mu_a,mu_h);
            [C(18,1),x{18,1},C_vec{18,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,change(18),ksi_d,mu_a,mu_h);
            [C(19,1),x{19,1},C_vec{19,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,change(19),mu_a,mu_h);
            [C(20,1),x{20,1},C_vec{20,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,change(20),mu_a,mu_h);
            [C(21,1),x{21,1},C_vec{21,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,change(21),mu_h);
            [C(22,1),x{22,1},C_vec{22,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,change(22),mu_h);
            [C(23,1),x{23,1},C_vec{23,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,change(23));
            [C(24,1),x{24,1},C_vec{24,1}] = SystemIdentification(ClearedTrajectories,ClearedVaccinations,count,param,param1,param2,param3,gamma_i,gamma_a,gamma_d,gamma_h,ksi_i,ksi_d,mu_a,change(24));

            min(C)

            %Find the parameter (minchange) that leads to the minimum cost (min(C)).
            if ( min(C) < TempCost )
               TempCost = min(C);
               minchange = find(C(:,1)==min(C));

               %10^-3

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

               elseif (minchange==9)
                   temp_gi = change(9);
                   x_rev = x{9,1};
                   C_rev = C_vec{9,1};

               elseif (minchange==10)
                   temp_gi = change(10);
                   x_rev = x{10,1};
                   C_rev = C_vec{10,1};

               elseif (minchange==11)
                   temp_ga = change(11);
                   x_rev = x{11,1};
                   C_rev = C_vec{11,1};

               elseif (minchange==12)
                   temp_ga = change(12);
                   x_rev = x{12,1};
                   C_rev = C_vec{12,1};

               elseif (minchange==13)
                   temp_gd = change(13);
                   x_rev = x{13,1};
                   C_rev = C_vec{13,1};

               elseif (minchange==14)
                   temp_gd = change(14);
                   x_rev = x{14,1};
                   C_rev = C_vec{14,1};

               elseif (minchange==15)
                   temp_gh = change(15);
                   x_rev = x{15,1};
                   C_rev = C_vec{15,1};

               elseif (minchange==16)
                   temp_gh = change(16);
                   x_rev = x{16,1};
                   C_rev = C_vec{16,1};

               elseif (minchange==17)
                   temp_ki = change(17);
                   x_rev = x{17,1};
                   C_rev = C_vec{17,1};

               elseif (minchange==18)
                   temp_ki = change(18);
                   x_rev = x{18,1};
                   C_rev = C_vec{18,1};

               elseif (minchange==19)
                   temp_kd = change(19);
                   x_rev = x{19,1};
                   C_rev = C_vec{19,1};

               elseif (minchange==20)
                   temp_kd = change(20);
                   x_rev = x{20,1};
                   C_rev = C_vec{20,1};

               elseif (minchange==21)
                   temp_mua = change(21);
                   x_rev = x{21,1};
                   C_rev = C_vec{21,1};    

               elseif (minchange==22)
                   temp_mua = change(22);
                   x_rev = x{22,1};
                   C_rev = C_vec{22,1};

               elseif (minchange==23)
                   temp_muh = change(23);
                   x_rev = x{23,1};
                   C_rev = C_vec{23,1};

               elseif (minchange==24)
                   temp_muh = change(24);
                   x_rev = x{24,1};
                   C_rev = C_vec{24,1};

               end

               numofiterations = numofiterations + 1;   %counting iterations while flag becomes 1

            else 
               flag = 1;

            end


        end
end