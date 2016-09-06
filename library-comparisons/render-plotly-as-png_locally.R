## =========================== Section Title ====================================
## ==============================================================================

## Credit to http://stackoverflow.com/a/36604170/1659890

library(plotly)
library(webshot)
library(htmlwidgets)
library(ggplot2)

## Not run: 
data(economics, package = "ggplot2")
# basic time-series plot
p <- plot_ly(economics, x = date, y = uempmed, type = "scatter", 
             showlegend = FALSE)

saveWidget(as.widget(p), "temp.html")
webshot("temp.html", file = "test.png",
        cliprect = "viewport")