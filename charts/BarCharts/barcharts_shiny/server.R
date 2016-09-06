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
library(highcharter)

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
  # replaces dots with spaces to produce more readable column names
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
    
    # bar charts look nicer when sorted by value
    aggregated_data <-
      aggregated_data[order(aggregated_data[, measure_column]), ]
    # Return for use
    aggregated_data
  }

plotly_aggregated_barchart <- function(data = NA,
                                       dimension_column = NA,
                                       measure_column = NA,
                                       aggregate_description = NA,
                                       left_margin = 100,
                                       displayFurniture = T) {
  plot_ly(
    data = data,
    type = "bar",
    y = eval(as.name(dimension_column)),
    x = Desktop.Items,
    orientation = "h"
  ) %>%
    layout(
      xaxis = list(title = aggregate_description),
      yaxis = list(title = ""),
      title = paste0(
        aggregate_description,
        " aggregated by ",
        format_label(dimension_column)
      ),
      margin = list(l = left_margin)
    ) %>%
    config(displayModeBar = displayFurniture)
}

highcharter_aggregated_barchart <- function(data = NA,
                                            dimension_column = NA,
                                            measure_column = NA,
                                            aggregate_description = NA) {
  highchart() %>%
    hc_chart(type = "bar") %>%
    hc_xAxis(categories = data[, dimension_column]) %>%
    hc_add_series(
      name = format_label(dimension_column),
      # bad idea to reverse here since makes the 'spec' for highcharter_aggregated_barchart rather odd
      data = rev(data[, measure_column])
    ) %>%
    hc_yAxis(title = list(text = aggregate_description)) %>%
    hc_title(text = paste0(
      aggregate_description,
      " of desktop items aggregated by ",
      format_label(dimension_column)
    ))
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
  
  output$measure_plot <- renderUI({
    # THIS NEEDS A COMMENT EXPLAINING IT
    switch (
      input$chart_library,
      "highcharter" = highchartOutput("highchart_barchart"),
      "plotly" = plotlyOutput("plotly_barchart")
    )
  })
  
  intermediate_aggregate <- reactive({
    # explain reactive here??
    aggregate_data_for_barchart(
      data = desktopItems,
      dimension_column = input$selected_dimension,
      measure_column = input$selected_measure,
      aggregate_function = eval(input$aggregate_function)
    )
  })
  
  
  output$plotly_barchart <- renderPlotly({
    if (is.null(input$selected_measure)) {
      return()
    }
    
    if (is.null(input$selected_dimension)) {
      return()
    }
    
    if (input$chart_library != "plotly") {
      return()
    }
    
    intermediate_aggregate <- intermediate_aggregate()
    
    plotly_aggregated_barchart(
      data = intermediate_aggregate,
      dimension_column = input$selected_dimension,
      measure_column = input$selected_measure,
      aggregate_description =
        switch (
          input$aggregate_function,
          "mean" = "Average number of desktop items",
          "length" = "Number of respondants"
        ),
      displayFurniture = F
    )
    
  })
  
  output$highchart_barchart <- renderHighchart({
    # THIS NEEDS A COMMENT EXPLAINING IT
    if (is.null(input$selected_measure)) {
      return()
    }
    
    if (is.null(input$selected_dimension)) {
      return()
    }
    
    if (input$chart_library != "highcharter") {
      return()
    }
    
    intermediate_aggregate <- intermediate_aggregate()
    
    highcharter_aggregated_barchart(
      data = intermediate_aggregate,
      dimension_column = input$selected_dimension,
      measure_column = input$selected_measure,
      aggregate_description =
        switch (
          input$aggregate_function,
          "mean" = "Average number of desktop items",
          "sum" = "Total number of desktop items", # just a suggestion
          "length" = "Number of respondants"
        )
    )
    
  })
  
})
