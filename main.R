# Rodrigo Almeida, Ping
# Team Dragon Masters
# 23/01/2017

# ---- setup ----
# Installs necessary requirements
system('./requirements.sh')
if(!require(raster) | !require(tools) | !require(rgdal) | !require(gdalUtils) | !require(rworldmap) | !require(cleangeo) | !require(gdata)) {
 install.packages(c('raster','tools','rgdal','gdalUtils','rworldmap', 'rworldxtra', 'cleangeo','gdata'))
}

# Libraries needed
library(raster)
library(tools)
library(rgdal)
library(gdalUtils)
library(rworldmap)
library(cleangeo)
library(gdata)

# Changes temp dir to location with space, at least 5 GB free
rasterOptions(tmpdir="data/temp/")
rasterOptions(maxmemory=1e+12)

# Source files
source('R/summary_data.R')
source('R/ndvi_annual_mean.R')
source('R/hazards_sum.R')
source('R/calc_index.R')
source('R/normalization.R')

# ---- downloads ----
# Runs the python script that downloads data available through WMS
system('python Python/sedac_haz_pm25.py')

# Downloads the broken files via WMS (Drought and Landslide) - watchout for login
system('Bash/./sedac_drg_lnd.sh')

# Runs the bash script that downloads the monthly MODIS NDVI data - some times need two times (12 files)
system('Bash/./modis_ndvi.sh')

# Runs the bash script that downloads the SEDAC GECON data (GDP per cell) - corrupted data for some reason
system('Bash/./sedac_gecon.sh') 

# Download GECON data xls (work around)
download.file('http://gecon.yale.edu/sites/default/files/Gecon40_post_final.xls', 'data/gecon/Gecon40_post_final.xls')

# ---- read-files ----
# Loads the hazards dataset into memory
hazards_files <- list.files('data', pattern = 'haz_*', full.names = T)
for (haz in hazards_files){
  assign(basename(file_path_sans_ext(haz)),raster(haz))
}
rm(haz,hazards_files)
# Since the WMS service sends the drought and landslide dataset with wrong values, we downloaded them manually
haz_drought <- raster('data/gddrg/gddrg.asc')
haz_landslide <- raster('data/gdlnd/gdlnd.asc')
haz_drought@data@names <- 'haz_drought'
haz_landslide@data@names <- 'haz_landslide'

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
annualpm25 <- raster('data/annualpm25.tif')

# Loads GDP per cell datasets into memory (MER and PPP 2005)
#gecon_mer <- raster('data/gecon/MER2005sum.asc')
#gecon_ppp <- raster('data/gecon/PPP2005sum.asc')
# Since the GECON data downloaded is not correct, use XLS file
gecon <- read.xls('data/gecon/Gecon40_post_final.xls',sheet = 1, header = T)
gecon <- data.frame(gecon$LAT, gecon$LONGITUDE, gecon$PPP2005_40, gecon$MER2005_40)
gecon$gecon.PPP2005_40 <- as.numeric(paste(gecon$gecon.PPP2005_40))
gecon$gecon.MER2005_40 <- as.numeric(paste(gecon$gecon.MER2005_40))
coordinates(gecon) <- ~gecon.LONGITUDE + gecon.LAT
gridded(gecon) <- T
gecon@proj4string <- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
gecon_mer <- raster(gecon["gecon.MER2005_40"])
gecon_ppp <- raster(gecon["gecon.PPP2005_40"])
gecon_mer@data@names <- 'gecon_mer'
gecon_ppp@data@names <- 'gecon_ppp'
rm(gecon)

# ---- files-info ----
# Gets all files into a vector that is passed to the data_summary func
all_files <- c(annualpm25, gecon_mer, gecon_ppp, haz_cyclone, haz_drought, haz_earthquake, haz_flood, haz_landslide, haz_volcano, ndvi_mean)
data_summary <- summary_data(all_files)
rm(all_files)

# Get the template raster object and the projection string
min_resx <- min(unlist(data_summary[,'resx']))
min_resy <- min(unlist(data_summary[,'resy']))                
proj <- data_summary[which(data_summary[,'resx']==min_resx,data_summary[,'resy']==min_resy),]
proj_str <- proj$projargs
set_raster <- proj$raster
rm(proj, min_resx, min_resy)

# ---- file-preprocessing ----
# Select all objects that have a different projection
to_reproj <- data_summary[data_summary[,'projargs']!=proj_str,'raster']
rm(data_summary, proj_str)

# Reprojects and resamples the objects - WHATCHOUT FOR MEMORY - changed tmp dir in the beginning, at least 5 GB
for(r in to_reproj){
  projectRaster(r,set_raster,filename = paste0('data/r_',r@data@names,'.tif'), method = 'ngb', overwrite = T)
}
rm(r,to_reproj, set_raster)

# Reads reprojected files into memory
r_hazards_files <- list.files('data', pattern = 'r_haz_*', full.names = T)
for (haz in r_hazards_files){
  assign(basename(file_path_sans_ext(haz)),raster(haz))
}
rm(haz,r_hazards_files)
r_annualpm25 <- raster('data/r_annualpm25.tif')
r_gecon_mer <- raster('data/r_gecon_mer.tif')
r_gecon_ppp <- raster('data/r_gecon_ppp.tif')
rm(annualpm25,gecon_mer, gecon_ppp, haz_cyclone, haz_drought, haz_earthquake, haz_flood, haz_landslide, haz_volcano)
# Remove if run from source
#ndvi_mean <- raster('data/ndvi_mean.tif')

# Adds aditional information
r_annualpm25@data@unit <- 'microg*m^-3'
r_gecon_mer@data@unit <- 'Billions US dollars'
r_gecon_ppp@data@unit <- 'Billions US dollars'

# Gets continental (countries) boundaries
world <- getMap()
world <- spTransform(world, ndvi_mean@crs)
simpleWorld <- gUnionCascaded(clgeo_Clean(world))

# ---- index-calculation ----
# Calculates the hazard component, (sum of all layers)
haz_comp <- hazards_sum(r_haz_cyclone, r_haz_drought, r_haz_earthquake, r_haz_flood, r_haz_landslide, r_haz_volcano)

# Masks and normalizes the data, saves into file
haz_comp_m <- mask(normalization(haz_comp), simpleWorld, filename = 'data/haz_comp_m.tif')
ndvi_mean_m <- mask(0.00000001*ndvi_mean, simpleWorld,filename = 'data/ndvi_mean_m.tif')
r_gecon_ppp_m <- mask(normalization(r_gecon_ppp), simpleWorld, filename = 'data/r_gecon_ppp_m.tif')
r_annualpm25_m <- mask(normalization(r_annualpm25), simpleWorld, filename = 'data/r_annualpm25_m.tif')

# Calculates the index with all factors 1
index <- calc_index(ndvi_mean,r_gecon_ppp, haz_comp, r_annualpm25, 1, 1, 1, 1)
