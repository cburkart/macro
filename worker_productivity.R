library(quantmod)

# Nonfarm Business Sector: Output Per Hour of All Persons (OPHNFB)
# Nonfarm Business Sector: Real Compensation Per Hour (COMPRNFB)
# Real Gross Domestic Product, 3 Decimal (GDPC1)
# 

getSymbols(c('OPHNFB','COMPRNFB','GDPC1'),src='FRED')

# Index all of them to first year of series
OPH <- OPHNFB/as.numeric(OPHNFB[1])*100
COM <- COMPRNFB/as.numeric(COMPRNFB[1])*100
GDP <- GDPC96/as.numeric(GDPC1[1])*100

plot(GDP, ylab="Index (1947=100)")
lines(GDP,lwd=2)
lines(COM,lwd=2,col='darkgreen')
lines(OPH,lwd=2,col='blue')
legend(x="topleft", c('GDP','Real Compensation','Output per Hour'), col=c('black','darkgreen','blue'), lwd=2)
