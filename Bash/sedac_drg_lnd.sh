#!/bin/bash
# Downloads drought and landslide data

cd Bash
mkdir -p ../data

# Drought

wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-drought-hazard-frequency-distribution/gddrg.zip

unzip gddrg.zip -d ../data/
rm gddrg.zip

#Landslide

wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-landslide-hazard-distribution/gdlnd.zip

unzip gdlnd.zip -d ../data/
rm gdlnd.zip