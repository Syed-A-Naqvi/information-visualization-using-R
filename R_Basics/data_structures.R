# creating vectors
d <- 1:5
x <- 1:7
# checking the type of data in the vectors
class(d)
class(x)
# checking the type of data structure of x and d
is.vector(d)
is.vector(x)

#vectors are dynamic can grow and shrink in size
  # old vector d
  d
  length(d)
  
  # adding values into d changing its size
  d <- c(1:6, 0, d)
  
  # new vector d
  d
  length(d)
  
# vectors are homogeneous and so mixing types will lead to "coercion"
# R will convert values to maintain homogeneity
  
  # 1 through 4 are integers but will be turned into floats due to the
  # addition of floating point values  
  d <- c(1:4, 6.6, 4.4)
  d

  # trying to add strings will result in everything being coerced into a string
  d <- c(d, "d")
  d
   
# Sub-setting or slicing is different from python in that R has inclusive
# indices on both ends and indexing starts at 1
  x <- seq(from=1, to=30, by=3)
  x
  
  x[2] # access second element, element at index 2
  x[1:5] # access elements from index 1 to index 4, first four elements
  x[c(1, 5, 9)] # access elements at indexes 1, 5, and 9
  # x[1,5,9] this is incorrect for a 1D vector, this implies dim 3
  
  # vectors are 1D and homogeneous
  # data frames are 2D and heterogeneous
  
  # using the built-in iris data frame
  ?iris
  class(iris)
  dim(iris)
  # opens the data frame in a separate tab
  View(iris)
  
  # the data frame as a whole can be heterogeneous but each column must
  # be individually homogeneous
  # each column is actually a vector so must be homogeneous
  head(iris)
  # better formatting
  as_tibble(iris)
  
# creating a data frame
  d <- data.frame(ids=1:6,
                  names=c("Andy", "Steve", "Bob", "Fred", "Joe", "Meagan"),
                  ages = c(23, 19, 56, 32, 77, 12))
  d
  dim(d)
  # does not know which column you would like to know the class of
  # returns "data.frame"
  class(d)
  #specifying the names column, returns "character"
  class(d$names)

  # extracting parts of the data frame
  d[1:6, 1:2] # first 6 rows and first 2 columns
  d[,] # all rows and all columns
  d # all rows and all columns
  d[,2:3] # all rows and last two columns
  d[c(1,3,5), c(1,3)] # rows 1,3 and 5 and columns 1 and 3
  d[c(1,1,3,2), c(3,3,3)] # duplicating and replacing orders of cols/rows
  
# Logical Subsetting
  5<10 # this is just TRUE
  1:20 < 10 # TRUE for each term in the sequence less than 10
  
  x
  x < 10 # TRUE for all those values in x less than 10
  x[x < 10] # will return only those indexes for which there is a TRUE value
            # there is only a TRUE for indexes whose element is less than 10
  
  d[d$ages<40,]  # logical subsetting of a data frame
                 # we will print all columns and only those rows marked TRUE
                 # a row is marked true if the value in its age column is less than 40
  
  
  
  