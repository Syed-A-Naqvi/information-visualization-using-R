# Final exam - 2024 Winter
# CSCI4210U

#### Enter Your details ####
# Student ID: 100590852
# Full name: Syed Arham Naqvi

#### 0. Setup workspace ####
graphics.off()
rm(list=ls())
library(tidyverse)
library(sf)


# Load data file
load(file = file.path('./4210_final/', 'data_exam_final_2024.RData'))


#### Question 1 ####
library(RColorBrewer)
barplot(d_q1, 
        main = "Monthly Deaths from Lung Disease in the UK",
        xlab = "Month",
        ylab = "Total Deaths",
        col = brewer.pal(n = nrow(d_q1), name = "Pastel1"))# Set colors for each group


#### Question 2 ####
d_q2 |> 
  arrange(index) |> 
  ggplot(aes(x=DAX, y=FTSE, colour=index)) +
  geom_abline(slope = 1, colour = "firebrick") +
  geom_point(size=1.5) +
  geom_path(linewidth=1.5) +
  scale_colour_viridis_c() +
  scale_x_continuous(limits = c(1000,6500)) +
  scale_y_continuous(limits = c(1000,6500)) +
  labs(colour = "Time")

#### Question 3 ####
ggplot(d_q3, aes(x = statistic, y = name, fill = scaled_score)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "steelblue", 
                      labels = c("0", "25", "50", "75", "100")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = -45)) +
  labs(title = "NBA player by performance statistic",
       x = "Performance statistic",
       y = "Player",
       fill = "Performance %")
#### Question 4 ####

# PART A
d_q4 <- inner_join(x=d_q4_flights, d_q4_airports, join_by(dest==faa)) |> 
  filter((lon > -130) & (lat > 25)) |> 
  st_as_sf(coords = c("lon", "lat"), crs = 4167, remove = FALSE) |> 
  group_by(dest) |> 
  summarize(n = n())

# PART B
ggplot() +
  geom_sf(data = d_q4_shp, fill = "gray97", colour="black") +
  geom_sf(data = d_q4, aes(colour = n, size = n)) +
  scale_colour_distiller(palette = "PuRd", 
                         breaks = c(min(d_q4$n), max(d_q4$n)/2, max(d_q4$n)),
                         labels = c("Quiet", "Moderate", "Busy")) +
  labs(colour = "Activity",
       title = "Airport business in USA",
       subtitle = "Incoming flight density") +
  theme_light()+
  coord_sf(crs = st_crs(4326)) +
  guides(size = "none")










