function [clip,exo_data1] = clip_exo_data(exo_data)

% clip out parts of data where mouse was less than y = -0.25 to remove data
% of mouse being docked and undocked, walking on wheel, etc. 

[I1,~] = find(exo_data(:,6)<-0.25);

step1 = I1(2:end,:) - I1(1:end-1,:); 

[I2,~] = find(step1>1);

clip = [I2(1,1),I1(I2(1,1)+1,1)];


% figure
% plot(exo_data(:,5:6));
% hold on
% plot([clip(1) clip(1)],[-0.4 0.3],'-k')
% hold on
% plot([clip(2) clip(2)],[-0.4 0.3],'-k')
% legend('global x pos','global y pos','clip')

% replace unwanted sections of data with zeros, except for time and sync
% pulse
exo_data1 = exo_data;
exo_data1(1:clip(1),[1:12,14:30]) = 0;
exo_data1(clip(2):end,[1:12,14:30]) = 0;



end

