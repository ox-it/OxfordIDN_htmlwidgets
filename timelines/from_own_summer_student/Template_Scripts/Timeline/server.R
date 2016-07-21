ininsinsins
library(ggplot2)
library(shiny)
library(DT)



imported_timeline_data <- read.csv("timeline_data.csv")

timeline_data <- imported_timeline_data
timeline_data$Valid.From <- as.Date(timeline_data$Valid.From)
timeline_data$Valid.To <- as.Date(timeline_data$Valid.To)

timeline_data <-
  timeline_data[order(timeline_data$Valid.From, timeline_data$Name.of.Policy), ]
# timeline_data$Unique.ID <- as.factor(nrow(timeline_data):1)

## =========================== Sort by earliest date ====================================
## ==============================================================================

aggregate(data = timeline_data, Name.of.Policy ~ Valid.From, FUN = sort)
## Find earliest date for each policy
earliest_date_by_Name_of_Policy <-
  timeline_data[timeline_data$Valid.From == ave(timeline_data$Valid.From, timeline_data$Name.of.Policy, FUN =
                                                  min),]
## Force order by date then Name.of.Policy
earliest_date_by_Name_of_Policy <-
  earliest_date_by_Name_of_Policy[order(
    earliest_date_by_Name_of_Policy$Valid.From,
    earliest_date_by_Name_of_Policy$Name.of.Policy
  ), ]

## Reorder the levels in Name.of.Policy for the gantt chart
timeline_data$Name.of.Policy <-
  factor(timeline_data$Name.of.Policy, levels = rev(levels(
    earliest_date_by_Name_of_Policy$Name.of.Policy
  )))

shinyServer(
  function(input, output, session){
    
    output$timeline <- renderPlot({
      
      ggplot(timeline_data, aes(x=Valid.From, xend=Valid.To, y=Name.of.Policy, yend=Name.of.Policy, colour=Type)) +
        geom_segment(size=3) + 
        xlab("Date") + ylab("Name of Policy")
      
    })
    
    selected_row_of_ordered_policies <- reactive({
      print("ffoo")
      row <- round(length(levels(timeline_data$Name.of.Policy)) + 1 - input$timeline_click$y)
      row
    })
    

    output$data_table <- DT::renderDataTable({
      if (is.null(input$timeline_click)){
        return()
      }
      
      selected_row_of_ordered_policies <- selected_row_of_ordered_policies()
      selected_policy <- earliest_date_by_Name_of_Policy[selected_row_of_ordered_policies,]$Name.of.Policy
      timeline_data[timeline_data$Name.of.Policy == selected_policy,]
    })
    
  }
)