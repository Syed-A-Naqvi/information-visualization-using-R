#setup workspace
graphics.off()
rm(list=ls())
library(tidyverse)

# piping in R
# create a sequence of 20 numbers equispaced between 10 and 100 (inclusive)
seq(from=10, to=100, length.out = 20) |>
  # and then round each number in the sequence
  round() |>
  # and then return the head of the sequence
  head()
  
# piping the mtcars data.frame into the group_by() function
# grouping by values in the cyl column and placing the results in a column named
# "# cylinders"
# we then count the number of rows in each grouping and place the results in a
# column named "# cars"
mtcars |>
  group_by("# cylinders" = cyl) |>
  summarise("# cars" = n()) |>
  View()

# average city millage of vehicles by number of cylinders
mpg |> 
  group_by(cyl) |> 
  summarize(cty = mean(cty)) |> 
  ggplot(aes(x = cyl, y = cty, fill = factor(cyl))) +
  geom_bar(stat = "identity")
# some renaming for clarity
mpg |> 
  group_by(cyl) |> 
  summarize(cty_avg = mean(cty)) |> 
  ggplot(aes(x = cyl, y = cty_avg, fill = factor(cyl))) +
  geom_bar(stat = "identity") +
  labs(x="# Cylinders", y = "Average CIty MPG")


