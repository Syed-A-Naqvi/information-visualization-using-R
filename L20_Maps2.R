# Lecture 20 - Maps 2
# CSCI4210U


#### 0. Setup workspace ####
graphics.off()
rm(list=ls())
library(tidyverse)
library(patchwork)
library(maps)
library(socviz)
library(ggthemes)

#### 1. Polygon maps ####
d <- map_data("nz") |>
  select(lon = long, lat, group, id = region) |> 
  as_tibble() 

ggplot(d, aes(x = lon, y = lat, group = group)) + 
  geom_polygon() + 
  coord_quickmap()

# View our data as a point plot
a <- d |> 
  filter(group == 1) |> 
  ggplot(aes(x = lon, y = lat, group = group)) +
  geom_point(size = 0.25) +
  coord_quickmap() + 
  ggtitle('dot plot')

b <- d |> 
  filter(group == 1) |> 
  ggplot(aes(x = lon, y = lat, group = group)) +
  geom_polygon() +
  coord_quickmap() +
  ggtitle('polygon')

a + b + 
  plot_annotation("North island of New Zealand")

# Comparing coordinate systems
ggplot(d, aes(x = lon, y = lat, group = group)) + 
  geom_polygon() + 
  coord_map() +
  ggtitle('coord_map')

# A minor difference
ggplot(d, aes(x = lon, y = lat, group = group)) + 
  geom_polygon() + 
  coord_quickmap() +
  ggtitle('coord_quickmap')


#### 2. US elections 2016 ####
# Explore our data
?election
glimpse(election)

# Party colours (democrat, republican)
party_colors <- c("#0000ff", "#ff0803") 

p1 <- election |> 
  filter(st != "DC") |> 
  ggplot(aes(x = r_points, y = reorder(state, r_points), color = party)) +
  geom_vline(xintercept = 0, color = "gray30") +
  geom_point(size = 2) + 
  scale_color_manual(values = party_colors) + 
  scale_x_continuous(breaks = seq(from = -30, to = 40, by = 10),
                     labels = c("30\n (Clinton)", "20", "10", "0",
                                "10", "20", "30", "40\n(Trump)"))
p1

# Facet by census region (basically the four quarters: N,S,E,W)
# What effect does scales=free_y have here?
p1 + facet_wrap(vars(census), ncol = 2, scales = "free_y") +
  guides(color = "none") + 
  labs(x = "Point Margin", y = NULL) +
  ggtitle('2016 US presidential results by census region') +
  theme_minimal() +
  theme(axis.text = element_text(size = 12),
        strip.text = element_text(size = 14))


# US-by-state map data
d_us <- map_data("state") |> 
  select(lon = long, lat, group, state = region) |> 
  as_tibble() 

head(d_us)



# Coding challenge 1
# 1-2.
ggplot(d_us, aes(x = lon, y = lat, group = group)) +
  geom_polygon(fill = "white", colour = "black", linewidth = 0.15) +
  coord_map()

# 3.
ggplot(d_us, aes(x = lon, y = lat, fill = state, group = group)) +
  geom_polygon(colour = "black", linewidth = 0.15) +
  coord_map() +
  guides(fill = "none")

# Different map projections
p <- ggplot(d_us, aes(x = lon, y = lat, fill = state, group = group)) +
  geom_polygon(colour = "black", linewidth = 0.15) +
  guides(fill = "none")

## Equatorial projections centered on the Prime Meridian
p + coord_map(projection = "mercator")
p + coord_map(projection = "gall", lat0 = 39)
p + coord_map(projection = "albers", lat0 = 39, lat1 = 45)
## Projection centered on the north pole
p + coord_map(projection = "gnomonic")
## Polar conic projections
# Canadian government - https://www150.statcan.gc.ca/n1/pub/92-195-x/2011001/other-autre/mapproj-projcarte/m-c-eng.htm
p + coord_map(projection = "lambert", lat0 = 39, lat1 = 45)


#### 3. Joins ####
# Create x and y
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

# Inner join y with x, using 'key' column
inner_join(x, y, by = "key")


#### 4. Electoral map ####
# Convert election to lowercase
election <- election |> 
  mutate(state = str_to_lower(state))

# Join data
d_us_elec <- left_join(d_us, election, join_by(state == state))

# Provides us with theme_map()
# install.packages('ggthemes')
library(ggthemes)


# 2016 electoral map
ggplot(d_us_elec, aes(x = lon, y = lat, group = group, fill = party)) + 
  geom_polygon(color = "gray90", linewidth = 0.1) +
  coord_map(projection = "gall", lat0 = 45) +
  scale_fill_manual(values = party_colors) +
  theme(legend.position="bottom") +
  theme_map() +
  theme(plot.title = element_text(size=22)) +
  ggtitle('2016 US presidential election, coloured by state-party win')
