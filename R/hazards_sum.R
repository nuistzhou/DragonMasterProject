# Calculate hazards index
hazards_sum <- function(cyclone,drought,earthquake,flood,landslide,volcano) {
  return (overlay(cyclone,drought,earthquake,flood,landslide,volcano,fun=sum,na.rm=T))
}

hazards_sum(r_haz_cyclone,r_haz_drought,r_haz_earthquake,r_haz_flood,r_haz_landslide,r_haz_volcano)
