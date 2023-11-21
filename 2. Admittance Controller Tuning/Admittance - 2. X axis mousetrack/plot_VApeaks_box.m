function [] = plot_VApeaks_box(AV_data,vel_cutoff)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% freely behaving
[fb1v,fb1a,g1] = clipandformat(AV_data.fb1.vx,AV_data.fb1.ax,{'Free1'},vel_cutoff);
[fb2v,fb2a,g2] = clipandformat(AV_data.fb2.vx,AV_data.fb2.ax,{'Free1'},vel_cutoff);
[fb3v,fb3a,g3] = clipandformat(AV_data.fb3.vx,AV_data.fb3.ax,{'Free1'},vel_cutoff);
[fb4v,fb4a,g4] = clipandformat(AV_data.fb4.vx,AV_data.fb4.ax,{'Free2'},vel_cutoff);
[fb5v,fb5a,g5] = clipandformat(AV_data.fb5.vx,AV_data.fb5.ax,{'Free2'},vel_cutoff);
[fb6v,fb6a,g6] = clipandformat(AV_data.fb6.vx,AV_data.fb6.ax,{'Free3'},vel_cutoff);

% mousetrack lowz
[lz1v,lz1a,g7] = clipandformat(AV_data.lowz1.vx,AV_data.lowz1.ax,{'LowZ1'},vel_cutoff);
[lz2v,lz2a,g8] = clipandformat(AV_data.lowz2.vx,AV_data.lowz2.ax,{'LowZ2'},vel_cutoff);
[lz3v,lz3a,g9] = clipandformat(AV_data.lowz3.vx,AV_data.lowz3.ax,{'LowZ3'},vel_cutoff);
[lz4v,lz4a,g10] = clipandformat(AV_data.lowz4.vx,AV_data.lowz4.ax,{'Lowz4'},vel_cutoff);

% mousetrack tunedz
[tz1v,tz1a,g11] = clipandformat(AV_data.tunedz1.vx,AV_data.tunedz1.ax,{'TuneZ1'},vel_cutoff);
[tz2v,tz2a,g12] = clipandformat(AV_data.tunedz2.vx,AV_data.tunedz2.ax,{'TuneZ2'},vel_cutoff);
[tz3v,tz3a,g13] = clipandformat(AV_data.tunedz3.vx,AV_data.tunedz3.ax,{'TuneZ3'},vel_cutoff);
[tz4v,tz4a,g14] = clipandformat(AV_data.tunedz4.vx,AV_data.tunedz4.ax,{'Tunez4'},vel_cutoff);

% mousetrack highz
[hz1v,hz1a,g19] = clipandformat(AV_data.highz1.vx,AV_data.highz1.ax,{'HighZ1'},vel_cutoff);
[hz2v,hz2a,g20] = clipandformat(AV_data.highz2.vx,AV_data.highz2.ax,{'HighZ2'},vel_cutoff);
[hz3v,hz3a,g21] = clipandformat(AV_data.highz3.vx,AV_data.highz3.ax,{'HighZ3'},vel_cutoff);
[hz4v,hz4a,g22] = clipandformat(AV_data.highz4.vx,AV_data.highz4.ax,{'HighZ4'},vel_cutoff);

% mousetrack trained - tunedZ
[rz1v,rz1a,g23] = clipandformat(AV_data.trained1.vx,AV_data.trained1.ax,{'Trained1'},vel_cutoff);
[rz2v,rz2a,g24] = clipandformat(AV_data.trained2.vx,AV_data.trained2.ax,{'Trained2'},vel_cutoff);
[rz3v,rz3a,g25] = clipandformat(AV_data.trained3.vx,AV_data.trained3.ax,{'Trained3'},vel_cutoff);
[rz4v,rz4a,g26] = clipandformat(AV_data.trained4.vx,AV_data.trained4.ax,{'Trained4'},vel_cutoff);


v1 = findpeaks(fb1v); g1 = repmat({'Free1'},size(v1));
v2 = findpeaks(fb2v); g2 = repmat({'Free1'},size(v2));
v3 = findpeaks(fb3v); g3 = repmat({'Free1'},size(v3));
v4 = findpeaks(fb4v); g4 = repmat({'Free2'},size(v4));
v5 = findpeaks(fb5v); g5 = repmat({'Free2'},size(v5));
v6 = findpeaks(fb6v); g6 = repmat({'Free3'},size(v6));
v7 = findpeaks(lz1v); g7 = repmat({'LowZ1'},size(v7));
v8 = findpeaks(lz2v); g8 = repmat({'LowZ2'},size(v8));
v9 = findpeaks(lz3v); g9 = repmat({'LowZ3'},size(v9));
v10 = findpeaks(lz4v); g10 = repmat({'LowZ4'},size(v10));
v11 = findpeaks(tz1v); g11 = repmat({'TuneZ1'},size(v11));
v12 = findpeaks(tz2v); g12 = repmat({'TuneZ2'},size(v12));
v13 = findpeaks(tz3v); g13 = repmat({'TuneZ3'},size(v13));
v14 = findpeaks(tz4v); g14 = repmat({'TuneZ4'},size(v14));
v19 = findpeaks(hz1v); g19 = repmat({'HighZ1'},size(v19));
v20 = findpeaks(hz2v); g20 = repmat({'HighZ2'},size(v20));
v21 = findpeaks(hz3v); g21 = repmat({'HighZ3'},size(v21));
v22 = findpeaks(hz4v); g22 = repmat({'HighZ4'},size(v22));
v23 = findpeaks(rz1v); g23 = repmat({'Trained1'},size(v23));
v24 = findpeaks(rz2v); g24 = repmat({'Trained2'},size(v24));
v25 = findpeaks(rz3v); g25 = repmat({'Trained3'},size(v25));
v26 = findpeaks(rz4v); g26 = repmat({'Trained4'},size(v26));


all_v_dat = [v1;v2;v3;v4;v5;v6;v7;v8;v9;v10;v11;v12;v13;v14;v19;v20;v21;v22;v23;v24;v25;v26]; 
all_g_dat = [g1;g2;g3;g4;g5;g6;g7;g8;g9;g10;g11;g12;g13;g14;g19;g20;g21;g22;g23;g24;g25;g26];

figure
boxplot(all_v_dat,all_g_dat,'PlotStyle','compact','whisker', inf,'Colors',[0 0.4470 0.7410])
title('X Velocity Peaks')
ylabel('Vel (m/s)')


% Positive acceleration only 
a1 = findpeaks(fb1a); a1 = a1(a1>0); g1 = repmat({'Free1'},size(a1));
a2 = findpeaks(fb2a); a2 = a2(a2>0);g2 = repmat({'Free1'},size(a2));
a3 = findpeaks(fb3a); a3 = a3(a3>0);g3 = repmat({'Free1'},size(a3));
a4 = findpeaks(fb4a); a4 = a4(a4>0);g4 = repmat({'Free2'},size(a4));
a5 = findpeaks(fb5a); a5 = a5(a5>0);g5 = repmat({'Free2'},size(a5));
a6 = findpeaks(fb6a); a6 = a6(a6>0);g6 = repmat({'Free3'},size(a6));
a7 = findpeaks(lz1a); a7 = a7(a7>0);g7 = repmat({'LowZ1'},size(a7));
a8 = findpeaks(lz2a); a8 = a8(a8>0);g8 = repmat({'LowZ2'},size(a8));
a9 = findpeaks(lz3a); a9 = a9(a9>0);g9 = repmat({'LowZ3'},size(a9));
a10 = findpeaks(lz4a); a10 = a10(a10>0);g10 = repmat({'LowZ4'},size(a10));
a11 = findpeaks(tz1a); a11 = a11(a11>0);g11 = repmat({'TuneZ1'},size(a11));
a12 = findpeaks(tz2a); a12 = a12(a12>0);g12 = repmat({'TuneZ2'},size(a12));
a13 = findpeaks(tz3a); a13 = a13(a13>0);g13 = repmat({'TuneZ3'},size(a13));
a14 = findpeaks(tz4a); a14 = a14(a14>0);g14 = repmat({'TuneZ4'},size(a14));
a19 = findpeaks(hz1a); a19 = a19(a19>0);g19 = repmat({'HighZ1'},size(a19));
a20 = findpeaks(hz2a); a20 = a20(a20>0);g20 = repmat({'HighZ2'},size(a20));
a21 = findpeaks(hz3a); a21 = a21(a21>0);g21 = repmat({'HighZ3'},size(a21));
a22 = findpeaks(hz4a); a22 = a22(a22>0);g22 = repmat({'HighZ4'},size(a22));
a23 = findpeaks(rz1a); a23 = a23(a23>0);g23 = repmat({'Trained1'},size(a23));
a24 = findpeaks(rz2a); a24 = a24(a24>0);g24 = repmat({'Trained2'},size(a24));
a25 = findpeaks(rz3a); a25 = a25(a25>0);g25 = repmat({'Trained3'},size(a25));
a26 = findpeaks(rz4a); a26 = a26(a26>0);g26 = repmat({'Trained4'},size(a26));

all_a_dat = [a1;a2;a3;a4;a5;a6;a7;a8;a9;a10;a11;a12;a13;a14;a19;a20;a21;a22;a23;a24;a25;a26];
all_g_dat = [g1;g2;g3;g4;g5;g6;g7;g8;g9;g10;g11;g12;g13;g14;g19;g20;g21;g22;g23;g24;g25;g26];
figure
boxplot(all_a_dat,all_g_dat,'PlotStyle','compact','whisker', inf,'Colors',[0 0.4470 0.7410])
title('X Positive Acceleration Peaks')
ylabel('Accel (m/s^2)')

end

