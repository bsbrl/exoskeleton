function [vstats,astats] = anova_on_boot(Boot)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% velocity peaks bootstrapped data
y1 = Boot.stats_fbv(:,1);
g1 = repmat({'FB'},size(y1));

y2 = Boot.stats_lzv(:,1);
g2 = repmat({'lowZ'},size(y2));

y3 = Boot.stats_tzv(:,1);
g3 = repmat({'tunedZ'},size(y3));

y5 = Boot.stats_hzv(:,1);
g5 = repmat({'HighZ'},size(y5));

y6 = Boot.stats_trv(:,1);
g6 = repmat({'Trained'},size(y6));

[p,tbl,stats] = kruskalwallis([y1;y2;y3;y5;y6],[g1;g2;g3;g5;g6],'off');

figure
c = multcompare(stats);

vstats.p = p;
vstats.tbl = tbl;
vstats.stats = stats;
vstats.c = c;

% acceleration peaks bootstrapped data

y1 = Boot.stats_fba(:,1);
g1 = repmat({'FB'},size(y1));

y2 = Boot.stats_lza(:,1);
g2 = repmat({'lowZ'},size(y2));

y3 = Boot.stats_tza(:,1);
g3 = repmat({'tunedZ'},size(y3));

y5 = Boot.stats_hza(:,1);
g5 = repmat({'HighZ'},size(y5));

y6 = Boot.stats_tra(:,1);
g6 = repmat({'Trained'},size(y6));

[p,tbl,stats] = kruskalwallis([y1;y2;y3;y5;y6],[g1;g2;g3;g5;g6],'off');

figure
c = multcompare(stats);

astats.p = p;
astats.tbl = tbl;
astats.stats = stats;
astats.c = c;



end

