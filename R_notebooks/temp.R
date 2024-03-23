#Part 1 - R Notebook

  ## initializing environment
  graphics.off()
  rm(list = ls())
  library(tidyverse)
  library(patchwork)

  # 2.
  d <- read_csv("./w6.csv")

  # 3.
  d <- d |> 
    mutate(Response = factor(Response,
                             levels = c(1,2, 3, 4, 5),
                             labels = c("Never", "Rarely", "Sometimes", "Often", "Always")))
  # 9.
  levels(d$Response) <- c("Not at all", "A little", "Somewhat", "A lot", "PC Load letter?")
  
  # 4.
  d <- d |> 
    mutate(Gender = factor(Gender,
                             levels = c(1,2),
                             labels = c("Women", "Men")))
  
# Part 2 - Plotting
  # 1.
  plot <- d |> 
    ggplot(aes(x="", y=Summary, fill=Response)) +
    geom_col(width = 1, color = "azure2") +
    coord_polar(theta = "y") +
    facet_wrap(~Gender)
  
  # 2.
  plot <- plot +
    scale_fill_brewer(palette = "Blues")
  
  # 3.
  plot <- plot +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank()) +
    scale_y_continuous(breaks = seq(0.1, 1, by = 0.1),
                       labels = scales::percent(seq(0.1, 1, by = 0.1)))
  # 4.
  plot <- plot +
    guides(fill = guide_legend(reverse=TRUE))
  
  # 5.
  plot <- plot +
    theme(legend.position = "bottom",
          legend.text = element_text(size = 10),
          legend.direction = "horizontal")
  
  # 6.
  #install.packages("ggthemes")
  library(ggthemes)    
  
  #7.
  ?ggthemes
  
  # 8.
  plot <- plot + theme_stata()
  plot <- plot + theme_economist_white()    
  
  # 9.
  plot <- plot +
    theme(legend.position = "bottom",
    legend.text = element_text(size = 10),
    legend.direction = "horizontal",
    axis.title.x = element_blank(),
    axis.title.y = element_blank()) +
    labs(title = "A meta-survey: \"How much do you hate surveys?\"")
  plot
  
  