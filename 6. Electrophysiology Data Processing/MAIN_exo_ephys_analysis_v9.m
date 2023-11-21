%% LOAD EPHYS AND EXO DATA AND ANALYSE THE TWO
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu
% --Script contains some functions from Kilosort for loading phy data 
% --Data loading functions by Travis Beckerle, Mech Eng, UMN

clear all

% This script will: 
% 1. Load raw electrophysiology data, and spike sorted data (requires user 
%    input for folder and file selection)
% 2. Filter Raw electrophysiology data
% 3. Visulalise average and subsample of spike traces for each cluster, and 
%    allow for manual removal of noisy or incorrectly mapped clusters, if 
%    necessary (requires user input for some data sets)
% 4. Load exoskeleton data (requires user file selection)
% 5. Temporally align the exoskeleton data to the ephys data
% 6. Generate spike raster plots overlaid with exoskeleton and 8maze events
% 7. Generate some stats on spike amplitudes, number of spikes, noise
%    levels
% 8. Generate videos of raw spike traces, waveforms, and spike rasters

%% Comment in the turn sequence for the data you want to analyze
% turn sequence is specific to each mouse and each session [0 = door in
% place; 1 = correct turn; -1 = incorrect turn];
% uncomment the line for the data your analyzing, to set Turn_seq and fs

% Mouse 1
% Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 1 1 1]'; fs = 30000;  % Mouse1 Day1 (M837 221010)
% Turn_seq = [0 0 0 0 1 1 1 1 1 1 1]';      fs = 20000;  % Mouse1 Day2 (M837 221003)
% Turn_seq = [0 0 0 0 0 1 1 1 1 1]';        fs = 30000;  % Mouse1 Day3 (M837 220930)

% Mouse 2
% Turn_seq = [0 0 -1 -1 0 1 -1 1]';          fs = 30000;  % Mouse2 Day1 (M845 220811) NB: exo and ephys data not sync'ed
% Turn_seq = [0 0 -1 1 1 -1 1 1 -1]';        fs = 30000;  % Mouse2 Day3 (M845 220810)

% Mouse 3
% Turn_seq = [0 0 1 1 1 1 1 1 -1 1]';        fs = 30000;  % Mouse3 Day1 (M881 220816)
% Turn_seq = [0 0 1 1 -1]';                  fs = 30000;  % Mouse3 Day2 (M881 220818) NB: exo and ephys data not sync'ed

% Mouse 4
% Turn_seq = [0 0 1 1 1 1 1 1 1 1 1 1 1]';   fs = 30000; % Mouse4 Day1 (M1002 230328)
% Turn_seq = [0 0 1 1 1 1 1 1 1 1 1 1]';     fs = 30000; % Mouse4 Day2 (M1002 230403)
Turn_seq = [0 0 1 1 1 1 1 1 1 1 1 1 1 1 1]'; fs = 30000; % Mouse4 Day3 (M1002 230406)


%% Select folder with the data you want to process
% You will be promted to select a folder; 
% e.g. you can select 'Mouse1Day1 - 221010_1_ENN_M0837 - Phy 221103'
% make sure this matches the Turn_seq that you have umcommented above

path = uigetdir(strcat(pwd,'\Ephys and Exo data'), 'Select Data Folder');
path = [path,'\'];
% addpath(path)

%% EPHYS DATA 
% Select the .bin file in the folder when promted 
% ...loading may take a while

clear ephys_filt ephys_data

% load ephys data (when prompted, open Mouse data folder and select the bin file)
[ephys_data] = load_ephys_data(path);
%format of ephys_data = [time,data,digpulse];
%%
% % use (bottom 10) electrodes that are in the brain to remove common-mode noise
ephys_data(:,2:33) = ephys_data(:,2:33)-mean(ephys_data(:,2:12),2);
ephys_data(:,34:65) = ephys_data(:,34:65)-mean(ephys_data(:,34:44),2);

% band pass filter ephys data raw spike traces
bpFilt = designfilt('highpassiir','FilterOrder',4, ...
         'PassbandFrequency',250,'PassbandRipple',0.2,'SampleRate',fs);
fvtool(bpFilt)
% zero phase filter
% ephys_data = [time,neural data,dig pulse]
for n = 2:65
    ephys_filt(:,n-1) = filtfilt(bpFilt,ephys_data(:,n));
end


%% LOAD PHY DATA
freq = fs;   % Data acquisition frequency in Hz

% similar_templates = readNPY([path,'similar_templates.npy']);
spike_clusters = readNPY([path,'spike_clusters.npy']);
% spike_templates = readNPY('spike_templates.npy');
spike_times = readNPY([path,'spike_times.npy']);
% amplitudes = readNPY([path,'amplitudes.npy']);
% channel_map = readNPY([path,'channel_map.npy']);
% channel_positions = readNPY([path,'channel_positions.npy']);
spike_templates = readNPY([path,'spike_templates.npy']);

%% LOAD CLUSTER INFO 
% this step requires that you have opened cluster_info.tsv, corrected any misalignment,
% labelled any unlabelled clusters (if phy did not save this info),
% saved, opened cluster_info.tsv in excel, then saved as cluster_info.csv
cluster_info = readtable([path,'cluster_info.csv']);
% format of cluster_info = [cluster_id,amplitude,ContamPct,KSlabel,amp,ch,depth,fr,group,n_spikes,sh]
% extract channels and change from 0 to 1 index 
channels = cluster_info{1:end,6} + 1; 
%extract cluster ids
cluster_ids = cluster_info{1:end,1};
%extract phy labelling
phy_labels = cluster_info{:,9};
phy_labels_temp = cellfun(@length,phy_labels);

isNoise = find(phy_labels_temp==5);
isGood = find(phy_labels_temp==4);
isMUA = find(phy_labels_temp==3);

phy_labels = zeros(size(cluster_ids));
phy_labels(isNoise) = 0;
phy_labels(isMUA) = 1;
phy_labels(isGood) = 2;

% collate phy info
phy_dat = [channels,cluster_ids,phy_labels];

[~,I] = sort(phy_dat(:,1));

phy_dat = phy_dat(I,:);

% keep only good spikes
for n = size(phy_dat,1):-1:1
    if phy_dat(n,3) == 2 %|| phy_dat(n,3) == 1
    else
       phy_dat(n,:) = [];
    end
end

clear isNoise isMUA isGood cluster_info channels phy_labels phy_labels_temp cluster_ids
 
%% remove bad spikes from spike times

spikes = [spike_times,spike_clusters];

for n = 1:size(phy_dat,1)
    clust = phy_dat(n,2);
    temp = find(spike_clusters==clust);
    ch = phy_dat(n,1).*ones(size(temp));    
    if n == 1
        foundclus = temp;
        foundch = ch;
    else
        foundclus = [foundclus;temp];
        foundch = [foundch;ch];
    end
end

spikes = spikes(foundclus,:);
spikes = [spikes,foundch];

clear foundclus foundch temp clus ch

%% plot sample and average waveforms (manually clean up, if necessary)

% To remove spikes that are on mapped to wrong channel, too noise etc
% comment out:

% Mouse1Day1 (M0837 231010) for video generation (best 24 spikes)
% remove = [13,26,27];                  
% phy_dat(remove,:) = [];

% Mouse1 Day3 (M0837 230930)
% remove = [21,22,23];                  
% phy_dat(remove,:) = [];

% Mouse2 Day1 (M0845 220811)
% remove = [9,16];                      
% phy_dat(remove,:) = [];

% Mouse2 Day3 (M0845 220810)
% remove = [4,9,11,20,21];              
% phy_dat(remove,:) = [];

% Mouse3 Day2 (M0881 220818)
% remove = [5,15,23,25,27,28,36,38];    
% phy_dat(remove,:) = [];


clear store
figure
x0 = 2400;
y0 = -300;
width = 300;
height = 1300;
set(gcf,'position',[x0,y0,width,height])
set(gcf,'color','w');

start = 1;

ch_plot = phy_dat(:,1);
clust_plot = phy_dat(:,2);

for n = 1:size(clust_plot,1)
    
    if n>1
        if ch_plot(n,1)>32 && ch_plot(n-1,1)<33
            figure
            x0 = 2400;
            y0 = -300;
            width = 300;
            height = 1300;
            set(gcf,'position',[x0,y0,width,height])
            set(gcf,'color','w');
        end
    end
    
    ch = ch_plot(n,1);
    clust = clust_plot(n,1);
    M = find(spikes(:,2)==clust);
%     subplot(size(clust_plot,1),1,n)
    t = 0:1/fs:100/fs;
    k = 1;
    for m = start:floor((size(M,1)-start)/50):size(M,1)
        st2p = spikes(M(m),1);
        plot(t,ephys_filt(st2p-50:st2p+50,ch)+250*n,'Color',[0.9 0.9 0.9])
        hold on
        store{n,1}(:,k) = ephys_filt(st2p-50:st2p+50,ch)+250*n;
        k = k + 1;
    end
    
    hold on
    plot(t,mean(store{n,1}(:,:),2),'Color',[0.1,0.1,0.1]);
    meanstore(:,n) = mean(store{n,1}(:,:),2) - 250*n;
%     ylim([-200 100])
%     xlim([0.002 0.005])
    axis off
end

% NB: plotting in order of depth on y-axis (but with anom's from multiple
% cells on some electrodes)

%%
%% EXOSKELETON DATA 
% Select the exo data .mat file in the folder when promted
% Exo data file name format is 'Mousexxx_8maze_ephys_[date].mat'

% load exoskeleton data
[exo_data] = load_exo_data(path);

% Note:  exo_data(:,32) = exo_time;
% format of exo_data(infx31) = [... Sound, Air, Milk, Sync pulse]
exo_data(:,28) = abs(exo_data(:,28)-1); % flip sound from trigger low to trigger high

% clip out parts of data where mouse was less than y = -0.25 to remove data
% of mouse being docked and undocked, walking on wheel, etc. 
[clip,exo_data] = clip_exo_data(exo_data);
legend('x position', 'y position', 'maze start and end points')
ylabel('position (m)')
xlabel('time (units = 10ms)')


%% load some useful parameters from exo_data
XYpos_global = exo_data(:,5:6); % (m)
Yawpos_global = exo_data(:,8);  % (m)
Xforce = exo_data(:,18);        %(N)
Yforce = exo_data(:,19);        %(N)
yawforce = exo_data(:,21);      %(Nm)
[vel_mouse,vel_mouse_yaw,accel_mouse,accel_mouse_yaw] = mouse_velocity(XYpos_global,Yawpos_global,0.01);

sound = exo_data(:,28);
air = exo_data(:,29);
milk = exo_data(:,30);
[milksound,leftsound,rightsound] = separate_sounds(sound,XYpos_global);

[d,dzone_trig] = Dzone_analysis(XYpos_global,Turn_seq);

%% CREATE SCALED EXO TIME VECTOR
% identify pulse train timing in ephys and exo data
% format of exo_data(infx32) = [... Sound, Air, Milk, Sync pulse, Scaled time]

% NOTE: For Mouse1 Day2 (M0837_221003), Uncomment the 2 lines below to create ref pulse
% exo_data(138102:138202,31) = 1;           
% ephys_data(end-40001:end-20001,end) = 0;
% % because need to manually create long ref pulses... The pulse indices 
% % for this data set have been temporally matched through sequences in 
% % behavioral video, exo, and ephys data sets

% NOTE: For data collected before Sept 9, 2022, use this function; 
% fitorder = 3; 
% [exo_data] = scale_exo_time(ephys_data,exo_data,fitorder);

% NOTE: for data acquired after Sept 9 2022, use this function: 
fitorder = 3;
[exo_data] = ref_big_pulses(ephys_data,exo_data,fitorder);


%% Raster plot with a line for each spike
figure
tplot = [100 500]./fs;
m = 1;
for n = 1:size(phy_dat,1)    
    if phy_dat(n,1) < 33
        temp = find(spikes(:,2)==phy_dat(n,2));
        plotdat = spikes(temp,:);
        scatter1 = scatter(plotdat(:,1),n.*ones(size(temp)),'|','MarkerEdgeColor',[0.3 0.3 0.3],...
          'MarkerFaceColor',[0.3 0.3 0.3]);
        hold on
    end
end

hold on
plot(exo_data(:,32).*fs,dzone_trig.*20,'r')
plot(exo_data(:,32).*fs,leftsound.*20,'k')
plot(exo_data(:,32).*fs,rightsound.*20,'k')
plot(exo_data(:,32).*fs,milk.*20,'Color',[0.4940 0.1840 0.5560])
xlim([0 exo_data(end,32).*fs])
title('Probe 2 Spike Raster')

figure
tplot = [100 500]./fs;
m = 1;
for n = 1:size(phy_dat,1)    
    if phy_dat(n,1) > 32
        temp = find(spikes(:,2)==phy_dat(n,2));
        plotdat = spikes(temp,:);
        scatter2 = scatter(plotdat(:,1),n.*ones(size(temp)),'|','MarkerEdgeColor',[0.3 0.3 0.3],...
          'MarkerFaceColor',[0.3 0.3 0.3]);
        hold on
    end

end

hold on
plot(exo_data(:,32).*fs,dzone_trig.*32,'r')
plot(exo_data(:,32).*fs,leftsound.*32,'k')
plot(exo_data(:,32).*fs,rightsound.*32,'k')
plot(exo_data(:,32).*fs,milk.*32,'Color',[0.4940 0.1840 0.5560])
xlim([0 exo_data(end,32).*fs])
title('Probe 1 Spike Raster')

%% Evaluate spike amplitudes 

clear store

ch_plot = phy_dat(:,1);
clust_plot = phy_dat(:,2);

for n = 1:size(ch_plot,1)
    ch = ch_plot(n,1);    
    clust = clust_plot(n,1);
    M = find(spikes(:,2)==clust);
    for m = start:start+50
        st2p = spikes(M(m),1);
        store{n,1}(:,m-start+1) = ephys_filt(st2p-50:st2p+50,ch);
    end
    temp = mean(store{n,1}(:,:),2); % mean waveform
    clust_plot(n,2) = max(temp) - min(temp);    

end

figure
M = find(ch_plot<33);
scatter(2.*ones(size(M,1),1),clust_plot(M,2),'x')
hold on
M = find(ch_plot>32);
scatter(ones(size(M,1),1),clust_plot(M,2),'x')
xlim([0 3])
ylim([0 410])
xlabel('Probe number')
ylabel('spike amplitude (uV)')

%% Evaluate noise levels
% create Noise array
Noise = NaN(size(ephys_filt));
for n = 1:size(ch_plot,1)
    ch = ch_plot(n,1);
    Noise(:,ch) = ephys_filt(:,ch);
end
% remove spikes from Noise array
for n = 1:size(ch_plot,1)
    ch = ch_plot(n,1);    
    clust = clust_plot(n,1);
    M = find(spikes(:,2)==clust);
    for m = 1:size(M,1)
        st2p = spikes(M(m),1);
        Noise(st2p-25:st2p+25,ch) = NaN; % remove spikes
    end   
end

% resize and align Noise array to exo data
tstart = ceil(exo_data(clip(1),32)).*fs;
tend = ceil(exo_data(clip(2),32)).*fs;

Noise([1:1:tstart-1,tend:1:end],:) = [];

Noise_rs = imresize(Noise,[(clip(2)-clip(1)+1),64]);
vel_rs = vel_mouse(clip(1):clip(2),1);
force_rs = Xforce(clip(1):clip(2),1);

%% downsample data for plotting noise vs vel
[Nvel,edgesvel,binvel] = histcounts(vel_rs,[0:0.01:0.12]);

Noise_rs_std = 3.*std(Noise_rs,[],2,'omitnan');  % 3std of noise across active channels

% remove reward dispensing (noisy)
Noise_rs_std_nm = Noise_rs_std;
M = find(milk(clip(1):clip(2),1)==1);
Noise_rs_std_nm(M,:) = NaN;

Noise_rs_std_m = Noise_rs_std;
M = find(milk(clip(1):clip(2),1)==0);
Noise_rs_std_m(M,:) = NaN;

figure
boxplot(Noise_rs_std_nm,binvel,'PlotStyle','compact','symbol','.');
ylim([-0.01 0.1])
ylabel('Noise amplitude (uV)')
xlabel('Velocity bin [0:0.01:0.12] (m/s)')

figure
scat1 = scatter(vel_rs,Noise_rs_std_nm,'.');
% hold on
% scat1 = scatter(vel_rs,Noise_rs_std_m,'.');
xlim([0 0.12])
ylim([-0.01 0.1])
alpha(scat1,.2)
ylabel('Noise amplitude (uV)')
xlabel('Velocity (m/s)')
legend('data excl. reward dispensing','reward dispensing') % reward port was not grounded

%% downsample noise data for plotting vs force
[NfX,edgesfX,binfX] = histcounts(force_rs,[-0.8:0.2:0.8]);

Noise_rs_std = 3.*std(Noise_rs,[],2,'omitnan');  % 3std of noise across active channels

% remove reward dispensing (noisy)
Noise_rs_std_nm = Noise_rs_std;
M = find(milk(clip(1):clip(2),1)==1);
Noise_rs_std_nm(M,:) = NaN;

Noise_rs_std_m = Noise_rs_std;
M = find(milk(clip(1):clip(2),1)==0);
Noise_rs_std_m(M,:) = NaN;

% Noise_rs_std = Noise_rs_std.*milk(clip(1):clip(2),1);

figure
boxplot(Noise_rs_std_nm,binfX,'PlotStyle','compact','symbol','.');
ylim([-0.01 0.1])
ylabel('Noise amplitude (uV)')
xlabel('Force bin [-0.8:0.2:0.8] (N)')

figure
scat1 = scatter(force_rs,Noise_rs_std_nm,'.');
% hold on
% scat1 = scatter(force_rs,Noise_rs_std_m,'.');
ylim([-0.01 0.1])
alpha(scat1,.2)
ylabel('Noise amplitude (uV)')
xlabel('Force (N)')
legend('data excl. reward dispensing','reward dispensing') % reward port was not grounded


%% BINARY SPIKE MATRIX (For Mouse 1, 2, 3):
% clear spike_matrix_Left spike_matrix_Right temp plotspikes
% % generate a binary matrix same size as ephys data with spike times as 1's
% 
% temp = find(phy_dat(:,1) < 33);
% spike_matrix_Left = zeros(size(ephys_filt,1),size(temp,1));
% temp = find(phy_dat(:,1) > 32);
% spike_matrix_Right = zeros(size(ephys_filt,1),size(temp,1));
% 
% j = 1; k = 1;
% for n = 1:size(phy_dat,1)
%     temp = find(spikes(:,2)==phy_dat(n,2));
%     plotspikes = spikes(temp,:);
%     if phy_dat(n,1) < 33
%         for m = 1:size(plotspikes,1)
%             st2p = plotspikes(m,1);
%             spike_matrix_Left(st2p,j) = 1;    
%         end
%         j = j+1;
%     else
%         for m = 1:size(plotspikes,1)
%             st2p = plotspikes(m,1);
%             spike_matrix_Right(st2p,k) = 1;    
%         end
%         k = k+1;
%     end
% end
% 
% figure
% scatter(clust_plot(1:size(spike_matrix_Right,2),2),sum(spike_matrix_Right,1))
% hold on 
% scatter(clust_plot(size(spike_matrix_Right,2)+1:end,2),sum(spike_matrix_Left,1))
% ylim([10 1e5])
% xlim([0 420])
% xlabel('cluster spike amplitude (uV)')
% ylabel('cluster number of spikes')
% legend('Probe 2','Probe 1')

%% BINARY SPIKE MATRIX (For Mouse 4):
clear spike_matrix_Left spike_matrix_Right temp plotspikes
% generate a binary matrix same size as ephys data with spike times as 1's

temp = find(phy_dat(:,1) > 32);
spike_matrix_Left = zeros(size(ephys_filt,1),size(temp,1));
temp = find(phy_dat(:,1) < 33);
spike_matrix_Right = zeros(size(ephys_filt,1),size(temp,1));

j = 1; k = 1;
for n = 1:size(phy_dat,1)
    temp = find(spikes(:,2)==phy_dat(n,2));
    plotspikes = spikes(temp,:);
    if phy_dat(n,1) < 33
        for m = 1:size(plotspikes,1)
            st2p = plotspikes(m,1);
            spike_matrix_Right(st2p,j) = 1;    
        end
        j = j+1;
    else
        for m = 1:size(plotspikes,1)
            st2p = plotspikes(m,1);
            spike_matrix_Left(st2p,k) = 1;    
        end
        k = k+1;
    end
end

figure
scatter(clust_plot(1:size(spike_matrix_Right,2),2),sum(spike_matrix_Right,1),'x')
hold on 
scatter(clust_plot(size(spike_matrix_Right,2)+1:end,2),sum(spike_matrix_Left,1),'x')
ylim([10 1e5])
xlim([0 420])
xlabel('cluster spike amplitude (uV)')
ylabel('cluster number of spikes')
legend('Probe 2','Probe 1')

%% Calculate spike rate 
% convert spike times to spike rates
clear spike_rate_Left spike_rate_Right
freq = fs; % sample rate of ephys data in Hz
win_s = 0.05; %window length in seconds; NB 1/length = min frequency analyzed
step_res = 0.02; %step size that window scans at in seconds

[spike_rate_Left,spike_rate_t] = spiketime2spikerate(spike_matrix_Left,freq,win_s,step_res);

[spike_rate_Right,spike_rate_t] = spiketime2spikerate(spike_matrix_Right,freq,win_s,step_res);

%% Guassian filter spike rates
clear GW spike_rate_Left_GW spike_rate_Right_GW
% smooth spike rate data using convolution with a Guassian waveform;
GW = gausswin(13,3);        % Gaussian window for conv
trim = floor(size(GW,1)/2); % trim size 

% Left probe
for n = 1:size(spike_rate_Left,1)
    spike_rate_Left_GW(n,:) = conv(GW./sum(GW),spike_rate_Left(n,:));
end

spike_rate_Left_GW(:,[1:trim,end-trim+1:end]) = [];

% Right probe
for n = 1:size(spike_rate_Right,1)
    spike_rate_Right_GW(n,:) = conv(GW./sum(GW),spike_rate_Right(n,:));
end

spike_rate_Right_GW(:,[1:trim,end-trim+1:end]) = [];

%% Collate variables for predictor matrix 

% collate some behavioral variables to save for use with RRRegression
Behav_vars = [XYpos_global, Yawpos_global, ...          % (1:3) position
              vel_mouse(:,1:2), vel_mouse_yaw,...       % (4:6) velocity
              accel_mouse(:,1:2),accel_mouse_yaw, ...   % (7:9) acceleration
              Xforce, Yforce, yawforce,...              % (10:12) force
              leftsound, rightsound, milksound, milk,...% (13:16) sounds and reward
              dzone_trig];                              % (17) decision zone

Behav_vars = Behav_vars(clip(1):clip(2),:);
          
%% Clip spike_rate matrices to match Behav_vars matrix times
cliptimes = [exo_data(clip(1),32), exo_data(clip(2),32)];
[~,M1] = mink((abs(spike_rate_t-cliptimes(1))),1); % find nearest time to cliptime 1
[~,M2] = mink((abs(spike_rate_t-cliptimes(2))),1); % find nearest time to cliptime 2

keep = [M1:M2];
throw = [1:1:length(spike_rate_t)]';
throw(keep,:) = [];

spike_rate_t(throw,:) = [];
spike_rate_Left_GW(throw,:) = [];
spike_rate_Right_GW(throw,:) = [];

%% Finally, resize Behav_vars
clear Behav_vars_rs
Behav_vars_rs(:,1:13) = imresize(Behav_vars(:,1:13),[size(spike_rate_t,1),13]);
Behav_vars_rs(:,14:17) = imresize(Behav_vars(:,14:17),[size(spike_rate_t,1),4],'nearest');

d_rs = d-clip(1)+1;
%% write video of raw data spikes

% vr = VideoWriter('Spikes_M837_221010.avi','Motion JPEG AVI'); %,'Uncompressed AVI');
% vr.FrameRate = 30;
% open(vr)
% 
% 
% figure
% x0 = 2400;
% y0 = -300;
% width = 1500;
% height = 1300;
% set(gcf,'position',[x0,y0,width,height])
% set(gcf,'color','w');
% 
% tstart = ceil(exo_data(clip(1),32).*fs);
% tend = ceil(exo_data(clip(2),32).*fs);
% tstep = fs/vr.FrameRate;
% trange = 60000;
% 
% phy_uniquech = unique(phy_dat(:,1));
% 
% probe1 = sum(phy_uniquech<33);
% probe2 = sum(phy_uniquech>32);
% spacearray = [[1:1:probe1],[probe1+3:1:probe1 + probe2+3-1]].*300;
% 
% for n = tstart:tstep:tend
%    
%     plot(ephys_data(n-trange/2:n+trange/2,1),ephys_filt(n-trange/2:n+trange/2,phy_uniquech)+spacearray,'Color','k')
%     ylim([0 max(spacearray)+200])
%     axis off
%     xlim([ephys_data(n-trange/2,1) ephys_data(n+trange/2,1)])
%     timestamp = n/fs;
%     title(num2str(timestamp))
%     framein = getframe(gcf);
%     writeVideo(vr,framein);
%     pause(0.05)
% end
% 
% close(vr)

%% Write video of mean and real-time spike waveforms 

% vr = VideoWriter('Waveforms_M837_221010.avi','Motion JPEG AVI'); %,'Uncompressed AVI');
% vr.FrameRate = 30;
% open(vr)
% 
% tstart = ceil(exo_data(clip(1),32).*fs);
% tend = ceil(exo_data(clip(2),32).*fs);
% tstep = ceil(fs/vr.FrameRate);
% trange = 100/fs;
% t = 0:1/fs:100/fs;    
% 
% ch_plot = phy_dat(:,1);
% clust_plot = phy_dat(:,2);
% 
% figure
% x0 = 2400;
% y0 = -300;
% width = 1500;
% height = 1300;
% set(gcf,'position',[x0,y0,width,height])
% set(gcf,'color','w');
% 
% for m = 1:24
%     subplot(4,6,m)
%     xlim([0 0.0033])
%     ylim([-300 100])
%     axis off
% end
% 
% for n = tstart:tstep:tend
%     for m = 1:size(clust_plot,1)
%         ch = ch_plot(m,1);
%         clust = clust_plot(m,1);
%         hold off
%         if ch < 32
%             subplot(4,6,m)
%             plot(t,meanstore(:,m),'Color',[0 0.4470 0.7410],'LineWidth',2)
%         else
%             subplot(4,6,m)
%             plot(t,meanstore(:,m),'Color',[0.3010 0.7450 0.9330],'LineWidth',2)            
%         end
%         xlim([0 0.0033])
%         ylim([-300 100])
%         axis off
%         hold on
%         plot24waveforms(spikes,ch,clust,t,ephys_filt,[0.9,0.9,0.9],n-6*tstep,n-4*tstep,m)
%         plot24waveforms(spikes,ch,clust,t,ephys_filt,[0.6,0.6,0.6],n-4*tstep,n-2*tstep,m)
%         plot24waveforms(spikes,ch,clust,t,ephys_filt,[0.3,0.3,0.3],n-2*tstep,n,m)
%         plot24waveforms(spikes,ch,clust,t,ephys_filt,[0,0,0],n,n+tstep,m)
%         xlim([0 0.0033])
%         ylim([-300 100])
%     end
%     framein = getframe(gcf);
%     writeVideo(vr,framein);
%     pause(0.05)
% end
% 
% close(vr)

%% write video of spike raster

% vr = VideoWriter('SpikeRaster_M837_221010_v3.avi','Motion JPEG AVI'); %,'Uncompressed AVI');
% vr.FrameRate = 30;
% open(vr)
% 
% figure
% x0 = 2400;
% y0 = -300;
% width = 750;
% height = 750;
% set(gcf,'position',[x0,y0,width,height])
% set(gcf,'color','w');
% 
% tstart = ceil(exo_data(clip(1),32).*fs);
% tend = ceil(exo_data(clip(2),32).*fs);
% tstep = fs/vr.FrameRate;
% % tstep = 1000;
% trange = 120000;
% 
% for n = tstart:tstep:tend
%     hold off
%     for m = 1:size(phy_dat,1)
%         clust = phy_dat(m,2);
%         M1 = find(spikes(:,2)==clust);
%         M2 = find(spikes(:,1)>n-trange/2);
%         M3 = find(spikes(:,1)<n+trange/2);
%         M4 = intersect(intersect(M1,M2),M3);
%         if size(M4,1) > 0
%             if phy_dat(m,1) < 33
%                 scatter(spikes(M4,1),m.*ones(size(M4,1),1),'|','MarkerEdgeColor',[0 0.4470 0.7410],...
%                 'MarkerFaceColor',[0 0.4470 0.7410],'LineWidth',1);
%                 hold on
%                 xlim([ephys_data(n-trange/2,1) ephys_data(n+trange/2,1)].*fs)
%                 ylim([0 size(phy_dat,1)+1])
%                 axis off
%             elseif phy_dat(m,1) > 32
%                 scatter(spikes(M4,1),m.*ones(size(M4,1),1),'|','MarkerEdgeColor',[0.3010 0.7450 0.9330],...
%                 'MarkerFaceColor',[0.3010 0.7450 0.9330],'LineWidth',1);
%                 hold on
%                 xlim([ephys_data(n-trange/2,1) ephys_data(n+trange/2,1)].*fs)
%                 ylim([0 size(phy_dat,1)+1])
%                 axis off
%             end
%         end
%     end
%     timestamp = n/fs;
%     title(num2str(timestamp))
%     framein = getframe(gcf);
%     writeVideo(vr,framein);
%     pause(0.01)
% end
%     
% close(vr)



