## server.R

library(ggplot2)
library(plotly)
library(lubridate)
library(dplyr)
library(DT)
library(timevis)

## =========================== data processing ==================================
## ==============================================================================

source(file = "data-processing.R")

label_column <- "Prime.Minister"
category_column <- "Political.Party"

## =========================== Beautification ===================================
## ==============================================================================

gantt_labeler <-
  function(start_date = NA,
           end_date = NA,
           y_axis = NA,
           color = NA) {
    paste0(
      "Prime Minister: ",
      y_axis,
      "</br>",
      "Date Range: ",
      start_date,
      " to ",
      end_date,
      "</br>",
      "Political Party: ",
      color
    )
  }

party_colours <-
  list(
    "Labour" = "#DC241f",
    "Conservatives" = "#0087DC",
    "Liberal Democrat" = "#FDBB30"
  )
party_colours <-
  as.character(party_colours[levels(timeline_data$Political.Party)])

## =========================== Shiny Server =====================================
## ==============================================================================

shinyServer(function(input, output) {
  
  output$timevis_timeline <- renderTimevis({
    timevis_data <- data.frame(
      id = 1:nrow(timeline_data),
      content = timeline_data[,label_column],
      start = timeline_data$Start.Date,
      end   = timeline_data$End.Date,
      type = c(rep("range", nrow(timeline_data))),
      group = timeline_data[,label_column],
      title = as.character(timeline_data[,category_column])
    )
    
    timeline_groups <- data.frame(
      id = levels(timeline_data[,label_column]),
      content = levels(timeline_data[,label_column])
    )
    
    timevis(data = timevis_data, groups = timeline_groups, options = list(editable = FALSE),showZoom = T,fit = TRUE)
    
  })
  
  output$plotly_timeline <- renderPlotly({

    ggplotly(
      ggplot(
        data = timeline_data,
        aes(
          x = Start.Date,
          xend = End.Date,
          y = eval(as.name(label_column)),
          yend = eval(as.name(label_column)),
          colour = eval(as.name(category_column)),
          text = gantt_labeler(
            start_date = Start.Date,
            end_date = End.Date,
            y_axis = eval(as.name(label_column)),
            color = eval(as.name(category_column))
          )
        )
      ) + geom_segment(size = 3) + xlab("Date") + ylab("") + scale_colour_manual(name = "Political Parties", values = party_colours),
      tooltip = "text"
    ) %>% layout(margin = list(l = 190))
    
  })
  
  output$selected_PM_Table <- renderDataTable({
    event_data <- event_data("plotly_click")

    if(is.null(event_data)){
      return()
    }

    selected_PM <- rev(as.character(earliest_date_by_Prime_Minister$Prime.Minister))[event_data$y]

    print(selected_PM)

    print(class(timeline_data$Prime.Minister))

    timeline_data %>% filter(Prime.Minister %in% selected_PM)
  })
  
  output$timeline_ui <- renderUI({
    switch(input$selected_vis_library,
           "plotly" = {
             fluidRow(
               column(
                 plotlyOutput("plotly_timeline"),
                 dataTableOutput("selected_PM_Table"),
                 width = 12
               )
             )
           },
           "timevis" = {
             timevisOutput("timevis_timeline", height = "100%")
           })
  })
  
})