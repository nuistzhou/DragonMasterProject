# calculate INDEX
index <- function(ndvi_mean,gecon,harzards,pm25,wei_ndvi_mean,wei_gecon,
                  wei_harzards,wei_pm25){
  overlay(ndvi_mean,gecon,harzards,pm25,wei_ndvi_mean,wei_gecon,
                 wei_harzards,wei_pm25,fun=function(a,b,c,d,e,f,g,h){
                   (a*e+b*f-c*g-d*h)
                 })
}

index(ndvi_mean,r_gecon_ppp,r_haz_flood,r_annualpm25,1,2,3,4)
