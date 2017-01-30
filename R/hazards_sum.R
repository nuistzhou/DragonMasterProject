# Calculate hazards index
hazards_sum <- function(cyclone,drought,earthquake,flood,landslide,volcano,boundary) {
  haz_list <- c(cyclone,drought,earthquake,flood,landslide,volcano)
  for (haz in haz_list) {
    haz <- mask(haz,boundary)
  }
  return (overlay(cyclone,drought,earthquake,flood,landslide,volcano,fun=sum,na.rm=T))
}
