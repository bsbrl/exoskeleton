function [Cumscore,Iwrg,Iinc] = trialbytrial(score)


% indices of wrong way and wrong turn errors
[Iwrg,~] = find(score == 0);
[Iinc,~] = find(score == -1);

score(score==0) = -1;
% cumulative score
Cumscore = cumsum(score);



end

