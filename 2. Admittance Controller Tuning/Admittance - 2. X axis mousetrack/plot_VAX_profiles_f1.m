function [] = plot_VAX_profiles_f1(AV_data)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% low z
subplot(1,3,1)

hold on
v = AV_data.fb3.vx;
a = AV_data.fb3.ax;
k = AV_data.fb3.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.lowz2.vx;
a = AV_data.lowz2.ax;
k = AV_data.lowz2.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

xlabel('x velocity (m/s)')
ylabel('x acceleration (m/s^2)')
title('X vel-accel, lowZ vs freely behaving')
ylim([-0.8 0.8])
xlim([-0.06 0.2])


% tuned z
subplot(1,3,2)

hold on
v = AV_data.fb3.vx;
a = AV_data.fb3.ax;
k = AV_data.fb3.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.trained1.vx;
a = AV_data.trained1.ax;
k = AV_data.trained1.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

xlabel('x velocity (m/s)')
ylabel('x acceleration (m/s^2)')
title('X vel-accel, tuned and trained vs freely behaving')
ylim([-0.8 0.8])
xlim([-0.06 0.2])

subplot(1,3,3)
hold on

v = AV_data.fb3.vx;
a = AV_data.fb3.ax;
k = AV_data.fb3.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

% high z
v = AV_data.highz4.vx;
a = AV_data.highz4.ax;
k = AV_data.highz4.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

xlabel('x velocity (m/s)')
ylabel('x acceleration (m/s^2)')
title('X vel-accel, highZ vs freely behaving')
ylim([-0.8 0.8])
xlim([-0.06 0.2])

end

