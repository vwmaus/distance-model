
library(gmapsdistance)
library(tidyverse)
library(measurements)

plants <- c("Innsbruck", "Salzbutg") 

markets <- c("Linz", "Graz", "Vienna") 

# The distance is returned in meters
results <- gmapsdistance::gmapsdistance(origin = plants, destination = markets, mode = "driving", 
                        dep_date = "2017-12-31", dep_time = "00:00:00") 

# Convert distance from meters to km and create distance matrix 
d <- results$Distance %>% 
  dplyr::select(-or) %>% 
  measurements::conv_unit(from = "m", to = "km") %>% 
  dplyr::bind_cols(tibble::tibble(` ` = results$Distance$or), .) 

d <- rbind(c(NA, markets), d) 

# Write distances to csv file 
readr::write_csv(x = d, path = "./distance.csv", col_names = FALSE, na = "") 

# Write demand to csv file 
tibble::tibble(markets, c(150, 200, 550)) %>% 
  readr::write_csv(path = "./demand.csv", col_names = FALSE, na = "") 

# Write capacity to csv file 
tibble::tibble(plants, c(500, 300)) %>% 
  readr::write_csv(path = "./capacity.csv", col_names = FALSE, na = "") 

