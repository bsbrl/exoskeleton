% GENERATE STATS ON FREELY BEHAVING VS EXOSKELETON TUNING
% Author: James Hope & Michael Feldkamp, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Updated 12/20/23 by JAH to include:
% Vel-Accel Distributions added 

% Updated 12/28/23 by MF to include:
% Sliding window averaged velocity over time for FB, L, T, H mice

% Updated 2/8/24 by MF to include:
% Sliding window averaged velocity over time for the above for all mice. Requires reloading AV_data with included time series.

clear all

% load AV profile data
load('AV_data.mat')
% Or generate it from scratch using 'MAIN_GenAVprofiles_TuningData.m' 
% in the folder directory: "...\Tuning Data and Figures"

path = strcat(pwd,'\Tuning Data and Figures');
addpath(path)
path = strcat(pwd,'\Tuned Mousetrack - Full Data');
addpath(path)

%% PLOT V-A PROFILE BOUNDS
figure
x0 = 0;
y0 = 0;
width = 1200;
height = 800;
set(gcf,'position',[x0,y0,width,height])
set(gcf,'color','w');

plot_VA_profiles(AV_data);

%% PLOT V-A DISTRIBUTIONS 
figure
x0 = 0;
y0 = 0;
width = 1200;
height = 800;
set(gcf,'position',[x0,y0,width,height])
set(gcf,'color','w');




%% Box and whisker analysis of all velocity and acceleration data peaks only
vel_cutoff = 0.005; % (m/s) to remove stationary data
% box and whisker plots for X velocity and X acceleration (peaks only)
plot_VApeaks_box(AV_data,vel_cutoff)

%% ANOVA on velocity and acceleration peaks
vel_cutoff = 0.005; % (m/s) to remove stationary data
Dsamp = 1;  % 1 = downsample; 0 = do not downsample
P = 100;    % num samples to downsample data to (if D = 1)
All = 0;    % All pops (1) or subsample of pops (0)
perc = 30;  % percentage to downsample
[vstats,astats] = anova_VApeaks(AV_data,vel_cutoff,P,Dsamp,All,perc);

%% Compare stats across percentage range of values
vel_cutoff = 0.005; % (m/s) to remove stationary data
Dsamp = 0;  % 1 = resample; 0 = do not downsample
P = 100;    % num samples to downsample data to (if D = 1)
All = 0;    % All pops (1) or subsample of pops (0)
m = 1;
for n = 100:-10:10

    [vstats,astats] = anova_VApeaks(AV_data,vel_cutoff,P,Dsamp,All,n);
    va_prange(m).vstats = vstats;
    v_means(m,1) = va_prange(m).vstats.xds.mean;    % freely behaving
    v_means(m,2) = va_prange(m).vstats.yds.mean;    % tuned and trained
%     v_means(m,3) = va_prange(m).vstats.zds.mean;    % tuned

    v_std(m,1) = va_prange(m).vstats.xds.std;
    v_std(m,2) = va_prange(m).vstats.yds.std;
%     v_std(m,3) = va_prange(m).vstats.zds.std;

    v_p(m,1) = va_prange(m).vstats.c(2,6);

    va_prange(m).astats = astats;
    a_means(m,1) = va_prange(m).astats.xds.mean;
    a_means(m,2) = va_prange(m).astats.yds.mean;
%     a_means(m,3) = va_prange(m).astats.zds.mean;

    a_std(m,1) = va_prange(m).astats.xds.std;
    a_std(m,2) = va_prange(m).astats.yds.std;
%     a_std(m,3) = va_prange(m).astats.zds.std;

    a_p(m,1) = va_prange(m).astats.c(2,6);
    m = m+1;
end

figure
subplot(1,2,1)
hold on
plot([100:-10:10],v_means(:,1),'-k')
% scatter([100:-10:10],v_means(:,1))
plot([100:-10:10],v_means(:,1)+v_std(:,1),'-k')
plot([100:-10:10],v_means(:,1)-v_std(:,1),'-k')

plot([100:-10:10],v_means(:,2),'-b')
% scatter([100:-10:10],v_means(:,2))
plot([100:-10:10],v_means(:,2)+v_std(:,2),'-b')
plot([100:-10:10],v_means(:,2)-v_std(:,2),'-b')

% plot([100:-10:10],v_means(:,3),'-g')
% % scatter([100:-10:10],v_means(:,2))
% plot([100:-10:10],v_means(:,3)+v_std(:,3),'-g')
% plot([100:-10:10],v_means(:,3)-v_std(:,3),'-g')

xlabel('Top percentage of peaks')
ylabel('Velocity peaks (m/s)')

subplot(1,2,2)
hold on
plot([100:-10:10],a_means(:,1),'-k')
% scatter([100:-10:10],a_means(:,1))
plot([100:-10:10],a_means(:,1)+a_std(:,1),'-k')
plot([100:-10:10],a_means(:,1)-a_std(:,1),'-k')

plot([100:-10:10],a_means(:,2),'-b')
% scatter([100:-10:10],a_means(:,2))
plot([100:-10:10],a_means(:,2)+a_std(:,2),'-b')
plot([100:-10:10],a_means(:,2)-a_std(:,2),'-b')

% plot([100:-10:10],a_means(:,3),'-g')
% % scatter([100:-10:10],v_means(:,2))
% plot([100:-10:10],a_means(:,3)+a_std(:,3),'-g')
% plot([100:-10:10],a_means(:,3)-a_std(:,3),'-g')

xlabel('Top percentage of peaks')
ylabel('Acceleration peaks (m/s^2)')

%% Only 3 populations for simpler box plot
vel_cutoff = 0.005; % (m/s) to remove stationary data
% box and whisker plots for X velocity and X acceleration peaks only
% population comparison
[vout,aout] = plot_VApeaks_box_pops(AV_data,vel_cutoff);

%% Compare forces trained vs untrained
vel_cutoff = 0.005; % (m/s) to remove stationary data
% box and whisker plots for absolute of force peaks
plot_Fpeaks_box(AV_data,vel_cutoff)

%% ANOVA test on trained vs untrained forces
vel_cutoff = 0.005; % (m/s) to remove stationary data
Dsamp = 1;  % 1 = downsample; 0 = do not downsample
P = 100;    % num samples to downsample data to (if D = 1)
[fstats] = anova_on_force(AV_data,vel_cutoff,P,Dsamp);


%% EXAMPLE DATA PLOTS
% data bounds X Y and Yaw axes
figure
plot_VAXYYaw_profiles_f1(AV_data)

% data bounds x axis varying tuning
figure
plot_VAX_profiles_f1(AV_data)

%% Velocity and force time series for x axis varying tuning
load('AV_data.mat') 
plot_time_series(AV_data)

%% Vel-Accel-Force scatter plot with admittance plane 
x0 = 0;
y0 = 0;
width = 1800;
height = 400;
set(gcf,'position',[x0,y0,width,height])
set(gcf,'color','w');

m1 = 0.5; c1 = 0.3;
m2 = 1; c2 = 0.9;
m3 = 3; c3 = 6;
plot_AVF(m1,c1,m2,c2,m3,c3)


%% Moving averaged time window
load('AV_data_t.mat')

mm_win = 10; % size of moving average window in seconds
t_fb = 0.034;
endtime = 200;
% Note that in fb datasets, fb1-3 fb4-5 fb6 are three different mice with
% concatenated trials. 
figure
fnames = fieldnames(AV_data);

meanFB = NaN(6,round(endtime/0.034));
meanTN = NaN(4,endtime/0.01);

for f = 1:21
    hold on
    name = fnames{f};
    type = name(1);
    sers = name(end);
    data = AV_data.(name);
    vx = data.vx;
    
    if type == 'm',continue,end
    if type == 'l',continue,end
    if type == 'h',continue,end
    
    if isfield(data,'time')
        time = data.time;
    else
        time = linspace(t_fb,t_fb*(length(data.vx)),length(data.vx)); % Freely behaving, create time vector manually using tincr
    end
    
    twin = round(mm_win/(time(2)-time(1)));
    tend = round(endtime/(time(2)-time(1))); % Samples within (endtime) seconds
    movave = movmean(vx,twin);

    if type=='t'
        meanTN(str2double(name(end)),1:min(tend,length(movave))) = movave(1:min(tend,length(movave)))';
    elseif type == 'f'
        meanFB(str2double(name(end)),1:min(tend,length(movave))) = movave(1:min(tend,length(movave)))';
    end
    
    switch type
        case 'f'
            typecolor = [0.5 0.5 0.5 0.7];
        case 'l'
            typecolor = [0 0.4470 0.7410];
        case 't'
            typecolor = 0.75*[0 0.4470 0.7410 0.7];
        case 'h'
            typecolor = 0.5*[0 0.4470 0.7410];
    end
    
    plot(time,movave,'color',typecolor,'linewidth',1)
    xlabel('time [s]')
    ylabel('x velocity [m/s]')
    sgtitle([num2str(mm_win),'s window'])
    
end

% xlim([0 60])
% ylim([0 0.06])
% legend({'Freely behaving','','','','','','Tuned z'})

% Plot linear regression of mean smoothed velocity over time
hold on

newX = [0:endtime]';

time_fb = linspace(t_fb,t_fb*size(meanFB,2),size(meanFB,2));
time_fb = repmat(time_fb,1,size(meanFB,1));
X_fb = meanFB'; X_fb = X_fb(:);
fitfb = fitlm(time_fb',X_fb);
[predfb,cifb] = predict(fitfb,newX);


time_tn = linspace(0.01,0.01*size(meanTN,2),size(meanTN,2));
time_tn = repmat(time_tn,1,size(meanTN,1));
X_tn = meanTN'; X_tn = X_tn(:);
fittn = fitlm(time_tn',X_tn);
[predtn,citn] = predict(fittn,newX);

fbcolor = [0.5 0.5 0.5];
tncolor = 0.75*[0 0.4470 0.7410];

plot(newX,predfb,'color',fbcolor,'LineWidth',3)
plot(newX,predtn,'color',tncolor,'LineWidth',3)


xlim([0 endtime])
% ylim([-0.01 0.06])
plot([0 mm_win],[0 0],'k')

legend({'FB trials','','','','','','Tuned z trials','','','','Mean FB','Mean tuned z',''})

% ylim([0 0.05])
% yticks([0 0.01 0.02 0.03 0.04 0.05])

%%




