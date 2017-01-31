# calculate INDEX
calc_index <- function(ndvi_mean,gecon,hazards,pm25,wei_ndvi_mean,wei_gecon,wei_hazards,wei_pm25){
  wei_hazards <- -wei_hazards
  wei_pm25 <- -wei_pm25
  return (normalization(sum((ndvi_mean*wei_ndvi_mean),(gecon*wei_gecon),(pm25*wei_pm25),(hazards*wei_hazards),rm.na=T)))
}