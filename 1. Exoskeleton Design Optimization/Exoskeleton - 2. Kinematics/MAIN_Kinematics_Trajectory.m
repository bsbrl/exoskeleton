% 6 DoF Forward and Inverse Kinematics for a 6 DoF trajectory through cartesian space
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu
% With delta robot kinematics functions from Yuliya Smirnova

% This script:
% 1. uses inverse kinematics to generate position and orientation of the end
%    effector using the 6 x motor angles
% 2. uses forward kinematics to generate position and orientation of the end 
%    effector using motor angles for the  3 x Delta robot motors, and the 
%    3 x goniometer motors. 
% 3. visualises the output

%%
clear all
% Dimensions
Rf = 0.2;      % (m) fixed platform radius
Rm = 0.1;      % (m) moving platform radius
Lp = 0.4125;      % (m) proximal linkage length
Ld = 0.755;      % (m) distal linage length
a_1 = 0.0575;     % (m) linkage 1 length (centre moving platform to frame 1 on goniometer)
a_2 = 0; % NB: hardcoded in       % (m) linkage 2 length (frame 1 to frame 2 on goniometer)
a_3 = 0; % NB: hardcoded in       % (m) linkage 3 length (frame 2 to frame 3 on goniometer)
a_4 = 0.2;     % (m) linkage 4 length (frame 3 to end effector tip on goniometer)     
Rg = 0.05;      % (m) goniometer radius for visualisation purposes)

% anglular offsets of delta motors from reference frame x-axis
kappa_1 = 6*pi/4;    % (rad)
kappa_2 = pi/6;     % (rad)
kappa_3 = 5*pi/6;   % (rad)

% anglular offset of gonioemeter motor1 frame from moving latform frame
kappa_4 = 0;

% inverse kinematics
% some example motion profiles; uncomment to select profile
% r = [x,y,z,RotY,RotX,RotZ], where alpha = rotY, beta = rotX', gamma = rotZ''

% example 1: 
pts = 20;
r_profile(1,:) = -0.2:0.4/pts:0.2-0.4/pts;
r_profile(2,:) = 0*ones(1,pts);
r_profile(3,:) = -0.8*ones(1,pts);
r_profile(4,:) = -pi/5:2*pi/5/pts:pi/5-2*pi/5/pts;
r_profile(5,:) = 0*ones(1,pts);
r_profile(6,:) = -pi/2:pi/pts:pi/2-pi/pts;

% example 2: 
% pts = 20;
% r_profile(1,:) = 0*ones(1,pts);
% r_profile(2,:) = 0*ones(1,pts);
% r_profile(3,:) = -0.8*ones(1,pts);
% r_profile(4,:) = -pi/5:2*pi/5:pi/5;
% r_profile(5,:) = 0*ones(1,pts);
% r_profile(6,:) = 0*ones(1,pts);

% example 3: 
% r_profile(2,:) = -0.2:0.4/20:0.2-0.4/20;
% r_profile(1,:) = 0*ones(1,20);
% r_profile(3,:) = -0.8*ones(1,20);
% r_profile(4,:) = 0*ones(1,20);
% r_profile(5,:) = pi/5:-2*pi/5/20:-pi/5+2*pi/5/20;
% r_profile(6,:) = 0*ones(1,20);

figure

for nn = 1:size(r_profile,2)
    
    r_inv = r_profile(:,nn);
    
    % Euler method:
    % generate the X-Y-Z rotation matrix for Euler angles using alpha, beta, gamma:
    % R_0m_Euler = XYZrotationmatrix_euler(r_inv(4),r_inv(5),r_inv(6));
    % find the goniometer motor angles using inverse kinematics relationships
    %     theta_5 = asin(-R_0m_Euler(1,3));
    %     theta_4 = atan2(R_0m_Euler(2,3),R_0m_Euler(3,3))+pi/2;
    %     theta_6 = atan2(R_0m_Euler(1,2),R_0m_Euler(1,1));
    % Inherent method
    theta_4 = -r_inv(4);
    theta_5 = r_inv(5);
    theta_6 = -r_inv(6);

    % generate the transformation matrix H_d4 and find the position of the end 
    % effector relative to the moving platform (D{m,n,q})
    [H_d4,H_45,H_56,H_6m] = gonio_transformation_matrices(kappa_4,theta_4,...
        theta_5,theta_6,a_1,a_2,a_3,a_4);

    % The coordinates of the moving platform

    H_dm = H_d4*H_45*H_56*H_6m;
    d_dm = H_dm(1:3,4);

    % platform position D{m,n,q} in the reference frame O{x,y,z}
    Dmnq_inv = r_inv(1:3,1) - d_dm;
    Dmnq_invstore(:,nn) = Dmnq_inv;

    % inverse kinematics to find motor angles
    % [theta_d1, theta_d2, theta_d3, fl] = IKinemDelta(Dmnq_inv(1),Dmnq_inv(2),Dmnq_inv(3),Rf,Rm,Lp,Ld);
    [theta_1, theta_2, theta_3, fl] = IKinemDelta2(Dmnq_inv(1),Dmnq_inv(2),Dmnq_inv(3),Rm, Rf, Ld, Lp);

    if fl == -1
        report = 'WARNING - POSITION OUT OF DELTA RANGE'
    % elseif fl == 0
    %     report = 'WITHIN DELTA RANGE'
    end
  
    theta = [theta_1,theta_2,theta_3]';
    hold off
    skeleton_plot(Rf,Rm,Lp,r_inv,Dmnq_inv,theta,H_d4,H_45,H_56,H_6m,kappa_1,kappa_2,kappa_3,Rg)
    grid off
    axis on
    xlim([-0.7 0.7])
    ylim([-0.7 0.7])
    zlim([-0.9 0.5])
    view([-0.1 -0.8 0.1])
    xlabel('x (m')
    ylabel('y (m')
    zlabel('z (m')
    pause(0.25)
    
end


















