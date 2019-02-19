

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
    x = runif(1) 
    if(u <= sin(x) / dunif(x) * M) {
      return(x)
    }
  }
}

n = 1000
samples = rep(0,n)
for(i in 1:n) {
  samples[i] = arfunc(1)
}

plot(samples)
hist(samples, freq = F, breaks = 30)
lines(seq(0, 2, 0.1), sin(seq(0, 2, 0.1)),  col="red")


