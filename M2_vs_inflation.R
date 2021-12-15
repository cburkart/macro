library(quantmod)
# Money growth and infaltion in the U.S.
# Companion to Figure 8.2 in Jones' Macroeconomics

getSymbols(c('M2SL','CPIAUCSL'), src='FRED')

df.xts <- cbind(yearlyReturn(M2SL),yearlyReturn(CPIAUCSL))

df.xts <- df.xts[-which(is.na(df.xts)),]
df.xts <- df.xts['::2015']

m.growth <- as.numeric(df.xts[,1])
infl.rate <- as.numeric(df.xts[,2])
year <- substring(as.character(index(df.xts)),1,4)
library(calibrate)
plot(m.growth,infl.rate, xlim=c(0,.14), ylim=c(-.02,.14), xlab="Money growth",ylab="Inflation rate")
abline(h=0, lty=2)
textxy(m.growth,infl.rate,year,cex=.8,col='darkgrey')

summary(lm(infl.rate~m.growth))
summary(lm(infl.rate~-1+m.growth))


df.xts <- df.xts['1984::2015']

m.growth <- as.numeric(df.xts[,1])
infl.rate <- as.numeric(df.xts[,2])
year <- substring(as.character(index(df.xts)),1,4)
library(calibrate)
plot(m.growth,infl.rate, xlim=c(0,.14), ylim=c(-.02,.14), xlab="Money growth",ylab="Inflation rate")
abline(h=0, lty=2)
textxy(m.growth,infl.rate,year,cex=.8,col='darkgrey')

summary(lm(infl.rate~m.growth))
summary(lm(infl.rate~-1+m.growth))
