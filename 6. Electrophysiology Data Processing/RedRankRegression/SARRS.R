library(MASS)
library(gglasso)

##### Set case:
set.seed(12345)
rep = 50
samples = 30
n = 10000+samples
p = 100
q = 1000
s = 15
r = 5


rhooo = c(0.1,0.5)
boo = c(0.2,0.4)
if (samples < p) boo = c(0.5,1)
output = NULL

for(rhoo in 1:2)
{
rho = rhooo[rhoo]

####### Create the predictor covariance matrix
fun = function(i,j) rho^(abs(i-j))
rows = 1:p
cols = 1:p
Covmatrix = outer(rows,cols,FUN=fun)

  ##################
  for(bo in 1:2)
  {
  b = boo[bo]  
  
  #### create coefficient matrix A and X
  b0 = matrix( rnorm(s*r,mean=0,sd=1),nrow = s,ncol = r)
  b1 = matrix(rnorm(r*q,mean=0,sd=1),nrow=r,ncol = q)
  a1 = b*b0 %*% b1
  A = rbind(a1,matrix(0,nrow = p-s,ncol = q))
  
    ### simulation output initialize
    Y_ssr=c()
    XA_ssr=c()
    A_ssr=c()
    TPRs=c()
    FPRs=c()
    
    #######################
    for (i in 1:rep) 
    {
    # generate x and y
    x = mvrnorm(n,rep(0,p),Sigma = Covmatrix)
    y = x%*%A + matrix(rnorm(n*q,mean=0,sd=1),nrow=n,ncol=q)
    #y = x%*%A+ sqrt(3/5)*matrix(rt(n*q,df=5),nrow=n,ncol=q)
    #y = x%*%A + matrix(runif(n*q,min=-1,max=1),nrow=n,ncol=q)+matrix(runif(n*q,min=-1,max=1),nrow=n,ncol=q)+matrix(runif(n*q,min=-1,max=1),nrow=n,ncol=q)
    
    #### create training and test set
    train_index = 1:samples
    test_index = setdiff(1:nrow(x),train_index)
    x_train = x[train_index,]
    y_train = y[train_index,]
    x_test = x[test_index,]
    y_test = as.vector(y[test_index,])
    
    
    ### create initial V(0)
    V_0 = svd(y_train,nu=r,nv=r)$v
    #sss = svd(A,nv=r)
    #V_0 = sss$v
    
    #### group penalized regression.
    ybar = as.vector(y_train%*%V_0)
    xbar = kronecker(diag(1,r),x_train)
    group = rep(1:p,r)
    
    cv.fit = cv.gglasso(xbar,ybar,group = group,pred.loss = "L2",nfolds = 5)
    lambda = cv.fit$lambda.1se
    fit = gglasso(xbar,ybar,group = group,lambda = lambda)
    
   
    ### pred y ssr
    B_1 = matrix(fit$beta,p,r,byrow = FALSE)
    Abar = B_1%*%t(V_0)
    # thresholding step
    if(n>p) Abar[Abar< 1e-6] = 0
    pred_y = x_test%*%Abar
    XA = x_test%*%A
    
    
    #### store result for each simulation
    Y_ssr[i] = mean((y_test-pred_y)^2)
    XA_ssr[i] = mean((XA-pred_y)^2)
    A_ssr[i] = mean((A-Abar)^2)
    TPRs[i] = mean(Abar[1:s,1]!=0)
    FPRs[i] = mean(Abar[(s+1):p,1]!=0)
    }
    results = cbind(Y_ssr,XA_ssr,A_ssr,TPRs,FPRs)
    output = rbind(output,results)
  }
}
output

### show the result 
rbind(apply(output[1:50,],2,mean),apply(output[1:50,],2,sd))
rbind(apply(output[51:100,],2,mean),apply(output[51:100,],2,sd))
rbind(apply(output[101:150,],2,mean),apply(output[101:150,],2,sd))
rbind(apply(output[151:200,],2,mean),apply(output[151:200,],2,sd))


write.csv(output, file = "C:/Users/hhilafu/Dropbox/papers/CISE Reduced-Rank/Simulations/SARRS_U_n_30_p_100_q_1000.csv")
write.csv(output, file = "/Users/haileabhilafu/Dropbox/papers/CISE Reduced-Rank/Simulations/SARRS_normal_n_30_p_100_q_1000.csv")




