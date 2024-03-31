# initializing environment
graphics.off()
rm(list=ls())
map_packages <- c("tidygeocoder", "sf", "ozmaps", "maps", "mapdata", "mapproj", "rmapshaper", "devtools")
lapply(map_packages, library, character.only=TRUE)
devtools::install_github("kjhealy/socviz")
library(tidyverse)
library(patchwork)
library(maps)
library(socviz)
library(ggthemes)


ad1 <- geo("Ontario tech university")
ad2 <- geo("Eiffel tower")
print(ad2$lat)
print(ad2$long)

reverse_geo(lat = ad2$lat, long = ad2$long)

d_italy <- map_data("italy") |>
  select(lon=long, lat, group, id = region) |> 
  as_tibble()

d_italy |> 
  ggplot(aes(x = lon, y = lat, group = group)) +
  geom_polygon(fill=d_italy$group, color = "grey12", linewidth = 0.25) + 
  coord_quickmap()

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

d_us <- map_data("state") |> 
  select(lon=long, lat, group, state = region) |> 
  as_tibble()  
head(d_us)

d_us |> 
  ggplot(aes(x=lon, y=lat, group=group)) +
  geom_polygon( color = "black", fill="white", linewidth=0.15) +
  coord_map(projection = "gall", lat0 = 45)

airlines <- nycflights13::airlines
airports <- nycflights13::airports
flights2 <- nycflights13::flights |> 
  select(year, time_hour, origin, dest, tailnum, carrier)
view(flights2[1:10,])  

# left joining flights2 with airlines
# this will retain all rows in flights2 where rows with unmatching keys contain a value of NA
# and drop all rows with unmmatching keys in airlines
lj <- left_join(flights2, nycflights13::airlines, join_by(carrier))
view(lj[1:10,])  

# inner joining flights2 with airports matching on dest and faa
# this will drop all rows from both datasets without a matching key
ij <- inner_join(flights2, airports, join_by(x$dest == y$faa))
view(ij[1:100,])
  
el <- election |> 
  mutate(state = str_to_lower(state))

d_us_election <- left_join(d_us, el, join_by(x$state == y$state))

party_colors <- c("#0000ff", "#ff0803") 
p1 <- d_us_election |> 
  ggplot(aes(x=lon, y=lat, group = group, fill = party)) +
  geom_polygon(colour = "white", linewidth = 0.15) +
  scale_fill_manual(values = party_colors) +
  coord_map()
p1
p1 <- d_us_election |> 
  ggplot(aes(x=lon, y=lat, group = group, fill = party)) +
  geom_polygon(colour = "white", linewidth = 0.15) +
  coord_map() +
  scale_fill_manual(values = party_colors) +
  theme_map() +
  theme(legend.position = "bottom",
        plot.title = element_text(size = 22),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 15)) +
  labs(title = "2016 US presidential election, coloured by state-party win", fill = "Party")
p1




