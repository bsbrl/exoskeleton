% STATS and FIGRUES on Eightmaze.mat data during exoskeleton training
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all

% Can either load Eightmaze.mat
load('Eightmaze.mat')
% Or generate it from scratch using the script "MAIN_Analyze8mazedata.m"
% in the folder directory "...\8maze Exo Training - Full data"

% The structure of Eightmaze is:
% Eightmaze.MxDx where M1 indicates mouse 1, and D1 indicates day 1
% Within each Eightmaze.MxDx, the variables saved are: 
% x        global x position
% vx       x velocity 
% ax       x acceleration
% fxp      x force
% y        global y position
% vy       y vel
% ay       y accel
% fy       y force
% yaw      global yaw position
% vyaw     yaw vel
% ayaw     yaw accel
% fyaw     yaw torque
% d        array with start and end indices of each turn in turning zone
% rangecum  concatenaed array of all data indices for mouse in turning zone
% success   success [L R]
% fail     fail [L R]
% kx       boundary of X va profile 
% ky       boundary of Y va profile 
% kyaw     boundary of Yaw va profile 

% For all data, the sample rate is 100 Hz (10 ms loop rate on DAQ)

%% Plot number of laps across trials
[data] = plot_numtrials(Eightmaze);
ylim([0 24])

%% Plot paths through turning zone on training day 1 for all mice
figure
hold on
plot_turnpaths(Eightmaze.M1D1);
plot_turnpaths(Eightmaze.M2D1);
plot_turnpaths(Eightmaze.M3D1);
plot_turnpaths(Eightmaze.M4D1);
plot_turnpaths(Eightmaze.M5D1);

%% Plot paths through turning zone on final training day for all mice
% NB: this is day 5 for some mice, day 8 for others
figure
hold on
plot_turnpaths(Eightmaze.M1D8);
plot_turnpaths(Eightmaze.M2D5);
plot_turnpaths(Eightmaze.M3D8);
plot_turnpaths(Eightmaze.M4D5);
plot_turnpaths(Eightmaze.M5D5);

%% Plot success rate across sessions
fit = 1;
[datas,dataf] = plot_successfail(Eightmaze,fit);
ylim([0 100])

% anova
% [statssf,csf] = anova_successfail(datas,dataf);

% binomial test
[phat,pci] = binomial_successfail(datas,dataf);



%% Plot tortuosity across trials
figure
[tortY] = plot_Ytortuosity(Eightmaze);
title('Y tortuosity - all mice across sessions')
figure
[tortYaw] = plot_Yawtortuosity(Eightmaze);
title('Yaw tortuosity - all mice across sessions')

% Stats and trends
[cY,statsY] = anova_tort(tortY);
p = polyfit([1:1:8],statsY.means,1); Yt = polyval(p,[1:1:8]);
hold on; plot(Yt,[8:-1:1]);
title('Y tortuosity across days')
% statsY.F

% [cY,statsY] = KW_tort(tortY);
% p = polyfit([1:1:8],statsY.meanranks,1); Yt = polyval(p,[1:1:8]);
% hold on; plot(Yt,[8:-1:1]);
% title('Y tortuosity across days')

[cYaw,statsYaw] = anova_tort(tortYaw);
p = polyfit([1:1:8],statsYaw.means,1); Yawt = polyval(p,[1:1:8]);
hold on; plot(Yawt,[8:-1:1]);
title('Yaw tortuosity across days')
% statsYaw.F

% [cYaw,statsYaw] = KW_tort(tortYaw);
% p = polyfit([1:1:8],statsYaw.meanranks,1); Yawt = polyval(p,[1:1:8]);
% hold on; plot(Yawt,[8:-1:1]);
% title('Yaw tortuosity across days')

%% Plot forces during left and right turns across days

% first generate the force variables from the data
[Eightmaze] = gen_forces_allmice(Eightmaze);

% compare across mice training day 1 and day final 
figure
plot_forces_mice(Eightmaze); 
figure
[statsfym,cfym,statsfyawm,cfyawm] = plot_forces_micepeak(Eightmaze);



%%
% Compare all mice across days
[statsfy,cfy,statsfyc,cfyc] = plot_forcesY(Eightmaze);
[statsfyaw,cfyaw,statsfyawc,cfyawc] = plot_forcesYaw(Eightmaze);

% Compare all mice across days - force peaks only
[statsfyp,cfyp,statsfycp,cfycp] = plot_forcesYpeak(Eightmaze);
[statsfyawp,cfyawp,statsfyawcp,cfyawcp] = plot_forcesYawpeak(Eightmaze);


%%








