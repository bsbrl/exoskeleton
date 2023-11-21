function [maxdff] = region_dffmax(k,dff_Data,iscell)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


clear maxdff
m = 1;
for n = 1:size(iscell,1)
    if iscell(n,1) == 1
        if iscell(n,3) == k
            maxdff(m,1) = max(dff_Data(n,:));
            m = m + 1;
        end

    end
end


end

