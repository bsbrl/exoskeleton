function [fbv,fba,g] = clipandformat(fbv,fba,label,cutoff)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% remove velocity points where the mouse is not moving (i.e. less than
% cutoff velocity) 
[M,~] = find(fbv<cutoff); 
fbv(M,:) = [];
fba(M,:) = [];
g = repmat(label,length(fbv),1);

end

