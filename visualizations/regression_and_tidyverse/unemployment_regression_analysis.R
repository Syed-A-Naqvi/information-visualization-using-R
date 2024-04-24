#### 0. Setup Worksapce ####
graphics.off()
rm(list=ls())
library(tidyverse)

# loading the data
d <- read_csv("http://datasets.flowingdata.com/unemployment-rate-1948-2010.csv")

# exploring the data
head(d)
plot(x=d$Year, y=d$Value,
     xlab = "Year", ylab="Unemployment Percentage",
     ylim=c(0,12))

# creating a linear model
m <- lm(d$Value~d$Year)

# overlaying regression line for the linear model
abline(m, col="red", lwd=2)

# summarizing model
summary(m)
  # here the summary indicates there is statistical significance due to a p-value < 0.05
  # however the low R-squared values indicate only 8% of variance in the data is explained by our linear model


#### 0. Setup Worksapce ####
graphics.off()
rm(list=ls())

# loading the data
d <- read_csv("http://datasets.flowingdata.com/unemployment-rate-1948-2010.csv")

# fitting a loess line to the data using scatter.smooth() creates a new plot with loess model by default
  # degree refers to the degree of the polynomial that is fit to the data (scatter.plot() only allows degree=0,1 or 2)
  # span refers to local range of data incorporated into a single fit,
  #   ex, span=0.5: separate fit for first 50% and second 50%
  # lpars parameter takes a list of line characteristics
  line = list(col="red", lwd=3, lty=3)
  scatter.smooth(x=d$Year, y=d$Value, col= "light grey",
                 xlab = "Year", ylab="Percentage Unemployment",
                 degree = 2, span=0.25, lpars = line)
  

#### 0. Setup Worksapce ####
graphics.off()
rm(list=ls())

# loading the data
d <- read_csv("http://datasets.flowingdata.com/unemployment-rate-1948-2010.csv")
  
    
# fitting a loess regressio to our data by first plotting the data and then adding a line afterwards
  # plotting the data normally
  plot(x=d$Year, y=d$Value, col="light grey", ylim = c(0,12))
  # using the lines() function to it a loess regression line
  lines(loess.smooth(d$Year, d$Value, span=0.5, degree = 2), col="red", lty = 3, lwd = 3)

  
  #### 0. Setup Worksapce ####
  graphics.off()
  rm(list=ls())
  
  # loading the data
  d <- read_csv("http://datasets.flowingdata.com/unemployment-rate-1948-2010.csv")
  
  
  # fitting a loess regressio to our data by first plotting the data and then adding a line afterwards
  # plotting the data normally
  plot(x=d$Year, y=d$Value, col="gray40", xlab="Year", ylab="Unemployment Rate (%)", ylim = c(0,12))
  # creating a loess regression model
  mod <- loess(d$Value~d$Year, span = 0.5, degree = 1)
  # using the loess regression model to predict the y-values for each x value
  mod <- predict(mod, se=T)
  lines(d$Year, mod$fit, col="blue", lwd = 3)
  
  # adding 95% confidence interval lines to the plot
  lines(d$Year, mod$fit + qt(0.975,mod$df)*mod$se.fit)
  lines(d$Year, mod$fit - qt(0.975,mod$df)*mod$se.fit)
  
  
  
  