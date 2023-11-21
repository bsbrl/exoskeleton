function [Rotx] = Rotxfun(theta)

%Rotation matrix around x axis

Rotx = [1,0,0;...
    0,cos(theta),-sin(theta);...
    0,sin(theta),cos(theta)];

end

