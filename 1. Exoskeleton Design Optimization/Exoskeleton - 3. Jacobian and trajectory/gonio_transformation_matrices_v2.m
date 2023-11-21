function [H_d4,H_45,H_56,H_6m] = gonio_transformation_matrices_v2(kappa_4,theta_4,theta_5,theta_6,a_1,a_2,a_3,a_4)

% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% generate the transformation matrices from the Delta moving platform to 
% the end effector: H_d1,H_12,H_23,H_34

% delta robot moving platform frame to gonio motor1 frame (fixed angle)
Rotz = Rotzfun(kappa_4);
R_d4 = Rotz*[0,0,-1;1,0,0;0,-1,0];
d_d4 = [0,0,-a_1]';
H_d4 = [R_d4,d_d4;0,0,0,1];

% motor 4 frame to motor 5 frame
Rotz = Rotzfun(theta_4);
R_45 = Rotz*[0,0,-1;1,0,0;0,-1,0];
d_45 = [0,0,0]';
H_45 = [R_45,d_45;0,0,0,1];

% motor 5 frame to motor 6 frame
Rotz = Rotzfun(theta_5);
R_56 = Rotz*[0,0,1;1,0,0;0,1,0];
d_56 = [0,0,0]';
H_56 = [R_56,d_56;0,0,0,1];

% motor 6 frame to end effector (mouse) frame
Rotz = Rotzfun(theta_6);
R_6m = Rotz*[1,0,0;0,-1,0;0,0,-1];
d_6m = [0,0,-a_4]';
H_6m = [R_6m,d_6m;0,0,0,1];


end

