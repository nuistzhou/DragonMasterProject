# Find top countries for each index
# ras_index is the index raster, world is the spatialDataFrame of world map, ras_world is the world map raster, top_num is the number of top ones
matrix_top <- function(ras_index,world,ras_world,top_num) {

  # Do zonal statistics on raster index based on raster world map
  zonal_index <- zonal(ras_index, ras_world,fun = 'mean',na.rm=T)

  # Give column names to zonal stastics matrix
  colnames(zonal_index) <- c('zone','value')

  # Put country names and codes into a data frame
  df_countries <- as.data.frame(world@data$ADMIN)
  df_countries['code'] <- as.numeric(world@data$ADMIN)
  colnames(df_countries) <- c('country','code')

  # Merge zonal stastics matrix and country information matrix based on country code
  zonal_index <- merge(zonal_index,df_countries,by.x='zone',by.y='code')
  zonal_index <- zonal_index[order(zonal_index$value,decreasing = T),]
  return (zonal_index[1:top_num,])
}