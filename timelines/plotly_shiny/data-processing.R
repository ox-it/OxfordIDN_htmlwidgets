## data-processing.R

timeline_data <- read.csv(file="https://ndownloader.figshare.com/files/5533448")
timeline_data$Start.Date <- dmy(timeline_data$Start.Date)
timeline_data$End.Date <- dmy(timeline_data$End.Date)
timeline_data <- timeline_data[!is.na(timeline_data$End.Date) & !is.na(timeline_data$Start.Date),]
label_column <- "Prime.Minister"
category_column <- "Political.Party"
earliest_date_by_Prime_Minister <-
  timeline_data[timeline_data$Start.Date == ave(timeline_data$Start.Date, timeline_data$Prime.Minister, FUN =
                                                  min), ]
earliest_date_by_Prime_Minister <-
  earliest_date_by_Prime_Minister[order(
    earliest_date_by_Prime_Minister$Start.Date,
    earliest_date_by_Prime_Minister$Prime.Minister), ]

timeline_data$Prime.Minister <-
  factor(timeline_data$Prime.Minister, levels = rev(as.character(unique(earliest_date_by_Prime_Minister$Prime.Minister))))


## =========================== Need list of prime ministers =====================
## ==============================================================================




as.character(unique(earliest_date_by_Prime_Minister$Prime.Minister))


