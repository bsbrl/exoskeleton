function [vout,aout] = plot_VApeaks_box_pops(AV_data,vel_cutoff)
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


vcombfb = [v1;v2;v3;v4;v5;v6];
gcombfb = repmat({'Free'},size(vcombfb));

vcombt = [v11;v1;v13;v14];
gcombt = repmat({'Tuned'},size(vcombt));

vcombr = [v23;v24;v25;v26];
gcombr = repmat({'Trained'},size(vcombr));

figure
boxplot([vcombfb;vcombt;vcombr],[gcombfb;gcombt;gcombr],'PlotStyle','compact','whisker', inf,'Colors',[0 0.4470 0.7410])
title('X Velocity Peaks')
ylabel('Vel (m/s)')

vout{1,1} = vcombfb; 
vout{2,1} = vcombt;
vout{3,1} = vcombr;
vout{1,2} = gcombfb; 
vout{2,2} = gcombt;
vout{3,2} = gcombr;

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

acombfb = [a1;a2;a3;a4;a5;a6];
gcombfb = repmat({'Free'},size(acombfb));

acombt = [a11;a1;a13;a14];
gcombt = repmat({'Tuned'},size(acombt));

acombr = [a23;a24;a25;a26];
gcombr = repmat({'Trained'},size(acombr));

figure
boxplot([acombfb;acombt;acombr],[gcombfb;gcombt;gcombr],'PlotStyle','compact','whisker', inf,'Colors',[0 0.4470 0.7410])
title('X Acceleration Peaks')
ylabel('Accel (m/s^2)')

aout{1,1} = acombfb; 
aout{2,1} = acombt;
aout{3,1} = acombr;
aout{1,2} = gcombfb; 
aout{2,2} = gcombt;
aout{3,2} = gcombr;

end
