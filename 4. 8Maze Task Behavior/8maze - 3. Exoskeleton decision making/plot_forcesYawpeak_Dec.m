function [statsfy,cfy] = plot_forcesYawpeak_Dec(Decisions,fit)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% DAY 1
% day 1 tL = positive (left) Yaw forces; 
x1L = [Decisions.M1D1.tL;...
       Decisions.M2D1.tL;...
       Decisions.M3D1.tL;...
       Decisions.M4D1.tL;...
       Decisions.M5D1.tL;...
       Decisions.M6D1.tL;...
       Decisions.M7D1.tL;...
       Decisions.M8D1.tL];
[x1L] = getFpeaks(x1L);   
g1L = [repmat({'D1L'},size(x1L))];

% day 1 tR = negative (right) Yaw forces
x1R = [Decisions.M1D1.tR;...
       Decisions.M2D1.tR;...
       Decisions.M3D1.tR;...
       Decisions.M4D1.tR;...
       Decisions.M5D1.tR;...
       Decisions.M6D1.tR;...
       Decisions.M7D1.tR;...
       Decisions.M8D1.tR];
[x1R] = getFpeaks(x1R);
g1R = [repmat({'D1R'},size(x1R))];

% DAY 2
% day 2 tL = positive (left) Yaw forces; 
% day 2 tL = positive (left) Yaw forces; 
x2L = [Decisions.M1D2.tL;...
       Decisions.M2D2.tL;...
       Decisions.M3D2.tL;...
       Decisions.M4D2.tL;...
       Decisions.M5D2.tL;...
       Decisions.M6D2.tL;...
       Decisions.M7D2.tL;...
       Decisions.M8D2.tL];
[x2L] = getFpeaks(x2L);
g2L = [repmat({'D2L'},size(x2L))];

% day 2 tR = negative (right) Yaw forces
x2R = [Decisions.M1D2.tR;...
       Decisions.M2D2.tR;...
       Decisions.M3D2.tR;...
       Decisions.M4D2.tR;...
       Decisions.M5D2.tR;...
       Decisions.M6D2.tR;...
       Decisions.M7D2.tR;...
       Decisions.M8D2.tR];
[x2R] = getFpeaks(x2R);
g2R = [repmat({'D2R'},size(x2R))];

% DAY 3
% day 3 tL = positive (left) Yaw forces; 
x3L = [Decisions.M1D3.tL;...
       Decisions.M2D3.tL;...
       Decisions.M3D3.tL;...
       Decisions.M4D3.tL;...
       Decisions.M5D3.tL;...
       Decisions.M6D3.tL;...
       Decisions.M7D3.tL;...
       Decisions.M8D3.tL];
[x3L] = getFpeaks(x3L);
g3L = [repmat({'D3L'},size(x3L))];

% day 3 tR = negative (right) Yaw forces
x3R = [Decisions.M1D3.tR;...
       Decisions.M2D3.tR;...
       Decisions.M3D3.tR;...
       Decisions.M4D3.tR;...
       Decisions.M5D3.tR;...
       Decisions.M6D3.tR;...
       Decisions.M7D3.tR;...
       Decisions.M8D3.tR];
[x3R] = getFpeaks(x3R);
g3R = [repmat({'D3R'},size(x3R))];

% DAY 4
% day 4 tL = positive (left) Yaw forces; 
x4L = [Decisions.M1D4.tL;...
       Decisions.M2D4.tL;...
       Decisions.M3D4.tL;...
       Decisions.M4D4.tL;...
       Decisions.M5D4.tL;...
       Decisions.M6D4.tL;...
       Decisions.M7D4.tL;...
       Decisions.M8D4.tL];
[x4L] = getFpeaks(x4L);
g4L = [repmat({'D4L'},size(x4L))];

% day 4 tR = negative (right) Yaw forces
x4R = [Decisions.M1D4.tR;...
       Decisions.M2D4.tR;...
       Decisions.M3D4.tR;...
       Decisions.M4D4.tR;...
       Decisions.M5D4.tR;...
       Decisions.M6D4.tR;...
       Decisions.M7D4.tR;...
       Decisions.M8D4.tR];
[x4R] = getFpeaks(x4R);
g4R = [repmat({'D4R'},size(x4R))];

% DAY 5
% day 5 tL = positive (left) Yaw forces; 
x5L = [Decisions.M1D5.tL;...
       Decisions.M2D5.tL;...
       Decisions.M3D5.tL;...
       Decisions.M4D5.tL;...
       Decisions.M5D5.tL;...
       Decisions.M6D5.tL;...
       Decisions.M7D5.tL;...
       Decisions.M8D5.tL];
[x5L] = getFpeaks(x5L);
g5L = [repmat({'D5L'},size(x5L))];

% day 5 tR = negative (right) Yaw forces
x5R = [Decisions.M1D5.tR;...
       Decisions.M2D5.tR;...
       Decisions.M3D5.tR;...
       Decisions.M4D5.tR;...
       Decisions.M5D5.tR;...
       Decisions.M6D5.tR;...
       Decisions.M7D5.tR;...
       Decisions.M8D5.tR];
[x5R] = getFpeaks(x5R);
g5R = [repmat({'D5R'},size(x5R))];

% DAY 6
% day 6 tL = positive (left) Yaw forces; 
x6L = [Decisions.M1D6.tL;...
       Decisions.M2D6.tL;...
       Decisions.M3D6.tL;...
       Decisions.M5D6.tL;...
       Decisions.M6D6.tL;...
       Decisions.M7D6.tL;...
       Decisions.M8D6.tL];
[x6L] = getFpeaks(x6L);
g6L = [repmat({'D6L'},size(x6L))];

% day 6 tR = negative (right) Yaw forces
x6R = [Decisions.M1D6.tR;...
       Decisions.M2D6.tR;...
       Decisions.M3D6.tR;...
       Decisions.M5D6.tR;...
       Decisions.M6D6.tR;...
       Decisions.M7D6.tR;...
       Decisions.M8D6.tR];
[x6R] = getFpeaks(x6R);
g6R = [repmat({'D6R'},size(x6R))];

% DAY 7
% day 7 tL = positive (left) Yaw forces; 
x7L = [Decisions.M1D7.tL;...
       Decisions.M2D7.tL;...       
       Decisions.M3D7.tL;...
       Decisions.M5D7.tL;...
       Decisions.M6D7.tL;...
       Decisions.M7D7.tL;...
       Decisions.M8D7.tL];
[x7L] = getFpeaks(x7L);
g7L = [repmat({'D7L'},size(x7L))];

% day 7 tR = negative (right) Yaw forces
x7R = [Decisions.M1D7.tR;...
       Decisions.M2D7.tR;...
       Decisions.M3D7.tR;...
       Decisions.M5D7.tR;...
       Decisions.M6D7.tR;...
       Decisions.M7D7.tR;...
       Decisions.M8D7.tR];
[x7R] = getFpeaks(x7R);
g7R = [repmat({'D7R'},size(x7R))];

% DAY 8
% day 8 tL = positive (left) Yaw forces; 
x8L = [Decisions.M1D8.tL;...
       Decisions.M2D8.tL;...
       Decisions.M3D8.tL;...
       Decisions.M5D8.tL;...
       Decisions.M6D8.tL;...
       Decisions.M8D8.tL];
[x8L] = getFpeaks(x8L);
g8L = [repmat({'D8L'},size(x8L))];

% day 8 tR = negative (right) Yaw forces
x8R = [Decisions.M1D8.tR;...
       Decisions.M2D8.tR;...       
       Decisions.M3D8.tR;...
       Decisions.M5D8.tR;...
       Decisions.M6D8.tR;...       
       Decisions.M8D8.tR];
[x8R] = getFpeaks(x8R);
g8R = [repmat({'D8R'},size(x8R))];


% DAY 9
% day 9 tL = positive (left) Yaw forces; 
x9L = [Decisions.M1D9.tL;...
       Decisions.M2D9.tL;...
       Decisions.M3D9.tL];
[x9L] = getFpeaks(x9L);
g9L = [repmat({'D9L'},size(x9L))];

% day 9 tR = negative (right) Yaw forces
x9R = [Decisions.M1D9.tR;...
       Decisions.M2D9.tR;...       
       Decisions.M3D9.tR];
[x9R] = getFpeaks(x9R);
g9R = [repmat({'D9R'},size(x9R))];

% DAY 10
% day 10 tL = positive (left) Yaw forces; 
x10L = [Decisions.M1D10.tL;...
       Decisions.M2D10.tL];
[x10L] = getFpeaks(x10L);
g10L = [repmat({'D10L'},size(x10L))];

% day 10 tR = negative (right) Yaw forces
x10R = [Decisions.M1D10.tR;...
       Decisions.M2D10.tR];
[x10R] = getFpeaks(x10R);
g10R = [repmat({'D10R'},size(x10R))];

% DAY 11
% day 11 tL = positive (left) Yaw forces; 
x11L = [Decisions.M1D11.tL;...
       Decisions.M2D11.tL];
[x11L] = getFpeaks(x11L);
g11L = [repmat({'D11L'},size(x11L))];

% day 11 tR = negative (right) Yaw forces
x11R = [Decisions.M1D11.tR;...
       Decisions.M2D11.tR];
[x11R] = getFpeaks(x11R);
g11R = [repmat({'D11R'},size(x11R))];

% DAY 12
% day 12 tL = positive (left) Yaw forces; 
x12L = [Decisions.M1D12.tL;...
       Decisions.M2D12.tL];
[x12L] = getFpeaks(x12L);
g12L = [repmat({'D12L'},size(x12L))];

% day 12 tR = negative (right) Yaw forces
x12R = [Decisions.M1D12.tR;...
       Decisions.M2D12.tR];
[x12R] = getFpeaks(x12R);
g12R = [repmat({'D12R'},size(x12R))];


x = [x1L; x1R; x2L; x2R; x3L; x3R; x4L; x4R; x5L; x5R; x6L; x6R; ...
    x7L; x7R; x8L; x8R; x9L; x9R; x10L; x10R; x11L; x11R; x12L; x12R];
g = [g1L; g1R; g2L; g2R; g3L; g3R; g4L; g4R; g5L; g5R; g6L; g6R;...
    g7L; g7R; g8L; g8R; g9L; g9R; g10L; g10R; g11L; g11R; g12L; g12R];

figure
boxplot(x,g,'PlotStyle','compact','symbol','')
title('Yaw peak forces across training')
ylabel('Yaw forces (Nm)')
xlabel('day')
ylim([-0.02 0.02])

[~,~,statsfy] = anova1(x,g,'off');

figure
cfy = multcompare(statsfy);
hold on
p = polyfit([1:2:23],statsfy.means(1,[1:2:23]),fit); 
Yt = polyval(p,[1:1:24]);
plot(Yt,[24:-1:1]);
p = polyfit([2:2:24],statsfy.means(1,[2:2:24]),fit); 
Yt = polyval(p,[1:1:24]);
plot(Yt,[24:-1:1]);
title('Yaw peak forces across training')



end

