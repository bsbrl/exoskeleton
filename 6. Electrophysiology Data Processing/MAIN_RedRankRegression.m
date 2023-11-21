%% LOAD EPHYS AND EXO DATA AND ANALYSE THE TWO
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Reduced rank regression functions from Hilafu et al. BMC Bioinformatics 
% (2020) doi.org/10.1186/s12859-020-03606-2 - modified by Michael
% Feldkamp (Mech Eng, UMN) and James Hope (Mech Eng, UMN) for compatibilty
% Mod 1 = taurange used in cvcisesrrr.m expanded
% Mod 2 = train-then-test function sequence changed to only train

clear all

% Data are contained in the files 'MouseXDayX_Srate_Bvars.mat'
% Data in these files have been generated for each mouse and day using the 
% script MAIN_exo_ephys_analysis_v9.m
% Data files contain several variables: 
% Behav_vars_rs     Behavioral variables (time x variable) from exoskeleton
%                   [global X, Y, Yaw positions (m,m,rad), mouse X, Y , Yaw 
%                   velocities (m/s, m/s, rad/s), mouse X, Y, Yaw accelerations 
%                   acceleration (m/s^2,m/s^2,rad/s^2), X, Y, Yaw forces 
%                   (N, N, Nm), left sound cue, right sound cue, reward
%                   sound cue, reward dispensing, dzone (logic arrays)];
% spike_rate_Left_GW    Spike rates (time x cluster), guassian filtered,
%                       for Left probe
% spike_rate_Right_GW   Spike rates (time x cluster), guassian filtered,
%                       for Right probe
% spike_rate_t      time array (s)

% path to data
addpath(strcat(pwd,'\RedRankRegression'))

%% Load data
% uncomment data set to use
load('Mouse1Day1_Srate_Bvars.mat')
% load('Mouse1Day2_Srate_Bvars.mat')
% load('Mouse1Day3_Srate_Bvars.mat')
% load('Mouse2Day3_Srate_Bvars.mat')
% load('Mouse3Day1_Srate_Bvars.mat')
% load('Mouse4Day1_Srate_Bvars.mat')
% load('Mouse4Day2_Srate_Bvars.mat')
% load('Mouse4Day3_Srate_Bvars.mat')

%% Z-score spike rates
Zspike_Left = zscore(spike_rate_Left_GW);
Zspike_Right = zscore(spike_rate_Right_GW);

%% Generate predictor matrix using position-binning, velocities and sound cues
% Pred contains:   [position binned Left turns through Dzone,...
%                   position binned motion through left loop (moving only),...
%                   position binned Right turns through Dzone,...
%                   position binned motion through Right loop (moving only),...
%                   left sound cue, right sound cue, reward sound cue,...
%                   reward dispensing, Zscored X, Y, & Yaw velocities,...
%                   zscored X, Y & Yaw accelerations];
tincr = spike_rate_t(2,1) - spike_rate_t(1,1);
step = 0.2; % include some time before movement onset in moving data
binD = 0.01; % Decision zone global y axis position binning (m)
binL = 2*pi/80; % Loop position position (rad)
[Pred] = generate_Predictor(Behav_vars_rs,tincr,step,binD, binL);

%% Reduced rank regression
path = (strcat(pwd,'\cvx'));                % cvx toolbox
addpath(path);                              % add path 
filename = strcat(path,'\cvx_license.dat'); % path to license
cvx_setup cvx_license.dat                   % set up cvx toolbox
addpath(strcat(pwd,'\RedRankRegression'));   % path to Regression functions

%% Set up matrices for regression
clear X Y
X = Pred;                 % prediction matrix
Xsmall = find(sum(X,1)<10);
X(:,Xsmall) = 0;

% REGRESSION ON Left or Right
% Y = [Zspike_Left];      % zscored spike rate Left probe
Y = [Zspike_Right];      % zscored spike rate Right probe


disp('Regression:')
nsim = 5; % number of replications
n = size(X,1);
r = 5;
s = 10;  % can't be bigger than sz(X,2), ... maybe # of singular values
% rho = 0.5;
b = 1;

% fpr = zeros(nsim,1); tpr = fpr; deltafY = tpr; deltafC = deltafY; deltafXB = deltafC;
for isim=1:nsim

    % setup and run
    nfolds = 5;
    ngrid = 15;

    normalize = 'False';
    cisesrrrOut = cvcisesrrr_L2tau(X,Y,X,Y,nfolds,ngrid,r); % call function
    cisesrrrError = cisesrrrOut.cisesrrrerror;
    deltafY(isim,:) = cisesrrrError;
    disp(isim) % track iterations
end  

C = cisesrrrOut.hatC;
windowsum = sum(C);

%% image C, split into position, cue/events, vel and accel
% Note that imagesc plots the Y axis with descending values

% figure
% subplot(1,3,1)
% imagesc([C(1:196,:)]')
% xlabel('position predictor')
% ylabel('cell')
% subplot(1,3,2)
% imagesc([C(197:200,:)]')
% xlabel('sound cues and reward predictor')
% ylabel('cell')
% subplot(1,3,3)
% imagesc([C(201:end,:)]')
% xlabel('vel, accel predictor')
% ylabel('cell')

figure
imagesc(abs(10-[C(1:196,:)]'))
xlabel('position bin')
ylabel('cell')
colormap(bone)

% figure
% imagesc([C(1:196,:)]')
% xlabel('position predictor')
% ylabel('cell')

% to convert cmyk to rgb
% testcmyk = [50 0 100 0]./100;
% cform = makecform('cmyk2srgb');
% lab = applycform(testcmyk,cform);
% figure
% plot(rand(3),'Color',lab,'LineWidth',6)

% colormap D1_Left
% cmap = [[linspace(1,0,100)]',...
%         [linspace(1,0.4470,100)]',...
%         [linspace(1,0.7410,100)]'];
% colormap(cmap)

% colormap D1_Right
% cmap = [[linspace(1,0.3010,100)]',...
%         [linspace(1,0.7450,100)]',...
%         [linspace(1,0.9330,100)]'];
% colormap(cmap)

% colormap D2_Left
% cmap = [[linspace(1,0.2851,100)]',...
%         [linspace(1,0.4884,100)]',...
%         [linspace(1,0.3334,100)]'];
% colormap(cmap)
%         
% colormap D2_Right
% cmap = [[linspace(1,0.5589,100)]',...
%         [linspace(1,0.7594,100)]',...
%         [linspace(1,0.1790,100)]'];
% colormap(cmap)

% colormap D3_Left
% cmap = [[linspace(1,0.5534,100)]',...
%         [linspace(1,0.3786,100)]',...
%         [linspace(1,0.2464,100)]'];
% colormap(cmap)
%                 
% colormap D3_Right
% cmap = [[linspace(1,0.9569,100)]',...
%         [linspace(1,0.5779,100)]',...
%         [linspace(1,0.0663,100)]'];
% colormap(cmap)
            
%% for Mouse 1 Day 1
figure
clustplot = [7:10,12,13];    % cells shown for M1D1L
% clustplot = [1:3,8,9,14]; % cells shown for M1D1R
% clustplot = [4:9]; % cells shown for M1D2L
% clustplot = [1:6]; % cells shown for M1D2R
% clustplot = [1:6]; % cells shown for M1D3L
% clustplot = [1:5]; % cells shown for M1D3R
  
datZ = Zspike_Left;

for n = 1:6
    cluster = clustplot(n);
    hold on
    % figure
    % subplot(2,1,1)
    % plot3(Behav_vars_rs(:,1),Behav_vars_rs(:,2),Zspike_Left(:,cluster))
    % hold on
    % plot(Behav_vars_rs(:,1),Behav_vars_rs(:,2))
    % view([24.7 18.55])
    % title('spike rate cell 1')
    % legend('spike rate','8maze position')

    subplot(2,3,n)
    ztemp = datZ(:,cluster);
    cmp = linspace(0,max(ztemp),numel(ztemp));
    s = scatter3(Behav_vars_rs(:,1),Behav_vars_rs(:,2),datZ(:,cluster),[],ztemp,'filled'); 
%     s = scatter3(Behav_vars_rs(:,1),Behav_vars_rs(:,2),datZ(:,cluster),[],[0.5 0.5 0.5],'filled');
%     s.MarkerFaceAlpha = 0.1;
%     s.MarkerEdgeAlpha = 0.1;
    colorbar
    title(strcat('cluster',num2str(cluster)))
    grid off
    xlim([-0.3 0.3])
    ylim([-0.15 0.15])
    view([-30 35])
end

%% Select cells of interest and plot average Zscored spike rate around 8maze
clear Xav Yav Zav Xdat Ydat Zdat

% M1D1 Left
% Col = [0 0.4470 0.7410]; cellOI = 10;

% M1D1 Right
% Col = [0.3010 0.7450 0.9330]; cellOI = 1;

% M1D2 Left
% Col = [0.2851,0.4884,0.3334]; cellOI = 6;

% M1D2 Right
% Col = [0.5589,0.7594,0.1790]; cellOI = 1;

% M1D3 Left
% Col = [0.5534,0.3786,0.2464]; cellOI = 3;

% M1D3 Right
Col = [0.9569,0.5779,0.0663]; cellOI = 1;


divisor = sum(Pred(:,1:196),1);
[M,I] = find(divisor == 0);
divisor(I) = [];

Predtemp = Pred(:,1:196);
Predtemp(:,I) = [];
Xdat = Behav_vars_rs(:,1).*Predtemp;
Ydat = Behav_vars_rs(:,2).*Predtemp;
Zdat = datZ(:,cellOI).*Predtemp;

% average X position 
Xav = sum(Xdat,1)./divisor;
% average Y position 
Yav = sum(Ydat,1)./divisor;
% average zscored spike rate
Zav = sum(Zdat,1)./divisor;

Xdat(Xdat==0) = NaN;
Ydat(Ydat==0) = NaN;
Zdat(Zdat==0) = NaN;

% std zscored spike rate
Zstd = std(Zdat,1,'omitnan');

% max zscored spike rate
Zmax = max(Zdat,[],1);

% min zscored spike rate
Zmin = min(Zdat,[],1);


figure

hold on
% plot3(Behav_vars_rs(:,1),Behav_vars_rs(:,2),datZ(:,cellOI),'Color',[0 0.4470 0.7410],'LineWidth',0.5)
plot3(Xav,Yav,Zav,'LineWidth',4,'Color', Col);
plot3(Xav,Yav,Zmax,'LineWidth',1,'Color', Col);
plot3(Xav,Yav,Zmin,'LineWidth',1,'Color', Col);
plot3(Xav,Yav,-2.*ones(size(Xav)),'-k');
s = surf([Xav; Xav],[Yav;Yav],[Zmin; Zmax])
s.EdgeColor = 'none';
s.FaceAlpha = 0.3;
s.FaceColor = Col;
xlim([-0.3 0.3])
ylim([-0.15 0.15])
title(num2str(cellOI))
view([-30 35])

figure
ztemp = Zav;
cmp = linspace(0,max(ztemp),numel(ztemp));
s = scatter3(Xav,Yav,Zav,200,ztemp,'filled'); 
grid off

