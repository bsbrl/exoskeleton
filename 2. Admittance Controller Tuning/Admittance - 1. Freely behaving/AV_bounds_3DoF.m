function [vx,ax,kx,Qx,vy,ay,ky,Qy,vyaw,ayaw,kyaw,Qyaw] = AV_bounds_3DoF(data,tincr,add,plotresults)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


% coordinate transform of body tracking points from global frame to mouse 
% frame and then calc velocities from body points in mouse frame
[vel_xy,accel_xy,vel_yaw,accel_yaw,time] = bodypts2velaccel(data,tincr,add);

% filter data because DLC tracking points jitter
[vel_xy] = medmovmeanfilt(vel_xy,5,3);
[accel_xy] = medmovmeanfilt(accel_xy,5,3);
[vel_yaw] = medmovmeanfilt(vel_yaw,5,3);
[accel_yaw] = medmovmeanfilt(accel_yaw,5,3);

% find bounds of data and area encompassed by bounds
vx = vel_xy(:,1)./1000;
ax = accel_xy(:,1)./1000;
kx = boundary(vx,ax,0.1);
Qx = abs(trapz(vx(kx),ax(kx)));

% repeat for Y
vy = vel_xy(:,2)./1000;
ay = accel_xy(:,2)./1000;
ky = boundary(vy,ay,0.1);
Qy = abs(trapz(vy(ky),ay(ky)));

% repeat for Yaw
vyaw = vel_yaw(:,1);
ayaw = accel_yaw(:,1);
kyaw = boundary(vyaw,ayaw,0.1);
Qyaw = abs(trapz(vyaw(kyaw),ayaw(kyaw)));

if plotresults == 1

    % plot V-A profiles
    figure
    subplot(1,3,1)
    plot(vel_xy(:,1)./1000,accel_xy(:,1)./1000)
    xlabel('X velocity (m/s)')
    ylabel('X acceleration (m/s^2)')
    title('X')
    % grid on

    subplot(1,3,2)
    plot(vel_xy(:,2)./1000,accel_xy(:,2)./1000)
    xlabel('Y velocity (m/s)')
    ylabel('Y acceleration (m/s^2)')
    title('Y')
    % grid on

    subplot(1,3,3)
    plot(vel_yaw(:,1),accel_yaw(:,1))
    xlabel('Yaw velocity (rad/s)')
    ylabel('Yaw acceleration (rad/s^2)')
    title('Yaw')
    % grid on

    % plot V and A time series
    figure
    subplot(2,1,1)
    plot(time,vel_xy(:,1)./1000)
    xlabel('Time (s)')
    ylabel('X velocity (m/s)')
    title('X')
    subplot(2,1,2)
    plot(time,accel_xy(:,1)./1000)
    xlabel('Time (s)')
    ylabel('X acceleration (m/s^2')
    title('X')

    figure
    subplot(2,1,1)
    plot(time,vel_xy(:,2)./1000)
    xlabel('Time (s)')
    ylabel('Y velocity (m/s)')
    title('Y')
    subplot(2,1,2)
    plot(time,accel_xy(:,2)./1000)
    xlabel('Time (s)')
    ylabel('Y acceleration (m/s^2')
    title('Y')

    figure
    subplot(2,1,1)
    plot(time,vel_yaw(:,1)./1000)
    xlabel('Time (s)')
    ylabel('Yaw velocity (m/s)')
    title('Yaw')
    subplot(2,1,2)
    plot(time,accel_yaw(:,1)./1000)
    xlabel('Time (s)')
    ylabel('Yaw acceleration (m/s^2')
    title('Yaw')
end


end

