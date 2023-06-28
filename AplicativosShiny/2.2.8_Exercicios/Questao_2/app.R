#
# Carefully read the documentation for sliderInput() to figure out how to
# create a date slider, as shown below.
#

library(shiny)
ui <- fluidPage(
  sliderInput(
  "dates",
  "When should we deliver?",
  min = as.Date("2019-08-09"),
  max = as.Date("2019-08-16"),
  value = as.Date("2019-08-10")
  )
)

server <- function(input, output) {
  output$selectedDate <- renderText({
    as.character(input$dates)
  })}

shinyApp(ui, server)
