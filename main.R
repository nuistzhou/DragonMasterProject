# Rodrigo Almeida, Ping
# Team Dragon Masters
# 23/01/2017

# ---- setup ----
# Installs necessary requirements
print('---- Starting setup ----')

if(!require(raster) | !require(tools) | !require(rgdal) | !require(gdalUtils) | !require(rworldmap) | !require(cleangeo) | !require(gdata)| !require(leaflet)| !require(htmltools)| !require(RColorBrewer)) {
 install.packages(c('raster','tools','rgdal','gdalUtils','rworldmap', 'rworldxtra', 'cleangeo','gdata','leaflet', 'htmlwidgets', 'RColorBrewer'))
}

# Libraries needed
library(raster)
library(tools)
library(rgdal)
library(gdalUtils)
library(rworldmap)
library(cleangeo)
library(gdata)
library(leaflet)
library(htmlwidgets)
library(RColorBrewer)

# Changes temp dir to location with space, at least 5 GB free
rasterOptions(tmpdir="data/temp/")
rasterOptions(maxmemory=1e+12)

# Source files
source('R/summary_data.R')
source('R/ndvi_annual_mean.R')
source('R/hazards_sum.R')
source('R/calc_index.R')
source('R/normalization.R')

print('---- Ending setup ----')

# ---- downloads ----
print('---- Starting downloads ----')
# Downloads the hazards and PM2.5 datasets from SEDAC
system('Bash/./sedac_haz_pm25.sh')

# Runs the bash script that downloads the monthly MODIS NDVI data
system('Bash/./modis_ndvi.sh')

# Download GECON data xls
download.file('http://gecon.yale.edu/sites/default/files/Gecon40_post_final.xls', 'data/Gecon40_post_final.xls')

print('---- Ending downloads ----')

# ---- read-files ----
print('---- Starting read-files ----')
# Loads the hazards dataset into memory
hazards_files <- list.files('data', pattern = 'haz_?.*\\.asc', full.names = T)
for (haz in hazards_files){
  assign(basename(file_path_sans_ext(haz)),raster(haz))
  a <- get(basename(file_path_sans_ext(haz)))
  a@data@names <- basename(file_path_sans_ext(haz))
}
rm(haz,hazards_files,a)

# Loads NDVI monthly datasest into memory
ndvi_files <- list.files('data', pattern = 'MOD13C2*', full.names = T)
ndvi.months <- c("01_2016", "02_2016", "03_2016", "04_2016", "05_2016", "06_2016", "07_2016", "08_2016", "09_2016", "10_2016", "11_2016", "12_2016")
ndvi <- vector("list", length(ndvi.months))
ndvi_reliability <- vector("list", length(ndvi.months))
names(ndvi) <- ndvi.months
names(ndvi_reliability) <- ndvi.months
for (i in 1:12){
  # NDVI is subdataset 1
  ndvi[i] <- raster(get_subdatasets(ndvi_files[i])[1])
  ndvi[[i]]@data@names <- paste0('NDVI',ndvi.months[i])
  # Reliability is subdataset 13 (0, 0 is good -4)
  ndvi_reliability[i] <- raster(get_subdatasets(ndvi_files[i])[13])
  ndvi_reliability[[i]]@data@names <- paste0('NDVI_reliability',ndvi.months[i])
}
rm(ndvi_files, ndvi.months, i)

# Cleans data according to reliability, calculates the annual mean
ndvi_mean <- ndvi_annual_mean(ndvi, ndvi_reliability)
rm(ndvi,ndvi_reliability)

# Loads polution dataset into memory
annualpm25 <- raster('data/annualpm25/annualpm25.tif')

# Loads GECON data from XLS file
gecon <- read.xls('data/Gecon40_post_final.xls',sheet = 1, header = T)
gecon <- data.frame(gecon$LAT, gecon$LONGITUDE, gecon$PPP2005_40, gecon$MER2005_40)
gecon$gecon.PPP2005_40 <- as.numeric(paste(gecon$gecon.PPP2005_40))
gecon$gecon.MER2005_40 <- as.numeric(paste(gecon$gecon.MER2005_40))
gecon$gecon.LAT <- gecon$gecon.LAT +1
gecon$gecon.LONGITUDE <- gecon$gecon.LONGITUDE + 1
coordinates(gecon) <- ~gecon.LONGITUDE + gecon.LAT
gridded(gecon) <- T
gecon@proj4string <- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
gecon_mer <- raster(gecon["gecon.MER2005_40"])
gecon_ppp <- raster(gecon["gecon.PPP2005_40"])
gecon_mer@data@names <- 'gecon_mer'
gecon_ppp@data@names <- 'gecon_ppp'
writeRaster(gecon_mer,'data/gecon_mer.tif','GTiff', overwrite = T)
writeRaster(gecon_ppp,'data/gecon_ppp.tif','GTiff', overwrite = T)
rm(gecon)

print('---- Ending read-files ----')

# ---- files-info ----
print('---- Starting files-info ----')
# Gets all files into a vector that is passed to the data_summary func
all_files <- c(annualpm25, gecon_mer, gecon_ppp, haz_cyclone, haz_drought, haz_earthquake, haz_flood, haz_landslide, haz_volcano, ndvi_mean)
data_summary <- summary_data(all_files)
rm(all_files)

# Get the template raster object and the projection string - WGS84, 2.5 minute grid
minx <- min(unlist(data_summary[,'resx']))
miny <- min(unlist(data_summary[,'resy']))
proj <- data_summary[which(data_summary[,'resx']==minx,data_summary[,'resy']==miny),]
proj_str <- proj[1,'projargs'][[1]]
set_raster <- proj[1,'raster'][[1]]
rm(proj)

print('---- Ending files-info ----')

# ---- file-preprocessing ----
print('---- Starting file-preprocessing ----')
print('---- This will take a while, grab a cup of coffee! :) ----')
# Select all objects that have a different projection, nedd to add the different extents
to_reproj <- data_summary[which(data_summary[,'projargs']!=proj_str|data_summary[,'resx']!=minx|data_summary[,'resy']!=miny|data_summary[,'ymin']!=set_raster@extent@ymin),'raster']
rm(data_summary, proj_str, minx,miny)

# Reprojects and resamples the objects - changed tmp dir in the beginning, at least 5 GB free in dir
for(r in to_reproj){
  projectRaster(r,set_raster,filename = paste0('data/r_',r@data@names,'.tif'), method = 'ngb', overwrite = T)
  print(paste(r@data@names,'was reprojected!'))
}
rm(r,to_reproj, set_raster)

# Reads reprojected files into memory
r_files <- list.files('data', pattern = 'r_', full.names = T)
for (r in r_files){
  assign(basename(file_path_sans_ext(r)),raster(r))
}
rm(r,r_files)

# Adds aditional information
r_annualpm25@data@unit <- 'microg*m^-3'
r_gecon_mer@data@unit <- 'Billions US dollars'
r_gecon_ppp@data@unit <- 'Billions US dollars'

# Gets continental (countries) boundaries
world <- getMap()
world <- spTransform(world, r_ndvi_mean@crs)
simpleWorld <- gUnionCascaded(clgeo_Clean(world))

print('---- Ending file-preprocessing ----')

# ---- index-calculation ----
print('---- Starting index-calculation ----')
# Calculates the hazard component, (sum of all layers)
haz_comp <- hazards_sum(r_haz_cyclone, haz_drought, r_haz_earthquake, r_haz_flood, haz_landslide, r_haz_volcano)
writeRaster(haz_comp, 'data/haz_comp.tif', 'GTiff', overwrite =T)

# To run if not from source
haz_comp <- raster('data/haz_comp.tif')
r_ndvi_mean <- raster('data/r_ndvi_mean.tif')
r_gecon_ppp <- raster('data/r_gecon_ppp.tif')
r_annualpm25 <- raster('data/r_annualpm25.tif')

# Normalizes the data
haz_comp <- normalization(haz_comp)
r_ndvi_mean <- normalization(r_ndvi_mean)
r_gecon_ppp <- normalization(r_gecon_ppp)
r_annualpm25 <- normalization(r_annualpm25)

# Calculates the index, for 5 differente combinations of weights
# Index - Same weight to all
index10101010 <- calc_index(r_ndvi_mean,r_gecon_ppp, haz_comp, r_annualpm25, 1, 1, 1, 1,simpleWorld)
index10101010 <- index10101010*100
writeRaster(index10101010, 'data/index10101010.tif', 'GTiff', overwrite =T, datatype = 'INT2S')
rm(index10101010)

# Index - Greenest
index10050505 <- calc_index(r_ndvi_mean,r_gecon_ppp, haz_comp, r_annualpm25, 1, 0.5, 0.5, 0.5,simpleWorld)
index10050505 <- index10050505*100
writeRaster(index10050505, 'data/index10050505.tif', 'GTiff', overwrite =T, datatype = 'INT2S')
rm(index10050505)

# Index - Richest
index05100505 <- calc_index(r_ndvi_mean,r_gecon_ppp, haz_comp, r_annualpm25, 0.5, 1, 0.5, 0.5,simpleWorld)
index05100505 <- index05100505*100
writeRaster(index05100505, 'data/index05100505.tif', 'GTiff', overwrite =T, datatype = 'INT2S')
rm(index05100505)

# Index - Less hazards
index05051005 <- calc_index(r_ndvi_mean,r_gecon_ppp, haz_comp, r_annualpm25, 0.5, 0.5, 1, 0.5,simpleWorld)
index05051005 <- index05051005*100
writeRaster(index05051005, 'data/index05051005.tif', 'GTiff', overwrite =T, datatype = 'INT2S')
rm(index05051005)

# Index - Less polution
index05050510 <- calc_index(r_ndvi_mean,r_gecon_ppp, haz_comp, r_annualpm25, 0.5, 0.5, 0.5, 1,simpleWorld)
index05050510 <- index05050510*100
writeRaster(index05050510, 'data/index05050510.tif', 'GTiff', overwrite =T, datatype = 'INT2S')
rm(index05050510)
print('---- Ending index-calculation ----')

# ---- visualization ----
source('R/vis.R')
