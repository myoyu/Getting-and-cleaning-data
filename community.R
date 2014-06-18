library(data.table)
setwd("D:\\Data\\Training\\Getting and cleaning data\\assignment");
if(!file.exists("community.csv"))
{
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv";
  download.file(url,destfile="community.csv");
}
DT = fread("community.csv");
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean));
system.time(tapply(DT$pwgtp15,DT$SEX,mean));
system.time(mean(DT$pwgtp15,by=DT$SEX));

system.time(DT[,mean(pwgtp15),by=SEX]);
system.time(mean(DT[DT$SEX==1,]$pwgtp15)); 
system.time(mean(DT[DT$SEX==2,]$pwgtp15));
system.time(rowMeans(DT)[DT$SEX==1]); 
system.time(rowMeans(DT)[DT$SEX==2]);