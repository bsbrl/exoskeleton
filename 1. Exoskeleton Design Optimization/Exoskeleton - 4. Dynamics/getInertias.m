function [hOD,hO4,hO5,hO6] = getInertias()
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Tranforming goniometer linkage inertias between coordinate frames

% Joint inertias 

% linkage D
Icm = [218594.34, 280.26, -7588.60;...
            280.26, 211697.40, -1485.22;...
            -7588.60, -1485.22, 151583.63];
% convert to kg.m^2
Icm = Icm./1000000000;

m = 0.440; % kg

IC = [Icm, zeros(3,3);...
        zeros(3,3), m*eye(3)];

v = [-74.62; 3.38; 6.18]./1000;

Sv = [0, -v(3), v(2);...
     v(3), 0, -v(1);...
     -v(2), v(1), 0];
 
hOD = [Icm+m*Sv*Sv', m*Sv;...
      m*Sv', m*eye(3)];

hO_altD = [m*eye(3), m*Sv';...
         m*Sv, Icm+m*Sv*Sv'];
     
     
% Joint 4
Icm = [336472.48, -18557.99, 115567.10;...
            -18557.99, 394048.85, -8274.93;...
            115567.10, -8274.93, 310000.29];
% convert to kg.m^2
Icm = Icm./1000000000;

m = 0.47178; % kg

IC = [Icm, zeros(3,3);...
        zeros(3,3), m*eye(3)];

v = [-74.62; 3.38; 6.18]./1000;

Sv = [0, -v(3), v(2);...
     v(3), 0, -v(1);...
     -v(2), v(1), 0];
 
hO4 = [Icm+m*Sv*Sv', m*Sv;...
      m*Sv', m*eye(3)];

hO_alt4 = [m*eye(3), m*Sv';...
         m*Sv, Icm+m*Sv*Sv'];
     
% add motor inertia
motor = zeros(6,6);
motor(6,6) = 0.0074;

hO_alt4wmotor = hO_alt4 + motor;
     
% Joint 5

% 3D inertia at centre of mass
Icm = [274945.62, -393.42, -55209.44;...
            -393.42, 291983.08, 1568.64;...
            -55209.44, 1568.64, 178988.95];

% convert to kg.m^2
Icm = Icm./1000000000;

% mass
m = 0.45061; % kg

% 6D spatial inertia at cm
IC = [Icm, zeros(3,3);...
        zeros(3,3), m*eye(3)];

% distance vector from center of mass to point O
v = [40.73; -0.1; -0.04]./1000;

Sv = [0, -v(3), v(2);...
     v(3), 0, -v(1);...
     -v(2), v(1), 0];

 % 6D spatial inertia at point O, arrange for Force vectors:
 % [rot,rot,rot,x,y,z]
hO5 = [Icm+m*Sv*Sv', m*Sv;...
      m*Sv', m*eye(3)];

 % 6D spatial inertia at point O, arrange for Force vectors:
 % [x,y,z,rot,rot,rot]
hO_alt5 = [m*eye(3), m*Sv';...
         m*Sv, Icm+m*Sv*Sv'];
     
% add motor inertia
motor = zeros(6,6);
motor(6,6) = 0.0074;

hO_alt5wmotor = hO_alt5 + motor;
     
% Joint 6

Icm = [2336160, -1138.23, 9061.14;...
            -1138.23, 1808522.33, -1886.73;...
            9061.14, -1886.73, 1800903.67];
% convert to kg.m^2
Icm = Icm./1000000000;

m = 0.885; % kg

IC = [Icm, zeros(3,3);...
        zeros(3,3), m*eye(3)];

v = [14.05; 0.11; -125.75]./1000;

Sv = [0, -v(3), v(2);...
     v(3), 0, -v(1);...
     -v(2), v(1), 0];
 
hO6 = [Icm+m*Sv*Sv', m*Sv;...
      m*Sv', m*eye(3)];

hO_alt6 = [m*eye(3), m*Sv';...
         m*Sv, Icm+m*Sv*Sv']; 
     
% add motor inertia
motor = zeros(6,6);
motor(6,6) = 0.0074;

hO_alt6wmotor = hO_alt6 + motor;

% remember to scale J6 inertia depending on headstage
% installed


     
     


end

