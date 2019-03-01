

# Problem 1
n = 74
s = 16
alpha = 2
beta = 6.4
#prior = rbeta(1, alpha, beta)
#posterior = rbinom(1e5, n, prior)
#hist(posterior, freq=F)

samples = numeric(1e5)
for(i in 1:1e5) {
  prior = rbeta(1, alpha, beta)
  samples[i] = rbinom(1, n, prior)
}
hist(samples, freq = F, breaks = 30)

n <- 5000
bp <- numeric(n)
z <- numeric(n)
for(i in 1:n) {
  z.i <- rbinom(1,1,0.5)
  if(z.i == 0) bp[i] <- rnorm(1, mean = 100, sd = 5)
  else bp[i] <- rnorm(1, mean = 140, sd = 5)
  z[i] = z.i
}
hist(bp, freq = F)
#################################

## Creat our posterior dis
n = 74
s = 16
alpha = 2
beta = 6.4
theta = rgamma(1, alpha + s, beta + n - s)
S = rbinom(1, n, theta)

# normalizing function
normalize = function(x) { return(x/sum(x)) }

#' @param x an n vector of data
#' @param pi a k vector
#' @param mu a k vector
#' @return z samples from the posterior
sample_z = function(x, pi, mu){
  dmat = outer(mu, x, "-") # produces a kxn matrix, d_kj = (mu_k - x_j)
  
  p.z.given.x = as.vector(pi) * dnorm(dmat, 0, 1)
  p.z.given.x = apply(p.z.given.x, 2, normalize) # normalize columns
  
  z = rep(0, length(x))
  for(i in 1:length(z)) {
    z[i] = sample(1:length(pi), size = 1, prob = p.z.given.x[,i], replace = T)
  }
  return(z)
}



# sample s | theta^{i-1}, n from a binomial dist.
sample_s = function(n, theta) {
  s = rbinom(1, n, theta)
  return(s)
}

# sample theta | s^{i}, alpha_0, beta_0, n from a beta dist.
sample_theta = function(alpha, beta, s, n) {
  theta = rbeta(1, alpha + s, beta + n - s)
  return(theta)
}


# Gibbs sampler
gibbs = function(x, k, niter = 1000, mu.prior = list(mean = 0, prec = 0.1)) {
  #pi = rep(1/k, k) # initialize
  #mu = rnorm(k, 0, 10)
  #z = sample_z(x, pi, mu)
  s = 16
  n = 74
  theta = s/n
  
  res = list(
    mu = matrix(nrow = niter, ncol = k), 
    pi = matrix(nrow = niter, ncol = k), 
    z = matrix(nrow = niter, ncol = length(x))
  )
  res$mu[1,] = mu
  res$pi[1,] = pi
  res$z[1,] = z
  
  for(i in 2:niter) {
    pi = sample(z, k)
    mu = sample_mu(x, z, k, mu.prior)
    z = sample_z(x, pi, mu)
    res$mu[i,] = mu
    res$pi[i,] = pi
    res$z[i,] = z
  }
  return(res)
}

# simulate data from our model
rmix = function(n, pi, mu, s) {
  z = sample(1:length(pi), prob = pi, size = n, replace = T)
  x = rnorm(n, mu[z], s[z])
  return(x)
}

### Run
# params mu_1=-2, mu_2=2, sig_1=sig_2=1
x = rmix(n=1000,pi=c(0.5,0.5),mu=c(-2,2),s=c(1,1))
hist(x)
res = gibbs(x,2)
plot(res$mu[,1],ylim=c(-4,4),type="l")
lines(res$mu[,2],col=2)

####
gibbs2 = function(x, k, niter = 1000, mu.prior = list(mean = 0, prec = 0.1))



