# initialize
graphics.off()
rm(list = ls())
library(tidyverse)
library(patchwork)
library(scales)

#### 1. Scales ####
# overriding the default scales
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  scale_x_log10(limits = c(1.6, 100)) + #instead of the x-axis increment/step size being 1, it'll instead be
                                        # powers of 10 so instead of 1,2,3,4,5 it'll be 10, 100, 1000,...
  #scale_x_continuous(limits = c(1.6, 100)) +
  scale_colour_brewer()  

#### 2. Position scales
ggplot(mpg, aes(x=displ)) +
  geom_histogram(bins = 5)
# equivalent to above:
ggplot(mpg, aes(x=displ, y=after_stat(count))) +
  geom_histogram(bins = 5)

#### 3. Axes ####
p_2008 <- mpg |> 
  filter(year == 2008) |> 
  ggplot(aes(x = displ, y=hwy)) +
  geom_point() +
  labs(title = "2008")

p_1999 <- mpg |> 
  filter(year == 1999) |> 
  ggplot(aes(x = displ, y=hwy)) +
  geom_point() +
  labs(title = "1999")

p_1999 + p_2008

mpg |>
  mutate(year = as_factor(year)) |> 
  filter(year %in% c(2008,1999)) |>
  ggplot(aes(x = displ, y=hwy)) +
  scale_x_continuous(limits = c(0,8)) +
  scale_y_continuous(limits = c(10,45)) +
  geom_point() +
  labs(x = "Engine displ (L)", y = "Highway mileage (MPG)") +
  facet_wrap(~year)
  
# this will set all values outside the limits to NA
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  scale_x_continuous(limits = c(4,7)) + # displacements outside this range will be thrown away
  scale_y_continuous(limits = c(20,45)) # hwy mileages outside this range will be thrown away
#Warning message:
#Removed 213 rows containing missing values (`geom_point()`). 

# this is what is actually happening in the above code:
mpg |> 
  mutate(displ = ifelse(displ < 4 | displ > 7, NA, displ),
         hwy = ifelse(hwy < 20 | hwy > 45, NA, hwy)) |> 
  ggplot(aes(x = displ, y = hwy)) +
  geom_point()


# this is a true zoom where the outlying data is not thrown away
mpg |> 
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  coord_cartesian(xlim = c(4,7), ylim = c(20,45))

# setting breaks
# no breaks
mpg |> 
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL)

# custom breaks
mpg |> 
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  scale_x_continuous(breaks = c(2,3,7), minor_breaks = c(2.5,3.5)) +
  scale_y_continuous(breaks = c(20,40), minor_breaks = c(10, 30))

# advanced breaks
economics |> 
  filter(date < lubridate::ymd("1970-01-01")) |> 
  ggplot(aes(x = date, y = pce)) +
  geom_line() +
  scale_x_date(NULL,
               breaks = scales::breaks_width("3 months"),
               labels = scales::label_date_short()) +
  scale_y_continuous("Personal Consumption Expendatures",
                     breaks = scales::breaks_extended(n=8),
                     labels = scales::label_dollar())


#labels
mpg |> 
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  scale_x_continuous(breaks = seq(min(mpg$displ), max(mpg$displ), by = (max(mpg$displ)-min(mpg$displ))/2),
                     labels = c("small", "medium", "large"))

# advanced labels
mpg |> 
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  scale_x_continuous(breaks = seq(min(mpg$displ), max(mpg$displ), by = (max(mpg$displ)-min(mpg$displ))/2),
                     labels = scales::label_percent(scale = 10))

# as RGB is not perceptually unifrom, two colors one unit apart can appear VERY similar or VERY different
# for this reason a popular color scheme for information visualization is HCL: Hue, Chroma, Luminance
  # hue is a number between 0-360 which gives the color of the colour, blue, red, orange...
  # Chroma is the purity of the colour, 0 is grey and mac value varies with luminance
  # Luminance is the lightness of the colour, 0 is black and 1 is white

  # Hues are arranged around a colour wheel and are not perceived as ordered: green is not larger than
    # say red and blue is not in between green and red
  # both chroma and luminance are perceived as ordered. pink would be between red and white while grey
    # is between black and white

#coding challenge 1







