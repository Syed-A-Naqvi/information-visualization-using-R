#setup workspace
graphics.off()
rm(list=ls())
library(tidyverse)

# Part 1.
  # 1.
  # loading the data and creating the scatter plot
  d <- cars
  plot(x = d$speed,
       y = d$dist,
       xlab = "speed (mph)",
       ylab = "stoppping distance (ft)",
       main = "Effect of car speed on stopping distance")
  
  # 2.
  # creating the simple linear model by overlaying a line of best fit
    abline(lm(d$dist ~ d$speed), col='red' , lwd=2)
    
# Part 2.
    # 3.
    # creating a LOESS regression fit for the data
    loess_fit <- loess(d$dist ~ d$speed)
    # Predict y values and standard errors using the loess model
    loess_pred <- predict(loess_fit, se = TRUE)
    y_pred <- loess_pred$fit
    se_fit <- loess_pred$se.fit
    
    # 4
    # Add the loess smooth line
    lines(d$speed, y_pred, col = "blue2", lwd = 3)
    
    # 5
    # overlaying the 95% confidence interval using "blue2", line weight 1 and dashed line type
    # Add the 95% confidence interval
    lines(d$speed, y_pred + qt(0.975, loess_pred$df)*se_fit, col = "blue", lwd = 1, lty = "dashed")
    lines(d$speed, y_pred - qt(0.975, loess_pred$df)*se_fit, col = "blue", lwd = 1, lty = "dashed")
    
    
    
    
    