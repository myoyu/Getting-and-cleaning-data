setwd("D:\\Data\\Training\\Getting and cleaning data\\assignment");
if(!file.exists("q2q2.csv"))
{
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv";
  download.file(url,destfile="q2q2.csv");
}
acs = read.csv("q2q2.csv",sep=",",header=TRUE);
options(sqldf.driver = "SQLite");
data = sqldf("select pwgtp1 from acs where AGEP < 50");
