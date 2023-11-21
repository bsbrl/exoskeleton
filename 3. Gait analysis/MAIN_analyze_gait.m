% STATISTICAL ANALYSIS ON GAIT METRICS

% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

clear all 

framerate = 30;

[Gait] = load_data(framerate);

%% Seperate data into laps

confthresh = 0.9;

[Gait.M1.Exo1] = calc_steps(Gait.M1.Exo1,confthresh);
[Gait.M1.Exo2] = calc_steps(Gait.M1.Exo2,confthresh);
[Gait.M1.Exo3] = calc_steps(Gait.M1.Exo3,confthresh);
[Gait.M2.Exo1] = calc_steps(Gait.M2.Exo1,confthresh);
[Gait.M2.Exo2] = calc_steps(Gait.M2.Exo2,confthresh);
[Gait.M2.Exo3] = calc_steps(Gait.M2.Exo3,confthresh);
[Gait.M3.Exo1] = calc_steps(Gait.M3.Exo1,confthresh);

[Gait.M1.FB1] = calc_steps(Gait.M1.FB1,confthresh);
[Gait.M1.FB2] = calc_steps(Gait.M1.FB2,confthresh);
[Gait.M2.FB1] = calc_steps(Gait.M2.FB1,confthresh);
[Gait.M2.FB2] = calc_steps(Gait.M2.FB2,confthresh);
[Gait.M3.FB1] = calc_steps(Gait.M3.FB1,confthresh);
[Gait.M3.FB2] = calc_steps(Gait.M3.FB2,confthresh);

%% Stats on exo data
figure
[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M1.Exo1,1);
FL = Flen;      FLG = Flgrp;
HL = Hlen;      HLG = Hlgrp;
FC = Fcad;      FCG = Fcgrp;
HC = Hcad;      HCG = Hcgrp;
FVl = Fvel;     HVl = Hvel;
FVc = Fcvel;    HVc = Hcvel;
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100); hold on
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100); hold on
subplot(2,2,3)
scatter(Fcad,Fcvel.*100); hold on
subplot(2,2,4)
scatter(Hcad,Hcvel.*100); hold on

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M1.Exo2,2);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M1.Exo3,3);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M2.Exo1,4);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M2.Exo2,5);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M2.Exo3,6);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M3.Exo1,7);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)


subplot(2,2,1)
title('Exo Forepaw')
xlabel('Step length (cm)')
ylabel('velocity (cm/s)')
subplot(2,2,2)
title('Exo Hindpaw')
xlabel('Step length (cm)')
ylabel('velocity (cm/s)')
subplot(2,2,3)
title('Exo Forepaw')
xlabel('Cadence (Hz)')
ylabel('velocity (cm/s)')
subplot(2,2,4)
title('Exo Hindpaw')
xlabel('Cadence (Hz)')
ylabel('velocity (cm/s)')

legend('1','2','3','4','5','6','7')

clear Flen Hlen Fcad Hcad Flgrp Hlgrp Fcgrp Hcgrp Fcvel Hcvel Hvel Fvel

figure('Renderer', 'painters', 'Position', [200 200 1200 350])
set(gcf,'color','w');
subplot(1,4,1)
boxplot(FL.*100,FLG,'PlotStyle','compact');
title('Exo Forepaw')
ylabel('Length (cm)')
subplot(1,4,2)
boxplot(HL.*100,HLG,'PlotStyle','compact');
title('Exo Hindpaw')
ylabel('Length (cm)')
subplot(1,4,3)
boxplot(FC,FCG,'PlotStyle','compact');
title('Exo Forepaw')
ylabel('Cadance (Hz)')
subplot(1,4,4)
boxplot(HC,HCG,'PlotStyle','compact');
title('Exo Hindpaw')
ylabel('Cadance (Hz)')

Exo.FL = FL;
Exo.HL = HL;
Exo.FC = FC;
Exo.HC = HC;
Exo.FV = FVl;
Exo.HV = HVl;
Exo.FVc = FVc;
Exo.HVc = HVc;

%% Stats on freely behaving data
figure
[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M1.FB1,1);
FL = Flen; FLG = Flgrp;
HL = Hlen; HLG = Hlgrp;
FC = Fcad; FCG = Fcgrp;
HC = Hcad; HCG = Hcgrp;
FVl = Fvel;     HVl = Hvel;
FVc = Fcvel;    HVc = Hcvel;
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100); hold on
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100); hold on
subplot(2,2,3)
scatter(Fcad,Fcvel.*100); hold on
subplot(2,2,4)
scatter(Hcad,Hcvel.*100); hold on

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M1.FB2,2);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M2.FB1,3);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M2.FB2,4);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M3.FB1,5);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)

[Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Gait.M3.FB2,6);
FL = [FL;Flen];     FLG = [FLG;Flgrp];
HL = [HL;Hlen];     HLG = [HLG;Hlgrp];
FC = [FC;Fcad];     FCG = [FCG;Fcgrp];
HC = [HC;Hcad];     HCG = [HCG;Hcgrp];
FVl = [FVl;Fvel];   HVl = [HVl;Hvel];
FVc = [FVc;Fcvel];  HVc = [HVc;Hcvel];
subplot(2,2,1)
scatter(Flen.*100,Fvel.*100)
subplot(2,2,2)
scatter(Hlen.*100,Hvel.*100)
subplot(2,2,3)
scatter(Fcad,Fcvel.*100)
subplot(2,2,4)
scatter(Hcad,Hcvel.*100)

subplot(2,2,1)
title('FB Forepaw')
xlabel('Step length (cm)')
ylabel('velocity (cm/s)')
subplot(2,2,2)
title('FB Hindpaw')
xlabel('Step length (cm)')
ylabel('velocity (cm/s)')
subplot(2,2,3)
title('FB Forepaw')
xlabel('Cadence (Hz)')
ylabel('velocity (cm/s)')
subplot(2,2,4)
title('FB Hindpaw')
xlabel('Cadence (Hz)')
ylabel('velocity (cm/s)')

legend('1','2','3','4','5','6','7')

clear Flen Hlen Fcad Hcad Flgrp Hlgrp Fcgrp Hcgrp

figure('Renderer', 'painters', 'Position', [200 200 1200 350])
set(gcf,'color','w');
subplot(1,4,1)
boxplot(FL.*100,FLG,'PlotStyle','compact');
title('FB Forepaw')
ylabel('Length (cm)')
subplot(1,4,2)
boxplot(HL.*100,HLG,'PlotStyle','compact');
title('FB Hindpaw')
ylabel('Length (cm)')
subplot(1,4,3)
boxplot(FC,FCG,'PlotStyle','compact');
title('FB Forepaw')
ylabel('Cadance (Hz)')
subplot(1,4,4)
boxplot(HC,HCG,'PlotStyle','compact');
title('FB Hindpaw')
ylabel('Cadance (Hz)')

FB.FL = FL;
FB.HL = HL;
FB.FC = FC;
FB.HC = HC;
FB.FV = FVl;
FB.HV = HVl;
FB.FVc = FVc;
FB.HVc = HVc;

%% 
figure
subplot(2,2,1)
scatter(FB.FL.*100,FB.FV.*100,'o')
hold on
scatter(Exo.FL.*100,Exo.FV.*100,'x')
title('Forepaw')
xlabel('Step length (cm)')
ylabel('velocity (cm/s)')

subplot(2,2,2)
scatter(FB.HL.*100,FB.HV.*100,'o')
hold on
scatter(Exo.HL.*100,Exo.HV.*100,'x')
title('Hindpaw')
xlabel('Step length (cm)')
ylabel('velocity (cm/s)')

subplot(2,2,3)
scatter(FB.FC,FB.FVc.*100,'o')
hold on
scatter(Exo.FC,Exo.FVc.*100,'x')
title('Forepaw')
xlabel('Cadance (Hz)')
ylabel('velocity (cm/s)')

subplot(2,2,4)
scatter(FB.HC,FB.HVc.*100,'o')
hold on
scatter(Exo.HC,Exo.HVc.*100,'x')
title('Hindpaw')
xlabel('Cadance (Hz)')
ylabel('velocity (cm/s)')


%% Compare groups

% step length
y1 = FB.FL;
y2 = Exo.FL;
g1 = repmat("FB",size(y1,1),1);
g2 = repmat("Exo",size(y2,1),1);
figure
boxplot([y1;y2],[g1;g2],'PlotStyle','compact');
title('Forepaw step length')
ylabel('Length (cm)')
[pFL,tblFL,statsFL] = anova1([y1;y2],[g1;g2],'off');
[sFL(1),sFL(2)] = datastats(y1,y2);
figure
[cFL,~,~,~] = multcompare(statsFL);

% step length
y1 = FB.HL;
y2 = Exo.HL;
g1 = repmat("FB",size(y1,1),1);
g2 = repmat("Exo",size(y2,1),1);
figure
boxplot([y1;y2],[g1;g2],'PlotStyle','compact');
title('Hindpaw step length')
ylabel('Length (cm)')
[pHL,tblHL,statsHL] = anova1([y1;y2],[g1;g2],'off');
[sHL(1),sHL(2)] = datastats(y1,y2);
figure
[cHL,~,~,~] = multcompare(statsHL);


% cadance
y1 = FB.FC;
y2 = Exo.FC;
g1 = repmat("FB",size(y1,1),1);
g2 = repmat("Exo",size(y2,1),1);
figure
boxplot([y1;y2],[g1;g2],'PlotStyle','compact');
title('Forepaw cadance')
ylabel('Cadance (Hz)')
[pFC,tblFC,statsFC] = anova1([y1;y2],[g1;g2],'off');
[sFC(1),sFC(2)] = datastats(y1,y2);
figure
[cFC,~,~,~]  = multcompare(statsFC);

% cadance
y1 = FB.HC;
y2 = Exo.HC;
g1 = repmat("FB",size(y1,1),1);
g2 = repmat("Exo",size(y2,1),1);
figure
boxplot([y1;y2],[g1;g2],'PlotStyle','compact');
title('Hindpaw cadance')
ylabel('Cadance (Hz)')
[pHC,tblHC,statsHC] = anova1([y1;y2],[g1;g2],'off');
[sHC(1),sHC(2)] = datastats(y1,y2);
figure
[cHC,~,~,~] = multcompare(statsHC);




%%






