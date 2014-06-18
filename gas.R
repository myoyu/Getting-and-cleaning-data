setwd("D:\\Data\\Training\\Getting and cleaning data\\assignment");
if(!file.exists("gas.xlsx"))
{
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx";
  download.file(url,destfile="gas.xlsx",mode="wb");
}
data = read.csv("house.csv",sep=",",header=TRUE);

library(xlsx);
dat = read.xlsx("gas.xlsx",sheetIndex=1,colIndex=7:15,rowIndex=18:23);
sum(dat$Zip*dat$Ext,na.rm=T);