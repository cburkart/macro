library(quantmod)
# M1 and M2
getSymbols(c('M1SL','M2SL'), src='FRED')
plot(as.zoo(M2SL), ylim=c(min(M1SL),max(M2SL)), xlab='Year',ylab="$Billion (ratio scale)", log='y')
abline(h=c(200,500,1000,2000,5000,10000),col='grey')
abline(v=as.Date(c("1960","1970","1980","1990","2000","2010"), "%Y"),col='lightgrey')
lines(as.zoo(M2SL), col='darkblue', lwd=3)
lines(as.zoo(M1SL), col=3, lwd=3)
legend('topleft', c('M2','M1'), lwd=3, col=c('darkblue',3))
