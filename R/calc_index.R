# calculate INDEX
calc_index <- function(ndvi_mean,gecon,harzards,pm25,wei_ndvi_mean,wei_gecon,wei_harzards,wei_pm25){
  return (sum((ndvi_mean*wei_ndvi_mean),(gecon*wei_gecon),(pm25*wei_pm25),(harzards*wei_harzards),rm.na=T))
}
