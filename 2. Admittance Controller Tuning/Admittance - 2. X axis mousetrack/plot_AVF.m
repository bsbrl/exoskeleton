function [] = plot_AVF(m1,c1,m2,c2,m3,c3)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% load subset of data
load('ExampleData.mat')
% Example_lowZ_full = M483_analysis_newsys_m0p08_c2;
% Example_tunedZ_full = M483_analysis_newsys_m0p04_c4;
% Example_highZ_full = M483_analysis_m0p1_0p1_c1_1;

% set up admittance plane
a = -1:0.2:1;
v = -0.05:0.025:0.15;
[V,A] = meshgrid(v,a);

subplot(1,3,1)
scatter3(Example_lowZ_full(:,2),Example_lowZ_full(:,3),Example_lowZ_full(:,4),4,'Filled','MarkerEdgeColor',[0.4940 0.1840 0.5560])
xlim([-0.05 0.15])
ylim([-0.5 0.5])
zlim([-1.5 2.5])
xlabel('Velocity (m/s)')
ylabel('Acceleration (m/s^2)')
zlabel('Force (N)')
title('Low Z')

F = m1.*A + c1.*V;
hold on
surf(V,A,F,'FaceAlpha',0.1,'EdgeColor','interp')
colormap('jet')
view([50 5]);
caxis([-1.5 2])

subplot(1,3,2)
scatter3(Example_tunedZ_full(:,2),Example_tunedZ_full(:,3),Example_tunedZ_full(:,4),4,'Filled','MarkerEdgeColor',[0.4940 0.1840 0.5560])
xlim([-0.05 0.15])
ylim([-0.5 0.5])
zlim([-1.5 2.5])
xlabel('Velocity (m/s)')
ylabel('Acceleration (m/s^2)')
zlabel('Force (N)')
title('Tuned Z')

F = m2.*A + c2.*V;
hold on
surf(V,A,F,'FaceAlpha',0.1,'EdgeColor','interp')
colormap('jet')
view([50 5]);
caxis([-1.5 2])

subplot(1,3,3)
scatter3(Example_highZ_full(:,2),Example_highZ_full(:,3),Example_highZ_full(:,4),4,'Filled','MarkerEdgeColor',[0.4940 0.1840 0.5560])
xlim([-0.05 0.15])
ylim([-0.5 0.5])
zlim([-1.5 2.5])
xlabel('Velocity (m/s)')
ylabel('Acceleration (m/s^2)')
zlabel('Force (N)')
title('High Z')

F = m3.*A + c3.*V;
hold on
surf(V,A,F,'FaceAlpha',0.1,'EdgeColor','interp')
colormap('jet')
view([50 5]);
caxis([-1.5 2])

end

