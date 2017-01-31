#!/bin/bash
# Downloads SEDAC hazards data and unzips it

cd Bash
mkdir -p ../data

# Drought
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-drought-hazard-frequency-distribution/gddrg.zip

unzip gddrg.zip -d ../data/
rm gddrg.zip
mv ../data/gddrg/gddrg.asc haz_drought.asc
mv ../data/gddrg/gddrg.prj haz_drought.prj
rm -r ../data/gddrg

#Landslide
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-landslide-hazard-distribution/gdlnd.zip

unzip gdlnd.zip -d ../data/
rm gdlnd.zip
mv ../data/gdlnd/gdlnd.asc haz_landslide.asc
mv ../data/gdlnd/gdlnd.prj haz_landslide.prj
rm -r ../data/gdlnd

#Cyclone
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-cyclone-hazard-frequency-distribution/gdcyc.zip

unzip gdcyc.zip -d ../data/
rm gdcyc.zip
mv ../data/gdcyc/gdcyc.asc haz_cyclone.asc
mv ../data/gdcyc/gdcyc.prj haz_cyclone.prj
rm -r ../data/gdcyc

#Volcano
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-volcano-hazard-frequency-distribution/gdvol.zip

unzip gdvol.zip -d ../data/
rm gdvol.zip
mv ../data/gdvol/gdvol.asc haz_volcano.asc
mv ../data/gdvol/gdvol.prj haz_volcano.prj
rm -r ../data/gdvol

#Flood
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-flood-hazard-frequency-distribution/gdfld.zip

unzip gdfld.zip -d ../data/
rm gdfld.zip
mv ../data/gdfld/gdfld.asc haz_flood.asc
mv ../data/gdfld/gdfld.prj haz_flood.prj
rm -r ../data/gdfld

#Earthquakes
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-earthquake-frequency-distribution/gdeqk.zip

unzip gdeqk.zip -d ../data/
rm gdeqk.zip
mv ../data/gdfld/gdeqk.asc haz_earthquake.asc
mv ../data/gdfld/gdeqk.prj haz_earthquake.prj
rm -r ../data/gdeqk
