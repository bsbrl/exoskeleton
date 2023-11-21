function [] = plot_turnpaths(MxDx)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

boxx = [-0.005 0.005 0.0425 -0.0425 -0.005 -0.005 0.005 0.005];
boxy = [0 0 0.091 0.091 0 -0.03 -0.03 0];
subplot(1,2,1)
plot(boxx, boxy,'--','Color',[0.6 0.6 0.6])
subplot(1,2,2)
plot(boxx, boxy,'--','Color',[0.6 0.6 0.6])

Left = [1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0]';
Right =[0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1]';

d = MxDx.d;
XYpos_global = [MxDx.x MxDx.y];

Left(size(d,1)+1:end,:) = [];
Right(size(d,1)+1:end,:) = [];

for n = 1:size(d,1)
    if Left(n,1) == 1
        subplot(1,2,1)
        hold on
        if sum(XYpos_global(d(n,1):d(n,2),1)> 0.01) > 0
            plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[1 0 0])
        else
            plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.39,0.83,0.07])
        end
    elseif Right(n,1) == 1
        subplot(1,2,2)
        hold on
        if sum(XYpos_global(d(n,1):d(n,2),1)< -0.01) > 0
            plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[1 0 0])
        else
            plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.39,0.83,0.07])
        end
    end
end

subplot(1,2,1)
title('Left')
xlabel('x (m)')
ylabel('y (m)')
xlim([-0.05 0.05])
subplot(1,2,2)
title('Right')
xlabel('x (m)')
ylabel('y (m)')
xlim([-0.05 0.05])



end

