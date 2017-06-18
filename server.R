#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#



#source('all_sessions.R', local=TRUE)
#source("final_fun.R")



library(shiny)
library("ggplot2")
library("plyr")
library("stringr") # Needed for last step

#getCorpFile()

#Bi_Data <- read.csv("Bi_Data.csv")
#Tri_Data <- read.csv("Tri_Data.csv")
#Quad_Data <- read.csv("Quad_Data.csv")
#Pent_Data <- read.csv("Pent_Data.csv")
#Sext_Data <- read.csv("Sext_Data.csv")

#print(str(Sext_Data))


shinyServer(function(input, output) {
  
  
  
  output$textInstructions <- renderUI({
    HTML("<h4><ul>
         <li>Information is Ready to Be Processed.</li>
         <li>Enter at least two words.</li>
         </ul></h4>"
    )
  })
  
  #This function is the one that is triggered when the action button is pressed
  #Pressing the button triggers the actions.
  geodata <- observeEvent(input$getgeo , { 
    if (input$getgeo == 0) return(NULL)
    #This previews the CSV data file
    txtDatatoReview <- ReviewText(input$texttoReview)
    getGraph <- graphData(txtDatatoReview)
    txtFiveTopWords <- FinalTopFiveWords2(txtDatatoReview)
    #txtFiveTopWords <- 'test'
    colnames(txtDatatoReview) <- c('Words Matched','Count','Number of Words Matched')
    
    
    
    output$getPlot <- renderPlot( {
      
      ggplot(getGraph, aes(x=getGraph[,1], y=getGraph[,2])) +
        geom_bar(stat='identity',fill="blue", colour="black") +
        xlab("Word") +  ylab("Count") +
        coord_flip() +
        scale_fill_hue() +
        theme_bw()
      
    })
    
    
    output$filetable <- renderTable({
      #filedata()
      txtDatatoReview
    })
    
    output$fiveWords <- renderText({
      #filedata()
      txtFiveTopWords
      
    })
    
    
    
  })  
  
  })



   
  
