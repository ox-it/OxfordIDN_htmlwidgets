library(shiny)
library(plotly)
shinyUI(fluidPage(
  wellPanel(
    "This is a template shiny app that allows users to aggregate and visualise a dataset against multiple categories"
  ),
  sidebarLayout(
    
    sidebarPanel(
      uiOutput("measure_selector"),
      uiOutput("dimension_selector"),
      selectInput("aggregate_function", label = "Aggregate Function",
                  choices = list("Average" = "mean", "Number of Respondants" = "length"))
    ),
    
    mainPanel(
      plotlyOutput("measurePlot")
    )
    
  )

))