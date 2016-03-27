#########################################################
# Created by: D.Dakhno
#########################################################
#-Downloads the and reads the rawdata
#-Merges the training and the test sets to create one data set.
#-Extracts only the measurements on the mean and standard deviation for each 
#measurement.
#-Uses descriptive activity names to name the activities in the data set
#-Appropriately labels the data set with descriptive variable names.
#-From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

#For performance and convenience
library(data.table)
library(dplyr)

#Cleaning and setting and  up the environment - working directory is arbitrary, up to user
#Cleaning up is made in script for reproducibility
objlst <- ls()
rm(list = objlst)
if (file.exists("data/Dataset.zip")) {
    unlink("data/Dataset.zip")
    unlink("data/UCI HAR Dataset", recursive = TRUE)
}
if (file.exists("Output-Datasets_Getting_and_Cleaning_Data_Course_Project.zip"))
{
        unlink("Output-Datasets_Getting_and_Cleaning_Data_Course_Project.zip")
}
if (file.exists("only_mean_and_std_dataset.txt"))
{
    unlink("only_mean_and_std_dataset.txt")
}
if (file.exists("mean_by_subject_and_activity_dataset.txt"))
{
    unlink("mean_by_subject_and_activity_dataset.txt")
}

#Setting up
if (!dir.exists("data")) dir.create("data")
rawdatadir <- "data"

#Downloading the data source file...
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(URL, destfile = "data/Dataset.zip", mode = "wb")

#...unzipping and reading the rawdata (frome a number of datafiles)
unzip(zipfile = "data/Dataset.zip",exdir = rawdatadir)
rawdatadir <- paste(rawdatadir,"UCI HAR Dataset",sep = "/")

#Reading the list of all 561-feature vector with time and frequency domain variables -> columnnames
features <- read.table(paste(rawdatadir,"features.txt",sep = "/"), header = FALSE, as.is = 1)
meanstdheader <- as.character(grep("-(mean|std)\\(\\)",features[[2]], value = TRUE))
meanstdheaderPos <- grep("-(mean|std)\\(\\)",features[[2]])

varnames <- gsub("-mean","Mean",meanstdheader)
varnames <-  gsub("-std","Std",varnames)
varnames <- gsub("[^[:alnum:]]","",varnames)





#Reading, re-selecting, labelling and flagging the training data set (file train/X_train.txt)
trainDS <- read.table(paste(rawdatadir,"train/X_train.txt",sep = "/"), header = FALSE, as.is = 1:561)
trainDS <- select(trainDS,meanstdheaderPos)
trainDS$partition <- "training"

#Reading in the subject id for training, injecting into the appr. column trainDS
trainSubjects <- read.table(paste(rawdatadir,"train/subject_train.txt",sep = "/"), header = FALSE)
trainDS$subject_id <- trainSubjects[[1]]


#Reading and flagging the test data set (file test/X_test.txt)
testDS <- read.table(paste(rawdatadir,"test/X_test.txt",sep = "/"), header = FALSE, as.is = 1:561)
testDS <- select(testDS,meanstdheaderPos)

testDS$partition <- "test"

#Reading in the subject for test, injecting the corr. column into testDS
testSubjects <- read.table(paste(rawdatadir,"test/subject_test.txt",sep = "/"), header = FALSE)
testDS$subject_id <- testSubjects[[1]]

#Reading the training labels as numerics (train/y_train.txt)
trainLAB <- read.table(paste(rawdatadir,"train/y_train.txt",sep = "/"), header = FALSE, as.is = 1)
#Reading the test labels (test/y_test.txt)
testLAB <- read.table(paste(rawdatadir,"test/y_test.txt",sep = "/"), header = FALSE, as.is = 1)

#Mapping the meaningful activity labels, transforming textual to lower
descrLAB <- read.table(paste(rawdatadir,"activity_labels.txt",sep = "/"),  header = FALSE, as.is = 1:2) 
colnames(descrLAB) <- c("numeric","text")
descrLAB$text <- tolower(descrLAB$text)
descrLAB <- data.table(descrLAB)
setkey(descrLAB,numeric)

#Test - substituting the numeric activity labels with descriptive activity names,
#writing the descr. labels direct into the test data set
testDS$activity <- sapply(testLAB,function(x) { descrLAB[x]$text })

#Training - substituting the numeric activity labels with descriptive activity names 
#(activity_labels.txt)
trainDS$activity <- sapply(trainLAB,function(x) { descrLAB[x]$text })

#Merging data to full dataset
only_mean_and_std_DS <- bind_rows(trainDS,testDS)

#Fixing the factors
only_mean_and_std_DS$partition <- as.factor(only_mean_and_std_DS$partition)
only_mean_and_std_DS$subject_id <- as.factor(only_mean_and_std_DS$subject_id)
only_mean_and_std_DS$activity <- as.factor(only_mean_and_std_DS$activity)

#Inject human readable column headers
colnames(only_mean_and_std_DS) <- c(varnames,c("partition","subject_id","activity"))

#Reorganizing the output data set - bringing the fixed variables to the positions
#+1,2,3

fixvar <- grep("^(subject_id|activity|partition)$",colnames(only_mean_and_std_DS))
only_mean_and_std_DS <- bind_cols(only_mean_and_std_DS[,fixvar],only_mean_and_std_DS[,-fixvar])

#Creating an independent tidy data set with the average of 
#each variable for each activity and each subject (i.e. averaging over all test&training)


#Groupping over subject and activity with chaining/piping
mean_by_subject_and_activity_DS <- only_mean_and_std_DS%>%
    group_by(subject_id, activity)%>%
        summarise_each(funs = c("mean"))

##The same without chaining w
#groupped <- group_by(only_mean_and_std_DS, subject_id, activity) 
#grouped_mean_DS_2 <- summarize_each(groupped, funs = "mean")})


#Throwing the already fused column partition away 
mean_by_subject_and_activity_DS$partition <- NULL

write.table(x = only_mean_and_std_DS, file = "only_mean_and_std_dataset.txt", quote = FALSE)
write.table(x = mean_by_subject_and_activity_DS, file = "mean_by_subject_and_activity_dataset.txt", quote = FALSE)

#Zipping the data files
zip(zipfile  = "Output-Datasets_Getting_and_Cleaning_Data_Course_Project.zip",files = c("CodeBook.md","README.md", "only_mean_and_std_dataset.txt","mean_by_subject_and_activity_dataset.txt"))


