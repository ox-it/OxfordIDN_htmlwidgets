# install.packages("DT")
library(shiny)
library(DT)
library(lubridate)
library(dplyr)
library(rhandsontable)

desktopItems <-
  read.csv(file = "https://ndownloader.figshare.com/files/5360960", stringsAsFactors = FALSE)
desktopItems$Timestamp <-
  mdy_hms(desktopItems$Timestamp, truncated = 2)

shinyServer(function(input, output, session) {
  
  output$datatable <- DT::renderDataTable({
    desktopItems
  },
  filter = 'top', rownames = TRUE,
  options = list(pageLength = 5, autoWidth = TRUE))
  
  output$datatable_selected_row <- renderUI({
    if (is.null(input$datatable_rows_selected)) {
      wellPanel("Select a row in the datatable")
    } else {
      wellPanel(paste(
        "You selected rows n:",
        paste(input$datatable_rows_selected, collapse = ", ")
      ))
    }
  })
  
  output$rhandsontable <- renderRHandsontable({
    rhandsontable(desktopItems, selectCallback = TRUE) %>% hot_col("Desktop.Items", readOnly = TRUE) %>%
      hot_table(highlightCol = TRUE, highlightRow = TRUE) %>%
      hot_cols(columnSorting = TRUE)
  })
  
  output$rhandsontable_selected_row <- renderUI({
    if (is.null(input$rhandsontable_select$select$r)) {
      wellPanel("Select a row in the datatable")
    } else {
      wellPanel(paste(
        "You selected row: ",
        input$rhandsontable_select$select$r
      ))
    }
  })
  
  output$selected_output <- renderUI({
    switch (input$selected_library,
            "DT" = {
              column(uiOutput("datatable_selected_row"),
                     dataTableOutput("datatable"),
                     width = 12)
              
            },
            "rhandsontable" = {
              column(
                uiOutput("rhandsontable_selected_row"),
                rHandsontableOutput("rhandsontable"),
                width = 12
              )
            })
  })
  #
  
  
})