#!/bin/bash
# Downloads NDVI MODIS data for the every month of 2016.
mkdir -p data
cd data

for i in 01 02 03 04 05 06 07 08 09 10 11 12;
do wget -L --user=rodrigoalmeida94 --password=RmA20071994 --load-cookies ~/.cookies --save-cookies ~/.cookies --no-parent -A*.hdf https://e4ftl01.cr.usgs.gov/MOLT/MOD13C2.006/2016.$i.01/
#-O NDVI_16_$i.hdf
# do curl -u rodrigoalmeida94:RmA20071994 -L -c cookiefile -b cookiefile -A *.hdf https://e4ftl01.cr.usgs.gov/MOLT/MOD13C2.006/2016.$i.01/ --output NDVI_16_$i.hdf;	
done
