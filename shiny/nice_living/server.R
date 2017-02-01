#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(raster)
library(shiny)
library(leaflet)
setwd('/home/ubuntu/Desktop/Project/shiny/nice_living/data')
# Loading raster layers
# Define server logic required to draw a histogram
shinyServer(function(input,output) {
   output$map <- renderLeaflet({
    leaflet() %>%
      addTiles(
        urlTemplate = "//{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
      ) %>%
#      setView(lng = 52.52, lat = 13.40, zoom = 4) %>%
      addRasterImage(raster(input$preference), colors = "red", opacity = 0.8,group="baseGroups",project=T) %>%
      addLayersControl(
      baseGroups = c("Greener", "Richer", "Breathing","Hazards Free"),
      options = layersControlOptions(collapsed = FALSE)
  )
 
  })
})