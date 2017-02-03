# ---- normalization ----
# Normalization function
normalization <- function(raster) {
  min <- minValue(raster)
  max <- maxValue(raster)
  return ((raster-min)/(max-min))
}