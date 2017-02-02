# ---- hazards_sum ----
# Calculate hazards index
hazards_sum <- function(cyclone,drought,earthquake,flood,landslide,volcano){
  # Calculate the sum of 6 different hazards
  h_stack <- stack(normalization(cyclone),normalization(drought),normalization(earthquake),normalization(flood),normalization(landslide),normalization(volcano))
  h <- calc(h_stack, sum, na.rm = T)
  h[h == 0]<- NA
  return (h)
}
