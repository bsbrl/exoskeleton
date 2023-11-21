function [datout] = medmovmeanfilt(datin,fil_1,fil_2)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% filter data to get rid of jitter

datout = medfilt1(datin,fil_1);
datout = movmean(datout,fil_2);
datout = medfilt1(datout,fil_1);
datout = movmean(datout,fil_2);


end

