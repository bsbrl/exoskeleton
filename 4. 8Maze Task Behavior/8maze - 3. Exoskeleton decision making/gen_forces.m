function [MxDx] = gen_forces(MxDx)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

d = MxDx.d;
% fx = MxDx.fx;
fy = MxDx.fy;
fyaw = MxDx.fyaw;

% left turns
for n = 1:2:length(d) 
    if n == 1
        fL = fy(d(n,1):d(n,2));
        tL = fyaw(d(n,1):d(n,2));
    else
        fL = [fL; fy(d(n,1):d(n,2))];
        tL = [tL; fyaw(d(n,1):d(n,2))];
    end
end

% right turns
for n = 2:2:length(d) 
    if n == 2
        fR = fy(d(n,1):d(n,2));
        tR = fyaw(d(n,1):d(n,2));
    else
        fR = [fR; fy(d(n,1):d(n,2))];
        tR = [tR; fyaw(d(n,1):d(n,2))];
    end
end

MxDx.fR = fR;
MxDx.fL = fL;
MxDx.tR = tR;
MxDx.tL = tL;

end

