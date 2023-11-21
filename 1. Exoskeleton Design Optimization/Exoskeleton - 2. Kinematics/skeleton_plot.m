function [] = skeleton_plot(Rf,Rm,Lp,r,Dmnq,theta,H_d4,H_45,H_56,H_6m,kappa_1,kappa_2,kappa_3,Rg)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% generic circle to represent goniometer stages
degs = 0:pi/20:2*pi;
gencirc = [Rg*sin(degs); Rg*cos(degs); 0*degs; 0*degs+1]; % 4D coordinates
degs = 0:pi/10:2*pi;
smallcirc = [Rg/4*sin(degs); Rg/4*cos(degs); 0*degs; 0*degs+1]; % 4D coordinates

% anglular offsets of delta motors from reference frame x-axis
Kappa = [kappa_1; kappa_2; kappa_3]; % (rad)

% fixed platform corner xyz coordinates
Fplatform = Rf*[cos(Kappa), sin(Kappa), 0*Kappa]';
temp = [Fplatform,Fplatform(:,1)];
plot3(temp(1,:),temp(2,:),temp(3,:),'color',[0 0.4470 0.7410]);
hold on
grid on
clear temp

% moving platform corner xyz coordinates
    Mplatform = Dmnq + Rm*[cos(Kappa), sin(Kappa), 0*Kappa]';
    temp = [Mplatform,Mplatform(:,1)];
    plot3(temp(1,:),temp(2,:),temp(3,:),'color',[0 0.4470 0.7410]);
    clear temp
    u = Fplatform + Lp*[cos(Kappa).*cos(theta), sin(Kappa).*cos(theta), -sin(theta)]';

% distal-to-proxmal link joint coordinates
    temp(:,:,1) = Fplatform;
    temp(:,:,2) = u;
    temp(:,:,3) = Mplatform;

    hold on
    plot3(reshape(temp(1,1,:),1,[]),reshape(temp(2,1,:),1,[]),...
        reshape(temp(3,1,:),1,[]),'color',[0 0.4470 0.7410])
    plot3(reshape(temp(1,2,:),1,[]),reshape(temp(2,2,:),1,[]),...
        reshape(temp(3,2,:),1,[]),'color',[0 0.4470 0.7410])
    plot3(reshape(temp(1,3,:),1,[]),reshape(temp(2,3,:),1,[]),...
        reshape(temp(3,3,:),1,[]),'color',[0 0.4470 0.7410])
%     xlim([-0.5 0.5]); ylim([-0.5 0.5]); zlim([-0.5 0.2])
    clear temp
    
% delta robot moving platform frame to gonio motor1 frame (fixed angle)
    gonio_d = H_d4*gencirc;
    temp = Dmnq + gonio_d(1:3,:);
    plot3(temp(1,:),temp(2,:),temp(3,:),'-','color',[0.4660 0.6740 0.1880]);
    clear temp
% motor 1 frame to motor 2 frame
    gonio_1 = H_d4*H_45*gencirc;
    temp = Dmnq + gonio_1(1:3,:);
    plot3(temp(1,:),temp(2,:),temp(3,:),'--','color',[0.4660 0.6740 0.1880]);
    clear temp
% motor 2 frame to motor 3 frame
    gonio_2 = H_d4*H_45*H_56*gencirc;
    temp = Dmnq + gonio_2(1:3,:);
    hold on
    plot3(temp(1,:),temp(2,:),temp(3,:),'.-','color',[0.4660 0.6740 0.1880]);
    clear temp
% payload / motor 3 frame to end effector (mouse) frame
    % don't want the a_4 link length included in the payload top
    H_34_custom = H_6m;
    H_34_custom(:,4) = H_56(:,4);   
    top = H_d4*H_45*H_56*H_34_custom*smallcirc;
    top = Dmnq + top(1:3,:);  % take the first 3D coordinates
    bottom = H_d4*H_45*H_56*H_6m*smallcirc;
    bottom = Dmnq + bottom(1:3,:);   
    
    pivot = H_d4*H_45*H_56*H_6m*[0;0;0;1];
    pivot = Dmnq + pivot(1:3,:);  

    hold on
    plot3(pivot(1), pivot(2),pivot(3),'-o','Color',[0.8500 0.3250 0.0980])
    

end

