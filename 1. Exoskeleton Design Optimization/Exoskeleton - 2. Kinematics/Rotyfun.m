function [Roty] = Rotyfun(theta)

%Rotation matrix around y axis

Roty = [cos(theta),0,sin(theta);...
    0,1,0;...
    -sin(theta),0,cos(theta)];

end

