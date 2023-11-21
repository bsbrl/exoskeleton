function [G_i,maxTau_a_i] = MaxTau_a(Eta,Phi_i,Gamma_i,crossww,w_i,I_A)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu
% Using Eqauations from Zhang et al 2012 doi:10.1017/S0263574711000622

% the inertial torque of a single actuated joint

global Lp

G_i = Eta*Lp^2*cos(Phi_i)/cos(Gamma_i)*(crossww'/norm(crossww))+w_i'/cos(Phi_i);

maxTau_a_i = I_A*(G_i*G_i')^0.5;



end

