function [] = plot_time_series(AV_data)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% load subset of data
load('ExampleData.mat')
% Example_lowZ_full = M483_analysis_newsys_m0p08_c2;
% Example_tunedZ_full = M483_analysis_newsys_m0p04_c4;
% Example_highZ_full = M483_analysis_m0p1_0p1_c1_1;

figure; 

% Low Z
subplot(2,3,1) 
hold on
plot(Example_lowZ_full(:,1),Example_lowZ_full(:,2),'Color',[0 0.4470 0.7410]);
plot([26:0.034:26+412*0.034]',AV_data.fb3.vx(1425:1425+412,1),'Color',[0.5 0.5 0.5])
plot([26 46],[0 0],'-k'); 
xlim([26 46]); ylim([-0.05 0.2])
xlabel('time (s)')
ylabel('velocity (m/s)')
legend('exo','fb')
title('low Z')

subplot(2,3,4)
hold on
plot(Example_lowZ_full(:,1),Example_lowZ_full(:,4),'Color',[0.8500 0.3250 0.0980]);
xlim([26 46]); ylim([-1 2])
plot([26 46],[0 0],'-k')
xlabel('time (s)')
ylabel('force(N)')
legend('exo')

% High Z
subplot(2,3,3); hold on
plot(Example_highZ_full(:,1),Example_highZ_full(:,2),'Color',[0 0.4470 0.7410]);
plot([240:0.034:240+412*0.034]',AV_data.fb3.vx(1425:1425+412,1),'Color',[0.5 0.5 0.5])
plot([240 260],[0 0],'-k'); 
xlim([240 260]); ylim([-0.05 0.2])
xlabel('time (s)')
ylabel('velocity (m/s)')
legend('exo','fb')
title('high Z')

subplot(2,3,6); hold on
plot(Example_highZ_full(:,1),Example_highZ_full(:,4),'Color',[0.8500 0.3250 0.0980]);
xlim([240 260]); ylim([-1 2])
plot([240 260],[0 0],'-k')
xlabel('time (s)')
ylabel('force(N)')
legend('exo')

% Tuned Z
subplot(2,3,2); hold on
plot(Example_tunedZ_full(:,1),Example_tunedZ_full(:,2),'Color',[0 0.4470 0.7410]);
plot([166:0.034:166+412*0.034]',AV_data.fb3.vx(1425:1425+412,1),'Color',[0.5 0.5 0.5])
plot([166 186],[0 0],'-k'); 
xlim([166 186]); ylim([-0.05 0.2])
xlabel('time (s)')
ylabel('velocity (m/s)')
legend('exo','fb')
title('high Z')

subplot(2,3,5); hold on
plot(Example_tunedZ_full(:,1),Example_tunedZ_full(:,4),'Color',[0.8500 0.3250 0.0980]);
xlim([166 186]); ylim([-1 2])
plot([166 186],[0 0],'-k')
xlabel('time (s)')
ylabel('force(N)')
legend('exo')


end

