function [vel_mouse,vel_mouse_yaw,accel_mouse,accel_mouse_yaw,rangecum] = Process_raw_data(data,tincr,laps)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% take raw data and generate velocities and accelerations in mouse frame
% then identify when mouse is in turning zone

    XYpos_global = data(:,5:6);   %(m)
    delXYpos_global = [(XYpos_global(2:end,:) - XYpos_global(1:end-1,:)); [0,0]];

    YAWpos = data(:,8);           %(m)  
    delpos_mouseyaw = [(YAWpos(2:end,:) - YAWpos(1:end-1,:)); [0]];

    for n = 1:size(delXYpos_global,1)
         delpos_mousevec(:,n) = Rotzfun(YAWpos(n,:))'*[delXYpos_global(n,:),0]';
    end
    delpos_mousevec = delpos_mousevec';

    vel_mouse = delpos_mousevec./tincr;         % (m/s)
    vel_mouse_yaw = delpos_mouseyaw./tincr;     % (rad/s)

    % smooth signals
    [vel_mouse] = medmovmeanfilt(vel_mouse,13,5);
    [vel_mouse] = medmovmeanfilt(vel_mouse,13,5);
    [vel_mouse_yaw] = medmovmeanfilt(vel_mouse_yaw,13,5);
    [vel_mouse_yaw] = medmovmeanfilt(vel_mouse_yaw,13,5);
    
    % calc acceleration from velocity
    accel_mouse = [[0,0,0]; (vel_mouse(2:end,:) - vel_mouse(1:end-1,:))]./tincr;
    accel_mouse_yaw = [[0]; (vel_mouse_yaw(2:end,:) - vel_mouse_yaw(1:end-1,:))]./tincr;

    % determine when mouse was in the turning zone
    clear dats
    clear storedats
    dats = zeros(size(XYpos_global,1),1);
    for nn = 1:size(XYpos_global,1)
        if XYpos_global(nn,1) < 0.015 && XYpos_global(nn,1) > -0.07
            if XYpos_global(nn,2) < 0.03 && XYpos_global(nn,2) > -0.03
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

    d = storedats;

    % laps to keep
    m = 1;
    for n = laps(1):laps(2)
        range = [d(n,1):1:d(n,2)]';
        if m ==1
            rangecum = range;
        else
            rangecum = [rangecum;range];
        end
        m = m+1;    
    end
    
    % plot path through turning zone
    figure
    sz1 = 5;
    sz2 = ceil(size(storedats,1)/sz1);

    for n = laps(1):laps(2)

        subplot(sz1,sz2,n)
        plot(XYpos_global(d(n,1):d(n,2),2),-XYpos_global(d(n,1):d(n,2),1))
        xlim([-0.04 0.04])
        ylim([-0.03 0.07])
        if n == 1
            xlabel('global x')
            ylabel('global y')
            title('turning path')
        end

    end


end

