## Import
data_import <- read.csv(file = "villi-data.csv",skipNul = TRUE, stringsAsFactors = F)
## Drop those rows where count is NA
data_import <- data_import[!is.na(data_import$count),]

## =========================== Format Data =====================================
## ==============================================================================
library(lubridate)
data_import$timestamp <- dmy(data_import$timestamp)

gig_economy_data <- data_import

## =========================== Highcharter ====================================
## ==============================================================================

library(highcharter)

highchart() %>% 
  hc_title(text = "Lynda Views") %>% 
  hc_tooltip(valueDecimals = 0) %>% 
  hc_add_series_times_values(gig_economy_data$timestamp,
                             gig_economy_data$count,
                             name = "Interactive Dashboards with Shiny")
