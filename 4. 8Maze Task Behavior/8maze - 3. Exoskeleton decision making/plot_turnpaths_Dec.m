function [] = plot_turnpaths_Dec(MxDx,r,numday)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

r = (r-1)*4;   % adjust plot row for day

boxx = [-0.005 0.005 0.0425 -0.0425 -0.005 -0.005 0.005 0.005];
boxy = [0 0 0.091 0.091 0 -0.03 -0.03 0];
for n = 1:4
    subplot(numday,4,n+r)
    plot(boxx, boxy,'--','Color',[0.6 0.6 0.6])

end

Turn_seq = MxDx.turnseq;
d = MxDx.d;
XYpos_global = [MxDx.x MxDx.y];

    for n = 1:size(d,1)
        if XYpos_global(d(n,2),1) < 0
            hold on
            if Turn_seq(n,1) == -1
                subplot(numday,4,3+r)
                plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[1 0 0])
            elseif Turn_seq(n,1) == 1
                subplot(numday,4,1+r)
                plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.39,0.83,0.07])
            end
        elseif XYpos_global(d(n,2),1) > 0
            hold on
            if Turn_seq(n,1) == -1
                subplot(numday,4,4+r)
                plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[1 0 0])
            elseif Turn_seq(n,1) == 1
                subplot(numday,4,2+r)
                plot(XYpos_global(d(n,1):d(n,2),1),XYpos_global(d(n,1):d(n,2),2),'Color',[0.39,0.83,0.07])
            end
        end
    end

for n = 1:4
    subplot(numday,4,n+r)
%     xlabel('x (m)')
%     ylabel('y (m)')
    xlim([-0.05 0.05])
    axis off
end



end

