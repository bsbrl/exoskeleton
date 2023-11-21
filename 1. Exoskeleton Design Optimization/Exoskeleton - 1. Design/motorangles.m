function [theta_i,E_i,F_i,G_i] = motorangles(r,e_i,Beta_i)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu
% Using Eqauations from Zhang et al 2012 doi:10.1017/S0263574711000622

% Inverse Kinematics:
% Calculation of variables E_i, F_i, and G_i followed by calculation 
% of motor angle
% Lp = length of proximal linkage
% r = position vector of point O' on moving platform
% e_i = vector connecting origin O to motor (compensated for moving
% platform size)
global Lp Ld

% unit vectors of origin:
x_hat = [1 0 0]';
y_hat = [0 1 0]';
z_hat = [0 0 1]';

E_i = 2*Lp*(r-e_i)'*z_hat;
F_i = -2*Lp*(r-e_i)'*(cos(Beta_i)*x_hat+sin(Beta_i)*y_hat);
G_i = (r-e_i)'*(r-e_i)+Lp^2-Ld^2;

theta_i = 2*atan((-E_i-(E_i^2-G_i^2+F_i^2)^0.5)/(G_i-F_i));



end

