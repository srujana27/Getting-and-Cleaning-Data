library(dplyr)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile ="./data/Datastep.zip",method="curl")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
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

dataFeatures <- read.table(file.path(path_rf,"features.txt"))
dataActivity <- read.table(file.path(path_rf,"activity_labels.txt"))

## Step 1 - Merge the training and the test sets to create one data set
train <- cbind(dataSubjectTrain,dataActivityTrain,dataFeaturesTrain)
test <- cbind(dataSubjectTest,dataActivityTest,dataFeaturesTest)
Activities <- rbind(train, test)
x <- as.vector(dataFeatures[,2])
colnames(Activities) <- c("Subject", x, "Activity")

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
columnsWithMeanSTD <- grepl("Subject|Activity|mean|Mean|std", colnames(Activities))
Activities <- Activities[, columnsWithMeanSTD]

## Step 3:Uses descriptive activity names to name the activities in the data set

Activities$Activity <- factor(Activities$Activity, levels = dataActivity[, 1], labels = dataActivity[, 2])

## Step 4 - Appropriately label the data set with descriptive variable names

rename <- colnames(Activities)
rename <- gsub("[\\(\\)-]", "", rename)
rename <- gsub("BodyBody", "Body", rename)
rename <- gsub("^f", "FrequencyDomain", rename)
rename <- gsub("^t", "TimeDomain", rename)
rename <- gsub("Acc", "Accelerometer",rename)
rename <- gsub("Gyro", "Gyroscope", rename)
rename <- gsub("Mag", "Magnitude",rename)
rename <- gsub("Freq", "Frequency", rename)
rename <- gsub("mean", "Mean", rename)
rename <- gsub("std", "Standard Deviation", rename)

colnames(Activities) <- rename

## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
ActivitiesAverage <- Activities %>% 
group_by(Subject, Activity) %>%
summarize_all(funs(mean))

write.table(ActivitiesAverage, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
 

