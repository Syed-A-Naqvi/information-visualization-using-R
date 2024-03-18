# 0. initializing environment
  graphics.off()
  rm(list=ls())
  library(tidyverse)
  library(scales)

# Part 1.
  
  # 1.
  # creating a tibble for mapping state names to abbreviations
  state <- tibble(
    name = state.name,
    abb = state.abb
  )
  # using a left_join to append state$name to midwest where values in midwest$state match state$abb
  # using rename to change the name of the newly appended midwest$name to state_name
  d <- midwest |> 
    left_join(state , by = c("state" = "abb")) |> 
    rename(state_name = name)

  # 2.
  # using group_by to summarize population by state
  state_populations <- d |> 
    group_by(state_name) |> 
    summarise(
      population = sum(poptotal, na.rm = TRUE)
    ) |> 
    rename(state = state_name)
  # creating a bar graph of the state populations using ggplot2
  graph <- ggplot(state_populations, aes(x = state, y = population, fill = state)) +
    geom_col()

# Part 2.
  
  # 3.
  # renaming axes, inserting a titles and dropping the legend
  graph <- graph +
    labs(
      title = "Population of the Midwest US",
      y = "State Population",
      x = "US State",
      subtitle = "Source: midwest (2000 US census)"
    )  + 
    theme(legend.position = "none")
  
  # 4.
  # using comma style values instead of scientific notation for values along the y-axis
  graph <- graph + scale_y_continuous(labels = comma)
  # plotting the final graph
  graph
  
  
  
  
  
  
  
  