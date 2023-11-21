% GENERATE Decisions.mat
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all

% This script loads raw data, calculates several variables from the data
% and then saves these into the structured variable "Decisions"
% the variables are:
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

% Raw data files (Mxxx_8maze_xx_xx_xx.mat) are formatted as follows: 
% columns 1 through 31 are: 
% 1     theta1  joint 1 angle (rad)
% 2     theta2  joint 2 angle (rad)
% 3     theta3  joint 3 angle (rad)
% 4     theta6  joint 6 angle (rad)
% 5     x       global x positoin (m)
% 6     y       global y positoin (m)
% 7     z       global z positoin (m)
% 8     gamma   global yaw positoin (m)
% 9     xdel    admittance X velocity output (m/s)
% 10    ydel    admittance Y velocity output (m/s)
% 11    zdel    admittance Z velocity output (m/s)
% 12    gammadel    admittance Yaw velocity output (m/s)
% 13    time    time (s)
% 14    PWM1    PWM signal to joint 1
% 15    PWM2    PWM signal to joint 2
% 16    PWM3    PWM signal to joint 3
% 17    PWM6    PWM signal to joint 4
% 18    Fxmouse Mouse X force (N) 
% 19    Fymouse Mouse Y force (N) 
% 20    Fzmouse Mouse Z force (N) 
% 21    Frotzmouse  Mouse Yaw torque (Nm) 
% 22    cx    virtual X damping (Ns/m)
% 23    cy    virtual Y damping (Ns/m)
% 24    cyaw  virtual Yaw damping 
% 25    mx    virtual X mass (kg)
% 26    my    virtual Y mass (kg)
% 27    myaw  virtual Yaw mass 
% 28    Sound binary indicator of when sound is on (0 = on, because device is low triggered)   
% 29    Air   binary indicator of when air is on   (1 = on)
% 30    Milk  binary indicator of when milk is being dispensed (1 = on)
% 31    Sync  binary indicator of when sync pulse is on ( 1 = on)

% Turn_seq is the turn sequence for that session (0 = door on, 1 = correct, -1 = incorrect)

% running the code will generate figures showing the path for each turn,
% and a second figure showing the classification of turns as success or
% fail

tincr = 0.01; % (s)

%% Mouse 1
load 'Mouse829_8mazeplus_22_8_12.mat'
Turn_seq = [0 0 1 1 1 1 -1 1 1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_8_12);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D1 = Mousedat;

load 'Mouse829_8mazeplus_22_8_29.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_8_29);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D2 = Mousedat;

load 'Mouse829_8mazeplus_22_8_30.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_8_30);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D3 = Mousedat;

load 'Mouse829_8mazeplus_22_8_31.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_8_31);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D4 = Mousedat;

load 'Mouse829_8mazeplus_22_9_1.mat'
Turn_seq = [0 0 1 1 1 1 1 1 -1 1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_9_1);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D5 = Mousedat;

load 'Mouse829_8mazeplus_22_9_2.mat'
Turn_seq = [0 0 1 1 -1 -1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_9_2);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D6 = Mousedat;

load 'Mouse829_8mazeplus_22_9_7.mat'
Turn_seq = [0 0 0 0 0 0 -1 -1 1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_9_7);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D7 = Mousedat;

load 'Mouse829_8mazeplus_22_9_8.mat'
Turn_seq = [0 0 0 0 0 0 -1 1 1 1 1 -1 1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_9_8);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D8 = Mousedat;

load 'Mouse829_8mazeplus_22_9_9.mat'
Turn_seq = [0 0 0 0 0 0 -1 1 1 -1 1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_9_9);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D9 = Mousedat;

load 'Mouse829_8mazeplus_22_9_20.mat'
Turn_seq = [0 0 0 0 -1 -1 -1 0 1 -1 -1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_9_20);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D10 = Mousedat;

load 'Mouse829_8mazeplus_22_9_21.mat'
Turn_seq = [0 0 0 0 1 1 1 1 -1 1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_9_21);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D11 = Mousedat;

load 'Mouse829_8mazeplus_22_9_27.mat'
Turn_seq = [0 0 0 0 -1 1 -1 1 1 1 -1 -1 1 1]';
[~,data] = clip_exo_data(Mouse829_8mazeplus_22_9_27);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M1D12 = Mousedat;

%% Mouse 2
load 'Mouse830_8mazeplus_22_8_29.mat'
Turn_seq = [0 0 0 0 1 -1 -1 1 1 -1 1 1 -1 1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_8_29);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D1 = Mousedat;

load 'Mouse830_8mazeplus_22_8_30.mat'
Turn_seq = [0 0 0 0 0 0 1 1 1 -1 1 1 1 1 -1 1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_8_30);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D2 = Mousedat;

load 'Mouse830_8mazeplus_22_8_31.mat'
Turn_seq = [0 0 0 0 0 0 1 1 1 1 1 1 1 -1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_8_31);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D3 = Mousedat;

load 'Mouse830_8mazeplus_22_9_1.mat'
Turn_seq = [0 0 1 1 1 -1 1 -1 -1 0 0 1 1 -1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_9_1);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D4 = Mousedat;

load 'Mouse830_8mazeplus_22_9_7.mat'
Turn_seq = [0 0 0 0 0 0 1 1 -1 1 -1 1 -1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_9_7);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D5 = Mousedat;

load 'Mouse830_8mazeplus_22_9_9.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_9_9);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D6 = Mousedat;

load 'Mouse830_8mazeplus_22_9_13.mat'
Turn_seq = [0 0 0 0 1 1 1 -1 1 1 -1 1 1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_9_13);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D7 = Mousedat;

load 'Mouse830_8mazeplus_22_9_23.mat'
Turn_seq = [0 0 0 0 0 0 1 -1 1 1 -1 1 1 1 1 1 1 -1 1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_9_23);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D8 = Mousedat;

load 'Mouse830_8mazeplus_22_9_27.mat'
Turn_seq = [0 0 0 0 1 -1 1 1 -1 1 1 -1 1 1 1 1 -1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_9_27);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D9 = Mousedat;

load 'Mouse830_8mazeplus_22_9_30.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_9_30);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D10 = Mousedat;

load 'Mouse830_8mazeplus_22_10_3.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_10_3);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D11 = Mousedat;

load 'Mouse830_8mazeplus_22_10_6.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse830_8mazeplus_22_10_6);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M2D12 = Mousedat;

%% NB: Mouse 832 did not pass 8maze task training so was removed from cohort

%% Mouse 3
load 'Mouse837_8mazeplus_22_8_15.mat'
Turn_seq = [0 0 -1 -1 0 1 -1 -1 -1 0 0 0 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse837_8mazeplus_22_8_15);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M3D1 = Mousedat;

load 'Mouse837_8mazeplus_22_8_17.mat'
Turn_seq = [0 0 1 1 1 1 1 -1 1 1 1 -1 1 1]';
[~,data] = clip_exo_data(Mouse837_8mazeplus_22_8_17);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M3D2 = Mousedat;

load 'Mouse837_8mazeplus_22_8_22.mat'
Turn_seq = [0 0 1 1 1 1 -1 -1 0 1 -1 -1 0 0 -1]';
[~,data] = clip_exo_data(Mouse837_8mazeplus_22_8_22);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M3D3 = Mousedat;

load 'Mouse837_8mazeplus_22_9_23.mat'
Turn_seq = [0 0 0 0 1 1 1 1 -1 -1 -1 1]';
[~,data] = clip_exo_data(Mouse837_8mazeplus_22_9_23);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M3D4 = Mousedat;

load 'Mouse837_8mazeplus_22_9_27.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse837_8mazeplus_22_9_27);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M3D5 = Mousedat;

load 'Mouse837_8mazeplus_22_9_30.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse837_8mazeplus_22_9_30);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M3D6 = Mousedat;

load 'Mouse837_8mazeplus_22_10_3.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse837_8mazeplus_22_10_3);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M3D7 = Mousedat;

load 'Mouse837_8mazeplus_22_10_6.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse837_8mazeplus_22_10_6);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M3D8 = Mousedat;

load 'Mouse837_8mazeplus_22_10_10.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse837_8mazeplus_22_10_10);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M3D9 = Mousedat;

%% Mouse 4
load 'Mouse881_8mazeplus_22_8_16.mat'
Turn_seq = [0 0 1 1 1 1 1 1 -1 1]';
[~,data] = clip_exo_data(Mouse881_8mazeplus_22_8_16);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M4D1 = Mousedat;

load 'Mouse881_8mazeplus_22_8_29.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse881_8mazeplus_22_8_29);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M4D2 = Mousedat;

load 'Mouse881_8mazeplus_22_8_31.mat'
Turn_seq = [0 0 1 1 1 1]';
[~,data] = clip_exo_data(Mouse881_8mazeplus_22_8_31);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M4D3 = Mousedat;

load 'Mouse881_8mazeplus_22_9_9.mat'
Turn_seq = [0 0 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse881_8mazeplus_22_9_9);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M4D4 = Mousedat;

load 'Mouse881_8mazeplus_22_9_14.mat'
Turn_seq = [0 0 1 1 1 1]';
[~,data] = clip_exo_data(Mouse881_8mazeplus_22_9_14);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M4D5 = Mousedat;

%% Mouse 5
load 'Mouse1002_8maze_exo_23_2_14.mat'
Turn_seq = [0 0 0 0 0 0 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1002_8maze_exo_23_2_14);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M5D1 = Mousedat;

load 'Mouse1002_8maze_exo_23_2_17.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 -1 1]';
[~,data] = clip_exo_data(Mouse1002_8maze_exo_23_2_17);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M5D2 = Mousedat;

load 'Mouse1002_8maze_exo_23_2_20.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1002_8maze_exo_23_2_20);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M5D3 = Mousedat;

load 'Mouse1002_8maze_exo_23_2_24.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 -1 1]';
[~,data] = clip_exo_data(Mouse1002_8maze_exo_23_2_24);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M5D4 = Mousedat;

load 'Mouse1002_8maze_exo_23_2_28.mat'
Turn_seq = [0 0 1 1 1 1 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1002_8maze_exo_23_2_28);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M5D5 = Mousedat;

load 'Mouse1002_8maze_exo_23_3_6.mat'
Turn_seq = [0 0 0 1 1 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1002_8maze_exo_23_3_6);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M5D6 = Mousedat;

load 'Mouse1002_8maze_exo_23_3_24.mat'
Turn_seq = [0 0 1 1 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1002_8maze_exo_23_3_24);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M5D7 = Mousedat;

load 'Mouse1002_8maze_exo_23_3_28.mat'
Turn_seq = [0 0 1 1 1 1 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1002_8maze_exo_23_3_28);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M5D8 = Mousedat;

%% Mouse 6

load 'Mouse1003_8maze_exo_23_1_30.mat'
Turn_seq = [0 0 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1003_8maze_exo_23_1_30);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M6D1 = Mousedat;

load 'Mouse1003_8maze_exo_23_2_6.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1003_8maze_exo_23_2_6);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M6D2 = Mousedat;

load 'Mouse1003_8maze_exo_23_2_10.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1003_8maze_exo_23_2_10);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M6D3 = Mousedat;

load 'Mouse1003_8maze_exo_23_2_14.mat'
Turn_seq = [0 0 0 0 1 1 1]';
[~,data] = clip_exo_data(Mouse1003_8maze_exo_23_2_14);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M6D4 = Mousedat;

load 'Mouse1003_8maze_exo_23_2_20.mat'
Turn_seq = [0 0 0 0 1 1 1]';
[~,data] = clip_exo_data(Mouse1003_8maze_exo_23_2_20);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M6D5 = Mousedat;

load 'Mouse1003_8maze_exo_23_2_24.mat'
Turn_seq = [0 0 0 0 1 1]';
[~,data] = clip_exo_data(Mouse1003_8maze_exo_23_2_24);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M6D6 = Mousedat;

load 'Mouse1003_8maze_exo_23_2_28.mat'
Turn_seq = [0 0 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1003_8maze_exo_23_2_28);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M6D7 = Mousedat;

load 'Mouse1003_8maze_exo_23_3_6.mat'
Turn_seq = [0 0 1 1 1 -1 -1 -1 0]';
[~,data] = clip_exo_data(Mouse1003_8maze_exo_23_3_6);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M6D8 = Mousedat;

%% Mouse 7

load 'Mouse1004_8maze_exo_23_1_30.mat'
Turn_seq = [0 0 -1 1 1 -1 -1 0 0 0]';
[~,data] = clip_exo_data(Mouse1004_8maze_exo_23_1_30);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M7D1 = Mousedat;

load 'Mouse1004_8maze_exo_23_2_14.mat'
Turn_seq = [0 0 0 0 0 0 -1 1]';
[~,data] = clip_exo_data(Mouse1004_8maze_exo_23_2_14);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M7D2 = Mousedat;

load 'Mouse1004_8maze_exo_23_2_17.mat'
Turn_seq = [0 0 0 0 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1004_8maze_exo_23_2_17);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M7D3 = Mousedat;

load 'Mouse1004_8maze_exo_23_2_20.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1004_8maze_exo_23_2_20);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M7D4 = Mousedat;

load 'Mouse1004_8maze_exo_23_2_24.mat'
Turn_seq = [0 0 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1004_8maze_exo_23_2_24);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M7D5 = Mousedat;

load 'Mouse1004_8maze_exo_23_2_28.mat'
Turn_seq = [0 0 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1004_8maze_exo_23_2_28);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M7D6 = Mousedat;

load 'Mouse1004_8maze_exo_23_3_6.mat'
Turn_seq = [0 0 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1004_8maze_exo_23_3_6);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M7D7 = Mousedat;


%% Mouse 8

load 'Mouse1006_8maze_exo_23_1_30.mat'
Turn_seq = [0 0 1 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1006_8maze_exo_23_1_30);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M8D1 = Mousedat;

load 'Mouse1006_8maze_exo_23_2_6.mat'
Turn_seq = [0 0 0 0 -1 1 1 1 1 1 1 -1 1 1 1]';
[~,data] = clip_exo_data(Mouse1006_8maze_exo_23_2_6);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M8D2 = Mousedat;

load 'Mouse1006_8maze_exo_23_2_10.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1006_8maze_exo_23_2_10);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M8D3 = Mousedat;

load 'Mouse1006_8maze_exo_23_2_14.mat'
Turn_seq = [0 0 0 0 1 1 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1006_8maze_exo_23_2_14);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M8D4 = Mousedat;

load 'Mouse1006_8maze_exo_23_2_20.mat'
Turn_seq = [0 0 0 0 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1006_8maze_exo_23_2_20);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M8D5 = Mousedat;

load 'Mouse1006_8maze_exo_23_2_24.mat'
Turn_seq = [0 0 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1006_8maze_exo_23_2_24);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M8D6 = Mousedat;

load 'Mouse1006_8maze_exo_23_2_28.mat'
Turn_seq = [0 0 1 1 1]';
[~,data] = clip_exo_data(Mouse1006_8maze_exo_23_2_28);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M8D7 = Mousedat;

load 'Mouse1006_8maze_exo_23_3_6.mat'
Turn_seq = [0 0 1 1 1 1 1 1]';
[~,data] = clip_exo_data(Mouse1006_8maze_exo_23_3_6);
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq);
Decisions.M8D8 = Mousedat;







































