# calculate INDEX
<<<<<<< HEAD
calc_index <- function(ndvi_mean,gecon,hazards,pm25,wei_ndvi_mean,wei_gecon,wei_hazards,wei_pm25){
#  wei_hazards <- -wei_hazards
#  wei_pm25 <- -wei_pm25
  return(normalization(sum((ndvi_mean*wei_ndvi_mean),(gecon*wei_gecon),(pm25*wei_pm25),(hazards*wei_hazards),rm.na=T)))
=======
calc_index <- function(ndvi_mean,gecon,hazards,pm25,wei_ndvi_mean,wei_gecon,wei_hazards,wei_pm25,w_mask){
  a_ndvi <- calc(ndvi_mean, function(x) x*wei_ndvi_mean)
  b_gecon <- calc(gecon, function(x) x*wei_gecon)
  c_hazards <- calc(hazards, function(x) x*-wei_hazards)
  d_pm25 <- calc(pm25, function(x) x*-wei_pm25)
  i_stack <- stack(a_ndvi,b_gecon,c_hazards,d_pm25)
  i <- calc(i_stack,sum,na.rm = T)
  i <- mask(i,w_mask)
  i <- normalization(i)
  return(i)
>>>>>>> origin/master
}