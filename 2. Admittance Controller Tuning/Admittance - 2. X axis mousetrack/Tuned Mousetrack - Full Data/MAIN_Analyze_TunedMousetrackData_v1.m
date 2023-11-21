%% Analyze data from the exoskeleton with tuned admittance controller
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all

% Datasets for Mouse276 are formatted from columns 1 to 23 as follows
%     theta1  joint 1 angle (rad)
%     theta2  joint 2 angle (rad)
%     theta3  joint 3 angle (rad)
%     theta6  joint 6 angle (rad)
%     x       global x positoin (m)
%     y       global y positoin (m)
%     z       global z positoin (m)
%     gamma   global yaw positoin (m)
%     xdel    admittance velocity output (m/s)
%     ydel    admittance velocity output (m/s)
%     zdel    admittance velocity output (m/s)
%     gammadel    admittance velocity output (m/s)
%     time    time (s)
%     PWM1    PWM signal to joint 1
%     PWM2    PWM signal to joint 2
%     PWM3    PWM signal to joint 3
%     PWM6    PWM signal to joint 4
%     Fxmouse Mouse Xce (N) 
%     Fymouse Mouse Y force (N) 
%     Fzmouse Mouse Z force (N) 
%     Frotzmouse  Mouse Yaw torque (Nm) 
%     m   virtual mass (kg)
%     c   virtual damping (Ns/m)

% Datasets for Mouse1002 and 1132 are formatted from columns 1 to 31 as follows: 
%     theta1  joint 1 angle (rad)
%     theta2  joint 2 angle (rad)
%     theta3  joint 3 angle (rad)
%     theta6  joint 6 angle (rad)
%     x       global x positoin (m)
%     y       global y positoin (m)
%     z       global z positoin (m)
%     gamma   global yaw positoin (m)
%     xdel    admittance velocity output (m/s)
%     ydel    admittance velocity output (m/s)
%     zdel    admittance velocity output (m/s)
%     gammadel    admittance velocity output (m/s)
%     time    time (s)
%     PWM1    PWM signal to joint 1
%     PWM2    PWM signal to joint 2
%     PWM3    PWM signal to joint 3
%     PWM6    PWM signal to joint 4
%     Fxmouse Mouse Xce (N) 
%     Fymouse Mouse Y force (N) 
%     Fzmouse Mouse Z force (N) 
%     Frotzmouse  Mouse Yaw torque (Nm) 
%     cx   virtual damping X (Ns/m)
%     N/A
%     N/A
%     mx   virtual mass X (kg)
%     N/A
%     N/A
%     N/A
%     N/A
%     N/A
%     N/A



%% Four data sets provided; more available at reasonable request

% dataset 1
load('Mouse276_mousetrack_2_16_22.mat')
data = Mouse276_mousetrack_2_16_22;
clip = [6322 53952];
[AV_data.trained1] = Process_mousetrack_data(data,clip);

% dataset 2
load('Mouse1002_Mousetrack_17_4_23.mat')
data = Mouse1002_Mousetrack_17_4_23;
clip = [14000 49650];
[AV_data.trained2] = Process_mousetrack_data(data,clip);

% dataset 3
load('Mouse1132_Mousetrack_17_4_23.mat')
data = Mouse1132_Mousetrack_17_4_23;
clip = [42800 73252];
[AV_data.trained3] = Process_mousetrack_data(data,clip);

% dataset 4
load('Mouse1252_Mousetrack_17_4_23.mat')
data = Mouse1252_Mousetrack_17_4_23;
clip = [32600 63560];
[AV_data.trained4] = Process_mousetrack_data(data,clip);

