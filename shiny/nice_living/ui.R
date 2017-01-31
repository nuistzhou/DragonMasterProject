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
  titlePanel("Best living places in the world"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("ndvi_wei","Factor of NDVI Influence",
                   min=0,max=1,value=0.5),
       sliderInput("haz_wei","Factor of Hazards Influence",
                   min=0,max=1,value=0.5),
       sliderInput("gecon_wei","Factor of Economic Influence",
                   min=0,max=1,value=0.5),
       sliderInput("pm25_wei","Factor of Air Quality Influence",
                   min=0,max=1,value=0.5)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("niceliving")
    )
  )
))
