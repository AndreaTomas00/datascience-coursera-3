library("dplyr")
directory <- "C:/Users/Usuari_carp/Documents/R"
#Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", dest="q4a.csv")
doc <- read.csv("q4a.csv")
names(doc)
strsplit(names(doc), "^wgtp", fixed = FALSE)

#Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", dest = "gdp.csv")
a <- read.csv("gdp.csv")
a <- a[5:195,c(1,2,4,5)]
a <- mutate(a, X.3 = as.numeric(gsub(",", "", a$X.3)))
names(a) <- c("abrname", "rankgdp", "countryNames", "valorgdp")
str(a)
mean(a$valorgdp, na.rm=T)

#Pregunta 3: In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United? 
 
grep("^United", a$countryNames) 

#Pregunta 4: Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", dest="edudata.csv")
a <- read.csv("gdp.csv")
a <- a[5:194,c(1, 4)]
names(a) <- c("CountryCode","countryNames")
b <- read.csv("edudata.csv")
b <- b[, c(1,10)]
c <- merge(a, b, by="CountryCode")
nrow(c)
filas <- grep("Fiscal year end: June", c$Special.Notes)
filas
length(filas)

#Pregunta 5: You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sampleTimes <- sampleTimes[grep("2012", sampleTimes)]
length(sampleTimes)
sampleTimes <- lapply(sampleTimes, wday)
sampleTimes
length(grep("2", sampleTimes))
