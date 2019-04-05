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