function [tortc] = plot_Ytortuosity(Eightmaze)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% calc tortuosity 
% day 1
[tort] = gen_tortuosity(Eightmaze.M1D1);
d1tort = tort;
[tort] = gen_tortuosity(Eightmaze.M2D1);
d1tort = [tort;d1tort];
[tort] = gen_tortuosity(Eightmaze.M3D1);
d1tort = [tort;d1tort];
[tort] = gen_tortuosity(Eightmaze.M4D1);
d1tort = [tort;d1tort];
[tort] = gen_tortuosity(Eightmaze.M5D1);
d1tort = [tort;d1tort];

tortc.d1tort = d1tort;
g1 = repmat(1,size(d1tort));
tortc.g1 = g1;

% day 2
[tort] = gen_tortuosity(Eightmaze.M1D2);
d2tort = tort;
[tort] = gen_tortuosity(Eightmaze.M2D2);
d2tort = [tort;d2tort];
[tort] = gen_tortuosity(Eightmaze.M3D2);
d2tort = [tort;d2tort];
[tort] = gen_tortuosity(Eightmaze.M4D2);
d2tort = [tort;d2tort];
[tort] = gen_tortuosity(Eightmaze.M5D2);
d2tort = [tort;d2tort];

tortc.d2tort = d2tort;
g2 = repmat(2,size(d2tort));
tortc.g2 = g2;

% day 3
[tort] = gen_tortuosity(Eightmaze.M1D3);
d3tort = tort;
[tort] = gen_tortuosity(Eightmaze.M2D3);
d3tort = [tort;d3tort];
[tort] = gen_tortuosity(Eightmaze.M3D3);
d3tort = [tort;d3tort];
[tort] = gen_tortuosity(Eightmaze.M4D3);
d3tort = [tort;d3tort];
[tort] = gen_tortuosity(Eightmaze.M5D3);
d3tort = [tort;d3tort];

tortc.d3tort = d3tort;
g3 = repmat(3,size(d3tort));
tortc.g3 = g3;

% day 4
[tort] = gen_tortuosity(Eightmaze.M1D4);
d4tort = tort;
[tort] = gen_tortuosity(Eightmaze.M2D4);
d4tort = [tort;d4tort];
[tort] = gen_tortuosity(Eightmaze.M3D4);
d4tort = [tort;d4tort];
[tort] = gen_tortuosity(Eightmaze.M4D4);
d4tort = [tort;d4tort];
[tort] = gen_tortuosity(Eightmaze.M5D4);
d4tort = [tort;d4tort];

tortc.d4tort = d4tort;
g4 = repmat(4,size(d4tort));
tortc.g4 = g4;

% day 5
[tort] = gen_tortuosity(Eightmaze.M1D5);
d5tort = tort;
[tort] = gen_tortuosity(Eightmaze.M2D5);
d5tort = [tort;d5tort];
[tort] = gen_tortuosity(Eightmaze.M3D5);
d5tort = [tort;d5tort];
[tort] = gen_tortuosity(Eightmaze.M4D5);
d5tort = [tort;d5tort];
[tort] = gen_tortuosity(Eightmaze.M5D5);
d5tort = [tort;d5tort];

tortc.d5tort = d5tort;
g5 = repmat(5,size(d5tort));
tortc.g5 = g5;

% day 6
[tort] = gen_tortuosity(Eightmaze.M1D6);
d6tort = tort;
[tort] = gen_tortuosity(Eightmaze.M3D6);
d6tort = [tort;d6tort];

tortc.d6tort = d6tort;
g6 = repmat(6,size(d6tort));
tortc.g6 = g6;

% day 7
[tort] = gen_tortuosity(Eightmaze.M1D7);
d7tort = tort;
[tort] = gen_tortuosity(Eightmaze.M3D7);
d7tort = [tort;d7tort];

tortc.d7tort = d7tort;
g7 = repmat(7,size(d7tort));
tortc.g7 = g7;

% day 8
[tort] = gen_tortuosity(Eightmaze.M1D8);
d8tort = tort;
[tort] = gen_tortuosity(Eightmaze.M3D8);
d8tort = [tort;d8tort];

tortc.d8tort = d8tort;
g8 = repmat(8,size(d8tort));
tortc.g8 = g8;

x = [d1tort;d2tort;d3tort;d4tort;d5tort;d6tort;d7tort;d8tort];
g = [g1;g2;g3;g4;g5;g6;g7;g8];

boxplot(x,g,'PlotStyle','compact')
ylabel('tortuosity')
xlabel('session')


end

