library(legislatoR)
library(leaflet)
library(dplyr)
library(htmltools)
library(tidyverse)

usaCore <- get_core(legislature = "usa_house")

a <- c("a, b, c" , "d, e, f")
str_split_fixed(a, ",", n = 2)

usaCore$latBirth <- as.numeric(str_split_fixed(usaCore$birthplace, ",", n = 2)[,1])
usaCore$lngBirth <- as.numeric(str_split_fixed(usaCore$birthplace, ",", n = 2)[,2])

usaCore$latDeath <- as.numeric(str_split_fixed(usaCore$deathplace, ",", n = 2)[,1])
usaCore$lngDeath <- as.numeric(str_split_fixed(usaCore$deathplace, ",", n = 2)[,2])

usaDf <- usaCore |>
  select(1:5, 13:16)

leaflet(data = usaDf) |>
  addTiles() |>
  addCircleMarkers( lng = ~lngBirth,
                    lat = ~latBirth,
                    color = "red",
                    radius = 0.2,
                    label = ~name,
                    group = "Born in"
  ) |>
  addCircleMarkers( lng = ~lngDeath,
                    lat = ~latDeath,
                    color = "blue",
                    radius = 0.2,
                    label = ~name,
                    group = "Died in"
  ) |>
  addLayersControl(overlayGroups = c("Born in", "Died in"),
                   options = layersControlOptions(collapsed = FALSE))



