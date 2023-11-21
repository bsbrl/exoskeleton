function [tort] = gen_tortuosity2(MxDx)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu
dist = 0.8; % shortest possible yyaw path through turning zone
% note that if the mouse exits the turning zone with its head at an angle
% then tortuosity can be less than 1

d = MxDx.d;
x = MxDx.yaw;
y = MxDx.y;

for k = 2:length(d) % ignore first lap because data start position varies
    n = k - 1;
    vecs{n,1}(:,1) = x(d(k,1):d(k,2));
    vecs{n,1}(:,2) = y(d(k,1):d(k,2));
    vecs{n,2} =  vecs{n,1}(2:end,:) - vecs{n,1}(1:end-1,:);
    for m = 1:size(vecs{n,2},1)
        vecs{n,3}(m,1) = norm(vecs{n,2}(m,:));
    end
    tort(n,1) = sum(vecs{n,3})./dist;    
end



end

