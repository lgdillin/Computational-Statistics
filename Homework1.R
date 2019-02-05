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
  
  if(mode == 1) {
    result = 0
    for(i in 1:n) {
      result = result + 0.5 ^ i
    }
    return(result)
  } else if(mode == 2) {
    i = 1
    result = 0
    while(i <= n) {
      result = result + 0.5 ^ i
      i = i + 1
    }
    return(result)
  } else {
    ### NOT FINISHED
  }

  

}

func(2, 2)

### Problem 3:
