
library(htmlwidgets)
library(leaflet)

mymap <-  leaflet() %>%
      addTiles() %>%
#      urlTemplate = "//{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png",
 #     attribution = 'Maps by <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
#    ) %>%
    #      setView(lng = 52.52, lat = 13.40, zoom = 4) %>%
     addRasterImage(raster('data/0.5_0.5_0.5_1.tif'), colors = rainbow(10), opacity = 0.8,group="Hazards Free") %>%
     addRasterImage(raster('data/1_0.5_0.5_0.5.tif'), colors = rainbow(10), opacity = 0.8,group="Greener") %>%
     addRasterImage(raster('data/0.5_1_0.5_0.5.tif'), colors = rainbow(10), opacity = 0.8,group="Richer") %>%
     addRasterImage(raster('data/0.5_0.5_1_0.5.tif'), colors = rainbow(10), opacity = 0.8,group="Breathing") %>%
     addLayersControl(
       baseGroups = c("Greener", "Richer", "Breathing","Hazards Free"),
       options = layersControlOptions(collapsed = FALSE)
    )

saveWidget(mymap, file="mymap.html")

