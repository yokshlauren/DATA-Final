#Lauren Yoksh DATA 824 Final Project Due 07/22/25
library(shiny)
library(UsingR)
library(ggplot2)

shinyUI(pageWithSidebar(
  headerPanel("Explore the Dimensions of Black Cherry Trees"),
  sidebarPanel(
    h4('Generate a Scatterplot'),
    h6('Choose the variables for the x and y axes to create a scatterplot.'),
    selectInput("x","x-axis Variable",
                       choices=names(trees),
                selected="Height"),
    selectInput("y","y-axis Variable",
                 choices=names(trees),
                selected = "Volume"),
    actionButton("plot_button","Create Plot"),
    h4('Dimension Distributions'),
    h6('Choose an attribute and specify the number of bins to create a histogram.'),
    selectInput("hist_var","Attribute",
                choices=names(trees),
                selected="Girth"),
    sliderInput("bins","Number of bins",value=10,min=1,max=50,step=1),
    actionButton("hist_button","Create Histogram"),
    h4('Cherry Tree Size Prediction'),
    h6('Choose values for tree height and diameter to predict its volume.'),
    numericInput("height","Enter height value", value=50,min = 50,max=100),
    numericInput("girth","Enter diameter value", value=10,min=5,max=25),
    actionButton("predict_button", "Predict volume")
  ),
  mainPanel(
    plotOutput("newScat"),
  plotOutput("newHist"),
  h3("Predicted Volume:"),
  verbatimTextOutput("predicted"))
))
