function [vel_xy,accel_xy,vel_yaw,accel_yaw,time] = bodypts2velaccel(data,tincr,add)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% in global frame
% marker 7
bodypoint1 = [data(:,20),data(:,21)];   % [x,y]
bodypoint1(:,3) = 0; % no z movement
bodypoint1 = movmean(bodypoint1,[5 5]);
% marker 4
bodypoint2 = [data(:,11),data(:,12)];  % [x,y]
bodypoint2(:,3) = 0; % no z movement
bodypoint2 = movmean(bodypoint2,[5 5]);

% body orientation = atan((y2-y1)/(x2-x1))   (radians)
% in global frame
bodyorient = atan((bodypoint2(:,2)-bodypoint1(:,2))./(bodypoint2(:,1)-bodypoint1(:,1)))+add;
bodyorient = unwrap(2.*bodyorient)./2;

% average body position
% in global frame
bodypointav = (bodypoint1 + bodypoint2)./2;

% change in average body position
% in global frame
del_bodypointav = bodypointav(2:end,:) - bodypointav(1:end-1,:);
del_bodypointav = [del_bodypointav;del_bodypointav(end,:)];  % add an extra row to maintain matrix dimensions

del_body_orient = bodyorient(2:end,:) - bodyorient(1:end-1,:);
del_body_orient = [del_body_orient;del_body_orient(end,:)];  % add an extra row to maintain matrix dimensions

% transform from global frame to mouse frame at time t
for t = 1:size(bodyorient,1)
    
    [Rotz] = Rotzfun(bodyorient(t,1));
    
    transformation(:,:,t) = [Rotz, [bodypointav(t,1:3)]';...
                                0,0,0,1];
end

% calculate change in body positions in the mouse frame at time t
% describe each new point in the mouse frame of the previous point
for t = 2:size(del_body_orient,1)

    pt_m = [bodypointav(t,:), 1]';
    trans = transformation(:,:,t-1);
    del_bodypointav_m(t,:) = [inv(trans)*pt_m]';
    
end

% head yaw angle is the difference between head and body orientation in the
% global frame
% Head marker position in global frame
% marker 1
headpoint = [data(:,2),data(:,3)];
headpoint(:,3) = 0;  % no z axis
headpoint = movmean(headpoint,[5 5]);

% head orientation = atan((y2-y1)/(x2-x2))   (radians)
% in global frame
headorient = atan((headpoint(:,2)-bodypoint2(:,2))./(headpoint(:,1)-bodypoint2(:,1)));

% unwrap phase
headorient = unwrap(2.*headorient)./2;

% in mouse frame
headorient_m = headorient - bodyorient; % radians
del_headorient_m = headorient_m(2:end,:) - headorient_m(1:end-1,:);
del_headorient_m = [del_headorient_m;del_headorient_m(end,:)];

% time vec
time = [0:tincr:tincr*(size(del_body_orient,1)-1)]';

% convert to velocities and accelerations
vel_xy = del_bodypointav_m./tincr;
vel_yaw = del_headorient_m./tincr;

accel_xy = [[0 0 0 0]; diff(vel_xy)]./tincr;
accel_yaw = [0; diff(vel_yaw)]./tincr;


end

