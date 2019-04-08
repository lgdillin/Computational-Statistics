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
a = 3
b = 3
tau.2 = 10
theta.0 = 5