function [H_i] = Hessian2(v_i,u_i,w_i,Lp,Ld)
% Calculate the Hessian matrix as part of f_r_dot calcs
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Using equation from Zhang et al 2012 doi:10.1017/S0263574711000622

E3 = eye([3,3]); % identity matrix
crossvu = cross(v_i,u_i);
del_i = w_i'*crossvu;

sub1 = ((crossvu'*crossvu)*(w_i*w_i'))/(del_i^2);
sub2 = E3 - (crossvu*w_i')/del_i;

H_i = 1/(Lp^2*del_i)*(sub1 + Lp/Ld*(sub2'*sub2));


end

