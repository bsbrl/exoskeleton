function [] = plot_VA_profiles(AV_data)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


subplot(2,3,5)
hold on
v = AV_data.fb1.vx;
a = AV_data.fb1.ax;
k = AV_data.fb1.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb2.vx;
a = AV_data.fb2.ax;
k = AV_data.fb2.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb3.vx;
a = AV_data.fb3.ax;
k = AV_data.fb3.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb4.vx;
a = AV_data.fb4.ax;
k = AV_data.fb4.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb5.vx;
a = AV_data.fb5.ax;
k = AV_data.fb5.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb6.vx;
a = AV_data.fb6.ax;
k = AV_data.fb6.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

% tuned and trained
v = AV_data.trained1.vx;
a = AV_data.trained1.ax;
k = AV_data.trained1.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.trained2.vx;
a = AV_data.trained2.ax;
k = AV_data.trained2.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.trained3.vx;
a = AV_data.trained3.ax;
k = AV_data.trained3.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.trained4.vx;
a = AV_data.trained4.ax;
k = AV_data.trained4.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

xlabel('x velocity (m/s)')
ylabel('x acceleration (m/s^2)')
title('X vel-accel, tuned and trained vs freely behaving')
ylim([-1 1])
xlim([-0.1 0.2])




subplot(2,3,3)

hold on
v = AV_data.fb1.vx;
a = AV_data.fb1.ax;
k = AV_data.fb1.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb2.vx;
a = AV_data.fb2.ax;
k = AV_data.fb2.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb3.vx;
a = AV_data.fb3.ax;
k = AV_data.fb3.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb4.vx;
a = AV_data.fb4.ax;
k = AV_data.fb4.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb5.vx;
a = AV_data.fb5.ax;
k = AV_data.fb5.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb6.vx;
a = AV_data.fb6.ax;
k = AV_data.fb6.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

% high
v = AV_data.highz1.vx;
a = AV_data.highz1.ax;
k = AV_data.highz1.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.highz2.vx;
a = AV_data.highz2.ax;
k = AV_data.highz2.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.highz3.vx;
a = AV_data.highz3.ax;
k = AV_data.highz3.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.highz4.vx;
a = AV_data.highz4.ax;
k = AV_data.highz4.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

xlabel('x velocity (m/s)')
ylabel('x acceleration (m/s^2)')
title('X vel-accel, highZ vs freely behaving')
ylim([-1 1])
xlim([-0.1 0.2])


subplot(2,3,2)

hold on
v = AV_data.fb1.vx;
a = AV_data.fb1.ax;
k = AV_data.fb1.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb2.vx;
a = AV_data.fb2.ax;
k = AV_data.fb2.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb3.vx;
a = AV_data.fb3.ax;
k = AV_data.fb3.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb4.vx;
a = AV_data.fb4.ax;
k = AV_data.fb4.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb5.vx;
a = AV_data.fb5.ax;
k = AV_data.fb5.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb6.vx;
a = AV_data.fb6.ax;
k = AV_data.fb6.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

% tuned
v = AV_data.tunedz1.vx;
a = AV_data.tunedz1.ax;
k = AV_data.tunedz1.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.tunedz2.vx;
a = AV_data.tunedz2.ax;
k = AV_data.tunedz2.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.tunedz3.vx;
a = AV_data.tunedz3.ax;
k = AV_data.tunedz3.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.tunedz4.vx;
a = AV_data.tunedz4.ax;
k = AV_data.tunedz4.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

xlabel('x velocity (m/s)')
ylabel('x acceleration (m/s^2)')
title('X vel-accel, tunedZ vs freely behaving')
ylim([-1 1])
xlim([-0.1 0.2])



subplot(2,3,1)

hold on
v = AV_data.fb1.vx;
a = AV_data.fb1.ax;
k = AV_data.fb1.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb2.vx;
a = AV_data.fb2.ax;
k = AV_data.fb2.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb3.vx;
a = AV_data.fb3.ax;
k = AV_data.fb3.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb4.vx;
a = AV_data.fb4.ax;
k = AV_data.fb4.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb5.vx;
a = AV_data.fb5.ax;
k = AV_data.fb5.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.fb6.vx;
a = AV_data.fb6.ax;
k = AV_data.fb6.kx;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

% low z
v = AV_data.lowz1.vx;
a = AV_data.lowz1.ax;
k = AV_data.lowz1.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.lowz2.vx;
a = AV_data.lowz2.ax;
k = AV_data.lowz2.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.lowz3.vx;
a = AV_data.lowz3.ax;
k = AV_data.lowz3.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

v = AV_data.lowz4.vx;
a = AV_data.lowz4.ax;
k = AV_data.lowz4.kx;
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

xlabel('x velocity (m/s)')
ylabel('x acceleration (m/s^2)')
title('X vel-accel, lowZ vs freely behaving')
ylim([-1 1])
xlim([-0.1 0.2])

end

