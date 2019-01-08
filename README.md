**Getting and Cleaning Data Course Project**
==================================

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:




**Project Goals**
=================

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation
    for each measurement.
3.  Uses descriptive activity names to name the activities in the data
    set
4.  Appropriately labels the data set with descriptive activity names.
5.  Create a second,independent tiny data set with the average of each
    variable for each activity and each subject.

The GitHub repository includes the following files:
===================================================

-   'README.md': describes how the script works
-   'run\_analysis.R': can be run as long as the Samsung data is in your
    working directory.
-   'activity\_labels.txt': Links the class labels with their activity
    name.
-   'codebook.md': describes the variables and summaries, along with
    units.
-   'tiny\_data.txt': contains the tiny data set created in step 5.

How the script works:
=====================

### Get the data by downloading the given files
    if(!file.exists("./data")){dir.create("./data")}
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,destfile ="./data/Datastep.zip",method="curl")

### Unzip the file and set a file path
    unzip(zipfile="./data/Dataset.zip",exdir="./data")
    path_rf<-file.path("./data","UCI HAR Dataset")
    files <- list.files(path_rf, recursive = TRUE)
    files 
### Read the test and train data
    dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
    dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
    dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

    dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
    dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt"),header = FALSE)
    dataFeaturesTest <- read.table(file.path(path_rf, "test", "X_test.txt"),header = FALSE)

    dataFeatures <- read.table(file.path(path_rf,"features.txt"))
    dataActivity <- read.table(file.path(path_rf,"activity_labels.txt"))

### Merge the test and train data using a rbind() function.

### Extract the measurements on the mean and standard deviation for each measurement
-   Take columns with Mean and Standard Deviation 
### Rename the variables activity, subject and activity names with descriptivenames. 
    prefix t is replaced by time 
    Acc is replaced by Accelerometer
    Gyro is replaced by Gyroscope 
    prefix f is replaced by frequency 
    Mag is replaced by Magnitude 
    BodyBody is replaced by Body 
    mean is replaced by Mean 
    std is replaced by Standard Deviation 
### Create a tiny\_data.txt file containing the average of each variable using the subject and activity. 
    ActivitiesMean <- Activities %>% 
    group_by(Subject, Activity) %>%
    summarize_all(funs(mean))
    write.table(ActivitiesMean, "tidy\_data.txt", row.names = FALSE, quote =
    FALSE)
   
