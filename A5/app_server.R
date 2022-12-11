#This is my app_server file where I will perform a majority of my calculations

co2_file <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")


library(dplyr)
library(ggplot2)

#Seeing the highest producers since 2000 
highest_producers <- co2_file %>% 
  filter(year > "1970", country != "World" , country != "Non-OECD (GCP)",
         country != "Asia",country != "Asia (GCP)", country != "Upper-middle-income countries",
         country!= "High-income countries", country != "OECD (GCP)", country != "North America",
         country != "North America (GCP)", country != "Europe", country != "Europe (GCP)",
         country != "Asia (excl. China and India)", country != "Lower-middle-income countries",
         country != "European Union (27)", country != "Africa" , country != "Africa (GCP",
         country != "European Union (28)", country !=  "European Union (27) (GCP)",
         country != "Europe (excl. EU-27)" , country != "Middle East (GCP)", 
         country != "Europe (excl. EU-28)", country != "Africa (GCP)") %>%
  arrange(-co2, -year)

#From this we can pull three relevant values of interest
# Firstly, I would like to find average for countries over the years.
#I would also like to reveal the most co2 and least produced by each
#country since 1970.
countries_since_1970 <- highest_producers %>% 
 select(country,year,co2) %>%
 group_by(country) %>% 
 summarize(average_co2 = mean(co2, na.rm = TRUE),
           max_co2 = max(co2, na.rm = TRUE),
           min_co2 = min(co2, na.rm = TRUE)) %>% 
arrange(-average_co2, -max_co2, -min_co2)







