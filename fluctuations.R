library(quantmod)
getSymbols(c('GDPC1','GDPPOT','CPIAUCSL'),src='FRED')

CPI <- get('CPIAUCSL')
anchor <- as.numeric(last(CPI))
GDPC1.base <- mean(CPI['2009'])
GDPPOT.base <- mean(CPI['2009'])


gdp.xts <- GDPC1['1949::']*(anchor/GDPC1.base)
potgdp.xts <- GDPPOT['1949::']*(anchor/GDPPOT.base)

ytilde.xts <- (100*(gdp.xts-potgdp.xts)/potgdp.xts)

par(mar=c(4,4.5,2,1))
plot(as.zoo(ytilde.xts),col='blue',lwd=3,main=expression('Short-run deviations from (real) '* bar(Y)[t]),xlab='Year',ylab=expression(tilde(Y)[t]*'  in percent'))
abline(h=0,lty=2)
abline(v=as.numeric(last(index(ytilde.xts))),col='grey')
text(as.numeric(last(index(ytilde.xts)))-1600,6,index(last(ytilde.xts)), col='grey')
