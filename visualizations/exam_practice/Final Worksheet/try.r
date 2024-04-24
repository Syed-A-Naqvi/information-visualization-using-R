# loading Libaries 
library(tidyverse)
library(maps)
library(socviz)
library(ggthemes)
library(sf)
library(ozmaps)

map_packages <- c("tidygeocoder", "sf", "ozmaps", "maps", "mapdata", 
                  "mapproj","rgdal","rmapshaper", "devtools")
install.packages(map_packages)

# Elections dataset and more (not an official CRAN package)
devtools::install_github("kjhealy/socviz")

load('W6-8.RData')

#Part 1 LINEAR REGRESSION
mpg |> ggplot(aes(x=displ,y=hwy,colour=factor(cyl), fill=factor(cyl)))+
  geom_point()+
  geom_smooth(method=lm,alpha=0.1)+
  scale_x_continuous(name = "Engine Displacement(Litres)")+
  scale_y_continuous(name = "Highway mileage (miles/gallon")+
  ggtitle("THE LONG TITLE")+
  labs(color='# of Cylinders')+guides(fill = FALSE)+
  labs(caption = "Figure 1")

  

d_p3


# part 3
m=c("Never","Rarely","Sometimes","Often","Always")
d_p3$Response<-d_p3$Response |> replace(d_p3$Response==1,"Never") |> 
  replace(d_p3$Response==2,"Rarely") |> 
  replace(d_p3$Response==3,"Sometimes") |> 
  replace(d_p3$Response==4,"Often") |> 
  replace(d_p3$Response==5,"Always")
d_p3$Response<-factor(d_p3$Response)


d_p3$Gender<-d_p3$Gender |> replace(d_p3$Gender==1,"women") |> 
  replace(d_p3$Gender==2,"men")
  
d_p3$Gender<-factor(d_p3$Gender)
d_p3

d_p3 |> ggplot(aes(x="",y=Summary,fill=Response))+
  geom_bar(width = 1, stat = "identity") + 
  coord_polar(theta ="y")+facet_wrap(~Gender)

# Part 4 CORRELATION PLOTS
ggcorr(mtcars, label = TRUE, palette = "RdBu", nbreaks = 9,label_size=3.5,label_alpha = TRUE,
       name = expression(Correlation~italic(rho) ))+ggtitle("PART 4")








#Part 5



d_ny<-map_data("county") |> filter(region =='new york') |> 
  select(lon = long, lat, group, region = subregion) |> 
  as_tibble() 

d_ny

d_ny |> 
  ggplot(aes(x = lon, y = lat,group=group,fill = factor(region)))+
  geom_polygon(colour = "grey20", linewidth = 0.2)+ 
  coord_map()+
  scale_fill_viridis_d(option="C")+
  guides(fill = "none")+ |>
  ggtitle("PART 5")



#Part 6 – sf maps
oz_states
oz_states<-ozmap_data('states') |> filter(NAME!='Other Territories')

ggplot(oz_states)+
  geom_sf(aes(fill = NAME),colour = 'grey20', linewidth = 0.2)+
  geom_sf_label(aes(label = NAME), nudge_x = 0.5, nudge_y = 0.5, alpha = 0.7)+
  scale_fill_viridis_d()+
  guides(fill = "none")+
  coord_sf(crs = st_crs(7844))+
  ggtitle("PART 6")

