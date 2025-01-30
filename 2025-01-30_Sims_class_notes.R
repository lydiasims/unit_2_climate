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

