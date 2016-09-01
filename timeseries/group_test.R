## =========================== group test ====================================
## ==============================================================================
library(timevis)

dataGroups <- data.frame(
  id = 1:11,
  content = c("Open", "Open",
              "Open", "Open", "Half price entry",
              "Staff meeting", "Open", "Adults only", "Open", "Hot tub closes",
              "Siesta"),
  start = c("2016-05-01 07:30:00", "2016-05-01 14:00:00",
            "2016-05-01 06:00:00", "2016-05-01 14:00:00", "2016-05-01 08:00:00",
            "2016-05-01 08:00:00", "2016-05-01 08:30:00", "2016-05-01 14:00:00",
            "2016-05-01 16:00:00", "2016-05-01 19:30:00",
            "2016-05-01 12:00:00"),
  end   = c("2016-05-01 12:00:00", "2016-05-01 20:00:00",
            "2016-05-01 12:00:00", "2016-05-01 22:00:00", "2016-05-01 10:00:00",
            "2016-05-01 08:30:00", "2016-05-01 12:00:00", "2016-05-01 16:00:00",
            "2016-05-01 20:00:00", NA,
            "2016-05-01 14:00:00"),
  group = c(rep("lib", 2), rep("gym", 3), rep("pool", 5), NA),
  type = c(rep("range", 9), "point", "background")
)

str(dataGroups)

groups <- data.frame(
  id = c("lib", "gym", "pool"),
  content = c("Library", "Gym", "Pool")
)

timevis(data = dataGroups, groups = groups, options = list(editable = FALSE))

## =========================== Section Title ====================================
## ==============================================================================

dataGroups <- data.frame(
  id = 1:10,
  content = timeline_data$Prime.Minister[1:10],
  start = c("2016-05-01 07:30:00", "2016-05-01 14:00:00",
            "2016-05-01 06:00:00", "2016-05-01 14:00:00", "2016-05-01 08:00:00",
            "2016-05-01 08:00:00", "2016-05-01 08:30:00", "2016-05-01 14:00:00",
            "2016-05-01 16:00:00", "2016-05-01 19:30:00"),
  end   = c("2016-05-01 12:00:00", "2016-05-01 20:00:00",
            "2016-05-01 12:00:00", "2016-05-01 22:00:00", "2016-05-01 10:00:00",
            "2016-05-01 08:30:00", "2016-05-01 12:00:00", "2016-05-01 16:00:00",
            "2016-05-01 20:00:00",
            "2016-05-01 14:00:00"),
  group = c(levels(timeline_data$Prime.Minister)[1:10]),
  type = c(rep("range", 10))
)

levels(timeline_data$Prime.Minister)[1:10]

groups <- data.frame(
  id = levels(timeline_data$Prime.Minister)[1:10],
  content = levels(timeline_data$Prime.Minister)[1:10]
)

timevis(data = dataGroups, groups = groups, options = list(editable = FALSE))

## =========================== Section Title ====================================
## ==============================================================================

# timeline_data <- timeline_data[rev(rownames(timeline_data)),]
# nrow(timeline_data)

as.character(timeline_data$Prime.Minister)

dataGroups <- data.frame(
  id = 1:nrow(timeline_data),
  content = timeline_data$Prime.Minister,
  start = timeline_data$Start.Date,
  end   = timeline_data$End.Date,
  group = c(as.character(timeline_data$Prime.Minister)),
  type = c(rep("range", nrow(timeline_data)))
)

groups <- data.frame(
  id = levels(timeline_data$Prime.Minister),
  content = levels(timeline_data$Prime.Minister)
)

timevis(data = dataGroups, groups = groups, options = list(editable = FALSE))

## =========================== Section Title ====================================
## ==============================================================================

timevis_data <- data.frame(
  "id" = 1:nrow(timeline_data),
  "content" = timeline_data$Prime.Minister,
  "start" = timeline_data$Start.Date,
  "end" = timeline_data$End.Date,
  "group" = levels(timeline_data$Prime.Minister),
  "type" = rep("range", nrow(timeline_data)),
  stringsAsFactors = T
)
str(timevis_data)



pms_df <- data.frame(
  id = levels(timeline_data$Prime.Minister),
  content = levels(timeline_data$Prime.Minister)
)
str(pms_df)

timevis(timevis_data, groups = political_parties)
