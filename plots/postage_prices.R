#setup workspace
graphics.off()
rm(list=ls())
library(tidyverse)

# Load Data
d <- read_csv("http://datasets.flowingdata.com/us-postage.csv")

# Explore Data
head(d)

# Basic Step Through plot
plot(x=d$Year, y=d$Price, type = "s", ylim = c(0.25,0.45),
     xlab = "Year", ylab = "Postage Price ($)",
     main = "USPS Postage Prices Over Time", yaxt = "n")#removes default ticks
axis(2, at = seq(from=0.25, to=0.45, by=0.02))

# What it would look like as a line plot
plot(x=d$Year, y=d$Price, type = "l", ylim = c(0.25,0.45),
     xlab = "Year", ylab = "Postage Price ($)", col = "red",
     main = "USPS Postage Prices Over Time", yaxt = "n")#removes default ticks
axis(2, at = seq(from=0.25, to=0.45, by=0.02))
# this plot incorrectly suggests a continuous change in stamp prices when
# the true change in stamp prices came in discontinuous jumps
