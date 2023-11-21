% GENERATE Eightmaze.mat
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all

% This script loads raw data, calculates several variables from the data
% and then saves these into the structured variable "Eightmaze"
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
% fyaw     yaw torqie
% d        cell array with start and end indices of each turn in turning zone
% rangecum  concatenaed matrix array of all data indices for mouse in turning zone
% success   success [L R]
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

% loading a file will load several variables:
% variable with same name as the file is the raw data
% data is the raw data clipped to length using variable 'clip'
% tincr is sampling time in seconds (loop rate of DAQ system)

% NB: turn 1 is clipped short because mouse starts around x,y = 0,0

% Running the code will generate figures showing the path for each turn,
% and a second figure showing the classification of turns as success or
% fail... 
% WARNING: this is 60+ figures


%% Mouse 1
load 'Mouse829_8mazeplus_22_7_11.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M1D1 = Mousedat;

load 'Mouse829_8mazeplus_22_7_12.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M1D2 = Mousedat;

load 'Mouse829_8mazeplus_22_7_13.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M1D3 = Mousedat;

load 'Mouse829_8mazeplus_22_7_14.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M1D4 = Mousedat;

load 'Mouse829_8mazeplus_22_7_15.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M1D5 = Mousedat;

load 'Mouse829_8mazeplus_22_7_16.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M1D6 = Mousedat;

load 'Mouse829_8mazeplus_22_7_18.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M1D7 = Mousedat;

load 'Mouse829_8mazeplus_22_7_19.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M1D8 = Mousedat;


%% Mouse 2
load 'Mouse830_8mazeplus_22_7_11.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M2D1 = Mousedat;

load 'Mouse830_8mazeplus_22_7_12.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M2D2 = Mousedat;

load 'Mouse830_8mazeplus_22_7_13.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M2D3 = Mousedat;

load 'Mouse830_8mazeplus_22_7_14.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M2D4 = Mousedat;

load 'Mouse830_8mazeplus_22_7_15.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M2D5 = Mousedat;


%% Mouse 3
load 'Mouse832_8mazeplus_22_7_11.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M3D1 = Mousedat;

load 'Mouse832_8mazeplus_22_7_12.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M3D2 = Mousedat;

load 'Mouse832_8mazeplus_22_7_13.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M3D3 = Mousedat;

load 'Mouse832_8mazeplus_22_7_14.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M3D4 = Mousedat;

load 'Mouse832_8mazeplus_22_7_15.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M3D5 = Mousedat;

load 'Mouse832_8mazeplus_22_7_16.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M3D6 = Mousedat;

load 'Mouse832_8mazeplus_22_7_18.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M3D7 = Mousedat;

load 'Mouse832_8mazeplus_22_7_19.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M3D8 = Mousedat;

%% Mouse 4
load 'Mouse837_8mazeplus_22_7_11.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M4D1 = Mousedat;

load 'Mouse837_8mazeplus_22_7_12.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M4D2 = Mousedat;

load 'Mouse837_8mazeplus_22_7_13.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M4D3 = Mousedat;

load 'Mouse837_8mazeplus_22_7_14.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M4D4 = Mousedat;

load 'Mouse837_8mazeplus_22_7_15.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M4D5 = Mousedat;

%% Mouse 5
load 'Mouse881_8mazeplus_22_7_11.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M5D1 = Mousedat;

load 'Mouse881_8mazeplus_22_7_12.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M5D2 = Mousedat;

load 'Mouse881_8mazeplus_22_7_13.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M5D3 = Mousedat;

load 'Mouse881_8mazeplus_22_7_14.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M5D4 = Mousedat;

load 'Mouse881_8mazeplus_22_7_15.mat'
% Calculate vel and accel from raw data and identify turns
[Mousedat] = Process_raw_data_8maze(data,tincr);
Eightmaze.M5D5 = Mousedat;

%%

% AV_data.YYhighz1.Qyaw = Qyaw;
