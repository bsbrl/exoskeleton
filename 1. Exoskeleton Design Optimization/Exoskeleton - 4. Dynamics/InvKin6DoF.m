function [theta_inv,report] = InvKin6DoF(r_inv,kappa_4,a_1,a_2,a_3,a_4,Rm, Rf, Ld, Lp)
% Author: James Hope


theta_4 = -r_inv(4);
theta_5 = r_inv(5);
theta_6 = -r_inv(6);

% generate the transformation matrix H_d4 and find the position of the end 
% effector relative to the moving platform (D{m,n,q})
[H_d1,H_12,H_23,H_34] = gonio_transformation_matrices(kappa_4,theta_4,...
    theta_5,theta_6,a_1,a_2,a_3,a_4);

H_d4 = H_d1*H_12*H_23*H_34;
d_d4 = H_d4(1:3,4);

% platform position D{m,n,q} in the reference frame O{x,y,z}
Dmnq_inv = r_inv(1:3,1) - d_d4;

% inverse kinematics to find motor angles
% [theta_d1, theta_d2, theta_d3, fl] = IKinemDelta(Dmnq_inv(1),Dmnq_inv(2),Dmnq_inv(3),Rf,Rm,Lp,Ld);
[theta_1, theta_2, theta_3, fl] = IKinemDelta2(Dmnq_inv(1),Dmnq_inv(2),Dmnq_inv(3),Rm, Rf, Ld, Lp);

if fl == -1
    report = {'WARNING - POSITION OUT OF DELTA RANGE'};
elseif fl == 0
    report = {'WITHIN DELTA RANGE'};
end

theta_inv = [theta_1,theta_2,theta_3,theta_4,theta_5,theta_6]';
% theta_inv_deg = [theta_1,theta_2,theta_3,theta_4,theta_5,theta_6]'.*180/pi;



end

