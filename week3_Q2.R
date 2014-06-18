library("jpeg");

setwd("D:\\Data\\Training\\Getting and cleaning data\\assignment");
if(!file.exists("jeff.jpeg"))
{
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg";
  download.file(url,destfile="jeff.jpg",mode="wb");
}
picture = readJPEG(source="jeff.jpg",native=TRUE);
quantile(picture,probs=c(0.3,0.8))