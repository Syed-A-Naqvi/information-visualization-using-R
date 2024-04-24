## initialize environment ##
graphics.off()
rm(list = ls())
library(tidyverse)

#Part 1. Data types in scales
  #1.
  g <- ggplot(mpg, aes(x = cty, y = hwy, color = as_factor(cyl))) + 
    geom_jitter() + # jittered scatterplot
    geom_smooth(method = "lm", color = "darkgrey", se = FALSE) +
    labs(title = "Highway and city mileage are highly correlated",
        x = "City mileage/gallon",
        y = "Highway mileage/gallon",
        color = "Cylinders")

  #2.
  g <- g + scale_color_brewer(palette = "BrBG") # Color Brewer palette for points

  #3.
  g <- g + scale_x_reverse() # Reverse the direction of the x-axis

  #4.
  g <- g + scale_y_continuous(limits = c(10, 50), breaks = seq(10, 50, length = 5)) # Y-axis limits and breaks

#Part 2. Themes
  #5.
  g <- g + theme(plot.title = element_text(face = "bold.italic", size = 15)) # Bold Italic Title, Size 15
  
  #6.
  g <- g + theme(panel.background = element_rect(fill = "aliceblue", color = "black")) # aliceblue background, black border
  
  #7.
  g <- g + theme(panel.grid.minor = element_blank()) # Disable minor gridlines
  
  #8.
  g <- g + theme(panel.grid.major = element_line(color = "grey70", linewidth = 0.2)) # Major gridlines grey70, width 0.2
  
#outputting plot
  g
