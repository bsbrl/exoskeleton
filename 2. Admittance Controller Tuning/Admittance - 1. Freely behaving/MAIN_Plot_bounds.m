%% Visualize VA-profile bounds
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

%% Plot bounds of all mice
clear all

% either load AV_data.mat
load('AV_data.mat') 
% or create AV_data.mat using the script: 'MAIN_AV_profiles_fromDLC.m'

figure
x0 = 2400;
y0 = -300;
width = 2200;
height = 400;
set(gcf,'position',[x0,y0,width,height])
set(gcf,'color','w');

subplot(1,3,1)
hold on
v = AV_data.fb1.vx;
a = AV_data.fb1.ax;
k = AV_data.fb1.kx;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);

v = AV_data.fb2.vx;
a = AV_data.fb2.ax;
k = AV_data.fb2.kx;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);

v = AV_data.fb3.vx;
a = AV_data.fb3.ax;
k = AV_data.fb3.kx;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);

v = AV_data.fb4.vx;
a = AV_data.fb4.ax;
k = AV_data.fb4.kx;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);

v = AV_data.fb5.vx;
a = AV_data.fb5.ax;
k = AV_data.fb5.kx;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);

v = AV_data.fb6.vx;
a = AV_data.fb6.ax;
k = AV_data.fb6.kx;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);

xlabel('x velocity (m/s)')
ylabel('x acceleration (m/s^2)')
title('X vel-accel, mouse frame')
ylim([-1 1])
xlim([-0.1 0.2])


subplot(1,3,2)
hold on
v = AV_data.fb1.vy;
a = AV_data.fb1.ay;
k = AV_data.fb1.ky;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);
v = AV_data.fb2.vy;
a = AV_data.fb2.ay;
k = AV_data.fb2.ky;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);
v = AV_data.fb3.vy;
a = AV_data.fb3.ay;
k = AV_data.fb3.ky;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);
v = AV_data.fb4.vy;
a = AV_data.fb4.ay;
k = AV_data.fb4.ky;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);
v = AV_data.fb5.vy;
a = AV_data.fb5.ay;
k = AV_data.fb5.ky;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);
v = AV_data.fb6.vy;
a = AV_data.fb6.ay;
k = AV_data.fb6.ky;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);

xlabel('y velocity (m/s)')
ylabel('y acceleration (m/s^2)')
title('Y vel-accel, mouse frame')
ylim([-0.4 0.4])
xlim([-0.08 0.08])


subplot(1,3,3)
hold on
v = AV_data.fb1.vyaw;
a = AV_data.fb1.ayaw;
k = AV_data.fb1.kyaw;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);
v = AV_data.fb2.vyaw;
a = AV_data.fb2.ayaw;
k = AV_data.fb2.kyaw;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);
v = AV_data.fb3.vyaw;
a = AV_data.fb3.ayaw;
k = AV_data.fb3.kyaw;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);
v = AV_data.fb4.vyaw;
a = AV_data.fb4.ayaw;
k = AV_data.fb4.kyaw;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);
v = AV_data.fb5.vyaw;
a = AV_data.fb5.ayaw;
k = AV_data.fb5.kyaw;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);
v = AV_data.fb6.vyaw;
a = AV_data.fb6.ayaw;
k = AV_data.fb6.kyaw;
fill(v(k),a(k),[0.7,0.7,0.7],'FaceAlpha',0.3,'EdgeColor',[0.7,0.7,0.7]);

xlabel('Yaw velocity (rad/s)')
ylabel('Yaw acceleration (rad/s^2)')
title('Yawvel-accel, mouse frame')
ylim([-30 30])
xlim([-3 3]) 

%% Plot bounds and scatter points
clear all
load('AV_data.mat')

figure
x0 = 2400;
y0 = -300;
width = 2200;
height = 400;
set(gcf,'position',[x0,y0,width,height])
set(gcf,'color','w');

subplot(1,3,1)
hold on
v = AV_data.fb1.vx;
a = AV_data.fb1.ax;
k = AV_data.fb1.kx;
plot(v(k),a(k),'Color',[0.4,0.4,0.4])
scatter(v,a,20,'filled','MarkerFaceColor',[0.7,0.7,0.7],'MarkerFaceAlpha',0.3,'MarkerEdgeColor','None');
v = AV_data.fb2.vx;
a = AV_data.fb2.ax;
k = AV_data.fb2.kx;
plot(v(k),a(k),'Color',[0.4,0.4,0.4])
scatter(v,a,20,'filled','MarkerFaceColor',[0.7,0.7,0.7],'MarkerFaceAlpha',0.3,'MarkerEdgeColor','None');
v = AV_data.fb3.vx;
a = AV_data.fb3.ax;
k = AV_data.fb3.kx;
plot(v(k),a(k),'Color',[0.4,0.4,0.4])
scatter(v,a,20,'filled','MarkerFaceColor',[0.7,0.7,0.7],'MarkerFaceAlpha',0.3,'MarkerEdgeColor','None');

xlabel('x velocity (m/s)')
ylabel('x acceleration (m/s^2)')
title('X vel-accel, mouse frame')
ylim([-1 1])
xlim([-0.1 0.2])


subplot(1,3,2)
hold on
v = AV_data.fb1.vy;
a = AV_data.fb1.ay;
k = AV_data.fb1.ky;
plot(v(k),a(k),'Color',[0.4,0.4,0.4])
scatter(v,a,20,'filled','MarkerFaceColor',[0.7,0.7,0.7],'MarkerFaceAlpha',0.3,'MarkerEdgeColor','None');
v = AV_data.fb2.vy;
a = AV_data.fb2.ay;
k = AV_data.fb2.ky;
plot(v(k),a(k),'Color',[0.4,0.4,0.4])
scatter(v,a,20,'filled','MarkerFaceColor',[0.7,0.7,0.7],'MarkerFaceAlpha',0.3,'MarkerEdgeColor','None');
v = AV_data.fb3.vy;
a = AV_data.fb3.ay;
k = AV_data.fb3.ky;
plot(v(k),a(k),'Color',[0.4,0.4,0.4])
scatter(v,a,20,'filled','MarkerFaceColor',[0.7,0.7,0.7],'MarkerFaceAlpha',0.3,'MarkerEdgeColor','None');

xlabel('y velocity (m/s)')
ylabel('y acceleration (m/s^2)')
title('Y vel-accel, mouse frame')
ylim([-0.4 0.4])
xlim([-0.08 0.08])


subplot(1,3,3)
hold on
v = AV_data.fb1.vyaw;
a = AV_data.fb1.ayaw;
k = AV_data.fb1.kyaw;
plot(v(k),a(k),'Color',[0.4,0.4,0.4])
scatter(v,a,20,'filled','MarkerFaceColor',[0.7,0.7,0.7],'MarkerFaceAlpha',0.3,'MarkerEdgeColor','None');
v = AV_data.fb2.vyaw;
a = AV_data.fb2.ayaw;
k = AV_data.fb2.kyaw;
plot(v(k),a(k),'Color',[0.4,0.4,0.4])
scatter(v,a,20,'filled','MarkerFaceColor',[0.7,0.7,0.7],'MarkerFaceAlpha',0.3,'MarkerEdgeColor','None');
v = AV_data.fb3.vyaw;
a = AV_data.fb3.ayaw;
k = AV_data.fb3.kyaw;
plot(v(k),a(k),'Color',[0.4,0.4,0.4])
scatter(v,a,20,'filled','MarkerFaceColor',[0.7,0.7,0.7],'MarkerFaceAlpha',0.3,'MarkerEdgeColor','None');

xlabel('Yaw velocity (rad/s)')
ylabel('Yaw acceleration (rad/s^2)')
title('Yawvel-accel, mouse frame')
ylim([-20 20])
xlim([-2.5 2.5]) 


