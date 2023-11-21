function [Tau] = Deltajointforce_v3(Lp,Ld,r_dotdot,f_r_dot,f_D,J,Theta)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Using dynamics equations from Zhang et al 2012 doi:10.1017/S0263574711000622


% NB : this section can probably be improved...

g = -9.8;     % (m/s^2) accel. from gravity
z_hat = -[0 0 1]';

% system properties
mu_1 = 1.3; % (kg/m) of proximal linkage
mu_2 = 1.0; % (kg/m) of distal linkage
m_A = mu_1*Lp; % (kg) mass of proximal linkage
r_A = Lp/2;  % assume centre of gravity is halfway along the linkage
m_B = 0.25;  % (kg) lump mass at B
m_C = 3;     % (kg) mass of moving platform

% the inertia of the components in each kinematic chain:
I_A1 = 0.17;         % (kg.m^2) gearbox
I_A2 = mu_1*Lp^3/3;    % (kg.m^2) intermediate section
I_A3 = m_B*Lp^2;       % (kg.m^2) lump mass at B
I_A4 = 4*mu_2*Ld*Lp^2/3; % (kg.m^2) equivalent mass of distal links
I_A = I_A1 + I_A2 + I_A3 + I_A4;

Eta = m_C/I_A;
G = Eta*J'+inv(J);
Tau_a = I_A*G*r_dotdot;     % Inertial torque
Tau_v = I_A*f_r_dot;        % centrifuge/Coriolis torque
Tau_Ag = m_A*r_A*g*[cos(Theta(1)) cos(Theta(2)) cos(Theta(3))]'; % gravitational torque from Delta arms
Tau_g = m_C*g*J'*z_hat + Tau_Ag;  % gravitational torque
Tau_d = J'*f_D;     % force exetered on delta platform by gonioemeter

% the motor torque in each arm
Tau = Tau_a + Tau_v + Tau_g + Tau_d; % (N.m)


% % system properties
% mu_1 = 1.3; % (kg/m) of proximal linkage
% m_A = mu_1*Lp; % (kg) mass of proximal linkage
% r_A = Lp/2;  % assume centre of gravity is halfway along the linkage
% m_B = 0.2;  % (kg) lump mass at B
% 
% Tau_Ag = m_A*r_A*g*[cos(Theta(1)) cos(Theta(2)) cos(Theta(3))]';
% Tau_d = Jinv'*f_D;     % force exetered on delta platform by gonioemeter
% Tau = Tau_Ag + Tau_d; % (N.m)


end

