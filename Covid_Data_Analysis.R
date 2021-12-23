library(dplyr)
file<-read.csv("country_vaccinations.csv")
head(file)
countrytable<-as.data.frame(table(file$country))
countrytable
subset(countrytable, countrytable$Var1!= "England" & countrytable$Var1!= "Scotland" & countrytable$Var1!= "Wales" & countrytable$Var1!= "Northern Ireland" )
vaccines<-as.data.frame(table(file$vaccines))
vaccinebycountry<-as.data.frame(table(file$vaccines,file$country))
vaccinebycountry %>%  rename(   vaccine = Var1, country = Var2)
vaccinebycountry<-vaccinebycountry %>%  rename(   Vaccine = Vaccine, region = Country)
map_data<- left_join(map_data,vaccinebycountry,by="region")
mapdata1<-map_data%>% filter(!is.na(map_data$Freq))
map1<-ggplot(mapdata1,aes(x=long,y=lat,group=group))+geom_polygon(aes(fill=mapdata1$Freq),color="black")
map1
 