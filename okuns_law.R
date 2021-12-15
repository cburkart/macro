library(quantmod)
getSymbols(c('UNRATE','NROU','NROUST','GDPC1','GDPPOT','CPALTT01USQ661S'),src='FRED')

CPI <- get('CPALTT01USQ661S')
anchor <- as.numeric(last(CPI))
GDPC1.base <- mean(CPI['2009'])
GDPPOT.base <- mean(CPI['2009'])

gdp.ts <- ts(GDPC1['1949::']*(anchor/GDPC1.base),start=1949,frequency=4)
potgdp.ts <- ts(GDPPOT['1949::']*(anchor/GDPPOT.base),start=1949,frequency=4)
ytilde.ts <- (100*(gdp.ts-potgdp.ts)/potgdp.ts)

preu.ts <- ts(UNRATE,start=1948,frequency=12)

u.ts <- aggregate(preu.ts,nfrequency=4,FUN=mean)
ubar.ts <- ts(NROU[paste('::',Sys.Date(),sep='')],start=1949,frequency=4)

# Time-series plot of u, ubar, ytilde
plot(u.ts,ylim=c(-10,10), ylab='Percent', main="Basis for Okun's Law (quarterly data)", xlab="Year")
abline(h=0,lty=2)
lines(ubar.ts,col='blue')
lines(ytilde.ts,col='red')
legend.labels <- c(
  expression(u[t]*'  (Unemployment rate)')
  , expression(bar(u)[t]*'  (Natural rate of unemployment)')
  , expression(tilde(Y)[t]*'  (Short-run output)')
)
legend('bottomleft', legend.labels, col=c('black','blue','red'), lwd=2)

# Convert to scatter-plot type layout and run linear model on it
new.df <- data.frame(u.ts-ubar.ts,ytilde.ts)
new.df <- new.df[-c(1:4,261),]
names(new.df) <- c('udiff','ytilde')

okunmod <- lm(udiff~-1+ytilde,data=new.df)
#okunmod1 <- lm(udiff~ytilde,data=new.df)


plot(new.df$ytilde,new.df$udiff,xlab=expression('Short-run output (%), '*tilde(Y)), pch=21,
     ylab=expression('Unemployment gap, '*u*-bar(u)), main='Evidence for Okun\'s Law', col='blue', bg='yellow')
abline(h=0,col='lightgrey')
abline(v=0,col='lightgrey')
abline(okunmod,col='darkblue',lwd=3, lty=2)
#abline(okunmod1,col='lightblue',lwd=3, lty=2)
