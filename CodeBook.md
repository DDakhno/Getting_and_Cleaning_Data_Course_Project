---
title: "Getting and Cleaning Data Course Project: Code Book"
author: "D.Dakhno"
date: "March 25, 2016"
output: html_document
---


##Introduction
This  Code Book describes the structure of the data sets generated through the script run_analysis.R developed by D.Dakhno for the Getting and Cleaning Data Course Project.
The source of the data processed by the script is the project [Smartphone-Based Recognition of Human Activities and Postural Transitions Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Contents of the data sets

There are two data sets (and files), delivered as a result of the analysis made by the script run_analysis.R upon the original data:

1. only_mean_and_std_DS - merged of test and training data sets, essentially only the measurements on the mean and standard deviation for each measurement, completed with the descriptive activity labels and test subject IDs.
2. mean_by_group_DS - data set with the average of each variable for each activity and each subject (derived from the first data set).

For details see in README.md file.


##Selection of relevant data from original data sets
There are values for 561 different measured variables in the original data set (see original file features.txt).  
For automated selection of the for the test relevant variables I used the patterns 
"-mean" and "-std" in the original variable names. Below the line we got 66 variables matching
the criteria.

##Naming conventions
The column names/headers in the generated data set follow this conventions:  
- maximal retaining of the meaningful information from original variable names   
- only alphanumeric characters allowed  
- accenting the of the statistical meaning as a suffix ("...Mean" or "...Std")  


##Variables description and relation to the original variables
There are following variables (column headers) constituting in the output data sets of the script :


Variable | Description | Units | Original variable  
---------|-------------|-------|-------------------------------------------------------
*Fixed variables* | | |  
partition | factor, 2 levels | |Mapped test or training data set   
subject_id | factor, 30 levels | |Subject ID from files subject_train.txt and subject_test.txt
activity | factor, 6 levels | |sourced from original y_test.txt or y_train.txt file, mapped to the text  values from activity_labels.txt  
*Measured variables* | | |
tBodyAccMeanX | lin. acceleration | gravity units "g" | tBodyAcc-mean()-X
tBodyAccMeanY | lin. acceleration | gravity units "g" | tBodyAcc-mean()-Y
tBodyAccMeanZ | lin. acceleration | gravity units "g" | tBodyAcc-mean()-Z
tBodyAccStdX | lin. acceleration | gravity units "g" | tBodyAcc-std()-X
tBodyAccStdY | lin. acceleration | gravity units "g" | tBodyAcc-std()-Y
tBodyAccStdZ | lin. acceleration | gravity units "g" | tBodyAcc-std()-Z
tGravityAccMeanX | lin. acceleration | gravity units "g" | tGravityAcc-mean()-X
tGravityAccMeanY | lin. acceleration | gravity units "g" | tGravityAcc-mean()-Y
tGravityAccMeanZ | lin. acceleration | gravity units "g" | tGravityAcc-mean()-Z
tGravityAccStdX | lin. acceleration | gravity units "g" | microgravity-std()-X
microgravity | lin. acceleration | gravity units "g" | tGravityAcc-std()-Y
tGravityAccStdZ | lin. acceleration | gravity units "g" | tGravityAcc-std()-Z
tBodyAccJerkMeanX | lin. acceleration | gravity units "g" | tBodyAccJerk-mean()-X
tBodyAccJerkMeanY | lin. acceleration | gravity units "g" | tBodyAccJerk-mean()-Y
tBodyAccJerkMeanZ | lin. acceleration | gravity units "g" | tBodyAccJerk-mean()-Z
tBodyAccJerkStdX | lin. acceleration | gravity units "g" | tBodyAccJerk-std()-X
tBodyAccJerkStdY | lin. acceleration | gravity units "g" | tBodyAccJerk-std()-Y
tBodyAccJerkStdZ | lin. acceleration | gravity units "g" | tBodyAccJerk-std()-Z
tBodyGyroMeanX | angular velocity | rad./second | tBodyGyro-mean()-X
tBodyGyroMeanY | angular velocity | rad./second | tBodyGyro-mean()-Y
tBodyGyroMeanZ | angular velocity | rad./second | tBodyGyro-mean()-Z
tBodyGyroStdX | angular velocity | rad./second | tBodyGyro-std()-X
tBodyGyroStdY | angular velocity | rad./second | tBodyGyro-std()-Y
tBodyGyroStdZ | angular velocity | rad./second | tBodyGyro-std()-Z
tBodyGyroJerkMeanX | angular velocity | rad./second | tBodyGyroJerk-mean()-X
tBodyGyroJerkMeanY | angular velocity | rad./second | tBodyGyroJerk-mean()-Y
tBodyGyroJerkMeanZ | angular velocity | rad./second | tBodyGyroJerk-mean()-Z
tBodyGyroJerkStdX | angular velocity | rad./second | tBodyGyroJerk-std()-X
tBodyGyroJerkStdY | angular velocity | rad./second | tBodyGyroJerk-std()-Y
tBodyGyroJerkStdZ | angular velocity | rad./second | tBodyGyroJerk-std()-Z
tBodyAccMagMean | lin. acceleration | gravity units "g" | tBodyAccMag-mean()
tBodyAccMagStd | lin. acceleration | gravity units "g" | tBodyAccMag-std()
tGravityAccMagMean | lin. acceleration | gravity units "g" | tGravityAccMag-mean()
tGravityAccMagStd | lin. acceleration | gravity units "g" | tGravityAccMag-std()
tBodyAccJerkMagMean | lin. acceleration | gravity units "g" | tBodyAccJerkMag-mean()
tBodyAccJerkMagStd | lin. acceleration | gravity units "g" | tBodyAccJerkMag-std()
tBodyGyroMagMean | angular velocity | rad./second | tBodyGyroMag-mean()
tBodyGyroMagStd | angular velocity | rad./second | tBodyGyroMag-std()
tBodyGyroJerkMagMean | angular velocity | rad./second | tBodyGyroJerkMag-mean()
tBodyGyroJerkMagStd | angular velocity | rad./second | tBodyGyroJerkMag-std()
fBodyAccMeanX | lin. acceleration | gravity units "g" | fBodyAcc-mean()-X
fBodyAccMeanY | lin. acceleration | gravity units "g" | fBodyAcc-mean()-Y
fBodyAccMeanZ | lin. acceleration | gravity units "g" | fBodyAcc-mean()-Z
fBodyAccStdX | lin. acceleration | gravity units "g" | fBodyAcc-std()-X
fBodyAccStdY | lin. acceleration | gravity units "g" | fBodyAcc-std()-Y
fBodyAccStdZ | lin. acceleration | gravity units "g" | fBodyAcc-std()-Z
fBodyAccJerkMeanX | lin. acceleration | gravity units "g" | fBodyAccJerk-mean()-X
fBodyAccJerkMeanY | lin. acceleration | gravity units "g" | fBodyAccJerk-mean()-Y
fBodyAccJerkMeanZ | lin. acceleration | gravity units "g" | fBodyAccJerk-mean()-Z
fBodyAccJerkStdX | lin. acceleration | gravity units "g" | fBodyAccJerk-std()-X
fBodyAccJerkStdY | lin. acceleration | gravity units "g" | fBodyAccJerk-std()-Y
fBodyAccJerkStdZ | lin. acceleration | gravity units "g" | fBodyAccJerk-std()-Z
fBodyGyroMeanX | angular velocity | rad./second | fBodyGyro-mean()-X
fBodyGyroMeanY | angular velocity | rad./second | fBodyGyro-mean()-Y
fBodyGyroMeanZ | angular velocity | rad./second | fBodyGyro-mean()-Z
fBodyGyroStdX | angular velocity | rad./second | fBodyGyro-std()-X
fBodyGyroStdY | angular velocity | rad./second | fBodyGyro-std()-Y
fBodyGyroStdZ | angular velocity | rad./second | fBodyGyro-std()-Z
fBodyAccMagMean | lin. acceleration | gravity units "g" | fBodyAccMag-mean()
fBodyAccMagStd | lin. acceleration | gravity units "g" | fBodyAccMag-std()
fBodyBodyAccJerkMagMean | lin. acceleration | gravity units "g" | fBodyBodyAccJerkMag-mean()
fBodyBodyAccJerkMagStd | lin. acceleration | gravity units "g" | fBodyBodyAccJerkMag-std()
fBodyBodyGyroMagMean | angular velocity | rad./second | fBodyBodyGyroMag-mean()
fBodyBodyGyroMagStd | angular velocity | rad./second | fBodyBodyGyroMag-std()
fBodyBodyGyroJerkMagMean | angular velocity | rad./second | fBodyBodyGyroJerkMag-mean()
fBodyBodyGyroJerkMagStd | angular velocity | rad./second | fBodyBodyGyroJerkMag-std()

##Variable values - differences between the data sets

There are two datasets in the output of the script: only_mean_and_std_DS and mean_by_group_DS.  
The fixed variables in the first data set (partition, subject_id and activity) come as result of the transforming and mapping of original features in to uniform layout (see README.md). The measured variables here are the result of selection of only mean and standard deviation values from the original data sets, so You can find the same values here as at the appropriate positions in the original data sets. 
The variable names in the data set mean_by_group_DS are the same; only the column "partition" is superfluous through the summarizing over subject ID and activity. The values of the measured variables are respectively the mean for each person and activity (30x6 = 180 combinations).

