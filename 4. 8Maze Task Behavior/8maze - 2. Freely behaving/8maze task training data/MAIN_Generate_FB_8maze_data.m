% GENERATE FB_8maze.mat 
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all

% This script contains the raw data of mouse performance in the 8maze 
% alternating task during training while freely behaving. 
% MxDx indicates Mouse x Day x, e.g. M1D5 = Mouse 1 Day 5
% Mice first train with both doors in place: MxDxT
% Then the goal arm door is removed so that mice make decisions: MxDxD

% The script processes the data from each trial to generate several 
% variables for analysis. These are: 
% score       score for that session. 1 = correct; 0 = wrong way; 
%               -1 = incorrect
% correct     number of correct trials (1)
% incorrect   number of incorrect trials (-1)
% wrongway    number of wrong way trials (0)
% perf        percentage correct trials
% co          number of correct left and right turn trials [L R];
% inc         number of incorrect left and right turn trials [L R];
% wrg         number of wrongway left and right turn trials [L R];


%% Convert raw data to score and then generate variables from score
% Mouse 1 (0829)
FB_8maze.M1D1T.score = [1	1	1	0	1	1	0	1	1	0	1	1	0	0	0	0	0	1	0	1	1	0]';
[FB_8maze.M1D1T] = Analyze_8mazedata(FB_8maze.M1D1T);
FB_8maze.M1D2T.score = [1	1	1	0	1	0	1	1	1	1	1	0	0	0	1	1	0	0	0	0	0	1	1	1	0	0	0	1	0]';
[FB_8maze.M1D2T] = Analyze_8mazedata(FB_8maze.M1D2T);
FB_8maze.M1D3T.score = [1	1	1	1	1	0	0	0	1	0	1	0	0	1	1	0	1	0	0	1	1	0	1	0	1	1	0	1	1	1	1	1	1	1	0	0	1	1	1	1	1	1	1	0	0	0	1	1	1	0	1	0]';
[FB_8maze.M1D3T] = Analyze_8mazedata(FB_8maze.M1D3T);
FB_8maze.M1D4T.score = [1	1	1	1	1	1	1	1	0	1	1	1	0	1	1	1	0	1	1	1	1	1	0	1	0	1	0	1	1	1	0	1	1	1	1	1	1	1	0	0	0	0	1	1	1	1]';
[FB_8maze.M1D4T] = Analyze_8mazedata(FB_8maze.M1D4T);
FB_8maze.M1D5T.score = [1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	0	1	1	1	1	1	0	1	1	0	1	1	0	1	1	1	1	1]';
[FB_8maze.M1D5T] = Analyze_8mazedata(FB_8maze.M1D5T);

FB_8maze.M1D1D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	-1	-1	1	1	1	0	-1	1	-1	1	-1	-1	1	1	1	1	0	1	1	-1	1	1	1	1	1]';
[FB_8maze.M1D1D] = Analyze_8mazedata(FB_8maze.M1D1D);
FB_8maze.M1D2D.score = [1	1	1	1	1	1	1	1	1	1	-1	1	1	-1	-1	1	-1	-1	1	1	1	1	1	-1	1	1	1	1	1	1	1	1	1	1	-1	1	1	1	1	0	1	1	1]';
[FB_8maze.M1D2D] = Analyze_8mazedata(FB_8maze.M1D2D);
FB_8maze.M1D3D.score = [1	0	1	-1	1	0	-1	1	1	1	1	1	1	1	1	1	-1	1	-1	-1	1	0	1	1	-1	1	1	1	1	1	1	1	1	-1	1	1	1	1	0	1	1	1	1	1	-1	-1	1	1	1]';
[FB_8maze.M1D3D] = Analyze_8mazedata(FB_8maze.M1D3D);
FB_8maze.M1D4D.score = [1	-1	1	1	-1	1	0	-1	1	1	-1	1	1	-1	1	1	-1	0	1	1	1	1	1	1	1	1	1	-1	1	1	1	1	1	1	1	1	1	1	-1	1	1	1	1	1	1	1	1	1	-1	1]';
[FB_8maze.M1D4D] = Analyze_8mazedata(FB_8maze.M1D4D);
FB_8maze.M1D5D.score = [1	1	1	1	1	1	1	1	0	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M1D5D] = Analyze_8mazedata(FB_8maze.M1D5D);
FB_8maze.M1D6D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	-1	1	1	1	1	1	1	1	1	1	-1	1	1	1	1	0	1	1	1	1]';
[FB_8maze.M1D6D] = Analyze_8mazedata(FB_8maze.M1D6D);
FB_8maze.M1D7D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M1D7D] = Analyze_8mazedata(FB_8maze.M1D7D);
FB_8maze.M1D8D.score = [-1	1	1	-1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M1D8D] = Analyze_8mazedata(FB_8maze.M1D8D);


% Mouse 2 (0830)
FB_8maze.M2D1T.score = [1	0	1	1	1	1	1	0	0	1	1	1	1	0	1	0	1	1	0	1	0	0	0	0	1	0	0]';
[FB_8maze.M2D1T] = Analyze_8mazedata(FB_8maze.M2D1T);
FB_8maze.M2D2T.score = [1	1	1	1	1	0	1	1	1	1	1	0	1	1	1	0	0	1	0	0	1	0	0	1	1	0	1	0	0	0	0]';
[FB_8maze.M2D2T] = Analyze_8mazedata(FB_8maze.M2D2T);
FB_8maze.M2D3T.score = [1	1	1	1	1	0	1	0	0	1	1	0	0	1	0	0	1	0	0	1	1	0	1	0	1	0	0	1	1	1	1	0	1	1	1	0	1	0	0	1	1	1	1	1	1	1	1	1	1	0	0	1	1]';
[FB_8maze.M2D3T] = Analyze_8mazedata(FB_8maze.M2D3T);
FB_8maze.M2D4T.score = [1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	0	1	1	1	0	1	0	1	1	0	1	0	1	1	1	0	1]';
[FB_8maze.M2D4T] = Analyze_8mazedata(FB_8maze.M2D4T);
FB_8maze.M2D5T.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	0	0	0	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	0	1	1	1	1	1	1	0	1]';
[FB_8maze.M2D5T] = Analyze_8mazedata(FB_8maze.M2D5T);

FB_8maze.M2D1D.score = [1	1	1	1	1	1	1	1	1	1	1	1	0	0	-1	-1	1	1	1	1	1	0	1	1	-1	1	1	1	0	0	-1	0	1	1	1	-1	1	1	1	1	-1	1	1	0	-1	1	1	1	1	0]';
[FB_8maze.M2D1D] = Analyze_8mazedata(FB_8maze.M2D1D);
FB_8maze.M2D2D.score = [1	1	1	1	1	1	1	1	1	-1	1	1	-1	1	1	-1	1	1	1	1	1	1	1	1	-1	-1	1	1	1	0	1	-1	1	0	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M2D2D] = Analyze_8mazedata(FB_8maze.M2D2D);
FB_8maze.M2D3D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	-1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	-1	1	1	1	1	1	1]';
[FB_8maze.M2D3D] = Analyze_8mazedata(FB_8maze.M2D3D);
FB_8maze.M2D4D.score = [1	1	-1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	-1	1	1	1	-1	1	-1	1	1]';
[FB_8maze.M2D4D] = Analyze_8mazedata(FB_8maze.M2D4D);
FB_8maze.M2D5D.score = [1	1	1	1	-1	1	1	1	1	1	1	1	1	1	1	0	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M2D5D] = Analyze_8mazedata(FB_8maze.M2D5D);
FB_8maze.M2D6D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M2D6D] = Analyze_8mazedata(FB_8maze.M2D6D);
FB_8maze.M2D7D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	-1	1	1	1	1	1	1	1]';
[FB_8maze.M2D7D] = Analyze_8mazedata(FB_8maze.M2D7D);
FB_8maze.M2D8D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	-1	1	1	1	0	1	1	1	1	1]';
[FB_8maze.M2D8D] = Analyze_8mazedata(FB_8maze.M2D8D);


% Mouse 3 (0837)
FB_8maze.M3D1T.score = [1	1	0	1	1	1	1	1	1	0	1	0	0	1	1	0	1	0	0	0	0]';
[FB_8maze.M3D1T] = Analyze_8mazedata(FB_8maze.M3D1T);
FB_8maze.M3D2T.score = [1	1	0	1	1	1	1	0	1	1	1	0	0	0	0	0	1	1	0	0	0	1	1	1	0	0]';
[FB_8maze.M3D2T] = Analyze_8mazedata(FB_8maze.M3D2T);
FB_8maze.M3D3T.score = [1	0	1	1	1	1	1	0	1	0	0	0	1	1	0	1	0	1	0	1	0	0	0	1	1	1	1	0	0	0	1	1	0	0	0	1	1	1	1	1	0]';
[FB_8maze.M3D3T] = Analyze_8mazedata(FB_8maze.M3D3T);
FB_8maze.M3D4T.score = [1	1	1	1	1	1	1	0	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	0	1	0	1	1	1	1	0	0	0	1	0	1	1]';
[FB_8maze.M3D4T] = Analyze_8mazedata(FB_8maze.M3D4T);
FB_8maze.M3D5T.score = [1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	0	1	0	1]';
[FB_8maze.M3D5T] = Analyze_8mazedata(FB_8maze.M3D5T);

FB_8maze.M3D1D.score = [1	1	1	1	1	1	1	1	0	1	1	1	0	-1	1	-1	1	1	0	-1	1	1	0	0	1	1	1	-1	1	1	1	1	1	1	1	1	1	0	0	1	1	1	1	0	0	1	1	1]';
[FB_8maze.M3D1D] = Analyze_8mazedata(FB_8maze.M3D1D);
FB_8maze.M3D2D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	0	1	1	1	1	1	-1	1	1	1	1	1	1	1	1]';
[FB_8maze.M3D2D] = Analyze_8mazedata(FB_8maze.M3D2D);
FB_8maze.M3D3D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	0	1	1	-1	1	1	1	-1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M3D3D] = Analyze_8mazedata(FB_8maze.M3D3D);
FB_8maze.M3D4D.score = [1	1	1	1	1	1	1	1	1	-1	1	1	1	1	1	-1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	0	1	-1	1	1	1	0	-1	1	1	1	1]';
[FB_8maze.M3D4D] = Analyze_8mazedata(FB_8maze.M3D4D);
FB_8maze.M3D5D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	-1	-1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M3D5D] = Analyze_8mazedata(FB_8maze.M3D5D);
FB_8maze.M3D6D.score = [1	1	-1	1	1	-1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M3D6D] = Analyze_8mazedata(FB_8maze.M3D6D);
FB_8maze.M3D7D.score = [1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M3D7D] = Analyze_8mazedata(FB_8maze.M3D7D);
FB_8maze.M3D8D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1]';
[FB_8maze.M3D8D] = Analyze_8mazedata(FB_8maze.M3D8D);


% Mouse 4 (0881)
FB_8maze.M4D1T.score = [1	1	1	0	0	1	1	1	1	1	1	1	0	1	0	1	1	1	0	0	1	1	1	0	0	1	0	1	1	1	0	1	0]';
[FB_8maze.M4D1T] = Analyze_8mazedata(FB_8maze.M4D1T);
FB_8maze.M4D2T.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	0	1	1	1	1	1	0	1	1	1	1	1	1	0	1	1]';
[FB_8maze.M4D2T] = Analyze_8mazedata(FB_8maze.M4D2T);
FB_8maze.M4D3T.score = [1	1	1	1	1	1	0	1	1	1	1	1	0	1	1	1	0	0	0	1	1	0	0	1	0	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M4D3T] = Analyze_8mazedata(FB_8maze.M4D3T);
FB_8maze.M4D4T.score = [1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	0	1	1	0	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	0	1	1	0	1	1	1]';
[FB_8maze.M4D4T] = Analyze_8mazedata(FB_8maze.M4D4T);
FB_8maze.M4D5T.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	0	1	1	0	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M4D5T] = Analyze_8mazedata(FB_8maze.M4D5T);

FB_8maze.M4D1D.score = [1	1	1	0	0	1	1	1	1	1	1	1	-1	1	1	0	-1	1	0	1	1	1	1	0	1	1	1	1	1	1	-1	1	0	0	1	0	0	0	1	1	1	1	1	1	1	1	1	0	0	0	1	1]';
[FB_8maze.M4D1D] = Analyze_8mazedata(FB_8maze.M4D1D);
FB_8maze.M4D2D.score = [1	0	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	-1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	0	1	1	1	1	1	1	0	0	0	1]';
[FB_8maze.M4D2D] = Analyze_8mazedata(FB_8maze.M4D2D);
FB_8maze.M4D3D.score = [1	1	1	1	1	1	1	1	1	-1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	-1	1	1	1	-1	1	1]';
[FB_8maze.M4D3D] = Analyze_8mazedata(FB_8maze.M4D3D);
FB_8maze.M4D4D.score = [1	1	1	1	1	1	1	1	1	1	1	0	1	1	0	1	-1	1	1	0	0	1	1	1	-1	1	1	1	-1	1	1	0	1	1	0]';
[FB_8maze.M4D4D] = Analyze_8mazedata(FB_8maze.M4D4D);
FB_8maze.M4D5D.score = [0	0	1	1	1	1	1	1	1	1	1	1	1	1	1	-1	1	1	0	1	1	1	1	1	1	-1	1	0	-1	1	0	1	1	1	1	1	0	1	1	1	1	1	1	-1	1]';
[FB_8maze.M4D5D] = Analyze_8mazedata(FB_8maze.M4D5D);
FB_8maze.M4D6D.score = [0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M4D6D] = Analyze_8mazedata(FB_8maze.M4D6D);
FB_8maze.M4D7D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	-1	1	1	1	1	1	-1	1	0	-1	1	-1	1	0	-1	1	1	1	1	1	1	1	1	1	-1	1]';
[FB_8maze.M4D7D] = Analyze_8mazedata(FB_8maze.M4D7D);
FB_8maze.M4D8D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	-1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M4D8D] = Analyze_8mazedata(FB_8maze.M4D8D);


% Mouse 5 (1002)
FB_8maze.M5D1T.score = [1	0	1	1	0	1	0	0	0	1	1	0	1	1	0	0	1	0	1	1	1	1	0	0	0	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	0	0	0	1	1]';
[FB_8maze.M5D1T] = Analyze_8mazedata(FB_8maze.M5D1T);
FB_8maze.M5D2T.score = [1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M5D2T] = Analyze_8mazedata(FB_8maze.M5D2T);
FB_8maze.M5D3T.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1]';
[FB_8maze.M5D3T] = Analyze_8mazedata(FB_8maze.M5D3T);

FB_8maze.M5D1D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M5D1D] = Analyze_8mazedata(FB_8maze.M5D1D);
FB_8maze.M5D2D.score = [1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1]';
[FB_8maze.M5D2D] = Analyze_8mazedata(FB_8maze.M5D2D);
FB_8maze.M5D3D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M5D3D] = Analyze_8mazedata(FB_8maze.M5D3D);
FB_8maze.M5D4D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M5D4D] = Analyze_8mazedata(FB_8maze.M5D4D);
FB_8maze.M5D5D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M5D5D] = Analyze_8mazedata(FB_8maze.M5D5D);


% Mouse 6 (1003)
FB_8maze.M6D1T.score = [1	1	1	1	0	0	1	1	1	0	1	1	0	1	1	0	0	0	1	0	1	1	1	1	0	1	1	1	1	0	0	1	0	0	0	1	1	1	1]';
[FB_8maze.M6D1T] = Analyze_8mazedata(FB_8maze.M6D1T);
FB_8maze.M6D2T.score = [1	1	1	1	1	0	1	1	1	0	1	1	1	1	1	1	0	0	1	1	1	0	0	0	0	1	0	1	1	1	1	1	1	1	1	0	1	1	1	1	1	0	1	1	0	1	0	0	0]';
[FB_8maze.M6D2T] = Analyze_8mazedata(FB_8maze.M6D2T);
FB_8maze.M6D3T.score = [1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	0	0	1	1	1]';
[FB_8maze.M6D3T] = Analyze_8mazedata(FB_8maze.M6D3T);
FB_8maze.M6D4T.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M6D4T] = Analyze_8mazedata(FB_8maze.M6D4T);

FB_8maze.M6D1D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M6D1D] = Analyze_8mazedata(FB_8maze.M6D1D);
FB_8maze.M6D2D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M6D2D] = Analyze_8mazedata(FB_8maze.M6D2D);
FB_8maze.M6D3D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M6D3D] = Analyze_8mazedata(FB_8maze.M6D3D);
FB_8maze.M6D4D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0   1   1]';
[FB_8maze.M6D4D] = Analyze_8mazedata(FB_8maze.M6D4D);


% Mouse 7 (1004)
FB_8maze.M7D1T.score = [1	0	1	1	1	0	1	1	1	1	1	1	0	1	1	0	1	1	1	1	0	1	0	1	1	0	1	1	0	0	1	1	0	1	1	0	1	0	1	0	0	0	0	1	1	1	1	1	1	0	1	1]';
[FB_8maze.M7D1T] = Analyze_8mazedata(FB_8maze.M7D1T);
FB_8maze.M7D2T.score = [1	1	1	1	1	0	1	1	0	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1]';
[FB_8maze.M7D2T] = Analyze_8mazedata(FB_8maze.M7D2T);
FB_8maze.M7D3T.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M7D3T] = Analyze_8mazedata(FB_8maze.M7D3T);

FB_8maze.M7D1D.score = [1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1]';
[FB_8maze.M7D1D] = Analyze_8mazedata(FB_8maze.M7D1D);
FB_8maze.M7D2D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	-1	0]';
[FB_8maze.M7D2D] = Analyze_8mazedata(FB_8maze.M7D2D);
FB_8maze.M7D3D.score = [1	1	1	1	1	1	1	1	-1	1	1	1	1	1	0	0	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	-1	0	1	1	1	1	1]';
[FB_8maze.M7D3D] = Analyze_8mazedata(FB_8maze.M7D3D);
FB_8maze.M7D4D.score = [1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M7D4D] = Analyze_8mazedata(FB_8maze.M7D4D);
FB_8maze.M7D5D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M7D5D] = Analyze_8mazedata(FB_8maze.M7D5D);


% Mouse 8 (1006)
FB_8maze.M8D1T.score = [1	1	1	1	1	0	0	1	1	0	1	0	1	0	1	0	1	1	0	1	0	1	1	0	1	1	1	0	1	0	1	1	1	0	1	1	1	1	0	1	1	0	1]';
[FB_8maze.M8D1T] = Analyze_8mazedata(FB_8maze.M8D1T);
FB_8maze.M8D2T.score = [1	1	1	1	1	1	1	1	1	0	0	1	1	0	1	1	1	0	1	0	1	0	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M8D2T] = Analyze_8mazedata(FB_8maze.M8D2T);
FB_8maze.M8D3T.score = [1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M8D3T] = Analyze_8mazedata(FB_8maze.M8D3T);

FB_8maze.M8D1D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	-1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M8D1D] = Analyze_8mazedata(FB_8maze.M8D1D);
FB_8maze.M8D2D.score = [-1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M8D2D] = Analyze_8mazedata(FB_8maze.M8D2D);
FB_8maze.M8D3D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M8D3D] = Analyze_8mazedata(FB_8maze.M8D3D);
FB_8maze.M8D4D.score = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[FB_8maze.M8D4D] = Analyze_8mazedata(FB_8maze.M8D4D);







































