function [x,y] = histoplot(h,plotinfun)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu
x = [h.BinEdges(1:end-1);h.BinEdges(2:end)];
x = reshape(x,[],1);
y = [h.BinCounts;h.BinCounts];
y = reshape(y,[],1);

if plotinfun == 1
    plot(x,y)

end

