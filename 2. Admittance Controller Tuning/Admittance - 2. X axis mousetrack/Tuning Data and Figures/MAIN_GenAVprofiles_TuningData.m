% GENERATE AV_data.mat
% Compute stats on X axis V-A-F profile from data on mice in the mousetrack
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all

% in AV_data.mat:
% AV_data.**.vx = x vel;
% AV_data.**.ax = x accel;
% AV_data.**.fx = x force;
% AV_data.**.kx = indices of the bounds of the va profile (i.e. vx(kx), ax(kx));
% AV_data.**.Qx = area of bounds of the va profile (i.e. trapz(vx(kx), ax(kx));

% for **: 
% fb1 through fb6 = freely behaving data (see folder: Admittance - 1. Freely behaving)
% highz1 = M485_analysis_m0p2_0p1_cp1_1
% midz1 = M485_analysis_m0p15_0p15_c0p2_0p1
% tunedz1 = M485_analysis_newsys_m0p08_c2
% lowz1 = M485_analysis_m0p005_c0p05
% highz2 = M484_analysis_m0p1_0p1_c1_1
% midz2 = M484_analysis_m0p15_c0p3
% tunedz2 = M484_analysis_newsys_m0p04_c4
% lowz2 = M484_analysis_m0p01_c0p02
% highz3 = M483_analysis_m0p1_0p1_c1_1
% midz3 = M483_analysis_m0p15_c0p3
% tunedz3 = M483_analysis_newsys_m0p04_c4
% lowz3 = M483_analysis_newsys_m0p08_c2
% highz4 = M276_analysis_m0p1_0p1_c0p25_0p25
% tunedz4 = M276_analysis_newsys_m0p04_c4
% lowz4 = M276_analysis_m0p025_c0p1
% In each data set, sections of data where the mouse was stationary have
% been removed because the mouse could not move backwards => stationary
% sections biased the data towards 0 velocity and negative forces. 

% Each dataset also has a corresponding figure showing:
% 1. a scatter plot of velocity vs acceleration, color coded for each
% mouse; Full data can be extracted from this figure using the commands: 
% subplot(3,3,1)
% Dat = get(gca,'Children');
% vel = get(Dat, 'XData');     % velocity
% acel = get(Dat, 'YData');    % acceleration
% force = get(Dat, 'ZData');   % force
% 2. a 3D line plot of velocity vs accel vs force
% 3. a plot of velocity vs time and force vs time (full data)
% 4. a plot of velocity vs time and smoothed force vs time; both with
% data removed when the mouse was stationary
% 5. the fourier transform of plot 4
% 6. a plot of velocity vs time and force vs time with stationary forces
% set to zero fbecause mouse could not move backwards
% 7. the cross-correlation of velocity and force in plot 6


%% Load tuning datasets and extract variables, then save to AV_data.mat
genplot = 1; % to generate plots = 1; no plots = 0;

% WARNING -- plots do not have titles. Recommended to copy paste sections
% into the workspace if you want to analyze the plots wrt data. 

% HIGH Z
load('M485_analysis_m0p2_0p1_cp1_1.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M485_analysis_m0p2_0p1_cp1_1,genplot);
AV_data.highz1.vx = vx;
AV_data.highz1.ax = ax;
AV_data.highz1.fx = fx;
AV_data.highz1.kx = kx;
AV_data.highz1.Qx = Qx;

load('M484_analysis_m0p1_0p1_c1_1.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M484_analysis_m0p1_0p1_c1_1,genplot);
AV_data.highz2.vx = vx;
AV_data.highz2.ax = ax;
AV_data.highz2.fx = fx;
AV_data.highz2.kx = kx;
AV_data.highz2.Qx = Qx;

load('M483_analysis_m0p1_0p1_c1_1.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M483_analysis_m0p1_0p1_c1_1,genplot);
AV_data.highz3.vx = vx;
AV_data.highz3.ax = ax;
AV_data.highz3.fx = fx;
AV_data.highz3.kx = kx;
AV_data.highz3.Qx = Qx;

load('M276_analysis_m0p1_0p1_c0p25_0p25.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M276_analysis_m0p1_0p1_c0p25_0p25,genplot);
AV_data.highz4.vx = vx;
AV_data.highz4.ax = ax;
AV_data.highz4.fx = fx;
AV_data.highz4.kx = kx;
AV_data.highz4.Qx = Qx;

% TUNED Z
load('M485_analysis_newsys_m0p08_c2.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M485_analysis_newsys_m0p08_c2,genplot);
AV_data.tunedz1.vx = vx;
AV_data.tunedz1.ax = ax;
AV_data.tunedz1.fx = fx;
AV_data.tunedz1.kx = kx;
AV_data.tunedz1.Qx = Qx;

load('M484_analysis_newsys_m0p04_c4.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M484_analysis_newsys_m0p04_c4,genplot);
AV_data.tunedz2.vx = vx;
AV_data.tunedz2.ax = ax;
AV_data.tunedz2.fx = fx;
AV_data.tunedz2.kx = kx;
AV_data.tunedz2.Qx = Qx;

load('M483_analysis_newsys_m0p04_c4.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M483_analysis_newsys_m0p04_c4,genplot);
AV_data.tunedz3.vx = vx;
AV_data.tunedz3.ax = ax;
AV_data.tunedz3.fx = fx;
AV_data.tunedz3.kx = kx;
AV_data.tunedz3.Qx = Qx;

load('M276_analysis_newsys_m0p04_c4.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M276_analysis_newsys_m0p04_c4,genplot);
AV_data.tunedz4.vx = vx;
AV_data.tunedz4.ax = ax;
AV_data.tunedz4.fx = fx;
AV_data.tunedz4.kx = kx;
AV_data.tunedz4.Qx = Qx;

% LOW Z
load('M485_analysis_m0p005_c0p05.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M485_analysis_m0p005_c0p05,genplot);
AV_data.lowz1.vx = vx;
AV_data.lowz1.ax = ax;
AV_data.lowz1.fx = fx;
AV_data.lowz1.kx = kx;
AV_data.lowz1.Qx = Qx;

load('M484_analysis_m0p01_c0p02.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M484_analysis_m0p01_c0p02,genplot);
AV_data.lowz2.vx = vx;
AV_data.lowz2.ax = ax;
AV_data.lowz2.fx = fx;
AV_data.lowz2.kx = kx;
AV_data.lowz2.Qx = Qx;

load('M483_analysis_newsys_m0p08_c2.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M483_analysis_newsys_m0p08_c2,genplot);
AV_data.lowz3.vx = vx;
AV_data.lowz3.ax = ax;
AV_data.lowz3.fx = fx;
AV_data.lowz3.kx = kx;
AV_data.lowz3.Qx = Qx;

load('M276_analysis_m0p025_c0p1.mat')  
[vx,ax,fx,kx,Qx] = Extract_VA(M276_analysis_m0p025_c0p1,genplot);
AV_data.lowz4.vx = vx;
AV_data.lowz4.ax = ax;
AV_data.lowz4.fx = fx;
AV_data.lowz4.kx = kx;
AV_data.lowz4.Qx = Qx;




   