# Rodrigo Almeida, Ping
# Team Dragon Masters
# 23/01/2017

# ---- setup ----
# Installs necessary requirments
system('./requirements.sh')
if(!require(raster) | !require(tools) | !require(rgdal) | !require(gdalUtils) | !require(rworldmap)) {
  install.packages(c('raster','tools','rgdal','gdalUtils','rworldmap'))
}

# Libraries needed
library(raster)
library(tools)
library(rgdal)
library(gdalUtils)
library(rworldmap)

# ---- downloads ----
# Runs the python script that downloads data available through WMS
system('python Python/sedac_haz_pm25.py')

# Runs the bash script that downloads the monthly MODIS NDVI data
system('Bash/./modis_ndvi.sh')

# Runs the bash script that downloads the SEDAC GECON data (GDP per cell)
system('Bash/./sedac_gecon.sh')

# ---- read-files ----
# Loads the hazards dataset into memory
hazards_files <- list.files('data', pattern = 'haz_*', full.names = T)
for (haz in hazards_files){
  assign(basename(file_path_sans_ext(haz)),raster(haz))
}

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
  # Reliability is subdataset 13 (0, 0 is good -4)
  ndvi_reliability[i] <- raster(get_subdatasets(ndvi_files[i])[13])
}

# Loads polution dataset into memory
annualpm25 <- raster('data/annualpm25.tif')

# Loads GDP per cell datasets into memory (MER and PPP 2005)
gecon_mer <- raster('data/gecon/MER2005sum.asc')
gecon_ppp <- raster('data/gecon/PPP2005sum.asc')

# Get data from crime statistics, terrorism? http://www.start.umd.edu/gtd/contact/, Human development index?