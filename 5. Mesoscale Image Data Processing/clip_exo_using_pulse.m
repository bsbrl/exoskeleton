function [data] = clip_exo_using_pulse(data)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% clip out exo data where mesoscope was capturing data to sync the 2
% datasets

figure
plot(data(:,5:6));
hold on

    
pulse = data(:,31);

[M,~] = find(pulse==1);
Mdiff = M(2:end,1) - M(1:end-1,1); 

[B,~] = find(Mdiff > 1);


data(max(M):end,:) = [];
data(1:M(B+1),:) = [];

plot([M(B+1) M(B+1)],[-0.4 0.3],'-k')
hold on
plot([max(M) max(M)],[-0.4 0.3],'-k')


end

