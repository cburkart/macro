# Risk Premium measure: 
# Compare 10yr Treasuries constant maturity (DGS10), BAA corporate bonds (DBAA)

library(quantmod)

getSymbols(c('DGS10','DBAA'), src='FRED')

dbaa.mo <- as.zoo(Cl(to.monthly(DBAA)))
dgs10.mo <- as.zoo(Cl(to.monthly(DGS10)))
spread.mo <- dbaa.mo - dgs10.mo
plot(dbaa.mo, col='grey', lwd=1, ylim=c(1,12))
lines(dgs10.mo, col='lightblue', lwd=1)
lines(spread.mo, col='orange', lwd=2)
legend('topright', c('10yr Treasury (Constant Maturity)','BAA Corporate Bonds','Spread'), col=c('lightblue','grey','orange'), lwd=2)
