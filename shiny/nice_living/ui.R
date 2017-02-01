#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# Choices for users' preference
setwd('/home/ubuntu/Desktop/Project/shiny/nice_living/data/')
choices <- c(
  "Greener" = "1_0.5_0.5_0.5.tif",
  "Richer" = "0.5_1_0.5_0.5.tif",
  "Breathing" = "0.5_0.5_1_0.5.tif",
  "Diaster Free" = "0.5_0.5_0.5_1.tif"
)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Best living places in the world"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("preference", "Preference", choices) 
    ),
    
    # Show a plot
    mainPanel(
       plotOutput("map")
    )
)
))
