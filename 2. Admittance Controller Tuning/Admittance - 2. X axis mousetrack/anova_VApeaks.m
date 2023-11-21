function [vstats,astats] = anova_VApeaks(AV_data,vel_cutoff,P,D,All,perc)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


% freely behaving
[fb1v,fb1a,~] = clipandformat(AV_data.fb1.vx,AV_data.fb1.ax,{'Free1'},vel_cutoff);
[fb2v,fb2a,~] = clipandformat(AV_data.fb2.vx,AV_data.fb2.ax,{'Free1'},vel_cutoff);
[fb3v,fb3a,~] = clipandformat(AV_data.fb3.vx,AV_data.fb3.ax,{'Free1'},vel_cutoff);
[fb4v,fb4a,~] = clipandformat(AV_data.fb4.vx,AV_data.fb4.ax,{'Free2'},vel_cutoff);
[fb5v,fb5a,~] = clipandformat(AV_data.fb5.vx,AV_data.fb5.ax,{'Free2'},vel_cutoff);
[fb6v,fb6a,~] = clipandformat(AV_data.fb6.vx,AV_data.fb6.ax,{'Free3'},vel_cutoff);

% mousetrack lowz
[lz1v,lz1a,~] = clipandformat(AV_data.lowz1.vx,AV_data.lowz1.ax,{'LowZ1'},vel_cutoff);
[lz2v,lz2a,~] = clipandformat(AV_data.lowz2.vx,AV_data.lowz2.ax,{'LowZ2'},vel_cutoff);
[lz3v,lz3a,~] = clipandformat(AV_data.lowz3.vx,AV_data.lowz3.ax,{'LowZ3'},vel_cutoff);
[lz4v,lz4a,~] = clipandformat(AV_data.lowz4.vx,AV_data.lowz4.ax,{'Lowz4'},vel_cutoff);

% mousetrack tunedz
[tz1v,tz1a,~] = clipandformat(AV_data.tunedz1.vx,AV_data.tunedz1.ax,{'TuneZ1'},vel_cutoff);
[tz2v,tz2a,~] = clipandformat(AV_data.tunedz2.vx,AV_data.tunedz2.ax,{'TuneZ2'},vel_cutoff);
[tz3v,tz3a,~] = clipandformat(AV_data.tunedz3.vx,AV_data.tunedz3.ax,{'TuneZ3'},vel_cutoff);
[tz4v,tz4a,~] = clipandformat(AV_data.tunedz4.vx,AV_data.tunedz4.ax,{'Tunez4'},vel_cutoff);

% mousetrack highz
[hz1v,hz1a,~] = clipandformat(AV_data.highz1.vx,AV_data.highz1.ax,{'HighZ1'},vel_cutoff);
[hz2v,hz2a,~] = clipandformat(AV_data.highz2.vx,AV_data.highz2.ax,{'HighZ2'},vel_cutoff);
[hz3v,hz3a,~] = clipandformat(AV_data.highz3.vx,AV_data.highz3.ax,{'HighZ3'},vel_cutoff);
[hz4v,hz4a,~] = clipandformat(AV_data.highz4.vx,AV_data.highz4.ax,{'HighZ4'},vel_cutoff);

% mousetrack trained - tunedZ
[rz1v,rz1a,~] = clipandformat(AV_data.trained1.vx,AV_data.trained1.ax,{'Trained1'},vel_cutoff);
[rz2v,rz2a,~] = clipandformat(AV_data.trained2.vx,AV_data.trained2.ax,{'Trained2'},vel_cutoff);
[rz3v,rz3a,~] = clipandformat(AV_data.trained3.vx,AV_data.trained3.ax,{'Trained3'},vel_cutoff);
[rz4v,rz4a,~] = clipandformat(AV_data.trained4.vx,AV_data.trained4.ax,{'Trained4'},vel_cutoff);


v1 = findpeaks(fb1v);
v2 = findpeaks(fb2v);
v3 = findpeaks(fb3v);
v4 = findpeaks(fb4v);
v5 = findpeaks(fb5v);
v6 = findpeaks(fb6v); 
v7 = findpeaks(lz1v);
v8 = findpeaks(lz2v);
v9 = findpeaks(lz3v);
v10 = findpeaks(lz4v);
v11 = findpeaks(tz1v); 
v12 = findpeaks(tz2v);
v13 = findpeaks(tz3v); 
v14 = findpeaks(tz4v); 
v19 = findpeaks(hz1v); 
v20 = findpeaks(hz2v); 
v21 = findpeaks(hz3v); 
v22 = findpeaks(hz4v); 
v23 = findpeaks(rz1v); 
v24 = findpeaks(rz2v); 
v25 = findpeaks(rz3v);
v26 = findpeaks(rz4v);


% Positive acceleration only 
a1 = findpeaks(fb1a); a1 = a1(a1>0); 
a2 = findpeaks(fb2a); a2 = a2(a2>0);
a3 = findpeaks(fb3a); a3 = a3(a3>0);
a4 = findpeaks(fb4a); a4 = a4(a4>0);
a5 = findpeaks(fb5a); a5 = a5(a5>0);
a6 = findpeaks(fb6a); a6 = a6(a6>0);
a7 = findpeaks(lz1a); a7 = a7(a7>0);
a8 = findpeaks(lz2a); a8 = a8(a8>0);
a9 = findpeaks(lz3a); a9 = a9(a9>0);
a10 = findpeaks(lz4a); a10 = a10(a10>0);
a11 = findpeaks(tz1a); a11 = a11(a11>0);
a12 = findpeaks(tz2a); a12 = a12(a12>0);
a13 = findpeaks(tz3a); a13 = a13(a13>0);
a14 = findpeaks(tz4a); a14 = a14(a14>0);
a19 = findpeaks(hz1a); a19 = a19(a19>0);
a20 = findpeaks(hz2a); a20 = a20(a20>0);
a21 = findpeaks(hz3a); a21 = a21(a21>0);
a22 = findpeaks(hz4a); a22 = a22(a22>0);
a23 = findpeaks(rz1a); a23 = a23(a23>0);
a24 = findpeaks(rz2a); a24 = a24(a24>0);
a25 = findpeaks(rz3a); a25 = a25(a25>0);
a26 = findpeaks(rz4a); a26 = a26(a26>0);


% combine velocity data into populations and anova test
% perc = 30;   %  % to subsample

cutoff = 0.005; % m/s, not interested in very slow data
% freely behaving
y1 = [v1;v2;v3;v4;v5;v6];y1 = y1(y1>cutoff);
if D == 1
    [y1] = sortandsubsamp(y1,P,perc);
else
    [y1] = sortandsamp(y1,perc,P);
end
g1 = repmat({'FB'},size(y1));

% low impedance
y2 = [v7;v8;v9;v10];y2 = y2(y2>cutoff);
if D == 1
    [y2] = sortandsubsamp(y2,P,perc);
else
    [y2] = sortandsamp(y2,perc,P);
end
g2 = repmat({'lowZ'},size(y2));

% tuned impedance
y3 = [v11;v12;v13;v14];y3 = y3(y3>cutoff);
if D == 1
    [y3] = sortandsubsamp(y3,P,perc);
else
    [y3] = sortandsamp(y3,perc,P);
end
g3 = repmat({'tunedZ'},size(y3));

% high impedance
y5 = [v19;v20;v21;v22];y5 = y5(y5>cutoff);
if D == 1
    [y5] = sortandsubsamp(y5,P,perc);
else
    [y5] = sortandsamp(y5,perc,P);
end
g5 = repmat({'HighZ'},size(y5));

% tuned and trained
y6 = [v23;v24;v25;v26];y6 = y6(y6>cutoff);
if D == 1
    [y6] = sortandsubsamp(y6,P,perc);
else
    [y6] = sortandsamp(y6,perc,P);
end
g6 = repmat({'Trained'},size(y6));

if All == 1
    [p,tbl,stats] = anova1([y1;y2;y3;y5;y6],[g1;g2;g3;g5;g6],'off');
    F = range(stats.means)/range([y1;y2;y3;y5;y6]);
elseif All == 0
% subset of populations
    [p,tbl,stats] = anova1([y1;y3;y6],[g1;g3;g6],'off');
    F = range(stats.means)/range([y1;y3;y6]);
end

% figure
c = multcompare(stats,'Display','off');
% title('X Velocity Peaks')
vstats.p = p;
vstats.tbl = tbl;
vstats.stats = stats;
vstats.c = c;
vstats.F = F;

[vstats.xds] = datastats(y1);   % freely behaving
[vstats.yds] = datastats(y6);   % tuned and trained
[vstats.zds] = datastats(y3);   % tuned

% combine acceleration data into populations and anova test

cutoff = 0.01; % m/s, not interested in very slow data

y1 = [a1;a2;a3;a4;a5;a6];y1 = y1(y1>cutoff);
if D == 1
    [y1] = sortandsubsamp(y1,P,perc);
else
    [y1] = sortandsamp(y1,perc,P);
end
g1 = repmat({'FB'},size(y1));

y2 = [a7;a8;a9;a10];y2 = y2(y2>cutoff);
if D == 1
    [y2] = sortandsubsamp(y2,P,perc);
else
    [y2] = sortandsamp(y2,perc,P);
end
g2 = repmat({'lowZ'},size(y2));

y3 = [a11;a12;a13;a14];y3 = y3(y3>cutoff);
if D == 1
    [y3] = sortandsubsamp(y3,P,perc);
else
    [y3] = sortandsamp(y3,perc,P);
end
g3 = repmat({'tunedZ'},size(y3));

y5 = [a19;a20;a21;a22];y5 = y5(y5>cutoff);
if D == 1
    [y5] = sortandsubsamp(y5,P,perc);
else
    [y5] = sortandsamp(y5,perc,P);
end
g5 = repmat({'HighZ'},size(y5));

y6 = [a23;a24;a25;a26];y6 = y6(y6>cutoff);
if D == 1
    [y6] = sortandsubsamp(y6,P,perc);
else
    [y6] = sortandsamp(y6,perc,P);
end
g6 = repmat({'Trained'},size(y6));

if All == 1
    [p,tbl,stats] = anova1([y1;y2;y3;y5;y6],[g1;g2;g3;g5;g6],'off');
    F = range(stats.means)/range([y1;y2;y3;y5;y6]);
elseif All == 0
% subset of populations
    [p,tbl,stats] = anova1([y1;y3;y6],[g1;g3;g6],'off');
    F = range(stats.means)/range([y1;y3;y6]);
end

% figure
c = multcompare(stats,'Display','off');
% title('X Acceleration Peaks')
astats.p = p;
astats.tbl = tbl;
astats.stats = stats;
astats.c = c;
astats.F = F;

[astats.xds] = datastats(y1);
[astats.yds] = datastats(y6);
[astats.zds] = datastats(y3);

end

