# Calculate annual mean NDVI
ndvi_annual_mean <- function(ndvi_data, ndvi_reliability) {
  # Select good quality ndvi data based on the data realibility
  # Removes reliability -1 and 3, no data and clouds
  ndvi_stack <- stack()
  for (i in 1:12) {
    ndvi[[i]] <- overlay(x=ndvi[[i]],y=ndvi_reliability[[i]],fun=function(x,y) ifelse(y %in% c(-1,3),NA,x))
    ndvi_stack <- stack(ndvi_stack, ndvi[[i]])
    }
  # Do mean calculation to get annual NDVI stack
  return (calc(ndvi_stack, fun = mean, na.rm = T))
}


#ndvi[[1]] <- overlay(x=ndvi[[1]],y=ndvi_reliability[[1]],fun=function(x,y) ifelse(y %in% c(0,2,4),NA,x))
#ndvi_stack <- stack(ndvi_stack, ndvi[[1]])

#ndvi[[2]] <- overlay(x=ndvi[[2]],y=ndvi_reliability[[2]],fun=function(x,y) ifelse(y %in% c(0,2,4),NA,x))
#ndvi_stack <- stack(ndvi_stack, ndvi[[2]])