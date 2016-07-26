## ui.R
library(htmltools)
library(DT)
library(plotly)

shinyUI(
  fluidPage(
    wellPanel(includeMarkdown("App_Description.Rmd")),
    plotlyOutput("plotly_timeline"),
    dataTableOutput("selected_PM_Table")
  )
)