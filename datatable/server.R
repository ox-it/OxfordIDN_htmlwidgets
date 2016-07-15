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
    
    output$tbl_a = DT::renderDataTable(iris, server = FALSE)
    output$server_queried_DT = DT::renderDataTable(employee, rownames = FALSE, options = list(
      ajax = list(
        serverSide = TRUE, processing = TRUE,
        url = 'https://datatables.net/examples/server_side/scripts/jsonp.php',
        dataType = 'jsonp'
      )
    ))
  }
)