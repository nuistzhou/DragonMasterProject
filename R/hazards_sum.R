# Calculate hazards index
hazards_sum <- function(cyclone,drought,earthquake,flood,landslide,volcano){
  cyclone[is.na(cyclone[])] <- 0
  drought[is.na(drought[])] <- 0
  earthquake[is.na(earthquake[])] <- 0
  flood[is.na(flood[])] <- 0
  landslide[is.na(landslide[])] <- 0
  volcano[is.na(volcano[])] <- 0
  return (sum(cyclone,drought,earthquake,flood,landslide,volcano)
}
