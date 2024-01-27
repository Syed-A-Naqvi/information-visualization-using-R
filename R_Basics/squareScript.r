# accepts an object that can be square such as a single number or a sequence
# 
square_it <- function(x){
  if(!is.numeric(x)){
    stop("Error: Non-numeric value provided.")
  }
  return(x^2)
}
