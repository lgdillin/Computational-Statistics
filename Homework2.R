

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

arfunc = function(n=1000) {
  m = 1
  a = 0
  rv = rep(0,n)
  
  for(i in 1:n) {
    x = runif(1)
    if(x < sin(x)) {
      rv[i] = x
      a = a + 1
    }
  }
  cat("Efficiency is ", a/n)  
  plot(rv)
  title("accept reject plot")
}
arfunc()

x = seq(0, pi/2, 0.1)
fx = sin(x)
y = isin_rvgen()
hist(y, freq = F, main = "Inverse CDF trans. of sin(x)")
lines(x, fx,  col="red")