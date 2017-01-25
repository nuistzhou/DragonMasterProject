#!/bin/bash
# Downloads GECON data from SEDAC (PPP2005 and MER2005)

mkdir -p ../data

wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/spatialecon/spatialecon-gecon-v4/spatialecon-gecon-v4-gis-ascii.zip

unzip spatialecon-gecon-v4-gis-ascii.zip -d ../data/gecon
rm spatialecon-gecon-v4-gis-ascii.zip

mv ../data/gecon/GIS\ data\ ASCII/PPP2005/ppp2005sum.asc ../data/gecon/PPP2005sum.asc
mv ../data/gecon/GIS\ data\ ASCII/PPP2005/PPP2005sum.prj ../data/gecon/PPP2005sum.prj
mv ../data/gecon/GIS\ data\ ASCII/MER2005/mer2005sum.asc ../data/gecon/MER2005sum.asc
mv ../data/gecon/GIS\ data\ ASCII/MER2005/MER2005sum.prj ../data/gecon/MER2005sum.prj

rm -rf ../data/gecon/GIS\ data\ ASCII