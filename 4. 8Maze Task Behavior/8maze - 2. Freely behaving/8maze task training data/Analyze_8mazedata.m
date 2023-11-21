function [MxDx] = Analyze_8mazedata(MxDx)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


score = MxDx.score;

% number of correct trials (1)
[M,I] = find(score == 1);
if size(I,1) > 0
    correct = sum(I);
else
    correct = 0;
end

% number of incorrect trials (-1)
[M,I] = find(score == -1);
if size(I,1) > 0
    incorrect = sum(I);
else
    incorrect = 0;
end

% number of wrong way trials (0)
[M,I] = find(score == 0);
if size(I,1) > 0
    wrongway = sum(I);
else
    wrongway = 0;
end

% performance
perf = correct/(correct + incorrect + wrongway);

% number of correct and incorrect L and R turns
Left = repmat([1;0],60,1);
Right = repmat([0;1],60,1);
cor = [0 0];
inc = [0 0];
wrg = [0 0];

for n = 1:size(score,1)
    if score(n,1) == 1
        cor = cor + [Left(n,1), Right(n,1)];
    elseif score(n,1) == 0
        wrg = wrg + [Left(n,1), Right(n,1)];
    elseif score(n,1) == -1
        Left(n,:) = []; 
        Right(n,:) = [];    
        inc = inc + [Left(n,1), Right(n,1)];    
    end
end

% save vars
MxDx.correct = correct;
MxDx.incorrect = incorrect;
MxDx.wrongway = wrongway;
MxDx.perf = perf;
MxDx.cor = cor;
MxDx.inc = inc;
MxDx.wrg = wrg;


end

