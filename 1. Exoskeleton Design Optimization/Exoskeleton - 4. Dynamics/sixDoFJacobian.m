function [J] = sixDoFJacobian(J,a_4,theta_t0)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


theta_4 = theta_t0(4,1);
theta_5 = theta_t0(5,1);
theta_6 = theta_t0(6,1);

% The angular rotation of the end effector from the Delta robot  should be 
% all 0' s because the Delta robot does not generate any angular velocities
J(4:6,1:3) = 0;

% The angular rotation of the end effector produced by the goniometer 
% will be a diagonal matrix if joints (axes) are uncoupled

J(4:6,4) = [1,0,0]';
J(4:6,5) = [0,-1,0]';
J(4:6,6) = [0,0,-1]';

% The linear translation of the end effector produced by the goniometer
J(1:3,4) = [-a_4*sin(theta_5), -a_4*cos(theta_4)*cos(theta_5),...
                a_4*sin(theta_4)*cos(theta_5)]';

J(1:3,5) = [-a_4*cos(theta_5), a_4*sin(theta_4)*sin(theta_5),...
                a_4*cos(theta_4)*sin(theta_5)];

J(1:3,6) = [0,0,0]';    





end

