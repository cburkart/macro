# File to grab, manipulate, and chart Gross Domestic Income

library(quantmod)

getSymbols(c('GDICOMP','GDI','GDINOS','GDICONSPA','GDISUBS','GDITAXES'),src='FRED', from='1959-01-01')

gdi.df <- cbind(GDI['1959-01-01::'], GDICOMP['1959-01-01::'], GDINOS, GDICONSPA['1959-01-01::'], GDISUBS['1959-01-01::'], GDITAXES['1959-01-01::'])
gdi.pct.df <- cbind(GDICOMP['1959-01-01::']/GDI['1959-01-01::'], GDINOS/GDI['1959-01-01::'], GDICONSPA['1959-01-01::']/GDI['1959-01-01::'], (GDITAXES['1959-01-01::'] - GDISUBS['1959-01-01::'])/GDI['1959-01-01::'])

names(gdi.pct.df) <- c('compensation', 'netopsurplus', 'capitaldep', 'nettaxes')

# Plot Gross Domestic Income
plot(gdi.pct.df$compensation,ylim=c(0,.65),main='Gross Domestic Income')
lines(gdi.pct.df$netopsurplus,col='blue')
lines(gdi.pct.df$capitaldep,col='red')
lines(gdi.pct.df$nettaxes,col='darkgreen')
legend(400, y=.5, c('Compensation','Net Operating Surplus', 'Capital Depreciation', 'Net Taxes'), col=c('black','blue','red','darkgreen'), lty=1)

# Plot two-panel for 1975 forward
par(mfrow=c(1,2))
plot(100*gdi.pct.df$compensation['1975::'], main="% Income to worker compensation")
lines(SMA(100*gdi.pct.df$compensation['1965::'],40),col='red',lty=2)
plot(100*gdi.pct.df$netopsurplus['1975::'], main="% Income to firm profit")
lines(SMA(100*gdi.pct.df$netopsurplus['1965::'],40),col='red',lty=2)
par(mfrow=c(1,1))

# Plot two-panel for 1959 forward
par(mfrow=c(1,2))
plot(100*gdi.pct.df$compensation, main="% Income to worker compensation")
lines(SMA(100*gdi.pct.df$compensation,40),col='red',lty=2)
plot(100*gdi.pct.df$netopsurplus, main="% Income to firm profit")
lines(SMA(100*gdi.pct.df$netopsurplus,40),col='red',lty=2)
par(mfrow=c(1,1))

gdi.pct.df[which(gdi.pct.df$compensation==max(gdi.pct.df$compensation))]
gdi.pct.df[which(gdi.pct.df$netopsurplus==min(gdi.pct.df$netopsurplus))]

cor(gdi.pct.df,use='complete.obs')


# Labor share index
getSymbols('PRS85006173',src='FRED')
plot(PRS85006173, ylab="Index (based on 2009)", main="Labor Share of Income (nonfarm business)")
lines(SMA(PRS85006173,30),col='red')
abline(h=100,lty=2)