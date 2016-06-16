## =============================== License ========================================
## ================================================================================
## This work is distributed under the MIT license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## Data Source: https://ndownloader.figshare.com/files/5360960
## ================================================================================

library(shiny)
library(plotly)

## =========================== Import Data --====================================
## ==============================================================================

desktopItems <-
  read.csv(file = "https://ndownloader.figshare.com/files/5360960")

measure_columns <- c("Desktop.Items")
dimension_columns <-
  c("Operating.System",
    "University.Department",
    "University",
    "Country")

## ======================= Utility Functions ====================================
## ==============================================================================

format_label <- function(dimension) {
  gsub(pattern = "[.]",
       replacement = " ",
       x = dimension)
}

aggregate_data_for_barchart <-
  function(data = NA,
           dimension_column = NA,
           measure_column = NA,
           aggregate_function = NA) {
    aggregated_data <-
      aggregate(data = data,
                eval(as.name(measure_column)) ~ eval(as.name(dimension_column)),
                FUN = aggregate_function)
    colnames(aggregated_data) <- c(dimension_column, measure_column)
    
    aggregated_data <-
      aggregated_data[order(aggregated_data[, measure_column]),]
    # Return for use
    aggregated_data
  }

plotly_aggregated_barchart <- function(
  data = NA,
  dimension_column = NA,
  measure_column = NA,
  aggregate_description = NA,
  left_margin = 100,
  displayFurniture = T
) {
  plot_ly(
    data = data,
    type = "bar",
    y = eval(as.name(dimension_column)),
    x = Desktop.Items,
    orientation = "h"
  ) %>%
    layout(
      xaxis = list(title = "Number of respondants"),
      yaxis = list(title = ""),
      title = paste0(
        aggregate_description," aggregated by ",
        format_label(dimension_column)
      ),
      margin = list(l = left_margin)
    ) %>%
    config(displayModeBar = displayFurniture)
}

## =========================== Shiny Server =====================================
## ==============================================================================

shinyServer(function(input, output, session) {
  output$measure_selector <- renderUI({
    selectInput("selected_measure", label = "Select Measure",
                choices = measure_columns)
  })
  
  output$dimension_selector <- renderUI({
    selectInput("selected_dimension",
                label = "Select Dimension",
                choices = dimension_columns)
  })
  
  output$measurePlot <- renderPlotly({
    if (is.null(input$selected_measure)) {
      return()
    }
    
    if (is.null(input$selected_dimension)) {
      return()
    }
    
    print("foo")
    
    intermediate_aggregate <- aggregate_data_for_barchart(
      data = desktopItems,
      dimension_column = input$selected_dimension,
      measure_column = input$selected_measure,
      aggregate_function = eval(input$aggregate_function)
    )
    
    plotly_aggregated_barchart(
      data = intermediate_aggregate,
      dimension_column = input$selected_dimension,
      measure_column = input$selected_measure,
      aggregate_description = "Mean number of desktop items",
      displayFurniture = F
    )
    
  })
  
})