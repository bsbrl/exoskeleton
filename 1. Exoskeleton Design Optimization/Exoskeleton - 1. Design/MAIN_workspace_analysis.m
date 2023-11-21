% Delta robot design
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% With some functions from: Yuliya Smirnova (Delta robot kinematics, see license)
% Delta robot dynamics method from Zhang et al 2012
% 6 DoF dynamics using Recursive Newton Euler algorithm
clear all 

% This script will: 
% 1. Sweeps through a range of values for the 4 delta robot dimensions: Lp,
%    Ld, Rm, Rf
% 2. Calculates the full workspace for each set of dimensions
% 3. Checks whether the desired behavioral arena size will fit within the 
%    calculated workspace. All sets of dimensions that do encompass the
%    arena are moved to the 'solution space'.

% UNITS IN THIS SCRIPT ARE Millimeters 

%% Define some features of the goniometer and behavioral arena

d = 200;    % (mm) pivot point to delta platform distance
theta = 40; % (deg) picth and roll range
extra = d*sin(theta*pi/180); % (mm) +/- extra distance required in X and Y
h = 200;     % (mm) extra height required 

% Target Z range
Targ_Z = h + extra; % (mm) minimum height range

% Target XY range 
Targ_xy = 600; % (mm) X and Y arena size
Targ_xy = Targ_xy/2;  % abs to +/- value
Targ_xy = Targ_xy*sqrt(2); % square arena instead of circular
Targ_xy = Targ_xy + extra; % extra width required for pitch and roll (mm)

%% Parameter sweep
% Sweep through a range of values for the 4 delta robot dimensions:
% Lp, Ld, Rm, Rf; stores these values in a parameter matrix
%

d = 5;
A = zeros((140/d)^3,3,400); % workspace
B = zeros(4,size(A,3));     % param matrix

nn = 1;
for Rvals = 110:20:410
    Rf = Rvals;  % fixed platform radius
    for rvals = 10
        Rm = rvals;  % moving platform radius
        for lvals = 500:50:1500
            Ld = lvals;  % distal linkage length
            for Lvals = 200:25:600
                Lp = Lvals; % proximal linkage length
                n = 1; 
                for th1 = -45 : d : 90
                    for th2 = -45 : d : 90
                        for th3 = -45 : d : 90
                            the1 = deg2rad(th1);
                            the2 = deg2rad(th2);
                            the3 = deg2rad(th3);
                            [X, Y, Z, fl] = FKinemDelta(the1, the2, the3,Rf,Rm,Lp,Ld);
                            if fl == 0 
                               A(n,1,nn) = X;
                               A(n,2,nn) = Y;
                               A(n,3,nn) = Z;
                               n = n+1;
                            end
                         end
                    end
                end
                B(:,nn) = [Rf;Rm;Ld;Lp];
                nn = nn + 1;
            end
        end
    end
end


%%
Amax_x = zeros(1,size(A,3));
Amax_y = zeros(1,size(A,3));

for nn = 1:size(A,3)
    Amax_x(1,nn) = max(reshape(A(:,1,nn),1,[]));
    Amax_y(1,nn) = max(reshape(A(:,2,nn),1,[]));
end    

A_y = reshape(A(:,2,:),size(A,1),[]);
A_z = reshape(A(:,3,:),size(A,1),[]);

for nn = 1:size(A_y,2)
    [I,M] = max(A_y(:,nn));
    Iy(1,nn) = I;   % max y value i parameter set
    My(1,nn) = M;   % position of max y value in matrix
    z_pt(1,nn) = A_z(M,nn);
end

logicalZ = A_z.*0;
logicalY = logicalZ;

for nn = 1:size(A_y,2)
    logicalZ(:,nn) = A_z(:,nn)<(z_pt(1,nn)-Targ_Z);
	logicalY(:,nn) = A_y(:,nn)>(Targ_xy);
end

Soln = logicalZ.*logicalY;

SS = sum(Soln,1)>0;

TestB = SS.*B;

TestB(TestB==0)=[];
TestB = reshape(TestB,4,[]);

figure
plot3(TestB(3,:),TestB(4,:),TestB(1,:),'x','color', [0.5 0 0.5], 'MarkerSize',5)
xlabel('Ld (mm)'); ylabel('Lp (mm)'); zlabel('Rf (mm)')
grid on
title('Solution space all points')

SS = sum(Soln,1)>0;

PlotB = SS.*B;
PlotB = [PlotB(3,:); PlotB(4,:); PlotB(1,:)]';
PlotB(PlotB>0) = 1;

x = [500:50:1500]';
y = [200:25:600]';
z = [110:20:410]';

[X,Y,Z] = meshgrid(x,y,z);

Brear = [B(3,:); B(4,:); B(1,:)]';


clear V
for n = 1:size(x,1)
    for m = 1:size(y,1)
        for p = 1:size(z,1)           
            I = ismember(Brear,[x(n),y(m),z(p)],'rows');
            M = find(I==1);
            V(m,n,p) = PlotB(M,1);
        end
    end
end

figure
s = isosurface(x,y,z,V);
p = patch(s);
isonormals(x,y,z,V,p)
view(3);
xlabel('Ld (mm)'); ylabel('Lp (mm)'); zlabel('Rf (mm)')
title('Solution space surface')
p.FaceColor = [0.3010 0.7450 0.9330];

%%

                

