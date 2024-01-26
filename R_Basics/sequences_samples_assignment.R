# Generate an inclusive-inclusive sequence
100:110

# Use the seq() function to generate a more fine-tuned sequence
  
  # generate 5 numbers that increment by 2 and begin at 0
  seq(from=0, length=5, by=2)
  
  # generate a sequence specifying start, upper bound and increment
  seq(from=0, to=10, by=3)
  
# Exercise: Create a sequence of even numbers, multiply the sequence by 3
# and squre each element of the resulting sequence
  my_sequence <- (seq(from=0, length=6, by=2)*3)^2
  
# Using the sample function to generate a sample of 4 numbers
# from a sequence of 1:10 WITH replacement
  # the following lines are equivalent:
  sample(x=1:10, size=4, replace=TRUE)
  sample(seq(1,10), 4, TRUE)
  sample(size=4, TRUE, x = seq(from=1,to=10))
  # as we can see, R can intelligently infer tags

# we can read documentation for the default behaviour of functions
  