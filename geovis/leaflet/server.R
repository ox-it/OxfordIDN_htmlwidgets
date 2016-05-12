library(shiny)
library(leaflet)

shinyServer(function(input, output) {
  source("data-processing.R", local = T)
  source("visualisation-and-ui.R", local = T)
  
})