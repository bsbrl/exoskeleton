function [statssf,csf] = anova_successfail(datas,dataf)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


for n = 1:size(datas,1)
    ts = ones(datas(n,5),1);
    tf = zeros(dataf(n,5),1);
    tc = [ts;tf];
    gc = n.*ones(size(tc));
    if n == 1
        y = tc;
        g = gc;
    else
        y = [y;tc];
        g = [g;gc];
    end
    clear tc gc
end

[~,~,statssf] = anova1(y,g,'off');

figure
csf = multcompare(statssf);

end

