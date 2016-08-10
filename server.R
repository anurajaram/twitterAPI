palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

shinyServer(function(input, output, session) {
  
  x = 1
  
  # processing to display the user input text again on output pane.
  output$In <- renderText({
    paste("Input Search String =", input$text)
  })
  
  # processing for error/confirmation message
  # the chk_searchterm function returns a string output
  # if the search term returns <5 tweets then we display ERROR message
  # else, success message is displayed.
  output$action <- renderText({
    chk_searchterm(input$text)
    
  })
  
  
  # processing for output graph - bar graphs dispaying sentiment values 
  # for various emotinons - anger, fear,joy, anticipation, etc..
  # if the previous function had returned an ERROR message, then 
  # this block will dispay an EMPTY graph.
  output$plot1 <- renderPlot({ 
      ggplot(data = twitter_senti(input$text), aes(x = sentiment, y = count)) +
      geom_bar(aes(fill = sentiment), stat = "identity") +
      theme(legend.position = "none") +
      xlab("Sentiment") + ylab("Total Count") + ggtitle("Sentiment Graph")

  })
  
  
  # this block displays an image to convey the overall sentiment of the search_term.
  # default = positive.
  output$image2 <- renderImage({
    
    x = twitter_senti(input$text)
    if((x[10,"count"]) < (x[9,"count"]))
    { image_flag = -99 }
    
    if (image_flag == 100) {
      return(list(
        src = "joy_disney.jpg",
        width = 150,
        contentType = "image/jpg",
        alt = "Positive"
      ))
    } else {
      return(list(
        src = "sad_disney.jpg",
        width = 150,
        filetype = "image/jpg",
        alt = "Negative"
      ))
    }
    
  }, deleteFile = FALSE)
  
})

