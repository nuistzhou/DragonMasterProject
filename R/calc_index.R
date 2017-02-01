# calculate INDEX
calc_index <- function(ndvi_mean,gecon,hazards,pm25,wei_ndvi_mean,wei_gecon,wei_hazards,wei_pm25){
  a_ndvi <- calc(ndvi_mean, function(x) x*wei_ndvi_mean)
  b_gecon <- calc(gecon, function(x) x*wei_gecon)
  c_hazards <- calc(hazards, function(x) x*-wei_hazards)
  d_pm25 <- calc(pm25, function(x) x*-wei_pm25)
  i <- sum(a_ndvi,b_gecon,c_hazards,d_pm25)
  i <- normalization(i)
  return(i)
}