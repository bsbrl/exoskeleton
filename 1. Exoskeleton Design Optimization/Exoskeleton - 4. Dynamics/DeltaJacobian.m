function [Jq,Jx] = DeltaJacobian(Rf,Rm,Ld,Lp,theta,r_forw,kappa)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Using equation from Zhang et al 2012 doi:10.1017/S0263574711000622

theta_1 = theta(1,1);
theta_2 = theta(2,1);
theta_3 = theta(3,1);

kappa_1 = kappa(1);
kappa_2 = kappa(2);
kappa_3 = kappa(3);

% Calculate the Jaconian using the method in ZHang et al (2012) Robotica
e_1 = (Rf-Rm)*[cos(kappa_1), sin(kappa_1), 0]';
e_2 = (Rf-Rm)*[cos(kappa_2), sin(kappa_2), 0]';
e_3 = (Rf-Rm)*[cos(kappa_3), sin(kappa_3), 0]';

% the unit vectors u_i for the proximal linkages are given by: 
u_1 = [cos(kappa_1)*cos(theta_1), sin(kappa_1)*cos(theta_1), -sin(theta_1)]';
u_2 = [cos(kappa_2)*cos(theta_2), sin(kappa_2)*cos(theta_2), -sin(theta_2)]';
u_3 = [cos(kappa_3)*cos(theta_3), sin(kappa_3)*cos(theta_3), -sin(theta_3)]';

% and on the distal linkages w_i are given by:
w_1 = 1/Ld*(r_forw-e_1-Lp*u_1);
w_2 = 1/Ld*(r_forw-e_2-Lp*u_2);
w_3 = 1/Ld*(r_forw-e_3-Lp*u_3);

% rotation axis if the ith proximal link, given by:
v_1 = [-sin(kappa_1), cos(kappa_1), 0]';
v_2 = [-sin(kappa_2), cos(kappa_2), 0]';
v_3 = [-sin(kappa_3), cos(kappa_3), 0]';

% The Jacobian, J = inv(Jq)*Jx, where: 
Jx = [w_1, w_2, w_3]'; % Jx is the indirect Jacobian
Jq = diag([Lp*w_1'*cross(v_1,u_1), Lp*w_2'*cross(v_2,u_2), ...
    Lp*w_3'*cross(v_3,u_3)]); % Jq is the direct Jacobian

% NB: ZHang at el acalculate the inverse Jacobian as Jinv = inv(Jq)*Jx


end

