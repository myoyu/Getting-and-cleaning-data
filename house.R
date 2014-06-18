setwd("D:\\Data\\Training\\Getting and cleaning data\\assignment");
if(!file.exists("house.csv"))
{
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv";
  download.file(url,destfile="house.csv");
}
if(!file.exists("house_cookbook.pdf"))
{
  cookbook = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf";
  download.file(cookbook,destfile="house_cookbook.pdf",mode="wb");
}
data = read.csv("house.csv",sep=",",header=TRUE);
count = sum(data$VAL==24,na.rm=TRUE);
