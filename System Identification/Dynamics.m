function [y,dy] = Dynamics(dt, x, param, param1, param2, param3, zeta, gamma_i, gamma_a, gamma_d,  gamma_h, ksi_i, ksi_d, mu_a, mu_h)

    dy(1,1) = -param*x(2,1)*x(1,1) - param1*x(3,1)*x(1,1) - zeta*x(1,1);
    dy(2,1) = param*x(2,1)*x(1,1) + param1*x(3,1)*x(1,1) - ksi_i*x(2,1) - gamma_i*x(2,1);
    dy(3,1) = param2*x(2,1)*x(7,1) + param3*x(3,1)*x(7,1) - ksi_d*x(3,1) - gamma_d*x(3,1);
    dy(4,1) = ksi_i*x(2,1) - gamma_a*x(4,1) - mu_a*x(4,1);
    dy(5,1) = gamma_i*x(2,1) + gamma_d*x(3,1) + gamma_a*x(4,1) + gamma_h*x(8,1);
    dy(6,1) = mu_a*x(4,1) + mu_h*x(8,1);
    dy(7,1) = zeta*x(1,1) - param2*x(2,1)*x(7,1) - param3*x(3,1)*x(7,1);
    dy(8,1) = ksi_d*x(3,1) - gamma_h*x(8,1) - mu_h*x(8,1);
    
    y = max(x + dt*dy,0);   %State update

end