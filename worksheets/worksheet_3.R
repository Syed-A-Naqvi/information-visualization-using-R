#### 0. Setup Workspace ####
graphics.off()
rm(list=ls())
library(tidyverse)


# Part 1 - Data Wrangling

  # 1. loading data and filtering species
  # only loading relevant columns
  d <- starwars |>
       select(name, mass, height, species) |>
       filter(str_detect(species, "^(G|D|W)") | str_detect(species, "man$")) 
  
  # 2. character BMI, species mean BMI, removing na values
  # drop_na() will remove all na rows from the dataframe
  d <- d |>
       drop_na() |> 
       mutate(character_BMI = mass / (height/100)^2) |> 
       group_by(species) |> 
       mutate(species_mean_BMI = mean(character_BMI))
  
  # 3. adding a column named is_bigger for mean BMI > 30
  d <- d |> 
       mutate(is_bigger = if_else(species_mean_BMI>30, "yes", "no"))

  
# Part 2 - Visualization
  
  # 4. & 5. creating bar graph with appropriate labels
  d |> 
    select(species, species_mean_BMI, is_bigger) |>
    distinct() |>
    ggplot(aes(x = species, y = species_mean_BMI, fill = is_bigger)) +
    geom_bar(stat = "identity") +
    labs(title = "The biggest species in Star Wars", x = "species",
            y = "Body mass index (kg/m^2)", fill = "BMI > 30")
  
  
  