## =============================== License ========================================
## ================================================================================
## This work is distributed under the MIT license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## Academic Contact: Felix Krawatzek
## Data Source: local file
## ================================================================================

## =========================== Section Title ====================================
## ==============================================================================

output$irelandmap <- renderLeaflet({
  m <- leaflet(leaflet_data) %>%
    addTiles() %>%
    setView(lat = 53.347778,
            lng = -6.259722,
            zoom = 6) %>%
    addCircleMarkers(
      lng = ~ Lon,
      lat = ~ Lat,
      radius = rescale(leaflet_data$latlong.location.tally, to = c(5, 20)),
      popup = paste0(
        "Location Name: ",
        as.character(leaflet_data$PoB..Town.or.Parish.),
        "<br/>",
        "Births at location: ",
        as.character(leaflet_data$latlong.location.tally)
      )
    )
  m
})

output$map_mouseover <- renderUI({
  
  print(input$irelandmap_mouseover$lat)
  HTML(paste0(
    "<p>",
    "map mouseover: lat",
    input$irelandmap_mouseover$lat,
    "</p>"
  )
    )
})

output$map_click <- renderUI({
  HTML(paste0(
    "<p>",
    "map click lat:",
    input$irelandmap_click$lat,
    "</p>"
  ))
})

output$shape_click <- renderUI({
  HTML(paste0(
    "<p>",
    "shape click lat:",
    input$irelandmap_shape_click$lat,
    "</p>"
  ))
})

output$marker_click <- renderUI({
  HTML(paste0(
    "<p>",
    "marker click lat:",
    input$irelandmap_marker_click$lat,
    "</p>"
  ))
})

output$marker_mouseover <- renderUI({
  HTML(paste0(
    "<p>",
    "marker mouseover lat:",
    input$irelandmap_marker_mouseover$lat,
    "</p>"
  ))
})


output$selected_circle <- renderUI({
  # if (is.null(input$ireland_map_popup_click)) {
  #   return()
  # }
  # 
  print(input$irelandmap_hover)
  
  HTML(input$irelandpopup_click)
})