# define the function of calculating final INDEX
calc_index <- function(hazards,pm25,eco,ndvi,wei_hazards,wei_pm25,wei_eco,wei_ndvi) {
  overlay(a=hazards,b=pm25,c=eco,d=ndvi,k=wei_hazards,l=wei_pm25,m=wei_eco,n=wei_ndvi,fun=function(a,b,c,d,k,l,m,n){return (a*(-k)+b*(-l)+c*(m)+d*n)})
}
