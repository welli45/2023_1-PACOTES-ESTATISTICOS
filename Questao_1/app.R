#
# When space is at a premium, it’s useful to label text boxes using a
# placeholder that appears inside the text entry area. How do you call to
# generate the UI below? textInput()
#

library(shiny)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  passwordInput("password", "What's your password?"),
  textAreaInput("story", "Tell me about yourself", rows = 3)
)
