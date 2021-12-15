library(quantmod)

getSymbols('TB3MS', src='FRED')
getSymbols('CPIAUCSL', src='FRED')

infl.xts <- 100*yearlyReturn(CPIAUCSL)
treas.xts <- Cl(to.yearly(TB3MS))

real_r.xts <- treas.xts - infl.xts

plot(as.zoo(treas.xts),col='darkblue',lwd=3,ylim=c(-8,16),xlab='Year',ylab='Percent',main='Real and Nominal U.S. Interest Rates, 1960-2015')
lines(as.zoo(real_r.xts),col='darkgreen',lwd=3)
abline(v=as.Date(c("1940","1950","1960","1970","1980","1990","2000","2010"), "%Y"),col='lightgrey')
abline(h=0,lty=2)
legend(x='topright','*Based on 3-month treasuries', bty='n')
legend('topleft', c('Nominal','Real'), lwd=3, col=c('darkblue','darkgreen'))
