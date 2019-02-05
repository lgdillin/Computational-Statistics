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