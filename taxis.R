setwd("~/Documents/JuliaR")
library(tidyverse)
library(tictoc)

tic("read data")
taxi <- bind_rows(read_csv("yellow_tripdata_2020-01.csv"),
                  read_csv("yellow_tripdata_2020-02.csv"),
                  read_csv("yellow_tripdata_2020-03.csv"),
                  read_csv("yellow_tripdata_2020-04.csv")
)
toc()
tic("summarise data")
taxi %>% 
  mutate(total_distance = passenger_count*trip_distance) %>% 
  select(total_distance, passenger_count, trip_distance) %>%
  group_by(passenger_count) %>%
  summarise(n = n(), total = sum(total_distance))
toc()