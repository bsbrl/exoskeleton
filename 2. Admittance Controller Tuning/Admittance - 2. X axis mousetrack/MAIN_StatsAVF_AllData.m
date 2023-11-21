% GENERATE STATS ON FREELY BEHAVING VS EXOSKELETON TUNING
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

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

%%




