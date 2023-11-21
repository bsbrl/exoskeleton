% 6 DoF Dynamics 
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Using equations from Zhang et al 2012 doi:10.1017/S0263574711000622
% With delta robot kinematics functions from Yuliya Smirnova

% Dynamics - characterize all forces on the 6Dof robot in joint space and
% on the end effector in op-space.
% Can measure the joint position, and calculate the joint velocity, and 
% acceleration, so start with these values.

% can load 'Mesoscope_trajectory.mat' for some joint data (joint pos vs time) and the
% associated system and trajectory variables used to generate them;
clear all
load("Mesoscope_trajectory.mat")

% or generate some new values using either the
% MAIN_generate_trapezoidal_profile.m or MAIN_generate_freely_behaving_profile.m
% script in the folder "...\Exoskeleton - 3. Jacobian and trajectory"


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



%% inertias 
%inertias can be calculated in CAD softwrae if you have designed an
% exoskeleton at this point 
[ID,I4,I5,I6] = getInertias();


%%
Tau = zeros(6,size(trajectory_joint,2));

for n = 2:size(trajectory_joint,2)-1

    theta = trajectory_joint(:,n);          % (rad)
    theta_dot = trajectory_jointvel(:,n);   % (rad/s)
    theta_dotdot = (trajectory_jointvel(:,n+1)-trajectory_jointvel(:,n-1))./(2*tincr); % (rad/s^2)
  
    
    % calculate Jacobian
        J = zeros(6,6);
        % calc position of delta moving platform
        [Dmnq(1),Dmnq(2),Dmnq(3), ~] = FKinemDelta(theta(1,1),...
        theta(2,1),theta(3,1),Rf,Rm,Lp,Ld);
        % delta inverse Jacobian
        [e_1,e_2,e_3,u_1,u_2,u_3,w_1,w_2,w_3,v_1,v_2,v_3] = Zhangvectors(Rf,Rm,Ld,Lp,theta(1:3,1),Dmnq',Kappa);
        [Jq,Jx] = DeltaJacobian2(u_1,u_2,u_3,w_1,w_2,w_3,v_1,v_2,v_3,Lp);
        Jinv(1:3,1:3) = inv(Jq)*Jx;

        % Goniometer inverse kinematics
        [H_d4,H_45,H_56,H_6m] = gonio_transformation_matrices_v2(kappa_4,theta(4),...
        theta(5),theta(6),a_1,a_2,a_3,a_4);
        H_dm = H_d4*H_45*H_56*H_6m;
        d_dm = H_dm(1:3,4);
        P_6D(1:3,1) = Dmnq' + d_dm;
        P_6D(4,1) = -theta(4,1);     % rotX Euler angle
        P_6D(5,1) = -theta(5,1);     % rotY Euler angle
        P_6D(6,1) = -theta(6,1);     % rotZ Euler angle

        % Jacobian elements
        J(1:3,1:3) = inv(Jinv(1:3,1:3));
        [J] = sixDoFJacobian(J,a_4,theta);
        Jinv = inv(J); % inverse Jacobian

    % position stability
        % add 0.1 degree to the Delta joint space and calc deviation in
        % Delta platform position
    % calc position of delta moving platform
        Deltamotorerr = 0.1*pi/180; % rad
        thetaerr = theta+Deltamotorerr;
        [Dmnqerr(1),Dmnqerr(2),Dmnqerr(3), ~] = FKinemDelta(thetaerr(1,1),...
        thetaerr(2,1),thetaerr(3,1),Rf,Rm,Lp,Ld); 
        Dmnqerrabs(1:3,n) = Dmnq-Dmnqerr;
        
 
    % calculate delta platform position, velocity, acceleration:
    % position
        Dmnq;
        tempDmnq(:,n) = Dmnq';
    % velocity
        Dmnq_dot = J(1:3,1:3)*theta_dot(1:3,1);  
    % acceleration 
        [f_r_dot] = f_r_dotcalc(u_1,u_2,u_3,w_1,w_2,w_3,v_1,v_2,v_3,Lp,Ld,Dmnq_dot);
        Dmnq_dotdot2 = J(1:3,1:3)*(theta_dotdot(1:3,1)-f_r_dot);

    % Calculate Plucker coordinate transforms in goniometer
    R_D_JD = [0,0,-1;1,0,0;0,-1,0]';
        X_d_JD = Rd_to_PluckerFrameTransform(R_D_JD,[0,0,-a_1]');
        X_JD_4 = Rd_to_PluckerFrameTransform(Rotzfun(theta(4,1)),[0,0,0]');
    X_d_4 = X_JD_4*X_d_JD;

    R_4_J4 = [0,0,-1;1,0,0;0,-1,0]';
        X_4_J4 = Rd_to_PluckerFrameTransform(R_4_J4,[0,0,0]');
        X_J4_5 = Rd_to_PluckerFrameTransform(Rotzfun(theta(5,1)),[0,0,0]');
    X_4_5 = X_J4_5*X_4_J4;

    R_5_J5 = [0,0,1;1,0,0;0,1,0]';
        X_5_J5 = Rd_to_PluckerFrameTransform(R_5_J5,[0,0,0]');
        X_J5_6 = Rd_to_PluckerFrameTransform(Rotzfun(theta(6,1)),[0,0,0]');
    X_5_6 = X_J5_6*X_5_J5;

    R_6_e = [1,0,0;0,-1,0;0,0,-1]';
        X_6_e = Rd_to_PluckerFrameTransform(R_6_e,[0,0,a_4]');   
    X_6_e;

    % motion subspace for each Joint type in goniometer (all are revolute) 
    SD = [0,0,1,0,0,0]';
    S4 = SD; 
    S5 = SD;
    % NB: remember Plucker coordinates of a body's velocity are the cartesian 
    % coordinates of [[angular velocity], [spatial velocity]]', so subspace
    % of revolute (rotZ) is the third vector element. 


    % calculate velocities and accelerations for each link starting at delta 
    % moving platform and finishing at end-effector
    a_grav = -9.8;  % m/s^2     gravity

    % Link D is the base frame, where v and a are known:
    v_D_Pluck = [0,0,0,Dmnq_dot']'; % delta moving platform velocity in Plucker coords
    a_D_Pluck = [0,0,0,Dmnq_dotdot2']'+[0,0,0,0,0,-a_grav]'; % delta moving platform acceleration in Plucker coords

    % calculate body velocity and acceleration from link 1 through to link 3
    v_JD = SD*theta_dot(4); % gonio axis 1 
    v_4_Pluck = X_d_4*v_D_Pluck + v_JD;
    a_4_Pluck = X_d_4*a_D_Pluck + SD*theta_dotdot(4) + 0 + Pluckercrossprod(v_4_Pluck,v_JD);

    v_J4 = S4*theta_dot(5); % gonio axis 2
    v_5_Pluck = X_4_5*v_4_Pluck + v_J4;
    a_5_Pluck = X_4_5*a_4_Pluck + S4*theta_dotdot(5) + 0 + Pluckercrossprod(v_5_Pluck,v_J4);

    v_J5 = S5*theta_dot(6);  % gonio axis 3 
    v_6_Pluck = X_5_6*v_5_Pluck + v_J5;
    a_6_Pluck = X_5_6*a_5_Pluck + S5*theta_dotdot(6) + 0 + Pluckercrossprod(v_6_Pluck,v_J5);

    % to end efffector (pivot point)
    v_e_Pluck = X_6_e*v_6_Pluck;
    a_e_Pluck = X_6_e*a_6_Pluck;
    
    
    % calculate the forces from link3 through to link D
    F_external = zeros(6,1);    % assume no external forces

    fB_3 = I6*a_6_Pluck + Pluckercrossprod(v_6_Pluck,I6*v_6_Pluck);
    f_3 = fB_3 + F_external; 
    tau_J3 = S5'*f_3;

    fB_2 = I5*a_5_Pluck + Pluckercrossprod(v_5_Pluck,I5*v_5_Pluck);
    f_2 = fB_2 + inv(X_5_6)*f_3; 
    tau_J2 = S4'*f_2;

    fB_1 = I4*a_4_Pluck + Pluckercrossprod(v_4_Pluck,I4*v_4_Pluck);
    f_1 = fB_1 + inv(X_4_5)*f_2; 
    tau_J1 = SD'*f_1;

    fB_D = ID*a_D_Pluck + Pluckercrossprod(v_D_Pluck,ID*v_D_Pluck);
    f_D(:,n) = fB_D + inv(X_d_4)*f_1; 
    % no tau for link D
    % negate f_D
    f_D = -f_D;
    
    % Joint forces (Nm)
    Tau(:,n) = [0,0,0,tau_J1,tau_J2,tau_J3]';

    % Delta robot joint forces
    % NB: code inside Deltajointforce is taken direct from Zhang et al, who
    % have the forward and inverse Jacobian notation reversed in their derivation (see paper)
    [Tau(1:3,n)] = Deltajointforce_v3(Lp,Ld,Dmnq_dotdot2,f_r_dot,f_D(4:6,n),J(1:3,1:3),theta);
    [tempTau_a(1:3,n),tempTau_v(1:3,n),tempTau_g(1:3,n),tempTau_Ag(1:3,n),tempTau_d(1:3,n)] = Deltajointforce_v4(Lp,Ld,Dmnq_dotdot2,f_r_dot,f_D(4:6,n),J(1:3,1:3),theta);

    v_endeffect(:,n) = v_e_Pluck;
    a_endeffect(:,n) = a_e_Pluck;
    

end



%%

% timearray = 0:tincr:(size(Tau,2)-1)*tincr;
figure
plot(timearray(1,3:end-4),Tau(1:3,3:end-4)','Color',[0 0.4470 0.7410])
title('motor torques')
legend('Dmotor1','Dmotor2','Dmotor3')
xlabel('time (s)')
ylabel('Delta motor torque (Nm)')

figure
plot(timearray(1,3:end-4),Tau(4:6,3:end-4)','Color',[0.4660 0.6740 0.1880])
title('motor torques')
ylabel('Goniometer motor torque (Nm)')
legend('Gmotor1','Gmotor2','Gmotor3')
xlabel('time (s)')


%%
figure
plot(timearray(3:size(tempTau_g,2)-4),tempTau_g(:,3:end-4))
ylabel('Delta motor torque (Nm)')
title('g gravity motor torques')


% figure
% plot(timearray(1:size(tempTau_g,2)),tempTau_Ag)
% ylabel('Delta motor torque (Nm)')
% title('Ag gravity motor torques from delta arms')
%%
figure
plot(timearray(3:size(tempTau_g,2)-4),tempTau_v(:,3:end-4),'--')
ylabel('Delta motor torque (Nm)')
title('velocity motor torques')

figure
plot(timearray(3:size(tempTau_g,2)-4),tempTau_a(:,3:end-4),'-.')
ylabel('Delta motor torque (Nm)')
title('inertial motor torques')

figure
plot(timearray(3:size(tempTau_g,2)-4),tempTau_d(:,3:end-4))
ylabel('Delta motor torque (Nm)')
title('goniometer coupling motor torques')

% figure
% title('motor torques')
% plot(timearray(1:size(tempTau_g,2)),tempTau_g+tempTau_v+tempTau_a+tempTau_d)
% ylabel('Delta motor torque (Nm)')










    