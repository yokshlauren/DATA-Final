#Lauren Yoksh DATA 824 Final Project Due 07/22/25
library(shiny)
library(UsingR)
library(ggplot2)


shinyServer(
  function(input,output){
    scatplot <- eventReactive(input$plot_button,{
     ggplot(trees, aes_string(x=input$x,y=input$y))+
        geom_point(position="jitter",alpha=1/2, size=4,color="violetred3")+
        xlab(input$x) +
        ylab(input$y) +
        ggtitle(paste("Scatterplot of", input$x, "vs.", input$y)) +
        theme(axis.text = element_text(size = 14),
              axis.title = element_text(size = 16),
              plot.title = element_text(size = 20, face = "bold"))
    })
    output$newScat <- renderPlot({scatplot()})
    
    histplot <- eventReactive(input$hist_button,{
      ggplot(trees, aes_string(input$hist_var)) +
        geom_histogram(bins = input$bins, fill="sienna4",alpha=0.75) +
        xlab(input$hist_var) +
        ggtitle(paste("Histogram of", input$hist_var)) +
        theme(axis.text = element_text(size = 14),
              axis.title = element_text(size = 16),
              plot.title = element_text(size = 20, face = "bold"))

    })
    output$newHist <- renderPlot({histplot()})
    
    predicted_value <- eventReactive(input$predict_button,{
      new_data <- data.frame(
        Height = input$height,
        Girth = input$girth
      )
      model <- lm(data=trees, Volume ~ Height + Girth)
      predict(model, new_data)
    })
    
    output$predicted <- renderText({input$predict_button
      predicted_value()
    })
  }
)