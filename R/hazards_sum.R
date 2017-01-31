# Calculate hazards index
hazards_sum <- function(cyclone,drought,earthquake,flood,landslide,volcano){
  # Set NA value to 0 to make it both easier and reasonable to calculate and display
  cyclone[is.na(cyclone[])] <- 0
  drought[is.na(drought[])] <- 0
  earthquake[is.na(earthquake[])] <- 0
  flood[is.na(flood[])] <- 0
  landslide[is.na(landslide[])] <- 0
  volcano[is.na(volcano[])] <- 0
  # Calculate the sum of 6 different hazards
  return (sum(normalization(cyclone),normalization(drought),normalization(earthquake),normalization(flood),normalization(landslide),normalization(volcano)))
}
