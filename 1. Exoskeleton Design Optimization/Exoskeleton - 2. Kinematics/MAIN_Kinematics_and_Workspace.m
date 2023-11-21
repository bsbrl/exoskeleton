% 6 DoF Kinematics
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% With delta robot kinematics functions from Yuliya Smirnova


% Forward and Inverse Kinematics for one point in space:
% 1. use inverse kinematics to generate position and orientation of the end
%    effector using the 6 x motor angles
% 2. use forward kinematics to generate position and orientation of the end 
%    effector using motor angles for the  3 x Delta robot motors, and the 
%    3 x goniometer motors. 
% 3. compare inverse and forward kinematics results and visualise the output

%%

% Dimensions
Rf = 0.2;      % (m) fixed platform radius
Rm = 0.1;      % (m) moving platform radius
Lp = 0.4125;      % (m) proximal linkage length
Ld = 0.75;      % (m) distal linage length
a_1 = 0.0575;     % (m) linkage 1 length (centre moving platform to frame 1 on goniometer)
a_2 = 0; % NB: hardcoded in       % (m) linkage 2 length (frame 1 to frame 2 on goniometer)
a_3 = 0; % NB: hardcoded in       % (m) linkage 3 length (frame 2 to frame 3 on goniometer)
a_4 = 0.2;     % (m) linkage 4 length (frame 3 to end effector tip on goniometer)     
Rg = 0.05;      % (m) goniometer radius for visualisation purposes)

% anglular offsets of delta motors from reference frame x-axis
kappa_1 = 6*pi/4;    % (rad)
kappa_2 = pi/6;     % (rad)
kappa_3 = 5*pi/6;   % (rad)

% anglular offset of gonioemeter motor1 frame from moving platform frame
kappa_4 = 0;

%% inverse kinematics
% figure
% for position {x,y,z} and X-Y-Z-Euler angles {alpha,beta,gamma}:
% r = [x,y,z,RotX,RotY,RotZ], where rotX = alpha, rotY = beta, rotZ = gamma; 
r_inv = [0.2,0.2,-0.7,0,0,0]';

    % generate the X-Y-Z rotation matrix for Euler angles using alpha, beta, gamma:
    %     R_0m_Euler = XYZrotationmatrix_euler(r_inv(4),r_inv(5),r_inv(6));

    %check R
    % testR = Rotxfun(r_inv(4))*Rotyfun(r_inv(5))*Rotzfun(r_inv(6)); 

    % find the goniometer motor angles using inverse kinematics relationships
    %     theta_5 = asin(-R_0m_Euler(1,3));
    %     theta_4 = atan2(R_0m_Euler(2,3),R_0m_Euler(3,3))+pi/2;
    %     theta_6 = atan2(R_0m_Euler(1,2),R_0m_Euler(1,1));
    
    % faster way to generate theta_4,5,6
    theta_4 = -r_inv(4);
    theta_5 = -r_inv(5);
    theta_6 = -r_inv(6);

% generate the transformation matrix H_d4 and find the position of the end 
% effector relative to the moving platform (D{m,n,q})
[H_d4,H_45,H_56,H_6m] = gonio_transformation_matrices(kappa_4,theta_4,...
    theta_5,theta_6,a_1,a_2,a_3,a_4);

%% The coordinates of the moving platform

H_dm = H_d4*H_45*H_56*H_6m;
d_dm = H_dm(1:3,4);

% platform position D{m,n,q} in the reference frame O{x,y,z}
Dmnq_inv = r_inv(1:3,1) - d_dm;

% inverse kinematics to find motor angles
% [theta_d1, theta_d2, theta_d3, fl] = IKinemDelta(Dmnq_inv(1),Dmnq_inv(2),Dmnq_inv(3),Rf,Rm,Lp,Ld);
[theta_1, theta_2, theta_3, fl] = IKinemDelta2(Dmnq_inv(1),Dmnq_inv(2),Dmnq_inv(3),Rm, Rf, Ld, Lp);

if fl == -1
    report = 'WARNING - POSITION OUT OF DELTA RANGE'
elseif fl == 0
    report = 'WITHIN DELTA RANGE'
end

theta_inv = [theta_1,theta_2,theta_3,theta_4,theta_5,theta_6]';
theta_inv_deg = [theta_1,theta_2,theta_3,theta_4,theta_5,theta_6]'.*180/pi;

%% forward kinematics 

theta_forw = theta_inv;
% theta_forw  = [-0.3,-0.3,-0.3,0,0,0]'
Dmnq_forw = zeros.*Dmnq_inv;

r_forw = zeros(6,1);

[Dmnq_forw(1),Dmnq_forw(2),Dmnq_forw(3), fl] = FKinemDelta(theta_forw(1),...
    theta_forw(2),theta_forw(3),Rf,Rm,Lp,Ld);

[H_d4,H_45,H_56,H_6m] = gonio_transformation_matrices(kappa_4,theta_forw(4),...
    theta_forw(5),theta_forw(6),a_1,a_2,a_3,a_4);

H_dm = H_d4*H_45*H_56*H_6m;
d_dm = H_dm(1:3,4);

r_forw(1:3,1) = Dmnq_forw + d_dm;

% r_forw(4,1) = atan2(R_0m_Euler(2,3),R_0m_Euler(3,3))+pi/2;
% r_forw(5,1) = asin(-R_0m_Euler(1,3));
% r_forw(6,1) = atan2(R_0m_Euler(1,2),R_0m_Euler(1,1));


   r_forw(4,1) = -theta_4; 
   r_forw(5,1) = -theta_5; 
   r_forw(6,1) = -theta_6;


%% visualise
% delta robot in blue
% goniometer in green
% pivot point in orange 

figure

skeleton_plot(Rf,Rm,Lp,r_inv,Dmnq_inv,theta_inv(1:3,:),H_d4,H_45,H_56,H_6m,kappa_1,kappa_2,kappa_3,Rg)

xlabel('x (m')
ylabel('y (m')
zlabel('z (m')


%% Workspace
figure
n = 1; 
h = 5;
A = zeros((140/h)^3, 3);
for th1 = -45 : h : 90
    for th2 = -45 : h : 90
        for th3 = -45 : h : 90
            the1 = deg2rad(th1);
            the2 = deg2rad(th2);
            the3 = deg2rad(th3);
            
            [X, Y, Z, fl] = FKinemDelta(the1, the2, the3,Rf,Rm,Lp,Ld);
            if fl == 0 
               A(n, 1) = X;
               A(n, 2) = Y;
               A(n, 3) = Z;
               n = n+1;
            end
         end
    end
end


hs = plot3(A(:,1),A(:,2),A(:,3),'Color',[0 0.4470 0.7410]);
grid off
% axis off

hs.Color(4) = 0.2;

title('Delta robot workspace')
xlim([-0.7 0.7])
ylim([-0.7 0.7])
zlim([-1.2 -0.1])
view([-0.1 -0.8 0.1])
xlabel('x (m')
ylabel('y (m')
zlabel('z (m')











