# setup
graphics.off()
rm(list=ls())
library(tidyverse)


# Part 1 - Exploring the data
  #1. load the nycflights dataset
  flights <- as_tibble(nycflights13::flights)
  #2. exploring the flights tibble
  head(flights)
  #3. sorting the tibble by departure delay in descending order    
  flights <- flights |> 
    arrange(dep_delay)
  head(flights)
  
# Part 2 - Summarising the data
  #4. identify avg departure delay for carriers. Save results in d and drop na values using mean function arguments
  d <- flights |> 
    group_by(carrier) |> 
    summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE))
  #5. sorting d by departure delay in ascending order
  d <- d |> 
    arrange(desc(avg_dep_delay))
  
# Part 3 - Joining and slicing
  #6. exploring tibble planes part of flights13
  airlines <- nycflights13::airlines
  head(airlines)
  #7. Using left_join to join d and planes airline names should now be in d
  d <- left_join(d, airlines, by=join_by(carrier)) |> 
    relocate(name, .before = avg_dep_delay)
  #8. using slice_max() to extract the row with the largest departure delay value
  d |> slice_max(avg_dep_delay) |> view()
  #9. storing the result from 8 in d_worst
  d_worst <- d |> 
    slice_max(avg_dep_delay)
  view(d_worst)

# Part 4 - How many engines?
  #10. joining flights and planes using tailnum as key
  plane_flights <- left_join(flights, nycflights13::planes, by=join_by(tailnum))
  #11. mutating the engines column into a factor using as_factor()
  plane_flights <- plane_flights |> mutate(engines = as_factor(engines))
  #12. calculate the average dep_delay per month
  avg_dep_delay_month <- plane_flights |>
    drop_na(dep_delay) |> 
    group_by(month) |> 
    summarize(avg_dep_delay = mean(dep_delay))
  view(avg_dep_delay_month)
  #13. creating a stacked bar plot with month(x), dep_delay(y) and where bar segments are color coded
  # according to the portion of the mean delay attributable to different engine counts
  avg_delay_monthandengine <- plane_flights |> 
    drop_na(dep_delay, month) |> 
    group_by(month,engines) |> 
    summarize(avg_delay = mean(dep_delay))
  
  graph <- avg_delay_monthandengine |>
    ggplot(aes(month, avg_delay, fill = engines)) +
    geom_col() +
    labs(x="month", y="Mean departure delay (mins)", title = "Average departure delay by month and engine")
  graph  
