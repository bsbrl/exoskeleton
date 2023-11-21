function [] = plot_Fpeaks_box(AV_data,vel_cutoff)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

[~,f11,~] = clipandformat(AV_data.tunedz1.vx,AV_data.tunedz1.fx,{'TuneZ'},vel_cutoff);
[~,f12,~] = clipandformat(AV_data.tunedz2.vx,AV_data.tunedz2.fx,{'TuneZ'},vel_cutoff);
[~,f13,~] = clipandformat(AV_data.tunedz3.vx,AV_data.tunedz3.fx,{'TuneZ'},vel_cutoff);
[~,f14,~] = clipandformat(AV_data.tunedz4.vx,AV_data.tunedz4.fx,{'TuneZ'},vel_cutoff);

[~,f23,~] = clipandformat(AV_data.trained1.vx,AV_data.trained1.fx,{'Trained'},vel_cutoff);
[~,f24,~] = clipandformat(AV_data.trained2.vx,AV_data.trained2.fx,{'Trained'},vel_cutoff);
[~,f25,~] = clipandformat(AV_data.trained3.vx,AV_data.trained3.fx,{'Trained'},vel_cutoff);
[~,f26,~] = clipandformat(AV_data.trained4.vx,AV_data.trained4.fx,{'Trained'},vel_cutoff);

f1 = findpeaks(f11); g1 = repmat({'TuneZ'},size(f1));
f2 = findpeaks(f12); g2 = repmat({'TuneZ'},size(f2));
f3 = findpeaks(f13); g3 = repmat({'TuneZ'},size(f3));
f4 = findpeaks(f14); g4 = repmat({'TuneZ'},size(f4));

f5 = findpeaks(f23); g5 = repmat({'Trained'},size(f5));
f6 = findpeaks(f24); g6 = repmat({'Trained'},size(f6));
f7 = findpeaks(f25); g7 = repmat({'Trained'},size(f7));
f8 = findpeaks(f26); g8 = repmat({'Trained'},size(f8));


figure
boxplot(abs([f1;f2;f3;f4;f5;f6;f7;f8]),[g1;g2;g3;g4;g5;g6;g7;g8],'PlotStyle','compact','symbol','','Colors',[0 0.4470 0.7410])
title('X Force peaks')
ylabel('abs(Force) (N)')
ylim([0 0.6])


end

