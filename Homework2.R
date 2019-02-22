

### Problem 1
sin_rvgen = function(n=1000) {
  u = runif(n, max = (pi/2))
  x = sin(u)
  return(x)
}

isin_rvgen = function(n=1000) {
  u = runif(n)
  x = acos(1-u)
  return(x)
}

x = seq(0, pi/2, 0.1)
fx = sin(x)
y = isin_rvgen()
hist(y, freq = F, main = "Inverse CDF trans. of sin(x)")
lines(x, fx,  col="red")

## Part 2

arfunc = function(M) {
  while(TRUE) {
    # value between [0,1]
    u = runif(1)
    
    # value from envelope dist
    x = runif(1, min = 0, max = pi/2) 
    if(u <= sin(x) / dunif(x, min = 0, max = pi/2) * M) {
      return(x)
    }
  }
}

n = 10000
samples = rep(0,n)
for(i in 1:n) {
  samples[i] = arfunc(2/pi)
}

plot(samples)
hist(samples, freq = F, breaks = 30)
lines(seq(0, 2, 0.1), sin(seq(0, 2, 0.1)),  col="red")

### PRoblem 2
z = rgamma(1e5, shape = (1/4), rate = (1/12))
z = z^(1/4)
f = runif(1e5)
for(i in 1:1e5) {
  if(f[i] < 0.5) {
    z[i] = z[i] * -1
  }
}
hist(z, breaks = 30, freq = F, col = rgb(0.75,0.4,0.1,0.5)) # z is your sample
lambda = 1/12; alpha = 1/4
target <- function(x){exp(-lambda*x^(1/alpha))/
    integrate(function(x) exp(-lambda*x^(1/alpha)),0,Inf)$value}
curve(target,lwd=2,add=T)

#Problem 3
n = 10
x = rnorm(n*n, mean = 0, sd = 1)
m1 = matrix(data = x, nrow = n, ncol = n)
S_n = (1/n) * (t(m1) %*% m1)
ev = eigen(S_n)$values
Y = n * min(ev)

hist(rtrunc(1000, spec = 'norm', a=0, b=2), breaks = 30)

# hist(rexp(1000, rate = 0.000001), breaks = 30)
####
target = function(y) { ((1+sqrt(y)) / (2 * sqrt(y))) * exp(-1 * (y/2 + sqrt(y))) }

arfunc = function(M) {
  while(TRUE) {
    # value between [0,1]
    u = runif(1)
    
    # value from envelope dist
    x = rtrunc(1, spec = 'norm', a=0, b=2)
    if(u <= target(x) / dtrunc(x, spec = 'norm', a=0, b=2) * M) {
      return(x)
    }
  }
}

n = 10000
samples = rep(0,n)
for(i in 1:n) {
  samples[i] = arfunc(0.05)
}

plot(samples)
hist(samples, freq = F, breaks = 30)
lines(seq(0, 2, 0.1), target(seq(0, 2, 0.1)),  col="red")

N = (1/length(samples))
sum = 0
for(i in 1:length(samples)) {
  sum = sum + log(samples[i])
}


