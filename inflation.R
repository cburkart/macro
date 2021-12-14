# Inflation in the U.S.

library(quantmod)

getSymbols('CPIAUCSL', src='FRED')
getSymbols('PCEPI', src='FRED')

infl.xts <- 100*yearlyReturn(CPIAUCSL)
pcepi.xts <- 100*yearlyReturn(PCEPI)

getSymbols('GDPC96', src='FRED')

bands <- USREC*max(GDPC96+1000)

plot(as.zoo(infl.xts),lwd=3,col='darkblue',xlab='Year',ylab='Percent',main='Annual Inflation in the United States, 1960-2015')
lines(as.zoo(pcepi.xts), lwd=3, col='lightblue')
lines(as.zoo(bands), col='darkgrey')
abline(h=0,lty=2,lwd=1)
#abline(h=c(2,4,6,8,10,12,14),col='lightgrey')
#abline(v=as.Date(c("1960","1970","1980","1990","2000","2010"), "%Y"),col='lightgrey')
legend(x='topright',c('CPI','PCEPI'),col=c('darkblue','lightblue'),lwd=c(3,3))


## Core inflation vs. All items on monthly basis
#
# Load Consumer Price Index for All Urban Consumers: All Items Less Food & Energy (CPILFESL) (Seasonally adjusted)
# Load Consumer Price Index for All Urban Consumers: All Items (CPIAUCSL) (Seasonally adjusted)
getSymbols(c('CPILFESL','CPIAUCSL'),src='FRED')

corecpi.avg <- paste("Core CPI: Average ", round(100*mean((monthlyReturn(CPILFESL)+1)^12-1),1),"%",sep="")
cpi.avg <- paste("Full CPI: Average ", round(100*mean((monthlyReturn(CPIAUCSL['1957::'])+1)^12-1),1),"%",sep="")

plot(as.zoo(quarterlyReturn(CPIAUCSL)),ylab='Annualized quarterly inflation rate',xlab="Year",lwd=2,col='pink')
lines(as.zoo(quarterlyReturn(CPILFESL)),col='black',lwd=3)
abline(h=c(-.1,-.05,0,.05,.1,.15),lty=2,col='lightgrey')
abline(v=as.Date(c("1960","1970","1980","1990","2000","2010"), "%Y"),col='lightgrey')
legend(x='topright',c(corecpi.avg,cpi.avg),col=c('black','pink'),lwd=c(3,2))
