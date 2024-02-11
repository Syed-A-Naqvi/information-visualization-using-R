#### 0. Setup Worksapce ####
graphics.off()
rm(list=ls())
library(tidyverse)

#### 1. Read Csv ####
d <- read_csv("./unemployment-rate-1948-2010.csv")

#### 2. Create Scatter Plot ####
plot(d$Year, d$Value, xlab="Year", ylab="Value")

#### 3. Create a linear model ####
m <- lm(d$Value~d$Year)

#### 4. Create a linear model ####
abline(m, col="red", lwd=2)

#### 5. Create a linear model ####
summary(m)

# the F-statistic of 66 and the p-value far below 0.05 indicate that the
# linear model is statistically significant and the unemployment rate in the US
# has seen an overall increase but the very low R-squared value indicates that
# this linear model explains very little of the variance in the data.
# this means that although the model does indicate a statistically significant
# relation between the variables Year and Value, it is a poor fit to the data,
# explaining very little variance

#### 6. Local Regression fit ####
scatter.smooth(x = d$Year, y = d$Value)
abline(m,col="red")

#### 7. adjusting the degree, span and line stylings for scatter.smooth() ####
scatter.smooth(x = d$Year, y = d$Value,
               degree = 2, span = 0.25,
               col="light grey", lpars=list(col="red", lwd = 3, lty = 3))

# a better approach would be to create the plot first and then add lines
plot(x = d$Year, y = d$Value, col="light grey")
lines(loess.smooth(x = d$Year, y = d$Value, span = 0.5, degree = 2),
      col="red", lty = 3, lwd = 3)


#### 0. Setup Worksapce ####
graphics.off()
rm(list=ls())
library(tidyverse)

#### creating a local regression model ####
  # 1. Loading data
  d <- read_csv("./unemployment-rate-1948-2010.csv")
  
  # 2. plotting the data
  plot(x = d$Year, y = d$Value, xlab = "Year(y)", ylab = "Unemployment rate (%)",
       col = "gray40")
  
  # 3. creating the local regression model - here we are just fitting the data
  mod <- loess(d$Value ~ d$Year, span = 0.5, degree = 1)

  # 4. adding the local regression line to the plot
  lines(mod, col = "blue2", lwd = 3, lty = 3)

  # 1. Loading data
  d <- read_csv("./unemployment-rate-1948-2010.csv")
  
  # 2. plotting the data
  plot(x = d$Year, y = d$Value, xlab = "Year(y)", ylab = "Unemployment rate (%)",
       col = "gray40")
  
  # 3. creating the local regression model - here we are predicting values
  mod <- predict(loess(Value ~ Year, data = d, span = 0.5, degree = 1), se=T)
  
  # 4. adding the local regression line to the plot
  lines(d$Year, mod$fit, col = "blue2", lwd = 3)




