#download and extract the raw data
if(!file.exists("HumanActivityRecognitionUsingSmartphones.zip"))
{
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
  download.file(url,destfile="HumanActivityRecognitionUsingSmartphones.zip",mode="wb");
  unzip("HumanActivityRecognitionUsingSmartphones.zip");
}

#read in the feature name that describe the feature data columns
featureName = read.csv("UCI HAR Dataset\\features.txt",sep="",header=FALSE);
#extract the feature name with "mean()" and "std()" naming in it
meanStdIndex = grepl("mean()\\>|std()\\>",featureName$V2);
#create the new feature column name
featureName = featureName[meanStdIndex,];
featureName$V2 = paste("ave",featureName$V2,sep="-"); 

#load the training feature data
trainFeature = read.csv("UCI HAR Dataset\\train\\X_train.txt",sep="",header=FALSE);
#load the training subject data
trainSubject = read.csv("UCI HAR Dataset\\train\\subject_train.txt",sep="",header=FALSE);
#load the training label data
trainLabel = read.csv("UCI HAR Dataset\\train\\y_train.txt",sep="",colClasses = "character",header=FALSE);
#filter the training feature data for mean and std measurement data only then 
#merge the training subject data to the left of training feature data and label data to the right
trainData = cbind.data.frame(trainSubject,trainFeature[,meanStdIndex],trainLabel);

#load the test feature data
testFeature = read.csv("UCI HAR Dataset\\test\\X_test.txt",sep="",header=FALSE);
#load the test subject data
testSubject = read.csv("UCI HAR Dataset\\test\\subject_test.txt",sep="",header=FALSE);
#load the test label data
testLabel = read.csv("UCI HAR Dataset\\test\\y_test.txt",sep="",colClasses = "character",header=FALSE);
#merge the test subject data to the left of test feature data and label data to the right
testData = cbind.data.frame(testSubject,testFeature[,meanStdIndex],testLabel);

#combine the training and testing data
combinedMeasurementMeanStdData = rbind(trainData,testData);

#update the column name 
colnames(combinedMeasurementMeanStdData) = c("SubjectID",featureName$V2,"HumanActivity");
#update the label data with more descriptive name rather than number...
library("gsubfn")
combinedMeasurementMeanStdData$HumanActivity = gsubfn("\\w+", list("1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", "5" = "STANDING", "6" = "LAYING"), combinedMeasurementMeanStdData$HumanActivity); 
#calculate the average of each variable for each activity and each subject
tidyData = aggregate(as.matrix(combinedMeasurementMeanStdData[,2:(ncol(combinedMeasurementMeanStdData)-1)])~SubjectID+HumanActivity,combinedMeasurementMeanStdData,mean)
write.table(tidyData,"tidy_dataset.txt",sep=",",row.names=FALSE);
