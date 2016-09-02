### Knit all index.Rmd files


all_files <- list.files(include.dirs = T, recursive = T)


all_files[grepl("index.Rmd", all_files)]

library(dplyr)

render_rmd <- function(x){rmarkdown::render(x)}
safe_render <- failwith(NA,render_rmd)

lapply(all_files[grepl("index.Rmd", all_files)], function(x)safe_render(x))