seq(1, 10)
sample(10, size = 5, replace = TRUE)
plot(1:5, 6:10)

# creating a new function and assigning it to the variable roll
# the function has a default sequence of 1:6 
roll <- function(x = 1:6){
  d <- sample(x, 3)
  # in r, either the last evaluated expression is returned in an implicit return
  # or we can make use of an explicit return using the return function
  return(d)
}

#invoking roll, can pass a sequence or pass nothing to use default sequence
roll(seq(100,1000, by=20))

# using the concatenate function c() to combine values
d <- c(1:5, 3, 4, 5, "abc")
d

# remove all graphics objects
graphics.off()

# clear memory
rm(list = ls())
