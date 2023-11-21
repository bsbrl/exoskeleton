library(MASS)
library(spls)

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
    b0 = matrix(rnorm(s*r,mean=0,sd=1),nrow = s,ncol = r)
    b1 = matrix(rnorm(r*q,mean=0,sd=1),nrow = r,ncol = q)
    a1 = b*b0 %*% b1
    A = rbind(a1,matrix(0,nrow = p-s,ncol = q))
    
    ### simulation output initialize
    Y_spls=c()
    XA_spls=c()
    A_spls=c()
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
      cv.fit = cv.spls(x=x_train,y=y_train,fold=5,K=c(1:10), 
                    eta = seq(0.1,0.9,0.1),scale.x=FALSE,plot.it=FALSE)
      fit = spls(x=x_train,y=y_train,K=cv.fit$K.opt, eta=cv.fit$eta.opt, 
                 kappa=0.5,select="pls2",fit="simpls",scale.x=FALSE)

      
      ### pred y remMap
      Abar = coef(fit)
      Abar[Abar < 1e-6] = 0
      pred_y = predict(fit,newx=x_test,type="fit")
      XA = x_test%*%A
      
      #### store result for each simulation
      Y_spls[i] = mean((y_test-pred_y)^2)
      XA_spls[i] = mean((XA-pred_y)^2)
      A_spls[i] = mean((A-Abar)^2)
      TPRs[i] = mean(apply(Abar[1:s,]!=0,1,max))
      FPRs[i] = mean(apply(Abar[(s+1):p,]!=0,1,max))
    }
    results = cbind(Y_spls,XA_spls,A_spls,TPRs,FPRs)
    output = rbind(output,results)
  }
}

output


### show the result 
rbind(apply(output[1:50,],2,mean),apply(output[1:50,],2,sd))
rbind(apply(output[51:100,],2,mean),apply(output[51:100,],2,sd))
rbind(apply(output[101:150,],2,mean),apply(output[101:150,],2,sd))
rbind(apply(output[151:200,],2,mean),apply(output[151:200,],2,sd))


write.csv(output, file = "C:/Users/hhilafu/Dropbox/papers/CISE Reduced-Rank/Simulations/SPLS_t_n_100_p_25_q_25.csv")
write.csv(output, file = "/Users/haileabhilafu/Dropbox/papers/CISE Reduced-Rank/Simulations/SPLS_normal_n_30_p_100_q_1000.csv")



