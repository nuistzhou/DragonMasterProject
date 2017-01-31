#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$niceliving <- renderPlot({
    index <- calc_index(ndvi_mean,r_gecon_ppp, r_haz_flood, r_annualpm25,input$ndvi_wei,
               input$haz_wei,input$gecon_wei,input$pm25_wei)
    m <- leaflet(data=index) %>% addTiles
    m
      })
  
})
