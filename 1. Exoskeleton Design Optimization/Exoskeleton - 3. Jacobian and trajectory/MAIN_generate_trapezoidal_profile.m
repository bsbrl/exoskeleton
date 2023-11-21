% Defining a 6DoF trajectory and then visualising the resultant motor and 
% end-effector velocities
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% With delta robot kinematics functions from Yuliya Smirnova

% This script:
% 1. Defines trajectory in operational space using trapezoidal accel/deccel 
%    profile (a set of positions and velocities at t_n time increments)
% 2. Converts each point in trajectory to joint-space using inverse
%    kinematics
% 3. Calculates Jaobian at each point
% 4. Converts each velocity in trajectory to joint-space velocity using
%    Jacobian

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


%% Trajectory 
% For further info on trapezoidal profiles see REF: 
% [Modeling, Performance Analysis and Control of Robot Manipulators]
% [Etienne Dombre & Wisama Khalil]
% [Copyright 0 2007, ISTE Ltd.]

% op-space coordinates
% [x,y,z](m);[thetay,thetax,thetaz](rad)
r_start = [-0.2,0.2,-0.8,0.5,0,0]';       
r_fin = [0.2,-0.2,-0.8,-0.5,0,0]'; 
v_maxs = [0.2,0.2,0.2,0.5,0.5,0.5]';         % (m/s) and (rad/s)
a_maxs = [1,1,1,1.5,1.5,1.5]';       % (m/s^2) and (rad/s^2)

% op-space coordinates
% r_start = [-0.2,0.2,-0.8,0.5,0,0]';        % [x,y,z](m);[thetay,thetax,thetaz](rad)
% r_fin = [0.2,-0.2,-0.8,-0.5,0,0]';     % [x,y,z](m);[thetay,thetax,thetaz](rad)
% v_maxs = [0.828,0.828,0.828,6.3,6.3,6.3]';         % (m/s) and (rad/s)
% a_maxs = [2.743,2.743,2.743,17.5,17.5,17.5]';       % (m/s^2) and (rad/s^2)

tincr = 0.02;                               % (s)

% assuming a stationary start in all axes:
    % distance travelled in each axis of operational-space
    d_pathL = abs(r_fin - r_start);               % (m)
    d_path = (r_fin - r_start);               % (m)
    % time to reach max vel at max accel
    t_amax = (d_pathL>0).*v_maxs./a_maxs;    % (s)
    % distance travelled during t_amax
    d_amax = 0.5.*a_maxs.*t_amax.^2;        % (m)
    % fraction of half path length travelled during t_amax (take half pat
    % length because profile is symmetrical)
    lambda = d_amax./(d_pathL./2);           % unitless
    % find maximum lambda value (slowest axis)
    [~,lminr] = min(lambda);
    lambdamin = lambda(lminr,1);              % unitless
    [~,lmaxr] = max(lambda);
    lambdamax = lambda(lmaxr,1);              % unitless
% then generate the trapezoidal profile based on this slow axis
    if lambdamin > 1  % then there is no constant velocity profile
        d_accel(lmaxr,1) = d_path(lmaxr,1)./2;         % for slowest axis   (m)
        accel(lmaxr,1) = a_maxs(lmaxr,1);       % for slowest axis   (m/s^2)
        t_accel = sqrt(abs(2*d_accel(lmaxr,1)/accel(lmaxr,1)));
        accel = 2.*(d_path./2)./(t_accel.^2);      % (m/s^2)
        v_c = accel.*t_accel;               % (m/s) 
        t_vc = 0;                           % (s) 
    elseif lambdamin < 1
        t_accel = t_amax(lminr,1); % all axes track slow axis
        d_accel = lambdamin.*d_path/2;      % (m)
        accel = 2.*d_accel/(t_accel.^2);    % (m/s^2)
        v_c = accel.*t_accel;               % (m/s)
        d_vc = d_path./2 - d_accel;         % (m)
        t_vc = d_vc./v_c;   % all populated cells should be equal  (s)
    end
%
% use the velocity and acceleration values to generate 6DoF trajectory

t_fin = 2.*t_accel + 2.*max(t_vc);          % (s)
t_finr = round(t_fin/tincr).*tincr;         % round to nearest tincr (s)  
timearray = tincr:tincr:t_finr;                 % (s)
t_accelr = round(t_accel/tincr).*tincr;     % round to nearest tincr (s)
t_vcr = round(2.*max(t_vc)/tincr).*tincr;   % round to nearest tincr (s)

trajectory_coord = zeros(6,size(timearray,2));    % empty array
trajectory_vel = 0.*trajectory_coord;           % empty array

% trajectory position profile
    % acceleration phase
    trajectory_coord(:,1:round(t_accelr/tincr)) = ...
       r_start + 0.5.*accel.*timearray(:,1:round(t_accelr/tincr)).^2;
    if lambdamin < 1
    % constant velocity phase
        trajectory_coord(:,t_accelr/tincr+1:t_accelr/tincr+t_vcr/tincr) = ...
            trajectory_coord(:,t_accelr/tincr) + v_c.*timearray(:,1:t_vcr/tincr);
    % decceleretaion phase
        trajectory_coord(:,t_accelr/tincr+t_vcr/tincr+1:end) = ...
            trajectory_coord(:,round(t_accelr/tincr+t_vcr/tincr)) + ...
            v_c.*timearray(:,1:t_accelr/tincr) + ...
            -0.5*accel.*timearray(:,1:t_accelr/tincr).^2;
    else
    % decceleretaion phase
    trajectory_coord(:,t_accelr/tincr+t_vcr/tincr:end) = ...
        trajectory_coord(:,round(t_accelr/tincr+t_vcr/tincr+1)) + ...
        v_c.*timearray(:,1:t_accelr/tincr) + ...
        -0.5*accel.*timearray(:,1:t_accelr/tincr).^2;
    end
    
% trajectory velocity profile
    % acceleration phase
    trajectory_vel(:,1:t_accelr/tincr+1) = accel.*timearray(:,1:t_accelr/tincr+1);
    if lambdamin < 1
    % constant velocity phase    
        trajectory_vel(:,t_accelr/tincr+1:t_accelr/tincr+t_vcr/tincr) = ...
            repmat(v_c,1,t_accelr/tincr+t_vcr/tincr - t_accelr/tincr);
    % decceleretaion phase
        trajectory_vel(:,t_accelr/tincr+t_vcr/tincr+1:end) = ...
            trajectory_vel(:,round(t_accelr/tincr+t_vcr/tincr)) - ...
            accel.*timearray(:,1:t_accelr/tincr);
    else
    % decceleretaion phase
        trajectory_vel(:,t_accelr/tincr+t_vcr/tincr:end) = ...
            trajectory_vel(:,round(t_accelr/tincr+t_vcr/tincr)) - ...
            accel.*timearray(:,1:t_accelr/tincr);        
    end
        
        
figure
title('synchronised axis motion with trapezoidal profile')
yyaxis left
plot(trajectory_coord')
ylabel('position (m) or (rad)')
yyaxis right 
plot(trajectory_vel')
ylabel('velocity (m/s) or (rad/s)')
legend('x','y','z','rotY','rotX','rotZ','x','y','z','rotY','rotX','rotZ')
yyaxis left
ylim([-0.8 0.8])
yyaxis right
ylim([-0.8 0.8])
%% visualize profile
figure
for n = 1:size(trajectory_coord,2)
    r_inv = trajectory_coord(:,n);

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

trajectory_joint = zeros.*(trajectory_coord);   % empty array
trajectory_jointvel = zeros.*(trajectory_coord);   % empty array

% joint positions along trajectory
for n = 1:size(trajectory_coord,2)
    
  [trajectory_joint(:,n),report2{1,n}] = InvKin6DoF(trajectory_coord(:,n),kappa_4,a_1,a_2,a_3,a_4,Rm, Rf, Ld, Lp);
    
end

% joint velocity along trajectory
for n = 1:size(trajectory_coord,2)
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





