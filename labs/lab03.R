# setup
graphics.off()
rm(list=ls())
library(tidyverse)

# Part 1. Preparing the data
  #1. Exploring the Diamonds dataset
  ?diamonds
  
  #2. reducing dimensionality
  dim(diamonds)
  d <- sample_n(diamonds, 1000) |> 
    arrange(carat)
  
  #3. scatterplot where x is carat and y is price
  plot(x=d$carat, y=d$price, xlab = "Carat", ylab = "Price (USD)", main = "Diamond Prices by Carat")
  
# Part 2. Modelling the data
  #4. creating a linear model predicting price from carat
  m <- lm(d$price ~ d$carat)
  abline(m, col="red")
  
  #5. Statistical summary of model
  summary(m)
    # 86.55% percent of variance explained by this linear model
    # p-value < 0.00000001, 

  #6. creating a loess model
  mod <- loess(d$price ~ d$carat)
  yfit <- predict(mod, se = TRUE)
  lines(x= d$carat, y = yfit$fit, col = "purple", lty = 3, lwd = 3)
  
  #8. adding 95% confidence intervals
  lines(d$carat, mod$fit + qt(0.975, yfit$df)*yfit$se.fit)
  lines(d$carat, mod$fit - qt(0.975, yfit$df)*yfit$se.fit)
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  