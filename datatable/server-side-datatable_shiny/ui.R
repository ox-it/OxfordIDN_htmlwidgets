library(shiny)
library(DT)

shinyUI(
  fluidPage(
    h2("Server-Side datatable Shiny App"),
    wellPanel(includeMarkdown("App_Description.Rmd")),
    uiOutput("selected_row"),
    DT::dataTableOutput('datatable')
  )
)