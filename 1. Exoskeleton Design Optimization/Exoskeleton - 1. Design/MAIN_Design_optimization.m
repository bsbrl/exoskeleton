% Delta robot design
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% With delta robot kinematics functions from Yuliya Smirnova
% Delta robot dynamics method from Zhang et al 2012 doi:10.1017/S0263574711000622
% 6 DoF dynamics calculated using Recursive Newton Euler algorithm

clear all 

% This script will: 
% 1. Sweeps through a range of values for the 4 delta robot dimensions: Lp,
%    Ld, Rm, Rf
% 2. Checks whether the desired behavioral arena size will fit within the 
%    calculated workspace. Only a subset of the workspace is calculated for
%    efficiency -- for full workspace check see MAIN_workspace_analysis.m
% 3. All sets of dimensions that do encompass the arena are moved to the 
%    'solution space'.
% 4. Generates a spiral trajectory through the arena bounds within the
%    workspace. Spiral covers the workspace to account for nonlinearity. 
% 5. Applies the maximum velocity and acceleration in each cartesian axis 
%    at each point along the trajectory and then calculates the associated
%    joint torques using a dynamic model. 
% 6. The isomap of the torque and velocity can be used for motor selection.
%    NB: it is good practice to double or triple the expected maximum
%    torque to ensure high bandwidth (system response) when the software
%    etc are added to the system
% 7. By selecting the input conditions to the dynamic model, the components
%    can be analysed separately (gravity, inertia, coriolis). This output
%    can be useful for optimising components of the exoskeleton


%% Specify experiment design parameters:
Arena_XY = 0.500;       % (m) X and Y arena size (animal navigation range)
Arena_Z = 0.2;          % (m) Z arena size (animal navigation range)
Animal_XY_dot = 0.2;    % (m/s) XY animal velocity
Animal_XY_dotdot = 1;   % (m/s^2) XY animal acceleration
PitchRoll_range = 40*pi/180; % (rad) +/- pitch and roll range [Meyer et al 2018 & 2020] 
PitchRoll_dot = 180*pi/180;  % (rad/s) [Meyer et al 2018 & 2020]
PitchRoll_dotdot = 540*pi/180; % (rad/s^2) estimated
L_payload = 0.2;        % (m) offset from platform to animal head

% Specify minimum and maximum motor angle (proximal arm angle)
Theta_range = [-45, 90]; % (deg)  [min, max]
Theta_step = 1;  % (deg) step size in parameter sweep

% Calculate minimum workspace
W_D = Arena_XY*sqrt(2) + 2*L_payload*sin(PitchRoll_range);
W_H = Arena_Z + L_payload*cos(PitchRoll_range); 

%% Generate a set of parameter values that meet the workspace spec

Rf_q = round([0.11:0.1:0.41],4);    % (m) radius of fixed platform
Lp_x = round([0.2:0.02:0.6],4);    % (m) Lp length of proximal linkage
Ld_y = round([0.4:0.02:1.5],4);       % (m) Ld length of distal linkage

clear('Astore','Bstore','Cstore')
nn = 1;
for m = 1:size(Rf_q,2)
    Rfd = Rf_q(1,m);             % (m) radius of fixed platform 
    Rmd = 0.01;                  % (m) radius of moving platform  
    for mm = 1:size(Lp_x,2)
        Lpd = Lp_x(1,mm);        % (m) length of proximal linkage
        for mmm = 1:size(Ld_y,2)
            Ldd = Ld_y(1,mmm);   % (m) length of distal linkage
        n = 1; 
        A = zeros((Theta_range(2)-Theta_range(1)/Theta_step), 3);
            for th1 = Theta_range(1) : Theta_step : Theta_range(2)
                th2 = Theta_range(2);
                th3 = Theta_range(2);
                [X, Y, Z, fl] = FKinemDelta(th1, th2, th3,Rfd,Rmd,Lpd,Ldd);
                if fl == 0 
                   A(n, 1) = X;
                   A(n, 2) = Y;
                   A(n, 3) = Z;
                end
            n = n+1;    
            end
            % determine whether to save the data points based on the size
            % of the workspace
            % first, locate the Z position of the workspace's lower plane
            A(:,4) = A(:,3)>(A(1,3)-W_H);
            Ylim = A(max(find(A(:,4)==1)),2);
            % then if the Yposition is larger than the workspace, save data
            
            if abs(Ylim) > W_D/2
                Astore(:,:,nn) = A;
                % [Rf ... Ld, W_Y, W_Zupper, W_Zlower]  
                Bstore(:,nn) = [Rfd; Rmd; Lpd; Ldd; Ylim; A(1,3);A(max(find(A(:,4)==1)),3)];
                nn = nn+1;
            end          
        end
    end
end


%% Generate a set of coordinates within the workspace for evaluation

clear('r_eval')
% variable r is a 3D array of coordinates, with the number of coordinates
% for evaluation in the first dimension; the xyz points in the second
% dimension; and, the design iteration of viable parameter set in the third
% dimension

% generate num points around the workspace
numz = 5;   % number of heights in workspace
numa = 21;  % # points in each Z plane
[r_eval] = Generate_r(numz,numa,Bstore,W_D,W_H);

% figure
for n = 1:size(r_eval,3)
    temp = r_eval(:,:,n);
%     plot3(temp(:,1),temp(:,2),temp(:,3),'.-')
%     grid on
    %  hold on
%     pause(0.1)
end


%% Platform XYZ velocity and acceleration to produce pitch and roll specs
% can evaluate the platform velocity and acceleration from the pitch and
% roll specs as vectors purely in each of the three dimensions.
% with linear velocity specs from animal navigation added
r_dot_eval = diag(repmat(L_payload*PitchRoll_dot+Animal_XY_dot,1,3));
r_dotdot_eval = diag(repmat(L_payload*PitchRoll_dotdot+Animal_XY_dotdot,1,3));

%% ... proceed to design optimization

%% Design Optimization 
global Rf Rm Lp Ld

% this script takes an array of parameter values {L_p,L_d,R_f} that meet 
% the workspace spec, an array of XYZ coordinates within the workspace, and 
% arrays of maximum velocity and acceleration, and then generates parameters 
% to optimize during the design process
g = 9.8;     % (m/s^2) accel. from gravity
z_hat = [0 0 -1]';

clear('Results')
Results = zeros(size(Bstore,2),size(r_eval,1),6);

for n = 1:size(Bstore,2)
    % [Rf, Rm, Lp, Ld, W_Y, W_Zupper, W_Zlower]  
    Rf = Bstore(1,n);
    Rm = Bstore(2,n);
    Lp = Bstore(3,n);
    Ld = Bstore(4,n);
    
    % system properties
    mu_1 =1.2; % (kg/m) of proximal linkage
    mu_2 = 1.0; % (kg/m) of distal linkage
    m_A = mu_1*Lp; % (kg) mass of proximal linkage
    r_A = Lp/2;  % assume centre of gravity is halfway along the linkage
    m_B = 0.25;  % (kg) lump mass at B
    m_C = 3;     % (kg) mass of moving platform

    % the inertia of the components in each kinematic chain:
    I_A1 = 0.05;         % (kg.m^2) gearbox
    I_A2 = mu_1*Lp^3/3;    % (kg.m^2) intermediate section
    I_A3 = m_B*Lp^2;       % (kg.m^2) lump mass at B
    I_A4 = 4*mu_2*Ld*Lp^2/3; % (kg.m^2) equivalent mass of distal links
    I_A = I_A1 + I_A2 + I_A3 + I_A4;   

    % vector e_i connects the origin O to the revolute joint in motor_i
    Beta_1 = 0*pi/180;  % (rad) angular offset of vector e_1 in XY plane 
    Beta_2 = 120*pi/180; % (rad) angular offset of vector e_2 in XY plane 
    Beta_3 = 240*pi/180; % (rad) angular offset of vector e_3 in XY plane 
    % We can subtract Rm from Rf because and consider the platform as a point
    % for now, because it is constrained in the rotational axes. 
    e_1 = (Rf-Rm)*[cos(Beta_1), sin(Beta_1), 0]';
    e_2 = (Rf-Rm)*[cos(Beta_2), sin(Beta_2), 0]';
    e_3 = (Rf-Rm)*[cos(Beta_3), sin(Beta_3), 0]';
    
    for nn = 1:size(r_eval,1)
        r = reshape(r_eval(nn,:,n),3,1);
        [Theta_1,~,~,~] = motorangles(r,e_1,Beta_1);
        [Theta_2,~,~,~] = motorangles(r,e_2,Beta_2);
        [Theta_3,~,~,~] = motorangles(r,e_3,Beta_3);

        % position error from 0.1 degree error in motor angle
        MEerr = 0.1; % (degree)
        [rerr(1,1), rerr(2,1), rerr(3,1), ~] = FKinemDelta(Theta_1*180/pi+MEerr,...
            Theta_2*180/pi+MEerr, Theta_3*180/pi+MEerr,Rf,Rm,Lp,Ld);
        poserr = (r - rerr).*1000;  % (mm)
        
        % the unit vectors u_i for the proximal linkages are given by: 
        u_1 = [cos(Beta_1)*cos(Theta_1), sin(Beta_1)*cos(Theta_1), -sin(Theta_1)]';
        u_2 = [cos(Beta_2)*cos(Theta_2), sin(Beta_2)*cos(Theta_2), -sin(Theta_2)]';
        u_3 = [cos(Beta_3)*cos(Theta_3), sin(Beta_3)*cos(Theta_3), -sin(Theta_3)]';

        % and on the distal linkages w_i are given by:
        w_1 = 1/Ld*(r-e_1-Lp*u_1);
        w_2 = 1/Ld*(r-e_2-Lp*u_2);
        w_3 = 1/Ld*(r-e_3-Lp*u_3);

        v_1 = [-sin(Beta_1), cos(Beta_1), 0]';
        v_2 = [-sin(Beta_2), cos(Beta_2), 0]';
        v_3 = [-sin(Beta_3), cos(Beta_3), 0]';
        
        r_dot = r_dot_eval(:,1);
        
        Jx = [w_1, w_2, w_3]';
        Jq = diag([Lp*w_1'*cross(v_1,u_1), Lp*w_2'*cross(v_2,u_2), Lp*w_3'*cross(v_3,u_3)]);
        J = inv(Jq)*Jx;

        Theta_dot = J*r_dot;
        
        [H_1] = Hessian(v_1,u_1,w_1);
        [H_2] = Hessian(v_2,u_2,w_2);
        [H_3] = Hessian(v_3,u_3,w_3);

        f_1_r_dot = r_dot'*H_1*r_dot;
        f_2_r_dot = r_dot'*H_2*r_dot;
        f_3_r_dot = r_dot'*H_3*r_dot;

        f_r_dot = [f_1_r_dot, f_2_r_dot, f_3_r_dot]';

        % so that, for a platform acceleration of r_dotdot:
        r_dotdot = r_dotdot_eval(:,1);

        Theta_dotdot = J*r_dotdot + f_r_dot;

        Eta = m_C/I_A;
        G = Eta*inv(J')+J;
        Tau_a = I_A*G*r_dotdot;     % Inertial torque
        Tau_v = I_A*f_r_dot;        % centrifuge/Coriolis torque
        Tau_Ag = m_A*r_A*g*[cos(Theta_1) cos(Theta_2) cos(Theta_3)]';
        Tau_g = m_C*g*inv(J')*z_hat + Tau_Ag;  % gravitational torque

        % the motor torque in each arm
        Tau = Tau_a + Tau_v + Tau_g; % (N.m)
        
        Phi_1 = acos(w_1'*cross(v_1,u_1));
        Phi_2 = acos(w_2'*cross(v_2,u_2));
        Phi_3 = acos(w_3'*cross(v_3,u_3));

        % Pressure angle amongst limbs (at moving platform)
        Gamma_1 = acos(w_1'*cross(w_3,w_2)/norm(cross(w_3,w_2)));
        Gamma_2 = acos(w_2'*cross(w_1,w_3)/norm(cross(w_1,w_3)));
        Gamma_3 = acos(w_3'*cross(w_2,w_1)/norm(cross(w_2,w_1)));

        % the transmission angle within a limb:
        Phi_1_dash = pi/2 - Phi_1; 
        Phi_2_dash = pi/2 - Phi_2;
        Phi_3_dash = pi/2 - Phi_3;

        % and, the transmission angles amongst limbs
        Gamma_1_dash = pi/2 - Gamma_1; 
        Gamma_2_dash = pi/2 - Gamma_2;
        Gamma_3_dash = pi/2 - Gamma_3;
        
        [G_1,maxTau_a_1] = MaxTau_a(Eta,Phi_1,Gamma_1,cross(w_3,w_2),w_1,I_A);
        [G_2,maxTau_a_2] = MaxTau_a(Eta,Phi_2,Gamma_2,cross(w_1,w_3),w_2,I_A);
        [G_3,maxTau_a_3] = MaxTau_a(Eta,Phi_3,Gamma_3,cross(w_2,w_1),w_3,I_A);
        
        [~,S,~] = svd(J);      
        Results(n,nn,:) = [max(abs(Tau));... 
            max(max(S)); min(min(S(S>0))); ...
            max([Gamma_1, Gamma_2, Gamma_3]); max([Phi_1, Phi_2, Phi_2]);...
            max(abs(Theta_dot))];
        
        Results2(n,nn) = max(abs(poserr));
        
    end
end

%%
Results(n,nn,:) = [max([maxTau_a_1, maxTau_a_2, maxTau_a_3]); ...
            max(max(S)); min(min(S(S>0))); ...
            max([Gamma_1, Gamma_2, Gamma_3]); max([Phi_1, Phi_2, Phi_2]);...
            max(abs(Theta_dot))];

%% The optimal design should:
% 1. minimize the global max torque (Results(:,:,1))
% 2. minimize the max sing val of J (Results(:,:,2))
% 3. maximize the min sing val of J (Results(:,:,3))
% 4. minimize the max motor velocity (Results(:,:,6))


%% Parse results based on fixed platform radii to compare linkage lengths only

% parameter sweep vals

figure
for nn = 1:size(Rf_q,2) 
  
    subplot(2,2,nn)

    logi = round(Bstore(1,:),3)==round(Rf_q(nn),3);

    Rf_dat = Bstore.*(logi); 
%     Rf_dat(Rf_dat==0) = [];
    Rf_dat = reshape(Rf_dat,size(Bstore,1),[]);

    Rf_res = Results.*(logi)'; 
%     Rf_res(Rf_res==0) = [];
    Rf_res = reshape(Rf_res,[], size(Results,2),size(Results,3));

    % Torque
    temp_maxTau = max(Rf_res(:,:,1)')';

    Z = nan(size(Ld_y,2),size(Lp_x,2));

    for n = 1:size(Rf_dat,2)
        [~,Ix] = find(Lp_x==round(Rf_dat(3,n),4));
        [~,Iy] = find(Ld_y==round(Rf_dat(4,n),4));
        Z(Iy,Ix) = temp_maxTau(n,1);
    end

    [X,Y] = meshgrid(Lp_x,Ld_y);

    contour(X,Y,Z,[0:1:40])
    colorbar
    caxis([1 40])
    view([0,0,1])
    xlabel('Lp length of proximal linkage (m)')
    ylabel('Ld length of distal linkage (m)')
        tit = join(["Torque (Nm)'-' isos (Rf = ",num2str(Rf_q(nn))," m)"]);
    title(tit)

end

%%
figure
for nn = 1:size(Rf_q,2) 
  
    subplot(2,2,nn)
    hold on

    logi = round(Bstore(1,:),3)==round(Rf_q(nn),3);

    Rf_dat = Bstore.*(logi); 
%     Rf_dat(Rf_dat==0) = [];
    Rf_dat = reshape(Rf_dat,size(Bstore,1),[]);

    Rf_res = Results.*(logi)'; 
%     Rf_res(Rf_res==0) = [];
    Rf_res = reshape(Rf_res,[], size(Results,2),size(Results,3));

    % velocity
    temp_maxthetadot =  max(Rf_res(:,:,6)')'; 

    Z = nan(size(Ld_y,2),size(Lp_x,2));

    for n = 1:size(Rf_dat,2)
        [~,Ix] = find(Lp_x==round(Rf_dat(3,n),4));
        [~,Iy] = find(Ld_y==round(Rf_dat(4,n),4));
        Z(Iy,Ix) = temp_maxthetadot(n,1);
    end

    [X,Y] = meshgrid(Lp_x,Ld_y);
    contour(X,Y,Z,[0:0.1:10],'--')
    colorbar
    caxis([1 10])
    view([0,0,1])
    xlabel('Lp length of proximal linkage (m)')
    ylabel('Ld length of distal linkage (m)')
        tit = join(["Velocity (rad/s) '--' isos (Rf = ",num2str(Rf_q(nn))," m)"]);
    title(tit)
end

%%








