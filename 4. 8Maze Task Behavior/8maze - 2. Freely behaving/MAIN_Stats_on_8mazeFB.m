% STATS ON FREELY BEHAVING 8MAZE DATA
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all 

% Can either load FB_8maze.mat 
load('FB_8maze.mat')
% or generate it from scratch using script MAIN_Generate_FB_8maze_data.m 
% in folder: '...\8maze task training data'

% FB_8maze.mat.MxDy indicates Mouse x Day y
% training = MxDxT; decisions (goal arm door removed) = MxDxD
% The variables for each session are: 
% score       score for the session. 1 = correct; 0 = wrong way; -1 = incorrect
% correct     number of correct trials (1)
% incorrect   number of incorrect trials (-1)
% wrongway    number of wrong way trials (0)
% perf        percentage correct trials
% co          number of correct left and right turn trials [L R];
% inc         number of incorrect left and right turn trials [L R];
% wrg         number of wrongway left and right turn trials [L R];

%% Plot success rate during training
n = 1; % polyfit order
% % plot data task training
% [x,y,x1,y1,datapT,datasT,datafT] = plot_successfail_Train_FB(FB_8maze,n);
% % anova test 
% % [statssf,csf] = anova_successfail(datasT,datafT);
% % binomial test 
% [phatT,pciT] = binomial_successfail(datasT,datafT);

%% Plot success rate during task 
% plot data task performance
[x,y,x1,y1,datapD,datasD,datafD] = plot_successfail_Dec_FB(FB_8maze,n);
% anova test 
[statssf,csf] = anova_successfail(datasD,datafD);
% binomial test 
[phatD,pciD] = binomial_successfail(datasD,datafD);

%% Generate data for final session only
% 
% [~,~,~,~,~,dataFs,dataFf] = plot_successfail_Dec_FB_finalday(FB_8maze,n);
% % binomial test 
% [phatT,pciT] = binomial_successfail(dataFs,dataFf);













