xlsx_convert_import <- function(inputFile = NA, outputFile = NA, stringsAsFactors = FALSE){
  if(file.exists(outputFile)){
    imported_data <<- read.csv(outputFile, stringsAsFactors = stringsAsFactors)
  } else {
    library(xlsx)
    xlsx_import <- read.xlsx(inputFile, sheetIndex = 1)
    write.csv(xlsx_import, file = outputFile, row.names = FALSE)
    remove(xlsx_import)
    imported_data <<- read.csv(outputFile, stringsAsFactors = stringsAsFactors)
  }
}
  
viz_by_library <-
  xlsx_convert_import(inputFile = "data/chart-type_htmlwidget-libraries.xlsx", outputFile = "chart-type_htmlwidget-libraries.csv")
viz_by_library

# viz_by_library[viz_by_library==1] <- "<span class='glyphicon glyphicon-ok' aria-hidden='true'></span>"
# viz_by_library[viz_by_library==0] <- "<span class='glyphicon glyphicon-remove' aria-hidden='true'></span>"
# viz_by_library[is.na(viz_by_library)] <- "<span class='glyphicon glyphicon-question-sign' aria-hidden='true'></span>"

viz_by_library[viz_by_library == 1] <- 'YES'
viz_by_library[viz_by_library == 0] <- "NO"
viz_by_library[is.na(viz_by_library)] <- "?"
viz_by_library[viz_by_library == "Future"] <- "FUTURE"

viz_types <-
  colnames(viz_by_library)[2:length(colnames(viz_by_library))]


viz_by_category <- xlsx_convert_import(inputFile = "data/chart-type_utilityxlsx.xlsx", output = "data/chart-type_category.csv", stringsAsFactors = FALSE)

viz_by_category %>% str()

viz_by_category[!is.na(viz_by_category$Categorical.Data.Comparison),1]








