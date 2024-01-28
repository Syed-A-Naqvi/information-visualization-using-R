#setup workspace
graphics.off()
rm(list=ls())
library(tidyverse)

# read in data and convert to matrix
# stacked bar graphs require a matrix
d <- read_csv("http://datasets.flowingdata.com/hot-dog-places.csv") |> 
  as.matrix()
class(d)

# styled stacked bar graph
barplot(d[c(3,2,1),], border = "white", space = 0.25, ylim = c(0, 200),
        col = c("#018A44", "#38AA48","#83BF45"), xlab = "Year",
        ylab = "Hot dogs and buns (HDBs) eaten",
        main = "Hot Dog Eating Contest Results, 1980-2010")
# since d is a matrix, barplot() will create a stacked bar graph
# each row represents the number of hotdogs eaten for 1st, 2nd and 3rd place
# respectively with the column representing the year of the competition