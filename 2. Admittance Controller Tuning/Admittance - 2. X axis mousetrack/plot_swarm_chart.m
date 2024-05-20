
%% Plot swarm charts from AV data

load('AV_data.mat')

%% INDIVIDUAL ANIMALS 

msz = 10;

figure
set(gcf,'color','white')
hold on
% Mouse 1 FB
v = [AV_data.fb1.vx; AV_data.fb2.vx; AV_data.fb3.vx];
swarmchart(1.*ones(size(v)),v,msz,[0.7 0.7 0.7],'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 2 FB
v = [AV_data.fb4.vx; AV_data.fb5.vx];
swarmchart(2.*ones(size(v)),v,msz,[0.7 0.7 0.7],'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 3 FB
v = [AV_data.fb6.vx];
swarmchart(3.*ones(size(v)),v,msz,[0.7 0.7 0.7],'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

% Mouse 4 LowZ
v = AV_data.lowz1.vx;
swarmchart(5.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 5 LowZ
v = AV_data.lowz2.vx;
swarmchart(6.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 6 LowZ
v = AV_data.lowz3.vx;
swarmchart(7.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 7 LowZ
v = AV_data.lowz4.vx;
swarmchart(8.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)


% Mouse 4 TunedZ
v = AV_data.tunedz1.vx;
swarmchart(10.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 5 TunedZ
v = AV_data.tunedz2.vx;
swarmchart(11.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 6 TunedZ
v = AV_data.tunedz3.vx;
swarmchart(12.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 7 TunedZ
v = AV_data.tunedz4.vx;
swarmchart(13.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)


% Mouse 4 highz
v = AV_data.highz1.vx;
swarmchart(15.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 5 highz
v = AV_data.highz2.vx;
swarmchart(16.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 6 highz
v = AV_data.highz3.vx;
swarmchart(17.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 7 highz
v = AV_data.highz4.vx;
swarmchart(18.*ones(size(v)),v,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)


% Mouse 4 trainedz
v = AV_data.trained1.vx;
swarmchart(20.*ones(size(v)),v,msz,[0 0.4470 0.7410],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 5 trainedz
v = AV_data.trained2.vx;
swarmchart(21.*ones(size(v)),v,msz,[0 0.4470 0.7410],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 6 trainedz
v = AV_data.trained3.vx;
swarmchart(22.*ones(size(v)),v,msz,[0 0.4470 0.7410],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 7 trainedz
v = AV_data.trained4.vx;
swarmchart(23.*ones(size(v)),v,msz,[0 0.4470 0.7410],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

xtickangle(45)
xticks([1 2 3  5 6 7 8  10 11 12 13  15 16 17 18  20 21 22 23])
xticklabels({'Mouse 1 FB','Mouse 2 FB','Mouse 3 FB' , 'Mouse 4 Low z','Mouse 5 Low z','Mouse 6 Low z','Mouse 7 Low z' , 'Mouse 4 Tuned z','Mouse 5 Tuned z','Mouse 6 Tuned z','Mouse 7 Tuned z' , 'Mouse 4 High z','Mouse 5 High z','Mouse 6 High z','Mouse 7 High z' , 'Mouse 4 Trained z','Mouse 5 Trained z','Mouse 6 Trained z','Mouse 7 Trained z'})
ylabel('X velocity (m/s)')
title('X velocity distributions')

%%

figure
set(gcf,'color','white')
hold on
% Mouse 1 FB
a = [AV_data.fb1.ax; AV_data.fb2.ax; AV_data.fb3.ax];
swarmchart(1.*ones(size(a)),a,msz,[0.7 0.7 0.7],'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 2 FB
a = [AV_data.fb4.ax; AV_data.fb5.ax];
swarmchart(2.*ones(size(a)),a,msz,[0.7 0.7 0.7],'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 3 FB
a = [AV_data.fb6.ax];
swarmchart(3.*ones(size(a)),a,msz,[0.7 0.7 0.7],'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

% Mouse 4 LowZ
a = AV_data.lowz1.ax;
swarmchart(5.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 5 LowZ
a = AV_data.lowz2.ax;
swarmchart(6.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 6 LowZ
a = AV_data.lowz3.ax;
swarmchart(7.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 7 LowZ
a = AV_data.lowz4.ax;
swarmchart(8.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)


% Mouse 4 TunedZ
a = AV_data.tunedz1.ax;
swarmchart(10.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 5 TunedZ
a = AV_data.tunedz2.ax;
swarmchart(11.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 6 TunedZ
a = AV_data.tunedz3.ax;
swarmchart(12.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 7 TunedZ
a = AV_data.tunedz4.ax;
swarmchart(13.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)


% Mouse 4 highz
a = AV_data.highz1.ax;
swarmchart(15.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 5 highz
a = AV_data.highz2.ax;
swarmchart(16.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 6 highz
a = AV_data.highz3.ax;
swarmchart(17.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 7 highz
a = AV_data.highz4.ax;
swarmchart(18.*ones(size(a)),a,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)


% Mouse 4 trainedz
a = AV_data.trained1.ax;
swarmchart(20.*ones(size(a)),a,msz,[0 0.4470 0.7410],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 5 trainedz
a = AV_data.trained2.ax;
swarmchart(21.*ones(size(a)),a,msz,[0 0.4470 0.7410],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 6 trainedz
a = AV_data.trained3.ax;
swarmchart(22.*ones(size(a)),a,msz,[0 0.4470 0.7410],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
% Mouse 7 trainedz
a = AV_data.trained4.ax;
swarmchart(23.*ones(size(a)),a,msz,[0 0.4470 0.7410],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

xtickangle(45)
xticks([1 2 3  5 6 7 8  10 11 12 13  15 16 17 18  20 21 22 23])
xticklabels({'Mouse 1 FB','Mouse 2 FB','Mouse 3 FB' , 'Mouse 4 Low z','Mouse 5 Low z','Mouse 6 Low z','Mouse 7 Low z' , 'Mouse 4 Tuned z','Mouse 5 Tuned z','Mouse 6 Tuned z','Mouse 7 Tuned z' , 'Mouse 4 High z','Mouse 5 High z','Mouse 6 High z','Mouse 7 High z' , 'Mouse 4 Trained z','Mouse 5 Trained z','Mouse 6 Trained z','Mouse 7 Trained z'})
ylabel('X acceleration (m/s^2)')
title('X acceleration distributions')

%% GROUPED DATA 


figure
set(gcf,'color','white')
hold on
vfb = [AV_data.fb1.vx;... 
    AV_data.fb2.vx;...
    AV_data.fb3.vx;...
    AV_data.fb4.vx;...
    AV_data.fb5.vx;...
    AV_data.fb6.vx];

vlz = [AV_data.lowz1.vx;...
    AV_data.lowz1.vx;...
    AV_data.lowz1.vx;...
    AV_data.lowz1.vx];

vtz = [AV_data.tunedz1.vx;...
    AV_data.tunedz2.vx;...
    AV_data.tunedz3.vx;...
    AV_data.tunedz4.vx];

vhz = [AV_data.highz1.vx;...
    AV_data.highz2.vx;...
    AV_data.highz3.vx;...
    AV_data.highz4.vx];


vtrz = [AV_data.trained1.vx;...
    AV_data.trained2.vx;...
    AV_data.trained3.vx;...
    AV_data.trained4.vx];

msz = 10;

swarmchart(0.*ones(size(vfb)),vfb,msz,[0.7 0.7 0.7],'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

% swarmchart(1.*ones(size(vfb)),vfb,msz,[0.7 0.7 0.7],'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
swarmchart(1.*ones(size(vlz)),vlz,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

% swarmchart(2.*ones(size(vfb)),vfb,msz,[0.7 0.7 0.7],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
swarmchart(2.*ones(size(vtz)),vtz,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

% swarmchart(3.*ones(size(vfb)),vfb,msz,[0.7 0.7 0.7],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
swarmchart(3.*ones(size(vhz)),vhz,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
    
% swarmchart(4.*ones(size(vfb)),vfb,msz,[0.7 0.7 0.7],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
swarmchart(4.*ones(size(vtrz)),vtrz,msz,[0 0.4470 0.7410],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
    
% swarmchart(4.*ones(size(vfb)),vfb,6,[0.7 0.7 0.7],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

ylabel('x velocity (m/s)')
title('X velocity distributions')

% ylabel('x acceleration (m/s^2)')
% title('X vel-accel, tuned and trained vs freely behaving')
% ylim([-1 1])
% xlim([-0.1 0.2])


%%

figure
hold on
afb = [AV_data.fb1.ax;...
    AV_data.fb2.ax;...
    AV_data.fb3.ax;...
    AV_data.fb4.ax;...
    AV_data.fb5.ax;...
    AV_data.fb6.ax];

alz = [AV_data.lowz1.ax;...
    AV_data.lowz1.ax;...
    AV_data.lowz1.ax;...
    AV_data.lowz1.ax];

atz = [AV_data.tunedz1.ax;...
    AV_data.tunedz2.ax;...
    AV_data.tunedz3.ax;...
    AV_data.tunedz4.ax];

ahz = [AV_data.highz1.ax;...
    AV_data.highz2.ax;...
    AV_data.highz3.ax;...
    AV_data.highz4.ax];

atrz = [AV_data.trained1.ax;...
    AV_data.trained2.ax;...
    AV_data.trained3.ax;...
    AV_data.trained4.ax];

msz = 10;
swarmchart(0.*ones(size(afb)),afb,msz,[0.7 0.7 0.7],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

% swarmchart(1.*ones(size(afb)),afb,msz,[0.7 0.7 0.7],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
swarmchart(1.*ones(size(alz)),alz,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

% swarmchart(2.*ones(size(afb)),afb,msz,[0.7 0.7 0.7],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
swarmchart(2.*ones(size(atz)),atz,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

% swarmchart(3.*ones(size(afb)),afb,msz,[0.7 0.7 0.7],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
swarmchart(3.*ones(size(ahz)),ahz,msz,[0.3010 0.7450 0.9330],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

% swarmchart(4.*ones(size(afb)),afb,msz,[0.7 0.7 0.7],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
swarmchart(4.*ones(size(atrz)),atrz,msz,[0 0.4470 0.7410],'o','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

ylabel('x acceleration (m/s^2)')
title('X acceleration distributions')


%%
