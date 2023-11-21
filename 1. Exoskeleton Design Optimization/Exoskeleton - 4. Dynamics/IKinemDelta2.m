
% function from Yuliya Smirnova, Copyright (c) 2019
% modified for compatibility with other functions 

function [theta1, theta2, theta3, fl] = IKinemDelta2(X, Y, Z,Rm, Rf, Ld, Lp)

    Y = -Y;

    x0 = X;
    y0 = Y;
    z0 = Z;
    theta1 = IKinemTh(x0,y0,z0,Rm, Rf, Ld, Lp);
    %.......................................................
    x0 = X*cos(2*pi/3) + Y*sin(2*pi/3);
    y0 = Y*cos(2*pi/3) - X*sin(2*pi/3);
    z0 =Z;
    theta2 = IKinemTh(x0,y0,z0,Rm,Rf, Ld, Lp);
    %.......................................................
    x0 =X*cos(2*pi/3) - Y*sin(2*pi/3);
    y0 =Y*cos(2*pi/3) + X*sin(2*pi/3);
    z0 = Z;
    theta3 = IKinemTh(x0,y0,z0,Rm,Rf, Ld, Lp);
    %.......................................................
    if (~isnan(theta1) && ~isnan(theta2) && ~isnan(theta3))
        fl = 0;
    else
        fl = -1; % non-existing
    end
    
     
function [theta] = IKinemTh(x0, y0, z0,Rm, Rf, Ld, Lp)

    y1 = -Rf;
    y0 = y0-Rm; % shift center to edge
    
    a = (x0^2 + y0^2 + z0^2 + Lp^2 - Ld^2 - y1^2)/(2*z0);
    b = (y1-y0)/z0;
    % discriminant
    D = -(a + b*y1)^2 + Lp^2*(b^2+1);
    if D < 0 
        theta = nan;% non-existing     
    else  
        yj = (y1 - a*b - sqrt(D)) / (b^2 + 1); 
        zj = a + b*yj;
        theta = atan(-zj/(y1-yj));
        if (yj>y1)
            theta = theta + pi;
        end
%         theta = rad2deg(theta);
    end

