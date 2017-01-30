# Calculate hazards index
hazards_sum <- function(cyclone,drought,earthquake,flood,landslide,volcano) {
  return (overlay(cyclone,drought,earthquake,flood,landslide,volcano,fun=sum,na.rm=T))
  
}
