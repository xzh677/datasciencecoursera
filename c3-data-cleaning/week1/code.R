#Q1
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv";
download.file(dataURL, destfile="data/q1data.csv", method="curl");

data <- read.csv("data/q1data.csv");
data[is.na(data$VAL), "VAL"] = 1;
values = data[["VAL"]];
length(values[values == 24]);

#Q2
#Tidy data has one variable per column.


#Q3

library(xlsx);

dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx";
download.file(dataURL, destfile="data/q2data.xlsx", method="curl");

data <- read.xlsx("data/q2data.xlsx");


#Q4

library(XML);
dataURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml";
doc <- xmlTreeParse(dataURL, useInternal=TRUE);
rootNode <- xmlRoot(doc);
zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
table(zipcode == 21231)

#Q5
library(data.table)
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv";
download.file(dataURL, destfile="data/q5data.csv", method="curl");
DT <- fread("data/q5data.csv");

check <- function(DT, f) {
	t <- system.time(y <- f(DT));
	message(sprintf("Elapsed time: %.10f", t[3]));
	print(y);
}

check(DT, function(DT) {tapply(DT$pwgtp15,DT$SEX,mean)})
check(DT, function(DT) {mean(DT$pwgtp15,by=DT$SEX) })
check(DT, function(DT) {rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] })
check(DT, function(DT) {mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15) })
check(DT, function(DT) { sapply(split(DT$pwgtp15,DT$SEX),mean) })
check(DT, function(DT) { DT[,mean(pwgtp15),by=SEX]})


#rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] WRONG
#mean(DT$pwgtp15,by=DT$SEX) WRONG
#sapply(split(DT$pwgtp15,DT$SEX),mean) WRONG