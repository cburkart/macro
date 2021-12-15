# File to grab, manipulate, and chart Gross Domestic Product and components

library(quantmod)
library(ggplot2)
library(tis)

getSymbols(c('GDPC96','PCECC96','GPDIC96','EXPGSC96','IMPGSC96','GCEC96','GDPPOT'),src='FRED')
gdp.all <- cbind(GDPC96,PCECC96,GPDIC96,GCEC96,EXPGSC96,IMPGSC96)

gdpc96.df <- data.frame(date=as.Date(index(gdp.all), format="%Y-%M-%D"), gdp=as.numeric(GDPC96))
gdppot.df <- data.frame(date=as.Date(index(GDPPOT['::2015-07-01']), format="%Y-%M-%D"), gdp=as.numeric(GDPPOT['::2012-07-01']))

gdp.plot <- ggplot(gdpc96.df, aes(x=date, y=gdp)) +
  theme_bw() +
  geom_line(data=gdpc96.df, aes(y=gdp), size=1) +
  geom_line(data=gdppot.df, aes(y=gdp), size=1, color='blue') +
  xlab("Year") +
  ylab("Real GDP (2005 Dollars)") 
print(gdp.plot)

# Add recession shading
bplot2 <- nberShade(gdp.plot,
                    fill = "grey",
                    xrange = c("1949-01-01", "2012-07-01"),
                    openShade = TRUE) # looks weird when FALSE

#Plot it
print(bplot2)

# Expenditure shares
C.shr <- 100*PCECC96/GDPC96
I.shr <- 100*GPDIC96/GDPC96
G.shr <- 100*GCEC96/GDPC96
NX.shr <- 100*(EXPGSC96-IMPGSC96)/GDPC96

plot(C.shr,ylim=c(-5,75),main="Expenditure Shares of GDP",ylab="Percent of Real GDP")
abline(h=0,lty=2)
lines(C.shr,col='darkblue',lwd=2)
lines(I.shr,col='darkgreen',lwd=2)
lines(G.shr,col='orange',lwd=2)
lines(NX.shr,col='red',lwd=2)
legend(x='right', y=70, c('Consumption','Investment', 'Government Spending', 'Net Exports'), col=c('darkblue','darkgreen','orange','red'), lty=1,lwd=2, bty="n")