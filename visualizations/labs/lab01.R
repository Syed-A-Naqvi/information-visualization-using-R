graphics.off()
rm(list=ls())
library(tidyverse)
# Part 1. Functions
  
  #1. create a sequecne of 15 numbers from 10 to -10
  s <- seq(10,-10, length.out = 15)
  # length.out is apparently the correct length argument
  
  #2. Take the mean of all values and round the answer
  roundedMean <- function(sequence){
    rm <- mean(sequence) |>
      round()
    return(rm)
  }
  print(roundedMean(s))
  # there are 7 positive numbers between 0 and 10, each of which has a negative complement
  # summing all these numbers gives 0 and so the mean is zero
  
  #3. Comparing the mean with 0
  print(roundedMean(s), 0)
  
  #4. roll function
  roll <- function(x=10){
    v <- sample(x, 5, replace = TRUE)
    return(v)
  }
  
  #5. default
  print(roll())
  # 3 sided die
  print(roll(3))

# Part 2. Data Structures
  
  # 6. create a vector of integers from 1:10 saving results in d
  # there are multiple ways to create a numeric vector in R
  d <- c(1:10)
  d <- seq(1,10)
  
  #7. confirming d is a vector
  is.vector(d)
  
  #8. concatenating the string "100" to the end of a numeric vector
  d <- c(d,"100") # turns any numeric value in d to a string
  
  #9. vector data type should now be 'character'
  class(d)
  
  #10 turning the data type back to numeric using as.numeric
  d <- as.numeric(d)
  is.vector(d)
  is.numeric(d)
  
  #11. creating a 3x4 data frame
  cards <- tibble(face = c("ace", 'two', 'six', 'king'),
            suit = c("clubs", "clubs", "clubs", 'hearts'),
            value = c(1, 2, 3, 10))
  
# Part 3. Subsetting
  
  #12. checking the dimensionality of the tibble
  paste0("the cards tibble has a dimensionality of (", dim(cards)[1],",",dim(cards)[2],") ",
         " with ", nrow(cards), " rows and ", ncol(cards), " columns.")

  #13. output the suits column to the console
  print(cards$suit) #this returns the suit column as a vector
  print(cards[c("suit")]) # this returns a new tibble containing only the suits column
  
  #14. print the first three rows of all columns to the console
  print(cards[1:3,]) # we are indexing the cards tibble using a numeric vector to index the rows

  #15. print rows 2 and 4 and columns 2 and 3
  print(cards[c(2,4),c(2,3)])
  
  
  
  
  
  
  
  