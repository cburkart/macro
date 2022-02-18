library(quantmod)
library(ggplot2)
# Employment-Population Ratio - 25-54 Yrs.
LNS <- get(getSymbols('LNS12300060', src='FRED')); names(LNS) <- 'LNS'

ggplot(LNS, aes(x=Index,y=LNS)) + geom_line() + ggtitle("Employment-Population Ratio - 25-54 Yrs.")
ggplot(LNS['2000::'], aes(x=Index,y=LNS)) + geom_line() + ggtitle("Employment-Population Ratio - 25-54 Yrs., Year 2000 Onwards")



# Quit rate vs prime age employment, pre and post pandemic
quits <- get(getSymbols('JTSQUR', src='FRED')); names(quits) <- 'Quits'

scatter <- cbind(LNS, quits)
scatter <- scatter[which(!is.na(scatter$Quits)),]
Era <- rep("Pre-Pandemic", nrow(scatter))
Era[which(index(scatter) > '2020-03-01')] <- "Post-Pandemic"
Era <- as.factor(Era)
scatter <- data.frame(scatter,Era)

ggplot(scatter, aes(x=LNS, y=quits, color=Era)) + geom_jitter(width=.1,height=.1) + ggtitle("Quit rate vs prime age employment, pre and post pandemic")

LFPR55 <- get(getSymbols('LNS11324230', src='FRED')); names(LFPR55) <- 'LFPR55'
NILF <- 100 - LFPR55

# How to back out the Not-In-Labor-Force for 55-74 year olds? (want share of population)
# CPS page on FRED: https://fred.stlouisfed.org/categories/12
# Available data (only Census CPS as source)
# Labor Force Participation Rate - 25-54 Yrs. LNS11300060
# Labor Force Participation Rate - 55 Yrs. & over LNS11324230
# Labor Force Participation Rate CIVPART
# Not in Labor Force Seasonally Adjusted LNS15000000
# Not in Labor Force LNU05000000
# Civilian Labor Force Level CLF16OV
# Civilian Labor Force Level - 55 Yrs. & over LNS11024230
# Civilian Labor Force - 65 years and over TOTLL65O
# Population Level - 55 Yrs. & over (LNU00024230)
#
# Pop. Level 55+ > Civ. Labor Force 55+ > 55+ Workers (55+ LF * 55+ LFPR)
#
pop55 <- get(getSymbols('LNU00024230', src='FRED')); names(pop55) <- 'pop55'
lforce55 <- get(getSymbols('LNS11024230', src='FRED')); names(lforce55) <- 'lforce55'
lforce65 <- get(getSymbols('TOTLL65O', src='FRED')); names(lforce65) <- 'lforce65'

nilf55 <- (pop55 - lforce55)/pop55

# Early retirees?



