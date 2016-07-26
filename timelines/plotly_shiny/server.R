## server.R

library(ggplot2)
library(plotly)
library(lubridate)
library(dplyr)
library(DT)

## =========================== data processing ==================================
## ==============================================================================

source(file = "data-processing.R")

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
  
})