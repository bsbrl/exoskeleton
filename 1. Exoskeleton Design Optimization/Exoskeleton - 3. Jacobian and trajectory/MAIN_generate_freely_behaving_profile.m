% Defining a 6DoF trajectory and then visualising the resultant motor and 
% end-effector velocities
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% With delta robot kinematics functions from Yuliya Smirnova

% This script:
% 1. Loads data on freely behaving mouse in open field arena
% 2. Converts each point in the data to joint-space using inverse
%    kinematics
% 3. Calculates Jaobian at each point
% 4. Converts each velocity to joint-space velocity using
%    Jacobian

clear all

%% Exoskeleton Dimensions
Rf = 0.2;      % (m) fixed platform radius
Rm = 0.1;      % (m) moving platform radius
Lp = 0.4125;      % (m) proximal linkage length
Ld = 0.8;      % (m) distal linage length
a_1 = 0; %0.0575;     % (m) linkage 1 length (centre moving platform to frame 1 on goniometer)
a_2 = 0; % NB: hardcoded in       % (m) linkage 2 length (frame 1 to frame 2 on goniometer)
a_3 = 0; % NB: hardcoded in       % (m) linkage 3 length (frame 2 to frame 3 on goniometer)
a_4 = 0.2;     % (m) linkage 4 length (frame 3 to end effector tip on goniometer)     
Rg = 0.05;      % (m) goniometer radius for visualisation purposes)

% anglular offsets of delta motors from reference frame x-axis
kappa_1 = 9/6*pi;    % (rad)
kappa_2 = 1/6*pi;     % (rad)
kappa_3 = 5/6*pi;   % (rad)
% anglular offsets of delta motors from reference frame x-axis
Kappa = [kappa_1, kappa_2, kappa_3];

% anglular offset of gonioemeter motor1 frame from moving latform frame
kappa_4 = 0;


%% Data from Rynes, Surinach et al (2021) Nature Methods 
% Miniaturized head-mounted microscope for whole-cortex mesoscale 
% imaging in freely behaving mice
% NB: data collected with top down camera view => no pitch or roll axes
% NB: z axis coordinates set manually to -0.8 m; this may have to change 
% depending on your delta robot dimensions (above)

load('Mesoscope_data.mat')
        
figure
title('synchronised axis motion with mouse motion data')
yyaxis left
plot(trajectory_coordfilt')
ylabel('position (m) or (rad)')
yyaxis right 
plot(trajectory_vel')
ylabel('velocity (m/s) or (rad/s)')
legend('x','y','z','rotY','rotX','rotZ','x','y','z','rotY','rotX','rotZ')
yyaxis left
ylim([-0.8 0.8])
yyaxis right
ylim([-0.8 0.8])

% % stationary test
% trajectory_coordfilt = [0.24.*ones(1,20);0.24.*ones(1,20);-0.75.*ones(1,20);0.*ones(1,20);0.*ones(1,20);0.*ones(1,20)];
% trajectory_vel = zeros(6,20);
% timearray = 1:20;

%% visualize profile
figure
for n = 1:size(trajectory_coordfilt,2)
    r_inv = trajectory_coordfilt(:,n);

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
    Dmnq_invstore(:,n) = Dmnq_inv;

    % inverse kinematics to find motor angles
    % [theta_d1, theta_d2, theta_d3, fl] = IKinemDelta(Dmnq_inv(1),Dmnq_inv(2),Dmnq_inv(3),Rf,Rm,Lp,Ld);
    [theta_1, theta_2, theta_3, fl] = IKinemDelta2(Dmnq_inv(1),Dmnq_inv(2),Dmnq_inv(3),Rm, Rf, Ld, Lp);

    if fl == -1
        report = 'WARNING - POSITION OUT OF DELTA RANGE'
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
    pause(0.02)
end
%% Convert the trajectory coordinates from op-space to joint-space using inverse kinematics

% trajectory_coord = trajectory_coordfilt;
% trajectory_coord(3,:) = trajectory_coord(3,:)-0.3;

trajectory_joint = zeros.*(trajectory_coordfilt);   % empty array
trajectory_jointvel = zeros.*(trajectory_coordfilt);   % empty array

% joint positions along trajectory
for n = 1:size(trajectory_coordfilt,2)
    
  [trajectory_joint(:,n),report2{1,n}] = InvKin6DoF(trajectory_coordfilt(:,n),kappa_4,a_1,a_2,a_3,a_4,Rm, Rf, Ld, Lp);
    
end

% joint velocity along trajectory
for n = 1:size(trajectory_coordfilt,2)
% calculate inverse Jacobian
    J = zeros(6,6);
    % calc position of delta moving platform
    [Dmnq(1),Dmnq(2),Dmnq(3), ~] = FKinemDelta(trajectory_joint(1,n),...
    trajectory_joint(2,n),trajectory_joint(3,n),Rf,Rm,Lp,Ld);
    % delta inverse Jacobian
    [Jq,Jx] = DeltaJacobian(Rf,Rm,Ld,Lp,trajectory_joint(1:3,n),Dmnq',Kappa);
    J(1:3,1:3) = inv(inv(Jq)*Jx);  
    % Jacobian elements
    [J] = sixDoFJacobian(J,a_4,trajectory_joint(:,n));
    Jinv = inv(J); % inverse Jacobian
    
% joint velocity along trajectory
    trajectory_jointvel(:,n) = Jinv*trajectory_vel(:,n);
    
end

%% plot results = joint position and velocity

figure
title('synchronised axis motion with trapezoidal profile')
yyaxis left
plot(timearray,trajectory_joint')
ylabel('joint position (rad)')
yyaxis right 
plot(timearray,trajectory_jointvel')
ylabel('joint velocity (rad/s)')
legend('theta1','theta2','theta3','theta4','theta5','theta6','theta1','theta2','theta3','theta4','theta5','theta6')

%% plot results = joint acceleration
trajectory_jointaccelest = (trajectory_jointvel(:,2:end)-trajectory_jointvel(:,1:end-1))./tincr;

figure
plot(timearray(1:end-1),trajectory_jointaccelest')
xlabel('time(s)')
ylabel('accel (rad/s2)')
legend('theta1','theta2','theta3')





