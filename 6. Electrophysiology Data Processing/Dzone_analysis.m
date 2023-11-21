function [d,dzone_trig] = Dzone_analysis(XYpos_global,Turn_seq)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% isolate sections of data where mouse is in the turning/decision zone
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

d = storedats;


boxx = [-0.005 0.005 0.0425 -0.0425 -0.005 -0.005 0.005 0.005];
boxy = [0 0 0.091 0.091 0 -0.03 -0.03 0];
figure
subplot(1,2,1)
plot(boxx, boxy,'--','Color',[0.6 0.6 0.6])
subplot(1,2,2)
plot(boxx, boxy,'--','Color',[0.6 0.6 0.6])


for n = 1:size(Turn_seq,1)
    if XYpos_global(d(n,2),1) < 0
        subplot(1,2,1)
        hold on
        if Turn_seq(n,1) == -1
            plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[1 0 0])
        elseif Turn_seq(n,1) == 1
            plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.39,0.83,0.07])
        elseif Turn_seq(n,1) == 0
            plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.6,0.6,0.6])
        end
    elseif XYpos_global(d(n,2),1) > 0
        subplot(1,2,2)
        hold on
        if Turn_seq(n,1) == -1
            plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[1 0 0])
        elseif Turn_seq(n,1) == 1
            plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.39,0.83,0.07])
        elseif Turn_seq(n,1) == 0
            plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.6,0.6,0.6])
        end
    end
end

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

if d(1,1) == 1
    d(1,:) = [];
end
if d(end,2) == 0
    d(end,:) = [];
end


dzone_trig = 0.*XYpos_global(:,1);

for n = 1:size(Turn_seq,1)
    dzone_trig(d(n,1):d(n,2)) = 1;
end

    
    
    
    
    


end

