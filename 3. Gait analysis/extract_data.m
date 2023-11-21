function [Mousedat] = extract_data(filename,framerate)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu
T = readtable(filename);
A = table2array(T);

% format of data in A is:
% column 1:     frame number
% column 2,3:   Nose x,y  
% column 4:     Nose confidence
% column 5,6:   L ear x,y  
% column 7:     L ear confidence
% column 8,9:   Back x,y  
% column 10:    Back confidence 
% column 11,12: Tailbase x,y    
% column 13:    Tailbase confidence
% column 14,15: L hindpaw x,y    
% column 16:    L hindpaw confidence 
% column 17,18: L forepaw x,y    
% column 19:    L forepaw confidence 

Mousedat.time = A(:,1)./framerate;
Mousedat.Nose = A(:,2:4);
Mousedat.Lear = A(:,5:7);
Mousedat.Back = A(:,8:10);
Mousedat.Tail = A(:,11:13);
Mousedat.Lhind = A(:,14:16);
Mousedat.Lfore = A(:,17:19);


end

