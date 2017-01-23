

source('R/download.R')
library(raster)
library(rgdal)
library(gdalUtils)
library(rworldmap)

system('python Python/download.py')
system('Bash/./modis_ndvi.sh')

# Handles the HDF files
sds <- get_subdatasets(list.files('data'))
r <- raster(sds[1])
