library(shiny)
library(DT)

shinyUI(
  fluidPage(
    h1('A Table Using Server-side Processing'),
    DT::dataTableOutput('server_queried_DT')
  )
)