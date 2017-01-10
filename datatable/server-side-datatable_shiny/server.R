# install.packages("DT")
library(shiny)
library(DT)

shinyServer(
  function(input, output, session) {
    
    employee <- data.frame(
      "First name" = character(), "Last name" = character(), "Position" = character(),
      "Office" = character(), "Start date" = character(), "Salary" = numeric(),
      check.names = FALSE
    )
    
    output$datatable = DT::renderDataTable(employee, rownames = FALSE, options = list(
      ajax = list(
        serverSide = TRUE, processing = TRUE,
        url = 'https://datatables.net/examples/server_side/scripts/jsonp.php',
        dataType = 'jsonp'
      )
    ))
    
    output$datatable_selected_row <- renderUI({
      if (is.null(input$datatable_rows_selected)) {
        wellPanel("Select a row in the datatable")
      } else {
        wellPanel(paste(
          "You selected the following individuals:",
          paste(input$datatable_rows_selected, collapse = ", ")
        ))
      }
    })
    
    output$selected_row <- renderUI({
      uiOutput("datatable_selected_row")
    })
    
    
  }
)
