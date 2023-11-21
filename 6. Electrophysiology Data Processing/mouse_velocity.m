function [vel_mouse,vel_mouse_yaw,accel_mouse,accel_mouse_yaw] = mouse_velocity(XYpos_global,Yawpos_global,tincr)
% Authors: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% transform to mouse frame and calc velocity
delXYpos_global = [(XYpos_global(2:end,:) - XYpos_global(1:end-1,:)); [0,0]];

delpos_mouseyaw = [(Yawpos_global(2:end,:) - Yawpos_global(1:end-1,:)); [0]];

for n = 1:size(delXYpos_global,1)
    
     delpos_mousevec(:,n) = Rotzfun(Yawpos_global(n,:))'*[delXYpos_global(n,:),0]';
    
end

delpos_mousevec = delpos_mousevec';

vel_mouse = delpos_mousevec./tincr;
vel_mouse_yaw = delpos_mouseyaw./tincr;

% smooth velocity signals
vel_mouse = medfilt1(vel_mouse,13);
vel_mouse = movmean(vel_mouse,5);
vel_mouse = medfilt1(vel_mouse,13);
vel_mouse = movmean(vel_mouse,5);


vel_mouse_yaw = medfilt1(vel_mouse_yaw,13);
vel_mouse_yaw = movmean(vel_mouse_yaw,5);
vel_mouse_yaw = medfilt1(vel_mouse_yaw,13);
vel_mouse_yaw = movmean(vel_mouse_yaw,5);


accel_mouse = [[0,0,0]; (vel_mouse(2:end,:) - vel_mouse(1:end-1,:))]./tincr;
accel_mouse_yaw = [[0]; (vel_mouse_yaw(2:end,:) - vel_mouse_yaw(1:end-1,:))]./tincr;


end

