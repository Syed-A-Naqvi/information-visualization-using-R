# remove all graphics objects
graphics.off()
# clear memory
rm(list = ls())

# loading the tidyverse library
library(tidyverse)

# generating a ggplot on some dummy vehicle data
ggplot(mtcars,aes(x = mpg, y = wt, colour=cyl) ) + 
  geom_point() + 
  geom_smooth()
?mtcars

