function [tortc] = plot_Ytortuosity_Dec(Decisions,ex,Col)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% calc tortuosity 
% day 1
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D1,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D1,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M3D1,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M4D1,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M5D1,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M6D1,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M7D1,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M8D1,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d1tort = tort;
g1 = repmat(1,size(tort));  
tortc.g1 = g1;
clear tort

% day 2
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D2,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D2,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M3D2,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M4D2,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M5D2,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M6D2,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M7D2,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M8D2,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d2tort = tort;
g2 = repmat(2,size(tort));
tortc.g2 = g2;
clear tort

% day 3
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D3,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D3,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M3D3,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M4D3,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M5D3,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M6D3,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M7D3,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M8D3,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d3tort = tort;
g3 = repmat(3,size(tort));
tortc.g3 = g3;
clear tort

% day 4
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D4,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D4,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M3D4,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M4D4,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M5D4,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M6D4,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M7D4,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M8D4,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d4tort = tort;
g4 = repmat(4,size(tort));
tortc.g4 = g4;
clear tort

% day 5
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D5,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D5,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M3D5,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M4D5,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M5D5,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M6D5,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M7D5,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M8D5,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d5tort = tort;
g5 = repmat(5,size(tort));
tortc.g5 = g5;
clear tort

% day 6
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D6,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D6,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M3D6,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M5D6,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M6D6,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M7D6,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M8D6,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d6tort = tort;
g6 = repmat(6,size(tort));
tortc.g6 = g6;
clear tort

% day 7
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D7,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D7,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M3D7,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M5D7,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M6D7,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M7D7,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M8D7,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d7tort = tort;
g7 = repmat(7,size(tort));
tortc.g7 = g7;
clear tort

% day 8
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D8,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D8,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M3D8,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M5D8,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M6D8,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M8D8,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d8tort = tort;
g8 = repmat(8,size(tort));
tortc.g8 = g8;
clear tort

% day 9
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D9,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D9,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M3D9,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d9tort = tort;
g9 = repmat(9,size(tort));
tortc.g9 = g9;
clear tort

% day 10
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D10,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D10,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d10tort = tort;
g10 = repmat(10,size(tort));
tortc.g10 = g10;
clear tort

% day 11
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D11,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D11,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d11tort = tort;
g11 = repmat(11,size(tort));
tortc.g11 = g11;
clear tort

% day 12
tort = [0]; % initialize
[tort] = gen_tortuosity_Dec(Decisions.M1D12,ex,tort);
[tort] = gen_tortuosity_Dec(Decisions.M2D12,ex,tort);
tort(1,:) = [];  % remove initialized row
tortc.d12tort = tort;
g12 = repmat(12,size(tort));
tortc.g12 = g12;
clear tort

x = [tortc.d1tort;tortc.d2tort;tortc.d3tort;tortc.d4tort;tortc.d5tort;...
    tortc.d6tort;tortc.d7tort;tortc.d8tort;tortc.d9tort;tortc.d10tort;...
    tortc.d11tort;tortc.d12tort];
g = [tortc.g1;tortc.g2;tortc.g3;tortc.g4;tortc.g5;tortc.g6;tortc.g7;...
    tortc.g8;tortc.g9;tortc.g10;tortc.g11;tortc.g12];

boxplot(x,g,'PlotStyle','compact','Colors',Col)
ylabel('tortuosity')
xlabel('session')


end

