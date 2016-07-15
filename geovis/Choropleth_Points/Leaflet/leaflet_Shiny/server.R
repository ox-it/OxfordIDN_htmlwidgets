library(shiny)
library(leaflet)
library(scales)

shinyServer(function(input, output) {
  source("data-processing.R", local = T)
  source("visualisation-and-ui.R", local = T)
  
})