library(shiny)
library(knob)

shinyUI(fluidPage(
  sliderInput('value', 'Value', 0, 200, 50),
  sliderInput('angleArc', 'Arc Angle', 45, 360, 180),
  knobOutput('gauge')
))


