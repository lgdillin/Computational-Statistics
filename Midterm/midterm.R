# Problem 1
R = runif(3e3,-1,1)
rad = runif(3e3,0,1)
X = rad - abs(R)
Y = abs(R) + rad
plot(X,Y, pch = 20, col=rgb(1,0,0,0.2))

arfunction = function() {
  while(TRUE) {
    x = runif(1,min = -1,max = 1)
    y = runif(1,min = -1, max = 1)
    if (abs(x) + abs(y) <= 1){
      rv = c(x, y)
      return(rv)
    }
  }
}
samples = matrix(nrow = 3000, ncol = 2)
for(i in 1:3000) {
  x = arfunction()
  samples[i,1] = x[1]
  samples[i,2] = x[2]
}
plot(samples[,1],samples[,2])

# Problem 2
if(!require(rigamma)){
  install.packages("rigamma", dependencies = TRUE, repos = 'http://cran.rstudio.com')
}

x = c(91, 504, 557, 609, 693, 727, 764, 803, 857, 929, 970, 1043, 1089, 1195, 1384, 1713)
n = length(x)
a = 3
b = 3
tau2 = 10
theta0 = 5

theta_mu = function(sig2) {
  mu1 = (sig2 * theta0) / (sig2 + n * tau2)
  mu2 = (n * tau2 * mean(x)) / (sig2 + n * tau2)
  return(mu1 + mu2)
}

theta_sig = function(sig2) {
  sig = (sig2 * tau2) / (sig2 + n * tau2)
  return(sig)
}

gibbs <- function(burn = 1000, nmc = 2000){
  
  theta <- rep(0, nmc+burn)
  sigma2 <- rep(0, nmc+burn)
  
  sigma2[1] = rinvgamma(1, (n/2) + a, 0.5 * sum((x - theta0)^(2)) + b)
  theta[1] = theta0; 
  
  for (i in 2:(burn+nmc)) {
    
    sigma2[i] <- rinvgamma(1, (n/2) + a, theta[i-1])
    theta[i] <- rnorm(1, theta_mu(sigma2[i]), theta_sig(sigma2[i]))
  }
  return(list(sigma2=sigma2,theta=theta))
}

mcmc.fit <- gibbs()
hist(log(mcmc.fit$sigma2[1001:2000]), breaks = 30, main="s(i) samples histogram", freq = F)
hist(log(mcmc.fit$theta[1001:2000]), breaks = 30, main="s(i) samples histogram", freq = F)
