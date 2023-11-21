function [R_04_Euler] = XYZrotationmatrix_euler(alpha,beta,gamma)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

R_04_Euler = ...     % row 1: 
    [cos(gamma)*cos(beta), cos(gamma)*sin(beta)*sin(alpha)-sin(gamma)*cos(alpha), ...
    cos(gamma)*sin(beta)*cos(alpha)-sin(gamma)*sin(alpha); ...
    % row 2:
    sin(gamma)*cos(beta), sin(gamma)*sin(beta)*sin(alpha)-cos(gamma)*cos(alpha), ...
    sin(gamma)*sin(beta)*cos(alpha)-cos(gamma)*cos(alpha);...
    % row 3:
    -sin(beta), cos(beta)*sin(alpha), cos(beta)*sin(alpha)];


end

