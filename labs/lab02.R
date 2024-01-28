#setup workspace
graphics.off()
rm(list=ls())
library(tidyverse)

# Part 1 - Preparing the data
  # 1.
    ?Seatbelts
  # 2.
    d <- as_tibble(Seatbelts) |>
      bind_cols(year = as_tibble(time(Seatbelts))) |>
      relocate(x, .before = DriversKilled) |>
      rename(Year = x)

# Part 2 - Plotting the data
  # 3.
    d$DriversKilled |> 
      barplot(names.arg = d$Year)
  # 4.
    d$petrol_fill <- "grey"
    d$petrol_fill[d$PetrolPrice>0.11] <- "firebrick"
    d$DriversKilled |> 
      barplot(names.arg = d$Year,
              xlab = "Year",
              ylab = "Number of Driver Deaths",
              ylim = c(0,220),
              main = "Driver Fatalities and Petrol Prices",
              col = d$petrol_fill)
  # 5.
    d$DriversKilled[d$PetrolPrice < 0.11] |> 
      mean()
    d$DriversKilled[d$PetrolPrice >= 0.11] |> 
      mean()

#  Part 3 - Scatterplots
  # 6.
    thetas <- seq(from = -pi, to = pi, by = 0.1)
    d <- tibble(x = thetas,
                tan_x = tan(thetas))
    
    plot(x = d$x, y = d$tan_x,
         xlab = "x", ylab = "tan(x)", main = "An Orange Tan",
         type = "o", col = "orange")
    
    
    
    
    