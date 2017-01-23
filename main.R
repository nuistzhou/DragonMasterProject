
library(raster)
library(tools)
library(rgdal)
library(gdalUtils)
library(rworldmap)

system('python Python/download.py')
system('Bash/./modis_ndvi.sh')

hazards <- list.files('data', pattern = 'haz_*', full.names = T)
for (haz in hazards){
  assign(basename(file_path_sans_ext(haz)),raster(haz))
}
hazards <- basename(file_path_sans_ext(hazards))




# Handles the HDF files
sds <- get_subdatasets(list.files('data'))
r <- raster(sds[1])
