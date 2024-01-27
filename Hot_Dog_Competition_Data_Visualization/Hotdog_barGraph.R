#setup workspace
graphics.off()
rm(list=ls())
library(tidyverse)

# Loading the data using read_csv()
d <- read_csv("http://datasets.flowingdata.com/hot-dog-contest-winners.csv") |> 
  rename(dogs_eaten = `Dogs eaten`,
         new_record = `New record`)

# Exploring the data
head(d)

# d[,3] will exctract the third column but maintain its class as a dateframe or
# tibble, not a vector
# the barplot() function requires a vector
# we can use d$dogs_eaten to extract the specified column as a vector not a tibble

# Create a bar graph
d$dogs_eaten |> 
  barplot()

# Labeling the bars on the x-axis
d$dogs_eaten |> 
  barplot(names.arg = d$Year)


# styling the bar graph
# Labeling the x axis
d$dogs_eaten |> 
  barplot(names.arg = d$Year, # names.arg is used to name each bar
          col = "#821122",
          border = NA,
          xlab = "Year", # xlab names the x-axis itself
          ylab = "Hotdogs and Buns (HDB) Eaten")


# labeling based on us victories

  # creating a new column for representing usa victories and initializing the
  # column so that each cell/row contains hex code for the color grey
  d$usa_won <- "#cccccc"
  d
  # we return only those cells in the usa_won column associated with rows in
  # which the country of victory was the United States and assign these cells
  # with a color of red
  d$usa_won[d$Country == "United States"] <- "#821122"
  d
  
  # we can now pass the d$usa_won column as the col parameter in barplot()
  d$dogs_eaten |> 
  barplot(names.arg = d$Year, # names.arg is used to name each bar
          col = d$usa_won,
          border = NA,
          xlab = "Year", # xlab names the x-axis itself
          ylab = "Hotdogs and Buns (HDB) Eaten")
  
  
# labeling based on world records set
  # same exact process as above only this time we use the d$record_set column
  d$world_record_fill <- "#cccccc"
  d

  d$world_record_fill[d$new_record == 1] <- "#821122"
  d

  d$dogs_eaten |> 
    barplot(names.arg = d$Year, # names.arg is used to name each bar
            col = d$world_record_fill,
            border = NA,
            xlab = "Year", # xlab names the x-axis itself
            ylab = "Hotdogs and Buns (HDB) Eaten")

  