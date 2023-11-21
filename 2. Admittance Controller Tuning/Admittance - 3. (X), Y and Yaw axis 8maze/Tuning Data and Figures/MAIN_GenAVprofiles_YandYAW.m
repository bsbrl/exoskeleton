% GENERATE AV_data.mat
% Compute stats on Y and Yaw axis V-A-F profile from data on mice in the 
% development 8maze arena; only taking data from the turning zone 
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all

% in AV_data.mat:
% freely behaving data: 
%   fb1 through fb6 (see folder: Admittance - 1. Freely behaving)
% X axis tuning Mousetrack data:
%   highz*, midz*, tunedz*, lowz*, trainedz* (see folder: Admittance - 2. X axis mousetrack)
% Y and Yaw axis on development 8maze arena (this script):
%   see below:

% AV_data.**.vx = x vel;
% AV_data.**.ax = x accel;
% AV_data.**.fx = x force;
% AV_data.**.kx = indices of the bounds of the va profile (i.e. vx(kx), ax(kx));
% AV_data.**.Qx = area of bounds of the va profile (i.e. trapz(vx(kx), ax(kx));

% AV_data.**.vy = y vel;
% AV_data.**.ay = y accel;
% AV_data.**.fy = y force;
% AV_data.**.ky = indices of the bounds of the va profile (i.e. vy(ky), ay(ky));
% AV_data.**.Qy = area of bounds of the va profile (i.e. trapz(vy(ky), ax(ky));

% AV_data.**.vyaw = yaw vel;
% AV_data.**.ayaw = yaw accel;
% AV_data.**.fyaw = yaw force;
% AV_data.**.kyaw = indices of the bounds of the va profile (i.e. vyaw(kyaw), ayaw(kyaw));
% AV_data.**.Qx = area of bounds of the va profile (i.e. trapz(vyaw(kyaw), ayaw(kyaw));

% for **: see 'label' column below:

% Date      Mouse	Laps        my      cy      myaw        cyaw    label
% 22-Mar    276     1 to 7      0.1     1       0.0001      0.004   
%                   8 to 9      0.1     2       0.00005     0.003   YYhighz1
%                   10 to 16	0.1     2       0.00005     0.002   YYhighz1
%           489     1 to 7      0.1     2       0.00005     0.002   YYhighz2
%                   8 to 12 	0.1     2       0.00005     0.003   YYhighz2
% 23-Mar	276     1 to 4      0.1     1       0.00005     0.004
%                   5 to 6      0.1     1       0.00005     0.002
%                   7 to 9      0.1     1       0.00005     0.003
%                   10          0.05	0.5     0.00005     0.003   
%           489     1 to 5      0.05	0.5     0.00005     0.003   
%                   6 to 12     0.05	0.5     0.00005     0.002   
% 24-Mar	276     1 to 8      0.04	0.2     0.00005     0.0002  YYmidz1
%           489     1 to 12 	0.04	0.2     0.00005     0.0002  YYmidz2
% 29-Mar	276     1 to 3      0.02	0.1     0.00005     0.00001
%                   4 to end    0.02	0.1     0.00005     0.0002  
%           489     1 to 9      0.02	0.1     0.00005     0.0002  
% 30-Mar	276     1 to 11     0.01	0.1     0.00002     0.0002
%           489     1 to 8      0.01	0.1     0.00002     0.0002
% 31-Mar	276     1 to 7      0.01	0.1     0.00002     0.0002
%                   1 to 8      0.01	0.1     0.00002     0.0002
% 1-Apr     276     1 to 2      0.01	0.1     0.00002     0.0002  YYlowz1
%                   3 to 6      0.01	0.1     0.00001     0.0001  YYlowz1
%                   7 to 8      0.005	0.05	0.00001     0.0001  
%           489     1 to 6      0.01	0.1     0.00001     0.0001	YYlowz2	
% 5-Apr     276     1 to 8      0.01	0.1     0.00002     0.0002
% 11-Apr	746     1 to 16     0.01	0.1     0.00002     0.0002 

load('AV_data.mat')

b_fac = 0.3;

%% Raw data format
% Raw data files (Mxxx_8maze_xx_xx_xx.mat) are formatted as follows: 
% columns 1 through 23 are: 
%     theta1  joint 1 angle (rad)
%     theta2  joint 2 angle (rad)
%     theta3  joint 3 angle (rad)
%     theta6  joint 6 angle (rad)
%     x       global x positoin (m)
%     y       global y positoin (m)
%     z       global z positoin (m)
%     gamma   global yaw positoin (m)
%     xdel    admittance X velocity output (m/s)
%     ydel    admittance Y velocity output (m/s)
%     zdel    admittance Z velocity output (m/s)
%     gammadel    admittance Yaw velocity output (m/s)
%     time    time (s)
%     PWM1    PWM signal to joint 1
%     PWM2    PWM signal to joint 2
%     PWM3    PWM signal to joint 3
%     PWM6    PWM signal to joint 4
%     Fxmouse Mouse Xce (N) 
%     Fymouse Mouse Y force (N) 
%     Fzmouse Mouse Z force (N) 
%     Frotzmouse  Mouse Yaw torque (Nm) 
%     m   virtual X mass (kg)
%     c   virtual X damping (Ns/m)

% if there are 27 columns of data, then columns 22:27 are: 
%     cx    virtual X damping (Ns/m)
%     cy    virtual Y damping (Ns/m)
%     cyaw  virtual Yaw damping 
%     mx    virtual X mass (kg)
%     my    virtual Y mass (kg)
%     myaw  virtual Yaw mass 

%% YYhighz1
load 'Mouse276_8maze_22_3_22_v2.mat'
laps = [8 16];

clip = [8262 52153];    % see script SUB_clipdata.m
data = Mouse276_8maze_22_3_22_v2(clip(1):clip(2),:);
tincr = 0.01;           % (ms)
time = [0:tincr:tincr*(size(data,1)-1)]';     %(s)

[vel_mouse,vel_mouse_yaw,accel_mouse,accel_mouse_yaw,rangecum] = Process_raw_data(data,tincr,laps);

vx = vel_mouse(rangecum,1);
ax = accel_mouse(rangecum,1);
fx = data(rangecum,18);              
kx = boundary(vx,ax,b_fac);
Qx = abs(trapz(vx(kx),ax(kx)));

vy = vel_mouse(rangecum,2);
ay = accel_mouse(rangecum,2);
fy = data(rangecum,19);              
ky = boundary(vy,ay,b_fac);
Qy = abs(trapz(vy(ky),ay(ky)));

vyaw = vel_mouse_yaw(rangecum,1);
ayaw = accel_mouse_yaw(rangecum,1);
fyaw = data(rangecum,21);            
kyaw = boundary(vyaw,ayaw,b_fac);
Qyaw = abs(trapz(vyaw(kyaw),ayaw(kyaw)));

AV_data.YYhighz1.vx = vx;
AV_data.YYhighz1.ax = ax;
AV_data.YYhighz1.fx = fx;
AV_data.YYhighz1.kx = kx;
AV_data.YYhighz1.Qx = Qx;

AV_data.YYhighz1.vy = vy;
AV_data.YYhighz1.ay = ay;
AV_data.YYhighz1.fy = fy;
AV_data.YYhighz1.ky = ky;
AV_data.YYhighz1.Qy = Qy;

AV_data.YYhighz1.vyaw = vyaw;
AV_data.YYhighz1.ayaw = ayaw;
AV_data.YYhighz1.fyaw = fyaw;
AV_data.YYhighz1.kyaw = kyaw;
AV_data.YYhighz1.Qyaw = Qyaw;

%% YYhighz2
load 'Mouse489_8maze_22_3_22_v2.mat'
laps = [1 13];

clip = [510 49608];    % see script SUB_clipdata.m
data = Mouse489_8maze_22_3_22_v2(clip(1):clip(2),:);
tincr = 0.01;           % (ms)
time = [0:tincr:tincr*(size(data,1)-1)]';     %(s)

[vel_mouse,vel_mouse_yaw,accel_mouse,accel_mouse_yaw,rangecum] = Process_raw_data(data,tincr,laps);

vx = vel_mouse(rangecum,1);
ax = accel_mouse(rangecum,1);
fx = data(rangecum,18);              
kx = boundary(vx,ax,b_fac);
Qx = abs(trapz(vx(kx),ax(kx)));

vy = vel_mouse(rangecum,2);
ay = accel_mouse(rangecum,2);
fy = data(rangecum,19);              
ky = boundary(vy,ay,b_fac);
Qy = abs(trapz(vy(ky),ay(ky)));

vyaw = vel_mouse_yaw(rangecum,1);
ayaw = accel_mouse_yaw(rangecum,1);
fyaw = data(rangecum,21);            
kyaw = boundary(vyaw,ayaw,b_fac);
Qyaw = abs(trapz(vyaw(kyaw),ayaw(kyaw)));

AV_data.YYhighz2.vx = vx;
AV_data.YYhighz2.ax = ax;
AV_data.YYhighz2.fx = fx;
AV_data.YYhighz2.kx = kx;
AV_data.YYhighz2.Qx = Qx;

AV_data.YYhighz2.vy = vy;
AV_data.YYhighz2.ay = ay;
AV_data.YYhighz2.fy = fy;
AV_data.YYhighz2.ky = ky;
AV_data.YYhighz2.Qy = Qy;

AV_data.YYhighz2.vyaw = vyaw;
AV_data.YYhighz2.ayaw = ayaw;
AV_data.YYhighz2.fyaw = fyaw;
AV_data.YYhighz2.kyaw = kyaw;
AV_data.YYhighz2.Qyaw = Qyaw;

%% YYmidz1
load 'Mouse276_8Maze_22_3_24_v2.mat'
laps = [1 8];

clip = [35785 87251];    % see script SUB_clipdata.m
data = Mouse276_8Maze_22_3_24_v2(clip(1):clip(2),:);
tincr = 0.01;           % (ms)
time = [0:tincr:tincr*(size(data,1)-1)]';     %(s)

[vel_mouse,vel_mouse_yaw,accel_mouse,accel_mouse_yaw,rangecum] = Process_raw_data(data,tincr,laps);

vx = vel_mouse(rangecum,1);
ax = accel_mouse(rangecum,1);
fx = data(rangecum,18);              
kx = boundary(vx,ax,b_fac);
Qx = abs(trapz(vx(kx),ax(kx)));

vy = vel_mouse(rangecum,2);
ay = accel_mouse(rangecum,2);
fy = data(rangecum,19);              
ky = boundary(vy,ay,b_fac);
Qy = abs(trapz(vy(ky),ay(ky)));

vyaw = vel_mouse_yaw(rangecum,1);
ayaw = accel_mouse_yaw(rangecum,1);
fyaw = data(rangecum,21);            
kyaw = boundary(vyaw,ayaw,b_fac);
Qyaw = abs(trapz(vyaw(kyaw),ayaw(kyaw)));

AV_data.YYmidz1.vx = vx;
AV_data.YYmidz1.ax = ax;
AV_data.YYmidz1.fx = fx;
AV_data.YYmidz1.kx = kx;
AV_data.YYmidz1.Qx = Qx;

AV_data.YYmidz1.vy = vy;
AV_data.YYmidz1.ay = ay;
AV_data.YYmidz1.fy = fy;
AV_data.YYmidz1.ky = ky;
AV_data.YYmidz1.Qy = Qy;

AV_data.YYmidz1.vyaw = vyaw;
AV_data.YYmidz1.ayaw = ayaw;
AV_data.YYmidz1.fyaw = fyaw;
AV_data.YYmidz1.kyaw = kyaw;
AV_data.YYmidz1.Qyaw = Qyaw;

%% YYmidz2
load 'Mouse489_8Maze_22_3_24_v2.mat'
laps = [1 12];

clip = [6347 71481];    % see script SUB_clipdata.m
data = Mouse489_8Maze_22_3_24_v2(clip(1):clip(2),:);
tincr = 0.01;           % (ms)
time = [0:tincr:tincr*(size(data,1)-1)]';     %(s)

[vel_mouse,vel_mouse_yaw,accel_mouse,accel_mouse_yaw,rangecum] = Process_raw_data(data,tincr,laps);

vx = vel_mouse(rangecum,1);
ax = accel_mouse(rangecum,1);
fx = data(rangecum,18);              
kx = boundary(vx,ax,b_fac);
Qx = abs(trapz(vx(kx),ax(kx)));

vy = vel_mouse(rangecum,2);
ay = accel_mouse(rangecum,2);
fy = data(rangecum,19);              
ky = boundary(vy,ay,b_fac);
Qy = abs(trapz(vy(ky),ay(ky)));

vyaw = vel_mouse_yaw(rangecum,1);
ayaw = accel_mouse_yaw(rangecum,1);
fyaw = data(rangecum,21);            
kyaw = boundary(vyaw,ayaw,b_fac);
Qyaw = abs(trapz(vyaw(kyaw),ayaw(kyaw)));

AV_data.YYmidz2.vx = vx;
AV_data.YYmidz2.ax = ax;
AV_data.YYmidz2.fx = fx;
AV_data.YYmidz2.kx = kx;
AV_data.YYmidz2.Qx = Qx;

AV_data.YYmidz2.vy = vy;
AV_data.YYmidz2.ay = ay;
AV_data.YYmidz2.fy = fy;
AV_data.YYmidz2.ky = ky;
AV_data.YYmidz2.Qy = Qy;

AV_data.YYmidz2.vyaw = vyaw;
AV_data.YYmidz2.ayaw = ayaw;
AV_data.YYmidz2.fyaw = fyaw;
AV_data.YYmidz2.kyaw = kyaw;
AV_data.YYmidz2.Qyaw = Qyaw;


%% YYlow1
load 'Mouse276_8maze_22_4_1.mat'
laps = [1 6];

clip = [28221 64752];    % see script SUB_clipdata.m
data = Mouse276_8maze_22_4_1(clip(1):clip(2),:);
tincr = 0.01;           % (ms)
time = [0:tincr:tincr*(size(data,1)-1)]';     %(s)

[vel_mouse,vel_mouse_yaw,accel_mouse,accel_mouse_yaw,rangecum] = Process_raw_data(data,tincr,laps);

vx = vel_mouse(rangecum,1);
ax = accel_mouse(rangecum,1);
fx = data(rangecum,18);              
kx = boundary(vx,ax,b_fac);
Qx = abs(trapz(vx(kx),ax(kx)));

vy = vel_mouse(rangecum,2);
ay = accel_mouse(rangecum,2);
fy = data(rangecum,19);              
ky = boundary(vy,ay,b_fac);
Qy = abs(trapz(vy(ky),ay(ky)));

vyaw = vel_mouse_yaw(rangecum,1);
ayaw = accel_mouse_yaw(rangecum,1);
fyaw = data(rangecum,21);            
kyaw = boundary(vyaw,ayaw,b_fac);
Qyaw = abs(trapz(vyaw(kyaw),ayaw(kyaw)));

AV_data.YYlowz1.vx = vx;
AV_data.YYlowz1.ax = ax;
AV_data.YYlowz1.fx = fx;
AV_data.YYlowz1.kx = kx;
AV_data.YYlowz1.Qx = Qx;

AV_data.YYlowz1.vy = vy;
AV_data.YYlowz1.ay = ay;
AV_data.YYlowz1.fy = fy;
AV_data.YYlowz1.ky = ky;
AV_data.YYlowz1.Qy = Qy;

AV_data.YYlowz1.vyaw = vyaw;
AV_data.YYlowz1.ayaw = ayaw;
AV_data.YYlowz1.fyaw = fyaw;
AV_data.YYlowz1.kyaw = kyaw;
AV_data.YYlowz1.Qyaw = Qyaw;

%% YYlowz2
load 'Mouse489_8maze_22_4_1_v2.mat'
laps = [1 6];

clip = [16969 69244];    % see script SUB_clipdata.m
data = Mouse489_8maze_22_4_1_v2(clip(1):clip(2),:);
tincr = 0.01;           % (ms)
time = [0:tincr:tincr*(size(data,1)-1)]';     %(s)

[vel_mouse,vel_mouse_yaw,accel_mouse,accel_mouse_yaw,rangecum] = Process_raw_data(data,tincr,laps);

vx = vel_mouse(rangecum,1);
ax = accel_mouse(rangecum,1);
fx = data(rangecum,18);              
kx = boundary(vx,ax,b_fac);
Qx = abs(trapz(vx(kx),ax(kx)));

vy = vel_mouse(rangecum,2);
ay = accel_mouse(rangecum,2);
fy = data(rangecum,19);              
ky = boundary(vy,ay,b_fac);
Qy = abs(trapz(vy(ky),ay(ky)));

vyaw = vel_mouse_yaw(rangecum,1);
ayaw = accel_mouse_yaw(rangecum,1);
fyaw = data(rangecum,21);            
kyaw = boundary(vyaw,ayaw,b_fac);
Qyaw = abs(trapz(vyaw(kyaw),ayaw(kyaw)));

AV_data.YYlowz2.vx = vx;
AV_data.YYlowz2.ax = ax;
AV_data.YYlowz2.fx = fx;
AV_data.YYlowz2.kx = kx;
AV_data.YYlowz2.Qx = Qx;

AV_data.YYlowz2.vy = vy;
AV_data.YYlowz2.ay = ay;
AV_data.YYlowz2.fy = fy;
AV_data.YYlowz2.ky = ky;
AV_data.YYlowz2.Qy = Qy;

AV_data.YYlowz2.vyaw = vyaw;
AV_data.YYlowz2.ayaw = ayaw;
AV_data.YYlowz2.fyaw = fyaw;
AV_data.YYlowz2.kyaw = kyaw;
AV_data.YYlowz2.Qyaw = Qyaw;


%%

subplot(1,2,1)
hold on
v = AV_data.YYmidz1.vy;
a = AV_data.YYmidz1.ay;
k = AV_data.YYmidz1.ky;
plot(v,a,'-k')
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);
v = AV_data.YYmidz2.vy;
a = AV_data.YYmidz2.ay;
k = AV_data.YYmidz2.ky;
plot(v,a,'-k')
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);


subplot(1,2,2)
hold on
v = AV_data.YYmidz1.vyaw;
a = AV_data.YYmidz1.ayaw;
k = AV_data.YYmidz1.kyaw;
plot(v,a,'-k')
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);
v = AV_data.YYmidz2.vyaw;
a = AV_data.YYmidz2.ayaw;
k = AV_data.YYmidz2.kyaw;
plot(v,a,'-k')
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);
