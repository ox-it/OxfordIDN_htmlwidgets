# library(devtools)
# # install_github('rstudio/htmltools')
# # install_github('ramnathv/htmlwidgets')
# # install_github('htmlwidgets/knob')

library(shiny)
library(knob)

shinyServer(function(input, output){
  output$gauge <- renderKnob(knob(
    value = input$value,
    min = 0,
    max = 200,
    angleArc = input$angleArc,
    angleOffset = -90,
    fgColor="#66CC66"
  ))
}
)