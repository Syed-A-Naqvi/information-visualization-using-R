### INITIALIZING ###
graphics.off()
rm(list=ls())
map_packages <- c("ggrepel", "patchwork", "socviz", "tidyverse", "ggthemes", "tidygeocoder", "sf", "ozmaps", "maps", "mapdata", "mapproj", "rmapshaper", "devtools")
lapply(map_packages, library, character.only=TRUE)

### DATA CLEANING ###
  
  # loading the main dataset
  raw <- read_csv("./Electric_Vehicle_Population_Data.csv") |>
    as_tibble() 

  # Extracting primary analysis data 
  d <- raw |>
    as_tibble() |> 
    select(c("Model Year", "Make", "Model",
             "Electric Range")) |> 
    rename(make = Make, model = Model, modelYear = 'Model Year', range = 'Electric Range')
  
# Histogram that counts the number of EVs by make
  make_count <- d |>
    count(make, name = "count") |>
    arrange(desc(count)) |> 
    mutate(over_10k = count > 10000)
  
  make_hist <- make_count |> 
    ggplot() +
    geom_col(aes(x = count,
                 y = reorder(make, count),
                 fill = over_10k)) +
    labs(title = "Number of Electric Vehicles by Manufacturer",
         subtitle = paste(
           "Plug-in Electric Vehicles (PEVs) and Battery Electric Vehicles (BEVs) registered", 
           "through Washington State Department of Licensing as of March 2024", sep = "\n"),
         x = "Number of Registered Vehicles",
         y = "") +
    scale_fill_manual(values = c("TRUE" = "firebrick", "FALSE" = "grey30"),
                      name = "Above 10k Registered Units") +
    scale_x_continuous(
      breaks = c(seq(0, 80000, by = 20000)),
      minor_breaks = c(seq(0, 80000, by = 10000)),
      labels = c("0", "20,000", "40,000", "60,000", "80,000" )
    ) +
    theme(
      axis.line.x.bottom = element_line(linewidth = 0.5, colour = "black"),
      axis.line.y.left = element_line(linewidth = 0.5, colour = "black"),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      plot.title = element_text(size = 14, face = "bold"),
      plot.subtitle = element_text(size = 10),
      plot.margin = margin(b=10, r=10, l=10, t=10, unit = "pt")
    ) +
    geom_vline(xintercept = 10000, linetype = "dashed", color = "black", linewidth = 0.5) +  # Add vertical line
    annotate("text", x = 10000, y = 5, label = "10000 units", color = "black", hjust = -0.2, vjust = -25) +  # Add label for the line
    guides(fill = guide_legend(reverse = TRUE))

# while "TESLA" represents the overwhelming majority of registered EVs "NISSAN" and "CHEVROLET" also have a significantly larger
# amount of registered models as compared to the other manufacturers
# Lets create another histogram this time comparing the average vehicle ranges of the manufacturers
# perhaps the most numerous makes will also have the highest average vehicle ranges?
  above_10k_units <- make_count$make[1:3]
    
  make_range <- d |> 
    filter(!(range == 0)) |> 
    group_by(make) |> 
    summarise(avg_range = mean(range, na.rm = TRUE)) |> 
    arrange(desc(avg_range)) |> 
    mutate(over_10k = if_else(make %in% above_10k_units, TRUE, FALSE))
  
  make_range_bar <- make_range |> 
    ggplot() +
    geom_col(aes(x = avg_range,
                 y = reorder(make, avg_range),
                 fill = over_10k)) +
    labs(title = "Average Electric Vehicle Range by Manufacturer",
         subtitle = "Both Plug-in and Battery EVs included in average",
         x = "Average Range (miles)",
         y = "Vehicle Make") +
    scale_fill_manual(values = c("TRUE" = "firebrick", "FALSE" = "grey30")) +
    theme(
      axis.line.x.bottom = element_line(linewidth = 0.5, colour = "black"),
      axis.line.y.left = element_line(linewidth = 0.5, colour = "black"),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      plot.title = element_text(size = 14, face = "bold"),
      plot.subtitle = element_text(size = 10),
      plot.margin = margin(b=10, r=10, l=10, t=10, unit = "pt"),
      legend.position = "none"
    ) +
    guides(fill = guide_legend(reverse = TRUE))
  make_range_bar + make_hist
  
# we can see that "TESLA" "NISSAN" and "CHEVROLET" also have substantial avg vehicle ranges above 100 miles
  
# lets now look at how the average range of the models for the above manufacturers have changed over time
  
  # extracting and summarizing records for only these manufacturers
  long_range_data <- d |>
    filter((make %in% c("TESLA", "NISSAN", "CHEVROLET")),  !(range == 0)) |> 
    group_by(make, model, modelYear) |> 
    summarize(avg_range = mean(range, na.rm = TRUE))
  
  # finding models with only a single entry
  single_entry <- long_range_data |>
    count(model, name = "modelcount") |> 
    filter(modelcount == 1) |> 
    ungroup() |> 
    pull(model)
  
  # removing records with the single entry model
  long_range_data <- long_range_data |> 
    filter(!(model %in% single_entry))
  
  #creating faceted plots where the points are connected by grouped lines
  range_plot <- long_range_data |> 
    ggplot(aes(x = modelYear, y = avg_range)) +
    geom_line(aes(group = model, color = model)) +  # Connect data points by model group with lines
    geom_point(aes(group = model, color = model)) +  # Add data points
    facet_wrap(~make, scales = "free") +  # Create a separate plot for each manufacturer
    labs(
      title = "Evolution of Electric Vehicle Ranges by Make and Model",
      x = "Model Year",
      y = "Average Range (miles)",
      colour = "Model"
    ) +
    scale_x_continuous(breaks = function(x) seq(floor(min(x)), ceiling(max(x)), by = 1)) +  # Adjust x-axis to increment by 1 year
    scale_color_brewer(palette = "Paired") +
    theme_minimal() +
    theme(
      plot.margin = margin(t=10, b=10, r=10, l=10, unit = "pt"),
      
      panel.border = element_rect(colour = "black", fill=NA, linewidth=0.4),
      
      axis.title.x = element_text(margin = margin(t=10, unit = "pt")),
      axis.title.y = element_text(margin = margin(r=10, unit = "pt")),
      plot.title = element_text(size = 16, face = "bold"),
      
      strip.background = element_rect(fill = "grey90"),  # Customize the look of facet labels
      strip.text.x = element_text(face = "bold"),  # Bold facet titles for clarity
      legend.background = element_rect(fill = "white")
    )
  range_plot
  
# we can see that generally most ev's have managed to increase their average range over their iterations
# the Tesla Model 3 and S both seemed to initially decrease in their average ranges before making improvements
    
# let us now examine the proportion of the top 7 most numerous models and see how they compare to the remaining
# models by all other manufacturers

  # Total number of vehicles
  total_vehicles <- nrow(d)
  
  # Top 7 most numerous models
  numerous_makes <- d |> 
    count(make, model) |> 
    arrange(desc(n)) |> 
    slice(1:7)
  
  # Sum the counts of the top 7 makes/models
  top_vehicles_count <- sum(numerous_makes$n)
  
  # Calculate the count for "OTHER"
  other_vehicles <- total_vehicles - top_vehicles_count
  
  # Combine the top 7 with "OTHER" and calculate percentages
  model_percentages <- numerous_makes |> 
    ungroup() |> 
    add_row(make = "OTHER", model = "OTHER", n = other_vehicles) |> 
    mutate(percentage = n / total_vehicles) |> 
    mutate(model = paste(make, model, scales::percent(percentage), sep = " "))
  
# creating a pie chart of the above data
  
  # Calculate label positions
  model_percentages <- model_percentages %>%
    arrange(desc(model)) %>%
    mutate(cumsum = cumsum(percentage),
           pos = cumsum - percentage / 2,
           label = scales::percent(percentage))
  
  # Create the pie chart
  pie_chart <- ggplot(model_percentages, aes(x = "", y = percentage, fill = model)) +
    geom_col(width = 1, colour = "black", linewidth = 0.2) +
    coord_polar(theta = "y") +
    scale_fill_brewer(palette = "Set3") +
    geom_label_repel(
      aes(y = pos, label = label), 
      size = 4.5, 
      nudge_x = 1, 
      show.legend = FALSE
    ) +
    theme_minimal() +
    theme(
      legend.key = element_rect(colour = "black"),
      plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      axis.text.x = element_blank(),
      panel.border = element_rect(colour = "black", linewidth = 0.2, fill = NA),
      panel.grid = element_blank(),
      legend.background = element_rect(fill = "grey100", colour = "black", linewidth = 0.2)) +
    labs(fill = "Make and Model", title = "Percentage of EV's Registered in Washington State")
  
  # Display the pie chart
  pie_chart

# as expected the most numerous ev models registerd in washington state are belong to the three most numerous makes
  # we can see that the tesla model 3 and model Y both make up a substantial portion of all ev registrations
  
# Lets look at the country wide distribution of TESLAs
  # Extracting extracting state and county information from raw dataset
  mapping <- raw |> 
    select("State",Make) |> 
    rename(make = Make, abb = "State")
  
  # creating a simple state name to state abbreviation mapping
  state_mapping <- tibble(abb = state.abb,
                          name = state.name)
  
  # creating a tibble with the vehicle make and the statename,countyname
  mapping <- mapping |> 
    left_join(state_mapping, join_by(abb)) |> 
    mutate(name = tolower(name)) |> 
    select(make, name)
  
  # creating a simple feature object from US county data
  d_state = st_as_sf(maps::map('state', plot = FALSE, fill = TRUE))
  
  # using d_state and the mapping dataset to create an sf object for TESLAs distributed throughout the us
  mapping <- mapping |> 
    mutate(make = ifelse(make == "TESLA", 1, 0)) |> 
    inner_join(d_state, join_by(name == ID)) |> 
    group_by(name, geom) |> 
    summarise(n = sum(make), .groups = "drop")
  
  # Create the base map with correct legend scaling
  p <- ggplot() +
    theme_map() +
    geom_sf(data = mapping, aes(fill = n, geometry = geom), colour = "grey") +
    scale_fill_gradientn(colors = c("white", "red"),
                         trans = "log1p", 
                         breaks = c(1, 10, 100, 1000, 10000, 100000),
                         labels = c("1", "10", "100", "1k", "10k", "100k")) +
    coord_sf(crs = st_crs(4326)) +
    theme(legend.position = "bottom",
          legend.direction = "horizontal",
          legend.key.width = unit(1.5, "cm"),
          plot.title = element_text(size = 16, face = "bold")) +
    labs(title = "Distribution of Washington-Registered Teslas in the US by State", fill = "Number of Teslas")
  
  # Adding the state boundaries
  p <- p + 
    geom_sf(data = d_state, fill = NA, colour = "grey30", linewidth = 0.35)
  
  # Add labels only for states with Teslas
  d_state_with_teslas <- d_state |> 
    inner_join(mapping |>  filter(n > 0), by = c("ID" = "name"))
  
  p <- p +
    geom_sf_label(data = d_state_with_teslas, aes(label = ID), nudge_x = 0.1, nudge_y = 0.1, size = 2) +
    theme(axis.title = element_blank())
  
  # Print the map
  print(p)
  

  