function [X, Y, Z, fl] = FKinemDelta(theta1, theta2, theta3,Rf,Rm,Lp,Ld)
        
% function from Yuliya Smirnova, Copyright (c) 2019
% modified for compatibility with other functions 


    t = Rf-Rm;
    
    y1 = -(t + Lp*cos(theta1));
    z1 = - Lp * sin(theta1);
    
    y2 = (t + Lp*cos(theta2)) * sin(pi/6);
    x2 = y2 * tan(pi/3);
    z2 = -Lp * sin(theta2);
    
    y3 = (t + Lp*cos(theta3)) * sin(pi/6);
    x3 = -y3 * tan(pi/3);
    z3 = -Lp * sin(theta3);
    
    w1 = y1^2 + z1^2;
    w2 = x2^2 + y2^2 + z2^2;
    w3 = x3^2 + y3^2 + z3^2;
    
    dnm = (y2-y1)*x3 - (y3-y1)*x2;
    % x = (a1*z + b1)/dnm
    a1 = (z2-z1)*(y3-y1) - (z3-z1)*(y2-y1);
    b1= -( (w2-w1)*(y3-y1) - (w3-w1)*(y2-y1) ) / 2;
    % y = (a2*z + b2)/dnm
    a2 = -(z2-z1)*x3 + (z3-z1)*x2;
    b2 = ( (w2-w1)*x3 - (w3-w1)*x2) / 2;
    % a*z^2 + b*z + c = 0
    a = a1^2 + a2^2 + dnm^2;
    b = 2 * (a1*b1 + a2*(b2 - y1*dnm) - z1*dnm^2);
    c = (b2 - y1*dnm)*(b2 - y1*dnm) + b1^2 + dnm^2*(z1^2 - Ld^2);
    
    % discriminant
    d = b*b - 4*a*c;
    if d >= 0
        Z = -0.5*(b + sqrt(d)) / a;
        X = (a1*Z + b1) / dnm;
        Y = (a2*Z + b2) / dnm;
%         if abs(X) > 1000 || abs(Y) > 1000 ||  Z > 0 || Z < -1000
%             fl = -1;% error
%         else
             fl = 0;
%         end
    else
        X = nan;
        Y = nan;
        Z = nan;
        fl = -1;% non-existing 
    end
    
    Y = -Y;
    
end