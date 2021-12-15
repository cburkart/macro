# Per capita GDP

library(quantmod)

getSymbols(c('GDPC96','GDPPOT','POP','CPALTT01USQ661S'),src='FRED')


plot(GDPC96,main='Actual and Potential Real GDP Per Capita', ylab="2009 Dollars")
lines(GDPC96,lwd=2)
lines(GDPPOT,col='blue',lwd=2)


plot(as.zoo(GDPC96), main='Log of Actual and Potential Real GDP Per Capita', ylab="Log 2009 Dollars", log='y', lwd=2)
lines(as.zoo(GDPPOT),col='blue',lwd=2)
