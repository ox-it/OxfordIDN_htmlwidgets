## =============================== ReadMe ========================================
## ================================================================================
## This file is used to rebuild all pages for this Github Pages site from the index.Rmd files contained within.
## Note that additional tools are commented out.
## ================================================================================


all_files <- list.files(include.dirs = T, recursive = T)
index_rmds <- all_files[grepl("index.Rmd", all_files)]

# Open all files
# invisible(lapply(index_rmds, function(x)file.edit(x)))

# failwith from dplyr allows failures to be ignored during a build 
library(dplyr)
render_rmd <- function(x){rmarkdown::render(x)}
safe_render <- failwith(NA,render_rmd)

render_output <- unlist(lapply(index_rmds, invisible(safe_render)))

failures <- index_rmds[which(is.na(unlist(render_output)))]
successes <- index_rmds[which(!is.na(unlist(render_output)))]

output <- list("success" = successes, "failure" = failures)
output

# Knit 404 page

safe_render("404.Rmd")
