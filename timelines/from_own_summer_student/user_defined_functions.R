my_func <- function(a, b){
  paste(
    "Value of a: ",a,
    "Value of b: ",b
  )
}

my_func("this","that")

df <- data.frame(
  "a" = 1:4,
  "b" = 11:14
)


addCircle(popup = ~my_func(University, URL))

