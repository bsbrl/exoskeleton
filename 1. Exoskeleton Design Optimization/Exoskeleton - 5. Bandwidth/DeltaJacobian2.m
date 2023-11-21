function [Jq,Jx] = DeltaJacobian2(u_1,u_2,u_3,w_1,w_2,w_3,v_1,v_2,v_3,Lp)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Using dynamics equations from Zhang et al 2012 doi:10.1017/S0263574711000622


% The Jacobian, J = inv(Jq)*Jx, where: 
Jx = [w_1, w_2, w_3]'; % Jx is the indirect Jacobian
Jq = diag([Lp*w_1'*cross(v_1,u_1), Lp*w_2'*cross(v_2,u_2), ...
    Lp*w_3'*cross(v_3,u_3)]); % Jq is the direct Jacobian

end

