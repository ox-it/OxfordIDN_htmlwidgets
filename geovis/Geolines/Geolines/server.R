## =============================== License ========================================
## ================================================================================
## This work is distributed under the MIT license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## Data Source: local file
## ================================================================================

## ==== Packages to load for server

library(shiny) # Some advanced functionality depends on the shiny package being loaded server-side, including plot.ly
library(scales)
library(plyr)
library(lubridate)
library(stringr)
library(DT)

library(maps)
library(mapproj)
library(leaflet)
library(rgdal)
library(GISTools)
library(sp)

## ==== Global Variables (server-side)

## ==== Tab selection variables (these are required to support anchor links, see within shinyServer)
url1 <- url2 <- ""

## ==== shinyServer

shinyServer(function(input, output, session) {
  
  ## =========================== Import Data  =====================================
  ## ==============================================================================
  ## Load data points, FIPS codes and shapefiles
  dated_date_points <-
    read.csv("data/dated_data_points.csv", stringsAsFactors = F)
  dated_date_points$Date <- as.Date(dated_date_points$Date)
  
  fips_codes <-
    read.csv("https://ndownloader.figshare.com/files/5548022", stringsAsFactors = F)
  contiguous_fips_codes <-
    fips_codes[fips_codes$Contiguous.United.States. == "Y", ]
  
  us_congressional_districts_shapefiles <-
    readOGR(dsn = "data/shapefiles/",
            layer = "contiguous_congressional_districts",
            verbose = F)
  
  us_states_shapefiles <-
    readOGR(dsn = "data/shapefiles/",
            layer = "contiguous_states",
            verbose = F)
  
  ## Add State_Names to shapefiles
  contiguous_fips_codes <- fips_codes[fips_codes$Contiguous.United.States. == "Y",]
  us_congressional_districts_shapefiles$State_Name <- mapvalues(us_congressional_districts_shapefiles$STATEFP, 
                                                                from = contiguous_fips_codes$STATE, 
                                                                to = contiguous_fips_codes$STATE_NAME)
  
  ## =========================== UI Elements ======================================
  ## ==============================================================================
  
  output$time_period_of_interest_UI <- renderUI({
    if (is.null(input$show_timeslider)) {
      return()
    }
    
    dates <- dated_date_points$Date
    
    if (input$show_timeslider == TRUE) {
      sliderInput(
        "time_period_of_interest",
        "Time period of interest:",
        min = min(dates),
        max = max(dates),
        step = 1,
        value = c(min(dates), max(dates)),
        width = "800px",
        timeFormat = "%F"
      )
    }
    
  })
  
  ## ======== Filter by Dates and Calculate Shapefile Tallies =====================
  ## ==============================================================================
  
  data_points_between_dates <-
    function(start.year = NA,
             end.year = NA,
             data = NA) {
      data_for_analysis <- data
      if (input$show_timeslider == TRUE) {
        data_for_analysis <-
          data_for_analysis[!is.na(data_for_analysis$Date),]
        
        data_for_analysis$Date <- as.Date(data_for_analysis$Date)
        data_for_analysis <- subset(data_for_analysis,
                                    Date >= start.year &
                                      Date <= end.year)
        data_for_analysis
        
      } else
        data_for_analysis
    }
  
  dated_date_points_SPDF <- reactive({
    data_for_analysis <-
      data_points_between_dates(
        start.year = input$time_period_of_interest[1],
        end.year = input$time_period_of_interest[2],
        data = dated_date_points
      )
    
    SpatialPointsDataFrame(
      coords = data_for_analysis[, c("Longitude", "Latitude")],
      data = data_for_analysis,
      proj4string = us_congressional_districts_shapefiles@proj4string
    )
  })
  
  shapefile_with_tallies <- reactive({
    dated_date_points_SPDF <- dated_date_points_SPDF()
    us_congressional_districts_shapefiles <-
      us_congressional_districts_shapefiles
    
    shapefile_counts <-
      poly.counts(pts = dated_date_points_SPDF, polys = us_congressional_districts_shapefiles)
    shapefile_counts_df <- data.frame(shapefile_counts)
    
    ## Insert counts into the shapefiles
    us_congressional_districts_shapefiles@data$Count.of.locations <-
      shapefile_counts_df$shapefile_counts
    
    # Return for use:
    us_congressional_districts_shapefiles
  })
  
  ## =========================== Generate Choropleth ==============================
  ## ==============================================================================
  ## Generate pretty breaks
  
  pretty_bins <-
    reactive({
      pretty(shapefile_with_tallies()$Count.of.locations)
    })
  ## color.brewer palette
  
  
  output$leaflet_choropleth <- renderLeaflet({
    if (is.null(input$time_period_of_interest)) {
      return()
    }
    
    if (is.null(input$pretty_legend_scale)) {
      return()
    }
    
    shapefile_with_tallies <- shapefile_with_tallies()
    pretty_bins <- pretty_bins()
    
    if (input$pretty_legend_scale) {
      palette <- colorBin(
        brewer.pal(length(pretty_bins) - 1, "YlGnBu"),
        bins = pretty_bins,
        pretty = FALSE,
        # na.color = "#cccccc",
        alpha = TRUE
      )
      
      colors_vector <- brewer.pal(length(pretty_bins) - 1, "YlGnBu")
      labels_vector <- {
        labels_vector <- as.character()
        for (i in 1:{
          length(pretty_bins) - 1
        }) {
          labels_vector <-
            append(labels_vector, paste0(pretty_bins[i], " to ", pretty_bins[i + 1]))
        }
        labels_vector
      }
    } else {
      palette <- colorBin(
        c("#cccccc", brewer.pal(5, "YlGnBu")),
        bins = c(0, 1, 5, 10, 20, 50, 350),
        pretty = FALSE,
        # na.color = "#cccccc",
        alpha = TRUE
      )
      colors_vector <- c("#cccccc",brewer.pal(5, "YlGnBu"))
      labels_vector <- c("0","1-5","5-10","10-20","20-50","50-350")
    }
    
    
    region_labeller <-
      function(state_name = NA,
               number_of_points = NA) {
        paste0("<p>", state_name, "</p>",
               "<p>", number_of_points, "</p>")
      }
    
    
    map <- leaflet(data = shapefile_with_tallies) %>% addTiles()
    map <- map %>% addPolygons(
      stroke = TRUE,
      color = "#000000",
      smoothFactor = 0.2,
      fillOpacity = 0.8,
      fillColor = ~ palette(Count.of.locations),
      weight = 1,
      popup = ~ region_labeller(state_name = State_Name, number_of_points = Count.of.locations)
    )
    map %>% addPolygons(
      data = us_states_shapefiles,
      stroke = TRUE,
      color = "#000000",
      smoothFactor = 0.2,
      weight = 1,
      fill = FALSE
    ) %>% addLegend(
      position = 'topleft',
      ## choose bottomleft, bottomright, topleft or topright
      colors = colors_vector,
      ## Generate labels from pretty_bins
      labels = labels_vector,
      ## legend labels (only min and max)
      opacity = 0.6,
      ##transparency again
      title = "relative<br>amount"
    )
    
    
  })
  
  
})
