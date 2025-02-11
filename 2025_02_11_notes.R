# Lydia Sims Class notes 2025-02-11

#while loops

x=1
while (x<0){
  x=x-1
  print(x) #infinte loop, my worst nightmare
}
x=10
while (x>0){
  x=x-1
  print(x) #well programmed loop
}


#fishing game with while loop
rnorm(n=1, mean=2, sd=1)

n_fish=0
total_catch_lb=0
while(total_catch_lb<50){
  new_fish_weight_lb=rnorm(n=1,mean=5,sd=1)
  n_fish=n_fish+1
  total_catch_lb=total_catch_lb+new_fish_weight_lb
  print(total_catch_lb)
  
}


# 2.6 arctic sea ice

url='ftp://sidads.colorado.edu/DATASETS/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v3.0.csv'

arctic_ice=read.delim(file=url,skip=2,sep=",", header=FALSE, col.names=c("year","month","day","extent","missing","source"))

head(arctic_ice)
tail(arctic_ice)


library(lubridate)

arctic_ice$date=make_date(year=arctic_ice$year, month=arctic_ice$month, day=arctic_ice$day)

class(arctic_ice$date)
class(arctic_ice)


plot(extent~date, data=arctic_ice, type='l', ylab='Arctic Sea Ice Extent (millions km^2)')

#taking the annual average, dumping 1978 and 2025 (not full years)
first_year= min(arctic_ice$year)+1
last_year= max(arctic_ice$year)-1

arctic_ice_averages=data.frame(year= seq(from=first_year, to=last_year), extent_annual_average=NA, extent_5yr_average=NA)


arctic_ice_averages$extent_annual_average[1]=mean(arctic_ice$extent[arctic_ice$year == arctic_ice_averages$year[1] ])

a=dim(arctic_ice_averages)[1]
for (i in seq(dim(arctic_ice_averages)[1])){
  arctic_ice_averages$extent_annual_average[i]=
    mean(arctic_ice$extent[arctic_ice$year == arctic_ice_averages$year[i] ])
  print(i) 
  print(arctic_ice_averages$extent_annual_average[i])
  
}

head(arctic_ice_averages)

plot(extent_annual_average~year, data=arctic_ice_averages, type='l')  

# calculating 5 yr averages doing a moving window with focus year centered (cuts off first 2 and last 2 years)
i=3
for(i in seq(from=3, to=dim(arctic_ice_averages)[1]-2)){
  
  years_cal=c( (arctic_ice_averages$year[i]-2) : (arctic_ice_averages$year[i]+2))
  arctic_ice_averages$extent_5yr_average[i]=mean(arctic_ice$extent[arctic_ice$year %in% years_cal])
  print(paste(i,": ", years_cal))
}  
  
head(arctic_ice_averages)
tail(arctic_ice_averages)  
  
plot(extent_annual_average~year, data=arctic_ice_averages, type='l',col='blue')  
lines(extent_5yr_average~year, data=arctic_ice_averages, col='red')
  

arctic_ice_averages$date=make_date(year=arctic_ice_averages$year, month=7, day=1)

# now plotting all together


plot(extent~date, data=arctic_ice, type='l')
lines(extent_annual_average~date, data=arctic_ice_averages, col='blue', lwd=2)  
lines(extent_5yr_average~date, data=arctic_ice_averages, col='hotpink', lwd=2)


# 10yr average but mean is target year and 9 years prior
arctic_ice_averages$extent_10yr_average=NA
for(i in seq(from=10, to=dim(arctic_ice_averages)[1])){
  
  years_cal=c( (arctic_ice_averages$year[i]-9) : (arctic_ice_averages$year[i]))
  arctic_ice_averages$extent_10yr_average[i]=mean(arctic_ice$extent[arctic_ice$year %in% years_cal])
  print(paste(i,": ", years_cal))
}  
lines(extent_10yr_average~date, data=arctic_ice_averages, col='red', lwd=2)



