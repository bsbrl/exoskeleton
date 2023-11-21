function [Pred] = generate_Predictor(Behav_vars_rs,tincr,step,binD, binL)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

Logi_dzone = Behav_vars_rs(:,17);
Logi_loop = abs(Logi_dzone - 1);
Logi_still = double(Behav_vars_rs(:,4)<0.002);
Logi_move = abs(Logi_still - 1);

% include step s before movement onset into moving
onset = ceil(step/tincr);
for n = onset+1:length(Logi_move)-1
    if Logi_move(n,1) == 1 && Logi_move(n-onset,1) == 0
        Logi_move(n-onset:n) = 1;
    end
end

% create variable d containing data indices of mouse in dzone
m = 1;
for n = 2:length(Logi_dzone)
    if Logi_dzone(n,1) == 1 && Logi_dzone(n-1,1) == 0
        d(m,1) = n;
    elseif Logi_dzone(n,1) == 0 && Logi_dzone(n-1,1) == 1
        d(m,2) = n;
        m = m+1;
    end    
end

% Left and right loops
Logi_Yaw_Lbin = 0.*Logi_loop;
Logi_Yaw_Rbin = 0.*Logi_loop;

for n = 1:2:size(d,1)-1
    Logi_Yaw_Lbin(d(n,2):d(n+1,1)) = 1;
end
Logi_Yaw_Lbin = Logi_Yaw_Lbin.*Logi_loop.*Logi_move;

for n = 2:2:size(d,1)-1
    Logi_Yaw_Rbin(d(n,2):d(n+1,1)) = 1;
end
Logi_Yaw_Rbin = Logi_Yaw_Rbin.*Logi_loop.*Logi_move;


% Left and right turns in Dzone
Logi_turnL = 0.*Logi_dzone.*Logi_move;
Logi_turnR = 0.*Logi_dzone.*Logi_move;
for n = 1:2:size(d,1)
    Logi_turnL(d(n,1):d(n,2)) = 1;
end
for n = 2:2:size(d,1)
    Logi_turnR(d(n,1):d(n,2)) = 1;
end

edges_yaw = [pi/2:binL:2.5*pi];
Yaw_binned = discretize(Behav_vars_rs(:,3),edges_yaw);
Logi_Yaw_Lbin = Logi_Yaw_Lbin.*Yaw_binned;
Logi_Yaw_Rbin = Logi_Yaw_Rbin.*Yaw_binned;

edges_D = [-0.03:binD:0.13];
Dzone_binned = discretize(Behav_vars_rs(:,2),edges_D);
Logi_dzone_bin = Logi_dzone.*Dzone_binned;
Logi_turnL = Logi_turnL.*Dzone_binned;
Logi_turnR = Logi_turnR.*Dzone_binned;

figure
plot(Logi_Yaw_Lbin)
hold on
plot(Logi_Yaw_Rbin)
hold on
plot(Logi_turnL)
hold on
plot(Logi_turnR)
title('position binning')
legend('Left loop','Right loop','Turning zone left','Turning zone right')

TF = isnan(Logi_Yaw_Lbin);
Logi_Yaw_Lbin(TF,:) = 0;

TF = isnan(Logi_Yaw_Rbin);
Logi_Yaw_Rbin(TF,:) = 0;

TF = isnan(Logi_dzone_bin);
Logi_dzone_bin(TF,:) = 0;

TF = isnan(Logi_turnL);
Logi_turnL(TF,:) = 0;

TF = isnan(Logi_turnR);
Logi_turnR(TF,:) = 0;


Pred_YL = zeros(size(Logi_Yaw_Lbin,1),size(edges_yaw,2));

for n = 1:size(Logi_Yaw_Lbin,1)
    if Logi_Yaw_Lbin(n,1) == 0
    else
        index = Logi_Yaw_Lbin(n,1);
        Pred_YL(n,index) = 1;
    end
end

Pred_YR = zeros(size(Logi_Yaw_Rbin,1),size(edges_yaw,2));

for n = 1:size(Logi_Yaw_Rbin,1)
    if Logi_Yaw_Rbin(n,1) == 0
    else
        index = Logi_Yaw_Rbin(n,1);
        Pred_YR(n,index) = 1;
    end
end
Pred_YR = fliplr(Pred_YR); % flip because yaw decreases with progression around loop

Pred_D = zeros(size(Logi_dzone_bin,1),size(edges_D,2));

for n = 1:size(Logi_dzone_bin,1)
    if Logi_dzone_bin(n,1) == 0
    else
        index = Logi_dzone_bin(n,1);
        Pred_D(n,index) = 1;
    end
end

Pred_DL = zeros(size(Logi_dzone_bin,1),size(edges_D,2));

for n = 1:size(Logi_turnL,1)
    if Logi_turnL(n,1) == 0
    else
        index = Logi_turnL(n,1);
        Pred_DL(n,index) = 1;
    end
end

Pred_DR = zeros(size(Logi_dzone_bin,1),size(edges_D,2));

for n = 1:size(Logi_turnR,1)
    if Logi_turnR(n,1) == 0
    else
        index = Logi_turnR(n,1);
        Pred_DR(n,index) = 1;
    end
end


Pred = [Pred_DL,Pred_YL,Pred_DR,Pred_YR,Behav_vars_rs(:,13:16),...
        zscore(Behav_vars_rs(:,4:6)),zscore(Behav_vars_rs(:,7:9))];

    
end

