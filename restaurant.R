setwd("D:\\Data\\Training\\Getting and cleaning data\\assignment");
if(!file.exists("restaurant.xml"))
{
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml";
  download.file(url,destfile="restaurant.xml");
}

library(XML);
doc = xmlTreeParse("restaurant.xml",useInternal=TRUE);
rootNode = xmlRoot(doc);
zc = xpathSApply(doc,"//zipcode",xmlValue);
sum(zc=="21231");
#data = read.csv("restaurant.xml",sep=",",header=TRUE);