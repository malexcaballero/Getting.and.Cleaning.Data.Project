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


#Assign column names 

colnames(activityLabel)<-c("activityId","activityType")
colnames(subjectTrain) <- "subId"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"


#Merging training Data.

trainData <- cbind(yTrain,subjectTrain,xTrain)

#Reading Data

subjectTest    <-read.table("./test/subject_test.txt", header=FALSE)
xTest         <- read.table("./test/X_test.txt", header=FALSE)
yTest         <- read.table("./test/y_test.txt", header=FALSE)

# Assign column names

colnames(subjectTest) <- "subId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

# merging test Data
testData <- cbind(yTest,subjectTest,xTest)


#final merged data

finalData <- rbind(trainData,testData)

# creating a vector for column names to be used further

colNames <- colnames(finalData)

# 2. Extract only the measurements on the mean and standard deviation for each measurement


data_mean_std <-finalData[,grepl("mean|std|subject|activityId",colnames(finalData))]

