#setup workspace
graphics.off()
rm(list=ls())


# Part 1 - Getting the data

# 1
  # loading required libraries
  library(tidyverse)
  library(readxl)

# 2
  # loading the data skipping first 5 lines of input
  d <- read_xlsx("./bc_trade.xlsx", skip = 5)

# 3
  # extracting the current names for columns 1 and 3
  old_names <- names(d)[c(1,3)]
  
  # renaming columns 1 and 3
  d <- d |>
    rename(month = old_names[1]) |> 
    rename(energy = old_names[2])
  
  
# Part 2 - Time series graphics

# 4.
  # creating a color codes vector with the same length as the month column in d
  # and initializing each value to "#cccccc"
  color_codes <- rep("#cccccc", times = length(d$month))
  # for those indices in color_codes matching the row numbers in the d$month
  # column containing Jun, Jul or Aug, we set a value of "firebrick"
  color_codes[d$month == "Jun" | d$month == "Jul" | d$month == "Aug"] <- "firebrick"

# 5.
  # creating the bar graph
  d$energy |> 
    barplot(names.arg = d$month,
            col = color_codes, border = color_codes,
            xlab = "Month", ylab = "Exports ($ thousands)",
            main = "British Columbia Energy Exports")
  
  
  
  
  