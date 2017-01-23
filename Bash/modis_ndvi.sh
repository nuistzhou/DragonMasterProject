#!/bin/bash
# Downloads NDVI MODIS data for the every month of 2016.

for i in $(seq 1 12);
do curl -u rodrigoalmeida94:RmA20071994 -L -c cookiefile -b cookiefile https://e4ftl01.cr.usgs.gov/MOLT/MOD13C2.006/2016.$i.01/*.hdf --output ../data/NDVI_16_$i.hdf;	
done
