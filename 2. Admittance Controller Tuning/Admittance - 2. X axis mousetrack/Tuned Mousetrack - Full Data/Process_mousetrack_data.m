function [Mx] = Process_mousetrack_data(data,clip)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

tincr = 0.01;   % (s)
% extract some useful parameters from exosksleton data
Xforce = data(clip(1):clip(2),18);  %(N)
Yforce = data(clip(1):clip(2),19);  %(N)
yawforce = data(clip(1):clip(2),21);  %(Nm)
time = [0:tincr:tincr*(size(Xforce,1)-1)]';   % (s)

XYpos_global = data(clip(1):clip(2),5:6);  %(m)
delXYpos_global = [(XYpos_global(2:end,:) - XYpos_global(1:end-1,:)); [0,0]];

delXY_admittance = data(clip(1):clip(2),9:10);   % (m)
delYaw_admittance = data(clip(1):clip(2),12);   % (m)

YAWpos = data(clip(1):clip(2),8);  %(m)  
delpos_mouseyaw = [(YAWpos(2:end,:) - YAWpos(1:end-1,:)); [0]];

%  find yaw pos in mouse ref frame 
for n = 1:size(delXYpos_global,1)
     delpos_mousevec(:,n) = Rotzfun(YAWpos(n,:))'*[delXYpos_global(n,:),0]';
end
delpos_mousevec = delpos_mousevec';

vel_mouse = delpos_mousevec./tincr;
vel_mouse_yaw = delpos_mouseyaw./tincr;

% smooth velocity signals
[vel_mouse] = medmovmeanfilt(vel_mouse,13,5);
[vel_mouse] = medmovmeanfilt(vel_mouse,13,5);

[vel_mouse_yaw] = medmovmeanfilt(vel_mouse_yaw,13,5);
[vel_mouse_yaw] = medmovmeanfilt(vel_mouse_yaw,13,5);

accel_mouse = [[0,0,0]; (vel_mouse(2:end,:) - vel_mouse(1:end-1,:))]./tincr;
accel_mouse_yaw = [[0]; (vel_mouse_yaw(2:end,:) - vel_mouse_yaw(1:end-1,:))]./tincr;

figure
scatter3(vel_mouse(:,1),accel_mouse(:,1),Xforce)
xlabel('velocity (m/s)')
ylabel('acceleration (m/s^2)')
zlabel('force (N)')
% title('mouse frame admittance controller')

a = -1:0.2:1;
v = -0.05:0.025:0.15;

[V,A] = meshgrid(v,a);

max_a = max(a);
min_a = min(a);
max_v = max(v);
min_v = min(v);

F = 1.*A + 1.*V;

hold on
surf(V,A,F,'FaceAlpha',0.1,'EdgeColor','interp')

colormap('jet')
colorbar
xlim([min_v max_v])
ylim([min_a max_a])

vx = vel_mouse(:,1);
ax = accel_mouse(:,1);
fx = Xforce;
kx = boundary(vx,ax,0.1);
Qx = abs(trapz(vx(kx),ax(kx)));

Mx.vx = vx;
Mx.ax = ax;
Mx.fx = fx;
Mx.kx = kx;
Mx.Qx = Qx;

end

