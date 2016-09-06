library(shiny)
library(DT)
library(htmltools)
library(rhandsontable)

shinyUI(
  fluidPage(
    h2("Comparing htmlwidget Interactive Tables"),
    wellPanel(includeMarkdown("App_Description.Rmd")),
    selectInput("selected_library", label = "Select library:",
                choices = c("DT","rhandsontable")),
    
    fluidRow(uiOutput("selected_output"))
  )
)
