# Creates the html file for vizualition of results
col_pal <- brewer.pal(10, "RdBu")
mymap <-  leaflet() %>%
      addTiles() %>%
     setView(lng = 5.66, lat = 51.96, zoom = 5) %>%
     #addRasterImage(raster('data/index10101010.tif'), colors = col_pal, opacity = 0.6,group="Same weights") %>%
    addRasterImage(raster('data/index10050505.tif'), colors = col_pal, opacity = 0.6,group="Greenest") %>%
     addRasterImage(raster('data/index05100505.tif'), colors = col_pal, opacity = 0.6,group="Richest") %>%
     addRasterImage(raster('data/index05051005.tif'), colors = col_pal, opacity = 0.6,group="Less hazards") %>%
     addRasterImage(raster('data/index05050510.tif'), colors = col_pal, opacity = 0.6,group="Less polution") %>%
     addLayersControl(
       baseGroups = c("Same weights", "Greenest", "Richest","Less hazards", 'Less polution'),
       options = layersControlOptions(collapsed = FALSE)
    ) %>%
     addLegend("bottomright", colors= col_pal, labels = c('1','2','3','4','5','6','7','8','9','10'),title="Living Quality Index") 

saveWidget(mymap, file="living-quality-index.html")