# Summary of data of a raster layer

summary_data <- function(raster_list){
  out <- c()
 
  for(elem in raster_list){
    info <- c(elem, elem@data@names, elem@class[1], elem@extent@xmin,elem@extent@xmax, elem@extent@ymin, elem@extent@ymax, elem@crs@projargs, res(elem),elem@data@min,elem@data@max )
    out <- rbind(out,info)
  }
  out.names <- c('raster', 'name', 'class', 'xmin', 'xmax', 'ymin', 'ymax', 'projargs', 'resx', 'resy', 'data_min', 'data_max')
  colnames(out) <- out.names
  rownames(out) <- out[,'name']
  out <- subset(out, select = -name)
  return(out)
}