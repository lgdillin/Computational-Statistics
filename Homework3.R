######### PRoblem 1
#' @param n number of vehicles
#' @param s number of bicycles
#' @param theta proportion of bicycle traffic
n <- 70
s_init <- 16
theta_init <- s_init/n
burn = 1000 # burn-in
nmc = 1000 # number of Monte Carlo iterations

gibbs <- function(s_init, theta_init, burn = 1000, nmc = 2000, alpha_0 = 2.0, beta_0 = 6.4){
  
  theta <- rep(0, nmc+burn)
  s <- rep(0, nmc+burn)
  
  s[1] = s_init; theta[1] = theta_init; 
  
  for (i in 2:(burn+nmc)) {
    
    s[i] <- rbinom(1, n, theta[i-1])
    theta[i] <- rbeta(1, alpha_0 + s[i], beta_0 + n-s[i])
  }
  return(list(s=s,theta=theta))
}

mcmc.fit <- gibbs(s_init, theta_init)

plot(mcmc.fit$theta[1001:2000], type = "l", main="theta(i) samples")
plot(mcmc.fit$s[1001:2000], type = "l", main="s(i) samples")
hist(mcmc.fit$s[1001:2000], breaks = 30, main="s(i) samples histogram", freq = F)
acf(mcmc.fit$theta[1001:2000])
mean(mcmc.fit$theta[1001:2000])
median(mcmc.fit$theta[1001:3000])

####################################
####################################
####################################
##### PRoblem 2
lambda = 64
n_init = 78
s_init <- 16
theta_init <- s_init/n_init
burn = 1000 # burn-in
nmc = 1000 # number of Monte Carlo iterations

gibbs <- function(s_init, theta_init, n_init, burn = 1000, nmc = 3000, alpha_0 = 2.0, beta_0 = 6.4){
  
  n = rep(0, nmc+burn)
  theta <- rep(0, nmc+burn)
  s <- rep(0, nmc+burn)
  
  s[1] = s_init; theta[1] = theta_init; n[1] = n_init;
  
  for (i in 2:(burn+nmc)) {
    n[i] = rpois(1, lambda * (1-theta[i-1]))
    s[i] <- rbinom(1, n[i], theta[i-1])
    theta[i] <- rbeta(1, alpha_0 + s[i], beta_0 + n[i]-s[i])
  }
  return(list(s=s,theta=theta,n=n))
}

mcmc.fit <- gibbs(s_init, theta_init, n_init)

plot(mcmc.fit$theta[1001:2000], type = "l")
plot(mcmc.fit$s[1001:2000], type = "l")
plot(mcmc.fit$n[1001:2000], type = "l")
acf(mcmc.fit$theta[1001:2000])
mean(mcmc.fit$theta[1001:2000])
median(mcmc.fit$theta[1001:4000])
hist(mcmc.fit$s[1001:4000], breaks = 30, main="s(i) samples histogram", freq = F)
