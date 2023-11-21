% STATS and FIGRUES on Decisions.mat data during exoskeleton decision making
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all

% Can either load Decisions.mat
load('Decisions.mat')
% Or generate it from scratch using the script "MAIN_Analyze8mazeDecisiondata.m"
% in the folder directory "...\8maze Exo Decisions - Full data"

% The structure of Decisions is:
% Decisions.MxDx where M1 indicates mouse 1, and D1 indicates day 1
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
% turnseq  sequence of decisions (1 = correct; -1 = incorrect; 0 = helped; )
% d        cell array with start and end indices of each turn in turning zone
% rangecum  concatenaed matrix array of all data indices for mouse in turning zone
% help     help (door in place) [L R]
% success  success [L R]
% fail     fail [L R]
% kx       boundary of X va profile 
% ky       boundary of Y va profile 
% kyaw     boundary of Yaw va profile 

% For all data, the sample rate is 100 Hz (10 ms loop rate on DAQ)

%% Plot number of laps across trials
[data] = plot_numtrials_Dec(Decisions);

%% Plot paths through turning zone on training day 1 for all mice
figure
x0 = 0;
y0 = 0;
width = 600;
height = 1000;
set(gcf,'position',[x0,y0,width,height])
set(gcf,'color','w');
plot_allturnpaths_Dec(Decisions)

% individual turn path figures
% plot_allturnpaths_Dec_indfig(Decisions)

%% Plot success rate across sessions
genplot = 2;
fit = 1;
% 8 sessions to include most mice
[x,y,x1,y1,datas,dataf] = plot_successfail_Dec_v2(Decisions,fit,genplot);
% All 12 sessions
% [~,~,~,~,~,~] = plot_successfail_Dec(Decisions,fit,genplot);

% ANOVA to get mean and confidence intervals
[statssf,csf] = anova_successfail(datas,dataf);

% Binomial to get mean and confidence intervals
[phat,pci] = binomial_successfail(datas,dataf);

%% Plot tortuosity across trials
figure 
ex = -1; 
Col = [0.4660 0.6740 0.1880];
[tortYS] = plot_Ytortuosity_Dec(Decisions,ex,Col);
title('Y tortuosity across days - correct turns')

figure
ex = 1;
Col = [0.6350 0.0780 0.1840];
[tortYF] = plot_Ytortuosity_Dec(Decisions,ex,Col);
title('Y tortuosity across days - incorrect turns')

%% ANOVA testing and trends in mean
[cY,statsY] = anova_tort_Dec(tortYS);
p = polyfit([1:1:12],statsY.means,1); Yt = polyval(p,[1:1:12]);
hold on; plot(Yt,[12:-1:1]);
title('Y tortuosity across days - correct turns')

[cYaw,statsYaw] = anova_tort_Dec(tortYF);
p = polyfit([1:1:12],statsYaw.means,1); Yawt = polyval(p,[1:1:12]);
hold on; plot(Yawt,[12:-1:1]);
title('Y tortuosity across days - incorrect turns')

%% Plot forces during left and right turns across days

% first generate the force variables from the data
[Decisions] = gen_forces_allmice_Dec(Decisions);

% Compare all mice across days
fit = 1;
[statsfy,cfy] = plot_forcesY_Dec(Decisions,fit);
[statsfyaw,cfyaw] = plot_forcesYaw_Dec(Decisions,fit);

% Compare all mice across days - force peaks only
[statsfyp,cfyp] = plot_forcesYpeak_Dec(Decisions,fit);
[statsfyawp,cfyawp] = plot_forcesYawpeak_Dec(Decisions,fit);


%% Kruskal-Wallis test for comparison (Chi-squared) to freely behaving
% load data from mice during freely behaving training and freely behaving 
% decision making 
load('FB_TD_dat.mat') 
% loads 4 variables: 
% datafD        fails during decision making freely behaving
% datasD        sucess during decision making freely behaving
% to be compared to variables created above in this script: 
% dataf         fails during decision making on exo 
% datas         success during decision making on exo 

% compare 7 days of decision making freely behaving to 7 days of exo 
[statskw,ckw,pkw,tblkw] = KW_successfail([sum(datasD(2:end,:),1);sum(datas(2:end,:),1)],[sum(datafD(2:end,:),1);sum(dataf(2:end,:),1)]);






