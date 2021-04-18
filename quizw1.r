library(dplyr)
library(xlsx)
library(data.table)
library(XML)
directory = "/Users/antop/Documents/R/acs.xlsx"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", directory)
f <- read.csv(directory)
valmillon <- filter(f, VAL == 24)
nrow(valmillon)

d2 <- "/Users/antop/Documents/R/gn.xlsx"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile= d2, mode='wb')          
dat <- read.xlsx(file = d2, sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
dat
sum(dat$Zip*dat$Ext,na.rm=T)

d3 <- "/Users/antop/Documents/R/br.xml"
c <- xmlTreeParse(sub("s", "","https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"), useInternal=TRUE)
rootNode <- xmlRoot(c)
ZipCodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
zip <- ZipCodes[ZipCodes == 21231]
length(zip)

