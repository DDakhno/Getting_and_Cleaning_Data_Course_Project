---
title: "Getting and Cleaning Data Course Project: requirements, definitions and script run_analysis.R"
author: "D.Dakhno"
date: "March 25, 2016"
output: html_document
---

##Requirements

Following demands had to be met with respect to the processing and output datasets:

- The submitted data set is tidy. 
- Merging the training and the test sets to create one data set.
- Extracting only the measurements on the mean and standard deviation for each measurement.
- Descriptive activity names to name the activities in the data set
- Appropriately labeling the data set with descriptive variable names/column headers.
- Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

##Definition of a tidy data set
The working definition of a tidy data set is (see the course materials and Hadley Wickham's ["Tidy Data"](http://vita.had.co.nz/papers/tidy-data.pdf)):

1.    Each variable forms a column (the variable is elementary, i.e. not a combination of two or more factors). The contents of individual columns are of unique meaning, not logically interchangeable or alternative.
2.    Each observation forms a row
3.    Meaningful column headers
4.    Fixed variables has position in the front (first columns).
4.    Each table/file stores data about one kind of observation (e.g. people/hospitals).

##Variable
Under "variable" we mean a measured value, that is a value of technical 
art (for the list of variables see CodeBook as well as features.txt in the downloaded original data sources)

##Observation
"Observation" means a combination of  fixed variables (dimensions) subject_id, 
activity and partition (test or training), each of them considered to be atomic 
and independent parameter (observation = subject_id + activity + partition (test or training)). OK, the 
partitioning into test and trial was made randomized retrospective. It is not 
really a given precondition but serves the aims of statistical pureness.  So 
defined, observations are obviously not unique in the given experiment design, 
so all test persons has repeated each kind of activities in multiple trials. 

##Kind of observation - separation of data structures
With regard to the contents and layout of the data set as well as given test tasks 
the main direction is proper assembling of the data.  In the given case there is 
no really need for  a some kind of separation. 

##Analysis script (run_analysis.R)
The script implements all the steps from downloading the source data files up to writing out the tidy data in two separate data files and archiving the result into zip file.
The script makes no use of any command line arguments. Only one implicit parameter -
working directory - is up to user of the script.
For the details of implementation see the comments in the script.
I have tried and compared different packages and techniques - dplyr is really 
smart!

##Procedures merging the data with the script
As a basis for merging of data I used the training set tables (from files 
X_train.txt and X_test.txt). 
Merging of data from different tables using the common id/key of two tables was not possible. So, by the values without explicit key like raw numeric activity or subject codes the assumption was made, their order matches that in the main database. Such data were inserted as additional column.
Additional column "partition" was inserted after extracting the test and
training data to preserve the distinction for future analysis. 
  
The cooking recipe is as follows:  
- clean and set up the environment removing the rests of the previous executions
- download the zipped raw data from Internet  
- unzip the downloaded data  
- setup the path to the root of the data directory structure  
- read the list of all 561-feature vector with time and frequency domain variables into the data table "features"  
- select the relevant feature names into the character vector "meanstdheader" (pattern "-(mean|std)\\(\\)")  
- select the relevant feature positions into the character vector "meanstdheaderPos" (pattern "-(mean|std)\\(\\)")  
- generate the vector of the variable names (column headers) according to the predefined criteria (only alphanumeric characters, accenting of "Mean" and "Std"")  
- read the training data set (from file train/X_train.txt) into the data table "trainDS"  
- leave only the relevant columns in the "trainDS" (selecting them with meanstdheaderPos)  
- set the flag "training" into the new column "trainDS$partition"
- read the test labels as numeric (from file test/y_test.txt) into the data table "testLAB"  
- read the test data set (from file test/X_test.txt) into the data table "trainDS"  
- leave only the relevant columns in the "testDS" (selecting them)  
- set the flag "test" into the new column "partition"  
- read the subject ids for test, insert into the column "subject_id"
- read the training labels (numeric for activities; from file train/y_train.txt) into the data table "trainLAB"  
- read the test labels (numeric for activities; from file test/y_test.txt) into the data table "testLAB"  
- read the mapping of numeric to descriptive activity names from file "activity_labels.txt" into the data table "descrLAB"  
- substitute the numeric activity labels with descriptive activity names in testDS and trainDS  
- merge trainDS and testDS into data set "only_mean_and_std_DS"  
- mark fixed variables as a factors  
- inject human readable column headers  into "only_mean_and_std_DS"
- reorganize "only_mean_and_std_DS" - bring the fixed variables to the positions 1,2,3  
- the first data set "only_mean_and_std_DS" is ready for delivery
- generate the second data set "mean_by_group_DS": grouping "only_mean_and_std_DS" over subject and activity with chaining/piping, summarizing with mean()
- leave away the obsolete column "partition" in "mean_by_group_DS"
- write the two data sets into the text files, zip them












