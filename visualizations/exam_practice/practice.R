#### 0. Setup wrokspace ####
graphics.off()
rm(list=ls())
library(tidyverse)
library(patchwork)
library(sf)
library(maps)
library(GGally)

## Setting working directory
setwd("./exam_practice/")

### 1. Timeseries and Regression with Base R ###
d <- read_csv("./data/hot-dog-contest-winners.csv")
d <- d |>
  rename(dogs_eaten = `Dogs eaten`,
         new_record = `New record`)

# Styling the bar graph
barplot(d$dogs_eaten, names.arg = d$Year, col = "#821122", border = NA, 
          xlab = "Year",
          ylab = "Hotdogs and buns (HDB) Eaten")

## Line plot - World population
d <- read_csv("./data/world-population.csv")

# Basic Line graph
plot(x=d$Year, y=d$Population, type = "b", ylim=c(2e9,8e9),
     xlab = "Year", ylab = "Population", main = "World Population Growth",
     sub = "Source: UN Department")

# linear model
m <- lm(mpg$cty~mpg$displ)

# scatter plot
plot(mpg$displ, mpg$cty, xlab = "Engine Displacement (Liters)", ylab = "City Milage (mpg)")

# overlay line of best fit
abline(m, col="firebrick")

# summary of model
summary(m)

## LOESS regression
d <- read_csv("./data/unemployment-rate-1948-2010.csv")

# LOESS Method 1 - scatter.smooth
scatter.smooth(x = d$Year, y = d$Value, span = 0.5, degree = 2, col = "black",
               lpars = list(col = "firebrick", lwd = 3, lty = 3))

# LOESS Method 2 - Plot & lines
plot(x = d$Year, y=d$Value, col="lightgrey")
# add loess line
lines(loess.smooth(d$Year, d$Value, span = 0.5, degree = 2), col = "firebrick", lty = 3, lwd = 3)

#### 2. ggplot2 basics ####
ggplot(diamonds, aes(x = depth, fill = cut)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE) +
  xlim(50, 75)

# Facet
ggplot(diamonds, aes(x = depth, fill = cut)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE) +
  xlim(50, 75) +
  theme(legend.position = "none") +
  facet_wrap(vars(clarity), scales = "free")

#### 3. Scales ####
# Add unemployment rate
economics <- economics |> 
  mutate(unemprate = unemploy/pop)
# Plot timeseries data of unemployment rate
ggplot(economics) +
  geom_line(aes(x = date, y = unemprate)) +
  labs(title = "Unemployment rate", x = "Date", y = "Percentage Unemployment")  

# Path plot - With viridis colour scale for continuous data
ggplot(economics, aes(x = unemprate, y = uempmed, color = date)) +
  geom_path() +
  geom_point() +
  scale_color_viridis_c() +
  labs(title = "Contrasting unemployment rate and duration")  
# the distance of the path along the x dimension represents the rate of unemployment in the population while the distance along
# the y axis represents the median duration of unemployment. As the color of the path goes from purple to yellow, we are moving
# forward in time

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = class)) +
  scale_x_continuous() +
  scale_y_continuous() +
  scale_color_viridis_d()

erupt <- ggplot(faithfuld, aes(x = waiting, y = eruptions, fill = density)) +
  geom_raster() +
  scale_x_continuous("waiting time (mins)", expand = c(1,5)) +
  scale_y_continuous("eruption duration (mins)", expand = c(1,5))

erupt + scale_fill_viridis_c(option = "magma")
erupt + scale_fill_distiller(palette = "PiYG")
erupt + scale_fill_gradient(low = "white", high = "red")

# scale_colour_brewer() and scale_fill_brewer() are the discrete ColourBrewer scale functions
# scale_colour_distiller() and scale_fill_distiller() are the continuous versions, there is also scale_colour/fill_fermenter()

d <- read_csv("./data/poll_data.csv") |> 
  mutate(Issue = as_factor(Issue),
         Opinion = as_factor(Opinion))

opinion <- ggplot(d, aes(x = Proportion, y = Issue, fill = Opinion)) +
  geom_col(position = "dodge") +
  scale_x_continuous(expand = c(0.01,0))

# discrete manual colour scale
opinion + scale_fill_manual(values = c("darkgreen", "darkred", "darkgrey"))
# discrete - viridis colour scale
opinion + scale_fill_viridis_d(option = "D")
# colour brewer
opinion + scale_fill_brewer(palette = "YlOrRd")


#### 4. Themes ####
#Themed MPG
ggplot(mpg, aes(x=cty, y=hwy)) +
  geom_jitter(size=3, aes(colour=factor(cyl))) +
  geom_smooth(method = "lm", col = "blue") +
#  geom_abline(slope = 1, intercept = 0, col="grey50", lwd = 2) +
  scale_x_continuous(name="City mileage/gallon", limit = c(0,40), expand = c(0,0)) +
  scale_y_continuous(name="Highway mileage/gallon", limit = c(0,50), expand = c(0,0)) +
  scale_colour_brewer(name="Cylinders", type = "div") +
  ggtitle("Highway and City Mileage are Highly Correlated") +
  theme_bw() +
  theme(plot.title = element_text(face="bold", size = 18),
        legend.background = element_rect(fill="red", linewidth = 1, colour = "black"),
        legend.justification = c(0.5,0.5),
        legend.position = c(0.1,0.8),
        legend.key = element_rect(fill = "black"),
        plot.background = element_rect(fill = "red"),
        axis.ticks = element_line(colour = "grey70", linewidth = 0.2),
        panel.grid.major = element_line(colour = "darkgreen", linewidth = 0.2),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "black"),
        panel.border = element_rect(colour = "darkgreen", linewidth = 2))

#### 5. Proportions #####
d <- tibble(Area = c("Statistics", "Design", "Business", "Cartography", "Information Science", "Web Analytics",
                     "Programming", "Engineering", "Mathematics", "Other"),
            Votes = c(172, 136, 135, 101, 80, 68, 50, 29, 19, 41)) |>
  mutate(VotesScaled = Votes/sum(Votes)*100,
         Area = factor(Area, levels = (Area))) |> 
  mutate(pol_alpha = scales::alpha("#61041D", seq(from = 1, to = 0.2, length = n())))

ggplot(d, aes(x="", y = VotesScaled, fill = Area)) +
  geom_bar(stat = "identity", colour = "aliceblue", linewidth = 0.25) +
  coord_polar(theta = "y", direction = -1) +
  labs(x=NULL, y=NULL, title = "Field of study of visitors to FlowingData.com") +
  scale_fill_manual(values = d$pol_alpha) +
  theme(panel.grid = element_blank(),
        axis.text = element_blank())

# Stacked Timeseries
data(uspopage, package = 'gcookbook')
# scale data
uspopage |> 
  group_by(Year) |> 
  mutate(Thousands = Thousands/sum(Thousands)) |> 
  ggplot(aes(x = Year, y = Thousands)) +
  geom_area(aes(fill = AgeGroup), colour = 'black', linewidth = 0.2) +
  scale_fill_brewer(palette = "Blues") +
  guides(fill = guide_legend(reverse = FALSE))
  
  
  
  
  














