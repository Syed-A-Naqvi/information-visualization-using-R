#setup workspace
graphics.off()
rm(list=ls())
library(tidyverse)

# Load data
d <- read_csv("http://datasets.flowingdata.com/flowingdata_subscribers.csv")

# Explore the data
head(d)

# Basic plot
plot(d$Subscribers)
# if only a single vector is passed to plot() it assumes that each value in the
# vector is a y-value and the x-axis will automatically consists of indices

# providing labels and rescalling the y-axis
plot(d$Subscribers, ylim = c(0,30000), xlab = "Day", ylab = "Subscribers")

# by adding type="l" we can turn the scatter plot into a line graph
plot(d$Subscribers, ylim = c(0,30000), xlab = "Day", ylab = "Subscribers", type = "l")


