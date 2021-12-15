library(quantmod)
library(calibrate)
# Capital-per-worker measure

# PWT Country codes:
# 
# AR - Argentina
# AM - Armenia
# AU - Australia
# AT - Austria
# BH - Bahrain
# BB - Barbados
# BE - Belgium
# BJ - Benin
# VE - (Bolivarian Republic of ) Venezuela
# BW - Botswana
# BR - Brazil
# BG - Bulgaria
# BI - Burundi
# CM - Cameroon
# CA - Canada
# CF - Central African Republic
# CL - Chile
# CN - China
# CO - Colombia
# CR - Costa Rica
# CI - Cote D'Ivoire
# HR - Croatia
# CY - Cyprus
# CZ - Czech Republic
# DK - Denmark 
# DO - Dominican Republic
# EC - Ecuador
# EG - Egypt
# EE - Estonia
# FJ - Fiji
# FI - Finland
# FR - France
# GA - Gabon
# DE - Germany
# GR - Greece
# GT - Guatemala
# HN - Honduras
# HK - Hong Kong
# HU - Hungary
# IS - Iceland
# IN - India
# ID - Indonesia
# IQ - Iraq
# IE - Ireland
# IR - (Islamic Republic of) Iran
# IL - Israel
# IT - Italy
# JM - Jamaica
# JP - Japan
# JO - Jordan
# KZ - Kazakhstan
# KE - Kenya
# KW - Kuwait
# KG - Kyrgyzstan
# LV - Latvia
# LS - Lesotho
# LT - Lithuania
# LU - Luxembourg
# MO - Macao
# MY - Malaysia
# MT - Malta
# MR - Mauritania
# MU - Mauritius
# MX - Mexico
# MN - Mongolia
# MA - Morocco
# MZ - Mozambique
# NA - Namibia
# NL - Netherlands
# NZ - New Zealand
# NE - Niger
# NO - Norway
# PA - Panama
# PY - Paraguay
# PE - Peru
# PH - Philippines
# PL - Poland
# PT - Portugal
# TW - (Province of) Taiwan
# QA - Qatar
# KR - (Republic of) Korea
# MD - (Republic of) Moldova
# RO - Romania
# RU - Russian Federation
# RW - Rwanda
# SA - Saudi Arabia
# SN - Senegal
# RS - Serbia
# SL - Sierra Leone
# SG - Singapore
# SK - Slovakia
# SI - Slovenia
# ZA - South Africa
# ES - Spain
# LK - Sri Lanka
# SZ - Swaziland
# SE - Sweden
# CH - Switzerland
# TJ - Tajikistan
# TH - Thailand
# BO - (The Plurinational State of) Bolivia
# TG - Togo
# TT - Trinidad and Tobago
# TN - Tunisia
# TR - Turkey
# UA - Ukraine
# GB - United Kingdom
# TZ - United Republic of Tanzania
# US - United States
# UY - Uruguay
# ZW - Zimbabwe

c.symbs <- c('AR',  'AM',	'AU',	'AT',	'BH',	'BB',	'BE',	'BJ',	'VE',	'BW',	'BR',	'BG',	'BI',	'CM',	'CA',	'CF',	'CL',	'CN',	'CO',	'CR',	'CI',	'HR',	'CY',	'CZ',	'DK',	'DO',	'EC',	'EG',	'EE',	'FJ',	'FI',	'FR',	'GA',	'DE',	'GR',	'GT',	'HN',	'HK',	'HU',	'IS',	'IN',	'ID',	'IQ',	'IE',	'IR',	'IL',	'IT',	'JM',	'JP',	'JO',	'KZ',	'KE',	'KW',	'KG',	'LV',	'LS',	'LT',	'LU',	'MO',	'MY',	'MT',	'MR',	'MU',	'MX',	'MN',	'MA',	'MZ',	'NA',	'NL',	'NZ',	'NE',	'NO',	'PA',	'PY',	'PE',	'PH',	'PL',	'PT',	'TW',	'QA',	'KR',	'MD',	'RO',	'RU',	'RW',	'SA',	'SN',	'RS',	'SL',	'SG',	'SK',	'SI',	'ZA',	'ES',	'LK',	'SZ',	'SE',	'CH',	'TJ',	'TH',	'BO',	'TG',	'TT',	'TN',	'TR',	'UA',	'GB',	'TZ',	'US',	'UY',	'ZW')
c.names <- c('Argentina',  'Armenia',	'Australia',	'Austria',	'Bahrain',	'Barbados',	'Belgium',	'Benin',	'Venezuela',	'Botswana',	'Brazil',	'Bulgaria',	'Burundi',	'Cameroon',	'Canada',	'Central African Republic',	'Chile',	'China',	'Colombia',	'Costa Rica',	'Ivory Coast',	'Croatia',	'Cyprus',	'Czech Republic',	'Denmark',	'Dominican Republic',	'Ecuador',	'Egypt',	'Estonia',	'Fiji',	'Finland',	'France',	'Gabon',	'Germany',	'Greece',	'Guatemala',	'Honduras',	'Hong Kong',	'Hungary',	'Iceland',	'India',	'Indonesia',	'Iraq',	'Ireland',	'Iran',	'Israel',	'Italy',	'Jamaica',	'Japan',	'Jordan',	'Kazakhstan',	'Kenya',	'Kuwait',	'Kyrgyzstan',	'Latvia',	'Lesotho',	'Lithuania',	'Luxembourg',	'Macao',	'Malaysia',	'Malta',	'Mauritania',	'Mauritius',	'Mexico',	'Mongolia',	'Morocco',	'Mozambique',	'Namibia',	'Netherlands',	'New Zealand',	'Niger',	'Norway',	'Panama',	'Paraguay',	'Peru',	'Philippines',	'Poland',	'Portugal',	'Taiwan',	'Qatar',	 'Korea',	'Moldova',	'Romania',	'Russia',	'Rwanda',	'Saudi Arabia',	'Senegal',	'Serbia',	'Sierra Leone',	'Singapore',	'Slovakia',	'Slovenia',	'South Africa',	'Spain',	'Sri Lanka',	'Swaziland',	'Sweden',	'Switzerland',	'Tajikistan',	'Thailand',	'Bolivia',	'Togo',	'Trinidad and Tobago',	'Tunisia',	'Turkey',	'Ukraine',	'UK',	'Tanzania',	'United States',	'Uruguay',	'Zimbabwe')

# Set up string wrappers for "Capital stock at Current Purchasing Power Parities"
Kwrap1 <- 'CKSPPP'
Kwrap2 <- 'A666NRUG'

K.list <- list()
for (i in 1:length(c.symbs)){
  country.string <- paste(Kwrap1,c.symbs[i],Kwrap2, sep='')
  #message(country.string)
  K.list[[i]] <- get(getSymbols(country.string,src='FRED'))
}


# Wrapper for "Real GDP at Constant National Prices"
Ywrap1 <- 'RGDPNA'
Ywrap2 <- 'A666NRUG'
Y.list <- list()
for (i in 1:length(c.symbs)){
  country.string <- paste(Ywrap1,c.symbs[i],Ywrap2, sep='')
  #message(country.string)
  Y.list[[i]] <- get(getSymbols(country.string,src='FRED'))
}

# Wrapper for "Investment Share of Purchasing Power Parity Converted GDP Per Capita at constant prices"
swrap1 <- 'KIPPPG'
swrap2 <- 'A156NUPN'
s.list <- list()
for (i in 1:length(c.symbs)){
  country.string <- paste(swrap1,c.symbs[i],swrap2, sep='')
  #message(country.string)
  s.list[[i]] <- get(getSymbols(country.string,src='FRED'))
}



K <- unlist(lapply(K.list,last))
Y <- unlist(lapply(Y.list,last))
s <- unlist(lapply(s.list,function(x){mean(x['1970::'])}))

dframe <- data.frame(c.names,K/Y,s)

names(dframe) <- c('CountryName','CapitalOutput','SavingRate')

plot(dframe$SavingRate, dframe$CapitalOutput, xlim=c(5,48), xlab="Average savings (% of GDP) 1970-present", ylab="K/Y Ratio")
textxy(dframe$SavingRate, dframe$CapitalOutput, dframe$CountryName, cex=.6, col='darkgrey')
#abline(lm(CapitalOutput~SavingRate, data=dframe), col='red')