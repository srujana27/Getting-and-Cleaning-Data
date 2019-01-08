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
   
