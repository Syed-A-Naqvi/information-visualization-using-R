#setup workspace
graphics.off()
rm(list=ls())
library(tidyverse)

# part 1 - Functions
  # 1.
    a <- seq(from=10, to=-10, length = 15)
  # 2.
    b <- a |> mean() |> round()
  # 3.
    0 == b
  # 4.
    roll <- function(x = 10){
      sample(1:x, size=5, replace = TRUE)
    }
  # 5.
    roll()
    roll(3)

# Part 2 - Data Structures
  # 6.
    d <- 1:10
  # 7.
    is.vector(d)
  # 8.
    d <- c(d, "100")
    d
  # 9.
    class(d)
  # 10.
    d <- as.numeric(d)
    class(d)    
    d
  # 11.
    d <- data.frame(face = c("ace","two","six","king"),
                    suit = c("clubs","clubs","clubs","hearts"),
                    value = c(1,2,3,10))
    d
# Part 3 - Subsetting
  # 12.    
    dim(d)
  # 13.
    d$suit
  # 14.
    d[1:3,]
  # 15.
    d[c(2,4),c(2,3)]
    
    