library(shiny)
library(leaflet)

shinyUI(
  fluidPage(sidebarLayout(
    sidebarPanel(
      fluidRow(
        column(uiOutput("map_mouseover"),
      uiOutput("map_click"),
      uiOutput("shape_click"),
      uiOutput("marker_click"),
      uiOutput("marker_mouseover"),width = 12))
    ),
    mainPanel(
      leafletOutput("irelandmap")
    )
  ))
  )
