library(quantmod)

getSymbols(c('GDPPOT','POP','GDP','A939RX0Q048SBEA','GDPC1'), src='FRED')

GDPPC <- A939RX0Q048SBEA
RealGDP <- GDPC1

plot(as.zoo(GDPPOT['::2021']), col='blue', lty=2, lwd=2, xlab="Year", ylab="Real GDP (billions of 2012 dollars)")
lines(as.zoo(GDPC1), lwd=2, col=1)

plot(as.zoo(GDPPOT['2000::2021']), col='blue', lty=2, lwd=2, log='y', xlab="Year", ylab="Real GDP (billions of 2012 dollars)")
lines(as.zoo(GDPC1), lwd=2, col=1)
