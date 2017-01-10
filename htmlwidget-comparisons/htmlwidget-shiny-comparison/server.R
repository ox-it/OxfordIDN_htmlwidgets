## ========== htmlwidget library comparisons ====================================
## ==============================================================================

library(DT)
library(shiny)

source("data-processing.R", local = TRUE)




shinyUI(function(input, output) {
  
  output$group_checks_1 <- renderUI({
    checkboxGroupInput(
      "checks_1",
      label = "Select Visualisations",
      choices = 1:5,
      inline = FALSE,
      selected = 1
    )
  })
  
  output$group_checks_2 <- renderUI({
    checkboxGroupInput(
      "checks_1",
      label = "Select Visualisations",
      choices = c(3,4,10),
      inline = FALSE,
      selected = 3
    )
  })
  
  output$group_output <- renderUI({
    print(input$checks_1)
    
    HTML(paste(input$checks_1))
  })
  
  
  output$select_columns_ui <- renderUI({
    checkboxGroupInput(
      "selected_columns",
      label = "Select Visualisations",
      choices = as.list(setNames(viz_types, gsub(
        "[.]", " ", viz_types
      ))),
      inline = FALSE,
      selected = c("Barchart", "Gantt.Chart", "Choropleth")
    )
  })
  
  output$summary <- DT::renderDataTable({
    datatable(
      viz_by_library[, c("Library", input$selected_columns)],
      filter = list(
        position = 'top',
        clear = TRUE,
        plain = TRUE
      ),
      rownames = F,
      options = list(paging = FALSE, searching = FALSE)
    )
    
  })
  
})
