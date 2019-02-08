
rm(list=ls())
mergearrays <- function(x,y){
  m = length(x)
  n = length(y)
  if(m==0){
    return(z = y)
    }
  if(n==0){
    return(z = x)
  }
  if (x[1]<=y[1]){
    return(z = c(x[1],mergearrays(x[-1],y)))
  }else{
    return(z = c(y[1],mergearrays(x,y[-1])))
  }
}

x = c(1,2,3)
y = c(2.5,3.5,4.5)
mergearrays(x,y)

mergesort <- function(x){
  n = length(x)
  mid = floor(n/2)
  if(n > 1){
    return(mergearrays(mergesort(x[1:mid]),mergesort(x[(mid+1):n])))
  }else{
    return(x)
  }
}
x = c(1,3,4,5,7,2)
mergesort(x)

## Time complexity

mergesort.time = rep(0,500);

for(i in 1:length(mergesort.time)){
  #obtain the cpu time from the i-th random sample
  #and save the results as, say, t1 and t2
  y =  runif(1000) #generated sample of size 100
  ptm <- proc.time()
  mergesort(y) #sorting algorithm 1
  t1 = proc.time()-ptm
  mergesort.time[i]=t1[["elapsed"]]
  
}

summary(mergesort.time)

## Implement Bubble Sort. 
## Compare Bubble Sort with Merge-sort for the same arrays of random numbers. 
