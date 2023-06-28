#
# Carefully read the documentation for to figure out how to create a date slider,
# as shown below.sliderInput()
#

library(shiny)

sliderInput(
  "dates",
  "When should we deliver?",
  min = as.Date("2019-08-09"),
  max = as.Date("2019-08-16"),
  value = as.Date("2019-08-10")
)
