function [X] = Rd_to_PluckerFrameTransform(R,p)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


% The transformation from Plücker coordinate system i to Plücker coordinate 
% system j for spatial velocities is achieved with the spatial transform
% jXi 
% NB: j and i are superscripts and subscripts respectively. 
% where, jXi = [jRi, 0; S(jpi)jRi, jRi];
% and, jpi and jRi denote the position and orientation of frame i relative to
% frame j, and S() is the skew-symmetrix matrix 

S = [0,-p(3), p(2); ...
    p(3), 0, -p(1); ...
    -p(2), p(1), 0];

X = [R, zeros(3,3);... 
    S*R, R]; 


% NB: inv(jXi) = iXj = [iRj, zeros(3,3); -iRj*S(jpi), iRj]
% NB: kXi = kXj*jXi


end

