function [Gait] = load_data(framerate)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu
addpath(strcat(pwd,'\Raw data'))

% load exo data
% Mouse 1
filename = 'Mouse1002_230413_Exo_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M1.Exo1] = extract_data(filename,framerate);

filename = 'Mouse1002_230417_Exo_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M1.Exo2] = extract_data(filename,framerate);

filename = 'Mouse1002_230419_Exo_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M1.Exo3] = extract_data(filename,framerate);

% Mouse 2
filename = 'Mouse1132_230413_Exo_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M2.Exo1] = extract_data(filename,framerate);

filename = 'Mouse1132_230419_Exo_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M2.Exo2] = extract_data(filename,framerate);

filename = 'Mouse1132_230427_Exo_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M2.Exo3] = extract_data(filename,framerate);

% Mouse 3
filename = 'Mouse1252_230419_Exo_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M3.Exo1] = extract_data(filename,framerate);



% load freely behaving data
% Mouse 1
filename = 'Mouse1002_230420_FB_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M1.FB1] = extract_data(filename,framerate);

filename = 'Mouse1002_230426_FB_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M1.FB2] = extract_data(filename,framerate);

% Mouse 2
filename = 'Mouse1132_230420_FB_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M2.FB1] = extract_data(filename,framerate);

filename = 'Mouse1132_230426_FB_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M2.FB2] = extract_data(filename,framerate);

% Mouse 3
filename = 'Mouse1252_230420_FB_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M3.FB1] = extract_data(filename,framerate);

filename = 'Mouse1252_230426_FB_clipDLC_resnet50_GaitApr20shuffle1_700000_filtered.csv';
[Gait.M3.FB2] = extract_data(filename,framerate);



end

