#--------------------------------------------------------------------------------------------
#
# Getting and Cleaning Data - Course Project
# 
# Date: May 24 2015
#
# Author: Alejandro Erasso
#
# This R code reads wearable data from the "Human Activity Recognition Using Smartphones Data Set" 
# and cleans them to provide a tidy data set with the mean values of the subject and activity 
# measurements.
# See ReadMe.txt for additional details on running this code.
# See CodeBook.md for the data dictionary of the output file, named "tidy_wearable_data.txt".
#
#--------------------------------------------------------------------------------------------



# - Reading data ----------------------------------------------------------------------------

fpath = file.path(getwd())

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl, destfile="Dataset.zip", mode="wb")   # Don't forget the binary mode!!!!

library(data.table)

fpath = file.path(getwd(), "UCI HAR Dataset/test/X_test.txt")
# fpath = file.path(getwd(), "Dataset.zip/UCI HAR Dataset/test/X_test.txt")
# fpath
file.exists(fpath)
X_test <- read.table(fpath, header = FALSE)

fpath = file.path(getwd(), "UCI HAR Dataset/test/Y_test.txt")
Y_test <- read.table(fpath, header = FALSE)

fpath = file.path(getwd(), "UCI HAR Dataset/test/subject_test.txt")
subject_test <- read.table(fpath, header = FALSE)

fpath = file.path(getwd(), "UCI HAR Dataset/train/X_train.txt")
X_train <- read.table(fpath, header = FALSE)

fpath = file.path(getwd(), "UCI HAR Dataset/train/Y_train.txt")
Y_train <- read.table(fpath, header = FALSE)

fpath = file.path(getwd(), "UCI HAR Dataset/train/subject_train.txt")
subject_train <- read.table(fpath, header = FALSE)

fpath = file.path(getwd(), "UCI HAR Dataset/activity_labels.txt")
activity_labels <- read.table(fpath, header = FALSE)

fpath = file.path(getwd(), "UCI HAR Dataset/features.txt")
features <- read.table(fpath, header = FALSE)

# - Merging data sets ----------------------------------------------------------------------

library(plyr)
library(dplyr)

features <- rename(features, ID = V1, Measure=V2) # Assigning names to columns of data frames
subject_test <- rename(subject_test, Subject=V1)
subject_train <- rename(subject_train, Subject=V1)
Y_test <- rename(Y_test, Activity=V1)
Y_train <- rename(Y_train, Activity=V1)
activity_labels <- rename(activity_labels, Activity=V1)
activity_labels <- rename(activity_labels, ActivityName=V2)

measures<-as.array(features$Measure)# Assigning measurements to columns of train and test data
colnames(X_test) <- measures
colnames(X_train) <- measures

test<-cbind(subject_test,Y_test)    # Assembling subject+activity+measurement for test data (left to right)
           
test <- join(test, activity_labels, by = "Activity") # Changing values of Activity column to English words
test <- select(test, -Activity)

test<-cbind(test,X_test) 

train<-cbind(subject_train,Y_train) # Assembling subject+activity+measurement for train data (left to right)

train <- join(train, activity_labels, by = "Activity") # Changing values of Activity column to English words
train <- select(train, -Activity)

train<-cbind(train,X_train)

data<-rbind(train,test)             # Appending test data to train data

# - Selecting columns containing "-mean()" or "-st()" in their names -----------------------

subsetData<- data[,grep("Subject|Activity|-mean()|-std()", colnames(data))] 

# - Removing old, big data to free up memory -----------------------------------------------
rm(X_test)
rm(X_train)

# -Building a tidy table with the mean of all variables for all the combinations of Subject and ActivityName

subsetData$Subject <- as.character(subsetData$Subject)
subsetData <- group_by(subsetData, Subject, ActivityName)

tidy <- group_by(subsetData, Subject, ActivityName) %>% summarise_each(funs(mean)) 

tidy$Subject <- as.numeric(tidy$Subject)
tidy <- arrange(tidy, desc(Subject), ActivityName)

write.table(tidy, file = "tidy_wearable_data.txt", sep = "\t", row.names = FALSE, col.names = TRUE)

#----------------------------- End ----------------------------------------------------------