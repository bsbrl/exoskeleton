function [exo_data] = load_exo_data(path)

    [file,path2fileexo] = uigetfile(strcat(path,'*.mat'));
    exostruc = load([path2fileexo,file]);
    exo_data = cell2mat(struct2cell(exostruc));

% Variables in Exo data are: 
% Col 1 = Actual joint pos theta 1 (rad)
% Col 2 = Actual joint pos theta 2 (rad)
% Col 3 = Actual joint pos theta 3 (rad)
% Col 4 = Actual joint pos theta 6 (rad)
% Col 5 = Op-space pos x (m)
% Col 6 = Op-space pos y (m)
% Col 7 = Op-space pos z (m)
% Col 8 = Op-space pos rotz (rad)
% Col 9 = Desired change in position x (m)
% Col 10 = Desired change in position y (m)
% Col 11 = Desired change in position z (m)
% Col 12 = Desired change in position rotz (rad)
% Col 13 = Loop time (ms)
% Col 14 = PWM command out theta 1 (V)
% Col 15 = PWM command out theta 2 (V)
% Col 16 = PWM command out theta 3 (V)
% Col 17 = PWM command out theta 6 (V)
% Col 18 = Fx (N) mouse frame
% Col 19 = Fy (N) mouse frame
% Col 20 = Fz (N) mouse frame
% Col 21 = Frotz (Nm) mouse frame
% Col 22 = cx (N.s/m)
% Col 23 = cy (N.s/m)
% Col 24 = cyaw (Nm.s/rad)
% Col 25 = mx (kg)
% Col 26 = my (kg)
% Col 27 = myaw (kg.m^2)
% Col 28 = LR (Left = 1, Right = 0... this may be wired to the sound instead)
% Col 29 = Air (1 = air puff active)
% Col 30 = Milk (L or R Milk being dispensed)
% Col 31 = Sync (sync pulse)

end