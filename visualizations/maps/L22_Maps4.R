# Lecture 22 - Maps 4
# CSCI4210U


#### 0. Setup workspace ####
graphics.off()
rm(list=ls())
library(tidyverse)
library(patchwork)
library(maps)
library(socviz)
library(ggthemes)


#### 1. County level maps ####
# Join tables
d_county_map <- left_join(county_map, county_data, join_by(id)) |> 
  as_tibble() |> 
  rename(lon = long)

# Create a population density map
ggplot(d_county_map, aes(x = lon, y = lat, fill = pop_dens,  group = group)) +
  geom_polygon(color = "gray90", linewidth = 0.1) + 
  coord_equal() +
  scale_fill_brewer(palette="Blues", 
                    labels = c("0-10", "10-50", "50-100", "100-500", "500-1,000", "1,000-5,000", ">5,000")) + 
  labs(fill = "Population per\nsquare mile",
       title = "Population density in the United States") +
  theme_map() +
  guides(fill = guide_legend(nrow = 1)) + 
  theme(legend.position = "bottom",
        plot.title = element_text(size=22))

# Coding challenge 1
ggplot(d_county_map, aes(x = lon, y = lat, fill = su_gun6,  group = group)) +
  geom_polygon(color = "gray90", linewidth = 0.1) + 
  coord_equal() +
  scale_fill_brewer(palette="Reds", 
                    labels = c("0-4", "4-7", "7-8", "8-10", "10-12", "12-54")) + 
  labs(fill = "Firearm-suicides\n100,000 people",
       title = "Firearm-related suicides, 1999-2015") +
  theme_map() +
  guides(fill = guide_legend(nrow = 1)) + 
  theme(legend.position = "bottom",
        plot.title = element_text(size=22))

#### 2. simple features ####
library(sf)
#library(mapcan)

# Load North Carolina shape file from sf package
nc <- st_read(system.file("shape/nc.shp", package="sf"))
print(nc, n = 3)

# Visualise NC data
ggplot(nc) +
  geom_sf(aes(fill = BIR79)) +
  scale_fill_viridis_c(name = "Live births") +
  coord_sf(crs = st_crs(4326))
  
# https://en.wikipedia.org/wiki/World_Geodetic_System

# Convert shape data from maps package to sf
d_county = st_as_sf(map('county', plot = FALSE, fill = TRUE))

# Join with fips to get fips codes, then join with our county-level survey data
d_county <- d_county |> 
  inner_join(county.fips, join_by(ID == polyname)) |> 
  left_join(county_data, join_by(fips == fips))


# Get the Canada lambert conformal
# Click: Proj4
# https://spatialreference.org/ref/esri/canada-lambert-conformal-conic/
  
# CRS 4326 - WGS84
#https://spatialreference.org/ref/epsg/4326/
  

# Visualise travel time
p <- ggplot() + 
  geom_sf(data = d_county, aes(fill = travel_time), colour = "gray85") +
  scale_fill_gradient2(low = scales::muted("blue"),
                       mid = "white",
                       high = scales::muted("red"),
                       midpoint = median(d_county$travel_time),
                       name = "Travel time (mins)") +
  coord_sf(crs = st_crs(4326)) +
  #coord_sf(crs = st_crs('+proj=lcc +lat_1=50 +lat_2=70 +lat_0=40 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs')) +
  labs(title = "Average travel time to work",
       subtitle = 'WGS system')
p


# Grab state boundaries
d_state = st_as_sf(map('state', plot = FALSE, fill = TRUE))

# Convert US cities data to sf. Dropping Alaska and Hawaii
d_cities <- st_as_sf(us.cities, coords = c("long", "lat"), crs = 4326, remove = FALSE) |> 
  filter(!(country.etc %in% c("AK","HI")), pop > 4e5)

# Overlay cities, city names, and state borders
p + 
  geom_sf(data = d_cities, size = 4, colour = "black", alpha = 0.75) +
  geom_sf_label(data = d_cities, aes(label = name), nudge_x = 2.5, nudge_y = 0.5, alpha = 0.7) +
  geom_sf(data = d_state, fill = NA, colour = 'grey50', linewidth = 0.35) +
  theme(axis.title = element_blank(),
        legend.position = "bottom")

