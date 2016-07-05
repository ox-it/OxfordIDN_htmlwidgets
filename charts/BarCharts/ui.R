library(shiny)
library(shiny)
library(plotly)
library(highcharter)

shinyUI(fluidPage(
  wellPanel(
    HTML(
      paste0(
    "<p>","This template shiny app visualises data published to figshare concerning the number of desktop items on University staff computers, the data is pulled directly from the ","<a href=https://figshare.com/articles/Investigation_into_the_number_of_desktop_items_on_University_staff_computers_broken_down_by_department_and_operating_system_/3425729>figshare repository</a>.","</>",
    "<p>","A thorough overview of the script behind this visualisation is available on ","<a href=https://github.com/ox-it/LiveData_htmlwidgets/tree/master/charts/BarCharts>GitHub</a>,"," you can also see what code is responsible for which operation in this application by selecting \"Show Code\""
      ))
  ),
  sidebarLayout(
    
    sidebarPanel(
      selectInput("chart_library", label = "Chart Library",
                  choices = c("highcharter","plotly")),
      uiOutput("measure_selector"),
      uiOutput("dimension_selector"),
      selectInput("aggregate_function", label = "Aggregate Function",
                  choices = list("Average" = "mean", "Number of Respondants" = "length"))
    ),
    
    mainPanel(
      uiOutput("measure_plot")
    )
    
  )

))