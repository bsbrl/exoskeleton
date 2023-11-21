function [statsfy,cfy,statsfyc,cfyc] = plot_forcesYaw(Eightmaze)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% DAY 1
% day 1 tL = positive (left) Yaw forces; 
x1L = [Eightmaze.M1D1.tL;...
       Eightmaze.M2D1.tL;...
       Eightmaze.M3D1.tL;...
       Eightmaze.M4D1.tL;...
       Eightmaze.M5D1.tL];

g1L = [repmat({'D1L'},size(x1L))];

% day 1 tR = negative (right) Yaw forces
x1R = [Eightmaze.M1D1.tR;...
       Eightmaze.M2D1.tR;...
       Eightmaze.M3D1.tR;...
       Eightmaze.M4D1.tR;...
       Eightmaze.M5D1.tR];

g1R = [repmat({'D1R'},size(x1R))];

% DAY 2
% day 2 tL = positive (left) Yaw forces; 
x2L = [Eightmaze.M1D2.tL;...
       Eightmaze.M2D2.tL;...
       Eightmaze.M3D2.tL;...
       Eightmaze.M4D2.tL;...
       Eightmaze.M5D2.tL];

g2L = [repmat({'D2L'},size(x2L))];

% day 2 tR = negative (right) Yaw forces
x2R = [Eightmaze.M1D2.tR;...
       Eightmaze.M2D2.tR;...
       Eightmaze.M3D2.tR;...
       Eightmaze.M4D2.tR;...
       Eightmaze.M5D2.tR];

g2R = [repmat({'D2R'},size(x2R))];

% DAY 3
% day 3 tL = positive (left) Yaw forces; 
x3L = [Eightmaze.M1D3.tL;...
       Eightmaze.M2D3.tL;...
       Eightmaze.M3D3.tL;...
       Eightmaze.M4D3.tL;...
       Eightmaze.M5D3.tL];

g3L = [repmat({'D3L'},size(x3L))];

% day 3 tR = negative (right) Yaw forces
x3R = [Eightmaze.M1D3.tR;...
       Eightmaze.M2D3.tR;...
       Eightmaze.M3D3.tR;...
       Eightmaze.M4D3.tR;...
       Eightmaze.M5D3.tR];

g3R = [repmat({'D3R'},size(x3R))];

% DAY 4
% day 4 tL = positive (left) Yaw forces; 
x4L = [Eightmaze.M1D4.tL;...
       Eightmaze.M2D4.tL;...
       Eightmaze.M3D4.tL;...
       Eightmaze.M4D4.tL;...
       Eightmaze.M5D4.tL];

g4L = [repmat({'D4L'},size(x4L))];

% day 4 tR = negative (right) Yaw forces
x4R = [Eightmaze.M1D4.tR;...
       Eightmaze.M2D4.tR;...
       Eightmaze.M3D4.tR;...
       Eightmaze.M4D4.tR;...
       Eightmaze.M5D4.tR];

g4R = [repmat({'D4R'},size(x4R))];

% DAY 5
% day 5 tL = positive (left) Yaw forces; 
x5L = [Eightmaze.M1D5.tL;...
       Eightmaze.M2D5.tL;...
       Eightmaze.M3D5.tL;...
       Eightmaze.M4D5.tL;...
       Eightmaze.M5D5.tL];

g5L = [repmat({'D5L'},size(x5L))];

% day 5 tR = negative (right) Yaw forces
x5R = [Eightmaze.M1D5.tR;...
       Eightmaze.M2D5.tR;...
       Eightmaze.M3D5.tR;...
       Eightmaze.M4D5.tR;...
       Eightmaze.M5D5.tR];

g5R = [repmat({'D5R'},size(x5R))];

% DAY 6
% day 6 tL = positive (left) Yaw forces; 
x6L = [Eightmaze.M1D6.tL;...
       Eightmaze.M3D6.tL];

g6L = [repmat({'D6L'},size(x6L))];

% day 6 tR = negative (right) Yaw forces
x6R = [Eightmaze.M1D6.tR;...
       Eightmaze.M3D6.tR];

g6R = [repmat({'D6R'},size(x6R))];

% DAY 7
% day 7 tL = positive (left) Yaw forces; 
x7L = [Eightmaze.M1D7.tL;...
       Eightmaze.M3D7.tL];

g7L = [repmat({'D7L'},size(x7L))];

% day 7 tR = negative (right) Yaw forces
x7R = [Eightmaze.M1D7.tR;...
       Eightmaze.M3D7.tR];

g7R = [repmat({'D7R'},size(x7R))];

% DAY 8
% day 8 tL = positive (left) Yaw forces; 
x8L = [Eightmaze.M1D8.tL;...
       Eightmaze.M3D8.tL];

g8L = [repmat({'D8L'},size(x8L))];

% day 8 tR = negative (right) Yaw forces
x8R = [Eightmaze.M1D8.tR;...
       Eightmaze.M3D8.tR];

g8R = [repmat({'D8R'},size(x8R))];


% DAY FINAL
% day FINAL tL = positive (left) Yaw forces; 
xFL = [Eightmaze.M1D8.tL;...
       Eightmaze.M2D5.tL;...
       Eightmaze.M3D8.tL;...
       Eightmaze.M4D5.tL;...
       Eightmaze.M5D5.tL];

gFL = [repmat({'DFL'},size(xFL))];

% day FINAL tR = negative (right) Yaw forces
xFR = [Eightmaze.M1D8.tR;...
       Eightmaze.M2D5.tR;...
       Eightmaze.M3D8.tR;...
       Eightmaze.M4D5.tR;...
       Eightmaze.M5D5.tR];

gFR = [repmat({'DFR'},size(xFR))];

x = [x1L; x1R; x2L; x2R; x3L; x3R; x4L; x4R; x5L; x5R; x6L; x6R; x7L; x7R; x8L; x8R];
g = [g1L; g1R; g2L; g2R; g3L; g3R; g4L; g4R; g5L; g5R; g6L; g6R; g7L; g7R; g8L; g8R];

figure
boxplot(x,g,'PlotStyle','compact','symbol','')
title('Yaw forces across training')
ylabel('Yaw forces (Nm)')
xlabel('day')
ylim([-0.02 0.02])

[~,~,statsfy] = anova1(x,g,'off');

figure
cfy = multcompare(statsfy);
hold on
p = polyfit([1:2:15],statsfy.means(1,[1:2:15]),3); 
Yt = polyval(p,[1:1:16]);
plot(Yt,[16:-1:1]);
p = polyfit([2:2:16],statsfy.means(1,[2:2:16]),3); 
Yt = polyval(p,[1:1:16]);
plot(Yt,[16:-1:1]);
title('Yaw forces across training')


% day 1 vs day final only
x = [x1L; x1R; xFL; xFR];
g = [g1L; g1R; gFL; gFR];

figure
boxplot(x,g,'PlotStyle','compact','symbol','')
title('Yaw forces day 1 vs final')
ylabel('Yaw forces (Nm)')
xlabel('day')
ylim([-0.02 0.02])

[~,~,statsfyc] = anova1(x,g,'off');

figure
cfyc = multcompare(statsfyc);
title('Yaw forces day1 vs final')


end

