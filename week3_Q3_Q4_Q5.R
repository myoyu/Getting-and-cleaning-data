library(reshape2)
setwd("D:\\Data\\Training\\Getting and cleaning data\\assignment");
if(!file.exists("gdp.csv"))
{
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv";
  download.file(url,destfile="gdp.csv");
}

if(!file.exists("edu.csv"))
{
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv";
  download.file(url,destfile="edu.csv");
}

gdp = read.csv("gdp.csv",sep=",",header=TRUE);
#cleaning up data
gdp = gdp[,c("X","Gross.domestic.product.2012","X.2","X.3")];
colnames(gdp) = c("CountryCode","Rank","Country","GDP");
gdp = gdp[5:194,];
edu = read.csv("edu.csv",sep=",",header=TRUE);
complete = merge(gdp,edu);
#match = outer(edu$CountryCode,gdp$CountryCode,"==");
length(intersect(edu$CountryCode,gdp$CountryCode))
sorted = sort(gdp$Rank,decreasing=TRUE);
gdp[sorted[13],]

#Q4
#solution 1
#first filter off the country code and country column, then convert the remaining column type to numeric.
#data = data.frame(lapply(X=dcast(complete,CountryCode + Country~Income.Group,value.var="GDP")[,-1:-2],function(x){as.numeric(gsub(",", "", x))}));
#is.na(data)
#colSums(data,na.rm=TRUE)/sum(is.na(data));
#solution 2
#complete$GDP = as.numeric(gsub(",", "", complete$GDP))
#tapply(complete$GDP,complete$Income.Group,mean)
#solution 3
#complete$Rank = as.numeric(levels(complete$Rank))[complete$Rank]
complete$Rank = as.numeric(as.character(complete$Rank))
tapply(complete$Rank,complete$Income.Group,mean)

#Q5
library("Hmisc")
complete$RankQ = cut2(complete$Rank,g=5);
xtabs(~complete$RankQ+Income.Group,data=complete);