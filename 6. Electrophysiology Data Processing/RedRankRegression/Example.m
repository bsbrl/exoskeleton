% There are two functions: cisesrrr and cvcisesrrr
% cvcisesrrr calls cisesrrr to do cross-validation in order to select
% the optimal tuning parameter, and returns results for the optimal tuning
% parameter
%
% Here is an example of how to run the codes


% First download cvx from:  http://cvxr.com/cvx/download/,  and add CVX path, and setup;
% Do as follows
% For windows:
addpath('\F:\Electrophysiology\cvx');
cvx_setup \F:\Electrophysiology\cvx\cvx_license.dat; % setup cvx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
% clear console and setup simulation settings
clear;
clc;
seed = 12345;
randn('seed',seed);
rand('seed',seed);
nsim = 5; % number of replications
ntest = 10000;

% Simulation Settings 
n = 30;
p = 100;
q = 1000;
r = 5;
s = 15;
rho = 0.5;
b = 1;

% model parameters - True C and sigma
sigma = eye(p,p);
for i=1:p
    for j=i:p
        sigma(i,j) = rho^(abs(i-j));
        sigma(j,i) = rho^(abs(i-j));
    end
end
mu = zeros(p,1);
BETA0 = mvnrnd(repmat(mu(1:r)', s,1), eye(r,r));
BETA1 = mvnrnd(repmat(zeros(q,1)', r,1), eye(q,q));
BETA = [b*(BETA0*BETA1);zeros(p-s,q)];

%%%%%%%%%%%%%%%%%%% Full simulation - nsim reps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fpr = zeros(nsim,1); tpr = fpr; deltafY = tpr; deltafC = deltafY; deltafXB = deltafC;
for isim=1:nsim
    %training
    X = mvnrnd(repmat(mu', n,1), sigma);
    E = mvnrnd(repmat(zeros(q,1)', n,1), eye(q,q));
    Y = X*BETA + E;
  
    % testing set
    Xtest = mvnrnd(repmat(mu',ntest,1), sigma);
    Etest = mvnrnd(repmat(zeros(q,1)',ntest,1), eye(q,q));
    Ytest = Xtest*BETA + Etest;
    
    % setup and run
    nfolds = 5;
    ngrid = 15;
    normalize = 'False';
    cisesrrrOut = cvcisesrrr(X,Y,Xtest,Ytest,nfolds,ngrid,r); % call function
    estbeta = cisesrrrOut.hatB;
    estceta = cisesrrrOut.hatC;
    tpr(isim,:) = mean(estbeta(1:s,1)~=0);
    fpr(isim,:) = mean(estbeta((s+1):p,1)~=0);
    cisesrrrError = cisesrrrOut.cisesrrrerror;
    deltafY(isim,:) = cisesrrrError;
    deltafC(isim,:) = (norm(estceta-BETA,'fro')^2)/(p*q);
    deltafXB(isim,:) = (norm(Xtest*estceta-Xtest*BETA, 'fro')^2)/(ntest*q);
    disp(isim) % track iterations
end  
   results = [deltafY,deltafC,tpr,fpr];
   [mean(results); std(results)]  % compute mean and standard deviation of the metrics
   
   toc
   
   