# initialize
graphics.off()
rm(list=ls())
library(tidyverse)

flights <- nycflights13::flights
dim(flights)
print(flights, n=40)

flights |> filter(month == 1, day > 15)

flights |> arrange(year, desc(month), desc(day))
view(flights)

airlines <- nycflights13::airlines
#view(airlines)

carriers <- filter(airlines, name %in% c("Hawaiian Airlines Inc.","Delta Air Lines Inc.", "US Airways Inc.")) |> 
  select(carrier) |> 
  as_vector() |> 
  unname()

desired_flights <- filter(flights, carrier %in% carriers) |> 
  select(carrier, origin, dest, contains("time"))
head(desired_flights)
dim(desired_flights)

#create a subset
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)

# create new variables
flights_sml |> mutate(gain = arr_delay - dep_delay,
                      speed = distance / air_time * 60)
