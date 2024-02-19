## initialize environment ##
graphics.off()
rm(list = ls())
library(tidyverse)

## overview ##

## basic ggplot example
ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point()

## nice example ##
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth() +
  labs(x = "Displacement (L)", y = "Highway Mileage (mpg)",
       colour = "Drive Train",
       title = "Highway Fuel Economy of 2008 Cars")

       
ggplot(midwest, aes(x = percprof, y = percchildbelowpovert)) +
  geom_point(aes(colour = factor(inmetro))) + 
  geom_smooth(method = "lm")


## coding challenge 1 ##
graphics.off()
rm(list=ls())

p <- ggplot(mpg, aes(x = cty, y = hwy))

p + geom_point(aes(colour = manufacturer))
p + geom_point(aes(shape = drv, colour = drv))
p + geom_point(aes(size = cyl))

## coding challenge 2 ##
graphics.off()
rm(list=ls())

g <- ggplot(mpg, aes(x = class))

g + geom_bar(aes(fill = drv)) + ggtitle("drive train distribution")

## coding challenge 3 ##


    