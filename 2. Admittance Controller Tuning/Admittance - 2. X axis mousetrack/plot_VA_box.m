function [] = plot_VA_box(AV_data,vel_cutoff)
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


all_v_dat = [fb1v;fb2v;fb3v;fb4v;fb5v;fb6v;lz1v;lz2v;lz3v;lz4v;tz1v;tz2v;tz3v;tz4v;hz1v;hz2v;hz3v;hz4v;rz1v;rz2v;rz3v;rz4v];
all_g_dat = [g1;g2;g3;g4;g5;g6;g7;g8;g9;g10;g11;g12;g13;g14;g19;g20;g21;g22;g23;g24;g25;g26];

figure
boxplot(all_v_dat,all_g_dat,'PlotStyle','compact','whisker', inf,'Colors',[0 0.4470 0.7410])
title('X Velocity')
ylabel('Vel (m/s)')

all_a_dat = [fb1a;fb2a;fb3a;fb4a;fb5a;fb6a;lz1a;lz2a;lz3a;lz4a;tz1a;tz2a;tz3a;tz4a;hz1a;hz2a;hz3a;hz4a;rz1a;rz2a;rz3a;rz4a];

figure
boxplot(all_a_dat,all_g_dat,'PlotStyle','compact','whisker', inf,'Colors',[0 0.4470 0.7410])
title('X Acceleration')
ylabel('Accel (m/s^2)')

end

