function [statsfy,cfy,statsfyc,cfyc] = plot_forcesYpeak(Eightmaze)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% DAY 1
% day 1 fL = positive (left) Y forces; 
x1L = [Eightmaze.M1D1.fL;...
       Eightmaze.M2D1.fL;...
       Eightmaze.M3D1.fL;...
       Eightmaze.M4D1.fL;...
       Eightmaze.M5D1.fL];
[x1L] = getFpeaks(x1L);   
g1L = [repmat({'D1L'},size(x1L))];

% day 1 fR = negative (right) Y forces
x1R = [Eightmaze.M1D1.fR;...
       Eightmaze.M2D1.fR;...
       Eightmaze.M3D1.fR;...
       Eightmaze.M4D1.fR;...
       Eightmaze.M5D1.fR];
[x1R] = getFpeaks(x1R);
g1R = [repmat({'D1R'},size(x1R))];

% DAY 2
% day 2 fL = positive (left) Y forces; 
x2L = [Eightmaze.M1D2.fL;...
       Eightmaze.M2D2.fL;...
       Eightmaze.M3D2.fL;...
       Eightmaze.M4D2.fL;...
       Eightmaze.M5D2.fL];
[x2L] = getFpeaks(x2L);
g2L = [repmat({'D2L'},size(x2L))];

% day 2 fR = negative (right) Y forces
x2R = [Eightmaze.M1D2.fR;...
       Eightmaze.M2D2.fR;...
       Eightmaze.M3D2.fR;...
       Eightmaze.M4D2.fR;...
       Eightmaze.M5D2.fR];
[x2R] = getFpeaks(x2R);
g2R = [repmat({'D2R'},size(x2R))];

% DAY 3
% day 3 fL = positive (left) Y forces; 
x3L = [Eightmaze.M1D3.fL;...
       Eightmaze.M2D3.fL;...
       Eightmaze.M3D3.fL;...
       Eightmaze.M4D3.fL;...
       Eightmaze.M5D3.fL];
[x3L] = getFpeaks(x3L);
g3L = [repmat({'D3L'},size(x3L))];

% day 3 fR = negative (right) Y forces
x3R = [Eightmaze.M1D3.fR;...
       Eightmaze.M2D3.fR;...
       Eightmaze.M3D3.fR;...
       Eightmaze.M4D3.fR;...
       Eightmaze.M5D3.fR];
[x3R] = getFpeaks(x3R);
g3R = [repmat({'D3R'},size(x3R))];

% DAY 4
% day 4 fL = positive (left) Y forces; 
x4L = [Eightmaze.M1D4.fL;...
       Eightmaze.M2D4.fL;...
       Eightmaze.M3D4.fL;...
       Eightmaze.M4D4.fL;...
       Eightmaze.M5D4.fL];
[x4L] = getFpeaks(x4L);
g4L = [repmat({'D4L'},size(x4L))];

% day 4 fR = negative (right) Y forces
x4R = [Eightmaze.M1D4.fR;...
       Eightmaze.M2D4.fR;...
       Eightmaze.M3D4.fR;...
       Eightmaze.M4D4.fR;...
       Eightmaze.M5D4.fR];
[x4R] = getFpeaks(x4R);
g4R = [repmat({'D4R'},size(x4R))];

% DAY 5
% day 5 fL = positive (left) Y forces; 
x5L = [Eightmaze.M1D5.fL;...
       Eightmaze.M2D5.fL;...
       Eightmaze.M3D5.fL;...
       Eightmaze.M4D5.fL;...
       Eightmaze.M5D5.fL];
[x5L] = getFpeaks(x5L);
g5L = [repmat({'D5L'},size(x5L))];

% day 5 fR = negative (right) Y forces
x5R = [Eightmaze.M1D5.fR;...
       Eightmaze.M2D5.fR;...
       Eightmaze.M3D5.fR;...
       Eightmaze.M4D5.fR;...
       Eightmaze.M5D5.fR];
[x5R] = getFpeaks(x5R);
g5R = [repmat({'D5R'},size(x5R))];

% DAY 6
% day 6 fL = positive (left) Y forces; 
x6L = [Eightmaze.M1D6.fL;...
       Eightmaze.M3D6.fL];
[x6L] = getFpeaks(x6L);
g6L = [repmat({'D6L'},size(x6L))];

% day 6 fR = negative (right) Y forces
x6R = [Eightmaze.M1D6.fR;...
       Eightmaze.M3D6.fR];
[x6R] = getFpeaks(x6R);
g6R = [repmat({'D6R'},size(x6R))];

% DAY 7
% day 7 fL = positive (left) Y forces; 
x7L = [Eightmaze.M1D7.fL;...
       Eightmaze.M3D7.fL];
[x7L] = getFpeaks(x7L);
g7L = [repmat({'D7L'},size(x7L))];

% day 7 fR = negative (right) Y forces
x7R = [Eightmaze.M1D7.fR;...
       Eightmaze.M3D7.fR];
[x7R] = getFpeaks(x7R);
g7R = [repmat({'D7R'},size(x7R))];

% DAY 8
% day 8 fL = positive (left) Y forces; 
x8L = [Eightmaze.M1D8.fL;...
       Eightmaze.M3D8.fL];
[x8L] = getFpeaks(x8L);
g8L = [repmat({'D8L'},size(x8L))];

% day 8 fR = negative (right) Y forces
x8R = [Eightmaze.M1D8.fR;...
       Eightmaze.M3D8.fR];
[x8R] = getFpeaks(x8R);
g8R = [repmat({'D8R'},size(x8R))];


% DAY FINAL
% day FINAL fL = positive (left) Y forces; 
xFL = [Eightmaze.M1D8.fL;...
       Eightmaze.M2D5.fL;...
       Eightmaze.M3D8.fL;...
       Eightmaze.M4D5.fL;...
       Eightmaze.M5D5.fL];
[xFL] = getFpeaks(xFL);
gFL = [repmat({'DFL'},size(xFL))];

% day FINAL fR = negative (right) Y forces
xFR = [Eightmaze.M1D8.fR;...
       Eightmaze.M2D5.fR;...
       Eightmaze.M3D8.fR;...
       Eightmaze.M4D5.fR;...
       Eightmaze.M5D5.fR];
[xFR] = getFpeaks(xFR);
gFR = [repmat({'DFR'},size(xFR))];


x = [x1L; x1R; x2L; x2R; x3L; x3R; x4L; x4R; x5L; x5R; x6L; x6R; x7L; x7R; x8L; x8R];
g = [g1L; g1R; g2L; g2R; g3L; g3R; g4L; g4R; g5L; g5R; g6L; g6R; g7L; g7R; g8L; g8R];
figure

boxplot(x,g,'PlotStyle','compact','symbol','')
title('Y peak forces across training')
ylabel('Y forces (N)')
xlabel('day')
ylim([-1 1])

[~,~,statsfy] = anova1(x,g,'off');

F = range(statsfy.means)/range([x1L; x1R; x2L; x2R; x3L; x3R; x4L; x4R; x5L; x5R; x6L; x6R; x7L; x7R; x8L; x8R]);
statsfy.F = F;

figure
cfy = multcompare(statsfy);
hold on
p = polyfit([1:2:15],statsfy.means(1,[1:2:15]),3); 
Yt = polyval(p,[1:1:16]);
plot(Yt,[16:-1:1]);
p = polyfit([2:2:16],statsfy.means(1,[2:2:16]),3); 
Yt = polyval(p,[1:1:16]);
plot(Yt,[16:-1:1]);
title('Y peak forces across training')


% day 1 vs day final only
x = [x1L; x1R; xFL; xFR];
g = [g1L; g1R; gFL; gFR];

figure
boxplot(x,g,'PlotStyle','compact','symbol','')
title('Y peak forces day 1 vs final')
ylabel('Y forces (N)')
xlabel('day')
ylim([-1 1])

[~,~,statsfyc] = anova1(x,g,'off');

figure
cfyc = multcompare(statsfyc);
title('Y peak forces day1 vs final')

end

