# call source file with all required packages.
source("global.R")


shinyUI(pageWithSidebar(
  # header for the Shiny app
  headerPanel('Twitter Sentiment Analysis'),
  
  # sidebar panel for user input text
  sidebarPanel(
    # Copy the line below to make a text input box
    textInput("text", label = h3("Enter text input/phrase for analysis"), 
              value = "#machinelearning"),
    
   hr(), 
   # marking width = 2 (max = 12) so that we have max space for the output graph
   width = 2
    
  ),
  
  
  # output panel - right hand side
  mainPanel(
    
    # display the search string again
    textOutput("In", container = span),
    hr(),
    
    # confirmation message - if search string is weird and does NOT return 
    # any tweets, we will display the error message in this block
    textOutput("action", container = span),
    hr(),
    
   # display Sentiment analysis output graph and image
   # the output pane is divided into two parts, 
   # 70% assigned to the graph and 30% to the sentiment image.
   fluidRow(
     splitLayout(cellWidths = c("70%", "30%"), plotOutput('plot1') ,
                 imageOutput("image2") )
   )
   
  )
))
