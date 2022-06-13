library(osmdata)
library(tidyverse)
library(ggplot2)
library(ggmap)
library(sf)

bbox_Sydney <- getbb("Sydney CBD, Australia")

map <- get_stamenmap(bbox = bbox_Sydney,
                           maptype = "toner-lite",
                           zoom=15)
ggmap(map)+
  theme_void()

streets <- opq(bbox_Sydney) %>% 
  add_osm_feature(key='highway') %>% 
  osmdata_sf() 
streets <- streets$osm_lines


train <- opq(bbox_Sydney) %>% 
  add_osm_feature(key='railway', value = 'rail') %>% 
  osmdata_sf() 
train <- train$osm_lines

station <- opq(bbox_Sydney) %>% 
  add_osm_feature(key='railway', value = 'station') %>% 
  osmdata_sf() 
station <- station$osm_points


ggplot()+
  geom_sf(data=streets, size=.1, color='grey')+ #(color=maxspeed)
  geom_sf(data=train)+
  geom_sf(data=station)+
  theme_void()

