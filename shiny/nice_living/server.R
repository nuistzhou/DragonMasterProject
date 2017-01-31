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
  dataInput <- reactive(  
  tif_files <- list.files('data', pattern = '*', full.names = T)
  for (tif in tif_files){
            assign(basename(file_path_sans_ext(tif)),raster(tif))
            source('calc_index.R')}
    )
  })
    output$niceliving <- renderPlot({
    dataInput()
    index <- calc_index(ndvi_mean_m,r_gecon_ppp_m,haz_comp_m, r_annualpm25_m,input$ndvi_wei,
               input$haz_wei,input$gecon_wei,input$pm25_wei)
    m <- leaflet(data=index) %>% addTiles %>%
      addLegend(pal=qpal,values=index$data,opacity=1)
    m
      })
})