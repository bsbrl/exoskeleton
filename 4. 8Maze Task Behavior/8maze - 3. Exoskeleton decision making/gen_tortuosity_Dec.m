function [d1tort] = gen_tortuosity_Dec(MxDx,id,d1tort)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu
dist = 0.125; % shortest possible yx path through turning zone

d = MxDx.d;
x = MxDx.x;
y = MxDx.y;
turnseq = MxDx.turnseq;

for n = length(d):-1:1
    if turnseq(n) == id
        d(n,:) = [];
    elseif turnseq(n) == 0
        d(n,:) = [];
    end
end       

if size(d,1) > 0
    for n = 1:size(d,1) 
        vecs{n,1}(:,1) = x(d(n,1):d(n,2));
        vecs{n,1}(:,2) = y(d(n,1):d(n,2));
        vecs{n,2} =  vecs{n,1}(2:end,:) - vecs{n,1}(1:end-1,:);
        for m = 1:size(vecs{n,2},1)
            vecs{n,3}(m,1) = norm(vecs{n,2}(m,:));
        end
        tort(n,1) = sum(vecs{n,3})./dist;    
    end
    d1tort = [d1tort;tort];
else
    d1tort = d1tort;
end


end

