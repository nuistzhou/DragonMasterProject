
library(htmlwidgets)
library(leaflet)
library(RColorBrewer)
col_pal <- brewer.pal(10, "RdBu")
mymap <-  leaflet() %>%
      addTiles() %>%
     setView(lng = 5.66, lat = 51.96, zoom = 5) %>%
     addRasterImage(raster('data/0.5_0.5_0.5_1.tif'), colors = col_pal, opacity = 0.6,group="Hazards Free") %>%
     addRasterImage(raster('data/1_0.5_0.5_0.5.tif'), colors = col_pal, opacity = 0.6,group="Greener") %>%
     addRasterImage(raster('data/0.5_1_0.5_0.5.tif'), colors = col_pal, opacity = 0.6,group="Richer") %>%
     addRasterImage(raster('data/0.5_0.5_1_0.5.tif'), colors = col_pal, opacity = 0.6,group="Breathing") %>%
     addLayersControl(
       baseGroups = c("Greener", "Richer", "Breathing","Hazards Free"),
       options = layersControlOptions(collapsed = FALSE)
    ) %>%
     addLegend("bottomright", colors= col_pal, labels = c('1','2','3','4','5','6','7','8','9','10'),title="Living Quality Index") 

saveWidget(mymap, file="mymap1.html")

