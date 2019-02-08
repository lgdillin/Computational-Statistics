# Liam Dillingham


### Problem 1:
x = c(9,10,11,12,13,14,15,16)

# Print last 3 elements
x[(length(x)-2):length(x)]

# Print only even elements
x[lapply(x, "%%", 2) == 0]

# Remove the even elements, and print the array
x = x[!x %in% x[lapply(x, "%%", 2) == 0]]
x

### Problem 2:
func = function(n, mode) {
  
  result = 0
  if(mode == 1) {
    for(i in 1:n) {
      result = result + 0.5 ^ i
    }
    return(result)
  } else if(mode == 2) {
    i = 1
    while(i <= n) {
      result = result + 0.5 ^ i
      i = i + 1
    }
    return(result)
  } else {
    result = 1 - (0.5 ^ n)
    return(result)
  }
}

func(2, 2)

### Problem 3:
# No code

### Problem 4:

# Bubble sort
bubblesort = function(x) {
  n = length(x)
  swapped = TRUE
  
  while(swapped) {
    swapped = FALSE
    for(i in 2:n) {
      if(x[i-1] > x[i]) {
        # swap 
        temp = x[i-1]
        x[i-1] = x[i]
        x[i] = temp
        swapped = TRUE
      }
    }
  }
  return(x)
}



# MergeSort
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

mergesort.time = rep(0,100);

for(i in 1:length(mergesort.time)){
  #obtain the cpu time from the i-th random sample
  #and save the results as, say, t1 and t2
  y =  rnorm(1000, mean = 0, sd = 1) #generated sample of size 100
  ptm <- proc.time()
  mergesort(y) #sorting algorithm 1
  t1 = proc.time()-ptm
  mergesort.time[i]=t1[["elapsed"]]
  
}

bubblesort.time = rep(0,100);

for(i in 1:length(bubblesort.time)){
  #obtain the cpu time from the i-th random sample
  #and save the results as, say, t1 and t2
  y =  rnorm(1000, mean = 0, sd = 1) #generated sample of size 100
  ptm <- proc.time()
  bubblesort(y) #sorting algorithm 1
  t1 = proc.time()-ptm
  bubblesort.time[i]=t1[["elapsed"]]
  
}

mean(mergesort.time)
var(mergesort.time)

mean(bubblesort.time)
var(bubblesort.time)
