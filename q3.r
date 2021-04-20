library(dplyr)
library(data.table)
directory <- "C:C:/Users/Usuari_carp/Documents/R"
download.file ("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", dest ="q1.csv" )

doc <- read.csv("q1.csv")
agricultureLogical <- doc$ACR == 3 & doc$AGS == 6
which(agricultureLogical)
result

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", dest="q2.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", dest="q3.csv")
d1 = read.csv("q2.csv")
d2 = read.csv("q3.csv")
d1 <- d1[5:195,]
d1 <- select(d1, X, Gross.domestic.product.2012, X.3)
head(d1)
newd <- merge(d1, d2, by.x = "X", by.y = "CountryCode")
nrow(newd)
result <- newd %>% arrange(desc(as.numeric(Gross.domestic.product.2012)))
result [13, 1] 

#What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group? 
newd %>% group_by(Income.Group) %>%
  filter("High income: OECD" %in% Income.Group | "High income: nonOECD" %in% Income.Group) %>%
  summarize(Average = mean(as.numeric(Gross.domestic.product.2012), na.rm = T)) %>%
  arrange(desc(Income.Group))

#Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?
r <- newd %>% arrange(desc(as.numeric(Gross.domestic.product.2012))) %>% mutate(rank = cut(as.numeric(Gross.domestic.product.2012), breaks = 5)) 
a <- table(r$rank, r$Income.Group)
a[1, 4]
