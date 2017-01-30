# Calculate annual mean NDVI
ndvi_annual_mean <- function(ndvi_data, ndvi_reliability) {
  # Select good quality ndvi data based on the data realibility
  # Removes reliability -1 and 3, no data and clouds
  ndvi_stack <- stack()
  for (i in 1:12) {
    ndvi[[i]] <- overlay(x=ndvi_data[[i]],y=ndvi_reliability[[i]],fun=function(x,y) ifelse(y %in% c(-1,3),NA,x))
    ndvi_stack <- stack(ndvi_stack, ndvi[[i]])
    }
  # Do mean calculation to get annual NDVI stack
  return (calc(ndvi_stack, fun = mean, na.rm = T, filename = 'data/ndvi_mean.tif'))
}