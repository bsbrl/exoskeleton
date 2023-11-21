function[cisesrrrerror,hatB,hatC,predvalues] = cisesrrr_L2tau(X,Y,Xtest,Ytest,Tau,r)
[n,q] = size(Y);
[ntest,p] = size(Xtest);
% mx = mean(X); mxx = repmat(mx,n,1); x  = X - mxx; 
% my = mean(Y); myy = repmat(my,n,1); y  = Y - myy; 
covx = X'*X;
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

%%%% call cvx 
cvx_begin quiet
       variable betai(p,r) 
       betai2 = sum(norms(betai,2,2));
       minimize(betai2);  
       subject to 
       max(norms(covxy*A-covx*betai,2,2))<=Tau; %use L2 norm instead of L1
%        norm(covxy*A-covx*betai, Inf) <= Tau;
cvx_end

betai(abs(betai)<=10^-6) = 0;
hatB = betai;
hatC = hatB*(A');
predvalues = Xtest*hatC;
cisesrrrerror = (norm(Ytest - predvalues, 'fro')^2)/(ntest*q);
end



