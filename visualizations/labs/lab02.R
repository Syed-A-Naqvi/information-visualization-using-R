# setup
graphics.off()
rm(list=ls())
library(tidyverse)

# Part 1. Preparing the data

  #1. exploring Seatbelts dataset
  ?Seatbelts

  #2. converting the ts object to a tibble
  d <- as_tibble(Seatbelts) |> 
    bind_cols(tibble(Year = time(Seatbelts))) |> 
    relocate(Year, .before = DriversKilled)
  
  #3. Create a barplot of DriversKilled with Year as the x-axis labels.
  barplot(d$DriversKilled, names.arg = d$Year, xlab = "Year", ylab = "Number of Drivers",
          ylim = c(0,220))
  
  #4. when PetrolPrice < 11 the bars are 'grey' otherwise 'firebrick'
  # generating color code vector
  colors = rep('grey', length(d$Year))
  colors[d$PetrolPrice >= 0.11] <- "firebrick"  
  # applying coloring
  barplot(d$DriversKilled, names.arg = d$Year, xlab = "Year", ylab = "Number of Drivers",
          ylim = c(0,220), col = colors, main = "Driver Fatalities and Gas Prices")
      
  #5. generating avg fatalities when petrol was < 11c and >= 11c
  avg_a <- mean(d$DriversKilled[d$PetrolPrice<0.11])
  avg_b <- mean(d$DriversKilled[d$PetrolPrice>=0.11])
  print(avg_a)
  print(avg_b)
  
# Part3. Scatterplots
  #6. create a tibble() where x is sequence of numbers between -pi and pi and y is tan of this numbers
  t <- tibble( x = seq(-pi, pi, 0.1),
               y = tan(x))

  #7. creating a scatterplot with both points and lines, axis labels and titles.
  plot(x = t$x, y = t$y,
       xlab = "x", ylab = "tan(x)", main = "An Orange tan", type = "b", col="tan")
  
  
  
  
  
  
  
  
  
  
  
  
