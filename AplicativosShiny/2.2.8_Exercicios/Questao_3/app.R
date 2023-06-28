#
# If you have a moderately long list in a selectInput(), it’s useful to create
# sub-headings that break the list up into pieces. Read the documentation to
# figure out how. (Hint: the underlying HTML is called <optgroup>.)
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  selectInput(
    "breed",
    "Select your favorite animal breed:",
    choices =
      list(`dogs` = list('German Shepherd', 'Bulldog', 'Labrador Retriever'),
           `cats` = list('Persian cat', 'Bengal cat', 'Siamese Cat'))
  ),
  textOutput("selectedBreed")
)

server <- function(input, output) {
  output$selectedBreed <- renderText({
    input$breed
  })
}

shinyApp(ui = ui, server = server)
