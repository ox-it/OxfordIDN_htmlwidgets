### Check current directory and search upwards

list.files() 

sum(list.files() == 'index.html')

setwd('.')

list.files()



find_css <- function(filename = NA){
  if(sum(list.files() == filename) > 0){
    './gh-pages_global/gh-pages_navbar.css'
  }
}

back_steps <- 0
while (sum(list.files() == 'gh-pages_global') == 0) {
  setwd('..')
  back_steps <- back_steps + 1
}
paste0(paste0(rep('.', back_steps + 1),collapse = ''), '/gh-pages_global/gh-pages_navbar.css', collapse = '')


list.files()
back_steps



this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)