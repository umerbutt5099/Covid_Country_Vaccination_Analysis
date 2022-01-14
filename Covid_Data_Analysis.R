library(dplyr)
library(ggplot2)
file<-read.csv("country_vaccinations.csv")
head(file)
countrytable<-as.data.frame(table(file$country))
countrytable
subset(countrytable, countrytable$Var1!= "England" & countrytable$Var1!= "Scotland" & countrytable$Var1!= "Wales" & countrytable$Var1!= "Northern Ireland" )
vaccines<-as.data.frame(table(file$vaccines))
vaccinebycountry<-as.data.frame(table(file$vaccines,file$country))
colnames(vaccinebycountry)<-c('Vaccine','region','Frequency')


WorldData <- map_data('world') %>% filter(region != "Antarctica") %>% fortify


p <- ggplot() +
  geom_map(data = WorldData, map = WorldData,
           aes(x = long, y = lat, group = group, map_id=region),
           fill = "white", colour = "blue", size=0.5) + 
  geom_map(data = vaccinebycountry, map=WorldData,
           aes(map_id=region),
           colour="green", size=0.5) +
  coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
  scale_fill_continuous( ) +
  scale_y_continuous() +
  scale_x_continuous() +
  labs(fill="Vaccines", title="Covid Vaccine Distribution", x="Longitude", y="Latitude") +
  theme_bw()

p






