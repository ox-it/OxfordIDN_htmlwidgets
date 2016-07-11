library(ggplot2)
library(shiny)
library(DT)

shinyUI(fluidPage(
  wellPanel("Select items in the gantt chart below to get information about the policy selected"),
  plotOutput(
    "timeline",
    click = "timeline_click",
    hover = hoverOpts(id = "timeline_hover")
  ),
  DT::dataTableOutput("data_table")
))