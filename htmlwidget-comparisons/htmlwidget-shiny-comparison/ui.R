## ========== htmlwidget library comparisons ====================================
## ==============================================================================

shinyUI(fluidPage(# uiOutput("column_selector"),
  
  uiOutput("group_checks_1"),
  uiOutput("group_checks_2"),
  verbatimTextOutput("group_output"),

  h1("foo"),
  
  wellPanel(fluidRow(
    column(uiOutput("select_columns_ui"), width = 12)
  )),
  
  
  DT::dataTableOutput("summary")))
