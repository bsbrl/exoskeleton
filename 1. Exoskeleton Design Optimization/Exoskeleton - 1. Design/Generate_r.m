function [r] = Generate_r(numz,numa,Bstore,W_D,W_H)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

for dat = 1:size(Bstore,2)
    % generate a coordinate dataset for each viable parameter set
    nn = 1;         
    for Zpt = Bstore(6,dat):-W_H/(numz-1):Bstore(6,dat)-W_H
        zst = (nn-1)*(numa);
        n = 1;
        for pt = 1:numa
            angleeval = (pt-1)*4*pi/numa;
            rad = (pt-1)*0.99*W_D/2/numa;
            r(zst+n,:,dat) = [rad*cos(angleeval), rad*sin(angleeval), Zpt];
            n = n+1;
        end
        nn = nn+1;
    end
end

end

