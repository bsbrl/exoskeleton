function [m1xm2] = Pluckercrossprod(m1,m2)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

m1rot = m1(1:3,1);
m1lin = m1(4:6,1);
m2rot = m2(1:3,1);
m2lin = m2(4:6,1);

m1xm2 = [cross(m1rot,m2rot);(cross(m1rot,m2lin)+cross(m1lin,m2rot))];




end

