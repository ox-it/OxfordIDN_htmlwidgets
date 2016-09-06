## =============================== License ========================================
## ================================================================================
## This work is distributed under the MIT license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## Academic Contact: otto.kassi@oii.ox.ac.uk
## Data Source: local file
## ================================================================================


library(shiny)
library(lubridate)
library(plotly)
library(highcharter)
library(dygraphs)
library(xts)
library(dplyr)
library(htmltools)

source("data-processing.R", local = T)

shinyServer(
  function(input, output, session){
    
    plot_data <- reactive({
      gig_economy_data[gig_economy_data$occupation == input$selected_occupation, ]
    })
    
    output$hchart <- renderHighchart({
      plot_data <- plot_data()
      
      open_data <- plot_data[plot_data$status == "open", ]
      closed_data <- plot_data[plot_data$status == "closed", ]
      
      highchart() %>%
        hc_chart(zoomType = "x") %>%
        hc_title(text = "Counts of \"Clerical and Data Entry\" where status is new") %>%
        hc_tooltip(valueDecimals = 0) %>%
        hc_add_series_times_values(open_data$timestamp,
                                   open_data$count,
                                   name = "Open Values") %>%
        hc_add_series_times_values(closed_data$timestamp,
                                   closed_data$count,
                                   name = "Closed Values")
    })
    
    output$plotly_chart <- renderPlotly({
      plot_data <- plot_data()
      
      open_data <- plot_data[plot_data$status == "open", ]
      closed_data <- plot_data[plot_data$status == "closed", ]
      
      plot_ly(
        data = open_data,
        x = timestamp,
        y = count, name = "Open"
      ) %>% add_trace(
        data = closed_data,
        x = timestamp,
        y = count, name = "Closed"
      )
    })
    
    output$dygraph <- renderDygraph({
      
      plot_data <- plot_data()
      
      new_gigs <- plot_data %>% 
        filter(status == "new")
      new_gigs <- xts(new_gigs$count,new_gigs$date)
      
      closed_gigs <- plot_data %>% 
        filter(status == "closed")
      closed_gigs <- xts(closed_gigs$count,closed_gigs$date)
      
      both_ts <- cbind(new_gigs, closed_gigs)
      names(both_ts) <- c("New","Closed")
      
      dygraph(both_ts) %>% dyRangeSelector()
      
    })
    
    output$output_plot <- renderUI({
      switch (input$selected_vizlibrary,
              "Dygraph" = dygraphOutput("dygraph"),
              "Highchart" = highchartOutput("hchart"),
              "Plotly" = plotlyOutput("plotly_chart")
      )
    })
    
  }
)