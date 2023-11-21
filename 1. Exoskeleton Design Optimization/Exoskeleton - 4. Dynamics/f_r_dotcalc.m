function [f_r_dot] = f_r_dotcalc(u_1,u_2,u_3,w_1,w_2,w_3,v_1,v_2,v_3,Lp,Ld,r_dot)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Using equation from Zhang et al 2012 doi:10.1017/S0263574711000622

% also calculate the Hessian while vector values are available:
[H_1] = Hessian2(v_1,u_1,w_1,Lp,Ld);
[H_2] = Hessian2(v_2,u_2,w_2,Lp,Ld);
[H_3] = Hessian2(v_3,u_3,w_3,Lp,Ld);

f_1_r_dot = r_dot'*H_1*r_dot;
f_2_r_dot = r_dot'*H_2*r_dot;
f_3_r_dot = r_dot'*H_3*r_dot;

f_r_dot = [f_1_r_dot, f_2_r_dot, f_3_r_dot]';


end

