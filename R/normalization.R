# Normalization object
normalization <- function(raster) {
  min <- raster@data@min
  max <- raster@data@max
  return ((raster-min)/(max-min))
}