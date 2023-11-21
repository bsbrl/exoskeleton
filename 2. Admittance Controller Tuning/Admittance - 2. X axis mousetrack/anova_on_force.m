function [fstats] = anova_on_force(AV_data,vel_cutoff,P,D)
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

fcat1 = abs([f1;f2;f3;f4]);
if D == 1
    fcat1 = imresize(fcat1,[P,1]);
end
gcat1 = repmat({'TuneZ'},size(fcat1));

fcat2 = abs([f5;f6;f7;f8]);
if D == 1
    fcat2 = imresize(fcat2,[P,1]);
end
gcat2 = repmat({'Trained'},size(fcat2));


[p,tbl,stats] = anova1(abs([fcat1;fcat2]),[gcat1;gcat2],'off');
F = range(stats.means)/range([fcat1;fcat2]);

figure
c = multcompare(stats);
[xds,yds] = datastats(abs(fcat1),abs(fcat2));

title('abs(F Peaks)')
fstats.p = p;
fstats.tbl = tbl;
fstats.stats = stats;
fstats.c = c;
fstats.F = F;
fstats.xds = xds;
fstats.yds = yds;

end

