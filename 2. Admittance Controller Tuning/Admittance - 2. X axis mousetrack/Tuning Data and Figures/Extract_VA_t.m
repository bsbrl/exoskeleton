function [vx,ax,fx,kx,Qx,time] = Extract_VA_t(data,genplot)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% extract and/or generate AVF data with time series
tincr = data(2,1)- data(1,1);   % (s)
vx = data(:,3);                 % (m/s)
ax = [0;diff(data(:,3))]./tincr;% (m/s^2)
fx = data(:,2);                 % (N)

time = data(:,1);               % (s) Added 2/8/24

% find bounds of data and area encompassed by bounds
kx = boundary(vx,ax,0.1);
Qx = abs(trapz(vx(kx),ax(kx)));

if genplot == 1
    % plot V-A profiles
    figure
    plot(vx(:,1),ax(:,1))
    xlabel('X velocity (m/s)')
    ylabel('X acceleration (m/s^2)')
    title('X')
    % grid on

    % plot V and A time series
    time = data(:,1);
    figure
    subplot(2,1,1)
    plot(time,vx(:,1))
    xlabel('Time (s)')
    ylabel('X velocity (m/s)')
    title('X')
    subplot(2,1,2)
    plot(time,ax(:,1))
    xlabel('Time (s)')
    ylabel('X acceleration (m/s^2)')
    title('X')
    
    % scatter plot VAF
    figure
    scatter3(vx,ax,fx)
    xlabel('X velocity (m/s)')   
    ylabel('X acceleration (m/s^2)')
    zlabel('X force (N)')
    xlim([-0.05 0.15])
    ylim([-0.5 0.5])
    zlim([-1.5 2.5])
    
end

end

