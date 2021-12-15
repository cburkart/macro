library(pwt)

data('pwt7.1')

s.korea <- subset(pwt7.1,pwt7.1$country=='Korea, Republic of')
philippines <- subset(pwt7.1,pwt7.1$country=='Philippines')
us <- subset(pwt7.1,pwt7.1$country=='United States of America')

plot(s.korea$year,s.korea$ki,typ='l',lwd=3,col='orange',xlab='Year',ylab='Saving rate (%)')
lines(philippines$year,philippines$ki,lwd=3,col='darkgreen')
lines(us$year,us$ki,lwd=3,col='blue')
abline(h=c(10,20,30,40),lty=2,col='grey')
abline(v=seq(from=1950,to=2010,by=10),lty=2,col='grey')
text(2007,40,'South Korea',col='darkorange')
text(2007,26,'United States',col='blue')
text(2007,14,'Philippines',col='darkgreen')
