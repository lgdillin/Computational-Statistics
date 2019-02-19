set.seed(345687)

library(smoothmest)

## Plot densities of p(x) and g(x), note why the Cauchy(0,2) doesn't stand as a good choice
## of the envelope.
setwd("C:/Users/Jyotishka/OneDrive/Documents/Course Notes/stat5443/R codes")
#pdf(file = "Rejection_Sampling_PoorEnvelope2.pdf", width = 7, height=4)
plot(seq(-5, 5, 0.01), dnorm(seq(-5, 5, 0.01)),type="l",xlab="",ylab="Density",ylim=c(0,0.5))
lines(seq(-5, 5, 0.01), ddoublex(seq(-5, 5, 0.01), mu=0, lambda = 1), col=2)
text(-2,0.2,labels="N(0,1)")
text(1.3,0.4,labels=paste("Laplace(0,",1,")",sep=""),col=2)
#dev.off()

## Plot p(x) and modified sqrt(pi/2e)*g(x). This modified density is now a good choice.
M = sqrt((2*exp(1))/pi)
#pdf(file = "Rejection_Sampling_ProperEnvelope2.pdf", width = 7, height=4)
plot(seq(-5, 5, 0.01), dnorm(seq(-5, 5, 0.01)),type="l",xlab="",ylab="Density",ylim=c(0,0.8))
lines(seq(-5, 5, 0.01), ddoublex(seq(-5, 5, 0.01), mu=0, lambda = 1)*M, col=2)
text(-2,0.2,labels="N(0,1)")
text(2.5,0.4,labels=paste("Laplace(0,",1,")*sqrt(2e/pi)",sep=""),col=2)
#dev.off()
## With this envelope, we now proceed to rejection sampling. First, a random value
## (say u) between zero and one is drawn uniform [U(0,1)]. Next, a random value
## for x is drawn from the enveloping distribution g(x). Finally, the acceptance/rejection
## step accepts x as having been drawn from p(x) if u is less than the density of p(x)
## at x divided by the density of g(x)*M. If not, we continue the sampling for x from g(x)
# Rejection sampler for multiplication constant M
rejsamp = function(M){
  while(1){
    # Draw single value from between zero and one
    u = runif(1)
    # Draw candidate value for x from the enveloping distribution
    x = rdoublex(1, mu=0, lambda = 1)
    # Accept or reject candidate value; if rejected try again
    if(u < dnorm(x,0,1)/M/ddoublex(x, mu=0, lambda = 1))
      return(x)
  }
}
N=10000
M = sqrt(2*exp(1)/pi)
sampx  = replicate(N, rejsamp(M))
#pdf(file = "Rejection_Sampling_HistEstimate2.pdf", width = 7, height=4)
hist(sampx, freq=FALSE, ylim=c(0,0.8), breaks=100, main="N(0,1) by RS",xlab="")
lines(seq(-5, 5, 0.01), dnorm(seq(-5, 5, 0.01)))
lines(seq(-5, 5, 0.01), ddoublex(seq(-5, 5, 0.01), mu=0, lambda = 1)*M, col=2)
text(2.5,0.4,labels=paste("Laplace(0,",1,")*sqrt(2e/pi)",sep=""),col=2)
#dev.off()

###Try with poor envelope for illustration:

sampx  = replicate(N, rejsamp(1))
#pdf(file = "Rejection_Sampling_PoorHistEstimate2.pdf", width = 7, height=4)
hist(sampx, freq=FALSE, ylim=c(0,0.8), breaks=100, main="N(0,1) by RS",xlab="")
lines(seq(-5, 5, 0.01), dnorm(seq(-5, 5, 0.01)))
lines(seq(-5, 5, 0.01), ddoublex(seq(-5, 5, 0.01), mu=0, lambda = 1)*M, col=2)
text(1.3,0.4,labels=paste("Laplace(0,",1,")",sep=""),col=2)
#dev.off()