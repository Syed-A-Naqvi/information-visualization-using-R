#setup workspace
graphics.off()
rm(list=ls())
library(tidyverse)

# Load Data
d <- read_csv("http://datasets.flowingdata.com/world-population.csv")

# Exploring Data
head(d)

# Plotting Data
plot(x=d$Year, y=d$Population,
     type = "o",
     ylim = c(0, 7e9),
     xlab = "Year", ylab = "Population",
     main = "World Population Growth",
     sub = "source: UN department")
