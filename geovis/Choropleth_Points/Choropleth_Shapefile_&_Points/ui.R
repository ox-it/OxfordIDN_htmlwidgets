## =============================== License ========================================
## ================================================================================
## This work is distributed under the MIT license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## Academic Contact: Felix Krawatzek
## Data Source: local file
## ================================================================================

## ==== Packages to load for server

library(shiny) # Some advanced functionality depends on the shiny package being loaded client-side, including plot.ly
library(leaflet)
library(DT)

## ==== Global Variables (client-side)

library(shinythemes) # Template uses the cerulean theme as it is pretty

shinyUI(fluidPage(
  ## ==== Automatically include vertical scrollbar
  ## ==== This prevents the app from reloading content when the window is resized which would otherwise result in the
  ## ==== appearance of the scrollbar and the reloading of content. Note that "click data" may still be lost during
  ## ==== resizing, as discussed here https://github.com/rstudio/shiny/issues/937
  tags$style(type = "text/css", "body { overflow-y: scroll; }"),
  
  theme = shinytheme("cerulean"),
  
  fluidPage(
    HTML(
      "<h2>Leaflet Choropleth with Timeline Template</h2>"
    ),
    wellPanel(fluidRow(
      column(
      HTML("Foobar"),
      "fpp",
      {example_data_frame <-
        data.frame(
          "Date" = c("\n 13.960129"),
          "Send City" = c("DEU, Mockethal"),
          "Receive Location" = c("50.97178\n 13.960129"),
          "Receive City" = c("DEU, Mockethal"),
          "Date" = c("1800-01-01"),
          "Category" = c("A")
        )
      datatable(example_data_frame,options = list(dom = 't', autowidth = "50%",rownames = FALSE), rownames = FALSE)}
      ,width = 12))),
    
    
    sidebarLayout(
      sidebarPanel(
        checkboxInput("show_timeslider", label = "Filter letters by date sent?", value = TRUE),
        checkboxInput("pretty_legend_scale", label = "Recalculate legend scale as data filtered?", value = FALSE),
        # uiOutput("legend_type_UI"),
        uiOutput("time_period_of_interest_UI")
      ),
      mainPanel(leafletOutput("leaflet_choropleth"))
    )
  )
))