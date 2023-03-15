function [y,dy] = Dynamics(dt, x, param, param1, param2, param3, vaccperday, gamma_i, gamma_a, gamma_d,  gamma_h, ksi_i, ksi_d, mu_a, mu_h)

    dy(1,1) = -param*x(2,1)*x(1,1) - param1*x(3,1)*x(1,1) - vaccperday;                         %S : Susceptible
    dy(2,1) = param*x(2,1)*x(1,1) + param1*x(3,1)*x(1,1) - ksi_i*x(2,1) - gamma_i*x(2,1);       %I : Infected detected
    dy(3,1) = param2*x(2,1)*x(7,1) + param3*x(3,1)*x(7,1) - ksi_d*x(3,1) - gamma_d*x(3,1);      %D : Vaccinated infected Detected
    dy(4,1) = ksi_i*x(2,1) - gamma_a*x(4,1) - mu_a*x(4,1);                                      %A : Acutely Symptomatic
    dy(5,1) = gamma_i*x(2,1) + gamma_d*x(3,1) + gamma_a*x(4,1) + gamma_h*x(8,1);                %R : Recovered
    dy(6,1) = mu_a*x(4,1) + mu_h*x(8,1);                                                        %E : Extinct
    dy(7,1) = vaccperday - param2*x(2,1)*x(7,1) - param3*x(3,1)*x(7,1);                         %V : Vaccinated Susceptible 
    dy(8,1) = ksi_d*x(3,1) - gamma_h*x(8,1) - mu_h*x(8,1);                                      %H : Vaccinated acutely symptomatic
    
    y = max(x + dt*dy,0);   %State update

end