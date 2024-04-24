## initializing environment
graphics.off()
rm(list = ls())
library(tidyverse)
library(patchwork)

# 2.
# this data has been obtained from https://www.cleanairpartnership.org/projects/electric-vehicle-proliferation-by-municipality-2016-2020-data-now-available/
# it includes on-road vehicles (both passenger and freight) and excludes off-road and farm vehicles
# Non-plugin hybrid vehicles are counted based on the primary fuel source (gas or diesel)
ontario_vehicles <- as_tibble(read_csv("./Registered-Vehicles-by-Municipality-2016-2020.csv"))
ontario_geo <- as_tibble(read_csv("./mmah-list-of-ontario-municipalities-en-utf8-2022-10-05.csv"))
