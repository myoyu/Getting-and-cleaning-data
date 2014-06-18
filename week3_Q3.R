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
