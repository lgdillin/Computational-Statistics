
## Code by Eric Lock, U Minnesotta. 
#Code modified from http://glau.ca/?p=227

set.seed(345687)

## Plot densities of p(x) and g(x), note why the Cauchy(0,2) doesn't stand as a good choice
## of the envelope.
setwd("C:/Users/Jyotishka/OneDrive/Documents/Course Notes/stat5443/R codes")
#pdf(file = "Rejection_Sampling_PoorEnvelope.pdf", width = 7, height=4)
plot(seq(-5, 5, 0.01), dnorm(seq(-5, 5, 0.01)),type="l",xlab="",ylab="Density",ylim=c(0,0.5))
lines(seq(-5, 5, 0.01), dcauchy(seq(-5, 5, 0.01), location=0, scale = 2), col=2)
text(0,0.45,labels="N(0,1)")
text(2.3,0.4,labels=paste("Cauchy(0,",2,")",sep=""),col=2)
#dev.off()

## Plot p(x) and modified 3*g(x). This modified density is now a good choice.
#pdf(file = "Rejection_Sampling_ProperEnvelope.pdf", width = 7, height=4)
plot(seq(-5, 5, 0.01), dnorm(seq(-5, 5, 0.01)),type="l",xlab="",ylab="Density",ylim=c(0,0.5))
lines(seq(-5, 5, 0.01), dcauchy(seq(-5, 5, 0.01), location=0, scale = 2)*3, col=2)
text(0,0.45,labels="N(0,1)")
text(2.3,0.4,labels=paste("Cauchy(0,",2,")*3",sep=""),col=2)
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
    x = rcauchy(1, location=0, scale = 2)
    # Accept or reject candidate value; if rejected try again
    if(u < dnorm(x,0,1)/M/dcauchy(x, location=0, scale = 2))
      return(x)
  }
}
N=10000
sampx  = replicate(N, rejsamp(3))
#pdf(file = "Rejection_Sampling_HistEstimate.pdf", width = 7, height=4)
hist(sampx, freq=FALSE, ylim=c(0,0.5), breaks=100, main="N(0,1) by RS",xlab="")
lines(seq(-5, 5, 0.01), dnorm(seq(-5, 5, 0.01)))
lines(seq(-5, 5, 0.01), dcauchy(seq(-5, 5, 0.01), location=0, scale = 2)*3, col=2)
text(2.3,0.4,labels="Cauchy(0,2)*3",col=2)
#dev.off()

###Try with poor envelope for illustration:
sampx  = replicate(N, rejsamp(1))
#pdf(file = "Rejection_Sampling_PoorHistEstimate.pdf", width = 7, height=4)
hist(sampx, freq=FALSE, ylim=c(0,0.5), breaks=100, main="N(0,1) by RS",xlab="")
lines(seq(-5, 5, 0.01), dnorm(seq(-5, 5, 0.01)))
lines(seq(-5, 5, 0.01), dcauchy(seq(-5, 5, 0.01), location=0, scale = 2), col=2)
text(2.3,0.4,labels="Cauchy(0,2)",col=2)
#dev.off()