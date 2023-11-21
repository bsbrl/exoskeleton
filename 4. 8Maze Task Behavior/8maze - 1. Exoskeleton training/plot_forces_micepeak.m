function [statsfy,cfy,statsfyaw,cfyaw] = plot_forces_micepeak(Eightmaze)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% plot day 1 vs final day peak force distributions comparing mice

% day 1 fL = positive (left) Y forces; fR = negative (right) Y forces
tempx = Eightmaze.M1D1.fL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M1D1LY'},size(tempx)); x = tempx; g = tempg;

tempx = Eightmaze.M1D1.fR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M1D1RY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M2D1.fL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M2D1LY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M2D1.fR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M2D1RY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M3D1.fL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M3D1LY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M3D1.fR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M3D1RY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M4D1.fL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M4D1LY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M4D1.fR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M4D1RY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M5D1.fL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M5D1LY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M5D1.fR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M5D1RY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

subplot(2,2,1)
boxplot(x,g,'PlotStyle','compact','symbol','')
ylabel('Y forces (N)')
title('Y peaks - day 1')
xlabel('mouse id')
ylim([-1 1])

xyd1 = x; gyd1 = g;

clear tempx tempg x g

% day 1 tL = positive (left) Yaw forces; tR = negative (right) Y forces
tempx = Eightmaze.M1D1.tL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M1D1Lyaw'},size(tempx)); x = tempx; g = tempg;

tempx = Eightmaze.M1D1.tR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M1D1Ryaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M2D1.tL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M2D1Lyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M2D1.tR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M2D1Ryaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M3D1.tL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M3D1Lyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M3D1.tR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M3D1Ryaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M4D1.tL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M4D1Lyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M4D1.tR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M4D1Ryaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M5D1.tL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M5D1Lyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M5D1.tR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M5D1Ryaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

subplot(2,2,3)
boxplot(x,g,'PlotStyle','compact','symbol','')
ylabel('Yaw forces (Nm)')
title('Yaw peaks - day 1')
xlabel('mouse id')
ylim([-0.02 0.02])

xyawd1 = x; gyawd1 = g;

clear tempx tempg x g

% day final fL = positive (left) Y forces; fR = negative (right) Y forces
tempx = Eightmaze.M1D8.fL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M1DFLY'},size(tempx)); x = tempx; g = tempg;

tempx = Eightmaze.M1D8.fR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M1DFRY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M2D5.fL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M2DFLY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M2D5.fR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M2DFRY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M3D8.fL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M3DFLY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M3D8.fR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M3DFRY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M4D5.fL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M4DFLY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M4D5.fR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M4DFRY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M5D5.fL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M5DFLY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M5D5.fR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M5DFRY'},size(tempx)); x = [x; tempx]; g = [g; tempg];

subplot(2,2,2)
boxplot(x,g,'PlotStyle','compact','symbol','')
title('Y peaks - day final')
ylabel('Y forces (N)')
xlabel('mouse id')
ylim([-1 1])

xydf = x; gydf = g;

clear tempx tempg x g

% day final tL = positive (left) Yaw forces; tR = negative (right) Y forces
tempx = Eightmaze.M1D8.tL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M1DFLyaw'},size(tempx)); x = tempx; g = tempg;

tempx = Eightmaze.M1D8.tR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M1DFRyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M2D5.tL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M2DFLyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M2D5.tR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M2DFRyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M3D8.tL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M3DFLyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M3D8.tR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M3DFRyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M4D5.tL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M4DFLyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M4D5.tR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M4DFRyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M5D5.tL; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M5DFLyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

tempx = Eightmaze.M5D5.tR; [tempx] = getFpeaks(tempx);  
tempg = repmat({'M5DFRyaw'},size(tempx)); x = [x; tempx]; g = [g; tempg];

subplot(2,2,4)
boxplot(x,g,'PlotStyle','compact','symbol','')
title('Yaw peaks - day final')
ylabel('Yaw forces (Nm)')
xlabel('mouse id')
ylim([-0.02 0.02])

xyawdf = x; gyawdf = g;


% stats on all data to compare trends within and across mice 

x = [xyd1;xydf];
g = [gyd1;gydf];
[~,~,statsfy] = anova1(x,g,'off');
figure
cfy = multcompare(statsfy);
title('Y force peaks - day1 vs dayF')

x = [xyawd1;xyawdf];
g = [gyawd1;gyawdf];
[~,~,statsfyaw] = anova1(x,g,'off');
figure
cfyaw = multcompare(statsfyaw);
title('Yaw force peaks - day1 vs dayF')

end

