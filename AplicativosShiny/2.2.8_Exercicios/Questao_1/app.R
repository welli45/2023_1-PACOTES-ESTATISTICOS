#
# When space is at a premium, it’s useful to label text boxes using a
# placeholder that appears inside the text entry area. How do you call to
# generate the UI below? textInput()
#

library(shiny)

ui <- fluidPage(
  textInput("text", "", placeholder = "Your name")

)

server <- function(input, output) {
  output$greeting <- renderText({
    paste0(input$text)
  })
}

shinyApp(ui, server)
