function [Mousedat] = Process_raw_data_8maze_vD(data,tincr,Turn_seq)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% take raw data from the 9maze and generate velocities and accelerations in mouse frame
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
% if code thinks mouse took less than 0.5s to make a turn then  it is
% probably hovering near the start of the turn => discard turn
    for n = size(storedats,1):-1:1
        if storedats(n,2) - storedats(n,1) < 50 
            storedats(n,:) = [];
        end
    end
% if mouse is not more than 9cm in global y at end of turn, then it has 
% reversed out of the turning zone (which does happen sometimes)
    for n = size(storedats,1):-1:1
        if XYpos_global(storedats(n,2),2) < 0.09
            storedats(n,:) = [];
        end
    end
    
    if storedats(1,1) == 0
        storedats(1,1) = 1; % can't have a 0 index
    elseif storedats(end,2) == 0
        storedats(end,:) = []; % can't have a 0 index
    end
    
    d = storedats;

    m = 1;
    for n = 1:length(d)
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

    for n = 1:length(d)

        subplot(sz1,sz2,n)
        plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2))
        xlim([-0.05 0.05])
        ylim([-0.03 0.1])
        title(strcat('turn',num2str(n)))
        if n == 1
            xlabel('global x')
            ylabel('global y')
        end

    end


    % plot success / fail in turning proficiency
    boxx = [-0.005 0.005 0.0425 -0.0425 -0.005 -0.005 0.005 0.005];
    boxy = [0 0 0.091 0.091 0 -0.03 -0.03 0];
    figure
    subplot(1,2,1)
    plot(boxx, boxy,'--','Color',[0.6 0.6 0.6])
    subplot(1,2,2)
    plot(boxx, boxy,'--','Color',[0.6 0.6 0.6])

    Left = [1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0]';
    Right =[0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1]';


    success = [0 0];
    fail = [0 0];
    help = [0 0];
    for n = 1:size(d,1)
        if XYpos_global(d(n,2),1) < 0
            subplot(1,2,1)
            hold on
            if Turn_seq(n,1) == -1
                Left(n,:) = []; Right(n,:) = [];
                fail = fail + [Left(n,1), Right(n,1)];
                plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[1 0 0])
            elseif Turn_seq(n,1) == 1
                success = success + [Left(n,1), Right(n,1)];
                plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.39,0.83,0.07])
            elseif Turn_seq(n,1) == 0
                help = help + [Left(n,1), Right(n,1)];
                plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.6,0.6,0.6])
            end
        elseif XYpos_global(d(n,2),1) > 0
            subplot(1,2,2)
            hold on
            if Turn_seq(n,1) == -1
                Left(n,:) = []; Right(n,:) = [];
                fail = fail + [Left(n,1), Right(n,1)];                
                plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[1 0 0])
            elseif Turn_seq(n,1) == 1
                success = success + [Left(n,1), Right(n,1)];
                plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.39,0.83,0.07])
            elseif Turn_seq(n,1) == 0
                help = help + [Left(n,1), Right(n,1)];
                plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.6,0.6,0.6])
            end
        end
    end

    
    Left(size(d,1)+1:end,:) = [];
    Right(size(d,1)+1:end,:) = [];
    
    subplot(1,2,1)
    title('Left')
    xlabel('x (m)')
    ylabel('y (m)')
    xlim([-0.05 0.05])
    grid on
    subplot(1,2,2)
    title('Right')
    xlabel('x (m)')
    ylabel('y (m)')
    grid on
    xlim([-0.05 0.05])
    
    % save data into a structure
    Mousedat.x = XYpos_global(:,1);  % global x position
    Mousedat.vx = vel_mouse(:,1);   % x velocity
    Mousedat.ax = accel_mouse(:,1); % x acceleration
    Mousedat.fx = data(:,18);       % x force
    
    Mousedat.y = XYpos_global(:,2);  % global x position
    Mousedat.vy = vel_mouse(:,2);   % y vel
    Mousedat.ay = accel_mouse(:,2); % y accel
    Mousedat.fy = data(:,19);       % y force       

    Mousedat.yaw = YAWpos;          % global yaw position
    Mousedat.vyaw = vel_mouse_yaw(:,1);     % yaw vel
    Mousedat.ayaw = accel_mouse_yaw(:,1);   % yaw accel
    Mousedat.fyaw = data(:,21);             % yaw torqie
    
    Mousedat.turnseq = Turn_seq;    % Sequence of correct / incorrect / helped turns
    Mousedat.d = d;                 % cell array of each turn range in turning zone
    Mousedat.rangecum = rangecum;   % concatenaed matrix array of turn ranges L and R
    Mousedat.success = success;     % success [L R]
    Mousedat.fail = fail;           % fail [L R]
    Mousedat.help = help;           % helped (door on) [L R]
    
    % VA profiles (some of these lines are redundant.. but copy pasted
    % code, so that's that)
    b_fac = 0.3;    % fill factor for boundary
    
    r = Mousedat.rangecum;
    v = Mousedat.vx(r,:); a = Mousedat.ax(r,:);
    kx = boundary(v,a,b_fac);
    Qx = abs(trapz(v(kx),a(kx)));
    Mousedat.kx = kx;               % boundary of X va profile 
    
    v = Mousedat.vy(r,:); a = Mousedat.ay(r,:);
    ky = boundary(v,a,b_fac);
    Qy = abs(trapz(v(ky),a(ky)));
    Mousedat.ky = ky;               % boundary of Y va profile 
    
    v = Mousedat.vyaw(r,:); a = Mousedat.ayaw(r,:);
    kyaw = boundary(v,a,b_fac);
    Qyaw = abs(trapz(v(kyaw),a(kyaw)));
    Mousedat.kyaw = kyaw;           % boundary of Yaw va profile 
    
end

