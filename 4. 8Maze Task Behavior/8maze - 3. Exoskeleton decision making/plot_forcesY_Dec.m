function [statsfy,cfy] = plot_forcesY_Dec(Decisions,fit)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% DAY 1
% day 1 fL = positive (left) Y forces; 
x1L = [Decisions.M1D1.fL;...
       Decisions.M2D1.fL;...
       Decisions.M3D1.fL;...
       Decisions.M4D1.fL;...
       Decisions.M5D1.fL;...
       Decisions.M6D1.fL;...
       Decisions.M7D1.fL;...
       Decisions.M8D1.fL];

g1L = [repmat({'D1L'},size(x1L))];

% day 1 fR = negative (right) Y forces
x1R = [Decisions.M1D1.fR;...
       Decisions.M2D1.fR;...
       Decisions.M3D1.fR;...
       Decisions.M4D1.fR;...
       Decisions.M5D1.fR;...
       Decisions.M6D1.fR;...
       Decisions.M7D1.fR;...
       Decisions.M8D1.fR];

g1R = [repmat({'D1R'},size(x1R))];

% DAY 2
% day 2 fL = positive (left) Y forces; 
x2L = [Decisions.M1D2.fL;...
       Decisions.M2D2.fL;...
       Decisions.M3D2.fL;...
       Decisions.M4D2.fL;...
       Decisions.M5D2.fL;...
       Decisions.M6D2.fL;...
       Decisions.M7D2.fL;...
       Decisions.M8D2.fL];

g2L = [repmat({'D2L'},size(x2L))];

% day 2 fR = negative (right) Y forces
x2R = [Decisions.M1D2.fR;...
       Decisions.M2D2.fR;...
       Decisions.M3D2.fR;...
       Decisions.M4D2.fR;...
       Decisions.M5D2.fR;...
       Decisions.M6D2.fR;...
       Decisions.M7D2.fR;...
       Decisions.M8D2.fR];

g2R = [repmat({'D2R'},size(x2R))];

% DAY 3
% day 3 fL = positive (left) Y forces; 
x3L = [Decisions.M1D3.fL;...
       Decisions.M2D3.fL;...
       Decisions.M3D3.fL;...
       Decisions.M4D3.fL;...
       Decisions.M5D3.fL;...
       Decisions.M6D3.fL;...
       Decisions.M7D3.fL;...
       Decisions.M8D3.fL];

g3L = [repmat({'D3L'},size(x3L))];

% day 3 fR = negative (right) Y forces
x3R = [Decisions.M1D3.fR;...
       Decisions.M2D3.fR;...
       Decisions.M3D3.fR;...
       Decisions.M4D3.fR;...
       Decisions.M5D3.fR;...
       Decisions.M6D3.fR;...
       Decisions.M7D3.fR;...
       Decisions.M8D3.fR];

g3R = [repmat({'D3R'},size(x3R))];

% DAY 4
% day 4 fL = positive (left) Y forces; 
x4L = [Decisions.M1D4.fL;...
       Decisions.M2D4.fL;...
       Decisions.M3D4.fL;...
       Decisions.M4D4.fL;...
       Decisions.M5D4.fL;...
       Decisions.M6D4.fL;...
       Decisions.M7D4.fL;...
       Decisions.M8D4.fL];

g4L = [repmat({'D4L'},size(x4L))];

% day 4 fR = negative (right) Y forces
x4R = [Decisions.M1D4.fR;...
       Decisions.M2D4.fR;...
       Decisions.M3D4.fR;...
       Decisions.M4D4.fR;...
       Decisions.M5D4.fR;...
       Decisions.M6D4.fR;...
       Decisions.M7D4.fR;...
       Decisions.M8D4.fR];

g4R = [repmat({'D4R'},size(x4R))];

% DAY 5
% day 5 fL = positive (left) Y forces; 
x5L = [Decisions.M1D5.fL;...
       Decisions.M2D5.fL;...
       Decisions.M3D5.fL;...
       Decisions.M4D5.fL;...
       Decisions.M5D5.fL;...
       Decisions.M6D5.fL;...
       Decisions.M7D5.fL;...
       Decisions.M8D5.fL];

g5L = [repmat({'D5L'},size(x5L))];

% day 5 fR = negative (right) Y forces
x5R = [Decisions.M1D5.fR;...
       Decisions.M2D5.fR;...
       Decisions.M3D5.fR;...
       Decisions.M4D5.fR;...
       Decisions.M5D5.fR;...
       Decisions.M6D5.fR;...
       Decisions.M7D5.fR;...
       Decisions.M8D5.fR];

g5R = [repmat({'D5R'},size(x5R))];

% DAY 6
% day 6 fL = positive (left) Y forces; 
x6L = [Decisions.M1D6.fL;...
       Decisions.M2D6.fL;...
       Decisions.M3D6.fL;...
       Decisions.M5D6.fL;...
       Decisions.M6D6.fL;...
       Decisions.M7D6.fL;...
       Decisions.M8D6.fL];

g6L = [repmat({'D6L'},size(x6L))];

% day 6 fR = negative (right) Y forces
x6R = [Decisions.M1D6.fR;...
       Decisions.M2D6.fR;...
       Decisions.M3D6.fR;...
       Decisions.M5D6.fR;...
       Decisions.M6D6.fR;...
       Decisions.M7D6.fR;...
       Decisions.M8D6.fR];

g6R = [repmat({'D6R'},size(x6R))];

% DAY 7
% day 7 fL = positive (left) Y forces; 
x7L = [Decisions.M1D7.fL;...
       Decisions.M2D7.fL;...       
       Decisions.M3D7.fL;...
       Decisions.M5D7.fL;...
       Decisions.M6D7.fL;...
       Decisions.M7D7.fL;...
       Decisions.M8D7.fL];

g7L = [repmat({'D7L'},size(x7L))];

% day 7 fR = negative (right) Y forces
x7R = [Decisions.M1D7.fR;...
       Decisions.M2D7.fR;...
       Decisions.M3D7.fR;...
       Decisions.M5D7.fR;...
       Decisions.M6D7.fR;...
       Decisions.M7D7.fR;...
       Decisions.M8D7.fR];

g7R = [repmat({'D7R'},size(x7R))];

% DAY 8
% day 8 fL = positive (left) Y forces; 
x8L = [Decisions.M1D8.fL;...
       Decisions.M2D8.fL;...
       Decisions.M3D8.fL;...
       Decisions.M5D8.fL;...
       Decisions.M6D8.fL;...
       Decisions.M8D8.fL];

g8L = [repmat({'D8L'},size(x8L))];

% day 8 fR = negative (right) Y forces
x8R = [Decisions.M1D8.fR;...
       Decisions.M2D8.fR;...       
       Decisions.M3D8.fR;...
       Decisions.M5D8.fR;...
       Decisions.M6D8.fR;...       
       Decisions.M8D8.fR];

g8R = [repmat({'D8R'},size(x8R))];


% DAY 9
% day 9 fL = positive (left) Y forces; 
x9L = [Decisions.M1D9.fL;...
       Decisions.M2D9.fL;...
       Decisions.M3D9.fL];

g9L = [repmat({'D9L'},size(x9L))];

% day 9 fR = negative (right) Y forces
x9R = [Decisions.M1D9.fR;...
       Decisions.M2D9.fR;...       
       Decisions.M3D9.fR];

g9R = [repmat({'D9R'},size(x9R))];

% DAY 10
% day 10 fL = positive (left) Y forces; 
x10L = [Decisions.M1D10.fL;...
       Decisions.M2D10.fL];

g10L = [repmat({'D10L'},size(x10L))];

% day 10 fR = negative (right) Y forces
x10R = [Decisions.M1D10.fR;...
       Decisions.M2D10.fR];

g10R = [repmat({'D10R'},size(x10R))];

% DAY 11
% day 11 fL = positive (left) Y forces; 
x11L = [Decisions.M1D11.fL;...
       Decisions.M2D11.fL];

g11L = [repmat({'D11L'},size(x11L))];

% day 11 fR = negative (right) Y forces
x11R = [Decisions.M1D11.fR;...
       Decisions.M2D11.fR];

g11R = [repmat({'D11R'},size(x11R))];

% DAY 12
% day 12 fL = positive (left) Y forces; 
x12L = [Decisions.M1D12.fL;...
       Decisions.M2D12.fL];

g12L = [repmat({'D12L'},size(x12L))];

% day 12 fR = negative (right) Y forces
x12R = [Decisions.M1D12.fR;...
       Decisions.M2D12.fR];

g12R = [repmat({'D12R'},size(x12R))];


x = [x1L; x1R; x2L; x2R; x3L; x3R; x4L; x4R; x5L; x5R; x6L; x6R; ...
    x7L; x7R; x8L; x8R; x9L; x9R; x10L; x10R; x11L; x11R; x12L; x12R];
g = [g1L; g1R; g2L; g2R; g3L; g3R; g4L; g4R; g5L; g5R; g6L; g6R;...
    g7L; g7R; g8L; g8R; g9L; g9R; g10L; g10R; g11L; g11R; g12L; g12R];

figure
boxplot(x,g,'PlotStyle','compact','symbol','')
title('Y forces across training')
ylabel('Y forces (N)')
xlabel('day')
ylim([-1 1])

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
title('Y forces across training')




end

