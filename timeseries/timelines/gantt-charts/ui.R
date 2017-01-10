## ui.R
library(htmltools)
library(DT)
library(plotly)
library(timevis)

shinyUI(
  fluidPage(
    wellPanel(includeMarkdown("App_Description.Rmd")),
    selectInput("selected_vis_library",
                label = "Select Library",
                choices = c("plotly","timevis")),
    uiOutput("timeline_ui")
    # plotlyOutput("plotly_timeline"),
    # dataTableOutput("selected_PM_Table")
  )
)
