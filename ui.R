#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Capstone Final - Word Predictor"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      helpText("Wait for message on right (Tab - Wait for Message).   Then enter the phrase/sentence/word for which you want to predict the next word. Once filled out, click the button below."),
      textInput("texttoReview", label = ('Please enter some text (min two words)'), value = ''),
      #The action button prevents an action firing before we're ready
      actionButton("getgeo", "Predictions"),
      # Table output
      textOutput("fiveWords")
    ),
    
    # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
        tabPanel("Wait for Message",htmlOutput("textInstructions")),
        tabPanel("Logic", tableOutput("filetable")),  
        tabPanel("Graph", plotOutput("getPlot"))
        #tabPanel("Graph", textOutput("fiveWords"))   
        )  
        
        
      )
    ))
)

