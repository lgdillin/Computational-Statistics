R = runif(1e4,-1,1)
rad = runif(1e4,0,1)
X = rad - abs(R)
Y = abs(R) + rad
plot(X,Y, pch = 20, col=rgb(1,0,0,0.2))
