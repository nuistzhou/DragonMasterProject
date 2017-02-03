#!/bin/bash
# Downloads SEDAC hazards data and unzips it

cd Bash
mkdir -p ../data

# Drought
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-drought-hazard-frequency-distribution/gddrg.zip

unzip gddrg.zip -d ../data/
rm gddrg.zip
mv ../data/gddrg/gddrg.asc ../data/haz_drought.asc
mv ../data/gddrg/gddrg.prj ../data/haz_drought.prj
rm -r ../data/gddrg

#Landslide
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-landslide-hazard-distribution/gdlnd.zip

unzip gdlnd.zip -d ../data/
rm gdlnd.zip
mv ../data/gdlnd/gdlnd.asc ../data/haz_landslide.asc
mv ../data/gdlnd/gdlnd.prj ../data/haz_landslide.prj
rm -r ../data/gdlnd

#Cyclone
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-cyclone-hazard-frequency-distribution/gdcyc.zip

unzip gdcyc.zip -d ../data/
rm gdcyc.zip
mv ../data/gdcyc/gdcyc.asc ../data/haz_cyclone.asc
mv ../data/gdcyc/gdcyc.prj ../data/haz_cyclone.prj
rm -r ../data/gdcyc

#Volcano
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-volcano-hazard-frequency-distribution/gdvol.zip

unzip gdvol.zip -d ../data/
rm gdvol.zip
mv ../data/gdvol/gdvol.asc ../data/haz_volcano.asc
mv ../data/gdvol/gdvol.prj ../data/haz_volcano.prj
rm -r ../data/gdvol

#Flood
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-flood-hazard-frequency-distribution/gdfld.zip

unzip gdfld.zip -d ../data/
rm gdfld.zip
mv ../data/gdfld/gdfld.asc ../data/haz_flood.asc
mv ../data/gdfld/gdfld.prj ../data/haz_flood.prj
rm -r ../data/gdfld

#Earthquakes
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/ndh/ndh-earthquake-frequency-distribution/gdeqk.zip

unzip gdeqk.zip -d ../data/
rm gdeqk.zip
mv ../data/gdeqk/gdeqk.asc ../data/haz_earthquake.asc
mv ../data/gdeqk/gdeqk.prj ../data/haz_earthquake.prj
rm -r ../data/gdeqk

#Annual PM25
wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-directories http://sedac.ciesin.columbia.edu/downloads/data/sdei/sdei-global-annual-avg-pm2-5-2001-2010/global-annual-avg-pm2-5-2010-geotiff.zip

unzip global-annual-avg-pm2-5-2010-geotiff.zip -d ../data/
rm global-annual-avg-pm2-5-2010-geotiff.zip
mv ../data/global-annual-avg-pm2-5-2010-geotiff ../data/annualpm25
mv ../data/global-annual-avg-pm2-5-2001-2010-documentation.pdf ../data/annualpm25
mv ../data/global-annual-avg-pm2-5-2001-2010-ReadMe.txt ../data/annualpm25
mv ../data/annualpm25/pm2-5-2010.tif ../data/annualpm25/annualpm25.tif
mv ../data/annualpm25/pm2-5-2010.tfw ../data/annualpm25/annualpm25.tfw
mv ../data/annualpm25/pm2-5-2010.tif.aux.xml ../data/annualpm25/annualpm25.tif.aux.xml
mv ../data/annualpm25/pm2-5-2010.tif.ovr ../data/annualpm25/annualpm25.tif.ovr
mv ../data/annualpm25/pm2-5-2010.tif.xml ../data/annualpm25/annualpm25.tif.xml

rm ../data/annualpm25/pm2-5-2010Copy.tif 
rm ../data/annualpm25/pm2-5-2010Copy.tfw 
rm ../data/annualpm25/pm2-5-2010Copy.tif.aux.xml
rm ../data/annualpm25/pm2-5-2010Copy.tif.ovr 
rm ../data/annualpm25/pm2-5-2010Copy.tif.xml