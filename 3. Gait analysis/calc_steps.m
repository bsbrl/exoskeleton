function [Mousedat] = calc_steps(Mousedat,confthresh)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% extract variables
time = Mousedat.time;
Nose = Mousedat.Nose;
Lear = Mousedat.Lear;
Back = Mousedat.Back;
Tail = Mousedat.Tail;
Lhind = Mousedat.Lhind;
Lfore = Mousedat.Lfore;

% filter using confidence
temp = Nose(:,3);                   % nose confidence
[I1,~] = find(temp<confthresh);     % find low conf values

temp = Tail(:,3);                   % tailbase confidence
[I2,~] = find(temp<confthresh);     % find low conf values

I = [I1;I2];

Nose(I,:) = 0;
Lear(I,:) = 0;
Back(I,:) = 0;
Tail(I,:) = 0;
Lhind(I,:) = 0;
Lfore(I,:) = 0;

% binary matrix indicating mouse in frame
Inframe = ones(size(Nose(:,1)));
Inframe(I,:) = 0;

% extend data to avoid edge artefacts
k = 1; 
extend = 5;
for n = extend+1:length(Inframe)-extend
    if Inframe(n,1) == 1 &&  Inframe(n-1) == 0  % mouse entering frame
        addpoints = [n-extend:1:n-1]';
        Nose(addpoints,[1,2]) = repmat(Nose(n,[1,2]),extend,1);
        Lear(addpoints,[1,2]) = repmat(Lear(n,[1,2]),extend,1);
        Back(addpoints,[1,2]) = repmat(Back(n,[1,2]),extend,1);
        Tail(addpoints,[1,2]) = repmat(Tail(n,[1,2]),extend,1);
        Lhind(addpoints,[1,2]) = repmat(Lhind(n,[1,2]),extend,1);
        Lfore(addpoints,[1,2]) = repmat(Lfore(n,[1,2]),extend,1);
        Marker(k,1) = n;
    elseif Inframe(n,1) == 0 &&  Inframe(n-1) == 1  % mouse exiting frame
        addpoints = [n:1:n+extend-1]';
        Nose(addpoints,[1,2]) = repmat(Nose(n-1,[1,2]),extend,1);
        Lear(addpoints,[1,2]) = repmat(Lear(n-1,[1,2]),extend,1);
        Back(addpoints,[1,2]) = repmat(Back(n-1,[1,2]),extend,1);
        Tail(addpoints,[1,2]) = repmat(Tail(n-1,[1,2]),extend,1);
        Lhind(addpoints,[1,2]) = repmat(Lhind(n-1,[1,2]),extend,1);
        Lfore(addpoints,[1,2]) = repmat(Lfore(n-1,[1,2]),extend,1);
        Marker(k,2) = n; 
        k = k+1;
    end
end

% convert pixels to metres
scale = 0.260/500; % m/pixel 

Nose(:,[1,2]) = Nose(:,[1,2]).*scale;
Lear(:,[1,2]) = Lear(:,[1,2]).*scale;
Back(:,[1,2]) = Back(:,[1,2]).*scale;
Tail(:,[1,2]) = Tail(:,[1,2]).*scale;
Lhind(:,[1,2]) = Lhind(:,[1,2]).*scale;
Lfore(:,[1,2]) = Lfore(:,[1,2]).*scale;

% X velocity
tincr = time(2,1) - time(1,1);
Meanpos = mean([Nose(:,1),Lear(:,1)],2); 
Meanpos = [Lear(:,1)]; 
Xvel = -[0;diff(Meanpos)]./tincr;   % (m/s)

% remove artefacts at start and end of laps
Xvel(Xvel>1) = 0; 
Xvel(Xvel<-1) = 0;

% smooth velocity using medfilt to reduce jitter artefacts
for n = 1:size(Marker,1)
    temp = Marker(n,:);
    dat = Xvel(temp(1)-extend+1:temp(2)+extend-1,1);
    datfilt = medfilt1(dat,5);
    datfilt = medfilt1(datfilt,5);
    datfilt = medfilt1(datfilt,5);
    Xvel(temp(1)-extend+1:temp(2)+extend-1,1) = datfilt;
end

% Hind paw velocity
Lhvel = -[0;diff(Lhind(:,1),1)]./tincr;   % (m/s)
% remove artefacts at start and end of laps
Lhvel(Lhvel>5) = 0; 
Lhvel(Lhvel<-5) = 0;
% remove jitter at stationary points
Lhvel(Lhvel<0.005) = 0;

% make points with very short stance duration become sttaionary 
Lhaccel = [0;Lhvel(2:end)-Lhvel(1:end-1);0];
for n = 2:length(Lhaccel)
    if Lhaccel(n,1) > 0 && Lhaccel(n-1,1) < 0
        Lhvel(n,1) = 0;
    end
end

% remove data with only 1 point of motion
for n = 2:size(Lhvel,1)-1
    if Lhvel(n-1,1) == 0 &&  Lhvel(n,1) > 0 &&  Lhvel(n+1,1) == 0
        Lhvel(n,1) = 0;
    end
end

% Forepaw velocity
Lfvel = -[0;diff(Lfore(:,1),1)]./tincr;   % (m/s)
% remove artefacts at start and end of laps
Lfvel(Lfvel>5) = 0; 
Lfvel(Lfvel<-5) = 0;
% remove jitter at stationary points a
Lfvel(Lfvel<0.005) = 0;

% make points with very short stance duration become sttaionary 
Lfaccel = [0;Lhvel(2:end)-Lfvel(1:end-1)];
for n = 2:length(Lfaccel)
    if Lfaccel(n,1) > 0 && Lfaccel(n-1,1) < 0
        Lfvel(n,1) = 0;
    end
end

% remove data with only 1 point of motion (artefacts)
for n = 2:size(Lfvel,1)-1
    if Lfvel(n-1,1) == 0 &&  Lfvel(n,1) > 0 &&  Lfvel(n+1,1) == 0
        Lfvel(n,1) = 0;
    end
end

% Single out individual steps
p = 1;
m = 1;
for n = 2:length(Lfvel)-1
    if Lfvel(n,1) == 0 && Lfvel(n+1,1) > 0      % step start
        Fsteps(p,1) = time(n,1);
        Fsteps(p,3) = Lfore(n,1);
        Fsteps(p,7) = m;
        Fsteps(p,10) = n;
    elseif Lfvel(n,1) == 0 && Lfvel(n-1,1) > 0      % step end
        Fsteps(p,2) = time(n,1);
        Fsteps(p,4) = Lfore(n,1);
        Fsteps(p,11) = n;
        p = p+1;
    end
    if Inframe(n,1) == 1 && Inframe(n+1,1) == 0
        m = m+1;
    end  
end

p = 1;
m = 1;
for n = 2:length(Lfvel)-1
    if Lhvel(n,1) == 0 && Lhvel(n+1,1) > 0      % step start
        Hsteps(p,1) = time(n,1);
        Hsteps(p,3) = Lhind(n,1);
        Hsteps(p,7) = m;
        Hsteps(p,10) = n;
    elseif Lhvel(n,1) == 0 && Lhvel(n-1,1) > 0      % step end
        Hsteps(p,2) = time(n,1);
        Hsteps(p,4) = Lhind(n,1);
        Hsteps(p,11) = n;
        p = p+1;
    end
    if Inframe(n,1) == 1 && Inframe(n+1,1) == 0
        m = m+1;
    end      
end

% step length
Fsteps(:,5) = -(Fsteps(:,4) - Fsteps(:,3));
Hsteps(:,5) = -(Hsteps(:,4) - Hsteps(:,3));

% step vel
Fsteps(:,6) = Fsteps(:,5)./(Fsteps(:,2)- Fsteps(:,1));
Hsteps(:,6) = Hsteps(:,5)./(Hsteps(:,2)- Hsteps(:,1));

% remove artefacts (steps < 1 cm or > 10 cm); where mouse steps are 
% typically 2 to 7 cm (DOI:10.1038/s41598-017-03336-1)
for n = size(Fsteps,1):-1:1
    if Fsteps(n,5) < 0.01
        Fsteps(n,:) = [];
    elseif Fsteps(n,5) > 0.10
        Fsteps(n,:) = [];
    end
end

for n = size(Hsteps,1):-1:1
    if Hsteps(n,5) < 0.01
        Hsteps(n,:) = [];
    elseif Hsteps(n,5) > 0.10
        Hsteps(n,:) = [];
    end
end

% average velocity during each step
% Fpaw
for n = 1:size(Fsteps,1)
    Fsteps(n,12) = mean(Xvel(Fsteps(n,10):Fsteps(n,11),1));
end
% Hpaw
for n = 1:size(Hsteps,1)
    Hsteps(n,12) = mean(Xvel(Hsteps(n,10):Hsteps(n,11),1));
end
     
% Fpaw cadence
T = unique(Fsteps(:,7));

for n = 1:length(T)
    [M,~] = find(Fsteps(:,7) == T(n,1));
    for m = 1:size(M,1)-1
        step = M(m,1);
        Fsteps(step,8) = 1/(Fsteps(step+1,1) - Fsteps(step,1)); % step start to step start

    end
end
    
% Hpaw cadence
T = unique(Hsteps(:,7));

for n = 1:length(T)
    [M,~] = find(Hsteps(:,7) == T(n,1));
    for m = 1:size(M,1)-1
        step = M(m,1);
        Hsteps(step,8) = 1/(Hsteps(step+1,1) - Hsteps(step,1)); % step start to step start
    end
end
    
Mousedat.Fpaw = Fsteps;
Mousedat.Hpaw = Hsteps;


end

