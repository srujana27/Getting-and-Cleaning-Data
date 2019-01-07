## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable fo

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile ="./data/Datastep.zip",method="curl")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
library(dplyr)
library(data.table)
library(tidyr)
path_rf<-file.path("./data","UCI HAR Dataset")
files <- list.files(path_rf, recursive = TRUE)
files 

### reading training data
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

### reading test data
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt"),header = FALSE)
dataFeaturesTest <- read.table(file.path(path_rf, "test", "X_test.txt"),header = FALSE)

### View Train data
str(dataSubjectTrain)
str(dataActivityTrain)
str(dataFeaturesTrain)

### View Test data
str(dataSubjectTest)
str(dataActivityTest)
str(dataFeaturesTest)

#### 1. Merge the training and test sets to create one data set.
subject <- rbind(dataSubjectTrain, dataSubjectTest)
activity <- rbind(dataActivityTrain, dataActivityTest)
features <- rbind(dataFeaturesTrain, dataFeaturesTest)
FeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(features)<- dataFeaturesNames$V2
dataCombine <- cbind(subject, activity)
completedData <- cbind(features, dataCombine)

#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completedData), ignore.case=TRUE)
requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(completedData)
removedData <- completedData[,requiredColumns]
dim(removedData)
write.table(removedData, "Mean_And_StdDev.txt")

#### 3. Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
head(completedData$activity,30)
 
#### 4. Appropriately labels the data set with descriptive variable names 

## View the data before labeling
names(removedData)

## Assign labels
names(removedData)<-gsub("Acc", "Accelerometer", names(removedData))
names(removedData)<-gsub("Gyro", "Gyroscope", names(removedData))
names(removedData)<-gsub("BodyBody", "Body", names(removedData))
names(removedData)<-gsub("Mag", "Magnitude", names(removedData))
names(removedData)<-gsub("^t", "Time", names(removedData))
names(removedData)<-gsub("^f", "Frequency", names(removedData))
names(removedData)<-gsub("tBody", "TimeBody", names(removedData))
names(removedData)<-gsub("-mean()", "Mean", names(removedData), ignore.case = TRUE)
names(removedData)<-gsub("-std()", "STD", names(removedData), ignore.case = TRUE)
names(removedData)<-gsub("-freq()", "Frequency", names(removedData), ignore.case = TRUE)
names(removedData)<-gsub("angle", "Angle", names(removedData))
names(removedData)<-gsub("gravity", "Gravity", names(removedData))

## View the data after labeling
names(removedData)

#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(removedData, "TidyData.txt", row.name=FALSE) 
 

