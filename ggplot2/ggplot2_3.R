# Aesthetic mappings, facetting, individual geoms, collective geoms


#initializing environment
graphics.off()
rm(list=ls())
library(tidyverse)


#### 1. Aesthetics ####
# Color
ggplot(mpg, aes(displ,hwy, colour = class, alpha = hwy))+
  geom_point(size=3)
# Shape
ggplot(mpg, aes(displ,hwy, shape=drv))+
  geom_point(size=3)
# Size
ggplot(mpg, aes(displ,hwy, size=cyl))+
  geom_point()

# Alpha Transparency
ggplot(faithfuld, aes(waiting,eruptions, alpha = density))+
  geom_raster(fill="maroon")

# Line Type
ggplot(diamonds, aes(x=depth, fill=cut, colour=cut, linetype=cut)) +
  geom_density(alpha = 0.2, na.rm = TRUE) +
  xlim(58,68) +
  labs(title="Distribution (Kernel Density Estimate) of diamonds dataset")

# coding challenge 1
ggplot(mpg, aes(x = displ, y = hwy, )) +
  geom_point( size = 2) +
  facet_wrap(vars(class))

# class discussion, what happens when you try to facet by a continuous variable
ggplot(mpg, aes(x = displ, y = hwy, )) +
  geom_point( size = 2) +
  facet_wrap(vars(class))
# ggplot treats each unique instance of the cty variable as a separate facet, converting cty to factor makes no difference

#### 3. Individual geoms ####

# Individual geoms are used to represent each observation or row in the data as a separate
# visual element in the plot
# they are also the basic building blocks of ggplot2, useful as standalone elements but can also be used
# in the construction of more complex geoms

d <- tibble(
  x = c(2,7,5,12),
  y = c(4.2, 9.7, 6.1, 8),
  label = c("a", "b", "c", "d")
)

p <- ggplot(d, aes(x = x, y = y, label = label )) + 
  labs(x=NULL, y = NULL) + # hide axis label 
  theme(plot.title = element_text(size = 12))

p1 <- p + geom_point() + ggtitle("point")
p2 <- p + geom_text() + ggtitle("text")
p3 <- p + geom_bar(stat = "identity") + ggtitle("bar")
p4 <- p + geom_tile() + ggtitle("raster")

p5 <- p + geom_line() + ggtitle("line")
p6 <- p + geom_area() + ggtitle("area")
p7 <- p + geom_path() + ggtitle("line")
p8 <- p + geom_polygon() + ggtitle("polygon")

# Collective geoms display multiple observations with one geometric object
# by defaul they map the intersection of discrete variables in the dataset

data(Oxboys, package = "nlme")
head(Oxboys)
Oxboys |> filter(Subject == 1)


#Coding challenge 2

#scatter plot
Oxboys |> 
  ggplot(aes(x=age,y=height)) +
  geom_point() +
  geom_line() +
  ggtitle("We should have connected each person by a line instead of all people of the same age")

# instead of group we can also use color in this case as colouring by subject will force the creating
# of seperate lines per individual
Oxboys |> 
  ggplot(aes(x=age, y=height)) +
  geom_point(aes(colour=Subject)) +
  geom_line(aes(colour=Subject)) +
  geom_smooth()

# Coding challenge 3
Oxboys |> 
  ggplot(aes(x=Occasion, y=height)) +
  geom_boxplot() +
  geom_line(aes(group = Subject, colour = Subject))


# geom_bar
  # for unsummarized data, each observation of a an occurrence contributes a count of 1 which
  # geom_bar() will sum and display as the occurrence bar height
  mpg |> 
    ggplot(aes(x = manufacturer)) +
    geom_bar()
  
  # for summarized data either use geom_bar(stat="identity") or geom_col()
  # this will plot a bar for each occurrence along the x axis with a height
  # equal to the corresponding value in another variable along the y axis
  drug_results <- tribble( ~drug, ~effect,
                           "a", 4.2,
                           "b", 9.7,
                           "c", 6.1)
  
  drug_results |> 
    ggplot(aes(x=drug, y=effect))+
    geom_col()
  

#geom_line and geom_path
  #geom_line() will draw a line between points in order of their x-values
  #geom_path() will draw a line between points in order of appearance in the data
  
  economics1 <- economics |> 
    mutate(unemprate = unemploy/pop)

  economics |> 
    ggplot(aes(x = date, y = uempmed)) +
    geom_line() +
    ggtitle("Median Unemployment Duration in Weeks")
  
  economics1 |> 
    ggplot(aes(x=date, y=unemprate)) +
    geom_line() +
    ggtitle("Unemployment Percentage %")

# coding challenge 1
  economics1 |> 
    ggplot(aes(x=unemprate, y=uempmed)) +
    geom_path(color="grey") +
    geom_point(aes(color = date)) +
    # modify labels
    xlab("Unemployment Rate") +
    ylab("Median Unemployment Duration in Weeks")
  
# outputting plots
  # print() must be used when trying to print multiple plots in a for loop
  # ggsave("plot.png", plot = p, width =5, height = 5) - this will save the plot as a png
  # save to disk as an R data object file using save() or saveRDS()

# Scales
  # control the mapping from data to aesthetics
  # also provide axes and legends to help with reading plot
  ## FORMAL DEFINITION ##
  # scales are a mapping from dataspace to visual aesthetic space and the legends are like
  # the inverse map that allow the visuals to be mapped back to data
  # So, in a sense, aesthetics tell ggplot "what" to change visually based on your data,
  # and scales tell ggplot "how" to change it.
    # so for example, an aesthetic could map values of a variable to colors but the scale
    # would tell which value in the variable maps to which color i.e "how" to map values to colors
    # or the aesthetic could map values to size of a point in a geom_point but the scale would
    # tell ggplot which values correspond to what size
  
  ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes(colour = class))
  # for the above plot, this is what is happening in the background:
  ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes(colour = class)) +
    scale_x_continuous() +
    scale_y_continuous() +
    scale_colour_discrete()
  
  
  
  
  
  
  
  
  
  
  