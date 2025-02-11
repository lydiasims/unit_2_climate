# Lydia Sims 2025-01-30 
#updated file names

# read in data
ant_ice_loss=read.table(file='data/antarctica_mass_200204_202408.txt',skip=31,sep='',header=FALSE,
           col.names=c('decimal_date','mass_GT','sigma_GT'))
head(ant_ice_loss)
tail(ant_ice_loss)

grn_ice_loss=read.table(file='data/greenland_mass_200204_202408.txt',skip=31,sep='',header=FALSE,
                        col.names=c('decimal_date','mass_GT','sigma_GT'))
head(grn_ice_loss)
tail(grn_ice_loss)
dim(grn_ice_loss)

summary(grn_ice_loss)
plot(x=ant_ice_loss$decimal_date, y=ant_ice_loss$mass_GT)
#or
plot(mass_GT~ decimal_date, data=ant_ice_loss, type='l', 
     ylab='Mass loss (GT)', xlab='year',ylim=range(grn_ice_loss$mass_GT))
lines(mass_GT~ decimal_date, data=grn_ice_loss, type='l',col='red')

#messy way to add a row of data into an existing data frame

data_break=data.frame(decimal_date=2018.0, mass_GT=NA, sigma_GT=NA)
ant_ice_loss_with_NA=rbind(ant_ice_loss,data_break)
head(ant_ice_loss_with_NA)


plot(mass_GT~ decimal_date, data=ant_ice_loss_with_NA, type='l', 
     ylab='Mass loss (GT)', xlab='year',ylim=range(grn_ice_loss$mass_GT))
#no gap, oh no!

ordered_rows=order(ant_ice_loss_with_NA$decimal_date) #shoots out new index based on variable
ant_ice_loss_with_NA=ant_ice_loss_with_NA[ordered_rows,]

grn_ice_loss_with_NA=rbind(grn_ice_loss,data_break)
head(grn_ice_loss_with_NA)
ordered_rows=order(grn_ice_loss_with_NA$decimal_date) #shoots out new index based on variable
grn_ice_loss_with_NA=grn_ice_loss_with_NA[ordered_rows,]


plot(mass_GT~ decimal_date, data=ant_ice_loss_with_NA, type='l', 
     ylab='Mass loss (GT)', xlab='year',ylim=range(grn_ice_loss$mass_GT))
lines(mass_GT~ decimal_date, data=grn_ice_loss_with_NA, type='l',col='red')
#now we have two perfect breaks in the lines


### adding uncertainty 
pdf('figures/my_awesome_figure.pdf',width=7,height=5) #width & height are in inches
plot(mass_GT~ decimal_date, data=ant_ice_loss_with_NA, type='l', lwd=2, 
     ylab='Mass loss (GT)', xlab='year',ylim=range(grn_ice_loss$mass_GT))
lines((mass_GT + 2*sigma_GT)~decimal_date,data=ant_ice_loss_with_NA,lty='dashed')
lines((mass_GT - 2*sigma_GT)~decimal_date,data=ant_ice_loss_with_NA,lty='dashed')

lines(mass_GT~ decimal_date, data=grn_ice_loss_with_NA, type='l',lwd=2,col='red')
lines((mass_GT + 2*sigma_GT)~decimal_date,data=grn_ice_loss_with_NA,lty='dashed',col='red')
lines((mass_GT - 2*sigma_GT)~decimal_date,data=grn_ice_loss_with_NA,lty='dashed',col='red')
dev.off()

# 2025-02-03 bar plot practice

# Largest observed decrease in ice mass loss in Antarctica:
min(ant_ice_loss$mass_GT)

# Barplot of largest observed ice loss in Antarctica and Greenland
barplot(height=c(min(ant_ice_loss$mass_GT), min(grn_ice_loss$mass_GT)))

# Flip to negative to positive, add x-axis labels, add more tick marks on y-axis, add y-axis title
barplot(height=c(min(ant_ice_loss$mass_GT)*(-1), min(grn_ice_loss$mass_GT)*(-1)), names.arg=c("Antarctica","Greenland"), ylim=c(0,6000), ylab="Ice loss in Gt")


#Calculate the average annual ice loss (a.k.a. the annual rate of ice loss) 
#for each ice sheet by dividing the change in ice lost from the beginning to the 
#end of the time series by the total time that passed. 
#Then display the ice loss rates in a bar graph. Save the bar graph into the `figures/` 
#directory in this repo.

ant_delta=ant_ice_loss$mass_GT[236]-ant_ice_loss$mass_GT[1]
grn_delta=grn_ice_loss$mass_GT[236]-grn_ice_loss$mass_GT[1]
year_diff=ant_ice_loss$decimal_date[236]-ant_ice_loss$decimal_date[1]


pdf('figures/my_awesome_bargraph.pdf',width=7,height=5)
barplot(height=c((ant_delta/year_diff*(-1)),(grn_delta/year_diff*(-1))), 
        names.arg=c("Antarctica","Greenland"), ylim=c(0,300), ylab="annual Ice loss in Gt")
dev.off()



