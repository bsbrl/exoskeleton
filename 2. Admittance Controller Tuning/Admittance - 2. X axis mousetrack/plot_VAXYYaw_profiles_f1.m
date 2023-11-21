function [] = plot_VAXYYaw_profiles_f1(AV_data)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


% tuned z
subplot(1,3,1)

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
title('X vel-accel')
ylim([-0.8 0.8])
xlim([-0.06 0.2])

subplot(1,3,2)
hold on
v = AV_data.fb3.vy;
a = AV_data.fb3.ay;
k = AV_data.fb3.ky;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

v = AV_data.YYmidz2.vy;
a = AV_data.YYmidz2.ay;
k = AV_data.YYmidz2.ky;
% plot(v,a,'-k')
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);
ylim([-0.4 0.4])
xlim([-0.07 0.07])
xlabel('y velocity (m/s)')
ylabel('y acceleration (m/s^2)')
title('Y vel-accel')


subplot(1,3,3)
v = AV_data.fb5.vyaw;
a = AV_data.fb5.ayaw;
k = AV_data.fb5.kyaw;
plot(v(k),a(k),'Color',[0.7,0.7,0.7]);

hold on
v = AV_data.YYhighz1.vyaw;
a = AV_data.YYhighz1.ayaw;
k = AV_data.YYhighz1.kyaw;
% plot(v,a,'-k')
plot(v(k),a(k),'Color',[0.3010 0.7450 0.9330]);

ylim([-30 30])
xlim([-3.2 3])
xlabel('yaw velocity (rad/s)')
ylabel('yaw acceleration (rad/s^2)')
title('Yaw vel-accel')
legend('freely behaving','tuned')

end

