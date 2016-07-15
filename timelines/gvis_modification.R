gvisTimeline <- function(data, rowlabel="", barlabel="", tooltip="", start="",end="", options=list(), chartid){
  my.type <- "Timeline"
  dataName <- deparse(substitute(data))
  my.options <- list(gvis=modifyList(list(width=600, height=200),options), dataName=dataName,data=list(rowlabel=rowlabel, barlabel=barlabel,tooltip=tooltip, start=start, end=end,allowed=c("number", "string", "date", "datetime"))
  )
  checked.data <- gvisCheckTimelineData(data, rl=rowlabel, bl=barlabel, tt=tooltip, start=start, end=end)
  output <- gvisChart(type=my.type, checked.data=checked.data, options=my.options,chartid=chartid, package="timeline") 
  return(output)
}

gvisCheckTimelineData <- function(data, rl, bl, tt, start, end){
  if(any(c(rl, bl, tt, start, end) %in% ""))
    return(data)
  else  
    return(data[, c(rl, bl, tt, start, end)])
}