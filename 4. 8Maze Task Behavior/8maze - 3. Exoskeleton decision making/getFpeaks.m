function [x1] = getFpeaks(x1)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

x1 = medmovmeanfilt(x1,15,8); x1 = medmovmeanfilt(x1,15,8);
temp = x1; temp(temp<0) = 0; pk_pos = findpeaks(temp);
temp = x1; temp(temp>0) = 0; pk_neg = -(findpeaks(-temp));
x1 = [pk_pos;pk_neg];

end

