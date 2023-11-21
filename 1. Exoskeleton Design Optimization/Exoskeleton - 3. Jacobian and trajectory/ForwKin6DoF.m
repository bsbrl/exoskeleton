function [r_forw] = ForwKin6DoF(trajectory_joint,kappa_4,a_1,a_2,a_3,a_4,Rm, Rf, Ld, Lp)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% forward kinematics 
% Zsombor-Murray method

Dmnq_forw = zeros(3,1); % delta moving platform xyz position
r_forw = zeros(6,1);    % empty array to store position and orientation 

% FKinemDelta function by Yulia Smirnova (2019) Mathworks
[Dmnq_forw(1),Dmnq_forw(2),Dmnq_forw(3), ~] = FKinemDelta(trajectory_joint(1),...
    trajectory_joint(2),trajectory_joint(3),Rf,Rm,Lp,Ld);

% Goniometer kinematics
[H_d4,H_45,H_56,H_6m] = gonio_transformation_matrices(kappa_4,trajectory_joint(4),...
    trajectory_joint(5),trajectory_joint(6),a_1,a_2,a_3,a_4);

H_dm = H_d4*H_45*H_56*H_6m;
d_dm = H_dm(1:3,4);

r_forw(1:3,1) = Dmnq_forw + d_dm;

r_forw(4,1) = -theta_4;     % rotY Euler angle
r_forw(5,1) = theta_5;      % rotX Euler angle
r_forw(6,1) = -theta_6;     % rotZ Euler angle


end

