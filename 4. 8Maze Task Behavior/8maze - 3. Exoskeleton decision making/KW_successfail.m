function [statssf,csf,p,tbl] = KW_successfail(datas_,dataf_)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


for n = 1:size(datas_,1)
    ts = ones(datas_(n,5),1);    % success
    tf = zeros(dataf_(n,5),1);   % fail
    tc = [ts;tf];
    gc = n.*ones(size(tc));     % gc is labelled with n to separate FB and Exo
    if n == 1
        y = tc;
        g = gc;
    else
        y = [y;tc];
        g = [g;gc];
    end
    clear tc gc
end

[p,tbl,statssf] = kruskalwallis(y,g,'off');

figure
csf = multcompare(statssf);

end

