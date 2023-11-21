%% MAIN SCRIPT TO DO STAT ANALYSIS ON CELL DISTRIBUTIONS
% Authors: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% This script will:
% 1. Scale and align the imaging window to CCF boundaries
% 2. Band pass filter fluorescence traces, and then remove noisy traces
%    using some exclusion criteria
% 3. Map each cell location to the CCF region
% 4. Produce some stats on the cell locations and DF/F traces
% 5. Load exoskeleton data and generate a predictor matrix using binned
%    position around the 8maze arena
% 6. Do a simple linear regression on the predictor matrix and DF/F traces
%    to identify location encoding cell responses; and then generate some 
%    plots to visualise these reponses
% 7. ROI analysis of DF/F traces for video production


clear all

%% Load data
%NB: to process data, comment in the 5 lines (t..., transform..., 
% load..., load..., exodata...) from the mouse you want to analyze: 

addpath(strcat(pwd,'\Data for analysis'));

% Mouse 1 (982 230121)
t = Tiff('Mouse982_230121.tiff','r');
transform = [-200, 0, 2];     % move image [(+)up/(-)down, (+)left/(-)right, rotate] 
load('Fall_982_230121.mat')
load 'Mouse982_8maze_23_1_21.mat'
exodata = Mouse982_8maze_23_1_21;

% Mouse 2 (1050 230114)
% t = Tiff('Mouse1050_230114.tiff','r');
% transform = [0, -150, -1];     % move image [(+)up/(-)down, (+)left/(-)right, rotate] 
% load('Fall_1050_230114.mat')
% load 'Mouse1050_8maze_23_1_14.mat'
% exodata = Mouse1050_8maze_23_1_14;

% Mouse 3 (1229 230308)
% t = Tiff('Mouse1229_230308.tiff','r');
% transform = [0, 350, 0];     % move image [(+)up/(-)down, (+)left/(-)right, rotate] 
% load('Fall_1229_230308.mat')
% load 'Mouse1229_8maze_23_3_8.mat'        
% exodata = Mouse1229_8maze_23_3_8;

% Mouse 4 (1267 230308)
% t = Tiff('Mouse1267_230308.tiff','r');
% transform = [0, 660, -1];     % move image [(+)up/(-)down, (+)left/(-)right, rotate] 
% load('Fall_1267_230308.mat')
% load 'Mouse1267_8maze_23_3_8.mat'
% exodata = Mouse1267_8maze_23_3_8;  

%% load CCF functional boundaries
[CCF, meta] = nrrdread('top.nrrd');
CCF(:,571:end) = fliplr(CCF(:,1:570));
BW = edge(CCF,'sobel',0.0000001);
BW = BW.*1; % change from logical to double
BW = uint8(BW.*2^16);

%% load example image from mesoscope, resize and align CCF boundaries to image
imageData = read(t);
imageData = imrotate(imageData,-90);
% figure
% imshow(imageData)
% title('raw image')

% NB: match_CCF_2_Image.m keeps CCF aligned with vertical, 
% whereas match_CCF_2_Image_alt.m keeps image aligned. 
[imagepad,BWimtran] = match_CCF_2_Image_alt(BW,imageData,transform);

CCFoverIM = imagepad + BWimtran;

figure
imagesc(CCFoverIM)
title('Aligned and scaled CCF boundaries over image')

% resize and align CCF regions matrix (color coded regions)
[~,CCFimtran] = match_CCF_2_Image_alt(CCF,imageData,transform);

% figure
% imagesc(CCFimtran)
% title('Aligned and scaled CCF matrix')

%% Filter cell data 

neu_subtracted = F - 0.7*Fneu;
d = designfilt('bandpassiir','FilterOrder',4,'PassbandFrequency1',0.05,'PassbandFrequency2',5,'SampleRate',15);
mean1 = mean(squeeze(neu_subtracted(:,:)),2);
tmp = filtfilt(d,double(squeeze(neu_subtracted(:,:)')));
tmp=tmp';
dff_Data = tmp./mean1;
dff_Data=detrend(dff_Data',2);
dff_Data=dff_Data';

%% remove overly noisy and mishaped cells 
% genplot = 1 plots DF/F traces for all cells remaining after exclusion
% criteria in Remove_noisy_cells.m
genplot = 0;  
[iscell] = Remove_noisy_cells(dff_Data,iscell,genplot,stat);

%% Histograms of npixels and aspect ratio 
clear dat_npix dat_aspect
cellind = find(iscell(:,1)==1);
m = 1;
for n = 1:size(cellind,1)
    k = cellind(m,1);
    dat_npix(m,1) = double(stat{1,k}.npix);
    dat_aspect(m,1) = double(stat{1,k}.aspect_ratio); 
    m = m+1;
end
% figure
% subplot(1,2,1)
% histogram(2.*(dat_npix./pi).^0.5)
% subplot(1,2,2)
% histogram(dat_aspect)

figure
subplot(1,2,1)
boxplot(3.45*2.*(dat_npix./pi).^0.5,'PlotStyle','compact','Symbol','o')
ylim([0 100])
ylabel('diameter (um)')
subplot(1,2,2)
boxplot(dat_aspect,'PlotStyle','compact','Symbol','o')
ylim([0.9 1.5])
ylabel('aspect ratio')

%% manual curation, if necessary, to remove noisy cells that slipped through 
% e.g.: for Mouse 3 (1229 230308)
% iscell(355,1) = 0;

%% cell span and locations in image
image_cells = zeros(2056,2464);

for n = 1:length(iscell)
    if(iscell(n,1)) == 1 
        pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]'];       
        for m = 1:length(pixels)
            image_cells(pixels(m,2),pixels(m,1)) = 1;
        end
        clear pixels
    end
end

image_cells = imrotate(image_cells,-90);

figure
imagesc(image_cells)
title('all cells')
colormap([1 1 1; 1 0 0])

[image_cells_col,~] = match_CCF_2_Image_alt(CCF,image_cells,transform);

CCF_col_cells = image_cells_col.*double(CCFimtran);

figure
imagesc(CCF_col_cells + double(BWimtran))
title('all cells - color coded CCF region')

%% mean location of each cell in image

image_cells_mean = zeros(2056,2464);

for n = 1:length(iscell)
    if(iscell(n,1)) == 1 
        pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]']; 
        pixel_mean = round(mean(pixels));
        image_cells_mean(pixel_mean(1,2),pixel_mean(1,1)) = 1;
        clear pixels
    end
end

image_cells_mean = imrotate(image_cells_mean,-90);

% figure
% imagesc(image_cells_mean)

%% resize and align cells image to CCF
[image_cells_pad,~,szdiff] = match_CCF_2_Image_alt(CCF,image_cells_mean,transform);
%mask CCF with cell mean locations
CCF_masked_cells = image_cells_pad.*double(CCFimtran);
% unique colors (regions) in CCF
CCF_regions = unique(double(CCF));
CCF_regions(1,:) = [];

%% collect stats
clear cell_stats
for n = 1:size(CCF_regions,1)
    
    [M,I] = find(CCF_masked_cells == CCF_regions(n,1));
    cell_stats{n,2} = [M,I];
    cell_stats{n,1} = CCF_regions(n,1);

end

%% cell by cell analysis to allow for activity mapping

CCF_reg = double(CCFimtran);

tempint = zeros(2464,2056);

for n = 1:length(iscell)
    if(iscell(n,1)) == 1 
        pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]']; 
        pixel_mean = [round(mean(pixels))];
        pixel_m_reg = [pixel_mean(1,1), 2056+1-pixel_mean(1,2)];
%         temp(pixel_m_reg(1,1),pixel_m_reg(1,2)) = 1;
        pixel_m_reg = pixel_m_reg + szdiff;
        iscell(n,3) = CCF_reg(pixel_m_reg(1,1),pixel_m_reg(1,2));
    end
    clear pixel_mean
end

% figure
% imagesc(temp)
 
%% Stats figure 1 = DFF distribution

dff_Data_cells = dff_Data;

for n = size(iscell,1):-1:1
    if iscell(n,1) == 0
        dff_Data_cells(n,:) = [];
    end
end

maxdff = max(dff_Data_cells,[],2);

figure
hall = histogram(maxdff,30);
xlabel('DF/F')
ylabel('cell count')
title('all cells DF/F')
edges = hall.BinEdges;

figure
[~,~] = histoplot(hall,1);
xlabel('DF/F')
ylabel('cell count')
title('all cells DF/F')

%% Regional analysis 

% M1
k = 578;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_M1] = region_dffmax(k,dff_Data,iscell);
end

% M2
k = 584;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_M2] = region_dffmax(k,dff_Data,iscell);
end

% RSp1
k = 872;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_RSp1] = region_dffmax(k,dff_Data,iscell);
end

% RSp2
k = 866;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_RSp2] = region_dffmax(k,dff_Data,iscell);
end

% SS_BF
k = 970;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_SS_BF] = region_dffmax(k,dff_Data,iscell);
end

% SS maybe lower limb
k = 977;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_SSa] = region_dffmax(k,dff_Data,iscell);
end

% SS maybe trunk
k = 998;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_SSb] = region_dffmax(k,dff_Data,iscell);
end

% SS maybe upper limb
k = 1005;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_SSc] = region_dffmax(k,dff_Data,iscell);
end

% SS more upper limb?
k = 1012;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_SSd] = region_dffmax(k,dff_Data,iscell);
end

% Vam
k = 1132;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_Vam] = region_dffmax(k,dff_Data,iscell);
end

% V1
k = 1153;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_V1] = region_dffmax(k,dff_Data,iscell);
end

% Vpm
k = 1167;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_Vpm] = region_dffmax(k,dff_Data,iscell);
end

% PPA1
k = 1207;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_PPA1] = region_dffmax(k,dff_Data,iscell);
end

% PPA2
k = 1228;
temp = find(iscell(:,3)==k);
if sum(temp,1)
    [maxdff_PPA2] = region_dffmax(k,dff_Data,iscell);
end
%% figures
% This section throws an error if some locations didn't have cells. 
% If this occurs, you can comment out the line with an error. 

maxdff_M = [maxdff_M1; maxdff_M2];
maxdff_SS = [maxdff_SS_BF;maxdff_SSa; maxdff_SSb; maxdff_SSc; maxdff_SSd];
maxdff_V = [maxdff_V1;maxdff_Vam;maxdff_Vpm];
maxdff_PPA = [maxdff_PPA1;maxdff_PPA2];
maxdff_RSp = [maxdff_RSp1; maxdff_RSp2];
% maxdff_SS_BF = [maxdff_SS_BF];

figure
hold on
h_M = histogram(maxdff_M,edges);
h_SS = histogram(maxdff_SS,edges);
h_V = histogram(maxdff_V,edges);
h_PPA = histogram(maxdff_PPA,edges);
h_RSp = histogram(maxdff_RSp,edges);
% h_SSBF = histogram(maxdff_SS_BF,edges);
legend('M','SS','V','PPA','RSp','BF')

figure
hold on
[~,~] = histoplot(h_M,1);
[~,~] = histoplot(h_SS,1);
[~,~] = histoplot(h_V,1);
[~,~] = histoplot(h_PPA,1);
[~,~] = histoplot(h_RSp,1);
legend('M','SS','V','PPA','RSp','BF')
xlabel('DF/F')
ylabel('cell count')

% figure
% hold on
% plot(h_M.BinEdges(1:end-1)+diff(h_M.BinEdges),h_M.BinCounts)
% plot(h_SS.BinEdges(1:end-1)+diff(h_SS.BinEdges),h_SS.BinCounts)
% plot(h_V.BinEdges(1:end-1)+diff(h_V.BinEdges),h_V.BinCounts)
% plot(h_PPA.BinEdges(1:end-1)+diff(h_PPA.BinEdges),h_PPA.BinCounts)
% plot(h_RSp.BinEdges(1:end-1)+diff(h_RSp.BinEdges),h_RSp.BinCounts)
% % plot(h_SSBF.BinEdges(1:end-1)+diff(h_SSBF.BinEdges),h_SSBF.BinCounts)
% legend('M','SS','V','PPA','RSp') %,'BF')
% xlabel('DF/F')
% ylabel('cell count')


%% more stats

x1 = maxdff_M;
x2 = maxdff_SS;
x3 = maxdff_RSp;
x4 = maxdff_V;
x5 = maxdff_PPA;
x = [x1;x2;x3;x4;x5];

g1 = repmat({'M'},size(maxdff_M,1),1);
g2 = repmat({'SS'},size(maxdff_SS,1),1);
g3 = repmat({'RSp'},size(maxdff_RSp,1),1);
g4 = repmat({'V'},size(maxdff_V,1),1);
g5 = repmat({'PPA'},size(maxdff_PPA,1),1);
g = [g1;g2;g3;g4;g5];

figure
boxplot(x,g,'PlotStyle','compact')
xlabel('Region')
ylabel('DF/F')
title('Cell DFFs by Region')

figure
plot([size(x1,1),size(x2,1),size(x3,1),size(x4,1),size(x5,1)]);
title('Cell numbers by Region')

%%  Exoskeleton data 
% input and output are the same variable so can only run this section once
% if you hit run twice, you'll get an error. You can reload the data at the
% top of the script. 
sz = size(exodata);
if sz(1) < sz(2)
    exodata = exodata';
end

tincr = 0.01;   % (s)
[exodata] = clip_exo_using_pulse(exodata);  
legend('mouse x position','mouse y position','recording start and end')
xlabel('time (acquisition units = 10ms)')
ylabel('position (m)')
title('aligning exo data to meso data')

%%  Extract some useful parameters from exo data 
Xforce = exodata(:,18);  %(N)
Yforce = exodata(:,19);  %(N)
yawforce = exodata(:,21);  %(Nm)
time = [0:tincr:tincr*(size(Xforce,1)-1)]';   % (s)

XYpos_global = exodata(:,5:6);  %(m)
delXYpos_global = [(XYpos_global(2:end,:) - XYpos_global(1:end-1,:)); [0,0]];

delXY_admittance = exodata(:,9:10);   % (m)
delYaw_admittance = exodata(:,12);   % (m)

YAWpos = exodata(:,8);  %(m)  
delpos_mouseyaw = [(YAWpos(2:end,:) - YAWpos(1:end-1,:)); [0]];

% this step will fail for data acquired before 22/3/23; in which case
% comment out. 
c_Dzonex = exodata(:,22);
c_Dzoney = exodata(:,23);
c_Dzoneyaw = exodata(:,24);
m_Dzonex = exodata(:,25);
m_Dzoney = exodata(:,26);
m_Dzoneyaw = exodata(:,27);

% filter 
for n = 1:size(delXYpos_global,1)
    
     delpos_mousevec(:,n) = Rotzfun(YAWpos(n,:))'*[delXYpos_global(n,:),0]';
    
end
delpos_mousevec = delpos_mousevec';
vel_mouse = delpos_mousevec./tincr;
vel_mouse_yaw = delpos_mouseyaw./tincr;

% smooth signals
vel_mouse = medfilt1(vel_mouse,13);
vel_mouse = movmean(vel_mouse,5);
vel_mouse = medfilt1(vel_mouse,13);
vel_mouse = movmean(vel_mouse,5);

vel_mouse_yaw = medfilt1(vel_mouse_yaw,13);
vel_mouse_yaw = movmean(vel_mouse_yaw,5);
vel_mouse_yaw = medfilt1(vel_mouse_yaw,13);
vel_mouse_yaw = movmean(vel_mouse_yaw,5);

accel_mouse = [[0,0,0]; (vel_mouse(2:end,:) - vel_mouse(1:end-1,:))]./tincr;
accel_mouse_yaw = [[0]; (vel_mouse_yaw(2:end,:) - vel_mouse_yaw(1:end-1,:))]./tincr;


clear dats
clear storedats
dats = zeros(size(XYpos_global,1),1);
for nn = 1:size(XYpos_global,1)
    if XYpos_global(nn,1) < 0.045 && XYpos_global(nn,1) > -0.045
        if XYpos_global(nn,2) < 0.1 && XYpos_global(nn,2) > -0.03
            dats(nn,1) = nn;
        end
    end
end

n = 1;
for nn = 2:size(dats,1)
    if dats(nn,1) ~= 0 && dats(nn-1) == 0
        storedats(n,1) = dats(nn,1);
    elseif dats(nn,1) == 0 && dats(nn-1) ~= 0
        storedats(n,2) = dats(nn-1,1);
        n = n+1;
    end
end

if storedats(1,1) == 0
    storedats(1,1) = 1;
elseif storedats(end,2) == 0
    storedats(end,:) = [];
end


sz1 = 5;
sz2 = ceil(size(storedats,1)/sz1);

d = storedats;
%
%% forces and paths through the turning zone
% 
% clear 'transyaw'
% clear 'transy'
% 
% for n = 1:size(delXYpos_global,1)
% 
%      transyaw(:,n) = Rotzfun(YAWpos(n,:))*[0,yawforce(n,:),0]';
%      transy(:,n) = Rotzfun(YAWpos(n,:))*[0,Yforce(n,:),0]';
%      
% end
% 
% transyaw = transyaw';
% transy = transy';
% 
% % forces and locomotion in Dzone
% figure
% for n = 1:size(d,1)
% 	subplot(sz1,sz2,n)
%   
%     hold on
%     plot(10.*XYpos_global(d(n,1):d(n,2),1),10.*XYpos_global(d(n,1):d(n,2),2))
%     plot(10.*XYpos_global(d(n,1):d(n,2),1)+10.*transyaw(d(n,1):d(n,2),1),10.*XYpos_global(d(n,1):d(n,2),2)+10.*transyaw(d(n,1):d(n,2),2))
%     plot(10.*XYpos_global(d(n,1):d(n,2),1)+0.1*transy(d(n,1):d(n,2),1),10.*XYpos_global(d(n,1):d(n,2),2)+0.1*transy(d(n,1):d(n,2),2))
%     if n ==size(d,1)
%         xlabel('yforce (N/10), yawtorque (Nm*10) position (m/10)')
%         ylabel('yforce (N/10), yawtorque (Nm*10) position (m/10)')
% %         title(strcat(Mouse,' forces during locomotion'))
%         legend('xy position','yaw torque','y force')
%     end
%     title(strcat('m = [',num2str(m_Dzonex(d(n,1))),',',num2str(m_Dzoney(d(n,1))),',',num2str(m_Dzoneyaw(d(n,1))),'], ',...
%         'c = [',num2str(c_Dzonex(d(n,1))),',',num2str(c_Dzoney(d(n,1))),',',num2str(c_Dzoneyaw(d(n,1))),']'));
%     grid on
% 
% end

%% logic arrays for some 8maze behavioral variables
Logi_dzone = 0.*XYpos_global(:,1);

for n = 1:size(d,1)
    Logi_dzone(d(n,1):d(n,2)) = 1;
end

Logi_loop = abs(Logi_dzone - 1);

Logi_still = double(vel_mouse(:,1)<0.001);

Logi_move = abs(Logi_still - 1);

Logi_Yaw_Lbin = 0.*Logi_loop;
Logi_Yaw_Rbin = 0.*Logi_loop;

for n = 1:2:size(d,1)-1
    Logi_Yaw_Lbin(d(n,2):d(n+1,1)) = 1;
end
% Logi_Yaw_Lbin = Logi_Yaw_Lbin.*Logi_loop;
Logi_Yaw_Lbin = Logi_Yaw_Lbin.*Logi_loop.*Logi_move;

for n = 2:2:size(d,1)-1
    Logi_Yaw_Rbin(d(n,2):d(n+1,1)) = 1;
end
% Logi_Yaw_Rbin = Logi_Yaw_Rbin.*Logi_loop;
Logi_Yaw_Rbin = Logi_Yaw_Rbin.*Logi_loop.*Logi_move;

% Logi_turnL = 0.*Logi_dzone;
Logi_turnL = 0.*Logi_dzone.*Logi_move;
% Logi_turnR = 0.*Logi_dzone;
Logi_turnR = 0.*Logi_dzone.*Logi_move;
for n = 1:2:size(d,1)
    Logi_turnL(d(n,1):d(n,2)) = 1;
end
for n = 2:2:size(d,1)
    Logi_turnR(d(n,1):d(n,2)) = 1;
end
%%
% plot(Logi_Yaw_L)
% hold on
% plot(Logi_Yaw_R)

edges_yaw = [pi/2:2*pi/40:2.5*pi];
Yaw_binned = discretize(YAWpos,edges_yaw);
Logi_Yaw_Lbin = Logi_Yaw_Lbin.*Yaw_binned;
Logi_Yaw_Rbin = Logi_Yaw_Rbin.*Yaw_binned;

edges_D = [-0.03:0.02:0.13];
Dzone_binned = discretize(XYpos_global(:,2),edges_D);
Logi_dzone_bin = Logi_dzone.*Dzone_binned;
Logi_turnL = Logi_turnL.*Dzone_binned;
Logi_turnR = Logi_turnR.*Dzone_binned;

% figure
% plot(Logi_Yaw_Lbin)
% hold on
% plot(Logi_Yaw_Rbin)
% hold on
% plot(Logi_turnL)
% hold on
% plot(Logi_turnR)
% title('position binning')
% legend('Left loop','Right loop','Turning zone left','Turning zone right')

TF = isnan(Logi_Yaw_Lbin);
Logi_Yaw_Lbin(TF,:) = 0;

TF = isnan(Logi_Yaw_Rbin);
Logi_Yaw_Rbin(TF,:) = 0;

TF = isnan(Logi_dzone_bin);
Logi_dzone_bin(TF,:) = 0;

TF = isnan(Logi_turnL);
Logi_turnL(TF,:) = 0;

TF = isnan(Logi_turnR);
Logi_turnR(TF,:) = 0;


%% resize (downsample) arrays to match camera data
Logi_dzone = imresize(Logi_dzone,[size(dff_Data,2),1],'nearest');
Logi_loop = imresize(Logi_loop,[size(dff_Data,2),1],'nearest');
Logi_still = imresize(Logi_still,[size(dff_Data,2),1],'nearest');
Logi_move = imresize(Logi_move,[size(dff_Data,2),1],'nearest');
Logi_Yaw_Lbin = imresize(Logi_Yaw_Lbin,[size(dff_Data,2),1],'nearest');
Logi_Yaw_Rbin = imresize(Logi_Yaw_Rbin,[size(dff_Data,2),1],'nearest');
Logi_dzone_bin = imresize(Logi_dzone_bin,[size(dff_Data,2),1],'nearest');
Logi_turnL = imresize(Logi_turnL,[size(dff_Data,2),1],'nearest');
Logi_turnR = imresize(Logi_turnR,[size(dff_Data,2),1],'nearest');

XY_pos_rs = imresize(XYpos_global,[size(dff_Data,2),2],'nearest');
vel_mouse_rs = imresize(vel_mouse(:,1:2),[size(dff_Data,2),2],'nearest');
vel_mouse_yaw_rs = imresize(vel_mouse_yaw,[size(dff_Data,2),1],'nearest');

%% predictor matrices for location encoding

Pred_YL = zeros(size(Logi_Yaw_Lbin,1),size(edges_yaw,2));

for n = 1:size(Logi_Yaw_Lbin,1)
    if Logi_Yaw_Lbin(n,1) == 0
    else
        index = Logi_Yaw_Lbin(n,1);
        Pred_YL(n,index) = 1;
    end
end

Pred_YR = zeros(size(Logi_Yaw_Rbin,1),size(edges_yaw,2));

for n = 1:size(Logi_Yaw_Rbin,1)
    if Logi_Yaw_Rbin(n,1) == 0
    else
        index = Logi_Yaw_Rbin(n,1);
        Pred_YR(n,index) = 1;
    end
end
Pred_YR = fliplr(Pred_YR); % flip because yaw decreases with progression around loop

Pred_D = zeros(size(Logi_dzone_bin,1),size(edges_D,2));

for n = 1:size(Logi_dzone_bin,1)
    if Logi_dzone_bin(n,1) == 0
    else
        index = Logi_dzone_bin(n,1);
        Pred_D(n,index) = 1;
    end
end

Pred_DL = zeros(size(Logi_dzone_bin,1),size(edges_D,2));

for n = 1:size(Logi_turnL,1)
    if Logi_turnL(n,1) == 0
    else
        index = Logi_turnL(n,1);
        Pred_DL(n,index) = 1;
    end
end

Pred_DR = zeros(size(Logi_dzone_bin,1),size(edges_D,2));

for n = 1:size(Logi_turnR,1)
    if Logi_turnR(n,1) == 0
    else
        index = Logi_turnR(n,1);
        Pred_DR(n,index) = 1;
    end
end


Pred = [Pred_DL,Pred_YL,Pred_DR,Pred_YR];

%% SPIKE ANALYSIS 

% first smooth spike data;
clear Ki Kfilt GW x spks_filt

GW = gausswin(15,3); %window for gaussian filtering, alpha = 1

for n = 1:size(spks,1)
    spks_filt(n,:) = conv(GW./sum(GW),spks(n,:));
end

trim = floor(size(GW,1)/2);

spks_filt(:,[1:trim,end-trim+1:end]) = [];


%% LOCATION ENCODING 
clear Keep_spks Keep_cell
% good cells
m = 1;
for n = 1:size(iscell,1)
    if iscell(n,1) == 1
        Keep_spks(m,:) = spks_filt(n,:);
        Keep_cell(m,1) = n;
        m = m + 1;
    end
end

%%  
spk_clip = size(F,2);

X = Pred(1:spk_clip,:);
% checkX = find(sum(X,1)==0);
% X(:,checkX) = [];
Predarray = [edges_D,edges_yaw,edges_D,edges_yaw];
% Predarray(:,checkX) = [];

Xsmall = find(sum(X,1)<5);
X(:,Xsmall) = 0;

Ys = Keep_spks(:,1:spk_clip)';

C = X\Ys;
% NB: zeros in the predictor matrix will produce a warning that it is rank
% deficient

figure
imagesc(C')
xlabel('predictor')
ylabel('cell')
title('Kernel raw')

%%
clear MAXC Cpeak Csorted Corder MAXC

MAXC = max(C,[],1);
Cnorm = C./MAXC;

figure
imagesc(Cnorm')
title('Kernel normalized')
xlabel('predictor')
ylabel('cell')

for n = 1:size(C,2)
    tf = isnan(Cnorm(1,n));
    if tf == 0
        [M,~] = find(Cnorm(:,n) == 1);
        Cpeak(1,n) = M;
    end
end

univals = unique(Cpeak);

for n = 1:size(univals,2)
    [~,M] = find(Cpeak(1,:) == univals(1,n));
    temp = Cnorm(:,M);
    if n == 1
        Csorted = temp;
        Cindex = M;
    else
        Csorted = [Csorted,temp];
        Cindex = [Cindex,M];
    end
end


figure
imagesc(abs(1-Csorted'))
colormap(bone)
title('Kernel sorted')
xlabel('predictor')
ylabel('cell')

figure
imagesc(Csorted')
title('Kernel sorted')
xlabel('predictor')
ylabel('cell')

%% can also sort without normalizing
% 
% MAXC = max(C,[],1);
% 
% for n = 1:size(C,2)
%     [M,~] = find(C(:,n) == MAXC(1,n));
%     Cpeak(1,n) = M;
% end
% 
% univals = unique(Cpeak);
% 
% for n = 1:size(univals,2)
%     [~,M] = find(Cpeak(1,:) == univals(1,n));
%     temp = C(:,M);
%     if n == 1
%         Csorted = temp;
%         Cindex = M;
%     else
%         Csorted = [Csorted,temp];
%         Cindex = [Cindex,M];
%     end
% end
% 
% figure
% imagesc(C')
% title('C')
% xlabel('predictor')
% ylabel('cell')
% 
% figure
% imagesc(Csorted')
% title('Csorted')
% xlabel('predictor')
% ylabel('cell')



%% SHOW LOCATION OF CELLS OF INTEREST
% Figures in paper generated from Mouse 1 (Mouse982_Date23_1_21)
% can select a range of cells to plot. Intra is the cell index using the
% Kernel (Y axis)
% intra = [1306,1333];    % cell range to plot
% Cinterest = Cindex(1,intra(1):intra(2));
% Sinterest = Keep_cell(Cinterest,1);

% For figure in paper, the 3 cells shown were: 
Sinterest = 26;
% Sinterest = 101;
% Sinterest = 261;

% plot cell location
% image = zeros(2056,2464);
% 
% for n = 1:length(Sinterest)
%     k = Sinterest(n,1);
%     pixels = [[stat{1,k}.xpix]',[stat{1,k}.ypix]'];
%     for m = 1:length(pixels)
%         image(pixels(m,2),pixels(m,1)) = 1;
%     end
%     clear pixels
% end
% figure
% imagesc(imrotate(image,-90))
% axis off

figure
subplot(1,2,1)
plot3(XY_pos_rs(1:spk_clip,1),XY_pos_rs(1:spk_clip,2),dff_Data(Sinterest,1:spk_clip))
hold on
plot(XY_pos_rs(1:spk_clip,1),XY_pos_rs(1:spk_clip,2))
view([24.7 18.55])
title('DF/F data')
legend('DF/F trace','8maze position')

subplot(1,2,2)
plot3(XY_pos_rs(1:spk_clip,1),XY_pos_rs(1:spk_clip,2),spks_filt(Sinterest,1:spk_clip))
hold on
plot(XY_pos_rs(1:spk_clip,1),XY_pos_rs(1:spk_clip,2))
view([24.7 18.55])
xlim([-0.3 0.3])
ylim([-0.2 0.2])
title('deconv spike rate')
legend('spike rate','8maze position')

figure
ztemp = spks_filt(Sinterest,1:spk_clip);
cmp = linspace(0,max(ztemp),numel(ztemp));
scatter3(XY_pos_rs(1:spk_clip,1),XY_pos_rs(1:spk_clip,2),spks_filt(Sinterest,1:spk_clip),[],ztemp,'filled'); 
colorbar
% scatter(XY_pos_rs(1:spk_clip,1),XY_pos_rs(1:spk_clip,2),[],ztemp,'filled'); 
colorbar

%%  Define RIO bounds over the image and then extract DF/F traces from bounds

image = imrotate(imageData,90); % zeros(2056,2464);
% format = [y y; x x]
bounds_b = [1500, 1150; 1952,1602];
bounds_r = [990, 640; 1420,1070];
bounds_g = [540, 190; 1083,733];
bounds_y = [439, 89; 1592,1242];

image([bounds_b(1,2):bounds_b(1,1)],[bounds_b(2,2):bounds_b(2,1)]) = 1;
image([bounds_r(1,2):bounds_r(1,1)],[bounds_r(2,2):bounds_r(2,1)]) = 1;
image([bounds_g(1,2):bounds_g(1,1)],[bounds_g(2,2):bounds_g(2,1)]) = 1;
image([bounds_y(1,2):bounds_y(1,1)],[bounds_y(2,2):bounds_y(2,1)]) = 1;

imagesc(image)
% imagesc(imrotate(image,-90))

%% Boxes around RIOs

boxiscell = iscell;
boxiscell(:,1) = 0;

for n = 1:length(iscell)
    if(iscell(n,1)) == 1 
        pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]'];
        for m = 1:length(pixels)
            if pixels(m,1) > bounds_b(2,2)+10 &&  pixels(m,1) < bounds_b(2,1) -10
                if pixels(m,2) > bounds_b(1,2)+10 &&  pixels(m,2) < bounds_b(1,1) -10
                    image(pixels(m,2),pixels(m,1)) = 255;
                    boxiscell(n,1) = 1;

                end
            end
            if pixels(m,1) > bounds_r(2,2)+10 &&  pixels(m,1) < bounds_r(2,1)-10
                if pixels(m,2) > bounds_r(1,2)+10 &&  pixels(m,2) < bounds_r(1,1)-10
                    image(pixels(m,2),pixels(m,1)) = 255;
                    boxiscell(n,1) = 2;

                end
            end
            if pixels(m,1) > bounds_g(2,2)+10 &&  pixels(m,1) < bounds_g(2,1)-10
                if pixels(m,2) > bounds_g(1,2)+10 &&  pixels(m,2) < bounds_g(1,1)-10
                    image(pixels(m,2),pixels(m,1)) = 255;
                    boxiscell(n,1) = 3;

                end
            end
            if pixels(m,1) > bounds_y(2,2)+10 &&  pixels(m,1) < bounds_y(2,1)-10
                if pixels(m,2) > bounds_y(1,2)+10 &&  pixels(m,2) < bounds_y(1,1)-10
                    image(pixels(m,2),pixels(m,1)) = 255;
                    boxiscell(n,1) = 4;
  
                end
            end
        end
        clear pixels
    end
end

figure
imagesc(image)
% imagesc(imrotate(image,-90))

%% 
scale = 1;

nums = [1:1:size(dff_Data,1)]';
traces_b = boxiscell(:,1) == 1;
traces_b = traces_b.*nums;
traces_b(traces_b==0) = [];
dfftraces_b = dff_Data(traces_b',:);
dfftraces_b = dfftraces_b + [1:1:size(dfftraces_b,1)]'.*scale;

traces_r = boxiscell(:,1) == 2;
traces_r = traces_r.*nums;
traces_r(traces_r==0) = [];
dfftraces_r = dff_Data(traces_r',:);
dfftraces_r = dfftraces_r + [1:1:size(dfftraces_r,1)]'.*scale;

traces_g = boxiscell(:,1) == 3;
traces_g = traces_g.*nums;
traces_g(traces_g==0) = [];
dfftraces_g = dff_Data(traces_g',:);
dfftraces_g = dfftraces_g + [1:1:size(dfftraces_g,1)]'.*scale;

traces_y = boxiscell(:,1) == 4;
traces_y = traces_y.*nums;
traces_y(traces_y==0) = [];
dfftraces_y = dff_Data(traces_y',:);
dfftraces_y = dfftraces_y + [1:1:size(dfftraces_y,1)]'.*scale;
%%

figure
for n = 1:10
    plot(dfftraces_b(n,:),'k')
    hold on
    title('blue')
end

figure
for n = 1:10
    plot(dfftraces_r(n,:),'k')
    hold on
    title('purple')
end

figure
for n = 1:10
    plot(dfftraces_g(n,:),'k')
    hold on
    title('green')
end

figure
for n = 1:10
    plot(dfftraces_y(n,:),'k')
    hold on
    title('brown')
end

%% plot cell locations
figure
image_loc_cells = image.*0.2;
k = 1; % counter
% for p = 1:10
p = 9; % cell number (manually change from 1 to 10)
    for n = 1:length(iscell)
        if boxiscell(n,1) == 4 
            pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]'];
            if p == k
                for m = 1:length(pixels)
                    image_loc_cells(pixels(m,2),pixels(m,1)) = 255;
                    k = k+1;
                end
            else
                k = k+1;
            end        
        end
   end

% imagesc(image)
imagesc(imrotate(image_loc_cells,-90))

% end



% %% Manifold projection onto 3D
% clear Keep_dffs
%  m = 1;
% for n = 1:size(iscell,1)
%     if iscell(n,1) == 1
%         Keep_dffs(m,:) = dff_Data(n,:);
%         m = m + 1;
%     end
% end
% 
% isodata = [Keep_dffs'];
% isocells = isodata(1:spk_clip,:);%.*Logi_move(1:spk_clip,1);
% 
% iso_0 = find(sum(isocells,2)==0);
% isocells(iso_0,:) = [];
% 
% isoD = pdist(isocells');
% D = squareform(isoD);
% 
% n_fcn = 'k';
% n_size = 10;
% 
% [Y, R, E] = IsoMap(D, n_fcn, n_size, []); 
% 
% %%
% % vr = VideoWriter('Isomap3Drotating_982_230121.avi','Uncompressed AVI');
% % vr.FrameRate = 30;
% % open(vr)
% 
% figure('Color','white') 
% dat = cell2mat(Y.coords(3,1));
% 
% for n = 1:1:size(Keep_dffs,2)+1000
%     if n < size(Keep_dffs,2)-1
%         datdff1 = sum(Keep_dffs(:,n).*dat',1);
%         datdff2 = sum(Keep_dffs(:,n+1).*dat');
%         datdff = [datdff1;datdff2];
%         m = n;
% 
%         if Logi_still(m,1) == 1
%             Col = [0 0.4470 0.7410];
%         elseif ceil(Logi_Yaw_Lbin(m,1)./10000) == 1
%             Col = [0.8500 0.3250 0.0980];
%         elseif ceil(Logi_Yaw_Rbin(m,1)./10000) == 1
%             Col = [0.9290 0.6940 0.1250];
%         elseif Logi_dzone(m,1) == 1
%             Col = [0.4660 0.6740 0.1880];
%         end  
% 
% 
%         plot3([datdff(:,1)],[datdff(:,2)],[datdff(:,3)],'-','Color',Col)
% 
%         xlim([-600, 600])
%         ylim([-600, 600])
%         zlim([-300, 300])
%         grid on
%         hold on
% %         pause(0.1)  % good to pause if writing a video
%     end
%         
%         [caz,cel] = view;
%         caz = caz-0.1;
%         view([caz cel])
%         axis off
%         title('manifold projection; Blue = mouse stationary, Orange = Left loop, Yellow = Right loop, Green = Turning zone')
% %     framein = getframe(gcf);  % get frame for video
% %     writeVideo(vr,framein);   % write frame to video
%     
% 
% end
% close(vr)
%     
% 
% 
% 
% 
