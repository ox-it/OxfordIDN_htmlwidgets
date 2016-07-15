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
library(highcharter)
library(plotly)
library(dygraphs)
library(htmltools)

shinyServer(fluidPage(
  titlePanel("Online Labout Index"),
  wellPanel(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur sodales ligula in libero."
  ),
  sidebarLayout(
  sidebarPanel(
    selectInput(
      "selected_occupation",
      label = "Selected Occupation",
      choices = c(
        "Business services",
        "Clerical and data entry",
        "Creative and multimedia",
        "Sales and marketing support",
        "Software development and technology",
        "Writing and translation"
      )
    ),
    selectInput(
      "selected_vizlibrary",
      label = "Visualisation Type",
      choices = c("Dygraph", "Highchart", "Plotly")
    ),
    fluidRow(column(
      img(src = "oii_thumbnail.png", width = "100%", style = "max-width:270px"),
      HTML(
        paste0(
          "<p>Data collected and analysed by Otta Kässi from the Oxford Internet Institute, visualisation developed by Martin Hadley from idn.ox.ac.uk.</p>",
          "<p>The underlying data may be downloaded from here <a href=https://dx.doi.org/10.6084/m9.figshare.3425729.v3>https://dx.doi.org/10.6084/otto-needs-to-upload</a></p>"
        )
      ),
      HTML(
        paste0(
          "<a rel='license' href='http://creativecommons.org/licenses/by/4.0/'><img alt='Creative Commons License' style='border-width:0'
          src='https://i.creativecommons.org/l/by/4.0/88x31.png' /></a>"
        )
      ),
      width = 12
    ))
    
    
    
  ),
  mainPanel(uiOutput("output_plot"))
)))