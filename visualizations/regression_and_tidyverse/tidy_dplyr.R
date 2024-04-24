## initializing environment ##
graphics.off()
rm(list = ls())
library(tidyverse)
library(nycflights13)

## tidy data is a way to organise tabular data in a consistent structure
  # 1. every column is a variable
  # 2. every row is an observation
  # #. every cell is a single value

d <- flights

print(d, n=40)

# dplyr is a grammer of data manipulation. It provides a set of verbs to solve common data manipulation challenges:
  
  # ROWS:
  # 1. filter() - pick observations (rows) based on their column values
  # 2. arrange() - changes the ordering of rows (sorting)
  
  # Columns:  
  # 3. select() - picks variables (columns) based on their names
  # 4. mutate() - adds new variables (columns) that are functions of existing variables (columns)

  # GROUPS OF ROWS:
  # 5. summarize() - reduces multiple values down to a single summary, collapse a group into a single row

  # all above operations can be used with group_by() allowing them to be applied by group instead of the entire dataset

  # FILTER
  view(filter(d, month == 1, day == 1))
  view(filter(flights, month == 1, day > 15))
  
  # ARRANGE
  # if multiple columns are provided, additional columns will be used to break ties in the preceding columns
  flights |>
    arrange(year, month, desc(day)) |>
    view()

  # SELECT
  # select individual columns from a datafram/tibble
  flights |> 
    select(year, day, month) |> 
    head()
  
  flights |> 
    select(day:arr_time)

  flights |> 
    select(!(day:arr_time))
  
  d <- flights |> 
    filter(carrier %in% c("HA", "DL", "US")) |> 
    select(carrier, origin, dest, contains("time")) |> 
    view()
  
  # MUTATE
  # create a small subset and add new colums including new columns based on new columns
  flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
  flights_sml <-  mutate(flights_sml,
         gain = arr_delay - dep_delay,
         speed = distance / air_time * 60,
         hours = air_time / 60,
         gain_per_hour = gain/hours)

  
  
  
  