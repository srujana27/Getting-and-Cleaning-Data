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

### Unzip the file and set a file path

### Read the test and train data

### Merge the test and train data using a rbind() function.

### Extract the measurements on the mean and standard deviation for each measurement

-   Take columns with Mean and Standard Deviation \#\#\# Rename the
    variables activity, subject and activity names with descriptive
    names. prefix t is replaced by time Acc is replaced by Accelerometer
    Gyro is replaced by Gyroscope prefix f is replaced by frequency Mag
    is replaced by Magnitude BodyBody is replaced by Body mean is
    replaced by Mean std is replaced by Standard Deviation \#\#\# Create
    a tiny\_data.txt file containing the average of each variable using
    the subject and activity. ActivitiesMean &lt;- Activities %&gt;%
    group\_by(Subject, Activity) %&gt;% summarize\_all(funs(mean))

write.table(ActivitiesMean, "tidy\_data.txt", row.names = FALSE, quote =
FALSE)
