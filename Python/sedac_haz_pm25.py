# -*- coding: utf-8 -*-
"""
Created on Fri Jan 20 13:27:36 2017

@author: rodrigoalmeida94
"""
import sys
import os
from owslib.wms import WebMapService
import urllib2
import zipfile

# Creates data dir if not exists within project folder
if not os.path.exists('../data'):
    os.makedirs('../data')

# Downloads hazard files & air pollution data
# Source: http://sedac.ciesin.columbia.edu/
sedac_wms = WebMapService("http://sedac.ciesin.columbia.edu/geoserver/wms")

ly = [['haz_cyclone','ndh:ndh-cyclone-hazard-frequency-distribution'],
['haz_volcano','ndh:ndh-volcano-hazard-frequency-distribution' ],
['haz_landslide', 'ndh:ndh-landslide-hazard-distribution'],
['haz_flood', 'ndh:ndh-flood-hazard-frequency-distribution'],
['haz_earthquake', 'ndh:ndh-earthquake-frequency-distribution'],
['haz_drought', 'ndh:ndh-drought-hazard-frequency-distribution'],
['annualpm25', 'sdei:sdei-global-annual-avg-pm2-5-modis-misr-seawifs-aod-1998-2012_2010-2012']]

for elem in ly:
    BB = sedac_wms[elem[1]].boundingBox
    resp = sedac_wms.getmap(layers = [elem[1]], srs = 'EPSG:4326', bbox = BB[0:4], format = 'image/geotiff', size = (2048,2048))
    out = open('../data/'+elem[0]+'.tif', 'wb')
    out.write(resp.read())
    out.close()

exit()
# Downloads GDP 'per cell'
# Does not seem doable due to authentication in the SEDAC website





