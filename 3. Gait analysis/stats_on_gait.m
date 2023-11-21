function [Flen,Hlen,Fcad,Hcad,Flgrp,Hlgrp,Fcgrp,Hcgrp,Fvel,Hvel,Fcvel,Hcvel] = stats_on_gait(Mousedat,num)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% load data
Fsteps = Mousedat.Fpaw;
Hsteps = Mousedat.Hpaw;


Flen = Fsteps(:,5);
Hlen = Hsteps(:,5);

Fcad = Fsteps(:,8);
Hcad = Hsteps(:,8);
% remove zeros in cadance because number of data offset
[Mf,~] = find(Fcad==0);
Fcad(Mf,:) = [];
[Mh,~] = find(Hcad==0);
Hcad(Mh,:) = [];

% groups for plotting
Flgrp = num.*ones(length(Flen),1);
Hlgrp = num.*ones(length(Hlen),1);
Fcgrp = num.*ones(length(Fcad),1);
Hcgrp = num.*ones(length(Hcad),1);

Fvel = Fsteps(:,12);
Hvel = Hsteps(:,12);

% remove zero cadence points
Fcvel = Fvel;
Fcvel(Mf,:) = [];
Hcvel = Hvel;
Hcvel(Mh,:) = [];


end

