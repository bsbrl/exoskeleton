%% load mesoscope data and create global trajectory for 6DoF robot
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all 

path = strcat(pwd,'\DLC data');
addpath(path)

%%
load('Mesoscopedata_trial1_1_13_20.mat')

%% Plot 

datastart = 4576;   % start at data point
datasize = 3000;    % number of data points

figure
plot(MSdata(datastart:datastart+datasize-1,2)./1000,...
    MSdata(datastart:datastart+datasize-1,3)./1000,'.-')
ylabel('ypos (m)')
xlabel('xpos (m)')
title('Animal tracking data')
hold on
for n = datastart:datastart+datasize-1
    plot(MSdata(n,[2, 5])./1000,MSdata(n,[3, 6])./1000,'-',...
        'color',[0.3010 0.7450 0.9330])
    rotZangle(n,1:2) = [MSdata(n,5) - MSdata(n,2), ...
        MSdata(n,6) - MSdata(n,3)];
    rotZangle(n,3) = atan(rotZangle(n,2)/rotZangle(n,1));
end
legend('head position','head orientation')


%% extract variables and filter data to remove jitter in tracking points

tincr = 0.034;  % (ms)
timearray = 0:tincr:tincr*(datasize-1); 

trajectory_coord = zeros(6,size(timearray,2));    % empty array
trajectory_vel = 0.*trajectory_coord;           % empty array

trajectory_coord(1,:) = MSdata(datastart:datastart+datasize-1,2)...
    ./1000-0.15; % (m)  (convert from mm to m, then centre on x=0.15m)
trajectory_coord(2,:) = MSdata(datastart:datastart+datasize-1,3)...
    ./1000-0.15; % (m)  (convert from mm to m, then centre on y=0.15m)
trajectory_coord(3,:) = -0.8;  % (m) Z offset from robot reference frame 
% trajectory_coord(4,:) = 0;  % (rad) no rotY displacement;
% trajectory_coord(5,:) = 0;  % (rad) no rotX displacement;
trajectory_coord(6,:) = rotZangle(datastart:datastart+datasize-1,3); % (rad)

% filter data
d1 = designfilt('lowpassiir','FilterOrder',6, ...
    'HalfPowerFrequency',0.05,'DesignMethod','butter');
for n = 1:6
    trajectory_coordfilt(n,:) = filtfilt(d1,trajectory_coord(n,:));
end

% velocity
for n = 2:datasize-1
    trajectory_vel(:,n) = (trajectory_coordfilt(:,n+1)-trajectory_coordfilt(:,n-1))./(2*tincr);
end

%% plot 
figure
subplot(1,2,1)
    title('Animal tracking data')
    yyaxis left
    plot(timearray,trajectory_coordfilt([1,2],:)')
    xlabel('time (s)')
    ylabel('global position (m)')
    yyaxis right 
    plot(timearray,trajectory_vel([1,2],:)')
    ylabel('global velocity (m/s)')
    legend('x','y','x','y')
subplot(1,2,2)
    title('Animal tracking data rotZ')
    yyaxis left
    plot(timearray,trajectory_coordfilt([6],:)')
    xlabel('time (s)')
    ylabel('position (rad)')
    yyaxis right 
    plot(timearray,trajectory_vel([6],:)')
    ylabel('velocity (rad/s)')
    legend('rotZ','rotZ')


    
    
    


