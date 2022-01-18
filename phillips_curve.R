library(calibrate)
library(quantmod)

getSymbols(c('GDPC1','GDPPOT','USACPIBLS','CPIAUCSL'),src='FRED')

CPI <- get('CPIAUCSL')
anchor <- as.numeric(last(CPI))
GDPC1.base <- mean(CPI['2009'])
GDPPOT.base <- mean(CPI['2009'])

gdp.ts <- ts(GDPC1['1949::2020']*(anchor/GDPC1.base),start=1949,frequency=4)
potgdp.ts <- ts(GDPPOT['1949::2020']*(anchor/GDPPOT.base),start=1949,frequency=4)


ytilde.ts <- (100*(gdp.ts-potgdp.ts)/potgdp.ts)

ann.ytilde.ts <- aggregate(ytilde.ts,nfrequency=1,FUN=mean)
infl.xts <- yearlyReturn(CPIAUCSL)
deltapi.ts <- ts(100*diff(infl.xts)['1954::'],start=1954,frequency=1)

new.df <- data.frame(seq(from=1955,to=2020),as.numeric(window(ann.ytilde.ts,start=1955,end=2020)), as.numeric(window(deltapi.ts,start=1955,end=2020)))
names(new.df) <- c('year','ytilde','deltapi')

model.lm <- lm(deltapi~-1+ytilde,data=new.df)

plot(new.df$ytilde,new.df$deltapi,pch=21,col='blue',bg='yellow',main='Empricial Phillips curve, U.S. 1955-present',xlab=expression('Short-run output, '*tilde(Y))
     , ylab=expression('Change in inflation, '*Delta*pi), xlim=c(-8,8))
textxy(new.df$ytilde,new.df$deltapi,labs=new.df$year,cex=.75)
abline(model.lm, col='blue', lwd=2)
abline(0, .5, lty=2, lwd=2)
text(7,0.5,'Extended data',col='blue')
text(-6,-4,'Textbook model')
abline(h=0,col='lightgrey')
abline(v=0,col='lightgrey')