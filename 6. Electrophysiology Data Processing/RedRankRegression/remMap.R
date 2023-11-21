library(MASS)
library(remMap)


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
    
    #### create coefficient matrix A
    b0 = matrix( rnorm(s*r,mean=0,sd=1),nrow = s,ncol = r)
    b1 = matrix(rnorm(r*q,mean=0,sd=1),nrow = r,ncol = q)
    a1 = b*b0 %*% b1
    A = rbind(a1,matrix(0,nrow = p-s,ncol = q))
    
    ### simulation output initialize
    Y_remMap=c()
    XA_remMap=c()
    A_remMap=c()
    TPRs=c()
    FPRs=c()
    
    #######################
    for (i in 1:rep) 
    {
      # generate x and y
      x = mvrnorm(n,rep(0,p),Sigma = Covmatrix)
      y = x%*%A + matrix(rnorm(n*q,mean=0,sd=1),nrow=n,ncol=q)
      #y = x%*%A + sqrt(3/5)*matrix(rt(n*q,df=5),nrow=n,ncol=q)
      #y = x%*%A + matrix(runif(n*q,min=-1,max=1),nrow=n,ncol=q)+matrix(runif(n*q,min=-1,max=1),nrow=n,ncol=q)+matrix(runif(n*q,min=-1,max=1),nrow=n,ncol=q)
      
      
      #### create training and test set
      train_index = 1:samples
      test_index = setdiff(1:nrow(x),train_index)
      x_train = x[train_index,]
      y_train = y[train_index,]
      x_test = x[test_index,]
      y_test = y[test_index,]
      
      # fit remMap.CV
      lamL1.v = exp(seq(log(1.5),log(50), length=5))
      lamL2.v = seq(0,5,length=5)
      cv.fit = remMap.CV(X = x_train, Y = y_train,lamL1.v, lamL2.v, C.m=NULL, fold=5, seed = 12345)
      pick = which.min(as.vector(cv.fit$ols.cv))
      lamL1.pick = cv.fit$l.index[1,pick] 
      lamL2.pick = cv.fit$l.index[2,pick]
      result = remMap(x_train, y_train, lamL1=lamL1.pick, lamL2=lamL2.pick, phi0=NULL, C.m=NULL)
      

      ### pred y remMap
      Abar = result$phi
      if(n>p) Abar[Abar< 1e-6] = 0
      pred_y = x_test%*%Abar
      XA = x_test%*%A
      
      #### store result for each simulation
      Y_remMap[i] = mean((y_test-pred_y)^2)
      XA_remMap[i] = mean((XA-pred_y)^2)
      A_remMap[i] = mean((A-Abar)^2)
      TPRs[i] = mean(Abar[1:s,1]!=0)
      FPRs[i] = mean(Abar[(s+1):p,1]!=0)
    }
    results = cbind(Y_remMap,XA_remMap,A_remMap,TPRs,FPRs)
    output = rbind(output,results)
  }
}

output


### show the result 
rbind(apply(output[1:50,],2,mean),apply(output[1:50,],2,sd))
rbind(apply(output[51:100,],2,mean),apply(output[51:100,],2,sd))
rbind(apply(output[101:150,],2,mean),apply(output[101:150,],2,sd))
rbind(apply(output[151:200,],2,mean),apply(output[151:200,],2,sd))


write.csv(output, file = "C:/Users/hhilafu/Dropbox/papers/CISE Reduced-Rank/Simulations/remMap_t_n_30_p_100_q_1000.csv")
write.csv(output, file = "/Users/haileabhilafu/Dropbox/papers/CISE Reduced-Rank/Simulations/remMap_normal_n_30_p_100_q_1000.csv")



