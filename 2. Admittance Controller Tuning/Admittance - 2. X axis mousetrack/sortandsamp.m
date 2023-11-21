function [y1] = sortandsamp(y1,perc,P)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

y1 = sort(y1,'descend');    % sort from highest to lowest
    
% TOP percentage 
perc = ceil(length(y1)*perc/100);  % top data to subsample
y1 = y1(1:perc,:);             % take top P samples

if length(y1) > P
    y1 = imresize(y1,[P,1]);
end


end

