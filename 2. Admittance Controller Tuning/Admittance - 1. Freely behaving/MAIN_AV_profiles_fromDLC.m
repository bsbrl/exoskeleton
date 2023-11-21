% Generate AV_data.mat which contains x y and yaw V-A profiles from 
% freely behaving mice 

% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all

% x and y position determined from points 4 and 7
% Body direction in global frame is the vector orientation between the two points
% Body velocity is the average change in position of the two points
% described in the mouse frame
% Arena size is 33 x 33 cm and ~330 x 330 pixels => 1 pixel equates to 1 mm distance
% Need to clip out sections of the data because there are several
% trials concatenated into the same file 
% => in 'Mesoscopedata_trial1_1_13_20.mat', used: 
% clip1 = 1:900; clip2 = 1100:2400; clip3 = 4600:7600
% => in 'Mesoscopedata_trial1_1_24_20.mat', used: 
% clip1 = 1:900; clip2 = not much happens; clip3 = 2700:6900
% => in 'Mesoscopedata_trial1_1_28_20.mat', used: 
% clip1 = not much movement; clip2 = not much movement; clip3 = 8500:10500

path = strcat(pwd,'\DLC data');
addpath(path)

%% fb1
load('Mesoscopedata_trial1_1_13_20.mat')
tincr = 0.034;
startpt = 1;
endpt = 900;
data = MSdata(startpt:endpt,:);
add = 0;    % sometimes necessary to add pi if initial angle is negative... 
plotresults = 1;
[vx,ax,kx,Qx,vy,ay,ky,Qy,vyaw,ayaw,kyaw,Qyaw] = AV_bounds_3DoF(data,tincr,add,plotresults);

% store data
 
AV_data.fb1.vx = vx;
AV_data.fb1.ax = ax;
AV_data.fb1.kx = kx;
AV_data.fb1.Qx = Qx;

AV_data.fb1.vy = vy;
AV_data.fb1.ay = ay;
AV_data.fb1.ky = ky;
AV_data.fb1.Qy = Qy;

AV_data.fb1.vyaw = vyaw;
AV_data.fb1.ayaw = ayaw;
AV_data.fb1.kyaw = kyaw;
AV_data.fb1.Qyaw = Qyaw;

clear MSdata data add 

%% fb2
load('Mesoscopedata_trial1_1_13_20.mat')
tincr = 0.034;
startpt = 1100;
endpt = 2400;
data = MSdata(startpt:endpt,:);
add = 0;    % sometimes necessary to add pi if initial angle is negative...
plotresults = 1;
[vx,ax,kx,Qx,vy,ay,ky,Qy,vyaw,ayaw,kyaw,Qyaw] = AV_bounds_3DoF(data,tincr,add,plotresults);

% store data
 
AV_data.fb2.vx = vx;
AV_data.fb2.ax = ax;
AV_data.fb2.kx = kx;
AV_data.fb2.Qx = Qx;

AV_data.fb2.vy = vy;
AV_data.fb2.ay = ay;
AV_data.fb2.ky = ky;
AV_data.fb2.Qy = Qy;

AV_data.fb2.vyaw = vyaw;
AV_data.fb2.ayaw = ayaw;
AV_data.fb2.kyaw = kyaw;
AV_data.fb2.Qyaw = Qyaw;

clear MSdata data add 

%% fb3
load('Mesoscopedata_trial1_1_13_20.mat')
tincr = 0.034;
startpt = 4600;
endpt = 7600;
data = MSdata(startpt:endpt,:);
add = 0;    % sometimes necessary to add pi if initial angle is negative... 
plotresults = 1;
[vx,ax,kx,Qx,vy,ay,ky,Qy,vyaw,ayaw,kyaw,Qyaw] = AV_bounds_3DoF(data,tincr,add,plotresults);

% store data
 
AV_data.fb3.vx = vx;
AV_data.fb3.ax = ax;
AV_data.fb3.kx = kx;
AV_data.fb3.Qx = Qx;

AV_data.fb3.vy = vy;
AV_data.fb3.ay = ay;
AV_data.fb3.ky = ky;
AV_data.fb3.Qy = Qy;

AV_data.fb3.vyaw = vyaw;
AV_data.fb3.ayaw = ayaw;
AV_data.fb3.kyaw = kyaw;
AV_data.fb3.Qyaw = Qyaw;

clear MSdata data add 

%% fb4

load('Mesoscopedata_trial1_1_24_20.mat')
tincr = 0.034;
startpt = 1;
endpt = 900;
data = MSdata(startpt:endpt,:);
add = pi;    % sometimes necessary to add pi if initial angle is negative... 
plotresults = 1;
[vx,ax,kx,Qx,vy,ay,ky,Qy,vyaw,ayaw,kyaw,Qyaw] = AV_bounds_3DoF(data,tincr,add,plotresults);

% store data
 
AV_data.fb4.vx = vx;
AV_data.fb4.ax = ax;
AV_data.fb4.kx = kx;
AV_data.fb4.Qx = Qx;

AV_data.fb4.vy = vy;
AV_data.fb4.ay = ay;
AV_data.fb4.ky = ky;
AV_data.fb4.Qy = Qy;

AV_data.fb4.vyaw = vyaw;
AV_data.fb4.ayaw = ayaw;
AV_data.fb4.kyaw = kyaw;
AV_data.fb4.Qyaw = Qyaw;

clear MSdata data add 

%% fb5
load('Mesoscopedata_trial1_1_24_20.mat')
tincr = 0.034;
startpt = 2700;
endpt = 6900;
data = MSdata(startpt:endpt,:);
add = pi;    % sometimes necessary to add pi if initial angle is negative... 
plotresults = 1;
[vx,ax,kx,Qx,vy,ay,ky,Qy,vyaw,ayaw,kyaw,Qyaw] = AV_bounds_3DoF(data,tincr,add,plotresults);

% store data
 
AV_data.fb5.vx = vx;
AV_data.fb5.ax = ax;
AV_data.fb5.kx = kx;
AV_data.fb5.Qx = Qx;

AV_data.fb5.vy = vy;
AV_data.fb5.ay = ay;
AV_data.fb5.ky = ky;
AV_data.fb5.Qy = Qy;

AV_data.fb5.vyaw = vyaw;
AV_data.fb5.ayaw = ayaw;
AV_data.fb5.kyaw = kyaw;
AV_data.fb5.Qyaw = Qyaw;

clear MSdata data add 

%% fb6
load('Mesoscopedata_trial1_1_28_20.mat')
tincr = 0.034;
startpt = 8500;
endpt = 10500;
data = MSdata(startpt:endpt,:);
add = pi;    % sometimes necessary to add pi if initial angle is negative... 
plotresults = 1;
[vx,ax,kx,Qx,vy,ay,ky,Qy,vyaw,ayaw,kyaw,Qyaw] = AV_bounds_3DoF(data,tincr,add,plotresults);

% store data
 
AV_data.fb6.vx = vx;
AV_data.fb6.ax = ax;
AV_data.fb6.kx = kx;
AV_data.fb6.Qx = Qx;

AV_data.fb6.vy = vy;
AV_data.fb6.ay = ay;
AV_data.fb6.ky = ky;
AV_data.fb6.Qy = Qy;

AV_data.fb6.vyaw = vyaw;
AV_data.fb6.ayaw = ayaw;
AV_data.fb6.kyaw = kyaw;
AV_data.fb6.Qyaw = Qyaw;

clear MSdata data add 

%%

