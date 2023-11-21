function cisesrrrOut = cvcisesrrr_V3(X,Y,Xtest,Ytest,nfolds,ngrid,r)
[n,p] = size(X);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Get the taurange %%%%%%%%%%%%%%%%%%%%%%%
% mx = mean(X); mxx = repmat(mx,n,1); x  = X - mxx; 
% my = mean(Y); myy = repmat(my,n,1); y  = Y - myy; 
covxy = X'*Y;
% if(n < p)
%     [U, D, V] = svd(X, 'econ');
%     lambda = sqrt(log(p)/n);
%     [sortD,idx] = sort(real(diag(D)),'descend');
%     U = real(U(:,idx'));
%     U = U(:,1:n);
%     D = real(diag(sortD));
%     D = D(1:n,1:n);
%     R = U*D;
%     covR = R'*R+lambda*eye(n);
%     beta = V*(inv(covR))*R'*Y;
% else
%     beta = (inv(covx))*covxy;
% end
[~,~,V] = svd(Y,'econ');
A = V(:,1:r);
upbound = max(norms(covxy*A,2,2));
if n < p 
    upbound = upbound;
end
lambdamin = 0.000001*log(size(X,1))/size(X,2)*upbound; % changed to sqrt for more sparsity
% lambdamin = log(size(X,1))/size(X,2)*upbound; % changed to sqrt for more sparsity
lambdamax = upbound;
taurange = 10.^linspace(log(lambdamin)/log(10), log(lambdamax)/log(10), ngrid+1);
taurange = taurange(1,1:ngrid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% perform CV%%%%%%%%%%
% perform 5 fold cross validation of training data;
 foldid3 = randsample([repmat(1:nfolds,1,floor(n/nfolds)) 1:mod(n,nfolds)],n);
 ErrTau=[];
for itau=1:size(taurange,2);   
     tau=taurange(:,itau);   
     for f=1:nfolds
         which=foldid3==f;
         [cisesrrrerror,~,~,~] = cisesrrr(X(~which,:),Y(~which,:),X(which,:),Y(which,:),tau,r);
         ErrTau = [ErrTau;[f tau' cisesrrrerror]];
     end
end        
 
 %choose tau that gives smallest average error; if there are many tau, choose the last (largest)
 Errtau = [taurange' grpstats(ErrTau(:,3), ErrTau(:,2))];   
 [row,~] = find(Errtau(:,2)==min(Errtau(:,2)),1,'last');
 tauopt = (Errtau(row,1))';
 
 % Apply on testing data;
[cisesrrrerror,hatB,hatC,predvalues] = cisesrrr(X,Y,Xtest,Ytest,tauopt,r);
 
% Output results
cisesrrrOut.cisesrrrerror = cisesrrrerror;
cisesrrrOut.hatB = hatB;
cisesrrrOut.hatC = hatC;
cisesrrrOut.predvalues = predvalues;
cisesrrrOut.tauopt = tauopt;
cisesrrrOut.taurange = taurange;
