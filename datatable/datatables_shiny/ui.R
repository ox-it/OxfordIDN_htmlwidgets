library(shiny)
library(DT)
library(htmltools)
library(rhandsontable)

shinyUI(
  fluidPage(
    wellPanel(includeMarkdown("App_Description.Rmd")),
    selectInput("selected_library", label = "Select library:",
                choices = c("DT","rhandsontable")),
    
    fluidRow(uiOutput("selected_output"))
    
    # uiOutput("selected_row"),
    # 
    # 
    # DT::dataTableOutput('datatable')
    # 
    
    
  )
)
