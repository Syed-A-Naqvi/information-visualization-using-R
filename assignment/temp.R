### INITIALIZING ###
graphics.off()
rm(list=ls())
map_packages <- c("patchwork", "socviz", "tidyverse", "ggthemes", "tidygeocoder", "sf", "ozmaps", "maps", "mapdata", "mapproj", "rmapshaper", "devtools")
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
  # Extracting mapping Data
  mapping <- raw |> 
    select("County", Make)

  
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
    labs(title = "Number of Electric Vehicles by Make",
         subtitle = expression(
           "Plug-in Electric Vehicles (PEVs) and Battery Electric Vehicles (BEVs)" *
             " registered through Washington" * "\n" * "State Department of Licensing as of March " * 
             "12"^"th" * ", 2024"
         ),
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
         x = "Average Range (miles)",
         y = "Vehicle Make") +
    scale_fill_manual(values = c("TRUE" = "firebrick", "FALSE" = "grey30")) +
    geom_vline(xintercept = 100, linetype = "dashed", color = "black", linewidth = 0.5) +  # Add vertical line
    annotate("text", x = 100, y = 5, label = "100 miles", color = "black", hjust = -0.2, vjust = -25) +  # Add label for the line
    theme(
      axis.line.x.bottom = element_line(linewidth = 0.5, colour = "black"),
      axis.line.y.left = element_line(linewidth = 0.5, colour = "black"),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      plot.title = element_text(size = 14, face = "bold"),
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
    
# as TESLA represents the overwhelming majority of electric vehicles lets perform more detailed analysis on the proportion of
  # the models of this make as compared to other make models
  



# can select the the most numerous models and find the change in their range over the years
  # could use faceting here perhaps in addition to grouping a trend line so faceting over make and grouping over model per make
# could then create a bar graph of the average range per make
# could then select the most numerous few makes and then create a pie chart of the model proportionality
# then just colour a map by county and the most numerous makes






  