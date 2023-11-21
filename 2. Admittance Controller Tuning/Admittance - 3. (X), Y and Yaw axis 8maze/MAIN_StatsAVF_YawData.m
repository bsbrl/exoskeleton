% GENERATE BOX PLOTS AND COMPARE INFO FOR YAW AXIS
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all

% load AV profile data
load('AV_data.mat')
% Or generate it from scratch using 'MAIN_GenAVprofiles_TuningData.m' 
% in the folder directory: "...\Tuning Data and Figures"

%% box and whisker analysis;

% freely behaving
vel_cutoff = 0.05;

[fb1v,fb1a,g1] = clipandformat(AV_data.fb1.vyaw,AV_data.fb1.ayaw,{'Free1'},vel_cutoff);
[fb2v,fb2a,g2] = clipandformat(AV_data.fb2.vyaw,AV_data.fb2.ayaw,{'Free1'},vel_cutoff);
[fb3v,fb3a,g3] = clipandformat(AV_data.fb3.vyaw,AV_data.fb3.ayaw,{'Free1'},vel_cutoff);
[fb4v,fb4a,g4] = clipandformat(AV_data.fb4.vyaw,AV_data.fb4.ayaw,{'Free2'},vel_cutoff);
[fb5v,fb5a,g5] = clipandformat(AV_data.fb5.vyaw,AV_data.fb5.ayaw,{'Free2'},vel_cutoff);
[fb6v,fb6a,g6] = clipandformat(AV_data.fb6.vyaw,AV_data.fb6.ayaw,{'Free3'},vel_cutoff);

% 8maze lowz
lz1v = AV_data.YYlowz1.vyaw; g7 = repmat({'LowZ1'},size(lz1v));
lz1a = AV_data.YYlowz1.ayaw; 
lz2v = AV_data.YYlowz2.vyaw; g8 = repmat({'LowZ2'},size(lz2v));
lz2a = AV_data.YYlowz2.ayaw; 

% 8maze midz
mz1v = AV_data.YYmidz1.vyaw; g9 = repmat({'MidZ1'},size(mz1v));
mz1a = AV_data.YYmidz1.ayaw;
mz2v = AV_data.YYmidz2.vyaw; g10 = repmat({'MidZ2'},size(mz2v));
mz2a = AV_data.YYmidz2.ayaw;

% 8maze highz
hz1v = AV_data.YYhighz1.vyaw; g11 = repmat({'HighZ1'},size(hz1v));
hz1a = AV_data.YYhighz1.ayaw;
hz2v = AV_data.YYhighz2.vyaw; g12 = repmat({'HighZ2'},size(hz2v));
hz2a = AV_data.YYhighz2.ayaw; 


all_v_dat = abs([fb1v;fb2v;fb3v;fb4v;fb5v;fb6v;lz1v;lz2v;mz1v;mz2v;hz1v;hz2v]);
all_g_dat = [g1;g2;g3;g4;g5;g6;g7;g8;g9;g10;g11;g12];

figure
boxplot(all_v_dat,all_g_dat,'PlotStyle','compact','whisker', inf,'Colors',[0 0.4470 0.7410])
title('Yaw Velocity')
ylabel('Vel (rad/s)')

all_a_dat = abs([fb1a;fb2a;fb3a;fb4a;fb5a;fb6a;lz1a;lz2a;mz1a;mz2a;hz1a;hz2a]);

figure
boxplot(all_a_dat,all_g_dat,'PlotStyle','compact','whisker', inf,'Colors',[0 0.4470 0.7410])
title('Yaw Acceleration')
ylabel('Accel (rad/s^2)')
 
%% Just look at velocity and acceleration peaks 
clear all_a_dat all_v_dat all_g_dat

v1 = findpeaks(fb1v); g1 = repmat({'Free1'},size(v1));
v2 = findpeaks(fb2v); g2 = repmat({'Free1'},size(v2));
v3 = findpeaks(fb3v); g3 = repmat({'Free1'},size(v3));
v4 = findpeaks(fb4v); g4 = repmat({'Free2'},size(v4));
v5 = findpeaks(fb5v); g5 = repmat({'Free2'},size(v5));
v6 = findpeaks(fb6v); g6 = repmat({'Free3'},size(v6));
v7 = findpeaks(lz1v); g7 = repmat({'LowZ1'},size(v7));
v8 = findpeaks(lz2v); g8 = repmat({'LowZ2'},size(v8));
v9 = findpeaks(mz1v); g9 = repmat({'MidZ1'},size(v9));
v10 = findpeaks(mz2v); g10 = repmat({'MidZ2'},size(v10));
v11 = findpeaks(hz1v); g11 = repmat({'HighZ1'},size(v11));
v12 = findpeaks(hz2v); g12 = repmat({'HighZ2'},size(v12));


all_v_dat = abs([v1;v2;v3;v4;v5;v6;v7;v8;v9;v10;v11;v12]); 
all_g_dat = [g1;g2;g3;g4;g5;g6;g7;g8;g9;g10;g11;g12];

figure
boxplot(all_v_dat,all_g_dat,'PlotStyle','compact','whisker', inf,'Colors',[0 0.4470 0.7410])
title('Yaw Velocity Peaks')
ylabel('Vel (rad/s)')


a1 = findpeaks(fb1a); g1 = repmat({'Free1'},size(a1));
a2 = findpeaks(fb2a); g2 = repmat({'Free1'},size(a2));
a3 = findpeaks(fb3a); g3 = repmat({'Free1'},size(a3));
a4 = findpeaks(fb4a); g4 = repmat({'Free2'},size(a4));
a5 = findpeaks(fb5a); g5 = repmat({'Free2'},size(a5));
a6 = findpeaks(fb6a); g6 = repmat({'Free3'},size(a6));
a7 = findpeaks(lz1a); g7 = repmat({'LowZ1'},size(a7));
a8 = findpeaks(lz2a); g8 = repmat({'LowZ2'},size(a8));
a9 = findpeaks(mz1a); g9 = repmat({'MidZ1'},size(a9));
a10 = findpeaks(mz2a); g10 = repmat({'MidZ2'},size(a10));
a11 = findpeaks(hz1a); g11 = repmat({'HighZ1'},size(a11));
a12 = findpeaks(hz2a); g12 = repmat({'HighZ2'},size(a12));

all_a_dat = abs([a1;a2;a3;a4;a5;a6;a7;a8;a9;a10;a11;a12]);
all_g_dat = [g1;g2;g3;g4;g5;g6;g7;g8;g9;g10;g11;g12];
figure
boxplot(all_a_dat,all_g_dat,'PlotStyle','compact','whisker', inf,'Colors',[0 0.4470 0.7410])
title('Yaw Acceleration Peaks')
ylabel('Accel (rad/s^2)')


%% Bootstrap analyais on random sample of 100 points from each peak velocity dataset

y = [v1;v2;v3;v4;v5;v6];
stats_fbv = bootstrp(100,@(x)[mean(x) std(x)],y);

y = [v7;v8];
stats_lzv = bootstrp(100,@(x)[mean(x) std(x)],y);

y = [v9;v10];
stats_mzv = bootstrp(100,@(x)[mean(x) std(x)],y);

y = [v11;v12];
stats_hzv = bootstrp(100,@(x)[mean(x) std(x)],y);


%% Bootstrap analyais on random sample of 100 points from each peak acceleration dataset

y = [a1;a2;a3;a4;a5;a6];y = y(y>0);
stats_fba = bootstrp(100,@(x)[mean(x) std(x)],y);

y = [a7;a8];y = y(y>0);
stats_lza = bootstrp(100,@(x)[mean(x) std(x)],y);

y = [;a9;a10];y = y(y>0);
stats_mza = bootstrp(100,@(x)[mean(x) std(x)],y);

y = [a11;a12];y = y(y>0);
stats_hza = bootstrp(100,@(x)[mean(x) std(x)],y);

%%
figure
hold on
plot(stats_fbv(:,1),stats_fba(:,1),'o')
plot(stats_lzv(:,1),stats_lza(:,1),'o')
plot(stats_mzv(:,1),stats_mza(:,1),'o')
plot(stats_hzv(:,1),stats_hza(:,1),'o')


legend('FB','LowZ','MidZ','HighZ')
title('Bootstrap: vel-accel peaks')
xlabel('Mean vel (rad/s)')
ylabel('Mean accel (rad/s^2)')



%% ANOVA on all vel peaks
numsel = 100;

y1 = [v1;v2;v3;v4;v5;v6];
y1 = imresize(y1,[numsel,1]);
g1 = repmat({'FB'},size(y1));

y2 = [v7;v8];
y2 = imresize(y2,[numsel,1]);
g2 = repmat({'lowZ'},size(y2));

y3 = [v9;v10];
y3 = imresize(y3,[numsel,1]);
g3 = repmat({'midZ'},size(y3));

y4 = [v11;v12];
y4 = imresize(y4,[numsel,1]);
g4 = repmat({'HighZ'},size(y4));

[pv,tblv,statsv] = anova1(abs([y1;y2;y3;y4]),[g1;g2;g3;g4]);

figure
cv = multcompare(statsv);


%% ANOVA on all accel peaks
numsel = 100;

y1 = [a1;a2;a3;a4;a5;a6];y1 = y1(y1>0);
y1 = imresize(y1,[numsel,1]);
g1 = repmat({'FB'},size(y1));

y2 = [a7;a8];y2 = y2(y2>0);
y2 = imresize(y2,[numsel,1]);
g2 = repmat({'lowZ'},size(y2));

y3 = [a9;a10];y3 = y3(y3>0);
y3 = imresize(y3,[numsel,1]);
g3 = repmat({'midZ'},size(y3));

y4 = [a11;a12];y4 = y4(y4>0);
y4 = imresize(y4,[numsel,1]);
g4 = repmat({'HighZ'},size(y4));

figure

[pa,tbla,statsa] = anova1(abs([y1;y2;y3;y4]),[g1;g2;g3;g4]);

figure
ca = multcompare(statsa);

%% PLOT VA PROFILE AREA CURVES
% clear all
% load('AV_data.mat')

figure
x0 = 2400;
y0 = -300;
width = 600;
height = 600;
set(gcf,'position',[x0,y0,width,height])
set(gcf,'color','w');

hold on
v = AV_data.fb1.vyaw;
a = AV_data.fb1.ayaw;
k = AV_data.fb1.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb2.vyaw;
a = AV_data.fb2.ayaw;
k = AV_data.fb2.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb3.vyaw;
a = AV_data.fb3.ayaw;
k = AV_data.fb3.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb4.vyaw;
a = AV_data.fb4.ayaw;
k = AV_data.fb4.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb5.vyaw;
a = AV_data.fb5.ayaw;
k = AV_data.fb5.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb6.vyaw;
a = AV_data.fb6.ayaw;
k = AV_data.fb6.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

hold on
v = AV_data.YYhighz1.vyaw;
a = AV_data.YYhighz1.ayaw;
k = AV_data.YYhighz1.kyaw;
% plot(v,a,'-k')
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);
v = AV_data.YYhighz2.vyaw;
a = AV_data.YYhighz2.ayaw;
k = AV_data.YYhighz2.kyaw;
% plot(v,a,'-k')
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

xlabel('yaw velocity (rad/s)')
ylabel('yaw acceleration (rad/s^2)')
title('Yaw vel-accel, fb vs highz')
xlim([-3.5 3.5])
ylim([-35 35])



figure
x0 = 2400;
y0 = -300;
width = 600;
height = 600;
set(gcf,'position',[x0,y0,width,height])
set(gcf,'color','w');

hold on
v = AV_data.fb1.vyaw;
a = AV_data.fb1.ayaw;
k = AV_data.fb1.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb2.vyaw;
a = AV_data.fb2.ayaw;
k = AV_data.fb2.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb3.vyaw;
a = AV_data.fb3.ayaw;
k = AV_data.fb3.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb4.vyaw;
a = AV_data.fb4.ayaw;
k = AV_data.fb4.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb5.vyaw;
a = AV_data.fb5.ayaw;
k = AV_data.fb5.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb6.vyaw;
a = AV_data.fb6.ayaw;
k = AV_data.fb6.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

hold on
v = AV_data.YYmidz1.vyaw;
a = AV_data.YYmidz1.ayaw;
k = AV_data.YYmidz1.kyaw;
% plot(v,a,'-k')
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);
v = AV_data.YYmidz2.vyaw;
a = AV_data.YYmidz2.ayaw;
k = AV_data.YYmidz2.kyaw;
% plot(v,a,'-k')
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

xlabel('yaw velocity (rad/s)')
ylabel('yaw acceleration (rad/s^2)')
title('Yaw vel-accel, fb vs midz')
xlim([-3.5 3.5])
ylim([-35 35])



figure
x0 = 2400;
y0 = -300;
width = 600;
height = 600;
set(gcf,'position',[x0,y0,width,height])
set(gcf,'color','w');

hold on
v = AV_data.fb1.vyaw;
a = AV_data.fb1.ayaw;
k = AV_data.fb1.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb2.vyaw;
a = AV_data.fb2.ayaw;
k = AV_data.fb2.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb3.vyaw;
a = AV_data.fb3.ayaw;
k = AV_data.fb3.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb4.vyaw;
a = AV_data.fb4.ayaw;
k = AV_data.fb4.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb5.vyaw;
a = AV_data.fb5.ayaw;
k = AV_data.fb5.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);
v = AV_data.fb6.vyaw;
a = AV_data.fb6.ayaw;
k = AV_data.fb6.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

hold on
v = AV_data.YYlowz1.vyaw;
a = AV_data.YYlowz1.ayaw;
k = AV_data.YYlowz1.kyaw;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);
v = AV_data.YYlowz2.vyaw;
a = AV_data.YYlowz2.ayaw;
k = AV_data.YYlowz2.kyaw;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

xlabel('yaw velocity (rad/s)')
ylabel('yaw acceleration (rad/s^2)')
title('Yaw vel-accel, fb vs lowz')
xlim([-3.5 3.5])
ylim([-35 35])







