#######################################################################
##
##Data

#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#Set Working Directory

#1. Merge the training and the test data.

#reading the data 

features        <- read.table("./features.txt",header=FALSE)
activityLabel   <- read.table("./activity_labels.txt",header=FALSE)
subjectTrain    <-read.table("./train/subject_train.txt", header=FALSE)
xTrain          <- read.table("./train/X_train.txt", header=FALSE)
yTrain          <- read.table("./train/y_train.txt", header=FALSE)
subjectTest    <-read.table("./test/subject_test.txt", header=FALSE)
xTest         <- read.table("./test/X_test.txt", header=FALSE)
yTest         <- read.table("./test/y_test.txt", header=FALSE)

#Assign column names 

colnames(activityLabel)<-c("activityId","activityType")
colnames(subjectTrain) <- "subId"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"
colnames(subjectTest) <- "subId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

#Merging training Data.

trainData <- cbind(yTrain,subjectTrain,xTrain)
testData <- cbind(yTest,subjectTest,xTest)
finalData <- rbind(trainData,testData)

#vector for column
colNames <- colnames(finalData)

# 2. Extract only the measurements on the mean and standard deviation for each measurement
data_mean_std <-finalData[,grepl("mean|std|subject|activityId",colnames(finalData))]

#3. #Uses descriptive activity names to name the activities in the data set
library(plyr)
data_mean_std <- join(data_mean_std, activityLabel, by = "activityId", match = "first")
data_mean_std <-data_mean_std[,-1]

#4. Appropriately labels the data set with descriptive variable names.

#Remove parentheses

names(data_mean_std) <- gsub("\\(|\\)", "", names(data_mean_std), perl  = TRUE)

#correct syntax in names

names(data_mean_std) <- make.names(names(data_mean_std))

#add descriptive names

names(data_mean_std) <- gsub("Acc", "acceleration", names(data_mean_std))
names(data_mean_std) <- gsub("^t", "time", names(data_mean_std))
names(data_mean_std) <- gsub("^f", "frequency", names(data_mean_std))
names(data_mean_std) <- gsub("BodyBody", "body", names(data_mean_std))
names(data_mean_std) <- gsub("mean", "mean", names(data_mean_std))
names(data_mean_std) <- gsub("std", "std", names(data_mean_std))
names(data_mean_std) <- gsub("Freq", "frequency", names(data_mean_std))
names(data_mean_std) <- gsub("Mag", "magnitude", names(data_mean_std))

#creates a second, independent tidy data set with the average of each variable for each activity and each subject.


tidydata_average_sub<- ddply(data_mean_std, c("subject","activity"), numcolwise(mean))


write.table(tidydata_average_sub,file="tidydata.txt",row.names = FALSE)

