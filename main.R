# Rodrigo Almeida, Ping
# Team Dragon Masters
# 23/01/2017

# Libraries needed
library(raster)
library(tools)
library(rgdal)
library(gdalUtils)
library(rworldmap)

# Runs the python script that downloads data available through WMS
system('python Python/download.py')

# Runs the bash script that downloads the monthly MODIS NDVI data
system('Bash/./modis_ndvi.sh')

# Loads the hazards dataset into memory
hazards <- list.files('data', pattern = 'haz_*', full.names = T)
for (haz in hazards){
  assign(basename(file_path_sans_ext(haz)),raster(haz))
}
# List of hazards datasets
hazards <- basename(file_path_sans_ext(hazards))

# Loads NDVI monthly datasest into memory
ndvi <- list.files('data', pattern = 'NDVI_*', full.names = T)
for (month in ndvi){
  sds <- get_subdatasets(month)
  assign(basename(file_path_sans_ext(month)),raster(sds[1]))
}
# List o NDVI monthly datasets
ndvi <- basename(file_path_sans_ext(ndvi))

# Loads polution dataset into memory
annualpm25 <- raster('data/annualpm25.tif')

# Loads GDP per cell datasets into memory (MER and PPP 2005)
gecon_mer <- raster('data/gecon/mer2005sum.asc')
gecon_ppp <- raster('data/gecon/ppp2005sum.asc')

# Handles the HDF files - NDVI
ndvi_sub <- get_subdatasets(ndvi)
for (month in ndvi_sub){
  
}
r <- raster(sds[1])
