function [y1] = sortandsubsamp(y1,P,perc)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

y1 = sort(y1,'descend');    % sort from highest to lowest
    
% resample data
perc = ceil(100/perc);  % top data to subsample
y1 = imresize(y1,[P.*perc,1]); % downsample data to P points
y1 = y1(1:P,:);             % take top P samples


end

