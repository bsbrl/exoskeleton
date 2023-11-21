function [cv,statsv] = anova_tort_Dec(data)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

t1 = data.d1tort;
g1 = data.g1;
t2 = data.d2tort;
g2 = data.g2;
t3 = data.d3tort;
g3 = data.g3;
t4 = data.d4tort;
g4 = data.g4;
t5 = data.d5tort;
g5 = data.g5;
t6 = data.d6tort;
g6 = data.g6;
t7 = data.d7tort;
g7 = data.g7;
t8 = data.d8tort;
g8 = data.g8;
t9 = data.d9tort;
g9 = data.g9;
t10 = data.d10tort;
g10 = data.g10;
t11 = data.d11tort;
g11 = data.g11;
t12 = data.d12tort;
g12 = data.g12;

[~,~,statsv] = anova1([t1;t2;t3;t4;t5;t6;t7;t8;t9;t10;t11;t12],...
    [g1;g2;g3;g4;g5;g6;g7;g8;g9;g10;g11;g12],'off');

figure
cv = multcompare(statsv);

end

